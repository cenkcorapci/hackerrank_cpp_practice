# hackerrank-cpp-track

Repository for practicing C++ algorithms. Organize each solution under `solutions/NNN-name/` where each folder contains a `main.cpp` and optional `CMakeLists.txt`.

Layout
------

- `solutions/NNN-short-name/` — each solution in its own folder (e.g. `001-hello`).
- `solutions/template/CMakeLists.txt` — template for per-solution CMake if you need custom flags.
- `CMakeLists.txt` (root) — auto-discovers `solutions/*` and creates executable targets prefixed with `sol_`.
- `Makefile` — convenience wrapper to configure and forward build targets to CMake.
- `scripts/run_solution` — helper script to configure, build and run a solution by folder name.
- `.github/workflows/ci.yml` — CI workflow that configures and builds the project on push/PR.

Quickstart (recommended)
------------------------

This quickstart shows the recommended out-of-source CMake workflow and the convenience `Makefile` usage. Commands are for fish/bash shells — copy-paste as-is.

1) Using the provided `Makefile` (convenient, generates build/ and forwards to CMake):

```bash
# Configure & build a single solution target (example: 001-hello)
make sol_001_hello

# Configure & build all targets
make all

# Use a different generator (e.g. Ninja)
make GENERATOR='Ninja' sol_001_hello
```

2) Manual out-of-source CMake (explicit, recommended when you want more control):

```bash
# Create a separate build dir and configure
mkdir -p build; cmake -S . -B build

# Build a single solution target (example target name: sol_001_hello)
cmake --build build --target sol_001_hello

# Run the binary
./build/sol_001_hello
```

3) Using the helper script (automates configure, build, run):

```bash
# make the script executable (one-time)
chmod +x scripts/run_solution

# build and run solution by folder name
./scripts/run_solution 001-hello
```

How targets are named
---------------------

- Folder `NNN-short-name` becomes CMake target `sol_NNN_short_name` (hyphens replaced with underscores).
- If a solution folder contains its own `CMakeLists.txt`, the root CMake will `add_subdirectory()` and use that file instead of creating a simple target.

Adding a new solution
---------------------

1. Create a folder `solutions/NNN-short-name` (e.g. `002-two-sum`).
2. Add a `main.cpp` containing your program.
3. Optionally add `CMakeLists.txt` inside the folder if you need to include additional sources or custom compile flags. Use `solutions/template/CMakeLists.txt` as a starting point.
4. Build with the Makefile or CMake as shown above — target will be `sol_NNN_short_name`.

Example
-------

See `solutions/001-hello` for a minimal example. Build it with `make sol_001_hello` or `cmake --build build --target sol_001_hello`.

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

Next steps (suggestions)
-----------------------

- Add more example problems under `solutions/` to seed the repo.
- Add an `all_solutions` CMake target that depends on all discovered `sol_*` targets (I can add this if you want).
- Add a CI step that runs each built executable and checks its output (useful for smoke tests).

If you'd like any of those, tell me which and I'll add them.
