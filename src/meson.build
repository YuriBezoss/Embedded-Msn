

#################
# GDTOA Library #
#################

gdtoa_files = files(
	'gdtoa/src/dmisc.c',
	'gdtoa/src/dtoa.c',
	'gdtoa/src/g__fmt.c',
	'gdtoa/src/g_ddfmt.c',
	'gdtoa/src/g_dfmt.c',
	'gdtoa/src/g_ffmt.c',
	'gdtoa/src/g_Qfmt.c',
	'gdtoa/src/g_xfmt.c',
	'gdtoa/src/g_xLfmt.c',
	'gdtoa/src/gdtoa.c',
	'gdtoa/src/gethex.c',
	'gdtoa/src/gmisc.c',
	'gdtoa/src/hd_init.c',
	'gdtoa/src/hexnan.c',
	'gdtoa/src/misc.c',
	'gdtoa/src/smisc.c',
	'gdtoa/src/strtod.c',
	'gdtoa/src/strtodg.c',
	'gdtoa/src/strtodI.c',
	'gdtoa/src/strtof.c',
	'gdtoa/src/strtoId.c',
	'gdtoa/src/strtoIdd.c',
	'gdtoa/src/strtoIf.c',
	'gdtoa/src/strtoIg.c',
	'gdtoa/src/strtoIQ.c',
	'gdtoa/src/strtoIx.c',
	'gdtoa/src/strtoIxL.c',
	'gdtoa/src/strtopd.c',
	'gdtoa/src/strtopdd.c',
	'gdtoa/src/strtopf.c',
	'gdtoa/src/strtopQ.c',
	'gdtoa/src/strtopx.c',
	'gdtoa/src/strtopxL.c',
	'gdtoa/src/strtord.c',
	'gdtoa/src/strtordd.c',
	'gdtoa/src/strtorf.c',
	'gdtoa/src/strtorQ.c',
	'gdtoa/src/strtorx.c',
	'gdtoa/src/strtorxL.c',
	'gdtoa/src/sum.c',
	'gdtoa/src/ulp.c'
)

gdtoa_includes = include_directories('gdtoa/include')

gdtoa_compiler_flags = [
	'-DNO_ERRNO',
	'-DIFNAN_CHECK',
	'-DGDTOA_NO_ASSERT',
	'-DNO_FENV_H'
]

libgdtoa = static_library('gdtoa',
    gdtoa_files,
    include_directories: gdtoa_includes,
    c_args: gdtoa_compiler_flags,
)

################
# libc Library #
################

assert_files = files('assert/assert.c')

crt_files = files(
	'crt/_Exit.c',
	'crt/abort.c',
	'crt/at_exit.c',
	'crt/at_quick_exit.c',
	'crt/crt.c',
	'crt/cxa_atexit.c',
	'crt/exit.c',
	'crt/quick_exit.c',
)

ctype_files = files(
	'ctype/isalnum.c',
	'ctype/isalpha.c',
	'ctype/isascii.c',
	'ctype/isblank.c',
	'ctype/iscntrl.c',
	'ctype/isdigit.c',
	'ctype/isgraph.c',
	'ctype/islower.c',
	'ctype/isprint.c',
	'ctype/ispunct.c',
	'ctype/isspace.c',
	'ctype/isupper.c',
	'ctype/isxdigit.c',
	'ctype/toascii.c',
	'ctype/tolower.c',
	'ctype/toupper.c'
)

locale_files = files('locale/langinfo.c')

math_files = files(
	'math/fabs.c',
	'math/fabsf.c',
)

stdlib_files = files(
	'stdlib/abs.c',
	'stdlib/atof.c',
	'stdlib/atoi.c',
	'stdlib/atol.c',
	'stdlib/atoll.c',
	'stdlib/bsearch.c',
	'stdlib/calloc.c',
	'stdlib/div.c',
	'stdlib/heapsort_r.c',
	'stdlib/heapsort.c',
	'stdlib/imaxabs.c',
	'stdlib/imaxdiv.c',
	'stdlib/labs.c',
	'stdlib/ldiv.c',
	'stdlib/llabs.c',
	'stdlib/lldiv.c',
	'stdlib/qsort_r.c',
	'stdlib/qsort.c',
	'stdlib/rand.c',
	'stdlib/realloc.c',
	'stdlib/strtol.c',
	'stdlib/strtold.c',
	'stdlib/strtoul.c',
	'stdlib/strtoll.c',
	'stdlib/strtoull.c',
)

