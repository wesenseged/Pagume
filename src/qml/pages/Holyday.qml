import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import "EthiopianCalendar.js" as EthCal

Kirigami.Page {
    id: holidayPage

    property date today: new Date()
    property var ethToday: EthCal.toEthiopian(today.getFullYear(), today.getMonth() + 1, today.getDate())
    property string currentDay: ethToday.day

    ListModel {
        id: monthlyHolidays

        ListElement {
            main: "ልደታ"
            other: "ራጉኤል፣ ኤልያስ"
            day: "1"
        }
        ListElement {
            main: "ታዴዎስ ሐዋርያ"
            other: "ኢዮብ ጻድቅ"
            day: "2"
        }
        ListElement {
            main: "በዓታ ማርያም"
            other: "ዜና ማርቆስ፣ ነአኩቶ ለአብ፣ ፋኑኤል"
            day: "3"
        }
        ListElement {
            main: "ዮሐንስ ወልደ ነጎድጓድ"
            other: "አባ መቃርዎስ፣ አባ አብርሐ"
            day: "4"
        }
        ListElement {
            main: "ጴጥሮስ ወጳውሎስ"
            other: "አቡነ ገብረ መንፈስ ቅዱስ"
            day: "5"
        }
        ListElement {
            main: "ኢየሱስ"
            other: "ቁስቋም፣ አርሴማ ቅድስት"
            day: "6"
        }
        ListElement {
            main: "ሥላሴ"
            other: "ፊሊሞን፣ አብላንዮስ"
            day: "7"
        }
        ListElement {
            main: "ማቴዎስ"
            other: "ዮልያኖስ፣ አባ ኪሮስ"
            day: "8"
        }
        ListElement {
            main: "ቶማስ ሐዋርያ"
            other: "እንድርያስ ሐዋርያ፣ አርባ ሰማዕታት"
            day: "9"
        }
        ListElement {
            main: "በዓለ መስቀሉ ለእግዚእነ"
            other: "ናትናኤል ሐዋርያ ፣ፀደንያ"
            day: "10"
        }
        ListElement {
            main: "ሃና ወኢያቄም"
            other: "ቅዱስ ፋሲለደስ ሰማዕት"
            day: "11"
        }
        ListElement {
            main: "ቅዱስ ሚካኤል"
            other: "ክርስቶስ ሠምራ፣ አባ ሳሙኤል"
            day: "12"
        }
        ListElement {
            main: "እግዚአብሔር አብ"
            other: "ቅዱስ ሩፋኤል"
            day: "13"
        }
        ListElement {
            main: "አባ አረጋዊ"
            other: "አባ ገብረ ክርስቶስ"
            day: "14"
        }
        ListElement {
            main: "ቂርቆስና ኢየሉጣ"
            other: "ስልፋኮስ"
            day: "15"
        }
        ListElement {
            main: "ኪዳነ ምሕረት"
            other: "ሚካኤል ጳጳስ"
            day: "16"
        }
        ListElement {
            main: "ቅዱስ እስጢፋኖስ"
            other: "ሉቃስ ዘዓምደ ብርሃን"
            day: "17"
        }
        ListElement {
            main: "ፊልጶስ ሐዋርያ"
            other: "ኤዎስጣጤዎስ ሰማዕት"
            day: "18"
        }
        ListElement {
            main: "ቅዱስ ገብርኤል"
            other: "አርቃዲዎስ"
            day: "19"
        }
        ListElement {
            main: "ጽንሰታ ለማርያም"
            other: "ነቢዩ ኤልሳ፣ አባ ሰላማ"
            day: "20"
        }
        ListElement {
            main: "በዓለ እግዝእትነ ማርያም"
            other: ""
            day: "21"
        }
        ListElement {
            main: "ቅዱስ ዑራኤል"
            other: "ደቅስዮስ"
            day: "22"
        }
        ListElement {
            main: "ቅዱስ ጊዮርጊስ"
            other: "ለጊኖስ ሰማዕት"
            day: "23"
        }
        ListElement {
            main: "አቡነ ተክለ ሃይማኖት"
            other: ""
            day: "24"
        }
        ListElement {
            main: "ቅዱስ መርቆሬዎስ"
            other: "አቡነ ሀቢብ"
            day: "25"
        }
        ListElement {
            main: "ዮሴፍ"
            other: "ቶማስ ዘህንደኬ፣ አቡነ ሀብተ ማርያም"
            day: "26"
        }
        ListElement {
            main: "መድኃኔዓለም"
            other: "ሕዝቅያስ ነቢይ"
            day: "27"
        }
        ListElement {
            main: "አማኑኤል"
            other: "አበው አብርሃም ይስሐቅና ያዕቆብ"
            day: "27"
        }
        ListElement {
            main: "በዓለ ወልድ"
            other: "ቅዱስ ላሊበላ፣ ቅድስት አርሴማ"
            day: "29"
        }
        ListElement {
            main: "ማርቆስ ወንጌላዊ"
            other: "ዮሐንስ መጥምቅ"
            day: "30"
        }
    }

    GridLayout {
        id: grid
        columns: 4
        columnSpacing: Kirigami.Units.largeSpacing
        rowSpacing: Kirigami.Units.largeSpacing
        Layout.alignment: Qt.AlignHCenter
        anchors.margins: Kirigami.Units.largeSpacing

        Repeater {
            model: monthlyHolidays
            delegate: Controls.Button {
                id: holidayButton
                Layout.preferredWidth: (holidayPage.width / 4) - (Kirigami.Units.largeSpacing * 2)
                Layout.preferredHeight: 80
                padding: 4

                background: Rectangle {
                    radius: 8
                    color: model.day === currentDay ? "#7e54ff" : Kirigami.Theme.backgroundColor
                }

                contentItem: ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: Kirigami.Units.smallSpacing

                    Controls.Label {
                        text: model.main
                        font.bold: true
                        wrapMode: Text.WordWrap
                        color: holidayButton.hovered ? Kirigami.Theme.highlightedTextColor : Kirigami.Theme.textColor
                    }

                    Controls.Label {
                        text: model.other
                        color: Kirigami.Theme.disabledTextColor
                        wrapMode: Text.WordWrap
                        visible: model.other.length > 0
                    }

                    Item {
                        Layout.fillHeight: true
                    }

                    Controls.Label {
                        text: model.day
                        color: holidayButton.hovered ? Kirigami.Theme.highlightedTextColor : Kirigami.Theme.textColor
                        horizontalAlignment: Text.AlignRight
                    }
                }
            }
        }
    }
}
