#!/usr/bin/env bats

# https://github.com/sstephenson/bats

@test "sha256" {
    [ "$(sha256sum test.txt)" == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test.txt" ]
}
@test "pvsha" {
    [ "$(pvsha.sh test.txt)" == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test.txt" ]
}

@test "sha256 with '/' in path" {
    [ "$(sha256sum ../LICENSE)" == "e1e444c16579275104ead78e370fd5df44675824569141cefb75d58f359fbb30  ../LICENSE" ]
}
@test "pvsha with '/' in path" {
    [ "$(pvsha.sh ../LICENSE)" == "e1e444c16579275104ead78e370fd5df44675824569141cefb75d58f359fbb30  ../LICENSE" ]
}

@test "sha256 with whitespace" {
    [ "$(sha256sum "test whitespace.txt")" == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test whitespace.txt" ]
}
@test "pvsha with whitespace" {
    [ "$(pvsha.sh "test whitespace.txt")" == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test whitespace.txt" ]
}

@test "sha256 multiple files" {
    run sha256sum test.txt test.txt
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test.txt" ]
    [ "${lines[1]}" = "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test.txt" ]
}

# algorithms 

@test "pvsha with algorithm sha512" {
    if ! command -v sha512sum &>/dev/null; then skip "sha512 algorithm not supported by your system "; fi
    [ "$(pvsha.sh -a sha512 test.txt)" == "ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff  test.txt" ]
}
@test "pvsha with algorithm sha256" {
    [ "$(pvsha.sh -a sha256 test.txt)" == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test.txt" ]
}
@test "pvsha with algorithm sha3" {
    if ! command -v sha3sum &>/dev/null; then skip "sha3 algorithm not supported by your system "; fi
    [ "$(pvsha.sh -a sha3 test.txt)" == "3797bf0afbbfca4a7bbba7602a2b552746876517a7f9b7ce2db0ae7b  test.txt" ]
}
@test "pvsha with algorithm sha1" {
    if ! command -v sha1sum &>/dev/null; then skip "sha1 algorithm not supported by your system "; fi
    [ "$(pvsha.sh -a sha1 test.txt)" == "a94a8fe5ccb19ba61c4c0873d391e987982fbbd3  test.txt" ]
}
@test "pvsha with algorithm md5" {
    if ! command -v md5sum &>/dev/null; then skip "md5 algorithm not supported by your system "; fi
    [ "$(pvsha.sh -a md5 test.txt)" == "098f6bcd4621d373cade4e832627b4f6  test.txt" ]
}

# check

@test "sha256 check" {
    [ "$(sha256sum -c test.txt.sha256)" == "test.txt: OK" ]
}
@test "sha256 check using pv" {
    [ "$(pvsha.sh -c test.txt.sha256)" == "test.txt: OK" ]
}

@test "sha256 check with whitespace" {
    [ "$(sha256sum -c "test whitespace.txt.sha256")" == "test whitespace.txt: OK" ]
}
@test "sha256 check using pv with whitespace" {
    [ "$(pvsha.sh -c "test whitespace.txt.sha256")" == "test whitespace.txt: OK" ]
}

@test "sha256 check multiple files" {
    run sha256sum -c test.txt.sha256 -c test.txt.sha256
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "test.txt: OK" ]
    [ "${lines[1]}" = "test.txt: OK" ]
}

# check with algorithms 
@test "pvsha check with algorithm sha512" {
    if ! command -v sha512sum &>/dev/null; then skip "sha512 algorithm not supported by your system "; fi
    [ "$(pvsha.sh -a sha512 -c test.txt.sha512)" == "test.txt: OK" ]
}
@test "pvsha check with algorithm sha256" {
    [ "$(pvsha.sh -a sha256 -c test.txt.sha256)" == "test.txt: OK" ]
}
@test "pvsha check with algorithm sha3" {
    if ! command -v sha3sum &>/dev/null; then skip "sha3 algorithm not supported by your system "; fi
    [ "$(pvsha.sh -a sha3 -c test.txt.sha3)" == "test.txt: OK" ]
}
@test "pvsha check with algorithm sha1" {
    if ! command -v sha1sum &>/dev/null; then skip "sha1 algorithm not supported by your system "; fi
    [ "$(pvsha.sh -a sha1 -c test.txt.sha1)" == "test.txt: OK" ]
}
@test "pvsha check with algorithm md5" {
    if ! command -v md5sum &>/dev/null; then skip "md5 algorithm not supported by your system "; fi
    [ "$(pvsha.sh -a md5 -c test.txt.md5)" == "test.txt: OK" ]
}