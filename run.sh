#!/bin/bash

echo "Type root path for the cppconan followed by [ENTER]:"
read root_path

echo "Type the project path followed by [ENTER]:"
read -e project

if [ "$root_path" == "" ]; then
    echo "Bad root path: " $root_path
    exit 1
else
    if [ "$project" == "" ]; then
        echo "Bad project path: " $project
        exit 1
    else
        docker run --rm -it -e DISPLAY=$DISPLAY \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v ~/$root_path/cppconan/.vscode/:/home/andrei/.vscode/ \
            -v $project:/home/andrei/project/ \
            -p 8800:8800 \
            cppconan:latest
        exit 0
    fi
fi