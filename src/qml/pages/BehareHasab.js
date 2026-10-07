// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later
.pragma library

function Month(day = 0, wer = 0) {
    return {
        day: day,
        wer: wer
    }
}

function Calendar(zemen, year) {
    return {
        zemen: zemen,
        year: year,
        wenber: 0,
        abekte: 0,
        metqe: Month(),
        mebaja_hamer: 0,
        tewsaq: Month(),
        nenewe: Month(),

        holidays: {
            abiy_tsom: Month(14),
            debre_zeyit: Month(41),
            hosahna: Month(62),
            siqlet: Month(67),
            tinsae: Month(69),
            rikbe_kahenat: Month(93),
            tsiret: Month(108),
            peraklitos: Month(118),
            tsome_hawaryat: Month(119),
            tseme_dihnet: Month(121)
        }
    }
}

function init(calendar) {
    getWenber(calendar)
    calcZemen(calendar)
}

function getWenber(calendar) {
    const amete_alem = calendar.year + calendar.zemen
    const abiy_kemer = amete_alem % 532
    const maikel_kemer = abiy_kemer % 76
    const nius_kemer = maikel_kemer % 19

    calendar.wenber = nius_kemer - 1
}

function calcZemen(calendar) {
    const result = (calendar.zemen + calendar.year) % 4

    const zemenSem = [
        "ዘመነ ዮሐንስ",
        "ዘመነ ማቴዎስ",
        "ዘመነ ማርቆስ",
        "ዘመነ ሉቃስ"
    ]

    calendar.zemenName = zemenSem[result]
}

function calcMesk1(calendar) {
    const amete_alem = calendar.year + calendar.zemen
    const metene_rabit = Math.floor(amete_alem / 4)

    return (amete_alem + metene_rabit) % 7
}

function calcDay(calendar) {
    let metq = calendar.metqe.day

    if (calendar.metqe.day < 14) {
        metq = 30 + metq
        calendar.metqe.wer = 1
    }

    if (calendar.metqe.day === 0) {
        metq = 30
        calendar.metqe.wer = 0
    }

    return (calcMesk1(calendar) + metq - 1) % 7
}

function getMebagaAmer(calendar) {
    const sum = calendar.metqe.day + calendar.tewsaq.day

    calendar.mebaja_hamer =
        sum > 30 ? sum % 30 : sum
}

function getNenewe(calendar) {
    calendar.nenewe.day = calendar.mebaja_hamer

    if (calendar.metqe.wer === 0) {
        calendar.nenewe.wer = 4
    }

    if (calendar.metqe.wer === 1) {
        calendar.nenewe.wer = 5
    }

    if (calendar.abekte === 0) {
        calendar.nenewe.wer = 5
    }

    if (calendar.mebaja_hamer > 30) {
        calendar.nenewe.wer = 5
    }
}

function calBeal(beal, nenewe) {
    const day = beal.day + nenewe.day

    if (day > 30) {
        beal.wer = Math.floor(day / 30) + nenewe.wer
        beal.day = day % 30
    } else {
        beal.day = day
        beal.wer = nenewe.wer
    }

    if (beal.day == 0) {
        beal.day = 30
        beal.wer-=1
  }

}

function calculateHolidays(calendar) {
    const holidays = calendar.holidays

    calBeal(holidays.abiy_tsom, calendar.nenewe)
    calBeal(holidays.hosahna, calendar.nenewe)
    calBeal(holidays.siqlet, calendar.nenewe)
    calBeal(holidays.tinsae, calendar.nenewe)
    // calBeal(holidays.debre_zeyit, calendar.nenewe)
    // calBeal(holidays.rikbe_kahenat, calendar.nenewe)
    // calBeal(holidays.tsiret, calendar.nenewe)
    // calBeal(holidays.peraklitos, calendar.nenewe)
    // calBeal(holidays.tsome_hawaryat, calendar.nenewe)
    // calBeal(holidays.tseme_dihnet, calendar.nenewe)

    return holidays
}
