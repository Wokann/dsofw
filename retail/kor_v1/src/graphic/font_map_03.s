; BNCMP resource; included by p5.s at P5_CharacterMap3.
; BNCMP 资源，由 p5.s 在 P5_CharacterMap3 处引入。
    .ascii "JNCM"
    .incbin "src/graphic/font_map_03.bncmp", 0x4, 0x2 ; original format bytes / 原始格式字节
    .dh (P5_FontResource3_MetricsEnd - P5_FontResource3_Metrics) / 2 ; glyph count / 字形数
P5_CharacterMap3_OffsetBase:
    .word P5_CharacterMap3_Ranges - P5_CharacterMap3_OffsetBase
    .word P5_CharacterMap3_Explicit - P5_CharacterMap3_OffsetBase
P5_CharacterMap3_Ranges:
    .dh (P5_CharacterMap3_RangeEntriesEnd - P5_CharacterMap3_RangeEntries) / 4
P5_CharacterMap3_RangeEntries:
    .dh 0x0020 ; inclusive first / 起始码点（含）
    .dh 0x007F ; inclusive last / 结束码点（含）
    .dh 0x00BF ; inclusive first / 起始码点（含）
    .dh 0x00DD ; inclusive last / 结束码点（含）
    .dh 0x00DF ; inclusive first / 起始码点（含）
    .dh 0x00FD ; inclusive last / 结束码点（含）
    .dh 0x3041 ; inclusive first / 起始码点（含）
    .dh 0x3093 ; inclusive last / 结束码点（含）
    .dh 0x30A1 ; inclusive first / 起始码点（含）
    .dh 0x30F6 ; inclusive last / 结束码点（含）
    .dh 0xE000 ; inclusive first / 起始码点（含）
    .dh 0xE01C ; inclusive last / 结束码点（含）
P5_CharacterMap3_RangeEntriesEnd:
    .byte 0x00, 0x00
P5_CharacterMap3_Explicit:
    .dh (P5_CharacterMap3_End - P5_CharacterMap3_CodePoints) / 2
    .dh (0x007F - 0x0020 + 1) + (0x00DD - 0x00BF + 1) + (0x00FD - 0x00DF + 1) + (0x3093 - 0x3041 + 1) + (0x30F6 - 0x30A1 + 1) + (0xE01C - 0xE000 + 1) ; first explicit glyph index / 离散码点起始字形索引
P5_CharacterMap3_CodePoints:
    .dh 0x00A1
    .dh 0x00A2
    .dh 0x00A3
    .dh 0x00A8
    .dh 0x00A9
    .dh 0x00AE
    .dh 0x00B0
    .dh 0x00B1
    .dh 0x00B4
    .dh 0x00B7
    .dh 0x0152
    .dh 0x0153
    .dh 0x02C6
    .dh 0x02DC
    .dh 0x2010
    .dh 0x2015
    .dh 0x2018
    .dh 0x2019
    .dh 0x201A
    .dh 0x201C
    .dh 0x201D
    .dh 0x201E
    .dh 0x2022
    .dh 0x2026
    .dh 0x2032
    .dh 0x2033
    .dh 0x203A
    .dh 0x203B
    .dh 0x20AC
    .dh 0x2122
    .dh 0x2190
    .dh 0x2191
    .dh 0x2192
    .dh 0x2193
    .dh 0x221E
    .dh 0x2234
    .dh 0x25A0
    .dh 0x25A1
    .dh 0x25B2
    .dh 0x25B3
    .dh 0x25BC
    .dh 0x25BD
    .dh 0x25C6
    .dh 0x25C7
    .dh 0x25CB
    .dh 0x25CE
    .dh 0x25CF
    .dh 0x2605
    .dh 0x2606
    .dh 0x266A
    .dh 0x266D
    .dh 0x266F
    .dh 0x3000
    .dh 0x3001
    .dh 0x3002
    .dh 0x3005
    .dh 0x3008
    .dh 0x3009
    .dh 0x300C
    .dh 0x300D
    .dh 0x3012
    .dh 0x3014
    .dh 0x3015
    .dh 0x309B
    .dh 0x309C
    .dh 0x309D
    .dh 0x309E
    .dh 0x30FB
    .dh 0x30FC
    .dh 0x4E0B
    .dh 0x53EF
    .dh 0x571F
    .dh 0x5B9A
    .dh 0x6027
    .dh 0x65E5
    .dh 0x6708
    .dh 0x6728
    .dh 0x6C34
    .dh 0x6D88
    .dh 0x706B
    .dh 0x80FD
    .dh 0x8A2D
    .dh 0x91D1
    .dh 0xAC00
    .dh 0xAE08
    .dh 0xAE30
    .dh 0xB2A5
    .dh 0xB2C8
    .dh 0xB2E4
    .dh 0xB2EB
    .dh 0xB4DC
    .dh 0xB7EC
    .dh 0xB808
    .dh 0xB85C
    .dh 0xB97C
    .dh 0xBAA9
    .dh 0xC120
    .dh 0xC124
    .dh 0xC131
    .dh 0xC138
    .dh 0xC218
    .dh 0xC2B5
    .dh 0xC694
    .dh 0xC6B4
    .dh 0xC6CC
    .dh 0xC6D4
    .dh 0xC744
    .dh 0xC774
    .dh 0xC77C
    .dh 0xC788
    .dh 0xC815
    .dh 0xC84C
    .dh 0xC8FC
    .dh 0xC9C0
    .dh 0xCE58
    .dh 0xCEEC
    .dh 0xD0DD
    .dh 0xD130
    .dh 0xD1A0
    .dh 0xD50C
    .dh 0xD574
    .dh 0xD654
    .dh 0xE028
    .dh 0xFF01
    .dh 0xFF06
    .dh 0xFF08
    .dh 0xFF09
    .dh 0xFF0B
    .dh 0xFF0C
    .dh 0xFF0D
    .dh 0xFF0E
    .dh 0xFF0F
    .dh 0xFF1A
    .dh 0xFF1B
    .dh 0xFF1D
    .dh 0xFF1F
    .dh 0xFF3B
    .dh 0xFF3C
    .dh 0xFF3D
    .dh 0xFF3E
    .dh 0xFF3F
    .dh 0xFF40
    .dh 0xFF5B
    .dh 0xFF5C
    .dh 0xFF5D
    .dh 0xFF5E
    .dh 0xFFE3
