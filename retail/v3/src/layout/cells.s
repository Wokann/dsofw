; BNCL cell placement / BNCL 图像单元摆放
P5_CellLayouts:
P5_CellLayout00:
    .ascii "JNCL"
    .incbin "src/layout/cells_00.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout00_EntriesEnd - P5_CellLayout00_Entries) / 8 ; entry count / 条目数
P5_CellLayout00_Entries:
    .dh 0x065 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002F ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002E ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000030 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000031 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000032 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000033 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000034 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000036 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000035 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000037 ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003A ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003B ; cell index / 图像单元索引
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003A ; cell index / 图像单元索引
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003B ; cell index / 图像单元索引
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
    .dh 0x07B | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000059 ; cell index / 图像单元索引
    .dh 0x07B | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000059 ; cell index / 图像单元索引
    .dh 0x07F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006E ; cell index / 图像单元索引
P5_CellLayout00_EntriesEnd:
P5_CellLayout00_End:
P5_CellLayout01:
    .ascii "JNCL"
    .incbin "src/layout/cells_01.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout01_EntriesEnd - P5_CellLayout01_Entries) / 8 ; entry count / 条目数
P5_CellLayout01_Entries:
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003B ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003A ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003B ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003A ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002E ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002F ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000030 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000031 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000032 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000033 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000034 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000035 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000036 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000037 ; cell index / 图像单元索引
P5_CellLayout01_EntriesEnd:
P5_CellLayout01_End:
P5_CellLayout02:
    .ascii "JNCL"
    .incbin "src/layout/cells_02.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout02_EntriesEnd - P5_CellLayout02_Entries) / 8 ; entry count / 条目数
P5_CellLayout02_Entries:
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000070 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000070 ; cell index / 图像单元索引
    .dh 0x010 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000040 ; cell index / 图像单元索引
    .dh 0x010 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000041 ; cell index / 图像单元索引
    .dh 0x00A | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x019 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000071 ; cell index / 图像单元索引
P5_CellLayout02_EntriesEnd:
P5_CellLayout02_End:
P5_CellLayout03:
    .ascii "JNCL"
    .incbin "src/layout/cells_03.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout03_EntriesEnd - P5_CellLayout03_Entries) / 8 ; entry count / 条目数
P5_CellLayout03_Entries:
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003B ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003A ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003A ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003B ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003C ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003D ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000039 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002E ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002F ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000030 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000031 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000032 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000033 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000034 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000036 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000035 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000037 ; cell index / 图像单元索引
P5_CellLayout03_EntriesEnd:
P5_CellLayout03_End:
P5_CellLayout04:
    .ascii "JNCL"
    .incbin "src/layout/cells_04.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout04_EntriesEnd - P5_CellLayout04_Entries) / 8 ; entry count / 条目数
P5_CellLayout04_Entries:
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFF8 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000043 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A8 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000044 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A9 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A9 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
P5_CellLayout04_EntriesEnd:
P5_CellLayout04_End:
P5_CellLayout05:
    .ascii "JNCL"
    .incbin "src/layout/cells_05.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout05_EntriesEnd - P5_CellLayout05_Entries) / 8 ; entry count / 条目数
P5_CellLayout05_Entries:
    .dh 0x07F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000024 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000022 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000021 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000020 ; cell index / 图像单元索引
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x04F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000010 ; cell index / 图像单元索引
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x055 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000007D ; cell index / 图像单元索引
    .dh 0x07F | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x054 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000023 ; cell index / 图像单元索引
    .dh 0x0E8 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AD | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000026 ; cell index / 图像单元索引
    .dh 0x008 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AD | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000025 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004C ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004D ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004F ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004E ; cell index / 图像单元索引
    .dh 0x036 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x065 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000F ; cell index / 图像单元索引
P5_CellLayout05_EntriesEnd:
P5_CellLayout05_End:
P5_CellLayout06:
    .ascii "JNCL"
    .incbin "src/layout/cells_06.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout06_EntriesEnd - P5_CellLayout06_Entries) / 8 ; entry count / 条目数
P5_CellLayout06_Entries:
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05B | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003E ; cell index / 图像单元索引
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x062 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000042 ; cell index / 图像单元索引
    .dh 0x088 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
    .dh 0x022 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x065 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000053 ; cell index / 图像单元索引
P5_CellLayout06_EntriesEnd:
P5_CellLayout06_End:
P5_CellLayout07:
    .ascii "JNCL"
    .incbin "src/layout/cells_07.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout07_EntriesEnd - P5_CellLayout07_Entries) / 8 ; entry count / 条目数
