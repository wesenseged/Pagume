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
            name: "Fasting"
            iconName: "weather-clear"
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
                    model: itemsModel
                    delegate: Controls.ToolButton {
                        icon.name: iconName ? iconName : "🎉"
                        icon.width: 24
                        icon.height: 24
                        Controls.ToolTip.text: name
                        Controls.ToolTip.visible: hovered
                        checkable: true
                        checked: pageLoader.source.toString().includes(name)
                        width: 36
                        height: 36
                        onClicked: {
                            if (name === "Calendar") {
                                pageLoader.source = Qt.resolvedUrl("Calendar.qml");
                            } else if (name === "Holyday") {
                                pageLoader.source = Qt.resolvedUrl("Holyday.qml");
                            } else if (name === "Fasting") {
                                pageLoader.source = Qt.resolvedUrl("Fasting.qml");
                            } else if (name === "About") {
                                pageLoader.source = Qt.resolvedUrl("About.qml");
                            }
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
