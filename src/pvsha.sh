#!/bin/bash

pvsha ()
{
    file="$1"
    escapefile="${file//\//\\/}" # fix / in sed
    pv "$file" | sha256sum | sed "s/-/$escapefile/"
}
pvsha "$1"