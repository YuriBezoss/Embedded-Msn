project('PROJECT_NAME',
	['c', 'cpp'],
	default_options : [
		'warning_level=3',
		'werror=false',
		# This project defaults to a release build
		'debug=false',
		'optimization=2',
		# `build.*` options affect `native: true targets`
		# plain options affect `native: false` targets.
		'c_std=c11', 'build.c_std=c11',
		'cpp_std=c++17', 'build.cpp_std=c++17',
	],
	meson_version: '>=0.52.0',
	version: '0.1'
)

################################
# Project Options and Settings #
################################

# Pick up our common compiler variables + desired_*_flags variables
subdir('build/compiler')
subdir('build/compiler/c')
subdir('build/compiler/cpp')

if get_option('debug')
	add_project_arguments('-DDEBUG',
		language: ['c', 'cpp'])
	add_project_arguments('-DDEBUG',
		language: ['c', 'cpp'], native: true)
endif

if get_option('disable-builtins')
	desired_common_compile_flags += '-fno-builtin'
endif

if get_option('disable-stack-protection')
	desired_common_compile_flags += '-fno-stack-protector'
endif

if get_option('disable-rtti')
	desired_cpp_compile_flags += '-fno-rtti'
endif

if get_option('disable-exceptions')
	desired_cpp_compile_flags += ['-fno-exceptions', '-fno-unwind-tables']
endif

if get_option('enable-pedantic')
	desired_common_compile_flags += '-pedantic'
else
	desired_common_compile_flags += '-Wno-pedantic'
endif

if get_option('enable-pedantic-error')
	desired_common_compile_flags += '-pedantic-error'
endif

compile_settings_list = [
	{'lang': 'c', 'compiler': host_c_compiler, 'flags': desired_c_compile_flags, 'isnative': false},
	{'lang': 'c', 'compiler': native_c_compiler, 'flags': desired_native_c_compile_flags, 'isnative': true},
	{'lang': 'cpp', 'compiler': host_cpp_compiler, 'flags': desired_cpp_compile_flags, 'isnative': false},
	{'lang': 'cpp', 'compiler': native_cpp_compiler, 'flags': desired_native_cpp_compile_flags, 'isnative': true},
]

# Process the compilation flags
subdir('build/compiler/check-and-apply-flags')

#################
# Build Modules #
#################

# Include reusable build modules here via subdir() calls
subdir('build/modules/linker-script-as-property')
subdir('build/modules/linker-map')

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

# Add files to this variable if you want them analyzed by clang-tidy
files_to_lint = []

subdir('src')
subdir('test')

##################
# Custom Targets #
##################

run_target('clear-test-results',
	command: meson.source_root() + '/tools/clear_test_xml.sh'
)

doxygen = find_program('doxygen', required: false, disabler: true)
run_target('docs',
	command: [doxygen, 'docs/Doxyfile'])

clangformat = find_program('clang-format', required: false, disabler: true)
if clangformat.found()
	run_target('format',
		command: 'tools/format.sh')

	run_target('format-patch',
		command: 'tools/format-patch.sh')
endif

cppcheck = find_program('cppcheck', required: false, disabler: true)
if cppcheck.found()
	run_target('cppcheck',
		command: 'tools/cppcheck.sh'
	)

	run_target('cppcheck-xml',
		command: [
			'tools/cppcheck.sh',
			'xml'
		],
	)
endif

clangtidy = find_program('clang-tidy', required: false, disabler: true)
if clangtidy.found()
	run_target('clang-tidy',
		command: [
			'tools/clang-tidy.sh',
			# Files,
			files_to_lint
		],
	)
endif

lizard_default_args = [
	# Exclude these Directories
	'-x', './buildresults/*',
	'-x', './subprojects/*',
	# Configuration
	'--length', '75', # Fail when functions are longer than this
	'--CCN', '10', # Fail over this CCN
	'--arguments', '10', # Fail at this arg count
]

lizard = find_program('lizard', required: false, disabler: true)
run_target('complexity',
	command: [lizard,
		lizard_default_args,
		'-w'
	]
)

run_target('complexity-full',
	command: [lizard,
		lizard_default_args
	]
)

complexity_xml = custom_target('complexity.xml',
	output: 'complexity.xml',
	command: [
		lizard,
		lizard_default_args,
		'--xml'
	],
	capture: true,
	build_always_stale: true,
	build_by_default: false,
)

alias_target('complexity-xml', complexity_xml)

#############
# Packaging #
#############

run_target('package',
	command: [
		'tools/package.sh',
		'-a', host_machine.cpu_family(),
		'-c', host_machine.cpu(),
		'-s', host_machine.system(),
		'-v', meson.project_version()
	]
)

run_target('package-native',
	command: [
		'tools/package.sh',
		'-a', build_machine.cpu_family(),
		'-c', build_machine.cpu(),
		'-s', build_machine.system(),
		'-v', meson.project_version(),
		'-n' # Use Native Files
	]
)

