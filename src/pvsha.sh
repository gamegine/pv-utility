#!/bin/bash

pvsha ()
{
    file="$1"
    escapefile="${file//\//\\/}" # fix / in sed
    pv "$file" | sha256sum | sed "s/-/$escapefile/"
}

pvshacheck ()
{
    failed=0
    file="$1"
    while read -r sha path; do
        if [ ! -z "$path" ] && [ ! -z "$sha" ]; then
            res=$(pv "$path" | sha256sum)
            if [ "$res" == "$sha  -" ] ; then
                #echo "$path: Réussi"
                echo "$path: OK"
            else
                echo "$path: FAILED"
                failed=$(($failed+1))
            fi
        else
            echo empty
        fi
    done < $file
    if [ ! $failed -eq 0 ] ; then
        echo "sha256sum: Attention : $failed somme de contrôle ne correspond pas"
    fi
}

# echo $@ all arg
# pvsha "$1"

# pvshacheck "sha256.txt"

check=""

# cmd arg parse
PARAMS=""

while (( "$#" )); do
    case "$1" in
        -c | --check)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                check=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
        ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2
            exit 1
        ;;
        *) # preserve positional arguments
            if [ -z $PARAMS ] ; then
                PARAMS="$1"
            else
                PARAMS="$PARAMS $1"
            fi
            shift
        ;;
    esac
done

# echo $PARAMS

if [ ! -z $check ] ; then
    pvshacheck "$check"
else
    pvsha "$PARAMS"
fi