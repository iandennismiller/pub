# pub2 (c) Ian Dennis Miller

SHELL=/bin/bash
MOD_NAME=pub2

install:
	python setup.py install

clean:
	rm -rf build dist *.egg-info
	find . -name '*.pyc' -delete
	find . -name __pycache__ -delete

docs:
	rm -rf build/sphinx
	sphinx-build -b html docs build/sphinx

watch:
	watchmedo shell-command -R -p "*.py" -c 'date; nosetests -w $(MOD_NAME) -c etc/tests.cfg; date' .

test:
	nosetests -w $(MOD_NAME) -c etc/tests.cfg

tox:
	tox

release:
	# first: python setup.py register -r https://pypi.python.org/pypi
	python setup.py sdist upload -r https://pypi.python.org/pypi

.PHONY: clean install test watch docs release tox
