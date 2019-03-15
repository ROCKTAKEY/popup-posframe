EMACS ?= emacs
TESTINGFILE := $(wildcard test/*.el)
TESTEDFILES := $(wildcard ./*.el)
CASK ?= cask

test:
	${CASK} exec ${EMACS} -batch -Q -L . -l ${TESTINGFILE} -f  ert-run-tests-batch-and-exit

travis:
	${MAKE} clean
	${MAKE} test
	${MAKE} compile
	${MAKE} test
	${MAKE} clean

compile:
	${CASK} exec ${EMACS} -batch -Q -L . -eval "(batch-byte-compile)" ${TESTEDFILES}

clean:
	rm -f -r *.elc

.PHONY: test travis compile clean
