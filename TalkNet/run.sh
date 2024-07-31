#!/bin/bash

# https://github.com/luongnguyenminhan/wav2lip

# Download video
# video_link="https://drive.google.com/file/d/1kddSO1217sD42GZVH81IbjzGC7_Pptgh/view?usp=drive_link"
video_link="https://drive.google.com/file/d/1aA1w0YLdl6DAdzhI8v6q_bRFsVZ0J6Ul/view?usp=sharing"
gdown --fuzzy $video_link -O videos.zip
unzip videos.zip
rm -rf __MACOSX
rm -rf ./videos/.DS_Store

video_folder="videos"  # Replace with the path to your video folder
output_folder="output_folder"  # Base name for the output folders

# Create the output folder if it doesn't exist
mkdir -p "$output_folder"

# Get all video file names from the folder (remove extension if needed)
video_files=($(ls "$video_folder"))

for video in "${video_files[@]}"; do
    # get video name
    video_name="${video%.*}"

    # echo "Preprocessing video: $video_name"

    # Run the processing command
    echo "****** Start detect talking face ******"
    python ./demoTalkNet.py --videoFolder "$video_folder" --videoName "$video_name"
    echo "****** Done detect talking face ******"

    # Move .mp4 and .avi files from "pycrop" to the specific output folder
    echo "****** Start moving pycrop to output_folder ******"
    for file in pycrop/*.{mp4,avi}; do
        if [[ -f "$file" ]]; then  # Check if the file exists
            mv "$file" "$output_folder/"
        fi
    done
    echo "****** Done moving pycrop to output_folder ******"
done

