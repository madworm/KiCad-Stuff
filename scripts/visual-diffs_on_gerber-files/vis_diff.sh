#!/bin/bash

shopt -s nocasematch

#
# Check if all tools are available
#
if [[ ! -e `which gerbv` ]]
then
	echo -e "\nPlease install 'gerbv'\n"
	EXIT=1
fi

if [[ $EXIT -eq 1 ]]
then
	echo -e "\nBYE!\n"
	exit
fi

#
# do a simple check for image-(like) file formats
#
if [[ $1 =~ ^.*\.(g[a-z]{2}|drl|oln)$ && ! $1 =~ ^.*.gvp$ ]]
then
	TMPFILE0=`mktemp --suffix=_git`
	TMPFILE1=`mktemp --suffix=_git`
	TMPFILE2=`mktemp --suffix=_git`

	cp $1 $TMPFILE1
	cp $2 $TMPFILE2

	GERBV_TEMPLATE="(gerbv-file-version! \"2.0A\")\n
	(define-layer! 1 (cons 'filename \"${TMPFILE1}\")(cons 'visible #t)(cons 'color #(65535 0 3050)))\n
	(define-layer! 0 (cons 'filename \"${TMPFILE2}\")(cons 'visible #t)(cons 'color #(8188 65535 0)))\n
	(set-render-type! 1)"

	echo -e $GERBV_TEMPLATE > $TMPFILE0
	gerbv -p $TMPFILE0
else
	# unsupported file format
	exit
fi

#
# cleanup
#
rm $TMPFILE0
rm $TMPFILE1
rm $TMPFILE2
