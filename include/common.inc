; NDS hardware registers and input
; Names follow GBATEK/libnds usage; each CPU has its own I/O view.
.definelabel REG_DISPCNT_A,                           0x04000000
.definelabel REG_DISPSTAT,                             0x04000004
.definelabel REG_VCOUNT,                              0x04000006
.definelabel REG_BG0CNT,                              0x04000008
.definelabel REG_BG1CNT,                              0x0400000a
.definelabel REG_BG2CNT,                              0x0400000c
.definelabel REG_BG3CNT,                              0x0400000e
.definelabel REG_BG0HOFS,                             0x04000010
.definelabel REG_BG0VOFS,                             0x04000012
.definelabel REG_BG1HOFS,                             0x04000014
.definelabel REG_BG1VOFS,                             0x04000016
.definelabel REG_BG2HOFS,                             0x04000018
.definelabel REG_BG2VOFS,                             0x0400001a
.definelabel REG_BG3HOFS,                             0x0400001c
.definelabel REG_BG3VOFS,                             0x0400001e
.definelabel REG_BG2PA,                               0x04000020
.definelabel REG_BG2PB,                               0x04000022
.definelabel REG_BG2PC,                               0x04000024
.definelabel REG_BG2PD,                               0x04000026
.definelabel REG_BG2X,                                0x04000028
.definelabel REG_BG2Y,                                0x0400002c
.definelabel REG_BG3PA,                               0x04000030
.definelabel REG_BG3PB,                               0x04000032
.definelabel REG_BG3PC,                               0x04000034
.definelabel REG_BG3PD,                               0x04000036
.definelabel REG_BG3X,                                0x04000038
.definelabel REG_BG3Y,                                0x0400003c
.definelabel REG_BLDCNT,                              0x04000050
.definelabel REG_BLDALPHA,                            0x04000052
.definelabel REG_MASTER_BRIGHT,                       0x0400006c
.definelabel REG_DMA0SAD,                             0x040000b0
.definelabel REG_DISPCNT_B,                           0x04001000
.definelabel REG_BG0CNT_SUB,                          0x04001008
.definelabel REG_BG1CNT_SUB,                          0x0400100a
.definelabel REG_BG2CNT_SUB,                          0x0400100c
.definelabel REG_BG3CNT_SUB,                          0x0400100e
.definelabel REG_BG0HOFS_SUB,                         0x04001010
.definelabel REG_BG0VOFS_SUB,                         0x04001012
.definelabel REG_BG1HOFS_SUB,                         0x04001014
.definelabel REG_BG1VOFS_SUB,                         0x04001016
.definelabel REG_BG2HOFS_SUB,                         0x04001018
.definelabel REG_BG2VOFS_SUB,                         0x0400101a
.definelabel REG_BG3HOFS_SUB,                         0x0400101c
.definelabel REG_BG3VOFS_SUB,                         0x0400101e
.definelabel REG_BG2PA_SUB,                           0x04001020
.definelabel REG_BG2PB_SUB,                           0x04001022
.definelabel REG_BG2PC_SUB,                           0x04001024
.definelabel REG_BG2PD_SUB,                           0x04001026
.definelabel REG_BG2X_SUB,                            0x04001028
.definelabel REG_BG2Y_SUB,                            0x0400102c
.definelabel REG_BG3PA_SUB,                           0x04001030
.definelabel REG_BG3PB_SUB,                           0x04001032
.definelabel REG_BG3PC_SUB,                           0x04001034
.definelabel REG_BG3PD_SUB,                           0x04001036
.definelabel REG_BG3X_SUB,                            0x04001038
.definelabel REG_BG3Y_SUB,                            0x0400103c
.definelabel REG_BLDCNT_SUB,                          0x04001050
.definelabel REG_BLDALPHA_SUB,                        0x04001052
.definelabel REG_MASTER_BRIGHT_SUB,                   0x0400106c
.definelabel REG_IME,                                 0x04000208
.definelabel REG_IE,                                  0x04000210
.definelabel REG_IF,                                  0x04000214
; Same physical address, with CPU-specific external-bus control semantics.
; 同一物理地址；两个 CPU 的外部总线控制语义不同。
.definelabel REG_EXMEMCNT_ARM9,                       0x04000204
.definelabel REG_EXMEMSTAT_ARM7,                      0x04000204
.definelabel REG_KEYINPUT,                            0x04000130
.definelabel REG_KEYXY,                               0x04000136
.definelabel REG_RCNT_ARM7,                           0x04000134
; ARM7 legacy serial interface. / ARM7 旧式串行接口。
.definelabel REG_SIODATA32_ARM7,                      0x04000120
.definelabel REG_SIOCNT_ARM7,                         0x04000128
.definelabel TIMER0_DATA,                             0x04000100
.definelabel TIMER0_CR,                               0x04000102
.definelabel TIMER1_DATA,                             0x04000104
.definelabel TIMER1_CR,                               0x04000106
.definelabel REG_IPC_SYNC,                            0x04000180
.definelabel REG_IPC_FIFO_CR,                         0x04000184
.definelabel REG_IPC_FIFO_TX,                         0x04000188
.definelabel REG_IPC_FIFO_RX,                         0x04100000
.definelabel REG_AUXSPICNT,                           0x040001a0
.definelabel REG_ROMCTRL,                             0x040001a4
.definelabel REG_GCCMDOUT,                            0x040001a8
.definelabel REG_SPICNT,                              0x040001c0
.definelabel REG_SPIDATA,                             0x040001c2
.definelabel VRAM_A_CR,                               0x04000240
.definelabel VRAM_B_CR,                               0x04000241
.definelabel VRAM_C_CR,                               0x04000242
.definelabel VRAM_D_CR,                               0x04000243
.definelabel VRAM_E_CR,                               0x04000244
.definelabel VRAM_F_CR,                               0x04000245
.definelabel VRAM_G_CR,                               0x04000246
.definelabel REG_WRAMCNT,                             0x04000247
.definelabel VRAM_H_CR,                               0x04000248
.definelabel VRAM_I_CR,                               0x04000249
.definelabel REG_DIVCNT,                              0x04000280
.definelabel REG_DIV_NUMER,                           0x04000290
.definelabel REG_DIV_DENOM,                           0x04000298
.definelabel REG_DIV_RESULT,                          0x040002a0
.definelabel REG_SQRTCNT,                             0x040002b0
.definelabel REG_SQRT_RESULT,                         0x040002b4
.definelabel REG_SQRT_PARAM,                          0x040002b8
.definelabel REG_POSTFLG,                             0x04000300
.definelabel REG_POWERCNT,                            0x04000304
; ARM7 view: sound/Wi-Fi power, and Wi-Fi bus waitstates.
; ARM7 视图：音频/Wi-Fi 供电与 Wi-Fi 总线等待周期。
.definelabel REG_POWERCNT_ARM7,                       0x04000304
.definelabel REG_WIFIWAITCNT_ARM7,                    0x04000206
.definelabel REG_GCDATAIN,                            0x04100010

