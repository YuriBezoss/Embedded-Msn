#!/bin/bash

# This script should be supplied with an argument, which is the Meson executable variable
# for the libc test program. This works around needing an external dependency and hard-coding
# the executable path in the script.

export CMOCKA_XML_FILE=${MESON_BUILD_ROOT}/test/\%g.xml
eval $1
