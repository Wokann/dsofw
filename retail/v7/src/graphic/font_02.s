; BNFR resource; included by p5.s at P5_FontResource2.
; BNFR 资源，由 p5.s 在 P5_FontResource2 处引入。
    .ascii "JNFR"
    .dh 0x0102
    .dh (P5_FontResource2_MetricsEnd - P5_FontResource2_Metrics) / 2
    .dh 9 | (12 << 5) ; width | height << 5 / 宽 | 高 << 5
; Two metric bytes per glyph; original DS glyphs stay unchanged. / 每字形两个度量字节，保留原 DS 字形。
P5_FontResource2_Metrics:
    .incbin "src/graphic/font_02.bnfr", 0xA, 0x488
P5_FontResource2_MetricsEnd:
P5_FontResource2_Bitmaps:
    .incbin "src/graphic/font_02.bnfr", 0x492, 0x1FB8
