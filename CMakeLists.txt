cmake_minimum_required(VERSION 3.20)
project(Pagume)

find_package(ECM 6.0.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMFindQmlModule)
include(ECMQmlModule)

find_package(Qt6 REQUIRED COMPONENTS
    Core
    Quick
    Test
    Gui
    QuickControls2
    Widgets
)

find_package(KF6 REQUIRED COMPONENTS
    Kirigami
    I18n
    CoreAddons
    QQC2DesktopStyle
    IconThemes
)

ecm_find_qmlmodule(org.kde.kirigami REQUIRED)

add_subdirectory(src)

# Install desktop file
install(PROGRAMS data/io.github.wesenseged.Pagume.desktop DESTINATION ${KDE_INSTALL_APPDIR})

# Install icons for multiple sizes
install(FILES data/icons/hicolor/128x128/apps/io.github.wesenseged.Pagume.png
        DESTINATION ${KDE_INSTALL_ICONDIR}/hicolor/128x128/apps)
install(FILES data/icons/hicolor/256x256/apps/io.github.wesenseged.Pagume.png
        DESTINATION ${KDE_INSTALL_ICONDIR}/hicolor/256x256/apps)
install(FILES data/icons/hicolor/512x512/apps/io.github.wesenseged.Pagume.png
        DESTINATION ${KDE_INSTALL_ICONDIR}/hicolor/512x512/apps)

# Install metainfo
install(FILES data/io.github.wesenseged.Pagume.metainfo.xml
        DESTINATION ${KDE_INSTALL_METAINFODIR})

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

