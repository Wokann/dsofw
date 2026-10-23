; BNLL text placement and UTF-16 strings / BNLL 文本布局与 UTF-16 字符串
.loadtable "../../include/p5-utf16le.tbl","utf-8"
P5_TextLayouts:
P5_TextLayout00:
    .ascii "JNLL"
    .incbin "src/layout/text_00.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout00_EntriesEnd - P5_TextLayout00_Entries) / 12 ; entry count / 条目数
P5_TextLayout00_Entries:
    .dh 0x0A8 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x058 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0C7 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00B | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout00_EntriesEnd:
P5_TextLayout00_End:
P5_TextLayout01:
    .ascii "JNLL"
    .incbin "src/layout/text_01.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout01_EntriesEnd - P5_TextLayout01_Entries) / 12 ; entry count / 条目数
P5_TextLayout01_Entries:
    .dh 0x000 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x000 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout01_EntriesEnd:
P5_TextLayout01_End:
P5_TextLayout02:
    .ascii "JNLL"
    .incbin "src/layout/text_02.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout02_EntriesEnd - P5_TextLayout02_Entries) / 12 ; entry count / 条目数
P5_TextLayout02_Entries:
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x046 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x03 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x086 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x03 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x067 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x027 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout02_EntriesEnd:
P5_TextLayout02_End:
P5_TextLayout03:
    .ascii "JNLL"
    .incbin "src/layout/text_03.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout03_EntriesEnd - P5_TextLayout03_Entries) / 12 ; entry count / 条目数
P5_TextLayout03_Entries:
    .dh 0x000 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x000 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x000 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout03_EntriesEnd:
P5_TextLayout03_End:
P5_TextLayout04:
    .ascii "JNLL"
    .incbin "src/layout/text_04.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout04_EntriesEnd - P5_TextLayout04_Entries) / 12 ; entry count / 条目数
P5_TextLayout04_Entries:
    .dh 0x045 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0B4 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0B8 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0B4 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout04_EntriesEnd:
P5_TextLayout04_End:
P5_TextLayout05:
    .ascii "JNLL"
    .incbin "src/layout/text_05.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout05_EntriesEnd - P5_TextLayout05_Entries) / 12 ; entry count / 条目数
P5_TextLayout05_Entries:
    .dh 0x0B1 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x051 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x050 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x050 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x00 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x096 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x01 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout05_Text02 - P5_TextLayout05 ; offset from this container / 相对本容器偏移
    .dh 0x096 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x01 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout05_Text03 - P5_TextLayout05 ; offset from this container / 相对本容器偏移
    .dh 0x050 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout05_Text02:
P5_TextLayout05_EntriesEnd:
    .stringn "ああああああああああああああ"
    .dh 0x000D
    .dh 0x000A
    .stringn "あ"
    .dh 0x000D
    .dh 0x000A
    .stringn "あ"
    .dh 0x0000
P5_TextLayout05_Text03:
    .stringn "ああああああああああああああ"
    .dh 0x000D
    .dh 0x000A
    .stringn "あ"
    .dh 0x000D
    .dh 0x000A
    .stringn "あ"
    .dh 0x0000
P5_ReferencedData_023A5B84:
P5_TextLayout05_End:
P5_TextLayout06:
    .ascii "JNLL"
    .incbin "src/layout/text_06.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout06_EntriesEnd - P5_TextLayout06_Entries) / 12 ; entry count / 条目数
