cmake_minimum_required(VERSION 4.1)
project(hackerrank_cpp_track)

set(CMAKE_CXX_STANDARD 20)

# If there is a root-level main.cpp keep it as a convenience target
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp")
    add_executable(root_main main.cpp
            solutions/input-output/main.cpp
            solutions/basic-dtypes/main.cpp
            solutions/playing-with-types/main.cpp
    )
endif()

# Auto-discover per-solution subfolders under `solutions/`
set(SOLUTIONS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/solutions")
if(EXISTS ${SOLUTIONS_DIR})
    file(GLOB SOL_FOLDERS RELATIVE ${SOLUTIONS_DIR} ${SOLUTIONS_DIR}/*)
    foreach(f ${SOL_FOLDERS})
        if(IS_DIRECTORY "${SOLUTIONS_DIR}/${f}")
            # If the solution provides its own CMakeLists.txt, prefer it
            if(EXISTS "${SOLUTIONS_DIR}/${f}/CMakeLists.txt")
                add_subdirectory("${SOLUTIONS_DIR}/${f}")
            elseif(EXISTS "${SOLUTIONS_DIR}/${f}/main.cpp")
                # Create a simple executable target named sol_<folder>
                string(REPLACE "-" "_" SOL_TARGET "${f}")
                add_executable(sol_${SOL_TARGET} "${SOLUTIONS_DIR}/${f}/main.cpp"
                        solutions/basic-dtypes/main.cpp
                        solutions/playing-with-types/main.cpp
                )
                target_compile_features(sol_${SOL_TARGET} PRIVATE cxx_std_20)
            endif()
        endif()
    endforeach()
endif()
