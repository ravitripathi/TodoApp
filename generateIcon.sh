#!/bin/bash
OUTPUT="generated"
mkdir -p ${OUTPUT}

APP_ICON=$1
declare -A iphone
declare -A appstore
declare -A watchos

iphone=(['Icon-60@2x']='120' ['Icon-60@3x']='180' ['Icon-76']='76' ['Icon-76@2x']='152' ['Icon-83.5@2x']='167' ['Icon-Small-40']='40' ['Icon-Small-40@2x']='80' ['Icon-Small-40@3x']='120' ['Icon-Small']='29' ['Icon-Small@2x']='58' ['Icon-Small@3x']='87')
watchos=(['AppIcon40x40@2x']='80' ['AppIcon44x44@2x']='88' ['AppIcon86x86@2x']='172' ['AppIcon98x98@2x']='196' ['AppIcon24x24@2x']='48' ['AppIcon27.5x27.5@2x']='55' ['AppIcon29x29@2x']='58' ['AppIcon29x29@3x']='87')
appstore=(['iTunesArtwork']='512' ['iTunesArtwork@2x']='1024')

function process_array 
{
	local -n array
	array=$1
	folder_name=$2
	for image_name in "${!array[@]}";
	do 
		value="${array[$image_name]}"
		echo "Creating $image_name with resolution $value"
		sips -Z $value --out "$folder_name/$image_name.png" "$APP_ICON"
	done
}

script_name=`basename "$0"`
if [[ -z "$APP_ICON" ]]; then
	echo "Usage: $script_name.sh <path_to_icon>"
	exit 1
fi

mkdir -p "$OUTPUT/iphone"
mkdir -p "$OUTPUT/watchos"
mkdir -p "$OUTPUT/appstore"

process_array iphone "$OUTPUT/iphone"
process_array watchos "$OUTPUT/watchos"
process_array appstore "$OUTPUT/appstore"


