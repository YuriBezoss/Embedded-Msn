#!/bin/bash

MESON_SOURCE_ROOT=${MESON_SOURCE_ROOT:-''}

if [[ "${MESON_SOURCE_ROOT}" == '' ]]; then
    MESON_SOURCE_ROOT=$(pwd)
fi

MESON_BUILD_ROOT=${MESON_BUILD_ROOT:-${MESON_SOURCE_ROOT}/buildresults}

# Arguments
# * `-a` indicates the target architecture (`x86_64`, `arm`)
# * `-c` indicates the target chip (`Cortex-M3`, `STM32F103VBIx`)
# * `-s` indicates the target system (`darwin`, `none`)
# * `-n` indicates that we should pick up the native files
# * `-v` indicates the version

ARCH='undef'
CHIP='undef'
SYSTEM='undef'

while getopts "na:c:s:v:" opt; do
  case $opt in
    a) ARCH="$OPTARG"
    ;;
    c) CHIP="$OPTARG"
    ;;
    s) SYSTEM="$OPTARG"
    ;;
    n) NATIVE='1'
    ;;
    v) VERSION="$OPTARG"
	;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

######################
# Construct Filename #
######################

FILENAME=libc

if [ "$NATIVE" == '1' ]; then
    FILENAME+='_native'
fi

if [ "$VERSION" != '' ]; then
    FILENAME+=_${VERSION}
fi

FILENAME+=_${ARCH}-${CHIP}-${SYSTEM}

FILENAME+=.tgz

#################
# Create Output #
#################

RELEASE_DIR=${MESON_BUILD_ROOT}/releases
mkdir -p "${RELEASE_DIR}"

if [ "$NATIVE" == '1' ]; then
    LIB_FILE="libc_native.a"
else
    LIB_FILE="libc.a"
fi

# First, we add the includes
cd ${MESON_SOURCE_ROOT}
tar -cf ${RELEASE_DIR}/${FILENAME} include/ arch/${ARCH}/include

# Next we add documentation
cd ${MESON_BUILD_ROOT}
tar -uf ${RELEASE_DIR}/${FILENAME} doc

# Finally we add the library file(s)
cd ${MESON_BUILD_ROOT}/src
tar -uf ${RELEASE_DIR}/${FILENAME} ${LIB_FILE}
