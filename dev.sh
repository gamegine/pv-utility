# build if not exists
if [[ "$(docker images -q pv-utility:dev 2> /dev/null)" == "" ]]; then
    docker build . --build-arg testtool=true -t pv-utility:dev
fi
# run
docker run --rm -v $(pwd):/root/pv-utility -it pv-utility:dev