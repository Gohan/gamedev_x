BOOTSTRAP = ./css/style.css
BOOTSTRAP_LESS = ./less/style.less
LESS_COMPRESSOR ?= `which lessc`
WATCHR ?= `which watchr`

#
# BUILD DOCS
#

DEMOPATH = .
demo:
	mkdir -p ${DEMOPATH}/css
	lessc ${BOOTSTRAP_LESS} > ${DEMOPATH}/css/style.css
	lessc --compress ${BOOTSTRAP_LESS} > ${DEMOPATH}/css/style.min.css
	cat js/libs/bootstrap/transition.js js/libs/bootstrap/alert.js js/libs/bootstrap/button.js js/libs/bootstrap/carousel.js js/libs/bootstrap/collapse.js js/libs/bootstrap/dropdown.js js/libs/bootstrap/modal.js js/libs/bootstrap/tooltip.js js/libs/bootstrap/popover.js js/libs/bootstrap/scrollspy.js js/libs/bootstrap/tab.js js/libs/bootstrap/typeahead.js > ${DEMOPATH}/js/bootstrap.js
	uglifyjs -nc ${DEMOPATH}/js/bootstrap.js > ${DEMOPATH}/js/bootstrap.min.tmp.js

.PHONY: demo
