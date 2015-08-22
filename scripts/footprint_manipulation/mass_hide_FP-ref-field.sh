#!/bin/bash

for FILE in `ls *.kicad_mod`; do TMP=`mktemp` && cat $FILE | sed 's/\(.*(fp_text\ reference.*)\)/\1 hide/' > $TMP && mv $TMP $FILE; done

