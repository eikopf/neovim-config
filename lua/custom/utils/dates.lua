-- sourced from https://github.com/renerocksai/telekasten.nvim/blob/main/lua/telekasten/utils/dates.lua

local M = {}
local luadate = require("custom.utils.luadate")

--- Returns the day of week (1..Monday, ..., 7..Sunday) for Dec, 31st of year
--- see https://webspace.science.uu.nl/~gent0113/calendar/isocalendar.htm
--- see https://en.wikipedia.org/wiki/ISO_week_date
M.dow_for_year = function(year)
    return (
        year
        + math.floor(year / 4)
        - math.floor(year / 100)
        + math.floor(year / 400)
    ) % 7
end

M.weeks_in_year = function(year)
    local d = 0
    local dy = M.dow_for_year(year) == 4 -- current year ends Thursday
    local dyy = M.dow_for_year(year - 1) == 3 -- previous year ends Wednesday
    if dy or dyy then
        d = 1
    end
    return 52 + d
end

M.days_in_year = function(year)
    local t = os.time({ year = year, month = 12, day = 31 })
    return os.date("*t", t).yday
end

M.date_from_doy = function(year, doy)
    local ret = {
        year = year,
        month = 1,
        day = doy,
    }
    -- january is clear immediately
    if doy < 32 then
        return ret
    end

    local dmap = {
        [1] = 31,
        [2] = 28, -- will be fixed further down
        [3] = 31,
        [4] = 30,
        [5] = 31,
        [6] = 30,
        [7] = 31,
        [8] = 31,
        [9] = 30,
        [10] = 31,
        [11] = 30,
        [12] = 31,
    }
    if M.days_in_year(year) == 366 then
        dmap[2] = 29
    end

    for month, d in pairs(dmap) do
        doy = doy - d
        if doy < 0 then
            ret.day = doy + d
            ret.month = month
            return ret
        end
    end
    return ret -- unreachable if input values are sane
end

-- the algo on wikipedia seems wrong, so we opt for full-blown luadate
M.isoweek_to_date = function(year, isoweek)
    local ret = luadate(year .. "-W" .. string.format("%02d", isoweek) .. "-1")
    return {
        year = ret:getyear(),
        month = ret:getmonth(),
        day = ret:getday(),
    }
end

local function daysuffix(day)
    day = tostring(day)
    if (day == "1") or (day == "21") or (day == "31") then
        return "st"
    end
    if (day == "2") or (day == "22") then
        return "nd"
    end
    if (day == "3") or (day == "23") then
        return "rd"
    end
    return "th"
end

local daymap = {
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
}
local monthmap = {
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
}

M.dateformats = {
    date = "%Y-%m-%d",
    week = "%V",
    isoweek = "%Y-W%V",
    time24 = "%H:%M:%S",
    time12 = "%I:%M:%S %p",
}

function M.calculate_dates(date, calendar_monday)
    local time = os.time(date)
    local dinfo = os.date("*t", time) -- this normalizes the input to a full date table
    local oneday = 24 * 60 * 60 -- hours * days * seconds
    local oneweek = 7 * oneday
    local df = M.dateformats

    local dates = {}

    -- this is to compensate for the calendar showing M-Su, but os.date Su is
    -- always wday = 1
    local wday = dinfo.wday - 1
    if wday == 0 then
        wday = 7
    end

    dates.year = dinfo.year
    dates.month = dinfo.month
    dates.day = dinfo.day
    dates.hdate = daymap[wday]
        .. ", "
        .. monthmap[dinfo.month]
        .. " "
        .. dinfo.day
        .. daysuffix(dinfo.day)
        .. ", "
        .. dinfo.year

    local zonehour = string.sub(os.date("%z"), 1, 3)
    local zonemin = string.sub(os.date("%z"), 4, 5)
    dates.rfc3339 = os.date(df.date, time)
        .. os.date("T%H:%M:%S")
        .. "Z"
        .. zonehour
        .. ":"
        .. zonemin

    dates.time24 = os.date(df.time24, time)
    dates.time12 = os.date(df.time12, time)
    dates.date = os.date(df.date, time)
    dates.prevday = os.date(df.date, time - oneday)
    dates.nextday = os.date(df.date, time + oneday)
    dates.week = os.date(df.week, time)
    dates.prevweek = os.date(df.week, time - oneweek)
    dates.nextweek = os.date(df.week, time + oneweek)
    dates.isoweek = os.date(df.isoweek, time)
    dates.isoprevweek = os.date(df.isoweek, time - oneweek)
    dates.isonextweek = os.date(df.isoweek, time + oneweek)

    -- things get a bit hairy at the year rollover.  W01 only starts the first week ofs
    -- January if it has more than 3 days. Partial weeks with less than 4 days are
    -- considered W52, but os.date still sets the year as the new year, so Jan 1 2022
    -- would appear as being in 2022-W52.  That breaks linear linking respective
    -- of next/prev week, so we want to put the days of that partial week in
    -- January in 2021-W52.  This tweak will only change the ISO formatted week string.
    if tonumber(dates.week) == 52 and tonumber(dates.month) == 1 then
        dates.isoweek = tostring(dates.year - 1) .. "-W52"
    end

    -- Find the Sunday that started this week regardless of the calendar
    -- display preference.  Then use that as the base to calculate the dates
    -- for the days of the current week.
    -- Finally, adjust Sunday to suit user calendar preference.
    local starting_sunday = time - (wday * oneday)
    local sunday_offset = 0
    if calendar_monday == 1 then
        sunday_offset = 7
    end
    dates.monday = os.date(df.date, starting_sunday + (1 * oneday))
    dates.tuesday = os.date(df.date, starting_sunday + (2 * oneday))
    dates.wednesday = os.date(df.date, starting_sunday + (3 * oneday))
    dates.thursday = os.date(df.date, starting_sunday + (4 * oneday))
    dates.friday = os.date(df.date, starting_sunday + (5 * oneday))
    dates.saturday = os.date(df.date, starting_sunday + (6 * oneday))
    dates.sunday = os.date(df.date, starting_sunday + (sunday_offset * oneday))

    return dates
end

local function check_isoweek(year, isoweek, ydate)
    print("***********   KW " .. isoweek .. " " .. year .. ": ")
    -- local ret = M.weeknumber_to_date(year, isoweek)
    local ret = M.isoweek_to_date(year, isoweek)
    local result = ret.year == ydate.year
        and ret.month == ydate.month
        and ret.day == ydate.day
    print(
        ret.year
            .. "-"
            .. ret.month
            .. "-"
            .. ret.day
            .. " == "
            .. ydate.year
            .. "-"
            .. ydate.month
            .. "-"
            .. ydate.day
            .. " : "
            .. tostring(result)
    )
end

M.run_tests = function()
    print(check_isoweek(2020, 1, { year = 2019, month = 12, day = 30 })) -- 30.12.2019
    print(check_isoweek(2020, 52, { year = 2020, month = 12, day = 21 })) -- 21.12.2020
    print(check_isoweek(2020, 53, { year = 2020, month = 12, day = 28 })) -- 28.12.2020
    print(check_isoweek(2021, 1, { year = 2021, month = 1, day = 4 })) -- 4.1.2020
    print(check_isoweek(2021, 52, { year = 2021, month = 12, day = 27 })) -- 27.12.2021
    print(check_isoweek(2022, 1, { year = 2022, month = 1, day = 3 })) -- 3.1.2022
end

-- M.run_tests()

return M
