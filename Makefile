# you can set this to 1 to see all commands that are being run
VERBOSE ?= 0

ifeq ($(VERBOSE),1)
export Q :=
export VERBOSE := 1
else
export Q := @
export VERBOSE := 0
endif

BUILDRESULTS ?= buildresults
SUBPROJECT_DEP = subprojects/printf
CONFIGURED_BUILD_DEP = $(BUILDRESULTS)/build.ninja

# Override to provide your own settings to the shim
OPTIONS ?=
LTO ?= 0
CROSS ?=
INTERNAL_OPTIONS =

ifeq ($(LTO),1)
	INTERNAL_OPTIONS += -Db_lto=true -Ddisable-builtins=true
endif

ifneq ($(CROSS),)
	# Split into two strings, first is arch, second is chip
	CROSS_2 := $(subst :, ,$(CROSS))
	INTERNAL_OPTIONS += --cross-file=build/cross/$(word 1, $(CROSS_2)).txt --cross-file=build/cross/$(word 2, $(CROSS_2)).txt
endif

all: default

.PHONY: default
default: | $(CONFIGURED_BUILD_DEP)
	$(Q)ninja -C $(BUILDRESULTS)

# Manually Reconfigure a target, esp. with new options
.PHONY: reconfig
reconfig:
	$(Q) meson $(BUILDRESULTS) --reconfigure $(INTERNAL_OPTIONS) $(OPTIONS)

# Runs whenever the build has not been configured successfully
$(CONFIGURED_BUILD_DEP): | $(SUBPROJECT_DEP)
	$(Q) meson $(BUILDRESULTS) $(INTERNAL_OPTIONS) $(OPTIONS)

# This prerequisite will download subprojects if they don't exist
$(SUBPROJECT_DEP):
	$(Q) meson subprojects download

.PHONY: cppcheck
cppcheck: | $(CONFIGURED_BUILD_DEP)
	$(Q) ninja -C $(BUILDRESULTS) cppcheck

.PHONY: cppcheck-xml
cppcheck-xml: | $(CONFIGURED_BUILD_DEP)
	$(Q) ninja -C $(BUILDRESULTS) cppcheck-xml

.PHONY: clean
clean:
	$(Q) if [ -d "$(BUILDRESULTS)" ]; then ninja -C buildresults clean; fi

.PHONY: distclean
distclean:
	$(Q) rm -rf $(BUILDRESULTS)

### Help Output ###
.PHONY : help
help :
	@echo "usage: make [OPTIONS] <target>"
	@echo "  Options:"
	@echo "    > VERBOSE Show verbose output for Make rules. Default 0. Enable with 1."
	@echo "    > BUILDRESULTS Directory for build results. Default buildresults."
	@echo "    > OPTIONS Configuration options to pass to a build. Default empty."
	@echo "    > LTO Enable LTO builds. Default 0. Enable with 1."
	@echo "    > CROSS Enable a Cross-compilation build. Form is arch:chip."
	@echo "			Example: make CROSS=arm:cortex-m3"
	@echo "			For supported chips, see build/cross/"
	@echo "Targets:"
	@echo "  default: Builds all default targets ninja knows about"
	@echo "  clean: cleans build artifacts, keeping build files in place"
	@echo "  distclean: removes the configured build output directory"
	@echo "  reconfig: Reconfigure an existing build output folder with new settings"
	@echo "Static Analysis:"
	@echo "    cppcheck: runs cppcheck"
	@echo "    cppcheck-xml: runs cppcheck and generates an XML report (for build servers)"

