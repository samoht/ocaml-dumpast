# Generated by Assemblage for dumpast 1c79aa.

# Run `make help' to get the list of targets.

.PHONY: all clean lib bin test doc distclean js help bin-ocaml-dumpast

#
# Main project configuration
#

BUILDIR     ?= _build
DUMPAST     ?= ocaml-dumpast
JS_OF_OCAML ?= js_of_ocaml
LIBDIR      ?= $(LIBDIR)
LN          ?= ln -sf
MKDIR       ?= mkdir -p
OCAMLMKLIB  ?= ocamlmklib
ROOTDIR     = $(shell pwd)
ifeq ($(HAS_NATIVE_TOOLCHAIN:true=),)
OCAMLC      ?= ocamlc.opt
OCAMLDEP    ?= ocamldep.opt
OCAMLDOC    ?= ocamldoc.opt
OCAMLOPT    ?= ocamlopt.opt
else
OCAMLC      ?= ocamlc
OCAMLDEP    ?= ocamldep
OCAMLDOC    ?= ocamldoc
OCAMLOPT    ?= ocamlopt
endif

HAS_ANNOT            ?= true
HAS_BYTE             ?= true
HAS_DEBUG            ?= true
HAS_DOC              ?= false
HAS_JS               ?= false
HAS_NATIVE           ?= true
HAS_NATIVE_DYNLINK   ?= true
HAS_NATIVE_TOOLCHAIN ?= true
HAS_TEST             ?= false
HAS_WARN_ERROR       ?= false

#
# Global variables
#

all            := lib bin
compile-byte   :=
compile-native :=
link-byte      :=
link-native    :=
ifeq ($(HAS_WARN_ERROR:true=),)
compile-byte   += -warn-error A-44-4-48 -w A-44-4-48
endif
ifeq ($(HAS_DEBUG:true=),)
compile-byte   += -g
compile-native += -g
link-byte      += -g
link-native    += -g
endif
ifeq ($(HAS_ANNOT:true=),)
compile-byte   += -bin-annot
endif

#
# Component configuration.
#
# Each component has variables associated to the different phases of the build.
# <NAME>.<PHASE> controls the compilation options for the component <NAME>,
# during the phase <PHASE>.
#

lib :=

bin := bin-ocaml-dumpast

js :=