P5_CellLayout07_Entries:
    .dh 0x080 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x033 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000047 ; cell index / 图像单元索引
P5_CellLayout07_EntriesEnd:
P5_CellLayout07_End:
P5_CellLayout08:
    .ascii "JNCL"
    .incbin "src/layout/cells_08.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout08_EntriesEnd - P5_CellLayout08_Entries) / 8 ; entry count / 条目数
P5_CellLayout08_Entries:
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000018 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000019 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000016 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001A ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000015 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003F ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000013 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000012 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001F ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001E ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001B ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001D ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001C ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000014 ; cell index / 图像单元索引
    .dh 0x01E | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x076 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000045 ; cell index / 图像单元索引
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x078 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000D ; cell index / 图像单元索引
P5_CellLayout08_EntriesEnd:
P5_CellLayout08_End:
P5_CellLayout09:
    .ascii "JNCL"
    .incbin "src/layout/cells_09.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout09_EntriesEnd - P5_CellLayout09_Entries) / 8 ; entry count / 条目数
P5_CellLayout09_Entries:
    .dh 0x065 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002E ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002F ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000030 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000031 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000032 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000033 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000034 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000036 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000035 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x043 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000037 ; cell index / 图像单元索引
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003A ; cell index / 图像单元索引
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003B ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003A ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000003B ; cell index / 图像单元索引
    .dh 0x07B | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x048 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000059 ; cell index / 图像单元索引
    .dh 0x07B | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000059 ; cell index / 图像单元索引
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000038 ; cell index / 图像单元索引
P5_CellLayout09_EntriesEnd:
P5_CellLayout09_End:
P5_CellLayout10:
    .ascii "JNCL"
    .incbin "src/layout/cells_10.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout10_EntriesEnd - P5_CellLayout10_Entries) / 8 ; entry count / 条目数
P5_CellLayout10_Entries:
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x030 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000027 ; cell index / 图像单元索引
    .dh 0x05F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x097 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000006 ; cell index / 图像单元索引
    .dh 0x05F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x019 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000028 ; cell index / 图像单元索引
    .dh 0x0DC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000048 ; cell index / 图像单元索引
    .dh 0x0DC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000049 ; cell index / 图像单元索引
    .dh 0x0DC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004A ; cell index / 图像单元索引
    .dh 0x0DC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x03E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004B ; cell index / 图像单元索引
    .dh 0x009 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000056 ; cell index / 图像单元索引
P5_CellLayout10_EntriesEnd:
P5_CellLayout10_End:
P5_CellLayout11:
    .ascii "JNCL"
    .incbin "src/layout/cells_11.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout11_EntriesEnd - P5_CellLayout11_Entries) / 8 ; entry count / 条目数
P5_CellLayout11_Entries:
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000008C ; cell index / 图像单元索引
    .dh 0x03F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000008D ; cell index / 图像单元索引
    .dh 0x06F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000008E ; cell index / 图像单元索引
    .dh 0x09F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000008F ; cell index / 图像单元索引
    .dh 0x0CF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000090 ; cell index / 图像单元索引
    .dh 0x02F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000008B ; cell index / 图像单元索引
    .dh 0x05F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000008B ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000008B ; cell index / 图像单元索引
    .dh 0x0BF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x068 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000008B ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000075 ; cell index / 图像单元索引
    .dh 0x017 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x081 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000007C ; cell index / 图像单元索引
P5_CellLayout11_EntriesEnd:
P5_CellLayout11_End:
P5_CellLayout12:
    .ascii "JNCL"
    .incbin "src/layout/cells_12.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout12_EntriesEnd - P5_CellLayout12_Entries) / 8 ; entry count / 条目数
P5_CellLayout12_Entries:
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000005A ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000005B ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000005C ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000005D ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000005E ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000005F ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000060 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000061 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000062 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000063 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000064 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000065 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000066 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000067 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000068 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000069 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000007A ; cell index / 图像单元索引
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0B4 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000007B ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0B2 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002D ; cell index / 图像单元索引
    .dh 0x0EF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000048 ; cell index / 图像单元索引
    .dh 0x0EF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000049 ; cell index / 图像单元索引
    .dh 0x0EF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004A ; cell index / 图像单元索引
    .dh 0x0EF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x091 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004B ; cell index / 图像单元索引
