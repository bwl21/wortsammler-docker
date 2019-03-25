# wortsammler-docker

This is an experimental approach to install and use Wortsammler by
docker

# usage

``` {.bash}
docker-compose up

cd your project

docker run --rm -v `pwd`:/data bwl21/wortsammler --pi example.md -f pdf

docker run --rm -v `pwd`:/workdir bwl21/wortsammler wortsammler -pbi readme.md

docker run -ti -v `pwd`:/workdir bwl21/wortsammler:latest bash -c "cd ZSUPP_Tools &&  rake UD"

docker run --rm -v `pwd`:/workdir bwl21/wortsammler:latest bash -c "cd ZSUPP_Tools &&  rake UD"

```

# credits

-   very small tex image ivanpondal/alpine-latex:1.1.0

-   https://hub.docker.com/r/ciandt/docker-alpine-pandoc/dockerfile \#
    based on ivanpondal/alpine-latex:1.1.0 but adds pandoc from github
    without cabal
