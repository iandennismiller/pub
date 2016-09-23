# pub2 (c) Ian Dennis Miller

SHELL=/bin/bash
PROJECT_NAME=pub
MOD_NAME=pub
TEST_CMD=SETTINGS=$$PWD/etc/conf/testing.conf nosetests -w $(MOD_NAME)

install:
	python setup.py install

requirements:
	pip install -r requirements.txt

requirements-dev:
	pip install -r requirements-dev.txt

clean:
	rm -rf build dist *.egg-info
	find . -name '*.pyc' -delete
	find . -name __pycache__ -delete

watch:
	watchmedo shell-command -R -p "*.py" -c 'echo \\n\\n\\n\\nSTART; date; $(TEST_CMD) -c etc/nose/test-single.cfg; date' .

test:
	$(TEST_CMD) -c etc/nose/test.cfg

docs:
	rm -rf build/sphinx
	SETTINGS=$$PWD/etc/conf/testing.conf sphinx-build -b html docs build/sphinx

release:
	# first: python setup.py register
	python setup.py sdist upload

.PHONY: clean install test watch docs release requirements requirements-dev