stdio_files = files(
	'stdio/asprintf.c',
	'stdio/putchar.c',
	'stdio/puts.c',
	'stdio/vasprintf.c',
)

string_files = files(
	'string/memcmp.c',
	'string/memcpy.c',
	'string/memmem.c',
	'string/memmove.c',
	'string/memchr.c',
	'string/memrchr.c',
	'string/memset.c',
	'string/strcat.c',
	'string/strchr.c',
	'string/strchrnul.c',
	'string/strcmp.c',
	'string/strcoll.c',
	'string/strcpy.c',
	'string/strcspn.c',
	'string/strdup.c',
	'string/strerror.c',
	'string/strerror_r.c',
	'string/strlen.c',
	'string/strncat.c',
	'string/strncmp.c',
	'string/strncpy.c',
	'string/strndup.c',
	'string/strnlen.c',
	'string/strnstr.c',
	'string/strpbrk.c',
	'string/strrchr.c',
	'string/strspn.c',
	'string/strstr.c',
	'string/strtok.c',
	'string/strxfrm.c'
)

support_files = files(
	'support/fls.c',
	'support/flsl.c',
	'support/flsll.c'
)

time_files = files(
	'time/asctime.c',
	'time/asctime_r.c',
)

wchar_files = files(
	'wchar/iswalnum.c',
	'wchar/iswalpha.c',
	'wchar/iswblank.c',
	'wchar/iswcntrl.c',
	'wchar/iswalnum.c',
	'wchar/iswalpha.c',
	'wchar/iswblank.c',
	'wchar/iswcntrl.c',
	'wchar/iswctype.c',
	'wchar/iswdigit.c',
	'wchar/iswgraph.c',
	'wchar/iswlower.c',
	'wchar/iswprint.c',
	'wchar/iswpunct.c',
	'wchar/iswspace.c',
	'wchar/iswupper.c',
	'wchar/iswxdigit.c',
	'wchar/towccase.c',
	'wchar/towctrans.c',
	'wchar/towlower.c',
	'wchar/towupper.c',
	'wchar/wcswidth.c',
	'wchar/wctrans.c',
	'wchar/wctype.c',
	'wchar/wcwidth.c',
)

# These files are used by all libc targets
libc_common_files = [
	assert_files,
	ctype_files,
	locale_files,
	math_files,
	stdio_files,
	stdlib_files,
	string_files,
	support_files,
	time_files,
	wchar_files,
]

#################################
# Set Compiler and Linker Flags #
#################################

libc_includes = include_directories('../include')
arch_specific_includes = include_directories('../arch/x86_64/include')

# These files are used to compile libc for a build machine / your personal computer
libc_native_files = files(
	'stdio/putchar_native.c',
)

# These files are used when cross-compiling libc for another platform
libc_standalone_files = [
	crt_files,
]

libc_compile_flags = c_compiler.get_supported_arguments(
	'-nostdinc', # Don't include standard include paths - we don't want system headers
)

if disable_unimplemented_apis
	# Note: This needs to be set for both libc compilation + dependency compile_args
	libc_compile_flags += '-DDISABLE_UNIMPLEMENTED_LIBC_APIS'
endif

if enable_gnu_src
	# Note: This needs to be set for both libc compilation + dependency compile_args
	libc_compile_flags += '-D_GNU_SOURCE'
endif

###################
# Library Targets #
###################

# We don't build the stdio files for the native variant, as we rely on the
# System library to do the heavy lifting for missing symbols

libc_native = static_library(
	'c_native',
	libc_common_files + libc_native_files,
	c_args: libc_compile_flags,
	include_directories: [libc_includes, arch_specific_includes],
	dependencies: [libprintf_dep, openlibm_dep],
)

libc_native_dep = declare_dependency(
	include_directories: [
		libc_includes,
		arch_specific_includes,
		openlibm_includes,
		libprintf_includes
	],
	compile_args: libc_compile_flags,
	link_with: libc_native,
)
