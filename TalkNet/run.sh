#!/bin/bash

# https://github.com/luongnguyenminhan/wav2lip

# Download video
# video_link="https://drive.google.com/file/d/1kddSO1217sD42GZVH81IbjzGC7_Pptgh/view?usp=drive_link"
# video_link="https://drive.google.com/file/d/1aA1w0YLdl6DAdzhI8v6q_bRFsVZ0J6Ul/view?usp=sharing" # videos
# video_link="https://drive.google.com/file/d/1iaOJXt-weJEMZg5vlO-S2MNBQRIk1B5f/view?usp=drive_link" # data
video_link="https://drive.google.com/file/d/1mbKfarkwWv0y14oqB9SfW4Lm-u-jfcjF/view?usp=sharing" # data 3, 10 vids
# video_link="https://drive.google.com/file/d/1HscH8xDiUXfnSZteJ2Cq0rPhgkD79rk8/view?usp=drive_link" # data 4
name="data"

gdown --fuzzy $video_link -O $name.zip
# rm -rf data
# unzip -q $name
rm -rf __MACOSX
rm -rf "./$name/.DS_Store"

data_folder="./data"
raw_data="./raw_data"
output_folder="./videos"

# Create the output folder if it doesn't exist
mkdir -p "$output_folder"
mkdir -p "$raw_data"
mkdir -p "$data_folder"

# Get all video file names from the folder (remove extension if needed)
video_files=($(ls "$data_folder"))

for video in "${video_files[@]}"; do
    # get video name
    video_name="${video%.*}"

    echo "Preprocessing video: $video_name"

    # Run the processing command
    echo "****** Start detect talking face $video_name ******"
    python ./demoTalkNet.py --videoFolder "$data_folder" --videoName "$video_name"
    echo "****** Start Moving file ******"
    # Rename file before moving
    for file in $data_folder/$video_name/pycrop/*.avi; do
        mv $file ${file%.avi}_$video_name.avi
    done
    mv $data_folder/$video_name/pycrop/*.avi $output_folder
    echo "****** Done Moving file ******"
    echo "****** Done detect talking face $video_name ******"
done

# mv "$data_folder"/*.mp4 $raw_data

# # move all pycrop
# video_outputs=($(ls "$data_folder"/))
# for video_output in "${video_outputs[@]}"; do
#     # get video name
#     echo $video_output

#     # echo "Preprocessing video: $video_name"

#     # Run the processing command
#     echo "****** Start Moving file ******"
#     # Rename file before moving
#     for file in $data_folder/$video_output/pycrop/*.avi; do
#         mv $file ${file%.wav}_$video_output.avi
#     done
#     mv $data_folder/$video_output/pycrop/*.avi $output_folder
#     echo "****** Done Moving file ******"
# done
