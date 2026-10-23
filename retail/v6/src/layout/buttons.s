; BNBL touch rectangles / BNBL 触摸矩形
P5_ButtonLayouts:
P5_ButtonLayout00:
    .ascii "JNBL"
    .incbin "src/layout/buttons_00.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout00_EntriesEnd - P5_ButtonLayout00_Entries) / 6 ; entry count / 条目数
P5_JnblRecord0Entries:
P5_ButtonLayout00_Entries:
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x071 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x31 ; height / 高
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x31 ; height / 高
    .dh 0x07F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x7F ; width / 宽
    .byte 0x11 ; height / 高
P5_JnblRecord0Padding:
P5_ButtonLayout00_EntriesEnd:
P5_ButtonLayout00_End:
    .dh 0x0000
P5_ReferencedData_023A4AD4:
P5_ButtonLayout01:
    .ascii "JNBL"
    .incbin "src/layout/buttons_01.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout01_EntriesEnd - P5_ButtonLayout01_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout01_Entries:
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x31 ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x31 ; height / 高
P5_ReferencedData_023A4B00:
P5_ButtonLayout01_EntriesEnd:
P5_ButtonLayout01_End:
P5_ButtonLayout02:
    .ascii "JNBL"
    .incbin "src/layout/buttons_02.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout02_EntriesEnd - P5_ButtonLayout02_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout02_Entries:
    .dh 0x010 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xE0 ; width / 宽
    .byte 0x40 ; height / 高
    .dh 0x010 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xE0 ; width / 宽
    .byte 0x40 ; height / 高
P5_ReferencedData_023A4B14:
P5_ButtonLayout02_EntriesEnd:
P5_ButtonLayout02_End:
P5_ButtonLayout03:
    .ascii "JNBL"
    .incbin "src/layout/buttons_03.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout03_EntriesEnd - P5_ButtonLayout03_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout03_Entries:
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x071 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x61 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x071 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x31 ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x31 ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x61 ; width / 宽
    .byte 0x31 ; height / 高
P5_ButtonLayout03_EntriesEnd:
P5_ButtonLayout03_End:
    .byte 0x00, 0x00
P5_ButtonLayout04:
    .ascii "JNBL"
    .incbin "src/layout/buttons_04.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout04_EntriesEnd - P5_ButtonLayout04_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout04_Entries:
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AA | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x50 ; width / 宽
    .byte 0x15 ; height / 高
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AA | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x50 ; width / 宽
    .byte 0x15 ; height / 高
P5_ButtonLayout04_EntriesEnd:
P5_ButtonLayout04_End:
P5_ButtonLayout05:
    .ascii "JNBL"
    .incbin "src/layout/buttons_05.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout05_EntriesEnd - P5_ButtonLayout05_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout05_Entries:
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x017 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xC0 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x07F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xC0 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x0E8 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AC | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x075 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AA | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x15 ; width / 宽
    .byte 0x15 ; height / 高
    .dh 0x008 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AC | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
P5_ButtonLayout05_EntriesEnd:
P5_ButtonLayout05_End:
    .byte 0x00, 0x00
P5_ButtonLayout06:
    .ascii "JNBL"
    .incbin "src/layout/buttons_06.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout06_EntriesEnd - P5_ButtonLayout06_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout06_Entries:
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x50 ; width / 宽
    .byte 0x11 ; height / 高
    .dh 0x088 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x50 ; width / 宽
    .byte 0x11 ; height / 高
P5_ButtonLayout06_EntriesEnd:
P5_ButtonLayout06_End:
P5_ButtonLayout07:
    .ascii "JNBL"
    .incbin "src/layout/buttons_07.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout07_EntriesEnd - P5_ButtonLayout07_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout07_Entries:
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x04F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x07F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x0AF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x04F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x07F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x0AF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x017 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x04F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x017 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x07F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x017 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
    .dh 0x0AF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x017 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x30 ; height / 高
P5_ButtonLayout07_EntriesEnd:
P5_ButtonLayout07_End:
P5_ButtonLayout08:
    .ascii "JNBL"
    .incbin "src/layout/buttons_08.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout08_EntriesEnd - P5_ButtonLayout08_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout08_Entries:
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x30 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x31 ; height / 高
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x31 ; width / 宽
    .byte 0x31 ; height / 高
P5_ReferencedData_023A4C2C:
P5_ButtonLayout08_EntriesEnd:
P5_ButtonLayout08_End:
P5_ButtonLayout09:
    .ascii "JNBL"
    .incbin "src/layout/buttons_09.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout09_EntriesEnd - P5_ButtonLayout09_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout09_Entries:
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x030 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xE0 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x05F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x019 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x40 ; width / 宽
    .byte 0x0F ; height / 高
    .dh 0x05F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x40 ; width / 宽
    .byte 0x0F ; height / 高
P5_ButtonLayout09_EntriesEnd:
P5_ButtonLayout09_End:
    .byte 0x00, 0x00
P5_ReferencedData_023A4C48:
P5_ButtonLayout10:
    .ascii "JNBL"
    .incbin "src/layout/buttons_10.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout10_EntriesEnd - P5_ButtonLayout10_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout10_Entries:
    .dh 0x008 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x099 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x20 ; width / 宽
    .byte 0x20 ; height / 高
