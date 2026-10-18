---
layout: default

title: Changelog
description: "ossia score release notes"

nav_order: 100
parent: Reference

permalink: /reference/changelog.html
---

# Changelog

**{{ site.data.release_archive.count }} releases.** [Downloads on GitHub](https://github.com/ossia/score/releases).

{% for group in site.data.release_archive.groups %}
<h2 id="{{ group.id }}">{{ group.title }}</h2>
{% include release-list.html releases=group.releases %}
{% endfor %}

## Continuous builds

Development builds, updated between releases.

{% include release-list.html releases=site.data.release_archive.development %}

