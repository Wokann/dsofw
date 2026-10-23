; BNFR resource; included by p5.s at P5_FontResource3.
; BNFR 资源，由 p5.s 在 P5_FontResource3 处引入。
    .ascii "JNFR"
    .dh 0x0102
    .dh (P5_FontResource3_MetricsEnd - P5_FontResource3_Metrics) / 2
    .dh 9 | (9 << 5) ; width | height << 5 / 宽 | 高 << 5
; Two metric bytes per glyph; original DS glyphs stay unchanged. / 每字形两个度量字节，保留原 DS 字形。
P5_FontResource3_Metrics:
    .incbin "src/graphic/font_03.bnfr", 0xA, 0x3EE
P5_FontResource3_MetricsEnd:
P5_FontResource3_Bitmaps:
    .incbin "src/graphic/font_03.bnfr", 0x3F8, 0x1794
