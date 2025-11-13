import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.Page {
    id: fastingPage

    ListModel {
        id: fastingModel
        ListElement {
            name: "ጾመ አብይ"
            date: "የካቲት 22 - ፋሲካ"
            desc: "ይህ ጌታችንና መድኃኒታችን አይሱስ ክርስቶስ ከተጠመቀ በኋላ ለአርባ ቀናትና ሌሊቶች የጾመው ጾም ነው።"
        }

        ListElement {
            name: "የረቡዕና አርብ ጾም"
            date: "ሁሌ (ከፋሲካ እስከ ጰራቅሊጦስ በስተቀር)"
            desc: "በየሳምንቱ ረቡዕና አርብ የሚጠበቅ ጾም ሲሆን፣ የጌታችንን መከራና ሞት ለመዝከር ነው።"
        }

        ListElement {
            name: "ጾመ ነነዌ"
            date: "የካቲት 8 - 10"
            desc: "በነነዌ ሕዝብ የነቢዩ ዮናስን ትንቢት በመስማት የተመለሱበትን ታሪክ የምንዝክርበት ትልቅ ሶስት ቀን ጾም ነው።"
        }

        ListElement {
            name: "ጾመ ገሃድ"
            date: "በገናና በጥምቀት ቀድሞ ቀን"
            desc: "ይህ በገናና በጥምቀት አብያተ ክርስቲያን በእኩለ ሌሊት እስከ አንድ ሰዓት ድረስ በመጸለይ የምትከበረው ጾም ነው።"
        }

        ListElement {
            name: "ጾመ ነብያት"
            date: "ህዳር 15 - ታህሳስ 29"
            desc: "ይህንን ጾም የምናከብረው በዘመናቸው የጌታችንንና የመድኃኒታችንን የአየሰስ ክርስቶስን መምጣት የሚናፍቁ ነቢያትን ምሳሌ በመከተል ነው።"
        }

        ListElement {
            name: "ጾመ ሐዋርያት"
            date: "ከፋሲካ በኋላ እስከ ጰራቅሊጦስ"
            desc: "ሐዋርያት ይህንን ጾም የጾሙት መንፈስ ቅዱስን ከተቀበሉ በኋላ እና ወንጌልን ለማወጅ ከመውጣታቸው በፊት ነበር።"
        }

        ListElement {
            name: "ጾመ ፍልሰታ"
            date: "ነሐሴ 1 - 16"
            desc: "በእመቤታችን ቅድስት ድንግል ማርያም ስም የምንጠብቀው ጾም ሲሆን በሰማይ መነሻዋን እንዝክራለን።"
        }
    }

    ListView {
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing
        clip: true
        spacing: Kirigami.Units.largeSpacing
        model: fastingModel

        delegate: Kirigami.AbstractCard {
            Layout.fillWidth: true

            anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
            contentItem: RowLayout {
                spacing: Kirigami.Units.largeSpacing

                ColumnLayout {
                    Controls.Label {
                        text: model.name
                        font.bold: true
                        color: Kirigami.Theme.textColor
                        wrapMode: Text.WordWrap
                    }
                    Controls.Label {
                        text: model.desc
                        color: Kirigami.Theme.disabledTextColor
                        wrapMode: Text.WordWrap
                        visible: model.desc.length > 0
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Controls.Label {
                    text: model.date
                    color: Kirigami.Theme.textColor
                    horizontalAlignment: Text.AlignRight
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }
}
