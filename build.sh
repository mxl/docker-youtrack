#!/usr/bin/env bash

docker build . -t appheads/youtrack
docker login -u mixel
docker push appheads/youtrack
