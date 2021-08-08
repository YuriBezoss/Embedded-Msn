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

cmocka_dep = dependency('cmocka', required: false, fallback: ['cmocka', 'cmocka_dep'])

#######################
# Process Source Tree #
#######################

subdir('src')
subdir('test')
