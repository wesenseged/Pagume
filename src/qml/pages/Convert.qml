// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import "EthiopianCalendar.js" as EthCal

Kirigami.Page {
    id: convertPage

    property date today: new Date()
    property var ethToday: EthCal.toEthiopian(today.getFullYear(), today.getMonth() + 1, today.getDate())

    ListModel {
        id: ethiMonthModel
        ListElement {
            month: "1 - መስከረም"
            days: 30
        }
        ListElement {
            month: "2 - ጥቅምት"
            days: 30
        }
        ListElement {
            month: "3 - ህዳር"
            days: 30
        }
        ListElement {
            month: "4 - ታህሳስ"
            days: 30
        }
        ListElement {
            month: "5 - ጥር"
            days: 30
        }
        ListElement {
            month: "6 - የካቲት"
            days: 30
        }
        ListElement {
            month: "7 - መጋቢት"
            days: 30
        }
        ListElement {
            month: "8 - ሚያዝያ"
            days: 30
        }
        ListElement {
            month: "9 - ግንቦት"
            days: 30
        }
        ListElement {
            month: "10 - ሰኔ"
            days: 30
        }
        ListElement {
            month: "11 - ሐምሌ"
            days: 30
        }
        ListElement {
            month: "12 - ነሐሴ"
            days: 30
        }
        ListElement {
            month: "13 - ጳጉሜን"
            days: 5
        }
    }

    ListModel {
        id: gregMonthModel
        ListElement {
            month: "1 - January"
            days: 31
        }
        ListElement {
            month: "2 - February"
            days: 28
        }
        ListElement {
            month: "3 - March"
            days: 31
        }
        ListElement {
            month: "4 - April"
            days: 30
        }
        ListElement {
            month: "5 - May"
            days: 31
        }
        ListElement {
            month: "6 - June"
            days: 30
        }
        ListElement {
            month: "7 - July"
            days: 31
        }
        ListElement {
            month: "8 - August"
            days: 31
        }
        ListElement {
            month: "9 - September"
            days: 30
        }
        ListElement {
            month: "10 - October"
            days: 31
        }
        ListElement {
            month: "11 - November"
            days: 30
        }
        ListElement {
            month: "12 - December"
            days: 31
        }
    }

    ColumnLayout {
        anchors.fill: parent
        Layout.alignment: Qt.AlignHCenter
        spacing: Kirigami.Units.largeSpacing

        ConvertCard {
            title: i18n("Ethiopian to Gregorian")
            desc: i18n("Select a Ethiopian date below to calculate its corresponding position in the Gregorian calendar system.")
            isEthi: true
            model: ethiMonthModel
            initialDay: convertPage.ethToday.day
            initialMonth: convertPage.ethToday.month
            initialYear: convertPage.ethToday.year
        }

        ConvertCard {
            title: i18n("Gregorian to Ethiopian")
            desc: i18n("Select a Western date below to calculate its corresponding position in the Ethiopian calendar system.")
            isEthi: false
            model: gregMonthModel
            initialDay: convertPage.today.getDate()
            initialMonth: convertPage.today.getMonth() + 1
            initialYear: convertPage.today.getFullYear()
        }
    }

    component ConvertCard: Kirigami.AbstractCard {
        id: card
        property string title
        property string desc
        property bool isEthi
        property var model
        property int initialDay
        property int initialMonth
        property int initialYear

        contentItem: ColumnLayout {
            spacing: 20

            Kirigami.Heading {
                text: card.title
                level: 1
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }

            Controls.Label {
                text: card.desc
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                opacity: 0.7
            }

            RowLayout {
                spacing: Kirigami.Units.largeSpacing
                Layout.alignment: Qt.AlignCenter

                Controls.SpinBox {
                    id: dBox
                    from: 1
                    to: mBox.currentValue
                    value: card.initialDay
                    editable: true
                    Layout.alignment: Qt.AlignHCenter
                }

                Controls.ComboBox {
                    id: mBox
                    model: card.model
                    textRole: "month"
                    valueRole: "days"
                    currentIndex: card.initialMonth - 1
                    Layout.preferredWidth: Kirigami.Units.gridUnit * 10
                }

                Controls.SpinBox {
                    id: yBox
                    value: card.initialYear
                    from: 1900
                    to: 2050
                    editable: true
                    textFromValue: v => v.toString()
                    valueFromText: t => parseInt(t)

                    onValueChanged: {
                        if (card.isEthi) {
                            let isLeap = EthCal.isEthiopianLeapYear(value);
                            ethiMonthModel.setProperty(12, "days", isLeap ? 6 : 5);
                        } else {
                            let isLeap = EthCal.isGregorianLeapYear(value);
                            gregMonthModel.setProperty(1, "days", isLeap ? 29 : 28);
                        }
                    }
                }

                Controls.Button {
                    text: i18n("Convert")
                    font.pointSize: 24
                    onClicked: {
                        let convDate;
                        if (card.isEthi == false) {
                            convDate = EthCal.toEthiopian(yBox.value, mBox.currentIndex + 1, dBox.value);
                        } else {
                            convDate = EthCal.toGregorian(yBox.value, mBox.currentIndex + 1, dBox.value);
                        }
                        resultText.text = `${convDate.month}/${convDate.day}/${convDate.year}`;
                    }
                }
            }

            Kirigami.Heading {
                id: resultText
                text: "M / D / Y"
                font.pointSize: 24
                color: Kirigami.Theme.activeTextColor
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
}
