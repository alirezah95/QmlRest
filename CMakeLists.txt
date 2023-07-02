cmake_minimum_required(VERSION 3.24)

find_package(QT NAMES Qt6 Qt5)

set(PROJECT_NAME "QmlRest")
set(PROJECT_VERSION_MAJOR 1)
set(PROJECT_VERSION_MINOR 1)
set(PROJECT_VERSION_PATCH 1)
set(PROJECT_VERSION_TWEAK 0)
if (PROJECT_VERSION_TWEAK EQUAL 0)
    set(PROJECT_VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH})
else()
    set(PROJECT_VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}.${PROJECT_VERSION_TWEAK})
endif()
set(PROJECT_VERSION_TYPE "alpha")
set(PROJECT_LICENSE_TYPE "MIT")
set(PROJECT_CREATOR "Alireza Hasani")
set(PROJECT_LANGUAGES "QML")
set(PROJECT_DESCRIPTION "A module providing common functionality for REST methods and exposing HTTP status code")
set(PROJECT_HOMEPAGE_URL "https://github.com/alirezah95/QmlRest")


if(QT_VERSION_MAJOR EQUAL 6)
    # For Qt 6.2.x and Qt 6.3.x, major version in qt_add_qml_module() must be
    # greater than zero otherwise module is not registered
    set_source_files_properties(
        src/qml/Status.qml
        src/qml/Rest.qml
        PROPERTIES
            QT_QML_SINGLETON_TYPE TRUE
    )

    qt_add_qml_module(${PROJECT_NAME}
        URI "QmlRest"
        SHARED
        VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        QML_FILES
            src/qml/Rest.qml
            src/qml/Status.qml
        )
endif()
