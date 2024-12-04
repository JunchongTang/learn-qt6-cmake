cmake_minimum_required(VERSION 3.16)

project(BuildWidgetAppWithTranslations VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

#添加国际化工具模块
find_package(Qt6 REQUIRED COMPONENTS LinguistTools)

#配置需要的国际化语种
qt_standard_project_setup(I18N_TRANSLATED_LANGUAGES en zh_CN)

set(PROJECT_SOURCES
        main.cpp
        mainwindow.cpp
        mainwindow.h
        mainwindow.ui
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(BuildWidgetAppWithTranslations
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET BuildWidgetAppWithTranslations APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(BuildWidgetAppWithTranslations SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(BuildWidgetAppWithTranslations
            ${PROJECT_SOURCES}
        )
    endif()
endif()



target_link_libraries(BuildWidgetAppWithTranslations PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)

#添加翻译文件到目标中
qt_add_translations(BuildWidgetAppWithTranslations)
#然后会自动生成ts文件，要更新翻译在build目录中执行cmake --build . --target update_translations

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.BuildWidgetAppWithTranslations)
endif()

#这是cmake支持的属性，在MacOS上创建应用程序包。
#在Windows上WIN32_EXECUTABLE设置为true在链接的时候会创建WinMain()的入口函数，而不仅仅是main()，这会标记为一个GUI程序。
set_target_properties(BuildWidgetAppWithTranslations PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS BuildWidgetAppWithTranslations
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(BuildWidgetAppWithTranslations)
endif()
