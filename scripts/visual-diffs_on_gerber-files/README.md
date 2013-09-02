
What is this?
=============

This is a very basic way of getting visual diffs for gerber files using git.

[![visual-diff_on_gerber-files](/pics/gerber-visual-diff.png)](/scripts/visual-diffs_on_gerber-files/pics/gerber-visual-diff.png)

This script uses 'gerbv' to show differences in gerber files by XOR-ing two revisions supplied by git.


Requirements:
=============

* gerbv


Setup:
======

1) Adapt your personal '.gitconfig' to include the [difftool] sections.

2) Adjust as necessary!

3) Copy the script to a convenient place (/usr/local/bin/) and make it executable.


Invocation from git:
====================

1) To see the changes in the current working tree

git difftool -t visdiff

2) Compare any two commits

git difftool -t visdiff commit-ID-1 commit-ID-2