; ARM7 audio registers. / ARM7 音频寄存器。
.definelabel REG_SOUNDCNT_ARM7,                       0x04000500
.definelabel SCHANNEL0_CR,                            0x04000400
.definelabel SCHANNEL0_PAN,                           0x04000402
.definelabel SCHANNEL0_TIMER,                         0x04000408
.definelabel REG_SNDCAP0CNT,                          0x04000508
.definelabel REG_SNDCAP1CNT,                          0x04000509
.definelabel REG_SNDCAP0DAD,                          0x04000510
.definelabel REG_SNDCAP0LEN,                           0x04000514
.definelabel REG_SNDCAP1DAD,                          0x04000518
.definelabel REG_SNDCAP1LEN,                          0x0400051c
.definelabel KEY_A,                                   (1 << 0)
.definelabel KEY_B,                                   (1 << 1)
.definelabel KEY_SELECT,                              (1 << 2)
.definelabel KEYXY_X,                                 (1 << 0)
.definelabel KEYXY_Y,                                 (1 << 1)

; NDS memory and video layout
.definelabel BG_PALETTE,                              0x05000000
.definelabel VRAM_A,                                  0x06800000
.definelabel OAM,                                     0x07000000
.definelabel VramLcdcBytes,                           0x000a4000
.definelabel MM_PALRAM_SZ,                            0x00000800
.definelabel MM_OBJRAM_SZ,                            0x00000800
.definelabel WRAM_0KARM9_32KARM7,                     0x03
.definelabel VramcntLcdcEnableAbcd,                   0x80808080

