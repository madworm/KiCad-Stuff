
What is this?
=============

This is a _very basic_ way of getting visual diffs for gerber files using git.

[![visual-diff_on_gerber-files](/scripts/visual-diffs_on_gerber-files/pics/gerber-visual-diff.png)](/scripts/visual-diffs_on_gerber-files/pics/gerber-visual-diff.png)

This script uses 'gerbv' to show differences in gerber files by XOR-ing two revisions supplied by git.


Requirements:
=============

* tools: gerbv + diff
* KiCad: don't forget to create gerber files for each commit


Setup:
======

1) Adapt your personal '.gitconfig' to include the [difftool] sections.

2) Adjust as necessary!

3) Copy the script to a convenient place (/usr/local/bin/) and make it executable.

4) Easily integrates with the 'qgit' GUI as 'external-diff' (Ctrl+D).

   Configure 'qgit' to run "xterm -e vis_diff.sh" as its 'External diff tool'. 


Invocation from git:
====================

1) To see the changes in the current working tree

git difftool -t visdiff

2) Compare any two commits

git difftool -t visdiff commit-ID-1 commit-ID-2


