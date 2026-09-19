// Start script for the `capture` pass of script/examples/metadata.rb.
//
//   ossia-score <example.score> --script script/examples/capture.mjs
//
// score refreshes a document's thumbnail from a grab of its view every time it
// is saved (updateProjectInfoBeforeSave in DocumentManager.cpp), so re-saving
// an example is all it takes to give it a screenshot -- provided the view has
// actually painted. Start scripts run 100 ms after startup, which is not enough
// for a freshly loaded scenario to lay out and render its first frame: grabbing
// then yields a flat image, which score detects and discards, leaving the
// example with no thumbnail at all.
//
// So this waits for SCORE_CAPTURE_SETTLE_MS of event loop before saving. The
// wait is a QML Timer rather than a busy loop: the point is to let the loop
// run, not to burn time.

const settle = parseInt(Util.environmentVariable("SCORE_CAPTURE_SETTLE_MS") || "4000");

const timer = Qt.createQmlObject(
    'import QtQuick; Timer { repeat: false; running: false }', Score, 'capture.mjs');
timer.interval = settle;
timer.triggered.connect(function () {
  try
  {
    Score.save();
    Qt.exit(0);
  }
  catch(e)
  {
    console.error("capture.mjs: save failed: " + e);
    Qt.exit(4);
  }
});
timer.running = true;
