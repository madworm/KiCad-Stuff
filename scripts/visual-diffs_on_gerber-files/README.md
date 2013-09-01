
What is this?
=============

This is a very basic way of getting visual diffs for gerber files using git.

[![visual-diff_on_gerber-files](/pics/gerber-visual-diff.png)](/scripts/visual-diffs_on_gerber-files/pics/gerber-visual-diff.png)

1) This script will use 'gerbv' to create png-images from gerber files.

2) The resulting images will be processed by 'ImageMagick' tools to create
   visual diffs.


Setup:
======

1) Adapt your personal '.gitconfig' to include the [difftool] sections.

2) Copy the script to a convenient place (/usr/local/bin/) and make it executable.

3) Adjust as necessary!


Invocation from git:
====================

1) To see the changes in the current working tree

git difftool -t visdiff

2) Compare any two commits

git difftool -t visdiff commit-ID-1 commit-ID-2


Caveats:
========

When the size of the gerber data (boardsize...) is changed, the script
will stretch them to size and probably display false diff information.

This may happen if you e.g. remove a drill-location from the edge of
the drill file.

For copper layers etc., this effect can be removed by always having the
board-outline on all layers when creating the gerber files.

