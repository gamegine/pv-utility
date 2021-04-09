#!/usr/bin/env bats

# https://github.com/sstephenson/bats

@test "sha256" {
    [ "$(sha256sum test.txt)" == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test.txt" ]
}
@test "sha256 using pv" {
    [ "$(pvsha.sh test.txt)" == "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08  test.txt" ]
}

@test "sha256 with / in path" {
    [ "$(sha256sum ../LICENSE)" == "e1e444c16579275104ead78e370fd5df44675824569141cefb75d58f359fbb30  ../LICENSE" ]
}
@test "sha256 using pv with / in path" {
    [ "$(pvsha.sh ../LICENSE)" == "e1e444c16579275104ead78e370fd5df44675824569141cefb75d58f359fbb30  ../LICENSE" ]
}

@test "sha256 check" {
    [ "$(sha256sum -c sha256.txt)" == "test.txt: OK" ]
}
@test "sha256 check using pv" {
    [ "$(pvsha.sh -c sha256.txt)" == "test.txt: OK" ]
}