P5_CellLayout12_EntriesEnd:
P5_CellLayout12_End:
P5_CellLayout13:
    .ascii "JNCL"
    .incbin "src/layout/cells_13.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout13_EntriesEnd - P5_CellLayout13_Entries) / 8 ; entry count / 条目数
P5_CellLayout13_Entries:
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000001 ; cell index / 图像单元索引
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000073 ; cell index / 图像单元索引
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x030 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000052 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000051 ; cell index / 图像单元索引
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000050 ; cell index / 图像单元索引
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006D ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000E ; cell index / 图像单元索引
P5_CellLayout13_EntriesEnd:
P5_CellLayout13_End:
P5_CellLayout14:
    .ascii "JNCL"
    .incbin "src/layout/cells_14.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout14_EntriesEnd - P5_CellLayout14_Entries) / 8 ; entry count / 条目数
P5_CellLayout14_Entries:
    .dh 0x0E0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x067 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
    .dh 0x0E9 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000010 ; cell index / 图像单元索引
    .dh 0x0E5 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x07C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001B ; cell index / 图像单元索引
    .dh 0x0E0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x087 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000001 ; cell index / 图像单元索引
    .dh 0x0E0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x09F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000002 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000003 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x011 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000004 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x024 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000005 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x033 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000006 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000008 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x054 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000007 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x07B | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000B ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x08C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000A ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x09D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000C ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AE | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000017 ; cell index / 图像单元索引
    .dh 0x015 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000D ; cell index / 图像单元索引
    .dh 0x0F2 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFE | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001C ; cell index / 图像单元索引
    .dh 0x019 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000024 ; cell index / 图像单元索引
    .dh 0x015 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000022 ; cell index / 图像单元索引
    .dh 0x01A | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000023 ; cell index / 图像单元索引
    .dh 0x015 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000E ; cell index / 图像单元索引
    .dh 0x015 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000F ; cell index / 图像单元索引
    .dh 0x015 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000019 ; cell index / 图像单元索引
    .dh 0x015 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x002 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001A ; cell index / 图像单元索引
    .dh 0x0C3 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x052 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000018 ; cell index / 图像单元索引
    .dh 0x089 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x052 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000018 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000021 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x062 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000021 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002C ; cell index / 图像单元索引
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002D ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002E ; cell index / 图像单元索引
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002F ; cell index / 图像单元索引
P5_CellLayout14_EntriesEnd:
P5_CellLayout14_End:
P5_CellLayout15:
    .ascii "JNCL"
    .incbin "src/layout/cells_15.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout15_EntriesEnd - P5_CellLayout15_Entries) / 8 ; entry count / 条目数
P5_CellLayout15_Entries:
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A1 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000016 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A1 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000015 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A1 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000014 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A1 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000013 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A1 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000012 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A1 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000011 ; cell index / 图像单元索引
    .dh 0x015 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000022 ; cell index / 图像单元索引
    .dh 0x019 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000023 ; cell index / 图像单元索引
    .dh 0x019 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000024 ; cell index / 图像单元索引
    .dh 0x015 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000025 ; cell index / 图像单元索引
    .dh 0x019 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000026 ; cell index / 图像单元索引
    .dh 0x019 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000027 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000020 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001F ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001E ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000001D ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000028 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000029 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002A ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0AF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002B ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00E | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000021 ; cell index / 图像单元索引
    .dh 0x001 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x0A7 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000021 ; cell index / 图像单元索引
P5_CellLayout15_EntriesEnd:
P5_CellLayout15_End:
P5_CellLayout16:
    .ascii "JNCL"
    .incbin "src/layout/cells_16.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout16_EntriesEnd - P5_CellLayout16_Entries) / 8 ; entry count / 条目数
P5_CellLayout16_Entries:
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000055 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000029 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000055 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002A ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000055 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002B ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000055 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000002C ; cell index / 图像单元索引
    .dh 0x0C9 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000048 ; cell index / 图像单元索引
    .dh 0x0C9 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000049 ; cell index / 图像单元索引
    .dh 0x0C9 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004A ; cell index / 图像单元索引
    .dh 0x0C9 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000004B ; cell index / 图像单元索引
    .dh 0x019 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000046 ; cell index / 图像单元索引
P5_CellLayout16_EntriesEnd:
P5_CellLayout16_End:
P5_CellLayout17:
    .ascii "JNCL"
    .incbin "src/layout/cells_17.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout17_EntriesEnd - P5_CellLayout17_Entries) / 8 ; entry count / 条目数
