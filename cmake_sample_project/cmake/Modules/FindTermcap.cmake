find_path(TERMCAP_INCLUDE_DIR termcap.h)
find_library(TERMCAP_LIBRARY termcap)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TERMCAP DEFAULT_MSG TERMCAP_LIBRARY TERMCAP_INCLUDE_DIR)