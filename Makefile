.PHONY: all setup deploy clean help

GIT_ROOT := $(shell git rev-parse --show-toplevel)

all: help

build:
	hugo build --cleanDestinationDir

publish:
	cd ${GIT_ROOT}/public
	git add .
	git commit -m "Rebuild site $(date)"
	git push origin main

test:
	hugo server

help:
	@echo "Available targets:"
	@echo "  build   - Update local state"
	@echo "  publish - Publish local state to static repo"
	@echo "  test    - Run web server to display local state"
	@echo "  help    - Display this help message"
