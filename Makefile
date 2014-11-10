#
# Makefile to compile my Latex Project. 
#     Recursive Makefile
#
# The primary target are :
#
# <default>		Generate ps
# swoh_ps\		Generate and show ps
# show_pdf		Generate and show pdf
# pdf			Generate pdf
# clean			Clean up generated files by latex
#
# Author := dmike
# Email  := cipmiky@gmail.com
#

# Do not:
#* use make's built-in rules and variables;
#* print "Entering directory"
MAKEFLAGS += -rR --no-print-directory

# That's the default target
PHONY := _all
_all:

#Delete implicit rules on top Makefile
$(CURDIR)/Makefile Makefile: ;

PHONY += all
_all: all

project_name	     := $(filter-out %/,$(subst /,/ ,$(CURDIR)))
output_dir           := _build
source_root_dir	     := src/latex
source_latex_dir     := $(source_root_dir)/main
source_biber_dir     := $(source_root_dir)/bib
source_texmf_dir     := $(source_root_dir)/texmf
subdir_list_main     := 
subdir_list_texmf    := 
setting_latex        := 
setting_latex_beamer := 
VERSION		     :=

quiet = quiet_
Q     = @


#Look for make include files relative to root of the project
MAKEFLAGS += --include-dir=$(CURDIR)

# Include some basic definition.
Kbuild.include: ;
include Kbuild.include

shell		:= bash
CP		:= cp
MKDIR		:= mkdir -p
MV		:= mv
RM		:= rm -rf
LATEX		:= pdflatex
BIB		:= biber
DVIPS		:= dvips
PSPDF		:= ps2pdf
SETTINGS	:= -o
TEXFLAGS        := -file-line-error -output-directory=$(output_dir)

#Include an init project file in with you can redefine some variable like
#output_dir	      := yourDir
#source_root_dir      := yourDir
#source_latex_dir     := yourDir 
#setting_latex        := filename
#setting_latex_beamer := filename
#project_name 	      := name(default current Dir name)
#subdir_list_main     := all the subdir inside src/latex/main
#subdir_list_texmf    := all subdir of texmf dir in which you put
#                         .cls or .sty file
#VERSION     	      := VersionNumber
#
Initproject.include: ;
include Initproject.include

TEXMFHOME=$(source_texmf_dir)
export TEXMFHOME 

#
#Use as default ps viwer *gv*, you can change it setting by CMD line or in a
#init project file
#-----------------------------
ifeq "$(PS_VIEWER)" ""
ifeq "$(call file-exists, /usr/bin/gv)" ""
PS_VIEWER	:= evince
else
PS_VIEWER 	:= gv
endif
endif

#Use as default pdf viwer *evince*, you can change it setting by CMD line or
#in a init project file
#-----------------------------
ifeq "$(PDF_VIEWER)" ""
ifneq "$(call file-exists, /usr/bin/evince)" ""
PDF_VIEWER      := evince
else ifneq "$(call file-exists, /usr/bin/acroread)" ""
PDF_VIEWER	:= acroread
else
PDF_VIEWER	:= ghostscipt
endif
endif

_subdir_list_main  := $(addprefix $(source_latex_dir)/,$(subdir_list_main))
_subdir_list_texmf := $(addprefix $(TEXMFHOME)/,$(subdir_list_texmf))
bib_out  	   := 
ps_out  	   := $(output_dir)/$(project_name).ps
pdf_out 	   := $(subst ps,pdf,$(ps_out))
dvi_out 	   := $(subst ps,dvi,$(ps_out))
bib_source         := $(source_biber_dir)/$(project_name).bib
main_source        := $(source_latex_dir)/$(project_name).tex
all_source         := $(wildcard $(patsubst %,%/*.tex,$(_subdir_list_main))) \
			$(main_source)
all_texmf_file     := $(wildcard $(patsubst %,%/*,$(_subdir_list_texmf)))

ifneq "$(call file-exists, $(bib_source))" ""
bib_out := $(output_dir)/$(project_name).bcf
endif

# Using the latex compiler
ifeq "$(LATEX)" "latex"

# Primary target dependecies
all : $(ps_out)


#PDF-OUTPUT
PHONY += pdf
pdf : $(pdf_out)

#Build and show ps output
PHONY += show_ps
show_ps : $(ps_out)
	$(PS_VIEWER) $<

ifeq "$(MAKECMDGOALS)" "pdf"
.INTERMEDIATE: $(ps_out)
endif

# Generate the pdf file
#
$(pdf_out): $(ps_out)


# Generate ps format file
#

$(ps_out): $(dvi_out)

# Generate the dvi format file
#

$(dvi_out): $(bib_out) $(all_source) $(setting_latex)
	$(call latex-compile,$(main_source))
endif

#Using the pdflatex compiler
ifeq "$(LATEX)" "pdflatex"
# Primary target dependecies
all : $(pdf_out)

$(pdf_out):  $(bib_out) $(all_source) $(setting_latex) $(all_texmf_file)
	$(call latex-compile,$(main_source))
endif

$(bib_out): $(bib_source)
	$(call latex-biber-compile,$(main_source),$@)
$(SETTING_LATEX):

#Build and show pdf output
PHONY += show_pdf
show_pdf : $(pdf_out)
	$(PDF_VIEWER) $<


# %.pdf- Pattern rule to produce pdf output from ps input
%.pdf: %.ps
	$(PSPDF) $< $@

#%.ps- Pattern rule to produce ps output from dvi input
%.ps: %.dvi
	$(DVIPS) $(SETTINGS) $@ $<


# Rule to clean the main dir and all the subdirs.
#
#

Makefile.clean: ;
include Makefile.clean

PHONY += clean

clean: 
	$(call cmd,rmfiles)
	$(call cmd,rmdirs)


#
# Create output dir if it doesn't exist.
#
ifneq "$(MAKECMDGOALS)" "clean"
_create-out-dir :=    \
	$(if $(call file-exists,  \
	$(output_dir)),, \
	$(shell $(MKDIR) $(output_dir)))
endif

#Brief documentation of the typical target used
#---------------------------------------------------------------

PHONY += help
help:
	@echo ' Cleaning targets:'
	@echo ' clean		-Remove all the files in the current dir and in the subdirs except the source files and remove the outputfile too'
	@echo ''
	@echo ' Other generics targets:'
	@echo ' all		-build the document in pdf format using pdflatex'
	@echo ' show_ps        -build the document in ps format and show it with *evince*'
	@echo ' pdf		-build the document in pdf format'
	@echo ' show_pdf	-build the document in pdf format and show it with *acroread* (the linux program for AdobeReader)'
	@echo ' help		-print this Help Message'
	@echo ''

#--------------------------------------------------------------------
quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
      cmd_rmdirs = $(RM) $(rm-dirs)

quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
      cmd_rmfiles = $(RM) $(rm-files)

.PHONY: $(PHONY)
