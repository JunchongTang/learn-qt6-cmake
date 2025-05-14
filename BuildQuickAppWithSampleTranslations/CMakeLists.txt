# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(BuildQuickAppWithSampleTranslations LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Qml LinguistTools)

qt_standard_project_setup(REQUIRES 6.8 I18N_TRANSLATED_LANGUAGES en fr zh_CN)

qt_add_executable(appBuildQuickAppWithSampleTranslations WIN32 MACOSX_BUNDLE main.cpp)

target_link_libraries(appBuildQuickAppWithSampleTranslations PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

qt_add_qml_module(appBuildQuickAppWithSampleTranslations
    URI Translation
    QML_FILES
        Main.qml
)

#![0]
qt_add_translations(appBuildQuickAppWithSampleTranslations
    RESOURCE_PREFIX /qt/qml/Translated/i18n
    TS_FILE_BASE qml
    TS_FILE_DIR i18n
)
#![0]

install(TARGETS appBuildQuickAppWithSampleTranslations
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

qt_generate_deploy_qml_app_script(
    TARGET appBuildQuickAppWithSampleTranslations
    OUTPUT_SCRIPT deploy_script
    MACOS_BUNDLE_POST_BUILD
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
)
install(SCRIPT ${deploy_script})
