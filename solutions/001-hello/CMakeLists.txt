# CMake for solution 001-hello
get_filename_component(SOL_DIR ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE "-" "_" SOL_TARGET "${SOL_DIR}")
add_executable(sol_${SOL_TARGET} main.cpp)
target_compile_features(sol_${SOL_TARGET} PRIVATE cxx_std_20)
