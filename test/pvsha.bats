#!/usr/bin/env bats

# https://github.com/sstephenson/bats

@test "sha256" {
    [ "$(sha256sum test.txt)" == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test.txt" ]
}
@test "sha256 using pv" {
    [ "$(pvsha.sh test.txt)" == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test.txt" ]
}