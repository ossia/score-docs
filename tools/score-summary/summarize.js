// Run inside ossia score through `--script`, on the document loaded from the
// command line. Writes a markdown summary of the document to $SCORE_SUMMARY_OUT.
//
// Process / protocol keys are emitted as `@@SRC:<uuid>@@` markers which
// summarize.sh replaces with the repository files declaring them.
//
// Environment:
//   SCORE_SUMMARY_OUT   output file (required)
//   SCORE_SUMMARY_SRC   path of the .score shown in the header
//   SCORE_SUMMARY_ERR   file receiving an error message if the script throws

function summarize() {
  const OUT = Util.environmentVariable("SCORE_SUMMARY_OUT");
  const SRC = Util.environmentVariable("SCORE_SUMMARY_SRC");
  const ERR = Util.environmentVariable("SCORE_SUMMARY_ERR");

  const FLICKS = 705600000;
  const TEXTBOX_KEY = "7be51631-fb4b-4152-9ca7-86fdafa8a989";
  const DEVICE_PLUGIN = "6e610e1f-9de2-4c36-90dd-0ef570002a21";
  const META_PLUGIN = "aac1402f-6851-4a1a-ab50-5f213acd1262";
  const CODE_FULL_LINES = 40; // inline code up to this many lines
  const CODE_HEAD_LINES = 20; // otherwise show this many

  const PORT_KIND = {
    "a1574bb0-cbd4-4c7d-9417-0c25cfd1187b": "audio",
    "a1d97535-18ac-444a-8417-0cbc1692d897": "audio",
    "c18adc77-e0e0-4ddf-a46c-43cb0719a890": "midi",
    "d8a3ed3d-b9c2-46f2-bdb3-d282a48481c6": "midi",
    "5ac86198-2d03-4830-9e41-a6d529922d29": "texture",
    "f1c71046-b754-49a5-8e66-d01374773dfc": "texture",
    "f2ab26ea-415d-45a2-bfbc-2968c7c92a33": "geometry",
    "848061c5-e8a0-4a13-9985-e8df30ce6d4f": "geometry",
  };
  const CABLE_TYPE = ["", "strict", "delayed", "delayed+strict"];

  // Keys of a process object which are common to every process, or handled
  // separately; anything else is process-specific data worth showing.
  const STD_KEYS = new Set([
    "uuid", "ObjectName", "id", "Metadata", "Duration", "Height", "StartOffset",
    "LoopDuration", "Pos", "Size", "Loops", "FoldMode", "Inlets", "Outlets",
    "Inlet", "Outlet", "TimeNodes", "Events", "States", "Constraints", "Comments",
    "StartTimeNodeId", "StartEventId", "StartStateId", "Exclusive",
    "DynamicInlets", "DynamicOutlets",
  ]);
  // Children of a process holding other model objects, not its own ports.
  const NO_PORT_DESCENT = new Set([
    "Metadata", "TimeNodes", "Events", "States", "Constraints", "Comments",
    "Curve", "Processes",
  ]);

  // ---------------------------------------------------------------- helpers
  function utf8(buf) {
    const b = new Uint8Array(buf);
    const parts = [];
    let cps = [];
    for (let i = 0; i < b.length;) {
      const c = b[i];
      let cp;
      if (c < 0x80) { cp = c; i += 1; }
      else if (c < 0xe0) { cp = ((c & 0x1f) << 6) | (b[i + 1] & 0x3f); i += 2; }
      else if (c < 0xf0) { cp = ((c & 0x0f) << 12) | ((b[i + 1] & 0x3f) << 6) | (b[i + 2] & 0x3f); i += 3; }
      else {
        cp = ((c & 0x07) << 18) | ((b[i + 1] & 0x3f) << 12) | ((b[i + 2] & 0x3f) << 6) | (b[i + 3] & 0x3f);
        i += 4;
        cp -= 0x10000;
        cps.push(0xd800 + (cp >> 10));
        cp = 0xdc00 + (cp & 0x3ff);
      }
      cps.push(cp);
      if (cps.length > 8000) { parts.push(String.fromCharCode.apply(null, cps)); cps = []; }
    }
    parts.push(String.fromCharCode.apply(null, cps));
    return parts.join("");
  }

  function num(x) {
    if (typeof x !== "number") return String(x);
    if (Number.isInteger(x)) return String(x);
    const a = Math.abs(x);
    if (a !== 0 && (a < 0.001 || a >= 1e6)) return x.toPrecision(3);
    return String(Math.round(x * 1000) / 1000);
  }
  function secs(flicks) {
    if (flicks === undefined || flicks === null) return "?";
    const s = flicks / FLICKS;
    return num(Math.round(s * 100) / 100) + "s";
  }
  function oneLine(s, max) {
    s = String(s).replace(/\s+/g, " ").trim();
    if (max && s.length > max) s = s.substr(0, max - 1) + "…";
    return s;
  }
  function q(s) { return "\"" + oneLine(s, 200) + "\""; }

  // ossia::value as saved: {"Float": 0.5}, {"Vec2f": [..]}, {"List": [...]}, {}
  function fmtValue(v, max) {
    max = max || 80;
    if (v === null || v === undefined) return "";
    if (typeof v !== "object") return oneLine(String(v), max);
    const k = Object.keys(v);
    if (k.length === 0) return "";
    const t = k[0], x = v[t];
    let s;
    switch (t) {
      case "Float": case "Int": s = num(x); break;
      case "Bool": s = String(x); break;
      case "Char": s = "'" + x + "'"; break;
      case "String": s = JSON.stringify(x); break;
      case "Impulse": s = "impulse"; break;
      case "Vec2f": case "Vec3f": case "Vec4f": s = "[" + x.map(num).join(", ") + "]"; break;
      case "List": case "Tuple": s = "[" + x.map(e => fmtValue(e, max)).join(", ") + "]"; break;
      case "Map": s = JSON.stringify(x); break;
      default: s = JSON.stringify(v);
    }
    return oneLine(s, max);
  }
  function valueEq(a, b) { return JSON.stringify(a || {}) === JSON.stringify(b || {}); }

  function htmlToText(html) {
    let s = String(html);
    const body = s.match(/<body[^>]*>([\s\S]*)<\/body>/i);
    if (body) s = body[1];
    s = s.replace(/<br\s*\/?>/gi, "\n").replace(/<\/(p|div|li|h\d)>/gi, "\n").replace(/<[^>]+>/g, "");
    s = s.replace(/&nbsp;/g, " ").replace(/&lt;/g, "<").replace(/&gt;/g, ">")
         .replace(/&quot;/g, "\"").replace(/&#39;/g, "'").replace(/&amp;/g, "&");
    return s.split("\n").map(l => l.trim()).filter(l => l.length).join(" / ");
  }

  function looksLikePath(s) {
    return typeof s === "string" && s.length < 400 && s.indexOf("\n") < 0
        && (/^<(LIBRARY|PROJECT)>:/.test(s) || /^(\/|~|[A-Za-z]:[\\/]|\.\.?\/)/.test(s)
            || /\.[A-Za-z0-9]{1,6}$/.test(s));
  }
  function isCode(s) { return typeof s === "string" && (s.indexOf("\n") >= 0 || s.length > 160); }
  function isBlob(s) { return typeof s === "string" && s.length > 160 && s.indexOf("\n") < 0 && s.indexOf(" ") < 0; }

  // ------------------------------------------------------------- the model
  // A file score failed to load leaves an empty "Untitled" document instead
  const docName = Score.documentName();
  if (SRC) {
    const expected = SRC.replace(/^.*[\/]/, "").replace(/\.score$/, "");
    if (!docName || !(expected.indexOf(docName) === 0 || docName.indexOf(expected) === 0))
      throw new Error("the open document is \"" + docName + "\", not " + expected + ": the file did not load");
  }
  const json = JSON.parse(utf8(Score.serializeAsJson()));
  const procInfo = Score.availableProcesses() || {};
  const protoInfo = Score.availableProtocols() || {};
  function procName(key) { const p = procInfo[key]; return p ? p.Name : null; }

  const processes = [];          // in traversal order
  const procByPath = {};         // "Obj:id/Obj:id/..." -> process record
  const usedTypes = {};          // key -> {count, objectName}
  const comments = [];           // {where, text}
  const textBoxes = [];
  const codeBlocks = [];         // {label, lang, text}
  const bindings = [];           // {addr, where, dir}
  let commentBlockCount = 0;

  // Ports with a cable, as "<process path>/Inlet:<id>"
  const cabledPorts = new Set();
  for (const c of json.Document.Cables || [])
    for (const end of [c.Source, c.Sink])
      cabledPorts.add(end.map(s => s.ObjectName + ":" + s.ObjectId).join("/"));

  function addBinding(addr, where, dir) { if (addr) bindings.push({ addr: addr, where: where, dir: dir }); }

  function metaComment(meta, where) {
    if (meta && meta.Comment && String(meta.Comment).trim().length)
      comments.push({ where: where, text: oneLine(meta.Comment, 600) });
  }

  // Collect the ports of a process (or interval), including nested ones such as
  // the gain/pan inlets of an audio outlet or an automation's min/max.
  // Ports found inside another port are flagged `nested`.
  const nestedPorts = new Set();
  function collectPorts(obj) {
    const ports = [];
    const seen = new Set();
    function rec(o, depth, inPort) {
      if (!o || typeof o !== "object" || depth > 4) return;
      if (Array.isArray(o)) { o.forEach(e => rec(e, depth + 1, inPort)); return; }
      const isPort = (o.ObjectName === "Inlet" || o.ObjectName === "Outlet") && depth > 0;
      if (isPort) {
        const k = o.ObjectName + ":" + o.id;
        if (!seen.has(k)) { seen.add(k); ports.push(o); if (inPort) nestedPorts.add(o); }
      }
      for (const key in o) {
        if (NO_PORT_DESCENT.has(key)) continue;
        const v = o[key];
        if (v && typeof v === "object") rec(v, depth + 1, inPort || isPort);
      }
    }
    rec(obj, 0, false);
    return ports;
  }
  // A port's address: a string, or {Address, Target} when anchored to an object
  function addrOf(pt) { const a = pt.Address; return typeof a === "string" ? a : (a && a.Address) || ""; }
  function portName(p) { return p.Custom || p.Exposed || (p.ObjectName === "Inlet" ? "in" : "out") + p.id; }
  function portKind(p) { return PORT_KIND[p.uuid] || "value"; }

  function interestingProps(o) {
    const out = [];
    for (const k in o) {
      if (STD_KEYS.has(k)) continue;
      const v = o[k];
      if (v && typeof v === "object" && (v.ObjectName === "Inlet" || v.ObjectName === "Outlet")) continue;
      out.push([k, v]);
    }
    return out;
  }

  // Registers a piece of code; identical code is only printed once.
  const codeSeen = {};
  function addCode(label, lang, text, file) {
    text = String(text).replace(/\s+$/, "");
    if (codeSeen[text]) return "same code as " + codeSeen[text];
    codeSeen[text] = label;
    codeBlocks.push({ label: label, lang: lang, text: text, file: file || "" });
    return "code, " + text.split("\n").length + " lines (see Code)";
  }
  function renderCode(c, full, head) {
    let text = c.text;
    let header = "";
    // ISF / CSF JSON header: summarized, then left out of the listing
    const m = text.match(/\/\*\s*(\{[\s\S]*?\})\s*\*\/\s*/);
    if (m) {
      try {
        const h = JSON.parse(m[1]);
        const bits = [];
        if (h.DESCRIPTION) bits.push("description: " + oneLine(h.DESCRIPTION, 400));
        if (h.CATEGORIES) bits.push("categories: " + [].concat(h.CATEGORIES).join(", "));
        if (h.INPUTS) bits.push("inputs: " + h.INPUTS.map(i => i.NAME + ":" + i.TYPE + (i.DEFAULT !== undefined ? "=" + JSON.stringify(i.DEFAULT) : "")).join(", "));
        if (h.OUTPUTS) bits.push("outputs: " + h.OUTPUTS.map(i => i.NAME + ":" + i.TYPE).join(", "));
        if (h.PASSES && h.PASSES.length > 1) bits.push("passes: " + h.PASSES.length);
        if (h.RESOURCES) bits.push("resources: " + h.RESOURCES.map(i => i.NAME + ":" + i.TYPE).join(", "));
        header = bits.join("; ");
        text = (text.substr(0, m.index) + text.substr(m.index + m[0].length)).replace(/^\s+/, "");
      } catch (e) {}
    }
    const lines = text.split("\n");
    const fromLib = c.file && lines.length > 20;
    const shown = fromLib ? [] : lines.length <= full ? lines : lines.slice(0, head);
    let s = "### " + c.label + "\n\n" + (header ? header + "\n\n" : "");
    if (fromLib) s += lines.length + " lines, not listed: the process was created from the library file `" + c.file + "`.\n";
    if (shown.length && shown.join("").trim().length) {
      s += "```" + c.lang + "\n" + shown.join("\n") + "\n";
      if (shown.length < lines.length) s += "// … " + (lines.length - shown.length) + " more lines\n";
      s += "```\n";
    }
    return s;
  }
  function codeLang(objName) {
    if (objName === "Javascript") return "qml";
    if (objName === "Faust") return "faust";
    if (objName === "gfxProcess" || objName === "CSF") return "glsl";
    if (objName === "Jit") return "cpp";
    if (objName === "PureData") return "";
    return "";
  }

  function describeProps(p, label) {
    const res = [];
    // Code loaded from a file of the library: the file is the reference
    let libFile = "";
    for (const [k, v] of interestingProps(p))
      if (typeof v === "string" && /^<LIBRARY>:.*\.[A-Za-z0-9]{1,5}$/.test(v)) libFile = v;
    for (const [k, v] of interestingProps(p)) {
      if (k === "Curve" && v && v.Segments) {
        const segs = v.Segments;
        let ys = [];
        segs.forEach(sg => { ys.push(sg.Start[1]); ys.push(sg.End[1]); });
        let s = "curve " + segs.length + " segment(s)";
        if (segs.length <= 6) {
          const pts = [segs[0].Start].concat(segs.map(sg => sg.End));
          s += ": " + pts.map(pt => "(" + num(pt[0]) + "," + num(pt[1]) + ")").join(" ");
        } else {
          s += ", y in [" + num(Math.min.apply(null, ys)) + ", " + num(Math.max.apply(null, ys)) + "]";
        }
        res.push(s);
      } else if (k === "Notes" && Array.isArray(v)) {
        const pitches = v.map(n => n.Note ? n.Note[2] : 0);
        res.push(v.length + " MIDI notes" + (v.length ? " (pitch " + Math.min.apply(null, pitches) + "–" + Math.max.apply(null, pitches) + ")" : ""));
      } else if (k === "Patterns" && Array.isArray(v)) {
        res.push(v.length + " pattern(s): " + oneLine(v.map(pt => (pt.Lanes || []).map(l => l.Note + ":" + l.Pattern).join(" ")).join(" | "), 300));
      } else if (typeof v === "string") {
        if (v.length === 0) continue;
        if (isBlob(v)) res.push(k + ": <" + v.length + " bytes of data>");
        else if (isCode(v)) res.push(k + ": " + addCode(label + " · " + k, codeLang(p.ObjectName), v, libFile));
        else res.push(k + ": " + JSON.stringify(v));
      } else if (Array.isArray(v)) {
        const s = JSON.stringify(v);
        res.push(k + ": " + (s.length <= 120 ? s : v.length + " items"));
      } else if (v && typeof v === "object") {
        const s = JSON.stringify(v);
        res.push(k + ": " + (s.length <= 120 ? s : "{…}"));
      } else if (v !== null && v !== undefined) {
        res.push(k + ": " + (typeof v === "number" ? num(v) : String(v)));
      }
    }
    return res;
  }

  const MAX_CONTROLS = 16;

  // Returns lines (already indented) describing a process.
  function walkProcess(p, path, indent, parentLabel, parentDur) {
    const rec = { n: processes.length + 1, obj: p, path: path, ports: collectPorts(p) };
    processes.push(rec);
    procByPath[path] = rec;
    const key = p.uuid;
    const typeName = procName(key) || p.ObjectName;
    rec.typeName = typeName;
    rec.name = (p.Metadata && p.Metadata.ScriptingName) || typeName;
    rec.label = "P" + rec.n + " " + (rec.name === typeName ? typeName : q(rec.name) + " (" + typeName + ")");
    rec.short = "P" + rec.n + " " + (rec.name === typeName ? typeName : q(rec.name));
    if (!usedTypes[key]) usedTypes[key] = { count: 0, objectName: p.ObjectName };
    usedTypes[key].count++;

    const pad = "  ".repeat(indent);
    const lines = [];
    let lb = labelOf(p.Metadata);
    if (lb === rec.name) lb = "";
    let head = pad + "- **P" + rec.n + "** " + (rec.name === typeName ? typeName : q(rec.name) + " — " + typeName) + (lb ? " label " + q(lb) : "");
    const extra = [];
    if (p.Duration !== undefined && parentDur !== undefined && p.Duration !== parentDur) extra.push("dur " + secs(p.Duration));
    if (p.StartOffset) extra.push("offset " + secs(p.StartOffset));
    if (p.Loops) extra.push("loops every " + secs(p.LoopDuration));
    if (extra.length) head += " [" + extra.join(", ") + "]";
    lines.push(head);
    metaComment(p.Metadata, rec.label);

    if (key === TEXTBOX_KEY) {
      const inl = rec.ports.find(pt => pt.ObjectName === "Inlet" && pt.Value && pt.Value.String !== undefined);
      let txt = inl ? inl.Value.String : "";
      if (/^\s*<(!DOCTYPE|html)/i.test(txt)) txt = htmlToText(txt);
      textBoxes.push({ where: parentLabel, n: rec.n, text: txt });
      lines.push(pad + "  - text: \"" + oneLine(txt, 3000) + "\"");
      return { rec: rec, lines: lines };
    }

    // Ports. A port is listed unless it is a nested gain/pan or a scenario's
    // default audio port with nothing attached.
    const isScenario = !!(p.Constraints && p.TimeNodes);
    const ins = [], outs = [];
    const controls = rec.ports.filter(pt => pt.ObjectName === "Inlet" && pt.Value !== undefined && !nestedPorts.has(pt));
    const changedOnly = controls.length > 8;
    let atDefault = 0, overflow = 0;
    for (const pt of rec.ports) {
      const nm = portName(pt);
      const cabled = cabledPorts.has(path + "/" + pt.ObjectName + ":" + pt.id);
      if ((nestedPorts.has(pt) || isScenario) && !addrOf(pt) && !cabled) continue;
      let s = nm;
      const kind = portKind(pt);
      if (pt.ObjectName === "Inlet") {
        if (pt.Value !== undefined) {
          if (changedOnly && valueEq(pt.Value, pt.Init) && !addrOf(pt) && !cabled) { atDefault++; continue; }
          if (ins.length >= MAX_CONTROLS && !addrOf(pt) && !cabled) { overflow++; continue; }
          const str = pt.Value && pt.Value.String;
          if (typeof str === "string" && isCode(str)) s += ": " + addCode(rec.label + " · " + nm, codeLang(p.ObjectName), str);
          else { const val = fmtValue(pt.Value); if (val !== "") s += "=" + val; }
        } else if (kind !== "value") s += " (" + kind + ")";
        if (addrOf(pt)) { s += " ← `" + addrOf(pt) + "`"; addBinding(addrOf(pt), rec.short + "." + nm, "in"); }
        ins.push(s);
      } else {
        if (kind !== "value") s += " (" + kind + ")";
        if (addrOf(pt)) { s += " → `" + addrOf(pt) + "`"; addBinding(addrOf(pt), rec.short + "." + nm, "out"); }
        if (kind === "audio" && pt.Propagate && !cabled) s += " (to parent mix)";
        outs.push(s);
      }
    }
    const more = [];
    if (overflow) more.push(overflow + " more set");
    if (atDefault) more.push(atDefault + " at default");
    if (ins.length || more.length) lines.push(pad + "  - in: " + ins.join(" · ") + (more.length ? (ins.length ? " · " : "") + "(" + more.join(", ") + ")" : ""));
    if (outs.length) lines.push(pad + "  - out: " + outs.join(" · "));
    if (p.DynamicInlets || p.DynamicOutlets) {
      const d = [].concat(p.DynamicInlets || [], p.DynamicOutlets || []).map(x => x[0] + "×" + x[1]);
      lines.push(pad + "  - dynamic ports: " + d.join(", "));
    }
    const props = describeProps(p, rec.label);
    if (props.length) lines.push(pad + "  - " + props.join("; "));

    if (isScenario) walkScenario(p, path, indent + 1, rec).forEach(l => lines.push(l));
    return { rec: rec, lines: lines };
  }

  function stateMessages(state) {
    const out = [];
    function rec(node, prefix) {
      const name = node.Name || "";
      const here = prefix === null ? "" : (prefix === "" ? name + ":" : prefix + "/" + name);
      if (node.User !== null && node.User !== undefined && prefix !== null)
        out.push(here + " = " + fmtValue(node.User, 60));
      (node.Children || []).forEach(c => rec(c, prefix === null ? "" : here));
    }
    if (state && state.Messages) rec(state.Messages, null);
    return out;
  }

  // "dev:/a/x = 1", "dev:/a/y = 2" -> "dev:/a/{x = 1, y = 2}"
  function groupMessages(msgs) {
    const groups = [], byPrefix = {};
    for (const m of msgs) {
      const eq = m.indexOf(" = ");
      const addr = eq >= 0 ? m.substr(0, eq) : m;
      const slash = addr.lastIndexOf("/");
      const prefix = slash > 0 && eq >= 0 ? addr.substr(0, slash + 1) : "";
      const key = prefix || ("\u0000" + groups.length);
      if (!byPrefix[key]) { byPrefix[key] = { prefix: prefix, items: [] }; groups.push(byPrefix[key]); }
      byPrefix[key].items.push(prefix ? m.substr(prefix.length) : m);
    }
    const out = groups.map(g => g.items.length > 1 ? g.prefix + "{" + g.items.slice(0, 16).join(", ") + (g.items.length > 16 ? ", +" + (g.items.length - 16) : "") + "}" : g.prefix + g.items[0]);
    return out.join("; ");
  }

  function labelOf(meta) { return meta && meta.Label && String(meta.Label).trim() ? oneLine(meta.Label, 200) : ""; }

  // ctx: { start, end } sync labels when the interval lives in a scenario
  function walkInterval(itv, path, indent, ctx) {
    const pad = "  ".repeat(indent);
    const lines = [];
    const name = (itv.Metadata && itv.Metadata.ScriptingName) || "Interval";
    let label = labelOf(itv.Metadata);
    if (label === name) label = "";
    const itvLabel = "interval " + q(name);
    const bits = [];
    if (ctx) bits.push(ctx.start + " → " + ctx.end);
    bits.push("dur " + secs(itv.DefaultDuration));
    const flex = [];
    if (itv.MinNull) flex.push("min 0"); else if (itv.MinDuration !== itv.DefaultDuration) flex.push("min " + secs(itv.MinDuration));
    if (itv.MaxInf) flex.push("max ∞"); else if (itv.MaxDuration !== itv.DefaultDuration) flex.push("max " + secs(itv.MaxDuration));
    if (flex.length && !itv.Rigidity) bits.push(flex.join(", "));
    if (itv.Speed !== undefined && itv.Speed !== 1) bits.push("speed " + num(itv.Speed));
    if (itv.ViewMode === 1) bits.push("nodal view");
    lines.push(pad + "- **Interval " + q(name) + "**" + (label ? " label " + q(label) : "") + " [" + bits.join(", ") + "]");
    metaComment(itv.Metadata, itvLabel);

    // The interval's own audio ports
    for (const pt of collectPorts({ Inlet: itv.Inlet, Outlet: itv.Outlet })) {
      if (!addrOf(pt)) continue;
      const dir = pt.ObjectName === "Inlet" ? "in" : "out";
      lines.push(pad + "  - audio " + dir + (dir === "in" ? " ← " : " → ") + "`" + addrOf(pt) + "`");
      if (addrOf(pt) !== "audio:/out/main") addBinding(addrOf(pt), itvLabel + "." + portName(pt), dir);
    }

    const procs = (itv.Processes || []).slice().sort((a, b) => a.id - b.id);
    for (const p of procs) {
      const r = walkProcess(p, path + "/" + p.ObjectName + ":" + p.id, indent + 1, itvLabel, itv.DefaultDuration);
      r.lines.forEach(l => lines.push(l));
    }
    return lines;
  }

  function walkScenario(sc, path, indent, procRec) {
    const pad = "  ".repeat(indent);
    const lines = [];
    const states = {}, events = {}, syncs = {};
    (sc.States || []).forEach(s => states[s.id] = s);
    (sc.Events || []).forEach(e => events[e.id] = e);
    (sc.TimeNodes || []).forEach(t => syncs[t.id] = t);
    const where = procRec ? procRec.short : "scenario";

    // Number syncs by date so that T1 < T2 < ... reads chronologically
    const syncList = (sc.TimeNodes || []).slice().sort((a, b) => (a.Date - b.Date) || (a.id - b.id));
    const syncName = {};
    syncList.forEach((t, i) => syncName[t.id] = "T" + i);
    function syncOfState(sid) {
      const st = states[sid]; if (!st) return undefined;
      const ev = events[st.Event]; return ev ? syncs[ev.TimeNode] : undefined;
    }
    function syncTag(t) { return t ? syncName[t.id] + "@" + secs(t.Date) : "?"; }

    const itvs = (sc.Constraints || []).slice();
    const itvName = {};
    const startsAt = {}, endsAt = {};
    for (const itv of itvs) {
      const nm = q((itv.Metadata && itv.Metadata.ScriptingName) || "Interval");
      const lb = labelOf(itv.Metadata);
      itvName[itv.id] = lb ? nm + " (" + lb + ")" : nm;
    }
    itvs.sort((a, b) => {
      const sa = syncOfState(a.StartState), sb = syncOfState(b.StartState);
      return ((sa ? sa.Date : 0) - (sb ? sb.Date : 0)) || (a.id - b.id);
    });
    for (const itv of itvs) {
      const s = syncOfState(itv.StartState), e = syncOfState(itv.EndState);
      walkInterval(itv, path + "/Scenario::IntervalModel:" + itv.id, indent,
                   { start: syncTag(s), end: syncTag(e) }).forEach(l => lines.push(l));
    }
    // which intervals start / end on each event
    for (const itv of itvs) {
      const ss = states[itv.StartState], es = states[itv.EndState];
      if (ss) (startsAt[ss.Event] = startsAt[ss.Event] || []).push(itvName[itv.id]);
      if (es) (endsAt[es.Event] = endsAt[es.Event] || []).push(itvName[itv.id]);
    }

    // Time syncs: the graph joints, with triggers, conditions and state messages
    const syncLines = [];
    for (const t of syncList) {
      const parts = [];
      const lb = labelOf(t.Metadata);
      if (lb) parts.push("label " + q(lb));
      metaComment(t.Metadata, "sync " + syncName[t.id] + " in " + where);
      if (t.Active) {
        const e = String(t.Expression || "").trim();
        parts.push("trigger " + (e && e !== "{ true == false }" ? "`" + e + "`" : "(manual / interaction)") + (t.AutoTrigger ? ", auto-retrigger" : ""));
      }
      if (t.MusicalSync !== undefined && t.MusicalSync > 0) parts.push("quantized " + num(t.MusicalSync));
      const evs = (t.Events || []).map(id => events[id]).filter(e => e);
      const evParts = [];
      let branching = evs.length > 1;
      for (const ev of evs) {
        metaComment(ev.Metadata, "event in " + where);
        const c = String(ev.Condition || "").trim();
        const ins = endsAt[ev.id] || [], outs = startsAt[ev.id] || [];
        const msgs = [];
        for (const sid of ev.States || []) {
          const st = states[sid]; if (!st) continue;
          metaComment(st.Metadata, "state in " + where);
          stateMessages(st).forEach(m => { msgs.push(m); addBinding(m.split(" = ")[0], "state at " + syncTag(t) + " in " + where, "msg"); });
          for (const sp of st.StateProcesses || []) {
            msgs.push("state process " + (procName(sp.uuid) || sp.ObjectName));
            if (!usedTypes[sp.uuid]) usedTypes[sp.uuid] = { count: 0, objectName: sp.ObjectName };
            usedTypes[sp.uuid].count++;
          }
        }
        let s = "";
        if (c && c !== "{ true == true }") s += "if `" + c + "` ";
        if (ins.length) s += "ends " + ins.join(", ") + " ";
        if (outs.length) s += (ins.length ? "→ " : "") + "starts " + outs.join(", ") + " ";
        if (msgs.length) s += (s ? "; " : "") + "sends " + groupMessages(msgs);
        s = s.trim();
        if (s) evParts.push(s);
      }
      const isStart = t.id === sc.StartTimeNodeId;
      if (evParts.length) parts.push(branching ? evParts.map((s, i) => "[event " + (i + 1) + "] " + s).join(" ") : evParts[0]);
      if (!parts.length) continue;
      syncLines.push(pad + "- " + syncName[t.id] + " @" + secs(t.Date) + (isStart ? " (start)" : "") + ": " + parts.join("; "));
    }
    if (syncLines.length) {
      lines.push(pad + "- time syncs:");
      syncLines.forEach(l => lines.push("  " + l));
    }

    const cmts = (sc.Comments || []).slice().sort((a, b) => a.Date - b.Date);
    if (cmts.length) {
      lines.push(pad + "- comment blocks:");
      for (const c of cmts)
        lines.push(pad + "  - @" + secs(c.Date) + ", " + Math.round((c.HeightPercentage || 0) * 100) + "% down: \"" + oneLine(htmlToText(c.HTMLContent || ""), 2000) + "\"");
      commentBlockCount += cmts.length;
    }
    return lines;
  }
  // ------------------------------------------------------------- traversal
  const doc = json.Document;
  const base = doc.BaseScenario;
  const rootItv = base.Constraint;
  const rootPath = doc.ObjectName + ":" + doc.id + "/" + base.ObjectName + ":" + base.id + "/" + rootItv.ObjectName + ":" + rootItv.id;
  const structure = walkInterval(rootItv, rootPath, 0, undefined);

  // ------------------------------------------------------------- cables
  function resolveEnd(segs) {
    const parts = segs.map(s => s.ObjectName + ":" + s.ObjectId);
    const portSeg = segs[segs.length - 1];
    const procPath = parts.slice(0, -1).join("/");
    const rec = procByPath[procPath];
    if (!rec) return { text: parts.slice(-2).join("/") + " (unresolved)" };
    const pt = rec.ports.find(p => p.ObjectName === portSeg.ObjectName && p.id === portSeg.ObjectId);
    return { rec: rec, port: pt, text: rec.short + "." + (pt ? portName(pt) : portSeg.ObjectName + portSeg.ObjectId) };
  }
  const cables = (doc.Cables || []).map(c => {
    const a = resolveEnd(c.Source), b = resolveEnd(c.Sink);
    const kind = a.port ? portKind(a.port) : (b.port ? portKind(b.port) : "?");
    let t = kind;
    if (CABLE_TYPE[c.Type]) t += ", " + CABLE_TYPE[c.Type];
    return { s: a, d: b, text: a.text + " → " + b.text + " (" + t + ")" };
  });
  cables.sort((x, y) => ((x.s.rec ? x.s.rec.n : 0) - (y.s.rec ? y.s.rec.n : 0)) || ((x.d.rec ? x.d.rec.n : 0) - (y.d.rec ? y.d.rec.n : 0)));

  // ------------------------------------------------------------- devices
  const devices = [];
  const plugins = json.Plugins || [];
  const devPlugin = plugins.find(p => p.uuid === DEVICE_PLUGIN);
  const metaPlugin = plugins.find(p => p.uuid === META_PLUGIN);

  function flatten(o, prefix, out) {
    for (const k in o) {
      const v = o[k];
      const key = prefix ? prefix + "." + k : k;
      if (v && typeof v === "object" && !Array.isArray(v)) flatten(v, key, out);
      else out.push([key, v]);
    }
    return out;
  }
  function addrTree(node, prefix, out) {
    for (const c of node.Children || []) {
      const a = c.Address || {};
      const p = prefix + "/" + (a.Name || "?");
      const val = a.Value ? Object.keys(a.Value)[0] : "";
      if (!c.Children || !c.Children.length) out.push(p + (val ? " (" + val.toLowerCase() + (a.ioType ? ", " + a.ioType : "") + ")" : ""));
      addrTree(c, p, out);
    }
    return out;
  }
  if (devPlugin) {
    for (const d of devPlugin.Children || []) {
      const dev = d.Device || {};
      const pi = protoInfo[dev.Protocol] || protoInfo[String(dev.Protocol).toLowerCase()];
      const settings = [];
      const devCopy = Object.assign({}, dev);
      delete devCopy.Name; delete devCopy.Protocol;
      for (const [k, v] of flatten(devCopy, "", [])) {
        if (typeof v === "string" && isCode(v)) {
          settings.push(k + ": " + addCode("device " + dev.Name + " · " + k, "qml", v));
        } else {
          const s = typeof v === "string" ? v : JSON.stringify(v);
          if (s === "" || s === "[]" || s === "{}") continue;
          settings.push(k + "=" + oneLine(s, 120));
        }
      }
      devices.push({
        name: dev.Name, protocol: pi ? pi.Name : dev.Protocol, key: dev.Protocol,
        settings: settings, addrs: addrTree(d, dev.Name + ":", []),
      });
    }
  }

  // ------------------------------------------------------------- output
  const L = [];
  L.push("# " + docName + " — score summary");
  L.push("");
  L.push("<!-- generated by score-docs/tools/score-summary from the document as loaded in ossia score; do not edit -->");
  if (SRC) L.push("- File: `" + SRC + "`");
  if (metaPlugin) {
    if (metaPlugin.Name && metaPlugin.Name !== docName) L.push("- Title: " + metaPlugin.Name);
    if (metaPlugin.Description) L.push("- Description: " + oneLine(metaPlugin.Description, 1500));
    if (metaPlugin.Url) L.push("- Doc URL: " + metaPlugin.Url);
    if (metaPlugin.Author) L.push("- Author: " + metaPlugin.Author);
  }
  if (json.Tag) L.push("- Saved with score " + json.Tag);
  L.push("- Root interval duration: " + secs(rootItv.DefaultDuration) + "; " + processes.length + " processes, "
         + Object.keys(usedTypes).length + " process types, " + cables.length + " cables, " + devices.length + " devices, "
         + commentBlockCount + " comment blocks, " + textBoxes.length + " text boxes");
  L.push("- Times are in seconds from the start of the parent interval; P<n> numbers processes in document order; source paths are relative to the ossia score repository.");
  L.push("");

  L.push("## Process types");
  L.push("");
  L.push("| Type | Category | Uses | Key | Source | Description |");
  L.push("|---|---|---|---|---|---|");
  const typeKeys = Object.keys(usedTypes).sort((a, b) => usedTypes[b].count - usedTypes[a].count || String(procName(a)).localeCompare(String(procName(b))));
  for (const k of typeKeys) {
    const pi = procInfo[k] || {};
    L.push("| " + (pi.Name || usedTypes[k].objectName) + " | " + (pi.Category || "") + " | " + usedTypes[k].count
           + " | `" + k + "` | @@SRC:" + k + "@@ | " + oneLine(pi.Description || "", 140).replace(/\|/g, "\\|") + " |");
  }
  L.push("");

  L.push("## Structure");
  L.push("");
  structure.forEach(l => L.push(l));
  L.push("");

  L.push("## Cables");
  L.push("");
  if (!cables.length) L.push("(none)");
  cables.forEach(c => L.push("- " + c.text));
  L.push("");

  if (comments.length) {
    L.push("## Object comments");
    L.push("");
    comments.forEach(c => L.push("- " + c.where + ": " + q(c.text)));
    L.push("");
  }

  L.push("## Devices");
  L.push("");
  if (!devices.length) L.push("(none)");
  for (const d of devices) {
    L.push("- **" + d.name + "** — " + d.protocol + " (`" + d.key + "`, @@SRC:" + d.key + "@@)");
    if (d.settings.length) L.push("  - settings: " + d.settings.slice(0, 30).join(", ") + (d.settings.length > 30 ? ", …" : ""));
    if (d.addrs.length) {
      if (d.addrs.length <= 12) L.push("  - addresses: " + d.addrs.map(a => "`" + a + "`").join(", "));
      else L.push("  - " + d.addrs.length + " addresses (e.g. " + d.addrs.slice(0, 6).map(a => "`" + a + "`").join(", ") + ", …)");
    }
  }
  L.push("");

  if (bindings.length) {
    L.push("## Address bindings");
    L.push("");
    const byAddr = {};
    bindings.forEach(b => { (byAddr[b.addr] = byAddr[b.addr] || []).push((b.dir === "in" ? "read by " : b.dir === "out" ? "written by " : "sent by ") + b.where); });
    Object.keys(byAddr).sort().forEach(a => L.push("- `" + a + "`: " + byAddr[a].join("; ")));
    L.push("");
  }

  if (codeBlocks.length) {
    L.push("## Code");
    L.push("");
    // Keep big documents readable: shorter listings when there is a lot of code
    const total = codeBlocks.reduce((n, c) => n + c.text.length, 0);
    const full = total > 60000 ? 0 : total > 25000 ? 15 : CODE_FULL_LINES;
    const head = total > 60000 ? 0 : total > 25000 ? 8 : CODE_HEAD_LINES;
    if (!full) L.push("(" + codeBlocks.length + " code blocks, " + Math.round(total / 1024) + " KB in total: only their headers are shown; read the .score for the code)\n");
    codeBlocks.forEach(c => L.push(renderCode(c, full, head)));
  }

  Util.writeFile(OUT, L.join("\n") + "\n");
}

try {
  summarize();
  Qt.exit(0);
} catch (e) {
  const err = Util.environmentVariable("SCORE_SUMMARY_ERR");
  const msg = String(e) + "\n" + (e && e.stack ? e.stack : "") + "\n";
  if (err) Util.writeFile(err, msg);
  console.error("score-summary: " + msg);
  Qt.exit(4);
}
