#!/bin/sh

pvsha ()
{
    file=$1
    pv "$file" | sha256sum | sed "s/-/$file/"
}
pvsha $1