P5_ButtonLayout10_EntriesEnd:
P5_ButtonLayout10_End:
    .byte 0x00, 0x00
P5_ReferencedData_023A4C58:
P5_ButtonLayout11:
    .ascii "JNBL"
    .incbin "src/layout/buttons_11.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout11_EntriesEnd - P5_ButtonLayout11_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout11_Entries:
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x6E ; width / 宽
    .byte 0x12 ; height / 高
    .dh 0x010 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x030 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x07 ; width / 宽
    .byte 0x07 ; height / 高
    .dh 0x0EC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x07 ; width / 宽
    .byte 0x07 ; height / 高
    .dh 0x010 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x07 ; width / 宽
    .byte 0x07 ; height / 高
    .dh 0x0EC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x07 ; width / 宽
    .byte 0x07 ; height / 高
P5_ButtonLayout11_EntriesEnd:
P5_ButtonLayout11_End:
    .byte 0x00, 0x00
P5_ButtonLayout12:
    .ascii "JNBL"
    .incbin "src/layout/buttons_12.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout12_EntriesEnd - P5_ButtonLayout12_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout12_Entries:
    .dh 0x0E0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x067 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x20 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x0E0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x088 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x20 ; width / 宽
    .byte 0x17 ; height / 高
    .dh 0x0E0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A0 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x20 ; width / 宽
    .byte 0x18 ; height / 高
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x11 ; width / 宽
    .byte 0x0F ; height / 高
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x011 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x0E ; height / 高
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x024 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x0F ; height / 高
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x033 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x0F ; height / 高
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x0F ; height / 高
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x055 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x0F ; height / 高
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x0E ; width / 宽
    .byte 0x0E ; height / 高
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x07C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x0E ; width / 宽
    .byte 0x0E ; height / 高
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x0E ; width / 宽
    .byte 0x0E ; height / 高
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x09E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x0E ; width / 宽
    .byte 0x0E ; height / 高
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x0E ; width / 宽
    .byte 0x0E ; height / 高
    .dh 0x0F5 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x0A ; width / 宽
    .byte 0x0A ; height / 高
    .dh 0x017 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x011 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x68 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x016 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x08 ; width / 宽
    .byte 0x0A ; height / 高
    .dh 0x0C3 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x052 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x3A ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x089 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x052 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x3A ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x016 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xDE ; width / 宽
    .byte 0x0A ; height / 高
P5_ButtonLayout12_EntriesEnd:
P5_ButtonLayout12_End:
P5_ButtonLayout13:
    .ascii "JNBL"
    .incbin "src/layout/buttons_13.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout13_EntriesEnd - P5_ButtonLayout13_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout13_Entries:
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x021 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xC0 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xC0 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xC0 ; width / 宽
    .byte 0x20 ; height / 高
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0xC0 ; width / 宽
    .byte 0x20 ; height / 高
P5_ReferencedData_023A4D20:
P5_ButtonLayout13_EntriesEnd:
P5_ButtonLayout13_End:
P5_ButtonLayout14:
    .ascii "JNBL"
    .incbin "src/layout/buttons_14.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout14_EntriesEnd - P5_ButtonLayout14_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout14_Entries:
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x088 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x088 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x088 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x088 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
P5_ButtonLayout14_EntriesEnd:
P5_ButtonLayout14_End:
P5_ButtonLayout15:
    .ascii "JNBL"
    .incbin "src/layout/buttons_15.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout15_EntriesEnd - P5_ButtonLayout15_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout15_Entries:
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x050 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x08C | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x64 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x64 ; width / 宽
    .byte 0x10 ; height / 高
P5_ButtonLayout15_EntriesEnd:
P5_ButtonLayout15_End:
    .byte 0x00, 0x00
P5_ReferencedData_023A4DBC:
P5_ButtonLayout16:
    .ascii "JNBL"
    .incbin "src/layout/buttons_16.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout16_EntriesEnd - P5_ButtonLayout16_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout16_Entries:
    .dh 0x02F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x32 ; width / 宽
    .byte 0x26 ; height / 高
    .dh 0x02F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x065 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x32 ; width / 宽
    .byte 0x26 ; height / 高
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x030 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x1F ; height / 高
P5_ReferencedData_023A4DDC:
P5_ButtonLayout16_EntriesEnd:
P5_ButtonLayout16_End:
P5_ButtonLayout17:
    .ascii "JNBL"
    .incbin "src/layout/buttons_17.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout17_EntriesEnd - P5_ButtonLayout17_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout17_Entries:
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x050 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x1F ; height / 高
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x050 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x60 ; width / 宽
    .byte 0x1F ; height / 高
P5_ButtonLayout17_EntriesEnd:
P5_ButtonLayout17_End:
P5_ButtonLayout18:
    .ascii "JNBL"
    .incbin "src/layout/buttons_18.bnbl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_ButtonLayout18_EntriesEnd - P5_ButtonLayout18_Entries) / 6 ; entry count / 条目数
P5_ButtonLayout18_Entries:
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x050 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x10 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x08C | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x64 ; width / 宽
    .byte 0x10 ; height / 高
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x64 ; width / 宽
    .byte 0x10 ; height / 高
P5_ButtonLayout18_EntriesEnd:
P5_ButtonLayout18_End:
    .byte 0x00, 0x00
P5_ButtonLayouts_End:
