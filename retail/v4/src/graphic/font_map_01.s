; BNCMP resource; included by p5.s at P5_CharacterMap1.
; BNCMP 资源，由 p5.s 在 P5_CharacterMap1 处引入。
    .ascii "JNCM"
    .incbin "src/graphic/font_map_01.bncmp", 0x4, 0x2 ; original format bytes / 原始格式字节
    .dh (P5_FontResource1_MetricsEnd - P5_FontResource1_Metrics) / 2 ; glyph count / 字形数
P5_CharacterMap1_OffsetBase:
    .word P5_CharacterMap1_Ranges - P5_CharacterMap1_OffsetBase
    .word P5_CharacterMap1_Explicit - P5_CharacterMap1_OffsetBase
P5_CharacterMap1_Ranges:
    .dh (P5_CharacterMap1_RangeEntriesEnd - P5_CharacterMap1_RangeEntries) / 4
P5_CharacterMap1_RangeEntries:
P5_CharacterMap1_RangeEntriesEnd:
    .byte 0x00, 0x00
P5_CharacterMap1_Explicit:
    .dh (P5_CharacterMap1_End - P5_CharacterMap1_CodePoints) / 2
    .dh 0 ; first explicit glyph index / 离散码点起始字形索引
P5_CharacterMap1_CodePoints:
    .dh 0x0020
    .dh 0x0040
    .dh 0x3000
    .dh 0x3042
    .dh 0x3044
    .dh 0x3046
    .dh 0x304B
    .dh 0x304C
    .dh 0x304F
    .dh 0x3051
    .dh 0x3053
    .dh 0x3057
    .dh 0x305B
    .dh 0x305C
    .dh 0x305D
    .dh 0x305F
    .dh 0x3064
    .dh 0x3065
    .dh 0x3068
    .dh 0x306A
    .dh 0x307F
    .dh 0x3081
    .dh 0x3087
    .dh 0x3088
    .dh 0x308A
    .dh 0x3093
