CXX_FLAGS = -std=c++20 -O3 -g -fsanitize=address -Iinclude

.PHONY: all
all:
	echo "Available targets: build, run, test, clean"


.PHONY: setup
setup:
	mkdir -p build

.PHONY: format_all
format_all:
	pre-commit run --all-files

.PHONY: build
build: setup
	g++ $(CXX_FLAGS) src/point.cpp -o build/point

.PHONY: run
run: build
	build/point

.PHONY: test
test: setup
	g++ $(CXX_FLAGS) src/point.cpp tests/test.cpp -o build/test_target
	build/test_target

.PHONY: lint-all
lint-all:
	run-clang-tidy -p=build ${CLANG_TIDY_FLAGS} $(FILES_TO_LINT)


.PHONY: clean
clean:
	rm -rf build
