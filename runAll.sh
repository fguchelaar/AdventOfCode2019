#!/bin/bash

find -s . -name "*day*" -depth 1 -type d \
    -exec echo Running {} \; \
    -exec sh -c 'pushd .  > /dev/null; cd $1; time swift run -c release; popd > /dev/null' sh {} \;
