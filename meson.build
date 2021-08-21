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

native_c_compiler = meson.get_compiler('c', native: true)
host_c_compiler = meson.get_compiler('c', native: false)
native_c_compiler_id = native_c_compiler.get_id()
host_c_compiler_id = host_c_compiler.get_id()

disable_unimplemented_apis = get_option('hide-unimplemented-libc-apis')
disable_builtins = get_option('disable-builtins')
disable_stack_protection = get_option('disable-stack-protection')
enable_gnu_src = get_option('enable-gnu-extensions')
debug = get_option('debug')

if debug
	debug_flags = ['-DDEBUG']
	add_project_arguments(debug_flags, language: ['c', 'cpp'])
	add_project_arguments(debug_flags, language: ['c', 'cpp'], native: true)
endif

project_arguments = [
	'-Wno-unknown-pragmas',
	'-Wno-nonnull',
	'-Wno-nonnull-compare'
]

add_project_arguments(
	host_c_compiler.get_supported_arguments(project_arguments),
	language: 'c'
)

add_project_arguments(
	native_c_compiler.get_supported_arguments(project_arguments),
	language: 'c',
	native: true
)

###################
# Build Templates #
###################

# This format string template can be used to declare a map file
# with an executable when using GCC, Clang, or MSVC
# Use it like:
#	link_args: host_map_file.format(meson.current_build_dir() + '/libc_test')

if native_c_compiler.has_link_argument('-Wl,-map,test.map')
	native_map_file = '-Wl,-map,@0@.map'
elif native_c_compiler.has_link_argument('-Wl,-Map,test.map')
	native_map_file = '-Wl,-Map,@0@.map'
else
	warning('Native toolchain does not support Map file generation')
	native_map_file = []
endif


if host_c_compiler.has_link_argument('-Wl,-Map,test.map')
	host_map_file = '-Wl,-Map,@0@.map'
elif host_c_compiler.has_link_argument('-Wl,-map,test.map')
	host_map_file = '-Wl,-map,@0@.map'
elif host_c_compiler.has_multi_link_arguments('--specs=nosys.specs', '-Wl,-Map,test.map')
	# arm-gcc will fail the check without --specs=nosys.specs
	host_map_file = '-Wl,-Map,@0@.map'
else
	warning('Host toolchain does not support Map file generation')
	host_map_file = []
endif


# The map_file variable is a simplified alias to host_map_file
map_file = host_map_file

##########################
# Architecture Detection #
##########################

subdir('arch')

#############################
# Printf Dependency Targets #
#############################

libprintf_files = files('subprojects/printf/printf.c')
libprintf_includes = include_directories('subprojects/printf', is_system: true)

printf_dep = declare_dependency(
	include_directories: libprintf_includes,
	sources: libprintf_files,
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

cmocka_native_dep = dependency('cmocka', native: true, fallback: ['cmocka', 'cmocka_native_dep'])

# Handle case where Linux fails to build because cmocka.h can't be found due to `-nostdinc`:
if cmocka_native_dep.type_name() != 'internal' and \
	false == native_c_compiler.has_header('cmocka.h',
		args: '-nostdinc',
		dependencies: cmocka_native_dep.partial_dependency(compile_args: true))

	# Header isn't found with `-nostdinc`, even though library is: revert to subproject
	cmocka_subproject = subproject('cmocka')
	cmocka_native_dep = cmocka_subproject.get_variable('cmocka_native_dep')
endif

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
