const std = @import("std");

// based on Date Field Symbol Table (https://www.unicode.org/reports/tr35/tr35-dates.html#Date_Field_Symbol_Table)
pub const FormatPattern = enum {
    Unknown,	
    G,      // 	AD, BC
    GG,     // 	AD, BC
    GGG	,	// 	AD, BC
    GGGG,	// 	Anno Domini, Before Christ
    y	,	// 	44, 1, 1900, 2017
    yy	,	// 	44, 01, 00, 17
    yyy	,	// 	044, 001, 1900, 2017
    yyyy,	// 	0044, 0001, 1900, 2017
    Y	,	// 	44, 1, 1900, 2017
    YY	,	// 	44, 01, 00, 17
    YYY	,	// 	044, 001, 1900, 2017
    YYYY,	// 	0044, 0001, 1900, 2017
    u	,	// 	-43, 0, 1, 1900, 2017
    uu	,	// 	-43, 01, 1900, 2017
    uuu	,	// 	-043, 001, 1900, 2017
    uuuu,	// 	-0043, 0001, 1900, 2017
    Q	,	// 	1, 2, 3, 4
    QQ	,	// 	01, 02, 03, 04
    QQQ	,	// 	Q1, Q2, Q3, Q4
    QQQQ,	// 	1st quarter, 2nd quarter, ...
    q	,	// 	1, 2, 3, 4
    qo	,	// 	1st, 2nd, 3rd, 4th
    qq	,	// 	01, 02, 03, 04
    qqq	,	// 	Q1, Q2, Q3, Q4
    qqqq	,	// 	1st quarter, 2nd quarter, ...
    M	,	// 	1, 2, ..., 12
    MM	,	// 	01, 02, ..., 12
    MMM	,	// 	Jan, Feb, ..., Dec
    MMMM	,	// 	January, February, ..., December
    MMMMM	,	// 	J, F, ..., D
    L	,	// 	1, 2, ..., 12
    LL	,	// 	01, 02, ..., 12
    LLL	,	// 	Jan, Feb, ..., Dec
    LLLL	,	// 	January, February, ..., December
    w	,	// 	1, 2, ..., 53
    wo	,	// 	1st, 2nd, ..., 53th
    ww	,	// 	01, 02, ..., 53
    I	,	// 	1, 2, ..., 53
    II	,	// 	01, 02, ..., 53
    d	,	// 	1, 2, ..., 31
    dd	,	// 	01, 02, ..., 31
    D	,	// 	1, 2, ..., 365, 366
    DD	,	// 	01, 02, ..., 365, 366
    DDD	,	// 	001, 002, ..., 365, 366
    DDDD	,	// 	...
    E,      // 	Mon, Tue, Wed, ..., Sun
    EE,     // 	Mon, Tue, Wed, ..., Sun
    EEE	,	// 	Mon, Tue, Wed, ..., Sun
    EEEE	,	// 	Monday, Tuesday, ..., Sunday
    EEEEE	,	// 	M, T, W, T, F, S, S
    i	,	// 	1, 2, 3, ..., 7
    io	,	// 	1st, 2nd, ..., 7th
    ii	,	// 	01, 02, ..., 07
    iii	,	// 	Mon, Tue, Wed, ..., Sun
    iiii	,	// 	Monday, Tuesday, ..., Sunday
    iiiii	,	// 	M, T, W, T, F, S, S
    e	,	// 	2, 3, 4, ..., 1
    eo	,	// 	2nd, 3rd, ..., 1st
    ee	,	// 	02, 03, ..., 01
    eee	,	// 	Mon, Tue, Wed, ..., Sun
    eeee	,	// 	Monday, Tuesday, ..., Sunday
    eeeee	,	// 	M, T, W, T, F, S, S
    c	,	// 	2, 3, 4, ..., 1
    co	,	// 	2nd, 3rd, ..., 1st
    cc	,	// 	02, 03, ..., 01
    ccc	,	// 	Mon, Tue, Wed, ..., Sun
    cccc	,	// 	Monday, Tuesday, ..., Sunday
    ccccc	,	// 	M, T, W, T, F, S, S
    a,      // 	AM, PM
    aa,     // 	AM, PM
    aaa	,	// 	AM, PM
    aaaa	,	// 	a.m., p.m.
    b,      // 	AM, PM, noon, midnight
    bb,     // 	AM, PM, noon, midnight
    bbb	,	// 	AM, PM, noon, midnight
    bbbb	,	// 	a.m., p.m., noon, midnight
    B,      // 	at night, in the morning, ...
    BB,     // 	at night, in the morning, ...
    BBB	,	// 	at night, in the morning, ...
    BBBB	,	// 	at night, in the morning, ...
    h	,	// 	1, 2, ..., 11, 12
    hh	,	// 	01, 02, ..., 11, 12
    H	,	// 	0, 1, 2, ..., 23
    HH	,	// 	00, 01, 02, ..., 23
    K	,	// 	1, 2, ..., 11, 0
    KK	,	// 	01, 02, ..., 11, 00
    k	,	// 	24, 1, 2, ..., 23
    kk	,	// 	24, 01, 02, ..., 23
    m	,	// 	0, 1, ..., 59
    mm	,	// 	00, 01, ..., 59
    s	,	// 	0, 1, ..., 59
    ss	,	// 	00, 01, ..., 59
    S	,	// 	0, 1, ..., 9
    SS	,	// 	00, 01, ..., 99
    SSS	,	// 	000, 0001, ..., 999
    X	,	// 	-08, +0530, Z
    XX	,	// 	-0800, +0530, Z
    XXX	,	// 	-08:00, +05:30, Z
    XXXX	,	// 	-0800, +0530, Z, +123456
    x	,	// 	-08, +0530, +00
    xx	,	// 	-0800, +0530, +0000
    xxx	,	// 	-08:00, +05:30, +00:00
    xxxx	,	// 	-0800, +0530, +0000, +123456
    O,      // 	GMT-8, GMT+5:30, GMT+0
    OO,     // 	GMT-8, GMT+5:30, GMT+0
    OOO	,	// 	GMT-8, GMT+5:30, GMT+0
    OOOO	,	// 	GMT-08:00, GMT+05:30, GMT+00:00
    z,      // 	GMT-8, GMT+5:30, GMT+0
    zz,     // 	GMT-8, GMT+5:30, GMT+0
    zzz	,	// 	GMT-8, GMT+5:30, GMT+0
    zzzz	,	// 	GMT-08:00, GMT+05:30, GMT+00:00
    t	,	// 	512969520
    tt	,	// 	...
    T	,	// 	512969520900
    TT	,	// 	...
};

pub fn findPattern(comptime fmt: []const u8) ?FormatPattern {
    return if ((std.meta.stringToEnum(FormatPattern, fmt))) |p| p else null;
}

