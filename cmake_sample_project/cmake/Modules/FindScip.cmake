if (SCIP_ROOT_DIR)
    set(_SCIP_INCLUDE_LOCATIONS "${SCIP_ROOT_DIR}")
    set(_SCIP_LIB_LOCATIONS "${SCIP_ROOT_DIR}")
else ()
    set(SCIP_ROOT_DIR "" CACHE PATH "Folder contains SCIP library")
    set(_SCIP_INCLUDE_LOCATIONS "")
    set(_SCIP_LIB_LOCATIONS "")
endif ()

if (NOT ZLIB_FOUND)
    find_package(ZLIB REQUIRED)
endif ()

if (NOT READLINE_FOUND)
    find_package(Readline REQUIRED)
endif ()

if (NOT SOPLEX_FOUND)
    find_package(Soplex REQUIRED)
endif ()

if (NOT GMP_FOUND)
    find_package(Gmp REQUIRED)
endif ()

find_path(SCIP_INCLUDE_DIR scip/scip.h HINTS ${_SCIP_INCLUDE_LOCATIONS} PATH_SUFFIXES src)

set(SCIP_LIBRARY "")
macro(FindScipComponent name)
    find_library(_${name}_LIBRARY ${name} HINTS ${_SCIP_LIB_LOCATIONS} PATH_SUFFIXES lib lib/static)
    if (NOT _${name}_LIBRARY)
        message(FATAL_ERROR "Not found lib${name}.a")
    endif ()
    mark_as_advanced(_${name}_LIBRARY)

    list(APPEND SCIP_LIBRARY ${_${name}_LIBRARY})
endmacro()

FindScipComponent(scip)
FindScipComponent(objscip)
FindScipComponent(tpinone)
FindScipComponent(lpispx2)
FindScipComponent(nlpi.cppad)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SCIP DEFAULT_MSG SCIP_LIBRARY SCIP_INCLUDE_DIR)

if (SCIP_FOUND)
    set(SCIP_LIBRARIES ${SCIP_LIBRARY})
    list(APPEND SCIP_LIBRARIES ${SOPLEX_LIBRARY})
    list(APPEND SCIP_LIBRARIES ${GMP_LIBRARY})
    list(APPEND SCIP_LIBRARIES ${READLINE_LIBRARIES})
    list(APPEND SCIP_LIBRARIES ${ZLIB_LIBRARY})

    set(SCIP_INCLUDE_DIRS ${SCIP_INCLUDE_DIR}
            ${GMP_INCLUDE_DIR}
            ${SOPLEX_INCLUDE_DIR}
            ${READLINE_INCLUDE_DIR}
            ${ZLIB_INCLUDE_DIR})
endif ()