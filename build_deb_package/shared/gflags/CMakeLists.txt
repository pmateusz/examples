cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(libgflags-dev LANGUAGES C CXX VERSION 2.1.2)

include(ExternalProject)
include(/shared/Utils.cmake)

# gflags will use pthreads if it's available in the system, so we must link with it
find_package(Threads)

if (UNIX)
    set(GLOG_EXTRA_COMPILER_FLAGS "-fPIC")
endif ()

set(GLOG_CXX_FLAGS ${CMAKE_CXX_FLAGS} ${GLOG_EXTRA_COMPILER_FLAGS})
set(GLOG_C_FLAGS ${CMAKE_C_FLAGS} ${GLOG_EXTRA_COMPILER_FLAGS})

# build directory
set(gflags_PREFIX ${CMAKE_BINARY_DIR}/external/gflags-prefix)
# install directory
set(gflags_INSTALL ${CMAKE_BINARY_DIR}/external/gflags-install)

# we build gflags statically
if (UNIX)
  set(GFLAGS_EXTRA_COMPILER_FLAGS "-fPIC")
endif()

set(GFLAGS_CXX_FLAGS ${CMAKE_CXX_FLAGS} ${GFLAGS_EXTRA_COMPILER_FLAGS})
set(GFLAGS_C_FLAGS ${CMAKE_C_FLAGS} ${GFLAGS_EXTRA_COMPILER_FLAGS})

ExternalProject_Add(gflags
  PREFIX ${gflags_PREFIX}
  GIT_REPOSITORY "https://github.com/gflags/gflags.git"
  GIT_TAG "v2.1.2"
  UPDATE_COMMAND ""
  INSTALL_DIR ${gflags_INSTALL}
  CMAKE_ARGS -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_INSTALL_PREFIX=${gflags_INSTALL}
    -DBUILD_SHARED_LIBS=OFF
    -DBUILD_STATIC_LIBS=ON
    -DBUILD_PACKAGING=OFF
    -DBUILD_TESTING=OFF
    -DBUILD_NC_TESTS=OFF
    -BUILD_CONFIG_TESTS=OFF
    -DINSTALL_HEADERS=ON
    -DCMAKE_C_FLAGS=${GFLAGS_C_FLAGS}
    -DCMAKE_CXX_FLAGS=${GFLAGS_CXX_FLAGS}
    LOG_DOWNLOAD 1
    LOG_INSTALL 1
)

install(DIRECTORY ${gflags_INSTALL}/include/gflags/ DESTINATION include/gflags FILES_MATCHING PATTERN "*.h")

install(DIRECTORY ${gflags_INSTALL}/lib/ DESTINATION lib
  FILES_MATCHING PATTERN "libgflags*"
                 PATTERN "cmake" EXCLUDE
                 PATTERN "pkgconfig" EXCLUDE)

install(FILES ${gflags_INSTALL}/bin/gflags_completions.sh DESTINATION bin)

if(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")
  include(InstallRequiredSystemLibraries)

  add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package)

  set(CPACK_SET_DESTDIR "on")
  set(CPACK_PACKAGING_INSTALL_PREFIX "/tmp")

  set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
  set(CPACK_PACKAGE_VENDOR "google")
  set(CPACK_PACKAGE_CONTACT "mateusz.polnik at strath.ac.uk")
  set(CPACK_PACKAGE_DESCRIPTION "The gflags package contains a C++ library that implements commandline flags processing.")
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