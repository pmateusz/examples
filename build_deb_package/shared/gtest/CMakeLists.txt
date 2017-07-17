cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(libgtest-dev LANGUAGES CXX VERSION 1.8.0)

include(ExternalProject)
include(/shared/Utils.cmake)

# build directory
set(gtest_PREFIX ${CMAKE_BINARY_DIR}/external/gtest-prefix)
# install directory
set(gtest_INSTALL ${CMAKE_BINARY_DIR}/external/gtest-install)

# we build gtest statically
if (UNIX)
  set(GTEST_EXTRA_COMPILER_FLAGS "-fPIC")
endif ()

set(GTEST_CXX_FLAGS ${CMAKE_CXX_FLAGS} ${GTEST_EXTRA_COMPILER_FLAGS})
set(GTEST_C_FLAGS ${CMAKE_C_FLAGS} ${GTEST_EXTRA_COMPILER_FLAGS})

ExternalProject_Add(gtest
  PREFIX ${gtest_PREFIX}
  URL https://github.com/google/googletest/archive/release-1.8.0.zip
  URL_HASH SHA1=667f873ab7a4d246062565fad32fb6d8e203ee73
  UPDATE_COMMAND ""
  INSTALL_DIR ${gtest_INSTALL}
  CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_INSTALL_PREFIX=${gtest_INSTALL}
    -DBUILD_SHARED_LIBS=OFF
    -DBUILD_STATIC_LIBS=ON
    -DBUILD_TESTING=OFF
    -DBUILD_NC_TESTS=OFF
    -DBUILD_PACKAGING=OFF
    -BUILD_CONFIG_TESTS=OFF
    -DINSTALL_HEADERS=ON
    -DCMAKE_C_FLAGS=${GTEST_C_FLAGS}
    -DCMAKE_CXX_FLAGS=${GTEST_CXX_FLAGS}
  LOG_DOWNLOAD 1
  LOG_CONFIGURE 1
  LOG_INSTALL 1)

install(DIRECTORY ${gtest_INSTALL}/include/gtest/ DESTINATION include/gtest
  FILES_MATCHING  PATTERN "*.h"
                  PATTERN "*.pump")

install(DIRECTORY ${gtest_INSTALL}/lib/ DESTINATION lib
  FILES_MATCHING  PATTERN "libgtest*"
                  PATTERN "libgmock*"
                  PATTERN "cmake" EXCLUDE
                  PATTERN "pkgconfig" EXCLUDE)
              
if(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")
  include(InstallRequiredSystemLibraries)

  add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package)

  set(CPACK_SET_DESTDIR "on")
  set(CPACK_PACKAGING_INSTALL_PREFIX "/tmp")

  set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
  set(CPACK_PACKAGE_VENDOR "google")
  set(CPACK_PACKAGE_CONTACT "mateusz.polnik at strath.ac.uk")
  set(CPACK_PACKAGE_DESCRIPTION "Google's C++ test framework")
  set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${CPACK_PACKAGE_DESCRIPTION})

  set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})

  if(UNIX)
    list(APPEND CPACK_GENERATOR "DEB")

    m_get_architecture(_OS_ARCH)
    mark_as_advanced(_OS_ARCH)

    m_get_os_name(_OS_NAME)
    mark_as_advanced(_OS_NAME)

    set(CPACK_DEBIAN_REVISON "${_OS_NAME}")
    set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CPACK_DEBIAN_REVISON}_${_OS_ARCH}")
    set(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
    set(CPACK_DEBIAN_COMPRESSION_TYPE "gzip")
    set(CPACK_DEBIAN_PACKAGE_DEPENDS "")
  endif()

  include(CPack)
endif()