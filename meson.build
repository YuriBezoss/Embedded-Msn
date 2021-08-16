project('Embedded Artistry libc',
	['c', 'cpp'],
	default_options : [
		'warning_level=3',
		'werror=false',
		'debug=true',
		'optimization=g',
		# `build.*` options affect `native: true targets`
		# plain options affect `native: false` targets.
		'c_std=c11', 'build.c_std=c11',
		'cpp_std=c++11', 'build.cpp_std=c++11',
	],
	license: 'MIT',
	meson_version: '>=0.52.0',
	version: '1.0'
)

################################
# Project Options and Settings #
################################

c_compiler = meson.get_compiler('c')

disable_unimplemented_apis = get_option('hide-unimplemented-libc-apis')
enable_gnu_src = get_option('enable-gnu-extensions')
debug = get_option('debug')
disable_builtins = get_option('disable-builtins')
disable_stack_protection = get_option('disable-stack-protection')

if debug
	add_project_arguments('-DDEBUG', '-DGDTOA_HOST_DEBUG',
		language: ['c', 'cpp'])
endif

add_project_arguments(
	c_compiler.get_supported_arguments(
		'-Wno-unknown-pragmas',
		'-Wno-nonnull',
		'-Wno-nonnull-compare'
	),
	language: 'c'
)

#############################
# Printf Dependency Targets #
#############################

libprintf_files = files('subprojects/printf/printf.c')
libprintf_includes = include_directories('subprojects/printf', is_system: true)

libprintf = static_library(
	'printf',
    libprintf_files,
    include_directories: libprintf_includes,
)

libprintf_native = static_library(
	'printf_native',
    libprintf_files,
    include_directories: libprintf_includes,
    native: true
)

libprintf_dep = declare_dependency(
	include_directories: libprintf_includes,
	link_with: libprintf,
)

libprintf_native_dep = declare_dependency(
	include_directories: libprintf_includes,
	link_with: libprintf_native,
)

printf_tests = executable('printf_tests',
	sources: files('subprojects/printf/test/test_suite.cpp'),
	include_directories: include_directories('subprojects/printf/test'),
	native: true
)

test('printf_tests',
	printf_tests,
	args: ['-s', '-r', 'junit', '-o', meson.build_root() + '/test/printf_tests.xml']
)

run_target('printf-tests',
	command: printf_tests
)

run_target('printf-tests-xml',
	command: [printf_tests, '-s', '-r', 'junit', '-o', meson.build_root() + '/test/printf_tests.xml']
)

###############################
# Openlibm Dependency Targets #
###############################

openlibm_includes = include_directories(
	'subprojects/openlibm/include',
	'subprojects/openlibm/src',
	is_system: true
)

openlibm_dep = declare_dependency(
	include_directories: openlibm_includes,
)

#####################
# CMocka Dependency #
#####################

cmocka_native_dep = dependency('cmocka', native: true, required: false,
	fallback: ['cmocka', 'cmocka_native_dep'])

# Uncomment if your build fails on Linux with CMocka installed due to -nostdinc,
# and remove the line above.
# cmocka_subproject = subproject('cmocka')
# cmocka_native_dep = cmocka_subproject.get_variable('cmocka_native_dep')

#######################
# Process Source Tree #
#######################

subdir('src')
subdir('test')

##################
# Custom Targets #
##################

run_target('clear-test-results',
	command: meson.source_root() + '/tools/clear_test_xml.sh'
)
