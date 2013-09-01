#!/bin/bash

#
# DPI value for gerbv PNG creation
#
DPI="600"

shopt -s nocasematch

if [ $# -ne 3 ] 
then
	echo -e "\nUsage: $0 image1 image2 outfile\n"
	EXIT=1
fi

#
# Check if all tools are available
#
if [[ ! -e `which gerbv` ]]
then
	echo -e "\nPlease install 'gerbv'\n"
	EXIT=1
fi

if [[ ! -e `which convert` ]]
then
	echo -e "\nMissing 'convert'. Please install 'ImageMagick' package.\n"
	EXIT=1
fi

if [[ ! -e `which composite` ]]
then
	echo -e "\nMissing 'composite'. Please install 'ImageMagick' package\n"
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
if [[ $1 =~ ^.*\.(png|jpg|pdf)$ ]]
then
	# we can process these files directly
	IN1=$1
	IN2=$2
	# only do gerber files for now...
	exit
elif [[ $1 =~ ^.*\.(g[a-z]{2}|drl|oln)$ && ! $1 =~ ^.*.gvp$ ]]
then
	# create temporary png images from gerber files
	IN1=`mktemp --suffix=_git`
	IN2=`mktemp --suffix=_git`	
	gerbv $1 -o $IN1 --dpi=${DPI}x${DPI} -a --export=png
	gerbv $2 -o $IN2 --dpi=${DPI}x${DPI} -a --export=png
else
	# unsupported file format
	exit
fi

#
# forced resize to (W,H) of the first image
#
#SIZE=`convert $IN1 -print "%wx%h\!" /dev/null`

#
# forced resize to (W,H)/2 of the screen size
#
SCREEN_WIDTH=`xwininfo -root |grep Width | gawk '{print $2}'`
SCREEN_HEIGHT=`xwininfo -root |grep Height | gawk '{print $2}'`
SIZE="$(($SCREEN_WIDTH*2/3))x$(($SCREEN_HEIGHT*2/3))!"

#
# this is where the magic happens
#
FILE_A=`mktemp --suffix=_git`
FILE_B=`mktemp --suffix=_git`
convert -colorspace gray -scale $SIZE $IN1 $FILE_A
convert -colorspace gray -scale $SIZE $IN2 $FILE_B
composite -stereo 0 $FILE_A $FILE_B $3

#
# cleanup
#
rm $FILE_A
rm $FILE_B

if [[ $IN1 =~ ^/tmp/tmp\..*$ ]]
then 
	rm $IN1
fi

if [[ $IN2 =~ ^/tmp/tmp\..*$ ]]
then
	rm $IN2
fi
