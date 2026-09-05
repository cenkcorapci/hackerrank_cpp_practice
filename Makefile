# Convenience Makefile that configures build/ and forwards build targets to CMake
# Usage examples:
#   make configure            # configure build/ (default: Unix Makefiles)
#   make all                  # configure & build all targets
#   make sol_001_hello        # configure & build the specific target
#   make clean                # remove build artifacts

BUILD_DIR := build
CMAKE := cmake
GENERATOR ?= Unix Makefiles
CMAKE_CONFIG := $(CMAKE) -S . -B $(BUILD_DIR) -G "$(GENERATOR)"
CMAKE_BUILD := $(CMAKE) --build $(BUILD_DIR)

.PHONY: configure all clean help new-solution run-solution test-solution

configure:
	@echo "Configuring (generator: $(GENERATOR)) -> $(BUILD_DIR)"
	$(CMAKE_CONFIG)

all: configure
	@echo "Building all targets"
	$(CMAKE_BUILD)

new-solution:
	@if [ -z "$(name)" ]; then \
		echo "Usage: make new-solution name=<solution-name>"; \
		exit 1; \
	fi
	@if [ -e "solutions/$(name)" ]; then \
		echo "Error: solutions/$(name) already exists"; \
		exit 1; \
	fi
	@mkdir -p "solutions/$(name)"
	@printf '%s\n' '# CMake for solution $(name)' 'get_filename_component(SOL_DIR $${CMAKE_CURRENT_SOURCE_DIR} NAME)' 'string(REPLACE "-" "_" SOL_TARGET "$${SOL_DIR}")' 'add_executable(sol_$${SOL_TARGET} main.cpp)' 'target_compile_features(sol_$${SOL_TARGET} PRIVATE cxx_std_20)' > "solutions/$(name)/CMakeLists.txt"
	@printf '%s\n' '#include <iostream>' '' 'int main() {' '    std::cout << "Solution $(name): TODO" << std::endl;' '    return 0;' '}' > "solutions/$(name)/main.cpp"
	@echo "Created scaffold: solutions/$(name)/main.cpp"
	@echo "Created scaffold: solutions/$(name)/CMakeLists.txt"

run-solution:
	@if [ -z "$(name)" ]; then \
		echo "Usage: make run-solution name=<solution-name>"; \
		exit 1; \
	fi
	@TARGET=sol_$$(echo "$(name)" | tr '-' '_'); \
	BIN="./$(BUILD_DIR)/solutions/$(name)/$$TARGET"; \
	echo "Building $$TARGET"; \
	$(CMAKE_CONFIG) >/dev/null; \
	$(CMAKE_BUILD) --target "$$TARGET" && \
	echo "Running $$TARGET" && \
	"$$BIN"

test-solution:
	@if [ -z "$(name)" ]; then \
		echo "Usage: make test-solution name=<solution-name>"; \
		exit 1; \
	fi
	@TARGET=sol_$$(echo "$(name)" | tr '-' '_'); \
	BIN="./$(BUILD_DIR)/solutions/$(name)/$$TARGET"; \
	echo "Building $$TARGET (solution-specific test)"; \
	$(CMAKE_CONFIG) >/dev/null; \
	$(CMAKE_BUILD) --target "$$TARGET" && \
	echo "No dedicated tests found for $(name). Build+run check is used as the solution test." && \
	"$$BIN"

# Generic target forwarding: `make sol_001_hello` will configure (if needed) and build that target
%:
	@echo "Building target: $@"
	@$(CMAKE_CONFIG)
	$(CMAKE_BUILD) --target $@

clean:
	@echo "Cleaning build directory"
	-$(CMAKE) --build $(BUILD_DIR) --target clean || true
	rm -rf $(BUILD_DIR)

help:
	@echo "Usage: make <target>"
	@echo "  make configure    # Configure the build directory (uses $(GENERATOR))"
	@echo "  make all          # Configure and build all targets"
	@echo "  make new-solution name=002-two-sum  # Create a new solution scaffold"
	@echo "  make run-solution name=001-hello    # Build and run one solution"
	@echo "  make test-solution name=001-hello   # Run one solution's test command"
	@echo "  make sol_001_hello  # Configure and build the specific solution target"
	@echo "  make clean        # Clean build directory"