P5_CellLayout17_Entries:
    .dh 0x01A | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x022 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000B ; cell index / 图像单元索引
    .dh 0x0C0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000007 ; cell index / 图像单元索引
    .dh 0x0D0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000007 ; cell index / 图像单元索引
    .dh 0x0C0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000007 ; cell index / 图像单元索引
    .dh 0x0D0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000007 ; cell index / 图像单元索引
P5_CellLayout17_EntriesEnd:
P5_CellLayout17_End:
P5_CellLayout18:
    .ascii "JNCL"
    .incbin "src/layout/cells_18.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout18_EntriesEnd - P5_CellLayout18_Entries) / 8 ; entry count / 条目数
P5_CellLayout18_Entries:
    .dh 0x017 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x027 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x037 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x057 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x067 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x087 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x097 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0A7 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0B7 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0C7 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0D8 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000A ; cell index / 图像单元索引
    .dh 0x017 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x027 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x037 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x057 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x067 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x087 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x097 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0A7 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0B7 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0C7 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0D8 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000A ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006C ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006C ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000008 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000091 ; cell index / 图像单元索引
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000092 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000093 ; cell index / 图像单元索引
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000094 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000002 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x050 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000004 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000003 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000005 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000C ; cell index / 图像单元索引
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000054 ; cell index / 图像单元索引
    .dh 0x08C | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000058 ; cell index / 图像单元索引
    .dh 0x0CC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006A ; cell index / 图像单元索引
    .dh 0x0DC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006B ; cell index / 图像单元索引
P5_CellLayout18_EntriesEnd:
P5_CellLayout18_End:
P5_CellLayout19:
    .ascii "JNCL"
    .incbin "src/layout/cells_19.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout19_EntriesEnd - P5_CellLayout19_Entries) / 8 ; entry count / 条目数
P5_CellLayout19_Entries:
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000057 ; cell index / 图像单元索引
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x06F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000057 ; cell index / 图像单元索引
    .dh 0x062 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x039 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000011 ; cell index / 图像单元索引
    .dh 0x062 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x079 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000011 ; cell index / 图像单元索引
    .dh 0x08A | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x02A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000072 ; cell index / 图像单元索引
P5_CellLayout19_EntriesEnd:
P5_CellLayout19_End:
P5_CellLayout20:
    .ascii "JNCL"
    .incbin "src/layout/cells_20.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout20_EntriesEnd - P5_CellLayout20_Entries) / 8 ; entry count / 条目数
P5_CellLayout20_Entries:
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x07F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000057 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000057 ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000057 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x04F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000057 ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x04F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000057 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x07F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000057 ; cell index / 图像单元索引
    .dh 0x009 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01A | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000072 ; cell index / 图像单元索引
P5_CellLayout20_EntriesEnd:
P5_CellLayout20_End:
P5_CellLayout21:
    .ascii "JNCL"
    .incbin "src/layout/cells_21.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout21_EntriesEnd - P5_CellLayout21_Entries) / 8 ; entry count / 条目数
