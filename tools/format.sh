#!/bin/bash

MESON_BUILD_ROOT=${MESON_BUILD_ROOT:-buildresults}

find . -type d \( -path ./src/gdtoa -o -path ./subprojects -o -path ./${MESON_BUILD_ROOT} \
	-o -path ./docs -o -path ./tools -o -path ./format \) -prune -type f \
	-o -iname *.h -o -iname *.c -o -iname *.cpp -o -iname *.hpp \
	| xargs clang-format -style=file -i -fallback-style=none
