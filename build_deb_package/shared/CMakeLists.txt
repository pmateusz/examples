cmake_minimum_required(VERSION 3.2 FATAL_ERROR)
project(libortools-dev LANGUAGES CXX VERSION 6.5)

include(/shared/Utils.cmake)

m_get_filepath(OR_TOOLS_DIR ~/dev/or-tools REALPATH)
m_get_filepath(OR_TOOLS_DEP_INSTALL_DIR ${OR_TOOLS_DIR}/dependencies/install REALPATH)

add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package)

# Dependencies

# Protobuf = 3.3.0
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/include/google/protobuf/api.pb.h)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libprotobuf.a)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/bin/protoc)

install(DIRECTORY ${OR_TOOLS_DEP_INSTALL_DIR}/include/google/ DESTINATION include/google)

install(DIRECTORY ${OR_TOOLS_DEP_INSTALL_DIR}/lib/ DESTINATION lib
  FILES_MATCHING PATTERN "libproto*"
                 PATTERN "cmake" EXCLUDE
                 PATTERN "pkgconfig" EXCLUDE)

install(PROGRAMS ${OR_TOOLS_DEP_INSTALL_DIR}/bin/protoc DESTINATION bin)

# gflags = 2.2.0
# m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/include/gflags/gflags.h)
# m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libgflags.a)
# m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/bin/gflags_completions.sh)

# install(DIRECTORY ${OR_TOOLS_DEP_INSTALL_DIR}/include/gflags/ DESTINATION include/gflags FILES_MATCHING PATTERN "*.h")

#install(DIRECTORY ${OR_TOOLS_DEP_INSTALL_DIR}/lib/ DESTINATION lib
#  FILES_MATCHING PATTERN "libgflags*"
#                 PATTERN "cmake" EXCLUDE
#                 PATTERN "pkgconfig" EXCLUDE)

#install(FILES ${OR_TOOLS_DEP_INSTALL_DIR}/bin/gflags_completions.sh DESTINATION bin)

# Glog = 0.3.5
#m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/include/glog/logging.h)
#m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libglog.a)

#install(DIRECTORY ${OR_TOOLS_DEP_INSTALL_DIR}/include/glog/ DESTINATION include/glog FILES_MATCHING PATTERN "*.h")

#install(DIRECTORY ${OR_TOOLS_DEP_INSTALL_DIR}/lib/ DESTINATION lib
#  FILES_MATCHING PATTERN "libglog*"
#                 PATTERN "cmake" EXCLUDE
#                 PATTERN "pkgconfig" EXCLUDE)

# cbc = 2.9.8
# CoinUtils = 2.10.13
# Osi = 0.107.8
# Clp = 1.16.10
# Cgl = 0.59.9
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libCbc.a)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libCbcSolver.a)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libCgl.a)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libClp.a)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libClpSolver.a)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libOsiCbc.a)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libOsiClp.a)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/lib/libOsi.a)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/bin/clp)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/bin/cbc)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/include/coin/CbcConfig.h)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/include/coin/ClpConfig.h)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/include/coin/CglConfig.h)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/include/coin/CoinUtilsConfig.h)
m_check_filepath(${OR_TOOLS_DEP_INSTALL_DIR}/include/coin/OsiConfig.h)

install(DIRECTORY ${OR_TOOLS_DEP_INSTALL_DIR}/include/coin/ DESTINATION include/coin
  FILES_MATCHING PATTERN "*.h"
                 PATTERN "*.hpp")

install(DIRECTORY ${OR_TOOLS_DEP_INSTALL_DIR}/lib/ DESTINATION lib
  FILES_MATCHING PATTERN "libCbc*"
                 PATTERN "libCgl*"
                 PATTERN "libClp*"
                 PATTERN "libCbcSolver*"
                 PATTERN "libClpSolver*"
                 PATTERN "libCoinUtils*"
                 PATTERN "libOsi*"
                 PATTERN "libOsiCbc*"
                 PATTERN "libOsiClp*"
                 PATTERN "libOsiCommonTests*"
                 PATTERN "libOsi*"
                 PATTERN "cmake" EXCLUDE
                 PATTERN "pkgconfig" EXCLUDE)
 
install(PROGRAMS ${OR_TOOLS_DEP_INSTALL_DIR}/bin/cbc ${OR_TOOLS_DEP_INSTALL_DIR}/bin/clp DESTINATION bin)

install(DIRECTORY ${OR_TOOLS_DEP_INSTALL_DIR}/share/coin/ DESTINATION share/coin)

# OR Tools 6.0
m_check_filepath(${OR_TOOLS_DIR}/lib/libcvrptw_lib.so )
m_check_filepath(${OR_TOOLS_DIR}/lib/libdimacs.so)
m_check_filepath(${OR_TOOLS_DIR}/lib/libfap.so)
m_check_filepath(${OR_TOOLS_DIR}/lib/libortools.so)
m_check_filepath(${OR_TOOLS_DIR}/ortools/linear_solver/linear_solver.h)
m_check_filepath(${OR_TOOLS_DIR}/ortools/gen/ortools/linear_solver/linear_solver.pb.h)

install(DIRECTORY ${OR_TOOLS_DIR}/lib/ DESTINATION lib
  FILES_MATCHING PATTERN "lib*")

foreach (dir algorithms base bop constraint_solver flatzinc glop graph linear_solver lp_data sat util)
  install(DIRECTORY ${OR_TOOLS_DIR}/ortools/${dir} DESTINATION include/ortools FILES_MATCHING PATTERN "*.h")
  install(DIRECTORY ${OR_TOOLS_DIR}/ortools/gen/ortools/${dir} DESTINATION include/ortools FILES_MATCHING PATTERN "*.h")
endforeach ()

if(EXISTS "${CMAKE_ROOT}/Modules/CPack.cmake")
  include(InstallRequiredSystemLibraries)

  set(CPACK_SET_DESTDIR "on")
  set(CPACK_PACKAGING_INSTALL_PREFIX "/tmp")

  set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
  set(CPACK_PACKAGE_VENDOR "google")
  set(CPACK_PACKAGE_CONTACT "mateusz.polnik at strath.ac.uk")
  set(CPACK_PACKAGE_DESCRIPTION "Google Optimization Tools")
  set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${CPACK_PACKAGE_DESCRIPTION})

  set(CPACK_RESOURCE_FILE_LICENSE ${OR_TOOLS_DIR}/LICENSE-2.0.txt)
  set(CPACK_RESOURCE_FILE_README ${OR_TOOLS_DIR}/README)
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
    # Ubuntu Trusty requires cmake3, Debian Jessie cmake. Removed the dependency to have a simple file
    set(CPACK_DEBIAN_PACKAGE_DEPENDS "git (>= 1:1.9.1), bison (>= 2:3.0.2), flex (>= 2.5.35), python-setuptools (>= 3.3), python-dev (>= 2.7.0), autoconf (>= 2.69), libtool (>= 2.4.2), zlib1g-dev (>= 1:1.2.8), texinfo (>= 5.2.0), help2man (>= 1.44.0), gawk (>= 1:4.0), g++ (>= 4:4.8.0), curl (>= 7.35.0), texlive, subversion (>= 1.8.0)")
  endif()

  include(CPack)
endif()