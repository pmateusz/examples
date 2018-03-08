if (TERMCAP_ROOT_DIR)
    set(_TERMCAP_INCLUDE_LOCATIONS "${TERMCAP_ROOT_DIR}/src")
    set(_TERMCAP_LIB_LOCATIONS "${TERMCAP_ROOT_DIR}/lib")
else ()
    set(TERMCAP_ROOT_DIR "" CACHE PATH "Folder contains Termcap library")
    set(_TERMCAP_INCLUDE_LOCATIONS "")
    set(_TERMCAP_LIB_LOCATIONS "")
endif ()

find_path(TERMCAP_INCLUDE_DIR termcap.h HINTS ${_TERMCAP_INCLUDE_LOCATIONS})
find_library(TERMCAP_LIBRARY termcap HINTS ${_TERMCAP_LIB_LOCATIONS})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TERMCAP DEFAULT_MSG TERMCAP_LIBRARY TERMCAP_INCLUDE_DIR)

mark_as_advanced(_TERMCAP_INCLUDE_LOCATIONS _TERMCAP_LIB_LOCATIONS)