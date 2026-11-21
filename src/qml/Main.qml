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
    minimumWidth: 360
    minimumHeight: 800

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

    Controls.SwipeView {
        id: swipeView
        anchors.fill: parent
        clip: true
        onCurrentIndexChanged: footer.currentIndex = currentIndex
        Calendar {
            id: calendar
        }
        Holyday {
            id: holyday
        }
        Convert {
            id: convert
        }
        About {
            id: about
        }
    }

    footer: Kirigami.NavigationTabBar {
        actions: [
            Kirigami.Action {
                icon.name: "view-calendar"
                text: "Calendar"
                checked: true
                onTriggered: swipeView.currentIndex = footer.currentIndex
            },
            Kirigami.Action {
                icon.name: "emblem-favorite"
                text: "Holyday"
                onTriggered: swipeView.currentIndex = footer.currentIndex
            },
            Kirigami.Action {
                icon.name: "accessories-calculator"
                text: "Convert"
                onTriggered: swipeView.currentIndex = footer.currentIndex
            },
            Kirigami.Action {
                icon.name: "help-about"
                text: "About"
                onTriggered: swipeView.currentIndex = footer.currentIndex
            }
        ]
    }
}
