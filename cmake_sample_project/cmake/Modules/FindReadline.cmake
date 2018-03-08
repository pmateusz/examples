find_path(READLINE_INCLUDE_DIR readline/readline.h)

find_library(_READLINE_LIB readline)
if (NOT _READLINE_LIB)
    message(FATAL_ERROR "Not found libreadline.a")
endif ()

find_library(_HISTORY_LIB history)
if (NOT _HISTORY_LIB)
    message(FATAL_ERROR "Not found libhistory.a")
endif ()

find_package(Curses REQUIRED)
find_package(Termcap REQUIRED)

set(READLINE_LIBRARY ${_READLINE_LIB})
list(APPEND READLINE_LIBRARY ${_HISTORY_LIB})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(READLINE DEFAULT_MSG READLINE_LIBRARY READLINE_INCLUDE_DIR)

if (READLINE_FOUND)
    set(READLINE_LIBRARIES ${READLINE_LIBRARY})
    list(APPEND READLINE_LIBRARIES ${CURSES_LIBRARIES})
    list(APPEND READLINE_LIBRARIES ${TERMCAP_LIBRARY})

    set(READLINE_INCLUDE_DIRS ${READLINE_INCLUDE_DIR} ${CURSES_INCLUDE_DIR} ${TERMCAP_INCLUDE_DIR})
endif ()

mark_as_advanced(_READLINE_LIB _HISTORY_LIB)