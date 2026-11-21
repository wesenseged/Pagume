// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQml
import QtCore
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import "EthiopianCalendar.js" as EthCal
import "BehareHasab.js" as BahireHasab

Kirigami.ScrollablePage {
    id: calendarPage

    property bool mobileLayout: Kirigami.Settings.isMobile || width < 600
    property var months: ["መስከረም", "ጥቅምት", "ሕዳር", "ታኅሣሥ", "ጥር", "የካቲት", "መጋቢት", "ሚያዝያ", "ግንቦት", "ሰኔ", "ሐምሌ", "ነሐሴ", "ጳጕሜን"]
    property var amharicNumbers: ["፩", "፪", "፫", "፬", "፭", "፮", "፯", "፰", "፱", "፲", "፲፩", "፲፪", "፲፫", "፲፬", "፲፭", "፲፮", "፲፯", "፲፰", "፲፱", "፳", "፳፩", "፳፪", "፳፫", "፳፬", "፳፭", "፳፮", "፳፯", "፳፰", "፳፱", "፴"]
    property var arabicNumbers: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
    property var cal: BahireHasab.Calendar(5500, currentEthYear)

    property date today: new Date()
    property var ethToday: EthCal.toEthiopian(today.getFullYear(), today.getMonth() + 1, today.getDate())

    property int currentEthYear: ethToday.year
    property int currentEthMonth: ethToday.month

    Component.onCompleted: {
        calculateBahireHasab();
    }

    property bool isAmharic: appSettings.savedIsAmharic
    property bool isFasting: appSettings.fastIsOn

    Settings {
        id: appSettings
        property bool savedIsAmharic: true
        property bool fastIsOn: false
    }

    ListModel {
        id: publicHolidays
    }

    function calculateBahireHasab() {
        publicHolidays.clear();

        publicHolidays.append({
            name: "እንቁጣጣሽ",
            month: "መስከረም",
            day: 1,
            fast: false
        });

        publicHolidays.append({
            name: "መስቀል",
            month: "መስከረም",
            day: 17,
            fast: false
        });

        publicHolidays.append({
            name: "የብሔር ብሔረሰቦች ቀን",
            month: "ሕዳር",
            day: 29,
            fast: false
        });

        publicHolidays.append({
            name: "ገና",
            month: "ታኅሣሥ",
            day: 29,
            fast: false
        });

        publicHolidays.append({
            name: "ጥምቀት",
            month: "ጥር",
            day: 11,
            fast: false
        });

        publicHolidays.append({
            name: "የሰማዕታት ቀን",
            month: "የካቲት",
            day: 12,
            fast: false
        });

        publicHolidays.append({
            name: "የዓድዋ ድል በዓል",
            month: "የካቲት",
            day: 23,
            fast: false
        });

        publicHolidays.append({
            name: "ደርግ የወደቀበት ቀን",
            month: "ግንቦት",
            day: 20,
            fast: false
        });

        publicHolidays.append({
            name: "መውሊድ",
            month: "ነሐሴ",
            day: 30,
            fast: false
        });
        cal = BahireHasab.Calendar(5500, currentEthYear);

        BahireHasab.init(cal);

        cal.abekte = (cal.wenber * 11) % 30;
        cal.metqe.day = (cal.wenber * 19) % 30;

        cal.tewsaq.wer = BahireHasab.calcDay(cal);
        cal.tewsaq.day = [6, 5, 4, 3, 2, 8, 7][cal.tewsaq.wer];

        BahireHasab.getMebagaAmer(cal);
        BahireHasab.getNenewe(cal);
        BahireHasab.calculateHolidays(cal);

        publicHolidays.append({
            name: "ሆሣዕና",
            month: months[cal.holidays.hosahna.wer],
            day: cal.holidays.hosahna.day,
            fast: false
        });

        publicHolidays.append({
            name: "ስቅለት",
            month: months[cal.holidays.siqlet.wer],
            day: cal.holidays.siqlet.day,
            fast: false
        });

        publicHolidays.append({
            name: "ትንሣኤ",
            month: months[cal.holidays.tinsae.wer],
            day: cal.holidays.tinsae.day,
            fast: false
        });

        publicHolidays.append({
            name: "የሠራተኞች ቀን",
            month: "ሚያዝያ",
            day: 23,
            fast: false
        });

        publicHolidays.append({
            name: "የአርበኞች ቀን",
            month: "ሚያዝያ",
            day: 27,
            fast: false
        });

        publicHolidays.append({
            name: "ዐቢይ ጾም",
            month: months[cal.holidays.abiy_tsom.wer],
            day: cal.holidays.abiy_tsom.day,
            fast: true
        });
    }

    function monthName(index) {
        return EthCal.months[index - 1];
    }

    function holidaysForMonth(month) {
        return publicHolidays.get(0) ? publicHolidays.getRange(0, publicHolidays.count).filter(holiday => holiday.month === monthName(month)) : [];
    }

    ColumnLayout {
        spacing: Kirigami.Units.largeSpacing * 1.5
        Layout.alignment: Qt.AlignHCenter

        // Month Heading
        Kirigami.Heading {
            text: (calendarPage.currentEthMonth >= 1 && calendarPage.currentEthMonth <= EthCal.months.length) ? EthCal.months[calendarPage.currentEthMonth - 1] : ""
            font.pointSize: calendarPage.mobileLayout ? 24 : 36
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        // Toggle switch
        RowLayout {
            spacing: 0
            Layout.alignment: Qt.AlignHCenter
            Rectangle {
                implicitHeight: 36
                implicitWidth: calendarPage.width / 12
                border.color: "#7e54ff"
                color: calendarPage.isAmharic ? "#7e54ff" : Kirigami.Theme.backgroundColor
                Controls.Label {
                    anchors.centerIn: parent
                    text: "፩"
                    font.pointSize: 14
                    color: Kirigami.Theme.textColor
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: appSettings.savedIsAmharic = true
                }
            }

            Rectangle {
                implicitHeight: 36
                implicitWidth: calendarPage.width / 12
                border.color: "#7e54ff"
                color: !calendarPage.isAmharic ? "#7e54ff" : Kirigami.Theme.backgroundColor
                Controls.Label {
                    anchors.centerIn: parent
                    text: "1"
                    font.pointSize: 14
                    color: Kirigami.Theme.textColor
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: appSettings.savedIsAmharic = false
                }
            }
        }

        // Fasting switch
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Controls.Switch {
                text: qsTr("ጾም")
                checked: appSettings.fastIsOn
                onClicked: appSettings.fastIsOn = !appSettings.fastIsOn
            }
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
                        calendarPage.calculateBahireHasab();
                    }
                }
            }

            Controls.Label {
                text: calendarPage.currentEthYear + " ዓ.ም"
                font.pointSize: calendarPage.mobileLayout ? 14 : 20
                font.bold: true
            }

            Controls.ToolButton {
                icon.name: "go-next"
                onClicked: {
                    calendarPage.currentEthMonth++;
                    if (calendarPage.currentEthMonth > 13) {
                        calendarPage.currentEthMonth = 1;
                        calendarPage.currentEthYear++;
                        calendarPage.calculateBahireHasab();
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
                    implicitWidth: calendarPage.width / 12
                    height: 50
                    radius: 6
                    color: "#7e54ff"
                    opacity: 0.8
                    Controls.Label {
                        anchors.centerIn: parent
                        text: calendarPage.mobileLayout ? modelData.substring(0, 1) : modelData
                        color: Kirigami.Theme.textColor
                        font.pointSize: 14
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
                    implicitWidth: calendarPage.width / 12
                    implicitHeight: calendarPage.height / 14
                    radius: 6
                    border.color: Kirigami.Theme.disabledTextColor
                    border.width: validDay ? 1 : 0
                    opacity: validDay ? 0.9 : 0.4

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

                    property bool isfasting: {
                        const currentMonth = calendarPage.currentEthMonth;
                        const currentDay = dayNumber;

                        let abiyTsomMonth = -1;
                        let abiyTsomDay = -1;
                        let fasikaMonth = -1;
                        let fasikaDay = -1;

                        for (let i = 0; i < publicHolidays.count; i++) {
                            const h = publicHolidays.get(i);

                            if (h.name === "ዐቢይ ጾም") {
                                abiyTsomMonth = months.indexOf(h.month) + 1;
                                abiyTsomDay = h.day;
                            }

                            if (h.name === "ትንሣኤ") {
                                fasikaMonth = months.indexOf(h.month) + 1;
                                fasikaDay = h.day;
                            }
                        }

                        if (abiyTsomMonth === -1 || fasikaMonth === -1)
                            return false;

                        const current = currentMonth * 100 + currentDay;
                        const start = abiyTsomMonth * 100 + abiyTsomDay;
                        const end = fasikaMonth * 100 + fasikaDay;
                        return current >= start && current < end;
                    }

                    color: {
                        if (!validDay)
                            return "transparent";
                        if (isHoliday)
                            return "#7e54ff";
                        if (calendarPage.currentEthYear === calendarPage.ethToday.year && calendarPage.currentEthMonth === calendarPage.ethToday.month && dayNumber === calendarPage.ethToday.day)
                            return "#52796f";
                        return Kirigami.Theme.backgroundColor;
                    }

                    Kirigami.Badge {
                        anchors {
                            top: dayCell.top
                            right: dayCell.right
                        }
                        icon.name: "dialog-information"
                        type: Kirigami.Badge.Type.Information
                        visible: appSettings.fastIsOn && isfasting
                    }

                    Controls.Label {
                        anchors.centerIn: parent
                        property string dayText: {
                            if (!dayCell.validDay)
                                return "";

                            var numbers = calendarPage.isAmharic ? calendarPage.amharicNumbers : calendarPage.arabicNumbers;

                            if (!numbers || numbers.length === 0)
                                return "";

                            var index = dayCell.dayNumber - 1;

                            return index >= 0 && index < numbers.length ? numbers[index] : String(dayCell.dayNumber);
                        }
                        text: dayText
                        font.weight: dayCell.isHoliday ? Font.Bold : Font.Light
                        font.pointSize: calendarPage.mobileLayout ? 10 : 16
                        color: dayCell.isHoliday ? Kirigami.Theme.backgroundColor : Kirigami.Theme.textColor
                    }
                }
            }
        }

        // holidays list
        Flow {
            spacing: Kirigami.Units.largeSpacing
            Layout.leftMargin: calendarPage.mobileLayout ? 0 : calendarPage.width / 6
            Layout.fillWidth: true
            Repeater {
                model: publicHolidays
                delegate: Controls.Label {
                    text: model.month + " " + model.day + " - " + model.name
                    color: Kirigami.Theme.textColor
                    leftPadding: 10
                    rightPadding: 10
                    background: Rectangle {
                        color: Kirigami.Theme.backgroundColor
                        radius: 6
                        border.color: "#9573fc"
                        border.width: 2
                    }
                    font.pointSize: calendarPage.mobileLayout ? 12 : 16
                    visible: model.month === monthName(calendarPage.currentEthMonth) && (!model.fast || appSettings.fastIsOn)
                }
            }
        }
    }
}