# Binary: ocaml-dumpast
bin-ocaml-dumpast :=
ifeq ($(HAS_BYTE:true=),)
bin-ocaml-dumpast += $(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.byte
endif
ifeq ($(HAS_NATIVE:true=),)
bin-ocaml-dumpast += $(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.native
endif
bin-ocaml-dumpast.compile-byte ?=  \
    $(compile-byte) \
    -I $(BUILDIR)/bin-ocaml-dumpast \
    $(shell ocamlfind query -r -predicates byte -format "-I %d" -r compiler-libs.bytecomp \
            unix)
bin-ocaml-dumpast.compile-native ?=  \
    $(compile-native) \
    -I $(BUILDIR)/bin-ocaml-dumpast \
    $(shell ocamlfind query -r -predicates native -format "-I %d" -r compiler-libs.bytecomp \
            unix)
bin-ocaml-dumpast.dep ?=  \
    $(dep) \
    -I $(BUILDIR)/bin-ocaml-dumpast \
    $(shell ocamlfind query -r -predicates byte -format "-I %d" -r compiler-libs.bytecomp \
            unix)
bin-ocaml-dumpast.link-byte ?=  \
    $(link-byte) \
    $(shell ocamlfind query -r -predicates byte -format "%d/%a" -r compiler-libs.bytecomp \
            unix) \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cmo \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.cmo
bin-ocaml-dumpast.link-js ?= $(link-js)
bin-ocaml-dumpast.link-native ?=  \
    $(link-native) \
    $(shell ocamlfind query -r -predicates native -format "%d/%a" -r compiler-libs.bytecomp \
            unix) \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cmx \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.cmx
bin-ocaml-dumpast.pp-byte ?= $(pp-byte)
bin-ocaml-dumpast.pp-native ?= $(pp-native)

test :=

doc :=

OCAML_VERSION ?= 401

# Compilation unit: src/$(OCAML_VERSION)/parse_compat
unit-parse_compat-bin-ocaml-dumpast.compile-byte ?= $(bin-ocaml-dumpast.compile-byte)
unit-parse_compat-bin-ocaml-dumpast.compile-native ?= $(bin-ocaml-dumpast.compile-native)
unit-parse_compat-bin-ocaml-dumpast.dep ?= $(bin-ocaml-dumpast.dep)
unit-parse_compat-bin-ocaml-dumpast.pp-byte ?= $(bin-ocaml-dumpast.pp-byte)
unit-parse_compat-bin-ocaml-dumpast.pp-native ?= $(bin-ocaml-dumpast.pp-native)

# Compilation unit: src/dumpast
unit-dumpast-bin-ocaml-dumpast.compile-byte ?= $(bin-ocaml-dumpast.compile-byte)
unit-dumpast-bin-ocaml-dumpast.compile-native ?= $(bin-ocaml-dumpast.compile-native)
unit-dumpast-bin-ocaml-dumpast.dep ?= $(bin-ocaml-dumpast.dep)
unit-dumpast-bin-ocaml-dumpast.pp-byte ?= $(bin-ocaml-dumpast.pp-byte)
unit-dumpast-bin-ocaml-dumpast.pp-native ?= $(bin-ocaml-dumpast.pp-native)


all::
	@echo '[04mall[m [1;34m=>[m ${all}'
	@$(MAKE) $(all)
	@if [ "x${HAS_JS}" = "x1" ]; then $(MAKE) js; fi
	@if [ "x${HAS_TEST}" = "x1" ]; then $(MAKE) test; fi
	@if [ "x${HAS_DOC}" = "x1" ]; then $(MAKE) doc; fi
	@if [ "x${HAS_FULL_DOC}" = "x1" ]; then $(MAKE) full-doc; fi
	@echo '[32m==>[m Done!'

clean::
	rm -f *~ **/*~
	rm -rf $(BUILDIR)

distclean:: clean
	rm -f Makefile dumpast.install META

install:: all
	@opam-installer --prefix $(shell opam config var prefix) dumpast.install

help:
	@echo 'Use [04mVERBOSE=true[m to show the full commands.'
	@echo 'The following targets are available (use "make [04m<target>[m"):'
	@echo
	@echo ' - [04mall[m -- build all the active targets.'
	@echo ' - [04mbin-ocaml-dumpast[m -- build the executable ocaml-dumpast.'
	@echo ' - [04mdoc[m -- build the documentation.'
	@echo ' - [04mtest[m -- build and run the test.'
	@echo ' - [04mjs[m -- build the js_of_ocaml targets.'
	@echo ' - [04mclean[m -- clean the build artefacts.'
	@echo ' - [04mdistclean[m -- clean the project to prepare the release.'
	@echo
	@echo
	@echo 'Current configuration (use "make [04mVAR=BOOL[m" to modify):'
	@echo
	@echo ' - [04mHAS_ANNOT=$(HAS_ANNOT)[m -- Build OCaml binary annotations files.'
	@echo ' - [04mHAS_BYTE=$(HAS_BYTE)[m -- Byte code OCaml compilation is available.'
	@echo ' - [04mHAS_DEBUG=$(HAS_DEBUG)[m -- Build with debugging support.'
	@echo ' - [04mHAS_DOC=$(HAS_DOC)[m -- Build the documentation.'
	@echo ' - [04mHAS_JS=$(HAS_JS)[m -- JavaScript code OCaml compilation with js_of_ocaml is available.'
	@echo ' - [04mHAS_NATIVE=$(HAS_NATIVE)[m -- Native code OCaml compilation is available.'
	@echo ' - [04mHAS_NATIVE_DYNLINK=$(HAS_NATIVE_DYNLINK)[m -- Native code OCaml dynamic linking is available.'
	@echo ' - [04mHAS_NATIVE_TOOLCHAIN=$(HAS_NATIVE_TOOLCHAIN)[m -- The native compiled OCaml toolchain is available (.opt tools).'
	@echo ' - [04mHAS_TEST=$(HAS_TEST)[m -- Build the tests.'
	@echo ' - [04mHAS_WARN_ERROR=$(HAS_WARN_ERROR)[m -- Build with warnings as errors.'
	@echo

lib: $(lib)
	@

bin: $(bin)
	@

js: $(js)
	@

bin-ocaml-dumpast: $(bin-ocaml-dumpast)
	@

$(BUILDIR)/bin-ocaml-dumpast/:
	@if test -n "$$VERBOSE"; \
        then echo '$(MKDIR) $(BUILDIR)/bin-ocaml-dumpast'; \
        else echo 'bin-ocaml-dumpast         [32m<=[m [01mprepare[m bin-ocaml-dumpast'; fi
	@$(MKDIR) $(BUILDIR)/bin-ocaml-dumpast

$(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.byte:  \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cmo \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.cmo \
    | $(BUILDIR)/bin-ocaml-dumpast/
	@if test -n "$$VERBOSE"; \
        then echo '$(OCAMLC) $(bin-ocaml-dumpast.link-byte) -o $(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.byte'; \
        else echo 'ocaml-dumpast.byte        [32m<=[m [01mlink-byte[m bin-ocaml-dumpast'; fi
	@$(OCAMLC) $(bin-ocaml-dumpast.link-byte) -o $(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.byte

$(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.native:  \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cmx \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.cmx \
    | $(BUILDIR)/bin-ocaml-dumpast/
	@if test -n "$$VERBOSE"; \
        then echo '$(OCAMLOPT) $(bin-ocaml-dumpast.link-native) -o $(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.native'; \
        else echo 'ocaml-dumpast.native      [32m<=[m [01mlink-native[m bin-ocaml-dumpast'; fi
	@$(OCAMLOPT) $(bin-ocaml-dumpast.link-native) -o $(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.native

$(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.js: $(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.byte
	@if test -n "$$VERBOSE"; \
        then echo '$(JS_OF_OCAML) $(bin-ocaml-dumpast.link-js) $(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.js'; \
        else echo 'ocaml-dumpast.js          [32m<=[m [01mlink-js[m bin-ocaml-dumpast'; fi
	@$(JS_OF_OCAML) $(bin-ocaml-dumpast.link-js) $(BUILDIR)/bin-ocaml-dumpast/ocaml-dumpast.js

test: $(test)
	@

doc: $(doc)
	@

$(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml: src/$(OCAML_VERSION)/parse_compat.ml \
    | $(BUILDIR)/bin-ocaml-dumpast/
	@if test -n "$$VERBOSE"; \
        then echo '$(LN) $(ROOTDIR)/src/$(OCAML_VERSION)/parse_compat.ml $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml'; \
        else echo 'parse_compat.ml           [32m<=[m [01mprepare[m unit-parse_compat-bin-ocaml-dumpast'; fi
	@$(LN) $(ROOTDIR)/src/$(OCAML_VERSION)/parse_compat.ml $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml

$(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-byte: $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml
	@if test -n "$$VERBOSE"; \
        then echo '$(DUMPAST) camlp4o $(unit-parse_compat-bin-ocaml-dumpast.pp-byte) $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml > $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-byte'; \
        else echo 'parse_compat.cml-byte     [32m<=[m [01mpp-byte[m unit-parse_compat-bin-ocaml-dumpast'; fi
	@$(DUMPAST) camlp4o $(unit-parse_compat-bin-ocaml-dumpast.pp-byte) $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml > $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-byte

$(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-native: $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml
	@if test -n "$$VERBOSE"; \
        then echo '$(DUMPAST) camlp4o $(unit-parse_compat-bin-ocaml-dumpast.pp-native) $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml > $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-native'; \
        else echo 'parse_compat.cml-native   [32m<=[m [01mpp-native[m unit-parse_compat-bin-ocaml-dumpast'; fi
	@$(DUMPAST) camlp4o $(unit-parse_compat-bin-ocaml-dumpast.pp-native) $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml > $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-native

$(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml.d: $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-byte \
    |  \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml
	@if test -n "$$VERBOSE"; \
        then echo '$(OCAMLDEP) $(unit-parse_compat-bin-ocaml-dumpast.dep) -impl $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-byte > $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml.d'; \
        else echo 'parse_compat.ml.d         [32m<=[m [01mdep[m unit-parse_compat-bin-ocaml-dumpast'; fi
	@$(OCAMLDEP) $(unit-parse_compat-bin-ocaml-dumpast.dep) -impl $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-byte > $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml.d

$(BUILDIR)/bin-ocaml-dumpast/parse_compat.cmi $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cmo:  \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml.d \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-byte
	@if test -n "$$VERBOSE"; \
        then echo '$(OCAMLC) -c $(unit-parse_compat-bin-ocaml-dumpast.compile-byte) -impl $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-byte'; \
        else echo 'parse_compat.cmi parse_compat.cmo [32m<=[m [01mcompile-byte[m unit-parse_compat-bin-ocaml-dumpast'; fi
	@$(OCAMLC) -c $(unit-parse_compat-bin-ocaml-dumpast.compile-byte) -impl $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-byte

$(BUILDIR)/bin-ocaml-dumpast/parse_compat.cmx:  \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml.d \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cmi \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-native
	@if test -n "$$VERBOSE"; \
        then echo '$(OCAMLOPT) -c $(unit-parse_compat-bin-ocaml-dumpast.compile-native) -impl $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-native'; \
        else echo 'parse_compat.cmx          [32m<=[m [01mcompile-native[m unit-parse_compat-bin-ocaml-dumpast'; fi
	@$(OCAMLOPT) -c $(unit-parse_compat-bin-ocaml-dumpast.compile-native) -impl $(BUILDIR)/bin-ocaml-dumpast/parse_compat.cml-native

$(BUILDIR)/bin-ocaml-dumpast/dumpast.ml: src/dumpast.ml \
    | $(BUILDIR)/bin-ocaml-dumpast/
	@if test -n "$$VERBOSE"; \
        then echo '$(LN) $(ROOTDIR)/src/dumpast.ml $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml'; \
        else echo 'dumpast.ml                [32m<=[m [01mprepare[m unit-dumpast-bin-ocaml-dumpast'; fi
	@$(LN) $(ROOTDIR)/src/dumpast.ml $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml

$(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-byte: $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml
	@if test -n "$$VERBOSE"; \
        then echo '$(DUMPAST) camlp4o $(unit-dumpast-bin-ocaml-dumpast.pp-byte) $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml > $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-byte'; \
        else echo 'dumpast.cml-byte          [32m<=[m [01mpp-byte[m unit-dumpast-bin-ocaml-dumpast'; fi
	@$(DUMPAST) camlp4o $(unit-dumpast-bin-ocaml-dumpast.pp-byte) $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml > $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-byte

$(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-native: $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml
	@if test -n "$$VERBOSE"; \
        then echo '$(DUMPAST) camlp4o $(unit-dumpast-bin-ocaml-dumpast.pp-native) $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml > $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-native'; \
        else echo 'dumpast.cml-native        [32m<=[m [01mpp-native[m unit-dumpast-bin-ocaml-dumpast'; fi
	@$(DUMPAST) camlp4o $(unit-dumpast-bin-ocaml-dumpast.pp-native) $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml > $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-native

$(BUILDIR)/bin-ocaml-dumpast/dumpast.ml.d: $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-byte \
    |  \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml
	@if test -n "$$VERBOSE"; \
        then echo '$(OCAMLDEP) $(unit-dumpast-bin-ocaml-dumpast.dep) -impl $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-byte > $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml.d'; \
        else echo 'dumpast.ml.d              [32m<=[m [01mdep[m unit-dumpast-bin-ocaml-dumpast'; fi
	@$(OCAMLDEP) $(unit-dumpast-bin-ocaml-dumpast.dep) -impl $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-byte > $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml.d

$(BUILDIR)/bin-ocaml-dumpast/dumpast.cmi $(BUILDIR)/bin-ocaml-dumpast/dumpast.cmo:  \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml.d \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-byte
	@if test -n "$$VERBOSE"; \
        then echo '$(OCAMLC) -c $(unit-dumpast-bin-ocaml-dumpast.compile-byte) -impl $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-byte'; \
        else echo 'dumpast.cmi dumpast.cmo   [32m<=[m [01mcompile-byte[m unit-dumpast-bin-ocaml-dumpast'; fi
	@$(OCAMLC) -c $(unit-dumpast-bin-ocaml-dumpast.compile-byte) -impl $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-byte

$(BUILDIR)/bin-ocaml-dumpast/dumpast.cmx:  \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml.d \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.cmi \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-native
	@if test -n "$$VERBOSE"; \
        then echo '$(OCAMLOPT) -c $(unit-dumpast-bin-ocaml-dumpast.compile-native) -impl $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-native'; \
        else echo 'dumpast.cmx               [32m<=[m [01mcompile-native[m unit-dumpast-bin-ocaml-dumpast'; fi
	@$(OCAMLOPT) -c $(unit-dumpast-bin-ocaml-dumpast.compile-native) -impl $(BUILDIR)/bin-ocaml-dumpast/dumpast.cml-native

-include Makefile.assemble
ifneq ($(filter-out clean help distclean,$(MAKECMDGOALS)),)
-include  \
    $(BUILDIR)/bin-ocaml-dumpast/parse_compat.ml.d \
    $(BUILDIR)/bin-ocaml-dumpast/dumpast.ml.d
endif
include
