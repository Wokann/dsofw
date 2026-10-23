; BNCD resource; included by p5.s at P5_CellResource2.
; BNCD 资源，由 p5.s 在 P5_CellResource2 处引入。
    .ascii "JNCD"
    .dh 0x0101
    .dh (P5_CellResource2_DirectoryEnd - P5_CellResource2_Directory) / 6
    .word P5_CellResource2_Directory - P5_CellResource2
    .word P5_CellResource2_Auxiliary - P5_CellResource2
    .word P5_CellResource2_Payload - P5_CellResource2
    .word P5_CellResource2_End - P5_CellResource2_Payload
    .word 0x00000002 ; unknown field, preserved / 未知字段，原样保留
P5_CellResource2_Directory:
    .byte 0x10
    .byte 0x10
    .dh (P5_CellResource2_Aux000 - P5_CellResource2_Auxiliary) / 12
    .dh 0x0004 ; record count / 辅助记录数
P5_CellResource2_DirectoryEnd:
    .byte 0x00, 0x00
; Record fields and pixel/palette interpretation remain unconfirmed. / 记录字段及像素、调色板解释尚待确认。
P5_CellResource2_Auxiliary:
P5_CellResource2_Aux000:
    .byte 0x00, 0x00, 0x00, 0x00
    .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
P5_CellResource2_Aux001:
    .byte 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    .byte 0x01, 0x00, 0x00, 0x00
P5_CellResource2_Aux002:
    .byte 0x00, 0x00, 0x08, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
P5_CellResource2_Aux003:
    .byte 0x08, 0x00, 0x08, 0x10, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
P5_CellResource2_Aux004:
P5_CellResource2_Payload:
; OBJ graphics from the complete BNCD file. / 从完整 BNCD 文件引用 OBJ 图像区。
    .incbin "src/graphic/cells_02.bncd", 0x54, 0x100
