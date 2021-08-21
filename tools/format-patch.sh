#!/bin/bash

MESON_BUILD_ROOT=${MESON_BUILD_ROOT:-buildresults}

rm -f clang_format.patch

find . -type d \( -path ./src/gdtoa -o -path ./subprojects -o -path ./${MESON_BUILD_ROOT} \
	-o -path ./docs -o -path ./tools -o -path ./format \) -prune -type f \
	-o -iname *.h -o -iname *.c -o -iname *.cpp -o -iname *.hpp \
	| xargs clang-format -style=file -i -fallback-style=none

git diff > clang_format.patch

# Delete if 0 size
if [ ! -s clang_format.patch ]
then
	rm clang_format.patch
fi
