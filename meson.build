project('Embedded Artistry libc',
	['c', 'cpp'],
	default_options : [
		#'warning_level=3',
		'werror=false',
		'c_std=c11',
		'cpp_std=c++11',
	],
	license: 'MIT',
	meson_version: '>=0.52.0',
	version: '1.0')

################################
# Project Options and Settings #
################################

c_compiler = meson.get_compiler('c')

disable_unimplemented_apis = get_option('hide-unimplemented-libc-apis')
enable_gnu_src = get_option('enable-gnu-extensions')

## Left for demonstration purposes, removed in the next example.
# add_project_arguments('-Wno-unused-parameter', language: 'c')

add_project_arguments(
	c_compiler.get_supported_arguments(
		'-Wno-unknown-pragmas',
		'-Wno-nonnull',
		'-Wno-nonnull-compare',
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

libprintf_dep = declare_dependency(
	include_directories: libprintf_includes,
	link_with: libprintf,
)

printf_tests = executable('printf_tests',
	sources: files('subprojects/printf/test/test_suite.cpp'),
	include_directories: include_directories('subprojects/printf/test'),
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

# Toggling between system libraries and embedded sources
#cmocka_dep = dependency('cmocka', required: false, fallback: ['cmocka', 'cmocka_dep'])

# Alternative toogling, as there are conflict between generated libc header and build-in header
# So we use subproject instead
#cmocka_dep = dependency('cmocka', required : false)
#if not cmocka_dep.found()
cmocka_proj = subproject('cmocka')
cmocka_dep = cmocka_proj.get_variable('cmocka_dep')
#endif

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
