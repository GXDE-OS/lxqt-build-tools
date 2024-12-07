# XDG standards expects system-wide configuration files in the /etc/xdg/lxqt location.
# Unfortunately QSettings we are using internally can be overriden in the Qt compilation
# time to use different path for system-wide configs. (for example configure ... -sysconfdir /etc/settings ...)
# This path can be found calling Qt4's qmake:
#   qmake -query QT_INSTALL_CONFIGURATION
#

find_package(Qt5Core REQUIRED)

if(NOT DEFINED LXQT_ETC_XDG_DIR)
    get_target_property(QT_QMAKE_EXECUTABLE ${Qt5Core_QMAKE_EXECUTABLE} IMPORTED_LOCATION)
    message(STATUS "${QT_QMAKE_EXECUTABLE}")

    if(NOT QT_QMAKE_EXECUTABLE)
        message(FATAL_ERROR "LXQT_ETC_XDG_DIR: qmake executable not found (included before qt was configured?)")
    endif()

    execute_process(COMMAND ${QT_QMAKE_EXECUTABLE} -query QT_INSTALL_CONFIGURATION
                    OUTPUT_VARIABLE LXQT_ETC_XDG_DIR
                    OUTPUT_STRIP_TRAILING_WHITESPACE)

    message(STATUS "LXQT_ETC_XDG_DIR autodetected as '${LXQT_ETC_XDG_DIR}'")
    message(STATUS "You can set it manually with -DLXQT_ETC_XDG_DIR=<value>")
    message(STATUS "")
endif ()

