#!/bin/bash
# Git KiCad library repos:
#
# The "install_prerequisites" step is the only "distro dependent" one.  Could modify
# that step for other linux distros.
# This script requires "git".  The package bzr-git is not up to the task.
# The first time you run with option --install-or-update that is the slowest, because
# git clone from github.com is slow.
# After that updates should run faster.

# There are two reasons why you might want to run this script:
#
# 1) You want to contribute to the KiCad library team maintained libraries and have yet to
#    discover or have chosen not to use the COW feature in the Github "Plugin Type".
#
# 2) You want to run with local pretty footprint libraries and not those remotely located
#    on https://github.com using Github plugin.  After running this script you should be able to
#      a)  $ cp ~/kicad_sources/library-repos/kicad-library/template/fp-lib-table.for-pretty ~/fp-lib-table
#    and then
#      b) set your environment variable KISYSMOD to "~/kicad_sources/library-repos".
#         Edit /etc/profile.d/kicad.sh, then reboot.
#
#    This will use the KiCad plugin against the *.pretty dirs in that base dir.


# Set where the library repos will go, use a full path
WORKING_TREES=/home/john_doe/some_folder

    # Use github API to list repos for org KiCad, then subset the JSON reply for only
    # *.pretty repos
    PRETTY_REPOS=`curl https://api.github.com/orgs/KiCad/repos?per_page=2000 2> /dev/null \
        | grep full_name | grep pretty \
        | sed -r  's:.+ "KiCad/(.+)",:\1:'`

    if [ ! -d "$WORKING_TREES" ]; then
        mkdir -p "$WORKING_TREES"
        echo " mark $WORKING_TREES as owned by me"
        chown -R `whoami` "$WORKING_TREES"
    fi
    cd $WORKING_TREES

    if [ ! -e "$WORKING_TREES/library-repos" ]; then
        mkdir -p "$WORKING_TREES/library-repos"
    fi

    for repo in kicad-library $PRETTY_REPOS; do
        # echo "repo:$repo"

        if [ ! -e "$WORKING_TREES/library-repos/$repo" ]; then

            # Be _sure_ and preserve the directory name, we want extension .pretty not .pretty.git.
            # That way those repos can serve as pretty libraries directly if need be.

            echo "installing $WORKING_TREES/library-repos/$repo"
            git clone "https://github.com/KiCad/$repo" "$WORKING_TREES/library-repos/$repo"
        else
            echo "updating $WORKING_TREES/library-repos/$repo"
            cd "$WORKING_TREES/library-repos/$repo"
            git pull
        fi
    done
