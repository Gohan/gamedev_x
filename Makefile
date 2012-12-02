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
	uglifyjs ${DEMOPATH}/js/bootstrap.js -nc > ${DEMOPATH}/js/bootstrap.min.tmp.js

debug:
	mkdir -p ${DEMOPATH}/css
	lessc ${BOOTSTRAP_LESS} > ${DEMOPATH}/css/style.css
	lessc --compress ${BOOTSTRAP_LESS} > ${DEMOPATH}/css/style.min.css
	cat js/libs/bootstrap/transition.js js/libs/bootstrap/alert.js js/libs/bootstrap/button.js js/libs/bootstrap/carousel.js js/libs/bootstrap/collapse.js js/libs/bootstrap/dropdown.js js/libs/bootstrap/modal.js js/libs/bootstrap/tooltip.js js/libs/bootstrap/popover.js js/libs/bootstrap/scrollspy.js js/libs/bootstrap/tab.js js/libs/bootstrap/typeahead.js > ${DEMOPATH}/js/bootstrap.js
	uglifyjs -nc ${DEMOPATH}/js/bootstrap.js > ${DEMOPATH}/js/bootstrap.min.tmp.js
	uglifyjs -nc ${DEMOPATH}/js/script.js > ${DEMOPATH}/js/script.min.js
	mustache debug.yml index.tmpl > index.html

publish:
	mkdir -p ${DEMOPATH}/css
	lessc ${BOOTSTRAP_LESS} > ${DEMOPATH}/css/style.css
	lessc --compress ${BOOTSTRAP_LESS} > ${DEMOPATH}/css/style.min.css
	cat js/libs/bootstrap/transition.js js/libs/bootstrap/alert.js js/libs/bootstrap/button.js js/libs/bootstrap/carousel.js js/libs/bootstrap/collapse.js js/libs/bootstrap/dropdown.js js/libs/bootstrap/modal.js js/libs/bootstrap/tooltip.js js/libs/bootstrap/popover.js js/libs/bootstrap/scrollspy.js js/libs/bootstrap/tab.js js/libs/bootstrap/typeahead.js > ${DEMOPATH}/js/bootstrap.js
	uglifyjs ${DEMOPATH}/js/bootstrap.js -nc > ${DEMOPATH}/js/bootstrap.min.tmp.js

	mustache publish.yml ${DEMOPATH}/js/script.tmpl > ${DEMOPATH}/js/script.js
	uglifyjs ${DEMOPATH}/js/script.js -nc > ${DEMOPATH}/js/script.min.js
	mustache publish.yml index.tmpl > index.tmp.html
	mustache publish.yml cgi/config.tmpl > cgi/config.py
	java -jar htmlcompressor-1.5.3.jar -o index.html index.tmp.html

.PHONY: demo debug publish