P5_TextLayout06_Entries:
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (2 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x050 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x074 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout06_Text01 - P5_TextLayout06 ; offset from this container / 相对本容器偏移
    .dh 0x0B0 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x074 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout06_Text02 - P5_TextLayout06 ; offset from this container / 相对本容器偏移
P5_TextLayout06_Text01:
P5_TextLayout06_EntriesEnd:
    .stringn "ああああ"
    .dh 0x0000
P5_TextLayout06_Text02:
    .stringn "ああああ"
    .dh 0x0000
P5_TextLayout06_End:
P5_TextLayout07:
    .ascii "JNLL"
    .incbin "src/layout/text_07.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout07_EntriesEnd - P5_TextLayout07_Entries) / 12 ; entry count / 条目数
P5_TextLayout07_Entries:
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x054 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x04 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout07_EntriesEnd:
P5_TextLayout07_End:
P5_TextLayout08:
    .ascii "JNLL"
    .incbin "src/layout/text_08.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout08_EntriesEnd - P5_TextLayout08_Entries) / 12 ; entry count / 条目数
P5_TextLayout08_Entries:
    .dh 0x0A8 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x058 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_ReferencedData_023A5BF8:
P5_TextLayout08_EntriesEnd:
P5_TextLayout08_End:
P5_TextLayout09:
    .ascii "JNLL"
    .incbin "src/layout/text_09.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout09_EntriesEnd - P5_TextLayout09_Entries) / 12 ; entry count / 条目数
P5_TextLayout09_Entries:
    .dh 0x035 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x046 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x0C ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout09_Text00 - P5_TextLayout09 ; offset from this container / 相对本容器偏移
    .dh 0x032 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x037 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0C ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout09_Text01 - P5_TextLayout09 ; offset from this container / 相对本容器偏移
    .dh 0x0C0 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x046 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout09_Text02 - P5_TextLayout09 ; offset from this container / 相对本容器偏移
    .dh 0x026 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (3 << 12) | (1 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout09_Text03 - P5_TextLayout09 ; offset from this container / 相对本容器偏移
    .dh 0x0DB | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (3 << 12) | (1 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout09_Text04 - P5_TextLayout09 ; offset from this container / 相对本容器偏移
P5_TextLayout09_Text00:
P5_TextLayout09_EntriesEnd:
    .stringn "ちょうそかべもとちか"
    .dh 0x0000
P5_TextLayout09_Text01:
    .stringn "ああああああああああああああああああ"
    .dh 0x000D
    .dh 0x000A
    .stringn "あ"
    .dh 0x0000
P5_TextLayout09_Text02:
    .stringn "14/16"
    .dh 0x0000
P5_TextLayout09_Text03:
    .dh 0xE020
    .dh 0x0000
P5_TextLayout09_Text04:
    .dh 0xE020
    .dh 0x0000
P5_TextLayout09_End:
    .byte 0x00, 0x00
P5_ReferencedData_023A5C94:
P5_TextLayout10:
    .ascii "JNLL"
    .incbin "src/layout/text_10.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout10_EntriesEnd - P5_TextLayout10_Entries) / 12 ; entry count / 条目数
P5_TextLayout10_Entries:
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout10_Text00 - P5_TextLayout10 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AF | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout10_Text01 - P5_TextLayout10 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout10_Text02 - P5_TextLayout10 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x04F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout10_Text03 - P5_TextLayout10 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout10_Text04 - P5_TextLayout10 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout10_Text05 - P5_TextLayout10 ; offset from this container / 相对本容器偏移
; UTF-16 language-selection labels. / UTF-16 语言选择界面文本。
FirmwareText_LanguageSelectionEnglish:
P5_TextLayout10_Text00:
P5_TextLayout10_EntriesEnd:
    .stringn "Select the language to use."
    .dh 0x0000
FirmwareText_LanguageSelectionJapanese:
P5_TextLayout10_Text01:
    .stringn "使用する言語を選択して下さい。"
    .dh 0x0000
FirmwareText_LanguageSelectionGerman:
P5_TextLayout10_Text02:
    .stringn "Wähle die gewünschte Sprache."
    .dh 0x0000
FirmwareText_LanguageSelectionFrench:
P5_TextLayout10_Text03:
    .stringn "Sélectionnez la langue à utiliser."
    .dh 0x0000
FirmwareText_LanguageSelectionSpanish:
P5_TextLayout10_Text04:
    .stringn "Selecciona el idioma que quieras."
    .dh 0x0000
FirmwareText_LanguageSelectionItalian:
P5_TextLayout10_Text05:
    .stringn "Seleziona la lingua del sistema."
    .dh 0x0000
P5_ReferencedData_023A5E44:
P5_TextLayout10_End:
P5_TextLayout11:
    .ascii "JNLL"
    .incbin "src/layout/text_11.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout11_EntriesEnd - P5_TextLayout11_Entries) / 12 ; entry count / 条目数
P5_TextLayout11_Entries:
    .dh 0x011 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x011 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (15 << 8) | 0x09 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout11_Text00 - P5_TextLayout11 ; offset from this container / 相对本容器偏移
    .dh 0x050 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x021 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (15 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout11_Text01 - P5_TextLayout11 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x031 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (15 << 8) | 0x09 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout11_Text02 - P5_TextLayout11 ; offset from this container / 相对本容器偏移
    .dh 0x0AF | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x041 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (15 << 8) | 0x09 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout11_Text03 - P5_TextLayout11 ; offset from this container / 相对本容器偏移
    .dh 0x0E0 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x051 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (15 << 8) | 0x09 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout11_Text04 - P5_TextLayout11 ; offset from this container / 相对本容器偏移
P5_TextLayout11_Text00:
P5_TextLayout11_EntriesEnd:
    .stringn "ちょうそかべもとちか"
    .dh 0x0000
P5_TextLayout11_Text01:
    .stringn "■"
    .dh 0x0000
P5_TextLayout11_Text02:
    .stringn "2004/12/24"
    .dh 0x0000
P5_TextLayout11_Text03:
    .stringn "23:42"
    .dh 0x0000
P5_TextLayout11_Text04:
    .stringn "12/24"
    .dh 0x0000
P5_ReferencedData_023A5ED0:
P5_TextLayout11_End:
P5_TextLayout12:
    .ascii "JNLL"
    .incbin "src/layout/text_12.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout12_EntriesEnd - P5_TextLayout12_Entries) / 12 ; entry count / 条目数
P5_TextLayout12_Entries:
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout12_Text00 - P5_TextLayout12 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout12_Text01 - P5_TextLayout12 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout12_Text02 - P5_TextLayout12 ; offset from this container / 相对本容器偏移
    .dh 0x081 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x04F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout12_Text03 - P5_TextLayout12 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout12_Text04 - P5_TextLayout12 ; offset from this container / 相对本容器偏移
    .dh 0x081 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AF | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x02 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout12_Text05 - P5_TextLayout12 ; offset from this container / 相对本容器偏移
; UTF-16 system-settings loss notices. / UTF-16 系统设置丢失提示。
FirmwareText_SettingsLostEnglish:
P5_TextLayout12_Text00:
P5_TextLayout12_EntriesEnd:
    .stringn "System settings have been lost. Tap "
    .dh 0xE014
    .stringn "."
    .dh 0x0000
FirmwareText_SettingsLostGerman:
P5_TextLayout12_Text01:
    .stringn "Systemeinstellungen sind gelöscht."
    .dh 0x000D
    .dh 0x000A
    .stringn "Bitte berühre "
    .dh 0xE014
    .stringn "."
    .dh 0x0000
FirmwareText_SettingsLostItalian:
P5_TextLayout12_Text02:
    .stringn "Le impostazioni di sistema sono state perdute."
    .dh 0x000D
    .dh 0x000A
    .stringn "Tocca "
    .dh 0xE014
    .stringn "."
    .dh 0x0000
FirmwareText_SettingsLostFrench:
P5_TextLayout12_Text03:
    .stringn "Les paramètres ont été perdus."
    .dh 0x000D
    .dh 0x000A
    .stringn "Pointez la marque "
    .dh 0xE014
    .stringn "."
    .dh 0x0000
FirmwareText_SettingsLostSpanish:
P5_TextLayout12_Text04:
    .stringn "Se ha perdido la configuración."
    .dh 0x000D
    .dh 0x000A
    .stringn "Da un suave toque sobre la marca "
    .dh 0xE014
    .stringn "."
    .dh 0x0000
FirmwareText_SettingsLostJapanese:
P5_TextLayout12_Text05:
    .stringn "設定が消えた可能性があります。"
    .dh 0xE014
    .stringn "をタッチして下さい。"
    .dh 0x0000
P5_ReferencedData_023A6174:
P5_TextLayout12_End:
P5_TextLayout13:
    .ascii "JNLL"
    .incbin "src/layout/text_13.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout13_EntriesEnd - P5_TextLayout13_Entries) / 12 ; entry count / 条目数
P5_TextLayout13_Entries:
    .dh 0x034 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AF | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x01 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x034 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x098 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (2 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x01D | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0B9 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (2 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout13_Text02 - P5_TextLayout13 ; offset from this container / 相对本容器偏移
    .dh 0x02A | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0BA | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (14 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout13_Text03 - P5_TextLayout13 ; offset from this container / 相对本容器偏移
P5_TextLayout13_Text02:
P5_TextLayout13_EntriesEnd:
    .stringn "15/16"
    .dh 0x0000
P5_TextLayout13_Text03:
    .stringn "ああああああああああ"
    .dh 0x0000
P5_TextLayout13_End:
    .byte 0x00, 0x00
P5_TextLayout14:
    .ascii "JNLL"
    .incbin "src/layout/text_14.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout14_EntriesEnd - P5_TextLayout14_Entries) / 12 ; entry count / 条目数
P5_TextLayout14_Entries:
    .dh 0x0C7 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00A | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x07F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout14_EntriesEnd:
P5_TextLayout14_End:
P5_TextLayout15:
    .ascii "JNLL"
    .incbin "src/layout/text_15.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout15_EntriesEnd - P5_TextLayout15_Entries) / 12 ; entry count / 条目数
P5_TextLayout15_Entries:
    .dh 0x01B | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x013 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (8 << 8) | 0x0D ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout15_Text00 - P5_TextLayout15 ; offset from this container / 相对本容器偏移
    .dh 0x01E | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (9 << 8) | 0x06 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout15_Text01 - P5_TextLayout15 ; offset from this container / 相对本容器偏移
    .dh 0x01E | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (9 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout15_Text02 - P5_TextLayout15 ; offset from this container / 相对本容器偏移
    .dh 0x0E0 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x059 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (15 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0A6 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x059 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (15 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x000 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (3 << 8) | 0x07 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout15_Text05 - P5_TextLayout15 ; offset from this container / 相对本容器偏移
P5_TextLayout15_Text00:
P5_TextLayout15_EntriesEnd:
    .stringn "ああああああああああ"
    .dh 0x0000
P5_TextLayout15_Text01:
    .stringn "ああああああああああ"
    .dh 0x0000
P5_TextLayout15_Text02:
    .stringn "ああああああああああ"
    .dh 0x0000
P5_TextLayout15_Text05:
    .stringn "あ"
    .dh 0x0000
P5_TextLayout15_End:
    .byte 0x00, 0x00
P5_TextLayout16:
    .ascii "JNLL"
    .incbin "src/layout/text_16.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout16_EntriesEnd - P5_TextLayout16_Entries) / 12 ; entry count / 条目数
P5_TextLayout16_Entries:
    .dh 0x01B | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x005 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x01B | (0 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x005 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (8 << 8) | 0x0D ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout16_Text01 - P5_TextLayout16 ; offset from this container / 相对本容器偏移
P5_TextLayout16_Text01:
P5_TextLayout16_EntriesEnd:
    .stringn "ああああああああああ"
    .dh 0x0000
P5_TextLayout16_End:
    .byte 0x00, 0x00
P5_ReferencedData_023A62CC:
P5_TextLayout17:
    .ascii "JNLL"
    .incbin "src/layout/text_17.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout17_EntriesEnd - P5_TextLayout17_Entries) / 12 ; entry count / 条目数
P5_TextLayout17_Entries:
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0C ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0B0 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x030 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout17_Text01 - P5_TextLayout17 ; offset from this container / 相对本容器偏移
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x04A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0C ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0B0 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x050 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout17_Text03 - P5_TextLayout17 ; offset from this container / 相对本容器偏移
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0C ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0B0 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout17_Text05 - P5_TextLayout17 ; offset from this container / 相对本容器偏移
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0C ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0B0 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout17_Text07 - P5_TextLayout17 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00B | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout17_Text01:
P5_TextLayout17_EntriesEnd:
    .stringn "11/16"
    .dh 0x0000
P5_TextLayout17_Text03:
    .stringn "3/16"
    .dh 0x0000
P5_TextLayout17_Text05:
    .stringn "16/16"
    .dh 0x0000
P5_TextLayout17_Text07:
    .stringn "8/16"
    .dh 0x0000
P5_TextLayout17_End:
P5_TextLayout18:
    .ascii "JNLL"
    .incbin "src/layout/text_18.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout18_EntriesEnd - P5_TextLayout18_Entries) / 12 ; entry count / 条目数
P5_TextLayout18_Entries:
    .dh 0x0D0 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_ReferencedData_023A6380:
P5_TextLayout18_EntriesEnd:
P5_TextLayout18_End:
P5_TextLayout19:
    .ascii "JNLL"
    .incbin "src/layout/text_19.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout19_EntriesEnd - P5_TextLayout19_Entries) / 12 ; entry count / 条目数
P5_TextLayout19_Entries:
    .dh 0x023 | (0 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x021 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x05A | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x0E ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0BE | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x0E ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (2 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout19_EntriesEnd:
P5_TextLayout19_End:
P5_TextLayout20:
    .ascii "JNLL"
    .incbin "src/layout/text_20.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout20_EntriesEnd - P5_TextLayout20_Entries) / 12 ; entry count / 条目数
P5_TextLayout20_Entries:
    .dh 0x0C0 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x07F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0C0 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout20_EntriesEnd:
P5_TextLayout20_End:
P5_TextLayout21:
    .ascii "JNLL"
    .incbin "src/layout/text_21.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout21_EntriesEnd - P5_TextLayout21_Entries) / 12 ; entry count / 条目数
P5_TextLayout21_Entries:
    .dh 0x03F | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0BF | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x03F | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0BF | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x03F | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0BF | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_ReferencedData_023A641C:
P5_TextLayout21_EntriesEnd:
P5_TextLayout21_End:
P5_TextLayout22:
    .ascii "JNLL"
    .incbin "src/layout/text_22.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout22_EntriesEnd - P5_TextLayout22_Entries) / 12 ; entry count / 条目数
P5_TextLayout22_Entries:
    .dh 0x0B8 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x027 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x03 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (3 << 8) | 0x0F ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x088 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x037 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (3 << 8) | 0x0B ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x098 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x037 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (3 << 8) | 0x0B ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0A8 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x037 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (3 << 8) | 0x0B ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0B8 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x037 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (3 << 8) | 0x0B ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0C8 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x037 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (3 << 8) | 0x0B ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0D8 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x037 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (3 << 8) | 0x0B ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0E8 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x037 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (3 << 8) | 0x0B ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0A0 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x003 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (15 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0BF | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x003 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (15 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x003 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x003 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (15 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0A1 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x003 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (15 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout22_Text11 - P5_TextLayout22 ; offset from this container / 相对本容器偏移
P5_TextLayout22_Text11:
P5_TextLayout22_EntriesEnd:
    .stringn ":"
    .dh 0x0000
P5_TextLayout22_End:
P5_TextLayout23:
    .ascii "JNLL"
    .incbin "src/layout/text_23.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout23_EntriesEnd - P5_TextLayout23_Entries) / 12 ; entry count / 条目数
P5_TextLayout23_Entries:
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x07C | (2 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A8 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x085 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A8 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_ReferencedData_023A64F0:
P5_TextLayout23_EntriesEnd:
P5_TextLayout23_End:
P5_TextLayout24:
    .ascii "JNLL"
    .incbin "src/layout/text_24.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout24_EntriesEnd - P5_TextLayout24_Entries) / 12 ; entry count / 条目数
P5_TextLayout24_Entries:
    .dh 0x033 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x021 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x05A | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x0E ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (2 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
    .dh 0x0BE | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x0E ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (2 << 8) | 0x0E ; font/palette/color / 字体、调色板与颜色
    .word 0 ; no stored text / 无内置文本
P5_TextLayout24_EntriesEnd:
P5_TextLayout24_End:
P5_TextLayout25:
    .ascii "JNLL"
    .incbin "src/layout/text_25.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout25_EntriesEnd - P5_TextLayout25_Entries) / 12 ; entry count / 条目数
P5_TextLayout25_Entries:
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x065 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout25_Text00 - P5_TextLayout25 ; offset from this container / 相对本容器偏移
    .dh 0x081 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout25_Text01 - P5_TextLayout25 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A6 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout25_Text02 - P5_TextLayout25 ; offset from this container / 相对本容器偏移
    .dh 0x085 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (3 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout25_Text03 - P5_TextLayout25 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout25_Text04 - P5_TextLayout25 ; offset from this container / 相对本容器偏移
; UTF-16 French health-prompt text. / UTF-16 法语健康提示文本。
FirmwareText_HealthSafetyFrenchExtraCopy:
P5_TextLayout25_Text00:
P5_TextLayout25_EntriesEnd:
    .stringn "POUR OBTENIR UN EXEMPLAIRE SUPPLEMENTAIRE"
    .dh 0x000D
    .dh 0x000A
    .stringn "CORRESPONDANT A VOTRE REGION,"
    .dh 0x000D
    .dh 0x000A
    .stringn "CONNECTEZ-VOUS A L'ADRESSE SUIVANTE :"
    .dh 0x0000
FirmwareText_HealthSafetyFrenchReadNotice:
P5_TextLayout25_Text01:
    .stringn "AVANT DE JOUER, LISEZ LE LIVRET"
    .dh 0x000D
    .dh 0x000A
    .stringn "DE PRECAUTIONS POUR DES INFORMATIONS"
    .dh 0x000D
    .dh 0x000A
    .stringn "IMPORTANTES SUR VOTRE SANTE ET SECURITE."
    .dh 0x0000
FirmwareText_HealthSafetyFrenchTouch:
P5_TextLayout25_Text02:
    .stringn "Touchez l'écran tactile pour continuer."
    .dh 0x0000
FirmwareText_HealthSafetyFrenchTitle:
P5_TextLayout25_Text03:
    .stringn "ATTENTION-SANTE ET SECURITE"
    .dh 0x0000
FirmwareText_HealthSafetyFrenchUrl:
P5_TextLayout25_Text04:
    .stringn "www.nintendo.com/healthsafety/"
    .dh 0x0000
P5_TextLayout25_End:
    .byte 0x00, 0x00
P5_TextLayout26:
    .ascii "JNLL"
    .incbin "src/layout/text_26.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout26_EntriesEnd - P5_TextLayout26_Entries) / 12 ; entry count / 条目数
P5_TextLayout26_Entries:
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout26_Text00 - P5_TextLayout26 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout26_Text01 - P5_TextLayout26 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A6 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x04 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout26_Text02 - P5_TextLayout26 ; offset from this container / 相对本容器偏移
    .dh 0x089 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (3 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout26_Text03 - P5_TextLayout26 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout26_Text04 - P5_TextLayout26 ; offset from this container / 相对本容器偏移
; UTF-16 German health-prompt text. / UTF-16 德语健康提示文本。
FirmwareText_HealthSafetyGermanExtraCopy:
P5_TextLayout26_Text00:
P5_TextLayout26_EntriesEnd:
    .stringn "UM EINE EXTRA-KOPIE DES TEXTES FÜR DEINE REGION"
    .dh 0x000D
    .dh 0x000A
    .stringn "ZU BEKOMMEN, BESUCHE BITTE FOLGENDE WEBSEITE:"
    .dh 0x0000
FirmwareText_HealthSafetyGermanReadNotice:
P5_TextLayout26_Text01:
    .stringn "BEVOR DU ZU SPIELEN BEGINNST, LIES BITTE DIE"
    .dh 0x000D
    .dh 0x000A
    .stringn "GESUNDHEITS- UND SICHERHEITSHINWEISE"
    .dh 0x000D
    .dh 0x000A
    .stringn "BEZÜGLICH WICHTIGER HINWEISE ZU DEINER"
    .dh 0x000D
    .dh 0x000A
    .stringn "GESUNDHEIT UND SICHERHEIT DURCH."
    .dh 0x0000
FirmwareText_HealthSafetyGermanTouch:
P5_TextLayout26_Text02:
    .stringn "Berühre den Touchscreen, um fortzufahren."
    .dh 0x0000
FirmwareText_HealthSafetyGermanTitle:
P5_TextLayout26_Text03:
    .stringn "WARNUNG-GESUNDHEIT UND SICHERHEIT"
    .dh 0x0000
FirmwareText_HealthSafetyGermanUrl:
P5_TextLayout26_Text04:
    .stringn "www.nintendo.com/healthsafety/"
    .dh 0x0000
P5_TextLayout26_End:
    .byte 0x00, 0x00
P5_TextLayout27:
    .ascii "JNLL"
    .incbin "src/layout/text_27.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout27_EntriesEnd - P5_TextLayout27_Entries) / 12 ; entry count / 条目数
P5_TextLayout27_Entries:
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout27_Text00 - P5_TextLayout27 ; offset from this container / 相对本容器偏移
    .dh 0x081 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout27_Text01 - P5_TextLayout27 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A6 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout27_Text02 - P5_TextLayout27 ; offset from this container / 相对本容器偏移
    .dh 0x02D | (0 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (3 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout27_Text03 - P5_TextLayout27 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout27_Text04 - P5_TextLayout27 ; offset from this container / 相对本容器偏移
; UTF-16 Italian health-prompt text. / UTF-16 意大利语健康提示文本。
FirmwareText_HealthSafetyItalianExtraCopy:
P5_TextLayout27_Text00:
P5_TextLayout27_EntriesEnd:
    .stringn "PER OTTENERNE UNA COPIA SUPPLEMENTARE RELATIVA"
    .dh 0x000D
    .dh 0x000A
    .stringn "ALLA TUA AREA VAI ALL'INDIRIZZO INTERNET:"
    .dh 0x0000
FirmwareText_HealthSafetyItalianReadNotice:
P5_TextLayout27_Text01:
    .stringn "PRIMA DI INIZIARE A GIOCARE, LEGGI ATTENTAMENTE"
    .dh 0x000D
    .dh 0x000A
    .stringn "IL LIBRETTO DI PRECAUZIONI PER LA SALUTE E LA"
    .dh 0x000D
    .dh 0x000A
    .stringn "SICUREZZA, DOVE TROVI IMPORTANTI INFORMAZIONI"
    .dh 0x000D
    .dh 0x000A
    .stringn "PER LA TUA SALUTE E SICUREZZA."
    .dh 0x000D
    .dh 0x000A
    .dh 0x0000
FirmwareText_HealthSafetyItalianTouch:
P5_TextLayout27_Text02:
    .stringn "Tocca il touch screen per continuare."
    .dh 0x0000
FirmwareText_HealthSafetyItalianTitle:
P5_TextLayout27_Text03:
    .stringn "ATTENZIONE-SALUTE E SICUREZZA"
    .dh 0x0000
FirmwareText_HealthSafetyItalianUrl:
P5_TextLayout27_Text04:
    .stringn "www.nintendo.com/healthsafety/"
    .dh 0x0000
P5_TextLayout27_End:
    .byte 0x00, 0x00
P5_TextLayout28:
    .ascii "JNLL"
    .incbin "src/layout/text_28.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout28_EntriesEnd - P5_TextLayout28_Entries) / 12 ; entry count / 条目数
P5_TextLayout28_Entries:
    .dh 0x043 | (0 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x010 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (3 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text00 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x082 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x031 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x0A ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text01 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x07B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text02 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x03C | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text03 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A7 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text04 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x038 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x029 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x0E ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text05 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x05A | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x09F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x07 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text06 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x084 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x029 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text07 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x044 | (0 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x008 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text08 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x00B | (0 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x055 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text09 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x00E | (0 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x029 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x0E ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text10 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x0A7 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x029 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x0E ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text11 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x02A | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x055 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text12 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x054 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x0E ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text13 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x061 | (0 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x008 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text14 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x086 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x008 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text15 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x092 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x073 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text16 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x085 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x055 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text17 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x055 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text18 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x021 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x073 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text19 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x0A7 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x055 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x02 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text20 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x09F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (2 << 12) | (0 << 8) | 0x07 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout28_Text21 - P5_TextLayout28 ; offset from this container / 相对本容器偏移
; UTF-16 Japanese health-prompt resources. / UTF-16 日语健康提示资源。
FirmwareText_HealthSafetyJapaneseTitle:
P5_TextLayout28_Text00:
P5_TextLayout28_EntriesEnd:
    .stringn "警告－健康と安全のために"
    .dh 0x0000
P5_TextLayout28_Text01:
    .stringn "遊ぶまえに取扱説明書の「安全に使用していただく"
    .dh 0x000D
    .dh 0x000A
    .stringn "ために…"
FirmwareText_HealthSafetyJapaneseBody:
    .stringn "」をお読みください。ここには、あなたの"
    .dh 0x000D
    .dh 0x000A
    .stringn "健康と安全のための大切な内容が書かれています。"
    .dh 0x0000
FirmwareText_HealthSafetyJapaneseWebCopy:
P5_TextLayout28_Text02:
    .stringn "この内容はホームページでも見ることができます。"
    .dh 0x0000
FirmwareText_HealthSafetyJapaneseUrl:
P5_TextLayout28_Text03:
    .stringn "www.nintendo.co.jp/anzen/"
    .dh 0x0000
FirmwareText_HealthSafetyJapaneseTouch:
P5_TextLayout28_Text04:
    .stringn "続けるには画面をタッチしてください。"
    .dh 0x0000
P5_TextLayout28_Text05:
    .stringn "とりあつかいせつめいしょ"
    .dh 0x0000
P5_TextLayout28_Text06:
    .stringn "がめん"
    .dh 0x0000
P5_TextLayout28_Text07:
    .stringn "あんぜん"
    .dh 0x0000
P5_TextLayout28_Text08:
    .stringn "けいこく"
    .dh 0x0000
P5_TextLayout28_Text09:
    .stringn " けんこう"
    .dh 0x0000
P5_TextLayout28_Text10:
    .stringn "あそ"
    .dh 0x0000
P5_TextLayout28_Text11:
    .stringn "しよう"
    .dh 0x0000
P5_TextLayout28_Text12:
    .stringn "あんぜん"
    .dh 0x0000
P5_TextLayout28_Text13:
    .stringn "よ"
    .dh 0x0000
P5_TextLayout28_Text14:
    .stringn " けんこう"
    .dh 0x0000
P5_TextLayout28_Text15:
    .stringn "あんぜん"
    .dh 0x0000
P5_TextLayout28_Text16:
    .stringn "み"
    .dh 0x0000
P5_TextLayout28_Text17:
    .stringn "ないよう"
    .dh 0x0000
P5_TextLayout28_Text18:
    .stringn "たいせつ"
    .dh 0x0000
P5_TextLayout28_Text19:
    .stringn "ないよう"
    .dh 0x0000
P5_TextLayout28_Text20:
    .stringn "か"
    .dh 0x0000
P5_TextLayout28_Text21:
    .stringn "つづ"
    .dh 0x0000
P5_TextLayout28_End:
P5_TextLayout29:
    .ascii "JNLL"
    .incbin "src/layout/text_29.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout29_EntriesEnd - P5_TextLayout29_Entries) / 12 ; entry count / 条目数
P5_TextLayout29_Entries:
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout29_Text00 - P5_TextLayout29 ; offset from this container / 相对本容器偏移
    .dh 0x081 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout29_Text01 - P5_TextLayout29 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A6 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout29_Text02 - P5_TextLayout29 ; offset from this container / 相对本容器偏移
    .dh 0x088 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (3 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout29_Text03 - P5_TextLayout29 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout29_Text04 - P5_TextLayout29 ; offset from this container / 相对本容器偏移
; UTF-16 Spanish health-prompt text. / UTF-16 西班牙语健康提示文本。
FirmwareText_HealthSafetySpanishExtraCopy:
P5_TextLayout29_Text00:
P5_TextLayout29_EntriesEnd:
    .stringn "PARA OBTENER UNA COPIA ADICIONAL CORRESPONDIENTE"
    .dh 0x000D
    .dh 0x000A
    .stringn "A TU ZONA, VISITA ESTA PÁGINA WEB:"
    .dh 0x0000
FirmwareText_HealthSafetySpanishReadNotice:
P5_TextLayout29_Text01:
    .stringn "ANTES DE COMENZAR A JUGAR, LEE CON ATENCIÓN EL"
    .dh 0x000D
    .dh 0x000A
    .stringn "FOLLETO DE PRECAUCIONES SOBRE SALUD Y SEGURIDAD,"
    .dh 0x000D
    .dh 0x000A
    .stringn "EN EL QUE SE RECOGE INFORMACIÓN IMPORTANTE"
    .dh 0x000D
    .dh 0x000A
    .stringn "PARA TU SALUD Y SEGURIDAD."
    .dh 0x0000
FirmwareText_HealthSafetySpanishTouch:
P5_TextLayout29_Text02:
    .stringn "Toca la pantalla táctil para continuar."
    .dh 0x0000
FirmwareText_HealthSafetySpanishTitle:
P5_TextLayout29_Text03:
    .stringn "ADVERTENCIA SOBRE SALUD Y SEGURIDAD"
    .dh 0x0000
FirmwareText_HealthSafetySpanishUrl:
P5_TextLayout29_Text04:
    .stringn "www.nintendo.com/healthsafety/"
    .dh 0x0000
P5_TextLayout29_End:
    .byte 0x00, 0x00
P5_TextLayout30:
    .ascii "JNLL"
    .incbin "src/layout/text_30.bnll", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_TextLayout30_EntriesEnd - P5_TextLayout30_Entries) / 12 ; entry count / 条目数
P5_TextLayout30_Entries:
    .dh 0x0B7 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (3 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout30_Text00 - P5_TextLayout30 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x07E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (1 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout30_Text01 - P5_TextLayout30 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x06 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout30_Text02 - P5_TextLayout30 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x01 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout30_Text03 - P5_TextLayout30 ; offset from this container / 相对本容器偏移
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A6 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x01 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (0 << 12) | (0 << 8) | 0x08 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout30_Text04 - P5_TextLayout30 ; offset from this container / 相对本容器偏移
    .dh 0x02A | (0 << 12) | (1 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .byte 0x02 ; signed horizontal spacing / 有符号横间距
    .byte 0x00 ; signed vertical spacing / 有符号纵间距
    .dh (3 << 12) | (0 << 8) | 0x05 ; font/palette/color / 字体、调色板与颜色
    .word P5_TextLayout30_Text05 - P5_TextLayout30 ; offset from this container / 相对本容器偏移
P5_TextLayout30_Text00:
P5_TextLayout30_EntriesEnd:
    .stringn "TH AND SAFETY"
    .dh 0x0000
; UTF-16 English health-prompt text and resource identifier. / UTF-16 英语健康提示文本及资源标识。
FirmwareText_HealthSafetyExtraCopy:
P5_TextLayout30_Text01:
    .stringn "TO GET AN EXTRA COPY FOR YOUR REGION, GO ONLINE AT"
    .dh 0x0000
FirmwareText_HealthSafetyReadNotice:
P5_TextLayout30_Text02:
    .stringn "BEFORE PLAYING, READ THE HEALTH"
    .dh 0x000D
    .dh 0x000A
    .stringn "AND SAFETY PRECAUTIONS BOOKLET"
    .dh 0x000D
    .dh 0x000A
    .stringn "FOR IMPORTANT INFORMATION"
    .dh 0x000D
    .dh 0x000A
    .stringn "ABOUT YOUR HEALTH AND SAFETY."
    .dh 0x0000
FirmwareText_HealthSafetyUrl:
P5_TextLayout30_Text03:
    .stringn "www.nintendo.com/healthsafety/"
    .dh 0x0000
FirmwareText_TouchToContinue:
P5_TextLayout30_Text04:
    .stringn "Touch the Touch Screen to continue."
    .dh 0x0000
FirmwareResourceId_HealthWarning:
P5_TextLayout30_Text05:
    .stringn "WARNING-HEAL"
    .dh 0x0000
P5_TextLayout30_End:
P5_TextLayouts_End:
.loadtable "../../include/utf16le.tbl","utf-8"
