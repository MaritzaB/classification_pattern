reports: \
	reports/tarea_01.pdf

.PHONY: \
	all \
	clean \
	format \
	tests

define renderLatex
    cd $(<D) && pdflatex $(<F)
	cd $(<D) && pdflatex $(<F)
endef

define lint
	pylint \
        --disable=missing-class-docstring \
        --disable=missing-function-docstring \
        --disable=missing-module-docstring \
		--function-naming-style=camelCase \
        ${1}
endef

reports/tarea_01.pdf: reports/tarea_01.tex
	$(renderLatex)

clean:
	rm --force reports/*.aux
	rm --force reports/*.bbl
	rm --force reports/*.blg
	rm --force reports/*.log
	rm --force reports/*.out
	rm --force reports/*.pdf
	rm --force reports/*.toc

format:
	black --line-length 80 src/*.py

linter:
	$(call lint, src)
	$(call lint, tests)

tests:
	pytest --verbose tests/
