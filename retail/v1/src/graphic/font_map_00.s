; BNCMP resource; included by p5.s at P5_CharacterMap0.
; BNCMP 资源，由 p5.s 在 P5_CharacterMap0 处引入。
    .ascii "JNCM"
    .incbin "src/graphic/font_map_00.bncmp", 0x4, 0x2 ; original format bytes / 原始格式字节
    .dh (P5_FontResource0_MetricsEnd - P5_FontResource0_Metrics) / 2 ; glyph count / 字形数
P5_CharacterMap0_OffsetBase:
    .word P5_CharacterMap0_Ranges - P5_CharacterMap0_OffsetBase
    .word P5_CharacterMap0_Explicit - P5_CharacterMap0_OffsetBase
P5_CharacterMap0_Ranges:
    .dh (P5_CharacterMap0_RangeEntriesEnd - P5_CharacterMap0_RangeEntries) / 4
P5_CharacterMap0_RangeEntries:
    .dh 0x0040 ; inclusive first / 起始码点（含）
    .dh 0x0049 ; inclusive last / 结束码点（含）
    .dh 0xE020 ; inclusive first / 起始码点（含）
    .dh 0xE027 ; inclusive last / 结束码点（含）
P5_CharacterMap0_RangeEntriesEnd:
    .byte 0x00, 0x00
P5_CharacterMap0_Explicit:
    .dh (P5_CharacterMap0_End - P5_CharacterMap0_CodePoints) / 2
    .dh (0x0049 - 0x0040 + 1) + (0xE027 - 0xE020 + 1) ; first explicit glyph index / 离散码点起始字形索引
P5_CharacterMap0_CodePoints:
    .dh 0x0020
    .dh 0x002D
    .dh 0x002E
    .dh 0x004C
    .dh 0x004D
    .dh 0x004E
    .dh 0x004F
    .dh 0x0050
    .dh 0x0052
    .dh 0x0053
    .dh 0x0054
    .dh 0x0055
    .dh 0x0056
    .dh 0x0057
    .dh 0x0059
    .dh 0x005A
    .dh 0x0061
    .dh 0x0062
    .dh 0x0063
    .dh 0x0065
    .dh 0x0069
    .dh 0x006E
    .dh 0x006F
    .dh 0x0072
    .dh 0x0073
    .dh 0x0074
    .dh 0x0075
    .dh 0x0079
    .dh 0x3000
    .dh 0x305F
    .dh 0x3068
    .dh 0x306B
    .dh 0x306E
    .dh 0x3081
    .dh 0x5065
    .dh 0x5168
    .dh 0x544A
    .dh 0x5B89
    .dh 0x5EB7
    .dh 0x8B66
    .dh 0xFF0D
