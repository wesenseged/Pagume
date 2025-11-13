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
    property var amharicNumbers: ["፩", "፪", "፫", "፬", "፭", "፮", "፯", "፰", "፱", "፲", "፲፩", "፲፪", "፲፫", "፲፬", "፲፭", "፲፮", "፲፯", "፲፰", "፲፱", "፳", "፳፩", "፳፪", "፳፫", "፳፬", "፳፭", "፳፮", "፳፯", "፳፰", "፳፱", "፴"]

    ListModel {
        id: monthlyHolidays

        ListElement {
            main: "ልደታ"
            other: "ራጉኤል፣ ኤልያስ"
            day: "፩"
        }
        ListElement {
            main: "ታዴዎስ ሐዋርያ"
            other: "ኢዮብ ጻድቅ"
            day: "፪"
        }
        ListElement {
            main: "በዓታ ማርያም"
            other: "ዜና ማርቆስ፣ ነአኩቶ ለአብ"
            day: "፫"
        }
        ListElement {
            main: "ዮሐንስ ወልደ ነጎድጓድ"
            other: ""
            day: "፬"
        }
        ListElement {
            main: "ጴጥሮስ ወጳውሎስ"
            other: "አቡነ ገብረ መንፈስ ቅዱስ"
            day: "፭"
        }
        ListElement {
            main: "ኢየሱስ"
            other: "ቁስቋም፣ አርሴማ ቅድስት"
            day: "፮"
        }
        ListElement {
            main: "ሥላሴ"
            other: "ፊሊሞን፣ አብላንዮስ"
            day: "፯"
        }
        ListElement {
            main: "ማቴዎስ"
            other: "ዮልያኖስ፣ አባ ኪሮስ"
            day: "፰"
        }
        ListElement {
            main: "ቶማስ ሐዋርያ"
            other: "እንድርያስ ሐዋርያ፣ አርባ ሰማዕታት"
            day: "፱"
        }
        ListElement {
            main: "በዓለ መስቀሉ ለእግዚእነ"
            other: ""
            day: "፲"
        }
        ListElement {
            main: "ሃና ወኢያቄም"
            other: "ቅዱስ ፋሲለደስ ሰማዕት"
            day: "፲፩"
        }
        ListElement {
            main: "ቅዱስ ሚካኤል"
            other: "ክርስቶስ ሠምራ"
            day: "፲፪"
        }
        ListElement {
            main: "እግዚአብሔር አብ"
            other: "ቅዱስ ሩፋኤል"
            day: "፲፫"
        }
        ListElement {
            main: "አባ አረጋዊ"
            other: "አባ ገብረ ክርስቶስ"
            day: "፲፬"
        }
        ListElement {
            main: "ቂርቆስና ኢየሉጣ"
            other: "ስልፋኮስ"
            day: "፲፭"
        }
        ListElement {
            main: "ኪዳነ ምሕረት"
            other: "ሚካኤል ጳጳስ"
            day: "፲፮"
        }
        ListElement {
            main: "ቅዱስ እስጢፋኖስ"
            other: "ሉቃስ ዘዓምደ ብርሃን"
            day: "፲፯"
        }
        ListElement {
            main: "ፊልጶስ ሐዋርያ"
            other: "ኤዎስጣጤዎስ ሰማዕት"
            day: "፲፰"
        }
        ListElement {
            main: "ቅዱስ ገብርኤል"
            other: "አርቃዲዎስ"
            day: "፲፱"
        }
        ListElement {
            main: "ጽንሰታ ለማርያም"
            other: "ነቢዩ ኤልሳ፣ አባ ሰላማ"
            day: "፳"
        }
        ListElement {
            main: "በዓለ እግዝእትነ ማርያም"
            other: ""
            day: "፳፩"
        }
        ListElement {
            main: "ቅዱስ ዑራኤል"
            other: "ደቅስዮስ"
            day: "፳፪"
        }
        ListElement {
            main: "ቅዱስ ጊዮርጊስ"
            other: "ለጊኖስ ሰማዕት"
            day: "፳፫"
        }
        ListElement {
            main: "አቡነ ተክለ ሃይማኖት"
            other: ""
            day: "፳፬"
        }
        ListElement {
            main: "መድኃኔዓለም"
            other: "ሕዝቅያስ ነቢይ"
            day: "፳፯"
        }
        ListElement {
            main: "በዓለ ወልድ"
            other: "ሳሙኤል ዘወገግ"
            day: "፳፱"
        }
        ListElement {
            main: "ማርቆስ ወንጌላዊ"
            other: ""
            day: "፴"
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
                    color: model.day === amharicNumbers[currentDay - 1] ? "#7e54ff" : Kirigami.Theme.backgroundColor
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
