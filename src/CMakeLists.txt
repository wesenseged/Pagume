add_executable(Pagume)

ecm_add_qml_module(Pagume
    URI
    io.github.wesenseged.Pagume
)

target_sources(Pagume
    PRIVATE
    main.cpp
)

ecm_target_qml_sources(Pagume
    SOURCES
    qml/Main.qml
    qml/pages/Calendar.qml
    qml/pages/Holyday.qml
    qml/pages/About.qml
    qml/pages/Fasting.qml

    qml/pages/EthiopianCalendar.js
)

target_link_libraries(Pagume
    PRIVATE
    Qt6::Quick
    Qt6::Qml
    Qt6::Gui
    Qt6::QuickControls2
    Qt6::Widgets
    KF6::I18n
    KF6::CoreAddons
    KF6::IconThemes
)

install(TARGETS Pagume ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})

