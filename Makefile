.PHONY: all clean build publish bump test help

GIT_ROOT := $(shell git rev-parse --show-toplevel)

all: help

set-msg:
	@read -p "Enter commit message: " msg \
	&& GIT_COMMIT_MSG=$$msg

clean:
	cd $(GIT_ROOT) \
	&& find public/ -mindepth 1 -not -name '.git' -not -name '.gitignore' -not -name 'CNAME' -exec rm -rf {} +

build: clean
	cd $(GIT_ROOT)/public/ \
	&& git fetch origin && git reset --hard origin/main && git clean -fd
	hugo build

publish: build set-msg
	cd $(GIT_ROOT)/public/ \
	&& git add . \
	&& git commit -m "$$msg" \
	&& git push origin main \
	&& git log --graph --oneline

update: publish
	cd $(GIT_ROOT) \
	&& git add . \
	&& git commit -m "$$msg" \
	&& git push origin main \
	&& git log --graph --oneline

test: build
	hugo server

help:
	@echo "Available targets:"
	@echo "  build   - Generate static files to serve"
	@echo "  publish - Publish local state to static repo"
	@echo "  bump    - Bump submodule"
	@echo "  test    - Run web server to display local state"
	@echo "  help    - Display this help message"
