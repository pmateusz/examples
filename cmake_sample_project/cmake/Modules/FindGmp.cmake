find_path(GMP_INCLUDE_DIR gmp.h)
find_library(GMP_LIBRARY gmp)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GMP DEFAULT_MSG GMP_LIBRARY GMP_INCLUDE_DIR)