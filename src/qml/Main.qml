// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQml
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    width: 1100
    height: 800
    minimumWidth: 930
    minimumHeight: 750

    ListModel {
        id: itemsModel
        ListElement {
            name: "Calendar"
            iconName: "view-calendar"
        }
        ListElement {
            name: "Holyday"
            iconName: "emblem-favorite"
        }
        ListElement {
            name: "Convert"
            iconName: "accessories-calculator"
        }
        ListElement {
            name: "About"
            iconName: "help-about"
        }
    }

    RowLayout {
        anchors.fill: parent
        Rectangle {
            id: sideBar
            Layout.preferredWidth: 80
            color: Kirigami.Theme.backgroundColor
            Layout.fillHeight: true

            Column {
                anchors.centerIn: parent
                spacing: Kirigami.Units.smallSpacing

                Repeater {
                    id: navButton
                    model: itemsModel
                    delegate: Controls.ToolButton {
                        icon.name: model.iconName ? model.iconName : "🎉"
                        icon.width: 24
                        icon.height: 24
                        Controls.ToolTip.text: model.name
                        Controls.ToolTip.visible: hovered

                        checkable: true
                        checked: pageLoader.source.toString().includes(model.name)
                        width: 36
                        height: 36
                        onClicked: {
                            pageLoader.source = Qt.resolvedUrl(model.name + ".qml");
                        }
                    }
                }
            }
        }

        Loader {
            id: pageLoader
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: Qt.resolvedUrl("Calendar.qml")
        }
    }
}
