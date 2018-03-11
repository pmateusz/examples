cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(demo LANGUAGES C CXX VERSION 0.0.1)
set(CMAKE_VERBOSE_MAKEFILE FALSE)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

if (CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_C_FLAGS_DEBUG "-g -ggdb -pg -fsanitize=undefined")
    set(CMAKE_C_FLAGS_RELEASE "-O2")
    set(CMAKE_CXX_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
    set(CMAKE_CXX_FLAGS_RELEASE ${CMAKE_C_FLAGS_RELEASE})
endif ()
set(CMAKE_BUILD_TYPE RELEASE)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/Modules/")
find_package(Scip REQUIRED)
find_package(Threads REQUIRED)

get_filename_component(HEADERS src REALPATH)
include_directories(${HEADERS} ${SCIP_INCLUDE_DIRS})

file(GLOB_RECURSE SOURCES src/*.c)
add_library(demo STATIC ${SOURCES})

add_executable(demo-main src/cmain.c)
target_link_libraries(demo-main demo ${SCIP_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
add_dependencies(demo-main demo)