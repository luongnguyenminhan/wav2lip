#!/bin/bash

# Download video
# gdown --fuzzy https://drive.google.com/file/d/1kddSO1217sD42GZVH81IbjzGC7_Pptgh/view?usp=drive_link -O data_root.zip
# unzip data_root.zip

video_folder="data_root"  # Replace with the path to your video folder
output_folder="output_folder"  # Base name for the output folders

# Get all video file names from the folder (remove extension if needed)
video_files=($(ls "$video_folder"))

for video in "${video_files[@]}"; do
    # get video name
    video_name="${video%.*}"

    # echo "Preprocessing video: $video_name"

    # Run the processing command
    python demoTalkNet.py --videoFolder "$video_folder" --videoName "$video_name"
    
    # # Move the contents of "pycrop" to the specific output folder
    # mv pycrop "$output_folder"
    # Move .mp4 and .avi files from "pycrop" to the specific output folder
    for file in pycrop/*.{mp4,avi}; do
        if [[ -f "$file" ]]; then  # Check if the file exists
            mv "$file" "$output_folder/"
        fi
    done
done

