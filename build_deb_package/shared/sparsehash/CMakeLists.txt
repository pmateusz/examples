cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(libsparsehash-dev LANGUAGES CXX VERSION 2.0.3)

include(ExternalProject)
include(/shared/Utils.cmake)

# build directory
set(sparsehash_PREFIX ${CMAKE_BINARY_DIR}/external/sparsehash-prefix)
# install directory
set(sparsehash_INSTALL ${CMAKE_BINARY_DIR}/external/sparsehash-install)

if (UNIX)
  set(SPARSEHASH_EXTRA_COMPILER_FLAGS "-fPIC")
endif()

set(SPARSEHASH_CXX_FLAGS ${CMAKE_CXX_FLAGS} ${SPARSEHASH_EXTRA_COMPILER_FLAGS})
set(SPARSEHASH_C_FLAGS ${CMAKE_C_FLAGS} ${SPARSEHASH_EXTRA_COMPILER_FLAGS})

ExternalProject_Add(sparsehash
  PREFIX ${sparsehash_PREFIX}
  GIT_REPOSITORY "https://github.com/sparsehash/sparsehash"
  GIT_TAG "sparsehash-2.0.3"
  UPDATE_COMMAND ""
  INSTALL_DIR ${sparsehash_INSTALL}
  PATCH_COMMAND autoreconf -i ${sparsehash_PREFIX}/src/sparsehash
  CONFIGURE_COMMAND env "CFLAGS=${SPARSEHASH_C_FLAGS}" "CXXFLAGS=${SPARSEHASH_CXX_FLAGS}" ${sparsehash_PREFIX}/src/sparsehash/configure --prefix=${sparsehash_INSTALL} --enable-shared=no --enable-static=yes
  LOG_DOWNLOAD 1
  LOG_INSTALL 1)

install(DIRECTORY ${sparsehash_INSTALL}/include/google/ DESTINATION include/google)
install(DIRECTORY ${sparsehash_INSTALL}/include/sparsehash/ DESTINATION include/sparsehash)

install(DIRECTORY ${sparsehash_INSTALL}/share/doc/ DESTINATION share/sparsehash)

if(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")
  include(InstallRequiredSystemLibraries)

  add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package)

  set(CPACK_SET_DESTDIR "on")
  set(CPACK_PACKAGING_INSTALL_PREFIX "/tmp")

  set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
  set(CPACK_PACKAGE_VENDOR "sparsehash")
  set(CPACK_PACKAGE_CONTACT "mateusz.polnik at strath.ac.uk")
  set(CPACK_PACKAGE_DESCRIPTION "C++ associative containers")
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