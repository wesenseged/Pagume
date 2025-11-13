import QtQuick
import QtQml
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import "EthiopianCalendar.js" as EthCal

Kirigami.Page {
    id: calendarPage

    property var amharicNumbers: ["፩", "፪", "፫", "፬", "፭", "፮", "፯", "፰", "፱", "፲", "፲፩", "፲፪", "፲፫", "፲፬", "፲፭", "፲፮", "፲፯", "፲፰", "፲፱", "፳", "፳፩", "፳፪", "፳፫", "፳፬", "፳፭", "፳፮", "፳፯", "፳፰", "፳፱", "፴"]

    property date today: new Date()
    property var ethToday: EthCal.toEthiopian(today.getFullYear(), today.getMonth() + 1, today.getDate())

    property int currentEthYear: ethToday.year
    property int currentEthMonth: ethToday.month

    // List of 13 Ethiopian Public Holidays
    ListModel {
        id: publicHolidays
        ListElement {
            name: "ገና"
            month: "ታኅሣስ"
            day: 29
        }
        ListElement {
            name: "ጥምቀት"
            month: "ጥር"
            day: 11
        }
        ListElement {
            name: "የዓድዋ ድል በዓል"
            month: "የካቲት"
            day: 23
        }
        ListElement {
            name: "የሠራተኞች ቀን"
            month: "ሚያዝያ"
            day: 23
        }
        ListElement {
            name: "የአርበኞች ቀን"
            month: "ግንቦት"
            day: 27
        }
        ListElement {
            name: "የድርግ ወደቀበት ቀን"
            month: "ግንቦት"
            day: 20
        }
        ListElement {
            name: "መውሊድ"
            month: "ነሐሴ"
            day: 30
        }
        ListElement {
            name: "እንቁጣጣሽ"
            month: "መስከረም"
            day: 1
        }
        ListElement {
            name: "መስቀል"
            month: "መስከረም"
            day: 17
        }
    }

    function monthName(index) {
        return EthCal.months[index - 1];
    }

    function holidaysForMonth(month) {
        return publicHolidays.get(0) ? publicHolidays.getRange(0, publicHolidays.count).filter(holiday => holiday.month === monthName(month)) : [];
    }

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: Kirigami.Units.largeSpacing * 2
        spacing: Kirigami.Units.largeSpacing * 1.5
        Layout.alignment: Qt.AlignHCenter

        Kirigami.Heading {
            text: (calendarPage.currentEthMonth >= 1 && calendarPage.currentEthMonth <= EthCal.months.length) ? EthCal.months[calendarPage.currentEthMonth - 1] : ""
            font.pointSize: 36
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        // Month switcher
        RowLayout {
            spacing: Kirigami.Units.largeSpacing
            Layout.alignment: Qt.AlignHCenter

            Controls.ToolButton {
                icon.name: "go-previous"
                onClicked: {
                    calendarPage.currentEthMonth--;
                    if (calendarPage.currentEthMonth < 1) {
                        calendarPage.currentEthMonth = 13;
                        calendarPage.currentEthYear--;
                    }
                }
            }

            Controls.Label {
                text: calendarPage.currentEthYear + " ዓ.ም"
                font.pointSize: 20
                font.bold: true
            }

            Controls.ToolButton {
                icon.name: "go-next"
                onClicked: {
                    calendarPage.currentEthMonth++;
                    if (calendarPage.currentEthMonth > 13) {
                        calendarPage.currentEthMonth = 1;
                        calendarPage.currentEthYear++;
                    }
                }
            }
        }

        // Weekday header
        RowLayout {
            spacing: 5
            Layout.alignment: Qt.AlignHCenter
            Repeater {
                model: EthCal.weekdays
                delegate: Rectangle {
                    width: 80
                    height: 50
                    radius: 6
                    color: "#7e54ff"
                    opacity: 0.8
                    Controls.Label {
                        anchors.centerIn: parent
                        text: modelData
                        color: Kirigami.Theme.textColor
                        font.bold: true
                    }
                }
            }
        }

        // Calendar Grid
        GridLayout {
            id: daysGrid
            columns: 7
            rows: 6
            Layout.alignment: Qt.AlignHCenter

            Repeater {
                model: 42
                delegate: Rectangle {
                    id: dayCell
                    width: 80
                    height: 60
                    radius: 6

                    property int firstDay: EthCal.firstWeekdayOfMonth(calendarPage.currentEthYear, calendarPage.currentEthMonth)
                    property int daysInMonth: (calendarPage.currentEthMonth === 13 ? (EthCal.isEthiopianLeapYear(calendarPage.currentEthYear) ? 6 : 5) : 30)
                    property int indexInMonth: index - firstDay
                    property bool validDay: indexInMonth >= 0 && indexInMonth < daysInMonth
                    property int dayNumber: indexInMonth + 1

                    property bool isHoliday: {
                        const monthStr = monthName(calendarPage.currentEthMonth);
                        for (let i = 0; i < publicHolidays.count; i++) {
                            const h = publicHolidays.get(i);
                            if (h.month === monthStr && h.day === dayNumber)
                                return true;
                        }
                        return false;
                    }

                    color: {
                        if (!validDay)
                            return "transparent";
                        if (isHoliday)
                            return "#7e54ff";
                        if (calendarPage.currentEthYear === calendarPage.ethToday.year && calendarPage.currentEthMonth === calendarPage.ethToday.month && dayNumber === calendarPage.ethToday.day)
                            return Kirigami.Theme.positiveTextColor;
                        return Kirigami.Theme.backgroundColor;
                    }

                    border.color: Kirigami.Theme.disabledTextColor
                    border.width: validDay ? 1 : 0
                    opacity: validDay ? 0.9 : 0.4

                    Controls.Label {
                        anchors.centerIn: parent
                        text: (typeof dayCell.validDay === "boolean" && dayCell.validDay && Array.isArray(calendarPage.amharicNumbers) && calendarPage.amharicNumbers.length > 0) ? (dayCell.dayNumber >= 1 && dayCell.dayNumber <= calendarPage.amharicNumbers.length ? calendarPage.amharicNumbers[dayCell.dayNumber - 1] : String(dayCell.dayNumber)) : ""
                        // text: validDay ? calendarPage.amharicNumbers[dayNumber - 1] : ""
                        color: isHoliday ? Kirigami.Theme.backgroundColor : Kirigami.Theme.textColor
                        font.bold: isHoliday
                    }
                }
            }
        }

        // Monthly holidays list
        ColumnLayout {
            Layout.fillWidth: true
            spacing: Kirigami.Units.smallSpacing
            Repeater {
                model: publicHolidays
                delegate: Controls.Label {
                    visible: model.month === monthName(calendarPage.currentEthMonth)
                    text: model.name + " - " + model.month + " " + model.day
                    color: "#7e54ff"
                    font.bold: true
                }
            }
        }
    }
}
