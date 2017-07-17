cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(libglog-dev LANGUAGES CXX VERSION 0.3.4)

include(ExternalProject)
include(/shared/Utils.cmake)

if (UNIX)
    set(GLOG_EXTRA_COMPILER_FLAGS "-fPIC")
endif ()

set(GLOG_CXX_FLAGS ${CMAKE_CXX_FLAGS} ${GLOG_EXTRA_COMPILER_FLAGS})
set(GLOG_C_FLAGS ${CMAKE_C_FLAGS} ${GLOG_EXTRA_COMPILER_FLAGS})

set(glog_PREFIX ${CMAKE_BINARY_DIR}/external/glog-prefix)
set(glog_INSTALL ${CMAKE_BINARY_DIR}/external/glog-install)

ExternalProject_Add(glog
    PREFIX ${glog_PREFIX}
    URL https://github.com/google/glog/archive/v0.3.4.zip
    URL_HASH SHA1=c5f2b5f48a1ae77a8224bc225006f3732d0a0dfd
    UPDATE_COMMAND ""
    INSTALL_DIR ${glog_INSTALL}
    PATCH_COMMAND autoreconf -i ${glog_PREFIX}/src/glog
    CONFIGURE_COMMAND env "CFLAGS=${GLOG_C_FLAGS}" "CXXFLAGS=${GLOG_CXX_FLAGS}" ${glog_PREFIX}/src/glog/configure --prefix=${glog_INSTALL} --enable-shared=no --enable-static=yes
    LOG_DOWNLOAD 1
    LOG_CONFIGURE 1
    LOG_INSTALL 1)

install(DIRECTORY ${glog_INSTALL}/include/glog/ DESTINATION include/glog FILES_MATCHING PATTERN "*.h")

install(DIRECTORY ${glog_INSTALL}/lib/ DESTINATION lib
  FILES_MATCHING PATTERN "libglog*"
                 PATTERN "cmake" EXCLUDE
                 PATTERN "pkgconfig" EXCLUDE)

install(DIRECTORY ${glog_INSTALL}/share/doc/ DESTINATION share/glog)

if(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")
  include(InstallRequiredSystemLibraries)

  add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package)

  set(CPACK_SET_DESTDIR "on")
  set(CPACK_PACKAGING_INSTALL_PREFIX "/tmp")

  set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
  set(CPACK_PACKAGE_VENDOR "google")
  set(CPACK_PACKAGE_CONTACT "mateusz.polnik at strath.ac.uk")
  set(CPACK_PACKAGE_DESCRIPTION "C++ implementation of the Google logging module")
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