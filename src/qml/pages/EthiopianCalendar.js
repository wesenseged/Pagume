.pragma library

const JD_EPOCH_OFFSET_AMETE_MIHRET = 1724220
const JD_OFFSET = 1

function gregToJDN(year, month, day) {
    const a = Math.floor((14 - month) / 12)
    const y = year + 4800 - a
    const m = month + 12 * a - 3
    return (
        day +
        Math.floor((153 * m + 2) / 5) +
        365 * y +
        Math.floor(y / 4) -
        Math.floor(y / 100) +
        Math.floor(y / 400) -
        32045
    )
}

function jdnToGreg(jdn) {
    const a = jdn + 32044
    const b = Math.floor((4 * a + 3) / 146097)
    const c = a - Math.floor((146097 * b) / 4)
    const d = Math.floor((4 * c + 3) / 1461)
    const e = c - Math.floor((1461 * d) / 4)
    const m = Math.floor((5 * e + 2) / 153)
    const day = e - Math.floor((153 * m + 2) / 5) + 1
    const month = m + 3 - 12 * Math.floor(m / 10)
    const year = b * 100 + d - 4800 + Math.floor(m / 10)
    return { year, month, day }
}

function ethToJDN(year, month, day) {
    const leapDays = Math.floor((year - 1) / 4)
    const daysInYear = 30 * (month - 1) + (day - 1)
    return JD_EPOCH_OFFSET_AMETE_MIHRET + 365 * (year - 1) + leapDays + daysInYear
}

function isEthiopianLeapYear(year) {
    return (year - 2015) % 4 === 0
}

function jdnToEth(jdn) {
    const r = jdn - JD_EPOCH_OFFSET_AMETE_MIHRET
    let year = Math.floor((r + 366) / 365.25)

    const newYearJDN = ethToJDN(year, 1, 1)
    let daysPassed = jdn - newYearJDN

    if (daysPassed < 0) {
        year -= 1
        daysPassed = jdn - ethToJDN(year, 1, 1)
    }

    const leap = isEthiopianLeapYear(year)
    const maxDays = leap ? 366 : 365
    if (daysPassed >= maxDays) {
        year += 1
        daysPassed = jdn - ethToJDN(year, 1, 1)
    }

    let month, day
    if (daysPassed < 30 * 12) {
        month = Math.floor(daysPassed / 30) + 1
        day = (daysPassed % 30) + 1
    } else {
        month = 13
        day = daysPassed - 30 * 12 + 1
        const maxPagumeDays = leap ? 6 : 5
        if (day > maxPagumeDays)
            day = maxPagumeDays
    }

    return { year, month, day }
}

function toGregorian(ethYear, ethMonth, ethDay) {
    const jdnEth = ethToJDN(ethYear, ethMonth, ethDay)
    const jdnGreg = jdnEth + JD_OFFSET
    return jdnToGreg(jdnGreg)
}

function toEthiopian(gregYear, gregMonth, gregDay) {
    const jdnGreg = gregToJDN(gregYear, gregMonth, gregDay)
    const jdnEth = jdnGreg - JD_OFFSET
    return jdnToEth(jdnEth)
}

// Ethiopian month names
const months = [
    "መስከረም", "ጥቅምት", "ኅዳር", "ታኅሣስ",
    "ጥር", "የካቲት", "መጋቢት", "ሚያዝያ",
    "ግንቦት", "ሰኔ", "ሐምሌ", "ነሐሴ", "ጳጉሜን"
]

// Ethiopian weekdays (start from Monday)
const weekdays = [
    "ሰኞ", "ማክሰኞ", "ረቡዕ", "ሐሙስ",
    "ዓርብ", "ቅዳሜ", "እሑድ"
]

// Utility to find first weekday of Ethiopian month
function firstWeekdayOfMonth(ethYear, ethMonth) {
    const gDate = toGregorian(ethYear, ethMonth, 1)
    const d = new Date(gDate.year, gDate.month - 1, gDate.day)
    return (d.getDay() + 6) % 7
}

