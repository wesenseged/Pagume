// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ScrollablePage {
    id: aboutPage
    title: "About Pagume"

    Item {
        id: centerContainer
        width: Math.min(parent.width * 0.33, 500)

        ColumnLayout {
            id: mainColumn
            anchors.fill: parent
            spacing: Kirigami.Units.largeSpacing

            // --- Header Card ---
            Kirigami.AbstractCard {
                Layout.fillWidth: true
                contentItem: RowLayout {
                    spacing: Kirigami.Units.largeSpacing
                    Kirigami.Icon {
                        source: "io.github.wesenseged.Pagume"
                        implicitWidth: 64
                        implicitHeight: 64
                    }
                    ColumnLayout {
                        spacing: 4
                        Kirigami.Heading {
                            text: "Pagume 1.0"
                            level: 2
                        }
                        Controls.Label {
                            text: "Ethiopian calendar with main holidays and fasting seasons"
                            wrapMode: Text.WordWrap
                            color: Kirigami.Theme.disabledTextColor
                        }
                    }
                }
            }

            Kirigami.AbstractCard {
                Layout.fillWidth: true
                contentItem: ColumnLayout {
                    spacing: Kirigami.Units.smallSpacing

                    Kirigami.Heading {
                        text: "Copyright"
                        level: 3
                    }
                    Controls.Label {
                        text: "© 2026 Abenezer Wesenseged"
                        color: Kirigami.Theme.disabledTextColor
                    }
                }
            }

            // --- License ---
            Kirigami.Heading {
                text: "License"
                level: 3
            }
            Kirigami.AbstractCard {
                Layout.fillWidth: true
                contentItem: ColumnLayout {
                    spacing: Kirigami.Units.smallSpacing
                    Controls.Label {
                        text: "GPL-3.0-or-later"
                        font.bold: true
                    }
                    Controls.Label {
                        text: "This application is licensed under the GNU General Public License v3.0 or later."
                        wrapMode: Text.WordWrap
                        color: Kirigami.Theme.disabledTextColor
                    }
                }
            }

            // --- Links ---
            Kirigami.Heading {
                text: "Links"
                level: 3
            }
            Kirigami.AbstractCard {
                Layout.fillWidth: true
                contentItem: ColumnLayout {
                    spacing: 6
                    RowLayout {
                        Layout.fillWidth: true
                        Kirigami.Icon {
                            source: "tools-report-bug"
                            implicitWidth: 22
                            implicitHeight: 22
                        }
                        Controls.Label {
                            text: "Report a Bug"
                            Layout.fillWidth: true
                            MouseArea {
                                anchors.fill: parent
                                onClicked: Qt.openUrlExternally("https://github.com/wesenseged/Pagume/issues")
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                        Kirigami.Icon {
                            source: "link-external"
                            implicitWidth: 18
                            implicitHeight: 18
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Kirigami.Icon {
                            source: "globe"
                            implicitWidth: 22
                            implicitHeight: 22
                        }
                        Controls.Label {
                            text: "Website"
                            Layout.fillWidth: true
                            MouseArea {
                                anchors.fill: parent
                                onClicked: Qt.openUrlExternally("https://wesen.vercel.app")
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                        Kirigami.Icon {
                            source: "link-external"
                            implicitWidth: 18
                            implicitHeight: 18
                        }
                    }
                }
            }

            // --- Libraries ---
            Kirigami.Heading {
                text: "Libraries in use"
                level: 3
            }
            Kirigami.AbstractCard {
                Layout.fillWidth: true
                contentItem: ColumnLayout {
                    spacing: Kirigami.Units.largeSpacing * 1.5
                    ColumnLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Kirigami.Heading {
                            text: "KDE Frameworks 6.20.0"
                            level: 3
                            color: Kirigami.Theme.activeTextColor
                        }
                        Controls.Label {
                            text: "Collection of libraries created by the KDE Community to extend Qt."
                            color: Kirigami.Theme.disabledTextColor
                        }
                    }
                    ColumnLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Kirigami.Heading {
                            text: "Qt 6.10.0 (built against 6.10.0)"
                            level: 3
                            color: Kirigami.Theme.activeTextColor
                        }
                        Controls.Label {
                            text: "Cross-platform application development framework."
                            color: Kirigami.Theme.disabledTextColor
                        }
                    }
                    ColumnLayout {
                        spacing: Kirigami.Units.smallSpacing
                        Kirigami.Heading {
                            text: "The Wayland windowing system"
                            level: 3
                            color: Kirigami.Theme.activeTextColor
                        }
                        Controls.Label {
                            text: "Underlying platform."
                            color: Kirigami.Theme.disabledTextColor
                        }
                    }
                }
            }

            // --- Authors ---
            Kirigami.Heading {
                text: "Authors"
                level: 3
            }
            Kirigami.AbstractCard {
                implicitWidth: 400
                Layout.fillWidth: true
                contentItem: RowLayout {
                    spacing: Kirigami.Units.largeSpacing
                    Kirigami.Icon {
                        source: "user-identity"
                        implicitWidth: 48
                        implicitHeight: 48
                    }
                    ColumnLayout {
                        Controls.Label {
                            text: "Abenezer Wesenseged"
                            font.bold: true
                        }
                        Controls.Label {
                            text: "Developer & Maintainer"
                            color: Kirigami.Theme.disabledTextColor
                        }
                    }
                    RowLayout {
                        Layout.alignment: Qt.AlignRight
                        spacing: 8
                        Controls.ToolButton {
                            icon.name: "mail-send"
                            onClicked: Qt.openUrlExternally("mailto:wseged@proton.me")
                            Controls.ToolTip.text: "mailto:wseged@proton.me"
                            Controls.ToolTip.visible: hovered
                        }
                        Controls.ToolButton {
                            icon.name: "globe"
                            onClicked: Qt.openUrlExternally("https://wesen.vercel.app")
                            Controls.ToolTip.text: "https://wesen.vercel.app"
                            Controls.ToolTip.visible: hovered
                        }
                    }
                }
            }
        }
    }
}
