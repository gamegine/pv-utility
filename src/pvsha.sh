#!/bin/bash

help ()
{
    echo "Usage:"
    echo "  $0 [options] [<files>...]"
    echo "  options:"
    echo "    -h, --help: show this help"
    echo "    -a, --alg:  algorithm to use (default: sha256)"
    echo "      available algorithms: sha512, sha256, sha3, sha1, md5"
    echo "     -c, --check: check hash list in file"

    echo "  Example: $0 file.txt"
    echo "  Example: $0 -a md5 file.txt"
    echo "  Example: $0 -c hash.sha256"
}

pvsha ()
{
    file="$1"
    escapefile="${file//\//\\/}" # fix / in sed
    pv "$file" | $algorithm | sed "s/-/$escapefile/"
}

pvshacheck ()
{
    failed=0
    file="$1"
    while read -r sha path; do
        if [ ! -z "$path" ] && [ ! -z "$sha" ]; then
            res=$(pv "$path" | $algorithm)
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
    done < "$file"
    if [ ! $failed -eq 0 ] ; then
        echo "$algorithm: Attention : $failed somme de contrôle ne correspond pas"
    fi
}

# hashing algorithm
algorithm="sha256sum"

# check file list
check=""

# parse input parameters and set config variables

# variable to store all arguments that are not config options
PARAMS=""
while (( "$#" )); do
    case "$1" in
        -c | --check)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                check="$2"
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
        ;;
        -a | --algorithm)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                case $2 in
                    sha256 | sha256sum)
                        algorithm="sha256sum"
                        ;;
                    sha512 | sha512sum)
                        algorithm="sha512sum"
                        ;;
                    sha3 | sha3sum)
                        algorithm="sha3sum"
                        ;;
                    sha1 | sha1sum)
                        algorithm="sha1sum"
                        ;;
                    md5 | md5sum)
                        algorithm="md5sum"
                        ;;
                    *)
                        echo "Error: $2 is not a valid algorithm" >&2
                        echo "valid algorithms are: sha256, sha512, sha3, sha1, md5" >&2
                        exit 1
                        ;;
                esac
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
        ;;
        -h | --help)
            help
            exit 0
        ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2
            exit 1
        ;;
        *) # preserve positional arguments
            if [ -z "$PARAMS" ] ; then
                PARAMS="$1"
            else
                PARAMS="$PARAMS $1"
            fi
            shift
        ;;
    esac
done

# echo $PARAMS

if [ ! -z "$check" ] ; then
    pvshacheck "$check"
else
    pvsha "$PARAMS"
fi