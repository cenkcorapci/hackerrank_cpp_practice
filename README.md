# hackerrank-cpp-track

Repository for practicing C++ algorithms. Organize each solution under `solutions/NNN-name/` where each folder contains a `main.cpp` and `CMakeLists.txt`.

Layout
------

- `solutions/NNN-short-name/` — each solution in its own folder (e.g. `001-hello`).
- `solutions/template/CMakeLists.txt` — template for per-solution CMake if you need custom flags.
- `CMakeLists.txt` (root) — auto-discovers `solutions/*` and creates executable targets prefixed with `sol_`.
- `Makefile` — convenience wrapper to configure and forward build targets to CMake.
- `scripts/run_solution` — helper script to configure, build and run a solution by folder name.
- `.github/workflows/ci.yml` — CI workflow that configures and builds the project on push/PR.

Quickstart
----------

This quickstart shows the recommended out-of-source CMake workflow and the convenience `Makefile` usage. Commands are for fish/bash shells — copy-paste as-is.

Using the provided `Makefile`:

```bash
# Create a runnable solution scaffold
make new-solution name=002-two-sum

# Build and run one solution by folder name
make run-solution name=001-hello

# Run the solution-specific test command
make test-solution name=001-hello

# Build a specific CMake target directly
make sol_001_hello

# Build all targets
make all
```

Manual out-of-source CMake:

```bash
# Create a separate build dir and configure
mkdir -p build; cmake -S . -B build

# Build a single solution target (example target name: sol_001_hello)
cmake --build build --target sol_001_hello

# Run the binary
./build/solutions/001-hello/sol_001_hello
```

How targets are named
---------------------

- Folder `NNN-short-name` becomes CMake target `sol_NNN_short_name` (hyphens replaced with underscores).
- If a solution folder contains its own `CMakeLists.txt`, the root CMake will `add_subdirectory()` and use that file.

Adding a new solution
---------------------

```bash
make new-solution name=002-two-sum
```

This creates:
- `solutions/002-two-sum/main.cpp`
- `solutions/002-two-sum/CMakeLists.txt`

Then run it:

```bash
make run-solution name=002-two-sum
```

Example
-------

See `solutions/001-hello` for a minimal example.

CI
--

A GitHub Actions workflow is included at `.github/workflows/ci.yml`.
- It runs on push and pull request to `main`/`master`.
- It installs `cmake`, `ninja-build`, and `build-essential` on Ubuntu, configures with Ninja, and builds all targets.

Tips and troubleshooting
------------------------

- "make: Makefile: No such file or directory" — means you ran `make` in a directory that doesn't have a Makefile. Use the `Makefile` at the project root (run `make` in the repo root) or run CMake to generate build files in a `build/` directory as shown above.
- If `cmake` is not found, install it:
  - macOS (Homebrew): `brew install cmake` 
  - Ubuntu: `sudo apt-get update && sudo apt-get install -y cmake`
- Prefer out-of-source builds (keep your repo clean): `cmake -S . -B build`.
