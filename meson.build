project('Embedded Artistry libc',
	'c',
	default_options : [
		'c_std=c11'
	],
	license: 'MIT',
	meson_version: '>=0.52.0',
	version: '1.0')

#############################
# Printf Dependency Targets #
#############################

printf_files = files('subprojects/printf/printf.c')
printf_includes = include_directories('subprojects/printf', is_system: true)

libprintf = static_library(
	'printf',
    printf_files,
    include_directories: printf_includes,
)

libprintf_dep = declare_dependency(
	include_directories: printf_includes,
	link_with: libprintf,
)

#############################
# openlibm Dependency Targets #
#############################

#openlibm_files = files('subprojects/openlibm/')
openlibm_includes = include_directories(
	'subprojects/openlibm/include/',
	'subprojects/openlibm/src/', 
	is_system: true)

'''libopenlibm = static_library(
	'openlibm',
    printf_files,
    include_directories: openlibm_includes,
)'''

libopenlibm_dep = declare_dependency(
	include_directories: openlibm_includes,
	#link_with: libopenlibm,
)

#######################
# Process Source Tree #
#######################

subdir('src')
