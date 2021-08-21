APP_sources = [
	'main.c'
]

executable('APP',
	APP_sources,
	dependencies: [
		utility_dep,
		libexample_dep,
	],
	install: false,
)

executable('APP_native',
	APP_sources,
	dependencies: [
		utility_native_dep,
		libexample_native_dep,
	],
	install: false,
	native: true
)

