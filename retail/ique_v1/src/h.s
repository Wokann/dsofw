.create "build/h.bin", 0
; Primary 0x180-byte firmware header.  dsfwtool regenerates component starts,
; component CRCs and the user-settings pointer; the fields below are its fixed template.
; 主固件 0x180 字节头。dsfwtool 重建组件起点、组件 CRC 与用户设置指针；以下为固定模板字段。
; Every field below is explicitly positioned to match FW_HEADER.
; 以下每个字段均以显式偏移对应 FW_HEADER 结构。
; Bit fields at header +0x14.  ROM fields control packed P1/P2 alignment;
; RAM fields select the address-encoding shift used by each boot component.
; 头 +0x14 的位域：ROM 字段决定压缩 P1/P2 对齐，RAM 字段决定启动组件的地址编码位移。
.definelabel HeaderP1RomShiftBits, 0
.definelabel HeaderP1RamShiftBits, 3
.definelabel HeaderP2RomShiftBits, 6
.definelabel HeaderP2RamShiftBits, 9
.definelabel HeaderP1RomAlignmentShift, 2
.definelabel HeaderP1RamAddressShift, 6
.definelabel HeaderP2RomAlignmentShift, 2
.definelabel HeaderP2RamAddressShift, 6
.definelabel HeaderShiftHighFlags, 0x4000
.definelabel HeaderShiftAmounts, HeaderShiftHighFlags | (HeaderP1RomAlignmentShift << HeaderP1RomShiftBits) | (HeaderP1RamAddressShift << HeaderP1RamShiftBits) | (HeaderP2RomAlignmentShift << HeaderP2RomShiftBits) | (HeaderP2RamAddressShift << HeaderP2RamShiftBits)
.definelabel HeaderP1RamEncoding, FirmwarePart1RamaddrFromRam(RetailP1RamAddress, HeaderShiftAmounts)
.definelabel HeaderP2RamEncoding, FirmwarePart2RamaddrFromRam(RetailP2RamAddress, HeaderShiftAmounts)
.orga FirmwareHeaderP3RomaddrOffset
FirmwareHeader_P3RomAddress:       .d16 0          ; generated: P3 physical offset / 8
.orga FirmwareHeaderP4RomaddrOffset
FirmwareHeader_P4RomAddress:       .d16 0          ; generated: P4 physical offset / 8
.orga FirmwareHeaderP3P4Crc16Offset
FirmwareHeader_P3P4Crc16:          .d16 0          ; generated from packed P3/P4
.orga FirmwareHeaderP1P2Crc16Offset
FirmwareHeader_P1P2Crc16:          .d16 0          ; generated from packed P1/P2
.orga FirmwareHeaderIdentifierOffset
FirmwareHeader_Identifier:         .ascii "MAC"
                                   .byte 0xC2
.orga FirmwareHeaderP1RomaddrOffset
FirmwareHeader_P1RomAddress:       .d16 0          ; generated with P1 placement
.orga HeaderPart1RamaddrOffset
FirmwareHeader_P1RamAddress:       .d16 HeaderP1RamEncoding
.orga FirmwareHeaderP2RomaddrOffset
FirmwareHeader_P2RomAddress:       .d16 0          ; generated with P2 placement
.orga HeaderPart2RamaddrOffset
FirmwareHeader_P2RamAddress:       .d16 HeaderP2RamEncoding
.orga HeaderShiftAmountsOffset
FirmwareHeader_ShiftAmounts:       .d16 HeaderShiftAmounts
.orga FirmwareHeaderP5RomaddrOffset
FirmwareHeader_P5RomAddress:       .d16 0          ; generated with P5 placement
; Packed BCD: minute, hour, day, month, year (20YY). / BCD：分、时、日、月、年（20YY）。
.orga FirmwareHeaderTimestampOffset
FirmwareHeader_BuildTimestamp:     .byte 0x15, 0x21, 0x09, 0x06, 0x05 ; 2005-06-09 21:15
.orga FirmwareHeaderConsoleTypeOffset
FirmwareHeader_ConsoleType:        .byte 0x43
.orga FirmwareHeaderUnused1Offset
FirmwareHeader_Unused1:            .d16 0xFFFF
.orga FirmwareHeaderUserSettingsOffset
FirmwareHeader_UserSettingsOffset: .d16 0          ; generated from final image capacity
.orga FirmwareHeaderUnknown1Offset
FirmwareHeader_Unknown1:           .d16 0x0AAE
.orga FirmwareHeaderUnknown2Offset
FirmwareHeader_Unknown2:           .d16 0x18A9
.orga FirmwareHeaderP5Crc16Offset
FirmwareHeader_P5Crc16:            .d16 0          ; generated from packed P5
.orga FirmwareHeaderUnused2Offset
FirmwareHeader_Unused2:            .d16 0xFFFF
; Wi-Fi configuration descriptor: dsfwtool recalculates this CRC when a length is declared.
; Wi-Fi 配置描述符：若长度已声明，dsfwtool 会重算该 CRC；归一化模板不声明私有配置。
.orga FirmwareHeaderWifiConfigCrc16Offset
FirmwareHeader_WifiConfigCrc16:    .d16 0xFFFF   ; CRC16 of [0x2C, 0x2C + length)
.orga FirmwareHeaderWifiConfigLengthOffset
FirmwareHeader_WifiConfigLength:   .d16 0xFFFF   ; 0/FFFF = not declared
.orga FirmwareHeaderWifiConfigOffset
.fill FirmwareHeaderDataBytes - FirmwareHeaderWifiConfigOffset, 0xFF ; Wi-Fi configuration / reserved bytes
.close