; BIOS service and fixed boot entry points
.definelabel SwiCustomPost,                           0x001f0000
.definelabel SwiWaitByLoop,                           0x00030000
.definelabel SwiSoundBias,                            0x00080000
.definelabel SwiCpuFastSet,                           0x000c0000
.definelabel Bios7SignalBootFinish,                   0x0000119d
.definelabel Bios7PowerManagementWrite,               0x00002369
.definelabel Bios7FirmwareRead,                       0x00002437
.definelabel Bios7Lz77UncompVram,                     0x00002a2b
.definelabel Bios7CpuFastSetArm,                      0x000030e4
.definelabel Bios7SpiTransferFinish,                  0x000022c7
.definelabel Bios7FirmwareReadBegin,                  0x00002389
.definelabel Bios7SpiTransferBuffer,                  0x000033a5
.definelabel Bios9NintendoLogoAddress,                0xffff0020

; Fixed ARM7 BIOS RAM ABI; these are not component-owned objects.
; ARM7 BIOS 固定 RAM 接口；不是随组件移动的数据对象。
.definelabel Bios7IrqFlagsAddress,                    0x0380fff8
.definelabel Bios7IrqHandlerSlot,                     0x0380fffc
; Firmware wireless initializer stores its work pointer here, not IRQ flags.
; 固件无线初始化器在此保存工作区指针；不是 BIOS 中断标志。
.definelabel FirmwareWlWorkPointerSlot,               0x0380fff4

; ARM7 Wi-Fi: preserve the original WS1 register view; packet RAM is separate.
; ARM7 Wi-Fi：保留原 WS1 寄存器视图；片上收发 RAM 单独表示。
; Names/offsets checked against GBATEK DS Wi-Fi I/O Map and calico mwl/regs.h.
; 名称/偏移核对 GBATEK 与 calico；UNKNOWN/CONFIG 不暗示已确认详细功能。
; https://mgba-emu.github.io/gbatek/#dswifiiomap
; https://github.com/devkitPro/calico/blob/master/include/calico/dev/mwl/regs.h
.definelabel WifiIoWs1Base,                             0x04808000
.definelabel WifiRamBase,                               0x04804000
.definelabel REG_WIFI_MODE_RST,                         WifiIoWs1Base + 0x004
.definelabel REG_WIFI_MODE_WEP,                         WifiIoWs1Base + 0x006
.definelabel REG_WIFI_TXSTATCNT,                        WifiIoWs1Base + 0x008
.definelabel REG_WIFI_UNKNOWN_00A,                      WifiIoWs1Base + 0x00A
.definelabel REG_WIFI_IF,                               WifiIoWs1Base + 0x010
.definelabel REG_WIFI_IE,                               WifiIoWs1Base + 0x012
.definelabel REG_WIFI_AID_LOW,                          WifiIoWs1Base + 0x028
.definelabel REG_WIFI_AID_FULL,                         WifiIoWs1Base + 0x02A
.definelabel REG_WIFI_TX_RETRYLIMIT,                    WifiIoWs1Base + 0x02C
.definelabel REG_WIFI_RXCNT,                            WifiIoWs1Base + 0x030
.definelabel REG_WIFI_WEP_CNT,                          WifiIoWs1Base + 0x032
.definelabel REG_WIFI_POWER_US,                         WifiIoWs1Base + 0x036
.definelabel REG_WIFI_POWER_TX,                         WifiIoWs1Base + 0x038
.definelabel REG_WIFI_POWERSTATE,                       WifiIoWs1Base + 0x03C
.definelabel REG_WIFI_POWERFORCE,                       WifiIoWs1Base + 0x040
.definelabel REG_WIFI_RANDOM,                           WifiIoWs1Base + 0x044
.definelabel REG_WIFI_UNKNOWN_048,                      WifiIoWs1Base + 0x048
.definelabel REG_WIFI_RXBUF_BEGIN,                      WifiIoWs1Base + 0x050
.definelabel REG_WIFI_RXBUF_END,                        WifiIoWs1Base + 0x052
.definelabel REG_WIFI_RXBUF_WRCSR,                      WifiIoWs1Base + 0x054
.definelabel REG_WIFI_RXBUF_WR_ADDR,                    WifiIoWs1Base + 0x056
.definelabel REG_WIFI_RXBUF_RD_ADDR,                    WifiIoWs1Base + 0x058
.definelabel REG_WIFI_RXBUF_READCSR,                    WifiIoWs1Base + 0x05A
.definelabel REG_WIFI_RXBUF_GAP,                        WifiIoWs1Base + 0x062
.definelabel REG_WIFI_TXBUF_WR_ADDR,                    WifiIoWs1Base + 0x068
.definelabel REG_WIFI_TXBUF_BEACON,                     WifiIoWs1Base + 0x080
.definelabel REG_WIFI_TXBUF_TIM,                        WifiIoWs1Base + 0x084
.definelabel REG_WIFI_LISTENCOUNT,                      WifiIoWs1Base + 0x088
.definelabel REG_WIFI_BEACONINT,                        WifiIoWs1Base + 0x08C
.definelabel REG_WIFI_LISTENINT,                        WifiIoWs1Base + 0x08E
.definelabel REG_WIFI_TXBUF_REPLY1,                     WifiIoWs1Base + 0x094
.definelabel REG_WIFI_TXBUF_REPLY2,                     WifiIoWs1Base + 0x098
.definelabel REG_WIFI_TXBUF_LOC1,                       WifiIoWs1Base + 0x0A0
.definelabel REG_WIFI_TXBUF_LOC3,                       WifiIoWs1Base + 0x0A8
.definelabel REG_WIFI_TXREQ_RESET,                      WifiIoWs1Base + 0x0AC
.definelabel REG_WIFI_TXREQ_SET,                        WifiIoWs1Base + 0x0AE
.definelabel REG_WIFI_TXREQ_READ,                       WifiIoWs1Base + 0x0B0
.definelabel REG_WIFI_TXBUF_RESET,                      WifiIoWs1Base + 0x0B4
.definelabel REG_WIFI_TXBUSY,                           WifiIoWs1Base + 0x0B6
.definelabel REG_WIFI_TXSTAT,                           WifiIoWs1Base + 0x0B8
.definelabel REG_WIFI_PREAMBLE,                         WifiIoWs1Base + 0x0BC
.definelabel REG_WIFI_RXFILTER,                         WifiIoWs1Base + 0x0D0
.definelabel REG_WIFI_RXFILTER2,                        WifiIoWs1Base + 0x0E0
.definelabel REG_WIFI_US_COUNTCNT,                      WifiIoWs1Base + 0x0E8
.definelabel REG_WIFI_US_COMPARECNT,                    WifiIoWs1Base + 0x0EA
.definelabel REG_WIFI_US_COMPARE0,                      WifiIoWs1Base + 0x0F0
.definelabel REG_WIFI_US_COMPARE1,                      WifiIoWs1Base + 0x0F2
.definelabel REG_WIFI_US_COMPARE2,                      WifiIoWs1Base + 0x0F4
.definelabel REG_WIFI_US_COMPARE3,                      WifiIoWs1Base + 0x0F6
.definelabel REG_WIFI_US_COUNT0,                        WifiIoWs1Base + 0x0F8
.definelabel REG_WIFI_US_COUNT1,                        WifiIoWs1Base + 0x0FA
.definelabel REG_WIFI_US_COUNT2,                        WifiIoWs1Base + 0x0FC
.definelabel REG_WIFI_US_COUNT3,                        WifiIoWs1Base + 0x0FE
.definelabel REG_WIFI_CONTENTFREE,                      WifiIoWs1Base + 0x10C
.definelabel REG_WIFI_CMD_COUNT,                        WifiIoWs1Base + 0x118
.definelabel REG_WIFI_CONFIG_124,                       WifiIoWs1Base + 0x124
.definelabel REG_WIFI_CONFIG_128,                       WifiIoWs1Base + 0x128
.definelabel REG_WIFI_POST_BEACON,                      WifiIoWs1Base + 0x134
.definelabel REG_WIFI_CONFIG_140,                       WifiIoWs1Base + 0x140
.definelabel REG_WIFI_CONFIG_150,                       WifiIoWs1Base + 0x150
.definelabel REG_WIFI_BB_CNT,                           WifiIoWs1Base + 0x158
.definelabel REG_WIFI_BB_WRITE,                         WifiIoWs1Base + 0x15A
.definelabel REG_WIFI_BB_READ,                          WifiIoWs1Base + 0x15C
.definelabel REG_WIFI_BB_BUSY,                          WifiIoWs1Base + 0x15E
.definelabel REG_WIFI_BB_MODE,                          WifiIoWs1Base + 0x160
.definelabel REG_WIFI_BB_POWER,                         WifiIoWs1Base + 0x168
.definelabel REG_WIFI_RF_DATA2,                         WifiIoWs1Base + 0x17C
.definelabel REG_WIFI_RF_DATA1,                         WifiIoWs1Base + 0x17E
.definelabel REG_WIFI_RF_BUSY,                          WifiIoWs1Base + 0x180
.definelabel REG_WIFI_RF_CNT,                           WifiIoWs1Base + 0x184
.definelabel REG_WIFI_TX_HDR_CNT,                       WifiIoWs1Base + 0x194
.definelabel REG_WIFI_RF_PINS,                          WifiIoWs1Base + 0x19C
.definelabel REG_WIFI_RXSTAT_INC_IF,                    WifiIoWs1Base + 0x1A8
.definelabel REG_WIFI_RXSTAT_INC_IE,                    WifiIoWs1Base + 0x1AA
.definelabel REG_WIFI_RXSTAT_OVF_IF,                    WifiIoWs1Base + 0x1AC
.definelabel REG_WIFI_RXSTAT_OVF_IE,                    WifiIoWs1Base + 0x1AE
.definelabel REG_WIFI_RXSTAT,                           WifiIoWs1Base + 0x1B0
.definelabel REG_WIFI_TX_ERR_COUNT,                     WifiIoWs1Base + 0x1C0
.definelabel REG_WIFI_CMD_STAT,                         WifiIoWs1Base + 0x1D0
.definelabel REG_WIFI_TX_SEQNO,                         WifiIoWs1Base + 0x210
.definelabel REG_WIFI_RF_STATUS,                        WifiIoWs1Base + 0x214
.definelabel REG_WIFI_UNKNOWN_228,                      WifiIoWs1Base + 0x228
.definelabel REG_WIFI_UNKNOWN_244,                      WifiIoWs1Base + 0x244
.definelabel REG_WIFI_RXTX_ADDR,                        WifiIoWs1Base + 0x268
.definelabel REG_WIFI_UNKNOWN_290,                      WifiIoWs1Base + 0x290

; Standard firmware header layout shared by every reconstruction.  These
; offsets mirror dsfwtool's packed FW_HEADER structure; the remainder through
; +0x17F is its Wi-Fi configuration/reserved payload.
; 各重建版本共用的标准固件头布局。这些偏移对应 dsfwtool 的紧凑 FW_HEADER
; 结构；其后直到 +0x17F 为 Wi-Fi 配置/保留载荷。
.definelabel FirmwareHeaderDataBytes,                 0x000180
.definelabel FirmwareHeaderP3RomaddrOffset,           0x0000
.definelabel FirmwareHeaderP4RomaddrOffset,           0x0002
.definelabel FirmwareHeaderP3P4Crc16Offset,           0x0004
.definelabel FirmwareHeaderP1P2Crc16Offset,           0x0006
.definelabel FirmwareHeaderIdentifierOffset,          0x0008
.definelabel FirmwareHeaderP1RomaddrOffset,           0x000c
.definelabel HeaderPart1RamaddrOffset,                0x000e
.definelabel FirmwareHeaderP2RomaddrOffset,           0x0010
.definelabel HeaderPart2RamaddrOffset,                0x0012
.definelabel HeaderShiftAmountsOffset,                0x0014
.definelabel FirmwareHeaderP5RomaddrOffset,           0x0016
.definelabel FirmwareHeaderTimestampOffset,           0x0018
.definelabel FirmwareHeaderConsoleTypeOffset,         0x001d
.definelabel FirmwareHeaderUnused1Offset,             0x001e
.definelabel FirmwareHeaderUserSettingsOffset,        0x0020
.definelabel FirmwareHeaderUnknown1Offset,            0x0022
.definelabel FirmwareHeaderUnknown2Offset,            0x0024
.definelabel FirmwareHeaderP5Crc16Offset,             0x0026
.definelabel FirmwareHeaderUnused2Offset,             0x0028
.definelabel FirmwareHeaderWifiConfigCrc16Offset,     0x002a
.definelabel FirmwareHeaderWifiConfigLengthOffset,    0x002c
.definelabel FirmwareHeaderWifiConfigOffset,          0x002e
.definelabel FirmwarePart1RamaddrEncodingBase,        0x02800000
.definelabel FirmwarePart2RamaddrEncodingBase,        0x03810000
; P1/P2 RAM fields are measured down from their respective boot-memory bases.
; P1/P2 RAM 字段以各自启动内存基址为起点向下编码。
.expfunc FirmwarePart1RamaddrFromRam(address, shifts), (FirmwarePart1RamaddrEncodingBase - (address)) >> (2 + (((shifts) >> 3) & 7))
.expfunc FirmwarePart2RamaddrFromRam(address, shifts), (FirmwarePart2RamaddrEncodingBase - (address)) >> (2 + (((shifts) >> 9) & 7))

; Fixed retail boot-info view; field layout agrees with calico EnvFwBootInfo.
; 原固件的固定启动信息视图；字段布局核对 calico 的 EnvFwBootInfo。
; https://github.com/devkitPro/calico/blob/master/include/calico/nds/env.h
.definelabel FirmwareBootInfoAddress,                     0x027ffc00
.definelabel FirmwareBootParamAddress,                    0x027ffc40
.definelabel BootInfoCardChipIdNormalOffset,              0x00000000
.definelabel BootInfoCardChipIdSecureOffset,              0x00000004
.definelabel BootInfoCardHeaderCrc16Offset,               0x00000008
.definelabel BootInfoCardSecureCrc16Offset,               0x0000000a
.definelabel BootInfoCardHeaderBadOffset,                 0x0000000c
.definelabel BootInfoCardSecureInvalidOffset,             0x0000000e
.definelabel BootInfoBios7Crc16Offset,                    0x00000010
.definelabel BootInfoCardSecureDisableOffset,             0x00000012
.definelabel BootInfoHasSerialDebuggerOffset,             0x00000014
.definelabel BootInfoRtcBadOffset,                        0x00000016
.definelabel BootInfoRtcRandomOffset,                     0x00000017
.definelabel BootInfoGbaIdOffset,                         0x00000030
.definelabel BootInfoGbaIdExtOffset,                      0x00000032
.definelabel BootInfoGbaFlagsOffset,                      0x00000035
.definelabel BootInfoGbaMakerCodeOffset,                  0x00000036
.definelabel BootInfoGbaGameCodeOffset,                   0x00000038
.definelabel BootInfoVBlankCountOffset,                   0x0000003c
; Wi-Fi/scanline-adjusted 16-bit time; other paths can replace this value.
; 由 Wi-Fi 计数和扫描行校正的 16 位值；其他路径也可覆盖它。
.definelabel FirmwareWlAdjustedTimeSlot,             0x0380fff0

; Firmware user-settings storage and its retail RAM mirror
.definelabel FirmwareUserSettingsAddress256K,         0x0003fe00
.definelabel FirmwareUserSettingsAddress512K,         0x0007fe00
.definelabel FirmwareUserSettingsRamAddress,          0x023ffc80

; Fixed user-settings RAM view used by the firmware, not a component BSS.
; 固件使用的固定用户设置 RAM 视图；不是组件 BSS，不替换成其他镜像地址。
.definelabel FirmwareUserSettingsSharedAddress,       0x027ffc80
; PERSONAL_DATA layout: libnds system.h; offsets apply to the settings copy.
; 字段对应 libnds 的 PERSONAL_DATA；偏移作用于用户设置副本。
.definelabel UserSettingsThemeOffset,                 0x02
.definelabel UserSettingsBirthMonthOffset,            0x03
.definelabel UserSettingsBirthDayOffset,              0x04
.definelabel UserSettingsNameOffset,                  0x06
.definelabel UserSettingsNameLengthOffset,            0x1a
.definelabel UserSettingsMessageLengthOffset,         0x50
.definelabel UserSettingsAlarmHourOffset,             0x52
.definelabel UserSettingsTouchAdcX1Offset,             0x58
.definelabel UserSettingsTouchAdcY1Offset,             0x5a
.definelabel UserSettingsTouchPixelX1Offset,           0x5c
.definelabel UserSettingsTouchPixelY1Offset,           0x5d
.definelabel UserSettingsTouchAdcX2Offset,             0x5e
.definelabel UserSettingsTouchAdcY2Offset,             0x60
.definelabel UserSettingsTouchPixelX2Offset,           0x62
.definelabel UserSettingsTouchPixelY2Offset,           0x63
; Packed options include language, GBA screen, brightness and auto-boot.
; 选项位包含语言、GBA 屏幕、亮度和自动启动；这里保留完整字段含义。
.definelabel UserSettingsOptionsOffset,               0x64
.definelabel UserSettingsRtcOffset,                   0x68

; NDS card header copied to ARM9 RAM; 0x023Fxxxx is the retail 4 MiB mirror.
; GBATEK documents populated header fields through +0x16F.  The following
; address at +0x170 is documented as unused and zero-filled at cartridge boot;
; FlashMe uses that otherwise free location for its own return trampoline.
.definelabel NdsCartHeaderRamAddress,                 0x027ffe00
.definelabel NdsCartHeaderRetailMirrorAddress,        0x023ffe00
.definelabel NdsCartHeaderDocumentedBytes,            0x00000170
.definelabel NdsCartHeaderDocumentedEndAddress,       NdsCartHeaderRamAddress + NdsCartHeaderDocumentedBytes
.definelabel NdsCartHeaderArm9EntryAddress,           NdsCartHeaderRamAddress + 0x24
.definelabel NdsCartHeaderArm9RamAddress,             NdsCartHeaderRamAddress + 0x28
.definelabel NdsCartHeaderArm9SizeAddress,            NdsCartHeaderRamAddress + 0x2c
.definelabel NdsCartHeaderArm7EntryAddress,           NdsCartHeaderRamAddress + 0x34
.definelabel NdsCartHeaderArm7RamAddress,             NdsCartHeaderRamAddress + 0x38
.definelabel NdsCartHeaderArm7SizeAddress,            NdsCartHeaderRamAddress + 0x3c
.definelabel NdsCartHeaderRetailArm9EntryAddress,     NdsCartHeaderRetailMirrorAddress + 0x24
.definelabel NdsCartHeaderRetailArm9RamAddress,       NdsCartHeaderRetailMirrorAddress + 0x28

; Slot-2 header locations
.definelabel GbaRomTitleAddress,                      0x080000a0
.definelabel GbaArm7Entry,                            0x080000c0

; BIOS ARM9 debug-handler pointer; RAM below this slot is the BIOS debug stack.
; ARM9 BIOS 调试入口指针；此槽下方的 RAM 用作 BIOS 调试栈。
.definelabel Bios9DebugVectorAddress,                 0x027ffd9c

; Shared SDK system-work fields; retain the firmware's 0x027FFC00 view.
; SDK 双核共享系统区字段；保留原固件的 0x027FFC00 地址视图。
; https://github.com/pret/pokediamond/blob/master/include/nitro/OS_systemWork_shared.h
.definelabel FirmwareSystemWorkAddress,              FirmwareBootInfoAddress
.definelabel SystemWorkRtcOffset,                         0x1e8
.definelabel SystemWorkWirelessCallbackControlOffset,     0x396
.definelabel SystemWorkArm9ThreadInfoOffset,              0x3a0
.definelabel SystemWorkArm7ThreadInfoOffset,              0x3a4
.definelabel SystemWorkKeyXYStateOffset,                  0x3a8
.definelabel SystemWorkTouchPanelOffset,                  0x3aa
.definelabel SystemWorkArm9LockIdsOffset,                 0x3b0
.definelabel SystemWorkArm7LockIdsOffset,                 0x3b8
.definelabel SystemWorkInitLockOffset,                    0x3f0
.definelabel SystemWorkArm7MemorySizeCheckOffset,         0x3fa

; Firmware-private shared boot exchange, separate from the SDK system-work area.
; 固件私有的双核启动交换区，区别于 SDK 系统工作区。
.definelabel FirmwareBootSharedAddress,              0x027ff860
.definelabel BootSharedSettingsFlashOffset,               0x08
.definelabel BootSharedP4DestinationOffset,              0x0c
.definelabel BootSharedP4StagingOffset,                   0x10
.definelabel BootSharedP5Crc16Offset,                     0x14
.definelabel BootSharedP3P4Crc16Offset,                   0x16
; V4–V7 store the staging end; iQue/KOR store the aligned P4 span instead.
; V4–V7 存暂存末端地址；iQue/KOR 在同槽改存按 8 字节对齐的 P4 暂存长度。
.definelabel BootSharedStagingEndOffset,                  0x1c
.definelabel BootSharedP4StagedBytesOffset,               0x1c
.definelabel BootSharedEventSyncOffset,                   0x28
.definelabel BootSharedEventFlagsOffset,                  0x30

; ARM7 stages packed components here for ARM9; later boot phases may reuse RAM.
; ARM7 将压缩组件暂存于此供 ARM9 解压；该 RAM 可由后续启动阶段复用。
.definelabel FirmwareComponentStagingAddress,        0x022c0000
.definelabel FirmwareComponentStagingLimit,          0x02300000

; PXI FIFO: five tag bits; one shared callback-availability bitmap per CPU.
; PXI FIFO 使用五位通道号，每个 CPU 各有一个共享回调可用位图。
.definelabel PxiFifoChannelCount,                    32
.definelabel SystemWorkPxiArm9AvailableOffset,       0x388
.definelabel SystemWorkPxiArm7AvailableOffset,       0x38C

; Firmware thread context fields shared by both CPUs; ARM9 adds arithmetic context.
; 两个 CPU 共用的固件线程现场字段；ARM9 另附算术硬件现场。
.definelabel ThreadContextCpsrOffset,                         0x0
.definelabel ThreadContextR0Offset,                           0x4
.definelabel ThreadContextSpOffset,                           0x38
.definelabel ThreadContextLrOffset,                           0x3C
.definelabel ThreadContextPcPlus4Offset,                      0x40
.definelabel ThreadContextSvcSpOffset,                        0x44
.definelabel ThreadContextArithmeticOffset,                   0x48
.definelabel ThreadContextSvcStackBytes,                      0x40

; Keypad IRQ control / 按键 IRQ 控制（calico IO_KEYCNT = 0x132）。
.definelabel REG_KEYCNT,                              0x04000132

; Settings-load failure and the two boot-state words; state numbers remain unchanged.
; 用户设置读取失败标记与双核启动状态；保留各版本原有状态编号。
.definelabel BootSharedSettingsInvalidOffset,               0x4
.definelabel BootSharedArm9StateOffset,                     0x20
.definelabel BootSharedArm7StateOffset,                     0x24

; Fixed external Slot-2 bus window; offsets alone do not identify an accessory protocol.
; Slot-2 固定外部总线窗口；具体偏移不直接命名成未确认的附件协议。
.definelabel Slot2BusBaseAddress,                           0x8000000

; Private source of published boot info; +0x10 is overwritten during publication.
; 启动信息发布前的私有源区；发布时 +0x10 字段会被另一个来源覆盖。
.definelabel FirmwareBootInfoScratchAddress,                0x27FF800
.definelabel BootScratchRtcSourceOffset,                    0x18
.definelabel BootScratchBios7CrcSourceOffset,               0x50
.definelabel BootSharedConsoleTypeOffset,                   0x18

; 原 P345 解码器的目标末端上限；它不检查工作区重叠或损坏的压缩流。
; Original P345 destination-end limit; no workspace-overlap or corrupt-stream checks.
.definelabel P345DecodeOutputLimitAddress, 0x023FE000

; 私有启动交换字段：名称依实际读写关系，不推断未确认的 SDK/下载协议。
; Private boot exchange fields named by proven accesses, not an assumed SDK/download protocol.
.definelabel BootSharedPmicReg4Bit6Offset,                  0x19
.definelabel BootSharedRuntimePatchModeOffset,             0x1A
.definelabel BootSharedRuntimePatchFlagsOffset,            0x6C
.definelabel BootSharedRuntimePatchKeyOffset,              0x70

; Gericom 提供、Generic/RSDuck 转贴的 Lite 扩展寄存器名称（社区资料）。
; Lite extension register name from Gericom, reposted by Generic/RSDuck (community source).
; https://melonds.kuribo64.net/board/thread.php?pid=5772#5772
.definelabel REG_NITRO2_REGCNT,                         0x04001080

; ARM7 BIOS 卡带引导状态的固定接口；KOR 替代回调继续使用同一布局，并非固件 BSS。
; Fixed ARM7 BIOS card-boot interface; KOR replacement callbacks reuse it, not firmware BSS.
; https://github.com/PikalaxALT/ndsbios/blob/master/bios7.s (FUN_00001C0A / FUN_00001E74)
.definelabel Bios7CartTransferStateAddress,               0x0380FC00
.definelabel Bios7CartRomOffset,                         0x00
.definelabel Bios7CartDestinationOffset,                 0x04
.definelabel Bios7CartRemainingOffset,                   0x08
.definelabel Bios7CartBlockBytesOffset,                  0x0C
.definelabel Bios7CartCommandOffset,                     0x10
.definelabel Bios7CartReaderOffset,                      0x20
; 命令子结构相对于状态区 +0x10；两个命令字发送时先高字，再低字。
; Command substructure at state +0x10; serialize the high command word before the low word.
.definelabel Bios7CartCmdDmaChannelOffset,                0x00
.definelabel Bios7CartCmdControlOffset,                   0x04
.definelabel Bios7CartCmdLowWordOffset,                   0x08
.definelabel Bios7CartCmdHighWordOffset,                  0x0C
.definelabel Bios7CartControlOffset, Bios7CartCommandOffset + Bios7CartCmdControlOffset
