#!/bin/bash

MESON_CURRENT_SOURCE_DIR=${MESON_CURRENT_SOURCE_DIR:-./}
MESON_BUILD_ROOT=${MESON_BUILD_ROOT:-buildresults}

if [[ "$1" == "XML" || "$1" == "xml" ]]; then
	XML_ARGS='--xml --xml-version=2'
	XML_REDIRECT="2>${MESON_BUILD_ROOT}/cppcheck.xml"
else
	XML_ARGS=
	XML_REDIRECT=
fi

eval cppcheck --quiet --enable=style --force ${XML_ARGS} \
	-I ${MESON_CURRENT_SOURCE_DIR}/include \
	src test ${XML_REDIRECT}