P5_CellLayout21_Entries:
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000001 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000002 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000003 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000004 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000005 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000006 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000007 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000008 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (1 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000A ; cell index / 图像单元索引
P5_CellLayout21_EntriesEnd:
P5_CellLayout21_End:
P5_CellLayout22:
    .ascii "JNCL"
    .incbin "src/layout/cells_22.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout22_EntriesEnd - P5_CellLayout22_Entries) / 8 ; entry count / 条目数
P5_CellLayout22_Entries:
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006F ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000074 ; cell index / 图像单元索引
    .dh 0x0D0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000078 ; cell index / 图像单元索引
    .dh 0x0E0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000007E ; cell index / 图像单元索引
    .dh 0x0E0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000007F ; cell index / 图像单元索引
    .dh 0x0F0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000076 ; cell index / 图像单元索引
    .dh 0x08F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000075 ; cell index / 图像单元索引
    .dh 0x0AF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000075 ; cell index / 图像单元索引
    .dh 0x0CF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000075 ; cell index / 图像单元索引
    .dh 0x0DF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000075 ; cell index / 图像单元索引
    .dh 0x0EF | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0xFFF | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000075 ; cell index / 图像单元索引
    .dh 0x0F0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000079 ; cell index / 图像单元索引
    .dh 0x0D0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000077 ; cell index / 图像单元索引
    .dh 0x03B | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x05C | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000095 ; cell index / 图像单元索引
P5_CellLayout22_EntriesEnd:
P5_CellLayout22_End:
P5_CellLayout23:
    .ascii "JNCL"
    .incbin "src/layout/cells_23.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout23_EntriesEnd - P5_CellLayout23_Entries) / 8 ; entry count / 条目数
P5_CellLayout23_Entries:
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000008A ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000089 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000088 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000087 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000086 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000085 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000084 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000083 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000082 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000081 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000080 ; cell index / 图像单元索引
P5_CellLayout23_EntriesEnd:
P5_CellLayout23_End:
P5_CellLayout24:
    .ascii "JNCL"
    .incbin "src/layout/cells_24.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout24_EntriesEnd - P5_CellLayout24_Entries) / 8 ; entry count / 条目数
P5_CellLayout24_Entries:
    .dh 0x027 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x037 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x047 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x057 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x067 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x077 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x087 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x097 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0A7 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000009 ; cell index / 图像单元索引
    .dh 0x0B8 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000A ; cell index / 图像单元索引
    .dh 0x02F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000008 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x040 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000002 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x050 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000004 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000003 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x070 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000005 ; cell index / 图像单元索引
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x080 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000000C ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000091 ; cell index / 图像单元索引
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000092 ; cell index / 图像单元索引
    .dh 0x000 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000093 ; cell index / 图像单元索引
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x000 | (2 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000094 ; cell index / 图像单元索引
    .dh 0x0D0 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x020 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000017 ; cell index / 图像单元索引
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x01F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006C ; cell index / 图像单元索引
    .dh 0x028 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000054 ; cell index / 图像单元索引
    .dh 0x08C | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x090 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000058 ; cell index / 图像单元索引
    .dh 0x0CC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006A ; cell index / 图像单元索引
    .dh 0x0DC | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x060 | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x0000006B ; cell index / 图像单元索引
P5_CellLayout24_EntriesEnd:
P5_CellLayout24_End:
P5_CellLayout25:
    .ascii "JNCL"
    .incbin "src/layout/cells_25.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout25_EntriesEnd - P5_CellLayout25_Entries) / 8 ; entry count / 条目数
P5_CellLayout25_Entries:
    .dh 0x01D | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
P5_CellLayout25_EntriesEnd:
P5_CellLayout25_End:
P5_CellLayout26:
    .ascii "JNCL"
    .incbin "src/layout/cells_26.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout26_EntriesEnd - P5_CellLayout26_Entries) / 8 ; entry count / 条目数
P5_CellLayout26_Entries:
    .dh 0x00D | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
P5_CellLayout26_EntriesEnd:
P5_CellLayout26_End:
P5_CellLayout27:
    .ascii "JNCL"
    .incbin "src/layout/cells_27.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout27_EntriesEnd - P5_CellLayout27_Entries) / 8 ; entry count / 条目数
P5_CellLayout27_Entries:
    .dh 0x01B | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
P5_CellLayout27_EntriesEnd:
P5_CellLayout27_End:
P5_CellLayout28:
    .ascii "JNCL"
    .incbin "src/layout/cells_28.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout28_EntriesEnd - P5_CellLayout28_Entries) / 8 ; entry count / 条目数
P5_CellLayout28_Entries:
    .dh 0x031 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00F | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
P5_CellLayout28_EntriesEnd:
P5_CellLayout28_End:
P5_CellLayout29:
    .ascii "JNCL"
    .incbin "src/layout/cells_29.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout29_EntriesEnd - P5_CellLayout29_Entries) / 8 ; entry count / 条目数
P5_CellLayout29_Entries:
    .dh 0x008 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
P5_CellLayout29_EntriesEnd:
P5_CellLayout29_End:
P5_CellLayout30:
    .ascii "JNCL"
    .incbin "src/layout/cells_30.bncl", 0x4, 0x2 ; original header word / 原始头字段
    .dh (P5_CellLayout30_EntriesEnd - P5_CellLayout30_Entries) / 8 ; entry count / 条目数
P5_CellLayout30_Entries:
    .dh 0x018 | (0 << 12) | (0 << 14) ; packed X/origin/alignment / X、基准与对齐
    .dh 0x00D | (0 << 12) | (0 << 14) ; packed Y/origin/alignment / Y、基准与对齐
    .word 0x00000000 ; cell index / 图像单元索引
P5_CellLayout30_EntriesEnd:
P5_CellLayout30_End:
P5_CellLayouts_End:
