; official_v2_p1
; Readable armips reconstruction exported from Ghidra.
; Recognised code is assembly; data is retained only where Ghidra has no instruction.
.nds
.create "build/p1.bin", 0x02320000
.arm
; ARM9 入口：关中断、建立各模式栈并清零主 RAM。
; ARM9 entry: masks IRQs, sets mode stacks, then clears main RAM.
.func P1_Arm9ResetBootstrap
loc_02320000:
	mov r12,#0x4000000	; 02320000
	str r12,[r12,#0x208]	; 02320004 ; REG_IME = 0
	bl P1_Arm9ConfigureCp15	; 02320008
	mov r0,#0x13	; 0232000C
	msr cpsr_c,r0	; 02320010
	ldr r0,[pool_0232008C]	; 02320014
	add r0,r0,#0x3fc0	; 02320018
	mov sp,r0	; 0232001C
	mov r0,#0x12	; 02320020
	msr cpsr_c,r0	; 02320024
	ldr r0,[pool_0232008C]	; 02320028
	add r0,r0,#0x3fc0	; 0232002C
	sub r0,r0,#0x40	; 02320030
	mov sp,r0	; 02320034
	ldr r1,[pool_02320090]	; 02320038
	sub r1,r0,r1	; 0232003C
	mov r0,#0x1f	; 02320040
	msr cpsr_cxsf,r0	; 02320044
	sub sp,r1,#0x4	; 02320048
	bl P1_InitializeDataAndBss	; 0232004C
	mov r0,#0x0	; 02320050
	ldr r1,[pool_0232008C]	; 02320054
	mov r2,#0x4000	; 02320058
	bl P1_MemFill32	; 0232005C
	ldr r1,[pool_0232008C]	; 02320060
	add r1,r1,#0x3fc0	; 02320064
	add r1,r1,#0x3c	; 02320068
	ldr r0,[pool_02320094]	; 0232006C
	str r0,[r1,#0x0]	; 02320070
	bl loc_0232CD4C	; 02320074
	bl loc_0232C578	; 02320078
	blx loc_0232CE0C	; 0232007C
	ldr r1,[pool_02320098]	; 02320080
	ldr lr,[pool_0232009C]	; 02320084
	bx r1	; 02320088
.endfunc
pool_0232008C:
loc_0232008C:
	.word P1_DtcmRuntimeStart	; 0232008C
pool_02320090:
loc_02320090:
	.word 0x00001000	; 02320090
pool_02320094:
loc_02320094:
	.word P1_DispatchIrq	; 02320094
pool_02320098:
loc_02320098:
	.word P1_FirmwareMainLoop+1	; 02320098 ; Thumb entry
pool_0232009C:
loc_0232009C:
	.word 0x023FEE00	; 0232009C
.thumb
; 固件主循环：初始化运行时服务并调度启动状态。
; Firmware main loop: initializes runtime services and dispatches boot states.
P1_FirmwareMainLoop:
loc_023200A0:
	push {r4,r5,lr}	; 023200A0
	sub sp,#0xc	; 023200A2
	mov r5,#0x0	; 023200A4
	add r4,r5,#0x0	; 023200A6
	ldr r0,[pool_02320210]	; 023200A8
	bl loc_023276C8	; 023200AA
	bl loc_0232B830	; 023200AE
	bl loc_0232BD00	; 023200B2
	bl loc_0232D138	; 023200B6
	bl loc_0232F3B4	; 023200BA
	ldr r1,[pool_02320214]	; 023200BE
	ldrh r2,[r1,#0x0]	; 023200C0
	ldr r0,[pool_02320218]	; 023200C2
	and r2,r0	; 023200C4
	ldr r0,[pool_0232021C]	; 023200C6
	orr r2,r0	; 023200C8
	strh r2,[r1,#0x0]	; 023200CA
	ldr r0,[pool_02320220]	; 023200CC
	bl loc_0232D448	; 023200CE
	lsl r0,r5,#0	; 023200D2
	str r0,[sp,#0x4]	; 023200D4
	ldr r0,[sp,#0x4]	; 023200D6
	ldr r1,[pool_02320224]	; 023200D8
	ldr r2,[pool_02320228]	; 023200DA
	blx loc_0232E34C	; 023200DC
	bl loc_0232D28C	; 023200E0
	mov r0,#0xc0	; 023200E4
	str r0,[sp,#0x0]	; 023200E6
	ldr r0,[sp,#0x0]	; 023200E8
	ldr r1,[pool_0232022C]	; 023200EA
	ldr r2,[pool_02320230]	; 023200EC
	blx loc_0232E34C	; 023200EE
	lsl r0,r5,#0	; 023200F2
	str r0,[sp,#0x8]	; 023200F4
	ldr r0,[sp,#0x8]	; 023200F6
	ldr r1,[pool_02320234]	; 023200F8
	ldr r2,[pool_02320230]	; 023200FA
	blx loc_0232E34C	; 023200FC
	mov r0,#0x1	; 02320100
	ldr r1,[pool_02320238]	; 02320102
	bl loc_0232ADD0	; 02320104
	mov r0,#0x1	; 02320108
	bl loc_0232AD4C	; 0232010A
	ldr r1,[pool_0232023C]	; 0232010E
	ldrh r0,[r1,#0x0]	; 02320110
	mov r0,#0x1	; 02320112
	strh r0,[r1,#0x0]	; 02320114
	blx P1_Arm9EnableIrqReturnPriorMask	; 02320116
	mov r0,#0x1	; 0232011A
	bl loc_0232D114	; 0232011C
	bl loc_0233043C	; 02320120
	bl loc_02327594	; 02320124
	cmp r0,#0x0	; 02320128
	bne loc_02320206	; 0232012A
	bl loc_02327340	; 0232012C
	bl loc_02326830	; 02320130
	bl loc_0232698C	; 02320134
	bl loc_02324BF0	; 02320138
	bl loc_02324D38	; 0232013C
	bl loc_02323678	; 02320140
	bl loc_0232569C	; 02320144
	bl loc_023257A0	; 02320148
	bl loc_023256C0	; 0232014C
	bl loc_02325694	; 02320150
	ldr r0,[r0,#0x0]	; 02320154
	lsl r0,r0,#0x1b	; 02320156
	lsr r0,r0,#0x1f	; 02320158
	cmp r0,#0x0	; 0232015A
	beq loc_02320162	; 0232015C
	mov r4,#0x5	; 0232015E
	b loc_02320168	; 02320160
loc_02320162:
	bl loc_02320DE8	; 02320162
	mov r5,#0x1	; 02320166
loc_02320168:
	bl P1_RefreshFirmwareUiRenderBuffers	; 02320168
	bl loc_02324BC4	; 0232016C
	bl loc_023249BC	; 02320170
	bl loc_02324BA8	; 02320174
	bl loc_023249BC	; 02320178
	bl loc_02326868	; 0232017C
	bl loc_02327340	; 02320180
	cmp r0,#0x0	; 02320184
	bne loc_02320206	; 02320186
	cmp r5,#0x0	; 02320188
	beq loc_023201B6	; 0232018A
	bl loc_02320260	; 0232018C
	add r4,r0,#0x0	; 02320190
	cmp r4,#0x0	; 02320192
	beq loc_023201B6	; 02320194
	cmp r4,#0x1	; 02320196
	beq loc_023201A4	; 02320198
	cmp r4,#0x2	; 0232019A
	beq loc_023201AA	; 0232019C
	cmp r4,#0x3	; 0232019E
	beq loc_023201B0	; 023201A0
	b loc_023201B4	; 023201A2
loc_023201A4:
	bl loc_0232728C	; 023201A4
	b loc_023201B4	; 023201A8
loc_023201AA:
	bl loc_023272AC	; 023201AA
	b loc_023201B4	; 023201AE
loc_023201B0:
	bl loc_0232729C	; 023201B0
loc_023201B4:
	mov r5,#0x0	; 023201B4
loc_023201B6:
	cmp r4,#0x5	; 023201B6
	bhi loc_02320200	; 023201B8
	add r0,r4,r4	; 023201BA
P1_SwitchIndexPC_023201BA:
	add r0,pc	; 023201BC
	ldrh r0,[r0,#(P1_SwitchTable_023201BA - (P1_SwitchIndexPC_023201BA + 4))]	; 023201BE
	lsl r0,r0,#0x10	; 023201C0
	asr r0,r0,#0x10	; 023201C2
P1_SwitchTargetPC_023201BA:
	add r0,pc	; 023201C4
	bx r0	; 023201C6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023201BA:
	.halfword (loc_02320200 + 1) - (P1_SwitchTargetPC_023201BA + 4)
	.halfword (loc_023201D4 + 1) - (P1_SwitchTargetPC_023201BA + 4)
	.halfword (loc_023201D4 + 1) - (P1_SwitchTargetPC_023201BA + 4)
	.halfword (loc_023201D4 + 1) - (P1_SwitchTargetPC_023201BA + 4)
	.halfword (loc_023201DA + 1) - (P1_SwitchTargetPC_023201BA + 4)
	.halfword (loc_023201EE + 1) - (P1_SwitchTargetPC_023201BA + 4)
P1_SwitchTable_023201BAEnd:
loc_023201D4:
	bl loc_0232730C	; 023201D4
	b loc_02320200	; 023201D8
loc_023201DA:
	bl loc_0232D0E0	; 023201DA
	ldr r2,[pool_02320240]	; 023201DE
	ldr r1,[r2,#0x0]	; 023201E0
	ldr r0,[pool_02320244]	; 023201E2
	and r1,r0	; 023201E4
	str r1,[r2,#0x0]	; 023201E6
	bl loc_023272CC	; 023201E8
	b loc_02320200	; 023201EC
loc_023201EE:
	bl loc_0232D0E0	; 023201EE
	ldr r2,[pool_02320240]	; 023201F2
	ldr r1,[r2,#0x0]	; 023201F4
	ldr r0,[pool_02320244]	; 023201F6
	and r1,r0	; 023201F8
	str r1,[r2,#0x0]	; 023201FA
	bl loc_023272BC	; 023201FC
loc_02320200:
	bl loc_02323670	; 02320200
	b loc_02320168	; 02320204
loc_02320206:
	add sp,#0xc	; 02320206
	pop {r4,r5}	; 02320208
	pop {r3}	; 0232020A
	bx r3	; 0232020C
	.byte 0xC0, 0x46	; 02320210
pool_02320210:
loc_02320210:
	.word 0x02330518	; 02320210
pool_02320214:
loc_02320214:
	.word REG_POWERCNT	; 02320214
pool_02320218:
loc_02320218:
	.word 0xFFFFFDF1	; 02320218
pool_0232021C:
loc_0232021C:
	.word 0x0000020E	; 0232021C
pool_02320220:
loc_02320220:
	.word 0x000001FF	; 02320220
pool_02320224:
loc_02320224:
	.word 0x06800000	; 02320224
pool_02320228:
loc_02320228:
	.word 0x000A4000	; 02320228
pool_0232022C:
loc_0232022C:
	.word 0x07000000	; 0232022C
pool_02320230:
loc_02320230:
	.word 0x00000400	; 02320230
pool_02320234:
loc_02320234:
	.word 0x05000000	; 02320234
pool_02320238:
loc_02320238:
	.word P1_IrqHandler_02320248 + 1	; 02320238
pool_0232023C:
loc_0232023C:
	.word REG_IME	; 0232023C
pool_02320240:
loc_02320240:
	.word REG_DISPCNT_B	; 02320240
pool_02320244:
loc_02320244:
	.word 0xFFFEFFFF	; 02320244
P1_IrqHandler_02320248:
	ldr r1,[pool_02320258]	; 02320248
	ldr r0,[pool_0232025C]	; 0232024A
	add r2,r1,r0	; 0232024C
	ldr r1,[r2,#0x0]	; 0232024E
	mov r0,#0x1	; 02320250
	orr r1,r0	; 02320252
	str r1,[r2,#0x0]	; 02320254
	bx lr	; 02320256
pool_02320258:
loc_02320258:
	.word 0x03000000	; 02320258
pool_0232025C:
loc_0232025C:
	.word 0x00003FF8	; 0232025C

; ===== function loc_02320260 =====
loc_02320260:
	push {r4,r5,r6,lr}	; 02320260
	mov r4,#0x0	; 02320262
	ldr r5,[pool_023203D0]	; 02320264
	ldr r6,[pool_023203D4]	; 02320266
	bl loc_02324098	; 02320268
	bl loc_02323EE0	; 0232026C
	ldr r0,[pool_023203D8]	; 02320270
	ldr r0,[r0,#0x68]	; 02320272
	lsl r1,r0,#0x1d	; 02320274
	lsr r1,r1,#0x1f	; 02320276
	cmp r1,#0x0	; 02320278
	beq loc_02320288	; 0232027A
	lsl r0,r0,#0x14	; 0232027C
	lsr r0,r0,#0x1f	; 0232027E
	cmp r0,#0x0	; 02320280
	bne loc_02320288	; 02320282
	bl loc_0232297C	; 02320284
loc_02320288:
	bl loc_0232539C	; 02320288
	bl loc_02324EAC	; 0232028C
	add r0,r5,#0x0	; 02320290
	bl loc_02321D10	; 02320292
	ldr r0,[pool_023203DC]	; 02320296
	bl loc_023269C4	; 02320298
	ldr r0,[pool_023203E0]	; 0232029C
	ldr r0,[r0,#0x4c]	; 0232029E
	cmp r0,#0x9	; 023202A0
	bhi loc_02320388	; 023202A2
	add r0,r0,r0	; 023202A4
P1_SwitchIndexPC_023202A4:
	add r0,pc	; 023202A6
	ldrh r0,[r0,#(P1_SwitchTable_023202A4 - (P1_SwitchIndexPC_023202A4 + 4))]	; 023202A8
	lsl r0,r0,#0x10	; 023202AA
	asr r0,r0,#0x10	; 023202AC
P1_SwitchTargetPC_023202A4:
	add r0,pc	; 023202AE
	bx r0	; 023202B0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023202A4:
	.halfword (loc_023202C6 + 1) - (P1_SwitchTargetPC_023202A4 + 4)
	.halfword (loc_0232033C + 1) - (P1_SwitchTargetPC_023202A4 + 4)
	.halfword (loc_02320346 + 1) - (P1_SwitchTargetPC_023202A4 + 4)
	.halfword (loc_02320350 + 1) - (P1_SwitchTargetPC_023202A4 + 4)
	.halfword (loc_02320358 + 1) - (P1_SwitchTargetPC_023202A4 + 4)
	.halfword (loc_02320360 + 1) - (P1_SwitchTargetPC_023202A4 + 4)
	.halfword (loc_02320368 + 1) - (P1_SwitchTargetPC_023202A4 + 4)
	.halfword (loc_02320370 + 1) - (P1_SwitchTargetPC_023202A4 + 4)
	.halfword (loc_02320380 + 1) - (P1_SwitchTargetPC_023202A4 + 4)
	.halfword (loc_02320378 + 1) - (P1_SwitchTargetPC_023202A4 + 4)
P1_SwitchTable_023202A4End:
loc_023202C6:
	ldr r0,[pool_023203E4]	; 023202C6
	ldr r0,[r0,#0x2c]	; 023202C8
	cmp r0,#0xa	; 023202CA
	bhi loc_02320388	; 023202CC
	add r0,r0,r0	; 023202CE
P1_SwitchIndexPC_023202CE:
	add r0,pc	; 023202D0
	ldrh r0,[r0,#(P1_SwitchTable_023202CE - (P1_SwitchIndexPC_023202CE + 4))]	; 023202D2
	lsl r0,r0,#0x10	; 023202D4
	asr r0,r0,#0x10	; 023202D6
P1_SwitchTargetPC_023202CE:
	add r0,pc	; 023202D8
	bx r0	; 023202DA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023202CE:
	.halfword (loc_023202F2 + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_023202F8 + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_023202FE + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_02320306 + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_0232030C + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_02320312 + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_0232031A + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_02320322 + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_0232032A + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_02320330 + 1) - (P1_SwitchTargetPC_023202CE + 4)
	.halfword (loc_02320336 + 1) - (P1_SwitchTargetPC_023202CE + 4)
P1_SwitchTable_023202CEEnd:
loc_023202F2:
	bl loc_02320AA4	; 023202F2
	b loc_02320388	; 023202F6
loc_023202F8:
	bl loc_02320968	; 023202F8
	b loc_02320388	; 023202FC
loc_023202FE:
	bl loc_02320888	; 023202FE
	add r4,r0,#0x0	; 02320302
	b loc_02320388	; 02320304
loc_02320306:
	bl loc_02320820	; 02320306
	b loc_02320388	; 0232030A
loc_0232030C:
	bl loc_023207D4	; 0232030C
	b loc_02320388	; 02320310
loc_02320312:
	add r0,r5,#0x0	; 02320312
	bl loc_023205FC	; 02320314
	b loc_02320388	; 02320318
loc_0232031A:
	bl loc_0232055C	; 0232031A
	add r4,r0,#0x0	; 0232031E
	b loc_02320388	; 02320320
loc_02320322:
	bl loc_02320508	; 02320322
	add r4,r0,#0x0	; 02320326
	b loc_02320388	; 02320328
loc_0232032A:
	bl loc_023204C4	; 0232032A
	b loc_02320388	; 0232032E
loc_02320330:
	bl loc_02320420	; 02320330
	b loc_02320388	; 02320334
loc_02320336:
	bl loc_023203F4	; 02320336
	b loc_02320388	; 0232033A
loc_0232033C:
	add r0,r5,#0x0	; 0232033C
	add r1,r6,#0x0	; 0232033E
	bl loc_02325F54	; 02320340
	b loc_02320388	; 02320344
loc_02320346:
	add r0,r5,#0x0	; 02320346
	add r1,r6,#0x0	; 02320348
	bl loc_02325EE8	; 0232034A
	b loc_02320388	; 0232034E
loc_02320350:
	add r0,r6,#0x0	; 02320350
	bl loc_02325E70	; 02320352
	b loc_02320388	; 02320356
loc_02320358:
	add r0,r6,#0x0	; 02320358
	bl loc_02325DE0	; 0232035A
	b loc_02320388	; 0232035E
loc_02320360:
	add r0,r6,#0x0	; 02320360
	bl loc_02325D30	; 02320362
	b loc_02320388	; 02320366
loc_02320368:
	add r0,r6,#0x0	; 02320368
	bl loc_02325BF8	; 0232036A
	b loc_02320388	; 0232036E
loc_02320370:
	add r0,r6,#0x0	; 02320370
	bl loc_02325B84	; 02320372
	b loc_02320388	; 02320376
loc_02320378:
	add r0,r6,#0x0	; 02320378
	bl loc_02325A38	; 0232037A
	b loc_02320388	; 0232037E
loc_02320380:
	add r0,r5,#0x0	; 02320380
	add r1,r6,#0x0	; 02320382
	bl loc_02325AC8	; 02320384
loc_02320388:
	bl loc_0232C2FC	; 02320388
	cmp r0,#0x0	; 0232038C
	beq loc_023203B0	; 0232038E
	ldr r0,[pool_023203E8]	; 02320390
	ldr r1,[pool_023203EC]	; 02320392
	mov r2,#0x30	; 02320394
	bl loc_02324ADC	; 02320396
	mov r1,#0x4	; 0232039A
	ldr r0,[pool_023203F0]	; 0232039C
	strh r1,[r0,#0x22]	; 0232039E
	ldr r1,[pool_023203D8]	; 023203A0
	ldr r2,[r1,#0x68]	; 023203A2
	mov r0,#0x20	; 023203A4
	bic r2,r0	; 023203A6
	str r2,[r1,#0x68]	; 023203A8
	mov r0,#0x40	; 023203AA
	bic r2,r0	; 023203AC
	str r2,[r1,#0x68]	; 023203AE
loc_023203B0:
	ldr r0,[pool_023203D4]	; 023203B0
	bl loc_02326004	; 023203B2
	cmp r4,#0x0	; 023203B6
	beq loc_023203C4	; 023203B8
	ldr r1,[pool_023203D8]	; 023203BA
	ldr r2,[r1,#0x68]	; 023203BC
	mov r0,#0x2	; 023203BE
	bic r2,r0	; 023203C0
	str r2,[r1,#0x68]	; 023203C2
loc_023203C4:
	bl loc_02320AF4	; 023203C4
	add r0,r4,#0x0	; 023203C8
	pop {r4,r5,r6}	; 023203CA
	pop {r3}	; 023203CC
	bx r3	; 023203CE
pool_023203D0:
loc_023203D0:
	.word 0x02330FB4	; 023203D0
pool_023203D4:
loc_023203D4:
	.word 0x0233191C	; 023203D4
pool_023203D8:
loc_023203D8:
	.word P1_BssStart + 0x1300	; 023203D8
pool_023203DC:
loc_023203DC:
	.word 0x02331930	; 023203DC
pool_023203E0:
loc_023203E0:
	.word P1_BssStart + 0xA80	; 023203E0
pool_023203E4:
loc_023203E4:
	.word P1_BssStart + 0x100	; 023203E4
pool_023203E8:
loc_023203E8:
	.word 0x02330ECC	; 023203E8
pool_023203EC:
loc_023203EC:
	.word 0x023A020C	; 023203EC
pool_023203F0:
loc_023203F0:
	.word P1_BssStart + 0x40	; 023203F0

; ===== function loc_023203F4 =====
loc_023203F4:
	ldr r0,[pool_02320414]	; 023203F4
	ldr r1,[r0,#0x10]	; 023203F6
	cmp r1,#0x0	; 023203F8
	beq loc_02320402	; 023203FA
	sub r1,#0x8	; 023203FC
	str r1,[r0,#0x10]	; 023203FE
	bx lr	; 02320400
loc_02320402:
	ldr r1,[pool_02320418]	; 02320402
	ldr r2,[r1,#0x68]	; 02320404
	mov r0,#0x80	; 02320406
	bic r2,r0	; 02320408
	str r2,[r1,#0x68]	; 0232040A
	mov r1,#0x5	; 0232040C
	ldr r0,[pool_0232041C]	; 0232040E
	str r1,[r0,#0x2c]	; 02320410
	bx lr	; 02320412
pool_02320414:
loc_02320414:
	.word P1_BssStart + 0xB00	; 02320414
pool_02320418:
loc_02320418:
	.word P1_BssStart + 0x1300	; 02320418
pool_0232041C:
loc_0232041C:
	.word P1_BssStart + 0x100	; 0232041C

; ===== function loc_02320420 =====
loc_02320420:
	push {lr}	; 02320420
	sub sp,#0x4	; 02320422
	ldr r0,[pool_023204BC]	; 02320424
	ldr r0,[r0,#0x30]	; 02320426
	cmp r0,#0xa	; 02320428
	bne loc_0232043C	; 0232042A
	bl loc_023252E8	; 0232042C
	mov r1,#0xa	; 02320430
	ldr r0,[pool_023204BC]	; 02320432
	str r1,[r0,#0x2c]	; 02320434
	mov r1,#0x5	; 02320436
	str r1,[r0,#0x30]	; 02320438
	b loc_023204B4	; 0232043A
loc_0232043C:
	ldr r0,[pool_023204C0]	; 0232043C
	ldr r1,[r0,#0x50]	; 0232043E
	cmp r1,#0x2	; 02320440
	bne loc_02320456	; 02320442
	mov r1,#0x0	; 02320444
	str r1,[r0,#0x50]	; 02320446
	mov r1,#0x2	; 02320448
	str r1,[r0,#0x4c]	; 0232044A
	mov r0,#0x3a	; 0232044C
	mov r1,#0x1	; 0232044E
	bl loc_02324FD8	; 02320450
	b loc_023204B4	; 02320454
loc_02320456:
	cmp r1,#0x3	; 02320456
	bne loc_02320470	; 02320458
	bl loc_023252E8	; 0232045A
	mov r0,#0x1	; 0232045E
	bl loc_02322A08	; 02320460
	mov r1,#0x0	; 02320464
	ldr r0,[pool_023204C0]	; 02320466
	str r1,[r0,#0x50]	; 02320468
	mov r1,#0x3	; 0232046A
	str r1,[r0,#0x4c]	; 0232046C
	b loc_023204B4	; 0232046E
loc_02320470:
	cmp r1,#0x4	; 02320470
	bne loc_02320484	; 02320472
	bl loc_023252E8	; 02320474
	mov r1,#0x0	; 02320478
	ldr r0,[pool_023204C0]	; 0232047A
	str r1,[r0,#0x50]	; 0232047C
	mov r1,#0x4	; 0232047E
	str r1,[r0,#0x4c]	; 02320480
	b loc_023204B4	; 02320482
loc_02320484:
	cmp r1,#0x9	; 02320484
	bne loc_02320492	; 02320486
	mov r1,#0x0	; 02320488
	str r1,[r0,#0x50]	; 0232048A
	mov r1,#0x9	; 0232048C
	str r1,[r0,#0x4c]	; 0232048E
	b loc_023204B4	; 02320490
loc_02320492:
	cmp r1,#0x6	; 02320492
	bne loc_023204A6	; 02320494
	bl loc_023252E8	; 02320496
	mov r1,#0x0	; 0232049A
	ldr r0,[pool_023204C0]	; 0232049C
	str r1,[r0,#0x50]	; 0232049E
	mov r1,#0x6	; 023204A0
	str r1,[r0,#0x4c]	; 023204A2
	b loc_023204B4	; 023204A4
loc_023204A6:
	cmp r1,#0x0	; 023204A6
	bne loc_023204B4	; 023204A8
	bl loc_023252E8	; 023204AA
	mov r1,#0xa	; 023204AE
	ldr r0,[pool_023204BC]	; 023204B0
	str r1,[r0,#0x2c]	; 023204B2
loc_023204B4:
	add sp,#0x4	; 023204B4
	pop {r3}	; 023204B6
	bx r3	; 023204B8
	.byte 0xC0, 0x46	; 023204BC
pool_023204BC:
loc_023204BC:
	.word P1_BssStart + 0x100	; 023204BC
pool_023204C0:
loc_023204C0:
	.word P1_BssStart + 0xA80	; 023204C0

; ===== function loc_023204C4 =====
loc_023204C4:
	push {lr}	; 023204C4
	sub sp,#0x4	; 023204C6
	ldr r0,[pool_023204F8]	; 023204C8
	ldr r1,[r0,#0x10]	; 023204CA
	cmp r1,#0xb0	; 023204CC
	beq loc_023204D6	; 023204CE
	add r1,#0x8	; 023204D0
	str r1,[r0,#0x10]	; 023204D2
	b loc_023204F0	; 023204D4
loc_023204D6:
	ldr r0,[pool_023204FC]	; 023204D6
	bl loc_023259C0	; 023204D8
	mov r1,#0x9	; 023204DC
	ldr r0,[pool_02320500]	; 023204DE
	str r1,[r0,#0x2c]	; 023204E0
	ldr r1,[pool_02320504]	; 023204E2
	ldr r2,[r1,#0x54]	; 023204E4
	mov r0,#0x20	; 023204E6
	bic r2,r0	; 023204E8
	str r2,[r1,#0x54]	; 023204EA
	mov r0,#0x1	; 023204EC
	str r0,[r1,#0x4c]	; 023204EE
loc_023204F0:
	add sp,#0x4	; 023204F0
	pop {r3}	; 023204F2
	bx r3	; 023204F4
	.byte 0xC0, 0x46	; 023204F8
pool_023204F8:
loc_023204F8:
	.word P1_BssStart + 0xB00	; 023204F8
pool_023204FC:
loc_023204FC:
	.word 0x0233191C	; 023204FC
pool_02320500:
loc_02320500:
	.word P1_BssStart + 0x100	; 02320500
pool_02320504:
loc_02320504:
	.word P1_BssStart + 0xA80	; 02320504

; ===== function loc_02320508 =====
loc_02320508:
	push {r4,r5,lr}	; 02320508
	sub sp,#0x4	; 0232050A
	mov r4,#0x0	; 0232050C
	ldr r0,[pool_02320550]	; 0232050E
	ldr r1,[r0,#0x8]	; 02320510
	add r1,r1,#0x1	; 02320512
	str r1,[r0,#0x8]	; 02320514
	cmp r1,#0x1e	; 02320516
	bgt loc_02320536	; 02320518
	lsl r0,r1,#0x4	; 0232051A
	mov r1,#0x1e	; 0232051C
	blx P1_SignedDivMod	; 0232051E
	add r5,r0,#0x0	; 02320522
	ldr r0,[pool_02320554]	; 02320524
	add r1,r5,#0x0	; 02320526
	bl loc_0232D018	; 02320528
	ldr r0,[pool_02320558]	; 0232052C
	add r1,r5,#0x0	; 0232052E
	bl loc_0232D018	; 02320530
	b loc_02320546	; 02320534
loc_02320536:
	ldr r0,[r0,#0x4]	; 02320536
	cmp r0,#0x1	; 02320538
	beq loc_02320544	; 0232053A
	cmp r0,#0x4	; 0232053C
	bne loc_02320546	; 0232053E
	mov r4,#0x4	; 02320540
	b loc_02320546	; 02320542
loc_02320544:
	mov r4,#0x5	; 02320544
loc_02320546:
	add r0,r4,#0x0	; 02320546
	add sp,#0x4	; 02320548
	pop {r4,r5}	; 0232054A
	pop {r3}	; 0232054C
	bx r3	; 0232054E
pool_02320550:
loc_02320550:
	.word P1_BssStart + 0xB00	; 02320550
pool_02320554:
loc_02320554:
	.word REG_MASTER_BRIGHT	; 02320554
pool_02320558:
loc_02320558:
	.word REG_MASTER_BRIGHT_SUB	; 02320558

; ===== function loc_0232055C =====
loc_0232055C:
	push {r4,r5,lr}	; 0232055C
	sub sp,#0x4	; 0232055E
	mov r4,#0x0	; 02320560
	ldr r2,[pool_023205EC]	; 02320562
	ldr r0,[pool_023205F0]	; 02320564
	ldr r1,[r0,#0x4]	; 02320566
	mov r0,#0x3c	; 02320568
	mul r1,r0	; 0232056A
	add r2,r2,r1	; 0232056C
	mov r0,#0x2	; 0232056E
	ldrsh r1,[r2,r0]	; 02320570
	mov r0,#0x77	; 02320572
	mvn r0,r0	; 02320574
	cmp r1,r0	; 02320576
	ble loc_02320582	; 02320578
	add r1,r2,#0x2	; 0232057A
	ldrsh r0,[r1,r4]	; 0232057C
	sub r0,r0,#0x6	; 0232057E
	strh r0,[r1,#0x0]	; 02320580
loc_02320582:
	ldr r1,[pool_023205F0]	; 02320582
	ldr r0,[r1,#0x8]	; 02320584
	add r0,r0,#0x1	; 02320586
	str r0,[r1,#0x8]	; 02320588
	cmp r0,#0x1e	; 0232058A
	bgt loc_023205AA	; 0232058C
	lsl r0,r0,#0x4	; 0232058E
	mov r1,#0x1e	; 02320590
	blx P1_SignedDivMod	; 02320592
	add r5,r0,#0x0	; 02320596
	str r5,[sp,#0x0]	; 02320598
	ldr r0,[pool_023205F4]	; 0232059A
	mov r1,#0x0	; 0232059C
	mov r2,#0x2	; 0232059E
	mov r3,#0x10	; 023205A0
	sub r3,r3,r5	; 023205A2
	bl loc_0232DBC0	; 023205A4
	b loc_023205DE	; 023205A8
loc_023205AA:
	ldr r0,[r1,#0x4]	; 023205AA
	cmp r0,#0x4	; 023205AC
	bhi loc_023205DE	; 023205AE
	add r0,r0,r0	; 023205B0
P1_SwitchIndexPC_023205B0:
	add r0,pc	; 023205B2
	ldrh r0,[r0,#(P1_SwitchTable_023205B0 - (P1_SwitchIndexPC_023205B0 + 4))]	; 023205B4
	lsl r0,r0,#0x10	; 023205B6
	asr r0,r0,#0x10	; 023205B8
P1_SwitchTargetPC_023205B0:
	add r0,pc	; 023205BA
	bx r0	; 023205BC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023205B0:
	.halfword (loc_023205C8 + 1) - (P1_SwitchTargetPC_023205B0 + 4)
	.halfword (loc_023205D4 + 1) - (P1_SwitchTargetPC_023205B0 + 4)
	.halfword (loc_023205D0 + 1) - (P1_SwitchTargetPC_023205B0 + 4)
	.halfword (loc_023205CC + 1) - (P1_SwitchTargetPC_023205B0 + 4)
	.halfword (loc_023205D4 + 1) - (P1_SwitchTargetPC_023205B0 + 4)
P1_SwitchTable_023205B0End:
loc_023205C8:
	mov r4,#0x1	; 023205C8
	b loc_023205DE	; 023205CA
loc_023205CC:
	mov r4,#0x2	; 023205CC
	b loc_023205DE	; 023205CE
loc_023205D0:
	mov r4,#0x3	; 023205D0
	b loc_023205DE	; 023205D2
loc_023205D4:
	mov r0,#0x0	; 023205D4
	str r0,[r1,#0x8]	; 023205D6
	mov r1,#0x7	; 023205D8
	ldr r0,[pool_023205F8]	; 023205DA
	str r1,[r0,#0x2c]	; 023205DC
loc_023205DE:
	bl loc_02321D60	; 023205DE
	add r0,r4,#0x0	; 023205E2
	add sp,#0x4	; 023205E4
	pop {r4,r5}	; 023205E6
	pop {r3}	; 023205E8
	bx r3	; 023205EA
pool_023205EC:
loc_023205EC:
	.word 0x02330E80	; 023205EC
pool_023205F0:
loc_023205F0:
	.word P1_BssStart + 0xB00	; 023205F0
pool_023205F4:
loc_023205F4:
	.word REG_BLDCNT_SUB	; 023205F4
pool_023205F8:
loc_023205F8:
	.word P1_BssStart + 0x100	; 023205F8

; ===== function loc_023205FC =====
loc_023205FC:
	push {r4,r5,lr}	; 023205FC
	sub sp,#0x4	; 023205FE
	add r5,r0,#0x0	; 02320600
	ldr r0,[pool_023207A0]	; 02320602
	bl loc_023216A4	; 02320604
	ldr r0,[pool_023207A4]	; 02320608
	ldr r4,[r0,#0x74]	; 0232060A
	add r0,r5,#0x0	; 0232060C
	mov r1,#0x5	; 0232060E
	bl loc_02321D08	; 02320610
	cmp r0,#0x0	; 02320614
	bne loc_02320626	; 02320616
	mov r0,#0x1	; 02320618
	bl loc_02324088	; 0232061A
	cmp r0,#0x0	; 0232061E
	beq loc_02320632	; 02320620
	cmp r4,#0x0	; 02320622
	bne loc_02320632	; 02320624
loc_02320626:
	bl loc_023207B8	; 02320626
	mov r1,#0x0	; 0232062A
	ldr r0,[pool_023207A8]	; 0232062C
	str r1,[r0,#0x4]	; 0232062E
	b loc_02320796	; 02320630
loc_02320632:
	add r0,r5,#0x0	; 02320632
	mov r1,#0x0	; 02320634
	bl loc_02321D08	; 02320636
	cmp r0,#0x0	; 0232063A
	bne loc_0232064C	; 0232063C
	mov r0,#0x1	; 0232063E
	bl loc_02324088	; 02320640
	cmp r0,#0x0	; 02320644
	beq loc_02320666	; 02320646
	cmp r4,#0x3	; 02320648
	bne loc_02320666	; 0232064A
loc_0232064C:
	bl loc_023207B8	; 0232064C
	mov r1,#0x3	; 02320650
	ldr r0,[pool_023207A8]	; 02320652
	str r1,[r0,#0x4]	; 02320654
	bl loc_02321E10	; 02320656
	ldr r1,[pool_023207AC]	; 0232065A
	ldr r2,[r1,#0x68]	; 0232065C
	ldr r0,[pool_023207B0]	; 0232065E
	orr r2,r0	; 02320660
	str r2,[r1,#0x68]	; 02320662
	b loc_02320796	; 02320664
loc_02320666:
	add r0,r5,#0x0	; 02320666
	mov r1,#0x2	; 02320668
	bl loc_02321D08	; 0232066A
	cmp r0,#0x0	; 0232066E
	bne loc_02320680	; 02320670
	mov r0,#0x1	; 02320672
	bl loc_02324088	; 02320674
	cmp r0,#0x0	; 02320678
	beq loc_0232068C	; 0232067A
	cmp r4,#0x2	; 0232067C
	bne loc_0232068C	; 0232067E
loc_02320680:
	bl loc_023207B8	; 02320680
	mov r1,#0x2	; 02320684
	ldr r0,[pool_023207A8]	; 02320686
	str r1,[r0,#0x4]	; 02320688
	b loc_02320796	; 0232068A
loc_0232068C:
	ldr r0,[pool_023207AC]	; 0232068C
	ldr r0,[r0,#0x68]	; 0232068E
	lsl r0,r0,#0x1b	; 02320690
	lsr r0,r0,#0x1f	; 02320692
	cmp r0,#0x0	; 02320694
	beq loc_023206A4	; 02320696
	add r0,r5,#0x0	; 02320698
	mov r1,#0x1	; 0232069A
	bl loc_02321D08	; 0232069C
	cmp r0,#0x0	; 023206A0
	bne loc_023206B2	; 023206A2
loc_023206A4:
	mov r0,#0x1	; 023206A4
	bl loc_02324088	; 023206A6
	cmp r0,#0x0	; 023206AA
	beq loc_023206BE	; 023206AC
	cmp r4,#0x4	; 023206AE
	bne loc_023206BE	; 023206B0
loc_023206B2:
	bl loc_023207B8	; 023206B2
	mov r1,#0x4	; 023206B6
	ldr r0,[pool_023207A8]	; 023206B8
	str r1,[r0,#0x4]	; 023206BA
	b loc_02320796	; 023206BC
loc_023206BE:
	ldr r0,[pool_023207AC]	; 023206BE
	ldr r0,[r0,#0x68]	; 023206C0
	lsl r0,r0,#0x1a	; 023206C2
	lsr r0,r0,#0x1f	; 023206C4
	cmp r0,#0x0	; 023206C6
	beq loc_023206D6	; 023206C8
	add r0,r5,#0x0	; 023206CA
	mov r1,#0x3	; 023206CC
	bl loc_02321D08	; 023206CE
	cmp r0,#0x0	; 023206D2
	bne loc_023206E4	; 023206D4
loc_023206D6:
	mov r0,#0x1	; 023206D6
	bl loc_02324088	; 023206D8
	cmp r0,#0x0	; 023206DC
	beq loc_023206F0	; 023206DE
	cmp r4,#0x1	; 023206E0
	bne loc_023206F0	; 023206E2
loc_023206E4:
	bl loc_023207B8	; 023206E4
	mov r1,#0x1	; 023206E8
	ldr r0,[pool_023207A8]	; 023206EA
	str r1,[r0,#0x4]	; 023206EC
	b loc_02320796	; 023206EE
loc_023206F0:
	add r0,r5,#0x0	; 023206F0
	mov r1,#0x4	; 023206F2
	bl loc_02321D00	; 023206F4
	cmp r0,#0x0	; 023206F8
	bne loc_0232070A	; 023206FA
	mov r0,#0x1	; 023206FC
	bl loc_02324088	; 023206FE
	cmp r0,#0x0	; 02320702
	beq loc_02320726	; 02320704
	cmp r4,#0x5	; 02320706
	bne loc_02320726	; 02320708
loc_0232070A:
	mov r0,#0x26	; 0232070A
	bl loc_0232365C	; 0232070C
	bl loc_023252F8	; 02320710
	ldr r1,[pool_023207AC]	; 02320714
	ldr r2,[r1,#0x68]	; 02320716
	mov r0,#0x80	; 02320718
	orr r2,r0	; 0232071A
	str r2,[r1,#0x68]	; 0232071C
	mov r1,#0x8	; 0232071E
	ldr r0,[pool_023207A4]	; 02320720
	str r1,[r0,#0x2c]	; 02320722
	b loc_02320796	; 02320724
loc_02320726:
	add r0,r5,#0x0	; 02320726
	mov r1,#0x6	; 02320728
	bl loc_02321D00	; 0232072A
	cmp r0,#0x0	; 0232072E
	bne loc_02320740	; 02320730
	mov r0,#0x1	; 02320732
	bl loc_02324088	; 02320734
	cmp r0,#0x0	; 02320738
	beq loc_02320796	; 0232073A
	cmp r4,#0x6	; 0232073C
	bne loc_02320796	; 0232073E
loc_02320740:
	bl loc_02325694	; 02320740
	add r4,r0,#0x0	; 02320744
	bl loc_02325694	; 02320746
	ldr r0,[r0,#0x0]	; 0232074A
	lsl r0,r0,#0x16	; 0232074C
	lsr r0,r0,#0x1f	; 0232074E
	cmp r0,#0x0	; 02320750
	bne loc_02320758	; 02320752
	mov r2,#0x1	; 02320754
	b loc_0232075A	; 02320756
loc_02320758:
	mov r2,#0x0	; 02320758
loc_0232075A:
	ldr r1,[r4,#0x0]	; 0232075A
	ldr r0,[pool_023207B4]	; 0232075C
	and r1,r0	; 0232075E
	mov r0,#0x1	; 02320760
	and r2,r0	; 02320762
	lsl r0,r2,#0x9	; 02320764
	orr r1,r0	; 02320766
	str r1,[r4,#0x0]	; 02320768
	bl loc_02325694	; 0232076A
	ldr r0,[r0,#0x0]	; 0232076E
	lsl r0,r0,#0x16	; 02320770
	lsr r0,r0,#0x1f	; 02320772
	cmp r0,#0x0	; 02320774
	beq loc_02320788	; 02320776
	mov r0,#0x2d	; 02320778
	bl loc_0232365C	; 0232077A
	mov r0,#0x2	; 0232077E
	mov r1,#0x1	; 02320780
	bl loc_0232F760	; 02320782
	b loc_02320796	; 02320786
loc_02320788:
	mov r0,#0x2e	; 02320788
	bl loc_0232365C	; 0232078A
	mov r0,#0x2	; 0232078E
	mov r1,#0x0	; 02320790
	bl loc_0232F760	; 02320792
loc_02320796:
	add sp,#0x4	; 02320796
	pop {r4,r5}	; 02320798
	pop {r3}	; 0232079A
	bx r3	; 0232079C
	.byte 0xC0, 0x46	; 023207A0
pool_023207A0:
loc_023207A0:
	.word 0x02330E80	; 023207A0
pool_023207A4:
loc_023207A4:
	.word P1_BssStart + 0x100	; 023207A4
pool_023207A8:
loc_023207A8:
	.word P1_BssStart + 0xB00	; 023207A8
pool_023207AC:
loc_023207AC:
	.word P1_BssStart + 0x1300	; 023207AC
pool_023207B0:
loc_023207B0:
	.word 0x00000800	; 023207B0
pool_023207B4:
loc_023207B4:
	.word 0xFFFFFDFF	; 023207B4

; ===== function loc_023207B8 =====
loc_023207B8:
	push {lr}	; 023207B8
	sub sp,#0x4	; 023207BA
	mov r0,#0x1a	; 023207BC
	bl loc_0232365C	; 023207BE
	mov r1,#0x6	; 023207C2
	ldr r0,[pool_023207D0]	; 023207C4
	str r1,[r0,#0x2c]	; 023207C6
	add sp,#0x4	; 023207C8
	pop {r3}	; 023207CA
	bx r3	; 023207CC
	.byte 0xC0, 0x46	; 023207D0
pool_023207D0:
loc_023207D0:
	.word P1_BssStart + 0x100	; 023207D0

; ===== function loc_023207D4 =====
loc_023207D4:
	push {lr}	; 023207D4
	sub sp,#0x4	; 023207D6
	ldr r0,[pool_02320810]	; 023207D8
	ldr r1,[r0,#0x8]	; 023207DA
	add r1,r1,#0x1	; 023207DC
	str r1,[r0,#0x8]	; 023207DE
	cmp r1,#0xf	; 023207E0
	bgt loc_023207FA	; 023207E2
	lsl r0,r1,#0x4	; 023207E4
	mov r1,#0xf	; 023207E6
	blx P1_SignedDivMod	; 023207E8
	mov r1,#0x10	; 023207EC
	sub r1,r1,r0	; 023207EE
	lsl r1,r1,#0x8	; 023207F0
	orr r0,r1	; 023207F2
	ldr r1,[pool_02320814]	; 023207F4
	strh r0,[r1,#0x0]	; 023207F6
	b loc_02320808	; 023207F8
loc_023207FA:
	mov r2,#0x0	; 023207FA
	ldr r1,[pool_02320818]	; 023207FC
	strh r2,[r1,#0x0]	; 023207FE
	str r2,[r0,#0x8]	; 02320800
	mov r1,#0x5	; 02320802
	ldr r0,[pool_0232081C]	; 02320804
	str r1,[r0,#0x2c]	; 02320806
loc_02320808:
	add sp,#0x4	; 02320808
	pop {r3}	; 0232080A
	bx r3	; 0232080C
	.byte 0xC0, 0x46	; 02320810
pool_02320810:
loc_02320810:
	.word P1_BssStart + 0xB00	; 02320810
pool_02320814:
loc_02320814:
	.word REG_BLDALPHA_SUB	; 02320814
pool_02320818:
loc_02320818:
	.word REG_BLDCNT_SUB	; 02320818
pool_0232081C:
loc_0232081C:
	.word P1_BssStart + 0x100	; 0232081C

; ===== function loc_02320820 =====
loc_02320820:
	push {lr}	; 02320820
	sub sp,#0x4	; 02320822
	ldr r0,[pool_02320874]	; 02320824
	ldr r1,[r0,#0x8]	; 02320826
	add r1,r1,#0x1	; 02320828
	str r1,[r0,#0x8]	; 0232082A
	cmp r1,#0xf	; 0232082C
	bgt loc_02320846	; 0232082E
	lsl r0,r1,#0x4	; 02320830
	mov r1,#0xf	; 02320832
	blx P1_SignedDivMod	; 02320834
	mov r1,#0x10	; 02320838
	sub r1,r1,r0	; 0232083A
	lsl r1,r1,#0x8	; 0232083C
	orr r0,r1	; 0232083E
	ldr r1,[pool_02320878]	; 02320840
	strh r0,[r1,#0x0]	; 02320842
	b loc_0232086C	; 02320844
loc_02320846:
	mov r0,#0x10	; 02320846
	str r0,[sp,#0x0]	; 02320848
	ldr r0,[pool_0232087C]	; 0232084A
	mov r1,#0x0	; 0232084C
	mov r2,#0x2	; 0232084E
	add r3,r1,#0x0	; 02320850
	bl loc_0232DBC0	; 02320852
	mov r1,#0x0	; 02320856
	ldr r0,[pool_02320874]	; 02320858
	str r1,[r0,#0x8]	; 0232085A
	ldr r1,[pool_02320880]	; 0232085C
	ldr r2,[r1,#0x68]	; 0232085E
	mov r0,#0x2	; 02320860
	orr r2,r0	; 02320862
	str r2,[r1,#0x68]	; 02320864
	mov r1,#0x4	; 02320866
	ldr r0,[pool_02320884]	; 02320868
	str r1,[r0,#0x2c]	; 0232086A
loc_0232086C:
	add sp,#0x4	; 0232086C
	pop {r3}	; 0232086E
	bx r3	; 02320870
	.byte 0xC0, 0x46	; 02320874
pool_02320874:
loc_02320874:
	.word P1_BssStart + 0xB00	; 02320874
pool_02320878:
loc_02320878:
	.word REG_BLDALPHA_SUB	; 02320878
pool_0232087C:
loc_0232087C:
	.word REG_BLDCNT_SUB	; 0232087C
pool_02320880:
loc_02320880:
	.word P1_BssStart + 0x1300	; 02320880
pool_02320884:
loc_02320884:
	.word P1_BssStart + 0x100	; 02320884

; ===== function loc_02320888 =====
loc_02320888:
	push {r4,r5,lr}	; 02320888
	sub sp,#0x4	; 0232088A
	mov r5,#0x0	; 0232088C
	bl loc_02325694	; 0232088E
	add r4,r0,#0x0	; 02320892
	ldr r0,[pool_02320940]	; 02320894
	bl loc_0232190C	; 02320896
	ldr r0,[pool_02320944]	; 0232089A
	ldr r1,[r0,#0x8]	; 0232089C
	add r1,r1,#0x1	; 0232089E
	str r1,[r0,#0x8]	; 023208A0
	cmp r1,#0xf	; 023208A2
	bgt loc_023208D4	; 023208A4
	lsl r0,r1,#0x4	; 023208A6
	mov r1,#0xf	; 023208A8
	blx P1_SignedDivMod	; 023208AA
	mov r1,#0x10	; 023208AE
	sub r1,r1,r0	; 023208B0
	lsl r0,r0,#0x8	; 023208B2
	orr r1,r0	; 023208B4
	ldr r0,[pool_02320948]	; 023208B6
	strh r1,[r0,#0x0]	; 023208B8
	ldr r0,[pool_02320944]	; 023208BA
	ldr r0,[r0,#0x8]	; 023208BC
	cmp r0,#0xf	; 023208BE
	bne loc_02320934	; 023208C0
	ldr r1,[pool_0232094C]	; 023208C2
	ldr r2,[r1,#0x68]	; 023208C4
	mov r0,#0x1	; 023208C6
	bic r2,r0	; 023208C8
	str r2,[r1,#0x68]	; 023208CA
	ldr r0,[pool_02320950]	; 023208CC
	and r2,r0	; 023208CE
	str r2,[r1,#0x68]	; 023208D0
	b loc_02320934	; 023208D2
loc_023208D4:
	ldr r1,[r4,#0x0]	; 023208D4
	lsl r0,r1,#0x1a	; 023208D6
	lsr r0,r0,#0x1f	; 023208D8
	cmp r0,#0x0	; 023208DA
	bne loc_023208E6	; 023208DC
	lsl r0,r1,#0x19	; 023208DE
	lsr r0,r0,#0x1f	; 023208E0
	cmp r0,#0x0	; 023208E2
	beq loc_023208EA	; 023208E4
loc_023208E6:
	mov r5,#0x4	; 023208E6
	b loc_02320934	; 023208E8
loc_023208EA:
	lsl r0,r1,#0x17	; 023208EA
	lsr r0,r0,#0x1f	; 023208EC
	cmp r0,#0x0	; 023208EE
	beq loc_023208F6	; 023208F0
	mov r5,#0x1	; 023208F2
	b loc_02320934	; 023208F4
loc_023208F6:
	ldr r1,[pool_02320954]	; 023208F6
	ldr r2,[r1,#0x0]	; 023208F8
	ldr r0,[pool_02320958]	; 023208FA
	and r2,r0	; 023208FC
	ldr r0,[pool_0232095C]	; 023208FE
	orr r2,r0	; 02320900
	str r2,[r1,#0x0]	; 02320902
	mov r0,#0x10	; 02320904
	str r0,[sp,#0x0]	; 02320906
	ldr r0,[pool_02320960]	; 02320908
	mov r1,#0x2	; 0232090A
	mov r2,#0x20	; 0232090C
	lsl r3,r5,#0	; 0232090E
	bl loc_0232DBC0	; 02320910
	bl loc_02322A54	; 02320914
	ldr r1,[pool_0232094C]	; 02320918
	ldr r2,[r1,#0x68]	; 0232091A
	mov r0,#0x8	; 0232091C
	orr r2,r0	; 0232091E
	str r2,[r1,#0x68]	; 02320920
	mov r0,#0x4	; 02320922
	orr r2,r0	; 02320924
	str r2,[r1,#0x68]	; 02320926
	lsl r1,r5,#0	; 02320928
	ldr r0,[pool_02320944]	; 0232092A
	str r1,[r0,#0x8]	; 0232092C
	mov r1,#0x3	; 0232092E
	ldr r0,[pool_02320964]	; 02320930
	str r1,[r0,#0x2c]	; 02320932
loc_02320934:
	add r0,r5,#0x0	; 02320934
	add sp,#0x4	; 02320936
	pop {r4,r5}	; 02320938
	pop {r3}	; 0232093A
	bx r3	; 0232093C
	.byte 0xC0, 0x46	; 02320940
pool_02320940:
loc_02320940:
	.word 0x02331000	; 02320940
pool_02320944:
loc_02320944:
	.word P1_BssStart + 0xB00	; 02320944
pool_02320948:
loc_02320948:
	.word REG_BLDALPHA_SUB	; 02320948
pool_0232094C:
loc_0232094C:
	.word P1_BssStart + 0x1300	; 0232094C
pool_02320950:
loc_02320950:
	.word 0xFFFFFDFF	; 02320950
pool_02320954:
loc_02320954:
	.word REG_DISPCNT_B	; 02320954
pool_02320958:
loc_02320958:
	.word 0xFFFFE0FF	; 02320958
pool_0232095C:
loc_0232095C:
	.word 0x00001200	; 0232095C
pool_02320960:
loc_02320960:
	.word REG_BLDCNT_SUB	; 02320960
pool_02320964:
loc_02320964:
	.word P1_BssStart + 0x100	; 02320964

; ===== function loc_02320968 =====
loc_02320968:
	push {r4,r5,lr}	; 02320968
	sub sp,#0x4	; 0232096A
	ldr r0,[pool_02320A88]	; 0232096C
	ldr r1,[r0,#0x8]	; 0232096E
	add r1,r1,#0x1	; 02320970
	str r1,[r0,#0x8]	; 02320972
	ldr r0,[pool_02320A8C]	; 02320974
	bl loc_0232190C	; 02320976
	ldr r0,[pool_02320A90]	; 0232097A
	ldr r0,[r0,#0x68]	; 0232097C
	lsl r0,r0,#0x17	; 0232097E
	lsr r0,r0,#0x1f	; 02320980
	cmp r0,#0x0	; 02320982
	beq loc_023209EE	; 02320984
	ldr r0,[pool_02320A88]	; 02320986
	ldr r5,[r0,#0x8]	; 02320988
	sub r5,#0x5a	; 0232098A
	add r0,r5,#0x0	; 0232098C
	mov r1,#0x1e	; 0232098E
	blx P1_SignedDivMod	; 02320990
	add r4,r1,#0x0	; 02320994
	add r0,r5,#0x0	; 02320996
	mov r1,#0x1e	; 02320998
	blx P1_SignedDivMod	; 0232099A
	mov r1,#0x1	; 0232099E
	and r0,r1	; 023209A0
	cmp r0,#0x0	; 023209A2
	beq loc_023209CC	; 023209A4
	mov r0,#0x1f	; 023209A6
	add r5,r4,#0x0	; 023209A8
	mul r5,r0	; 023209AA
	add r0,r5,#0x0	; 023209AC
	mov r1,#0x1e	; 023209AE
	blx P1_SignedDivMod	; 023209B0
	ldr r1,[pool_02320A90]	; 023209B4
	str r0,[r1,#0x5c]	; 023209B6
	mov r1,#0x1e	; 023209B8
	sub r2,r1,r4	; 023209BA
	mov r0,#0x14	; 023209BC
	mul r2,r0	; 023209BE
	add r0,r5,r2	; 023209C0
	blx P1_SignedDivMod	; 023209C2
	ldr r1,[pool_02320A90]	; 023209C6
	str r0,[r1,#0x60]	; 023209C8
	b loc_023209EE	; 023209CA
loc_023209CC:
	mov r1,#0x1e	; 023209CC
	sub r5,r1,r4	; 023209CE
	mov r0,#0x1f	; 023209D0
	mul r5,r0	; 023209D2
	add r0,r5,#0x0	; 023209D4
	blx P1_SignedDivMod	; 023209D6
	ldr r1,[pool_02320A90]	; 023209DA
	str r0,[r1,#0x5c]	; 023209DC
	mov r0,#0x14	; 023209DE
	mul r4,r0	; 023209E0
	add r0,r4,r5	; 023209E2
	mov r1,#0x1e	; 023209E4
	blx P1_SignedDivMod	; 023209E6
	ldr r1,[pool_02320A90]	; 023209EA
	str r0,[r1,#0x60]	; 023209EC
loc_023209EE:
	ldr r0,[pool_02320A88]	; 023209EE
	ldr r0,[r0,#0x8]	; 023209F0
	cmp r0,#0x5a	; 023209F2
	bne loc_02320A00	; 023209F4
	ldr r1,[pool_02320A90]	; 023209F6
	ldr r2,[r1,#0x68]	; 023209F8
	ldr r0,[pool_02320A94]	; 023209FA
	orr r2,r0	; 023209FC
	str r2,[r1,#0x68]	; 023209FE
loc_02320A00:
	ldr r0,[pool_02320A88]	; 02320A00
	ldr r0,[r0,#0x8]	; 02320A02
	cmp r0,#0x5a	; 02320A04
	ble loc_02320A7E	; 02320A06
	ldr r0,[pool_02320A98]	; 02320A08
	bl loc_02324078	; 02320A0A
	cmp r0,#0x0	; 02320A0E
	bne loc_02320A40	; 02320A10
	bl loc_0232405C	; 02320A12
	cmp r0,#0x0	; 02320A16
	bne loc_02320A40	; 02320A18
	ldr r0,[pool_02320A88]	; 02320A1A
	ldr r1,[r0,#0x8]	; 02320A1C
	ldr r0,[pool_02320A9C]	; 02320A1E
	cmp r1,r0	; 02320A20
	bgt loc_02320A40	; 02320A22
	bl loc_02325694	; 02320A24
	ldr r0,[r0,#0x0]	; 02320A28
	lsl r0,r0,#0x17	; 02320A2A
	lsr r0,r0,#0x1f	; 02320A2C
	cmp r0,#0x0	; 02320A2E
	bne loc_02320A40	; 02320A30
	bl loc_02325694	; 02320A32
	ldr r0,[r0,#0x0]	; 02320A36
	lsl r0,r0,#0x19	; 02320A38
	lsr r0,r0,#0x1f	; 02320A3A
	cmp r0,#0x0	; 02320A3C
	beq loc_02320A7E	; 02320A3E
loc_02320A40:
	ldr r0,[pool_02320A88]	; 02320A40
	ldr r1,[r0,#0x8]	; 02320A42
	ldr r0,[pool_02320A9C]	; 02320A44
	cmp r1,r0	; 02320A46
	bgt loc_02320A6C	; 02320A48
	bl loc_02325694	; 02320A4A
	ldr r0,[r0,#0x0]	; 02320A4E
	lsl r0,r0,#0x17	; 02320A50
	lsr r0,r0,#0x1f	; 02320A52
	cmp r0,#0x0	; 02320A54
	bne loc_02320A6C	; 02320A56
	bl loc_02325694	; 02320A58
	ldr r0,[r0,#0x0]	; 02320A5C
	lsl r0,r0,#0x19	; 02320A5E
	lsr r0,r0,#0x1f	; 02320A60
	cmp r0,#0x0	; 02320A62
	bne loc_02320A6C	; 02320A64
	mov r0,#0x31	; 02320A66
	bl loc_0232365C	; 02320A68
loc_02320A6C:
	ldr r0,[pool_02320A8C]	; 02320A6C
	bl loc_023218E8	; 02320A6E
	mov r1,#0x0	; 02320A72
	ldr r0,[pool_02320A88]	; 02320A74
	str r1,[r0,#0x8]	; 02320A76
	mov r1,#0x2	; 02320A78
	ldr r0,[pool_02320AA0]	; 02320A7A
	str r1,[r0,#0x2c]	; 02320A7C
loc_02320A7E:
	add sp,#0x4	; 02320A7E
	pop {r4,r5}	; 02320A80
	pop {r3}	; 02320A82
	bx r3	; 02320A84
	.byte 0xC0, 0x46	; 02320A88
pool_02320A88:
loc_02320A88:
	.word P1_BssStart + 0xB00	; 02320A88
pool_02320A8C:
loc_02320A8C:
	.word 0x02331000	; 02320A8C
pool_02320A90:
loc_02320A90:
	.word P1_BssStart + 0x1300	; 02320A90
pool_02320A94:
loc_02320A94:
	.word 0x00000100	; 02320A94
pool_02320A98:
loc_02320A98:
	.word 0x00000FFF	; 02320A98
pool_02320A9C:
loc_02320A9C:
	.word 0x00000E10	; 02320A9C
pool_02320AA0:
loc_02320AA0:
	.word P1_BssStart + 0x100	; 02320AA0

; ===== function loc_02320AA4 =====
loc_02320AA4:
	push {lr}	; 02320AA4
	sub sp,#0x4	; 02320AA6
	ldr r0,[pool_02320AE4]	; 02320AA8
	ldr r1,[r0,#0x8]	; 02320AAA
	add r1,r1,#0x1	; 02320AAC
	str r1,[r0,#0x8]	; 02320AAE
	ldr r0,[pool_02320AE8]	; 02320AB0
	bl loc_0232190C	; 02320AB2
	ldr r0,[pool_02320AE4]	; 02320AB6
	ldr r1,[r0,#0x8]	; 02320AB8
	cmp r1,#0xf	; 02320ABA
	bgt loc_02320AD4	; 02320ABC
	lsl r0,r1,#0x4	; 02320ABE
	mov r1,#0xf	; 02320AC0
	blx P1_SignedDivMod	; 02320AC2
	mov r1,#0x10	; 02320AC6
	sub r1,r1,r0	; 02320AC8
	lsl r1,r1,#0x8	; 02320ACA
	orr r0,r1	; 02320ACC
	ldr r1,[pool_02320AEC]	; 02320ACE
	strh r0,[r1,#0x0]	; 02320AD0
	b loc_02320ADE	; 02320AD2
loc_02320AD4:
	mov r1,#0x0	; 02320AD4
	str r1,[r0,#0x8]	; 02320AD6
	mov r1,#0x1	; 02320AD8
	ldr r0,[pool_02320AF0]	; 02320ADA
	str r1,[r0,#0x2c]	; 02320ADC
loc_02320ADE:
	add sp,#0x4	; 02320ADE
	pop {r3}	; 02320AE0
	bx r3	; 02320AE2
pool_02320AE4:
loc_02320AE4:
	.word P1_BssStart + 0xB00	; 02320AE4
pool_02320AE8:
loc_02320AE8:
	.word 0x02331000	; 02320AE8
pool_02320AEC:
loc_02320AEC:
	.word REG_BLDALPHA_SUB	; 02320AEC
pool_02320AF0:
loc_02320AF0:
	.word P1_BssStart + 0x100	; 02320AF0

; ===== function loc_02320AF4 =====
loc_02320AF4:
	push {r4,r5,r6,r7,lr}	; 02320AF4
	sub sp,#0x54	; 02320AF6
	bl loc_02323DB8	; 02320AF8
	add r7,r0,#0x0	; 02320AFC
	bl loc_0232545C	; 02320AFE
	bl loc_02325030	; 02320B02
	ldr r0,[pool_02320D9C]	; 02320B06
	ldr r0,[r0,#0x54]	; 02320B08
	lsl r0,r0,#0x1e	; 02320B0A
	lsr r0,r0,#0x1f	; 02320B0C
	cmp r0,#0x0	; 02320B0E
	beq loc_02320B2E	; 02320B10
	mov r0,#0x1	; 02320B12
	str r0,[sp,#0x0]	; 02320B14
	ldr r0,[pool_02320DA0]	; 02320B16
	mov r1,#0x0	; 02320B18
	add r2,r1,#0x0	; 02320B1A
	add r3,r1,#0x0	; 02320B1C
	bl loc_023236B8	; 02320B1E
	add r0,r7,#0x0	; 02320B22
	ldr r1,[pool_02320DA4]	; 02320B24
	ldr r2,[pool_02320DA8]	; 02320B26
	mov r3,#0x0	; 02320B28
	bl loc_02323BA4	; 02320B2A
loc_02320B2E:
	ldr r0,[pool_02320DAC]	; 02320B2E
	ldr r0,[r0,#0x68]	; 02320B30
	lsl r0,r0,#0x1f	; 02320B32
	lsr r0,r0,#0x1f	; 02320B34
	cmp r0,#0x0	; 02320B36
	beq loc_02320B48	; 02320B38
	add r0,r7,#0x0	; 02320B3A
	ldr r1,[pool_02320DB0]	; 02320B3C
	ldr r2,[pool_02320DB4]	; 02320B3E
	ldr r2,[r2,#0x14]	; 02320B40
	mov r3,#0x1	; 02320B42
	bl loc_02323AFC	; 02320B44
loc_02320B48:
	ldr r0,[pool_02320DAC]	; 02320B48
	ldr r1,[r0,#0x68]	; 02320B4A
	lsl r0,r1,#0x16	; 02320B4C
	lsr r0,r0,#0x1f	; 02320B4E
	cmp r0,#0x0	; 02320B50
	beq loc_02320B5E	; 02320B52
	ldr r0,[pool_02320DB8]	; 02320B54
	lsl r1,r1,#0x1b	; 02320B56
	lsr r1,r1,#0x1f	; 02320B58
	bl loc_02321A1C	; 02320B5A
loc_02320B5E:
	ldr r0,[pool_02320DAC]	; 02320B5E
	ldr r0,[r0,#0x68]	; 02320B60
	lsl r0,r0,#0x1e	; 02320B62
	lsr r0,r0,#0x1f	; 02320B64
	cmp r0,#0x0	; 02320B66
	bne loc_02320B6C	; 02320B68
	b loc_02320D94	; 02320B6A
loc_02320B6C:
	mov r4,#0x0	; 02320B6C
loc_02320B6E:
	add r1,r4,#0x0	; 02320B6E
	mov r0,#0xc	; 02320B70
	mul r1,r0	; 02320B72
	ldr r0,[pool_02320DBC]	; 02320B74
	add r5,r0,r1	; 02320B76
	ldr r0,[r5,#0x4]	; 02320B78
	ldr r1,[pool_02320DC0]	; 02320B7A
	blx P1_SignedDivMod	; 02320B7C
	ldr r1,[pool_02320DB4]	; 02320B80
	ldr r1,[r1,#0x10]	; 02320B82
	add r6,r1,r0	; 02320B84
	cmp r6,#0xf0	; 02320B86
	ble loc_02320B8C	; 02320B88
	mov r6,#0xf0	; 02320B8A
loc_02320B8C:
	ldr r0,[r5,#0x0]	; 02320B8C
	ldr r1,[pool_02320DC0]	; 02320B8E
	blx P1_SignedDivMod	; 02320B90
	str r0,[sp,#0x0]	; 02320B94
	str r6,[sp,#0x4]	; 02320B96
	mov r0,#0x1	; 02320B98
	str r0,[sp,#0x8]	; 02320B9A
	add r0,r7,#0x0	; 02320B9C
	ldr r1,[pool_02320DA4]	; 02320B9E
	ldr r2,[pool_02320DC4]	; 02320BA0
	ldr r3,[r5,#0x8]	; 02320BA2
	bl loc_02323AA8	; 02320BA4
	add r4,r4,#0x1	; 02320BA8
	cmp r4,#0x4	; 02320BAA
	blt loc_02320B6E	; 02320BAC
	mov r0,#0x0	; 02320BAE
	str r0,[sp,#0x24]	; 02320BB0
	ldr r1,[pool_02320DC8]	; 02320BB2
	ldr r0,[r1,#0x4]	; 02320BB4
	str r0,[sp,#0x18]	; 02320BB6
	ldr r0,[r1,#0x8]	; 02320BB8
	str r0,[sp,#0x1c]	; 02320BBA
	ldr r0,[r1,#0x0]	; 02320BBC
	str r0,[sp,#0x20]	; 02320BBE
	ldr r0,[sp,#0x24]	; 02320BC0
	str r0,[sp,#0x28]	; 02320BC2
	str r0,[sp,#0x2c]	; 02320BC4
	str r0,[sp,#0x30]	; 02320BC6
	str r0,[sp,#0x40]	; 02320BC8
	str r0,[sp,#0x3c]	; 02320BCA
	str r0,[sp,#0x38]	; 02320BCC
	str r0,[sp,#0x34]	; 02320BCE
	str r0,[sp,#0x44]	; 02320BD0
loc_02320BD2:
	ldr r1,[sp,#0x24]	; 02320BD2
	mov r0,#0x3c	; 02320BD4
	mul r1,r0	; 02320BD6
	ldr r0,[pool_02320DCC]	; 02320BD8
	add r5,r0,r1	; 02320BDA
	mov r4,#0x1	; 02320BDC
	mov r0,#0x2	; 02320BDE
	ldrsh r1,[r5,r0]	; 02320BE0
	ldr r0,[pool_02320DB4]	; 02320BE2
	ldr r0,[r0,#0x10]	; 02320BE4
	add r6,r1,r0	; 02320BE6
	cmp r6,#0x80	; 02320BE8
	ble loc_02320BEE	; 02320BEA
	mov r6,#0x80	; 02320BEC
loc_02320BEE:
	ldr r0,[pool_02320DB4]	; 02320BEE
	ldr r1,[r0,#0x4]	; 02320BF0
	ldr r0,[sp,#0x24]	; 02320BF2
	cmp r0,r1	; 02320BF4
	bne loc_02320BFA	; 02320BF6
	ldr r4,[sp,#0x28]	; 02320BF8
loc_02320BFA:
	ldr r0,[r5,#0x8]	; 02320BFA
	cmp r0,#0x0	; 02320BFC
	blt loc_02320C12	; 02320BFE
	str r4,[sp,#0x0]	; 02320C00
	add r0,r5,#0x0	; 02320C02
	add r0,#0x10	; 02320C04
	ldr r1,[sp,#0x30]	; 02320C06
	ldrsh r1,[r5,r1]	; 02320C08
	add r2,r6,#0x0	; 02320C0A
	mov r3,#0x1	; 02320C0C
	bl loc_023236B8	; 02320C0E
loc_02320C12:
	ldr r0,[pool_02320DD0]	; 02320C12
	ldr r1,[r5,#0xc]	; 02320C14
	bl loc_02321CF8	; 02320C16
	cmp r0,#0x0	; 02320C1A
	beq loc_02320C28	; 02320C1C
	cmp r0,#0x1	; 02320C1E
	beq loc_02320C28	; 02320C20
	cmp r0,#0x2	; 02320C22
	beq loc_02320C2E	; 02320C24
	b loc_02320C34	; 02320C26
loc_02320C28:
	ldr r0,[sp,#0x18]	; 02320C28
	str r0,[sp,#0x14]	; 02320C2A
	b loc_02320C38	; 02320C2C
loc_02320C2E:
	ldr r0,[sp,#0x1c]	; 02320C2E
	str r0,[sp,#0x14]	; 02320C30
	b loc_02320C38	; 02320C32
loc_02320C34:
	ldr r0,[sp,#0x20]	; 02320C34
	str r0,[sp,#0x14]	; 02320C36
loc_02320C38:
	ldr r0,[sp,#0x24]	; 02320C38
	cmp r0,#0x4	; 02320C3A
	bne loc_02320CA0	; 02320C3C
	ldr r0,[pool_02320DAC]	; 02320C3E
	ldr r0,[r0,#0x68]	; 02320C40
	lsl r0,r0,#0x1b	; 02320C42
	lsr r0,r0,#0x1f	; 02320C44
	cmp r0,#0x0	; 02320C46
	beq loc_02320C7C	; 02320C48
	ldr r0,[sp,#0x34]	; 02320C4A
	ldrsh r1,[r5,r0]	; 02320C4C
	add r1,#0x28	; 02320C4E
	ldr r0,[pool_02320DD4]	; 02320C50
	and r1,r0	; 02320C52
	lsl r1,r1,#0x10	; 02320C54
	add r0,r6,#0x0	; 02320C56
	add r0,#0x4f	; 02320C58
	mov r2,#0xff	; 02320C5A
	and r0,r2	; 02320C5C
	lsl r2,r4,#0xa	; 02320C5E
	orr r0,r2	; 02320C60
	ldr r2,[pool_02320DD8]	; 02320C62
	orr r0,r2	; 02320C64
	orr r1,r0	; 02320C66
	str r1,[sp,#0x48]	; 02320C68
	ldr r1,[pool_02320DDC]	; 02320C6A
	add r0,sp,#0x48	; 02320C6C
	strh r1,[r0,#0x4]	; 02320C6E
	add r0,r7,#0x0	; 02320C70
	add r1,sp,#0x48	; 02320C72
	ldr r2,[sp,#0x2c]	; 02320C74
	bl loc_023238D8	; 02320C76
	b loc_02320D0E	; 02320C7A
loc_02320C7C:
	mov r0,#0x4	; 02320C7C
	str r0,[sp,#0x14]	; 02320C7E
	ldr r0,[sp,#0x38]	; 02320C80
	ldrsh r0,[r5,r0]	; 02320C82
	str r0,[sp,#0x0]	; 02320C84
	str r6,[sp,#0x4]	; 02320C86
	mov r0,#0x4	; 02320C88
	str r0,[sp,#0x8]	; 02320C8A
	str r4,[sp,#0xc]	; 02320C8C
	mov r0,#0x1	; 02320C8E
	str r0,[sp,#0x10]	; 02320C90
	add r0,r7,#0x0	; 02320C92
	ldr r1,[pool_02320DA4]	; 02320C94
	ldr r2,[pool_02320DC4]	; 02320C96
	mov r3,#0x4	; 02320C98
	bl loc_0232396C	; 02320C9A
	b loc_02320D0E	; 02320C9E
loc_02320CA0:
	cmp r0,#0x1	; 02320CA0
	bne loc_02320CE4	; 02320CA2
	ldr r0,[pool_02320DAC]	; 02320CA4
	ldr r1,[r0,#0x68]	; 02320CA6
	lsl r0,r1,#0x1a	; 02320CA8
	lsr r0,r0,#0x1f	; 02320CAA
	cmp r0,#0x0	; 02320CAC
	bne loc_02320CC4	; 02320CAE
	mov r0,#0x4	; 02320CB0
	str r0,[sp,#0x14]	; 02320CB2
	lsl r0,r1,#0x19	; 02320CB4
	lsr r0,r0,#0x1f	; 02320CB6
	cmp r0,#0x0	; 02320CB8
	bne loc_02320CC0	; 02320CBA
	mov r1,#0x4	; 02320CBC
	b loc_02320CC6	; 02320CBE
loc_02320CC0:
	ldr r1,[sp,#0x20]	; 02320CC0
	b loc_02320CC6	; 02320CC2
loc_02320CC4:
	ldr r1,[sp,#0x20]	; 02320CC4
loc_02320CC6:
	ldr r0,[sp,#0x3c]	; 02320CC6
	ldrsh r0,[r5,r0]	; 02320CC8
	str r0,[sp,#0x0]	; 02320CCA
	str r6,[sp,#0x4]	; 02320CCC
	str r1,[sp,#0x8]	; 02320CCE
	str r4,[sp,#0xc]	; 02320CD0
	mov r0,#0x1	; 02320CD2
	str r0,[sp,#0x10]	; 02320CD4
	add r0,r7,#0x0	; 02320CD6
	ldr r1,[pool_02320DA4]	; 02320CD8
	ldr r2,[pool_02320DC4]	; 02320CDA
	mov r3,#0x5	; 02320CDC
	bl loc_0232396C	; 02320CDE
	b loc_02320D0E	; 02320CE2
loc_02320CE4:
	cmp r0,#0x3	; 02320CE4
	bne loc_02320D0E	; 02320CE6
	ldr r0,[pool_02320DAC]	; 02320CE8
	ldr r0,[r0,#0x58]	; 02320CEA
	cmp r0,#0x0	; 02320CEC
	bne loc_02320D0E	; 02320CEE
	ldr r0,[sp,#0x40]	; 02320CF0
	ldrsh r0,[r5,r0]	; 02320CF2
	str r0,[sp,#0x0]	; 02320CF4
	str r6,[sp,#0x4]	; 02320CF6
	ldr r0,[sp,#0x14]	; 02320CF8
	str r0,[sp,#0x8]	; 02320CFA
	str r4,[sp,#0xc]	; 02320CFC
	mov r0,#0x1	; 02320CFE
	str r0,[sp,#0x10]	; 02320D00
	add r0,r7,#0x0	; 02320D02
	ldr r1,[pool_02320DA4]	; 02320D04
	ldr r2,[pool_02320DC4]	; 02320D06
	mov r3,#0xd	; 02320D08
	bl loc_0232396C	; 02320D0A
loc_02320D0E:
	ldr r0,[sp,#0x44]	; 02320D0E
	ldrsh r0,[r5,r0]	; 02320D10
	str r0,[sp,#0x0]	; 02320D12
	str r6,[sp,#0x4]	; 02320D14
	ldr r0,[sp,#0x14]	; 02320D16
	str r0,[sp,#0x8]	; 02320D18
	str r4,[sp,#0xc]	; 02320D1A
	mov r0,#0x1	; 02320D1C
	str r0,[sp,#0x10]	; 02320D1E
	add r0,r7,#0x0	; 02320D20
	ldr r1,[pool_02320DA4]	; 02320D22
	ldr r2,[pool_02320DC4]	; 02320D24
	ldr r3,[r5,#0x4]	; 02320D26
	bl loc_0232396C	; 02320D28
	ldr r0,[sp,#0x24]	; 02320D2C
	add r0,r0,#0x1	; 02320D2E
	str r0,[sp,#0x24]	; 02320D30
	cmp r0,#0x5	; 02320D32
	bge loc_02320D38	; 02320D34
	b loc_02320BD2	; 02320D36
loc_02320D38:
	ldr r0,[pool_02320DB4]	; 02320D38
	ldr r4,[r0,#0x10]	; 02320D3A
	cmp r4,#0x30	; 02320D3C
	blt loc_02320D42	; 02320D3E
	mov r4,#0x30	; 02320D40
loc_02320D42:
	bl loc_02325694	; 02320D42
	mov r1,#0x0	; 02320D46
	str r1,[sp,#0x0]	; 02320D48
	str r4,[sp,#0x4]	; 02320D4A
	ldr r0,[r0,#0x0]	; 02320D4C
	lsl r0,r0,#0x16	; 02320D4E
	lsr r0,r0,#0x1f	; 02320D50
	lsl r1,r0,#0x2	; 02320D52
	ldr r0,[pool_02320DE0]	; 02320D54
	ldr r0,[r0,r1]	; 02320D56
	str r0,[sp,#0x8]	; 02320D58
	mov r0,#0x1	; 02320D5A
	str r0,[sp,#0xc]	; 02320D5C
	str r0,[sp,#0x10]	; 02320D5E
	add r0,r7,#0x0	; 02320D60
	ldr r1,[pool_02320DA4]	; 02320D62
	ldr r2,[pool_02320DC4]	; 02320D64
	mov r3,#0x8	; 02320D66
	bl loc_0232396C	; 02320D68
	mov r0,#0x0	; 02320D6C
	str r0,[sp,#0x0]	; 02320D6E
	str r4,[sp,#0x4]	; 02320D70
	ldr r0,[pool_02320DAC]	; 02320D72
	ldr r0,[r0,#0x68]	; 02320D74
	lsl r0,r0,#0x18	; 02320D76
	lsr r0,r0,#0x1f	; 02320D78
	lsl r1,r0,#0x2	; 02320D7A
	ldr r0,[pool_02320DE4]	; 02320D7C
	ldr r0,[r0,r1]	; 02320D7E
	str r0,[sp,#0x8]	; 02320D80
	mov r0,#0x1	; 02320D82
	str r0,[sp,#0xc]	; 02320D84
	str r0,[sp,#0x10]	; 02320D86
	add r0,r7,#0x0	; 02320D88
	ldr r1,[pool_02320DA4]	; 02320D8A
	ldr r2,[pool_02320DC4]	; 02320D8C
	mov r3,#0x7	; 02320D8E
	bl loc_0232396C	; 02320D90
loc_02320D94:
	add sp,#0x54	; 02320D94
	pop {r4,r5,r6,r7}	; 02320D96
	pop {r3}	; 02320D98
	bx r3	; 02320D9A
pool_02320D9C:
loc_02320D9C:
	.word P1_BssStart + 0xA80	; 02320D9C
pool_02320DA0:
loc_02320DA0:
	.word 0x02331958	; 02320DA0
pool_02320DA4:
loc_02320DA4:
	.word 0x023BB898	; 02320DA4
pool_02320DA8:
loc_02320DA8:
	.word 0x0239F7AC	; 02320DA8
pool_02320DAC:
loc_02320DAC:
	.word P1_BssStart + 0x1300	; 02320DAC
pool_02320DB0:
loc_02320DB0:
	.word 0x023CE1DC	; 02320DB0
pool_02320DB4:
loc_02320DB4:
	.word P1_BssStart + 0xB00	; 02320DB4
pool_02320DB8:
loc_02320DB8:
	.word 0x02331000	; 02320DB8
pool_02320DBC:
loc_02320DBC:
	.word 0x02330FC4	; 02320DBC
pool_02320DC0:
loc_02320DC0:
	.word 0x00001000	; 02320DC0
pool_02320DC4:
loc_02320DC4:
	.word 0x0239F704	; 02320DC4
pool_02320DC8:
loc_02320DC8:
	.word P1_Data_02330534	; 02320DC8
pool_02320DCC:
loc_02320DCC:
	.word 0x02330E80	; 02320DCC
pool_02320DD0:
loc_02320DD0:
	.word 0x02330FB4	; 02320DD0
pool_02320DD4:
loc_02320DD4:
	.word 0x000001FF	; 02320DD4
pool_02320DD8:
loc_02320DD8:
	.word 0x80000000	; 02320DD8
pool_02320DDC:
loc_02320DDC:
	.word 0x0000E7FC	; 02320DDC
pool_02320DE0:
loc_02320DE0:
	.word P1_Data_0233052C	; 02320DE0
pool_02320DE4:
loc_02320DE4:
	.word P1_Data_02330524	; 02320DE4

; ===== function loc_02320DE8 =====
loc_02320DE8:
	push {r4,r5,r6,r7,lr}	; 02320DE8
	sub sp,#0x12c	; 02320DEA
	bl loc_02324198	; 02320DEC
	bl loc_02324098	; 02320DF0
	mov r0,#0x0	; 02320DF4
	str r0,[sp,#0x8]	; 02320DF6
	ldr r0,[sp,#0x8]	; 02320DF8
	ldr r1,[pool_023211BC]	; 02320DFA
	ldr r2,[pool_023211C0]	; 02320DFC
	blx loc_0232E34C	; 02320DFE
	ldr r0,[pool_023211C4]	; 02320E02
	bl loc_02321D4C	; 02320E04
	mov r5,#0x0	; 02320E08
	ldr r4,[pool_023211BC]	; 02320E0A
	ldr r6,[pool_023211C8]	; 02320E0C
	mov r7,#0x3c	; 02320E0E
loc_02320E10:
	add r0,r5,#0x0	; 02320E10
	mul r0,r7	; 02320E12
	lsl r1,r5,#0x4	; 02320E14
	add r3,r6,r1	; 02320E16
	add r2,r4,r0	; 02320E18
	ldmia r3!,{r0,r1}	; 02320E1A
	stmia r2!,{r0,r1}	; 02320E1C
	ldmia r3!,{r0,r1}	; 02320E1E
	stmia r2!,{r0,r1}	; 02320E20
	add r5,r5,#0x1	; 02320E22
	cmp r5,#0x5	; 02320E24
	blt loc_02320E10	; 02320E26
	mov r1,#0x5	; 02320E28
	ldr r0,[pool_023211CC]	; 02320E2A
	str r1,[r0,#0x30]	; 02320E2C
	mov r0,#0x0	; 02320E2E
	mvn r1,r0	; 02320E30
	ldr r0,[pool_023211D0]	; 02320E32
	str r1,[r0,#0x4]	; 02320E34
	mov r0,#0x1f	; 02320E36
	ldr r1,[pool_023211D4]	; 02320E38
	str r0,[r1,#0x5c]	; 02320E3A
	str r0,[r1,#0x60]	; 02320E3C
	ldr r0,[pool_023211D8]	; 02320E3E
	ldrh r0,[r0,#0x0]	; 02320E40
	lsl r0,r0,#0x1d	; 02320E42
	lsr r0,r0,#0x1d	; 02320E44
	str r0,[r1,#0x58]	; 02320E46
	bl loc_02324D2C	; 02320E48
	add r0,sp,#0x14	; 02320E4C
	bl loc_023269A8	; 02320E4E
	ldr r1,[sp,#0x18]	; 02320E52
	ldr r2,[pool_023211DC]	; 02320E54
	ldrb r0,[r2,#0x0]	; 02320E56
	cmp r1,r0	; 02320E58
	bne loc_02320E68	; 02320E5A
	ldr r1,[sp,#0x1c]	; 02320E5C
	ldrb r0,[r2,#0x1]	; 02320E5E
	cmp r1,r0	; 02320E60
	bne loc_02320E68	; 02320E62
	mov r3,#0x1	; 02320E64
	b loc_02320E6A	; 02320E66
loc_02320E68:
	mov r3,#0x0	; 02320E68
loc_02320E6A:
	ldr r1,[pool_023211D4]	; 02320E6A
	ldr r2,[r1,#0x68]	; 02320E6C
	ldr r0,[pool_023211E0]	; 02320E6E
	and r2,r0	; 02320E70
	mov r0,#0x1	; 02320E72
	and r3,r0	; 02320E74
	lsl r0,r3,#0xa	; 02320E76
	orr r2,r0	; 02320E78
	str r2,[r1,#0x68]	; 02320E7A
	bl loc_0232D0E0	; 02320E7C
	ldr r2,[pool_023211E4]	; 02320E80
	ldr r1,[r2,#0x0]	; 02320E82
	ldr r0,[pool_023211E8]	; 02320E84
	and r1,r0	; 02320E86
	str r1,[r2,#0x0]	; 02320E88
	ldr r0,[pool_023211EC]	; 02320E8A
	bl loc_0232D448	; 02320E8C
	mov r0,#0x0	; 02320E90
	str r0,[sp,#0xc]	; 02320E92
	ldr r0,[sp,#0xc]	; 02320E94
	ldr r1,[pool_023211F0]	; 02320E96
	ldr r2,[pool_023211F4]	; 02320E98
	blx loc_0232E34C	; 02320E9A
	bl loc_0232D28C	; 02320E9E
	mov r0,#0xc0	; 02320EA2
	str r0,[sp,#0x4]	; 02320EA4
	ldr r0,[sp,#0x4]	; 02320EA6
	ldr r1,[pool_023211F8]	; 02320EA8
	ldr r2,[pool_023211FC]	; 02320EAA
	blx loc_0232E34C	; 02320EAC
	mov r0,#0x0	; 02320EB0
	str r0,[sp,#0x10]	; 02320EB2
	ldr r0,[sp,#0x10]	; 02320EB4
	ldr r1,[pool_02321200]	; 02320EB6
	ldr r2,[pool_023211FC]	; 02320EB8
	blx loc_0232E34C	; 02320EBA
	mov r0,#0x1	; 02320EBE
	bl loc_0232D530	; 02320EC0
	mov r0,#0x2	; 02320EC4
	bl loc_0232D45C	; 02320EC6
	mov r0,#0x1	; 02320ECA
	mov r1,#0x0	; 02320ECC
	add r2,r1,#0x0	; 02320ECE
	bl loc_0232D054	; 02320ED0
	ldr r2,[pool_02321204]	; 02320ED4
	ldrh r1,[r2,#0x0]	; 02320ED6
	mov r0,#0x43	; 02320ED8
	and r1,r0	; 02320EDA
	mov r0,#0x8	; 02320EDC
	orr r1,r0	; 02320EDE
	strh r1,[r2,#0x0]	; 02320EE0
	ldrh r1,[r2,#0x0]	; 02320EE2
	mov r0,#0x3	; 02320EE4
	bic r1,r0	; 02320EE6
	strh r1,[r2,#0x0]	; 02320EE8
	mov r1,#0x0	; 02320EEA
	ldr r0,[pool_02321208]	; 02320EEC
	str r1,[r0,#0x0]	; 02320EEE
	ldr r2,[pool_0232120C]	; 02320EF0
	ldr r3,[r2,#0x0]	; 02320EF2
	ldr r0,[pool_02321210]	; 02320EF4
	and r3,r0	; 02320EF6
	ldr r0,[pool_02321214]	; 02320EF8
	orr r3,r0	; 02320EFA
	str r3,[r2,#0x0]	; 02320EFC
	ldr r2,[pool_02321218]	; 02320EFE
	ldr r0,[pool_0232121C]	; 02320F00
	sub r6,r2,r0	; 02320F02
	add r2,r6,#0x0	; 02320F04
	bl loc_0232DD20	; 02320F06
	ldr r1,[pool_02321220]	; 02320F0A
	ldr r0,[pool_02321224]	; 02320F0C
	sub r7,r1,r0	; 02320F0E
	mov r1,#0x0	; 02320F10
	add r2,r7,#0x0	; 02320F12
	bl loc_0232E18C	; 02320F14
	ldr r0,[pool_02321228]	; 02320F18
	mov r1,#0x0	; 02320F1A
	ldr r2,[pool_0232122C]	; 02320F1C
	sub r2,r2,r0	; 02320F1E
	bl loc_0232DF20	; 02320F20
	ldr r0,[pool_02321230]	; 02320F24
	mov r1,#0x0	; 02320F26
	ldr r2,[pool_02321234]	; 02320F28
	sub r2,r2,r0	; 02320F2A
	bl loc_0232E114	; 02320F2C
	ldr r0,[pool_02321238]	; 02320F30
	mov r1,#0x0	; 02320F32
	mov r2,#0x2	; 02320F34
	bl loc_0232E18C	; 02320F36
	mov r0,#0x4	; 02320F3A
	bl loc_0232D3DC	; 02320F3C
	mov r0,#0x8	; 02320F40
	bl loc_0232D38C	; 02320F42
	mov r0,#0x0	; 02320F46
	bl loc_0232D040	; 02320F48
	ldr r4,[pool_0232123C]	; 02320F4C
	ldrh r2,[r4,#0x0]	; 02320F4E
	mov r1,#0x43	; 02320F50
	and r2,r1	; 02320F52
	ldr r0,[pool_02321240]	; 02320F54
	orr r2,r0	; 02320F56
	strh r2,[r4,#0x0]	; 02320F58
	ldrh r0,[r4,#0x0]	; 02320F5A
	mov r2,#0x3	; 02320F5C
	bic r0,r2	; 02320F5E
	strh r0,[r4,#0x0]	; 02320F60
	ldrh r0,[r4,#0x0]	; 02320F62
	mov r3,#0x40	; 02320F64
	bic r0,r3	; 02320F66
	strh r0,[r4,#0x0]	; 02320F68
	ldr r4,[pool_02321244]	; 02320F6A
	mov r0,#0x0	; 02320F6C
	str r0,[r4,#0x0]	; 02320F6E
	ldr r4,[pool_02321248]	; 02320F70
	ldrh r5,[r4,#0x0]	; 02320F72
	and r5,r1	; 02320F74
	ldr r0,[pool_0232124C]	; 02320F76
	orr r5,r0	; 02320F78
	strh r5,[r4,#0x0]	; 02320F7A
	ldrh r0,[r4,#0x0]	; 02320F7C
	bic r0,r2	; 02320F7E
	orr r0,r2	; 02320F80
	strh r0,[r4,#0x0]	; 02320F82
	ldrh r0,[r4,#0x0]	; 02320F84
	bic r0,r3	; 02320F86
	strh r0,[r4,#0x0]	; 02320F88
	ldr r4,[pool_02321250]	; 02320F8A
	ldr r0,[pool_02321254]	; 02320F8C
	str r4,[r0,#0x0]	; 02320F8E
	ldr r0,[pool_02321258]	; 02320F90
	ldrh r4,[r0,#0x0]	; 02320F92
	and r4,r1	; 02320F94
	ldr r1,[pool_0232125C]	; 02320F96
	orr r4,r1	; 02320F98
	strh r4,[r0,#0x0]	; 02320F9A
	ldrh r1,[r0,#0x0]	; 02320F9C
	bic r1,r2	; 02320F9E
	strh r1,[r0,#0x0]	; 02320FA0
	ldrh r1,[r0,#0x0]	; 02320FA2
	bic r1,r3	; 02320FA4
	strh r1,[r0,#0x0]	; 02320FA6
	ldr r1,[pool_02321260]	; 02320FA8
	mov r0,#0x0	; 02320FAA
	str r0,[r1,#0x0]	; 02320FAC
	ldr r2,[pool_0232120C]	; 02320FAE
	ldr r3,[r2,#0x0]	; 02320FB0
	ldr r0,[pool_02321264]	; 02320FB2
	and r3,r0	; 02320FB4
	ldr r1,[pool_02321268]	; 02320FB6
	orr r3,r1	; 02320FB8
	str r3,[r2,#0x0]	; 02320FBA
	ldr r2,[pool_023211E4]	; 02320FBC
	ldr r3,[r2,#0x0]	; 02320FBE
	and r3,r0	; 02320FC0
	orr r3,r1	; 02320FC2
	str r3,[r2,#0x0]	; 02320FC4
	ldr r0,[pool_0232121C]	; 02320FC6
	mov r1,#0x0	; 02320FC8
	add r2,r6,#0x0	; 02320FCA
	bl loc_0232DCE0	; 02320FCC
	mov r4,#0x0	; 02320FD0
	ldr r6,[pool_0232126C]	; 02320FD2
loc_02320FD4:
	lsl r5,r4,#0x6	; 02320FD4
	lsl r0,r4,#0x7	; 02320FD6
	add r0,r6,r0	; 02320FD8
	add r1,r5,#0x0	; 02320FDA
	mov r2,#0x40	; 02320FDC
	bl loc_0232DEE0	; 02320FDE
	lsl r0,r4,#0x1	; 02320FE2
	add r0,r0,#0x1	; 02320FE4
	lsl r0,r0,#0x6	; 02320FE6
	add r0,r6,r0	; 02320FE8
	ldr r1,[pool_02321270]	; 02320FEA
	add r1,r5,r1	; 02320FEC
	mov r2,#0x40	; 02320FEE
	bl loc_0232DEE0	; 02320FF0
	add r4,r4,#0x1	; 02320FF4
	cmp r4,#0x20	; 02320FF6
	blt loc_02320FD4	; 02320FF8
	bl loc_023251B0	; 02320FFA
	ldr r0,[pool_02321274]	; 02320FFE
	ldr r1,[pool_02321278]	; 02321000
	ldr r2,[pool_0232127C]	; 02321002
	sub r2,r2,r0	; 02321004
	blx loc_0232E334	; 02321006
	ldr r0,[pool_02321280]	; 0232100A
	ldr r1,[pool_02321284]	; 0232100C
	ldr r2,[pool_02321288]	; 0232100E
	sub r2,r2,r0	; 02321010
	blx loc_0232E334	; 02321012
	ldr r0,[pool_0232128C]	; 02321016
	ldr r1,[pool_02321290]	; 02321018
	ldr r2,[pool_02321294]	; 0232101A
	sub r2,r2,r0	; 0232101C
	blx loc_0232E334	; 0232101E
	ldr r0,[pool_02321298]	; 02321022
	ldr r1,[pool_0232129C]	; 02321024
	ldr r2,[pool_023212A0]	; 02321026
	sub r2,r2,r0	; 02321028
	blx loc_0232E334	; 0232102A
	bl loc_02323DB8	; 0232102E
	bl loc_02323F90	; 02321032
	bl loc_02323DB8	; 02321036
	ldr r1,[pool_023212A4]	; 0232103A
	bl loc_02323EFC	; 0232103C
	bl loc_02323DB8	; 02321040
	ldr r1,[pool_023212A8]	; 02321044
	bl loc_02323EFC	; 02321046
	bl loc_02323DC0	; 0232104A
	ldr r1,[pool_023212AC]	; 0232104E
	bl loc_02323EFC	; 02321050
	mov r0,#0x25	; 02321054
	mov r1,#0x29	; 02321056
	mov r2,#0x6	; 02321058
	bl loc_0232556C	; 0232105A
	bl loc_02325180	; 0232105E
	bl loc_02324BA8	; 02321062
	add r4,r0,#0x0	; 02321066
	ldr r0,[pool_023212A4]	; 02321068
	bl loc_02328D88	; 0232106A
	add r5,r0,#0x0	; 0232106E
	ldr r0,[pool_023212A8]	; 02321070
	bl loc_02328D88	; 02321072
	add r1,r0,#0x0	; 02321076
	add r0,r4,#0x0	; 02321078
	add r1,r5,r1	; 0232107A
	bl loc_02324B68	; 0232107C
	add r0,r4,#0x0	; 02321080
	bl loc_02325520	; 02321082
	add r0,r4,#0x0	; 02321086
	bl loc_02325130	; 02321088
	mov r5,#0x0	; 0232108C
	ldr r6,[pool_023211BC]	; 0232108E
loc_02321090:
	add r1,r5,#0x0	; 02321090
	mov r0,#0x3c	; 02321092
	mul r1,r0	; 02321094
	add r1,r6,r1	; 02321096
	ldr r3,[r1,#0x8]	; 02321098
	cmp r3,#0x0	; 0232109A
	blt loc_023210A8	; 0232109C
	add r0,r4,#0x0	; 0232109E
	add r1,#0x10	; 023210A0
	ldr r2,[pool_023212B0]	; 023210A2
	bl loc_02324B34	; 023210A4
loc_023210A8:
	add r5,r5,#0x1	; 023210A8
	cmp r5,#0x5	; 023210AA
	blt loc_02321090	; 023210AC
	ldr r0,[pool_023212B4]	; 023210AE
	ldr r1,[r0,#0x0]	; 023210B0
	mov r0,#0x2	; 023210B2
	and r1,r0	; 023210B4
	cmp r1,#0x0	; 023210B6
	beq loc_023210BE	; 023210B8
	mov r2,#0x1	; 023210BA
	b loc_023210C0	; 023210BC
loc_023210BE:
	mov r2,#0x0	; 023210BE
loc_023210C0:
	ldr r0,[pool_023211D4]	; 023210C0
	ldr r1,[r0,#0x68]	; 023210C2
	mov r3,#0x10	; 023210C4
	bic r1,r3	; 023210C6
	mov r3,#0x1	; 023210C8
	and r2,r3	; 023210CA
	lsl r2,r2,#0x4	; 023210CC
	orr r1,r2	; 023210CE
	str r1,[r0,#0x68]	; 023210D0
	lsl r0,r1,#0x1b	; 023210D2
	lsr r0,r0,#0x1f	; 023210D4
	cmp r0,#0x0	; 023210D6
	beq loc_02321106	; 023210D8
	add r0,sp,#0x24	; 023210DA
	ldr r1,[pool_023212B8]	; 023210DC
	bl loc_0232CDF4	; 023210DE
	ldr r0,[pool_023212BC]	; 023210E2
	bl loc_02326E5C	; 023210E4
	ldr r0,[pool_023212C0]	; 023210E8
	ldr r1,[pool_023212C4]	; 023210EA
	ldr r2,[pool_023212C8]	; 023210EC
	bl loc_0232DFE0	; 023210EE
	add r0,sp,#0x24	; 023210F2
	bl loc_023214C0	; 023210F4
	ldr r0,[pool_023211CC]	; 023210F8
	add r1,sp,#0x24	; 023210FA
	bl loc_02324A80	; 023210FC
	bl loc_02326490	; 02321100
	b loc_02321116	; 02321104
loc_02321106:
	ldr r0,[pool_023211CC]	; 02321106
	ldr r1,[pool_023212B0]	; 02321108
	mov r2,#0x2d	; 0232110A
	bl loc_02324ADC	; 0232110C
	mov r1,#0x4	; 02321110
	ldr r0,[pool_023211CC]	; 02321112
	strh r1,[r0,#0x16]	; 02321114
loc_02321116:
	ldr r0,[pool_023212B4]	; 02321116
	ldr r0,[r0,#0x0]	; 02321118
	mov r2,#0x1	; 0232111A
	and r0,r2	; 0232111C
	cmp r0,#0x0	; 0232111E
	bne loc_02321124	; 02321120
	mov r2,#0x0	; 02321122
loc_02321124:
	ldr r0,[pool_023211D4]	; 02321124
	ldr r1,[r0,#0x68]	; 02321126
	mov r3,#0x20	; 02321128
	bic r1,r3	; 0232112A
	mov r3,#0x1	; 0232112C
	and r2,r3	; 0232112E
	lsl r2,r2,#0x5	; 02321130
	orr r1,r2	; 02321132
	str r1,[r0,#0x68]	; 02321134
	lsl r0,r1,#0x1a	; 02321136
	lsr r0,r0,#0x1f	; 02321138
	cmp r0,#0x0	; 0232113A
	beq loc_0232114A	; 0232113C
	ldr r0,[pool_023212CC]	; 0232113E
	ldr r1,[pool_023212B0]	; 02321140
	mov r2,#0x2f	; 02321142
	bl loc_02324ADC	; 02321144
	b loc_02321184	; 02321148
loc_0232114A:
	bl loc_0232C240	; 0232114A
	ldr r1,[pool_023211D4]	; 0232114E
	ldr r2,[r1,#0x68]	; 02321150
	mov r3,#0x40	; 02321152
	bic r2,r3	; 02321154
	mov r3,#0x1	; 02321156
	and r0,r3	; 02321158
	lsl r0,r0,#0x6	; 0232115A
	orr r2,r0	; 0232115C
	str r2,[r1,#0x68]	; 0232115E
	lsl r0,r2,#0x19	; 02321160
	lsr r0,r0,#0x1f	; 02321162
	cmp r0,#0x0	; 02321164
	beq loc_02321174	; 02321166
	ldr r0,[pool_023212CC]	; 02321168
	ldr r1,[pool_023212B0]	; 0232116A
	mov r2,#0x31	; 0232116C
	bl loc_02324ADC	; 0232116E
	b loc_02321184	; 02321172
loc_02321174:
	ldr r0,[pool_023212CC]	; 02321174
	ldr r1,[pool_023212B0]	; 02321176
	mov r2,#0x30	; 02321178
	bl loc_02324ADC	; 0232117A
	mov r1,#0x4	; 0232117E
	ldr r0,[pool_023212D0]	; 02321180
	strh r1,[r0,#0x22]	; 02321182
loc_02321184:
	add r0,r4,#0x0	; 02321184
	ldr r1,[pool_023212D4]	; 02321186
	ldr r2,[pool_023212D8]	; 02321188
	mov r3,#0x61	; 0232118A
	bl loc_02324B34	; 0232118C
	bl loc_02325694	; 02321190
	ldr r0,[r0,#0x0]	; 02321194
	lsl r0,r0,#0x17	; 02321196
	lsr r0,r0,#0x1f	; 02321198
	cmp r0,#0x0	; 0232119A
	bne loc_023211A0	; 0232119C
	b loc_02321306	; 0232119E
loc_023211A0:
	ldr r1,[pool_023211D4]	; 023211A0
	ldr r2,[r1,#0x68]	; 023211A2
	ldr r0,[pool_023212C8]	; 023211A4
	orr r2,r0	; 023211A6
	str r2,[r1,#0x68]	; 023211A8
	ldr r1,[pool_023211E4]	; 023211AA
	ldr r2,[r1,#0x0]	; 023211AC
	ldr r0,[pool_02321210]	; 023211AE
	and r2,r0	; 023211B0
	ldr r0,[pool_02321214]	; 023211B2
	orr r2,r0	; 023211B4
	str r2,[r1,#0x0]	; 023211B6
	ldr r0,[pool_023212DC]	; 023211B8
	b loc_023212E0	; 023211BA
pool_023211BC:
loc_023211BC:
	.word 0x02330E80	; 023211BC
pool_023211C0:
loc_023211C0:
	.word 0x0000136C	; 023211C0
pool_023211C4:
loc_023211C4:
	.word 0x02330FB4	; 023211C4
pool_023211C8:
loc_023211C8:
	.word 0x0233059C	; 023211C8
pool_023211CC:
loc_023211CC:
	.word P1_BssStart + 0x100	; 023211CC
pool_023211D0:
loc_023211D0:
	.word P1_BssStart + 0xB00	; 023211D0
pool_023211D4:
loc_023211D4:
	.word P1_BssStart + 0x1300	; 023211D4
pool_023211D8:
loc_023211D8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023211D8
pool_023211DC:
loc_023211DC:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 023211DC
pool_023211E0:
loc_023211E0:
	.word 0xFFFFFBFF	; 023211E0
pool_023211E4:
loc_023211E4:
	.word REG_DISPCNT_B	; 023211E4
pool_023211E8:
loc_023211E8:
	.word 0xFFFEFFFF	; 023211E8
pool_023211EC:
loc_023211EC:
	.word 0x000001FF	; 023211EC
pool_023211F0:
loc_023211F0:
	.word 0x06800000	; 023211F0
pool_023211F4:
loc_023211F4:
	.word 0x000A4000	; 023211F4
pool_023211F8:
loc_023211F8:
	.word 0x07000400	; 023211F8
pool_023211FC:
loc_023211FC:
	.word 0x00000400	; 023211FC
pool_02321200:
loc_02321200:
	.word 0x05000400	; 02321200
pool_02321204:
loc_02321204:
	.word REG_BG1CNT	; 02321204
pool_02321208:
loc_02321208:
	.word REG_BG1HOFS	; 02321208
pool_0232120C:
loc_0232120C:
	.word REG_DISPCNT_A	; 0232120C
pool_02321210:
loc_02321210:
	.word 0xFFFFE0FF	; 02321210
pool_02321214:
loc_02321214:
	.word 0x00001000	; 02321214
pool_02321218:
loc_02321218:
	.word 0x023AA960	; 02321218
pool_0232121C:
loc_0232121C:
	.word 0x023A8D60	; 0232121C
pool_02321220:
loc_02321220:
	.word 0x023B66E0	; 02321220
pool_02321224:
loc_02321224:
	.word 0x023B64E0	; 02321224
pool_02321228:
loc_02321228:
	.word 0x023B24E0	; 02321228
pool_0232122C:
loc_0232122C:
	.word 0x023B2CE0	; 0232122C
pool_02321230:
loc_02321230:
	.word 0x023B74E0	; 02321230
pool_02321234:
loc_02321234:
	.word 0x023B76E0	; 02321234
pool_02321238:
loc_02321238:
	.word 0x023306CC	; 02321238
pool_0232123C:
loc_0232123C:
	.word REG_BG0CNT_SUB	; 0232123C
pool_02321240:
loc_02321240:
	.word 0x00001018	; 02321240
pool_02321244:
loc_02321244:
	.word REG_BG0HOFS_SUB	; 02321244
pool_02321248:
loc_02321248:
	.word REG_BG1CNT_SUB	; 02321248
pool_0232124C:
loc_0232124C:
	.word 0x00004110	; 0232124C
pool_02321250:
loc_02321250:
	.word 0x00190011	; 02321250
pool_02321254:
loc_02321254:
	.word REG_BG1HOFS_SUB	; 02321254
pool_02321258:
loc_02321258:
	.word REG_BG3CNT_SUB	; 02321258
pool_0232125C:
loc_0232125C:
	.word 0x00000810	; 0232125C
pool_02321260:
loc_02321260:
	.word REG_BG3HOFS_SUB	; 02321260
pool_02321264:
loc_02321264:
	.word 0xFFCFFFEF	; 02321264
pool_02321268:
loc_02321268:
	.word 0x00200010	; 02321268
pool_0232126C:
loc_0232126C:
	.word 0x023B4CE0	; 0232126C
pool_02321270:
loc_02321270:
	.word 0x00000800	; 02321270
pool_02321274:
loc_02321274:
	.word 0x023B14E0	; 02321274
pool_02321278:
loc_02321278:
	.word 0x06200000	; 02321278
pool_0232127C:
loc_0232127C:
	.word 0x023B1CE0	; 0232127C
pool_02321280:
loc_02321280:
	.word 0x023B44E0	; 02321280
pool_02321284:
loc_02321284:
	.word 0x06203000	; 02321284
pool_02321288:
loc_02321288:
	.word 0x023B4CE0	; 02321288
pool_0232128C:
loc_0232128C:
	.word 0x023B3CE0	; 0232128C
pool_02321290:
loc_02321290:
	.word 0x06203800	; 02321290
pool_02321294:
loc_02321294:
	.word 0x023B44E0	; 02321294
pool_02321298:
loc_02321298:
	.word 0x023B1CE0	; 02321298
pool_0232129C:
loc_0232129C:
	.word 0x06204800	; 0232129C
pool_023212A0:
loc_023212A0:
	.word 0x023B24E0	; 023212A0
pool_023212A4:
loc_023212A4:
	.word 0x023BB898	; 023212A4
pool_023212A8:
loc_023212A8:
	.word 0x023CE1DC	; 023212A8
pool_023212AC:
loc_023212AC:
	.word 0x023CE330	; 023212AC
pool_023212B0:
loc_023212B0:
	.word 0x023A020C	; 023212B0
pool_023212B4:
loc_023212B4:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023212B4
pool_023212B8:
loc_023212B8:
	.word 0x00000102	; 023212B8
pool_023212BC:
loc_023212BC:
	.word 0x02331998	; 023212BC
pool_023212C0:
loc_023212C0:
	.word 0x023319B8	; 023212C0
pool_023212C4:
loc_023212C4:
	.word 0x0001FE00	; 023212C4
pool_023212C8:
loc_023212C8:
	.word 0x00000200	; 023212C8
pool_023212CC:
loc_023212CC:
	.word 0x02330ECC	; 023212CC
pool_023212D0:
loc_023212D0:
	.word P1_BssStart + 0x40	; 023212D0
pool_023212D4:
loc_023212D4:
	.word 0x02331958	; 023212D4
pool_023212D8:
loc_023212D8:
	.word 0x023A02E4	; 023212D8
pool_023212DC:
loc_023212DC:
	.word 0x023B6CE0	; 023212DC
loc_023212E0:
	mov r1,#0x0	; 023212E0
	ldr r2,[pool_02321408]	; 023212E2
	sub r2,r2,r0	; 023212E4
	bl loc_0232E0D8	; 023212E6
	ldr r0,[pool_0232140C]	; 023212EA
	mov r1,#0x0	; 023212EC
	add r2,r7,#0x0	; 023212EE
	bl loc_0232E150	; 023212F0
	ldr r0,[pool_02321410]	; 023212F4
	mov r1,#0x0	; 023212F6
	mov r2,#0x2	; 023212F8
	bl loc_0232E150	; 023212FA
	mov r1,#0x1	; 023212FE
	ldr r0,[pool_02321414]	; 02321300
	str r1,[r0,#0x2c]	; 02321302
	b loc_023213C0	; 02321304
loc_02321306:
	mov r0,#0x0	; 02321306
	ldr r1,[pool_02321418]	; 02321308
	ldr r1,[r1,#0x58]	; 0232130A
	cmp r1,#0x5	; 0232130C
	bhi loc_02321364	; 0232130E
	add r1,r1,r1	; 02321310
P1_SwitchIndexPC_02321310:
	add r1,pc	; 02321312
	ldrh r1,[r1,#(P1_SwitchTable_02321310 - (P1_SwitchIndexPC_02321310 + 4))]	; 02321314
	lsl r1,r1,#0x10	; 02321316
	asr r1,r1,#0x10	; 02321318
P1_SwitchTargetPC_02321310:
	add r1,pc	; 0232131A
	bx r1	; 0232131C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02321310:
	.halfword (loc_0232132A + 1) - (P1_SwitchTargetPC_02321310 + 4)
	.halfword (loc_02321334 + 1) - (P1_SwitchTargetPC_02321310 + 4)
	.halfword (loc_0232133E + 1) - (P1_SwitchTargetPC_02321310 + 4)
	.halfword (loc_02321348 + 1) - (P1_SwitchTargetPC_02321310 + 4)
	.halfword (loc_02321352 + 1) - (P1_SwitchTargetPC_02321310 + 4)
	.halfword (loc_0232135C + 1) - (P1_SwitchTargetPC_02321310 + 4)
P1_SwitchTable_02321310End:
loc_0232132A:
	ldr r0,[pool_0232141C]	; 0232132A
	ldr r2,[pool_02321420]	; 0232132C
	ldr r1,[pool_02321424]	; 0232132E
	str r2,[r1,#0x14]	; 02321330
	b loc_02321364	; 02321332
loc_02321334:
	ldr r0,[pool_02321428]	; 02321334
	ldr r2,[pool_0232142C]	; 02321336
	ldr r1,[pool_02321424]	; 02321338
	str r2,[r1,#0x14]	; 0232133A
	b loc_02321364	; 0232133C
loc_0232133E:
	ldr r0,[pool_02321430]	; 0232133E
	ldr r2,[pool_02321434]	; 02321340
	ldr r1,[pool_02321424]	; 02321342
	str r2,[r1,#0x14]	; 02321344
	b loc_02321364	; 02321346
loc_02321348:
	ldr r0,[pool_02321438]	; 02321348
	ldr r2,[pool_0232143C]	; 0232134A
	ldr r1,[pool_02321424]	; 0232134C
	str r2,[r1,#0x14]	; 0232134E
	b loc_02321364	; 02321350
loc_02321352:
	ldr r0,[pool_02321440]	; 02321352
	ldr r2,[pool_02321444]	; 02321354
	ldr r1,[pool_02321424]	; 02321356
	str r2,[r1,#0x14]	; 02321358
	b loc_02321364	; 0232135A
loc_0232135C:
	ldr r0,[pool_02321448]	; 0232135C
	ldr r2,[pool_0232144C]	; 0232135E
	ldr r1,[pool_02321424]	; 02321360
	str r2,[r1,#0x14]	; 02321362
loc_02321364:
	mov r1,#0x1	; 02321364
	bl loc_023255EC	; 02321366
	ldr r1,[pool_02321418]	; 0232136A
	ldr r2,[r1,#0x68]	; 0232136C
	mov r0,#0x1	; 0232136E
	bic r2,r0	; 02321370
	orr r2,r0	; 02321372
	str r2,[r1,#0x68]	; 02321374
	ldr r0,[pool_02321450]	; 02321376
	orr r2,r0	; 02321378
	str r2,[r1,#0x68]	; 0232137A
	mov r1,#0x0	; 0232137C
	ldr r0,[pool_02321414]	; 0232137E
	str r1,[r0,#0x2c]	; 02321380
	ldr r2,[pool_02321454]	; 02321382
	ldr r0,[pool_02321458]	; 02321384
	sub r4,r2,r0	; 02321386
	add r2,r4,#0x0	; 02321388
	bl loc_0232E0D8	; 0232138A
	ldr r0,[pool_02321458]	; 0232138E
	mov r1,#0x0	; 02321390
	add r2,r4,#0x0	; 02321392
	bl loc_0232E150	; 02321394
	ldr r0,[pool_0232145C]	; 02321398
	mov r1,#0x0	; 0232139A
	mov r2,#0x2	; 0232139C
	bl loc_0232E150	; 0232139E
	ldr r1,[pool_02321460]	; 023213A2
	ldr r2,[r1,#0x0]	; 023213A4
	ldr r0,[pool_02321464]	; 023213A6
	and r2,r0	; 023213A8
	ldr r0,[pool_02321468]	; 023213AA
	orr r2,r0	; 023213AC
	str r2,[r1,#0x0]	; 023213AE
	mov r0,#0x10	; 023213B0
	str r0,[sp,#0x0]	; 023213B2
	ldr r0,[pool_0232146C]	; 023213B4
	mov r1,#0x1	; 023213B6
	mov r2,#0x20	; 023213B8
	mov r3,#0x0	; 023213BA
	bl loc_0232DBC0	; 023213BC
loc_023213C0:
	ldr r0,[pool_02321470]	; 023213C0
	bl loc_0232186C	; 023213C2
	ldr r0,[pool_02321474]	; 023213C6
	bl loc_02321974	; 023213C8
	ldr r0,[pool_02321478]	; 023213CC
	mov r1,#0x12	; 023213CE
	mov r2,#0x8	; 023213D0
	bl loc_02325FDC	; 023213D2
	ldr r0,[pool_0232147C]	; 023213D6
	bl loc_02326544	; 023213D8
	mov r0,#0x1	; 023213DC
	ldr r1,[pool_02321480]	; 023213DE
	bl loc_0232ADD0	; 023213E0
	mov r0,#0x1	; 023213E4
	bl loc_0232AD4C	; 023213E6
	mov r0,#0x1	; 023213EA
	bl loc_0232D114	; 023213EC
	bl loc_0232D0A0	; 023213F0
	ldr r2,[pool_02321460]	; 023213F4
	ldr r1,[r2,#0x0]	; 023213F6
	ldr r0,[pool_02321484]	; 023213F8
	orr r1,r0	; 023213FA
	str r1,[r2,#0x0]	; 023213FC
	add sp,#0x12c	; 023213FE
	pop {r4,r5,r6,r7}	; 02321400
	pop {r3}	; 02321402
	bx r3	; 02321404
	.byte 0xC0, 0x46	; 02321408
pool_02321408:
loc_02321408:
	.word 0x023B6EE0	; 02321408
pool_0232140C:
loc_0232140C:
	.word 0x023B64E0	; 0232140C
pool_02321410:
loc_02321410:
	.word 0x023306D0	; 02321410
pool_02321414:
loc_02321414:
	.word P1_BssStart + 0x100	; 02321414
pool_02321418:
loc_02321418:
	.word P1_BssStart + 0x1300	; 02321418
pool_0232141C:
loc_0232141C:
	.word 0x023A153C	; 0232141C
pool_02321420:
loc_02321420:
	.word 0x023A010C	; 02321420
pool_02321424:
loc_02321424:
	.word P1_BssStart + 0xB00	; 02321424
pool_02321428:
loc_02321428:
	.word 0x023A1B3C	; 02321428
pool_0232142C:
loc_0232142C:
	.word 0x023A012C	; 0232142C
pool_02321430:
loc_02321430:
	.word 0x023A0C3C	; 02321430
pool_02321434:
loc_02321434:
	.word 0x023A00DC	; 02321434
pool_02321438:
loc_02321438:
	.word 0x023A0F08	; 02321438
pool_0232143C:
loc_0232143C:
	.word 0x023A00EC	; 0232143C
pool_02321440:
loc_02321440:
	.word 0x023A121C	; 02321440
pool_02321444:
loc_02321444:
	.word 0x023A00FC	; 02321444
pool_02321448:
loc_02321448:
	.word 0x023A1824	; 02321448
pool_0232144C:
loc_0232144C:
	.word 0x023A011C	; 0232144C
pool_02321450:
loc_02321450:
	.word 0x00000200	; 02321450
pool_02321454:
loc_02321454:
	.word 0x023B74E0	; 02321454
pool_02321458:
loc_02321458:
	.word 0x023B72E0	; 02321458
pool_0232145C:
loc_0232145C:
	.word 0x023306D4	; 0232145C
pool_02321460:
loc_02321460:
	.word REG_DISPCNT_B	; 02321460
pool_02321464:
loc_02321464:
	.word 0xFFFFE0FF	; 02321464
pool_02321468:
loc_02321468:
	.word 0x00001100	; 02321468
pool_0232146C:
loc_0232146C:
	.word REG_BLDCNT_SUB	; 0232146C
pool_02321470:
loc_02321470:
	.word 0x02330E80	; 02321470
pool_02321474:
loc_02321474:
	.word 0x02331000	; 02321474
pool_02321478:
loc_02321478:
	.word 0x0233191C	; 02321478
pool_0232147C:
loc_0232147C:
	.word 0x0232154D	; 0232147C
pool_02321480:
loc_02321480:
	.word P1_IrqHandler_02321594 + 1	; 02321480
pool_02321484:
loc_02321484:
	.word 0x00010000	; 02321484

; ===== function loc_02321488 =====
loc_02321488:
	push {lr}	; 02321488
	sub sp,#0x4	; 0232148A
	bl loc_02325694	; 0232148C
	ldr r0,[r0,#0x0]	; 02321490
	lsl r0,r0,#0x17	; 02321492
	lsr r0,r0,#0x1f	; 02321494
	cmp r0,#0x0	; 02321496
	bne loc_023214AE	; 02321498
	ldr r0,[pool_023214BC]	; 0232149A
	ldr r0,[r0,#0x68]	; 0232149C
	lsl r0,r0,#0x15	; 0232149E
	lsr r0,r0,#0x1f	; 023214A0
	cmp r0,#0x0	; 023214A2
	beq loc_023214AE	; 023214A4
	mov r0,#0x2	; 023214A6
	bl loc_0232365C	; 023214A8
	b loc_023214B4	; 023214AC
loc_023214AE:
	mov r0,#0x1	; 023214AE
	bl loc_0232365C	; 023214B0
loc_023214B4:
	add sp,#0x4	; 023214B4
	pop {r3}	; 023214B6
	bx r3	; 023214B8
	.byte 0xC0, 0x46	; 023214BC
pool_023214BC:
loc_023214BC:
	.word P1_BssStart + 0x1300	; 023214BC

; ===== function loc_023214C0 =====
loc_023214C0:
	push {r4,r5,r6,r7,lr}	; 023214C0
	sub sp,#0x4	; 023214C2
	ldr r1,[pool_0232152C]	; 023214C4
	ldr r4,[r1,#0x58]	; 023214C6
	ldr r3,[pool_02321530]	; 023214C8
	lsl r1,r4,#0x8	; 023214CA
	add r2,r3,r1	; 023214CC
	ldr r1,[pool_02321534]	; 023214CE
	ldrh r1,[r2,r1]	; 023214D0
	cmp r1,#0x0	; 023214D2
	bne loc_02321506	; 023214D4
	cmp r4,#0x0	; 023214D6
	bne loc_023214DE	; 023214D8
	ldr r2,[pool_02321538]	; 023214DA
	b loc_023214E8	; 023214DC
loc_023214DE:
	cmp r4,#0x1	; 023214DE
	bne loc_023214E6	; 023214E0
	ldr r2,[pool_0232153C]	; 023214E2
	b loc_023214E8	; 023214E4
loc_023214E6:
	ldr r2,[pool_02321540]	; 023214E6
loc_023214E8:
	mov r5,#0x0	; 023214E8
	ldr r6,[pool_02321534]	; 023214EA
	b loc_02321502	; 023214EC
loc_023214EE:
	lsl r1,r5,#0x1	; 023214EE
	ldrsh r1,[r2,r1]	; 023214F0
	lsl r7,r1,#0x8	; 023214F2
	add r7,r3,r7	; 023214F4
	ldrh r7,[r7,r6]	; 023214F6
	cmp r7,#0x0	; 023214F8
	beq loc_02321500	; 023214FA
	add r4,r1,#0x0	; 023214FC
	b loc_02321506	; 023214FE
loc_02321500:
	add r5,r5,#0x1	; 02321500
loc_02321502:
	cmp r5,#0x6	; 02321502
	blt loc_023214EE	; 02321504
loc_02321506:
	mov r1,#0x0	; 02321506
	ldr r3,[pool_02321544]	; 02321508
	lsl r2,r4,#0x8	; 0232150A
	add r5,r3,r2	; 0232150C
	ldr r2,[pool_02321548]	; 0232150E
loc_02321510:
	lsl r4,r1,#0x1	; 02321510
	add r3,r5,r4	; 02321512
	ldrh r3,[r3,r2]	; 02321514
	strh r3,[r0,r4]	; 02321516
	add r1,r1,#0x1	; 02321518
	cmp r1,#0x80	; 0232151A
	blt loc_02321510	; 0232151C
	mov r2,#0x0	; 0232151E
	lsl r1,r1,#0x1	; 02321520
	strh r2,[r0,r1]	; 02321522
	add sp,#0x4	; 02321524
	pop {r4,r5,r6,r7}	; 02321526
	pop {r3}	; 02321528
	bx r3	; 0232152A
pool_0232152C:
loc_0232152C:
	.word P1_BssStart + 0x1300	; 0232152C
pool_02321530:
loc_02321530:
	.word 0x023319B8	; 02321530
pool_02321534:
loc_02321534:
	.word 0x00000220	; 02321534
pool_02321538:
loc_02321538:
	.word 0x02330540	; 02321538
pool_0232153C:
loc_0232153C:
	.word 0x02330558	; 0232153C
pool_02321540:
loc_02321540:
	.word 0x0233054C	; 02321540
pool_02321544:
loc_02321544:
	.word 0x02330E80	; 02321544
pool_02321548:
loc_02321548:
	.word 0x00000D58	; 02321548

; ===== function loc_0232154C =====
	push {lr}	; 0232154C
	sub sp,#0x4	; 0232154E
	mov r1,#0x0	; 02321550
	ldr r0,[pool_0232158C]	; 02321552
	str r1,[r0,#0x20]	; 02321554
	bl loc_02325694	; 02321556
	ldr r0,[r0,#0x0]	; 0232155A
	lsl r0,r0,#0x16	; 0232155C
	lsr r0,r0,#0x1f	; 0232155E
	cmp r0,#0x0	; 02321560
	beq loc_02321586	; 02321562
	bl loc_02325694	; 02321564
	ldr r0,[r0,#0x0]	; 02321568
	lsl r0,r0,#0x15	; 0232156A
	lsr r0,r0,#0x1f	; 0232156C
	cmp r0,#0x0	; 0232156E
	bne loc_0232157A	; 02321570
	mov r0,#0x2	; 02321572
	mov r1,#0x1	; 02321574
	bl loc_0232F760	; 02321576
loc_0232157A:
	bl loc_02325694	; 0232157A
	ldr r2,[r0,#0x0]	; 0232157E
	ldr r1,[pool_02321590]	; 02321580
	orr r2,r1	; 02321582
	str r2,[r0,#0x0]	; 02321584
loc_02321586:
	add sp,#0x4	; 02321586
	pop {r3}	; 02321588
	bx r3	; 0232158A
pool_0232158C:
loc_0232158C:
	.word P1_BssStart + 0xA80	; 0232158C
pool_02321590:
loc_02321590:
	.word 0x00000400	; 02321590

; ===== function loc_02321594 =====
P1_IrqHandler_02321594:
	push {r4,lr}	; 02321594
	ldr r1,[pool_0232166C]	; 02321596
	ldr r0,[pool_02321670]	; 02321598
	add r2,r1,r0	; 0232159A
	ldr r1,[r2,#0x0]	; 0232159C
	mov r0,#0x1	; 0232159E
	orr r1,r0	; 023215A0
	str r1,[r2,#0x0]	; 023215A2
	ldr r0,[pool_02321674]	; 023215A4
	ldr r0,[r0,#0x68]	; 023215A6
	lsl r0,r0,#0x1c	; 023215A8
	lsr r0,r0,#0x1f	; 023215AA
	cmp r0,#0x0	; 023215AC
	beq loc_02321608	; 023215AE
	ldr r0,[pool_02321678]	; 023215B0
	ldrb r0,[r0,#0x0]	; 023215B2
	lsl r0,r0,#0x1c	; 023215B4
	lsr r4,r0,#0x1c	; 023215B6
	ldr r0,[pool_0232167C]	; 023215B8
	mov r1,#0x0	; 023215BA
	ldr r2,[pool_02321680]	; 023215BC
	sub r2,r2,r0	; 023215BE
	bl loc_0232E0D8	; 023215C0
	ldr r0,[pool_02321684]	; 023215C4
	ldr r1,[pool_02321688]	; 023215C6
	mov r2,#0x20	; 023215C8
	bl loc_0232E0D8	; 023215CA
	ldr r0,[pool_0232168C]	; 023215CE
	mov r1,#0x0	; 023215D0
	ldr r2,[pool_02321690]	; 023215D2
	sub r2,r2,r0	; 023215D4
	bl loc_0232E150	; 023215D6
	ldr r0,[pool_02321694]	; 023215DA
	mov r1,#0x0	; 023215DC
	mov r2,#0x2	; 023215DE
	bl loc_0232E150	; 023215E0
	ldr r1,[pool_02321698]	; 023215E4
	lsl r0,r4,#0x5	; 023215E6
	add r4,r1,r0	; 023215E8
	add r0,r4,#0x0	; 023215EA
	ldr r1,[pool_0232169C]	; 023215EC
	mov r2,#0x20	; 023215EE
	bl loc_0232E150	; 023215F0
	add r0,r4,#0x0	; 023215F4
	ldr r1,[pool_0232169C]	; 023215F6
	mov r2,#0x20	; 023215F8
	bl loc_0232E0D8	; 023215FA
	ldr r1,[pool_02321674]	; 023215FE
	ldr r2,[r1,#0x68]	; 02321600
	mov r0,#0x8	; 02321602
	bic r2,r0	; 02321604
	str r2,[r1,#0x68]	; 02321606
loc_02321608:
	ldr r2,[pool_02321674]	; 02321608
	ldr r0,[r2,#0x68]	; 0232160A
	lsl r0,r0,#0x1f	; 0232160C
	lsr r0,r0,#0x1f	; 0232160E
	cmp r0,#0x0	; 02321610
	beq loc_0232164A	; 02321612
	ldr r0,[r2,#0x60]	; 02321614
	ldr r4,[r2,#0x5c]	; 02321616
	lsl r3,r4,#0xa	; 02321618
	lsl r1,r4,#0x5	; 0232161A
	orr r4,r1	; 0232161C
	orr r3,r4	; 0232161E
	lsl r1,r3,#0x10	; 02321620
	lsr r1,r1,#0x10	; 02321622
	lsl r4,r1,#0x10	; 02321624
	lsl r3,r0,#0xa	; 02321626
	lsl r1,r0,#0x5	; 02321628
	orr r0,r1	; 0232162A
	orr r3,r0	; 0232162C
	lsl r0,r3,#0x10	; 0232162E
	lsr r0,r0,#0x10	; 02321630
	orr r4,r0	; 02321632
	str r4,[r2,#0x64]	; 02321634
	ldr r4,[pool_023216A0]	; 02321636
	add r0,r4,#0x0	; 02321638
	mov r1,#0x4	; 0232163A
	blx P1_CleanDataCacheRange	; 0232163C
	add r0,r4,#0x0	; 02321640
	mov r1,#0xe	; 02321642
	mov r2,#0x4	; 02321644
	bl loc_0232E150	; 02321646
loc_0232164A:
	ldr r0,[pool_02321674]	; 0232164A
	ldr r0,[r0,#0x68]	; 0232164C
	lsl r1,r0,#0x1d	; 0232164E
	lsr r1,r1,#0x1f	; 02321650
	cmp r1,#0x0	; 02321652
	beq loc_02321662	; 02321654
	lsl r0,r0,#0x14	; 02321656
	lsr r0,r0,#0x1f	; 02321658
	cmp r0,#0x0	; 0232165A
	bne loc_02321662	; 0232165C
	bl loc_023228FC	; 0232165E
loc_02321662:
	bl loc_02323DC8	; 02321662
	pop {r4}	; 02321666
	pop {r3}	; 02321668
	bx r3	; 0232166A
pool_0232166C:
loc_0232166C:
	.word 0x03000000	; 0232166C
pool_02321670:
loc_02321670:
	.word 0x00003FF8	; 02321670
pool_02321674:
loc_02321674:
	.word P1_BssStart + 0x1300	; 02321674
pool_02321678:
loc_02321678:
	.word FirmwareUserSettingsSharedAddress + UserSettingsThemeOffset	; 02321678
pool_0232167C:
loc_0232167C:
	.word 0x023B6CE0	; 0232167C
pool_02321680:
loc_02321680:
	.word 0x023B6EE0	; 02321680
pool_02321684:
loc_02321684:
	.word 0x02331BB8	; 02321684
pool_02321688:
loc_02321688:
	.word 0x000001C0	; 02321688
pool_0232168C:
loc_0232168C:
	.word 0x023B64E0	; 0232168C
pool_02321690:
loc_02321690:
	.word 0x023B66E0	; 02321690
pool_02321694:
loc_02321694:
	.word 0x023306D8	; 02321694
pool_02321698:
loc_02321698:
	.word 0x023B70E0	; 02321698
pool_0232169C:
loc_0232169C:
	.word 0x000001E0	; 0232169C
pool_023216A0:
loc_023216A0:
	.word 0x023321E4	; 023216A0

; ===== function loc_023216A4 =====
loc_023216A4:
	push {r4,r5,r6,r7,lr}	; 023216A4
	sub sp,#0xc	; 023216A6
	add r7,r0,#0x0	; 023216A8
	ldr r0,[pool_0232185C]	; 023216AA
	add r4,r7,r0	; 023216AC
	ldr r5,[r4,#0x30]	; 023216AE
	mov r0,#0x40	; 023216B0
	bl loc_02324088	; 023216B2
	str r0,[sp,#0x8]	; 023216B6
	mov r0,#0x80	; 023216B8
	bl loc_02324088	; 023216BA
	str r0,[sp,#0x0]	; 023216BE
	mov r0,#0x20	; 023216C0
	bl loc_02324088	; 023216C2
	add r6,r0,#0x0	; 023216C6
	mov r0,#0x10	; 023216C8
	bl loc_02324088	; 023216CA
	cmp r5,#0x6	; 023216CE
	bls loc_023216D4	; 023216D0
	b loc_023217FA	; 023216D2
loc_023216D4:
	add r1,r5,r5	; 023216D4
P1_SwitchIndexPC_023216D4:
	add r1,pc	; 023216D6
	ldrh r1,[r1,#(P1_SwitchTable_023216D4 - (P1_SwitchIndexPC_023216D4 + 4))]	; 023216D8
	lsl r1,r1,#0x10	; 023216DA
	asr r1,r1,#0x10	; 023216DC
P1_SwitchTargetPC_023216D4:
	add r1,pc	; 023216DE
	bx r1	; 023216E0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023216D4:
	.halfword (loc_023217AA + 1) - (P1_SwitchTargetPC_023216D4 + 4)
	.halfword (loc_02321772 + 1) - (P1_SwitchTargetPC_023216D4 + 4)
	.halfword (loc_0232171C + 1) - (P1_SwitchTargetPC_023216D4 + 4)
	.halfword (loc_0232171C + 1) - (P1_SwitchTargetPC_023216D4 + 4)
	.halfword (loc_023216F0 + 1) - (P1_SwitchTargetPC_023216D4 + 4)
	.halfword (loc_023217E8 + 1) - (P1_SwitchTargetPC_023216D4 + 4)
	.halfword (loc_023217F2 + 1) - (P1_SwitchTargetPC_023216D4 + 4)
P1_SwitchTable_023216D4End:
loc_023216F0:
	ldr r1,[sp,#0x0]	; 023216F0
	cmp r1,#0x0	; 023216F2
	beq loc_02321708	; 023216F4
	ldr r0,[r4,#0x34]	; 023216F6
	cmp r0,#0x3	; 023216F8
	bne loc_02321702	; 023216FA
	mov r0,#0x3	; 023216FC
	str r0,[r4,#0x30]	; 023216FE
	b loc_023217FA	; 02321700
loc_02321702:
	mov r0,#0x2	; 02321702
	str r0,[r4,#0x30]	; 02321704
	b loc_023217FA	; 02321706
loc_02321708:
	cmp r6,#0x0	; 02321708
	beq loc_02321712	; 0232170A
	mov r0,#0x3	; 0232170C
	str r0,[r4,#0x34]	; 0232170E
	b loc_023217FA	; 02321710
loc_02321712:
	cmp r0,#0x0	; 02321712
	beq loc_023217FA	; 02321714
	mov r0,#0x2	; 02321716
	str r0,[r4,#0x34]	; 02321718
	b loc_023217FA	; 0232171A
loc_0232171C:
	ldr r1,[sp,#0x8]	; 0232171C
	cmp r1,#0x0	; 0232171E
	beq loc_02321734	; 02321720
	ldr r1,[pool_02321860]	; 02321722
	ldr r1,[r7,r1]	; 02321724
	lsl r1,r1,#0x1b	; 02321726
	lsr r1,r1,#0x1f	; 02321728
	cmp r1,#0x0	; 0232172A
	beq loc_02321734	; 0232172C
	mov r0,#0x4	; 0232172E
	str r0,[r4,#0x30]	; 02321730
	b loc_023217FA	; 02321732
loc_02321734:
	ldr r1,[sp,#0x0]	; 02321734
	cmp r1,#0x0	; 02321736
	beq loc_02321752	; 02321738
	ldr r0,[pool_02321860]	; 0232173A
	ldr r0,[r7,r0]	; 0232173C
	lsl r0,r0,#0x1a	; 0232173E
	lsr r0,r0,#0x1f	; 02321740
	cmp r0,#0x0	; 02321742
	beq loc_0232174C	; 02321744
	mov r0,#0x1	; 02321746
	str r0,[r4,#0x30]	; 02321748
	b loc_023217FA	; 0232174A
loc_0232174C:
	mov r0,#0x0	; 0232174C
	str r0,[r4,#0x30]	; 0232174E
	b loc_023217FA	; 02321750
loc_02321752:
	cmp r0,#0x0	; 02321752
	beq loc_02321762	; 02321754
	cmp r5,#0x3	; 02321756
	bne loc_02321762	; 02321758
	mov r0,#0x2	; 0232175A
	str r0,[r4,#0x30]	; 0232175C
	str r0,[r4,#0x34]	; 0232175E
	b loc_023217FA	; 02321760
loc_02321762:
	cmp r6,#0x0	; 02321762
	beq loc_023217FA	; 02321764
	cmp r5,#0x2	; 02321766
	bne loc_023217FA	; 02321768
	mov r0,#0x3	; 0232176A
	str r0,[r4,#0x30]	; 0232176C
	str r0,[r4,#0x34]	; 0232176E
	b loc_023217FA	; 02321770
loc_02321772:
	ldr r1,[sp,#0x8]	; 02321772
	cmp r1,#0x0	; 02321774
	beq loc_0232178A	; 02321776
	ldr r0,[r4,#0x34]	; 02321778
	cmp r0,#0x3	; 0232177A
	bne loc_02321784	; 0232177C
	mov r0,#0x3	; 0232177E
	str r0,[r4,#0x30]	; 02321780
	b loc_023217FA	; 02321782
loc_02321784:
	mov r0,#0x2	; 02321784
	str r0,[r4,#0x30]	; 02321786
	b loc_023217FA	; 02321788
loc_0232178A:
	ldr r1,[sp,#0x0]	; 0232178A
	cmp r1,#0x0	; 0232178C
	beq loc_02321796	; 0232178E
	mov r0,#0x0	; 02321790
	str r0,[r4,#0x30]	; 02321792
	b loc_023217FA	; 02321794
loc_02321796:
	cmp r6,#0x0	; 02321796
	beq loc_023217A0	; 02321798
	mov r0,#0x3	; 0232179A
	str r0,[r4,#0x34]	; 0232179C
	b loc_023217FA	; 0232179E
loc_023217A0:
	cmp r0,#0x0	; 023217A0
	beq loc_023217FA	; 023217A2
	mov r0,#0x2	; 023217A4
	str r0,[r4,#0x34]	; 023217A6
	b loc_023217FA	; 023217A8
loc_023217AA:
	ldr r1,[sp,#0x8]	; 023217AA
	cmp r1,#0x0	; 023217AC
	beq loc_023217D4	; 023217AE
	ldr r0,[pool_02321860]	; 023217B0
	ldr r0,[r7,r0]	; 023217B2
	lsl r0,r0,#0x1a	; 023217B4
	lsr r0,r0,#0x1f	; 023217B6
	cmp r0,#0x0	; 023217B8
	beq loc_023217C2	; 023217BA
	mov r0,#0x1	; 023217BC
	str r0,[r4,#0x30]	; 023217BE
	b loc_023217FA	; 023217C0
loc_023217C2:
	ldr r0,[r4,#0x34]	; 023217C2
	cmp r0,#0x3	; 023217C4
	bne loc_023217CE	; 023217C6
	mov r0,#0x3	; 023217C8
	str r0,[r4,#0x30]	; 023217CA
	b loc_023217FA	; 023217CC
loc_023217CE:
	mov r0,#0x2	; 023217CE
	str r0,[r4,#0x30]	; 023217D0
	b loc_023217FA	; 023217D2
loc_023217D4:
	cmp r0,#0x0	; 023217D4
	beq loc_023217DE	; 023217D6
	mov r0,#0x5	; 023217D8
	str r0,[r4,#0x30]	; 023217DA
	b loc_023217FA	; 023217DC
loc_023217DE:
	cmp r6,#0x0	; 023217DE
	beq loc_023217FA	; 023217E0
	mov r0,#0x6	; 023217E2
	str r0,[r4,#0x30]	; 023217E4
	b loc_023217FA	; 023217E6
loc_023217E8:
	cmp r6,#0x0	; 023217E8
	beq loc_023217FA	; 023217EA
	mov r0,#0x0	; 023217EC
	str r0,[r4,#0x30]	; 023217EE
	b loc_023217FA	; 023217F0
loc_023217F2:
	cmp r0,#0x0	; 023217F2
	beq loc_023217FA	; 023217F4
	mov r0,#0x0	; 023217F6
	str r0,[r4,#0x30]	; 023217F8
loc_023217FA:
	ldr r0,[r4,#0x30]	; 023217FA
	cmp r5,r0	; 023217FC
	beq loc_02321806	; 023217FE
	mov r0,#0x1d	; 02321800
	bl loc_0232365C	; 02321802
loc_02321806:
	mov r5,#0x0	; 02321806
loc_02321808:
	add r7,r5,#0x0	; 02321808
	mov r0,#0xc	; 0232180A
	mul r7,r0	; 0232180C
	add r6,r4,r7	; 0232180E
	ldr r0,[r4,#0x30]	; 02321810
	lsl r1,r0,#0x5	; 02321812
	ldr r0,[pool_02321864]	; 02321814
	add r2,r0,r1	; 02321816
	lsl r1,r5,#0x3	; 02321818
	add r0,r2,r1	; 0232181A
	str r0,[sp,#0x4]	; 0232181C
	ldr r0,[r4,r7]	; 0232181E
	lsl r0,r0,#0x3	; 02321820
	ldr r1,[r2,r1]	; 02321822
	lsl r1,r1,#0x1	; 02321824
	add r1,r0,r1	; 02321826
	ldr r0,[pool_02321868]	; 02321828
	add r0,r1,r0	; 0232182A
	mov r1,#0xa	; 0232182C
	blx P1_SignedDivMod	; 0232182E
	str r0,[r4,r7]	; 02321832
	ldr r0,[r6,#0x4]	; 02321834
	lsl r1,r0,#0x3	; 02321836
	ldr r0,[sp,#0x4]	; 02321838
	ldr r0,[r0,#0x4]	; 0232183A
	lsl r0,r0,#0x1	; 0232183C
	add r1,r1,r0	; 0232183E
	ldr r0,[pool_02321868]	; 02321840
	add r0,r1,r0	; 02321842
	mov r1,#0xa	; 02321844
	blx P1_SignedDivMod	; 02321846
	str r0,[r6,#0x4]	; 0232184A
	add r5,r5,#0x1	; 0232184C
	cmp r5,#0x4	; 0232184E
	blt loc_02321808	; 02321850
	add sp,#0xc	; 02321852
	pop {r4,r5,r6,r7}	; 02321854
	pop {r3}	; 02321856
	bx r3	; 02321858
	.byte 0xC0, 0x46	; 0232185C
pool_0232185C:
loc_0232185C:
	.word 0x00000144	; 0232185C
pool_02321860:
loc_02321860:
	.word 0x00001368	; 02321860
pool_02321864:
loc_02321864:
	.word 0x023305EC	; 02321864
pool_02321868:
loc_02321868:
	.word 0x00000800	; 02321868

; ===== function loc_0232186C =====
loc_0232186C:
	push {r4,r5,r6,r7,lr}	; 0232186C
	sub sp,#0x4	; 0232186E
	ldr r1,[pool_023218D8]	; 02321870
	add r5,r0,r1	; 02321872
	ldr r0,[pool_023218DC]	; 02321874
	ldr r0,[r0,#0x68]	; 02321876
	lsl r1,r0,#0x1b	; 02321878
	lsr r1,r1,#0x1f	; 0232187A
	cmp r1,#0x0	; 0232187C
	beq loc_02321886	; 0232187E
	mov r0,#0x4	; 02321880
	str r0,[r5,#0x30]	; 02321882
	b loc_02321898	; 02321884
loc_02321886:
	lsl r0,r0,#0x1a	; 02321886
	lsr r0,r0,#0x1f	; 02321888
	cmp r0,#0x0	; 0232188A
	beq loc_02321894	; 0232188C
	mov r0,#0x1	; 0232188E
	str r0,[r5,#0x30]	; 02321890
	b loc_02321898	; 02321892
loc_02321894:
	mov r0,#0x3	; 02321894
	str r0,[r5,#0x30]	; 02321896
loc_02321898:
	mov r0,#0x3	; 02321898
	str r0,[r5,#0x34]	; 0232189A
	mov r6,#0x0	; 0232189C
	ldr r2,[pool_023218E0]	; 0232189E
	ldr r0,[pool_023218E4]	; 023218A0
loc_023218A2:
	add r3,r6,#0x0	; 023218A2
	mov r1,#0xc	; 023218A4
	mul r3,r1	; 023218A6
	add r4,r5,r3	; 023218A8
	lsl r1,r6,#0x2	; 023218AA
	ldr r1,[r2,r1]	; 023218AC
	str r1,[r4,#0x8]	; 023218AE
	lsl r1,r6,#0x3	; 023218B0
	ldr r7,[r5,#0x30]	; 023218B2
	lsl r7,r7,#0x5	; 023218B4
	add r7,r0,r7	; 023218B6
	ldr r7,[r1,r7]	; 023218B8
	str r7,[r5,r3]	; 023218BA
	ldr r3,[r5,#0x30]	; 023218BC
	lsl r3,r3,#0x5	; 023218BE
	add r3,r0,r3	; 023218C0
	add r1,r1,r3	; 023218C2
	ldr r1,[r1,#0x4]	; 023218C4
	str r1,[r4,#0x4]	; 023218C6
	add r6,r6,#0x1	; 023218C8
	cmp r6,#0x4	; 023218CA
	blt loc_023218A2	; 023218CC
	add sp,#0x4	; 023218CE
	pop {r4,r5,r6,r7}	; 023218D0
	pop {r3}	; 023218D2
	bx r3	; 023218D4
	.byte 0xC0, 0x46	; 023218D8
pool_023218D8:
loc_023218D8:
	.word 0x00000144	; 023218D8
pool_023218DC:
loc_023218DC:
	.word P1_BssStart + 0x1300	; 023218DC
pool_023218E0:
loc_023218E0:
	.word P1_Data_02330564	; 023218E0
pool_023218E4:
loc_023218E4:
	.word 0x023305EC	; 023218E4

; ===== function loc_023218E8 =====
loc_023218E8:
	push {lr}	; 023218E8
	sub sp,#0x4	; 023218EA
	mov r1,#0x1	; 023218EC
	str r1,[r0,#0x8]	; 023218EE
	mov r0,#0x0	; 023218F0
	str r0,[sp,#0x0]	; 023218F2
	ldr r0,[pool_02321908]	; 023218F4
	mov r1,#0x10	; 023218F6
	mov r2,#0x20	; 023218F8
	add r3,r1,#0x0	; 023218FA
	bl loc_0232DBC0	; 023218FC
	add sp,#0x4	; 02321900
	pop {r3}	; 02321902
	bx r3	; 02321904
	.byte 0xC0, 0x46	; 02321908
pool_02321908:
loc_02321908:
	.word REG_BLDCNT	; 02321908

; ===== function loc_0232190C =====
loc_0232190C:
	push {r4,r5,r6,r7,lr}	; 0232190C
	sub sp,#0x4	; 0232190E
	add r5,r0,#0x0	; 02321910
	mov r4,#0x0	; 02321912
	add r6,r5,#0x0	; 02321914
	add r6,#0xc	; 02321916
	mov r7,#0x74	; 02321918
loc_0232191A:
	add r0,r4,#0x0	; 0232191A
	mul r0,r7	; 0232191C
	add r0,r6,r0	; 0232191E
	ldr r1,[r5,#0x0]	; 02321920
	bl loc_02321BE4	; 02321922
	add r4,r4,#0x1	; 02321926
	cmp r4,#0x14	; 02321928
	blt loc_0232191A	; 0232192A
	ldr r0,[r5,#0x0]	; 0232192C
	cmp r0,#0x78	; 0232192E
	bge loc_02321936	; 02321930
	add r0,r0,#0x1	; 02321932
	str r0,[r5,#0x0]	; 02321934
loc_02321936:
	ldr r0,[r5,#0x0]	; 02321936
	cmp r0,#0x1d	; 02321938
	bne loc_02321940	; 0232193A
	bl loc_02321488	; 0232193C
loc_02321940:
	ldr r0,[r5,#0x8]	; 02321940
	cmp r0,#0x0	; 02321942
	beq loc_02321968	; 02321944
	add r1,r5,#0x4	; 02321946
	ldr r0,[r1,#0x0]	; 02321948
	add r0,r0,#0x1	; 0232194A
	str r0,[r1,#0x0]	; 0232194C
	ldr r0,[r5,#0x4]	; 0232194E
	cmp r0,#0xf	; 02321950
	bgt loc_02321968	; 02321952
	lsl r0,r0,#0x4	; 02321954
	mov r1,#0xf	; 02321956
	blx P1_SignedDivMod	; 02321958
	mov r1,#0x10	; 0232195C
	sub r1,r1,r0	; 0232195E
	lsl r0,r0,#0x8	; 02321960
	orr r1,r0	; 02321962
	ldr r0,[pool_02321970]	; 02321964
	strh r1,[r0,#0x0]	; 02321966
loc_02321968:
	add sp,#0x4	; 02321968
	pop {r4,r5,r6,r7}	; 0232196A
	pop {r3}	; 0232196C
	bx r3	; 0232196E
pool_02321970:
loc_02321970:
	.word REG_BLDALPHA	; 02321970

; ===== function loc_02321974 =====
loc_02321974:
	push {r4,r5,r6,r7,lr}	; 02321974
	sub sp,#0x1c	; 02321976
	str r0,[sp,#0x0]	; 02321978
	mov r5,#0x0	; 0232197A
	str r5,[sp,#0x4]	; 0232197C
	str r5,[sp,#0x10]	; 0232197E
	str r5,[sp,#0x8]	; 02321980
loc_02321982:
	ldr r2,[sp,#0x0]	; 02321982
	add r2,#0xc	; 02321984
	ldr r1,[sp,#0x4]	; 02321986
	mov r0,#0x74	; 02321988
	mul r1,r0	; 0232198A
	add r4,r2,r1	; 0232198C
	ldr r0,[pool_02321A18]	; 0232198E
	ldrh r0,[r0,r5]	; 02321990
	str r0,[r4,#0x70]	; 02321992
	add r5,r5,#0x2	; 02321994
	ldr r7,[sp,#0x8]	; 02321996
	b loc_023219EC	; 02321998
loc_0232199A:
	add r1,r7,#0x0	; 0232199A
	str r1,[sp,#0xc]	; 0232199C
	mov r0,#0x18	; 0232199E
	mul r1,r0	; 023219A0
	str r1,[sp,#0xc]	; 023219A2
	add r6,r4,r1	; 023219A4
	ldr r0,[pool_02321A18]	; 023219A6
	add r0,r0,r5	; 023219A8
	add r1,sp,#0x14	; 023219AA
	mov r2,#0x8	; 023219AC
	blx loc_0232E304	; 023219AE
	add r5,#0x8	; 023219B2
	add r0,sp,#0x14	; 023219B4
	ldrb r1,[r0,#0x0]	; 023219B6
	ldr r0,[sp,#0xc]	; 023219B8
	str r1,[r4,r0]	; 023219BA
	add r0,sp,#0x14	; 023219BC
	ldrb r0,[r0,#0x1]	; 023219BE
	lsl r0,r0,#0xc	; 023219C0
	asr r0,r0,#0x4	; 023219C2
	str r0,[r6,#0x14]	; 023219C4
	add r1,sp,#0x14	; 023219C6
	mov r0,#0x2	; 023219C8
	ldrsh r0,[r1,r0]	; 023219CA
	lsl r0,r0,#0xc	; 023219CC
	str r0,[r6,#0x4]	; 023219CE
	mov r0,#0x4	; 023219D0
	ldrsh r0,[r1,r0]	; 023219D2
	lsl r0,r0,#0xc	; 023219D4
	str r0,[r6,#0x8]	; 023219D6
	lsl r0,r1,#0	; 023219D8
	ldrb r0,[r0,#0x6]	; 023219DA
	lsl r0,r0,#0xc	; 023219DC
	str r0,[r6,#0xc]	; 023219DE
	lsl r0,r1,#0	; 023219E0
	ldrb r0,[r0,#0x7]	; 023219E2
	lsl r0,r0,#0xc	; 023219E4
	asr r0,r0,#0x4	; 023219E6
	str r0,[r6,#0x10]	; 023219E8
	add r7,r7,#0x1	; 023219EA
loc_023219EC:
	ldr r0,[r4,#0x70]	; 023219EC
	cmp r7,r0	; 023219EE
	bcc loc_0232199A	; 023219F0
	ldr r0,[sp,#0x10]	; 023219F2
	str r0,[r4,#0x60]	; 023219F4
	str r0,[r4,#0x64]	; 023219F6
	str r0,[r4,#0x68]	; 023219F8
	str r0,[r4,#0x6c]	; 023219FA
	ldr r0,[sp,#0x4]	; 023219FC
	add r0,r0,#0x1	; 023219FE
	str r0,[sp,#0x4]	; 02321A00
	cmp r0,#0x14	; 02321A02
	blt loc_02321982	; 02321A04
	ldr r1,[sp,#0x10]	; 02321A06
	ldr r0,[sp,#0x0]	; 02321A08
	str r1,[r0,#0x0]	; 02321A0A
	str r1,[r0,#0x4]	; 02321A0C
	str r1,[r0,#0x8]	; 02321A0E
	add sp,#0x1c	; 02321A10
	pop {r4,r5,r6,r7}	; 02321A12
	pop {r3}	; 02321A14
	bx r3	; 02321A16
pool_02321A18:
loc_02321A18:
	.word P5_Data_023A8BB8	; 02321A18

; ===== function loc_02321A1C =====
loc_02321A1C:
	push {r4,r5,r6,r7,lr}	; 02321A1C
	sub sp,#0x1c	; 02321A1E
	str r0,[sp,#0xc]	; 02321A20
	str r1,[sp,#0x10]	; 02321A22
	mov r5,#0x0	; 02321A24
	str r5,[sp,#0x14]	; 02321A26
loc_02321A28:
	ldr r2,[sp,#0xc]	; 02321A28
	add r2,#0xc	; 02321A2A
	add r1,r5,#0x0	; 02321A2C
	mov r0,#0x74	; 02321A2E
	mul r1,r0	; 02321A30
	add r6,r2,r1	; 02321A32
	ldr r0,[r6,#0x68]	; 02321A34
	asr r4,r0,#0xc	; 02321A36
	cmp r4,#0x0	; 02321A38
	bge loc_02321A40	; 02321A3A
	ldr r4,[sp,#0x14]	; 02321A3C
	b loc_02321A46	; 02321A3E
loc_02321A40:
	cmp r4,#0xf	; 02321A40
	blt loc_02321A46	; 02321A42
	mov r4,#0xe	; 02321A44
loc_02321A46:
	ldr r0,[r6,#0x70]	; 02321A46
	cmp r0,#0x0	; 02321A48
	beq loc_02321AD4	; 02321A4A
	cmp r4,#0x0	; 02321A4C
	beq loc_02321AD4	; 02321A4E
	ldr r1,[r6,#0x60]	; 02321A50
	ldr r0,[pool_02321AE4]	; 02321A52
	add r0,r1,r0	; 02321A54
	ldr r1,[pool_02321AE8]	; 02321A56
	bl loc_0232CF50	; 02321A58
	str r0,[sp,#0x18]	; 02321A5C
	ldr r1,[r6,#0x64]	; 02321A5E
	ldr r0,[pool_02321AE4]	; 02321A60
	add r0,r1,r0	; 02321A62
	ldr r1,[pool_02321AE8]	; 02321A64
	bl loc_0232CF50	; 02321A66
	add r7,r0,#0x0	; 02321A6A
	cmp r5,#0xc	; 02321A6C
	bge loc_02321ABC	; 02321A6E
	lsl r1,r5,#0x1	; 02321A70
	ldr r0,[pool_02321AEC]	; 02321A72
	ldrsh r6,[r0,r1]	; 02321A74
	cmp r6,#0xb	; 02321A76
	bne loc_02321AA4	; 02321A78
	ldr r0,[sp,#0x10]	; 02321A7A
	cmp r0,#0x0	; 02321A7C
	beq loc_02321AD4	; 02321A7E
	ldr r0,[sp,#0x18]	; 02321A80
	add r0,#0xe	; 02321A82
	add r1,r7,#0x7	; 02321A84
	add r2,r4,#0x0	; 02321A86
	bl loc_023263FC	; 02321A88
	bl loc_02323DC0	; 02321A8C
	ldr r1,[sp,#0x18]	; 02321A90
	str r1,[sp,#0x0]	; 02321A92
	str r7,[sp,#0x4]	; 02321A94
	str r4,[sp,#0x8]	; 02321A96
	ldr r1,[pool_02321AF0]	; 02321A98
	ldr r2,[pool_02321AF4]	; 02321A9A
	add r3,r6,#0x0	; 02321A9C
	bl loc_02323B24	; 02321A9E
	b loc_02321AD4	; 02321AA2
loc_02321AA4:
	bl loc_02323DC0	; 02321AA4
	ldr r1,[sp,#0x18]	; 02321AA8
	str r1,[sp,#0x0]	; 02321AAA
	str r7,[sp,#0x4]	; 02321AAC
	str r4,[sp,#0x8]	; 02321AAE
	ldr r1,[pool_02321AF0]	; 02321AB0
	ldr r2,[pool_02321AF4]	; 02321AB2
	add r3,r6,#0x0	; 02321AB4
	bl loc_02323B24	; 02321AB6
	b loc_02321AD4	; 02321ABA
loc_02321ABC:
	ldr r0,[r6,#0x6c]	; 02321ABC
	bl loc_0232CFE8	; 02321ABE
	str r0,[sp,#0x0]	; 02321AC2
	lsl r1,r5,#0x1	; 02321AC4
	ldr r0,[pool_02321AEC]	; 02321AC6
	ldrsh r0,[r0,r1]	; 02321AC8
	ldr r1,[sp,#0x18]	; 02321ACA
	add r2,r7,#0x0	; 02321ACC
	add r3,r4,#0x0	; 02321ACE
	bl loc_02321AF8	; 02321AD0
loc_02321AD4:
	add r5,r5,#0x1	; 02321AD4
	cmp r5,#0x14	; 02321AD6
	blt loc_02321A28	; 02321AD8
	add sp,#0x1c	; 02321ADA
	pop {r4,r5,r6,r7}	; 02321ADC
	pop {r3}	; 02321ADE
	bx r3	; 02321AE0
	.byte 0xC0, 0x46	; 02321AE4
pool_02321AE4:
loc_02321AE4:
	.word 0x00000800	; 02321AE4
pool_02321AE8:
loc_02321AE8:
	.word 0x00001000	; 02321AE8
pool_02321AEC:
loc_02321AEC:
	.word P1_Data_02330574	; 02321AEC
pool_02321AF0:
loc_02321AF0:
	.word 0x023CE330	; 02321AF0
pool_02321AF4:
loc_02321AF4:
	.word 0x0239FEBC	; 02321AF4

; ===== function loc_02321AF8 =====
loc_02321AF8:
	push {r4,r5,r6,r7,lr}	; 02321AF8
	sub sp,#0x34	; 02321AFA
	str r1,[sp,#0x0]	; 02321AFC
	str r2,[sp,#0x4]	; 02321AFE
	str r3,[sp,#0x8]	; 02321B00
	ldr r7,[pool_02321BD4]	; 02321B02
	add r7,#0x8	; 02321B04
	lsl r0,r0,#0x3	; 02321B06
	str r0,[sp,#0x14]	; 02321B08
	add r5,r7,r0	; 02321B0A
	ldr r0,[pool_02321BD8]	; 02321B0C
	ldr r1,[r5,#0x4]	; 02321B0E
	bl loc_02328D94	; 02321B10
	add r6,r0,#0x0	; 02321B14
	ldr r0,[pool_02321BD8]	; 02321B16
	ldr r1,[r5,#0x4]	; 02321B18
	bl loc_02328D7C	; 02321B1A
	add r4,r0,#0x0	; 02321B1E
	ldr r0,[pool_02321BD8]	; 02321B20
	ldr r1,[r5,#0x4]	; 02321B22
	bl loc_02328DAC	; 02321B24
	str r0,[sp,#0xc]	; 02321B28
	mov r1,sp	; 02321B2A
	sub r1,r1,#0x4	; 02321B2C
	ldr r0,[sp,#0x14]	; 02321B2E
	ldrh r0,[r7,r0]	; 02321B30
	strh r0,[r1,#0x0]	; 02321B32
	ldmia r1!,{r0}	; 02321B34
	ldrb r1,[r4,#0x0]	; 02321B36
	bl loc_02328CAC	; 02321B38
	ldr r1,[sp,#0x0]	; 02321B3C
	add r0,r1,r0	; 02321B3E
	str r0,[sp,#0x0]	; 02321B40
	mov r1,sp	; 02321B42
	sub r1,r1,#0x4	; 02321B44
	ldrh r0,[r5,#0x2]	; 02321B46
	strh r0,[r1,#0x0]	; 02321B48
	ldmia r1!,{r0}	; 02321B4A
	ldrb r1,[r4,#0x1]	; 02321B4C
	bl loc_02328C74	; 02321B4E
	ldr r1,[sp,#0x4]	; 02321B52
	add r0,r1,r0	; 02321B54
	str r0,[sp,#0x4]	; 02321B56
	ldr r0,[sp,#0x48]	; 02321B58
	cmp r0,#0x0	; 02321B5A
	beq loc_02321BCC	; 02321B5C
	str r0,[sp,#0x2c]	; 02321B5E
	str r0,[sp,#0x20]	; 02321B60
	mov r5,#0x0	; 02321B62
	str r5,[sp,#0x28]	; 02321B64
	str r5,[sp,#0x24]	; 02321B66
	ldr r0,[sp,#0x8]	; 02321B68
	lsl r0,r0,#0xc	; 02321B6A
	str r0,[sp,#0x10]	; 02321B6C
	b loc_02321BC6	; 02321B6E
loc_02321B70:
	ldrh r7,[r6,#0x8]	; 02321B70
	ldr r0,[r6,#0x0]	; 02321B72
	lsl r1,r0,#0x10	; 02321B74
	lsr r1,r1,#0x1e	; 02321B76
	lsl r2,r1,#0xe	; 02321B78
	lsr r1,r0,#0x1e	; 02321B7A
	lsl r1,r1,#0x1e	; 02321B7C
	orr r2,r1	; 02321B7E
	lsl r0,r0,#0x7	; 02321B80
	lsr r1,r0,#0x17	; 02321B82
	ldr r0,[sp,#0x0]	; 02321B84
	add r0,r0,r1	; 02321B86
	ldrb r1,[r4,#0x0]	; 02321B88
	lsr r1,r1,#0x1	; 02321B8A
	sub r1,r0,r1	; 02321B8C
	ldr r0,[pool_02321BDC]	; 02321B8E
	and r1,r0	; 02321B90
	lsl r1,r1,#0x10	; 02321B92
	ldrb r3,[r6,#0x0]	; 02321B94
	ldr r0,[sp,#0x4]	; 02321B96
	add r0,r0,r3	; 02321B98
	ldrb r3,[r4,#0x1]	; 02321B9A
	lsr r3,r3,#0x1	; 02321B9C
	sub r3,r0,r3	; 02321B9E
	mov r0,#0xff	; 02321BA0
	and r3,r0	; 02321BA2
	orr r2,r3	; 02321BA4
	orr r1,r2	; 02321BA6
	ldr r0,[pool_02321BE0]	; 02321BA8
	orr r1,r0	; 02321BAA
	str r1,[sp,#0x18]	; 02321BAC
	ldr r1,[sp,#0x10]	; 02321BAE
	orr r1,r7	; 02321BB0
	add r0,sp,#0x18	; 02321BB2
	strh r1,[r0,#0x4]	; 02321BB4
	bl loc_02323DC0	; 02321BB6
	add r1,sp,#0x18	; 02321BBA
	add r2,sp,#0x20	; 02321BBC
	bl loc_023238D8	; 02321BBE
	add r5,r5,#0x1	; 02321BC2
	add r6,#0xc	; 02321BC4
loc_02321BC6:
	ldr r0,[sp,#0xc]	; 02321BC6
	cmp r5,r0	; 02321BC8
	blt loc_02321B70	; 02321BCA
loc_02321BCC:
	add sp,#0x34	; 02321BCC
	pop {r4,r5,r6,r7}	; 02321BCE
	pop {r3}	; 02321BD0
	bx r3	; 02321BD2
pool_02321BD4:
loc_02321BD4:
	.word 0x0239FEBC	; 02321BD4
pool_02321BD8:
loc_02321BD8:
	.word 0x023CE330	; 02321BD8
pool_02321BDC:
loc_02321BDC:
	.word 0x000001FF	; 02321BDC
pool_02321BE0:
loc_02321BE0:
	.word 0x00000300	; 02321BE0

; ===== function loc_02321BE4 =====
loc_02321BE4:
	push {r4,r5,r6,r7,lr}	; 02321BE4
	sub sp,#0x14	; 02321BE6
	add r5,r0,#0x0	; 02321BE8
	str r1,[sp,#0x8]	; 02321BEA
	mov r7,#0x0	; 02321BEC
	add r6,r7,#0x0	; 02321BEE
	add r3,r7,#0x0	; 02321BF0
	ldr r2,[r5,#0x70]	; 02321BF2
	b loc_02321C08	; 02321BF4
loc_02321BF6:
	add r4,r3,#0x0	; 02321BF6
	mov r0,#0x18	; 02321BF8
	mul r4,r0	; 02321BFA
	ldr r1,[r5,r4]	; 02321BFC
	ldr r0,[sp,#0x8]	; 02321BFE
	cmp r1,r0	; 02321C00
	bhi loc_02321C06	; 02321C02
	add r7,r5,r4	; 02321C04
loc_02321C06:
	add r3,r3,#0x1	; 02321C06
loc_02321C08:
	cmp r3,r2	; 02321C08
	bcc loc_02321BF6	; 02321C0A
	sub r3,r2,#0x1	; 02321C0C
	mov r4,#0x18	; 02321C0E
	b loc_02321C22	; 02321C10
loc_02321C12:
	add r2,r3,#0x0	; 02321C12
	mul r2,r4	; 02321C14
	ldr r1,[r5,r2]	; 02321C16
	ldr r0,[sp,#0x8]	; 02321C18
	cmp r1,r0	; 02321C1A
	bls loc_02321C20	; 02321C1C
	add r6,r5,r2	; 02321C1E
loc_02321C20:
	sub r3,r3,#0x1	; 02321C20
loc_02321C22:
	cmp r3,#0x0	; 02321C22
	bge loc_02321C12	; 02321C24
	cmp r7,#0x0	; 02321C26
	bne loc_02321C3C	; 02321C28
	mov r2,#0x0	; 02321C2A
loc_02321C2C:
	lsl r0,r2,#0x2	; 02321C2C
	add r1,r5,r0	; 02321C2E
	ldr r0,[r1,#0x4]	; 02321C30
	str r0,[r1,#0x60]	; 02321C32
	add r2,r2,#0x1	; 02321C34
	cmp r2,#0x4	; 02321C36
	blt loc_02321C2C	; 02321C38
	b loc_02321C96	; 02321C3A
loc_02321C3C:
	cmp r6,#0x0	; 02321C3C
	bne loc_02321C5E	; 02321C3E
	mov r0,#0x0	; 02321C40
	mov r1,#0x18	; 02321C42
loc_02321C44:
	lsl r4,r0,#0x2	; 02321C44
	ldr r2,[r5,#0x70]	; 02321C46
	mul r2,r1	; 02321C48
	add r2,r5,r2	; 02321C4A
	add r2,r4,r2	; 02321C4C
	sub r2,#0x14	; 02321C4E
	ldr r3,[r2,#0x0]	; 02321C50
	add r2,r5,r4	; 02321C52
	str r3,[r2,#0x60]	; 02321C54
	add r0,r0,#0x1	; 02321C56
	cmp r0,#0x4	; 02321C58
	blt loc_02321C44	; 02321C5A
	b loc_02321C96	; 02321C5C
loc_02321C5E:
	mov r4,#0x0	; 02321C5E
	str r4,[sp,#0x10]	; 02321C60
loc_02321C62:
	cmp r4,#0x2	; 02321C62
	bne loc_02321C6A	; 02321C64
	ldr r3,[sp,#0x10]	; 02321C66
	b loc_02321C6C	; 02321C68
loc_02321C6A:
	ldr r3,[r7,#0x14]	; 02321C6A
loc_02321C6C:
	lsl r0,r4,#0x2	; 02321C6C
	str r0,[sp,#0xc]	; 02321C6E
	ldr r0,[r6,#0x0]	; 02321C70
	str r0,[sp,#0x0]	; 02321C72
	ldr r0,[sp,#0xc]	; 02321C74
	add r0,r6,r0	; 02321C76
	ldr r0,[r0,#0x4]	; 02321C78
	str r0,[sp,#0x4]	; 02321C7A
	ldr r0,[sp,#0x8]	; 02321C7C
	ldr r1,[r7,#0x0]	; 02321C7E
	ldr r2,[sp,#0xc]	; 02321C80
	add r2,r7,r2	; 02321C82
	ldr r2,[r2,#0x4]	; 02321C84
	bl loc_02321CA0	; 02321C86
	ldr r1,[sp,#0xc]	; 02321C8A
	add r1,r5,r1	; 02321C8C
	str r0,[r1,#0x60]	; 02321C8E
	add r4,r4,#0x1	; 02321C90
	cmp r4,#0x4	; 02321C92
	blt loc_02321C62	; 02321C94
loc_02321C96:
	add sp,#0x14	; 02321C96
	pop {r4,r5,r6,r7}	; 02321C98
	pop {r3}	; 02321C9A
	bx r3	; 02321C9C
	.byte 0x00, 0x00	; 02321CA0

; ===== function loc_02321CA0 =====
loc_02321CA0:
	push {r4,r5,r6,r7,lr}	; 02321CA0
	sub sp,#0x4	; 02321CA2
	add r4,r2,#0x0	; 02321CA4
	add r7,r3,#0x0	; 02321CA6
	sub r0,r0,r1	; 02321CA8
	lsl r0,r0,#0xc	; 02321CAA
	ldr r2,[sp,#0x18]	; 02321CAC
	sub r1,r2,r1	; 02321CAE
	blx P1_SignedDivMod	; 02321CB0
	add r5,r0,#0x0	; 02321CB4
	ldr r0,[pool_02321CF4]	; 02321CB6
	sub r0,r0,r5	; 02321CB8
	str r0,[sp,#0x0]	; 02321CBA
	add r1,r4,#0x0	; 02321CBC
	blx loc_0232CFFC	; 02321CBE
	add r6,r0,#0x0	; 02321CC2
	ldr r0,[sp,#0x0]	; 02321CC4
	ldr r1,[pool_02321CF4]	; 02321CC6
	add r1,r5,r1	; 02321CC8
	blx loc_0232CFFC	; 02321CCA
	add r1,r7,#0x0	; 02321CCE
	blx loc_0232CFFC	; 02321CD0
	ldr r1,[sp,#0x1c]	; 02321CD4
	sub r1,r1,r4	; 02321CD6
	blx loc_0232CFFC	; 02321CD8
	add r4,r0,#0x0	; 02321CDC
	add r0,r5,#0x0	; 02321CDE
	ldr r1,[sp,#0x1c]	; 02321CE0
	blx loc_0232CFFC	; 02321CE2
	add r0,r4,r0	; 02321CE6
	add r0,r6,r0	; 02321CE8
	add sp,#0x4	; 02321CEA
	pop {r4,r5,r6,r7}	; 02321CEC
	pop {r3}	; 02321CEE
	bx r3	; 02321CF0
	.byte 0xC0, 0x46	; 02321CF4
pool_02321CF4:
loc_02321CF4:
	.word 0x00001000	; 02321CF4

; ===== function loc_02321CF8 =====
loc_02321CF8:
	ldr r3,[pool_02321CFC]	; 02321CF8
	bx r3	; 02321CFA
pool_02321CFC:
loc_02321CFC:
	.word loc_02324274 + 1	; 02321CFC

; ===== function loc_02321D00 =====
loc_02321D00:
	ldr r3,[pool_02321D04]	; 02321D00
	bx r3	; 02321D02
pool_02321D04:
loc_02321D04:
	.word loc_02324284 + 1	; 02321D04

; ===== function loc_02321D08 =====
loc_02321D08:
	ldr r3,[pool_02321D0C]	; 02321D08
	bx r3	; 02321D0A
pool_02321D0C:
loc_02321D0C:
	.word loc_02324298 + 1	; 02321D0C

; ===== function loc_02321D10 =====
loc_02321D10:
	push {r4,lr}	; 02321D10
	add r4,r0,#0x0	; 02321D12
	ldr r1,[pool_02321D48]	; 02321D14
	bl loc_023242AC	; 02321D16
	mov r0,#0x0	; 02321D1A
	bl loc_02325308	; 02321D1C
	cmp r0,#0x0	; 02321D20
	beq loc_02321D2A	; 02321D22
	mov r0,#0x0	; 02321D24
	str r0,[r4,#0xc]	; 02321D26
	b loc_02321D40	; 02321D28
loc_02321D2A:
	mov r0,#0x1	; 02321D2A
	bl loc_02325308	; 02321D2C
	cmp r0,#0x0	; 02321D30
	beq loc_02321D3A	; 02321D32
	mov r0,#0x1	; 02321D34
	str r0,[r4,#0xc]	; 02321D36
	b loc_02321D40	; 02321D38
loc_02321D3A:
	mov r0,#0x0	; 02321D3A
	mvn r0,r0	; 02321D3C
	str r0,[r4,#0xc]	; 02321D3E
loc_02321D40:
	pop {r4}	; 02321D40
	pop {r3}	; 02321D42
	bx r3	; 02321D44
	.byte 0xC0, 0x46	; 02321D48
pool_02321D48:
loc_02321D48:
	.word 0x0239F208	; 02321D48

; ===== function loc_02321D4C =====
loc_02321D4C:
	push {r4,lr}	; 02321D4C
	add r4,r0,#0x0	; 02321D4E
	bl loc_02324358	; 02321D50
	mov r0,#0x0	; 02321D54
	mvn r0,r0	; 02321D56
	str r0,[r4,#0xc]	; 02321D58
	pop {r4}	; 02321D5A
	pop {r3}	; 02321D5C
	bx r3	; 02321D5E

; ===== function loc_02321D60 =====
loc_02321D60:
	push {r4,lr}	; 02321D60
	sub sp,#0x8	; 02321D62
	ldr r0,[pool_02321DF0]	; 02321D64
	ldr r0,[r0,#0x0]	; 02321D66
	cmp r0,#0x0	; 02321D68
	beq loc_02321DDA	; 02321D6A
	ldr r0,[pool_02321DF4]	; 02321D6C
	ldr r0,[r0,#0x0]	; 02321D6E
	cmp r0,#0x0	; 02321D70
	beq loc_02321D7C	; 02321D72
	ldr r0,[pool_02321DF8]	; 02321D74
	ldr r0,[r0,#0x0]	; 02321D76
	cmp r0,#0xf	; 02321D78
	bge loc_02321DDA	; 02321D7A
loc_02321D7C:
	ldr r0,[pool_02321DF8]	; 02321D7C
	ldr r1,[r0,#0x0]	; 02321D7E
	add r1,r1,#0x1	; 02321D80
	str r1,[r0,#0x0]	; 02321D82
	lsl r0,r1,#0x4	; 02321D84
	mov r1,#0xf	; 02321D86
	blx P1_SignedDivMod	; 02321D88
	mov r3,#0x10	; 02321D8C
	sub r1,r3,r0	; 02321D8E
	lsl r0,r0,#0x8	; 02321D90
	orr r1,r0	; 02321D92
	ldr r0,[pool_02321DFC]	; 02321D94
	strh r1,[r0,#0x0]	; 02321D96
	ldr r0,[pool_02321DF4]	; 02321D98
	ldr r0,[r0,#0x0]	; 02321D9A
	cmp r0,#0x0	; 02321D9C
	bne loc_02321DDA	; 02321D9E
	ldr r0,[pool_02321DF8]	; 02321DA0
	ldr r0,[r0,#0x0]	; 02321DA2
	cmp r0,#0xf	; 02321DA4
	bne loc_02321DDA	; 02321DA6
	ldr r1,[pool_02321E00]	; 02321DA8
	ldr r4,[r1,#0x0]	; 02321DAA
	mov r0,#0x12	; 02321DAC
	bic r4,r0	; 02321DAE
	str r4,[r1,#0x0]	; 02321DB0
	ldr r1,[pool_02321E04]	; 02321DB2
	ldr r2,[r1,#0x0]	; 02321DB4
	ldr r0,[pool_02321E08]	; 02321DB6
	and r2,r0	; 02321DB8
	lsl r0,r4,#0x8	; 02321DBA
	orr r2,r0	; 02321DBC
	str r2,[r1,#0x0]	; 02321DBE
	mov r0,#0x0	; 02321DC0
	str r0,[sp,#0x0]	; 02321DC2
	ldr r0,[pool_02321E0C]	; 02321DC4
	mov r1,#0x4	; 02321DC6
	mov r2,#0x8	; 02321DC8
	bl loc_0232DBC0	; 02321DCA
	mov r1,#0x0	; 02321DCE
	ldr r0,[pool_02321DF8]	; 02321DD0
	str r1,[r0,#0x0]	; 02321DD2
	mov r1,#0x1	; 02321DD4
	ldr r0,[pool_02321DF4]	; 02321DD6
	str r1,[r0,#0x0]	; 02321DD8
loc_02321DDA:
	bl loc_02323320	; 02321DDA
	bl loc_02322A78	; 02321DDE
	bl loc_023230B0	; 02321DE2
	add sp,#0x8	; 02321DE6
	pop {r4}	; 02321DE8
	pop {r3}	; 02321DEA
	bx r3	; 02321DEC
	.byte 0xC0, 0x46	; 02321DF0
pool_02321DF0:
loc_02321DF0:
	.word P1_BssStart + 0x1384	; 02321DF0
pool_02321DF4:
loc_02321DF4:
	.word P1_BssStart + 0x1380	; 02321DF4
pool_02321DF8:
loc_02321DF8:
	.word P1_BssStart + 0x1378	; 02321DF8
pool_02321DFC:
loc_02321DFC:
	.word REG_BLDALPHA	; 02321DFC
pool_02321E00:
loc_02321E00:
	.word P1_BssStart + 0x1370	; 02321E00
pool_02321E04:
loc_02321E04:
	.word REG_DISPCNT_A	; 02321E04
pool_02321E08:
loc_02321E08:
	.word 0xFFFFE0FF	; 02321E08
pool_02321E0C:
loc_02321E0C:
	.word REG_BLDCNT	; 02321E0C

; ===== function loc_02321E10 =====
loc_02321E10:
	push {lr}	; 02321E10
	sub sp,#0x4	; 02321E12
	mov r0,#0x0	; 02321E14
	str r0,[sp,#0x0]	; 02321E16
	ldr r0,[pool_02321E30]	; 02321E18
	mov r1,#0x12	; 02321E1A
	mov r2,#0x1c	; 02321E1C
	mov r3,#0x10	; 02321E1E
	bl loc_0232DBC0	; 02321E20
	mov r1,#0x1	; 02321E24
	ldr r0,[pool_02321E34]	; 02321E26
	str r1,[r0,#0x0]	; 02321E28
	add sp,#0x4	; 02321E2A
	pop {r3}	; 02321E2C
	bx r3	; 02321E2E
pool_02321E30:
loc_02321E30:
	.word REG_BLDCNT	; 02321E30
pool_02321E34:
loc_02321E34:
	.word P1_BssStart + 0x1384	; 02321E34

; ===== function loc_02321E38 =====
loc_02321E38:
	push {lr}	; 02321E38
	sub sp,#0x4	; 02321E3A
	mov r1,#0x1	; 02321E3C
	ldr r0,[pool_02321E70]	; 02321E3E
	str r1,[r0,#0x0]	; 02321E40
	mov r1,#0x0	; 02321E42
	ldr r0,[pool_02321E74]	; 02321E44
	str r1,[r0,#0x0]	; 02321E46
	bl loc_02321F58	; 02321E48
	bl loc_02323350	; 02321E4C
	bl loc_023230D0	; 02321E50
	bl loc_02322CB0	; 02321E54
	bl loc_023235C8	; 02321E58
	ldr r0,[pool_02321E78]	; 02321E5C
	bl loc_02322878	; 02321E5E
	mov r1,#0x0	; 02321E62
	ldr r0,[pool_02321E7C]	; 02321E64
	str r1,[r0,#0x8]	; 02321E66
	add sp,#0x4	; 02321E68
	pop {r3}	; 02321E6A
	bx r3	; 02321E6C
	.byte 0xC0, 0x46	; 02321E70
pool_02321E70:
loc_02321E70:
	.word P1_BssStart + 0x137C	; 02321E70
pool_02321E74:
loc_02321E74:
	.word P1_BssStart + 0x1374	; 02321E74
pool_02321E78:
loc_02321E78:
	.word 0x02332208	; 02321E78
pool_02321E7C:
loc_02321E7C:
	.word P1_BssStart + 0x1444	; 02321E7C

; ===== function loc_02321E80 =====
loc_02321E80:
	push {lr}	; 02321E80
	sub sp,#0x4	; 02321E82
	ldr r1,[pool_02321EC0]	; 02321E84
	ldr r2,[r1,#0x0]	; 02321E86
	mov r0,#0xe	; 02321E88
	mul r2,r0	; 02321E8A
	ldr r0,[pool_02321EC4]	; 02321E8C
	ldrh r0,[r0,r2]	; 02321E8E
	cmp r0,#0x0	; 02321E90
	bne loc_02321E98	; 02321E92
	mov r0,#0x0	; 02321E94
	b loc_02321EBA	; 02321E96
loc_02321E98:
	cmp r0,#0x2	; 02321E98
	blt loc_02321EA2	; 02321E9A
	mov r0,#0xf	; 02321E9C
	mvn r0,r0	; 02321E9E
	b loc_02321EBA	; 02321EA0
loc_02321EA2:
	mov r0,#0x6	; 02321EA2
	ldrsh r0,[r1,r0]	; 02321EA4
	lsl r0,r0,#0x6	; 02321EA6
	mov r1,#0xf	; 02321EA8
	blx P1_SignedDivMod	; 02321EAA
	sub r0,#0x30	; 02321EAE
	cmp r0,#0x0	; 02321EB0
	ble loc_02321EB8	; 02321EB2
	neg r0,r0	; 02321EB4
	b loc_02321EBA	; 02321EB6
loc_02321EB8:
	mov r0,#0x0	; 02321EB8
loc_02321EBA:
	add sp,#0x4	; 02321EBA
	pop {r3}	; 02321EBC
	bx r3	; 02321EBE
pool_02321EC0:
loc_02321EC0:
	.word P1_BssStart + 0x1444	; 02321EC0
pool_02321EC4:
loc_02321EC4:
	.word P1_Data_02330704	; 02321EC4

; ===== function loc_02321EC8 =====
P1_Entry_02321EC8:
	push {r4,lr}	; 02321EC8
	sub sp,#0x128	; 02321ECA
	add r4,r0,#0x0	; 02321ECC
	cmp r4,#0x0	; 02321ECE
	beq loc_02321F30	; 02321ED0
	add r0,sp,#0x0	; 02321ED2
	ldr r1,[pool_02321F3C]	; 02321ED4
	add r1,r4,r1	; 02321ED6
	mov r2,#0x30	; 02321ED8
	bl P1_Utf16StrNCpy	; 02321EDA
	mov r1,#0x0	; 02321EDE
	add r0,sp,#0x40	; 02321EE0
	strh r1,[r0,#0x20]	; 02321EE2
	add r0,sp,#0x60	; 02321EE4
	add r0,#0x2	; 02321EE6
	ldr r1,[pool_02321F40]	; 02321EE8
	add r1,r4,r1	; 02321EEA
	mov r2,#0x60	; 02321EEC
	bl P1_Utf16StrNCpy	; 02321EEE
	mov r1,#0x0	; 02321EF2
	add r0,sp,#0x120	; 02321EF4
	add r0,#0x2	; 02321EF6
	strh r1,[r0,#0x0]	; 02321EF8
	mov r0,#0x11	; 02321EFA
	bl loc_0232212C	; 02321EFC
	ldr r0,[pool_02321F44]	; 02321F00
	add r1,sp,#0x0	; 02321F02
	bl loc_02324A80	; 02321F04
	ldr r0,[pool_02321F48]	; 02321F08
	add r1,sp,#0x60	; 02321F0A
	add r1,#0x2	; 02321F0C
	bl loc_02324A80	; 02321F0E
	add r0,r4,#0x0	; 02321F12
	add r0,#0x20	; 02321F14
	ldr r1,[pool_02321F4C]	; 02321F16
	ldr r2,[pool_02321F50]	; 02321F18
	bl loc_0232E020	; 02321F1A
	add r0,r4,#0x0	; 02321F1E
	ldr r1,[pool_02321F54]	; 02321F20
	mov r2,#0x20	; 02321F22
	bl loc_0232E114	; 02321F24
	add r0,r4,#0x0	; 02321F28
	bl loc_02323538	; 02321F2A
	b loc_02321F34	; 02321F2E
loc_02321F30:
	bl loc_0232352C	; 02321F30
loc_02321F34:
	add sp,#0x128	; 02321F34
	pop {r4}	; 02321F36
	pop {r3}	; 02321F38
	bx r3	; 02321F3A
pool_02321F3C:
loc_02321F3C:
	.word 0x00000238	; 02321F3C
pool_02321F40:
loc_02321F40:
	.word 0x00000298	; 02321F40
pool_02321F44:
loc_02321F44:
	.word 0x023322FC	; 02321F44
pool_02321F48:
loc_02321F48:
	.word 0x02332380	; 02321F48
pool_02321F4C:
loc_02321F4C:
	.word 0x0001EE00	; 02321F4C
pool_02321F50:
loc_02321F50:
	.word 0x00000200	; 02321F50
pool_02321F54:
loc_02321F54:
	.word 0x00000140	; 02321F54

; ===== function loc_02321F58 =====
loc_02321F58:
	push {r4,r5,r6,r7,lr}	; 02321F58
	sub sp,#0x4	; 02321F5A
	ldr r0,[pool_023220AC]	; 02321F5C
	ldrb r0,[r0,#0x0]	; 02321F5E
	lsl r0,r0,#0x1c	; 02321F60
	lsr r7,r0,#0x1c	; 02321F62
	mov r1,#0x1f	; 02321F64
	ldr r0,[pool_023220B0]	; 02321F66
	str r1,[r0,#0x0]	; 02321F68
	ldr r2,[pool_023220B4]	; 02321F6A
	ldr r3,[r2,#0x0]	; 02321F6C
	ldr r0,[pool_023220B8]	; 02321F6E
	and r3,r0	; 02321F70
	ldr r0,[pool_023220BC]	; 02321F72
	orr r3,r0	; 02321F74
	str r3,[r2,#0x0]	; 02321F76
	ldr r0,[pool_023220C0]	; 02321F78
	mov r2,#0x10	; 02321F7A
	bl loc_0232DBA4	; 02321F7C
	ldr r5,[pool_023220C4]	; 02321F80
	ldrh r2,[r5,#0x0]	; 02321F82
	mov r0,#0x43	; 02321F84
	and r2,r0	; 02321F86
	mov r1,#0x10	; 02321F88
	orr r2,r1	; 02321F8A
	strh r2,[r5,#0x0]	; 02321F8C
	ldr r4,[pool_023220C8]	; 02321F8E
	ldrh r2,[r4,#0x0]	; 02321F90
	and r2,r0	; 02321F92
	ldr r1,[pool_023220CC]	; 02321F94
	orr r2,r1	; 02321F96
	strh r2,[r4,#0x0]	; 02321F98
	ldr r3,[pool_023220D0]	; 02321F9A
	ldrh r2,[r3,#0x0]	; 02321F9C
	and r2,r0	; 02321F9E
	ldr r1,[pool_023220D4]	; 02321FA0
	orr r2,r1	; 02321FA2
	strh r2,[r3,#0x0]	; 02321FA4
	ldr r1,[pool_023220D8]	; 02321FA6
	ldrh r2,[r1,#0x0]	; 02321FA8
	and r2,r0	; 02321FAA
	ldr r0,[pool_023220DC]	; 02321FAC
	orr r2,r0	; 02321FAE
	strh r2,[r1,#0x0]	; 02321FB0
	ldrh r2,[r5,#0x0]	; 02321FB2
	mov r0,#0x3	; 02321FB4
	bic r2,r0	; 02321FB6
	strh r2,[r5,#0x0]	; 02321FB8
	ldrh r2,[r4,#0x0]	; 02321FBA
	bic r2,r0	; 02321FBC
	strh r2,[r4,#0x0]	; 02321FBE
	ldrh r2,[r3,#0x0]	; 02321FC0
	bic r2,r0	; 02321FC2
	orr r2,r0	; 02321FC4
	strh r2,[r3,#0x0]	; 02321FC6
	ldrh r2,[r1,#0x0]	; 02321FC8
	bic r2,r0	; 02321FCA
	orr r2,r0	; 02321FCC
	strh r2,[r1,#0x0]	; 02321FCE
	mov r1,#0x0	; 02321FD0
	ldr r0,[pool_023220E0]	; 02321FD2
	str r1,[r0,#0x0]	; 02321FD4
	ldr r0,[pool_023220E4]	; 02321FD6
	str r1,[r0,#0x0]	; 02321FD8
	ldr r0,[pool_023220E8]	; 02321FDA
	str r1,[r0,#0x0]	; 02321FDC
	ldr r0,[pool_023220EC]	; 02321FDE
	str r1,[r0,#0x0]	; 02321FE0
	bl P1_GetMainBg1TilemapBase	; 02321FE2
	add r5,r0,#0x0	; 02321FE6
	mov r3,#0x0	; 02321FE8
	str r3,[sp,#0x0]	; 02321FEA
loc_02321FEC:
	ldr r4,[sp,#0x0]	; 02321FEC
	lsl r2,r3,#0x5	; 02321FEE
	lsl r0,r3,#0x6	; 02321FF0
	add r1,r5,r0	; 02321FF2
loc_02321FF4:
	add r0,r4,r2	; 02321FF4
	ldr r6,[pool_023220F0]	; 02321FF6
	orr r0,r6	; 02321FF8
	lsl r6,r4,#0x1	; 02321FFA
	strh r0,[r1,r6]	; 02321FFC
	add r4,r4,#0x1	; 02321FFE
	cmp r4,#0x20	; 02322000
	blt loc_02321FF4	; 02322002
	add r3,r3,#0x1	; 02322004
	cmp r3,#0x18	; 02322006
	blt loc_02321FEC	; 02322008
	bl P1_GetMainBg1CharacterBase	; 0232200A
	add r1,r0,#0x0	; 0232200E
	mov r0,#0x3	; 02322010
	mov r2,#0x0	; 02322012
	ldr r3,[pool_023220F4]	; 02322014
	bl loc_0232E298	; 02322016
	ldr r0,[pool_023220F8]	; 0232201A
	mov r1,#0x0	; 0232201C
	ldr r2,[pool_023220FC]	; 0232201E
	sub r2,r2,r0	; 02322020
	bl loc_0232DCA0	; 02322022
	ldr r0,[pool_02322100]	; 02322026
	mov r1,#0x0	; 02322028
	ldr r2,[pool_02322104]	; 0232202A
	sub r2,r2,r0	; 0232202C
	bl loc_0232E18C	; 0232202E
	mov r1,#0x0	; 02322032
	ldr r0,[pool_02322108]	; 02322034
	strh r1,[r0,#0x0]	; 02322036
	mov r1,#0x2	; 02322038
	blx P1_CleanDataCacheRange	; 0232203A
	ldr r0,[pool_02322108]	; 0232203E
	mov r1,#0x0	; 02322040
	mov r2,#0x2	; 02322042
	bl loc_0232E18C	; 02322044
	ldr r1,[pool_0232210C]	; 02322048
	lsl r0,r7,#0x5	; 0232204A
	add r5,r1,r0	; 0232204C
	add r0,r5,#0x0	; 0232204E
	ldr r1,[pool_02322110]	; 02322050
	mov r2,#0x20	; 02322052
	bl loc_0232E18C	; 02322054
	ldr r0,[pool_02322114]	; 02322058
	mov r1,#0x0	; 0232205A
	ldr r2,[pool_02322118]	; 0232205C
	sub r2,r2,r0	; 0232205E
	bl loc_0232DEA0	; 02322060
	ldr r0,[pool_0232211C]	; 02322064
	mov r1,#0x0	; 02322066
	ldr r2,[pool_02322120]	; 02322068
	sub r2,r2,r0	; 0232206A
	bl loc_0232DE20	; 0232206C
	bl loc_02323DC0	; 02322070
	bl loc_02323F90	; 02322074
	bl loc_02323DC0	; 02322078
	ldr r1,[pool_02322124]	; 0232207C
	bl loc_02323EFC	; 0232207E
	bl loc_02324BC4	; 02322082
	add r4,r0,#0x0	; 02322086
	bl loc_02323DC0	; 02322088
	add r2,r0,#0x0	; 0232208C
	add r0,r4,#0x0	; 0232208E
	ldr r1,[pool_02322128]	; 02322090
	ldr r1,[r2,r1]	; 02322092
	bl loc_02324B68	; 02322094
	add r0,r5,#0x0	; 02322098
	ldr r1,[pool_02322110]	; 0232209A
	mov r2,#0x20	; 0232209C
	bl loc_0232E114	; 0232209E
	add sp,#0x4	; 023220A2
	pop {r4,r5,r6,r7}	; 023220A4
	pop {r3}	; 023220A6
	bx r3	; 023220A8
	.byte 0xC0, 0x46	; 023220AC
pool_023220AC:
loc_023220AC:
	.word FirmwareUserSettingsSharedAddress + UserSettingsThemeOffset	; 023220AC
pool_023220B0:
loc_023220B0:
	.word P1_BssStart + 0x1370	; 023220B0
pool_023220B4:
loc_023220B4:
	.word REG_DISPCNT_A	; 023220B4
pool_023220B8:
loc_023220B8:
	.word 0xFFFFE0FF	; 023220B8
pool_023220BC:
loc_023220BC:
	.word 0x00001F00	; 023220BC
pool_023220C0:
loc_023220C0:
	.word REG_BLDCNT	; 023220C0
pool_023220C4:
loc_023220C4:
	.word REG_BG0CNT	; 023220C4
pool_023220C8:
loc_023220C8:
	.word REG_BG1CNT	; 023220C8
pool_023220CC:
loc_023220CC:
	.word 0x00000D08	; 023220CC
pool_023220D0:
loc_023220D0:
	.word REG_BG2CNT	; 023220D0
pool_023220D4:
loc_023220D4:
	.word 0x00000E10	; 023220D4
pool_023220D8:
loc_023220D8:
	.word REG_BG3CNT	; 023220D8
pool_023220DC:
loc_023220DC:
	.word 0x00000F10	; 023220DC
pool_023220E0:
loc_023220E0:
	.word REG_BG0HOFS	; 023220E0
pool_023220E4:
loc_023220E4:
	.word REG_BG1HOFS	; 023220E4
pool_023220E8:
loc_023220E8:
	.word REG_BG2HOFS	; 023220E8
pool_023220EC:
loc_023220EC:
	.word REG_BG3HOFS	; 023220EC
pool_023220F0:
loc_023220F0:
	.word 0x00003000	; 023220F0
pool_023220F4:
loc_023220F4:
	.word 0x00008000	; 023220F4
pool_023220F8:
loc_023220F8:
	.word 0x023A8D60	; 023220F8
pool_023220FC:
loc_023220FC:
	.word 0x023AA960	; 023220FC
pool_02322100:
loc_02322100:
	.word 0x023B64E0	; 02322100
pool_02322104:
loc_02322104:
	.word 0x023B66E0	; 02322104
pool_02322108:
loc_02322108:
	.word P1_BssStart + 0x136C	; 02322108
pool_0232210C:
loc_0232210C:
	.word 0x023B70E0	; 0232210C
pool_02322110:
loc_02322110:
	.word 0x000001E0	; 02322110
pool_02322114:
loc_02322114:
	.word 0x023B2CE0	; 02322114
pool_02322118:
loc_02322118:
	.word 0x023B34E0	; 02322118
pool_0232211C:
loc_0232211C:
	.word 0x023B14E0	; 0232211C
pool_02322120:
loc_02322120:
	.word 0x023B1CE0	; 02322120
pool_02322124:
loc_02322124:
	.word 0x023BB898	; 02322124
pool_02322128:
loc_02322128:
	.word 0x0000062C	; 02322128

; ===== function loc_0232212C =====
loc_0232212C:
	push {r4,r5,r6,lr}	; 0232212C
	add r6,r0,#0x0	; 0232212E
	mov r0,#0xe	; 02322130
	add r4,r6,#0x0	; 02322132
	mul r4,r0	; 02322134
	ldr r5,[pool_02322188]	; 02322136
	ldrh r3,[r5,r4]	; 02322138
	ldr r1,[pool_0232218C]	; 0232213A
	ldr r2,[r1,#0x0]	; 0232213C
	mul r2,r0	; 0232213E
	ldrh r0,[r5,r2]	; 02322140
	cmp r3,r0	; 02322142
	bcc loc_02322176	; 02322144
	sub r5,r3,#0x1	; 02322146
	mov r0,#0x2c	; 02322148
	mul r5,r0	; 0232214A
	ldr r0,[pool_02322190]	; 0232214C
	add r0,r0,r5	; 0232214E
	ldr r1,[pool_02322194]	; 02322150
	ldr r2,[pool_02322198]	; 02322152
	ldrh r2,[r2,r4]	; 02322154
	bl loc_02324ADC	; 02322156
	ldr r0,[pool_0232219C]	; 0232215A
	add r0,r0,r5	; 0232215C
	ldr r1,[pool_02322194]	; 0232215E
	ldr r2,[pool_023221A0]	; 02322160
	ldrh r2,[r2,r4]	; 02322162
	bl loc_02324ADC	; 02322164
	ldr r0,[pool_0232218C]	; 02322168
	str r6,[r0,#0x0]	; 0232216A
	mov r1,#0x0	; 0232216C
	strh r1,[r0,#0x6]	; 0232216E
	mov r1,#0x1	; 02322170
	strh r1,[r0,#0x4]	; 02322172
	b loc_02322180	; 02322174
loc_02322176:
	mov r0,#0xf	; 02322176
	strh r0,[r1,#0x6]	; 02322178
	mov r0,#0x0	; 0232217A
	mvn r0,r0	; 0232217C
	strh r0,[r1,#0x4]	; 0232217E
loc_02322180:
	pop {r4,r5,r6}	; 02322180
	pop {r3}	; 02322182
	bx r3	; 02322184
	.byte 0xC0, 0x46	; 02322188
pool_02322188:
loc_02322188:
	.word P1_Data_02330704	; 02322188
pool_0232218C:
loc_0232218C:
	.word P1_BssStart + 0x1444	; 0232218C
pool_02322190:
loc_02322190:
	.word 0x023322D0	; 02322190
pool_02322194:
loc_02322194:
	.word 0x023A0894	; 02322194
pool_02322198:
loc_02322198:
	.word P1_Data_02330706	; 02322198
pool_0232219C:
loc_0232219C:
	.word 0x02332354	; 0232219C
pool_023221A0:
loc_023221A0:
	.word P1_Data_02330708	; 023221A0

; ===== function loc_023221A4 =====
loc_023221A4:
	push {r4,r5,r6,r7,lr}	; 023221A4
	sub sp,#0x4	; 023221A6
	mov r5,#0x0	; 023221A8
	ldr r7,[pool_023221F4]	; 023221AA
	b loc_023221DA	; 023221AC
loc_023221AE:
	lsl r0,r5,#0x1	; 023221AE
	add r0,r2,r0	; 023221B0
	ldrh r1,[r0,#0x6]	; 023221B2
	mov r0,#0xe	; 023221B4
	mul r1,r0	; 023221B6
	add r4,r7,r1	; 023221B8
	add r6,r5,#0x0	; 023221BA
	mov r0,#0x2c	; 023221BC
	mul r6,r0	; 023221BE
	ldr r0,[pool_023221F8]	; 023221C0
	add r0,r0,r6	; 023221C2
	ldr r1,[pool_023221FC]	; 023221C4
	ldrh r2,[r4,#0x2]	; 023221C6
	bl loc_02324ADC	; 023221C8
	ldr r0,[pool_02322200]	; 023221CC
	add r0,r0,r6	; 023221CE
	ldr r1,[pool_023221FC]	; 023221D0
	ldrh r2,[r4,#0x4]	; 023221D2
	bl loc_02324ADC	; 023221D4
	add r5,r5,#0x1	; 023221D8
loc_023221DA:
	ldr r0,[pool_02322204]	; 023221DA
	ldr r1,[r0,#0x0]	; 023221DC
	mov r0,#0xe	; 023221DE
	mul r1,r0	; 023221E0
	add r2,r7,r1	; 023221E2
	ldrh r0,[r7,r1]	; 023221E4
	cmp r5,r0	; 023221E6
	blt loc_023221AE	; 023221E8
	add sp,#0x4	; 023221EA
	pop {r4,r5,r6,r7}	; 023221EC
	pop {r3}	; 023221EE
	bx r3	; 023221F0
	.byte 0xC0, 0x46	; 023221F4
pool_023221F4:
loc_023221F4:
	.word 0x02330704	; 023221F4
pool_023221F8:
loc_023221F8:
	.word 0x023322D0	; 023221F8
pool_023221FC:
loc_023221FC:
	.word 0x023A0894	; 023221FC
pool_02322200:
loc_02322200:
	.word 0x02332354	; 02322200
pool_02322204:
loc_02322204:
	.word P1_BssStart + 0x1444	; 02322204

; ===== function loc_02322208 =====
loc_02322208:
	push {r4,r5,r6,r7,lr}	; 02322208
	sub sp,#0x24	; 0232220A
	ldr r2,[pool_023223F8]	; 0232220C
	ldr r0,[r2,#0x8]	; 0232220E
	cmp r0,#0x0	; 02322210
	bne loc_02322216	; 02322212
	b loc_023223EE	; 02322214
loc_02322216:
	mov r0,#0x6	; 02322216
	ldrsh r3,[r2,r0]	; 02322218
	mov r1,#0x4	; 0232221A
	ldrsh r1,[r2,r1]	; 0232221C
	add r3,r3,r1	; 0232221E
	strh r3,[r2,#0x6]	; 02322220
	cmp r1,#0x1	; 02322222
	bne loc_02322230	; 02322224
	ldrsh r0,[r2,r0]	; 02322226
	cmp r0,#0xf	; 02322228
	bne loc_02322230	; 0232222A
	mov r0,#0x0	; 0232222C
	strh r0,[r2,#0x4]	; 0232222E
loc_02322230:
	ldr r0,[pool_023223F8]	; 02322230
	mov r1,#0x4	; 02322232
	ldrsh r3,[r0,r1]	; 02322234
	mov r2,#0x0	; 02322236
	mvn r1,r2	; 02322238
	cmp r3,r1	; 0232223A
	bne loc_0232226A	; 0232223C
	mov r1,#0x6	; 0232223E
	ldrsh r1,[r0,r1]	; 02322240
	cmp r1,#0x0	; 02322242
	bne loc_0232226A	; 02322244
	strh r2,[r0,#0x4]	; 02322246
	ldr r1,[r0,#0x0]	; 02322248
	mov r3,#0xe	; 0232224A
	mul r1,r3	; 0232224C
	ldr r3,[pool_023223FC]	; 0232224E
	ldrh r4,[r3,r1]	; 02322250
	cmp r4,#0x1	; 02322252
	bne loc_0232225A	; 02322254
	str r2,[r0,#0x0]	; 02322256
	b loc_0232226A	; 02322258
loc_0232225A:
	mov r2,#0xf	; 0232225A
	strh r2,[r0,#0x6]	; 0232225C
	ldr r3,[pool_02322400]	; 0232225E
	sub r2,r4,#0x2	; 02322260
	lsl r2,r2,#0x1	; 02322262
	add r1,r3,r1	; 02322264
	ldrh r1,[r2,r1]	; 02322266
	str r1,[r0,#0x0]	; 02322268
loc_0232226A:
	bl loc_02323DC0	; 0232226A
	str r0,[sp,#0xc]	; 0232226E
	ldr r0,[pool_023223F8]	; 02322270
	ldr r1,[r0,#0x0]	; 02322272
	mov r0,#0xe	; 02322274
	mul r1,r0	; 02322276
	ldr r0,[pool_023223FC]	; 02322278
	ldrh r5,[r0,r1]	; 0232227A
	b loc_023223E8	; 0232227C
loc_0232227E:
	sub r7,r5,#0x1	; 0232227E
	ldr r0,[pool_023223F8]	; 02322280
	ldr r1,[r0,#0x0]	; 02322282
	mov r0,#0xe	; 02322284
	mul r1,r0	; 02322286
	ldr r0,[pool_023223FC]	; 02322288
	ldrh r0,[r0,r1]	; 0232228A
	sub r0,r0,r5	; 0232228C
	str r0,[sp,#0x10]	; 0232228E
	neg r0,r0	; 02322290
	lsl r6,r0,#0x4	; 02322292
	ldr r1,[pool_023223F8]	; 02322294
	mov r0,#0x6	; 02322296
	ldrsh r0,[r1,r0]	; 02322298
	lsl r0,r0,#0x6	; 0232229A
	mov r1,#0xf	; 0232229C
	blx P1_SignedDivMod	; 0232229E
	add r1,r6,#0x0	; 023222A2
	add r1,#0x40	; 023222A4
	sub r0,r1,r0	; 023222A6
	lsl r0,r0,#0x10	; 023222A8
	asr r4,r0,#0x10	; 023222AA
	ldr r0,[sp,#0x10]	; 023222AC
	cmp r0,#0x0	; 023222AE
	ble loc_023222BA	; 023222B0
	add r6,#0x10	; 023222B2
	cmp r4,r6	; 023222B4
	blt loc_023222BA	; 023222B6
	add r4,r6,#0x0	; 023222B8
loc_023222BA:
	bl loc_023235AC	; 023222BA
	sub r4,r4,r0	; 023222BE
	lsl r0,r4,#0x10	; 023222C0
	asr r6,r0,#0x10	; 023222C2
	add r1,r7,#0x0	; 023222C4
	str r1,[sp,#0x18]	; 023222C6
	mov r0,#0x2c	; 023222C8
	mul r1,r0	; 023222CA
	str r1,[sp,#0x18]	; 023222CC
	mov r0,#0x1	; 023222CE
	str r0,[sp,#0x0]	; 023222D0
	ldr r1,[pool_02322404]	; 023222D2
	ldr r0,[sp,#0x18]	; 023222D4
	add r0,r1,r0	; 023222D6
	mov r1,#0x0	; 023222D8
	add r2,r6,#0x0	; 023222DA
	lsl r3,r1,#0	; 023222DC
	bl loc_023236B8	; 023222DE
	mov r0,#0x1	; 023222E2
	str r0,[sp,#0x0]	; 023222E4
	ldr r1,[pool_02322408]	; 023222E6
	ldr r0,[sp,#0x18]	; 023222E8
	add r0,r1,r0	; 023222EA
	mov r1,#0x0	; 023222EC
	add r2,r6,#0x0	; 023222EE
	lsl r3,r1,#0	; 023222F0
	bl loc_023236B8	; 023222F2
	ldr r0,[pool_023223F8]	; 023222F6
	ldr r0,[r0,#0x0]	; 023222F8
	mov r1,#0xe	; 023222FA
	mul r0,r1	; 023222FC
	lsl r2,r7,#0x1	; 023222FE
	ldr r1,[pool_023223FC]	; 02322300
	add r0,r1,r0	; 02322302
	add r0,r2,r0	; 02322304
	ldrh r3,[r0,#0x6]	; 02322306
	cmp r3,#0x11	; 02322308
	bne loc_02322396	; 0232230A
	ldr r0,[pool_0232240C]	; 0232230C
	mov r1,#0x0	; 0232230E
	bl loc_02328E38	; 02322310
	add r6,r0,#0x0	; 02322314
	bl P3_Entry_02367C38	; 02322316
	cmp r0,#0x3	; 0232231A
	bhi loc_0232234A	; 0232231C
	add r0,r0,r0	; 0232231E
P1_SwitchIndexPC_0232231E:
	add r0,pc	; 02322320
	ldrh r0,[r0,#(P1_SwitchTable_0232231E - (P1_SwitchIndexPC_0232231E + 4))]	; 02322322
	lsl r0,r0,#0x10	; 02322324
	asr r0,r0,#0x10	; 02322326
P1_SwitchTargetPC_0232231E:
	add r0,pc	; 02322328
	bx r0	; 0232232A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232231E:
	.halfword (loc_02322334 + 1) - (P1_SwitchTargetPC_0232231E + 4)
	.halfword (loc_0232233A + 1) - (P1_SwitchTargetPC_0232231E + 4)
	.halfword (loc_02322340 + 1) - (P1_SwitchTargetPC_0232231E + 4)
	.halfword (loc_02322346 + 1) - (P1_SwitchTargetPC_0232231E + 4)
P1_SwitchTable_0232231EEnd:
loc_02322334:
	mov r0,#0x13	; 02322334
	str r0,[sp,#0x14]	; 02322336
	b loc_0232234A	; 02322338
loc_0232233A:
	mov r0,#0x14	; 0232233A
	str r0,[sp,#0x14]	; 0232233C
	b loc_0232234A	; 0232233E
loc_02322340:
	mov r0,#0x15	; 02322340
	str r0,[sp,#0x14]	; 02322342
	b loc_0232234A	; 02322344
loc_02322346:
	mov r0,#0x16	; 02322346
	str r0,[sp,#0x14]	; 02322348
loc_0232234A:
	bl loc_02323DC0	; 0232234A
	mov r1,#0x0	; 0232234E
	str r1,[sp,#0x0]	; 02322350
	str r4,[sp,#0x4]	; 02322352
	ldr r1,[pool_02322410]	; 02322354
	ldr r2,[pool_02322414]	; 02322356
	ldr r3,[sp,#0x14]	; 02322358
	bl loc_02323B78	; 0232235A
	mov r0,#0x0	; 0232235E
	ldrsh r0,[r6,r0]	; 02322360
	lsl r0,r0,#0x14	; 02322362
	asr r1,r0,#0x14	; 02322364
	ldr r0,[pool_02322418]	; 02322366
	and r1,r0	; 02322368
	lsl r0,r1,#0x10	; 0232236A
	mov r1,#0x2	; 0232236C
	ldrsh r1,[r6,r1]	; 0232236E
	lsl r1,r1,#0x14	; 02322370
	asr r1,r1,#0x14	; 02322372
	add r2,r1,r4	; 02322374
	mov r1,#0xff	; 02322376
	and r2,r1	; 02322378
	ldr r1,[pool_0232241C]	; 0232237A
	orr r2,r1	; 0232237C
	orr r0,r2	; 0232237E
	str r0,[sp,#0x1c]	; 02322380
	ldr r1,[pool_02322420]	; 02322382
	add r0,sp,#0x1c	; 02322384
	strh r1,[r0,#0x4]	; 02322386
	bl loc_02323DC0	; 02322388
	add r1,sp,#0x1c	; 0232238C
	mov r2,#0x0	; 0232238E
	bl loc_023238D8	; 02322390
	b loc_023223D4	; 02322394
loc_02322396:
	add r1,r3,#0x0	; 02322396
	mov r0,#0xe	; 02322398
	mul r1,r0	; 0232239A
	ldr r0,[pool_023223FC]	; 0232239C
	add r1,r0,r1	; 0232239E
	mov r0,#0xc	; 023223A0
	ldrsh r0,[r1,r0]	; 023223A2
	mov r1,#0x0	; 023223A4
	mvn r1,r1	; 023223A6
	cmp r0,r1	; 023223A8
	bne loc_023223C0	; 023223AA
	mov r0,#0x0	; 023223AC
	str r0,[sp,#0x0]	; 023223AE
	str r4,[sp,#0x4]	; 023223B0
	ldr r0,[sp,#0xc]	; 023223B2
	ldr r1,[pool_02322410]	; 023223B4
	ldr r2,[pool_02322414]	; 023223B6
	sub r3,r3,#0x1	; 023223B8
	bl loc_02323B78	; 023223BA
	b loc_023223D4	; 023223BE
loc_023223C0:
	mov r1,#0x0	; 023223C0
	str r1,[sp,#0x0]	; 023223C2
	str r4,[sp,#0x4]	; 023223C4
	str r0,[sp,#0x8]	; 023223C6
	ldr r0,[sp,#0xc]	; 023223C8
	ldr r1,[pool_02322410]	; 023223CA
	ldr r2,[pool_02322414]	; 023223CC
	sub r3,r3,#0x1	; 023223CE
	bl loc_02323B24	; 023223D0
loc_023223D4:
	mov r0,#0x0	; 023223D4
	str r0,[sp,#0x0]	; 023223D6
	str r4,[sp,#0x4]	; 023223D8
	ldr r0,[sp,#0xc]	; 023223DA
	ldr r1,[pool_02322410]	; 023223DC
	ldr r2,[pool_02322414]	; 023223DE
	mov r3,#0x10	; 023223E0
	bl loc_02323B78	; 023223E2
	sub r5,r5,#0x1	; 023223E6
loc_023223E8:
	cmp r5,#0x0	; 023223E8
	ble loc_023223EE	; 023223EA
	b loc_0232227E	; 023223EC
loc_023223EE:
	add sp,#0x24	; 023223EE
	pop {r4,r5,r6,r7}	; 023223F0
	pop {r3}	; 023223F2
	bx r3	; 023223F4
	.byte 0xC0, 0x46	; 023223F8
pool_023223F8:
loc_023223F8:
	.word P1_BssStart + 0x1444	; 023223F8
pool_023223FC:
loc_023223FC:
	.word P1_Data_02330704	; 023223FC
pool_02322400:
loc_02322400:
	.word 0x0233070A	; 02322400
pool_02322404:
loc_02322404:
	.word 0x023322D0	; 02322404
pool_02322408:
loc_02322408:
	.word 0x02332354	; 02322408
pool_0232240C:
loc_0232240C:
	.word 0x0239F2E8	; 0232240C
pool_02322410:
loc_02322410:
	.word 0x023BB898	; 02322410
pool_02322414:
loc_02322414:
	.word 0x0239F98C	; 02322414
pool_02322418:
loc_02322418:
	.word 0x000001FF	; 02322418
pool_0232241C:
loc_0232241C:
	.word 0x80000000	; 0232241C
pool_02322420:
loc_02322420:
	.word 0x0000A3DC	; 02322420

; ===== function loc_02322424 =====
P1_Entry_02322424:
	push {r4,r5,r6,r7,lr}	; 02322424
	sub sp,#0x4	; 02322426
	mov r1,#0x1	; 02322428
	ldr r0,[pool_0232246C]	; 0232242A
	str r1,[r0,#0x8]	; 0232242C
	mov r5,#0x0	; 0232242E
	str r5,[r0,#0x0]	; 02322430
	strh r5,[r0,#0x4]	; 02322432
	strh r5,[r0,#0x6]	; 02322434
	ldr r6,[pool_02322470]	; 02322436
	ldr r7,[pool_02322474]	; 02322438
loc_0232243A:
	add r4,r5,#0x0	; 0232243A
	mov r0,#0x2c	; 0232243C
	mul r4,r0	; 0232243E
	bl loc_02324BC4	; 02322440
	add r1,r6,r4	; 02322444
	ldr r2,[pool_02322478]	; 02322446
	mov r3,#0x95	; 02322448
	bl loc_02324B34	; 0232244A
	bl loc_02324BC4	; 0232244E
	add r1,r7,r4	; 02322452
	ldr r2,[pool_02322478]	; 02322454
	mov r3,#0x7f	; 02322456
	bl loc_02324B34	; 02322458
	add r5,r5,#0x1	; 0232245C
	cmp r5,#0x3	; 0232245E
	blt loc_0232243A	; 02322460
	add sp,#0x4	; 02322462
	pop {r4,r5,r6,r7}	; 02322464
	pop {r3}	; 02322466
	bx r3	; 02322468
	.byte 0xC0, 0x46	; 0232246C
pool_0232246C:
loc_0232246C:
	.word P1_BssStart + 0x1444	; 0232246C
pool_02322470:
loc_02322470:
	.word 0x023322D0	; 02322470
pool_02322474:
loc_02322474:
	.word 0x02332354	; 02322474
pool_02322478:
loc_02322478:
	.word 0x023A0894	; 02322478

; ===== function loc_0232247C =====
loc_0232247C:
	ldr r0,[pool_023224CC]	; 0232247C
	ldr r0,[r0,#0x0]	; 0232247E
	cmp r0,#0x5	; 02322480
	bhi loc_023224C6	; 02322482
	add r0,r0,r0	; 02322484
P1_SwitchIndexPC_02322484:
	add r0,pc	; 02322486
	ldrh r0,[r0,#(P1_SwitchTable_02322484 - (P1_SwitchIndexPC_02322484 + 4))]	; 02322488
	lsl r0,r0,#0x10	; 0232248A
	asr r0,r0,#0x10	; 0232248C
P1_SwitchTargetPC_02322484:
	add r0,pc	; 0232248E
	bx r0	; 02322490
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02322484:
	.halfword (loc_0232249E + 1) - (P1_SwitchTargetPC_02322484 + 4)
	.halfword (loc_023224A2 + 1) - (P1_SwitchTargetPC_02322484 + 4)
	.halfword (loc_023224AA + 1) - (P1_SwitchTargetPC_02322484 + 4)
	.halfword (loc_023224B2 + 1) - (P1_SwitchTargetPC_02322484 + 4)
	.halfword (loc_023224B6 + 1) - (P1_SwitchTargetPC_02322484 + 4)
	.halfword (loc_023224BE + 1) - (P1_SwitchTargetPC_02322484 + 4)
P1_SwitchTable_02322484End:
loc_0232249E:
	mov r0,#0x0	; 0232249E
	bx lr	; 023224A0
loc_023224A2:
	ldr r0,[pool_023224D0]	; 023224A2
	ldr r0,[r0,#0x38]	; 023224A4
	neg r0,r0	; 023224A6
	bx lr	; 023224A8
loc_023224AA:
	ldr r0,[pool_023224D0]	; 023224AA
	ldr r0,[r0,#0x38]	; 023224AC
	sub r0,#0x10	; 023224AE
	bx lr	; 023224B0
loc_023224B2:
	mov r0,#0x0	; 023224B2
	bx lr	; 023224B4
loc_023224B6:
	ldr r0,[pool_023224D0]	; 023224B6
	ldr r0,[r0,#0x38]	; 023224B8
	neg r0,r0	; 023224BA
	bx lr	; 023224BC
loc_023224BE:
	ldr r0,[pool_023224D0]	; 023224BE
	ldr r0,[r0,#0x38]	; 023224C0
	sub r0,#0x10	; 023224C2
	bx lr	; 023224C4
loc_023224C6:
	mov r0,#0x0	; 023224C6
	bx lr	; 023224C8
	.byte 0xC0, 0x46	; 023224CC
pool_023224CC:
loc_023224CC:
	.word P1_BssStart + 0x1388	; 023224CC
pool_023224D0:
loc_023224D0:
	.word P1_BssStart + 0x1408	; 023224D0

; ===== function loc_023224D4 =====
loc_023224D4:
	ldr r0,[pool_02322504]	; 023224D4
	ldr r0,[r0,#0x0]	; 023224D6
	cmp r0,#0x5	; 023224D8
	bhi loc_023224FE	; 023224DA
	add r0,r0,r0	; 023224DC
P1_SwitchIndexPC_023224DC:
	add r0,pc	; 023224DE
	ldrh r0,[r0,#(P1_SwitchTable_023224DC - (P1_SwitchIndexPC_023224DC + 4))]	; 023224E0
	lsl r0,r0,#0x10	; 023224E2
	asr r0,r0,#0x10	; 023224E4
P1_SwitchTargetPC_023224DC:
	add r0,pc	; 023224E6
	bx r0	; 023224E8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023224DC:
	.halfword (loc_023224FA + 1) - (P1_SwitchTargetPC_023224DC + 4)
	.halfword (loc_023224FA + 1) - (P1_SwitchTargetPC_023224DC + 4)
	.halfword (loc_023224F6 + 1) - (P1_SwitchTargetPC_023224DC + 4)
	.halfword (loc_023224F6 + 1) - (P1_SwitchTargetPC_023224DC + 4)
	.halfword (loc_023224F6 + 1) - (P1_SwitchTargetPC_023224DC + 4)
	.halfword (loc_023224FA + 1) - (P1_SwitchTargetPC_023224DC + 4)
P1_SwitchTable_023224DCEnd:
loc_023224F6:
	mov r0,#0x1	; 023224F6
	bx lr	; 023224F8
loc_023224FA:
	mov r0,#0x0	; 023224FA
	bx lr	; 023224FC
loc_023224FE:
	mov r0,#0x0	; 023224FE
	bx lr	; 02322500
	.byte 0xC0, 0x46	; 02322504
pool_02322504:
loc_02322504:
	.word P1_BssStart + 0x1388	; 02322504

; ===== function loc_02322508 =====
loc_02322508:
	push {lr}	; 02322508
	sub sp,#0x4	; 0232250A
	ldr r0,[r0,#0x0]	; 0232250C
	cmp r0,#0x5	; 0232250E
	bhi loc_0232254E	; 02322510
	add r0,r0,r0	; 02322512
P1_SwitchIndexPC_02322512:
	add r0,pc	; 02322514
	ldrh r0,[r0,#(P1_SwitchTable_02322512 - (P1_SwitchIndexPC_02322512 + 4))]	; 02322516
	lsl r0,r0,#0x10	; 02322518
	asr r0,r0,#0x10	; 0232251A
P1_SwitchTargetPC_02322512:
	add r0,pc	; 0232251C
	bx r0	; 0232251E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02322512:
	.halfword (loc_0232253C + 1) - (P1_SwitchTargetPC_02322512 + 4)
	.halfword (loc_0232253C + 1) - (P1_SwitchTargetPC_02322512 + 4)
	.halfword (loc_0232252C + 1) - (P1_SwitchTargetPC_02322512 + 4)
	.halfword (loc_0232252C + 1) - (P1_SwitchTargetPC_02322512 + 4)
	.halfword (loc_0232252C + 1) - (P1_SwitchTargetPC_02322512 + 4)
	.halfword (loc_0232253C + 1) - (P1_SwitchTargetPC_02322512 + 4)
P1_SwitchTable_02322512End:
loc_0232252C:
	ldr r1,[pool_0232256C]	; 0232252C
	ldr r2,[r1,#0x0]	; 0232252E
	ldr r0,[pool_02322570]	; 02322530
	and r2,r0	; 02322532
	ldr r0,[pool_02322574]	; 02322534
	orr r2,r0	; 02322536
	str r2,[r1,#0x0]	; 02322538
	b loc_0232254E	; 0232253A
loc_0232253C:
	ldr r1,[pool_0232256C]	; 0232253C
	ldr r2,[r1,#0x0]	; 0232253E
	ldr r0,[pool_02322570]	; 02322540
	and r2,r0	; 02322542
	ldr r0,[pool_02322578]	; 02322544
	ldr r0,[r0,#0x0]	; 02322546
	lsl r0,r0,#0x8	; 02322548
	orr r2,r0	; 0232254A
	str r2,[r1,#0x0]	; 0232254C
loc_0232254E:
	ldr r0,[pool_0232257C]	; 0232254E
	ldr r0,[r0,#0x0]	; 02322550
	cmp r0,#0x10	; 02322552
	bne loc_02322564	; 02322554
	bl loc_0232247C	; 02322556
	add r2,r0,#0x0	; 0232255A
	ldr r0,[pool_02322580]	; 0232255C
	mov r1,#0x1f	; 0232255E
	bl loc_0232DBA4	; 02322560
loc_02322564:
	add sp,#0x4	; 02322564
	pop {r3}	; 02322566
	bx r3	; 02322568
	.byte 0xC0, 0x46	; 0232256C
pool_0232256C:
loc_0232256C:
	.word REG_DISPCNT_A	; 0232256C
pool_02322570:
loc_02322570:
	.word 0xFFFFE0FF	; 02322570
pool_02322574:
loc_02322574:
	.word 0x00001000	; 02322574
pool_02322578:
loc_02322578:
	.word P1_BssStart + 0x1370	; 02322578
pool_0232257C:
loc_0232257C:
	.word P1_BssStart + 0x1374	; 0232257C
pool_02322580:
loc_02322580:
	.word REG_BLDCNT	; 02322580

; ===== function loc_02322584 =====
loc_02322584:
	push {r4,r5,r6,r7,lr}	; 02322584
	sub sp,#0x44	; 02322586
	add r5,r0,#0x0	; 02322588
	add r0,#0xb8	; 0232258A
	ldr r0,[r0,#0x0]	; 0232258C
	cmp r0,#0x10	; 0232258E
	bge loc_023225C6	; 02322590
	ldr r0,[r5,#0x0]	; 02322592
	cmp r0,#0x0	; 02322594
	beq loc_023225A6	; 02322596
	cmp r0,#0x3	; 02322598
	beq loc_023225A6	; 0232259A
	add r1,r5,#0x0	; 0232259C
	add r1,#0xb8	; 0232259E
	ldr r0,[r1,#0x0]	; 023225A0
	add r0,r0,#0x1	; 023225A2
	str r0,[r1,#0x0]	; 023225A4
loc_023225A6:
	add r0,r5,#0x0	; 023225A6
	add r0,#0xb8	; 023225A8
	ldr r0,[r0,#0x0]	; 023225AA
	cmp r0,#0x10	; 023225AC
	bne loc_023225C6	; 023225AE
	mov r1,#0x0	; 023225B0
	add r0,r5,#0x0	; 023225B2
	add r0,#0xb8	; 023225B4
	str r1,[r0,#0x0]	; 023225B6
	ldr r0,[r5,#0x0]	; 023225B8
	add r0,r0,#0x1	; 023225BA
	str r0,[r5,#0x0]	; 023225BC
	ldr r0,[r5,#0x0]	; 023225BE
	cmp r0,#0x6	; 023225C0
	bne loc_023225C6	; 023225C2
	str r1,[r5,#0x0]	; 023225C4
loc_023225C6:
	bl loc_023224D4	; 023225C6
	cmp r0,#0x0	; 023225CA
	bne loc_023225D0	; 023225CC
	b loc_023227BC	; 023225CE
loc_023225D0:
	add r0,sp,#0x30	; 023225D0
	ldr r1,[r5,#0x4]	; 023225D2
	bl loc_023227D4	; 023225D4
	add r0,r5,#0x0	; 023225D8
	add r0,#0x8c	; 023225DA
	add r1,sp,#0x30	; 023225DC
	bl loc_02324A80	; 023225DE
	ldr r0,[r5,#0x4]	; 023225E2
	cmp r0,#0x0	; 023225E4
	bne loc_023225FA	; 023225E6
	mov r0,#0x9c	; 023225E8
	bl loc_02324D1C	; 023225EA
	add r1,r0,#0x0	; 023225EE
	add r0,r5,#0x0	; 023225F0
	add r0,#0x60	; 023225F2
	bl loc_02324A80	; 023225F4
	b loc_0232260A	; 023225F8
loc_023225FA:
	mov r0,#0x9d	; 023225FA
	bl loc_02324D1C	; 023225FC
	add r1,r0,#0x0	; 02322600
	add r0,r5,#0x0	; 02322602
	add r0,#0x60	; 02322604
	bl loc_02324A80	; 02322606
loc_0232260A:
	add r0,sp,#0x24	; 0232260A
	bl loc_023269C4	; 0232260C
	ldr r4,[sp,#0x24]	; 02322610
	add r0,r4,#0x0	; 02322612
	mov r1,#0xa	; 02322614
	blx P1_UnsignedDivMod	; 02322616
	str r0,[sp,#0x10]	; 0232261A
	add r0,r4,#0x0	; 0232261C
	mov r1,#0xa	; 0232261E
	blx P1_UnsignedDivMod	; 02322620
	add r7,r1,#0x0	; 02322624
	ldr r4,[sp,#0x28]	; 02322626
	add r0,r4,#0x0	; 02322628
	mov r1,#0xa	; 0232262A
	blx P1_UnsignedDivMod	; 0232262C
	str r0,[sp,#0x14]	; 02322630
	add r0,r4,#0x0	; 02322632
	mov r1,#0xa	; 02322634
	blx P1_UnsignedDivMod	; 02322636
	str r1,[sp,#0xc]	; 0232263A
	ldr r0,[pool_023227C4]	; 0232263C
	ldrb r4,[r0,#0x0]	; 0232263E
	add r0,r4,#0x0	; 02322640
	mov r1,#0xa	; 02322642
	blx P1_SignedDivMod	; 02322644
	str r0,[sp,#0x18]	; 02322648
	add r0,r4,#0x0	; 0232264A
	mov r1,#0xa	; 0232264C
	blx P1_SignedDivMod	; 0232264E
	str r1,[sp,#0x8]	; 02322652
	ldr r0,[pool_023227C4]	; 02322654
	ldrb r4,[r0,#0x1]	; 02322656
	add r0,r4,#0x0	; 02322658
	mov r1,#0xa	; 0232265A
	blx P1_SignedDivMod	; 0232265C
	str r0,[sp,#0x1c]	; 02322660
	add r0,r4,#0x0	; 02322662
	mov r1,#0xa	; 02322664
	blx P1_SignedDivMod	; 02322666
	add r6,r1,#0x0	; 0232266A
	mov r4,#0x0	; 0232266C
	str r4,[sp,#0x20]	; 0232266E
loc_02322670:
	mov r0,#0x1	; 02322670
	str r0,[sp,#0x0]	; 02322672
	add r2,r5,#0x0	; 02322674
	add r2,#0x8	; 02322676
	add r1,r4,#0x0	; 02322678
	mov r0,#0x2c	; 0232267A
	mul r1,r0	; 0232267C
	add r0,r2,r1	; 0232267E
	ldr r1,[sp,#0x20]	; 02322680
	lsl r2,r1,#0	; 02322682
	lsl r3,r1,#0	; 02322684
	bl loc_023236B8	; 02322686
	add r4,r4,#0x1	; 0232268A
	cmp r4,#0x2	; 0232268C
	blt loc_02322670	; 0232268E
	mov r0,#0x1	; 02322690
	str r0,[sp,#0x0]	; 02322692
	add r0,r5,#0x0	; 02322694
	add r0,#0x60	; 02322696
	mov r1,#0x0	; 02322698
	add r2,r1,#0x0	; 0232269A
	add r3,r1,#0x0	; 0232269C
	bl loc_023236B8	; 0232269E
	mov r0,#0x1	; 023226A2
	str r0,[sp,#0x0]	; 023226A4
	add r5,#0x8c	; 023226A6
	add r0,r5,#0x0	; 023226A8
	mov r1,#0x0	; 023226AA
	add r2,r1,#0x0	; 023226AC
	add r3,r1,#0x0	; 023226AE
	bl loc_023236B8	; 023226B0
	bl loc_02323DC0	; 023226B4
	mov r1,#0x3e	; 023226B8
	str r1,[sp,#0x0]	; 023226BA
	mov r1,#0x20	; 023226BC
	str r1,[sp,#0x4]	; 023226BE
	ldr r1,[pool_023227C8]	; 023226C0
	ldr r2,[pool_023227CC]	; 023226C2
	ldr r3,[sp,#0x10]	; 023226C4
	lsl r4,r3,#0x2	; 023226C6
	ldr r3,[pool_023227D0]	; 023226C8
	ldr r3,[r3,r4]	; 023226CA
	bl loc_02323B78	; 023226CC
	bl loc_02323DC0	; 023226D0
	mov r1,#0x5d	; 023226D4
	str r1,[sp,#0x0]	; 023226D6
	mov r1,#0x20	; 023226D8
	str r1,[sp,#0x4]	; 023226DA
	ldr r1,[pool_023227C8]	; 023226DC
	ldr r2,[pool_023227CC]	; 023226DE
	lsl r4,r7,#0x2	; 023226E0
	ldr r3,[pool_023227D0]	; 023226E2
	ldr r3,[r3,r4]	; 023226E4
	bl loc_02323B78	; 023226E6
	bl loc_02323DC0	; 023226EA
	mov r1,#0x74	; 023226EE
	str r1,[sp,#0x0]	; 023226F0
	mov r1,#0x20	; 023226F2
	str r1,[sp,#0x4]	; 023226F4
	ldr r1,[pool_023227C8]	; 023226F6
	ldr r2,[pool_023227CC]	; 023226F8
	mov r3,#0x0	; 023226FA
	bl loc_02323B78	; 023226FC
	bl loc_02323DC0	; 02322700
	mov r1,#0x8b	; 02322704
	str r1,[sp,#0x0]	; 02322706
	mov r1,#0x20	; 02322708
	str r1,[sp,#0x4]	; 0232270A
	ldr r1,[pool_023227C8]	; 0232270C
	ldr r2,[pool_023227CC]	; 0232270E
	ldr r3,[sp,#0x14]	; 02322710
	lsl r4,r3,#0x2	; 02322712
	ldr r3,[pool_023227D0]	; 02322714
	ldr r3,[r3,r4]	; 02322716
	bl loc_02323B78	; 02322718
	bl loc_02323DC0	; 0232271C
	mov r1,#0xaa	; 02322720
	str r1,[sp,#0x0]	; 02322722
	mov r1,#0x20	; 02322724
	str r1,[sp,#0x4]	; 02322726
	ldr r1,[pool_023227C8]	; 02322728
	ldr r2,[pool_023227CC]	; 0232272A
	ldr r3,[sp,#0xc]	; 0232272C
	lsl r4,r3,#0x2	; 0232272E
	ldr r3,[pool_023227D0]	; 02322730
	ldr r3,[r3,r4]	; 02322732
	bl loc_02323B78	; 02322734
	bl loc_02323DC0	; 02322738
	mov r1,#0x3e	; 0232273C
	str r1,[sp,#0x0]	; 0232273E
	mov r1,#0x6e	; 02322740
	str r1,[sp,#0x4]	; 02322742
	ldr r1,[pool_023227C8]	; 02322744
	ldr r2,[pool_023227CC]	; 02322746
	ldr r3,[sp,#0x18]	; 02322748
	lsl r4,r3,#0x2	; 0232274A
	ldr r3,[pool_023227D0]	; 0232274C
	ldr r3,[r3,r4]	; 0232274E
	bl loc_02323B78	; 02322750
	bl loc_02323DC0	; 02322754
	mov r1,#0x5d	; 02322758
	str r1,[sp,#0x0]	; 0232275A
	mov r1,#0x6e	; 0232275C
	str r1,[sp,#0x4]	; 0232275E
	ldr r1,[pool_023227C8]	; 02322760
	ldr r2,[pool_023227CC]	; 02322762
	ldr r3,[sp,#0x8]	; 02322764
	lsl r4,r3,#0x2	; 02322766
	ldr r3,[pool_023227D0]	; 02322768
	ldr r3,[r3,r4]	; 0232276A
	bl loc_02323B78	; 0232276C
	bl loc_02323DC0	; 02322770
	mov r1,#0x74	; 02322774
	str r1,[sp,#0x0]	; 02322776
	mov r1,#0x6e	; 02322778
	str r1,[sp,#0x4]	; 0232277A
	ldr r1,[pool_023227C8]	; 0232277C
	ldr r2,[pool_023227CC]	; 0232277E
	mov r3,#0x0	; 02322780
	bl loc_02323B78	; 02322782
	bl loc_02323DC0	; 02322786
	mov r1,#0x8b	; 0232278A
	str r1,[sp,#0x0]	; 0232278C
	mov r1,#0x6e	; 0232278E
	str r1,[sp,#0x4]	; 02322790
	ldr r1,[pool_023227C8]	; 02322792
	ldr r2,[pool_023227CC]	; 02322794
	ldr r3,[sp,#0x1c]	; 02322796
	lsl r4,r3,#0x2	; 02322798
	ldr r3,[pool_023227D0]	; 0232279A
	ldr r3,[r3,r4]	; 0232279C
	bl loc_02323B78	; 0232279E
	bl loc_02323DC0	; 023227A2
	mov r1,#0xaa	; 023227A6
	str r1,[sp,#0x0]	; 023227A8
	mov r1,#0x6e	; 023227AA
	str r1,[sp,#0x4]	; 023227AC
	ldr r1,[pool_023227C8]	; 023227AE
	ldr r2,[pool_023227CC]	; 023227B0
	lsl r4,r6,#0x2	; 023227B2
	ldr r3,[pool_023227D0]	; 023227B4
	ldr r3,[r3,r4]	; 023227B6
	bl loc_02323B78	; 023227B8
loc_023227BC:
	add sp,#0x44	; 023227BC
	pop {r4,r5,r6,r7}	; 023227BE
	pop {r3}	; 023227C0
	bx r3	; 023227C2
pool_023227C4:
loc_023227C4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsAlarmHourOffset	; 023227C4
pool_023227C8:
loc_023227C8:
	.word 0x023BB898	; 023227C8
pool_023227CC:
loc_023227CC:
	.word 0x0239FFA4	; 023227CC
pool_023227D0:
loc_023227D0:
	.word P1_Data_023306DC	; 023227D0

; ===== function loc_023227D4 =====
loc_023227D4:
	push {r4,r5,r6,r7,lr}	; 023227D4
	sub sp,#0xc	; 023227D6
	add r5,r0,#0x0	; 023227D8
	add r4,r1,#0x0	; 023227DA
	add r0,sp,#0x0	; 023227DC
	bl loc_023269C4	; 023227DE
	ldr r3,[sp,#0x8]	; 023227E2
	ldr r2,[sp,#0x4]	; 023227E4
	ldr r0,[sp,#0x0]	; 023227E6
	mov r1,#0x3c	; 023227E8
	mul r0,r1	; 023227EA
	add r0,r2,r0	; 023227EC
	mul r0,r1	; 023227EE
	add r0,r3,r0	; 023227F0
	ldr r2,[pool_0232286C]	; 023227F2
	ldrb r3,[r2,#0x1]	; 023227F4
	ldrb r2,[r2,#0x0]	; 023227F6
	mul r2,r1	; 023227F8
	add r2,r3,r2	; 023227FA
	mul r2,r1	; 023227FC
	cmp r4,#0x0	; 023227FE
	bne loc_02322812	; 02322800
	cmp r0,r2	; 02322802
	bhi loc_0232280A	; 02322804
	sub r4,r2,r0	; 02322806
	b loc_02322820	; 02322808
loc_0232280A:
	sub r1,r0,r2	; 0232280A
	ldr r0,[pool_02322870]	; 0232280C
	sub r4,r0,r1	; 0232280E
	b loc_02322820	; 02322810
loc_02322812:
	cmp r2,r0	; 02322812
	bhi loc_0232281A	; 02322814
	sub r4,r0,r2	; 02322816
	b loc_02322820	; 02322818
loc_0232281A:
	sub r1,r2,r0	; 0232281A
	ldr r0,[pool_02322870]	; 0232281C
	sub r4,r0,r1	; 0232281E
loc_02322820:
	add r0,r4,#0x0	; 02322820
	ldr r1,[pool_02322874]	; 02322822
	blx P1_UnsignedDivMod	; 02322824
	add r6,r0,#0x0	; 02322828
	ldr r0,[pool_02322874]	; 0232282A
	add r1,r6,#0x0	; 0232282C
	mul r1,r0	; 0232282E
	sub r4,r4,r1	; 02322830
	add r0,r4,#0x0	; 02322832
	mov r1,#0x3c	; 02322834
	blx P1_UnsignedDivMod	; 02322836
	add r7,r0,#0x0	; 0232283A
	mov r0,#0x3c	; 0232283C
	add r1,r7,#0x0	; 0232283E
	mul r1,r0	; 02322840
	sub r4,r4,r1	; 02322842
	add r0,r5,#0x0	; 02322844
	add r1,r6,#0x0	; 02322846
	bl loc_02325980	; 02322848
	mov r1,#0x3a	; 0232284C
	strh r1,[r0,#0x0]	; 0232284E
	add r0,r0,#0x2	; 02322850
	add r1,r7,#0x0	; 02322852
	bl loc_02325980	; 02322854
	mov r1,#0x3a	; 02322858
	strh r1,[r0,#0x0]	; 0232285A
	add r0,r0,#0x2	; 0232285C
	add r1,r4,#0x0	; 0232285E
	bl loc_02325980	; 02322860
	add sp,#0xc	; 02322864
	pop {r4,r5,r6,r7}	; 02322866
	pop {r3}	; 02322868
	bx r3	; 0232286A
pool_0232286C:
loc_0232286C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsAlarmHourOffset	; 0232286C
pool_02322870:
loc_02322870:
	.word 0x00015180	; 02322870
pool_02322874:
loc_02322874:
	.word 0x00000E10	; 02322874

; ===== function loc_02322878 =====
loc_02322878:
	push {r4,r5,lr}	; 02322878
	sub sp,#0x4	; 0232287A
	add r5,r0,#0x0	; 0232287C
	bl loc_02324BC4	; 0232287E
	add r4,r0,#0x0	; 02322882
	mov r1,#0x0	; 02322884
	str r1,[r5,#0x0]	; 02322886
	str r1,[r5,#0x4]	; 02322888
	add r1,r5,#0x0	; 0232288A
	add r1,#0x8	; 0232288C
	ldr r2,[pool_023228EC]	; 0232288E
	mov r3,#0x9e	; 02322890
	bl loc_02324B34	; 02322892
	add r0,r5,#0x0	; 02322896
	add r0,#0x8	; 02322898
	ldr r1,[pool_023228EC]	; 0232289A
	mov r2,#0x9a	; 0232289C
	bl loc_02324ADC	; 0232289E
	add r0,r4,#0x0	; 023228A2
	add r1,r5,#0x0	; 023228A4
	add r1,#0x34	; 023228A6
	ldr r2,[pool_023228EC]	; 023228A8
	mov r3,#0x9e	; 023228AA
	bl loc_02324B34	; 023228AC
	add r0,r5,#0x0	; 023228B0
	add r0,#0x34	; 023228B2
	ldr r1,[pool_023228EC]	; 023228B4
	mov r2,#0x9f	; 023228B6
	bl loc_02324ADC	; 023228B8
	add r0,r4,#0x0	; 023228BC
	add r1,r5,#0x0	; 023228BE
	add r1,#0x60	; 023228C0
	ldr r2,[pool_023228EC]	; 023228C2
	mov r3,#0x9e	; 023228C4
	bl loc_02324B34	; 023228C6
	add r0,r4,#0x0	; 023228CA
	add r1,r5,#0x0	; 023228CC
	add r1,#0x8c	; 023228CE
	ldr r2,[pool_023228EC]	; 023228D0
	mov r3,#0x9e	; 023228D2
	bl loc_02324B34	; 023228D4
	add r5,#0x8c	; 023228D8
	add r0,r5,#0x0	; 023228DA
	ldr r1,[pool_023228EC]	; 023228DC
	mov r2,#0x9b	; 023228DE
	bl loc_02324ADC	; 023228E0
	add sp,#0x4	; 023228E4
	pop {r4,r5}	; 023228E6
	pop {r3}	; 023228E8
	bx r3	; 023228EA
pool_023228EC:
loc_023228EC:
	.word 0x023A0BD8	; 023228EC

; ===== function loc_023228F0 =====
loc_023228F0:
	ldr r1,[pool_023228F8]	; 023228F0
	str r0,[r1,#0x4]	; 023228F2
	bx lr	; 023228F4
	.byte 0xC0, 0x46	; 023228F8
pool_023228F8:
loc_023228F8:
	.word P1_BssStart + 0x1388	; 023228F8

; ===== function loc_023228FC =====
loc_023228FC:
	push {lr}	; 023228FC
	sub sp,#0x4	; 023228FE
	ldr r0,[pool_02322944]	; 02322900
	ldr r0,[r0,#0x0]	; 02322902
	cmp r0,#0x0	; 02322904
	beq loc_0232293E	; 02322906
	bl loc_02321E80	; 02322908
	neg r0,r0	; 0232290C
	lsl r1,r0,#0x10	; 0232290E
	ldr r0,[pool_02322948]	; 02322910
	and r1,r0	; 02322912
	ldr r0,[pool_0232294C]	; 02322914
	str r1,[r0,#0x0]	; 02322916
	bl loc_02321E80	; 02322918
	neg r0,r0	; 0232291C
	lsl r1,r0,#0x10	; 0232291E
	ldr r0,[pool_02322948]	; 02322920
	and r1,r0	; 02322922
	ldr r0,[pool_02322950]	; 02322924
	str r1,[r0,#0x0]	; 02322926
	bl loc_02321E80	; 02322928
	neg r0,r0	; 0232292C
	lsl r1,r0,#0x10	; 0232292E
	ldr r0,[pool_02322948]	; 02322930
	and r1,r0	; 02322932
	ldr r0,[pool_02322954]	; 02322934
	str r1,[r0,#0x0]	; 02322936
	ldr r0,[pool_02322958]	; 02322938
	bl loc_02322508	; 0232293A
loc_0232293E:
	add sp,#0x4	; 0232293E
	pop {r3}	; 02322940
	bx r3	; 02322942
pool_02322944:
loc_02322944:
	.word P1_BssStart + 0x137C	; 02322944
pool_02322948:
loc_02322948:
	.word 0x01FF0000	; 02322948
pool_0232294C:
loc_0232294C:
	.word REG_BG1HOFS	; 0232294C
pool_02322950:
loc_02322950:
	.word REG_BG2HOFS	; 02322950
pool_02322954:
loc_02322954:
	.word REG_BG3HOFS	; 02322954
pool_02322958:
loc_02322958:
	.word 0x02332208	; 02322958

; ===== function loc_0232295C =====
P1_Entry_0232295C:
	push {lr}	; 0232295C
	sub sp,#0x4	; 0232295E
	ldr r0,[pool_02322978]	; 02322960
	ldr r0,[r0,#0x0]	; 02322962
	cmp r0,#0x0	; 02322964
	beq loc_02322970	; 02322966
	bl loc_023230C0	; 02322968
	bl loc_023221A4	; 0232296C
loc_02322970:
	add sp,#0x4	; 02322970
	pop {r3}	; 02322972
	bx r3	; 02322974
	.byte 0xC0, 0x46	; 02322978
pool_02322978:
loc_02322978:
	.word P1_BssStart + 0x137C	; 02322978

; ===== function loc_0232297C =====
loc_0232297C:
	push {lr}	; 0232297C
	sub sp,#0x4	; 0232297E
	ldr r0,[pool_023229E4]	; 02322980
	ldr r0,[r0,#0x0]	; 02322982
	cmp r0,#0x0	; 02322984
	beq loc_023229DE	; 02322986
	ldr r0,[pool_023229E8]	; 02322988
	ldr r1,[r0,#0x0]	; 0232298A
	cmp r1,#0x10	; 0232298C
	bge loc_023229BC	; 0232298E
	add r1,r1,#0x1	; 02322990
	str r1,[r0,#0x0]	; 02322992
	lsl r0,r1,#0x4	; 02322994
	mov r1,#0x10	; 02322996
	blx P1_SignedDivMod	; 02322998
	add r3,r0,#0x0	; 0232299C
	ldr r0,[pool_023229EC]	; 0232299E
	mov r1,#0x1f	; 023229A0
	mov r2,#0x10	; 023229A2
	sub r2,r2,r3	; 023229A4
	bl loc_0232DBA4	; 023229A6
	ldr r0,[pool_023229E8]	; 023229AA
	ldr r0,[r0,#0x0]	; 023229AC
	cmp r0,#0x10	; 023229AE
	bne loc_023229BC	; 023229B0
	mov r1,#0x0	; 023229B2
	ldr r0,[pool_023229EC]	; 023229B4
	strh r1,[r0,#0x0]	; 023229B6
	bl P1_SetRuntimeWordAtOffset8	; 023229B8
loc_023229BC:
	ldr r0,[pool_023229F0]	; 023229BC
	bl loc_02322584	; 023229BE
	bl loc_023224D4	; 023229C2
	cmp r0,#0x0	; 023229C6
	bne loc_023229DE	; 023229C8
	bl loc_02323320	; 023229CA
	bl loc_02323414	; 023229CE
	bl loc_02322208	; 023229D2
	bl loc_023230B0	; 023229D6
	bl loc_02322A78	; 023229DA
loc_023229DE:
	add sp,#0x4	; 023229DE
	pop {r3}	; 023229E0
	bx r3	; 023229E2
pool_023229E4:
loc_023229E4:
	.word P1_BssStart + 0x137C	; 023229E4
pool_023229E8:
loc_023229E8:
	.word P1_BssStart + 0x1374	; 023229E8
pool_023229EC:
loc_023229EC:
	.word REG_BLDCNT	; 023229EC
pool_023229F0:
loc_023229F0:
	.word 0x02332208	; 023229F0

; ===== function loc_023229F4 =====
loc_023229F4:
	ldr r0,[pool_023229FC]	; 023229F4
	ldr r0,[r0,#0x0]	; 023229F6
	bx lr	; 023229F8
	.byte 0xC0, 0x46	; 023229FC
pool_023229FC:
loc_023229FC:
	.word P1_BssStart + 0x1444	; 023229FC

; ===== function loc_02322A00 =====
loc_02322A00:
	ldr r3,[pool_02322A04]	; 02322A00
	bx r3	; 02322A02
pool_02322A04:
loc_02322A04:
	.word loc_0232212C + 1	; 02322A04

; ===== function loc_02322A08 =====
loc_02322A08:
	push {lr}	; 02322A08
	sub sp,#0x4	; 02322A0A
	cmp r0,#0x0	; 02322A0C
	beq loc_02322A14	; 02322A0E
	mov r2,#0x1	; 02322A10
	b loc_02322A16	; 02322A12
loc_02322A14:
	mov r2,#0x4	; 02322A14
loc_02322A16:
	ldr r1,[pool_02322A3C]	; 02322A16
	str r2,[r1,#0x0]	; 02322A18
	cmp r0,#0x0	; 02322A1A
	beq loc_02322A36	; 02322A1C
	mov r0,#0x0	; 02322A1E
	str r0,[r1,#0x4]	; 02322A20
	ldr r0,[pool_02322A40]	; 02322A22
	ldr r1,[pool_02322A44]	; 02322A24
	mov r2,#0x9a	; 02322A26
	bl loc_02324ADC	; 02322A28
	ldr r0,[pool_02322A48]	; 02322A2C
	ldr r1,[pool_02322A44]	; 02322A2E
	mov r2,#0x9f	; 02322A30
	bl loc_02324ADC	; 02322A32
loc_02322A36:
	add sp,#0x4	; 02322A36
	pop {r3}	; 02322A38
	bx r3	; 02322A3A
pool_02322A3C:
loc_02322A3C:
	.word P1_BssStart + 0x1388	; 02322A3C
pool_02322A40:
loc_02322A40:
	.word 0x02332210	; 02322A40
pool_02322A44:
loc_02322A44:
	.word 0x023A0BD8	; 02322A44
pool_02322A48:
loc_02322A48:
	.word 0x0233223C	; 02322A48
P1_Entry_02322A4C:
	ldr r3,[pool_02322A50]	; 02322A4C
	bx r3	; 02322A4E
pool_02322A50:
	.word P1_Entry_02322424 + 1	; 02322A50

; ===== function loc_02322A54 =====
loc_02322A54:
	push {lr}	; 02322A54
	sub sp,#0x4	; 02322A56
	ldr r0,[pool_02322A70]	; 02322A58
	mov r1,#0x0	; 02322A5A
	ldr r2,[pool_02322A74]	; 02322A5C
	sub r2,r2,r0	; 02322A5E
	bl loc_0232E114	; 02322A60
	bl loc_02321E38	; 02322A64
	add sp,#0x4	; 02322A68
	pop {r3}	; 02322A6A
	bx r3	; 02322A6C
	.byte 0xC0, 0x46	; 02322A70
pool_02322A70:
loc_02322A70:
	.word 0x023B6EE0	; 02322A70
pool_02322A74:
loc_02322A74:
	.word 0x023B70E0	; 02322A74

; ===== function loc_02322A78 =====
loc_02322A78:
	push {r4,r5,lr}	; 02322A78
	sub sp,#0x4c	; 02322A7A
	add r0,sp,#0x40	; 02322A7C
	bl loc_023269C4	; 02322A7E
	ldr r0,[sp,#0x44]	; 02322A82
	cmp r0,#0x0	; 02322A84
	bne loc_02322A98	; 02322A86
	ldr r0,[pool_02322C74]	; 02322A88
	ldr r0,[r0,#0x4]	; 02322A8A
	cmp r0,#0x0	; 02322A8C
	beq loc_02322A98	; 02322A8E
	mov r0,#0x2b	; 02322A90
	bl loc_0232365C	; 02322A92
	b loc_02322ABC	; 02322A96
loc_02322A98:
	ldr r1,[sp,#0x48]	; 02322A98
	cmp r1,#0x0	; 02322A9A
	bne loc_02322AAE	; 02322A9C
	ldr r0,[pool_02322C74]	; 02322A9E
	ldr r0,[r0,#0x8]	; 02322AA0
	cmp r0,#0x0	; 02322AA2
	beq loc_02322AAE	; 02322AA4
	mov r0,#0x29	; 02322AA6
	bl loc_0232365C	; 02322AA8
	b loc_02322ABC	; 02322AAC
loc_02322AAE:
	ldr r0,[pool_02322C74]	; 02322AAE
	ldr r0,[r0,#0x8]	; 02322AB0
	cmp r1,r0	; 02322AB2
	beq loc_02322ABC	; 02322AB4
	mov r0,#0x2a	; 02322AB6
	bl loc_0232365C	; 02322AB8
loc_02322ABC:
	add r3,sp,#0x40	; 02322ABC
	ldr r2,[pool_02322C74]	; 02322ABE
	ldmia r3!,{r0,r1}	; 02322AC0
	stmia r2!,{r0,r1}	; 02322AC2
	ldr r0,[r3,#0x0]	; 02322AC4
	str r0,[r2,#0x0]	; 02322AC6
	ldr r0,[sp,#0x44]	; 02322AC8
	mov r1,#0xc	; 02322ACA
	blx P1_UnsignedDivMod	; 02322ACC
	add r4,r0,#0x0	; 02322AD0
	ldr r0,[sp,#0x40]	; 02322AD2
	mov r1,#0xc	; 02322AD4
	blx P1_UnsignedDivMod	; 02322AD6
	mov r0,#0x5	; 02322ADA
	mul r1,r0	; 02322ADC
	add r5,r4,r1	; 02322ADE
	bl loc_02323DC0	; 02322AE0
	add r4,r0,#0x0	; 02322AE4
	bl loc_02321E80	; 02322AE6
	mov r1,#0x0	; 02322AEA
	str r1,[sp,#0x0]	; 02322AEC
	str r0,[sp,#0x4]	; 02322AEE
	add r0,r4,#0x0	; 02322AF0
	ldr r1,[pool_02322C78]	; 02322AF2
	ldr r2,[pool_02322C7C]	; 02322AF4
	mov r3,#0xd	; 02322AF6
	bl loc_02323B78	; 02322AF8
	ldr r0,[pool_02322C80]	; 02322AFC
	bl loc_0232CFE8	; 02322AFE
	add r4,r0,#0x0	; 02322B02
	ldr r0,[pool_02322C84]	; 02322B04
	bl loc_0232CFE8	; 02322B06
	add r1,r0,#0x0	; 02322B0A
	add r0,sp,#0x20	; 02322B0C
	add r2,r4,#0x0	; 02322B0E
	bl loc_0232CE3C	; 02322B10
	ldr r0,[sp,#0x48]	; 02322B14
	lsl r3,r0,#0x1	; 02322B16
	add r0,sp,#0x10	; 02322B18
	ldr r1,[pool_02322C88]	; 02322B1A
	ldrsh r1,[r1,r3]	; 02322B1C
	ldr r2,[pool_02322C8C]	; 02322B1E
	ldrsh r2,[r2,r3]	; 02322B20
	bl loc_0232CE48	; 02322B22
	add r0,sp,#0x20	; 02322B26
	add r1,sp,#0x10	; 02322B28
	add r2,sp,#0x30	; 02322B2A
	bl loc_0232CE54	; 02322B2C
	bl loc_02321E80	; 02322B30
	add r0,#0x20	; 02322B34
	mov r1,#0xff	; 02322B36
	and r0,r1	; 02322B38
	ldr r1,[pool_02322C90]	; 02322B3A
	orr r0,r1	; 02322B3C
	str r0,[sp,#0x8]	; 02322B3E
	ldr r1,[pool_02322C94]	; 02322B40
	add r0,sp,#0x8	; 02322B42
	strh r1,[r0,#0x4]	; 02322B44
	bl loc_02323DC0	; 02322B46
	add r1,sp,#0x8	; 02322B4A
	add r2,sp,#0x30	; 02322B4C
	bl loc_023238D8	; 02322B4E
	ldr r0,[pool_02322C98]	; 02322B52
	bl loc_0232CFE8	; 02322B54
	add r4,r0,#0x0	; 02322B58
	ldr r0,[pool_02322C84]	; 02322B5A
	bl loc_0232CFE8	; 02322B5C
	add r1,r0,#0x0	; 02322B60
	add r0,sp,#0x20	; 02322B62
	add r2,r4,#0x0	; 02322B64
	bl loc_0232CE3C	; 02322B66
	ldr r0,[sp,#0x44]	; 02322B6A
	lsl r3,r0,#0x1	; 02322B6C
	add r0,sp,#0x10	; 02322B6E
	ldr r1,[pool_02322C88]	; 02322B70
	ldrsh r1,[r1,r3]	; 02322B72
	ldr r2,[pool_02322C8C]	; 02322B74
	ldrsh r2,[r2,r3]	; 02322B76
	bl loc_0232CE48	; 02322B78
	add r0,sp,#0x20	; 02322B7C
	add r1,sp,#0x10	; 02322B7E
	add r2,sp,#0x30	; 02322B80
	bl loc_0232CE54	; 02322B82
	bl loc_02321E80	; 02322B86
	add r0,#0x20	; 02322B8A
	mov r1,#0xff	; 02322B8C
	and r0,r1	; 02322B8E
	ldr r1,[pool_02322C90]	; 02322B90
	orr r0,r1	; 02322B92
	str r0,[sp,#0x8]	; 02322B94
	ldr r1,[pool_02322C9C]	; 02322B96
	add r0,sp,#0x8	; 02322B98
	strh r1,[r0,#0x4]	; 02322B9A
	bl loc_02323DC0	; 02322B9C
	add r1,sp,#0x8	; 02322BA0
	add r2,sp,#0x30	; 02322BA2
	bl loc_023238D8	; 02322BA4
	ldr r0,[pool_02322CA0]	; 02322BA8
	bl loc_0232CFE8	; 02322BAA
	add r4,r0,#0x0	; 02322BAE
	ldr r0,[pool_02322C84]	; 02322BB0
	bl loc_0232CFE8	; 02322BB2
	add r1,r0,#0x0	; 02322BB6
	add r0,sp,#0x20	; 02322BB8
	add r2,r4,#0x0	; 02322BBA
	bl loc_0232CE3C	; 02322BBC
	lsl r3,r5,#0x1	; 02322BC0
	add r0,sp,#0x10	; 02322BC2
	ldr r1,[pool_02322C88]	; 02322BC4
	ldrsh r1,[r1,r3]	; 02322BC6
	ldr r2,[pool_02322C8C]	; 02322BC8
	ldrsh r2,[r2,r3]	; 02322BCA
	bl loc_0232CE48	; 02322BCC
	add r0,sp,#0x20	; 02322BD0
	add r1,sp,#0x10	; 02322BD2
	add r2,sp,#0x30	; 02322BD4
	bl loc_0232CE54	; 02322BD6
	bl loc_02321E80	; 02322BDA
	add r0,#0x20	; 02322BDE
	mov r1,#0xff	; 02322BE0
	and r0,r1	; 02322BE2
	ldr r1,[pool_02322C90]	; 02322BE4
	orr r0,r1	; 02322BE6
	str r0,[sp,#0x8]	; 02322BE8
	ldr r1,[pool_02322C9C]	; 02322BEA
	add r0,sp,#0x8	; 02322BEC
	strh r1,[r0,#0x4]	; 02322BEE
	bl loc_02323DC0	; 02322BF0
	add r1,sp,#0x8	; 02322BF4
	add r2,sp,#0x30	; 02322BF6
	bl loc_023238D8	; 02322BF8
	ldr r0,[pool_02322CA4]	; 02322BFC
	ldrb r0,[r0,#0x1]	; 02322BFE
	mov r1,#0xc	; 02322C00
	blx P1_SignedDivMod	; 02322C02
	add r4,r0,#0x0	; 02322C06
	ldr r0,[pool_02322CA4]	; 02322C08
	ldrb r0,[r0,#0x0]	; 02322C0A
	mov r1,#0xc	; 02322C0C
	blx P1_SignedDivMod	; 02322C0E
	mov r0,#0x5	; 02322C12
	mul r1,r0	; 02322C14
	add r5,r4,r1	; 02322C16
	ldr r0,[pool_02322CA8]	; 02322C18
	bl loc_0232CFE8	; 02322C1A
	add r4,r0,#0x0	; 02322C1E
	ldr r0,[pool_02322C84]	; 02322C20
	bl loc_0232CFE8	; 02322C22
	add r1,r0,#0x0	; 02322C26
	add r0,sp,#0x20	; 02322C28
	add r2,r4,#0x0	; 02322C2A
	bl loc_0232CE3C	; 02322C2C
	lsl r3,r5,#0x1	; 02322C30
	add r0,sp,#0x10	; 02322C32
	ldr r1,[pool_02322C88]	; 02322C34
	ldrsh r1,[r1,r3]	; 02322C36
	ldr r2,[pool_02322C8C]	; 02322C38
	ldrsh r2,[r2,r3]	; 02322C3A
	bl loc_0232CE48	; 02322C3C
	add r0,sp,#0x20	; 02322C40
	add r1,sp,#0x10	; 02322C42
	add r2,sp,#0x30	; 02322C44
	bl loc_0232CE54	; 02322C46
	bl loc_02321E80	; 02322C4A
	add r0,#0x20	; 02322C4E
	mov r1,#0xff	; 02322C50
	and r0,r1	; 02322C52
	ldr r1,[pool_02322C90]	; 02322C54
	orr r0,r1	; 02322C56
	str r0,[sp,#0x8]	; 02322C58
	ldr r1,[pool_02322CAC]	; 02322C5A
	add r0,sp,#0x8	; 02322C5C
	strh r1,[r0,#0x4]	; 02322C5E
	bl loc_02323DC0	; 02322C60
	add r1,sp,#0x8	; 02322C64
	add r2,sp,#0x30	; 02322C66
	bl loc_023238D8	; 02322C68
	add sp,#0x4c	; 02322C6C
	pop {r4,r5}	; 02322C6E
	pop {r3}	; 02322C70
	bx r3	; 02322C72
pool_02322C74:
loc_02322C74:
	.word P1_BssStart + 0x1558	; 02322C74
pool_02322C78:
loc_02322C78:
	.word 0x023BB898	; 02322C78
pool_02322C7C:
loc_02322C7C:
	.word 0x0239FF2C	; 02322C7C
pool_02322C80:
loc_02322C80:
	.word 0x00009000	; 02322C80
pool_02322C84:
loc_02322C84:
	.word 0x00001000	; 02322C84
pool_02322C88:
loc_02322C88:
	.word P1_Data_023309C0	; 02322C88
pool_02322C8C:
loc_02322C8C:
	.word P1_Data_02330A38	; 02322C8C
pool_02322C90:
loc_02322C90:
	.word 0xC0000300	; 02322C90
pool_02322C94:
loc_02322C94:
	.word 0x0000F3F0	; 02322C94
pool_02322C98:
loc_02322C98:
	.word 0x00008000	; 02322C98
pool_02322C9C:
loc_02322C9C:
	.word 0x000023F0	; 02322C9C
pool_02322CA0:
loc_02322CA0:
	.word 0x00006000	; 02322CA0
pool_02322CA4:
loc_02322CA4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsAlarmHourOffset	; 02322CA4
pool_02322CA8:
loc_02322CA8:
	.word 0x00004000	; 02322CA8
pool_02322CAC:
loc_02322CAC:
	.word 0x000053E0	; 02322CAC

; ===== function loc_02322CB0 =====
loc_02322CB0:
	push {lr}	; 02322CB0
	sub sp,#0x1c	; 02322CB2
	mov r0,#0x0	; 02322CB4
	str r0,[sp,#0x0]	; 02322CB6
	str r0,[sp,#0x4]	; 02322CB8
	add r0,sp,#0x8	; 02322CBA
	ldr r2,[pool_02322D3C]	; 02322CBC
	ldr r1,[pool_02322D40]	; 02322CBE
	add r1,r2,r1	; 02322CC0
	mov r2,#0x40	; 02322CC2
	add r3,r2,#0x0	; 02322CC4
	bl loc_02328BF0	; 02322CC6
	mov r0,#0x1c	; 02322CCA
	str r0,[sp,#0x0]	; 02322CCC
	mov r0,#0x7	; 02322CCE
	str r0,[sp,#0x4]	; 02322CD0
	add r0,sp,#0x8	; 02322CD2
	mov r1,#0x1f	; 02322CD4
	mov r2,#0x20	; 02322CD6
	add r3,r1,#0x0	; 02322CD8
	bl loc_02324394	; 02322CDA
	mov r0,#0x1c	; 02322CDE
	str r0,[sp,#0x0]	; 02322CE0
	mov r0,#0x7	; 02322CE2
	str r0,[sp,#0x4]	; 02322CE4
	add r0,sp,#0x8	; 02322CE6
	mov r1,#0x20	; 02322CE8
	add r2,r1,#0x0	; 02322CEA
	add r3,r1,#0x0	; 02322CEC
	bl loc_02324394	; 02322CEE
	mov r0,#0x0	; 02322CF2
	str r0,[sp,#0x0]	; 02322CF4
	str r0,[sp,#0x4]	; 02322CF6
	add r0,sp,#0x8	; 02322CF8
	ldr r2,[pool_02322D3C]	; 02322CFA
	ldr r1,[pool_02322D44]	; 02322CFC
	add r1,r2,r1	; 02322CFE
	mov r2,#0x40	; 02322D00
	add r3,r2,#0x0	; 02322D02
	bl loc_02328BF0	; 02322D04
	mov r0,#0x1c	; 02322D08
	str r0,[sp,#0x0]	; 02322D0A
	mov r0,#0x8	; 02322D0C
	str r0,[sp,#0x4]	; 02322D0E
	add r0,sp,#0x8	; 02322D10
	mov r1,#0x1f	; 02322D12
	mov r2,#0x20	; 02322D14
	add r3,r1,#0x0	; 02322D16
	bl loc_02324394	; 02322D18
	mov r0,#0x1c	; 02322D1C
	str r0,[sp,#0x0]	; 02322D1E
	mov r0,#0x8	; 02322D20
	str r0,[sp,#0x4]	; 02322D22
	add r0,sp,#0x8	; 02322D24
	mov r1,#0x20	; 02322D26
	add r2,r1,#0x0	; 02322D28
	add r3,r1,#0x0	; 02322D2A
	bl loc_02324394	; 02322D2C
	ldr r0,[pool_02322D48]	; 02322D30
	bl loc_023269C4	; 02322D32
	add sp,#0x1c	; 02322D36
	pop {r3}	; 02322D38
	bx r3	; 02322D3A
pool_02322D3C:
loc_02322D3C:
	.word 0x06400000	; 02322D3C
pool_02322D40:
loc_02322D40:
	.word 0x0001F000	; 02322D40
pool_02322D44:
loc_02322D44:
	.word 0x0001F800	; 02322D44
pool_02322D48:
loc_02322D48:
	.word 0x023323D8	; 02322D48
loc_02322D4C:
	push {r4,r5,lr}	; 02322D4C
	sub sp,#0x1c	; 02322D4E
	add r5,r0,#0x0	; 02322D50
	add r0,sp,#0xc	; 02322D52
	bl loc_023269A8	; 02322D54
	ldr r1,[sp,#0x14]	; 02322D58
	ldr r0,[r5,#0x0]	; 02322D5A
	cmp r1,r0	; 02322D5C
	bne loc_02322D70	; 02322D5E
	ldr r1,[sp,#0x10]	; 02322D60
	ldr r0,[r5,#0x4]	; 02322D62
	cmp r1,r0	; 02322D64
	bne loc_02322D70	; 02322D66
	ldr r1,[sp,#0xc]	; 02322D68
	ldr r0,[r5,#0x8]	; 02322D6A
	cmp r1,r0	; 02322D6C
	beq loc_02322D76	; 02322D6E
loc_02322D70:
	add r0,r5,#0x0	; 02322D70
	bl loc_02322E38	; 02322D72
loc_02322D76:
	bl loc_02323DC0	; 02322D76
	add r4,r0,#0x0	; 02322D7A
	bl loc_02321E80	; 02322D7C
	ldrh r1,[r5,#0xc]	; 02322D80
	str r1,[sp,#0x0]	; 02322D82
	ldrh r1,[r5,#0xe]	; 02322D84
	add r0,r1,r0	; 02322D86
	str r0,[sp,#0x4]	; 02322D88
	mov r0,#0x1	; 02322D8A
	str r0,[sp,#0x8]	; 02322D8C
	add r0,r4,#0x0	; 02322D8E
	ldr r1,[pool_02322DA4]	; 02322D90
	ldr r2,[pool_02322DA8]	; 02322D92
	mov r3,#0x0	; 02322D94
	bl loc_02323A24	; 02322D96
	add sp,#0x1c	; 02322D9A
	pop {r4,r5}	; 02322D9C
	pop {r3}	; 02322D9E
	bx r3	; 02322DA0
	.byte 0xC0, 0x46	; 02322DA4
pool_02322DA4:
loc_02322DA4:
	.word 0x023BB898	; 02322DA4
pool_02322DA8:
loc_02322DA8:
	.word 0x0239FF2C	; 02322DA8

; ===== function loc_02322DAC =====
loc_02322DAC:
	push {r4,r5,r6,r7,lr}	; 02322DAC
	sub sp,#0x4	; 02322DAE
	add r4,r0,#0x0	; 02322DB0
	blx P1_ResolveMainBg2TilemapAddress	; 02322DB2
	add r7,r0,#0x0	; 02322DB6
	cmp r4,#0x0	; 02322DB8
	beq loc_02322DC0	; 02322DBA
	mov r6,#0xf	; 02322DBC
	b loc_02322DC2	; 02322DBE
loc_02322DC0:
	mov r6,#0x11	; 02322DC0
loc_02322DC2:
	mov r4,#0x0	; 02322DC2
	str r4,[sp,#0x0]	; 02322DC4
loc_02322DC6:
	ldr r5,[sp,#0x0]	; 02322DC6
	add r0,r6,r4	; 02322DC8
	lsl r1,r0,#0x6	; 02322DCA
	ldr r0,[pool_02322DF8]	; 02322DCC
	add r3,r0,r1	; 02322DCE
	add r0,r4,#0x0	; 02322DD0
	add r0,#0x11	; 02322DD2
	lsl r0,r0,#0x6	; 02322DD4
	add r2,r7,r0	; 02322DD6
loc_02322DD8:
	add r0,r5,#0x0	; 02322DD8
	add r0,#0xf	; 02322DDA
	lsl r1,r0,#0x1	; 02322DDC
	ldrh r0,[r3,r1]	; 02322DDE
	strh r0,[r2,r1]	; 02322DE0
	add r5,r5,#0x1	; 02322DE2
	cmp r5,#0x10	; 02322DE4
	blt loc_02322DD8	; 02322DE6
	add r4,r4,#0x1	; 02322DE8
	cmp r4,#0x4	; 02322DEA
	blt loc_02322DC6	; 02322DEC
	add sp,#0x4	; 02322DEE
	pop {r4,r5,r6,r7}	; 02322DF0
	pop {r3}	; 02322DF2
	bx r3	; 02322DF4
	.byte 0xC0, 0x46	; 02322DF8
pool_02322DF8:
loc_02322DF8:
	.word 0x023B2CE0	; 02322DF8

; ===== function loc_02322DFC =====
loc_02322DFC:
	push {r4,r5,r6,r7,lr}	; 02322DFC
	sub sp,#0x4	; 02322DFE
	add r6,r0,#0x0	; 02322E00
	add r7,r1,#0x0	; 02322E02
	add r5,r2,#0x0	; 02322E04
	mov r2,#0x1	; 02322E06
	bl loc_02326A24	; 02322E08
	add r4,r0,#0x0	; 02322E0C
	add r0,r6,#0x0	; 02322E0E
	add r1,r7,#0x0	; 02322E10
	mov r2,#0x0	; 02322E12
	bl loc_02326A88	; 02322E14
	add r6,r0,#0x0	; 02322E18
	add r0,r4,#0x7	; 02322E1A
	sub r0,r0,r5	; 02322E1C
	mov r1,#0x7	; 02322E1E
	blx P1_SignedDivMod	; 02322E20
	add r0,r1,r6	; 02322E24
	cmp r0,#0x23	; 02322E26
	ble loc_02322E2E	; 02322E28
	mov r0,#0x1	; 02322E2A
	b loc_02322E30	; 02322E2C
loc_02322E2E:
	mov r0,#0x0	; 02322E2E
loc_02322E30:
	add sp,#0x4	; 02322E30
	pop {r4,r5,r6,r7}	; 02322E32
	pop {r3}	; 02322E34
	bx r3	; 02322E36

; ===== function loc_02322E38 =====
loc_02322E38:
	push {r4,r5,r6,r7,lr}	; 02322E38
	sub sp,#0xb4	; 02322E3A
	add r4,r0,#0x0	; 02322E3C
	ldr r5,[pool_02323084]	; 02322E3E
	add r3,sp,#0x58	; 02322E40
	mov r2,#0x3	; 02322E42
loc_02322E44:
	ldmia r5!,{r0,r1}	; 02322E44
	stmia r3!,{r0,r1}	; 02322E46
	sub r2,r2,#0x1	; 02322E48
	cmp r2,#0x0	; 02322E4A
	bne loc_02322E44	; 02322E4C
	ldr r0,[r5,#0x0]	; 02322E4E
	str r0,[r3,#0x0]	; 02322E50
	ldr r5,[pool_02323088]	; 02322E52
	add r3,sp,#0x74	; 02322E54
	mov r2,#0x3	; 02322E56
loc_02322E58:
	ldmia r5!,{r0,r1}	; 02322E58
	stmia r3!,{r0,r1}	; 02322E5A
	sub r2,r2,#0x1	; 02322E5C
	cmp r2,#0x0	; 02322E5E
	bne loc_02322E58	; 02322E60
	ldr r0,[r5,#0x0]	; 02322E62
	str r0,[r3,#0x0]	; 02322E64
	add r0,sp,#0x48	; 02322E66
	bl loc_023269A8	; 02322E68
	ldr r0,[sp,#0x48]	; 02322E6C
	str r0,[r4,#0x8]	; 02322E6E
	ldr r0,[sp,#0x4c]	; 02322E70
	str r0,[r4,#0x4]	; 02322E72
	ldr r0,[sp,#0x50]	; 02322E74
	str r0,[r4,#0x0]	; 02322E76
	bl P1_GetMainBg1CharacterBase	; 02322E78
	add r1,r0,#0x0	; 02322E7C
	mov r0,#0x0	; 02322E7E
	str r0,[sp,#0x34]	; 02322E80
	ldr r0,[sp,#0x34]	; 02322E82
	ldr r2,[pool_0232308C]	; 02322E84
	blx loc_0232E34C	; 02322E86
	bl P1_GetMainBg1CharacterBase	; 02322E8A
	add r5,r0,#0x0	; 02322E8E
	bl loc_02324BE8	; 02322E90
	mov r1,#0x0	; 02322E94
	str r1,[sp,#0x0]	; 02322E96
	str r0,[sp,#0x4]	; 02322E98
	add r0,sp,#0x38	; 02322E9A
	add r1,r5,#0x0	; 02322E9C
	ldr r2,[pool_02323090]	; 02322E9E
	mov r3,#0xc0	; 02322EA0
	bl loc_02328BF0	; 02322EA2
	add r0,sp,#0x24	; 02322EA6
	ldr r1,[sp,#0x48]	; 02322EA8
	bl loc_02325980	; 02322EAA
	add r0,sp,#0x2c	; 02322EAE
	ldr r1,[sp,#0x4c]	; 02322EB0
	bl loc_02325980	; 02322EB2
	ldr r0,[pool_02323094]	; 02322EB6
	ldrh r0,[r0,#0x0]	; 02322EB8
	lsl r0,r0,#0x1d	; 02322EBA
	lsr r0,r0,#0x1d	; 02322EBC
	cmp r0,#0x5	; 02322EBE
	bhi loc_02322EDC	; 02322EC0
	add r0,r0,r0	; 02322EC2
P1_SwitchIndexPC_02322EC2:
	add r0,pc	; 02322EC4
	ldrh r0,[r0,#(P1_SwitchTable_02322EC2 - (P1_SwitchIndexPC_02322EC2 + 4))]	; 02322EC6
	lsl r0,r0,#0x10	; 02322EC8
	asr r0,r0,#0x10	; 02322ECA
P1_SwitchTargetPC_02322EC2:
	add r0,pc	; 02322ECC
	bx r0	; 02322ECE
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02322EC2:
	.halfword (loc_02322EDC + 1) - (P1_SwitchTargetPC_02322EC2 + 4)
	.halfword (loc_02322EF0 + 1) - (P1_SwitchTargetPC_02322EC2 + 4)
	.halfword (loc_02322EF0 + 1) - (P1_SwitchTargetPC_02322EC2 + 4)
	.halfword (loc_02322EE6 + 1) - (P1_SwitchTargetPC_02322EC2 + 4)
	.halfword (loc_02322EF0 + 1) - (P1_SwitchTargetPC_02322EC2 + 4)
	.halfword (loc_02322EF0 + 1) - (P1_SwitchTargetPC_02322EC2 + 4)
P1_SwitchTable_02322EC2End:
loc_02322EDC:
	add r0,sp,#0x90	; 02322EDC
	ldr r1,[pool_02323098]	; 02322EDE
	bl P1_Utf16StrCpy	; 02322EE0
	b loc_02322EF8	; 02322EE4
loc_02322EE6:
	add r0,sp,#0x90	; 02322EE6
	ldr r1,[pool_0232309C]	; 02322EE8
	bl P1_Utf16StrCpy	; 02322EEA
	b loc_02322EF8	; 02322EEE
loc_02322EF0:
	add r0,sp,#0x90	; 02322EF0
	ldr r1,[pool_023230A0]	; 02322EF2
	bl P1_Utf16StrCpy	; 02322EF4
loc_02322EF8:
	add r0,sp,#0x90	; 02322EF8
	mov r1,#0x59	; 02322EFA
	bl P1_Utf16StrChr	; 02322EFC
	add r1,sp,#0x24	; 02322F00
	mov r2,#0x2	; 02322F02
	bl P1_Utf16StrNCpy	; 02322F04
	add r0,sp,#0x90	; 02322F08
	mov r1,#0x4d	; 02322F0A
	bl P1_Utf16StrChr	; 02322F0C
	add r1,sp,#0x2c	; 02322F10
	mov r2,#0x2	; 02322F12
	bl P1_Utf16StrNCpy	; 02322F14
	ldr r0,[pool_023230A4]	; 02322F18
	mov r1,#0x0	; 02322F1A
	bl loc_02328D64	; 02322F1C
	add r1,r0,#0x0	; 02322F20
	add r0,sp,#0x38	; 02322F22
	add r2,sp,#0x90	; 02322F24
	bl loc_02328CE4	; 02322F26
	mov r5,#0x0	; 02322F2A
	b loc_02322F76	; 02322F2C
loc_02322F2E:
	ldr r0,[pool_023230A4]	; 02322F2E
	add r1,r5,#0x1	; 02322F30
	bl loc_02328D64	; 02322F32
	add r6,r0,#0x0	; 02322F36
	bl loc_02324BD8	; 02322F38
	add r7,r0,#0x0	; 02322F3C
	lsl r1,r5,#0x2	; 02322F3E
	add r0,sp,#0x58	; 02322F40
	ldr r0,[r0,r1]	; 02322F42
	bl loc_02324D1C	; 02322F44
	mov r1,#0x4	; 02322F48
	ldrsb r1,[r6,r1]	; 02322F4A
	str r1,[sp,#0x0]	; 02322F4C
	mov r1,#0x5	; 02322F4E
	ldrsb r1,[r6,r1]	; 02322F50
	str r1,[sp,#0x4]	; 02322F52
	str r0,[sp,#0x8]	; 02322F54
	ldrb r0,[r6,#0x6]	; 02322F56
	str r0,[sp,#0xc]	; 02322F58
	add r0,r7,#0x0	; 02322F5A
	add r1,sp,#0x38	; 02322F5C
	mov r7,sp	; 02322F5E
	sub r7,r7,#0x4	; 02322F60
	ldrh r2,[r6,#0x0]	; 02322F62
	strh r2,[r7,#0x0]	; 02322F64
	add r3,r7,#0x0	; 02322F66
	ldmia r3!,{r2}	; 02322F68
	ldrh r3,[r6,#0x2]	; 02322F6A
	strh r3,[r7,#0x0]	; 02322F6C
	ldmia r7!,{r3}	; 02322F6E
	bl loc_02328890	; 02322F70
	add r5,r5,#0x1	; 02322F74
loc_02322F76:
	cmp r5,#0x7	; 02322F76
	bcc loc_02322F2E	; 02322F78
	ldr r0,[pool_023230A4]	; 02322F7A
	mov r1,#0x1	; 02322F7C
	bl loc_02328D64	; 02322F7E
	ldrh r1,[r0,#0x0]	; 02322F82
	add r0,sp,#0x20	; 02322F84
	strh r1,[r0,#0x2]	; 02322F86
	ldrh r1,[r0,#0x2]	; 02322F88
	strh r1,[r0,#0x0]	; 02322F8A
	mov r5,#0x0	; 02322F8C
	ldr r0,[sp,#0x48]	; 02322F8E
	ldr r1,[sp,#0x4c]	; 02322F90
	mov r2,#0x1	; 02322F92
	bl loc_02326A24	; 02322F94
	add r0,r0,#0x7	; 02322F98
	sub r0,r0,r5	; 02322F9A
	mov r1,#0x7	; 02322F9C
	blx P1_SignedDivMod	; 02322F9E
	add r7,r1,#0x0	; 02322FA2
	ldr r0,[r4,#0x0]	; 02322FA4
	add r0,r7,r0	; 02322FA6
	sub r0,r0,#0x1	; 02322FA8
	mov r1,#0x7	; 02322FAA
	blx P1_SignedDivMod	; 02322FAC
	lsl r0,r1,#0x4	; 02322FB0
	strh r0,[r4,#0xc]	; 02322FB2
	ldr r0,[r4,#0x0]	; 02322FB4
	add r0,r7,r0	; 02322FB6
	sub r0,r0,#0x1	; 02322FB8
	mov r1,#0x7	; 02322FBA
	blx P1_SignedDivMod	; 02322FBC
	lsl r0,r0,#0x4	; 02322FC0
	strh r0,[r4,#0xe]	; 02322FC2
	add r4,sp,#0x20	; 02322FC4
	str r5,[sp,#0x14]	; 02322FC6
	str r5,[sp,#0x18]	; 02322FC8
	str r5,[sp,#0x1c]	; 02322FCA
	b loc_02323052	; 02322FCC
loc_02322FCE:
	add r0,r7,r5	; 02322FCE
	str r0,[sp,#0x10]	; 02322FD0
	mov r1,#0x7	; 02322FD2
	blx P1_SignedDivMod	; 02322FD4
	add r6,r1,#0x0	; 02322FD8
	add r0,sp,#0x90	; 02322FDA
	add r1,r5,#0x1	; 02322FDC
	lsl r1,r1,#0x10	; 02322FDE
	lsr r1,r1,#0x10	; 02322FE0
	bl loc_02325958	; 02322FE2
	ldr r0,[sp,#0x1c]	; 02322FE6
	ldrsh r0,[r4,r0]	; 02322FE8
	ldr r1,[pool_023230A8]	; 02322FEA
	and r0,r1	; 02322FEC
	lsl r1,r6,#0x4	; 02322FEE
	add r1,#0x88	; 02322FF0
	lsl r1,r1,#0x10	; 02322FF2
	asr r2,r1,#0x10	; 02322FF4
	ldr r1,[pool_023230AC]	; 02322FF6
	and r2,r1	; 02322FF8
	orr r0,r2	; 02322FFA
	strh r0,[r4,#0x0]	; 02322FFC
	ldr r0,[sp,#0x10]	; 02322FFE
	mov r1,#0x7	; 02323000
	blx P1_SignedDivMod	; 02323002
	mov r1,#0x2	; 02323006
	ldrsh r1,[r4,r1]	; 02323008
	ldr r2,[pool_023230A8]	; 0232300A
	and r1,r2	; 0232300C
	add r0,r0,#0x1	; 0232300E
	lsl r0,r0,#0x4	; 02323010
	add r0,#0x37	; 02323012
	lsl r0,r0,#0x10	; 02323014
	asr r2,r0,#0x10	; 02323016
	ldr r0,[pool_023230AC]	; 02323018
	and r2,r0	; 0232301A
	orr r1,r2	; 0232301C
	strh r1,[r4,#0x2]	; 0232301E
	bl loc_02324BD8	; 02323020
	mov r1,#0x1	; 02323024
	str r1,[sp,#0x0]	; 02323026
	ldr r1,[sp,#0x14]	; 02323028
	str r1,[sp,#0x4]	; 0232302A
	add r1,sp,#0x90	; 0232302C
	str r1,[sp,#0x8]	; 0232302E
	lsl r2,r6,#0x2	; 02323030
	add r1,sp,#0x74	; 02323032
	ldr r1,[r1,r2]	; 02323034
	str r1,[sp,#0xc]	; 02323036
	add r1,sp,#0x38	; 02323038
	mov r6,sp	; 0232303A
	sub r6,r6,#0x4	; 0232303C
	ldrh r2,[r4,#0x0]	; 0232303E
	strh r2,[r6,#0x0]	; 02323040
	add r3,r6,#0x0	; 02323042
	ldmia r3!,{r2}	; 02323044
	ldrh r3,[r4,#0x2]	; 02323046
	strh r3,[r6,#0x0]	; 02323048
	ldmia r6!,{r3}	; 0232304A
	bl loc_02328890	; 0232304C
	add r5,r5,#0x1	; 02323050
loc_02323052:
	ldr r0,[sp,#0x48]	; 02323052
	ldr r1,[sp,#0x4c]	; 02323054
	ldr r2,[sp,#0x18]	; 02323056
	bl loc_02326A88	; 02323058
	cmp r5,r0	; 0232305C
	bcc loc_02322FCE	; 0232305E
	ldr r0,[sp,#0x48]	; 02323060
	ldr r1,[sp,#0x4c]	; 02323062
	mov r2,#0x0	; 02323064
	bl loc_02322DFC	; 02323066
	cmp r0,#0x0	; 0232306A
	beq loc_02323076	; 0232306C
	mov r0,#0x1	; 0232306E
	bl loc_02322DAC	; 02323070
	b loc_0232307C	; 02323074
loc_02323076:
	mov r0,#0x0	; 02323076
	bl loc_02322DAC	; 02323078
loc_0232307C:
	add sp,#0xb4	; 0232307C
	pop {r4,r5,r6,r7}	; 0232307E
	pop {r3}	; 02323080
	bx r3	; 02323082
pool_02323084:
loc_02323084:
	.word 0x02330AB0	; 02323084
pool_02323088:
loc_02323088:
	.word 0x02330ACC	; 02323088
pool_0232308C:
loc_0232308C:
	.word 0x00006000	; 0232308C
pool_02323090:
loc_02323090:
	.word 0x00000100	; 02323090
pool_02323094:
loc_02323094:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02323094
pool_02323098:
loc_02323098:
	.word 0x02330AE8	; 02323098
pool_0232309C:
loc_0232309C:
	.word 0x02330AF8	; 0232309C
pool_023230A0:
loc_023230A0:
	.word 0x02330B08	; 023230A0
pool_023230A4:
loc_023230A4:
	.word 0x023A0B3C	; 023230A4
pool_023230A8:
loc_023230A8:
	.word 0xFFFFF000	; 023230A8
pool_023230AC:
loc_023230AC:
	.word 0x00000FFF	; 023230AC

; ===== function loc_023230B0 =====
loc_023230B0:
	ldr r0,[pool_023230B8]	; 023230B0
	ldr r3,[pool_023230BC]	; 023230B2
	bx r3	; 023230B4
	.byte 0xC0, 0x46	; 023230B8
pool_023230B8:
loc_023230B8:
	.word 0x023323E4	; 023230B8
pool_023230BC:
loc_023230BC:
	.word loc_02322D4C + 1	; 023230BC

; ===== function loc_023230C0 =====
loc_023230C0:
	ldr r0,[pool_023230C8]	; 023230C0
	ldr r3,[pool_023230CC]	; 023230C2
	bx r3	; 023230C4
	.byte 0xC0, 0x46	; 023230C8
pool_023230C8:
loc_023230C8:
	.word 0x023323E4	; 023230C8
pool_023230CC:
loc_023230CC:
	.word loc_02322E38 + 1	; 023230CC

; ===== function loc_023230D0 =====
loc_023230D0:
	ldr r0,[pool_023230D8]	; 023230D0
	ldr r3,[pool_023230DC]	; 023230D2
	bx r3	; 023230D4
	.byte 0xC0, 0x46	; 023230D8
pool_023230D8:
loc_023230D8:
	.word 0x023323E4	; 023230D8
pool_023230DC:
loc_023230DC:
	.word loc_02322E38 + 1	; 023230DC

; ===== function loc_023230E0 =====
loc_023230E0:
	push {r4,r5,lr}	; 023230E0
	sub sp,#0x24	; 023230E2
	ldr r0,[pool_023232A4]	; 023230E4
	ldr r1,[r0,#0x8]	; 023230E6
	cmp r1,#0x0	; 023230E8
	bne loc_023230EE	; 023230EA
	b loc_0232329A	; 023230EC
loc_023230EE:
	ldr r1,[r0,#0x4]	; 023230EE
	cmp r1,#0xa	; 023230F0
	bge loc_023230F8	; 023230F2
	add r1,r1,#0x1	; 023230F4
	str r1,[r0,#0x4]	; 023230F6
loc_023230F8:
	ldr r0,[pool_023232A4]	; 023230F8
	ldr r0,[r0,#0x4]	; 023230FA
	lsl r0,r0,#0x4	; 023230FC
	mov r1,#0xa	; 023230FE
	blx P1_SignedDivMod	; 02323100
	add r4,r0,#0x0	; 02323104
	sub r4,#0x10	; 02323106
	add r0,sp,#0x10	; 02323108
	bl loc_02326364	; 0232310A
	ldr r0,[pool_023232A8]	; 0232310E
	ldr r1,[r0,#0x0]	; 02323110
	add r1,r1,#0x1	; 02323112
	str r1,[r0,#0x0]	; 02323114
	cmp r1,#0x1e	; 02323116
	bge loc_02323122	; 02323118
	mov r1,#0x7f	; 0232311A
	add r0,sp,#0xc	; 0232311C
	strh r1,[r0,#0x8]	; 0232311E
	b loc_0232312A	; 02323120
loc_02323122:
	cmp r1,#0x3c	; 02323122
	bne loc_0232312A	; 02323124
	mov r1,#0x0	; 02323126
	str r1,[r0,#0x0]	; 02323128
loc_0232312A:
	ldr r0,[pool_023232AC]	; 0232312A
	add r1,sp,#0x10	; 0232312C
	bl loc_02324A80	; 0232312E
	add r0,sp,#0x10	; 02323132
	bl loc_02326314	; 02323134
	ldr r0,[pool_023232B0]	; 02323138
	add r1,sp,#0x10	; 0232313A
	bl loc_02324A80	; 0232313C
	bl loc_02323DC0	; 02323140
	add r5,r0,#0x0	; 02323144
	mov r0,#0x1	; 02323146
	str r0,[sp,#0x0]	; 02323148
	ldr r0,[pool_023232AC]	; 0232314A
	mov r1,#0x0	; 0232314C
	add r2,r4,#0x0	; 0232314E
	add r3,r1,#0x0	; 02323150
	bl loc_023236B8	; 02323152
	mov r0,#0x1	; 02323156
	str r0,[sp,#0x0]	; 02323158
	ldr r0,[pool_023232B0]	; 0232315A
	mov r1,#0x0	; 0232315C
	add r2,r4,#0x0	; 0232315E
	add r3,r1,#0x0	; 02323160
	bl loc_023236B8	; 02323162
	mov r0,#0x1	; 02323166
	str r0,[sp,#0x0]	; 02323168
	ldr r0,[pool_023232B4]	; 0232316A
	mov r1,#0x0	; 0232316C
	add r2,r4,#0x0	; 0232316E
	add r3,r1,#0x0	; 02323170
	bl loc_023236B8	; 02323172
	mov r0,#0x0	; 02323176
	str r0,[sp,#0x0]	; 02323178
	str r4,[sp,#0x4]	; 0232317A
	add r0,r5,#0x0	; 0232317C
	ldr r1,[pool_023232B8]	; 0232317E
	ldr r2,[pool_023232BC]	; 02323180
	mov r3,#0x6	; 02323182
	bl loc_02323B78	; 02323184
	mov r0,#0x0	; 02323188
	str r0,[sp,#0x0]	; 0232318A
	str r4,[sp,#0x4]	; 0232318C
	add r0,r5,#0x0	; 0232318E
	ldr r1,[pool_023232B8]	; 02323190
	ldr r2,[pool_023232BC]	; 02323192
	mov r3,#0x7	; 02323194
	bl loc_02323B78	; 02323196
	mov r0,#0x0	; 0232319A
	str r0,[sp,#0x0]	; 0232319C
	str r4,[sp,#0x4]	; 0232319E
	add r0,r5,#0x0	; 023231A0
	ldr r1,[pool_023232B8]	; 023231A2
	ldr r2,[pool_023232BC]	; 023231A4
	mov r3,#0x8	; 023231A6
	bl loc_02323B78	; 023231A8
	mov r0,#0x0	; 023231AC
	str r0,[sp,#0x0]	; 023231AE
	str r4,[sp,#0x4]	; 023231B0
	add r0,r5,#0x0	; 023231B2
	ldr r1,[pool_023232B8]	; 023231B4
	ldr r2,[pool_023232BC]	; 023231B6
	mov r3,#0x9	; 023231B8
	bl loc_02323B78	; 023231BA
	mov r0,#0x0	; 023231BE
	str r0,[sp,#0x0]	; 023231C0
	str r4,[sp,#0x4]	; 023231C2
	add r0,r5,#0x0	; 023231C4
	ldr r1,[pool_023232B8]	; 023231C6
	ldr r2,[pool_023232BC]	; 023231C8
	mov r3,#0xa	; 023231CA
	bl loc_02323B78	; 023231CC
	bl loc_02325694	; 023231D0
	ldr r0,[r0,#0x4]	; 023231D4
	mov r1,#0x14	; 023231D6
	blx P1_UnsignedDivMod	; 023231D8
	cmp r1,#0x1	; 023231DC
	bne loc_02323206	; 023231DE
	add r0,sp,#0xc	; 023231E0
	bl loc_0232F70C	; 023231E2
	cmp r0,#0x0	; 023231E6
	bne loc_02323200	; 023231E8
	ldr r0,[sp,#0xc]	; 023231EA
	cmp r0,#0x0	; 023231EC
	bne loc_023231F8	; 023231EE
	mov r1,#0x1	; 023231F0
	ldr r0,[pool_023232C0]	; 023231F2
	str r1,[r0,#0x0]	; 023231F4
	b loc_02323206	; 023231F6
loc_023231F8:
	mov r1,#0x0	; 023231F8
	ldr r0,[pool_023232C0]	; 023231FA
	str r1,[r0,#0x0]	; 023231FC
	b loc_02323206	; 023231FE
loc_02323200:
	mov r1,#0x1	; 02323200
	ldr r0,[pool_023232C0]	; 02323202
	str r1,[r0,#0x0]	; 02323204
loc_02323206:
	ldr r0,[pool_023232C4]	; 02323206
	ldr r1,[r0,#0x0]	; 02323208
	add r1,r1,#0x1	; 0232320A
	str r1,[r0,#0x0]	; 0232320C
	cmp r1,#0x3c	; 0232320E
	bne loc_02323216	; 02323210
	mov r1,#0x0	; 02323212
	str r1,[r0,#0x0]	; 02323214
loc_02323216:
	ldr r0,[pool_023232C0]	; 02323216
	ldr r1,[r0,#0x0]	; 02323218
	cmp r1,#0x0	; 0232321A
	bne loc_02323226	; 0232321C
	ldr r0,[pool_023232C4]	; 0232321E
	ldr r0,[r0,#0x0]	; 02323220
	cmp r0,#0x1e	; 02323222
	bge loc_02323240	; 02323224
loc_02323226:
	cmp r1,#0x0	; 02323226
	beq loc_0232322E	; 02323228
	mov r3,#0xb	; 0232322A
	b loc_02323230	; 0232322C
loc_0232322E:
	mov r3,#0x5	; 0232322E
loc_02323230:
	mov r0,#0x0	; 02323230
	str r0,[sp,#0x0]	; 02323232
	str r4,[sp,#0x4]	; 02323234
	add r0,r5,#0x0	; 02323236
	ldr r1,[pool_023232B8]	; 02323238
	ldr r2,[pool_023232BC]	; 0232323A
	bl loc_02323B78	; 0232323C
loc_02323240:
	ldr r0,[pool_023232C8]	; 02323240
	ldrh r0,[r0,#0x0]	; 02323242
	lsl r0,r0,#0x1c	; 02323244
	lsr r0,r0,#0x1f	; 02323246
	cmp r0,#0x0	; 02323248
	beq loc_02323250	; 0232324A
	mov r3,#0xc	; 0232324C
	b loc_02323252	; 0232324E
loc_02323250:
	mov r3,#0x2	; 02323250
loc_02323252:
	mov r0,#0x0	; 02323252
	str r0,[sp,#0x0]	; 02323254
	str r4,[sp,#0x4]	; 02323256
	add r0,r5,#0x0	; 02323258
	ldr r1,[pool_023232B8]	; 0232325A
	ldr r2,[pool_023232BC]	; 0232325C
	bl loc_02323B78	; 0232325E
	ldr r0,[pool_023232C8]	; 02323262
	ldrh r0,[r0,#0x0]	; 02323264
	lsl r0,r0,#0x19	; 02323266
	lsr r0,r0,#0x1f	; 02323268
	cmp r0,#0x0	; 0232326A
	beq loc_02323272	; 0232326C
	mov r3,#0x3	; 0232326E
	b loc_02323274	; 02323270
loc_02323272:
	mov r3,#0x4	; 02323272
loc_02323274:
	mov r0,#0x0	; 02323274
	str r0,[sp,#0x0]	; 02323276
	str r4,[sp,#0x4]	; 02323278
	add r0,r5,#0x0	; 0232327A
	ldr r1,[pool_023232B8]	; 0232327C
	ldr r2,[pool_023232BC]	; 0232327E
	bl loc_02323B78	; 02323280
	mov r0,#0x0	; 02323284
	str r0,[sp,#0x0]	; 02323286
	str r4,[sp,#0x4]	; 02323288
	mov r0,#0xf	; 0232328A
	str r0,[sp,#0x8]	; 0232328C
	add r0,r5,#0x0	; 0232328E
	ldr r1,[pool_023232B8]	; 02323290
	ldr r2,[pool_023232BC]	; 02323292
	mov r3,#0x1	; 02323294
	bl loc_02323B24	; 02323296
loc_0232329A:
	add sp,#0x24	; 0232329A
	pop {r4,r5}	; 0232329C
	pop {r3}	; 0232329E
	bx r3	; 023232A0
	.byte 0xC0, 0x46	; 023232A4
pool_023232A4:
loc_023232A4:
	.word P1_BssStart + 0x15FC	; 023232A4
pool_023232A8:
loc_023232A8:
	.word P1_BssStart + 0x1578	; 023232A8
pool_023232AC:
loc_023232AC:
	.word 0x023323FC	; 023232AC
pool_023232B0:
loc_023232B0:
	.word 0x02332428	; 023232B0
pool_023232B4:
loc_023232B4:
	.word 0x02332454	; 023232B4
pool_023232B8:
loc_023232B8:
	.word 0x023BB898	; 023232B8
pool_023232BC:
loc_023232BC:
	.word 0x0239FF2C	; 023232BC
pool_023232C0:
loc_023232C0:
	.word P1_Data_02330B18	; 023232C0
pool_023232C4:
loc_023232C4:
	.word P1_BssStart + 0x1574	; 023232C4
pool_023232C8:
loc_023232C8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023232C8

; ===== function loc_023232CC =====
loc_023232CC:
	push {lr}	; 023232CC
	sub sp,#0x4	; 023232CE
	bl loc_02324BC4	; 023232D0
	ldr r1,[pool_0232330C]	; 023232D4
	ldr r2,[pool_02323310]	; 023232D6
	mov r3,#0x81	; 023232D8
	bl loc_02324B34	; 023232DA
	bl loc_02324BC4	; 023232DE
	ldr r1,[pool_02323314]	; 023232E2
	ldr r2,[pool_02323310]	; 023232E4
	mov r3,#0x6c	; 023232E6
	bl loc_02324B34	; 023232E8
	bl loc_02324BC4	; 023232EC
	ldr r1,[pool_02323318]	; 023232F0
	ldr r2,[pool_02323310]	; 023232F2
	mov r3,#0x6d	; 023232F4
	bl loc_02324B34	; 023232F6
	mov r1,#0x0	; 023232FA
	ldr r0,[pool_0232331C]	; 023232FC
	str r1,[r0,#0x4]	; 023232FE
	str r1,[r0,#0x8]	; 02323300
	bl loc_02323328	; 02323302
	add sp,#0x4	; 02323306
	pop {r3}	; 02323308
	bx r3	; 0232330A
pool_0232330C:
loc_0232330C:
	.word 0x02332454	; 0232330C
pool_02323310:
loc_02323310:
	.word 0x023A0B3C	; 02323310
pool_02323314:
loc_02323314:
	.word 0x023323FC	; 02323314
pool_02323318:
loc_02323318:
	.word 0x02332428	; 02323318
pool_0232331C:
loc_0232331C:
	.word P1_BssStart + 0x15FC	; 0232331C

; ===== function loc_02323320 =====
loc_02323320:
	ldr r3,[pool_02323324]	; 02323320
	bx r3	; 02323322
pool_02323324:
loc_02323324:
	.word loc_023230E0 + 1	; 02323324

; ===== function loc_02323328 =====
loc_02323328:
	push {lr}	; 02323328
	sub sp,#0x4	; 0232332A
	bl loc_023263D0	; 0232332C
	add r1,r0,#0x0	; 02323330
	ldr r0,[pool_02323340]	; 02323332
	bl loc_02324A80	; 02323334
	add sp,#0x4	; 02323338
	pop {r3}	; 0232333A
	bx r3	; 0232333C
	.byte 0xC0, 0x46	; 02323340
pool_02323340:
loc_02323340:
	.word 0x02332454	; 02323340

; ===== function loc_02323344 =====
; Stores one at a fixed runtime-block offset. / 向固定运行时块偏移写入 1。
.func P1_SetRuntimeWordAtOffset8
loc_02323344:
	mov r1,#0x1	; 02323344
	ldr r0,[pool_0232334C]	; 02323346
	str r1,[r0,#0x8]	; 02323348
	bx lr	; 0232334A
.endfunc
pool_0232334C:
loc_0232334C:
	.word P1_BssStart + 0x15FC	; 0232334C

; ===== function loc_02323350 =====
loc_02323350:
	ldr r3,[pool_02323354]	; 02323350
	bx r3	; 02323352
pool_02323354:
loc_02323354:
	.word loc_023232CC + 1	; 02323354

; ===== function loc_02323358 =====
loc_02323358:
	push {r4,lr}	; 02323358
	ldr r1,[pool_02323380]	; 0232335A
	mov r0,#0x4	; 0232335C
	ldrsh r4,[r1,r0]	; 0232335E
	sub r4,#0xf	; 02323360
	bl loc_02323384	; 02323362
	mov r1,#0xc	; 02323366
	mul r0,r1	; 02323368
	mul r4,r0	; 0232336A
	add r0,r4,#0x0	; 0232336C
	ldr r2,[pool_02323380]	; 0232336E
	mov r1,#0x6	; 02323370
	ldrsh r1,[r2,r1]	; 02323372
	sub r1,#0xf	; 02323374
	blx P1_SignedDivMod	; 02323376
	pop {r4}	; 0232337A
	pop {r3}	; 0232337C
	bx r3	; 0232337E
pool_02323380:
loc_02323380:
	.word P1_BssStart + 0x1608	; 02323380

; ===== function loc_02323384 =====
loc_02323384:
	push {lr}	; 02323384
	sub sp,#0x4	; 02323386
	ldr r0,[pool_023233A0]	; 02323388
	ldr r0,[r0,#0x20]	; 0232338A
	add r0,r0,#0x1	; 0232338C
	mov r1,#0x3	; 0232338E
	blx P1_SignedDivMod	; 02323390
	cmp r0,#0x0	; 02323394
	bne loc_0232339A	; 02323396
	mov r0,#0x1	; 02323398
loc_0232339A:
	add sp,#0x4	; 0232339A
	pop {r3}	; 0232339C
	bx r3	; 0232339E
pool_023233A0:
loc_023233A0:
	.word P1_BssStart + 0x1888	; 023233A0

; ===== function loc_023233A4 =====
loc_023233A4:
	push {r4,r5,lr}	; 023233A4
	sub sp,#0x1c	; 023233A6
	add r5,r0,#0x0	; 023233A8
	add r4,r1,#0x0	; 023233AA
	cmp r5,#0xf	; 023233AC
	bge loc_023233FC	; 023233AE
	add r0,sp,#0x0	; 023233B0
	add r1,r4,#0x2	; 023233B2
	ldrb r2,[r4,#0x1]	; 023233B4
	bl P1_Utf16StrNCpy	; 023233B6
	mov r2,#0x0	; 023233BA
	ldrb r0,[r4,#0x1]	; 023233BC
	lsl r0,r0,#0x1	; 023233BE
	add r1,sp,#0x0	; 023233C0
	strh r2,[r1,r0]	; 023233C2
	ldr r3,[pool_02323404]	; 023233C4
	mov r0,#0x2c	; 023233C6
	add r2,r5,#0x0	; 023233C8
	mul r2,r0	; 023233CA
	add r0,r3,r2	; 023233CC
	add r2,r5,#0x1	; 023233CE
	bl loc_02324A58	; 023233D0
	ldr r0,[pool_02323408]	; 023233D4
	mov r1,#0x3	; 023233D6
	bl loc_02328D64	; 023233D8
	ldrb r1,[r0,#0x6]	; 023233DC
	ldr r0,[pool_0232340C]	; 023233DE
	ldrb r2,[r4,#0x0]	; 023233E0
	lsl r2,r2,#0x1c	; 023233E2
	lsr r2,r2,#0x1c	; 023233E4
	lsl r2,r2,#0x5	; 023233E6
	add r2,r0,r2	; 023233E8
	lsl r0,r1,#0x1	; 023233EA
	add r0,r2,r0	; 023233EC
	add r1,r5,#0x1	; 023233EE
	lsl r2,r1,#0x1	; 023233F0
	ldr r1,[pool_02323410]	; 023233F2
	add r1,r2,r1	; 023233F4
	mov r2,#0x2	; 023233F6
	bl loc_0232E114	; 023233F8
loc_023233FC:
	add sp,#0x1c	; 023233FC
	pop {r4,r5}	; 023233FE
	pop {r3}	; 02323400
	bx r3	; 02323402
pool_02323404:
loc_02323404:
	.word 0x02332494	; 02323404
pool_02323408:
loc_02323408:
	.word 0x023A0894	; 02323408
pool_0232340C:
loc_0232340C:
	.word 0x023B70E0	; 0232340C
pool_02323410:
loc_02323410:
	.word 0x000001C0	; 02323410

; ===== function loc_02323414 =====
loc_02323414:
	push {r4,r5,r6,r7,lr}	; 02323414
	sub sp,#0x14	; 02323416
	bl loc_02323384	; 02323418
	ldr r0,[pool_02323514]	; 0232341C
	ldr r1,[r0,#0x0]	; 0232341E
	cmp r1,#0x3	; 02323420
	bhi loc_02323494	; 02323422
	add r1,r1,r1	; 02323424
P1_SwitchIndexPC_02323424:
	add r1,pc	; 02323426
	ldrh r1,[r1,#(P1_SwitchTable_02323424 - (P1_SwitchIndexPC_02323424 + 4))]	; 02323428
	lsl r1,r1,#0x10	; 0232342A
	asr r1,r1,#0x10	; 0232342C
P1_SwitchTargetPC_02323424:
	add r1,pc	; 0232342E
	bx r1	; 02323430
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02323424:
	.halfword (loc_0232343A + 1) - (P1_SwitchTargetPC_02323424 + 4)
	.halfword (loc_0232343C + 1) - (P1_SwitchTargetPC_02323424 + 4)
	.halfword (loc_02323494 + 1) - (P1_SwitchTargetPC_02323424 + 4)
	.halfword (loc_0232346E + 1) - (P1_SwitchTargetPC_02323424 + 4)
P1_SwitchTable_02323424End:
loc_0232343A:
	b loc_0232350C	; 0232343A
loc_0232343C:
	mov r1,#0x4	; 0232343C
	ldrsh r2,[r0,r1]	; 0232343E
	mov r1,#0x6	; 02323440
	ldrsh r1,[r0,r1]	; 02323442
	cmp r2,r1	; 02323444
	bge loc_0232344C	; 02323446
	add r1,r2,#0x1	; 02323448
	strh r1,[r0,#0x4]	; 0232344A
loc_0232344C:
	bl loc_023229F4	; 0232344C
	cmp r0,#0x11	; 02323450
	beq loc_0232345A	; 02323452
	mov r0,#0x11	; 02323454
	bl loc_02322A00	; 02323456
loc_0232345A:
	ldr r1,[pool_02323514]	; 0232345A
	mov r0,#0x4	; 0232345C
	ldrsh r2,[r1,r0]	; 0232345E
	mov r0,#0x6	; 02323460
	ldrsh r0,[r1,r0]	; 02323462
	cmp r2,r0	; 02323464
	bne loc_02323494	; 02323466
	mov r0,#0x2	; 02323468
	str r0,[r1,#0x0]	; 0232346A
	b loc_02323494	; 0232346C
loc_0232346E:
	mov r1,#0x4	; 0232346E
	ldrsh r2,[r0,r1]	; 02323470
	cmp r2,#0x0	; 02323472
	ble loc_02323486	; 02323474
	sub r2,r2,#0x1	; 02323476
	strh r2,[r0,#0x4]	; 02323478
	ldrsh r0,[r0,r1]	; 0232347A
	cmp r0,#0xf	; 0232347C
	bne loc_02323486	; 0232347E
	mov r0,#0xf	; 02323480
	bl loc_02322A00	; 02323482
loc_02323486:
	ldr r1,[pool_02323514]	; 02323486
	mov r0,#0x4	; 02323488
	ldrsh r0,[r1,r0]	; 0232348A
	cmp r0,#0x0	; 0232348C
	bne loc_02323494	; 0232348E
	mov r0,#0x0	; 02323490
	str r0,[r1,#0x0]	; 02323492
loc_02323494:
	mov r5,#0x0	; 02323494
	add r4,r5,#0x0	; 02323496
	b loc_023234E2	; 02323498
loc_0232349A:
	ldr r3,[pool_02323518]	; 0232349A
	add r2,sp,#0x8	; 0232349C
	ldmia r3!,{r0,r1}	; 0232349E
	stmia r2!,{r0,r1}	; 023234A0
	ldr r0,[r3,#0x0]	; 023234A2
	str r0,[r2,#0x0]	; 023234A4
	bl loc_023235AC	; 023234A6
	add r7,r0,#0x0	; 023234AA
	add r0,r5,#0x0	; 023234AC
	mov r1,#0x3	; 023234AE
	blx P1_SignedDivMod	; 023234B0
	add r6,r1,#0x0	; 023234B4
	add r0,r5,#0x0	; 023234B6
	mov r1,#0x3	; 023234B8
	blx P1_SignedDivMod	; 023234BA
	add r2,r0,#0x0	; 023234BE
	str r4,[sp,#0x0]	; 023234C0
	add r0,r5,#0x0	; 023234C2
	mov r1,#0x2c	; 023234C4
	mul r0,r1	; 023234C6
	ldr r1,[pool_0232351C]	; 023234C8
	add r0,r1,r0	; 023234CA
	lsl r3,r6,#0x2	; 023234CC
	add r1,sp,#0x8	; 023234CE
	ldr r1,[r1,r3]	; 023234D0
	mov r3,#0xc	; 023234D2
	mul r2,r3	; 023234D4
	sub r3,r3,r7	; 023234D6
	add r2,r2,r3	; 023234D8
	add r3,r4,#0x0	; 023234DA
	bl loc_023236B8	; 023234DC
	add r5,r5,#0x1	; 023234E0
loc_023234E2:
	ldr r0,[pool_02323520]	; 023234E2
	ldr r0,[r0,#0x20]	; 023234E4
	sub r0,r0,#0x1	; 023234E6
	cmp r5,r0	; 023234E8
	blt loc_0232349A	; 023234EA
	bl loc_02323DC0	; 023234EC
	add r4,r0,#0x0	; 023234F0
	bl loc_023235AC	; 023234F2
	mov r1,#0x0	; 023234F6
	str r1,[sp,#0x0]	; 023234F8
	mov r1,#0xc	; 023234FA
	sub r0,r1,r0	; 023234FC
	str r0,[sp,#0x4]	; 023234FE
	add r0,r4,#0x0	; 02323500
	ldr r1,[pool_02323524]	; 02323502
	ldr r2,[pool_02323528]	; 02323504
	mov r3,#0x11	; 02323506
	bl loc_02323B78	; 02323508
loc_0232350C:
	add sp,#0x14	; 0232350C
	pop {r4,r5,r6,r7}	; 0232350E
	pop {r3}	; 02323510
	bx r3	; 02323512
pool_02323514:
loc_02323514:
	.word P1_BssStart + 0x1608	; 02323514
pool_02323518:
loc_02323518:
	.word 0x02330B1C	; 02323518
pool_0232351C:
loc_0232351C:
	.word 0x02332494	; 0232351C
pool_02323520:
loc_02323520:
	.word P1_BssStart + 0x1888	; 02323520
pool_02323524:
loc_02323524:
	.word 0x023BB898	; 02323524
pool_02323528:
loc_02323528:
	.word 0x0239F98C	; 02323528

; ===== function loc_0232352C =====
loc_0232352C:
	mov r1,#0x3	; 0232352C
	ldr r0,[pool_02323534]	; 0232352E
	str r1,[r0,#0x0]	; 02323530
	bx lr	; 02323532
pool_02323534:
loc_02323534:
	.word P1_BssStart + 0x1608	; 02323534

; ===== function loc_02323538 =====
loc_02323538:
	push {r4,r5,r6,r7,lr}	; 02323538
	sub sp,#0x4	; 0232353A
	add r5,r0,#0x0	; 0232353C
	ldr r0,[pool_02323598]	; 0232353E
	str r5,[r0,#0x8]	; 02323540
	mov r1,#0x1	; 02323542
	str r1,[r0,#0x0]	; 02323544
	mov r4,#0x0	; 02323546
	add r6,r4,#0x0	; 02323548
	ldr r7,[pool_0232359C]	; 0232354A
loc_0232354C:
	ldrh r1,[r5,r7]	; 0232354C
	mov r0,#0x2	; 0232354E
	lsl r0,r4	; 02323550
	and r1,r0	; 02323552
	cmp r1,#0x0	; 02323554
	beq loc_0232356C	; 02323556
	add r0,r6,#0x0	; 02323558
	ldr r1,[pool_023235A0]	; 0232355A
	add r3,r5,r1	; 0232355C
	add r2,r4,#0x0	; 0232355E
	mov r1,#0x16	; 02323560
	mul r2,r1	; 02323562
	add r1,r3,r2	; 02323564
	bl loc_023233A4	; 02323566
	add r6,r6,#0x1	; 0232356A
loc_0232356C:
	add r4,r4,#0x1	; 0232356C
	cmp r4,#0xf	; 0232356E
	blt loc_0232354C	; 02323570
	ldr r0,[pool_023235A4]	; 02323572
	ldrb r1,[r5,r0]	; 02323574
	ldr r0,[pool_023235A8]	; 02323576
	str r1,[r0,#0x20]	; 02323578
	mov r1,#0x0	; 0232357A
	ldr r0,[pool_02323598]	; 0232357C
	strh r1,[r0,#0x4]	; 0232357E
	bl loc_02323384	; 02323580
	mov r1,#0x3	; 02323584
	mul r0,r1	; 02323586
	add r0,#0xf	; 02323588
	ldr r1,[pool_02323598]	; 0232358A
	strh r0,[r1,#0x6]	; 0232358C
	add sp,#0x4	; 0232358E
	pop {r4,r5,r6,r7}	; 02323590
	pop {r3}	; 02323592
	bx r3	; 02323594
	.byte 0xC0, 0x46	; 02323598
pool_02323598:
loc_02323598:
	.word P1_BssStart + 0x1608	; 02323598
pool_0232359C:
loc_0232359C:
	.word 0x0000035A	; 0232359C
pool_023235A0:
loc_023235A0:
	.word 0x0000035E	; 023235A0
pool_023235A4:
loc_023235A4:
	.word 0x00000358	; 023235A4
pool_023235A8:
loc_023235A8:
	.word P1_BssStart + 0x1888	; 023235A8

; ===== function loc_023235AC =====
loc_023235AC:
	push {lr}	; 023235AC
	sub sp,#0x4	; 023235AE
	bl loc_02323358	; 023235B0
	cmp r0,#0x0	; 023235B4
	bge loc_023235BC	; 023235B6
	mov r0,#0x0	; 023235B8
	b loc_023235C0	; 023235BA
loc_023235BC:
	bl loc_02323358	; 023235BC
loc_023235C0:
	add sp,#0x4	; 023235C0
	pop {r3}	; 023235C2
	bx r3	; 023235C4
	.byte 0x00, 0x00	; 023235C8

; ===== function loc_023235C8 =====
loc_023235C8:
	push {r4,r5,r6,r7,lr}	; 023235C8
	sub sp,#0x4	; 023235CA
	ldr r0,[pool_02323608]	; 023235CC
	mov r1,#0x0	; 023235CE
	ldr r2,[pool_0232360C]	; 023235D0
	blx loc_0232E3D0	; 023235D2
	mov r5,#0x0	; 023235D6
	ldr r4,[pool_02323610]	; 023235D8
	ldr r7,[pool_02323614]	; 023235DA
	mov r6,#0x2c	; 023235DC
loc_023235DE:
	bl loc_02324BC4	; 023235DE
	add r1,r5,#0x0	; 023235E2
	mul r1,r6	; 023235E4
	add r1,r4,r1	; 023235E6
	add r2,r7,#0x0	; 023235E8
	mov r3,#0x3	; 023235EA
	bl loc_02324B10	; 023235EC
	add r5,r5,#0x1	; 023235F0
	cmp r5,#0xf	; 023235F2
	blt loc_023235DE	; 023235F4
	mov r1,#0x0	; 023235F6
	ldr r0,[pool_02323608]	; 023235F8
	str r1,[r0,#0x0]	; 023235FA
	mov r1,#0x1e	; 023235FC
	strh r1,[r0,#0x6]	; 023235FE
	add sp,#0x4	; 02323600
	pop {r4,r5,r6,r7}	; 02323602
	pop {r3}	; 02323604
	bx r3	; 02323606
pool_02323608:
loc_02323608:
	.word P1_BssStart + 0x1608	; 02323608
pool_0232360C:
loc_0232360C:
	.word 0x000002A4	; 0232360C
pool_02323610:
loc_02323610:
	.word 0x02332494	; 02323610
pool_02323614:
loc_02323614:
	.word 0x023A0894	; 02323614

; ===== function loc_02323618 =====
	push {lr}	; 02323618
	sub sp,#0x4	; 0232361A
	bl loc_02328FF0	; 0232361C
	ldr r0,[pool_02323630]	; 02323620
	ldr r1,[pool_02323634]	; 02323622
	mov r2,#0x1	; 02323624
	bl loc_02329010	; 02323626
	add sp,#0x4	; 0232362A
	pop {r3}	; 0232362C
	bx r3	; 0232362E
pool_02323630:
loc_02323630:
	.word 0x023327C0	; 02323630
pool_02323634:
loc_02323634:
	.word 0x00001000	; 02323634

; ===== function loc_02323638 =====
loc_02323638:
	mov r1,#0x0	; 02323638
	ldr r3,[pool_02323640]	; 0232363A
	bx r3	; 0232363C
	.byte 0xC0, 0x46	; 02323640
pool_02323640:
loc_02323640:
	.word loc_02329E40 + 1	; 02323640

; ===== function loc_02323644 =====
loc_02323644:
	add r2,r0,#0x0	; 02323644
	add r0,r1,#0x0	; 02323646
	mov r1,#0x0	; 02323648
	ldr r3,[pool_02323650]	; 0232364A
	bx r3	; 0232364C
	.byte 0xC0, 0x46	; 02323650
pool_02323650:
loc_02323650:
	.word loc_0232AA48 + 1	; 02323650
loc_02323654:
	ldr r3,[pool_02323658]	; 02323654
	bx r3	; 02323656
pool_02323658:
loc_02323658:
	.word loc_02329E38 + 1	; 02323658

; ===== function loc_0232365C =====
loc_0232365C:
	add r2,r0,#0x0	; 0232365C
	ldr r0,[pool_02323668]	; 0232365E
	mov r1,#0x0	; 02323660
	ldr r3,[pool_0232366C]	; 02323662
	bx r3	; 02323664
	.byte 0xC0, 0x46	; 02323668
pool_02323668:
loc_02323668:
	.word 0x0233272C	; 02323668
pool_0232366C:
loc_0232366C:
	.word loc_0232AA48 + 1	; 0232366C

; ===== function loc_02323670 =====
loc_02323670:
	ldr r3,[pool_02323674]	; 02323670
	bx r3	; 02323672
pool_02323674:
loc_02323674:
	.word loc_0232994C + 1	; 02323674

; ===== function loc_02323678 =====
loc_02323678:
	push {lr}	; 02323678
	sub sp,#0x4	; 0232367A
	bl loc_02329970	; 0232367C
	ldr r0,[pool_023236A4]	; 02323680
	ldr r1,[pool_023236A8]	; 02323682
	mov r2,#0x1	; 02323684
	bl loc_02329010	; 02323686
	ldr r0,[pool_023236AC]	; 0232368A
	ldr r1,[pool_023236B0]	; 0232368C
	bl loc_0232A694	; 0232368E
	mov r0,#0x0	; 02323692
	bl loc_0232AAB0	; 02323694
	ldr r0,[pool_023236B4]	; 02323698
	bl loc_02329E38	; 0232369A
	add sp,#0x4	; 0232369E
	pop {r3}	; 023236A0
	bx r3	; 023236A2
pool_023236A4:
loc_023236A4:
	.word 0x023327C0	; 023236A4
pool_023236A8:
loc_023236A8:
	.word 0x00001000	; 023236A8
pool_023236AC:
loc_023236AC:
	.word 0x02332730	; 023236AC
pool_023236B0:
loc_023236B0:
	.word 0x023A6198	; 023236B0
pool_023236B4:
loc_023236B4:
	.word 0x0233272C	; 023236B4

; ===== function loc_023236B8 =====
loc_023236B8:
	push {r4,r5,r6,r7,lr}	; 023236B8
	sub sp,#0x2c	; 023236BA
	add r5,r0,#0x0	; 023236BC
	str r1,[sp,#0x0]	; 023236BE
	str r2,[sp,#0x4]	; 023236C0
	add r6,r3,#0x0	; 023236C2
	ldr r0,[r5,#0x24]	; 023236C4
	ldrh r0,[r0,#0x10]	; 023236C6
	cmp r0,#0x0	; 023236C8
	beq loc_023236D4	; 023236CA
	bl loc_02323DC0	; 023236CC
	str r0,[sp,#0x8]	; 023236D0
	b loc_023236DA	; 023236D2
loc_023236D4:
	bl loc_02323DB8	; 023236D4
	str r0,[sp,#0x8]	; 023236D8
loc_023236DA:
	ldr r0,[r5,#0x10]	; 023236DA
	bl loc_02323818	; 023236DC
	mov r1,#0x4	; 023236E0
	blx P1_SignedDivMod	; 023236E2
	str r0,[sp,#0xc]	; 023236E6
	mov r4,#0x0	; 023236E8
	ldr r0,[sp,#0x40]	; 023236EA
	lsl r0,r0,#0xa	; 023236EC
	str r0,[sp,#0x18]	; 023236EE
	lsl r0,r6,#0xa	; 023236F0
	str r0,[sp,#0x1c]	; 023236F2
	str r4,[sp,#0x20]	; 023236F4
	b loc_02323756	; 023236F6
loc_023236F8:
	ldrh r0,[r5,#0x16]	; 023236F8
	str r0,[sp,#0x14]	; 023236FA
	ldrh r1,[r5,#0x14]	; 023236FC
	ldr r0,[sp,#0xc]	; 023236FE
	mul r0,r4	; 02323700
	add r0,r1,r0	; 02323702
	str r0,[sp,#0x10]	; 02323704
	ldr r7,[r5,#0x10]	; 02323706
	mov r0,#0xa	; 02323708
	ldrsh r1,[r5,r0]	; 0232370A
	ldr r0,[sp,#0x4]	; 0232370C
	add r6,r1,r0	; 0232370E
	add r0,r7,#0x0	; 02323710
	bl loc_02323768	; 02323712
	mov r1,#0x8	; 02323716
	ldrsh r2,[r5,r1]	; 02323718
	ldr r1,[sp,#0x0]	; 0232371A
	add r2,r2,r1	; 0232371C
	add r1,r4,#0x0	; 0232371E
	mul r1,r0	; 02323720
	add r1,r2,r1	; 02323722
	ldr r0,[pool_02323764]	; 02323724
	and r1,r0	; 02323726
	lsl r1,r1,#0x10	; 02323728
	mov r0,#0xff	; 0232372A
	and r6,r0	; 0232372C
	ldr r0,[sp,#0x18]	; 0232372E
	orr r6,r0	; 02323730
	orr r7,r6	; 02323732
	orr r1,r7	; 02323734
	str r1,[sp,#0x24]	; 02323736
	ldr r0,[sp,#0x14]	; 02323738
	lsl r2,r0,#0xc	; 0232373A
	ldr r1,[sp,#0x10]	; 0232373C
	ldr r0,[sp,#0x1c]	; 0232373E
	orr r1,r0	; 02323740
	str r1,[sp,#0x10]	; 02323742
	orr r2,r1	; 02323744
	add r0,sp,#0x24	; 02323746
	strh r2,[r0,#0x4]	; 02323748
	ldr r0,[sp,#0x8]	; 0232374A
	add r1,sp,#0x24	; 0232374C
	ldr r2,[sp,#0x20]	; 0232374E
	bl loc_023238D8	; 02323750
	add r4,r4,#0x1	; 02323754
loc_02323756:
	ldrh r0,[r5,#0x18]	; 02323756
	cmp r4,r0	; 02323758
	blt loc_023236F8	; 0232375A
	add sp,#0x2c	; 0232375C
	pop {r4,r5,r6,r7}	; 0232375E
	pop {r3}	; 02323760
	bx r3	; 02323762
pool_02323764:
loc_02323764:
	.word 0x000001FF	; 02323764

; ===== function loc_02323768 =====
loc_02323768:
	ldr r1,[pool_023237EC]	; 02323768
	cmp r0,r1	; 0232376A
	bgt loc_023237A4	; 0232376C
	cmp r0,r1	; 0232376E
	bge loc_023237E0	; 02323770
	ldr r1,[pool_023237F0]	; 02323772
	cmp r0,r1	; 02323774
	bgt loc_02323790	; 02323776
	cmp r0,r1	; 02323778
	bge loc_023237DC	; 0232377A
	ldr r1,[pool_023237F4]	; 0232377C
	cmp r0,r1	; 0232377E
	bgt loc_02323788	; 02323780
	cmp r0,r1	; 02323782
	beq loc_023237E0	; 02323784
	b loc_023237E8	; 02323786
loc_02323788:
	ldr r1,[pool_023237F8]	; 02323788
	cmp r0,r1	; 0232378A
	beq loc_023237E0	; 0232378C
	b loc_023237E8	; 0232378E
loc_02323790:
	ldr r1,[pool_023237FC]	; 02323790
	cmp r0,r1	; 02323792
	bgt loc_0232379C	; 02323794
	cmp r0,r1	; 02323796
	beq loc_023237E4	; 02323798
	b loc_023237E8	; 0232379A
loc_0232379C:
	ldr r1,[pool_02323800]	; 0232379C
	cmp r0,r1	; 0232379E
	beq loc_023237E4	; 023237A0
	b loc_023237E8	; 023237A2
loc_023237A4:
	ldr r1,[pool_02323804]	; 023237A4
	cmp r0,r1	; 023237A6
	bgt loc_023237C0	; 023237A8
	cmp r0,r1	; 023237AA
	bge loc_023237D8	; 023237AC
	cmp r0,#0x0	; 023237AE
	bgt loc_023237B8	; 023237B0
	cmp r0,#0x0	; 023237B2
	beq loc_023237D8	; 023237B4
	b loc_023237E8	; 023237B6
loc_023237B8:
	ldr r1,[pool_02323808]	; 023237B8
	cmp r0,r1	; 023237BA
	beq loc_023237DC	; 023237BC
	b loc_023237E8	; 023237BE
loc_023237C0:
	ldr r1,[pool_0232380C]	; 023237C0
	cmp r0,r1	; 023237C2
	bgt loc_023237D2	; 023237C4
	cmp r0,r1	; 023237C6
	bge loc_023237E0	; 023237C8
	ldr r1,[pool_02323810]	; 023237CA
	cmp r0,r1	; 023237CC
	beq loc_023237DC	; 023237CE
	b loc_023237E8	; 023237D0
loc_023237D2:
	ldr r1,[pool_02323814]	; 023237D2
	cmp r0,r1	; 023237D4
	bne loc_023237E8	; 023237D6
loc_023237D8:
	mov r0,#0x8	; 023237D8
	bx lr	; 023237DA
loc_023237DC:
	mov r0,#0x10	; 023237DC
	bx lr	; 023237DE
loc_023237E0:
	mov r0,#0x20	; 023237E0
	bx lr	; 023237E2
loc_023237E4:
	mov r0,#0x40	; 023237E4
	bx lr	; 023237E6
loc_023237E8:
	mov r0,#0x0	; 023237E8
	bx lr	; 023237EA
pool_023237EC:
loc_023237EC:
	.word 0xC0008000	; 023237EC
pool_023237F0:
loc_023237F0:
	.word 0x80008000	; 023237F0
pool_023237F4:
loc_023237F4:
	.word 0x80000000	; 023237F4
pool_023237F8:
loc_023237F8:
	.word 0x80004000	; 023237F8
pool_023237FC:
loc_023237FC:
	.word 0xC0000000	; 023237FC
pool_02323800:
loc_02323800:
	.word 0xC0004000	; 02323800
pool_02323804:
loc_02323804:
	.word 0x00008000	; 02323804
pool_02323808:
loc_02323808:
	.word 0x00004000	; 02323808
pool_0232380C:
loc_0232380C:
	.word 0x40004000	; 0232380C
pool_02323810:
loc_02323810:
	.word 0x40000000	; 02323810
pool_02323814:
loc_02323814:
	.word 0x40008000	; 02323814

; ===== function loc_02323818 =====
loc_02323818:
	ldr r1,[pool_023238AC]	; 02323818
	cmp r0,r1	; 0232381A
	bgt loc_02323854	; 0232381C
	cmp r0,r1	; 0232381E
	bge loc_0232389E	; 02323820
	ldr r1,[pool_023238B0]	; 02323822
	cmp r0,r1	; 02323824
	bgt loc_02323840	; 02323826
	cmp r0,r1	; 02323828
	bge loc_02323896	; 0232382A
	ldr r1,[pool_023238B4]	; 0232382C
	cmp r0,r1	; 0232382E
	bgt loc_02323838	; 02323830
	cmp r0,r1	; 02323832
	beq loc_0232389A	; 02323834
	b loc_023238A6	; 02323836
loc_02323838:
	ldr r1,[pool_023238B8]	; 02323838
	cmp r0,r1	; 0232383A
	beq loc_02323896	; 0232383C
	b loc_023238A6	; 0232383E
loc_02323840:
	ldr r1,[pool_023238BC]	; 02323840
	cmp r0,r1	; 02323842
	bgt loc_0232384C	; 02323844
	cmp r0,r1	; 02323846
	beq loc_023238A2	; 02323848
	b loc_023238A6	; 0232384A
loc_0232384C:
	ldr r1,[pool_023238C0]	; 0232384C
	cmp r0,r1	; 0232384E
	beq loc_0232389E	; 02323850
	b loc_023238A6	; 02323852
loc_02323854:
	ldr r1,[pool_023238C4]	; 02323854
	cmp r0,r1	; 02323856
	bgt loc_02323870	; 02323858
	cmp r0,r1	; 0232385A
	bge loc_0232388E	; 0232385C
	cmp r0,#0x0	; 0232385E
	bgt loc_02323868	; 02323860
	cmp r0,#0x0	; 02323862
	beq loc_0232388A	; 02323864
	b loc_023238A6	; 02323866
loc_02323868:
	ldr r1,[pool_023238C8]	; 02323868
	cmp r0,r1	; 0232386A
	beq loc_0232388E	; 0232386C
	b loc_023238A6	; 0232386E
loc_02323870:
	ldr r1,[pool_023238CC]	; 02323870
	cmp r0,r1	; 02323872
	bgt loc_02323882	; 02323874
	cmp r0,r1	; 02323876
	bge loc_02323892	; 02323878
	ldr r1,[pool_023238D0]	; 0232387A
	cmp r0,r1	; 0232387C
	beq loc_02323892	; 0232387E
	b loc_023238A6	; 02323880
loc_02323882:
	ldr r1,[pool_023238D4]	; 02323882
	cmp r0,r1	; 02323884
	beq loc_02323892	; 02323886
	b loc_023238A6	; 02323888
loc_0232388A:
	mov r0,#0x1	; 0232388A
	bx lr	; 0232388C
loc_0232388E:
	mov r0,#0x2	; 0232388E
	bx lr	; 02323890
loc_02323892:
	mov r0,#0x4	; 02323892
	bx lr	; 02323894
loc_02323896:
	mov r0,#0x8	; 02323896
	bx lr	; 02323898
loc_0232389A:
	mov r0,#0x10	; 0232389A
	bx lr	; 0232389C
loc_0232389E:
	mov r0,#0x20	; 0232389E
	bx lr	; 023238A0
loc_023238A2:
	mov r0,#0x40	; 023238A2
	bx lr	; 023238A4
loc_023238A6:
	mov r0,#0x0	; 023238A6
	bx lr	; 023238A8
	.byte 0xC0, 0x46	; 023238AC
pool_023238AC:
loc_023238AC:
	.word 0xC0008000	; 023238AC
pool_023238B0:
loc_023238B0:
	.word 0x80008000	; 023238B0
pool_023238B4:
loc_023238B4:
	.word 0x80000000	; 023238B4
pool_023238B8:
loc_023238B8:
	.word 0x80004000	; 023238B8
pool_023238BC:
loc_023238BC:
	.word 0xC0000000	; 023238BC
pool_023238C0:
loc_023238C0:
	.word 0xC0004000	; 023238C0
pool_023238C4:
loc_023238C4:
	.word 0x00008000	; 023238C4
pool_023238C8:
loc_023238C8:
	.word 0x00004000	; 023238C8
pool_023238CC:
loc_023238CC:
	.word 0x40004000	; 023238CC
pool_023238D0:
loc_023238D0:
	.word 0x40000000	; 023238D0
pool_023238D4:
loc_023238D4:
	.word 0x40008000	; 023238D4

; ===== function loc_023238D8 =====
loc_023238D8:
	push {r4,r5,lr}	; 023238D8
	sub sp,#0x4	; 023238DA
	add r3,r0,#0x0	; 023238DC
	ldr r0,[pool_0232395C]	; 023238DE
	ldr r4,[r3,r0]	; 023238E0
	cmp r4,#0x7f	; 023238E2
	bne loc_023238EA	; 023238E4
	mov r0,#0x0	; 023238E6
	b loc_02323954	; 023238E8
loc_023238EA:
	cmp r2,#0x0	; 023238EA
	beq loc_023238FA	; 023238EC
	ldr r0,[pool_02323960]	; 023238EE
	ldr r0,[r3,r0]	; 023238F0
	cmp r0,#0x1f	; 023238F2
	bne loc_023238FA	; 023238F4
	mov r0,#0x0	; 023238F6
	b loc_02323954	; 023238F8
loc_023238FA:
	lsl r5,r4,#0x3	; 023238FA
	add r0,r3,r5	; 023238FC
	ldr r4,[r1,#0x0]	; 023238FE
	ldr r1,[r1,#0x4]	; 02323900
	str r4,[r3,r5]	; 02323902
	str r1,[r0,#0x4]	; 02323904
	cmp r2,#0x0	; 02323906
	beq loc_02323910	; 02323908
	ldr r0,[pool_02323960]	; 0232390A
	ldr r0,[r3,r0]	; 0232390C
	b loc_02323912	; 0232390E
loc_02323910:
	mov r0,#0x0	; 02323910
loc_02323912:
	ldr r1,[pool_0232395C]	; 02323912
	ldr r1,[r3,r1]	; 02323914
	lsl r5,r1,#0x3	; 02323916
	ldr r4,[r3,r5]	; 02323918
	ldr r1,[pool_02323964]	; 0232391A
	and r4,r1	; 0232391C
	mov r1,#0x1f	; 0232391E
	and r0,r1	; 02323920
	lsl r0,r0,#0x19	; 02323922
	orr r4,r0	; 02323924
	str r4,[r3,r5]	; 02323926
	cmp r2,#0x0	; 02323928
	beq loc_02323948	; 0232392A
	ldr r0,[pool_02323960]	; 0232392C
	add r4,r3,r0	; 0232392E
	ldr r0,[r4,#0x0]	; 02323930
	lsl r0,r0,#0x4	; 02323932
	add r1,r3,r0	; 02323934
	ldr r0,[pool_02323968]	; 02323936
	add r5,r1,r0	; 02323938
	ldmia r2!,{r0,r1}	; 0232393A
	stmia r5!,{r0,r1}	; 0232393C
	ldmia r2!,{r0,r1}	; 0232393E
	stmia r5!,{r0,r1}	; 02323940
	ldr r0,[r4,#0x0]	; 02323942
	add r0,r0,#0x1	; 02323944
	str r0,[r4,#0x0]	; 02323946
loc_02323948:
	ldr r0,[pool_0232395C]	; 02323948
	add r1,r3,r0	; 0232394A
	ldr r0,[r1,#0x0]	; 0232394C
	add r0,r0,#0x1	; 0232394E
	str r0,[r1,#0x0]	; 02323950
	mov r0,#0x1	; 02323952
loc_02323954:
	add sp,#0x4	; 02323954
	pop {r4,r5}	; 02323956
	pop {r3}	; 02323958
	bx r3	; 0232395A
pool_0232395C:
loc_0232395C:
	.word 0x00000600	; 0232395C
pool_02323960:
loc_02323960:
	.word 0x00000604	; 02323960
pool_02323964:
loc_02323964:
	.word 0xC1FFFFFF	; 02323964
pool_02323968:
loc_02323968:
	.word 0x00000400	; 02323968

; ===== function loc_0232396C =====
loc_0232396C:
	push {r4,lr}	; 0232396C
	sub sp,#0x18	; 0232396E
	add r4,r0,#0x0	; 02323970
	ldr r0,[sp,#0x20]	; 02323972
	str r0,[sp,#0x0]	; 02323974
	ldr r0,[sp,#0x24]	; 02323976
	str r0,[sp,#0x4]	; 02323978
	ldr r0,[sp,#0x28]	; 0232397A
	str r0,[sp,#0x8]	; 0232397C
	ldr r0,[sp,#0x2c]	; 0232397E
	str r0,[sp,#0xc]	; 02323980
	ldr r0,[sp,#0x30]	; 02323982
	str r0,[sp,#0x10]	; 02323984
	add r0,r1,#0x0	; 02323986
	add r1,r2,#0x0	; 02323988
	add r2,r4,#0x0	; 0232398A
	bl loc_02323C24	; 0232398C
	add sp,#0x18	; 02323990
	pop {r4}	; 02323992
	pop {r3}	; 02323994
	bx r3	; 02323996

; ===== function loc_02323998 =====
P1_Entry_02323998:
	push {r4,lr}	; 02323998
	sub sp,#0x18	; 0232399A
	add r4,r0,#0x0	; 0232399C
	ldr r0,[sp,#0x20]	; 0232399E
	str r0,[sp,#0x0]	; 023239A0
	ldr r0,[sp,#0x24]	; 023239A2
	str r0,[sp,#0x4]	; 023239A4
	mov r0,#0x0	; 023239A6
	mvn r0,r0	; 023239A8
	str r0,[sp,#0x8]	; 023239AA
	ldr r0,[sp,#0x28]	; 023239AC
	str r0,[sp,#0xc]	; 023239AE
	ldr r0,[sp,#0x2c]	; 023239B0
	str r0,[sp,#0x10]	; 023239B2
	add r0,r1,#0x0	; 023239B4
	add r1,r2,#0x0	; 023239B6
	add r2,r4,#0x0	; 023239B8
	bl loc_02323C24	; 023239BA
	add sp,#0x18	; 023239BE
	pop {r4}	; 023239C0
	pop {r3}	; 023239C2
	bx r3	; 023239C4
	.byte 0x00, 0x00, 0x10, 0xB5, 0x86, 0xB0, 0x04, 0x1C, 0x08, 0x98, 0x00, 0x90, 0x09, 0x98, 0x01, 0x90	; 023239C6
	.byte 0x0A, 0x98, 0x02, 0x90, 0x00, 0x20, 0xC0, 0x43, 0x03, 0x90, 0x0B, 0x98, 0x04, 0x90, 0x08, 0x1C	; 023239D6
	.byte 0x11, 0x1C, 0x22, 0x1C, 0x00, 0xF0, 0x1B, 0xF9, 0x06, 0xB0, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 023239E6
	.byte 0x00, 0x00	; 023239F6
P1_Entry_023239F8:
	push {r4,r5,lr}	; 023239F8
	sub sp,#0x14	; 023239FA
	add r4,r0,#0x0	; 023239FC
	mov r5,#0x0	; 023239FE
	str r5,[sp,#0x0]	; 02323A00
	str r5,[sp,#0x4]	; 02323A02
	ldr r0,[sp,#0x20]	; 02323A04
	str r0,[sp,#0x8]	; 02323A06
	mvn r0,r5	; 02323A08
	str r0,[sp,#0xc]	; 02323A0A
	ldr r0,[sp,#0x24]	; 02323A0C
	str r0,[sp,#0x10]	; 02323A0E
	add r0,r1,#0x0	; 02323A10
	add r1,r2,#0x0	; 02323A12
	add r2,r4,#0x0	; 02323A14
	bl loc_02323C24	; 02323A16
	add sp,#0x14	; 02323A1A
	pop {r4,r5}	; 02323A1C
	pop {r3}	; 02323A1E
	bx r3	; 02323A20
	.byte 0x00, 0x00	; 02323A22

; ===== function loc_02323A24 =====
loc_02323A24:
	push {r4,lr}	; 02323A24
	sub sp,#0x18	; 02323A26
	add r4,r0,#0x0	; 02323A28
	ldr r0,[sp,#0x20]	; 02323A2A
	str r0,[sp,#0x0]	; 02323A2C
	ldr r0,[sp,#0x24]	; 02323A2E
	str r0,[sp,#0x4]	; 02323A30
	mov r0,#0x0	; 02323A32
	mvn r0,r0	; 02323A34
	str r0,[sp,#0x8]	; 02323A36
	str r0,[sp,#0xc]	; 02323A38
	ldr r0,[sp,#0x28]	; 02323A3A
	str r0,[sp,#0x10]	; 02323A3C
	add r0,r1,#0x0	; 02323A3E
	add r1,r2,#0x0	; 02323A40
	add r2,r4,#0x0	; 02323A42
	bl loc_02323C24	; 02323A44
	add sp,#0x18	; 02323A48
	pop {r4}	; 02323A4A
	pop {r3}	; 02323A4C
	bx r3	; 02323A4E

; ===== function loc_02323A50 =====
	push {r4,lr}	; 02323A50
	sub sp,#0x18	; 02323A52
	add r4,r0,#0x0	; 02323A54
	mov r0,#0x0	; 02323A56
	str r0,[sp,#0x0]	; 02323A58
	str r0,[sp,#0x4]	; 02323A5A
	mvn r0,r0	; 02323A5C
	str r0,[sp,#0x8]	; 02323A5E
	str r0,[sp,#0xc]	; 02323A60
	ldr r0,[sp,#0x20]	; 02323A62
	str r0,[sp,#0x10]	; 02323A64
	add r0,r1,#0x0	; 02323A66
	add r1,r2,#0x0	; 02323A68
	add r2,r4,#0x0	; 02323A6A
	bl loc_02323C24	; 02323A6C
	add sp,#0x18	; 02323A70
	pop {r4}	; 02323A72
	pop {r3}	; 02323A74
	bx r3	; 02323A76
P1_Entry_02323A78:
	push {r4,lr}	; 02323A78
	sub sp,#0x18	; 02323A7A
	add r4,r0,#0x0	; 02323A7C
	ldr r0,[sp,#0x20]	; 02323A7E
	str r0,[sp,#0x0]	; 02323A80
	ldr r0,[sp,#0x24]	; 02323A82
	str r0,[sp,#0x4]	; 02323A84
	ldr r0,[sp,#0x28]	; 02323A86
	str r0,[sp,#0x8]	; 02323A88
	ldr r0,[sp,#0x2c]	; 02323A8A
	str r0,[sp,#0xc]	; 02323A8C
	mov r0,#0x0	; 02323A8E
	mvn r0,r0	; 02323A90
	str r0,[sp,#0x10]	; 02323A92
	add r0,r1,#0x0	; 02323A94
	add r1,r2,#0x0	; 02323A96
	add r2,r4,#0x0	; 02323A98
	bl loc_02323C24	; 02323A9A
	add sp,#0x18	; 02323A9E
	pop {r4}	; 02323AA0
	pop {r3}	; 02323AA2
	bx r3	; 02323AA4
	.byte 0x00, 0x00	; 02323AA6

; ===== function loc_02323AA8 =====
loc_02323AA8:
	push {r4,r5,lr}	; 02323AA8
	sub sp,#0x14	; 02323AAA
	add r4,r0,#0x0	; 02323AAC
	ldr r0,[sp,#0x20]	; 02323AAE
	str r0,[sp,#0x0]	; 02323AB0
	ldr r0,[sp,#0x24]	; 02323AB2
	str r0,[sp,#0x4]	; 02323AB4
	mov r0,#0x0	; 02323AB6
	mvn r5,r0	; 02323AB8
	str r5,[sp,#0x8]	; 02323ABA
	ldr r0,[sp,#0x28]	; 02323ABC
	str r0,[sp,#0xc]	; 02323ABE
	str r5,[sp,#0x10]	; 02323AC0
	add r0,r1,#0x0	; 02323AC2
	add r1,r2,#0x0	; 02323AC4
	add r2,r4,#0x0	; 02323AC6
	bl loc_02323C24	; 02323AC8
	add sp,#0x14	; 02323ACC
	pop {r4,r5}	; 02323ACE
	pop {r3}	; 02323AD0
	bx r3	; 02323AD2

; ===== function loc_02323AD4 =====
P1_Entry_02323AD4:
	push {r4,r5,lr}	; 02323AD4
	sub sp,#0x14	; 02323AD6
	add r4,r0,#0x0	; 02323AD8
	mov r0,#0x0	; 02323ADA
	str r0,[sp,#0x0]	; 02323ADC
	str r0,[sp,#0x4]	; 02323ADE
	mvn r5,r0	; 02323AE0
	str r5,[sp,#0x8]	; 02323AE2
	ldr r0,[sp,#0x20]	; 02323AE4
	str r0,[sp,#0xc]	; 02323AE6
	str r5,[sp,#0x10]	; 02323AE8
	add r0,r1,#0x0	; 02323AEA
	add r1,r2,#0x0	; 02323AEC
	add r2,r4,#0x0	; 02323AEE
	bl loc_02323C24	; 02323AF0
	add sp,#0x14	; 02323AF4
	pop {r4,r5}	; 02323AF6
	pop {r3}	; 02323AF8
	bx r3	; 02323AFA

; ===== function loc_02323AFC =====
loc_02323AFC:
	push {r4,r5,lr}	; 02323AFC
	sub sp,#0x14	; 02323AFE
	add r5,r0,#0x0	; 02323B00
	mov r4,#0x0	; 02323B02
	str r4,[sp,#0x0]	; 02323B04
	mvn r0,r4	; 02323B06
	str r0,[sp,#0x4]	; 02323B08
	str r3,[sp,#0x8]	; 02323B0A
	str r0,[sp,#0xc]	; 02323B0C
	add r0,r1,#0x0	; 02323B0E
	add r1,r2,#0x0	; 02323B10
	add r2,r5,#0x0	; 02323B12
	add r3,r4,#0x0	; 02323B14
	bl loc_02323BCC	; 02323B16
	add sp,#0x14	; 02323B1A
	pop {r4,r5}	; 02323B1C
	pop {r3}	; 02323B1E
	bx r3	; 02323B20
	.byte 0x00, 0x00	; 02323B24

; ===== function loc_02323B24 =====
loc_02323B24:
	push {r4,lr}	; 02323B24
	sub sp,#0x18	; 02323B26
	add r4,r0,#0x0	; 02323B28
	ldr r0,[sp,#0x20]	; 02323B2A
	str r0,[sp,#0x0]	; 02323B2C
	ldr r0,[sp,#0x24]	; 02323B2E
	str r0,[sp,#0x4]	; 02323B30
	ldr r0,[sp,#0x28]	; 02323B32
	str r0,[sp,#0x8]	; 02323B34
	mov r0,#0x0	; 02323B36
	mvn r0,r0	; 02323B38
	str r0,[sp,#0xc]	; 02323B3A
	str r0,[sp,#0x10]	; 02323B3C
	add r0,r1,#0x0	; 02323B3E
	add r1,r2,#0x0	; 02323B40
	add r2,r4,#0x0	; 02323B42
	bl loc_02323C24	; 02323B44
	add sp,#0x18	; 02323B48
	pop {r4}	; 02323B4A
	pop {r3}	; 02323B4C
	bx r3	; 02323B4E

; ===== function loc_02323B50 =====
P1_Entry_02323B50:
	push {r4,r5,lr}	; 02323B50
	sub sp,#0x14	; 02323B52
	add r4,r0,#0x0	; 02323B54
	mov r5,#0x0	; 02323B56
	str r5,[sp,#0x0]	; 02323B58
	str r5,[sp,#0x4]	; 02323B5A
	ldr r0,[sp,#0x20]	; 02323B5C
	str r0,[sp,#0x8]	; 02323B5E
	mvn r0,r5	; 02323B60
	str r0,[sp,#0xc]	; 02323B62
	str r0,[sp,#0x10]	; 02323B64
	add r0,r1,#0x0	; 02323B66
	add r1,r2,#0x0	; 02323B68
	add r2,r4,#0x0	; 02323B6A
	bl loc_02323C24	; 02323B6C
	add sp,#0x14	; 02323B70
	pop {r4,r5}	; 02323B72
	pop {r3}	; 02323B74
	bx r3	; 02323B76

; ===== function loc_02323B78 =====
loc_02323B78:
	push {r4,lr}	; 02323B78
	sub sp,#0x18	; 02323B7A
	add r4,r0,#0x0	; 02323B7C
	ldr r0,[sp,#0x20]	; 02323B7E
	str r0,[sp,#0x0]	; 02323B80
	ldr r0,[sp,#0x24]	; 02323B82
	str r0,[sp,#0x4]	; 02323B84
	mov r0,#0x0	; 02323B86
	mvn r0,r0	; 02323B88
	str r0,[sp,#0x8]	; 02323B8A
	str r0,[sp,#0xc]	; 02323B8C
	str r0,[sp,#0x10]	; 02323B8E
	add r0,r1,#0x0	; 02323B90
	add r1,r2,#0x0	; 02323B92
	add r2,r4,#0x0	; 02323B94
	bl loc_02323C24	; 02323B96
	add sp,#0x18	; 02323B9A
	pop {r4}	; 02323B9C
	pop {r3}	; 02323B9E
	bx r3	; 02323BA0
	.byte 0x00, 0x00	; 02323BA4

; ===== function loc_02323BA4 =====
loc_02323BA4:
	push {r4,lr}	; 02323BA4
	sub sp,#0x18	; 02323BA6
	add r4,r0,#0x0	; 02323BA8
	mov r0,#0x0	; 02323BAA
	str r0,[sp,#0x0]	; 02323BAC
	str r0,[sp,#0x4]	; 02323BAE
	mvn r0,r0	; 02323BB0
	str r0,[sp,#0x8]	; 02323BB2
	str r0,[sp,#0xc]	; 02323BB4
	str r0,[sp,#0x10]	; 02323BB6
	add r0,r1,#0x0	; 02323BB8
	add r1,r2,#0x0	; 02323BBA
	add r2,r4,#0x0	; 02323BBC
	bl loc_02323C24	; 02323BBE
	add sp,#0x18	; 02323BC2
	pop {r4}	; 02323BC4
	pop {r3}	; 02323BC6
	bx r3	; 02323BC8
	.byte 0x00, 0x00	; 02323BCC

; ===== function loc_02323BCC =====
loc_02323BCC:
	push {r4,r5,r6,r7,lr}	; 02323BCC
	sub sp,#0x24	; 02323BCE
	str r0,[sp,#0x14]	; 02323BD0
	add r5,r1,#0x0	; 02323BD2
	str r2,[sp,#0x18]	; 02323BD4
	str r3,[sp,#0x1c]	; 02323BD6
	ldr r6,[sp,#0x38]	; 02323BD8
	ldr r7,[sp,#0x3c]	; 02323BDA
	ldr r0,[sp,#0x40]	; 02323BDC
	str r0,[sp,#0x40]	; 02323BDE
	ldr r0,[sp,#0x44]	; 02323BE0
	str r0,[sp,#0x44]	; 02323BE2
	ldrh r0,[r5,#0x6]	; 02323BE4
	str r0,[sp,#0x20]	; 02323BE6
	mov r4,#0x0	; 02323BE8
	b loc_02323C12	; 02323BEA
loc_02323BEC:
	ldr r0,[sp,#0x1c]	; 02323BEC
	str r0,[sp,#0x0]	; 02323BEE
	str r6,[sp,#0x4]	; 02323BF0
	str r7,[sp,#0x8]	; 02323BF2
	ldr r0,[sp,#0x40]	; 02323BF4
	str r0,[sp,#0xc]	; 02323BF6
	ldr r0,[sp,#0x44]	; 02323BF8
	str r0,[sp,#0x10]	; 02323BFA
	ldr r0,[sp,#0x14]	; 02323BFC
	add r1,r5,#0x0	; 02323BFE
	ldr r2,[sp,#0x18]	; 02323C00
	add r3,r4,#0x0	; 02323C02
	bl loc_02323C24	; 02323C04
	cmp r0,#0x0	; 02323C08
	bne loc_02323C10	; 02323C0A
	mov r0,#0x0	; 02323C0C
	b loc_02323C1A	; 02323C0E
loc_02323C10:
	add r4,r4,#0x1	; 02323C10
loc_02323C12:
	ldr r0,[sp,#0x20]	; 02323C12
	cmp r4,r0	; 02323C14
	blt loc_02323BEC	; 02323C16
	mov r0,#0x1	; 02323C18
loc_02323C1A:
	add sp,#0x24	; 02323C1A
	pop {r4,r5,r6,r7}	; 02323C1C
	pop {r3}	; 02323C1E
	bx r3	; 02323C20
	.byte 0x00, 0x00	; 02323C24

; ===== function loc_02323C24 =====
loc_02323C24:
	push {r4,r5,r6,r7,lr}	; 02323C24
	sub sp,#0x1c	; 02323C26
	str r0,[sp,#0x10]	; 02323C28
	str r2,[sp,#0x14]	; 02323C2A
	add r4,r1,#0x0	; 02323C2C
	add r4,#0x8	; 02323C2E
	lsl r7,r3,#0x3	; 02323C30
	add r5,r4,r7	; 02323C32
	ldr r1,[r5,#0x4]	; 02323C34
	bl loc_02328D7C	; 02323C36
	add r6,r0,#0x0	; 02323C3A
	mov r1,sp	; 02323C3C
	sub r1,r1,#0x4	; 02323C3E
	ldrh r0,[r4,r7]	; 02323C40
	strh r0,[r1,#0x0]	; 02323C42
	ldmia r1!,{r0}	; 02323C44
	ldrb r1,[r6,#0x0]	; 02323C46
	bl loc_02328CAC	; 02323C48
	ldr r1,[sp,#0x30]	; 02323C4C
	add r0,r1,r0	; 02323C4E
	str r0,[sp,#0x30]	; 02323C50
	mov r1,sp	; 02323C52
	sub r1,r1,#0x4	; 02323C54
	ldrh r0,[r5,#0x2]	; 02323C56
	strh r0,[r1,#0x0]	; 02323C58
	ldmia r1!,{r0}	; 02323C5A
	ldrb r1,[r6,#0x1]	; 02323C5C
	bl loc_02328C74	; 02323C5E
	ldr r1,[sp,#0x34]	; 02323C62
	add r3,r1,r0	; 02323C64
	str r3,[sp,#0x34]	; 02323C66
	ldr r0,[sp,#0x38]	; 02323C68
	str r0,[sp,#0x0]	; 02323C6A
	ldr r0,[sp,#0x3c]	; 02323C6C
	str r0,[sp,#0x4]	; 02323C6E
	ldr r0,[sp,#0x40]	; 02323C70
	str r0,[sp,#0x8]	; 02323C72
	ldr r0,[r5,#0x4]	; 02323C74
	str r0,[sp,#0xc]	; 02323C76
	ldr r0,[sp,#0x10]	; 02323C78
	ldr r1,[sp,#0x14]	; 02323C7A
	ldr r2,[sp,#0x30]	; 02323C7C
	bl loc_02323C8C	; 02323C7E
	add sp,#0x1c	; 02323C82
	pop {r4,r5,r6,r7}	; 02323C84
	pop {r3}	; 02323C86
	bx r3	; 02323C88
	.byte 0x00, 0x00	; 02323C8C

; ===== function loc_02323C8C =====
loc_02323C8C:
	push {r4,r5,r6,r7,lr}	; 02323C8C
	sub sp,#0x14	; 02323C8E
	add r5,r0,#0x0	; 02323C90
	add r4,r1,#0x0	; 02323C92
	str r2,[sp,#0x0]	; 02323C94
	str r3,[sp,#0x4]	; 02323C96
	ldr r1,[sp,#0x28]	; 02323C98
	str r1,[sp,#0x28]	; 02323C9A
	ldr r1,[sp,#0x2c]	; 02323C9C
	str r1,[sp,#0x2c]	; 02323C9E
	ldr r1,[sp,#0x30]	; 02323CA0
	str r1,[sp,#0x30]	; 02323CA2
	ldr r1,[sp,#0x34]	; 02323CA4
	bl loc_02328DAC	; 02323CA6
	str r0,[sp,#0x8]	; 02323CAA
	add r0,r5,#0x0	; 02323CAC
	ldr r1,[sp,#0x34]	; 02323CAE
	bl loc_02328D94	; 02323CB0
	add r7,r0,#0x0	; 02323CB4
	add r0,r5,#0x0	; 02323CB6
	ldr r1,[sp,#0x34]	; 02323CB8
	bl loc_02328D7C	; 02323CBA
	mov r2,#0x0	; 02323CBE
	str r2,[sp,#0xc]	; 02323CC0
	ldr r0,[pool_02323D94]	; 02323CC2
	ldr r1,[r4,r0]	; 02323CC4
	b loc_02323CDE	; 02323CC6
loc_02323CC8:
	lsl r0,r2,#0x3	; 02323CC8
	add r0,r4,r0	; 02323CCA
	ldr r3,[pool_02323D98]	; 02323CCC
	ldr r3,[r0,r3]	; 02323CCE
	cmp r3,r5	; 02323CD0
	bne loc_02323CDC	; 02323CD2
	ldr r3,[pool_02323D9C]	; 02323CD4
	ldr r0,[r0,r3]	; 02323CD6
	lsr r0,r0,#0x7	; 02323CD8
	str r0,[sp,#0xc]	; 02323CDA
loc_02323CDC:
	add r2,r2,#0x1	; 02323CDC
loc_02323CDE:
	cmp r2,r1	; 02323CDE
	blt loc_02323CC8	; 02323CE0
	mov r1,#0x0	; 02323CE2
	b loc_02323D82	; 02323CE4
loc_02323CE6:
	ldr r0,[pool_02323DA0]	; 02323CE6
	ldr r0,[r4,r0]	; 02323CE8
	lsl r0,r0,#0x3	; 02323CEA
	add r2,r4,r0	; 02323CEC
	ldr r5,[r7,#0x0]	; 02323CEE
	ldr r3,[r7,#0x4]	; 02323CF0
	str r5,[r4,r0]	; 02323CF2
	str r3,[r2,#0x4]	; 02323CF4
	ldrh r6,[r2,#0x4]	; 02323CF6
	ldr r3,[pool_02323DA4]	; 02323CF8
	and r6,r3	; 02323CFA
	ldrh r5,[r7,#0x8]	; 02323CFC
	ldr r3,[sp,#0xc]	; 02323CFE
	add r3,r5,r3	; 02323D00
	orr r6,r3	; 02323D02
	strh r6,[r2,#0x4]	; 02323D04
	ldr r5,[r4,r0]	; 02323D06
	add r6,r5,#0x0	; 02323D08
	ldr r3,[pool_02323DA8]	; 02323D0A
	and r6,r3	; 02323D0C
	lsl r3,r5,#0x7	; 02323D0E
	lsr r5,r3,#0x17	; 02323D10
	ldr r3,[sp,#0x0]	; 02323D12
	add r5,r5,r3	; 02323D14
	ldr r3,[pool_02323DAC]	; 02323D16
	and r5,r3	; 02323D18
	lsl r3,r5,#0x10	; 02323D1A
	orr r6,r3	; 02323D1C
	str r6,[r4,r0]	; 02323D1E
	ldrb r5,[r4,r0]	; 02323D20
	ldr r3,[sp,#0x4]	; 02323D22
	add r3,r5,r3	; 02323D24
	strb r3,[r4,r0]	; 02323D26
	ldr r0,[sp,#0x28]	; 02323D28
	cmp r0,#0x0	; 02323D2A
	blt loc_02323D42	; 02323D2C
	add r5,r2,#0x4	; 02323D2E
	ldr r3,[r5,#0x0]	; 02323D30
	ldr r0,[pool_02323DB0]	; 02323D32
	and r3,r0	; 02323D34
	ldr r6,[sp,#0x28]	; 02323D36
	mov r0,#0xf	; 02323D38
	and r6,r0	; 02323D3A
	lsl r0,r6,#0xc	; 02323D3C
	orr r3,r0	; 02323D3E
	str r3,[r5,#0x0]	; 02323D40
loc_02323D42:
	ldr r0,[sp,#0x2c]	; 02323D42
	cmp r0,#0x0	; 02323D44
	blt loc_02323D5A	; 02323D46
	ldr r0,[r2,#0x0]	; 02323D48
	ldr r3,[pool_02323DB4]	; 02323D4A
	and r0,r3	; 02323D4C
	ldr r5,[sp,#0x2c]	; 02323D4E
	mov r3,#0x3	; 02323D50
	and r5,r3	; 02323D52
	lsl r3,r5,#0xa	; 02323D54
	orr r0,r3	; 02323D56
	str r0,[r2,#0x0]	; 02323D58
loc_02323D5A:
	ldr r0,[sp,#0x30]	; 02323D5A
	cmp r0,#0x0	; 02323D5C
	blt loc_02323D74	; 02323D5E
	add r2,r2,#0x4	; 02323D60
	ldr r0,[r2,#0x0]	; 02323D62
	ldr r3,[pool_02323DB4]	; 02323D64
	and r0,r3	; 02323D66
	ldr r5,[sp,#0x30]	; 02323D68
	mov r3,#0x3	; 02323D6A
	and r5,r3	; 02323D6C
	lsl r3,r5,#0xa	; 02323D6E
	orr r0,r3	; 02323D70
	str r0,[r2,#0x0]	; 02323D72
loc_02323D74:
	ldr r0,[pool_02323DA0]	; 02323D74
	add r2,r4,r0	; 02323D76
	ldr r0,[r2,#0x0]	; 02323D78
	add r0,r0,#0x1	; 02323D7A
	str r0,[r2,#0x0]	; 02323D7C
	add r1,r1,#0x1	; 02323D7E
	add r7,#0xc	; 02323D80
loc_02323D82:
	ldr r0,[sp,#0x8]	; 02323D82
	cmp r1,r0	; 02323D84
	blt loc_02323CE6	; 02323D86
	mov r0,#0x1	; 02323D88
	add sp,#0x14	; 02323D8A
	pop {r4,r5,r6,r7}	; 02323D8C
	pop {r3}	; 02323D8E
	bx r3	; 02323D90
	.byte 0xC0, 0x46	; 02323D94
pool_02323D94:
loc_02323D94:
	.word 0x00000628	; 02323D94
pool_02323D98:
loc_02323D98:
	.word 0x00000608	; 02323D98
pool_02323D9C:
loc_02323D9C:
	.word 0x0000060C	; 02323D9C
pool_02323DA0:
loc_02323DA0:
	.word 0x00000600	; 02323DA0
pool_02323DA4:
loc_02323DA4:
	.word 0xFFFFFC00	; 02323DA4
pool_02323DA8:
loc_02323DA8:
	.word 0xFE00FFFF	; 02323DA8
pool_02323DAC:
loc_02323DAC:
	.word 0x000001FF	; 02323DAC
pool_02323DB0:
loc_02323DB0:
	.word 0xFFFF0FFF	; 02323DB0
pool_02323DB4:
loc_02323DB4:
	.word 0xFFFFF3FF	; 02323DB4

; ===== function loc_02323DB8 =====
loc_02323DB8:
	ldr r0,[pool_02323DBC]	; 02323DB8
	bx lr	; 02323DBA
pool_02323DBC:
loc_02323DBC:
	.word 0x02333DF0	; 02323DBC

; ===== function loc_02323DC0 =====
loc_02323DC0:
	ldr r0,[pool_02323DC4]	; 02323DC0
	bx lr	; 02323DC2
pool_02323DC4:
loc_02323DC4:
	.word 0x023337C0	; 02323DC4

; ===== function loc_02323DC8 =====
loc_02323DC8:
	push {lr}	; 02323DC8
	sub sp,#0x4	; 02323DCA
	ldr r0,[pool_02323DF0]	; 02323DCC
	ldr r0,[r0,#0x60]	; 02323DCE
	cmp r0,#0x0	; 02323DD0
	beq loc_02323DE8	; 02323DD2
	ldr r0,[pool_02323DF4]	; 02323DD4
	mov r1,#0x0	; 02323DD6
	ldr r2,[pool_02323DF8]	; 02323DD8
	bl loc_0232E09C	; 02323DDA
	ldr r0,[pool_02323DFC]	; 02323DDE
	mov r1,#0x0	; 02323DE0
	ldr r2,[pool_02323DF8]	; 02323DE2
	bl loc_0232E060	; 02323DE4
loc_02323DE8:
	add sp,#0x4	; 02323DE8
	pop {r3}	; 02323DEA
	bx r3	; 02323DEC
	.byte 0xC0, 0x46	; 02323DF0
pool_02323DF0:
loc_02323DF0:
	.word P1_BssStart + 0x3540	; 02323DF0
pool_02323DF4:
loc_02323DF4:
	.word 0x023337C0	; 02323DF4
pool_02323DF8:
loc_02323DF8:
	.word 0x00000400	; 02323DF8
pool_02323DFC:
loc_02323DFC:
	.word 0x02333DF0	; 02323DFC

; ===== function loc_02323E00 =====
; 更新 UI 工作缓冲区、清理其数据缓存，并在 VBlank 前提交。
; Updates UI work buffers, cleans their D-cache, then commits before VBlank.
.func P1_RefreshFirmwareUiRenderBuffers
loc_02323E00:
	push {r4,r5,r6,r7,lr}	; 02323E00
	sub sp,#0xc	; 02323E02
	mov r0,#0xc0	; 02323E04
	str r0,[sp,#0x0]	; 02323E06
	ldr r0,[pool_02323EB0]	; 02323E08
	ldr r3,[r0,#0x0]	; 02323E0A
	ldr r0,[sp,#0x0]	; 02323E0C
	ldr r2,[pool_02323EB4]	; 02323E0E
	lsl r1,r3,#0x3	; 02323E10
	add r1,r2,r1	; 02323E12
	mov r2,#0x80	; 02323E14
	sub r2,r2,r3	; 02323E16
	lsl r2,r2,#0x3	; 02323E18
	blx loc_0232E34C	; 02323E1A
	mov r0,#0xc0	; 02323E1E
	str r0,[sp,#0x4]	; 02323E20
	ldr r0,[pool_02323EB8]	; 02323E22
	ldr r3,[r0,#0x30]	; 02323E24
	ldr r0,[sp,#0x4]	; 02323E26
	ldr r2,[pool_02323EBC]	; 02323E28
	lsl r1,r3,#0x3	; 02323E2A
	add r1,r2,r1	; 02323E2C
	mov r2,#0x80	; 02323E2E
	sub r2,r2,r3	; 02323E30
	lsl r2,r2,#0x3	; 02323E32
	blx loc_0232E34C	; 02323E34
	mov r5,#0x0	; 02323E38
	ldr r3,[pool_02323EB4]	; 02323E3A
	ldr r0,[pool_02323EBC]	; 02323E3C
	ldr r7,[pool_02323EC0]	; 02323E3E
loc_02323E40:
	lsl r1,r5,#0x4	; 02323E40
	add r4,r3,r1	; 02323E42
	lsl r2,r5,#0x5	; 02323E44
	add r1,r3,r2	; 02323E46
	ldr r6,[pool_02323EC4]	; 02323E48
	ldr r6,[r4,r6]	; 02323E4A
	asr r6,r6,#0x4	; 02323E4C
	strh r6,[r1,#0x6]	; 02323E4E
	ldr r6,[pool_02323EC8]	; 02323E50
	ldr r6,[r4,r6]	; 02323E52
	asr r6,r6,#0x4	; 02323E54
	strh r6,[r1,#0xe]	; 02323E56
	ldr r6,[pool_02323ECC]	; 02323E58
	ldr r6,[r4,r6]	; 02323E5A
	asr r6,r6,#0x4	; 02323E5C
	strh r6,[r1,#0x16]	; 02323E5E
	ldr r6,[pool_02323ED0]	; 02323E60
	ldr r6,[r4,r6]	; 02323E62
	asr r6,r6,#0x4	; 02323E64
	strh r6,[r1,#0x1e]	; 02323E66
	add r1,r0,r2	; 02323E68
	ldr r2,[pool_02323ED4]	; 02323E6A
	ldr r2,[r4,r2]	; 02323E6C
	asr r2,r2,#0x4	; 02323E6E
	strh r2,[r1,#0x6]	; 02323E70
	ldr r2,[pool_02323ED8]	; 02323E72
	ldr r2,[r4,r2]	; 02323E74
	asr r2,r2,#0x4	; 02323E76
	strh r2,[r1,#0xe]	; 02323E78
	ldr r2,[pool_02323EDC]	; 02323E7A
	ldr r2,[r4,r2]	; 02323E7C
	asr r2,r2,#0x4	; 02323E7E
	strh r2,[r1,#0x16]	; 02323E80
	ldr r2,[r4,r7]	; 02323E82
	asr r2,r2,#0x4	; 02323E84
	strh r2,[r1,#0x1e]	; 02323E86
	add r5,r5,#0x1	; 02323E88
	cmp r5,#0x20	; 02323E8A
	blt loc_02323E40	; 02323E8C
	add r0,r3,#0x0	; 02323E8E
	ldr r1,[pool_02323EC4]	; 02323E90
	blx P1_CleanDataCacheRange	; 02323E92
	ldr r0,[pool_02323EBC]	; 02323E96
	ldr r1,[pool_02323EC4]	; 02323E98
	blx P1_CleanDataCacheRange	; 02323E9A
	mov r1,#0x1	; 02323E9E
	ldr r0,[pool_02323EB8]	; 02323EA0
	str r1,[r0,#0x60]	; 02323EA2
	bl loc_0232C3E6	; 02323EA4
	add sp,#0xc	; 02323EA8
	pop {r4,r5,r6,r7}	; 02323EAA
	pop {r3}	; 02323EAC
	bx r3	; 02323EAE
.endfunc
pool_02323EB0:
loc_02323EB0:
	.word P1_BssStart + 0x2F40	; 02323EB0
pool_02323EB4:
loc_02323EB4:
	.word 0x023337C0	; 02323EB4
pool_02323EB8:
loc_02323EB8:
	.word P1_BssStart + 0x3540	; 02323EB8
pool_02323EBC:
loc_02323EBC:
	.word 0x02333DF0	; 02323EBC
pool_02323EC0:
loc_02323EC0:
	.word 0x00000A3C	; 02323EC0
pool_02323EC4:
loc_02323EC4:
	.word 0x00000400	; 02323EC4
pool_02323EC8:
loc_02323EC8:
	.word 0x00000404	; 02323EC8
pool_02323ECC:
loc_02323ECC:
	.word 0x00000408	; 02323ECC
pool_02323ED0:
loc_02323ED0:
	.word 0x0000040C	; 02323ED0
pool_02323ED4:
loc_02323ED4:
	.word 0x00000A30	; 02323ED4
pool_02323ED8:
loc_02323ED8:
	.word 0x00000A34	; 02323ED8
pool_02323EDC:
loc_02323EDC:
	.word 0x00000A38	; 02323EDC

; ===== function loc_02323EE0 =====
loc_02323EE0:
	mov r2,#0x0	; 02323EE0
	ldr r1,[pool_02323EF4]	; 02323EE2
	str r2,[r1,#0x30]	; 02323EE4
	ldr r0,[pool_02323EF8]	; 02323EE6
	str r2,[r0,#0x0]	; 02323EE8
	str r2,[r1,#0x34]	; 02323EEA
	str r2,[r0,#0x4]	; 02323EEC
	str r2,[r1,#0x60]	; 02323EEE
	bx lr	; 02323EF0
	.byte 0xC0, 0x46	; 02323EF4
pool_02323EF4:
loc_02323EF4:
	.word P1_BssStart + 0x3540	; 02323EF4
pool_02323EF8:
loc_02323EF8:
	.word P1_BssStart + 0x2F40	; 02323EF8

; ===== function loc_02323EFC =====
loc_02323EFC:
	push {r4,r5,r6,lr}	; 02323EFC
	add r5,r0,#0x0	; 02323EFE
	add r4,r1,#0x0	; 02323F00
	ldr r0,[pool_02323F7C]	; 02323F02
	add r1,r5,r0	; 02323F04
	ldr r0,[r1,#0x0]	; 02323F06
	lsl r0,r0,#0x3	; 02323F08
	add r2,r5,r0	; 02323F0A
	ldr r0,[pool_02323F80]	; 02323F0C
	str r4,[r2,r0]	; 02323F0E
	ldr r0,[pool_02323F84]	; 02323F10
	ldr r0,[r5,r0]	; 02323F12
	ldr r1,[r1,#0x0]	; 02323F14
	lsl r1,r1,#0x3	; 02323F16
	add r2,r5,r1	; 02323F18
	ldr r1,[pool_02323F88]	; 02323F1A
	str r0,[r2,r1]	; 02323F1C
	ldr r0,[pool_02323F8C]	; 02323F1E
	cmp r5,r0	; 02323F20
	bne loc_02323F40	; 02323F22
	add r0,r4,#0x0	; 02323F24
	bl loc_02328D8C	; 02323F26
	add r6,r0,#0x0	; 02323F2A
	add r0,r4,#0x0	; 02323F2C
	bl loc_02328D88	; 02323F2E
	add r2,r0,#0x0	; 02323F32
	add r0,r6,#0x0	; 02323F34
	ldr r1,[pool_02323F84]	; 02323F36
	ldr r1,[r5,r1]	; 02323F38
	bl loc_0232E020	; 02323F3A
	b loc_02323F5A	; 02323F3E
loc_02323F40:
	add r0,r4,#0x0	; 02323F40
	bl loc_02328D8C	; 02323F42
	add r6,r0,#0x0	; 02323F46
	add r0,r4,#0x0	; 02323F48
	bl loc_02328D88	; 02323F4A
	add r2,r0,#0x0	; 02323F4E
	add r0,r6,#0x0	; 02323F50
	ldr r1,[pool_02323F84]	; 02323F52
	ldr r1,[r5,r1]	; 02323F54
	bl loc_0232DFE0	; 02323F56
loc_02323F5A:
	add r0,r4,#0x0	; 02323F5A
	bl loc_02328D88	; 02323F5C
	ldr r1,[pool_02323F84]	; 02323F60
	add r2,r5,r1	; 02323F62
	ldr r1,[r2,#0x0]	; 02323F64
	add r0,r1,r0	; 02323F66
	str r0,[r2,#0x0]	; 02323F68
	ldr r0,[pool_02323F7C]	; 02323F6A
	add r1,r5,r0	; 02323F6C
	ldr r0,[r1,#0x0]	; 02323F6E
	add r0,r0,#0x1	; 02323F70
	str r0,[r1,#0x0]	; 02323F72
	pop {r4,r5,r6}	; 02323F74
	pop {r3}	; 02323F76
	bx r3	; 02323F78
	.byte 0xC0, 0x46	; 02323F7C
pool_02323F7C:
loc_02323F7C:
	.word 0x00000628	; 02323F7C
pool_02323F80:
loc_02323F80:
	.word 0x00000608	; 02323F80
pool_02323F84:
loc_02323F84:
	.word 0x0000062C	; 02323F84
pool_02323F88:
loc_02323F88:
	.word 0x0000060C	; 02323F88
pool_02323F8C:
loc_02323F8C:
	.word 0x023337C0	; 02323F8C

; ===== function loc_02323F90 =====
loc_02323F90:
	push {r4,r5,lr}	; 02323F90
	sub sp,#0x4	; 02323F92
	mov r5,#0x0	; 02323F94
	add r3,r5,#0x0	; 02323F96
	ldr r1,[pool_02323FC4]	; 02323F98
	ldr r2,[pool_02323FC8]	; 02323F9A
loc_02323F9C:
	lsl r4,r5,#0x3	; 02323F9C
	add r4,r0,r4	; 02323F9E
	str r3,[r4,r1]	; 02323FA0
	str r3,[r4,r2]	; 02323FA2
	add r5,r5,#0x1	; 02323FA4
	cmp r5,#0x4	; 02323FA6
	blt loc_02323F9C	; 02323FA8
	ldr r1,[pool_02323FCC]	; 02323FAA
	str r3,[r0,r1]	; 02323FAC
	ldr r1,[pool_02323FD0]	; 02323FAE
	str r3,[r0,r1]	; 02323FB0
	ldr r1,[pool_02323FD4]	; 02323FB2
	str r3,[r0,r1]	; 02323FB4
	ldr r1,[pool_02323FD8]	; 02323FB6
	str r3,[r0,r1]	; 02323FB8
	add sp,#0x4	; 02323FBA
	pop {r4,r5}	; 02323FBC
	pop {r3}	; 02323FBE
	bx r3	; 02323FC0
	.byte 0xC0, 0x46	; 02323FC4
pool_02323FC4:
loc_02323FC4:
	.word 0x00000608	; 02323FC4
pool_02323FC8:
loc_02323FC8:
	.word 0x0000060C	; 02323FC8
pool_02323FCC:
loc_02323FCC:
	.word 0x00000628	; 02323FCC
pool_02323FD0:
loc_02323FD0:
	.word 0x0000062C	; 02323FD0
pool_02323FD4:
loc_02323FD4:
	.word 0x00000600	; 02323FD4
pool_02323FD8:
loc_02323FD8:
	.word 0x00000604	; 02323FD8
	.byte 0x00, 0x04, 0x02, 0x0C, 0x05, 0x48, 0xC1, 0x88, 0x91, 0x43, 0xC1, 0x80, 0x81, 0x88, 0x91, 0x43	; 02323FDC
	.byte 0x81, 0x80, 0x01, 0x89, 0x91, 0x43, 0x01, 0x81, 0x70, 0x47, 0xC0, 0x46, 0x24, 0x44, 0x33, 0x02	; 02323FEC
P1_Entry_02323FFC:
	mov r1,#0x0	; 02323FFC
	ldr r0,[pool_02324004]	; 02323FFE
	str r1,[r0,#0x24]	; 02324000
	bx lr	; 02324002
pool_02324004:
	.word P1_BssStart + 0x35A4	; 02324004
P1_Entry_02324008:
	mov r1,#0x1	; 02324008
	ldr r0,[pool_02324010]	; 0232400A
	str r1,[r0,#0x24]	; 0232400C
	bx lr	; 0232400E
pool_02324010:
	.word P1_BssStart + 0x35A4	; 02324010
P1_Entry_02324014:
	ldr r0,[pool_0232401C]	; 02324014
	ldr r0,[r0,#0x0]	; 02324016
	bx lr	; 02324018
	.byte 0xC0, 0x46	; 0232401A
pool_0232401C:
	.word P1_BssStart + 0x35A4	; 0232401C
P1_Entry_02324020:
	ldr r1,[pool_02324028]	; 02324020
	strh r0,[r1,#0xa]	; 02324022
	bx lr	; 02324024
	.byte 0xC0, 0x46	; 02324026
pool_02324028:
	.word P1_BssStart + 0x35A4	; 02324028
P1_Entry_0232402C:
	ldr r0,[pool_02324034]	; 0232402C
	ldr r0,[r0,#0x18]	; 0232402E
	bx lr	; 02324030
	.byte 0xC0, 0x46	; 02324032
pool_02324034:
	.word P1_BssStart + 0x35A4	; 02324034

; ===== function loc_02324038 =====
loc_02324038:
	ldr r0,[pool_02324040]	; 02324038
	ldrh r0,[r0,#0x16]	; 0232403A
	bx lr	; 0232403C
	.byte 0xC0, 0x46	; 02324040
pool_02324040:
loc_02324040:
	.word P1_BssStart + 0x35A4	; 02324040

; ===== function loc_02324044 =====
loc_02324044:
	ldr r0,[pool_0232404C]	; 02324044
	ldrh r0,[r0,#0x14]	; 02324046
	bx lr	; 02324048
	.byte 0xC0, 0x46	; 0232404C
pool_0232404C:
loc_0232404C:
	.word P1_BssStart + 0x35A4	; 0232404C

; ===== function loc_02324050 =====
loc_02324050:
	ldr r0,[pool_02324058]	; 02324050
	ldr r0,[r0,#0x1c]	; 02324052
	bx lr	; 02324054
	.byte 0xC0, 0x46	; 02324058
pool_02324058:
loc_02324058:
	.word P1_BssStart + 0x35A4	; 02324058

; ===== function loc_0232405C =====
loc_0232405C:
	ldr r0,[pool_02324064]	; 0232405C
	ldrh r0,[r0,#0x20]	; 0232405E
	bx lr	; 02324060
	.byte 0xC0, 0x46	; 02324064
pool_02324064:
loc_02324064:
	.word P1_BssStart + 0x35A4	; 02324064
	.byte 0x02, 0x49, 0x09, 0x89, 0x01, 0x40, 0x08, 0x1C, 0x70, 0x47, 0xC0, 0x46, 0x24, 0x44, 0x33, 0x02	; 02324078

; ===== function loc_02324078 =====
loc_02324078:
	ldr r1,[pool_02324084]	; 02324078
	ldrh r1,[r1,#0x6]	; 0232407A
	and r1,r0	; 0232407C
	add r0,r1,#0x0	; 0232407E
	bx lr	; 02324080
	.byte 0xC0, 0x46	; 02324084
pool_02324084:
loc_02324084:
	.word P1_BssStart + 0x35A4	; 02324084

; ===== function loc_02324088 =====
loc_02324088:
	ldr r1,[pool_02324094]	; 02324088
	ldrh r1,[r1,#0x4]	; 0232408A
	and r1,r0	; 0232408C
	add r0,r1,#0x0	; 0232408E
	bx lr	; 02324090
	.byte 0xC0, 0x46	; 02324094
pool_02324094:
loc_02324094:
	.word P1_BssStart + 0x35A4	; 02324094

; ===== function loc_02324098 =====
loc_02324098:
	push {r4,lr}	; 02324098
	sub sp,#0x10	; 0232409A
	ldr r0,[pool_02324184]	; 0232409C
	ldrh r1,[r0,#0x0]	; 0232409E
	ldr r0,[pool_02324188]	; 023240A0
	ldrh r0,[r0,#0x0]	; 023240A2
	orr r1,r0	; 023240A4
	ldr r0,[pool_0232418C]	; 023240A6
	eor r1,r0	; 023240A8
	and r1,r0	; 023240AA
	lsl r0,r1,#0x10	; 023240AC
	lsr r3,r0,#0x10	; 023240AE
	ldr r0,[pool_02324190]	; 023240B0
	ldrh r1,[r0,#0x6]	; 023240B2
	add r2,r3,#0x0	; 023240B4
	eor r2,r1	; 023240B6
	add r1,r3,#0x0	; 023240B8
	and r1,r2	; 023240BA
	strh r1,[r0,#0x4]	; 023240BC
	mvn r1,r3	; 023240BE
	and r1,r2	; 023240C0
	strh r1,[r0,#0x8]	; 023240C2
	strh r3,[r0,#0x6]	; 023240C4
	ldrh r2,[r0,#0x6]	; 023240C6
	ldrh r1,[r0,#0xa]	; 023240C8
	and r2,r1	; 023240CA
	cmp r2,#0x0	; 023240CC
	beq loc_023240D8	; 023240CE
	ldr r1,[r0,#0x0]	; 023240D0
	add r1,r1,#0x1	; 023240D2
	str r1,[r0,#0x0]	; 023240D4
	b loc_023240DC	; 023240D6
loc_023240D8:
	mov r1,#0x0	; 023240D8
	str r1,[r0,#0x0]	; 023240DA
loc_023240DC:
	ldr r0,[pool_02324190]	; 023240DC
	ldr r0,[r0,#0x24]	; 023240DE
	cmp r0,#0x0	; 023240E0
	beq loc_0232417A	; 023240E2
	add r4,sp,#0x0	; 023240E4
loc_023240E6:
	bl loc_0232F298	; 023240E6
	add r0,r4,#0x0	; 023240EA
	bl loc_0232F264	; 023240EC
	cmp r0,#0x0	; 023240F0
	bne loc_023240E6	; 023240F2
	add r0,sp,#0x8	; 023240F4
	add r1,sp,#0x0	; 023240F6
	bl loc_0232EFF0	; 023240F8
	add r0,sp,#0x0	; 023240FC
	ldrh r0,[r0,#0xe]	; 023240FE
	cmp r0,#0x0	; 02324100
	beq loc_0232411E	; 02324102
	ldr r3,[pool_02324194]	; 02324104
	add r2,sp,#0x8	; 02324106
	mov r1,#0x4	; 02324108
loc_0232410A:
	ldrh r0,[r3,#0x0]	; 0232410A
	add r3,r3,#0x2	; 0232410C
	strh r0,[r2,#0x0]	; 0232410E
	add r2,r2,#0x2	; 02324110
	sub r1,r1,#0x1	; 02324112
	cmp r1,#0x0	; 02324114
	bne loc_0232410A	; 02324116
	mov r1,#0x0	; 02324118
	add r0,sp,#0x0	; 0232411A
	strh r1,[r0,#0xc]	; 0232411C
loc_0232411E:
	add r0,sp,#0x0	; 0232411E
	ldrh r0,[r0,#0xc]	; 02324120
	ldr r1,[pool_02324190]	; 02324122
	ldrh r2,[r1,#0x10]	; 02324124
	cmp r0,r2	; 02324126
	beq loc_0232413E	; 02324128
	cmp r0,#0x0	; 0232412A
	beq loc_02324132	; 0232412C
	mov r2,#0x1	; 0232412E
	b loc_02324134	; 02324130
loc_02324132:
	mov r2,#0x3	; 02324132
loc_02324134:
	ldr r1,[pool_02324190]	; 02324134
	str r2,[r1,#0x1c]	; 02324136
	mov r2,#0x0	; 02324138
	str r2,[r1,#0x18]	; 0232413A
	b loc_02324152	; 0232413C
loc_0232413E:
	cmp r0,#0x0	; 0232413E
	beq loc_0232414E	; 02324140
	mov r2,#0x2	; 02324142
	str r2,[r1,#0x1c]	; 02324144
	ldr r2,[r1,#0x18]	; 02324146
	add r2,r2,#0x1	; 02324148
	str r2,[r1,#0x18]	; 0232414A
	b loc_02324152	; 0232414C
loc_0232414E:
	mov r2,#0x0	; 0232414E
	str r2,[r1,#0x1c]	; 02324150
loc_02324152:
	cmp r0,#0x0	; 02324152
	beq loc_02324162	; 02324154
	add r2,sp,#0x0	; 02324156
	ldrh r3,[r2,#0x8]	; 02324158
	ldr r1,[pool_02324190]	; 0232415A
	strh r3,[r1,#0x14]	; 0232415C
	ldrh r2,[r2,#0xa]	; 0232415E
	strh r2,[r1,#0x16]	; 02324160
loc_02324162:
	ldr r1,[pool_02324190]	; 02324162
	strh r0,[r1,#0x20]	; 02324164
	add r3,sp,#0x8	; 02324166
	ldr r2,[pool_02324194]	; 02324168
	mov r1,#0x4	; 0232416A
loc_0232416C:
	ldrh r0,[r3,#0x0]	; 0232416C
	add r3,r3,#0x2	; 0232416E
	strh r0,[r2,#0x0]	; 02324170
	add r2,r2,#0x2	; 02324172
	sub r1,r1,#0x1	; 02324174
	cmp r1,#0x0	; 02324176
	bne loc_0232416C	; 02324178
loc_0232417A:
	add sp,#0x10	; 0232417A
	pop {r4}	; 0232417C
	pop {r3}	; 0232417E
	bx r3	; 02324180
	.byte 0xC0, 0x46	; 02324184
pool_02324184:
loc_02324184:
	.word REG_KEYINPUT	; 02324184
pool_02324188:
loc_02324188:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 02324188
pool_0232418C:
loc_0232418C:
	.word 0x00002FFF	; 0232418C
pool_02324190:
loc_02324190:
	.word P1_BssStart + 0x35A4	; 02324190
pool_02324194:
loc_02324194:
	.word P1_BssStart + 0x35B0	; 02324194

; ===== function loc_02324198 =====
loc_02324198:
	push {lr}	; 02324198
	sub sp,#0x4	; 0232419A
	bl loc_023241B0	; 0232419C
	mov r1,#0x1	; 023241A0
	ldr r0,[pool_023241AC]	; 023241A2
	str r1,[r0,#0x24]	; 023241A4
	add sp,#0x4	; 023241A6
	pop {r3}	; 023241A8
	bx r3	; 023241AA
pool_023241AC:
loc_023241AC:
	.word P1_BssStart + 0x35A4	; 023241AC

; ===== function loc_023241B0 =====
loc_023241B0:
	push {lr}	; 023241B0
	sub sp,#0x4	; 023241B2
	mov r0,#0x0	; 023241B4
	str r0,[sp,#0x0]	; 023241B6
	ldr r0,[sp,#0x0]	; 023241B8
	ldr r1,[pool_023241C8]	; 023241BA
	mov r2,#0x28	; 023241BC
	blx loc_0232E34C	; 023241BE
	add sp,#0x4	; 023241C2
	pop {r3}	; 023241C4
	bx r3	; 023241C6
pool_023241C8:
loc_023241C8:
	.word 0x02334424	; 023241C8

; ===== function loc_023241CC =====
loc_023241CC:
	push {lr}	; 023241CC
	sub sp,#0x4	; 023241CE
	bl loc_02324274	; 023241D0
	cmp r0,#0x0	; 023241D4
	beq loc_023241E2	; 023241D6
	cmp r0,#0x1	; 023241D8
	beq loc_023241E2	; 023241DA
	cmp r0,#0x2	; 023241DC
	beq loc_023241E6	; 023241DE
	b loc_023241EA	; 023241E0
loc_023241E2:
	mov r0,#0x3	; 023241E2
	b loc_023241EC	; 023241E4
loc_023241E6:
	mov r0,#0xf	; 023241E6
	b loc_023241EC	; 023241E8
loc_023241EA:
	mov r0,#0x2	; 023241EA
loc_023241EC:
	add sp,#0x4	; 023241EC
	pop {r3}	; 023241EE
	bx r3	; 023241F0
	.byte 0x00, 0x00	; 023241F2
P1_Entry_023241F4:
	push {r4,r5,lr}	; 023241F4
	sub sp,#0x4	; 023241F6
	add r5,r0,#0x0	; 023241F8
	add r4,r1,#0x0	; 023241FA
	bl loc_02324284	; 023241FC
	cmp r0,#0x0	; 02324200
	bne P1_Entry_02324228	; 02324202
	add r0,r5,#0x0	; 02324204
	add r1,r4,#0x0	; 02324206
	bl loc_02324274	; 02324208
	cmp r0,#0x1	; 0232420C
	bne P1_Entry_0232422C	; 0232420E
	bl P1_Entry_0232402C	; 02324210
	cmp r0,#0x1e	; 02324214
	bls P1_Entry_0232422C	; 02324216
	bl P1_Entry_0232402C	; 02324218
	sub r0,#0x1e	; 0232421C
	mov r1,#0xa	; 0232421E
	blx P1_UnsignedDivMod	; 02324220
	cmp r1,#0x0	; 02324224
	bne P1_Entry_0232422C	; 02324226
P1_Entry_02324228:
	mov r0,#0x1	; 02324228
	b P1_Entry_0232422E	; 0232422A
P1_Entry_0232422C:
	mov r0,#0x0	; 0232422C
P1_Entry_0232422E:
	add sp,#0x4	; 0232422E
	pop {r4,r5}	; 02324230
	pop {r3}	; 02324232
	bx r3	; 02324234
	.byte 0x00, 0x00	; 02324236
P1_Entry_02324238:
	push {r4,lr}	; 02324238
	add r4,r0,#0x0	; 0232423A
	bl loc_02324088	; 0232423C
	cmp r0,#0x0	; 02324240
	bne P1_Entry_02324266	; 02324242
	add r0,r4,#0x0	; 02324244
	bl loc_02324078	; 02324246
	cmp r0,#0x0	; 0232424A
	beq P1_Entry_0232426A	; 0232424C
	bl P1_Entry_02324014	; 0232424E
	cmp r0,#0x1e	; 02324252
	bls P1_Entry_0232426A	; 02324254
	bl P1_Entry_02324014	; 02324256
	sub r0,#0x1e	; 0232425A
	mov r1,#0xa	; 0232425C
	blx P1_UnsignedDivMod	; 0232425E
	cmp r1,#0x0	; 02324262
	bne P1_Entry_0232426A	; 02324264
P1_Entry_02324266:
	mov r0,#0x1	; 02324266
	b P1_Entry_0232426C	; 02324268
P1_Entry_0232426A:
	mov r0,#0x0	; 0232426A
P1_Entry_0232426C:
	pop {r4}	; 0232426C
	pop {r3}	; 0232426E
	bx r3	; 02324270
	.byte 0x00, 0x00	; 02324272

; ===== function loc_02324274 =====
loc_02324274:
	mov r2,#0x0	; 02324274
	mvn r3,r2	; 02324276
	ldr r2,[r0,#0x0]	; 02324278
	cmp r2,r1	; 0232427A
	bne loc_02324280	; 0232427C
	ldr r3,[r0,#0x8]	; 0232427E
loc_02324280:
	add r0,r3,#0x0	; 02324280
	bx lr	; 02324282

; ===== function loc_02324284 =====
loc_02324284:
	ldr r2,[r0,#0x8]	; 02324284
	cmp r2,#0x0	; 02324286
	bne loc_02324294	; 02324288
	ldr r0,[r0,#0x0]	; 0232428A
	cmp r0,r1	; 0232428C
	bne loc_02324294	; 0232428E
	mov r0,#0x1	; 02324290
	bx lr	; 02324292
loc_02324294:
	mov r0,#0x0	; 02324294
	bx lr	; 02324296

; ===== function loc_02324298 =====
loc_02324298:
	ldr r2,[r0,#0x8]	; 02324298
	cmp r2,#0x3	; 0232429A
	bne loc_023242A8	; 0232429C
	ldr r0,[r0,#0x4]	; 0232429E
	cmp r0,r1	; 023242A0
	bne loc_023242A8	; 023242A2
	mov r0,#0x1	; 023242A4
	bx lr	; 023242A6
loc_023242A8:
	mov r0,#0x0	; 023242A8
	bx lr	; 023242AA

; ===== function loc_023242AC =====
loc_023242AC:
	push {r4,r5,r6,r7,lr}	; 023242AC
	sub sp,#0x4	; 023242AE
	add r5,r0,#0x0	; 023242B0
	add r4,r1,#0x0	; 023242B2
	bl loc_02324044	; 023242B4
	add r6,r0,#0x0	; 023242B8
	bl loc_02324038	; 023242BA
	add r7,r0,#0x0	; 023242BE
	bl loc_02324050	; 023242C0
	cmp r0,#0x1	; 023242C4
	bne loc_023242E8	; 023242C6
	add r0,r4,#0x0	; 023242C8
	add r1,r6,#0x0	; 023242CA
	add r2,r7,#0x0	; 023242CC
	bl loc_02328DBC	; 023242CE
	str r0,[r5,#0x4]	; 023242D2
	ldr r0,[r5,#0x4]	; 023242D4
	str r0,[r5,#0x0]	; 023242D6
	ldr r1,[r5,#0x0]	; 023242D8
	mov r2,#0x0	; 023242DA
	mvn r0,r2	; 023242DC
	cmp r1,r0	; 023242DE
	bne loc_023242E4	; 023242E0
	add r2,r0,#0x0	; 023242E2
loc_023242E4:
	str r2,[r5,#0x8]	; 023242E4
	b loc_0232434E	; 023242E6
loc_023242E8:
	ldr r1,[r5,#0x0]	; 023242E8
	mov r0,#0x0	; 023242EA
	mvn r0,r0	; 023242EC
	cmp r1,r0	; 023242EE
	beq loc_02324318	; 023242F0
	bl loc_02324050	; 023242F2
	cmp r0,#0x2	; 023242F6
	bne loc_02324318	; 023242F8
	add r0,r4,#0x0	; 023242FA
	add r1,r6,#0x0	; 023242FC
	add r2,r7,#0x0	; 023242FE
	bl loc_02328DBC	; 02324300
	str r0,[r5,#0x4]	; 02324304
	ldr r1,[r5,#0x0]	; 02324306
	ldr r0,[r5,#0x4]	; 02324308
	cmp r1,r0	; 0232430A
	bne loc_02324312	; 0232430C
	mov r0,#0x1	; 0232430E
	b loc_02324314	; 02324310
loc_02324312:
	mov r0,#0x2	; 02324312
loc_02324314:
	str r0,[r5,#0x8]	; 02324314
	b loc_0232434E	; 02324316
loc_02324318:
	ldr r1,[r5,#0x0]	; 02324318
	mov r0,#0x0	; 0232431A
	mvn r0,r0	; 0232431C
	cmp r1,r0	; 0232431E
	beq loc_02324348	; 02324320
	bl loc_02324050	; 02324322
	cmp r0,#0x3	; 02324326
	bne loc_02324348	; 02324328
	add r0,r4,#0x0	; 0232432A
	add r1,r6,#0x0	; 0232432C
	add r2,r7,#0x0	; 0232432E
	bl loc_02328DBC	; 02324330
	str r0,[r5,#0x4]	; 02324334
	ldr r1,[r5,#0x0]	; 02324336
	ldr r0,[r5,#0x4]	; 02324338
	cmp r1,r0	; 0232433A
	bne loc_02324342	; 0232433C
	mov r0,#0x3	; 0232433E
	b loc_02324344	; 02324340
loc_02324342:
	mov r0,#0x2	; 02324342
loc_02324344:
	str r0,[r5,#0x8]	; 02324344
	b loc_0232434E	; 02324346
loc_02324348:
	add r0,r5,#0x0	; 02324348
	bl loc_02324358	; 0232434A
loc_0232434E:
	add sp,#0x4	; 0232434E
	pop {r4,r5,r6,r7}	; 02324350
	pop {r3}	; 02324352
	bx r3	; 02324354
	.byte 0x00, 0x00	; 02324358

; ===== function loc_02324358 =====
loc_02324358:
	mov r1,#0x0	; 02324358
	mvn r1,r1	; 0232435A
	str r1,[r0,#0x0]	; 0232435C
	str r1,[r0,#0x4]	; 0232435E
	str r1,[r0,#0x8]	; 02324360
	bx lr	; 02324362

; ===== function loc_02324364 =====
	push {r4,r5,r6,r7,lr}	; 02324364
	sub sp,#0x14	; 02324366
	add r7,r0,#0x0	; 02324368
	str r1,[sp,#0x8]	; 0232436A
	add r5,r2,#0x0	; 0232436C
	str r3,[sp,#0xc]	; 0232436E
	ldr r4,[sp,#0x28]	; 02324370
	ldr r6,[sp,#0x2c]	; 02324372
	b loc_02324388	; 02324374
loc_02324376:
	str r5,[sp,#0x0]	; 02324376
	str r6,[sp,#0x4]	; 02324378
	add r0,r7,#0x0	; 0232437A
	ldr r1,[sp,#0x8]	; 0232437C
	add r2,r5,#0x0	; 0232437E
	ldr r3,[sp,#0xc]	; 02324380
	bl loc_02324394	; 02324382
	add r5,r5,#0x1	; 02324386
loc_02324388:
	cmp r5,r4	; 02324388
	blt loc_02324376	; 0232438A
	add sp,#0x14	; 0232438C
	pop {r4,r5,r6,r7}	; 0232438E
	pop {r3}	; 02324390
	bx r3	; 02324392

; ===== function loc_02324394 =====
loc_02324394:
	push {r4,r5,r6,r7,lr}	; 02324394
	sub sp,#0x1c	; 02324396
	str r0,[sp,#0x0]	; 02324398
	add r5,r1,#0x0	; 0232439A
	add r4,r2,#0x0	; 0232439C
	add r7,r3,#0x0	; 0232439E
	ldr r6,[sp,#0x30]	; 023243A0
	ldr r0,[sp,#0x34]	; 023243A2
	str r0,[sp,#0x34]	; 023243A4
	add r0,r5,#0x0	; 023243A6
	add r1,r7,#0x0	; 023243A8
	bl loc_02324448	; 023243AA
	str r0,[sp,#0x14]	; 023243AE
	add r0,r4,#0x0	; 023243B0
	add r1,r6,#0x0	; 023243B2
	bl loc_02324448	; 023243B4
	ldr r1,[sp,#0x14]	; 023243B8
	cmp r1,r0	; 023243BA
	ble loc_02324400	; 023243BC
	cmp r5,r7	; 023243BE
	ble loc_023243CE	; 023243C0
	add r0,r5,#0x0	; 023243C2
	add r5,r7,#0x0	; 023243C4
	add r7,r0,#0x0	; 023243C6
	add r0,r4,#0x0	; 023243C8
	add r4,r6,#0x0	; 023243CA
	add r6,r0,#0x0	; 023243CC
loc_023243CE:
	sub r0,r7,r5	; 023243CE
	str r0,[sp,#0x4]	; 023243D0
	sub r0,r6,r4	; 023243D2
	lsl r0,r0,#0xc	; 023243D4
	ldr r1,[sp,#0x4]	; 023243D6
	blx P1_SignedDivMod	; 023243D8
	str r0,[sp,#0xc]	; 023243DC
	mov r6,#0x0	; 023243DE
	add r7,r6,#0x0	; 023243E0
	b loc_023243F8	; 023243E2
loc_023243E4:
	ldr r0,[sp,#0x0]	; 023243E4
	add r1,r5,r6	; 023243E6
	asr r2,r7,#0xc	; 023243E8
	add r2,r4,r2	; 023243EA
	ldr r3,[sp,#0x34]	; 023243EC
	bl loc_02324454	; 023243EE
	add r6,r6,#0x1	; 023243F2
	ldr r0,[sp,#0xc]	; 023243F4
	add r7,r7,r0	; 023243F6
loc_023243F8:
	ldr r0,[sp,#0x4]	; 023243F8
	cmp r6,r0	; 023243FA
	blt loc_023243E4	; 023243FC
	b loc_02324440	; 023243FE
loc_02324400:
	cmp r4,r6	; 02324400
	ble loc_02324410	; 02324402
	add r0,r5,#0x0	; 02324404
	add r5,r7,#0x0	; 02324406
	add r7,r0,#0x0	; 02324408
	add r0,r4,#0x0	; 0232440A
	add r4,r6,#0x0	; 0232440C
	add r6,r0,#0x0	; 0232440E
loc_02324410:
	sub r0,r6,r4	; 02324410
	str r0,[sp,#0x8]	; 02324412
	sub r0,r7,r5	; 02324414
	lsl r0,r0,#0xc	; 02324416
	ldr r1,[sp,#0x8]	; 02324418
	blx P1_SignedDivMod	; 0232441A
	str r0,[sp,#0x10]	; 0232441E
	mov r6,#0x0	; 02324420
	add r7,r6,#0x0	; 02324422
	b loc_0232443A	; 02324424
loc_02324426:
	ldr r0,[sp,#0x0]	; 02324426
	asr r1,r7,#0xc	; 02324428
	add r1,r5,r1	; 0232442A
	add r2,r4,r6	; 0232442C
	ldr r3,[sp,#0x34]	; 0232442E
	bl loc_02324454	; 02324430
	add r6,r6,#0x1	; 02324434
	ldr r0,[sp,#0x10]	; 02324436
	add r7,r7,r0	; 02324438
loc_0232443A:
	ldr r0,[sp,#0x8]	; 0232443A
	cmp r6,r0	; 0232443C
	blt loc_02324426	; 0232443E
loc_02324440:
	add sp,#0x1c	; 02324440
	pop {r4,r5,r6,r7}	; 02324442
	pop {r3}	; 02324444
	bx r3	; 02324446

; ===== function loc_02324448 =====
loc_02324448:
	cmp r0,r1	; 02324448
	ble loc_02324450	; 0232444A
	sub r0,r0,r1	; 0232444C
	bx lr	; 0232444E
loc_02324450:
	sub r0,r1,r0	; 02324450
	bx lr	; 02324452

; ===== function loc_02324454 =====
loc_02324454:
	push {r4,r5,r6,r7,lr}	; 02324454
	sub sp,#0x1c	; 02324456
	add r5,r0,#0x0	; 02324458
	add r4,r1,#0x0	; 0232445A
	add r6,r2,#0x0	; 0232445C
	str r3,[sp,#0x0]	; 0232445E
	asr r0,r4,#0x3	; 02324460
	str r0,[sp,#0x4]	; 02324462
	asr r0,r6,#0x3	; 02324464
	str r0,[sp,#0x8]	; 02324466
	mov r1,#0x3	; 02324468
	add r0,r4,#0x0	; 0232446A
	str r0,[sp,#0xc]	; 0232446C
	and r0,r1	; 0232446E
	str r0,[sp,#0xc]	; 02324470
	asr r7,r4,#0x2	; 02324472
	mov r0,#0x1	; 02324474
	and r7,r0	; 02324476
	mov r1,#0x7	; 02324478
	add r0,r6,#0x0	; 0232447A
	str r0,[sp,#0x10]	; 0232447C
	and r0,r1	; 0232447E
	str r0,[sp,#0x10]	; 02324480
	ldrh r0,[r5,#0x4]	; 02324482
	str r0,[sp,#0x14]	; 02324484
	lsl r0,r0,#0x4	; 02324486
	mov r1,#0x8	; 02324488
	blx P1_SignedDivMod	; 0232448A
	ldr r1,[r5,#0x0]	; 0232448E
	ldr r2,[sp,#0x14]	; 02324490
	cmp r4,r2	; 02324492
	bgt loc_023244CE	; 02324494
	ldrh r2,[r5,#0x6]	; 02324496
	cmp r6,r2	; 02324498
	bgt loc_023244CE	; 0232449A
	ldr r2,[sp,#0x4]	; 0232449C
	lsl r3,r2,#0x4	; 0232449E
	ldr r2,[sp,#0x8]	; 023244A0
	mul r0,r2	; 023244A2
	add r0,r3,r0	; 023244A4
	lsl r0,r0,#0x1	; 023244A6
	add r4,r1,r0	; 023244A8
	ldr r0,[sp,#0x10]	; 023244AA
	lsl r0,r0,#0x1	; 023244AC
	add r0,r7,r0	; 023244AE
	lsl r3,r0,#0x1	; 023244B0
	ldr r0,[sp,#0xc]	; 023244B2
	lsl r2,r0,#0x2	; 023244B4
	ldrh r1,[r4,r3]	; 023244B6
	mov r0,#0xf	; 023244B8
	add r5,r0,#0x0	; 023244BA
	lsl r5,r2	; 023244BC
	bic r1,r5	; 023244BE
	ldr r5,[sp,#0x0]	; 023244C0
	lsl r5,r5,#0x18	; 023244C2
	lsr r5,r5,#0x18	; 023244C4
	and r5,r0	; 023244C6
	lsl r5,r2	; 023244C8
	orr r1,r5	; 023244CA
	strh r1,[r4,r3]	; 023244CC
loc_023244CE:
	add sp,#0x1c	; 023244CE
	pop {r4,r5,r6,r7}	; 023244D0
	pop {r3}	; 023244D2
	bx r3	; 023244D4
	.byte 0x00, 0x00	; 023244D8

; ===== function loc_023244D8 =====
loc_023244D8:
	ldr r0,[pool_023244DC]	; 023244D8
	bx lr	; 023244DA
pool_023244DC:
loc_023244DC:
	.word 0x0233444C	; 023244DC

; ===== function loc_023244E0 =====
loc_023244E0:
	push {lr}	; 023244E0
	sub sp,#0x4	; 023244E2
	cmp r0,#0x8	; 023244E4
	bhi loc_02324536	; 023244E6
	add r0,r0,r0	; 023244E8
P1_SwitchIndexPC_023244E8:
	add r0,pc	; 023244EA
	ldrh r0,[r0,#(P1_SwitchTable_023244E8 - (P1_SwitchIndexPC_023244E8 + 4))]	; 023244EC
	lsl r0,r0,#0x10	; 023244EE
	asr r0,r0,#0x10	; 023244F0
P1_SwitchTargetPC_023244E8:
	add r0,pc	; 023244F2
	bx r0	; 023244F4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023244E8:
	.halfword (loc_02324536 + 1) - (P1_SwitchTargetPC_023244E8 + 4)
	.halfword (loc_02324508 + 1) - (P1_SwitchTargetPC_023244E8 + 4)
	.halfword (loc_02324514 + 1) - (P1_SwitchTargetPC_023244E8 + 4)
	.halfword (loc_02324536 + 1) - (P1_SwitchTargetPC_023244E8 + 4)
	.halfword (loc_02324520 + 1) - (P1_SwitchTargetPC_023244E8 + 4)
	.halfword (loc_02324536 + 1) - (P1_SwitchTargetPC_023244E8 + 4)
	.halfword (loc_02324536 + 1) - (P1_SwitchTargetPC_023244E8 + 4)
	.halfword (loc_02324536 + 1) - (P1_SwitchTargetPC_023244E8 + 4)
	.halfword (loc_0232452C + 1) - (P1_SwitchTargetPC_023244E8 + 4)
P1_SwitchTable_023244E8End:
loc_02324508:
	ldr r0,[pool_0232453C]	; 02324508
	mov r1,#0x0	; 0232450A
	ldr r2,[pool_02324540]	; 0232450C
	bl loc_0232DF60	; 0232450E
	b loc_02324536	; 02324512
loc_02324514:
	ldr r0,[pool_0232453C]	; 02324514
	mov r1,#0x0	; 02324516
	ldr r2,[pool_02324540]	; 02324518
	bl loc_0232DEE0	; 0232451A
	b loc_02324536	; 0232451E
loc_02324520:
	ldr r0,[pool_0232453C]	; 02324520
	mov r1,#0x0	; 02324522
	ldr r2,[pool_02324540]	; 02324524
	bl loc_0232DE60	; 02324526
	b loc_02324536	; 0232452A
loc_0232452C:
	ldr r0,[pool_0232453C]	; 0232452C
	mov r1,#0x0	; 0232452E
	ldr r2,[pool_02324540]	; 02324530
	bl loc_0232DDE0	; 02324532
loc_02324536:
	add sp,#0x4	; 02324536
	pop {r3}	; 02324538
	bx r3	; 0232453A
pool_0232453C:
loc_0232453C:
	.word 0x0233444C	; 0232453C
pool_02324540:
loc_02324540:
	.word 0x00000600	; 02324540

; ===== function loc_02324544 =====
P1_Entry_02324544:
	push {lr}	; 02324544
	sub sp,#0x4	; 02324546
	mov r0,#0x0	; 02324548
	str r0,[sp,#0x0]	; 0232454A
	ldr r0,[sp,#0x0]	; 0232454C
	ldr r1,[pool_02324564]	; 0232454E
	ldr r2,[pool_02324568]	; 02324550
	blx loc_0232E34C	; 02324552
	ldr r0,[pool_02324564]	; 02324556
	ldr r1,[pool_02324568]	; 02324558
	blx P1_CleanDataCacheRange	; 0232455A
	add sp,#0x4	; 0232455E
	pop {r3}	; 02324560
	bx r3	; 02324562
pool_02324564:
loc_02324564:
	.word 0x0233444C	; 02324564
pool_02324568:
loc_02324568:
	.word 0x00000600	; 02324568

; ===== function loc_0232456C =====
loc_0232456C:
	push {r4,r5,r6,r7,lr}	; 0232456C
	sub sp,#0x54	; 0232456E
	add r5,r0,#0x0	; 02324570
	add r4,r1,#0x0	; 02324572
	add r7,r2,#0x0	; 02324574
	str r3,[sp,#0x20]	; 02324576
	ldr r0,[sp,#0x74]	; 02324578
	str r0,[sp,#0x74]	; 0232457A
	ldr r1,[pool_023246B8]	; 0232457C
	ldrh r2,[r1,#0x0]	; 0232457E
	add r0,sp,#0x38	; 02324580
	strh r2,[r0,#0x18]	; 02324582
	ldrh r1,[r1,#0x2]	; 02324584
	strh r1,[r0,#0x1a]	; 02324586
	ldr r0,[sp,#0x68]	; 02324588
	ldr r1,[pool_023246BC]	; 0232458A
	cmp r0,r1	; 0232458C
	bne loc_023245AA	; 0232458E
	add r0,r7,#0x0	; 02324590
	lsl r1,r3,#0	; 02324592
	bl loc_02328D64	; 02324594
	ldr r0,[r0,#0x8]	; 02324598
	cmp r0,#0x0	; 0232459A
	beq loc_023245A4	; 0232459C
	add r0,r7,r0	; 0232459E
	str r0,[sp,#0x28]	; 023245A0
	b loc_023245BA	; 023245A2
loc_023245A4:
	add r0,sp,#0x50	; 023245A4
	str r0,[sp,#0x28]	; 023245A6
	b loc_023245BA	; 023245A8
loc_023245AA:
	bl loc_02324D1C	; 023245AA
	str r0,[sp,#0x28]	; 023245AE
	ldrh r0,[r0,#0x0]	; 023245B0
	cmp r0,#0x0	; 023245B2
	bne loc_023245BA	; 023245B4
	add r0,sp,#0x50	; 023245B6
	str r0,[sp,#0x28]	; 023245B8
loc_023245BA:
	ldr r0,[sp,#0x6c]	; 023245BA
	cmp r0,#0x0	; 023245BC
	beq loc_023245C2	; 023245BE
	str r0,[sp,#0x28]	; 023245C0
loc_023245C2:
	add r0,sp,#0x48	; 023245C2
	str r0,[sp,#0x0]	; 023245C4
	add r0,sp,#0x4c	; 023245C6
	str r0,[sp,#0x4]	; 023245C8
	ldr r0,[sp,#0x28]	; 023245CA
	str r0,[sp,#0x8]	; 023245CC
	add r0,r7,#0x0	; 023245CE
	ldr r1,[sp,#0x20]	; 023245D0
	add r2,sp,#0x40	; 023245D2
	add r3,sp,#0x44	; 023245D4
	bl loc_023247E8	; 023245D6
	str r5,[r4,#0x24]	; 023245DA
	str r7,[r4,#0x20]	; 023245DC
	ldr r0,[sp,#0x68]	; 023245DE
	strh r0,[r4,#0x1a]	; 023245E0
	ldr r0,[sp,#0x20]	; 023245E2
	strh r0,[r4,#0x1c]	; 023245E4
	mov r1,#0x0	; 023245E6
	add r0,r4,#0x0	; 023245E8
	add r0,#0x28	; 023245EA
	strb r1,[r0,#0x0]	; 023245EC
	add r0,r7,#0x0	; 023245EE
	ldr r1,[sp,#0x20]	; 023245F0
	bl loc_02328D64	; 023245F2
	ldrh r0,[r0,#0x6]	; 023245F6
	lsl r0,r0,#0x14	; 023245F8
	lsr r0,r0,#0x1c	; 023245FA
	strh r0,[r4,#0x16]	; 023245FC
	ldr r0,[sp,#0x40]	; 023245FE
	strh r0,[r4,#0x8]	; 02324600
	ldr r0,[sp,#0x44]	; 02324602
	strh r0,[r4,#0xa]	; 02324604
	ldr r0,[sp,#0x48]	; 02324606
	strb r0,[r4,#0xc]	; 02324608
	ldr r0,[sp,#0x4c]	; 0232460A
	strb r0,[r4,#0xd]	; 0232460C
	ldr r0,[sp,#0x70]	; 0232460E
	cmp r0,#0x0	; 02324610
	beq loc_02324644	; 02324612
	add r0,r5,#0x0	; 02324614
	add r1,r4,#0x0	; 02324616
	bl loc_0232923C	; 02324618
	ldrh r0,[r5,#0xe]	; 0232461C
	strh r0,[r4,#0x14]	; 0232461E
	ldr r0,[sp,#0x48]	; 02324620
	ldr r1,[sp,#0x4c]	; 02324622
	bl loc_0232485C	; 02324624
	str r0,[r4,#0x10]	; 02324628
	ldr r0,[r4,#0x10]	; 0232462A
	add r1,sp,#0x38	; 0232462C
	add r2,sp,#0x3c	; 0232462E
	bl loc_023248CC	; 02324630
	ldr r0,[sp,#0x48]	; 02324634
	sub r0,r0,#0x1	; 02324636
	ldr r1,[sp,#0x38]	; 02324638
	blx P1_SignedDivMod	; 0232463A
	add r0,r0,#0x1	; 0232463E
	strh r0,[r4,#0x18]	; 02324640
	b loc_0232464E	; 02324642
loc_02324644:
	ldr r0,[r4,#0x10]	; 02324644
	add r1,sp,#0x38	; 02324646
	add r2,sp,#0x3c	; 02324648
	bl loc_023248CC	; 0232464A
loc_0232464E:
	ldrh r0,[r4,#0x14]	; 0232464E
	str r0,[sp,#0x34]	; 02324650
	mov r0,#0x0	; 02324652
	str r0,[sp,#0x24]	; 02324654
	str r0,[sp,#0x2c]	; 02324656
	b loc_0232469C	; 02324658
loc_0232465A:
	ldr r0,[sp,#0x38]	; 0232465A
	str r0,[sp,#0x30]	; 0232465C
	ldr r0,[sp,#0x2c]	; 0232465E
	str r0,[sp,#0x0]	; 02324660
	ldr r0,[sp,#0x30]	; 02324662
	str r0,[sp,#0x4]	; 02324664
	ldr r0,[sp,#0x3c]	; 02324666
	str r0,[sp,#0x8]	; 02324668
	ldr r0,[sp,#0x34]	; 0232466A
	str r0,[sp,#0xc]	; 0232466C
	ldr r0,[sp,#0x40]	; 0232466E
	str r0,[sp,#0x10]	; 02324670
	ldr r0,[sp,#0x44]	; 02324672
	str r0,[sp,#0x14]	; 02324674
	ldr r0,[sp,#0x28]	; 02324676
	str r0,[sp,#0x18]	; 02324678
	ldr r0,[sp,#0x74]	; 0232467A
	str r0,[sp,#0x1c]	; 0232467C
	add r0,r5,#0x0	; 0232467E
	add r1,r7,#0x0	; 02324680
	ldr r2,[sp,#0x20]	; 02324682
	ldr r6,[sp,#0x24]	; 02324684
	ldr r3,[sp,#0x30]	; 02324686
	mul r3,r6	; 02324688
	str r3,[sp,#0x30]	; 0232468A
	bl loc_023246C0	; 0232468C
	ldr r1,[sp,#0x34]	; 02324690
	add r0,r1,r0	; 02324692
	str r0,[sp,#0x34]	; 02324694
	ldr r0,[sp,#0x24]	; 02324696
	add r0,r0,#0x1	; 02324698
	str r0,[sp,#0x24]	; 0232469A
loc_0232469C:
	ldrh r1,[r4,#0x18]	; 0232469C
	ldr r0,[sp,#0x24]	; 0232469E
	cmp r0,r1	; 023246A0
	blt loc_0232465A	; 023246A2
	ldr r0,[sp,#0x70]	; 023246A4
	cmp r0,#0x0	; 023246A6
	beq loc_023246AE	; 023246A8
	ldr r0,[sp,#0x34]	; 023246AA
	strh r0,[r5,#0xe]	; 023246AC
loc_023246AE:
	add sp,#0x54	; 023246AE
	pop {r4,r5,r6,r7}	; 023246B0
	pop {r3}	; 023246B2
	bx r3	; 023246B4
	.byte 0xC0, 0x46	; 023246B8
pool_023246B8:
loc_023246B8:
	.word P1_Data_02330B28	; 023246B8
pool_023246BC:
loc_023246BC:
	.word 0x0000FFFF	; 023246BC

; ===== function loc_023246C0 =====
loc_023246C0:
	push {r4,r5,r6,r7,lr}	; 023246C0
	sub sp,#0x34	; 023246C2
	add r5,r0,#0x0	; 023246C4
	str r1,[sp,#0x10]	; 023246C6
	str r2,[sp,#0x14]	; 023246C8
	str r3,[sp,#0x18]	; 023246CA
	ldr r0,[sp,#0x4c]	; 023246CC
	mov r1,#0x8	; 023246CE
	blx P1_SignedDivMod	; 023246D0
	add r6,r0,#0x0	; 023246D4
	ldr r0,[sp,#0x50]	; 023246D6
	mov r1,#0x8	; 023246D8
	blx P1_SignedDivMod	; 023246DA
	mul r6,r0	; 023246DE
	ldr r1,[sp,#0x54]	; 023246E0
	ldrh r0,[r5,#0xc]	; 023246E2
	sub r0,r1,r0	; 023246E4
	lsl r4,r0,#0x7	; 023246E6
	bl loc_02324BE8	; 023246E8
	add r7,r0,#0x0	; 023246EC
	ldr r0,[sp,#0x10]	; 023246EE
	ldr r1,[sp,#0x14]	; 023246F0
	bl loc_02328D64	; 023246F2
	mov r0,#0x0	; 023246F6
	str r0,[sp,#0x20]	; 023246F8
	ldr r0,[sp,#0x4c]	; 023246FA
	ldr r1,[sp,#0x50]	; 023246FC
	mul r0,r1	; 023246FE
	mov r1,#0x2	; 02324700
	blx P1_SignedDivMod	; 02324702
	add r2,r0,#0x0	; 02324706
	ldr r0,[sp,#0x20]	; 02324708
	ldr r1,[r5,#0x14]	; 0232470A
	add r1,r1,r4	; 0232470C
	blx loc_0232E34C	; 0232470E
	mov r0,#0x0	; 02324712
	str r0,[sp,#0x0]	; 02324714
	str r7,[sp,#0x4]	; 02324716
	add r0,sp,#0x24	; 02324718
	ldr r1,[r5,#0x14]	; 0232471A
	add r1,r1,r4	; 0232471C
	ldr r2,[sp,#0x4c]	; 0232471E
	lsl r2,r2,#0x10	; 02324720
	lsr r2,r2,#0x10	; 02324722
	ldr r3,[sp,#0x50]	; 02324724
	lsl r3,r3,#0x10	; 02324726
	lsr r3,r3,#0x10	; 02324728
	bl loc_02328BF0	; 0232472A
	ldr r0,[sp,#0x10]	; 0232472E
	ldr r1,[sp,#0x14]	; 02324730
	bl loc_02328D64	; 02324732
	add r4,r0,#0x0	; 02324736
	add r5,sp,#0x1c	; 02324738
	ldrh r1,[r4,#0x0]	; 0232473A
	add r0,sp,#0x1c	; 0232473C
	strh r1,[r0,#0x0]	; 0232473E
	mov r0,#0x0	; 02324740
	ldrsh r1,[r5,r0]	; 02324742
	add r3,r1,#0x0	; 02324744
	ldr r0,[pool_023247E0]	; 02324746
	and r3,r0	; 02324748
	lsl r0,r1,#0x14	; 0232474A
	asr r2,r0,#0x14	; 0232474C
	ldr r1,[sp,#0x58]	; 0232474E
	ldr r0,[sp,#0x18]	; 02324750
	add r0,r1,r0	; 02324752
	sub r0,r2,r0	; 02324754
	lsl r0,r0,#0x10	; 02324756
	asr r1,r0,#0x10	; 02324758
	ldr r0,[pool_023247E4]	; 0232475A
	and r1,r0	; 0232475C
	orr r3,r1	; 0232475E
	strh r3,[r5,#0x0]	; 02324760
	add r5,sp,#0x1c	; 02324762
	add r5,#0x2	; 02324764
	ldrh r1,[r4,#0x2]	; 02324766
	add r0,sp,#0x1c	; 02324768
	strh r1,[r0,#0x2]	; 0232476A
	mov r0,#0x0	; 0232476C
	ldrsh r1,[r5,r0]	; 0232476E
	add r3,r1,#0x0	; 02324770
	ldr r0,[pool_023247E0]	; 02324772
	and r3,r0	; 02324774
	lsl r0,r1,#0x14	; 02324776
	asr r2,r0,#0x14	; 02324778
	ldr r1,[sp,#0x5c]	; 0232477A
	ldr r0,[sp,#0x48]	; 0232477C
	add r0,r1,r0	; 0232477E
	sub r0,r2,r0	; 02324780
	lsl r0,r0,#0x10	; 02324782
	asr r1,r0,#0x10	; 02324784
	ldr r0,[pool_023247E4]	; 02324786
	and r1,r0	; 02324788
	orr r3,r1	; 0232478A
	strh r3,[r5,#0x0]	; 0232478C
	ldr r0,[sp,#0x64]	; 0232478E
	mov r1,#0x0	; 02324790
	mvn r1,r1	; 02324792
	cmp r0,r1	; 02324794
	bne loc_0232479A	; 02324796
	ldrb r0,[r4,#0x6]	; 02324798
loc_0232479A:
	mov r1,#0x4	; 0232479A
	ldrsb r1,[r4,r1]	; 0232479C
	str r1,[sp,#0x0]	; 0232479E
	mov r1,#0x5	; 023247A0
	ldrsb r1,[r4,r1]	; 023247A2
	str r1,[sp,#0x4]	; 023247A4
	ldr r1,[sp,#0x60]	; 023247A6
	str r1,[sp,#0x8]	; 023247A8
	str r0,[sp,#0xc]	; 023247AA
	ldrh r0,[r4,#0x6]	; 023247AC
	lsl r0,r0,#0x10	; 023247AE
	lsr r0,r0,#0x1c	; 023247B0
	lsl r0,r0,#0x5	; 023247B2
	add r0,r7,r0	; 023247B4
	add r1,sp,#0x24	; 023247B6
	mov r4,sp	; 023247B8
	sub r4,r4,#0x4	; 023247BA
	add r5,sp,#0x1c	; 023247BC
	ldrh r2,[r5,#0x0]	; 023247BE
	strh r2,[r4,#0x0]	; 023247C0
	add r3,r4,#0x0	; 023247C2
	ldmia r3!,{r2}	; 023247C4
	ldrh r3,[r5,#0x2]	; 023247C6
	strh r3,[r4,#0x0]	; 023247C8
	ldmia r4!,{r3}	; 023247CA
	bl loc_02328890	; 023247CC
	add r0,r6,#0x0	; 023247D0
	mov r1,#0x4	; 023247D2
	blx P1_SignedDivMod	; 023247D4
	add sp,#0x34	; 023247D8
	pop {r4,r5,r6,r7}	; 023247DA
	pop {r3}	; 023247DC
	bx r3	; 023247DE
pool_023247E0:
loc_023247E0:
	.word 0xFFFFF000	; 023247E0
pool_023247E4:
loc_023247E4:
	.word 0x00000FFF	; 023247E4

; ===== function loc_023247E8 =====
loc_023247E8:
	push {r4,r5,r6,r7,lr}	; 023247E8
	sub sp,#0x4	; 023247EA
	add r7,r2,#0x0	; 023247EC
	str r3,[sp,#0x0]	; 023247EE
	ldr r5,[sp,#0x18]	; 023247F0
	ldr r6,[sp,#0x1c]	; 023247F2
	bl loc_02328D64	; 023247F4
	add r4,r0,#0x0	; 023247F8
	bl loc_02324BE8	; 023247FA
	ldrh r1,[r4,#0x6]	; 023247FE
	lsl r1,r1,#0x10	; 02324800
	lsr r1,r1,#0x1c	; 02324802
	lsl r1,r1,#0x5	; 02324804
	add r0,r0,r1	; 02324806
	ldr r1,[sp,#0x20]	; 02324808
	mov r2,#0x4	; 0232480A
	ldrsb r2,[r4,r2]	; 0232480C
	bl loc_023287E0	; 0232480E
	str r0,[r5,#0x0]	; 02324812
	bl loc_02324BE8	; 02324814
	ldrh r1,[r4,#0x6]	; 02324818
	lsl r1,r1,#0x10	; 0232481A
	lsr r1,r1,#0x1c	; 0232481C
	lsl r1,r1,#0x5	; 0232481E
	add r0,r0,r1	; 02324820
	ldr r1,[sp,#0x20]	; 02324822
	mov r2,#0x5	; 02324824
	ldrsb r2,[r4,r2]	; 02324826
	bl loc_023287C0	; 02324828
	str r0,[r6,#0x0]	; 0232482C
	mov r1,sp	; 0232482E
	sub r1,r1,#0x4	; 02324830
	ldrh r0,[r4,#0x0]	; 02324832
	strh r0,[r1,#0x0]	; 02324834
	ldmia r1!,{r0}	; 02324836
	ldr r1,[r5,#0x0]	; 02324838
	bl loc_02328CAC	; 0232483A
	str r0,[r7,#0x0]	; 0232483E
	mov r1,sp	; 02324840
	sub r1,r1,#0x4	; 02324842
	ldrh r0,[r4,#0x2]	; 02324844
	strh r0,[r1,#0x0]	; 02324846
	ldmia r1!,{r0}	; 02324848
	ldr r1,[r6,#0x0]	; 0232484A
	bl loc_02328C74	; 0232484C
	ldr r1,[sp,#0x0]	; 02324850
	str r0,[r1,#0x0]	; 02324852
	add sp,#0x4	; 02324854
	pop {r4,r5,r6,r7}	; 02324856
	pop {r3}	; 02324858
	bx r3	; 0232485A

; ===== function loc_0232485C =====
loc_0232485C:
	push {r4,r5,lr}	; 0232485C
	sub sp,#0x4	; 0232485E
	add r5,r1,#0x0	; 02324860
	sub r0,r0,#0x1	; 02324862
	mov r1,#0x8	; 02324864
	blx P1_SignedDivMod	; 02324866
	add r4,r0,#0x1	; 0232486A
	sub r0,r5,#0x1	; 0232486C
	mov r1,#0x8	; 0232486E
	blx P1_SignedDivMod	; 02324870
	add r0,r0,#0x1	; 02324874
	cmp r4,#0x2	; 02324876
	bgt loc_02324886	; 02324878
	cmp r0,#0x2	; 0232487A
	bgt loc_02324882	; 0232487C
	ldr r0,[pool_023248B8]	; 0232487E
	b loc_023248B0	; 02324880
loc_02324882:
	ldr r0,[pool_023248BC]	; 02324882
	b loc_023248B0	; 02324884
loc_02324886:
	cmp r4,#0x4	; 02324886
	bgt loc_0232489E	; 02324888
	cmp r0,#0x2	; 0232488A
	bgt loc_02324892	; 0232488C
	ldr r0,[pool_023248C0]	; 0232488E
	b loc_023248B0	; 02324890
loc_02324892:
	cmp r0,#0x4	; 02324892
	bgt loc_0232489A	; 02324894
	ldr r0,[pool_023248BC]	; 02324896
	b loc_023248B0	; 02324898
loc_0232489A:
	ldr r0,[pool_023248C4]	; 0232489A
	b loc_023248B0	; 0232489C
loc_0232489E:
	cmp r0,#0x2	; 0232489E
	bgt loc_023248A6	; 023248A0
	ldr r0,[pool_023248C0]	; 023248A2
	b loc_023248B0	; 023248A4
loc_023248A6:
	cmp r0,#0x4	; 023248A6
	bgt loc_023248AE	; 023248A8
	ldr r0,[pool_023248C8]	; 023248AA
	b loc_023248B0	; 023248AC
loc_023248AE:
	ldr r0,[pool_023248C4]	; 023248AE
loc_023248B0:
	add sp,#0x4	; 023248B0
	pop {r4,r5}	; 023248B2
	pop {r3}	; 023248B4
	bx r3	; 023248B6
pool_023248B8:
loc_023248B8:
	.word 0x40000000	; 023248B8
pool_023248BC:
loc_023248BC:
	.word 0x80000000	; 023248BC
pool_023248C0:
loc_023248C0:
	.word 0x80004000	; 023248C0
pool_023248C4:
loc_023248C4:
	.word 0xC0000000	; 023248C4
pool_023248C8:
loc_023248C8:
	.word 0xC0004000	; 023248C8

; ===== function loc_023248CC =====
loc_023248CC:
	push {r4,lr}	; 023248CC
	ldr r4,[pool_02324990]	; 023248CE
	cmp r0,r4	; 023248D0
	bgt loc_0232490A	; 023248D2
	cmp r0,r4	; 023248D4
	bge loc_02324982	; 023248D6
	ldr r4,[pool_02324994]	; 023248D8
	cmp r0,r4	; 023248DA
	bgt loc_023248F6	; 023248DC
	cmp r0,r4	; 023248DE
	bge loc_0232497C	; 023248E0
	ldr r4,[pool_02324998]	; 023248E2
	cmp r0,r4	; 023248E4
	bgt loc_023248EE	; 023248E6
	cmp r0,r4	; 023248E8
	beq loc_0232494C	; 023248EA
	b loc_02324986	; 023248EC
loc_023248EE:
	ldr r4,[pool_0232499C]	; 023248EE
	cmp r0,r4	; 023248F0
	beq loc_02324964	; 023248F2
	b loc_02324986	; 023248F4
loc_023248F6:
	ldr r4,[pool_023249A0]	; 023248F6
	cmp r0,r4	; 023248F8
	bgt loc_02324902	; 023248FA
	cmp r0,r4	; 023248FC
	beq loc_02324952	; 023248FE
	b loc_02324986	; 02324900
loc_02324902:
	ldr r4,[pool_023249A4]	; 02324902
	cmp r0,r4	; 02324904
	beq loc_0232496A	; 02324906
	b loc_02324986	; 02324908
loc_0232490A:
	ldr r4,[pool_023249A8]	; 0232490A
	cmp r0,r4	; 0232490C
	bgt loc_02324926	; 0232490E
	cmp r0,r4	; 02324910
	bge loc_02324970	; 02324912
	cmp r0,#0x0	; 02324914
	bgt loc_0232491E	; 02324916
	cmp r0,#0x0	; 02324918
	beq loc_02324940	; 0232491A
	b loc_02324986	; 0232491C
loc_0232491E:
	ldr r4,[pool_023249AC]	; 0232491E
	cmp r0,r4	; 02324920
	beq loc_02324958	; 02324922
	b loc_02324986	; 02324924
loc_02324926:
	ldr r4,[pool_023249B0]	; 02324926
	cmp r0,r4	; 02324928
	bgt loc_02324938	; 0232492A
	cmp r0,r4	; 0232492C
	bge loc_0232495E	; 0232492E
	ldr r4,[pool_023249B4]	; 02324930
	cmp r0,r4	; 02324932
	beq loc_02324946	; 02324934
	b loc_02324986	; 02324936
loc_02324938:
	ldr r4,[pool_023249B8]	; 02324938
	cmp r0,r4	; 0232493A
	beq loc_02324976	; 0232493C
	b loc_02324986	; 0232493E
loc_02324940:
	mov r3,#0x8	; 02324940
	add r0,r3,#0x0	; 02324942
	b loc_02324986	; 02324944
loc_02324946:
	mov r3,#0x10	; 02324946
	add r0,r3,#0x0	; 02324948
	b loc_02324986	; 0232494A
loc_0232494C:
	mov r3,#0x20	; 0232494C
	add r0,r3,#0x0	; 0232494E
	b loc_02324986	; 02324950
loc_02324952:
	mov r3,#0x40	; 02324952
	add r0,r3,#0x0	; 02324954
	b loc_02324986	; 02324956
loc_02324958:
	mov r3,#0x10	; 02324958
	mov r0,#0x8	; 0232495A
	b loc_02324986	; 0232495C
loc_0232495E:
	mov r3,#0x20	; 0232495E
	mov r0,#0x8	; 02324960
	b loc_02324986	; 02324962
loc_02324964:
	mov r3,#0x20	; 02324964
	mov r0,#0x10	; 02324966
	b loc_02324986	; 02324968
loc_0232496A:
	mov r3,#0x40	; 0232496A
	mov r0,#0x20	; 0232496C
	b loc_02324986	; 0232496E
loc_02324970:
	mov r3,#0x8	; 02324970
	mov r0,#0x10	; 02324972
	b loc_02324986	; 02324974
loc_02324976:
	mov r3,#0x8	; 02324976
	mov r0,#0x20	; 02324978
	b loc_02324986	; 0232497A
loc_0232497C:
	mov r3,#0x10	; 0232497C
	mov r0,#0x20	; 0232497E
	b loc_02324986	; 02324980
loc_02324982:
	mov r3,#0x20	; 02324982
	mov r0,#0x40	; 02324984
loc_02324986:
	str r3,[r1,#0x0]	; 02324986
	str r0,[r2,#0x0]	; 02324988
	pop {r4}	; 0232498A
	pop {r3}	; 0232498C
	bx r3	; 0232498E
pool_02324990:
loc_02324990:
	.word 0xC0008000	; 02324990
pool_02324994:
loc_02324994:
	.word 0x80008000	; 02324994
pool_02324998:
loc_02324998:
	.word 0x80000000	; 02324998
pool_0232499C:
loc_0232499C:
	.word 0x80004000	; 0232499C
pool_023249A0:
loc_023249A0:
	.word 0xC0000000	; 023249A0
pool_023249A4:
loc_023249A4:
	.word 0xC0004000	; 023249A4
pool_023249A8:
loc_023249A8:
	.word 0x00008000	; 023249A8
pool_023249AC:
loc_023249AC:
	.word 0x00004000	; 023249AC
pool_023249B0:
loc_023249B0:
	.word 0x40004000	; 023249B0
pool_023249B4:
loc_023249B4:
	.word 0x40000000	; 023249B4
pool_023249B8:
loc_023249B8:
	.word 0x40008000	; 023249B8

; ===== function loc_023249BC =====
loc_023249BC:
	push {r4,r5,lr}	; 023249BC
	sub sp,#0x4	; 023249BE
	add r5,r0,#0x0	; 023249C0
	mov r4,#0x0	; 023249C2
	b loc_023249D6	; 023249C4
loc_023249C6:
	add r0,r4,#0x0	; 023249C6
	add r0,#0x28	; 023249C8
	ldrb r0,[r0,#0x0]	; 023249CA
	cmp r0,#0x0	; 023249CC
	bne loc_023249D6	; 023249CE
	add r0,r4,#0x0	; 023249D0
	bl loc_023249EC	; 023249D2
loc_023249D6:
	add r0,r5,#0x0	; 023249D6
	add r1,r4,#0x0	; 023249D8
	bl loc_0232916C	; 023249DA
	add r4,r0,#0x0	; 023249DE
	cmp r4,#0x0	; 023249E0
	bne loc_023249C6	; 023249E2
	add sp,#0x4	; 023249E4
	pop {r4,r5}	; 023249E6
	pop {r3}	; 023249E8
	bx r3	; 023249EA

; ===== function loc_023249EC =====
loc_023249EC:
	push {r4,r5,r6,r7,lr}	; 023249EC
	sub sp,#0xc	; 023249EE
	add r5,r0,#0x0	; 023249F0
	ldrh r1,[r5,#0x14]	; 023249F2
	ldr r0,[r5,#0x24]	; 023249F4
	ldrh r0,[r0,#0xc]	; 023249F6
	sub r0,r1,r0	; 023249F8
	lsl r4,r0,#0x7	; 023249FA
	lsl r6,r1,#0x7	; 023249FC
	ldr r0,[r5,#0x10]	; 023249FE
	add r1,sp,#0x0	; 02324A00
	add r2,sp,#0x4	; 02324A02
	bl loc_023248CC	; 02324A04
	ldrh r0,[r5,#0x18]	; 02324A08
	ldr r2,[sp,#0x0]	; 02324A0A
	ldr r1,[sp,#0x4]	; 02324A0C
	mul r2,r1	; 02324A0E
	mul r0,r2	; 02324A10
	mov r1,#0x2	; 02324A12
	blx P1_SignedDivMod	; 02324A14
	add r7,r0,#0x0	; 02324A18
	ldr r0,[r5,#0x24]	; 02324A1A
	ldr r0,[r0,#0x14]	; 02324A1C
	add r0,r0,r4	; 02324A1E
	add r1,r7,#0x0	; 02324A20
	blx P1_CleanDataCacheRange	; 02324A22
	ldr r1,[r5,#0x24]	; 02324A26
	ldrh r0,[r1,#0x10]	; 02324A28
	cmp r0,#0x0	; 02324A2A
	beq loc_02324A3C	; 02324A2C
	ldr r0,[r1,#0x14]	; 02324A2E
	add r0,r0,r4	; 02324A30
	add r1,r6,#0x0	; 02324A32
	add r2,r7,#0x0	; 02324A34
	bl loc_0232E020	; 02324A36
	b loc_02324A48	; 02324A3A
loc_02324A3C:
	ldr r0,[r1,#0x14]	; 02324A3C
	add r0,r0,r4	; 02324A3E
	add r1,r6,#0x0	; 02324A40
	add r2,r7,#0x0	; 02324A42
	bl loc_0232DFE0	; 02324A44
loc_02324A48:
	mov r0,#0x1	; 02324A48
	add r5,#0x28	; 02324A4A
	strb r0,[r5,#0x0]	; 02324A4C
	add sp,#0xc	; 02324A4E
	pop {r4,r5,r6,r7}	; 02324A50
	pop {r3}	; 02324A52
	bx r3	; 02324A54
	.byte 0x00, 0x00	; 02324A58

; ===== function loc_02324A58 =====
loc_02324A58:
	push {lr}	; 02324A58
	sub sp,#0x14	; 02324A5A
	add r3,r0,#0x0	; 02324A5C
	ldr r0,[pool_02324A7C]	; 02324A5E
	str r0,[sp,#0x0]	; 02324A60
	str r1,[sp,#0x4]	; 02324A62
	mov r0,#0x0	; 02324A64
	str r0,[sp,#0x8]	; 02324A66
	str r2,[sp,#0xc]	; 02324A68
	ldr r0,[r3,#0x24]	; 02324A6A
	add r1,r3,#0x0	; 02324A6C
	ldr r2,[r3,#0x20]	; 02324A6E
	ldrh r3,[r3,#0x1c]	; 02324A70
	bl loc_0232456C	; 02324A72
	add sp,#0x14	; 02324A76
	pop {r3}	; 02324A78
	bx r3	; 02324A7A
pool_02324A7C:
loc_02324A7C:
	.word 0x0000FFFF	; 02324A7C

; ===== function loc_02324A80 =====
loc_02324A80:
	push {lr}	; 02324A80
	sub sp,#0x14	; 02324A82
	add r3,r0,#0x0	; 02324A84
	ldr r0,[pool_02324AA8]	; 02324A86
	str r0,[sp,#0x0]	; 02324A88
	str r1,[sp,#0x4]	; 02324A8A
	mov r0,#0x0	; 02324A8C
	str r0,[sp,#0x8]	; 02324A8E
	mvn r0,r0	; 02324A90
	str r0,[sp,#0xc]	; 02324A92
	ldr r0,[r3,#0x24]	; 02324A94
	add r1,r3,#0x0	; 02324A96
	ldr r2,[r3,#0x20]	; 02324A98
	ldrh r3,[r3,#0x1c]	; 02324A9A
	bl loc_0232456C	; 02324A9C
	add sp,#0x14	; 02324AA0
	pop {r3}	; 02324AA2
	bx r3	; 02324AA4
	.byte 0xC0, 0x46	; 02324AA8
pool_02324AA8:
loc_02324AA8:
	.word 0x0000FFFF	; 02324AA8

; ===== function loc_02324AAC =====
	push {r4,r5,lr}	; 02324AAC
	sub sp,#0x14	; 02324AAE
	add r5,r0,#0x0	; 02324AB0
	add r4,r1,#0x0	; 02324AB2
	add r3,r2,#0x0	; 02324AB4
	ldr r0,[pool_02324AD8]	; 02324AB6
	str r0,[sp,#0x0]	; 02324AB8
	mov r0,#0x0	; 02324ABA
	str r0,[sp,#0x4]	; 02324ABC
	str r0,[sp,#0x8]	; 02324ABE
	mvn r0,r0	; 02324AC0
	str r0,[sp,#0xc]	; 02324AC2
	ldr r0,[r5,#0x24]	; 02324AC4
	add r1,r5,#0x0	; 02324AC6
	add r2,r4,#0x0	; 02324AC8
	bl loc_0232456C	; 02324ACA
	add sp,#0x14	; 02324ACE
	pop {r4,r5}	; 02324AD0
	pop {r3}	; 02324AD2
	bx r3	; 02324AD4
	.byte 0xC0, 0x46	; 02324AD8
pool_02324AD8:
loc_02324AD8:
	.word 0x0000FFFF	; 02324AD8

; ===== function loc_02324ADC =====
loc_02324ADC:
	push {r4,r5,r6,lr}	; 02324ADC
	sub sp,#0x10	; 02324ADE
	add r5,r0,#0x0	; 02324AE0
	add r4,r1,#0x0	; 02324AE2
	add r6,r2,#0x0	; 02324AE4
	add r0,r6,#0x0	; 02324AE6
	bl loc_02324D10	; 02324AE8
	add r3,r0,#0x0	; 02324AEC
	str r6,[sp,#0x0]	; 02324AEE
	mov r0,#0x0	; 02324AF0
	str r0,[sp,#0x4]	; 02324AF2
	str r0,[sp,#0x8]	; 02324AF4
	mvn r0,r0	; 02324AF6
	str r0,[sp,#0xc]	; 02324AF8
	ldr r0,[r5,#0x24]	; 02324AFA
	add r1,r5,#0x0	; 02324AFC
	add r2,r4,#0x0	; 02324AFE
	lsl r3,r3,#0x10	; 02324B00
	lsr r3,r3,#0x10	; 02324B02
	bl loc_0232456C	; 02324B04
	add sp,#0x10	; 02324B08
	pop {r4,r5,r6}	; 02324B0A
	pop {r3}	; 02324B0C
	bx r3	; 02324B0E

; ===== function loc_02324B10 =====
loc_02324B10:
	push {r4,r5,lr}	; 02324B10
	sub sp,#0x14	; 02324B12
	ldr r4,[pool_02324B30]	; 02324B14
	str r4,[sp,#0x0]	; 02324B16
	mov r5,#0x0	; 02324B18
	str r5,[sp,#0x4]	; 02324B1A
	mov r4,#0x1	; 02324B1C
	str r4,[sp,#0x8]	; 02324B1E
	mvn r4,r5	; 02324B20
	str r4,[sp,#0xc]	; 02324B22
	bl loc_0232456C	; 02324B24
	add sp,#0x14	; 02324B28
	pop {r4,r5}	; 02324B2A
	pop {r3}	; 02324B2C
	bx r3	; 02324B2E
pool_02324B30:
loc_02324B30:
	.word 0x0000FFFF	; 02324B30

; ===== function loc_02324B34 =====
loc_02324B34:
	push {r4,r5,r6,r7,lr}	; 02324B34
	sub sp,#0x14	; 02324B36
	add r5,r0,#0x0	; 02324B38
	add r4,r1,#0x0	; 02324B3A
	add r6,r2,#0x0	; 02324B3C
	add r7,r3,#0x0	; 02324B3E
	add r0,r7,#0x0	; 02324B40
	bl loc_02324D10	; 02324B42
	add r3,r0,#0x0	; 02324B46
	str r7,[sp,#0x0]	; 02324B48
	mov r1,#0x0	; 02324B4A
	str r1,[sp,#0x4]	; 02324B4C
	mov r0,#0x1	; 02324B4E
	str r0,[sp,#0x8]	; 02324B50
	mvn r0,r1	; 02324B52
	str r0,[sp,#0xc]	; 02324B54
	add r0,r5,#0x0	; 02324B56
	add r1,r4,#0x0	; 02324B58
	add r2,r6,#0x0	; 02324B5A
	bl loc_0232456C	; 02324B5C
	add sp,#0x14	; 02324B60
	pop {r4,r5,r6,r7}	; 02324B62
	pop {r3}	; 02324B64
	bx r3	; 02324B66

; ===== function loc_02324B68 =====
loc_02324B68:
	push {r4,r5,lr}	; 02324B68
	sub sp,#0x4	; 02324B6A
	add r5,r0,#0x0	; 02324B6C
	add r4,r1,#0x0	; 02324B6E
	mov r1,#0x0	; 02324B70
	bl loc_02329294	; 02324B72
	ldr r0,[pool_02324BA0]	; 02324B76
	ldrh r0,[r0,#0x0]	; 02324B78
	lsl r0,r0,#0x1d	; 02324B7A
	lsr r0,r0,#0x1d	; 02324B7C
	bl loc_02324D2C	; 02324B7E
	lsl r0,r4,#0x9	; 02324B82
	lsr r0,r0,#0x10	; 02324B84
	strh r0,[r5,#0xc]	; 02324B86
	strh r0,[r5,#0xe]	; 02324B88
	mov r0,#0x0	; 02324B8A
	str r0,[sp,#0x0]	; 02324B8C
	ldr r0,[sp,#0x0]	; 02324B8E
	ldr r1,[r5,#0x14]	; 02324B90
	ldr r2,[pool_02324BA4]	; 02324B92
	blx loc_0232E34C	; 02324B94
	add sp,#0x4	; 02324B98
	pop {r4,r5}	; 02324B9A
	pop {r3}	; 02324B9C
	bx r3	; 02324B9E
pool_02324BA0:
loc_02324BA0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02324BA0
pool_02324BA4:
loc_02324BA4:
	.word 0x00010000	; 02324BA4

; ===== function loc_02324BA8 =====
loc_02324BA8:
	mov r1,#0x0	; 02324BA8
	ldr r0,[pool_02324BB8]	; 02324BAA
	strh r1,[r0,#0x28]	; 02324BAC
	ldr r1,[pool_02324BBC]	; 02324BAE
	str r1,[r0,#0x2c]	; 02324BB0
	ldr r0,[pool_02324BC0]	; 02324BB2
	bx lr	; 02324BB4
	.byte 0xC0, 0x46	; 02324BB8
pool_02324BB8:
loc_02324BB8:
	.word P1_BssStart + 0x3BCC	; 02324BB8
pool_02324BBC:
loc_02324BBC:
	.word 0x02344A7C	; 02324BBC
pool_02324BC0:
loc_02324BC0:
	.word 0x02334A64	; 02324BC0

; ===== function loc_02324BC4 =====
loc_02324BC4:
	mov r1,#0x1	; 02324BC4
	ldr r0,[pool_02324BD0]	; 02324BC6
	strh r1,[r0,#0x10]	; 02324BC8
	ldr r1,[pool_02324BD4]	; 02324BCA
	str r1,[r0,#0x14]	; 02324BCC
	bx lr	; 02324BCE
pool_02324BD0:
loc_02324BD0:
	.word P1_BssStart + 0x3BCC	; 02324BD0
pool_02324BD4:
loc_02324BD4:
	.word 0x02334A7C	; 02324BD4

; ===== function loc_02324BD8 =====
loc_02324BD8:
	ldr r0,[pool_02324BDC]	; 02324BD8
	bx lr	; 02324BDA
pool_02324BDC:
loc_02324BDC:
	.word 0x02354A9C	; 02324BDC
P1_Entry_02324BE0:
	ldr r0,[pool_02324BE4]	; 02324BE0
	bx lr	; 02324BE2
pool_02324BE4:
	.word 0x02354A7C	; 02324BE4

; ===== function loc_02324BE8 =====
loc_02324BE8:
	ldr r0,[pool_02324BEC]	; 02324BE8
	bx lr	; 02324BEA
pool_02324BEC:
loc_02324BEC:
	.word 0x02354A7C	; 02324BEC

; ===== function loc_02324BF0 =====
loc_02324BF0:
	push {r4,r5,r6,lr}	; 02324BF0
	ldr r0,[pool_02324C38]	; 02324BF2
	ldr r1,[pool_02324C3C]	; 02324BF4
	ldr r2,[pool_02324C40]	; 02324BF6
	bl loc_02328C00	; 02324BF8
	ldr r0,[pool_02324C44]	; 02324BFC
	ldr r1,[pool_02324C48]	; 02324BFE
	ldr r2,[pool_02324C4C]	; 02324C00
	bl loc_02328C00	; 02324C02
	ldr r0,[pool_02324C50]	; 02324C06
	ldr r1,[pool_02324C54]	; 02324C08
	ldr r2,[pool_02324C58]	; 02324C0A
	bl loc_02328C00	; 02324C0C
	ldr r0,[pool_02324C5C]	; 02324C10
	ldr r1,[pool_02324C60]	; 02324C12
	ldr r2,[pool_02324C64]	; 02324C14
	bl loc_02328C00	; 02324C16
	mov r5,#0x0	; 02324C1A
	ldr r4,[pool_02324C38]	; 02324C1C
	ldr r6,[pool_02324C68]	; 02324C1E
	b loc_02324C2E	; 02324C20
loc_02324C22:
	lsl r0,r5,#0x5	; 02324C22
	add r0,r4,r0	; 02324C24
	ldrh r1,[r6,#0x0]	; 02324C26
	bl loc_0232878C	; 02324C28
	add r5,r5,#0x1	; 02324C2C
loc_02324C2E:
	cmp r5,#0x4	; 02324C2E
	bcc loc_02324C22	; 02324C30
	pop {r4,r5,r6}	; 02324C32
	pop {r3}	; 02324C34
	bx r3	; 02324C36
pool_02324C38:
loc_02324C38:
	.word 0x02354A7C	; 02324C38
pool_02324C3C:
loc_02324C3C:
	.word 0x023A27EC	; 02324C3C
pool_02324C40:
loc_02324C40:
	.word 0x023A1E64	; 02324C40
pool_02324C44:
loc_02324C44:
	.word 0x02354A9C	; 02324C44
pool_02324C48:
loc_02324C48:
	.word 0x023A4C38	; 02324C48
pool_02324C4C:
loc_02324C4C:
	.word 0x023A2040	; 02324C4C
pool_02324C50:
loc_02324C50:
	.word 0x02354ABC	; 02324C50
pool_02324C54:
loc_02324C54:
	.word 0x023A26DC	; 02324C54
pool_02324C58:
loc_02324C58:
	.word 0x023A1E18	; 02324C58
pool_02324C5C:
loc_02324C5C:
	.word 0x02354ADC	; 02324C5C
pool_02324C60:
loc_02324C60:
	.word 0x023A2148	; 02324C60
pool_02324C64:
loc_02324C64:
	.word 0x023A1DA4	; 02324C64
pool_02324C68:
loc_02324C68:
	.word 0x02330B2C	; 02324C68
loc_02324C6C:
	push {r4,r5,r6,r7,lr}	; 02324C6C
	sub sp,#0x4	; 02324C6E
	lsl r2,r1,#0x3	; 02324C70
	ldr r1,[pool_02324D00]	; 02324C72
	ldr r3,[r1,r2]	; 02324C74
	ldr r1,[pool_02324D04]	; 02324C76
	ldr r2,[r1,r2]	; 02324C78
	ldr r1,[pool_02324D08]	; 02324C7A
	and r0,r1	; 02324C7C
	lsl r0,r0,#0x2	; 02324C7E
	ldr r0,[r2,r0]	; 02324C80
	add r1,r3,r0	; 02324C82
	ldr r0,[pool_02324D0C]	; 02324C84
	mov r3,#0x3	; 02324C86
	mov r4,#0x3f	; 02324C88
	mov r2,#0xf	; 02324C8A
	b loc_02324CEA	; 02324C8C
loc_02324C8E:
	cmp r5,#0x80	; 02324C8E
	bcs loc_02324C98	; 02324C90
	strh r5,[r0,#0x0]	; 02324C92
	add r1,r1,#0x1	; 02324C94
	b loc_02324CE8	; 02324C96
loc_02324C98:
	cmp r5,#0xe0	; 02324C98
	bcc loc_02324CBC	; 02324C9A
	ldrb r6,[r1,#0x1]	; 02324C9C
	and r5,r2	; 02324C9E
	lsl r7,r5,#0x4	; 02324CA0
	asr r5,r6,#0x2	; 02324CA2
	and r5,r2	; 02324CA4
	orr r7,r5	; 02324CA6
	lsl r5,r7,#0x8	; 02324CA8
	and r6,r3	; 02324CAA
	lsl r7,r6,#0x6	; 02324CAC
	ldrb r6,[r1,#0x2]	; 02324CAE
	and r6,r4	; 02324CB0
	orr r7,r6	; 02324CB2
	orr r5,r7	; 02324CB4
	strh r5,[r0,#0x0]	; 02324CB6
	add r1,r1,#0x3	; 02324CB8
	b loc_02324CE8	; 02324CBA
loc_02324CBC:
	add r7,r5,#0x0	; 02324CBC
	mov r6,#0xe0	; 02324CBE
	and r7,r6	; 02324CC0
	cmp r7,#0xc0	; 02324CC2
	bne loc_02324CE8	; 02324CC4
	add r7,r5,#0x0	; 02324CC6
	mov r6,#0x1c	; 02324CC8
	and r7,r6	; 02324CCA
	asr r6,r7,#0x2	; 02324CCC
	lsl r6,r6,#0x10	; 02324CCE
	lsr r6,r6,#0x8	; 02324CD0
	and r5,r3	; 02324CD2
	lsl r5,r5,#0x16	; 02324CD4
	lsr r5,r5,#0x10	; 02324CD6
	ldrb r7,[r1,#0x1]	; 02324CD8
	and r7,r4	; 02324CDA
	lsl r7,r7,#0x10	; 02324CDC
	lsr r7,r7,#0x10	; 02324CDE
	orr r5,r7	; 02324CE0
	orr r6,r5	; 02324CE2
	strh r6,[r0,#0x0]	; 02324CE4
	add r1,r1,#0x2	; 02324CE6
loc_02324CE8:
	add r0,r0,#0x2	; 02324CE8
loc_02324CEA:
	ldrb r5,[r1,#0x0]	; 02324CEA
	cmp r5,#0x0	; 02324CEC
	bne loc_02324C8E	; 02324CEE
	mov r1,#0x0	; 02324CF0
	strh r1,[r0,#0x0]	; 02324CF2
	ldr r0,[pool_02324D0C]	; 02324CF4
	add sp,#0x4	; 02324CF6
	pop {r4,r5,r6,r7}	; 02324CF8
	pop {r3}	; 02324CFA
	bx r3	; 02324CFC
	.byte 0xC0, 0x46	; 02324D00
pool_02324D00:
loc_02324D00:
	.word P1_BssStart + 0x23C84	; 02324D00
pool_02324D04:
loc_02324D04:
	.word P1_BssStart + 0x23C80	; 02324D04
pool_02324D08:
loc_02324D08:
	.word 0x0000FFFF	; 02324D08
pool_02324D0C:
loc_02324D0C:
	.word 0x02354B30	; 02324D0C

; ===== function loc_02324D10 =====
loc_02324D10:
	lsl r1,r0,#0x1	; 02324D10
	ldr r0,[pool_02324D18]	; 02324D12
	ldrh r0,[r0,r1]	; 02324D14
	bx lr	; 02324D16
pool_02324D18:
loc_02324D18:
	.word P1_Data_02330B48	; 02324D18

; ===== function loc_02324D1C =====
loc_02324D1C:
	ldr r1,[pool_02324D24]	; 02324D1C
	ldr r1,[r1,#0x0]	; 02324D1E
	ldr r3,[pool_02324D28]	; 02324D20
	bx r3	; 02324D22
pool_02324D24:
loc_02324D24:
	.word P1_BssStart + 0x23C7C	; 02324D24
pool_02324D28:
loc_02324D28:
	.word loc_02324C6C + 1	; 02324D28

; ===== function loc_02324D2C =====
loc_02324D2C:
	ldr r1,[pool_02324D34]	; 02324D2C
	str r0,[r1,#0x0]	; 02324D2E
	bx lr	; 02324D30
	.byte 0xC0, 0x46	; 02324D34
pool_02324D34:
loc_02324D34:
	.word P1_BssStart + 0x23C7C	; 02324D34

; ===== function loc_02324D38 =====
loc_02324D38:
	push {r4,r5,r6,lr}	; 02324D38
	sub sp,#0x18	; 02324D3A
	ldr r4,[pool_02324D78]	; 02324D3C
	add r3,sp,#0x0	; 02324D3E
	mov r2,#0x3	; 02324D40
loc_02324D42:
	ldmia r4!,{r0,r1}	; 02324D42
	stmia r3!,{r0,r1}	; 02324D44
	sub r2,r2,#0x1	; 02324D46
	cmp r2,#0x0	; 02324D48
	bne loc_02324D42	; 02324D4A
	mov r5,#0x0	; 02324D4C
	add r4,sp,#0x0	; 02324D4E
	ldr r6,[pool_02324D7C]	; 02324D50
loc_02324D52:
	lsl r0,r5,#0x2	; 02324D52
	ldr r0,[r4,r0]	; 02324D54
	lsl r1,r5,#0x3	; 02324D56
	add r1,r6,r1	; 02324D58
	bl loc_02324D88	; 02324D5A
	add r5,r5,#0x1	; 02324D5E
	cmp r5,#0x6	; 02324D60
	blt loc_02324D52	; 02324D62
	ldr r0,[pool_02324D80]	; 02324D64
	ldrh r0,[r0,#0x0]	; 02324D66
	lsl r0,r0,#0x1d	; 02324D68
	lsr r1,r0,#0x1d	; 02324D6A
	ldr r0,[pool_02324D84]	; 02324D6C
	str r1,[r0,#0x0]	; 02324D6E
	add sp,#0x18	; 02324D70
	pop {r4,r5,r6}	; 02324D72
	pop {r3}	; 02324D74
	bx r3	; 02324D76
pool_02324D78:
loc_02324D78:
	.word 0x02330B30	; 02324D78
pool_02324D7C:
loc_02324D7C:
	.word 0x02354B00	; 02324D7C
pool_02324D80:
loc_02324D80:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02324D80
pool_02324D84:
loc_02324D84:
	.word P1_BssStart + 0x23C7C	; 02324D84

; ===== function loc_02324D88 =====
loc_02324D88:
	push {r4,r5,r6,lr}	; 02324D88
	ldr r2,[r0,#0xc]	; 02324D8A
	add r0,#0x20	; 02324D8C
	mov r3,#0x0	; 02324D8E
	str r3,[r1,#0x0]	; 02324D90
	str r3,[r1,#0x4]	; 02324D92
	ldr r5,[pool_02324DC4]	; 02324D94
	ldr r4,[pool_02324DC8]	; 02324D96
	b loc_02324DBA	; 02324D98
loc_02324D9A:
	ldr r6,[r0,#0x0]	; 02324D9A
	cmp r6,r5	; 02324D9C
	beq loc_02324DA6	; 02324D9E
	cmp r6,r4	; 02324DA0
	beq loc_02324DAE	; 02324DA2
	b loc_02324DB4	; 02324DA4
loc_02324DA6:
	add r6,r0,#0x0	; 02324DA6
	add r6,#0x10	; 02324DA8
	str r6,[r1,#0x0]	; 02324DAA
	b loc_02324DB4	; 02324DAC
loc_02324DAE:
	add r6,r0,#0x0	; 02324DAE
	add r6,#0x8	; 02324DB0
	str r6,[r1,#0x4]	; 02324DB2
loc_02324DB4:
	ldr r6,[r0,#0x4]	; 02324DB4
	add r0,r0,r6	; 02324DB6
	add r3,r3,#0x1	; 02324DB8
loc_02324DBA:
	cmp r3,r2	; 02324DBA
	blt loc_02324D9A	; 02324DBC
	pop {r4,r5,r6}	; 02324DBE
	pop {r3}	; 02324DC0
	bx r3	; 02324DC2
pool_02324DC4:
loc_02324DC4:
	.word 0x31464E49	; 02324DC4
pool_02324DC8:
loc_02324DC8:
	.word 0x31544144	; 02324DC8
	.byte 0x01, 0x48, 0xC0, 0x69, 0x70, 0x47, 0xC0, 0x46, 0x30, 0x4F, 0x35, 0x02	; 02324DCC
P1_Entry_02324DD8:
	push {lr}	; 02324DD8
	sub sp,#0x4	; 02324DDA
	ldr r0,[pool_02324DF8]	; 02324DDC
	ldr r1,[pool_02324DFC]	; 02324DDE
	mov r2,#0x35	; 02324DE0
	bl loc_02324ADC	; 02324DE2
	ldr r0,[pool_02324E00]	; 02324DE6
	ldr r1,[pool_02324DFC]	; 02324DE8
	mov r2,#0x36	; 02324DEA
	bl loc_02324ADC	; 02324DEC
	add sp,#0x4	; 02324DF0
	pop {r3}	; 02324DF2
	bx r3	; 02324DF4
	.byte 0xC0, 0x46	; 02324DF6
pool_02324DF8:
	.word 0x02354F90	; 02324DF8
pool_02324DFC:
	.word 0x023A02A4	; 02324DFC
pool_02324E00:
	.word 0x02354FBC	; 02324E00
P1_Entry_02324E04:
	push {r4,r5,r6,lr}	; 02324E04
	mov r4,#0x0	; 02324E06
	mvn r5,r4	; 02324E08
	ldr r0,[pool_02324EA0]	; 02324E0A
	ldr r0,[r0,#0x18]	; 02324E0C
	cmp r0,#0x2	; 02324E0E
	bne P1_Entry_02324E98	; 02324E10
	add r6,r4,#0x0	; 02324E12
	ldr r0,[pool_02324EA4]	; 02324E14
	ldr r1,[pool_02324EA8]	; 02324E16
	bl loc_023242AC	; 02324E18
	ldr r0,[pool_02324EA4]	; 02324E1C
	mov r1,#0x1	; 02324E1E
	bl loc_02324298	; 02324E20
	cmp r0,#0x0	; 02324E24
	beq P1_Entry_02324E30	; 02324E26
	mov r4,#0x1	; 02324E28
	ldr r0,[pool_02324EA0]	; 02324E2A
	str r4,[r0,#0x20]	; 02324E2C
	b P1_Entry_02324E44	; 02324E2E
P1_Entry_02324E30:
	ldr r0,[pool_02324EA4]	; 02324E30
	lsl r1,r4,#0	; 02324E32
	bl loc_02324298	; 02324E34
	cmp r0,#0x0	; 02324E38
	beq P1_Entry_02324E44	; 02324E3A
	lsl r1,r4,#0	; 02324E3C
	ldr r0,[pool_02324EA0]	; 02324E3E
	str r1,[r0,#0x20]	; 02324E40
	mov r6,#0x1	; 02324E42
P1_Entry_02324E44:
	mov r0,#0x20	; 02324E44
	bl loc_02324088	; 02324E46
	cmp r0,#0x0	; 02324E4A
	beq P1_Entry_02324E5C	; 02324E4C
	mov r1,#0x0	; 02324E4E
	ldr r0,[pool_02324EA0]	; 02324E50
	str r1,[r0,#0x20]	; 02324E52
	mov r0,#0x1d	; 02324E54
	bl loc_0232365C	; 02324E56
	b P1_Entry_02324E98	; 02324E5A
P1_Entry_02324E5C:
	mov r0,#0x10	; 02324E5C
	bl loc_02324088	; 02324E5E
	cmp r0,#0x0	; 02324E62
	beq P1_Entry_02324E74	; 02324E64
	mov r1,#0x1	; 02324E66
	ldr r0,[pool_02324EA0]	; 02324E68
	str r1,[r0,#0x20]	; 02324E6A
	mov r0,#0x1d	; 02324E6C
	bl loc_0232365C	; 02324E6E
	b P1_Entry_02324E98	; 02324E72
P1_Entry_02324E74:
	mov r0,#0x1	; 02324E74
	bl loc_02324088	; 02324E76
	cmp r0,#0x0	; 02324E7A
	bne P1_Entry_02324E82	; 02324E7C
	cmp r4,#0x0	; 02324E7E
	beq P1_Entry_02324E88	; 02324E80
P1_Entry_02324E82:
	ldr r0,[pool_02324EA0]	; 02324E82
	ldr r5,[r0,#0x20]	; 02324E84
	b P1_Entry_02324E98	; 02324E86
P1_Entry_02324E88:
	mov r0,#0x2	; 02324E88
	bl loc_02324088	; 02324E8A
	cmp r0,#0x0	; 02324E8E
	bne P1_Entry_02324E96	; 02324E90
	cmp r6,#0x0	; 02324E92
	beq P1_Entry_02324E98	; 02324E94
P1_Entry_02324E96:
	mov r5,#0x0	; 02324E96
P1_Entry_02324E98:
	add r0,r5,#0x0	; 02324E98
	pop {r4,r5,r6}	; 02324E9A
	pop {r3}	; 02324E9C
	bx r3	; 02324E9E
pool_02324EA0:
	.word P1_BssStart + 0x240B0	; 02324EA0
pool_02324EA4:
	.word 0x02354F58	; 02324EA4
pool_02324EA8:
	.word 0x0239F23C	; 02324EA8

; ===== function loc_02324EAC =====
loc_02324EAC:
	push {lr}	; 02324EAC
	sub sp,#0x4	; 02324EAE
	bl loc_023251FC	; 02324EB0
	ldr r0,[pool_02324F8C]	; 02324EB4
	ldr r1,[r0,#0x14]	; 02324EB6
	cmp r1,#0x0	; 02324EB8
	blt loc_02324F84	; 02324EBA
	ldr r1,[r0,#0x1c]	; 02324EBC
	cmp r1,#0x0	; 02324EBE
	beq loc_02324ECC	; 02324EC0
	cmp r1,#0x1	; 02324EC2
	beq loc_02324EFE	; 02324EC4
	cmp r1,#0x2	; 02324EC6
	beq loc_02324F5C	; 02324EC8
	b loc_02324F84	; 02324ECA
loc_02324ECC:
	ldr r1,[r0,#0x10]	; 02324ECC
	add r2,r1,#0x1	; 02324ECE
	str r2,[r0,#0x10]	; 02324ED0
	cmp r2,#0xf	; 02324ED2
	bgt loc_02324EE8	; 02324ED4
	mov r1,#0xf	; 02324ED6
	sub r0,r1,r2	; 02324ED8
	mov r2,#0x78	; 02324EDA
	mul r0,r2	; 02324EDC
	blx P1_SignedDivMod	; 02324EDE
	ldr r1,[pool_02324F8C]	; 02324EE2
	str r0,[r1,#0x0]	; 02324EE4
	b loc_02324F84	; 02324EE6
loc_02324EE8:
	ldr r0,[r0,#0x18]	; 02324EE8
	cmp r0,#0x1	; 02324EEA
	bne loc_02324EF2	; 02324EEC
	bl loc_02325230	; 02324EEE
loc_02324EF2:
	mov r1,#0x0	; 02324EF2
	ldr r0,[pool_02324F8C]	; 02324EF4
	str r1,[r0,#0x10]	; 02324EF6
	mov r1,#0x1	; 02324EF8
	str r1,[r0,#0x1c]	; 02324EFA
	b loc_02324F84	; 02324EFC
loc_02324EFE:
	ldr r1,[r0,#0x18]	; 02324EFE
	cmp r1,#0x0	; 02324F00
	bne loc_02324F18	; 02324F02
	ldr r1,[r0,#0x10]	; 02324F04
	add r1,r1,#0x1	; 02324F06
	str r1,[r0,#0x10]	; 02324F08
	cmp r1,#0x78	; 02324F0A
	ble loc_02324F84	; 02324F0C
	mov r1,#0x0	; 02324F0E
	str r1,[r0,#0x10]	; 02324F10
	mov r1,#0x2	; 02324F12
	str r1,[r0,#0x1c]	; 02324F14
	b loc_02324F84	; 02324F16
loc_02324F18:
	cmp r1,#0x1	; 02324F18
	bne loc_02324F3E	; 02324F1A
	ldr r1,[r0,#0x10]	; 02324F1C
	add r1,r1,#0x1	; 02324F1E
	str r1,[r0,#0x10]	; 02324F20
	ldr r0,[r0,#0x24]	; 02324F22
	cmp r0,#0x0	; 02324F24
	beq loc_02324F84	; 02324F26
	bl loc_02325224	; 02324F28
	ldr r0,[pool_02324F8C]	; 02324F2C
	ldr r1,[r0,#0x10]	; 02324F2E
	cmp r1,#0x1e	; 02324F30
	ble loc_02324F84	; 02324F32
	mov r1,#0x0	; 02324F34
	str r1,[r0,#0x10]	; 02324F36
	mov r1,#0x2	; 02324F38
	str r1,[r0,#0x1c]	; 02324F3A
	b loc_02324F84	; 02324F3C
loc_02324F3E:
	cmp r1,#0x2	; 02324F3E
	bne loc_02324F84	; 02324F40
	ldr r1,[r0,#0x10]	; 02324F42
	add r1,r1,#0x1	; 02324F44
	str r1,[r0,#0x10]	; 02324F46
	cmp r1,#0x1e	; 02324F48
	ble loc_02324F84	; 02324F4A
	ldr r1,[r0,#0x24]	; 02324F4C
	cmp r1,#0x0	; 02324F4E
	beq loc_02324F84	; 02324F50
	mov r1,#0x0	; 02324F52
	str r1,[r0,#0x10]	; 02324F54
	mov r1,#0x2	; 02324F56
	str r1,[r0,#0x1c]	; 02324F58
	b loc_02324F84	; 02324F5A
loc_02324F5C:
	ldr r1,[r0,#0x10]	; 02324F5C
	add r2,r1,#0x1	; 02324F5E
	str r2,[r0,#0x10]	; 02324F60
	cmp r2,#0xf	; 02324F62
	bgt loc_02324F7C	; 02324F64
	mov r1,#0xf	; 02324F66
	sub r0,r1,r2	; 02324F68
	mov r2,#0x78	; 02324F6A
	mul r0,r2	; 02324F6C
	blx P1_SignedDivMod	; 02324F6E
	mov r1,#0x78	; 02324F72
	sub r1,r1,r0	; 02324F74
	ldr r0,[pool_02324F8C]	; 02324F76
	str r1,[r0,#0x0]	; 02324F78
	b loc_02324F84	; 02324F7A
loc_02324F7C:
	bl loc_02325230	; 02324F7C
	bl loc_02325180	; 02324F80
loc_02324F84:
	add sp,#0x4	; 02324F84
	pop {r3}	; 02324F86
	bx r3	; 02324F88
	.byte 0xC0, 0x46	; 02324F8C
pool_02324F8C:
loc_02324F8C:
	.word P1_BssStart + 0x240B0	; 02324F8C

; ===== function loc_02324F90 =====
loc_02324F90:
	ldr r0,[pool_02324FA0]	; 02324F90
	ldr r2,[r0,#0x14]	; 02324F92
	mov r0,#0x0	; 02324F94
	mvn r1,r0	; 02324F96
	cmp r2,r1	; 02324F98
	beq loc_02324F9E	; 02324F9A
	mov r0,#0x1	; 02324F9C
loc_02324F9E:
	bx lr	; 02324F9E
pool_02324FA0:
loc_02324FA0:
	.word P1_BssStart + 0x240B0	; 02324FA0

; ===== function loc_02324FA4 =====
loc_02324FA4:
	ldr r0,[pool_02324FAC]	; 02324FA4
	ldr r0,[r0,#0x24]	; 02324FA6
	bx lr	; 02324FA8
	.byte 0xC0, 0x46	; 02324FAC
pool_02324FAC:
loc_02324FAC:
	.word P1_BssStart + 0x240B0	; 02324FAC

; ===== function loc_02324FB0 =====
loc_02324FB0:
	mov r1,#0x1	; 02324FB0
	ldr r0,[pool_02324FB8]	; 02324FB2
	str r1,[r0,#0x24]	; 02324FB4
	bx lr	; 02324FB6
pool_02324FB8:
loc_02324FB8:
	.word P1_BssStart + 0x240B0	; 02324FB8

; ===== function loc_02324FBC =====
loc_02324FBC:
	push {r4,lr}	; 02324FBC
	add r4,r2,#0x0	; 02324FBE
	bl loc_02325000	; 02324FC0
	ldr r0,[pool_02324FD4]	; 02324FC4
	add r1,r4,#0x0	; 02324FC6
	bl loc_02324A80	; 02324FC8
	pop {r4}	; 02324FCC
	pop {r3}	; 02324FCE
	bx r3	; 02324FD0
	.byte 0xC0, 0x46	; 02324FD4
pool_02324FD4:
loc_02324FD4:
	.word 0x02354F64	; 02324FD4

; ===== function loc_02324FD8 =====
loc_02324FD8:
	push {lr}	; 02324FD8
	sub sp,#0x4	; 02324FDA
	bl loc_02325000	; 02324FDC
	ldr r0,[pool_02324FF4]	; 02324FE0
	ldr r1,[pool_02324FF8]	; 02324FE2
	ldr r2,[pool_02324FFC]	; 02324FE4
	ldr r2,[r2,#0x14]	; 02324FE6
	bl loc_02324ADC	; 02324FE8
	add sp,#0x4	; 02324FEC
	pop {r3}	; 02324FEE
	bx r3	; 02324FF0
	.byte 0xC0, 0x46	; 02324FF4
pool_02324FF4:
loc_02324FF4:
	.word 0x02354F64	; 02324FF4
pool_02324FF8:
loc_02324FF8:
	.word 0x023A02A4	; 02324FF8
pool_02324FFC:
loc_02324FFC:
	.word P1_BssStart + 0x240B0	; 02324FFC

; ===== function loc_02325000 =====
loc_02325000:
	push {r4,r5,lr}	; 02325000
	sub sp,#0x4	; 02325002
	add r5,r0,#0x0	; 02325004
	add r4,r1,#0x0	; 02325006
	bl loc_02325224	; 02325008
	bl loc_02325180	; 0232500C
	ldr r1,[pool_0232502C]	; 02325010
	str r5,[r1,#0x14]	; 02325012
	str r4,[r1,#0x18]	; 02325014
	cmp r4,#0x2	; 02325016
	bne loc_02325024	; 02325018
	mov r0,#0xd	; 0232501A
	mvn r0,r0	; 0232501C
	str r0,[r1,#0x4]	; 0232501E
	mov r0,#0x8	; 02325020
	str r0,[r1,#0x8]	; 02325022
loc_02325024:
	add sp,#0x4	; 02325024
	pop {r4,r5}	; 02325026
	pop {r3}	; 02325028
	bx r3	; 0232502A
pool_0232502C:
loc_0232502C:
	.word P1_BssStart + 0x240B0	; 0232502C

; ===== function loc_02325030 =====
loc_02325030:
	push {r4,lr}	; 02325030
	sub sp,#0x10	; 02325032
	ldr r0,[pool_02325114]	; 02325034
	ldr r1,[r0,#0x14]	; 02325036
	cmp r1,#0x0	; 02325038
	blt loc_0232510C	; 0232503A
	ldr r0,[r0,#0x18]	; 0232503C
	cmp r0,#0x2	; 0232503E
	bne loc_023250C2	; 02325040
	bl loc_02323DB8	; 02325042
	ldr r1,[pool_02325114]	; 02325046
	ldr r2,[r1,#0xc]	; 02325048
	str r2,[sp,#0x0]	; 0232504A
	ldr r1,[r1,#0x0]	; 0232504C
	str r1,[sp,#0x4]	; 0232504E
	ldr r1,[pool_02325118]	; 02325050
	ldr r2,[pool_0232511C]	; 02325052
	mov r3,#0x4	; 02325054
	bl loc_02323B78	; 02325056
	mov r1,#0x0	; 0232505A
	str r1,[sp,#0x0]	; 0232505C
	ldr r0,[pool_02325120]	; 0232505E
	ldr r2,[pool_02325114]	; 02325060
	ldr r2,[r2,#0x0]	; 02325062
	add r3,r1,#0x0	; 02325064
	bl loc_023236B8	; 02325066
	mov r1,#0x0	; 0232506A
	str r1,[sp,#0x0]	; 0232506C
	ldr r0,[pool_02325124]	; 0232506E
	ldr r2,[pool_02325114]	; 02325070
	ldr r2,[r2,#0x0]	; 02325072
	add r3,r1,#0x0	; 02325074
	bl loc_023236B8	; 02325076
	ldr r0,[pool_02325128]	; 0232507A
	mov r1,#0x1	; 0232507C
	bl loc_023241CC	; 0232507E
	add r4,r0,#0x0	; 02325082
	bl loc_02323DB8	; 02325084
	mov r1,#0x0	; 02325088
	str r1,[sp,#0x0]	; 0232508A
	ldr r1,[pool_02325114]	; 0232508C
	ldr r1,[r1,#0x0]	; 0232508E
	str r1,[sp,#0x4]	; 02325090
	str r4,[sp,#0x8]	; 02325092
	ldr r1,[pool_02325118]	; 02325094
	ldr r2,[pool_0232511C]	; 02325096
	mov r3,#0x2	; 02325098
	bl loc_02323B24	; 0232509A
	ldr r0,[pool_02325128]	; 0232509E
	mov r1,#0x0	; 023250A0
	bl loc_023241CC	; 023250A2
	add r4,r0,#0x0	; 023250A6
	bl loc_02323DB8	; 023250A8
	mov r1,#0x0	; 023250AC
	str r1,[sp,#0x0]	; 023250AE
	ldr r1,[pool_02325114]	; 023250B0
	ldr r1,[r1,#0x0]	; 023250B2
	str r1,[sp,#0x4]	; 023250B4
	str r4,[sp,#0x8]	; 023250B6
	ldr r1,[pool_02325118]	; 023250B8
	ldr r2,[pool_0232511C]	; 023250BA
	mov r3,#0x3	; 023250BC
	bl loc_02323B24	; 023250BE
loc_023250C2:
	mov r1,#0x0	; 023250C2
	str r1,[sp,#0x0]	; 023250C4
	ldr r0,[pool_0232512C]	; 023250C6
	ldr r2,[pool_02325114]	; 023250C8
	ldr r3,[r2,#0x0]	; 023250CA
	ldr r2,[r2,#0x4]	; 023250CC
	add r2,r3,r2	; 023250CE
	add r3,r1,#0x0	; 023250D0
	bl loc_023236B8	; 023250D2
	bl loc_02323DB8	; 023250D6
	mov r1,#0x0	; 023250DA
	str r1,[sp,#0x0]	; 023250DC
	ldr r1,[pool_02325114]	; 023250DE
	ldr r2,[r1,#0x0]	; 023250E0
	ldr r1,[r1,#0x8]	; 023250E2
	add r1,r2,r1	; 023250E4
	str r1,[sp,#0x4]	; 023250E6
	ldr r1,[pool_02325118]	; 023250E8
	ldr r2,[pool_0232511C]	; 023250EA
	mov r3,#0x1	; 023250EC
	bl loc_02323B78	; 023250EE
	bl loc_02323DB8	; 023250F2
	mov r3,#0x0	; 023250F6
	str r3,[sp,#0x0]	; 023250F8
	ldr r1,[pool_02325114]	; 023250FA
	ldr r2,[r1,#0x0]	; 023250FC
	ldr r1,[r1,#0x4]	; 023250FE
	add r1,r2,r1	; 02325100
	str r1,[sp,#0x4]	; 02325102
	ldr r1,[pool_02325118]	; 02325104
	ldr r2,[pool_0232511C]	; 02325106
	bl loc_02323B78	; 02325108
loc_0232510C:
	add sp,#0x10	; 0232510C
	pop {r4}	; 0232510E
	pop {r3}	; 02325110
	bx r3	; 02325112
pool_02325114:
loc_02325114:
	.word P1_BssStart + 0x240B0	; 02325114
pool_02325118:
loc_02325118:
	.word 0x023BB898	; 02325118
pool_0232511C:
loc_0232511C:
	.word 0x0239F77C	; 0232511C
pool_02325120:
loc_02325120:
	.word 0x02354F90	; 02325120
pool_02325124:
loc_02325124:
	.word 0x02354FBC	; 02325124
pool_02325128:
loc_02325128:
	.word 0x02354F58	; 02325128
pool_0232512C:
loc_0232512C:
	.word 0x02354F64	; 0232512C

; ===== function loc_02325130 =====
loc_02325130:
	push {r4,lr}	; 02325130
	add r4,r0,#0x0	; 02325132
	ldr r1,[pool_02325170]	; 02325134
	ldr r2,[pool_02325174]	; 02325136
	mov r3,#0x5d	; 02325138
	bl loc_02324B34	; 0232513A
	add r0,r4,#0x0	; 0232513E
	ldr r1,[pool_02325178]	; 02325140
	ldr r2,[pool_02325174]	; 02325142
	mov r3,#0x1	; 02325144
	bl loc_02324B10	; 02325146
	add r0,r4,#0x0	; 0232514A
	ldr r1,[pool_0232517C]	; 0232514C
	ldr r2,[pool_02325174]	; 0232514E
	mov r3,#0x2	; 02325150
	bl loc_02324B10	; 02325152
	ldr r0,[pool_02325178]	; 02325156
	ldr r1,[pool_02325174]	; 02325158
	mov r2,#0x35	; 0232515A
	bl loc_02324ADC	; 0232515C
	ldr r0,[pool_0232517C]	; 02325160
	ldr r1,[pool_02325174]	; 02325162
	mov r2,#0x36	; 02325164
	bl loc_02324ADC	; 02325166
	pop {r4}	; 0232516A
	pop {r3}	; 0232516C
	bx r3	; 0232516E
pool_02325170:
loc_02325170:
	.word 0x02354F64	; 02325170
pool_02325174:
loc_02325174:
	.word 0x023A02A4	; 02325174
pool_02325178:
loc_02325178:
	.word 0x02354F90	; 02325178
pool_0232517C:
loc_0232517C:
	.word 0x02354FBC	; 0232517C

; ===== function loc_02325180 =====
loc_02325180:
	mov r1,#0x78	; 02325180
	ldr r0,[pool_023251A4]	; 02325182
	str r1,[r0,#0x0]	; 02325184
	mov r1,#0x0	; 02325186
	mvn r2,r1	; 02325188
	str r2,[r0,#0x14]	; 0232518A
	str r1,[r0,#0x4]	; 0232518C
	str r1,[r0,#0x8]	; 0232518E
	str r1,[r0,#0xc]	; 02325190
	str r1,[r0,#0x10]	; 02325192
	str r1,[r0,#0x18]	; 02325194
	str r1,[r0,#0x1c]	; 02325196
	str r1,[r0,#0x20]	; 02325198
	str r1,[r0,#0x24]	; 0232519A
	ldr r0,[pool_023251A8]	; 0232519C
	ldr r3,[pool_023251AC]	; 0232519E
	bx r3	; 023251A0
	.byte 0xC0, 0x46	; 023251A4
pool_023251A4:
loc_023251A4:
	.word P1_BssStart + 0x240B0	; 023251A4
pool_023251A8:
loc_023251A8:
	.word 0x02354F58	; 023251A8
pool_023251AC:
loc_023251AC:
	.word loc_02324358 + 1	; 023251AC

; ===== function loc_023251B0 =====
loc_023251B0:
	push {lr}	; 023251B0
	sub sp,#0x4	; 023251B2
	ldr r1,[pool_023251EC]	; 023251B4
	ldrh r2,[r1,#0x0]	; 023251B6
	mov r0,#0x43	; 023251B8
	and r2,r0	; 023251BA
	ldr r0,[pool_023251F0]	; 023251BC
	orr r2,r0	; 023251BE
	strh r2,[r1,#0x0]	; 023251C0
	bl loc_023244D8	; 023251C2
	add r1,r0,#0x0	; 023251C6
	ldr r0,[pool_023251F4]	; 023251C8
	str r0,[sp,#0x0]	; 023251CA
	ldr r0,[sp,#0x0]	; 023251CC
	ldr r2,[pool_023251F8]	; 023251CE
	blx loc_0232E34C	; 023251D0
	bl loc_023244D8	; 023251D4
	ldr r1,[pool_023251F8]	; 023251D8
	blx P1_CleanDataCacheRange	; 023251DA
	mov r0,#0x8	; 023251DE
	bl loc_023244E0	; 023251E0
	add sp,#0x4	; 023251E4
	pop {r3}	; 023251E6
	bx r3	; 023251E8
	.byte 0xC0, 0x46	; 023251EC
pool_023251EC:
loc_023251EC:
	.word REG_BG3CNT_SUB	; 023251EC
pool_023251F0:
loc_023251F0:
	.word 0x00000810	; 023251F0
pool_023251F4:
loc_023251F4:
	.word 0x005F005F	; 023251F4
pool_023251F8:
loc_023251F8:
	.word 0x00000600	; 023251F8

; ===== function loc_023251FC =====
loc_023251FC:
	ldr r0,[pool_0232521C]	; 023251FC
	ldr r1,[r0,#0x20]	; 023251FE
	lsl r2,r1,#0x1	; 02325200
	ldr r1,[pool_02325220]	; 02325202
	ldrh r2,[r1,r2]	; 02325204
	ldr r1,[r0,#0xc]	; 02325206
	cmp r1,r2	; 02325208
	bge loc_02325212	; 0232520A
	add r1,#0x10	; 0232520C
	str r1,[r0,#0xc]	; 0232520E
	bx lr	; 02325210
loc_02325212:
	cmp r1,r2	; 02325212
	ble loc_0232521A	; 02325214
	sub r1,#0x10	; 02325216
	str r1,[r0,#0xc]	; 02325218
loc_0232521A:
	bx lr	; 0232521A
pool_0232521C:
loc_0232521C:
	.word P1_BssStart + 0x240B0	; 0232521C
pool_02325220:
loc_02325220:
	.word P1_Data_02330800	; 02325220

; ===== function loc_02325224 =====
loc_02325224:
	mov r1,#0x0	; 02325224
	ldr r0,[pool_0232522C]	; 02325226
	str r1,[r0,#0x8]	; 02325228
	bx lr	; 0232522A
pool_0232522C:
loc_0232522C:
	.word P1_BssStart + 0x24168	; 0232522C

; ===== function loc_02325230 =====
loc_02325230:
	mov r1,#0x1	; 02325230
	ldr r0,[pool_02325238]	; 02325232
	str r1,[r0,#0x8]	; 02325234
	bx lr	; 02325236
pool_02325238:
loc_02325238:
	.word P1_BssStart + 0x24168	; 02325238

; ===== function loc_0232523C =====
loc_0232523C:
	ldr r1,[pool_02325254]	; 0232523C
	ldr r2,[r1,#0x0]	; 0232523E
	mov r0,#0x1	; 02325240
	and r2,r0	; 02325242
	cmp r2,#0x0	; 02325244
	bne loc_0232524E	; 02325246
	ldr r1,[r1,#0x4]	; 02325248
	cmp r1,#0x18	; 0232524A
	beq loc_02325250	; 0232524C
loc_0232524E:
	mov r0,#0x0	; 0232524E
loc_02325250:
	bx lr	; 02325250
	.byte 0xC0, 0x46	; 02325254
pool_02325254:
loc_02325254:
	.word P1_BssStart + 0x24168	; 02325254
P1_Entry_02325258:
	ldr r1,[pool_02325274]	; 02325258
	ldr r2,[r1,#0x0]	; 0232525A
	ldr r0,[pool_02325278]	; 0232525C
	ldr r0,[r0,#0x4]	; 0232525E
	add r3,r2,#0x0	; 02325260
	and r3,r0	; 02325262
	cmp r3,#0x0	; 02325264
	beq P1_Entry_02325272	; 02325266
	mov r0,#0x4	; 02325268
	bic r2,r0	; 0232526A
	str r2,[r1,#0x0]	; 0232526C
	mov r0,#0x1	; 0232526E
	str r0,[r1,#0x68]	; 02325270
P1_Entry_02325272:
	bx lr	; 02325272
pool_02325274:
	.word P1_BssStart + 0x24168	; 02325274
pool_02325278:
	.word P1_Data_02330804	; 02325278
P1_Entry_0232527C:
	ldr r1,[pool_02325298]	; 0232527C
	ldr r2,[r1,#0x0]	; 0232527E
	ldr r0,[pool_0232529C]	; 02325280
	ldr r0,[r0,#0x4]	; 02325282
	add r3,r2,#0x0	; 02325284
	and r3,r0	; 02325286
	cmp r3,#0x0	; 02325288
	bne P1_Entry_02325296	; 0232528A
	mov r0,#0x4	; 0232528C
	orr r2,r0	; 0232528E
	str r2,[r1,#0x0]	; 02325290
	mov r0,#0x1	; 02325292
	str r0,[r1,#0x68]	; 02325294
P1_Entry_02325296:
	bx lr	; 02325296
pool_02325298:
	.word P1_BssStart + 0x24168	; 02325298
pool_0232529C:
	.word P1_Data_02330804	; 0232529C
P1_Entry_023252A0:
	ldr r1,[pool_023252BC]	; 023252A0
	ldr r2,[r1,#0x0]	; 023252A2
	ldr r0,[pool_023252C0]	; 023252A4
	ldr r0,[r0,#0x0]	; 023252A6
	add r3,r2,#0x0	; 023252A8
	and r3,r0	; 023252AA
	cmp r3,#0x0	; 023252AC
	beq P1_Entry_023252BA	; 023252AE
	mov r0,#0x2	; 023252B0
	bic r2,r0	; 023252B2
	str r2,[r1,#0x0]	; 023252B4
	mov r0,#0x1	; 023252B6
	str r0,[r1,#0x28]	; 023252B8
P1_Entry_023252BA:
	bx lr	; 023252BA
pool_023252BC:
	.word P1_BssStart + 0x24168	; 023252BC
pool_023252C0:
	.word P1_Data_02330804	; 023252C0
P1_Entry_023252C4:
	ldr r1,[pool_023252E0]	; 023252C4
	ldr r2,[r1,#0x0]	; 023252C6
	ldr r0,[pool_023252E4]	; 023252C8
	ldr r0,[r0,#0x0]	; 023252CA
	add r3,r2,#0x0	; 023252CC
	and r3,r0	; 023252CE
	cmp r3,#0x0	; 023252D0
	bne P1_Entry_023252DE	; 023252D2
	mov r0,#0x2	; 023252D4
	orr r2,r0	; 023252D6
	str r2,[r1,#0x0]	; 023252D8
	mov r0,#0x1	; 023252DA
	str r0,[r1,#0x28]	; 023252DC
P1_Entry_023252DE:
	bx lr	; 023252DE
pool_023252E0:
	.word P1_BssStart + 0x24168	; 023252E0
pool_023252E4:
	.word P1_Data_02330804	; 023252E4

; ===== function loc_023252E8 =====
loc_023252E8:
	ldr r1,[pool_023252F4]	; 023252E8
	ldr r2,[r1,#0x0]	; 023252EA
	mov r0,#0x1	; 023252EC
	bic r2,r0	; 023252EE
	str r2,[r1,#0x0]	; 023252F0
	bx lr	; 023252F2
pool_023252F4:
loc_023252F4:
	.word P1_BssStart + 0x24168	; 023252F4

; ===== function loc_023252F8 =====
loc_023252F8:
	ldr r1,[pool_02325304]	; 023252F8
	ldr r2,[r1,#0x0]	; 023252FA
	mov r0,#0x1	; 023252FC
	orr r2,r0	; 023252FE
	str r2,[r1,#0x0]	; 02325300
	bx lr	; 02325302
pool_02325304:
loc_02325304:
	.word P1_BssStart + 0x24168	; 02325304

; ===== function loc_02325308 =====
loc_02325308:
	push {r4,r5,r6,lr}	; 02325308
	ldr r2,[pool_02325360]	; 0232530A
	lsl r1,r0,#0x6	; 0232530C
	add r1,r2,r1	; 0232530E
	lsl r3,r0,#0x2	; 02325310
	ldr r2,[pool_02325364]	; 02325312
	ldr r4,[r2,r3]	; 02325314
	ldr r2,[pool_02325368]	; 02325316
	ldr r3,[r2,#0x8]	; 02325318
	cmp r3,#0x0	; 0232531A
	beq loc_02325330	; 0232531C
	ldr r2,[r2,#0x0]	; 0232531E
	and r2,r4	; 02325320
	cmp r2,#0x0	; 02325322
	beq loc_02325330	; 02325324
	ldr r1,[r1,#0x8]	; 02325326
	cmp r1,#0x0	; 02325328
	bne loc_02325330	; 0232532A
	mov r5,#0x1	; 0232532C
	b loc_02325332	; 0232532E
loc_02325330:
	mov r5,#0x0	; 02325330
loc_02325332:
	lsl r4,r0,#0x3	; 02325332
	ldr r0,[pool_0232536C]	; 02325334
	ldr r1,[pool_02325370]	; 02325336
	ldrh r1,[r1,r4]	; 02325338
	bl loc_02324298	; 0232533A
	add r6,r0,#0x0	; 0232533E
	ldr r0,[pool_02325374]	; 02325340
	ldrh r0,[r0,r4]	; 02325342
	bl loc_02324088	; 02325344
	cmp r5,#0x0	; 02325348
	beq loc_02325358	; 0232534A
	cmp r6,#0x0	; 0232534C
	bne loc_02325354	; 0232534E
	cmp r0,#0x0	; 02325350
	beq loc_02325358	; 02325352
loc_02325354:
	mov r0,#0x1	; 02325354
	b loc_0232535A	; 02325356
loc_02325358:
	mov r0,#0x0	; 02325358
loc_0232535A:
	pop {r4,r5,r6}	; 0232535A
	pop {r3}	; 0232535C
	bx r3	; 0232535E
pool_02325360:
loc_02325360:
	.word 0x02355000	; 02325360
pool_02325364:
loc_02325364:
	.word P1_Data_02330804	; 02325364
pool_02325368:
loc_02325368:
	.word P1_BssStart + 0x24168	; 02325368
pool_0232536C:
loc_0232536C:
	.word 0x02354FF4	; 0232536C
pool_02325370:
loc_02325370:
	.word P1_Data_02330810	; 02325370
pool_02325374:
loc_02325374:
	.word P1_Data_02330812	; 02325374
P1_Entry_02325378:
	lsl r2,r1,#0x6	; 02325378
	ldr r1,[pool_02325390]	; 0232537A
	ldr r1,[r1,r2]	; 0232537C
	cmp r0,r1	; 0232537E
	beq P1_Entry_0232538C	; 02325380
	ldr r1,[pool_02325394]	; 02325382
	str r0,[r1,r2]	; 02325384
	mov r1,#0x1	; 02325386
	ldr r0,[pool_02325398]	; 02325388
	str r1,[r0,r2]	; 0232538A
P1_Entry_0232538C:
	bx lr	; 0232538C
	.byte 0xC0, 0x46	; 0232538E
pool_02325390:
	.word P1_BssStart + 0x24180	; 02325390
pool_02325394:
	.word P1_BssStart + 0x24184	; 02325394
pool_02325398:
	.word P1_BssStart + 0x24190	; 02325398

; ===== function loc_0232539C =====
loc_0232539C:
	push {r4,r5,r6,r7,lr}	; 0232539C
	sub sp,#0xc	; 0232539E
	ldr r1,[pool_02325444]	; 023253A0
	ldr r2,[r1,#0x0]	; 023253A2
	mov r0,#0x1	; 023253A4
	and r2,r0	; 023253A6
	cmp r2,#0x0	; 023253A8
	beq loc_023253B8	; 023253AA
	ldr r0,[r1,#0x4]	; 023253AC
	cmp r0,#0x0	; 023253AE
	beq loc_023253C2	; 023253B0
	sub r0,r0,#0x2	; 023253B2
	str r0,[r1,#0x4]	; 023253B4
	b loc_023253C2	; 023253B6
loc_023253B8:
	ldr r0,[r1,#0x4]	; 023253B8
	cmp r0,#0x18	; 023253BA
	beq loc_023253C2	; 023253BC
	add r0,r0,#0x2	; 023253BE
	str r0,[r1,#0x4]	; 023253C0
loc_023253C2:
	mov r5,#0x0	; 023253C2
	add r7,r5,#0x0	; 023253C4
	mvn r6,r5	; 023253C6
	str r5,[sp,#0x0]	; 023253C8
	str r5,[sp,#0x4]	; 023253CA
loc_023253CC:
	lsl r1,r5,#0x6	; 023253CC
	ldr r0,[pool_02325448]	; 023253CE
	add r4,r0,r1	; 023253D0
	ldr r0,[r4,#0x10]	; 023253D2
	cmp r0,#0x0	; 023253D4
	beq loc_02325420	; 023253D6
	ldr r0,[r4,#0x8]	; 023253D8
	cmp r0,#0x18	; 023253DA
	beq loc_023253E8	; 023253DC
	add r4,#0x8	; 023253DE
	ldr r0,[r4,#0x0]	; 023253E0
	add r0,r0,#0x2	; 023253E2
	str r0,[r4,#0x0]	; 023253E4
	b loc_0232542E	; 023253E6
loc_023253E8:
	ldr r0,[pool_02325444]	; 023253E8
	ldr r0,[r0,#0x0]	; 023253EA
	lsl r2,r5,#0x2	; 023253EC
	ldr r1,[pool_0232544C]	; 023253EE
	ldr r1,[r1,r2]	; 023253F0
	and r0,r1	; 023253F2
	cmp r0,#0x0	; 023253F4
	beq loc_023253FE	; 023253F6
	mov r0,#0x1	; 023253F8
	str r0,[r4,#0xc]	; 023253FA
	b loc_02325400	; 023253FC
loc_023253FE:
	str r7,[r4,#0xc]	; 023253FE
loc_02325400:
	ldr r1,[r4,#0x4]	; 02325400
	ldr r0,[sp,#0x4]	; 02325402
	mvn r0,r0	; 02325404
	cmp r1,r0	; 02325406
	beq loc_0232541A	; 02325408
	str r1,[r4,#0x0]	; 0232540A
	add r0,r4,#0x0	; 0232540C
	add r0,#0x14	; 0232540E
	ldr r1,[pool_02325450]	; 02325410
	ldr r2,[r4,#0x0]	; 02325412
	bl loc_02324ADC	; 02325414
	str r6,[r4,#0x4]	; 02325418
loc_0232541A:
	ldr r0,[sp,#0x0]	; 0232541A
	str r0,[r4,#0x10]	; 0232541C
	b loc_0232542E	; 0232541E
loc_02325420:
	ldr r0,[r4,#0x8]	; 02325420
	cmp r0,#0x0	; 02325422
	beq loc_0232542E	; 02325424
	add r4,#0x8	; 02325426
	ldr r0,[r4,#0x0]	; 02325428
	sub r0,r0,#0x2	; 0232542A
	str r0,[r4,#0x0]	; 0232542C
loc_0232542E:
	add r5,r5,#0x1	; 0232542E
	cmp r5,#0x2	; 02325430
	blt loc_023253CC	; 02325432
	ldr r0,[pool_02325454]	; 02325434
	ldr r1,[pool_02325458]	; 02325436
	bl loc_023242AC	; 02325438
	add sp,#0xc	; 0232543C
	pop {r4,r5,r6,r7}	; 0232543E
	pop {r3}	; 02325440
	bx r3	; 02325442
pool_02325444:
loc_02325444:
	.word P1_BssStart + 0x24168	; 02325444
pool_02325448:
loc_02325448:
	.word 0x02355000	; 02325448
pool_0232544C:
loc_0232544C:
	.word P1_Data_02330804	; 0232544C
pool_02325450:
loc_02325450:
	.word 0x023A01EC	; 02325450
pool_02325454:
loc_02325454:
	.word 0x02354FF4	; 02325454
pool_02325458:
loc_02325458:
	.word 0x0239F1F4	; 02325458

; ===== function loc_0232545C =====
loc_0232545C:
	push {r4,r5,r6,r7,lr}	; 0232545C
	sub sp,#0x1c	; 0232545E
	bl loc_02323DB8	; 02325460
	add r7,r0,#0x0	; 02325464
	mov r5,#0x0	; 02325466
	str r5,[sp,#0x10]	; 02325468
	str r5,[sp,#0x14]	; 0232546A
loc_0232546C:
	lsl r1,r5,#0x6	; 0232546C
	ldr r0,[pool_02325508]	; 0232546E
	add r4,r0,r1	; 02325470
	ldr r0,[r4,#0xc]	; 02325472
	cmp r0,#0x0	; 02325474
	beq loc_023254CE	; 02325476
	ldr r1,[r4,#0x8]	; 02325478
	cmp r1,#0x18	; 0232547A
	beq loc_023254CE	; 0232547C
	ldr r0,[pool_0232550C]	; 0232547E
	ldr r0,[r0,#0x4]	; 02325480
	add r6,r0,r1	; 02325482
	ldr r0,[pool_0232550C]	; 02325484
	ldr r0,[r0,#0x8]	; 02325486
	cmp r0,#0x0	; 02325488
	beq loc_0232549E	; 0232548A
	ldr r0,[pool_02325510]	; 0232548C
	lsl r2,r5,#0x3	; 0232548E
	ldr r1,[pool_02325514]	; 02325490
	add r1,r1,r2	; 02325492
	ldrh r1,[r1,#0x4]	; 02325494
	bl loc_023241CC	; 02325496
	str r0,[sp,#0xc]	; 0232549A
	b loc_023254A2	; 0232549C
loc_0232549E:
	mov r0,#0x2	; 0232549E
	str r0,[sp,#0xc]	; 023254A0
loc_023254A2:
	ldr r0,[sp,#0x10]	; 023254A2
	str r0,[sp,#0x0]	; 023254A4
	add r4,#0x14	; 023254A6
	add r0,r4,#0x0	; 023254A8
	ldr r1,[sp,#0x10]	; 023254AA
	add r2,r6,#0x0	; 023254AC
	lsl r3,r1,#0	; 023254AE
	bl loc_023236B8	; 023254B0
	ldr r0,[sp,#0x14]	; 023254B4
	str r0,[sp,#0x0]	; 023254B6
	str r6,[sp,#0x4]	; 023254B8
	ldr r0,[sp,#0xc]	; 023254BA
	str r0,[sp,#0x8]	; 023254BC
	add r0,r7,#0x0	; 023254BE
	ldr r1,[pool_02325518]	; 023254C0
	ldr r2,[pool_0232551C]	; 023254C2
	lsl r4,r5,#0x3	; 023254C4
	ldr r3,[pool_02325514]	; 023254C6
	ldrh r3,[r3,r4]	; 023254C8
	bl loc_02323B24	; 023254CA
loc_023254CE:
	add r5,r5,#0x1	; 023254CE
	cmp r5,#0x2	; 023254D0
	blt loc_0232546C	; 023254D2
	mov r3,#0x0	; 023254D4
	str r3,[sp,#0x0]	; 023254D6
	ldr r0,[pool_0232550C]	; 023254D8
	ldr r0,[r0,#0x4]	; 023254DA
	neg r0,r0	; 023254DC
	str r0,[sp,#0x4]	; 023254DE
	add r0,r7,#0x0	; 023254E0
	ldr r1,[pool_02325518]	; 023254E2
	ldr r2,[pool_0232551C]	; 023254E4
	bl loc_02323B78	; 023254E6
	mov r0,#0x0	; 023254EA
	str r0,[sp,#0x0]	; 023254EC
	ldr r0,[pool_0232550C]	; 023254EE
	ldr r0,[r0,#0x4]	; 023254F0
	str r0,[sp,#0x4]	; 023254F2
	add r0,r7,#0x0	; 023254F4
	ldr r1,[pool_02325518]	; 023254F6
	ldr r2,[pool_0232551C]	; 023254F8
	mov r3,#0x1	; 023254FA
	bl loc_02323B78	; 023254FC
	add sp,#0x1c	; 02325500
	pop {r4,r5,r6,r7}	; 02325502
	pop {r3}	; 02325504
	bx r3	; 02325506
pool_02325508:
loc_02325508:
	.word 0x02355000	; 02325508
pool_0232550C:
loc_0232550C:
	.word P1_BssStart + 0x24168	; 0232550C
pool_02325510:
loc_02325510:
	.word 0x02354FF4	; 02325510
pool_02325514:
loc_02325514:
	.word P1_Data_0233080C	; 02325514
pool_02325518:
loc_02325518:
	.word 0x023BB898	; 02325518
pool_0232551C:
loc_0232551C:
	.word 0x0239F6DC	; 0232551C

; ===== function loc_02325520 =====
loc_02325520:
	push {r4,r5,r6,r7,lr}	; 02325520
	sub sp,#0x4	; 02325522
	str r0,[sp,#0x0]	; 02325524
	mov r5,#0x0	; 02325526
loc_02325528:
	lsl r4,r5,#0x6	; 02325528
	ldr r0,[pool_02325560]	; 0232552A
	add r7,r0,r4	; 0232552C
	ldr r0,[sp,#0x0]	; 0232552E
	add r1,r7,#0x0	; 02325530
	add r1,#0x14	; 02325532
	ldr r2,[pool_02325564]	; 02325534
	lsl r6,r5,#0x3	; 02325536
	ldr r3,[pool_02325568]	; 02325538
	add r3,r3,r6	; 0232553A
	ldrh r3,[r3,#0x2]	; 0232553C
	bl loc_02324B34	; 0232553E
	add r7,#0x14	; 02325542
	add r0,r7,#0x0	; 02325544
	ldr r1,[pool_02325564]	; 02325546
	ldr r2,[pool_02325560]	; 02325548
	ldr r2,[r2,r4]	; 0232554A
	bl loc_02324ADC	; 0232554C
	add r5,r5,#0x1	; 02325550
	cmp r5,#0x2	; 02325552
	blt loc_02325528	; 02325554
	add sp,#0x4	; 02325556
	pop {r4,r5,r6,r7}	; 02325558
	pop {r3}	; 0232555A
	bx r3	; 0232555C
	.byte 0xC0, 0x46	; 02325560
pool_02325560:
loc_02325560:
	.word P1_BssStart + 0x24180	; 02325560
pool_02325564:
loc_02325564:
	.word 0x023A01EC	; 02325564
pool_02325568:
loc_02325568:
	.word 0x0233080C	; 02325568

; ===== function loc_0232556C =====
loc_0232556C:
	push {r4,r5,r6,r7,lr}	; 0232556C
	sub sp,#0xc	; 0232556E
	str r0,[sp,#0x4]	; 02325570
	add r7,r1,#0x0	; 02325572
	add r4,r2,#0x0	; 02325574
	mov r3,#0x0	; 02325576
	mvn r1,r3	; 02325578
	add r0,r3,#0x0	; 0232557A
loc_0232557C:
	lsl r5,r3,#0x6	; 0232557C
	ldr r2,[pool_023255DC]	; 0232557E
	add r2,r2,r5	; 02325580
	str r1,[r2,#0x4]	; 02325582
	str r0,[r2,#0x10]	; 02325584
	lsl r6,r3,#0x2	; 02325586
	ldr r5,[pool_023255E0]	; 02325588
	ldr r6,[r5,r6]	; 0232558A
	add r5,r4,#0x0	; 0232558C
	str r5,[sp,#0x0]	; 0232558E
	and r5,r6	; 02325590
	str r5,[sp,#0x0]	; 02325592
	cmp r5,#0x0	; 02325594
	beq loc_023255A0	; 02325596
	mov r5,#0x1	; 02325598
	str r5,[r2,#0xc]	; 0232559A
	str r0,[r2,#0x8]	; 0232559C
	b loc_023255A6	; 0232559E
loc_023255A0:
	str r0,[r2,#0xc]	; 023255A0
	mov r5,#0x18	; 023255A2
	str r5,[r2,#0x8]	; 023255A4
loc_023255A6:
	add r3,r3,#0x1	; 023255A6
	cmp r3,#0x2	; 023255A8
	blt loc_0232557C	; 023255AA
	ldr r1,[pool_023255E4]	; 023255AC
	ldr r0,[sp,#0x4]	; 023255AE
	str r0,[r1,#0x18]	; 023255B0
	str r7,[r1,#0x58]	; 023255B2
	str r4,[r1,#0x0]	; 023255B4
	mov r0,#0x1	; 023255B6
	and r4,r0	; 023255B8
	cmp r4,#0x0	; 023255BA
	beq loc_023255C4	; 023255BC
	mov r0,#0x0	; 023255BE
	str r0,[r1,#0x4]	; 023255C0
	b loc_023255C8	; 023255C2
loc_023255C4:
	mov r0,#0x18	; 023255C4
	str r0,[r1,#0x4]	; 023255C6
loc_023255C8:
	mov r1,#0x1	; 023255C8
	ldr r0,[pool_023255E4]	; 023255CA
	str r1,[r0,#0x8]	; 023255CC
	ldr r0,[pool_023255E8]	; 023255CE
	bl loc_02324358	; 023255D0
	add sp,#0xc	; 023255D4
	pop {r4,r5,r6,r7}	; 023255D6
	pop {r3}	; 023255D8
	bx r3	; 023255DA
pool_023255DC:
loc_023255DC:
	.word 0x02355000	; 023255DC
pool_023255E0:
loc_023255E0:
	.word P1_Data_02330804	; 023255E0
pool_023255E4:
loc_023255E4:
	.word P1_BssStart + 0x24168	; 023255E4
pool_023255E8:
loc_023255E8:
	.word 0x02354FF4	; 023255E8

; ===== function loc_023255EC =====
loc_023255EC:
	push {r4,r5,r6,lr}	; 023255EC
	sub sp,#0x8	; 023255EE
	add r5,r0,#0x0	; 023255F0
	mov r4,#0x0	; 023255F2
	add r6,r4,#0x0	; 023255F4
	cmp r1,#0x8	; 023255F6
	bhi loc_02325650	; 023255F8
	add r0,r1,r1	; 023255FA
P1_SwitchIndexPC_023255FA:
	add r0,pc	; 023255FC
	ldrh r0,[r0,#(P1_SwitchTable_023255FA - (P1_SwitchIndexPC_023255FA + 4))]	; 023255FE
	lsl r0,r0,#0x10	; 02325600
	asr r0,r0,#0x10	; 02325602
P1_SwitchTargetPC_023255FA:
	add r0,pc	; 02325604
	bx r0	; 02325606
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023255FA:
	.halfword (loc_02325650 + 1) - (P1_SwitchTargetPC_023255FA + 4)
	.halfword (loc_0232561A + 1) - (P1_SwitchTargetPC_023255FA + 4)
	.halfword (loc_02325628 + 1) - (P1_SwitchTargetPC_023255FA + 4)
	.halfword (loc_02325650 + 1) - (P1_SwitchTargetPC_023255FA + 4)
	.halfword (loc_02325636 + 1) - (P1_SwitchTargetPC_023255FA + 4)
	.halfword (loc_02325650 + 1) - (P1_SwitchTargetPC_023255FA + 4)
	.halfword (loc_02325650 + 1) - (P1_SwitchTargetPC_023255FA + 4)
	.halfword (loc_02325650 + 1) - (P1_SwitchTargetPC_023255FA + 4)
	.halfword (loc_02325644 + 1) - (P1_SwitchTargetPC_023255FA + 4)
P1_SwitchTable_023255FAEnd:
loc_0232561A:
	bl P1_GetSubBg0TilemapBase	; 0232561A
	add r4,r0,#0x0	; 0232561E
	bl P1_GetSubBg0CharacterBase	; 02325620
	add r6,r0,#0x0	; 02325624
	b loc_02325650	; 02325626
loc_02325628:
	bl P1_GetSubBg1TilemapBase	; 02325628
	add r4,r0,#0x0	; 0232562C
	bl P1_GetSubBg1CharacterBase	; 0232562E
	add r6,r0,#0x0	; 02325632
	b loc_02325650	; 02325634
loc_02325636:
	bl P1_ResolveSubBg2TilemapAddress	; 02325636
	add r4,r0,#0x0	; 0232563A
	bl P1_TryGetSubBg2CharacterBase	; 0232563C
	add r6,r0,#0x0	; 02325640
	b loc_02325650	; 02325642
loc_02325644:
	bl P1_ResolveSubBg3TilemapAddress	; 02325644
	add r4,r0,#0x0	; 02325648
	bl P1_TryGetSubBg3CharacterBase	; 0232564A
	add r6,r0,#0x0	; 0232564E
loc_02325650:
	mov r2,#0x0	; 02325650
	ldr r1,[pool_02325688]	; 02325652
loc_02325654:
	lsl r0,r2,#0x1	; 02325654
	strh r2,[r4,r0]	; 02325656
	add r0,r2,#0x1	; 02325658
	lsl r0,r0,#0x10	; 0232565A
	lsr r2,r0,#0x10	; 0232565C
	cmp r2,r1	; 0232565E
	bcc loc_02325654	; 02325660
	bl loc_02324BE8	; 02325662
	mov r1,#0x0	; 02325666
	str r1,[sp,#0x0]	; 02325668
	str r0,[sp,#0x4]	; 0232566A
	ldr r0,[pool_0232568C]	; 0232566C
	add r1,r6,#0x0	; 0232566E
	ldr r2,[pool_02325690]	; 02325670
	mov r3,#0xc0	; 02325672
	bl loc_02328BF0	; 02325674
	ldr r0,[pool_0232568C]	; 02325678
	add r1,r5,#0x0	; 0232567A
	bl loc_02328D2C	; 0232567C
	add sp,#0x8	; 02325680
	pop {r4,r5,r6}	; 02325682
	pop {r3}	; 02325684
	bx r3	; 02325686
pool_02325688:
loc_02325688:
	.word 0x00000300	; 02325688
pool_0232568C:
loc_0232568C:
	.word 0x02355080	; 0232568C
pool_02325690:
loc_02325690:
	.word 0x00000100	; 02325690

; ===== function loc_02325694 =====
loc_02325694:
	ldr r0,[pool_02325698]	; 02325694
	bx lr	; 02325696
pool_02325698:
loc_02325698:
	.word 0x02355090	; 02325698

; ===== function loc_0232569C =====
loc_0232569C:
	mov r2,#0x0	; 0232569C
	ldr r1,[pool_023256B4]	; 0232569E
	str r2,[r1,#0x0]	; 023256A0
	str r2,[r1,#0x4]	; 023256A2
	ldr r0,[pool_023256B8]	; 023256A4
	orr r2,r0	; 023256A6
	str r2,[r1,#0x0]	; 023256A8
	ldr r0,[pool_023256BC]	; 023256AA
	orr r2,r0	; 023256AC
	str r2,[r1,#0x0]	; 023256AE
	bx lr	; 023256B0
	.byte 0xC0, 0x46	; 023256B4
pool_023256B4:
loc_023256B4:
	.word P1_BssStart + 0x24210	; 023256B4
pool_023256B8:
loc_023256B8:
	.word 0x00000200	; 023256B8
pool_023256BC:
loc_023256BC:
	.word 0x00000400	; 023256BC

; ===== function loc_023256C0 =====
loc_023256C0:
	push {r4,r5,r6,r7,lr}	; 023256C0
	sub sp,#0x4	; 023256C2
	bl loc_02325694	; 023256C4
	add r5,r0,#0x0	; 023256C8
	ldr r0,[pool_02325788]	; 023256CA
	ldrh r1,[r0,#0x0]	; 023256CC
	ldr r0,[pool_0232578C]	; 023256CE
	ldrh r0,[r0,#0x0]	; 023256D0
	orr r1,r0	; 023256D2
	ldr r0,[pool_02325790]	; 023256D4
	eor r1,r0	; 023256D6
	and r1,r0	; 023256D8
	lsl r0,r1,#0x10	; 023256DA
	lsr r1,r0,#0x10	; 023256DC
	ldr r0,[r5,#0x0]	; 023256DE
	lsl r2,r0,#0x19	; 023256E0
	lsr r2,r2,#0x1f	; 023256E2
	cmp r2,#0x0	; 023256E4
	bne loc_0232577E	; 023256E6
	lsl r2,r0,#0x17	; 023256E8
	lsr r2,r2,#0x1f	; 023256EA
	cmp r2,#0x0	; 023256EC
	beq loc_02325702	; 023256EE
	ldr r2,[pool_02325794]	; 023256F0
	add r3,r1,#0x0	; 023256F2
	and r3,r2	; 023256F4
	cmp r3,r2	; 023256F6
	bne loc_02325702	; 023256F8
	mov r1,#0x10	; 023256FA
	orr r0,r1	; 023256FC
	str r0,[r5,#0x0]	; 023256FE
	b loc_0232577E	; 02325700
loc_02325702:
	ldr r0,[pool_02325798]	; 02325702
	ldrh r0,[r0,#0x0]	; 02325704
	lsl r0,r0,#0x19	; 02325706
	lsr r0,r0,#0x1f	; 02325708
	cmp r0,#0x0	; 0232570A
	beq loc_0232577E	; 0232570C
	ldr r0,[pool_0232579C]	; 0232570E
	ldr r0,[r0,#0x0]	; 02325710
	mov r2,#0x1	; 02325712
	and r0,r2	; 02325714
	cmp r0,#0x0	; 02325716
	bne loc_0232571C	; 02325718
	mov r2,#0x0	; 0232571A
loc_0232571C:
	cmp r2,#0x0	; 0232571C
	beq loc_0232577E	; 0232571E
	ldr r0,[r5,#0x0]	; 02325720
	lsl r0,r0,#0x1c	; 02325722
	lsr r0,r0,#0x1f	; 02325724
	cmp r0,#0x0	; 02325726
	bne loc_0232577E	; 02325728
	ldr r0,[pool_0232579C]	; 0232572A
	ldr r2,[r0,#0x0]	; 0232572C
	mov r0,#0x2	; 0232572E
	and r2,r0	; 02325730
	cmp r2,#0x0	; 02325732
	beq loc_0232573A	; 02325734
	mov r0,#0x1	; 02325736
	b loc_0232573C	; 02325738
loc_0232573A:
	mov r0,#0x0	; 0232573A
loc_0232573C:
	cmp r0,#0x0	; 0232573C
	bne loc_0232574A	; 0232573E
	ldr r1,[r5,#0x0]	; 02325740
	mov r0,#0x10	; 02325742
	orr r1,r0	; 02325744
	str r1,[r5,#0x0]	; 02325746
	b loc_0232577E	; 02325748
loc_0232574A:
	mov r4,#0x0	; 0232574A
	ldr r7,[pool_02325788]	; 0232574C
	ldr r6,[pool_02325790]	; 0232574E
	b loc_02325776	; 02325750
loc_02325752:
	bl loc_0232C3E6	; 02325752
	ldrh r1,[r7,#0x0]	; 02325756
	ldr r0,[pool_0232578C]	; 02325758
	ldrh r0,[r0,#0x0]	; 0232575A
	orr r1,r0	; 0232575C
	eor r1,r6	; 0232575E
	and r1,r6	; 02325760
	lsl r0,r1,#0x10	; 02325762
	lsr r1,r0,#0x10	; 02325764
	add r4,r4,#0x1	; 02325766
	cmp r4,#0x1e	; 02325768
	blt loc_02325776	; 0232576A
	ldr r1,[r5,#0x0]	; 0232576C
	mov r0,#0x10	; 0232576E
	orr r1,r0	; 02325770
	str r1,[r5,#0x0]	; 02325772
	b loc_0232577E	; 02325774
loc_02325776:
	mov r0,#0x2	; 02325776
	and r1,r0	; 02325778
	cmp r1,#0x0	; 0232577A
	bne loc_02325752	; 0232577C
loc_0232577E:
	add sp,#0x4	; 0232577E
	pop {r4,r5,r6,r7}	; 02325780
	pop {r3}	; 02325782
	bx r3	; 02325784
	.byte 0xC0, 0x46	; 02325788
pool_02325788:
loc_02325788:
	.word REG_KEYINPUT	; 02325788
pool_0232578C:
loc_0232578C:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 0232578C
pool_02325790:
loc_02325790:
	.word 0x00002FFF	; 02325790
pool_02325794:
loc_02325794:
	.word 0x00000E03	; 02325794
pool_02325798:
loc_02325798:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02325798
pool_0232579C:
loc_0232579C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232579C

; ===== function loc_023257A0 =====
loc_023257A0:
	push {r4,r5,r6,r7,lr}	; 023257A0
	sub sp,#0x4	; 023257A2
	bl loc_02325694	; 023257A4
	add r1,r0,#0x0	; 023257A8
	ldr r0,[pool_02325938]	; 023257AA
	ldrh r2,[r0,#0x0]	; 023257AC
	ldr r0,[pool_0232593C]	; 023257AE
	ldrh r0,[r0,#0x0]	; 023257B0
	orr r2,r0	; 023257B2
	ldr r0,[pool_02325940]	; 023257B4
	eor r2,r0	; 023257B6
	and r2,r0	; 023257B8
	lsl r0,r2,#0x10	; 023257BA
	lsr r0,r0,#0x10	; 023257BC
	ldr r3,[r1,#0x0]	; 023257BE
	mov r2,#0x4	; 023257C0
	bic r3,r2	; 023257C2
	ldr r4,[pool_02325944]	; 023257C4
	ldrh r2,[r4,#0x0]	; 023257C6
	lsl r2,r2,#0x16	; 023257C8
	lsr r5,r2,#0x1f	; 023257CA
	mov r2,#0x1	; 023257CC
	and r5,r2	; 023257CE
	lsl r5,r5,#0x2	; 023257D0
	orr r3,r5	; 023257D2
	str r3,[r1,#0x0]	; 023257D4
	ldrh r6,[r4,#0x0]	; 023257D6
	lsl r3,r6,#0x15	; 023257D8
	lsr r7,r3,#0x1f	; 023257DA
	lsl r3,r6,#0x11	; 023257DC
	lsr r5,r3,#0x1f	; 023257DE
	lsl r3,r6,#0x14	; 023257E0
	lsr r4,r3,#0x1f	; 023257E2
	lsl r3,r6,#0x12	; 023257E4
	lsr r3,r3,#0x1f	; 023257E6
	lsl r6,r6,#0x10	; 023257E8
	lsr r6,r6,#0x1f	; 023257EA
	and r3,r6	; 023257EC
	and r4,r3	; 023257EE
	and r5,r4	; 023257F0
	and r7,r5	; 023257F2
	cmp r7,#0x0	; 023257F4
	beq loc_023257FA	; 023257F6
	mov r2,#0x0	; 023257F8
loc_023257FA:
	ldr r4,[r1,#0x0]	; 023257FA
	mov r3,#0x1	; 023257FC
	bic r4,r3	; 023257FE
	and r2,r3	; 02325800
	orr r4,r2	; 02325802
	str r4,[r1,#0x0]	; 02325804
	ldr r2,[r1,#0x0]	; 02325806
	mov r4,#0x2	; 02325808
	bic r2,r4	; 0232580A
	ldr r4,[pool_02325944]	; 0232580C
	ldrh r4,[r4,#0x0]	; 0232580E
	lsl r4,r4,#0x12	; 02325810
	lsr r4,r4,#0x1f	; 02325812
	and r4,r3	; 02325814
	lsl r4,r4,#0x1	; 02325816
	orr r2,r4	; 02325818
	str r2,[r1,#0x0]	; 0232581A
	ldr r6,[r1,#0x0]	; 0232581C
	ldr r4,[pool_02325948]	; 0232581E
	add r2,r6,#0x0	; 02325820
	and r2,r4	; 02325822
	lsl r4,r6,#0x1f	; 02325824
	lsr r5,r4,#0x1f	; 02325826
	lsl r4,r6,#0x1d	; 02325828
	lsr r4,r4,#0x1f	; 0232582A
	orr r5,r4	; 0232582C
	and r5,r3	; 0232582E
	lsl r4,r5,#0x8	; 02325830
	orr r2,r4	; 02325832
	str r2,[r1,#0x0]	; 02325834
	mov r2,#0x8	; 02325836
	add r4,r0,#0x0	; 02325838
	and r4,r2	; 0232583A
	cmp r4,#0x0	; 0232583C
	bne loc_02325842	; 0232583E
	mov r3,#0x0	; 02325840
loc_02325842:
	ldr r5,[r1,#0x0]	; 02325842
	mov r2,#0x8	; 02325844
	bic r5,r2	; 02325846
	mov r4,#0x1	; 02325848
	and r3,r4	; 0232584A
	lsl r2,r3,#0x3	; 0232584C
	orr r5,r2	; 0232584E
	str r5,[r1,#0x0]	; 02325850
	mov r3,#0x0	; 02325852
	add r2,r3,#0x0	; 02325854
	ldr r5,[pool_0232594C]	; 02325856
	ldr r6,[r5,#0x0]	; 02325858
	mov r5,#0x2	; 0232585A
	and r6,r5	; 0232585C
	cmp r6,#0x0	; 0232585E
	bne loc_02325864	; 02325860
	add r4,r3,#0x0	; 02325862
loc_02325864:
	cmp r4,#0x0	; 02325864
	beq loc_02325874	; 02325866
	ldr r4,[r1,#0x0]	; 02325868
	lsl r4,r4,#0x17	; 0232586A
	lsr r4,r4,#0x1f	; 0232586C
	cmp r4,#0x0	; 0232586E
	beq loc_02325874	; 02325870
	mov r2,#0x1	; 02325872
loc_02325874:
	cmp r2,#0x0	; 02325874
	beq loc_02325882	; 02325876
	ldr r2,[pool_02325950]	; 02325878
	and r0,r2	; 0232587A
	cmp r0,r2	; 0232587C
	bne loc_02325882	; 0232587E
	mov r3,#0x1	; 02325880
loc_02325882:
	ldr r4,[r1,#0x0]	; 02325882
	mov r0,#0x40	; 02325884
	bic r4,r0	; 02325886
	mov r0,#0x1	; 02325888
	and r3,r0	; 0232588A
	lsl r2,r3,#0x6	; 0232588C
	orr r4,r2	; 0232588E
	str r4,[r1,#0x0]	; 02325890
	mov r2,#0x0	; 02325892
	ldr r3,[pool_0232594C]	; 02325894
	ldr r4,[r3,#0x0]	; 02325896
	mov r3,#0x2	; 02325898
	and r4,r3	; 0232589A
	cmp r4,#0x0	; 0232589C
	bne loc_023258A2	; 0232589E
	add r0,r2,#0x0	; 023258A0
loc_023258A2:
	cmp r0,#0x0	; 023258A2
	beq loc_023258D2	; 023258A4
	mov r0,#0x0	; 023258A6
	ldr r3,[pool_0232594C]	; 023258A8
	ldr r4,[r3,#0x0]	; 023258AA
	mov r3,#0x2	; 023258AC
	and r4,r3	; 023258AE
	cmp r4,#0x0	; 023258B0
	beq loc_023258B8	; 023258B2
	mov r3,#0x1	; 023258B4
	b loc_023258BA	; 023258B6
loc_023258B8:
	add r3,r0,#0x0	; 023258B8
loc_023258BA:
	cmp r3,#0x0	; 023258BA
	beq loc_023258CC	; 023258BC
	ldr r3,[pool_02325954]	; 023258BE
	ldrb r3,[r3,#0x0]	; 023258C0
	lsl r3,r3,#0x1d	; 023258C2
	lsr r3,r3,#0x1f	; 023258C4
	cmp r3,#0x0	; 023258C6
	beq loc_023258CC	; 023258C8
	mov r0,#0x1	; 023258CA
loc_023258CC:
	cmp r0,#0x0	; 023258CC
	beq loc_023258D2	; 023258CE
	mov r2,#0x1	; 023258D0
loc_023258D2:
	ldr r4,[r1,#0x0]	; 023258D2
	mov r3,#0x40	; 023258D4
	add r0,r4,#0x0	; 023258D6
	bic r0,r3	; 023258D8
	lsl r3,r4,#0x19	; 023258DA
	lsr r4,r3,#0x1f	; 023258DC
	orr r4,r2	; 023258DE
	mov r3,#0x1	; 023258E0
	and r4,r3	; 023258E2
	lsl r2,r4,#0x6	; 023258E4
	orr r0,r2	; 023258E6
	str r0,[r1,#0x0]	; 023258E8
	mov r2,#0x0	; 023258EA
	add r0,r2,#0x0	; 023258EC
	ldr r4,[pool_02325944]	; 023258EE
	ldrh r4,[r4,#0x0]	; 023258F0
	lsl r4,r4,#0x19	; 023258F2
	lsr r4,r4,#0x1f	; 023258F4
	cmp r4,#0x0	; 023258F6
	beq loc_0232590E	; 023258F8
	ldr r4,[pool_0232594C]	; 023258FA
	ldr r5,[r4,#0x0]	; 023258FC
	mov r4,#0x2	; 023258FE
	and r5,r4	; 02325900
	cmp r5,#0x0	; 02325902
	bne loc_02325908	; 02325904
	add r3,r2,#0x0	; 02325906
loc_02325908:
	cmp r3,#0x0	; 02325908
	beq loc_0232590E	; 0232590A
	mov r0,#0x1	; 0232590C
loc_0232590E:
	cmp r0,#0x0	; 0232590E
	beq loc_0232591E	; 02325910
	ldr r0,[r1,#0x0]	; 02325912
	lsl r0,r0,#0x1c	; 02325914
	lsr r0,r0,#0x1f	; 02325916
	cmp r0,#0x0	; 02325918
	bne loc_0232591E	; 0232591A
	mov r2,#0x1	; 0232591C
loc_0232591E:
	ldr r3,[r1,#0x0]	; 0232591E
	mov r0,#0x20	; 02325920
	bic r3,r0	; 02325922
	mov r0,#0x1	; 02325924
	and r2,r0	; 02325926
	lsl r0,r2,#0x5	; 02325928
	orr r3,r0	; 0232592A
	str r3,[r1,#0x0]	; 0232592C
	add sp,#0x4	; 0232592E
	pop {r4,r5,r6,r7}	; 02325930
	pop {r3}	; 02325932
	bx r3	; 02325934
	.byte 0xC0, 0x46	; 02325938
pool_02325938:
loc_02325938:
	.word REG_KEYINPUT	; 02325938
pool_0232593C:
loc_0232593C:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 0232593C
pool_02325940:
loc_02325940:
	.word 0x00002FFF	; 02325940
pool_02325944:
loc_02325944:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02325944
pool_02325948:
loc_02325948:
	.word 0xFFFFFEFF	; 02325948
pool_0232594C:
loc_0232594C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232594C
pool_02325950:
loc_02325950:
	.word 0x00000D03	; 02325950
pool_02325954:
loc_02325954:
	.word NdsCartHeaderRamAddress + 0x1F	; 02325954

; ===== function loc_02325958 =====
loc_02325958:
	push {lr}	; 02325958
	sub sp,#0x4	; 0232595A
	cmp r1,#0xa	; 0232595C
	bge loc_02325970	; 0232595E
	lsl r2,r1,#0x1	; 02325960
	ldr r1,[pool_0232597C]	; 02325962
	ldrh r1,[r1,r2]	; 02325964
	strh r1,[r0,#0x0]	; 02325966
	mov r1,#0x0	; 02325968
	strh r1,[r0,#0x2]	; 0232596A
	add r0,r0,#0x2	; 0232596C
	b loc_02325974	; 0232596E
loc_02325970:
	bl loc_02325980	; 02325970
loc_02325974:
	add sp,#0x4	; 02325974
	pop {r3}	; 02325976
	bx r3	; 02325978
	.byte 0xC0, 0x46	; 0232597C
pool_0232597C:
loc_0232597C:
	.word P1_Data_0233081C	; 0232597C

; ===== function loc_02325980 =====
loc_02325980:
	push {r4,r5,lr}	; 02325980
	sub sp,#0x4	; 02325982
	add r5,r0,#0x0	; 02325984
	add r4,r1,#0x0	; 02325986
	add r0,r4,#0x0	; 02325988
	mov r1,#0xa	; 0232598A
	blx P1_SignedDivMod	; 0232598C
	mov r1,#0xa	; 02325990
	blx P1_SignedDivMod	; 02325992
	lsl r1,r1,#0x1	; 02325996
	ldr r0,[pool_023259BC]	; 02325998
	ldrh r0,[r0,r1]	; 0232599A
	strh r0,[r5,#0x0]	; 0232599C
	add r0,r4,#0x0	; 0232599E
	mov r1,#0xa	; 023259A0
	blx P1_SignedDivMod	; 023259A2
	lsl r1,r1,#0x1	; 023259A6
	ldr r0,[pool_023259BC]	; 023259A8
	ldrh r0,[r0,r1]	; 023259AA
	strh r0,[r5,#0x2]	; 023259AC
	mov r0,#0x0	; 023259AE
	strh r0,[r5,#0x4]	; 023259B0
	add r0,r5,#0x4	; 023259B2
	add sp,#0x4	; 023259B4
	pop {r4,r5}	; 023259B6
	pop {r3}	; 023259B8
	bx r3	; 023259BA
pool_023259BC:
loc_023259BC:
	.word P1_Data_0233081C	; 023259BC

; ===== function loc_023259C0 =====
loc_023259C0:
	push {r4,r5,r6,r7,lr}	; 023259C0
	sub sp,#0x1fc	; 023259C2
	sub sp,#0x10	; 023259C4
	add r5,r0,#0x0	; 023259C6
	mov r4,#0x0	; 023259C8
	add r0,sp,#0x8	; 023259CA
	ldr r1,[pool_02325A2C]	; 023259CC
	bl loc_0232CDF4	; 023259CE
	mov r0,#0x39	; 023259D2
	bl loc_02324D1C	; 023259D4
	add r6,r0,#0x0	; 023259D8
	add r0,sp,#0x0	; 023259DA
	ldr r1,[r5,#0x10]	; 023259DC
	ldrb r1,[r1,#0x0]	; 023259DE
	bl loc_02325980	; 023259E0
	add r0,sp,#0x4	; 023259E4
	ldr r1,[r5,#0x10]	; 023259E6
	ldrb r1,[r1,#0x1]	; 023259E8
	bl loc_02325980	; 023259EA
	lsl r3,r4,#0	; 023259EE
	add r0,sp,#0x8	; 023259F0
	add r7,sp,#0x0	; 023259F2
	b loc_02325A0A	; 023259F4
loc_023259F6:
	ldr r5,[pool_02325A30]	; 023259F6
	cmp r2,r5	; 023259F8
	bne loc_02325A06	; 023259FA
	lsl r2,r4,#0x1	; 023259FC
	add r4,r4,#0x1	; 023259FE
	ldrh r2,[r7,r2]	; 02325A00
	strh r2,[r0,r1]	; 02325A02
	b loc_02325A08	; 02325A04
loc_02325A06:
	strh r2,[r0,r1]	; 02325A06
loc_02325A08:
	add r3,r3,#0x1	; 02325A08
loc_02325A0A:
	lsl r1,r3,#0x1	; 02325A0A
	ldrh r2,[r6,r1]	; 02325A0C
	cmp r2,#0x0	; 02325A0E
	beq loc_02325A18	; 02325A10
	ldr r5,[pool_02325A34]	; 02325A12
	cmp r3,r5	; 02325A14
	blt loc_023259F6	; 02325A16
loc_02325A18:
	mov r0,#0x39	; 02325A18
	mov r1,#0x1	; 02325A1A
	add r2,sp,#0x8	; 02325A1C
	bl loc_02324FBC	; 02325A1E
	add sp,#0x1fc	; 02325A22
	add sp,#0x10	; 02325A24
	pop {r4,r5,r6,r7}	; 02325A26
	pop {r3}	; 02325A28
	bx r3	; 02325A2A
pool_02325A2C:
loc_02325A2C:
	.word 0x00000200	; 02325A2C
pool_02325A30:
loc_02325A30:
	.word 0x000025CF	; 02325A30
pool_02325A34:
loc_02325A34:
	.word 0x00000100	; 02325A34

; ===== function loc_02325A38 =====
loc_02325A38:
	push {r4,lr}	; 02325A38
	sub sp,#0x8	; 02325A3A
	add r4,r0,#0x0	; 02325A3C
	ldr r0,[r4,#0x0]	; 02325A3E
	cmp r0,#0x0	; 02325A40
	bne loc_02325A5C	; 02325A42
	mov r0,#0x0	; 02325A44
	str r0,[sp,#0x0]	; 02325A46
	ldr r0,[pool_02325AB8]	; 02325A48
	ldr r1,[r4,#0xc]	; 02325A4A
	ldr r2,[r4,#0x8]	; 02325A4C
	mov r3,#0x10	; 02325A4E
	bl loc_0232DBC0	; 02325A50
	ldr r0,[r4,#0x0]	; 02325A54
	add r0,r0,#0x1	; 02325A56
	str r0,[r4,#0x0]	; 02325A58
	b loc_02325AB0	; 02325A5A
loc_02325A5C:
	cmp r0,#0xf	; 02325A5C
	bgt loc_02325A7C	; 02325A5E
	lsl r0,r0,#0x4	; 02325A60
	mov r1,#0xf	; 02325A62
	blx P1_SignedDivMod	; 02325A64
	mov r1,#0x10	; 02325A68
	sub r1,r1,r0	; 02325A6A
	lsl r0,r0,#0x8	; 02325A6C
	orr r1,r0	; 02325A6E
	ldr r0,[pool_02325ABC]	; 02325A70
	strh r1,[r0,#0x0]	; 02325A72
	ldr r0,[r4,#0x0]	; 02325A74
	add r0,r0,#0x1	; 02325A76
	str r0,[r4,#0x0]	; 02325A78
	b loc_02325AB0	; 02325A7A
loc_02325A7C:
	mov r0,#0x0	; 02325A7C
	str r0,[r4,#0x0]	; 02325A7E
	add r3,r4,#0x0	; 02325A80
	add r3,#0x38	; 02325A82
	ldr r2,[r3,#0x0]	; 02325A84
	mov r1,#0x4	; 02325A86
	bic r2,r1	; 02325A88
	str r2,[r3,#0x0]	; 02325A8A
	ldr r2,[r3,#0x0]	; 02325A8C
	mov r1,#0x10	; 02325A8E
	orr r2,r1	; 02325A90
	str r2,[r3,#0x0]	; 02325A92
	ldr r2,[pool_02325AC0]	; 02325A94
	ldr r3,[r2,#0x0]	; 02325A96
	ldr r1,[pool_02325AC4]	; 02325A98
	and r3,r1	; 02325A9A
	ldr r1,[r4,#0x8]	; 02325A9C
	lsl r1,r1,#0x8	; 02325A9E
	orr r3,r1	; 02325AA0
	str r3,[r2,#0x0]	; 02325AA2
	ldr r1,[pool_02325AB8]	; 02325AA4
	strh r0,[r1,#0x0]	; 02325AA6
	bl loc_023252F8	; 02325AA8
	mov r0,#0x0	; 02325AAC
	str r0,[r4,#0x30]	; 02325AAE
loc_02325AB0:
	add sp,#0x8	; 02325AB0
	pop {r4}	; 02325AB2
	pop {r3}	; 02325AB4
	bx r3	; 02325AB6
pool_02325AB8:
loc_02325AB8:
	.word REG_BLDCNT_SUB	; 02325AB8
pool_02325ABC:
loc_02325ABC:
	.word REG_BLDALPHA_SUB	; 02325ABC
pool_02325AC0:
loc_02325AC0:
	.word REG_DISPCNT_B	; 02325AC0
pool_02325AC4:
loc_02325AC4:
	.word 0xFFFFE0FF	; 02325AC4

; ===== function loc_02325AC8 =====
loc_02325AC8:
	push {r4,r5,lr}	; 02325AC8
	sub sp,#0x4	; 02325ACA
	add r5,r1,#0x0	; 02325ACC
	mov r4,#0x0	; 02325ACE
	str r4,[sp,#0x0]	; 02325AD0
	ldr r0,[pool_02325B80]	; 02325AD2
	mov r1,#0x10	; 02325AD4
	ldr r2,[r5,#0xc]	; 02325AD6
	add r3,r1,#0x0	; 02325AD8
	bl loc_0232DBC0	; 02325ADA
	bl loc_02324F90	; 02325ADE
	cmp r0,#0x0	; 02325AE2
	bne loc_02325AF6	; 02325AE4
	ldr r0,[r5,#0x38]	; 02325AE6
	lsl r0,r0,#0x1a	; 02325AE8
	lsr r4,r0,#0x1f	; 02325AEA
	mov r0,#0x0	; 02325AEC
	str r0,[r5,#0x0]	; 02325AEE
	str r0,[r5,#0x4]	; 02325AF0
	str r0,[r5,#0x30]	; 02325AF2
	b loc_02325B76	; 02325AF4
loc_02325AF6:
	bl loc_02324FA4	; 02325AF6
	cmp r0,#0x0	; 02325AFA
	bne loc_02325B76	; 02325AFC
	lsl r0,r4,#0	; 02325AFE
	bl loc_02325308	; 02325B00
	cmp r0,#0x0	; 02325B04
	beq loc_02325B32	; 02325B06
	mov r0,#0x1b	; 02325B08
	bl loc_0232365C	; 02325B0A
	bl loc_02324FB0	; 02325B0E
	lsl r0,r4,#0	; 02325B12
	bl loc_02322A08	; 02325B14
	add r2,r5,#0x0	; 02325B18
	add r2,#0x38	; 02325B1A
	ldr r1,[r2,#0x0]	; 02325B1C
	mov r0,#0x20	; 02325B1E
	orr r1,r0	; 02325B20
	str r1,[r2,#0x0]	; 02325B22
	mov r0,#0x9	; 02325B24
	str r0,[r5,#0x34]	; 02325B26
	bl loc_02326568	; 02325B28
	bl loc_023268B0	; 02325B2C
	b loc_02325B76	; 02325B30
loc_02325B32:
	mov r0,#0x1	; 02325B32
	bl loc_02325308	; 02325B34
	cmp r0,#0x0	; 02325B38
	beq loc_02325B58	; 02325B3A
	lsl r0,r4,#0	; 02325B3C
	str r0,[r5,#0x4]	; 02325B3E
	add r0,r5,#0x0	; 02325B40
	mov r1,#0x5	; 02325B42
	bl loc_02326168	; 02325B44
	mov r0,#0x20	; 02325B48
	bl loc_0232365C	; 02325B4A
	bl loc_02324FB0	; 02325B4E
	mov r0,#0x4	; 02325B52
	str r0,[r5,#0x34]	; 02325B54
	b loc_02325B76	; 02325B56
loc_02325B58:
	add r0,r5,#0x0	; 02325B58
	bl loc_023261B4	; 02325B5A
	cmp r0,#0x0	; 02325B5E
	beq loc_02325B76	; 02325B60
	lsl r0,r4,#0	; 02325B62
	str r0,[r5,#0x4]	; 02325B64
	add r0,r5,#0x0	; 02325B66
	mov r1,#0x5	; 02325B68
	bl loc_02326168	; 02325B6A
	bl loc_02324FB0	; 02325B6E
	mov r0,#0x4	; 02325B72
	str r0,[r5,#0x34]	; 02325B74
loc_02325B76:
	add r0,r4,#0x0	; 02325B76
	add sp,#0x4	; 02325B78
	pop {r4,r5}	; 02325B7A
	pop {r3}	; 02325B7C
	bx r3	; 02325B7E
pool_02325B80:
loc_02325B80:
	.word REG_BLDCNT_SUB	; 02325B80

; ===== function loc_02325B84 =====
loc_02325B84:
	push {r4,lr}	; 02325B84
	sub sp,#0x8	; 02325B86
	add r4,r0,#0x0	; 02325B88
	ldr r0,[r4,#0x0]	; 02325B8A
	cmp r0,#0x0	; 02325B8C
	bne loc_02325BA8	; 02325B8E
	mov r0,#0x0	; 02325B90
	str r0,[sp,#0x0]	; 02325B92
	ldr r0,[pool_02325BF0]	; 02325B94
	mov r1,#0x10	; 02325B96
	ldr r2,[r4,#0xc]	; 02325B98
	add r3,r1,#0x0	; 02325B9A
	bl loc_0232DBC0	; 02325B9C
	ldr r0,[r4,#0x0]	; 02325BA0
	add r0,r0,#0x1	; 02325BA2
	str r0,[r4,#0x0]	; 02325BA4
	b loc_02325BE8	; 02325BA6
loc_02325BA8:
	cmp r0,#0xf	; 02325BA8
	bgt loc_02325BC8	; 02325BAA
	lsl r0,r0,#0x4	; 02325BAC
	mov r1,#0xf	; 02325BAE
	blx P1_SignedDivMod	; 02325BB0
	mov r1,#0x10	; 02325BB4
	sub r1,r1,r0	; 02325BB6
	lsl r0,r0,#0x8	; 02325BB8
	orr r1,r0	; 02325BBA
	ldr r0,[pool_02325BF4]	; 02325BBC
	strh r1,[r0,#0x0]	; 02325BBE
	ldr r0,[r4,#0x0]	; 02325BC0
	add r0,r0,#0x1	; 02325BC2
	str r0,[r4,#0x0]	; 02325BC4
	b loc_02325BE8	; 02325BC6
loc_02325BC8:
	mov r0,#0x0	; 02325BC8
	str r0,[r4,#0x0]	; 02325BCA
	add r2,r4,#0x0	; 02325BCC
	add r2,#0x38	; 02325BCE
	ldr r1,[r2,#0x0]	; 02325BD0
	mov r0,#0x2	; 02325BD2
	bic r1,r0	; 02325BD4
	str r1,[r2,#0x0]	; 02325BD6
	mov r0,#0x38	; 02325BD8
	mov r1,#0x1	; 02325BDA
	bl loc_02324FD8	; 02325BDC
	bl loc_023252F8	; 02325BE0
	mov r0,#0x8	; 02325BE4
	str r0,[r4,#0x30]	; 02325BE6
loc_02325BE8:
	add sp,#0x8	; 02325BE8
	pop {r4}	; 02325BEA
	pop {r3}	; 02325BEC
	bx r3	; 02325BEE
pool_02325BF0:
loc_02325BF0:
	.word REG_BLDCNT_SUB	; 02325BF0
pool_02325BF4:
loc_02325BF4:
	.word REG_BLDALPHA_SUB	; 02325BF4

; ===== function loc_02325BF8 =====
loc_02325BF8:
	push {r4,r5,r6,lr}	; 02325BF8
	add r5,r0,#0x0	; 02325BFA
	ldr r1,[r5,#0x14]	; 02325BFC
	ldr r3,[r5,#0x18]	; 02325BFE
	mov r2,#0x3c	; 02325C00
	add r0,r1,#0x0	; 02325C02
	mul r0,r2	; 02325C04
	add r4,r3,r0	; 02325C06
	ldr r3,[r5,#0x10]	; 02325C08
	ldrb r0,[r3,#0x0]	; 02325C0A
	ldrb r6,[r3,#0x1]	; 02325C0C
	add r3,r0,#0x0	; 02325C0E
	mul r3,r2	; 02325C10
	add r6,r6,r3	; 02325C12
	cmp r1,r0	; 02325C14
	bcs loc_02325C1C	; 02325C16
	ldr r0,[pool_02325D24]	; 02325C18
	add r4,r4,r0	; 02325C1A
loc_02325C1C:
	ldr r0,[pool_02325D28]	; 02325C1C
	bl loc_02324088	; 02325C1E
	cmp r0,#0x0	; 02325C22
	bne loc_02325C2E	; 02325C24
	bl loc_0232405C	; 02325C26
	cmp r0,#0x0	; 02325C2A
	beq loc_02325C5A	; 02325C2C
loc_02325C2E:
	add r0,r5,#0x0	; 02325C2E
	mov r1,#0x1	; 02325C30
	bl loc_02326168	; 02325C32
	add r0,r5,#0x0	; 02325C36
	bl loc_02326128	; 02325C38
	add r0,r5,#0x0	; 02325C3C
	add r0,#0x2c	; 02325C3E
	bl loc_02323638	; 02325C40
	bl loc_023268B0	; 02325C44
	mov r0,#0x0	; 02325C48
	str r0,[r5,#0x0]	; 02325C4A
	str r0,[r5,#0x4]	; 02325C4C
	mov r0,#0x7	; 02325C4E
	str r0,[r5,#0x30]	; 02325C50
	mov r0,#0x28	; 02325C52
	bl loc_0232365C	; 02325C54
	b loc_02325D1E	; 02325C58
loc_02325C5A:
	add r6,#0x3c	; 02325C5A
	cmp r4,r6	; 02325C5C
	blt loc_02325CA0	; 02325C5E
	mov r0,#0x0	; 02325C60
	str r0,[r5,#0x0]	; 02325C62
	str r0,[r5,#0x4]	; 02325C64
	add r2,r5,#0x0	; 02325C66
	add r2,#0x38	; 02325C68
	ldr r1,[r2,#0x0]	; 02325C6A
	mov r0,#0x4	; 02325C6C
	bic r1,r0	; 02325C6E
	str r1,[r2,#0x0]	; 02325C70
	mov r0,#0x5	; 02325C72
	str r0,[r5,#0x30]	; 02325C74
	add r0,r5,#0x0	; 02325C76
	add r0,#0x3c	; 02325C78
	ldr r1,[pool_02325D2C]	; 02325C7A
	mov r2,#0x5e	; 02325C7C
	bl loc_02324ADC	; 02325C7E
	mov r0,#0x0	; 02325C82
	bl loc_023228F0	; 02325C84
	add r0,r5,#0x0	; 02325C88
	add r0,#0x2c	; 02325C8A
	bl loc_02323638	; 02325C8C
	bl loc_023268B0	; 02325C90
	bl loc_0232659C	; 02325C94
	add r0,r5,#0x0	; 02325C98
	bl loc_023265C8	; 02325C9A
	b loc_02325D1E	; 02325C9E
loc_02325CA0:
	ldr r0,[r5,#0x38]	; 02325CA0
	lsl r0,r0,#0x1c	; 02325CA2
	lsr r0,r0,#0x1f	; 02325CA4
	cmp r0,#0x0	; 02325CA6
	beq loc_02325CDC	; 02325CA8
	add r0,r5,#0x0	; 02325CAA
	bl loc_023261B4	; 02325CAC
	cmp r0,#0x0	; 02325CB0
	beq loc_02325D1E	; 02325CB2
	add r0,r5,#0x0	; 02325CB4
	mov r1,#0x5	; 02325CB6
	bl loc_02326168	; 02325CB8
	mov r0,#0x0	; 02325CBC
	str r0,[r5,#0x0]	; 02325CBE
	str r0,[r5,#0x4]	; 02325CC0
	add r2,r5,#0x0	; 02325CC2
	add r2,#0x38	; 02325CC4
	ldr r1,[r2,#0x0]	; 02325CC6
	mov r0,#0x8	; 02325CC8
	bic r1,r0	; 02325CCA
	str r1,[r2,#0x0]	; 02325CCC
	add r5,#0x2c	; 02325CCE
	add r0,r5,#0x0	; 02325CD0
	bl loc_02323638	; 02325CD2
	bl loc_023268B0	; 02325CD6
	b loc_02325D1E	; 02325CDA
loc_02325CDC:
	add r0,r5,#0x0	; 02325CDC
	bl loc_023260D4	; 02325CDE
	add r0,r5,#0x0	; 02325CE2
	bl loc_023261B4	; 02325CE4
	cmp r0,#0x0	; 02325CE8
	beq loc_02325D1E	; 02325CEA
	add r0,r5,#0x0	; 02325CEC
	mov r1,#0x1	; 02325CEE
	bl loc_02326168	; 02325CF0
	mov r0,#0x0	; 02325CF4
	str r0,[r5,#0x0]	; 02325CF6
	str r0,[r5,#0x4]	; 02325CF8
	add r2,r5,#0x0	; 02325CFA
	add r2,#0x38	; 02325CFC
	ldr r1,[r2,#0x0]	; 02325CFE
	mov r0,#0x8	; 02325D00
	orr r1,r0	; 02325D02
	str r1,[r2,#0x0]	; 02325D04
	add r0,r5,#0x0	; 02325D06
	bl loc_02326128	; 02325D08
	mov r0,#0x27	; 02325D0C
	add r5,#0x2c	; 02325D0E
	add r1,r5,#0x0	; 02325D10
	bl loc_02323644	; 02325D12
	mov r0,#0x2	; 02325D16
	mov r1,#0x0	; 02325D18
	bl loc_023268C8	; 02325D1A
loc_02325D1E:
	pop {r4,r5,r6}	; 02325D1E
	pop {r3}	; 02325D20
	bx r3	; 02325D22
pool_02325D24:
loc_02325D24:
	.word 0x000005A0	; 02325D24
pool_02325D28:
loc_02325D28:
	.word 0x00000CFF	; 02325D28
pool_02325D2C:
loc_02325D2C:
	.word 0x023A02E4	; 02325D2C

; ===== function loc_02325D30 =====
loc_02325D30:
	push {r4,lr}	; 02325D30
	add r4,r0,#0x0	; 02325D32
	ldr r0,[pool_02325DD8]	; 02325D34
	bl loc_02324088	; 02325D36
	cmp r0,#0x0	; 02325D3A
	bne loc_02325D46	; 02325D3C
	bl loc_0232405C	; 02325D3E
	cmp r0,#0x0	; 02325D42
	beq loc_02325D66	; 02325D44
loc_02325D46:
	add r0,r4,#0x0	; 02325D46
	mov r1,#0x1	; 02325D48
	bl loc_02326168	; 02325D4A
	mov r0,#0x28	; 02325D4E
	bl loc_0232365C	; 02325D50
	add r0,r4,#0x0	; 02325D54
	bl loc_02326128	; 02325D56
	mov r0,#0x7	; 02325D5A
	str r0,[r4,#0x30]	; 02325D5C
	mov r0,#0x0	; 02325D5E
	str r0,[r4,#0x0]	; 02325D60
	str r0,[r4,#0x4]	; 02325D62
	b loc_02325DD2	; 02325D64
loc_02325D66:
	add r0,r4,#0x0	; 02325D66
	bl loc_023260D4	; 02325D68
	ldr r2,[r4,#0x10]	; 02325D6C
	ldr r1,[r4,#0x14]	; 02325D6E
	ldrb r0,[r2,#0x0]	; 02325D70
	cmp r1,r0	; 02325D72
	bne loc_02325DD2	; 02325D74
	ldr r1,[r4,#0x18]	; 02325D76
	ldrb r0,[r2,#0x1]	; 02325D78
	cmp r1,r0	; 02325D7A
	bne loc_02325DD2	; 02325D7C
	add r0,r4,#0x0	; 02325D7E
	mov r1,#0x1	; 02325D80
	bl loc_02326168	; 02325D82
	mov r0,#0x1	; 02325D86
	bl loc_023228F0	; 02325D88
	add r0,r4,#0x0	; 02325D8C
	bl loc_02326128	; 02325D8E
	add r0,r4,#0x0	; 02325D92
	add r0,#0x3c	; 02325D94
	ldr r1,[pool_02325DDC]	; 02325D96
	mov r2,#0x5f	; 02325D98
	bl loc_02324ADC	; 02325D9A
	add r2,r4,#0x0	; 02325D9E
	add r2,#0x38	; 02325DA0
	ldr r1,[r2,#0x0]	; 02325DA2
	mov r0,#0x8	; 02325DA4
	orr r1,r0	; 02325DA6
	str r1,[r2,#0x0]	; 02325DA8
	ldr r1,[r2,#0x0]	; 02325DAA
	mov r0,#0x4	; 02325DAC
	orr r1,r0	; 02325DAE
	str r1,[r2,#0x0]	; 02325DB0
	mov r0,#0x0	; 02325DB2
	str r0,[r4,#0x0]	; 02325DB4
	str r0,[r4,#0x4]	; 02325DB6
	mov r0,#0x6	; 02325DB8
	str r0,[r4,#0x30]	; 02325DBA
	mov r0,#0x27	; 02325DBC
	add r4,#0x2c	; 02325DBE
	add r1,r4,#0x0	; 02325DC0
	bl loc_02323644	; 02325DC2
	mov r0,#0x2	; 02325DC6
	mov r1,#0x0	; 02325DC8
	bl loc_023268C8	; 02325DCA
	bl loc_02326628	; 02325DCE
loc_02325DD2:
	pop {r4}	; 02325DD2
	pop {r3}	; 02325DD4
	bx r3	; 02325DD6
pool_02325DD8:
loc_02325DD8:
	.word 0x00000CFF	; 02325DD8
pool_02325DDC:
loc_02325DDC:
	.word 0x023A02E4	; 02325DDC

; ===== function loc_02325DE0 =====
loc_02325DE0:
	push {r4,lr}	; 02325DE0
	sub sp,#0x8	; 02325DE2
	add r4,r0,#0x0	; 02325DE4
	bl loc_0232523C	; 02325DE6
	cmp r0,#0x0	; 02325DEA
	beq loc_02325E60	; 02325DEC
	ldr r0,[r4,#0x0]	; 02325DEE
	cmp r0,#0x0	; 02325DF0
	bne loc_02325E16	; 02325DF2
	mov r1,#0x10	; 02325DF4
	str r1,[sp,#0x0]	; 02325DF6
	ldr r0,[pool_02325E68]	; 02325DF8
	ldr r2,[r4,#0xc]	; 02325DFA
	mov r3,#0x0	; 02325DFC
	bl loc_0232DBC0	; 02325DFE
	add r2,r4,#0x0	; 02325E02
	add r2,#0x38	; 02325E04
	ldr r1,[r2,#0x0]	; 02325E06
	mov r0,#0x2	; 02325E08
	orr r1,r0	; 02325E0A
	str r1,[r2,#0x0]	; 02325E0C
	ldr r0,[r4,#0x0]	; 02325E0E
	add r0,r0,#0x1	; 02325E10
	str r0,[r4,#0x0]	; 02325E12
	b loc_02325E60	; 02325E14
loc_02325E16:
	cmp r0,#0xf	; 02325E16
	bgt loc_02325E36	; 02325E18
	lsl r0,r0,#0x4	; 02325E1A
	mov r1,#0xf	; 02325E1C
	blx P1_SignedDivMod	; 02325E1E
	mov r1,#0x10	; 02325E22
	sub r1,r1,r0	; 02325E24
	lsl r1,r1,#0x8	; 02325E26
	orr r0,r1	; 02325E28
	ldr r1,[pool_02325E6C]	; 02325E2A
	strh r0,[r1,#0x0]	; 02325E2C
	ldr r0,[r4,#0x0]	; 02325E2E
	add r0,r0,#0x1	; 02325E30
	str r0,[r4,#0x0]	; 02325E32
	b loc_02325E60	; 02325E34
loc_02325E36:
	mov r0,#0x0	; 02325E36
	str r0,[r4,#0x0]	; 02325E38
	ldr r0,[r4,#0x38]	; 02325E3A
	lsl r0,r0,#0x1d	; 02325E3C
	lsr r0,r0,#0x1f	; 02325E3E
	cmp r0,#0x0	; 02325E40
	beq loc_02325E56	; 02325E42
	add r2,r4,#0x0	; 02325E44
	add r2,#0x38	; 02325E46
	ldr r1,[r2,#0x0]	; 02325E48
	mov r0,#0x8	; 02325E4A
	bic r1,r0	; 02325E4C
	str r1,[r2,#0x0]	; 02325E4E
	mov r0,#0x6	; 02325E50
	str r0,[r4,#0x30]	; 02325E52
	b loc_02325E60	; 02325E54
loc_02325E56:
	add r0,r4,#0x0	; 02325E56
	bl loc_023265C8	; 02325E58
	mov r0,#0x5	; 02325E5C
	str r0,[r4,#0x30]	; 02325E5E
loc_02325E60:
	add sp,#0x8	; 02325E60
	pop {r4}	; 02325E62
	pop {r3}	; 02325E64
	bx r3	; 02325E66
pool_02325E68:
loc_02325E68:
	.word REG_BLDCNT_SUB	; 02325E68
pool_02325E6C:
loc_02325E6C:
	.word REG_BLDALPHA_SUB	; 02325E6C

; ===== function loc_02325E70 =====
loc_02325E70:
	push {r4,lr}	; 02325E70
	sub sp,#0x8	; 02325E72
	add r4,r0,#0x0	; 02325E74
	ldr r0,[r4,#0x0]	; 02325E76
	cmp r0,#0x0	; 02325E78
	bne loc_02325EA8	; 02325E7A
	ldr r2,[pool_02325ED8]	; 02325E7C
	ldr r3,[r2,#0x0]	; 02325E7E
	ldr r0,[pool_02325EDC]	; 02325E80
	and r3,r0	; 02325E82
	ldr r1,[r4,#0x8]	; 02325E84
	ldr r0,[r4,#0xc]	; 02325E86
	orr r1,r0	; 02325E88
	lsl r0,r1,#0x8	; 02325E8A
	orr r3,r0	; 02325E8C
	str r3,[r2,#0x0]	; 02325E8E
	mov r0,#0x10	; 02325E90
	str r0,[sp,#0x0]	; 02325E92
	ldr r0,[pool_02325EE0]	; 02325E94
	ldr r1,[r4,#0xc]	; 02325E96
	ldr r2,[r4,#0x8]	; 02325E98
	mov r3,#0x0	; 02325E9A
	bl loc_0232DBC0	; 02325E9C
	ldr r0,[r4,#0x0]	; 02325EA0
	add r0,r0,#0x1	; 02325EA2
	str r0,[r4,#0x0]	; 02325EA4
	b loc_02325ED0	; 02325EA6
loc_02325EA8:
	cmp r0,#0xf	; 02325EA8
	bgt loc_02325EC8	; 02325EAA
	lsl r0,r0,#0x4	; 02325EAC
	mov r1,#0xf	; 02325EAE
	blx P1_SignedDivMod	; 02325EB0
	mov r1,#0x10	; 02325EB4
	sub r1,r1,r0	; 02325EB6
	lsl r1,r1,#0x8	; 02325EB8
	orr r0,r1	; 02325EBA
	ldr r1,[pool_02325EE4]	; 02325EBC
	strh r0,[r1,#0x0]	; 02325EBE
	ldr r0,[r4,#0x0]	; 02325EC0
	add r0,r0,#0x1	; 02325EC2
	str r0,[r4,#0x0]	; 02325EC4
	b loc_02325ED0	; 02325EC6
loc_02325EC8:
	mov r0,#0x0	; 02325EC8
	str r0,[r4,#0x0]	; 02325ECA
	mov r0,#0x4	; 02325ECC
	str r0,[r4,#0x30]	; 02325ECE
loc_02325ED0:
	add sp,#0x8	; 02325ED0
	pop {r4}	; 02325ED2
	pop {r3}	; 02325ED4
	bx r3	; 02325ED6
pool_02325ED8:
loc_02325ED8:
	.word REG_DISPCNT_B	; 02325ED8
pool_02325EDC:
loc_02325EDC:
	.word 0xFFFFE0FF	; 02325EDC
pool_02325EE0:
loc_02325EE0:
	.word REG_BLDCNT_SUB	; 02325EE0
pool_02325EE4:
loc_02325EE4:
	.word REG_BLDALPHA_SUB	; 02325EE4

; ===== function loc_02325EE8 =====
loc_02325EE8:
	push {r4,lr}	; 02325EE8
	add r4,r1,#0x0	; 02325EEA
	bl loc_02324F90	; 02325EEC
	cmp r0,#0x0	; 02325EF0
	bne loc_02325EFE	; 02325EF2
	mov r0,#0x0	; 02325EF4
	str r0,[r4,#0x30]	; 02325EF6
	mov r0,#0x3	; 02325EF8
	str r0,[r4,#0x34]	; 02325EFA
	b loc_02325F4E	; 02325EFC
loc_02325EFE:
	bl loc_02324FA4	; 02325EFE
	cmp r0,#0x0	; 02325F02
	bne loc_02325F4E	; 02325F04
	mov r0,#0x0	; 02325F06
	bl loc_02325308	; 02325F08
	cmp r0,#0x0	; 02325F0C
	beq loc_02325F2C	; 02325F0E
	mov r0,#0x1a	; 02325F10
	bl loc_0232365C	; 02325F12
	add r4,#0x38	; 02325F16
	ldr r1,[r4,#0x0]	; 02325F18
	mov r0,#0x1	; 02325F1A
	bic r1,r0	; 02325F1C
	orr r1,r0	; 02325F1E
	str r1,[r4,#0x0]	; 02325F20
	bl loc_02324FB0	; 02325F22
	bl loc_02326888	; 02325F26
	b loc_02325F4E	; 02325F2A
loc_02325F2C:
	mov r0,#0x1	; 02325F2C
	bl loc_02325308	; 02325F2E
	cmp r0,#0x0	; 02325F32
	beq loc_02325F4E	; 02325F34
	mov r0,#0x20	; 02325F36
	bl loc_0232365C	; 02325F38
	add r4,#0x38	; 02325F3C
	ldr r1,[r4,#0x0]	; 02325F3E
	mov r0,#0x1	; 02325F40
	bic r1,r0	; 02325F42
	str r1,[r4,#0x0]	; 02325F44
	bl loc_02324FB0	; 02325F46
	bl loc_02326898	; 02325F4A
loc_02325F4E:
	pop {r4}	; 02325F4E
	pop {r3}	; 02325F50
	bx r3	; 02325F52

; ===== function loc_02325F54 =====
loc_02325F54:
	push {r4,r5,lr}	; 02325F54
	sub sp,#0x4	; 02325F56
	add r5,r1,#0x0	; 02325F58
	mov r4,#0x0	; 02325F5A
	bl loc_02324F90	; 02325F5C
	cmp r0,#0x0	; 02325F60
	bne loc_02325F7C	; 02325F62
	ldr r0,[r5,#0x38]	; 02325F64
	lsl r0,r0,#0x1a	; 02325F66
	lsr r4,r0,#0x1f	; 02325F68
	add r0,r5,#0x0	; 02325F6A
	add r0,#0x3c	; 02325F6C
	ldr r1,[pool_02325FD8]	; 02325F6E
	mov r2,#0x5e	; 02325F70
	bl loc_02324ADC	; 02325F72
	mov r0,#0x0	; 02325F76
	str r0,[r5,#0x30]	; 02325F78
	b loc_02325FCC	; 02325F7A
loc_02325F7C:
	bl loc_02324FA4	; 02325F7C
	cmp r0,#0x0	; 02325F80
	bne loc_02325FCC	; 02325F82
	lsl r0,r4,#0	; 02325F84
	bl loc_02325308	; 02325F86
	cmp r0,#0x0	; 02325F8A
	beq loc_02325FAE	; 02325F8C
	mov r0,#0x1b	; 02325F8E
	bl loc_0232365C	; 02325F90
	bl loc_02324FB0	; 02325F94
	mov r0,#0x1	; 02325F98
	bl loc_0232C368	; 02325F9A
	cmp r0,#0x0	; 02325F9E
	beq loc_02325FA8	; 02325FA0
	mov r0,#0x2	; 02325FA2
	str r0,[r5,#0x34]	; 02325FA4
	b loc_02325FCC	; 02325FA6
loc_02325FA8:
	mov r0,#0x3	; 02325FA8
	str r0,[r5,#0x34]	; 02325FAA
	b loc_02325FCC	; 02325FAC
loc_02325FAE:
	mov r0,#0x1	; 02325FAE
	bl loc_02325308	; 02325FB0
	cmp r0,#0x0	; 02325FB4
	beq loc_02325FCC	; 02325FB6
	mov r0,#0x20	; 02325FB8
	bl loc_0232365C	; 02325FBA
	add r5,#0x38	; 02325FBE
	ldr r1,[r5,#0x0]	; 02325FC0
	mov r0,#0x20	; 02325FC2
	orr r1,r0	; 02325FC4
	str r1,[r5,#0x0]	; 02325FC6
	bl loc_02324FB0	; 02325FC8
loc_02325FCC:
	add r0,r4,#0x0	; 02325FCC
	add sp,#0x4	; 02325FCE
	pop {r4,r5}	; 02325FD0
	pop {r3}	; 02325FD2
	bx r3	; 02325FD4
	.byte 0xC0, 0x46	; 02325FD8
pool_02325FD8:
loc_02325FD8:
	.word 0x023A02E4	; 02325FD8

; ===== function loc_02325FDC =====
loc_02325FDC:
	ldr r3,[pool_02325FFC]	; 02325FDC
	str r3,[r0,#0x10]	; 02325FDE
	str r1,[r0,#0x8]	; 02325FE0
	str r2,[r0,#0xc]	; 02325FE2
	add r3,r0,#0x0	; 02325FE4
	add r3,#0x38	; 02325FE6
	ldr r2,[r3,#0x0]	; 02325FE8
	mov r1,#0x10	; 02325FEA
	orr r2,r1	; 02325FEC
	str r2,[r3,#0x0]	; 02325FEE
	mov r1,#0x0	; 02325FF0
	str r1,[r0,#0x0]	; 02325FF2
	str r1,[r0,#0x4]	; 02325FF4
	add r0,#0x2c	; 02325FF6
	ldr r3,[pool_02326000]	; 02325FF8
	bx r3	; 02325FFA
pool_02325FFC:
loc_02325FFC:
	.word 0x027FFCD2	; 02325FFC
pool_02326000:
loc_02326000:
	.word loc_02323654 + 1	; 02326000

; ===== function loc_02326004 =====
loc_02326004:
	push {r4,r5,r6,r7,lr}	; 02326004
	sub sp,#0x1fc	; 02326006
	sub sp,#0x10	; 02326008
	add r5,r0,#0x0	; 0232600A
	ldr r1,[r5,#0x38]	; 0232600C
	lsl r0,r1,#0x1d	; 0232600E
	lsr r0,r0,#0x1f	; 02326010
	cmp r0,#0x0	; 02326012
	beq loc_023260BA	; 02326014
	ldr r0,[r5,#0x1c]	; 02326016
	cmp r0,#0x0	; 02326018
	bne loc_023260B0	; 0232601A
	lsl r0,r1,#0x1b	; 0232601C
	lsr r0,r0,#0x1f	; 0232601E
	cmp r0,#0x0	; 02326020
	bne loc_023260BA	; 02326022
	add r0,sp,#0x8	; 02326024
	ldr r1,[pool_023260C4]	; 02326026
	bl loc_0232CDF4	; 02326028
	mov r0,#0x60	; 0232602C
	bl loc_02324D1C	; 0232602E
	add r7,r0,#0x0	; 02326032
	mov r6,#0x0	; 02326034
	ldr r2,[r5,#0x10]	; 02326036
	ldrb r1,[r2,#0x0]	; 02326038
	ldr r0,[r5,#0x14]	; 0232603A
	ldr r3,[r5,#0x18]	; 0232603C
	ldrb r2,[r2,#0x1]	; 0232603E
	sub r4,r3,r2	; 02326040
	sub r3,r0,r1	; 02326042
	mov r2,#0x3c	; 02326044
	mul r3,r2	; 02326046
	add r4,r4,r3	; 02326048
	cmp r0,r1	; 0232604A
	bcs loc_02326052	; 0232604C
	ldr r0,[pool_023260C8]	; 0232604E
	add r4,r4,r0	; 02326050
loc_02326052:
	add r0,r4,#0x0	; 02326052
	mov r1,#0x3c	; 02326054
	blx P1_SignedDivMod	; 02326056
	add r1,r0,#0x0	; 0232605A
	add r0,sp,#0x0	; 0232605C
	bl loc_02325980	; 0232605E
	add r0,r4,#0x0	; 02326062
	mov r1,#0x3c	; 02326064
	blx P1_SignedDivMod	; 02326066
	add r0,sp,#0x4	; 0232606A
	bl loc_02325980	; 0232606C
	mov r2,#0x0	; 02326070
	add r4,sp,#0x8	; 02326072
	b loc_0232608C	; 02326074
loc_02326076:
	ldr r3,[pool_023260CC]	; 02326076
	cmp r1,r3	; 02326078
	bne loc_02326088	; 0232607A
	lsl r3,r6,#0x1	; 0232607C
	add r6,r6,#0x1	; 0232607E
	add r1,sp,#0x0	; 02326080
	ldrh r1,[r1,r3]	; 02326082
	strh r1,[r4,r0]	; 02326084
	b loc_0232608A	; 02326086
loc_02326088:
	strh r1,[r4,r0]	; 02326088
loc_0232608A:
	add r2,r2,#0x1	; 0232608A
loc_0232608C:
	lsl r0,r2,#0x1	; 0232608C
	ldrh r1,[r7,r0]	; 0232608E
	cmp r1,#0x0	; 02326090
	beq loc_0232609A	; 02326092
	ldr r3,[pool_023260D0]	; 02326094
	cmp r2,r3	; 02326096
	blt loc_02326076	; 02326098
loc_0232609A:
	add r0,r5,#0x0	; 0232609A
	add r0,#0x3c	; 0232609C
	add r1,sp,#0x8	; 0232609E
	bl loc_02324A80	; 023260A0
	add r5,#0x38	; 023260A4
	ldr r1,[r5,#0x0]	; 023260A6
	mov r0,#0x10	; 023260A8
	orr r1,r0	; 023260AA
	str r1,[r5,#0x0]	; 023260AC
	b loc_023260BA	; 023260AE
loc_023260B0:
	add r5,#0x38	; 023260B0
	ldr r1,[r5,#0x0]	; 023260B2
	mov r0,#0x10	; 023260B4
	bic r1,r0	; 023260B6
	str r1,[r5,#0x0]	; 023260B8
loc_023260BA:
	add sp,#0x1fc	; 023260BA
	add sp,#0x10	; 023260BC
	pop {r4,r5,r6,r7}	; 023260BE
	pop {r3}	; 023260C0
	bx r3	; 023260C2
pool_023260C4:
loc_023260C4:
	.word 0x00000200	; 023260C4
pool_023260C8:
loc_023260C8:
	.word 0x000005A0	; 023260C8
pool_023260CC:
loc_023260CC:
	.word 0x000025CF	; 023260CC
pool_023260D0:
loc_023260D0:
	.word 0x00000100	; 023260D0

; ===== function loc_023260D4 =====
loc_023260D4:
	push {lr}	; 023260D4
	sub sp,#0x4	; 023260D6
	ldr r2,[r0,#0x4]	; 023260D8
	ldr r1,[pool_023260F4]	; 023260DA
	cmp r2,r1	; 023260DC
	ble loc_023260E6	; 023260DE
	bl loc_023260F8	; 023260E0
	b loc_023260EE	; 023260E4
loc_023260E6:
	add r1,r0,#0x4	; 023260E6
	ldr r0,[r1,#0x0]	; 023260E8
	add r0,r0,#0x1	; 023260EA
	str r0,[r1,#0x0]	; 023260EC
loc_023260EE:
	add sp,#0x4	; 023260EE
	pop {r3}	; 023260F0
	bx r3	; 023260F2
pool_023260F4:
loc_023260F4:
	.word 0x0000012C	; 023260F4

; ===== function loc_023260F8 =====
loc_023260F8:
	push {lr}	; 023260F8
	sub sp,#0x4	; 023260FA
	bl loc_02325694	; 023260FC
	ldr r0,[r0,#0x0]	; 02326100
	lsl r0,r0,#0x15	; 02326102
	lsr r0,r0,#0x1f	; 02326104
	cmp r0,#0x0	; 02326106
	beq loc_02326112	; 02326108
	mov r0,#0x2	; 0232610A
	mov r1,#0x0	; 0232610C
	bl loc_0232F760	; 0232610E
loc_02326112:
	bl loc_02325694	; 02326112
	ldr r2,[r0,#0x0]	; 02326116
	ldr r1,[pool_02326124]	; 02326118
	and r2,r1	; 0232611A
	str r2,[r0,#0x0]	; 0232611C
	add sp,#0x4	; 0232611E
	pop {r3}	; 02326120
	bx r3	; 02326122
pool_02326124:
loc_02326124:
	.word 0xFFFFFBFF	; 02326124

; ===== function loc_02326128 =====
loc_02326128:
	push {lr}	; 02326128
	sub sp,#0x4	; 0232612A
	bl loc_02325694	; 0232612C
	ldr r0,[r0,#0x0]	; 02326130
	lsl r0,r0,#0x16	; 02326132
	lsr r0,r0,#0x1f	; 02326134
	cmp r0,#0x0	; 02326136
	beq loc_02326150	; 02326138
	bl loc_02325694	; 0232613A
	ldr r0,[r0,#0x0]	; 0232613E
	lsl r0,r0,#0x15	; 02326140
	lsr r0,r0,#0x1f	; 02326142
	cmp r0,#0x0	; 02326144
	bne loc_02326150	; 02326146
	mov r0,#0x2	; 02326148
	mov r1,#0x1	; 0232614A
	bl loc_0232F760	; 0232614C
loc_02326150:
	bl loc_02325694	; 02326150
	ldr r2,[r0,#0x0]	; 02326154
	ldr r1,[pool_02326164]	; 02326156
	orr r2,r1	; 02326158
	str r2,[r0,#0x0]	; 0232615A
	add sp,#0x4	; 0232615C
	pop {r3}	; 0232615E
	bx r3	; 02326160
	.byte 0xC0, 0x46	; 02326164
pool_02326164:
loc_02326164:
	.word 0x00000400	; 02326164

; ===== function loc_02326168 =====
loc_02326168:
	push {r4,r5,r6,lr}	; 02326168
	add r4,r0,#0x0	; 0232616A
	add r3,r1,#0x0	; 0232616C
	add r6,r4,#0x0	; 0232616E
	add r6,#0x14	; 02326170
	add r5,r4,#0x0	; 02326172
	add r5,#0x20	; 02326174
	add r2,r5,#0x0	; 02326176
	ldmia r6!,{r0,r1}	; 02326178
	stmia r5!,{r0,r1}	; 0232617A
	ldr r0,[r6,#0x0]	; 0232617C
	str r0,[r5,#0x0]	; 0232617E
	ldr r0,[r4,#0x24]	; 02326180
	add r0,r0,r3	; 02326182
	cmp r0,#0x3c	; 02326184
	bcc loc_023261A6	; 02326186
	ldr r0,[r4,#0x20]	; 02326188
	cmp r0,#0x17	; 0232618A
	bne loc_02326194	; 0232618C
	mov r0,#0x0	; 0232618E
	str r0,[r4,#0x20]	; 02326190
	b loc_0232619A	; 02326192
loc_02326194:
	ldr r0,[r2,#0x0]	; 02326194
	add r0,r0,#0x1	; 02326196
	str r0,[r2,#0x0]	; 02326198
loc_0232619A:
	add r4,#0x24	; 0232619A
	ldr r0,[r4,#0x0]	; 0232619C
	sub r3,#0x3c	; 0232619E
	add r0,r0,r3	; 023261A0
	str r0,[r4,#0x0]	; 023261A2
	b loc_023261AE	; 023261A4
loc_023261A6:
	add r4,#0x24	; 023261A6
	ldr r0,[r4,#0x0]	; 023261A8
	add r0,r0,r3	; 023261AA
	str r0,[r4,#0x0]	; 023261AC
loc_023261AE:
	pop {r4,r5,r6}	; 023261AE
	pop {r3}	; 023261B0
	bx r3	; 023261B2

; ===== function loc_023261B4 =====
loc_023261B4:
	ldr r2,[r0,#0x20]	; 023261B4
	ldr r1,[r0,#0x14]	; 023261B6
	cmp r2,r1	; 023261B8
	bne loc_023261D0	; 023261BA
	ldr r2,[r0,#0x24]	; 023261BC
	ldr r1,[r0,#0x18]	; 023261BE
	cmp r2,r1	; 023261C0
	bne loc_023261D0	; 023261C2
	ldr r1,[r0,#0x28]	; 023261C4
	ldr r0,[r0,#0x1c]	; 023261C6
	cmp r1,r0	; 023261C8
	bne loc_023261D0	; 023261CA
	mov r0,#0x1	; 023261CC
	bx lr	; 023261CE
loc_023261D0:
	mov r0,#0x0	; 023261D0
	bx lr	; 023261D2

; ===== function loc_023261D4 =====
loc_023261D4:
	push {lr}	; 023261D4
	sub sp,#0x4	; 023261D6
	ldr r1,[pool_0232621C]	; 023261D8
	ldrh r1,[r1,#0x0]	; 023261DA
	lsl r1,r1,#0x1d	; 023261DC
	lsr r1,r1,#0x1d	; 023261DE
	cmp r1,#0x5	; 023261E0
	bhi loc_023261FE	; 023261E2
	add r1,r1,r1	; 023261E4
P1_SwitchIndexPC_023261E4:
	add r1,pc	; 023261E6
	ldrh r1,[r1,#(P1_SwitchTable_023261E4 - (P1_SwitchIndexPC_023261E4 + 4))]	; 023261E8
	lsl r1,r1,#0x10	; 023261EA
	asr r1,r1,#0x10	; 023261EC
P1_SwitchTargetPC_023261E4:
	add r1,pc	; 023261EE
	bx r1	; 023261F0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023261E4:
	.halfword (loc_023261FE + 1) - (P1_SwitchTargetPC_023261E4 + 4)
	.halfword (loc_023261FE + 1) - (P1_SwitchTargetPC_023261E4 + 4)
	.halfword (loc_0232620E + 1) - (P1_SwitchTargetPC_023261E4 + 4)
	.halfword (loc_02326206 + 1) - (P1_SwitchTargetPC_023261E4 + 4)
	.halfword (loc_0232620E + 1) - (P1_SwitchTargetPC_023261E4 + 4)
	.halfword (loc_0232620E + 1) - (P1_SwitchTargetPC_023261E4 + 4)
P1_SwitchTable_023261E4End:
loc_023261FE:
	ldr r1,[pool_02326220]	; 023261FE
	bl P1_Utf16StrCpy	; 02326200
	b loc_02326214	; 02326204
loc_02326206:
	ldr r1,[pool_02326224]	; 02326206
	bl P1_Utf16StrCpy	; 02326208
	b loc_02326214	; 0232620C
loc_0232620E:
	ldr r1,[pool_02326228]	; 0232620E
	bl P1_Utf16StrCpy	; 02326210
loc_02326214:
	add sp,#0x4	; 02326214
	pop {r3}	; 02326216
	bx r3	; 02326218
	.byte 0xC0, 0x46	; 0232621C
pool_0232621C:
loc_0232621C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 0232621C
pool_02326220:
loc_02326220:
	.word 0x02330C90	; 02326220
pool_02326224:
loc_02326224:
	.word 0x02330C9C	; 02326224
pool_02326228:
loc_02326228:
	.word 0x02330CAC	; 02326228

; ===== function loc_0232622C =====
P1_Entry_0232622C:
	push {lr}	; 0232622C
	sub sp,#0x4	; 0232622E
	ldr r1,[pool_0232627C]	; 02326230
	ldrh r1,[r1,#0x0]	; 02326232
	lsl r1,r1,#0x1d	; 02326234
	lsr r1,r1,#0x1d	; 02326236
	cmp r1,#0x5	; 02326238
	bhi loc_02326256	; 0232623A
	add r1,r1,r1	; 0232623C
P1_SwitchIndexPC_0232623C:
	add r1,pc	; 0232623E
	ldrh r1,[r1,#(P1_SwitchTable_0232623C - (P1_SwitchIndexPC_0232623C + 4))]	; 02326240
	lsl r1,r1,#0x10	; 02326242
	asr r1,r1,#0x10	; 02326244
P1_SwitchTargetPC_0232623C:
	add r1,pc	; 02326246
	bx r1	; 02326248
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232623C:
	.halfword (loc_02326256 + 1) - (P1_SwitchTargetPC_0232623C + 4)
	.halfword (loc_0232625E + 1) - (P1_SwitchTargetPC_0232623C + 4)
	.halfword (loc_0232626E + 1) - (P1_SwitchTargetPC_0232623C + 4)
	.halfword (loc_02326266 + 1) - (P1_SwitchTargetPC_0232623C + 4)
	.halfword (loc_0232626E + 1) - (P1_SwitchTargetPC_0232623C + 4)
	.halfword (loc_0232626E + 1) - (P1_SwitchTargetPC_0232623C + 4)
P1_SwitchTable_0232623CEnd:
loc_02326256:
	ldr r1,[pool_02326280]	; 02326256
	bl P1_Utf16StrCpy	; 02326258
	b loc_02326274	; 0232625C
loc_0232625E:
	ldr r1,[pool_02326284]	; 0232625E
	bl P1_Utf16StrCpy	; 02326260
	b loc_02326274	; 02326264
loc_02326266:
	ldr r1,[pool_02326288]	; 02326266
	bl P1_Utf16StrCpy	; 02326268
	b loc_02326274	; 0232626C
loc_0232626E:
	ldr r1,[pool_0232628C]	; 0232626E
	bl P1_Utf16StrCpy	; 02326270
loc_02326274:
	add sp,#0x4	; 02326274
	pop {r3}	; 02326276
	bx r3	; 02326278
	.byte 0xC0, 0x46	; 0232627C
pool_0232627C:
loc_0232627C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 0232627C
pool_02326280:
loc_02326280:
	.word 0x02330CB8	; 02326280
pool_02326284:
loc_02326284:
	.word 0x02330CD0	; 02326284
pool_02326288:
loc_02326288:
	.word 0x02330CE8	; 02326288
pool_0232628C:
loc_0232628C:
	.word 0x02330D00	; 0232628C

; ===== function loc_02326290 =====
loc_02326290:
	push {r4,r5,r6,lr}	; 02326290
	sub sp,#0x18	; 02326292
	add r5,r0,#0x0	; 02326294
	add r4,r2,#0x0	; 02326296
	add r6,r3,#0x0	; 02326298
	add r0,sp,#0x10	; 0232629A
	bl loc_02325980	; 0232629C
	add r0,sp,#0x8	; 023262A0
	add r1,r4,#0x0	; 023262A2
	bl loc_02325980	; 023262A4
	add r0,sp,#0x0	; 023262A8
	add r1,r6,#0x0	; 023262AA
	bl loc_02325980	; 023262AC
	add r0,r5,#0x0	; 023262B0
	mov r1,#0x59	; 023262B2
	bl P1_Utf16StrChr	; 023262B4
	cmp r0,#0x0	; 023262B8
	beq loc_023262C4	; 023262BA
	add r1,sp,#0x10	; 023262BC
	mov r2,#0x2	; 023262BE
	bl P1_Utf16StrNCpy	; 023262C0
loc_023262C4:
	add r0,r5,#0x0	; 023262C4
	mov r1,#0x4d	; 023262C6
	bl P1_Utf16StrChr	; 023262C8
	cmp r0,#0x0	; 023262CC
	beq loc_023262D8	; 023262CE
	add r1,sp,#0x8	; 023262D0
	mov r2,#0x2	; 023262D2
	bl P1_Utf16StrNCpy	; 023262D4
loc_023262D8:
	add r0,r5,#0x0	; 023262D8
	mov r1,#0x44	; 023262DA
	bl P1_Utf16StrChr	; 023262DC
	cmp r0,#0x0	; 023262E0
	beq loc_023262EC	; 023262E2
	add r1,sp,#0x0	; 023262E4
	mov r2,#0x2	; 023262E6
	bl P1_Utf16StrNCpy	; 023262E8
loc_023262EC:
	add sp,#0x18	; 023262EC
	pop {r4,r5,r6}	; 023262EE
	pop {r3}	; 023262F0
	bx r3	; 023262F2

; ===== function loc_023262F4 =====
P1_Entry_023262F4:
	push {r4,lr}	; 023262F4
	add r4,r0,#0x0	; 023262F6
	bl loc_023261D4	; 023262F8
	add r0,r4,#0x0	; 023262FC
	mov r1,#0x0	; 023262FE
	ldr r3,[pool_02326310]	; 02326300
	ldrb r2,[r3,#0x0]	; 02326302
	ldrb r3,[r3,#0x1]	; 02326304
	bl loc_02326290	; 02326306
	pop {r4}	; 0232630A
	pop {r3}	; 0232630C
	bx r3	; 0232630E
pool_02326310:
loc_02326310:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 02326310

; ===== function loc_02326314 =====
loc_02326314:
	push {r4,lr}	; 02326314
	sub sp,#0x10	; 02326316
	add r4,r0,#0x0	; 02326318
	add r0,sp,#0x0	; 0232631A
	bl loc_023269A8	; 0232631C
	add r0,r4,#0x0	; 02326320
	bl loc_023261D4	; 02326322
	add r0,r4,#0x0	; 02326326
	mov r1,#0x0	; 02326328
	ldr r2,[sp,#0x4]	; 0232632A
	ldr r3,[sp,#0x8]	; 0232632C
	bl loc_02326290	; 0232632E
	add sp,#0x10	; 02326332
	pop {r4}	; 02326334
	pop {r3}	; 02326336
	bx r3	; 02326338
	.byte 0x00, 0x00	; 0232633A
P1_Entry_0232633C:
	push {r4,lr}	; 0232633C
	sub sp,#0x10	; 0232633E
	add r4,r0,#0x0	; 02326340
	add r0,sp,#0x0	; 02326342
	bl loc_023269A8	; 02326344
	add r0,r4,#0x0	; 02326348
	bl P1_Entry_0232622C	; 0232634A
	add r0,r4,#0x0	; 0232634E
	ldr r1,[sp,#0x0]	; 02326350
	ldr r2,[sp,#0x4]	; 02326352
	ldr r3,[sp,#0x8]	; 02326354
	bl loc_02326290	; 02326356
	add sp,#0x10	; 0232635A
	pop {r4}	; 0232635C
	pop {r3}	; 0232635E
	bx r3	; 02326360
	.byte 0x00, 0x00	; 02326362

; ===== function loc_02326364 =====
loc_02326364:
	push {r4,lr}	; 02326364
	sub sp,#0x10	; 02326366
	add r4,r0,#0x0	; 02326368
	add r0,sp,#0x0	; 0232636A
	bl loc_023269C4	; 0232636C
	add r0,r4,#0x0	; 02326370
	ldr r1,[sp,#0x0]	; 02326372
	bl loc_02325980	; 02326374
	mov r1,#0x3a	; 02326378
	strh r1,[r0,#0x0]	; 0232637A
	add r0,r0,#0x2	; 0232637C
	ldr r1,[sp,#0x4]	; 0232637E
	bl loc_02325980	; 02326380
	add sp,#0x10	; 02326384
	pop {r4}	; 02326386
	pop {r3}	; 02326388
	bx r3	; 0232638A
P1_Entry_0232638C:
	ldr r0,[pool_0232639C]	; 0232638C
	ldrb r0,[r0,#0x0]	; 0232638E
	lsl r0,r0,#0x1c	; 02326390
	lsr r0,r0,#0x1c	; 02326392
	cmp r0,#0x10	; 02326394
	blt P1_Entry_0232639A	; 02326396
	mov r0,#0x1	; 02326398
P1_Entry_0232639A:
	bx lr	; 0232639A
pool_0232639C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsThemeOffset	; 0232639C
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x48, 0x09, 0x49, 0x02, 0x1C, 0x34, 0x32, 0x12, 0x78, 0x52, 0x00	; 023263A0
	.byte 0x07, 0xF0, 0xA8, 0xEF, 0x00, 0x22, 0x04, 0x48, 0x34, 0x30, 0x00, 0x78, 0x41, 0x00, 0x03, 0x48	; 023263B0
	.byte 0x42, 0x52, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x9C, 0xFC, 0x7F, 0x02, 0xB0, 0x50, 0x35, 0x02	; 023263C0

; ===== function loc_023263D0 =====
loc_023263D0:
	push {lr}	; 023263D0
	sub sp,#0x4	; 023263D2
	ldr r0,[pool_023263F4]	; 023263D4
	ldr r1,[pool_023263F8]	; 023263D6
	ldrb r2,[r0,#0x14]	; 023263D8
	lsl r2,r2,#0x1	; 023263DA
	blx loc_0232E304	; 023263DC
	mov r2,#0x0	; 023263E0
	ldr r0,[pool_023263F4]	; 023263E2
	ldrb r0,[r0,#0x14]	; 023263E4
	lsl r1,r0,#0x1	; 023263E6
	ldr r0,[pool_023263F8]	; 023263E8
	strh r2,[r0,r1]	; 023263EA
	add sp,#0x4	; 023263EC
	pop {r3}	; 023263EE
	bx r3	; 023263F0
	.byte 0xC0, 0x46	; 023263F4
pool_023263F4:
loc_023263F4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsNameOffset	; 023263F4
pool_023263F8:
loc_023263F8:
	.word P1_BssStart + 0x24218	; 023263F8

; ===== function loc_023263FC =====
loc_023263FC:
	push {r4,r5,r6,r7,lr}	; 023263FC
	sub sp,#0x14	; 023263FE
	add r6,r0,#0x0	; 02326400
	add r7,r1,#0x0	; 02326402
	add r5,r2,#0x0	; 02326404
	bl loc_02323DC0	; 02326406
	str r0,[sp,#0x0]	; 0232640A
	mov r4,#0x0	; 0232640C
	str r4,[sp,#0x4]	; 0232640E
loc_02326410:
	lsl r1,r4,#0x3	; 02326410
	ldr r0,[pool_02326478]	; 02326412
	add r1,r0,r1	; 02326414
	ldr r0,[pool_0232647C]	; 02326416
	ldr r0,[r1,r0]	; 02326418
	ldr r2,[pool_02326480]	; 0232641A
	ldr r1,[r1,r2]	; 0232641C
	str r0,[sp,#0x8]	; 0232641E
	str r1,[sp,#0xc]	; 02326420
	add r0,sp,#0x8	; 02326422
	ldr r2,[r0,#0x0]	; 02326424
	add r0,r2,#0x0	; 02326426
	ldr r1,[pool_02326484]	; 02326428
	and r0,r1	; 0232642A
	lsl r1,r2,#0x7	; 0232642C
	lsr r1,r1,#0x17	; 0232642E
	add r2,r1,r6	; 02326430
	ldr r1,[pool_02326488]	; 02326432
	and r2,r1	; 02326434
	lsl r1,r2,#0x10	; 02326436
	orr r0,r1	; 02326438
	add r1,sp,#0x8	; 0232643A
	str r0,[r1,#0x0]	; 0232643C
	add r0,sp,#0x8	; 0232643E
	ldrb r0,[r0,#0x0]	; 02326440
	add r1,r0,r7	; 02326442
	add r0,sp,#0x8	; 02326444
	strb r1,[r0,#0x0]	; 02326446
	cmp r5,#0x0	; 02326448
	blt loc_0232645E	; 0232644A
	ldr r0,[sp,#0xc]	; 0232644C
	ldr r1,[pool_0232648C]	; 0232644E
	and r0,r1	; 02326450
	add r2,r5,#0x0	; 02326452
	mov r1,#0xf	; 02326454
	and r2,r1	; 02326456
	lsl r1,r2,#0xc	; 02326458
	orr r0,r1	; 0232645A
	str r0,[sp,#0xc]	; 0232645C
loc_0232645E:
	ldr r0,[sp,#0x0]	; 0232645E
	add r1,sp,#0x8	; 02326460
	ldr r2,[sp,#0x4]	; 02326462
	bl loc_023238D8	; 02326464
	add r4,r4,#0x1	; 02326468
	cmp r4,#0x1a	; 0232646A
	blt loc_02326410	; 0232646C
	add sp,#0x14	; 0232646E
	pop {r4,r5,r6,r7}	; 02326470
	pop {r3}	; 02326472
	bx r3	; 02326474
	.byte 0xC0, 0x46	; 02326478
pool_02326478:
loc_02326478:
	.word 0x023550E8	; 02326478
pool_0232647C:
loc_0232647C:
	.word 0x00000AA0	; 0232647C
pool_02326480:
loc_02326480:
	.word 0x00000AA4	; 02326480
pool_02326484:
loc_02326484:
	.word 0xFE00FFFF	; 02326484
pool_02326488:
loc_02326488:
	.word 0x000001FF	; 02326488
pool_0232648C:
loc_0232648C:
	.word 0xFFFF0FFF	; 0232648C

; ===== function loc_02326490 =====
loc_02326490:
	push {r4,r5,r6,r7,lr}	; 02326490
	sub sp,#0x4	; 02326492
	ldr r0,[pool_02326518]	; 02326494
	ldr r1,[pool_0232651C]	; 02326496
	mov r2,#0x8	; 02326498
	ldr r3,[pool_02326520]	; 0232649A
	bl loc_02328268	; 0232649C
	ldr r0,[pool_0232651C]	; 023264A0
	ldr r1,[pool_02326524]	; 023264A2
	blx P1_CleanDataCacheRange	; 023264A4
	mov r5,#0x0	; 023264A8
	ldr r4,[pool_0232651C]	; 023264AA
	mov r7,#0x20	; 023264AC
	ldr r6,[pool_02326528]	; 023264AE
loc_023264B0:
	lsl r0,r5,#0x5	; 023264B0
	add r0,r4,r0	; 023264B2
	lsl r1,r5,#0x7	; 023264B4
	add r1,r1,r6	; 023264B6
	add r2,r7,#0x0	; 023264B8
	bl loc_0232E020	; 023264BA
	add r5,r5,#0x1	; 023264BE
	cmp r5,#0x1a	; 023264C0
	blt loc_023264B0	; 023264C2
	ldr r0,[pool_0232652C]	; 023264C4
	ldr r1,[pool_02326530]	; 023264C6
	mov r2,#0x2	; 023264C8
	bl loc_0232E114	; 023264CA
	mov r2,#0x0	; 023264CE
	str r2,[sp,#0x0]	; 023264D0
loc_023264D2:
	ldr r5,[sp,#0x0]	; 023264D2
	lsl r4,r2,#0x3	; 023264D4
	mov r0,#0xff	; 023264D6
	and r4,r0	; 023264D8
	add r7,r2,#0x0	; 023264DA
	mov r0,#0xd	; 023264DC
	mul r7,r0	; 023264DE
	lsl r1,r7,#0x3	; 023264E0
	ldr r0,[pool_0232651C]	; 023264E2
	add r3,r0,r1	; 023264E4
loc_023264E6:
	lsl r6,r5,#0x3	; 023264E6
	add r1,r3,r6	; 023264E8
	ldr r0,[pool_02326534]	; 023264EA
	and r6,r0	; 023264EC
	lsl r6,r6,#0x10	; 023264EE
	orr r6,r4	; 023264F0
	ldr r0,[pool_02326538]	; 023264F2
	str r6,[r1,r0]	; 023264F4
	add r6,r5,r7	; 023264F6
	ldr r0,[pool_02326524]	; 023264F8
	add r0,r6,r0	; 023264FA
	ldr r6,[pool_0232653C]	; 023264FC
	orr r0,r6	; 023264FE
	ldr r6,[pool_02326540]	; 02326500
	strh r0,[r1,r6]	; 02326502
	add r5,r5,#0x1	; 02326504
	cmp r5,#0xd	; 02326506
	blt loc_023264E6	; 02326508
	add r2,r2,#0x1	; 0232650A
	cmp r2,#0x2	; 0232650C
	blt loc_023264D2	; 0232650E
	add sp,#0x4	; 02326510
	pop {r4,r5,r6,r7}	; 02326512
	pop {r3}	; 02326514
	bx r3	; 02326516
pool_02326518:
loc_02326518:
	.word 0x027FFEC0	; 02326518
pool_0232651C:
loc_0232651C:
	.word 0x023550E8	; 0232651C
pool_02326520:
loc_02326520:
	.word 0x02355488	; 02326520
pool_02326524:
loc_02326524:
	.word 0x000003A0	; 02326524
pool_02326528:
loc_02326528:
	.word 0x0001D000	; 02326528
pool_0232652C:
loc_0232652C:
	.word 0x02330830	; 0232652C
pool_02326530:
loc_02326530:
	.word 0x000001F0	; 02326530
pool_02326534:
loc_02326534:
	.word 0x000001FF	; 02326534
pool_02326538:
loc_02326538:
	.word 0x00000AA0	; 02326538
pool_0232653C:
loc_0232653C:
	.word 0x0000F000	; 0232653C
pool_02326540:
loc_02326540:
	.word 0x00000AA4	; 02326540

; ===== function loc_02326544 =====
loc_02326544:
	ldr r1,[pool_0232654C]	; 02326544
	str r0,[r1,#0x0]	; 02326546
	bx lr	; 02326548
	.byte 0xC0, 0x46	; 0232654C
pool_0232654C:
loc_0232654C:
	.word P1_BssStart + 0x24DE8	; 0232654C
	.byte 0x01, 0x49, 0x08, 0x60, 0x70, 0x47, 0xC0, 0x46, 0x64, 0x5C, 0x35, 0x02, 0x01, 0x49, 0x08, 0x60	; 02326560
	.byte 0x70, 0x47, 0xC0, 0x46, 0x60, 0x5C, 0x35, 0x02	; 02326568

; ===== function loc_02326568 =====
loc_02326568:
	push {lr}	; 02326568
	sub sp,#0x4	; 0232656A
	ldr r0,[pool_02326598]	; 0232656C
	ldr r1,[r0,#0x0]	; 0232656E
	mov r0,#0x1	; 02326570
	and r1,r0	; 02326572
	cmp r1,#0x1	; 02326574
	bne loc_02326592	; 02326576
	blx P1_Arm9DisableIrqReturnPriorMask	; 02326578
	ldr r2,[pool_02326598]	; 0232657C
	ldr r3,[r2,#0x0]	; 0232657E
	mov r1,#0x1	; 02326580
	bic r3,r1	; 02326582
	str r3,[r2,#0x0]	; 02326584
	ldr r3,[r2,#0x0]	; 02326586
	mov r1,#0x2	; 02326588
	bic r3,r1	; 0232658A
	str r3,[r2,#0x0]	; 0232658C
	blx P1_Arm9RestoreIrqMask	; 0232658E
loc_02326592:
	add sp,#0x4	; 02326592
	pop {r3}	; 02326594
	bx r3	; 02326596
pool_02326598:
loc_02326598:
	.word P1_BssStart + 0x24DD8	; 02326598

; ===== function loc_0232659C =====
loc_0232659C:
	push {lr}	; 0232659C
	sub sp,#0x4	; 0232659E
	ldr r0,[pool_023265C4]	; 023265A0
	ldr r1,[r0,#0x0]	; 023265A2
	mov r0,#0x1	; 023265A4
	and r1,r0	; 023265A6
	cmp r1,#0x1	; 023265A8
	bne loc_023265BE	; 023265AA
	blx P1_Arm9DisableIrqReturnPriorMask	; 023265AC
	ldr r2,[pool_023265C4]	; 023265B0
	ldr r3,[r2,#0x0]	; 023265B2
	mov r1,#0x2	; 023265B4
	bic r3,r1	; 023265B6
	str r3,[r2,#0x0]	; 023265B8
	blx P1_Arm9RestoreIrqMask	; 023265BA
loc_023265BE:
	add sp,#0x4	; 023265BE
	pop {r3}	; 023265C0
	bx r3	; 023265C2
pool_023265C4:
loc_023265C4:
	.word P1_BssStart + 0x24DD8	; 023265C4

; ===== function loc_023265C8 =====
loc_023265C8:
	push {lr}	; 023265C8
	sub sp,#0x4	; 023265CA
	ldr r2,[pool_02326618]	; 023265CC
	ldr r3,[r2,#0x0]	; 023265CE
	mov r1,#0x10	; 023265D0
	and r3,r1	; 023265D2
	cmp r3,#0x10	; 023265D4
	beq loc_02326610	; 023265D6
	ldr r1,[r2,#0x0]	; 023265D8
	mov r3,#0x1	; 023265DA
	orr r1,r3	; 023265DC
	str r1,[r2,#0x0]	; 023265DE
	ldr r1,[r0,#0x10]	; 023265E0
	ldrb r2,[r1,#0x0]	; 023265E2
	ldr r1,[pool_0232661C]	; 023265E4
	str r2,[r1,#0x4]	; 023265E6
	ldr r0,[r0,#0x10]	; 023265E8
	ldrb r0,[r0,#0x1]	; 023265EA
	str r0,[r1,#0x8]	; 023265EC
	mov r0,#0x6	; 023265EE
	str r0,[r1,#0xc]	; 023265F0
	ldr r0,[pool_02326620]	; 023265F2
	str r3,[r0,#0x0]	; 023265F4
	ldr r0,[pool_02326624]	; 023265F6
	bl loc_02330268	; 023265F8
	mov r0,#0x0	; 023265FC
	ldr r1,[pool_02326620]	; 023265FE
	bl loc_023301AC	; 02326600
	mov r0,#0x0	; 02326604
	ldr r1,[pool_0232661C]	; 02326606
	bl loc_023300D0	; 02326608
	mov r0,#0x1	; 0232660C
	b loc_02326612	; 0232660E
loc_02326610:
	mov r0,#0x0	; 02326610
loc_02326612:
	add sp,#0x4	; 02326612
	pop {r3}	; 02326614
	bx r3	; 02326616
pool_02326618:
loc_02326618:
	.word P1_BssStart + 0x24DD8	; 02326618
pool_0232661C:
loc_0232661C:
	.word P1_BssStart + 0x24DEC	; 0232661C
pool_02326620:
loc_02326620:
	.word P1_BssStart + 0x24DDC	; 02326620
pool_02326624:
loc_02326624:
	.word 0x02326629	; 02326624

; ===== function loc_02326628 =====
loc_02326628:
	ldr r1,[pool_02326640]	; 02326628
	ldr r2,[r1,#0x0]	; 0232662A
	mov r0,#0x1	; 0232662C
	and r2,r0	; 0232662E
	cmp r2,#0x1	; 02326630
	bne loc_0232663C	; 02326632
	ldr r2,[r1,#0x0]	; 02326634
	mov r0,#0x2	; 02326636
	orr r2,r0	; 02326638
	str r2,[r1,#0x0]	; 0232663A
loc_0232663C:
	bx lr	; 0232663C
	.byte 0xC0, 0x46	; 02326640
pool_02326640:
loc_02326640:
	.word P1_BssStart + 0x24DD8	; 02326640

; ===== function loc_02326644 =====
loc_02326644:
	push {lr}	; 02326644
	sub sp,#0x4	; 02326646
	ldr r0,[pool_023267F8]	; 02326648
	ldrh r1,[r0,#0x0]	; 0232664A
	ldr r0,[pool_023267FC]	; 0232664C
	and r1,r0	; 0232664E
	asr r0,r1,#0xf	; 02326650
	ldr r1,[pool_02326800]	; 02326652
	ldr r2,[r1,#0x0]	; 02326654
	ldr r1,[pool_02326804]	; 02326656
	and r2,r1	; 02326658
	cmp r2,r1	; 0232665A
	bne loc_02326662	; 0232665C
	mov r3,#0x1	; 0232665E
	b loc_02326664	; 02326660
loc_02326662:
	mov r3,#0x0	; 02326662
loc_02326664:
	mvn r2,r0	; 02326664
	add r1,r0,#0x0	; 02326666
	eor r1,r3	; 02326668
	and r2,r1	; 0232666A
	cmp r2,#0x0	; 0232666C
	beq loc_0232667C	; 0232666E
	ldr r2,[pool_02326800]	; 02326670
	ldr r3,[r2,#0x0]	; 02326672
	ldr r1,[pool_02326808]	; 02326674
	orr r3,r1	; 02326676
	str r3,[r2,#0x0]	; 02326678
	b loc_02326686	; 0232667A
loc_0232667C:
	ldr r2,[pool_02326800]	; 0232667C
	ldr r3,[r2,#0x0]	; 0232667E
	ldr r1,[pool_0232680C]	; 02326680
	and r3,r1	; 02326682
	str r3,[r2,#0x0]	; 02326684
loc_02326686:
	cmp r0,#0x0	; 02326686
	beq loc_02326696	; 02326688
	ldr r1,[pool_02326800]	; 0232668A
	ldr r2,[r1,#0x0]	; 0232668C
	ldr r0,[pool_02326804]	; 0232668E
	orr r2,r0	; 02326690
	str r2,[r1,#0x0]	; 02326692
	b loc_023266A0	; 02326694
loc_02326696:
	ldr r1,[pool_02326800]	; 02326696
	ldr r2,[r1,#0x0]	; 02326698
	ldr r0,[pool_02326810]	; 0232669A
	and r2,r0	; 0232669C
	str r2,[r1,#0x0]	; 0232669E
loc_023266A0:
	ldr r1,[pool_02326800]	; 023266A0
	ldr r2,[r1,#0x0]	; 023266A2
	mov r0,#0x2	; 023266A4
	and r2,r0	; 023266A6
	cmp r2,#0x2	; 023266A8
	beq loc_0232671C	; 023266AA
	ldr r0,[pool_023267F8]	; 023266AC
	ldrh r2,[r0,#0x0]	; 023266AE
	ldr r0,[pool_023267FC]	; 023266B0
	and r2,r0	; 023266B2
	asr r0,r2,#0xf	; 023266B4
	cmp r0,#0x0	; 023266B6
	beq loc_0232671C	; 023266B8
	ldr r2,[r1,#0x0]	; 023266BA
	mov r0,#0x40	; 023266BC
	orr r2,r0	; 023266BE
	str r2,[r1,#0x0]	; 023266C0
	bl loc_02329920	; 023266C2
	ldr r0,[pool_02326814]	; 023266C6
	ldr r0,[r0,#0x0]	; 023266C8
	cmp r0,#0x0	; 023266CA
	beq loc_023266D0	; 023266CC
	blx r0	; 023266CE
loc_023266D0:
	bl loc_023278B4	; 023266D0
	bl loc_023268B0	; 023266D4
	bl loc_0232D0E0	; 023266D8
	ldr r2,[pool_02326818]	; 023266DC
	ldr r1,[r2,#0x0]	; 023266DE
	ldr r0,[pool_0232681C]	; 023266E0
	and r1,r0	; 023266E2
	str r1,[r2,#0x0]	; 023266E4
	ldr r0,[pool_02326800]	; 023266E6
	ldr r1,[r0,#0x0]	; 023266E8
	mov r0,#0x1	; 023266EA
	and r1,r0	; 023266EC
	cmp r1,#0x1	; 023266EE
	bne loc_023266F6	; 023266F0
	mov r0,#0x2	; 023266F2
	b loc_023266F8	; 023266F4
loc_023266F6:
	mov r0,#0x0	; 023266F6
loc_023266F8:
	mov r1,#0x4	; 023266F8
	orr r0,r1	; 023266FA
	mov r1,#0x0	; 023266FC
	add r2,r1,#0x0	; 023266FE
	bl loc_0232F624	; 02326700
	mov r0,#0xa	; 02326704
	mov r1,#0x1	; 02326706
	blx loc_0232ABB8	; 02326708
	bl loc_0232D0A0	; 0232670C
	ldr r2,[pool_02326818]	; 02326710
	ldr r1,[r2,#0x0]	; 02326712
	ldr r0,[pool_02326820]	; 02326714
	orr r1,r0	; 02326716
	str r1,[r2,#0x0]	; 02326718
	b loc_02326752	; 0232671A
loc_0232671C:
	bl loc_02325694	; 0232671C
	ldr r0,[r0,#0x0]	; 02326720
	lsl r0,r0,#0x16	; 02326722
	lsr r0,r0,#0x1f	; 02326724
	cmp r0,#0x0	; 02326726
	beq loc_02326752	; 02326728
	bl loc_02325694	; 0232672A
	ldr r0,[r0,#0x0]	; 0232672E
	lsl r0,r0,#0x15	; 02326730
	lsr r0,r0,#0x1f	; 02326732
	cmp r0,#0x0	; 02326734
	beq loc_02326752	; 02326736
	ldr r0,[pool_023267F8]	; 02326738
	ldrh r1,[r0,#0x0]	; 0232673A
	ldr r0,[pool_023267FC]	; 0232673C
	and r1,r0	; 0232673E
	asr r0,r1,#0xf	; 02326740
	cmp r0,#0x0	; 02326742
	beq loc_0232674A	; 02326744
	mov r1,#0x0	; 02326746
	b loc_0232674C	; 02326748
loc_0232674A:
	mov r1,#0x1	; 0232674A
loc_0232674C:
	mov r0,#0x2	; 0232674C
	bl loc_0232F760	; 0232674E
loc_02326752:
	ldr r0,[pool_02326800]	; 02326752
	ldr r1,[r0,#0x0]	; 02326754
	mov r0,#0x40	; 02326756
	and r1,r0	; 02326758
	cmp r1,#0x40	; 0232675A
	bne loc_023267A6	; 0232675C
	bl loc_023278D4	; 0232675E
	bl loc_023278B4	; 02326762
	bl loc_023278D4	; 02326766
	cmp r0,#0x0	; 0232676A
	bne loc_02326788	; 0232676C
	ldr r0,[pool_02326824]	; 0232676E
	ldr r0,[r0,#0x0]	; 02326770
	mov r1,#0x1	; 02326772
	and r0,r1	; 02326774
	cmp r0,#0x0	; 02326776
	bne loc_0232677C	; 02326778
	mov r1,#0x0	; 0232677A
loc_0232677C:
	cmp r1,#0x0	; 0232677C
	beq loc_0232678C	; 0232677E
	bl loc_0232C2FC	; 02326780
	cmp r0,#0x0	; 02326784
	beq loc_0232678C	; 02326786
loc_02326788:
	bl loc_0232F730	; 02326788
loc_0232678C:
	ldr r0,[pool_02326828]	; 0232678C
	ldr r0,[r0,#0x0]	; 0232678E
	cmp r0,#0x0	; 02326790
	beq loc_02326796	; 02326792
	blx r0	; 02326794
loc_02326796:
	bl loc_02329918	; 02326796
	ldr r1,[pool_02326800]	; 0232679A
	ldr r2,[r1,#0x0]	; 0232679C
	mov r0,#0x40	; 0232679E
	bic r2,r0	; 023267A0
	str r2,[r1,#0x0]	; 023267A2
	b loc_023267F2	; 023267A4
loc_023267A6:
	bl loc_023278D4	; 023267A6
	cmp r0,#0x0	; 023267AA
	bne loc_023267C8	; 023267AC
	ldr r0,[pool_02326824]	; 023267AE
	ldr r0,[r0,#0x0]	; 023267B0
	mov r1,#0x1	; 023267B2
	and r0,r1	; 023267B4
	cmp r0,#0x0	; 023267B6
	bne loc_023267BC	; 023267B8
	mov r1,#0x0	; 023267BA
loc_023267BC:
	cmp r1,#0x0	; 023267BC
	beq loc_023267DC	; 023267BE
	bl loc_0232C2FC	; 023267C0
	cmp r0,#0x0	; 023267C4
	beq loc_023267DC	; 023267C6
loc_023267C8:
	bl loc_02329920	; 023267C8
	ldr r0,[pool_02326814]	; 023267CC
	ldr r0,[r0,#0x0]	; 023267CE
	cmp r0,#0x0	; 023267D0
	beq loc_023267D6	; 023267D2
	blx r0	; 023267D4
loc_023267D6:
	bl loc_0232C158	; 023267D6
	b loc_023267F2	; 023267DA
loc_023267DC:
	ldr r0,[pool_02326800]	; 023267DC
	ldr r1,[r0,#0x0]	; 023267DE
	ldr r0,[pool_02326808]	; 023267E0
	and r1,r0	; 023267E2
	cmp r1,r0	; 023267E4
	bne loc_023267F2	; 023267E6
	ldr r0,[pool_0232682C]	; 023267E8
	ldr r0,[r0,#0x0]	; 023267EA
	cmp r0,#0x0	; 023267EC
	beq loc_023267F2	; 023267EE
	blx r0	; 023267F0
loc_023267F2:
	add sp,#0x4	; 023267F2
	pop {r3}	; 023267F4
	bx r3	; 023267F6
pool_023267F8:
loc_023267F8:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 023267F8
pool_023267FC:
loc_023267FC:
	.word 0x00008000	; 023267FC
pool_02326800:
loc_02326800:
	.word P1_BssStart + 0x24DD8	; 02326800
pool_02326804:
loc_02326804:
	.word 0x00000200	; 02326804
pool_02326808:
loc_02326808:
	.word 0x00000100	; 02326808
pool_0232680C:
loc_0232680C:
	.word 0xFFFFFEFF	; 0232680C
pool_02326810:
loc_02326810:
	.word 0xFFFFFDFF	; 02326810
pool_02326814:
loc_02326814:
	.word P1_BssStart + 0x24DE0	; 02326814
pool_02326818:
loc_02326818:
	.word REG_DISPCNT_B	; 02326818
pool_0232681C:
loc_0232681C:
	.word 0xFFFEFFFF	; 0232681C
pool_02326820:
loc_02326820:
	.word 0x00010000	; 02326820
pool_02326824:
loc_02326824:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02326824
pool_02326828:
loc_02326828:
	.word P1_BssStart + 0x24DE4	; 02326828
pool_0232682C:
loc_0232682C:
	.word P1_BssStart + 0x24DE8	; 0232682C

; ===== function loc_02326830 =====
loc_02326830:
	push {lr}	; 02326830
	sub sp,#0x4	; 02326832
	mov r0,#0x0	; 02326834
	ldr r1,[pool_02326858]	; 02326836
	str r0,[r1,#0x0]	; 02326838
	ldr r1,[pool_0232685C]	; 0232683A
	str r0,[r1,#0x0]	; 0232683C
	ldr r1,[pool_02326860]	; 0232683E
	str r0,[r1,#0x0]	; 02326840
	ldr r1,[pool_02326864]	; 02326842
	str r0,[r1,#0x0]	; 02326844
	bl loc_023301AC	; 02326846
	mov r0,#0x1	; 0232684A
	ldr r1,[pool_02326864]	; 0232684C
	bl loc_023301AC	; 0232684E
	add sp,#0x4	; 02326852
	pop {r3}	; 02326854
	bx r3	; 02326856
pool_02326858:
loc_02326858:
	.word P1_BssStart + 0x24DD8	; 02326858
pool_0232685C:
loc_0232685C:
	.word P1_BssStart + 0x24DE0	; 0232685C
pool_02326860:
loc_02326860:
	.word P1_BssStart + 0x24DE4	; 02326860
pool_02326864:
loc_02326864:
	.word P1_BssStart + 0x24DDC	; 02326864

; ===== function loc_02326868 =====
loc_02326868:
	push {lr}	; 02326868
	sub sp,#0x4	; 0232686A
	bl loc_02326644	; 0232686C
	bl loc_02326918	; 02326870
	bl loc_02325694	; 02326874
	add r1,r0,#0x4	; 02326878
	ldr r0,[r1,#0x0]	; 0232687A
	add r0,r0,#0x1	; 0232687C
	str r0,[r1,#0x0]	; 0232687E
	add sp,#0x4	; 02326880
	pop {r3}	; 02326882
	bx r3	; 02326884
	.byte 0x00, 0x00	; 02326888

; ===== function loc_02326888 =====
loc_02326888:
	ldr r1,[pool_02326894]	; 02326888
	ldr r2,[r1,#0x0]	; 0232688A
	mov r0,#0x2	; 0232688C
	bic r2,r0	; 0232688E
	str r2,[r1,#0x0]	; 02326890
	bx lr	; 02326892
pool_02326894:
loc_02326894:
	.word P1_BssStart + 0x24DFC	; 02326894

; ===== function loc_02326898 =====
loc_02326898:
	ldr r1,[pool_023268A8]	; 02326898
	ldr r2,[r1,#0x0]	; 0232689A
	mov r0,#0x2	; 0232689C
	orr r2,r0	; 0232689E
	str r2,[r1,#0x0]	; 023268A0
	mov r0,#0x0	; 023268A2
	ldr r3,[pool_023268AC]	; 023268A4
	bx r3	; 023268A6
pool_023268A8:
loc_023268A8:
	.word P1_BssStart + 0x24DFC	; 023268A8
pool_023268AC:
loc_023268AC:
	.word loc_02329078 + 1	; 023268AC

; ===== function loc_023268B0 =====
loc_023268B0:
	ldr r1,[pool_023268C0]	; 023268B0
	ldr r2,[r1,#0x0]	; 023268B2
	mov r0,#0x1	; 023268B4
	bic r2,r0	; 023268B6
	str r2,[r1,#0x0]	; 023268B8
	mov r0,#0x0	; 023268BA
	ldr r3,[pool_023268C4]	; 023268BC
	bx r3	; 023268BE
pool_023268C0:
loc_023268C0:
	.word P1_BssStart + 0x24DFC	; 023268C0
pool_023268C4:
loc_023268C4:
	.word loc_02329078 + 1	; 023268C4

; ===== function loc_023268C8 =====
loc_023268C8:
	push {r4,lr}	; 023268C8
	cmp r1,#0x0	; 023268CA
	beq loc_023268D6	; 023268CC
	ldr r2,[pool_02326914]	; 023268CE
	ldr r2,[r2,#0x8]	; 023268D0
	cmp r2,r0	; 023268D2
	bne loc_023268E2	; 023268D4
loc_023268D6:
	ldr r2,[pool_02326914]	; 023268D6
	ldr r3,[r2,#0x0]	; 023268D8
	mov r2,#0x1	; 023268DA
	and r3,r2	; 023268DC
	cmp r3,#0x1	; 023268DE
	beq loc_023268F0	; 023268E0
loc_023268E2:
	mov r2,#0x0	; 023268E2
	ldr r3,[pool_02326914]	; 023268E4
	str r2,[r3,#0x4]	; 023268E6
	ldr r4,[r3,#0x0]	; 023268E8
	mov r2,#0x1	; 023268EA
	orr r4,r2	; 023268EC
	str r4,[r3,#0x0]	; 023268EE
loc_023268F0:
	cmp r1,#0x0	; 023268F0
	beq loc_02326900	; 023268F2
	ldr r2,[pool_02326914]	; 023268F4
	ldr r3,[r2,#0x0]	; 023268F6
	mov r1,#0x4	; 023268F8
	orr r3,r1	; 023268FA
	str r3,[r2,#0x0]	; 023268FC
	b loc_0232690A	; 023268FE
loc_02326900:
	ldr r2,[pool_02326914]	; 02326900
	ldr r3,[r2,#0x0]	; 02326902
	mov r1,#0x4	; 02326904
	bic r3,r1	; 02326906
	str r3,[r2,#0x0]	; 02326908
loc_0232690A:
	ldr r1,[pool_02326914]	; 0232690A
	str r0,[r1,#0x8]	; 0232690C
	pop {r4}	; 0232690E
	pop {r3}	; 02326910
	bx r3	; 02326912
pool_02326914:
loc_02326914:
	.word P1_BssStart + 0x24DFC	; 02326914

; ===== function loc_02326918 =====
loc_02326918:
	push {lr}	; 02326918
	sub sp,#0x4	; 0232691A
	ldr r2,[pool_02326984]	; 0232691C
	ldr r0,[r2,#0x0]	; 0232691E
	mov r1,#0x1	; 02326920
	and r0,r1	; 02326922
	cmp r0,#0x1	; 02326924
	bne loc_02326976	; 02326926
	ldr r3,[r2,#0x0]	; 02326928
	mov r0,#0x2	; 0232692A
	and r3,r0	; 0232692C
	cmp r3,#0x2	; 0232692E
	beq loc_02326976	; 02326930
	ldr r0,[r2,#0x8]	; 02326932
	lsl r3,r0,#0x2	; 02326934
	ldr r0,[pool_02326988]	; 02326936
	ldr r3,[r0,r3]	; 02326938
	ldr r0,[r2,#0x4]	; 0232693A
	lsr r3,r0	; 0232693C
	and r3,r1	; 0232693E
	lsl r0,r3,#0x10	; 02326940
	lsr r0,r0,#0x10	; 02326942
	bl loc_02329078	; 02326944
	ldr r0,[pool_02326984]	; 02326948
	ldr r1,[r0,#0x4]	; 0232694A
	add r1,r1,#0x1	; 0232694C
	str r1,[r0,#0x4]	; 0232694E
	ldr r1,[r0,#0x4]	; 02326950
	cmp r1,#0x20	; 02326952
	blt loc_02326966	; 02326954
	ldr r1,[r0,#0x0]	; 02326956
	mov r0,#0x4	; 02326958
	and r1,r0	; 0232695A
	cmp r1,#0x4	; 0232695C
	bne loc_02326966	; 0232695E
	bl loc_023268B0	; 02326960
	b loc_0232697C	; 02326964
loc_02326966:
	ldr r0,[pool_02326984]	; 02326966
	ldr r0,[r0,#0x4]	; 02326968
	mov r1,#0x20	; 0232696A
	blx P1_SignedDivMod	; 0232696C
	ldr r0,[pool_02326984]	; 02326970
	str r1,[r0,#0x4]	; 02326972
	b loc_0232697C	; 02326974
loc_02326976:
	mov r0,#0x0	; 02326976
	bl loc_02329078	; 02326978
loc_0232697C:
	add sp,#0x4	; 0232697C
	pop {r3}	; 0232697E
	bx r3	; 02326980
	.byte 0xC0, 0x46	; 02326984
pool_02326984:
loc_02326984:
	.word P1_BssStart + 0x24DFC	; 02326984
pool_02326988:
loc_02326988:
	.word P1_Data_02330834	; 02326988

; ===== function loc_0232698C =====
loc_0232698C:
	push {lr}	; 0232698C
	sub sp,#0x4	; 0232698E
	ldr r0,[pool_023269A4]	; 02326990
	mov r1,#0x0	; 02326992
	mov r2,#0xc	; 02326994
	blx loc_0232E3D0	; 02326996
	bl loc_023290C4	; 0232699A
	add sp,#0x4	; 0232699E
	pop {r3}	; 023269A0
	bx r3	; 023269A2
pool_023269A4:
loc_023269A4:
	.word 0x02355C7C	; 023269A4

; ===== function loc_023269A8 =====
loc_023269A8:
	push {r4,lr}	; 023269A8
	add r4,r0,#0x0	; 023269AA
	bl loc_023269E0	; 023269AC
	ldr r2,[pool_023269C0]	; 023269B0
	ldmia r2!,{r0,r1}	; 023269B2
	stmia r4!,{r0,r1}	; 023269B4
	ldmia r2!,{r0,r1}	; 023269B6
	stmia r4!,{r0,r1}	; 023269B8
	pop {r4}	; 023269BA
	pop {r3}	; 023269BC
	bx r3	; 023269BE
pool_023269C0:
loc_023269C0:
	.word 0x02355C94	; 023269C0

; ===== function loc_023269C4 =====
loc_023269C4:
	push {r4,lr}	; 023269C4
	add r4,r0,#0x0	; 023269C6
	bl loc_023269E0	; 023269C8
	ldr r2,[pool_023269DC]	; 023269CC
	ldmia r2!,{r0,r1}	; 023269CE
	stmia r4!,{r0,r1}	; 023269D0
	ldr r0,[r2,#0x0]	; 023269D2
	str r0,[r4,#0x0]	; 023269D4
	pop {r4}	; 023269D6
	pop {r3}	; 023269D8
	bx r3	; 023269DA
pool_023269DC:
loc_023269DC:
	.word 0x02355C88	; 023269DC

; ===== function loc_023269E0 =====
loc_023269E0:
	push {lr}	; 023269E0
	sub sp,#0x4	; 023269E2
	bl loc_02325694	; 023269E4
	ldr r0,[r0,#0x4]	; 023269E8
	mov r1,#0x14	; 023269EA
	blx P1_UnsignedDivMod	; 023269EC
	cmp r1,#0x0	; 023269F0
	bne loc_02326A16	; 023269F2
	ldr r0,[pool_02326A1C]	; 023269F4
	ldr r1,[pool_02326A20]	; 023269F6
	bl loc_023303B0	; 023269F8
	cmp r0,#0x0	; 023269FC
	beq loc_02326A16	; 023269FE
	mov r2,#0x0	; 02326A00
	ldr r0,[pool_02326A1C]	; 02326A02
	str r2,[r0,#0x0]	; 02326A04
	mov r1,#0x1	; 02326A06
	str r1,[r0,#0x4]	; 02326A08
	str r1,[r0,#0x8]	; 02326A0A
	str r2,[r0,#0xc]	; 02326A0C
	ldr r0,[pool_02326A20]	; 02326A0E
	str r2,[r0,#0x0]	; 02326A10
	str r2,[r0,#0x4]	; 02326A12
	str r2,[r0,#0x8]	; 02326A14
loc_02326A16:
	add sp,#0x4	; 02326A16
	pop {r3}	; 02326A18
	bx r3	; 02326A1A
pool_02326A1C:
loc_02326A1C:
	.word P1_BssStart + 0x24E14	; 02326A1C
pool_02326A20:
loc_02326A20:
	.word P1_BssStart + 0x24E08	; 02326A20

; ===== function loc_02326A24 =====
loc_02326A24:
	push {r4,r5,r6,r7,lr}	; 02326A24
	sub sp,#0xc	; 02326A26
	add r5,r0,#0x0	; 02326A28
	add r4,r1,#0x0	; 02326A2A
	add r6,r2,#0x0	; 02326A2C
	sub r0,r4,#0x1	; 02326A2E
	cmp r0,#0x1	; 02326A30
	bhi loc_02326A38	; 02326A32
	sub r5,r5,#0x1	; 02326A34
	add r4,#0xc	; 02326A36
loc_02326A38:
	add r0,r5,#0x0	; 02326A38
	ldr r1,[pool_02326A84]	; 02326A3A
	blx P1_SignedDivMod	; 02326A3C
	add r7,r0,#0x0	; 02326A40
	add r0,r5,#0x0	; 02326A42
	mov r1,#0x4	; 02326A44
	blx P1_SignedDivMod	; 02326A46
	str r0,[sp,#0x0]	; 02326A4A
	add r0,r5,#0x0	; 02326A4C
	mov r1,#0x64	; 02326A4E
	blx P1_SignedDivMod	; 02326A50
	str r0,[sp,#0x4]	; 02326A54
	mov r0,#0xd	; 02326A56
	mul r4,r0	; 02326A58
	add r4,#0x8	; 02326A5A
	add r0,r4,#0x0	; 02326A5C
	mov r1,#0x5	; 02326A5E
	blx P1_SignedDivMod	; 02326A60
	ldr r1,[sp,#0x0]	; 02326A64
	add r2,r5,r1	; 02326A66
	ldr r1,[sp,#0x4]	; 02326A68
	sub r1,r2,r1	; 02326A6A
	add r1,r7,r1	; 02326A6C
	add r0,r1,r0	; 02326A6E
	add r0,r6,r0	; 02326A70
	mov r1,#0x7	; 02326A72
	blx P1_SignedDivMod	; 02326A74
	add r0,r1,#0x0	; 02326A78
	add sp,#0xc	; 02326A7A
	pop {r4,r5,r6,r7}	; 02326A7C
	pop {r3}	; 02326A7E
	bx r3	; 02326A80
	.byte 0xC0, 0x46	; 02326A84
pool_02326A84:
loc_02326A84:
	.word 0x00000190	; 02326A84

; ===== function loc_02326A88 =====
loc_02326A88:
	push {r4,r5,r6,lr}	; 02326A88
	sub sp,#0x18	; 02326A8A
	add r4,r1,#0x0	; 02326A8C
	ldr r6,[pool_02326AC4]	; 02326A8E
	add r5,sp,#0x0	; 02326A90
	mov r3,#0xc	; 02326A92
loc_02326A94:
	ldrh r1,[r6,#0x0]	; 02326A94
	add r6,r6,#0x2	; 02326A96
	strh r1,[r5,#0x0]	; 02326A98
	add r5,r5,#0x2	; 02326A9A
	sub r3,r3,#0x1	; 02326A9C
	cmp r3,#0x0	; 02326A9E
	bne loc_02326A94	; 02326AA0
	cmp r2,#0x1	; 02326AA2
	beq loc_02326AAE	; 02326AA4
	bl loc_02326ACC	; 02326AA6
	cmp r0,#0x0	; 02326AAA
	beq loc_02326AB4	; 02326AAC
loc_02326AAE:
	mov r1,#0x1d	; 02326AAE
	add r0,sp,#0x0	; 02326AB0
	strh r1,[r0,#0x2]	; 02326AB2
loc_02326AB4:
	lsl r1,r4,#0x1	; 02326AB4
	ldr r0,[pool_02326AC8]	; 02326AB6
	add r0,sp	; 02326AB8
	ldrh r0,[r0,r1]	; 02326ABA
	add sp,#0x18	; 02326ABC
	pop {r4,r5,r6}	; 02326ABE
	pop {r3}	; 02326AC0
	bx r3	; 02326AC2
pool_02326AC4:
loc_02326AC4:
	.word P1_Data_02330D18	; 02326AC4
pool_02326AC8:
loc_02326AC8:
	.word 0xFFFFFFFE	; 02326AC8

; ===== function loc_02326ACC =====
loc_02326ACC:
	push {r4,lr}	; 02326ACC
	add r4,r0,#0x0	; 02326ACE
	mov r1,#0x3	; 02326AD0
	add r2,r4,#0x0	; 02326AD2
	and r2,r1	; 02326AD4
	cmp r2,#0x0	; 02326AD6
	bne loc_02326AE4	; 02326AD8
	mov r1,#0x64	; 02326ADA
	blx P1_UnsignedDivMod	; 02326ADC
	cmp r1,#0x0	; 02326AE0
	bne loc_02326AF0	; 02326AE2
loc_02326AE4:
	add r0,r4,#0x0	; 02326AE4
	ldr r1,[pool_02326AFC]	; 02326AE6
	blx P1_UnsignedDivMod	; 02326AE8
	cmp r1,#0x0	; 02326AEC
	bne loc_02326AF4	; 02326AEE
loc_02326AF0:
	mov r0,#0x1	; 02326AF0
	b loc_02326AF6	; 02326AF2
loc_02326AF4:
	mov r0,#0x0	; 02326AF4
loc_02326AF6:
	pop {r4}	; 02326AF6
	pop {r3}	; 02326AF8
	bx r3	; 02326AFA
pool_02326AFC:
loc_02326AFC:
	.word 0x00000190	; 02326AFC

; ===== function loc_02326B00 =====
loc_02326B00:
	push {r4,r5,lr}	; 02326B00
	sub sp,#0x4	; 02326B02
	ldr r0,[pool_02326B58]	; 02326B04
	ldr r1,[pool_02326B5C]	; 02326B06
	blx loc_023282AC	; 02326B08
	add r5,r0,#0x0	; 02326B0C
	ldr r1,[pool_02326B60]	; 02326B0E
	ldr r0,[r1,#0xc]	; 02326B10
	ldr r1,[r1,#0x10]	; 02326B12
	blx loc_023282AC	; 02326B14
	add r4,r0,#0x0	; 02326B18
	ldr r0,[pool_02326B64]	; 02326B1A
	ldr r1,[pool_02326B58]	; 02326B1C
	add r2,r5,#0x0	; 02326B1E
	bl loc_0232C406	; 02326B20
	ldr r1,[pool_02326B60]	; 02326B24
	ldr r1,[r1,#0xc]	; 02326B26
	add r2,r4,#0x0	; 02326B28
	bl loc_0232C406	; 02326B2A
	add r4,r0,#0x0	; 02326B2E
	blx P1_CleanAndInvalidateEntireDataCacheByIndex	; 02326B30
	ldr r0,[pool_02326B60]	; 02326B34
	ldrh r0,[r0,#0x16]	; 02326B36
	cmp r4,r0	; 02326B38
	bne loc_02326B4A	; 02326B3A
	ldr r0,[pool_02326B68]	; 02326B3C
	bl P1_OrSharedEventFlags	; 02326B3E
	add sp,#0x4	; 02326B42
	pop {r4,r5}	; 02326B44
	pop {r3}	; 02326B46
	bx r3	; 02326B48
loc_02326B4A:
	ldr r0,[pool_02326B6C]	; 02326B4A
	bl P1_OrSharedEventFlags	; 02326B4C
	add sp,#0x4	; 02326B50
	pop {r4,r5}	; 02326B52
	pop {r3}	; 02326B54
	bx r3	; 02326B56
pool_02326B58:
loc_02326B58:
	.word 0x023591C0	; 02326B58
pool_02326B5C:
loc_02326B5C:
	.word 0x022C0000	; 02326B5C
pool_02326B60:
loc_02326B60:
	.word 0x027FF860	; 02326B60
pool_02326B64:
loc_02326B64:
	.word 0x0000FFFF	; 02326B64
pool_02326B68:
loc_02326B68:
	.word 0x00000400	; 02326B68
pool_02326B6C:
loc_02326B6C:
	.word 0x00000408	; 02326B6C

; ===== function loc_02326B70 =====
loc_02326B70:
	push {r4,lr}	; 02326B70
	ldr r0,[pool_02326BA0]	; 02326B72
	ldr r1,[pool_02326BA4]	; 02326B74
	blx loc_023282AC	; 02326B76
	add r2,r0,#0x0	; 02326B7A
	ldr r0,[pool_02326BA8]	; 02326B7C
	ldr r1,[pool_02326BA0]	; 02326B7E
	bl loc_0232C406	; 02326B80
	add r4,r0,#0x0	; 02326B84
	blx P1_CleanAndInvalidateEntireDataCacheByIndex	; 02326B86
	ldr r0,[pool_02326BAC]	; 02326B8A
	ldrh r0,[r0,#0x0]	; 02326B8C
	cmp r4,r0	; 02326B8E
	bne loc_02326B98	; 02326B90
	ldr r0,[pool_02326BB0]	; 02326B92
	bl P1_OrSharedEventFlags	; 02326B94
loc_02326B98:
	pop {r4}	; 02326B98
	pop {r3}	; 02326B9A
	bx r3	; 02326B9C
	.byte 0xC0, 0x46	; 02326BA0
pool_02326BA0:
loc_02326BA0:
	.word 0x0239F120	; 02326BA0
pool_02326BA4:
loc_02326BA4:
	.word 0x022C0000	; 02326BA4
pool_02326BA8:
loc_02326BA8:
	.word 0x0000FFFF	; 02326BA8
pool_02326BAC:
loc_02326BAC:
	.word FirmwareBootSharedAddress + BootSharedP5Crc16Offset	; 02326BAC
pool_02326BB0:
loc_02326BB0:
	.word 0x10000000	; 02326BB0

; ===== function loc_02326BB4 =====
loc_02326BB4:
; 发布前 0x18 字节启动信息，再补 ARM7 BIOS CRC 与 RTC 随机值。
; Publish 0x18 boot-info bytes, then update the ARM7 BIOS CRC and RTC random byte.
.func P1_PublishBootInfo
	push {lr}	; 02326BB4
	sub sp,#0x4	; 02326BB6
	ldr r0,[pool_02326BD8]	; 02326BB8
	ldr r1,[pool_02326BDC]	; 02326BBA
	mov r2,#0x18	; 02326BBC
	blx loc_0232E398	; 02326BBE
	ldr r0,[pool_02326BE0]	; 02326BC2
	ldrh r1,[r0,#0x0]	; 02326BC4
	ldr r0,[pool_02326BE4]	; 02326BC6
	strh r1,[r0,#0x0]	; 02326BC8
	ldr r0,[pool_02326BE8]	; 02326BCA
	ldrb r1,[r0,#0x0]	; 02326BCC
	ldr r0,[pool_02326BEC]	; 02326BCE
	strb r1,[r0,#0x0]	; 02326BD0
	add sp,#0x4	; 02326BD2
	pop {r3}	; 02326BD4
	bx r3	; 02326BD6
.endfunc
pool_02326BD8:
loc_02326BD8:
	.word 0x027FF800	; 02326BD8
pool_02326BDC:
loc_02326BDC:
	.word 0x027FFC00	; 02326BDC
pool_02326BE0:
loc_02326BE0:
	.word 0x027FF850	; 02326BE0
pool_02326BE4:
loc_02326BE4:
	.word FirmwareBootInfoAddress + BootInfoBios7Crc16Offset	; 02326BE4
pool_02326BE8:
loc_02326BE8:
	.word 0x027FF818	; 02326BE8
pool_02326BEC:
loc_02326BEC:
	.word FirmwareBootInfoAddress + BootInfoRtcRandomOffset	; 02326BEC

; ===== function loc_02326BF0 =====
loc_02326BF0:
	push {r4,r5,r6,r7,lr}	; 02326BF0
	sub sp,#0x4	; 02326BF2
	ldr r5,[pool_02326CA4]	; 02326BF4
	mov r0,#0x6d	; 02326BF6
	bl loc_0232AFA8	; 02326BF8
	blx P1_Arm9DisableIrqReturnPriorMask	; 02326BFC
	str r0,[sp,#0x0]	; 02326C00
	ldr r2,[pool_02326CA8]	; 02326C02
	ldrh r1,[r2,#0x0]	; 02326C04
	ldr r0,[pool_02326CAC]	; 02326C06
	and r1,r0	; 02326C08
	asr r4,r1,#0xf	; 02326C0A
	ldrh r1,[r2,#0x0]	; 02326C0C
	mov r0,#0xc	; 02326C0E
	and r1,r0	; 02326C10
	asr r6,r1,#0x2	; 02326C12
	ldrh r1,[r2,#0x0]	; 02326C14
	mov r3,#0x10	; 02326C16
	and r1,r3	; 02326C18
	asr r7,r1,#0x4	; 02326C1A
	ldrh r1,[r2,#0x0]	; 02326C1C
	bic r1,r0	; 02326C1E
	orr r1,r0	; 02326C20
	strh r1,[r2,#0x0]	; 02326C22
	ldrh r0,[r2,#0x0]	; 02326C24
	bic r0,r3	; 02326C26
	strh r0,[r2,#0x0]	; 02326C28
	ldrh r1,[r2,#0x0]	; 02326C2A
	ldr r0,[pool_02326CB0]	; 02326C2C
	and r1,r0	; 02326C2E
	strh r1,[r2,#0x0]	; 02326C30
	mov r0,#0x0	; 02326C32
	ldr r1,[pool_02326CB4]	; 02326C34
	ldr r2,[pool_02326CB8]	; 02326C36
	mov r3,#0x40	; 02326C38
	bl loc_0232E214	; 02326C3A
	ldr r0,[pool_02326CA8]	; 02326C3E
	ldrh r1,[r0,#0x0]	; 02326C40
	ldr r2,[pool_02326CB0]	; 02326C42
	and r1,r2	; 02326C44
	lsl r2,r4,#0xf	; 02326C46
	orr r1,r2	; 02326C48
	strh r1,[r0,#0x0]	; 02326C4A
	ldrh r2,[r0,#0x0]	; 02326C4C
	mov r1,#0xc	; 02326C4E
	bic r2,r1	; 02326C50
	lsl r1,r6,#0x2	; 02326C52
	orr r2,r1	; 02326C54
	strh r2,[r0,#0x0]	; 02326C56
	ldrh r2,[r0,#0x0]	; 02326C58
	mov r1,#0x10	; 02326C5A
	bic r2,r1	; 02326C5C
	lsl r1,r7,#0x4	; 02326C5E
	orr r2,r1	; 02326C60
	strh r2,[r0,#0x0]	; 02326C62
	ldr r0,[sp,#0x0]	; 02326C64
	blx P1_Arm9RestoreIrqMask	; 02326C66
	mov r0,#0x6d	; 02326C6A
	bl loc_0232AE40	; 02326C6C
	add r0,r5,#0x0	; 02326C70
	add r0,#0xbe	; 02326C72
	ldrh r1,[r0,#0x0]	; 02326C74
	ldr r0,[pool_02326CBC]	; 02326C76
	strh r1,[r0,#0x0]	; 02326C78
	mov r2,#0x0	; 02326C7A
	ldr r0,[pool_02326CC0]	; 02326C7C
loc_02326C7E:
	add r1,r5,r2	; 02326C7E
	add r1,#0xb5	; 02326C80
	ldrb r1,[r1,#0x0]	; 02326C82
	strb r1,[r2,r0]	; 02326C84
	add r2,r2,#0x1	; 02326C86
	cmp r2,#0x3	; 02326C88
	blt loc_02326C7E	; 02326C8A
	add r0,r5,#0x0	; 02326C8C
	add r0,#0xb0	; 02326C8E
	ldrh r0,[r0,#0x0]	; 02326C90
	ldr r1,[pool_02326CBC]	; 02326C92
	strh r0,[r1,#0x6]	; 02326C94
	add r5,#0xac	; 02326C96
	ldr r0,[r5,#0x0]	; 02326C98
	str r0,[r1,#0x8]	; 02326C9A
	add sp,#0x4	; 02326C9C
	pop {r4,r5,r6,r7}	; 02326C9E
	pop {r3}	; 02326CA0
	bx r3	; 02326CA2
pool_02326CA4:
loc_02326CA4:
	.word 0x02355CC0	; 02326CA4
pool_02326CA8:
loc_02326CA8:
	.word REG_EXMEMCNT_ARM9	; 02326CA8
pool_02326CAC:
loc_02326CAC:
	.word 0x00008000	; 02326CAC
pool_02326CB0:
loc_02326CB0:
	.word 0xFFFF7FFF	; 02326CB0
pool_02326CB4:
loc_02326CB4:
	.word 0x08000080	; 02326CB4
pool_02326CB8:
loc_02326CB8:
	.word 0x02355D40	; 02326CB8
pool_02326CBC:
loc_02326CBC:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 02326CBC
pool_02326CC0:
loc_02326CC0:
	.word 0x027FFC32	; 02326CC0

; ===== function loc_02326CC4 =====
loc_02326CC4:
	push {r4}	; 02326CC4
	sub sp,#0x4	; 02326CC6
	ldr r1,[pool_02326CFC]	; 02326CC8
	mov r2,#0x4e	; 02326CCA
	sub r2,r2,#0x1	; 02326CCC
	lsl r2,r2,#0x10	; 02326CCE
	lsr r4,r2,#0x10	; 02326CD0
loc_02326CD2:
	ldrh r3,[r1,#0x0]	; 02326CD2
	add r1,r1,#0x2	; 02326CD4
	ldrh r2,[r0,#0x0]	; 02326CD6
	add r0,r0,#0x2	; 02326CD8
	cmp r3,r2	; 02326CDA
	beq loc_02326CE6	; 02326CDC
	mov r0,#0x0	; 02326CDE
	add sp,#0x4	; 02326CE0
	pop {r4}	; 02326CE2
	bx lr	; 02326CE4
loc_02326CE6:
	add r3,r4,#0x0	; 02326CE6
	sub r2,r4,#0x1	; 02326CE8
	lsl r2,r2,#0x10	; 02326CEA
	lsr r4,r2,#0x10	; 02326CEC
	cmp r3,#0x0	; 02326CEE
	bne loc_02326CD2	; 02326CF0
	mov r0,#0x1	; 02326CF2
	add sp,#0x4	; 02326CF4
	pop {r4}	; 02326CF6
	bx lr	; 02326CF8
	.byte 0xC0, 0x46	; 02326CFC
pool_02326CFC:
loc_02326CFC:
	.word Bios9NintendoLogoAddress	; 02326CFC

; ===== function loc_02326D00 =====
loc_02326D00:
	ldr r0,[pool_02326D20]	; 02326D00
	ldrh r1,[r0,#0x0]	; 02326D02
	ldr r0,[pool_02326D24]	; 02326D04
	cmp r1,r0	; 02326D06
	bne loc_02326D1A	; 02326D08
	ldr r0,[pool_02326D28]	; 02326D0A
	ldrh r1,[r0,#0x0]	; 02326D0C
	ldr r0,[pool_02326D2C]	; 02326D0E
	ldrh r0,[r0,#0x0]	; 02326D10
	cmp r1,r0	; 02326D12
	bne loc_02326D1A	; 02326D14
	mov r0,#0x1	; 02326D16
	bx lr	; 02326D18
loc_02326D1A:
	mov r0,#0x0	; 02326D1A
	bx lr	; 02326D1C
	.byte 0xC0, 0x46	; 02326D20
pool_02326D20:
loc_02326D20:
	.word NdsCartHeaderRamAddress + 0x15C	; 02326D20
pool_02326D24:
loc_02326D24:
	.word 0x0000CF56	; 02326D24
pool_02326D28:
loc_02326D28:
	.word NdsCartHeaderRamAddress + 0x15E	; 02326D28
pool_02326D2C:
loc_02326D2C:
	.word 0x027FF808	; 02326D2C

; ===== function loc_02326D30 =====
loc_02326D30:
	add r1,r0,#0x0	; 02326D30
	mov r0,#0x2	; 02326D32
	mov r2,#0x0	; 02326D34
	ldr r3,[pool_02326D3C]	; 02326D36
	bx r3	; 02326D38
	.byte 0xC0, 0x46	; 02326D3C
pool_02326D3C:
loc_02326D3C:
	.word loc_0232ED98 + 1	; 02326D3C

; ===== function loc_02326D40 =====
loc_02326D40:
	push {lr}	; 02326D40
	sub sp,#0x4	; 02326D42
	ldr r0,[pool_02326D58]	; 02326D44
	ldrb r1,[r0,#0x0]	; 02326D46
	add r0,sp,#0x0	; 02326D48
	strb r1,[r0,#0x0]	; 02326D4A
	add r0,sp,#0x0	; 02326D4C
	bl loc_02330274	; 02326D4E
	add sp,#0x4	; 02326D52
	pop {r3}	; 02326D54
	bx r3	; 02326D56
pool_02326D58:
loc_02326D58:
	.word FirmwareUserSettingsSharedAddress + 0x67	; 02326D58

; ===== function loc_02326D5C =====
loc_02326D5C:
	push {lr}	; 02326D5C
	sub sp,#0x1c	; 02326D5E
	ldr r0,[pool_02326D9C]	; 02326D60
	ldrb r0,[r0,#0x0]	; 02326D62
	str r0,[sp,#0x0]	; 02326D64
	ldr r0,[pool_02326DA0]	; 02326D66
	ldrh r0,[r0,#0x0]	; 02326D68
	str r0,[sp,#0x4]	; 02326D6A
	ldr r0,[pool_02326DA4]	; 02326D6C
	ldrh r0,[r0,#0x0]	; 02326D6E
	str r0,[sp,#0x8]	; 02326D70
	ldr r0,[pool_02326DA8]	; 02326D72
	ldrb r0,[r0,#0x0]	; 02326D74
	str r0,[sp,#0xc]	; 02326D76
	ldr r0,[pool_02326DAC]	; 02326D78
	ldrb r0,[r0,#0x0]	; 02326D7A
	str r0,[sp,#0x10]	; 02326D7C
	add r0,sp,#0x14	; 02326D7E
	ldr r1,[pool_02326DB0]	; 02326D80
	ldrh r1,[r1,#0x0]	; 02326D82
	ldr r2,[pool_02326DB4]	; 02326D84
	ldrh r2,[r2,#0x0]	; 02326D86
	ldr r3,[pool_02326DB8]	; 02326D88
	ldrb r3,[r3,#0x0]	; 02326D8A
	bl loc_0232F0B8	; 02326D8C
	add r0,sp,#0x14	; 02326D90
	bl loc_0232F300	; 02326D92
	add sp,#0x1c	; 02326D96
	pop {r3}	; 02326D98
	bx r3	; 02326D9A
pool_02326D9C:
loc_02326D9C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelY1Offset	; 02326D9C
pool_02326DA0:
loc_02326DA0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcX2Offset	; 02326DA0
pool_02326DA4:
loc_02326DA4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcY2Offset	; 02326DA4
pool_02326DA8:
loc_02326DA8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelX2Offset	; 02326DA8
pool_02326DAC:
loc_02326DAC:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelY2Offset	; 02326DAC
pool_02326DB0:
loc_02326DB0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcX1Offset	; 02326DB0
pool_02326DB4:
loc_02326DB4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcY1Offset	; 02326DB4
pool_02326DB8:
loc_02326DB8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelX1Offset	; 02326DB8

; ===== function loc_02326DBC =====
loc_02326DBC:
	push {r4,r5,lr}	; 02326DBC
	sub sp,#0x4	; 02326DBE
	ldr r5,[pool_02326E44]	; 02326DC0
	bl loc_02326D00	; 02326DC2
	cmp r0,#0x0	; 02326DC6
	beq loc_02326DD2	; 02326DC8
	ldr r0,[pool_02326E48]	; 02326DCA
	ldr r0,[r0,#0x0]	; 02326DCC
	cmp r0,#0x0	; 02326DCE
	bne loc_02326DE0	; 02326DD0
loc_02326DD2:
	mov r1,#0x0	; 02326DD2
	ldr r0,[pool_02326E4C]	; 02326DD4
	str r1,[r0,#0x0]	; 02326DD6
	add sp,#0x4	; 02326DD8
	pop {r4,r5}	; 02326DDA
	pop {r3}	; 02326DDC
	bx r3	; 02326DDE
loc_02326DE0:
	blx loc_0232AE50	; 02326DE0
	add r4,r0,#0x0	; 02326DE4
	cmp r4,#0x0	; 02326DE6
	beq loc_02326E16	; 02326DE8
	lsl r0,r4,#0x10	; 02326DEA
	lsr r0,r0,#0x10	; 02326DEC
	bl loc_0232AF3C	; 02326DEE
	add r0,r5,#0x0	; 02326DF2
	ldr r1,[pool_02326E50]	; 02326DF4
	blx P1_CleanAndInvalidateDataCacheRange	; 02326DF6
	ldr r0,[pool_02326E48]	; 02326DFA
	ldr r0,[r0,#0x0]	; 02326DFC
	add r1,r5,#0x0	; 02326DFE
	ldr r2,[pool_02326E50]	; 02326E00
	bl loc_02327814	; 02326E02
	lsl r0,r4,#0x10	; 02326E06
	lsr r0,r0,#0x10	; 02326E08
	bl loc_0232AE48	; 02326E0A
	lsl r0,r4,#0x10	; 02326E0E
	lsr r0,r0,#0x10	; 02326E10
	blx loc_0232AEA8	; 02326E12
loc_02326E16:
	ldr r0,[pool_02326E54]	; 02326E16
	add r1,r5,#0x0	; 02326E18
	add r1,#0x20	; 02326E1A
	ldr r2,[pool_02326E58]	; 02326E1C
	bl loc_0232C406	; 02326E1E
	ldrh r1,[r5,#0x2]	; 02326E22
	cmp r1,r0	; 02326E24
	beq loc_02326E36	; 02326E26
	mov r1,#0x0	; 02326E28
	ldr r0,[pool_02326E4C]	; 02326E2A
	str r1,[r0,#0x0]	; 02326E2C
	add sp,#0x4	; 02326E2E
	pop {r4,r5}	; 02326E30
	pop {r3}	; 02326E32
	bx r3	; 02326E34
loc_02326E36:
	mov r1,#0x1	; 02326E36
	ldr r0,[pool_02326E4C]	; 02326E38
	str r1,[r0,#0x0]	; 02326E3A
	add sp,#0x4	; 02326E3C
	pop {r4,r5}	; 02326E3E
	pop {r3}	; 02326E40
	bx r3	; 02326E42
pool_02326E44:
loc_02326E44:
	.word 0x02355D80	; 02326E44
pool_02326E48:
loc_02326E48:
	.word NdsCartHeaderRamAddress + 0x68	; 02326E48
pool_02326E4C:
loc_02326E4C:
	.word P1_BssStart + 0x24E24	; 02326E4C
pool_02326E50:
loc_02326E50:
	.word 0x00000840	; 02326E50
pool_02326E54:
loc_02326E54:
	.word 0x0000FFFF	; 02326E54
pool_02326E58:
loc_02326E58:
	.word 0x00000820	; 02326E58

; ===== function loc_02326E5C =====
loc_02326E5C:
	push {lr}	; 02326E5C
	sub sp,#0x4	; 02326E5E
	add r1,r0,#0x0	; 02326E60
	ldr r0,[pool_02326E84]	; 02326E62
	ldr r0,[r0,#0x0]	; 02326E64
	cmp r0,#0x0	; 02326E66
	bne loc_02326E72	; 02326E68
	mov r0,#0x0	; 02326E6A
	add sp,#0x4	; 02326E6C
	pop {r3}	; 02326E6E
	bx r3	; 02326E70
loc_02326E72:
	ldr r0,[pool_02326E88]	; 02326E72
	ldr r2,[pool_02326E8C]	; 02326E74
	blx loc_0232E304	; 02326E76
	mov r0,#0x1	; 02326E7A
	add sp,#0x4	; 02326E7C
	pop {r3}	; 02326E7E
	bx r3	; 02326E80
	.byte 0xC0, 0x46	; 02326E84
pool_02326E84:
loc_02326E84:
	.word P1_BssStart + 0x24E24	; 02326E84
pool_02326E88:
loc_02326E88:
	.word 0x02355D80	; 02326E88
pool_02326E8C:
loc_02326E8C:
	.word 0x00000840	; 02326E8C

; ===== function loc_02326E90 =====
loc_02326E90:
	push {lr}	; 02326E90
	sub sp,#0x4	; 02326E92
	ldr r0,[pool_02326F04]	; 02326E94
	bl loc_02328014	; 02326E96
	ldr r1,[pool_02326F08]	; 02326E9A
	str r0,[r1,#0x0]	; 02326E9C
	ldr r0,[r1,#0x0]	; 02326E9E
	cmp r0,#0x0	; 02326EA0
	beq loc_02326ED6	; 02326EA2
	mov r0,#0x0	; 02326EA4
	str r0,[sp,#0x0]	; 02326EA6
	add r0,sp,#0x0	; 02326EA8
	ldr r1,[pool_02326F04]	; 02326EAA
	ldr r2,[pool_02326F0C]	; 02326EAC
	bl loc_0232C3FE	; 02326EAE
	ldr r0,[pool_02326F10]	; 02326EB2
	ldrh r2,[r0,#0x0]	; 02326EB4
	ldr r1,[pool_02326F14]	; 02326EB6
	orr r2,r1	; 02326EB8
	strh r2,[r0,#0x0]	; 02326EBA
	mov r2,#0x5	; 02326EBC
	ldr r1,[pool_02326F04]	; 02326EBE
	strb r2,[r1,#0x0]	; 02326EC0
	ldrh r2,[r0,#0x0]	; 02326EC2
	mov r1,#0x7	; 02326EC4
	bic r2,r1	; 02326EC6
	mov r1,#0x1	; 02326EC8
	orr r2,r1	; 02326ECA
	strh r2,[r0,#0x0]	; 02326ECC
	ldr r0,[pool_02326F18]	; 02326ECE
	strb r1,[r0,#0x0]	; 02326ED0
	ldr r0,[pool_02326F1C]	; 02326ED2
	strb r1,[r0,#0x0]	; 02326ED4
loc_02326ED6:
	ldr r0,[pool_02326F20]	; 02326ED6
	ldrb r1,[r0,#0x0]	; 02326ED8
	mov r0,#0x1	; 02326EDA
	and r1,r0	; 02326EDC
	cmp r1,#0x0	; 02326EDE
	beq loc_02326EFE	; 02326EE0
	ldr r2,[pool_02326F10]	; 02326EE2
	ldrh r1,[r2,#0x0]	; 02326EE4
	ldr r0,[pool_02326F24]	; 02326EE6
	and r1,r0	; 02326EE8
	strh r1,[r2,#0x0]	; 02326EEA
	mov r1,#0x0	; 02326EEC
	ldr r0,[pool_02326F28]	; 02326EEE
	str r1,[r0,#0x0]	; 02326EF0
	str r1,[r0,#0x4]	; 02326EF2
	ldr r0,[pool_02326F2C]	; 02326EF4
	strb r1,[r0,#0x0]	; 02326EF6
	ldr r0,[pool_02326F04]	; 02326EF8
	bl loc_02327F08	; 02326EFA
loc_02326EFE:
	add sp,#0x4	; 02326EFE
	pop {r3}	; 02326F00
	bx r3	; 02326F02
pool_02326F04:
loc_02326F04:
	.word FirmwareUserSettingsSharedAddress	; 02326F04
pool_02326F08:
loc_02326F08:
	.word 0x027FF864	; 02326F08
pool_02326F0C:
loc_02326F0C:
	.word 0x0100001C	; 02326F0C
pool_02326F10:
loc_02326F10:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02326F10
pool_02326F14:
loc_02326F14:
	.word 0x00000200	; 02326F14
pool_02326F18:
loc_02326F18:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 02326F18
pool_02326F1C:
loc_02326F1C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthDayOffset	; 02326F1C
pool_02326F20:
loc_02326F20:
	.word 0x027FF818	; 02326F20
pool_02326F24:
loc_02326F24:
	.word 0xFFFFBFFF	; 02326F24
pool_02326F28:
loc_02326F28:
	.word FirmwareUserSettingsSharedAddress + UserSettingsRtcOffset	; 02326F28
pool_02326F2C:
loc_02326F2C:
	.word FirmwareUserSettingsSharedAddress + 0x66	; 02326F2C
.arm
; 此段随后覆盖复制至 ITCM；运行入口不是 CRT 初始内容。
; This stub later replaces ITCM contents; its entry is not the CRT image.
P1_TransitionCopySource:
.func P1_TransitionLoadEntry
	ldr r0,[pool_02326F74]	; 02326F30
	mov r1,#0x9	; 02326F34
	str r1,[r0,#0x0]	; 02326F38
	ldr r1,[pool_02326F78]	; 02326F3C
	b loc_02326F4C	; 02326F40
loc_02326F44:
	mov r0,#0x400	; 02326F44
	swi 0x30000	; 02326F48
loc_02326F4C:
	ldr r0,[r1,#0x0]	; 02326F4C
	cmp r0,#0xa	; 02326F50
	bne loc_02326F44	; 02326F54
	ldr r1,[pool_02326F7C]	; 02326F58
	ldrh r0,[r1,#0x0]	; 02326F5C
	bic r0,r0,#0x4000	; 02326F60
	strh r0,[r1,#0x0]	; 02326F64
	mov r0,#0x0	; 02326F68
	mcr p15,0x0,r0,c7,c0,0x4	; 02326F6C
	bx lr	; 02326F70
.endfunc
.definelabel P1_TransitionItcmBase, 0x01FF8000
.definelabel P1_TransitionRuntimeEntry, P1_TransitionItcmBase + (P1_TransitionLoadEntry - P1_TransitionCopySource)
pool_02326F74:
loc_02326F74:
	.word 0x027FF880	; 02326F74
pool_02326F78:
loc_02326F78:
	.word 0x027FF884	; 02326F78
pool_02326F7C:
loc_02326F7C:
	.word REG_EXMEMCNT_ARM9	; 02326F7C
.thumb

; ===== function loc_02326F80 =====
loc_02326F80:
	push {lr}	; 02326F80
	sub sp,#0x4	; 02326F82
	mov r0,#0x3	; 02326F84
	bl loc_0232D448	; 02326F86
	mov r0,#0x0	; 02326F8A
	str r0,[sp,#0x0]	; 02326F8C
	ldr r0,[sp,#0x0]	; 02326F8E
	ldr r1,[pool_02326FA0]	; 02326F90
	ldr r2,[pool_02326FA4]	; 02326F92
	blx loc_0232E34C	; 02326F94
	add sp,#0x4	; 02326F98
	pop {r3}	; 02326F9A
	bx r3	; 02326F9C
	.byte 0xC0, 0x46	; 02326FA0
pool_02326FA0:
loc_02326FA0:
	.word 0x06800000	; 02326FA0
pool_02326FA4:
loc_02326FA4:
	.word 0x00040000	; 02326FA4

; ===== function loc_02326FA8 =====
loc_02326FA8:
	push {lr}	; 02326FA8
	sub sp,#0x4	; 02326FAA
	ldr r0,[pool_0232705C]	; 02326FAC
	ldrh r0,[r0,#0x0]	; 02326FAE
	lsl r0,r0,#0x1c	; 02326FB0
	lsr r0,r0,#0x1f	; 02326FB2
	cmp r0,#0x0	; 02326FB4
	beq loc_02326FCA	; 02326FB6
	ldr r0,[pool_02327060]	; 02326FB8
	ldr r0,[r0,#0x0]	; 02326FBA
	cmp r0,#0x0	; 02326FBC
	bne loc_02326FCA	; 02326FBE
	mov r0,#0x0	; 02326FC0
	add r1,r0,#0x0	; 02326FC2
	bl loc_0232F760	; 02326FC4
	b loc_02326FD2	; 02326FC8
loc_02326FCA:
	mov r0,#0x1	; 02326FCA
	mov r1,#0x0	; 02326FCC
	bl loc_0232F760	; 02326FCE
loc_02326FD2:
	ldr r1,[pool_02327064]	; 02326FD2
	ldrh r0,[r1,#0x0]	; 02326FD4
	mov r0,#0x0	; 02326FD6
	strh r0,[r1,#0x0]	; 02326FD8
	bl loc_0232AD74	; 02326FDA
	bl loc_0232D2BC	; 02326FDE
	bl loc_0232D2AC	; 02326FE2
	bl loc_0232D27C	; 02326FE6
	bl loc_0232D26C	; 02326FEA
	bl loc_0232D29C	; 02326FEE
	ldr r0,[pool_02327068]	; 02326FF2
	bl loc_0232D448	; 02326FF4
	mov r0,#0x0	; 02326FF8
	str r0,[sp,#0x0]	; 02326FFA
	ldr r0,[sp,#0x0]	; 02326FFC
	ldr r1,[pool_0232706C]	; 02326FFE
	ldr r2,[pool_02327070]	; 02327000
	blx loc_0232E34C	; 02327002
	bl loc_0232D28C	; 02327006
	bl loc_02326F80	; 0232700A
	bl loc_0232D0A0	; 0232700E
	ldr r0,[pool_02327074]	; 02327012
	ldrh r2,[r0,#0x0]	; 02327014
	mov r1,#0x2	; 02327016
	orr r2,r1	; 02327018
	strh r2,[r0,#0x0]	; 0232701A
	ldrh r2,[r0,#0x0]	; 0232701C
	ldr r1,[pool_02327078]	; 0232701E
	and r2,r1	; 02327020
	strh r2,[r0,#0x0]	; 02327022
	ldrh r2,[r0,#0x0]	; 02327024
	mov r1,#0xc	; 02327026
	bic r2,r1	; 02327028
	strh r2,[r0,#0x0]	; 0232702A
	ldr r1,[pool_0232705C]	; 0232702C
	ldrh r1,[r1,#0x0]	; 0232702E
	lsl r1,r1,#0x1c	; 02327030
	lsr r1,r1,#0x1f	; 02327032
	cmp r1,#0x0	; 02327034
	beq loc_02327048	; 02327036
	ldr r1,[pool_02327060]	; 02327038
	ldr r1,[r1,#0x0]	; 0232703A
	cmp r1,#0x0	; 0232703C
	bne loc_02327048	; 0232703E
	ldrh r2,[r0,#0x0]	; 02327040
	ldr r1,[pool_0232707C]	; 02327042
	and r2,r1	; 02327044
	strh r2,[r0,#0x0]	; 02327046
loc_02327048:
; CpuFastSet 的 0x100 个字复制 0x400 字节，再进入新的 ITCM 段。
; CpuFastSet copies 0x100 words (0x400 bytes), then enters the new ITCM stub.
	ldr r0,[pool_02327080]	; 02327048
	ldr r1,[pool_02327084]	; 0232704A
	ldr r2,[pool_02327088]	; 0232704C
	bl loc_0232C3FE	; 0232704E
	ldr r0,[pool_02327084]	; 02327052
	blx r0	; 02327054
	add sp,#0x4	; 02327056
	pop {r3}	; 02327058
	bx r3	; 0232705A
pool_0232705C:
loc_0232705C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 0232705C
pool_02327060:
loc_02327060:
	.word 0x027FF864	; 02327060
pool_02327064:
loc_02327064:
	.word REG_IME	; 02327064
pool_02327068:
loc_02327068:
	.word 0x000001FF	; 02327068
pool_0232706C:
loc_0232706C:
	.word 0x06800000	; 0232706C
pool_02327070:
loc_02327070:
	.word 0x000A4000	; 02327070
pool_02327074:
loc_02327074:
	.word REG_POWERCNT	; 02327074
pool_02327078:
loc_02327078:
	.word 0xFFFFFDFF	; 02327078
pool_0232707C:
loc_0232707C:
	.word 0xFFFF7FFF	; 0232707C
pool_02327080:
loc_02327080:
	.word P1_TransitionCopySource	; 02327080
pool_02327084:
loc_02327084:
	.word P1_TransitionRuntimeEntry	; 02327084
pool_02327088:
loc_02327088:
	.word 0x00000100	; 02327088

; ===== function loc_0232708C =====
loc_0232708C:
	push {lr}	; 0232708C
	sub sp,#0x24	; 0232708E
	mov r0,#0x0	; 02327090
	bl loc_0232AD74	; 02327092
	mov r0,#0x0	; 02327096
	mvn r0,r0	; 02327098
	bl loc_0232ACFC	; 0232709A
	ldr r0,[pool_02327140]	; 0232709E
	bl loc_0232D448	; 023270A0
	mov r0,#0x0	; 023270A4
	str r0,[sp,#0x0]	; 023270A6
	ldr r0,[sp,#0x0]	; 023270A8
	ldr r1,[pool_02327144]	; 023270AA
	ldr r2,[pool_02327148]	; 023270AC
	blx loc_0232E34C	; 023270AE
	bl loc_0232D28C	; 023270B2
	mov r0,#0x0	; 023270B6
	str r0,[sp,#0x4]	; 023270B8
	ldr r0,[sp,#0x4]	; 023270BA
	ldr r1,[pool_0232714C]	; 023270BC
	ldr r2,[pool_02327150]	; 023270BE
	blx loc_0232E34C	; 023270C0
	mov r0,#0x0	; 023270C4
	str r0,[sp,#0x8]	; 023270C6
	ldr r0,[sp,#0x8]	; 023270C8
	ldr r1,[pool_02327154]	; 023270CA
	ldr r2,[pool_02327150]	; 023270CC
	blx loc_0232E34C	; 023270CE
	mov r0,#0x0	; 023270D2
	str r0,[sp,#0xc]	; 023270D4
	ldr r0,[sp,#0xc]	; 023270D6
	ldr r1,[pool_02327158]	; 023270D8
	ldr r2,[pool_02327150]	; 023270DA
	blx loc_0232E34C	; 023270DC
	mov r0,#0x0	; 023270E0
	str r0,[sp,#0x10]	; 023270E2
	ldr r0,[sp,#0x10]	; 023270E4
	ldr r1,[pool_0232715C]	; 023270E6
	ldr r2,[pool_02327150]	; 023270E8
	blx loc_0232E34C	; 023270EA
	mov r0,#0x0	; 023270EE
	str r0,[sp,#0x14]	; 023270F0
	ldr r0,[sp,#0x14]	; 023270F2
	ldr r1,[pool_02327160]	; 023270F4
	ldr r2,[pool_02327164]	; 023270F6
	blx loc_0232E34C	; 023270F8
	mov r0,#0x0	; 023270FC
	str r0,[sp,#0x18]	; 023270FE
	ldr r0,[sp,#0x18]	; 02327100
	ldr r1,[pool_02327168]	; 02327102
	mov r2,#0x40	; 02327104
	blx loc_0232E34C	; 02327106
	mov r0,#0x0	; 0232710A
	str r0,[sp,#0x1c]	; 0232710C
	ldr r0,[sp,#0x1c]	; 0232710E
	ldr r1,[pool_0232716C]	; 02327110
	mov r2,#0x6e	; 02327112
	blx loc_0232E34C	; 02327114
	mov r0,#0x0	; 02327118
	ldr r1,[pool_02327168]	; 0232711A
	strh r0,[r1,#0x0]	; 0232711C
	ldr r1,[pool_02327170]	; 0232711E
	str r0,[r1,#0x0]	; 02327120
	mov r2,#0x1	; 02327122
	ldr r1,[pool_02327174]	; 02327124
	str r2,[r1,#0x0]	; 02327126
	str r0,[r1,#0x4]	; 02327128
	ldr r2,[pool_02327178]	; 0232712A
	ldr r1,[pool_0232717C]	; 0232712C
	strh r2,[r1,#0x0]	; 0232712E
	ldr r1,[pool_02327180]	; 02327130
	str r0,[r1,#0x0]	; 02327132
	ldr r1,[pool_02327184]	; 02327134
	strh r0,[r1,#0x0]	; 02327136
	add sp,#0x24	; 02327138
	pop {r3}	; 0232713A
	bx r3	; 0232713C
	.byte 0xC0, 0x46	; 02327140
pool_02327140:
loc_02327140:
	.word 0x000001FF	; 02327140
pool_02327144:
loc_02327144:
	.word 0x06800000	; 02327144
pool_02327148:
loc_02327148:
	.word 0x000A4000	; 02327148
pool_0232714C:
loc_0232714C:
	.word 0x07000000	; 0232714C
pool_02327150:
loc_02327150:
	.word 0x00000400	; 02327150
pool_02327154:
loc_02327154:
	.word 0x05000000	; 02327154
pool_02327158:
loc_02327158:
	.word 0x07000400	; 02327158
pool_0232715C:
loc_0232715C:
	.word 0x05000400	; 0232715C
pool_02327160:
loc_02327160:
	.word REG_BG0CNT	; 02327160
pool_02327164:
loc_02327164:
	.word 0x0000012C	; 02327164
pool_02327168:
loc_02327168:
	.word REG_DIVCNT	; 02327168
pool_0232716C:
loc_0232716C:
	.word REG_DISPCNT_B	; 0232716C
pool_02327170:
loc_02327170:
	.word REG_DIV_NUMER	; 02327170
pool_02327174:
loc_02327174:
	.word REG_DIV_DENOM	; 02327174
pool_02327178:
loc_02327178:
	.word 0x00004008	; 02327178
pool_0232717C:
loc_0232717C:
	.word REG_IPC_FIFO_CR	; 0232717C
pool_02327180:
loc_02327180:
	.word REG_DISPCNT_A	; 02327180
pool_02327184:
loc_02327184:
	.word REG_DISPSTAT	; 02327184

; ===== function loc_02327188 =====
loc_02327188:
	ldr r1,[pool_0232719C]	; 02327188
	ldr r1,[r1,#0x0]	; 0232718A
	and r1,r0	; 0232718C
	cmp r1,#0x0	; 0232718E
	beq loc_02327196	; 02327190
	mov r0,#0x1	; 02327192
	bx lr	; 02327194
loc_02327196:
	mov r0,#0x0	; 02327196
	bx lr	; 02327198
	.byte 0xC0, 0x46	; 0232719C
pool_0232719C:
loc_0232719C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232719C

; ===== function loc_023271A0 =====
loc_023271A0:
	push {r4,lr}	; 023271A0
	ldr r0,[pool_02327218]	; 023271A2
	ldr r1,[pool_0232721C]	; 023271A4
	ldr r2,[pool_02327220]	; 023271A6
	sub r2,r2,r0	; 023271A8
	blx loc_0232E398	; 023271AA
	ldr r0,[pool_02327218]	; 023271AE
	ldr r1,[pool_02327224]	; 023271B0
	blx P1_CleanDataCacheRange	; 023271B2
	mov r4,#0x0	; 023271B6
loc_023271B8:
	add r0,r4,#0x0	; 023271B8
	bl loc_0232E1D4	; 023271BA
	add r4,r4,#0x1	; 023271BE
	cmp r4,#0x3	; 023271C0
	ble loc_023271B8	; 023271C2
	bl loc_023278B4	; 023271C4
	bl loc_0232708C	; 023271C8
	mov r0,#0x0	; 023271CC
	bl loc_0232D114	; 023271CE
	ldr r0,[pool_02327228]	; 023271D2
	ldr r1,[pool_0232722C]	; 023271D4
	bl loc_0232ADD0	; 023271D6
	ldr r0,[pool_02327228]	; 023271DA
	bl loc_0232AD74	; 023271DC
	ldr r1,[pool_02327230]	; 023271E0
	ldr r0,[pool_02327234]	; 023271E2
	strh r1,[r0,#0x0]	; 023271E4
	mov r1,#0x7	; 023271E6
	ldr r0,[pool_02327238]	; 023271E8
	str r1,[r0,#0x0]	; 023271EA
	mov r0,#0x1	; 023271EC
	ldr r1,[pool_02327228]	; 023271EE
	blx loc_0232ABB8	; 023271F0
	ldr r2,[pool_02327234]	; 023271F4
	ldrh r1,[r2,#0x0]	; 023271F6
	ldr r0,[pool_0232723C]	; 023271F8
	and r1,r0	; 023271FA
	strh r1,[r2,#0x0]	; 023271FC
	ldr r1,[pool_02327240]	; 023271FE
	ldrh r0,[r1,#0x0]	; 02327200
	mov r0,#0x0	; 02327202
	strh r0,[r1,#0x0]	; 02327204
	bl loc_0232AD74	; 02327206
	mov r0,#0x0	; 0232720A
	mvn r0,r0	; 0232720C
	bl loc_0232ACFC	; 0232720E
	pop {r4}	; 02327212
	pop {r3}	; 02327214
	bx r3	; 02327216
pool_02327218:
loc_02327218:
	.word 0x02327990	; 02327218
pool_0232721C:
loc_0232721C:
	.word 0x023FEE00	; 0232721C
pool_02327220:
loc_02327220:
	.word 0x02327AF8	; 02327220
pool_02327224:
loc_02327224:
	.word 0x00000200	; 02327224
pool_02327228:
loc_02327228:
	.word 0x00010000	; 02327228
pool_0232722C:
loc_0232722C:
	.word P1_IrqHandler_02327244 + 1	; 0232722C
pool_02327230:
loc_02327230:
	.word 0x00004F00	; 02327230
pool_02327234:
loc_02327234:
	.word REG_IPC_SYNC	; 02327234
pool_02327238:
loc_02327238:
	.word 0x027FF880	; 02327238
pool_0232723C:
loc_0232723C:
	.word 0x00000F00	; 0232723C
pool_02327240:
loc_02327240:
	.word REG_IME	; 02327240
P1_IrqHandler_02327244:
	ldr r1,[pool_02327254]	; 02327244
	ldr r0,[pool_02327258]	; 02327246
	add r2,r1,r0	; 02327248
	ldr r1,[r2,#0x0]	; 0232724A
	ldr r0,[pool_0232725C]	; 0232724C
	orr r1,r0	; 0232724E
	str r1,[r2,#0x0]	; 02327250
	bx lr	; 02327252
pool_02327254:
loc_02327254:
	.word 0x03000000	; 02327254
pool_02327258:
loc_02327258:
	.word 0x00003FF8	; 02327258
pool_0232725C:
loc_0232725C:
	.word 0x00010000	; 0232725C

; ===== function loc_02327260 =====
loc_02327260:
; 将参数中的事件位并入双核共享位图。
; OR the requested event bits into the shared bitmap.
.func P1_OrSharedEventFlags
	push {r4,lr}	; 02327260
	add r4,r0,#0x0	; 02327262
	mov r0,#0x6e	; 02327264
	ldr r1,[pool_02327288]	; 02327266
	mov r2,#0x0	; 02327268
	bl loc_0232B09C	; 0232726A
	ldr r1,[pool_02327288]	; 0232726E
	add r2,r1,#0x0	; 02327270
	add r2,#0x8	; 02327272
	ldr r0,[r2,#0x0]	; 02327274
	orr r0,r4	; 02327276
	str r0,[r2,#0x0]	; 02327278
	mov r0,#0x6e	; 0232727A
	mov r2,#0x0	; 0232727C
	bl loc_0232B024	; 0232727E
	pop {r4}	; 02327282
	pop {r3}	; 02327284
	bx r3	; 02327286
.endfunc
pool_02327288:
loc_02327288:
	.word FirmwareBootSharedAddress + BootSharedEventSyncOffset	; 02327288

; ===== function loc_0232728C =====
loc_0232728C:
	ldr r0,[pool_02327294]	; 0232728C
	ldr r3,[pool_02327298]	; 0232728E
	bx r3	; 02327290
	.byte 0xC0, 0x46	; 02327294
pool_02327294:
loc_02327294:
	.word 0x80000040	; 02327294
pool_02327298:
loc_02327298:
	.word P1_OrSharedEventFlags + 1	; 02327298

; ===== function loc_0232729C =====
loc_0232729C:
	ldr r0,[pool_023272A4]	; 0232729C
	ldr r3,[pool_023272A8]	; 0232729E
	bx r3	; 023272A0
	.byte 0xC0, 0x46	; 023272A4
pool_023272A4:
loc_023272A4:
	.word 0x80000100	; 023272A4
pool_023272A8:
loc_023272A8:
	.word P1_OrSharedEventFlags + 1	; 023272A8

; ===== function loc_023272AC =====
loc_023272AC:
	ldr r0,[pool_023272B4]	; 023272AC
	ldr r3,[pool_023272B8]	; 023272AE
	bx r3	; 023272B0
	.byte 0xC0, 0x46	; 023272B4
pool_023272B4:
loc_023272B4:
	.word 0x80000080	; 023272B4
pool_023272B8:
loc_023272B8:
	.word P1_OrSharedEventFlags + 1	; 023272B8

; ===== function loc_023272BC =====
loc_023272BC:
	ldr r0,[pool_023272C4]	; 023272BC
	ldr r3,[pool_023272C8]	; 023272BE
	bx r3	; 023272C0
	.byte 0xC0, 0x46	; 023272C4
pool_023272C4:
loc_023272C4:
	.word 0x80000010	; 023272C4
pool_023272C8:
loc_023272C8:
	.word P1_OrSharedEventFlags + 1	; 023272C8

; ===== function loc_023272CC =====
loc_023272CC:
	push {lr}	; 023272CC
	sub sp,#0x4	; 023272CE
	ldr r0,[pool_02327300]	; 023272D0
	bl loc_02326CC4	; 023272D2
	cmp r0,#0x0	; 023272D6
	beq loc_023272E4	; 023272D8
	ldr r1,[pool_02327304]	; 023272DA
	mov r0,#0x0	; 023272DC
	ldrsh r0,[r1,r0]	; 023272DE
	cmp r0,#0x1	; 023272E0
	bne loc_023272F2	; 023272E2
loc_023272E4:
	mov r0,#0x4	; 023272E4
	bl P1_OrSharedEventFlags	; 023272E6
	mov r0,#0x0	; 023272EA
	add sp,#0x4	; 023272EC
	pop {r3}	; 023272EE
	bx r3	; 023272F0
loc_023272F2:
	ldr r0,[pool_02327308]	; 023272F2
	bl P1_OrSharedEventFlags	; 023272F4
	mov r0,#0x1	; 023272F8
	add sp,#0x4	; 023272FA
	pop {r3}	; 023272FC
	bx r3	; 023272FE
pool_02327300:
loc_02327300:
	.word 0x027FFEC0	; 02327300
pool_02327304:
loc_02327304:
	.word 0x027FF812	; 02327304
pool_02327308:
loc_02327308:
	.word 0x80000020	; 02327308

; ===== function loc_0232730C =====
loc_0232730C:
	push {lr}	; 0232730C
	sub sp,#0x4	; 0232730E
	ldr r0,[pool_02327334]	; 02327310
	ldr r2,[r0,#0x0]	; 02327312
	mov r0,#0x8	; 02327314
	add r1,r2,#0x0	; 02327316
	and r1,r0	; 02327318
	cmp r1,#0x0	; 0232731A
	bne loc_0232732C	; 0232731C
	ldr r0,[pool_02327338]	; 0232731E
	and r2,r0	; 02327320
	cmp r2,#0x0	; 02327322
	beq loc_0232732C	; 02327324
	ldr r0,[pool_0232733C]	; 02327326
	bl P1_OrSharedEventFlags	; 02327328
loc_0232732C:
	add sp,#0x4	; 0232732C
	pop {r3}	; 0232732E
	bx r3	; 02327330
	.byte 0xC0, 0x46	; 02327334
pool_02327334:
loc_02327334:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327334
pool_02327338:
loc_02327338:
	.word 0x00000400	; 02327338
pool_0232733C:
loc_0232733C:
	.word 0x08000000	; 0232733C

; ===== function loc_02327340 =====
loc_02327340:
	push {r4,lr}	; 02327340
	sub sp,#0x10	; 02327342
	ldr r0,[pool_02327534]	; 02327344
	ldr r1,[r0,#0x20]	; 02327346
	cmp r1,#0x8	; 02327348
	bls loc_0232734E	; 0232734A
	b loc_0232752A	; 0232734C
loc_0232734E:
	add r1,r1,r1	; 0232734E
P1_SwitchIndexPC_0232734E:
	add r1,pc	; 02327350
	ldrh r1,[r1,#(P1_SwitchTable_0232734E - (P1_SwitchIndexPC_0232734E + 4))]	; 02327352
	lsl r1,r1,#0x10	; 02327354
	asr r1,r1,#0x10	; 02327356
P1_SwitchTargetPC_0232734E:
	add r1,pc	; 02327358
	bx r1	; 0232735A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232734E:
	.halfword (loc_0232752A + 1) - (P1_SwitchTargetPC_0232734E + 4)
	.halfword (loc_0232752A + 1) - (P1_SwitchTargetPC_0232734E + 4)
	.halfword (loc_0232736E + 1) - (P1_SwitchTargetPC_0232734E + 4)
	.halfword (loc_023273C6 + 1) - (P1_SwitchTargetPC_0232734E + 4)
	.halfword (loc_02327416 + 1) - (P1_SwitchTargetPC_0232734E + 4)
	.halfword (loc_02327430 + 1) - (P1_SwitchTargetPC_0232734E + 4)
	.halfword (loc_02327442 + 1) - (P1_SwitchTargetPC_0232734E + 4)
	.halfword (loc_0232752A + 1) - (P1_SwitchTargetPC_0232734E + 4)
	.halfword (loc_02327494 + 1) - (P1_SwitchTargetPC_0232734E + 4)
P1_SwitchTable_0232734EEnd:
loc_0232736E:
	bl loc_02326E90	; 0232736E
	bl loc_02326D5C	; 02327372
	bl loc_02326D40	; 02327376
	mov r4,#0x0	; 0232737A
	bl loc_02326D00	; 0232737C
	cmp r0,#0x0	; 02327380
	beq loc_02327396	; 02327382
	mov r0,#0x2	; 02327384
	orr r4,r0	; 02327386
	ldr r0,[pool_02327538]	; 02327388
	bl loc_02326CC4	; 0232738A
	cmp r0,#0x0	; 0232738E
	bne loc_02327396	; 02327390
	mov r0,#0x4	; 02327392
	orr r4,r0	; 02327394
loc_02327396:
	bl loc_023281C0	; 02327396
	cmp r0,#0x0	; 0232739A
	beq loc_023273AC	; 0232739C
	mov r0,#0x1	; 0232739E
	orr r4,r0	; 023273A0
	ldr r2,[pool_0232753C]	; 023273A2
	ldrb r1,[r2,#0x0]	; 023273A4
	bic r1,r0	; 023273A6
	orr r1,r0	; 023273A8
	strb r1,[r2,#0x0]	; 023273AA
loc_023273AC:
	bl loc_02326BF0	; 023273AC
	bl P1_Runtime_01FF8084	; 023273B0
	ldr r0,[pool_02327540]	; 023273B4
	orr r4,r0	; 023273B6
	add r0,r4,#0x0	; 023273B8
	bl P1_OrSharedEventFlags	; 023273BA
	mov r1,#0x3	; 023273BE
	ldr r0,[pool_02327534]	; 023273C0
	str r1,[r0,#0x20]	; 023273C2
	b loc_0232752A	; 023273C4
loc_023273C6:
	ldr r3,[pool_02327544]	; 023273C6
	ldr r2,[r3,#0x0]	; 023273C8
	ldr r1,[pool_02327548]	; 023273CA
	and r2,r1	; 023273CC
	cmp r2,#0x0	; 023273CE
	bne loc_023273D4	; 023273D0
	b loc_0232752A	; 023273D2
loc_023273D4:
	ldr r2,[r3,#0x0]	; 023273D4
	mov r1,#0x20	; 023273D6
	and r2,r1	; 023273D8
	cmp r2,#0x0	; 023273DA
	beq loc_023273EC	; 023273DC
	mov r0,#0x3	; 023273DE
	bl loc_02326D30	; 023273E0
	mov r1,#0x4	; 023273E4
	ldr r0,[pool_02327534]	; 023273E6
	str r1,[r0,#0x20]	; 023273E8
	b loc_0232752A	; 023273EA
loc_023273EC:
	ldr r2,[r3,#0x0]	; 023273EC
	mov r1,#0x10	; 023273EE
	and r2,r1	; 023273F0
	cmp r2,#0x0	; 023273F2
	beq loc_023273FC	; 023273F4
	mov r1,#0x5	; 023273F6
	str r1,[r0,#0x20]	; 023273F8
	b loc_0232752A	; 023273FA
loc_023273FC:
	ldr r1,[r3,#0x0]	; 023273FC
	ldr r0,[pool_0232754C]	; 023273FE
	and r1,r0	; 02327400
	cmp r1,#0x0	; 02327402
	bne loc_02327408	; 02327404
	b loc_0232752A	; 02327406
loc_02327408:
	mov r0,#0x6	; 02327408
	bl loc_02326D30	; 0232740A
	mov r1,#0x6	; 0232740E
	ldr r0,[pool_02327534]	; 02327410
	str r1,[r0,#0x20]	; 02327412
	b loc_0232752A	; 02327414
loc_02327416:
	ldr r0,[pool_02327550]	; 02327416
	bl loc_02327188	; 02327418
	cmp r0,#0x0	; 0232741C
	bne loc_02327422	; 0232741E
	b loc_0232752A	; 02327420
loc_02327422:
	bl loc_023271A0	; 02327422
	mov r0,#0x1	; 02327426
	add sp,#0x10	; 02327428
	pop {r4}	; 0232742A
	pop {r3}	; 0232742C
	bx r3	; 0232742E
loc_02327430:
	ldr r0,[r0,#0x24]	; 02327430
	cmp r0,#0x2	; 02327432
	bne loc_0232752A	; 02327434
	mov r0,#0x4	; 02327436
	bl loc_02326D30	; 02327438
	bl loc_02326FA8	; 0232743C
	b loc_0232752A	; 02327440
loc_02327442:
	ldr r0,[pool_02327544]	; 02327442
	ldr r1,[r0,#0x0]	; 02327444
	ldr r0,[pool_02327554]	; 02327446
	and r1,r0	; 02327448
	cmp r1,#0x0	; 0232744A
	beq loc_0232752A	; 0232744C
	bl loc_02326B00	; 0232744E
	ldr r0,[pool_02327558]	; 02327452
	bl P1_OrSharedEventFlags	; 02327454
	mov r0,#0x0	; 02327458
	str r0,[sp,#0x4]	; 0232745A
	ldr r0,[sp,#0x4]	; 0232745C
	ldr r1,[pool_0232755C]	; 0232745E
	ldr r2,[pool_02327560]	; 02327460
	blx loc_0232E34C	; 02327462
; 按此版本的零区起点和字节数清零，SWI 参数换算为 32 位字数。
; Clear this version's zero area; convert its byte size to the SWI word count.
	ldr r2,[pool_02327564]	; 02327466
	cmp r2,#0x0	; 02327468
	beq loc_02327482	; 0232746A
	mov r0,#0x0	; 0232746C
	str r0,[sp,#0x0]	; 0232746E
	add r0,sp,#0x0	; 02327470
	ldr r1,[pool_02327568]	; 02327472
	lsr r2,r2,#0x2	; 02327474
	ldr r3,[pool_0232756C]	; 02327476
	and r2,r3	; 02327478
	ldr r3,[pool_02327570]	; 0232747A
	orr r2,r3	; 0232747C
	bl loc_0232C3FE	; 0232747E
loc_02327482:
	blx P1_CleanEntireDataCacheByIndex	; 02327482
	mov r0,#0x7	; 02327486
	bl loc_02326D30	; 02327488
	mov r1,#0x8	; 0232748C
	ldr r0,[pool_02327534]	; 0232748E
	str r1,[r0,#0x20]	; 02327490
	b loc_0232752A	; 02327492
loc_02327494:
	ldr r0,[pool_02327544]	; 02327494
	ldr r2,[r0,#0x0]	; 02327496
	ldr r1,[pool_02327574]	; 02327498
	and r2,r1	; 0232749A
	cmp r2,#0x0	; 0232749C
	beq loc_0232752A	; 0232749E
	ldr r2,[r0,#0x0]	; 023274A0
	ldr r1,[pool_02327578]	; 023274A2
	and r2,r1	; 023274A4
	cmp r2,#0x0	; 023274A6
	beq loc_0232752A	; 023274A8
	ldr r2,[r0,#0x0]	; 023274AA
	mov r1,#0x80	; 023274AC
	and r2,r1	; 023274AE
	cmp r2,#0x0	; 023274B0
	beq loc_023274BE	; 023274B2
	ldr r0,[pool_0232757C]	; 023274B4
	ldr r0,[r0,#0x0]	; 023274B6
	ldr r0,[r0,#0x0]	; 023274B8
	blx r0	; 023274BA
	b loc_02327520	; 023274BC
loc_023274BE:
	ldr r2,[r0,#0x0]	; 023274BE
	ldr r1,[pool_02327580]	; 023274C0
	and r2,r1	; 023274C2
	cmp r2,#0x0	; 023274C4
	beq loc_0232750E	; 023274C6
	ldr r1,[r0,#0x0]	; 023274C8
	mov r0,#0x2	; 023274CA
	and r1,r0	; 023274CC
	cmp r1,#0x0	; 023274CE
	beq loc_023274D6	; 023274D0
	mov r0,#0x1	; 023274D2
	b loc_023274D8	; 023274D4
loc_023274D6:
	mov r0,#0x0	; 023274D6
loc_023274D8:
	cmp r0,#0x0	; 023274D8
	beq loc_023274FC	; 023274DA
	ldr r0,[pool_02327534]	; 023274DC
	ldr r1,[r0,#0x0]	; 023274DE
	ldr r0,[pool_02327584]	; 023274E0
	str r1,[r0,#0x0]	; 023274E2
	ldr r0,[pool_02327588]	; 023274E4
	ldr r1,[pool_0232758C]	; 023274E6
	ldr r2,[pool_02327590]	; 023274E8
	blx loc_0232E398	; 023274EA
	mov r0,#0x0	; 023274EE
	str r0,[sp,#0x8]	; 023274F0
	ldr r0,[sp,#0x8]	; 023274F2
	ldr r1,[pool_02327588]	; 023274F4
	ldr r2,[pool_02327590]	; 023274F6
	blx loc_0232E34C	; 023274F8
loc_023274FC:
	ldr r0,[pool_0232757C]	; 023274FC
	ldr r0,[r0,#0x0]	; 023274FE
	ldr r0,[r0,#0x4]	; 02327500
	blx r0	; 02327502
	blx P1_CleanEntireDataCacheByIndex	; 02327504
	bl loc_023271A0	; 02327508
	b loc_02327520	; 0232750C
loc_0232750E:
	ldr r1,[r0,#0x0]	; 0232750E
	mov r0,#0x40	; 02327510
	and r1,r0	; 02327512
	cmp r1,#0x0	; 02327514
	beq loc_02327520	; 02327516
	ldr r0,[pool_0232757C]	; 02327518
	ldr r0,[r0,#0x0]	; 0232751A
	ldr r0,[r0,#0x8]	; 0232751C
	blx r0	; 0232751E
loc_02327520:
	mov r0,#0x1	; 02327520
	add sp,#0x10	; 02327522
	pop {r4}	; 02327524
	pop {r3}	; 02327526
	bx r3	; 02327528
loc_0232752A:
	mov r0,#0x0	; 0232752A
	add sp,#0x10	; 0232752C
	pop {r4}	; 0232752E
	pop {r3}	; 02327530
	bx r3	; 02327532
pool_02327534:
loc_02327534:
	.word 0x027FF860	; 02327534
pool_02327538:
loc_02327538:
	.word 0x027FFEC0	; 02327538
pool_0232753C:
loc_0232753C:
	.word FirmwareBootInfoAddress + BootInfoGbaFlagsOffset	; 0232753C
pool_02327540:
loc_02327540:
	.word 0x20000000	; 02327540
pool_02327544:
loc_02327544:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327544
pool_02327548:
loc_02327548:
	.word 0x80000000	; 02327548
pool_0232754C:
loc_0232754C:
	.word 0x000001C0	; 0232754C
pool_02327550:
loc_02327550:
	.word 0x00000200	; 02327550
pool_02327554:
loc_02327554:
	.word 0x00001000	; 02327554
pool_02327558:
loc_02327558:
	.word 0x00000400	; 02327558
pool_0232755C:
loc_0232755C:
	.word 0x02000000	; 0232755C
pool_02327560:
loc_02327560:
	.word 0x00300000	; 02327560
pool_02327564:
loc_02327564:
	.word UiBootZeroBytes	; 02327564
pool_02327568:
loc_02327568:
	.word UiBootZeroStart	; 02327568
pool_0232756C:
loc_0232756C:
	.word 0x001FFFFF	; 0232756C
pool_02327570:
loc_02327570:
	.word 0x01000000	; 02327570
pool_02327574:
loc_02327574:
	.word 0x40000000	; 02327574
pool_02327578:
loc_02327578:
	.word 0x08000000	; 02327578
pool_0232757C:
loc_0232757C:
	.word P1_BssStart + 0x24E28	; 0232757C
pool_02327580:
loc_02327580:
	.word 0x00000100	; 02327580
pool_02327584:
loc_02327584:
	.word NdsCartHeaderArm7RamAddress	; 02327584
pool_02327588:
loc_02327588:
	.word 0x027FFE00	; 02327588
pool_0232758C:
loc_0232758C:
	.word 0x023FE940	; 0232758C
pool_02327590:
loc_02327590:
	.word 0x00000160	; 02327590

; ===== function loc_02327594 =====
loc_02327594:
	push {r4,r5,r6,r7,lr}	; 02327594
	sub sp,#0x4	; 02327596
	ldr r4,[pool_023275E4]	; 02327598
	ldr r6,[pool_023275E8]	; 0232759A
	ldr r7,[pool_023275EC]	; 0232759C
loc_0232759E:
	ldr r5,[r6,#0x0]	; 0232759E
	ldr r0,[pool_023275F0]	; 023275A0
	bl loc_0232C3DC	; 023275A2
	add r0,r5,#0x0	; 023275A6
	and r0,r4	; 023275A8
	cmp r0,#0x0	; 023275AA
	bne loc_023275C0	; 023275AC
	and r5,r7	; 023275AE
	cmp r5,#0x0	; 023275B0
	beq loc_0232759E	; 023275B2
	bl loc_02326B70	; 023275B4
	add r0,r4,#0x0	; 023275B8
	bl P1_OrSharedEventFlags	; 023275BA
	b loc_0232759E	; 023275BE
loc_023275C0:
	mov r1,#0x2	; 023275C0
	ldr r0,[pool_023275F4]	; 023275C2
	str r1,[r0,#0x0]	; 023275C4
	ldr r2,[pool_023275F8]	; 023275C6
	ldrh r1,[r2,#0x0]	; 023275C8
	mov r0,#0x1	; 023275CA
	orr r1,r0	; 023275CC
	strh r1,[r2,#0x0]	; 023275CE
	bl loc_02327970	; 023275D0
	bl loc_02326DBC	; 023275D4
	mov r0,#0x0	; 023275D8
	add sp,#0x4	; 023275DA
	pop {r4,r5,r6,r7}	; 023275DC
	pop {r3}	; 023275DE
	bx r3	; 023275E0
	.byte 0xC0, 0x46	; 023275E4
pool_023275E4:
loc_023275E4:
	.word 0x00000800	; 023275E4
pool_023275E8:
loc_023275E8:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023275E8
pool_023275EC:
loc_023275EC:
	.word 0x00002000	; 023275EC
pool_023275F0:
loc_023275F0:
	.word 0x00001000	; 023275F0
pool_023275F4:
loc_023275F4:
	.word 0x027FF880	; 023275F4
pool_023275F8:
loc_023275F8:
	.word REG_POSTFLG	; 023275F8

; ===== function P1_ClipMemoryRangeToBounds =====
; Rejects a (start,length) range outside the supplied bounds; trims a range that crosses the upper bound.
; 将越出给定边界的（起始地址、长度）范围置零；超过上界时截短长度。
.func P1_ClipMemoryRangeToBounds
loc_023275FC:
	push {r4,r5}	; 023275FC
	ldr r5,[r0,#0x0]	; 023275FE
	ldr r3,[r0,#0x4]	; 02327600
	add r4,r5,r3	; 02327602
	cmp r5,r1	; 02327604
	bcc loc_0232760C	; 02327606
	cmp r5,r2	; 02327608
	bls loc_02327614	; 0232760A
loc_0232760C:
	mov r1,#0x0	; 0232760C
	str r1,[r0,#0x4]	; 0232760E
	pop {r4,r5}	; 02327610
	bx lr	; 02327612
loc_02327614:
	cmp r4,r2	; 02327614
	bls loc_02327622	; 02327616
	add r3,r0,#0x4	; 02327618
	ldr r1,[r3,#0x0]	; 0232761A
	sub r0,r4,r2	; 0232761C
	sub r0,r1,r0	; 0232761E
	str r0,[r3,#0x0]	; 02327620
loc_02327622:
	pop {r4,r5}	; 02327622
	bx lr	; 02327624
.endfunc
	.byte 0x00, 0x00	; 02327628

; ===== function P1_ConstrainNdsHeaderImageLoadRanges =====
; Constrains ARM7/ARM9 image load ranges recorded in the copied NDS card header before boot.
; 启动前约束复制到 RAM 的 NDS 卡带头内 ARM7/ARM9 映像装载范围。
.func P1_ConstrainNdsHeaderImageLoadRanges
loc_02327628:
	push {lr}	; 02327628
	sub sp,#0x4	; 0232762A
	bl loc_02326D00	; 0232762C
	cmp r0,#0x0	; 02327630
	beq loc_02327694	; 02327632
	ldr r0,[pool_0232769C]	; 02327634
	ldr r2,[r0,#0x0]	; 02327636
	ldr r1,[pool_023276A0]	; 02327638
	cmp r2,r1	; 0232763A
	bcc loc_02327652	; 0232763C
	ldr r2,[pool_023276A4]	; 0232763E
	bl P1_ClipMemoryRangeToBounds	; 02327640
	ldr r2,[pool_0232769C]	; 02327644
	ldr r1,[r2,#0x0]	; 02327646
	ldr r0,[pool_023276A8]	; 02327648
	str r1,[r0,#0x0]	; 0232764A
	ldr r0,[pool_023276AC]	; 0232764C
	str r0,[r2,#0x0]	; 0232764E
	b loc_0232768A	; 02327650
loc_02327652:
	ldr r1,[pool_023276B0]	; 02327652
	ldr r2,[pool_023276B4]	; 02327654
	bl P1_ClipMemoryRangeToBounds	; 02327656
	ldr r1,[pool_0232769C]	; 0232765A
	ldr r3,[r1,#0x0]	; 0232765C
	ldr r0,[pool_023276B8]	; 0232765E
	cmp r3,r0	; 02327660
	bcc loc_0232767A	; 02327662
	ldr r0,[pool_023276A8]	; 02327664
	str r3,[r0,#0x0]	; 02327666
	ldr r0,[pool_023276AC]	; 02327668
	str r0,[r1,#0x0]	; 0232766A
	ldr r2,[pool_023276BC]	; 0232766C
	ldr r1,[r2,#0x0]	; 0232766E
	ldr r0,[pool_023276C0]	; 02327670
	cmp r1,r0	; 02327672
	bls loc_0232768A	; 02327674
	str r0,[r2,#0x0]	; 02327676
	b loc_0232768A	; 02327678
loc_0232767A:
	ldr r2,[pool_023276BC]	; 0232767A
	ldr r1,[r2,#0x0]	; 0232767C
	add r3,r3,r1	; 0232767E
	cmp r3,r0	; 02327680
	bls loc_0232768A	; 02327682
	sub r0,r3,r0	; 02327684
	sub r0,r1,r0	; 02327686
	str r0,[r2,#0x0]	; 02327688
loc_0232768A:
	ldr r0,[pool_023276C4]	; 0232768A
	ldr r1,[pool_023276B0]	; 0232768C
	ldr r2,[pool_023276AC]	; 0232768E
	bl P1_ClipMemoryRangeToBounds	; 02327690
loc_02327694:
	add sp,#0x4	; 02327694
	pop {r3}	; 02327696
	bx r3	; 02327698
.endfunc
	.byte 0xC0, 0x46	; 0232769C
pool_0232769C:
loc_0232769C:
	.word NdsCartHeaderArm7RamAddress	; 0232769C
pool_023276A0:
loc_023276A0:
	.word 0x037F8000	; 023276A0
pool_023276A4:
loc_023276A4:
	.word 0x0380F000	; 023276A4
pool_023276A8:
loc_023276A8:
	.word 0x027FF860	; 023276A8
pool_023276AC:
loc_023276AC:
	.word 0x022C0000	; 023276AC
pool_023276B0:
loc_023276B0:
	.word 0x02000000	; 023276B0
pool_023276B4:
loc_023276B4:
	.word 0x023FE000	; 023276B4
pool_023276B8:
loc_023276B8:
	.word 0x02300000	; 023276B8
pool_023276BC:
loc_023276BC:
	.word NdsCartHeaderArm7SizeAddress	; 023276BC
pool_023276C0:
loc_023276C0:
	.word 0x00040000	; 023276C0
pool_023276C4:
loc_023276C4:
	.word NdsCartHeaderArm9RamAddress	; 023276C4

; ===== function loc_023276C8 =====
loc_023276C8:
	push {r4,lr}	; 023276C8
	sub sp,#0x8	; 023276CA
	add r4,r0,#0x0	; 023276CC
	ldr r2,[pool_02327740]	; 023276CE
	ldrh r1,[r2,#0x0]	; 023276D0
	ldr r0,[pool_02327744]	; 023276D2
	orr r1,r0	; 023276D4
	strh r1,[r2,#0x0]	; 023276D6
	ldrh r1,[r2,#0x0]	; 023276D8
	mov r0,#0xc	; 023276DA
	bic r1,r0	; 023276DC
	strh r1,[r2,#0x0]	; 023276DE
	ldrh r1,[r2,#0x0]	; 023276E0
	mov r0,#0x10	; 023276E2
	bic r1,r0	; 023276E4
	strh r1,[r2,#0x0]	; 023276E6
	mov r0,#0x3	; 023276E8
	bl loc_0232E1C8	; 023276EA
	ldr r0,[pool_02327748]	; 023276EE
	ldr r1,[pool_0232774C]	; 023276F0
	blx P1_InvalidateDataCacheRange	; 023276F2
	mov r0,#0x0	; 023276F6
	str r0,[sp,#0x0]	; 023276F8
	add r0,sp,#0x0	; 023276FA
	ldr r1,[pool_02327750]	; 023276FC
	ldr r2,[pool_02327754]	; 023276FE
	bl loc_0232C3FE	; 02327700
	ldr r0,[pool_02327758]	; 02327704
	str r4,[r0,#0x0]	; 02327706
	mov r1,#0x1	; 02327708
	ldr r0,[pool_0232775C]	; 0232770A
	str r1,[r0,#0x0]	; 0232770C
	bl P1_ConstrainNdsHeaderImageLoadRanges	; 0232770E
	bl loc_02326BB4	; 02327712
	ldr r0,[pool_02327760]	; 02327716
	add r0,#0x19	; 02327718
	mov r1,#0x0	; 0232771A
	mov r2,#0x37	; 0232771C
	blx loc_0232E3D0	; 0232771E
	ldr r1,[pool_02327764]	; 02327722
	mov r0,#0x0	; 02327724
	ldrsh r0,[r1,r0]	; 02327726
	cmp r0,#0x0	; 02327728
	bne loc_02327736	; 0232772A
	ldr r2,[pool_02327768]	; 0232772C
	ldr r1,[r2,#0x0]	; 0232772E
	ldr r0,[pool_0232776C]	; 02327730
	orr r1,r0	; 02327732
	str r1,[r2,#0x0]	; 02327734
loc_02327736:
	add sp,#0x8	; 02327736
	pop {r4}	; 02327738
	pop {r3}	; 0232773A
	bx r3	; 0232773C
	.byte 0xC0, 0x46	; 02327740
pool_02327740:
loc_02327740:
	.word REG_EXMEMCNT_ARM9	; 02327740
pool_02327744:
loc_02327744:
	.word 0x00008000	; 02327744
pool_02327748:
loc_02327748:
	.word 0x022C0000	; 02327748
pool_0232774C:
loc_0232774C:
	.word 0x00040000	; 0232774C
pool_02327750:
loc_02327750:
	.word 0x027FF860	; 02327750
pool_02327754:
loc_02327754:
	.word 0x0100001B	; 02327754
pool_02327758:
loc_02327758:
	.word P1_BssStart + 0x24E28	; 02327758
pool_0232775C:
loc_0232775C:
	.word 0x027FF880	; 0232775C
pool_02327760:
loc_02327760:
	.word 0x027FF800	; 02327760
pool_02327764:
loc_02327764:
	.word 0x027FF814	; 02327764
pool_02327768:
loc_02327768:
	.word NdsCartHeaderRamAddress + 0x60	; 02327768
pool_0232776C:
loc_0232776C:
	.word 0x00406000	; 0232776C

; ===== function loc_02327770 =====
loc_02327770:
	push {r4,r5}	; 02327770
	mov r2,#0x80	; 02327772
	ldr r1,[pool_023277A0]	; 02327774
	strb r2,[r1,#0x0]	; 02327776
	mov r2,#0x0	; 02327778
	ldr r1,[pool_023277A4]	; 0232777A
	mov r3,#0x1	; 0232777C
loc_0232777E:
	sub r4,r3,r2	; 0232777E
	lsl r4,r4,#0x2	; 02327780
	ldr r5,[r0,r4]	; 02327782
	lsr r4,r5,#0x18	; 02327784
	strb r4,[r1,#0x0]	; 02327786
	lsr r4,r5,#0x10	; 02327788
	strb r4,[r1,#0x1]	; 0232778A
	lsr r4,r5,#0x8	; 0232778C
	strb r4,[r1,#0x2]	; 0232778E
	strb r5,[r1,#0x3]	; 02327790
	add r1,r1,#0x4	; 02327792
	add r2,r2,#0x1	; 02327794
	cmp r2,#0x2	; 02327796
	blt loc_0232777E	; 02327798
	pop {r4,r5}	; 0232779A
	bx lr	; 0232779C
	.byte 0xC0, 0x46	; 023277A0
pool_023277A0:
loc_023277A0:
	.word REG_AUXSPICNT + 1	; 023277A0
pool_023277A4:
loc_023277A4:
	.word REG_GCCMDOUT	; 023277A4

; ===== function loc_023277A8 =====
loc_023277A8:
	push {r4,r5,r6,r7,lr}	; 023277A8
	sub sp,#0xc	; 023277AA
	add r5,r1,#0x0	; 023277AC
	add r4,r2,#0x0	; 023277AE
	lsl r1,r0,#0x18	; 023277B0
	str r1,[sp,#0x0]	; 023277B2
	lsr r1,r0,#0x8	; 023277B4
	ldr r0,[pool_023277F8]	; 023277B6
	orr r1,r0	; 023277B8
	str r1,[sp,#0x4]	; 023277BA
	add r0,sp,#0x0	; 023277BC
	bl loc_02327770	; 023277BE
	ldr r0,[pool_023277FC]	; 023277C2
	ldr r1,[r0,#0x0]	; 023277C4
	ldr r0,[pool_02327800]	; 023277C6
	orr r1,r0	; 023277C8
	ldr r0,[pool_02327804]	; 023277CA
	str r1,[r0,#0x0]	; 023277CC
	add r2,r5,r4	; 023277CE
	ldr r7,[pool_02327808]	; 023277D0
	ldr r3,[pool_0232780C]	; 023277D2
	ldr r4,[pool_02327810]	; 023277D4
loc_023277D6:
	ldr r1,[r0,#0x0]	; 023277D6
	add r6,r1,#0x0	; 023277D8
	and r6,r4	; 023277DA
	cmp r6,#0x0	; 023277DC
	beq loc_023277EA	; 023277DE
	ldr r6,[r7,#0x0]	; 023277E0
	cmp r5,r2	; 023277E2
	bcs loc_023277E8	; 023277E4
	str r6,[r5,#0x0]	; 023277E6
loc_023277E8:
	add r5,r5,#0x4	; 023277E8
loc_023277EA:
	and r1,r3	; 023277EA
	cmp r1,#0x0	; 023277EC
	bne loc_023277D6	; 023277EE
	add sp,#0xc	; 023277F0
	pop {r4,r5,r6,r7}	; 023277F2
	pop {r3}	; 023277F4
	bx r3	; 023277F6
pool_023277F8:
loc_023277F8:
	.word 0xB7000000	; 023277F8
pool_023277FC:
loc_023277FC:
	.word NdsCartHeaderRamAddress + 0x60	; 023277FC
pool_02327800:
loc_02327800:
	.word 0xA1000000	; 02327800
pool_02327804:
loc_02327804:
	.word REG_ROMCTRL	; 02327804
pool_02327808:
loc_02327808:
	.word REG_GCDATAIN	; 02327808
pool_0232780C:
loc_0232780C:
	.word 0x80000000	; 0232780C
pool_02327810:
loc_02327810:
	.word 0x00800000	; 02327810

; ===== function loc_02327814 =====
loc_02327814:
	push {r4,r5,r6,r7,lr}	; 02327814
	sub sp,#0x4	; 02327816
	add r6,r0,#0x0	; 02327818
	add r7,r1,#0x0	; 0232781A
	add r5,r2,#0x0	; 0232781C
	add r4,r5,#0x0	; 0232781E
	cmp r5,#0x0	; 02327820
	ble loc_02327844	; 02327822
loc_02327824:
	ldr r0,[pool_0232784C]	; 02327824
	cmp r4,r0	; 02327826
	blt loc_0232782E	; 02327828
	lsl r5,r0,#0	; 0232782A
	b loc_02327830	; 0232782C
loc_0232782E:
	add r5,r4,#0x0	; 0232782E
loc_02327830:
	add r0,r6,#0x0	; 02327830
	add r1,r7,#0x0	; 02327832
	add r2,r5,#0x0	; 02327834
	bl loc_023277A8	; 02327836
	add r6,r6,r5	; 0232783A
	add r7,r7,r5	; 0232783C
	sub r4,r4,r5	; 0232783E
	cmp r4,#0x0	; 02327840
	bgt loc_02327824	; 02327842
loc_02327844:
	add sp,#0x4	; 02327844
	pop {r4,r5,r6,r7}	; 02327846
	pop {r3}	; 02327848
	bx r3	; 0232784A
pool_0232784C:
loc_0232784C:
	.word 0x00000200	; 0232784C

; ===== function loc_02327850 =====
loc_02327850:
	push {lr}	; 02327850
	sub sp,#0xc	; 02327852
	mov r0,#0x0	; 02327854
	str r0,[sp,#0x0]	; 02327856
	ldr r0,[pool_02327874]	; 02327858
	str r0,[sp,#0x4]	; 0232785A
	add r0,sp,#0x0	; 0232785C
	bl loc_02327770	; 0232785E
	ldr r0,[pool_02327878]	; 02327862
	ldr r1,[r0,#0x4]	; 02327864
	ldr r0,[pool_0232787C]	; 02327866
	orr r1,r0	; 02327868
	ldr r0,[pool_02327880]	; 0232786A
	str r1,[r0,#0x0]	; 0232786C
	add sp,#0xc	; 0232786E
	pop {r3}	; 02327870
	bx r3	; 02327872
pool_02327874:
loc_02327874:
	.word 0xB8000000	; 02327874
pool_02327878:
loc_02327878:
	.word P1_BssStart + 0x25740	; 02327878
pool_0232787C:
loc_0232787C:
	.word 0xA7000000	; 0232787C
pool_02327880:
loc_02327880:
	.word REG_ROMCTRL	; 02327880

; ===== function loc_02327884 =====
loc_02327884:
	ldr r0,[pool_02327898]	; 02327884
	ldr r1,[r0,#0x0]	; 02327886
	ldr r0,[pool_0232789C]	; 02327888
	and r1,r0	; 0232788A
	cmp r1,#0x0	; 0232788C
	beq loc_02327894	; 0232788E
	mov r0,#0x1	; 02327890
	bx lr	; 02327892
loc_02327894:
	mov r0,#0x0	; 02327894
	bx lr	; 02327896
pool_02327898:
loc_02327898:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327898
pool_0232789C:
loc_0232789C:
	.word 0x00000200	; 0232789C

; ===== function loc_023278A0 =====
loc_023278A0:
	ldr r0,[pool_023278B0]	; 023278A0
	ldr r0,[r0,#0x0]	; 023278A2
	cmp r0,#0x1	; 023278A4
	bne loc_023278AC	; 023278A6
	mov r0,#0x1	; 023278A8
	bx lr	; 023278AA
loc_023278AC:
	mov r0,#0x0	; 023278AC
	bx lr	; 023278AE
pool_023278B0:
loc_023278B0:
	.word P1_BssStart + 0x25740	; 023278B0

; ===== function loc_023278B4 =====
loc_023278B4:
	push {lr}	; 023278B4
	sub sp,#0x4	; 023278B6
	bl loc_023278A0	; 023278B8
	cmp r0,#0x0	; 023278BC
	beq loc_023278CC	; 023278BE
loc_023278C0:
	bl loc_023278D4	; 023278C0
	bl loc_023278A0	; 023278C4
	cmp r0,#0x0	; 023278C8
	bne loc_023278C0	; 023278CA
loc_023278CC:
	add sp,#0x4	; 023278CC
	pop {r3}	; 023278CE
	bx r3	; 023278D0
	.byte 0x00, 0x00	; 023278D4

; ===== function loc_023278D4 =====
loc_023278D4:
	push {lr}	; 023278D4
	sub sp,#0x4	; 023278D6
	bl loc_02327884	; 023278D8
	cmp r0,#0x0	; 023278DC
	bne loc_023278E8	; 023278DE
	mov r0,#0x0	; 023278E0
	add sp,#0x4	; 023278E2
	pop {r3}	; 023278E4
	bx r3	; 023278E6
loc_023278E8:
	ldr r0,[pool_02327958]	; 023278E8
	ldr r1,[r0,#0x0]	; 023278EA
	cmp r1,#0x0	; 023278EC
	beq loc_023278F6	; 023278EE
	cmp r1,#0x1	; 023278F0
	beq loc_0232790C	; 023278F2
	b loc_0232794E	; 023278F4
loc_023278F6:
	ldrh r0,[r0,#0x8]	; 023278F6
	bl loc_0232AF14	; 023278F8
	cmp r0,#0x0	; 023278FC
	bne loc_0232794E	; 023278FE
	bl loc_02327850	; 02327900
	mov r1,#0x1	; 02327904
	ldr r0,[pool_02327958]	; 02327906
	str r1,[r0,#0x0]	; 02327908
	b loc_0232794E	; 0232790A
loc_0232790C:
	ldr r0,[pool_0232795C]	; 0232790C
	ldr r1,[r0,#0x0]	; 0232790E
	ldr r0,[pool_02327960]	; 02327910
	and r1,r0	; 02327912
	cmp r1,#0x0	; 02327914
	beq loc_0232794E	; 02327916
	ldr r0,[pool_02327964]	; 02327918
	ldr r1,[r0,#0x0]	; 0232791A
	ldr r0,[pool_02327968]	; 0232791C
	ldr r0,[r0,#0x0]	; 0232791E
	cmp r1,r0	; 02327920
	beq loc_02327940	; 02327922
	ldr r0,[pool_0232796C]	; 02327924
	ldr r1,[r0,#0x0]	; 02327926
	mov r0,#0x2	; 02327928
	and r1,r0	; 0232792A
	cmp r1,#0x0	; 0232792C
	beq loc_02327934	; 0232792E
	mov r0,#0x1	; 02327930
	b loc_02327936	; 02327932
loc_02327934:
	mov r0,#0x0	; 02327934
loc_02327936:
	cmp r0,#0x0	; 02327936
	beq loc_02327940	; 02327938
	mov r1,#0x1	; 0232793A
	ldr r0,[pool_02327958]	; 0232793C
	strh r1,[r0,#0xa]	; 0232793E
loc_02327940:
	ldr r0,[pool_02327958]	; 02327940
	ldrh r0,[r0,#0x8]	; 02327942
	bl loc_0232AF28	; 02327944
	mov r1,#0x0	; 02327948
	ldr r0,[pool_02327958]	; 0232794A
	str r1,[r0,#0x0]	; 0232794C
loc_0232794E:
	ldr r0,[pool_02327958]	; 0232794E
	ldrh r0,[r0,#0xa]	; 02327950
	add sp,#0x4	; 02327952
	pop {r3}	; 02327954
	bx r3	; 02327956
pool_02327958:
loc_02327958:
	.word P1_BssStart + 0x25740	; 02327958
pool_0232795C:
loc_0232795C:
	.word REG_ROMCTRL	; 0232795C
pool_02327960:
loc_02327960:
	.word 0x00800000	; 02327960
pool_02327964:
loc_02327964:
	.word REG_GCDATAIN	; 02327964
pool_02327968:
loc_02327968:
	.word 0x027FF800	; 02327968
pool_0232796C:
loc_0232796C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232796C

; ===== function loc_02327970 =====
loc_02327970:
	push {lr}	; 02327970
	sub sp,#0x4	; 02327972
	blx loc_0232AE50	; 02327974
	ldr r1,[pool_02327988]	; 02327978
	strh r0,[r1,#0x8]	; 0232797A
	ldr r0,[pool_0232798C]	; 0232797C
	ldr r0,[r0,#0x0]	; 0232797E
	str r0,[r1,#0x4]	; 02327980
	add sp,#0x4	; 02327982
	pop {r3}	; 02327984
	bx r3	; 02327986
pool_02327988:
loc_02327988:
	.word P1_BssStart + 0x25740	; 02327988
pool_0232798C:
loc_0232798C:
	.word NdsCartHeaderRamAddress + 0x60	; 0232798C
.arm
	mov r0,#0x0	; 02327990
	mcr p15,0x0,r0,c7,c6,0x0	; 02327994
	ldr r1,[pool_02327A10]	; 02327998
loc_0232799C:
	ldrh r0,[r1,#0x0]	; 0232799C
	and r0,r0,#0xf	; 023279A0
	cmp r0,#0x2	; 023279A4
	bne loc_0232799C	; 023279A8
	mov r0,#0x200	; 023279AC
	strh r0,[r1,#0x0]	; 023279B0
	ldr r1,[pool_02327A10]	; 023279B4
loc_023279B8:
	ldrh r0,[r1,#0x0]	; 023279B8
	and r0,r0,#0xf	; 023279BC
	cmp r0,#0x1	; 023279C0
	bne loc_023279B8	; 023279C4
	mov r0,#0x100	; 023279C8
	strh r0,[r1,#0x0]	; 023279CC
	bl loc_02327A44	; 023279D0
	bl loc_02327A1C	; 023279D4
	ldr r1,[pool_02327A10]	; 023279D8
loc_023279DC:
	ldrh r0,[r1,#0x0]	; 023279DC
	and r0,r0,#0xf	; 023279E0
	cmp r0,#0x1	; 023279E4
	beq loc_023279DC	; 023279E8
	mov r0,#0x0	; 023279EC
	strh r0,[r1,#0x0]	; 023279F0
	ldr r3,[pool_02327A14]	; 023279F4
	ldr r12,[r3,#-0x1dc]	; 023279F8
	mov lr,r12	; 023279FC
	ldr r11,[pool_02327A18]	; 02327A00
	ldmia r11,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10}	; 02327A04
	mov r11,#0x0	; 02327A08
	bx r12	; 02327A0C
pool_02327A10:
loc_02327A10:
	.word REG_IPC_SYNC	; 02327A10
pool_02327A14:
loc_02327A14:
; 基准为头部 RAM 视图 +0x200；负偏移实际读取 ARM9/ARM7 入口字段。
; Addressing anchor: the negative offset above reads the ARM9/ARM7 entry field.
	.word NdsCartHeaderRamAddress + 0x200	; 02327A14
pool_02327A18:
loc_02327A18:
	.word 0x03000000	; 02327A18

; ===== function loc_02327A1C =====
loc_02327A1C:
	ldr r0,[pool_02327A40]	; 02327A1C
	mcr p15,0x0,r0,c1,c0,0x0	; 02327A20
	mov r0,#0x0	; 02327A24
	mcr p15,0x0,r0,c6,c5,0x0	; 02327A28
	mov r0,#0x0	; 02327A2C
	mcr p15,0x0,r0,c7,c5,0x0	; 02327A30
	mcr p15,0x0,r0,c7,c6,0x0	; 02327A34
	mcr p15,0x0,r0,c7,c10,0x4	; 02327A38
	bx lr	; 02327A3C
pool_02327A40:
loc_02327A40:
	.word 0x00012078	; 02327A40

; ===== function loc_02327A44 =====
loc_02327A44:
	mov r12,lr	; 02327A44
	mov r0,#0xd3	; 02327A48
	msr cpsr_cxsf,r0	; 02327A4C
	ldr r0,[pool_02327AB4]	; 02327A50
	add r0,r0,#0x3fc0	; 02327A54
	mov sp,r0	; 02327A58
	mov lr,#0x0	; 02327A5C
	msr spsr_cxsf,lr	; 02327A60
	mov r0,#0xd2	; 02327A64
	msr cpsr_cxsf,r0	; 02327A68
	ldr r0,[pool_02327AB4]	; 02327A6C
	add r0,r0,#0x3fc0	; 02327A70
	sub r0,r0,#0x40	; 02327A74
	mov sp,r0	; 02327A78
	mov lr,#0x0	; 02327A7C
	msr spsr_cxsf,lr	; 02327A80
	ldr r1,[pool_02327AB8]	; 02327A84
	sub r1,r0,r1	; 02327A88
	mov r0,#0xdf	; 02327A8C
	msr cpsr_cxsf,r0	; 02327A90
	sub sp,r1,#0x4	; 02327A94
	ldr r0,[pool_02327ABC]	; 02327A98
	mov r1,#0x8000	; 02327A9C
	bl loc_02327AC0	; 02327AA0
	ldr r0,[pool_02327AB4]	; 02327AA4
	mov r1,#0x4000	; 02327AA8
	bl loc_02327AC0	; 02327AAC
	bx r12	; 02327AB0
pool_02327AB4:
loc_02327AB4:
	.word 0x03000000	; 02327AB4
pool_02327AB8:
loc_02327AB8:
	.word 0x00001000	; 02327AB8
pool_02327ABC:
loc_02327ABC:
	.word 0x01FF8000	; 02327ABC

; ===== function loc_02327AC0 =====
loc_02327AC0:
	add r2,r0,r1	; 02327AC0
	mov r1,r1, lsr #0x5	; 02327AC4
	mov r3,#0x0	; 02327AC8
	mov r4,r3	; 02327ACC
	mov r5,r3	; 02327AD0
	mov r6,r3	; 02327AD4
	mov r7,r3	; 02327AD8
	mov r8,r3	; 02327ADC
	mov r9,r3	; 02327AE0
	mov r10,r3	; 02327AE4
loc_02327AE8:
	cmp r0,r2	; 02327AE8
	stmltia r0!,{r3,r4,r5,r6,r7,r8,r9,r10}	; 02327AEC
	blt loc_02327AE8	; 02327AF0
	bx lr	; 02327AF4
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 02327AFC
.thumb
	ldr r0,[pool_02327B98]	; 02327AFC
	add r3,r1,#0x0	; 02327AFE
	and r3,r0	; 02327B00
	lsl r0,r3,#0x8	; 02327B02
	lsr r3,r0,#0x10	; 02327B04
	mov r0,#0xff	; 02327B06
	and r1,r0	; 02327B08
	lsl r1,r1,#0x10	; 02327B0A
	lsr r1,r1,#0x10	; 02327B0C
	cmp r2,#0x0	; 02327B0E
	beq loc_02327B14	; 02327B10
	add r1,r0,#0x0	; 02327B12
loc_02327B14:
	sub r3,#0x20	; 02327B14
	cmp r3,#0x5	; 02327B16
	bhi loc_02327B96	; 02327B18
	add r0,r3,r3	; 02327B1A
P1_SwitchIndexPC_02327B1A:
	add r0,pc	; 02327B1C
	ldrh r0,[r0,#(P1_SwitchTable_02327B1A - (P1_SwitchIndexPC_02327B1A + 4))]	; 02327B1E
	lsl r0,r0,#0x10	; 02327B20
	asr r0,r0,#0x10	; 02327B22
P1_SwitchTargetPC_02327B1A:
	add r0,pc	; 02327B24
	bx r0	; 02327B26
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02327B1A:
	.halfword (loc_02327B48 + 1) - (P1_SwitchTargetPC_02327B1A + 4)
	.halfword (loc_02327B84 + 1) - (P1_SwitchTargetPC_02327B1A + 4)
	.halfword (loc_02327B70 + 1) - (P1_SwitchTargetPC_02327B1A + 4)
	.halfword (loc_02327B34 + 1) - (P1_SwitchTargetPC_02327B1A + 4)
	.halfword (loc_02327B96 + 1) - (P1_SwitchTargetPC_02327B1A + 4)
	.halfword (loc_02327B5C + 1) - (P1_SwitchTargetPC_02327B1A + 4)
P1_SwitchTable_02327B1AEnd:
loc_02327B34:
	cmp r1,#0x0	; 02327B34
	bne loc_02327B40	; 02327B36
	mov r1,#0x0	; 02327B38
	ldr r0,[pool_02327B9C]	; 02327B3A
	str r1,[r0,#0x0]	; 02327B3C
	bx lr	; 02327B3E
loc_02327B40:
	mov r1,#0x1	; 02327B40
	ldr r0,[pool_02327B9C]	; 02327B42
	str r1,[r0,#0x0]	; 02327B44
	bx lr	; 02327B46
loc_02327B48:
	cmp r1,#0x0	; 02327B48
	bne loc_02327B54	; 02327B4A
	mov r1,#0x5	; 02327B4C
	ldr r0,[pool_02327B9C]	; 02327B4E
	str r1,[r0,#0x0]	; 02327B50
	bx lr	; 02327B52
loc_02327B54:
	mov r1,#0x3	; 02327B54
	ldr r0,[pool_02327B9C]	; 02327B56
	str r1,[r0,#0x0]	; 02327B58
	bx lr	; 02327B5A
loc_02327B5C:
	cmp r1,#0x0	; 02327B5C
	bne loc_02327B68	; 02327B5E
	mov r1,#0x7	; 02327B60
	ldr r0,[pool_02327B9C]	; 02327B62
	str r1,[r0,#0x0]	; 02327B64
	bx lr	; 02327B66
loc_02327B68:
	mov r1,#0x5	; 02327B68
	ldr r0,[pool_02327B9C]	; 02327B6A
	str r1,[r0,#0x0]	; 02327B6C
	bx lr	; 02327B6E
loc_02327B70:
	cmp r1,#0x0	; 02327B70
	bne loc_02327B7C	; 02327B72
	mov r1,#0x9	; 02327B74
	ldr r0,[pool_02327B9C]	; 02327B76
	str r1,[r0,#0x0]	; 02327B78
	bx lr	; 02327B7A
loc_02327B7C:
	mov r1,#0x7	; 02327B7C
	ldr r0,[pool_02327B9C]	; 02327B7E
	str r1,[r0,#0x0]	; 02327B80
	bx lr	; 02327B82
loc_02327B84:
	cmp r1,#0x0	; 02327B84
	bne loc_02327B90	; 02327B86
	mov r1,#0x0	; 02327B88
	ldr r0,[pool_02327B9C]	; 02327B8A
	str r1,[r0,#0x0]	; 02327B8C
	bx lr	; 02327B8E
loc_02327B90:
	mov r1,#0xa	; 02327B90
	ldr r0,[pool_02327B9C]	; 02327B92
	str r1,[r0,#0x0]	; 02327B94
loc_02327B96:
	bx lr	; 02327B96
pool_02327B98:
loc_02327B98:
	.word 0x00007F00	; 02327B98
pool_02327B9C:
loc_02327B9C:
	.word P1_BssStart + 0x25750	; 02327B9C

; ===== function loc_02327BA0 =====
loc_02327BA0:
	push {r4,r5,r6,r7,lr}	; 02327BA0
	sub sp,#0x1c	; 02327BA2
	add r7,r0,#0x0	; 02327BA4
	str r1,[sp,#0x0]	; 02327BA6
	str r2,[sp,#0x4]	; 02327BA8
	mov r0,#0x3	; 02327BAA
	ldr r6,[pool_02327D0C]	; 02327BAC
	str r0,[r6,#0x0]	; 02327BAE
	ldr r0,[r6,#0x0]	; 02327BB0
	cmp r0,#0x0	; 02327BB2
	bne loc_02327BB8	; 02327BB4
	b loc_02327D02	; 02327BB6
loc_02327BB8:
	lsr r0,r7,#0x10	; 02327BB8
	str r0,[sp,#0x8]	; 02327BBA
	mov r1,#0xff	; 02327BBC
	and r0,r1	; 02327BBE
	str r0,[sp,#0x8]	; 02327BC0
	ldr r1,[pool_02327D10]	; 02327BC2
	orr r0,r1	; 02327BC4
	str r0,[sp,#0x8]	; 02327BC6
	ldr r0,[pool_02327D14]	; 02327BC8
	and r7,r0	; 02327BCA
	ldr r1,[pool_02327D18]	; 02327BCC
	orr r7,r1	; 02327BCE
	ldr r3,[pool_02327D1C]	; 02327BD0
	ldr r2,[sp,#0x0]	; 02327BD2
	orr r2,r3	; 02327BD4
	str r2,[sp,#0x0]	; 02327BD6
	ldr r2,[sp,#0x4]	; 02327BD8
	lsr r2,r2,#0x10	; 02327BDA
	str r2,[sp,#0xc]	; 02327BDC
	ldr r3,[pool_02327D20]	; 02327BDE
	orr r2,r3	; 02327BE0
	str r2,[sp,#0xc]	; 02327BE2
	ldr r2,[sp,#0x4]	; 02327BE4
	and r2,r0	; 02327BE6
	str r2,[sp,#0x4]	; 02327BE8
	ldr r3,[pool_02327D24]	; 02327BEA
	orr r2,r3	; 02327BEC
	str r2,[sp,#0x4]	; 02327BEE
	ldr r2,[pool_02327D28]	; 02327BF0
	lsr r2,r2,#0x18	; 02327BF2
	str r2,[sp,#0x10]	; 02327BF4
	ldr r3,[pool_02327D2C]	; 02327BF6
	orr r2,r3	; 02327BF8
	str r2,[sp,#0x10]	; 02327BFA
	ldr r2,[pool_02327D28]	; 02327BFC
	lsr r2,r2,#0x8	; 02327BFE
	str r2,[sp,#0x14]	; 02327C00
	and r2,r0	; 02327C02
	str r2,[sp,#0x14]	; 02327C04
	orr r2,r1	; 02327C06
	str r2,[sp,#0x14]	; 02327C08
	ldr r0,[pool_02327D28]	; 02327C0A
	lsl r0,r0,#0x8	; 02327C0C
	str r0,[sp,#0x18]	; 02327C0E
	ldr r1,[pool_02327D30]	; 02327C10
	and r0,r1	; 02327C12
	str r0,[sp,#0x18]	; 02327C14
	ldr r1,[pool_02327D34]	; 02327C16
	orr r0,r1	; 02327C18
	str r0,[sp,#0x18]	; 02327C1A
	mov r4,#0x4	; 02327C1C
	mov r5,#0x0	; 02327C1E
loc_02327C20:
	ldr r0,[r6,#0x0]	; 02327C20
	cmp r0,#0xa	; 02327C22
	bhi loc_02327CFC	; 02327C24
	add r0,r0,r0	; 02327C26
P1_SwitchIndexPC_02327C26:
	add r0,pc	; 02327C28
	ldrh r0,[r0,#(P1_SwitchTable_02327C26 - (P1_SwitchIndexPC_02327C26 + 4))]	; 02327C2A
	lsl r0,r0,#0x10	; 02327C2C
	asr r0,r0,#0x10	; 02327C2E
P1_SwitchTargetPC_02327C26:
	add r0,pc	; 02327C30
	bx r0	; 02327C32
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02327C26:
	.halfword (loc_02327CFC + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327CFC + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327CFC + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327C4A + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327CFC + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327C58 + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327CFC + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327CA0 + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327CFC + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327CCC + 1) - (P1_SwitchTargetPC_02327C26 + 4)
	.halfword (loc_02327CEE + 1) - (P1_SwitchTargetPC_02327C26 + 4)
P1_SwitchTable_02327C26End:
loc_02327C4A:
	add r0,r4,#0x0	; 02327C4A
	ldr r1,[pool_02327D38]	; 02327C4C
	add r2,r5,#0x0	; 02327C4E
	bl loc_0232ED98	; 02327C50
	str r4,[r6,#0x0]	; 02327C54
	b loc_02327CFC	; 02327C56
loc_02327C58:
	add r0,r4,#0x0	; 02327C58
	ldr r1,[sp,#0x8]	; 02327C5A
	add r2,r5,#0x0	; 02327C5C
	bl loc_0232ED98	; 02327C5E
	cmp r0,#0x0	; 02327C62
	blt loc_02327C9A	; 02327C64
	add r0,r4,#0x0	; 02327C66
	add r1,r7,#0x0	; 02327C68
	add r2,r5,#0x0	; 02327C6A
	bl loc_0232ED98	; 02327C6C
	cmp r0,#0x0	; 02327C70
	blt loc_02327C9A	; 02327C72
	add r0,r4,#0x0	; 02327C74
	ldr r1,[sp,#0x0]	; 02327C76
	add r2,r5,#0x0	; 02327C78
	bl loc_0232ED98	; 02327C7A
	cmp r0,#0x0	; 02327C7E
	blt loc_02327C9A	; 02327C80
	add r0,r4,#0x0	; 02327C82
	ldr r1,[sp,#0xc]	; 02327C84
	add r2,r5,#0x0	; 02327C86
	bl loc_0232ED98	; 02327C88
	cmp r0,#0x0	; 02327C8C
	blt loc_02327C9A	; 02327C8E
	add r0,r4,#0x0	; 02327C90
	ldr r1,[sp,#0x4]	; 02327C92
	add r2,r5,#0x0	; 02327C94
	bl loc_0232ED98	; 02327C96
loc_02327C9A:
	mov r0,#0x6	; 02327C9A
	str r0,[r6,#0x0]	; 02327C9C
	b loc_02327CFC	; 02327C9E
loc_02327CA0:
	add r0,r4,#0x0	; 02327CA0
	ldr r1,[sp,#0x10]	; 02327CA2
	add r2,r5,#0x0	; 02327CA4
	bl loc_0232ED98	; 02327CA6
	cmp r0,#0x0	; 02327CAA
	blt loc_02327CC6	; 02327CAC
	add r0,r4,#0x0	; 02327CAE
	ldr r1,[sp,#0x14]	; 02327CB0
	add r2,r5,#0x0	; 02327CB2
	bl loc_0232ED98	; 02327CB4
	cmp r0,#0x0	; 02327CB8
	blt loc_02327CC6	; 02327CBA
	add r0,r4,#0x0	; 02327CBC
	ldr r1,[sp,#0x18]	; 02327CBE
	add r2,r5,#0x0	; 02327CC0
	bl loc_0232ED98	; 02327CC2
loc_02327CC6:
	mov r0,#0x8	; 02327CC6
	str r0,[r6,#0x0]	; 02327CC8
	b loc_02327CFC	; 02327CCA
loc_02327CCC:
	ldr r0,[pool_02327D28]	; 02327CCC
	mov r1,#0x1	; 02327CCE
	blx P1_InvalidateDataCacheRange	; 02327CD0
	ldr r0,[pool_02327D28]	; 02327CD4
	ldrb r0,[r0,#0x0]	; 02327CD6
	cmp r0,#0x1	; 02327CD8
	bne loc_02327CE8	; 02327CDA
	ldr r0,[pool_02327D3C]	; 02327CDC
	bl loc_0232C3DC	; 02327CDE
	mov r0,#0x7	; 02327CE2
	str r0,[r6,#0x0]	; 02327CE4
	b loc_02327CFC	; 02327CE6
loc_02327CE8:
	mov r0,#0xa	; 02327CE8
	str r0,[r6,#0x0]	; 02327CEA
	b loc_02327CFC	; 02327CEC
loc_02327CEE:
	add r0,r4,#0x0	; 02327CEE
	ldr r1,[pool_02327D40]	; 02327CF0
	add r2,r5,#0x0	; 02327CF2
	bl loc_0232ED98	; 02327CF4
	mov r0,#0xb	; 02327CF8
	str r0,[r6,#0x0]	; 02327CFA
loc_02327CFC:
	ldr r0,[r6,#0x0]	; 02327CFC
	cmp r0,#0x0	; 02327CFE
	bne loc_02327C20	; 02327D00
loc_02327D02:
	add sp,#0x1c	; 02327D02
	pop {r4,r5,r6,r7}	; 02327D04
	pop {r3}	; 02327D06
	bx r3	; 02327D08
	.byte 0xC0, 0x46	; 02327D0C
pool_02327D0C:
loc_02327D0C:
	.word P1_BssStart + 0x25750	; 02327D0C
pool_02327D10:
loc_02327D10:
	.word 0x02002500	; 02327D10
pool_02327D14:
loc_02327D14:
	.word 0x0000FFFF	; 02327D14
pool_02327D18:
loc_02327D18:
	.word 0x00010000	; 02327D18
pool_02327D1C:
loc_02327D1C:
	.word 0x00020000	; 02327D1C
pool_02327D20:
loc_02327D20:
	.word 0x00030000	; 02327D20
pool_02327D24:
loc_02327D24:
	.word 0x01040000	; 02327D24
pool_02327D28:
loc_02327D28:
	.word P1_BssStart + 0x257E0	; 02327D28
pool_02327D2C:
loc_02327D2C:
	.word 0x02002200	; 02327D2C
pool_02327D30:
loc_02327D30:
	.word 0x0000FF00	; 02327D30
pool_02327D34:
loc_02327D34:
	.word 0x01020000	; 02327D34
pool_02327D38:
loc_02327D38:
	.word 0x03002000	; 02327D38
pool_02327D3C:
loc_02327D3C:
	.word 0x00001000	; 02327D3C
pool_02327D40:
loc_02327D40:
	.word 0x03002100	; 02327D40

; ===== function loc_02327D44 =====
loc_02327D44:
	push {r4,r5,r6,r7,lr}	; 02327D44
	sub sp,#0x14	; 02327D46
	add r7,r0,#0x0	; 02327D48
	str r1,[sp,#0x0]	; 02327D4A
	str r2,[sp,#0x4]	; 02327D4C
	ldr r6,[pool_02327E30]	; 02327D4E
	mov r0,#0x1	; 02327D50
	str r0,[r6,#0x0]	; 02327D52
	ldr r0,[r6,#0x0]	; 02327D54
	cmp r0,#0x0	; 02327D56
	beq loc_02327E26	; 02327D58
	lsr r0,r7,#0x10	; 02327D5A
	str r0,[sp,#0x8]	; 02327D5C
	mov r1,#0xff	; 02327D5E
	and r0,r1	; 02327D60
	str r0,[sp,#0x8]	; 02327D62
	ldr r1,[pool_02327E34]	; 02327D64
	orr r0,r1	; 02327D66
	str r0,[sp,#0x8]	; 02327D68
	ldr r0,[pool_02327E38]	; 02327D6A
	and r7,r0	; 02327D6C
	ldr r1,[pool_02327E3C]	; 02327D6E
	orr r7,r1	; 02327D70
	ldr r1,[sp,#0x0]	; 02327D72
	and r1,r0	; 02327D74
	str r1,[sp,#0x0]	; 02327D76
	ldr r2,[pool_02327E40]	; 02327D78
	orr r1,r2	; 02327D7A
	str r1,[sp,#0x0]	; 02327D7C
	ldr r1,[sp,#0x4]	; 02327D7E
	lsr r1,r1,#0x10	; 02327D80
	str r1,[sp,#0xc]	; 02327D82
	ldr r2,[pool_02327E44]	; 02327D84
	orr r1,r2	; 02327D86
	str r1,[sp,#0xc]	; 02327D88
	ldr r1,[sp,#0x4]	; 02327D8A
	and r1,r0	; 02327D8C
	str r1,[sp,#0x4]	; 02327D8E
	ldr r1,[pool_02327E48]	; 02327D90
	ldr r0,[sp,#0x4]	; 02327D92
	orr r0,r1	; 02327D94
	str r0,[sp,#0x4]	; 02327D96
	mov r5,#0x4	; 02327D98
	mov r4,#0x0	; 02327D9A
loc_02327D9C:
	ldr r0,[r6,#0x0]	; 02327D9C
	cmp r0,#0x1	; 02327D9E
	bne loc_02327E20	; 02327DA0
	add r0,r5,#0x0	; 02327DA2
	ldr r1,[sp,#0x8]	; 02327DA4
	add r2,r4,#0x0	; 02327DA6
	bl loc_0232ED98	; 02327DA8
	cmp r0,#0x0	; 02327DAC
	bge loc_02327DB4	; 02327DAE
	add r0,r4,#0x0	; 02327DB0
	b loc_02327E10	; 02327DB2
loc_02327DB4:
	add r0,r5,#0x0	; 02327DB4
	add r1,r7,#0x0	; 02327DB6
	add r2,r4,#0x0	; 02327DB8
	bl loc_0232ED98	; 02327DBA
	cmp r0,#0x0	; 02327DBE
	bge loc_02327DC6	; 02327DC0
	add r0,r4,#0x0	; 02327DC2
	b loc_02327E10	; 02327DC4
loc_02327DC6:
	add r0,r5,#0x0	; 02327DC6
	ldr r1,[pool_02327E4C]	; 02327DC8
	add r2,r4,#0x0	; 02327DCA
	bl loc_0232ED98	; 02327DCC
	cmp r0,#0x0	; 02327DD0
	bge loc_02327DD8	; 02327DD2
	add r0,r4,#0x0	; 02327DD4
	b loc_02327E10	; 02327DD6
loc_02327DD8:
	add r0,r5,#0x0	; 02327DD8
	ldr r1,[sp,#0x0]	; 02327DDA
	add r2,r4,#0x0	; 02327DDC
	bl loc_0232ED98	; 02327DDE
	cmp r0,#0x0	; 02327DE2
	bge loc_02327DEA	; 02327DE4
	add r0,r4,#0x0	; 02327DE6
	b loc_02327E10	; 02327DE8
loc_02327DEA:
	add r0,r5,#0x0	; 02327DEA
	ldr r1,[sp,#0xc]	; 02327DEC
	add r2,r4,#0x0	; 02327DEE
	bl loc_0232ED98	; 02327DF0
	cmp r0,#0x0	; 02327DF4
	bge loc_02327DFC	; 02327DF6
	add r0,r4,#0x0	; 02327DF8
	b loc_02327E10	; 02327DFA
loc_02327DFC:
	add r0,r5,#0x0	; 02327DFC
	ldr r1,[sp,#0x4]	; 02327DFE
	add r2,r4,#0x0	; 02327E00
	bl loc_0232ED98	; 02327E02
	cmp r0,#0x0	; 02327E06
	bge loc_02327E0E	; 02327E08
	add r0,r4,#0x0	; 02327E0A
	b loc_02327E10	; 02327E0C
loc_02327E0E:
	mov r0,#0x1	; 02327E0E
loc_02327E10:
	cmp r0,#0x1	; 02327E10
	bne loc_02327E1A	; 02327E12
	mov r0,#0x2	; 02327E14
	str r0,[r6,#0x0]	; 02327E16
	b loc_02327E20	; 02327E18
loc_02327E1A:
	ldr r0,[pool_02327E50]	; 02327E1A
	bl loc_0232C3DC	; 02327E1C
loc_02327E20:
	ldr r0,[r6,#0x0]	; 02327E20
	cmp r0,#0x0	; 02327E22
	bne loc_02327D9C	; 02327E24
loc_02327E26:
	add sp,#0x14	; 02327E26
	pop {r4,r5,r6,r7}	; 02327E28
	pop {r3}	; 02327E2A
	bx r3	; 02327E2C
	.byte 0xC0, 0x46	; 02327E30
pool_02327E30:
loc_02327E30:
	.word P1_BssStart + 0x25750	; 02327E30
pool_02327E34:
loc_02327E34:
	.word 0x02002300	; 02327E34
pool_02327E38:
loc_02327E38:
	.word 0x0000FFFF	; 02327E38
pool_02327E3C:
loc_02327E3C:
	.word 0x00010000	; 02327E3C
pool_02327E40:
loc_02327E40:
	.word 0x00030000	; 02327E40
pool_02327E44:
loc_02327E44:
	.word 0x00040000	; 02327E44
pool_02327E48:
loc_02327E48:
	.word 0x01050000	; 02327E48
pool_02327E4C:
loc_02327E4C:
	.word 0x00020000	; 02327E4C
pool_02327E50:
loc_02327E50:
	.word 0x00001000	; 02327E50

; ===== function loc_02327E54 =====
loc_02327E54:
	push {r4,r5,r6,r7,lr}	; 02327E54
	sub sp,#0x4	; 02327E56
	add r7,r0,#0x0	; 02327E58
	mov r6,#0x0	; 02327E5A
	add r5,r6,#0x0	; 02327E5C
loc_02327E5E:
	lsl r0,r5,#0x7	; 02327E5E
	add r4,r7,r0	; 02327E60
	ldr r0,[pool_02327F00]	; 02327E62
	add r1,r4,#0x0	; 02327E64
	mov r2,#0x70	; 02327E66
	bl loc_0232C406	; 02327E68
	add r1,r4,#0x0	; 02327E6C
	add r1,#0x72	; 02327E6E
	ldrh r1,[r1,#0x0]	; 02327E70
	cmp r0,r1	; 02327E72
	bne loc_02327E90	; 02327E74
	add r0,r4,#0x0	; 02327E76
	add r0,#0x70	; 02327E78
	ldrh r0,[r0,#0x0]	; 02327E7A
	cmp r0,#0x80	; 02327E7C
	bcs loc_02327E90	; 02327E7E
	ldrb r0,[r4,#0x0]	; 02327E80
	cmp r0,#0x5	; 02327E82
	bne loc_02327E90	; 02327E84
	mov r0,#0x1	; 02327E86
	lsl r0,r5	; 02327E88
	orr r6,r0	; 02327E8A
	lsl r0,r6,#0x10	; 02327E8C
	lsr r6,r0,#0x10	; 02327E8E
loc_02327E90:
	add r0,r5,#0x1	; 02327E90
	lsl r0,r0,#0x10	; 02327E92
	lsr r5,r0,#0x10	; 02327E94
	cmp r5,#0x2	; 02327E96
	bcc loc_02327E5E	; 02327E98
	cmp r6,#0x3	; 02327E9A
	bne loc_02327EC6	; 02327E9C
	add r0,r7,#0x0	; 02327E9E
	add r0,#0x70	; 02327EA0
	ldrh r0,[r0,#0x0]	; 02327EA2
	add r1,r0,#0x1	; 02327EA4
	mov r0,#0x7f	; 02327EA6
	and r1,r0	; 02327EA8
	lsl r0,r1,#0x18	; 02327EAA
	lsr r1,r0,#0x18	; 02327EAC
	add r7,#0xf0	; 02327EAE
	ldrh r0,[r7,#0x0]	; 02327EB0
	cmp r1,r0	; 02327EB2
	bne loc_02327EBE	; 02327EB4
	mov r1,#0x1	; 02327EB6
	ldr r0,[pool_02327F04]	; 02327EB8
	strh r1,[r0,#0x0]	; 02327EBA
	b loc_02327EF6	; 02327EBC
loc_02327EBE:
	mov r1,#0x0	; 02327EBE
	ldr r0,[pool_02327F04]	; 02327EC0
	strh r1,[r0,#0x0]	; 02327EC2
	b loc_02327EF6	; 02327EC4
loc_02327EC6:
	cmp r6,#0x0	; 02327EC6
	beq loc_02327EEC	; 02327EC8
	mov r1,#0x0	; 02327ECA
	ldr r0,[pool_02327F04]	; 02327ECC
	strh r1,[r0,#0x0]	; 02327ECE
	mov r2,#0x1	; 02327ED0
loc_02327ED2:
	ldrh r1,[r0,#0x0]	; 02327ED2
	add r3,r2,#0x0	; 02327ED4
	lsl r3,r1	; 02327ED6
	add r4,r6,#0x0	; 02327ED8
	and r4,r3	; 02327EDA
	cmp r4,#0x0	; 02327EDC
	bne loc_02327EF6	; 02327EDE
	add r1,r1,#0x1	; 02327EE0
	strh r1,[r0,#0x0]	; 02327EE2
	ldrh r1,[r0,#0x0]	; 02327EE4
	cmp r1,#0x2	; 02327EE6
	bcc loc_02327ED2	; 02327EE8
	b loc_02327EF6	; 02327EEA
loc_02327EEC:
	mov r0,#0x1	; 02327EEC
	add sp,#0x4	; 02327EEE
	pop {r4,r5,r6,r7}	; 02327EF0
	pop {r3}	; 02327EF2
	bx r3	; 02327EF4
loc_02327EF6:
	mov r0,#0x0	; 02327EF6
	add sp,#0x4	; 02327EF8
	pop {r4,r5,r6,r7}	; 02327EFA
	pop {r3}	; 02327EFC
	bx r3	; 02327EFE
pool_02327F00:
loc_02327F00:
	.word 0x0000FFFF	; 02327F00
pool_02327F04:
loc_02327F04:
	.word P1_Data_02330D30	; 02327F04

; ===== function loc_02327F08 =====
loc_02327F08:
	push {r4,r5,lr}	; 02327F08
	sub sp,#0x4	; 02327F0A
	add r5,r0,#0x0	; 02327F0C
	ldr r4,[pool_02327F90]	; 02327F0E
	ldr r0,[pool_02327F94]	; 02327F10
	ldrh r0,[r0,#0x0]	; 02327F12
	cmp r0,#0xff	; 02327F14
	bne loc_02327F28	; 02327F16
	mov r0,#0x0	; 02327F18
	bl loc_02328014	; 02327F1A
	cmp r0,#0x0	; 02327F1E
	beq loc_02327F28	; 02327F20
	mov r1,#0x0	; 02327F22
	ldr r0,[pool_02327F94]	; 02327F24
	strh r1,[r0,#0x0]	; 02327F26
loc_02327F28:
	mov r0,#0x5	; 02327F28
	strb r0,[r5,#0x0]	; 02327F2A
	add r3,r4,#0x0	; 02327F2C
	mov r2,#0xe	; 02327F2E
loc_02327F30:
	ldmia r5!,{r0,r1}	; 02327F30
	stmia r3!,{r0,r1}	; 02327F32
	sub r2,r2,#0x1	; 02327F34
	cmp r2,#0x0	; 02327F36
	bne loc_02327F30	; 02327F38
	ldr r0,[pool_02327F98]	; 02327F3A
	add r1,r4,#0x0	; 02327F3C
	mov r2,#0x70	; 02327F3E
	bl loc_0232C406	; 02327F40
	add r1,r4,#0x0	; 02327F44
	add r1,#0x72	; 02327F46
	strh r0,[r1,#0x0]	; 02327F48
	ldr r1,[pool_02327F9C]	; 02327F4A
	ldrh r2,[r1,#0x0]	; 02327F4C
	add r0,r4,#0x0	; 02327F4E
	add r0,#0x70	; 02327F50
	strh r2,[r0,#0x0]	; 02327F52
	ldrh r0,[r1,#0x0]	; 02327F54
	add r2,r0,#0x1	; 02327F56
	mov r0,#0x7f	; 02327F58
	and r2,r0	; 02327F5A
	lsl r0,r2,#0x18	; 02327F5C
	lsr r0,r0,#0x18	; 02327F5E
	strh r0,[r1,#0x0]	; 02327F60
	ldr r1,[pool_02327F94]	; 02327F62
	ldrh r2,[r1,#0x0]	; 02327F64
	mov r0,#0x1	; 02327F66
	eor r2,r0	; 02327F68
	strh r2,[r1,#0x0]	; 02327F6A
	ldr r0,[pool_02327FA0]	; 02327F6C
	ldr r2,[r0,#0x0]	; 02327F6E
	ldrh r0,[r1,#0x0]	; 02327F70
	lsl r0,r0,#0x8	; 02327F72
	add r5,r2,r0	; 02327F74
	add r0,r4,#0x0	; 02327F76
	mov r1,#0x80	; 02327F78
	blx P1_CleanAndInvalidateDataCacheRange	; 02327F7A
	add r0,r5,#0x0	; 02327F7E
	mov r1,#0x80	; 02327F80
	add r2,r4,#0x0	; 02327F82
	bl loc_02327BA0	; 02327F84
	add sp,#0x4	; 02327F88
	pop {r4,r5}	; 02327F8A
	pop {r3}	; 02327F8C
	bx r3	; 02327F8E
pool_02327F90:
loc_02327F90:
	.word 0x023565E0	; 02327F90
pool_02327F94:
loc_02327F94:
	.word P1_Data_02330D30	; 02327F94
pool_02327F98:
loc_02327F98:
	.word 0x0000FFFF	; 02327F98
pool_02327F9C:
loc_02327F9C:
	.word P1_BssStart + 0x2574C	; 02327F9C
pool_02327FA0:
loc_02327FA0:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 02327FA0

; ===== function loc_02327FA4 =====
loc_02327FA4:
	ldrb r1,[r0,#0x3]	; 02327FA4
	cmp r1,#0xc	; 02327FA6
	bhi loc_02327FB0	; 02327FA8
	ldrb r1,[r0,#0x4]	; 02327FAA
	cmp r1,#0x1f	; 02327FAC
	bls loc_02327FB6	; 02327FAE
loc_02327FB0:
	mov r1,#0x1	; 02327FB0
	strb r1,[r0,#0x3]	; 02327FB2
	strb r1,[r0,#0x4]	; 02327FB4
loc_02327FB6:
	ldrb r1,[r0,#0x1a]	; 02327FB6
	cmp r1,#0xa	; 02327FB8
	bls loc_02327FC0	; 02327FBA
	mov r1,#0x0	; 02327FBC
	strb r1,[r0,#0x1a]	; 02327FBE
loc_02327FC0:
	add r1,r0,#0x0	; 02327FC0
	add r1,#0x50	; 02327FC2
	ldrb r1,[r1,#0x0]	; 02327FC4
	cmp r1,#0x1a	; 02327FC6
	bls loc_02327FD2	; 02327FC8
	mov r2,#0x0	; 02327FCA
	add r1,r0,#0x0	; 02327FCC
	add r1,#0x50	; 02327FCE
	strb r2,[r1,#0x0]	; 02327FD0
loc_02327FD2:
	add r1,r0,#0x0	; 02327FD2
	add r1,#0x52	; 02327FD4
	ldrb r1,[r1,#0x0]	; 02327FD6
	cmp r1,#0x17	; 02327FD8
	bhi loc_02327FE6	; 02327FDA
	add r1,r0,#0x0	; 02327FDC
	add r1,#0x53	; 02327FDE
	ldrb r1,[r1,#0x0]	; 02327FE0
	cmp r1,#0x3b	; 02327FE2
	bls loc_02327FF4	; 02327FE4
loc_02327FE6:
	mov r2,#0x0	; 02327FE6
	add r1,r0,#0x0	; 02327FE8
	add r1,#0x52	; 02327FEA
	strb r2,[r1,#0x0]	; 02327FEC
	add r1,r0,#0x0	; 02327FEE
	add r1,#0x53	; 02327FF0
	strb r2,[r1,#0x0]	; 02327FF2
loc_02327FF4:
	add r1,r0,#0x0	; 02327FF4
	add r1,#0x64	; 02327FF6
	ldrh r1,[r1,#0x0]	; 02327FF8
	lsl r1,r1,#0x1d	; 02327FFA
	lsr r1,r1,#0x1d	; 02327FFC
	cmp r1,#0x6	; 02327FFE
	bcc loc_02328010	; 02328000
	add r0,#0x64	; 02328002
	ldrh r2,[r0,#0x0]	; 02328004
	mov r1,#0x7	; 02328006
	bic r2,r1	; 02328008
	mov r1,#0x1	; 0232800A
	orr r2,r1	; 0232800C
	strh r2,[r0,#0x0]	; 0232800E
loc_02328010:
	bx lr	; 02328010
	.byte 0x00, 0x00	; 02328014

; ===== function loc_02328014 =====
loc_02328014:
	push {r4,r5,r6,lr}	; 02328014
	add r5,r0,#0x0	; 02328016
	mov r4,#0x0	; 02328018
	ldr r6,[pool_02328090]	; 0232801A
	mov r0,#0x4	; 0232801C
	ldr r1,[pool_02328094]	; 0232801E
	bl loc_0232EE58	; 02328020
	ldr r0,[pool_02328098]	; 02328024
	ldr r0,[r0,#0x0]	; 02328026
	mov r1,#0x80	; 02328028
	lsl r2,r6,#0	; 0232802A
	bl loc_02327D44	; 0232802C
	ldr r0,[pool_02328098]	; 02328030
	ldr r1,[r0,#0x0]	; 02328032
	ldr r0,[pool_0232809C]	; 02328034
	add r0,r1,r0	; 02328036
	mov r1,#0x80	; 02328038
	ldr r2,[pool_023280A0]	; 0232803A
	bl loc_02327D44	; 0232803C
	lsl r0,r6,#0	; 02328040
	ldr r1,[pool_0232809C]	; 02328042
	blx P1_InvalidateDataCacheRange	; 02328044
	lsl r0,r6,#0	; 02328048
	bl loc_02327E54	; 0232804A
	cmp r0,#0x0	; 0232804E
	beq loc_0232805A	; 02328050
	mov r4,#0x1	; 02328052
	ldr r0,[pool_023280A4]	; 02328054
	strh r4,[r0,#0x0]	; 02328056
	b loc_02328088	; 02328058
loc_0232805A:
	ldr r0,[pool_023280A8]	; 0232805A
	ldrh r0,[r0,#0x0]	; 0232805C
	lsl r0,r0,#0x7	; 0232805E
	add r0,r6,r0	; 02328060
	add r1,r0,#0x0	; 02328062
	add r1,#0x70	; 02328064
	ldrh r1,[r1,#0x0]	; 02328066
	add r2,r1,#0x1	; 02328068
	mov r1,#0x7f	; 0232806A
	and r2,r1	; 0232806C
	lsl r1,r2,#0x18	; 0232806E
	lsr r2,r1,#0x18	; 02328070
	ldr r1,[pool_023280A4]	; 02328072
	strh r2,[r1,#0x0]	; 02328074
	cmp r5,#0x0	; 02328076
	beq loc_02328088	; 02328078
	add r1,r5,#0x0	; 0232807A
	mov r2,#0x38	; 0232807C
	bl loc_0232C3FA	; 0232807E
	add r0,r5,#0x0	; 02328082
	bl loc_02327FA4	; 02328084
loc_02328088:
	add r0,r4,#0x0	; 02328088
	pop {r4,r5,r6}	; 0232808A
	pop {r3}	; 0232808C
	bx r3	; 0232808E
pool_02328090:
loc_02328090:
	.word 0x023565E0	; 02328090
pool_02328094:
loc_02328094:
	.word 0x02327AFD	; 02328094
pool_02328098:
loc_02328098:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 02328098
pool_0232809C:
loc_0232809C:
	.word 0x00000100	; 0232809C
pool_023280A0:
loc_023280A0:
	.word 0x02356660	; 023280A0
pool_023280A4:
loc_023280A4:
	.word P1_BssStart + 0x2574C	; 023280A4
pool_023280A8:
loc_023280A8:
	.word P1_Data_02330D30	; 023280A8

; ===== function loc_023280AC =====
loc_023280AC:
	push {r4,r5}	; 023280AC
	mov r4,#0x3	; 023280AE
	mov r3,#0x0	; 023280B0
loc_023280B2:
	ldrb r2,[r0,#0x0]	; 023280B2
	ror r3,r4	; 023280B4
	mov r5,#0x4	; 023280B6
loc_023280B8:
	eor r3,r2	; 023280B8
	lsl r2,r2,#0x8	; 023280BA
	sub r5,#0x1	; 023280BC
	bgt loc_023280B8	; 023280BE
	add r0,#0x1	; 023280C0
	sub r1,#0x1	; 023280C2
	bgt loc_023280B2	; 023280C4
	add r0,r3,#0x0	; 023280C6
	lsl r0,r0,#0x1b	; 023280C8
	lsr r0,r0,#0x1e	; 023280CA
	pop {r4,r5}	; 023280CC
	bx lr	; 023280CE

; ===== function loc_023280D0 =====
loc_023280D0:
	add r2,r0,#0x0	; 023280D0
	mov r0,#0x14	; 023280D2
	mul r1,r0	; 023280D4
	ldr r0,[pool_023280E4]	; 023280D6
	add r0,r1,r0	; 023280D8
	add r1,r2,r1	; 023280DA
	mov r2,#0xa	; 023280DC
	ldr r3,[pool_023280E8]	; 023280DE
	bx r3	; 023280E0
	.byte 0xC0, 0x46	; 023280E4
pool_023280E4:
loc_023280E4:
	.word 0x08000004	; 023280E4
pool_023280E8:
loc_023280E8:
	.word P1_SwiCpuSet + 1	; 023280E8

; ===== function loc_023280EC =====
loc_023280EC:
	push {r4,r5,r6,r7,lr}	; 023280EC
	sub sp,#0x4	; 023280EE
	add r6,r0,#0x0	; 023280F0
	ldr r0,[pool_02328158]	; 023280F2
	ldrb r1,[r0,#0x0]	; 023280F4
	mov r0,#0x80	; 023280F6
	and r1,r0	; 023280F8
	cmp r1,#0x0	; 023280FA
	beq loc_02328102	; 023280FC
	ldr r0,[pool_0232815C]	; 023280FE
	b loc_02328104	; 02328100
loc_02328102:
	ldr r0,[pool_02328160]	; 02328102
loc_02328104:
	add r1,r6,#0x0	; 02328104
	mov r2,#0xa	; 02328106
	bl loc_0232C3FA	; 02328108
	ldr r0,[pool_02328164]	; 0232810C
	sub r0,r0,#0x1	; 0232810E
	mov r1,#0x1b	; 02328110
	bl loc_023280AC	; 02328112
	ldr r3,[pool_02328168]	; 02328116
	ldr r1,[pool_02328164]	; 02328118
	ldrb r2,[r1,#0x0]	; 0232811A
	mov r1,#0x3	; 0232811C
	and r2,r1	; 0232811E
	mov r1,#0x30	; 02328120
	mul r2,r1	; 02328122
	add r2,r3,r2	; 02328124
	mov r1,#0xc	; 02328126
	mul r0,r1	; 02328128
	add r5,r2,r0	; 0232812A
	mov r4,#0x0	; 0232812C
	ldr r7,[pool_0232816C]	; 0232812E
loc_02328130:
	add r0,r6,#0x0	; 02328130
	add r1,r4,#0x0	; 02328132
	bl loc_023280D0	; 02328134
	cmp r4,#0x3	; 02328138
	blt loc_02328148	; 0232813A
	cmp r4,#0x9	; 0232813C
	bge loc_02328148	; 0232813E
	ldrh r0,[r5,#0x0]	; 02328140
	add r5,r5,#0x2	; 02328142
	lsl r0,r0,#0x1	; 02328144
	ldrh r0,[r0,r7]	; 02328146
loc_02328148:
	add r4,r4,#0x1	; 02328148
	cmp r4,#0xb	; 0232814A
	blt loc_02328130	; 0232814C
	add sp,#0x4	; 0232814E
	pop {r4,r5,r6,r7}	; 02328150
	pop {r3}	; 02328152
	bx r3	; 02328154
	.byte 0xC0, 0x46	; 02328158
pool_02328158:
loc_02328158:
	.word 0x080000B4	; 02328158
pool_0232815C:
loc_0232815C:
	.word 0x09FE1FE0	; 0232815C
pool_02328160:
loc_02328160:
	.word 0x09FFFFE0	; 02328160
pool_02328164:
loc_02328164:
	.word 0x0800009E	; 02328164
pool_02328168:
loc_02328168:
	.word 0x02330D34	; 02328168
pool_0232816C:
loc_0232816C:
	.word 0x08000000	; 0232816C

; ===== function loc_02328170 =====
loc_02328170:
	push {r4,r5,r6,r7}	; 02328170
	mov r5,#0x0	; 02328172
	ldr r3,[pool_023281B8]	; 02328174
	ldr r2,[pool_023281BC]	; 02328176
	mov r1,#0x3	; 02328178
	add r4,r2,#0x0	; 0232817A
	eor r4,r1	; 0232817C
	lsl r1,r4,#0x10	; 0232817E
	lsr r1,r1,#0x10	; 02328180
	mov r6,#0x84	; 02328182
loc_02328184:
	add r4,r2,#0x0	; 02328184
	cmp r5,#0x4c	; 02328186
	bne loc_02328192	; 02328188
	eor r4,r6	; 0232818A
	lsl r4,r4,#0x10	; 0232818C
	lsr r4,r4,#0x10	; 0232818E
	b loc_02328198	; 02328190
loc_02328192:
	cmp r5,#0x4d	; 02328192
	bne loc_02328198	; 02328194
	add r4,r1,#0x0	; 02328196
loc_02328198:
	ldrh r7,[r0,#0x0]	; 02328198
	and r4,r7	; 0232819A
	ldrh r7,[r3,#0x0]	; 0232819C
	cmp r4,r7	; 0232819E
	beq loc_023281A8	; 023281A0
	mov r0,#0x0	; 023281A2
	pop {r4,r5,r6,r7}	; 023281A4
	bx lr	; 023281A6
loc_023281A8:
	add r3,r3,#0x2	; 023281A8
	add r0,r0,#0x2	; 023281AA
	add r5,r5,#0x1	; 023281AC
	cmp r5,#0x4e	; 023281AE
	blt loc_02328184	; 023281B0
	mov r0,#0x1	; 023281B2
	pop {r4,r5,r6,r7}	; 023281B4
	bx lr	; 023281B6
pool_023281B8:
loc_023281B8:
	.word 0xFFFF0020	; 023281B8
pool_023281BC:
loc_023281BC:
	.word 0x0000FFFF	; 023281BC

; ===== function loc_023281C0 =====
loc_023281C0:
	push {r4,lr}	; 023281C0
	mov r0,#0x6d	; 023281C2
	bl loc_0232AFA8	; 023281C4
	ldr r0,[pool_023281E4]	; 023281C8
	bl loc_023280EC	; 023281CA
	ldr r0,[pool_023281E4]	; 023281CE
	bl loc_02328170	; 023281D0
	add r4,r0,#0x0	; 023281D4
	mov r0,#0x6d	; 023281D6
	bl loc_0232AE40	; 023281D8
	add r0,r4,#0x0	; 023281DC
	pop {r4}	; 023281DE
	pop {r3}	; 023281E0
	bx r3	; 023281E2
pool_023281E4:
loc_023281E4:
	.word 0x023566E0	; 023281E4

; ===== function loc_023281E8 =====
loc_023281E8:
	push {r0,r1,r2,r4,lr}	; 023281E8
	ldr r0,[pool_0232822C]	; 023281EA
	add r1,r2,#0x0	; 023281EC
	add r4,r1,#0x0	; 023281EE
	mov r2,#0x24	; 023281F0
	blx loc_0232E304	; 023281F2
	ldr r0,[sp,#0x0]	; 023281F6
	mov r2,#0x24	; 023281F8
	add r1,r4,r2	; 023281FA
	mov r2,#0x9c	; 023281FC
	blx loc_0232E304	; 023281FE
	add r0,r4,#0x0	; 02328202
	ldr r1,[sp,#0x4]	; 02328204
	mov r2,#0x1	; 02328206
	lsl r2,r2,#0x8	; 02328208
	add r2,r2,r1	; 0232820A
	ldr r3,[pool_02328230]	; 0232820C
	bl loc_0232C41A	; 0232820E
	ldr r0,[sp,#0x4]	; 02328212
	ldr r2,[pool_02328234]	; 02328214
	str r2,[r0,#0x0]	; 02328216
	add r1,r4,#0x0	; 02328218
	bl loc_0232823C	; 0232821A
	add r0,r4,#0x0	; 0232821E
	ldr r1,[sp,#0x4]	; 02328220
	ldr r2,[pool_02328238]	; 02328222
	bl loc_0232C40E	; 02328224
	pop {r0,r1,r2,r4,pc}	; 02328228
	.byte 0xC0, 0x46	; 0232822C
pool_0232822C:
loc_0232822C:
	.word 0x02330858	; 0232822C
pool_02328230:
loc_02328230:
	.word 0x02330844	; 02328230
pool_02328234:
loc_02328234:
	.word 0x0000D082	; 02328234
pool_02328238:
loc_02328238:
	.word 0x02330DF4	; 02328238

; ===== function loc_0232823C =====
.func P1_SwiDiff16UnFilter
; BIOS SWI #18: differential 16-bit decompression. / BIOS SWI #18：差分 16 位解压。
loc_0232823C:
	swi 0x18	; 0232823C
	bx lr	; 0232823E
.endfunc

; ===== function loc_02328240 =====
loc_02328240:
	ldr r0,[r0,#0x0]	; 02328240
	bx lr	; 02328242
	ldrb r0,[r0,#0x0]	; 02328244
	bx lr	; 02328246
	mov r0,#0x0	; 02328248
	bx lr	; 0232824A

; ===== function loc_0232824C =====
	push {lr}	; 0232824C
	sub sp,#0x4	; 0232824E
	cmp r2,#0x0	; 02328250
	beq loc_0232825E	; 02328252
	bl loc_02328240	; 02328254
	add sp,#0x4	; 02328258
	pop {r3}	; 0232825A
	bx r3	; 0232825C
loc_0232825E:
	mov r0,#0x0	; 0232825E
	add sp,#0x4	; 02328260
	pop {r3}	; 02328262
	bx r3	; 02328264
	.byte 0x00, 0x00	; 02328268

; ===== function loc_02328268 =====
loc_02328268:
	push {r4,r5,r6,lr}	; 02328268
	sub sp,#0x100	; 0232826A
	add r5,r1,#0x0	; 0232826C
	add r4,r3,#0x0	; 0232826E
	ldr r1,[pool_0232829C]	; 02328270
	ldr r3,[r1,#0x4]	; 02328272
	ldr r6,[pool_023282A0]	; 02328274
	and r3,r6	; 02328276
	sub r6,r2,#0x1	; 02328278
	ldr r2,[pool_023282A4]	; 0232827A
	and r6,r2	; 0232827C
	orr r3,r6	; 0232827E
	str r3,[r1,#0x4]	; 02328280
	add r1,r4,#0x0	; 02328282
	add r2,sp,#0x0	; 02328284
	bl loc_023281E8	; 02328286
	add r0,r4,#0x0	; 0232828A
	add r1,r5,#0x0	; 0232828C
	ldr r2,[pool_023282A8]	; 0232828E
	blx loc_0232E398	; 02328290
	add sp,#0x100	; 02328294
	pop {r4,r5,r6}	; 02328296
	pop {r3}	; 02328298
	bx r3	; 0232829A
pool_0232829C:
loc_0232829C:
	.word P1_Data_02330DF4	; 0232829C
pool_023282A0:
loc_023282A0:
	.word 0x80000000	; 023282A0
pool_023282A4:
loc_023282A4:
	.word 0x7FFFFFFF	; 023282A4
pool_023282A8:
loc_023282A8:
	.word 0x00000340	; 023282A8
.arm

; ===== function loc_023282AC =====
loc_023282AC:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 023282AC
	sub sp,sp,#0xc	; 023282B0
	mov r9,r1	; 023282B4
	ldrb r1,[r9,#0x5]	; 023282B8
	ldrb r2,[r9,#0x6]	; 023282BC
	ldrb r3,[r9,#0x8]	; 023282C0
	mov r4,r1, lsl #0x10	; 023282C4
	orr r5,r4,r2, lsl #0x8	; 023282C8
	ldrb r2,[r9,#0x9]	; 023282CC
	mov r3,r3, lsl #0x18	; 023282D0
	ldrb r1,[r9,#0x7]	; 023282D4
	orr r2,r3,r2, lsl #0x10	; 023282D8
	ldrb r4,[r9,#0xa]	; 023282DC
	mov r10,r0	; 023282E0
	orr r0,r1,r5	; 023282E4
	str r0,[sp,#0x0]	; 023282E8
	ldrb r3,[r9,#0xb]	; 023282EC
	orr r2,r2,r4, lsl #0x8	; 023282F0
	ldr r1,[pool_02328468]	; 023282F4
	add r0,r10,r0	; 023282F8
	cmp r0,r1	; 023282FC
	orr r11,r3,r2	; 02328300
	addhi sp,sp,#0xc	; 02328304
	movhi r0,#0x0	; 02328308
	ldmhiia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 0232830C
	bxhi lr	; 02328310
	ldr r5,[pool_0232846C]	; 02328314
	mov r8,#0xc	; 02328318
	ldr r4,[pool_02328470]	; 0232831C
	mov r2,#0x0	; 02328320
	ldr r3,[pool_02328474]	; 02328324
	mov r7,#0x200	; 02328328
	mov r6,#0x800	; 0232832C
	mov r0,r9	; 02328330
	mov r1,#0x20	; 02328334
	str r8,[r5,#0x0]	; 02328338
	str r11,[r5,#0x4]	; 0232833C
	str r2,[r4,#0x4]	; 02328340
	str r2,[r4,#0x0]	; 02328344
	str r7,[r3,#0x0]	; 02328348
	str r6,[r3,#0x4]	; 0232834C
	bl loc_02328670	; 02328350
	mov r0,r9	; 02328354
	mov r1,#0x20	; 02328358
	mov r2,#0x1	; 0232835C
	bl loc_02328670	; 02328360
	mov r0,r9	; 02328364
	bl loc_02328578	; 02328368
	str r0,[sp,#0x4]	; 0232836C
	mov r0,r9	; 02328370
	bl loc_02328488	; 02328374
	str r0,[sp,#0x8]	; 02328378
	ldr r0,[sp,#0x0]	; 0232837C
	mov r6,#0x0	; 02328380
	cmp r0,#0x0	; 02328384
	ble loc_02328458	; 02328388
	ldr r11,[pool_02328478]	; 0232838C
	mov r4,r6	; 02328390
	mov r5,#0x1	; 02328394
loc_02328398:
	ldr r7,[sp,#0x4]	; 02328398
	mov r0,r7	; 0232839C
	cmp r0,#0x200	; 023283A0
	blt loc_023283D0	; 023283A4
loc_023283A8:
	mov r0,r9	; 023283A8
	mov r1,r5	; 023283AC
	mov r2,r4	; 023283B0
	bl loc_02328670	; 023283B4
	cmp r0,#0x0	; 023283B8
	ldrne r7,[r11,r7,lsl #0x2]	; 023283BC
	ldreq r0,[pool_0232847C]	; 023283C0
	ldreq r7,[r0,r7,lsl #0x2]	; 023283C4
	cmp r7,#0x200	; 023283C8
	bge loc_023283A8	; 023283CC
loc_023283D0:
	cmp r7,#0x100	; 023283D0
	strltb r7,[r10,r6]	; 023283D4
	addlt r6,r6,#0x1	; 023283D8
	blt loc_0232844C	; 023283DC
	ldr r8,[sp,#0x8]	; 023283E0
	mov r0,r8	; 023283E4
	cmp r0,#0x800	; 023283E8
	blt loc_0232841C	; 023283EC
loc_023283F0:
	mov r0,r9	; 023283F0
	mov r1,r5	; 023283F4
	mov r2,r5	; 023283F8
	bl loc_02328670	; 023283FC
	cmp r0,#0x0	; 02328400
	ldrne r0,[pool_02328480]	; 02328404
	ldrne r8,[r0,r8,lsl #0x2]	; 02328408
	ldreq r0,[pool_02328484]	; 0232840C
	ldreq r8,[r0,r8,lsl #0x2]	; 02328410
	cmp r8,#0x800	; 02328414
	bge loc_023283F0	; 02328418
loc_0232841C:
	sub r0,r6,r8	; 0232841C
	sub r1,r0,#0x1	; 02328420
	sub r7,r7,#0xfd	; 02328424
	cmp r7,#0x0	; 02328428
	ble loc_0232844C	; 0232842C
loc_02328430:
	ldrb r0,[r10,r1]	; 02328430
	sub r7,r7,#0x1	; 02328434
	cmp r7,#0x0	; 02328438
	strb r0,[r10,r6]	; 0232843C
	add r6,r6,#0x1	; 02328440
	add r1,r1,#0x1	; 02328444
	bgt loc_02328430	; 02328448
loc_0232844C:
	ldr r0,[sp,#0x0]	; 0232844C
	cmp r6,r0	; 02328450
	blt loc_02328398	; 02328454
loc_02328458:
	mov r0,r6	; 02328458
	add sp,sp,#0xc	; 0232845C
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328460
	bx lr	; 02328464
pool_02328468:
loc_02328468:
	.word 0x023FE000	; 02328468
pool_0232846C:
loc_0232846C:
	.word 0x023D98E0	; 0232846C
pool_02328470:
loc_02328470:
	.word 0x023D98F8	; 02328470
pool_02328474:
loc_02328474:
	.word 0x023D98E8	; 02328474
pool_02328478:
loc_02328478:
	.word 0x023D9B00	; 02328478
pool_0232847C:
loc_0232847C:
	.word 0x023DAB00	; 0232847C
pool_02328480:
loc_02328480:
	.word 0x023DFB00	; 02328480
pool_02328484:
loc_02328484:
	.word 0x023DBB00	; 02328484

; ===== function loc_02328488 =====
loc_02328488:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328488
	sub sp,sp,#0x4	; 0232848C
	ldr r1,[pool_02328564]	; 02328490
	mov r10,r0	; 02328494
	ldr r8,[r1,#0x4]	; 02328498
	mov r7,#0x0	; 0232849C
	mov r9,r8	; 023284A0
	ldr r5,[pool_02328568]	; 023284A4
	ldr r6,[pool_0232856C]	; 023284A8
	mov r0,#0xb	; 023284AC
	str r0,[sp,#0x0]	; 023284B0
	mov r11,#0x1	; 023284B4
	ldr r4,[pool_02328570]	; 023284B8
loc_023284BC:
	mov r0,r10	; 023284BC
	mov r1,r11	; 023284C0
	mov r2,r11	; 023284C4
	bl loc_02328670	; 023284C8
	cmp r0,#0x0	; 023284CC
	beq loc_02328500	; 023284D0
	add r0,r7,#0x1	; 023284D4
	mov r2,r7, lsl #0x1	; 023284D8
	orr r3,r9,#0x8000	; 023284DC
	orr r1,r9,#0x4000	; 023284E0
	strh r3,[r6,r2]	; 023284E4
	mov r0,r0, lsl #0x1	; 023284E8
	strh r1,[r6,r0]	; 023284EC
	add r9,r9,#0x1	; 023284F0
	add r8,r8,#0x1	; 023284F4
	add r7,r7,#0x2	; 023284F8
	b loc_023284BC	; 023284FC
loc_02328500:
	ldr r1,[sp,#0x0]	; 02328500
	mov r0,r10	; 02328504
	mov r2,r11	; 02328508
	bl loc_02328670	; 0232850C
loc_02328510:
	sub r7,r7,#0x1	; 02328510
	mov r1,r7, lsl #0x1	; 02328514
	ldrh r2,[r6,r1]	; 02328518
	ands r1,r2,#0x8000	; 0232851C
	beq loc_02328544	; 02328520
	and r1,r2,r4	; 02328524
	str r0,[r5,r1,lsl #0x2]	; 02328528
	mov r0,r1	; 0232852C
	cmp r7,#0x0	; 02328530
	bne loc_02328510	; 02328534
	add sp,sp,#0x4	; 02328538
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 0232853C
	bx lr	; 02328540
loc_02328544:
	ldr r1,[pool_02328574]	; 02328544
	and r2,r2,r4	; 02328548
	mov r9,r8	; 0232854C
	str r0,[r1,r2,lsl #0x2]	; 02328550
	b loc_023284BC	; 02328554
	.byte 0x04, 0xD0, 0x8D, 0xE2, 0xF0, 0x4F, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 02328564
pool_02328564:
loc_02328564:
	.word 0x023D98E8	; 02328564
pool_02328568:
loc_02328568:
	.word 0x023DFB00	; 02328568
pool_0232856C:
loc_0232856C:
	.word 0x023D9900	; 0232856C
pool_02328570:
loc_02328570:
	.word 0x00003FFF	; 02328570
pool_02328574:
loc_02328574:
	.word 0x023DBB00	; 02328574

; ===== function loc_02328578 =====
loc_02328578:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328578
	sub sp,sp,#0xc	; 0232857C
	ldr r1,[pool_0232865C]	; 02328580
	mov r10,r0	; 02328584
	ldr r8,[r1,#0x0]	; 02328588
	mov r7,#0x0	; 0232858C
	mov r9,r8	; 02328590
	ldr r5,[pool_02328660]	; 02328594
	ldr r6,[pool_02328664]	; 02328598
	str r7,[sp,#0x8]	; 0232859C
	str r7,[sp,#0x0]	; 023285A0
	mov r0,#0x9	; 023285A4
	str r0,[sp,#0x4]	; 023285A8
	mov r11,#0x1	; 023285AC
	ldr r4,[pool_02328668]	; 023285B0
loc_023285B4:
	ldr r2,[sp,#0x0]	; 023285B4
	mov r0,r10	; 023285B8
	mov r1,r11	; 023285BC
	bl loc_02328670	; 023285C0
	cmp r0,#0x0	; 023285C4
	beq loc_023285F8	; 023285C8
	add r0,r7,#0x1	; 023285CC
	mov r1,r7, lsl #0x1	; 023285D0
	mov r0,r0, lsl #0x1	; 023285D4
	orr r2,r9,#0x8000	; 023285D8
	strh r2,[r6,r1]	; 023285DC
	orr r1,r9,#0x4000	; 023285E0
	strh r1,[r6,r0]	; 023285E4
	add r9,r9,#0x1	; 023285E8
	add r8,r8,#0x1	; 023285EC
	add r7,r7,#0x2	; 023285F0
	b loc_023285B4	; 023285F4
loc_023285F8:
	ldr r1,[sp,#0x4]	; 023285F8
	ldr r2,[sp,#0x8]	; 023285FC
	mov r0,r10	; 02328600
	bl loc_02328670	; 02328604
loc_02328608:
	sub r7,r7,#0x1	; 02328608
	mov r1,r7, lsl #0x1	; 0232860C
	ldrh r2,[r6,r1]	; 02328610
	ands r1,r2,#0x8000	; 02328614
	beq loc_0232863C	; 02328618
	and r1,r2,r4	; 0232861C
	str r0,[r5,r1,lsl #0x2]	; 02328620
	mov r0,r1	; 02328624
	cmp r7,#0x0	; 02328628
	bne loc_02328608	; 0232862C
	add sp,sp,#0xc	; 02328630
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328634
	bx lr	; 02328638
loc_0232863C:
	ldr r1,[pool_0232866C]	; 0232863C
	and r2,r2,r4	; 02328640
	mov r9,r8	; 02328644
	str r0,[r1,r2,lsl #0x2]	; 02328648
	b loc_023285B4	; 0232864C
	.byte 0x0C, 0xD0, 0x8D, 0xE2, 0xF0, 0x4F, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 0232865C
pool_0232865C:
loc_0232865C:
	.word 0x023D98E8	; 0232865C
pool_02328660:
loc_02328660:
	.word 0x023D9B00	; 02328660
pool_02328664:
loc_02328664:
	.word 0x023D9900	; 02328664
pool_02328668:
loc_02328668:
	.word 0x00003FFF	; 02328668
pool_0232866C:
loc_0232866C:
	.word 0x023DAB00	; 0232866C

; ===== function loc_02328670 =====
loc_02328670:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328670
	sub sp,sp,#0x4	; 02328674
	ldr r6,[pool_02328780]	; 02328678
	ldr r8,[pool_02328784]	; 0232867C
	ldr r5,[r6,r2,lsl #0x2]	; 02328680
	ldr r4,[pool_02328788]	; 02328684
	add r3,r5,r1	; 02328688
	cmp r3,#0x20	; 0232868C
	mov r9,r2, lsl #0x2	; 02328690
	ldr r7,[r8,r2,lsl #0x2]	; 02328694
	ldr lr,[r4,r2,lsl #0x2]	; 02328698
	ble loc_02328708	; 0232869C
	add r2,r7,#0x1	; 023286A0
	ldrb r10,[r0,r7]	; 023286A4
	ldrb r2,[r0,r2]	; 023286A8
	add r3,r7,#0x2	; 023286AC
	mov r11,r10, lsl #0x18	; 023286B0
	orr r2,r11,r2, lsl #0x10	; 023286B4
	rsb r11,r1,#0x20	; 023286B8
	sub r10,r1,#0x20	; 023286BC
	add r12,r7,#0x3	; 023286C0
	mov lr,lr, lsr r11	; 023286C4
	rsb r1,r1,#0x40	; 023286C8
	ldrb r3,[r0,r3]	; 023286CC
	ldrb r11,[r0,r12]	; 023286D0
	sub r1,r1,r5	; 023286D4
	orr r0,r2,r3, lsl #0x8	; 023286D8
	add r3,r5,r10	; 023286DC
	orr r10,r11,r0	; 023286E0
	mov r2,r10, lsl r3	; 023286E4
	add r0,r7,#0x4	; 023286E8
	str r0,[r8,r9]	; 023286EC
	add sp,sp,#0x4	; 023286F0
	str r2,[r4,r9]	; 023286F4
	str r3,[r6,r9]	; 023286F8
	orr r0,lr,r10, lsr r1	; 023286FC
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328700
	bx lr	; 02328704
loc_02328708:
	cmp r3,#0x20	; 02328708
	movne r2,lr, lsl r1	; 0232870C
	rsbne r0,r1,#0x20	; 02328710
	addne sp,sp,#0x4	; 02328714
	movne r0,lr, lsr r0	; 02328718
	strne r2,[r4,r9]	; 0232871C
	strne r3,[r6,r9]	; 02328720
	ldmneia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328724
	bxne lr	; 02328728
	add r3,r7,#0x1	; 0232872C
	ldrb r5,[r0,r7]	; 02328730
	add r10,r7,#0x2	; 02328734
	ldrb r3,[r0,r3]	; 02328738
	mov r5,r5, lsl #0x18	; 0232873C
	add r2,r7,#0x3	; 02328740
	orr r3,r5,r3, lsl #0x10	; 02328744
	ldrb r5,[r0,r2]	; 02328748
	ldrb r10,[r0,r10]	; 0232874C
	add r2,r7,#0x4	; 02328750
	orr r0,r3,r10, lsl #0x8	; 02328754
	orr r3,r5,r0	; 02328758
	rsb r0,r1,#0x20	; 0232875C
	mov r1,#0x0	; 02328760
	mov r0,lr, lsr r0	; 02328764
	str r3,[r4,r9]	; 02328768
	str r2,[r8,r9]	; 0232876C
	str r1,[r6,r9]	; 02328770
	add sp,sp,#0x4	; 02328774
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328778
	bx lr	; 0232877C
pool_02328780:
loc_02328780:
	.word 0x023D98F8	; 02328780
pool_02328784:
loc_02328784:
	.word 0x023D98E0	; 02328784
pool_02328788:
loc_02328788:
	.word 0x023D98F0	; 02328788
.thumb

; ===== function loc_0232878C =====
loc_0232878C:
	push {r4,lr}	; 0232878C
	add r4,r0,#0x0	; 0232878E
	bl loc_02328B38	; 02328790
	ldrh r1,[r4,#0x12]	; 02328794
	cmp r0,r1	; 02328796
	beq loc_023287A4	; 02328798
	strh r0,[r4,#0x12]	; 0232879A
	mov r0,#0x1	; 0232879C
	pop {r4}	; 0232879E
	pop {r3}	; 023287A0
	bx r3	; 023287A2
loc_023287A4:
	mov r0,#0x0	; 023287A4
	pop {r4}	; 023287A6
	pop {r3}	; 023287A8
	bx r3	; 023287AA

; ===== function loc_023287AC =====
P1_Entry_023287AC:
	push {r4,lr}	; 023287AC
	add r4,r0,#0x0	; 023287AE
	bl loc_02328B38	; 023287B0
	ldr r1,[r4,#0xc]	; 023287B4
	lsl r0,r0,#0x1	; 023287B6
	ldrb r0,[r1,r0]	; 023287B8
	pop {r4}	; 023287BA
	pop {r3}	; 023287BC
	bx r3	; 023287BE

; ===== function loc_023287C0 =====
loc_023287C0:
	ldrh r0,[r0,#0x16]	; 023287C0
	lsl r0,r0,#0x16	; 023287C2
	lsr r0,r0,#0x1b	; 023287C4
	ldrh r3,[r1,#0x0]	; 023287C6
	cmp r3,#0x0	; 023287C8
	beq loc_023287DC	; 023287CA
	add r2,r2,r0	; 023287CC
loc_023287CE:
	cmp r3,#0xa	; 023287CE
	bne loc_023287D4	; 023287D0
	add r0,r0,r2	; 023287D2
loc_023287D4:
	add r1,r1,#0x2	; 023287D4
	ldrh r3,[r1,#0x0]	; 023287D6
	cmp r3,#0x0	; 023287D8
	bne loc_023287CE	; 023287DA
loc_023287DC:
	bx lr	; 023287DC
	.byte 0x00, 0x00	; 023287E0

; ===== function loc_023287E0 =====
loc_023287E0:
	push {r4,r5,r6,r7,lr}	; 023287E0
	sub sp,#0x4	; 023287E2
	add r5,r0,#0x0	; 023287E4
	add r6,r2,#0x0	; 023287E6
	mov r4,#0x0	; 023287E8
	str r4,[sp,#0x0]	; 023287EA
	cmp r1,#0x0	; 023287EC
	beq loc_0232880A	; 023287EE
	add r7,sp,#0x0	; 023287F0
loc_023287F2:
	add r0,r5,#0x0	; 023287F2
	add r2,r7,#0x0	; 023287F4
	add r3,r6,#0x0	; 023287F6
	bl loc_02328814	; 023287F8
	add r1,r0,#0x0	; 023287FC
	ldr r0,[sp,#0x0]	; 023287FE
	cmp r4,r0	; 02328800
	bge loc_02328806	; 02328802
	add r4,r0,#0x0	; 02328804
loc_02328806:
	cmp r1,#0x0	; 02328806
	bne loc_023287F2	; 02328808
loc_0232880A:
	add r0,r4,#0x0	; 0232880A
	add sp,#0x4	; 0232880C
	pop {r4,r5,r6,r7}	; 0232880E
	pop {r3}	; 02328810
	bx r3	; 02328812

; ===== function loc_02328814 =====
loc_02328814:
	push {r4,r5,r6,r7,lr}	; 02328814
	sub sp,#0x4	; 02328816
	add r7,r0,#0x0	; 02328818
	add r5,r1,#0x0	; 0232881A
	str r2,[sp,#0x0]	; 0232881C
	add r6,r3,#0x0	; 0232881E
	mov r4,#0x0	; 02328820
	ldrh r1,[r5,#0x0]	; 02328822
	cmp r1,#0x0	; 02328824
	beq loc_0232885C	; 02328826
loc_02328828:
	cmp r1,#0xa	; 02328828
	bne loc_02328846	; 0232882A
	ldr r0,[sp,#0x0]	; 0232882C
	cmp r0,#0x0	; 0232882E
	beq loc_0232883C	; 02328830
	cmp r4,r6	; 02328832
	ble loc_02328838	; 02328834
	sub r4,r4,r6	; 02328836
loc_02328838:
	ldr r0,[sp,#0x0]	; 02328838
	str r4,[r0,#0x0]	; 0232883A
loc_0232883C:
	add r0,r5,#0x2	; 0232883C
	add sp,#0x4	; 0232883E
	pop {r4,r5,r6,r7}	; 02328840
	pop {r3}	; 02328842
	bx r3	; 02328844
loc_02328846:
	cmp r1,#0xd	; 02328846
	beq loc_02328854	; 02328848
	add r0,r7,#0x0	; 0232884A
	bl loc_02328878	; 0232884C
	add r0,r6,r0	; 02328850
	add r4,r4,r0	; 02328852
loc_02328854:
	add r5,r5,#0x2	; 02328854
	ldrh r1,[r5,#0x0]	; 02328856
	cmp r1,#0x0	; 02328858
	bne loc_02328828	; 0232885A
loc_0232885C:
	ldr r0,[sp,#0x0]	; 0232885C
	cmp r0,#0x0	; 0232885E
	beq loc_0232886C	; 02328860
	cmp r4,r6	; 02328862
	ble loc_02328868	; 02328864
	sub r4,r4,r6	; 02328866
loc_02328868:
	ldr r0,[sp,#0x0]	; 02328868
	str r4,[r0,#0x0]	; 0232886A
loc_0232886C:
	mov r0,#0x0	; 0232886C
	add sp,#0x4	; 0232886E
	pop {r4,r5,r6,r7}	; 02328870
	pop {r3}	; 02328872
	bx r3	; 02328874
	.byte 0x00, 0x00	; 02328878

; ===== function loc_02328878 =====
loc_02328878:
	push {r4,lr}	; 02328878
	add r4,r0,#0x0	; 0232887A
	bl loc_02328B38	; 0232887C
	ldr r1,[r4,#0xc]	; 02328880
	lsl r0,r0,#0x1	; 02328882
	add r0,r1,r0	; 02328884
	ldrb r0,[r0,#0x1]	; 02328886
	pop {r4}	; 02328888
	pop {r3}	; 0232888A
	bx r3	; 0232888C
	.byte 0x00, 0x00	; 02328890

; ===== function loc_02328890 =====
loc_02328890:
	push {r0,r1,r2,r3}	; 02328890
	push {r4,r5,r6,r7,lr}	; 02328892
	sub sp,#0x1c	; 02328894
	add r5,r0,#0x0	; 02328896
	str r1,[sp,#0x8]	; 02328898
	ldr r1,[sp,#0x40]	; 0232889A
	str r1,[sp,#0x40]	; 0232889C
	ldr r1,[sp,#0x44]	; 0232889E
	str r1,[sp,#0x44]	; 023288A0
	ldr r6,[sp,#0x48]	; 023288A2
	ldr r1,[sp,#0x4c]	; 023288A4
	str r1,[sp,#0x4c]	; 023288A6
	add r1,r6,#0x0	; 023288A8
	ldr r2,[sp,#0x40]	; 023288AA
	bl loc_023287E0	; 023288AC
	add r4,r0,#0x0	; 023288B0
	add r0,r5,#0x0	; 023288B2
	add r1,r6,#0x0	; 023288B4
	ldr r2,[sp,#0x44]	; 023288B6
	bl loc_023287C0	; 023288B8
	str r0,[sp,#0x14]	; 023288BC
	mov r1,sp	; 023288BE
	sub r1,r1,#0x4	; 023288C0
	add r0,sp,#0x30	; 023288C2
	ldrh r0,[r0,#0x8]	; 023288C4
	strh r0,[r1,#0x0]	; 023288C6
	ldmia r1!,{r0}	; 023288C8
	add r1,r4,#0x0	; 023288CA
	bl loc_02328CAC	; 023288CC
	add r7,r0,#0x0	; 023288D0
	mov r1,sp	; 023288D2
	sub r1,r1,#0x4	; 023288D4
	add r0,sp,#0x30	; 023288D6
	ldrh r0,[r0,#0xc]	; 023288D8
	strh r0,[r1,#0x0]	; 023288DA
	ldmia r1!,{r0}	; 023288DC
	ldr r1,[sp,#0x14]	; 023288DE
	bl loc_02328C74	; 023288E0
	str r0,[sp,#0x10]	; 023288E4
	mov r1,sp	; 023288E6
	sub r1,r1,#0x4	; 023288E8
	add r0,sp,#0x30	; 023288EA
	ldrh r0,[r0,#0x8]	; 023288EC
	strh r0,[r1,#0x0]	; 023288EE
	ldmia r1!,{r0}	; 023288F0
	add r1,r4,#0x0	; 023288F2
	bl loc_023289A0	; 023288F4
	add r4,r7,r0	; 023288F8
	str r4,[sp,#0xc]	; 023288FA
	add r0,r5,#0x0	; 023288FC
	add r1,r6,#0x0	; 023288FE
	add r2,sp,#0x18	; 02328900
	ldr r3,[sp,#0x40]	; 02328902
	bl loc_02328814	; 02328904
	mov r1,sp	; 02328908
	sub r1,r1,#0x4	; 0232890A
	add r0,sp,#0x30	; 0232890C
	ldrh r0,[r0,#0x8]	; 0232890E
	strh r0,[r1,#0x0]	; 02328910
	ldmia r1!,{r0}	; 02328912
	ldr r1,[sp,#0x18]	; 02328914
	bl loc_023289A0	; 02328916
	sub r4,r4,r0	; 0232891A
	ldrh r1,[r6,#0x0]	; 0232891C
	cmp r1,#0x0	; 0232891E
	beq loc_02328994	; 02328920
loc_02328922:
	cmp r1,#0xa	; 02328922
	bne loc_0232895A	; 02328924
	add r0,r5,#0x0	; 02328926
	add r1,r6,#0x2	; 02328928
	add r2,sp,#0x18	; 0232892A
	ldr r3,[sp,#0x40]	; 0232892C
	bl loc_02328814	; 0232892E
	mov r1,sp	; 02328932
	sub r1,r1,#0x4	; 02328934
	add r0,sp,#0x30	; 02328936
	ldrh r0,[r0,#0x8]	; 02328938
	strh r0,[r1,#0x0]	; 0232893A
	ldmia r1!,{r0}	; 0232893C
	ldr r1,[sp,#0x18]	; 0232893E
	bl loc_023289A0	; 02328940
	ldr r1,[sp,#0xc]	; 02328944
	sub r4,r1,r0	; 02328946
	ldrh r0,[r5,#0x16]	; 02328948
	lsl r0,r0,#0x16	; 0232894A
	lsr r1,r0,#0x1b	; 0232894C
	ldr r0,[sp,#0x44]	; 0232894E
	add r1,r1,r0	; 02328950
	ldr r0,[sp,#0x10]	; 02328952
	add r0,r0,r1	; 02328954
	str r0,[sp,#0x10]	; 02328956
	b loc_0232898C	; 02328958
loc_0232895A:
	cmp r1,#0xd	; 0232895A
	beq loc_0232898C	; 0232895C
	add r0,r5,#0x0	; 0232895E
	bl loc_02328B38	; 02328960
	lsl r0,r0,#0x10	; 02328964
	lsr r0,r0,#0x10	; 02328966
	lsl r7,r0,#0x1	; 02328968
	str r0,[sp,#0x0]	; 0232896A
	ldr r0,[sp,#0x4c]	; 0232896C
	str r0,[sp,#0x4]	; 0232896E
	add r0,r5,#0x0	; 02328970
	ldr r1,[sp,#0x8]	; 02328972
	ldr r2,[r5,#0xc]	; 02328974
	ldrb r2,[r2,r7]	; 02328976
	sub r2,r4,r2	; 02328978
	ldr r3,[sp,#0x10]	; 0232897A
	bl loc_023289D4	; 0232897C
	ldr r0,[r5,#0xc]	; 02328980
	add r0,r0,r7	; 02328982
	ldrb r1,[r0,#0x1]	; 02328984
	ldr r0,[sp,#0x40]	; 02328986
	add r0,r0,r1	; 02328988
	add r4,r4,r0	; 0232898A
loc_0232898C:
	add r6,r6,#0x2	; 0232898C
	ldrh r1,[r6,#0x0]	; 0232898E
	cmp r1,#0x0	; 02328990
	bne loc_02328922	; 02328992
loc_02328994:
	add sp,#0x1c	; 02328994
	pop {r4,r5,r6,r7}	; 02328996
	pop {r3}	; 02328998
	add sp,#0x10	; 0232899A
	bx r3	; 0232899C
	.byte 0x00, 0x00	; 023289A0

; ===== function loc_023289A0 =====
loc_023289A0:
	push {r0,r1,r2,r3}	; 023289A0
	push {lr}	; 023289A2
	sub sp,#0x4	; 023289A4
	add r0,sp,#0x8	; 023289A6
	ldrh r0,[r0,#0x0]	; 023289A8
	lsl r0,r0,#0x10	; 023289AA
	lsr r0,r0,#0x1e	; 023289AC
	cmp r0,#0x1	; 023289AE
	bne loc_023289C2	; 023289B0
	add r0,r1,#0x1	; 023289B2
	mov r1,#0x2	; 023289B4
	blx P1_SignedDivMod	; 023289B6
	add sp,#0x4	; 023289BA
	pop {r3}	; 023289BC
	add sp,#0x10	; 023289BE
	bx r3	; 023289C0
loc_023289C2:
	cmp r0,#0x2	; 023289C2
	beq loc_023289C8	; 023289C4
	mov r1,#0x0	; 023289C6
loc_023289C8:
	add r0,r1,#0x0	; 023289C8
	add sp,#0x4	; 023289CA
	pop {r3}	; 023289CC
	add sp,#0x10	; 023289CE
	bx r3	; 023289D0
	.byte 0x00, 0x00	; 023289D4

; ===== function loc_023289D4 =====
loc_023289D4:
	push {r4,r5,r6,r7,lr}	; 023289D4
	sub sp,#0x2c	; 023289D6
	str r1,[sp,#0x0]	; 023289D8
	str r2,[sp,#0x4]	; 023289DA
	str r3,[sp,#0x8]	; 023289DC
	ldr r1,[sp,#0x44]	; 023289DE
	str r1,[sp,#0x44]	; 023289E0
	mov r5,#0x0	; 023289E2
	add r4,r5,#0x0	; 023289E4
	ldrh r2,[r0,#0x16]	; 023289E6
	add r1,sp,#0x24	; 023289E8
	strh r2,[r1,#0x0]	; 023289EA
	ldr r2,[r0,#0x0]	; 023289EC
	mov r3,#0x14	; 023289EE
	ldrsh r3,[r0,r3]	; 023289F0
	add r0,sp,#0x30	; 023289F2
	ldrh r0,[r0,#0x10]	; 023289F4
	mul r3,r0	; 023289F6
	lsl r0,r3,#0x1	; 023289F8
	add r7,r2,r0	; 023289FA
	str r5,[sp,#0xc]	; 023289FC
	ldrh r1,[r1,#0x0]	; 023289FE
	lsl r0,r1,#0x16	; 02328A00
	lsr r0,r0,#0x1b	; 02328A02
	str r0,[sp,#0x14]	; 02328A04
	cmp r0,#0x0	; 02328A06
	ble loc_02328A68	; 02328A08
	lsl r0,r1,#0x1b	; 02328A0A
	lsr r0,r0,#0x1b	; 02328A0C
	str r0,[sp,#0x10]	; 02328A0E
	str r5,[sp,#0x20]	; 02328A10
	str r5,[sp,#0x1c]	; 02328A12
loc_02328A14:
	ldr r6,[sp,#0x1c]	; 02328A14
	ldr r0,[sp,#0x10]	; 02328A16
	cmp r0,#0x0	; 02328A18
	ble loc_02328A5C	; 02328A1A
	ldr r1,[sp,#0x8]	; 02328A1C
	ldr r0,[sp,#0xc]	; 02328A1E
	add r0,r1,r0	; 02328A20
	str r0,[sp,#0x18]	; 02328A22
loc_02328A24:
	cmp r4,#0x0	; 02328A24
	bne loc_02328A2A	; 02328A26
	ldrh r5,[r7,#0x0]	; 02328A28
loc_02328A2A:
	add r1,r5,#0x0	; 02328A2A
	mov r0,#0x1	; 02328A2C
	and r1,r0	; 02328A2E
	cmp r1,#0x0	; 02328A30
	bne loc_02328A42	; 02328A32
	ldr r0,[sp,#0x0]	; 02328A34
	ldr r1,[sp,#0x4]	; 02328A36
	add r1,r1,r6	; 02328A38
	ldr r2,[sp,#0x18]	; 02328A3A
	ldr r3,[sp,#0x44]	; 02328A3C
	bl loc_02328AA4	; 02328A3E
loc_02328A42:
	lsl r0,r5,#0xf	; 02328A42
	lsr r5,r0,#0x10	; 02328A44
	add r0,r4,#0x1	; 02328A46
	lsl r0,r0,#0x10	; 02328A48
	lsr r4,r0,#0x10	; 02328A4A
	cmp r4,#0xf	; 02328A4C
	bls loc_02328A54	; 02328A4E
	ldr r4,[sp,#0x20]	; 02328A50
	add r7,r7,#0x2	; 02328A52
loc_02328A54:
	add r6,r6,#0x1	; 02328A54
	ldr r0,[sp,#0x10]	; 02328A56
	cmp r6,r0	; 02328A58
	blt loc_02328A24	; 02328A5A
loc_02328A5C:
	ldr r0,[sp,#0xc]	; 02328A5C
	add r1,r0,#0x1	; 02328A5E
	str r1,[sp,#0xc]	; 02328A60
	ldr r0,[sp,#0x14]	; 02328A62
	cmp r1,r0	; 02328A64
	blt loc_02328A14	; 02328A66
loc_02328A68:
	add sp,#0x2c	; 02328A68
	pop {r4,r5,r6,r7}	; 02328A6A
	pop {r3}	; 02328A6C
	bx r3	; 02328A6E

; ===== function loc_02328A70 =====
P1_Entry_02328A70:
	push {r4,r5,r6,r7,lr}	; 02328A70
	sub sp,#0xc	; 02328A72
	add r5,r0,#0x0	; 02328A74
	add r4,r1,#0x0	; 02328A76
	add r6,r2,#0x0	; 02328A78
	add r7,r3,#0x0	; 02328A7A
	add r1,sp,#0x10	; 02328A7C
	ldrh r1,[r1,#0x10]	; 02328A7E
	bl loc_02328B38	; 02328A80
	lsl r0,r0,#0x10	; 02328A84
	lsr r0,r0,#0x10	; 02328A86
	str r0,[sp,#0x0]	; 02328A88
	ldr r0,[sp,#0x24]	; 02328A8A
	str r0,[sp,#0x4]	; 02328A8C
	add r0,r5,#0x0	; 02328A8E
	add r1,r4,#0x0	; 02328A90
	add r2,r6,#0x0	; 02328A92
	add r3,r7,#0x0	; 02328A94
	bl loc_023289D4	; 02328A96
	add sp,#0xc	; 02328A9A
	pop {r4,r5,r6,r7}	; 02328A9C
	pop {r3}	; 02328A9E
	bx r3	; 02328AA0
	.byte 0x00, 0x00	; 02328AA4

; ===== function loc_02328AA4 =====
loc_02328AA4:
	push {r4,lr}	; 02328AA4
	ldrh r4,[r0,#0x8]	; 02328AA6
	cmp r4,#0x0	; 02328AA8
	bne loc_02328AB0	; 02328AAA
	bl loc_02328AB8	; 02328AAC
loc_02328AB0:
	pop {r4}	; 02328AB0
	pop {r3}	; 02328AB2
	bx r3	; 02328AB4
	.byte 0x00, 0x00	; 02328AB8

; ===== function loc_02328AB8 =====
loc_02328AB8:
	push {r4,r5,r6,r7}	; 02328AB8
	sub sp,#0x18	; 02328ABA
	add r4,r0,#0x0	; 02328ABC
	add r0,r1,#0x0	; 02328ABE
	add r5,r2,#0x0	; 02328AC0
	str r3,[sp,#0x0]	; 02328AC2
	asr r3,r0,#0x3	; 02328AC4
	asr r7,r5,#0x3	; 02328AC6
	mov r2,#0x3	; 02328AC8
	str r1,[sp,#0x10]	; 02328ACA
	and r1,r2	; 02328ACC
	str r1,[sp,#0x10]	; 02328ACE
	asr r2,r0,#0x2	; 02328AD0
	mov r1,#0x1	; 02328AD2
	and r2,r1	; 02328AD4
	mov r6,#0x7	; 02328AD6
	add r1,r5,#0x0	; 02328AD8
	str r1,[sp,#0x4]	; 02328ADA
	and r1,r6	; 02328ADC
	str r1,[sp,#0x4]	; 02328ADE
	ldrh r1,[r4,#0x4]	; 02328AE0
	str r1,[sp,#0x8]	; 02328AE2
	lsl r1,r1,#0x4	; 02328AE4
	asr r1,r1,#0x3	; 02328AE6
	ldr r6,[r4,#0x0]	; 02328AE8
	str r6,[sp,#0xc]	; 02328AEA
	cmp r0,#0x0	; 02328AEC
	blt loc_02328B30	; 02328AEE
	ldr r6,[sp,#0x8]	; 02328AF0
	cmp r0,r6	; 02328AF2
	bge loc_02328B30	; 02328AF4
	cmp r5,#0x0	; 02328AF6
	blt loc_02328B30	; 02328AF8
	ldrh r0,[r4,#0x6]	; 02328AFA
	cmp r5,r0	; 02328AFC
	bge loc_02328B30	; 02328AFE
	lsl r0,r3,#0x4	; 02328B00
	mul r1,r7	; 02328B02
	add r0,r0,r1	; 02328B04
	lsl r1,r0,#0x1	; 02328B06
	ldr r0,[sp,#0xc]	; 02328B08
	add r4,r0,r1	; 02328B0A
	ldr r0,[sp,#0x4]	; 02328B0C
	lsl r0,r0,#0x1	; 02328B0E
	add r0,r2,r0	; 02328B10
	lsl r3,r0,#0x1	; 02328B12
	ldr r0,[sp,#0x10]	; 02328B14
	lsl r2,r0,#0x2	; 02328B16
	ldrh r1,[r4,r3]	; 02328B18
	mov r0,#0xf	; 02328B1A
	add r5,r0,#0x0	; 02328B1C
	lsl r5,r2	; 02328B1E
	bic r1,r5	; 02328B20
	ldr r5,[sp,#0x0]	; 02328B22
	lsl r5,r5,#0x18	; 02328B24
	lsr r5,r5,#0x18	; 02328B26
	and r5,r0	; 02328B28
	lsl r5,r2	; 02328B2A
	orr r1,r5	; 02328B2C
	strh r1,[r4,r3]	; 02328B2E
loc_02328B30:
	add sp,#0x18	; 02328B30
	pop {r4,r5,r6,r7}	; 02328B32
	bx lr	; 02328B34
	.byte 0x00, 0x00	; 02328B38

; ===== function loc_02328B38 =====
loc_02328B38:
	push {r4,r5,r6,r7,lr}	; 02328B38
	sub sp,#0x14	; 02328B3A
	str r0,[sp,#0x8]	; 02328B3C
	add r6,r1,#0x0	; 02328B3E
	mov r5,#0x0	; 02328B40
	add r7,r5,#0x0	; 02328B42
	ldrh r0,[r0,#0x1a]	; 02328B44
	str r0,[sp,#0xc]	; 02328B46
	cmp r0,#0x0	; 02328B48
	ble loc_02328B8A	; 02328B4A
	ldr r0,[sp,#0x8]	; 02328B4C
	ldr r2,[r0,#0x8]	; 02328B4E
	add r4,r2,#0x0	; 02328B50
	add r3,r5,#0x0	; 02328B52
loc_02328B54:
	ldrh r0,[r4,#0x0]	; 02328B54
	cmp r0,r6	; 02328B56
	bhi loc_02328B72	; 02328B58
	add r0,r2,r3	; 02328B5A
	ldrh r0,[r0,#0x2]	; 02328B5C
	cmp r6,r0	; 02328B5E
	bhi loc_02328B72	; 02328B60
	add r1,r5,r6	; 02328B62
	lsl r0,r7,#0x2	; 02328B64
	ldrh r0,[r2,r0]	; 02328B66
	sub r0,r1,r0	; 02328B68
	add sp,#0x14	; 02328B6A
	pop {r4,r5,r6,r7}	; 02328B6C
	pop {r3}	; 02328B6E
	bx r3	; 02328B70
loc_02328B72:
	add r0,r2,r3	; 02328B72
	ldrh r1,[r0,#0x2]	; 02328B74
	ldrh r0,[r2,r3]	; 02328B76
	sub r0,r1,r0	; 02328B78
	add r0,r0,#0x1	; 02328B7A
	add r5,r5,r0	; 02328B7C
	add r4,r4,#0x4	; 02328B7E
	add r3,r3,#0x4	; 02328B80
	add r7,r7,#0x1	; 02328B82
	ldr r0,[sp,#0xc]	; 02328B84
	cmp r7,r0	; 02328B86
	blt loc_02328B54	; 02328B88
loc_02328B8A:
	lsl r0,r5,#0x10	; 02328B8A
	lsr r0,r0,#0x10	; 02328B8C
	str r0,[sp,#0x0]	; 02328B8E
	ldr r0,[sp,#0x8]	; 02328B90
	ldrh r0,[r0,#0x12]	; 02328B92
	str r0,[sp,#0x4]	; 02328B94
	add r0,r6,#0x0	; 02328B96
	mov r1,#0x0	; 02328B98
	ldr r2,[sp,#0x8]	; 02328B9A
	ldrh r2,[r2,#0x18]	; 02328B9C
	sub r2,r2,#0x1	; 02328B9E
	ldr r3,[sp,#0x8]	; 02328BA0
	ldr r3,[r3,#0x4]	; 02328BA2
	bl loc_02328BB0	; 02328BA4
	add sp,#0x14	; 02328BA8
	pop {r4,r5,r6,r7}	; 02328BAA
	pop {r3}	; 02328BAC
	bx r3	; 02328BAE

; ===== function loc_02328BB0 =====
loc_02328BB0:
	push {r4,r5}	; 02328BB0
	cmp r1,r2	; 02328BB2
	bgt loc_02328BE0	; 02328BB4
loc_02328BB6:
	sub r4,r2,r1	; 02328BB6
	asr r4,r4,#0x1	; 02328BB8
	add r4,r1,r4	; 02328BBA
	lsl r5,r4,#0x1	; 02328BBC
	ldrh r5,[r3,r5]	; 02328BBE
	cmp r5,r0	; 02328BC0
	bls loc_02328BC8	; 02328BC2
	sub r2,r4,#0x1	; 02328BC4
	b loc_02328BDC	; 02328BC6
loc_02328BC8:
	cmp r5,r0	; 02328BC8
	bcs loc_02328BD0	; 02328BCA
	add r1,r4,#0x1	; 02328BCC
	b loc_02328BDC	; 02328BCE
loc_02328BD0:
	ldr r0,[pool_02328BEC]	; 02328BD0
	add r0,sp	; 02328BD2
	ldrh r0,[r0,#0x10]	; 02328BD4
	add r0,r0,r4	; 02328BD6
	pop {r4,r5}	; 02328BD8
	bx lr	; 02328BDA
loc_02328BDC:
	cmp r1,r2	; 02328BDC
	ble loc_02328BB6	; 02328BDE
loc_02328BE0:
	ldr r0,[pool_02328BEC]	; 02328BE0
	add r0,sp	; 02328BE2
	ldrh r0,[r0,#0x14]	; 02328BE4
	pop {r4,r5}	; 02328BE6
	bx lr	; 02328BE8
	.byte 0xC0, 0x46	; 02328BEC
pool_02328BEC:
loc_02328BEC:
	.word 0xFFFFFFF8	; 02328BEC

; ===== function loc_02328BF0 =====
loc_02328BF0:
	str r1,[r0,#0x0]	; 02328BF0
	strh r2,[r0,#0x4]	; 02328BF2
	strh r3,[r0,#0x6]	; 02328BF4
	ldr r1,[sp,#0x0]	; 02328BF6
	strh r1,[r0,#0x8]	; 02328BF8
	ldr r1,[sp,#0x4]	; 02328BFA
	str r1,[r0,#0xc]	; 02328BFC
	bx lr	; 02328BFE

; ===== function loc_02328C00 =====
loc_02328C00:
	push {r4}	; 02328C00
	sub sp,#0x4	; 02328C02
	ldrh r3,[r1,#0x6]	; 02328C04
	strh r3,[r0,#0x10]	; 02328C06
	ldrh r3,[r1,#0x8]	; 02328C08
	strh r3,[r0,#0x16]	; 02328C0A
	add r1,#0xa	; 02328C0C
	str r1,[r0,#0xc]	; 02328C0E
	ldr r3,[r0,#0xc]	; 02328C10
	ldrh r1,[r0,#0x10]	; 02328C12
	lsl r1,r1,#0x1	; 02328C14
	add r1,r3,r1	; 02328C16
	str r1,[r0,#0x0]	; 02328C18
	ldrh r1,[r0,#0x16]	; 02328C1A
	lsl r3,r1,#0x1b	; 02328C1C
	lsr r3,r3,#0x1b	; 02328C1E
	lsl r1,r1,#0x16	; 02328C20
	lsr r1,r1,#0x1b	; 02328C22
	mul r3,r1	; 02328C24
	add r3,#0xf	; 02328C26
	asr r1,r3,#0x4	; 02328C28
	strh r1,[r0,#0x14]	; 02328C2A
	mov r1,#0x0	; 02328C2C
	strh r1,[r0,#0x12]	; 02328C2E
	add r4,r0,#0x0	; 02328C30
	add r4,#0x1c	; 02328C32
	ldr r3,[r4,#0x0]	; 02328C34
	mov r1,#0x1	; 02328C36
	bic r3,r1	; 02328C38
	orr r3,r1	; 02328C3A
	str r3,[r4,#0x0]	; 02328C3C
	ldr r3,[r4,#0x0]	; 02328C3E
	mov r1,#0x2	; 02328C40
	orr r3,r1	; 02328C42
	str r3,[r4,#0x0]	; 02328C44
	add r1,r2,#0x0	; 02328C46
	add r1,#0x8	; 02328C48
	ldr r3,[r1,#0x4]	; 02328C4A
	add r3,r2,r3	; 02328C4C
	ldrh r3,[r3,#0x8]	; 02328C4E
	strh r3,[r0,#0x18]	; 02328C50
	add r4,r2,#0x0	; 02328C52
	add r4,#0xc	; 02328C54
	ldr r3,[r1,#0x4]	; 02328C56
	add r3,r4,r3	; 02328C58
	str r3,[r0,#0x4]	; 02328C5A
	ldr r3,[r1,#0x0]	; 02328C5C
	add r3,r2,r3	; 02328C5E
	ldrh r3,[r3,#0x8]	; 02328C60
	strh r3,[r0,#0x1a]	; 02328C62
	add r2,#0xa	; 02328C64
	ldr r1,[r1,#0x0]	; 02328C66
	add r1,r2,r1	; 02328C68
	str r1,[r0,#0x8]	; 02328C6A
	add sp,#0x4	; 02328C6C
	pop {r4}	; 02328C6E
	bx lr	; 02328C70
	.byte 0x00, 0x00	; 02328C74

; ===== function loc_02328C74 =====
loc_02328C74:
	push {r0,r1,r2,r3}	; 02328C74
	push {r4,lr}	; 02328C76
	add r2,sp,#0x8	; 02328C78
	mov r0,#0x0	; 02328C7A
	ldrsh r0,[r2,r0]	; 02328C7C
	lsl r0,r0,#0x14	; 02328C7E
	asr r4,r0,#0x14	; 02328C80
	ldrh r0,[r2,#0x0]	; 02328C82
	lsl r0,r0,#0x12	; 02328C84
	lsr r0,r0,#0x1e	; 02328C86
	cmp r0,#0x1	; 02328C88
	beq loc_02328C92	; 02328C8A
	cmp r0,#0x2	; 02328C8C
	beq loc_02328C9E	; 02328C8E
	b loc_02328CA0	; 02328C90
loc_02328C92:
	add r0,r1,#0x1	; 02328C92
	mov r1,#0x2	; 02328C94
	blx P1_SignedDivMod	; 02328C96
	sub r4,r4,r0	; 02328C9A
	b loc_02328CA0	; 02328C9C
loc_02328C9E:
	sub r4,r4,r1	; 02328C9E
loc_02328CA0:
	add r0,r4,#0x0	; 02328CA0
	pop {r4}	; 02328CA2
	pop {r3}	; 02328CA4
	add sp,#0x10	; 02328CA6
	bx r3	; 02328CA8
	.byte 0x00, 0x00	; 02328CAC

; ===== function loc_02328CAC =====
loc_02328CAC:
	push {r0,r1,r2,r3}	; 02328CAC
	push {r4,lr}	; 02328CAE
	add r2,sp,#0x8	; 02328CB0
	mov r0,#0x0	; 02328CB2
	ldrsh r0,[r2,r0]	; 02328CB4
	lsl r0,r0,#0x14	; 02328CB6
	asr r4,r0,#0x14	; 02328CB8
	ldrh r0,[r2,#0x0]	; 02328CBA
	lsl r0,r0,#0x12	; 02328CBC
	lsr r0,r0,#0x1e	; 02328CBE
	cmp r0,#0x1	; 02328CC0
	beq loc_02328CCA	; 02328CC2
	cmp r0,#0x2	; 02328CC4
	beq loc_02328CD6	; 02328CC6
	b loc_02328CD8	; 02328CC8
loc_02328CCA:
	add r0,r1,#0x1	; 02328CCA
	mov r1,#0x2	; 02328CCC
	blx P1_SignedDivMod	; 02328CCE
	sub r4,r4,r0	; 02328CD2
	b loc_02328CD8	; 02328CD4
loc_02328CD6:
	sub r4,r4,r1	; 02328CD6
loc_02328CD8:
	add r0,r4,#0x0	; 02328CD8
	pop {r4}	; 02328CDA
	pop {r3}	; 02328CDC
	add sp,#0x10	; 02328CDE
	bx r3	; 02328CE0
	.byte 0x00, 0x00	; 02328CE4

; ===== function loc_02328CE4 =====
loc_02328CE4:
	push {r4,r5,lr}	; 02328CE4
	sub sp,#0x14	; 02328CE6
	add r4,r0,#0x0	; 02328CE8
	add r3,r1,#0x0	; 02328CEA
	mov r0,#0x4	; 02328CEC
	ldrsb r0,[r3,r0]	; 02328CEE
	str r0,[sp,#0x0]	; 02328CF0
	mov r0,#0x5	; 02328CF2
	ldrsb r0,[r3,r0]	; 02328CF4
	str r0,[sp,#0x4]	; 02328CF6
	str r2,[sp,#0x8]	; 02328CF8
	ldrb r0,[r3,#0x6]	; 02328CFA
	str r0,[sp,#0xc]	; 02328CFC
	ldr r1,[r4,#0xc]	; 02328CFE
	ldrh r0,[r3,#0x6]	; 02328D00
	lsl r0,r0,#0x10	; 02328D02
	lsr r0,r0,#0x1c	; 02328D04
	lsl r0,r0,#0x5	; 02328D06
	add r0,r1,r0	; 02328D08
	add r1,r4,#0x0	; 02328D0A
	mov r4,sp	; 02328D0C
	sub r4,r4,#0x4	; 02328D0E
	ldrh r2,[r3,#0x0]	; 02328D10
	strh r2,[r4,#0x0]	; 02328D12
	add r5,r4,#0x0	; 02328D14
	ldmia r5!,{r2}	; 02328D16
	ldrh r3,[r3,#0x2]	; 02328D18
	strh r3,[r4,#0x0]	; 02328D1A
	ldmia r4!,{r3}	; 02328D1C
	bl loc_02328890	; 02328D1E
	add sp,#0x14	; 02328D22
	pop {r4,r5}	; 02328D24
	pop {r3}	; 02328D26
	bx r3	; 02328D28
	.byte 0x00, 0x00	; 02328D2C

; ===== function loc_02328D2C =====
loc_02328D2C:
	push {r4,r5,r6,r7,lr}	; 02328D2C
	sub sp,#0x4	; 02328D2E
	add r7,r0,#0x0	; 02328D30
	str r1,[sp,#0x0]	; 02328D32
	ldrh r6,[r1,#0x6]	; 02328D34
	lsl r4,r1,#0	; 02328D36
	add r4,#0x8	; 02328D38
	mov r5,#0x0	; 02328D3A
	cmp r6,#0x0	; 02328D3C
	ble loc_02328D5A	; 02328D3E
loc_02328D40:
	ldr r3,[r4,#0x8]	; 02328D40
	cmp r3,#0x0	; 02328D42
	beq loc_02328D52	; 02328D44
	add r0,r7,#0x0	; 02328D46
	add r1,r4,#0x0	; 02328D48
	ldr r2,[sp,#0x0]	; 02328D4A
	add r2,r2,r3	; 02328D4C
	bl loc_02328CE4	; 02328D4E
loc_02328D52:
	add r4,#0xc	; 02328D52
	add r5,r5,#0x1	; 02328D54
	cmp r5,r6	; 02328D56
	blt loc_02328D40	; 02328D58
loc_02328D5A:
	add sp,#0x4	; 02328D5A
	pop {r4,r5,r6,r7}	; 02328D5C
	pop {r3}	; 02328D5E
	bx r3	; 02328D60
	.byte 0x00, 0x00	; 02328D64

; ===== function loc_02328D64 =====
loc_02328D64:
	ldrh r2,[r0,#0x6]	; 02328D64
	add r0,#0x8	; 02328D66
	cmp r1,#0x0	; 02328D68
	blt loc_02328D70	; 02328D6A
	cmp r1,r2	; 02328D6C
	blt loc_02328D74	; 02328D6E
loc_02328D70:
	mov r0,#0x0	; 02328D70
	bx lr	; 02328D72
loc_02328D74:
	mov r2,#0xc	; 02328D74
	mul r1,r2	; 02328D76
	add r0,r0,r1	; 02328D78
	bx lr	; 02328D7A

; ===== function loc_02328D7C =====
loc_02328D7C:
	ldr r2,[r0,#0x8]	; 02328D7C
	add r2,r0,r2	; 02328D7E
	mov r0,#0x6	; 02328D80
	mul r1,r0	; 02328D82
	add r0,r2,r1	; 02328D84
	bx lr	; 02328D86

; ===== function loc_02328D88 =====
loc_02328D88:
	ldr r0,[r0,#0x14]	; 02328D88
	bx lr	; 02328D8A

; ===== function loc_02328D8C =====
loc_02328D8C:
	ldr r1,[r0,#0x10]	; 02328D8C
	add r0,r0,r1	; 02328D8E
	bx lr	; 02328D90
	.byte 0x00, 0x00	; 02328D94

; ===== function loc_02328D94 =====
loc_02328D94:
	ldr r2,[r0,#0xc]	; 02328D94
	add r2,r0,r2	; 02328D96
	ldr r3,[r0,#0x8]	; 02328D98
	add r3,r0,r3	; 02328D9A
	mov r0,#0x6	; 02328D9C
	mul r1,r0	; 02328D9E
	add r0,r3,r1	; 02328DA0
	ldrh r1,[r0,#0x2]	; 02328DA2
	mov r0,#0xc	; 02328DA4
	mul r1,r0	; 02328DA6
	add r0,r2,r1	; 02328DA8
	bx lr	; 02328DAA

; ===== function loc_02328DAC =====
loc_02328DAC:
	ldr r2,[r0,#0x8]	; 02328DAC
	add r2,r0,r2	; 02328DAE
	mov r0,#0x6	; 02328DB0
	mul r1,r0	; 02328DB2
	add r0,r2,r1	; 02328DB4
	ldrh r0,[r0,#0x4]	; 02328DB6
	bx lr	; 02328DB8
	.byte 0x00, 0x00	; 02328DBC

; ===== function loc_02328DBC =====
loc_02328DBC:
	push {r4,r5,r6,r7,lr}	; 02328DBC
	sub sp,#0xc	; 02328DBE
	str r0,[sp,#0x0]	; 02328DC0
	add r7,r1,#0x0	; 02328DC2
	str r2,[sp,#0x4]	; 02328DC4
	lsl r4,r0,#0	; 02328DC6
	add r4,#0x8	; 02328DC8
	mov r5,#0x0	; 02328DCA
	bl loc_02328E68	; 02328DCC
	cmp r0,#0x0	; 02328DD0
	ble loc_02328E2A	; 02328DD2
loc_02328DD4:
	mov r1,sp	; 02328DD4
	sub r1,r1,#0x4	; 02328DD6
	ldrh r0,[r4,#0x0]	; 02328DD8
	strh r0,[r1,#0x0]	; 02328DDA
	ldmia r1!,{r0}	; 02328DDC
	ldrb r1,[r4,#0x4]	; 02328DDE
	bl loc_02328CAC	; 02328DE0
	add r6,r0,#0x0	; 02328DE4
	mov r1,sp	; 02328DE6
	sub r1,r1,#0x4	; 02328DE8
	ldrh r0,[r4,#0x2]	; 02328DEA
	strh r0,[r1,#0x0]	; 02328DEC
	ldmia r1!,{r0}	; 02328DEE
	ldrb r1,[r4,#0x5]	; 02328DF0
	bl loc_02328C74	; 02328DF2
	ldrb r1,[r4,#0x4]	; 02328DF6
	add r2,r6,r1	; 02328DF8
	ldrb r1,[r4,#0x5]	; 02328DFA
	add r1,r0,r1	; 02328DFC
	cmp r6,r7	; 02328DFE
	bgt loc_02328E1C	; 02328E00
	cmp r7,r2	; 02328E02
	bgt loc_02328E1C	; 02328E04
	ldr r2,[sp,#0x4]	; 02328E06
	cmp r0,r2	; 02328E08
	bgt loc_02328E1C	; 02328E0A
	lsl r0,r2,#0	; 02328E0C
	cmp r0,r1	; 02328E0E
	bgt loc_02328E1C	; 02328E10
	add r0,r5,#0x0	; 02328E12
	add sp,#0xc	; 02328E14
	pop {r4,r5,r6,r7}	; 02328E16
	pop {r3}	; 02328E18
	bx r3	; 02328E1A
loc_02328E1C:
	add r5,r5,#0x1	; 02328E1C
	add r4,r4,#0x6	; 02328E1E
	ldr r0,[sp,#0x0]	; 02328E20
	bl loc_02328E68	; 02328E22
	cmp r5,r0	; 02328E26
	blt loc_02328DD4	; 02328E28
loc_02328E2A:
	mov r0,#0x0	; 02328E2A
	mvn r0,r0	; 02328E2C
	add sp,#0xc	; 02328E2E
	pop {r4,r5,r6,r7}	; 02328E30
	pop {r3}	; 02328E32
	bx r3	; 02328E34
	.byte 0x00, 0x00	; 02328E38

; ===== function loc_02328E38 =====
loc_02328E38:
	push {r4,r5,lr}	; 02328E38
	sub sp,#0x4	; 02328E3A
	add r5,r1,#0x0	; 02328E3C
	add r4,r0,#0x0	; 02328E3E
	add r4,#0x8	; 02328E40
	cmp r5,#0x0	; 02328E42
	blt loc_02328E4E	; 02328E44
	bl loc_02328E68	; 02328E46
	cmp r5,r0	; 02328E4A
	blt loc_02328E58	; 02328E4C
loc_02328E4E:
	mov r0,#0x0	; 02328E4E
	add sp,#0x4	; 02328E50
	pop {r4,r5}	; 02328E52
	pop {r3}	; 02328E54
	bx r3	; 02328E56
loc_02328E58:
	mov r0,#0x6	; 02328E58
	mul r5,r0	; 02328E5A
	add r0,r4,r5	; 02328E5C
	add sp,#0x4	; 02328E5E
	pop {r4,r5}	; 02328E60
	pop {r3}	; 02328E62
	bx r3	; 02328E64
	.byte 0x00, 0x00	; 02328E68

; ===== function loc_02328E68 =====
loc_02328E68:
	ldrh r0,[r0,#0x6]	; 02328E68
	bx lr	; 02328E6A

; ===== function loc_02328E6C =====
loc_02328E6C:
	push {r4,r5,r6,r7,lr}	; 02328E6C
	sub sp,#0x14	; 02328E6E
	str r0,[sp,#0x0]	; 02328E70
	str r1,[sp,#0x4]	; 02328E72
	str r2,[sp,#0x8]	; 02328E74
	str r3,[sp,#0xc]	; 02328E76
	lsl r0,r2,#0	; 02328E78
	lsr r6,r0,#0x1	; 02328E7A
	mov r5,#0x0	; 02328E7C
	add r4,sp,#0x10	; 02328E7E
	ldr r1,[pool_02328FAC]	; 02328E80
	ldr r7,[pool_02328FB0]	; 02328E82
loc_02328E84:
	add r0,r5,r6	; 02328E84
	sub r0,r0,#0x2	; 02328E86
	lsl r3,r0,#0x1	; 02328E88
	ldr r0,[sp,#0x0]	; 02328E8A
	ldrsh r2,[r0,r3]	; 02328E8C
	ldr r0,[sp,#0x4]	; 02328E8E
	ldrsh r0,[r0,r3]	; 02328E90
	sub r0,r2,r0	; 02328E92
	cmp r0,r1	; 02328E94
	bge loc_02328E9C	; 02328E96
	add r0,r1,#0x0	; 02328E98
	b loc_02328EA2	; 02328E9A
loc_02328E9C:
	cmp r0,r7	; 02328E9C
	blt loc_02328EA2	; 02328E9E
	ldr r0,[pool_02328FB4]	; 02328EA0
loc_02328EA2:
	strh r0,[r4,#0x0]	; 02328EA2
	add r4,r4,#0x2	; 02328EA4
	add r5,r5,#0x1	; 02328EA6
	cmp r5,#0x2	; 02328EA8
	blt loc_02328E84	; 02328EAA
	sub r0,r6,#0x1	; 02328EAC
	cmp r0,#0x2	; 02328EAE
	blt loc_02328F2A	; 02328EB0
	lsl r3,r0,#0x1	; 02328EB2
	ldr r1,[sp,#0x0]	; 02328EB4
	add r2,r1,r3	; 02328EB6
	ldr r1,[sp,#0x4]	; 02328EB8
	add r1,r1,r3	; 02328EBA
	ldr r7,[pool_02328FAC]	; 02328EBC
	mov r4,#0x0	; 02328EBE
loc_02328EC0:
	sub r3,r0,#0x2	; 02328EC0
	lsl r6,r3,#0x1	; 02328EC2
	ldr r3,[sp,#0x0]	; 02328EC4
	ldrsh r5,[r3,r6]	; 02328EC6
	ldr r3,[sp,#0x4]	; 02328EC8
	ldrsh r3,[r3,r6]	; 02328ECA
	sub r6,r5,r3	; 02328ECC
	cmp r6,#0x0	; 02328ECE
	blt loc_02328EFA	; 02328ED0
	ldrsh r3,[r2,r4]	; 02328ED2
	add r5,r6,r3	; 02328ED4
	ldr r3,[pool_02328FB0]	; 02328ED6
	cmp r5,r3	; 02328ED8
	bge loc_02328EE2	; 02328EDA
	lsl r3,r5,#0x10	; 02328EDC
	asr r3,r3,#0x10	; 02328EDE
	b loc_02328EE4	; 02328EE0
loc_02328EE2:
	ldr r3,[pool_02328FB4]	; 02328EE2
loc_02328EE4:
	strh r3,[r2,#0x0]	; 02328EE4
	ldrsh r3,[r1,r4]	; 02328EE6
	sub r3,r3,r6	; 02328EE8
	cmp r3,r7	; 02328EEA
	blt loc_02328EF4	; 02328EEC
	lsl r3,r3,#0x10	; 02328EEE
	asr r3,r3,#0x10	; 02328EF0
	b loc_02328EF6	; 02328EF2
loc_02328EF4:
	add r3,r7,#0x0	; 02328EF4
loc_02328EF6:
	strh r3,[r1,#0x0]	; 02328EF6
	b loc_02328F20	; 02328EF8
loc_02328EFA:
	ldrsh r3,[r2,r4]	; 02328EFA
	add r3,r6,r3	; 02328EFC
	cmp r3,r7	; 02328EFE
	blt loc_02328F08	; 02328F00
	lsl r3,r3,#0x10	; 02328F02
	asr r3,r3,#0x10	; 02328F04
	b loc_02328F0A	; 02328F06
loc_02328F08:
	add r3,r7,#0x0	; 02328F08
loc_02328F0A:
	strh r3,[r2,#0x0]	; 02328F0A
	ldrsh r3,[r1,r4]	; 02328F0C
	sub r5,r3,r6	; 02328F0E
	ldr r3,[pool_02328FB0]	; 02328F10
	cmp r5,r3	; 02328F12
	bge loc_02328F1C	; 02328F14
	lsl r3,r5,#0x10	; 02328F16
	asr r3,r3,#0x10	; 02328F18
	b loc_02328F1E	; 02328F1A
loc_02328F1C:
	ldr r3,[pool_02328FB4]	; 02328F1C
loc_02328F1E:
	strh r3,[r1,#0x0]	; 02328F1E
loc_02328F20:
	sub r2,r2,#0x2	; 02328F20
	sub r1,r1,#0x2	; 02328F22
	sub r0,r0,#0x1	; 02328F24
	cmp r0,#0x2	; 02328F26
	bge loc_02328EC0	; 02328F28
loc_02328F2A:
	mov r1,#0x1	; 02328F2A
	ldr r0,[sp,#0xc]	; 02328F2C
	add r4,r0,#0x4	; 02328F2E
	ldr r0,[sp,#0x0]	; 02328F30
	add r3,r0,#0x2	; 02328F32
	ldr r0,[sp,#0x4]	; 02328F34
	add r2,r0,#0x2	; 02328F36
	ldr r0,[pool_02328FAC]	; 02328F38
loc_02328F3A:
	mov r5,#0x0	; 02328F3A
	ldrsh r6,[r3,r5]	; 02328F3C
	ldr r5,[r4,#0xc]	; 02328F3E
	add r6,r6,r5	; 02328F40
	cmp r6,r0	; 02328F42
	bge loc_02328F4A	; 02328F44
	add r6,r0,#0x0	; 02328F46
	b loc_02328F52	; 02328F48
loc_02328F4A:
	ldr r5,[pool_02328FB0]	; 02328F4A
	cmp r6,r5	; 02328F4C
	blt loc_02328F52	; 02328F4E
	ldr r6,[pool_02328FB4]	; 02328F50
loc_02328F52:
	strh r6,[r3,#0x0]	; 02328F52
	mov r5,#0x0	; 02328F54
	ldrsh r6,[r2,r5]	; 02328F56
	ldr r5,[r4,#0xc]	; 02328F58
	sub r6,r6,r5	; 02328F5A
	cmp r6,r0	; 02328F5C
	bge loc_02328F64	; 02328F5E
	add r6,r0,#0x0	; 02328F60
	b loc_02328F6C	; 02328F62
loc_02328F64:
	ldr r5,[pool_02328FB0]	; 02328F64
	cmp r6,r5	; 02328F66
	blt loc_02328F6C	; 02328F68
	ldr r6,[pool_02328FB4]	; 02328F6A
loc_02328F6C:
	strh r6,[r2,#0x0]	; 02328F6C
	sub r4,r4,#0x4	; 02328F6E
	sub r3,r3,#0x2	; 02328F70
	sub r2,r2,#0x2	; 02328F72
	sub r1,r1,#0x1	; 02328F74
	cmp r1,#0x0	; 02328F76
	bge loc_02328F3A	; 02328F78
	mov r3,#0x0	; 02328F7A
	add r4,sp,#0x10	; 02328F7C
	add r1,r3,#0x0	; 02328F7E
loc_02328F80:
	ldrsh r2,[r4,r1]	; 02328F80
	ldr r0,[sp,#0xc]	; 02328F82
	str r2,[r0,#0xc]	; 02328F84
	add r4,r4,#0x2	; 02328F86
	add r0,r0,#0x4	; 02328F88
	str r0,[sp,#0xc]	; 02328F8A
	add r3,r3,#0x1	; 02328F8C
	cmp r3,#0x2	; 02328F8E
	blt loc_02328F80	; 02328F90
	ldr r0,[sp,#0x0]	; 02328F92
	ldr r1,[sp,#0x8]	; 02328F94
	blx P1_CleanAndInvalidateDataCacheRange	; 02328F96
	ldr r0,[sp,#0x4]	; 02328F9A
	ldr r1,[sp,#0x8]	; 02328F9C
	blx P1_CleanAndInvalidateDataCacheRange	; 02328F9E
	add sp,#0x14	; 02328FA2
	pop {r4,r5,r6,r7}	; 02328FA4
	pop {r3}	; 02328FA6
	bx r3	; 02328FA8
	.byte 0xC0, 0x46	; 02328FAC
pool_02328FAC:
loc_02328FAC:
	.word 0xFFFF8000	; 02328FAC
pool_02328FB0:
loc_02328FB0:
	.word 0x00008000	; 02328FB0
pool_02328FB4:
loc_02328FB4:
	.word 0x00007FFF	; 02328FB4

; ===== function loc_02328FB8 =====
	push {r4,r5,r6,r7,lr}	; 02328FB8
	sub sp,#0xc	; 02328FBA
	add r7,r0,#0x0	; 02328FBC
	str r1,[sp,#0x4]	; 02328FBE
	str r2,[sp,#0x8]	; 02328FC0
	ldr r4,[sp,#0x20]	; 02328FC2
	ldr r6,[r4,#0x4]	; 02328FC4
	cmp r6,#0x0	; 02328FC6
	beq loc_02328FD0	; 02328FC8
	ldr r5,[r4,#0x8]	; 02328FCA
	str r5,[sp,#0x0]	; 02328FCC
	blx r6	; 02328FCE
loc_02328FD0:
	ldr r0,[r4,#0x0]	; 02328FD0
	cmp r0,#0x0	; 02328FD2
	beq loc_02328FE6	; 02328FD4
	cmp r0,#0x1	; 02328FD6
	bne loc_02328FE6	; 02328FD8
	add r0,r7,#0x0	; 02328FDA
	ldr r1,[sp,#0x4]	; 02328FDC
	ldr r2,[sp,#0x8]	; 02328FDE
	add r3,r4,#0x0	; 02328FE0
	bl loc_02328E6C	; 02328FE2
loc_02328FE6:
	add sp,#0xc	; 02328FE6
	pop {r4,r5,r6,r7}	; 02328FE8
	pop {r3}	; 02328FEA
	bx r3	; 02328FEC
	.byte 0x00, 0x00	; 02328FF0

; ===== function loc_02328FF0 =====
loc_02328FF0:
	push {lr}	; 02328FF0
	sub sp,#0x4	; 02328FF2
	ldr r0,[pool_0232900C]	; 02328FF4
	ldr r0,[r0,#0x0]	; 02328FF6
	cmp r0,#0x1	; 02328FF8
	bne loc_02329002	; 02328FFA
	mov r0,#0x0	; 02328FFC
	bl loc_0232E460	; 02328FFE
loc_02329002:
	bl loc_0232A438	; 02329002
	add sp,#0x4	; 02329006
	pop {r3}	; 02329008
	bx r3	; 0232900A
pool_0232900C:
loc_0232900C:
	.word P1_BssStart + 0x2593C	; 0232900C

; ===== function loc_02329010 =====
loc_02329010:
	push {r4,r5,r6,lr}	; 02329010
	sub sp,#0x10	; 02329012
	add r5,r0,#0x0	; 02329014
	add r6,r1,#0x0	; 02329016
	add r4,r2,#0x0	; 02329018
	mov r1,#0x0	; 0232901A
	add r0,sp,#0xc	; 0232901C
	strh r1,[r0,#0x0]	; 0232901E
	ldrh r0,[r0,#0x0]	; 02329020
	ldr r1,[pool_02329058]	; 02329022
	mov r2,#0xc0	; 02329024
	blx loc_0232E2EC	; 02329026
	ldr r0,[pool_0232905C]	; 0232902A
	str r4,[r0,#0x0]	; 0232902C
	cmp r4,#0x1	; 0232902E
	bne loc_02329038	; 02329030
	ldr r0,[pool_02329060]	; 02329032
	bl loc_0232E460	; 02329034
loc_02329038:
	mov r0,#0x2	; 02329038
	str r0,[sp,#0x0]	; 0232903A
	ldr r0,[pool_02329064]	; 0232903C
	str r0,[sp,#0x4]	; 0232903E
	ldr r0,[pool_0232905C]	; 02329040
	str r0,[sp,#0x8]	; 02329042
	add r0,r5,#0x0	; 02329044
	add r1,r6,#0x0	; 02329046
	mov r2,#0x0	; 02329048
	ldr r3,[pool_02329068]	; 0232904A
	bl loc_0232A458	; 0232904C
	add sp,#0x10	; 02329050
	pop {r4,r5,r6}	; 02329052
	pop {r3}	; 02329054
	bx r3	; 02329056
pool_02329058:
loc_02329058:
	.word 0x023567C8	; 02329058
pool_0232905C:
loc_0232905C:
	.word P1_BssStart + 0x2593C	; 0232905C
pool_02329060:
loc_02329060:
	.word 0x00003000	; 02329060
pool_02329064:
loc_02329064:
	.word 0x02328FB9	; 02329064
pool_02329068:
loc_02329068:
	.word 0x00007D00	; 02329068

; ===== function loc_0232906C =====
loc_0232906C:
	mov r0,#0x1	; 0232906C
	ldr r3,[pool_02329074]	; 0232906E
	bx r3	; 02329070
	.byte 0xC0, 0x46	; 02329074
pool_02329074:
loc_02329074:
	.word loc_0232C368 + 1	; 02329074

; ===== function loc_02329078 =====
loc_02329078:
	push {r4,r5,lr}	; 02329078
	sub sp,#0x4	; 0232907A
	add r5,r0,#0x0	; 0232907C
	bl loc_0232906C	; 0232907E
	cmp r0,#0x0	; 02329082
	bne loc_02329092	; 02329084
	mov r0,#0x2	; 02329086
	mvn r0,r0	; 02329088
	add sp,#0x4	; 0232908A
	pop {r4,r5}	; 0232908C
	pop {r3}	; 0232908E
	bx r3	; 02329090
loc_02329092:
	bl loc_02329130	; 02329092
	add r4,r0,#0x0	; 02329096
	mov r0,#0x0	; 02329098
	mvn r0,r0	; 0232909A
	cmp r4,r0	; 0232909C
	beq loc_023290BA	; 0232909E
	add r0,r5,#0x0	; 023290A0
	bl loc_023290EC	; 023290A2
	lsl r0,r4,#0x10	; 023290A6
	lsr r0,r0,#0x10	; 023290A8
	bl loc_0232910C	; 023290AA
	mov r1,#0x1	; 023290AE
	mvn r1,r1	; 023290B0
	cmp r0,r1	; 023290B2
	beq loc_023290B8	; 023290B4
	mov r1,#0x0	; 023290B6
loc_023290B8:
	add r0,r1,#0x0	; 023290B8
loc_023290BA:
	add sp,#0x4	; 023290BA
	pop {r4,r5}	; 023290BC
	pop {r3}	; 023290BE
	bx r3	; 023290C0
	.byte 0x00, 0x00	; 023290C4

; ===== function loc_023290C4 =====
loc_023290C4:
	push {lr}	; 023290C4
	sub sp,#0x4	; 023290C6
	mov r3,#0x0	; 023290C8
	ldr r2,[pool_023290E8]	; 023290CA
	add r0,r3,#0x0	; 023290CC
loc_023290CE:
	ldrsb r1,[r2,r0]	; 023290CE
	add r2,r2,#0x1	; 023290D0
	add r3,r3,#0x1	; 023290D2
	cmp r3,#0x13	; 023290D4
	bcc loc_023290CE	; 023290D6
	bl loc_0232C3B8	; 023290D8
	mov r0,#0x1	; 023290DC
	bl loc_0232C338	; 023290DE
	add sp,#0x4	; 023290E2
	pop {r3}	; 023290E4
	bx r3	; 023290E6
pool_023290E8:
loc_023290E8:
	.word P1_VibBuildIdentifier	; 023290E8

; ===== function loc_023290EC =====
loc_023290EC:
	push {r4,lr}	; 023290EC
	add r4,r0,#0x0	; 023290EE
	bl loc_0232906C	; 023290F0
	cmp r0,#0x1	; 023290F4
	bne loc_02329100	; 023290F6
	mov r0,#0x1	; 023290F8
	and r4,r0	; 023290FA
	ldr r0,[pool_02329108]	; 023290FC
	strh r4,[r0,#0x0]	; 023290FE
loc_02329100:
	pop {r4}	; 02329100
	pop {r3}	; 02329102
	bx r3	; 02329104
	.byte 0xC0, 0x46	; 02329108
pool_02329108:
loc_02329108:
	.word 0x08000004	; 02329108

; ===== function loc_0232910C =====
loc_0232910C:
	push {r4,r5,lr}	; 0232910C
	sub sp,#0x4	; 0232910E
	add r5,r0,#0x0	; 02329110
	bl loc_0232AF8C	; 02329112
	add r4,r0,#0x0	; 02329116
	add r0,r5,#0x0	; 02329118
	blx loc_0232AEA8	; 0232911A
	mov r0,#0x1	; 0232911E
	mvn r0,r0	; 02329120
	cmp r4,r0	; 02329122
	beq loc_02329128	; 02329124
	mov r0,#0x0	; 02329126
loc_02329128:
	add sp,#0x4	; 02329128
	pop {r4,r5}	; 0232912A
	pop {r3}	; 0232912C
	bx r3	; 0232912E

; ===== function loc_02329130 =====
loc_02329130:
	push {r4,lr}	; 02329130
	blx loc_0232AE50	; 02329132
	add r4,r0,#0x0	; 02329136
	mov r0,#0x2	; 02329138
	mvn r0,r0	; 0232913A
	cmp r4,r0	; 0232913C
	bne loc_0232914A	; 0232913E
	mov r0,#0x0	; 02329140
	mvn r0,r0	; 02329142
	pop {r4}	; 02329144
	pop {r3}	; 02329146
	bx r3	; 02329148
loc_0232914A:
	lsl r0,r4,#0x10	; 0232914A
	lsr r0,r0,#0x10	; 0232914C
	bl loc_0232AFA8	; 0232914E
	add r0,r4,#0x0	; 02329152
	pop {r4}	; 02329154
	pop {r3}	; 02329156
	bx r3	; 02329158
	.byte 0x00, 0x00	; 0232915C

; ===== function loc_0232915C =====
loc_0232915C:
	cmp r1,#0x0	; 0232915C
	bne loc_02329164	; 0232915E
	ldr r0,[r0,#0x4]	; 02329160
	bx lr	; 02329162
loc_02329164:
	ldrh r0,[r0,#0xa]	; 02329164
	ldr r0,[r1,r0]	; 02329166
	bx lr	; 02329168
	.byte 0x00, 0x00	; 0232916C

; ===== function loc_0232916C =====
loc_0232916C:
	cmp r1,#0x0	; 0232916C
	bne loc_02329174	; 0232916E
	ldr r0,[r0,#0x0]	; 02329170
	bx lr	; 02329172
loc_02329174:
	ldrh r0,[r0,#0xa]	; 02329174
	add r0,r1,r0	; 02329176
	ldr r0,[r0,#0x4]	; 02329178
	bx lr	; 0232917A

; ===== function loc_0232917C =====
loc_0232917C:
	push {r4}	; 0232917C
	sub sp,#0x4	; 0232917E
	ldrh r4,[r0,#0xa]	; 02329180
	add r2,r1,r4	; 02329182
	ldr r1,[r1,r4]	; 02329184
	cmp r1,#0x0	; 02329186
	bne loc_02329190	; 02329188
	ldr r1,[r2,#0x4]	; 0232918A
	str r1,[r0,#0x0]	; 0232918C
	b loc_02329196	; 0232918E
loc_02329190:
	ldr r3,[r2,#0x4]	; 02329190
	add r1,r1,r4	; 02329192
	str r3,[r1,#0x4]	; 02329194
loc_02329196:
	ldr r4,[r2,#0x4]	; 02329196
	cmp r4,#0x0	; 02329198
	bne loc_023291A2	; 0232919A
	ldr r1,[r2,#0x0]	; 0232919C
	str r1,[r0,#0x4]	; 0232919E
	b loc_023291A8	; 023291A0
loc_023291A2:
	ldr r3,[r2,#0x0]	; 023291A2
	ldrh r1,[r0,#0xa]	; 023291A4
	str r3,[r4,r1]	; 023291A6
loc_023291A8:
	mov r1,#0x0	; 023291A8
	str r1,[r2,#0x0]	; 023291AA
	str r1,[r2,#0x4]	; 023291AC
	add r0,#0x8	; 023291AE
	ldrh r1,[r0,#0x0]	; 023291B0
	sub r1,r1,#0x1	; 023291B2
	strh r1,[r0,#0x0]	; 023291B4
	add sp,#0x4	; 023291B6
	pop {r4}	; 023291B8
	bx lr	; 023291BA

; ===== function loc_023291BC =====
loc_023291BC:
	push {r4,r5,lr}	; 023291BC
	sub sp,#0x4	; 023291BE
	cmp r1,#0x0	; 023291C0
	bne loc_023291D2	; 023291C2
	add r1,r2,#0x0	; 023291C4
	bl loc_0232923C	; 023291C6
	add sp,#0x4	; 023291CA
	pop {r4,r5}	; 023291CC
	pop {r3}	; 023291CE
	bx r3	; 023291D0
loc_023291D2:
	ldr r3,[r0,#0x0]	; 023291D2
	cmp r1,r3	; 023291D4
	bne loc_023291E6	; 023291D6
	add r1,r2,#0x0	; 023291D8
	bl loc_02329208	; 023291DA
	add sp,#0x4	; 023291DE
	pop {r4,r5}	; 023291E0
	pop {r3}	; 023291E2
	bx r3	; 023291E4
loc_023291E6:
	ldrh r5,[r0,#0xa]	; 023291E6
	add r4,r2,r5	; 023291E8
	ldr r3,[r1,r5]	; 023291EA
	str r3,[r2,r5]	; 023291EC
	str r1,[r4,#0x4]	; 023291EE
	add r3,r3,r5	; 023291F0
	str r2,[r3,#0x4]	; 023291F2
	ldrh r3,[r0,#0xa]	; 023291F4
	str r2,[r1,r3]	; 023291F6
	add r0,#0x8	; 023291F8
	ldrh r1,[r0,#0x0]	; 023291FA
	add r1,r1,#0x1	; 023291FC
	strh r1,[r0,#0x0]	; 023291FE
	add sp,#0x4	; 02329200
	pop {r4,r5}	; 02329202
	pop {r3}	; 02329204
	bx r3	; 02329206

; ===== function loc_02329208 =====
loc_02329208:
	push {r4,lr}	; 02329208
	ldr r2,[r0,#0x0]	; 0232920A
	cmp r2,#0x0	; 0232920C
	bne loc_0232921A	; 0232920E
	bl loc_02329274	; 02329210
	pop {r4}	; 02329214
	pop {r3}	; 02329216
	bx r3	; 02329218
loc_0232921A:
	ldrh r3,[r0,#0xa]	; 0232921A
	add r4,r1,r3	; 0232921C
	mov r2,#0x0	; 0232921E
	str r2,[r1,r3]	; 02329220
	ldr r2,[r0,#0x0]	; 02329222
	str r2,[r4,#0x4]	; 02329224
	ldr r3,[r0,#0x0]	; 02329226
	ldrh r2,[r0,#0xa]	; 02329228
	str r1,[r3,r2]	; 0232922A
	str r1,[r0,#0x0]	; 0232922C
	add r0,#0x8	; 0232922E
	ldrh r1,[r0,#0x0]	; 02329230
	add r1,r1,#0x1	; 02329232
	strh r1,[r0,#0x0]	; 02329234
	pop {r4}	; 02329236
	pop {r3}	; 02329238
	bx r3	; 0232923A

; ===== function loc_0232923C =====
loc_0232923C:
	push {r4,lr}	; 0232923C
	ldr r2,[r0,#0x0]	; 0232923E
	cmp r2,#0x0	; 02329240
	bne loc_0232924E	; 02329242
	bl loc_02329274	; 02329244
	pop {r4}	; 02329248
	pop {r3}	; 0232924A
	bx r3	; 0232924C
loc_0232924E:
	ldrh r3,[r0,#0xa]	; 0232924E
	add r4,r1,r3	; 02329250
	ldr r2,[r0,#0x4]	; 02329252
	str r2,[r1,r3]	; 02329254
	mov r2,#0x0	; 02329256
	str r2,[r4,#0x4]	; 02329258
	ldr r3,[r0,#0x4]	; 0232925A
	ldrh r2,[r0,#0xa]	; 0232925C
	add r2,r3,r2	; 0232925E
	str r1,[r2,#0x4]	; 02329260
	str r1,[r0,#0x4]	; 02329262
	add r0,#0x8	; 02329264
	ldrh r1,[r0,#0x0]	; 02329266
	add r1,r1,#0x1	; 02329268
	strh r1,[r0,#0x0]	; 0232926A
	pop {r4}	; 0232926C
	pop {r3}	; 0232926E
	bx r3	; 02329270
	.byte 0x00, 0x00	; 02329274

; ===== function loc_02329274 =====
loc_02329274:
	push {r4}	; 02329274
	sub sp,#0x4	; 02329276
	ldrh r3,[r0,#0xa]	; 02329278
	add r4,r1,r3	; 0232927A
	mov r2,#0x0	; 0232927C
	str r2,[r4,#0x4]	; 0232927E
	str r2,[r1,r3]	; 02329280
	str r1,[r0,#0x0]	; 02329282
	str r1,[r0,#0x4]	; 02329284
	add r0,#0x8	; 02329286
	ldrh r1,[r0,#0x0]	; 02329288
	add r1,r1,#0x1	; 0232928A
	strh r1,[r0,#0x0]	; 0232928C
	add sp,#0x4	; 0232928E
	pop {r4}	; 02329290
	bx lr	; 02329292

; ===== function loc_02329294 =====
loc_02329294:
	mov r2,#0x0	; 02329294
	str r2,[r0,#0x0]	; 02329296
	str r2,[r0,#0x4]	; 02329298
	strh r2,[r0,#0x8]	; 0232929A
	strh r1,[r0,#0xa]	; 0232929C
	bx lr	; 0232929E

; ===== function loc_023292A0 =====
loc_023292A0:
	push {r4,lr}	; 023292A0
	add r4,r0,#0x0	; 023292A2
	bl loc_0232931C	; 023292A4
	add r1,r4,#0x0	; 023292A8
	bl loc_0232917C	; 023292AA
	pop {r4}	; 023292AE
	pop {r3}	; 023292B0
	bx r3	; 023292B2

; ===== function loc_023292B4 =====
loc_023292B4:
	push {r4,lr}	; 023292B4
	add r4,r0,#0x0	; 023292B6
	str r1,[r4,#0x0]	; 023292B8
	str r2,[r4,#0x18]	; 023292BA
	str r3,[r4,#0x1c]	; 023292BC
	mov r0,#0x0	; 023292BE
	str r0,[r4,#0x20]	; 023292C0
	add r3,r4,#0x0	; 023292C2
	add r3,#0x20	; 023292C4
	ldr r1,[r3,#0x0]	; 023292C6
	mov r0,#0xff	; 023292C8
	bic r1,r0	; 023292CA
	str r1,[r3,#0x0]	; 023292CC
	ldr r2,[r3,#0x0]	; 023292CE
	ldr r1,[pool_02329310]	; 023292D0
	add r1,sp	; 023292D2
	ldrh r1,[r1,#0x10]	; 023292D4
	and r1,r0	; 023292D6
	orr r2,r1	; 023292D8
	str r2,[r3,#0x0]	; 023292DA
	add r0,r4,#0x0	; 023292DC
	add r0,#0xc	; 023292DE
	mov r1,#0x4	; 023292E0
	bl loc_02329294	; 023292E2
	ldr r0,[pool_02329314]	; 023292E6
	ldr r0,[r0,#0x0]	; 023292E8
	cmp r0,#0x0	; 023292EA
	bne loc_023292FC	; 023292EC
	ldr r0,[pool_02329318]	; 023292EE
	mov r1,#0x4	; 023292F0
	bl loc_02329294	; 023292F2
	mov r1,#0x1	; 023292F6
	ldr r0,[pool_02329314]	; 023292F8
	str r1,[r0,#0x0]	; 023292FA
loc_023292FC:
	add r0,r4,#0x0	; 023292FC
	bl loc_0232931C	; 023292FE
	add r1,r4,#0x0	; 02329302
	bl loc_0232923C	; 02329304
	pop {r4}	; 02329308
	pop {r3}	; 0232930A
	bx r3	; 0232930C
	.byte 0xC0, 0x46	; 02329310
pool_02329310:
loc_02329310:
	.word 0xFFFFFFF8	; 02329310
pool_02329314:
loc_02329314:
	.word P1_BssStart + 0x25A08	; 02329314
pool_02329318:
loc_02329318:
	.word 0x0235688C	; 02329318

; ===== function loc_0232931C =====
loc_0232931C:
	push {r4,lr}	; 0232931C
	add r1,r0,#0x0	; 0232931E
	ldr r4,[pool_02329338]	; 02329320
	add r0,r4,#0x0	; 02329322
	bl loc_0232933C	; 02329324
	cmp r0,#0x0	; 02329328
	beq loc_02329330	; 0232932A
	add r4,r0,#0x0	; 0232932C
	add r4,#0xc	; 0232932E
loc_02329330:
	add r0,r4,#0x0	; 02329330
	pop {r4}	; 02329332
	pop {r3}	; 02329334
	bx r3	; 02329336
pool_02329338:
loc_02329338:
	.word 0x0235688C	; 02329338

; ===== function loc_0232933C =====
loc_0232933C:
	push {r4,r5,r6,lr}	; 0232933C
	add r6,r0,#0x0	; 0232933E
	add r5,r1,#0x0	; 02329340
	mov r1,#0x0	; 02329342
	bl loc_0232916C	; 02329344
	add r4,r0,#0x0	; 02329348
	cmp r4,#0x0	; 0232934A
	beq loc_0232937E	; 0232934C
loc_0232934E:
	ldr r0,[r4,#0x18]	; 0232934E
	cmp r0,r5	; 02329350
	bhi loc_02329370	; 02329352
	ldr r0,[r4,#0x1c]	; 02329354
	cmp r5,r0	; 02329356
	bcs loc_02329370	; 02329358
	add r0,r4,#0x0	; 0232935A
	add r0,#0xc	; 0232935C
	add r1,r5,#0x0	; 0232935E
	bl loc_0232933C	; 02329360
	cmp r0,#0x0	; 02329364
	bne loc_02329380	; 02329366
	add r0,r4,#0x0	; 02329368
	pop {r4,r5,r6}	; 0232936A
	pop {r3}	; 0232936C
	bx r3	; 0232936E
loc_02329370:
	add r0,r6,#0x0	; 02329370
	add r1,r4,#0x0	; 02329372
	bl loc_0232916C	; 02329374
	add r4,r0,#0x0	; 02329378
	cmp r4,#0x0	; 0232937A
	bne loc_0232934E	; 0232937C
loc_0232937E:
	mov r0,#0x0	; 0232937E
loc_02329380:
	pop {r4,r5,r6}	; 02329380
	pop {r3}	; 02329382
	bx r3	; 02329384
	.byte 0x00, 0x00, 0x30, 0xB5, 0x83, 0xB0, 0x05, 0x1C, 0x24, 0x35, 0x0C, 0x1C, 0x10, 0x3C, 0x00, 0xA8	; 02329396
	.byte 0x21, 0x1C, 0x00, 0xF0, 0xEA, 0xF9, 0x28, 0x1C, 0x08, 0x30, 0x21, 0x1C, 0x00, 0xF0, 0xD7, 0xF9	; 023293A6
	.byte 0x28, 0x1C, 0x00, 0xA9, 0x00, 0xF0, 0x31, 0xF8, 0x03, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 023293B6
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x00, 0x29, 0x00, 0xD1, 0x01, 0x21, 0xC9, 0x1C, 0x03, 0x23	; 023293C6
	.byte 0x99, 0x43, 0x00, 0x2A, 0x04, 0xDB, 0x00, 0xF0, 0xAE, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47	; 023293D6
	.byte 0x52, 0x42, 0x00, 0xF0, 0x64, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0x00, 0xB5	; 023293E6
	.byte 0x81, 0xB0, 0x09, 0x18, 0x03, 0x23, 0x99, 0x43, 0xC0, 0x1C, 0x98, 0x43, 0x88, 0x42, 0x02, 0xD8	; 023293F6
	.byte 0x0B, 0x1A, 0x4C, 0x2B, 0x03, 0xD2, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0xF0	; 02329406
	.byte 0x5C, 0xF9, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0x70, 0xB5, 0x82, 0xB0, 0x06, 0x1C	; 02329416
	.byte 0x0D, 0x1C, 0x00, 0x24, 0x29, 0x68, 0x68, 0x68, 0x00, 0x91, 0x01, 0x90, 0x31, 0x68, 0x00, 0x29	; 02329426
	.byte 0x13, 0xD0, 0x28, 0x68, 0x81, 0x42, 0x01, 0xD2, 0x0C, 0x1C, 0x0B, 0xE0, 0x68, 0x68, 0x81, 0x42	; 02329436
	.byte 0x0B, 0xD1, 0x4A, 0x68, 0x08, 0x1C, 0x10, 0x30, 0x10, 0x18, 0x01, 0x90, 0x30, 0x1C, 0x00, 0xF0	; 02329446
	.byte 0x86, 0xF9, 0x02, 0xE0, 0xC9, 0x68, 0x00, 0x29, 0xEC, 0xD1, 0x00, 0x2C, 0x0C, 0xD0, 0x61, 0x68	; 02329456
	.byte 0x20, 0x1C, 0x10, 0x30, 0x09, 0x18, 0x28, 0x68, 0x81, 0x42, 0x05, 0xD1, 0x00, 0x94, 0x30, 0x1C	; 02329466
	.byte 0x21, 0x1C, 0x00, 0xF0, 0x74, 0xF9, 0x04, 0x1C, 0x01, 0x99, 0x00, 0x98, 0x08, 0x1A, 0x10, 0x28	; 02329476
	.byte 0x04, 0xD2, 0x00, 0x20, 0x02, 0xB0, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0xA8, 0x06, 0x49	; 02329486
	.byte 0x00, 0xF0, 0x47, 0xF9, 0x01, 0x1C, 0x30, 0x1C, 0x22, 0x1C, 0x00, 0xF0, 0x50, 0xF9, 0x01, 0x20	; 02329496
	.byte 0x02, 0xB0, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x52, 0x46, 0x00, 0x00, 0xF0, 0xB5	; 023294A6
	.byte 0x85, 0xB0, 0x0B, 0x1C, 0x03, 0x90, 0x24, 0x30, 0x03, 0x90, 0x40, 0x8A, 0x01, 0x27, 0x38, 0x40	; 023294B6
	.byte 0x00, 0x04, 0x00, 0x0C, 0x00, 0x28, 0x00, 0xD0, 0x00, 0x27, 0x00, 0x20, 0x01, 0x90, 0xC0, 0x43	; 023294C6
	.byte 0x01, 0x99, 0x02, 0x91, 0x03, 0x99, 0x49, 0x68, 0x00, 0x29, 0x18, 0xD0, 0x52, 0x1E, 0xD2, 0x43	; 023294D6
	.byte 0x04, 0x92, 0x0E, 0x1C, 0x10, 0x36, 0x4D, 0x68, 0xAA, 0x19, 0xD2, 0x1A, 0x04, 0x9C, 0x14, 0x40	; 023294E6
	.byte 0xA2, 0x1B, 0x00, 0x2A, 0x08, 0xDB, 0xA8, 0x42, 0x06, 0xD9, 0x01, 0x91, 0x28, 0x1C, 0x02, 0x94	; 023294F6
	.byte 0x00, 0x2F, 0x04, 0xD1, 0x9D, 0x42, 0x02, 0xD0, 0x89, 0x68, 0x00, 0x29, 0xE9, 0xD1, 0x01, 0x98	; 02329506
	.byte 0x00, 0x28, 0x0A, 0xD0, 0x01, 0x20, 0x00, 0x90, 0x03, 0x98, 0x01, 0x99, 0x02, 0x9A, 0x00, 0xF0	; 02329516
	.byte 0x4E, 0xF8, 0x05, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x20, 0x05, 0xB0, 0xF0, 0xBC	; 02329526
	.byte 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0xF0, 0xB5, 0x85, 0xB0, 0x0B, 0x1C, 0x03, 0x90, 0x24, 0x30	; 02329536
	.byte 0x03, 0x90, 0x40, 0x8A, 0x01, 0x27, 0x38, 0x40, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x28, 0x00, 0xD0	; 02329546
	.byte 0x00, 0x27, 0x00, 0x20, 0x01, 0x90, 0xC0, 0x43, 0x01, 0x99, 0x02, 0x91, 0x03, 0x99, 0x09, 0x68	; 02329556
	.byte 0x00, 0x29, 0x18, 0xD0, 0x56, 0x1E, 0xF2, 0x43, 0x04, 0x92, 0x0D, 0x1C, 0x10, 0x35, 0x72, 0x19	; 02329566
	.byte 0x04, 0x9C, 0x14, 0x40, 0x4A, 0x68, 0x65, 0x1B, 0x5D, 0x19, 0xAA, 0x42, 0x08, 0xD3, 0x90, 0x42	; 02329576
	.byte 0x06, 0xD9, 0x01, 0x91, 0x10, 0x1C, 0x02, 0x94, 0x00, 0x2F, 0x04, 0xD1, 0x9A, 0x42, 0x02, 0xD0	; 02329586
	.byte 0xC9, 0x68, 0x00, 0x29, 0xE9, 0xD1, 0x01, 0x98, 0x00, 0x28, 0x0A, 0xD0, 0x00, 0x20, 0x00, 0x90	; 02329596
	.byte 0x03, 0x98, 0x01, 0x99, 0x02, 0x9A, 0x00, 0xF0, 0x0A, 0xF8, 0x05, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 023295A6
	.byte 0x18, 0x47, 0x00, 0x20, 0x05, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0xF0, 0xB5	; 023295B6
	.byte 0x87, 0xB0, 0x05, 0x1C, 0x0F, 0x1C, 0x14, 0x1C, 0x1E, 0x1C, 0x00, 0xA8, 0x00, 0xF0, 0xD5, 0xF8	; 023295C6
	.byte 0x01, 0x98, 0x03, 0x90, 0x30, 0x19, 0x02, 0x90, 0x26, 0x1C, 0x10, 0x3E, 0x01, 0x96, 0x28, 0x1C	; 023295D6
	.byte 0x39, 0x1C, 0x00, 0xF0, 0xBC, 0xF8, 0x07, 0x1C, 0x00, 0x99, 0x01, 0x98, 0x40, 0x1A, 0x10, 0x28	; 023295E6
	.byte 0x01, 0xD2, 0x01, 0x91, 0x09, 0xE0, 0x00, 0xA8, 0x30, 0x49, 0x00, 0xF0, 0x92, 0xF8, 0x01, 0x1C	; 023295F6
	.byte 0x28, 0x1C, 0x3A, 0x1C, 0x00, 0xF0, 0x9B, 0xF8, 0x07, 0x1C, 0x03, 0x99, 0x02, 0x98, 0x08, 0x1A	; 02329606
	.byte 0x10, 0x28, 0x01, 0xD2, 0x02, 0x91, 0x08, 0xE0, 0x02, 0xA8, 0x27, 0x49, 0x00, 0xF0, 0x81, 0xF8	; 02329616
	.byte 0x01, 0x1C, 0x28, 0x1C, 0x3A, 0x1C, 0x00, 0xF0, 0x8A, 0xF8, 0x01, 0x99, 0x02, 0x98, 0x42, 0x1A	; 02329626
	.byte 0x28, 0x1F, 0x03, 0x68, 0xFF, 0x20, 0x03, 0x40, 0x18, 0x04, 0x03, 0x0C, 0x01, 0x20, 0x03, 0x40	; 02329636
	.byte 0x00, 0x2B, 0x04, 0xD0, 0x00, 0x20, 0x06, 0x90, 0x06, 0x98, 0x04, 0xF0, 0x6E, 0xEE, 0x04, 0x96	; 02329646
	.byte 0x02, 0x98, 0x05, 0x90, 0x04, 0xA8, 0x19, 0x49, 0x00, 0xF0, 0x63, 0xF8, 0x01, 0x1C, 0x88, 0x1C	; 02329656
	.byte 0x03, 0x88, 0x17, 0x4A, 0x13, 0x40, 0x03, 0x80, 0x02, 0x88, 0x08, 0xAB, 0x1E, 0x8A, 0x01, 0x23	; 02329666
	.byte 0x1E, 0x40, 0xF3, 0x03, 0x1A, 0x43, 0x02, 0x80, 0x01, 0x9A, 0x8B, 0x1A, 0x06, 0x88, 0x11, 0x4A	; 02329676
	.byte 0x16, 0x40, 0x06, 0x80, 0x02, 0x88, 0x1B, 0x04, 0x1E, 0x0C, 0x7F, 0x23, 0x1E, 0x40, 0x33, 0x02	; 02329686
	.byte 0x1A, 0x43, 0x02, 0x80, 0x2A, 0x8A, 0xFF, 0x23, 0x1A, 0x40, 0x06, 0x88, 0x9E, 0x43, 0x06, 0x80	; 02329696
	.byte 0x03, 0x88, 0x13, 0x43, 0x03, 0x80, 0x28, 0x1C, 0x08, 0x30, 0xEA, 0x68, 0x00, 0xF0, 0x47, 0xF8	; 023296A6
	.byte 0x20, 0x1C, 0x07, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x52, 0x46, 0x00, 0x00, 0x44, 0x55	; 023296B6
	.byte 0x00, 0x00, 0xFF, 0x7F, 0xFF, 0xFF, 0xFF, 0x80, 0xFF, 0xFF	; 023296C0

; ===== function loc_023296C0 =====
	push {r4,r5,lr}	; 023296C0
	sub sp,#0xc	; 023296C2
	add r5,r0,#0x0	; 023296C4
	add r3,r1,#0x0	; 023296C6
	add r4,r5,#0x0	; 023296C8
	add r4,#0x24	; 023296CA
	str r2,[sp,#0x0]	; 023296CC
	ldr r1,[pool_02329710]	; 023296CE
	add r2,r4,#0x0	; 023296D0
	add r2,#0x14	; 023296D2
	bl loc_023292B4	; 023296D4
	mov r0,#0x0	; 023296D8
	strh r0,[r4,#0x10]	; 023296DA
	strh r0,[r4,#0x12]	; 023296DC
	add r2,r4,#0x0	; 023296DE
	add r2,#0x12	; 023296E0
	ldrh r1,[r2,#0x0]	; 023296E2
	mov r0,#0x1	; 023296E4
	bic r1,r0	; 023296E6
	strh r1,[r2,#0x0]	; 023296E8
	ldr r0,[r5,#0x18]	; 023296EA
	str r0,[sp,#0x4]	; 023296EC
	ldr r0,[r5,#0x1c]	; 023296EE
	str r0,[sp,#0x8]	; 023296F0
	add r0,sp,#0x4	; 023296F2
	ldr r1,[pool_02329714]	; 023296F4
	bl loc_02329718	; 023296F6
	str r0,[r4,#0x0]	; 023296FA
	str r0,[r4,#0x4]	; 023296FC
	mov r0,#0x0	; 023296FE
	str r0,[r4,#0x8]	; 02329700
	str r0,[r4,#0xc]	; 02329702
	add r0,r5,#0x0	; 02329704
	add sp,#0xc	; 02329706
	pop {r4,r5}	; 02329708
	pop {r3}	; 0232970A
	bx r3	; 0232970C
	.byte 0xC0, 0x46	; 02329710
pool_02329710:
loc_02329710:
	.word 0x45585048	; 02329710
pool_02329714:
loc_02329714:
	.word 0x00004652	; 02329714

; ===== function loc_02329718 =====
loc_02329718:
	ldr r3,[r0,#0x0]	; 02329718
	strh r1,[r3,#0x0]	; 0232971A
	mov r2,#0x0	; 0232971C
	strh r2,[r3,#0x2]	; 0232971E
	ldr r1,[r0,#0x4]	; 02329720
	add r0,r3,#0x0	; 02329722
	add r0,#0x10	; 02329724
	sub r0,r1,r0	; 02329726
	str r0,[r3,#0x4]	; 02329728
	str r2,[r3,#0x8]	; 0232972A
	str r2,[r3,#0xc]	; 0232972C
	add r0,r3,#0x0	; 0232972E
	bx lr	; 02329730
	.byte 0x00, 0x00, 0x8A, 0x60, 0x00, 0x2A, 0x02, 0xD0, 0xD3, 0x68, 0xD1, 0x60, 0x01, 0xE0, 0x03, 0x68	; 02329742
	.byte 0x01, 0x60, 0xCB, 0x60, 0x00, 0x2B, 0x01, 0xD0, 0x99, 0x60, 0x00, 0xE0, 0x41, 0x60, 0x08, 0x1C	; 02329752
	.byte 0x70, 0x47, 0x8A, 0x68, 0xC9, 0x68, 0x00, 0x2A, 0x01, 0xD0, 0xD1, 0x60, 0x00, 0xE0, 0x01, 0x60	; 02329762
	.byte 0x00, 0x29, 0x01, 0xD0, 0x8A, 0x60, 0x00, 0xE0, 0x42, 0x60, 0x10, 0x1C, 0x70, 0x47, 0x4A, 0x88	; 02329772
	.byte 0x13, 0x12, 0x7F, 0x22, 0x13, 0x40, 0x1A, 0x04, 0x12, 0x0C, 0x8A, 0x1A, 0x02, 0x60, 0x4A, 0x68	; 02329782
	.byte 0x10, 0x31, 0x51, 0x18, 0x41, 0x60, 0x70, 0x47, 0x00, 0x00	; 0232978C

; ===== function loc_0232978C =====
loc_0232978C:
	push {r4,r5,lr}	; 0232978C
	sub sp,#0x4	; 0232978E
	add r5,r0,#0x0	; 02329790
	add r4,r1,#0x0	; 02329792
	mov r1,#0x1	; 02329794
	add r2,r4,#0x0	; 02329796
	and r2,r1	; 02329798
	cmp r2,#0x0	; 0232979A
	beq loc_023297A2	; 0232979C
	bl loc_02329834	; 0232979E
loc_023297A2:
	mov r0,#0x2	; 023297A2
	and r4,r0	; 023297A4
	cmp r4,#0x0	; 023297A6
	beq loc_023297B0	; 023297A8
	add r0,r5,#0x0	; 023297AA
	bl loc_02329818	; 023297AC
loc_023297B0:
	add sp,#0x4	; 023297B0
	pop {r4,r5}	; 023297B2
	pop {r3}	; 023297B4
	bx r3	; 023297B6

; ===== function loc_023297B8 =====
loc_023297B8:
	push {lr}	; 023297B8
	sub sp,#0x4	; 023297BA
	add r0,#0x24	; 023297BC
	cmp r1,#0x0	; 023297BE
	bne loc_023297C4	; 023297C0
	mov r1,#0x1	; 023297C2
loc_023297C4:
	add r1,r1,#0x3	; 023297C4
	mov r3,#0x3	; 023297C6
	bic r1,r3	; 023297C8
	cmp r2,#0x0	; 023297CA
	blt loc_023297D8	; 023297CC
	bl loc_02329894	; 023297CE
	add sp,#0x4	; 023297D2
	pop {r3}	; 023297D4
	bx r3	; 023297D6
loc_023297D8:
	neg r2,r2	; 023297D8
	bl loc_02329844	; 023297DA
	add sp,#0x4	; 023297DE
	pop {r3}	; 023297E0
	bx r3	; 023297E2

; ===== function loc_023297E4 =====
loc_023297E4:
	ldr r3,[pool_023297E8]	; 023297E4
	bx r3	; 023297E6
pool_023297E8:
loc_023297E8:
	.word loc_023292A0 + 1	; 023297E8

; ===== function loc_023297EC =====
loc_023297EC:
	push {lr}	; 023297EC
	sub sp,#0x4	; 023297EE
	add r1,r1,r0	; 023297F0
	mov r3,#0x3	; 023297F2
	bic r1,r3	; 023297F4
	add r0,r0,#0x3	; 023297F6
	bic r0,r3	; 023297F8
	cmp r0,r1	; 023297FA
	bhi loc_02329804	; 023297FC
	sub r3,r1,r0	; 023297FE
	cmp r3,#0x30	; 02329800
	bcs loc_0232980C	; 02329802
loc_02329804:
	mov r0,#0x0	; 02329804
	add sp,#0x4	; 02329806
	pop {r3}	; 02329808
	bx r3	; 0232980A
loc_0232980C:
	bl loc_023298E4	; 0232980C
	add sp,#0x4	; 02329810
	pop {r3}	; 02329812
	bx r3	; 02329814
	.byte 0x00, 0x00	; 02329818

; ===== function loc_02329818 =====
loc_02329818:
	add r2,r0,#0x0	; 02329818
	add r2,#0x24	; 0232981A
	ldr r3,[r2,#0x8]	; 0232981C
	cmp r3,#0x0	; 0232981E
	beq loc_0232982C	; 02329820
loc_02329822:
	ldr r1,[r0,#0x1c]	; 02329822
	str r1,[r3,#0x8]	; 02329824
	ldr r3,[r3,#0xc]	; 02329826
	cmp r3,#0x0	; 02329828
	bne loc_02329822	; 0232982A
loc_0232982C:
	ldr r0,[r0,#0x1c]	; 0232982C
	str r0,[r2,#0x4]	; 0232982E
	bx lr	; 02329830
	.byte 0x00, 0x00	; 02329834

; ===== function loc_02329834 =====
loc_02329834:
	add r1,r0,#0x0	; 02329834
	add r1,#0x24	; 02329836
	ldr r0,[r0,#0x18]	; 02329838
	str r0,[r1,#0x0]	; 0232983A
	mov r0,#0x0	; 0232983C
	str r0,[r1,#0x8]	; 0232983E
	bx lr	; 02329840
	.byte 0x00, 0x00	; 02329844

; ===== function loc_02329844 =====
loc_02329844:
	push {r4,r5,lr}	; 02329844
	sub sp,#0x4	; 02329846
	add r5,r0,#0x0	; 02329848
	ldr r0,[r5,#0x4]	; 0232984A
	sub r2,r2,#0x1	; 0232984C
	mvn r4,r2	; 0232984E
	sub r1,r0,r1	; 02329850
	and r4,r1	; 02329852
loc_02329854:
	ldr r1,[r5,#0x0]	; 02329854
	cmp r4,r1	; 02329856
	bcs loc_02329864	; 02329858
	mov r0,#0x0	; 0232985A
	add sp,#0x4	; 0232985C
	pop {r4,r5}	; 0232985E
	pop {r3}	; 02329860
	bx r3	; 02329862
loc_02329864:
	sub r2,r0,r4	; 02329864
	sub r0,r5,#0x4	; 02329866
	ldr r1,[r0,#0x0]	; 02329868
	mov r0,#0xff	; 0232986A
	and r1,r0	; 0232986C
	lsl r0,r1,#0x10	; 0232986E
	lsr r1,r0,#0x10	; 02329870
	mov r0,#0x1	; 02329872
	and r1,r0	; 02329874
	cmp r1,#0x0	; 02329876
	beq loc_02329886	; 02329878
	mov r0,#0x0	; 0232987A
	str r0,[sp,#0x0]	; 0232987C
	ldr r0,[sp,#0x0]	; 0232987E
	add r1,r4,#0x0	; 02329880
	blx loc_0232E320	; 02329882
loc_02329886:
	str r4,[r5,#0x4]	; 02329886
	add r0,r4,#0x0	; 02329888
	add sp,#0x4	; 0232988A
	pop {r4,r5}	; 0232988C
	pop {r3}	; 0232988E
	bx r3	; 02329890
	.byte 0x00, 0x00	; 02329894

; ===== function loc_02329894 =====
loc_02329894:
	push {r4,r5,r6,lr}	; 02329894
	sub sp,#0x8	; 02329896
	add r5,r0,#0x0	; 02329898
	ldr r3,[r5,#0x0]	; 0232989A
	sub r0,r2,#0x1	; 0232989C
	mvn r4,r0	; 0232989E
	add r0,r0,r3	; 023298A0
	and r4,r0	; 023298A2
	add r6,r1,r4	; 023298A4
	ldr r0,[r5,#0x4]	; 023298A6
	cmp r6,r0	; 023298A8
	bls loc_023298B6	; 023298AA
	mov r0,#0x0	; 023298AC
	add sp,#0x8	; 023298AE
	pop {r4,r5,r6}	; 023298B0
	pop {r3}	; 023298B2
	bx r3	; 023298B4
loc_023298B6:
	sub r2,r6,r3	; 023298B6
	sub r0,r5,#0x4	; 023298B8
	ldr r1,[r0,#0x0]	; 023298BA
	mov r0,#0xff	; 023298BC
	and r1,r0	; 023298BE
	lsl r0,r1,#0x10	; 023298C0
	lsr r1,r0,#0x10	; 023298C2
	mov r0,#0x1	; 023298C4
	and r1,r0	; 023298C6
	cmp r1,#0x0	; 023298C8
	beq loc_023298D8	; 023298CA
	mov r0,#0x0	; 023298CC
	str r0,[sp,#0x0]	; 023298CE
	ldr r0,[sp,#0x0]	; 023298D0
	add r1,r3,#0x0	; 023298D2
	blx loc_0232E320	; 023298D4
loc_023298D8:
	str r6,[r5,#0x0]	; 023298D8
	add r0,r4,#0x0	; 023298DA
	add sp,#0x8	; 023298DC
	pop {r4,r5,r6}	; 023298DE
	pop {r3}	; 023298E0
	bx r3	; 023298E2

; ===== function loc_023298E4 =====
loc_023298E4:
	push {r4,r5,lr}	; 023298E4
	sub sp,#0x4	; 023298E6
	add r5,r0,#0x0	; 023298E8
	add r3,r1,#0x0	; 023298EA
	add r4,r5,#0x0	; 023298EC
	add r4,#0x24	; 023298EE
	str r2,[sp,#0x0]	; 023298F0
	ldr r1,[pool_02329914]	; 023298F2
	add r2,r4,#0x0	; 023298F4
	add r2,#0xc	; 023298F6
	bl loc_023292B4	; 023298F8
	ldr r0,[r5,#0x18]	; 023298FC
	str r0,[r4,#0x0]	; 023298FE
	ldr r0,[r5,#0x1c]	; 02329900
	str r0,[r4,#0x4]	; 02329902
	mov r0,#0x0	; 02329904
	str r0,[r4,#0x8]	; 02329906
	add r0,r5,#0x0	; 02329908
	add sp,#0x4	; 0232990A
	pop {r4,r5}	; 0232990C
	pop {r3}	; 0232990E
	bx r3	; 02329910
	.byte 0xC0, 0x46	; 02329914
pool_02329914:
loc_02329914:
	.word 0x46524D48	; 02329914

; ===== function loc_02329918 =====
loc_02329918:
	ldr r3,[pool_0232991C]	; 02329918
	bx r3	; 0232991A
pool_0232991C:
loc_0232991C:
	.word loc_0232A0D8 + 1	; 0232991C

; ===== function loc_02329920 =====
loc_02329920:
	push {r4,lr}	; 02329920
	bl loc_0232A138	; 02329922
	mov r0,#0x0	; 02329926
	add r1,r0,#0x0	; 02329928
	add r2,r0,#0x0	; 0232992A
	add r3,r0,#0x0	; 0232992C
	bl loc_0232E5D4	; 0232992E
	bl loc_0232E7EC	; 02329932
	add r4,r0,#0x0	; 02329936
	mov r0,#0x1	; 02329938
	bl loc_0232E858	; 0232993A
	add r0,r4,#0x0	; 0232993E
	bl loc_0232E80C	; 02329940
	pop {r4}	; 02329944
	pop {r3}	; 02329946
	bx r3	; 02329948
	.byte 0x00, 0x00	; 0232994C

; ===== function loc_0232994C =====
loc_0232994C:
	push {r4,lr}	; 0232994C
	mov r4,#0x0	; 0232994E
loc_02329950:
	add r0,r4,#0x0	; 02329950
	bl loc_0232E9B0	; 02329952
	cmp r0,#0x0	; 02329956
	bne loc_02329950	; 02329958
	bl loc_02329ECC	; 0232995A
	bl loc_0232A4C8	; 0232995E
	mov r0,#0x0	; 02329962
	bl loc_0232E858	; 02329964
	pop {r4}	; 02329968
	pop {r3}	; 0232996A
	bx r3	; 0232996C
	.byte 0x00, 0x00	; 02329970

; ===== function loc_02329970 =====
loc_02329970:
	push {lr}	; 02329970
	sub sp,#0x4	; 02329972
	ldr r0,[pool_02329998]	; 02329974
	ldr r1,[r0,#0x0]	; 02329976
	cmp r1,#0x0	; 02329978
	bne loc_02329990	; 0232997A
	mov r1,#0x1	; 0232997C
	str r1,[r0,#0x0]	; 0232997E
	bl loc_0232E40C	; 02329980
	bl loc_02329A68	; 02329984
	bl loc_0232A528	; 02329988
	bl loc_02329FBC	; 0232998C
loc_02329990:
	add sp,#0x4	; 02329990
	pop {r3}	; 02329992
	bx r3	; 02329994
	.byte 0xC0, 0x46	; 02329998
pool_02329998:
loc_02329998:
	.word P1_BssStart + 0x25A18	; 02329998

; ===== function loc_0232999C =====
loc_0232999C:
	ldr r1,[pool_023299AC]	; 0232999C
	ldr r3,[r1,#0x0]	; 0232999E
	mov r2,#0x1	; 023299A0
	lsl r2,r0	; 023299A2
	bic r3,r2	; 023299A4
	str r3,[r1,#0x0]	; 023299A6
	bx lr	; 023299A8
	.byte 0xC0, 0x46	; 023299AC
pool_023299AC:
loc_023299AC:
	.word P1_BssStart + 0x25A20	; 023299AC

; ===== function loc_023299B0 =====
loc_023299B0:
	mov r3,#0x1	; 023299B0
	mov r0,#0x0	; 023299B2
	ldr r1,[pool_023299D8]	; 023299B4
	ldr r2,[r1,#0x0]	; 023299B6
loc_023299B8:
	add r1,r2,#0x0	; 023299B8
	and r1,r3	; 023299BA
	cmp r1,#0x0	; 023299BC
	bne loc_023299CA	; 023299BE
	ldr r1,[pool_023299D8]	; 023299C0
	ldr r2,[r1,#0x0]	; 023299C2
	orr r2,r3	; 023299C4
	str r2,[r1,#0x0]	; 023299C6
	bx lr	; 023299C8
loc_023299CA:
	add r0,r0,#0x1	; 023299CA
	lsl r3,r3,#0x1	; 023299CC
	cmp r0,#0x8	; 023299CE
	blt loc_023299B8	; 023299D0
	mov r0,#0x0	; 023299D2
	mvn r0,r0	; 023299D4
	bx lr	; 023299D6
pool_023299D8:
loc_023299D8:
	.word P1_BssStart + 0x25A20	; 023299D8

; ===== function loc_023299DC =====
loc_023299DC:
	ldr r1,[pool_023299E8]	; 023299DC
	ldr r2,[r1,#0x0]	; 023299DE
	bic r2,r0	; 023299E0
	str r2,[r1,#0x0]	; 023299E2
	bx lr	; 023299E4
	.byte 0xC0, 0x46	; 023299E8
pool_023299E8:
loc_023299E8:
	.word P1_BssStart + 0x25A1C	; 023299E8

; ===== function loc_023299EC =====
loc_023299EC:
	ldr r1,[pool_02329A04]	; 023299EC
	ldr r2,[r1,#0x0]	; 023299EE
	add r3,r0,#0x0	; 023299F0
	and r3,r2	; 023299F2
	cmp r3,#0x0	; 023299F4
	beq loc_023299FC	; 023299F6
	mov r0,#0x0	; 023299F8
	bx lr	; 023299FA
loc_023299FC:
	orr r2,r0	; 023299FC
	str r2,[r1,#0x0]	; 023299FE
	mov r0,#0x1	; 02329A00
	bx lr	; 02329A02
pool_02329A04:
loc_02329A04:
	.word P1_BssStart + 0x25A1C	; 02329A04

; ===== function loc_02329A08 =====
loc_02329A08:
	push {r4,lr}	; 02329A08
	add r4,r0,#0x0	; 02329A0A
	cmp r4,#0x0	; 02329A0C
	beq loc_02329A1E	; 02329A0E
	mov r1,#0x0	; 02329A10
	bl loc_0232E538	; 02329A12
	ldr r0,[pool_02329A24]	; 02329A16
	ldr r1,[r0,#0x0]	; 02329A18
	bic r1,r4	; 02329A1A
	str r1,[r0,#0x0]	; 02329A1C
loc_02329A1E:
	pop {r4}	; 02329A1E
	pop {r3}	; 02329A20
	bx r3	; 02329A22
pool_02329A24:
loc_02329A24:
	.word P1_BssStart + 0x25A24	; 02329A24

; ===== function loc_02329A28 =====
loc_02329A28:
	push {r4,lr}	; 02329A28
	add r4,r0,#0x0	; 02329A2A
	cmp r4,#0x0	; 02329A2C
	bne loc_02329A38	; 02329A2E
	mov r0,#0x1	; 02329A30
	pop {r4}	; 02329A32
	pop {r3}	; 02329A34
	bx r3	; 02329A36
loc_02329A38:
	ldr r1,[pool_02329A64]	; 02329A38
	ldr r1,[r1,#0x0]	; 02329A3A
	add r2,r4,#0x0	; 02329A3C
	and r2,r1	; 02329A3E
	cmp r2,#0x0	; 02329A40
	beq loc_02329A4C	; 02329A42
	mov r0,#0x0	; 02329A44
	pop {r4}	; 02329A46
	pop {r3}	; 02329A48
	bx r3	; 02329A4A
loc_02329A4C:
	mov r1,#0x0	; 02329A4C
	bl loc_0232E554	; 02329A4E
	ldr r0,[pool_02329A64]	; 02329A52
	ldr r1,[r0,#0x0]	; 02329A54
	orr r1,r4	; 02329A56
	str r1,[r0,#0x0]	; 02329A58
	mov r0,#0x1	; 02329A5A
	pop {r4}	; 02329A5C
	pop {r3}	; 02329A5E
	bx r3	; 02329A60
	.byte 0xC0, 0x46	; 02329A64
pool_02329A64:
loc_02329A64:
	.word P1_BssStart + 0x25A24	; 02329A64

; ===== function loc_02329A68 =====
loc_02329A68:
	mov r1,#0x0	; 02329A68
	ldr r0,[pool_02329A78]	; 02329A6A
	str r1,[r0,#0x0]	; 02329A6C
	ldr r0,[pool_02329A7C]	; 02329A6E
	str r1,[r0,#0x0]	; 02329A70
	ldr r0,[pool_02329A80]	; 02329A72
	str r1,[r0,#0x0]	; 02329A74
	bx lr	; 02329A76
pool_02329A78:
loc_02329A78:
	.word P1_BssStart + 0x25A24	; 02329A78
pool_02329A7C:
loc_02329A7C:
	.word P1_BssStart + 0x25A1C	; 02329A7C
pool_02329A80:
loc_02329A80:
	.word P1_BssStart + 0x25A20	; 02329A80

; ===== function loc_02329A84 =====
loc_02329A84:
	push {r4,r5,r6,lr}	; 02329A84
	add r5,r0,#0x0	; 02329A86
	add r6,r1,#0x0	; 02329A88
	ldr r4,[r5,#0x4]	; 02329A8A
	cmp r4,#0x0	; 02329A8C
	beq loc_02329A9C	; 02329A8E
	add r0,r4,#0x0	; 02329A90
	add r1,r5,#0x0	; 02329A92
	bl loc_0232917C	; 02329A94
	mov r0,#0x0	; 02329A98
	str r0,[r5,#0x4]	; 02329A9A
loc_02329A9C:
	ldr r0,[pool_02329AC4]	; 02329A9C
	add r1,r5,#0x0	; 02329A9E
	bl loc_0232917C	; 02329AA0
	add r0,r5,#0x0	; 02329AA4
	add r0,#0x3d	; 02329AA6
	strb r6,[r0,#0x0]	; 02329AA8
	cmp r4,#0x0	; 02329AAA
	beq loc_02329AB6	; 02329AAC
	add r0,r4,#0x0	; 02329AAE
	add r1,r5,#0x0	; 02329AB0
	bl loc_02329C1C	; 02329AB2
loc_02329AB6:
	add r0,r5,#0x0	; 02329AB6
	bl loc_02329BD4	; 02329AB8
	pop {r4,r5,r6}	; 02329ABC
	pop {r3}	; 02329ABE
	bx r3	; 02329AC0
	.byte 0xC0, 0x46	; 02329AC4
pool_02329AC4:
loc_02329AC4:
	.word 0x023568B4	; 02329AC4

; ===== function loc_02329AC8 =====
	push {r4,lr}	; 02329AC8
	add r4,r0,#0x0	; 02329ACA
	ldr r0,[r4,#0x8]	; 02329ACC
	cmp r0,#0x0	; 02329ACE
	beq loc_02329AF8	; 02329AD0
	bl loc_0232A86C	; 02329AD2
	ldr r1,[r4,#0xc]	; 02329AD6
	cmp r1,#0x0	; 02329AD8
	beq loc_02329AE6	; 02329ADA
	mov r0,#0x0	; 02329ADC
	str r0,[r1,#0x8]	; 02329ADE
	pop {r4}	; 02329AE0
	pop {r3}	; 02329AE2
	bx r3	; 02329AE4
loc_02329AE6:
	ldr r2,[pool_02329B00]	; 02329AE6
	ldr r1,[r4,#0x10]	; 02329AE8
	mov r0,#0x1c	; 02329AEA
	mul r1,r0	; 02329AEC
	add r0,r2,r1	; 02329AEE
	add r0,#0xc	; 02329AF0
	add r1,r4,#0x0	; 02329AF2
	bl loc_0232917C	; 02329AF4
loc_02329AF8:
	pop {r4}	; 02329AF8
	pop {r3}	; 02329AFA
	bx r3	; 02329AFC
	.byte 0xC0, 0x46	; 02329B00
pool_02329B00:
loc_02329B00:
	.word 0x023568C0	; 02329B00

; ===== function loc_02329B04 =====
loc_02329B04:
	push {r4,r5,lr}	; 02329B04
	sub sp,#0x4	; 02329B06
	add r5,r0,#0x0	; 02329B08
	ldr r1,[r5,#0x0]	; 02329B0A
	cmp r1,#0x0	; 02329B0C
	beq loc_02329B16	; 02329B0E
	mov r0,#0x0	; 02329B10
	str r0,[r1,#0x0]	; 02329B12
	str r0,[r5,#0x0]	; 02329B14
loc_02329B16:
	ldr r4,[r5,#0x4]	; 02329B16
	add r0,r4,#0x0	; 02329B18
	add r1,r5,#0x0	; 02329B1A
	bl loc_0232917C	; 02329B1C
	mov r0,#0x0	; 02329B20
	str r0,[r5,#0x4]	; 02329B22
	ldr r1,[r5,#0x8]	; 02329B24
	cmp r1,#0x0	; 02329B26
	beq loc_02329B3A	; 02329B28
	add r4,#0xc	; 02329B2A
	add r0,r4,#0x0	; 02329B2C
	bl loc_0232923C	; 02329B2E
	mov r1,#0x0	; 02329B32
	ldr r0,[r5,#0x8]	; 02329B34
	str r1,[r0,#0xc]	; 02329B36
	str r1,[r5,#0x8]	; 02329B38
loc_02329B3A:
	ldr r0,[pool_02329B58]	; 02329B3A
	add r1,r5,#0x0	; 02329B3C
	bl loc_0232917C	; 02329B3E
	ldr r0,[pool_02329B5C]	; 02329B42
	add r1,r5,#0x0	; 02329B44
	bl loc_0232923C	; 02329B46
	mov r0,#0x0	; 02329B4A
	add r5,#0x2c	; 02329B4C
	strb r0,[r5,#0x0]	; 02329B4E
	add sp,#0x4	; 02329B50
	pop {r4,r5}	; 02329B52
	pop {r3}	; 02329B54
	bx r3	; 02329B56
pool_02329B58:
loc_02329B58:
	.word 0x023568B4	; 02329B58
pool_02329B5C:
loc_02329B5C:
	.word 0x023568A8	; 02329B5C

; ===== function loc_02329B60 =====
loc_02329B60:
	push {r4,r5,lr}	; 02329B60
	sub sp,#0x4	; 02329B62
	add r5,r0,#0x0	; 02329B64
	ldr r0,[pool_02329BB4]	; 02329B66
	mov r1,#0x0	; 02329B68
	bl loc_0232916C	; 02329B6A
	add r4,r0,#0x0	; 02329B6E
	cmp r4,#0x0	; 02329B70
	bne loc_02329B96	; 02329B72
	ldr r0,[pool_02329BB8]	; 02329B74
	mov r1,#0x0	; 02329B76
	bl loc_0232916C	; 02329B78
	add r4,r0,#0x0	; 02329B7C
	add r1,r4,#0x0	; 02329B7E
	add r1,#0x3d	; 02329B80
	ldrb r1,[r1,#0x0]	; 02329B82
	cmp r5,r1	; 02329B84
	bge loc_02329B92	; 02329B86
	mov r0,#0x0	; 02329B88
	add sp,#0x4	; 02329B8A
	pop {r4,r5}	; 02329B8C
	pop {r3}	; 02329B8E
	bx r3	; 02329B90
loc_02329B92:
	bl loc_02329BBC	; 02329B92
loc_02329B96:
	ldr r0,[pool_02329BB4]	; 02329B96
	add r1,r4,#0x0	; 02329B98
	bl loc_0232917C	; 02329B9A
	add r0,r4,#0x0	; 02329B9E
	add r0,#0x3d	; 02329BA0
	strb r5,[r0,#0x0]	; 02329BA2
	add r0,r4,#0x0	; 02329BA4
	bl loc_02329BD4	; 02329BA6
	add r0,r4,#0x0	; 02329BAA
	add sp,#0x4	; 02329BAC
	pop {r4,r5}	; 02329BAE
	pop {r3}	; 02329BB0
	bx r3	; 02329BB2
pool_02329BB4:
loc_02329BB4:
	.word 0x023568A8	; 02329BB4
pool_02329BB8:
loc_02329BB8:
	.word 0x023568B4	; 02329BB8

; ===== function loc_02329BBC =====
loc_02329BBC:
	push {r4,lr}	; 02329BBC
	add r4,r0,#0x0	; 02329BBE
	add r0,#0x3c	; 02329BC0
	ldrb r0,[r0,#0x0]	; 02329BC2
	bl loc_0232E694	; 02329BC4
	add r0,r4,#0x0	; 02329BC8
	bl loc_02329B04	; 02329BCA
	pop {r4}	; 02329BCE
	pop {r3}	; 02329BD0
	bx r3	; 02329BD2

; ===== function loc_02329BD4 =====
loc_02329BD4:
	push {r4,r5,lr}	; 02329BD4
	sub sp,#0x4	; 02329BD6
	add r5,r0,#0x0	; 02329BD8
	ldr r0,[pool_02329C18]	; 02329BDA
	mov r1,#0x0	; 02329BDC
	bl loc_0232916C	; 02329BDE
	add r1,r0,#0x0	; 02329BE2
	cmp r1,#0x0	; 02329BE4
	beq loc_02329C06	; 02329BE6
	ldr r4,[pool_02329C18]	; 02329BE8
loc_02329BEA:
	add r0,r5,#0x0	; 02329BEA
	add r0,#0x3d	; 02329BEC
	ldrb r2,[r0,#0x0]	; 02329BEE
	add r0,r1,#0x0	; 02329BF0
	add r0,#0x3d	; 02329BF2
	ldrb r0,[r0,#0x0]	; 02329BF4
	cmp r2,r0	; 02329BF6
	bcc loc_02329C06	; 02329BF8
	add r0,r4,#0x0	; 02329BFA
	bl loc_0232916C	; 02329BFC
	add r1,r0,#0x0	; 02329C00
	cmp r1,#0x0	; 02329C02
	bne loc_02329BEA	; 02329C04
loc_02329C06:
	ldr r0,[pool_02329C18]	; 02329C06
	add r2,r5,#0x0	; 02329C08
	bl loc_023291BC	; 02329C0A
	add sp,#0x4	; 02329C0E
	pop {r4,r5}	; 02329C10
	pop {r3}	; 02329C12
	bx r3	; 02329C14
	.byte 0xC0, 0x46	; 02329C18
pool_02329C18:
loc_02329C18:
	.word 0x023568B4	; 02329C18

; ===== function loc_02329C1C =====
loc_02329C1C:
	push {r4,r5,lr}	; 02329C1C
	sub sp,#0x4	; 02329C1E
	add r5,r0,#0x0	; 02329C20
	add r4,r1,#0x0	; 02329C22
	mov r1,#0x0	; 02329C24
	bl loc_0232916C	; 02329C26
	add r1,r0,#0x0	; 02329C2A
	cmp r1,#0x0	; 02329C2C
	beq loc_02329C4C	; 02329C2E
loc_02329C30:
	add r0,r4,#0x0	; 02329C30
	add r0,#0x3d	; 02329C32
	ldrb r2,[r0,#0x0]	; 02329C34
	add r0,r1,#0x0	; 02329C36
	add r0,#0x3d	; 02329C38
	ldrb r0,[r0,#0x0]	; 02329C3A
	cmp r2,r0	; 02329C3C
	bcc loc_02329C4C	; 02329C3E
	add r0,r5,#0x0	; 02329C40
	bl loc_0232916C	; 02329C42
	add r1,r0,#0x0	; 02329C46
	cmp r1,#0x0	; 02329C48
	bne loc_02329C30	; 02329C4A
loc_02329C4C:
	add r0,r5,#0x0	; 02329C4C
	add r2,r4,#0x0	; 02329C4E
	bl loc_023291BC	; 02329C50
	str r5,[r4,#0x4]	; 02329C54
	add sp,#0x4	; 02329C56
	pop {r4,r5}	; 02329C58
	pop {r3}	; 02329C5A
	bx r3	; 02329C5C
	.byte 0x00, 0x00	; 02329C60

; ===== function loc_02329C60 =====
loc_02329C60:
	push {r4,lr}	; 02329C60
	add r4,r0,#0x0	; 02329C62
	mov r1,#0x0	; 02329C64
	add r0,#0x2e	; 02329C66
	strb r1,[r0,#0x0]	; 02329C68
	add r0,r4,#0x0	; 02329C6A
	add r0,#0x2d	; 02329C6C
	strb r1,[r0,#0x0]	; 02329C6E
	strh r1,[r4,#0x34]	; 02329C70
	strh r1,[r4,#0x3e]	; 02329C72
	mov r1,#0x7f	; 02329C74
	add r0,r4,#0x0	; 02329C76
	add r0,#0x40	; 02329C78
	strb r1,[r0,#0x0]	; 02329C7A
	add r0,r4,#0x0	; 02329C7C
	add r0,#0x41	; 02329C7E
	strb r1,[r0,#0x0]	; 02329C80
	add r0,r4,#0x0	; 02329C82
	add r0,#0x1c	; 02329C84
	bl loc_0232ABA8	; 02329C86
	add r4,#0x1c	; 02329C8A
	add r0,r4,#0x0	; 02329C8C
	ldr r1,[pool_02329C9C]	; 02329C8E
	mov r2,#0x1	; 02329C90
	bl loc_0232AB8C	; 02329C92
	pop {r4}	; 02329C96
	pop {r3}	; 02329C98
	bx r3	; 02329C9A
pool_02329C9C:
loc_02329C9C:
	.word 0x00007F00	; 02329C9C
loc_02329CA0:
	push {r4,lr}	; 02329CA0
	add r4,r0,#0x0	; 02329CA2
	add r2,r1,#0x0	; 02329CA4
	cmp r4,#0x0	; 02329CA6
	beq loc_02329CD8	; 02329CA8
	add r1,r4,#0x0	; 02329CAA
	add r1,#0x2c	; 02329CAC
	ldrb r1,[r1,#0x0]	; 02329CAE
	cmp r1,#0x0	; 02329CB0
	beq loc_02329CD8	; 02329CB2
	cmp r2,#0x0	; 02329CB4
	bne loc_02329CC2	; 02329CB6
	bl loc_02329BBC	; 02329CB8
	pop {r4}	; 02329CBC
	pop {r3}	; 02329CBE
	bx r3	; 02329CC0
loc_02329CC2:
	add r0,#0x1c	; 02329CC2
	mov r1,#0x0	; 02329CC4
	bl loc_0232AB8C	; 02329CC6
	add r0,r4,#0x0	; 02329CCA
	mov r1,#0x0	; 02329CCC
	bl loc_02329A84	; 02329CCE
	mov r0,#0x2	; 02329CD2
	add r4,#0x2c	; 02329CD4
	strb r0,[r4,#0x0]	; 02329CD6
loc_02329CD8:
	pop {r4}	; 02329CD8
	pop {r3}	; 02329CDA
	bx r3	; 02329CDC
	.byte 0x00, 0x00	; 02329CE0

; ===== function loc_02329CE0 =====
loc_02329CE0:
	push {r4,lr}	; 02329CE0
	add r4,r0,#0x0	; 02329CE2
	add r0,#0x3c	; 02329CE4
	ldrb r0,[r0,#0x0]	; 02329CE6
	bl loc_0232E6AC	; 02329CE8
	add r0,r4,#0x0	; 02329CEC
	bl loc_02329C60	; 02329CEE
	bl loc_0232E7EC	; 02329CF2
	str r0,[r4,#0x30]	; 02329CF6
	mov r0,#0x1	; 02329CF8
	add r4,#0x2c	; 02329CFA
	strb r0,[r4,#0x0]	; 02329CFC
	pop {r4}	; 02329CFE
	pop {r3}	; 02329D00
	bx r3	; 02329D02

; ===== function loc_02329D04 =====
loc_02329D04:
	ldr r3,[pool_02329D08]	; 02329D04
	bx r3	; 02329D06
pool_02329D08:
loc_02329D08:
	.word loc_02329B04 + 1	; 02329D08

; ===== function loc_02329D0C =====
loc_02329D0C:
	push {r4,r5,r6,lr}	; 02329D0C
	add r5,r0,#0x0	; 02329D0E
	add r6,r2,#0x0	; 02329D10
	ldr r3,[pool_02329D80]	; 02329D12
	mov r2,#0x1c	; 02329D14
	mul r1,r2	; 02329D16
	add r4,r3,r1	; 02329D18
	ldr r1,[r5,#0x0]	; 02329D1A
	cmp r1,#0x0	; 02329D1C
	beq loc_02329D24	; 02329D1E
	bl loc_02329E28	; 02329D20
loc_02329D24:
	ldrh r1,[r4,#0x8]	; 02329D24
	ldr r0,[r4,#0x18]	; 02329D26
	cmp r1,r0	; 02329D28
	bcc loc_02329D56	; 02329D2A
	add r0,r4,#0x0	; 02329D2C
	mov r1,#0x0	; 02329D2E
	bl loc_0232916C	; 02329D30
	cmp r0,#0x0	; 02329D34
	bne loc_02329D40	; 02329D36
	mov r0,#0x0	; 02329D38
	pop {r4,r5,r6}	; 02329D3A
	pop {r3}	; 02329D3C
	bx r3	; 02329D3E
loc_02329D40:
	add r1,r0,#0x0	; 02329D40
	add r1,#0x3d	; 02329D42
	ldrb r1,[r1,#0x0]	; 02329D44
	cmp r6,r1	; 02329D46
	bge loc_02329D52	; 02329D48
	mov r0,#0x0	; 02329D4A
	pop {r4,r5,r6}	; 02329D4C
	pop {r3}	; 02329D4E
	bx r3	; 02329D50
loc_02329D52:
	bl loc_02329BBC	; 02329D52
loc_02329D56:
	add r0,r6,#0x0	; 02329D56
	bl loc_02329B60	; 02329D58
	add r6,r0,#0x0	; 02329D5C
	cmp r6,#0x0	; 02329D5E
	bne loc_02329D6A	; 02329D60
	mov r0,#0x0	; 02329D62
	pop {r4,r5,r6}	; 02329D64
	pop {r3}	; 02329D66
	bx r3	; 02329D68
loc_02329D6A:
	add r0,r4,#0x0	; 02329D6A
	add r1,r6,#0x0	; 02329D6C
	bl loc_02329C1C	; 02329D6E
	str r5,[r6,#0x0]	; 02329D72
	str r6,[r5,#0x0]	; 02329D74
	add r0,r6,#0x0	; 02329D76
	pop {r4,r5,r6}	; 02329D78
	pop {r3}	; 02329D7A
	bx r3	; 02329D7C
	.byte 0xC0, 0x46	; 02329D80
pool_02329D80:
loc_02329D80:
	.word 0x023568C0	; 02329D80

; ===== function loc_02329D84 =====
loc_02329D84:
	push {r4}	; 02329D84
	sub sp,#0x4	; 02329D86
	ldr r4,[r0,#0x0]	; 02329D88
	cmp r4,#0x0	; 02329D8A
	beq loc_02329D9A	; 02329D8C
	mov r3,#0x2	; 02329D8E
	strh r3,[r4,#0x34]	; 02329D90
	ldr r3,[r0,#0x0]	; 02329D92
	strh r1,[r3,#0x38]	; 02329D94
	ldr r0,[r0,#0x0]	; 02329D96
	strh r2,[r0,#0x3a]	; 02329D98
loc_02329D9A:
	add sp,#0x4	; 02329D9A
	pop {r4}	; 02329D9C
	bx lr	; 02329D9E

; ===== function loc_02329DA0 =====
	push {lr}	; 02329DA0
	sub sp,#0x4	; 02329DA2
	ldr r0,[r0,#0x0]	; 02329DA4
	cmp r0,#0x0	; 02329DA6
	beq loc_02329DB2	; 02329DA8
	add r0,#0x3c	; 02329DAA
	ldrb r0,[r0,#0x0]	; 02329DAC
	bl loc_0232E63C	; 02329DAE
loc_02329DB2:
	add sp,#0x4	; 02329DB2
	pop {r3}	; 02329DB4
	bx r3	; 02329DB6

; ===== function loc_02329DB8 =====
	push {lr}	; 02329DB8
	sub sp,#0x4	; 02329DBA
	ldr r0,[r0,#0x0]	; 02329DBC
	cmp r0,#0x0	; 02329DBE
	beq loc_02329DCA	; 02329DC0
	add r0,#0x3c	; 02329DC2
	ldrb r0,[r0,#0x0]	; 02329DC4
	bl loc_0232E654	; 02329DC6
loc_02329DCA:
	add sp,#0x4	; 02329DCA
	pop {r3}	; 02329DCC
	bx r3	; 02329DCE

; ===== function loc_02329DD0 =====
loc_02329DD0:
	push {lr}	; 02329DD0
	sub sp,#0x4	; 02329DD2
	ldr r0,[r0,#0x0]	; 02329DD4
	cmp r0,#0x0	; 02329DD6
	beq loc_02329DE2	; 02329DD8
	add r0,#0x3c	; 02329DDA
	ldrb r0,[r0,#0x0]	; 02329DDC
	bl loc_0232E66C	; 02329DDE
loc_02329DE2:
	add sp,#0x4	; 02329DE2
	pop {r3}	; 02329DE4
	bx r3	; 02329DE6

; ===== function loc_02329DE8 =====
	push {lr}	; 02329DE8
	sub sp,#0x4	; 02329DEA
	ldr r0,[r0,#0x0]	; 02329DEC
	cmp r0,#0x0	; 02329DEE
	beq loc_02329E04	; 02329DF0
	add r3,r0,#0x0	; 02329DF2
	add r3,#0x2c	; 02329DF4
	ldrb r3,[r3,#0x0]	; 02329DF6
	cmp r3,#0x2	; 02329DF8
	beq loc_02329E04	; 02329DFA
	add r0,#0x1c	; 02329DFC
	lsl r1,r1,#0x8	; 02329DFE
	bl loc_0232AB8C	; 02329E00
loc_02329E04:
	add sp,#0x4	; 02329E04
	pop {r3}	; 02329E06
	bx r3	; 02329E08
	.byte 0x00, 0x00	; 02329E0C

; ===== function loc_02329E0C =====
loc_02329E0C:
	ldr r0,[r0,#0x0]	; 02329E0C
	cmp r0,#0x0	; 02329E0E
	beq loc_02329E16	; 02329E10
	add r0,#0x40	; 02329E12
	strb r1,[r0,#0x0]	; 02329E14
loc_02329E16:
	bx lr	; 02329E16
	.byte 0x1C, 0x21, 0x48, 0x43, 0x01, 0x49, 0x08, 0x5A, 0x70, 0x47, 0xC0, 0x46, 0xC8, 0x68, 0x35, 0x02	; 02329E28

; ===== function loc_02329E28 =====
loc_02329E28:
	ldr r2,[r0,#0x0]	; 02329E28
	cmp r2,#0x0	; 02329E2A
	beq loc_02329E34	; 02329E2C
	mov r1,#0x0	; 02329E2E
	str r1,[r2,#0x0]	; 02329E30
	str r1,[r0,#0x0]	; 02329E32
loc_02329E34:
	bx lr	; 02329E34
	.byte 0x00, 0x00	; 02329E38

; ===== function loc_02329E38 =====
loc_02329E38:
	mov r1,#0x0	; 02329E38
	str r1,[r0,#0x0]	; 02329E3A
	bx lr	; 02329E3C
	.byte 0x00, 0x00	; 02329E40
loc_02329E40:
	ldr r0,[r0,#0x0]	; 02329E40
	ldr r3,[pool_02329E48]	; 02329E42
	bx r3	; 02329E44
	.byte 0xC0, 0x46	; 02329E48
pool_02329E48:
loc_02329E48:
	.word loc_02329CA0 + 1	; 02329E48

; ===== function loc_02329E4C =====
loc_02329E4C:
	push {r4,r5,r6,lr}	; 02329E4C
	sub sp,#0x8	; 02329E4E
	add r5,r0,#0x0	; 02329E50
	add r6,r2,#0x0	; 02329E52
	mov r3,#0x0	; 02329E54
	str r3,[sp,#0x0]	; 02329E56
	add r0,r1,#0x0	; 02329E58
	add r1,r6,#0x0	; 02329E5A
	add r1,#0x14	; 02329E5C
	ldr r2,[pool_02329EB0]	; 02329E5E
	bl loc_0232A7A4	; 02329E60
	add r4,r0,#0x0	; 02329E64
	cmp r4,#0x0	; 02329E66
	bne loc_02329E74	; 02329E68
	mov r0,#0x0	; 02329E6A
	add sp,#0x8	; 02329E6C
	pop {r4,r5,r6}	; 02329E6E
	pop {r3}	; 02329E70
	bx r3	; 02329E72
loc_02329E74:
	mov r0,#0x0	; 02329E74
	str r0,[r4,#0xc]	; 02329E76
	str r5,[r4,#0x10]	; 02329E78
	str r0,[r4,#0x8]	; 02329E7A
	add r0,r4,#0x0	; 02329E7C
	add r0,#0x14	; 02329E7E
	add r1,r6,#0x0	; 02329E80
	bl loc_0232A880	; 02329E82
	cmp r0,#0x0	; 02329E86
	bne loc_02329E94	; 02329E88
	mov r0,#0x0	; 02329E8A
	add sp,#0x8	; 02329E8C
	pop {r4,r5,r6}	; 02329E8E
	pop {r3}	; 02329E90
	bx r3	; 02329E92
loc_02329E94:
	str r0,[r4,#0x8]	; 02329E94
	ldr r1,[pool_02329EB4]	; 02329E96
	mov r0,#0x1c	; 02329E98
	mul r5,r0	; 02329E9A
	add r0,r1,r5	; 02329E9C
	add r0,#0xc	; 02329E9E
	add r1,r4,#0x0	; 02329EA0
	bl loc_0232923C	; 02329EA2
	mov r0,#0x1	; 02329EA6
	add sp,#0x8	; 02329EA8
	pop {r4,r5,r6}	; 02329EAA
	pop {r3}	; 02329EAC
	bx r3	; 02329EAE
pool_02329EB0:
loc_02329EB0:
	.word 0x02329AC9	; 02329EB0
pool_02329EB4:
loc_02329EB4:
	.word 0x023568C0	; 02329EB4

; ===== function loc_02329EB8 =====
loc_02329EB8:
	lsl r1,r1,#0x10	; 02329EB8
	lsr r2,r1,#0x10	; 02329EBA
	mov r1,#0x1c	; 02329EBC
	mul r0,r1	; 02329EBE
	ldr r1,[pool_02329EC8]	; 02329EC0
	str r2,[r1,r0]	; 02329EC2
	bx lr	; 02329EC4
	.byte 0xC0, 0x46	; 02329EC8
pool_02329EC8:
loc_02329EC8:
	.word P1_BssStart + 0x25A58	; 02329EC8

; ===== function loc_02329ECC =====
loc_02329ECC:
	push {r4,r5,r6,r7,lr}	; 02329ECC
	sub sp,#0xc	; 02329ECE
	bl loc_0232EC18	; 02329ED0
	str r0,[sp,#0x4]	; 02329ED4
	ldr r0,[pool_02329FB0]	; 02329ED6
	mov r1,#0x0	; 02329ED8
	bl loc_0232916C	; 02329EDA
	add r5,r0,#0x0	; 02329EDE
	cmp r5,#0x0	; 02329EE0
	beq loc_02329FA8	; 02329EE2
	ldr r7,[pool_02329FB4]	; 02329EE4
loc_02329EE6:
	ldr r0,[pool_02329FB0]	; 02329EE6
	add r1,r5,#0x0	; 02329EE8
	bl loc_0232916C	; 02329EEA
	str r0,[sp,#0x0]	; 02329EEE
	add r0,r5,#0x0	; 02329EF0
	add r0,#0x2d	; 02329EF2
	ldrb r0,[r0,#0x0]	; 02329EF4
	cmp r0,#0x0	; 02329EF6
	bne loc_02329F0C	; 02329EF8
	ldr r0,[r5,#0x30]	; 02329EFA
	bl loc_0232E7BC	; 02329EFC
	cmp r0,#0x0	; 02329F00
	beq loc_02329F0C	; 02329F02
	add r1,r5,#0x0	; 02329F04
	add r1,#0x2d	; 02329F06
	mov r0,#0x1	; 02329F08
	strb r0,[r1,#0x0]	; 02329F0A
loc_02329F0C:
	add r0,r5,#0x0	; 02329F0C
	add r0,#0x2d	; 02329F0E
	ldrb r0,[r0,#0x0]	; 02329F10
	cmp r0,#0x0	; 02329F12
	beq loc_02329F30	; 02329F14
	add r0,r5,#0x0	; 02329F16
	add r0,#0x3c	; 02329F18
	ldrb r0,[r0,#0x0]	; 02329F1A
	mov r1,#0x1	; 02329F1C
	lsl r1,r0	; 02329F1E
	ldr r0,[sp,#0x4]	; 02329F20
	and r0,r1	; 02329F22
	cmp r0,#0x0	; 02329F24
	bne loc_02329F30	; 02329F26
	add r0,r5,#0x0	; 02329F28
	bl loc_02329B04	; 02329F2A
	b loc_02329FA0	; 02329F2E
loc_02329F30:
	add r0,r5,#0x0	; 02329F30
	add r0,#0x1c	; 02329F32
	bl loc_0232AB50	; 02329F34
	add r0,r5,#0x0	; 02329F38
	add r0,#0x41	; 02329F3A
	ldrb r0,[r0,#0x0]	; 02329F3C
	lsl r0,r0,#0x1	; 02329F3E
	ldrsh r4,[r7,r0]	; 02329F40
	add r0,r5,#0x0	; 02329F42
	add r0,#0x40	; 02329F44
	ldrb r0,[r0,#0x0]	; 02329F46
	lsl r0,r0,#0x1	; 02329F48
	ldrsh r6,[r7,r0]	; 02329F4A
	add r0,r5,#0x0	; 02329F4C
	add r0,#0x1c	; 02329F4E
	bl loc_0232AB64	; 02329F50
	asr r0,r0,#0x8	; 02329F54
	lsl r0,r0,#0x1	; 02329F56
	ldrsh r1,[r7,r0]	; 02329F58
	add r0,r6,r4	; 02329F5A
	add r4,r1,r0	; 02329F5C
	ldr r0,[pool_02329FB8]	; 02329F5E
	cmp r4,r0	; 02329F60
	bge loc_02329F68	; 02329F62
	lsl r4,r0,#0	; 02329F64
	b loc_02329F6E	; 02329F66
loc_02329F68:
	cmp r4,#0x0	; 02329F68
	ble loc_02329F6E	; 02329F6A
	mov r4,#0x0	; 02329F6C
loc_02329F6E:
	mov r0,#0x3e	; 02329F6E
	ldrsh r0,[r5,r0]	; 02329F70
	cmp r4,r0	; 02329F72
	beq loc_02329F84	; 02329F74
	add r0,r5,#0x0	; 02329F76
	add r0,#0x3c	; 02329F78
	ldrb r0,[r0,#0x0]	; 02329F7A
	add r1,r4,#0x0	; 02329F7C
	bl loc_0232E680	; 02329F7E
	strh r4,[r5,#0x3e]	; 02329F82
loc_02329F84:
	add r0,r5,#0x0	; 02329F84
	add r0,#0x2c	; 02329F86
	ldrb r0,[r0,#0x0]	; 02329F88
	cmp r0,#0x2	; 02329F8A
	bne loc_02329FA0	; 02329F8C
	add r0,r5,#0x0	; 02329F8E
	add r0,#0x1c	; 02329F90
	bl loc_0232AB40	; 02329F92
	cmp r0,#0x0	; 02329F96
	beq loc_02329FA0	; 02329F98
	add r0,r5,#0x0	; 02329F9A
	bl loc_02329BBC	; 02329F9C
loc_02329FA0:
	ldr r5,[sp,#0x0]	; 02329FA0
	lsl r0,r5,#0	; 02329FA2
	cmp r0,#0x0	; 02329FA4
	bne loc_02329EE6	; 02329FA6
loc_02329FA8:
	add sp,#0xc	; 02329FA8
	pop {r4,r5,r6,r7}	; 02329FAA
	pop {r3}	; 02329FAC
	bx r3	; 02329FAE
pool_02329FB0:
loc_02329FB0:
	.word 0x023568B4	; 02329FB0
pool_02329FB4:
loc_02329FB4:
	.word 0x023308A4	; 02329FB4
pool_02329FB8:
loc_02329FB8:
	.word 0xFFFFFD2D	; 02329FB8

; ===== function loc_02329FBC =====
loc_02329FBC:
	push {r4,r5,r6,r7,lr}	; 02329FBC
	sub sp,#0x4	; 02329FBE
	ldr r0,[pool_0232A020]	; 02329FC0
	mov r1,#0x14	; 02329FC2
	bl loc_02329294	; 02329FC4
	ldr r0,[pool_0232A024]	; 02329FC8
	mov r1,#0x14	; 02329FCA
	bl loc_02329294	; 02329FCC
	mov r5,#0x0	; 02329FD0
	ldr r4,[pool_0232A028]	; 02329FD2
	add r6,r5,#0x0	; 02329FD4
	ldr r7,[pool_0232A024]	; 02329FD6
loc_02329FD8:
	add r0,r4,#0x0	; 02329FD8
	add r0,#0x2c	; 02329FDA
	strb r6,[r0,#0x0]	; 02329FDC
	add r0,r4,#0x0	; 02329FDE
	add r0,#0x3c	; 02329FE0
	strb r5,[r0,#0x0]	; 02329FE2
	add r0,r7,#0x0	; 02329FE4
	add r1,r4,#0x0	; 02329FE6
	bl loc_0232923C	; 02329FE8
	add r4,#0x44	; 02329FEC
	add r5,r5,#0x1	; 02329FEE
	cmp r5,#0x10	; 02329FF0
	blt loc_02329FD8	; 02329FF2
	mov r4,#0x0	; 02329FF4
	ldr r5,[pool_0232A02C]	; 02329FF6
	add r6,r4,#0x0	; 02329FF8
	mov r7,#0x1	; 02329FFA
loc_02329FFC:
	add r0,r5,#0x0	; 02329FFC
	mov r1,#0xc	; 02329FFE
	bl loc_02329294	; 0232A000
	add r0,r5,#0x0	; 0232A004
	add r0,#0xc	; 0232A006
	add r1,r6,#0x0	; 0232A008
	bl loc_02329294	; 0232A00A
	str r7,[r5,#0x18]	; 0232A00E
	add r5,#0x1c	; 0232A010
	add r4,r4,#0x1	; 0232A012
	cmp r4,#0x20	; 0232A014
	blt loc_02329FFC	; 0232A016
	add sp,#0x4	; 0232A018
	pop {r4,r5,r6,r7}	; 0232A01A
	pop {r3}	; 0232A01C
	bx r3	; 0232A01E
pool_0232A020:
loc_0232A020:
	.word 0x023568B4	; 0232A020
pool_0232A024:
loc_0232A024:
	.word 0x023568A8	; 0232A024
pool_0232A028:
loc_0232A028:
	.word P1_BssStart + 0x25DC0	; 0232A028
pool_0232A02C:
loc_0232A02C:
	.word 0x023568C0	; 0232A02C

; ===== function loc_0232A030 =====
	push {r4,r5,r6,r7,lr}	; 0232A030
	sub sp,#0xc	; 0232A032
	add r5,r0,#0x0	; 0232A034
	ldr r0,[r5,#0x14]	; 0232A036
	ldr r1,[r5,#0x2c]	; 0232A038
	blx P1_SignedDivMod	; 0232A03A
	str r0,[sp,#0x4]	; 0232A03E
	ldr r0,[r5,#0x18]	; 0232A040
	ldr r4,[sp,#0x4]	; 0232A042
	mul r4,r0	; 0232A044
	ldr r0,[r5,#0xc]	; 0232A046
	add r6,r0,r4	; 0232A048
	ldr r0,[r5,#0x10]	; 0232A04A
	add r7,r0,r4	; 0232A04C
	add r0,r6,#0x0	; 0232A04E
	ldr r1,[sp,#0x4]	; 0232A050
	blx P1_InvalidateDataCacheRange	; 0232A052
	add r0,r7,#0x0	; 0232A056
	ldr r1,[sp,#0x4]	; 0232A058
	blx P1_InvalidateDataCacheRange	; 0232A05A
	ldr r0,[pool_0232A0C8]	; 0232A05E
	ldr r0,[r0,#0x0]	; 0232A060
	cmp r0,#0x0	; 0232A062
	beq loc_0232A098	; 0232A064
	ldr r2,[pool_0232A0CC]	; 0232A066
	ldr r0,[pool_0232A0D0]	; 0232A068
	ldr r0,[r0,#0x0]	; 0232A06A
	mov r1,#0x14	; 0232A06C
	mul r0,r1	; 0232A06E
	add r1,r2,r0	; 0232A070
	str r5,[r2,r0]	; 0232A072
	ldr r0,[sp,#0x4]	; 0232A074
	str r0,[r1,#0x4]	; 0232A076
	str r4,[r1,#0x8]	; 0232A078
	str r6,[r1,#0xc]	; 0232A07A
	str r7,[r1,#0x10]	; 0232A07C
	ldr r0,[pool_0232A0D4]	; 0232A07E
	mov r2,#0x0	; 0232A080
	bl loc_0232B6A0	; 0232A082
	ldr r0,[pool_0232A0D0]	; 0232A086
	ldr r1,[r0,#0x0]	; 0232A088
	add r1,r1,#0x1	; 0232A08A
	str r1,[r0,#0x0]	; 0232A08C
	cmp r1,#0x8	; 0232A08E
	blt loc_0232A0A8	; 0232A090
	mov r1,#0x0	; 0232A092
	str r1,[r0,#0x0]	; 0232A094
	b loc_0232A0A8	; 0232A096
loc_0232A098:
	ldr r0,[r5,#0x34]	; 0232A098
	str r0,[sp,#0x0]	; 0232A09A
	add r0,r6,#0x0	; 0232A09C
	add r1,r7,#0x0	; 0232A09E
	ldr r2,[sp,#0x4]	; 0232A0A0
	ldr r3,[r5,#0x8]	; 0232A0A2
	ldr r4,[r5,#0x30]	; 0232A0A4
	blx r4	; 0232A0A6
loc_0232A0A8:
	add r1,r5,#0x0	; 0232A0A8
	add r1,#0x18	; 0232A0AA
	ldr r0,[r1,#0x0]	; 0232A0AC
	add r0,r0,#0x1	; 0232A0AE
	str r0,[r1,#0x0]	; 0232A0B0
	ldr r1,[r5,#0x18]	; 0232A0B2
	ldr r0,[r5,#0x2c]	; 0232A0B4
	cmp r1,r0	; 0232A0B6
	blt loc_0232A0BE	; 0232A0B8
	mov r0,#0x0	; 0232A0BA
	str r0,[r5,#0x18]	; 0232A0BC
loc_0232A0BE:
	add sp,#0xc	; 0232A0BE
	pop {r4,r5,r6,r7}	; 0232A0C0
	pop {r3}	; 0232A0C2
	bx r3	; 0232A0C4
	.byte 0xC0, 0x46	; 0232A0C8
pool_0232A0C8:
loc_0232A0C8:
	.word P1_BssStart + 0x26204	; 0232A0C8
pool_0232A0CC:
loc_0232A0CC:
	.word P1_BssStart + 0x2626C	; 0232A0CC
pool_0232A0D0:
loc_0232A0D0:
	.word P1_BssStart + 0x26200	; 0232A0D0
pool_0232A0D4:
loc_0232A0D4:
	.word 0x02357088	; 0232A0D4

; ===== function loc_0232A0D8 =====
loc_0232A0D8:
	push {r4,lr}	; 0232A0D8
	sub sp,#0x8	; 0232A0DA
	ldr r4,[pool_0232A134]	; 0232A0DC
	ldr r0,[r4,#0x0]	; 0232A0DE
	cmp r0,#0x0	; 0232A0E0
	beq loc_0232A12A	; 0232A0E2
	mov r0,#0x0	; 0232A0E4
	str r0,[r4,#0x18]	; 0232A0E6
	str r0,[sp,#0x0]	; 0232A0E8
	ldr r0,[sp,#0x0]	; 0232A0EA
	ldr r1,[r4,#0xc]	; 0232A0EC
	ldr r2,[r4,#0x14]	; 0232A0EE
	blx loc_0232E320	; 0232A0F0
	mov r0,#0x0	; 0232A0F4
	str r0,[sp,#0x4]	; 0232A0F6
	ldr r0,[sp,#0x4]	; 0232A0F8
	ldr r1,[r4,#0x10]	; 0232A0FA
	ldr r2,[r4,#0x14]	; 0232A0FC
	blx loc_0232E320	; 0232A0FE
	ldr r0,[r4,#0xc]	; 0232A102
	ldr r1,[r4,#0x14]	; 0232A104
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A106
	ldr r0,[r4,#0x10]	; 0232A10A
	ldr r1,[r4,#0x14]	; 0232A10C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A10E
	ldr r0,[r4,#0x28]	; 0232A112
	cmp r0,#0x0	; 0232A114
	blt loc_0232A11E	; 0232A116
	mov r2,#0x1	; 0232A118
	lsl r2,r0	; 0232A11A
	b loc_0232A120	; 0232A11C
loc_0232A11E:
	mov r2,#0x0	; 0232A11E
loc_0232A120:
	ldr r0,[r4,#0x20]	; 0232A120
	ldr r1,[r4,#0x24]	; 0232A122
	mov r3,#0x0	; 0232A124
	bl loc_0232E61C	; 0232A126
loc_0232A12A:
	add sp,#0x8	; 0232A12A
	pop {r4}	; 0232A12C
	pop {r3}	; 0232A12E
	bx r3	; 0232A130
	.byte 0xC0, 0x46	; 0232A134
pool_0232A134:
loc_0232A134:
	.word P1_BssStart + 0x2621C	; 0232A134

; ===== function loc_0232A138 =====
loc_0232A138:
	push {r4,lr}	; 0232A138
	ldr r1,[pool_0232A174]	; 0232A13A
	ldr r0,[r1,#0x0]	; 0232A13C
	cmp r0,#0x0	; 0232A13E
	beq loc_0232A16C	; 0232A140
	ldr r0,[r1,#0x28]	; 0232A142
	cmp r0,#0x0	; 0232A144
	blt loc_0232A14E	; 0232A146
	mov r2,#0x1	; 0232A148
	lsl r2,r0	; 0232A14A
	b loc_0232A150	; 0232A14C
loc_0232A14E:
	mov r2,#0x0	; 0232A14E
loc_0232A150:
	ldr r0,[r1,#0x20]	; 0232A150
	ldr r1,[r1,#0x24]	; 0232A152
	mov r3,#0x0	; 0232A154
	bl loc_0232E5D4	; 0232A156
	bl loc_0232E7EC	; 0232A15A
	add r4,r0,#0x0	; 0232A15E
	mov r0,#0x1	; 0232A160
	bl loc_0232E858	; 0232A162
	add r0,r4,#0x0	; 0232A166
	bl loc_0232E80C	; 0232A168
loc_0232A16C:
	pop {r4}	; 0232A16C
	pop {r3}	; 0232A16E
	bx r3	; 0232A170
	.byte 0xC0, 0x46	; 0232A174
pool_0232A174:
loc_0232A174:
	.word P1_BssStart + 0x2621C	; 0232A174

; ===== function loc_0232A178 =====
loc_0232A178:
	push {r4,r5,r6,r7,lr}	; 0232A178
	sub sp,#0x4	; 0232A17A
	ldr r4,[pool_0232A208]	; 0232A17C
	ldr r0,[r4,#0x28]	; 0232A17E
	cmp r0,#0x0	; 0232A180
	blt loc_0232A188	; 0232A182
	mov r5,#0x1	; 0232A184
	b loc_0232A18A	; 0232A186
loc_0232A188:
	mov r5,#0x0	; 0232A188
loc_0232A18A:
	cmp r5,#0x0	; 0232A18A
	beq loc_0232A196	; 0232A18C
	mov r2,#0x1	; 0232A18E
	ldr r0,[r4,#0x28]	; 0232A190
	lsl r2,r0	; 0232A192
	b loc_0232A198	; 0232A194
loc_0232A196:
	mov r2,#0x0	; 0232A196
loc_0232A198:
	ldr r0,[r4,#0x20]	; 0232A198
	ldr r1,[r4,#0x24]	; 0232A19A
	mov r3,#0x0	; 0232A19C
	bl loc_0232E5D4	; 0232A19E
	cmp r5,#0x0	; 0232A1A2
	beq loc_0232A1CA	; 0232A1A4
	bl loc_0232E7EC	; 0232A1A6
	add r6,r0,#0x0	; 0232A1AA
	mov r0,#0x1	; 0232A1AC
	bl loc_0232E858	; 0232A1AE
	add r0,r6,#0x0	; 0232A1B2
	bl loc_0232E80C	; 0232A1B4
	ldr r6,[pool_0232A20C]	; 0232A1B8
	mov r7,#0x0	; 0232A1BA
loc_0232A1BC:
	add r0,r6,#0x0	; 0232A1BC
	add r1,r7,#0x0	; 0232A1BE
	add r2,r7,#0x0	; 0232A1C0
	bl loc_0232B628	; 0232A1C2
	cmp r0,#0x0	; 0232A1C6
	bne loc_0232A1BC	; 0232A1C8
loc_0232A1CA:
	ldr r0,[r4,#0x24]	; 0232A1CA
	cmp r0,#0x0	; 0232A1CC
	beq loc_0232A1D4	; 0232A1CE
	bl loc_023299DC	; 0232A1D0
loc_0232A1D4:
	ldr r0,[r4,#0x1c]	; 0232A1D4
	cmp r0,#0x0	; 0232A1D6
	beq loc_0232A1DE	; 0232A1D8
	bl loc_02329A08	; 0232A1DA
loc_0232A1DE:
	cmp r5,#0x0	; 0232A1DE
	beq loc_0232A1E8	; 0232A1E0
	ldr r0,[r4,#0x28]	; 0232A1E2
	bl loc_0232999C	; 0232A1E4
loc_0232A1E8:
	ldr r0,[r4,#0x4]	; 0232A1E8
	cmp r0,#0x1	; 0232A1EA
	bne loc_0232A1FA	; 0232A1EC
	mov r0,#0x0	; 0232A1EE
	add r1,r0,#0x0	; 0232A1F0
	add r2,r0,#0x0	; 0232A1F2
	add r3,r0,#0x0	; 0232A1F4
	bl loc_0232E4BC	; 0232A1F6
loc_0232A1FA:
	mov r0,#0x0	; 0232A1FA
	str r0,[r4,#0x0]	; 0232A1FC
	add sp,#0x4	; 0232A1FE
	pop {r4,r5,r6,r7}	; 0232A200
	pop {r3}	; 0232A202
	bx r3	; 0232A204
	.byte 0xC0, 0x46	; 0232A208
pool_0232A208:
loc_0232A208:
	.word P1_BssStart + 0x2621C	; 0232A208
pool_0232A20C:
loc_0232A20C:
	.word 0x02357088	; 0232A20C

; ===== function loc_0232A210 =====
loc_0232A210:
	push {r4,r5,r6,r7,lr}	; 0232A210
	sub sp,#0x44	; 0232A212
	str r0,[sp,#0x18]	; 0232A214
	str r1,[sp,#0x1c]	; 0232A216
	str r2,[sp,#0x20]	; 0232A218
	str r3,[sp,#0x24]	; 0232A21A
	ldr r7,[sp,#0x64]	; 0232A21C
	ldr r0,[sp,#0x6c]	; 0232A21E
	str r0,[sp,#0x6c]	; 0232A220
	mov r0,#0x0	; 0232A222
	str r0,[sp,#0x30]	; 0232A224
	mvn r5,r0	; 0232A226
	ldr r4,[pool_0232A42C]	; 0232A228
	lsl r0,r1,#0	; 0232A22A
	lsl r1,r3,#0	; 0232A22C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A22E
	ldr r0,[sp,#0x20]	; 0232A232
	ldr r1,[sp,#0x24]	; 0232A234
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A236
	ldr r0,[sp,#0x58]	; 0232A23A
	cmp r0,#0x1	; 0232A23C
	bne loc_0232A244	; 0232A23E
	mov r6,#0x1	; 0232A240
	b loc_0232A246	; 0232A242
loc_0232A244:
	mov r6,#0x0	; 0232A244
loc_0232A246:
	ldr r0,[pool_0232A430]	; 0232A246
	ldr r1,[sp,#0x68]	; 0232A248
	blx P1_SignedDivMod	; 0232A24A
	str r0,[sp,#0x34]	; 0232A24E
	ldr r0,[sp,#0x7c]	; 0232A250
	cmp r0,#0x0	; 0232A252
	beq loc_0232A290	; 0232A254
	ldr r0,[sp,#0x24]	; 0232A256
	cmp r6,#0x0	; 0232A258
	bne loc_0232A25E	; 0232A25A
	asr r0,r0,#0x1	; 0232A25C
loc_0232A25E:
	ldr r1,[sp,#0x34]	; 0232A25E
	add r1,#0x10	; 0232A260
	str r1,[sp,#0x34]	; 0232A262
	mov r2,#0x1f	; 0232A264
	bic r1,r2	; 0232A266
	str r1,[sp,#0x34]	; 0232A268
	asr r1,r1,#0x5	; 0232A26A
	str r1,[sp,#0x40]	; 0232A26C
	ldr r1,[sp,#0x78]	; 0232A26E
	blx P1_SignedDivMod	; 0232A270
	ldr r1,[sp,#0x40]	; 0232A274
	str r1,[sp,#0x38]	; 0232A276
	mul r1,r0	; 0232A278
	str r1,[sp,#0x38]	; 0232A27A
	mov r0,#0x20	; 0232A27C
	str r0,[sp,#0x3c]	; 0232A27E
	cmp r6,#0x0	; 0232A280
	bne loc_0232A288	; 0232A282
	asr r0,r0,#0x1	; 0232A284
	str r0,[sp,#0x3c]	; 0232A286
loc_0232A288:
	ldr r1,[sp,#0x3c]	; 0232A288
	ldr r0,[sp,#0x40]	; 0232A28A
	mul r1,r0	; 0232A28C
	str r1,[sp,#0x3c]	; 0232A28E
loc_0232A290:
	cmp r6,#0x0	; 0232A290
	beq loc_0232A29A	; 0232A292
	mov r0,#0x0	; 0232A294
	str r0,[sp,#0x2c]	; 0232A296
	b loc_0232A29E	; 0232A298
loc_0232A29A:
	mov r0,#0x1	; 0232A29A
	str r0,[sp,#0x2c]	; 0232A29C
loc_0232A29E:
	cmp r6,#0x0	; 0232A29E
	beq loc_0232A2A8	; 0232A2A0
	mov r0,#0x1	; 0232A2A2
	str r0,[sp,#0x28]	; 0232A2A4
	b loc_0232A2AC	; 0232A2A6
loc_0232A2A8:
	mov r0,#0x0	; 0232A2A8
	str r0,[sp,#0x28]	; 0232A2AA
loc_0232A2AC:
	ldr r0,[sp,#0x18]	; 0232A2AC
	cmp r0,#0x2	; 0232A2AE
	beq loc_0232A2B6	; 0232A2B0
	mov r0,#0xa	; 0232A2B2
	str r0,[sp,#0x30]	; 0232A2B4
loc_0232A2B6:
	ldr r0,[sp,#0x7c]	; 0232A2B6
	cmp r0,#0x0	; 0232A2B8
	beq loc_0232A2D0	; 0232A2BA
	bl loc_023299B0	; 0232A2BC
	add r5,r0,#0x0	; 0232A2C0
	cmp r5,#0x0	; 0232A2C2
	bge loc_0232A2D0	; 0232A2C4
	mov r0,#0x0	; 0232A2C6
	add sp,#0x44	; 0232A2C8
	pop {r4,r5,r6,r7}	; 0232A2CA
	pop {r3}	; 0232A2CC
	bx r3	; 0232A2CE
loc_0232A2D0:
	mov r0,#0x3	; 0232A2D0
	bl loc_023299EC	; 0232A2D2
	cmp r0,#0x0	; 0232A2D6
	bne loc_0232A2EE	; 0232A2D8
	cmp r5,#0x0	; 0232A2DA
	blt loc_0232A2E4	; 0232A2DC
	add r0,r5,#0x0	; 0232A2DE
	bl loc_0232999C	; 0232A2E0
loc_0232A2E4:
	mov r0,#0x0	; 0232A2E4
	add sp,#0x44	; 0232A2E6
	pop {r4,r5,r6,r7}	; 0232A2E8
	pop {r3}	; 0232A2EA
	bx r3	; 0232A2EC
loc_0232A2EE:
	mov r0,#0xa	; 0232A2EE
	bl loc_02329A28	; 0232A2F0
	cmp r0,#0x0	; 0232A2F4
	bne loc_0232A312	; 0232A2F6
	cmp r5,#0x0	; 0232A2F8
	blt loc_0232A302	; 0232A2FA
	add r0,r5,#0x0	; 0232A2FC
	bl loc_0232999C	; 0232A2FE
loc_0232A302:
	mov r0,#0x3	; 0232A302
	bl loc_023299DC	; 0232A304
	mov r0,#0x0	; 0232A308
	add sp,#0x44	; 0232A30A
	pop {r4,r5,r6,r7}	; 0232A30C
	pop {r3}	; 0232A30E
	bx r3	; 0232A310
loc_0232A312:
	cmp r7,#0x0	; 0232A312
	beq loc_0232A31A	; 0232A314
	mov r3,#0x1	; 0232A316
	b loc_0232A31C	; 0232A318
loc_0232A31A:
	mov r3,#0x2	; 0232A31A
loc_0232A31C:
	ldr r0,[sp,#0x24]	; 0232A31C
	lsr r6,r0,#0x2	; 0232A31E
	mov r1,#0x0	; 0232A320
	str r1,[sp,#0x0]	; 0232A322
	str r6,[sp,#0x4]	; 0232A324
	ldr r0,[sp,#0x6c]	; 0232A326
	str r0,[sp,#0x8]	; 0232A328
	str r1,[sp,#0xc]	; 0232A32A
	ldr r0,[sp,#0x34]	; 0232A32C
	str r0,[sp,#0x10]	; 0232A32E
	ldr r0,[sp,#0x70]	; 0232A330
	str r0,[sp,#0x14]	; 0232A332
	mov r0,#0x1	; 0232A334
	ldr r1,[sp,#0x2c]	; 0232A336
	ldr r2,[sp,#0x1c]	; 0232A338
	bl loc_0232E4DC	; 0232A33A
	str r7,[sp,#0x0]	; 0232A33E
	ldr r0,[sp,#0x5c]	; 0232A340
	str r0,[sp,#0x4]	; 0232A342
	ldr r0,[sp,#0x60]	; 0232A344
	str r0,[sp,#0x8]	; 0232A346
	mov r0,#0x0	; 0232A348
	ldr r1,[sp,#0x28]	; 0232A34A
	ldr r2,[sp,#0x1c]	; 0232A34C
	add r3,r6,#0x0	; 0232A34E
	bl loc_0232E598	; 0232A350
	cmp r7,#0x0	; 0232A354
	beq loc_0232A35C	; 0232A356
	mov r3,#0x1	; 0232A358
	b loc_0232A35E	; 0232A35A
loc_0232A35C:
	mov r3,#0x2	; 0232A35C
loc_0232A35E:
	mov r1,#0x0	; 0232A35E
	str r1,[sp,#0x0]	; 0232A360
	str r6,[sp,#0x4]	; 0232A362
	ldr r0,[sp,#0x6c]	; 0232A364
	str r0,[sp,#0x8]	; 0232A366
	str r1,[sp,#0xc]	; 0232A368
	ldr r0,[sp,#0x34]	; 0232A36A
	str r0,[sp,#0x10]	; 0232A36C
	ldr r0,[sp,#0x74]	; 0232A36E
	str r0,[sp,#0x14]	; 0232A370
	mov r0,#0x3	; 0232A372
	ldr r1,[sp,#0x2c]	; 0232A374
	ldr r2,[sp,#0x20]	; 0232A376
	bl loc_0232E4DC	; 0232A378
	str r7,[sp,#0x0]	; 0232A37C
	ldr r0,[sp,#0x5c]	; 0232A37E
	str r0,[sp,#0x4]	; 0232A380
	ldr r0,[sp,#0x60]	; 0232A382
	str r0,[sp,#0x8]	; 0232A384
	mov r0,#0x1	; 0232A386
	ldr r1,[sp,#0x28]	; 0232A388
	ldr r2,[sp,#0x20]	; 0232A38A
	add r3,r6,#0x0	; 0232A38C
	bl loc_0232E598	; 0232A38E
	cmp r5,#0x0	; 0232A392
	blt loc_0232A3A6	; 0232A394
	str r4,[sp,#0x0]	; 0232A396
	add r0,r5,#0x0	; 0232A398
	ldr r2,[sp,#0x38]	; 0232A39A
	ldr r1,[sp,#0x3c]	; 0232A39C
	add r1,r2,r1	; 0232A39E
	ldr r3,[pool_0232A434]	; 0232A3A0
	bl loc_0232E570	; 0232A3A2
loc_0232A3A6:
	ldr r0,[sp,#0x18]	; 0232A3A6
	cmp r0,#0x1	; 0232A3A8
	bne loc_0232A3B8	; 0232A3AA
	mov r0,#0x3	; 0232A3AC
	add r1,r0,#0x0	; 0232A3AE
	mov r2,#0x1	; 0232A3B0
	add r3,r2,#0x0	; 0232A3B2
	bl loc_0232E4BC	; 0232A3B4
loc_0232A3B8:
	cmp r5,#0x0	; 0232A3B8
	blt loc_0232A3C2	; 0232A3BA
	mov r2,#0x1	; 0232A3BC
	lsl r2,r5	; 0232A3BE
	b loc_0232A3C4	; 0232A3C0
loc_0232A3C2:
	mov r2,#0x0	; 0232A3C2
loc_0232A3C4:
	ldr r0,[sp,#0x30]	; 0232A3C4
	mov r1,#0x3	; 0232A3C6
	mov r3,#0x0	; 0232A3C8
	bl loc_0232E61C	; 0232A3CA
	mov r0,#0x1	; 0232A3CE
	str r0,[r4,#0x0]	; 0232A3D0
	ldr r0,[sp,#0x18]	; 0232A3D2
	str r0,[r4,#0x4]	; 0232A3D4
	mov r0,#0xa	; 0232A3D6
	str r0,[r4,#0x1c]	; 0232A3D8
	ldr r0,[sp,#0x30]	; 0232A3DA
	str r0,[r4,#0x20]	; 0232A3DC
	mov r0,#0x3	; 0232A3DE
	str r0,[r4,#0x24]	; 0232A3E0
	str r5,[r4,#0x28]	; 0232A3E2
	ldr r0,[sp,#0x58]	; 0232A3E4
	str r0,[r4,#0x8]	; 0232A3E6
	ldr r0,[sp,#0x1c]	; 0232A3E8
	str r0,[r4,#0xc]	; 0232A3EA
	ldr r0,[sp,#0x20]	; 0232A3EC
	str r0,[r4,#0x10]	; 0232A3EE
	ldr r0,[sp,#0x24]	; 0232A3F0
	str r0,[r4,#0x14]	; 0232A3F2
	mov r0,#0x0	; 0232A3F4
	str r0,[r4,#0x18]	; 0232A3F6
	ldr r0,[sp,#0x78]	; 0232A3F8
	str r0,[r4,#0x2c]	; 0232A3FA
	ldr r0,[sp,#0x7c]	; 0232A3FC
	str r0,[r4,#0x30]	; 0232A3FE
	ldr r0,[sp,#0x80]	; 0232A400
	str r0,[r4,#0x34]	; 0232A402
	ldr r0,[sp,#0x6c]	; 0232A404
	str r0,[r4,#0x4c]	; 0232A406
	add r0,r4,#0x0	; 0232A408
	add r0,#0x38	; 0232A40A
	bl loc_0232ABA8	; 0232A40C
	add r0,r4,#0x0	; 0232A410
	add r0,#0x38	; 0232A412
	ldr r1,[sp,#0x6c]	; 0232A414
	lsl r1,r1,#0x8	; 0232A416
	mov r2,#0x1	; 0232A418
	bl loc_0232AB8C	; 0232A41A
	mov r0,#0x0	; 0232A41E
	str r0,[r4,#0x48]	; 0232A420
	mov r0,#0x1	; 0232A422
	add sp,#0x44	; 0232A424
	pop {r4,r5,r6,r7}	; 0232A426
	pop {r3}	; 0232A428
	bx r3	; 0232A42A
pool_0232A42C:
loc_0232A42C:
	.word 0x0235709C	; 0232A42C
pool_0232A430:
loc_0232A430:
	.word 0x00FFB0FF	; 0232A430
pool_0232A434:
loc_0232A434:
	.word 0x0232A031	; 0232A434

; ===== function loc_0232A438 =====
loc_0232A438:
	push {lr}	; 0232A438
	sub sp,#0x4	; 0232A43A
	ldr r0,[pool_0232A454]	; 0232A43C
	ldr r1,[r0,#0x0]	; 0232A43E
	cmp r1,#0x0	; 0232A440
	beq loc_0232A44E	; 0232A442
	ldr r0,[r0,#0x4]	; 0232A444
	cmp r0,#0x1	; 0232A446
	bne loc_0232A44E	; 0232A448
	bl loc_0232A178	; 0232A44A
loc_0232A44E:
	add sp,#0x4	; 0232A44E
	pop {r3}	; 0232A450
	bx r3	; 0232A452
pool_0232A454:
loc_0232A454:
	.word P1_BssStart + 0x2621C	; 0232A454

; ===== function loc_0232A458 =====
loc_0232A458:
	push {r4,r5,r6,r7,lr}	; 0232A458
	sub sp,#0x34	; 0232A45A
	add r5,r0,#0x0	; 0232A45C
	add r4,r1,#0x0	; 0232A45E
	add r6,r2,#0x0	; 0232A460
	add r7,r3,#0x0	; 0232A462
	bl loc_0232A438	; 0232A464
	ldr r0,[pool_0232A4C4]	; 0232A468
	ldr r0,[r0,#0x0]	; 0232A46A
	cmp r0,#0x0	; 0232A46C
	beq loc_0232A47A	; 0232A46E
	mov r0,#0x0	; 0232A470
	add sp,#0x34	; 0232A472
	pop {r4,r5,r6,r7}	; 0232A474
	pop {r3}	; 0232A476
	bx r3	; 0232A478
loc_0232A47A:
	mov r0,#0x0	; 0232A47A
	str r0,[sp,#0x2c]	; 0232A47C
	ldr r0,[sp,#0x2c]	; 0232A47E
	add r1,r5,#0x0	; 0232A480
	add r2,r4,#0x0	; 0232A482
	blx loc_0232E320	; 0232A484
	add r0,r5,#0x0	; 0232A488
	add r1,r4,#0x0	; 0232A48A
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A48C
	lsr r3,r4,#0x1	; 0232A490
	str r6,[sp,#0x0]	; 0232A492
	mov r2,#0x0	; 0232A494
	str r2,[sp,#0x4]	; 0232A496
	str r2,[sp,#0x8]	; 0232A498
	mov r0,#0x1	; 0232A49A
	str r0,[sp,#0xc]	; 0232A49C
	str r7,[sp,#0x10]	; 0232A49E
	mov r1,#0x7f	; 0232A4A0
	str r1,[sp,#0x14]	; 0232A4A2
	str r2,[sp,#0x18]	; 0232A4A4
	str r1,[sp,#0x1c]	; 0232A4A6
	ldr r1,[sp,#0x48]	; 0232A4A8
	str r1,[sp,#0x20]	; 0232A4AA
	ldr r1,[sp,#0x4c]	; 0232A4AC
	str r1,[sp,#0x24]	; 0232A4AE
	ldr r1,[sp,#0x50]	; 0232A4B0
	str r1,[sp,#0x28]	; 0232A4B2
	add r1,r5,#0x0	; 0232A4B4
	add r2,r5,r3	; 0232A4B6
	bl loc_0232A210	; 0232A4B8
	add sp,#0x34	; 0232A4BC
	pop {r4,r5,r6,r7}	; 0232A4BE
	pop {r3}	; 0232A4C0
	bx r3	; 0232A4C2
pool_0232A4C4:
loc_0232A4C4:
	.word P1_BssStart + 0x2621C	; 0232A4C4

; ===== function loc_0232A4C8 =====
loc_0232A4C8:
	push {r4,r5,lr}	; 0232A4C8
	sub sp,#0x4	; 0232A4CA
	ldr r4,[pool_0232A524]	; 0232A4CC
	ldr r0,[r4,#0x0]	; 0232A4CE
	cmp r0,#0x0	; 0232A4D0
	beq loc_0232A51A	; 0232A4D2
	ldr r0,[r4,#0x4]	; 0232A4D4
	cmp r0,#0x0	; 0232A4D6
	bne loc_0232A51A	; 0232A4D8
	add r5,r4,#0x0	; 0232A4DA
	add r5,#0x38	; 0232A4DC
	add r0,r5,#0x0	; 0232A4DE
	bl loc_0232AB50	; 0232A4E0
	ldr r0,[r4,#0x48]	; 0232A4E4
	cmp r0,#0x0	; 0232A4E6
	beq loc_0232A500	; 0232A4E8
	add r0,r5,#0x0	; 0232A4EA
	bl loc_0232AB40	; 0232A4EC
	cmp r0,#0x0	; 0232A4F0
	beq loc_0232A500	; 0232A4F2
	bl loc_0232A178	; 0232A4F4
	add sp,#0x4	; 0232A4F8
	pop {r4,r5}	; 0232A4FA
	pop {r3}	; 0232A4FC
	bx r3	; 0232A4FE
loc_0232A500:
	add r0,r5,#0x0	; 0232A500
	bl loc_0232AB64	; 0232A502
	asr r5,r0,#0x8	; 0232A506
	ldr r0,[r4,#0x4c]	; 0232A508
	cmp r5,r0	; 0232A50A
	beq loc_0232A51A	; 0232A50C
	ldr r0,[r4,#0x20]	; 0232A50E
	add r1,r5,#0x0	; 0232A510
	mov r2,#0x0	; 0232A512
	bl loc_0232E518	; 0232A514
	str r5,[r4,#0x4c]	; 0232A518
loc_0232A51A:
	add sp,#0x4	; 0232A51A
	pop {r4,r5}	; 0232A51C
	pop {r3}	; 0232A51E
	bx r3	; 0232A520
	.byte 0xC0, 0x46	; 0232A524
pool_0232A524:
loc_0232A524:
	.word P1_BssStart + 0x2621C	; 0232A524

; ===== function loc_0232A528 =====
loc_0232A528:
	mov r1,#0x0	; 0232A528
	ldr r0,[pool_0232A534]	; 0232A52A
	str r1,[r0,#0x0]	; 0232A52C
	ldr r0,[pool_0232A538]	; 0232A52E
	str r1,[r0,#0x0]	; 0232A530
	bx lr	; 0232A532
pool_0232A534:
loc_0232A534:
	.word P1_BssStart + 0x26204	; 0232A534
pool_0232A538:
loc_0232A538:
	.word P1_BssStart + 0x2621C	; 0232A538

; ===== function loc_0232A53C =====
loc_0232A53C:
	ldr r1,[pool_0232A554]	; 0232A53C
	ldr r1,[r1,#0x0]	; 0232A53E
	ldr r2,[r1,#0x7c]	; 0232A540
	ldr r1,[r2,#0x8]	; 0232A542
	cmp r0,r1	; 0232A544
	bcc loc_0232A54C	; 0232A546
	mov r0,#0x0	; 0232A548
	bx lr	; 0232A54A
loc_0232A54C:
	lsl r0,r0,#0x4	; 0232A54C
	add r0,r2,r0	; 0232A54E
	ldr r0,[r0,#0x14]	; 0232A550
	bx lr	; 0232A552
pool_0232A554:
loc_0232A554:
	.word P1_BssStart + 0x2630C	; 0232A554

; ===== function loc_0232A558 =====
loc_0232A558:
	ldr r1,[pool_0232A5A0]	; 0232A558
	ldr r1,[r1,#0x0]	; 0232A55A
	add r2,r1,#0x0	; 0232A55C
	add r2,#0x84	; 0232A55E
	ldr r3,[r2,#0x0]	; 0232A560
	ldr r2,[r3,#0x18]	; 0232A562
	cmp r2,#0x0	; 0232A564
	bne loc_0232A56C	; 0232A566
	mov r3,#0x0	; 0232A568
	b loc_0232A56E	; 0232A56A
loc_0232A56C:
	add r3,r3,r2	; 0232A56C
loc_0232A56E:
	cmp r3,#0x0	; 0232A56E
	bne loc_0232A576	; 0232A570
	mov r0,#0x0	; 0232A572
	bx lr	; 0232A574
loc_0232A576:
	cmp r0,#0x0	; 0232A576
	bge loc_0232A57E	; 0232A578
	mov r0,#0x0	; 0232A57A
	bx lr	; 0232A57C
loc_0232A57E:
	ldr r2,[r3,#0x0]	; 0232A57E
	cmp r0,r2	; 0232A580
	bcc loc_0232A588	; 0232A582
	mov r0,#0x0	; 0232A584
	bx lr	; 0232A586
loc_0232A588:
	lsl r0,r0,#0x2	; 0232A588
	add r0,r3,r0	; 0232A58A
	ldr r2,[r0,#0x4]	; 0232A58C
	add r1,#0x84	; 0232A58E
	ldr r0,[r1,#0x0]	; 0232A590
	cmp r2,#0x0	; 0232A592
	bne loc_0232A59A	; 0232A594
	mov r0,#0x0	; 0232A596
	bx lr	; 0232A598
loc_0232A59A:
	add r0,r0,r2	; 0232A59A
	bx lr	; 0232A59C
	.byte 0xC0, 0x46	; 0232A5A0
pool_0232A5A0:
loc_0232A5A0:
	.word P1_BssStart + 0x2630C	; 0232A5A0

; ===== function loc_0232A5A4 =====
loc_0232A5A4:
	ldr r1,[pool_0232A5EC]	; 0232A5A4
	ldr r1,[r1,#0x0]	; 0232A5A6
	add r2,r1,#0x0	; 0232A5A8
	add r2,#0x84	; 0232A5AA
	ldr r3,[r2,#0x0]	; 0232A5AC
	ldr r2,[r3,#0x14]	; 0232A5AE
	cmp r2,#0x0	; 0232A5B0
	bne loc_0232A5B8	; 0232A5B2
	mov r3,#0x0	; 0232A5B4
	b loc_0232A5BA	; 0232A5B6
loc_0232A5B8:
	add r3,r3,r2	; 0232A5B8
loc_0232A5BA:
	cmp r3,#0x0	; 0232A5BA
	bne loc_0232A5C2	; 0232A5BC
	mov r0,#0x0	; 0232A5BE
	bx lr	; 0232A5C0
loc_0232A5C2:
	cmp r0,#0x0	; 0232A5C2
	bge loc_0232A5CA	; 0232A5C4
	mov r0,#0x0	; 0232A5C6
	bx lr	; 0232A5C8
loc_0232A5CA:
	ldr r2,[r3,#0x0]	; 0232A5CA
	cmp r0,r2	; 0232A5CC
	bcc loc_0232A5D4	; 0232A5CE
	mov r0,#0x0	; 0232A5D0
	bx lr	; 0232A5D2
loc_0232A5D4:
	lsl r0,r0,#0x2	; 0232A5D4
	add r0,r3,r0	; 0232A5D6
	ldr r2,[r0,#0x4]	; 0232A5D8
	add r1,#0x84	; 0232A5DA
	ldr r0,[r1,#0x0]	; 0232A5DC
	cmp r2,#0x0	; 0232A5DE
	bne loc_0232A5E6	; 0232A5E0
	mov r0,#0x0	; 0232A5E2
	bx lr	; 0232A5E4
loc_0232A5E6:
	add r0,r0,r2	; 0232A5E6
	bx lr	; 0232A5E8
	.byte 0xC0, 0x46	; 0232A5EC
pool_0232A5EC:
loc_0232A5EC:
	.word P1_BssStart + 0x2630C	; 0232A5EC

; ===== function loc_0232A5F0 =====
loc_0232A5F0:
	ldr r1,[pool_0232A638]	; 0232A5F0
	ldr r1,[r1,#0x0]	; 0232A5F2
	add r2,r1,#0x0	; 0232A5F4
	add r2,#0x84	; 0232A5F6
	ldr r3,[r2,#0x0]	; 0232A5F8
	ldr r2,[r3,#0x10]	; 0232A5FA
	cmp r2,#0x0	; 0232A5FC
	bne loc_0232A604	; 0232A5FE
	mov r3,#0x0	; 0232A600
	b loc_0232A606	; 0232A602
loc_0232A604:
	add r3,r3,r2	; 0232A604
loc_0232A606:
	cmp r3,#0x0	; 0232A606
	bne loc_0232A60E	; 0232A608
	mov r0,#0x0	; 0232A60A
	bx lr	; 0232A60C
loc_0232A60E:
	cmp r0,#0x0	; 0232A60E
	bge loc_0232A616	; 0232A610
	mov r0,#0x0	; 0232A612
	bx lr	; 0232A614
loc_0232A616:
	ldr r2,[r3,#0x0]	; 0232A616
	cmp r0,r2	; 0232A618
	bcc loc_0232A620	; 0232A61A
	mov r0,#0x0	; 0232A61C
	bx lr	; 0232A61E
loc_0232A620:
	lsl r0,r0,#0x2	; 0232A620
	add r0,r3,r0	; 0232A622
	ldr r2,[r0,#0x4]	; 0232A624
	add r1,#0x84	; 0232A626
	ldr r0,[r1,#0x0]	; 0232A628
	cmp r2,#0x0	; 0232A62A
	bne loc_0232A632	; 0232A62C
	mov r0,#0x0	; 0232A62E
	bx lr	; 0232A630
loc_0232A632:
	add r0,r0,r2	; 0232A632
	bx lr	; 0232A634
	.byte 0xC0, 0x46	; 0232A638
pool_0232A638:
loc_0232A638:
	.word P1_BssStart + 0x2630C	; 0232A638

; ===== function loc_0232A63C =====
loc_0232A63C:
	ldr r1,[pool_0232A684]	; 0232A63C
	ldr r1,[r1,#0x0]	; 0232A63E
	add r2,r1,#0x0	; 0232A640
	add r2,#0x84	; 0232A642
	ldr r3,[r2,#0x0]	; 0232A644
	ldr r2,[r3,#0xc]	; 0232A646
	cmp r2,#0x0	; 0232A648
	bne loc_0232A650	; 0232A64A
	mov r3,#0x0	; 0232A64C
	b loc_0232A652	; 0232A64E
loc_0232A650:
	add r3,r3,r2	; 0232A650
loc_0232A652:
	cmp r3,#0x0	; 0232A652
	bne loc_0232A65A	; 0232A654
	mov r0,#0x0	; 0232A656
	bx lr	; 0232A658
loc_0232A65A:
	cmp r0,#0x0	; 0232A65A
	bge loc_0232A662	; 0232A65C
	mov r0,#0x0	; 0232A65E
	bx lr	; 0232A660
loc_0232A662:
	ldr r2,[r3,#0x0]	; 0232A662
	cmp r0,r2	; 0232A664
	bcc loc_0232A66C	; 0232A666
	mov r0,#0x0	; 0232A668
	bx lr	; 0232A66A
loc_0232A66C:
	lsl r0,r0,#0x2	; 0232A66C
	add r0,r3,r0	; 0232A66E
	ldr r2,[r0,#0x4]	; 0232A670
	add r1,#0x84	; 0232A672
	ldr r0,[r1,#0x0]	; 0232A674
	cmp r2,#0x0	; 0232A676
	bne loc_0232A67E	; 0232A678
	mov r0,#0x0	; 0232A67A
	bx lr	; 0232A67C
loc_0232A67E:
	add r0,r0,r2	; 0232A67E
	bx lr	; 0232A680
	.byte 0xC0, 0x46	; 0232A684
pool_0232A684:
loc_0232A684:
	.word P1_BssStart + 0x2630C	; 0232A684

; ===== function loc_0232A688 =====
loc_0232A688:
	ldr r0,[pool_0232A690]	; 0232A688
	ldr r0,[r0,#0x0]	; 0232A68A
	bx lr	; 0232A68C
	.byte 0xC0, 0x46	; 0232A690
pool_0232A690:
loc_0232A690:
	.word P1_BssStart + 0x2630C	; 0232A690

; ===== function loc_0232A694 =====
loc_0232A694:
	push {r4,r5,r6,r7,lr}	; 0232A694
	sub sp,#0x4	; 0232A696
	add r5,r0,#0x0	; 0232A698
	add r4,r1,#0x0	; 0232A69A
	add r0,r4,#0x0	; 0232A69C
	add r1,r5,#0x0	; 0232A69E
	mov r2,#0x30	; 0232A6A0
	blx loc_0232E334	; 0232A6A2
	ldr r0,[r5,#0x18]	; 0232A6A6
	cmp r0,#0x0	; 0232A6A8
	bne loc_0232A6B0	; 0232A6AA
	mov r1,#0x0	; 0232A6AC
	b loc_0232A6B2	; 0232A6AE
loc_0232A6B0:
	add r1,r4,r0	; 0232A6B0
loc_0232A6B2:
	add r0,r5,#0x0	; 0232A6B2
	add r0,#0x84	; 0232A6B4
	str r1,[r0,#0x0]	; 0232A6B6
	ldr r0,[r5,#0x20]	; 0232A6B8
	cmp r0,#0x0	; 0232A6BA
	bne loc_0232A6C2	; 0232A6BC
	mov r0,#0x0	; 0232A6BE
	b loc_0232A6C4	; 0232A6C0
loc_0232A6C2:
	add r0,r4,r0	; 0232A6C2
loc_0232A6C4:
	str r0,[r5,#0x7c]	; 0232A6C4
	ldr r0,[r5,#0x10]	; 0232A6C6
	cmp r0,#0x0	; 0232A6C8
	bne loc_0232A6D0	; 0232A6CA
	mov r1,#0x0	; 0232A6CC
	b loc_0232A6D2	; 0232A6CE
loc_0232A6D0:
	add r1,r4,r0	; 0232A6D0
loc_0232A6D2:
	add r0,r5,#0x0	; 0232A6D2
	add r0,#0x80	; 0232A6D4
	str r1,[r0,#0x0]	; 0232A6D6
	mov r0,#0x0	; 0232A6D8
	ldr r3,[r5,#0x7c]	; 0232A6DA
	ldr r1,[r3,#0x8]	; 0232A6DC
	cmp r1,#0x0	; 0232A6DE
	bls loc_0232A704	; 0232A6E0
	add r6,r0,#0x0	; 0232A6E2
	add r2,r0,#0x0	; 0232A6E4
loc_0232A6E6:
	add r3,#0xc	; 0232A6E6
	add r7,r3,r6	; 0232A6E8
	ldr r1,[r3,r6]	; 0232A6EA
	cmp r1,#0x0	; 0232A6EC
	bne loc_0232A6F4	; 0232A6EE
	add r1,r2,#0x0	; 0232A6F0
	b loc_0232A6F6	; 0232A6F2
loc_0232A6F4:
	add r1,r4,r1	; 0232A6F4
loc_0232A6F6:
	str r1,[r7,#0x8]	; 0232A6F6
	add r6,#0x10	; 0232A6F8
	add r0,r0,#0x1	; 0232A6FA
	ldr r3,[r5,#0x7c]	; 0232A6FC
	ldr r1,[r3,#0x8]	; 0232A6FE
	cmp r0,r1	; 0232A700
	bcc loc_0232A6E6	; 0232A702
loc_0232A704:
	ldr r0,[pool_0232A710]	; 0232A704
	str r5,[r0,#0x0]	; 0232A706
	add sp,#0x4	; 0232A708
	pop {r4,r5,r6,r7}	; 0232A70A
	pop {r3}	; 0232A70C
	bx r3	; 0232A70E
pool_0232A710:
loc_0232A710:
	.word P1_BssStart + 0x2630C	; 0232A710

; ===== function loc_0232A714 =====
loc_0232A714:
	push {r4,lr}	; 0232A714
	bl loc_0232E7EC	; 0232A716
	add r4,r0,#0x0	; 0232A71A
	mov r0,#0x1	; 0232A71C
	bl loc_0232E858	; 0232A71E
	add r0,r4,#0x0	; 0232A722
	bl loc_0232E80C	; 0232A724
	pop {r4}	; 0232A728
	pop {r3}	; 0232A72A
	bx r3	; 0232A72C
	.byte 0x00, 0x00	; 0232A730

; ===== function loc_0232A730 =====
loc_0232A730:
	push {r4,r5,lr}	; 0232A730
	sub sp,#0x4	; 0232A732
	add r5,r0,#0x0	; 0232A734
	ldr r0,[r5,#0x0]	; 0232A736
	mov r1,#0x14	; 0232A738
	mov r2,#0x4	; 0232A73A
	bl loc_023297B8	; 0232A73C
	add r4,r0,#0x0	; 0232A740
	cmp r4,#0x0	; 0232A742
	bne loc_0232A750	; 0232A744
	mov r0,#0x0	; 0232A746
	add sp,#0x4	; 0232A748
	pop {r4,r5}	; 0232A74A
	pop {r3}	; 0232A74C
	bx r3	; 0232A74E
loc_0232A750:
	bl loc_0232A798	; 0232A750
	add r0,r5,#0x4	; 0232A754
	add r1,r4,#0x0	; 0232A756
	bl loc_0232923C	; 0232A758
	mov r0,#0x1	; 0232A75C
	add sp,#0x4	; 0232A75E
	pop {r4,r5}	; 0232A760
	pop {r3}	; 0232A762
	bx r3	; 0232A764
	.byte 0x00, 0x00	; 0232A768

; ===== function loc_0232A768 =====
loc_0232A768:
	push {r4,r5,lr}	; 0232A768
	sub sp,#0x4	; 0232A76A
	add r5,r0,#0x0	; 0232A76C
	add r4,r1,#0x0	; 0232A76E
	add r0,r5,#0x4	; 0232A770
	mov r1,#0xc	; 0232A772
	bl loc_02329294	; 0232A774
	str r4,[r5,#0x0]	; 0232A778
	add r0,r5,#0x0	; 0232A77A
	bl loc_0232A730	; 0232A77C
	cmp r0,#0x0	; 0232A780
	beq loc_0232A78E	; 0232A782
	mov r0,#0x1	; 0232A784
	add sp,#0x4	; 0232A786
	pop {r4,r5}	; 0232A788
	pop {r3}	; 0232A78A
	bx r3	; 0232A78C
loc_0232A78E:
	mov r0,#0x0	; 0232A78E
	add sp,#0x4	; 0232A790
	pop {r4,r5}	; 0232A792
	pop {r3}	; 0232A794
	bx r3	; 0232A796

; ===== function loc_0232A798 =====
loc_0232A798:
	mov r1,#0x0	; 0232A798
	ldr r3,[pool_0232A7A0]	; 0232A79A
	bx r3	; 0232A79C
	.byte 0xC0, 0x46	; 0232A7A0
pool_0232A7A0:
loc_0232A7A0:
	.word loc_02329294 + 1	; 0232A7A0

; ===== function loc_0232A7A4 =====
loc_0232A7A4:
	push {r4,r5,r6,r7,lr}	; 0232A7A4
	sub sp,#0x4	; 0232A7A6
	add r5,r0,#0x0	; 0232A7A8
	add r6,r1,#0x0	; 0232A7AA
	add r7,r2,#0x0	; 0232A7AC
	str r3,[sp,#0x0]	; 0232A7AE
	ldr r0,[r5,#0x0]	; 0232A7B0
	add r1,#0x1f	; 0232A7B2
	mov r2,#0x1f	; 0232A7B4
	bic r1,r2	; 0232A7B6
	add r1,#0x20	; 0232A7B8
	mov r2,#0x20	; 0232A7BA
	bl loc_023297B8	; 0232A7BC
	add r4,r0,#0x0	; 0232A7C0
	cmp r4,#0x0	; 0232A7C2
	bne loc_0232A7D0	; 0232A7C4
	mov r0,#0x0	; 0232A7C6
	add sp,#0x4	; 0232A7C8
	pop {r4,r5,r6,r7}	; 0232A7CA
	pop {r3}	; 0232A7CC
	bx r3	; 0232A7CE
loc_0232A7D0:
	add r0,r5,#0x4	; 0232A7D0
	mov r1,#0x0	; 0232A7D2
	bl loc_0232915C	; 0232A7D4
	str r6,[r4,#0x8]	; 0232A7D8
	str r7,[r4,#0xc]	; 0232A7DA
	ldr r1,[sp,#0x0]	; 0232A7DC
	str r1,[r4,#0x10]	; 0232A7DE
	ldr r1,[sp,#0x18]	; 0232A7E0
	str r1,[r4,#0x14]	; 0232A7E2
	add r1,r4,#0x0	; 0232A7E4
	bl loc_0232923C	; 0232A7E6
	add r4,#0x20	; 0232A7EA
	add r0,r4,#0x0	; 0232A7EC
	add sp,#0x4	; 0232A7EE
	pop {r4,r5,r6,r7}	; 0232A7F0
	pop {r3}	; 0232A7F2
	bx r3	; 0232A7F4
	.byte 0x00, 0x00	; 0232A7F8

; ===== function loc_0232A7F8 =====
loc_0232A7F8:
	push {r4,r5,r6,r7,lr}	; 0232A7F8
	sub sp,#0x4	; 0232A7FA
	add r7,r0,#0x0	; 0232A7FC
	add r0,r7,#0x4	; 0232A7FE
	mov r1,#0x0	; 0232A800
	bl loc_0232915C	; 0232A802
	add r5,r0,#0x0	; 0232A806
	cmp r5,#0x0	; 0232A808
	beq loc_0232A850	; 0232A80A
loc_0232A80C:
	add r0,r5,#0x0	; 0232A80C
	mov r1,#0x0	; 0232A80E
	bl loc_0232915C	; 0232A810
	add r4,r0,#0x0	; 0232A814
	cmp r4,#0x0	; 0232A816
	beq loc_0232A83A	; 0232A818
loc_0232A81A:
	ldr r6,[r4,#0xc]	; 0232A81A
	cmp r6,#0x0	; 0232A81C
	beq loc_0232A82C	; 0232A81E
	add r0,r4,#0x0	; 0232A820
	add r0,#0x20	; 0232A822
	ldr r1,[r4,#0x8]	; 0232A824
	ldr r2,[r4,#0x10]	; 0232A826
	ldr r3,[r4,#0x14]	; 0232A828
	blx r6	; 0232A82A
loc_0232A82C:
	add r0,r5,#0x0	; 0232A82C
	add r1,r4,#0x0	; 0232A82E
	bl loc_0232915C	; 0232A830
	add r4,r0,#0x0	; 0232A834
	cmp r4,#0x0	; 0232A836
	bne loc_0232A81A	; 0232A838
loc_0232A83A:
	add r0,r7,#0x4	; 0232A83A
	add r1,r5,#0x0	; 0232A83C
	bl loc_0232917C	; 0232A83E
	add r0,r7,#0x4	; 0232A842
	mov r1,#0x0	; 0232A844
	bl loc_0232915C	; 0232A846
	add r5,r0,#0x0	; 0232A84A
	cmp r5,#0x0	; 0232A84C
	bne loc_0232A80C	; 0232A84E
loc_0232A850:
	ldr r0,[r7,#0x0]	; 0232A850
	mov r1,#0x3	; 0232A852
	bl loc_0232978C	; 0232A854
	bl loc_0232A714	; 0232A858
	add r0,r7,#0x0	; 0232A85C
	bl loc_0232A730	; 0232A85E
	add sp,#0x4	; 0232A862
	pop {r4,r5,r6,r7}	; 0232A864
	pop {r3}	; 0232A866
	bx r3	; 0232A868
	.byte 0x00, 0x00	; 0232A86C

; ===== function loc_0232A86C =====
loc_0232A86C:
	push {r4,lr}	; 0232A86C
	add r4,r0,#0x0	; 0232A86E
	bl loc_0232A7F8	; 0232A870
	ldr r0,[r4,#0x0]	; 0232A874
	bl loc_023297E4	; 0232A876
	pop {r4}	; 0232A87A
	pop {r3}	; 0232A87C
	bx r3	; 0232A87E

; ===== function loc_0232A880 =====
loc_0232A880:
	push {r4,r5,lr}	; 0232A880
	sub sp,#0x4	; 0232A882
	add r1,r0,r1	; 0232A884
	add r4,r0,#0x3	; 0232A886
	mov r0,#0x3	; 0232A888
	bic r4,r0	; 0232A88A
	cmp r4,r1	; 0232A88C
	bls loc_0232A89A	; 0232A88E
	mov r0,#0x0	; 0232A890
	add sp,#0x4	; 0232A892
	pop {r4,r5}	; 0232A894
	pop {r3}	; 0232A896
	bx r3	; 0232A898
loc_0232A89A:
	sub r1,r1,r4	; 0232A89A
	cmp r1,#0x10	; 0232A89C
	bcs loc_0232A8AA	; 0232A89E
	mov r0,#0x0	; 0232A8A0
	add sp,#0x4	; 0232A8A2
	pop {r4,r5}	; 0232A8A4
	pop {r3}	; 0232A8A6
	bx r3	; 0232A8A8
loc_0232A8AA:
	add r0,r4,#0x0	; 0232A8AA
	add r0,#0x10	; 0232A8AC
	sub r1,#0x10	; 0232A8AE
	mov r2,#0x0	; 0232A8B0
	bl loc_023297EC	; 0232A8B2
	add r5,r0,#0x0	; 0232A8B6
	cmp r5,#0x0	; 0232A8B8
	bne loc_0232A8C6	; 0232A8BA
	mov r0,#0x0	; 0232A8BC
	add sp,#0x4	; 0232A8BE
	pop {r4,r5}	; 0232A8C0
	pop {r3}	; 0232A8C2
	bx r3	; 0232A8C4
loc_0232A8C6:
	add r0,r4,#0x0	; 0232A8C6
	add r1,r5,#0x0	; 0232A8C8
	bl loc_0232A768	; 0232A8CA
	cmp r0,#0x0	; 0232A8CE
	bne loc_0232A8E2	; 0232A8D0
	add r0,r5,#0x0	; 0232A8D2
	bl loc_023297E4	; 0232A8D4
	mov r0,#0x0	; 0232A8D8
	add sp,#0x4	; 0232A8DA
	pop {r4,r5}	; 0232A8DC
	pop {r3}	; 0232A8DE
	bx r3	; 0232A8E0
loc_0232A8E2:
	add r0,r4,#0x0	; 0232A8E2
	add sp,#0x4	; 0232A8E4
	pop {r4,r5}	; 0232A8E6
	pop {r3}	; 0232A8E8
	bx r3	; 0232A8EA

; ===== function loc_0232A8EC =====
loc_0232A8EC:
	push {r4,r5,r6,r7,lr}	; 0232A8EC
	sub sp,#0xc	; 0232A8EE
	str r0,[sp,#0x0]	; 0232A8F0
	add r5,r1,#0x0	; 0232A8F2
	add r6,r3,#0x0	; 0232A8F4
	ldr r7,[sp,#0x20]	; 0232A8F6
	add r0,r2,#0x0	; 0232A8F8
	bl loc_0232A5F0	; 0232A8FA
	add r4,r0,#0x0	; 0232A8FE
	cmp r4,#0x0	; 0232A900
	bne loc_0232A90E	; 0232A902
	mov r0,#0x0	; 0232A904
	add sp,#0xc	; 0232A906
	pop {r4,r5,r6,r7}	; 0232A908
	pop {r3}	; 0232A90A
	bx r3	; 0232A90C
loc_0232A90E:
	ldr r0,[sp,#0x0]	; 0232A90E
	add r1,r5,#0x0	; 0232A910
	add r2,r6,#0x0	; 0232A912
	bl loc_02329D0C	; 0232A914
	str r0,[sp,#0x4]	; 0232A918
	cmp r0,#0x0	; 0232A91A
	bne loc_0232A928	; 0232A91C
	mov r0,#0x0	; 0232A91E
	add sp,#0xc	; 0232A920
	pop {r4,r5,r6,r7}	; 0232A922
	pop {r3}	; 0232A924
	bx r3	; 0232A926
loc_0232A928:
	ldr r0,[r4,#0x0]	; 0232A928
	bl loc_0232A53C	; 0232A92A
	add r6,r0,#0x0	; 0232A92E
	cmp r6,#0x0	; 0232A930
	bne loc_0232A944	; 0232A932
	ldr r0,[sp,#0x4]	; 0232A934
	bl loc_02329D04	; 0232A936
	mov r0,#0x0	; 0232A93A
	add sp,#0xc	; 0232A93C
	pop {r4,r5,r6,r7}	; 0232A93E
	pop {r3}	; 0232A940
	bx r3	; 0232A942
loc_0232A944:
	mov r5,#0x0	; 0232A944
loc_0232A946:
	ldrh r0,[r4,#0x4]	; 0232A946
	ldr r1,[pool_0232A9C8]	; 0232A948
	cmp r0,r1	; 0232A94A
	beq loc_0232A98A	; 0232A94C
	bl loc_0232A5A4	; 0232A94E
	cmp r0,#0x0	; 0232A952
	bne loc_0232A966	; 0232A954
	ldr r0,[sp,#0x4]	; 0232A956
	bl loc_02329D04	; 0232A958
	mov r0,#0x0	; 0232A95C
	add sp,#0xc	; 0232A95E
	pop {r4,r5,r6,r7}	; 0232A960
	pop {r3}	; 0232A962
	bx r3	; 0232A964
loc_0232A966:
	ldr r0,[r0,#0x0]	; 0232A966
	bl loc_0232A53C	; 0232A968
	add r2,r0,#0x0	; 0232A96C
	cmp r2,#0x0	; 0232A96E
	bne loc_0232A982	; 0232A970
	ldr r0,[sp,#0x4]	; 0232A972
	bl loc_02329D04	; 0232A974
	mov r0,#0x0	; 0232A978
	add sp,#0xc	; 0232A97A
	pop {r4,r5,r6,r7}	; 0232A97C
	pop {r3}	; 0232A97E
	bx r3	; 0232A980
loc_0232A982:
	add r0,r6,#0x0	; 0232A982
	add r1,r5,#0x0	; 0232A984
	bl loc_0232EC3C	; 0232A986
loc_0232A98A:
	add r4,r4,#0x2	; 0232A98A
	add r5,r5,#0x1	; 0232A98C
	cmp r5,#0x4	; 0232A98E
	blt loc_0232A946	; 0232A990
	ldr r0,[sp,#0x4]	; 0232A992
	ldr r2,[sp,#0x24]	; 0232A994
	ldr r1,[r2,#0x18]	; 0232A996
	add r1,r2,r1	; 0232A998
	ldr r2,[r7,#0x0]	; 0232A99A
	add r3,r6,#0x0	; 0232A99C
	bl loc_02329CE0	; 0232A99E
	ldr r0,[sp,#0x0]	; 0232A9A2
	ldrb r1,[r7,#0x6]	; 0232A9A4
	bl loc_02329E0C	; 0232A9A6
	ldr r0,[sp,#0x0]	; 0232A9AA
	ldrb r1,[r7,#0x7]	; 0232A9AC
	bl loc_02329DD0	; 0232A9AE
	ldr r0,[sp,#0x0]	; 0232A9B2
	ldr r1,[sp,#0x28]	; 0232A9B4
	ldr r2,[sp,#0x2c]	; 0232A9B6
	bl loc_02329D84	; 0232A9B8
	mov r0,#0x1	; 0232A9BC
	add sp,#0xc	; 0232A9BE
	pop {r4,r5,r6,r7}	; 0232A9C0
	pop {r3}	; 0232A9C2
	bx r3	; 0232A9C4
	.byte 0xC0, 0x46	; 0232A9C8
pool_0232A9C8:
loc_0232A9C8:
	.word 0x0000FFFF	; 0232A9C8

; ===== function loc_0232A9CC =====
	push {r4,r5,r6,r7,lr}	; 0232A9CC
	sub sp,#0x14	; 0232A9CE
	str r0,[sp,#0x10]	; 0232A9D0
	add r5,r1,#0x0	; 0232A9D2
	add r4,r2,#0x0	; 0232A9D4
	add r6,r3,#0x0	; 0232A9D6
	ldr r0,[sp,#0x28]	; 0232A9D8
	bl loc_0232A63C	; 0232A9DA
	cmp r0,#0x0	; 0232A9DE
	bne loc_0232A9EC	; 0232A9E0
	mov r0,#0x0	; 0232A9E2
	add sp,#0x14	; 0232A9E4
	pop {r4,r5,r6,r7}	; 0232A9E6
	pop {r3}	; 0232A9E8
	bx r3	; 0232A9EA
loc_0232A9EC:
	ldr r0,[r0,#0x0]	; 0232A9EC
	bl loc_0232A53C	; 0232A9EE
	add r7,r0,#0x0	; 0232A9F2
	cmp r7,#0x0	; 0232A9F4
	bne loc_0232AA02	; 0232A9F6
	mov r0,#0x0	; 0232A9F8
	add sp,#0x14	; 0232A9FA
	pop {r4,r5,r6,r7}	; 0232A9FC
	pop {r3}	; 0232A9FE
	bx r3	; 0232AA00
loc_0232AA02:
	ldr r1,[sp,#0x2c]	; 0232AA02
	bl loc_0232AB14	; 0232AA04
	cmp r0,#0x0	; 0232AA08
	bne loc_0232AA16	; 0232AA0A
	mov r0,#0x0	; 0232AA0C
	add sp,#0x14	; 0232AA0E
	pop {r4,r5,r6,r7}	; 0232AA10
	pop {r3}	; 0232AA12
	bx r3	; 0232AA14
loc_0232AA16:
	cmp r6,#0x0	; 0232AA16
	bge loc_0232AA1C	; 0232AA18
	ldrb r6,[r0,#0x8]	; 0232AA1A
loc_0232AA1C:
	cmp r4,#0x0	; 0232AA1C
	bge loc_0232AA22	; 0232AA1E
	ldrh r4,[r0,#0x4]	; 0232AA20
loc_0232AA22:
	cmp r5,#0x0	; 0232AA22
	bge loc_0232AA28	; 0232AA24
	ldrb r5,[r0,#0x9]	; 0232AA26
loc_0232AA28:
	str r0,[sp,#0x0]	; 0232AA28
	str r7,[sp,#0x4]	; 0232AA2A
	ldr r0,[sp,#0x28]	; 0232AA2C
	str r0,[sp,#0x8]	; 0232AA2E
	ldr r0,[sp,#0x2c]	; 0232AA30
	str r0,[sp,#0xc]	; 0232AA32
	ldr r0,[sp,#0x10]	; 0232AA34
	add r1,r5,#0x0	; 0232AA36
	add r2,r4,#0x0	; 0232AA38
	add r3,r6,#0x0	; 0232AA3A
	bl loc_0232A8EC	; 0232AA3C
	add sp,#0x14	; 0232AA40
	pop {r4,r5,r6,r7}	; 0232AA42
	pop {r3}	; 0232AA44
	bx r3	; 0232AA46
loc_0232AA48:
	push {r4,r5,r6,r7,lr}	; 0232AA48
	sub sp,#0x14	; 0232AA4A
	add r7,r0,#0x0	; 0232AA4C
	add r5,r1,#0x0	; 0232AA4E
	add r4,r2,#0x0	; 0232AA50
	add r0,r5,#0x0	; 0232AA52
	bl loc_0232A63C	; 0232AA54
	cmp r0,#0x0	; 0232AA58
	bne loc_0232AA66	; 0232AA5A
	mov r0,#0x0	; 0232AA5C
	add sp,#0x14	; 0232AA5E
	pop {r4,r5,r6,r7}	; 0232AA60
	pop {r3}	; 0232AA62
	bx r3	; 0232AA64
loc_0232AA66:
	ldr r0,[r0,#0x0]	; 0232AA66
	bl loc_0232A53C	; 0232AA68
	add r6,r0,#0x0	; 0232AA6C
	cmp r6,#0x0	; 0232AA6E
	bne loc_0232AA7C	; 0232AA70
	mov r0,#0x0	; 0232AA72
	add sp,#0x14	; 0232AA74
	pop {r4,r5,r6,r7}	; 0232AA76
	pop {r3}	; 0232AA78
	bx r3	; 0232AA7A
loc_0232AA7C:
	add r1,r4,#0x0	; 0232AA7C
	bl loc_0232AB14	; 0232AA7E
	add r3,r0,#0x0	; 0232AA82
	cmp r3,#0x0	; 0232AA84
	bne loc_0232AA92	; 0232AA86
	mov r0,#0x0	; 0232AA88
	add sp,#0x14	; 0232AA8A
	pop {r4,r5,r6,r7}	; 0232AA8C
	pop {r3}	; 0232AA8E
	bx r3	; 0232AA90
loc_0232AA92:
	str r3,[sp,#0x0]	; 0232AA92
	str r6,[sp,#0x4]	; 0232AA94
	str r5,[sp,#0x8]	; 0232AA96
	str r4,[sp,#0xc]	; 0232AA98
	add r0,r7,#0x0	; 0232AA9A
	ldrb r1,[r3,#0x9]	; 0232AA9C
	ldrh r2,[r3,#0x4]	; 0232AA9E
	ldrb r3,[r3,#0x8]	; 0232AAA0
	bl loc_0232A8EC	; 0232AAA2
	add sp,#0x14	; 0232AAA6
	pop {r4,r5,r6,r7}	; 0232AAA8
	pop {r3}	; 0232AAAA
	bx r3	; 0232AAAC
	.byte 0x00, 0x00	; 0232AAB0

; ===== function loc_0232AAB0 =====
loc_0232AAB0:
	push {r4,r5,r6,r7,lr}	; 0232AAB0
	sub sp,#0x4	; 0232AAB2
	add r7,r0,#0x0	; 0232AAB4
	bl loc_0232A688	; 0232AAB6
	mov r6,#0x0	; 0232AABA
	str r6,[sp,#0x0]	; 0232AABC
loc_0232AABE:
	add r0,r6,#0x0	; 0232AABE
	bl loc_0232A558	; 0232AAC0
	add r5,r0,#0x0	; 0232AAC4
	cmp r5,#0x0	; 0232AAC6
	beq loc_0232AB04	; 0232AAC8
	add r0,r6,#0x0	; 0232AACA
	ldrb r1,[r5,#0x0]	; 0232AACC
	bl loc_02329EB8	; 0232AACE
	ldr r0,[r5,#0x4]	; 0232AAD2
	cmp r0,#0x0	; 0232AAD4
	beq loc_0232AB04	; 0232AAD6
	cmp r7,#0x0	; 0232AAD8
	beq loc_0232AB04	; 0232AADA
	ldr r4,[sp,#0x0]	; 0232AADC
	ldrb r0,[r5,#0x0]	; 0232AADE
	cmp r0,#0x0	; 0232AAE0
	ble loc_0232AB04	; 0232AAE2
loc_0232AAE4:
	add r0,r6,#0x0	; 0232AAE4
	add r1,r7,#0x0	; 0232AAE6
	ldr r2,[r5,#0x4]	; 0232AAE8
	bl loc_02329E4C	; 0232AAEA
	cmp r0,#0x0	; 0232AAEE
	bne loc_0232AAFC	; 0232AAF0
	mov r0,#0x0	; 0232AAF2
	add sp,#0x4	; 0232AAF4
	pop {r4,r5,r6,r7}	; 0232AAF6
	pop {r3}	; 0232AAF8
	bx r3	; 0232AAFA
loc_0232AAFC:
	add r4,r4,#0x1	; 0232AAFC
	ldrb r0,[r5,#0x0]	; 0232AAFE
	cmp r4,r0	; 0232AB00
	blt loc_0232AAE4	; 0232AB02
loc_0232AB04:
	add r6,r6,#0x1	; 0232AB04
	cmp r6,#0x20	; 0232AB06
	blt loc_0232AABE	; 0232AB08
	mov r0,#0x1	; 0232AB0A
	add sp,#0x4	; 0232AB0C
	pop {r4,r5,r6,r7}	; 0232AB0E
	pop {r3}	; 0232AB10
	bx r3	; 0232AB12

; ===== function loc_0232AB14 =====
loc_0232AB14:
	cmp r1,#0x0	; 0232AB14
	bge loc_0232AB1C	; 0232AB16
	mov r0,#0x0	; 0232AB18
	bx lr	; 0232AB1A
loc_0232AB1C:
	ldr r2,[r0,#0x1c]	; 0232AB1C
	cmp r1,r2	; 0232AB1E
	bcc loc_0232AB26	; 0232AB20
	mov r0,#0x0	; 0232AB22
	bx lr	; 0232AB24
loc_0232AB26:
	add r0,#0x20	; 0232AB26
	mov r2,#0xc	; 0232AB28
	mul r1,r2	; 0232AB2A
	add r3,r0,r1	; 0232AB2C
	ldr r2,[r0,r1]	; 0232AB2E
	mov r0,#0x0	; 0232AB30
	mvn r1,r0	; 0232AB32
	cmp r2,r1	; 0232AB34
	bne loc_0232AB3A	; 0232AB36
	add r3,r0,#0x0	; 0232AB38
loc_0232AB3A:
	add r0,r3,#0x0	; 0232AB3A
	bx lr	; 0232AB3C
	.byte 0x00, 0x00	; 0232AB40

; ===== function loc_0232AB40 =====
loc_0232AB40:
	ldr r1,[r0,#0x8]	; 0232AB40
	ldr r0,[r0,#0xc]	; 0232AB42
	cmp r1,r0	; 0232AB44
	blt loc_0232AB4C	; 0232AB46
	mov r0,#0x1	; 0232AB48
	bx lr	; 0232AB4A
loc_0232AB4C:
	mov r0,#0x0	; 0232AB4C
	bx lr	; 0232AB4E

; ===== function loc_0232AB50 =====
loc_0232AB50:
	ldr r2,[r0,#0x8]	; 0232AB50
	ldr r1,[r0,#0xc]	; 0232AB52
	cmp r2,r1	; 0232AB54
	bge loc_0232AB60	; 0232AB56
	add r0,#0x8	; 0232AB58
	ldr r1,[r0,#0x0]	; 0232AB5A
	add r1,r1,#0x1	; 0232AB5C
	str r1,[r0,#0x0]	; 0232AB5E
loc_0232AB60:
	bx lr	; 0232AB60
	.byte 0x00, 0x00	; 0232AB64

; ===== function loc_0232AB64 =====
loc_0232AB64:
	push {r4,lr}	; 0232AB64
	ldr r1,[r0,#0xc]	; 0232AB66
	ldr r2,[r0,#0x8]	; 0232AB68
	cmp r2,r1	; 0232AB6A
	blt loc_0232AB76	; 0232AB6C
	ldr r0,[r0,#0x4]	; 0232AB6E
	pop {r4}	; 0232AB70
	pop {r3}	; 0232AB72
	bx r3	; 0232AB74
loc_0232AB76:
	ldr r4,[r0,#0x0]	; 0232AB76
	ldr r0,[r0,#0x4]	; 0232AB78
	sub r0,r0,r4	; 0232AB7A
	mul r2,r0	; 0232AB7C
	add r0,r2,#0x0	; 0232AB7E
	blx P1_SignedDivMod	; 0232AB80
	add r0,r4,r0	; 0232AB84
	pop {r4}	; 0232AB86
	pop {r3}	; 0232AB88
	bx r3	; 0232AB8A

; ===== function loc_0232AB8C =====
loc_0232AB8C:
	push {r4,r5,r6,lr}	; 0232AB8C
	add r5,r0,#0x0	; 0232AB8E
	add r4,r1,#0x0	; 0232AB90
	add r6,r2,#0x0	; 0232AB92
	bl loc_0232AB64	; 0232AB94
	str r0,[r5,#0x0]	; 0232AB98
	str r4,[r5,#0x4]	; 0232AB9A
	str r6,[r5,#0xc]	; 0232AB9C
	mov r0,#0x0	; 0232AB9E
	str r0,[r5,#0x8]	; 0232ABA0
	pop {r4,r5,r6}	; 0232ABA2
	pop {r3}	; 0232ABA4
	bx r3	; 0232ABA6

; ===== function loc_0232ABA8 =====
loc_0232ABA8:
	mov r2,#0x0	; 0232ABA8
	str r2,[r0,#0x4]	; 0232ABAA
	ldr r1,[r0,#0x4]	; 0232ABAC
	str r1,[r0,#0x0]	; 0232ABAE
	str r2,[r0,#0xc]	; 0232ABB0
	ldr r1,[r0,#0xc]	; 0232ABB2
	str r1,[r0,#0x8]	; 0232ABB4
	bx lr	; 0232ABB6
.arm

; ===== function loc_0232ABB8 =====
loc_0232ABB8:
	stmdb sp!,{r4,r5,r6,lr}	; 0232ABB8
	mov r5,r0	; 0232ABBC
	mov r4,r1	; 0232ABC0
	bl P1_Arm9DisableIrqReturnPriorMask	; 0232ABC4
	cmp r5,#0x0	; 0232ABC8
	beq loc_0232ABE8	; 0232ABCC
	ldr r3,[pool_0232AC2C]	; 0232ABD0
	ldr r1,[pool_0232AC30]	; 0232ABD4
	mvn r2,r4	; 0232ABD8
	ldr r1,[r3,r1]!	; 0232ABDC
	and r1,r1,r2	; 0232ABE0
	str r1,[r3,#0x0]	; 0232ABE4
loc_0232ABE8:
	bl P1_Arm9RestoreIrqMask	; 0232ABE8
	ldr r1,[pool_0232AC2C]	; 0232ABEC
	add r0,r1,#0x3000	; 0232ABF0
	ldr r0,[r0,#0xff8]	; 0232ABF4
	ands r0,r4,r0	; 0232ABF8
	ldmneia sp!,{r4,r5,r6,lr}	; 0232ABFC
	bxne lr	; 0232AC00
	ldr r0,[pool_0232AC30]	; 0232AC04
	add r6,r1,r0	; 0232AC08
	ldr r5,[pool_0232AC34]	; 0232AC0C
loc_0232AC10:
	mov r0,r5	; 0232AC10
	blx loc_0232B278	; 0232AC14
	ldr r0,[r6,#0x0]	; 0232AC18
	ands r0,r4,r0	; 0232AC1C
	beq loc_0232AC10	; 0232AC20
	ldmia sp!,{r4,r5,r6,lr}	; 0232AC24
	bx lr	; 0232AC28
pool_0232AC2C:
loc_0232AC2C:
	.word P1_DtcmRuntimeStart	; 0232AC2C
pool_0232AC30:
loc_0232AC30:
	.word 0x00003FF8	; 0232AC30
pool_0232AC34:
loc_0232AC34:
	.word 0x03000000	; 0232AC34
.thumb
P1_IrqHandler_0232AC38:
	mov r0,#0x7	; 0232AC38
	ldr r3,[pool_0232AC40]	; 0232AC3A
	bx r3	; 0232AC3C
	.byte 0xC0, 0x46	; 0232AC40
pool_0232AC40:
loc_0232AC40:
	.word loc_0232AC98 + 1	; 0232AC40
P1_IrqHandler_0232AC44:
	mov r0,#0x6	; 0232AC44
	ldr r3,[pool_0232AC4C]	; 0232AC46
	bx r3	; 0232AC48
	.byte 0xC0, 0x46	; 0232AC4C
pool_0232AC4C:
loc_0232AC4C:
	.word loc_0232AC98 + 1	; 0232AC4C
P1_IrqHandler_0232AC50:
	mov r0,#0x5	; 0232AC50
	ldr r3,[pool_0232AC58]	; 0232AC52
	bx r3	; 0232AC54
	.byte 0xC0, 0x46	; 0232AC58
pool_0232AC58:
loc_0232AC58:
	.word loc_0232AC98 + 1	; 0232AC58
P1_IrqHandler_0232AC5C:
	mov r0,#0x4	; 0232AC5C
	ldr r3,[pool_0232AC64]	; 0232AC5E
	bx r3	; 0232AC60
	.byte 0xC0, 0x46	; 0232AC64
pool_0232AC64:
loc_0232AC64:
	.word loc_0232AC98 + 1	; 0232AC64
P1_IrqHandler_0232AC68:
	mov r0,#0x3	; 0232AC68
	ldr r3,[pool_0232AC70]	; 0232AC6A
	bx r3	; 0232AC6C
	.byte 0xC0, 0x46	; 0232AC70
pool_0232AC70:
loc_0232AC70:
	.word loc_0232AC98 + 1	; 0232AC70
P1_IrqHandler_0232AC74:
	mov r0,#0x2	; 0232AC74
	ldr r3,[pool_0232AC7C]	; 0232AC76
	bx r3	; 0232AC78
	.byte 0xC0, 0x46	; 0232AC7C
pool_0232AC7C:
loc_0232AC7C:
	.word loc_0232AC98 + 1	; 0232AC7C
P1_IrqHandler_0232AC80:
	mov r0,#0x1	; 0232AC80
	ldr r3,[pool_0232AC88]	; 0232AC82
	bx r3	; 0232AC84
	.byte 0xC0, 0x46	; 0232AC88
pool_0232AC88:
loc_0232AC88:
	.word loc_0232AC98 + 1	; 0232AC88
P1_IrqHandler_0232AC8C:
	mov r0,#0x0	; 0232AC8C
	ldr r3,[pool_0232AC94]	; 0232AC8E
	bx r3	; 0232AC90
	.byte 0xC0, 0x46	; 0232AC94
pool_0232AC94:
loc_0232AC94:
	.word loc_0232AC98 + 1	; 0232AC94
loc_0232AC98:
	push {r4,r5,lr}	; 0232AC98
	sub sp,#0x4	; 0232AC9A
	mov r5,#0x1	; 0232AC9C
	lsl r2,r0,#0x1	; 0232AC9E
	ldr r1,[pool_0232ACE0]	; 0232ACA0
	ldrh r1,[r1,r2]	; 0232ACA2
	lsl r5,r1	; 0232ACA4
	mov r1,#0xc	; 0232ACA6
	add r4,r0,#0x0	; 0232ACA8
	mul r4,r1	; 0232ACAA
	ldr r2,[pool_0232ACE4]	; 0232ACAC
	ldr r1,[r2,r4]	; 0232ACAE
	mov r0,#0x0	; 0232ACB0
	str r0,[r2,r4]	; 0232ACB2
	cmp r1,#0x0	; 0232ACB4
	beq loc_0232ACBE	; 0232ACB6
	ldr r0,[pool_0232ACE8]	; 0232ACB8
	ldr r0,[r0,r4]	; 0232ACBA
	blx r1	; 0232ACBC
loc_0232ACBE:
	ldr r1,[pool_0232ACEC]	; 0232ACBE
	ldr r0,[pool_0232ACF0]	; 0232ACC0
	add r1,r1,r0	; 0232ACC2
	ldr r0,[r1,#0x0]	; 0232ACC4
	orr r0,r5	; 0232ACC6
	str r0,[r1,#0x0]	; 0232ACC8
	ldr r0,[pool_0232ACF4]	; 0232ACCA
	ldr r0,[r0,r4]	; 0232ACCC
	cmp r0,#0x0	; 0232ACCE
	bne loc_0232ACD8	; 0232ACD0
	add r0,r5,#0x0	; 0232ACD2
	bl loc_0232AD24	; 0232ACD4
loc_0232ACD8:
	add sp,#0x4	; 0232ACD8
	pop {r4,r5}	; 0232ACDA
	pop {r3}	; 0232ACDC
	bx r3	; 0232ACDE
pool_0232ACE0:
loc_0232ACE0:
	.word P1_Data_02330DFC	; 0232ACE0
pool_0232ACE4:
loc_0232ACE4:
	.word P1_BssStart + 0x26310	; 0232ACE4
pool_0232ACE8:
loc_0232ACE8:
	.word P1_BssStart + 0x26318	; 0232ACE8
pool_0232ACEC:
loc_0232ACEC:
	.word 0x03000000	; 0232ACEC
pool_0232ACF0:
loc_0232ACF0:
	.word 0x00003FF8	; 0232ACF0
pool_0232ACF4:
loc_0232ACF4:
	.word P1_BssStart + 0x26314	; 0232ACF4
P1_IrqHandler_0232ACF8:
	bx lr	; 0232ACF8
	.byte 0x00, 0x00	; 0232ACFC

; ===== function loc_0232ACFC =====
loc_0232ACFC:
	push {r4}	; 0232ACFC
	sub sp,#0x4	; 0232ACFE
	ldr r4,[pool_0232AD1C]	; 0232AD00
	ldrh r3,[r4,#0x0]	; 0232AD02
	mov r1,#0x0	; 0232AD04
	strh r1,[r4,#0x0]	; 0232AD06
	ldr r2,[pool_0232AD20]	; 0232AD08
	ldr r1,[r2,#0x0]	; 0232AD0A
	str r0,[r2,#0x0]	; 0232AD0C
	ldrh r0,[r4,#0x0]	; 0232AD0E
	strh r3,[r4,#0x0]	; 0232AD10
	add r0,r1,#0x0	; 0232AD12
	add sp,#0x4	; 0232AD14
	pop {r4}	; 0232AD16
	bx lr	; 0232AD18
	.byte 0xC0, 0x46	; 0232AD1C
pool_0232AD1C:
loc_0232AD1C:
	.word REG_IME	; 0232AD1C
pool_0232AD20:
loc_0232AD20:
	.word REG_IF	; 0232AD20

; ===== function loc_0232AD24 =====
loc_0232AD24:
	push {r4,r5}	; 0232AD24
	ldr r5,[pool_0232AD44]	; 0232AD26
	ldrh r4,[r5,#0x0]	; 0232AD28
	mov r1,#0x0	; 0232AD2A
	strh r1,[r5,#0x0]	; 0232AD2C
	ldr r3,[pool_0232AD48]	; 0232AD2E
	ldr r2,[r3,#0x0]	; 0232AD30
	add r1,r2,#0x0	; 0232AD32
	bic r1,r0	; 0232AD34
	str r1,[r3,#0x0]	; 0232AD36
	ldrh r0,[r5,#0x0]	; 0232AD38
	strh r4,[r5,#0x0]	; 0232AD3A
	add r0,r2,#0x0	; 0232AD3C
	pop {r4,r5}	; 0232AD3E
	bx lr	; 0232AD40
	.byte 0xC0, 0x46	; 0232AD44
pool_0232AD44:
loc_0232AD44:
	.word REG_IME	; 0232AD44
pool_0232AD48:
loc_0232AD48:
	.word REG_IE	; 0232AD48

; ===== function loc_0232AD4C =====
loc_0232AD4C:
	push {r4,r5}	; 0232AD4C
	ldr r5,[pool_0232AD6C]	; 0232AD4E
	ldrh r4,[r5,#0x0]	; 0232AD50
	mov r1,#0x0	; 0232AD52
	strh r1,[r5,#0x0]	; 0232AD54
	ldr r3,[pool_0232AD70]	; 0232AD56
	ldr r2,[r3,#0x0]	; 0232AD58
	add r1,r2,#0x0	; 0232AD5A
	orr r1,r0	; 0232AD5C
	str r1,[r3,#0x0]	; 0232AD5E
	ldrh r0,[r5,#0x0]	; 0232AD60
	strh r4,[r5,#0x0]	; 0232AD62
	add r0,r2,#0x0	; 0232AD64
	pop {r4,r5}	; 0232AD66
	bx lr	; 0232AD68
	.byte 0xC0, 0x46	; 0232AD6C
pool_0232AD6C:
loc_0232AD6C:
	.word REG_IME	; 0232AD6C
pool_0232AD70:
loc_0232AD70:
	.word REG_IE	; 0232AD70

; ===== function loc_0232AD74 =====
loc_0232AD74:
	push {r4}	; 0232AD74
	sub sp,#0x4	; 0232AD76
	ldr r4,[pool_0232AD94]	; 0232AD78
	ldrh r3,[r4,#0x0]	; 0232AD7A
	mov r1,#0x0	; 0232AD7C
	strh r1,[r4,#0x0]	; 0232AD7E
	ldr r2,[pool_0232AD98]	; 0232AD80
	ldr r1,[r2,#0x0]	; 0232AD82
	str r0,[r2,#0x0]	; 0232AD84
	ldrh r0,[r4,#0x0]	; 0232AD86
	strh r3,[r4,#0x0]	; 0232AD88
	add r0,r1,#0x0	; 0232AD8A
	add sp,#0x4	; 0232AD8C
	pop {r4}	; 0232AD8E
	bx lr	; 0232AD90
	.byte 0xC0, 0x46	; 0232AD94
pool_0232AD94:
loc_0232AD94:
	.word REG_IME	; 0232AD94
pool_0232AD98:
loc_0232AD98:
	.word REG_IE	; 0232AD98

; ===== function loc_0232AD9C =====
loc_0232AD9C:
	push {r4,lr}	; 0232AD9C
	mov r3,#0xc	; 0232AD9E
	add r4,r0,#0x0	; 0232ADA0
	mul r4,r3	; 0232ADA2
	ldr r3,[pool_0232ADC4]	; 0232ADA4
	str r1,[r3,r4]	; 0232ADA6
	ldr r1,[pool_0232ADC8]	; 0232ADA8
	str r2,[r1,r4]	; 0232ADAA
	mov r1,#0x1	; 0232ADAC
	add r0,r0,#0x3	; 0232ADAE
	lsl r1,r0	; 0232ADB0
	add r0,r1,#0x0	; 0232ADB2
	bl loc_0232AD4C	; 0232ADB4
	mov r1,#0x1	; 0232ADB8
	ldr r0,[pool_0232ADCC]	; 0232ADBA
	str r1,[r0,r4]	; 0232ADBC
	pop {r4}	; 0232ADBE
	pop {r3}	; 0232ADC0
	bx r3	; 0232ADC2
pool_0232ADC4:
loc_0232ADC4:
	.word P1_BssStart + 0x26340	; 0232ADC4
pool_0232ADC8:
loc_0232ADC8:
	.word P1_BssStart + 0x26348	; 0232ADC8
pool_0232ADCC:
loc_0232ADCC:
	.word P1_BssStart + 0x26344	; 0232ADCC

; ===== function loc_0232ADD0 =====
loc_0232ADD0:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P1_SetIrqHandlers
	push {r4,r5,r6,r7}	; 0232ADD0
	mov r6,#0x0	; 0232ADD2
	ldr r5,[pool_0232AE2C]	; 0232ADD4
	add r4,r6,#0x0	; 0232ADD6
	add r2,r6,#0x0	; 0232ADD8
loc_0232ADDA:
	add r7,r0,#0x0	; 0232ADDA
	mov r3,#0x1	; 0232ADDC
	and r7,r3	; 0232ADDE
	cmp r7,#0x0	; 0232ADE0
	beq loc_0232AE1E	; 0232ADE2
	add r7,r4,#0x0	; 0232ADE4
	cmp r6,#0x8	; 0232ADE6
	blt loc_0232ADFC	; 0232ADE8
	cmp r6,#0xb	; 0232ADEA
	bgt loc_0232ADFC	; 0232ADEC
	add r3,r6,#0x0	; 0232ADEE
	sub r3,#0x8	; 0232ADF0
	mov r7,#0xc	; 0232ADF2
	mul r3,r7	; 0232ADF4
	ldr r7,[pool_0232AE30]	; 0232ADF6
	add r7,r7,r3	; 0232ADF8
	b loc_0232AE12	; 0232ADFA
loc_0232ADFC:
	cmp r6,#0x3	; 0232ADFC
	blt loc_0232AE10	; 0232ADFE
	cmp r6,#0x6	; 0232AE00
	bgt loc_0232AE10	; 0232AE02
	add r3,r6,#0x1	; 0232AE04
	mov r7,#0xc	; 0232AE06
	mul r3,r7	; 0232AE08
	ldr r7,[pool_0232AE30]	; 0232AE0A
	add r7,r7,r3	; 0232AE0C
	b loc_0232AE12	; 0232AE0E
loc_0232AE10:
	str r1,[r5,#0x0]	; 0232AE10
loc_0232AE12:
	cmp r7,#0x0	; 0232AE12
	beq loc_0232AE1E	; 0232AE14
	str r1,[r7,#0x0]	; 0232AE16
	str r2,[r7,#0x8]	; 0232AE18
	mov r3,#0x1	; 0232AE1A
	str r3,[r7,#0x4]	; 0232AE1C
loc_0232AE1E:
	lsr r0,r0,#0x1	; 0232AE1E
	add r5,r5,#0x4	; 0232AE20
	add r6,r6,#0x1	; 0232AE22
	cmp r6,#0x16	; 0232AE24
	blt loc_0232ADDA	; 0232AE26
	pop {r4,r5,r6,r7}	; 0232AE28
	bx lr	; 0232AE2A
.endfunc
pool_0232AE2C:
loc_0232AE2C:
	.word P1_IrqHandlers	; 0232AE2C
pool_0232AE30:
loc_0232AE30:
	.word 0x02357190	; 0232AE30

; ===== function loc_0232AE34 =====
loc_0232AE34:
	mov r1,#0x0	; 0232AE34
	ldr r0,[pool_0232AE3C]	; 0232AE36
	strh r1,[r0,#0x0]	; 0232AE38
	bx lr	; 0232AE3A
pool_0232AE3C:
loc_0232AE3C:
	.word P1_DtcmRuntimeStart	; 0232AE3C

; ===== function loc_0232AE40 =====
loc_0232AE40:
	ldr r1,[pool_0232AE44]	; 0232AE40
	bx r1	; 0232AE42
pool_0232AE44:
loc_0232AE44:
	.word loc_0232AF8C + 1	; 0232AE44

; ===== function loc_0232AE48 =====
loc_0232AE48:
	ldr r1,[pool_0232AE4C]	; 0232AE48
	bx r1	; 0232AE4A
pool_0232AE4C:
loc_0232AE4C:
	.word loc_0232AF28 + 1	; 0232AE4C
.arm

; ===== function loc_0232AE50 =====
loc_0232AE50:
	ldr r3,[pool_0232AEA0]	; 0232AE50
	ldr r1,[r3,#0x0]	; 0232AE54
	clz r2,r1	; 0232AE58
	cmp r2,#0x20	; 0232AE5C
	movne r0,#0x40	; 0232AE60
	bne loc_0232AE84	; 0232AE64
	add r3,r3,#0x4	; 0232AE68
	ldr r1,[r3,#0x0]	; 0232AE6C
	clz r2,r1	; 0232AE70
	cmp r2,#0x20	; 0232AE74
	ldr r0,[pool_0232AEA4]	; 0232AE78
	bxeq lr	; 0232AE7C
	mov r0,#0x60	; 0232AE80
loc_0232AE84:
	add r0,r0,r2	; 0232AE84
	mov r1,#0x80000000	; 0232AE88
	mov r1,r1, lsr r2	; 0232AE8C
	ldr r2,[r3,#0x0]	; 0232AE90
	bic r2,r2,r1	; 0232AE94
	str r2,[r3,#0x0]	; 0232AE98
	bx lr	; 0232AE9C
pool_0232AEA0:
loc_0232AEA0:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232AEA0
pool_0232AEA4:
loc_0232AEA4:
	.word 0xFFFFFFFD	; 0232AEA4

; ===== function loc_0232AEA8 =====
loc_0232AEA8:
	ldr r3,[pool_0232AED4]	; 0232AEA8
	cmp r0,#0x60	; 0232AEAC
	addpl r3,r3,#0x4	; 0232AEB0
	subpl r0,r0,#0x60	; 0232AEB4
	submi r0,r0,#0x40	; 0232AEB8
	mov r1,#0x80000000	; 0232AEBC
	mov r1,r1, lsr r0	; 0232AEC0
	ldr r2,[r3,#0x0]	; 0232AEC4
	orr r2,r2,r1	; 0232AEC8
	str r2,[r3,#0x0]	; 0232AECC
	bx lr	; 0232AED0
pool_0232AED4:
loc_0232AED4:
	.word 0x027FFFB0	; 0232AED4
.thumb

; ===== function loc_0232AED8 =====
loc_0232AED8:
	ldr r0,[pool_0232AEE0]	; 0232AED8
	ldr r3,[pool_0232AEE4]	; 0232AEDA
	bx r3	; 0232AEDC
	.byte 0xC0, 0x46	; 0232AEE0
pool_0232AEE0:
loc_0232AEE0:
	.word 0x00001000	; 0232AEE0
pool_0232AEE4:
loc_0232AEE4:
	.word P1_Arm9BusyWaitByLoop4	; 0232AEE4

; ===== function loc_0232AEE8 =====
loc_0232AEE8:
	ldrh r0,[r0,#0x4]	; 0232AEE8
	bx lr	; 0232AEEA
	ldr r1,[pool_0232AEF8]	; 0232AEEC
	ldrh r2,[r1,#0x0]	; 0232AEEE
	ldr r0,[pool_0232AEFC]	; 0232AEF0
	orr r2,r0	; 0232AEF2
	strh r2,[r1,#0x0]	; 0232AEF4
	bx lr	; 0232AEF6
pool_0232AEF8:
loc_0232AEF8:
	.word REG_EXMEMCNT_ARM9	; 0232AEF8
pool_0232AEFC:
loc_0232AEFC:
	.word 0x00000800	; 0232AEFC
	ldr r1,[pool_0232AF0C]	; 0232AF00
	ldrh r2,[r1,#0x0]	; 0232AF02
	ldr r0,[pool_0232AF10]	; 0232AF04
	and r2,r0	; 0232AF06
	strh r2,[r1,#0x0]	; 0232AF08
	bx lr	; 0232AF0A
pool_0232AF0C:
loc_0232AF0C:
	.word REG_EXMEMCNT_ARM9	; 0232AF0C
pool_0232AF10:
loc_0232AF10:
	.word 0xFFFFF7FF	; 0232AF10

; ===== function loc_0232AF14 =====
loc_0232AF14:
	ldr r1,[pool_0232AF1C]	; 0232AF14
	ldr r2,[pool_0232AF20]	; 0232AF16
	ldr r3,[pool_0232AF24]	; 0232AF18
	bx r3	; 0232AF1A
pool_0232AF1C:
loc_0232AF1C:
	.word 0x027FFFE0	; 0232AF1C
pool_0232AF20:
loc_0232AF20:
	.word 0x0232AF01	; 0232AF20
pool_0232AF24:
loc_0232AF24:
	.word loc_0232AFC4 + 1	; 0232AF24

; ===== function loc_0232AF28 =====
loc_0232AF28:
	ldr r1,[pool_0232AF30]	; 0232AF28
	ldr r2,[pool_0232AF34]	; 0232AF2A
	ldr r3,[pool_0232AF38]	; 0232AF2C
	bx r3	; 0232AF2E
pool_0232AF30:
loc_0232AF30:
	.word 0x027FFFE0	; 0232AF30
pool_0232AF34:
loc_0232AF34:
	.word 0x0232AEED	; 0232AF34
pool_0232AF38:
loc_0232AF38:
	.word loc_0232B034 + 1	; 0232AF38

; ===== function loc_0232AF3C =====
loc_0232AF3C:
	ldr r1,[pool_0232AF44]	; 0232AF3C
	ldr r2,[pool_0232AF48]	; 0232AF3E
	ldr r3,[pool_0232AF4C]	; 0232AF40
	bx r3	; 0232AF42
pool_0232AF44:
loc_0232AF44:
	.word 0x027FFFE0	; 0232AF44
pool_0232AF48:
loc_0232AF48:
	.word 0x0232AF01	; 0232AF48
pool_0232AF4C:
loc_0232AF4C:
	.word loc_0232B09C + 1	; 0232AF4C
	ldr r1,[pool_0232AF5C]	; 0232AF50
	ldrh r2,[r1,#0x0]	; 0232AF52
	mov r0,#0x80	; 0232AF54
	orr r2,r0	; 0232AF56
	strh r2,[r1,#0x0]	; 0232AF58
	bx lr	; 0232AF5A
pool_0232AF5C:
loc_0232AF5C:
	.word REG_EXMEMCNT_ARM9	; 0232AF5C
	ldr r1,[pool_0232AF6C]	; 0232AF60
	ldrh r2,[r1,#0x0]	; 0232AF62
	mov r0,#0x80	; 0232AF64
	bic r2,r0	; 0232AF66
	strh r2,[r1,#0x0]	; 0232AF68
	bx lr	; 0232AF6A
pool_0232AF6C:
loc_0232AF6C:
	.word REG_EXMEMCNT_ARM9	; 0232AF6C

; ===== function loc_0232AF70 =====
loc_0232AF70:
	push {lr}	; 0232AF70
	sub sp,#0x4	; 0232AF72
	ldr r1,[pool_0232AF84]	; 0232AF74
	ldr r2,[pool_0232AF88]	; 0232AF76
	mov r3,#0x1	; 0232AF78
	bl loc_0232AFD4	; 0232AF7A
	add sp,#0x4	; 0232AF7E
	pop {r3}	; 0232AF80
	bx r3	; 0232AF82
pool_0232AF84:
loc_0232AF84:
	.word 0x027FFFE8	; 0232AF84
pool_0232AF88:
loc_0232AF88:
	.word 0x0232AF61	; 0232AF88

; ===== function loc_0232AF8C =====
loc_0232AF8C:
	push {lr}	; 0232AF8C
	sub sp,#0x4	; 0232AF8E
	ldr r1,[pool_0232AFA0]	; 0232AF90
	ldr r2,[pool_0232AFA4]	; 0232AF92
	mov r3,#0x1	; 0232AF94
	bl loc_0232B044	; 0232AF96
	add sp,#0x4	; 0232AF9A
	pop {r3}	; 0232AF9C
	bx r3	; 0232AF9E
pool_0232AFA0:
loc_0232AFA0:
	.word 0x027FFFE8	; 0232AFA0
pool_0232AFA4:
loc_0232AFA4:
	.word 0x0232AF51	; 0232AFA4

; ===== function loc_0232AFA8 =====
loc_0232AFA8:
	push {lr}	; 0232AFA8
	sub sp,#0x4	; 0232AFAA
	ldr r1,[pool_0232AFBC]	; 0232AFAC
	ldr r2,[pool_0232AFC0]	; 0232AFAE
	mov r3,#0x1	; 0232AFB0
	bl loc_0232B0AC	; 0232AFB2
	add sp,#0x4	; 0232AFB6
	pop {r3}	; 0232AFB8
	bx r3	; 0232AFBA
pool_0232AFBC:
loc_0232AFBC:
	.word 0x027FFFE8	; 0232AFBC
pool_0232AFC0:
loc_0232AFC0:
	.word 0x0232AF61	; 0232AFC0
loc_0232AFC4:
	push {lr}	; 0232AFC4
	sub sp,#0x4	; 0232AFC6
	mov r3,#0x0	; 0232AFC8
	bl loc_0232AFD4	; 0232AFCA
	add sp,#0x4	; 0232AFCE
	pop {r3}	; 0232AFD0
	bx r3	; 0232AFD2

; ===== function loc_0232AFD4 =====
loc_0232AFD4:
	push {r4,r5,r6,r7,lr}	; 0232AFD4
	sub sp,#0xc	; 0232AFD6
	add r5,r0,#0x0	; 0232AFD8
	add r6,r1,#0x0	; 0232AFDA
	add r4,r2,#0x0	; 0232AFDC
	add r7,r3,#0x0	; 0232AFDE
	cmp r7,#0x0	; 0232AFE0
	beq loc_0232AFEC	; 0232AFE2
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232AFE4
	str r0,[sp,#0x0]	; 0232AFE8
	b loc_0232AFF2	; 0232AFEA
loc_0232AFEC:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232AFEC
	str r0,[sp,#0x0]	; 0232AFF0
loc_0232AFF2:
	add r0,r5,#0x0	; 0232AFF2
	add r1,r6,#0x0	; 0232AFF4
	blx loc_0232E404	; 0232AFF6
	str r0,[sp,#0x4]	; 0232AFFA
	cmp r0,#0x0	; 0232AFFC
	bne loc_0232B008	; 0232AFFE
	cmp r4,#0x0	; 0232B000
	beq loc_0232B006	; 0232B002
	blx r4	; 0232B004
loc_0232B006:
	strh r5,[r6,#0x4]	; 0232B006
loc_0232B008:
	cmp r7,#0x0	; 0232B008
	beq loc_0232B014	; 0232B00A
	ldr r0,[sp,#0x0]	; 0232B00C
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B00E
	b loc_0232B01A	; 0232B012
loc_0232B014:
	ldr r0,[sp,#0x0]	; 0232B014
	blx P1_Arm9RestoreIrqMask	; 0232B016
loc_0232B01A:
	ldr r0,[sp,#0x4]	; 0232B01A
	add sp,#0xc	; 0232B01C
	pop {r4,r5,r6,r7}	; 0232B01E
	pop {r3}	; 0232B020
	bx r3	; 0232B022

; ===== function loc_0232B024 =====
loc_0232B024:
	push {lr}	; 0232B024
	sub sp,#0x4	; 0232B026
	mov r3,#0x0	; 0232B028
	bl loc_0232B044	; 0232B02A
	add sp,#0x4	; 0232B02E
	pop {r3}	; 0232B030
	bx r3	; 0232B032

; ===== function loc_0232B034 =====
loc_0232B034:
	push {lr}	; 0232B034
	sub sp,#0x4	; 0232B036
	mov r3,#0x0	; 0232B038
	bl loc_0232B044	; 0232B03A
	add sp,#0x4	; 0232B03E
	pop {r3}	; 0232B040
	bx r3	; 0232B042

; ===== function loc_0232B044 =====
loc_0232B044:
	push {r4,r5,r6,r7,lr}	; 0232B044
	sub sp,#0x4	; 0232B046
	add r5,r1,#0x0	; 0232B048
	add r4,r2,#0x0	; 0232B04A
	add r6,r3,#0x0	; 0232B04C
	ldrh r1,[r5,#0x4]	; 0232B04E
	cmp r0,r1	; 0232B050
	beq loc_0232B060	; 0232B052
	mov r0,#0x1	; 0232B054
	mvn r0,r0	; 0232B056
	add sp,#0x4	; 0232B058
	pop {r4,r5,r6,r7}	; 0232B05A
	pop {r3}	; 0232B05C
	bx r3	; 0232B05E
loc_0232B060:
	cmp r6,#0x0	; 0232B060
	beq loc_0232B06C	; 0232B062
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B064
	add r7,r0,#0x0	; 0232B068
	b loc_0232B072	; 0232B06A
loc_0232B06C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B06C
	add r7,r0,#0x0	; 0232B070
loc_0232B072:
	mov r0,#0x0	; 0232B072
	strh r0,[r5,#0x4]	; 0232B074
	cmp r4,#0x0	; 0232B076
	beq loc_0232B07C	; 0232B078
	blx r4	; 0232B07A
loc_0232B07C:
	mov r0,#0x0	; 0232B07C
	str r0,[r5,#0x0]	; 0232B07E
	cmp r6,#0x0	; 0232B080
	beq loc_0232B08C	; 0232B082
	add r0,r7,#0x0	; 0232B084
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B086
	b loc_0232B092	; 0232B08A
loc_0232B08C:
	add r0,r7,#0x0	; 0232B08C
	blx P1_Arm9RestoreIrqMask	; 0232B08E
loc_0232B092:
	mov r0,#0x0	; 0232B092
	add sp,#0x4	; 0232B094
	pop {r4,r5,r6,r7}	; 0232B096
	pop {r3}	; 0232B098
	bx r3	; 0232B09A

; ===== function loc_0232B09C =====
loc_0232B09C:
	push {lr}	; 0232B09C
	sub sp,#0x4	; 0232B09E
	mov r3,#0x0	; 0232B0A0
	bl loc_0232B0AC	; 0232B0A2
	add sp,#0x4	; 0232B0A6
	pop {r3}	; 0232B0A8
	bx r3	; 0232B0AA

; ===== function loc_0232B0AC =====
loc_0232B0AC:
	push {r4,r5,r6,r7,lr}	; 0232B0AC
	sub sp,#0x4	; 0232B0AE
	add r5,r0,#0x0	; 0232B0B0
	add r4,r1,#0x0	; 0232B0B2
	add r6,r2,#0x0	; 0232B0B4
	add r7,r3,#0x0	; 0232B0B6
	bl loc_0232AFD4	; 0232B0B8
	cmp r0,#0x0	; 0232B0BC
	ble loc_0232B0D4	; 0232B0BE
loc_0232B0C0:
	bl loc_0232AED8	; 0232B0C0
	add r0,r5,#0x0	; 0232B0C4
	add r1,r4,#0x0	; 0232B0C6
	add r2,r6,#0x0	; 0232B0C8
	add r3,r7,#0x0	; 0232B0CA
	bl loc_0232AFD4	; 0232B0CC
	cmp r0,#0x0	; 0232B0D0
	bgt loc_0232B0C0	; 0232B0D2
loc_0232B0D4:
	add sp,#0x4	; 0232B0D4
	pop {r4,r5,r6,r7}	; 0232B0D6
	pop {r3}	; 0232B0D8
	bx r3	; 0232B0DA

; ===== function loc_0232B0DC =====
loc_0232B0DC:
	push {r4,lr}	; 0232B0DC
	sub sp,#0x8	; 0232B0DE
	ldr r0,[pool_0232B154]	; 0232B0E0
	ldr r1,[r0,#0x0]	; 0232B0E2
	cmp r1,#0x0	; 0232B0E4
	bne loc_0232B14A	; 0232B0E6
	mov r1,#0x1	; 0232B0E8
	str r1,[r0,#0x0]	; 0232B0EA
	mov r2,#0x0	; 0232B0EC
	ldr r1,[pool_0232B158]	; 0232B0EE
	str r2,[r1,#0x0]	; 0232B0F0
	mov r0,#0x7e	; 0232B0F2
	bl loc_0232B09C	; 0232B0F4
	ldr r4,[pool_0232B158]	; 0232B0F8
	ldrh r0,[r4,#0x6]	; 0232B0FA
	cmp r0,#0x0	; 0232B0FC
	beq loc_0232B10A	; 0232B0FE
loc_0232B100:
	bl loc_0232AED8	; 0232B100
	ldrh r0,[r4,#0x6]	; 0232B104
	cmp r0,#0x0	; 0232B106
	bne loc_0232B100	; 0232B108
loc_0232B10A:
	mov r0,#0x0	; 0232B10A
	mvn r2,r0	; 0232B10C
	ldr r1,[pool_0232B15C]	; 0232B10E
	str r2,[r1,#0x0]	; 0232B110
	ldr r2,[pool_0232B160]	; 0232B112
	ldr r1,[pool_0232B164]	; 0232B114
	str r2,[r1,#0x0]	; 0232B116
	str r0,[sp,#0x0]	; 0232B118
	ldr r0,[sp,#0x0]	; 0232B11A
	ldr r1,[pool_0232B168]	; 0232B11C
	mov r2,#0x28	; 0232B11E
	blx loc_0232E320	; 0232B120
	ldr r2,[pool_0232B16C]	; 0232B124
	ldrh r1,[r2,#0x0]	; 0232B126
	ldr r0,[pool_0232B170]	; 0232B128
	orr r1,r0	; 0232B12A
	strh r1,[r2,#0x0]	; 0232B12C
	ldrh r1,[r2,#0x0]	; 0232B12E
	mov r0,#0x80	; 0232B130
	orr r1,r0	; 0232B132
	strh r1,[r2,#0x0]	; 0232B134
	mov r0,#0x7e	; 0232B136
	ldr r1,[pool_0232B158]	; 0232B138
	mov r2,#0x0	; 0232B13A
	bl loc_0232B034	; 0232B13C
	mov r0,#0x7f	; 0232B140
	ldr r1,[pool_0232B158]	; 0232B142
	mov r2,#0x0	; 0232B144
	bl loc_0232B09C	; 0232B146
loc_0232B14A:
	add sp,#0x8	; 0232B14A
	pop {r4}	; 0232B14C
	pop {r3}	; 0232B14E
	bx r3	; 0232B150
	.byte 0xC0, 0x46	; 0232B154
pool_0232B154:
loc_0232B154:
	.word P1_BssStart + 0x26370	; 0232B154
pool_0232B158:
loc_0232B158:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 0232B158
pool_0232B15C:
loc_0232B15C:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B15C
pool_0232B160:
loc_0232B160:
	.word 0xFFFF0000	; 0232B160
pool_0232B164:
loc_0232B164:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset + 0x4	; 0232B164
pool_0232B168:
loc_0232B168:
	.word 0x027FFFC0	; 0232B168
pool_0232B16C:
loc_0232B16C:
	.word REG_EXMEMCNT_ARM9	; 0232B16C
pool_0232B170:
loc_0232B170:
	.word 0x00000800	; 0232B170

; ===== function loc_0232B174 =====
	push {lr}	; 0232B174
	sub sp,#0x4	; 0232B176
	blx P1_Arm9EnableIrqReturnPriorMask	; 0232B178
loc_0232B17C:
	blx P1_Arm9WaitForInterrupt	; 0232B17C
	b loc_0232B17C	; 0232B180
	.byte 0x00, 0x00	; 0232B184

; ===== function loc_0232B184 =====
loc_0232B184:
	push {r4,r5,lr}	; 0232B184
	sub sp,#0x4	; 0232B186
	add r5,r0,#0x0	; 0232B188
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B18A
	ldr r1,[pool_0232B1A4]	; 0232B18E
	ldr r4,[r1,#0x10]	; 0232B190
	str r5,[r1,#0x10]	; 0232B192
	blx P1_Arm9RestoreIrqMask	; 0232B194
	add r0,r4,#0x0	; 0232B198
	add sp,#0x4	; 0232B19A
	pop {r4,r5}	; 0232B19C
	pop {r3}	; 0232B19E
	bx r3	; 0232B1A0
	.byte 0xC0, 0x46	; 0232B1A4
pool_0232B1A4:
loc_0232B1A4:
	.word P1_BssStart + 0x26380	; 0232B1A4

; ===== function loc_0232B1A8 =====
loc_0232B1A8:
	push {r4,r5,r6,lr}	; 0232B1A8
	ldr r6,[pool_0232B20C]	; 0232B1AA
	ldrh r0,[r6,#0x4]	; 0232B1AC
	cmp r0,#0x0	; 0232B1AE
	bne loc_0232B1BA	; 0232B1B0
	blx P1_Arm9GetProcessorMode	; 0232B1B2
	cmp r0,#0x12	; 0232B1B6
	bne loc_0232B1C4	; 0232B1B8
loc_0232B1BA:
	mov r0,#0x1	; 0232B1BA
	strh r0,[r6,#0x0]	; 0232B1BC
	pop {r4,r5,r6}	; 0232B1BE
	pop {r3}	; 0232B1C0
	bx r3	; 0232B1C2
loc_0232B1C4:
	ldr r0,[pool_0232B210]	; 0232B1C4
	ldr r0,[r0,#0x0]	; 0232B1C6
	ldr r5,[r0,#0x0]	; 0232B1C8
	bl loc_0232B218	; 0232B1CA
	add r4,r0,#0x0	; 0232B1CE
	cmp r5,r4	; 0232B1D0
	beq loc_0232B206	; 0232B1D2
	cmp r4,#0x0	; 0232B1D4
	beq loc_0232B206	; 0232B1D6
	add r0,r5,#0x0	; 0232B1D8
	blx loc_0232B584	; 0232B1DA
	cmp r0,#0x0	; 0232B1DE
	bne loc_0232B206	; 0232B1E0
	ldr r0,[pool_0232B214]	; 0232B1E2
	ldr r2,[r0,#0x0]	; 0232B1E4
	cmp r2,#0x0	; 0232B1E6
	beq loc_0232B1F0	; 0232B1E8
	add r0,r5,#0x0	; 0232B1EA
	add r1,r4,#0x0	; 0232B1EC
	blx r2	; 0232B1EE
loc_0232B1F0:
	ldr r2,[r6,#0x10]	; 0232B1F0
	cmp r2,#0x0	; 0232B1F2
	beq loc_0232B1FC	; 0232B1F4
	add r0,r5,#0x0	; 0232B1F6
	add r1,r4,#0x0	; 0232B1F8
	blx r2	; 0232B1FA
loc_0232B1FC:
	ldr r0,[pool_0232B20C]	; 0232B1FC
	str r4,[r0,#0x8]	; 0232B1FE
	add r0,r4,#0x0	; 0232B200
	blx loc_0232B5D0	; 0232B202
loc_0232B206:
	pop {r4,r5,r6}	; 0232B206
	pop {r3}	; 0232B208
	bx r3	; 0232B20A
pool_0232B20C:
loc_0232B20C:
	.word P1_BssStart + 0x26380	; 0232B20C
pool_0232B210:
loc_0232B210:
	.word P1_BssStart + 0x26378	; 0232B210
pool_0232B214:
loc_0232B214:
	.word P1_BssStart + 0x26374	; 0232B214

; ===== function loc_0232B218 =====
loc_0232B218:
	ldr r0,[pool_0232B22C]	; 0232B218
	ldr r0,[r0,#0xc]	; 0232B21A
	b loc_0232B220	; 0232B21C
loc_0232B21E:
	ldr r0,[r0,#0x68]	; 0232B21E
loc_0232B220:
	cmp r0,#0x0	; 0232B220
	beq loc_0232B22A	; 0232B222
	ldr r1,[r0,#0x64]	; 0232B224
	cmp r1,#0x1	; 0232B226
	bne loc_0232B21E	; 0232B228
loc_0232B22A:
	bx lr	; 0232B22A
pool_0232B22C:
loc_0232B22C:
	.word P1_BssStart + 0x26380	; 0232B22C

; ===== function loc_0232B230 =====
loc_0232B230:
	push {r4,r5,r6,lr}	; 0232B230
	add r5,r0,#0x0	; 0232B232
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B234
	add r4,r0,#0x0	; 0232B238
	ldrh r1,[r5,#0x0]	; 0232B23A
	cmp r1,#0x0	; 0232B23C
	beq loc_0232B268	; 0232B23E
	ldr r0,[pool_0232B274]	; 0232B240
	ldr r0,[r0,#0xc]	; 0232B242
	cmp r0,#0x0	; 0232B244
	beq loc_0232B260	; 0232B246
	mov r3,#0x1	; 0232B248
loc_0232B24A:
	ldr r2,[r0,#0x6c]	; 0232B24A
	add r6,r3,#0x0	; 0232B24C
	lsl r6,r2	; 0232B24E
	add r2,r1,#0x0	; 0232B250
	and r2,r6	; 0232B252
	cmp r2,#0x0	; 0232B254
	beq loc_0232B25A	; 0232B256
	str r3,[r0,#0x64]	; 0232B258
loc_0232B25A:
	ldr r0,[r0,#0x68]	; 0232B25A
	cmp r0,#0x0	; 0232B25C
	bne loc_0232B24A	; 0232B25E
loc_0232B260:
	mov r0,#0x0	; 0232B260
	strh r0,[r5,#0x0]	; 0232B262
	bl loc_0232B1A8	; 0232B264
loc_0232B268:
	add r0,r4,#0x0	; 0232B268
	blx P1_Arm9RestoreIrqMask	; 0232B26A
	pop {r4,r5,r6}	; 0232B26E
	pop {r3}	; 0232B270
	bx r3	; 0232B272
pool_0232B274:
loc_0232B274:
	.word P1_BssStart + 0x26380	; 0232B274

; ===== function loc_0232B278 =====
loc_0232B278:
	push {r4,r5,lr}	; 0232B278
	sub sp,#0x4	; 0232B27A
	add r5,r0,#0x0	; 0232B27C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B27E
	add r4,r0,#0x0	; 0232B282
	ldr r0,[pool_0232B2B4]	; 0232B284
	ldr r0,[r0,#0x0]	; 0232B286
	ldr r1,[r0,#0x0]	; 0232B288
	cmp r5,#0x0	; 0232B28A
	beq loc_0232B29E	; 0232B28C
	ldrh r0,[r5,#0x0]	; 0232B28E
	mov r3,#0x1	; 0232B290
	ldr r2,[r1,#0x6c]	; 0232B292
	lsl r3,r2	; 0232B294
	lsl r2,r3,#0x10	; 0232B296
	lsr r2,r2,#0x10	; 0232B298
	orr r0,r2	; 0232B29A
	strh r0,[r5,#0x0]	; 0232B29C
loc_0232B29E:
	mov r0,#0x0	; 0232B29E
	str r0,[r1,#0x64]	; 0232B2A0
	bl loc_0232B1A8	; 0232B2A2
	add r0,r4,#0x0	; 0232B2A6
	blx P1_Arm9RestoreIrqMask	; 0232B2A8
	add sp,#0x4	; 0232B2AC
	pop {r4,r5}	; 0232B2AE
	pop {r3}	; 0232B2B0
	bx r3	; 0232B2B2
pool_0232B2B4:
loc_0232B2B4:
	.word P1_BssStart + 0x26378	; 0232B2B4
	push {r4,lr}	; 0232B2B8
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B2BA
	ldr r0,[pool_0232B2F0]	; 0232B2BE
	ldr r0,[r0,#0x0]	; 0232B2C0
	ldr r4,[r0,#0x0]	; 0232B2C2
	add r0,r4,#0x0	; 0232B2C4
	bl loc_0232B740	; 0232B2C6
	add r0,r4,#0x0	; 0232B2CA
	bl loc_0232B4A0	; 0232B2CC
	mov r2,#0x0	; 0232B2D0
	ldr r0,[r4,#0x6c]	; 0232B2D2
	lsl r1,r0,#0x2	; 0232B2D4
	ldr r0,[pool_0232B2F4]	; 0232B2D6
	str r2,[r0,r1]	; 0232B2D8
	mov r0,#0x2	; 0232B2DA
	str r0,[r4,#0x64]	; 0232B2DC
	add r4,#0x90	; 0232B2DE
	add r0,r4,#0x0	; 0232B2E0
	bl loc_0232B230	; 0232B2E2
	bl loc_0232B1A8	; 0232B2E6
	pop {r4}	; 0232B2EA
	pop {r3}	; 0232B2EC
	bx r3	; 0232B2EE
pool_0232B2F0:
loc_0232B2F0:
	.word P1_BssStart + 0x26378	; 0232B2F0
pool_0232B2F4:
loc_0232B2F4:
	.word P1_BssStart + 0x26394	; 0232B2F4

; ===== function loc_0232B2F8 =====
loc_0232B2F8:
	push {r4,r5,r6,r7,lr}	; 0232B2F8
	sub sp,#0xc	; 0232B2FA
	add r5,r0,#0x0	; 0232B2FC
	str r1,[sp,#0x0]	; 0232B2FE
	add r7,r2,#0x0	; 0232B300
	add r4,r3,#0x0	; 0232B302
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B304
	str r0,[sp,#0x4]	; 0232B308
	bl loc_0232B504	; 0232B30A
	cmp r0,#0x0	; 0232B30E
	bge loc_0232B320	; 0232B310
	ldr r0,[sp,#0x4]	; 0232B312
	blx P1_Arm9RestoreIrqMask	; 0232B314
	add sp,#0xc	; 0232B318
	pop {r4,r5,r6,r7}	; 0232B31A
	pop {r3}	; 0232B31C
	bx r3	; 0232B31E
loc_0232B320:
	ldr r1,[sp,#0x24]	; 0232B320
	str r1,[r5,#0x70]	; 0232B322
	str r0,[r5,#0x6c]	; 0232B324
	mov r1,#0x0	; 0232B326
	str r1,[r5,#0x64]	; 0232B328
	lsl r1,r0,#0x2	; 0232B32A
	ldr r0,[pool_0232B39C]	; 0232B32C
	str r5,[r0,r1]	; 0232B32E
	add r0,r5,#0x0	; 0232B330
	bl loc_0232B4CC	; 0232B332
	add r0,r5,#0x0	; 0232B336
	add r0,#0x88	; 0232B338
	str r4,[r0,#0x0]	; 0232B33A
	ldr r0,[sp,#0x20]	; 0232B33C
	sub r6,r4,r0	; 0232B33E
	add r0,r5,#0x0	; 0232B340
	add r0,#0x84	; 0232B342
	str r6,[r0,#0x0]	; 0232B344
	mov r1,#0x0	; 0232B346
	add r0,r5,#0x0	; 0232B348
	add r0,#0x8c	; 0232B34A
	str r1,[r0,#0x0]	; 0232B34C
	ldr r0,[pool_0232B3A0]	; 0232B34E
	add r1,r5,#0x0	; 0232B350
	add r1,#0x88	; 0232B352
	ldr r1,[r1,#0x0]	; 0232B354
	sub r1,r1,#0x4	; 0232B356
	str r0,[r1,#0x0]	; 0232B358
	ldr r1,[pool_0232B3A4]	; 0232B35A
	add r0,r5,#0x0	; 0232B35C
	add r0,#0x84	; 0232B35E
	ldr r0,[r0,#0x0]	; 0232B360
	str r1,[r0,#0x0]	; 0232B362
	add r0,r5,#0x0	; 0232B364
	ldr r1,[sp,#0x0]	; 0232B366
	sub r2,r4,#0x4	; 0232B368
	blx loc_0232B520	; 0232B36A
	str r7,[r5,#0x4]	; 0232B36E
	ldr r0,[pool_0232B3A8]	; 0232B370
	str r0,[r5,#0x3c]	; 0232B372
	mov r0,#0x0	; 0232B374
	str r0,[sp,#0x8]	; 0232B376
	ldr r0,[sp,#0x8]	; 0232B378
	add r1,r6,#0x4	; 0232B37A
	ldr r2,[sp,#0x20]	; 0232B37C
	sub r2,#0x8	; 0232B37E
	blx loc_0232E320	; 0232B380
	mov r0,#0x0	; 0232B384
	str r0,[r5,#0x78]	; 0232B386
	str r0,[r5,#0x7c]	; 0232B388
	add r5,#0x80	; 0232B38A
	str r0,[r5,#0x0]	; 0232B38C
	ldr r0,[sp,#0x4]	; 0232B38E
	blx P1_Arm9RestoreIrqMask	; 0232B390
	add sp,#0xc	; 0232B394
	pop {r4,r5,r6,r7}	; 0232B396
	pop {r3}	; 0232B398
	bx r3	; 0232B39A
pool_0232B39C:
loc_0232B39C:
	.word P1_BssStart + 0x26394	; 0232B39C
pool_0232B3A0:
loc_0232B3A0:
	.word 0xFDDB597D	; 0232B3A0
pool_0232B3A4:
loc_0232B3A4:
	.word 0x7BF9DD5B	; 0232B3A4
pool_0232B3A8:
loc_0232B3A8:
	.word 0x0232B2B9	; 0232B3A8

; ===== function loc_0232B3AC =====
loc_0232B3AC:
	push {lr}	; 0232B3AC
	sub sp,#0xc	; 0232B3AE
	ldr r0,[pool_0232B45C]	; 0232B3B0
	ldr r1,[r0,#0x0]	; 0232B3B2
	cmp r1,#0x0	; 0232B3B4
	bne loc_0232B454	; 0232B3B6
	mov r1,#0x1	; 0232B3B8
	str r1,[r0,#0x0]	; 0232B3BA
	mov r1,#0x0	; 0232B3BC
	ldr r0,[pool_0232B460]	; 0232B3BE
	add r2,r1,#0x0	; 0232B3C0
loc_0232B3C2:
	str r2,[r0,#0x14]	; 0232B3C2
	add r0,r0,#0x4	; 0232B3C4
	add r1,r1,#0x1	; 0232B3C6
	cmp r1,#0x10	; 0232B3C8
	blt loc_0232B3C2	; 0232B3CA
	ldr r1,[pool_0232B464]	; 0232B3CC
	ldr r0,[pool_0232B468]	; 0232B3CE
	str r1,[r0,#0x0]	; 0232B3D0
	mov r0,#0x10	; 0232B3D2
	ldr r1,[pool_0232B46C]	; 0232B3D4
	str r0,[r1,#0x70]	; 0232B3D6
	str r2,[r1,#0x6c]	; 0232B3D8
	mov r0,#0x1	; 0232B3DA
	str r0,[r1,#0x64]	; 0232B3DC
	str r2,[r1,#0x68]	; 0232B3DE
	str r2,[r1,#0x74]	; 0232B3E0
	ldr r0,[pool_0232B460]	; 0232B3E2
	str r1,[r0,#0x14]	; 0232B3E4
	str r1,[r0,#0xc]	; 0232B3E6
	str r1,[r0,#0x8]	; 0232B3E8
	ldr r2,[pool_0232B470]	; 0232B3EA
	cmp r2,#0x0	; 0232B3EC
	bne loc_0232B3F6	; 0232B3EE
	ldr r0,[pool_0232B474]	; 0232B3F0
	sub r3,r0,r2	; 0232B3F2
	b loc_0232B402	; 0232B3F4
loc_0232B3F6:
	ldr r1,[pool_0232B478]	; 0232B3F6
	ldr r0,[pool_0232B47C]	; 0232B3F8
	add r1,r1,r0	; 0232B3FA
	ldr r0,[pool_0232B480]	; 0232B3FC
	sub r0,r1,r0	; 0232B3FE
	sub r3,r0,r2	; 0232B400
loc_0232B402:
	ldr r1,[pool_0232B478]	; 0232B402
	ldr r0,[pool_0232B47C]	; 0232B404
	add r1,r1,r0	; 0232B406
	ldr r0,[pool_0232B480]	; 0232B408
	sub r1,r1,r0	; 0232B40A
	ldr r2,[pool_0232B484]	; 0232B40C
	str r1,[r2,#0x8]	; 0232B40E
	str r3,[r2,#0x4]	; 0232B410
	mov r0,#0x0	; 0232B412
	str r0,[r2,#0xc]	; 0232B414
	ldr r3,[pool_0232B488]	; 0232B416
	sub r1,r1,#0x4	; 0232B418
	str r3,[r1,#0x0]	; 0232B41A
	ldr r3,[pool_0232B48C]	; 0232B41C
	ldr r1,[r2,#0x4]	; 0232B41E
	str r3,[r1,#0x0]	; 0232B420
	strh r0,[r2,#0x10]	; 0232B422
	mov r2,#0x10	; 0232B424
	ldr r1,[pool_0232B460]	; 0232B426
	strh r2,[r1,#0x2]	; 0232B428
	strh r0,[r1,#0x0]	; 0232B42A
	strh r0,[r1,#0x4]	; 0232B42C
	ldr r2,[pool_0232B490]	; 0232B42E
	str r1,[r2,#0x0]	; 0232B430
	bl loc_0232B184	; 0232B432
	mov r0,#0xc8	; 0232B436
	str r0,[sp,#0x0]	; 0232B438
	mov r0,#0x1f	; 0232B43A
	str r0,[sp,#0x4]	; 0232B43C
	ldr r0,[pool_0232B494]	; 0232B43E
	ldr r1,[pool_0232B498]	; 0232B440
	mov r2,#0x0	; 0232B442
	ldr r3,[pool_0232B49C]	; 0232B444
	bl loc_0232B2F8	; 0232B446
	mov r1,#0x20	; 0232B44A
	ldr r0,[pool_0232B494]	; 0232B44C
	str r1,[r0,#0x70]	; 0232B44E
	mov r1,#0x1	; 0232B450
	str r1,[r0,#0x64]	; 0232B452
loc_0232B454:
	add sp,#0xc	; 0232B454
	pop {r3}	; 0232B456
	bx r3	; 0232B458
	.byte 0xC0, 0x46	; 0232B45C
pool_0232B45C:
loc_0232B45C:
	.word P1_BssStart + 0x2637C	; 0232B45C
pool_0232B460:
loc_0232B460:
	.word P1_BssStart + 0x26380	; 0232B460
pool_0232B464:
loc_0232B464:
	.word 0x02357208	; 0232B464
pool_0232B468:
loc_0232B468:
	.word P1_BssStart + 0x26378	; 0232B468
pool_0232B46C:
loc_0232B46C:
	.word P1_BssStart + 0x26468	; 0232B46C
pool_0232B470:
loc_0232B470:
	.word 0x00000000	; 0232B470
pool_0232B474:
loc_0232B474:
	.word 0x03000020	; 0232B474
pool_0232B478:
loc_0232B478:
	.word 0x03000000	; 0232B478
pool_0232B47C:
loc_0232B47C:
	.word 0x00003FC0	; 0232B47C
pool_0232B480:
loc_0232B480:
	.word 0x00001000	; 0232B480
pool_0232B484:
loc_0232B484:
	.word P1_BssStart + 0x264E8	; 0232B484
pool_0232B488:
loc_0232B488:
	.word 0xFDDB597D	; 0232B488
pool_0232B48C:
loc_0232B48C:
	.word 0x7BF9DD5B	; 0232B48C
pool_0232B490:
loc_0232B490:
	.word FirmwareSystemWorkAddress + SystemWorkArm9ThreadInfoOffset	; 0232B490
pool_0232B494:
loc_0232B494:
	.word P1_BssStart + 0x263D4	; 0232B494
pool_0232B498:
loc_0232B498:
	.word 0x0232B175	; 0232B498
pool_0232B49C:
loc_0232B49C:
	.word 0x02357444	; 0232B49C

; ===== function loc_0232B4A0 =====
loc_0232B4A0:
	ldr r1,[pool_0232B4C8]	; 0232B4A0
	ldr r2,[r1,#0xc]	; 0232B4A2
	mov r1,#0x0	; 0232B4A4
	b loc_0232B4AC	; 0232B4A6
loc_0232B4A8:
	add r1,r2,#0x0	; 0232B4A8
	ldr r2,[r2,#0x68]	; 0232B4AA
loc_0232B4AC:
	cmp r2,#0x0	; 0232B4AC
	beq loc_0232B4B4	; 0232B4AE
	cmp r2,r0	; 0232B4B0
	bne loc_0232B4A8	; 0232B4B2
loc_0232B4B4:
	cmp r1,#0x0	; 0232B4B4
	bne loc_0232B4C0	; 0232B4B6
	ldr r1,[r0,#0x68]	; 0232B4B8
	ldr r0,[pool_0232B4C8]	; 0232B4BA
	str r1,[r0,#0xc]	; 0232B4BC
	bx lr	; 0232B4BE
loc_0232B4C0:
	ldr r0,[r0,#0x68]	; 0232B4C0
	str r0,[r1,#0x68]	; 0232B4C2
	bx lr	; 0232B4C4
	.byte 0xC0, 0x46	; 0232B4C8
pool_0232B4C8:
loc_0232B4C8:
	.word P1_BssStart + 0x26380	; 0232B4C8

; ===== function loc_0232B4CC =====
loc_0232B4CC:
	push {r4,r5}	; 0232B4CC
	ldr r1,[pool_0232B500]	; 0232B4CE
	ldr r3,[r1,#0xc]	; 0232B4D0
	add r5,r3,#0x0	; 0232B4D2
	mov r4,#0x0	; 0232B4D4
	b loc_0232B4DC	; 0232B4D6
loc_0232B4D8:
	add r4,r5,#0x0	; 0232B4D8
	ldr r5,[r5,#0x68]	; 0232B4DA
loc_0232B4DC:
	cmp r5,#0x0	; 0232B4DC
	beq loc_0232B4E8	; 0232B4DE
	ldr r2,[r5,#0x70]	; 0232B4E0
	ldr r1,[r0,#0x70]	; 0232B4E2
	cmp r2,r1	; 0232B4E4
	bcc loc_0232B4D8	; 0232B4E6
loc_0232B4E8:
	cmp r4,#0x0	; 0232B4E8
	bne loc_0232B4F6	; 0232B4EA
	str r3,[r0,#0x68]	; 0232B4EC
	ldr r1,[pool_0232B500]	; 0232B4EE
	str r0,[r1,#0xc]	; 0232B4F0
	pop {r4,r5}	; 0232B4F2
	bx lr	; 0232B4F4
loc_0232B4F6:
	ldr r1,[r4,#0x68]	; 0232B4F6
	str r1,[r0,#0x68]	; 0232B4F8
	str r0,[r4,#0x68]	; 0232B4FA
	pop {r4,r5}	; 0232B4FC
	bx lr	; 0232B4FE
pool_0232B500:
loc_0232B500:
	.word P1_BssStart + 0x26380	; 0232B500

; ===== function loc_0232B504 =====
loc_0232B504:
	mov r0,#0x0	; 0232B504
	ldr r2,[pool_0232B51C]	; 0232B506
loc_0232B508:
	ldr r1,[r2,#0x14]	; 0232B508
	cmp r1,#0x0	; 0232B50A
	beq loc_0232B51A	; 0232B50C
	add r2,r2,#0x4	; 0232B50E
	add r0,r0,#0x1	; 0232B510
	cmp r0,#0x10	; 0232B512
	blt loc_0232B508	; 0232B514
	mov r0,#0x0	; 0232B516
	mvn r0,r0	; 0232B518
loc_0232B51A:
	bx lr	; 0232B51A
pool_0232B51C:
loc_0232B51C:
	.word P1_BssStart + 0x26380	; 0232B51C
.arm

; ===== function loc_0232B520 =====
loc_0232B520:
	add r1,r1,#0x4	; 0232B520
	str r1,[r0,#0x40]	; 0232B524
	str r2,[r0,#0x44]	; 0232B528
	sub r2,r2,#0x40	; 0232B52C
	str r2,[r0,#0x38]	; 0232B530
	ands r1,r1,#0x1	; 0232B534
	movne r1,#0x3f	; 0232B538
	moveq r1,#0x1f	; 0232B53C
	str r1,[r0,#0x0]	; 0232B540
	mov r1,#0x0	; 0232B544
	str r1,[r0,#0x4]	; 0232B548
	str r1,[r0,#0x8]	; 0232B54C
	str r1,[r0,#0xc]	; 0232B550
	str r1,[r0,#0x10]	; 0232B554
	str r1,[r0,#0x14]	; 0232B558
	str r1,[r0,#0x18]	; 0232B55C
	str r1,[r0,#0x1c]	; 0232B560
	str r1,[r0,#0x20]	; 0232B564
	str r1,[r0,#0x24]	; 0232B568
	str r1,[r0,#0x28]	; 0232B56C
	str r1,[r0,#0x2c]	; 0232B570
	str r1,[r0,#0x30]	; 0232B574
	str r1,[r0,#0x34]	; 0232B578
	str r1,[r0,#0x3c]	; 0232B57C
	bx lr	; 0232B580

; ===== function loc_0232B584 =====
loc_0232B584:
	stmdb sp!,{r0,lr}	; 0232B584
	add r0,r0,#0x48	; 0232B588
	ldr r1,[pool_0232B5CC]	; 0232B58C
	blx r1	; 0232B590
	ldmia sp!,{r0,lr}	; 0232B594
	add r1,r0,#0x0	; 0232B598
	mrs r2,cpsr	; 0232B59C
	str r2,[r1],#0x4	; 0232B5A0
	mov r0,#0xd3	; 0232B5A4
	msr cpsr_c,r0	; 0232B5A8
	str sp,[r1,#0x40]	; 0232B5AC
	msr cpsr_c,r2	; 0232B5B0
	mov r0,#0x1	; 0232B5B4
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 0232B5B8
	adr r0,loc_0232B5CC	; 0232B5BC
	str r0,[r1,#0x3c]	; 0232B5C0
	mov r0,#0x0	; 0232B5C4
	bx lr	; 0232B5C8
pool_0232B5CC:
loc_0232B5CC:
	.word loc_0232EF98 + 1	; 0232B5CC

; ===== function loc_0232B5D0 =====
loc_0232B5D0:
	stmdb sp!,{r0,lr}	; 0232B5D0
	add r0,r0,#0x48	; 0232B5D4
	ldr r1,[pool_0232B610]	; 0232B5D8
	blx r1	; 0232B5DC
	ldmia sp!,{r0,lr}	; 0232B5E0
	mrs r1,cpsr	; 0232B5E4
	bic r1,r1,#0x1f	; 0232B5E8
	orr r1,r1,#0xd3	; 0232B5EC
	msr cpsr_c,r1	; 0232B5F0
	ldr r1,[r0],#0x4	; 0232B5F4
	msr spsr_cxsf,r1	; 0232B5F8
	ldr sp,[r0,#0x40]	; 0232B5FC
	ldr lr,[r0,#0x3c]	; 0232B600
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 0232B604
	mov r0,r0	; 0232B608
	subs pc,lr,#0x4	; 0232B60C
pool_0232B610:
loc_0232B610:
	.word loc_0232EF58 + 1	; 0232B610
.thumb

; ===== function loc_0232B614 =====
loc_0232B614:
	ldr r0,[pool_0232B61C]	; 0232B614
	ldr r1,[pool_0232B620]	; 0232B616
	str r0,[r1,#0x0]	; 0232B618
	bx lr	; 0232B61A
pool_0232B61C:
loc_0232B61C:
	.word 0x82000001	; 0232B61C
pool_0232B620:
loc_0232B620:
	.word P1_Data_02330E64	; 0232B620

; ===== function loc_0232B624 =====
loc_0232B624:
	mov r0,#0x0	; 0232B624
	bx lr	; 0232B626

; ===== function loc_0232B628 =====
loc_0232B628:
	push {r4,r5,r6,r7,lr}	; 0232B628
	sub sp,#0x4	; 0232B62A
	add r5,r0,#0x0	; 0232B62C
	add r7,r1,#0x0	; 0232B62E
	add r4,r2,#0x0	; 0232B630
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B632
	str r0,[sp,#0x0]	; 0232B636
	ldr r0,[r5,#0x10]	; 0232B638
	cmp r0,#0x0	; 0232B63A
	bne loc_0232B664	; 0232B63C
	mov r0,#0x1	; 0232B63E
	and r4,r0	; 0232B640
	add r6,r5,#0x2	; 0232B642
loc_0232B644:
	cmp r4,#0x0	; 0232B644
	bne loc_0232B658	; 0232B646
	ldr r0,[sp,#0x0]	; 0232B648
	blx P1_Arm9RestoreIrqMask	; 0232B64A
	mov r0,#0x0	; 0232B64E
	add sp,#0x4	; 0232B650
	pop {r4,r5,r6,r7}	; 0232B652
	pop {r3}	; 0232B654
	bx r3	; 0232B656
loc_0232B658:
	add r0,r6,#0x0	; 0232B658
	bl loc_0232B278	; 0232B65A
	ldr r0,[r5,#0x10]	; 0232B65E
	cmp r0,#0x0	; 0232B660
	beq loc_0232B644	; 0232B662
loc_0232B664:
	cmp r7,#0x0	; 0232B664
	beq loc_0232B672	; 0232B666
	ldr r1,[r5,#0x4]	; 0232B668
	ldr r0,[r5,#0xc]	; 0232B66A
	lsl r0,r0,#0x2	; 0232B66C
	ldr r0,[r1,r0]	; 0232B66E
	str r0,[r7,#0x0]	; 0232B670
loc_0232B672:
	ldr r0,[r5,#0xc]	; 0232B672
	add r0,r0,#0x1	; 0232B674
	ldr r1,[r5,#0x8]	; 0232B676
	blx P1_SignedDivMod	; 0232B678
	str r1,[r5,#0xc]	; 0232B67C
	add r1,r5,#0x0	; 0232B67E
	add r1,#0x10	; 0232B680
	ldr r0,[r1,#0x0]	; 0232B682
	sub r0,r0,#0x1	; 0232B684
	str r0,[r1,#0x0]	; 0232B686
	add r0,r5,#0x0	; 0232B688
	bl loc_0232B230	; 0232B68A
	ldr r0,[sp,#0x0]	; 0232B68E
	blx P1_Arm9RestoreIrqMask	; 0232B690
	mov r0,#0x1	; 0232B694
	add sp,#0x4	; 0232B696
	pop {r4,r5,r6,r7}	; 0232B698
	pop {r3}	; 0232B69A
	bx r3	; 0232B69C
	.byte 0x00, 0x00	; 0232B6A0

; ===== function loc_0232B6A0 =====
loc_0232B6A0:
	push {r4,r5,r6,r7,lr}	; 0232B6A0
	sub sp,#0x4	; 0232B6A2
	add r5,r0,#0x0	; 0232B6A4
	add r6,r1,#0x0	; 0232B6A6
	add r4,r2,#0x0	; 0232B6A8
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B6AA
	add r7,r0,#0x0	; 0232B6AE
	ldr r2,[r5,#0x10]	; 0232B6B0
	ldr r1,[r5,#0x8]	; 0232B6B2
	cmp r1,r2	; 0232B6B4
	bgt loc_0232B6DE	; 0232B6B6
	mov r0,#0x1	; 0232B6B8
	and r4,r0	; 0232B6BA
loc_0232B6BC:
	cmp r4,#0x0	; 0232B6BC
	bne loc_0232B6D0	; 0232B6BE
	add r0,r7,#0x0	; 0232B6C0
	blx P1_Arm9RestoreIrqMask	; 0232B6C2
	mov r0,#0x0	; 0232B6C6
	add sp,#0x4	; 0232B6C8
	pop {r4,r5,r6,r7}	; 0232B6CA
	pop {r3}	; 0232B6CC
	bx r3	; 0232B6CE
loc_0232B6D0:
	add r0,r5,#0x0	; 0232B6D0
	bl loc_0232B278	; 0232B6D2
	ldr r2,[r5,#0x10]	; 0232B6D6
	ldr r1,[r5,#0x8]	; 0232B6D8
	cmp r1,r2	; 0232B6DA
	ble loc_0232B6BC	; 0232B6DC
loc_0232B6DE:
	ldr r0,[r5,#0xc]	; 0232B6DE
	add r0,r0,r2	; 0232B6E0
	blx P1_SignedDivMod	; 0232B6E2
	ldr r2,[r5,#0x4]	; 0232B6E6
	lsl r0,r1,#0x2	; 0232B6E8
	str r6,[r2,r0]	; 0232B6EA
	add r1,r5,#0x0	; 0232B6EC
	add r1,#0x10	; 0232B6EE
	ldr r0,[r1,#0x0]	; 0232B6F0
	add r0,r0,#0x1	; 0232B6F2
	str r0,[r1,#0x0]	; 0232B6F4
	add r0,r5,#0x2	; 0232B6F6
	bl loc_0232B230	; 0232B6F8
	add r0,r7,#0x0	; 0232B6FC
	blx P1_Arm9RestoreIrqMask	; 0232B6FE
	mov r0,#0x1	; 0232B702
	add sp,#0x4	; 0232B704
	pop {r4,r5,r6,r7}	; 0232B706
	pop {r3}	; 0232B708
	bx r3	; 0232B70A
P1_Entry_0232B70C:
	mov r3,#0x0	; 0232B70C
	strh r3,[r0,#0x0]	; 0232B70E
	strh r3,[r0,#0x2]	; 0232B710
	str r1,[r0,#0x4]	; 0232B712
	str r2,[r0,#0x8]	; 0232B714
	str r3,[r0,#0xc]	; 0232B716
	str r3,[r0,#0x10]	; 0232B718
	bx lr	; 0232B71A

; ===== function loc_0232B71C =====
loc_0232B71C:
	push {r4}	; 0232B71C
	sub sp,#0x4	; 0232B71E
	ldr r4,[r0,#0x7c]	; 0232B720
	ldr r3,[r4,#0x10]	; 0232B722
	cmp r3,#0x0	; 0232B724
	bne loc_0232B732	; 0232B726
	mov r2,#0x0	; 0232B728
	add r1,r0,#0x0	; 0232B72A
	add r1,#0x80	; 0232B72C
	str r2,[r1,#0x0]	; 0232B72E
	b loc_0232B736	; 0232B730
loc_0232B732:
	mov r1,#0x0	; 0232B732
	str r1,[r3,#0xc]	; 0232B734
loc_0232B736:
	str r3,[r0,#0x7c]	; 0232B736
	add r0,r4,#0x0	; 0232B738
	add sp,#0x4	; 0232B73A
	pop {r4}	; 0232B73C
	bx lr	; 0232B73E

; ===== function loc_0232B740 =====
loc_0232B740:
	push {r4,r5,lr}	; 0232B740
	sub sp,#0x4	; 0232B742
	add r5,r0,#0x0	; 0232B744
	ldr r0,[r5,#0x7c]	; 0232B746
	cmp r0,#0x0	; 0232B748
	beq loc_0232B762	; 0232B74A
	mov r4,#0x0	; 0232B74C
loc_0232B74E:
	add r0,r5,#0x0	; 0232B74E
	bl loc_0232B71C	; 0232B750
	str r4,[r0,#0x8]	; 0232B754
	str r4,[r0,#0x4]	; 0232B756
	bl loc_0232B230	; 0232B758
	ldr r0,[r5,#0x7c]	; 0232B75C
	cmp r0,#0x0	; 0232B75E
	bne loc_0232B74E	; 0232B760
loc_0232B762:
	add sp,#0x4	; 0232B762
	pop {r4,r5}	; 0232B764
	pop {r3}	; 0232B766
	bx r3	; 0232B768
	.byte 0x00, 0x00	; 0232B76C

; ===== function loc_0232B76C =====
loc_0232B76C:
	mov r1,#0x0	; 0232B76C
	strh r1,[r0,#0x0]	; 0232B76E
	str r1,[r0,#0x4]	; 0232B770
	str r1,[r0,#0x8]	; 0232B772
	bx lr	; 0232B774
	.byte 0x00, 0x00	; 0232B778
.arm

; ===== function loc_0232B778 =====
; 以 ARM946 cache index 遍历并清理整个 D-cache。
; Cleans the entire ARM946 D-cache by cache index.
.func P1_CleanEntireDataCacheByIndex
loc_0232B778:
	mov r1,#0x0	; 0232B778
loc_0232B77C:
	mov r0,#0x0	; 0232B77C
loc_0232B780:
	orr r2,r1,r0	; 0232B780
	mcr p15,0x0,r2,c7,c10,0x2	; 0232B784
	add r0,r0,#0x20	; 0232B788
	cmp r0,#0x400	; 0232B78C
	blt loc_0232B780	; 0232B790
	add r1,r1,#0x40000000	; 0232B794
	cmp r1,#0x0	; 0232B798
	bne loc_0232B77C	; 0232B79C
	bx lr	; 0232B7A0

.endfunc

; ===== function loc_0232B7A4 =====
; 以 ARM946 cache index 遍历，清理并失效整个 D-cache。
; Cleans and invalidates the entire ARM946 D-cache by cache index.
.func P1_CleanAndInvalidateEntireDataCacheByIndex
loc_0232B7A4:
	mov r1,#0x0	; 0232B7A4
loc_0232B7A8:
	mov r0,#0x0	; 0232B7A8
loc_0232B7AC:
	orr r2,r1,r0	; 0232B7AC
	mcr p15,0x0,r2,c7,c14,0x2	; 0232B7B0
	add r0,r0,#0x20	; 0232B7B4
	cmp r0,#0x400	; 0232B7B8
	blt loc_0232B7AC	; 0232B7BC
	add r1,r1,#0x40000000	; 0232B7C0
	cmp r1,#0x0	; 0232B7C4
	bne loc_0232B7A8	; 0232B7C8
	bx lr	; 0232B7CC

.endfunc

; ===== function loc_0232B7D0 =====
; 按 ARM946 32 字节 cache line 失效指定的 D-cache 地址范围。
; Invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_InvalidateDataCacheRange
loc_0232B7D0:
	add r1,r1,r0	; 0232B7D0
	bic r0,r0,#0x1f	; 0232B7D4
loc_0232B7D8:
	mcr p15,0x0,r0,c7,c6,0x1	; 0232B7D8
	add r0,r0,#0x20	; 0232B7DC
	cmp r0,r1	; 0232B7E0
	blt loc_0232B7D8	; 0232B7E4
	bx lr	; 0232B7E8

.endfunc

; ===== function loc_0232B7EC =====
; 按 ARM946 32 字节 cache line 清理指定的 D-cache 地址范围。
; Cleans a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanDataCacheRange
loc_0232B7EC:
	add r1,r1,r0	; 0232B7EC
	bic r0,r0,#0x1f	; 0232B7F0
loc_0232B7F4:
	mcr p15,0x0,r0,c7,c10,0x1	; 0232B7F4
	add r0,r0,#0x20	; 0232B7F8
	cmp r0,r1	; 0232B7FC
	blt loc_0232B7F4	; 0232B800
	bx lr	; 0232B804

.endfunc

; ===== function loc_0232B808 =====
; 按 ARM946 32 字节 cache line 清理并失效指定的 D-cache 地址范围。
; Cleans and invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanAndInvalidateDataCacheRange
loc_0232B808:
	add r1,r1,r0	; 0232B808
	bic r0,r0,#0x1f	; 0232B80C
loc_0232B810:
	mcr p15,0x0,r0,c7,c14,0x1	; 0232B810
	add r0,r0,#0x20	; 0232B814
	cmp r0,r1	; 0232B818
	blt loc_0232B810	; 0232B81C
	bx lr	; 0232B820
.endfunc
.arm
; 排空 ARM946 写缓冲区，确保先前存储操作完成。
; Drains the ARM946 write buffer so prior stores complete.
.func P1_DrainWriteBuffer
loc_0232B824:
	mov r0,#0x0	; 0232B824
	mcr p15,0x0,r0,c7,c10,0x4	; 0232B828
	bx lr	; 0232B82C
.endfunc
.thumb

; ===== function loc_0232B830 =====
loc_0232B830:
	push {lr}	; 0232B830
	sub sp,#0x4	; 0232B832
	bl loc_0232B958	; 0232B834
	bl loc_0232ECB8	; 0232B838
	bl loc_0232B0DC	; 0232B83C
	bl loc_0232B954	; 0232B840
	bl loc_0232AE34	; 0232B844
	bl P1_InitExceptionHandler	; 0232B848
	mov r0,#0x3	; 0232B84C
	bl loc_0232E1C8	; 0232B84E
	bl loc_0232C09C	; 0232B852
	bl loc_0232B3AC	; 0232B856
	bl loc_0232C3B8	; 0232B85A
	bl loc_0232FA18	; 0232B85E
	add sp,#0x4	; 0232B862
	pop {r3}	; 0232B864
	bx r3	; 0232B866

; ===== function loc_0232B868 =====
loc_0232B868:
	lsl r2,r0,#0x2	; 0232B868
	ldr r0,[pool_0232B870]	; 0232B86A
	str r1,[r2,r0]	; 0232B86C
	bx lr	; 0232B86E
pool_0232B870:
loc_0232B870:
	.word 0x027FFDA0	; 0232B870

; ===== function loc_0232B874 =====
loc_0232B874:
	lsl r2,r0,#0x2	; 0232B874
	ldr r0,[pool_0232B87C]	; 0232B876
	str r1,[r2,r0]	; 0232B878
	bx lr	; 0232B87A
pool_0232B87C:
loc_0232B87C:
	.word 0x027FFDC4	; 0232B87C

; ===== function loc_0232B880 =====
loc_0232B880:
	cmp r0,#0x6	; 0232B880
	bhi loc_0232B8B8	; 0232B882
	add r0,r0,r0	; 0232B884
P1_SwitchIndexPC_0232B884:
	add r0,pc	; 0232B886
	ldrh r0,[r0,#(P1_SwitchTable_0232B884 - (P1_SwitchIndexPC_0232B884 + 4))]	; 0232B888
	lsl r0,r0,#0x10	; 0232B88A
	asr r0,r0,#0x10	; 0232B88C
P1_SwitchTargetPC_0232B884:
	add r0,pc	; 0232B88E
	bx r0	; 0232B890
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232B884:
	.halfword (loc_0232B8A0 + 1) - (P1_SwitchTargetPC_0232B884 + 4)
	.halfword (loc_0232B8B8 + 1) - (P1_SwitchTargetPC_0232B884 + 4)
	.halfword (loc_0232B8A4 + 1) - (P1_SwitchTargetPC_0232B884 + 4)
	.halfword (loc_0232B8A8 + 1) - (P1_SwitchTargetPC_0232B884 + 4)
	.halfword (loc_0232B8AC + 1) - (P1_SwitchTargetPC_0232B884 + 4)
	.halfword (loc_0232B8B0 + 1) - (P1_SwitchTargetPC_0232B884 + 4)
	.halfword (loc_0232B8B4 + 1) - (P1_SwitchTargetPC_0232B884 + 4)
P1_SwitchTable_0232B884End:
loc_0232B8A0:
	ldr r0,[pool_0232B8BC]	; 0232B8A0
	bx lr	; 0232B8A2
loc_0232B8A4:
	mov r0,#0x0	; 0232B8A4
	bx lr	; 0232B8A6
loc_0232B8A8:
	ldr r0,[pool_0232B8C0]	; 0232B8A8
	bx lr	; 0232B8AA
loc_0232B8AC:
	ldr r0,[pool_0232B8C4]	; 0232B8AC
	bx lr	; 0232B8AE
loc_0232B8B0:
	ldr r0,[pool_0232B8C8]	; 0232B8B0
	bx lr	; 0232B8B2
loc_0232B8B4:
	ldr r0,[pool_0232B8CC]	; 0232B8B4
	bx lr	; 0232B8B6
loc_0232B8B8:
	mov r0,#0x0	; 0232B8B8
	bx lr	; 0232B8BA
pool_0232B8BC:
loc_0232B8BC:
	.word 0x023E3B00	; 0232B8BC
pool_0232B8C0:
loc_0232B8C0:
	.word 0x01FF8320	; 0232B8C0
pool_0232B8C4:
loc_0232B8C4:
	.word 0x03000020	; 0232B8C4
pool_0232B8C8:
loc_0232B8C8:
	.word 0x027FF000	; 0232B8C8
pool_0232B8CC:
loc_0232B8CC:
	.word 0x037F8000	; 0232B8CC

; ===== function loc_0232B8D0 =====
loc_0232B8D0:
	cmp r0,#0x6	; 0232B8D0
	bhi loc_0232B92A	; 0232B8D2
	add r0,r0,r0	; 0232B8D4
P1_SwitchIndexPC_0232B8D4:
	add r0,pc	; 0232B8D6
	ldrh r0,[r0,#(P1_SwitchTable_0232B8D4 - (P1_SwitchIndexPC_0232B8D4 + 4))]	; 0232B8D8
	lsl r0,r0,#0x10	; 0232B8DA
	asr r0,r0,#0x10	; 0232B8DC
P1_SwitchTargetPC_0232B8D4:
	add r0,pc	; 0232B8DE
	bx r0	; 0232B8E0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232B8D4:
	.halfword (loc_0232B8F0 + 1) - (P1_SwitchTargetPC_0232B8D4 + 4)
	.halfword (loc_0232B92A + 1) - (P1_SwitchTargetPC_0232B8D4 + 4)
	.halfword (loc_0232B8F4 + 1) - (P1_SwitchTargetPC_0232B8D4 + 4)
	.halfword (loc_0232B8F8 + 1) - (P1_SwitchTargetPC_0232B8D4 + 4)
	.halfword (loc_0232B8FC + 1) - (P1_SwitchTargetPC_0232B8D4 + 4)
	.halfword (loc_0232B922 + 1) - (P1_SwitchTargetPC_0232B8D4 + 4)
	.halfword (loc_0232B926 + 1) - (P1_SwitchTargetPC_0232B8D4 + 4)
P1_SwitchTable_0232B8D4End:
loc_0232B8F0:
	ldr r0,[pool_0232B930]	; 0232B8F0
	bx lr	; 0232B8F2
loc_0232B8F4:
	mov r0,#0x0	; 0232B8F4
	bx lr	; 0232B8F6
loc_0232B8F8:
	ldr r0,[pool_0232B934]	; 0232B8F8
	bx lr	; 0232B8FA
loc_0232B8FC:
	ldr r0,[pool_0232B938]	; 0232B8FC
	ldr r1,[pool_0232B93C]	; 0232B8FE
	add r2,r0,r1	; 0232B900
	ldr r1,[pool_0232B940]	; 0232B902
	sub r2,r2,r1	; 0232B904
	ldr r1,[pool_0232B944]	; 0232B906
	cmp r1,#0x0	; 0232B908
	bne loc_0232B916	; 0232B90A
	ldr r1,[pool_0232B948]	; 0232B90C
	cmp r0,r1	; 0232B90E
	bcs loc_0232B92C	; 0232B910
	add r0,r1,#0x0	; 0232B912
	bx lr	; 0232B914
loc_0232B916:
	cmp r1,#0x0	; 0232B916
	bge loc_0232B91E	; 0232B918
	sub r0,r0,r1	; 0232B91A
	bx lr	; 0232B91C
loc_0232B91E:
	sub r0,r2,r1	; 0232B91E
	bx lr	; 0232B920
loc_0232B922:
	ldr r0,[pool_0232B94C]	; 0232B922
	bx lr	; 0232B924
loc_0232B926:
	ldr r0,[pool_0232B950]	; 0232B926
	bx lr	; 0232B928
loc_0232B92A:
	mov r0,#0x0	; 0232B92A
loc_0232B92C:
	bx lr	; 0232B92C
	.byte 0xC0, 0x46	; 0232B930
pool_0232B930:
loc_0232B930:
	.word 0x023C0000	; 0232B930
pool_0232B934:
loc_0232B934:
	.word 0x02000000	; 0232B934
pool_0232B938:
loc_0232B938:
	.word 0x03000000	; 0232B938
pool_0232B93C:
loc_0232B93C:
	.word 0x00003F80	; 0232B93C
pool_0232B940:
loc_0232B940:
	.word 0x00001000	; 0232B940
pool_0232B944:
loc_0232B944:
	.word 0x00000000	; 0232B944
pool_0232B948:
loc_0232B948:
	.word 0x03000020	; 0232B948
pool_0232B94C:
loc_0232B94C:
	.word 0x027FF800	; 0232B94C
pool_0232B950:
loc_0232B950:
	.word 0x037F8000	; 0232B950

; ===== function loc_0232B954 =====
loc_0232B954:
	bx lr	; 0232B954
	.byte 0x00, 0x00	; 0232B958

; ===== function loc_0232B958 =====
loc_0232B958:
	push {lr}	; 0232B958
	sub sp,#0x4	; 0232B95A
	ldr r0,[pool_0232BA0C]	; 0232B95C
	ldr r1,[r0,#0x0]	; 0232B95E
	cmp r1,#0x0	; 0232B960
	bne loc_0232BA04	; 0232B962
	mov r1,#0x1	; 0232B964
	str r1,[r0,#0x0]	; 0232B966
	mov r0,#0x0	; 0232B968
	bl loc_0232B8D0	; 0232B96A
	add r1,r0,#0x0	; 0232B96E
	mov r0,#0x0	; 0232B970
	bl loc_0232B874	; 0232B972
	mov r0,#0x0	; 0232B976
	bl loc_0232B880	; 0232B978
	add r1,r0,#0x0	; 0232B97C
	mov r0,#0x0	; 0232B97E
	bl loc_0232B868	; 0232B980
	mov r0,#0x2	; 0232B984
	mov r1,#0x0	; 0232B986
	bl loc_0232B868	; 0232B988
	mov r0,#0x2	; 0232B98C
	mov r1,#0x0	; 0232B98E
	bl loc_0232B874	; 0232B990
	mov r0,#0x3	; 0232B994
	bl loc_0232B8D0	; 0232B996
	add r1,r0,#0x0	; 0232B99A
	mov r0,#0x3	; 0232B99C
	bl loc_0232B874	; 0232B99E
	mov r0,#0x3	; 0232B9A2
	bl loc_0232B880	; 0232B9A4
	add r1,r0,#0x0	; 0232B9A8
	mov r0,#0x3	; 0232B9AA
	bl loc_0232B868	; 0232B9AC
	mov r0,#0x4	; 0232B9B0
	bl loc_0232B8D0	; 0232B9B2
	add r1,r0,#0x0	; 0232B9B6
	mov r0,#0x4	; 0232B9B8
	bl loc_0232B874	; 0232B9BA
	mov r0,#0x4	; 0232B9BE
	bl loc_0232B880	; 0232B9C0
	add r1,r0,#0x0	; 0232B9C4
	mov r0,#0x4	; 0232B9C6
	bl loc_0232B868	; 0232B9C8
	mov r0,#0x5	; 0232B9CC
	bl loc_0232B8D0	; 0232B9CE
	add r1,r0,#0x0	; 0232B9D2
	mov r0,#0x5	; 0232B9D4
	bl loc_0232B874	; 0232B9D6
	mov r0,#0x5	; 0232B9DA
	bl loc_0232B880	; 0232B9DC
	add r1,r0,#0x0	; 0232B9E0
	mov r0,#0x5	; 0232B9E2
	bl loc_0232B868	; 0232B9E4
	mov r0,#0x6	; 0232B9E8
	bl loc_0232B8D0	; 0232B9EA
	add r1,r0,#0x0	; 0232B9EE
	mov r0,#0x6	; 0232B9F0
	bl loc_0232B874	; 0232B9F2
	mov r0,#0x6	; 0232B9F6
	bl loc_0232B880	; 0232B9F8
	add r1,r0,#0x0	; 0232B9FC
	mov r0,#0x6	; 0232B9FE
	bl loc_0232B868	; 0232BA00
loc_0232BA04:
	add sp,#0x4	; 0232BA04
	pop {r3}	; 0232BA06
	bx r3	; 0232BA08
	.byte 0xC0, 0x46	; 0232BA0C
pool_0232BA0C:
loc_0232BA0C:
	.word P1_BssStart + 0x265C4	; 0232BA0C
.arm

; ===== function loc_0232BA10 =====
; Sets CP15 control-register c1 bit 0. / 置位 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9SetCp15ControlBit0
loc_0232BA10:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BA10
	orr r0,r0,#0x1	; 0232BA14
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BA18
	bx lr	; 0232BA1C
.endfunc

; ===== function loc_0232BA20 =====
; Clears CP15 control-register c1 bit 0. / 清除 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9ClearCp15ControlBit0
loc_0232BA20:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BA20
	bic r0,r0,#0x1	; 0232BA24
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BA28
	bx lr	; 0232BA2C
.endfunc
; 链接既有调试入口；保存现场后处理 abort/undef，最后停在等待循环。
; Chain the saved debug handler; process abort/undef context, then stop in a wait loop.
.func P1_ExceptionEntry
	ldr r12,[pool_0232BA9C]	; 0232BA30
	ldr r12,[r12,#0x0]	; 0232BA34
	cmp r12,#0x0	; 0232BA38
	movne lr,pc	; 0232BA3C
	bxne r12	; 0232BA40
	ldr r12,[pool_0232BAA0]	; 0232BA44
	stmdb r12!,{r0,r1,r2,r3,sp,lr}	; 0232BA48
	and r0,sp,#0x1	; 0232BA4C
	mov sp,r12	; 0232BA50
	mrs r1,cpsr	; 0232BA54
	and r1,r1,#0x1f	; 0232BA58
	teq r1,#0x17	; 0232BA5C
	bne loc_0232BA6C	; 0232BA60
	bl P1_ProcessException	; 0232BA64
	b loc_0232BA78	; 0232BA68
loc_0232BA6C:
	teq r1,#0x1b	; 0232BA6C
	bne loc_0232BA78	; 0232BA70
	bl P1_ProcessException	; 0232BA74
loc_0232BA78:
	ldr r12,[pool_0232BA9C]	; 0232BA78
	ldr r12,[r12,#0x0]	; 0232BA7C
	cmp r12,#0x0	; 0232BA80
loc_0232BA84:
	beq loc_0232BA84	; 0232BA84
loc_0232BA88:
	mov r0,r0	; 0232BA88
	b loc_0232BA88	; 0232BA8C
.endfunc
	.byte 0x0F, 0x50, 0xBD, 0xE8, 0x0C, 0xD0, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1	; 0232BA9C
pool_0232BA9C:
loc_0232BA9C:
	.word P1_PreviousExceptionHandler	; 0232BA9C
pool_0232BAA0:
loc_0232BAA0:
	.word P1_ExceptionStackTop	; 0232BAA0

; ===== function loc_0232BAA4 =====
loc_0232BAA4:
; 先保存异常现场，再调用已注册的用户处理器。
; Save exception context, then invoke the registered user handler.
.func P1_ProcessException
	stmdb sp!,{lr}	; 0232BAA4
	bl P1_SaveExceptionContext	; 0232BAA8
	bl P1_CallUserExceptionHandler	; 0232BAAC
	ldmia sp!,{lr}	; 0232BAB0
	bx lr	; 0232BAB4
.endfunc

; ===== function loc_0232BAB8 =====
loc_0232BAB8:
; 收集通用寄存器、异常栈与各模式的状态，写入 BSS 上下文。
; Collect registers, exception-stack data and mode state into the BSS context.
.func P1_SaveExceptionContext
	ldr r1,[pool_0232BB44]	; 0232BAB8
	mrs r2,cpsr	; 0232BABC
	str r2,[r1,#0x74]	; 0232BAC0
	str r0,[r1,#0x6c]	; 0232BAC4
	ldr r0,[r12,#0x0]	; 0232BAC8
	str r0,[r1,#0x4]	; 0232BACC
	ldr r0,[r12,#0x4]	; 0232BAD0
	str r0,[r1,#0x8]	; 0232BAD4
	ldr r0,[r12,#0x8]	; 0232BAD8
	str r0,[r1,#0xc]	; 0232BADC
	ldr r0,[r12,#0xc]	; 0232BAE0
	str r0,[r1,#0x10]	; 0232BAE4
	ldr r2,[r12,#0x10]	; 0232BAE8
	bic r2,r2,#0x1	; 0232BAEC
	add r0,r1,#0x14	; 0232BAF0
	stmia r0,{r4,r5,r6,r7,r8,r9,r10,r11}	; 0232BAF4
	str r12,[r1,#0x70]	; 0232BAF8
	ldr r0,[r2,#0x0]	; 0232BAFC
	str r0,[r1,#0x64]	; 0232BB00
	ldr r3,[r2,#0x4]	; 0232BB04
	str r3,[r1,#0x0]	; 0232BB08
	ldr r0,[r2,#0x8]	; 0232BB0C
	str r0,[r1,#0x34]	; 0232BB10
	ldr r0,[r2,#0xc]	; 0232BB14
	str r0,[r1,#0x40]	; 0232BB18
	mrs r0,cpsr	; 0232BB1C
	orr r3,r3,#0x80	; 0232BB20
	bic r3,r3,#0x20	; 0232BB24
	msr cpsr_cxsf,r3	; 0232BB28
	str sp,[r1,#0x38]	; 0232BB2C
	str lr,[r1,#0x3c]	; 0232BB30
	mrs r2,spsr	; 0232BB34
	str r2,[r1,#0x7c]	; 0232BB38
	msr cpsr_cxsf,r0	; 0232BB3C
	bx lr	; 0232BB40
.endfunc
pool_0232BB44:
loc_0232BB44:
	.word P1_ExceptionContext	; 0232BB44

; ===== function loc_0232BB48 =====
loc_0232BB48:
; 若已注册，临时启用保护单元并以现场/参数调用用户回调。
; If registered, enable the MPU for the user callback with context and argument.
.func P1_CallUserExceptionHandler
	stmdb sp!,{lr}	; 0232BB48
	sub sp,sp,#0x4	; 0232BB4C
	ldr r0,[pool_0232BBA4]	; 0232BB50
	ldr r0,[r0,#0x0]	; 0232BB54
	cmp r0,#0x0	; 0232BB58
	addeq sp,sp,#0x4	; 0232BB5C
	ldmeqia sp!,{lr}	; 0232BB60
	bxeq lr	; 0232BB64
	mov r0,sp	; 0232BB68
	ldr r1,[pool_0232BBA8]	; 0232BB6C
	msr cpsr_cxsf,r1	; 0232BB70
	mov sp,r0	; 0232BB74
	bl P1_Arm9SetCp15ControlBit0	; 0232BB78
	ldr r1,[pool_0232BBAC]	; 0232BB7C
	ldr r0,[pool_0232BBA4]	; 0232BB80
	ldr r1,[r1,#0x0]	; 0232BB84
	ldr r2,[r0,#0x0]	; 0232BB88
	ldr r0,[pool_0232BBB0]	; 0232BB8C
	blx r2	; 0232BB90
	bl P1_Arm9ClearCp15ControlBit0	; 0232BB94
	add sp,sp,#0x4	; 0232BB98
	ldmia sp!,{lr}	; 0232BB9C
	bx lr	; 0232BBA0
.endfunc
pool_0232BBA4:
loc_0232BBA4:
	.word P1_UserExceptionHandler	; 0232BBA4
pool_0232BBA8:
loc_0232BBA8:
	.word 0x0000009F	; 0232BBA8
pool_0232BBAC:
loc_0232BBAC:
	.word P1_UserExceptionArgument	; 0232BBAC
pool_0232BBB0:
loc_0232BBB0:
	.word P1_ExceptionContext	; 0232BBB0
.thumb

; ===== function loc_0232BBB4 =====
loc_0232BBB4:
; 检查既有调试入口；需要时同时安装 BIOS 向量和 DTCM 中的入口副本。
; Check the saved debug entry; install the BIOS vector and DTCM copy when required.
.func P1_InitExceptionHandler
	push {lr}	; 0232BBB4
	sub sp,#0x4	; 0232BBB6
	ldr r0,[pool_0232BC00]	; 0232BBB8
	ldr r1,[r0,#0x0]	; 0232BBBA
	ldr r0,[pool_0232BC04]	; 0232BBBC
	cmp r1,r0	; 0232BBBE
	bcc loc_0232BBCE	; 0232BBC0
	ldr r0,[pool_0232BC08]	; 0232BBC2
	cmp r1,r0	; 0232BBC4
	bcs loc_0232BBCE	; 0232BBC6
	ldr r0,[pool_0232BC0C]	; 0232BBC8
	str r1,[r0,#0x0]	; 0232BBCA
	b loc_0232BBD4	; 0232BBCC
loc_0232BBCE:
	mov r1,#0x0	; 0232BBCE
	ldr r0,[pool_0232BC0C]	; 0232BBD0
	str r1,[r0,#0x0]	; 0232BBD2
loc_0232BBD4:
	ldr r0,[pool_0232BC0C]	; 0232BBD4
	ldr r0,[r0,#0x0]	; 0232BBD6
	cmp r0,#0x0	; 0232BBD8
	beq loc_0232BBE8	; 0232BBDA
	bl loc_0232B614	; 0232BBDC
	ldr r1,[pool_0232BC10]	; 0232BBE0
	and r0,r1	; 0232BBE2
	cmp r0,#0x0	; 0232BBE4
	bne loc_0232BBF2	; 0232BBE6
loc_0232BBE8:
	ldr r1,[pool_0232BC14]	; 0232BBE8
	ldr r0,[pool_0232BC00]	; 0232BBEA
	str r1,[r0,#0x0]	; 0232BBEC
	ldr r0,[pool_0232BC18]	; 0232BBEE
	str r1,[r0,#0x5c]	; 0232BBF0
loc_0232BBF2:
	mov r1,#0x0	; 0232BBF2
	ldr r0,[pool_0232BC1C]	; 0232BBF4
	str r1,[r0,#0x0]	; 0232BBF6
	add sp,#0x4	; 0232BBF8
	pop {r3}	; 0232BBFA
	bx r3	; 0232BBFC
.endfunc
	.byte 0xC0, 0x46	; 0232BC00
pool_0232BC00:
loc_0232BC00:
	.word Bios9DebugVectorAddress	; 0232BC00
pool_0232BC04:
loc_0232BC04:
	.word 0x02600000	; 0232BC04
pool_0232BC08:
loc_0232BC08:
	.word 0x02800000	; 0232BC08
pool_0232BC0C:
loc_0232BC0C:
	.word P1_PreviousExceptionHandler	; 0232BC0C
pool_0232BC10:
loc_0232BC10:
	.word 0x40000000	; 0232BC10
pool_0232BC14:
loc_0232BC14:
	.word P1_ExceptionEntry	; 0232BC14
pool_0232BC18:
loc_0232BC18:
	.word P1_DtcmExceptionVector - 0x5C	; 0232BC18
pool_0232BC1C:
loc_0232BC1C:
	.word P1_UserExceptionHandler	; 0232BC1C

; ===== function loc_0232BC20 =====
loc_0232BC20:
	ldr r1,[pool_0232BC30]	; 0232BC20
	ldrh r3,[r1,#0x0]	; 0232BC22
	mov r2,#0x1	; 0232BC24
	lsl r2,r0	; 0232BC26
	orr r3,r2	; 0232BC28
	strh r3,[r1,#0x0]	; 0232BC2A
	bx lr	; 0232BC2C
	.byte 0xC0, 0x46	; 0232BC30
pool_0232BC30:
loc_0232BC30:
	.word P1_BssStart + 0x26654	; 0232BC30

; ===== function loc_0232BC34 =====
loc_0232BC34:
	push {r4,r5,lr}	; 0232BC34
	sub sp,#0xc	; 0232BC36
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BC38
	ldr r1,[pool_0232BC9C]	; 0232BC3C
	ldrh r1,[r1,#0x0]	; 0232BC3E
	add r3,sp,#0x0	; 0232BC40
	strh r1,[r3,#0x0]	; 0232BC42
	ldr r1,[pool_0232BCA0]	; 0232BC44
	ldr r5,[r1,#0x0]	; 0232BC46
	ldr r4,[r1,#0x4]	; 0232BC48
	ldr r1,[pool_0232BCA4]	; 0232BC4A
	mov r2,#0x0	; 0232BC4C
	and r4,r1	; 0232BC4E
	bic r5,r2	; 0232BC50
	str r5,[sp,#0x4]	; 0232BC52
	str r4,[sp,#0x8]	; 0232BC54
	ldr r1,[pool_0232BCA8]	; 0232BC56
	ldr r4,[r1,#0x0]	; 0232BC58
	mov r1,#0x8	; 0232BC5A
	and r4,r1	; 0232BC5C
	cmp r4,#0x0	; 0232BC5E
	beq loc_0232BC7A	; 0232BC60
	ldrh r3,[r3,#0x0]	; 0232BC62
	ldr r1,[pool_0232BCAC]	; 0232BC64
	and r3,r1	; 0232BC66
	cmp r3,#0x0	; 0232BC68
	bne loc_0232BC7A	; 0232BC6A
	ldr r3,[sp,#0x4]	; 0232BC6C
	ldr r4,[sp,#0x8]	; 0232BC6E
	mov r1,#0x1	; 0232BC70
	add r1,r3,r1	; 0232BC72
	adc r4,r2	; 0232BC74
	str r1,[sp,#0x4]	; 0232BC76
	str r4,[sp,#0x8]	; 0232BC78
loc_0232BC7A:
	blx P1_Arm9RestoreIrqMask	; 0232BC7A
	ldr r2,[sp,#0x4]	; 0232BC7E
	ldr r1,[sp,#0x8]	; 0232BC80
	lsr r0,r2,#0x10	; 0232BC82
	lsl r1,r1,#0x10	; 0232BC84
	orr r1,r0	; 0232BC86
	lsl r0,r2,#0x10	; 0232BC88
	add r2,sp,#0x0	; 0232BC8A
	ldrh r3,[r2,#0x0]	; 0232BC8C
	asr r2,r3,#0x1f	; 0232BC8E
	orr r1,r2	; 0232BC90
	orr r0,r3	; 0232BC92
	add sp,#0xc	; 0232BC94
	pop {r4,r5}	; 0232BC96
	pop {r3}	; 0232BC98
	bx r3	; 0232BC9A
pool_0232BC9C:
loc_0232BC9C:
	.word TIMER0_DATA	; 0232BC9C
pool_0232BCA0:
loc_0232BCA0:
	.word P1_BssStart + 0x26660	; 0232BCA0
pool_0232BCA4:
loc_0232BCA4:
	.word 0x0000FFFF	; 0232BCA4
pool_0232BCA8:
loc_0232BCA8:
	.word REG_IF	; 0232BCA8
pool_0232BCAC:
loc_0232BCAC:
	.word 0x00008000	; 0232BCAC

; ===== function loc_0232BCB0 =====
P1_IrqHandler_0232BCB0:
	push {r4,lr}	; 0232BCB0
	ldr r1,[pool_0232BCEC]	; 0232BCB2
	ldr r2,[r1,#0x0]	; 0232BCB4
	ldr r4,[r1,#0x4]	; 0232BCB6
	mov r3,#0x0	; 0232BCB8
	mov r0,#0x1	; 0232BCBA
	add r0,r2,r0	; 0232BCBC
	adc r4,r3	; 0232BCBE
	str r0,[r1,#0x0]	; 0232BCC0
	str r4,[r1,#0x4]	; 0232BCC2
	ldr r0,[pool_0232BCF0]	; 0232BCC4
	ldr r1,[r0,#0x0]	; 0232BCC6
	cmp r1,#0x0	; 0232BCC8
	beq loc_0232BCDA	; 0232BCCA
	ldr r2,[pool_0232BCF4]	; 0232BCCC
	strh r3,[r2,#0x0]	; 0232BCCE
	ldr r1,[pool_0232BCF8]	; 0232BCD0
	strh r3,[r1,#0x0]	; 0232BCD2
	mov r1,#0xc1	; 0232BCD4
	strh r1,[r2,#0x0]	; 0232BCD6
	str r3,[r0,#0x0]	; 0232BCD8
loc_0232BCDA:
	mov r0,#0x0	; 0232BCDA
	ldr r1,[pool_0232BCFC]	; 0232BCDC
	add r2,r0,#0x0	; 0232BCDE
	bl loc_0232AD9C	; 0232BCE0
	pop {r4}	; 0232BCE4
	pop {r3}	; 0232BCE6
	bx r3	; 0232BCE8
	.byte 0xC0, 0x46	; 0232BCEC
pool_0232BCEC:
loc_0232BCEC:
	.word P1_BssStart + 0x26660	; 0232BCEC
pool_0232BCF0:
loc_0232BCF0:
	.word P1_BssStart + 0x2665C	; 0232BCF0
pool_0232BCF4:
loc_0232BCF4:
	.word TIMER0_CR	; 0232BCF4
pool_0232BCF8:
loc_0232BCF8:
	.word TIMER0_DATA	; 0232BCF8
pool_0232BCFC:
loc_0232BCFC:
	.word 0x0232BCB1	; 0232BCFC

; ===== function loc_0232BD00 =====
loc_0232BD00:
	push {lr}	; 0232BD00
	sub sp,#0x4	; 0232BD02
	ldr r0,[pool_0232BD44]	; 0232BD04
	ldrh r1,[r0,#0x0]	; 0232BD06
	cmp r1,#0x0	; 0232BD08
	bne loc_0232BD3E	; 0232BD0A
	mov r1,#0x1	; 0232BD0C
	strh r1,[r0,#0x0]	; 0232BD0E
	mov r0,#0x0	; 0232BD10
	bl loc_0232BC20	; 0232BD12
	mov r2,#0x0	; 0232BD16
	ldr r0,[pool_0232BD48]	; 0232BD18
	str r2,[r0,#0x0]	; 0232BD1A
	str r2,[r0,#0x4]	; 0232BD1C
	ldr r1,[pool_0232BD4C]	; 0232BD1E
	strh r2,[r1,#0x0]	; 0232BD20
	ldr r0,[pool_0232BD50]	; 0232BD22
	strh r2,[r0,#0x0]	; 0232BD24
	mov r0,#0xc1	; 0232BD26
	strh r0,[r1,#0x0]	; 0232BD28
	mov r0,#0x8	; 0232BD2A
	ldr r1,[pool_0232BD54]	; 0232BD2C
	bl loc_0232ADD0	; 0232BD2E
	mov r0,#0x8	; 0232BD32
	bl loc_0232AD4C	; 0232BD34
	mov r1,#0x0	; 0232BD38
	ldr r0,[pool_0232BD58]	; 0232BD3A
	str r1,[r0,#0x0]	; 0232BD3C
loc_0232BD3E:
	add sp,#0x4	; 0232BD3E
	pop {r3}	; 0232BD40
	bx r3	; 0232BD42
pool_0232BD44:
loc_0232BD44:
	.word P1_BssStart + 0x26658	; 0232BD44
pool_0232BD48:
loc_0232BD48:
	.word P1_BssStart + 0x26660	; 0232BD48
pool_0232BD4C:
loc_0232BD4C:
	.word TIMER0_CR	; 0232BD4C
pool_0232BD50:
loc_0232BD50:
	.word TIMER0_DATA	; 0232BD50
pool_0232BD54:
loc_0232BD54:
	.word P1_IrqHandler_0232BCB0 + 1	; 0232BD54
pool_0232BD58:
loc_0232BD58:
	.word P1_BssStart + 0x2665C	; 0232BD58
.arm
	stmdb sp!,{lr}	; 0232BD5C
	blx loc_0232BDC0	; 0232BD60
	ldmia sp!,{lr}	; 0232BD64
	bx lr	; 0232BD68
.thumb

; ===== function loc_0232BD6C =====
	push {r4,r5,r6,r7,lr}	; 0232BD6C
	sub sp,#0x4	; 0232BD6E
	add r5,r0,#0x0	; 0232BD70
	cmp r5,#0x0	; 0232BD72
	beq loc_0232BDB0	; 0232BD74
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BD76
	add r7,r0,#0x0	; 0232BD7A
	ldr r0,[pool_0232BDB8]	; 0232BD7C
	ldr r0,[r0,#0x0]	; 0232BD7E
	cmp r0,#0x0	; 0232BD80
	beq loc_0232BD88	; 0232BD82
	ldr r4,[r0,#0x18]	; 0232BD84
	b loc_0232BD8A	; 0232BD86
loc_0232BD88:
	mov r4,#0x0	; 0232BD88
loc_0232BD8A:
	cmp r0,#0x0	; 0232BD8A
	beq loc_0232BDAA	; 0232BD8C
	mov r6,#0x0	; 0232BD8E
loc_0232BD90:
	ldr r1,[r0,#0x8]	; 0232BD90
	cmp r1,r5	; 0232BD92
	bne loc_0232BD9A	; 0232BD94
	bl loc_0232BE70	; 0232BD96
loc_0232BD9A:
	add r0,r4,#0x0	; 0232BD9A
	cmp r4,#0x0	; 0232BD9C
	beq loc_0232BDA4	; 0232BD9E
	ldr r4,[r4,#0x18]	; 0232BDA0
	b loc_0232BDA6	; 0232BDA2
loc_0232BDA4:
	add r4,r6,#0x0	; 0232BDA4
loc_0232BDA6:
	cmp r0,#0x0	; 0232BDA6
	bne loc_0232BD90	; 0232BDA8
loc_0232BDAA:
	add r0,r7,#0x0	; 0232BDAA
	blx P1_Arm9RestoreIrqMask	; 0232BDAC
loc_0232BDB0:
	add sp,#0x4	; 0232BDB0
	pop {r4,r5,r6,r7}	; 0232BDB2
	pop {r3}	; 0232BDB4
	bx r3	; 0232BDB6
pool_0232BDB8:
loc_0232BDB8:
	.word P1_BssStart + 0x2666C	; 0232BDB8
	.byte 0x81, 0x60, 0x70, 0x47	; 0232BDC0

; ===== function loc_0232BDC0 =====
loc_0232BDC0:
	push {r4,r5,lr}	; 0232BDC0
	sub sp,#0x4	; 0232BDC2
	mov r1,#0x0	; 0232BDC4
	ldr r0,[pool_0232BE60]	; 0232BDC6
	strh r1,[r0,#0x0]	; 0232BDC8
	mov r0,#0x10	; 0232BDCA
	bl loc_0232AD24	; 0232BDCC
	ldr r1,[pool_0232BE64]	; 0232BDD0
	ldr r0,[pool_0232BE68]	; 0232BDD2
	add r2,r1,r0	; 0232BDD4
	ldr r1,[r2,#0x0]	; 0232BDD6
	mov r0,#0x10	; 0232BDD8
	orr r1,r0	; 0232BDDA
	str r1,[r2,#0x0]	; 0232BDDC
	bl loc_0232BC34	; 0232BDDE
	ldr r2,[pool_0232BE6C]	; 0232BDE2
	ldr r4,[r2,#0x0]	; 0232BDE4
	cmp r4,#0x0	; 0232BDE6
	beq loc_0232BE56	; 0232BDE8
	ldr r5,[r4,#0xc]	; 0232BDEA
	ldr r3,[r4,#0x10]	; 0232BDEC
	sub r0,r0,r5	; 0232BDEE
	sbc r1,r3	; 0232BDF0
	bcs loc_0232BE02	; 0232BDF2
	add r0,r4,#0x0	; 0232BDF4
	bl loc_0232C030	; 0232BDF6
	add sp,#0x4	; 0232BDFA
	pop {r4,r5}	; 0232BDFC
	pop {r3}	; 0232BDFE
	bx r3	; 0232BE00
loc_0232BE02:
	ldr r1,[r4,#0x18]	; 0232BE02
	str r1,[r2,#0x0]	; 0232BE04
	cmp r1,#0x0	; 0232BE06
	bne loc_0232BE10	; 0232BE08
	mov r0,#0x0	; 0232BE0A
	str r0,[r2,#0x4]	; 0232BE0C
	b loc_0232BE14	; 0232BE0E
loc_0232BE10:
	mov r0,#0x0	; 0232BE10
	str r0,[r1,#0x14]	; 0232BE12
loc_0232BE14:
	ldr r5,[r4,#0x0]	; 0232BE14
	ldr r2,[r4,#0x1c]	; 0232BE16
	ldr r1,[r4,#0x20]	; 0232BE18
	mov r0,#0x0	; 0232BE1A
	eor r1,r0	; 0232BE1C
	eor r2,r0	; 0232BE1E
	orr r1,r2	; 0232BE20
	bne loc_0232BE28	; 0232BE22
	mov r0,#0x0	; 0232BE24
	str r0,[r4,#0x0]	; 0232BE26
loc_0232BE28:
	cmp r5,#0x0	; 0232BE28
	beq loc_0232BE30	; 0232BE2A
	ldr r0,[r4,#0x4]	; 0232BE2C
	blx r5	; 0232BE2E
loc_0232BE30:
	ldr r2,[r4,#0x1c]	; 0232BE30
	ldr r1,[r4,#0x20]	; 0232BE32
	mov r0,#0x0	; 0232BE34
	eor r1,r0	; 0232BE36
	eor r2,r0	; 0232BE38
	orr r1,r2	; 0232BE3A
	beq loc_0232BE4A	; 0232BE3C
	str r5,[r4,#0x0]	; 0232BE3E
	add r0,r4,#0x0	; 0232BE40
	mov r1,#0x0	; 0232BE42
	add r2,r1,#0x0	; 0232BE44
	bl loc_0232BF20	; 0232BE46
loc_0232BE4A:
	ldr r0,[pool_0232BE6C]	; 0232BE4A
	ldr r0,[r0,#0x0]	; 0232BE4C
	cmp r0,#0x0	; 0232BE4E
	beq loc_0232BE56	; 0232BE50
	bl loc_0232C030	; 0232BE52
loc_0232BE56:
	add sp,#0x4	; 0232BE56
	pop {r4,r5}	; 0232BE58
	pop {r3}	; 0232BE5A
	bx r3	; 0232BE5C
	.byte 0xC0, 0x46	; 0232BE60
pool_0232BE60:
loc_0232BE60:
	.word TIMER1_CR	; 0232BE60
pool_0232BE64:
loc_0232BE64:
	.word 0x03000000	; 0232BE64
pool_0232BE68:
loc_0232BE68:
	.word 0x00003FF8	; 0232BE68
pool_0232BE6C:
loc_0232BE6C:
	.word P1_BssStart + 0x2666C	; 0232BE6C

; ===== function loc_0232BE70 =====
loc_0232BE70:
	push {r4,r5,lr}	; 0232BE70
	sub sp,#0x4	; 0232BE72
	add r5,r0,#0x0	; 0232BE74
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BE76
	add r4,r0,#0x0	; 0232BE7A
	ldr r1,[r5,#0x0]	; 0232BE7C
	cmp r1,#0x0	; 0232BE7E
	bne loc_0232BE8E	; 0232BE80
	blx P1_Arm9RestoreIrqMask	; 0232BE82
	add sp,#0x4	; 0232BE86
	pop {r4,r5}	; 0232BE88
	pop {r3}	; 0232BE8A
	bx r3	; 0232BE8C
loc_0232BE8E:
	ldr r0,[r5,#0x18]	; 0232BE8E
	cmp r0,#0x0	; 0232BE90
	bne loc_0232BE9C	; 0232BE92
	ldr r2,[r5,#0x14]	; 0232BE94
	ldr r1,[pool_0232BECC]	; 0232BE96
	str r2,[r1,#0x4]	; 0232BE98
	b loc_0232BEA0	; 0232BE9A
loc_0232BE9C:
	ldr r1,[r5,#0x14]	; 0232BE9C
	str r1,[r0,#0x14]	; 0232BE9E
loc_0232BEA0:
	ldr r1,[r5,#0x14]	; 0232BEA0
	cmp r1,#0x0	; 0232BEA2
	beq loc_0232BEAA	; 0232BEA4
	str r0,[r1,#0x18]	; 0232BEA6
	b loc_0232BEB6	; 0232BEA8
loc_0232BEAA:
	ldr r1,[pool_0232BECC]	; 0232BEAA
	str r0,[r1,#0x0]	; 0232BEAC
	cmp r0,#0x0	; 0232BEAE
	beq loc_0232BEB6	; 0232BEB0
	bl loc_0232C030	; 0232BEB2
loc_0232BEB6:
	mov r0,#0x0	; 0232BEB6
	str r0,[r5,#0x0]	; 0232BEB8
	str r0,[r5,#0x1c]	; 0232BEBA
	str r0,[r5,#0x20]	; 0232BEBC
	add r0,r4,#0x0	; 0232BEBE
	blx P1_Arm9RestoreIrqMask	; 0232BEC0
	add sp,#0x4	; 0232BEC4
	pop {r4,r5}	; 0232BEC6
	pop {r3}	; 0232BEC8
	bx r3	; 0232BECA
pool_0232BECC:
loc_0232BECC:
	.word P1_BssStart + 0x2666C	; 0232BECC
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x14, 0x1C, 0x1F, 0x1C, 0x00, 0x2D, 0x02, 0xD0	; 0232BEE0
	.byte 0x28, 0x68, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x37, 0xF9, 0x00, 0xF0, 0xF8, 0xE8, 0x00, 0x90	; 0232BEF0
	.byte 0x00, 0x20, 0xE8, 0x61, 0x28, 0x62, 0x2F, 0x60, 0x06, 0x98, 0x68, 0x60, 0xFF, 0xF7, 0x9A, 0xFE	; 0232BF00
	.byte 0x02, 0x1C, 0x28, 0x1C, 0xB2, 0x18, 0x4C, 0x41, 0x11, 0x1C, 0x22, 0x1C, 0x00, 0xF0, 0x08, 0xF8	; 0232BF10
	.byte 0x00, 0x98, 0x00, 0xF0, 0xEE, 0xE8, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 0232BF20

; ===== function loc_0232BF20 =====
loc_0232BF20:
	push {r4,r5,r6,r7,lr}	; 0232BF20
	sub sp,#0xc	; 0232BF22
	add r5,r0,#0x0	; 0232BF24
	add r4,r1,#0x0	; 0232BF26
	add r6,r2,#0x0	; 0232BF28
	ldr r2,[r5,#0x1c]	; 0232BF2A
	ldr r1,[r5,#0x20]	; 0232BF2C
	mov r0,#0x0	; 0232BF2E
	eor r1,r0	; 0232BF30
	eor r2,r0	; 0232BF32
	orr r1,r2	; 0232BF34
	beq loc_0232BF7A	; 0232BF36
	bl loc_0232BC34	; 0232BF38
	ldr r4,[r5,#0x24]	; 0232BF3C
	ldr r6,[r5,#0x28]	; 0232BF3E
	sub r2,r4,r0	; 0232BF40
	lsl r2,r6,#0	; 0232BF42
	sbc r2,r1	; 0232BF44
	bcs loc_0232BF7A	; 0232BF46
	ldr r2,[r5,#0x1c]	; 0232BF48
	str r2,[sp,#0x0]	; 0232BF4A
	ldr r2,[r5,#0x20]	; 0232BF4C
	str r2,[sp,#0x4]	; 0232BF4E
	sub r0,r0,r4	; 0232BF50
	sbc r1,r6	; 0232BF52
	ldr r2,[sp,#0x0]	; 0232BF54
	ldr r3,[sp,#0x4]	; 0232BF56
	blx loc_0232C734	; 0232BF58
	str r0,[sp,#0x8]	; 0232BF5C
	add r7,r1,#0x0	; 0232BF5E
	ldr r0,[sp,#0x0]	; 0232BF60
	ldr r1,[sp,#0x4]	; 0232BF62
	mov r3,#0x1	; 0232BF64
	ldr r2,[sp,#0x8]	; 0232BF66
	add r3,r2,r3	; 0232BF68
	mov r2,#0x0	; 0232BF6A
	adc r7,r2	; 0232BF6C
	add r2,r3,#0x0	; 0232BF6E
	add r3,r7,#0x0	; 0232BF70
	blx P1_AeabiLmul	; 0232BF72
	add r4,r4,r0	; 0232BF76
	adc r6,r1	; 0232BF78
loc_0232BF7A:
	str r4,[r5,#0xc]	; 0232BF7A
	str r6,[r5,#0x10]	; 0232BF7C
	ldr r0,[pool_0232BFF4]	; 0232BF7E
	ldr r3,[r0,#0x0]	; 0232BF80
	cmp r3,#0x0	; 0232BF82
	beq loc_0232BFC8	; 0232BF84
loc_0232BF86:
	ldr r1,[r3,#0xc]	; 0232BF86
	ldr r0,[r3,#0x10]	; 0232BF88
	sub r2,r4,r1	; 0232BF8A
	lsl r1,r6,#0	; 0232BF8C
	sbc r1,r0	; 0232BF8E
	mov r0,#0x0	; 0232BF90
	sub r2,r2,r0	; 0232BF92
	sbc r1,r0	; 0232BF94
	bge loc_0232BFC2	; 0232BF96
	ldr r0,[r3,#0x14]	; 0232BF98
	str r0,[r5,#0x14]	; 0232BF9A
	str r5,[r3,#0x14]	; 0232BF9C
	str r3,[r5,#0x18]	; 0232BF9E
	ldr r0,[r5,#0x14]	; 0232BFA0
	cmp r0,#0x0	; 0232BFA2
	beq loc_0232BFB0	; 0232BFA4
	str r5,[r0,#0x18]	; 0232BFA6
	add sp,#0xc	; 0232BFA8
	pop {r4,r5,r6,r7}	; 0232BFAA
	pop {r3}	; 0232BFAC
	bx r3	; 0232BFAE
loc_0232BFB0:
	ldr r0,[pool_0232BFF4]	; 0232BFB0
	str r5,[r0,#0x0]	; 0232BFB2
	add r0,r5,#0x0	; 0232BFB4
	bl loc_0232C030	; 0232BFB6
	add sp,#0xc	; 0232BFBA
	pop {r4,r5,r6,r7}	; 0232BFBC
	pop {r3}	; 0232BFBE
	bx r3	; 0232BFC0
loc_0232BFC2:
	ldr r3,[r3,#0x18]	; 0232BFC2
	cmp r3,#0x0	; 0232BFC4
	bne loc_0232BF86	; 0232BFC6
loc_0232BFC8:
	mov r0,#0x0	; 0232BFC8
	str r0,[r5,#0x18]	; 0232BFCA
	ldr r0,[pool_0232BFF4]	; 0232BFCC
	ldr r1,[r0,#0x4]	; 0232BFCE
	str r5,[r0,#0x4]	; 0232BFD0
	str r1,[r5,#0x14]	; 0232BFD2
	cmp r1,#0x0	; 0232BFD4
	beq loc_0232BFE2	; 0232BFD6
	str r5,[r1,#0x18]	; 0232BFD8
	add sp,#0xc	; 0232BFDA
	pop {r4,r5,r6,r7}	; 0232BFDC
	pop {r3}	; 0232BFDE
	bx r3	; 0232BFE0
loc_0232BFE2:
	str r5,[r0,#0x4]	; 0232BFE2
	str r5,[r0,#0x0]	; 0232BFE4
	add r0,r5,#0x0	; 0232BFE6
	bl loc_0232C030	; 0232BFE8
	add sp,#0xc	; 0232BFEC
	pop {r4,r5,r6,r7}	; 0232BFEE
	pop {r3}	; 0232BFF0
	bx r3	; 0232BFF2
pool_0232BFF4:
loc_0232BFF4:
	.word P1_BssStart + 0x2666C	; 0232BFF4
	.byte 0x00, 0x21, 0x01, 0x60, 0x81, 0x60, 0x70, 0x47	; 0232C000

; ===== function loc_0232C000 =====
	push {lr}	; 0232C000
	sub sp,#0x4	; 0232C002
	ldr r1,[pool_0232C028]	; 0232C004
	ldrh r0,[r1,#0x0]	; 0232C006
	cmp r0,#0x0	; 0232C008
	bne loc_0232C022	; 0232C00A
	mov r0,#0x1	; 0232C00C
	strh r0,[r1,#0x0]	; 0232C00E
	bl loc_0232BC20	; 0232C010
	mov r1,#0x0	; 0232C014
	ldr r0,[pool_0232C02C]	; 0232C016
	str r1,[r0,#0x0]	; 0232C018
	str r1,[r0,#0x4]	; 0232C01A
	mov r0,#0x10	; 0232C01C
	bl loc_0232AD24	; 0232C01E
loc_0232C022:
	add sp,#0x4	; 0232C022
	pop {r3}	; 0232C024
	bx r3	; 0232C026
pool_0232C028:
loc_0232C028:
	.word P1_BssStart + 0x26668	; 0232C028
pool_0232C02C:
loc_0232C02C:
	.word P1_BssStart + 0x2666C	; 0232C02C

; ===== function loc_0232C030 =====
loc_0232C030:
	push {r4,r5,lr}	; 0232C030
	sub sp,#0x4	; 0232C032
	add r4,r0,#0x0	; 0232C034
	bl loc_0232BC34	; 0232C036
	mov r2,#0x0	; 0232C03A
	ldr r3,[pool_0232C088]	; 0232C03C
	strh r2,[r3,#0x0]	; 0232C03E
	ldr r3,[r4,#0xc]	; 0232C040
	ldr r4,[r4,#0x10]	; 0232C042
	sub r5,r3,r0	; 0232C044
	sbc r4,r1	; 0232C046
	mov r0,#0x1	; 0232C048
	ldr r1,[pool_0232C08C]	; 0232C04A
	bl loc_0232AD9C	; 0232C04C
	mov r1,#0x0	; 0232C050
	sub r0,r5,r1	; 0232C052
	lsl r0,r4,#0	; 0232C054
	sbc r0,r1	; 0232C056
	bge loc_0232C05E	; 0232C058
	ldr r1,[pool_0232C090]	; 0232C05A
	b loc_0232C070	; 0232C05C
loc_0232C05E:
	ldr r0,[pool_0232C094]	; 0232C05E
	sub r0,r5,r0	; 0232C060
	sbc r4,r1	; 0232C062
	bge loc_0232C06E	; 0232C064
	mvn r0,r5	; 0232C066
	lsl r0,r0,#0x10	; 0232C068
	lsr r1,r0,#0x10	; 0232C06A
	b loc_0232C070	; 0232C06C
loc_0232C06E:
	mov r1,#0x0	; 0232C06E
loc_0232C070:
	ldr r0,[pool_0232C098]	; 0232C070
	strh r1,[r0,#0x0]	; 0232C072
	mov r1,#0xc1	; 0232C074
	ldr r0,[pool_0232C088]	; 0232C076
	strh r1,[r0,#0x0]	; 0232C078
	mov r0,#0x10	; 0232C07A
	bl loc_0232AD4C	; 0232C07C
	add sp,#0x4	; 0232C080
	pop {r4,r5}	; 0232C082
	pop {r3}	; 0232C084
	bx r3	; 0232C086
pool_0232C088:
loc_0232C088:
	.word TIMER1_CR	; 0232C088
pool_0232C08C:
loc_0232C08C:
	.word 0x0232BD5C	; 0232C08C
pool_0232C090:
loc_0232C090:
	.word 0x0000FFFE	; 0232C090
pool_0232C094:
loc_0232C094:
	.word 0x00010000	; 0232C094
pool_0232C098:
loc_0232C098:
	.word TIMER1_DATA	; 0232C098

; ===== function loc_0232C09C =====
loc_0232C09C:
	push {lr}	; 0232C09C
	sub sp,#0x4	; 0232C09E
	ldr r0,[pool_0232C0C0]	; 0232C0A0
	ldrh r1,[r0,#0x0]	; 0232C0A2
	cmp r1,#0x0	; 0232C0A4
	bne loc_0232C0BA	; 0232C0A6
	mov r1,#0x1	; 0232C0A8
	strh r1,[r0,#0x0]	; 0232C0AA
	mov r1,#0x0	; 0232C0AC
	ldr r0,[pool_0232C0C4]	; 0232C0AE
	str r1,[r0,#0x0]	; 0232C0B0
	str r1,[r0,#0x4]	; 0232C0B2
	mov r0,#0x4	; 0232C0B4
	bl loc_0232AD24	; 0232C0B6
loc_0232C0BA:
	add sp,#0x4	; 0232C0BA
	pop {r3}	; 0232C0BC
	bx r3	; 0232C0BE
pool_0232C0C0:
loc_0232C0C0:
	.word P1_BssStart + 0x26674	; 0232C0C0
pool_0232C0C4:
loc_0232C0C4:
	.word P1_BssStart + 0x26678	; 0232C0C4
.arm

; ===== function loc_0232C0C8 =====
; Clears CPSR I and returns the former I mask. / 清除 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9EnableIrqReturnPriorMask
loc_0232C0C8:
	mrs r0,cpsr	; 0232C0C8
	bic r1,r0,#0x80	; 0232C0CC
	msr cpsr_c,r1	; 0232C0D0
	and r0,r0,#0x80	; 0232C0D4
	bx lr	; 0232C0D8
.endfunc

; ===== function loc_0232C0DC =====
; Sets CPSR I and returns the former I mask. / 设置 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9DisableIrqReturnPriorMask
loc_0232C0DC:
	mrs r0,cpsr	; 0232C0DC
	orr r1,r0,#0x80	; 0232C0E0
	msr cpsr_c,r1	; 0232C0E4
	and r0,r0,#0x80	; 0232C0E8
	bx lr	; 0232C0EC
.endfunc

; ===== function loc_0232C0F0 =====
; Restores CPSR I from r0 and returns the prior mask. / 按 r0 恢复 CPSR I 位并返回先前掩码。
.func P1_Arm9RestoreIrqMask
loc_0232C0F0:
	mrs r1,cpsr	; 0232C0F0
	bic r2,r1,#0x80	; 0232C0F4
	orr r2,r2,r0	; 0232C0F8
	msr cpsr_c,r2	; 0232C0FC
	and r0,r1,#0x80	; 0232C100
	bx lr	; 0232C104
.endfunc

; ===== function loc_0232C108 =====
; Sets CPSR I/F and returns the former masks. / 设置 CPSR I/F 位并返回先前掩码。
.func P1_Arm9DisableIrqFiqReturnPriorMasks
loc_0232C108:
	mrs r0,cpsr	; 0232C108
	orr r1,r0,#0xc0	; 0232C10C
	msr cpsr_c,r1	; 0232C110
	and r0,r0,#0xc0	; 0232C114
	bx lr	; 0232C118
.endfunc

; ===== function loc_0232C11C =====
; Restores CPSR I/F from r0 and returns prior masks. / 按 r0 恢复 CPSR I/F 位并返回先前掩码。
.func P1_Arm9RestoreIrqFiqMasks
loc_0232C11C:
	mrs r1,cpsr	; 0232C11C
	bic r2,r1,#0xc0	; 0232C120
	orr r2,r2,r0	; 0232C124
	msr cpsr_c,r2	; 0232C128
	and r0,r1,#0xc0	; 0232C12C
	bx lr	; 0232C130
.endfunc

; ===== function loc_0232C134 =====
; Returns the CPSR processor-mode bits. / 返回 CPSR 的处理器模式位。
.func P1_Arm9GetProcessorMode
loc_0232C134:
	mrs r0,cpsr	; 0232C134
	and r0,r0,#0x1f	; 0232C138
	bx lr	; 0232C13C
.endfunc

; ===== function loc_0232C140 =====
; ARM946 CP15 wait-for-interrupt helper. / ARM946 CP15 等待中断帮助例程。
.func P1_Arm9WaitForInterrupt
loc_0232C140:
	mov r0,#0x0	; 0232C140
	mcr p15,0x0,r0,c7,c0,0x4	; 0232C144
	bx lr	; 0232C148
.endfunc

; ===== function loc_0232C14C =====
; Decrements r0 by four until borrow. / 每次将 r0 减四，直至产生借位。
.func P1_Arm9BusyWaitByLoop4
loc_0232C14C:
	subs r0,r0,#0x4	; 0232C14C
	bcs loc_0232C14C	; 0232C150
	bx lr	; 0232C154
.endfunc
.thumb

; ===== function loc_0232C158 =====
loc_0232C158:
	push {lr}	; 0232C158
	sub sp,#0x4	; 0232C15A
loc_0232C15C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C15C
	blx P1_Arm9WaitForInterrupt	; 0232C160
	b loc_0232C15C	; 0232C164
	.byte 0x00, 0x00, 0x01, 0x1C, 0x02, 0x48, 0x06, 0x22, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFC	; 0232C176
	.byte 0x7F, 0x02, 0xE8, 0xE3, 0x32, 0x02	; 0232C17C

; ===== function loc_0232C17C =====
loc_0232C17C:
	push {r4,lr}	; 0232C17C
	add r4,r1,#0x0	; 0232C17E
	ldr r1,[r4,#0x0]	; 0232C180
	cmp r1,#0x0	; 0232C182
	bne loc_0232C18A	; 0232C184
	bl loc_0232AE40	; 0232C186
loc_0232C18A:
	ldr r0,[r4,#0x4]	; 0232C18A
	blx P1_Arm9RestoreIrqMask	; 0232C18C
	pop {r4}	; 0232C190
	pop {r3}	; 0232C192
	bx r3	; 0232C194
	.byte 0x00, 0x00	; 0232C198

; ===== function loc_0232C198 =====
loc_0232C198:
	push {r4,r5,r6,r7,lr}	; 0232C198
	sub sp,#0x4	; 0232C19A
	add r5,r0,#0x0	; 0232C19C
	add r4,r1,#0x0	; 0232C19E
	ldr r7,[pool_0232C1DC]	; 0232C1A0
	mov r6,#0x40	; 0232C1A2
loc_0232C1A4:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C1A4
	str r0,[r4,#0x4]	; 0232C1A8
	add r0,r7,#0x0	; 0232C1AA
	bl loc_0232AEE8	; 0232C1AC
	and r0,r6	; 0232C1B0
	str r0,[r4,#0x0]	; 0232C1B2
	ldr r0,[r4,#0x0]	; 0232C1B4
	cmp r0,#0x0	; 0232C1B6
	bne loc_0232C1D2	; 0232C1B8
	add r0,r5,#0x0	; 0232C1BA
	bl loc_0232AF70	; 0232C1BC
	cmp r0,#0x0	; 0232C1C0
	beq loc_0232C1D2	; 0232C1C2
	ldr r0,[r4,#0x4]	; 0232C1C4
	blx P1_Arm9RestoreIrqMask	; 0232C1C6
	mov r0,#0x1	; 0232C1CA
	bl loc_0232C3DC	; 0232C1CC
	b loc_0232C1A4	; 0232C1D0
loc_0232C1D2:
	add sp,#0x4	; 0232C1D2
	pop {r4,r5,r6,r7}	; 0232C1D4
	pop {r3}	; 0232C1D6
	bx r3	; 0232C1D8
	.byte 0xC0, 0x46	; 0232C1DC
pool_0232C1DC:
loc_0232C1DC:
	.word 0x027FFFE8	; 0232C1DC

; ===== function loc_0232C1E0 =====
loc_0232C1E0:
	push {r4}	; 0232C1E0
	sub sp,#0x4	; 0232C1E2
	ldr r4,[r0,#0x0]	; 0232C1E4
	ldr r3,[pool_0232C208]	; 0232C1E6
	ldrh r2,[r3,#0x0]	; 0232C1E8
	mov r1,#0xc	; 0232C1EA
	bic r2,r1	; 0232C1EC
	lsl r1,r4,#0x2	; 0232C1EE
	orr r2,r1	; 0232C1F0
	strh r2,[r3,#0x0]	; 0232C1F2
	ldr r2,[r0,#0x4]	; 0232C1F4
	ldrh r1,[r3,#0x0]	; 0232C1F6
	mov r0,#0x10	; 0232C1F8
	bic r1,r0	; 0232C1FA
	lsl r0,r2,#0x4	; 0232C1FC
	orr r1,r0	; 0232C1FE
	strh r1,[r3,#0x0]	; 0232C200
	add sp,#0x4	; 0232C202
	pop {r4}	; 0232C204
	bx lr	; 0232C206
pool_0232C208:
loc_0232C208:
	.word REG_EXMEMCNT_ARM9	; 0232C208

; ===== function loc_0232C20C =====
loc_0232C20C:
	push {r4}	; 0232C20C
	sub sp,#0x4	; 0232C20E
	ldr r4,[pool_0232C23C]	; 0232C210
	ldrh r2,[r4,#0x0]	; 0232C212
	mov r1,#0xc	; 0232C214
	and r2,r1	; 0232C216
	asr r2,r2,#0x2	; 0232C218
	str r2,[r0,#0x0]	; 0232C21A
	ldrh r3,[r4,#0x0]	; 0232C21C
	mov r2,#0x10	; 0232C21E
	and r3,r2	; 0232C220
	asr r3,r3,#0x4	; 0232C222
	str r3,[r0,#0x4]	; 0232C224
	ldrh r0,[r4,#0x0]	; 0232C226
	bic r0,r1	; 0232C228
	orr r0,r1	; 0232C22A
	strh r0,[r4,#0x0]	; 0232C22C
	ldrh r0,[r4,#0x0]	; 0232C22E
	bic r0,r2	; 0232C230
	strh r0,[r4,#0x0]	; 0232C232
	add sp,#0x4	; 0232C234
	pop {r4}	; 0232C236
	bx lr	; 0232C238
	.byte 0xC0, 0x46	; 0232C23C
pool_0232C23C:
loc_0232C23C:
	.word REG_EXMEMCNT_ARM9	; 0232C23C

; ===== function loc_0232C240 =====
loc_0232C240:
	push {r4,lr}	; 0232C240
	sub sp,#0x10	; 0232C242
	mov r4,#0x1	; 0232C244
	ldr r2,[pool_0232C2E8]	; 0232C246
	ldrh r1,[r2,#0x0]	; 0232C248
	ldr r0,[pool_0232C2EC]	; 0232C24A
	cmp r1,r0	; 0232C24C
	bne loc_0232C25A	; 0232C24E
	mov r0,#0x0	; 0232C250
	add sp,#0x10	; 0232C252
	pop {r4}	; 0232C254
	pop {r3}	; 0232C256
	bx r3	; 0232C258
loc_0232C25A:
	ldrb r0,[r2,#0x5]	; 0232C25A
	lsl r0,r0,#0x1e	; 0232C25C
	lsr r0,r0,#0x1f	; 0232C25E
	cmp r0,#0x1	; 0232C260
	bne loc_0232C26E	; 0232C262
	mov r0,#0x0	; 0232C264
	add sp,#0x10	; 0232C266
	pop {r4}	; 0232C268
	pop {r3}	; 0232C26A
	bx r3	; 0232C26C
loc_0232C26E:
	ldr r0,[pool_0232C2F0]	; 0232C26E
	ldrh r0,[r0,#0x2]	; 0232C270
	add r1,sp,#0x0	; 0232C272
	bl loc_0232C198	; 0232C274
	add r0,sp,#0x8	; 0232C278
	bl loc_0232C20C	; 0232C27A
	ldr r2,[pool_0232C2F4]	; 0232C27E
	add r0,r2,#0x0	; 0232C280
	add r0,#0xb2	; 0232C282
	ldrb r3,[r0,#0x0]	; 0232C284
	cmp r3,#0x96	; 0232C286
	bne loc_0232C296	; 0232C288
	ldr r0,[pool_0232C2E8]	; 0232C28A
	ldrh r1,[r0,#0x0]	; 0232C28C
	add r2,#0xbe	; 0232C28E
	ldrh r0,[r2,#0x0]	; 0232C290
	cmp r1,r0	; 0232C292
	bne loc_0232C2BE	; 0232C294
loc_0232C296:
	cmp r3,#0x96	; 0232C296
	beq loc_0232C2A6	; 0232C298
	ldr r0,[pool_0232C2E8]	; 0232C29A
	ldrh r1,[r0,#0x0]	; 0232C29C
	ldr r0,[pool_0232C2F8]	; 0232C29E
	ldrh r0,[r0,#0x0]	; 0232C2A0
	cmp r1,r0	; 0232C2A2
	bne loc_0232C2BE	; 0232C2A4
loc_0232C2A6:
	ldr r2,[pool_0232C2E8]	; 0232C2A6
	ldr r1,[r2,#0x8]	; 0232C2A8
	ldr r0,[pool_0232C2F4]	; 0232C2AA
	add r0,#0xac	; 0232C2AC
	ldr r0,[r0,#0x0]	; 0232C2AE
	cmp r1,r0	; 0232C2B0
	beq loc_0232C2CC	; 0232C2B2
	ldrb r0,[r2,#0x5]	; 0232C2B4
	lsl r0,r0,#0x1f	; 0232C2B6
	lsr r0,r0,#0x1f	; 0232C2B8
	cmp r0,#0x0	; 0232C2BA
	beq loc_0232C2CC	; 0232C2BC
loc_0232C2BE:
	ldr r0,[pool_0232C2E8]	; 0232C2BE
	add r2,r0,#0x5	; 0232C2C0
	ldrb r1,[r2,#0x0]	; 0232C2C2
	mov r0,#0x2	; 0232C2C4
	orr r1,r0	; 0232C2C6
	strb r1,[r2,#0x0]	; 0232C2C8
	mov r4,#0x0	; 0232C2CA
loc_0232C2CC:
	add r0,sp,#0x8	; 0232C2CC
	bl loc_0232C1E0	; 0232C2CE
	ldr r0,[pool_0232C2F0]	; 0232C2D2
	ldrh r0,[r0,#0x2]	; 0232C2D4
	add r1,sp,#0x0	; 0232C2D6
	bl loc_0232C17C	; 0232C2D8
	add r0,r4,#0x0	; 0232C2DC
	add sp,#0x10	; 0232C2DE
	pop {r4}	; 0232C2E0
	pop {r3}	; 0232C2E2
	bx r3	; 0232C2E4
	.byte 0xC0, 0x46	; 0232C2E8
pool_0232C2E8:
loc_0232C2E8:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C2E8
pool_0232C2EC:
loc_0232C2EC:
	.word 0x0000FFFF	; 0232C2EC
pool_0232C2F0:
loc_0232C2F0:
	.word P1_BssStart + 0x26680	; 0232C2F0
pool_0232C2F4:
loc_0232C2F4:
	.word 0x08000000	; 0232C2F4
pool_0232C2F8:
loc_0232C2F8:
	.word 0x0801FFFE	; 0232C2F8

; ===== function loc_0232C2FC =====
loc_0232C2FC:
	push {lr}	; 0232C2FC
	sub sp,#0x4	; 0232C2FE
	ldr r2,[pool_0232C330]	; 0232C300
	ldrh r1,[r2,#0x0]	; 0232C302
	ldr r0,[pool_0232C334]	; 0232C304
	cmp r1,r0	; 0232C306
	bne loc_0232C312	; 0232C308
	mov r0,#0x0	; 0232C30A
	add sp,#0x4	; 0232C30C
	pop {r3}	; 0232C30E
	bx r3	; 0232C310
loc_0232C312:
	ldrb r0,[r2,#0x5]	; 0232C312
	lsl r0,r0,#0x1e	; 0232C314
	lsr r0,r0,#0x1f	; 0232C316
	cmp r0,#0x0	; 0232C318
	bne loc_0232C320	; 0232C31A
	bl loc_0232C240	; 0232C31C
loc_0232C320:
	ldr r0,[pool_0232C330]	; 0232C320
	ldrb r0,[r0,#0x5]	; 0232C322
	lsl r0,r0,#0x1e	; 0232C324
	lsr r0,r0,#0x1f	; 0232C326
	add sp,#0x4	; 0232C328
	pop {r3}	; 0232C32A
	bx r3	; 0232C32C
	.byte 0xC0, 0x46	; 0232C330
pool_0232C330:
loc_0232C330:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C330
pool_0232C334:
loc_0232C334:
	.word 0x0000FFFF	; 0232C334

; ===== function loc_0232C338 =====
loc_0232C338:
	push {r4}	; 0232C338
	sub sp,#0x4	; 0232C33A
	mov r4,#0x0	; 0232C33C
	ldr r3,[pool_0232C360]	; 0232C33E
	ldrh r2,[r3,#0x0]	; 0232C340
	ldr r1,[pool_0232C364]	; 0232C342
	cmp r2,r1	; 0232C344
	beq loc_0232C358	; 0232C346
	cmp r2,#0x0	; 0232C348
	beq loc_0232C358	; 0232C34A
	ldrb r1,[r3,#0x0]	; 0232C34C
	mvn r1,r1	; 0232C34E
	and r1,r0	; 0232C350
	cmp r1,#0x0	; 0232C352
	beq loc_0232C358	; 0232C354
	mov r4,#0x1	; 0232C356
loc_0232C358:
	add r0,r4,#0x0	; 0232C358
	add sp,#0x4	; 0232C35A
	pop {r4}	; 0232C35C
	bx lr	; 0232C35E
pool_0232C360:
loc_0232C360:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C360
pool_0232C364:
loc_0232C364:
	.word 0x0000FFFF	; 0232C364

; ===== function loc_0232C368 =====
loc_0232C368:
	push {r4,lr}	; 0232C368
	add r4,r0,#0x0	; 0232C36A
	bl loc_0232C240	; 0232C36C
	cmp r0,#0x0	; 0232C370
	beq loc_0232C386	; 0232C372
	add r0,r4,#0x0	; 0232C374
	bl loc_0232C338	; 0232C376
	cmp r0,#0x0	; 0232C37A
	beq loc_0232C386	; 0232C37C
	mov r0,#0x1	; 0232C37E
	pop {r4}	; 0232C380
	pop {r3}	; 0232C382
	bx r3	; 0232C384
loc_0232C386:
	mov r0,#0x0	; 0232C386
	pop {r4}	; 0232C388
	pop {r3}	; 0232C38A
	bx r3	; 0232C38C
	.byte 0x00, 0x00	; 0232C390

; ===== function loc_0232C390 =====
loc_0232C390:
	push {lr}	; 0232C390
	sub sp,#0x4	; 0232C392
	mov r0,#0x0	; 0232C394
	str r0,[sp,#0x0]	; 0232C396
	add r0,sp,#0x0	; 0232C398
	ldr r1,[pool_0232C3B0]	; 0232C39A
	ldr r2,[pool_0232C3B4]	; 0232C39C
	bl loc_0232C3FA	; 0232C39E
	blx loc_0232AE50	; 0232C3A2
	ldr r1,[pool_0232C3B0]	; 0232C3A6
	strh r0,[r1,#0x2]	; 0232C3A8
	add sp,#0x4	; 0232C3AA
	pop {r3}	; 0232C3AC
	bx r3	; 0232C3AE
pool_0232C3B0:
loc_0232C3B0:
	.word P1_BssStart + 0x26680	; 0232C3B0
pool_0232C3B4:
loc_0232C3B4:
	.word 0x05000001	; 0232C3B4

; ===== function loc_0232C3B8 =====
loc_0232C3B8:
	push {lr}	; 0232C3B8
	sub sp,#0x4	; 0232C3BA
	ldr r0,[pool_0232C3D4]	; 0232C3BC
	ldr r1,[r0,#0x0]	; 0232C3BE
	cmp r1,#0x0	; 0232C3C0
	bne loc_0232C3CC	; 0232C3C2
	mov r1,#0x1	; 0232C3C4
	str r1,[r0,#0x0]	; 0232C3C6
	bl loc_0232C390	; 0232C3C8
loc_0232C3CC:
	add sp,#0x4	; 0232C3CC
	pop {r3}	; 0232C3CE
	bx r3	; 0232C3D0
	.byte 0xC0, 0x46	; 0232C3D4
pool_0232C3D4:
loc_0232C3D4:
	.word P1_BssStart + 0x26684	; 0232C3D4
	.byte 0x00, 0xDF, 0x70, 0x47	; 0232C3DC

; ===== function loc_0232C3DC =====
.func P1_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
loc_0232C3DC:
	swi 0x3	; 0232C3DC
	bx lr	; 0232C3DE
.endfunc
	.byte 0x00, 0x22, 0x04, 0xDF, 0x70, 0x47	; 0232C3E6

; ===== function loc_0232C3E6 =====
.func P1_SwiVBlankIntrWait
; BIOS SWI #05: wait for VBlank IRQ. / BIOS SWI #05：等待 VBlank 中断。
loc_0232C3E6:
	mov r2,#0x0	; 0232C3E6
	swi 0x5	; 0232C3E8
	bx lr	; 0232C3EA
.endfunc
.func P1_SwiHalt
; BIOS SWI #06: halt ARM9 until an interrupt. / BIOS SWI #06：使 ARM9 停止至中断发生。
	swi 0x6
	bx lr
.endfunc
.func P1_SwiDiv
; BIOS SWI #09: signed division, returning quotient. / BIOS SWI #09：有符号除法，返回商。
	swi 0x9
	bx lr
.endfunc
.func P1_SwiMod
; BIOS SWI #09: signed division wrapper returning remainder. / BIOS SWI #09：有符号除法包装，返回余数。
	swi 0x9
	mov r0,r1
	bx lr
.endfunc

; ===== function loc_0232C3FA =====
.func P1_SwiCpuSet
; BIOS SWI #0B: CpuSet copy/fill. / BIOS SWI #0B：CpuSet 复制/填充。
loc_0232C3FA:
	swi 0xb	; 0232C3FA
	bx lr	; 0232C3FC
.endfunc

; ===== function loc_0232C3FE =====
.func P1_SwiCpuFastSet
; BIOS SWI #0C: CpuFastSet copy/fill. / BIOS SWI #0C：CpuFastSet 复制/填充。
loc_0232C3FE:
	swi 0xc	; 0232C3FE
	bx lr	; 0232C400
.endfunc
.func P1_SwiSqrt
; BIOS SWI #0D: integer square root. / BIOS SWI #0D：整数平方根。
	swi 0xd
	bx lr
.endfunc

; ===== function loc_0232C406 =====
.func P1_SwiGetCrc16
; BIOS SWI #0E: CRC-16 service. / BIOS SWI #0E：CRC-16 服务。
loc_0232C406:
	swi 0xe	; 0232C406
	bx lr	; 0232C408
.endfunc
.func P1_SwiIsDebugger
; BIOS SWI #0F: detect debugger state. / BIOS SWI #0F：检测调试器状态。
	swi 0x0f
	bx lr
.endfunc

; ===== function loc_0232C40E =====
.func P1_SwiBitUnPack
; BIOS SWI #10: BitUnPack decoder. / BIOS SWI #10：BitUnPack 解码器。
loc_0232C40E:
	swi 0x10	; 0232C40E
	bx lr	; 0232C410
.endfunc
.func P1_SwiLZ77UnCompWRAM
; BIOS SWI #11: decompress LZ77 into WRAM. / BIOS SWI #11：向 WRAM 解压 LZ77。
	swi 0x11
	bx lr
.endfunc
.func P1_SwiLZ77UnCompVRAM
; BIOS SWI #12: decompress LZ77 into VRAM. / BIOS SWI #12：向 VRAM 解压 LZ77。
	swi 0x12
	bx lr
.endfunc

; ===== function loc_0232C41A =====
.func P1_SwiHuffUnComp
; BIOS SWI #13: Huffman decoder. / BIOS SWI #13：Huffman 解码器。
loc_0232C41A:
	swi 0x13	; 0232C41A
	bx lr	; 0232C41C
.endfunc
.func P1_SwiRLUnCompWRAM
; BIOS SWI #14: decompress run-length data into WRAM. / BIOS SWI #14：向 WRAM 解压游程编码数据。
	swi 0x14
	bx lr
.endfunc
.func P1_SwiRLUnCompVRAM
; BIOS SWI #15: decompress run-length data into VRAM. / BIOS SWI #15：向 VRAM 解压游程编码数据。
	swi 0x15
	bx lr
.endfunc
	.byte 0x00, 0x00	; alignment
loc_0232C428:
.arm
; 先复制初始化代码/数据，再清零各段尾部和主 BSS；源区随后可复用。
; Copy initialized code/data, then clear per-segment tails and main BSS.
.func P1_InitializeDataAndBss
    ldr r0,[P1_CrtInitTablePointer]
    ldr r1,[r0,#0x0]
    ldr r2,[r0,#0x4]
    ldr r3,[r0,#0x8]
P1_CrtNextCopy:
    cmp r1,r2
    beq P1_CrtMainBss
    ldr r4,[r1],#0x4
    ldr r5,[r1],#0x4
    add r6,r4,r5
P1_CrtCopyWords:
    cmp r4,r6
    ldrmi r7,[r3],#0x4
    strmi r7,[r4],#0x4
    bmi P1_CrtCopyWords
    ldr r5,[r1],#0x4
    add r6,r4,r5
    mov r7,#0x0
P1_CrtClearCopyTail:
    cmp r4,r6
    strcc r7,[r4],#0x4
    bcc P1_CrtClearCopyTail
    beq P1_CrtNextCopy
P1_CrtMainBss:
    ldr r4,[r0,#0xc]
    ldr r6,[r0,#0x10]
    mov r7,#0x0
P1_CrtClearMainBss:
    cmp r4,r6
    strcc r7,[r4],#0x4
    bcc P1_CrtClearMainBss
    b P1_CrtInitReturn
P1_CrtInitTablePointer:
    .word P1_CrtDataInitTable
P1_CrtInitReturn:
    bx lr
.endfunc
; Configures ARM9 CP15 control/cache state before C/C++ runtime setup.
; 在 C/C++ 运行时建立前配置 ARM9 的 CP15 控制与缓存状态。
.arm
; Programs the fixed ARM946 CP15 control, MPU-region and cache-access state.
; 写入固定的 ARM946 CP15 控制、MPU 区域与缓存访问状态。
.func P1_Arm9ConfigureCp15
loc_0232C49C:
	mrc p15, 0x0, r0, c1, c0, 0x0
	ldr r1, [P1_Cp15ControlDisableMask]
	bic r0, r0, r1
	mcr p15, 0x0, r0, c1, c0, 0x0
	mov r0, 0x0
	mcr p15, 0x0, r0, c7, c5, 0x0
	mcr p15, 0x0, r0, c7, c6, 0x0
	mcr p15, 0x0, r0, c7, c10, 0x4
	ldr r0, [P1_Cp15MpuRegion0Config]
	mcr p15, 0x0, r0, c6, c0, 0x0
	ldr r0, [P1_Cp15MpuRegion1Config]
	mcr p15, 0x0, r0, c6, c1, 0x0
	ldr r0, [P1_Cp15MpuRegion3Config]
	mcr p15, 0x0, r0, c6, c3, 0x0
	ldr r0, [P1_Cp15MpuRegion4Base]
	orr r0, r0, 0x1A
	orr r0, r0, 0x1
	mcr p15, 0x0, r0, c6, c4, 0x0
	ldr r0, [P1_Cp15MpuRegion5Config]
	mcr p15, 0x0, r0, c6, c5, 0x0
	ldr r0, [P1_Cp15MpuRegion6Config]
	mcr p15, 0x0, r0, c6, c6, 0x0
	ldr r0, [P1_Cp15MpuRegion7Config]
	mcr p15, 0x0, r0, c6, c7, 0x0
	mov r0, 0x20
	mcr p15, 0x0, r0, c9, c1, 0x1
	ldr r0, [P1_Cp15MpuRegion4Base]
	orr r0, r0, 0xA
	mcr p15, 0x0, r0, c9, c1, 0x0
	mov r0, 0x42
	mcr p15, 0x0, r0, c2, c0, 0x1
	mov r0, 0x42
	mcr p15, 0x0, r0, c2, c0, 0x0
	mov r0, 0x2
	mcr p15, 0x0, r0, c3, c0, 0x0
	ldr r0, [P1_Cp15InstructionAccessConfig]
	mcr p15, 0x0, r0, c5, c0, 0x3
	ldr r0, [P1_Cp15DataAccessConfig]
	mcr p15, 0x0, r0, c5, c0, 0x2
	mrc p15, 0x0, r0, c1, c0, 0x0
	ldr r1, [P1_Cp15ControlEnableMask]
	orr r0, r0, r1
	mcr p15, 0x0, r0, c1, c0, 0x0
	bx lr
.endfunc

P1_Cp15ControlDisableMask:       .word 0x000F9005
P1_Cp15MpuRegion0Config:         .word 0x04000033
P1_Cp15MpuRegion1Config:         .word 0x0200002B
P1_Cp15MpuRegion3Config:         .word 0x08000035
P1_Cp15MpuRegion4Base:           .word 0x03000000
P1_Cp15MpuRegion5Config:         .word 0x0100002F
P1_Cp15MpuRegion6Config:         .word 0xFFFF001D
P1_Cp15MpuRegion7Config:         .word 0x027FF017
P1_Cp15InstructionAccessConfig:  .word 0x05100011
P1_Cp15DataAccessConfig:         .word 0x15111011
P1_Cp15ControlEnableMask:        .word 0x0005707D
.thumb
loc_0232C578:
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x10, 0xB4, 0x81, 0xB0, 0x00, 0x2A, 0x17, 0xD0, 0x04, 0x78, 0x40, 0x1C	; 0232C588
	.byte 0x0B, 0x78, 0x49, 0x1C, 0x9C, 0x42, 0x0E, 0xD0, 0x40, 0x1E, 0x02, 0x78, 0x48, 0x1E, 0x00, 0x78	; 0232C598
	.byte 0x82, 0x42, 0x04, 0xD2, 0x00, 0x20, 0xC0, 0x43, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x01, 0x20	; 0232C5A8
	.byte 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x52, 0x1E, 0x00, 0x2A, 0xE7, 0xD1, 0x00, 0x20, 0x01, 0xB0	; 0232C5B8
	.byte 0x10, 0xBC, 0x70, 0x47	; 0232C5BC

; Standard memset: fill r2 bytes at r0 with low byte of r1 and return original r0.
; 标准 memset：以 r1 低字节填充 r0 起始的 r2 字节，并返回原 r0。
P1_MemSet:
; ===== function loc_0232C5BC =====
	push {r4,lr}	; 0232C5BC
	add r4,r0,#0x0	; 0232C5BE
	bl P1_MemSetCore	; 0232C5C0
	add r0,r4,#0x0	; 0232C5C4
	pop {r4}	; 0232C5C6
	pop {r3}	; 0232C5C8
	bx r3	; 0232C5CA

; ===== function loc_0232C5CC =====
; Core byte/word fill loop; r0 advances to the end. / 核心字节/字填充循环；r0 前进至末尾。
P1_MemSetCore:
loc_0232C5CC:
	push {r4,r5}	; 0232C5CC
	lsl r1,r1,#0x18	; 0232C5CE
	lsr r1,r1,#0x18	; 0232C5D0
	cmp r2,#0x20	; 0232C5D2
	bcc loc_0232C63A	; 0232C5D4
	neg r4,r0	; 0232C5D6
	mov r3,#0x3	; 0232C5D8
	and r4,r3	; 0232C5DA
	cmp r4,#0x0	; 0232C5DC
	beq loc_0232C5F0	; 0232C5DE
	sub r2,r2,r4	; 0232C5E0
	lsl r3,r1,#0x18	; 0232C5E2
	lsr r3,r3,#0x18	; 0232C5E4
loc_0232C5E6:
	strb r3,[r0,#0x0]	; 0232C5E6
	add r0,r0,#0x1	; 0232C5E8
	sub r4,r4,#0x1	; 0232C5EA
	cmp r4,#0x0	; 0232C5EC
	bne loc_0232C5E6	; 0232C5EE
loc_0232C5F0:
	cmp r1,#0x0	; 0232C5F0
	beq loc_0232C600	; 0232C5F2
	lsl r5,r1,#0x8	; 0232C5F4
	lsl r4,r1,#0x18	; 0232C5F6
	lsl r3,r1,#0x10	; 0232C5F8
	orr r4,r3	; 0232C5FA
	orr r5,r4	; 0232C5FC
	orr r1,r5	; 0232C5FE
loc_0232C600:
	lsr r4,r2,#0x5	; 0232C600
	cmp r4,#0x0	; 0232C602
	beq loc_0232C622	; 0232C604
loc_0232C606:
	str r1,[r0,#0x0]	; 0232C606
	str r1,[r0,#0x4]	; 0232C608
	str r1,[r0,#0x8]	; 0232C60A
	str r1,[r0,#0xc]	; 0232C60C
	str r1,[r0,#0x10]	; 0232C60E
	str r1,[r0,#0x14]	; 0232C610
	str r1,[r0,#0x18]	; 0232C612
	add r3,r0,#0x0	; 0232C614
	add r3,#0x1c	; 0232C616
	add r0,#0x20	; 0232C618
	str r1,[r3,#0x0]	; 0232C61A
	sub r4,r4,#0x1	; 0232C61C
	cmp r4,#0x0	; 0232C61E
	bne loc_0232C606	; 0232C620
loc_0232C622:
	mov r3,#0x1f	; 0232C622
	add r4,r2,#0x0	; 0232C624
	and r4,r3	; 0232C626
	lsr r3,r4,#0x2	; 0232C628
	cmp r3,#0x0	; 0232C62A
	beq loc_0232C636	; 0232C62C
loc_0232C62E:
	stmia r0!,{r1}	; 0232C62E
	sub r3,r3,#0x1	; 0232C630
	cmp r3,#0x0	; 0232C632
	bne loc_0232C62E	; 0232C634
loc_0232C636:
	mov r3,#0x3	; 0232C636
	and r2,r3	; 0232C638
loc_0232C63A:
	cmp r2,#0x0	; 0232C63A
	beq loc_0232C64C	; 0232C63C
	lsl r1,r1,#0x18	; 0232C63E
	lsr r1,r1,#0x18	; 0232C640
loc_0232C642:
	strb r1,[r0,#0x0]	; 0232C642
	add r0,r0,#0x1	; 0232C644
	sub r2,r2,#0x1	; 0232C646
	cmp r2,#0x0	; 0232C648
	bne loc_0232C642	; 0232C64A
loc_0232C64C:
	pop {r4,r5}	; 0232C64C
	bx lr	; 0232C64E

; UTF-16 strchr: find a code unit, including the terminating NUL. / UTF-16 strchr：查找码元，包括结尾 NUL。
P1_Utf16StrChr:
; ===== function loc_0232C650 =====
loc_0232C650:
	add r2,r0,#0x2	; 0232C650
	ldrh r0,[r0,#0x0]	; 0232C652
	cmp r0,#0x0	; 0232C654
	beq loc_0232C668	; 0232C656
loc_0232C658:
	cmp r0,r1	; 0232C658
	bne loc_0232C660	; 0232C65A
	sub r0,r2,#0x2	; 0232C65C
	bx lr	; 0232C65E
loc_0232C660:
	ldrh r0,[r2,#0x0]	; 0232C660
	add r2,r2,#0x2	; 0232C662
	cmp r0,#0x0	; 0232C664
	bne loc_0232C658	; 0232C666
loc_0232C668:
	cmp r1,#0x0	; 0232C668
	beq loc_0232C670	; 0232C66A
	mov r0,#0x0	; 0232C66C
	bx lr	; 0232C66E
loc_0232C670:
	sub r0,r2,#0x2	; 0232C670
	bx lr	; 0232C672

; UTF-16 bounded comparison. / UTF-16 定长字符串比较。
P1_Utf16StrNCmp:
; ===== function loc_0232C674 =====
	push {r4}	; 0232C674
	sub sp,#0x4	; 0232C676
	cmp r2,#0x0	; 0232C678
	beq loc_0232C69A	; 0232C67A
loc_0232C67C:
	ldrh r4,[r1,#0x0]	; 0232C67C
	add r1,r1,#0x2	; 0232C67E
	ldrh r3,[r0,#0x0]	; 0232C680
	add r0,r0,#0x2	; 0232C682
	cmp r3,r4	; 0232C684
	beq loc_0232C690	; 0232C686
	sub r0,r3,r4	; 0232C688
	add sp,#0x4	; 0232C68A
	pop {r4}	; 0232C68C
	bx lr	; 0232C68E
loc_0232C690:
	cmp r3,#0x0	; 0232C690
	beq loc_0232C69A	; 0232C692
	sub r2,r2,#0x1	; 0232C694
	cmp r2,#0x0	; 0232C696
	bne loc_0232C67C	; 0232C698
loc_0232C69A:
	mov r0,#0x0	; 0232C69A
	add sp,#0x4	; 0232C69C
	pop {r4}	; 0232C69E
	bx lr	; 0232C6A0
	.byte 0x00, 0x00, 0x10, 0xB4, 0x81, 0xB0, 0x04, 0x1C, 0x22, 0x88, 0xA4, 0x1C, 0x00, 0x2A, 0xFB, 0xD1	; 0232C6B2
	.byte 0xA4, 0x1E, 0x23, 0x1C, 0x0A, 0x88, 0x89, 0x1C, 0x22, 0x80, 0xA4, 0x1C, 0x1A, 0x88, 0x00, 0x2A	; 0232C6C2
	.byte 0xF7, 0xD1, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x00, 0x00	; 0232C6CC

; UTF-16 bounded copy with NUL padding. / UTF-16 定长复制，结尾不足时补 NUL。
P1_Utf16StrNCpy:
; ===== function loc_0232C6CC =====
loc_0232C6CC:
	push {r4,r5}	; 0232C6CC
	add r5,r0,#0x0	; 0232C6CE
	cmp r2,#0x0	; 0232C6D0
	beq loc_0232C700	; 0232C6D2
loc_0232C6D4:
	add r4,r5,#0x0	; 0232C6D4
	ldrh r3,[r1,#0x0]	; 0232C6D6
	add r1,r1,#0x2	; 0232C6D8
	strh r3,[r5,#0x0]	; 0232C6DA
	add r5,r5,#0x2	; 0232C6DC
	ldrh r3,[r4,#0x0]	; 0232C6DE
	cmp r3,#0x0	; 0232C6E0
	bne loc_0232C6FA	; 0232C6E2
	sub r2,r2,#0x1	; 0232C6E4
	cmp r2,#0x0	; 0232C6E6
	beq loc_0232C700	; 0232C6E8
	mov r1,#0x0	; 0232C6EA
loc_0232C6EC:
	strh r1,[r5,#0x0]	; 0232C6EC
	add r5,r5,#0x2	; 0232C6EE
	sub r2,r2,#0x1	; 0232C6F0
	cmp r2,#0x0	; 0232C6F2
	bne loc_0232C6EC	; 0232C6F4
	pop {r4,r5}	; 0232C6F6
	bx lr	; 0232C6F8
loc_0232C6FA:
	sub r2,r2,#0x1	; 0232C6FA
	cmp r2,#0x0	; 0232C6FC
	bne loc_0232C6D4	; 0232C6FE
loc_0232C700:
	pop {r4,r5}	; 0232C700
	bx lr	; 0232C702

; UTF-16 unbounded copy through the terminating NUL. / UTF-16 复制，直至结尾 NUL。
P1_Utf16StrCpy:
; ===== function loc_0232C704 =====
loc_0232C704:
	push {r4}	; 0232C704
	sub sp,#0x4	; 0232C706
	add r4,r0,#0x0	; 0232C708
loc_0232C70A:
	add r3,r4,#0x0	; 0232C70A
	ldrh r2,[r1,#0x0]	; 0232C70C
	add r1,r1,#0x2	; 0232C70E
	strh r2,[r4,#0x0]	; 0232C710
	add r4,r4,#0x2	; 0232C712
	ldrh r2,[r3,#0x0]	; 0232C714
	cmp r2,#0x0	; 0232C716
	bne loc_0232C70A	; 0232C718
	add sp,#0x4	; 0232C71A
	pop {r4}	; 0232C71C
	bx lr	; 0232C71E
; UTF-16 strlen: count code units before the terminating NUL. / UTF-16 strlen：统计结尾 NUL 前的码元数。
P1_Utf16StrLen:
; ===== function loc_0232C720 =====
loc_0232C720:
	mov r1,#0x0	; 0232C720
	mvn r2,r1	; 0232C722
loc_0232C724:
	add r2,r2,#0x1	; 0232C724
	ldrh r1,[r0,#0x0]	; 0232C726
	add r0,r0,#0x2	; 0232C728
	cmp r1,#0x0	; 0232C72A
	bne loc_0232C724	; 0232C72C
	add r0,r2,#0x0	; 0232C72E
	bx lr	; 0232C730
	.hword 0x0000	; padding / 对齐填充。
.arm

; ===== function loc_0232C734 =====
loc_0232C734:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C734
	mov r4,#0x0	; 0232C738
	b loc_0232C748	; 0232C73C
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 0232C748
loc_0232C748:
	orrs r5,r3,r2	; 0232C748
	bne loc_0232C758	; 0232C74C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C750
	bx lr	; 0232C754
loc_0232C758:
	orrs r5,r1,r3	; 0232C758
	bne loc_0232C800	; 0232C75C
	mov r1,r2	; 0232C760
	bl loc_0232CB70	; 0232C764
	cmp r4,#0x0	; 0232C768
	movne r0,r1	; 0232C76C
	mov r1,#0x0	; 0232C770
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C774
	bx lr	; 0232C778
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 0232C78C
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x03, 0x40, 0x21, 0xE0, 0xC4, 0x40, 0xA0, 0xE1, 0x84, 0x40, 0xA0, 0xE1	; 0232C79C
	.byte 0x02, 0x50, 0x93, 0xE1, 0x01, 0x00, 0x00, 0x1A, 0xF0, 0x58, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 0232C7AC
	.byte 0xA0, 0x5F, 0xA0, 0xE1, 0x01, 0x50, 0x85, 0xE0, 0xA2, 0x6F, 0xA0, 0xE1, 0x03, 0x60, 0x86, 0xE0	; 0232C7BC
	.byte 0x06, 0x60, 0x95, 0xE1, 0x06, 0x00, 0x00, 0x1A, 0x02, 0x10, 0xA0, 0xE1, 0x63, 0x00, 0x00, 0xEB	; 0232C7CC
	.byte 0x01, 0x40, 0x14, 0xE2, 0x01, 0x00, 0xA0, 0x11, 0xC0, 0x1F, 0xA0, 0xE1, 0xF0, 0x58, 0xBD, 0xE8	; 0232C7DC
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x00, 0x00, 0x51, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x00, 0x70, 0xE2	; 0232C7EC
	.byte 0x00, 0x10, 0xE1, 0xE2, 0x00, 0x00, 0x53, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x20, 0x72, 0xE2	; 0232C7FC
	.byte 0x00, 0x30, 0xE3, 0xE2	; 0232C800
loc_0232C800:
	orrs r5,r1,r0	; 0232C800
	beq loc_0232C924	; 0232C804
	mov r5,#0x0	; 0232C808
	mov r6,#0x1	; 0232C80C
	cmp r3,#0x0	; 0232C810
	bmi loc_0232C82C	; 0232C814
loc_0232C818:
	add r5,r5,#0x1	; 0232C818
	adds r2,r2,r2	; 0232C81C
	adcs r3,r3,r3	; 0232C820
	bpl loc_0232C818	; 0232C824
	add r6,r6,r5	; 0232C828
loc_0232C82C:
	cmp r1,#0x0	; 0232C82C
	blt loc_0232C84C	; 0232C830
loc_0232C834:
	cmp r6,#0x1	; 0232C834
	beq loc_0232C84C	; 0232C838
	sub r6,r6,#0x1	; 0232C83C
	adds r0,r0,r0	; 0232C840
	adcs r1,r1,r1	; 0232C844
	bpl loc_0232C834	; 0232C848
loc_0232C84C:
	mov r7,#0x0	; 0232C84C
	mov r12,#0x0	; 0232C850
	mov r11,#0x0	; 0232C854
	b loc_0232C874	; 0232C858
loc_0232C85C:
	orr r12,r12,#0x1	; 0232C85C
	subs r6,r6,#0x1	; 0232C860
	beq loc_0232C8CC	; 0232C864
	adds r0,r0,r0	; 0232C868
	adcs r1,r1,r1	; 0232C86C
	adcs r7,r7,r7	; 0232C870
loc_0232C874:
	subs r0,r0,r2	; 0232C874
	sbcs r1,r1,r3	; 0232C878
	sbcs r7,r7,#0x0	; 0232C87C
	adds r12,r12,r12	; 0232C880
	adc r11,r11,r11	; 0232C884
	cmp r7,#0x0	; 0232C888
	bge loc_0232C85C	; 0232C88C
loc_0232C890:
	subs r6,r6,#0x1	; 0232C890
	beq loc_0232C8C4	; 0232C894
	adds r0,r0,r0	; 0232C898
	adcs r1,r1,r1	; 0232C89C
	adc r7,r7,r7	; 0232C8A0
	adds r0,r0,r2	; 0232C8A4
	adcs r1,r1,r3	; 0232C8A8
	adc r7,r7,#0x0	; 0232C8AC
	adds r12,r12,r12	; 0232C8B0
	adc r11,r11,r11	; 0232C8B4
	cmp r7,#0x0	; 0232C8B8
	bge loc_0232C85C	; 0232C8BC
	b loc_0232C890	; 0232C8C0
loc_0232C8C4:
	adds r0,r0,r2	; 0232C8C4
	adc r1,r1,r3	; 0232C8C8
loc_0232C8CC:
	ands r7,r4,#0x1	; 0232C8CC
	moveq r0,r12	; 0232C8D0
	moveq r1,r11	; 0232C8D4
	beq loc_0232C904	; 0232C8D8
	subs r7,r5,#0x20	; 0232C8DC
	movge r0,r1, lsr r7	; 0232C8E0
	bge loc_0232C928	; 0232C8E4
	rsb r7,r5,#0x20	; 0232C8E8
	mov r0,r0, lsr r5	; 0232C8EC
	orr r0,r0,r1, lsl r7	; 0232C8F0
	mov r1,r1, lsr r5	; 0232C8F4
	b loc_0232C904	; 0232C8F8
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 0232C904
loc_0232C904:
	cmp r4,#0x0	; 0232C904
	blt loc_0232C914	; 0232C908
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C90C
	bx lr	; 0232C910
loc_0232C914:
	rsbs r0,r0,#0x0	; 0232C914
	rsc r1,r1,#0x0	; 0232C918
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C91C
	bx lr	; 0232C920
loc_0232C924:
	mov r0,#0x0	; 0232C924
loc_0232C928:
	mov r1,#0x0	; 0232C928
	cmp r4,#0x0	; 0232C92C
	blt loc_0232C914	; 0232C930
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C934
	bx lr	; 0232C938

; ARM EABI 64-bit multiply (__aeabi_lmul); the bit pattern is identical for signed and unsigned operands. / ARM EABI 64 位乘法（__aeabi_lmul）；有符号与无符号操作数的位级结果相同。
P1_AeabiLmul:
; ===== function loc_0232C93C =====
loc_0232C93C:
	stmdb sp!,{r4,r5,lr}	; 0232C93C
	umull r5,r4,r0,r2	; 0232C940
	mla r4,r0,r3,r4	; 0232C944
	mla r4,r2,r1,r4	; 0232C948
	mov r1,r4	; 0232C94C
	mov r0,r5	; 0232C950
	ldmia sp!,{r4,r5,lr}	; 0232C954
	bx lr	; 0232C958

; 32-bit signed division with remainder: r0 = quotient, r1 = remainder. / 32 位有符号除法及取余：r0 为商，r1 为余数。
P1_SignedDivMod:
; ===== function loc_0232C95C =====
loc_0232C95C:
	eor r12,r0,r1	; 0232C95C
	and r12,r12,#0x80000000	; 0232C960
	cmp r0,#0x0	; 0232C964
	rsblt r0,r0,#0x0	; 0232C968
	addlt r12,r12,#0x1	; 0232C96C
	cmp r1,#0x0	; 0232C970
	rsblt r1,r1,#0x0	; 0232C974
	beq loc_0232CB54	; 0232C978
	cmp r0,r1	; 0232C97C
	movcc r1,r0	; 0232C980
	movcc r0,#0x0	; 0232C984
	bcc loc_0232CB54	; 0232C988
	mov r2,#0x1c	; 0232C98C
	mov r3,r0, lsr #0x4	; 0232C990
	cmp r1,r3, lsr #0xc	; 0232C994
	suble r2,r2,#0x10	; 0232C998
	movle r3,r3, lsr #0x10	; 0232C99C
	cmp r1,r3, lsr #0x4	; 0232C9A0
	suble r2,r2,#0x8	; 0232C9A4
	movle r3,r3, lsr #0x8	; 0232C9A8
	cmp r1,r3	; 0232C9AC
	suble r2,r2,#0x4	; 0232C9B0
	movle r3,r3, lsr #0x4	; 0232C9B4
	mov r0,r0, lsl r2	; 0232C9B8
	rsb r1,r1,#0x0	; 0232C9BC
	adds r0,r0,r0	; 0232C9C0
	add r2,r2,r2, lsl #0x1	; 0232C9C4
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232C9C8PC:
	add pc,pc,r2, lsl #0x2	; 0232C9C8
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232C9D0
loc_0232C9D0:
P1_DivisionDispatch_0232C9C8Steps:
	adcs r3,r1,r3, lsl #0x1	; 0232C9D0
	subcc r3,r3,r1	; 0232C9D4
	adcs r0,r0,r0	; 0232C9D8
	adcs r3,r1,r3, lsl #0x1	; 0232C9DC
	subcc r3,r3,r1	; 0232C9E0
	adcs r0,r0,r0	; 0232C9E4
	adcs r3,r1,r3, lsl #0x1	; 0232C9E8
	subcc r3,r3,r1	; 0232C9EC
	adcs r0,r0,r0	; 0232C9F0
	adcs r3,r1,r3, lsl #0x1	; 0232C9F4
	subcc r3,r3,r1	; 0232C9F8
	adcs r0,r0,r0	; 0232C9FC
loc_0232CA00:
	adcs r3,r1,r3, lsl #0x1	; 0232CA00
	subcc r3,r3,r1	; 0232CA04
	adcs r0,r0,r0	; 0232CA08
	adcs r3,r1,r3, lsl #0x1	; 0232CA0C
	subcc r3,r3,r1	; 0232CA10
	adcs r0,r0,r0	; 0232CA14
	adcs r3,r1,r3, lsl #0x1	; 0232CA18
	subcc r3,r3,r1	; 0232CA1C
	adcs r0,r0,r0	; 0232CA20
	adcs r3,r1,r3, lsl #0x1	; 0232CA24
	subcc r3,r3,r1	; 0232CA28
	adcs r0,r0,r0	; 0232CA2C
loc_0232CA30:
	adcs r3,r1,r3, lsl #0x1	; 0232CA30
	subcc r3,r3,r1	; 0232CA34
	adcs r0,r0,r0	; 0232CA38
	adcs r3,r1,r3, lsl #0x1	; 0232CA3C
	subcc r3,r3,r1	; 0232CA40
	adcs r0,r0,r0	; 0232CA44
	adcs r3,r1,r3, lsl #0x1	; 0232CA48
	subcc r3,r3,r1	; 0232CA4C
	adcs r0,r0,r0	; 0232CA50
	adcs r3,r1,r3, lsl #0x1	; 0232CA54
	subcc r3,r3,r1	; 0232CA58
	adcs r0,r0,r0	; 0232CA5C
	adcs r3,r1,r3, lsl #0x1	; 0232CA60
	subcc r3,r3,r1	; 0232CA64
	adcs r0,r0,r0	; 0232CA68
	adcs r3,r1,r3, lsl #0x1	; 0232CA6C
	subcc r3,r3,r1	; 0232CA70
	adcs r0,r0,r0	; 0232CA74
	adcs r3,r1,r3, lsl #0x1	; 0232CA78
	subcc r3,r3,r1	; 0232CA7C
	adcs r0,r0,r0	; 0232CA80
	adcs r3,r1,r3, lsl #0x1	; 0232CA84
	subcc r3,r3,r1	; 0232CA88
	adcs r0,r0,r0	; 0232CA8C
loc_0232CA90:
	adcs r3,r1,r3, lsl #0x1	; 0232CA90
	subcc r3,r3,r1	; 0232CA94
	adcs r0,r0,r0	; 0232CA98
	adcs r3,r1,r3, lsl #0x1	; 0232CA9C
	subcc r3,r3,r1	; 0232CAA0
	adcs r0,r0,r0	; 0232CAA4
	adcs r3,r1,r3, lsl #0x1	; 0232CAA8
	subcc r3,r3,r1	; 0232CAAC
	adcs r0,r0,r0	; 0232CAB0
	adcs r3,r1,r3, lsl #0x1	; 0232CAB4
	subcc r3,r3,r1	; 0232CAB8
	adcs r0,r0,r0	; 0232CABC
	adcs r3,r1,r3, lsl #0x1	; 0232CAC0
	subcc r3,r3,r1	; 0232CAC4
	adcs r0,r0,r0	; 0232CAC8
	adcs r3,r1,r3, lsl #0x1	; 0232CACC
	subcc r3,r3,r1	; 0232CAD0
	adcs r0,r0,r0	; 0232CAD4
	adcs r3,r1,r3, lsl #0x1	; 0232CAD8
	subcc r3,r3,r1	; 0232CADC
	adcs r0,r0,r0	; 0232CAE0
	adcs r3,r1,r3, lsl #0x1	; 0232CAE4
	subcc r3,r3,r1	; 0232CAE8
	adcs r0,r0,r0	; 0232CAEC
	adcs r3,r1,r3, lsl #0x1	; 0232CAF0
	subcc r3,r3,r1	; 0232CAF4
	adcs r0,r0,r0	; 0232CAF8
	adcs r3,r1,r3, lsl #0x1	; 0232CAFC
	subcc r3,r3,r1	; 0232CB00
	adcs r0,r0,r0	; 0232CB04
	adcs r3,r1,r3, lsl #0x1	; 0232CB08
	subcc r3,r3,r1	; 0232CB0C
	adcs r0,r0,r0	; 0232CB10
	adcs r3,r1,r3, lsl #0x1	; 0232CB14
	subcc r3,r3,r1	; 0232CB18
	adcs r0,r0,r0	; 0232CB1C
	adcs r3,r1,r3, lsl #0x1	; 0232CB20
	subcc r3,r3,r1	; 0232CB24
	adcs r0,r0,r0	; 0232CB28
	adcs r3,r1,r3, lsl #0x1	; 0232CB2C
	subcc r3,r3,r1	; 0232CB30
	adcs r0,r0,r0	; 0232CB34
	adcs r3,r1,r3, lsl #0x1	; 0232CB38
	subcc r3,r3,r1	; 0232CB3C
	adcs r0,r0,r0	; 0232CB40
	adcs r3,r1,r3, lsl #0x1	; 0232CB44
	subcc r3,r3,r1	; 0232CB48
	adcs r0,r0,r0	; 0232CB4C
P1_DivisionDispatch_0232C9C8End:
.if (P1_DivisionDispatch_0232C9C8Steps != P1_DivisionDispatch_0232C9C8PC + 8) || (P1_DivisionDispatch_0232C9C8End - P1_DivisionDispatch_0232C9C8Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232CB50
loc_0232CB54:
	ands r3,r12,#0x80000000	; 0232CB54
	rsbne r0,r0,#0x0	; 0232CB58
	ands r3,r12,#0x1	; 0232CB5C
	rsbne r1,r1,#0x0	; 0232CB60
	bx lr	; 0232CB64

; 32-bit unsigned division with remainder; the first entry returns immediately for a zero divisor. / 32 位无符号除法及取余；除数为零时第一个入口直接返回。
P1_UnsignedDivMod:
; ===== function loc_0232CB68 =====
loc_0232CB68:
	cmp r1,#0x0	; 0232CB68
	bxeq lr	; 0232CB6C

; ===== function loc_0232CB70 =====
loc_0232CB70:
	cmp r0,r1	; 0232CB70
	movcc r1,r0	; 0232CB74
	movcc r0,#0x0	; 0232CB78
	bxcc lr	; 0232CB7C
	mov r2,#0x1c	; 0232CB80
	mov r3,r0, lsr #0x4	; 0232CB84
	cmp r1,r3, lsr #0xc	; 0232CB88
	suble r2,r2,#0x10	; 0232CB8C
	movle r3,r3, lsr #0x10	; 0232CB90
	cmp r1,r3, lsr #0x4	; 0232CB94
	suble r2,r2,#0x8	; 0232CB98
	movle r3,r3, lsr #0x8	; 0232CB9C
	cmp r1,r3	; 0232CBA0
	suble r2,r2,#0x4	; 0232CBA4
	movle r3,r3, lsr #0x4	; 0232CBA8
	mov r0,r0, lsl r2	; 0232CBAC
	rsb r1,r1,#0x0	; 0232CBB0
	adds r0,r0,r0	; 0232CBB4
	add r2,r2,r2, lsl #0x1	; 0232CBB8
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CBBCPC:
	add pc,pc,r2, lsl #0x2	; 0232CBBC
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CBC4
loc_0232CBC4:
P1_DivisionDispatch_0232CBBCSteps:
	adcs r3,r1,r3, lsl #0x1	; 0232CBC4
	subcc r3,r3,r1	; 0232CBC8
	adcs r0,r0,r0	; 0232CBCC
	adcs r3,r1,r3, lsl #0x1	; 0232CBD0
	subcc r3,r3,r1	; 0232CBD4
	adcs r0,r0,r0	; 0232CBD8
	adcs r3,r1,r3, lsl #0x1	; 0232CBDC
	subcc r3,r3,r1	; 0232CBE0
	adcs r0,r0,r0	; 0232CBE4
	adcs r3,r1,r3, lsl #0x1	; 0232CBE8
	subcc r3,r3,r1	; 0232CBEC
	adcs r0,r0,r0	; 0232CBF0
loc_0232CBF4:
	adcs r3,r1,r3, lsl #0x1	; 0232CBF4
	subcc r3,r3,r1	; 0232CBF8
	adcs r0,r0,r0	; 0232CBFC
	adcs r3,r1,r3, lsl #0x1	; 0232CC00
	subcc r3,r3,r1	; 0232CC04
	adcs r0,r0,r0	; 0232CC08
	adcs r3,r1,r3, lsl #0x1	; 0232CC0C
	subcc r3,r3,r1	; 0232CC10
	adcs r0,r0,r0	; 0232CC14
	adcs r3,r1,r3, lsl #0x1	; 0232CC18
	subcc r3,r3,r1	; 0232CC1C
	adcs r0,r0,r0	; 0232CC20
loc_0232CC24:
	adcs r3,r1,r3, lsl #0x1	; 0232CC24
	subcc r3,r3,r1	; 0232CC28
	adcs r0,r0,r0	; 0232CC2C
	adcs r3,r1,r3, lsl #0x1	; 0232CC30
	subcc r3,r3,r1	; 0232CC34
	adcs r0,r0,r0	; 0232CC38
	adcs r3,r1,r3, lsl #0x1	; 0232CC3C
	subcc r3,r3,r1	; 0232CC40
	adcs r0,r0,r0	; 0232CC44
	adcs r3,r1,r3, lsl #0x1	; 0232CC48
	subcc r3,r3,r1	; 0232CC4C
	adcs r0,r0,r0	; 0232CC50
	adcs r3,r1,r3, lsl #0x1	; 0232CC54
	subcc r3,r3,r1	; 0232CC58
	adcs r0,r0,r0	; 0232CC5C
	adcs r3,r1,r3, lsl #0x1	; 0232CC60
	subcc r3,r3,r1	; 0232CC64
	adcs r0,r0,r0	; 0232CC68
	adcs r3,r1,r3, lsl #0x1	; 0232CC6C
	subcc r3,r3,r1	; 0232CC70
	adcs r0,r0,r0	; 0232CC74
	adcs r3,r1,r3, lsl #0x1	; 0232CC78
	subcc r3,r3,r1	; 0232CC7C
	adcs r0,r0,r0	; 0232CC80
loc_0232CC84:
	adcs r3,r1,r3, lsl #0x1	; 0232CC84
	subcc r3,r3,r1	; 0232CC88
	adcs r0,r0,r0	; 0232CC8C
	adcs r3,r1,r3, lsl #0x1	; 0232CC90
	subcc r3,r3,r1	; 0232CC94
	adcs r0,r0,r0	; 0232CC98
	adcs r3,r1,r3, lsl #0x1	; 0232CC9C
	subcc r3,r3,r1	; 0232CCA0
	adcs r0,r0,r0	; 0232CCA4
	adcs r3,r1,r3, lsl #0x1	; 0232CCA8
	subcc r3,r3,r1	; 0232CCAC
	adcs r0,r0,r0	; 0232CCB0
	adcs r3,r1,r3, lsl #0x1	; 0232CCB4
	subcc r3,r3,r1	; 0232CCB8
	adcs r0,r0,r0	; 0232CCBC
	adcs r3,r1,r3, lsl #0x1	; 0232CCC0
	subcc r3,r3,r1	; 0232CCC4
	adcs r0,r0,r0	; 0232CCC8
	adcs r3,r1,r3, lsl #0x1	; 0232CCCC
	subcc r3,r3,r1	; 0232CCD0
	adcs r0,r0,r0	; 0232CCD4
	adcs r3,r1,r3, lsl #0x1	; 0232CCD8
	subcc r3,r3,r1	; 0232CCDC
	adcs r0,r0,r0	; 0232CCE0
	adcs r3,r1,r3, lsl #0x1	; 0232CCE4
	subcc r3,r3,r1	; 0232CCE8
	adcs r0,r0,r0	; 0232CCEC
	adcs r3,r1,r3, lsl #0x1	; 0232CCF0
	subcc r3,r3,r1	; 0232CCF4
	adcs r0,r0,r0	; 0232CCF8
	adcs r3,r1,r3, lsl #0x1	; 0232CCFC
	subcc r3,r3,r1	; 0232CD00
	adcs r0,r0,r0	; 0232CD04
	adcs r3,r1,r3, lsl #0x1	; 0232CD08
	subcc r3,r3,r1	; 0232CD0C
	adcs r0,r0,r0	; 0232CD10
	adcs r3,r1,r3, lsl #0x1	; 0232CD14
	subcc r3,r3,r1	; 0232CD18
	adcs r0,r0,r0	; 0232CD1C
	adcs r3,r1,r3, lsl #0x1	; 0232CD20
	subcc r3,r3,r1	; 0232CD24
	adcs r0,r0,r0	; 0232CD28
	adcs r3,r1,r3, lsl #0x1	; 0232CD2C
	subcc r3,r3,r1	; 0232CD30
	adcs r0,r0,r0	; 0232CD34
	adcs r3,r1,r3, lsl #0x1	; 0232CD38
	subcc r3,r3,r1	; 0232CD3C
	adcs r0,r0,r0	; 0232CD40
P1_DivisionDispatch_0232CBBCEnd:
.if (P1_DivisionDispatch_0232CBBCSteps != P1_DivisionDispatch_0232CBBCPC + 8) || (P1_DivisionDispatch_0232CBBCEnd - P1_DivisionDispatch_0232CBBCSteps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232CD44
	bx lr	; 0232CD48

; ===== function loc_0232CD4C =====
loc_0232CD4C:
	stmdb sp!,{lr}	; 0232CD4C
	blx loc_0232CE2C	; 0232CD50
	mov r1,#0x0	; 0232CD54
	str r1,[r0,#0x0]	; 0232CD58
	blx loc_0232CE34	; 0232CD5C
	mov r1,#0x0	; 0232CD60
	str r1,[r0,#0x4]	; 0232CD64
	str r1,[r0,#0x8]	; 0232CD68
	str r1,[r0,#0xc]	; 0232CD6C
	str r1,[r0,#0x10]	; 0232CD70
	str r1,[r0,#0x14]	; 0232CD74
	ldmia sp!,{lr}	; 0232CD78
	bx lr	; 0232CD7C
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x28, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232CD90
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232CDA0
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 0232CDB0
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 0232CDC0
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x18, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232CDD0
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232CDE0
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 0232CDF0
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 0232CDF4
.thumb

; ===== function loc_0232CDF4 =====
loc_0232CDF4:
	add r3,r0,#0x0	; 0232CDF4
	cmp r0,#0x0	; 0232CDF6
	beq loc_0232CE0A	; 0232CDF8
	cmp r1,#0x0	; 0232CDFA
	beq loc_0232CE0A	; 0232CDFC
	mov r2,#0x0	; 0232CDFE
loc_0232CE00:
	strb r2,[r3,#0x0]	; 0232CE00
	add r3,r3,#0x1	; 0232CE02
	sub r1,r1,#0x1	; 0232CE04
	cmp r1,#0x0	; 0232CE06
	bne loc_0232CE00	; 0232CE08
loc_0232CE0A:
	bx lr	; 0232CE0A

; ===== function loc_0232CE0C =====
loc_0232CE0C:
	push {r4,lr}	; 0232CE0C
	ldr r4,[pool_0232CE28]	; 0232CE0E
	b loc_0232CE16	; 0232CE10
loc_0232CE12:
	blx r0	; 0232CE12
	add r4,r4,#0x4	; 0232CE14
loc_0232CE16:
	cmp r4,#0x0	; 0232CE16
	beq loc_0232CE20	; 0232CE18
	ldr r0,[r4,#0x0]	; 0232CE1A
	cmp r0,#0x0	; 0232CE1C
	bne loc_0232CE12	; 0232CE1E
loc_0232CE20:
	pop {r4}	; 0232CE20
	pop {r3}	; 0232CE22
	bx r3	; 0232CE24
	.byte 0xC0, 0x46	; 0232CE28
pool_0232CE28:
loc_0232CE28:
	.word 0x023309A4	; 0232CE28

; ===== function loc_0232CE2C =====
loc_0232CE2C:
	ldr r0,[pool_0232CE30]	; 0232CE2C
	bx lr	; 0232CE2E
pool_0232CE30:
loc_0232CE30:
	.word 0x02357508	; 0232CE30

; ===== function loc_0232CE34 =====
loc_0232CE34:
	ldr r0,[pool_0232CE38]	; 0232CE34
	bx lr	; 0232CE36
pool_0232CE38:
loc_0232CE38:
	.word 0x0235750C	; 0232CE38

; ===== function loc_0232CE3C =====
loc_0232CE3C:
	stmia r0!,{r1}	; 0232CE3C
	mov r1,#0x0	; 0232CE3E
	str r2,[r0,#0x8]	; 0232CE40
	mov r2,#0x0	; 0232CE42
	stmia r0!,{r1,r2}	; 0232CE44
	bx lr	; 0232CE46

; ===== function loc_0232CE48 =====
loc_0232CE48:
	str r2,[r0,#0x0]	; 0232CE48
	str r1,[r0,#0x4]	; 0232CE4A
	neg r1,r1	; 0232CE4C
	str r1,[r0,#0x8]	; 0232CE4E
	str r2,[r0,#0xc]	; 0232CE50
	bx lr	; 0232CE52

; ===== function loc_0232CE54 =====
loc_0232CE54:
	push {r4,r5,r6,r7,lr}	; 0232CE54
	sub sp,#0x54	; 0232CE56
	add r6,r0,#0x0	; 0232CE58
	add r5,r1,#0x0	; 0232CE5A
	add r7,r2,#0x0	; 0232CE5C
	cmp r7,r5	; 0232CE5E
	bne loc_0232CE66	; 0232CE60
	add r4,sp,#0x40	; 0232CE62
	b loc_0232CE68	; 0232CE64
loc_0232CE66:
	add r4,r7,#0x0	; 0232CE66
loc_0232CE68:
	ldr r0,[r6,#0x0]	; 0232CE68
	str r0,[sp,#0x10]	; 0232CE6A
	ldr r0,[r6,#0x4]	; 0232CE6C
	str r0,[sp,#0x14]	; 0232CE6E
	asr r0,r0,#0x1f	; 0232CE70
	str r0,[sp,#0x18]	; 0232CE72
	ldr r0,[sp,#0x10]	; 0232CE74
	asr r0,r0,#0x1f	; 0232CE76
	str r0,[sp,#0x1c]	; 0232CE78
	ldr r0,[sp,#0x10]	; 0232CE7A
	ldr r1,[sp,#0x1c]	; 0232CE7C
	ldr r2,[r5,#0x0]	; 0232CE7E
	asr r3,r2,#0x1f	; 0232CE80
	blx P1_AeabiLmul	; 0232CE82
	str r0,[sp,#0x20]	; 0232CE86
	str r1,[sp,#0xc]	; 0232CE88
	ldr r0,[sp,#0x14]	; 0232CE8A
	ldr r1,[sp,#0x18]	; 0232CE8C
	ldr r2,[r5,#0x8]	; 0232CE8E
	asr r3,r2,#0x1f	; 0232CE90
	blx P1_AeabiLmul	; 0232CE92
	ldr r2,[sp,#0x20]	; 0232CE96
	add r0,r2,r0	; 0232CE98
	ldr r2,[sp,#0xc]	; 0232CE9A
	adc r2,r1	; 0232CE9C
	str r2,[sp,#0xc]	; 0232CE9E
	lsl r1,r2,#0x14	; 0232CEA0
	lsr r0,r0,#0xc	; 0232CEA2
	orr r0,r1	; 0232CEA4
	str r0,[r4,#0x0]	; 0232CEA6
	ldr r0,[sp,#0x10]	; 0232CEA8
	ldr r1,[sp,#0x1c]	; 0232CEAA
	ldr r2,[r5,#0x4]	; 0232CEAC
	asr r3,r2,#0x1f	; 0232CEAE
	blx P1_AeabiLmul	; 0232CEB0
	str r0,[sp,#0x24]	; 0232CEB4
	str r1,[sp,#0x4]	; 0232CEB6
	ldr r0,[sp,#0x14]	; 0232CEB8
	ldr r1,[sp,#0x18]	; 0232CEBA
	ldr r2,[r5,#0xc]	; 0232CEBC
	asr r3,r2,#0x1f	; 0232CEBE
	blx P1_AeabiLmul	; 0232CEC0
	ldr r2,[sp,#0x24]	; 0232CEC4
	add r0,r2,r0	; 0232CEC6
	ldr r2,[sp,#0x4]	; 0232CEC8
	adc r2,r1	; 0232CECA
	str r2,[sp,#0x4]	; 0232CECC
	lsl r1,r2,#0x14	; 0232CECE
	lsr r0,r0,#0xc	; 0232CED0
	orr r0,r1	; 0232CED2
	str r0,[r4,#0x4]	; 0232CED4
	ldr r0,[r6,#0xc]	; 0232CED6
	str r0,[sp,#0x28]	; 0232CED8
	asr r0,r0,#0x1f	; 0232CEDA
	str r0,[sp,#0x2c]	; 0232CEDC
	ldr r0,[r6,#0x8]	; 0232CEDE
	str r0,[sp,#0x30]	; 0232CEE0
	asr r0,r0,#0x1f	; 0232CEE2
	str r0,[sp,#0x34]	; 0232CEE4
	ldr r0,[sp,#0x30]	; 0232CEE6
	ldr r1,[sp,#0x34]	; 0232CEE8
	ldr r2,[r5,#0x0]	; 0232CEEA
	asr r3,r2,#0x1f	; 0232CEEC
	blx P1_AeabiLmul	; 0232CEEE
	str r0,[sp,#0x38]	; 0232CEF2
	add r6,r1,#0x0	; 0232CEF4
	ldr r0,[sp,#0x28]	; 0232CEF6
	ldr r1,[sp,#0x2c]	; 0232CEF8
	ldr r2,[r5,#0x8]	; 0232CEFA
	asr r3,r2,#0x1f	; 0232CEFC
	blx P1_AeabiLmul	; 0232CEFE
	ldr r2,[sp,#0x38]	; 0232CF02
	add r2,r2,r0	; 0232CF04
	adc r6,r1	; 0232CF06
	lsl r0,r6,#0x14	; 0232CF08
	lsr r1,r2,#0xc	; 0232CF0A
	orr r1,r0	; 0232CF0C
	str r1,[r4,#0x8]	; 0232CF0E
	ldr r0,[sp,#0x30]	; 0232CF10
	ldr r1,[sp,#0x34]	; 0232CF12
	ldr r2,[r5,#0x4]	; 0232CF14
	asr r3,r2,#0x1f	; 0232CF16
	blx P1_AeabiLmul	; 0232CF18
	str r0,[sp,#0x3c]	; 0232CF1C
	add r6,r1,#0x0	; 0232CF1E
	ldr r0,[sp,#0x28]	; 0232CF20
	ldr r1,[sp,#0x2c]	; 0232CF22
	ldr r2,[r5,#0xc]	; 0232CF24
	asr r3,r2,#0x1f	; 0232CF26
	blx P1_AeabiLmul	; 0232CF28
	ldr r2,[sp,#0x3c]	; 0232CF2C
	add r2,r2,r0	; 0232CF2E
	adc r6,r1	; 0232CF30
	lsl r0,r6,#0x14	; 0232CF32
	lsr r1,r2,#0xc	; 0232CF34
	orr r1,r0	; 0232CF36
	str r1,[r4,#0xc]	; 0232CF38
	add r2,sp,#0x40	; 0232CF3A
	cmp r4,r2	; 0232CF3C
	bne loc_0232CF48	; 0232CF3E
	ldmia r2!,{r0,r1}	; 0232CF40
	stmia r7!,{r0,r1}	; 0232CF42
	ldmia r2!,{r0,r1}	; 0232CF44
	stmia r7!,{r0,r1}	; 0232CF46
loc_0232CF48:
	add sp,#0x54	; 0232CF48
	pop {r4,r5,r6,r7}	; 0232CF4A
	pop {r3}	; 0232CF4C
	bx r3	; 0232CF4E

; ===== function loc_0232CF50 =====
loc_0232CF50:
	push {r4}	; 0232CF50
	sub sp,#0x4	; 0232CF52
	mov r4,#0x0	; 0232CF54
	ldr r3,[pool_0232CF78]	; 0232CF56
	strh r4,[r3,#0x0]	; 0232CF58
	ldr r2,[pool_0232CF7C]	; 0232CF5A
	str r0,[r2,#0x0]	; 0232CF5C
	ldr r0,[pool_0232CF80]	; 0232CF5E
	str r1,[r0,#0x0]	; 0232CF60
	str r4,[r0,#0x4]	; 0232CF62
	ldr r0,[pool_0232CF84]	; 0232CF64
loc_0232CF66:
	ldrh r1,[r3,#0x0]	; 0232CF66
	and r1,r0	; 0232CF68
	cmp r1,#0x0	; 0232CF6A
	bne loc_0232CF66	; 0232CF6C
	ldr r0,[pool_0232CF88]	; 0232CF6E
	ldr r0,[r0,#0x0]	; 0232CF70
	add sp,#0x4	; 0232CF72
	pop {r4}	; 0232CF74
	bx lr	; 0232CF76
pool_0232CF78:
loc_0232CF78:
	.word REG_DIVCNT	; 0232CF78
pool_0232CF7C:
loc_0232CF7C:
	.word REG_DIV_NUMER	; 0232CF7C
pool_0232CF80:
loc_0232CF80:
	.word REG_DIV_DENOM	; 0232CF80
pool_0232CF84:
loc_0232CF84:
	.word 0x00008000	; 0232CF84
pool_0232CF88:
loc_0232CF88:
	.word REG_DIV_RESULT	; 0232CF88

; ===== function loc_0232CF8C =====
loc_0232CF8C:
	mov r2,#0x1	; 0232CF8C
	ldr r1,[pool_0232CFA4]	; 0232CF8E
	strh r2,[r1,#0x0]	; 0232CF90
	mov r3,#0x0	; 0232CF92
	ldr r2,[pool_0232CFA8]	; 0232CF94
	ldr r1,[pool_0232CFAC]	; 0232CF96
	str r3,[r1,#0x0]	; 0232CF98
	str r2,[r1,#0x4]	; 0232CF9A
	ldr r1,[pool_0232CFB0]	; 0232CF9C
	str r0,[r1,#0x0]	; 0232CF9E
	str r3,[r1,#0x4]	; 0232CFA0
	bx lr	; 0232CFA2
pool_0232CFA4:
loc_0232CFA4:
	.word REG_DIVCNT	; 0232CFA4
pool_0232CFA8:
loc_0232CFA8:
	.word 0x00001000	; 0232CFA8
pool_0232CFAC:
loc_0232CFAC:
	.word REG_DIV_NUMER	; 0232CFAC
pool_0232CFB0:
loc_0232CFB0:
	.word REG_DIV_DENOM	; 0232CFB0

; ===== function loc_0232CFB4 =====
loc_0232CFB4:
	ldr r1,[pool_0232CFD8]	; 0232CFB4
	ldr r0,[pool_0232CFDC]	; 0232CFB6
loc_0232CFB8:
	ldrh r2,[r1,#0x0]	; 0232CFB8
	and r2,r0	; 0232CFBA
	cmp r2,#0x0	; 0232CFBC
	bne loc_0232CFB8	; 0232CFBE
	ldr r0,[pool_0232CFE0]	; 0232CFC0
	ldr r2,[r0,#0x0]	; 0232CFC2
	ldr r3,[r0,#0x4]	; 0232CFC4
	mov r1,#0x0	; 0232CFC6
	ldr r0,[pool_0232CFE4]	; 0232CFC8
	add r0,r2,r0	; 0232CFCA
	adc r3,r1	; 0232CFCC
	lsl r1,r3,#0xc	; 0232CFCE
	lsr r0,r0,#0x14	; 0232CFD0
	orr r0,r1	; 0232CFD2
	bx lr	; 0232CFD4
	.byte 0xC0, 0x46	; 0232CFD8
pool_0232CFD8:
loc_0232CFD8:
	.word REG_DIVCNT	; 0232CFD8
pool_0232CFDC:
loc_0232CFDC:
	.word 0x00008000	; 0232CFDC
pool_0232CFE0:
loc_0232CFE0:
	.word REG_DIV_RESULT	; 0232CFE0
pool_0232CFE4:
loc_0232CFE4:
	.word 0x00080000	; 0232CFE4

; ===== function loc_0232CFE8 =====
loc_0232CFE8:
	push {lr}	; 0232CFE8
	sub sp,#0x4	; 0232CFEA
	bl loc_0232CF8C	; 0232CFEC
	bl loc_0232CFB4	; 0232CFF0
	add sp,#0x4	; 0232CFF4
	pop {r3}	; 0232CFF6
	bx r3	; 0232CFF8
	.byte 0x00, 0x00	; 0232CFFC
.arm

; ===== function loc_0232CFFC =====
loc_0232CFFC:
	smull r2,r1,r0,r1	; 0232CFFC
	mov r0,#0x800	; 0232D000
	adds r0,r2,r0	; 0232D004
	adc r1,r1,#0x0	; 0232D008
	mov r0,r0, lsr #0xc	; 0232D00C
	orr r0,r0,r1, lsl #0x14	; 0232D010
	bx lr	; 0232D014
.thumb

; ===== function loc_0232D018 =====
loc_0232D018:
	cmp r1,#0x0	; 0232D018
	bne loc_0232D022	; 0232D01A
	mov r1,#0x0	; 0232D01C
	strh r1,[r0,#0x0]	; 0232D01E
	bx lr	; 0232D020
loc_0232D022:
	cmp r1,#0x0	; 0232D022
	ble loc_0232D02E	; 0232D024
	ldr r2,[pool_0232D038]	; 0232D026
	orr r1,r2	; 0232D028
	strh r1,[r0,#0x0]	; 0232D02A
	bx lr	; 0232D02C
loc_0232D02E:
	neg r2,r1	; 0232D02E
	ldr r1,[pool_0232D03C]	; 0232D030
	orr r2,r1	; 0232D032
	strh r2,[r0,#0x0]	; 0232D034
	bx lr	; 0232D036
pool_0232D038:
loc_0232D038:
	.word 0x00004000	; 0232D038
pool_0232D03C:
loc_0232D03C:
	.word 0x00008000	; 0232D03C

; ===== function loc_0232D040 =====
loc_0232D040:
	ldr r2,[pool_0232D050]	; 0232D040
	ldr r3,[r2,#0x0]	; 0232D042
	mov r1,#0x7	; 0232D044
	bic r3,r1	; 0232D046
	orr r3,r0	; 0232D048
	str r3,[r2,#0x0]	; 0232D04A
	bx lr	; 0232D04C
	.byte 0xC0, 0x46	; 0232D050
pool_0232D050:
loc_0232D050:
	.word REG_DISPCNT_B	; 0232D050

; ===== function loc_0232D054 =====
loc_0232D054:
	push {r4}	; 0232D054
	sub sp,#0x4	; 0232D056
	ldr r3,[pool_0232D090]	; 0232D058
	ldr r3,[r3,#0x0]	; 0232D05A
	ldr r4,[pool_0232D094]	; 0232D05C
	strh r0,[r4,#0x0]	; 0232D05E
	ldr r4,[pool_0232D098]	; 0232D060
	ldrh r4,[r4,#0x0]	; 0232D062
	cmp r4,#0x0	; 0232D064
	bne loc_0232D06A	; 0232D066
	mov r0,#0x0	; 0232D068
loc_0232D06A:
	lsl r4,r2,#0x3	; 0232D06A
	ldr r2,[pool_0232D09C]	; 0232D06C
	and r3,r2	; 0232D06E
	lsl r0,r0,#0x10	; 0232D070
	orr r3,r0	; 0232D072
	orr r1,r3	; 0232D074
	orr r4,r1	; 0232D076
	ldr r0,[pool_0232D090]	; 0232D078
	str r4,[r0,#0x0]	; 0232D07A
	ldr r0,[pool_0232D094]	; 0232D07C
	ldrh r0,[r0,#0x0]	; 0232D07E
	cmp r0,#0x0	; 0232D080
	bne loc_0232D08A	; 0232D082
	mov r1,#0x0	; 0232D084
	ldr r0,[pool_0232D098]	; 0232D086
	strh r1,[r0,#0x0]	; 0232D088
loc_0232D08A:
	add sp,#0x4	; 0232D08A
	pop {r4}	; 0232D08C
	bx lr	; 0232D08E
pool_0232D090:
loc_0232D090:
	.word REG_DISPCNT_A	; 0232D090
pool_0232D094:
loc_0232D094:
	.word P1_BssStart + 0x266A4	; 0232D094
pool_0232D098:
loc_0232D098:
	.word P1_Data_02330E68	; 0232D098
pool_0232D09C:
loc_0232D09C:
	.word 0xFFF0FFF0	; 0232D09C

; ===== function loc_0232D0A0 =====
loc_0232D0A0:
	mov r1,#0x1	; 0232D0A0
	ldr r0,[pool_0232D0CC]	; 0232D0A2
	strh r1,[r0,#0x0]	; 0232D0A4
	ldr r0,[pool_0232D0D0]	; 0232D0A6
	ldrh r3,[r0,#0x0]	; 0232D0A8
	cmp r3,#0x0	; 0232D0AA
	beq loc_0232D0BE	; 0232D0AC
	ldr r1,[pool_0232D0D4]	; 0232D0AE
	ldr r2,[r1,#0x0]	; 0232D0B0
	ldr r0,[pool_0232D0D8]	; 0232D0B2
	and r2,r0	; 0232D0B4
	lsl r0,r3,#0x10	; 0232D0B6
	orr r2,r0	; 0232D0B8
	str r2,[r1,#0x0]	; 0232D0BA
	bx lr	; 0232D0BC
loc_0232D0BE:
	ldr r1,[pool_0232D0D4]	; 0232D0BE
	ldr r2,[r1,#0x0]	; 0232D0C0
	ldr r0,[pool_0232D0DC]	; 0232D0C2
	orr r2,r0	; 0232D0C4
	str r2,[r1,#0x0]	; 0232D0C6
	bx lr	; 0232D0C8
	.byte 0xC0, 0x46	; 0232D0CC
pool_0232D0CC:
loc_0232D0CC:
	.word P1_Data_02330E68	; 0232D0CC
pool_0232D0D0:
loc_0232D0D0:
	.word P1_BssStart + 0x266A4	; 0232D0D0
pool_0232D0D4:
loc_0232D0D4:
	.word REG_DISPCNT_A	; 0232D0D4
pool_0232D0D8:
loc_0232D0D8:
	.word 0xFFFCFFFF	; 0232D0D8
pool_0232D0DC:
loc_0232D0DC:
	.word 0x00010000	; 0232D0DC

; ===== function loc_0232D0E0 =====
loc_0232D0E0:
	ldr r1,[pool_0232D100]	; 0232D0E0
	ldr r0,[r1,#0x0]	; 0232D0E2
	mov r3,#0x0	; 0232D0E4
	ldr r2,[pool_0232D104]	; 0232D0E6
	strh r3,[r2,#0x0]	; 0232D0E8
	ldr r2,[pool_0232D108]	; 0232D0EA
	add r3,r0,#0x0	; 0232D0EC
	and r3,r2	; 0232D0EE
	lsr r3,r3,#0x10	; 0232D0F0
	ldr r2,[pool_0232D10C]	; 0232D0F2
	strh r3,[r2,#0x0]	; 0232D0F4
	ldr r2,[pool_0232D110]	; 0232D0F6
	and r0,r2	; 0232D0F8
	str r0,[r1,#0x0]	; 0232D0FA
	bx lr	; 0232D0FC
	.byte 0xC0, 0x46	; 0232D100
pool_0232D100:
loc_0232D100:
	.word REG_DISPCNT_A	; 0232D100
pool_0232D104:
loc_0232D104:
	.word P1_Data_02330E68	; 0232D104
pool_0232D108:
loc_0232D108:
	.word 0x00030000	; 0232D108
pool_0232D10C:
loc_0232D10C:
	.word P1_BssStart + 0x266A4	; 0232D10C
pool_0232D110:
loc_0232D110:
	.word 0xFFFCFFFF	; 0232D110

; ===== function loc_0232D114 =====
loc_0232D114:
	ldr r2,[pool_0232D134]	; 0232D114
	ldrh r3,[r2,#0x0]	; 0232D116
	mov r1,#0x8	; 0232D118
	and r3,r1	; 0232D11A
	cmp r0,#0x0	; 0232D11C
	beq loc_0232D128	; 0232D11E
	ldrh r0,[r2,#0x0]	; 0232D120
	orr r0,r1	; 0232D122
	strh r0,[r2,#0x0]	; 0232D124
	b loc_0232D12E	; 0232D126
loc_0232D128:
	ldrh r0,[r2,#0x0]	; 0232D128
	bic r0,r1	; 0232D12A
	strh r0,[r2,#0x0]	; 0232D12C
loc_0232D12E:
	add r0,r3,#0x0	; 0232D12E
	bx lr	; 0232D130
	.byte 0xC0, 0x46	; 0232D134
pool_0232D134:
loc_0232D134:
	.word REG_DISPSTAT	; 0232D134

; ===== function loc_0232D138 =====
loc_0232D138:
	push {lr}	; 0232D138
	sub sp,#0xc	; 0232D13A
	ldr r0,[pool_0232D1D4]	; 0232D13C
	ldrh r2,[r0,#0x0]	; 0232D13E
	ldr r1,[pool_0232D1D8]	; 0232D140
	orr r2,r1	; 0232D142
	strh r2,[r0,#0x0]	; 0232D144
	ldrh r2,[r0,#0x0]	; 0232D146
	ldr r1,[pool_0232D1DC]	; 0232D148
	and r2,r1	; 0232D14A
	ldr r1,[pool_0232D1E0]	; 0232D14C
	orr r2,r1	; 0232D14E
	strh r2,[r0,#0x0]	; 0232D150
	ldrh r2,[r0,#0x0]	; 0232D152
	mov r1,#0x1	; 0232D154
	orr r2,r1	; 0232D156
	strh r2,[r0,#0x0]	; 0232D158
	bl loc_0232D220	; 0232D15A
	mov r2,#0x0	; 0232D15E
	ldr r0,[pool_0232D1E4]	; 0232D160
	strh r2,[r0,#0x0]	; 0232D162
	ldr r0,[pool_0232D1E8]	; 0232D164
	str r2,[r0,#0x0]	; 0232D166
	ldr r0,[pool_0232D1EC]	; 0232D168
	ldr r0,[r0,#0x0]	; 0232D16A
	mvn r1,r2	; 0232D16C
	cmp r0,r1	; 0232D16E
	beq loc_0232D18E	; 0232D170
	ldr r1,[pool_0232D1F0]	; 0232D172
	mov r3,#0x60	; 0232D174
	bl loc_0232E298	; 0232D176
	mov r2,#0x0	; 0232D17A
	ldr r0,[pool_0232D1F4]	; 0232D17C
	strh r2,[r0,#0x0]	; 0232D17E
	ldr r0,[pool_0232D1EC]	; 0232D180
	ldr r0,[r0,#0x0]	; 0232D182
	ldr r1,[pool_0232D1F8]	; 0232D184
	mov r3,#0x70	; 0232D186
	bl loc_0232E298	; 0232D188
	b loc_0232D1AC	; 0232D18C
loc_0232D18E:
	str r2,[sp,#0x0]	; 0232D18E
	ldr r0,[sp,#0x0]	; 0232D190
	ldr r1,[pool_0232D1F0]	; 0232D192
	mov r2,#0x60	; 0232D194
	blx loc_0232E320	; 0232D196
	mov r1,#0x0	; 0232D19A
	ldr r0,[pool_0232D1F4]	; 0232D19C
	strh r1,[r0,#0x0]	; 0232D19E
	str r1,[sp,#0x4]	; 0232D1A0
	ldr r0,[sp,#0x4]	; 0232D1A2
	ldr r1,[pool_0232D1F8]	; 0232D1A4
	mov r2,#0x70	; 0232D1A6
	blx loc_0232E320	; 0232D1A8
loc_0232D1AC:
	ldr r0,[pool_0232D1FC]	; 0232D1AC
	ldr r1,[pool_0232D200]	; 0232D1AE
	strh r0,[r1,#0x0]	; 0232D1B0
	ldr r1,[pool_0232D204]	; 0232D1B2
	strh r0,[r1,#0x0]	; 0232D1B4
	ldr r1,[pool_0232D208]	; 0232D1B6
	strh r0,[r1,#0x0]	; 0232D1B8
	ldr r1,[pool_0232D20C]	; 0232D1BA
	strh r0,[r1,#0x0]	; 0232D1BC
	ldr r1,[pool_0232D210]	; 0232D1BE
	strh r0,[r1,#0x0]	; 0232D1C0
	ldr r1,[pool_0232D214]	; 0232D1C2
	strh r0,[r1,#0x0]	; 0232D1C4
	ldr r1,[pool_0232D218]	; 0232D1C6
	strh r0,[r1,#0x0]	; 0232D1C8
	ldr r1,[pool_0232D21C]	; 0232D1CA
	strh r0,[r1,#0x0]	; 0232D1CC
	add sp,#0xc	; 0232D1CE
	pop {r3}	; 0232D1D0
	bx r3	; 0232D1D2
pool_0232D1D4:
loc_0232D1D4:
	.word REG_POWERCNT	; 0232D1D4
pool_0232D1D8:
loc_0232D1D8:
	.word 0x00008000	; 0232D1D8
pool_0232D1DC:
loc_0232D1DC:
	.word 0xFFFFFDF1	; 0232D1DC
pool_0232D1E0:
loc_0232D1E0:
	.word 0x0000020E	; 0232D1E0
pool_0232D1E4:
loc_0232D1E4:
	.word REG_DISPSTAT	; 0232D1E4
pool_0232D1E8:
loc_0232D1E8:
	.word REG_DISPCNT_A	; 0232D1E8
pool_0232D1EC:
loc_0232D1EC:
	.word P1_Data_02330E6C	; 0232D1EC
pool_0232D1F0:
loc_0232D1F0:
	.word REG_BG0CNT	; 0232D1F0
pool_0232D1F4:
loc_0232D1F4:
	.word REG_MASTER_BRIGHT	; 0232D1F4
pool_0232D1F8:
loc_0232D1F8:
	.word REG_DISPCNT_B	; 0232D1F8
pool_0232D1FC:
loc_0232D1FC:
	.word 0x00000100	; 0232D1FC
pool_0232D200:
loc_0232D200:
	.word REG_BG2PA	; 0232D200
pool_0232D204:
loc_0232D204:
	.word REG_BG2PD	; 0232D204
pool_0232D208:
loc_0232D208:
	.word REG_BG3PA	; 0232D208
pool_0232D20C:
loc_0232D20C:
	.word REG_BG3PD	; 0232D20C
pool_0232D210:
loc_0232D210:
	.word REG_BG2PA_SUB	; 0232D210
pool_0232D214:
loc_0232D214:
	.word REG_BG2PD_SUB	; 0232D214
pool_0232D218:
loc_0232D218:
	.word REG_BG3PA_SUB	; 0232D218
pool_0232D21C:
loc_0232D21C:
	.word REG_BG3PD_SUB	; 0232D21C

; ===== function loc_0232D220 =====
loc_0232D220:
	mov r1,#0x0	; 0232D220
	ldr r0,[pool_0232D254]	; 0232D222
	strh r1,[r0,#0x0]	; 0232D224
	strh r1,[r0,#0x2]	; 0232D226
	strh r1,[r0,#0x4]	; 0232D228
	strh r1,[r0,#0x6]	; 0232D22A
	strh r1,[r0,#0x8]	; 0232D22C
	strh r1,[r0,#0xa]	; 0232D22E
	strh r1,[r0,#0xc]	; 0232D230
	strh r1,[r0,#0xe]	; 0232D232
	strh r1,[r0,#0x10]	; 0232D234
	strh r1,[r0,#0x12]	; 0232D236
	strh r1,[r0,#0x14]	; 0232D238
	strh r1,[r0,#0x16]	; 0232D23A
	strh r1,[r0,#0x18]	; 0232D23C
	ldr r0,[pool_0232D258]	; 0232D23E
	str r1,[r0,#0x0]	; 0232D240
	ldr r0,[pool_0232D25C]	; 0232D242
	strb r1,[r0,#0x0]	; 0232D244
	ldr r0,[pool_0232D260]	; 0232D246
	strb r1,[r0,#0x0]	; 0232D248
	ldr r0,[pool_0232D264]	; 0232D24A
	strb r1,[r0,#0x0]	; 0232D24C
	ldr r0,[pool_0232D268]	; 0232D24E
	strh r1,[r0,#0x0]	; 0232D250
	bx lr	; 0232D252
pool_0232D254:
loc_0232D254:
	.word P1_BssStart + 0x266A8	; 0232D254
pool_0232D258:
loc_0232D258:
	.word VRAM_A_CR	; 0232D258
pool_0232D25C:
loc_0232D25C:
	.word VRAM_E_CR	; 0232D25C
pool_0232D260:
loc_0232D260:
	.word VRAM_F_CR	; 0232D260
pool_0232D264:
loc_0232D264:
	.word VRAM_G_CR	; 0232D264
pool_0232D268:
loc_0232D268:
	.word VRAM_H_CR	; 0232D268

; ===== function loc_0232D26C =====
loc_0232D26C:
	ldr r0,[pool_0232D274]	; 0232D26C
	ldr r3,[pool_0232D278]	; 0232D26E
	bx r3	; 0232D270
	.byte 0xC0, 0x46	; 0232D274
pool_0232D274:
loc_0232D274:
	.word 0x0235753C	; 0232D274
pool_0232D278:
loc_0232D278:
	.word loc_0232D2CC + 1	; 0232D278

; ===== function loc_0232D27C =====
loc_0232D27C:
	ldr r0,[pool_0232D284]	; 0232D27C
	ldr r3,[pool_0232D288]	; 0232D27E
	bx r3	; 0232D280
	.byte 0xC0, 0x46	; 0232D284
pool_0232D284:
loc_0232D284:
	.word 0x0235753A	; 0232D284
pool_0232D288:
loc_0232D288:
	.word loc_0232D2CC + 1	; 0232D288

; ===== function loc_0232D28C =====
loc_0232D28C:
	ldr r0,[pool_0232D294]	; 0232D28C
	ldr r3,[pool_0232D298]	; 0232D28E
	bx r3	; 0232D290
	.byte 0xC0, 0x46	; 0232D294
pool_0232D294:
loc_0232D294:
	.word 0x02357528	; 0232D294
pool_0232D298:
loc_0232D298:
	.word loc_0232D2CC + 1	; 0232D298

; ===== function loc_0232D29C =====
loc_0232D29C:
	ldr r0,[pool_0232D2A4]	; 0232D29C
	ldr r3,[pool_0232D2A8]	; 0232D29E
	bx r3	; 0232D2A0
	.byte 0xC0, 0x46	; 0232D2A4
pool_0232D2A4:
loc_0232D2A4:
	.word 0x0235752E	; 0232D2A4
pool_0232D2A8:
loc_0232D2A8:
	.word loc_0232D2CC + 1	; 0232D2A8

; ===== function loc_0232D2AC =====
loc_0232D2AC:
	ldr r0,[pool_0232D2B4]	; 0232D2AC
	ldr r3,[pool_0232D2B8]	; 0232D2AE
	bx r3	; 0232D2B0
	.byte 0xC0, 0x46	; 0232D2B4
pool_0232D2B4:
loc_0232D2B4:
	.word 0x0235752C	; 0232D2B4
pool_0232D2B8:
loc_0232D2B8:
	.word loc_0232D2CC + 1	; 0232D2B8

; ===== function loc_0232D2BC =====
loc_0232D2BC:
	ldr r0,[pool_0232D2C4]	; 0232D2BC
	ldr r3,[pool_0232D2C8]	; 0232D2BE
	bx r3	; 0232D2C0
	.byte 0xC0, 0x46	; 0232D2C4
pool_0232D2C4:
loc_0232D2C4:
	.word 0x0235752A	; 0232D2C4
pool_0232D2C8:
loc_0232D2C8:
	.word loc_0232D2CC + 1	; 0232D2C8
loc_0232D2CC:
	ldrh r1,[r0,#0x0]	; 0232D2CC
	mov r3,#0x0	; 0232D2CE
	strh r3,[r0,#0x0]	; 0232D2D0
	mov r0,#0x1	; 0232D2D2
	add r2,r1,#0x0	; 0232D2D4
	and r2,r0	; 0232D2D6
	cmp r2,#0x0	; 0232D2D8
	beq loc_0232D2E0	; 0232D2DA
	ldr r0,[pool_0232D364]	; 0232D2DC
	strb r3,[r0,#0x0]	; 0232D2DE
loc_0232D2E0:
	mov r0,#0x2	; 0232D2E0
	add r2,r1,#0x0	; 0232D2E2
	and r2,r0	; 0232D2E4
	cmp r2,#0x0	; 0232D2E6
	beq loc_0232D2F0	; 0232D2E8
	mov r2,#0x0	; 0232D2EA
	ldr r0,[pool_0232D368]	; 0232D2EC
	strb r2,[r0,#0x0]	; 0232D2EE
loc_0232D2F0:
	mov r0,#0x4	; 0232D2F0
	add r2,r1,#0x0	; 0232D2F2
	and r2,r0	; 0232D2F4
	cmp r2,#0x0	; 0232D2F6
	beq loc_0232D300	; 0232D2F8
	mov r2,#0x0	; 0232D2FA
	ldr r0,[pool_0232D36C]	; 0232D2FC
	strb r2,[r0,#0x0]	; 0232D2FE
loc_0232D300:
	mov r0,#0x8	; 0232D300
	add r2,r1,#0x0	; 0232D302
	and r2,r0	; 0232D304
	cmp r2,#0x0	; 0232D306
	beq loc_0232D310	; 0232D308
	mov r2,#0x0	; 0232D30A
	ldr r0,[pool_0232D370]	; 0232D30C
	strb r2,[r0,#0x0]	; 0232D30E
loc_0232D310:
	mov r0,#0x10	; 0232D310
	add r2,r1,#0x0	; 0232D312
	and r2,r0	; 0232D314
	cmp r2,#0x0	; 0232D316
	beq loc_0232D320	; 0232D318
	mov r2,#0x0	; 0232D31A
	ldr r0,[pool_0232D374]	; 0232D31C
	strb r2,[r0,#0x0]	; 0232D31E
loc_0232D320:
	mov r0,#0x20	; 0232D320
	add r2,r1,#0x0	; 0232D322
	and r2,r0	; 0232D324
	cmp r2,#0x0	; 0232D326
	beq loc_0232D330	; 0232D328
	mov r2,#0x0	; 0232D32A
	ldr r0,[pool_0232D378]	; 0232D32C
	strb r2,[r0,#0x0]	; 0232D32E
loc_0232D330:
	mov r0,#0x40	; 0232D330
	add r2,r1,#0x0	; 0232D332
	and r2,r0	; 0232D334
	cmp r2,#0x0	; 0232D336
	beq loc_0232D340	; 0232D338
	mov r2,#0x0	; 0232D33A
	ldr r0,[pool_0232D37C]	; 0232D33C
	strb r2,[r0,#0x0]	; 0232D33E
loc_0232D340:
	mov r0,#0x80	; 0232D340
	add r2,r1,#0x0	; 0232D342
	and r2,r0	; 0232D344
	cmp r2,#0x0	; 0232D346
	beq loc_0232D350	; 0232D348
	mov r2,#0x0	; 0232D34A
	ldr r0,[pool_0232D380]	; 0232D34C
	strb r2,[r0,#0x0]	; 0232D34E
loc_0232D350:
	ldr r0,[pool_0232D384]	; 0232D350
	add r2,r1,#0x0	; 0232D352
	and r2,r0	; 0232D354
	cmp r2,#0x0	; 0232D356
	beq loc_0232D360	; 0232D358
	mov r2,#0x0	; 0232D35A
	ldr r0,[pool_0232D388]	; 0232D35C
	strb r2,[r0,#0x0]	; 0232D35E
loc_0232D360:
	add r0,r1,#0x0	; 0232D360
	bx lr	; 0232D362
pool_0232D364:
loc_0232D364:
	.word VRAM_A_CR	; 0232D364
pool_0232D368:
loc_0232D368:
	.word VRAM_B_CR	; 0232D368
pool_0232D36C:
loc_0232D36C:
	.word VRAM_C_CR	; 0232D36C
pool_0232D370:
loc_0232D370:
	.word VRAM_D_CR	; 0232D370
pool_0232D374:
loc_0232D374:
	.word VRAM_E_CR	; 0232D374
pool_0232D378:
loc_0232D378:
	.word VRAM_F_CR	; 0232D378
pool_0232D37C:
loc_0232D37C:
	.word VRAM_G_CR	; 0232D37C
pool_0232D380:
loc_0232D380:
	.word VRAM_H_CR	; 0232D380
pool_0232D384:
loc_0232D384:
	.word 0x00000100	; 0232D384
pool_0232D388:
loc_0232D388:
	.word VRAM_I_CR	; 0232D388

; ===== function loc_0232D38C =====
loc_0232D38C:
	push {r4,lr}	; 0232D38C
	mvn r4,r0	; 0232D38E
	ldr r1,[pool_0232D3CC]	; 0232D390
	ldrh r3,[r1,#0x0]	; 0232D392
	ldrh r2,[r1,#0x14]	; 0232D394
	orr r3,r2	; 0232D396
	and r4,r3	; 0232D398
	strh r4,[r1,#0x0]	; 0232D39A
	strh r0,[r1,#0x14]	; 0232D39C
	cmp r0,#0x0	; 0232D39E
	beq loc_0232D3BC	; 0232D3A0
	cmp r0,#0x8	; 0232D3A2
	beq loc_0232D3AE	; 0232D3A4
	ldr r1,[pool_0232D3D0]	; 0232D3A6
	cmp r0,r1	; 0232D3A8
	beq loc_0232D3B6	; 0232D3AA
	b loc_0232D3BC	; 0232D3AC
loc_0232D3AE:
	mov r1,#0x84	; 0232D3AE
	ldr r0,[pool_0232D3D4]	; 0232D3B0
	strb r1,[r0,#0x0]	; 0232D3B2
	b loc_0232D3BC	; 0232D3B4
loc_0232D3B6:
	mov r1,#0x82	; 0232D3B6
	ldr r0,[pool_0232D3D8]	; 0232D3B8
	strb r1,[r0,#0x0]	; 0232D3BA
loc_0232D3BC:
	ldr r0,[pool_0232D3CC]	; 0232D3BC
	ldrh r0,[r0,#0x0]	; 0232D3BE
	bl loc_0232D6AC	; 0232D3C0
	pop {r4}	; 0232D3C4
	pop {r3}	; 0232D3C6
	bx r3	; 0232D3C8
	.byte 0xC0, 0x46	; 0232D3CC
pool_0232D3CC:
loc_0232D3CC:
	.word P1_BssStart + 0x266A8	; 0232D3CC
pool_0232D3D0:
loc_0232D3D0:
	.word 0x00000100	; 0232D3D0
pool_0232D3D4:
loc_0232D3D4:
	.word VRAM_D_CR	; 0232D3D4
pool_0232D3D8:
loc_0232D3D8:
	.word VRAM_I_CR	; 0232D3D8

; ===== function loc_0232D3DC =====
loc_0232D3DC:
	push {r4,lr}	; 0232D3DC
	mvn r4,r0	; 0232D3DE
	ldr r1,[pool_0232D434]	; 0232D3E0
	ldrh r3,[r1,#0x0]	; 0232D3E2
	ldrh r2,[r1,#0x12]	; 0232D3E4
	orr r3,r2	; 0232D3E6
	and r4,r3	; 0232D3E8
	strh r4,[r1,#0x0]	; 0232D3EA
	strh r0,[r1,#0x12]	; 0232D3EC
	cmp r0,#0x80	; 0232D3EE
	bgt loc_0232D408	; 0232D3F0
	cmp r0,#0x80	; 0232D3F2
	bge loc_0232D41E	; 0232D3F4
	cmp r0,#0x4	; 0232D3F6
	bgt loc_0232D424	; 0232D3F8
	cmp r0,#0x0	; 0232D3FA
	blt loc_0232D424	; 0232D3FC
	cmp r0,#0x0	; 0232D3FE
	beq loc_0232D424	; 0232D400
	cmp r0,#0x4	; 0232D402
	beq loc_0232D410	; 0232D404
	b loc_0232D424	; 0232D406
loc_0232D408:
	ldr r1,[pool_0232D438]	; 0232D408
	cmp r0,r1	; 0232D40A
	beq loc_0232D418	; 0232D40C
	b loc_0232D424	; 0232D40E
loc_0232D410:
	mov r1,#0x84	; 0232D410
	ldr r0,[pool_0232D43C]	; 0232D412
	strb r1,[r0,#0x0]	; 0232D414
	b loc_0232D424	; 0232D416
loc_0232D418:
	mov r1,#0x81	; 0232D418
	ldr r0,[pool_0232D440]	; 0232D41A
	strb r1,[r0,#0x0]	; 0232D41C
loc_0232D41E:
	mov r1,#0x81	; 0232D41E
	ldr r0,[pool_0232D444]	; 0232D420
	strb r1,[r0,#0x0]	; 0232D422
loc_0232D424:
	ldr r0,[pool_0232D434]	; 0232D424
	ldrh r0,[r0,#0x0]	; 0232D426
	bl loc_0232D6AC	; 0232D428
	pop {r4}	; 0232D42C
	pop {r3}	; 0232D42E
	bx r3	; 0232D430
	.byte 0xC0, 0x46	; 0232D434
pool_0232D434:
loc_0232D434:
	.word P1_BssStart + 0x266A8	; 0232D434
pool_0232D438:
loc_0232D438:
	.word 0x00000180	; 0232D438
pool_0232D43C:
loc_0232D43C:
	.word VRAM_C_CR	; 0232D43C
pool_0232D440:
loc_0232D440:
	.word VRAM_I_CR	; 0232D440
pool_0232D444:
loc_0232D444:
	.word VRAM_H_CR	; 0232D444

; ===== function loc_0232D448 =====
loc_0232D448:
	ldr r1,[pool_0232D454]	; 0232D448
	ldrh r2,[r1,#0x0]	; 0232D44A
	orr r2,r0	; 0232D44C
	strh r2,[r1,#0x0]	; 0232D44E
	ldr r3,[pool_0232D458]	; 0232D450
	bx r3	; 0232D452
pool_0232D454:
loc_0232D454:
	.word P1_BssStart + 0x266A8	; 0232D454
pool_0232D458:
loc_0232D458:
	.word P1_EnableVramBanksByMask + 1	; 0232D458

; ===== function loc_0232D45C =====
loc_0232D45C:
	push {r4,lr}	; 0232D45C
	mvn r4,r0	; 0232D45E
	ldr r1,[pool_0232D518]	; 0232D460
	ldrh r3,[r1,#0x0]	; 0232D462
	ldrh r2,[r1,#0x4]	; 0232D464
	orr r3,r2	; 0232D466
	and r4,r3	; 0232D468
	strh r4,[r1,#0x0]	; 0232D46A
	strh r0,[r1,#0x4]	; 0232D46C
	cmp r0,#0x30	; 0232D46E
	bgt loc_0232D49E	; 0232D470
	cmp r0,#0x30	; 0232D472
	bge loc_0232D4D8	; 0232D474
	cmp r0,#0x10	; 0232D476
	bgt loc_0232D498	; 0232D478
	cmp r0,#0x10	; 0232D47A
	bge loc_0232D4DE	; 0232D47C
	cmp r0,#0x3	; 0232D47E
	bhi loc_0232D508	; 0232D480
	add r1,r0,r0	; 0232D482
P1_SwitchIndexPC_0232D482:
	add r1,pc	; 0232D484
	ldrh r1,[r1,#(P1_SwitchTable_0232D482 - (P1_SwitchIndexPC_0232D482 + 4))]	; 0232D486
	lsl r1,r1,#0x10	; 0232D488
	asr r1,r1,#0x10	; 0232D48A
P1_SwitchTargetPC_0232D482:
	add r1,pc	; 0232D48C
	bx r1	; 0232D48E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232D482:
	.halfword (loc_0232D508 + 1) - (P1_SwitchTargetPC_0232D482 + 4)
	.halfword (loc_0232D4C2 + 1) - (P1_SwitchTargetPC_0232D482 + 4)
	.halfword (loc_0232D4CA + 1) - (P1_SwitchTargetPC_0232D482 + 4)
	.halfword (loc_0232D4BC + 1) - (P1_SwitchTargetPC_0232D482 + 4)
P1_SwitchTable_0232D482End:
loc_0232D498:
	cmp r0,#0x20	; 0232D498
	beq loc_0232D4FA	; 0232D49A
	b loc_0232D508	; 0232D49C
loc_0232D49E:
	cmp r0,#0x50	; 0232D49E
	bgt loc_0232D4AC	; 0232D4A0
	cmp r0,#0x50	; 0232D4A2
	bge loc_0232D4E6	; 0232D4A4
	cmp r0,#0x40	; 0232D4A6
	beq loc_0232D502	; 0232D4A8
	b loc_0232D508	; 0232D4AA
loc_0232D4AC:
	cmp r0,#0x60	; 0232D4AC
	bgt loc_0232D4B6	; 0232D4AE
	cmp r0,#0x60	; 0232D4B0
	beq loc_0232D4F4	; 0232D4B2
	b loc_0232D508	; 0232D4B4
loc_0232D4B6:
	cmp r0,#0x70	; 0232D4B6
	beq loc_0232D4D2	; 0232D4B8
	b loc_0232D508	; 0232D4BA
loc_0232D4BC:
	mov r1,#0x8a	; 0232D4BC
	ldr r0,[pool_0232D51C]	; 0232D4BE
	strb r1,[r0,#0x0]	; 0232D4C0
loc_0232D4C2:
	mov r1,#0x82	; 0232D4C2
	ldr r0,[pool_0232D520]	; 0232D4C4
	strb r1,[r0,#0x0]	; 0232D4C6
	b loc_0232D508	; 0232D4C8
loc_0232D4CA:
	mov r1,#0x82	; 0232D4CA
	ldr r0,[pool_0232D51C]	; 0232D4CC
	strb r1,[r0,#0x0]	; 0232D4CE
	b loc_0232D508	; 0232D4D0
loc_0232D4D2:
	mov r1,#0x9a	; 0232D4D2
	ldr r0,[pool_0232D524]	; 0232D4D4
	strb r1,[r0,#0x0]	; 0232D4D6
loc_0232D4D8:
	mov r1,#0x92	; 0232D4D8
	ldr r0,[pool_0232D528]	; 0232D4DA
	strb r1,[r0,#0x0]	; 0232D4DC
loc_0232D4DE:
	mov r1,#0x82	; 0232D4DE
	ldr r0,[pool_0232D52C]	; 0232D4E0
	strb r1,[r0,#0x0]	; 0232D4E2
	b loc_0232D508	; 0232D4E4
loc_0232D4E6:
	mov r1,#0x92	; 0232D4E6
	ldr r0,[pool_0232D524]	; 0232D4E8
	strb r1,[r0,#0x0]	; 0232D4EA
	mov r1,#0x82	; 0232D4EC
	ldr r0,[pool_0232D52C]	; 0232D4EE
	strb r1,[r0,#0x0]	; 0232D4F0
	b loc_0232D508	; 0232D4F2
loc_0232D4F4:
	mov r1,#0x8a	; 0232D4F4
	ldr r0,[pool_0232D524]	; 0232D4F6
	strb r1,[r0,#0x0]	; 0232D4F8
loc_0232D4FA:
	mov r1,#0x82	; 0232D4FA
	ldr r0,[pool_0232D528]	; 0232D4FC
	strb r1,[r0,#0x0]	; 0232D4FE
	b loc_0232D508	; 0232D500
loc_0232D502:
	mov r1,#0x82	; 0232D502
	ldr r0,[pool_0232D524]	; 0232D504
	strb r1,[r0,#0x0]	; 0232D506
loc_0232D508:
	ldr r0,[pool_0232D518]	; 0232D508
	ldrh r0,[r0,#0x0]	; 0232D50A
	bl loc_0232D6AC	; 0232D50C
	pop {r4}	; 0232D510
	pop {r3}	; 0232D512
	bx r3	; 0232D514
	.byte 0xC0, 0x46	; 0232D518
pool_0232D518:
loc_0232D518:
	.word P1_BssStart + 0x266A8	; 0232D518
pool_0232D51C:
loc_0232D51C:
	.word VRAM_B_CR	; 0232D51C
pool_0232D520:
loc_0232D520:
	.word VRAM_A_CR	; 0232D520
pool_0232D524:
loc_0232D524:
	.word VRAM_G_CR	; 0232D524
pool_0232D528:
loc_0232D528:
	.word VRAM_F_CR	; 0232D528
pool_0232D52C:
loc_0232D52C:
	.word VRAM_E_CR	; 0232D52C

; ===== function loc_0232D530 =====
loc_0232D530:
	push {r4,lr}	; 0232D530
	mvn r4,r0	; 0232D532
	ldr r1,[pool_0232D68C]	; 0232D534
	ldrh r3,[r1,#0x0]	; 0232D536
	ldrh r2,[r1,#0x2]	; 0232D538
	orr r3,r2	; 0232D53A
	and r4,r3	; 0232D53C
	strh r4,[r1,#0x0]	; 0232D53E
	strh r0,[r1,#0x2]	; 0232D540
	cmp r0,#0x40	; 0232D542
	bgt loc_0232D5AC	; 0232D544
	cmp r0,#0x40	; 0232D546
	blt loc_0232D54C	; 0232D548
	b loc_0232D678	; 0232D54A
loc_0232D54C:
	cmp r0,#0x20	; 0232D54C
	bgt loc_0232D5A6	; 0232D54E
	cmp r0,#0x0	; 0232D550
	bge loc_0232D556	; 0232D552
	b loc_0232D67E	; 0232D554
loc_0232D556:
	add r1,r0,r0	; 0232D556
P1_SwitchIndexPC_0232D556:
	add r1,pc	; 0232D558
	ldrh r1,[r1,#(P1_SwitchTable_0232D556 - (P1_SwitchIndexPC_0232D556 + 4))]	; 0232D55A
	lsl r1,r1,#0x10	; 0232D55C
	asr r1,r1,#0x10	; 0232D55E
P1_SwitchTargetPC_0232D556:
	add r1,pc	; 0232D560
	bx r1	; 0232D562
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232D556:
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5FC + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5E2 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5F6 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5CE + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D61E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5DC + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5F0 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5C0 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D62C + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D63A + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D604 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5C8 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D618 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5D6 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D5EA + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D654 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D67E + 1) - (P1_SwitchTargetPC_0232D556 + 4)
	.halfword (loc_0232D670 + 1) - (P1_SwitchTargetPC_0232D556 + 4)
P1_SwitchTable_0232D556End:
loc_0232D5A6:
	cmp r0,#0x30	; 0232D5A6
	beq loc_0232D64E	; 0232D5A8
	b loc_0232D67E	; 0232D5AA
loc_0232D5AC:
	cmp r0,#0x60	; 0232D5AC
	bgt loc_0232D5BA	; 0232D5AE
	cmp r0,#0x60	; 0232D5B0
	bge loc_0232D66A	; 0232D5B2
	cmp r0,#0x50	; 0232D5B4
	beq loc_0232D65C	; 0232D5B6
	b loc_0232D67E	; 0232D5B8
loc_0232D5BA:
	cmp r0,#0x70	; 0232D5BA
	beq loc_0232D648	; 0232D5BC
	b loc_0232D67E	; 0232D5BE
loc_0232D5C0:
	mov r1,#0x81	; 0232D5C0
	ldr r0,[pool_0232D690]	; 0232D5C2
	strb r1,[r0,#0x0]	; 0232D5C4
	b loc_0232D67E	; 0232D5C6
loc_0232D5C8:
	mov r1,#0x89	; 0232D5C8
	ldr r0,[pool_0232D690]	; 0232D5CA
	strb r1,[r0,#0x0]	; 0232D5CC
loc_0232D5CE:
	mov r1,#0x81	; 0232D5CE
	ldr r0,[pool_0232D694]	; 0232D5D0
	strb r1,[r0,#0x0]	; 0232D5D2
	b loc_0232D67E	; 0232D5D4
loc_0232D5D6:
	mov r1,#0x91	; 0232D5D6
	ldr r0,[pool_0232D690]	; 0232D5D8
	strb r1,[r0,#0x0]	; 0232D5DA
loc_0232D5DC:
	mov r1,#0x89	; 0232D5DC
	ldr r0,[pool_0232D694]	; 0232D5DE
	strb r1,[r0,#0x0]	; 0232D5E0
loc_0232D5E2:
	mov r1,#0x81	; 0232D5E2
	ldr r0,[pool_0232D698]	; 0232D5E4
	strb r1,[r0,#0x0]	; 0232D5E6
	b loc_0232D67E	; 0232D5E8
loc_0232D5EA:
	mov r1,#0x99	; 0232D5EA
	ldr r0,[pool_0232D690]	; 0232D5EC
	strb r1,[r0,#0x0]	; 0232D5EE
loc_0232D5F0:
	mov r1,#0x91	; 0232D5F0
	ldr r0,[pool_0232D694]	; 0232D5F2
	strb r1,[r0,#0x0]	; 0232D5F4
loc_0232D5F6:
	mov r1,#0x89	; 0232D5F6
	ldr r0,[pool_0232D698]	; 0232D5F8
	strb r1,[r0,#0x0]	; 0232D5FA
loc_0232D5FC:
	mov r1,#0x81	; 0232D5FC
	ldr r0,[pool_0232D69C]	; 0232D5FE
	strb r1,[r0,#0x0]	; 0232D600
	b loc_0232D67E	; 0232D602
loc_0232D604:
	mov r1,#0x81	; 0232D604
	ldr r0,[pool_0232D69C]	; 0232D606
	strb r1,[r0,#0x0]	; 0232D608
	mov r1,#0x89	; 0232D60A
	ldr r0,[pool_0232D698]	; 0232D60C
	strb r1,[r0,#0x0]	; 0232D60E
	mov r1,#0x91	; 0232D610
	ldr r0,[pool_0232D690]	; 0232D612
	strb r1,[r0,#0x0]	; 0232D614
	b loc_0232D67E	; 0232D616
loc_0232D618:
	mov r1,#0x91	; 0232D618
	ldr r0,[pool_0232D690]	; 0232D61A
	strb r1,[r0,#0x0]	; 0232D61C
loc_0232D61E:
	mov r1,#0x81	; 0232D61E
	ldr r0,[pool_0232D69C]	; 0232D620
	strb r1,[r0,#0x0]	; 0232D622
	mov r1,#0x89	; 0232D624
	ldr r0,[pool_0232D694]	; 0232D626
	strb r1,[r0,#0x0]	; 0232D628
	b loc_0232D67E	; 0232D62A
loc_0232D62C:
	mov r1,#0x81	; 0232D62C
	ldr r0,[pool_0232D69C]	; 0232D62E
	strb r1,[r0,#0x0]	; 0232D630
	mov r1,#0x89	; 0232D632
	ldr r0,[pool_0232D690]	; 0232D634
	strb r1,[r0,#0x0]	; 0232D636
	b loc_0232D67E	; 0232D638
loc_0232D63A:
	mov r1,#0x81	; 0232D63A
	ldr r0,[pool_0232D698]	; 0232D63C
	strb r1,[r0,#0x0]	; 0232D63E
	mov r1,#0x89	; 0232D640
	ldr r0,[pool_0232D690]	; 0232D642
	strb r1,[r0,#0x0]	; 0232D644
	b loc_0232D67E	; 0232D646
loc_0232D648:
	mov r1,#0x99	; 0232D648
	ldr r0,[pool_0232D6A0]	; 0232D64A
	strb r1,[r0,#0x0]	; 0232D64C
loc_0232D64E:
	mov r1,#0x91	; 0232D64E
	ldr r0,[pool_0232D6A4]	; 0232D650
	strb r1,[r0,#0x0]	; 0232D652
loc_0232D654:
	mov r1,#0x81	; 0232D654
	ldr r0,[pool_0232D6A8]	; 0232D656
	strb r1,[r0,#0x0]	; 0232D658
	b loc_0232D67E	; 0232D65A
loc_0232D65C:
	mov r1,#0x91	; 0232D65C
	ldr r0,[pool_0232D6A0]	; 0232D65E
	strb r1,[r0,#0x0]	; 0232D660
	mov r1,#0x81	; 0232D662
	ldr r0,[pool_0232D6A8]	; 0232D664
	strb r1,[r0,#0x0]	; 0232D666
	b loc_0232D67E	; 0232D668
loc_0232D66A:
	mov r1,#0x89	; 0232D66A
	ldr r0,[pool_0232D6A0]	; 0232D66C
	strb r1,[r0,#0x0]	; 0232D66E
loc_0232D670:
	mov r1,#0x81	; 0232D670
	ldr r0,[pool_0232D6A4]	; 0232D672
	strb r1,[r0,#0x0]	; 0232D674
	b loc_0232D67E	; 0232D676
loc_0232D678:
	mov r1,#0x81	; 0232D678
	ldr r0,[pool_0232D6A0]	; 0232D67A
	strb r1,[r0,#0x0]	; 0232D67C
loc_0232D67E:
	ldr r0,[pool_0232D68C]	; 0232D67E
	ldrh r0,[r0,#0x0]	; 0232D680
	bl loc_0232D6AC	; 0232D682
	pop {r4}	; 0232D686
	pop {r3}	; 0232D688
	bx r3	; 0232D68A
pool_0232D68C:
loc_0232D68C:
	.word P1_BssStart + 0x266A8	; 0232D68C
pool_0232D690:
loc_0232D690:
	.word VRAM_D_CR	; 0232D690
pool_0232D694:
loc_0232D694:
	.word VRAM_C_CR	; 0232D694
pool_0232D698:
loc_0232D698:
	.word VRAM_B_CR	; 0232D698
pool_0232D69C:
loc_0232D69C:
	.word VRAM_A_CR	; 0232D69C
pool_0232D6A0:
loc_0232D6A0:
	.word VRAM_G_CR	; 0232D6A0
pool_0232D6A4:
loc_0232D6A4:
	.word VRAM_F_CR	; 0232D6A4
pool_0232D6A8:
loc_0232D6A8:
	.word VRAM_E_CR	; 0232D6A8

; ===== function loc_0232D6AC =====
; Enables VRAM A--I banks selected by r0 bit mask. / 按 r0 位掩码启用 VRAM A--I bank。
.func P1_EnableVramBanksByMask
loc_0232D6AC:
	mov r1,#0x1	; 0232D6AC
	add r2,r0,#0x0	; 0232D6AE
	and r2,r1	; 0232D6B0
	cmp r2,#0x0	; 0232D6B2
	beq loc_0232D6BC	; 0232D6B4
	mov r2,#0x80	; 0232D6B6
	ldr r1,[pool_0232D73C]	; 0232D6B8
	strb r2,[r1,#0x0]	; 0232D6BA
loc_0232D6BC:
	mov r1,#0x2	; 0232D6BC
	add r2,r0,#0x0	; 0232D6BE
	and r2,r1	; 0232D6C0
	cmp r2,#0x0	; 0232D6C2
	beq loc_0232D6CC	; 0232D6C4
	mov r2,#0x80	; 0232D6C6
	ldr r1,[pool_0232D740]	; 0232D6C8
	strb r2,[r1,#0x0]	; 0232D6CA
loc_0232D6CC:
	mov r1,#0x4	; 0232D6CC
	add r2,r0,#0x0	; 0232D6CE
	and r2,r1	; 0232D6D0
	cmp r2,#0x0	; 0232D6D2
	beq loc_0232D6DC	; 0232D6D4
	mov r2,#0x80	; 0232D6D6
	ldr r1,[pool_0232D744]	; 0232D6D8
	strb r2,[r1,#0x0]	; 0232D6DA
loc_0232D6DC:
	mov r1,#0x8	; 0232D6DC
	add r2,r0,#0x0	; 0232D6DE
	and r2,r1	; 0232D6E0
	cmp r2,#0x0	; 0232D6E2
	beq loc_0232D6EC	; 0232D6E4
	mov r2,#0x80	; 0232D6E6
	ldr r1,[pool_0232D748]	; 0232D6E8
	strb r2,[r1,#0x0]	; 0232D6EA
loc_0232D6EC:
	mov r1,#0x10	; 0232D6EC
	add r2,r0,#0x0	; 0232D6EE
	and r2,r1	; 0232D6F0
	cmp r2,#0x0	; 0232D6F2
	beq loc_0232D6FC	; 0232D6F4
	mov r2,#0x80	; 0232D6F6
	ldr r1,[pool_0232D74C]	; 0232D6F8
	strb r2,[r1,#0x0]	; 0232D6FA
loc_0232D6FC:
	mov r1,#0x20	; 0232D6FC
	add r2,r0,#0x0	; 0232D6FE
	and r2,r1	; 0232D700
	cmp r2,#0x0	; 0232D702
	beq loc_0232D70C	; 0232D704
	mov r2,#0x80	; 0232D706
	ldr r1,[pool_0232D750]	; 0232D708
	strb r2,[r1,#0x0]	; 0232D70A
loc_0232D70C:
	mov r1,#0x40	; 0232D70C
	add r2,r0,#0x0	; 0232D70E
	and r2,r1	; 0232D710
	cmp r2,#0x0	; 0232D712
	beq loc_0232D71C	; 0232D714
	mov r2,#0x80	; 0232D716
	ldr r1,[pool_0232D754]	; 0232D718
	strb r2,[r1,#0x0]	; 0232D71A
loc_0232D71C:
	mov r2,#0x80	; 0232D71C
	add r1,r0,#0x0	; 0232D71E
	and r1,r2	; 0232D720
	cmp r1,#0x0	; 0232D722
	beq loc_0232D72A	; 0232D724
	ldr r1,[pool_0232D758]	; 0232D726
	strb r2,[r1,#0x0]	; 0232D728
loc_0232D72A:
	ldr r1,[pool_0232D75C]	; 0232D72A
	and r0,r1	; 0232D72C
	cmp r0,#0x0	; 0232D72E
	beq loc_0232D738	; 0232D730
	mov r1,#0x80	; 0232D732
	ldr r0,[pool_0232D760]	; 0232D734
	strb r1,[r0,#0x0]	; 0232D736
loc_0232D738:
	bx lr	; 0232D738
.endfunc
	.byte 0xC0, 0x46	; 0232D73C
pool_0232D73C:
loc_0232D73C:
	.word VRAM_A_CR	; 0232D73C
pool_0232D740:
loc_0232D740:
	.word VRAM_B_CR	; 0232D740
pool_0232D744:
loc_0232D744:
	.word VRAM_C_CR	; 0232D744
pool_0232D748:
loc_0232D748:
	.word VRAM_D_CR	; 0232D748
pool_0232D74C:
loc_0232D74C:
	.word VRAM_E_CR	; 0232D74C
pool_0232D750:
loc_0232D750:
	.word VRAM_F_CR	; 0232D750
pool_0232D754:
loc_0232D754:
	.word VRAM_G_CR	; 0232D754
pool_0232D758:
loc_0232D758:
	.word VRAM_H_CR	; 0232D758
pool_0232D75C:
loc_0232D75C:
	.word 0x00000100	; 0232D75C
pool_0232D760:
loc_0232D760:
	.word VRAM_I_CR	; 0232D760

; ===== function loc_0232D764 =====
; Returns sub-engine BG3 character-base address, or zero for an unsupported configuration.
; 返回副引擎 BG3 字符基址；当前显示配置不支持时返回零。
.func P1_TryGetSubBg3CharacterBase
loc_0232D764:
	ldr r0,[pool_0232D794]	; 0232D764
	ldr r1,[r0,#0x0]	; 0232D766
	mov r0,#0x7	; 0232D768
	and r1,r0	; 0232D76A
	ldr r0,[pool_0232D798]	; 0232D76C
	ldrh r2,[r0,#0x0]	; 0232D76E
	cmp r1,#0x3	; 0232D770
	blt loc_0232D782	; 0232D772
	cmp r1,#0x6	; 0232D774
	bge loc_0232D790	; 0232D776
	mov r0,#0x80	; 0232D778
	add r1,r2,#0x0	; 0232D77A
	and r1,r0	; 0232D77C
	cmp r1,#0x0	; 0232D77E
	bne loc_0232D790	; 0232D780
loc_0232D782:
	mov r0,#0x3c	; 0232D782
	and r2,r0	; 0232D784
	lsr r0,r2,#0x2	; 0232D786
	lsl r1,r0,#0xe	; 0232D788
	ldr r0,[pool_0232D79C]	; 0232D78A
	add r0,r1,r0	; 0232D78C
	bx lr	; 0232D78E
loc_0232D790:
	mov r0,#0x0	; 0232D790
	bx lr	; 0232D792
.endfunc
pool_0232D794:
loc_0232D794:
	.word REG_DISPCNT_B	; 0232D794
pool_0232D798:
loc_0232D798:
	.word REG_BG3CNT_SUB	; 0232D798
pool_0232D79C:
loc_0232D79C:
	.word 0x06200000	; 0232D79C

; ===== function loc_0232D7A0 =====
; Returns main-engine BG3 character-base address, or zero for an unsupported configuration.
; 返回主引擎 BG3 字符基址；当前显示配置不支持时返回零。
.func P1_TryGetMainBg3CharacterBase
loc_0232D7A0:
	ldr r0,[pool_0232D7E0]	; 0232D7A0
	ldr r1,[r0,#0x0]	; 0232D7A2
	mov r0,#0x7	; 0232D7A4
	and r1,r0	; 0232D7A6
	ldr r0,[pool_0232D7E4]	; 0232D7A8
	ldrh r0,[r0,#0x0]	; 0232D7AA
	cmp r1,#0x3	; 0232D7AC
	blt loc_0232D7BE	; 0232D7AE
	cmp r1,#0x6	; 0232D7B0
	bge loc_0232D7DA	; 0232D7B2
	mov r1,#0x80	; 0232D7B4
	add r2,r0,#0x0	; 0232D7B6
	and r2,r1	; 0232D7B8
	cmp r2,#0x0	; 0232D7BA
	bne loc_0232D7DA	; 0232D7BC
loc_0232D7BE:
	ldr r1,[pool_0232D7E0]	; 0232D7BE
	ldr r2,[r1,#0x0]	; 0232D7C0
	ldr r1,[pool_0232D7E8]	; 0232D7C2
	and r2,r1	; 0232D7C4
	lsr r1,r2,#0x18	; 0232D7C6
	lsl r2,r1,#0x10	; 0232D7C8
	ldr r1,[pool_0232D7EC]	; 0232D7CA
	add r2,r2,r1	; 0232D7CC
	mov r1,#0x3c	; 0232D7CE
	and r0,r1	; 0232D7D0
	lsr r0,r0,#0x2	; 0232D7D2
	lsl r0,r0,#0xe	; 0232D7D4
	add r0,r2,r0	; 0232D7D6
	bx lr	; 0232D7D8
loc_0232D7DA:
	mov r0,#0x0	; 0232D7DA
	bx lr	; 0232D7DC
.endfunc
	.byte 0xC0, 0x46	; 0232D7E0
pool_0232D7E0:
loc_0232D7E0:
	.word REG_DISPCNT_A	; 0232D7E0
pool_0232D7E4:
loc_0232D7E4:
	.word REG_BG3CNT	; 0232D7E4
pool_0232D7E8:
loc_0232D7E8:
	.word 0x07000000	; 0232D7E8
pool_0232D7EC:
loc_0232D7EC:
	.word 0x06000000	; 0232D7EC

; ===== function loc_0232D7F0 =====
; Returns sub-engine BG2 character-base address, or zero for an unsupported configuration.
; 返回副引擎 BG2 字符基址；当前显示配置不支持时返回零。
.func P1_TryGetSubBg2CharacterBase
loc_0232D7F0:
	ldr r0,[pool_0232D81C]	; 0232D7F0
	ldr r1,[r0,#0x0]	; 0232D7F2
	mov r0,#0x7	; 0232D7F4
	and r1,r0	; 0232D7F6
	ldr r0,[pool_0232D820]	; 0232D7F8
	ldrh r2,[r0,#0x0]	; 0232D7FA
	cmp r1,#0x5	; 0232D7FC
	blt loc_0232D80A	; 0232D7FE
	mov r0,#0x80	; 0232D800
	add r1,r2,#0x0	; 0232D802
	and r1,r0	; 0232D804
	cmp r1,#0x0	; 0232D806
	bne loc_0232D818	; 0232D808
loc_0232D80A:
	mov r0,#0x3c	; 0232D80A
	and r2,r0	; 0232D80C
	lsr r0,r2,#0x2	; 0232D80E
	lsl r1,r0,#0xe	; 0232D810
	ldr r0,[pool_0232D824]	; 0232D812
	add r0,r1,r0	; 0232D814
	bx lr	; 0232D816
loc_0232D818:
	mov r0,#0x0	; 0232D818
	bx lr	; 0232D81A
.endfunc
pool_0232D81C:
loc_0232D81C:
	.word REG_DISPCNT_B	; 0232D81C
pool_0232D820:
loc_0232D820:
	.word REG_BG2CNT_SUB	; 0232D820
pool_0232D824:
loc_0232D824:
	.word 0x06200000	; 0232D824

; ===== function loc_0232D828 =====
; Returns main-engine BG2 character-base address, or zero for an unsupported configuration.
; 返回主引擎 BG2 字符基址；当前显示配置不支持时返回零。
.func P1_TryGetMainBg2CharacterBase
loc_0232D828:
	ldr r0,[pool_0232D864]	; 0232D828
	ldr r1,[r0,#0x0]	; 0232D82A
	mov r0,#0x7	; 0232D82C
	and r1,r0	; 0232D82E
	ldr r0,[pool_0232D868]	; 0232D830
	ldrh r0,[r0,#0x0]	; 0232D832
	cmp r1,#0x5	; 0232D834
	blt loc_0232D842	; 0232D836
	mov r1,#0x80	; 0232D838
	add r2,r0,#0x0	; 0232D83A
	and r2,r1	; 0232D83C
	cmp r2,#0x0	; 0232D83E
	bne loc_0232D85E	; 0232D840
loc_0232D842:
	ldr r1,[pool_0232D864]	; 0232D842
	ldr r2,[r1,#0x0]	; 0232D844
	ldr r1,[pool_0232D86C]	; 0232D846
	and r2,r1	; 0232D848
	lsr r1,r2,#0x18	; 0232D84A
	lsl r2,r1,#0x10	; 0232D84C
	ldr r1,[pool_0232D870]	; 0232D84E
	add r2,r2,r1	; 0232D850
	mov r1,#0x3c	; 0232D852
	and r0,r1	; 0232D854
	lsr r0,r0,#0x2	; 0232D856
	lsl r0,r0,#0xe	; 0232D858
	add r0,r2,r0	; 0232D85A
	bx lr	; 0232D85C
loc_0232D85E:
	mov r0,#0x0	; 0232D85E
	bx lr	; 0232D860
.endfunc
	.byte 0xC0, 0x46	; 0232D864
pool_0232D864:
loc_0232D864:
	.word REG_DISPCNT_A	; 0232D864
pool_0232D868:
loc_0232D868:
	.word REG_BG2CNT	; 0232D868
pool_0232D86C:
loc_0232D86C:
	.word 0x07000000	; 0232D86C
pool_0232D870:
loc_0232D870:
	.word 0x06000000	; 0232D870

; ===== function loc_0232D874 =====
; Returns the sub-engine BG1 character-base address.
; 返回副引擎 BG1 字符基址。
.func P1_GetSubBg1CharacterBase
loc_0232D874:
	ldr r0,[pool_0232D888]	; 0232D874
	ldrh r1,[r0,#0x0]	; 0232D876
	mov r0,#0x3c	; 0232D878
	and r1,r0	; 0232D87A
	asr r0,r1,#0x2	; 0232D87C
	lsl r1,r0,#0xe	; 0232D87E
	ldr r0,[pool_0232D88C]	; 0232D880
	add r0,r1,r0	; 0232D882
	bx lr	; 0232D884
.endfunc
	.byte 0xC0, 0x46	; 0232D888
pool_0232D888:
loc_0232D888:
	.word REG_BG1CNT_SUB	; 0232D888
pool_0232D88C:
loc_0232D88C:
	.word 0x06200000	; 0232D88C

; ===== function loc_0232D890 =====
; Returns the main-engine BG1 character-base address.
; 返回主引擎 BG1 字符基址。
.func P1_GetMainBg1CharacterBase
loc_0232D890:
	ldr r0,[pool_0232D8B0]	; 0232D890
	ldrh r1,[r0,#0x0]	; 0232D892
	mov r0,#0x3c	; 0232D894
	and r1,r0	; 0232D896
	asr r0,r1,#0x2	; 0232D898
	lsl r2,r0,#0xe	; 0232D89A
	ldr r0,[pool_0232D8B4]	; 0232D89C
	ldr r1,[r0,#0x0]	; 0232D89E
	ldr r0,[pool_0232D8B8]	; 0232D8A0
	and r1,r0	; 0232D8A2
	lsr r0,r1,#0x18	; 0232D8A4
	lsl r1,r0,#0x10	; 0232D8A6
	ldr r0,[pool_0232D8BC]	; 0232D8A8
	add r0,r1,r0	; 0232D8AA
	add r0,r2,r0	; 0232D8AC
	bx lr	; 0232D8AE
.endfunc
pool_0232D8B0:
loc_0232D8B0:
	.word REG_BG1CNT	; 0232D8B0
pool_0232D8B4:
loc_0232D8B4:
	.word REG_DISPCNT_A	; 0232D8B4
pool_0232D8B8:
loc_0232D8B8:
	.word 0x07000000	; 0232D8B8
pool_0232D8BC:
loc_0232D8BC:
	.word 0x06000000	; 0232D8BC

; ===== function loc_0232D8C0 =====
; Returns the sub-engine BG0 character-base address.
; 返回副引擎 BG0 字符基址。
.func P1_GetSubBg0CharacterBase
loc_0232D8C0:
	ldr r0,[pool_0232D8D4]	; 0232D8C0
	ldrh r1,[r0,#0x0]	; 0232D8C2
	mov r0,#0x3c	; 0232D8C4
	and r1,r0	; 0232D8C6
	asr r0,r1,#0x2	; 0232D8C8
	lsl r1,r0,#0xe	; 0232D8CA
	ldr r0,[pool_0232D8D8]	; 0232D8CC
	add r0,r1,r0	; 0232D8CE
	bx lr	; 0232D8D0
.endfunc
	.byte 0xC0, 0x46	; 0232D8D4
pool_0232D8D4:
loc_0232D8D4:
	.word REG_BG0CNT_SUB	; 0232D8D4
pool_0232D8D8:
loc_0232D8D8:
	.word 0x06200000	; 0232D8D8
; ===== function loc_0232D8EC =====
; Returns the main-engine BG0 character-base address.
; 返回主引擎 BG0 字符基址。
.func P1_GetMainBg0CharacterBase
loc_0232D8EC:
	ldr r0,[pool_0232D90C]	; 0232D8EC
	ldrh r1,[r0,#0x0]	; 0232D8EE
	mov r0,#0x3c	; 0232D8F0
	and r1,r0	; 0232D8F2
	asr r0,r1,#0x2	; 0232D8F4
	lsl r2,r0,#0xe	; 0232D8F6
	ldr r0,[pool_0232D910]	; 0232D8F8
	ldr r1,[r0,#0x0]	; 0232D8FA
	ldr r0,[pool_0232D914]	; 0232D8FC
	and r1,r0	; 0232D8FE
	lsr r0,r1,#0x18	; 0232D900
	lsl r1,r0,#0x10	; 0232D902
	ldr r0,[pool_0232D918]	; 0232D904
	add r0,r1,r0	; 0232D906
	add r0,r2,r0	; 0232D908
	bx lr	; 0232D90A
.endfunc
pool_0232D90C:
	.word REG_BG0CNT	; 0232D90C
pool_0232D910:
	.word REG_DISPCNT_A	; 0232D910
pool_0232D914:
	.word 0x07000000	; 0232D914
pool_0232D918:
	.word 0x06000000	; 0232D918

; ===== function loc_0232D90C =====
; Resolves the sub-engine BG3 tilemap base for the active BG mode.
; 按当前 BG 模式解析副引擎 BG3 tilemap 基址。
.func P1_ResolveSubBg3TilemapAddress
loc_0232D90C:
	ldr r0,[pool_0232D968]	; 0232D90C
	ldr r3,[r0,#0x0]	; 0232D90E
	mov r0,#0x7	; 0232D910
	and r3,r0	; 0232D912
	ldr r0,[pool_0232D96C]	; 0232D914
	ldrh r0,[r0,#0x0]	; 0232D916
	ldr r1,[pool_0232D970]	; 0232D918
	add r2,r0,#0x0	; 0232D91A
	and r2,r1	; 0232D91C
	lsr r2,r2,#0x8	; 0232D91E
	cmp r3,#0x6	; 0232D920
	bhi loc_0232D964	; 0232D922
	add r1,r3,r3	; 0232D924
P1_SwitchIndexPC_0232D924:
	add r1,pc	; 0232D926
	ldrh r1,[r1,#(P1_SwitchTable_0232D924 - (P1_SwitchIndexPC_0232D924 + 4))]	; 0232D928
	lsl r1,r1,#0x10	; 0232D92A
	asr r1,r1,#0x10	; 0232D92C
P1_SwitchTargetPC_0232D924:
	add r1,pc	; 0232D92E
	bx r1	; 0232D930
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232D924:
	.halfword (loc_0232D940 + 1) - (P1_SwitchTargetPC_0232D924 + 4)
	.halfword (loc_0232D940 + 1) - (P1_SwitchTargetPC_0232D924 + 4)
	.halfword (loc_0232D940 + 1) - (P1_SwitchTargetPC_0232D924 + 4)
	.halfword (loc_0232D948 + 1) - (P1_SwitchTargetPC_0232D924 + 4)
	.halfword (loc_0232D948 + 1) - (P1_SwitchTargetPC_0232D924 + 4)
	.halfword (loc_0232D948 + 1) - (P1_SwitchTargetPC_0232D924 + 4)
	.halfword (loc_0232D960 + 1) - (P1_SwitchTargetPC_0232D924 + 4)
P1_SwitchTable_0232D924End:
loc_0232D940:
	lsl r1,r2,#0xb	; 0232D940
	ldr r0,[pool_0232D974]	; 0232D942
	add r0,r1,r0	; 0232D944
	bx lr	; 0232D946
loc_0232D948:
	mov r1,#0x80	; 0232D948
	and r0,r1	; 0232D94A
	cmp r0,#0x0	; 0232D94C
	beq loc_0232D958	; 0232D94E
	lsl r1,r2,#0xe	; 0232D950
	ldr r0,[pool_0232D974]	; 0232D952
	add r0,r1,r0	; 0232D954
	bx lr	; 0232D956
loc_0232D958:
	lsl r1,r2,#0xb	; 0232D958
	ldr r0,[pool_0232D974]	; 0232D95A
	add r0,r1,r0	; 0232D95C
	bx lr	; 0232D95E
loc_0232D960:
	mov r0,#0x0	; 0232D960
	bx lr	; 0232D962
loc_0232D964:
	mov r0,#0x0	; 0232D964
	bx lr	; 0232D966
.endfunc
pool_0232D968:
loc_0232D968:
	.word REG_DISPCNT_B	; 0232D968
pool_0232D96C:
loc_0232D96C:
	.word REG_BG3CNT_SUB	; 0232D96C
pool_0232D970:
loc_0232D970:
	.word 0x00001F00	; 0232D970
pool_0232D974:
loc_0232D974:
	.word 0x06200000	; 0232D974
.arm

; ===== function loc_0232D978 =====
; Resolves the main-engine BG3 tilemap base for the active BG and VRAM mode.
; 按当前 BG 与 VRAM 模式解析主引擎 BG3 tilemap 基址。
.func P1_ResolveMainBg3TilemapAddress
loc_0232D978:
	ldr r0,[pool_0232DA00]	; 0232D978
	mov r2,#0x4000000	; 0232D97C
	ldr r1,[r2,#0x0]	; 0232D980
	ldrh r3,[r0,#0x0]	; 0232D984
	ldr r0,[r2,#0x0]	; 0232D988
	and r12,r1,#0x7	; 0232D98C
	and r0,r0,#0x38000000	; 0232D990
	mov r1,r0, lsr #0x1b	; 0232D994
	and r0,r3,#0x1f00	; 0232D998
	mov r2,r1, lsl #0x10	; 0232D99C
	cmp r12,#((P1_ArmBranchTable_0232D9A8End - P1_ArmBranchTable_0232D9A8) / 4 - 1)	; 0232D9A0
	mov r1,r0, lsr #0x8	; 0232D9A4
; ARM 的 PC 为当前地址 +8；索引选择一条 4 字节 B 指令。
; ARM reads PC+8; the index selects one 4-byte B instruction.
P1_ArmBranchTable_0232D9A8PC:
	addls pc,pc,r12, lsl #0x2	; 0232D9A8
	b loc_0232D9F8	; 0232D9AC
loc_0232D9B0:
P1_ArmBranchTable_0232D9A8:
	b loc_0232D9CC	; 0232D9B0
loc_0232D9B4:
	b loc_0232D9CC	; 0232D9B4
loc_0232D9B8:
	b loc_0232D9CC	; 0232D9B8
loc_0232D9BC:
	b loc_0232D9D8	; 0232D9BC
loc_0232D9C0:
	b loc_0232D9D8	; 0232D9C0
loc_0232D9C4:
	b loc_0232D9D8	; 0232D9C4
loc_0232D9C8:
	b loc_0232D9F0	; 0232D9C8
loc_0232D9CC:
P1_ArmBranchTable_0232D9A8End:
.if (P1_ArmBranchTable_0232D9A8 != P1_ArmBranchTable_0232D9A8PC + 8) || ((P1_ArmBranchTable_0232D9A8End - P1_ArmBranchTable_0232D9A8) % 4 != 0)
    .error "ARM branch-table layout changed"
.endif
	add r0,r2,#0x6000000	; 0232D9CC
	add r0,r0,r1, lsl #0xb	; 0232D9D0
	bx lr	; 0232D9D4
loc_0232D9D8:
	ands r0,r3,#0x80	; 0232D9D8
	movne r0,r1, lsl #0xe	; 0232D9DC
	addne r0,r0,#0x6000000	; 0232D9E0
	addeq r0,r2,#0x6000000	; 0232D9E4
	addeq r0,r0,r1, lsl #0xb	; 0232D9E8
	bx lr	; 0232D9EC
loc_0232D9F0:
	mov r0,#0x0	; 0232D9F0
	bx lr	; 0232D9F4
loc_0232D9F8:
	mov r0,#0x0	; 0232D9F8
	bx lr	; 0232D9FC
.endfunc
pool_0232DA00:
loc_0232DA00:
	.word REG_BG3CNT	; 0232DA00
.thumb

; ===== function loc_0232DA04 =====
; Resolves the sub-engine BG2 tilemap base for the active BG mode.
; 按当前 BG 模式解析副引擎 BG2 tilemap 基址。
.func P1_ResolveSubBg2TilemapAddress
loc_0232DA04:
	ldr r0,[pool_0232DA60]	; 0232DA04
	ldr r3,[r0,#0x0]	; 0232DA06
	mov r0,#0x7	; 0232DA08
	and r3,r0	; 0232DA0A
	ldr r0,[pool_0232DA64]	; 0232DA0C
	ldrh r0,[r0,#0x0]	; 0232DA0E
	ldr r1,[pool_0232DA68]	; 0232DA10
	add r2,r0,#0x0	; 0232DA12
	and r2,r1	; 0232DA14
	lsr r2,r2,#0x8	; 0232DA16
	cmp r3,#0x6	; 0232DA18
	bhi loc_0232DA5C	; 0232DA1A
	add r1,r3,r3	; 0232DA1C
P1_SwitchIndexPC_0232DA1C:
	add r1,pc	; 0232DA1E
	ldrh r1,[r1,#(P1_SwitchTable_0232DA1C - (P1_SwitchIndexPC_0232DA1C + 4))]	; 0232DA20
	lsl r1,r1,#0x10	; 0232DA22
	asr r1,r1,#0x10	; 0232DA24
P1_SwitchTargetPC_0232DA1C:
	add r1,pc	; 0232DA26
	bx r1	; 0232DA28
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232DA1C:
	.halfword (loc_0232DA38 + 1) - (P1_SwitchTargetPC_0232DA1C + 4)
	.halfword (loc_0232DA38 + 1) - (P1_SwitchTargetPC_0232DA1C + 4)
	.halfword (loc_0232DA38 + 1) - (P1_SwitchTargetPC_0232DA1C + 4)
	.halfword (loc_0232DA38 + 1) - (P1_SwitchTargetPC_0232DA1C + 4)
	.halfword (loc_0232DA38 + 1) - (P1_SwitchTargetPC_0232DA1C + 4)
	.halfword (loc_0232DA40 + 1) - (P1_SwitchTargetPC_0232DA1C + 4)
	.halfword (loc_0232DA58 + 1) - (P1_SwitchTargetPC_0232DA1C + 4)
P1_SwitchTable_0232DA1CEnd:
loc_0232DA38:
	lsl r1,r2,#0xb	; 0232DA38
	ldr r0,[pool_0232DA6C]	; 0232DA3A
	add r0,r1,r0	; 0232DA3C
	bx lr	; 0232DA3E
loc_0232DA40:
	mov r1,#0x80	; 0232DA40
	and r0,r1	; 0232DA42
	cmp r0,#0x0	; 0232DA44
	beq loc_0232DA50	; 0232DA46
	lsl r1,r2,#0xe	; 0232DA48
	ldr r0,[pool_0232DA6C]	; 0232DA4A
	add r0,r1,r0	; 0232DA4C
	bx lr	; 0232DA4E
loc_0232DA50:
	lsl r1,r2,#0xb	; 0232DA50
	ldr r0,[pool_0232DA6C]	; 0232DA52
	add r0,r1,r0	; 0232DA54
	bx lr	; 0232DA56
loc_0232DA58:
	mov r0,#0x0	; 0232DA58
	bx lr	; 0232DA5A
loc_0232DA5C:
	mov r0,#0x0	; 0232DA5C
	bx lr	; 0232DA5E
.endfunc
pool_0232DA60:
loc_0232DA60:
	.word REG_DISPCNT_B	; 0232DA60
pool_0232DA64:
loc_0232DA64:
	.word REG_BG2CNT_SUB	; 0232DA64
pool_0232DA68:
loc_0232DA68:
	.word 0x00001F00	; 0232DA68
pool_0232DA6C:
loc_0232DA6C:
	.word 0x06200000	; 0232DA6C
.arm

; ===== function loc_0232DA70 =====
; Resolves the main-engine BG2 tilemap base for the active BG and VRAM mode.
; 按当前 BG 与 VRAM 模式解析主引擎 BG2 tilemap 基址。
.func P1_ResolveMainBg2TilemapAddress
loc_0232DA70:
	ldr r0,[pool_0232DAF8]	; 0232DA70
	mov r2,#0x4000000	; 0232DA74
	ldr r1,[r2,#0x0]	; 0232DA78
	ldrh r3,[r0,#0x0]	; 0232DA7C
	ldr r0,[r2,#0x0]	; 0232DA80
	and r12,r1,#0x7	; 0232DA84
	and r0,r0,#0x38000000	; 0232DA88
	mov r1,r0, lsr #0x1b	; 0232DA8C
	and r0,r3,#0x1f00	; 0232DA90
	mov r2,r1, lsl #0x10	; 0232DA94
	cmp r12,#((P1_ArmBranchTable_0232DAA0End - P1_ArmBranchTable_0232DAA0) / 4 - 1)	; 0232DA98
	mov r1,r0, lsr #0x8	; 0232DA9C
; ARM 的 PC 为当前地址 +8；索引选择一条 4 字节 B 指令。
; ARM reads PC+8; the index selects one 4-byte B instruction.
P1_ArmBranchTable_0232DAA0PC:
	addls pc,pc,r12, lsl #0x2	; 0232DAA0
	b loc_0232DAF0	; 0232DAA4
loc_0232DAA8:
P1_ArmBranchTable_0232DAA0:
	b loc_0232DAC4	; 0232DAA8
loc_0232DAAC:
	b loc_0232DAC4	; 0232DAAC
loc_0232DAB0:
	b loc_0232DAC4	; 0232DAB0
loc_0232DAB4:
	b loc_0232DAC4	; 0232DAB4
loc_0232DAB8:
	b loc_0232DAC4	; 0232DAB8
loc_0232DABC:
	b loc_0232DAD0	; 0232DABC
loc_0232DAC0:
	b loc_0232DAE8	; 0232DAC0
loc_0232DAC4:
P1_ArmBranchTable_0232DAA0End:
.if (P1_ArmBranchTable_0232DAA0 != P1_ArmBranchTable_0232DAA0PC + 8) || ((P1_ArmBranchTable_0232DAA0End - P1_ArmBranchTable_0232DAA0) % 4 != 0)
    .error "ARM branch-table layout changed"
.endif
	add r0,r2,#0x6000000	; 0232DAC4
	add r0,r0,r1, lsl #0xb	; 0232DAC8
	bx lr	; 0232DACC
loc_0232DAD0:
	ands r0,r3,#0x80	; 0232DAD0
	movne r0,r1, lsl #0xe	; 0232DAD4
	addne r0,r0,#0x6000000	; 0232DAD8
	addeq r0,r2,#0x6000000	; 0232DADC
	addeq r0,r0,r1, lsl #0xb	; 0232DAE0
	bx lr	; 0232DAE4
loc_0232DAE8:
	mov r0,#0x6000000	; 0232DAE8
	bx lr	; 0232DAEC
loc_0232DAF0:
	mov r0,#0x0	; 0232DAF0
	bx lr	; 0232DAF4
.endfunc
pool_0232DAF8:
loc_0232DAF8:
	.word REG_BG2CNT	; 0232DAF8
.thumb

; ===== function loc_0232DAFC =====
; Returns the sub-engine BG1 tilemap base from BG1CNT.
; 由 BG1CNT 返回副引擎 BG1 tilemap 基址。
.func P1_GetSubBg1TilemapBase
loc_0232DAFC:
	ldr r0,[pool_0232DB10]	; 0232DAFC
	ldrh r1,[r0,#0x0]	; 0232DAFE
	ldr r0,[pool_0232DB14]	; 0232DB00
	and r1,r0	; 0232DB02
	asr r0,r1,#0x8	; 0232DB04
	lsl r1,r0,#0xb	; 0232DB06
	ldr r0,[pool_0232DB18]	; 0232DB08
	add r0,r1,r0	; 0232DB0A
	bx lr	; 0232DB0C
.endfunc
	.byte 0xC0, 0x46	; 0232DB10
pool_0232DB10:
loc_0232DB10:
	.word REG_BG1CNT_SUB	; 0232DB10
pool_0232DB14:
loc_0232DB14:
	.word 0x00001F00	; 0232DB14
pool_0232DB18:
loc_0232DB18:
	.word 0x06200000	; 0232DB18

; ===== function loc_0232DB1C =====
; Returns the main-engine BG1 tilemap base from BG1CNT and VRAM bank mode.
; 由 BG1CNT 与 VRAM bank 模式返回主引擎 BG1 tilemap 基址。
.func P1_GetMainBg1TilemapBase
loc_0232DB1C:
	ldr r0,[pool_0232DB3C]	; 0232DB1C
	ldrh r1,[r0,#0x0]	; 0232DB1E
	ldr r0,[pool_0232DB40]	; 0232DB20
	and r1,r0	; 0232DB22
	asr r0,r1,#0x8	; 0232DB24
	lsl r2,r0,#0xb	; 0232DB26
	ldr r0,[pool_0232DB44]	; 0232DB28
	ldr r1,[r0,#0x0]	; 0232DB2A
	ldr r0,[pool_0232DB48]	; 0232DB2C
	and r1,r0	; 0232DB2E
	lsr r0,r1,#0x1b	; 0232DB30
	lsl r1,r0,#0x10	; 0232DB32
	ldr r0,[pool_0232DB4C]	; 0232DB34
	add r0,r1,r0	; 0232DB36
	add r0,r2,r0	; 0232DB38
	bx lr	; 0232DB3A
.endfunc
pool_0232DB3C:
loc_0232DB3C:
	.word REG_BG1CNT	; 0232DB3C
pool_0232DB40:
loc_0232DB40:
	.word 0x00001F00	; 0232DB40
pool_0232DB44:
loc_0232DB44:
	.word REG_DISPCNT_A	; 0232DB44
pool_0232DB48:
loc_0232DB48:
	.word 0x38000000	; 0232DB48
pool_0232DB4C:
loc_0232DB4C:
	.word 0x06000000	; 0232DB4C

; ===== function loc_0232DB50 =====
; Returns the sub-engine BG0 tilemap base from BG0CNT.
; 由 BG0CNT 返回副引擎 BG0 tilemap 基址。
.func P1_GetSubBg0TilemapBase
loc_0232DB50:
	ldr r0,[pool_0232DB64]	; 0232DB50
	ldrh r1,[r0,#0x0]	; 0232DB52
	ldr r0,[pool_0232DB68]	; 0232DB54
	and r1,r0	; 0232DB56
	asr r0,r1,#0x8	; 0232DB58
	lsl r1,r0,#0xb	; 0232DB5A
	ldr r0,[pool_0232DB6C]	; 0232DB5C
	add r0,r1,r0	; 0232DB5E
	bx lr	; 0232DB60
.endfunc
	.byte 0xC0, 0x46	; 0232DB64
pool_0232DB64:
loc_0232DB64:
	.word REG_BG0CNT_SUB	; 0232DB64
pool_0232DB68:
loc_0232DB68:
	.word 0x00001F00	; 0232DB68
pool_0232DB6C:
loc_0232DB6C:
	.word 0x06200000	; 0232DB6C

; ===== function loc_0232DB70 =====
; Returns the main-engine BG0 tilemap base from BG0CNT and VRAM bank mode.
; 由 BG0CNT 与 VRAM bank 模式返回主引擎 BG0 tilemap 基址。
.func P1_GetMainBg0TilemapBase
loc_0232DB70:
	ldr r0,[pool_0232DB90]	; 0232DB70
	ldrh r1,[r0,#0x0]	; 0232DB72
	ldr r0,[pool_0232DB94]	; 0232DB74
	and r1,r0	; 0232DB76
	asr r0,r1,#0x8	; 0232DB78
	lsl r2,r0,#0xb	; 0232DB7A
	ldr r0,[pool_0232DB98]	; 0232DB7C
	ldr r1,[r0,#0x0]	; 0232DB7E
	ldr r0,[pool_0232DB9C]	; 0232DB80
	and r1,r0	; 0232DB82
	lsr r0,r1,#0x1b	; 0232DB84
	lsl r1,r0,#0x10	; 0232DB86
	ldr r0,[pool_0232DBA0]	; 0232DB88
	add r0,r1,r0	; 0232DB8A
	add r0,r2,r0	; 0232DB8C
	bx lr	; 0232DB8E
.endfunc
pool_0232DB90:
loc_0232DB90:
	.word REG_BG0CNT	; 0232DB90
pool_0232DB94:
loc_0232DB94:
	.word 0x00001F00	; 0232DB94
pool_0232DB98:
loc_0232DB98:
	.word REG_DISPCNT_A	; 0232DB98
pool_0232DB9C:
loc_0232DB9C:
	.word 0x38000000	; 0232DB9C
pool_0232DBA0:
loc_0232DBA0:
	.word 0x06000000	; 0232DBA0

; ===== function loc_0232DBA4 =====
loc_0232DBA4:
	cmp r2,#0x0	; 0232DBA4
	bge loc_0232DBB4	; 0232DBA6
	mov r3,#0xc0	; 0232DBA8
	orr r1,r3	; 0232DBAA
	strh r1,[r0,#0x0]	; 0232DBAC
	neg r1,r2	; 0232DBAE
	strh r1,[r0,#0x4]	; 0232DBB0
	bx lr	; 0232DBB2
loc_0232DBB4:
	mov r3,#0x80	; 0232DBB4
	orr r1,r3	; 0232DBB6
	strh r1,[r0,#0x0]	; 0232DBB8
	strh r2,[r0,#0x4]	; 0232DBBA
	bx lr	; 0232DBBC
	.byte 0x00, 0x00	; 0232DBC0

; ===== function loc_0232DBC0 =====
loc_0232DBC0:
	push {r4}	; 0232DBC0
	sub sp,#0x4	; 0232DBC2
	mov r4,#0x40	; 0232DBC4
	orr r1,r4	; 0232DBC6
	lsl r2,r2,#0x8	; 0232DBC8
	orr r1,r2	; 0232DBCA
	ldr r2,[sp,#0x8]	; 0232DBCC
	lsl r2,r2,#0x8	; 0232DBCE
	orr r3,r2	; 0232DBD0
	lsl r2,r3,#0x10	; 0232DBD2
	orr r1,r2	; 0232DBD4
	str r1,[r0,#0x0]	; 0232DBD6
	add sp,#0x4	; 0232DBD8
	pop {r4}	; 0232DBDA
	bx lr	; 0232DBDC
	.byte 0x00, 0x00	; 0232DBE0

; ===== function loc_0232DBE0 =====
P1_Entry_0232DBE0:
	push {r4,r5,r6,lr}	; 0232DBE0
	add r5,r0,#0x0	; 0232DBE2
	add r4,r1,#0x0	; 0232DBE4
	add r6,r2,#0x0	; 0232DBE6
	bl P1_TryGetSubBg3CharacterBase	; 0232DBE8
	add r2,r0,#0x0	; 0232DBEC
	ldr r0,[pool_0232DC1C]	; 0232DBEE
	ldr r0,[r0,#0x0]	; 0232DBF0
	mov r1,#0x0	; 0232DBF2
	mvn r1,r1	; 0232DBF4
	cmp r0,r1	; 0232DBF6
	beq loc_0232DC0A	; 0232DBF8
	add r1,r5,#0x0	; 0232DBFA
	add r2,r2,r4	; 0232DBFC
	add r3,r6,#0x0	; 0232DBFE
	bl loc_0232E254	; 0232DC00
	pop {r4,r5,r6}	; 0232DC04
	pop {r3}	; 0232DC06
	bx r3	; 0232DC08
loc_0232DC0A:
	add r0,r5,#0x0	; 0232DC0A
	add r1,r2,r4	; 0232DC0C
	add r2,r6,#0x0	; 0232DC0E
	blx loc_0232E334	; 0232DC10
	pop {r4,r5,r6}	; 0232DC14
	pop {r3}	; 0232DC16
	bx r3	; 0232DC18
	.byte 0xC0, 0x46	; 0232DC1C
pool_0232DC1C:
loc_0232DC1C:
	.word P1_Data_02330E6C	; 0232DC1C

; ===== function loc_0232DC20 =====
P1_Entry_0232DC20:
	push {r4,r5,r6,lr}	; 0232DC20
	add r5,r0,#0x0	; 0232DC22
	add r4,r1,#0x0	; 0232DC24
	add r6,r2,#0x0	; 0232DC26
	bl P1_TryGetMainBg3CharacterBase	; 0232DC28
	add r2,r0,#0x0	; 0232DC2C
	ldr r0,[pool_0232DC5C]	; 0232DC2E
	ldr r0,[r0,#0x0]	; 0232DC30
	mov r1,#0x0	; 0232DC32
	mvn r1,r1	; 0232DC34
	cmp r0,r1	; 0232DC36
	beq loc_0232DC4A	; 0232DC38
	add r1,r5,#0x0	; 0232DC3A
	add r2,r2,r4	; 0232DC3C
	add r3,r6,#0x0	; 0232DC3E
	bl loc_0232E254	; 0232DC40
	pop {r4,r5,r6}	; 0232DC44
	pop {r3}	; 0232DC46
	bx r3	; 0232DC48
loc_0232DC4A:
	add r0,r5,#0x0	; 0232DC4A
	add r1,r2,r4	; 0232DC4C
	add r2,r6,#0x0	; 0232DC4E
	blx loc_0232E334	; 0232DC50
	pop {r4,r5,r6}	; 0232DC54
	pop {r3}	; 0232DC56
	bx r3	; 0232DC58
	.byte 0xC0, 0x46	; 0232DC5C
pool_0232DC5C:
loc_0232DC5C:
	.word P1_Data_02330E6C	; 0232DC5C
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xFF, 0xF7, 0xC2, 0xFD, 0x02, 0x1C, 0x0B, 0x48	; 0232DC70
	.byte 0x00, 0x68, 0x00, 0x21, 0xC9, 0x43, 0x88, 0x42, 0x07, 0xD0, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C	; 0232DC80
	.byte 0x00, 0xF0, 0xE8, 0xFA, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x28, 0x1C, 0x11, 0x19, 0x32, 0x1C	; 0232DC90
	.byte 0x00, 0xF0, 0x50, 0xEB, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x6C, 0x0E, 0x33, 0x02	; 0232DCA0

; ===== function loc_0232DCA0 =====
loc_0232DCA0:
	push {r4,r5,r6,lr}	; 0232DCA0
	add r5,r0,#0x0	; 0232DCA2
	add r4,r1,#0x0	; 0232DCA4
	add r6,r2,#0x0	; 0232DCA6
	bl P1_TryGetMainBg2CharacterBase	; 0232DCA8
	add r2,r0,#0x0	; 0232DCAC
	ldr r0,[pool_0232DCDC]	; 0232DCAE
	ldr r0,[r0,#0x0]	; 0232DCB0
	mov r1,#0x0	; 0232DCB2
	mvn r1,r1	; 0232DCB4
	cmp r0,r1	; 0232DCB6
	beq loc_0232DCCA	; 0232DCB8
	add r1,r5,#0x0	; 0232DCBA
	add r2,r2,r4	; 0232DCBC
	add r3,r6,#0x0	; 0232DCBE
	bl loc_0232E254	; 0232DCC0
	pop {r4,r5,r6}	; 0232DCC4
	pop {r3}	; 0232DCC6
	bx r3	; 0232DCC8
loc_0232DCCA:
	add r0,r5,#0x0	; 0232DCCA
	add r1,r2,r4	; 0232DCCC
	add r2,r6,#0x0	; 0232DCCE
	blx loc_0232E334	; 0232DCD0
	pop {r4,r5,r6}	; 0232DCD4
	pop {r3}	; 0232DCD6
	bx r3	; 0232DCD8
	.byte 0xC0, 0x46	; 0232DCDC
pool_0232DCDC:
loc_0232DCDC:
	.word P1_Data_02330E6C	; 0232DCDC

; ===== function loc_0232DCE0 =====
loc_0232DCE0:
	push {r4,r5,r6,lr}	; 0232DCE0
	add r5,r0,#0x0	; 0232DCE2
	add r4,r1,#0x0	; 0232DCE4
	add r6,r2,#0x0	; 0232DCE6
	bl P1_GetSubBg1CharacterBase	; 0232DCE8
	add r2,r0,#0x0	; 0232DCEC
	ldr r0,[pool_0232DD1C]	; 0232DCEE
	ldr r0,[r0,#0x0]	; 0232DCF0
	mov r1,#0x0	; 0232DCF2
	mvn r1,r1	; 0232DCF4
	cmp r0,r1	; 0232DCF6
	beq loc_0232DD0A	; 0232DCF8
	add r1,r5,#0x0	; 0232DCFA
	add r2,r2,r4	; 0232DCFC
	add r3,r6,#0x0	; 0232DCFE
	bl loc_0232E254	; 0232DD00
	pop {r4,r5,r6}	; 0232DD04
	pop {r3}	; 0232DD06
	bx r3	; 0232DD08
loc_0232DD0A:
	add r0,r5,#0x0	; 0232DD0A
	add r1,r2,r4	; 0232DD0C
	add r2,r6,#0x0	; 0232DD0E
	blx loc_0232E334	; 0232DD10
	pop {r4,r5,r6}	; 0232DD14
	pop {r3}	; 0232DD16
	bx r3	; 0232DD18
	.byte 0xC0, 0x46	; 0232DD1C
pool_0232DD1C:
loc_0232DD1C:
	.word P1_Data_02330E6C	; 0232DD1C

; ===== function loc_0232DD20 =====
loc_0232DD20:
	push {r4,r5,r6,lr}	; 0232DD20
	add r5,r0,#0x0	; 0232DD22
	add r4,r1,#0x0	; 0232DD24
	add r6,r2,#0x0	; 0232DD26
	bl P1_GetMainBg1CharacterBase	; 0232DD28
	add r2,r0,#0x0	; 0232DD2C
	ldr r0,[pool_0232DD5C]	; 0232DD2E
	ldr r0,[r0,#0x0]	; 0232DD30
	mov r1,#0x0	; 0232DD32
	mvn r1,r1	; 0232DD34
	cmp r0,r1	; 0232DD36
	beq loc_0232DD4A	; 0232DD38
	add r1,r5,#0x0	; 0232DD3A
	add r2,r2,r4	; 0232DD3C
	add r3,r6,#0x0	; 0232DD3E
	bl loc_0232E254	; 0232DD40
	pop {r4,r5,r6}	; 0232DD44
	pop {r3}	; 0232DD46
	bx r3	; 0232DD48
loc_0232DD4A:
	add r0,r5,#0x0	; 0232DD4A
	add r1,r2,r4	; 0232DD4C
	add r2,r6,#0x0	; 0232DD4E
	blx loc_0232E334	; 0232DD50
	pop {r4,r5,r6}	; 0232DD54
	pop {r3}	; 0232DD56
	bx r3	; 0232DD58
	.byte 0xC0, 0x46	; 0232DD5C
pool_0232DD5C:
loc_0232DD5C:
	.word P1_Data_02330E6C	; 0232DD5C

; ===== function loc_0232DD60 =====
	push {r4,r5,r6,lr}	; 0232DD60
	add r5,r0,#0x0	; 0232DD62
	add r4,r1,#0x0	; 0232DD64
	add r6,r2,#0x0	; 0232DD66
	bl P1_GetSubBg0CharacterBase	; 0232DD68
	add r2,r0,#0x0	; 0232DD6C
	ldr r0,[pool_0232DD9C]	; 0232DD6E
	ldr r0,[r0,#0x0]	; 0232DD70
	mov r1,#0x0	; 0232DD72
	mvn r1,r1	; 0232DD74
	cmp r0,r1	; 0232DD76
	beq loc_0232DD8A	; 0232DD78
	add r1,r5,#0x0	; 0232DD7A
	add r2,r2,r4	; 0232DD7C
	add r3,r6,#0x0	; 0232DD7E
	bl loc_0232E254	; 0232DD80
	pop {r4,r5,r6}	; 0232DD84
	pop {r3}	; 0232DD86
	bx r3	; 0232DD88
loc_0232DD8A:
	add r0,r5,#0x0	; 0232DD8A
	add r1,r2,r4	; 0232DD8C
	add r2,r6,#0x0	; 0232DD8E
	blx loc_0232E334	; 0232DD90
	pop {r4,r5,r6}	; 0232DD94
	pop {r3}	; 0232DD96
	bx r3	; 0232DD98
	.byte 0xC0, 0x46	; 0232DD9C
pool_0232DD9C:
loc_0232DD9C:
	.word P1_Data_02330E6C	; 0232DD9C
P1_Entry_0232DDA0:
	push {r4,r5,r6,lr}	; 0232DDA0
	add r5,r0,#0x0	; 0232DDA2
	add r4,r1,#0x0	; 0232DDA4
	add r6,r2,#0x0	; 0232DDA6
	bl P1_GetMainBg0CharacterBase	; 0232DDA8
	add r2,r0,#0x0	; 0232DDAC
	ldr r0,[pool_0232DDDC]	; 0232DDAE
	ldr r0,[r0,#0x0]	; 0232DDB0
	mov r1,#0x0	; 0232DDB2
	mvn r1,r1	; 0232DDB4
	cmp r0,r1	; 0232DDB6
	beq P1_Entry_0232DDCA	; 0232DDB8
	add r1,r5,#0x0	; 0232DDBA
	add r2,r2,r4	; 0232DDBC
	add r3,r6,#0x0	; 0232DDBE
	bl loc_0232E254	; 0232DDC0
	pop {r4,r5,r6}	; 0232DDC4
	pop {r3}	; 0232DDC6
	bx r3	; 0232DDC8
P1_Entry_0232DDCA:
	add r0,r5,#0x0	; 0232DDCA
	add r1,r2,r4	; 0232DDCC
	add r2,r6,#0x0	; 0232DDCE
	blx P1_MemCopy32	; 0232DDD0
	pop {r4,r5,r6}	; 0232DDD4
	pop {r3}	; 0232DDD6
	bx r3	; 0232DDD8
	.byte 0xC0, 0x46	; 0232DDDA
pool_0232DDDC:
	.word P1_Data_02330E6C	; 0232DDDC

; ===== function loc_0232DDE0 =====
loc_0232DDE0:
	push {r4,r5,r6,lr}	; 0232DDE0
	add r5,r0,#0x0	; 0232DDE2
	add r4,r1,#0x0	; 0232DDE4
	add r6,r2,#0x0	; 0232DDE6
	bl P1_ResolveSubBg3TilemapAddress	; 0232DDE8
	add r2,r0,#0x0	; 0232DDEC
	ldr r0,[pool_0232DE1C]	; 0232DDEE
	ldr r0,[r0,#0x0]	; 0232DDF0
	mov r1,#0x0	; 0232DDF2
	mvn r1,r1	; 0232DDF4
	cmp r0,r1	; 0232DDF6
	beq loc_0232DE0A	; 0232DDF8
	add r1,r5,#0x0	; 0232DDFA
	add r2,r2,r4	; 0232DDFC
	add r3,r6,#0x0	; 0232DDFE
	bl loc_0232E214	; 0232DE00
	pop {r4,r5,r6}	; 0232DE04
	pop {r3}	; 0232DE06
	bx r3	; 0232DE08
loc_0232DE0A:
	add r0,r5,#0x0	; 0232DE0A
	add r1,r2,r4	; 0232DE0C
	add r2,r6,#0x0	; 0232DE0E
	blx loc_0232E304	; 0232DE10
	pop {r4,r5,r6}	; 0232DE14
	pop {r3}	; 0232DE16
	bx r3	; 0232DE18
	.byte 0xC0, 0x46	; 0232DE1C
pool_0232DE1C:
loc_0232DE1C:
	.word P1_Data_02330E6C	; 0232DE1C

; ===== function loc_0232DE20 =====
loc_0232DE20:
	push {r4,r5,r6,lr}	; 0232DE20
	add r5,r0,#0x0	; 0232DE22
	add r4,r1,#0x0	; 0232DE24
	add r6,r2,#0x0	; 0232DE26
	blx P1_ResolveMainBg3TilemapAddress	; 0232DE28
	add r2,r0,#0x0	; 0232DE2C
	ldr r0,[pool_0232DE5C]	; 0232DE2E
	ldr r0,[r0,#0x0]	; 0232DE30
	mov r1,#0x0	; 0232DE32
	mvn r1,r1	; 0232DE34
	cmp r0,r1	; 0232DE36
	beq loc_0232DE4A	; 0232DE38
	add r1,r5,#0x0	; 0232DE3A
	add r2,r2,r4	; 0232DE3C
	add r3,r6,#0x0	; 0232DE3E
	bl loc_0232E214	; 0232DE40
	pop {r4,r5,r6}	; 0232DE44
	pop {r3}	; 0232DE46
	bx r3	; 0232DE48
loc_0232DE4A:
	add r0,r5,#0x0	; 0232DE4A
	add r1,r2,r4	; 0232DE4C
	add r2,r6,#0x0	; 0232DE4E
	blx loc_0232E304	; 0232DE50
	pop {r4,r5,r6}	; 0232DE54
	pop {r3}	; 0232DE56
	bx r3	; 0232DE58
	.byte 0xC0, 0x46	; 0232DE5C
pool_0232DE5C:
loc_0232DE5C:
	.word P1_Data_02330E6C	; 0232DE5C

; ===== function loc_0232DE60 =====
loc_0232DE60:
	push {r4,r5,r6,lr}	; 0232DE60
	add r5,r0,#0x0	; 0232DE62
	add r4,r1,#0x0	; 0232DE64
	add r6,r2,#0x0	; 0232DE66
	bl P1_ResolveSubBg2TilemapAddress	; 0232DE68
	add r2,r0,#0x0	; 0232DE6C
	ldr r0,[pool_0232DE9C]	; 0232DE6E
	ldr r0,[r0,#0x0]	; 0232DE70
	mov r1,#0x0	; 0232DE72
	mvn r1,r1	; 0232DE74
	cmp r0,r1	; 0232DE76
	beq loc_0232DE8A	; 0232DE78
	add r1,r5,#0x0	; 0232DE7A
	add r2,r2,r4	; 0232DE7C
	add r3,r6,#0x0	; 0232DE7E
	bl loc_0232E214	; 0232DE80
	pop {r4,r5,r6}	; 0232DE84
	pop {r3}	; 0232DE86
	bx r3	; 0232DE88
loc_0232DE8A:
	add r0,r5,#0x0	; 0232DE8A
	add r1,r2,r4	; 0232DE8C
	add r2,r6,#0x0	; 0232DE8E
	blx loc_0232E304	; 0232DE90
	pop {r4,r5,r6}	; 0232DE94
	pop {r3}	; 0232DE96
	bx r3	; 0232DE98
	.byte 0xC0, 0x46	; 0232DE9C
pool_0232DE9C:
loc_0232DE9C:
	.word P1_Data_02330E6C	; 0232DE9C

; ===== function loc_0232DEA0 =====
loc_0232DEA0:
	push {r4,r5,r6,lr}	; 0232DEA0
	add r5,r0,#0x0	; 0232DEA2
	add r4,r1,#0x0	; 0232DEA4
	add r6,r2,#0x0	; 0232DEA6
	blx P1_ResolveMainBg2TilemapAddress	; 0232DEA8
	add r2,r0,#0x0	; 0232DEAC
	ldr r0,[pool_0232DEDC]	; 0232DEAE
	ldr r0,[r0,#0x0]	; 0232DEB0
	mov r1,#0x0	; 0232DEB2
	mvn r1,r1	; 0232DEB4
	cmp r0,r1	; 0232DEB6
	beq loc_0232DECA	; 0232DEB8
	add r1,r5,#0x0	; 0232DEBA
	add r2,r2,r4	; 0232DEBC
	add r3,r6,#0x0	; 0232DEBE
	bl loc_0232E214	; 0232DEC0
	pop {r4,r5,r6}	; 0232DEC4
	pop {r3}	; 0232DEC6
	bx r3	; 0232DEC8
loc_0232DECA:
	add r0,r5,#0x0	; 0232DECA
	add r1,r2,r4	; 0232DECC
	add r2,r6,#0x0	; 0232DECE
	blx loc_0232E304	; 0232DED0
	pop {r4,r5,r6}	; 0232DED4
	pop {r3}	; 0232DED6
	bx r3	; 0232DED8
	.byte 0xC0, 0x46	; 0232DEDC
pool_0232DEDC:
loc_0232DEDC:
	.word P1_Data_02330E6C	; 0232DEDC

; ===== function loc_0232DEE0 =====
loc_0232DEE0:
	push {r4,r5,r6,lr}	; 0232DEE0
	add r5,r0,#0x0	; 0232DEE2
	add r4,r1,#0x0	; 0232DEE4
	add r6,r2,#0x0	; 0232DEE6
	bl P1_GetSubBg1TilemapBase	; 0232DEE8
	add r2,r0,#0x0	; 0232DEEC
	ldr r0,[pool_0232DF1C]	; 0232DEEE
	ldr r0,[r0,#0x0]	; 0232DEF0
	mov r1,#0x0	; 0232DEF2
	mvn r1,r1	; 0232DEF4
	cmp r0,r1	; 0232DEF6
	beq loc_0232DF0A	; 0232DEF8
	add r1,r5,#0x0	; 0232DEFA
	add r2,r2,r4	; 0232DEFC
	add r3,r6,#0x0	; 0232DEFE
	bl loc_0232E214	; 0232DF00
	pop {r4,r5,r6}	; 0232DF04
	pop {r3}	; 0232DF06
	bx r3	; 0232DF08
loc_0232DF0A:
	add r0,r5,#0x0	; 0232DF0A
	add r1,r2,r4	; 0232DF0C
	add r2,r6,#0x0	; 0232DF0E
	blx loc_0232E304	; 0232DF10
	pop {r4,r5,r6}	; 0232DF14
	pop {r3}	; 0232DF16
	bx r3	; 0232DF18
	.byte 0xC0, 0x46	; 0232DF1C
pool_0232DF1C:
loc_0232DF1C:
	.word P1_Data_02330E6C	; 0232DF1C

; ===== function loc_0232DF20 =====
loc_0232DF20:
	push {r4,r5,r6,lr}	; 0232DF20
	add r5,r0,#0x0	; 0232DF22
	add r4,r1,#0x0	; 0232DF24
	add r6,r2,#0x0	; 0232DF26
	bl P1_GetMainBg1TilemapBase	; 0232DF28
	add r2,r0,#0x0	; 0232DF2C
	ldr r0,[pool_0232DF5C]	; 0232DF2E
	ldr r0,[r0,#0x0]	; 0232DF30
	mov r1,#0x0	; 0232DF32
	mvn r1,r1	; 0232DF34
	cmp r0,r1	; 0232DF36
	beq loc_0232DF4A	; 0232DF38
	add r1,r5,#0x0	; 0232DF3A
	add r2,r2,r4	; 0232DF3C
	add r3,r6,#0x0	; 0232DF3E
	bl loc_0232E214	; 0232DF40
	pop {r4,r5,r6}	; 0232DF44
	pop {r3}	; 0232DF46
	bx r3	; 0232DF48
loc_0232DF4A:
	add r0,r5,#0x0	; 0232DF4A
	add r1,r2,r4	; 0232DF4C
	add r2,r6,#0x0	; 0232DF4E
	blx loc_0232E304	; 0232DF50
	pop {r4,r5,r6}	; 0232DF54
	pop {r3}	; 0232DF56
	bx r3	; 0232DF58
	.byte 0xC0, 0x46	; 0232DF5C
pool_0232DF5C:
loc_0232DF5C:
	.word P1_Data_02330E6C	; 0232DF5C

; ===== function loc_0232DF60 =====
loc_0232DF60:
	push {r4,r5,r6,lr}	; 0232DF60
	add r5,r0,#0x0	; 0232DF62
	add r4,r1,#0x0	; 0232DF64
	add r6,r2,#0x0	; 0232DF66
	bl P1_GetSubBg0TilemapBase	; 0232DF68
	add r2,r0,#0x0	; 0232DF6C
	ldr r0,[pool_0232DF9C]	; 0232DF6E
	ldr r0,[r0,#0x0]	; 0232DF70
	mov r1,#0x0	; 0232DF72
	mvn r1,r1	; 0232DF74
	cmp r0,r1	; 0232DF76
	beq loc_0232DF8A	; 0232DF78
	add r1,r5,#0x0	; 0232DF7A
	add r2,r2,r4	; 0232DF7C
	add r3,r6,#0x0	; 0232DF7E
	bl loc_0232E214	; 0232DF80
	pop {r4,r5,r6}	; 0232DF84
	pop {r3}	; 0232DF86
	bx r3	; 0232DF88
loc_0232DF8A:
	add r0,r5,#0x0	; 0232DF8A
	add r1,r2,r4	; 0232DF8C
	add r2,r6,#0x0	; 0232DF8E
	blx loc_0232E304	; 0232DF90
	pop {r4,r5,r6}	; 0232DF94
	pop {r3}	; 0232DF96
	bx r3	; 0232DF98
	.byte 0xC0, 0x46	; 0232DF9C
pool_0232DF9C:
loc_0232DF9C:
	.word P1_Data_02330E6C	; 0232DF9C

; ===== function loc_0232DFA0 =====
P1_Entry_0232DFA0:
	push {r4,r5,r6,lr}	; 0232DFA0
	add r5,r0,#0x0	; 0232DFA2
	add r4,r1,#0x0	; 0232DFA4
	add r6,r2,#0x0	; 0232DFA6
	bl P1_GetMainBg0TilemapBase	; 0232DFA8
	add r2,r0,#0x0	; 0232DFAC
	ldr r0,[pool_0232DFDC]	; 0232DFAE
	ldr r0,[r0,#0x0]	; 0232DFB0
	mov r1,#0x0	; 0232DFB2
	mvn r1,r1	; 0232DFB4
	cmp r0,r1	; 0232DFB6
	beq loc_0232DFCA	; 0232DFB8
	add r1,r5,#0x0	; 0232DFBA
	add r2,r2,r4	; 0232DFBC
	add r3,r6,#0x0	; 0232DFBE
	bl loc_0232E214	; 0232DFC0
	pop {r4,r5,r6}	; 0232DFC4
	pop {r3}	; 0232DFC6
	bx r3	; 0232DFC8
loc_0232DFCA:
	add r0,r5,#0x0	; 0232DFCA
	add r1,r2,r4	; 0232DFCC
	add r2,r6,#0x0	; 0232DFCE
	blx loc_0232E304	; 0232DFD0
	pop {r4,r5,r6}	; 0232DFD4
	pop {r3}	; 0232DFD6
	bx r3	; 0232DFD8
	.byte 0xC0, 0x46	; 0232DFDC
pool_0232DFDC:
loc_0232DFDC:
	.word P1_Data_02330E6C	; 0232DFDC

; ===== function loc_0232DFE0 =====
loc_0232DFE0:
	push {r4,r5,r6,r7,lr}	; 0232DFE0
	sub sp,#0x4	; 0232DFE2
	add r5,r0,#0x0	; 0232DFE4
	add r4,r1,#0x0	; 0232DFE6
	add r3,r2,#0x0	; 0232DFE8
	ldr r7,[pool_0232E018]	; 0232DFEA
	ldr r1,[pool_0232E01C]	; 0232DFEC
	ldr r1,[r1,#0x0]	; 0232DFEE
	mov r6,#0x0	; 0232DFF0
	mvn r6,r6	; 0232DFF2
	cmp r1,r6	; 0232DFF4
	beq loc_0232E00A	; 0232DFF6
	add r0,r1,#0x0	; 0232DFF8
	add r1,r5,#0x0	; 0232DFFA
	add r2,r7,r4	; 0232DFFC
	bl loc_0232E254	; 0232DFFE
	add sp,#0x4	; 0232E002
	pop {r4,r5,r6,r7}	; 0232E004
	pop {r3}	; 0232E006
	bx r3	; 0232E008
loc_0232E00A:
	add r1,r7,r4	; 0232E00A
	blx loc_0232E334	; 0232E00C
	add sp,#0x4	; 0232E010
	pop {r4,r5,r6,r7}	; 0232E012
	pop {r3}	; 0232E014
	bx r3	; 0232E016
pool_0232E018:
loc_0232E018:
	.word 0x06600000	; 0232E018
pool_0232E01C:
loc_0232E01C:
	.word P1_Data_02330E6C	; 0232E01C

; ===== function loc_0232E020 =====
loc_0232E020:
	push {r4,r5,r6,r7,lr}	; 0232E020
	sub sp,#0x4	; 0232E022
	add r5,r0,#0x0	; 0232E024
	add r4,r1,#0x0	; 0232E026
	add r3,r2,#0x0	; 0232E028
	ldr r7,[pool_0232E058]	; 0232E02A
	ldr r1,[pool_0232E05C]	; 0232E02C
	ldr r1,[r1,#0x0]	; 0232E02E
	mov r6,#0x0	; 0232E030
	mvn r6,r6	; 0232E032
	cmp r1,r6	; 0232E034
	beq loc_0232E04A	; 0232E036
	add r0,r1,#0x0	; 0232E038
	add r1,r5,#0x0	; 0232E03A
	add r2,r7,r4	; 0232E03C
	bl loc_0232E254	; 0232E03E
	add sp,#0x4	; 0232E042
	pop {r4,r5,r6,r7}	; 0232E044
	pop {r3}	; 0232E046
	bx r3	; 0232E048
loc_0232E04A:
	add r1,r7,r4	; 0232E04A
	blx loc_0232E334	; 0232E04C
	add sp,#0x4	; 0232E050
	pop {r4,r5,r6,r7}	; 0232E052
	pop {r3}	; 0232E054
	bx r3	; 0232E056
pool_0232E058:
loc_0232E058:
	.word 0x06400000	; 0232E058
pool_0232E05C:
loc_0232E05C:
	.word P1_Data_02330E6C	; 0232E05C

; ===== function loc_0232E060 =====
loc_0232E060:
	push {r4,r5,r6,lr}	; 0232E060
	add r5,r0,#0x0	; 0232E062
	add r4,r1,#0x0	; 0232E064
	add r3,r2,#0x0	; 0232E066
	ldr r1,[pool_0232E094]	; 0232E068
	ldr r1,[r1,#0x0]	; 0232E06A
	mov r6,#0x0	; 0232E06C
	mvn r6,r6	; 0232E06E
	cmp r1,r6	; 0232E070
	beq loc_0232E086	; 0232E072
	add r0,r1,#0x0	; 0232E074
	add r1,r5,#0x0	; 0232E076
	ldr r2,[pool_0232E098]	; 0232E078
	add r2,r4,r2	; 0232E07A
	bl loc_0232E254	; 0232E07C
	pop {r4,r5,r6}	; 0232E080
	pop {r3}	; 0232E082
	bx r3	; 0232E084
loc_0232E086:
	ldr r1,[pool_0232E098]	; 0232E086
	add r1,r4,r1	; 0232E088
	blx loc_0232E334	; 0232E08A
	pop {r4,r5,r6}	; 0232E08E
	pop {r3}	; 0232E090
	bx r3	; 0232E092
pool_0232E094:
loc_0232E094:
	.word P1_Data_02330E6C	; 0232E094
pool_0232E098:
loc_0232E098:
	.word 0x07000400	; 0232E098

; ===== function loc_0232E09C =====
loc_0232E09C:
	push {r4,r5,r6,lr}	; 0232E09C
	add r5,r0,#0x0	; 0232E09E
	add r4,r1,#0x0	; 0232E0A0
	add r3,r2,#0x0	; 0232E0A2
	ldr r1,[pool_0232E0D0]	; 0232E0A4
	ldr r1,[r1,#0x0]	; 0232E0A6
	mov r6,#0x0	; 0232E0A8
	mvn r6,r6	; 0232E0AA
	cmp r1,r6	; 0232E0AC
	beq loc_0232E0C2	; 0232E0AE
	add r0,r1,#0x0	; 0232E0B0
	add r1,r5,#0x0	; 0232E0B2
	ldr r2,[pool_0232E0D4]	; 0232E0B4
	add r2,r4,r2	; 0232E0B6
	bl loc_0232E254	; 0232E0B8
	pop {r4,r5,r6}	; 0232E0BC
	pop {r3}	; 0232E0BE
	bx r3	; 0232E0C0
loc_0232E0C2:
	ldr r1,[pool_0232E0D4]	; 0232E0C2
	add r1,r4,r1	; 0232E0C4
	blx loc_0232E334	; 0232E0C6
	pop {r4,r5,r6}	; 0232E0CA
	pop {r3}	; 0232E0CC
	bx r3	; 0232E0CE
pool_0232E0D0:
loc_0232E0D0:
	.word P1_Data_02330E6C	; 0232E0D0
pool_0232E0D4:
loc_0232E0D4:
	.word 0x07000000	; 0232E0D4

; ===== function loc_0232E0D8 =====
loc_0232E0D8:
	push {r4,r5,r6,lr}	; 0232E0D8
	add r5,r0,#0x0	; 0232E0DA
	add r4,r1,#0x0	; 0232E0DC
	add r3,r2,#0x0	; 0232E0DE
	ldr r1,[pool_0232E10C]	; 0232E0E0
	ldr r1,[r1,#0x0]	; 0232E0E2
	mov r6,#0x0	; 0232E0E4
	mvn r6,r6	; 0232E0E6
	cmp r1,r6	; 0232E0E8
	beq loc_0232E0FE	; 0232E0EA
	add r0,r1,#0x0	; 0232E0EC
	add r1,r5,#0x0	; 0232E0EE
	ldr r2,[pool_0232E110]	; 0232E0F0
	add r2,r4,r2	; 0232E0F2
	bl loc_0232E214	; 0232E0F4
	pop {r4,r5,r6}	; 0232E0F8
	pop {r3}	; 0232E0FA
	bx r3	; 0232E0FC
loc_0232E0FE:
	ldr r1,[pool_0232E110]	; 0232E0FE
	add r1,r4,r1	; 0232E100
	blx loc_0232E304	; 0232E102
	pop {r4,r5,r6}	; 0232E106
	pop {r3}	; 0232E108
	bx r3	; 0232E10A
pool_0232E10C:
loc_0232E10C:
	.word P1_Data_02330E6C	; 0232E10C
pool_0232E110:
loc_0232E110:
	.word 0x05000600	; 0232E110

; ===== function loc_0232E114 =====
loc_0232E114:
	push {r4,r5,r6,lr}	; 0232E114
	add r5,r0,#0x0	; 0232E116
	add r4,r1,#0x0	; 0232E118
	add r3,r2,#0x0	; 0232E11A
	ldr r1,[pool_0232E148]	; 0232E11C
	ldr r1,[r1,#0x0]	; 0232E11E
	mov r6,#0x0	; 0232E120
	mvn r6,r6	; 0232E122
	cmp r1,r6	; 0232E124
	beq loc_0232E13A	; 0232E126
	add r0,r1,#0x0	; 0232E128
	add r1,r5,#0x0	; 0232E12A
	ldr r2,[pool_0232E14C]	; 0232E12C
	add r2,r4,r2	; 0232E12E
	bl loc_0232E214	; 0232E130
	pop {r4,r5,r6}	; 0232E134
	pop {r3}	; 0232E136
	bx r3	; 0232E138
loc_0232E13A:
	ldr r1,[pool_0232E14C]	; 0232E13A
	add r1,r4,r1	; 0232E13C
	blx loc_0232E304	; 0232E13E
	pop {r4,r5,r6}	; 0232E142
	pop {r3}	; 0232E144
	bx r3	; 0232E146
pool_0232E148:
loc_0232E148:
	.word P1_Data_02330E6C	; 0232E148
pool_0232E14C:
loc_0232E14C:
	.word 0x05000200	; 0232E14C

; ===== function loc_0232E150 =====
loc_0232E150:
	push {r4,r5,r6,lr}	; 0232E150
	add r5,r0,#0x0	; 0232E152
	add r4,r1,#0x0	; 0232E154
	add r3,r2,#0x0	; 0232E156
	ldr r1,[pool_0232E184]	; 0232E158
	ldr r1,[r1,#0x0]	; 0232E15A
	mov r6,#0x0	; 0232E15C
	mvn r6,r6	; 0232E15E
	cmp r1,r6	; 0232E160
	beq loc_0232E176	; 0232E162
	add r0,r1,#0x0	; 0232E164
	add r1,r5,#0x0	; 0232E166
	ldr r2,[pool_0232E188]	; 0232E168
	add r2,r4,r2	; 0232E16A
	bl loc_0232E214	; 0232E16C
	pop {r4,r5,r6}	; 0232E170
	pop {r3}	; 0232E172
	bx r3	; 0232E174
loc_0232E176:
	ldr r1,[pool_0232E188]	; 0232E176
	add r1,r4,r1	; 0232E178
	blx loc_0232E304	; 0232E17A
	pop {r4,r5,r6}	; 0232E17E
	pop {r3}	; 0232E180
	bx r3	; 0232E182
pool_0232E184:
loc_0232E184:
	.word P1_Data_02330E6C	; 0232E184
pool_0232E188:
loc_0232E188:
	.word 0x05000400	; 0232E188

; ===== function loc_0232E18C =====
loc_0232E18C:
	push {r4,r5,r6,lr}	; 0232E18C
	add r5,r0,#0x0	; 0232E18E
	add r4,r1,#0x0	; 0232E190
	add r3,r2,#0x0	; 0232E192
	ldr r1,[pool_0232E1C0]	; 0232E194
	ldr r1,[r1,#0x0]	; 0232E196
	mov r6,#0x0	; 0232E198
	mvn r6,r6	; 0232E19A
	cmp r1,r6	; 0232E19C
	beq loc_0232E1B2	; 0232E19E
	add r0,r1,#0x0	; 0232E1A0
	add r1,r5,#0x0	; 0232E1A2
	ldr r2,[pool_0232E1C4]	; 0232E1A4
	add r2,r4,r2	; 0232E1A6
	bl loc_0232E214	; 0232E1A8
	pop {r4,r5,r6}	; 0232E1AC
	pop {r3}	; 0232E1AE
	bx r3	; 0232E1B0
loc_0232E1B2:
	ldr r1,[pool_0232E1C4]	; 0232E1B2
	add r1,r4,r1	; 0232E1B4
	blx loc_0232E304	; 0232E1B6
	pop {r4,r5,r6}	; 0232E1BA
	pop {r3}	; 0232E1BC
	bx r3	; 0232E1BE
pool_0232E1C0:
loc_0232E1C0:
	.word P1_Data_02330E6C	; 0232E1C0
pool_0232E1C4:
loc_0232E1C4:
	.word 0x05000000	; 0232E1C4

; ===== function loc_0232E1C8 =====
loc_0232E1C8:
	ldr r1,[pool_0232E1D0]	; 0232E1C8
	strb r0,[r1,#0x0]	; 0232E1CA
	bx lr	; 0232E1CC
	.byte 0xC0, 0x46	; 0232E1D0
pool_0232E1D0:
loc_0232E1D0:
	.word REG_WRAMCNT	; 0232E1D0

; ===== function loc_0232E1D4 =====
loc_0232E1D4:
	push {r4,lr}	; 0232E1D4
	add r4,r0,#0x0	; 0232E1D6
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E1D8
	mov r1,#0x6	; 0232E1DC
	mul r4,r1	; 0232E1DE
	add r1,r4,#0x5	; 0232E1E0
	lsl r2,r1,#0x1	; 0232E1E2
	ldr r1,[pool_0232E208]	; 0232E1E4
	add r3,r2,r1	; 0232E1E6
	ldrh r2,[r3,#0x0]	; 0232E1E8
	ldr r1,[pool_0232E20C]	; 0232E1EA
	and r2,r1	; 0232E1EC
	strh r2,[r3,#0x0]	; 0232E1EE
	ldrh r2,[r3,#0x0]	; 0232E1F0
	ldr r1,[pool_0232E210]	; 0232E1F2
	and r2,r1	; 0232E1F4
	strh r2,[r3,#0x0]	; 0232E1F6
	ldrh r1,[r3,#0x0]	; 0232E1F8
	ldrh r1,[r3,#0x0]	; 0232E1FA
	blx P1_Arm9RestoreIrqMask	; 0232E1FC
	pop {r4}	; 0232E200
	pop {r3}	; 0232E202
	bx r3	; 0232E204
	.byte 0xC0, 0x46	; 0232E208
pool_0232E208:
loc_0232E208:
	.word REG_DMA0SAD	; 0232E208
pool_0232E20C:
loc_0232E20C:
	.word 0xFFFFC5FF	; 0232E20C
pool_0232E210:
loc_0232E210:
	.word 0xFFFF7FFF	; 0232E210

; ===== function loc_0232E214 =====
loc_0232E214:
	push {r4,r5,r6,lr}	; 0232E214
	cmp r3,#0x0	; 0232E216
	beq loc_0232E246	; 0232E218
	mov r4,#0x3	; 0232E21A
	add r5,r0,#0x0	; 0232E21C
	mul r5,r4	; 0232E21E
	add r4,r5,#0x2	; 0232E220
	lsl r5,r4,#0x2	; 0232E222
	ldr r4,[pool_0232E24C]	; 0232E224
	add r4,r5,r4	; 0232E226
	ldr r5,[pool_0232E250]	; 0232E228
loc_0232E22A:
	ldr r6,[r4,#0x0]	; 0232E22A
	and r6,r5	; 0232E22C
	cmp r6,#0x0	; 0232E22E
	bne loc_0232E22A	; 0232E230
	lsr r3,r3,#0x1	; 0232E232
	ldr r5,[pool_0232E250]	; 0232E234
	orr r3,r5	; 0232E236
	bl P1_SetDmaChannelRegisters	; 0232E238
	lsl r0,r5,#0	; 0232E23C
loc_0232E23E:
	ldr r1,[r4,#0x0]	; 0232E23E
	and r1,r0	; 0232E240
	cmp r1,#0x0	; 0232E242
	bne loc_0232E23E	; 0232E244
loc_0232E246:
	pop {r4,r5,r6}	; 0232E246
	pop {r3}	; 0232E248
	bx r3	; 0232E24A
pool_0232E24C:
loc_0232E24C:
	.word REG_DMA0SAD	; 0232E24C
pool_0232E250:
loc_0232E250:
	.word 0x80000000	; 0232E250

; ===== function loc_0232E254 =====
loc_0232E254:
	push {r4,r5,r6,lr}	; 0232E254
	cmp r3,#0x0	; 0232E256
	beq loc_0232E286	; 0232E258
	mov r4,#0x3	; 0232E25A
	add r5,r0,#0x0	; 0232E25C
	mul r5,r4	; 0232E25E
	add r4,r5,#0x2	; 0232E260
	lsl r5,r4,#0x2	; 0232E262
	ldr r4,[pool_0232E28C]	; 0232E264
	add r4,r5,r4	; 0232E266
	ldr r5,[pool_0232E290]	; 0232E268
loc_0232E26A:
	ldr r6,[r4,#0x0]	; 0232E26A
	and r6,r5	; 0232E26C
	cmp r6,#0x0	; 0232E26E
	bne loc_0232E26A	; 0232E270
	lsr r3,r3,#0x2	; 0232E272
	ldr r5,[pool_0232E294]	; 0232E274
	orr r3,r5	; 0232E276
	bl P1_SetDmaChannelRegisters	; 0232E278
	ldr r0,[pool_0232E290]	; 0232E27C
loc_0232E27E:
	ldr r1,[r4,#0x0]	; 0232E27E
	and r1,r0	; 0232E280
	cmp r1,#0x0	; 0232E282
	bne loc_0232E27E	; 0232E284
loc_0232E286:
	pop {r4,r5,r6}	; 0232E286
	pop {r3}	; 0232E288
	bx r3	; 0232E28A
pool_0232E28C:
loc_0232E28C:
	.word REG_DMA0SAD	; 0232E28C
pool_0232E290:
loc_0232E290:
	.word 0x80000000	; 0232E290
pool_0232E294:
loc_0232E294:
	.word 0x84000000	; 0232E294

; ===== function loc_0232E298 =====
loc_0232E298:
	push {r4,r5,r6,lr}	; 0232E298
	add r5,r1,#0x0	; 0232E29A
	cmp r3,#0x0	; 0232E29C
	beq loc_0232E2D6	; 0232E29E
	mov r1,#0x3	; 0232E2A0
	add r4,r0,#0x0	; 0232E2A2
	mul r4,r1	; 0232E2A4
	add r1,r4,#0x2	; 0232E2A6
	lsl r4,r1,#0x2	; 0232E2A8
	ldr r1,[pool_0232E2DC]	; 0232E2AA
	add r4,r4,r1	; 0232E2AC
	ldr r1,[pool_0232E2E0]	; 0232E2AE
loc_0232E2B0:
	ldr r6,[r4,#0x0]	; 0232E2B0
	and r6,r1	; 0232E2B2
	cmp r6,#0x0	; 0232E2B4
	bne loc_0232E2B0	; 0232E2B6
	lsl r6,r0,#0x2	; 0232E2B8
	ldr r1,[pool_0232E2E4]	; 0232E2BA
	add r1,r6,r1	; 0232E2BC
	str r2,[r1,#0x0]	; 0232E2BE
	add r2,r5,#0x0	; 0232E2C0
	lsr r3,r3,#0x2	; 0232E2C2
	ldr r5,[pool_0232E2E8]	; 0232E2C4
	orr r3,r5	; 0232E2C6
	bl P1_SetDmaChannelRegisters	; 0232E2C8
	ldr r0,[pool_0232E2E0]	; 0232E2CC
loc_0232E2CE:
	ldr r1,[r4,#0x0]	; 0232E2CE
	and r1,r0	; 0232E2D0
	cmp r1,#0x0	; 0232E2D2
	bne loc_0232E2CE	; 0232E2D4
loc_0232E2D6:
	pop {r4,r5,r6}	; 0232E2D6
	pop {r3}	; 0232E2D8
	bx r3	; 0232E2DA
pool_0232E2DC:
loc_0232E2DC:
	.word REG_DMA0SAD	; 0232E2DC
pool_0232E2E0:
loc_0232E2E0:
	.word 0x80000000	; 0232E2E0
pool_0232E2E4:
loc_0232E2E4:
	.word 0x040000E0	; 0232E2E4
pool_0232E2E8:
loc_0232E2E8:
	.word 0x85000000	; 0232E2E8
.arm

; ===== function loc_0232E2EC =====
loc_0232E2EC:
	mov r3,#0x0	; 0232E2EC
loc_0232E2F0:
	cmp r3,r2	; 0232E2F0
	strlth r0,[r1,r3]	; 0232E2F4
	addlt r3,r3,#0x2	; 0232E2F8
	blt loc_0232E2F0	; 0232E2FC
	bx lr	; 0232E300

; ===== function loc_0232E304 =====
loc_0232E304:
	mov r12,#0x0	; 0232E304
loc_0232E308:
	cmp r12,r2	; 0232E308
	ldrlth r3,[r0,r12]	; 0232E30C
	strlth r3,[r1,r12]	; 0232E310
	addlt r12,r12,#0x2	; 0232E314
	blt loc_0232E308	; 0232E318
	bx lr	; 0232E31C

; ===== function loc_0232E320 =====
; r0=填充值，r1=目标，r2=字节数；按 32 位字写入。
; r0=value, r1=destination, r2=byte count; fills in 32-bit words.
P1_MemFill32:
loc_0232E320:
	add r12,r1,r2	; 0232E320
loc_0232E324:
	cmp r1,r12	; 0232E324
	stmltia r1!,{r0}	; 0232E328
	blt loc_0232E324	; 0232E32C
	bx lr	; 0232E330

; ===== function loc_0232E334 =====
; r0=源，r1=目标，r2=字节数；按 32 位字复制。
; r0=source, r1=destination, r2=byte count; copies 32-bit words.
P1_MemCopy32:
loc_0232E334:
	add r12,r1,r2	; 0232E334
loc_0232E338:
	cmp r1,r12	; 0232E338
	ldmltia r0!,{r2}	; 0232E33C
	stmltia r1!,{r2}	; 0232E340
	blt loc_0232E338	; 0232E344
	bx lr	; 0232E348

; ===== function loc_0232E34C =====
loc_0232E34C:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 0232E34C
	add r9,r1,r2	; 0232E350
	mov r12,r2, lsr #0x5	; 0232E354
	add r12,r1,r12, lsl #0x5	; 0232E358
	mov r2,r0	; 0232E35C
	mov r3,r2	; 0232E360
	mov r4,r2	; 0232E364
	mov r5,r2	; 0232E368
	mov r6,r2	; 0232E36C
	mov r7,r2	; 0232E370
	mov r8,r2	; 0232E374
loc_0232E378:
	cmp r1,r12	; 0232E378
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 0232E37C
	blt loc_0232E378	; 0232E380
loc_0232E384:
	cmp r1,r9	; 0232E384
	stmltia r1!,{r0}	; 0232E388
	blt loc_0232E384	; 0232E38C
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 0232E390
	bx lr	; 0232E394

; ===== function loc_0232E398 =====
loc_0232E398:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232E398
	add r10,r1,r2	; 0232E39C
	mov r12,r2, lsr #0x5	; 0232E3A0
	add r12,r1,r12, lsl #0x5	; 0232E3A4
loc_0232E3A8:
	cmp r1,r12	; 0232E3A8
	ldmltia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232E3AC
	stmltia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232E3B0
	blt loc_0232E3A8	; 0232E3B4
loc_0232E3B8:
	cmp r1,r10	; 0232E3B8
	ldmltia r0!,{r2}	; 0232E3BC
	stmltia r1!,{r2}	; 0232E3C0
	blt loc_0232E3B8	; 0232E3C4
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232E3C8
	bx lr	; 0232E3CC

; ===== function loc_0232E3D0 =====
loc_0232E3D0:
	mov r12,#0x0	; 0232E3D0
loc_0232E3D4:
	cmp r12,r2	; 0232E3D4
	strltb r1,[r0,r12]	; 0232E3D8
	addlt r12,r12,#0x1	; 0232E3DC
	blt loc_0232E3D4	; 0232E3E0
	bx lr	; 0232E3E4
P1_Entry_0232E3E8:
	mov r12,#0x0	; 0232E3E8
P1_Entry_0232E3EC:
	cmp r12,r2	; 0232E3EC
	ldrltb r3,[r0,r12]	; 0232E3F0
	strltb r3,[r1,r12]	; 0232E3F4
	addlt r12,r12,#0x1	; 0232E3F8
	blt P1_Entry_0232E3EC	; 0232E3FC
	bx lr	; 0232E400

; ===== function loc_0232E404 =====
loc_0232E404:
	swp r0,r0,[r1]	; 0232E404
	bx lr	; 0232E408
.thumb

; ===== function loc_0232E40C =====
loc_0232E40C:
	push {lr}	; 0232E40C
	sub sp,#0x4	; 0232E40E
	ldr r0,[pool_0232E42C]	; 0232E410
	ldr r1,[r0,#0x0]	; 0232E412
	cmp r1,#0x0	; 0232E414
	bne loc_0232E424	; 0232E416
	mov r1,#0x1	; 0232E418
	str r1,[r0,#0x0]	; 0232E41A
	bl loc_0232EA40	; 0232E41C
	bl loc_0232EB64	; 0232E420
loc_0232E424:
	add sp,#0x4	; 0232E424
	pop {r3}	; 0232E426
	bx r3	; 0232E428
	.byte 0xC0, 0x46	; 0232E42C
pool_0232E42C:
loc_0232E42C:
	.word P1_BssStart + 0x266C4	; 0232E42C

; ===== function loc_0232E430 =====
loc_0232E430:
	push {r4,r5,r6,r7,lr}	; 0232E430
	sub sp,#0x4	; 0232E432
	add r5,r0,#0x0	; 0232E434
	add r4,r1,#0x0	; 0232E436
	add r6,r2,#0x0	; 0232E438
	add r7,r3,#0x0	; 0232E43A
	mov r0,#0x1	; 0232E43C
	bl loc_0232E944	; 0232E43E
	cmp r0,#0x0	; 0232E442
	beq loc_0232E456	; 0232E444
	str r5,[r0,#0x4]	; 0232E446
	str r4,[r0,#0x8]	; 0232E448
	str r6,[r0,#0xc]	; 0232E44A
	str r7,[r0,#0x10]	; 0232E44C
	ldr r1,[sp,#0x18]	; 0232E44E
	str r1,[r0,#0x14]	; 0232E450
	bl loc_0232E920	; 0232E452
loc_0232E456:
	add sp,#0x4	; 0232E456
	pop {r4,r5,r6,r7}	; 0232E458
	pop {r3}	; 0232E45A
	bx r3	; 0232E45C
	.byte 0x00, 0x00	; 0232E460

; ===== function loc_0232E460 =====
loc_0232E460:
	push {lr}	; 0232E460
	sub sp,#0x4	; 0232E462
	add r1,r0,#0x0	; 0232E464
	mov r2,#0x0	; 0232E466
	str r2,[sp,#0x0]	; 0232E468
	mov r0,#0x13	; 0232E46A
	add r3,r2,#0x0	; 0232E46C
	bl loc_0232E430	; 0232E46E
	add sp,#0x4	; 0232E472
	pop {r3}	; 0232E474
	bx r3	; 0232E476

; ===== function loc_0232E478 =====
loc_0232E478:
	push {r4,r5,r6,lr}	; 0232E478
	sub sp,#0x8	; 0232E47A
	add r6,r0,#0x0	; 0232E47C
	add r5,r1,#0x0	; 0232E47E
	add r4,r2,#0x0	; 0232E480
	str r3,[sp,#0x0]	; 0232E482
	mov r0,#0x4	; 0232E484
	ldr r1,[sp,#0x18]	; 0232E486
	lsl r1,r1,#0x18	; 0232E488
	orr r1,r6	; 0232E48A
	add r2,r5,#0x0	; 0232E48C
	add r3,r4,#0x0	; 0232E48E
	bl loc_0232E430	; 0232E490
	add sp,#0x8	; 0232E494
	pop {r4,r5,r6}	; 0232E496
	pop {r3}	; 0232E498
	bx r3	; 0232E49A

; ===== function loc_0232E49C =====
loc_0232E49C:
	push {r4,r5,r6,lr}	; 0232E49C
	sub sp,#0x8	; 0232E49E
	add r6,r0,#0x0	; 0232E4A0
	add r5,r1,#0x0	; 0232E4A2
	add r4,r2,#0x0	; 0232E4A4
	str r3,[sp,#0x0]	; 0232E4A6
	mov r0,#0x3	; 0232E4A8
	add r1,r6,#0x0	; 0232E4AA
	add r2,r5,#0x0	; 0232E4AC
	add r3,r4,#0x0	; 0232E4AE
	bl loc_0232E430	; 0232E4B0
	add sp,#0x8	; 0232E4B4
	pop {r4,r5,r6}	; 0232E4B6
	pop {r3}	; 0232E4B8
	bx r3	; 0232E4BA

; ===== function loc_0232E4BC =====
loc_0232E4BC:
	push {r4,r5,r6,lr}	; 0232E4BC
	sub sp,#0x8	; 0232E4BE
	add r6,r0,#0x0	; 0232E4C0
	add r5,r1,#0x0	; 0232E4C2
	add r4,r2,#0x0	; 0232E4C4
	str r3,[sp,#0x0]	; 0232E4C6
	mov r0,#0x15	; 0232E4C8
	add r1,r6,#0x0	; 0232E4CA
	add r2,r5,#0x0	; 0232E4CC
	add r3,r4,#0x0	; 0232E4CE
	bl loc_0232E430	; 0232E4D0
	add sp,#0x8	; 0232E4D4
	pop {r4,r5,r6}	; 0232E4D6
	pop {r3}	; 0232E4D8
	bx r3	; 0232E4DA

; ===== function loc_0232E4DC =====
loc_0232E4DC:
	push {r4,r5,lr}	; 0232E4DC
	sub sp,#0x4	; 0232E4DE
	add r5,r0,#0x0	; 0232E4E0
	ldr r4,[sp,#0x10]	; 0232E4E2
	ldr r0,[sp,#0x24]	; 0232E4E4
	lsl r0,r0,#0x10	; 0232E4E6
	lsl r3,r3,#0x1a	; 0232E4E8
	lsl r1,r1,#0x18	; 0232E4EA
	orr r3,r1	; 0232E4EC
	orr r0,r3	; 0232E4EE
	orr r4,r0	; 0232E4F0
	str r4,[sp,#0x0]	; 0232E4F2
	mov r0,#0xb	; 0232E4F4
	ldr r1,[sp,#0x20]	; 0232E4F6
	lsl r1,r1,#0x10	; 0232E4F8
	orr r1,r5	; 0232E4FA
	ldr r3,[sp,#0x14]	; 0232E4FC
	ldr r4,[sp,#0x18]	; 0232E4FE
	lsl r5,r4,#0x18	; 0232E500
	ldr r4,[sp,#0x1c]	; 0232E502
	lsl r4,r4,#0x16	; 0232E504
	orr r5,r4	; 0232E506
	orr r3,r5	; 0232E508
	bl loc_0232E430	; 0232E50A
	add sp,#0x4	; 0232E50E
	pop {r4,r5}	; 0232E510
	pop {r3}	; 0232E512
	bx r3	; 0232E514
	.byte 0x00, 0x00	; 0232E518

; ===== function loc_0232E518 =====
loc_0232E518:
	push {r4,r5,lr}	; 0232E518
	sub sp,#0x4	; 0232E51A
	add r5,r0,#0x0	; 0232E51C
	add r4,r1,#0x0	; 0232E51E
	add r3,r2,#0x0	; 0232E520
	mov r0,#0x0	; 0232E522
	str r0,[sp,#0x0]	; 0232E524
	mov r0,#0x11	; 0232E526
	add r1,r5,#0x0	; 0232E528
	add r2,r4,#0x0	; 0232E52A
	bl loc_0232E430	; 0232E52C
	add sp,#0x4	; 0232E530
	pop {r4,r5}	; 0232E532
	pop {r3}	; 0232E534
	bx r3	; 0232E536

; ===== function loc_0232E538 =====
loc_0232E538:
	push {r4,lr}	; 0232E538
	sub sp,#0x8	; 0232E53A
	add r4,r0,#0x0	; 0232E53C
	add r2,r1,#0x0	; 0232E53E
	mov r3,#0x0	; 0232E540
	str r3,[sp,#0x0]	; 0232E542
	mov r0,#0x17	; 0232E544
	add r1,r4,#0x0	; 0232E546
	bl loc_0232E430	; 0232E548
	add sp,#0x8	; 0232E54C
	pop {r4}	; 0232E54E
	pop {r3}	; 0232E550
	bx r3	; 0232E552

; ===== function loc_0232E554 =====
loc_0232E554:
	push {r4,lr}	; 0232E554
	sub sp,#0x8	; 0232E556
	add r4,r0,#0x0	; 0232E558
	add r2,r1,#0x0	; 0232E55A
	mov r3,#0x0	; 0232E55C
	str r3,[sp,#0x0]	; 0232E55E
	mov r0,#0x16	; 0232E560
	add r1,r4,#0x0	; 0232E562
	bl loc_0232E430	; 0232E564
	add sp,#0x8	; 0232E568
	pop {r4}	; 0232E56A
	pop {r3}	; 0232E56C
	bx r3	; 0232E56E

; ===== function loc_0232E570 =====
loc_0232E570:
	push {r4,r5,r6,lr}	; 0232E570
	sub sp,#0x8	; 0232E572
	add r5,r0,#0x0	; 0232E574
	add r4,r1,#0x0	; 0232E576
	add r6,r2,#0x0	; 0232E578
	add r1,r3,#0x0	; 0232E57A
	ldr r2,[sp,#0x18]	; 0232E57C
	bl loc_0232EB24	; 0232E57E
	str r0,[sp,#0x0]	; 0232E582
	mov r0,#0xf	; 0232E584
	add r1,r5,#0x0	; 0232E586
	add r2,r4,#0x0	; 0232E588
	add r3,r6,#0x0	; 0232E58A
	bl loc_0232E430	; 0232E58C
	add sp,#0x8	; 0232E590
	pop {r4,r5,r6}	; 0232E592
	pop {r3}	; 0232E594
	bx r3	; 0232E596

; ===== function loc_0232E598 =====
loc_0232E598:
	push {r4,r5,r6,r7,lr}	; 0232E598
	sub sp,#0xc	; 0232E59A
	add r6,r0,#0x0	; 0232E59C
	str r1,[sp,#0x4]	; 0232E59E
	mov r0,#0x0	; 0232E5A0
	str r0,[sp,#0x0]	; 0232E5A2
	mov r0,#0xe	; 0232E5A4
	add r1,r2,#0x0	; 0232E5A6
	add r2,r3,#0x0	; 0232E5A8
	ldr r3,[sp,#0x28]	; 0232E5AA
	lsl r7,r3,#0x1b	; 0232E5AC
	ldr r3,[sp,#0x24]	; 0232E5AE
	lsl r5,r3,#0x1c	; 0232E5B0
	ldr r3,[sp,#0x20]	; 0232E5B2
	lsl r4,r3,#0x1d	; 0232E5B4
	lsl r3,r6,#0x1f	; 0232E5B6
	ldr r6,[sp,#0x4]	; 0232E5B8
	lsl r6,r6,#0x1e	; 0232E5BA
	orr r3,r6	; 0232E5BC
	orr r4,r3	; 0232E5BE
	orr r5,r4	; 0232E5C0
	orr r7,r5	; 0232E5C2
	add r3,r7,#0x0	; 0232E5C4
	bl loc_0232E430	; 0232E5C6
	add sp,#0xc	; 0232E5CA
	pop {r4,r5,r6,r7}	; 0232E5CC
	pop {r3}	; 0232E5CE
	bx r3	; 0232E5D0
	.byte 0x00, 0x00	; 0232E5D4

; ===== function loc_0232E5D4 =====
loc_0232E5D4:
	push {r4,r5,r6,r7,lr}	; 0232E5D4
	sub sp,#0x14	; 0232E5D6
	str r0,[sp,#0x4]	; 0232E5D8
	str r1,[sp,#0x8]	; 0232E5DA
	add r7,r2,#0x0	; 0232E5DC
	str r3,[sp,#0xc]	; 0232E5DE
	add r4,r7,#0x0	; 0232E5E0
	mov r5,#0x0	; 0232E5E2
	mov r6,#0x1	; 0232E5E4
	b loc_0232E5FA	; 0232E5E6
loc_0232E5E8:
	add r0,r4,#0x0	; 0232E5E8
	and r0,r6	; 0232E5EA
	cmp r0,#0x0	; 0232E5EC
	beq loc_0232E5F6	; 0232E5EE
	add r0,r5,#0x0	; 0232E5F0
	bl loc_0232EB4C	; 0232E5F2
loc_0232E5F6:
	add r5,r5,#0x1	; 0232E5F6
	lsr r4,r4,#0x1	; 0232E5F8
loc_0232E5FA:
	cmp r5,#0x8	; 0232E5FA
	bge loc_0232E602	; 0232E5FC
	cmp r4,#0x0	; 0232E5FE
	bne loc_0232E5E8	; 0232E600
loc_0232E602:
	ldr r0,[sp,#0xc]	; 0232E602
	str r0,[sp,#0x0]	; 0232E604
	mov r0,#0xa	; 0232E606
	ldr r1,[sp,#0x4]	; 0232E608
	ldr r2,[sp,#0x8]	; 0232E60A
	add r3,r7,#0x0	; 0232E60C
	bl loc_0232E430	; 0232E60E
	add sp,#0x14	; 0232E612
	pop {r4,r5,r6,r7}	; 0232E614
	pop {r3}	; 0232E616
	bx r3	; 0232E618
	.byte 0x00, 0x00	; 0232E61C

; ===== function loc_0232E61C =====
loc_0232E61C:
	push {r4,r5,r6,lr}	; 0232E61C
	sub sp,#0x8	; 0232E61E
	add r6,r0,#0x0	; 0232E620
	add r5,r1,#0x0	; 0232E622
	add r4,r2,#0x0	; 0232E624
	str r3,[sp,#0x0]	; 0232E626
	mov r0,#0x9	; 0232E628
	add r1,r6,#0x0	; 0232E62A
	add r2,r5,#0x0	; 0232E62C
	add r3,r4,#0x0	; 0232E62E
	bl loc_0232E430	; 0232E630
	add sp,#0x8	; 0232E634
	pop {r4,r5,r6}	; 0232E636
	pop {r3}	; 0232E638
	bx r3	; 0232E63A

; ===== function loc_0232E63C =====
loc_0232E63C:
	push {lr}	; 0232E63C
	sub sp,#0x4	; 0232E63E
	add r3,r2,#0x0	; 0232E640
	mov r2,#0x1	; 0232E642
	str r2,[sp,#0x0]	; 0232E644
	mov r2,#0x1a	; 0232E646
	bl loc_0232E478	; 0232E648
	add sp,#0x4	; 0232E64C
	pop {r3}	; 0232E64E
	bx r3	; 0232E650
	.byte 0x00, 0x00	; 0232E654

; ===== function loc_0232E654 =====
loc_0232E654:
	push {lr}	; 0232E654
	sub sp,#0x4	; 0232E656
	add r3,r2,#0x0	; 0232E658
	mov r2,#0x2	; 0232E65A
	str r2,[sp,#0x0]	; 0232E65C
	mov r2,#0xc	; 0232E65E
	bl loc_0232E478	; 0232E660
	add sp,#0x4	; 0232E664
	pop {r3}	; 0232E666
	bx r3	; 0232E668
	.byte 0x00, 0x00	; 0232E66C

; ===== function loc_0232E66C =====
loc_0232E66C:
	push {lr}	; 0232E66C
	sub sp,#0x4	; 0232E66E
	add r2,r1,#0x0	; 0232E670
	mov r1,#0x4	; 0232E672
	mov r3,#0x1	; 0232E674
	bl loc_0232E49C	; 0232E676
	add sp,#0x4	; 0232E67A
	pop {r3}	; 0232E67C
	bx r3	; 0232E67E

; ===== function loc_0232E680 =====
loc_0232E680:
	push {lr}	; 0232E680
	sub sp,#0x4	; 0232E682
	add r2,r1,#0x0	; 0232E684
	mov r1,#0x6	; 0232E686
	mov r3,#0x2	; 0232E688
	bl loc_0232E49C	; 0232E68A
	add sp,#0x4	; 0232E68E
	pop {r3}	; 0232E690
	bx r3	; 0232E692

; ===== function loc_0232E694 =====
loc_0232E694:
	push {lr}	; 0232E694
	sub sp,#0x4	; 0232E696
	add r1,r0,#0x0	; 0232E698
	mov r2,#0x0	; 0232E69A
	str r2,[sp,#0x0]	; 0232E69C
	mov r0,#0x1	; 0232E69E
	add r3,r2,#0x0	; 0232E6A0
	bl loc_0232E430	; 0232E6A2
	add sp,#0x4	; 0232E6A6
	pop {r3}	; 0232E6A8
	bx r3	; 0232E6AA

; ===== function loc_0232E6AC =====
loc_0232E6AC:
	push {r4,r5,r6,lr}	; 0232E6AC
	sub sp,#0x8	; 0232E6AE
	add r6,r0,#0x0	; 0232E6B0
	add r5,r1,#0x0	; 0232E6B2
	add r4,r2,#0x0	; 0232E6B4
	str r3,[sp,#0x0]	; 0232E6B6
	mov r0,#0x0	; 0232E6B8
	add r1,r6,#0x0	; 0232E6BA
	add r2,r5,#0x0	; 0232E6BC
	add r3,r4,#0x0	; 0232E6BE
	bl loc_0232E430	; 0232E6C0
	add sp,#0x8	; 0232E6C4
	pop {r4,r5,r6}	; 0232E6C6
	pop {r3}	; 0232E6C8
	bx r3	; 0232E6CA

; ===== function loc_0232E6CC =====
loc_0232E6CC:
	ldr r1,[pool_0232E6E8]	; 0232E6CC
	ldr r0,[r1,#0x0]	; 0232E6CE
	cmp r0,#0x0	; 0232E6D0
	bne loc_0232E6D8	; 0232E6D2
	mov r0,#0x0	; 0232E6D4
	bx lr	; 0232E6D6
loc_0232E6D8:
	ldr r2,[r0,#0x0]	; 0232E6D8
	str r2,[r1,#0x0]	; 0232E6DA
	cmp r2,#0x0	; 0232E6DC
	bne loc_0232E6E6	; 0232E6DE
	mov r2,#0x0	; 0232E6E0
	ldr r1,[pool_0232E6EC]	; 0232E6E2
	str r2,[r1,#0x0]	; 0232E6E4
loc_0232E6E6:
	bx lr	; 0232E6E6
pool_0232E6E8:
loc_0232E6E8:
	.word P1_BssStart + 0x266C8	; 0232E6E8
pool_0232E6EC:
loc_0232E6EC:
	.word P1_BssStart + 0x266D8	; 0232E6EC

; ===== function loc_0232E6F0 =====
loc_0232E6F0:
	push {r4,r5,lr}	; 0232E6F0
	sub sp,#0x4	; 0232E6F2
	mov r5,#0x7	; 0232E6F4
	mov r4,#0x0	; 0232E6F6
loc_0232E6F8:
	add r0,r5,#0x0	; 0232E6F8
	add r1,r4,#0x0	; 0232E6FA
	add r2,r4,#0x0	; 0232E6FC
	bl loc_0232ED98	; 0232E6FE
	cmp r0,#0x0	; 0232E702
	blt loc_0232E6F8	; 0232E704
	add sp,#0x4	; 0232E706
	pop {r4,r5}	; 0232E708
	pop {r3}	; 0232E70A
	bx r3	; 0232E70C
	.byte 0x00, 0x00	; 0232E710

; ===== function loc_0232E710 =====
loc_0232E710:
	push {r4,r5,r6,lr}	; 0232E710
	mov r0,#0x7	; 0232E712
	ldr r1,[pool_0232E74C]	; 0232E714
	bl loc_0232EE58	; 0232E716
	bl loc_0232B624	; 0232E71A
	cmp r0,#0x0	; 0232E71E
	bne loc_0232E746	; 0232E720
	mov r0,#0x7	; 0232E722
	mov r1,#0x1	; 0232E724
	bl loc_0232EE2C	; 0232E726
	cmp r0,#0x0	; 0232E72A
	bne loc_0232E746	; 0232E72C
	mov r5,#0x64	; 0232E72E
	mov r4,#0x7	; 0232E730
	mov r6,#0x1	; 0232E732
loc_0232E734:
	add r0,r5,#0x0	; 0232E734
	blx P1_Arm9BusyWaitByLoop4	; 0232E736
	add r0,r4,#0x0	; 0232E73A
	add r1,r6,#0x0	; 0232E73C
	bl loc_0232EE2C	; 0232E73E
	cmp r0,#0x0	; 0232E742
	beq loc_0232E734	; 0232E744
loc_0232E746:
	pop {r4,r5,r6}	; 0232E746
	pop {r3}	; 0232E748
	bx r3	; 0232E74A
pool_0232E74C:
loc_0232E74C:
	.word 0x0232E751	; 0232E74C

; ===== function loc_0232E750 =====
	push {r4,r5,lr}	; 0232E750
	sub sp,#0x4	; 0232E752
	add r5,r1,#0x0	; 0232E754
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E756
	add r4,r0,#0x0	; 0232E75A
	add r0,r5,#0x0	; 0232E75C
	bl loc_0232EAF4	; 0232E75E
	add r0,r4,#0x0	; 0232E762
	blx P1_Arm9RestoreIrqMask	; 0232E764
	add sp,#0x4	; 0232E768
	pop {r4,r5}	; 0232E76A
	pop {r3}	; 0232E76C
	bx r3	; 0232E76E

; ===== function loc_0232E770 =====
loc_0232E770:
	push {r4,lr}	; 0232E770
	bl loc_0232E7A4	; 0232E772
	add r4,r0,#0x0	; 0232E776
	bl loc_0232E78C	; 0232E778
	ldr r1,[pool_0232E788]	; 0232E77C
	sub r1,r1,r4	; 0232E77E
	sub r0,r1,r0	; 0232E780
	pop {r4}	; 0232E782
	pop {r3}	; 0232E784
	bx r3	; 0232E786
pool_0232E788:
loc_0232E788:
	.word 0x00000100	; 0232E788

; ===== function loc_0232E78C =====
loc_0232E78C:
	ldr r0,[pool_0232E7A0]	; 0232E78C
	ldr r1,[r0,#0x0]	; 0232E78E
	mov r0,#0x0	; 0232E790
	cmp r1,#0x0	; 0232E792
	beq loc_0232E79E	; 0232E794
loc_0232E796:
	add r0,r0,#0x1	; 0232E796
	ldr r1,[r1,#0x0]	; 0232E798
	cmp r1,#0x0	; 0232E79A
	bne loc_0232E796	; 0232E79C
loc_0232E79E:
	bx lr	; 0232E79E
pool_0232E7A0:
loc_0232E7A0:
	.word P1_BssStart + 0x266D0	; 0232E7A0

; ===== function loc_0232E7A4 =====
loc_0232E7A4:
	ldr r0,[pool_0232E7B8]	; 0232E7A4
	ldr r1,[r0,#0x0]	; 0232E7A6
	mov r0,#0x0	; 0232E7A8
	cmp r1,#0x0	; 0232E7AA
	beq loc_0232E7B6	; 0232E7AC
loc_0232E7AE:
	add r0,r0,#0x1	; 0232E7AE
	ldr r1,[r1,#0x0]	; 0232E7B0
	cmp r1,#0x0	; 0232E7B2
	bne loc_0232E7AE	; 0232E7B4
loc_0232E7B6:
	bx lr	; 0232E7B6
pool_0232E7B8:
loc_0232E7B8:
	.word P1_BssStart + 0x266C8	; 0232E7B8

; ===== function loc_0232E7BC =====
loc_0232E7BC:
	ldr r1,[pool_0232E7E4]	; 0232E7BC
	ldr r1,[r1,#0x0]	; 0232E7BE
	cmp r0,r1	; 0232E7C0
	bls loc_0232E7D4	; 0232E7C2
	sub r1,r0,r1	; 0232E7C4
	ldr r0,[pool_0232E7E8]	; 0232E7C6
	cmp r1,r0	; 0232E7C8
	bcc loc_0232E7D0	; 0232E7CA
	mov r0,#0x1	; 0232E7CC
	bx lr	; 0232E7CE
loc_0232E7D0:
	mov r0,#0x0	; 0232E7D0
	bx lr	; 0232E7D2
loc_0232E7D4:
	sub r1,r1,r0	; 0232E7D4
	ldr r0,[pool_0232E7E8]	; 0232E7D6
	cmp r1,r0	; 0232E7D8
	bcs loc_0232E7E0	; 0232E7DA
	mov r0,#0x1	; 0232E7DC
	bx lr	; 0232E7DE
loc_0232E7E0:
	mov r0,#0x0	; 0232E7E0
	bx lr	; 0232E7E2
pool_0232E7E4:
loc_0232E7E4:
	.word P1_BssStart + 0x266CC	; 0232E7E4
pool_0232E7E8:
loc_0232E7E8:
	.word 0x80000000	; 0232E7E8

; ===== function loc_0232E7EC =====
loc_0232E7EC:
	ldr r0,[pool_0232E800]	; 0232E7EC
	ldr r0,[r0,#0x0]	; 0232E7EE
	cmp r0,#0x0	; 0232E7F0
	bne loc_0232E7FA	; 0232E7F2
	ldr r0,[pool_0232E804]	; 0232E7F4
	ldr r0,[r0,#0x0]	; 0232E7F6
	bx lr	; 0232E7F8
loc_0232E7FA:
	ldr r0,[pool_0232E808]	; 0232E7FA
	ldr r0,[r0,#0x0]	; 0232E7FC
	bx lr	; 0232E7FE
pool_0232E800:
loc_0232E800:
	.word P1_BssStart + 0x266D0	; 0232E800
pool_0232E804:
loc_0232E804:
	.word P1_BssStart + 0x266CC	; 0232E804
pool_0232E808:
loc_0232E808:
	.word P1_BssStart + 0x266E8	; 0232E808

; ===== function loc_0232E80C =====
loc_0232E80C:
	push {r4,r5,lr}	; 0232E80C
	sub sp,#0x4	; 0232E80E
	add r4,r0,#0x0	; 0232E810
	bl loc_0232E7BC	; 0232E812
	cmp r0,#0x0	; 0232E816
	bne loc_0232E850	; 0232E818
	mov r5,#0x0	; 0232E81A
loc_0232E81C:
	add r0,r5,#0x0	; 0232E81C
	bl loc_0232E9B0	; 0232E81E
	cmp r0,#0x0	; 0232E822
	bne loc_0232E81C	; 0232E824
	add r0,r4,#0x0	; 0232E826
	bl loc_0232E7BC	; 0232E828
	cmp r0,#0x0	; 0232E82C
	bne loc_0232E850	; 0232E82E
	bl loc_0232E6F0	; 0232E830
	add r0,r4,#0x0	; 0232E834
	bl loc_0232E7BC	; 0232E836
	cmp r0,#0x0	; 0232E83A
	bne loc_0232E850	; 0232E83C
	mov r5,#0x1	; 0232E83E
loc_0232E840:
	add r0,r5,#0x0	; 0232E840
	bl loc_0232E9B0	; 0232E842
	add r0,r4,#0x0	; 0232E846
	bl loc_0232E7BC	; 0232E848
	cmp r0,#0x0	; 0232E84C
	beq loc_0232E840	; 0232E84E
loc_0232E850:
	add sp,#0x4	; 0232E850
	pop {r4,r5}	; 0232E852
	pop {r3}	; 0232E854
	bx r3	; 0232E856

; ===== function loc_0232E858 =====
loc_0232E858:
	push {r4,lr}	; 0232E858
	add r4,r0,#0x0	; 0232E85A
	ldr r0,[pool_0232E900]	; 0232E85C
	ldr r0,[r0,#0x0]	; 0232E85E
	cmp r0,#0x0	; 0232E860
	bne loc_0232E86C	; 0232E862
	mov r0,#0x1	; 0232E864
	pop {r4}	; 0232E866
	pop {r3}	; 0232E868
	bx r3	; 0232E86A
loc_0232E86C:
	ldr r0,[pool_0232E904]	; 0232E86C
	ldr r0,[r0,#0x0]	; 0232E86E
	cmp r0,#0x8	; 0232E870
	blt loc_0232E88E	; 0232E872
	cmp r4,#0x0	; 0232E874
	bne loc_0232E880	; 0232E876
	mov r0,#0x0	; 0232E878
	pop {r4}	; 0232E87A
	pop {r3}	; 0232E87C
	bx r3	; 0232E87E
loc_0232E880:
	mov r0,#0x1	; 0232E880
	bl loc_0232E9B0	; 0232E882
	ldr r0,[pool_0232E904]	; 0232E886
	ldr r0,[r0,#0x0]	; 0232E888
	cmp r0,#0x8	; 0232E88A
	bge loc_0232E880	; 0232E88C
loc_0232E88E:
	ldr r0,[pool_0232E908]	; 0232E88E
	ldr r1,[pool_0232E90C]	; 0232E890
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E892
	mov r0,#0x7	; 0232E896
	ldr r1,[pool_0232E900]	; 0232E898
	ldr r1,[r1,#0x0]	; 0232E89A
	mov r2,#0x0	; 0232E89C
	bl loc_0232ED98	; 0232E89E
	cmp r0,#0x0	; 0232E8A2
	bge loc_0232E8C2	; 0232E8A4
	cmp r4,#0x0	; 0232E8A6
	bne loc_0232E8B2	; 0232E8A8
	mov r0,#0x0	; 0232E8AA
	pop {r4}	; 0232E8AC
	pop {r3}	; 0232E8AE
	bx r3	; 0232E8B0
loc_0232E8B2:
	mov r0,#0x7	; 0232E8B2
	ldr r1,[pool_0232E900]	; 0232E8B4
	ldr r1,[r1,#0x0]	; 0232E8B6
	mov r2,#0x0	; 0232E8B8
	bl loc_0232ED98	; 0232E8BA
	cmp r0,#0x0	; 0232E8BE
	blt loc_0232E8B2	; 0232E8C0
loc_0232E8C2:
	ldr r0,[pool_0232E900]	; 0232E8C2
	ldr r4,[r0,#0x0]	; 0232E8C4
	ldr r0,[pool_0232E910]	; 0232E8C6
	ldr r2,[r0,#0x0]	; 0232E8C8
	lsl r3,r2,#0x2	; 0232E8CA
	ldr r1,[pool_0232E914]	; 0232E8CC
	str r4,[r1,r3]	; 0232E8CE
	add r1,r2,#0x1	; 0232E8D0
	str r1,[r0,#0x0]	; 0232E8D2
	cmp r1,#0x8	; 0232E8D4
	ble loc_0232E8DC	; 0232E8D6
	mov r1,#0x0	; 0232E8D8
	str r1,[r0,#0x0]	; 0232E8DA
loc_0232E8DC:
	mov r1,#0x0	; 0232E8DC
	ldr r0,[pool_0232E900]	; 0232E8DE
	str r1,[r0,#0x0]	; 0232E8E0
	ldr r0,[pool_0232E918]	; 0232E8E2
	str r1,[r0,#0x0]	; 0232E8E4
	ldr r0,[pool_0232E904]	; 0232E8E6
	ldr r1,[r0,#0x0]	; 0232E8E8
	add r1,r1,#0x1	; 0232E8EA
	str r1,[r0,#0x0]	; 0232E8EC
	ldr r0,[pool_0232E91C]	; 0232E8EE
	ldr r1,[r0,#0x0]	; 0232E8F0
	add r1,r1,#0x1	; 0232E8F2
	str r1,[r0,#0x0]	; 0232E8F4
	mov r0,#0x1	; 0232E8F6
	pop {r4}	; 0232E8F8
	pop {r3}	; 0232E8FA
	bx r3	; 0232E8FC
	.byte 0xC0, 0x46	; 0232E900
pool_0232E900:
loc_0232E900:
	.word P1_BssStart + 0x266D0	; 0232E900
pool_0232E904:
loc_0232E904:
	.word P1_BssStart + 0x266E4	; 0232E904
pool_0232E908:
loc_0232E908:
	.word 0x02357820	; 0232E908
pool_0232E90C:
loc_0232E90C:
	.word 0x00001800	; 0232E90C
pool_0232E910:
loc_0232E910:
	.word P1_BssStart + 0x266E0	; 0232E910
pool_0232E914:
loc_0232E914:
	.word P1_BssStart + 0x266EC	; 0232E914
pool_0232E918:
loc_0232E918:
	.word P1_BssStart + 0x266D4	; 0232E918
pool_0232E91C:
loc_0232E91C:
	.word P1_BssStart + 0x266E8	; 0232E91C

; ===== function loc_0232E920 =====
loc_0232E920:
	ldr r2,[pool_0232E93C]	; 0232E920
	ldr r1,[r2,#0x0]	; 0232E922
	cmp r1,#0x0	; 0232E924
	bne loc_0232E930	; 0232E926
	ldr r1,[pool_0232E940]	; 0232E928
	str r0,[r1,#0x0]	; 0232E92A
	str r0,[r2,#0x0]	; 0232E92C
	b loc_0232E934	; 0232E92E
loc_0232E930:
	str r0,[r1,#0x0]	; 0232E930
	str r0,[r2,#0x0]	; 0232E932
loc_0232E934:
	mov r1,#0x0	; 0232E934
	str r1,[r0,#0x0]	; 0232E936
	bx lr	; 0232E938
	.byte 0xC0, 0x46	; 0232E93C
pool_0232E93C:
loc_0232E93C:
	.word P1_BssStart + 0x266D4	; 0232E93C
pool_0232E940:
loc_0232E940:
	.word P1_BssStart + 0x266D0	; 0232E940

; ===== function loc_0232E944 =====
loc_0232E944:
	push {r4,lr}	; 0232E944
	add r4,r0,#0x0	; 0232E946
	bl loc_0232B624	; 0232E948
	cmp r0,#0x0	; 0232E94C
	beq loc_0232E958	; 0232E94E
	mov r0,#0x0	; 0232E950
	pop {r4}	; 0232E952
	pop {r3}	; 0232E954
	bx r3	; 0232E956
loc_0232E958:
	bl loc_0232E6CC	; 0232E958
	cmp r0,#0x0	; 0232E95C
	bne loc_0232E9A8	; 0232E95E
	cmp r4,#0x0	; 0232E960
	bne loc_0232E96C	; 0232E962
	mov r0,#0x0	; 0232E964
	pop {r4}	; 0232E966
	pop {r3}	; 0232E968
	bx r3	; 0232E96A
loc_0232E96C:
	bl loc_0232E770	; 0232E96C
	cmp r0,#0x0	; 0232E970
	ble loc_0232E98E	; 0232E972
	mov r4,#0x0	; 0232E974
loc_0232E976:
	add r0,r4,#0x0	; 0232E976
	bl loc_0232E9B0	; 0232E978
	cmp r0,#0x0	; 0232E97C
	bne loc_0232E976	; 0232E97E
	bl loc_0232E6CC	; 0232E980
	cmp r0,#0x0	; 0232E984
	beq loc_0232E994	; 0232E986
	pop {r4}	; 0232E988
	pop {r3}	; 0232E98A
	bx r3	; 0232E98C
loc_0232E98E:
	mov r0,#0x1	; 0232E98E
	bl loc_0232E858	; 0232E990
loc_0232E994:
	bl loc_0232E6F0	; 0232E994
	mov r4,#0x1	; 0232E998
loc_0232E99A:
	add r0,r4,#0x0	; 0232E99A
	bl loc_0232E9B0	; 0232E99C
	bl loc_0232E6CC	; 0232E9A0
	cmp r0,#0x0	; 0232E9A4
	beq loc_0232E99A	; 0232E9A6
loc_0232E9A8:
	pop {r4}	; 0232E9A8
	pop {r3}	; 0232E9AA
	bx r3	; 0232E9AC
	.byte 0x00, 0x00	; 0232E9B0

; ===== function loc_0232E9B0 =====
loc_0232E9B0:
	push {lr}	; 0232E9B0
	sub sp,#0x4	; 0232E9B2
	cmp r0,#0x0	; 0232E9B4
	bne loc_0232E9CC	; 0232E9B6
	bl loc_0232EBD0	; 0232E9B8
	ldr r1,[pool_0232EA28]	; 0232E9BC
	ldr r1,[r1,#0x0]	; 0232E9BE
	cmp r1,r0	; 0232E9C0
	bne loc_0232E9D8	; 0232E9C2
	mov r0,#0x0	; 0232E9C4
	add sp,#0x4	; 0232E9C6
	pop {r3}	; 0232E9C8
	bx r3	; 0232E9CA
loc_0232E9CC:
	bl loc_0232EBD0	; 0232E9CC
	ldr r1,[pool_0232EA28]	; 0232E9D0
	ldr r1,[r1,#0x0]	; 0232E9D2
	cmp r1,r0	; 0232E9D4
	beq loc_0232E9CC	; 0232E9D6
loc_0232E9D8:
	ldr r1,[pool_0232EA2C]	; 0232E9D8
	ldr r2,[r1,#0x0]	; 0232E9DA
	lsl r3,r2,#0x2	; 0232E9DC
	ldr r0,[pool_0232EA30]	; 0232E9DE
	ldr r0,[r0,r3]	; 0232E9E0
	add r2,r2,#0x1	; 0232E9E2
	str r2,[r1,#0x0]	; 0232E9E4
	cmp r2,#0x8	; 0232E9E6
	ble loc_0232E9EE	; 0232E9E8
	mov r2,#0x0	; 0232E9EA
	str r2,[r1,#0x0]	; 0232E9EC
loc_0232E9EE:
	add r2,r0,#0x0	; 0232E9EE
	ldr r1,[r0,#0x0]	; 0232E9F0
	cmp r1,#0x0	; 0232E9F2
	beq loc_0232E9FE	; 0232E9F4
loc_0232E9F6:
	ldr r2,[r2,#0x0]	; 0232E9F6
	ldr r1,[r2,#0x0]	; 0232E9F8
	cmp r1,#0x0	; 0232E9FA
	bne loc_0232E9F6	; 0232E9FC
loc_0232E9FE:
	ldr r1,[pool_0232EA34]	; 0232E9FE
	ldr r1,[r1,#0x0]	; 0232EA00
	cmp r1,#0x0	; 0232EA02
	beq loc_0232EA0A	; 0232EA04
	str r0,[r1,#0x0]	; 0232EA06
	b loc_0232EA0E	; 0232EA08
loc_0232EA0A:
	ldr r1,[pool_0232EA38]	; 0232EA0A
	str r0,[r1,#0x0]	; 0232EA0C
loc_0232EA0E:
	ldr r1,[pool_0232EA34]	; 0232EA0E
	str r2,[r1,#0x0]	; 0232EA10
	ldr r1,[pool_0232EA3C]	; 0232EA12
	ldr r2,[r1,#0x0]	; 0232EA14
	sub r2,r2,#0x1	; 0232EA16
	str r2,[r1,#0x0]	; 0232EA18
	ldr r1,[pool_0232EA28]	; 0232EA1A
	ldr r2,[r1,#0x0]	; 0232EA1C
	add r2,r2,#0x1	; 0232EA1E
	str r2,[r1,#0x0]	; 0232EA20
	add sp,#0x4	; 0232EA22
	pop {r3}	; 0232EA24
	bx r3	; 0232EA26
pool_0232EA28:
loc_0232EA28:
	.word P1_BssStart + 0x266CC	; 0232EA28
pool_0232EA2C:
loc_0232EA2C:
	.word P1_BssStart + 0x266DC	; 0232EA2C
pool_0232EA30:
loc_0232EA30:
	.word P1_BssStart + 0x266EC	; 0232EA30
pool_0232EA34:
loc_0232EA34:
	.word P1_BssStart + 0x266D8	; 0232EA34
pool_0232EA38:
loc_0232EA38:
	.word P1_BssStart + 0x266C8	; 0232EA38
pool_0232EA3C:
loc_0232EA3C:
	.word P1_BssStart + 0x266E4	; 0232EA3C

; ===== function loc_0232EA40 =====
loc_0232EA40:
	push {r4,lr}	; 0232EA40
	bl loc_0232E710	; 0232EA42
	ldr r3,[pool_0232EABC]	; 0232EA46
	ldr r0,[pool_0232EAC0]	; 0232EA48
	str r3,[r0,#0x0]	; 0232EA4A
	mov r4,#0x0	; 0232EA4C
	add r2,r3,#0x0	; 0232EA4E
	mov r0,#0x18	; 0232EA50
loc_0232EA52:
	add r4,r4,#0x1	; 0232EA52
	add r1,r4,#0x0	; 0232EA54
	mul r1,r0	; 0232EA56
	add r1,r2,r1	; 0232EA58
	str r1,[r3,#0x0]	; 0232EA5A
	add r3,#0x18	; 0232EA5C
	cmp r4,#0xff	; 0232EA5E
	blt loc_0232EA52	; 0232EA60
	mov r0,#0x0	; 0232EA62
	ldr r1,[pool_0232EAC4]	; 0232EA64
	str r0,[r1,#0x68]	; 0232EA66
	ldr r2,[pool_0232EAC8]	; 0232EA68
	ldr r1,[pool_0232EACC]	; 0232EA6A
	str r2,[r1,#0x0]	; 0232EA6C
	ldr r1,[pool_0232EAD0]	; 0232EA6E
	str r0,[r1,#0x0]	; 0232EA70
	ldr r1,[pool_0232EAD4]	; 0232EA72
	str r0,[r1,#0x0]	; 0232EA74
	ldr r1,[pool_0232EAD8]	; 0232EA76
	str r0,[r1,#0x0]	; 0232EA78
	ldr r1,[pool_0232EADC]	; 0232EA7A
	str r0,[r1,#0x0]	; 0232EA7C
	ldr r1,[pool_0232EAE0]	; 0232EA7E
	str r0,[r1,#0x0]	; 0232EA80
	mov r2,#0x1	; 0232EA82
	ldr r1,[pool_0232EAE4]	; 0232EA84
	str r2,[r1,#0x0]	; 0232EA86
	ldr r1,[pool_0232EAE8]	; 0232EA88
	str r0,[r1,#0x0]	; 0232EA8A
	ldr r0,[pool_0232EAEC]	; 0232EA8C
	ldr r1,[pool_0232EAF0]	; 0232EA8E
	str r0,[r1,#0x0]	; 0232EA90
	bl loc_0232EB80	; 0232EA92
	mov r0,#0x1	; 0232EA96
	bl loc_0232E944	; 0232EA98
	cmp r0,#0x0	; 0232EA9C
	beq loc_0232EAB4	; 0232EA9E
	mov r1,#0x19	; 0232EAA0
	str r1,[r0,#0x4]	; 0232EAA2
	ldr r1,[pool_0232EAF0]	; 0232EAA4
	ldr r1,[r1,#0x0]	; 0232EAA6
	str r1,[r0,#0x8]	; 0232EAA8
	bl loc_0232E920	; 0232EAAA
	mov r0,#0x1	; 0232EAAE
	bl loc_0232E858	; 0232EAB0
loc_0232EAB4:
	pop {r4}	; 0232EAB4
	pop {r3}	; 0232EAB6
	bx r3	; 0232EAB8
	.byte 0xC0, 0x46	; 0232EABC
pool_0232EABC:
loc_0232EABC:
	.word P1_BssStart + 0x269A0	; 0232EABC
pool_0232EAC0:
loc_0232EAC0:
	.word P1_BssStart + 0x266C8	; 0232EAC0
pool_0232EAC4:
loc_0232EAC4:
	.word P1_BssStart + 0x28120	; 0232EAC4
pool_0232EAC8:
loc_0232EAC8:
	.word 0x02359008	; 0232EAC8
pool_0232EACC:
loc_0232EACC:
	.word P1_BssStart + 0x266D8	; 0232EACC
pool_0232EAD0:
loc_0232EAD0:
	.word P1_BssStart + 0x266D0	; 0232EAD0
pool_0232EAD4:
loc_0232EAD4:
	.word P1_BssStart + 0x266D4	; 0232EAD4
pool_0232EAD8:
loc_0232EAD8:
	.word P1_BssStart + 0x266E4	; 0232EAD8
pool_0232EADC:
loc_0232EADC:
	.word P1_BssStart + 0x266DC	; 0232EADC
pool_0232EAE0:
loc_0232EAE0:
	.word P1_BssStart + 0x266E0	; 0232EAE0
pool_0232EAE4:
loc_0232EAE4:
	.word P1_BssStart + 0x266E8	; 0232EAE4
pool_0232EAE8:
loc_0232EAE8:
	.word P1_BssStart + 0x266CC	; 0232EAE8
pool_0232EAEC:
loc_0232EAEC:
	.word 0x023575A0	; 0232EAEC
pool_0232EAF0:
loc_0232EAF0:
	.word P1_BssStart + 0x28200	; 0232EAF0

; ===== function loc_0232EAF4 =====
loc_0232EAF4:
	push {r4,lr}	; 0232EAF4
	ldr r4,[pool_0232EB20]	; 0232EAF6
	mov r2,#0xff	; 0232EAF8
	add r3,r0,#0x0	; 0232EAFA
	and r3,r2	; 0232EAFC
	mov r1,#0xc	; 0232EAFE
	mul r3,r1	; 0232EB00
	add r3,r4,r3	; 0232EB02
	asr r1,r0,#0x8	; 0232EB04
	and r1,r2	; 0232EB06
	ldrb r0,[r3,#0x8]	; 0232EB08
	cmp r1,r0	; 0232EB0A
	bne loc_0232EB18	; 0232EB0C
	ldr r1,[r3,#0x0]	; 0232EB0E
	cmp r1,#0x0	; 0232EB10
	beq loc_0232EB18	; 0232EB12
	ldr r0,[r3,#0x4]	; 0232EB14
	blx r1	; 0232EB16
loc_0232EB18:
	pop {r4}	; 0232EB18
	pop {r3}	; 0232EB1A
	bx r3	; 0232EB1C
	.byte 0xC0, 0x46	; 0232EB20
pool_0232EB20:
loc_0232EB20:
	.word 0x02359020	; 0232EB20

; ===== function loc_0232EB24 =====
loc_0232EB24:
	push {r4}	; 0232EB24
	sub sp,#0x4	; 0232EB26
	ldr r4,[pool_0232EB48]	; 0232EB28
	mov r3,#0xc	; 0232EB2A
	mul r0,r3	; 0232EB2C
	add r3,r4,r0	; 0232EB2E
	str r1,[r4,r0]	; 0232EB30
	str r2,[r3,#0x4]	; 0232EB32
	add r1,r3,#0x0	; 0232EB34
	add r1,#0x8	; 0232EB36
	ldrb r0,[r1,#0x0]	; 0232EB38
	add r0,r0,#0x1	; 0232EB3A
	strb r0,[r1,#0x0]	; 0232EB3C
	ldrb r0,[r3,#0x8]	; 0232EB3E
	add sp,#0x4	; 0232EB40
	pop {r4}	; 0232EB42
	bx lr	; 0232EB44
	.byte 0xC0, 0x46	; 0232EB48
pool_0232EB48:
loc_0232EB48:
	.word P1_BssStart + 0x281A0	; 0232EB48

; ===== function loc_0232EB4C =====
loc_0232EB4C:
	ldr r2,[pool_0232EB60]	; 0232EB4C
	mov r1,#0xc	; 0232EB4E
	mul r0,r1	; 0232EB50
	add r1,r2,r0	; 0232EB52
	add r1,#0x8	; 0232EB54
	ldrb r0,[r1,#0x0]	; 0232EB56
	add r0,r0,#0x1	; 0232EB58
	strb r0,[r1,#0x0]	; 0232EB5A
	bx lr	; 0232EB5C
	.byte 0xC0, 0x46	; 0232EB60
pool_0232EB60:
loc_0232EB60:
	.word 0x02359020	; 0232EB60

; ===== function loc_0232EB64 =====
loc_0232EB64:
	mov r2,#0x0	; 0232EB64
	ldr r1,[pool_0232EB7C]	; 0232EB66
	add r0,r2,#0x0	; 0232EB68
loc_0232EB6A:
	str r0,[r1,#0x0]	; 0232EB6A
	str r0,[r1,#0x4]	; 0232EB6C
	strb r0,[r1,#0x8]	; 0232EB6E
	add r1,#0xc	; 0232EB70
	add r2,r2,#0x1	; 0232EB72
	cmp r2,#0x8	; 0232EB74
	blt loc_0232EB6A	; 0232EB76
	bx lr	; 0232EB78
	.byte 0xC0, 0x46	; 0232EB7C
pool_0232EB7C:
loc_0232EB7C:
	.word P1_BssStart + 0x281A0	; 0232EB7C

; ===== function loc_0232EB80 =====
loc_0232EB80:
	push {r4,r5,r6,lr}	; 0232EB80
	mov r6,#0x0	; 0232EB82
	str r6,[r0,#0x4]	; 0232EB84
	strh r6,[r0,#0x8]	; 0232EB86
	strh r6,[r0,#0xa]	; 0232EB88
	str r6,[r0,#0x0]	; 0232EB8A
	add r4,r0,#0x0	; 0232EB8C
	mvn r1,r6	; 0232EB8E
	add r2,r6,#0x0	; 0232EB90
loc_0232EB92:
	str r2,[r4,#0x40]	; 0232EB92
	add r5,r2,#0x0	; 0232EB94
	add r3,r4,#0x0	; 0232EB96
loc_0232EB98:
	strh r1,[r3,#0x20]	; 0232EB98
	add r3,r3,#0x2	; 0232EB9A
	add r5,r5,#0x1	; 0232EB9C
	cmp r5,#0x10	; 0232EB9E
	blt loc_0232EB98	; 0232EBA0
	add r4,#0x24	; 0232EBA2
	add r6,r6,#0x1	; 0232EBA4
	cmp r6,#0x10	; 0232EBA6
	blt loc_0232EB92	; 0232EBA8
	mov r3,#0x0	; 0232EBAA
	add r4,r0,#0x0	; 0232EBAC
	mvn r2,r3	; 0232EBAE
	ldr r1,[pool_0232EBC8]	; 0232EBB0
loc_0232EBB2:
	strh r2,[r4,r1]	; 0232EBB2
	add r4,r4,#0x2	; 0232EBB4
	add r3,r3,#0x1	; 0232EBB6
	cmp r3,#0x10	; 0232EBB8
	blt loc_0232EBB2	; 0232EBBA
	ldr r1,[pool_0232EBCC]	; 0232EBBC
	blx P1_CleanAndInvalidateDataCacheRange	; 0232EBBE
	pop {r4,r5,r6}	; 0232EBC2
	pop {r3}	; 0232EBC4
	bx r3	; 0232EBC6
pool_0232EBC8:
loc_0232EBC8:
	.word 0x00000260	; 0232EBC8
pool_0232EBCC:
loc_0232EBCC:
	.word 0x00000280	; 0232EBCC

; ===== function loc_0232EBD0 =====
loc_0232EBD0:
	push {lr}	; 0232EBD0
	sub sp,#0x4	; 0232EBD2
	ldr r0,[pool_0232EBEC]	; 0232EBD4
	ldr r0,[r0,#0x0]	; 0232EBD6
	ldr r1,[pool_0232EBF0]	; 0232EBD8
	blx P1_InvalidateDataCacheRange	; 0232EBDA
	ldr r0,[pool_0232EBEC]	; 0232EBDE
	ldr r0,[r0,#0x0]	; 0232EBE0
	ldr r0,[r0,#0x0]	; 0232EBE2
	add sp,#0x4	; 0232EBE4
	pop {r3}	; 0232EBE6
	bx r3	; 0232EBE8
	.byte 0xC0, 0x46	; 0232EBEC
pool_0232EBEC:
loc_0232EBEC:
	.word P1_BssStart + 0x28200	; 0232EBEC
pool_0232EBF0:
loc_0232EBF0:
	.word 0x00000280	; 0232EBF0

; ===== function loc_0232EBF4 =====
	push {lr}	; 0232EBF4
	sub sp,#0x4	; 0232EBF6
	ldr r0,[pool_0232EC10]	; 0232EBF8
	ldr r0,[r0,#0x0]	; 0232EBFA
	ldr r1,[pool_0232EC14]	; 0232EBFC
	blx P1_InvalidateDataCacheRange	; 0232EBFE
	ldr r0,[pool_0232EC10]	; 0232EC02
	ldr r0,[r0,#0x0]	; 0232EC04
	ldrh r0,[r0,#0x8]	; 0232EC06
	add sp,#0x4	; 0232EC08
	pop {r3}	; 0232EC0A
	bx r3	; 0232EC0C
	.byte 0xC0, 0x46	; 0232EC10
pool_0232EC10:
loc_0232EC10:
	.word P1_BssStart + 0x28200	; 0232EC10
pool_0232EC14:
loc_0232EC14:
	.word 0x00000280	; 0232EC14

; ===== function loc_0232EC18 =====
loc_0232EC18:
	push {lr}	; 0232EC18
	sub sp,#0x4	; 0232EC1A
	ldr r0,[pool_0232EC34]	; 0232EC1C
	ldr r0,[r0,#0x0]	; 0232EC1E
	ldr r1,[pool_0232EC38]	; 0232EC20
	blx P1_InvalidateDataCacheRange	; 0232EC22
	ldr r0,[pool_0232EC34]	; 0232EC26
	ldr r0,[r0,#0x0]	; 0232EC28
	ldr r0,[r0,#0x4]	; 0232EC2A
	add sp,#0x4	; 0232EC2C
	pop {r3}	; 0232EC2E
	bx r3	; 0232EC30
	.byte 0xC0, 0x46	; 0232EC34
pool_0232EC34:
loc_0232EC34:
	.word P1_BssStart + 0x28200	; 0232EC34
pool_0232EC38:
loc_0232EC38:
	.word 0x00000280	; 0232EC38

; ===== function loc_0232EC3C =====
loc_0232EC3C:
	push {r4,r5,r6,r7,lr}	; 0232EC3C
	sub sp,#0x4	; 0232EC3E
	add r5,r0,#0x0	; 0232EC40
	add r7,r1,#0x0	; 0232EC42
	add r4,r2,#0x0	; 0232EC44
	lsl r2,r7,#0x3	; 0232EC46
	add r1,r5,r2	; 0232EC48
	ldr r0,[r1,#0x18]	; 0232EC4A
	cmp r0,#0x0	; 0232EC4C
	beq loc_0232EC8C	; 0232EC4E
	cmp r4,r0	; 0232EC50
	beq loc_0232ECAE	; 0232EC52
	ldr r6,[r0,#0x18]	; 0232EC54
	add r3,r5,#0x0	; 0232EC56
	add r3,#0x18	; 0232EC58
	add r3,r3,r2	; 0232EC5A
	cmp r3,r6	; 0232EC5C
	bne loc_0232EC6E	; 0232EC5E
	ldr r2,[r1,#0x1c]	; 0232EC60
	str r2,[r0,#0x18]	; 0232EC62
	ldr r0,[r1,#0x18]	; 0232EC64
	mov r1,#0x3c	; 0232EC66
	blx P1_CleanDataCacheRange	; 0232EC68
	b loc_0232EC8C	; 0232EC6C
loc_0232EC6E:
	cmp r6,#0x0	; 0232EC6E
	beq loc_0232EC7E	; 0232EC70
loc_0232EC72:
	ldr r0,[r6,#0x4]	; 0232EC72
	cmp r3,r0	; 0232EC74
	beq loc_0232EC7E	; 0232EC76
	add r6,r0,#0x0	; 0232EC78
	cmp r0,#0x0	; 0232EC7A
	bne loc_0232EC72	; 0232EC7C
loc_0232EC7E:
	add r0,r5,r2	; 0232EC7E
	ldr r0,[r0,#0x1c]	; 0232EC80
	str r0,[r6,#0x4]	; 0232EC82
	add r0,r6,#0x0	; 0232EC84
	mov r1,#0x8	; 0232EC86
	blx P1_CleanDataCacheRange	; 0232EC88
loc_0232EC8C:
	ldr r0,[r4,#0x18]	; 0232EC8C
	lsl r3,r7,#0x3	; 0232EC8E
	add r2,r5,#0x0	; 0232EC90
	add r2,#0x18	; 0232EC92
	add r1,r2,r3	; 0232EC94
	str r1,[r4,#0x18]	; 0232EC96
	add r1,r5,r3	; 0232EC98
	str r0,[r1,#0x1c]	; 0232EC9A
	str r4,[r2,r3]	; 0232EC9C
	add r0,r5,#0x0	; 0232EC9E
	mov r1,#0x3c	; 0232ECA0
	blx P1_CleanDataCacheRange	; 0232ECA2
	add r0,r4,#0x0	; 0232ECA6
	mov r1,#0x3c	; 0232ECA8
	blx P1_CleanDataCacheRange	; 0232ECAA
loc_0232ECAE:
	add sp,#0x4	; 0232ECAE
	pop {r4,r5,r6,r7}	; 0232ECB0
	pop {r3}	; 0232ECB2
	bx r3	; 0232ECB4
	.byte 0x00, 0x00	; 0232ECB8

; ===== function loc_0232ECB8 =====
loc_0232ECB8:
	ldr r3,[pool_0232ECBC]	; 0232ECB8
	bx r3	; 0232ECBA
pool_0232ECBC:
loc_0232ECBC:
	.word loc_0232EEA8 + 1	; 0232ECBC

; ===== function loc_0232ECC0 =====
P1_IrqHandler_0232ECC0:
	push {r4,r5,r6,r7,lr}	; 0232ECC0
	sub sp,#0x4	; 0232ECC2
	ldr r5,[pool_0232ED7C]	; 0232ECC4
	mov r0,#0x3	; 0232ECC6
	mvn r6,r0	; 0232ECC8
	mov r7,#0x2	; 0232ECCA
	mvn r4,r7	; 0232ECCC
loc_0232ECCE:
	ldrh r1,[r5,#0x0]	; 0232ECCE
	ldr r0,[pool_0232ED80]	; 0232ECD0
	and r1,r0	; 0232ECD2
	cmp r1,#0x0	; 0232ECD4
	beq loc_0232ECE4	; 0232ECD6
	ldrh r1,[r5,#0x0]	; 0232ECD8
	ldr r0,[pool_0232ED84]	; 0232ECDA
	orr r1,r0	; 0232ECDC
	strh r1,[r5,#0x0]	; 0232ECDE
	add r0,r4,#0x0	; 0232ECE0
	b loc_0232ED06	; 0232ECE2
loc_0232ECE4:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232ECE4
	ldrh r2,[r5,#0x0]	; 0232ECE8
	ldr r1,[pool_0232ED88]	; 0232ECEA
	and r2,r1	; 0232ECEC
	cmp r2,#0x0	; 0232ECEE
	beq loc_0232ECFA	; 0232ECF0
	blx P1_Arm9RestoreIrqMask	; 0232ECF2
	add r0,r6,#0x0	; 0232ECF6
	b loc_0232ED06	; 0232ECF8
loc_0232ECFA:
	ldr r1,[pool_0232ED8C]	; 0232ECFA
	ldr r1,[r1,#0x0]	; 0232ECFC
	str r1,[sp,#0x0]	; 0232ECFE
	blx P1_Arm9RestoreIrqMask	; 0232ED00
	mov r0,#0x0	; 0232ED04
loc_0232ED06:
	mov r1,#0x3	; 0232ED06
	mvn r1,r1	; 0232ED08
	cmp r0,r1	; 0232ED0A
	beq loc_0232ED72	; 0232ED0C
	mvn r1,r7	; 0232ED0E
	cmp r0,r1	; 0232ED10
	beq loc_0232ECCE	; 0232ED12
	ldr r2,[sp,#0x0]	; 0232ED14
	lsl r0,r2,#0x1b	; 0232ED16
	lsr r0,r0,#0x1b	; 0232ED18
	cmp r0,#0x0	; 0232ED1A
	beq loc_0232ECCE	; 0232ED1C
	lsl r3,r0,#0x2	; 0232ED1E
	ldr r1,[pool_0232ED90]	; 0232ED20
	ldr r3,[r1,r3]	; 0232ED22
	cmp r3,#0x0	; 0232ED24
	beq loc_0232ED32	; 0232ED26
	lsr r1,r2,#0x6	; 0232ED28
	lsl r2,r2,#0x1a	; 0232ED2A
	lsr r2,r2,#0x1f	; 0232ED2C
	blx r3	; 0232ED2E
	b loc_0232ECCE	; 0232ED30
loc_0232ED32:
	lsl r0,r2,#0x1a	; 0232ED32
	lsr r0,r0,#0x1f	; 0232ED34
	cmp r0,#0x0	; 0232ED36
	bne loc_0232ECCE	; 0232ED38
	mov r0,#0x20	; 0232ED3A
	orr r2,r0	; 0232ED3C
	str r2,[sp,#0x0]	; 0232ED3E
	ldrh r1,[r5,#0x0]	; 0232ED40
	ldr r0,[pool_0232ED80]	; 0232ED42
	and r1,r0	; 0232ED44
	cmp r1,#0x0	; 0232ED46
	beq loc_0232ED54	; 0232ED48
	ldrh r1,[r5,#0x0]	; 0232ED4A
	ldr r0,[pool_0232ED84]	; 0232ED4C
	orr r1,r0	; 0232ED4E
	strh r1,[r5,#0x0]	; 0232ED50
	b loc_0232ECCE	; 0232ED52
loc_0232ED54:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232ED54
	ldrh r1,[r5,#0x0]	; 0232ED58
	and r1,r7	; 0232ED5A
	cmp r1,#0x0	; 0232ED5C
	beq loc_0232ED66	; 0232ED5E
	blx P1_Arm9RestoreIrqMask	; 0232ED60
	b loc_0232ECCE	; 0232ED64
loc_0232ED66:
	ldr r2,[sp,#0x0]	; 0232ED66
	ldr r1,[pool_0232ED94]	; 0232ED68
	str r2,[r1,#0x0]	; 0232ED6A
	blx P1_Arm9RestoreIrqMask	; 0232ED6C
	b loc_0232ECCE	; 0232ED70
loc_0232ED72:
	add sp,#0x4	; 0232ED72
	pop {r4,r5,r6,r7}	; 0232ED74
	pop {r3}	; 0232ED76
	bx r3	; 0232ED78
	.byte 0xC0, 0x46	; 0232ED7C
pool_0232ED7C:
loc_0232ED7C:
	.word REG_IPC_FIFO_CR	; 0232ED7C
pool_0232ED80:
loc_0232ED80:
	.word 0x00004000	; 0232ED80
pool_0232ED84:
loc_0232ED84:
	.word 0x0000C000	; 0232ED84
pool_0232ED88:
loc_0232ED88:
	.word 0x00000100	; 0232ED88
pool_0232ED8C:
loc_0232ED8C:
	.word REG_IPC_FIFO_RX	; 0232ED8C
pool_0232ED90:
loc_0232ED90:
	.word P1_BssStart + 0x28208	; 0232ED90
pool_0232ED94:
loc_0232ED94:
	.word REG_IPC_FIFO_TX	; 0232ED94

; ===== function loc_0232ED98 =====
loc_0232ED98:
	push {r4,lr}	; 0232ED98
	sub sp,#0x8	; 0232ED9A
	ldr r3,[sp,#0x0]	; 0232ED9C
	mov r4,#0x1f	; 0232ED9E
	bic r3,r4	; 0232EDA0
	and r0,r4	; 0232EDA2
	orr r3,r0	; 0232EDA4
	str r3,[sp,#0x0]	; 0232EDA6
	mov r0,#0x20	; 0232EDA8
	bic r3,r0	; 0232EDAA
	mov r0,#0x1	; 0232EDAC
	and r2,r0	; 0232EDAE
	lsl r0,r2,#0x5	; 0232EDB0
	orr r3,r0	; 0232EDB2
	str r3,[sp,#0x0]	; 0232EDB4
	mov r0,#0x3f	; 0232EDB6
	and r3,r0	; 0232EDB8
	ldr r0,[pool_0232EE18]	; 0232EDBA
	and r1,r0	; 0232EDBC
	lsl r0,r1,#0x6	; 0232EDBE
	orr r3,r0	; 0232EDC0
	str r3,[sp,#0x0]	; 0232EDC2
	ldr r2,[pool_0232EE1C]	; 0232EDC4
	ldrh r1,[r2,#0x0]	; 0232EDC6
	ldr r0,[pool_0232EE20]	; 0232EDC8
	and r1,r0	; 0232EDCA
	cmp r1,#0x0	; 0232EDCC
	beq loc_0232EDE4	; 0232EDCE
	ldrh r1,[r2,#0x0]	; 0232EDD0
	ldr r0,[pool_0232EE24]	; 0232EDD2
	orr r1,r0	; 0232EDD4
	strh r1,[r2,#0x0]	; 0232EDD6
	mov r0,#0x0	; 0232EDD8
	mvn r0,r0	; 0232EDDA
	add sp,#0x8	; 0232EDDC
	pop {r4}	; 0232EDDE
	pop {r3}	; 0232EDE0
	bx r3	; 0232EDE2
loc_0232EDE4:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EDE4
	ldr r1,[pool_0232EE1C]	; 0232EDE8
	ldrh r2,[r1,#0x0]	; 0232EDEA
	mov r1,#0x2	; 0232EDEC
	and r2,r1	; 0232EDEE
	cmp r2,#0x0	; 0232EDF0
	beq loc_0232EE04	; 0232EDF2
	blx P1_Arm9RestoreIrqMask	; 0232EDF4
	mov r0,#0x1	; 0232EDF8
	mvn r0,r0	; 0232EDFA
	add sp,#0x8	; 0232EDFC
	pop {r4}	; 0232EDFE
	pop {r3}	; 0232EE00
	bx r3	; 0232EE02
loc_0232EE04:
	ldr r2,[sp,#0x0]	; 0232EE04
	ldr r1,[pool_0232EE28]	; 0232EE06
	str r2,[r1,#0x0]	; 0232EE08
	blx P1_Arm9RestoreIrqMask	; 0232EE0A
	mov r0,#0x0	; 0232EE0E
	add sp,#0x8	; 0232EE10
	pop {r4}	; 0232EE12
	pop {r3}	; 0232EE14
	bx r3	; 0232EE16
pool_0232EE18:
loc_0232EE18:
	.word 0x03FFFFFF	; 0232EE18
pool_0232EE1C:
loc_0232EE1C:
	.word REG_IPC_FIFO_CR	; 0232EE1C
pool_0232EE20:
loc_0232EE20:
	.word 0x00004000	; 0232EE20
pool_0232EE24:
loc_0232EE24:
	.word 0x0000C000	; 0232EE24
pool_0232EE28:
loc_0232EE28:
	.word REG_IPC_FIFO_TX	; 0232EE28

; ===== function loc_0232EE2C =====
loc_0232EE2C:
	push {r4}	; 0232EE2C
	sub sp,#0x4	; 0232EE2E
	mov r3,#0x1	; 0232EE30
	add r2,r3,#0x0	; 0232EE32
	lsl r2,r0	; 0232EE34
	ldr r4,[pool_0232EE50]	; 0232EE36
	lsl r0,r1,#0x2	; 0232EE38
	add r1,r4,r0	; 0232EE3A
	ldr r0,[pool_0232EE54]	; 0232EE3C
	ldr r0,[r1,r0]	; 0232EE3E
	and r2,r0	; 0232EE40
	cmp r2,#0x0	; 0232EE42
	bne loc_0232EE48	; 0232EE44
	mov r3,#0x0	; 0232EE46
loc_0232EE48:
	add r0,r3,#0x0	; 0232EE48
	add sp,#0x4	; 0232EE4A
	pop {r4}	; 0232EE4C
	bx lr	; 0232EE4E
pool_0232EE50:
loc_0232EE50:
	.word 0x027FFC00	; 0232EE50
pool_0232EE54:
loc_0232EE54:
	.word 0x00000388	; 0232EE54

; ===== function loc_0232EE58 =====
loc_0232EE58:
	push {r4,r5,lr}	; 0232EE58
	sub sp,#0x4	; 0232EE5A
	add r5,r0,#0x0	; 0232EE5C
	add r4,r1,#0x0	; 0232EE5E
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EE60
	lsl r2,r5,#0x2	; 0232EE64
	ldr r1,[pool_0232EE9C]	; 0232EE66
	str r4,[r1,r2]	; 0232EE68
	cmp r4,#0x0	; 0232EE6A
	beq loc_0232EE80	; 0232EE6C
	ldr r2,[pool_0232EEA0]	; 0232EE6E
	ldr r1,[pool_0232EEA4]	; 0232EE70
	add r3,r2,r1	; 0232EE72
	ldr r2,[r3,#0x0]	; 0232EE74
	mov r1,#0x1	; 0232EE76
	lsl r1,r5	; 0232EE78
	orr r2,r1	; 0232EE7A
	str r2,[r3,#0x0]	; 0232EE7C
	b loc_0232EE90	; 0232EE7E
loc_0232EE80:
	ldr r2,[pool_0232EEA0]	; 0232EE80
	ldr r1,[pool_0232EEA4]	; 0232EE82
	add r3,r2,r1	; 0232EE84
	ldr r2,[r3,#0x0]	; 0232EE86
	mov r1,#0x1	; 0232EE88
	lsl r1,r5	; 0232EE8A
	bic r2,r1	; 0232EE8C
	str r2,[r3,#0x0]	; 0232EE8E
loc_0232EE90:
	blx P1_Arm9RestoreIrqMask	; 0232EE90
	add sp,#0x4	; 0232EE94
	pop {r4,r5}	; 0232EE96
	pop {r3}	; 0232EE98
	bx r3	; 0232EE9A
pool_0232EE9C:
loc_0232EE9C:
	.word P1_BssStart + 0x28208	; 0232EE9C
pool_0232EEA0:
loc_0232EEA0:
	.word 0x027FFC00	; 0232EEA0
pool_0232EEA4:
loc_0232EEA4:
	.word 0x00000388	; 0232EEA4

; ===== function loc_0232EEA8 =====
loc_0232EEA8:
	push {r4,r5,r6,r7,lr}	; 0232EEA8
	sub sp,#0x4	; 0232EEAA
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EEAC
	str r0,[sp,#0x0]	; 0232EEB0
	ldr r0,[pool_0232EF30]	; 0232EEB2
	ldrh r1,[r0,#0x0]	; 0232EEB4
	cmp r1,#0x0	; 0232EEB6
	bne loc_0232EF20	; 0232EEB8
	mov r1,#0x1	; 0232EEBA
	strh r1,[r0,#0x0]	; 0232EEBC
	mov r2,#0x0	; 0232EEBE
	ldr r1,[pool_0232EF34]	; 0232EEC0
	ldr r0,[pool_0232EF38]	; 0232EEC2
	str r2,[r1,r0]	; 0232EEC4
	ldr r1,[pool_0232EF3C]	; 0232EEC6
	add r0,r2,#0x0	; 0232EEC8
loc_0232EECA:
	stmia r1!,{r0}	; 0232EECA
	add r2,r2,#0x1	; 0232EECC
	cmp r2,#0x20	; 0232EECE
	blt loc_0232EECA	; 0232EED0
	ldr r0,[pool_0232EF40]	; 0232EED2
	ldr r1,[pool_0232EF44]	; 0232EED4
	bl loc_0232ADD0	; 0232EED6
	ldr r0,[pool_0232EF40]	; 0232EEDA
	bl loc_0232AD4C	; 0232EEDC
	ldr r1,[pool_0232EF48]	; 0232EEE0
	ldr r0,[pool_0232EF4C]	; 0232EEE2
	strh r1,[r0,#0x0]	; 0232EEE4
	mov r1,#0x0	; 0232EEE6
	ldr r0,[pool_0232EF50]	; 0232EEE8
	add r6,r1,#0x0	; 0232EEEA
	ldr r7,[pool_0232EF54]	; 0232EEEC
	mov r4,#0xf	; 0232EEEE
loc_0232EEF0:
	ldrh r2,[r0,#0x0]	; 0232EEF0
	and r2,r4	; 0232EEF2
	lsl r3,r2,#0x8	; 0232EEF4
	strh r3,[r0,#0x0]	; 0232EEF6
	cmp r2,#0x0	; 0232EEF8
	bne loc_0232EF00	; 0232EEFA
	cmp r1,#0x4	; 0232EEFC
	bgt loc_0232EF20	; 0232EEFE
loc_0232EF00:
	add r3,r7,#0x0	; 0232EF00
	ldrh r5,[r0,#0x0]	; 0232EF02
	and r5,r4	; 0232EF04
	cmp r5,r2	; 0232EF06
	bne loc_0232EF1C	; 0232EF08
loc_0232EF0A:
	cmp r3,#0x0	; 0232EF0A
	bgt loc_0232EF12	; 0232EF0C
	add r1,r6,#0x0	; 0232EF0E
	b loc_0232EF1C	; 0232EF10
loc_0232EF12:
	sub r3,r3,#0x1	; 0232EF12
	ldrh r5,[r0,#0x0]	; 0232EF14
	and r5,r4	; 0232EF16
	cmp r5,r2	; 0232EF18
	beq loc_0232EF0A	; 0232EF1A
loc_0232EF1C:
	add r1,r1,#0x1	; 0232EF1C
	b loc_0232EEF0	; 0232EF1E
loc_0232EF20:
	ldr r0,[sp,#0x0]	; 0232EF20
	blx P1_Arm9RestoreIrqMask	; 0232EF22
	add sp,#0x4	; 0232EF26
	pop {r4,r5,r6,r7}	; 0232EF28
	pop {r3}	; 0232EF2A
	bx r3	; 0232EF2C
	.byte 0xC0, 0x46	; 0232EF30
pool_0232EF30:
loc_0232EF30:
	.word P1_BssStart + 0x28204	; 0232EF30
pool_0232EF34:
loc_0232EF34:
	.word FirmwareBootInfoAddress	; 0232EF34
pool_0232EF38:
loc_0232EF38:
	.word 0x00000388	; 0232EF38
pool_0232EF3C:
loc_0232EF3C:
	.word 0x02359088	; 0232EF3C
pool_0232EF40:
loc_0232EF40:
	.word 0x00040000	; 0232EF40
pool_0232EF44:
loc_0232EF44:
	.word P1_IrqHandler_0232ECC0 + 1	; 0232EF44
pool_0232EF48:
loc_0232EF48:
	.word 0x0000C408	; 0232EF48
pool_0232EF4C:
loc_0232EF4C:
	.word REG_IPC_FIFO_CR	; 0232EF4C
pool_0232EF50:
loc_0232EF50:
	.word REG_IPC_SYNC	; 0232EF50
pool_0232EF54:
loc_0232EF54:
	.word 0x000003E8	; 0232EF54

; ===== function loc_0232EF58 =====
loc_0232EF58:
	ldr r3,[r0,#0x0]	; 0232EF58
	ldr r2,[r0,#0x4]	; 0232EF5A
	ldr r1,[pool_0232EF84]	; 0232EF5C
	str r3,[r1,#0x0]	; 0232EF5E
	str r2,[r1,#0x4]	; 0232EF60
	ldr r3,[r0,#0x8]	; 0232EF62
	ldr r2,[r0,#0xc]	; 0232EF64
	ldr r1,[pool_0232EF88]	; 0232EF66
	str r3,[r1,#0x0]	; 0232EF68
	str r2,[r1,#0x4]	; 0232EF6A
	ldrh r2,[r0,#0x18]	; 0232EF6C
	ldr r1,[pool_0232EF8C]	; 0232EF6E
	strh r2,[r1,#0x0]	; 0232EF70
	ldr r3,[r0,#0x10]	; 0232EF72
	ldr r2,[r0,#0x14]	; 0232EF74
	ldr r1,[pool_0232EF90]	; 0232EF76
	str r3,[r1,#0x0]	; 0232EF78
	str r2,[r1,#0x4]	; 0232EF7A
	ldrh r1,[r0,#0x1a]	; 0232EF7C
	ldr r0,[pool_0232EF94]	; 0232EF7E
	strh r1,[r0,#0x0]	; 0232EF80
	bx lr	; 0232EF82
pool_0232EF84:
loc_0232EF84:
	.word REG_DIV_NUMER	; 0232EF84
pool_0232EF88:
loc_0232EF88:
	.word REG_DIV_DENOM	; 0232EF88
pool_0232EF8C:
loc_0232EF8C:
	.word REG_DIVCNT	; 0232EF8C
pool_0232EF90:
loc_0232EF90:
	.word REG_SQRT_PARAM	; 0232EF90
pool_0232EF94:
loc_0232EF94:
	.word REG_SQRTCNT	; 0232EF94

; ===== function loc_0232EF98 =====
loc_0232EF98:
	ldr r1,[pool_0232EFCC]	; 0232EF98
	ldr r2,[r1,#0x0]	; 0232EF9A
	ldr r1,[r1,#0x4]	; 0232EF9C
	str r2,[r0,#0x0]	; 0232EF9E
	str r1,[r0,#0x4]	; 0232EFA0
	ldr r1,[pool_0232EFD0]	; 0232EFA2
	ldr r2,[r1,#0x0]	; 0232EFA4
	ldr r1,[r1,#0x4]	; 0232EFA6
	str r2,[r0,#0x8]	; 0232EFA8
	str r1,[r0,#0xc]	; 0232EFAA
	ldr r1,[pool_0232EFD4]	; 0232EFAC
	ldrh r2,[r1,#0x0]	; 0232EFAE
	mov r1,#0x3	; 0232EFB0
	and r2,r1	; 0232EFB2
	strh r2,[r0,#0x18]	; 0232EFB4
	ldr r1,[pool_0232EFD8]	; 0232EFB6
	ldr r2,[r1,#0x0]	; 0232EFB8
	ldr r1,[r1,#0x4]	; 0232EFBA
	str r2,[r0,#0x10]	; 0232EFBC
	str r1,[r0,#0x14]	; 0232EFBE
	ldr r1,[pool_0232EFDC]	; 0232EFC0
	ldrh r2,[r1,#0x0]	; 0232EFC2
	mov r1,#0x1	; 0232EFC4
	and r2,r1	; 0232EFC6
	strh r2,[r0,#0x1a]	; 0232EFC8
	bx lr	; 0232EFCA
pool_0232EFCC:
loc_0232EFCC:
	.word REG_DIV_NUMER	; 0232EFCC
pool_0232EFD0:
loc_0232EFD0:
	.word REG_DIV_DENOM	; 0232EFD0
pool_0232EFD4:
loc_0232EFD4:
	.word REG_DIVCNT	; 0232EFD4
pool_0232EFD8:
loc_0232EFD8:
	.word REG_SQRT_PARAM	; 0232EFD8
pool_0232EFDC:
loc_0232EFDC:
	.word REG_SQRTCNT	; 0232EFDC

; ===== function loc_0232EFE0 =====
loc_0232EFE0:
	ldr r1,[pool_0232EFEC]	; 0232EFE0
loc_0232EFE2:
	ldrh r2,[r1,#0x36]	; 0232EFE2
	and r2,r0	; 0232EFE4
	cmp r2,#0x0	; 0232EFE6
	bne loc_0232EFE2	; 0232EFE8
	bx lr	; 0232EFEA
pool_0232EFEC:
loc_0232EFEC:
	.word P1_BssStart + 0x2828C	; 0232EFEC

; ===== function loc_0232EFF0 =====
loc_0232EFF0:
	push {r4,r5,r6,r7,lr}	; 0232EFF0
	sub sp,#0x4	; 0232EFF2
	add r5,r0,#0x0	; 0232EFF4
	add r4,r1,#0x0	; 0232EFF6
	ldr r0,[pool_0232F0B0]	; 0232EFF8
	ldrh r0,[r0,#0x30]	; 0232EFFA
	cmp r0,#0x0	; 0232EFFC
	bne loc_0232F018	; 0232EFFE
	ldrh r0,[r4,#0x0]	; 0232F000
	strh r0,[r5,#0x0]	; 0232F002
	ldrh r0,[r4,#0x2]	; 0232F004
	strh r0,[r5,#0x2]	; 0232F006
	ldrh r0,[r4,#0x4]	; 0232F008
	strh r0,[r5,#0x4]	; 0232F00A
	ldrh r0,[r4,#0x6]	; 0232F00C
	strh r0,[r5,#0x6]	; 0232F00E
	add sp,#0x4	; 0232F010
	pop {r4,r5,r6,r7}	; 0232F012
	pop {r3}	; 0232F014
	bx r3	; 0232F016
loc_0232F018:
	ldrh r0,[r4,#0x4]	; 0232F018
	strh r0,[r5,#0x4]	; 0232F01A
	ldrh r0,[r4,#0x6]	; 0232F01C
	strh r0,[r5,#0x6]	; 0232F01E
	ldrh r0,[r4,#0x4]	; 0232F020
	cmp r0,#0x0	; 0232F022
	bne loc_0232F034	; 0232F024
	mov r0,#0x0	; 0232F026
	strh r0,[r5,#0x0]	; 0232F028
	strh r0,[r5,#0x2]	; 0232F02A
	add sp,#0x4	; 0232F02C
	pop {r4,r5,r6,r7}	; 0232F02E
	pop {r3}	; 0232F030
	bx r3	; 0232F032
loc_0232F034:
	ldr r0,[pool_0232F0B4]	; 0232F034
	ldr r0,[r0,#0x8]	; 0232F036
	asr r1,r0,#0x1f	; 0232F038
	ldrh r2,[r4,#0x0]	; 0232F03A
	lsl r6,r2,#0x2	; 0232F03C
	asr r3,r6,#0x1f	; 0232F03E
	ldr r2,[pool_0232F0B4]	; 0232F040
	ldr r2,[r2,#0x0]	; 0232F042
	asr r7,r2,#0x1f	; 0232F044
	sub r2,r6,r2	; 0232F046
	sbc r3,r7	; 0232F048
	blx P1_AeabiLmul	; 0232F04A
	lsl r1,r1,#0xa	; 0232F04E
	lsr r0,r0,#0x16	; 0232F050
	orr r0,r1	; 0232F052
	strh r0,[r5,#0x0]	; 0232F054
	mov r0,#0x0	; 0232F056
	ldrsh r1,[r5,r0]	; 0232F058
	cmp r1,#0x0	; 0232F05A
	bge loc_0232F062	; 0232F05C
	strh r0,[r5,#0x0]	; 0232F05E
	b loc_0232F06A	; 0232F060
loc_0232F062:
	cmp r1,#0xff	; 0232F062
	ble loc_0232F06A	; 0232F064
	mov r0,#0xff	; 0232F066
	strh r0,[r5,#0x0]	; 0232F068
loc_0232F06A:
	ldr r0,[pool_0232F0B4]	; 0232F06A
	ldr r0,[r0,#0x14]	; 0232F06C
	asr r1,r0,#0x1f	; 0232F06E
	ldrh r2,[r4,#0x2]	; 0232F070
	lsl r2,r2,#0x2	; 0232F072
	asr r3,r2,#0x1f	; 0232F074
	ldr r4,[pool_0232F0B4]	; 0232F076
	ldr r6,[r4,#0xc]	; 0232F078
	asr r4,r6,#0x1f	; 0232F07A
	sub r2,r2,r6	; 0232F07C
	sbc r3,r4	; 0232F07E
	blx P1_AeabiLmul	; 0232F080
	lsl r1,r1,#0xa	; 0232F084
	lsr r0,r0,#0x16	; 0232F086
	orr r0,r1	; 0232F088
	strh r0,[r5,#0x2]	; 0232F08A
	mov r0,#0x2	; 0232F08C
	ldrsh r0,[r5,r0]	; 0232F08E
	cmp r0,#0x0	; 0232F090
	bge loc_0232F0A0	; 0232F092
	mov r0,#0x0	; 0232F094
	strh r0,[r5,#0x2]	; 0232F096
	add sp,#0x4	; 0232F098
	pop {r4,r5,r6,r7}	; 0232F09A
	pop {r3}	; 0232F09C
	bx r3	; 0232F09E
loc_0232F0A0:
	cmp r0,#0xbf	; 0232F0A0
	ble loc_0232F0A8	; 0232F0A2
	mov r0,#0xbf	; 0232F0A4
	strh r0,[r5,#0x2]	; 0232F0A6
loc_0232F0A8:
	add sp,#0x4	; 0232F0A8
	pop {r4,r5,r6,r7}	; 0232F0AA
	pop {r3}	; 0232F0AC
	bx r3	; 0232F0AE
pool_0232F0B0:
loc_0232F0B0:
	.word P1_BssStart + 0x2828C	; 0232F0B0
pool_0232F0B4:
loc_0232F0B4:
	.word P1_BssStart + 0x282A4	; 0232F0B4

; ===== function loc_0232F0B8 =====
loc_0232F0B8:
	push {r4,r5,r6,r7,lr}	; 0232F0B8
	sub sp,#0x24	; 0232F0BA
	add r5,r0,#0x0	; 0232F0BC
	add r4,r1,#0x0	; 0232F0BE
	add r7,r2,#0x0	; 0232F0C0
	add r6,r3,#0x0	; 0232F0C2
	ldr r2,[pool_0232F244]	; 0232F0C4
	cmp r4,r2	; 0232F0C6
	bcs loc_0232F0DE	; 0232F0C8
	cmp r7,r2	; 0232F0CA
	bcs loc_0232F0DE	; 0232F0CC
	add r3,sp,#0x28	; 0232F0CE
	ldrh r1,[r3,#0x14]	; 0232F0D0
	cmp r1,r2	; 0232F0D2
	bcs loc_0232F0DE	; 0232F0D4
	ldrh r0,[r3,#0x18]	; 0232F0D6
	str r0,[sp,#0x20]	; 0232F0D8
	cmp r0,r2	; 0232F0DA
	bcc loc_0232F0E8	; 0232F0DC
loc_0232F0DE:
	mov r0,#0x1	; 0232F0DE
	add sp,#0x24	; 0232F0E0
	pop {r4,r5,r6,r7}	; 0232F0E2
	pop {r3}	; 0232F0E4
	bx r3	; 0232F0E6
loc_0232F0E8:
	ldr r0,[pool_0232F248]	; 0232F0E8
	cmp r6,r0	; 0232F0EA
	bcs loc_0232F104	; 0232F0EC
	ldrh r0,[r3,#0x1c]	; 0232F0EE
	ldr r2,[pool_0232F248]	; 0232F0F0
	cmp r0,r2	; 0232F0F2
	bcs loc_0232F104	; 0232F0F4
	ldrh r2,[r3,#0x10]	; 0232F0F6
	str r2,[sp,#0x1c]	; 0232F0F8
	cmp r2,#0xc0	; 0232F0FA
	bcs loc_0232F104	; 0232F0FC
	ldrh r2,[r3,#0x20]	; 0232F0FE
	cmp r2,#0xc0	; 0232F100
	bcc loc_0232F10E	; 0232F102
loc_0232F104:
	mov r0,#0x1	; 0232F104
	add sp,#0x24	; 0232F106
	pop {r4,r5,r6,r7}	; 0232F108
	pop {r3}	; 0232F10A
	bx r3	; 0232F10C
loc_0232F10E:
	cmp r6,r0	; 0232F10E
	beq loc_0232F122	; 0232F110
	ldr r0,[sp,#0x1c]	; 0232F112
	cmp r0,r2	; 0232F114
	beq loc_0232F122	; 0232F116
	cmp r4,r1	; 0232F118
	beq loc_0232F122	; 0232F11A
	ldr r0,[sp,#0x20]	; 0232F11C
	cmp r7,r0	; 0232F11E
	bne loc_0232F12C	; 0232F120
loc_0232F122:
	mov r0,#0x1	; 0232F122
	add sp,#0x24	; 0232F124
	pop {r4,r5,r6,r7}	; 0232F126
	pop {r3}	; 0232F128
	bx r3	; 0232F12A
loc_0232F12C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F12C
	str r0,[sp,#0x4]	; 0232F130
	mov r3,#0x0	; 0232F132
	ldr r0,[pool_0232F24C]	; 0232F134
	strh r3,[r0,#0x0]	; 0232F136
	add r1,sp,#0x28	; 0232F138
	ldrh r1,[r1,#0x14]	; 0232F13A
	str r1,[sp,#0xc]	; 0232F13C
	sub r1,r4,r1	; 0232F13E
	lsl r2,r1,#0x8	; 0232F140
	ldr r1,[pool_0232F250]	; 0232F142
	str r2,[r1,#0x0]	; 0232F144
	add r1,sp,#0x28	; 0232F146
	ldrh r1,[r1,#0x1c]	; 0232F148
	str r1,[sp,#0x8]	; 0232F14A
	sub r1,r6,r1	; 0232F14C
	ldr r2,[pool_0232F254]	; 0232F14E
	str r1,[r2,#0x0]	; 0232F150
	str r3,[r2,#0x4]	; 0232F152
	add r1,sp,#0x28	; 0232F154
	ldrh r1,[r1,#0x18]	; 0232F156
	str r1,[sp,#0x18]	; 0232F158
	sub r3,r7,r1	; 0232F15A
	add r1,sp,#0x28	; 0232F15C
	ldrh r1,[r1,#0x20]	; 0232F15E
	str r1,[sp,#0x10]	; 0232F160
	add r1,sp,#0x28	; 0232F162
	ldrh r2,[r1,#0x10]	; 0232F164
	str r2,[sp,#0x14]	; 0232F166
	ldr r1,[sp,#0x10]	; 0232F168
	sub r1,r2,r1	; 0232F16A
	str r1,[sp,#0x0]	; 0232F16C
	ldr r1,[pool_0232F258]	; 0232F16E
loc_0232F170:
	ldrh r2,[r0,#0x0]	; 0232F170
	and r2,r1	; 0232F172
	cmp r2,#0x0	; 0232F174
	bne loc_0232F170	; 0232F176
	ldr r1,[pool_0232F25C]	; 0232F178
	ldr r2,[r1,#0x0]	; 0232F17A
	mov r1,#0x0	; 0232F17C
	strh r1,[r0,#0x0]	; 0232F17E
	lsl r1,r3,#0x8	; 0232F180
	ldr r0,[pool_0232F250]	; 0232F182
	str r1,[r0,#0x0]	; 0232F184
	ldr r0,[pool_0232F254]	; 0232F186
	ldr r1,[sp,#0x0]	; 0232F188
	str r1,[r0,#0x0]	; 0232F18A
	mov r1,#0x0	; 0232F18C
	str r1,[r0,#0x4]	; 0232F18E
	ldr r0,[pool_0232F258]	; 0232F190
	cmp r2,r0	; 0232F192
	bge loc_0232F19C	; 0232F194
	ldr r1,[pool_0232F260]	; 0232F196
	cmp r2,r1	; 0232F198
	bge loc_0232F1AC	; 0232F19A
loc_0232F19C:
	ldr r0,[sp,#0x4]	; 0232F19C
	blx P1_Arm9RestoreIrqMask	; 0232F19E
	mov r0,#0x1	; 0232F1A2
	add sp,#0x24	; 0232F1A4
	pop {r4,r5,r6,r7}	; 0232F1A6
	pop {r3}	; 0232F1A8
	bx r3	; 0232F1AA
loc_0232F1AC:
	strh r2,[r5,#0x4]	; 0232F1AC
	ldr r1,[sp,#0xc]	; 0232F1AE
	add r1,r4,r1	; 0232F1B0
	lsl r2,r1,#0x8	; 0232F1B2
	mov r1,#0x4	; 0232F1B4
	ldrsh r1,[r5,r1]	; 0232F1B6
	ldr r3,[sp,#0x8]	; 0232F1B8
	add r3,r6,r3	; 0232F1BA
	mul r1,r3	; 0232F1BC
	sub r1,r2,r1	; 0232F1BE
	lsl r1,r1,#0x9	; 0232F1C0
	asr r2,r1,#0x10	; 0232F1C2
	cmp r2,r0	; 0232F1C4
	bge loc_0232F1CE	; 0232F1C6
	ldr r1,[pool_0232F260]	; 0232F1C8
	cmp r2,r1	; 0232F1CA
	bge loc_0232F1DE	; 0232F1CC
loc_0232F1CE:
	ldr r0,[sp,#0x4]	; 0232F1CE
	blx P1_Arm9RestoreIrqMask	; 0232F1D0
	mov r0,#0x1	; 0232F1D4
	add sp,#0x24	; 0232F1D6
	pop {r4,r5,r6,r7}	; 0232F1D8
	pop {r3}	; 0232F1DA
	bx r3	; 0232F1DC
loc_0232F1DE:
	strh r2,[r5,#0x0]	; 0232F1DE
	ldr r1,[pool_0232F24C]	; 0232F1E0
loc_0232F1E2:
	ldrh r2,[r1,#0x0]	; 0232F1E2
	and r2,r0	; 0232F1E4
	cmp r2,#0x0	; 0232F1E6
	bne loc_0232F1E2	; 0232F1E8
	ldr r0,[pool_0232F25C]	; 0232F1EA
	ldr r4,[r0,#0x0]	; 0232F1EC
	ldr r0,[sp,#0x4]	; 0232F1EE
	blx P1_Arm9RestoreIrqMask	; 0232F1F0
	ldr r1,[pool_0232F258]	; 0232F1F4
	cmp r4,r1	; 0232F1F6
	bge loc_0232F200	; 0232F1F8
	ldr r0,[pool_0232F260]	; 0232F1FA
	cmp r4,r0	; 0232F1FC
	bge loc_0232F20A	; 0232F1FE
loc_0232F200:
	mov r0,#0x1	; 0232F200
	add sp,#0x24	; 0232F202
	pop {r4,r5,r6,r7}	; 0232F204
	pop {r3}	; 0232F206
	bx r3	; 0232F208
loc_0232F20A:
	strh r4,[r5,#0x6]	; 0232F20A
	ldr r2,[sp,#0x18]	; 0232F20C
	add r2,r7,r2	; 0232F20E
	lsl r3,r2,#0x8	; 0232F210
	mov r2,#0x6	; 0232F212
	ldrsh r2,[r5,r2]	; 0232F214
	ldr r6,[sp,#0x14]	; 0232F216
	ldr r4,[sp,#0x10]	; 0232F218
	add r4,r6,r4	; 0232F21A
	mul r2,r4	; 0232F21C
	sub r2,r3,r2	; 0232F21E
	lsl r2,r2,#0x9	; 0232F220
	asr r2,r2,#0x10	; 0232F222
	cmp r2,r1	; 0232F224
	bge loc_0232F22C	; 0232F226
	cmp r2,r0	; 0232F228
	bge loc_0232F236	; 0232F22A
loc_0232F22C:
	mov r0,#0x1	; 0232F22C
	add sp,#0x24	; 0232F22E
	pop {r4,r5,r6,r7}	; 0232F230
	pop {r3}	; 0232F232
	bx r3	; 0232F234
loc_0232F236:
	strh r2,[r5,#0x2]	; 0232F236
	mov r0,#0x0	; 0232F238
	add sp,#0x24	; 0232F23A
	pop {r4,r5,r6,r7}	; 0232F23C
	pop {r3}	; 0232F23E
	bx r3	; 0232F240
	.byte 0xC0, 0x46	; 0232F244
pool_0232F244:
loc_0232F244:
	.word 0x00001000	; 0232F244
pool_0232F248:
loc_0232F248:
	.word 0x00000100	; 0232F248
pool_0232F24C:
loc_0232F24C:
	.word REG_DIVCNT	; 0232F24C
pool_0232F250:
loc_0232F250:
	.word REG_DIV_NUMER	; 0232F250
pool_0232F254:
loc_0232F254:
	.word REG_DIV_DENOM	; 0232F254
pool_0232F258:
loc_0232F258:
	.word 0x00008000	; 0232F258
pool_0232F25C:
loc_0232F25C:
	.word REG_DIV_RESULT	; 0232F25C
pool_0232F260:
loc_0232F260:
	.word 0xFFFF8000	; 0232F260

; ===== function loc_0232F264 =====
loc_0232F264:
	push {r4,lr}	; 0232F264
	add r4,r0,#0x0	; 0232F266
	mov r0,#0x1	; 0232F268
	bl loc_0232EFE0	; 0232F26A
	ldr r1,[pool_0232F294]	; 0232F26E
	ldrh r2,[r1,#0x34]	; 0232F270
	mov r0,#0x1	; 0232F272
	and r2,r0	; 0232F274
	cmp r2,#0x0	; 0232F276
	bne loc_0232F28C	; 0232F278
	ldrh r0,[r1,#0x4]	; 0232F27A
	strh r0,[r4,#0x0]	; 0232F27C
	ldrh r0,[r1,#0x6]	; 0232F27E
	strh r0,[r4,#0x2]	; 0232F280
	ldrh r0,[r1,#0x8]	; 0232F282
	strh r0,[r4,#0x4]	; 0232F284
	ldrh r0,[r1,#0xa]	; 0232F286
	strh r0,[r4,#0x6]	; 0232F288
	mov r0,#0x0	; 0232F28A
loc_0232F28C:
	pop {r4}	; 0232F28C
	pop {r3}	; 0232F28E
	bx r3	; 0232F290
	.byte 0xC0, 0x46	; 0232F294
pool_0232F294:
loc_0232F294:
	.word P1_BssStart + 0x2828C	; 0232F294

; ===== function loc_0232F298 =====
loc_0232F298:
	push {r4,lr}	; 0232F298
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F29A
	add r4,r0,#0x0	; 0232F29E
	mov r0,#0x6	; 0232F2A0
	ldr r1,[pool_0232F2F8]	; 0232F2A2
	mov r2,#0x0	; 0232F2A4
	bl loc_0232ED98	; 0232F2A6
	cmp r0,#0x0	; 0232F2AA
	blt loc_0232F2B2	; 0232F2AC
	mov r0,#0x1	; 0232F2AE
	b loc_0232F2B4	; 0232F2B0
loc_0232F2B2:
	mov r0,#0x0	; 0232F2B2
loc_0232F2B4:
	cmp r0,#0x0	; 0232F2B4
	bne loc_0232F2DC	; 0232F2B6
	add r0,r4,#0x0	; 0232F2B8
	blx P1_Arm9RestoreIrqMask	; 0232F2BA
	ldr r1,[pool_0232F2FC]	; 0232F2BE
	ldrh r2,[r1,#0x34]	; 0232F2C0
	mov r0,#0x1	; 0232F2C2
	orr r2,r0	; 0232F2C4
	strh r2,[r1,#0x34]	; 0232F2C6
	ldr r3,[r1,#0x0]	; 0232F2C8
	cmp r3,#0x0	; 0232F2CA
	beq loc_0232F2F2	; 0232F2CC
	mov r0,#0x0	; 0232F2CE
	mov r1,#0x4	; 0232F2D0
	add r2,r0,#0x0	; 0232F2D2
	blx r3	; 0232F2D4
	pop {r4}	; 0232F2D6
	pop {r3}	; 0232F2D8
	bx r3	; 0232F2DA
loc_0232F2DC:
	ldr r1,[pool_0232F2FC]	; 0232F2DC
	ldrh r2,[r1,#0x36]	; 0232F2DE
	mov r0,#0x1	; 0232F2E0
	orr r2,r0	; 0232F2E2
	strh r2,[r1,#0x36]	; 0232F2E4
	ldrh r2,[r1,#0x34]	; 0232F2E6
	bic r2,r0	; 0232F2E8
	strh r2,[r1,#0x34]	; 0232F2EA
	add r0,r4,#0x0	; 0232F2EC
	blx P1_Arm9RestoreIrqMask	; 0232F2EE
loc_0232F2F2:
	pop {r4}	; 0232F2F2
	pop {r3}	; 0232F2F4
	bx r3	; 0232F2F6
pool_0232F2F8:
loc_0232F2F8:
	.word 0x03000000	; 0232F2F8
pool_0232F2FC:
loc_0232F2FC:
	.word P1_BssStart + 0x2828C	; 0232F2FC

; ===== function loc_0232F300 =====
loc_0232F300:
	push {r4,r5,r6,r7,lr}	; 0232F300
	sub sp,#0x4	; 0232F302
	add r4,r0,#0x0	; 0232F304
	cmp r4,#0x0	; 0232F306
	bne loc_0232F318	; 0232F308
	mov r1,#0x0	; 0232F30A
	ldr r0,[pool_0232F398]	; 0232F30C
	strh r1,[r0,#0x30]	; 0232F30E
	add sp,#0x4	; 0232F310
	pop {r4,r5,r6,r7}	; 0232F312
	pop {r3}	; 0232F314
	bx r3	; 0232F316
loc_0232F318:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F318
	add r6,r0,#0x0	; 0232F31C
	mov r7,#0x4	; 0232F31E
	ldrsh r5,[r4,r7]	; 0232F320
	mov r3,#0x0	; 0232F322
	ldr r2,[pool_0232F39C]	; 0232F324
	strh r3,[r2,#0x0]	; 0232F326
	ldr r1,[pool_0232F3A0]	; 0232F328
	ldr r0,[pool_0232F3A4]	; 0232F32A
	str r1,[r0,#0x0]	; 0232F32C
	ldr r0,[pool_0232F3A8]	; 0232F32E
	str r5,[r0,#0x0]	; 0232F330
	str r3,[r0,#0x4]	; 0232F332
	ldrsh r1,[r4,r3]	; 0232F334
	ldr r0,[pool_0232F398]	; 0232F336
	str r1,[r0,#0x18]	; 0232F338
	ldrsh r1,[r4,r7]	; 0232F33A
	str r1,[r0,#0x1c]	; 0232F33C
	ldr r0,[pool_0232F3AC]	; 0232F33E
loc_0232F340:
	ldrh r1,[r2,#0x0]	; 0232F340
	and r1,r0	; 0232F342
	cmp r1,#0x0	; 0232F344
	bne loc_0232F340	; 0232F346
	ldr r0,[pool_0232F3B0]	; 0232F348
	ldr r0,[r0,#0x0]	; 0232F34A
	ldr r3,[pool_0232F398]	; 0232F34C
	str r0,[r3,#0x20]	; 0232F34E
	mov r7,#0x6	; 0232F350
	ldrsh r1,[r4,r7]	; 0232F352
	mov r0,#0x0	; 0232F354
	strh r0,[r2,#0x0]	; 0232F356
	ldr r5,[pool_0232F3A0]	; 0232F358
	ldr r2,[pool_0232F3A4]	; 0232F35A
	str r5,[r2,#0x0]	; 0232F35C
	ldr r2,[pool_0232F3A8]	; 0232F35E
	str r1,[r2,#0x0]	; 0232F360
	str r0,[r2,#0x4]	; 0232F362
	mov r0,#0x2	; 0232F364
	ldrsh r0,[r4,r0]	; 0232F366
	str r0,[r3,#0x24]	; 0232F368
	ldrsh r0,[r4,r7]	; 0232F36A
	str r0,[r3,#0x28]	; 0232F36C
	ldr r1,[pool_0232F39C]	; 0232F36E
	ldr r0,[pool_0232F3AC]	; 0232F370
loc_0232F372:
	ldrh r2,[r1,#0x0]	; 0232F372
	and r2,r0	; 0232F374
	cmp r2,#0x0	; 0232F376
	bne loc_0232F372	; 0232F378
	ldr r0,[pool_0232F3B0]	; 0232F37A
	ldr r1,[r0,#0x0]	; 0232F37C
	ldr r0,[pool_0232F398]	; 0232F37E
	str r1,[r0,#0x2c]	; 0232F380
	add r0,r6,#0x0	; 0232F382
	blx P1_Arm9RestoreIrqMask	; 0232F384
	mov r1,#0x1	; 0232F388
	ldr r0,[pool_0232F398]	; 0232F38A
	strh r1,[r0,#0x30]	; 0232F38C
	add sp,#0x4	; 0232F38E
	pop {r4,r5,r6,r7}	; 0232F390
	pop {r3}	; 0232F392
	bx r3	; 0232F394
	.byte 0xC0, 0x46	; 0232F398
pool_0232F398:
loc_0232F398:
	.word P1_BssStart + 0x2828C	; 0232F398
pool_0232F39C:
loc_0232F39C:
	.word REG_DIVCNT	; 0232F39C
pool_0232F3A0:
loc_0232F3A0:
	.word 0x10000000	; 0232F3A0
pool_0232F3A4:
loc_0232F3A4:
	.word REG_DIV_NUMER	; 0232F3A4
pool_0232F3A8:
loc_0232F3A8:
	.word REG_DIV_DENOM	; 0232F3A8
pool_0232F3AC:
loc_0232F3AC:
	.word 0x00008000	; 0232F3AC
pool_0232F3B0:
loc_0232F3B0:
	.word REG_DIV_RESULT	; 0232F3B0

; ===== function loc_0232F3B4 =====
loc_0232F3B4:
	push {r4,r5,lr}	; 0232F3B4
	sub sp,#0x4	; 0232F3B6
	ldr r0,[pool_0232F3FC]	; 0232F3B8
	ldrh r1,[r0,#0x0]	; 0232F3BA
	cmp r1,#0x0	; 0232F3BC
	bne loc_0232F3F2	; 0232F3BE
	mov r1,#0x1	; 0232F3C0
	strh r1,[r0,#0x0]	; 0232F3C2
	bl loc_0232ECB8	; 0232F3C4
	mov r1,#0x0	; 0232F3C8
	ldr r0,[pool_0232F400]	; 0232F3CA
	strh r1,[r0,#0xc]	; 0232F3CC
	str r1,[r0,#0x0]	; 0232F3CE
	str r1,[r0,#0x10]	; 0232F3D0
	strh r1,[r0,#0x32]	; 0232F3D2
	strh r1,[r0,#0x30]	; 0232F3D4
	strh r1,[r0,#0x36]	; 0232F3D6
	strh r1,[r0,#0x34]	; 0232F3D8
	mov r5,#0x6	; 0232F3DA
	mov r4,#0x1	; 0232F3DC
loc_0232F3DE:
	add r0,r5,#0x0	; 0232F3DE
	add r1,r4,#0x0	; 0232F3E0
	bl loc_0232EE2C	; 0232F3E2
	cmp r0,#0x0	; 0232F3E6
	beq loc_0232F3DE	; 0232F3E8
	mov r0,#0x6	; 0232F3EA
	ldr r1,[pool_0232F404]	; 0232F3EC
	bl loc_0232EE58	; 0232F3EE
loc_0232F3F2:
	add sp,#0x4	; 0232F3F2
	pop {r4,r5}	; 0232F3F4
	pop {r3}	; 0232F3F6
	bx r3	; 0232F3F8
	.byte 0xC0, 0x46	; 0232F3FC
pool_0232F3FC:
loc_0232F3FC:
	.word P1_BssStart + 0x28288	; 0232F3FC
pool_0232F400:
loc_0232F400:
	.word P1_BssStart + 0x2828C	; 0232F400
pool_0232F404:
loc_0232F404:
	.word 0x0232F409	; 0232F404

; ===== function loc_0232F408 =====
	push {r4,r5,r6,lr}	; 0232F408
	sub sp,#0x8	; 0232F40A
	lsl r0,r1,#0x10	; 0232F40C
	lsr r3,r0,#0x10	; 0232F40E
	ldr r0,[pool_0232F58C]	; 0232F410
	add r4,r3,#0x0	; 0232F412
	and r4,r0	; 0232F414
	lsl r0,r4,#0x8	; 0232F416
	lsr r0,r0,#0x10	; 0232F418
	cmp r2,#0x0	; 0232F41A
	beq loc_0232F440	; 0232F41C
	ldr r1,[pool_0232F590]	; 0232F41E
	ldrh r3,[r1,#0x34]	; 0232F420
	mov r2,#0x1	; 0232F422
	lsl r2,r0	; 0232F424
	orr r3,r2	; 0232F426
	strh r3,[r1,#0x34]	; 0232F428
	ldr r3,[r1,#0x0]	; 0232F42A
	cmp r3,#0x0	; 0232F42C
	bne loc_0232F432	; 0232F42E
	b loc_0232F582	; 0232F430
loc_0232F432:
	mov r1,#0x4	; 0232F432
	mov r2,#0x0	; 0232F434
	blx r3	; 0232F436
	add sp,#0x8	; 0232F438
	pop {r4,r5,r6}	; 0232F43A
	pop {r3}	; 0232F43C
	bx r3	; 0232F43E
loc_0232F440:
	cmp r0,#0x10	; 0232F440
	bne loc_0232F4B0	; 0232F442
	ldr r1,[pool_0232F590]	; 0232F444
	ldrh r2,[r1,#0xc]	; 0232F446
	add r2,r2,#0x1	; 0232F448
	strh r2,[r1,#0xc]	; 0232F44A
	ldrh r3,[r1,#0xc]	; 0232F44C
	ldrh r2,[r1,#0x14]	; 0232F44E
	cmp r3,r2	; 0232F450
	bcc loc_0232F458	; 0232F452
	mov r2,#0x0	; 0232F454
	strh r2,[r1,#0xc]	; 0232F456
loc_0232F458:
	ldr r2,[pool_0232F590]	; 0232F458
	ldr r3,[r2,#0x10]	; 0232F45A
	ldrh r1,[r2,#0xc]	; 0232F45C
	lsl r1,r1,#0x3	; 0232F45E
	add r4,r3,r1	; 0232F460
	ldr r5,[pool_0232F594]	; 0232F462
	ldrh r6,[r5,#0x0]	; 0232F464
	add r5,sp,#0x0	; 0232F466
	strh r6,[r5,#0x0]	; 0232F468
	ldr r6,[pool_0232F598]	; 0232F46A
	ldrh r6,[r6,#0x0]	; 0232F46C
	strh r6,[r5,#0x2]	; 0232F46E
	ldr r5,[sp,#0x0]	; 0232F470
	lsl r5,r5,#0x14	; 0232F472
	lsr r5,r5,#0x14	; 0232F474
	strh r5,[r3,r1]	; 0232F476
	ldr r1,[sp,#0x0]	; 0232F478
	lsl r1,r1,#0x8	; 0232F47A
	lsr r1,r1,#0x14	; 0232F47C
	strh r1,[r4,#0x2]	; 0232F47E
	ldr r1,[sp,#0x0]	; 0232F480
	lsl r1,r1,#0x7	; 0232F482
	lsr r1,r1,#0x1f	; 0232F484
	lsl r1,r1,#0x18	; 0232F486
	lsr r1,r1,#0x18	; 0232F488
	strh r1,[r4,#0x4]	; 0232F48A
	ldr r1,[sp,#0x0]	; 0232F48C
	lsl r1,r1,#0x5	; 0232F48E
	lsr r1,r1,#0x1e	; 0232F490
	lsl r1,r1,#0x18	; 0232F492
	lsr r1,r1,#0x18	; 0232F494
	strh r1,[r4,#0x6]	; 0232F496
	ldr r3,[r2,#0x0]	; 0232F498
	cmp r3,#0x0	; 0232F49A
	beq loc_0232F582	; 0232F49C
	mov r1,#0x0	; 0232F49E
	ldrh r2,[r2,#0xc]	; 0232F4A0
	lsl r2,r2,#0x18	; 0232F4A2
	lsr r2,r2,#0x18	; 0232F4A4
	blx r3	; 0232F4A6
	add sp,#0x8	; 0232F4A8
	pop {r4,r5,r6}	; 0232F4AA
	pop {r3}	; 0232F4AC
	bx r3	; 0232F4AE
loc_0232F4B0:
	ldr r2,[pool_0232F59C]	; 0232F4B0
	and r1,r2	; 0232F4B2
	cmp r1,#0x0	; 0232F4B4
	beq loc_0232F582	; 0232F4B6
	lsl r1,r3,#0x18	; 0232F4B8
	lsr r1,r1,#0x18	; 0232F4BA
	cmp r1,#0x4	; 0232F4BC
	bhi loc_0232F57E	; 0232F4BE
	add r1,r1,r1	; 0232F4C0
P1_SwitchIndexPC_0232F4C0:
	add r1,pc	; 0232F4C2
	ldrh r1,[r1,#(P1_SwitchTable_0232F4C0 - (P1_SwitchIndexPC_0232F4C0 + 4))]	; 0232F4C4
	lsl r1,r1,#0x10	; 0232F4C6
	asr r1,r1,#0x10	; 0232F4C8
P1_SwitchTargetPC_0232F4C0:
	add r1,pc	; 0232F4CA
	bx r1	; 0232F4CC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232F4C0:
	.halfword (loc_0232F4D8 + 1) - (P1_SwitchTargetPC_0232F4C0 + 4)
	.halfword (loc_0232F57E + 1) - (P1_SwitchTargetPC_0232F4C0 + 4)
	.halfword (loc_0232F550 + 1) - (P1_SwitchTargetPC_0232F4C0 + 4)
	.halfword (loc_0232F554 + 1) - (P1_SwitchTargetPC_0232F4C0 + 4)
	.halfword (loc_0232F54C + 1) - (P1_SwitchTargetPC_0232F4C0 + 4)
P1_SwitchTable_0232F4C0End:
loc_0232F4D8:
	cmp r0,#0x0	; 0232F4D8
	beq loc_0232F4E6	; 0232F4DA
	cmp r0,#0x1	; 0232F4DC
	beq loc_0232F51E	; 0232F4DE
	cmp r0,#0x2	; 0232F4E0
	beq loc_0232F526	; 0232F4E2
	b loc_0232F52C	; 0232F4E4
loc_0232F4E6:
	ldr r1,[pool_0232F594]	; 0232F4E6
	ldrh r2,[r1,#0x0]	; 0232F4E8
	add r1,sp,#0x0	; 0232F4EA
	strh r2,[r1,#0x4]	; 0232F4EC
	ldr r2,[pool_0232F598]	; 0232F4EE
	ldrh r2,[r2,#0x0]	; 0232F4F0
	strh r2,[r1,#0x6]	; 0232F4F2
	ldr r1,[sp,#0x4]	; 0232F4F4
	lsl r2,r1,#0x14	; 0232F4F6
	lsr r2,r2,#0x14	; 0232F4F8
	ldr r3,[pool_0232F590]	; 0232F4FA
	strh r2,[r3,#0x4]	; 0232F4FC
	lsl r2,r1,#0x8	; 0232F4FE
	lsr r2,r2,#0x14	; 0232F500
	strh r2,[r3,#0x6]	; 0232F502
	lsl r2,r1,#0x7	; 0232F504
	lsr r2,r2,#0x1f	; 0232F506
	lsl r2,r2,#0x18	; 0232F508
	lsr r2,r2,#0x18	; 0232F50A
	strh r2,[r3,#0x8]	; 0232F50C
	lsl r1,r1,#0x5	; 0232F50E
	lsr r1,r1,#0x1e	; 0232F510
	lsl r1,r1,#0x18	; 0232F512
	lsr r1,r1,#0x18	; 0232F514
	strh r1,[r3,#0xa]	; 0232F516
	mov r1,#0x0	; 0232F518
	strh r1,[r3,#0x32]	; 0232F51A
	b loc_0232F52C	; 0232F51C
loc_0232F51E:
	mov r2,#0x2	; 0232F51E
	ldr r1,[pool_0232F590]	; 0232F520
	strh r2,[r1,#0x32]	; 0232F522
	b loc_0232F52C	; 0232F524
loc_0232F526:
	mov r2,#0x0	; 0232F526
	ldr r1,[pool_0232F590]	; 0232F528
	strh r2,[r1,#0x32]	; 0232F52A
loc_0232F52C:
	ldr r1,[pool_0232F590]	; 0232F52C
	ldrh r3,[r1,#0x36]	; 0232F52E
	mov r2,#0x1	; 0232F530
	lsl r2,r0	; 0232F532
	bic r3,r2	; 0232F534
	strh r3,[r1,#0x36]	; 0232F536
	ldr r3,[r1,#0x0]	; 0232F538
	cmp r3,#0x0	; 0232F53A
	beq loc_0232F582	; 0232F53C
	mov r1,#0x0	; 0232F53E
	add r2,r1,#0x0	; 0232F540
	blx r3	; 0232F542
	add sp,#0x8	; 0232F544
	pop {r4,r5,r6}	; 0232F546
	pop {r3}	; 0232F548
	bx r3	; 0232F54A
loc_0232F54C:
	mov r1,#0x3	; 0232F54C
	b loc_0232F556	; 0232F54E
loc_0232F550:
	mov r1,#0x1	; 0232F550
	b loc_0232F556	; 0232F552
loc_0232F554:
	mov r1,#0x2	; 0232F554
loc_0232F556:
	mov r4,#0x1	; 0232F556
	lsl r4,r0	; 0232F558
	ldr r2,[pool_0232F590]	; 0232F55A
	ldrh r3,[r2,#0x34]	; 0232F55C
	orr r3,r4	; 0232F55E
	strh r3,[r2,#0x34]	; 0232F560
	ldrh r3,[r2,#0x36]	; 0232F562
	bic r3,r4	; 0232F564
	strh r3,[r2,#0x36]	; 0232F566
	ldr r3,[r2,#0x0]	; 0232F568
	cmp r3,#0x0	; 0232F56A
	beq loc_0232F582	; 0232F56C
	mov r2,#0xff	; 0232F56E
	and r1,r2	; 0232F570
	mov r2,#0x0	; 0232F572
	blx r3	; 0232F574
	add sp,#0x8	; 0232F576
	pop {r4,r5,r6}	; 0232F578
	pop {r3}	; 0232F57A
	bx r3	; 0232F57C
loc_0232F57E:
	bl loc_0232C158	; 0232F57E
loc_0232F582:
	add sp,#0x8	; 0232F582
	pop {r4,r5,r6}	; 0232F584
	pop {r3}	; 0232F586
	bx r3	; 0232F588
	.byte 0xC0, 0x46	; 0232F58C
pool_0232F58C:
loc_0232F58C:
	.word 0x00007F00	; 0232F58C
pool_0232F590:
loc_0232F590:
	.word P1_BssStart + 0x2828C	; 0232F590
pool_0232F594:
loc_0232F594:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 0232F594
pool_0232F598:
loc_0232F598:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 0232F598
pool_0232F59C:
loc_0232F59C:
	.word 0x01000000	; 0232F59C

; ===== function loc_0232F5A0 =====
loc_0232F5A0:
	push {r4,lr}	; 0232F5A0
	cmp r0,#0x0	; 0232F5A2
	beq loc_0232F5E6	; 0232F5A4
	cmp r0,#0x1	; 0232F5A6
	bne loc_0232F60E	; 0232F5A8
	cmp r2,#0x0	; 0232F5AA
	bne loc_0232F5C4	; 0232F5AC
	ldr r0,[pool_0232F618]	; 0232F5AE
	ldr r2,[r0,#0x0]	; 0232F5B0
	ldr r0,[pool_0232F61C]	; 0232F5B2
	ldr r0,[r0,#0x0]	; 0232F5B4
	sub r0,r2,r0	; 0232F5B6
	cmp r0,#0x7	; 0232F5B8
	bhi loc_0232F5C4	; 0232F5BA
	mov r0,#0x0	; 0232F5BC
	pop {r4}	; 0232F5BE
	pop {r3}	; 0232F5C0
	bx r3	; 0232F5C2
loc_0232F5C4:
	cmp r3,#0x0	; 0232F5C4
	beq loc_0232F5D0	; 0232F5C6
	add r0,r1,#0x0	; 0232F5C8
	bl loc_0232F7D8	; 0232F5CA
	b loc_0232F5DA	; 0232F5CE
loc_0232F5D0:
	add r0,r1,#0x0	; 0232F5D0
	mov r1,#0x0	; 0232F5D2
	add r2,r1,#0x0	; 0232F5D4
	bl loc_0232F7F8	; 0232F5D6
loc_0232F5DA:
	ldr r2,[pool_0232F620]	; 0232F5DA
	ldrh r1,[r2,#0x0]	; 0232F5DC
	mov r0,#0x1	; 0232F5DE
	orr r1,r0	; 0232F5E0
	strh r1,[r2,#0x0]	; 0232F5E2
	b loc_0232F60E	; 0232F5E4
loc_0232F5E6:
	ldr r4,[pool_0232F620]	; 0232F5E6
	ldrh r2,[r4,#0x0]	; 0232F5E8
	mov r0,#0x1	; 0232F5EA
	bic r2,r0	; 0232F5EC
	strh r2,[r4,#0x0]	; 0232F5EE
	ldr r0,[pool_0232F618]	; 0232F5F0
	ldr r2,[r0,#0x0]	; 0232F5F2
	ldr r0,[pool_0232F61C]	; 0232F5F4
	str r2,[r0,#0x0]	; 0232F5F6
	cmp r3,#0x0	; 0232F5F8
	beq loc_0232F604	; 0232F5FA
	add r0,r1,#0x0	; 0232F5FC
	bl loc_0232F7D8	; 0232F5FE
	b loc_0232F60E	; 0232F602
loc_0232F604:
	add r0,r1,#0x0	; 0232F604
	mov r1,#0x0	; 0232F606
	add r2,r1,#0x0	; 0232F608
	bl loc_0232F7F8	; 0232F60A
loc_0232F60E:
	mov r0,#0x1	; 0232F60E
	pop {r4}	; 0232F610
	pop {r3}	; 0232F612
	bx r3	; 0232F614
	.byte 0xC0, 0x46	; 0232F618
pool_0232F618:
loc_0232F618:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232F618
pool_0232F61C:
loc_0232F61C:
	.word P1_BssStart + 0x282D0	; 0232F61C
pool_0232F620:
loc_0232F620:
	.word REG_POWERCNT	; 0232F620

; ===== function loc_0232F624 =====
loc_0232F624:
	push {r4,r5,r6,r7,lr}	; 0232F624
	sub sp,#0xc	; 0232F626
	add r5,r0,#0x0	; 0232F628
	add r4,r1,#0x0	; 0232F62A
	str r2,[sp,#0x0]	; 0232F62C
	mov r6,#0x0	; 0232F62E
	ldr r0,[pool_0232F6D8]	; 0232F630
	ldrh r7,[r0,#0x0]	; 0232F632
	strh r6,[r0,#0x0]	; 0232F634
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F636
	str r0,[sp,#0x4]	; 0232F63A
	ldr r0,[pool_0232F6DC]	; 0232F63C
	bl loc_0232AD24	; 0232F63E
	str r0,[sp,#0x8]	; 0232F642
	ldr r0,[pool_0232F6E0]	; 0232F644
	bl loc_0232AD74	; 0232F646
	ldr r0,[sp,#0x4]	; 0232F64A
	blx P1_Arm9RestoreIrqMask	; 0232F64C
	ldr r1,[pool_0232F6D8]	; 0232F650
	ldrh r0,[r1,#0x0]	; 0232F652
	mov r0,#0x1	; 0232F654
	strh r0,[r1,#0x0]	; 0232F656
	mov r0,#0x10	; 0232F658
	add r1,r5,#0x0	; 0232F65A
	and r1,r0	; 0232F65C
	cmp r1,#0x0	; 0232F65E
	beq loc_0232F66E	; 0232F660
	bl loc_0232C240	; 0232F662
	cmp r0,#0x0	; 0232F666
	bne loc_0232F66E	; 0232F668
	mov r0,#0x10	; 0232F66A
	bic r5,r0	; 0232F66C
loc_0232F66E:
	ldr r0,[sp,#0x0]	; 0232F66E
	orr r4,r0	; 0232F670
loc_0232F672:
	lsl r0,r5,#0x10	; 0232F672
	lsr r0,r0,#0x10	; 0232F674
	lsl r1,r4,#0x10	; 0232F676
	lsr r1,r1,#0x10	; 0232F678
	bl loc_0232F900	; 0232F67A
	cmp r0,#0x0	; 0232F67E
	bne loc_0232F672	; 0232F680
	blx P1_Arm9WaitForInterrupt	; 0232F682
	ldr r0,[pool_0232F6E4]	; 0232F686
	blx P1_Arm9BusyWaitByLoop4	; 0232F688
	mov r0,#0x8	; 0232F68C
	and r5,r0	; 0232F68E
	cmp r5,#0x0	; 0232F690
	beq loc_0232F6A2	; 0232F692
	ldr r0,[pool_0232F6E8]	; 0232F694
	ldr r1,[r0,#0x0]	; 0232F696
	ldr r0,[pool_0232F6EC]	; 0232F698
	and r1,r0	; 0232F69A
	cmp r1,#0x0	; 0232F69C
	beq loc_0232F6A2	; 0232F69E
	mov r6,#0x1	; 0232F6A0
loc_0232F6A2:
	cmp r6,#0x0	; 0232F6A2
	bne loc_0232F6B2	; 0232F6A4
	mov r0,#0x1	; 0232F6A6
	add r1,r0,#0x0	; 0232F6A8
	add r2,r0,#0x0	; 0232F6AA
	mov r3,#0x0	; 0232F6AC
	bl loc_0232F5A0	; 0232F6AE
loc_0232F6B2:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F6B2
	ldr r0,[sp,#0x8]	; 0232F6B6
	bl loc_0232AD74	; 0232F6B8
	ldr r0,[sp,#0x4]	; 0232F6BC
	blx P1_Arm9RestoreIrqMask	; 0232F6BE
	ldr r1,[pool_0232F6D8]	; 0232F6C2
	ldrh r0,[r1,#0x0]	; 0232F6C4
	strh r7,[r1,#0x0]	; 0232F6C6
	cmp r6,#0x0	; 0232F6C8
	beq loc_0232F6D0	; 0232F6CA
	bl loc_0232F730	; 0232F6CC
loc_0232F6D0:
	add sp,#0xc	; 0232F6D0
	pop {r4,r5,r6,r7}	; 0232F6D2
	pop {r3}	; 0232F6D4
	bx r3	; 0232F6D6
pool_0232F6D8:
loc_0232F6D8:
	.word REG_IME	; 0232F6D8
pool_0232F6DC:
loc_0232F6DC:
	.word 0x003FFFFF	; 0232F6DC
pool_0232F6E0:
loc_0232F6E0:
	.word 0x00040000	; 0232F6E0
pool_0232F6E4:
loc_0232F6E4:
	.word 0x00332340	; 0232F6E4
pool_0232F6E8:
loc_0232F6E8:
	.word REG_IF	; 0232F6E8
pool_0232F6EC:
loc_0232F6EC:
	.word 0x00100000	; 0232F6EC

; ===== function loc_0232F6F0 =====
loc_0232F6F0:
	push {r4,r5,r6,lr}	; 0232F6F0
	add r5,r0,#0x0	; 0232F6F2
	mov r4,#0x8	; 0232F6F4
	mov r6,#0x0	; 0232F6F6
loc_0232F6F8:
	add r0,r4,#0x0	; 0232F6F8
	add r1,r5,#0x0	; 0232F6FA
	add r2,r6,#0x0	; 0232F6FC
	bl loc_0232ED98	; 0232F6FE
	cmp r0,#0x0	; 0232F702
	bne loc_0232F6F8	; 0232F704
	pop {r4,r5,r6}	; 0232F706
	pop {r3}	; 0232F708
	bx r3	; 0232F70A

; ===== function loc_0232F70C =====
loc_0232F70C:
	push {r4,lr}	; 0232F70C
	sub sp,#0x8	; 0232F70E
	add r4,r0,#0x0	; 0232F710
	mov r0,#0x1	; 0232F712
	add r1,sp,#0x0	; 0232F714
	bl loc_0232F834	; 0232F716
	cmp r0,#0x0	; 0232F71A
	bne loc_0232F728	; 0232F71C
	cmp r4,#0x0	; 0232F71E
	beq loc_0232F728	; 0232F720
	add r1,sp,#0x0	; 0232F722
	ldrh r1,[r1,#0x0]	; 0232F724
	str r1,[r4,#0x0]	; 0232F726
loc_0232F728:
	add sp,#0x8	; 0232F728
	pop {r4}	; 0232F72A
	pop {r3}	; 0232F72C
	bx r3	; 0232F72E

; ===== function loc_0232F730 =====
loc_0232F730:
	push {lr}	; 0232F730
	sub sp,#0x4	; 0232F732
	ldr r0,[pool_0232F74C]	; 0232F734
	add r1,sp,#0x0	; 0232F736
	bl loc_0232F750	; 0232F738
	cmp r0,#0x0	; 0232F73C
	bne loc_0232F746	; 0232F73E
	bl loc_0232FABC	; 0232F740
	ldr r0,[sp,#0x0]	; 0232F744
loc_0232F746:
	add sp,#0x4	; 0232F746
	pop {r3}	; 0232F748
	bx r3	; 0232F74A
pool_0232F74C:
loc_0232F74C:
	.word 0x0232FAB9	; 0232F74C

; ===== function loc_0232F750 =====
loc_0232F750:
	add r3,r0,#0x0	; 0232F750
	add r2,r1,#0x0	; 0232F752
	mov r0,#0xe	; 0232F754
	add r1,r3,#0x0	; 0232F756
	ldr r3,[pool_0232F75C]	; 0232F758
	bx r3	; 0232F75A
pool_0232F75C:
loc_0232F75C:
	.word loc_0232F8AC + 1	; 0232F75C

; ===== function loc_0232F760 =====
loc_0232F760:
	push {lr}	; 0232F760
	sub sp,#0x4	; 0232F762
	ldr r2,[pool_0232F77C]	; 0232F764
	add r3,sp,#0x0	; 0232F766
	bl loc_0232F780	; 0232F768
	cmp r0,#0x0	; 0232F76C
	bne loc_0232F776	; 0232F76E
	bl loc_0232FABC	; 0232F770
	ldr r0,[sp,#0x0]	; 0232F774
loc_0232F776:
	add sp,#0x4	; 0232F776
	pop {r3}	; 0232F778
	bx r3	; 0232F77A
pool_0232F77C:
loc_0232F77C:
	.word 0x0232FAB9	; 0232F77C

; ===== function loc_0232F780 =====
loc_0232F780:
	push {r4,lr}	; 0232F780
	mov r4,#0x0	; 0232F782
	cmp r0,#0x0	; 0232F784
	bne loc_0232F796	; 0232F786
	cmp r1,#0x1	; 0232F788
	bne loc_0232F78E	; 0232F78A
	mov r4,#0x6	; 0232F78C
loc_0232F78E:
	cmp r1,#0x0	; 0232F78E
	bne loc_0232F7B8	; 0232F790
	mov r4,#0x7	; 0232F792
	b loc_0232F7B8	; 0232F794
loc_0232F796:
	cmp r0,#0x1	; 0232F796
	bne loc_0232F7A8	; 0232F798
	cmp r1,#0x1	; 0232F79A
	bne loc_0232F7A0	; 0232F79C
	mov r4,#0x4	; 0232F79E
loc_0232F7A0:
	cmp r1,#0x0	; 0232F7A0
	bne loc_0232F7B8	; 0232F7A2
	mov r4,#0x5	; 0232F7A4
	b loc_0232F7B8	; 0232F7A6
loc_0232F7A8:
	cmp r0,#0x2	; 0232F7A8
	bne loc_0232F7B8	; 0232F7AA
	cmp r1,#0x1	; 0232F7AC
	bne loc_0232F7B2	; 0232F7AE
	mov r4,#0x8	; 0232F7B0
loc_0232F7B2:
	cmp r1,#0x0	; 0232F7B2
	bne loc_0232F7B8	; 0232F7B4
	mov r4,#0x9	; 0232F7B6
loc_0232F7B8:
	cmp r4,#0x0	; 0232F7B8
	beq loc_0232F7CC	; 0232F7BA
	add r0,r4,#0x0	; 0232F7BC
	add r1,r2,#0x0	; 0232F7BE
	add r2,r3,#0x0	; 0232F7C0
	bl loc_0232F8AC	; 0232F7C2
	pop {r4}	; 0232F7C6
	pop {r3}	; 0232F7C8
	bx r3	; 0232F7CA
loc_0232F7CC:
	ldr r0,[pool_0232F7D4]	; 0232F7CC
	pop {r4}	; 0232F7CE
	pop {r3}	; 0232F7D0
	bx r3	; 0232F7D2
pool_0232F7D4:
loc_0232F7D4:
	.word 0x0000FFFF	; 0232F7D4

; ===== function loc_0232F7D8 =====
loc_0232F7D8:
	push {lr}	; 0232F7D8
	sub sp,#0x4	; 0232F7DA
	ldr r1,[pool_0232F7F4]	; 0232F7DC
	add r2,sp,#0x0	; 0232F7DE
	bl loc_0232F7F8	; 0232F7E0
	cmp r0,#0x0	; 0232F7E4
	bne loc_0232F7EE	; 0232F7E6
	bl loc_0232FABC	; 0232F7E8
	ldr r0,[sp,#0x0]	; 0232F7EC
loc_0232F7EE:
	add sp,#0x4	; 0232F7EE
	pop {r3}	; 0232F7F0
	bx r3	; 0232F7F2
pool_0232F7F4:
loc_0232F7F4:
	.word 0x0232FAB9	; 0232F7F4

; ===== function loc_0232F7F8 =====
loc_0232F7F8:
	push {lr}	; 0232F7F8
	sub sp,#0x4	; 0232F7FA
	cmp r0,#0x1	; 0232F7FC
	beq loc_0232F80A	; 0232F7FE
	cmp r0,#0x2	; 0232F800
	beq loc_0232F812	; 0232F802
	cmp r0,#0x3	; 0232F804
	beq loc_0232F80E	; 0232F806
	b loc_0232F816	; 0232F808
loc_0232F80A:
	mov r0,#0x1	; 0232F80A
	b loc_0232F818	; 0232F80C
loc_0232F80E:
	mov r0,#0x2	; 0232F80E
	b loc_0232F818	; 0232F810
loc_0232F812:
	mov r0,#0x3	; 0232F812
	b loc_0232F818	; 0232F814
loc_0232F816:
	mov r0,#0x0	; 0232F816
loc_0232F818:
	cmp r0,#0x0	; 0232F818
	beq loc_0232F826	; 0232F81A
	bl loc_0232F8AC	; 0232F81C
	add sp,#0x4	; 0232F820
	pop {r3}	; 0232F822
	bx r3	; 0232F824
loc_0232F826:
	ldr r0,[pool_0232F830]	; 0232F826
	add sp,#0x4	; 0232F828
	pop {r3}	; 0232F82A
	bx r3	; 0232F82C
	.byte 0xC0, 0x46	; 0232F830
pool_0232F830:
loc_0232F830:
	.word 0x0000FFFF	; 0232F830

; ===== function loc_0232F834 =====
loc_0232F834:
	push {lr}	; 0232F834
	sub sp,#0x4	; 0232F836
	ldr r2,[pool_0232F850]	; 0232F838
	add r3,sp,#0x0	; 0232F83A
	bl loc_0232F854	; 0232F83C
	cmp r0,#0x0	; 0232F840
	bne loc_0232F84A	; 0232F842
	bl loc_0232FABC	; 0232F844
	ldr r0,[sp,#0x0]	; 0232F848
loc_0232F84A:
	add sp,#0x4	; 0232F84A
	pop {r3}	; 0232F84C
	bx r3	; 0232F84E
pool_0232F850:
loc_0232F850:
	.word 0x0232FAB9	; 0232F850

; ===== function loc_0232F854 =====
loc_0232F854:
	push {r4,r5,r6,r7,lr}	; 0232F854
	sub sp,#0x4	; 0232F856
	add r5,r0,#0x0	; 0232F858
	add r4,r1,#0x0	; 0232F85A
	add r6,r2,#0x0	; 0232F85C
	add r7,r3,#0x0	; 0232F85E
	bl loc_0232FACC	; 0232F860
	cmp r0,#0x0	; 0232F864
	bne loc_0232F872	; 0232F866
	mov r0,#0x1	; 0232F868
	add sp,#0x4	; 0232F86A
	pop {r4,r5,r6,r7}	; 0232F86C
	pop {r3}	; 0232F86E
	bx r3	; 0232F870
loc_0232F872:
	ldr r0,[pool_0232F89C]	; 0232F872
	str r6,[r0,#0x4]	; 0232F874
	str r7,[r0,#0x8]	; 0232F876
	lsl r2,r5,#0x3	; 0232F878
	mov r1,#0x0	; 0232F87A
	ldr r0,[pool_0232F8A0]	; 0232F87C
	strh r1,[r0,r2]	; 0232F87E
	ldr r0,[pool_0232F8A4]	; 0232F880
	str r4,[r0,r2]	; 0232F882
	mov r0,#0xff	; 0232F884
	and r5,r0	; 0232F886
	ldr r0,[pool_0232F8A8]	; 0232F888
	orr r5,r0	; 0232F88A
	add r0,r5,#0x0	; 0232F88C
	bl loc_0232F6F0	; 0232F88E
	mov r0,#0x0	; 0232F892
	add sp,#0x4	; 0232F894
	pop {r4,r5,r6,r7}	; 0232F896
	pop {r3}	; 0232F898
	bx r3	; 0232F89A
pool_0232F89C:
loc_0232F89C:
	.word P1_BssStart + 0x282D4	; 0232F89C
pool_0232F8A0:
loc_0232F8A0:
	.word P1_BssStart + 0x282F8	; 0232F8A0
pool_0232F8A4:
loc_0232F8A4:
	.word P1_BssStart + 0x282FC	; 0232F8A4
pool_0232F8A8:
loc_0232F8A8:
	.word 0x03006500	; 0232F8A8

; ===== function loc_0232F8AC =====
loc_0232F8AC:
	push {r4,r5,r6,lr}	; 0232F8AC
	add r5,r0,#0x0	; 0232F8AE
	add r4,r1,#0x0	; 0232F8B0
	add r6,r2,#0x0	; 0232F8B2
	bl loc_0232FACC	; 0232F8B4
	cmp r0,#0x0	; 0232F8B8
	bne loc_0232F8C4	; 0232F8BA
	mov r0,#0x1	; 0232F8BC
	pop {r4,r5,r6}	; 0232F8BE
	pop {r3}	; 0232F8C0
	bx r3	; 0232F8C2
loc_0232F8C4:
	ldr r0,[pool_0232F8F0]	; 0232F8C4
	str r4,[r0,#0x4]	; 0232F8C6
	str r6,[r0,#0x8]	; 0232F8C8
	lsr r0,r5,#0x10	; 0232F8CA
	mov r1,#0xff	; 0232F8CC
	and r0,r1	; 0232F8CE
	ldr r1,[pool_0232F8F4]	; 0232F8D0
	orr r0,r1	; 0232F8D2
	bl loc_0232F6F0	; 0232F8D4
	ldr r0,[pool_0232F8F8]	; 0232F8D8
	and r5,r0	; 0232F8DA
	ldr r0,[pool_0232F8FC]	; 0232F8DC
	orr r5,r0	; 0232F8DE
	add r0,r5,#0x0	; 0232F8E0
	bl loc_0232F6F0	; 0232F8E2
	mov r0,#0x0	; 0232F8E6
	pop {r4,r5,r6}	; 0232F8E8
	pop {r3}	; 0232F8EA
	bx r3	; 0232F8EC
	.byte 0xC0, 0x46	; 0232F8F0
pool_0232F8F0:
loc_0232F8F0:
	.word P1_BssStart + 0x282D4	; 0232F8F0
pool_0232F8F4:
loc_0232F8F4:
	.word 0x02006300	; 0232F8F4
pool_0232F8F8:
loc_0232F8F8:
	.word 0x0000FFFF	; 0232F8F8
pool_0232F8FC:
loc_0232F8FC:
	.word 0x01010000	; 0232F8FC

; ===== function loc_0232F900 =====
loc_0232F900:
	push {r4,r5,lr}	; 0232F900
	sub sp,#0x4	; 0232F902
	add r5,r0,#0x0	; 0232F904
	add r4,r1,#0x0	; 0232F906
	bl loc_0232FACC	; 0232F908
	cmp r0,#0x0	; 0232F90C
	bne loc_0232F91A	; 0232F90E
	mov r0,#0x1	; 0232F910
	add sp,#0x4	; 0232F912
	pop {r4,r5}	; 0232F914
	pop {r3}	; 0232F916
	bx r3	; 0232F918
loc_0232F91A:
	mov r1,#0x0	; 0232F91A
	ldr r0,[pool_0232F968]	; 0232F91C
	str r1,[r0,#0x0]	; 0232F91E
	ldr r0,[pool_0232F96C]	; 0232F920
	bl loc_0232F6F0	; 0232F922
	ldr r1,[pool_0232F968]	; 0232F926
loc_0232F928:
	ldr r0,[r1,#0x0]	; 0232F928
	cmp r0,#0x0	; 0232F92A
	beq loc_0232F928	; 0232F92C
	mov r0,#0x0	; 0232F92E
	str r0,[r1,#0x0]	; 0232F930
	ldr r1,[pool_0232F970]	; 0232F932
	str r0,[r1,#0x0]	; 0232F934
	mov r1,#0x2	; 0232F936
	add r2,r0,#0x0	; 0232F938
	add r3,r0,#0x0	; 0232F93A
	bl loc_0232F5A0	; 0232F93C
	mov r0,#0xff	; 0232F940
	and r5,r0	; 0232F942
	ldr r0,[pool_0232F974]	; 0232F944
	orr r5,r0	; 0232F946
	add r0,r5,#0x0	; 0232F948
	bl loc_0232F6F0	; 0232F94A
	ldr r0,[pool_0232F978]	; 0232F94E
	and r4,r0	; 0232F950
	ldr r0,[pool_0232F97C]	; 0232F952
	orr r4,r0	; 0232F954
	add r0,r4,#0x0	; 0232F956
	bl loc_0232F6F0	; 0232F958
	mov r0,#0x0	; 0232F95C
	add sp,#0x4	; 0232F95E
	pop {r4,r5}	; 0232F960
	pop {r3}	; 0232F962
	bx r3	; 0232F964
	.byte 0xC0, 0x46	; 0232F968
pool_0232F968:
loc_0232F968:
	.word P1_BssStart + 0x282C8	; 0232F968
pool_0232F96C:
loc_0232F96C:
	.word 0x03006000	; 0232F96C
pool_0232F970:
loc_0232F970:
	.word P1_BssStart + 0x282CC	; 0232F970
pool_0232F974:
loc_0232F974:
	.word 0x02006100	; 0232F974
pool_0232F978:
loc_0232F978:
	.word 0x0000FFFF	; 0232F978
pool_0232F97C:
loc_0232F97C:
	.word 0x01010000	; 0232F97C

; ===== function loc_0232F980 =====
	push {lr}	; 0232F980
	sub sp,#0x4	; 0232F982
	cmp r2,#0x0	; 0232F984
	beq loc_0232F994	; 0232F986
	mov r0,#0x2	; 0232F988
	bl loc_0232FA90	; 0232F98A
	add sp,#0x4	; 0232F98E
	pop {r3}	; 0232F990
	bx r3	; 0232F992
loc_0232F994:
	ldr r0,[pool_0232FA00]	; 0232F994
	add r2,r1,#0x0	; 0232F996
	and r2,r0	; 0232F998
	lsl r0,r2,#0x8	; 0232F99A
	lsr r3,r0,#0x10	; 0232F99C
	mov r2,#0xff	; 0232F99E
	and r1,r2	; 0232F9A0
	lsl r0,r1,#0x10	; 0232F9A2
	lsr r0,r0,#0x10	; 0232F9A4
	cmp r3,#0x70	; 0232F9A6
	bcc loc_0232F9CC	; 0232F9A8
	cmp r3,#0x73	; 0232F9AA
	bhi loc_0232F9CC	; 0232F9AC
	and r0,r2	; 0232F9AE
	lsl r0,r0,#0x10	; 0232F9B0
	lsr r1,r0,#0x10	; 0232F9B2
	sub r3,#0x70	; 0232F9B4
	lsl r2,r3,#0x3	; 0232F9B6
	ldr r0,[pool_0232FA04]	; 0232F9B8
	ldr r0,[r0,r2]	; 0232F9BA
	cmp r0,#0x0	; 0232F9BC
	beq loc_0232F9C2	; 0232F9BE
	strh r1,[r0,#0x0]	; 0232F9C0
loc_0232F9C2:
	mov r1,#0x1	; 0232F9C2
	ldr r0,[pool_0232FA08]	; 0232F9C4
	strh r1,[r0,r2]	; 0232F9C6
	mov r0,#0x0	; 0232F9C8
	b loc_0232F9F4	; 0232F9CA
loc_0232F9CC:
	cmp r3,#0x60	; 0232F9CC
	bne loc_0232F9D8	; 0232F9CE
	mov r2,#0x1	; 0232F9D0
	ldr r1,[pool_0232FA0C]	; 0232F9D2
	str r2,[r1,#0x0]	; 0232F9D4
	b loc_0232F9F4	; 0232F9D6
loc_0232F9D8:
	cmp r3,#0x62	; 0232F9D8
	bne loc_0232F9E4	; 0232F9DA
	mov r2,#0x1	; 0232F9DC
	ldr r1,[pool_0232FA10]	; 0232F9DE
	str r2,[r1,#0x0]	; 0232F9E0
	b loc_0232F9F4	; 0232F9E2
loc_0232F9E4:
	cmp r3,#0x67	; 0232F9E4
	bne loc_0232F9F4	; 0232F9E6
	ldr r1,[pool_0232FA14]	; 0232F9E8
	ldr r1,[r1,#0xc]	; 0232F9EA
	cmp r1,#0x0	; 0232F9EC
	beq loc_0232F9F2	; 0232F9EE
	str r0,[r1,#0x0]	; 0232F9F0
loc_0232F9F2:
	mov r0,#0x0	; 0232F9F2
loc_0232F9F4:
	bl loc_0232FA90	; 0232F9F4
	add sp,#0x4	; 0232F9F8
	pop {r3}	; 0232F9FA
	bx r3	; 0232F9FC
	.byte 0xC0, 0x46	; 0232FA00
pool_0232FA00:
loc_0232FA00:
	.word 0x00007F00	; 0232FA00
pool_0232FA04:
loc_0232FA04:
	.word P1_BssStart + 0x282FC	; 0232FA04
pool_0232FA08:
loc_0232FA08:
	.word P1_BssStart + 0x282F8	; 0232FA08
pool_0232FA0C:
loc_0232FA0C:
	.word P1_BssStart + 0x282C8	; 0232FA0C
pool_0232FA10:
loc_0232FA10:
	.word P1_BssStart + 0x282CC	; 0232FA10
pool_0232FA14:
loc_0232FA14:
	.word P1_BssStart + 0x282D4	; 0232FA14

; ===== function loc_0232FA18 =====
loc_0232FA18:
	push {r4,r5,lr}	; 0232FA18
	sub sp,#0x4	; 0232FA1A
	ldr r0,[pool_0232FA74]	; 0232FA1C
	ldrh r1,[r0,#0x0]	; 0232FA1E
	cmp r1,#0x0	; 0232FA20
	bne loc_0232FA6A	; 0232FA22
	mov r1,#0x1	; 0232FA24
	strh r1,[r0,#0x0]	; 0232FA26
	mov r1,#0x0	; 0232FA28
	ldr r0,[pool_0232FA78]	; 0232FA2A
	str r1,[r0,#0x0]	; 0232FA2C
	str r1,[r0,#0x4]	; 0232FA2E
	bl loc_0232ECB8	; 0232FA30
	mov r5,#0x8	; 0232FA34
	mov r4,#0x1	; 0232FA36
loc_0232FA38:
	add r0,r5,#0x0	; 0232FA38
	add r1,r4,#0x0	; 0232FA3A
	bl loc_0232EE2C	; 0232FA3C
	cmp r0,#0x0	; 0232FA40
	beq loc_0232FA38	; 0232FA42
	mov r0,#0x8	; 0232FA44
	ldr r1,[pool_0232FA7C]	; 0232FA46
	bl loc_0232EE58	; 0232FA48
	mov r2,#0x0	; 0232FA4C
	ldr r1,[pool_0232FA80]	; 0232FA4E
	add r0,r2,#0x0	; 0232FA50
loc_0232FA52:
	strh r0,[r1,#0x0]	; 0232FA52
	add r1,#0x8	; 0232FA54
	add r2,r2,#0x1	; 0232FA56
	cmp r2,#0x4	; 0232FA58
	blt loc_0232FA52	; 0232FA5A
	ldr r0,[pool_0232FA84]	; 0232FA5C
	bl loc_0232B76C	; 0232FA5E
	ldr r0,[pool_0232FA88]	; 0232FA62
	ldr r1,[r0,#0x0]	; 0232FA64
	ldr r0,[pool_0232FA8C]	; 0232FA66
	str r1,[r0,#0x0]	; 0232FA68
loc_0232FA6A:
	add sp,#0x4	; 0232FA6A
	pop {r4,r5}	; 0232FA6C
	pop {r3}	; 0232FA6E
	bx r3	; 0232FA70
	.byte 0xC0, 0x46	; 0232FA74
pool_0232FA74:
loc_0232FA74:
	.word P1_BssStart + 0x282C4	; 0232FA74
pool_0232FA78:
loc_0232FA78:
	.word P1_BssStart + 0x282D4	; 0232FA78
pool_0232FA7C:
loc_0232FA7C:
	.word 0x0232F981	; 0232FA7C
pool_0232FA80:
loc_0232FA80:
	.word P1_BssStart + 0x282F8	; 0232FA80
pool_0232FA84:
loc_0232FA84:
	.word 0x02359164	; 0232FA84
pool_0232FA88:
loc_0232FA88:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232FA88
pool_0232FA8C:
loc_0232FA8C:
	.word P1_BssStart + 0x282D0	; 0232FA8C

; ===== function loc_0232FA90 =====
loc_0232FA90:
	push {r4,lr}	; 0232FA90
	ldr r3,[pool_0232FAB4]	; 0232FA92
	ldr r2,[r3,#0x4]	; 0232FA94
	ldr r1,[r3,#0x8]	; 0232FA96
	ldr r4,[r3,#0x0]	; 0232FA98
	cmp r4,#0x0	; 0232FA9A
	beq loc_0232FAA2	; 0232FA9C
	mov r4,#0x0	; 0232FA9E
	str r4,[r3,#0x0]	; 0232FAA0
loc_0232FAA2:
	cmp r2,#0x0	; 0232FAA2
	beq loc_0232FAAE	; 0232FAA4
	mov r4,#0x0	; 0232FAA6
	ldr r3,[pool_0232FAB4]	; 0232FAA8
	str r4,[r3,#0x4]	; 0232FAAA
	blx r2	; 0232FAAC
loc_0232FAAE:
	pop {r4}	; 0232FAAE
	pop {r3}	; 0232FAB0
	bx r3	; 0232FAB2
pool_0232FAB4:
loc_0232FAB4:
	.word P1_BssStart + 0x282D4	; 0232FAB4
	str r0,[r1,#0x0]	; 0232FAB8
	bx lr	; 0232FABA

; ===== function loc_0232FABC =====
loc_0232FABC:
	ldr r1,[pool_0232FAC8]	; 0232FABC
loc_0232FABE:
	ldr r0,[r1,#0x0]	; 0232FABE
	cmp r0,#0x0	; 0232FAC0
	bne loc_0232FABE	; 0232FAC2
	bx lr	; 0232FAC4
	.byte 0xC0, 0x46	; 0232FAC8
pool_0232FAC8:
loc_0232FAC8:
	.word P1_BssStart + 0x282D4	; 0232FAC8

; ===== function loc_0232FACC =====
loc_0232FACC:
	push {lr}	; 0232FACC
	sub sp,#0x4	; 0232FACE
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FAD0
	ldr r1,[pool_0232FAF8]	; 0232FAD4
	ldr r2,[r1,#0x0]	; 0232FAD6
	cmp r2,#0x0	; 0232FAD8
	beq loc_0232FAE8	; 0232FADA
	blx P1_Arm9RestoreIrqMask	; 0232FADC
	mov r0,#0x0	; 0232FAE0
	add sp,#0x4	; 0232FAE2
	pop {r3}	; 0232FAE4
	bx r3	; 0232FAE6
loc_0232FAE8:
	mov r2,#0x1	; 0232FAE8
	str r2,[r1,#0x0]	; 0232FAEA
	blx P1_Arm9RestoreIrqMask	; 0232FAEC
	mov r0,#0x1	; 0232FAF0
	add sp,#0x4	; 0232FAF2
	pop {r3}	; 0232FAF4
	bx r3	; 0232FAF6
pool_0232FAF8:
loc_0232FAF8:
	.word P1_BssStart + 0x282D4	; 0232FAF8
.arm

; ===== function loc_0232FAFC =====
loc_0232FAFC:
	ldr r12,[pool_0232FB10]	; 0232FAFC
loc_0232FB00:
	ldr r0,[r12,#0x0]	; 0232FB00
	cmp r0,#0x1	; 0232FB04
	beq loc_0232FB00	; 0232FB08
	bx lr	; 0232FB0C
pool_0232FB10:
loc_0232FB10:
	.word P1_BssStart + 0x2831C	; 0232FB10
.thumb
	ldr r1,[pool_0232FB1C]	; 0232FB14
	str r0,[r1,#0x20]	; 0232FB16
	bx lr	; 0232FB18
	.byte 0xC0, 0x46	; 0232FB1C
pool_0232FB1C:
loc_0232FB1C:
	.word P1_BssStart + 0x2831C	; 0232FB1C

; ===== function loc_0232FB20 =====
loc_0232FB20:
	push {r4,r5,lr}	; 0232FB20
	sub sp,#0x4	; 0232FB22
	add r5,r0,#0x0	; 0232FB24
	add r4,r1,#0x0	; 0232FB26
	ldr r1,[r5,#0x0]	; 0232FB28
	cmp r1,#0x18	; 0232FB2A
	bcc loc_0232FB38	; 0232FB2C
	mov r0,#0x0	; 0232FB2E
	add sp,#0x4	; 0232FB30
	pop {r4,r5}	; 0232FB32
	pop {r3}	; 0232FB34
	bx r3	; 0232FB36
loc_0232FB38:
	ldr r0,[r5,#0x4]	; 0232FB38
	cmp r0,#0x3c	; 0232FB3A
	bcc loc_0232FB48	; 0232FB3C
	mov r0,#0x0	; 0232FB3E
	add sp,#0x4	; 0232FB40
	pop {r4,r5}	; 0232FB42
	pop {r3}	; 0232FB44
	bx r3	; 0232FB46
loc_0232FB48:
	ldr r0,[r5,#0x8]	; 0232FB48
	cmp r0,#0x3c	; 0232FB4A
	bcc loc_0232FB58	; 0232FB4C
	mov r0,#0x0	; 0232FB4E
	add sp,#0x4	; 0232FB50
	pop {r4,r5}	; 0232FB52
	pop {r3}	; 0232FB54
	bx r3	; 0232FB56
loc_0232FB58:
	cmp r1,#0xc	; 0232FB58
	bcc loc_0232FB66	; 0232FB5A
	ldr r1,[r4,#0x0]	; 0232FB5C
	mov r0,#0x40	; 0232FB5E
	orr r1,r0	; 0232FB60
	str r1,[r4,#0x0]	; 0232FB62
	b loc_0232FB6E	; 0232FB64
loc_0232FB66:
	ldr r1,[r4,#0x0]	; 0232FB66
	mov r0,#0x40	; 0232FB68
	bic r1,r0	; 0232FB6A
	str r1,[r4,#0x0]	; 0232FB6C
loc_0232FB6E:
	ldr r0,[r5,#0x0]	; 0232FB6E
	bl loc_0232FD50	; 0232FB70
	ldr r2,[r4,#0x0]	; 0232FB74
	mov r1,#0x3f	; 0232FB76
	bic r2,r1	; 0232FB78
	and r0,r1	; 0232FB7A
	orr r2,r0	; 0232FB7C
	str r2,[r4,#0x0]	; 0232FB7E
	ldr r0,[r5,#0x4]	; 0232FB80
	bl loc_0232FD50	; 0232FB82
	ldr r2,[r4,#0x0]	; 0232FB86
	ldr r1,[pool_0232FBB8]	; 0232FB88
	and r2,r1	; 0232FB8A
	mov r1,#0x7f	; 0232FB8C
	and r0,r1	; 0232FB8E
	lsl r0,r0,#0x8	; 0232FB90
	orr r2,r0	; 0232FB92
	str r2,[r4,#0x0]	; 0232FB94
	ldr r0,[r5,#0x8]	; 0232FB96
	bl loc_0232FD50	; 0232FB98
	ldr r2,[r4,#0x0]	; 0232FB9C
	ldr r1,[pool_0232FBBC]	; 0232FB9E
	and r2,r1	; 0232FBA0
	mov r1,#0x7f	; 0232FBA2
	and r0,r1	; 0232FBA4
	lsl r0,r0,#0x10	; 0232FBA6
	orr r2,r0	; 0232FBA8
	str r2,[r4,#0x0]	; 0232FBAA
	mov r0,#0x1	; 0232FBAC
	add sp,#0x4	; 0232FBAE
	pop {r4,r5}	; 0232FBB0
	pop {r3}	; 0232FBB2
	bx r3	; 0232FBB4
	.byte 0xC0, 0x46	; 0232FBB8
pool_0232FBB8:
loc_0232FBB8:
	.word 0xFFFF80FF	; 0232FBB8
pool_0232FBBC:
loc_0232FBBC:
	.word 0xFF80FFFF	; 0232FBBC

; ===== function loc_0232FBC0 =====
loc_0232FBC0:
	push {r4,r5,lr}	; 0232FBC0
	sub sp,#0x4	; 0232FBC2
	add r5,r0,#0x0	; 0232FBC4
	add r4,r1,#0x0	; 0232FBC6
	ldr r0,[r5,#0x0]	; 0232FBC8
	cmp r0,#0x64	; 0232FBCA
	bcc loc_0232FBD8	; 0232FBCC
	mov r0,#0x0	; 0232FBCE
	add sp,#0x4	; 0232FBD0
	pop {r4,r5}	; 0232FBD2
	pop {r3}	; 0232FBD4
	bx r3	; 0232FBD6
loc_0232FBD8:
	ldr r1,[r5,#0x4]	; 0232FBD8
	cmp r1,#0x1	; 0232FBDA
	bcc loc_0232FBE2	; 0232FBDC
	cmp r1,#0xc	; 0232FBDE
	bls loc_0232FBEC	; 0232FBE0
loc_0232FBE2:
	mov r0,#0x0	; 0232FBE2
	add sp,#0x4	; 0232FBE4
	pop {r4,r5}	; 0232FBE6
	pop {r3}	; 0232FBE8
	bx r3	; 0232FBEA
loc_0232FBEC:
	ldr r1,[r5,#0x8]	; 0232FBEC
	cmp r1,#0x1	; 0232FBEE
	bcc loc_0232FBF6	; 0232FBF0
	cmp r1,#0x1f	; 0232FBF2
	bls loc_0232FC00	; 0232FBF4
loc_0232FBF6:
	mov r0,#0x0	; 0232FBF6
	add sp,#0x4	; 0232FBF8
	pop {r4,r5}	; 0232FBFA
	pop {r3}	; 0232FBFC
	bx r3	; 0232FBFE
loc_0232FC00:
	ldr r1,[r5,#0xc]	; 0232FC00
	cmp r1,#0x7	; 0232FC02
	blt loc_0232FC10	; 0232FC04
	mov r0,#0x0	; 0232FC06
	add sp,#0x4	; 0232FC08
	pop {r4,r5}	; 0232FC0A
	pop {r3}	; 0232FC0C
	bx r3	; 0232FC0E
loc_0232FC10:
	bl loc_0232FD50	; 0232FC10
	str r0,[r4,#0x0]	; 0232FC14
	ldr r0,[r5,#0x4]	; 0232FC16
	bl loc_0232FD50	; 0232FC18
	ldr r2,[r4,#0x0]	; 0232FC1C
	ldr r1,[pool_0232FC60]	; 0232FC1E
	and r2,r1	; 0232FC20
	mov r1,#0x1f	; 0232FC22
	and r0,r1	; 0232FC24
	lsl r0,r0,#0x8	; 0232FC26
	orr r2,r0	; 0232FC28
	str r2,[r4,#0x0]	; 0232FC2A
	ldr r0,[r5,#0x8]	; 0232FC2C
	bl loc_0232FD50	; 0232FC2E
	ldr r2,[r4,#0x0]	; 0232FC32
	ldr r1,[pool_0232FC64]	; 0232FC34
	and r2,r1	; 0232FC36
	mov r1,#0x3f	; 0232FC38
	and r0,r1	; 0232FC3A
	lsl r0,r0,#0x10	; 0232FC3C
	orr r2,r0	; 0232FC3E
	str r2,[r4,#0x0]	; 0232FC40
	ldr r2,[r4,#0x0]	; 0232FC42
	ldr r0,[pool_0232FC68]	; 0232FC44
	and r2,r0	; 0232FC46
	ldr r1,[r5,#0xc]	; 0232FC48
	mov r0,#0x7	; 0232FC4A
	and r1,r0	; 0232FC4C
	lsl r0,r1,#0x18	; 0232FC4E
	orr r2,r0	; 0232FC50
	str r2,[r4,#0x0]	; 0232FC52
	mov r0,#0x1	; 0232FC54
	add sp,#0x4	; 0232FC56
	pop {r4,r5}	; 0232FC58
	pop {r3}	; 0232FC5A
	bx r3	; 0232FC5C
	.byte 0xC0, 0x46	; 0232FC60
pool_0232FC60:
loc_0232FC60:
	.word 0xFFFFE0FF	; 0232FC60
pool_0232FC64:
loc_0232FC64:
	.word 0xFFC0FFFF	; 0232FC64
pool_0232FC68:
loc_0232FC68:
	.word 0xF8FFFFFF	; 0232FC68

; ===== function loc_0232FC6C =====
loc_0232FC6C:
	push {r4,lr}	; 0232FC6C
	sub sp,#0x8	; 0232FC6E
	add r4,r0,#0x0	; 0232FC70
	mov r1,#0x0	; 0232FC72
	str r1,[sp,#0x0]	; 0232FC74
	bl loc_0232FD20	; 0232FC76
	cmp r0,#0x0	; 0232FC7A
	bne loc_0232FC88	; 0232FC7C
	ldr r0,[sp,#0x0]	; 0232FC7E
	add sp,#0x8	; 0232FC80
	pop {r4}	; 0232FC82
	pop {r3}	; 0232FC84
	bx r3	; 0232FC86
loc_0232FC88:
	ldr r2,[sp,#0x0]	; 0232FC88
	mov r0,#0x7	; 0232FC8A
	bic r2,r0	; 0232FC8C
	ldr r1,[r4,#0x0]	; 0232FC8E
	and r1,r0	; 0232FC90
	orr r2,r1	; 0232FC92
	str r2,[sp,#0x0]	; 0232FC94
	ldr r0,[r4,#0x4]	; 0232FC96
	cmp r0,#0xc	; 0232FC98
	bcc loc_0232FCA2	; 0232FC9A
	ldr r0,[pool_0232FD0C]	; 0232FC9C
	orr r2,r0	; 0232FC9E
	str r2,[sp,#0x0]	; 0232FCA0
loc_0232FCA2:
	ldr r0,[r4,#0x4]	; 0232FCA2
	bl loc_0232FD50	; 0232FCA4
	ldr r2,[sp,#0x0]	; 0232FCA8
	ldr r1,[pool_0232FD10]	; 0232FCAA
	and r2,r1	; 0232FCAC
	mov r1,#0x3f	; 0232FCAE
	and r0,r1	; 0232FCB0
	lsl r0,r0,#0x8	; 0232FCB2
	orr r2,r0	; 0232FCB4
	str r2,[sp,#0x0]	; 0232FCB6
	ldr r0,[r4,#0x8]	; 0232FCB8
	bl loc_0232FD50	; 0232FCBA
	ldr r1,[sp,#0x0]	; 0232FCBE
	ldr r2,[pool_0232FD14]	; 0232FCC0
	and r1,r2	; 0232FCC2
	mov r2,#0x7f	; 0232FCC4
	and r0,r2	; 0232FCC6
	lsl r0,r0,#0x10	; 0232FCC8
	orr r1,r0	; 0232FCCA
	str r1,[sp,#0x0]	; 0232FCCC
	ldr r2,[r4,#0xc]	; 0232FCCE
	mov r0,#0x1	; 0232FCD0
	and r2,r0	; 0232FCD2
	cmp r2,#0x0	; 0232FCD4
	beq loc_0232FCDE	; 0232FCD6
	mov r0,#0x80	; 0232FCD8
	orr r1,r0	; 0232FCDA
	str r1,[sp,#0x0]	; 0232FCDC
loc_0232FCDE:
	ldr r1,[r4,#0xc]	; 0232FCDE
	mov r0,#0x2	; 0232FCE0
	and r1,r0	; 0232FCE2
	cmp r1,#0x0	; 0232FCE4
	beq loc_0232FCF0	; 0232FCE6
	ldr r1,[sp,#0x0]	; 0232FCE8
	ldr r0,[pool_0232FD18]	; 0232FCEA
	orr r1,r0	; 0232FCEC
	str r1,[sp,#0x0]	; 0232FCEE
loc_0232FCF0:
	ldr r1,[r4,#0xc]	; 0232FCF0
	mov r0,#0x4	; 0232FCF2
	and r1,r0	; 0232FCF4
	cmp r1,#0x0	; 0232FCF6
	beq loc_0232FD02	; 0232FCF8
	ldr r1,[sp,#0x0]	; 0232FCFA
	ldr r0,[pool_0232FD1C]	; 0232FCFC
	orr r1,r0	; 0232FCFE
	str r1,[sp,#0x0]	; 0232FD00
loc_0232FD02:
	ldr r0,[sp,#0x0]	; 0232FD02
	add sp,#0x8	; 0232FD04
	pop {r4}	; 0232FD06
	pop {r3}	; 0232FD08
	bx r3	; 0232FD0A
pool_0232FD0C:
loc_0232FD0C:
	.word 0x00004000	; 0232FD0C
pool_0232FD10:
loc_0232FD10:
	.word 0xFFFFC0FF	; 0232FD10
pool_0232FD14:
loc_0232FD14:
	.word 0xFF80FFFF	; 0232FD14
pool_0232FD18:
loc_0232FD18:
	.word 0x00008000	; 0232FD18
pool_0232FD1C:
loc_0232FD1C:
	.word 0x00800000	; 0232FD1C

; ===== function loc_0232FD20 =====
loc_0232FD20:
	ldr r1,[r0,#0x0]	; 0232FD20
	cmp r1,#0x7	; 0232FD22
	blt loc_0232FD2A	; 0232FD24
	mov r0,#0x0	; 0232FD26
	bx lr	; 0232FD28
loc_0232FD2A:
	ldr r1,[r0,#0x4]	; 0232FD2A
	cmp r1,#0x18	; 0232FD2C
	bcc loc_0232FD34	; 0232FD2E
	mov r0,#0x0	; 0232FD30
	bx lr	; 0232FD32
loc_0232FD34:
	ldr r1,[r0,#0x8]	; 0232FD34
	cmp r1,#0x3c	; 0232FD36
	bcc loc_0232FD3E	; 0232FD38
	mov r0,#0x0	; 0232FD3A
	bx lr	; 0232FD3C
loc_0232FD3E:
	ldr r1,[r0,#0xc]	; 0232FD3E
	mov r0,#0x7	; 0232FD40
	bic r1,r0	; 0232FD42
	cmp r1,#0x0	; 0232FD44
	bne loc_0232FD4C	; 0232FD46
	mov r0,#0x1	; 0232FD48
	bx lr	; 0232FD4A
loc_0232FD4C:
	mov r0,#0x0	; 0232FD4C
	bx lr	; 0232FD4E

; ===== function loc_0232FD50 =====
loc_0232FD50:
	push {r4,r5,r6,r7,lr}	; 0232FD50
	sub sp,#0x4	; 0232FD52
	add r5,r0,#0x0	; 0232FD54
	mov r6,#0x0	; 0232FD56
	ldr r0,[pool_0232FD94]	; 0232FD58
	cmp r5,r0	; 0232FD5A
	bls loc_0232FD68	; 0232FD5C
	add r0,r6,#0x0	; 0232FD5E
	add sp,#0x4	; 0232FD60
	pop {r4,r5,r6,r7}	; 0232FD62
	pop {r3}	; 0232FD64
	bx r3	; 0232FD66
loc_0232FD68:
	add r7,r6,#0x0	; 0232FD68
	add r4,r6,#0x0	; 0232FD6A
loc_0232FD6C:
	add r0,r5,#0x0	; 0232FD6C
	mov r1,#0xa	; 0232FD6E
	blx P1_UnsignedDivMod	; 0232FD70
	lsl r1,r4	; 0232FD74
	add r6,r6,r1	; 0232FD76
	add r0,r5,#0x0	; 0232FD78
	mov r1,#0xa	; 0232FD7A
	blx P1_UnsignedDivMod	; 0232FD7C
	add r5,r0,#0x0	; 0232FD80
	add r4,r4,#0x4	; 0232FD82
	add r7,r7,#0x1	; 0232FD84
	cmp r7,#0x8	; 0232FD86
	blt loc_0232FD6C	; 0232FD88
	add r0,r6,#0x0	; 0232FD8A
	add sp,#0x4	; 0232FD8C
	pop {r4,r5,r6,r7}	; 0232FD8E
	pop {r3}	; 0232FD90
	bx r3	; 0232FD92
pool_0232FD94:
loc_0232FD94:
	.word 0x05F5E0FF	; 0232FD94

; ===== function loc_0232FD98 =====
loc_0232FD98:
	push {r4,r5,r6,r7}	; 0232FD98
	mov r4,#0x0	; 0232FD9A
	add r5,r4,#0x0	; 0232FD9C
	add r3,r4,#0x0	; 0232FD9E
	mov r1,#0xf	; 0232FDA0
loc_0232FDA2:
	add r2,r0,#0x0	; 0232FDA2
	lsr r2,r3	; 0232FDA4
	and r2,r1	; 0232FDA6
	cmp r2,#0xa	; 0232FDA8
	bcc loc_0232FDB2	; 0232FDAA
	mov r0,#0x0	; 0232FDAC
	pop {r4,r5,r6,r7}	; 0232FDAE
	bx lr	; 0232FDB0
loc_0232FDB2:
	add r3,r3,#0x4	; 0232FDB2
	add r5,r5,#0x1	; 0232FDB4
	cmp r5,#0x8	; 0232FDB6
	blt loc_0232FDA2	; 0232FDB8
	mov r1,#0x0	; 0232FDBA
	mov r3,#0x1	; 0232FDBC
	add r2,r1,#0x0	; 0232FDBE
	mov r6,#0xa	; 0232FDC0
loc_0232FDC2:
	add r7,r0,#0x0	; 0232FDC2
	lsr r7,r2	; 0232FDC4
	mov r5,#0xf	; 0232FDC6
	and r7,r5	; 0232FDC8
	add r5,r3,#0x0	; 0232FDCA
	mul r5,r7	; 0232FDCC
	add r4,r4,r5	; 0232FDCE
	add r2,r2,#0x4	; 0232FDD0
	add r1,r1,#0x1	; 0232FDD2
	mul r3,r6	; 0232FDD4
	cmp r1,#0x8	; 0232FDD6
	blt loc_0232FDC2	; 0232FDD8
	add r0,r4,#0x0	; 0232FDDA
	pop {r4,r5,r6,r7}	; 0232FDDC
	bx lr	; 0232FDDE

; ===== function loc_0232FDE0 =====
	push {r4,r5,lr}	; 0232FDE0
	sub sp,#0x4	; 0232FDE2
	cmp r2,#0x0	; 0232FDE4
	beq loc_0232FE1C	; 0232FDE6
	ldr r0,[pool_023300BC]	; 0232FDE8
	ldr r1,[r0,#0x18]	; 0232FDEA
	cmp r1,#0x0	; 0232FDEC
	beq loc_0232FDF4	; 0232FDEE
	mov r1,#0x0	; 0232FDF0
	str r1,[r0,#0x18]	; 0232FDF2
loc_0232FDF4:
	ldr r0,[pool_023300BC]	; 0232FDF4
	ldr r1,[r0,#0x0]	; 0232FDF6
	cmp r1,#0x0	; 0232FDF8
	beq loc_0232FE00	; 0232FDFA
	mov r1,#0x0	; 0232FDFC
	str r1,[r0,#0x0]	; 0232FDFE
loc_0232FE00:
	ldr r1,[pool_023300BC]	; 0232FE00
	ldr r2,[r1,#0x4]	; 0232FE02
	cmp r2,#0x0	; 0232FE04
	bne loc_0232FE0A	; 0232FE06
	b loc_023300B4	; 0232FE08
loc_0232FE0A:
	mov r0,#0x0	; 0232FE0A
	str r0,[r1,#0x4]	; 0232FE0C
	mov r0,#0x6	; 0232FE0E
	ldr r1,[r1,#0x10]	; 0232FE10
	blx r2	; 0232FE12
	add sp,#0x4	; 0232FE14
	pop {r4,r5}	; 0232FE16
	pop {r3}	; 0232FE18
	bx r3	; 0232FE1A
loc_0232FE1C:
	mov r2,#0xff	; 0232FE1C
	add r0,r1,#0x0	; 0232FE1E
	and r0,r2	; 0232FE20
	ldr r3,[pool_023300C0]	; 0232FE22
	and r1,r3	; 0232FE24
	lsr r1,r1,#0x8	; 0232FE26
	lsl r1,r1,#0x18	; 0232FE28
	lsr r1,r1,#0x18	; 0232FE2A
	cmp r1,#0x30	; 0232FE2C
	bne loc_0232FE44	; 0232FE2E
	ldr r0,[pool_023300BC]	; 0232FE30
	ldr r0,[r0,#0x1c]	; 0232FE32
	cmp r0,#0x0	; 0232FE34
	bne loc_0232FE3A	; 0232FE36
	b loc_023300B4	; 0232FE38
loc_0232FE3A:
	blx r0	; 0232FE3A
	add sp,#0x4	; 0232FE3C
	pop {r4,r5}	; 0232FE3E
	pop {r3}	; 0232FE40
	bx r3	; 0232FE42
loc_0232FE44:
	cmp r0,#0x0	; 0232FE44
	beq loc_0232FE4A	; 0232FE46
	b loc_02330060	; 0232FE48
loc_0232FE4A:
	mov r4,#0x0	; 0232FE4A
	ldr r0,[pool_023300BC]	; 0232FE4C
	ldr r1,[r0,#0x14]	; 0232FE4E
	cmp r1,#0xf	; 0232FE50
	bls loc_0232FE56	; 0232FE52
	b loc_02330056	; 0232FE54
loc_0232FE56:
	add r1,r1,r1	; 0232FE56
P1_SwitchIndexPC_0232FE56:
	add r1,pc	; 0232FE58
	ldrh r1,[r1,#(P1_SwitchTable_0232FE56 - (P1_SwitchIndexPC_0232FE56 + 4))]	; 0232FE5A
	lsl r1,r1,#0x10	; 0232FE5C
	asr r1,r1,#0x10	; 0232FE5E
P1_SwitchTargetPC_0232FE56:
	add r1,pc	; 0232FE60
	bx r1	; 0232FE62
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232FE56:
	.halfword (loc_02330056 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_02330056 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_0232FE84 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_02330056 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_02330056 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_02330090 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_0232FEE8 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_0232FF00 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_0232FF18 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_0232FF86 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_0232FFF0 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_02330090 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_02330090 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_02330090 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_02330090 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
	.halfword (loc_02330090 + 1) - (P1_SwitchTargetPC_0232FE56 + 4)
P1_SwitchTable_0232FE56End:
loc_0232FE84:
	ldr r5,[r0,#0x8]	; 0232FE84
	ldr r0,[pool_023300C4]	; 0232FE86
	ldr r0,[r0,#0x0]	; 0232FE88
	and r0,r2	; 0232FE8A
	bl loc_0232FD98	; 0232FE8C
	str r0,[r5,#0x0]	; 0232FE90
	ldr r0,[pool_023300C4]	; 0232FE92
	ldr r0,[r0,#0x0]	; 0232FE94
	lsl r0,r0,#0x13	; 0232FE96
	lsr r0,r0,#0x1b	; 0232FE98
	bl loc_0232FD98	; 0232FE9A
	str r0,[r5,#0x4]	; 0232FE9E
	ldr r0,[pool_023300C4]	; 0232FEA0
	ldr r0,[r0,#0x0]	; 0232FEA2
	lsl r0,r0,#0xa	; 0232FEA4
	lsr r0,r0,#0x1a	; 0232FEA6
	bl loc_0232FD98	; 0232FEA8
	str r0,[r5,#0x8]	; 0232FEAC
	ldr r0,[pool_023300C4]	; 0232FEAE
	ldr r0,[r0,#0x0]	; 0232FEB0
	lsl r0,r0,#0x5	; 0232FEB2
	lsr r0,r0,#0x1d	; 0232FEB4
	str r0,[r5,#0xc]	; 0232FEB6
	ldr r0,[pool_023300BC]	; 0232FEB8
	ldr r5,[r0,#0xc]	; 0232FEBA
	ldr r0,[pool_023300C8]	; 0232FEBC
	ldr r0,[r0,#0x0]	; 0232FEBE
	lsl r0,r0,#0x1a	; 0232FEC0
	lsr r0,r0,#0x1a	; 0232FEC2
	bl loc_0232FD98	; 0232FEC4
	str r0,[r5,#0x0]	; 0232FEC8
	ldr r0,[pool_023300C8]	; 0232FECA
	ldr r0,[r0,#0x0]	; 0232FECC
	lsl r0,r0,#0x11	; 0232FECE
	lsr r0,r0,#0x19	; 0232FED0
	bl loc_0232FD98	; 0232FED2
	str r0,[r5,#0x4]	; 0232FED6
	ldr r0,[pool_023300C8]	; 0232FED8
	ldr r0,[r0,#0x0]	; 0232FEDA
	lsl r0,r0,#0x9	; 0232FEDC
	lsr r0,r0,#0x19	; 0232FEDE
	bl loc_0232FD98	; 0232FEE0
	str r0,[r5,#0x8]	; 0232FEE4
	b loc_02330090	; 0232FEE6
loc_0232FEE8:
	ldr r1,[r0,#0x8]	; 0232FEE8
	ldr r0,[pool_023300CC]	; 0232FEEA
	ldrh r0,[r0,#0x0]	; 0232FEEC
	lsl r0,r0,#0x1c	; 0232FEEE
	lsr r0,r0,#0x1c	; 0232FEF0
	cmp r0,#0x4	; 0232FEF2
	bne loc_0232FEFC	; 0232FEF4
	mov r0,#0x1	; 0232FEF6
	str r0,[r1,#0x0]	; 0232FEF8
	b loc_02330090	; 0232FEFA
loc_0232FEFC:
	str r4,[r1,#0x0]	; 0232FEFC
	b loc_02330090	; 0232FEFE
loc_0232FF00:
	ldr r1,[r0,#0x8]	; 0232FF00
	ldr r0,[pool_023300CC]	; 0232FF02
	ldrh r0,[r0,#0x0]	; 0232FF04
	lsl r0,r0,#0x19	; 0232FF06
	lsr r0,r0,#0x1f	; 0232FF08
	cmp r0,#0x0	; 0232FF0A
	beq loc_0232FF14	; 0232FF0C
	mov r0,#0x1	; 0232FF0E
	str r0,[r1,#0x0]	; 0232FF10
	b loc_02330090	; 0232FF12
loc_0232FF14:
	str r4,[r1,#0x0]	; 0232FF14
	b loc_02330090	; 0232FF16
loc_0232FF18:
	ldr r5,[r0,#0x8]	; 0232FF18
	ldr r1,[pool_023300C8]	; 0232FF1A
	ldr r0,[r1,#0x0]	; 0232FF1C
	lsl r0,r0,#0x1d	; 0232FF1E
	lsr r0,r0,#0x1d	; 0232FF20
	str r0,[r5,#0x0]	; 0232FF22
	ldr r0,[r1,#0x0]	; 0232FF24
	lsl r0,r0,#0x12	; 0232FF26
	lsr r0,r0,#0x1a	; 0232FF28
	bl loc_0232FD98	; 0232FF2A
	str r0,[r5,#0x4]	; 0232FF2E
	ldr r0,[pool_023300C8]	; 0232FF30
	ldr r0,[r0,#0x0]	; 0232FF32
	lsl r0,r0,#0x9	; 0232FF34
	lsr r0,r0,#0x19	; 0232FF36
	bl loc_0232FD98	; 0232FF38
	str r0,[r5,#0x8]	; 0232FF3C
	lsl r0,r4,#0	; 0232FF3E
	str r0,[r5,#0xc]	; 0232FF40
	ldr r0,[pool_023300C8]	; 0232FF42
	ldr r0,[r0,#0x0]	; 0232FF44
	lsl r0,r0,#0x18	; 0232FF46
	lsr r0,r0,#0x1f	; 0232FF48
	cmp r0,#0x0	; 0232FF4A
	beq loc_0232FF58	; 0232FF4C
	add r1,r5,#0x0	; 0232FF4E
	add r1,#0xc	; 0232FF50
	ldr r0,[r1,#0x0]	; 0232FF52
	add r0,r0,#0x1	; 0232FF54
	str r0,[r1,#0x0]	; 0232FF56
loc_0232FF58:
	ldr r0,[pool_023300C8]	; 0232FF58
	ldr r0,[r0,#0x0]	; 0232FF5A
	lsl r0,r0,#0x10	; 0232FF5C
	lsr r0,r0,#0x1f	; 0232FF5E
	cmp r0,#0x0	; 0232FF60
	beq loc_0232FF6E	; 0232FF62
	add r1,r5,#0x0	; 0232FF64
	add r1,#0xc	; 0232FF66
	ldr r0,[r1,#0x0]	; 0232FF68
	add r0,r0,#0x2	; 0232FF6A
	str r0,[r1,#0x0]	; 0232FF6C
loc_0232FF6E:
	ldr r0,[pool_023300C8]	; 0232FF6E
	ldr r0,[r0,#0x0]	; 0232FF70
	lsl r0,r0,#0x8	; 0232FF72
	lsr r0,r0,#0x1f	; 0232FF74
	cmp r0,#0x0	; 0232FF76
	bne loc_0232FF7C	; 0232FF78
	b loc_02330090	; 0232FF7A
loc_0232FF7C:
	add r5,#0xc	; 0232FF7C
	ldr r0,[r5,#0x0]	; 0232FF7E
	add r0,r0,#0x4	; 0232FF80
	str r0,[r5,#0x0]	; 0232FF82
	b loc_02330090	; 0232FF84
loc_0232FF86:
	ldr r2,[r0,#0x18]	; 0232FF86
	cmp r2,#0x0	; 0232FF88
	bne loc_0232FFEC	; 0232FF8A
	ldr r1,[r0,#0x8]	; 0232FF8C
	ldr r1,[r1,#0x0]	; 0232FF8E
	cmp r1,#0x1	; 0232FF90
	bne loc_0232FFC2	; 0232FF92
	ldr r1,[pool_023300CC]	; 0232FF94
	ldrh r3,[r1,#0x0]	; 0232FF96
	lsl r3,r3,#0x1c	; 0232FF98
	lsr r3,r3,#0x1c	; 0232FF9A
	cmp r3,#0x4	; 0232FF9C
	beq loc_02330090	; 0232FF9E
	add r2,r2,#0x1	; 0232FFA0
	str r2,[r0,#0x18]	; 0232FFA2
	ldrh r2,[r1,#0x0]	; 0232FFA4
	mov r0,#0xf	; 0232FFA6
	bic r2,r0	; 0232FFA8
	mov r0,#0x4	; 0232FFAA
	orr r2,r0	; 0232FFAC
	strh r2,[r1,#0x0]	; 0232FFAE
	bl loc_023304C4	; 0232FFB0
	cmp r0,#0x0	; 0232FFB4
	bne loc_02330090	; 0232FFB6
	lsl r1,r4,#0	; 0232FFB8
	ldr r0,[pool_023300BC]	; 0232FFBA
	str r1,[r0,#0x18]	; 0232FFBC
	mov r4,#0x3	; 0232FFBE
	b loc_02330090	; 0232FFC0
loc_0232FFC2:
	ldr r1,[pool_023300CC]	; 0232FFC2
	ldrh r3,[r1,#0x0]	; 0232FFC4
	lsl r3,r3,#0x1c	; 0232FFC6
	lsr r3,r3,#0x1c	; 0232FFC8
	cmp r3,#0x0	; 0232FFCA
	beq loc_02330090	; 0232FFCC
	add r2,r2,#0x1	; 0232FFCE
	str r2,[r0,#0x18]	; 0232FFD0
	ldrh r2,[r1,#0x0]	; 0232FFD2
	mov r0,#0xf	; 0232FFD4
	bic r2,r0	; 0232FFD6
	strh r2,[r1,#0x0]	; 0232FFD8
	bl loc_023304C4	; 0232FFDA
	cmp r0,#0x0	; 0232FFDE
	bne loc_02330090	; 0232FFE0
	lsl r1,r4,#0	; 0232FFE2
	ldr r0,[pool_023300BC]	; 0232FFE4
	str r1,[r0,#0x18]	; 0232FFE6
	mov r4,#0x3	; 0232FFE8
	b loc_02330090	; 0232FFEA
loc_0232FFEC:
	str r4,[r0,#0x18]	; 0232FFEC
	b loc_02330090	; 0232FFEE
loc_0232FFF0:
	ldr r2,[r0,#0x18]	; 0232FFF0
	cmp r2,#0x0	; 0232FFF2
	bne loc_02330052	; 0232FFF4
	ldr r1,[r0,#0x8]	; 0232FFF6
	ldr r1,[r1,#0x0]	; 0232FFF8
	cmp r1,#0x1	; 0232FFFA
	bne loc_02330028	; 0232FFFC
	ldr r1,[pool_023300CC]	; 0232FFFE
	ldrh r3,[r1,#0x0]	; 02330000
	lsl r3,r3,#0x19	; 02330002
	lsr r3,r3,#0x1f	; 02330004
	cmp r3,#0x0	; 02330006
	bne loc_02330090	; 02330008
	add r2,r2,#0x1	; 0233000A
	str r2,[r0,#0x18]	; 0233000C
	ldrh r2,[r1,#0x0]	; 0233000E
	mov r0,#0x40	; 02330010
	orr r2,r0	; 02330012
	strh r2,[r1,#0x0]	; 02330014
	bl loc_023304C4	; 02330016
	cmp r0,#0x0	; 0233001A
	bne loc_02330090	; 0233001C
	lsl r1,r4,#0	; 0233001E
	ldr r0,[pool_023300BC]	; 02330020
	str r1,[r0,#0x18]	; 02330022
	mov r4,#0x3	; 02330024
	b loc_02330090	; 02330026
loc_02330028:
	ldr r1,[pool_023300CC]	; 02330028
	ldrh r3,[r1,#0x0]	; 0233002A
	lsl r3,r3,#0x19	; 0233002C
	lsr r3,r3,#0x1f	; 0233002E
	cmp r3,#0x0	; 02330030
	beq loc_02330090	; 02330032
	add r2,r2,#0x1	; 02330034
	str r2,[r0,#0x18]	; 02330036
	ldrh r2,[r1,#0x0]	; 02330038
	mov r0,#0x40	; 0233003A
	bic r2,r0	; 0233003C
	strh r2,[r1,#0x0]	; 0233003E
	bl loc_023304C4	; 02330040
	cmp r0,#0x0	; 02330044
	bne loc_02330090	; 02330046
	lsl r1,r4,#0	; 02330048
	ldr r0,[pool_023300BC]	; 0233004A
	str r1,[r0,#0x18]	; 0233004C
	mov r4,#0x3	; 0233004E
	b loc_02330090	; 02330050
loc_02330052:
	str r4,[r0,#0x18]	; 02330052
	b loc_02330090	; 02330054
loc_02330056:
	mov r4,#0x4	; 02330056
	mov r1,#0x0	; 02330058
	ldr r0,[pool_023300BC]	; 0233005A
	str r1,[r0,#0x18]	; 0233005C
	b loc_02330090	; 0233005E
loc_02330060:
	mov r2,#0x0	; 02330060
	ldr r1,[pool_023300BC]	; 02330062
	str r2,[r1,#0x18]	; 02330064
	cmp r0,#0x4	; 02330066
	bhi loc_0233008E	; 02330068
	add r0,r0,r0	; 0233006A
P1_SwitchIndexPC_0233006A:
	add r0,pc	; 0233006C
	ldrh r0,[r0,#(P1_SwitchTable_0233006A - (P1_SwitchIndexPC_0233006A + 4))]	; 0233006E
	lsl r0,r0,#0x10	; 02330070
	asr r0,r0,#0x10	; 02330072
P1_SwitchTargetPC_0233006A:
	add r0,pc	; 02330074
	bx r0	; 02330076
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0233006A:
	.halfword (loc_0233008E + 1) - (P1_SwitchTargetPC_0233006A + 4)
	.halfword (loc_02330082 + 1) - (P1_SwitchTargetPC_0233006A + 4)
	.halfword (loc_02330086 + 1) - (P1_SwitchTargetPC_0233006A + 4)
	.halfword (loc_0233008A + 1) - (P1_SwitchTargetPC_0233006A + 4)
	.halfword (loc_0233008E + 1) - (P1_SwitchTargetPC_0233006A + 4)
P1_SwitchTable_0233006AEnd:
loc_02330082:
	mov r4,#0x4	; 02330082
	b loc_02330090	; 02330084
loc_02330086:
	mov r4,#0x5	; 02330086
	b loc_02330090	; 02330088
loc_0233008A:
	mov r4,#0x1	; 0233008A
	b loc_02330090	; 0233008C
loc_0233008E:
	mov r4,#0x6	; 0233008E
loc_02330090:
	ldr r0,[pool_023300BC]	; 02330090
	ldr r1,[r0,#0x18]	; 02330092
	cmp r1,#0x0	; 02330094
	bne loc_023300B4	; 02330096
	ldr r1,[r0,#0x0]	; 02330098
	cmp r1,#0x0	; 0233009A
	beq loc_023300A2	; 0233009C
	mov r1,#0x0	; 0233009E
	str r1,[r0,#0x0]	; 023300A0
loc_023300A2:
	ldr r1,[pool_023300BC]	; 023300A2
	ldr r2,[r1,#0x4]	; 023300A4
	cmp r2,#0x0	; 023300A6
	beq loc_023300B4	; 023300A8
	mov r0,#0x0	; 023300AA
	str r0,[r1,#0x4]	; 023300AC
	add r0,r4,#0x0	; 023300AE
	ldr r1,[r1,#0x10]	; 023300B0
	blx r2	; 023300B2
loc_023300B4:
	add sp,#0x4	; 023300B4
	pop {r4,r5}	; 023300B6
	pop {r3}	; 023300B8
	bx r3	; 023300BA
pool_023300BC:
loc_023300BC:
	.word P1_BssStart + 0x2831C	; 023300BC
pool_023300C0:
loc_023300C0:
	.word 0x00007F00	; 023300C0
pool_023300C4:
loc_023300C4:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset	; 023300C4
pool_023300C8:
loc_023300C8:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 023300C8
pool_023300CC:
loc_023300CC:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x2	; 023300CC

; ===== function loc_023300D0 =====
loc_023300D0:
	push {lr}	; 023300D0
	sub sp,#0x4	; 023300D2
	ldr r2,[pool_023300F4]	; 023300D4
	mov r3,#0x0	; 023300D6
	bl loc_023300FC	; 023300D8
	ldr r1,[pool_023300F8]	; 023300DC
	str r0,[r1,#0x20]	; 023300DE
	cmp r0,#0x0	; 023300E0
	bne loc_023300E8	; 023300E2
	blx loc_0232FAFC	; 023300E4
loc_023300E8:
	ldr r0,[pool_023300F8]	; 023300E8
	ldr r0,[r0,#0x20]	; 023300EA
	add sp,#0x4	; 023300EC
	pop {r3}	; 023300EE
	bx r3	; 023300F0
	.byte 0xC0, 0x46	; 023300F4
pool_023300F4:
loc_023300F4:
	.word 0x0232FB15	; 023300F4
pool_023300F8:
loc_023300F8:
	.word P1_BssStart + 0x2831C	; 023300F8

; ===== function loc_023300FC =====
loc_023300FC:
	push {r4,r5,r6,r7,lr}	; 023300FC
	sub sp,#0xc	; 023300FE
	add r5,r0,#0x0	; 02330100
	add r6,r1,#0x0	; 02330102
	add r7,r2,#0x0	; 02330104
	str r3,[sp,#0x0]	; 02330106
	mov r4,#0x0	; 02330108
	cmp r5,#0x2	; 0233010A
	blt loc_02330118	; 0233010C
	mov r0,#0x2	; 0233010E
	add sp,#0xc	; 02330110
	pop {r4,r5,r6,r7}	; 02330112
	pop {r3}	; 02330114
	bx r3	; 02330116
loc_02330118:
	add r0,r6,#0x0	; 02330118
	bl loc_0232FD20	; 0233011A
	cmp r0,#0x0	; 0233011E
	bne loc_0233012C	; 02330120
	mov r0,#0x2	; 02330122
	add sp,#0xc	; 02330124
	pop {r4,r5,r6,r7}	; 02330126
	pop {r3}	; 02330128
	bx r3	; 0233012A
loc_0233012C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0233012C
	ldr r1,[pool_023301A4]	; 02330130
	ldr r2,[r1,#0x0]	; 02330132
	cmp r2,#0x0	; 02330134
	beq loc_02330146	; 02330136
	blx P1_Arm9RestoreIrqMask	; 02330138
	mov r0,#0x1	; 0233013C
	add sp,#0xc	; 0233013E
	pop {r4,r5,r6,r7}	; 02330140
	pop {r3}	; 02330142
	bx r3	; 02330144
loc_02330146:
	mov r2,#0x1	; 02330146
	str r2,[r1,#0x0]	; 02330148
	blx P1_Arm9RestoreIrqMask	; 0233014A
	lsl r0,r4,#0	; 0233014E
	ldr r1,[pool_023301A4]	; 02330150
	str r0,[r1,#0x18]	; 02330152
	str r7,[r1,#0x4]	; 02330154
	ldr r0,[sp,#0x0]	; 02330156
	str r0,[r1,#0x10]	; 02330158
	add r0,r6,#0x0	; 0233015A
	bl loc_0232FC6C	; 0233015C
	str r0,[sp,#0x4]	; 02330160
	ldr r1,[pool_023301A8]	; 02330162
	str r0,[r1,#0x0]	; 02330164
	cmp r5,#0x0	; 02330166
	beq loc_02330170	; 02330168
	cmp r5,#0x1	; 0233016A
	beq loc_0233017E	; 0233016C
	b loc_0233018A	; 0233016E
loc_02330170:
	mov r1,#0xb	; 02330170
	ldr r0,[pool_023301A4]	; 02330172
	str r1,[r0,#0x14]	; 02330174
	bl loc_023304E8	; 02330176
	add r4,r0,#0x0	; 0233017A
	b loc_0233018A	; 0233017C
loc_0233017E:
	mov r1,#0xc	; 0233017E
	ldr r0,[pool_023301A4]	; 02330180
	str r1,[r0,#0x14]	; 02330182
	bl loc_023304DC	; 02330184
	add r4,r0,#0x0	; 02330188
loc_0233018A:
	cmp r4,#0x0	; 0233018A
	beq loc_02330198	; 0233018C
	mov r0,#0x0	; 0233018E
	add sp,#0xc	; 02330190
	pop {r4,r5,r6,r7}	; 02330192
	pop {r3}	; 02330194
	bx r3	; 02330196
loc_02330198:
	mov r0,#0x3	; 02330198
	add sp,#0xc	; 0233019A
	pop {r4,r5,r6,r7}	; 0233019C
	pop {r3}	; 0233019E
	bx r3	; 023301A0
	.byte 0xC0, 0x46	; 023301A4
pool_023301A4:
loc_023301A4:
	.word P1_BssStart + 0x2831C	; 023301A4
pool_023301A8:
loc_023301A8:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 023301A8

; ===== function loc_023301AC =====
loc_023301AC:
	push {lr}	; 023301AC
	sub sp,#0x4	; 023301AE
	ldr r2,[pool_023301D0]	; 023301B0
	mov r3,#0x0	; 023301B2
	bl loc_023301D8	; 023301B4
	ldr r1,[pool_023301D4]	; 023301B8
	str r0,[r1,#0x20]	; 023301BA
	cmp r0,#0x0	; 023301BC
	bne loc_023301C4	; 023301BE
	blx loc_0232FAFC	; 023301C0
loc_023301C4:
	ldr r0,[pool_023301D4]	; 023301C4
	ldr r0,[r0,#0x20]	; 023301C6
	add sp,#0x4	; 023301C8
	pop {r3}	; 023301CA
	bx r3	; 023301CC
	.byte 0xC0, 0x46	; 023301D0
pool_023301D0:
loc_023301D0:
	.word 0x0232FB15	; 023301D0
pool_023301D4:
loc_023301D4:
	.word P1_BssStart + 0x2831C	; 023301D4

; ===== function loc_023301D8 =====
loc_023301D8:
	push {r4,r5,r6,r7,lr}	; 023301D8
	sub sp,#0x4	; 023301DA
	add r5,r0,#0x0	; 023301DC
	add r4,r1,#0x0	; 023301DE
	add r6,r2,#0x0	; 023301E0
	add r7,r3,#0x0	; 023301E2
	cmp r5,#0x2	; 023301E4
	blt loc_023301F2	; 023301E6
	mov r0,#0x2	; 023301E8
	add sp,#0x4	; 023301EA
	pop {r4,r5,r6,r7}	; 023301EC
	pop {r3}	; 023301EE
	bx r3	; 023301F0
loc_023301F2:
	ldr r0,[r4,#0x0]	; 023301F2
	cmp r0,#0x1	; 023301F4
	ble loc_02330202	; 023301F6
	mov r0,#0x2	; 023301F8
	add sp,#0x4	; 023301FA
	pop {r4,r5,r6,r7}	; 023301FC
	pop {r3}	; 023301FE
	bx r3	; 02330200
loc_02330202:
	blx P1_Arm9DisableIrqReturnPriorMask	; 02330202
	ldr r1,[pool_02330264]	; 02330206
	ldr r2,[r1,#0x0]	; 02330208
	cmp r2,#0x0	; 0233020A
	beq loc_0233021C	; 0233020C
	blx P1_Arm9RestoreIrqMask	; 0233020E
	mov r0,#0x1	; 02330212
	add sp,#0x4	; 02330214
	pop {r4,r5,r6,r7}	; 02330216
	pop {r3}	; 02330218
	bx r3	; 0233021A
loc_0233021C:
	mov r2,#0x1	; 0233021C
	str r2,[r1,#0x0]	; 0233021E
	blx P1_Arm9RestoreIrqMask	; 02330220
	cmp r5,#0x0	; 02330224
	beq loc_0233022E	; 02330226
	cmp r5,#0x1	; 02330228
	beq loc_02330236	; 0233022A
	b loc_0233023C	; 0233022C
loc_0233022E:
	mov r1,#0x9	; 0233022E
	ldr r0,[pool_02330264]	; 02330230
	str r1,[r0,#0x14]	; 02330232
	b loc_0233023C	; 02330234
loc_02330236:
	mov r1,#0xa	; 02330236
	ldr r0,[pool_02330264]	; 02330238
	str r1,[r0,#0x14]	; 0233023A
loc_0233023C:
	mov r1,#0x0	; 0233023C
	ldr r0,[pool_02330264]	; 0233023E
	str r1,[r0,#0x18]	; 02330240
	str r4,[r0,#0x8]	; 02330242
	str r6,[r0,#0x4]	; 02330244
	str r7,[r0,#0x10]	; 02330246
	bl loc_023304D0	; 02330248
	cmp r0,#0x0	; 0233024C
	beq loc_0233025A	; 0233024E
	mov r0,#0x0	; 02330250
	add sp,#0x4	; 02330252
	pop {r4,r5,r6,r7}	; 02330254
	pop {r3}	; 02330256
	bx r3	; 02330258
loc_0233025A:
	mov r0,#0x3	; 0233025A
	add sp,#0x4	; 0233025C
	pop {r4,r5,r6,r7}	; 0233025E
	pop {r3}	; 02330260
	bx r3	; 02330262
pool_02330264:
loc_02330264:
	.word P1_BssStart + 0x2831C	; 02330264

; ===== function loc_02330268 =====
loc_02330268:
	ldr r1,[pool_02330270]	; 02330268
	str r0,[r1,#0x1c]	; 0233026A
	bx lr	; 0233026C
	.byte 0xC0, 0x46	; 02330270
pool_02330270:
loc_02330270:
	.word P1_BssStart + 0x2831C	; 02330270

; ===== function loc_02330274 =====
loc_02330274:
	push {lr}	; 02330274
	sub sp,#0x4	; 02330276
	ldr r1,[pool_02330298]	; 02330278
	mov r2,#0x0	; 0233027A
	bl loc_023302A0	; 0233027C
	ldr r1,[pool_0233029C]	; 02330280
	str r0,[r1,#0x20]	; 02330282
	cmp r0,#0x0	; 02330284
	bne loc_0233028C	; 02330286
	blx loc_0232FAFC	; 02330288
loc_0233028C:
	ldr r0,[pool_0233029C]	; 0233028C
	ldr r0,[r0,#0x20]	; 0233028E
	add sp,#0x4	; 02330290
	pop {r3}	; 02330292
	bx r3	; 02330294
	.byte 0xC0, 0x46	; 02330298
pool_02330298:
loc_02330298:
	.word 0x0232FB15	; 02330298
pool_0233029C:
loc_0233029C:
	.word P1_BssStart + 0x2831C	; 0233029C

; ===== function loc_023302A0 =====
loc_023302A0:
	push {r4,r5,lr}	; 023302A0
	sub sp,#0x4	; 023302A2
	add r5,r1,#0x0	; 023302A4
	add r4,r2,#0x0	; 023302A6
	ldrb r1,[r0,#0x0]	; 023302A8
	ldr r0,[pool_023302FC]	; 023302AA
	strb r1,[r0,#0x0]	; 023302AC
	blx P1_Arm9DisableIrqReturnPriorMask	; 023302AE
	ldr r1,[pool_02330300]	; 023302B2
	ldr r2,[r1,#0x0]	; 023302B4
	cmp r2,#0x0	; 023302B6
	beq loc_023302C8	; 023302B8
	blx P1_Arm9RestoreIrqMask	; 023302BA
	mov r0,#0x1	; 023302BE
	add sp,#0x4	; 023302C0
	pop {r4,r5}	; 023302C2
	pop {r3}	; 023302C4
	bx r3	; 023302C6
loc_023302C8:
	mov r2,#0x1	; 023302C8
	str r2,[r1,#0x0]	; 023302CA
	blx P1_Arm9RestoreIrqMask	; 023302CC
	mov r1,#0xf	; 023302D0
	ldr r0,[pool_02330300]	; 023302D2
	str r1,[r0,#0x14]	; 023302D4
	mov r1,#0x0	; 023302D6
	str r1,[r0,#0x18]	; 023302D8
	str r5,[r0,#0x4]	; 023302DA
	str r4,[r0,#0x10]	; 023302DC
	bl loc_023304B8	; 023302DE
	cmp r0,#0x0	; 023302E2
	beq loc_023302F0	; 023302E4
	mov r0,#0x0	; 023302E6
	add sp,#0x4	; 023302E8
	pop {r4,r5}	; 023302EA
	pop {r3}	; 023302EC
	bx r3	; 023302EE
loc_023302F0:
	mov r0,#0x3	; 023302F0
	add sp,#0x4	; 023302F2
	pop {r4,r5}	; 023302F4
	pop {r3}	; 023302F6
	bx r3	; 023302F8
	.byte 0xC0, 0x46	; 023302FC
pool_023302FC:
loc_023302FC:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 023302FC
pool_02330300:
loc_02330300:
	.word P1_BssStart + 0x2831C	; 02330300

; ===== function loc_02330304 =====
P1_Entry_02330304:
	push {lr}	; 02330304
	sub sp,#0x4	; 02330306
	ldr r2,[pool_02330328]	; 02330308
	mov r3,#0x0	; 0233030A
	bl loc_02330330	; 0233030C
	ldr r1,[pool_0233032C]	; 02330310
	str r0,[r1,#0x20]	; 02330312
	cmp r0,#0x0	; 02330314
	bne loc_0233031C	; 02330316
	blx loc_0232FAFC	; 02330318
loc_0233031C:
	ldr r0,[pool_0233032C]	; 0233031C
	ldr r0,[r0,#0x20]	; 0233031E
	add sp,#0x4	; 02330320
	pop {r3}	; 02330322
	bx r3	; 02330324
	.byte 0xC0, 0x46	; 02330328
pool_02330328:
loc_02330328:
	.word 0x0232FB15	; 02330328
pool_0233032C:
loc_0233032C:
	.word P1_BssStart + 0x2831C	; 0233032C

; ===== function loc_02330330 =====
loc_02330330:
	push {r4,r5,r6,lr}	; 02330330
	add r6,r1,#0x0	; 02330332
	add r5,r2,#0x0	; 02330334
	add r4,r3,#0x0	; 02330336
	ldr r1,[pool_023303A4]	; 02330338
	bl loc_0232FBC0	; 0233033A
	cmp r0,#0x0	; 0233033E
	bne loc_0233034A	; 02330340
	mov r0,#0x2	; 02330342
	pop {r4,r5,r6}	; 02330344
	pop {r3}	; 02330346
	bx r3	; 02330348
loc_0233034A:
	add r0,r6,#0x0	; 0233034A
	ldr r1,[pool_023303A8]	; 0233034C
	bl loc_0232FB20	; 0233034E
	cmp r0,#0x0	; 02330352
	bne loc_0233035E	; 02330354
	mov r0,#0x2	; 02330356
	pop {r4,r5,r6}	; 02330358
	pop {r3}	; 0233035A
	bx r3	; 0233035C
loc_0233035E:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0233035E
	ldr r1,[pool_023303AC]	; 02330362
	ldr r2,[r1,#0x0]	; 02330364
	cmp r2,#0x0	; 02330366
	beq loc_02330376	; 02330368
	blx P1_Arm9RestoreIrqMask	; 0233036A
	mov r0,#0x1	; 0233036E
	pop {r4,r5,r6}	; 02330370
	pop {r3}	; 02330372
	bx r3	; 02330374
loc_02330376:
	mov r2,#0x1	; 02330376
	str r2,[r1,#0x0]	; 02330378
	blx P1_Arm9RestoreIrqMask	; 0233037A
	mov r1,#0x5	; 0233037E
	ldr r0,[pool_023303AC]	; 02330380
	str r1,[r0,#0x14]	; 02330382
	mov r1,#0x0	; 02330384
	str r1,[r0,#0x18]	; 02330386
	str r5,[r0,#0x4]	; 02330388
	str r4,[r0,#0x10]	; 0233038A
	bl loc_023304F4	; 0233038C
	cmp r0,#0x0	; 02330390
	beq loc_0233039C	; 02330392
	mov r0,#0x0	; 02330394
	pop {r4,r5,r6}	; 02330396
	pop {r3}	; 02330398
	bx r3	; 0233039A
loc_0233039C:
	mov r0,#0x3	; 0233039C
	pop {r4,r5,r6}	; 0233039E
	pop {r3}	; 023303A0
	bx r3	; 023303A2
pool_023303A4:
loc_023303A4:
	.word 0x027FFDE8	; 023303A4
pool_023303A8:
loc_023303A8:
	.word 0x027FFDEC	; 023303A8
pool_023303AC:
loc_023303AC:
	.word P1_BssStart + 0x2831C	; 023303AC

; ===== function loc_023303B0 =====
loc_023303B0:
	push {lr}	; 023303B0
	sub sp,#0x4	; 023303B2
	ldr r2,[pool_023303D4]	; 023303B4
	mov r3,#0x0	; 023303B6
	bl loc_023303DC	; 023303B8
	ldr r1,[pool_023303D8]	; 023303BC
	str r0,[r1,#0x20]	; 023303BE
	cmp r0,#0x0	; 023303C0
	bne loc_023303C8	; 023303C2
	blx loc_0232FAFC	; 023303C4
loc_023303C8:
	ldr r0,[pool_023303D8]	; 023303C8
	ldr r0,[r0,#0x20]	; 023303CA
	add sp,#0x4	; 023303CC
	pop {r3}	; 023303CE
	bx r3	; 023303D0
	.byte 0xC0, 0x46	; 023303D4
pool_023303D4:
loc_023303D4:
	.word 0x0232FB15	; 023303D4
pool_023303D8:
loc_023303D8:
	.word P1_BssStart + 0x2831C	; 023303D8

; ===== function loc_023303DC =====
loc_023303DC:
	push {r4,r5,r6,r7,lr}	; 023303DC
	sub sp,#0x4	; 023303DE
	add r5,r0,#0x0	; 023303E0
	add r4,r1,#0x0	; 023303E2
	add r6,r2,#0x0	; 023303E4
	add r7,r3,#0x0	; 023303E6
	blx P1_Arm9DisableIrqReturnPriorMask	; 023303E8
	ldr r1,[pool_02330438]	; 023303EC
	ldr r2,[r1,#0x0]	; 023303EE
	cmp r2,#0x0	; 023303F0
	beq loc_02330402	; 023303F2
	blx P1_Arm9RestoreIrqMask	; 023303F4
	mov r0,#0x1	; 023303F8
	add sp,#0x4	; 023303FA
	pop {r4,r5,r6,r7}	; 023303FC
	pop {r3}	; 023303FE
	bx r3	; 02330400
loc_02330402:
	mov r2,#0x1	; 02330402
	str r2,[r1,#0x0]	; 02330404
	blx P1_Arm9RestoreIrqMask	; 02330406
	mov r1,#0x2	; 0233040A
	ldr r0,[pool_02330438]	; 0233040C
	str r1,[r0,#0x14]	; 0233040E
	mov r1,#0x0	; 02330410
	str r1,[r0,#0x18]	; 02330412
	str r5,[r0,#0x8]	; 02330414
	str r4,[r0,#0xc]	; 02330416
	str r6,[r0,#0x4]	; 02330418
	str r7,[r0,#0x10]	; 0233041A
	bl loc_02330500	; 0233041C
	cmp r0,#0x0	; 02330420
	beq loc_0233042E	; 02330422
	mov r0,#0x0	; 02330424
	add sp,#0x4	; 02330426
	pop {r4,r5,r6,r7}	; 02330428
	pop {r3}	; 0233042A
	bx r3	; 0233042C
loc_0233042E:
	mov r0,#0x3	; 0233042E
	add sp,#0x4	; 02330430
	pop {r4,r5,r6,r7}	; 02330432
	pop {r3}	; 02330434
	bx r3	; 02330436
pool_02330438:
loc_02330438:
	.word P1_BssStart + 0x2831C	; 02330438

; ===== function loc_0233043C =====
loc_0233043C:
	push {r4,r5,lr}	; 0233043C
	sub sp,#0x4	; 0233043E
	ldr r0,[pool_02330480]	; 02330440
	ldrh r1,[r0,#0x0]	; 02330442
	cmp r1,#0x0	; 02330444
	bne loc_02330476	; 02330446
	mov r1,#0x1	; 02330448
	strh r1,[r0,#0x0]	; 0233044A
	mov r1,#0x0	; 0233044C
	ldr r0,[pool_02330484]	; 0233044E
	str r1,[r0,#0x0]	; 02330450
	str r1,[r0,#0x4]	; 02330452
	str r1,[r0,#0x1c]	; 02330454
	str r1,[r0,#0x8]	; 02330456
	str r1,[r0,#0xc]	; 02330458
	bl loc_0232ECB8	; 0233045A
	mov r5,#0x5	; 0233045E
	mov r4,#0x1	; 02330460
loc_02330462:
	add r0,r5,#0x0	; 02330462
	add r1,r4,#0x0	; 02330464
	bl loc_0232EE2C	; 02330466
	cmp r0,#0x0	; 0233046A
	beq loc_02330462	; 0233046C
	mov r0,#0x5	; 0233046E
	ldr r1,[pool_02330488]	; 02330470
	bl loc_0232EE58	; 02330472
loc_02330476:
	add sp,#0x4	; 02330476
	pop {r4,r5}	; 02330478
	pop {r3}	; 0233047A
	bx r3	; 0233047C
	.byte 0xC0, 0x46	; 02330480
pool_02330480:
loc_02330480:
	.word P1_BssStart + 0x28318	; 02330480
pool_02330484:
loc_02330484:
	.word P1_BssStart + 0x2831C	; 02330484
pool_02330488:
loc_02330488:
	.word 0x0232FDE1	; 02330488
loc_0233048C:
	push {lr}	; 0233048C
	sub sp,#0x4	; 0233048E
	add r1,r0,#0x0	; 02330490
	mov r0,#0x5	; 02330492
	lsl r1,r1,#0x8	; 02330494
	ldr r2,[pool_023304B4]	; 02330496
	and r1,r2	; 02330498
	mov r2,#0x0	; 0233049A
	bl loc_0232ED98	; 0233049C
	cmp r0,#0x0	; 023304A0
	blt loc_023304AC	; 023304A2
	mov r0,#0x1	; 023304A4
	add sp,#0x4	; 023304A6
	pop {r3}	; 023304A8
	bx r3	; 023304AA
loc_023304AC:
	mov r0,#0x0	; 023304AC
	add sp,#0x4	; 023304AE
	pop {r3}	; 023304B0
	bx r3	; 023304B2
pool_023304B4:
loc_023304B4:
	.word 0x00007F00	; 023304B4

; ===== function loc_023304B8 =====
loc_023304B8:
	mov r0,#0x28	; 023304B8
	ldr r3,[pool_023304C0]	; 023304BA
	bx r3	; 023304BC
	.byte 0xC0, 0x46	; 023304C0
pool_023304C0:
loc_023304C0:
	.word loc_0233048C + 1	; 023304C0

; ===== function loc_023304C4 =====
loc_023304C4:
	mov r0,#0x27	; 023304C4
	ldr r3,[pool_023304CC]	; 023304C6
	bx r3	; 023304C8
	.byte 0xC0, 0x46	; 023304CC
pool_023304CC:
loc_023304CC:
	.word loc_0233048C + 1	; 023304CC

; ===== function loc_023304D0 =====
loc_023304D0:
	mov r0,#0x17	; 023304D0
	ldr r3,[pool_023304D8]	; 023304D2
	bx r3	; 023304D4
	.byte 0xC0, 0x46	; 023304D8
pool_023304D8:
loc_023304D8:
	.word loc_0233048C + 1	; 023304D8

; ===== function loc_023304DC =====
loc_023304DC:
	mov r0,#0x25	; 023304DC
	ldr r3,[pool_023304E4]	; 023304DE
	bx r3	; 023304E0
	.byte 0xC0, 0x46	; 023304E4
pool_023304E4:
loc_023304E4:
	.word loc_0233048C + 1	; 023304E4

; ===== function loc_023304E8 =====
loc_023304E8:
	mov r0,#0x24	; 023304E8
	ldr r3,[pool_023304F0]	; 023304EA
	bx r3	; 023304EC
	.byte 0xC0, 0x46	; 023304F0
pool_023304F0:
loc_023304F0:
	.word loc_0233048C + 1	; 023304F0

; ===== function loc_023304F4 =====
loc_023304F4:
	mov r0,#0x20	; 023304F4
	ldr r3,[pool_023304FC]	; 023304F6
	bx r3	; 023304F8
	.byte 0xC0, 0x46	; 023304FC
pool_023304FC:
loc_023304FC:
	.word loc_0233048C + 1	; 023304FC

; ===== function loc_02330500 =====
loc_02330500:
	mov r0,#0x10	; 02330500
	ldr r3,[pool_02330508]	; 02330502
	bx r3	; 02330504
	.byte 0xC0, 0x46	; 02330508
pool_02330508:
loc_02330508:
	.word loc_0233048C + 1	; 02330508
	.byte 0x0D, 0xCE, 0x32, 0x02, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00, 0x59, 0x42, 0x36, 0x02	; 0233051C
	.byte 0xB5, 0x7C, 0x36, 0x02, 0xC1, 0x91, 0x35, 0x02	; 0233051C
P1_Data_02330524:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 02330524
P1_Data_0233052C:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0233052C
P1_Data_02330534:
	.byte 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 02330534
	.byte 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x05, 0x00, 0x04, 0x00	; 0233054C
	.byte 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x05, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00	; 0233055C
	.byte 0x05, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00	; 0233055C
P1_Data_02330564:
	.byte 0x09, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00	; 02330564
	.byte 0x0B, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00	; 0233056C
P1_Data_02330574:
	.byte 0x05, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00	; 02330574
	.byte 0x04, 0x00, 0x00, 0x00, 0x06, 0x00, 0x07, 0x00, 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00	; 0233058C
	.byte 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00	; 0233059C
	.byte 0x00, 0x00, 0x54, 0x00, 0x06, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00	; 023305AC
	.byte 0x00, 0x00, 0x30, 0x00, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 023305BC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x34, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00	; 023305CC
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023305DC
	.byte 0x00, 0x00, 0xD0, 0xFF, 0x03, 0x00, 0x00, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 023305EC
	.byte 0x00, 0x70, 0x07, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x08, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 023305FC
	.byte 0x00, 0x80, 0x08, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x07, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 0233060C
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x07, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x07, 0x00	; 0233061C
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x0A, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x0A, 0x00	; 0233062C
	.byte 0x00, 0x60, 0x08, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x04, 0x00	; 0233063C
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x08, 0x00, 0x00, 0x10, 0x07, 0x00	; 0233064C
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x07, 0x00, 0x00, 0xE0, 0x04, 0x00	; 0233065C
	.byte 0x00, 0x90, 0x07, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x07, 0x00	; 0233066C
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x01, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x01, 0x00	; 0233067C
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x04, 0x00	; 0233068C
	.byte 0x00, 0x80, 0x0E, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x90, 0x0F, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0233069C
	.byte 0x00, 0x90, 0x0F, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x80, 0x0E, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 023306AC
	.byte 0x00, 0x70, 0x00, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 023306BC
	.byte 0x00, 0x80, 0x01, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 023306CC
	.byte 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00	; 023306DC
P1_Data_023306DC:
	.byte 0x0A, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00	; 023306DC
	.byte 0x06, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 023306FC
	.byte 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 023306FC
P1_Data_02330704:
	.byte 0x00, 0x00	; 02330704
P1_Data_02330706:
	.byte 0x95, 0x00	; 02330706
P1_Data_02330708:
	.byte 0x7F, 0x00, 0x00, 0x00	; 02330708
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x02, 0x00, 0x8A, 0x00, 0x74, 0x00, 0x0E, 0x00, 0x01, 0x00	; 0233071C
	.byte 0x00, 0x00, 0x06, 0x00, 0x02, 0x00, 0x91, 0x00, 0x7B, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x00, 0x00	; 0233072C
	.byte 0x09, 0x00, 0x02, 0x00, 0x86, 0x00, 0x70, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00	; 0233073C
	.byte 0x02, 0x00, 0x8F, 0x00, 0x79, 0x00, 0x0E, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00	; 0233074C
	.byte 0x8B, 0x00, 0x75, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x05, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8D, 0x00	; 0233075C
	.byte 0x77, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x06, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8C, 0x00, 0x76, 0x00	; 0233076C
	.byte 0x0E, 0x00, 0x01, 0x00, 0x07, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8E, 0x00, 0x78, 0x00, 0x0E, 0x00	; 0233077C
	.byte 0x01, 0x00, 0x08, 0x00, 0x06, 0x00, 0x03, 0x00, 0x92, 0x00, 0x7C, 0x00, 0x0E, 0x00, 0x02, 0x00	; 0233078C
	.byte 0x09, 0x00, 0x09, 0x00, 0x03, 0x00, 0x93, 0x00, 0x7D, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0A, 0x00	; 0233079C
	.byte 0x09, 0x00, 0x03, 0x00, 0x94, 0x00, 0x7E, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0B, 0x00, 0x09, 0x00	; 023307AC
	.byte 0x03, 0x00, 0x88, 0x00, 0x72, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x03, 0x00	; 023307BC
	.byte 0x89, 0x00, 0x73, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x0D, 0x00, 0x0C, 0x00, 0x01, 0x00, 0x90, 0x00	; 023307CC
	.byte 0x7A, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x85, 0x00, 0x6F, 0x00	; 023307DC
	.byte 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x03, 0x00, 0x87, 0x00, 0x71, 0x00, 0x0E, 0x00	; 023307EC
	.byte 0x03, 0x00, 0x10, 0x00, 0x0C, 0x00, 0x02, 0x00, 0x85, 0x00, 0x6F, 0x00, 0x0F, 0x00, 0x11, 0x00	; 023307FC
	.byte 0x00, 0x00, 0xFF, 0xFF	; 023307FC
P1_Data_02330800:
	.byte 0x00, 0x00, 0x60, 0x00	; 02330800
P1_Data_02330804:
	.byte 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00	; 02330804
P1_Data_0233080C:
	.byte 0x03, 0x00, 0x24, 0x00	; 0233080C
P1_Data_02330810:
	.byte 0x01, 0x00	; 02330810
P1_Data_02330812:
	.byte 0x01, 0x00, 0x02, 0x00, 0x2B, 0x00, 0x00, 0x00, 0x02, 0x00	; 02330812
P1_Data_0233081C:
	.byte 0x30, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00	; 0233081C
	.byte 0x38, 0x00, 0x39, 0x00, 0x00, 0x00, 0x00, 0x00	; 0233082C
P1_Data_02330834:
	.byte 0x03, 0x03, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00	; 02330834
	.byte 0xFF, 0x0F, 0xFF, 0x0F, 0xC7, 0x01, 0x00, 0x00, 0x4D, 0x82, 0x32, 0x02, 0x49, 0x82, 0x32, 0x02	; 0233084C
	.byte 0x45, 0x82, 0x32, 0x02, 0x00, 0x00, 0x00, 0x00, 0x41, 0x82, 0x32, 0x02, 0x24, 0xD4, 0x00, 0x00	; 0233085C
	.byte 0x0F, 0x40, 0x00, 0x00, 0x00, 0x01, 0x81, 0x82, 0x82, 0x83, 0x0F, 0x83, 0x0C, 0xC3, 0x03, 0x83	; 0233086C
	.byte 0x01, 0x83, 0x04, 0xC3, 0x08, 0x0E, 0x02, 0xC2, 0x0D, 0xC2, 0x07, 0x0B, 0x06, 0x0A, 0x05, 0x09	; 0233087C
; ASCII VIB build identifier with the embedded build date. / 含内嵌构建日期的 ASCII VIB 构建标识。
P1_VibBuildIdentifier:
	.ascii "VIB2.11Nov 26 2004", 0
	.byte 0x00	; 0233088F
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P1_CrtDataInitTable:
	.word P1_CopyDescriptors, P1_CopyDescriptorsEnd
	.word P1_ItcmLoadStart
	.word P1_BssStart, P3_FirmwareUiEntry
	.byte 0x2D, 0xFD, 0x5B, 0xFE, 0x97, 0xFE, 0xBB, 0xFE, 0xD4, 0xFE, 0xE7, 0xFE, 0xF7, 0xFE, 0x04, 0xFF	; 023308A4
	.byte 0x10, 0xFF, 0x1A, 0xFF, 0x23, 0xFF, 0x2C, 0xFF, 0x33, 0xFF, 0x3A, 0xFF, 0x40, 0xFF, 0x46, 0xFF	; 023308B4
	.byte 0x4C, 0xFF, 0x51, 0xFF, 0x56, 0xFF, 0x5B, 0xFF, 0x5F, 0xFF, 0x64, 0xFF, 0x68, 0xFF, 0x6C, 0xFF	; 023308C4
	.byte 0x6F, 0xFF, 0x73, 0xFF, 0x76, 0xFF, 0x7A, 0xFF, 0x7D, 0xFF, 0x80, 0xFF, 0x83, 0xFF, 0x86, 0xFF	; 023308D4
	.byte 0x88, 0xFF, 0x8B, 0xFF, 0x8E, 0xFF, 0x90, 0xFF, 0x92, 0xFF, 0x95, 0xFF, 0x97, 0xFF, 0x99, 0xFF	; 023308E4
	.byte 0x9C, 0xFF, 0x9E, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA4, 0xFF, 0xA6, 0xFF, 0xA8, 0xFF, 0xAA, 0xFF	; 023308F4
	.byte 0xAB, 0xFF, 0xAD, 0xFF, 0xAF, 0xFF, 0xB1, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB7, 0xFF	; 02330904
	.byte 0xB9, 0xFF, 0xBA, 0xFF, 0xBC, 0xFF, 0xBD, 0xFF, 0xBF, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC3, 0xFF	; 02330914
	.byte 0xC4, 0xFF, 0xC6, 0xFF, 0xC7, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF, 0xCB, 0xFF, 0xCC, 0xFF, 0xCD, 0xFF	; 02330924
	.byte 0xCF, 0xFF, 0xD0, 0xFF, 0xD1, 0xFF, 0xD2, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD7, 0xFF	; 02330934
	.byte 0xD8, 0xFF, 0xD9, 0xFF, 0xDA, 0xFF, 0xDB, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDE, 0xFF, 0xDF, 0xFF	; 02330944
	.byte 0xE0, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE3, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF, 0xE6, 0xFF, 0xE7, 0xFF	; 02330954
	.byte 0xE8, 0xFF, 0xE9, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEB, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEE, 0xFF	; 02330964
	.byte 0xEF, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF1, 0xFF, 0xF2, 0xFF, 0xF3, 0xFF, 0xF4, 0xFF, 0xF4, 0xFF	; 02330974
	.byte 0xF5, 0xFF, 0xF6, 0xFF, 0xF7, 0xFF, 0xF7, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFA, 0xFF	; 02330984
	.byte 0xFB, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF, 0xFD, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00	; 02330994
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023309A4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023309B4
P1_Data_023309C0:
	.byte 0x00, 0x00, 0xAA, 0x01	; 023309C0
	.byte 0x50, 0x03, 0xED, 0x04, 0x82, 0x06, 0xFE, 0x07, 0x65, 0x09, 0xB1, 0x0A, 0xE3, 0x0B, 0xF0, 0x0C	; 023309C4
	.byte 0xD9, 0x0D, 0x9B, 0x0E, 0x37, 0x0F, 0xA6, 0x0F, 0xE9, 0x0F, 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F	; 023309D4
	.byte 0x39, 0x0F, 0xA1, 0x0E, 0xDC, 0x0D, 0xF4, 0x0C, 0xE8, 0x0B, 0xBA, 0x0A, 0x6A, 0x09, 0x04, 0x08	; 023309E4
	.byte 0x87, 0x06, 0xF9, 0x04, 0x56, 0x03, 0xB1, 0x01, 0x06, 0x00, 0x5C, 0xFE, 0xB0, 0xFC, 0x13, 0xFB	; 023309F4
	.byte 0x84, 0xF9, 0x07, 0xF8, 0x9B, 0xF6, 0x4F, 0xF5, 0x21, 0xF4, 0x13, 0xF3, 0x27, 0xF2, 0x65, 0xF1	; 02330A04
	.byte 0xCB, 0xF0, 0x5B, 0xF0, 0x17, 0xF0, 0x00, 0xF0, 0x16, 0xF0, 0x58, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1	; 02330A14
	.byte 0x21, 0xF2, 0x08, 0xF3, 0x18, 0xF4, 0x46, 0xF5, 0x91, 0xF6, 0xF7, 0xF7, 0x79, 0xF9, 0x07, 0xFB	; 02330A24
	.byte 0xA3, 0xFC, 0x49, 0xFE	; 02330A34
P1_Data_02330A38:
	.byte 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F, 0x39, 0x0F, 0x9E, 0x0E, 0xDC, 0x0D	; 02330A38
	.byte 0xF4, 0x0C, 0xE8, 0x0B, 0xB5, 0x0A, 0x6A, 0x09, 0x04, 0x08, 0x87, 0x06, 0xF3, 0x04, 0x56, 0x03	; 02330A44
	.byte 0xB1, 0x01, 0x06, 0x00, 0x56, 0xFE, 0xB0, 0xFC, 0x13, 0xFB, 0x84, 0xF9, 0x02, 0xF8, 0x9B, 0xF6	; 02330A54
	.byte 0x4F, 0xF5, 0x21, 0xF4, 0x10, 0xF3, 0x27, 0xF2, 0x65, 0xF1, 0xCB, 0xF0, 0x5A, 0xF0, 0x17, 0xF0	; 02330A64
	.byte 0x00, 0xF0, 0x16, 0xF0, 0x59, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1, 0x21, 0xF2, 0x0C, 0xF3, 0x18, 0xF4	; 02330A74
	.byte 0x46, 0xF5, 0x91, 0xF6, 0xFC, 0xF7, 0x79, 0xF9, 0x07, 0xFB, 0xA3, 0xFC, 0x4F, 0xFE, 0xFA, 0xFF	; 02330A84
	.byte 0xA4, 0x01, 0x4A, 0x03, 0xED, 0x04, 0x7C, 0x06, 0xF9, 0x07, 0x5F, 0x09, 0xB1, 0x0A, 0xDF, 0x0B	; 02330A94
	.byte 0xED, 0x0C, 0xD6, 0x0D, 0x9B, 0x0E, 0x35, 0x0F, 0xA5, 0x0F, 0xE8, 0x0F, 0x83, 0x00, 0x00, 0x00	; 02330AA4
	.byte 0x80, 0x00, 0x00, 0x00, 0x96, 0x00, 0x00, 0x00, 0x97, 0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0x00	; 02330AB4
	.byte 0x6E, 0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 02330AC4
	.byte 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 02330AD4
	.byte 0x0C, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 02330AE4
	.byte 0x4D, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00	; 02330AF4
	.byte 0x59, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00	; 02330B04
	.byte 0x59, 0x00, 0x00, 0x00	; 02330B14
P1_Data_02330B18:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x00, 0x00	; 02330B18
	.byte 0xA9, 0x00, 0x00, 0x00	; 02330B24
P1_Data_02330B28:
	.byte 0x58, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x20, 0x12, 0x3D, 0x02	; 02330B28
	.byte 0xC0, 0x2B, 0x3D, 0x02, 0x00, 0x40, 0x3D, 0x02, 0x40, 0x56, 0x3D, 0x02, 0x40, 0x6C, 0x3D, 0x02	; 02330B34
	.byte 0x20, 0x82, 0x3D, 0x02	; 02330B44
P1_Data_02330B48:
	.byte 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00	; 02330B48
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04, 0x00	; 02330B54
	.byte 0x06, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00	; 02330B64
	.byte 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330B74
	.byte 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330B84
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00	; 02330B94
	.byte 0x02, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330BA4
	.byte 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BB4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BC4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BD4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BE4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BF4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330C04
	.byte 0x02, 0x00, 0x04, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x05, 0x00, 0x08, 0x00, 0x09, 0x00	; 02330C14
	.byte 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330C24
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330C34
	.byte 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0A, 0x00, 0x07, 0x00, 0x01, 0x00, 0x05, 0x00, 0x01, 0x00	; 02330C44
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330C54
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330C64
	.byte 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00	; 02330C74
	.byte 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 02330C84
	.byte 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00	; 02330C94
	.byte 0x4D, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 02330CA4
	.byte 0x4D, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 02330CB4
	.byte 0x4D, 0x00, 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 02330CC4
	.byte 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00	; 02330CD4
	.byte 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00	; 02330CE4
	.byte 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00	; 02330CF4
	.byte 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00	; 02330D04
	.byte 0x00, 0x00, 0x00, 0x00	; 02330D14
P1_Data_02330D18:
	.byte 0x1F, 0x00, 0x1C, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00	; 02330D18
	.byte 0x1F, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00	; 02330D24
P1_Data_02330D30:
	.byte 0xFF, 0x00, 0x00, 0x00	; 02330D30
	.byte 0x9B, 0x47, 0x26, 0x74, 0xBC, 0x11, 0x4F, 0x6D, 0xBD, 0x11, 0xF1, 0x32, 0xD9, 0x7F, 0xE7, 0x2C	; 02330D34
	.byte 0xA5, 0x5D, 0xBD, 0x11, 0x10, 0x46, 0xA4, 0x5D, 0x90, 0x4E, 0x73, 0x61, 0x84, 0x2A, 0x91, 0x4E	; 02330D44
	.byte 0x6A, 0x10, 0xFE, 0x75, 0xC8, 0x29, 0x39, 0x78, 0x0E, 0x42, 0x1B, 0x5D, 0x38, 0x78, 0xA8, 0x12	; 02330D54
	.byte 0x7D, 0x3F, 0xB9, 0x67, 0xF3, 0x26, 0xEF, 0x54, 0x23, 0x7C, 0xF2, 0x26, 0xC6, 0x6B, 0x37, 0x41	; 02330D64
	.byte 0xAB, 0x15, 0x0D, 0x73, 0xC7, 0x6B, 0x4F, 0x3B, 0x24, 0x5F, 0xDA, 0x3D, 0x3F, 0x25, 0x49, 0x17	; 02330D74
	.byte 0xDB, 0x3D, 0xE6, 0x70, 0x6C, 0x74, 0xF7, 0x30, 0x1F, 0x53, 0x38, 0x67, 0x1E, 0x53, 0x51, 0x1A	; 02330D84
	.byte 0x71, 0x19, 0x7D, 0x5B, 0xD6, 0x4E, 0x70, 0x19, 0x27, 0x3F, 0xCB, 0x75, 0x62, 0x3D, 0x8C, 0x12	; 02330D94
	.byte 0xB8, 0x74, 0xAD, 0x2F, 0xB9, 0x74, 0xFD, 0x64, 0x9A, 0x6C, 0x3A, 0x4F, 0x6D, 0x27, 0xEF, 0x73	; 02330DA4
	.byte 0xB1, 0x38, 0x3B, 0x4F, 0x1E, 0x57, 0xA3, 0x7E, 0x49, 0x62, 0x87, 0x35, 0x7C, 0x1B, 0x86, 0x35	; 02330DB4
	.byte 0xFB, 0x7A, 0xE4, 0x67, 0x92, 0x5C, 0xE5, 0x67, 0xCA, 0x2B, 0x8C, 0x43, 0x6F, 0x2E, 0x7F, 0x58	; 02330DC4
	.byte 0xB7, 0x14, 0x6E, 0x2E, 0xB9, 0x4C, 0xA2, 0x6F, 0xF0, 0x38, 0x9E, 0x71, 0x5A, 0x47, 0x3C, 0x1F	; 02330DD4
	.byte 0xD8, 0x6A, 0x5B, 0x47, 0x99, 0x51, 0x64, 0x32, 0x41, 0x7B, 0xEF, 0x49, 0x98, 0x51, 0xD7, 0x1C	; 02330DE4
P1_Data_02330DF4:
	.byte 0xC0, 0x01, 0x01, 0x04, 0x00, 0x00, 0x00, 0x00	; 02330DF4
P1_Data_02330DFC:
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00	; 02330DFC
	.byte 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 02330E04
P1_Data_02330E0C:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P1_IrqHandlers:
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 0
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 1
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 2
	.word P1_IrqHandler_0232AC5C + 1	; IRQ 3
	.word P1_IrqHandler_0232AC50 + 1	; IRQ 4
	.word P1_IrqHandler_0232AC44 + 1	; IRQ 5
	.word P1_IrqHandler_0232AC38 + 1	; IRQ 6
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 7
	.word P1_IrqHandler_0232AC8C + 1	; IRQ 8
	.word P1_IrqHandler_0232AC80 + 1	; IRQ 9
	.word P1_IrqHandler_0232AC74 + 1	; IRQ 10
	.word P1_IrqHandler_0232AC68 + 1	; IRQ 11
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 12
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 13
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 14
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 15
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 16
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 17
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 18
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 19
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 20
	.word P1_IrqHandler_0232ACF8 + 1	; IRQ 21
P1_IrqHandlersEnd:
P1_Data_02330E64:
	.byte 0xFF, 0xFF, 0xFF, 0xFF	; 02330E64
P1_Data_02330E68:
	.byte 0x01, 0x00, 0x00, 0x00	; 02330E68
P1_Data_02330E6C:
	.byte 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330E6C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330E74
; CRT 复制后，此保存区复用为主 BSS；下游偏移仍保留原内存布局。
; After CRT copying, reuse this load area as BSS; keep the original field offsets.
P1_BssStart:
; 异常对象位于已由 CRT 清零的主 BSS，不是固定硬件地址。
; Exception objects live in CRT-cleared BSS, not fixed hardware slots.
.definelabel P1_UserExceptionHandler, P1_BssStart + 0x265C8
.definelabel P1_UserExceptionArgument, P1_BssStart + 0x265CC
.definelabel P1_PreviousExceptionHandler, P1_BssStart + 0x265D0
.definelabel P1_ExceptionContext, P1_BssStart + 0x265D4

; 按运行地址汇编；物理字节仍保留在组件的初始化数据区。
; Assemble at the copied execution address; keep bytes in the load image.
P1_ItcmLoadStart:
.headersize 0x01FF8000 - orga()
P1_ItcmRuntimeStart:
.definelabel P1_ExceptionStackTop, P1_ItcmRuntimeStart + 0x8000
	.byte 0x02, 0x69, 0xA0, 0xE3, 0x03, 0x74, 0xA0, 0xE3, 0x68, 0x00, 0x9F, 0xE5, 0x09, 0x10, 0xA0, 0xE3	; 01FF8000
	.byte 0xB0, 0x10, 0xC0, 0xE1, 0xB0, 0x10, 0xD0, 0xE1, 0x09, 0x10, 0x51, 0xE2, 0xF9, 0xFF, 0xFF, 0x1A	; 01FF8010
P1_Runtime_01FF8020:
.thumb
	push {r4}	; 01FF8020
	sub sp,#0x4	; 01FF8022
	ldr r2,[pool_01FF8074]	; 01FF8024
	ldrb r0,[r2,#0x5]	; 01FF8026
	lsl r0,r0,#0x1f	; 01FF8028
	lsr r0,r0,#0x1f	; 01FF802A
	cmp r0,#0x0	; 01FF802C
	beq P1_Runtime_01FF806C	; 01FF802E
	ldrh r0,[r2,#0x0]	; 01FF8030
	cmp r0,#0x0	; 01FF8032
	bne P1_Runtime_01FF806C	; 01FF8034
	ldrh r1,[r2,#0x6]	; 01FF8036
	ldr r0,[pool_01FF8078]	; 01FF8038
	cmp r1,r0	; 01FF803A
	bne P1_Runtime_01FF806C	; 01FF803C
	ldr r0,[r2,#0x8]	; 01FF803E
	cmp r0,#0x0	; 01FF8040
	bne P1_Runtime_01FF806C	; 01FF8042
	mov r4,#0x0	; 01FF8044
	ldr r3,[pool_01FF807C]	; 01FF8046
	ldr r2,[pool_01FF8080]	; 01FF8048
P1_Runtime_01FF804A:
	ldrh r1,[r2,#0x0]	; 01FF804A
	ldrh r0,[r3,#0x0]	; 01FF804C
	cmp r1,r0	; 01FF804E
	beq P1_Runtime_01FF805A	; 01FF8050
	mov r0,#0x0	; 01FF8052
	add sp,#0x4	; 01FF8054
	pop {r4}	; 01FF8056
	bx lr	; 01FF8058
P1_Runtime_01FF805A:
	add r3,r3,#0x2	; 01FF805A
	add r2,r2,#0x2	; 01FF805C
	add r4,r4,#0x1	; 01FF805E
	cmp r4,#0x10	; 01FF8060
	bcc P1_Runtime_01FF804A	; 01FF8062
	mov r0,#0x1	; 01FF8064
	add sp,#0x4	; 01FF8066
	pop {r4}	; 01FF8068
	bx lr	; 01FF806A
P1_Runtime_01FF806C:
	mov r0,#0x0	; 01FF806C
	add sp,#0x4	; 01FF806E
	pop {r4}	; 01FF8070
	bx lr	; 01FF8072
pool_01FF8074:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 01FF8074
pool_01FF8078:
	.word 0x00003130	; 01FF8078
pool_01FF807C:
	.word 0x08000180	; 01FF807C
pool_01FF8080:
	.word P1_ItcmRuntimeStart	; 01FF8080
P1_Runtime_01FF8084:
	push {r4,r5,r6,r7,lr}	; 01FF8084
	sub sp,#0xc	; 01FF8086
	blx loc_0232AE50	; 01FF8088
	lsl r0,r0,#0x10	; 01FF808C
	lsr r0,r0,#0x10	; 01FF808E
	str r0,[sp,#0x0]	; 01FF8090
	bl loc_0232AFA8	; 01FF8092
	bl P1_Runtime_01FF8020	; 01FF8096
	cmp r0,#0x0	; 01FF809A
	beq P1_Runtime_01FF810A	; 01FF809C
	blx P1_Arm9DisableIrqReturnPriorMask	; 01FF809E
	str r0,[sp,#0x4]	; 01FF80A2
	mov r0,#0x1	; 01FF80A4
	bl P1_SwiWaitByLoop	; 01FF80A6
	mov r5,#0x0	; 01FF80AA
	mov r7,#0xb	; 01FF80AC
	ldr r6,[pool_01FF8120]	; 01FF80AE
	add r4,r5,#0x0	; 01FF80B0
P1_Runtime_01FF80B2:
	strh r7,[r6,#0x0]	; 01FF80B2
	mov r0,#0x1	; 01FF80B4
	bl P1_SwiWaitByLoop	; 01FF80B6
	ldrsh r0,[r6,r4]	; 01FF80BA
	cmp r0,#0xb	; 01FF80BC
	beq P1_Runtime_01FF80C6	; 01FF80BE
	add r5,r5,#0x1	; 01FF80C0
	cmp r5,#0x19	; 01FF80C2
	blt P1_Runtime_01FF80B2	; 01FF80C4
P1_Runtime_01FF80C6:
	mov r5,#0x0	; 01FF80C6
	ldr r7,[pool_01FF8120]	; 01FF80C8
	add r4,r5,#0x0	; 01FF80CA
	ldr r6,[pool_01FF8124]	; 01FF80CC
P1_Runtime_01FF80CE:
	mov r0,#0x1	; 01FF80CE
	bl P1_SwiWaitByLoop	; 01FF80D0
	ldrsh r0,[r7,r4]	; 01FF80D4
	and r0,r6	; 01FF80D6
	cmp r0,r6	; 01FF80D8
	beq P1_Runtime_01FF80E2	; 01FF80DA
	add r5,r5,#0x1	; 01FF80DC
	cmp r5,#0x19	; 01FF80DE
	blt P1_Runtime_01FF80CE	; 01FF80E0
P1_Runtime_01FF80E2:
	ldr r1,[pool_01FF8128]	; 01FF80E2
	ldr r0,[pool_01FF812C]	; 01FF80E4
	strh r1,[r0,#0x0]	; 01FF80E6
	mov r5,#0x0	; 01FF80E8
	mov r6,#0x1	; 01FF80EA
	ldr r7,[pool_01FF8120]	; 01FF80EC
	add r4,r5,#0x0	; 01FF80EE
P1_Runtime_01FF80F0:
	add r0,r6,#0x0	; 01FF80F0
	bl P1_SwiWaitByLoop	; 01FF80F2
	ldrsh r0,[r7,r4]	; 01FF80F6
	and r0,r6	; 01FF80F8
	cmp r0,#0x0	; 01FF80FA
	beq P1_Runtime_01FF8104	; 01FF80FC
	add r5,r5,#0x1	; 01FF80FE
	cmp r5,#0x19	; 01FF8100
	blt P1_Runtime_01FF80F0	; 01FF8102
P1_Runtime_01FF8104:
	ldr r0,[sp,#0x4]	; 01FF8104
	blx P1_Arm9RestoreIrqMask	; 01FF8106
P1_Runtime_01FF810A:
	ldr r0,[sp,#0x0]	; 01FF810A
	bl loc_0232AE40	; 01FF810C
	ldr r0,[sp,#0x0]	; 01FF8110
	blx loc_0232AEA8	; 01FF8112
	add sp,#0xc	; 01FF8116
	pop {r4,r5,r6,r7}	; 01FF8118
	pop {r3}	; 01FF811A
	bx r3	; 01FF811C
	.byte 0xC0, 0x46	; 01FF811E
pool_01FF8120:
	.word 0x08010420	; 01FF8120
pool_01FF8124:
	.word 0x00004000	; 01FF8124
pool_01FF8128:
	.word 0x00000400	; 01FF8128
pool_01FF812C:
	.word 0x0801040A	; 01FF812C

; 按 IE/IF 选择并应答 IRQ，再调用对应回调。
; Select and acknowledge an enabled IRQ, then dispatch its callback.
.func P1_DispatchIrq
.arm
	stmdb sp!,{lr}	; 01FF8130
	mov r12,#0x4000000	; 01FF8134
	add r12,r12,#0x210	; 01FF8138
	ldr r1,[r12,#-0x8]	; 01FF813C
	cmp r1,#0x0	; 01FF8140
	ldmeqia sp!,{pc}	; 01FF8144
	ldmia r12,{r1,r2}	; 01FF8148
	ands r1,r1,r2	; 01FF814C
	ldmeqia sp!,{pc}	; 01FF8150
	mov r3,#0x80000000	; 01FF8154
P1_Runtime_01FF8158:
	clz r0,r1	; 01FF8158
	bics r1,r1,r3, lsr r0	; 01FF815C
	bne P1_Runtime_01FF8158	; 01FF8160
	mov r1,r3, lsr r0	; 01FF8164
	str r1,[r12,#0x4]	; 01FF8168
	rsbs r0,r0,#0x1f	; 01FF816C
	ldr r1,[pool_01FF8180]	; 01FF8170
	ldr r0,[r1,r0,lsl #0x2]	; 01FF8174
	ldr lr,[pool_01FF8184]	; 01FF8178
	bx r0	; 01FF817C
.endfunc
pool_01FF8180:
	.word P1_IrqHandlers	; 01FF8180
pool_01FF8184:
	.word P1_IrqReturnContinuation	; 01FF8184
; 中断回调返回后处理待执行状态，必要时保存并切换执行上下文。
; After the IRQ callback, process pending state and save/switch context when needed.
.func P1_IrqReturnContinuation
	ldr r12,[pool_01FF82CC]	; 01FF8188
	ldrh r3,[r12,#0x0]	; 01FF818C
	mov r0,#0x0	; 01FF8190
	cmp r3,#0x0	; 01FF8194
	beq P1_Entry_01FF81D0	; 01FF8198
	strh r0,[r12,#0x0]	; 01FF819C
	ldr r12,[pool_01FF82D0]	; 01FF81A0
	mov r1,#0x1	; 01FF81A4
	strh r1,[r12,#0x0]	; 01FF81A8
	ldr r12,[r12,#0xc]	; 01FF81AC
	mov r2,#0x1	; 01FF81B0
P1_Entry_01FF81B4:
	cmp r12,#0x0	; 01FF81B4
	beq P1_Entry_01FF81D0	; 01FF81B8
	ldr r0,[r12,#0x6c]	; 01FF81BC
	tst r3,r1, lsl r0	; 01FF81C0
	strne r2,[r12,#0x64]	; 01FF81C4
	ldr r12,[r12,#0x68]	; 01FF81C8
	b P1_Entry_01FF81B4	; 01FF81CC
P1_Entry_01FF81D0:
	ldr r12,[pool_01FF82D0]	; 01FF81D0
	ldrh r1,[r12,#0x0]	; 01FF81D4
	cmp r1,#0x0	; 01FF81D8
	ldreq pc,[sp],#0x4	; 01FF81DC
	mov r1,#0x0	; 01FF81E0
	strh r1,[r12,#0x0]	; 01FF81E4
	mov r3,#0xd2	; 01FF81E8
	msr cpsr_c,r3	; 01FF81EC
	add r2,r12,#0xc	; 01FF81F0
	ldr r1,[r2,#0x0]	; 01FF81F4
P1_Entry_01FF81F8:
	cmp r1,#0x0	; 01FF81F8
	ldrneh r0,[r1,#0x64]	; 01FF81FC
	cmpne r0,#0x1	; 01FF8200
	ldrne r1,[r1,#0x68]	; 01FF8204
	bne P1_Entry_01FF81F8	; 01FF8208
	cmp r1,#0x0	; 01FF820C
	bne P1_Entry_01FF8220	; 01FF8210
P1_Entry_01FF8214:
	mov r3,#0x92	; 01FF8214
	msr cpsr_c,r3	; 01FF8218
	ldr pc,[sp],#0x4	; 01FF821C
P1_Entry_01FF8220:
	ldr r0,[r12,#0x8]	; 01FF8220
	cmp r1,r0	; 01FF8224
	beq P1_Entry_01FF8214	; 01FF8228
	ldr r3,[r12,#0x10]	; 01FF822C
	cmp r3,#0x0	; 01FF8230
	beq P1_Entry_01FF8248	; 01FF8234
	stmdb sp!,{r0,r1,r12}	; 01FF8238
	mov lr,pc	; 01FF823C
	bx r3	; 01FF8240
	ldmia sp!,{r0,r1,r12}	; 01FF8244
P1_Entry_01FF8248:
	str r1,[r12,#0x8]	; 01FF8248
	mrs r2,spsr	; 01FF824C
	str r2,[r0,#0x0]!	; 01FF8250
	stmdb sp!,{r0,r1}	; 01FF8254
	add r0,r0,#0x0	; 01FF8258
	add r0,r0,#0x48	; 01FF825C
	ldr r1,[pool_01FF82D4]	; 01FF8260
	blx r1	; 01FF8264
	ldmia sp!,{r0,r1}	; 01FF8268
	ldmib sp!,{r2,r3}	; 01FF826C
	stmib r0!,{r2,r3}	; 01FF8270
	ldmib sp!,{r2,r3,r12,lr}	; 01FF8274
	stmib r0!,{r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 01FF8278
	stmib r0!,{lr}	; 01FF827C
	mov r3,#0xd3	; 01FF8280
	msr cpsr_c,r3	; 01FF8284
	stmib r0!,{sp}	; 01FF8288
	stmdb sp!,{r1}	; 01FF828C
	add r0,r1,#0x0	; 01FF8290
	add r0,r0,#0x48	; 01FF8294
	ldr r1,[pool_01FF82D8]	; 01FF8298
	blx r1	; 01FF829C
	ldmia sp!,{r1}	; 01FF82A0
	ldr sp,[r1,#0x44]	; 01FF82A4
	mov r3,#0xd2	; 01FF82A8
	msr cpsr_c,r3	; 01FF82AC
	ldr r2,[r1,#0x0]!	; 01FF82B0
	msr spsr_cf,r2	; 01FF82B4
	ldr lr,[r1,#0x40]	; 01FF82B8
	ldmib r1!,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 01FF82BC
	mov r0,r0	; 01FF82C0
	stmda sp!,{r0,r1,r2,r3,r12,lr}	; 01FF82C4
	ldmia sp!,{pc}	; 01FF82C8
.endfunc
pool_01FF82CC:
	.word P1_DtcmRuntimeStart	; 01FF82CC
pool_01FF82D0:
	.word P1_BssStart + 0x26380	; 01FF82D0
pool_01FF82D4:
	.word loc_0232EF98 + 1	; 01FF82D4
pool_01FF82D8:
	.word loc_0232EF58 + 1	; 01FF82D8

; 写入所选 DMA 通道的源、目的和控制寄存器。
; Set source, destination and control registers for the selected DMA channel.
.func P1_SetDmaChannelRegisters
.thumb
	push {r4,r5,r6,r7,lr}	; 01FF82DC
	sub sp,#0x4	; 01FF82DE
	add r5,r0,#0x0	; 01FF82E0
	add r4,r1,#0x0	; 01FF82E2
	add r6,r2,#0x0	; 01FF82E4
	add r7,r3,#0x0	; 01FF82E6
	blx P1_Arm9DisableIrqReturnPriorMask	; 01FF82E8
	mov r1,#0xc	; 01FF82EC
	mul r5,r1	; 01FF82EE
	ldr r2,[pool_01FF830C]	; 01FF82F0
	add r1,r5,r2	; 01FF82F2
	str r4,[r1,#0x0]	; 01FF82F4
	str r6,[r1,#0x4]	; 01FF82F6
	str r7,[r1,#0x8]	; 01FF82F8
	ldr r1,[r2,#0x0]	; 01FF82FA
	ldr r1,[r2,#0x0]	; 01FF82FC
	blx P1_Arm9RestoreIrqMask	; 01FF82FE
	add sp,#0x4	; 01FF8302
	pop {r4,r5,r6,r7}	; 01FF8304
	pop {r3}	; 01FF8306
	bx r3	; 01FF8308
.endfunc
	.byte 0xC0, 0x46	; 01FF830A
pool_01FF830C:
	.word REG_DMA0SAD	; 01FF830C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 01FF8310
P1_ItcmRuntimeEnd:
.definelabel P1_ItcmZeroBytes, 0x0
.definelabel P1_ItcmBssStart, P1_ItcmRuntimeEnd
.definelabel P1_ItcmBssEnd, P1_ItcmBssStart + P1_ItcmZeroBytes
.headersize 0x02320000
P1_ItcmLoadEnd:

; 按运行地址汇编；物理字节仍保留在组件的初始化数据区。
; Assemble at the copied execution address; keep bytes in the load image.
P1_DtcmLoadStart:
.headersize 0x03000000 - orga()
P1_DtcmRuntimeStart:
.definelabel P1_DtcmExceptionVector, P1_DtcmRuntimeStart + 0x3FDC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03000000
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 03000010
P1_DtcmRuntimeEnd:
.definelabel P1_DtcmZeroBytes, 0x0
.definelabel P1_DtcmBssStart, P1_DtcmRuntimeEnd
.definelabel P1_DtcmBssEnd, P1_DtcmBssStart + P1_DtcmZeroBytes
.headersize 0x02320000
P1_DtcmLoadEnd:
P1_CopyDescriptors:
	.word P1_ItcmRuntimeStart, P1_ItcmRuntimeEnd - P1_ItcmRuntimeStart, P1_ItcmZeroBytes
	.word P1_DtcmRuntimeStart, P1_DtcmRuntimeEnd - P1_DtcmRuntimeStart, P1_DtcmZeroBytes
P1_CopyDescriptorsEnd:
	.byte 0x21, 0x06, 0xC0, 0xDE, 0x90, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 023311D8
.thumb
.close
