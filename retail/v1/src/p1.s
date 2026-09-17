; official_v1_p1
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
	bl loc_0232CD44	; 02320074
	bl loc_0232C570	; 02320078
	blx loc_0232CE04	; 0232007C
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
	bl loc_023276C0	; 023200AA
	bl loc_0232B828	; 023200AE
	bl loc_0232BCF8	; 023200B2
	bl loc_0232D130	; 023200B6
	bl loc_0232F3AC	; 023200BA
	ldr r1,[pool_02320214]	; 023200BE
	ldrh r2,[r1,#0x0]	; 023200C0
	ldr r0,[pool_02320218]	; 023200C2
	and r2,r0	; 023200C4
	ldr r0,[pool_0232021C]	; 023200C6
	orr r2,r0	; 023200C8
	strh r2,[r1,#0x0]	; 023200CA
	ldr r0,[pool_02320220]	; 023200CC
	bl loc_0232D440	; 023200CE
	lsl r0,r5,#0	; 023200D2
	str r0,[sp,#0x4]	; 023200D4
	ldr r0,[sp,#0x4]	; 023200D6
	ldr r1,[pool_02320224]	; 023200D8
	ldr r2,[pool_02320228]	; 023200DA
	blx loc_0232E344	; 023200DC
	bl loc_0232D284	; 023200E0
	mov r0,#0xc0	; 023200E4
	str r0,[sp,#0x0]	; 023200E6
	ldr r0,[sp,#0x0]	; 023200E8
	ldr r1,[pool_0232022C]	; 023200EA
	ldr r2,[pool_02320230]	; 023200EC
	blx loc_0232E344	; 023200EE
	lsl r0,r5,#0	; 023200F2
	str r0,[sp,#0x8]	; 023200F4
	ldr r0,[sp,#0x8]	; 023200F6
	ldr r1,[pool_02320234]	; 023200F8
	ldr r2,[pool_02320230]	; 023200FA
	blx loc_0232E344	; 023200FC
	mov r0,#0x1	; 02320100
	ldr r1,[pool_02320238]	; 02320102
	bl loc_0232ADC8	; 02320104
	mov r0,#0x1	; 02320108
	bl loc_0232AD44	; 0232010A
	ldr r1,[pool_0232023C]	; 0232010E
	ldrh r0,[r1,#0x0]	; 02320110
	mov r0,#0x1	; 02320112
	strh r0,[r1,#0x0]	; 02320114
	blx P1_Arm9EnableIrqReturnPriorMask	; 02320116
	mov r0,#0x1	; 0232011A
	bl loc_0232D10C	; 0232011C
	bl loc_02330434	; 02320120
	bl loc_0232758C	; 02320124
	cmp r0,#0x0	; 02320128
	bne loc_02320206	; 0232012A
	bl loc_02327338	; 0232012C
	bl loc_02326828	; 02320130
	bl loc_02326984	; 02320134
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
	bl loc_02326860	; 0232017C
	bl loc_02327338	; 02320180
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
	bl loc_02327284	; 023201A4
	b loc_023201B4	; 023201A8
loc_023201AA:
	bl loc_023272A4	; 023201AA
	b loc_023201B4	; 023201AE
loc_023201B0:
	bl loc_02327294	; 023201B0
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
	bl loc_02327304	; 023201D4
	b loc_02320200	; 023201D8
loc_023201DA:
	bl loc_0232D0D8	; 023201DA
	ldr r2,[pool_02320240]	; 023201DE
	ldr r1,[r2,#0x0]	; 023201E0
	ldr r0,[pool_02320244]	; 023201E2
	and r1,r0	; 023201E4
	str r1,[r2,#0x0]	; 023201E6
	bl loc_023272C4	; 023201E8
	b loc_02320200	; 023201EC
loc_023201EE:
	bl loc_0232D0D8	; 023201EE
	ldr r2,[pool_02320240]	; 023201F2
	ldr r1,[r2,#0x0]	; 023201F4
	ldr r0,[pool_02320244]	; 023201F6
	and r1,r0	; 023201F8
	str r1,[r2,#0x0]	; 023201FA
	bl loc_023272B4	; 023201FC
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
	.word 0x02330510	; 02320210
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
	.word P1_DtcmRuntimeStart	; 02320258
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
	bl loc_023269BC	; 02320298
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
	bl loc_0232C2F4	; 02320388
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
	.word 0x02330F94	; 023203D0
pool_023203D4:
loc_023203D4:
	.word 0x023318FC	; 023203D4
pool_023203D8:
loc_023203D8:
	.word P1_BssStart + 0x1300	; 023203D8
pool_023203DC:
loc_023203DC:
	.word 0x02331910	; 023203DC
pool_023203E0:
loc_023203E0:
	.word P1_BssStart + 0xA80	; 023203E0
pool_023203E4:
loc_023203E4:
	.word P1_BssStart + 0x100	; 023203E4
pool_023203E8:
loc_023203E8:
	.word 0x02330EAC	; 023203E8
pool_023203EC:
loc_023203EC:
	.word 0x023A01CC	; 023203EC
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
	.word 0x023318FC	; 023204FC
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
	bl loc_0232D010	; 02320528
	ldr r0,[pool_02320558]	; 0232052C
	add r1,r5,#0x0	; 0232052E
	bl loc_0232D010	; 02320530
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
	bl loc_0232DBB8	; 023205A4
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
	.word P1_BssStart	; 023205EC
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
	bl loc_0232F758	; 02320782
	b loc_02320796	; 02320786
loc_02320788:
	mov r0,#0x2e	; 02320788
	bl loc_0232365C	; 0232078A
	mov r0,#0x2	; 0232078E
	mov r1,#0x0	; 02320790
	bl loc_0232F758	; 02320792
loc_02320796:
	add sp,#0x4	; 02320796
	pop {r4,r5}	; 02320798
	pop {r3}	; 0232079A
	bx r3	; 0232079C
	.byte 0xC0, 0x46	; 023207A0
pool_023207A0:
loc_023207A0:
	.word P1_BssStart	; 023207A0
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
	bl loc_0232DBB8	; 02320852
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
	bl loc_0232DBB8	; 02320910
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
	.word 0x02330FE0	; 02320940
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
	.word 0x02330FE0	; 02320A8C
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
	.word 0x02330FE0	; 02320AE8
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
	.word 0x02331938	; 02320DA0
pool_02320DA4:
loc_02320DA4:
	.word 0x023BB858	; 02320DA4
pool_02320DA8:
loc_02320DA8:
	.word 0x0239F76C	; 02320DA8
pool_02320DAC:
loc_02320DAC:
	.word P1_BssStart + 0x1300	; 02320DAC
pool_02320DB0:
loc_02320DB0:
	.word 0x023CE19C	; 02320DB0
pool_02320DB4:
loc_02320DB4:
	.word P1_BssStart + 0xB00	; 02320DB4
pool_02320DB8:
loc_02320DB8:
	.word 0x02330FE0	; 02320DB8
pool_02320DBC:
loc_02320DBC:
	.word 0x02330FA4	; 02320DBC
pool_02320DC0:
loc_02320DC0:
	.word 0x00001000	; 02320DC0
pool_02320DC4:
loc_02320DC4:
	.word 0x0239F6C4	; 02320DC4
pool_02320DC8:
loc_02320DC8:
	.word P1_Data_0233052C	; 02320DC8
pool_02320DCC:
loc_02320DCC:
	.word P1_BssStart	; 02320DCC
pool_02320DD0:
loc_02320DD0:
	.word 0x02330F94	; 02320DD0
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
	.word P1_Data_02330524	; 02320DE0
pool_02320DE4:
loc_02320DE4:
	.word P1_Data_0233051C	; 02320DE4

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
	blx loc_0232E344	; 02320DFE
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
	bl loc_023269A0	; 02320E4E
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
	bl loc_0232D0D8	; 02320E7C
	ldr r2,[pool_023211E4]	; 02320E80
	ldr r1,[r2,#0x0]	; 02320E82
	ldr r0,[pool_023211E8]	; 02320E84
	and r1,r0	; 02320E86
	str r1,[r2,#0x0]	; 02320E88
	ldr r0,[pool_023211EC]	; 02320E8A
	bl loc_0232D440	; 02320E8C
	mov r0,#0x0	; 02320E90
	str r0,[sp,#0xc]	; 02320E92
	ldr r0,[sp,#0xc]	; 02320E94
	ldr r1,[pool_023211F0]	; 02320E96
	ldr r2,[pool_023211F4]	; 02320E98
	blx loc_0232E344	; 02320E9A
	bl loc_0232D284	; 02320E9E
	mov r0,#0xc0	; 02320EA2
	str r0,[sp,#0x4]	; 02320EA4
	ldr r0,[sp,#0x4]	; 02320EA6
	ldr r1,[pool_023211F8]	; 02320EA8
	ldr r2,[pool_023211FC]	; 02320EAA
	blx loc_0232E344	; 02320EAC
	mov r0,#0x0	; 02320EB0
	str r0,[sp,#0x10]	; 02320EB2
	ldr r0,[sp,#0x10]	; 02320EB4
	ldr r1,[pool_02321200]	; 02320EB6
	ldr r2,[pool_023211FC]	; 02320EB8
	blx loc_0232E344	; 02320EBA
	mov r0,#0x1	; 02320EBE
	bl loc_0232D528	; 02320EC0
	mov r0,#0x2	; 02320EC4
	bl loc_0232D454	; 02320EC6
	mov r0,#0x1	; 02320ECA
	mov r1,#0x0	; 02320ECC
	add r2,r1,#0x0	; 02320ECE
	bl loc_0232D04C	; 02320ED0
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
	bl loc_0232DD18	; 02320F06
	ldr r1,[pool_02321220]	; 02320F0A
	ldr r0,[pool_02321224]	; 02320F0C
	sub r7,r1,r0	; 02320F0E
	mov r1,#0x0	; 02320F10
	add r2,r7,#0x0	; 02320F12
	bl loc_0232E184	; 02320F14
	ldr r0,[pool_02321228]	; 02320F18
	mov r1,#0x0	; 02320F1A
	ldr r2,[pool_0232122C]	; 02320F1C
	sub r2,r2,r0	; 02320F1E
	bl loc_0232DF18	; 02320F20
	ldr r0,[pool_02321230]	; 02320F24
	mov r1,#0x0	; 02320F26
	ldr r2,[pool_02321234]	; 02320F28
	sub r2,r2,r0	; 02320F2A
	bl loc_0232E10C	; 02320F2C
	ldr r0,[pool_02321238]	; 02320F30
	mov r1,#0x0	; 02320F32
	mov r2,#0x2	; 02320F34
	bl loc_0232E184	; 02320F36
	mov r0,#0x4	; 02320F3A
	bl loc_0232D3D4	; 02320F3C
	mov r0,#0x8	; 02320F40
	bl loc_0232D384	; 02320F42
	mov r0,#0x0	; 02320F46
	bl loc_0232D038	; 02320F48
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
	bl loc_0232DCD8	; 02320FCC
	mov r4,#0x0	; 02320FD0
	ldr r6,[pool_0232126C]	; 02320FD2
loc_02320FD4:
	lsl r5,r4,#0x6	; 02320FD4
	lsl r0,r4,#0x7	; 02320FD6
	add r0,r6,r0	; 02320FD8
	add r1,r5,#0x0	; 02320FDA
	mov r2,#0x40	; 02320FDC
	bl loc_0232DED8	; 02320FDE
	lsl r0,r4,#0x1	; 02320FE2
	add r0,r0,#0x1	; 02320FE4
	lsl r0,r0,#0x6	; 02320FE6
	add r0,r6,r0	; 02320FE8
	ldr r1,[pool_02321270]	; 02320FEA
	add r1,r5,r1	; 02320FEC
	mov r2,#0x40	; 02320FEE
	bl loc_0232DED8	; 02320FF0
	add r4,r4,#0x1	; 02320FF4
	cmp r4,#0x20	; 02320FF6
	blt loc_02320FD4	; 02320FF8
	bl loc_023251B0	; 02320FFA
	ldr r0,[pool_02321274]	; 02320FFE
	ldr r1,[pool_02321278]	; 02321000
	ldr r2,[pool_0232127C]	; 02321002
	sub r2,r2,r0	; 02321004
	blx loc_0232E32C	; 02321006
	ldr r0,[pool_02321280]	; 0232100A
	ldr r1,[pool_02321284]	; 0232100C
	ldr r2,[pool_02321288]	; 0232100E
	sub r2,r2,r0	; 02321010
	blx loc_0232E32C	; 02321012
	ldr r0,[pool_0232128C]	; 02321016
	ldr r1,[pool_02321290]	; 02321018
	ldr r2,[pool_02321294]	; 0232101A
	sub r2,r2,r0	; 0232101C
	blx loc_0232E32C	; 0232101E
	ldr r0,[pool_02321298]	; 02321022
	ldr r1,[pool_0232129C]	; 02321024
	ldr r2,[pool_023212A0]	; 02321026
	sub r2,r2,r0	; 02321028
	blx loc_0232E32C	; 0232102A
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
	bl loc_02328D80	; 0232106A
	add r5,r0,#0x0	; 0232106E
	ldr r0,[pool_023212A8]	; 02321070
	bl loc_02328D80	; 02321072
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
	bl loc_0232CDEC	; 023210DE
	ldr r0,[pool_023212BC]	; 023210E2
	bl loc_02326E54	; 023210E4
	ldr r0,[pool_023212C0]	; 023210E8
	ldr r1,[pool_023212C4]	; 023210EA
	ldr r2,[pool_023212C8]	; 023210EC
	bl loc_0232DFD8	; 023210EE
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
	bl loc_0232C238	; 0232114A
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
	.word P1_BssStart	; 023211BC
pool_023211C0:
loc_023211C0:
	.word 0x0000136C	; 023211C0
pool_023211C4:
loc_023211C4:
	.word 0x02330F94	; 023211C4
pool_023211C8:
loc_023211C8:
	.word 0x02330594	; 023211C8
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
	.word 0x023AA920	; 02321218
pool_0232121C:
loc_0232121C:
	.word 0x023A8D20	; 0232121C
pool_02321220:
loc_02321220:
	.word 0x023B66A0	; 02321220
pool_02321224:
loc_02321224:
	.word 0x023B64A0	; 02321224
pool_02321228:
loc_02321228:
	.word 0x023B24A0	; 02321228
pool_0232122C:
loc_0232122C:
	.word 0x023B2CA0	; 0232122C
pool_02321230:
loc_02321230:
	.word 0x023B74A0	; 02321230
pool_02321234:
loc_02321234:
	.word 0x023B76A0	; 02321234
pool_02321238:
loc_02321238:
	.word 0x023306C4	; 02321238
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
	.word 0x023B4CA0	; 0232126C
pool_02321270:
loc_02321270:
	.word 0x00000800	; 02321270
pool_02321274:
loc_02321274:
	.word 0x023B14A0	; 02321274
pool_02321278:
loc_02321278:
	.word 0x06200000	; 02321278
pool_0232127C:
loc_0232127C:
	.word P5_Data_023B1CA0	; 0232127C
pool_02321280:
loc_02321280:
	.word 0x023B44A0	; 02321280
pool_02321284:
loc_02321284:
	.word 0x06203000	; 02321284
pool_02321288:
loc_02321288:
	.word 0x023B4CA0	; 02321288
pool_0232128C:
loc_0232128C:
	.word 0x023B3CA0	; 0232128C
pool_02321290:
loc_02321290:
	.word 0x06203800	; 02321290
pool_02321294:
loc_02321294:
	.word 0x023B44A0	; 02321294
pool_02321298:
loc_02321298:
	.word P5_Data_023B1CA0	; 02321298
pool_0232129C:
loc_0232129C:
	.word 0x06204800	; 0232129C
pool_023212A0:
loc_023212A0:
	.word 0x023B24A0	; 023212A0
pool_023212A4:
loc_023212A4:
	.word 0x023BB858	; 023212A4
pool_023212A8:
loc_023212A8:
	.word 0x023CE19C	; 023212A8
pool_023212AC:
loc_023212AC:
	.word 0x023CE2F0	; 023212AC
pool_023212B0:
loc_023212B0:
	.word 0x023A01CC	; 023212B0
pool_023212B4:
loc_023212B4:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023212B4
pool_023212B8:
loc_023212B8:
	.word 0x00000102	; 023212B8
pool_023212BC:
loc_023212BC:
	.word 0x02331978	; 023212BC
pool_023212C0:
loc_023212C0:
	.word 0x02331998	; 023212C0
pool_023212C4:
loc_023212C4:
	.word 0x0001FE00	; 023212C4
pool_023212C8:
loc_023212C8:
	.word 0x00000200	; 023212C8
pool_023212CC:
loc_023212CC:
	.word 0x02330EAC	; 023212CC
pool_023212D0:
loc_023212D0:
	.word P1_BssStart + 0x40	; 023212D0
pool_023212D4:
loc_023212D4:
	.word 0x02331938	; 023212D4
pool_023212D8:
loc_023212D8:
	.word 0x023A02A4	; 023212D8
pool_023212DC:
loc_023212DC:
	.word 0x023B6CA0	; 023212DC
loc_023212E0:
	mov r1,#0x0	; 023212E0
	ldr r2,[pool_02321408]	; 023212E2
	sub r2,r2,r0	; 023212E4
	bl loc_0232E0D0	; 023212E6
	ldr r0,[pool_0232140C]	; 023212EA
	mov r1,#0x0	; 023212EC
	add r2,r7,#0x0	; 023212EE
	bl loc_0232E148	; 023212F0
	ldr r0,[pool_02321410]	; 023212F4
	mov r1,#0x0	; 023212F6
	mov r2,#0x2	; 023212F8
	bl loc_0232E148	; 023212FA
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
	bl loc_0232E0D0	; 0232138A
	ldr r0,[pool_02321458]	; 0232138E
	mov r1,#0x0	; 02321390
	add r2,r4,#0x0	; 02321392
	bl loc_0232E148	; 02321394
	ldr r0,[pool_0232145C]	; 02321398
	mov r1,#0x0	; 0232139A
	mov r2,#0x2	; 0232139C
	bl loc_0232E148	; 0232139E
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
	bl loc_0232DBB8	; 023213BC
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
	bl P1_SetLidOpenedCallback	; 023213D8
	mov r0,#0x1	; 023213DC
	ldr r1,[pool_02321480]	; 023213DE
	bl loc_0232ADC8	; 023213E0
	mov r0,#0x1	; 023213E4
	bl loc_0232AD44	; 023213E6
	mov r0,#0x1	; 023213EA
	bl loc_0232D10C	; 023213EC
	bl loc_0232D098	; 023213F0
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
	.word 0x023B6EA0	; 02321408
pool_0232140C:
loc_0232140C:
	.word 0x023B64A0	; 0232140C
pool_02321410:
loc_02321410:
	.word 0x023306C8	; 02321410
pool_02321414:
loc_02321414:
	.word P1_BssStart + 0x100	; 02321414
pool_02321418:
loc_02321418:
	.word P1_BssStart + 0x1300	; 02321418
pool_0232141C:
loc_0232141C:
	.word 0x023A14FC	; 0232141C
pool_02321420:
loc_02321420:
	.word 0x023A00CC	; 02321420
pool_02321424:
loc_02321424:
	.word P1_BssStart + 0xB00	; 02321424
pool_02321428:
loc_02321428:
	.word 0x023A1AFC	; 02321428
pool_0232142C:
loc_0232142C:
	.word 0x023A00EC	; 0232142C
pool_02321430:
loc_02321430:
	.word 0x023A0BFC	; 02321430
pool_02321434:
loc_02321434:
	.word 0x023A009C	; 02321434
pool_02321438:
loc_02321438:
	.word 0x023A0EC8	; 02321438
pool_0232143C:
loc_0232143C:
	.word 0x023A00AC	; 0232143C
pool_02321440:
loc_02321440:
	.word 0x023A11DC	; 02321440
pool_02321444:
loc_02321444:
	.word 0x023A00BC	; 02321444
pool_02321448:
loc_02321448:
	.word 0x023A17E4	; 02321448
pool_0232144C:
loc_0232144C:
	.word 0x023A00DC	; 0232144C
pool_02321450:
loc_02321450:
	.word 0x00000200	; 02321450
pool_02321454:
loc_02321454:
	.word 0x023B74A0	; 02321454
pool_02321458:
loc_02321458:
	.word 0x023B72A0	; 02321458
pool_0232145C:
loc_0232145C:
	.word 0x023306CC	; 0232145C
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
	.word P1_BssStart	; 02321470
pool_02321474:
loc_02321474:
	.word 0x02330FE0	; 02321474
pool_02321478:
loc_02321478:
	.word 0x023318FC	; 02321478
pool_0232147C:
loc_0232147C:
	.word P1_UiOnLidOpened + 1	; 0232147C
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
	.word 0x02331998	; 02321530
pool_02321534:
loc_02321534:
	.word 0x00000220	; 02321534
pool_02321538:
loc_02321538:
	.word 0x02330538	; 02321538
pool_0232153C:
loc_0232153C:
	.word 0x02330550	; 0232153C
pool_02321540:
loc_02321540:
	.word 0x02330544	; 02321540
pool_02321544:
loc_02321544:
	.word P1_BssStart	; 02321544
pool_02321548:
loc_02321548:
	.word 0x00000D58	; 02321548

; ===== function loc_0232154C =====
; 本组件 UI 注册的开盖处理：更新局部状态及 UI 电源标志。
; This UI stage's lid-open handler updates local state and UI power flags.
.func P1_UiOnLidOpened
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
	bl loc_0232F758	; 02321576
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
.endfunc
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
	bl loc_0232E0D0	; 023215C0
	ldr r0,[pool_02321684]	; 023215C4
	ldr r1,[pool_02321688]	; 023215C6
	mov r2,#0x20	; 023215C8
	bl loc_0232E0D0	; 023215CA
	ldr r0,[pool_0232168C]	; 023215CE
	mov r1,#0x0	; 023215D0
	ldr r2,[pool_02321690]	; 023215D2
	sub r2,r2,r0	; 023215D4
	bl loc_0232E148	; 023215D6
	ldr r0,[pool_02321694]	; 023215DA
	mov r1,#0x0	; 023215DC
	mov r2,#0x2	; 023215DE
	bl loc_0232E148	; 023215E0
	ldr r1,[pool_02321698]	; 023215E4
	lsl r0,r4,#0x5	; 023215E6
	add r4,r1,r0	; 023215E8
	add r0,r4,#0x0	; 023215EA
	ldr r1,[pool_0232169C]	; 023215EC
	mov r2,#0x20	; 023215EE
	bl loc_0232E148	; 023215F0
	add r0,r4,#0x0	; 023215F4
	ldr r1,[pool_0232169C]	; 023215F6
	mov r2,#0x20	; 023215F8
	bl loc_0232E0D0	; 023215FA
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
	bl loc_0232E148	; 02321646
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
	.word P1_DtcmRuntimeStart	; 0232166C
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
	.word 0x023B6CA0	; 0232167C
pool_02321680:
loc_02321680:
	.word 0x023B6EA0	; 02321680
pool_02321684:
loc_02321684:
	.word 0x02331B98	; 02321684
pool_02321688:
loc_02321688:
	.word 0x000001C0	; 02321688
pool_0232168C:
loc_0232168C:
	.word 0x023B64A0	; 0232168C
pool_02321690:
loc_02321690:
	.word 0x023B66A0	; 02321690
pool_02321694:
loc_02321694:
	.word 0x023306D0	; 02321694
pool_02321698:
loc_02321698:
	.word 0x023B70A0	; 02321698
pool_0232169C:
loc_0232169C:
	.word 0x000001E0	; 0232169C
pool_023216A0:
loc_023216A0:
	.word 0x023321C4	; 023216A0

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
	.word 0x023305E4	; 02321864
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
	.word P1_Data_0233055C	; 023218E0
pool_023218E4:
loc_023218E4:
	.word 0x023305E4	; 023218E4

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
	bl loc_0232DBB8	; 023218FC
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
	blx loc_0232E2FC	; 023219AE
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
	.word P5_Data_023A8B78	; 02321A18

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
	bl loc_0232CF48	; 02321A58
	str r0,[sp,#0x18]	; 02321A5C
	ldr r1,[r6,#0x64]	; 02321A5E
	ldr r0,[pool_02321AE4]	; 02321A60
	add r0,r1,r0	; 02321A62
	ldr r1,[pool_02321AE8]	; 02321A64
	bl loc_0232CF48	; 02321A66
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
	bl loc_0232CFE0	; 02321ABE
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
	.word P1_Data_0233056C	; 02321AEC
pool_02321AF0:
loc_02321AF0:
	.word 0x023CE2F0	; 02321AF0
pool_02321AF4:
loc_02321AF4:
	.word 0x0239FE7C	; 02321AF4

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
	bl loc_02328D8C	; 02321B10
	add r6,r0,#0x0	; 02321B14
	ldr r0,[pool_02321BD8]	; 02321B16
	ldr r1,[r5,#0x4]	; 02321B18
	bl loc_02328D74	; 02321B1A
	add r4,r0,#0x0	; 02321B1E
	ldr r0,[pool_02321BD8]	; 02321B20
	ldr r1,[r5,#0x4]	; 02321B22
	bl loc_02328DA4	; 02321B24
	str r0,[sp,#0xc]	; 02321B28
	mov r1,sp	; 02321B2A
	sub r1,r1,#0x4	; 02321B2C
	ldr r0,[sp,#0x14]	; 02321B2E
	ldrh r0,[r7,r0]	; 02321B30
	strh r0,[r1,#0x0]	; 02321B32
	ldmia r1!,{r0}	; 02321B34
	ldrb r1,[r4,#0x0]	; 02321B36
	bl loc_02328CA4	; 02321B38
	ldr r1,[sp,#0x0]	; 02321B3C
	add r0,r1,r0	; 02321B3E
	str r0,[sp,#0x0]	; 02321B40
	mov r1,sp	; 02321B42
	sub r1,r1,#0x4	; 02321B44
	ldrh r0,[r5,#0x2]	; 02321B46
	strh r0,[r1,#0x0]	; 02321B48
	ldmia r1!,{r0}	; 02321B4A
	ldrb r1,[r4,#0x1]	; 02321B4C
	bl loc_02328C6C	; 02321B4E
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
	.word 0x0239FE7C	; 02321BD4
pool_02321BD8:
loc_02321BD8:
	.word 0x023CE2F0	; 02321BD8
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
	blx loc_0232CFF4	; 02321CBE
	add r6,r0,#0x0	; 02321CC2
	ldr r0,[sp,#0x0]	; 02321CC4
	ldr r1,[pool_02321CF4]	; 02321CC6
	add r1,r5,r1	; 02321CC8
	blx loc_0232CFF4	; 02321CCA
	add r1,r7,#0x0	; 02321CCE
	blx loc_0232CFF4	; 02321CD0
	ldr r1,[sp,#0x1c]	; 02321CD4
	sub r1,r1,r4	; 02321CD6
	blx loc_0232CFF4	; 02321CD8
	add r4,r0,#0x0	; 02321CDC
	add r0,r5,#0x0	; 02321CDE
	ldr r1,[sp,#0x1c]	; 02321CE0
	blx loc_0232CFF4	; 02321CE2
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
	.word 0x0239F1C8	; 02321D48

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
	bl loc_0232DBB8	; 02321DCA
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
	bl loc_0232DBB8	; 02321E20
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
	.word 0x023321E8	; 02321E78
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
	.word P1_Data_023306FC	; 02321EC4

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
	bl loc_0232E018	; 02321F1A
	add r0,r4,#0x0	; 02321F1E
	ldr r1,[pool_02321F54]	; 02321F20
	mov r2,#0x20	; 02321F22
	bl loc_0232E10C	; 02321F24
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
	.word 0x023322DC	; 02321F44
pool_02321F48:
loc_02321F48:
	.word 0x02332360	; 02321F48
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
	bl loc_0232DB9C	; 02321F7C
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
	bl loc_0232E290	; 02322016
	ldr r0,[pool_023220F8]	; 0232201A
	mov r1,#0x0	; 0232201C
	ldr r2,[pool_023220FC]	; 0232201E
	sub r2,r2,r0	; 02322020
	bl loc_0232DC98	; 02322022
	ldr r0,[pool_02322100]	; 02322026
	mov r1,#0x0	; 02322028
	ldr r2,[pool_02322104]	; 0232202A
	sub r2,r2,r0	; 0232202C
	bl loc_0232E184	; 0232202E
	mov r1,#0x0	; 02322032
	ldr r0,[pool_02322108]	; 02322034
	strh r1,[r0,#0x0]	; 02322036
	mov r1,#0x2	; 02322038
	blx P1_CleanDataCacheRange	; 0232203A
	ldr r0,[pool_02322108]	; 0232203E
	mov r1,#0x0	; 02322040
	mov r2,#0x2	; 02322042
	bl loc_0232E184	; 02322044
	ldr r1,[pool_0232210C]	; 02322048
	lsl r0,r7,#0x5	; 0232204A
	add r5,r1,r0	; 0232204C
	add r0,r5,#0x0	; 0232204E
	ldr r1,[pool_02322110]	; 02322050
	mov r2,#0x20	; 02322052
	bl loc_0232E184	; 02322054
	ldr r0,[pool_02322114]	; 02322058
	mov r1,#0x0	; 0232205A
	ldr r2,[pool_02322118]	; 0232205C
	sub r2,r2,r0	; 0232205E
	bl loc_0232DE98	; 02322060
	ldr r0,[pool_0232211C]	; 02322064
	mov r1,#0x0	; 02322066
	ldr r2,[pool_02322120]	; 02322068
	sub r2,r2,r0	; 0232206A
	bl loc_0232DE18	; 0232206C
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
	bl loc_0232E10C	; 0232209E
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
	.word 0x023A8D20	; 023220F8
pool_023220FC:
loc_023220FC:
	.word 0x023AA920	; 023220FC
pool_02322100:
loc_02322100:
	.word 0x023B64A0	; 02322100
pool_02322104:
loc_02322104:
	.word 0x023B66A0	; 02322104
pool_02322108:
loc_02322108:
	.word P1_BssStart + 0x136C	; 02322108
pool_0232210C:
loc_0232210C:
	.word 0x023B70A0	; 0232210C
pool_02322110:
loc_02322110:
	.word 0x000001E0	; 02322110
pool_02322114:
loc_02322114:
	.word 0x023B2CA0	; 02322114
pool_02322118:
loc_02322118:
	.word 0x023B34A0	; 02322118
pool_0232211C:
loc_0232211C:
	.word 0x023B14A0	; 0232211C
pool_02322120:
loc_02322120:
	.word P5_Data_023B1CA0	; 02322120
pool_02322124:
loc_02322124:
	.word 0x023BB858	; 02322124
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
	.word P1_Data_023306FC	; 02322188
pool_0232218C:
loc_0232218C:
	.word P1_BssStart + 0x1444	; 0232218C
pool_02322190:
loc_02322190:
	.word 0x023322B0	; 02322190
pool_02322194:
loc_02322194:
	.word 0x023A0854	; 02322194
pool_02322198:
loc_02322198:
	.word P1_Data_023306FE	; 02322198
pool_0232219C:
loc_0232219C:
	.word 0x02332334	; 0232219C
pool_023221A0:
loc_023221A0:
	.word P1_Data_02330700	; 023221A0

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
	.word P1_Data_023306FC	; 023221F4
pool_023221F8:
loc_023221F8:
	.word 0x023322B0	; 023221F8
pool_023221FC:
loc_023221FC:
	.word 0x023A0854	; 023221FC
pool_02322200:
loc_02322200:
	.word 0x02332334	; 02322200
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
	bl loc_02328E30	; 02322310
	add r6,r0,#0x0	; 02322314
	bl P3_Entry_02367C18	; 02322316
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
	.word P1_Data_023306FC	; 023223FC
pool_02322400:
loc_02322400:
	.word 0x02330702	; 02322400
pool_02322404:
loc_02322404:
	.word 0x023322B0	; 02322404
pool_02322408:
loc_02322408:
	.word 0x02332334	; 02322408
pool_0232240C:
loc_0232240C:
	.word 0x0239F2A8	; 0232240C
pool_02322410:
loc_02322410:
	.word 0x023BB858	; 02322410
pool_02322414:
loc_02322414:
	.word 0x0239F94C	; 02322414
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
	.word 0x023322B0	; 02322470
pool_02322474:
loc_02322474:
	.word 0x02332334	; 02322474
pool_02322478:
loc_02322478:
	.word 0x023A0854	; 02322478

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
	bl loc_0232DB9C	; 02322560
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
	bl loc_023269BC	; 0232260C
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
	.word 0x023BB858	; 023227C8
pool_023227CC:
loc_023227CC:
	.word 0x0239FF64	; 023227CC
pool_023227D0:
loc_023227D0:
	.word P1_Data_023306D4	; 023227D0

; ===== function loc_023227D4 =====
loc_023227D4:
	push {r4,r5,r6,r7,lr}	; 023227D4
	sub sp,#0xc	; 023227D6
	add r5,r0,#0x0	; 023227D8
	add r4,r1,#0x0	; 023227DA
	add r0,sp,#0x0	; 023227DC
	bl loc_023269BC	; 023227DE
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
	.word 0x023A0B98	; 023228EC

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
	.word 0x023321E8	; 02322958

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
	bl loc_0232DB9C	; 023229A6
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
	.word 0x023321E8	; 023229F0

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
	.word 0x023321F0	; 02322A40
pool_02322A44:
loc_02322A44:
	.word 0x023A0B98	; 02322A44
pool_02322A48:
loc_02322A48:
	.word 0x0233221C	; 02322A48
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
	bl loc_0232E10C	; 02322A60
	bl loc_02321E38	; 02322A64
	add sp,#0x4	; 02322A68
	pop {r3}	; 02322A6A
	bx r3	; 02322A6C
	.byte 0xC0, 0x46	; 02322A70
pool_02322A70:
loc_02322A70:
	.word 0x023B6EA0	; 02322A70
pool_02322A74:
loc_02322A74:
	.word 0x023B70A0	; 02322A74

; ===== function loc_02322A78 =====
loc_02322A78:
	push {r4,r5,lr}	; 02322A78
	sub sp,#0x4c	; 02322A7A
	add r0,sp,#0x40	; 02322A7C
	bl loc_023269BC	; 02322A7E
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
	bl loc_0232CFE0	; 02322AFE
	add r4,r0,#0x0	; 02322B02
	ldr r0,[pool_02322C84]	; 02322B04
	bl loc_0232CFE0	; 02322B06
	add r1,r0,#0x0	; 02322B0A
	add r0,sp,#0x20	; 02322B0C
	add r2,r4,#0x0	; 02322B0E
	bl loc_0232CE34	; 02322B10
	ldr r0,[sp,#0x48]	; 02322B14
	lsl r3,r0,#0x1	; 02322B16
	add r0,sp,#0x10	; 02322B18
	ldr r1,[pool_02322C88]	; 02322B1A
	ldrsh r1,[r1,r3]	; 02322B1C
	ldr r2,[pool_02322C8C]	; 02322B1E
	ldrsh r2,[r2,r3]	; 02322B20
	bl loc_0232CE40	; 02322B22
	add r0,sp,#0x20	; 02322B26
	add r1,sp,#0x10	; 02322B28
	add r2,sp,#0x30	; 02322B2A
	bl loc_0232CE4C	; 02322B2C
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
	bl loc_0232CFE0	; 02322B54
	add r4,r0,#0x0	; 02322B58
	ldr r0,[pool_02322C84]	; 02322B5A
	bl loc_0232CFE0	; 02322B5C
	add r1,r0,#0x0	; 02322B60
	add r0,sp,#0x20	; 02322B62
	add r2,r4,#0x0	; 02322B64
	bl loc_0232CE34	; 02322B66
	ldr r0,[sp,#0x44]	; 02322B6A
	lsl r3,r0,#0x1	; 02322B6C
	add r0,sp,#0x10	; 02322B6E
	ldr r1,[pool_02322C88]	; 02322B70
	ldrsh r1,[r1,r3]	; 02322B72
	ldr r2,[pool_02322C8C]	; 02322B74
	ldrsh r2,[r2,r3]	; 02322B76
	bl loc_0232CE40	; 02322B78
	add r0,sp,#0x20	; 02322B7C
	add r1,sp,#0x10	; 02322B7E
	add r2,sp,#0x30	; 02322B80
	bl loc_0232CE4C	; 02322B82
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
	bl loc_0232CFE0	; 02322BAA
	add r4,r0,#0x0	; 02322BAE
	ldr r0,[pool_02322C84]	; 02322BB0
	bl loc_0232CFE0	; 02322BB2
	add r1,r0,#0x0	; 02322BB6
	add r0,sp,#0x20	; 02322BB8
	add r2,r4,#0x0	; 02322BBA
	bl loc_0232CE34	; 02322BBC
	lsl r3,r5,#0x1	; 02322BC0
	add r0,sp,#0x10	; 02322BC2
	ldr r1,[pool_02322C88]	; 02322BC4
	ldrsh r1,[r1,r3]	; 02322BC6
	ldr r2,[pool_02322C8C]	; 02322BC8
	ldrsh r2,[r2,r3]	; 02322BCA
	bl loc_0232CE40	; 02322BCC
	add r0,sp,#0x20	; 02322BD0
	add r1,sp,#0x10	; 02322BD2
	add r2,sp,#0x30	; 02322BD4
	bl loc_0232CE4C	; 02322BD6
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
	bl loc_0232CFE0	; 02322C1A
	add r4,r0,#0x0	; 02322C1E
	ldr r0,[pool_02322C84]	; 02322C20
	bl loc_0232CFE0	; 02322C22
	add r1,r0,#0x0	; 02322C26
	add r0,sp,#0x20	; 02322C28
	add r2,r4,#0x0	; 02322C2A
	bl loc_0232CE34	; 02322C2C
	lsl r3,r5,#0x1	; 02322C30
	add r0,sp,#0x10	; 02322C32
	ldr r1,[pool_02322C88]	; 02322C34
	ldrsh r1,[r1,r3]	; 02322C36
	ldr r2,[pool_02322C8C]	; 02322C38
	ldrsh r2,[r2,r3]	; 02322C3A
	bl loc_0232CE40	; 02322C3C
	add r0,sp,#0x20	; 02322C40
	add r1,sp,#0x10	; 02322C42
	add r2,sp,#0x30	; 02322C44
	bl loc_0232CE4C	; 02322C46
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
	.word 0x023BB858	; 02322C78
pool_02322C7C:
loc_02322C7C:
	.word 0x0239FEEC	; 02322C7C
pool_02322C80:
loc_02322C80:
	.word 0x00009000	; 02322C80
pool_02322C84:
loc_02322C84:
	.word 0x00001000	; 02322C84
pool_02322C88:
loc_02322C88:
	.word P1_Data_023309A0	; 02322C88
pool_02322C8C:
loc_02322C8C:
	.word P1_Data_02330A18	; 02322C8C
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
	bl loc_02328BE8	; 02322CC6
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
	bl loc_02328BE8	; 02322D04
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
	bl loc_023269BC	; 02322D32
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
	.word 0x023323B8	; 02322D48
loc_02322D4C:
	push {r4,r5,lr}	; 02322D4C
	sub sp,#0x1c	; 02322D4E
	add r5,r0,#0x0	; 02322D50
	add r0,sp,#0xc	; 02322D52
	bl loc_023269A0	; 02322D54
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
	.word 0x023BB858	; 02322DA4
pool_02322DA8:
loc_02322DA8:
	.word 0x0239FEEC	; 02322DA8

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
	.word 0x023B2CA0	; 02322DF8

; ===== function loc_02322DFC =====
loc_02322DFC:
	push {r4,r5,r6,r7,lr}	; 02322DFC
	sub sp,#0x4	; 02322DFE
	add r6,r0,#0x0	; 02322E00
	add r7,r1,#0x0	; 02322E02
	add r5,r2,#0x0	; 02322E04
	mov r2,#0x1	; 02322E06
	bl loc_02326A1C	; 02322E08
	add r4,r0,#0x0	; 02322E0C
	add r0,r6,#0x0	; 02322E0E
	add r1,r7,#0x0	; 02322E10
	mov r2,#0x0	; 02322E12
	bl loc_02326A80	; 02322E14
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
	bl loc_023269A0	; 02322E68
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
	blx loc_0232E344	; 02322E86
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
	bl loc_02328BE8	; 02322EA2
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
	bl loc_02328D5C	; 02322F1C
	add r1,r0,#0x0	; 02322F20
	add r0,sp,#0x38	; 02322F22
	add r2,sp,#0x90	; 02322F24
	bl loc_02328CDC	; 02322F26
	mov r5,#0x0	; 02322F2A
	b loc_02322F76	; 02322F2C
loc_02322F2E:
	ldr r0,[pool_023230A4]	; 02322F2E
	add r1,r5,#0x1	; 02322F30
	bl loc_02328D5C	; 02322F32
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
	bl loc_02328888	; 02322F70
	add r5,r5,#0x1	; 02322F74
loc_02322F76:
	cmp r5,#0x7	; 02322F76
	bcc loc_02322F2E	; 02322F78
	ldr r0,[pool_023230A4]	; 02322F7A
	mov r1,#0x1	; 02322F7C
	bl loc_02328D5C	; 02322F7E
	ldrh r1,[r0,#0x0]	; 02322F82
	add r0,sp,#0x20	; 02322F84
	strh r1,[r0,#0x2]	; 02322F86
	ldrh r1,[r0,#0x2]	; 02322F88
	strh r1,[r0,#0x0]	; 02322F8A
	mov r5,#0x0	; 02322F8C
	ldr r0,[sp,#0x48]	; 02322F8E
	ldr r1,[sp,#0x4c]	; 02322F90
	mov r2,#0x1	; 02322F92
	bl loc_02326A1C	; 02322F94
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
	bl loc_02328888	; 0232304C
	add r5,r5,#0x1	; 02323050
loc_02323052:
	ldr r0,[sp,#0x48]	; 02323052
	ldr r1,[sp,#0x4c]	; 02323054
	ldr r2,[sp,#0x18]	; 02323056
	bl loc_02326A80	; 02323058
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
	.word 0x02330A90	; 02323084
pool_02323088:
loc_02323088:
	.word 0x02330AAC	; 02323088
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
	.word 0x02330AC8	; 02323098
pool_0232309C:
loc_0232309C:
	.word 0x02330AD8	; 0232309C
pool_023230A0:
loc_023230A0:
	.word 0x02330AE8	; 023230A0
pool_023230A4:
loc_023230A4:
	.word 0x023A0AFC	; 023230A4
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
	.word 0x023323C4	; 023230B8
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
	.word 0x023323C4	; 023230C8
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
	.word 0x023323C4	; 023230D8
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
	bl loc_0232F704	; 023231E2
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
	.word 0x023323DC	; 023232AC
pool_023232B0:
loc_023232B0:
	.word 0x02332408	; 023232B0
pool_023232B4:
loc_023232B4:
	.word 0x02332434	; 023232B4
pool_023232B8:
loc_023232B8:
	.word 0x023BB858	; 023232B8
pool_023232BC:
loc_023232BC:
	.word 0x0239FEEC	; 023232BC
pool_023232C0:
loc_023232C0:
	.word P1_Data_02330AF8	; 023232C0
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
	.word 0x02332434	; 0232330C
pool_02323310:
loc_02323310:
	.word 0x023A0AFC	; 02323310
pool_02323314:
loc_02323314:
	.word 0x023323DC	; 02323314
pool_02323318:
loc_02323318:
	.word 0x02332408	; 02323318
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
	.word 0x02332434	; 02323340

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
	bl loc_02328D5C	; 023233D8
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
	bl loc_0232E10C	; 023233F8
loc_023233FC:
	add sp,#0x1c	; 023233FC
	pop {r4,r5}	; 023233FE
	pop {r3}	; 02323400
	bx r3	; 02323402
pool_02323404:
loc_02323404:
	.word 0x02332474	; 02323404
pool_02323408:
loc_02323408:
	.word 0x023A0854	; 02323408
pool_0232340C:
loc_0232340C:
	.word 0x023B70A0	; 0232340C
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
	.word 0x02330AFC	; 02323518
pool_0232351C:
loc_0232351C:
	.word 0x02332474	; 0232351C
pool_02323520:
loc_02323520:
	.word P1_BssStart + 0x1888	; 02323520
pool_02323524:
loc_02323524:
	.word 0x023BB858	; 02323524
pool_02323528:
loc_02323528:
	.word 0x0239F94C	; 02323528

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
	blx loc_0232E3C8	; 023235D2
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
	.word 0x02332474	; 02323610
pool_02323614:
loc_02323614:
	.word 0x023A0854	; 02323614

; ===== function loc_02323618 =====
	push {lr}	; 02323618
	sub sp,#0x4	; 0232361A
	bl loc_02328FE8	; 0232361C
	ldr r0,[pool_02323630]	; 02323620
	ldr r1,[pool_02323634]	; 02323622
	mov r2,#0x1	; 02323624
	bl P1_StartDualBufferProcessor	; 02323626
	add sp,#0x4	; 0232362A
	pop {r3}	; 0232362C
	bx r3	; 0232362E
pool_02323630:
loc_02323630:
	.word 0x023327A0	; 02323630
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
	.word loc_02329E38 + 1	; 02323640

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
	.word loc_0232AA40 + 1	; 02323650
loc_02323654:
	ldr r3,[pool_02323658]	; 02323654
	bx r3	; 02323656
pool_02323658:
loc_02323658:
	.word loc_02329E30 + 1	; 02323658

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
	.word 0x0233270C	; 02323668
pool_0232366C:
loc_0232366C:
	.word loc_0232AA40 + 1	; 0232366C

; ===== function loc_02323670 =====
loc_02323670:
	ldr r3,[pool_02323674]	; 02323670
	bx r3	; 02323672
pool_02323674:
loc_02323674:
	.word loc_02329944 + 1	; 02323674

; ===== function loc_02323678 =====
loc_02323678:
	push {lr}	; 02323678
	sub sp,#0x4	; 0232367A
	bl loc_02329968	; 0232367C
	ldr r0,[pool_023236A4]	; 02323680
	ldr r1,[pool_023236A8]	; 02323682
	mov r2,#0x1	; 02323684
	bl P1_StartDualBufferProcessor	; 02323686
	ldr r0,[pool_023236AC]	; 0232368A
	ldr r1,[pool_023236B0]	; 0232368C
	bl loc_0232A68C	; 0232368E
	mov r0,#0x0	; 02323692
	bl loc_0232AAA8	; 02323694
	ldr r0,[pool_023236B4]	; 02323698
	bl loc_02329E30	; 0232369A
	add sp,#0x4	; 0232369E
	pop {r3}	; 023236A0
	bx r3	; 023236A2
pool_023236A4:
loc_023236A4:
	.word 0x023327A0	; 023236A4
pool_023236A8:
loc_023236A8:
	.word 0x00001000	; 023236A8
pool_023236AC:
loc_023236AC:
	.word 0x02332710	; 023236AC
pool_023236B0:
loc_023236B0:
	.word 0x023A6158	; 023236B0
pool_023236B4:
loc_023236B4:
	.word 0x0233270C	; 023236B4

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
	bl loc_02328D74	; 02323C36
	add r6,r0,#0x0	; 02323C3A
	mov r1,sp	; 02323C3C
	sub r1,r1,#0x4	; 02323C3E
	ldrh r0,[r4,r7]	; 02323C40
	strh r0,[r1,#0x0]	; 02323C42
	ldmia r1!,{r0}	; 02323C44
	ldrb r1,[r6,#0x0]	; 02323C46
	bl loc_02328CA4	; 02323C48
	ldr r1,[sp,#0x30]	; 02323C4C
	add r0,r1,r0	; 02323C4E
	str r0,[sp,#0x30]	; 02323C50
	mov r1,sp	; 02323C52
	sub r1,r1,#0x4	; 02323C54
	ldrh r0,[r5,#0x2]	; 02323C56
	strh r0,[r1,#0x0]	; 02323C58
	ldmia r1!,{r0}	; 02323C5A
	ldrb r1,[r6,#0x1]	; 02323C5C
	bl loc_02328C6C	; 02323C5E
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
	bl loc_02328DA4	; 02323CA6
	str r0,[sp,#0x8]	; 02323CAA
	add r0,r5,#0x0	; 02323CAC
	ldr r1,[sp,#0x34]	; 02323CAE
	bl loc_02328D8C	; 02323CB0
	add r7,r0,#0x0	; 02323CB4
	add r0,r5,#0x0	; 02323CB6
	ldr r1,[sp,#0x34]	; 02323CB8
	bl loc_02328D74	; 02323CBA
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
	.word 0x02333DD0	; 02323DBC

; ===== function loc_02323DC0 =====
loc_02323DC0:
	ldr r0,[pool_02323DC4]	; 02323DC0
	bx lr	; 02323DC2
pool_02323DC4:
loc_02323DC4:
	.word 0x023337A0	; 02323DC4

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
	bl loc_0232E094	; 02323DDA
	ldr r0,[pool_02323DFC]	; 02323DDE
	mov r1,#0x0	; 02323DE0
	ldr r2,[pool_02323DF8]	; 02323DE2
	bl loc_0232E058	; 02323DE4
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
	.word 0x023337A0	; 02323DF4
pool_02323DF8:
loc_02323DF8:
	.word 0x00000400	; 02323DF8
pool_02323DFC:
loc_02323DFC:
	.word 0x02333DD0	; 02323DFC

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
	blx loc_0232E344	; 02323E1A
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
	blx loc_0232E344	; 02323E34
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
	bl loc_0232C3DE	; 02323EA4
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
	.word 0x023337A0	; 02323EB4
pool_02323EB8:
loc_02323EB8:
	.word P1_BssStart + 0x3540	; 02323EB8
pool_02323EBC:
loc_02323EBC:
	.word 0x02333DD0	; 02323EBC
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
	bl loc_02328D84	; 02323F26
	add r6,r0,#0x0	; 02323F2A
	add r0,r4,#0x0	; 02323F2C
	bl loc_02328D80	; 02323F2E
	add r2,r0,#0x0	; 02323F32
	add r0,r6,#0x0	; 02323F34
	ldr r1,[pool_02323F84]	; 02323F36
	ldr r1,[r5,r1]	; 02323F38
	bl loc_0232E018	; 02323F3A
	b loc_02323F5A	; 02323F3E
loc_02323F40:
	add r0,r4,#0x0	; 02323F40
	bl loc_02328D84	; 02323F42
	add r6,r0,#0x0	; 02323F46
	add r0,r4,#0x0	; 02323F48
	bl loc_02328D80	; 02323F4A
	add r2,r0,#0x0	; 02323F4E
	add r0,r6,#0x0	; 02323F50
	ldr r1,[pool_02323F84]	; 02323F52
	ldr r1,[r5,r1]	; 02323F54
	bl loc_0232DFD8	; 02323F56
loc_02323F5A:
	add r0,r4,#0x0	; 02323F5A
	bl loc_02328D80	; 02323F5C
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
	.word 0x023337A0	; 02323F8C

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
	.byte 0x81, 0x80, 0x01, 0x89, 0x91, 0x43, 0x01, 0x81, 0x70, 0x47, 0xC0, 0x46, 0x04, 0x44, 0x33, 0x02	; 02323FEC
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
	.byte 0x02, 0x49, 0x09, 0x89, 0x01, 0x40, 0x08, 0x1C, 0x70, 0x47, 0xC0, 0x46, 0x04, 0x44, 0x33, 0x02	; 02324078

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
	bl loc_0232F290	; 023240E6
	add r0,r4,#0x0	; 023240EA
	bl loc_0232F25C	; 023240EC
	cmp r0,#0x0	; 023240F0
	bne loc_023240E6	; 023240F2
	add r0,sp,#0x8	; 023240F4
	add r1,sp,#0x0	; 023240F6
	bl loc_0232EFE8	; 023240F8
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
	blx loc_0232E344	; 023241BE
	add sp,#0x4	; 023241C2
	pop {r3}	; 023241C4
	bx r3	; 023241C6
pool_023241C8:
loc_023241C8:
	.word 0x02334404	; 023241C8

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
	bl loc_02328DB4	; 023242CE
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
	bl loc_02328DB4	; 02324300
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
	bl loc_02328DB4	; 02324330
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
	.word 0x0233442C	; 023244DC

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
	bl loc_0232DF58	; 0232450E
	b loc_02324536	; 02324512
loc_02324514:
	ldr r0,[pool_0232453C]	; 02324514
	mov r1,#0x0	; 02324516
	ldr r2,[pool_02324540]	; 02324518
	bl loc_0232DED8	; 0232451A
	b loc_02324536	; 0232451E
loc_02324520:
	ldr r0,[pool_0232453C]	; 02324520
	mov r1,#0x0	; 02324522
	ldr r2,[pool_02324540]	; 02324524
	bl loc_0232DE58	; 02324526
	b loc_02324536	; 0232452A
loc_0232452C:
	ldr r0,[pool_0232453C]	; 0232452C
	mov r1,#0x0	; 0232452E
	ldr r2,[pool_02324540]	; 02324530
	bl loc_0232DDD8	; 02324532
loc_02324536:
	add sp,#0x4	; 02324536
	pop {r3}	; 02324538
	bx r3	; 0232453A
pool_0232453C:
loc_0232453C:
	.word 0x0233442C	; 0232453C
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
	blx loc_0232E344	; 02324552
	ldr r0,[pool_02324564]	; 02324556
	ldr r1,[pool_02324568]	; 02324558
	blx P1_CleanDataCacheRange	; 0232455A
	add sp,#0x4	; 0232455E
	pop {r3}	; 02324560
	bx r3	; 02324562
pool_02324564:
loc_02324564:
	.word 0x0233442C	; 02324564
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
	bl loc_02328D5C	; 02324594
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
	bl loc_02328D5C	; 023245F2
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
	bl loc_02329234	; 02324618
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
	.word P1_Data_02330B08	; 023246B8
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
	bl loc_02328D5C	; 023246F2
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
	blx loc_0232E344	; 0232470E
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
	bl loc_02328BE8	; 0232472A
	ldr r0,[sp,#0x10]	; 0232472E
	ldr r1,[sp,#0x14]	; 02324730
	bl loc_02328D5C	; 02324732
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
	bl loc_02328888	; 023247CC
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
	bl loc_02328D5C	; 023247F4
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
	bl loc_023287D8	; 0232480E
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
	bl loc_023287B8	; 02324828
	str r0,[r6,#0x0]	; 0232482C
	mov r1,sp	; 0232482E
	sub r1,r1,#0x4	; 02324830
	ldrh r0,[r4,#0x0]	; 02324832
	strh r0,[r1,#0x0]	; 02324834
	ldmia r1!,{r0}	; 02324836
	ldr r1,[r5,#0x0]	; 02324838
	bl loc_02328CA4	; 0232483A
	str r0,[r7,#0x0]	; 0232483E
	mov r1,sp	; 02324840
	sub r1,r1,#0x4	; 02324842
	ldrh r0,[r4,#0x2]	; 02324844
	strh r0,[r1,#0x0]	; 02324846
	ldmia r1!,{r0}	; 02324848
	ldr r1,[r6,#0x0]	; 0232484A
	bl loc_02328C6C	; 0232484C
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
	bl loc_02329164	; 023249DA
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
	bl loc_0232E018	; 02324A36
	b loc_02324A48	; 02324A3A
loc_02324A3C:
	ldr r0,[r1,#0x14]	; 02324A3C
	add r0,r0,r4	; 02324A3E
	add r1,r6,#0x0	; 02324A40
	add r2,r7,#0x0	; 02324A42
	bl loc_0232DFD8	; 02324A44
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
	bl loc_0232928C	; 02324B72
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
	blx loc_0232E344	; 02324B94
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
	.word 0x02344A5C	; 02324BBC
pool_02324BC0:
loc_02324BC0:
	.word 0x02334A44	; 02324BC0

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
	.word 0x02334A5C	; 02324BD4

; ===== function loc_02324BD8 =====
loc_02324BD8:
	ldr r0,[pool_02324BDC]	; 02324BD8
	bx lr	; 02324BDA
pool_02324BDC:
loc_02324BDC:
	.word 0x02354A7C	; 02324BDC
P1_Entry_02324BE0:
	ldr r0,[pool_02324BE4]	; 02324BE0
	bx lr	; 02324BE2
pool_02324BE4:
	.word 0x02354A5C	; 02324BE4

; ===== function loc_02324BE8 =====
loc_02324BE8:
	ldr r0,[pool_02324BEC]	; 02324BE8
	bx lr	; 02324BEA
pool_02324BEC:
loc_02324BEC:
	.word 0x02354A5C	; 02324BEC

; ===== function loc_02324BF0 =====
loc_02324BF0:
	push {r4,r5,r6,lr}	; 02324BF0
	ldr r0,[pool_02324C38]	; 02324BF2
	ldr r1,[pool_02324C3C]	; 02324BF4
	ldr r2,[pool_02324C40]	; 02324BF6
	bl loc_02328BF8	; 02324BF8
	ldr r0,[pool_02324C44]	; 02324BFC
	ldr r1,[pool_02324C48]	; 02324BFE
	ldr r2,[pool_02324C4C]	; 02324C00
	bl loc_02328BF8	; 02324C02
	ldr r0,[pool_02324C50]	; 02324C06
	ldr r1,[pool_02324C54]	; 02324C08
	ldr r2,[pool_02324C58]	; 02324C0A
	bl loc_02328BF8	; 02324C0C
	ldr r0,[pool_02324C5C]	; 02324C10
	ldr r1,[pool_02324C60]	; 02324C12
	ldr r2,[pool_02324C64]	; 02324C14
	bl loc_02328BF8	; 02324C16
	mov r5,#0x0	; 02324C1A
	ldr r4,[pool_02324C38]	; 02324C1C
	ldr r6,[pool_02324C68]	; 02324C1E
	b loc_02324C2E	; 02324C20
loc_02324C22:
	lsl r0,r5,#0x5	; 02324C22
	add r0,r4,r0	; 02324C24
	ldrh r1,[r6,#0x0]	; 02324C26
	bl loc_02328784	; 02324C28
	add r5,r5,#0x1	; 02324C2C
loc_02324C2E:
	cmp r5,#0x4	; 02324C2E
	bcc loc_02324C22	; 02324C30
	pop {r4,r5,r6}	; 02324C32
	pop {r3}	; 02324C34
	bx r3	; 02324C36
pool_02324C38:
loc_02324C38:
	.word 0x02354A5C	; 02324C38
pool_02324C3C:
loc_02324C3C:
	.word P5_FontResource2	; 02324C3C
pool_02324C40:
loc_02324C40:
	.word 0x023A1E24	; 02324C40
pool_02324C44:
loc_02324C44:
	.word 0x02354A7C	; 02324C44
pool_02324C48:
loc_02324C48:
	.word P5_FontResource3	; 02324C48
pool_02324C4C:
loc_02324C4C:
	.word 0x023A2000	; 02324C4C
pool_02324C50:
loc_02324C50:
	.word 0x02354A9C	; 02324C50
pool_02324C54:
loc_02324C54:
	.word P5_FontResource1	; 02324C54
pool_02324C58:
loc_02324C58:
	.word 0x023A1DD8	; 02324C58
pool_02324C5C:
loc_02324C5C:
	.word 0x02354ABC	; 02324C5C
pool_02324C60:
loc_02324C60:
	.word P5_FontResource0	; 02324C60
pool_02324C64:
loc_02324C64:
	.word 0x023A1D64	; 02324C64
pool_02324C68:
loc_02324C68:
	.word 0x02330B0C	; 02324C68
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
	.word 0x02354B10	; 02324D0C

; ===== function loc_02324D10 =====
loc_02324D10:
	lsl r1,r0,#0x1	; 02324D10
	ldr r0,[pool_02324D18]	; 02324D12
	ldrh r0,[r0,r1]	; 02324D14
	bx lr	; 02324D16
pool_02324D18:
loc_02324D18:
	.word P1_Data_02330B28	; 02324D18

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
	.word 0x02330B10	; 02324D78
pool_02324D7C:
loc_02324D7C:
	.word 0x02354AE0	; 02324D7C
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
	.byte 0x01, 0x48, 0xC0, 0x69, 0x70, 0x47, 0xC0, 0x46, 0x10, 0x4F, 0x35, 0x02	; 02324DCC
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
	.word 0x02354F70	; 02324DF8
pool_02324DFC:
	.word 0x023A0264	; 02324DFC
pool_02324E00:
	.word 0x02354F9C	; 02324E00
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
	.word 0x02354F38	; 02324EA4
pool_02324EA8:
	.word 0x0239F1FC	; 02324EA8

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
	.word 0x02354F44	; 02324FD4

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
	.word 0x02354F44	; 02324FF4
pool_02324FF8:
loc_02324FF8:
	.word 0x023A0264	; 02324FF8
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
	.word 0x023BB858	; 02325118
pool_0232511C:
loc_0232511C:
	.word 0x0239F73C	; 0232511C
pool_02325120:
loc_02325120:
	.word 0x02354F70	; 02325120
pool_02325124:
loc_02325124:
	.word 0x02354F9C	; 02325124
pool_02325128:
loc_02325128:
	.word 0x02354F38	; 02325128
pool_0232512C:
loc_0232512C:
	.word 0x02354F44	; 0232512C

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
	.word 0x02354F44	; 02325170
pool_02325174:
loc_02325174:
	.word 0x023A0264	; 02325174
pool_02325178:
loc_02325178:
	.word 0x02354F70	; 02325178
pool_0232517C:
loc_0232517C:
	.word 0x02354F9C	; 0232517C

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
	.word 0x02354F38	; 023251A8
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
	blx loc_0232E344	; 023251D0
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
	.word P1_Data_023307F8	; 02325220

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
	.word P1_Data_023307FC	; 02325278
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
	.word P1_Data_023307FC	; 0232529C
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
	.word P1_Data_023307FC	; 023252C0
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
	.word P1_Data_023307FC	; 023252E4

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
	.word 0x02354FE0	; 02325360
pool_02325364:
loc_02325364:
	.word P1_Data_023307FC	; 02325364
pool_02325368:
loc_02325368:
	.word P1_BssStart + 0x24168	; 02325368
pool_0232536C:
loc_0232536C:
	.word 0x02354FD4	; 0232536C
pool_02325370:
loc_02325370:
	.word P1_Data_02330808	; 02325370
pool_02325374:
loc_02325374:
	.word P1_Data_0233080A	; 02325374
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
	.word 0x02354FE0	; 02325448
pool_0232544C:
loc_0232544C:
	.word P1_Data_023307FC	; 0232544C
pool_02325450:
loc_02325450:
	.word 0x023A01AC	; 02325450
pool_02325454:
loc_02325454:
	.word 0x02354FD4	; 02325454
pool_02325458:
loc_02325458:
	.word 0x0239F1B4	; 02325458

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
	.word 0x02354FE0	; 02325508
pool_0232550C:
loc_0232550C:
	.word P1_BssStart + 0x24168	; 0232550C
pool_02325510:
loc_02325510:
	.word 0x02354FD4	; 02325510
pool_02325514:
loc_02325514:
	.word P1_Data_02330804	; 02325514
pool_02325518:
loc_02325518:
	.word 0x023BB858	; 02325518
pool_0232551C:
loc_0232551C:
	.word 0x0239F69C	; 0232551C

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
	.word 0x023A01AC	; 02325564
pool_02325568:
loc_02325568:
	.word P1_Data_02330804	; 02325568

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
	.word 0x02354FE0	; 023255DC
pool_023255E0:
loc_023255E0:
	.word P1_Data_023307FC	; 023255E0
pool_023255E4:
loc_023255E4:
	.word P1_BssStart + 0x24168	; 023255E4
pool_023255E8:
loc_023255E8:
	.word 0x02354FD4	; 023255E8

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
	bl loc_02328BE8	; 02325674
	ldr r0,[pool_0232568C]	; 02325678
	add r1,r5,#0x0	; 0232567A
	bl loc_02328D24	; 0232567C
	add sp,#0x8	; 02325680
	pop {r4,r5,r6}	; 02325682
	pop {r3}	; 02325684
	bx r3	; 02325686
pool_02325688:
loc_02325688:
	.word 0x00000300	; 02325688
pool_0232568C:
loc_0232568C:
	.word 0x02355060	; 0232568C
pool_02325690:
loc_02325690:
	.word 0x00000100	; 02325690

; ===== function loc_02325694 =====
loc_02325694:
	ldr r0,[pool_02325698]	; 02325694
	bx lr	; 02325696
pool_02325698:
loc_02325698:
	.word 0x02355070	; 02325698

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
	bl loc_0232C3DE	; 02325752
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
	.word P1_Data_02330814	; 0232597C

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
	.word P1_Data_02330814	; 023259BC

; ===== function loc_023259C0 =====
loc_023259C0:
	push {r4,r5,r6,r7,lr}	; 023259C0
	sub sp,#0x1fc	; 023259C2
	sub sp,#0x10	; 023259C4
	add r5,r0,#0x0	; 023259C6
	mov r4,#0x0	; 023259C8
	add r0,sp,#0x8	; 023259CA
	ldr r1,[pool_02325A2C]	; 023259CC
	bl loc_0232CDEC	; 023259CE
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
	bl loc_0232DBB8	; 02325A50
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
	bl loc_0232DBB8	; 02325ADA
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
	bl loc_023268A8	; 02325B2C
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
	bl loc_0232DBB8	; 02325B9C
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
	bl loc_023268A8	; 02325C44
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
	bl loc_023268A8	; 02325C90
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
	bl loc_023268A8	; 02325CD6
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
	bl loc_023268C0	; 02325D1A
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
	.word 0x023A02A4	; 02325D2C

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
	bl loc_023268C0	; 02325DCA
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
	.word 0x023A02A4	; 02325DDC

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
	bl loc_0232DBB8	; 02325DFE
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
	bl loc_0232DBB8	; 02325E9C
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
	bl loc_02326880	; 02325F26
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
	bl loc_02326890	; 02325F4A
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
	bl loc_0232C360	; 02325F9A
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
	.word 0x023A02A4	; 02325FD8

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
	bl loc_0232CDEC	; 02326028
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
	bl loc_0232F758	; 0232610E
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
	bl loc_0232F758	; 0232614C
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
	.word 0x02330C70	; 02326220
pool_02326224:
loc_02326224:
	.word 0x02330C7C	; 02326224
pool_02326228:
loc_02326228:
	.word 0x02330C8C	; 02326228

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
	.word 0x02330C98	; 02326280
pool_02326284:
loc_02326284:
	.word 0x02330CB0	; 02326284
pool_02326288:
loc_02326288:
	.word 0x02330CC8	; 02326288
pool_0232628C:
loc_0232628C:
	.word 0x02330CE0	; 0232628C

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
	bl loc_023269A0	; 0232631C
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
	bl loc_023269A0	; 02326344
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
	bl loc_023269BC	; 0232636C
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
	.byte 0x07, 0xF0, 0xA4, 0xEF, 0x00, 0x22, 0x04, 0x48, 0x34, 0x30, 0x00, 0x78, 0x41, 0x00, 0x03, 0x48	; 023263B0
	.byte 0x42, 0x52, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x9C, 0xFC, 0x7F, 0x02, 0x90, 0x50, 0x35, 0x02	; 023263C0

; ===== function loc_023263D0 =====
loc_023263D0:
	push {lr}	; 023263D0
	sub sp,#0x4	; 023263D2
	ldr r0,[pool_023263F4]	; 023263D4
	ldr r1,[pool_023263F8]	; 023263D6
	ldrb r2,[r0,#0x14]	; 023263D8
	lsl r2,r2,#0x1	; 023263DA
	blx loc_0232E2FC	; 023263DC
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
	.word 0x023550C8	; 02326478
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
	bl loc_02328260	; 0232649C
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
	bl loc_0232E018	; 023264BA
	add r5,r5,#0x1	; 023264BE
	cmp r5,#0x1a	; 023264C0
	blt loc_023264B0	; 023264C2
	ldr r0,[pool_0232652C]	; 023264C4
	ldr r1,[pool_02326530]	; 023264C6
	mov r2,#0x2	; 023264C8
	bl loc_0232E10C	; 023264CA
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
	.word 0x023550C8	; 0232651C
pool_02326520:
loc_02326520:
	.word 0x02355468	; 02326520
pool_02326524:
loc_02326524:
	.word 0x000003A0	; 02326524
pool_02326528:
loc_02326528:
	.word 0x0001D000	; 02326528
pool_0232652C:
loc_0232652C:
	.word 0x02330828	; 0232652C
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
; 保存 r0 的开盖回调；空指针表示不回调。
; Save the lid-open callback in r0; null disables its notification.
.func P1_SetLidOpenedCallback
	ldr r1,[pool_0232654C]	; 02326544
	str r0,[r1,#0x0]	; 02326546
	bx lr	; 02326548
.endfunc
	.byte 0xC0, 0x46	; 0232654C
pool_0232654C:
loc_0232654C:
	.word P1_LidOpenedCallbackSlot	; 0232654C
; 保存 r0 的唤醒后回调；空指针表示不回调。
; Save the after-sleep callback in r0; null disables it.
.func P1_SetAfterSleepCallback
	ldr r1,[P1_SetAfterSleepCallbackLiteral]
	str r0,[r1,#0x0]
	bx lr
.endfunc
	.byte 0xC0, 0x46
P1_SetAfterSleepCallbackLiteral:
	.word P1_AfterSleepCallbackSlot

; 保存 r0 的休眠前回调；空指针表示不回调。
; Save the before-sleep callback in r0; null disables it.
.func P1_SetBeforeSleepCallback
	ldr r1,[P1_SetBeforeSleepCallbackLiteral]
	str r0,[r1,#0x0]
	bx lr
.endfunc
	.byte 0xC0, 0x46
P1_SetBeforeSleepCallbackLiteral:
	.word P1_BeforeSleepCallbackSlot


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
	bl loc_02330260	; 023265F8
	mov r0,#0x0	; 023265FC
	ldr r1,[pool_02326620]	; 023265FE
	bl loc_023301A4	; 02326600
	mov r0,#0x0	; 02326604
	ldr r1,[pool_0232661C]	; 02326606
	bl loc_023300C8	; 02326608
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
; 更新开合盖边沿；按现有状态执行休眠、唤醒及已注册回调。
; Track lid transitions; handle sleep, wake-up and registered callbacks according to current state.
.func P1_UpdateLidAndSleepState
	push {lr}	; 02326644
	sub sp,#0x4	; 02326646
	ldr r0,[pool_023267F0]	; 02326648
	ldrh r1,[r0,#0x0]	; 0232664A
	ldr r0,[pool_023267F4]	; 0232664C
	and r1,r0	; 0232664E
	asr r0,r1,#0xf	; 02326650
	ldr r1,[pool_023267F8]	; 02326652
	ldr r2,[r1,#0x0]	; 02326654
	ldr r1,[pool_023267FC]	; 02326656
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
	ldr r2,[pool_023267F8]	; 02326670
	ldr r3,[r2,#0x0]	; 02326672
	ldr r1,[pool_02326800]	; 02326674
	orr r3,r1	; 02326676
	str r3,[r2,#0x0]	; 02326678
	b loc_02326686	; 0232667A
loc_0232667C:
	ldr r2,[pool_023267F8]	; 0232667C
	ldr r3,[r2,#0x0]	; 0232667E
	ldr r1,[pool_02326804]	; 02326680
	and r3,r1	; 02326682
	str r3,[r2,#0x0]	; 02326684
loc_02326686:
	cmp r0,#0x0	; 02326686
	beq loc_02326696	; 02326688
	ldr r1,[pool_023267F8]	; 0232668A
	ldr r2,[r1,#0x0]	; 0232668C
	ldr r0,[pool_023267FC]	; 0232668E
	orr r2,r0	; 02326690
	str r2,[r1,#0x0]	; 02326692
	b loc_023266A0	; 02326694
loc_02326696:
	ldr r1,[pool_023267F8]	; 02326696
	ldr r2,[r1,#0x0]	; 02326698
	ldr r0,[pool_02326808]	; 0232669A
	and r2,r0	; 0232669C
	str r2,[r1,#0x0]	; 0232669E
loc_023266A0:
	ldr r1,[pool_023267F8]	; 023266A0
	ldr r2,[r1,#0x0]	; 023266A2
	mov r0,#0x2	; 023266A4
	and r2,r0	; 023266A6
	cmp r2,#0x2	; 023266A8
	beq loc_0232671C	; 023266AA
	ldr r0,[pool_023267F0]	; 023266AC
	ldrh r2,[r0,#0x0]	; 023266AE
	ldr r0,[pool_023267F4]	; 023266B0
	and r2,r0	; 023266B2
	asr r0,r2,#0xf	; 023266B4
	cmp r0,#0x0	; 023266B6
	beq loc_0232671C	; 023266B8
	ldr r2,[r1,#0x0]	; 023266BA
	mov r0,#0x40	; 023266BC
	orr r2,r0	; 023266BE
	str r2,[r1,#0x0]	; 023266C0
	bl loc_02329918	; 023266C2
	ldr r0,[pool_0232680C]	; 023266C6
	ldr r0,[r0,#0x0]	; 023266C8
	cmp r0,#0x0	; 023266CA
	beq loc_023266D0	; 023266CC
	blx r0	; 023266CE
loc_023266D0:
	bl loc_023278AC	; 023266D0
	bl loc_023268A8	; 023266D4
	bl loc_0232D0D8	; 023266D8
	ldr r2,[pool_02326810]	; 023266DC
	ldr r1,[r2,#0x0]	; 023266DE
	ldr r0,[pool_02326814]	; 023266E0
	and r1,r0	; 023266E2
	str r1,[r2,#0x0]	; 023266E4
	ldr r0,[pool_023267F8]	; 023266E6
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
	bl loc_0232F61C	; 02326700
	mov r0,#0xa	; 02326704
	mov r1,#0x1	; 02326706
	blx loc_0232ABB0	; 02326708
	bl loc_0232D098	; 0232670C
	ldr r2,[pool_02326810]	; 02326710
	ldr r1,[r2,#0x0]	; 02326712
	ldr r0,[pool_02326818]	; 02326714
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
	ldr r0,[pool_023267F0]	; 02326738
	ldrh r1,[r0,#0x0]	; 0232673A
	ldr r0,[pool_023267F4]	; 0232673C
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
	bl loc_0232F758	; 0232674E
loc_02326752:
	ldr r0,[pool_023267F8]	; 02326752
	ldr r1,[r0,#0x0]	; 02326754
	mov r0,#0x40	; 02326756
	and r1,r0	; 02326758
	cmp r1,#0x40	; 0232675A
	bne loc_023267A6	; 0232675C
	bl loc_023278CC	; 0232675E
	bl loc_023278AC	; 02326762
	bl loc_023278CC	; 02326766
	cmp r0,#0x0	; 0232676A
	bne loc_02326788	; 0232676C
	ldr r0,[pool_0232681C]	; 0232676E
	ldr r0,[r0,#0x0]	; 02326770
	mov r1,#0x1	; 02326772
	and r0,r1	; 02326774
	cmp r0,#0x0	; 02326776
	bne loc_0232677C	; 02326778
	mov r1,#0x0	; 0232677A
loc_0232677C:
	cmp r1,#0x0	; 0232677C
	beq loc_0232678C	; 0232677E
	bl loc_0232C2F4	; 02326780
	cmp r0,#0x0	; 02326784
	beq loc_0232678C	; 02326786
loc_02326788:
	bl loc_0232F728	; 02326788
loc_0232678C:
	ldr r0,[pool_02326820]	; 0232678C
	ldr r0,[r0,#0x0]	; 0232678E
	cmp r0,#0x0	; 02326790
	beq loc_02326796	; 02326792
	blx r0	; 02326794
loc_02326796:
	bl loc_02329910	; 02326796
	ldr r1,[pool_023267F8]	; 0232679A
	ldr r2,[r1,#0x0]	; 0232679C
	mov r0,#0x40	; 0232679E
	bic r2,r0	; 023267A0
	str r2,[r1,#0x0]	; 023267A2
	b loc_023267E8	; 023267A4
loc_023267A6:
	bl loc_023278CC	; 023267A6
	cmp r0,#0x0	; 023267AA
	bne loc_023267C8	; 023267AC
	ldr r0,[pool_0232681C]	; 023267AE
	ldr r0,[r0,#0x0]	; 023267B0
	mov r1,#0x1	; 023267B2
	and r0,r1	; 023267B4
	cmp r0,#0x0	; 023267B6
	bne loc_023267BC	; 023267B8
	mov r1,#0x0	; 023267BA
loc_023267BC:
	cmp r1,#0x0	; 023267BC
	beq loc_023267D2	; 023267BE
	bl loc_0232C2F4	; 023267C0
	cmp r0,#0x0	; 023267C4
	beq loc_023267D2	; 023267C6
loc_023267C8:
	bl loc_02329918	; 023267C8
	bl loc_0232C150	; 023267CC
	b loc_023267E8	; 023267D0
loc_023267D2:
	ldr r0,[pool_023267F8]	; 023267D2
	ldr r1,[r0,#0x0]	; 023267D4
	ldr r0,[pool_02326800]	; 023267D6
	and r1,r0	; 023267D8
	cmp r1,r0	; 023267DA
	bne loc_023267E8	; 023267DC
	ldr r0,[pool_02326824]	; 023267DE
	ldr r0,[r0,#0x0]	; 023267E0
	cmp r0,#0x0	; 023267E2
	beq loc_023267E8	; 023267E4
	blx r0	; 023267E6
loc_023267E8:
	add sp,#0x4	; 023267E8
	pop {r3}	; 023267EA
	bx r3	; 023267EC
.endfunc
	.byte 0xC0, 0x46	; 023267F0
pool_023267F0:
loc_023267F0:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 023267F0
pool_023267F4:
loc_023267F4:
	.word SystemWorkLidClosedMask	; 023267F4
pool_023267F8:
loc_023267F8:
	.word P1_LidAndSleepState	; 023267F8
pool_023267FC:
loc_023267FC:
	.word LidStateClosedMask	; 023267FC
pool_02326800:
loc_02326800:
	.word LidStateOpenedMask	; 02326800
pool_02326804:
loc_02326804:
	.word (0xFFFFFFFF ^ LidStateOpenedMask)	; 02326804
pool_02326808:
loc_02326808:
	.word (0xFFFFFFFF ^ LidStateClosedMask)	; 02326808
pool_0232680C:
loc_0232680C:
	.word P1_BeforeSleepCallbackSlot	; 0232680C
pool_02326810:
loc_02326810:
	.word REG_DISPCNT_B	; 02326810
pool_02326814:
loc_02326814:
	.word 0xFFFEFFFF	; 02326814
pool_02326818:
loc_02326818:
	.word 0x00010000	; 02326818
pool_0232681C:
loc_0232681C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232681C
pool_02326820:
loc_02326820:
	.word P1_AfterSleepCallbackSlot	; 02326820
pool_02326824:
loc_02326824:
	.word P1_LidOpenedCallbackSlot	; 02326824

; ===== function loc_02326828 =====
loc_02326828:
	push {lr}	; 02326828
	sub sp,#0x4	; 0232682A
	mov r0,#0x0	; 0232682C
	ldr r1,[pool_02326850]	; 0232682E
	str r0,[r1,#0x0]	; 02326830
	ldr r1,[pool_02326854]	; 02326832
	str r0,[r1,#0x0]	; 02326834
	ldr r1,[pool_02326858]	; 02326836
	str r0,[r1,#0x0]	; 02326838
	ldr r1,[pool_0232685C]	; 0232683A
	str r0,[r1,#0x0]	; 0232683C
	bl loc_023301A4	; 0232683E
	mov r0,#0x1	; 02326842
	ldr r1,[pool_0232685C]	; 02326844
	bl loc_023301A4	; 02326846
	add sp,#0x4	; 0232684A
	pop {r3}	; 0232684C
	bx r3	; 0232684E
pool_02326850:
loc_02326850:
	.word P1_BssStart + 0x24DD8	; 02326850
pool_02326854:
loc_02326854:
	.word P1_BssStart + 0x24DE0	; 02326854
pool_02326858:
loc_02326858:
	.word P1_BssStart + 0x24DE4	; 02326858
pool_0232685C:
loc_0232685C:
	.word P1_BssStart + 0x24DDC	; 0232685C

; ===== function loc_02326860 =====
loc_02326860:
	push {lr}	; 02326860
	sub sp,#0x4	; 02326862
	bl P1_UpdateLidAndSleepState	; 02326864
	bl loc_02326910	; 02326868
	bl loc_02325694	; 0232686C
	add r1,r0,#0x4	; 02326870
	ldr r0,[r1,#0x0]	; 02326872
	add r0,r0,#0x1	; 02326874
	str r0,[r1,#0x0]	; 02326876
	add sp,#0x4	; 02326878
	pop {r3}	; 0232687A
	bx r3	; 0232687C
	.byte 0x00, 0x00	; 02326880

; ===== function loc_02326880 =====
loc_02326880:
	ldr r1,[pool_0232688C]	; 02326880
	ldr r2,[r1,#0x0]	; 02326882
	mov r0,#0x2	; 02326884
	bic r2,r0	; 02326886
	str r2,[r1,#0x0]	; 02326888
	bx lr	; 0232688A
pool_0232688C:
loc_0232688C:
	.word P1_BssStart + 0x24DFC	; 0232688C

; ===== function loc_02326890 =====
loc_02326890:
	ldr r1,[pool_023268A0]	; 02326890
	ldr r2,[r1,#0x0]	; 02326892
	mov r0,#0x2	; 02326894
	orr r2,r0	; 02326896
	str r2,[r1,#0x0]	; 02326898
	mov r0,#0x0	; 0232689A
	ldr r3,[pool_023268A4]	; 0232689C
	bx r3	; 0232689E
pool_023268A0:
loc_023268A0:
	.word P1_BssStart + 0x24DFC	; 023268A0
pool_023268A4:
loc_023268A4:
	.word loc_02329070 + 1	; 023268A4

; ===== function loc_023268A8 =====
loc_023268A8:
	ldr r1,[pool_023268B8]	; 023268A8
	ldr r2,[r1,#0x0]	; 023268AA
	mov r0,#0x1	; 023268AC
	bic r2,r0	; 023268AE
	str r2,[r1,#0x0]	; 023268B0
	mov r0,#0x0	; 023268B2
	ldr r3,[pool_023268BC]	; 023268B4
	bx r3	; 023268B6
pool_023268B8:
loc_023268B8:
	.word P1_BssStart + 0x24DFC	; 023268B8
pool_023268BC:
loc_023268BC:
	.word loc_02329070 + 1	; 023268BC

; ===== function loc_023268C0 =====
loc_023268C0:
	push {r4,lr}	; 023268C0
	cmp r1,#0x0	; 023268C2
	beq loc_023268CE	; 023268C4
	ldr r2,[pool_0232690C]	; 023268C6
	ldr r2,[r2,#0x8]	; 023268C8
	cmp r2,r0	; 023268CA
	bne loc_023268DA	; 023268CC
loc_023268CE:
	ldr r2,[pool_0232690C]	; 023268CE
	ldr r3,[r2,#0x0]	; 023268D0
	mov r2,#0x1	; 023268D2
	and r3,r2	; 023268D4
	cmp r3,#0x1	; 023268D6
	beq loc_023268E8	; 023268D8
loc_023268DA:
	mov r2,#0x0	; 023268DA
	ldr r3,[pool_0232690C]	; 023268DC
	str r2,[r3,#0x4]	; 023268DE
	ldr r4,[r3,#0x0]	; 023268E0
	mov r2,#0x1	; 023268E2
	orr r4,r2	; 023268E4
	str r4,[r3,#0x0]	; 023268E6
loc_023268E8:
	cmp r1,#0x0	; 023268E8
	beq loc_023268F8	; 023268EA
	ldr r2,[pool_0232690C]	; 023268EC
	ldr r3,[r2,#0x0]	; 023268EE
	mov r1,#0x4	; 023268F0
	orr r3,r1	; 023268F2
	str r3,[r2,#0x0]	; 023268F4
	b loc_02326902	; 023268F6
loc_023268F8:
	ldr r2,[pool_0232690C]	; 023268F8
	ldr r3,[r2,#0x0]	; 023268FA
	mov r1,#0x4	; 023268FC
	bic r3,r1	; 023268FE
	str r3,[r2,#0x0]	; 02326900
loc_02326902:
	ldr r1,[pool_0232690C]	; 02326902
	str r0,[r1,#0x8]	; 02326904
	pop {r4}	; 02326906
	pop {r3}	; 02326908
	bx r3	; 0232690A
pool_0232690C:
loc_0232690C:
	.word P1_BssStart + 0x24DFC	; 0232690C

; ===== function loc_02326910 =====
loc_02326910:
	push {lr}	; 02326910
	sub sp,#0x4	; 02326912
	ldr r2,[pool_0232697C]	; 02326914
	ldr r0,[r2,#0x0]	; 02326916
	mov r1,#0x1	; 02326918
	and r0,r1	; 0232691A
	cmp r0,#0x1	; 0232691C
	bne loc_0232696E	; 0232691E
	ldr r3,[r2,#0x0]	; 02326920
	mov r0,#0x2	; 02326922
	and r3,r0	; 02326924
	cmp r3,#0x2	; 02326926
	beq loc_0232696E	; 02326928
	ldr r0,[r2,#0x8]	; 0232692A
	lsl r3,r0,#0x2	; 0232692C
	ldr r0,[pool_02326980]	; 0232692E
	ldr r3,[r0,r3]	; 02326930
	ldr r0,[r2,#0x4]	; 02326932
	lsr r3,r0	; 02326934
	and r3,r1	; 02326936
	lsl r0,r3,#0x10	; 02326938
	lsr r0,r0,#0x10	; 0232693A
	bl loc_02329070	; 0232693C
	ldr r0,[pool_0232697C]	; 02326940
	ldr r1,[r0,#0x4]	; 02326942
	add r1,r1,#0x1	; 02326944
	str r1,[r0,#0x4]	; 02326946
	ldr r1,[r0,#0x4]	; 02326948
	cmp r1,#0x20	; 0232694A
	blt loc_0232695E	; 0232694C
	ldr r1,[r0,#0x0]	; 0232694E
	mov r0,#0x4	; 02326950
	and r1,r0	; 02326952
	cmp r1,#0x4	; 02326954
	bne loc_0232695E	; 02326956
	bl loc_023268A8	; 02326958
	b loc_02326974	; 0232695C
loc_0232695E:
	ldr r0,[pool_0232697C]	; 0232695E
	ldr r0,[r0,#0x4]	; 02326960
	mov r1,#0x20	; 02326962
	blx P1_SignedDivMod	; 02326964
	ldr r0,[pool_0232697C]	; 02326968
	str r1,[r0,#0x4]	; 0232696A
	b loc_02326974	; 0232696C
loc_0232696E:
	mov r0,#0x0	; 0232696E
	bl loc_02329070	; 02326970
loc_02326974:
	add sp,#0x4	; 02326974
	pop {r3}	; 02326976
	bx r3	; 02326978
	.byte 0xC0, 0x46	; 0232697C
pool_0232697C:
loc_0232697C:
	.word P1_BssStart + 0x24DFC	; 0232697C
pool_02326980:
loc_02326980:
	.word P1_Data_0233082C	; 02326980

; ===== function loc_02326984 =====
loc_02326984:
	push {lr}	; 02326984
	sub sp,#0x4	; 02326986
	ldr r0,[pool_0232699C]	; 02326988
	mov r1,#0x0	; 0232698A
	mov r2,#0xc	; 0232698C
	blx loc_0232E3C8	; 0232698E
	bl loc_023290BC	; 02326992
	add sp,#0x4	; 02326996
	pop {r3}	; 02326998
	bx r3	; 0232699A
pool_0232699C:
loc_0232699C:
	.word 0x02355C5C	; 0232699C

; ===== function loc_023269A0 =====
loc_023269A0:
	push {r4,lr}	; 023269A0
	add r4,r0,#0x0	; 023269A2
	bl loc_023269D8	; 023269A4
	ldr r2,[pool_023269B8]	; 023269A8
	ldmia r2!,{r0,r1}	; 023269AA
	stmia r4!,{r0,r1}	; 023269AC
	ldmia r2!,{r0,r1}	; 023269AE
	stmia r4!,{r0,r1}	; 023269B0
	pop {r4}	; 023269B2
	pop {r3}	; 023269B4
	bx r3	; 023269B6
pool_023269B8:
loc_023269B8:
	.word 0x02355C74	; 023269B8

; ===== function loc_023269BC =====
loc_023269BC:
	push {r4,lr}	; 023269BC
	add r4,r0,#0x0	; 023269BE
	bl loc_023269D8	; 023269C0
	ldr r2,[pool_023269D4]	; 023269C4
	ldmia r2!,{r0,r1}	; 023269C6
	stmia r4!,{r0,r1}	; 023269C8
	ldr r0,[r2,#0x0]	; 023269CA
	str r0,[r4,#0x0]	; 023269CC
	pop {r4}	; 023269CE
	pop {r3}	; 023269D0
	bx r3	; 023269D2
pool_023269D4:
loc_023269D4:
	.word 0x02355C68	; 023269D4

; ===== function loc_023269D8 =====
loc_023269D8:
	push {lr}	; 023269D8
	sub sp,#0x4	; 023269DA
	bl loc_02325694	; 023269DC
	ldr r0,[r0,#0x4]	; 023269E0
	mov r1,#0x14	; 023269E2
	blx P1_UnsignedDivMod	; 023269E4
	cmp r1,#0x0	; 023269E8
	bne loc_02326A0E	; 023269EA
	ldr r0,[pool_02326A14]	; 023269EC
	ldr r1,[pool_02326A18]	; 023269EE
	bl loc_023303A8	; 023269F0
	cmp r0,#0x0	; 023269F4
	beq loc_02326A0E	; 023269F6
	mov r2,#0x0	; 023269F8
	ldr r0,[pool_02326A14]	; 023269FA
	str r2,[r0,#0x0]	; 023269FC
	mov r1,#0x1	; 023269FE
	str r1,[r0,#0x4]	; 02326A00
	str r1,[r0,#0x8]	; 02326A02
	str r2,[r0,#0xc]	; 02326A04
	ldr r0,[pool_02326A18]	; 02326A06
	str r2,[r0,#0x0]	; 02326A08
	str r2,[r0,#0x4]	; 02326A0A
	str r2,[r0,#0x8]	; 02326A0C
loc_02326A0E:
	add sp,#0x4	; 02326A0E
	pop {r3}	; 02326A10
	bx r3	; 02326A12
pool_02326A14:
loc_02326A14:
	.word P1_BssStart + 0x24E14	; 02326A14
pool_02326A18:
loc_02326A18:
	.word P1_BssStart + 0x24E08	; 02326A18

; ===== function loc_02326A1C =====
loc_02326A1C:
	push {r4,r5,r6,r7,lr}	; 02326A1C
	sub sp,#0xc	; 02326A1E
	add r5,r0,#0x0	; 02326A20
	add r4,r1,#0x0	; 02326A22
	add r6,r2,#0x0	; 02326A24
	sub r0,r4,#0x1	; 02326A26
	cmp r0,#0x1	; 02326A28
	bhi loc_02326A30	; 02326A2A
	sub r5,r5,#0x1	; 02326A2C
	add r4,#0xc	; 02326A2E
loc_02326A30:
	add r0,r5,#0x0	; 02326A30
	ldr r1,[pool_02326A7C]	; 02326A32
	blx P1_SignedDivMod	; 02326A34
	add r7,r0,#0x0	; 02326A38
	add r0,r5,#0x0	; 02326A3A
	mov r1,#0x4	; 02326A3C
	blx P1_SignedDivMod	; 02326A3E
	str r0,[sp,#0x0]	; 02326A42
	add r0,r5,#0x0	; 02326A44
	mov r1,#0x64	; 02326A46
	blx P1_SignedDivMod	; 02326A48
	str r0,[sp,#0x4]	; 02326A4C
	mov r0,#0xd	; 02326A4E
	mul r4,r0	; 02326A50
	add r4,#0x8	; 02326A52
	add r0,r4,#0x0	; 02326A54
	mov r1,#0x5	; 02326A56
	blx P1_SignedDivMod	; 02326A58
	ldr r1,[sp,#0x0]	; 02326A5C
	add r2,r5,r1	; 02326A5E
	ldr r1,[sp,#0x4]	; 02326A60
	sub r1,r2,r1	; 02326A62
	add r1,r7,r1	; 02326A64
	add r0,r1,r0	; 02326A66
	add r0,r6,r0	; 02326A68
	mov r1,#0x7	; 02326A6A
	blx P1_SignedDivMod	; 02326A6C
	add r0,r1,#0x0	; 02326A70
	add sp,#0xc	; 02326A72
	pop {r4,r5,r6,r7}	; 02326A74
	pop {r3}	; 02326A76
	bx r3	; 02326A78
	.byte 0xC0, 0x46	; 02326A7C
pool_02326A7C:
loc_02326A7C:
	.word 0x00000190	; 02326A7C

; ===== function loc_02326A80 =====
loc_02326A80:
	push {r4,r5,r6,lr}	; 02326A80
	sub sp,#0x18	; 02326A82
	add r4,r1,#0x0	; 02326A84
	ldr r6,[pool_02326ABC]	; 02326A86
	add r5,sp,#0x0	; 02326A88
	mov r3,#0xc	; 02326A8A
loc_02326A8C:
	ldrh r1,[r6,#0x0]	; 02326A8C
	add r6,r6,#0x2	; 02326A8E
	strh r1,[r5,#0x0]	; 02326A90
	add r5,r5,#0x2	; 02326A92
	sub r3,r3,#0x1	; 02326A94
	cmp r3,#0x0	; 02326A96
	bne loc_02326A8C	; 02326A98
	cmp r2,#0x1	; 02326A9A
	beq loc_02326AA6	; 02326A9C
	bl loc_02326AC4	; 02326A9E
	cmp r0,#0x0	; 02326AA2
	beq loc_02326AAC	; 02326AA4
loc_02326AA6:
	mov r1,#0x1d	; 02326AA6
	add r0,sp,#0x0	; 02326AA8
	strh r1,[r0,#0x2]	; 02326AAA
loc_02326AAC:
	lsl r1,r4,#0x1	; 02326AAC
	ldr r0,[pool_02326AC0]	; 02326AAE
	add r0,sp	; 02326AB0
	ldrh r0,[r0,r1]	; 02326AB2
	add sp,#0x18	; 02326AB4
	pop {r4,r5,r6}	; 02326AB6
	pop {r3}	; 02326AB8
	bx r3	; 02326ABA
pool_02326ABC:
loc_02326ABC:
	.word P1_Data_02330CF8	; 02326ABC
pool_02326AC0:
loc_02326AC0:
	.word 0xFFFFFFFE	; 02326AC0

; ===== function loc_02326AC4 =====
loc_02326AC4:
	push {r4,lr}	; 02326AC4
	add r4,r0,#0x0	; 02326AC6
	mov r1,#0x3	; 02326AC8
	add r2,r4,#0x0	; 02326ACA
	and r2,r1	; 02326ACC
	cmp r2,#0x0	; 02326ACE
	bne loc_02326ADC	; 02326AD0
	mov r1,#0x64	; 02326AD2
	blx P1_UnsignedDivMod	; 02326AD4
	cmp r1,#0x0	; 02326AD8
	bne loc_02326AE8	; 02326ADA
loc_02326ADC:
	add r0,r4,#0x0	; 02326ADC
	ldr r1,[pool_02326AF4]	; 02326ADE
	blx P1_UnsignedDivMod	; 02326AE0
	cmp r1,#0x0	; 02326AE4
	bne loc_02326AEC	; 02326AE6
loc_02326AE8:
	mov r0,#0x1	; 02326AE8
	b loc_02326AEE	; 02326AEA
loc_02326AEC:
	mov r0,#0x0	; 02326AEC
loc_02326AEE:
	pop {r4}	; 02326AEE
	pop {r3}	; 02326AF0
	bx r3	; 02326AF2
pool_02326AF4:
loc_02326AF4:
	.word 0x00000190	; 02326AF4

; ===== function P1_DecompressAndCheckP3P4 =====
loc_02326AF8:
; 解压 P3/P4，按顺序累计两块明文的 CRC16，清理缓存后发布结果。
; Decode P3/P4, chain CRC16 over their decoded bytes, maintain the cache, then publish the result.
.func P1_DecompressAndCheckP3P4
	push {r4,r5,lr}	; 02326AF8
	sub sp,#0x4	; 02326AFA
	ldr r0,[pool_02326B50]	; 02326AFC
	ldr r1,[pool_02326B54]	; 02326AFE
	blx P1_DecompressP345	; 02326B00
	add r5,r0,#0x0	; 02326B04
	ldr r1,[pool_02326B58]	; 02326B06
	ldr r0,[r1,#BootSharedP4DestinationOffset]	; 02326B08
	ldr r1,[r1,#BootSharedP4StagingOffset]	; 02326B0A
	blx P1_DecompressP345	; 02326B0C
	add r4,r0,#0x0	; 02326B10
	ldr r0,[pool_02326B5C]	; 02326B12
	ldr r1,[pool_02326B50]	; 02326B14
	add r2,r5,#0x0	; 02326B16
	bl P1_SwiGetCrc16	; 02326B18
	ldr r1,[pool_02326B58]	; 02326B1C
	ldr r1,[r1,#BootSharedP4DestinationOffset]	; 02326B1E
	add r2,r4,#0x0	; 02326B20
	bl P1_SwiGetCrc16	; 02326B22
	add r4,r0,#0x0	; 02326B26
	blx P1_CleanAndInvalidateEntireDataCacheByIndex	; 02326B28
	ldr r0,[pool_02326B58]	; 02326B2C
	ldrh r0,[r0,#BootSharedP3P4Crc16Offset]	; 02326B2E
	cmp r4,r0	; 02326B30
	bne loc_02326B42	; 02326B32
	ldr r0,[pool_02326B60]	; 02326B34
	bl P1_OrSharedEventFlags	; 02326B36
	add sp,#0x4	; 02326B3A
	pop {r4,r5}	; 02326B3C
	pop {r3}	; 02326B3E
	bx r3	; 02326B40
loc_02326B42:
	ldr r0,[pool_02326B64]	; 02326B42
	bl P1_OrSharedEventFlags	; 02326B44
	add sp,#0x4	; 02326B48
	pop {r4,r5}	; 02326B4A
	pop {r3}	; 02326B4C
	bx r3	; 02326B4E
.endfunc
pool_02326B50:
loc_02326B50:
	.word P3_FirmwareUiEntry	; 02326B50
pool_02326B54:
loc_02326B54:
	.word FirmwareComponentStagingAddress	; 02326B54
pool_02326B58:
loc_02326B58:
	.word FirmwareBootSharedAddress	; 02326B58
pool_02326B5C:
loc_02326B5C:
	.word 0x0000FFFF	; 02326B5C
pool_02326B60:
loc_02326B60:
	.word 0x00000400	; 02326B60
pool_02326B64:
loc_02326B64:
	.word 0x00000408	; 02326B64

; ===== function P1_DecompressAndCheckP5 =====
loc_02326B68:
; 解压 P5 并校验明文 CRC16；匹配时才发布资源已就绪标志。
; Decode P5 and check its decoded CRC16; publish the resource-ready flag only on a match.
.func P1_DecompressAndCheckP5
	push {r4,lr}	; 02326B68
	ldr r0,[pool_02326B98]	; 02326B6A
	ldr r1,[pool_02326B9C]	; 02326B6C
	blx P1_DecompressP345	; 02326B6E
	add r2,r0,#0x0	; 02326B72
	ldr r0,[pool_02326BA0]	; 02326B74
	ldr r1,[pool_02326B98]	; 02326B76
	bl P1_SwiGetCrc16	; 02326B78
	add r4,r0,#0x0	; 02326B7C
	blx P1_CleanAndInvalidateEntireDataCacheByIndex	; 02326B7E
	ldr r0,[pool_02326BA4]	; 02326B82
	ldrh r0,[r0,#0x0]	; 02326B84
	cmp r4,r0	; 02326B86
	bne loc_02326B90	; 02326B88
	ldr r0,[pool_02326BA8]	; 02326B8A
	bl P1_OrSharedEventFlags	; 02326B8C
loc_02326B90:
	pop {r4}	; 02326B90
	pop {r3}	; 02326B92
	bx r3	; 02326B94
.endfunc
	.byte 0xC0, 0x46	; 02326B98
pool_02326B98:
loc_02326B98:
	.word P5_FirmwareUiResources	; 02326B98
pool_02326B9C:
loc_02326B9C:
	.word FirmwareComponentStagingAddress	; 02326B9C
pool_02326BA0:
loc_02326BA0:
	.word 0x0000FFFF	; 02326BA0
pool_02326BA4:
loc_02326BA4:
	.word FirmwareBootSharedAddress + BootSharedP5Crc16Offset	; 02326BA4
pool_02326BA8:
loc_02326BA8:
	.word 0x10000000	; 02326BA8

; ===== function loc_02326BAC =====
loc_02326BAC:
; 发布前 0x18 字节启动信息，再补 ARM7 BIOS CRC 与 RTC 随机值。
; Publish 0x18 boot-info bytes, then update the ARM7 BIOS CRC and RTC random byte.
.func P1_PublishBootInfo
	push {lr}	; 02326BAC
	sub sp,#0x4	; 02326BAE
	ldr r0,[pool_02326BD0]	; 02326BB0
	ldr r1,[pool_02326BD4]	; 02326BB2
	mov r2,#0x18	; 02326BB4
	blx loc_0232E390	; 02326BB6
	ldr r0,[pool_02326BD8]	; 02326BBA
	ldrh r1,[r0,#0x0]	; 02326BBC
	ldr r0,[pool_02326BDC]	; 02326BBE
	strh r1,[r0,#0x0]	; 02326BC0
	ldr r0,[pool_02326BE0]	; 02326BC2
	ldrb r1,[r0,#0x0]	; 02326BC4
	ldr r0,[pool_02326BE4]	; 02326BC6
	strb r1,[r0,#0x0]	; 02326BC8
	add sp,#0x4	; 02326BCA
	pop {r3}	; 02326BCC
	bx r3	; 02326BCE
.endfunc
pool_02326BD0:
loc_02326BD0:
	.word FirmwareBootInfoScratchAddress	; 02326BD0
pool_02326BD4:
loc_02326BD4:
	.word 0x027FFC00	; 02326BD4
pool_02326BD8:
loc_02326BD8:
	.word FirmwareBootInfoScratchAddress + BootScratchBios7CrcSourceOffset	; 02326BD8
pool_02326BDC:
loc_02326BDC:
	.word FirmwareBootInfoAddress + BootInfoBios7Crc16Offset	; 02326BDC
pool_02326BE0:
loc_02326BE0:
	.word FirmwareBootInfoScratchAddress + BootScratchRtcSourceOffset	; 02326BE0
pool_02326BE4:
loc_02326BE4:
	.word FirmwareBootInfoAddress + BootInfoRtcRandomOffset	; 02326BE4

; ===== function loc_02326BE8 =====
loc_02326BE8:
	push {r4,r5,r6,r7,lr}	; 02326BE8
	sub sp,#0x4	; 02326BEA
	ldr r5,[pool_02326C9C]	; 02326BEC
	mov r0,#0x6d	; 02326BEE
	bl loc_0232AFA0	; 02326BF0
	blx P1_Arm9DisableIrqReturnPriorMask	; 02326BF4
	str r0,[sp,#0x0]	; 02326BF8
	ldr r2,[pool_02326CA0]	; 02326BFA
	ldrh r1,[r2,#0x0]	; 02326BFC
	ldr r0,[pool_02326CA4]	; 02326BFE
	and r1,r0	; 02326C00
	asr r4,r1,#0xf	; 02326C02
	ldrh r1,[r2,#0x0]	; 02326C04
	mov r0,#0xc	; 02326C06
	and r1,r0	; 02326C08
	asr r6,r1,#0x2	; 02326C0A
	ldrh r1,[r2,#0x0]	; 02326C0C
	mov r3,#0x10	; 02326C0E
	and r1,r3	; 02326C10
	asr r7,r1,#0x4	; 02326C12
	ldrh r1,[r2,#0x0]	; 02326C14
	bic r1,r0	; 02326C16
	orr r1,r0	; 02326C18
	strh r1,[r2,#0x0]	; 02326C1A
	ldrh r0,[r2,#0x0]	; 02326C1C
	bic r0,r3	; 02326C1E
	strh r0,[r2,#0x0]	; 02326C20
	ldrh r1,[r2,#0x0]	; 02326C22
	ldr r0,[pool_02326CA8]	; 02326C24
	and r1,r0	; 02326C26
	strh r1,[r2,#0x0]	; 02326C28
	mov r0,#0x0	; 02326C2A
	ldr r1,[pool_02326CAC]	; 02326C2C
	ldr r2,[pool_02326CB0]	; 02326C2E
	mov r3,#0x40	; 02326C30
	bl loc_0232E20C	; 02326C32
	ldr r0,[pool_02326CA0]	; 02326C36
	ldrh r1,[r0,#0x0]	; 02326C38
	ldr r2,[pool_02326CA8]	; 02326C3A
	and r1,r2	; 02326C3C
	lsl r2,r4,#0xf	; 02326C3E
	orr r1,r2	; 02326C40
	strh r1,[r0,#0x0]	; 02326C42
	ldrh r2,[r0,#0x0]	; 02326C44
	mov r1,#0xc	; 02326C46
	bic r2,r1	; 02326C48
	lsl r1,r6,#0x2	; 02326C4A
	orr r2,r1	; 02326C4C
	strh r2,[r0,#0x0]	; 02326C4E
	ldrh r2,[r0,#0x0]	; 02326C50
	mov r1,#0x10	; 02326C52
	bic r2,r1	; 02326C54
	lsl r1,r7,#0x4	; 02326C56
	orr r2,r1	; 02326C58
	strh r2,[r0,#0x0]	; 02326C5A
	ldr r0,[sp,#0x0]	; 02326C5C
	blx P1_Arm9RestoreIrqMask	; 02326C5E
	mov r0,#0x6d	; 02326C62
	bl loc_0232AE38	; 02326C64
	add r0,r5,#0x0	; 02326C68
	add r0,#0xbe	; 02326C6A
	ldrh r1,[r0,#0x0]	; 02326C6C
	ldr r0,[pool_02326CB4]	; 02326C6E
	strh r1,[r0,#0x0]	; 02326C70
	mov r2,#0x0	; 02326C72
	ldr r0,[pool_02326CB8]	; 02326C74
loc_02326C76:
	add r1,r5,r2	; 02326C76
	add r1,#0xb5	; 02326C78
	ldrb r1,[r1,#0x0]	; 02326C7A
	strb r1,[r2,r0]	; 02326C7C
	add r2,r2,#0x1	; 02326C7E
	cmp r2,#0x3	; 02326C80
	blt loc_02326C76	; 02326C82
	add r0,r5,#0x0	; 02326C84
	add r0,#0xb0	; 02326C86
	ldrh r0,[r0,#0x0]	; 02326C88
	ldr r1,[pool_02326CB4]	; 02326C8A
	strh r0,[r1,#0x6]	; 02326C8C
	add r5,#0xac	; 02326C8E
	ldr r0,[r5,#0x0]	; 02326C90
	str r0,[r1,#0x8]	; 02326C92
	add sp,#0x4	; 02326C94
	pop {r4,r5,r6,r7}	; 02326C96
	pop {r3}	; 02326C98
	bx r3	; 02326C9A
pool_02326C9C:
loc_02326C9C:
	.word 0x02355CA0	; 02326C9C
pool_02326CA0:
loc_02326CA0:
	.word REG_EXMEMCNT_ARM9	; 02326CA0
pool_02326CA4:
loc_02326CA4:
	.word 0x00008000	; 02326CA4
pool_02326CA8:
loc_02326CA8:
	.word 0xFFFF7FFF	; 02326CA8
pool_02326CAC:
loc_02326CAC:
	.word 0x08000080	; 02326CAC
pool_02326CB0:
loc_02326CB0:
	.word 0x02355D20	; 02326CB0
pool_02326CB4:
loc_02326CB4:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 02326CB4
pool_02326CB8:
loc_02326CB8:
	.word 0x027FFC32	; 02326CB8

; ===== function loc_02326CBC =====
loc_02326CBC:
	push {r4}	; 02326CBC
	sub sp,#0x4	; 02326CBE
	ldr r1,[pool_02326CF4]	; 02326CC0
	mov r2,#0x4e	; 02326CC2
	sub r2,r2,#0x1	; 02326CC4
	lsl r2,r2,#0x10	; 02326CC6
	lsr r4,r2,#0x10	; 02326CC8
loc_02326CCA:
	ldrh r3,[r1,#0x0]	; 02326CCA
	add r1,r1,#0x2	; 02326CCC
	ldrh r2,[r0,#0x0]	; 02326CCE
	add r0,r0,#0x2	; 02326CD0
	cmp r3,r2	; 02326CD2
	beq loc_02326CDE	; 02326CD4
	mov r0,#0x0	; 02326CD6
	add sp,#0x4	; 02326CD8
	pop {r4}	; 02326CDA
	bx lr	; 02326CDC
loc_02326CDE:
	add r3,r4,#0x0	; 02326CDE
	sub r2,r4,#0x1	; 02326CE0
	lsl r2,r2,#0x10	; 02326CE2
	lsr r4,r2,#0x10	; 02326CE4
	cmp r3,#0x0	; 02326CE6
	bne loc_02326CCA	; 02326CE8
	mov r0,#0x1	; 02326CEA
	add sp,#0x4	; 02326CEC
	pop {r4}	; 02326CEE
	bx lr	; 02326CF0
	.byte 0xC0, 0x46	; 02326CF4
pool_02326CF4:
loc_02326CF4:
	.word Bios9NintendoLogoAddress	; 02326CF4

; ===== function loc_02326CF8 =====
loc_02326CF8:
	ldr r0,[pool_02326D18]	; 02326CF8
	ldrh r1,[r0,#0x0]	; 02326CFA
	ldr r0,[pool_02326D1C]	; 02326CFC
	cmp r1,r0	; 02326CFE
	bne loc_02326D12	; 02326D00
	ldr r0,[pool_02326D20]	; 02326D02
	ldrh r1,[r0,#0x0]	; 02326D04
	ldr r0,[pool_02326D24]	; 02326D06
	ldrh r0,[r0,#0x0]	; 02326D08
	cmp r1,r0	; 02326D0A
	bne loc_02326D12	; 02326D0C
	mov r0,#0x1	; 02326D0E
	bx lr	; 02326D10
loc_02326D12:
	mov r0,#0x0	; 02326D12
	bx lr	; 02326D14
	.byte 0xC0, 0x46	; 02326D18
pool_02326D18:
loc_02326D18:
	.word NdsCartHeaderRamAddress + 0x15C	; 02326D18
pool_02326D1C:
loc_02326D1C:
	.word 0x0000CF56	; 02326D1C
pool_02326D20:
loc_02326D20:
	.word NdsCartHeaderRamAddress + 0x15E	; 02326D20
pool_02326D24:
loc_02326D24:
	.word FirmwareBootInfoScratchAddress + BootInfoCardHeaderCrc16Offset	; 02326D24

; ===== function loc_02326D28 =====
loc_02326D28:
	add r1,r0,#0x0	; 02326D28
	mov r0,#0x2	; 02326D2A
	mov r2,#0x0	; 02326D2C
	ldr r3,[pool_02326D34]	; 02326D2E
	bx r3	; 02326D30
	.byte 0xC0, 0x46	; 02326D34
pool_02326D34:
loc_02326D34:
	.word loc_0232ED90 + 1	; 02326D34

; ===== function loc_02326D38 =====
loc_02326D38:
	push {lr}	; 02326D38
	sub sp,#0x4	; 02326D3A
	ldr r0,[pool_02326D50]	; 02326D3C
	ldrb r1,[r0,#0x0]	; 02326D3E
	add r0,sp,#0x0	; 02326D40
	strb r1,[r0,#0x0]	; 02326D42
	add r0,sp,#0x0	; 02326D44
	bl loc_0233026C	; 02326D46
	add sp,#0x4	; 02326D4A
	pop {r3}	; 02326D4C
	bx r3	; 02326D4E
pool_02326D50:
loc_02326D50:
	.word FirmwareUserSettingsSharedAddress + 0x67	; 02326D50

; ===== function loc_02326D54 =====
loc_02326D54:
	push {lr}	; 02326D54
	sub sp,#0x1c	; 02326D56
	ldr r0,[pool_02326D94]	; 02326D58
	ldrb r0,[r0,#0x0]	; 02326D5A
	str r0,[sp,#0x0]	; 02326D5C
	ldr r0,[pool_02326D98]	; 02326D5E
	ldrh r0,[r0,#0x0]	; 02326D60
	str r0,[sp,#0x4]	; 02326D62
	ldr r0,[pool_02326D9C]	; 02326D64
	ldrh r0,[r0,#0x0]	; 02326D66
	str r0,[sp,#0x8]	; 02326D68
	ldr r0,[pool_02326DA0]	; 02326D6A
	ldrb r0,[r0,#0x0]	; 02326D6C
	str r0,[sp,#0xc]	; 02326D6E
	ldr r0,[pool_02326DA4]	; 02326D70
	ldrb r0,[r0,#0x0]	; 02326D72
	str r0,[sp,#0x10]	; 02326D74
	add r0,sp,#0x14	; 02326D76
	ldr r1,[pool_02326DA8]	; 02326D78
	ldrh r1,[r1,#0x0]	; 02326D7A
	ldr r2,[pool_02326DAC]	; 02326D7C
	ldrh r2,[r2,#0x0]	; 02326D7E
	ldr r3,[pool_02326DB0]	; 02326D80
	ldrb r3,[r3,#0x0]	; 02326D82
	bl loc_0232F0B0	; 02326D84
	add r0,sp,#0x14	; 02326D88
	bl loc_0232F2F8	; 02326D8A
	add sp,#0x1c	; 02326D8E
	pop {r3}	; 02326D90
	bx r3	; 02326D92
pool_02326D94:
loc_02326D94:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelY1Offset	; 02326D94
pool_02326D98:
loc_02326D98:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcX2Offset	; 02326D98
pool_02326D9C:
loc_02326D9C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcY2Offset	; 02326D9C
pool_02326DA0:
loc_02326DA0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelX2Offset	; 02326DA0
pool_02326DA4:
loc_02326DA4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelY2Offset	; 02326DA4
pool_02326DA8:
loc_02326DA8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcX1Offset	; 02326DA8
pool_02326DAC:
loc_02326DAC:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcY1Offset	; 02326DAC
pool_02326DB0:
loc_02326DB0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelX1Offset	; 02326DB0

; ===== function loc_02326DB4 =====
loc_02326DB4:
	push {r4,r5,lr}	; 02326DB4
	sub sp,#0x4	; 02326DB6
	ldr r5,[pool_02326E3C]	; 02326DB8
	bl loc_02326CF8	; 02326DBA
	cmp r0,#0x0	; 02326DBE
	beq loc_02326DCA	; 02326DC0
	ldr r0,[pool_02326E40]	; 02326DC2
	ldr r0,[r0,#0x0]	; 02326DC4
	cmp r0,#0x0	; 02326DC6
	bne loc_02326DD8	; 02326DC8
loc_02326DCA:
	mov r1,#0x0	; 02326DCA
	ldr r0,[pool_02326E44]	; 02326DCC
	str r1,[r0,#0x0]	; 02326DCE
	add sp,#0x4	; 02326DD0
	pop {r4,r5}	; 02326DD2
	pop {r3}	; 02326DD4
	bx r3	; 02326DD6
loc_02326DD8:
	blx loc_0232AE48	; 02326DD8
	add r4,r0,#0x0	; 02326DDC
	cmp r4,#0x0	; 02326DDE
	beq loc_02326E0E	; 02326DE0
	lsl r0,r4,#0x10	; 02326DE2
	lsr r0,r0,#0x10	; 02326DE4
	bl loc_0232AF34	; 02326DE6
	add r0,r5,#0x0	; 02326DEA
	ldr r1,[pool_02326E48]	; 02326DEC
	blx P1_CleanAndInvalidateDataCacheRange	; 02326DEE
	ldr r0,[pool_02326E40]	; 02326DF2
	ldr r0,[r0,#0x0]	; 02326DF4
	add r1,r5,#0x0	; 02326DF6
	ldr r2,[pool_02326E48]	; 02326DF8
	bl loc_0232780C	; 02326DFA
	lsl r0,r4,#0x10	; 02326DFE
	lsr r0,r0,#0x10	; 02326E00
	bl loc_0232AE40	; 02326E02
	lsl r0,r4,#0x10	; 02326E06
	lsr r0,r0,#0x10	; 02326E08
	blx loc_0232AEA0	; 02326E0A
loc_02326E0E:
	ldr r0,[pool_02326E4C]	; 02326E0E
	add r1,r5,#0x0	; 02326E10
	add r1,#0x20	; 02326E12
	ldr r2,[pool_02326E50]	; 02326E14
	bl P1_SwiGetCrc16	; 02326E16
	ldrh r1,[r5,#0x2]	; 02326E1A
	cmp r1,r0	; 02326E1C
	beq loc_02326E2E	; 02326E1E
	mov r1,#0x0	; 02326E20
	ldr r0,[pool_02326E44]	; 02326E22
	str r1,[r0,#0x0]	; 02326E24
	add sp,#0x4	; 02326E26
	pop {r4,r5}	; 02326E28
	pop {r3}	; 02326E2A
	bx r3	; 02326E2C
loc_02326E2E:
	mov r1,#0x1	; 02326E2E
	ldr r0,[pool_02326E44]	; 02326E30
	str r1,[r0,#0x0]	; 02326E32
	add sp,#0x4	; 02326E34
	pop {r4,r5}	; 02326E36
	pop {r3}	; 02326E38
	bx r3	; 02326E3A
pool_02326E3C:
loc_02326E3C:
	.word 0x02355D60	; 02326E3C
pool_02326E40:
loc_02326E40:
	.word NdsCartHeaderRamAddress + 0x68	; 02326E40
pool_02326E44:
loc_02326E44:
	.word P1_BssStart + 0x24E24	; 02326E44
pool_02326E48:
loc_02326E48:
	.word 0x00000840	; 02326E48
pool_02326E4C:
loc_02326E4C:
	.word 0x0000FFFF	; 02326E4C
pool_02326E50:
loc_02326E50:
	.word 0x00000820	; 02326E50

; ===== function loc_02326E54 =====
loc_02326E54:
	push {lr}	; 02326E54
	sub sp,#0x4	; 02326E56
	add r1,r0,#0x0	; 02326E58
	ldr r0,[pool_02326E7C]	; 02326E5A
	ldr r0,[r0,#0x0]	; 02326E5C
	cmp r0,#0x0	; 02326E5E
	bne loc_02326E6A	; 02326E60
	mov r0,#0x0	; 02326E62
	add sp,#0x4	; 02326E64
	pop {r3}	; 02326E66
	bx r3	; 02326E68
loc_02326E6A:
	ldr r0,[pool_02326E80]	; 02326E6A
	ldr r2,[pool_02326E84]	; 02326E6C
	blx loc_0232E2FC	; 02326E6E
	mov r0,#0x1	; 02326E72
	add sp,#0x4	; 02326E74
	pop {r3}	; 02326E76
	bx r3	; 02326E78
	.byte 0xC0, 0x46	; 02326E7C
pool_02326E7C:
loc_02326E7C:
	.word P1_BssStart + 0x24E24	; 02326E7C
pool_02326E80:
loc_02326E80:
	.word 0x02355D60	; 02326E80
pool_02326E84:
loc_02326E84:
	.word 0x00000840	; 02326E84

; ===== function loc_02326E88 =====
loc_02326E88:
	push {lr}	; 02326E88
	sub sp,#0x4	; 02326E8A
	ldr r0,[pool_02326EFC]	; 02326E8C
	bl P1_LoadAndSelectUserSettings	; 02326E8E
	ldr r1,[pool_02326F00]	; 02326E92
	str r0,[r1,#0x0]	; 02326E94
	ldr r0,[r1,#0x0]	; 02326E96
	cmp r0,#0x0	; 02326E98
	beq loc_02326ECE	; 02326E9A
	mov r0,#0x0	; 02326E9C
	str r0,[sp,#0x0]	; 02326E9E
	add r0,sp,#0x0	; 02326EA0
	ldr r1,[pool_02326EFC]	; 02326EA2
	ldr r2,[pool_02326F04]	; 02326EA4
	bl loc_0232C3F6	; 02326EA6
	ldr r0,[pool_02326F08]	; 02326EAA
	ldrh r2,[r0,#0x0]	; 02326EAC
	ldr r1,[pool_02326F0C]	; 02326EAE
	orr r2,r1	; 02326EB0
	strh r2,[r0,#0x0]	; 02326EB2
	mov r2,#0x5	; 02326EB4
	ldr r1,[pool_02326EFC]	; 02326EB6
	strb r2,[r1,#0x0]	; 02326EB8
	ldrh r2,[r0,#0x0]	; 02326EBA
	mov r1,#0x7	; 02326EBC
	bic r2,r1	; 02326EBE
	mov r1,#0x1	; 02326EC0
	orr r2,r1	; 02326EC2
	strh r2,[r0,#0x0]	; 02326EC4
	ldr r0,[pool_02326F10]	; 02326EC6
	strb r1,[r0,#0x0]	; 02326EC8
	ldr r0,[pool_02326F14]	; 02326ECA
	strb r1,[r0,#0x0]	; 02326ECC
loc_02326ECE:
	ldr r0,[pool_02326F18]	; 02326ECE
	ldrb r1,[r0,#0x0]	; 02326ED0
	mov r0,#0x1	; 02326ED2
	and r1,r0	; 02326ED4
	cmp r1,#0x0	; 02326ED6
	beq loc_02326EF6	; 02326ED8
	ldr r2,[pool_02326F08]	; 02326EDA
	ldrh r1,[r2,#0x0]	; 02326EDC
	ldr r0,[pool_02326F1C]	; 02326EDE
	and r1,r0	; 02326EE0
	strh r1,[r2,#0x0]	; 02326EE2
	mov r1,#0x0	; 02326EE4
	ldr r0,[pool_02326F20]	; 02326EE6
	str r1,[r0,#0x0]	; 02326EE8
	str r1,[r0,#0x4]	; 02326EEA
	ldr r0,[pool_02326F24]	; 02326EEC
	strb r1,[r0,#0x0]	; 02326EEE
	ldr r0,[pool_02326EFC]	; 02326EF0
	bl loc_02327F00	; 02326EF2
loc_02326EF6:
	add sp,#0x4	; 02326EF6
	pop {r3}	; 02326EF8
	bx r3	; 02326EFA
pool_02326EFC:
loc_02326EFC:
	.word FirmwareUserSettingsSharedAddress	; 02326EFC
pool_02326F00:
loc_02326F00:
	.word FirmwareBootSharedAddress + BootSharedSettingsInvalidOffset	; 02326F00
pool_02326F04:
loc_02326F04:
	.word 0x0100001C	; 02326F04
pool_02326F08:
loc_02326F08:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02326F08
pool_02326F0C:
loc_02326F0C:
	.word 0x00000200	; 02326F0C
pool_02326F10:
loc_02326F10:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 02326F10
pool_02326F14:
loc_02326F14:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthDayOffset	; 02326F14
pool_02326F18:
loc_02326F18:
	.word FirmwareBootInfoScratchAddress + BootScratchRtcSourceOffset	; 02326F18
pool_02326F1C:
loc_02326F1C:
	.word 0xFFFFBFFF	; 02326F1C
pool_02326F20:
loc_02326F20:
	.word FirmwareUserSettingsSharedAddress + UserSettingsRtcOffset	; 02326F20
pool_02326F24:
loc_02326F24:
	.word FirmwareUserSettingsSharedAddress + 0x66	; 02326F24
.arm
; 此段随后覆盖复制至 ITCM；运行入口不是 CRT 初始内容。
; This stub later replaces ITCM contents; its entry is not the CRT image.
P1_TransitionCopySource:
.func P1_TransitionLoadEntry
	ldr r0,[pool_02326F6C]	; 02326F28
	mov r1,#0x9	; 02326F2C
	str r1,[r0,#0x0]	; 02326F30
	ldr r1,[pool_02326F70]	; 02326F34
	b loc_02326F44	; 02326F38
loc_02326F3C:
	mov r0,#0x400	; 02326F3C
	swi 0x30000	; 02326F40
loc_02326F44:
	ldr r0,[r1,#0x0]	; 02326F44
	cmp r0,#0xa	; 02326F48
	bne loc_02326F3C	; 02326F4C
	ldr r1,[pool_02326F74]	; 02326F50
	ldrh r0,[r1,#0x0]	; 02326F54
	bic r0,r0,#0x4000	; 02326F58
	strh r0,[r1,#0x0]	; 02326F5C
	mov r0,#0x0	; 02326F60
	mcr p15,0x0,r0,c7,c0,0x4	; 02326F64
	bx lr	; 02326F68
.endfunc
.definelabel P1_TransitionItcmBase, 0x01FF8000
.definelabel P1_TransitionRuntimeEntry, P1_TransitionItcmBase + (P1_TransitionLoadEntry - P1_TransitionCopySource)
pool_02326F6C:
loc_02326F6C:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 02326F6C
pool_02326F70:
loc_02326F70:
	.word 0x027FF884	; 02326F70
pool_02326F74:
loc_02326F74:
	.word REG_EXMEMCNT_ARM9	; 02326F74
.thumb

; ===== function loc_02326F78 =====
loc_02326F78:
	push {lr}	; 02326F78
	sub sp,#0x4	; 02326F7A
	mov r0,#0x3	; 02326F7C
	bl loc_0232D440	; 02326F7E
	mov r0,#0x0	; 02326F82
	str r0,[sp,#0x0]	; 02326F84
	ldr r0,[sp,#0x0]	; 02326F86
	ldr r1,[pool_02326F98]	; 02326F88
	ldr r2,[pool_02326F9C]	; 02326F8A
	blx loc_0232E344	; 02326F8C
	add sp,#0x4	; 02326F90
	pop {r3}	; 02326F92
	bx r3	; 02326F94
	.byte 0xC0, 0x46	; 02326F98
pool_02326F98:
loc_02326F98:
	.word 0x06800000	; 02326F98
pool_02326F9C:
loc_02326F9C:
	.word 0x00040000	; 02326F9C

; ===== function loc_02326FA0 =====
loc_02326FA0:
	push {lr}	; 02326FA0
	sub sp,#0x4	; 02326FA2
	ldr r0,[pool_02327054]	; 02326FA4
	ldrh r0,[r0,#0x0]	; 02326FA6
	lsl r0,r0,#0x1c	; 02326FA8
	lsr r0,r0,#0x1f	; 02326FAA
	cmp r0,#0x0	; 02326FAC
	beq loc_02326FC2	; 02326FAE
	ldr r0,[pool_02327058]	; 02326FB0
	ldr r0,[r0,#0x0]	; 02326FB2
	cmp r0,#0x0	; 02326FB4
	bne loc_02326FC2	; 02326FB6
	mov r0,#0x0	; 02326FB8
	add r1,r0,#0x0	; 02326FBA
	bl loc_0232F758	; 02326FBC
	b loc_02326FCA	; 02326FC0
loc_02326FC2:
	mov r0,#0x1	; 02326FC2
	mov r1,#0x0	; 02326FC4
	bl loc_0232F758	; 02326FC6
loc_02326FCA:
	ldr r1,[pool_0232705C]	; 02326FCA
	ldrh r0,[r1,#0x0]	; 02326FCC
	mov r0,#0x0	; 02326FCE
	strh r0,[r1,#0x0]	; 02326FD0
	bl loc_0232AD6C	; 02326FD2
	bl loc_0232D2B4	; 02326FD6
	bl loc_0232D2A4	; 02326FDA
	bl loc_0232D274	; 02326FDE
	bl loc_0232D264	; 02326FE2
	bl loc_0232D294	; 02326FE6
	ldr r0,[pool_02327060]	; 02326FEA
	bl loc_0232D440	; 02326FEC
	mov r0,#0x0	; 02326FF0
	str r0,[sp,#0x0]	; 02326FF2
	ldr r0,[sp,#0x0]	; 02326FF4
	ldr r1,[pool_02327064]	; 02326FF6
	ldr r2,[pool_02327068]	; 02326FF8
	blx loc_0232E344	; 02326FFA
	bl loc_0232D284	; 02326FFE
	bl loc_02326F78	; 02327002
	bl loc_0232D098	; 02327006
	ldr r0,[pool_0232706C]	; 0232700A
	ldrh r2,[r0,#0x0]	; 0232700C
	mov r1,#0x2	; 0232700E
	orr r2,r1	; 02327010
	strh r2,[r0,#0x0]	; 02327012
	ldrh r2,[r0,#0x0]	; 02327014
	ldr r1,[pool_02327070]	; 02327016
	and r2,r1	; 02327018
	strh r2,[r0,#0x0]	; 0232701A
	ldrh r2,[r0,#0x0]	; 0232701C
	mov r1,#0xc	; 0232701E
	bic r2,r1	; 02327020
	strh r2,[r0,#0x0]	; 02327022
	ldr r1,[pool_02327054]	; 02327024
	ldrh r1,[r1,#0x0]	; 02327026
	lsl r1,r1,#0x1c	; 02327028
	lsr r1,r1,#0x1f	; 0232702A
	cmp r1,#0x0	; 0232702C
	beq loc_02327040	; 0232702E
	ldr r1,[pool_02327058]	; 02327030
	ldr r1,[r1,#0x0]	; 02327032
	cmp r1,#0x0	; 02327034
	bne loc_02327040	; 02327036
	ldrh r2,[r0,#0x0]	; 02327038
	ldr r1,[pool_02327074]	; 0232703A
	and r2,r1	; 0232703C
	strh r2,[r0,#0x0]	; 0232703E
loc_02327040:
; CpuFastSet 的 0x100 个字复制 0x400 字节，再进入新的 ITCM 段。
; CpuFastSet copies 0x100 words (0x400 bytes), then enters the new ITCM stub.
	ldr r0,[pool_02327078]	; 02327040
	ldr r1,[pool_0232707C]	; 02327042
	ldr r2,[pool_02327080]	; 02327044
	bl loc_0232C3F6	; 02327046
	ldr r0,[pool_0232707C]	; 0232704A
	blx r0	; 0232704C
	add sp,#0x4	; 0232704E
	pop {r3}	; 02327050
	bx r3	; 02327052
pool_02327054:
loc_02327054:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02327054
pool_02327058:
loc_02327058:
	.word FirmwareBootSharedAddress + BootSharedSettingsInvalidOffset	; 02327058
pool_0232705C:
loc_0232705C:
	.word REG_IME	; 0232705C
pool_02327060:
loc_02327060:
	.word 0x000001FF	; 02327060
pool_02327064:
loc_02327064:
	.word 0x06800000	; 02327064
pool_02327068:
loc_02327068:
	.word 0x000A4000	; 02327068
pool_0232706C:
loc_0232706C:
	.word REG_POWERCNT	; 0232706C
pool_02327070:
loc_02327070:
	.word 0xFFFFFDFF	; 02327070
pool_02327074:
loc_02327074:
	.word 0xFFFF7FFF	; 02327074
pool_02327078:
loc_02327078:
	.word P1_TransitionCopySource	; 02327078
pool_0232707C:
loc_0232707C:
	.word P1_TransitionRuntimeEntry	; 0232707C
pool_02327080:
loc_02327080:
	.word 0x00000100	; 02327080

; ===== function loc_02327084 =====
loc_02327084:
	push {lr}	; 02327084
	sub sp,#0x24	; 02327086
	mov r0,#0x0	; 02327088
	bl loc_0232AD6C	; 0232708A
	mov r0,#0x0	; 0232708E
	mvn r0,r0	; 02327090
	bl loc_0232ACF4	; 02327092
	ldr r0,[pool_02327138]	; 02327096
	bl loc_0232D440	; 02327098
	mov r0,#0x0	; 0232709C
	str r0,[sp,#0x0]	; 0232709E
	ldr r0,[sp,#0x0]	; 023270A0
	ldr r1,[pool_0232713C]	; 023270A2
	ldr r2,[pool_02327140]	; 023270A4
	blx loc_0232E344	; 023270A6
	bl loc_0232D284	; 023270AA
	mov r0,#0x0	; 023270AE
	str r0,[sp,#0x4]	; 023270B0
	ldr r0,[sp,#0x4]	; 023270B2
	ldr r1,[pool_02327144]	; 023270B4
	ldr r2,[pool_02327148]	; 023270B6
	blx loc_0232E344	; 023270B8
	mov r0,#0x0	; 023270BC
	str r0,[sp,#0x8]	; 023270BE
	ldr r0,[sp,#0x8]	; 023270C0
	ldr r1,[pool_0232714C]	; 023270C2
	ldr r2,[pool_02327148]	; 023270C4
	blx loc_0232E344	; 023270C6
	mov r0,#0x0	; 023270CA
	str r0,[sp,#0xc]	; 023270CC
	ldr r0,[sp,#0xc]	; 023270CE
	ldr r1,[pool_02327150]	; 023270D0
	ldr r2,[pool_02327148]	; 023270D2
	blx loc_0232E344	; 023270D4
	mov r0,#0x0	; 023270D8
	str r0,[sp,#0x10]	; 023270DA
	ldr r0,[sp,#0x10]	; 023270DC
	ldr r1,[pool_02327154]	; 023270DE
	ldr r2,[pool_02327148]	; 023270E0
	blx loc_0232E344	; 023270E2
	mov r0,#0x0	; 023270E6
	str r0,[sp,#0x14]	; 023270E8
	ldr r0,[sp,#0x14]	; 023270EA
	ldr r1,[pool_02327158]	; 023270EC
	ldr r2,[pool_0232715C]	; 023270EE
	blx loc_0232E344	; 023270F0
	mov r0,#0x0	; 023270F4
	str r0,[sp,#0x18]	; 023270F6
	ldr r0,[sp,#0x18]	; 023270F8
	ldr r1,[pool_02327160]	; 023270FA
	mov r2,#0x40	; 023270FC
	blx loc_0232E344	; 023270FE
	mov r0,#0x0	; 02327102
	str r0,[sp,#0x1c]	; 02327104
	ldr r0,[sp,#0x1c]	; 02327106
	ldr r1,[pool_02327164]	; 02327108
	mov r2,#0x6e	; 0232710A
	blx loc_0232E344	; 0232710C
	mov r0,#0x0	; 02327110
	ldr r1,[pool_02327160]	; 02327112
	strh r0,[r1,#0x0]	; 02327114
	ldr r1,[pool_02327168]	; 02327116
	str r0,[r1,#0x0]	; 02327118
	mov r2,#0x1	; 0232711A
	ldr r1,[pool_0232716C]	; 0232711C
	str r2,[r1,#0x0]	; 0232711E
	str r0,[r1,#0x4]	; 02327120
	ldr r2,[pool_02327170]	; 02327122
	ldr r1,[pool_02327174]	; 02327124
	strh r2,[r1,#0x0]	; 02327126
	ldr r1,[pool_02327178]	; 02327128
	str r0,[r1,#0x0]	; 0232712A
	ldr r1,[pool_0232717C]	; 0232712C
	strh r0,[r1,#0x0]	; 0232712E
	add sp,#0x24	; 02327130
	pop {r3}	; 02327132
	bx r3	; 02327134
	.byte 0xC0, 0x46	; 02327138
pool_02327138:
loc_02327138:
	.word 0x000001FF	; 02327138
pool_0232713C:
loc_0232713C:
	.word 0x06800000	; 0232713C
pool_02327140:
loc_02327140:
	.word 0x000A4000	; 02327140
pool_02327144:
loc_02327144:
	.word 0x07000000	; 02327144
pool_02327148:
loc_02327148:
	.word 0x00000400	; 02327148
pool_0232714C:
loc_0232714C:
	.word 0x05000000	; 0232714C
pool_02327150:
loc_02327150:
	.word 0x07000400	; 02327150
pool_02327154:
loc_02327154:
	.word 0x05000400	; 02327154
pool_02327158:
loc_02327158:
	.word REG_BG0CNT	; 02327158
pool_0232715C:
loc_0232715C:
	.word 0x0000012C	; 0232715C
pool_02327160:
loc_02327160:
	.word REG_DIVCNT	; 02327160
pool_02327164:
loc_02327164:
	.word REG_DISPCNT_B	; 02327164
pool_02327168:
loc_02327168:
	.word REG_DIV_NUMER	; 02327168
pool_0232716C:
loc_0232716C:
	.word REG_DIV_DENOM	; 0232716C
pool_02327170:
loc_02327170:
	.word 0x00004008	; 02327170
pool_02327174:
loc_02327174:
	.word REG_IPC_FIFO_CR	; 02327174
pool_02327178:
loc_02327178:
	.word REG_DISPCNT_A	; 02327178
pool_0232717C:
loc_0232717C:
	.word REG_DISPSTAT	; 0232717C

; ===== function loc_02327180 =====
loc_02327180:
	ldr r1,[pool_02327194]	; 02327180
	ldr r1,[r1,#0x0]	; 02327182
	and r1,r0	; 02327184
	cmp r1,#0x0	; 02327186
	beq loc_0232718E	; 02327188
	mov r0,#0x1	; 0232718A
	bx lr	; 0232718C
loc_0232718E:
	mov r0,#0x0	; 0232718E
	bx lr	; 02327190
	.byte 0xC0, 0x46	; 02327194
pool_02327194:
loc_02327194:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327194

; ===== function loc_02327198 =====
loc_02327198:
	push {r4,lr}	; 02327198
	ldr r0,[pool_02327210]	; 0232719A
	ldr r1,[pool_02327214]	; 0232719C
	ldr r2,[pool_02327218]	; 0232719E
	sub r2,r2,r0	; 023271A0
	blx loc_0232E390	; 023271A2
	ldr r0,[pool_02327210]	; 023271A6
	ldr r1,[pool_0232721C]	; 023271A8
	blx P1_CleanDataCacheRange	; 023271AA
	mov r4,#0x0	; 023271AE
loc_023271B0:
	add r0,r4,#0x0	; 023271B0
	bl loc_0232E1CC	; 023271B2
	add r4,r4,#0x1	; 023271B6
	cmp r4,#0x3	; 023271B8
	ble loc_023271B0	; 023271BA
	bl loc_023278AC	; 023271BC
	bl loc_02327084	; 023271C0
	mov r0,#0x0	; 023271C4
	bl loc_0232D10C	; 023271C6
	ldr r0,[pool_02327220]	; 023271CA
	ldr r1,[pool_02327224]	; 023271CC
	bl loc_0232ADC8	; 023271CE
	ldr r0,[pool_02327220]	; 023271D2
	bl loc_0232AD6C	; 023271D4
	ldr r1,[pool_02327228]	; 023271D8
	ldr r0,[pool_0232722C]	; 023271DA
	strh r1,[r0,#0x0]	; 023271DC
	mov r1,#0x7	; 023271DE
	ldr r0,[pool_02327230]	; 023271E0
	str r1,[r0,#0x0]	; 023271E2
	mov r0,#0x1	; 023271E4
	ldr r1,[pool_02327220]	; 023271E6
	blx loc_0232ABB0	; 023271E8
	ldr r2,[pool_0232722C]	; 023271EC
	ldrh r1,[r2,#0x0]	; 023271EE
	ldr r0,[pool_02327234]	; 023271F0
	and r1,r0	; 023271F2
	strh r1,[r2,#0x0]	; 023271F4
	ldr r1,[pool_02327238]	; 023271F6
	ldrh r0,[r1,#0x0]	; 023271F8
	mov r0,#0x0	; 023271FA
	strh r0,[r1,#0x0]	; 023271FC
	bl loc_0232AD6C	; 023271FE
	mov r0,#0x0	; 02327202
	mvn r0,r0	; 02327204
	bl loc_0232ACF4	; 02327206
	pop {r4}	; 0232720A
	pop {r3}	; 0232720C
	bx r3	; 0232720E
pool_02327210:
loc_02327210:
	.word 0x02327988	; 02327210
pool_02327214:
loc_02327214:
	.word 0x023FEE00	; 02327214
pool_02327218:
loc_02327218:
	.word 0x02327AF0	; 02327218
pool_0232721C:
loc_0232721C:
	.word 0x00000200	; 0232721C
pool_02327220:
loc_02327220:
	.word 0x00010000	; 02327220
pool_02327224:
loc_02327224:
	.word P1_IrqHandler_0232723C + 1	; 02327224
pool_02327228:
loc_02327228:
	.word 0x00004F00	; 02327228
pool_0232722C:
loc_0232722C:
	.word REG_IPC_SYNC	; 0232722C
pool_02327230:
loc_02327230:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 02327230
pool_02327234:
loc_02327234:
	.word 0x00000F00	; 02327234
pool_02327238:
loc_02327238:
	.word REG_IME	; 02327238
P1_IrqHandler_0232723C:
	ldr r1,[pool_0232724C]	; 0232723C
	ldr r0,[pool_02327250]	; 0232723E
	add r2,r1,r0	; 02327240
	ldr r1,[r2,#0x0]	; 02327242
	ldr r0,[pool_02327254]	; 02327244
	orr r1,r0	; 02327246
	str r1,[r2,#0x0]	; 02327248
	bx lr	; 0232724A
pool_0232724C:
loc_0232724C:
	.word P1_DtcmRuntimeStart	; 0232724C
pool_02327250:
loc_02327250:
	.word 0x00003FF8	; 02327250
pool_02327254:
loc_02327254:
	.word 0x00010000	; 02327254

; ===== function loc_02327258 =====
loc_02327258:
; 将参数中的事件位并入双核共享位图。
; OR the requested event bits into the shared bitmap.
.func P1_OrSharedEventFlags
	push {r4,lr}	; 02327258
	add r4,r0,#0x0	; 0232725A
	mov r0,#0x6e	; 0232725C
	ldr r1,[pool_02327280]	; 0232725E
	mov r2,#0x0	; 02327260
	bl loc_0232B094	; 02327262
	ldr r1,[pool_02327280]	; 02327266
	add r2,r1,#0x0	; 02327268
	add r2,#0x8	; 0232726A
	ldr r0,[r2,#0x0]	; 0232726C
	orr r0,r4	; 0232726E
	str r0,[r2,#0x0]	; 02327270
	mov r0,#0x6e	; 02327272
	mov r2,#0x0	; 02327274
	bl loc_0232B01C	; 02327276
	pop {r4}	; 0232727A
	pop {r3}	; 0232727C
	bx r3	; 0232727E
.endfunc
pool_02327280:
loc_02327280:
	.word FirmwareBootSharedAddress + BootSharedEventSyncOffset	; 02327280

; ===== function loc_02327284 =====
loc_02327284:
	ldr r0,[pool_0232728C]	; 02327284
	ldr r3,[pool_02327290]	; 02327286
	bx r3	; 02327288
	.byte 0xC0, 0x46	; 0232728C
pool_0232728C:
loc_0232728C:
	.word 0x80000040	; 0232728C
pool_02327290:
loc_02327290:
	.word P1_OrSharedEventFlags + 1	; 02327290

; ===== function loc_02327294 =====
loc_02327294:
	ldr r0,[pool_0232729C]	; 02327294
	ldr r3,[pool_023272A0]	; 02327296
	bx r3	; 02327298
	.byte 0xC0, 0x46	; 0232729C
pool_0232729C:
loc_0232729C:
	.word 0x80000100	; 0232729C
pool_023272A0:
loc_023272A0:
	.word P1_OrSharedEventFlags + 1	; 023272A0

; ===== function loc_023272A4 =====
loc_023272A4:
	ldr r0,[pool_023272AC]	; 023272A4
	ldr r3,[pool_023272B0]	; 023272A6
	bx r3	; 023272A8
	.byte 0xC0, 0x46	; 023272AC
pool_023272AC:
loc_023272AC:
	.word 0x80000080	; 023272AC
pool_023272B0:
loc_023272B0:
	.word P1_OrSharedEventFlags + 1	; 023272B0

; ===== function loc_023272B4 =====
loc_023272B4:
	ldr r0,[pool_023272BC]	; 023272B4
	ldr r3,[pool_023272C0]	; 023272B6
	bx r3	; 023272B8
	.byte 0xC0, 0x46	; 023272BC
pool_023272BC:
loc_023272BC:
	.word 0x80000010	; 023272BC
pool_023272C0:
loc_023272C0:
	.word P1_OrSharedEventFlags + 1	; 023272C0

; ===== function loc_023272C4 =====
loc_023272C4:
	push {lr}	; 023272C4
	sub sp,#0x4	; 023272C6
	ldr r0,[pool_023272F8]	; 023272C8
	bl loc_02326CBC	; 023272CA
	cmp r0,#0x0	; 023272CE
	beq loc_023272DC	; 023272D0
	ldr r1,[pool_023272FC]	; 023272D2
	mov r0,#0x0	; 023272D4
	ldrsh r0,[r1,r0]	; 023272D6
	cmp r0,#0x1	; 023272D8
	bne loc_023272EA	; 023272DA
loc_023272DC:
	mov r0,#0x4	; 023272DC
	bl P1_OrSharedEventFlags	; 023272DE
	mov r0,#0x0	; 023272E2
	add sp,#0x4	; 023272E4
	pop {r3}	; 023272E6
	bx r3	; 023272E8
loc_023272EA:
	ldr r0,[pool_02327300]	; 023272EA
	bl P1_OrSharedEventFlags	; 023272EC
	mov r0,#0x1	; 023272F0
	add sp,#0x4	; 023272F2
	pop {r3}	; 023272F4
	bx r3	; 023272F6
pool_023272F8:
loc_023272F8:
	.word 0x027FFEC0	; 023272F8
pool_023272FC:
loc_023272FC:
	.word FirmwareBootInfoScratchAddress + BootInfoCardSecureDisableOffset	; 023272FC
pool_02327300:
loc_02327300:
	.word 0x80000020	; 02327300

; ===== function loc_02327304 =====
loc_02327304:
	push {lr}	; 02327304
	sub sp,#0x4	; 02327306
	ldr r0,[pool_0232732C]	; 02327308
	ldr r2,[r0,#0x0]	; 0232730A
	mov r0,#0x8	; 0232730C
	add r1,r2,#0x0	; 0232730E
	and r1,r0	; 02327310
	cmp r1,#0x0	; 02327312
	bne loc_02327324	; 02327314
	ldr r0,[pool_02327330]	; 02327316
	and r2,r0	; 02327318
	cmp r2,#0x0	; 0232731A
	beq loc_02327324	; 0232731C
	ldr r0,[pool_02327334]	; 0232731E
	bl P1_OrSharedEventFlags	; 02327320
loc_02327324:
	add sp,#0x4	; 02327324
	pop {r3}	; 02327326
	bx r3	; 02327328
	.byte 0xC0, 0x46	; 0232732C
pool_0232732C:
loc_0232732C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232732C
pool_02327330:
loc_02327330:
	.word 0x00000400	; 02327330
pool_02327334:
loc_02327334:
	.word 0x08000000	; 02327334

; ===== function loc_02327338 =====
loc_02327338:
	push {r4,lr}	; 02327338
	sub sp,#0x10	; 0232733A
	ldr r0,[pool_0232752C]	; 0232733C
	ldr r1,[r0,#0x20]	; 0232733E
	cmp r1,#0x8	; 02327340
	bls loc_02327346	; 02327342
	b loc_02327522	; 02327344
loc_02327346:
	add r1,r1,r1	; 02327346
P1_SwitchIndexPC_02327346:
	add r1,pc	; 02327348
	ldrh r1,[r1,#(P1_SwitchTable_02327346 - (P1_SwitchIndexPC_02327346 + 4))]	; 0232734A
	lsl r1,r1,#0x10	; 0232734C
	asr r1,r1,#0x10	; 0232734E
P1_SwitchTargetPC_02327346:
	add r1,pc	; 02327350
	bx r1	; 02327352
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02327346:
	.halfword (loc_02327522 + 1) - (P1_SwitchTargetPC_02327346 + 4)
	.halfword (loc_02327522 + 1) - (P1_SwitchTargetPC_02327346 + 4)
	.halfword (loc_02327366 + 1) - (P1_SwitchTargetPC_02327346 + 4)
	.halfword (loc_023273BE + 1) - (P1_SwitchTargetPC_02327346 + 4)
	.halfword (loc_0232740E + 1) - (P1_SwitchTargetPC_02327346 + 4)
	.halfword (loc_02327428 + 1) - (P1_SwitchTargetPC_02327346 + 4)
	.halfword (loc_0232743A + 1) - (P1_SwitchTargetPC_02327346 + 4)
	.halfword (loc_02327522 + 1) - (P1_SwitchTargetPC_02327346 + 4)
	.halfword (loc_0232748C + 1) - (P1_SwitchTargetPC_02327346 + 4)
P1_SwitchTable_02327346End:
loc_02327366:
	bl loc_02326E88	; 02327366
	bl loc_02326D54	; 0232736A
	bl loc_02326D38	; 0232736E
	mov r4,#0x0	; 02327372
	bl loc_02326CF8	; 02327374
	cmp r0,#0x0	; 02327378
	beq loc_0232738E	; 0232737A
	mov r0,#0x2	; 0232737C
	orr r4,r0	; 0232737E
	ldr r0,[pool_02327530]	; 02327380
	bl loc_02326CBC	; 02327382
	cmp r0,#0x0	; 02327386
	bne loc_0232738E	; 02327388
	mov r0,#0x4	; 0232738A
	orr r4,r0	; 0232738C
loc_0232738E:
	bl loc_023281B8	; 0232738E
	cmp r0,#0x0	; 02327392
	beq loc_023273A4	; 02327394
	mov r0,#0x1	; 02327396
	orr r4,r0	; 02327398
	ldr r2,[pool_02327534]	; 0232739A
	ldrb r1,[r2,#0x0]	; 0232739C
	bic r1,r0	; 0232739E
	orr r1,r0	; 023273A0
	strb r1,[r2,#0x0]	; 023273A2
loc_023273A4:
	bl loc_02326BE8	; 023273A4
	bl P1_Runtime_01FF8084	; 023273A8
	ldr r0,[pool_02327538]	; 023273AC
	orr r4,r0	; 023273AE
	add r0,r4,#0x0	; 023273B0
	bl P1_OrSharedEventFlags	; 023273B2
	mov r1,#0x3	; 023273B6
	ldr r0,[pool_0232752C]	; 023273B8
	str r1,[r0,#0x20]	; 023273BA
	b loc_02327522	; 023273BC
loc_023273BE:
	ldr r3,[pool_0232753C]	; 023273BE
	ldr r2,[r3,#0x0]	; 023273C0
	ldr r1,[pool_02327540]	; 023273C2
	and r2,r1	; 023273C4
	cmp r2,#0x0	; 023273C6
	bne loc_023273CC	; 023273C8
	b loc_02327522	; 023273CA
loc_023273CC:
	ldr r2,[r3,#0x0]	; 023273CC
	mov r1,#0x20	; 023273CE
	and r2,r1	; 023273D0
	cmp r2,#0x0	; 023273D2
	beq loc_023273E4	; 023273D4
	mov r0,#0x3	; 023273D6
	bl loc_02326D28	; 023273D8
	mov r1,#0x4	; 023273DC
	ldr r0,[pool_0232752C]	; 023273DE
	str r1,[r0,#0x20]	; 023273E0
	b loc_02327522	; 023273E2
loc_023273E4:
	ldr r2,[r3,#0x0]	; 023273E4
	mov r1,#0x10	; 023273E6
	and r2,r1	; 023273E8
	cmp r2,#0x0	; 023273EA
	beq loc_023273F4	; 023273EC
	mov r1,#0x5	; 023273EE
	str r1,[r0,#0x20]	; 023273F0
	b loc_02327522	; 023273F2
loc_023273F4:
	ldr r1,[r3,#0x0]	; 023273F4
	ldr r0,[pool_02327544]	; 023273F6
	and r1,r0	; 023273F8
	cmp r1,#0x0	; 023273FA
	bne loc_02327400	; 023273FC
	b loc_02327522	; 023273FE
loc_02327400:
	mov r0,#0x6	; 02327400
	bl loc_02326D28	; 02327402
	mov r1,#0x6	; 02327406
	ldr r0,[pool_0232752C]	; 02327408
	str r1,[r0,#0x20]	; 0232740A
	b loc_02327522	; 0232740C
loc_0232740E:
	ldr r0,[pool_02327548]	; 0232740E
	bl loc_02327180	; 02327410
	cmp r0,#0x0	; 02327414
	bne loc_0232741A	; 02327416
	b loc_02327522	; 02327418
loc_0232741A:
	bl loc_02327198	; 0232741A
	mov r0,#0x1	; 0232741E
	add sp,#0x10	; 02327420
	pop {r4}	; 02327422
	pop {r3}	; 02327424
	bx r3	; 02327426
loc_02327428:
	ldr r0,[r0,#0x24]	; 02327428
	cmp r0,#0x2	; 0232742A
	bne loc_02327522	; 0232742C
	mov r0,#0x4	; 0232742E
	bl loc_02326D28	; 02327430
	bl loc_02326FA0	; 02327434
	b loc_02327522	; 02327438
loc_0232743A:
	ldr r0,[pool_0232753C]	; 0232743A
	ldr r1,[r0,#0x0]	; 0232743C
	ldr r0,[pool_0232754C]	; 0232743E
	and r1,r0	; 02327440
	cmp r1,#0x0	; 02327442
	beq loc_02327522	; 02327444
	bl P1_DecompressAndCheckP3P4	; 02327446
	ldr r0,[pool_02327550]	; 0232744A
	bl P1_OrSharedEventFlags	; 0232744C
	mov r0,#0x0	; 02327450
	str r0,[sp,#0x4]	; 02327452
	ldr r0,[sp,#0x4]	; 02327454
	ldr r1,[pool_02327554]	; 02327456
	ldr r2,[pool_02327558]	; 02327458
	blx loc_0232E344	; 0232745A
; 按此版本的零区起点和字节数清零，SWI 参数换算为 32 位字数。
; Clear this version's zero area; convert its byte size to the SWI word count.
	ldr r2,[pool_0232755C]	; 0232745E
	cmp r2,#0x0	; 02327460
	beq loc_0232747A	; 02327462
	mov r0,#0x0	; 02327464
	str r0,[sp,#0x0]	; 02327466
	add r0,sp,#0x0	; 02327468
	ldr r1,[pool_02327560]	; 0232746A
	lsr r2,r2,#0x2	; 0232746C
	ldr r3,[pool_02327564]	; 0232746E
	and r2,r3	; 02327470
	ldr r3,[pool_02327568]	; 02327472
	orr r2,r3	; 02327474
	bl loc_0232C3F6	; 02327476
loc_0232747A:
	blx P1_CleanEntireDataCacheByIndex	; 0232747A
	mov r0,#0x7	; 0232747E
	bl loc_02326D28	; 02327480
	mov r1,#0x8	; 02327484
	ldr r0,[pool_0232752C]	; 02327486
	str r1,[r0,#0x20]	; 02327488
	b loc_02327522	; 0232748A
loc_0232748C:
	ldr r0,[pool_0232753C]	; 0232748C
	ldr r2,[r0,#0x0]	; 0232748E
	ldr r1,[pool_0232756C]	; 02327490
	and r2,r1	; 02327492
	cmp r2,#0x0	; 02327494
	beq loc_02327522	; 02327496
	ldr r2,[r0,#0x0]	; 02327498
	ldr r1,[pool_02327570]	; 0232749A
	and r2,r1	; 0232749C
	cmp r2,#0x0	; 0232749E
	beq loc_02327522	; 023274A0
	ldr r2,[r0,#0x0]	; 023274A2
	mov r1,#0x80	; 023274A4
	and r2,r1	; 023274A6
	cmp r2,#0x0	; 023274A8
	beq loc_023274B6	; 023274AA
	ldr r0,[pool_02327574]	; 023274AC
	ldr r0,[r0,#0x0]	; 023274AE
	ldr r0,[r0,#0x0]	; 023274B0
	blx r0	; 023274B2
	b loc_02327518	; 023274B4
loc_023274B6:
	ldr r2,[r0,#0x0]	; 023274B6
	ldr r1,[pool_02327578]	; 023274B8
	and r2,r1	; 023274BA
	cmp r2,#0x0	; 023274BC
	beq loc_02327506	; 023274BE
	ldr r1,[r0,#0x0]	; 023274C0
	mov r0,#0x2	; 023274C2
	and r1,r0	; 023274C4
	cmp r1,#0x0	; 023274C6
	beq loc_023274CE	; 023274C8
	mov r0,#0x1	; 023274CA
	b loc_023274D0	; 023274CC
loc_023274CE:
	mov r0,#0x0	; 023274CE
loc_023274D0:
	cmp r0,#0x0	; 023274D0
	beq loc_023274F4	; 023274D2
	ldr r0,[pool_0232752C]	; 023274D4
	ldr r1,[r0,#0x0]	; 023274D6
	ldr r0,[pool_0232757C]	; 023274D8
	str r1,[r0,#0x0]	; 023274DA
	ldr r0,[pool_02327580]	; 023274DC
	ldr r1,[pool_02327584]	; 023274DE
	ldr r2,[pool_02327588]	; 023274E0
	blx loc_0232E390	; 023274E2
	mov r0,#0x0	; 023274E6
	str r0,[sp,#0x8]	; 023274E8
	ldr r0,[sp,#0x8]	; 023274EA
	ldr r1,[pool_02327580]	; 023274EC
	ldr r2,[pool_02327588]	; 023274EE
	blx loc_0232E344	; 023274F0
loc_023274F4:
	ldr r0,[pool_02327574]	; 023274F4
	ldr r0,[r0,#0x0]	; 023274F6
	ldr r0,[r0,#0x4]	; 023274F8
	blx r0	; 023274FA
	blx P1_CleanEntireDataCacheByIndex	; 023274FC
	bl loc_02327198	; 02327500
	b loc_02327518	; 02327504
loc_02327506:
	ldr r1,[r0,#0x0]	; 02327506
	mov r0,#0x40	; 02327508
	and r1,r0	; 0232750A
	cmp r1,#0x0	; 0232750C
	beq loc_02327518	; 0232750E
	ldr r0,[pool_02327574]	; 02327510
	ldr r0,[r0,#0x0]	; 02327512
	ldr r0,[r0,#0x8]	; 02327514
	blx r0	; 02327516
loc_02327518:
	mov r0,#0x1	; 02327518
	add sp,#0x10	; 0232751A
	pop {r4}	; 0232751C
	pop {r3}	; 0232751E
	bx r3	; 02327520
loc_02327522:
	mov r0,#0x0	; 02327522
	add sp,#0x10	; 02327524
	pop {r4}	; 02327526
	pop {r3}	; 02327528
	bx r3	; 0232752A
pool_0232752C:
loc_0232752C:
	.word FirmwareBootSharedAddress	; 0232752C
pool_02327530:
loc_02327530:
	.word 0x027FFEC0	; 02327530
pool_02327534:
loc_02327534:
	.word FirmwareBootInfoAddress + BootInfoGbaFlagsOffset	; 02327534
pool_02327538:
loc_02327538:
	.word 0x20000000	; 02327538
pool_0232753C:
loc_0232753C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232753C
pool_02327540:
loc_02327540:
	.word 0x80000000	; 02327540
pool_02327544:
loc_02327544:
	.word 0x000001C0	; 02327544
pool_02327548:
loc_02327548:
	.word 0x00000200	; 02327548
pool_0232754C:
loc_0232754C:
	.word 0x00001000	; 0232754C
pool_02327550:
loc_02327550:
	.word 0x00000400	; 02327550
pool_02327554:
loc_02327554:
	.word 0x02000000	; 02327554
pool_02327558:
loc_02327558:
	.word 0x00300000	; 02327558
pool_0232755C:
loc_0232755C:
	.word UiBootZeroBytes	; 0232755C
pool_02327560:
loc_02327560:
	.word UiBootZeroStart	; 02327560
pool_02327564:
loc_02327564:
	.word 0x001FFFFF	; 02327564
pool_02327568:
loc_02327568:
	.word 0x01000000	; 02327568
pool_0232756C:
loc_0232756C:
	.word 0x40000000	; 0232756C
pool_02327570:
loc_02327570:
	.word 0x08000000	; 02327570
pool_02327574:
loc_02327574:
	.word P1_BssStart + 0x24E28	; 02327574
pool_02327578:
loc_02327578:
	.word 0x00000100	; 02327578
pool_0232757C:
loc_0232757C:
	.word NdsCartHeaderArm7RamAddress	; 0232757C
pool_02327580:
loc_02327580:
	.word 0x027FFE00	; 02327580
pool_02327584:
loc_02327584:
	.word 0x023FE940	; 02327584
pool_02327588:
loc_02327588:
	.word 0x00000160	; 02327588

; ===== function loc_0232758C =====
loc_0232758C:
	push {r4,r5,r6,r7,lr}	; 0232758C
	sub sp,#0x4	; 0232758E
	ldr r4,[pool_023275DC]	; 02327590
	ldr r6,[pool_023275E0]	; 02327592
	ldr r7,[pool_023275E4]	; 02327594
loc_02327596:
	ldr r5,[r6,#0x0]	; 02327596
	ldr r0,[pool_023275E8]	; 02327598
	bl loc_0232C3D4	; 0232759A
	add r0,r5,#0x0	; 0232759E
	and r0,r4	; 023275A0
	cmp r0,#0x0	; 023275A2
	bne loc_023275B8	; 023275A4
	and r5,r7	; 023275A6
	cmp r5,#0x0	; 023275A8
	beq loc_02327596	; 023275AA
	bl P1_DecompressAndCheckP5	; 023275AC
	add r0,r4,#0x0	; 023275B0
	bl P1_OrSharedEventFlags	; 023275B2
	b loc_02327596	; 023275B6
loc_023275B8:
	mov r1,#0x2	; 023275B8
	ldr r0,[pool_023275EC]	; 023275BA
	str r1,[r0,#0x0]	; 023275BC
	ldr r2,[pool_023275F0]	; 023275BE
	ldrh r1,[r2,#0x0]	; 023275C0
	mov r0,#0x1	; 023275C2
	orr r1,r0	; 023275C4
	strh r1,[r2,#0x0]	; 023275C6
	bl loc_02327968	; 023275C8
	bl loc_02326DB4	; 023275CC
	mov r0,#0x0	; 023275D0
	add sp,#0x4	; 023275D2
	pop {r4,r5,r6,r7}	; 023275D4
	pop {r3}	; 023275D6
	bx r3	; 023275D8
	.byte 0xC0, 0x46	; 023275DC
pool_023275DC:
loc_023275DC:
	.word 0x00000800	; 023275DC
pool_023275E0:
loc_023275E0:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023275E0
pool_023275E4:
loc_023275E4:
	.word 0x00002000	; 023275E4
pool_023275E8:
loc_023275E8:
	.word 0x00001000	; 023275E8
pool_023275EC:
loc_023275EC:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 023275EC
pool_023275F0:
loc_023275F0:
	.word REG_POSTFLG	; 023275F0

; ===== function P1_ClipMemoryRangeToBounds =====
; Rejects a (start,length) range outside the supplied bounds; trims a range that crosses the upper bound.
; 将越出给定边界的（起始地址、长度）范围置零；超过上界时截短长度。
.func P1_ClipMemoryRangeToBounds
loc_023275F4:
	push {r4,r5}	; 023275F4
	ldr r5,[r0,#0x0]	; 023275F6
	ldr r3,[r0,#0x4]	; 023275F8
	add r4,r5,r3	; 023275FA
	cmp r5,r1	; 023275FC
	bcc loc_02327604	; 023275FE
	cmp r5,r2	; 02327600
	bls loc_0232760C	; 02327602
loc_02327604:
	mov r1,#0x0	; 02327604
	str r1,[r0,#0x4]	; 02327606
	pop {r4,r5}	; 02327608
	bx lr	; 0232760A
loc_0232760C:
	cmp r4,r2	; 0232760C
	bls loc_0232761A	; 0232760E
	add r3,r0,#0x4	; 02327610
	ldr r1,[r3,#0x0]	; 02327612
	sub r0,r4,r2	; 02327614
	sub r0,r1,r0	; 02327616
	str r0,[r3,#0x0]	; 02327618
loc_0232761A:
	pop {r4,r5}	; 0232761A
	bx lr	; 0232761C
.endfunc
	.byte 0x00, 0x00	; 02327620

; ===== function P1_ConstrainNdsHeaderImageLoadRanges =====
; Constrains ARM7/ARM9 image load ranges recorded in the copied NDS card header before boot.
; 启动前约束复制到 RAM 的 NDS 卡带头内 ARM7/ARM9 映像装载范围。
.func P1_ConstrainNdsHeaderImageLoadRanges
loc_02327620:
	push {lr}	; 02327620
	sub sp,#0x4	; 02327622
	bl loc_02326CF8	; 02327624
	cmp r0,#0x0	; 02327628
	beq loc_0232768C	; 0232762A
	ldr r0,[pool_02327694]	; 0232762C
	ldr r2,[r0,#0x0]	; 0232762E
	ldr r1,[pool_02327698]	; 02327630
	cmp r2,r1	; 02327632
	bcc loc_0232764A	; 02327634
	ldr r2,[pool_0232769C]	; 02327636
	bl P1_ClipMemoryRangeToBounds	; 02327638
	ldr r2,[pool_02327694]	; 0232763C
	ldr r1,[r2,#0x0]	; 0232763E
	ldr r0,[pool_023276A0]	; 02327640
	str r1,[r0,#0x0]	; 02327642
	ldr r0,[pool_023276A4]	; 02327644
	str r0,[r2,#0x0]	; 02327646
	b loc_02327682	; 02327648
loc_0232764A:
	ldr r1,[pool_023276A8]	; 0232764A
	ldr r2,[pool_023276AC]	; 0232764C
	bl P1_ClipMemoryRangeToBounds	; 0232764E
	ldr r1,[pool_02327694]	; 02327652
	ldr r3,[r1,#0x0]	; 02327654
	ldr r0,[pool_023276B0]	; 02327656
	cmp r3,r0	; 02327658
	bcc loc_02327672	; 0232765A
	ldr r0,[pool_023276A0]	; 0232765C
	str r3,[r0,#0x0]	; 0232765E
	ldr r0,[pool_023276A4]	; 02327660
	str r0,[r1,#0x0]	; 02327662
	ldr r2,[pool_023276B4]	; 02327664
	ldr r1,[r2,#0x0]	; 02327666
	ldr r0,[pool_023276B8]	; 02327668
	cmp r1,r0	; 0232766A
	bls loc_02327682	; 0232766C
	str r0,[r2,#0x0]	; 0232766E
	b loc_02327682	; 02327670
loc_02327672:
	ldr r2,[pool_023276B4]	; 02327672
	ldr r1,[r2,#0x0]	; 02327674
	add r3,r3,r1	; 02327676
	cmp r3,r0	; 02327678
	bls loc_02327682	; 0232767A
	sub r0,r3,r0	; 0232767C
	sub r0,r1,r0	; 0232767E
	str r0,[r2,#0x0]	; 02327680
loc_02327682:
	ldr r0,[pool_023276BC]	; 02327682
	ldr r1,[pool_023276A8]	; 02327684
	ldr r2,[pool_023276A4]	; 02327686
	bl P1_ClipMemoryRangeToBounds	; 02327688
loc_0232768C:
	add sp,#0x4	; 0232768C
	pop {r3}	; 0232768E
	bx r3	; 02327690
.endfunc
	.byte 0xC0, 0x46	; 02327694
pool_02327694:
loc_02327694:
	.word NdsCartHeaderArm7RamAddress	; 02327694
pool_02327698:
loc_02327698:
	.word Arm7SharedWramStart	; 02327698
pool_0232769C:
loc_0232769C:
	.word Arm7FirmwareReservedWramStart	; 0232769C
pool_023276A0:
loc_023276A0:
	.word FirmwareBootSharedAddress	; 023276A0
pool_023276A4:
loc_023276A4:
	.word 0x022C0000	; 023276A4
pool_023276A8:
loc_023276A8:
	.word 0x02000000	; 023276A8
pool_023276AC:
loc_023276AC:
	.word 0x023FE000	; 023276AC
pool_023276B0:
loc_023276B0:
	.word 0x02300000	; 023276B0
pool_023276B4:
loc_023276B4:
	.word NdsCartHeaderArm7SizeAddress	; 023276B4
pool_023276B8:
loc_023276B8:
	.word 0x00040000	; 023276B8
pool_023276BC:
loc_023276BC:
	.word NdsCartHeaderArm9RamAddress	; 023276BC

; ===== function loc_023276C0 =====
loc_023276C0:
	push {r4,lr}	; 023276C0
	sub sp,#0x8	; 023276C2
	add r4,r0,#0x0	; 023276C4
	ldr r2,[pool_02327738]	; 023276C6
	ldrh r1,[r2,#0x0]	; 023276C8
	ldr r0,[pool_0232773C]	; 023276CA
	orr r1,r0	; 023276CC
	strh r1,[r2,#0x0]	; 023276CE
	ldrh r1,[r2,#0x0]	; 023276D0
	mov r0,#0xc	; 023276D2
	bic r1,r0	; 023276D4
	strh r1,[r2,#0x0]	; 023276D6
	ldrh r1,[r2,#0x0]	; 023276D8
	mov r0,#0x10	; 023276DA
	bic r1,r0	; 023276DC
	strh r1,[r2,#0x0]	; 023276DE
	mov r0,#0x3	; 023276E0
	bl loc_0232E1C0	; 023276E2
	ldr r0,[pool_02327740]	; 023276E6
	ldr r1,[pool_02327744]	; 023276E8
	blx P1_InvalidateDataCacheRange	; 023276EA
	mov r0,#0x0	; 023276EE
	str r0,[sp,#0x0]	; 023276F0
	add r0,sp,#0x0	; 023276F2
	ldr r1,[pool_02327748]	; 023276F4
	ldr r2,[pool_0232774C]	; 023276F6
	bl loc_0232C3F6	; 023276F8
	ldr r0,[pool_02327750]	; 023276FC
	str r4,[r0,#0x0]	; 023276FE
	mov r1,#0x1	; 02327700
	ldr r0,[pool_02327754]	; 02327702
	str r1,[r0,#0x0]	; 02327704
	bl P1_ConstrainNdsHeaderImageLoadRanges	; 02327706
	bl loc_02326BAC	; 0232770A
	ldr r0,[pool_02327758]	; 0232770E
	add r0,#0x19	; 02327710
	mov r1,#0x0	; 02327712
	mov r2,#0x37	; 02327714
	blx loc_0232E3C8	; 02327716
	ldr r1,[pool_0232775C]	; 0232771A
	mov r0,#0x0	; 0232771C
	ldrsh r0,[r1,r0]	; 0232771E
	cmp r0,#0x0	; 02327720
	bne loc_0232772E	; 02327722
	ldr r2,[pool_02327760]	; 02327724
	ldr r1,[r2,#0x0]	; 02327726
	ldr r0,[pool_02327764]	; 02327728
	orr r1,r0	; 0232772A
	str r1,[r2,#0x0]	; 0232772C
loc_0232772E:
	add sp,#0x8	; 0232772E
	pop {r4}	; 02327730
	pop {r3}	; 02327732
	bx r3	; 02327734
	.byte 0xC0, 0x46	; 02327738
pool_02327738:
loc_02327738:
	.word REG_EXMEMCNT_ARM9	; 02327738
pool_0232773C:
loc_0232773C:
	.word 0x00008000	; 0232773C
pool_02327740:
loc_02327740:
	.word 0x022C0000	; 02327740
pool_02327744:
loc_02327744:
	.word 0x00040000	; 02327744
pool_02327748:
loc_02327748:
	.word 0x027FF860	; 02327748
pool_0232774C:
loc_0232774C:
	.word 0x0100001B	; 0232774C
pool_02327750:
loc_02327750:
	.word P1_BssStart + 0x24E28	; 02327750
pool_02327754:
loc_02327754:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 02327754
pool_02327758:
loc_02327758:
	.word 0x027FF800	; 02327758
pool_0232775C:
loc_0232775C:
	.word FirmwareBootInfoScratchAddress + BootInfoHasSerialDebuggerOffset	; 0232775C
pool_02327760:
loc_02327760:
	.word NdsCartHeaderRamAddress + 0x60	; 02327760
pool_02327764:
loc_02327764:
	.word 0x00406000	; 02327764

; ===== function loc_02327768 =====
loc_02327768:
	push {r4,r5}	; 02327768
	mov r2,#0x80	; 0232776A
	ldr r1,[pool_02327798]	; 0232776C
	strb r2,[r1,#0x0]	; 0232776E
	mov r2,#0x0	; 02327770
	ldr r1,[pool_0232779C]	; 02327772
	mov r3,#0x1	; 02327774
loc_02327776:
	sub r4,r3,r2	; 02327776
	lsl r4,r4,#0x2	; 02327778
	ldr r5,[r0,r4]	; 0232777A
	lsr r4,r5,#0x18	; 0232777C
	strb r4,[r1,#0x0]	; 0232777E
	lsr r4,r5,#0x10	; 02327780
	strb r4,[r1,#0x1]	; 02327782
	lsr r4,r5,#0x8	; 02327784
	strb r4,[r1,#0x2]	; 02327786
	strb r5,[r1,#0x3]	; 02327788
	add r1,r1,#0x4	; 0232778A
	add r2,r2,#0x1	; 0232778C
	cmp r2,#0x2	; 0232778E
	blt loc_02327776	; 02327790
	pop {r4,r5}	; 02327792
	bx lr	; 02327794
	.byte 0xC0, 0x46	; 02327798
pool_02327798:
loc_02327798:
	.word REG_AUXSPICNT + 1	; 02327798
pool_0232779C:
loc_0232779C:
	.word REG_GCCMDOUT	; 0232779C

; ===== function loc_023277A0 =====
loc_023277A0:
	push {r4,r5,r6,r7,lr}	; 023277A0
	sub sp,#0xc	; 023277A2
	add r5,r1,#0x0	; 023277A4
	add r4,r2,#0x0	; 023277A6
	lsl r1,r0,#0x18	; 023277A8
	str r1,[sp,#0x0]	; 023277AA
	lsr r1,r0,#0x8	; 023277AC
	ldr r0,[pool_023277F0]	; 023277AE
	orr r1,r0	; 023277B0
	str r1,[sp,#0x4]	; 023277B2
	add r0,sp,#0x0	; 023277B4
	bl loc_02327768	; 023277B6
	ldr r0,[pool_023277F4]	; 023277BA
	ldr r1,[r0,#0x0]	; 023277BC
	ldr r0,[pool_023277F8]	; 023277BE
	orr r1,r0	; 023277C0
	ldr r0,[pool_023277FC]	; 023277C2
	str r1,[r0,#0x0]	; 023277C4
	add r2,r5,r4	; 023277C6
	ldr r7,[pool_02327800]	; 023277C8
	ldr r3,[pool_02327804]	; 023277CA
	ldr r4,[pool_02327808]	; 023277CC
loc_023277CE:
	ldr r1,[r0,#0x0]	; 023277CE
	add r6,r1,#0x0	; 023277D0
	and r6,r4	; 023277D2
	cmp r6,#0x0	; 023277D4
	beq loc_023277E2	; 023277D6
	ldr r6,[r7,#0x0]	; 023277D8
	cmp r5,r2	; 023277DA
	bcs loc_023277E0	; 023277DC
	str r6,[r5,#0x0]	; 023277DE
loc_023277E0:
	add r5,r5,#0x4	; 023277E0
loc_023277E2:
	and r1,r3	; 023277E2
	cmp r1,#0x0	; 023277E4
	bne loc_023277CE	; 023277E6
	add sp,#0xc	; 023277E8
	pop {r4,r5,r6,r7}	; 023277EA
	pop {r3}	; 023277EC
	bx r3	; 023277EE
pool_023277F0:
loc_023277F0:
	.word 0xB7000000	; 023277F0
pool_023277F4:
loc_023277F4:
	.word NdsCartHeaderRamAddress + 0x60	; 023277F4
pool_023277F8:
loc_023277F8:
	.word 0xA1000000	; 023277F8
pool_023277FC:
loc_023277FC:
	.word REG_ROMCTRL	; 023277FC
pool_02327800:
loc_02327800:
	.word REG_GCDATAIN	; 02327800
pool_02327804:
loc_02327804:
	.word 0x80000000	; 02327804
pool_02327808:
loc_02327808:
	.word 0x00800000	; 02327808

; ===== function loc_0232780C =====
loc_0232780C:
	push {r4,r5,r6,r7,lr}	; 0232780C
	sub sp,#0x4	; 0232780E
	add r6,r0,#0x0	; 02327810
	add r7,r1,#0x0	; 02327812
	add r5,r2,#0x0	; 02327814
	add r4,r5,#0x0	; 02327816
	cmp r5,#0x0	; 02327818
	ble loc_0232783C	; 0232781A
loc_0232781C:
	ldr r0,[pool_02327844]	; 0232781C
	cmp r4,r0	; 0232781E
	blt loc_02327826	; 02327820
	lsl r5,r0,#0	; 02327822
	b loc_02327828	; 02327824
loc_02327826:
	add r5,r4,#0x0	; 02327826
loc_02327828:
	add r0,r6,#0x0	; 02327828
	add r1,r7,#0x0	; 0232782A
	add r2,r5,#0x0	; 0232782C
	bl loc_023277A0	; 0232782E
	add r6,r6,r5	; 02327832
	add r7,r7,r5	; 02327834
	sub r4,r4,r5	; 02327836
	cmp r4,#0x0	; 02327838
	bgt loc_0232781C	; 0232783A
loc_0232783C:
	add sp,#0x4	; 0232783C
	pop {r4,r5,r6,r7}	; 0232783E
	pop {r3}	; 02327840
	bx r3	; 02327842
pool_02327844:
loc_02327844:
	.word 0x00000200	; 02327844

; ===== function loc_02327848 =====
loc_02327848:
	push {lr}	; 02327848
	sub sp,#0xc	; 0232784A
	mov r0,#0x0	; 0232784C
	str r0,[sp,#0x0]	; 0232784E
	ldr r0,[pool_0232786C]	; 02327850
	str r0,[sp,#0x4]	; 02327852
	add r0,sp,#0x0	; 02327854
	bl loc_02327768	; 02327856
	ldr r0,[pool_02327870]	; 0232785A
	ldr r1,[r0,#0x4]	; 0232785C
	ldr r0,[pool_02327874]	; 0232785E
	orr r1,r0	; 02327860
	ldr r0,[pool_02327878]	; 02327862
	str r1,[r0,#0x0]	; 02327864
	add sp,#0xc	; 02327866
	pop {r3}	; 02327868
	bx r3	; 0232786A
pool_0232786C:
loc_0232786C:
	.word 0xB8000000	; 0232786C
pool_02327870:
loc_02327870:
	.word P1_BssStart + 0x25740	; 02327870
pool_02327874:
loc_02327874:
	.word 0xA7000000	; 02327874
pool_02327878:
loc_02327878:
	.word REG_ROMCTRL	; 02327878

; ===== function loc_0232787C =====
loc_0232787C:
	ldr r0,[pool_02327890]	; 0232787C
	ldr r1,[r0,#0x0]	; 0232787E
	ldr r0,[pool_02327894]	; 02327880
	and r1,r0	; 02327882
	cmp r1,#0x0	; 02327884
	beq loc_0232788C	; 02327886
	mov r0,#0x1	; 02327888
	bx lr	; 0232788A
loc_0232788C:
	mov r0,#0x0	; 0232788C
	bx lr	; 0232788E
pool_02327890:
loc_02327890:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327890
pool_02327894:
loc_02327894:
	.word 0x00000200	; 02327894

; ===== function loc_02327898 =====
loc_02327898:
	ldr r0,[pool_023278A8]	; 02327898
	ldr r0,[r0,#0x0]	; 0232789A
	cmp r0,#0x1	; 0232789C
	bne loc_023278A4	; 0232789E
	mov r0,#0x1	; 023278A0
	bx lr	; 023278A2
loc_023278A4:
	mov r0,#0x0	; 023278A4
	bx lr	; 023278A6
pool_023278A8:
loc_023278A8:
	.word P1_BssStart + 0x25740	; 023278A8

; ===== function loc_023278AC =====
loc_023278AC:
	push {lr}	; 023278AC
	sub sp,#0x4	; 023278AE
	bl loc_02327898	; 023278B0
	cmp r0,#0x0	; 023278B4
	beq loc_023278C4	; 023278B6
loc_023278B8:
	bl loc_023278CC	; 023278B8
	bl loc_02327898	; 023278BC
	cmp r0,#0x0	; 023278C0
	bne loc_023278B8	; 023278C2
loc_023278C4:
	add sp,#0x4	; 023278C4
	pop {r3}	; 023278C6
	bx r3	; 023278C8
	.byte 0x00, 0x00	; 023278CC

; ===== function loc_023278CC =====
loc_023278CC:
	push {lr}	; 023278CC
	sub sp,#0x4	; 023278CE
	bl loc_0232787C	; 023278D0
	cmp r0,#0x0	; 023278D4
	bne loc_023278E0	; 023278D6
	mov r0,#0x0	; 023278D8
	add sp,#0x4	; 023278DA
	pop {r3}	; 023278DC
	bx r3	; 023278DE
loc_023278E0:
	ldr r0,[pool_02327950]	; 023278E0
	ldr r1,[r0,#0x0]	; 023278E2
	cmp r1,#0x0	; 023278E4
	beq loc_023278EE	; 023278E6
	cmp r1,#0x1	; 023278E8
	beq loc_02327904	; 023278EA
	b loc_02327946	; 023278EC
loc_023278EE:
	ldrh r0,[r0,#0x8]	; 023278EE
	bl loc_0232AF0C	; 023278F0
	cmp r0,#0x0	; 023278F4
	bne loc_02327946	; 023278F6
	bl loc_02327848	; 023278F8
	mov r1,#0x1	; 023278FC
	ldr r0,[pool_02327950]	; 023278FE
	str r1,[r0,#0x0]	; 02327900
	b loc_02327946	; 02327902
loc_02327904:
	ldr r0,[pool_02327954]	; 02327904
	ldr r1,[r0,#0x0]	; 02327906
	ldr r0,[pool_02327958]	; 02327908
	and r1,r0	; 0232790A
	cmp r1,#0x0	; 0232790C
	beq loc_02327946	; 0232790E
	ldr r0,[pool_0232795C]	; 02327910
	ldr r1,[r0,#0x0]	; 02327912
	ldr r0,[pool_02327960]	; 02327914
	ldr r0,[r0,#0x0]	; 02327916
	cmp r1,r0	; 02327918
	beq loc_02327938	; 0232791A
	ldr r0,[pool_02327964]	; 0232791C
	ldr r1,[r0,#0x0]	; 0232791E
	mov r0,#0x2	; 02327920
	and r1,r0	; 02327922
	cmp r1,#0x0	; 02327924
	beq loc_0232792C	; 02327926
	mov r0,#0x1	; 02327928
	b loc_0232792E	; 0232792A
loc_0232792C:
	mov r0,#0x0	; 0232792C
loc_0232792E:
	cmp r0,#0x0	; 0232792E
	beq loc_02327938	; 02327930
	mov r1,#0x1	; 02327932
	ldr r0,[pool_02327950]	; 02327934
	strh r1,[r0,#0xa]	; 02327936
loc_02327938:
	ldr r0,[pool_02327950]	; 02327938
	ldrh r0,[r0,#0x8]	; 0232793A
	bl loc_0232AF20	; 0232793C
	mov r1,#0x0	; 02327940
	ldr r0,[pool_02327950]	; 02327942
	str r1,[r0,#0x0]	; 02327944
loc_02327946:
	ldr r0,[pool_02327950]	; 02327946
	ldrh r0,[r0,#0xa]	; 02327948
	add sp,#0x4	; 0232794A
	pop {r3}	; 0232794C
	bx r3	; 0232794E
pool_02327950:
loc_02327950:
	.word P1_BssStart + 0x25740	; 02327950
pool_02327954:
loc_02327954:
	.word REG_ROMCTRL	; 02327954
pool_02327958:
loc_02327958:
	.word 0x00800000	; 02327958
pool_0232795C:
loc_0232795C:
	.word REG_GCDATAIN	; 0232795C
pool_02327960:
loc_02327960:
	.word FirmwareBootInfoScratchAddress	; 02327960
pool_02327964:
loc_02327964:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327964

; ===== function loc_02327968 =====
loc_02327968:
	push {lr}	; 02327968
	sub sp,#0x4	; 0232796A
	blx loc_0232AE48	; 0232796C
	ldr r1,[pool_02327980]	; 02327970
	strh r0,[r1,#0x8]	; 02327972
	ldr r0,[pool_02327984]	; 02327974
	ldr r0,[r0,#0x0]	; 02327976
	str r0,[r1,#0x4]	; 02327978
	add sp,#0x4	; 0232797A
	pop {r3}	; 0232797C
	bx r3	; 0232797E
pool_02327980:
loc_02327980:
	.word P1_BssStart + 0x25740	; 02327980
pool_02327984:
loc_02327984:
	.word NdsCartHeaderRamAddress + 0x60	; 02327984
.arm
	mov r0,#0x0	; 02327988
	mcr p15,0x0,r0,c7,c6,0x0	; 0232798C
	ldr r1,[pool_02327A08]	; 02327990
loc_02327994:
	ldrh r0,[r1,#0x0]	; 02327994
	and r0,r0,#0xf	; 02327998
	cmp r0,#0x2	; 0232799C
	bne loc_02327994	; 023279A0
	mov r0,#0x200	; 023279A4
	strh r0,[r1,#0x0]	; 023279A8
	ldr r1,[pool_02327A08]	; 023279AC
loc_023279B0:
	ldrh r0,[r1,#0x0]	; 023279B0
	and r0,r0,#0xf	; 023279B4
	cmp r0,#0x1	; 023279B8
	bne loc_023279B0	; 023279BC
	mov r0,#0x100	; 023279C0
	strh r0,[r1,#0x0]	; 023279C4
	bl loc_02327A3C	; 023279C8
	bl loc_02327A14	; 023279CC
	ldr r1,[pool_02327A08]	; 023279D0
loc_023279D4:
	ldrh r0,[r1,#0x0]	; 023279D4
	and r0,r0,#0xf	; 023279D8
	cmp r0,#0x1	; 023279DC
	beq loc_023279D4	; 023279E0
	mov r0,#0x0	; 023279E4
	strh r0,[r1,#0x0]	; 023279E8
	ldr r3,[pool_02327A0C]	; 023279EC
	ldr r12,[r3,#-0x1dc]	; 023279F0
	mov lr,r12	; 023279F4
	ldr r11,[pool_02327A10]	; 023279F8
	ldmia r11,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10}	; 023279FC
	mov r11,#0x0	; 02327A00
	bx r12	; 02327A04
pool_02327A08:
loc_02327A08:
	.word REG_IPC_SYNC	; 02327A08
pool_02327A0C:
loc_02327A0C:
; 基准为头部 RAM 视图 +0x200；负偏移实际读取 ARM9/ARM7 入口字段。
; Addressing anchor: the negative offset above reads the ARM9/ARM7 entry field.
	.word NdsCartHeaderRamAddress + 0x200	; 02327A0C
pool_02327A10:
loc_02327A10:
	.word P1_DtcmRuntimeStart	; 02327A10

; ===== function loc_02327A14 =====
loc_02327A14:
	ldr r0,[pool_02327A38]	; 02327A14
	mcr p15,0x0,r0,c1,c0,0x0	; 02327A18
	mov r0,#0x0	; 02327A1C
	mcr p15,0x0,r0,c6,c5,0x0	; 02327A20
	mov r0,#0x0	; 02327A24
	mcr p15,0x0,r0,c7,c5,0x0	; 02327A28
	mcr p15,0x0,r0,c7,c6,0x0	; 02327A2C
	mcr p15,0x0,r0,c7,c10,0x4	; 02327A30
	bx lr	; 02327A34
pool_02327A38:
loc_02327A38:
	.word 0x00012078	; 02327A38

; ===== function loc_02327A3C =====
loc_02327A3C:
	mov r12,lr	; 02327A3C
	mov r0,#0xd3	; 02327A40
	msr cpsr_cxsf,r0	; 02327A44
	ldr r0,[pool_02327AAC]	; 02327A48
	add r0,r0,#0x3fc0	; 02327A4C
	mov sp,r0	; 02327A50
	mov lr,#0x0	; 02327A54
	msr spsr_cxsf,lr	; 02327A58
	mov r0,#0xd2	; 02327A5C
	msr cpsr_cxsf,r0	; 02327A60
	ldr r0,[pool_02327AAC]	; 02327A64
	add r0,r0,#0x3fc0	; 02327A68
	sub r0,r0,#0x40	; 02327A6C
	mov sp,r0	; 02327A70
	mov lr,#0x0	; 02327A74
	msr spsr_cxsf,lr	; 02327A78
	ldr r1,[pool_02327AB0]	; 02327A7C
	sub r1,r0,r1	; 02327A80
	mov r0,#0xdf	; 02327A84
	msr cpsr_cxsf,r0	; 02327A88
	sub sp,r1,#0x4	; 02327A8C
	ldr r0,[pool_02327AB4]	; 02327A90
	mov r1,#0x8000	; 02327A94
	bl loc_02327AB8	; 02327A98
	ldr r0,[pool_02327AAC]	; 02327A9C
	mov r1,#0x4000	; 02327AA0
	bl loc_02327AB8	; 02327AA4
	bx r12	; 02327AA8
pool_02327AAC:
loc_02327AAC:
	.word P1_DtcmRuntimeStart	; 02327AAC
pool_02327AB0:
loc_02327AB0:
	.word 0x00001000	; 02327AB0
pool_02327AB4:
loc_02327AB4:
	.word 0x01FF8000	; 02327AB4

; ===== function loc_02327AB8 =====
loc_02327AB8:
	add r2,r0,r1	; 02327AB8
	mov r1,r1, lsr #0x5	; 02327ABC
	mov r3,#0x0	; 02327AC0
	mov r4,r3	; 02327AC4
	mov r5,r3	; 02327AC8
	mov r6,r3	; 02327ACC
	mov r7,r3	; 02327AD0
	mov r8,r3	; 02327AD4
	mov r9,r3	; 02327AD8
	mov r10,r3	; 02327ADC
loc_02327AE0:
	cmp r0,r2	; 02327AE0
	stmltia r0!,{r3,r4,r5,r6,r7,r8,r9,r10}	; 02327AE4
	blt loc_02327AE0	; 02327AE8
	bx lr	; 02327AEC
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 02327AF4
.thumb
P1_PxiCallback_02327AF4:
	ldr r0,[pool_02327B90]	; 02327AF4
	add r3,r1,#0x0	; 02327AF6
	and r3,r0	; 02327AF8
	lsl r0,r3,#0x8	; 02327AFA
	lsr r3,r0,#0x10	; 02327AFC
	mov r0,#0xff	; 02327AFE
	and r1,r0	; 02327B00
	lsl r1,r1,#0x10	; 02327B02
	lsr r1,r1,#0x10	; 02327B04
	cmp r2,#0x0	; 02327B06
	beq loc_02327B0C	; 02327B08
	add r1,r0,#0x0	; 02327B0A
loc_02327B0C:
	sub r3,#0x20	; 02327B0C
	cmp r3,#0x5	; 02327B0E
	bhi loc_02327B8E	; 02327B10
	add r0,r3,r3	; 02327B12
P1_SwitchIndexPC_02327B12:
	add r0,pc	; 02327B14
	ldrh r0,[r0,#(P1_SwitchTable_02327B12 - (P1_SwitchIndexPC_02327B12 + 4))]	; 02327B16
	lsl r0,r0,#0x10	; 02327B18
	asr r0,r0,#0x10	; 02327B1A
P1_SwitchTargetPC_02327B12:
	add r0,pc	; 02327B1C
	bx r0	; 02327B1E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02327B12:
	.halfword (loc_02327B40 + 1) - (P1_SwitchTargetPC_02327B12 + 4)
	.halfword (loc_02327B7C + 1) - (P1_SwitchTargetPC_02327B12 + 4)
	.halfword (loc_02327B68 + 1) - (P1_SwitchTargetPC_02327B12 + 4)
	.halfword (loc_02327B2C + 1) - (P1_SwitchTargetPC_02327B12 + 4)
	.halfword (loc_02327B8E + 1) - (P1_SwitchTargetPC_02327B12 + 4)
	.halfword (loc_02327B54 + 1) - (P1_SwitchTargetPC_02327B12 + 4)
P1_SwitchTable_02327B12End:
loc_02327B2C:
	cmp r1,#0x0	; 02327B2C
	bne loc_02327B38	; 02327B2E
	mov r1,#0x0	; 02327B30
	ldr r0,[pool_02327B94]	; 02327B32
	str r1,[r0,#0x0]	; 02327B34
	bx lr	; 02327B36
loc_02327B38:
	mov r1,#0x1	; 02327B38
	ldr r0,[pool_02327B94]	; 02327B3A
	str r1,[r0,#0x0]	; 02327B3C
	bx lr	; 02327B3E
loc_02327B40:
	cmp r1,#0x0	; 02327B40
	bne loc_02327B4C	; 02327B42
	mov r1,#0x5	; 02327B44
	ldr r0,[pool_02327B94]	; 02327B46
	str r1,[r0,#0x0]	; 02327B48
	bx lr	; 02327B4A
loc_02327B4C:
	mov r1,#0x3	; 02327B4C
	ldr r0,[pool_02327B94]	; 02327B4E
	str r1,[r0,#0x0]	; 02327B50
	bx lr	; 02327B52
loc_02327B54:
	cmp r1,#0x0	; 02327B54
	bne loc_02327B60	; 02327B56
	mov r1,#0x7	; 02327B58
	ldr r0,[pool_02327B94]	; 02327B5A
	str r1,[r0,#0x0]	; 02327B5C
	bx lr	; 02327B5E
loc_02327B60:
	mov r1,#0x5	; 02327B60
	ldr r0,[pool_02327B94]	; 02327B62
	str r1,[r0,#0x0]	; 02327B64
	bx lr	; 02327B66
loc_02327B68:
	cmp r1,#0x0	; 02327B68
	bne loc_02327B74	; 02327B6A
	mov r1,#0x9	; 02327B6C
	ldr r0,[pool_02327B94]	; 02327B6E
	str r1,[r0,#0x0]	; 02327B70
	bx lr	; 02327B72
loc_02327B74:
	mov r1,#0x7	; 02327B74
	ldr r0,[pool_02327B94]	; 02327B76
	str r1,[r0,#0x0]	; 02327B78
	bx lr	; 02327B7A
loc_02327B7C:
	cmp r1,#0x0	; 02327B7C
	bne loc_02327B88	; 02327B7E
	mov r1,#0x0	; 02327B80
	ldr r0,[pool_02327B94]	; 02327B82
	str r1,[r0,#0x0]	; 02327B84
	bx lr	; 02327B86
loc_02327B88:
	mov r1,#0xa	; 02327B88
	ldr r0,[pool_02327B94]	; 02327B8A
	str r1,[r0,#0x0]	; 02327B8C
loc_02327B8E:
	bx lr	; 02327B8E
pool_02327B90:
loc_02327B90:
	.word 0x00007F00	; 02327B90
pool_02327B94:
loc_02327B94:
	.word P1_BssStart + 0x25750	; 02327B94

; ===== function loc_02327B98 =====
loc_02327B98:
	push {r4,r5,r6,r7,lr}	; 02327B98
	sub sp,#0x1c	; 02327B9A
	add r7,r0,#0x0	; 02327B9C
	str r1,[sp,#0x0]	; 02327B9E
	str r2,[sp,#0x4]	; 02327BA0
	mov r0,#0x3	; 02327BA2
	ldr r6,[pool_02327D04]	; 02327BA4
	str r0,[r6,#0x0]	; 02327BA6
	ldr r0,[r6,#0x0]	; 02327BA8
	cmp r0,#0x0	; 02327BAA
	bne loc_02327BB0	; 02327BAC
	b loc_02327CFA	; 02327BAE
loc_02327BB0:
	lsr r0,r7,#0x10	; 02327BB0
	str r0,[sp,#0x8]	; 02327BB2
	mov r1,#0xff	; 02327BB4
	and r0,r1	; 02327BB6
	str r0,[sp,#0x8]	; 02327BB8
	ldr r1,[pool_02327D08]	; 02327BBA
	orr r0,r1	; 02327BBC
	str r0,[sp,#0x8]	; 02327BBE
	ldr r0,[pool_02327D0C]	; 02327BC0
	and r7,r0	; 02327BC2
	ldr r1,[pool_02327D10]	; 02327BC4
	orr r7,r1	; 02327BC6
	ldr r3,[pool_02327D14]	; 02327BC8
	ldr r2,[sp,#0x0]	; 02327BCA
	orr r2,r3	; 02327BCC
	str r2,[sp,#0x0]	; 02327BCE
	ldr r2,[sp,#0x4]	; 02327BD0
	lsr r2,r2,#0x10	; 02327BD2
	str r2,[sp,#0xc]	; 02327BD4
	ldr r3,[pool_02327D18]	; 02327BD6
	orr r2,r3	; 02327BD8
	str r2,[sp,#0xc]	; 02327BDA
	ldr r2,[sp,#0x4]	; 02327BDC
	and r2,r0	; 02327BDE
	str r2,[sp,#0x4]	; 02327BE0
	ldr r3,[pool_02327D1C]	; 02327BE2
	orr r2,r3	; 02327BE4
	str r2,[sp,#0x4]	; 02327BE6
	ldr r2,[pool_02327D20]	; 02327BE8
	lsr r2,r2,#0x18	; 02327BEA
	str r2,[sp,#0x10]	; 02327BEC
	ldr r3,[pool_02327D24]	; 02327BEE
	orr r2,r3	; 02327BF0
	str r2,[sp,#0x10]	; 02327BF2
	ldr r2,[pool_02327D20]	; 02327BF4
	lsr r2,r2,#0x8	; 02327BF6
	str r2,[sp,#0x14]	; 02327BF8
	and r2,r0	; 02327BFA
	str r2,[sp,#0x14]	; 02327BFC
	orr r2,r1	; 02327BFE
	str r2,[sp,#0x14]	; 02327C00
	ldr r0,[pool_02327D20]	; 02327C02
	lsl r0,r0,#0x8	; 02327C04
	str r0,[sp,#0x18]	; 02327C06
	ldr r1,[pool_02327D28]	; 02327C08
	and r0,r1	; 02327C0A
	str r0,[sp,#0x18]	; 02327C0C
	ldr r1,[pool_02327D2C]	; 02327C0E
	orr r0,r1	; 02327C10
	str r0,[sp,#0x18]	; 02327C12
	mov r4,#0x4	; 02327C14
	mov r5,#0x0	; 02327C16
loc_02327C18:
	ldr r0,[r6,#0x0]	; 02327C18
	cmp r0,#0xa	; 02327C1A
	bhi loc_02327CF4	; 02327C1C
	add r0,r0,r0	; 02327C1E
P1_SwitchIndexPC_02327C1E:
	add r0,pc	; 02327C20
	ldrh r0,[r0,#(P1_SwitchTable_02327C1E - (P1_SwitchIndexPC_02327C1E + 4))]	; 02327C22
	lsl r0,r0,#0x10	; 02327C24
	asr r0,r0,#0x10	; 02327C26
P1_SwitchTargetPC_02327C1E:
	add r0,pc	; 02327C28
	bx r0	; 02327C2A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02327C1E:
	.halfword (loc_02327CF4 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327CF4 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327CF4 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327C42 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327CF4 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327C50 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327CF4 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327C98 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327CF4 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327CC4 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
	.halfword (loc_02327CE6 + 1) - (P1_SwitchTargetPC_02327C1E + 4)
P1_SwitchTable_02327C1EEnd:
loc_02327C42:
	add r0,r4,#0x0	; 02327C42
	ldr r1,[pool_02327D30]	; 02327C44
	add r2,r5,#0x0	; 02327C46
	bl loc_0232ED90	; 02327C48
	str r4,[r6,#0x0]	; 02327C4C
	b loc_02327CF4	; 02327C4E
loc_02327C50:
	add r0,r4,#0x0	; 02327C50
	ldr r1,[sp,#0x8]	; 02327C52
	add r2,r5,#0x0	; 02327C54
	bl loc_0232ED90	; 02327C56
	cmp r0,#0x0	; 02327C5A
	blt loc_02327C92	; 02327C5C
	add r0,r4,#0x0	; 02327C5E
	add r1,r7,#0x0	; 02327C60
	add r2,r5,#0x0	; 02327C62
	bl loc_0232ED90	; 02327C64
	cmp r0,#0x0	; 02327C68
	blt loc_02327C92	; 02327C6A
	add r0,r4,#0x0	; 02327C6C
	ldr r1,[sp,#0x0]	; 02327C6E
	add r2,r5,#0x0	; 02327C70
	bl loc_0232ED90	; 02327C72
	cmp r0,#0x0	; 02327C76
	blt loc_02327C92	; 02327C78
	add r0,r4,#0x0	; 02327C7A
	ldr r1,[sp,#0xc]	; 02327C7C
	add r2,r5,#0x0	; 02327C7E
	bl loc_0232ED90	; 02327C80
	cmp r0,#0x0	; 02327C84
	blt loc_02327C92	; 02327C86
	add r0,r4,#0x0	; 02327C88
	ldr r1,[sp,#0x4]	; 02327C8A
	add r2,r5,#0x0	; 02327C8C
	bl loc_0232ED90	; 02327C8E
loc_02327C92:
	mov r0,#0x6	; 02327C92
	str r0,[r6,#0x0]	; 02327C94
	b loc_02327CF4	; 02327C96
loc_02327C98:
	add r0,r4,#0x0	; 02327C98
	ldr r1,[sp,#0x10]	; 02327C9A
	add r2,r5,#0x0	; 02327C9C
	bl loc_0232ED90	; 02327C9E
	cmp r0,#0x0	; 02327CA2
	blt loc_02327CBE	; 02327CA4
	add r0,r4,#0x0	; 02327CA6
	ldr r1,[sp,#0x14]	; 02327CA8
	add r2,r5,#0x0	; 02327CAA
	bl loc_0232ED90	; 02327CAC
	cmp r0,#0x0	; 02327CB0
	blt loc_02327CBE	; 02327CB2
	add r0,r4,#0x0	; 02327CB4
	ldr r1,[sp,#0x18]	; 02327CB6
	add r2,r5,#0x0	; 02327CB8
	bl loc_0232ED90	; 02327CBA
loc_02327CBE:
	mov r0,#0x8	; 02327CBE
	str r0,[r6,#0x0]	; 02327CC0
	b loc_02327CF4	; 02327CC2
loc_02327CC4:
	ldr r0,[pool_02327D20]	; 02327CC4
	mov r1,#0x1	; 02327CC6
	blx P1_InvalidateDataCacheRange	; 02327CC8
	ldr r0,[pool_02327D20]	; 02327CCC
	ldrb r0,[r0,#0x0]	; 02327CCE
	cmp r0,#0x1	; 02327CD0
	bne loc_02327CE0	; 02327CD2
	ldr r0,[pool_02327D34]	; 02327CD4
	bl loc_0232C3D4	; 02327CD6
	mov r0,#0x7	; 02327CDA
	str r0,[r6,#0x0]	; 02327CDC
	b loc_02327CF4	; 02327CDE
loc_02327CE0:
	mov r0,#0xa	; 02327CE0
	str r0,[r6,#0x0]	; 02327CE2
	b loc_02327CF4	; 02327CE4
loc_02327CE6:
	add r0,r4,#0x0	; 02327CE6
	ldr r1,[pool_02327D38]	; 02327CE8
	add r2,r5,#0x0	; 02327CEA
	bl loc_0232ED90	; 02327CEC
	mov r0,#0xb	; 02327CF0
	str r0,[r6,#0x0]	; 02327CF2
loc_02327CF4:
	ldr r0,[r6,#0x0]	; 02327CF4
	cmp r0,#0x0	; 02327CF6
	bne loc_02327C18	; 02327CF8
loc_02327CFA:
	add sp,#0x1c	; 02327CFA
	pop {r4,r5,r6,r7}	; 02327CFC
	pop {r3}	; 02327CFE
	bx r3	; 02327D00
	.byte 0xC0, 0x46	; 02327D04
pool_02327D04:
loc_02327D04:
	.word P1_BssStart + 0x25750	; 02327D04
pool_02327D08:
loc_02327D08:
	.word 0x02002500	; 02327D08
pool_02327D0C:
loc_02327D0C:
	.word 0x0000FFFF	; 02327D0C
pool_02327D10:
loc_02327D10:
	.word 0x00010000	; 02327D10
pool_02327D14:
loc_02327D14:
	.word 0x00020000	; 02327D14
pool_02327D18:
loc_02327D18:
	.word 0x00030000	; 02327D18
pool_02327D1C:
loc_02327D1C:
	.word 0x01040000	; 02327D1C
pool_02327D20:
loc_02327D20:
	.word P1_BssStart + 0x257E0	; 02327D20
pool_02327D24:
loc_02327D24:
	.word 0x02002200	; 02327D24
pool_02327D28:
loc_02327D28:
	.word 0x0000FF00	; 02327D28
pool_02327D2C:
loc_02327D2C:
	.word 0x01020000	; 02327D2C
pool_02327D30:
loc_02327D30:
	.word 0x03002000	; 02327D30
pool_02327D34:
loc_02327D34:
	.word 0x00001000	; 02327D34
pool_02327D38:
loc_02327D38:
	.word 0x03002100	; 02327D38

; ===== function loc_02327D3C =====
loc_02327D3C:
	push {r4,r5,r6,r7,lr}	; 02327D3C
	sub sp,#0x14	; 02327D3E
	add r7,r0,#0x0	; 02327D40
	str r1,[sp,#0x0]	; 02327D42
	str r2,[sp,#0x4]	; 02327D44
	ldr r6,[pool_02327E28]	; 02327D46
	mov r0,#0x1	; 02327D48
	str r0,[r6,#0x0]	; 02327D4A
	ldr r0,[r6,#0x0]	; 02327D4C
	cmp r0,#0x0	; 02327D4E
	beq loc_02327E1E	; 02327D50
	lsr r0,r7,#0x10	; 02327D52
	str r0,[sp,#0x8]	; 02327D54
	mov r1,#0xff	; 02327D56
	and r0,r1	; 02327D58
	str r0,[sp,#0x8]	; 02327D5A
	ldr r1,[pool_02327E2C]	; 02327D5C
	orr r0,r1	; 02327D5E
	str r0,[sp,#0x8]	; 02327D60
	ldr r0,[pool_02327E30]	; 02327D62
	and r7,r0	; 02327D64
	ldr r1,[pool_02327E34]	; 02327D66
	orr r7,r1	; 02327D68
	ldr r1,[sp,#0x0]	; 02327D6A
	and r1,r0	; 02327D6C
	str r1,[sp,#0x0]	; 02327D6E
	ldr r2,[pool_02327E38]	; 02327D70
	orr r1,r2	; 02327D72
	str r1,[sp,#0x0]	; 02327D74
	ldr r1,[sp,#0x4]	; 02327D76
	lsr r1,r1,#0x10	; 02327D78
	str r1,[sp,#0xc]	; 02327D7A
	ldr r2,[pool_02327E3C]	; 02327D7C
	orr r1,r2	; 02327D7E
	str r1,[sp,#0xc]	; 02327D80
	ldr r1,[sp,#0x4]	; 02327D82
	and r1,r0	; 02327D84
	str r1,[sp,#0x4]	; 02327D86
	ldr r1,[pool_02327E40]	; 02327D88
	ldr r0,[sp,#0x4]	; 02327D8A
	orr r0,r1	; 02327D8C
	str r0,[sp,#0x4]	; 02327D8E
	mov r5,#0x4	; 02327D90
	mov r4,#0x0	; 02327D92
loc_02327D94:
	ldr r0,[r6,#0x0]	; 02327D94
	cmp r0,#0x1	; 02327D96
	bne loc_02327E18	; 02327D98
	add r0,r5,#0x0	; 02327D9A
	ldr r1,[sp,#0x8]	; 02327D9C
	add r2,r4,#0x0	; 02327D9E
	bl loc_0232ED90	; 02327DA0
	cmp r0,#0x0	; 02327DA4
	bge loc_02327DAC	; 02327DA6
	add r0,r4,#0x0	; 02327DA8
	b loc_02327E08	; 02327DAA
loc_02327DAC:
	add r0,r5,#0x0	; 02327DAC
	add r1,r7,#0x0	; 02327DAE
	add r2,r4,#0x0	; 02327DB0
	bl loc_0232ED90	; 02327DB2
	cmp r0,#0x0	; 02327DB6
	bge loc_02327DBE	; 02327DB8
	add r0,r4,#0x0	; 02327DBA
	b loc_02327E08	; 02327DBC
loc_02327DBE:
	add r0,r5,#0x0	; 02327DBE
	ldr r1,[pool_02327E44]	; 02327DC0
	add r2,r4,#0x0	; 02327DC2
	bl loc_0232ED90	; 02327DC4
	cmp r0,#0x0	; 02327DC8
	bge loc_02327DD0	; 02327DCA
	add r0,r4,#0x0	; 02327DCC
	b loc_02327E08	; 02327DCE
loc_02327DD0:
	add r0,r5,#0x0	; 02327DD0
	ldr r1,[sp,#0x0]	; 02327DD2
	add r2,r4,#0x0	; 02327DD4
	bl loc_0232ED90	; 02327DD6
	cmp r0,#0x0	; 02327DDA
	bge loc_02327DE2	; 02327DDC
	add r0,r4,#0x0	; 02327DDE
	b loc_02327E08	; 02327DE0
loc_02327DE2:
	add r0,r5,#0x0	; 02327DE2
	ldr r1,[sp,#0xc]	; 02327DE4
	add r2,r4,#0x0	; 02327DE6
	bl loc_0232ED90	; 02327DE8
	cmp r0,#0x0	; 02327DEC
	bge loc_02327DF4	; 02327DEE
	add r0,r4,#0x0	; 02327DF0
	b loc_02327E08	; 02327DF2
loc_02327DF4:
	add r0,r5,#0x0	; 02327DF4
	ldr r1,[sp,#0x4]	; 02327DF6
	add r2,r4,#0x0	; 02327DF8
	bl loc_0232ED90	; 02327DFA
	cmp r0,#0x0	; 02327DFE
	bge loc_02327E06	; 02327E00
	add r0,r4,#0x0	; 02327E02
	b loc_02327E08	; 02327E04
loc_02327E06:
	mov r0,#0x1	; 02327E06
loc_02327E08:
	cmp r0,#0x1	; 02327E08
	bne loc_02327E12	; 02327E0A
	mov r0,#0x2	; 02327E0C
	str r0,[r6,#0x0]	; 02327E0E
	b loc_02327E18	; 02327E10
loc_02327E12:
	ldr r0,[pool_02327E48]	; 02327E12
	bl loc_0232C3D4	; 02327E14
loc_02327E18:
	ldr r0,[r6,#0x0]	; 02327E18
	cmp r0,#0x0	; 02327E1A
	bne loc_02327D94	; 02327E1C
loc_02327E1E:
	add sp,#0x14	; 02327E1E
	pop {r4,r5,r6,r7}	; 02327E20
	pop {r3}	; 02327E22
	bx r3	; 02327E24
	.byte 0xC0, 0x46	; 02327E28
pool_02327E28:
loc_02327E28:
	.word P1_BssStart + 0x25750	; 02327E28
pool_02327E2C:
loc_02327E2C:
	.word 0x02002300	; 02327E2C
pool_02327E30:
loc_02327E30:
	.word 0x0000FFFF	; 02327E30
pool_02327E34:
loc_02327E34:
	.word 0x00010000	; 02327E34
pool_02327E38:
loc_02327E38:
	.word 0x00030000	; 02327E38
pool_02327E3C:
loc_02327E3C:
	.word 0x00040000	; 02327E3C
pool_02327E40:
loc_02327E40:
	.word 0x01050000	; 02327E40
pool_02327E44:
loc_02327E44:
	.word 0x00020000	; 02327E44
pool_02327E48:
loc_02327E48:
	.word 0x00001000	; 02327E48

; ===== function loc_02327E4C =====
loc_02327E4C:
; 检查副本并按更新计数选择；返回 0 成功，1 表示两份均无效。
; Validate/select by update counter; return 0 on success, 1 if neither copy is valid.
.func P1_SelectValidUserSettingsCopy
	push {r4,r5,r6,r7,lr}	; 02327E4C
	sub sp,#0x4	; 02327E4E
	add r7,r0,#0x0	; 02327E50
	mov r6,#0x0	; 02327E52
	add r5,r6,#0x0	; 02327E54
loc_02327E56:
	lsl r0,r5,#0x7	; 02327E56
	add r4,r7,r0	; 02327E58
	ldr r0,[pool_02327EF8]	; 02327E5A
	add r1,r4,#0x0	; 02327E5C
	mov r2,#0x70	; 02327E5E
	bl P1_SwiGetCrc16	; 02327E60
	add r1,r4,#0x0	; 02327E64
	add r1,#0x72	; 02327E66
	ldrh r1,[r1,#0x0]	; 02327E68
	cmp r0,r1	; 02327E6A
	bne loc_02327E88	; 02327E6C
	add r0,r4,#0x0	; 02327E6E
	add r0,#0x70	; 02327E70
	ldrh r0,[r0,#0x0]	; 02327E72
	cmp r0,#0x80	; 02327E74
	bcs loc_02327E88	; 02327E76
	ldrb r0,[r4,#0x0]	; 02327E78
	cmp r0,#0x5	; 02327E7A
	bne loc_02327E88	; 02327E7C
	mov r0,#0x1	; 02327E7E
	lsl r0,r5	; 02327E80
	orr r6,r0	; 02327E82
	lsl r0,r6,#0x10	; 02327E84
	lsr r6,r0,#0x10	; 02327E86
loc_02327E88:
	add r0,r5,#0x1	; 02327E88
	lsl r0,r0,#0x10	; 02327E8A
	lsr r5,r0,#0x10	; 02327E8C
	cmp r5,#0x2	; 02327E8E
	bcc loc_02327E56	; 02327E90
	cmp r6,#0x3	; 02327E92
	bne loc_02327EBE	; 02327E94
	add r0,r7,#0x0	; 02327E96
	add r0,#0x70	; 02327E98
	ldrh r0,[r0,#0x0]	; 02327E9A
	add r1,r0,#0x1	; 02327E9C
	mov r0,#0x7f	; 02327E9E
	and r1,r0	; 02327EA0
	lsl r0,r1,#0x18	; 02327EA2
	lsr r1,r0,#0x18	; 02327EA4
	add r7,#0xf0	; 02327EA6
	ldrh r0,[r7,#0x0]	; 02327EA8
	cmp r1,r0	; 02327EAA
	bne loc_02327EB6	; 02327EAC
	mov r1,#0x1	; 02327EAE
	ldr r0,[pool_02327EFC]	; 02327EB0
	strh r1,[r0,#0x0]	; 02327EB2
	b loc_02327EEE	; 02327EB4
loc_02327EB6:
	mov r1,#0x0	; 02327EB6
	ldr r0,[pool_02327EFC]	; 02327EB8
	strh r1,[r0,#0x0]	; 02327EBA
	b loc_02327EEE	; 02327EBC
loc_02327EBE:
	cmp r6,#0x0	; 02327EBE
	beq loc_02327EE4	; 02327EC0
	mov r1,#0x0	; 02327EC2
	ldr r0,[pool_02327EFC]	; 02327EC4
	strh r1,[r0,#0x0]	; 02327EC6
	mov r2,#0x1	; 02327EC8
loc_02327ECA:
	ldrh r1,[r0,#0x0]	; 02327ECA
	add r3,r2,#0x0	; 02327ECC
	lsl r3,r1	; 02327ECE
	add r4,r6,#0x0	; 02327ED0
	and r4,r3	; 02327ED2
	cmp r4,#0x0	; 02327ED4
	bne loc_02327EEE	; 02327ED6
	add r1,r1,#0x1	; 02327ED8
	strh r1,[r0,#0x0]	; 02327EDA
	ldrh r1,[r0,#0x0]	; 02327EDC
	cmp r1,#0x2	; 02327EDE
	bcc loc_02327ECA	; 02327EE0
	b loc_02327EEE	; 02327EE2
loc_02327EE4:
	mov r0,#0x1	; 02327EE4
	add sp,#0x4	; 02327EE6
	pop {r4,r5,r6,r7}	; 02327EE8
	pop {r3}	; 02327EEA
	bx r3	; 02327EEC
loc_02327EEE:
	mov r0,#0x0	; 02327EEE
	add sp,#0x4	; 02327EF0
	pop {r4,r5,r6,r7}	; 02327EF2
	pop {r3}	; 02327EF4
	bx r3	; 02327EF6
.endfunc
pool_02327EF8:
loc_02327EF8:
	.word 0x0000FFFF	; 02327EF8
pool_02327EFC:
loc_02327EFC:
	.word P1_Data_02330D10	; 02327EFC

; ===== function loc_02327F00 =====
loc_02327F00:
	push {r4,r5,lr}	; 02327F00
	sub sp,#0x4	; 02327F02
	add r5,r0,#0x0	; 02327F04
	ldr r4,[pool_02327F88]	; 02327F06
	ldr r0,[pool_02327F8C]	; 02327F08
	ldrh r0,[r0,#0x0]	; 02327F0A
	cmp r0,#0xff	; 02327F0C
	bne loc_02327F20	; 02327F0E
	mov r0,#0x0	; 02327F10
	bl P1_LoadAndSelectUserSettings	; 02327F12
	cmp r0,#0x0	; 02327F16
	beq loc_02327F20	; 02327F18
	mov r1,#0x0	; 02327F1A
	ldr r0,[pool_02327F8C]	; 02327F1C
	strh r1,[r0,#0x0]	; 02327F1E
loc_02327F20:
	mov r0,#0x5	; 02327F20
	strb r0,[r5,#0x0]	; 02327F22
	add r3,r4,#0x0	; 02327F24
	mov r2,#0xe	; 02327F26
loc_02327F28:
	ldmia r5!,{r0,r1}	; 02327F28
	stmia r3!,{r0,r1}	; 02327F2A
	sub r2,r2,#0x1	; 02327F2C
	cmp r2,#0x0	; 02327F2E
	bne loc_02327F28	; 02327F30
	ldr r0,[pool_02327F90]	; 02327F32
	add r1,r4,#0x0	; 02327F34
	mov r2,#0x70	; 02327F36
	bl P1_SwiGetCrc16	; 02327F38
	add r1,r4,#0x0	; 02327F3C
	add r1,#0x72	; 02327F3E
	strh r0,[r1,#0x0]	; 02327F40
	ldr r1,[pool_02327F94]	; 02327F42
	ldrh r2,[r1,#0x0]	; 02327F44
	add r0,r4,#0x0	; 02327F46
	add r0,#0x70	; 02327F48
	strh r2,[r0,#0x0]	; 02327F4A
	ldrh r0,[r1,#0x0]	; 02327F4C
	add r2,r0,#0x1	; 02327F4E
	mov r0,#0x7f	; 02327F50
	and r2,r0	; 02327F52
	lsl r0,r2,#0x18	; 02327F54
	lsr r0,r0,#0x18	; 02327F56
	strh r0,[r1,#0x0]	; 02327F58
	ldr r1,[pool_02327F8C]	; 02327F5A
	ldrh r2,[r1,#0x0]	; 02327F5C
	mov r0,#0x1	; 02327F5E
	eor r2,r0	; 02327F60
	strh r2,[r1,#0x0]	; 02327F62
	ldr r0,[pool_02327F98]	; 02327F64
	ldr r2,[r0,#0x0]	; 02327F66
	ldrh r0,[r1,#0x0]	; 02327F68
	lsl r0,r0,#0x8	; 02327F6A
	add r5,r2,r0	; 02327F6C
	add r0,r4,#0x0	; 02327F6E
	mov r1,#0x80	; 02327F70
	blx P1_CleanAndInvalidateDataCacheRange	; 02327F72
	add r0,r5,#0x0	; 02327F76
	mov r1,#0x80	; 02327F78
	add r2,r4,#0x0	; 02327F7A
	bl loc_02327B98	; 02327F7C
	add sp,#0x4	; 02327F80
	pop {r4,r5}	; 02327F82
	pop {r3}	; 02327F84
	bx r3	; 02327F86
pool_02327F88:
loc_02327F88:
	.word 0x023565C0	; 02327F88
pool_02327F8C:
loc_02327F8C:
	.word P1_Data_02330D10	; 02327F8C
pool_02327F90:
loc_02327F90:
	.word 0x0000FFFF	; 02327F90
pool_02327F94:
loc_02327F94:
	.word P1_BssStart + 0x2574C	; 02327F94
pool_02327F98:
loc_02327F98:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 02327F98

; ===== function loc_02327F9C =====
loc_02327F9C:
	ldrb r1,[r0,#0x3]	; 02327F9C
	cmp r1,#0xc	; 02327F9E
	bhi loc_02327FA8	; 02327FA0
	ldrb r1,[r0,#0x4]	; 02327FA2
	cmp r1,#0x1f	; 02327FA4
	bls loc_02327FAE	; 02327FA6
loc_02327FA8:
	mov r1,#0x1	; 02327FA8
	strb r1,[r0,#0x3]	; 02327FAA
	strb r1,[r0,#0x4]	; 02327FAC
loc_02327FAE:
	ldrb r1,[r0,#0x1a]	; 02327FAE
	cmp r1,#0xa	; 02327FB0
	bls loc_02327FB8	; 02327FB2
	mov r1,#0x0	; 02327FB4
	strb r1,[r0,#0x1a]	; 02327FB6
loc_02327FB8:
	add r1,r0,#0x0	; 02327FB8
	add r1,#0x50	; 02327FBA
	ldrb r1,[r1,#0x0]	; 02327FBC
	cmp r1,#0x1a	; 02327FBE
	bls loc_02327FCA	; 02327FC0
	mov r2,#0x0	; 02327FC2
	add r1,r0,#0x0	; 02327FC4
	add r1,#0x50	; 02327FC6
	strb r2,[r1,#0x0]	; 02327FC8
loc_02327FCA:
	add r1,r0,#0x0	; 02327FCA
	add r1,#0x52	; 02327FCC
	ldrb r1,[r1,#0x0]	; 02327FCE
	cmp r1,#0x17	; 02327FD0
	bhi loc_02327FDE	; 02327FD2
	add r1,r0,#0x0	; 02327FD4
	add r1,#0x53	; 02327FD6
	ldrb r1,[r1,#0x0]	; 02327FD8
	cmp r1,#0x3b	; 02327FDA
	bls loc_02327FEC	; 02327FDC
loc_02327FDE:
	mov r2,#0x0	; 02327FDE
	add r1,r0,#0x0	; 02327FE0
	add r1,#0x52	; 02327FE2
	strb r2,[r1,#0x0]	; 02327FE4
	add r1,r0,#0x0	; 02327FE6
	add r1,#0x53	; 02327FE8
	strb r2,[r1,#0x0]	; 02327FEA
loc_02327FEC:
	add r1,r0,#0x0	; 02327FEC
	add r1,#0x64	; 02327FEE
	ldrh r1,[r1,#0x0]	; 02327FF0
	lsl r1,r1,#0x1d	; 02327FF2
	lsr r1,r1,#0x1d	; 02327FF4
	cmp r1,#0x6	; 02327FF6
	bcc loc_02328008	; 02327FF8
	add r0,#0x64	; 02327FFA
	ldrh r2,[r0,#0x0]	; 02327FFC
	mov r1,#0x7	; 02327FFE
	bic r2,r1	; 02328000
	mov r1,#0x1	; 02328002
	orr r2,r1	; 02328004
	strh r2,[r0,#0x0]	; 02328006
loc_02328008:
	bx lr	; 02328008
	.byte 0x00, 0x00	; 0232800C

; ===== function loc_0232800C =====
loc_0232800C:
; 读取两份用户设置并选用有效副本；返回 1 表示无可用副本。
; Read both settings copies and select one; return 1 when neither is usable.
.func P1_LoadAndSelectUserSettings
	push {r4,r5,r6,lr}	; 0232800C
	add r5,r0,#0x0	; 0232800E
	mov r4,#0x0	; 02328010
	ldr r6,[pool_02328088]	; 02328012
	mov r0,#0x4	; 02328014
	ldr r1,[pool_0232808C]	; 02328016
	bl P1_SetPxiReceiveCallback	; 02328018
	ldr r0,[pool_02328090]	; 0232801C
	ldr r0,[r0,#0x0]	; 0232801E
	mov r1,#0x80	; 02328020
	lsl r2,r6,#0	; 02328022
	bl loc_02327D3C	; 02328024
	ldr r0,[pool_02328090]	; 02328028
	ldr r1,[r0,#0x0]	; 0232802A
	ldr r0,[pool_02328094]	; 0232802C
	add r0,r1,r0	; 0232802E
	mov r1,#0x80	; 02328030
	ldr r2,[pool_02328098]	; 02328032
	bl loc_02327D3C	; 02328034
	lsl r0,r6,#0	; 02328038
	ldr r1,[pool_02328094]	; 0232803A
	blx P1_InvalidateDataCacheRange	; 0232803C
	lsl r0,r6,#0	; 02328040
	bl P1_SelectValidUserSettingsCopy	; 02328042
	cmp r0,#0x0	; 02328046
	beq loc_02328052	; 02328048
	mov r4,#0x1	; 0232804A
	ldr r0,[pool_0232809C]	; 0232804C
	strh r4,[r0,#0x0]	; 0232804E
	b loc_02328080	; 02328050
loc_02328052:
	ldr r0,[pool_023280A0]	; 02328052
	ldrh r0,[r0,#0x0]	; 02328054
	lsl r0,r0,#0x7	; 02328056
	add r0,r6,r0	; 02328058
	add r1,r0,#0x0	; 0232805A
	add r1,#0x70	; 0232805C
	ldrh r1,[r1,#0x0]	; 0232805E
	add r2,r1,#0x1	; 02328060
	mov r1,#0x7f	; 02328062
	and r2,r1	; 02328064
	lsl r1,r2,#0x18	; 02328066
	lsr r2,r1,#0x18	; 02328068
	ldr r1,[pool_0232809C]	; 0232806A
	strh r2,[r1,#0x0]	; 0232806C
	cmp r5,#0x0	; 0232806E
	beq loc_02328080	; 02328070
	add r1,r5,#0x0	; 02328072
	mov r2,#0x38	; 02328074
	bl loc_0232C3F2	; 02328076
	add r0,r5,#0x0	; 0232807A
	bl loc_02327F9C	; 0232807C
loc_02328080:
	add r0,r4,#0x0	; 02328080
	pop {r4,r5,r6}	; 02328082
	pop {r3}	; 02328084
	bx r3	; 02328086
.endfunc
pool_02328088:
loc_02328088:
	.word 0x023565C0	; 02328088
pool_0232808C:
loc_0232808C:
	.word P1_PxiCallback_02327AF4 + 1	; 0232808C
pool_02328090:
loc_02328090:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 02328090
pool_02328094:
loc_02328094:
	.word 0x00000100	; 02328094
pool_02328098:
loc_02328098:
	.word 0x02356640	; 02328098
pool_0232809C:
loc_0232809C:
	.word P1_BssStart + 0x2574C	; 0232809C
pool_023280A0:
loc_023280A0:
	.word P1_Data_02330D10	; 023280A0

; ===== function loc_023280A4 =====
loc_023280A4:
	push {r4,r5}	; 023280A4
	mov r4,#0x3	; 023280A6
	mov r3,#0x0	; 023280A8
loc_023280AA:
	ldrb r2,[r0,#0x0]	; 023280AA
	ror r3,r4	; 023280AC
	mov r5,#0x4	; 023280AE
loc_023280B0:
	eor r3,r2	; 023280B0
	lsl r2,r2,#0x8	; 023280B2
	sub r5,#0x1	; 023280B4
	bgt loc_023280B0	; 023280B6
	add r0,#0x1	; 023280B8
	sub r1,#0x1	; 023280BA
	bgt loc_023280AA	; 023280BC
	add r0,r3,#0x0	; 023280BE
	lsl r0,r0,#0x1b	; 023280C0
	lsr r0,r0,#0x1e	; 023280C2
	pop {r4,r5}	; 023280C4
	bx lr	; 023280C6

; ===== function loc_023280C8 =====
loc_023280C8:
	add r2,r0,#0x0	; 023280C8
	mov r0,#0x14	; 023280CA
	mul r1,r0	; 023280CC
	ldr r0,[pool_023280DC]	; 023280CE
	add r0,r1,r0	; 023280D0
	add r1,r2,r1	; 023280D2
	mov r2,#0xa	; 023280D4
	ldr r3,[pool_023280E0]	; 023280D6
	bx r3	; 023280D8
	.byte 0xC0, 0x46	; 023280DC
pool_023280DC:
loc_023280DC:
	.word 0x08000004	; 023280DC
pool_023280E0:
loc_023280E0:
	.word P1_SwiCpuSet + 1	; 023280E0

; ===== function loc_023280E4 =====
loc_023280E4:
	push {r4,r5,r6,r7,lr}	; 023280E4
	sub sp,#0x4	; 023280E6
	add r6,r0,#0x0	; 023280E8
	ldr r0,[pool_02328150]	; 023280EA
	ldrb r1,[r0,#0x0]	; 023280EC
	mov r0,#0x80	; 023280EE
	and r1,r0	; 023280F0
	cmp r1,#0x0	; 023280F2
	beq loc_023280FA	; 023280F4
	ldr r0,[pool_02328154]	; 023280F6
	b loc_023280FC	; 023280F8
loc_023280FA:
	ldr r0,[pool_02328158]	; 023280FA
loc_023280FC:
	add r1,r6,#0x0	; 023280FC
	mov r2,#0xa	; 023280FE
	bl loc_0232C3F2	; 02328100
	ldr r0,[pool_0232815C]	; 02328104
	sub r0,r0,#0x1	; 02328106
	mov r1,#0x1b	; 02328108
	bl loc_023280A4	; 0232810A
	ldr r3,[pool_02328160]	; 0232810E
	ldr r1,[pool_0232815C]	; 02328110
	ldrb r2,[r1,#0x0]	; 02328112
	mov r1,#0x3	; 02328114
	and r2,r1	; 02328116
	mov r1,#0x30	; 02328118
	mul r2,r1	; 0232811A
	add r2,r3,r2	; 0232811C
	mov r1,#0xc	; 0232811E
	mul r0,r1	; 02328120
	add r5,r2,r0	; 02328122
	mov r4,#0x0	; 02328124
	ldr r7,[pool_02328164]	; 02328126
loc_02328128:
	add r0,r6,#0x0	; 02328128
	add r1,r4,#0x0	; 0232812A
	bl loc_023280C8	; 0232812C
	cmp r4,#0x3	; 02328130
	blt loc_02328140	; 02328132
	cmp r4,#0x9	; 02328134
	bge loc_02328140	; 02328136
	ldrh r0,[r5,#0x0]	; 02328138
	add r5,r5,#0x2	; 0232813A
	lsl r0,r0,#0x1	; 0232813C
	ldrh r0,[r0,r7]	; 0232813E
loc_02328140:
	add r4,r4,#0x1	; 02328140
	cmp r4,#0xb	; 02328142
	blt loc_02328128	; 02328144
	add sp,#0x4	; 02328146
	pop {r4,r5,r6,r7}	; 02328148
	pop {r3}	; 0232814A
	bx r3	; 0232814C
	.byte 0xC0, 0x46	; 02328150
pool_02328150:
loc_02328150:
	.word Slot2BusBaseAddress + 0xB4	; 02328150
pool_02328154:
loc_02328154:
	.word 0x09FE1FE0	; 02328154
pool_02328158:
loc_02328158:
	.word 0x09FFFFE0	; 02328158
pool_0232815C:
loc_0232815C:
	.word Slot2BusBaseAddress + 0x9E	; 0232815C
pool_02328160:
loc_02328160:
	.word 0x02330D14	; 02328160
pool_02328164:
loc_02328164:
	.word 0x08000000	; 02328164

; ===== function loc_02328168 =====
loc_02328168:
	push {r4,r5,r6,r7}	; 02328168
	mov r5,#0x0	; 0232816A
	ldr r3,[pool_023281B0]	; 0232816C
	ldr r2,[pool_023281B4]	; 0232816E
	mov r1,#0x3	; 02328170
	add r4,r2,#0x0	; 02328172
	eor r4,r1	; 02328174
	lsl r1,r4,#0x10	; 02328176
	lsr r1,r1,#0x10	; 02328178
	mov r6,#0x84	; 0232817A
loc_0232817C:
	add r4,r2,#0x0	; 0232817C
	cmp r5,#0x4c	; 0232817E
	bne loc_0232818A	; 02328180
	eor r4,r6	; 02328182
	lsl r4,r4,#0x10	; 02328184
	lsr r4,r4,#0x10	; 02328186
	b loc_02328190	; 02328188
loc_0232818A:
	cmp r5,#0x4d	; 0232818A
	bne loc_02328190	; 0232818C
	add r4,r1,#0x0	; 0232818E
loc_02328190:
	ldrh r7,[r0,#0x0]	; 02328190
	and r4,r7	; 02328192
	ldrh r7,[r3,#0x0]	; 02328194
	cmp r4,r7	; 02328196
	beq loc_023281A0	; 02328198
	mov r0,#0x0	; 0232819A
	pop {r4,r5,r6,r7}	; 0232819C
	bx lr	; 0232819E
loc_023281A0:
	add r3,r3,#0x2	; 023281A0
	add r0,r0,#0x2	; 023281A2
	add r5,r5,#0x1	; 023281A4
	cmp r5,#0x4e	; 023281A6
	blt loc_0232817C	; 023281A8
	mov r0,#0x1	; 023281AA
	pop {r4,r5,r6,r7}	; 023281AC
	bx lr	; 023281AE
pool_023281B0:
loc_023281B0:
	.word 0xFFFF0020	; 023281B0
pool_023281B4:
loc_023281B4:
	.word 0x0000FFFF	; 023281B4

; ===== function loc_023281B8 =====
loc_023281B8:
	push {r4,lr}	; 023281B8
	mov r0,#0x6d	; 023281BA
	bl loc_0232AFA0	; 023281BC
	ldr r0,[pool_023281DC]	; 023281C0
	bl loc_023280E4	; 023281C2
	ldr r0,[pool_023281DC]	; 023281C6
	bl loc_02328168	; 023281C8
	add r4,r0,#0x0	; 023281CC
	mov r0,#0x6d	; 023281CE
	bl loc_0232AE38	; 023281D0
	add r0,r4,#0x0	; 023281D4
	pop {r4}	; 023281D6
	pop {r3}	; 023281D8
	bx r3	; 023281DA
pool_023281DC:
loc_023281DC:
	.word 0x023566C0	; 023281DC

; ===== function loc_023281E0 =====
loc_023281E0:
	push {r0,r1,r2,r4,lr}	; 023281E0
	ldr r0,[pool_02328224]	; 023281E2
	add r1,r2,#0x0	; 023281E4
	add r4,r1,#0x0	; 023281E6
	mov r2,#0x24	; 023281E8
	blx loc_0232E2FC	; 023281EA
	ldr r0,[sp,#0x0]	; 023281EE
	mov r2,#0x24	; 023281F0
	add r1,r4,r2	; 023281F2
	mov r2,#0x9c	; 023281F4
	blx loc_0232E2FC	; 023281F6
	add r0,r4,#0x0	; 023281FA
	ldr r1,[sp,#0x4]	; 023281FC
	mov r2,#0x1	; 023281FE
	lsl r2,r2,#0x8	; 02328200
	add r2,r2,r1	; 02328202
	ldr r3,[pool_02328228]	; 02328204
	bl loc_0232C412	; 02328206
	ldr r0,[sp,#0x4]	; 0232820A
	ldr r2,[pool_0232822C]	; 0232820C
	str r2,[r0,#0x0]	; 0232820E
	add r1,r4,#0x0	; 02328210
	bl loc_02328234	; 02328212
	add r0,r4,#0x0	; 02328216
	ldr r1,[sp,#0x4]	; 02328218
	ldr r2,[pool_02328230]	; 0232821A
	bl loc_0232C406	; 0232821C
	pop {r0,r1,r2,r4,pc}	; 02328220
	.byte 0xC0, 0x46	; 02328224
pool_02328224:
loc_02328224:
	.word 0x02330850	; 02328224
pool_02328228:
loc_02328228:
	.word 0x0233083C	; 02328228
pool_0232822C:
loc_0232822C:
	.word 0x0000D082	; 0232822C
pool_02328230:
loc_02328230:
	.word P1_Data_02330DD4	; 02328230

; ===== function loc_02328234 =====
.func P1_SwiDiff16UnFilter
; BIOS SWI #18: differential 16-bit decompression. / BIOS SWI #18：差分 16 位解压。
loc_02328234:
	swi 0x18	; 02328234
	bx lr	; 02328236
.endfunc

; ===== function loc_02328238 =====
loc_02328238:
	ldr r0,[r0,#0x0]	; 02328238
	bx lr	; 0232823A
	ldrb r0,[r0,#0x0]	; 0232823C
	bx lr	; 0232823E
	mov r0,#0x0	; 02328240
	bx lr	; 02328242

; ===== function loc_02328244 =====
	push {lr}	; 02328244
	sub sp,#0x4	; 02328246
	cmp r2,#0x0	; 02328248
	beq loc_02328256	; 0232824A
	bl loc_02328238	; 0232824C
	add sp,#0x4	; 02328250
	pop {r3}	; 02328252
	bx r3	; 02328254
loc_02328256:
	mov r0,#0x0	; 02328256
	add sp,#0x4	; 02328258
	pop {r3}	; 0232825A
	bx r3	; 0232825C
	.byte 0x00, 0x00	; 02328260

; ===== function loc_02328260 =====
loc_02328260:
	push {r4,r5,r6,lr}	; 02328260
	sub sp,#0x100	; 02328262
	add r5,r1,#0x0	; 02328264
	add r4,r3,#0x0	; 02328266
	ldr r1,[pool_02328294]	; 02328268
	ldr r3,[r1,#0x4]	; 0232826A
	ldr r6,[pool_02328298]	; 0232826C
	and r3,r6	; 0232826E
	sub r6,r2,#0x1	; 02328270
	ldr r2,[pool_0232829C]	; 02328272
	and r6,r2	; 02328274
	orr r3,r6	; 02328276
	str r3,[r1,#0x4]	; 02328278
	add r1,r4,#0x0	; 0232827A
	add r2,sp,#0x0	; 0232827C
	bl loc_023281E0	; 0232827E
	add r0,r4,#0x0	; 02328282
	add r1,r5,#0x0	; 02328284
	ldr r2,[pool_023282A0]	; 02328286
	blx loc_0232E390	; 02328288
	add sp,#0x100	; 0232828C
	pop {r4,r5,r6}	; 0232828E
	pop {r3}	; 02328290
	bx r3	; 02328292
pool_02328294:
loc_02328294:
	.word P1_Data_02330DD4	; 02328294
pool_02328298:
loc_02328298:
	.word 0x80000000	; 02328298
pool_0232829C:
loc_0232829C:
	.word 0x7FFFFFFF	; 0232829C
pool_023282A0:
loc_023282A0:
	.word 0x00000340	; 023282A0
.arm

; ===== function loc_023282A4 =====
loc_023282A4:
; 解出 P3/P4/P5；r0=目标、r1=压缩流，返回输出长度。
; Decode P3/P4/P5; r0=destination, r1=stream, returns output size.
.func P1_DecompressP345
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 023282A4
	sub sp,sp,#0xc	; 023282A8
	mov r9,r1	; 023282AC
	ldrb r1,[r9,#0x5]	; 023282B0
	ldrb r2,[r9,#0x6]	; 023282B4
	ldrb r3,[r9,#0x8]	; 023282B8
	mov r4,r1, lsl #0x10	; 023282BC
	orr r5,r4,r2, lsl #0x8	; 023282C0
	ldrb r2,[r9,#0x9]	; 023282C4
	mov r3,r3, lsl #0x18	; 023282C8
	ldrb r1,[r9,#0x7]	; 023282CC
	orr r2,r3,r2, lsl #0x10	; 023282D0
	ldrb r4,[r9,#0xa]	; 023282D4
	mov r10,r0	; 023282D8
	orr r0,r1,r5	; 023282DC
	str r0,[sp,#0x0]	; 023282E0
	ldrb r3,[r9,#0xb]	; 023282E4
	orr r2,r2,r4, lsl #0x8	; 023282E8
	ldr r1,[pool_02328460]	; 023282EC
	add r0,r10,r0	; 023282F0
	cmp r0,r1	; 023282F4
	orr r11,r3,r2	; 023282F8
	addhi sp,sp,#0xc	; 023282FC
	movhi r0,#0x0	; 02328300
	ldmhiia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328304
	bxhi lr	; 02328308
; 每次重新建立两路状态；共享工作区不可重入。
; Reinitialize both streams for each call; shared workspace is not reentrant.
	ldr r5,[pool_02328464]	; 0232830C
	mov r8,#0xc	; 02328310
	ldr r4,[pool_02328468]	; 02328314
	mov r2,#0x0	; 02328318
	ldr r3,[pool_0232846C]	; 0232831C
	mov r7,#0x200	; 02328320
	mov r6,#0x800	; 02328324
	mov r0,r9	; 02328328
	mov r1,#0x20	; 0232832C
	str r8,[r5,#0x0]	; 02328330
	str r11,[r5,#0x4]	; 02328334
	str r2,[r4,#0x4]	; 02328338
	str r2,[r4,#0x0]	; 0232833C
	str r7,[r3,#0x0]	; 02328340
	str r6,[r3,#0x4]	; 02328344
	bl P1_ReadP345Bits	; 02328348
	mov r0,r9	; 0232834C
	mov r1,#0x20	; 02328350
	mov r2,#0x1	; 02328354
	bl P1_ReadP345Bits	; 02328358
	mov r0,r9	; 0232835C
	bl P1_BuildP345LengthTree	; 02328360
	str r0,[sp,#0x4]	; 02328364
	mov r0,r9	; 02328368
	bl P1_BuildP345DistanceTree	; 0232836C
	str r0,[sp,#0x8]	; 02328370
	ldr r0,[sp,#0x0]	; 02328374
	mov r6,#0x0	; 02328378
	cmp r0,#0x0	; 0232837C
	ble loc_02328450	; 02328380
	ldr r11,[pool_02328470]	; 02328384
	mov r4,r6	; 02328388
	mov r5,#0x1	; 0232838C
loc_02328390:
; 小于 0x100 的值直接输出；否则长度=值-0xFD，回距=距离值+1。
; Values below 0x100 are literals; otherwise length=value-0xFD, distance=distance value+1.
	ldr r7,[sp,#0x4]	; 02328390
	mov r0,r7	; 02328394
	cmp r0,#0x200	; 02328398
	blt loc_023283C8	; 0232839C
loc_023283A0:
	mov r0,r9	; 023283A0
	mov r1,r5	; 023283A4
	mov r2,r4	; 023283A8
	bl P1_ReadP345Bits	; 023283AC
	cmp r0,#0x0	; 023283B0
	ldrne r7,[r11,r7,lsl #0x2]	; 023283B4
	ldreq r0,[pool_02328474]	; 023283B8
	ldreq r7,[r0,r7,lsl #0x2]	; 023283BC
	cmp r7,#0x200	; 023283C0
	bge loc_023283A0	; 023283C4
loc_023283C8:
	cmp r7,#0x100	; 023283C8
	strltb r7,[r10,r6]	; 023283CC
	addlt r6,r6,#0x1	; 023283D0
	blt loc_02328444	; 023283D4
	ldr r8,[sp,#0x8]	; 023283D8
	mov r0,r8	; 023283DC
	cmp r0,#0x800	; 023283E0
	blt loc_02328414	; 023283E4
loc_023283E8:
	mov r0,r9	; 023283E8
	mov r1,r5	; 023283EC
	mov r2,r5	; 023283F0
	bl P1_ReadP345Bits	; 023283F4
	cmp r0,#0x0	; 023283F8
	ldrne r0,[pool_02328478]	; 023283FC
	ldrne r8,[r0,r8,lsl #0x2]	; 02328400
	ldreq r0,[pool_0232847C]	; 02328404
	ldreq r8,[r0,r8,lsl #0x2]	; 02328408
	cmp r8,#0x800	; 0232840C
	bge loc_023283E8	; 02328410
loc_02328414:
	sub r0,r6,r8	; 02328414
	sub r1,r0,#0x1	; 02328418
	sub r7,r7,#0xfd	; 0232841C
	cmp r7,#0x0	; 02328420
	ble loc_02328444	; 02328424
loc_02328428:
	ldrb r0,[r10,r1]	; 02328428
	sub r7,r7,#0x1	; 0232842C
	cmp r7,#0x0	; 02328430
	strb r0,[r10,r6]	; 02328434
	add r6,r6,#0x1	; 02328438
	add r1,r1,#0x1	; 0232843C
	bgt loc_02328428	; 02328440
loc_02328444:
	ldr r0,[sp,#0x0]	; 02328444
	cmp r6,r0	; 02328448
	blt loc_02328390	; 0232844C
loc_02328450:
	mov r0,r6	; 02328450
	add sp,sp,#0xc	; 02328454
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328458
	bx lr	; 0232845C
.endfunc
pool_02328460:
loc_02328460:
	.word P345DecodeOutputLimitAddress	; 02328460
pool_02328464:
loc_02328464:
	.word P1_P345StreamOffsets	; 02328464
pool_02328468:
loc_02328468:
	.word P1_P345BitPositions	; 02328468
pool_0232846C:
loc_0232846C:
	.word P1_P345NodeBaseIds	; 0232846C
pool_02328470:
loc_02328470:
	.word P1_P345LengthOneChildren	; 02328470
pool_02328474:
loc_02328474:
	.word P1_P345LengthZeroChildren	; 02328474
pool_02328478:
loc_02328478:
	.word P1_P345DistanceOneChildren	; 02328478
pool_0232847C:
loc_0232847C:
	.word P1_P345DistanceZeroChildren	; 0232847C

; ===== function loc_02328480 =====
loc_02328480:
; 重建距离树；叶子为 11 位，子节点使用 32 位表项。
; Build the distance tree: 11-bit leaves, 32-bit child entries.
.func P1_BuildP345DistanceTree
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328480
	sub sp,sp,#0x4	; 02328484
	ldr r1,[pool_0232855C]	; 02328488
	mov r10,r0	; 0232848C
	ldr r8,[r1,#0x4]	; 02328490
	mov r7,#0x0	; 02328494
	mov r9,r8	; 02328498
	ldr r5,[pool_02328560]	; 0232849C
	ldr r6,[pool_02328564]	; 023284A0
	mov r0,#0xb	; 023284A4
	str r0,[sp,#0x0]	; 023284A8
	mov r11,#0x1	; 023284AC
	ldr r4,[pool_02328568]	; 023284B0
loc_023284B4:
	mov r0,r10	; 023284B4
	mov r1,r11	; 023284B8
	mov r2,r11	; 023284BC
	bl P1_ReadP345Bits	; 023284C0
	cmp r0,#0x0	; 023284C4
	beq loc_023284F8	; 023284C8
	add r0,r7,#0x1	; 023284CC
	mov r2,r7, lsl #0x1	; 023284D0
	orr r3,r9,#0x8000	; 023284D4
	orr r1,r9,#0x4000	; 023284D8
	strh r3,[r6,r2]	; 023284DC
	mov r0,r0, lsl #0x1	; 023284E0
	strh r1,[r6,r0]	; 023284E4
	add r9,r9,#0x1	; 023284E8
	add r8,r8,#0x1	; 023284EC
	add r7,r7,#0x2	; 023284F0
	b loc_023284B4	; 023284F4
loc_023284F8:
	ldr r1,[sp,#0x0]	; 023284F8
	mov r0,r10	; 023284FC
	mov r2,r11	; 02328500
	bl P1_ReadP345Bits	; 02328504
loc_02328508:
	sub r7,r7,#0x1	; 02328508
	mov r1,r7, lsl #0x1	; 0232850C
	ldrh r2,[r6,r1]	; 02328510
	ands r1,r2,#0x8000	; 02328514
	beq loc_0232853C	; 02328518
	and r1,r2,r4	; 0232851C
	str r0,[r5,r1,lsl #0x2]	; 02328520
	mov r0,r1	; 02328524
	cmp r7,#0x0	; 02328528
	bne loc_02328508	; 0232852C
	add sp,sp,#0x4	; 02328530
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328534
	bx lr	; 02328538
loc_0232853C:
	ldr r1,[pool_0232856C]	; 0232853C
	and r2,r2,r4	; 02328540
	mov r9,r8	; 02328544
	str r0,[r1,r2,lsl #0x2]	; 02328548
	b loc_023284B4	; 0232854C
.endfunc
	.byte 0x04, 0xD0, 0x8D, 0xE2, 0xF0, 0x4F, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 0232855C
pool_0232855C:
loc_0232855C:
	.word P1_P345NodeBaseIds	; 0232855C
pool_02328560:
loc_02328560:
	.word P1_P345DistanceOneChildren	; 02328560
pool_02328564:
loc_02328564:
	.word P1_P345TreeStack	; 02328564
pool_02328568:
loc_02328568:
	.word 0x00003FFF	; 02328568
pool_0232856C:
loc_0232856C:
	.word P1_P345DistanceZeroChildren	; 0232856C

; ===== function loc_02328570 =====
loc_02328570:
; 重建字面量/长度树；叶子为 9 位，子节点使用 32 位表项。
; Build the literal/length tree: 9-bit leaves, 32-bit child entries.
.func P1_BuildP345LengthTree
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328570
	sub sp,sp,#0xc	; 02328574
	ldr r1,[pool_02328654]	; 02328578
	mov r10,r0	; 0232857C
	ldr r8,[r1,#0x0]	; 02328580
	mov r7,#0x0	; 02328584
	mov r9,r8	; 02328588
	ldr r5,[pool_02328658]	; 0232858C
	ldr r6,[pool_0232865C]	; 02328590
	str r7,[sp,#0x8]	; 02328594
	str r7,[sp,#0x0]	; 02328598
	mov r0,#0x9	; 0232859C
	str r0,[sp,#0x4]	; 023285A0
	mov r11,#0x1	; 023285A4
	ldr r4,[pool_02328660]	; 023285A8
loc_023285AC:
	ldr r2,[sp,#0x0]	; 023285AC
	mov r0,r10	; 023285B0
	mov r1,r11	; 023285B4
	bl P1_ReadP345Bits	; 023285B8
	cmp r0,#0x0	; 023285BC
	beq loc_023285F0	; 023285C0
	add r0,r7,#0x1	; 023285C4
	mov r1,r7, lsl #0x1	; 023285C8
	mov r0,r0, lsl #0x1	; 023285CC
	orr r2,r9,#0x8000	; 023285D0
	strh r2,[r6,r1]	; 023285D4
	orr r1,r9,#0x4000	; 023285D8
	strh r1,[r6,r0]	; 023285DC
	add r9,r9,#0x1	; 023285E0
	add r8,r8,#0x1	; 023285E4
	add r7,r7,#0x2	; 023285E8
	b loc_023285AC	; 023285EC
loc_023285F0:
	ldr r1,[sp,#0x4]	; 023285F0
	ldr r2,[sp,#0x8]	; 023285F4
	mov r0,r10	; 023285F8
	bl P1_ReadP345Bits	; 023285FC
loc_02328600:
	sub r7,r7,#0x1	; 02328600
	mov r1,r7, lsl #0x1	; 02328604
	ldrh r2,[r6,r1]	; 02328608
	ands r1,r2,#0x8000	; 0232860C
	beq loc_02328634	; 02328610
	and r1,r2,r4	; 02328614
	str r0,[r5,r1,lsl #0x2]	; 02328618
	mov r0,r1	; 0232861C
	cmp r7,#0x0	; 02328620
	bne loc_02328600	; 02328624
	add sp,sp,#0xc	; 02328628
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 0232862C
	bx lr	; 02328630
loc_02328634:
	ldr r1,[pool_02328664]	; 02328634
	and r2,r2,r4	; 02328638
	mov r9,r8	; 0232863C
	str r0,[r1,r2,lsl #0x2]	; 02328640
	b loc_023285AC	; 02328644
.endfunc
	.byte 0x0C, 0xD0, 0x8D, 0xE2, 0xF0, 0x4F, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 02328654
pool_02328654:
loc_02328654:
	.word P1_P345NodeBaseIds	; 02328654
pool_02328658:
loc_02328658:
	.word P1_P345LengthOneChildren	; 02328658
pool_0232865C:
loc_0232865C:
	.word P1_P345TreeStack	; 0232865C
pool_02328660:
loc_02328660:
	.word 0x00003FFF	; 02328660
pool_02328664:
loc_02328664:
	.word P1_P345LengthZeroChildren	; 02328664

; ===== function loc_02328668 =====
loc_02328668:
; r0=流首、r1=位数、r2=流索引；返回读出的位并推进游标。
; r0=stream base, r1=bit count, r2=stream index; return bits and advance.
.func P1_ReadP345Bits
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328668
	sub sp,sp,#0x4	; 0232866C
	ldr r6,[pool_02328778]	; 02328670
	ldr r8,[pool_0232877C]	; 02328674
	ldr r5,[r6,r2,lsl #0x2]	; 02328678
	ldr r4,[pool_02328780]	; 0232867C
	add r3,r5,r1	; 02328680
	cmp r3,#0x20	; 02328684
	mov r9,r2, lsl #0x2	; 02328688
	ldr r7,[r8,r2,lsl #0x2]	; 0232868C
	ldr lr,[r4,r2,lsl #0x2]	; 02328690
	ble loc_02328700	; 02328694
	add r2,r7,#0x1	; 02328698
	ldrb r10,[r0,r7]	; 0232869C
	ldrb r2,[r0,r2]	; 023286A0
	add r3,r7,#0x2	; 023286A4
	mov r11,r10, lsl #0x18	; 023286A8
	orr r2,r11,r2, lsl #0x10	; 023286AC
	rsb r11,r1,#0x20	; 023286B0
	sub r10,r1,#0x20	; 023286B4
	add r12,r7,#0x3	; 023286B8
	mov lr,lr, lsr r11	; 023286BC
	rsb r1,r1,#0x40	; 023286C0
	ldrb r3,[r0,r3]	; 023286C4
	ldrb r11,[r0,r12]	; 023286C8
	sub r1,r1,r5	; 023286CC
	orr r0,r2,r3, lsl #0x8	; 023286D0
	add r3,r5,r10	; 023286D4
	orr r10,r11,r0	; 023286D8
	mov r2,r10, lsl r3	; 023286DC
	add r0,r7,#0x4	; 023286E0
	str r0,[r8,r9]	; 023286E4
	add sp,sp,#0x4	; 023286E8
	str r2,[r4,r9]	; 023286EC
	str r3,[r6,r9]	; 023286F0
	orr r0,lr,r10, lsr r1	; 023286F4
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 023286F8
	bx lr	; 023286FC
loc_02328700:
	cmp r3,#0x20	; 02328700
	movne r2,lr, lsl r1	; 02328704
	rsbne r0,r1,#0x20	; 02328708
	addne sp,sp,#0x4	; 0232870C
	movne r0,lr, lsr r0	; 02328710
	strne r2,[r4,r9]	; 02328714
	strne r3,[r6,r9]	; 02328718
	ldmneia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 0232871C
	bxne lr	; 02328720
	add r3,r7,#0x1	; 02328724
	ldrb r5,[r0,r7]	; 02328728
	add r10,r7,#0x2	; 0232872C
	ldrb r3,[r0,r3]	; 02328730
	mov r5,r5, lsl #0x18	; 02328734
	add r2,r7,#0x3	; 02328738
	orr r3,r5,r3, lsl #0x10	; 0232873C
	ldrb r5,[r0,r2]	; 02328740
	ldrb r10,[r0,r10]	; 02328744
	add r2,r7,#0x4	; 02328748
	orr r0,r3,r10, lsl #0x8	; 0232874C
	orr r3,r5,r0	; 02328750
	rsb r0,r1,#0x20	; 02328754
	mov r1,#0x0	; 02328758
	mov r0,lr, lsr r0	; 0232875C
	str r3,[r4,r9]	; 02328760
	str r2,[r8,r9]	; 02328764
	str r1,[r6,r9]	; 02328768
	add sp,sp,#0x4	; 0232876C
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,lr}	; 02328770
	bx lr	; 02328774
.endfunc
pool_02328778:
loc_02328778:
	.word P1_P345BitPositions	; 02328778
pool_0232877C:
loc_0232877C:
	.word P1_P345StreamOffsets	; 0232877C
pool_02328780:
loc_02328780:
	.word P1_P345ShiftedWords	; 02328780
.thumb

; ===== function loc_02328784 =====
loc_02328784:
	push {r4,lr}	; 02328784
	add r4,r0,#0x0	; 02328786
	bl loc_02328B30	; 02328788
	ldrh r1,[r4,#0x12]	; 0232878C
	cmp r0,r1	; 0232878E
	beq loc_0232879C	; 02328790
	strh r0,[r4,#0x12]	; 02328792
	mov r0,#0x1	; 02328794
	pop {r4}	; 02328796
	pop {r3}	; 02328798
	bx r3	; 0232879A
loc_0232879C:
	mov r0,#0x0	; 0232879C
	pop {r4}	; 0232879E
	pop {r3}	; 023287A0
	bx r3	; 023287A2

; ===== function loc_023287A4 =====
P1_Entry_023287A4:
	push {r4,lr}	; 023287A4
	add r4,r0,#0x0	; 023287A6
	bl loc_02328B30	; 023287A8
	ldr r1,[r4,#0xc]	; 023287AC
	lsl r0,r0,#0x1	; 023287AE
	ldrb r0,[r1,r0]	; 023287B0
	pop {r4}	; 023287B2
	pop {r3}	; 023287B4
	bx r3	; 023287B6

; ===== function loc_023287B8 =====
loc_023287B8:
	ldrh r0,[r0,#0x16]	; 023287B8
	lsl r0,r0,#0x16	; 023287BA
	lsr r0,r0,#0x1b	; 023287BC
	ldrh r3,[r1,#0x0]	; 023287BE
	cmp r3,#0x0	; 023287C0
	beq loc_023287D4	; 023287C2
	add r2,r2,r0	; 023287C4
loc_023287C6:
	cmp r3,#0xa	; 023287C6
	bne loc_023287CC	; 023287C8
	add r0,r0,r2	; 023287CA
loc_023287CC:
	add r1,r1,#0x2	; 023287CC
	ldrh r3,[r1,#0x0]	; 023287CE
	cmp r3,#0x0	; 023287D0
	bne loc_023287C6	; 023287D2
loc_023287D4:
	bx lr	; 023287D4
	.byte 0x00, 0x00	; 023287D8

; ===== function loc_023287D8 =====
loc_023287D8:
	push {r4,r5,r6,r7,lr}	; 023287D8
	sub sp,#0x4	; 023287DA
	add r5,r0,#0x0	; 023287DC
	add r6,r2,#0x0	; 023287DE
	mov r4,#0x0	; 023287E0
	str r4,[sp,#0x0]	; 023287E2
	cmp r1,#0x0	; 023287E4
	beq loc_02328802	; 023287E6
	add r7,sp,#0x0	; 023287E8
loc_023287EA:
	add r0,r5,#0x0	; 023287EA
	add r2,r7,#0x0	; 023287EC
	add r3,r6,#0x0	; 023287EE
	bl loc_0232880C	; 023287F0
	add r1,r0,#0x0	; 023287F4
	ldr r0,[sp,#0x0]	; 023287F6
	cmp r4,r0	; 023287F8
	bge loc_023287FE	; 023287FA
	add r4,r0,#0x0	; 023287FC
loc_023287FE:
	cmp r1,#0x0	; 023287FE
	bne loc_023287EA	; 02328800
loc_02328802:
	add r0,r4,#0x0	; 02328802
	add sp,#0x4	; 02328804
	pop {r4,r5,r6,r7}	; 02328806
	pop {r3}	; 02328808
	bx r3	; 0232880A

; ===== function loc_0232880C =====
loc_0232880C:
	push {r4,r5,r6,r7,lr}	; 0232880C
	sub sp,#0x4	; 0232880E
	add r7,r0,#0x0	; 02328810
	add r5,r1,#0x0	; 02328812
	str r2,[sp,#0x0]	; 02328814
	add r6,r3,#0x0	; 02328816
	mov r4,#0x0	; 02328818
	ldrh r1,[r5,#0x0]	; 0232881A
	cmp r1,#0x0	; 0232881C
	beq loc_02328854	; 0232881E
loc_02328820:
	cmp r1,#0xa	; 02328820
	bne loc_0232883E	; 02328822
	ldr r0,[sp,#0x0]	; 02328824
	cmp r0,#0x0	; 02328826
	beq loc_02328834	; 02328828
	cmp r4,r6	; 0232882A
	ble loc_02328830	; 0232882C
	sub r4,r4,r6	; 0232882E
loc_02328830:
	ldr r0,[sp,#0x0]	; 02328830
	str r4,[r0,#0x0]	; 02328832
loc_02328834:
	add r0,r5,#0x2	; 02328834
	add sp,#0x4	; 02328836
	pop {r4,r5,r6,r7}	; 02328838
	pop {r3}	; 0232883A
	bx r3	; 0232883C
loc_0232883E:
	cmp r1,#0xd	; 0232883E
	beq loc_0232884C	; 02328840
	add r0,r7,#0x0	; 02328842
	bl loc_02328870	; 02328844
	add r0,r6,r0	; 02328848
	add r4,r4,r0	; 0232884A
loc_0232884C:
	add r5,r5,#0x2	; 0232884C
	ldrh r1,[r5,#0x0]	; 0232884E
	cmp r1,#0x0	; 02328850
	bne loc_02328820	; 02328852
loc_02328854:
	ldr r0,[sp,#0x0]	; 02328854
	cmp r0,#0x0	; 02328856
	beq loc_02328864	; 02328858
	cmp r4,r6	; 0232885A
	ble loc_02328860	; 0232885C
	sub r4,r4,r6	; 0232885E
loc_02328860:
	ldr r0,[sp,#0x0]	; 02328860
	str r4,[r0,#0x0]	; 02328862
loc_02328864:
	mov r0,#0x0	; 02328864
	add sp,#0x4	; 02328866
	pop {r4,r5,r6,r7}	; 02328868
	pop {r3}	; 0232886A
	bx r3	; 0232886C
	.byte 0x00, 0x00	; 02328870

; ===== function loc_02328870 =====
loc_02328870:
	push {r4,lr}	; 02328870
	add r4,r0,#0x0	; 02328872
	bl loc_02328B30	; 02328874
	ldr r1,[r4,#0xc]	; 02328878
	lsl r0,r0,#0x1	; 0232887A
	add r0,r1,r0	; 0232887C
	ldrb r0,[r0,#0x1]	; 0232887E
	pop {r4}	; 02328880
	pop {r3}	; 02328882
	bx r3	; 02328884
	.byte 0x00, 0x00	; 02328888

; ===== function loc_02328888 =====
loc_02328888:
	push {r0,r1,r2,r3}	; 02328888
	push {r4,r5,r6,r7,lr}	; 0232888A
	sub sp,#0x1c	; 0232888C
	add r5,r0,#0x0	; 0232888E
	str r1,[sp,#0x8]	; 02328890
	ldr r1,[sp,#0x40]	; 02328892
	str r1,[sp,#0x40]	; 02328894
	ldr r1,[sp,#0x44]	; 02328896
	str r1,[sp,#0x44]	; 02328898
	ldr r6,[sp,#0x48]	; 0232889A
	ldr r1,[sp,#0x4c]	; 0232889C
	str r1,[sp,#0x4c]	; 0232889E
	add r1,r6,#0x0	; 023288A0
	ldr r2,[sp,#0x40]	; 023288A2
	bl loc_023287D8	; 023288A4
	add r4,r0,#0x0	; 023288A8
	add r0,r5,#0x0	; 023288AA
	add r1,r6,#0x0	; 023288AC
	ldr r2,[sp,#0x44]	; 023288AE
	bl loc_023287B8	; 023288B0
	str r0,[sp,#0x14]	; 023288B4
	mov r1,sp	; 023288B6
	sub r1,r1,#0x4	; 023288B8
	add r0,sp,#0x30	; 023288BA
	ldrh r0,[r0,#0x8]	; 023288BC
	strh r0,[r1,#0x0]	; 023288BE
	ldmia r1!,{r0}	; 023288C0
	add r1,r4,#0x0	; 023288C2
	bl loc_02328CA4	; 023288C4
	add r7,r0,#0x0	; 023288C8
	mov r1,sp	; 023288CA
	sub r1,r1,#0x4	; 023288CC
	add r0,sp,#0x30	; 023288CE
	ldrh r0,[r0,#0xc]	; 023288D0
	strh r0,[r1,#0x0]	; 023288D2
	ldmia r1!,{r0}	; 023288D4
	ldr r1,[sp,#0x14]	; 023288D6
	bl loc_02328C6C	; 023288D8
	str r0,[sp,#0x10]	; 023288DC
	mov r1,sp	; 023288DE
	sub r1,r1,#0x4	; 023288E0
	add r0,sp,#0x30	; 023288E2
	ldrh r0,[r0,#0x8]	; 023288E4
	strh r0,[r1,#0x0]	; 023288E6
	ldmia r1!,{r0}	; 023288E8
	add r1,r4,#0x0	; 023288EA
	bl loc_02328998	; 023288EC
	add r4,r7,r0	; 023288F0
	str r4,[sp,#0xc]	; 023288F2
	add r0,r5,#0x0	; 023288F4
	add r1,r6,#0x0	; 023288F6
	add r2,sp,#0x18	; 023288F8
	ldr r3,[sp,#0x40]	; 023288FA
	bl loc_0232880C	; 023288FC
	mov r1,sp	; 02328900
	sub r1,r1,#0x4	; 02328902
	add r0,sp,#0x30	; 02328904
	ldrh r0,[r0,#0x8]	; 02328906
	strh r0,[r1,#0x0]	; 02328908
	ldmia r1!,{r0}	; 0232890A
	ldr r1,[sp,#0x18]	; 0232890C
	bl loc_02328998	; 0232890E
	sub r4,r4,r0	; 02328912
	ldrh r1,[r6,#0x0]	; 02328914
	cmp r1,#0x0	; 02328916
	beq loc_0232898C	; 02328918
loc_0232891A:
	cmp r1,#0xa	; 0232891A
	bne loc_02328952	; 0232891C
	add r0,r5,#0x0	; 0232891E
	add r1,r6,#0x2	; 02328920
	add r2,sp,#0x18	; 02328922
	ldr r3,[sp,#0x40]	; 02328924
	bl loc_0232880C	; 02328926
	mov r1,sp	; 0232892A
	sub r1,r1,#0x4	; 0232892C
	add r0,sp,#0x30	; 0232892E
	ldrh r0,[r0,#0x8]	; 02328930
	strh r0,[r1,#0x0]	; 02328932
	ldmia r1!,{r0}	; 02328934
	ldr r1,[sp,#0x18]	; 02328936
	bl loc_02328998	; 02328938
	ldr r1,[sp,#0xc]	; 0232893C
	sub r4,r1,r0	; 0232893E
	ldrh r0,[r5,#0x16]	; 02328940
	lsl r0,r0,#0x16	; 02328942
	lsr r1,r0,#0x1b	; 02328944
	ldr r0,[sp,#0x44]	; 02328946
	add r1,r1,r0	; 02328948
	ldr r0,[sp,#0x10]	; 0232894A
	add r0,r0,r1	; 0232894C
	str r0,[sp,#0x10]	; 0232894E
	b loc_02328984	; 02328950
loc_02328952:
	cmp r1,#0xd	; 02328952
	beq loc_02328984	; 02328954
	add r0,r5,#0x0	; 02328956
	bl loc_02328B30	; 02328958
	lsl r0,r0,#0x10	; 0232895C
	lsr r0,r0,#0x10	; 0232895E
	lsl r7,r0,#0x1	; 02328960
	str r0,[sp,#0x0]	; 02328962
	ldr r0,[sp,#0x4c]	; 02328964
	str r0,[sp,#0x4]	; 02328966
	add r0,r5,#0x0	; 02328968
	ldr r1,[sp,#0x8]	; 0232896A
	ldr r2,[r5,#0xc]	; 0232896C
	ldrb r2,[r2,r7]	; 0232896E
	sub r2,r4,r2	; 02328970
	ldr r3,[sp,#0x10]	; 02328972
	bl loc_023289CC	; 02328974
	ldr r0,[r5,#0xc]	; 02328978
	add r0,r0,r7	; 0232897A
	ldrb r1,[r0,#0x1]	; 0232897C
	ldr r0,[sp,#0x40]	; 0232897E
	add r0,r0,r1	; 02328980
	add r4,r4,r0	; 02328982
loc_02328984:
	add r6,r6,#0x2	; 02328984
	ldrh r1,[r6,#0x0]	; 02328986
	cmp r1,#0x0	; 02328988
	bne loc_0232891A	; 0232898A
loc_0232898C:
	add sp,#0x1c	; 0232898C
	pop {r4,r5,r6,r7}	; 0232898E
	pop {r3}	; 02328990
	add sp,#0x10	; 02328992
	bx r3	; 02328994
	.byte 0x00, 0x00	; 02328998

; ===== function loc_02328998 =====
loc_02328998:
	push {r0,r1,r2,r3}	; 02328998
	push {lr}	; 0232899A
	sub sp,#0x4	; 0232899C
	add r0,sp,#0x8	; 0232899E
	ldrh r0,[r0,#0x0]	; 023289A0
	lsl r0,r0,#0x10	; 023289A2
	lsr r0,r0,#0x1e	; 023289A4
	cmp r0,#0x1	; 023289A6
	bne loc_023289BA	; 023289A8
	add r0,r1,#0x1	; 023289AA
	mov r1,#0x2	; 023289AC
	blx P1_SignedDivMod	; 023289AE
	add sp,#0x4	; 023289B2
	pop {r3}	; 023289B4
	add sp,#0x10	; 023289B6
	bx r3	; 023289B8
loc_023289BA:
	cmp r0,#0x2	; 023289BA
	beq loc_023289C0	; 023289BC
	mov r1,#0x0	; 023289BE
loc_023289C0:
	add r0,r1,#0x0	; 023289C0
	add sp,#0x4	; 023289C2
	pop {r3}	; 023289C4
	add sp,#0x10	; 023289C6
	bx r3	; 023289C8
	.byte 0x00, 0x00	; 023289CC

; ===== function loc_023289CC =====
loc_023289CC:
	push {r4,r5,r6,r7,lr}	; 023289CC
	sub sp,#0x2c	; 023289CE
	str r1,[sp,#0x0]	; 023289D0
	str r2,[sp,#0x4]	; 023289D2
	str r3,[sp,#0x8]	; 023289D4
	ldr r1,[sp,#0x44]	; 023289D6
	str r1,[sp,#0x44]	; 023289D8
	mov r5,#0x0	; 023289DA
	add r4,r5,#0x0	; 023289DC
	ldrh r2,[r0,#0x16]	; 023289DE
	add r1,sp,#0x24	; 023289E0
	strh r2,[r1,#0x0]	; 023289E2
	ldr r2,[r0,#0x0]	; 023289E4
	mov r3,#0x14	; 023289E6
	ldrsh r3,[r0,r3]	; 023289E8
	add r0,sp,#0x30	; 023289EA
	ldrh r0,[r0,#0x10]	; 023289EC
	mul r3,r0	; 023289EE
	lsl r0,r3,#0x1	; 023289F0
	add r7,r2,r0	; 023289F2
	str r5,[sp,#0xc]	; 023289F4
	ldrh r1,[r1,#0x0]	; 023289F6
	lsl r0,r1,#0x16	; 023289F8
	lsr r0,r0,#0x1b	; 023289FA
	str r0,[sp,#0x14]	; 023289FC
	cmp r0,#0x0	; 023289FE
	ble loc_02328A60	; 02328A00
	lsl r0,r1,#0x1b	; 02328A02
	lsr r0,r0,#0x1b	; 02328A04
	str r0,[sp,#0x10]	; 02328A06
	str r5,[sp,#0x20]	; 02328A08
	str r5,[sp,#0x1c]	; 02328A0A
loc_02328A0C:
	ldr r6,[sp,#0x1c]	; 02328A0C
	ldr r0,[sp,#0x10]	; 02328A0E
	cmp r0,#0x0	; 02328A10
	ble loc_02328A54	; 02328A12
	ldr r1,[sp,#0x8]	; 02328A14
	ldr r0,[sp,#0xc]	; 02328A16
	add r0,r1,r0	; 02328A18
	str r0,[sp,#0x18]	; 02328A1A
loc_02328A1C:
	cmp r4,#0x0	; 02328A1C
	bne loc_02328A22	; 02328A1E
	ldrh r5,[r7,#0x0]	; 02328A20
loc_02328A22:
	add r1,r5,#0x0	; 02328A22
	mov r0,#0x1	; 02328A24
	and r1,r0	; 02328A26
	cmp r1,#0x0	; 02328A28
	bne loc_02328A3A	; 02328A2A
	ldr r0,[sp,#0x0]	; 02328A2C
	ldr r1,[sp,#0x4]	; 02328A2E
	add r1,r1,r6	; 02328A30
	ldr r2,[sp,#0x18]	; 02328A32
	ldr r3,[sp,#0x44]	; 02328A34
	bl loc_02328A9C	; 02328A36
loc_02328A3A:
	lsl r0,r5,#0xf	; 02328A3A
	lsr r5,r0,#0x10	; 02328A3C
	add r0,r4,#0x1	; 02328A3E
	lsl r0,r0,#0x10	; 02328A40
	lsr r4,r0,#0x10	; 02328A42
	cmp r4,#0xf	; 02328A44
	bls loc_02328A4C	; 02328A46
	ldr r4,[sp,#0x20]	; 02328A48
	add r7,r7,#0x2	; 02328A4A
loc_02328A4C:
	add r6,r6,#0x1	; 02328A4C
	ldr r0,[sp,#0x10]	; 02328A4E
	cmp r6,r0	; 02328A50
	blt loc_02328A1C	; 02328A52
loc_02328A54:
	ldr r0,[sp,#0xc]	; 02328A54
	add r1,r0,#0x1	; 02328A56
	str r1,[sp,#0xc]	; 02328A58
	ldr r0,[sp,#0x14]	; 02328A5A
	cmp r1,r0	; 02328A5C
	blt loc_02328A0C	; 02328A5E
loc_02328A60:
	add sp,#0x2c	; 02328A60
	pop {r4,r5,r6,r7}	; 02328A62
	pop {r3}	; 02328A64
	bx r3	; 02328A66

; ===== function loc_02328A68 =====
P1_Entry_02328A68:
	push {r4,r5,r6,r7,lr}	; 02328A68
	sub sp,#0xc	; 02328A6A
	add r5,r0,#0x0	; 02328A6C
	add r4,r1,#0x0	; 02328A6E
	add r6,r2,#0x0	; 02328A70
	add r7,r3,#0x0	; 02328A72
	add r1,sp,#0x10	; 02328A74
	ldrh r1,[r1,#0x10]	; 02328A76
	bl loc_02328B30	; 02328A78
	lsl r0,r0,#0x10	; 02328A7C
	lsr r0,r0,#0x10	; 02328A7E
	str r0,[sp,#0x0]	; 02328A80
	ldr r0,[sp,#0x24]	; 02328A82
	str r0,[sp,#0x4]	; 02328A84
	add r0,r5,#0x0	; 02328A86
	add r1,r4,#0x0	; 02328A88
	add r2,r6,#0x0	; 02328A8A
	add r3,r7,#0x0	; 02328A8C
	bl loc_023289CC	; 02328A8E
	add sp,#0xc	; 02328A92
	pop {r4,r5,r6,r7}	; 02328A94
	pop {r3}	; 02328A96
	bx r3	; 02328A98
	.byte 0x00, 0x00	; 02328A9C

; ===== function loc_02328A9C =====
loc_02328A9C:
	push {r4,lr}	; 02328A9C
	ldrh r4,[r0,#0x8]	; 02328A9E
	cmp r4,#0x0	; 02328AA0
	bne loc_02328AA8	; 02328AA2
	bl loc_02328AB0	; 02328AA4
loc_02328AA8:
	pop {r4}	; 02328AA8
	pop {r3}	; 02328AAA
	bx r3	; 02328AAC
	.byte 0x00, 0x00	; 02328AB0

; ===== function loc_02328AB0 =====
loc_02328AB0:
	push {r4,r5,r6,r7}	; 02328AB0
	sub sp,#0x18	; 02328AB2
	add r4,r0,#0x0	; 02328AB4
	add r0,r1,#0x0	; 02328AB6
	add r5,r2,#0x0	; 02328AB8
	str r3,[sp,#0x0]	; 02328ABA
	asr r3,r0,#0x3	; 02328ABC
	asr r7,r5,#0x3	; 02328ABE
	mov r2,#0x3	; 02328AC0
	str r1,[sp,#0x10]	; 02328AC2
	and r1,r2	; 02328AC4
	str r1,[sp,#0x10]	; 02328AC6
	asr r2,r0,#0x2	; 02328AC8
	mov r1,#0x1	; 02328ACA
	and r2,r1	; 02328ACC
	mov r6,#0x7	; 02328ACE
	add r1,r5,#0x0	; 02328AD0
	str r1,[sp,#0x4]	; 02328AD2
	and r1,r6	; 02328AD4
	str r1,[sp,#0x4]	; 02328AD6
	ldrh r1,[r4,#0x4]	; 02328AD8
	str r1,[sp,#0x8]	; 02328ADA
	lsl r1,r1,#0x4	; 02328ADC
	asr r1,r1,#0x3	; 02328ADE
	ldr r6,[r4,#0x0]	; 02328AE0
	str r6,[sp,#0xc]	; 02328AE2
	cmp r0,#0x0	; 02328AE4
	blt loc_02328B28	; 02328AE6
	ldr r6,[sp,#0x8]	; 02328AE8
	cmp r0,r6	; 02328AEA
	bge loc_02328B28	; 02328AEC
	cmp r5,#0x0	; 02328AEE
	blt loc_02328B28	; 02328AF0
	ldrh r0,[r4,#0x6]	; 02328AF2
	cmp r5,r0	; 02328AF4
	bge loc_02328B28	; 02328AF6
	lsl r0,r3,#0x4	; 02328AF8
	mul r1,r7	; 02328AFA
	add r0,r0,r1	; 02328AFC
	lsl r1,r0,#0x1	; 02328AFE
	ldr r0,[sp,#0xc]	; 02328B00
	add r4,r0,r1	; 02328B02
	ldr r0,[sp,#0x4]	; 02328B04
	lsl r0,r0,#0x1	; 02328B06
	add r0,r2,r0	; 02328B08
	lsl r3,r0,#0x1	; 02328B0A
	ldr r0,[sp,#0x10]	; 02328B0C
	lsl r2,r0,#0x2	; 02328B0E
	ldrh r1,[r4,r3]	; 02328B10
	mov r0,#0xf	; 02328B12
	add r5,r0,#0x0	; 02328B14
	lsl r5,r2	; 02328B16
	bic r1,r5	; 02328B18
	ldr r5,[sp,#0x0]	; 02328B1A
	lsl r5,r5,#0x18	; 02328B1C
	lsr r5,r5,#0x18	; 02328B1E
	and r5,r0	; 02328B20
	lsl r5,r2	; 02328B22
	orr r1,r5	; 02328B24
	strh r1,[r4,r3]	; 02328B26
loc_02328B28:
	add sp,#0x18	; 02328B28
	pop {r4,r5,r6,r7}	; 02328B2A
	bx lr	; 02328B2C
	.byte 0x00, 0x00	; 02328B30

; ===== function loc_02328B30 =====
loc_02328B30:
	push {r4,r5,r6,r7,lr}	; 02328B30
	sub sp,#0x14	; 02328B32
	str r0,[sp,#0x8]	; 02328B34
	add r6,r1,#0x0	; 02328B36
	mov r5,#0x0	; 02328B38
	add r7,r5,#0x0	; 02328B3A
	ldrh r0,[r0,#0x1a]	; 02328B3C
	str r0,[sp,#0xc]	; 02328B3E
	cmp r0,#0x0	; 02328B40
	ble loc_02328B82	; 02328B42
	ldr r0,[sp,#0x8]	; 02328B44
	ldr r2,[r0,#0x8]	; 02328B46
	add r4,r2,#0x0	; 02328B48
	add r3,r5,#0x0	; 02328B4A
loc_02328B4C:
	ldrh r0,[r4,#0x0]	; 02328B4C
	cmp r0,r6	; 02328B4E
	bhi loc_02328B6A	; 02328B50
	add r0,r2,r3	; 02328B52
	ldrh r0,[r0,#0x2]	; 02328B54
	cmp r6,r0	; 02328B56
	bhi loc_02328B6A	; 02328B58
	add r1,r5,r6	; 02328B5A
	lsl r0,r7,#0x2	; 02328B5C
	ldrh r0,[r2,r0]	; 02328B5E
	sub r0,r1,r0	; 02328B60
	add sp,#0x14	; 02328B62
	pop {r4,r5,r6,r7}	; 02328B64
	pop {r3}	; 02328B66
	bx r3	; 02328B68
loc_02328B6A:
	add r0,r2,r3	; 02328B6A
	ldrh r1,[r0,#0x2]	; 02328B6C
	ldrh r0,[r2,r3]	; 02328B6E
	sub r0,r1,r0	; 02328B70
	add r0,r0,#0x1	; 02328B72
	add r5,r5,r0	; 02328B74
	add r4,r4,#0x4	; 02328B76
	add r3,r3,#0x4	; 02328B78
	add r7,r7,#0x1	; 02328B7A
	ldr r0,[sp,#0xc]	; 02328B7C
	cmp r7,r0	; 02328B7E
	blt loc_02328B4C	; 02328B80
loc_02328B82:
	lsl r0,r5,#0x10	; 02328B82
	lsr r0,r0,#0x10	; 02328B84
	str r0,[sp,#0x0]	; 02328B86
	ldr r0,[sp,#0x8]	; 02328B88
	ldrh r0,[r0,#0x12]	; 02328B8A
	str r0,[sp,#0x4]	; 02328B8C
	add r0,r6,#0x0	; 02328B8E
	mov r1,#0x0	; 02328B90
	ldr r2,[sp,#0x8]	; 02328B92
	ldrh r2,[r2,#0x18]	; 02328B94
	sub r2,r2,#0x1	; 02328B96
	ldr r3,[sp,#0x8]	; 02328B98
	ldr r3,[r3,#0x4]	; 02328B9A
	bl loc_02328BA8	; 02328B9C
	add sp,#0x14	; 02328BA0
	pop {r4,r5,r6,r7}	; 02328BA2
	pop {r3}	; 02328BA4
	bx r3	; 02328BA6

; ===== function loc_02328BA8 =====
loc_02328BA8:
	push {r4,r5}	; 02328BA8
	cmp r1,r2	; 02328BAA
	bgt loc_02328BD8	; 02328BAC
loc_02328BAE:
	sub r4,r2,r1	; 02328BAE
	asr r4,r4,#0x1	; 02328BB0
	add r4,r1,r4	; 02328BB2
	lsl r5,r4,#0x1	; 02328BB4
	ldrh r5,[r3,r5]	; 02328BB6
	cmp r5,r0	; 02328BB8
	bls loc_02328BC0	; 02328BBA
	sub r2,r4,#0x1	; 02328BBC
	b loc_02328BD4	; 02328BBE
loc_02328BC0:
	cmp r5,r0	; 02328BC0
	bcs loc_02328BC8	; 02328BC2
	add r1,r4,#0x1	; 02328BC4
	b loc_02328BD4	; 02328BC6
loc_02328BC8:
	ldr r0,[pool_02328BE4]	; 02328BC8
	add r0,sp	; 02328BCA
	ldrh r0,[r0,#0x10]	; 02328BCC
	add r0,r0,r4	; 02328BCE
	pop {r4,r5}	; 02328BD0
	bx lr	; 02328BD2
loc_02328BD4:
	cmp r1,r2	; 02328BD4
	ble loc_02328BAE	; 02328BD6
loc_02328BD8:
	ldr r0,[pool_02328BE4]	; 02328BD8
	add r0,sp	; 02328BDA
	ldrh r0,[r0,#0x14]	; 02328BDC
	pop {r4,r5}	; 02328BDE
	bx lr	; 02328BE0
	.byte 0xC0, 0x46	; 02328BE4
pool_02328BE4:
loc_02328BE4:
	.word 0xFFFFFFF8	; 02328BE4

; ===== function loc_02328BE8 =====
loc_02328BE8:
	str r1,[r0,#0x0]	; 02328BE8
	strh r2,[r0,#0x4]	; 02328BEA
	strh r3,[r0,#0x6]	; 02328BEC
	ldr r1,[sp,#0x0]	; 02328BEE
	strh r1,[r0,#0x8]	; 02328BF0
	ldr r1,[sp,#0x4]	; 02328BF2
	str r1,[r0,#0xc]	; 02328BF4
	bx lr	; 02328BF6

; ===== function loc_02328BF8 =====
loc_02328BF8:
	push {r4}	; 02328BF8
	sub sp,#0x4	; 02328BFA
	ldrh r3,[r1,#0x6]	; 02328BFC
	strh r3,[r0,#0x10]	; 02328BFE
	ldrh r3,[r1,#0x8]	; 02328C00
	strh r3,[r0,#0x16]	; 02328C02
	add r1,#0xa	; 02328C04
	str r1,[r0,#0xc]	; 02328C06
	ldr r3,[r0,#0xc]	; 02328C08
	ldrh r1,[r0,#0x10]	; 02328C0A
	lsl r1,r1,#0x1	; 02328C0C
	add r1,r3,r1	; 02328C0E
	str r1,[r0,#0x0]	; 02328C10
	ldrh r1,[r0,#0x16]	; 02328C12
	lsl r3,r1,#0x1b	; 02328C14
	lsr r3,r3,#0x1b	; 02328C16
	lsl r1,r1,#0x16	; 02328C18
	lsr r1,r1,#0x1b	; 02328C1A
	mul r3,r1	; 02328C1C
	add r3,#0xf	; 02328C1E
	asr r1,r3,#0x4	; 02328C20
	strh r1,[r0,#0x14]	; 02328C22
	mov r1,#0x0	; 02328C24
	strh r1,[r0,#0x12]	; 02328C26
	add r4,r0,#0x0	; 02328C28
	add r4,#0x1c	; 02328C2A
	ldr r3,[r4,#0x0]	; 02328C2C
	mov r1,#0x1	; 02328C2E
	bic r3,r1	; 02328C30
	orr r3,r1	; 02328C32
	str r3,[r4,#0x0]	; 02328C34
	ldr r3,[r4,#0x0]	; 02328C36
	mov r1,#0x2	; 02328C38
	orr r3,r1	; 02328C3A
	str r3,[r4,#0x0]	; 02328C3C
	add r1,r2,#0x0	; 02328C3E
	add r1,#0x8	; 02328C40
	ldr r3,[r1,#0x4]	; 02328C42
	add r3,r2,r3	; 02328C44
	ldrh r3,[r3,#0x8]	; 02328C46
	strh r3,[r0,#0x18]	; 02328C48
	add r4,r2,#0x0	; 02328C4A
	add r4,#0xc	; 02328C4C
	ldr r3,[r1,#0x4]	; 02328C4E
	add r3,r4,r3	; 02328C50
	str r3,[r0,#0x4]	; 02328C52
	ldr r3,[r1,#0x0]	; 02328C54
	add r3,r2,r3	; 02328C56
	ldrh r3,[r3,#0x8]	; 02328C58
	strh r3,[r0,#0x1a]	; 02328C5A
	add r2,#0xa	; 02328C5C
	ldr r1,[r1,#0x0]	; 02328C5E
	add r1,r2,r1	; 02328C60
	str r1,[r0,#0x8]	; 02328C62
	add sp,#0x4	; 02328C64
	pop {r4}	; 02328C66
	bx lr	; 02328C68
	.byte 0x00, 0x00	; 02328C6C

; ===== function loc_02328C6C =====
loc_02328C6C:
	push {r0,r1,r2,r3}	; 02328C6C
	push {r4,lr}	; 02328C6E
	add r2,sp,#0x8	; 02328C70
	mov r0,#0x0	; 02328C72
	ldrsh r0,[r2,r0]	; 02328C74
	lsl r0,r0,#0x14	; 02328C76
	asr r4,r0,#0x14	; 02328C78
	ldrh r0,[r2,#0x0]	; 02328C7A
	lsl r0,r0,#0x12	; 02328C7C
	lsr r0,r0,#0x1e	; 02328C7E
	cmp r0,#0x1	; 02328C80
	beq loc_02328C8A	; 02328C82
	cmp r0,#0x2	; 02328C84
	beq loc_02328C96	; 02328C86
	b loc_02328C98	; 02328C88
loc_02328C8A:
	add r0,r1,#0x1	; 02328C8A
	mov r1,#0x2	; 02328C8C
	blx P1_SignedDivMod	; 02328C8E
	sub r4,r4,r0	; 02328C92
	b loc_02328C98	; 02328C94
loc_02328C96:
	sub r4,r4,r1	; 02328C96
loc_02328C98:
	add r0,r4,#0x0	; 02328C98
	pop {r4}	; 02328C9A
	pop {r3}	; 02328C9C
	add sp,#0x10	; 02328C9E
	bx r3	; 02328CA0
	.byte 0x00, 0x00	; 02328CA4

; ===== function loc_02328CA4 =====
loc_02328CA4:
	push {r0,r1,r2,r3}	; 02328CA4
	push {r4,lr}	; 02328CA6
	add r2,sp,#0x8	; 02328CA8
	mov r0,#0x0	; 02328CAA
	ldrsh r0,[r2,r0]	; 02328CAC
	lsl r0,r0,#0x14	; 02328CAE
	asr r4,r0,#0x14	; 02328CB0
	ldrh r0,[r2,#0x0]	; 02328CB2
	lsl r0,r0,#0x12	; 02328CB4
	lsr r0,r0,#0x1e	; 02328CB6
	cmp r0,#0x1	; 02328CB8
	beq loc_02328CC2	; 02328CBA
	cmp r0,#0x2	; 02328CBC
	beq loc_02328CCE	; 02328CBE
	b loc_02328CD0	; 02328CC0
loc_02328CC2:
	add r0,r1,#0x1	; 02328CC2
	mov r1,#0x2	; 02328CC4
	blx P1_SignedDivMod	; 02328CC6
	sub r4,r4,r0	; 02328CCA
	b loc_02328CD0	; 02328CCC
loc_02328CCE:
	sub r4,r4,r1	; 02328CCE
loc_02328CD0:
	add r0,r4,#0x0	; 02328CD0
	pop {r4}	; 02328CD2
	pop {r3}	; 02328CD4
	add sp,#0x10	; 02328CD6
	bx r3	; 02328CD8
	.byte 0x00, 0x00	; 02328CDC

; ===== function loc_02328CDC =====
loc_02328CDC:
	push {r4,r5,lr}	; 02328CDC
	sub sp,#0x14	; 02328CDE
	add r4,r0,#0x0	; 02328CE0
	add r3,r1,#0x0	; 02328CE2
	mov r0,#0x4	; 02328CE4
	ldrsb r0,[r3,r0]	; 02328CE6
	str r0,[sp,#0x0]	; 02328CE8
	mov r0,#0x5	; 02328CEA
	ldrsb r0,[r3,r0]	; 02328CEC
	str r0,[sp,#0x4]	; 02328CEE
	str r2,[sp,#0x8]	; 02328CF0
	ldrb r0,[r3,#0x6]	; 02328CF2
	str r0,[sp,#0xc]	; 02328CF4
	ldr r1,[r4,#0xc]	; 02328CF6
	ldrh r0,[r3,#0x6]	; 02328CF8
	lsl r0,r0,#0x10	; 02328CFA
	lsr r0,r0,#0x1c	; 02328CFC
	lsl r0,r0,#0x5	; 02328CFE
	add r0,r1,r0	; 02328D00
	add r1,r4,#0x0	; 02328D02
	mov r4,sp	; 02328D04
	sub r4,r4,#0x4	; 02328D06
	ldrh r2,[r3,#0x0]	; 02328D08
	strh r2,[r4,#0x0]	; 02328D0A
	add r5,r4,#0x0	; 02328D0C
	ldmia r5!,{r2}	; 02328D0E
	ldrh r3,[r3,#0x2]	; 02328D10
	strh r3,[r4,#0x0]	; 02328D12
	ldmia r4!,{r3}	; 02328D14
	bl loc_02328888	; 02328D16
	add sp,#0x14	; 02328D1A
	pop {r4,r5}	; 02328D1C
	pop {r3}	; 02328D1E
	bx r3	; 02328D20
	.byte 0x00, 0x00	; 02328D24

; ===== function loc_02328D24 =====
loc_02328D24:
	push {r4,r5,r6,r7,lr}	; 02328D24
	sub sp,#0x4	; 02328D26
	add r7,r0,#0x0	; 02328D28
	str r1,[sp,#0x0]	; 02328D2A
	ldrh r6,[r1,#0x6]	; 02328D2C
	lsl r4,r1,#0	; 02328D2E
	add r4,#0x8	; 02328D30
	mov r5,#0x0	; 02328D32
	cmp r6,#0x0	; 02328D34
	ble loc_02328D52	; 02328D36
loc_02328D38:
	ldr r3,[r4,#0x8]	; 02328D38
	cmp r3,#0x0	; 02328D3A
	beq loc_02328D4A	; 02328D3C
	add r0,r7,#0x0	; 02328D3E
	add r1,r4,#0x0	; 02328D40
	ldr r2,[sp,#0x0]	; 02328D42
	add r2,r2,r3	; 02328D44
	bl loc_02328CDC	; 02328D46
loc_02328D4A:
	add r4,#0xc	; 02328D4A
	add r5,r5,#0x1	; 02328D4C
	cmp r5,r6	; 02328D4E
	blt loc_02328D38	; 02328D50
loc_02328D52:
	add sp,#0x4	; 02328D52
	pop {r4,r5,r6,r7}	; 02328D54
	pop {r3}	; 02328D56
	bx r3	; 02328D58
	.byte 0x00, 0x00	; 02328D5C

; ===== function loc_02328D5C =====
loc_02328D5C:
	ldrh r2,[r0,#0x6]	; 02328D5C
	add r0,#0x8	; 02328D5E
	cmp r1,#0x0	; 02328D60
	blt loc_02328D68	; 02328D62
	cmp r1,r2	; 02328D64
	blt loc_02328D6C	; 02328D66
loc_02328D68:
	mov r0,#0x0	; 02328D68
	bx lr	; 02328D6A
loc_02328D6C:
	mov r2,#0xc	; 02328D6C
	mul r1,r2	; 02328D6E
	add r0,r0,r1	; 02328D70
	bx lr	; 02328D72

; ===== function loc_02328D74 =====
loc_02328D74:
	ldr r2,[r0,#0x8]	; 02328D74
	add r2,r0,r2	; 02328D76
	mov r0,#0x6	; 02328D78
	mul r1,r0	; 02328D7A
	add r0,r2,r1	; 02328D7C
	bx lr	; 02328D7E

; ===== function loc_02328D80 =====
loc_02328D80:
	ldr r0,[r0,#0x14]	; 02328D80
	bx lr	; 02328D82

; ===== function loc_02328D84 =====
loc_02328D84:
	ldr r1,[r0,#0x10]	; 02328D84
	add r0,r0,r1	; 02328D86
	bx lr	; 02328D88
	.byte 0x00, 0x00	; 02328D8C

; ===== function loc_02328D8C =====
loc_02328D8C:
	ldr r2,[r0,#0xc]	; 02328D8C
	add r2,r0,r2	; 02328D8E
	ldr r3,[r0,#0x8]	; 02328D90
	add r3,r0,r3	; 02328D92
	mov r0,#0x6	; 02328D94
	mul r1,r0	; 02328D96
	add r0,r3,r1	; 02328D98
	ldrh r1,[r0,#0x2]	; 02328D9A
	mov r0,#0xc	; 02328D9C
	mul r1,r0	; 02328D9E
	add r0,r2,r1	; 02328DA0
	bx lr	; 02328DA2

; ===== function loc_02328DA4 =====
loc_02328DA4:
	ldr r2,[r0,#0x8]	; 02328DA4
	add r2,r0,r2	; 02328DA6
	mov r0,#0x6	; 02328DA8
	mul r1,r0	; 02328DAA
	add r0,r2,r1	; 02328DAC
	ldrh r0,[r0,#0x4]	; 02328DAE
	bx lr	; 02328DB0
	.byte 0x00, 0x00	; 02328DB4

; ===== function loc_02328DB4 =====
loc_02328DB4:
	push {r4,r5,r6,r7,lr}	; 02328DB4
	sub sp,#0xc	; 02328DB6
	str r0,[sp,#0x0]	; 02328DB8
	add r7,r1,#0x0	; 02328DBA
	str r2,[sp,#0x4]	; 02328DBC
	lsl r4,r0,#0	; 02328DBE
	add r4,#0x8	; 02328DC0
	mov r5,#0x0	; 02328DC2
	bl loc_02328E60	; 02328DC4
	cmp r0,#0x0	; 02328DC8
	ble loc_02328E22	; 02328DCA
loc_02328DCC:
	mov r1,sp	; 02328DCC
	sub r1,r1,#0x4	; 02328DCE
	ldrh r0,[r4,#0x0]	; 02328DD0
	strh r0,[r1,#0x0]	; 02328DD2
	ldmia r1!,{r0}	; 02328DD4
	ldrb r1,[r4,#0x4]	; 02328DD6
	bl loc_02328CA4	; 02328DD8
	add r6,r0,#0x0	; 02328DDC
	mov r1,sp	; 02328DDE
	sub r1,r1,#0x4	; 02328DE0
	ldrh r0,[r4,#0x2]	; 02328DE2
	strh r0,[r1,#0x0]	; 02328DE4
	ldmia r1!,{r0}	; 02328DE6
	ldrb r1,[r4,#0x5]	; 02328DE8
	bl loc_02328C6C	; 02328DEA
	ldrb r1,[r4,#0x4]	; 02328DEE
	add r2,r6,r1	; 02328DF0
	ldrb r1,[r4,#0x5]	; 02328DF2
	add r1,r0,r1	; 02328DF4
	cmp r6,r7	; 02328DF6
	bgt loc_02328E14	; 02328DF8
	cmp r7,r2	; 02328DFA
	bgt loc_02328E14	; 02328DFC
	ldr r2,[sp,#0x4]	; 02328DFE
	cmp r0,r2	; 02328E00
	bgt loc_02328E14	; 02328E02
	lsl r0,r2,#0	; 02328E04
	cmp r0,r1	; 02328E06
	bgt loc_02328E14	; 02328E08
	add r0,r5,#0x0	; 02328E0A
	add sp,#0xc	; 02328E0C
	pop {r4,r5,r6,r7}	; 02328E0E
	pop {r3}	; 02328E10
	bx r3	; 02328E12
loc_02328E14:
	add r5,r5,#0x1	; 02328E14
	add r4,r4,#0x6	; 02328E16
	ldr r0,[sp,#0x0]	; 02328E18
	bl loc_02328E60	; 02328E1A
	cmp r5,r0	; 02328E1E
	blt loc_02328DCC	; 02328E20
loc_02328E22:
	mov r0,#0x0	; 02328E22
	mvn r0,r0	; 02328E24
	add sp,#0xc	; 02328E26
	pop {r4,r5,r6,r7}	; 02328E28
	pop {r3}	; 02328E2A
	bx r3	; 02328E2C
	.byte 0x00, 0x00	; 02328E30

; ===== function loc_02328E30 =====
loc_02328E30:
	push {r4,r5,lr}	; 02328E30
	sub sp,#0x4	; 02328E32
	add r5,r1,#0x0	; 02328E34
	add r4,r0,#0x0	; 02328E36
	add r4,#0x8	; 02328E38
	cmp r5,#0x0	; 02328E3A
	blt loc_02328E46	; 02328E3C
	bl loc_02328E60	; 02328E3E
	cmp r5,r0	; 02328E42
	blt loc_02328E50	; 02328E44
loc_02328E46:
	mov r0,#0x0	; 02328E46
	add sp,#0x4	; 02328E48
	pop {r4,r5}	; 02328E4A
	pop {r3}	; 02328E4C
	bx r3	; 02328E4E
loc_02328E50:
	mov r0,#0x6	; 02328E50
	mul r5,r0	; 02328E52
	add r0,r4,r5	; 02328E54
	add sp,#0x4	; 02328E56
	pop {r4,r5}	; 02328E58
	pop {r3}	; 02328E5A
	bx r3	; 02328E5C
	.byte 0x00, 0x00	; 02328E60

; ===== function loc_02328E60 =====
loc_02328E60:
	ldrh r0,[r0,#0x6]	; 02328E60
	bx lr	; 02328E62

; ===== function loc_02328E64 =====
loc_02328E64:
	push {r4,r5,r6,r7,lr}	; 02328E64
	sub sp,#0x14	; 02328E66
	str r0,[sp,#0x0]	; 02328E68
	str r1,[sp,#0x4]	; 02328E6A
	str r2,[sp,#0x8]	; 02328E6C
	str r3,[sp,#0xc]	; 02328E6E
	lsl r0,r2,#0	; 02328E70
	lsr r6,r0,#0x1	; 02328E72
	mov r5,#0x0	; 02328E74
	add r4,sp,#0x10	; 02328E76
	ldr r1,[pool_02328FA4]	; 02328E78
	ldr r7,[pool_02328FA8]	; 02328E7A
loc_02328E7C:
	add r0,r5,r6	; 02328E7C
	sub r0,r0,#0x2	; 02328E7E
	lsl r3,r0,#0x1	; 02328E80
	ldr r0,[sp,#0x0]	; 02328E82
	ldrsh r2,[r0,r3]	; 02328E84
	ldr r0,[sp,#0x4]	; 02328E86
	ldrsh r0,[r0,r3]	; 02328E88
	sub r0,r2,r0	; 02328E8A
	cmp r0,r1	; 02328E8C
	bge loc_02328E94	; 02328E8E
	add r0,r1,#0x0	; 02328E90
	b loc_02328E9A	; 02328E92
loc_02328E94:
	cmp r0,r7	; 02328E94
	blt loc_02328E9A	; 02328E96
	ldr r0,[pool_02328FAC]	; 02328E98
loc_02328E9A:
	strh r0,[r4,#0x0]	; 02328E9A
	add r4,r4,#0x2	; 02328E9C
	add r5,r5,#0x1	; 02328E9E
	cmp r5,#0x2	; 02328EA0
	blt loc_02328E7C	; 02328EA2
	sub r0,r6,#0x1	; 02328EA4
	cmp r0,#0x2	; 02328EA6
	blt loc_02328F22	; 02328EA8
	lsl r3,r0,#0x1	; 02328EAA
	ldr r1,[sp,#0x0]	; 02328EAC
	add r2,r1,r3	; 02328EAE
	ldr r1,[sp,#0x4]	; 02328EB0
	add r1,r1,r3	; 02328EB2
	ldr r7,[pool_02328FA4]	; 02328EB4
	mov r4,#0x0	; 02328EB6
loc_02328EB8:
	sub r3,r0,#0x2	; 02328EB8
	lsl r6,r3,#0x1	; 02328EBA
	ldr r3,[sp,#0x0]	; 02328EBC
	ldrsh r5,[r3,r6]	; 02328EBE
	ldr r3,[sp,#0x4]	; 02328EC0
	ldrsh r3,[r3,r6]	; 02328EC2
	sub r6,r5,r3	; 02328EC4
	cmp r6,#0x0	; 02328EC6
	blt loc_02328EF2	; 02328EC8
	ldrsh r3,[r2,r4]	; 02328ECA
	add r5,r6,r3	; 02328ECC
	ldr r3,[pool_02328FA8]	; 02328ECE
	cmp r5,r3	; 02328ED0
	bge loc_02328EDA	; 02328ED2
	lsl r3,r5,#0x10	; 02328ED4
	asr r3,r3,#0x10	; 02328ED6
	b loc_02328EDC	; 02328ED8
loc_02328EDA:
	ldr r3,[pool_02328FAC]	; 02328EDA
loc_02328EDC:
	strh r3,[r2,#0x0]	; 02328EDC
	ldrsh r3,[r1,r4]	; 02328EDE
	sub r3,r3,r6	; 02328EE0
	cmp r3,r7	; 02328EE2
	blt loc_02328EEC	; 02328EE4
	lsl r3,r3,#0x10	; 02328EE6
	asr r3,r3,#0x10	; 02328EE8
	b loc_02328EEE	; 02328EEA
loc_02328EEC:
	add r3,r7,#0x0	; 02328EEC
loc_02328EEE:
	strh r3,[r1,#0x0]	; 02328EEE
	b loc_02328F18	; 02328EF0
loc_02328EF2:
	ldrsh r3,[r2,r4]	; 02328EF2
	add r3,r6,r3	; 02328EF4
	cmp r3,r7	; 02328EF6
	blt loc_02328F00	; 02328EF8
	lsl r3,r3,#0x10	; 02328EFA
	asr r3,r3,#0x10	; 02328EFC
	b loc_02328F02	; 02328EFE
loc_02328F00:
	add r3,r7,#0x0	; 02328F00
loc_02328F02:
	strh r3,[r2,#0x0]	; 02328F02
	ldrsh r3,[r1,r4]	; 02328F04
	sub r5,r3,r6	; 02328F06
	ldr r3,[pool_02328FA8]	; 02328F08
	cmp r5,r3	; 02328F0A
	bge loc_02328F14	; 02328F0C
	lsl r3,r5,#0x10	; 02328F0E
	asr r3,r3,#0x10	; 02328F10
	b loc_02328F16	; 02328F12
loc_02328F14:
	ldr r3,[pool_02328FAC]	; 02328F14
loc_02328F16:
	strh r3,[r1,#0x0]	; 02328F16
loc_02328F18:
	sub r2,r2,#0x2	; 02328F18
	sub r1,r1,#0x2	; 02328F1A
	sub r0,r0,#0x1	; 02328F1C
	cmp r0,#0x2	; 02328F1E
	bge loc_02328EB8	; 02328F20
loc_02328F22:
	mov r1,#0x1	; 02328F22
	ldr r0,[sp,#0xc]	; 02328F24
	add r4,r0,#0x4	; 02328F26
	ldr r0,[sp,#0x0]	; 02328F28
	add r3,r0,#0x2	; 02328F2A
	ldr r0,[sp,#0x4]	; 02328F2C
	add r2,r0,#0x2	; 02328F2E
	ldr r0,[pool_02328FA4]	; 02328F30
loc_02328F32:
	mov r5,#0x0	; 02328F32
	ldrsh r6,[r3,r5]	; 02328F34
	ldr r5,[r4,#0xc]	; 02328F36
	add r6,r6,r5	; 02328F38
	cmp r6,r0	; 02328F3A
	bge loc_02328F42	; 02328F3C
	add r6,r0,#0x0	; 02328F3E
	b loc_02328F4A	; 02328F40
loc_02328F42:
	ldr r5,[pool_02328FA8]	; 02328F42
	cmp r6,r5	; 02328F44
	blt loc_02328F4A	; 02328F46
	ldr r6,[pool_02328FAC]	; 02328F48
loc_02328F4A:
	strh r6,[r3,#0x0]	; 02328F4A
	mov r5,#0x0	; 02328F4C
	ldrsh r6,[r2,r5]	; 02328F4E
	ldr r5,[r4,#0xc]	; 02328F50
	sub r6,r6,r5	; 02328F52
	cmp r6,r0	; 02328F54
	bge loc_02328F5C	; 02328F56
	add r6,r0,#0x0	; 02328F58
	b loc_02328F64	; 02328F5A
loc_02328F5C:
	ldr r5,[pool_02328FA8]	; 02328F5C
	cmp r6,r5	; 02328F5E
	blt loc_02328F64	; 02328F60
	ldr r6,[pool_02328FAC]	; 02328F62
loc_02328F64:
	strh r6,[r2,#0x0]	; 02328F64
	sub r4,r4,#0x4	; 02328F66
	sub r3,r3,#0x2	; 02328F68
	sub r2,r2,#0x2	; 02328F6A
	sub r1,r1,#0x1	; 02328F6C
	cmp r1,#0x0	; 02328F6E
	bge loc_02328F32	; 02328F70
	mov r3,#0x0	; 02328F72
	add r4,sp,#0x10	; 02328F74
	add r1,r3,#0x0	; 02328F76
loc_02328F78:
	ldrsh r2,[r4,r1]	; 02328F78
	ldr r0,[sp,#0xc]	; 02328F7A
	str r2,[r0,#0xc]	; 02328F7C
	add r4,r4,#0x2	; 02328F7E
	add r0,r0,#0x4	; 02328F80
	str r0,[sp,#0xc]	; 02328F82
	add r3,r3,#0x1	; 02328F84
	cmp r3,#0x2	; 02328F86
	blt loc_02328F78	; 02328F88
	ldr r0,[sp,#0x0]	; 02328F8A
	ldr r1,[sp,#0x8]	; 02328F8C
	blx P1_CleanAndInvalidateDataCacheRange	; 02328F8E
	ldr r0,[sp,#0x4]	; 02328F92
	ldr r1,[sp,#0x8]	; 02328F94
	blx P1_CleanAndInvalidateDataCacheRange	; 02328F96
	add sp,#0x14	; 02328F9A
	pop {r4,r5,r6,r7}	; 02328F9C
	pop {r3}	; 02328F9E
	bx r3	; 02328FA0
	.byte 0xC0, 0x46	; 02328FA4
pool_02328FA4:
loc_02328FA4:
	.word 0xFFFF8000	; 02328FA4
pool_02328FA8:
loc_02328FA8:
	.word 0x00008000	; 02328FA8
pool_02328FAC:
loc_02328FAC:
	.word 0x00007FFF	; 02328FAC

; ===== function loc_02328FB0 =====
	push {r4,r5,r6,r7,lr}	; 02328FB0
; 已登记的双缓冲处理回调：先调度上下文的可选处理函数，再按模式继续处理。
; Registered two-buffer handler: call the context's optional worker, then continue by mode.
.func P1_RunDualBufferCallback
	sub sp,#0xc	; 02328FB2
	add r7,r0,#0x0	; 02328FB4
	str r1,[sp,#0x4]	; 02328FB6
	str r2,[sp,#0x8]	; 02328FB8
	ldr r4,[sp,#0x20]	; 02328FBA
	ldr r6,[r4,#P1_DualBufferCallbackContextWorkerOffset]	; 02328FBC
	cmp r6,#0x0	; 02328FBE
	beq loc_02328FC8	; 02328FC0
	ldr r5,[r4,#P1_DualBufferCallbackContextArgumentOffset]	; 02328FC2
	str r5,[sp,#0x0]	; 02328FC4
	blx r6	; 02328FC6
loc_02328FC8:
	ldr r0,[r4,#P1_DualBufferCallbackContextModeOffset]	; 02328FC8
	cmp r0,#0x0	; 02328FCA
	beq loc_02328FDE	; 02328FCC
	cmp r0,#0x1	; 02328FCE
	bne loc_02328FDE	; 02328FD0
	add r0,r7,#0x0	; 02328FD2
	ldr r1,[sp,#0x4]	; 02328FD4
	ldr r2,[sp,#0x8]	; 02328FD6
	add r3,r4,#0x0	; 02328FD8
	bl loc_02328E64	; 02328FDA
loc_02328FDE:
	add sp,#0xc	; 02328FDE
	pop {r4,r5,r6,r7}	; 02328FE0
	pop {r3}	; 02328FE2
	bx r3	; 02328FE4
	.byte 0x00, 0x00	; 02328FE8
.endfunc

; ===== function loc_02328FE8 =====
loc_02328FE8:
	push {lr}	; 02328FE8
	sub sp,#0x4	; 02328FEA
	ldr r0,[pool_02329004]	; 02328FEC
	ldr r0,[r0,#0x0]	; 02328FEE
	cmp r0,#0x1	; 02328FF0
	bne loc_02328FFA	; 02328FF2
	mov r0,#0x0	; 02328FF4
	bl loc_0232E458	; 02328FF6
loc_02328FFA:
	bl P1_StopActiveDualBufferProcessor	; 02328FFA
	add sp,#0x4	; 02328FFE
	pop {r3}	; 02329000
	bx r3	; 02329002
pool_02329004:
loc_02329004:
	.word P1_DualBufferCallbackContext	; 02329004

; ===== function loc_02329008 =====
loc_02329008:
	push {r4,r5,r6,lr}	; 02329008
; 清零初始工作区、记录启动模式，并建立双缓冲处理对象。
; Clear initial workspace, record the start mode, and create the two-buffer processor.
.func P1_StartDualBufferProcessor
	sub sp,#0x10	; 0232900A
	add r5,r0,#0x0	; 0232900C
	add r6,r1,#0x0	; 0232900E
	add r4,r2,#0x0	; 02329010
	mov r1,#0x0	; 02329012
	add r0,sp,#0xc	; 02329014
	strh r1,[r0,#0x0]	; 02329016
	ldrh r0,[r0,#0x0]	; 02329018
	ldr r1,[pool_02329050]	; 0232901A
	mov r2,#0xc0	; 0232901C
	blx loc_0232E2E4	; 0232901E
	ldr r0,[pool_02329054]	; 02329022
	str r4,[r0,#0x0]	; 02329024
	cmp r4,#0x1	; 02329026
	bne loc_02329030	; 02329028
	ldr r0,[pool_02329058]	; 0232902A
	bl loc_0232E458	; 0232902C
loc_02329030:
	mov r0,#0x2	; 02329030
	str r0,[sp,#0x0]	; 02329032
	ldr r0,[pool_0232905C]	; 02329034
	str r0,[sp,#0x4]	; 02329036
	ldr r0,[pool_02329054]	; 02329038
	str r0,[sp,#0x8]	; 0232903A
	add r0,r5,#0x0	; 0232903C
	add r1,r6,#0x0	; 0232903E
	mov r2,#0x0	; 02329040
	ldr r3,[pool_02329060]	; 02329042
	bl P1_ConfigureDualBufferProcessor	; 02329044
	add sp,#0x10	; 02329048
	pop {r4,r5,r6}	; 0232904A
	pop {r3}	; 0232904C
	bx r3	; 0232904E
pool_02329050:
.endfunc
loc_02329050:
	.word 0x023567A8	; 02329050
pool_02329054:
loc_02329054:
	.word P1_DualBufferCallbackContext	; 02329054
pool_02329058:
loc_02329058:
	.word 0x00003000	; 02329058
pool_0232905C:
loc_0232905C:
	.word P1_RunDualBufferCallback + 1	; 0232905C
pool_02329060:
loc_02329060:
	.word 0x00007D00	; 02329060

; ===== function loc_02329064 =====
loc_02329064:
	mov r0,#0x1	; 02329064
	ldr r3,[pool_0232906C]	; 02329066
	bx r3	; 02329068
	.byte 0xC0, 0x46	; 0232906C
pool_0232906C:
loc_0232906C:
	.word loc_0232C360 + 1	; 0232906C

; ===== function loc_02329070 =====
loc_02329070:
	push {r4,r5,lr}	; 02329070
	sub sp,#0x4	; 02329072
	add r5,r0,#0x0	; 02329074
	bl loc_02329064	; 02329076
	cmp r0,#0x0	; 0232907A
	bne loc_0232908A	; 0232907C
	mov r0,#0x2	; 0232907E
	mvn r0,r0	; 02329080
	add sp,#0x4	; 02329082
	pop {r4,r5}	; 02329084
	pop {r3}	; 02329086
	bx r3	; 02329088
loc_0232908A:
	bl loc_02329128	; 0232908A
	add r4,r0,#0x0	; 0232908E
	mov r0,#0x0	; 02329090
	mvn r0,r0	; 02329092
	cmp r4,r0	; 02329094
	beq loc_023290B2	; 02329096
	add r0,r5,#0x0	; 02329098
	bl loc_023290E4	; 0232909A
	lsl r0,r4,#0x10	; 0232909E
	lsr r0,r0,#0x10	; 023290A0
	bl loc_02329104	; 023290A2
	mov r1,#0x1	; 023290A6
	mvn r1,r1	; 023290A8
	cmp r0,r1	; 023290AA
	beq loc_023290B0	; 023290AC
	mov r1,#0x0	; 023290AE
loc_023290B0:
	add r0,r1,#0x0	; 023290B0
loc_023290B2:
	add sp,#0x4	; 023290B2
	pop {r4,r5}	; 023290B4
	pop {r3}	; 023290B6
	bx r3	; 023290B8
	.byte 0x00, 0x00	; 023290BC

; ===== function loc_023290BC =====
loc_023290BC:
	push {lr}	; 023290BC
	sub sp,#0x4	; 023290BE
	mov r3,#0x0	; 023290C0
	ldr r2,[pool_023290E0]	; 023290C2
	add r0,r3,#0x0	; 023290C4
loc_023290C6:
	ldrsb r1,[r2,r0]	; 023290C6
	add r2,r2,#0x1	; 023290C8
	add r3,r3,#0x1	; 023290CA
	cmp r3,#0x13	; 023290CC
	bcc loc_023290C6	; 023290CE
	bl loc_0232C3B0	; 023290D0
	mov r0,#0x1	; 023290D4
	bl loc_0232C330	; 023290D6
	add sp,#0x4	; 023290DA
	pop {r3}	; 023290DC
	bx r3	; 023290DE
pool_023290E0:
loc_023290E0:
	.word P1_VibBuildIdentifier	; 023290E0

; ===== function loc_023290E4 =====
loc_023290E4:
	push {r4,lr}	; 023290E4
	add r4,r0,#0x0	; 023290E6
	bl loc_02329064	; 023290E8
	cmp r0,#0x1	; 023290EC
	bne loc_023290F8	; 023290EE
	mov r0,#0x1	; 023290F0
	and r4,r0	; 023290F2
	ldr r0,[pool_02329100]	; 023290F4
	strh r4,[r0,#0x0]	; 023290F6
loc_023290F8:
	pop {r4}	; 023290F8
	pop {r3}	; 023290FA
	bx r3	; 023290FC
	.byte 0xC0, 0x46	; 02329100
pool_02329100:
loc_02329100:
	.word Slot2BusBaseAddress + 0x4	; 02329100

; ===== function loc_02329104 =====
loc_02329104:
	push {r4,r5,lr}	; 02329104
	sub sp,#0x4	; 02329106
	add r5,r0,#0x0	; 02329108
	bl loc_0232AF84	; 0232910A
	add r4,r0,#0x0	; 0232910E
	add r0,r5,#0x0	; 02329110
	blx loc_0232AEA0	; 02329112
	mov r0,#0x1	; 02329116
	mvn r0,r0	; 02329118
	cmp r4,r0	; 0232911A
	beq loc_02329120	; 0232911C
	mov r0,#0x0	; 0232911E
loc_02329120:
	add sp,#0x4	; 02329120
	pop {r4,r5}	; 02329122
	pop {r3}	; 02329124
	bx r3	; 02329126

; ===== function loc_02329128 =====
loc_02329128:
	push {r4,lr}	; 02329128
	blx loc_0232AE48	; 0232912A
	add r4,r0,#0x0	; 0232912E
	mov r0,#0x2	; 02329130
	mvn r0,r0	; 02329132
	cmp r4,r0	; 02329134
	bne loc_02329142	; 02329136
	mov r0,#0x0	; 02329138
	mvn r0,r0	; 0232913A
	pop {r4}	; 0232913C
	pop {r3}	; 0232913E
	bx r3	; 02329140
loc_02329142:
	lsl r0,r4,#0x10	; 02329142
	lsr r0,r0,#0x10	; 02329144
	bl loc_0232AFA0	; 02329146
	add r0,r4,#0x0	; 0232914A
	pop {r4}	; 0232914C
	pop {r3}	; 0232914E
	bx r3	; 02329150
	.byte 0x00, 0x00	; 02329154

; ===== function loc_02329154 =====
loc_02329154:
	cmp r1,#0x0	; 02329154
	bne loc_0232915C	; 02329156
	ldr r0,[r0,#0x4]	; 02329158
	bx lr	; 0232915A
loc_0232915C:
	ldrh r0,[r0,#0xa]	; 0232915C
	ldr r0,[r1,r0]	; 0232915E
	bx lr	; 02329160
	.byte 0x00, 0x00	; 02329164

; ===== function loc_02329164 =====
loc_02329164:
	cmp r1,#0x0	; 02329164
	bne loc_0232916C	; 02329166
	ldr r0,[r0,#0x0]	; 02329168
	bx lr	; 0232916A
loc_0232916C:
	ldrh r0,[r0,#0xa]	; 0232916C
	add r0,r1,r0	; 0232916E
	ldr r0,[r0,#0x4]	; 02329170
	bx lr	; 02329172

; ===== function loc_02329174 =====
loc_02329174:
	push {r4}	; 02329174
	sub sp,#0x4	; 02329176
	ldrh r4,[r0,#0xa]	; 02329178
	add r2,r1,r4	; 0232917A
	ldr r1,[r1,r4]	; 0232917C
	cmp r1,#0x0	; 0232917E
	bne loc_02329188	; 02329180
	ldr r1,[r2,#0x4]	; 02329182
	str r1,[r0,#0x0]	; 02329184
	b loc_0232918E	; 02329186
loc_02329188:
	ldr r3,[r2,#0x4]	; 02329188
	add r1,r1,r4	; 0232918A
	str r3,[r1,#0x4]	; 0232918C
loc_0232918E:
	ldr r4,[r2,#0x4]	; 0232918E
	cmp r4,#0x0	; 02329190
	bne loc_0232919A	; 02329192
	ldr r1,[r2,#0x0]	; 02329194
	str r1,[r0,#0x4]	; 02329196
	b loc_023291A0	; 02329198
loc_0232919A:
	ldr r3,[r2,#0x0]	; 0232919A
	ldrh r1,[r0,#0xa]	; 0232919C
	str r3,[r4,r1]	; 0232919E
loc_023291A0:
	mov r1,#0x0	; 023291A0
	str r1,[r2,#0x0]	; 023291A2
	str r1,[r2,#0x4]	; 023291A4
	add r0,#0x8	; 023291A6
	ldrh r1,[r0,#0x0]	; 023291A8
	sub r1,r1,#0x1	; 023291AA
	strh r1,[r0,#0x0]	; 023291AC
	add sp,#0x4	; 023291AE
	pop {r4}	; 023291B0
	bx lr	; 023291B2

; ===== function loc_023291B4 =====
loc_023291B4:
	push {r4,r5,lr}	; 023291B4
	sub sp,#0x4	; 023291B6
	cmp r1,#0x0	; 023291B8
	bne loc_023291CA	; 023291BA
	add r1,r2,#0x0	; 023291BC
	bl loc_02329234	; 023291BE
	add sp,#0x4	; 023291C2
	pop {r4,r5}	; 023291C4
	pop {r3}	; 023291C6
	bx r3	; 023291C8
loc_023291CA:
	ldr r3,[r0,#0x0]	; 023291CA
	cmp r1,r3	; 023291CC
	bne loc_023291DE	; 023291CE
	add r1,r2,#0x0	; 023291D0
	bl loc_02329200	; 023291D2
	add sp,#0x4	; 023291D6
	pop {r4,r5}	; 023291D8
	pop {r3}	; 023291DA
	bx r3	; 023291DC
loc_023291DE:
	ldrh r5,[r0,#0xa]	; 023291DE
	add r4,r2,r5	; 023291E0
	ldr r3,[r1,r5]	; 023291E2
	str r3,[r2,r5]	; 023291E4
	str r1,[r4,#0x4]	; 023291E6
	add r3,r3,r5	; 023291E8
	str r2,[r3,#0x4]	; 023291EA
	ldrh r3,[r0,#0xa]	; 023291EC
	str r2,[r1,r3]	; 023291EE
	add r0,#0x8	; 023291F0
	ldrh r1,[r0,#0x0]	; 023291F2
	add r1,r1,#0x1	; 023291F4
	strh r1,[r0,#0x0]	; 023291F6
	add sp,#0x4	; 023291F8
	pop {r4,r5}	; 023291FA
	pop {r3}	; 023291FC
	bx r3	; 023291FE

; ===== function loc_02329200 =====
loc_02329200:
	push {r4,lr}	; 02329200
	ldr r2,[r0,#0x0]	; 02329202
	cmp r2,#0x0	; 02329204
	bne loc_02329212	; 02329206
	bl loc_0232926C	; 02329208
	pop {r4}	; 0232920C
	pop {r3}	; 0232920E
	bx r3	; 02329210
loc_02329212:
	ldrh r3,[r0,#0xa]	; 02329212
	add r4,r1,r3	; 02329214
	mov r2,#0x0	; 02329216
	str r2,[r1,r3]	; 02329218
	ldr r2,[r0,#0x0]	; 0232921A
	str r2,[r4,#0x4]	; 0232921C
	ldr r3,[r0,#0x0]	; 0232921E
	ldrh r2,[r0,#0xa]	; 02329220
	str r1,[r3,r2]	; 02329222
	str r1,[r0,#0x0]	; 02329224
	add r0,#0x8	; 02329226
	ldrh r1,[r0,#0x0]	; 02329228
	add r1,r1,#0x1	; 0232922A
	strh r1,[r0,#0x0]	; 0232922C
	pop {r4}	; 0232922E
	pop {r3}	; 02329230
	bx r3	; 02329232

; ===== function loc_02329234 =====
loc_02329234:
	push {r4,lr}	; 02329234
	ldr r2,[r0,#0x0]	; 02329236
	cmp r2,#0x0	; 02329238
	bne loc_02329246	; 0232923A
	bl loc_0232926C	; 0232923C
	pop {r4}	; 02329240
	pop {r3}	; 02329242
	bx r3	; 02329244
loc_02329246:
	ldrh r3,[r0,#0xa]	; 02329246
	add r4,r1,r3	; 02329248
	ldr r2,[r0,#0x4]	; 0232924A
	str r2,[r1,r3]	; 0232924C
	mov r2,#0x0	; 0232924E
	str r2,[r4,#0x4]	; 02329250
	ldr r3,[r0,#0x4]	; 02329252
	ldrh r2,[r0,#0xa]	; 02329254
	add r2,r3,r2	; 02329256
	str r1,[r2,#0x4]	; 02329258
	str r1,[r0,#0x4]	; 0232925A
	add r0,#0x8	; 0232925C
	ldrh r1,[r0,#0x0]	; 0232925E
	add r1,r1,#0x1	; 02329260
	strh r1,[r0,#0x0]	; 02329262
	pop {r4}	; 02329264
	pop {r3}	; 02329266
	bx r3	; 02329268
	.byte 0x00, 0x00	; 0232926C

; ===== function loc_0232926C =====
loc_0232926C:
	push {r4}	; 0232926C
	sub sp,#0x4	; 0232926E
	ldrh r3,[r0,#0xa]	; 02329270
	add r4,r1,r3	; 02329272
	mov r2,#0x0	; 02329274
	str r2,[r4,#0x4]	; 02329276
	str r2,[r1,r3]	; 02329278
	str r1,[r0,#0x0]	; 0232927A
	str r1,[r0,#0x4]	; 0232927C
	add r0,#0x8	; 0232927E
	ldrh r1,[r0,#0x0]	; 02329280
	add r1,r1,#0x1	; 02329282
	strh r1,[r0,#0x0]	; 02329284
	add sp,#0x4	; 02329286
	pop {r4}	; 02329288
	bx lr	; 0232928A

; ===== function loc_0232928C =====
loc_0232928C:
	mov r2,#0x0	; 0232928C
	str r2,[r0,#0x0]	; 0232928E
	str r2,[r0,#0x4]	; 02329290
	strh r2,[r0,#0x8]	; 02329292
	strh r1,[r0,#0xa]	; 02329294
	bx lr	; 02329296

; ===== function loc_02329298 =====
loc_02329298:
	push {r4,lr}	; 02329298
	add r4,r0,#0x0	; 0232929A
	bl loc_02329314	; 0232929C
	add r1,r4,#0x0	; 023292A0
	bl loc_02329174	; 023292A2
	pop {r4}	; 023292A6
	pop {r3}	; 023292A8
	bx r3	; 023292AA

; ===== function loc_023292AC =====
loc_023292AC:
	push {r4,lr}	; 023292AC
	add r4,r0,#0x0	; 023292AE
	str r1,[r4,#0x0]	; 023292B0
	str r2,[r4,#0x18]	; 023292B2
	str r3,[r4,#0x1c]	; 023292B4
	mov r0,#0x0	; 023292B6
	str r0,[r4,#0x20]	; 023292B8
	add r3,r4,#0x0	; 023292BA
	add r3,#0x20	; 023292BC
	ldr r1,[r3,#0x0]	; 023292BE
	mov r0,#0xff	; 023292C0
	bic r1,r0	; 023292C2
	str r1,[r3,#0x0]	; 023292C4
	ldr r2,[r3,#0x0]	; 023292C6
	ldr r1,[pool_02329308]	; 023292C8
	add r1,sp	; 023292CA
	ldrh r1,[r1,#0x10]	; 023292CC
	and r1,r0	; 023292CE
	orr r2,r1	; 023292D0
	str r2,[r3,#0x0]	; 023292D2
	add r0,r4,#0x0	; 023292D4
	add r0,#0xc	; 023292D6
	mov r1,#0x4	; 023292D8
	bl loc_0232928C	; 023292DA
	ldr r0,[pool_0232930C]	; 023292DE
	ldr r0,[r0,#0x0]	; 023292E0
	cmp r0,#0x0	; 023292E2
	bne loc_023292F4	; 023292E4
	ldr r0,[pool_02329310]	; 023292E6
	mov r1,#0x4	; 023292E8
	bl loc_0232928C	; 023292EA
	mov r1,#0x1	; 023292EE
	ldr r0,[pool_0232930C]	; 023292F0
	str r1,[r0,#0x0]	; 023292F2
loc_023292F4:
	add r0,r4,#0x0	; 023292F4
	bl loc_02329314	; 023292F6
	add r1,r4,#0x0	; 023292FA
	bl loc_02329234	; 023292FC
	pop {r4}	; 02329300
	pop {r3}	; 02329302
	bx r3	; 02329304
	.byte 0xC0, 0x46	; 02329308
pool_02329308:
loc_02329308:
	.word 0xFFFFFFF8	; 02329308
pool_0232930C:
loc_0232930C:
	.word P1_BssStart + 0x25A08	; 0232930C
pool_02329310:
loc_02329310:
	.word 0x0235686C	; 02329310

; ===== function loc_02329314 =====
loc_02329314:
	push {r4,lr}	; 02329314
	add r1,r0,#0x0	; 02329316
	ldr r4,[pool_02329330]	; 02329318
	add r0,r4,#0x0	; 0232931A
	bl loc_02329334	; 0232931C
	cmp r0,#0x0	; 02329320
	beq loc_02329328	; 02329322
	add r4,r0,#0x0	; 02329324
	add r4,#0xc	; 02329326
loc_02329328:
	add r0,r4,#0x0	; 02329328
	pop {r4}	; 0232932A
	pop {r3}	; 0232932C
	bx r3	; 0232932E
pool_02329330:
loc_02329330:
	.word 0x0235686C	; 02329330

; ===== function loc_02329334 =====
loc_02329334:
	push {r4,r5,r6,lr}	; 02329334
	add r6,r0,#0x0	; 02329336
	add r5,r1,#0x0	; 02329338
	mov r1,#0x0	; 0232933A
	bl loc_02329164	; 0232933C
	add r4,r0,#0x0	; 02329340
	cmp r4,#0x0	; 02329342
	beq loc_02329376	; 02329344
loc_02329346:
	ldr r0,[r4,#0x18]	; 02329346
	cmp r0,r5	; 02329348
	bhi loc_02329368	; 0232934A
	ldr r0,[r4,#0x1c]	; 0232934C
	cmp r5,r0	; 0232934E
	bcs loc_02329368	; 02329350
	add r0,r4,#0x0	; 02329352
	add r0,#0xc	; 02329354
	add r1,r5,#0x0	; 02329356
	bl loc_02329334	; 02329358
	cmp r0,#0x0	; 0232935C
	bne loc_02329378	; 0232935E
	add r0,r4,#0x0	; 02329360
	pop {r4,r5,r6}	; 02329362
	pop {r3}	; 02329364
	bx r3	; 02329366
loc_02329368:
	add r0,r6,#0x0	; 02329368
	add r1,r4,#0x0	; 0232936A
	bl loc_02329164	; 0232936C
	add r4,r0,#0x0	; 02329370
	cmp r4,#0x0	; 02329372
	bne loc_02329346	; 02329374
loc_02329376:
	mov r0,#0x0	; 02329376
loc_02329378:
	pop {r4,r5,r6}	; 02329378
	pop {r3}	; 0232937A
	bx r3	; 0232937C
	.byte 0x00, 0x00, 0x30, 0xB5, 0x83, 0xB0, 0x05, 0x1C, 0x24, 0x35, 0x0C, 0x1C, 0x10, 0x3C, 0x00, 0xA8	; 0232938E
	.byte 0x21, 0x1C, 0x00, 0xF0, 0xEA, 0xF9, 0x28, 0x1C, 0x08, 0x30, 0x21, 0x1C, 0x00, 0xF0, 0xD7, 0xF9	; 0232939E
	.byte 0x28, 0x1C, 0x00, 0xA9, 0x00, 0xF0, 0x31, 0xF8, 0x03, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 023293AE
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x00, 0x29, 0x00, 0xD1, 0x01, 0x21, 0xC9, 0x1C, 0x03, 0x23	; 023293BE
	.byte 0x99, 0x43, 0x00, 0x2A, 0x04, 0xDB, 0x00, 0xF0, 0xAE, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47	; 023293CE
	.byte 0x52, 0x42, 0x00, 0xF0, 0x64, 0xF8, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0x00, 0xB5	; 023293DE
	.byte 0x81, 0xB0, 0x09, 0x18, 0x03, 0x23, 0x99, 0x43, 0xC0, 0x1C, 0x98, 0x43, 0x88, 0x42, 0x02, 0xD8	; 023293EE
	.byte 0x0B, 0x1A, 0x4C, 0x2B, 0x03, 0xD2, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0xF0	; 023293FE
	.byte 0x5C, 0xF9, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0x70, 0xB5, 0x82, 0xB0, 0x06, 0x1C	; 0232940E
	.byte 0x0D, 0x1C, 0x00, 0x24, 0x29, 0x68, 0x68, 0x68, 0x00, 0x91, 0x01, 0x90, 0x31, 0x68, 0x00, 0x29	; 0232941E
	.byte 0x13, 0xD0, 0x28, 0x68, 0x81, 0x42, 0x01, 0xD2, 0x0C, 0x1C, 0x0B, 0xE0, 0x68, 0x68, 0x81, 0x42	; 0232942E
	.byte 0x0B, 0xD1, 0x4A, 0x68, 0x08, 0x1C, 0x10, 0x30, 0x10, 0x18, 0x01, 0x90, 0x30, 0x1C, 0x00, 0xF0	; 0232943E
	.byte 0x86, 0xF9, 0x02, 0xE0, 0xC9, 0x68, 0x00, 0x29, 0xEC, 0xD1, 0x00, 0x2C, 0x0C, 0xD0, 0x61, 0x68	; 0232944E
	.byte 0x20, 0x1C, 0x10, 0x30, 0x09, 0x18, 0x28, 0x68, 0x81, 0x42, 0x05, 0xD1, 0x00, 0x94, 0x30, 0x1C	; 0232945E
	.byte 0x21, 0x1C, 0x00, 0xF0, 0x74, 0xF9, 0x04, 0x1C, 0x01, 0x99, 0x00, 0x98, 0x08, 0x1A, 0x10, 0x28	; 0232946E
	.byte 0x04, 0xD2, 0x00, 0x20, 0x02, 0xB0, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0xA8, 0x06, 0x49	; 0232947E
	.byte 0x00, 0xF0, 0x47, 0xF9, 0x01, 0x1C, 0x30, 0x1C, 0x22, 0x1C, 0x00, 0xF0, 0x50, 0xF9, 0x01, 0x20	; 0232948E
	.byte 0x02, 0xB0, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x52, 0x46, 0x00, 0x00, 0xF0, 0xB5	; 0232949E
	.byte 0x85, 0xB0, 0x0B, 0x1C, 0x03, 0x90, 0x24, 0x30, 0x03, 0x90, 0x40, 0x8A, 0x01, 0x27, 0x38, 0x40	; 023294AE
	.byte 0x00, 0x04, 0x00, 0x0C, 0x00, 0x28, 0x00, 0xD0, 0x00, 0x27, 0x00, 0x20, 0x01, 0x90, 0xC0, 0x43	; 023294BE
	.byte 0x01, 0x99, 0x02, 0x91, 0x03, 0x99, 0x49, 0x68, 0x00, 0x29, 0x18, 0xD0, 0x52, 0x1E, 0xD2, 0x43	; 023294CE
	.byte 0x04, 0x92, 0x0E, 0x1C, 0x10, 0x36, 0x4D, 0x68, 0xAA, 0x19, 0xD2, 0x1A, 0x04, 0x9C, 0x14, 0x40	; 023294DE
	.byte 0xA2, 0x1B, 0x00, 0x2A, 0x08, 0xDB, 0xA8, 0x42, 0x06, 0xD9, 0x01, 0x91, 0x28, 0x1C, 0x02, 0x94	; 023294EE
	.byte 0x00, 0x2F, 0x04, 0xD1, 0x9D, 0x42, 0x02, 0xD0, 0x89, 0x68, 0x00, 0x29, 0xE9, 0xD1, 0x01, 0x98	; 023294FE
	.byte 0x00, 0x28, 0x0A, 0xD0, 0x01, 0x20, 0x00, 0x90, 0x03, 0x98, 0x01, 0x99, 0x02, 0x9A, 0x00, 0xF0	; 0232950E
	.byte 0x4E, 0xF8, 0x05, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x20, 0x05, 0xB0, 0xF0, 0xBC	; 0232951E
	.byte 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0xF0, 0xB5, 0x85, 0xB0, 0x0B, 0x1C, 0x03, 0x90, 0x24, 0x30	; 0232952E
	.byte 0x03, 0x90, 0x40, 0x8A, 0x01, 0x27, 0x38, 0x40, 0x00, 0x04, 0x00, 0x0C, 0x00, 0x28, 0x00, 0xD0	; 0232953E
	.byte 0x00, 0x27, 0x00, 0x20, 0x01, 0x90, 0xC0, 0x43, 0x01, 0x99, 0x02, 0x91, 0x03, 0x99, 0x09, 0x68	; 0232954E
	.byte 0x00, 0x29, 0x18, 0xD0, 0x56, 0x1E, 0xF2, 0x43, 0x04, 0x92, 0x0D, 0x1C, 0x10, 0x35, 0x72, 0x19	; 0232955E
	.byte 0x04, 0x9C, 0x14, 0x40, 0x4A, 0x68, 0x65, 0x1B, 0x5D, 0x19, 0xAA, 0x42, 0x08, 0xD3, 0x90, 0x42	; 0232956E
	.byte 0x06, 0xD9, 0x01, 0x91, 0x10, 0x1C, 0x02, 0x94, 0x00, 0x2F, 0x04, 0xD1, 0x9A, 0x42, 0x02, 0xD0	; 0232957E
	.byte 0xC9, 0x68, 0x00, 0x29, 0xE9, 0xD1, 0x01, 0x98, 0x00, 0x28, 0x0A, 0xD0, 0x00, 0x20, 0x00, 0x90	; 0232958E
	.byte 0x03, 0x98, 0x01, 0x99, 0x02, 0x9A, 0x00, 0xF0, 0x0A, 0xF8, 0x05, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 0232959E
	.byte 0x18, 0x47, 0x00, 0x20, 0x05, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00, 0xF0, 0xB5	; 023295AE
	.byte 0x87, 0xB0, 0x05, 0x1C, 0x0F, 0x1C, 0x14, 0x1C, 0x1E, 0x1C, 0x00, 0xA8, 0x00, 0xF0, 0xD5, 0xF8	; 023295BE
	.byte 0x01, 0x98, 0x03, 0x90, 0x30, 0x19, 0x02, 0x90, 0x26, 0x1C, 0x10, 0x3E, 0x01, 0x96, 0x28, 0x1C	; 023295CE
	.byte 0x39, 0x1C, 0x00, 0xF0, 0xBC, 0xF8, 0x07, 0x1C, 0x00, 0x99, 0x01, 0x98, 0x40, 0x1A, 0x10, 0x28	; 023295DE
	.byte 0x01, 0xD2, 0x01, 0x91, 0x09, 0xE0, 0x00, 0xA8, 0x30, 0x49, 0x00, 0xF0, 0x92, 0xF8, 0x01, 0x1C	; 023295EE
	.byte 0x28, 0x1C, 0x3A, 0x1C, 0x00, 0xF0, 0x9B, 0xF8, 0x07, 0x1C, 0x03, 0x99, 0x02, 0x98, 0x08, 0x1A	; 023295FE
	.byte 0x10, 0x28, 0x01, 0xD2, 0x02, 0x91, 0x08, 0xE0, 0x02, 0xA8, 0x27, 0x49, 0x00, 0xF0, 0x81, 0xF8	; 0232960E
	.byte 0x01, 0x1C, 0x28, 0x1C, 0x3A, 0x1C, 0x00, 0xF0, 0x8A, 0xF8, 0x01, 0x99, 0x02, 0x98, 0x42, 0x1A	; 0232961E
	.byte 0x28, 0x1F, 0x03, 0x68, 0xFF, 0x20, 0x03, 0x40, 0x18, 0x04, 0x03, 0x0C, 0x01, 0x20, 0x03, 0x40	; 0232962E
	.byte 0x00, 0x2B, 0x04, 0xD0, 0x00, 0x20, 0x06, 0x90, 0x06, 0x98, 0x04, 0xF0, 0x6E, 0xEE, 0x04, 0x96	; 0232963E
	.byte 0x02, 0x98, 0x05, 0x90, 0x04, 0xA8, 0x19, 0x49, 0x00, 0xF0, 0x63, 0xF8, 0x01, 0x1C, 0x88, 0x1C	; 0232964E
	.byte 0x03, 0x88, 0x17, 0x4A, 0x13, 0x40, 0x03, 0x80, 0x02, 0x88, 0x08, 0xAB, 0x1E, 0x8A, 0x01, 0x23	; 0232965E
	.byte 0x1E, 0x40, 0xF3, 0x03, 0x1A, 0x43, 0x02, 0x80, 0x01, 0x9A, 0x8B, 0x1A, 0x06, 0x88, 0x11, 0x4A	; 0232966E
	.byte 0x16, 0x40, 0x06, 0x80, 0x02, 0x88, 0x1B, 0x04, 0x1E, 0x0C, 0x7F, 0x23, 0x1E, 0x40, 0x33, 0x02	; 0232967E
	.byte 0x1A, 0x43, 0x02, 0x80, 0x2A, 0x8A, 0xFF, 0x23, 0x1A, 0x40, 0x06, 0x88, 0x9E, 0x43, 0x06, 0x80	; 0232968E
	.byte 0x03, 0x88, 0x13, 0x43, 0x03, 0x80, 0x28, 0x1C, 0x08, 0x30, 0xEA, 0x68, 0x00, 0xF0, 0x47, 0xF8	; 0232969E
	.byte 0x20, 0x1C, 0x07, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x52, 0x46, 0x00, 0x00, 0x44, 0x55	; 023296AE
	.byte 0x00, 0x00, 0xFF, 0x7F, 0xFF, 0xFF, 0xFF, 0x80, 0xFF, 0xFF	; 023296B8

; ===== function loc_023296B8 =====
	push {r4,r5,lr}	; 023296B8
	sub sp,#0xc	; 023296BA
	add r5,r0,#0x0	; 023296BC
	add r3,r1,#0x0	; 023296BE
	add r4,r5,#0x0	; 023296C0
	add r4,#0x24	; 023296C2
	str r2,[sp,#0x0]	; 023296C4
	ldr r1,[pool_02329708]	; 023296C6
	add r2,r4,#0x0	; 023296C8
	add r2,#0x14	; 023296CA
	bl loc_023292AC	; 023296CC
	mov r0,#0x0	; 023296D0
	strh r0,[r4,#0x10]	; 023296D2
	strh r0,[r4,#0x12]	; 023296D4
	add r2,r4,#0x0	; 023296D6
	add r2,#0x12	; 023296D8
	ldrh r1,[r2,#0x0]	; 023296DA
	mov r0,#0x1	; 023296DC
	bic r1,r0	; 023296DE
	strh r1,[r2,#0x0]	; 023296E0
	ldr r0,[r5,#0x18]	; 023296E2
	str r0,[sp,#0x4]	; 023296E4
	ldr r0,[r5,#0x1c]	; 023296E6
	str r0,[sp,#0x8]	; 023296E8
	add r0,sp,#0x4	; 023296EA
	ldr r1,[pool_0232970C]	; 023296EC
	bl loc_02329710	; 023296EE
	str r0,[r4,#0x0]	; 023296F2
	str r0,[r4,#0x4]	; 023296F4
	mov r0,#0x0	; 023296F6
	str r0,[r4,#0x8]	; 023296F8
	str r0,[r4,#0xc]	; 023296FA
	add r0,r5,#0x0	; 023296FC
	add sp,#0xc	; 023296FE
	pop {r4,r5}	; 02329700
	pop {r3}	; 02329702
	bx r3	; 02329704
	.byte 0xC0, 0x46	; 02329708
pool_02329708:
loc_02329708:
	.word 0x45585048	; 02329708
pool_0232970C:
loc_0232970C:
	.word 0x00004652	; 0232970C

; ===== function loc_02329710 =====
loc_02329710:
	ldr r3,[r0,#0x0]	; 02329710
	strh r1,[r3,#0x0]	; 02329712
	mov r2,#0x0	; 02329714
	strh r2,[r3,#0x2]	; 02329716
	ldr r1,[r0,#0x4]	; 02329718
	add r0,r3,#0x0	; 0232971A
	add r0,#0x10	; 0232971C
	sub r0,r1,r0	; 0232971E
	str r0,[r3,#0x4]	; 02329720
	str r2,[r3,#0x8]	; 02329722
	str r2,[r3,#0xc]	; 02329724
	add r0,r3,#0x0	; 02329726
	bx lr	; 02329728
	.byte 0x00, 0x00, 0x8A, 0x60, 0x00, 0x2A, 0x02, 0xD0, 0xD3, 0x68, 0xD1, 0x60, 0x01, 0xE0, 0x03, 0x68	; 0232973A
	.byte 0x01, 0x60, 0xCB, 0x60, 0x00, 0x2B, 0x01, 0xD0, 0x99, 0x60, 0x00, 0xE0, 0x41, 0x60, 0x08, 0x1C	; 0232974A
	.byte 0x70, 0x47, 0x8A, 0x68, 0xC9, 0x68, 0x00, 0x2A, 0x01, 0xD0, 0xD1, 0x60, 0x00, 0xE0, 0x01, 0x60	; 0232975A
	.byte 0x00, 0x29, 0x01, 0xD0, 0x8A, 0x60, 0x00, 0xE0, 0x42, 0x60, 0x10, 0x1C, 0x70, 0x47, 0x4A, 0x88	; 0232976A
	.byte 0x13, 0x12, 0x7F, 0x22, 0x13, 0x40, 0x1A, 0x04, 0x12, 0x0C, 0x8A, 0x1A, 0x02, 0x60, 0x4A, 0x68	; 0232977A
	.byte 0x10, 0x31, 0x51, 0x18, 0x41, 0x60, 0x70, 0x47, 0x00, 0x00	; 02329784

; ===== function loc_02329784 =====
loc_02329784:
	push {r4,r5,lr}	; 02329784
	sub sp,#0x4	; 02329786
	add r5,r0,#0x0	; 02329788
	add r4,r1,#0x0	; 0232978A
	mov r1,#0x1	; 0232978C
	add r2,r4,#0x0	; 0232978E
	and r2,r1	; 02329790
	cmp r2,#0x0	; 02329792
	beq loc_0232979A	; 02329794
	bl loc_0232982C	; 02329796
loc_0232979A:
	mov r0,#0x2	; 0232979A
	and r4,r0	; 0232979C
	cmp r4,#0x0	; 0232979E
	beq loc_023297A8	; 023297A0
	add r0,r5,#0x0	; 023297A2
	bl loc_02329810	; 023297A4
loc_023297A8:
	add sp,#0x4	; 023297A8
	pop {r4,r5}	; 023297AA
	pop {r3}	; 023297AC
	bx r3	; 023297AE

; ===== function loc_023297B0 =====
loc_023297B0:
	push {lr}	; 023297B0
	sub sp,#0x4	; 023297B2
	add r0,#0x24	; 023297B4
	cmp r1,#0x0	; 023297B6
	bne loc_023297BC	; 023297B8
	mov r1,#0x1	; 023297BA
loc_023297BC:
	add r1,r1,#0x3	; 023297BC
	mov r3,#0x3	; 023297BE
	bic r1,r3	; 023297C0
	cmp r2,#0x0	; 023297C2
	blt loc_023297D0	; 023297C4
	bl loc_0232988C	; 023297C6
	add sp,#0x4	; 023297CA
	pop {r3}	; 023297CC
	bx r3	; 023297CE
loc_023297D0:
	neg r2,r2	; 023297D0
	bl loc_0232983C	; 023297D2
	add sp,#0x4	; 023297D6
	pop {r3}	; 023297D8
	bx r3	; 023297DA

; ===== function loc_023297DC =====
loc_023297DC:
	ldr r3,[pool_023297E0]	; 023297DC
	bx r3	; 023297DE
pool_023297E0:
loc_023297E0:
	.word loc_02329298 + 1	; 023297E0

; ===== function loc_023297E4 =====
loc_023297E4:
	push {lr}	; 023297E4
	sub sp,#0x4	; 023297E6
	add r1,r1,r0	; 023297E8
	mov r3,#0x3	; 023297EA
	bic r1,r3	; 023297EC
	add r0,r0,#0x3	; 023297EE
	bic r0,r3	; 023297F0
	cmp r0,r1	; 023297F2
	bhi loc_023297FC	; 023297F4
	sub r3,r1,r0	; 023297F6
	cmp r3,#0x30	; 023297F8
	bcs loc_02329804	; 023297FA
loc_023297FC:
	mov r0,#0x0	; 023297FC
	add sp,#0x4	; 023297FE
	pop {r3}	; 02329800
	bx r3	; 02329802
loc_02329804:
	bl loc_023298DC	; 02329804
	add sp,#0x4	; 02329808
	pop {r3}	; 0232980A
	bx r3	; 0232980C
	.byte 0x00, 0x00	; 02329810

; ===== function loc_02329810 =====
loc_02329810:
	add r2,r0,#0x0	; 02329810
	add r2,#0x24	; 02329812
	ldr r3,[r2,#0x8]	; 02329814
	cmp r3,#0x0	; 02329816
	beq loc_02329824	; 02329818
loc_0232981A:
	ldr r1,[r0,#0x1c]	; 0232981A
	str r1,[r3,#0x8]	; 0232981C
	ldr r3,[r3,#0xc]	; 0232981E
	cmp r3,#0x0	; 02329820
	bne loc_0232981A	; 02329822
loc_02329824:
	ldr r0,[r0,#0x1c]	; 02329824
	str r0,[r2,#0x4]	; 02329826
	bx lr	; 02329828
	.byte 0x00, 0x00	; 0232982C

; ===== function loc_0232982C =====
loc_0232982C:
	add r1,r0,#0x0	; 0232982C
	add r1,#0x24	; 0232982E
	ldr r0,[r0,#0x18]	; 02329830
	str r0,[r1,#0x0]	; 02329832
	mov r0,#0x0	; 02329834
	str r0,[r1,#0x8]	; 02329836
	bx lr	; 02329838
	.byte 0x00, 0x00	; 0232983C

; ===== function loc_0232983C =====
loc_0232983C:
	push {r4,r5,lr}	; 0232983C
	sub sp,#0x4	; 0232983E
	add r5,r0,#0x0	; 02329840
	ldr r0,[r5,#0x4]	; 02329842
	sub r2,r2,#0x1	; 02329844
	mvn r4,r2	; 02329846
	sub r1,r0,r1	; 02329848
	and r4,r1	; 0232984A
loc_0232984C:
	ldr r1,[r5,#0x0]	; 0232984C
	cmp r4,r1	; 0232984E
	bcs loc_0232985C	; 02329850
	mov r0,#0x0	; 02329852
	add sp,#0x4	; 02329854
	pop {r4,r5}	; 02329856
	pop {r3}	; 02329858
	bx r3	; 0232985A
loc_0232985C:
	sub r2,r0,r4	; 0232985C
	sub r0,r5,#0x4	; 0232985E
	ldr r1,[r0,#0x0]	; 02329860
	mov r0,#0xff	; 02329862
	and r1,r0	; 02329864
	lsl r0,r1,#0x10	; 02329866
	lsr r1,r0,#0x10	; 02329868
	mov r0,#0x1	; 0232986A
	and r1,r0	; 0232986C
	cmp r1,#0x0	; 0232986E
	beq loc_0232987E	; 02329870
	mov r0,#0x0	; 02329872
	str r0,[sp,#0x0]	; 02329874
	ldr r0,[sp,#0x0]	; 02329876
	add r1,r4,#0x0	; 02329878
	blx loc_0232E318	; 0232987A
loc_0232987E:
	str r4,[r5,#0x4]	; 0232987E
	add r0,r4,#0x0	; 02329880
	add sp,#0x4	; 02329882
	pop {r4,r5}	; 02329884
	pop {r3}	; 02329886
	bx r3	; 02329888
	.byte 0x00, 0x00	; 0232988C

; ===== function loc_0232988C =====
loc_0232988C:
	push {r4,r5,r6,lr}	; 0232988C
	sub sp,#0x8	; 0232988E
	add r5,r0,#0x0	; 02329890
	ldr r3,[r5,#0x0]	; 02329892
	sub r0,r2,#0x1	; 02329894
	mvn r4,r0	; 02329896
	add r0,r0,r3	; 02329898
	and r4,r0	; 0232989A
	add r6,r1,r4	; 0232989C
	ldr r0,[r5,#0x4]	; 0232989E
	cmp r6,r0	; 023298A0
	bls loc_023298AE	; 023298A2
	mov r0,#0x0	; 023298A4
	add sp,#0x8	; 023298A6
	pop {r4,r5,r6}	; 023298A8
	pop {r3}	; 023298AA
	bx r3	; 023298AC
loc_023298AE:
	sub r2,r6,r3	; 023298AE
	sub r0,r5,#0x4	; 023298B0
	ldr r1,[r0,#0x0]	; 023298B2
	mov r0,#0xff	; 023298B4
	and r1,r0	; 023298B6
	lsl r0,r1,#0x10	; 023298B8
	lsr r1,r0,#0x10	; 023298BA
	mov r0,#0x1	; 023298BC
	and r1,r0	; 023298BE
	cmp r1,#0x0	; 023298C0
	beq loc_023298D0	; 023298C2
	mov r0,#0x0	; 023298C4
	str r0,[sp,#0x0]	; 023298C6
	ldr r0,[sp,#0x0]	; 023298C8
	add r1,r3,#0x0	; 023298CA
	blx loc_0232E318	; 023298CC
loc_023298D0:
	str r6,[r5,#0x0]	; 023298D0
	add r0,r4,#0x0	; 023298D2
	add sp,#0x8	; 023298D4
	pop {r4,r5,r6}	; 023298D6
	pop {r3}	; 023298D8
	bx r3	; 023298DA

; ===== function loc_023298DC =====
loc_023298DC:
	push {r4,r5,lr}	; 023298DC
	sub sp,#0x4	; 023298DE
	add r5,r0,#0x0	; 023298E0
	add r3,r1,#0x0	; 023298E2
	add r4,r5,#0x0	; 023298E4
	add r4,#0x24	; 023298E6
	str r2,[sp,#0x0]	; 023298E8
	ldr r1,[pool_0232990C]	; 023298EA
	add r2,r4,#0x0	; 023298EC
	add r2,#0xc	; 023298EE
	bl loc_023292AC	; 023298F0
	ldr r0,[r5,#0x18]	; 023298F4
	str r0,[r4,#0x0]	; 023298F6
	ldr r0,[r5,#0x1c]	; 023298F8
	str r0,[r4,#0x4]	; 023298FA
	mov r0,#0x0	; 023298FC
	str r0,[r4,#0x8]	; 023298FE
	add r0,r5,#0x0	; 02329900
	add sp,#0x4	; 02329902
	pop {r4,r5}	; 02329904
	pop {r3}	; 02329906
	bx r3	; 02329908
	.byte 0xC0, 0x46	; 0232990C
pool_0232990C:
loc_0232990C:
	.word 0x46524D48	; 0232990C

; ===== function loc_02329910 =====
loc_02329910:
	ldr r3,[pool_02329914]	; 02329910
	bx r3	; 02329912
pool_02329914:
loc_02329914:
	.word P1_ResetDualBufferBuffers + 1	; 02329914

; ===== function loc_02329918 =====
loc_02329918:
	push {r4,lr}	; 02329918
	bl P1_ApplyDualBufferProcessorSettings	; 0232991A
	mov r0,#0x0	; 0232991E
	add r1,r0,#0x0	; 02329920
	add r2,r0,#0x0	; 02329922
	add r3,r0,#0x0	; 02329924
	bl loc_0232E5CC	; 02329926
	bl loc_0232E7E4	; 0232992A
	add r4,r0,#0x0	; 0232992E
	mov r0,#0x1	; 02329930
	bl loc_0232E850	; 02329932
	add r0,r4,#0x0	; 02329936
	bl loc_0232E804	; 02329938
	pop {r4}	; 0232993C
	pop {r3}	; 0232993E
	bx r3	; 02329940
	.byte 0x00, 0x00	; 02329944

; ===== function loc_02329944 =====
loc_02329944:
	push {r4,lr}	; 02329944
	mov r4,#0x0	; 02329946
loc_02329948:
	add r0,r4,#0x0	; 02329948
	bl loc_0232E9A8	; 0232994A
	cmp r0,#0x0	; 0232994E
	bne loc_02329948	; 02329950
	bl loc_02329EC4	; 02329952
	bl P1_UpdateDualBufferProcessorStatus	; 02329956
	mov r0,#0x0	; 0232995A
	bl loc_0232E850	; 0232995C
	pop {r4}	; 02329960
	pop {r3}	; 02329962
	bx r3	; 02329964
	.byte 0x00, 0x00	; 02329968

; ===== function loc_02329968 =====
loc_02329968:
	push {lr}	; 02329968
	sub sp,#0x4	; 0232996A
	ldr r0,[pool_02329990]	; 0232996C
	ldr r1,[r0,#0x0]	; 0232996E
	cmp r1,#0x0	; 02329970
	bne loc_02329988	; 02329972
	mov r1,#0x1	; 02329974
	str r1,[r0,#0x0]	; 02329976
	bl loc_0232E404	; 02329978
	bl loc_02329A60	; 0232997C
	bl P1_ClearDualBufferProcessorAndQueueState	; 02329980
	bl loc_02329FB4	; 02329984
loc_02329988:
	add sp,#0x4	; 02329988
	pop {r3}	; 0232998A
	bx r3	; 0232998C
	.byte 0xC0, 0x46	; 02329990
pool_02329990:
loc_02329990:
	.word P1_BssStart + 0x25A18	; 02329990

; ===== function loc_02329994 =====
loc_02329994:
	ldr r1,[pool_023299A4]	; 02329994
	ldr r3,[r1,#0x0]	; 02329996
	mov r2,#0x1	; 02329998
	lsl r2,r0	; 0232999A
	bic r3,r2	; 0232999C
	str r3,[r1,#0x0]	; 0232999E
	bx lr	; 023299A0
	.byte 0xC0, 0x46	; 023299A4
pool_023299A4:
loc_023299A4:
	.word P1_BssStart + 0x25A20	; 023299A4

; ===== function loc_023299A8 =====
loc_023299A8:
	mov r3,#0x1	; 023299A8
	mov r0,#0x0	; 023299AA
	ldr r1,[pool_023299D0]	; 023299AC
	ldr r2,[r1,#0x0]	; 023299AE
loc_023299B0:
	add r1,r2,#0x0	; 023299B0
	and r1,r3	; 023299B2
	cmp r1,#0x0	; 023299B4
	bne loc_023299C2	; 023299B6
	ldr r1,[pool_023299D0]	; 023299B8
	ldr r2,[r1,#0x0]	; 023299BA
	orr r2,r3	; 023299BC
	str r2,[r1,#0x0]	; 023299BE
	bx lr	; 023299C0
loc_023299C2:
	add r0,r0,#0x1	; 023299C2
	lsl r3,r3,#0x1	; 023299C4
	cmp r0,#0x8	; 023299C6
	blt loc_023299B0	; 023299C8
	mov r0,#0x0	; 023299CA
	mvn r0,r0	; 023299CC
	bx lr	; 023299CE
pool_023299D0:
loc_023299D0:
	.word P1_BssStart + 0x25A20	; 023299D0

; ===== function loc_023299D4 =====
loc_023299D4:
	ldr r1,[pool_023299E0]	; 023299D4
	ldr r2,[r1,#0x0]	; 023299D6
	bic r2,r0	; 023299D8
	str r2,[r1,#0x0]	; 023299DA
	bx lr	; 023299DC
	.byte 0xC0, 0x46	; 023299E0
pool_023299E0:
loc_023299E0:
	.word P1_BssStart + 0x25A1C	; 023299E0

; ===== function loc_023299E4 =====
loc_023299E4:
	ldr r1,[pool_023299FC]	; 023299E4
	ldr r2,[r1,#0x0]	; 023299E6
	add r3,r0,#0x0	; 023299E8
	and r3,r2	; 023299EA
	cmp r3,#0x0	; 023299EC
	beq loc_023299F4	; 023299EE
	mov r0,#0x0	; 023299F0
	bx lr	; 023299F2
loc_023299F4:
	orr r2,r0	; 023299F4
	str r2,[r1,#0x0]	; 023299F6
	mov r0,#0x1	; 023299F8
	bx lr	; 023299FA
pool_023299FC:
loc_023299FC:
	.word P1_BssStart + 0x25A1C	; 023299FC

; ===== function loc_02329A00 =====
loc_02329A00:
	push {r4,lr}	; 02329A00
	add r4,r0,#0x0	; 02329A02
	cmp r4,#0x0	; 02329A04
	beq loc_02329A16	; 02329A06
	mov r1,#0x0	; 02329A08
	bl loc_0232E530	; 02329A0A
	ldr r0,[pool_02329A1C]	; 02329A0E
	ldr r1,[r0,#0x0]	; 02329A10
	bic r1,r4	; 02329A12
	str r1,[r0,#0x0]	; 02329A14
loc_02329A16:
	pop {r4}	; 02329A16
	pop {r3}	; 02329A18
	bx r3	; 02329A1A
pool_02329A1C:
loc_02329A1C:
	.word P1_BssStart + 0x25A24	; 02329A1C

; ===== function loc_02329A20 =====
loc_02329A20:
	push {r4,lr}	; 02329A20
	add r4,r0,#0x0	; 02329A22
	cmp r4,#0x0	; 02329A24
	bne loc_02329A30	; 02329A26
	mov r0,#0x1	; 02329A28
	pop {r4}	; 02329A2A
	pop {r3}	; 02329A2C
	bx r3	; 02329A2E
loc_02329A30:
	ldr r1,[pool_02329A5C]	; 02329A30
	ldr r1,[r1,#0x0]	; 02329A32
	add r2,r4,#0x0	; 02329A34
	and r2,r1	; 02329A36
	cmp r2,#0x0	; 02329A38
	beq loc_02329A44	; 02329A3A
	mov r0,#0x0	; 02329A3C
	pop {r4}	; 02329A3E
	pop {r3}	; 02329A40
	bx r3	; 02329A42
loc_02329A44:
	mov r1,#0x0	; 02329A44
	bl loc_0232E54C	; 02329A46
	ldr r0,[pool_02329A5C]	; 02329A4A
	ldr r1,[r0,#0x0]	; 02329A4C
	orr r1,r4	; 02329A4E
	str r1,[r0,#0x0]	; 02329A50
	mov r0,#0x1	; 02329A52
	pop {r4}	; 02329A54
	pop {r3}	; 02329A56
	bx r3	; 02329A58
	.byte 0xC0, 0x46	; 02329A5C
pool_02329A5C:
loc_02329A5C:
	.word P1_BssStart + 0x25A24	; 02329A5C

; ===== function loc_02329A60 =====
loc_02329A60:
	mov r1,#0x0	; 02329A60
	ldr r0,[pool_02329A70]	; 02329A62
	str r1,[r0,#0x0]	; 02329A64
	ldr r0,[pool_02329A74]	; 02329A66
	str r1,[r0,#0x0]	; 02329A68
	ldr r0,[pool_02329A78]	; 02329A6A
	str r1,[r0,#0x0]	; 02329A6C
	bx lr	; 02329A6E
pool_02329A70:
loc_02329A70:
	.word P1_BssStart + 0x25A24	; 02329A70
pool_02329A74:
loc_02329A74:
	.word P1_BssStart + 0x25A1C	; 02329A74
pool_02329A78:
loc_02329A78:
	.word P1_BssStart + 0x25A20	; 02329A78

; ===== function loc_02329A7C =====
loc_02329A7C:
	push {r4,r5,r6,lr}	; 02329A7C
	add r5,r0,#0x0	; 02329A7E
	add r6,r1,#0x0	; 02329A80
	ldr r4,[r5,#0x4]	; 02329A82
	cmp r4,#0x0	; 02329A84
	beq loc_02329A94	; 02329A86
	add r0,r4,#0x0	; 02329A88
	add r1,r5,#0x0	; 02329A8A
	bl loc_02329174	; 02329A8C
	mov r0,#0x0	; 02329A90
	str r0,[r5,#0x4]	; 02329A92
loc_02329A94:
	ldr r0,[pool_02329ABC]	; 02329A94
	add r1,r5,#0x0	; 02329A96
	bl loc_02329174	; 02329A98
	add r0,r5,#0x0	; 02329A9C
	add r0,#0x3d	; 02329A9E
	strb r6,[r0,#0x0]	; 02329AA0
	cmp r4,#0x0	; 02329AA2
	beq loc_02329AAE	; 02329AA4
	add r0,r4,#0x0	; 02329AA6
	add r1,r5,#0x0	; 02329AA8
	bl loc_02329C14	; 02329AAA
loc_02329AAE:
	add r0,r5,#0x0	; 02329AAE
	bl loc_02329BCC	; 02329AB0
	pop {r4,r5,r6}	; 02329AB4
	pop {r3}	; 02329AB6
	bx r3	; 02329AB8
	.byte 0xC0, 0x46	; 02329ABC
pool_02329ABC:
loc_02329ABC:
	.word 0x02356894	; 02329ABC

; ===== function loc_02329AC0 =====
	push {r4,lr}	; 02329AC0
	add r4,r0,#0x0	; 02329AC2
	ldr r0,[r4,#0x8]	; 02329AC4
	cmp r0,#0x0	; 02329AC6
	beq loc_02329AF0	; 02329AC8
	bl loc_0232A864	; 02329ACA
	ldr r1,[r4,#0xc]	; 02329ACE
	cmp r1,#0x0	; 02329AD0
	beq loc_02329ADE	; 02329AD2
	mov r0,#0x0	; 02329AD4
	str r0,[r1,#0x8]	; 02329AD6
	pop {r4}	; 02329AD8
	pop {r3}	; 02329ADA
	bx r3	; 02329ADC
loc_02329ADE:
	ldr r2,[pool_02329AF8]	; 02329ADE
	ldr r1,[r4,#0x10]	; 02329AE0
	mov r0,#0x1c	; 02329AE2
	mul r1,r0	; 02329AE4
	add r0,r2,r1	; 02329AE6
	add r0,#0xc	; 02329AE8
	add r1,r4,#0x0	; 02329AEA
	bl loc_02329174	; 02329AEC
loc_02329AF0:
	pop {r4}	; 02329AF0
	pop {r3}	; 02329AF2
	bx r3	; 02329AF4
	.byte 0xC0, 0x46	; 02329AF8
pool_02329AF8:
loc_02329AF8:
	.word 0x023568A0	; 02329AF8

; ===== function loc_02329AFC =====
loc_02329AFC:
	push {r4,r5,lr}	; 02329AFC
	sub sp,#0x4	; 02329AFE
	add r5,r0,#0x0	; 02329B00
	ldr r1,[r5,#0x0]	; 02329B02
	cmp r1,#0x0	; 02329B04
	beq loc_02329B0E	; 02329B06
	mov r0,#0x0	; 02329B08
	str r0,[r1,#0x0]	; 02329B0A
	str r0,[r5,#0x0]	; 02329B0C
loc_02329B0E:
	ldr r4,[r5,#0x4]	; 02329B0E
	add r0,r4,#0x0	; 02329B10
	add r1,r5,#0x0	; 02329B12
	bl loc_02329174	; 02329B14
	mov r0,#0x0	; 02329B18
	str r0,[r5,#0x4]	; 02329B1A
	ldr r1,[r5,#0x8]	; 02329B1C
	cmp r1,#0x0	; 02329B1E
	beq loc_02329B32	; 02329B20
	add r4,#0xc	; 02329B22
	add r0,r4,#0x0	; 02329B24
	bl loc_02329234	; 02329B26
	mov r1,#0x0	; 02329B2A
	ldr r0,[r5,#0x8]	; 02329B2C
	str r1,[r0,#0xc]	; 02329B2E
	str r1,[r5,#0x8]	; 02329B30
loc_02329B32:
	ldr r0,[pool_02329B50]	; 02329B32
	add r1,r5,#0x0	; 02329B34
	bl loc_02329174	; 02329B36
	ldr r0,[pool_02329B54]	; 02329B3A
	add r1,r5,#0x0	; 02329B3C
	bl loc_02329234	; 02329B3E
	mov r0,#0x0	; 02329B42
	add r5,#0x2c	; 02329B44
	strb r0,[r5,#0x0]	; 02329B46
	add sp,#0x4	; 02329B48
	pop {r4,r5}	; 02329B4A
	pop {r3}	; 02329B4C
	bx r3	; 02329B4E
pool_02329B50:
loc_02329B50:
	.word 0x02356894	; 02329B50
pool_02329B54:
loc_02329B54:
	.word 0x02356888	; 02329B54

; ===== function loc_02329B58 =====
loc_02329B58:
	push {r4,r5,lr}	; 02329B58
	sub sp,#0x4	; 02329B5A
	add r5,r0,#0x0	; 02329B5C
	ldr r0,[pool_02329BAC]	; 02329B5E
	mov r1,#0x0	; 02329B60
	bl loc_02329164	; 02329B62
	add r4,r0,#0x0	; 02329B66
	cmp r4,#0x0	; 02329B68
	bne loc_02329B8E	; 02329B6A
	ldr r0,[pool_02329BB0]	; 02329B6C
	mov r1,#0x0	; 02329B6E
	bl loc_02329164	; 02329B70
	add r4,r0,#0x0	; 02329B74
	add r1,r4,#0x0	; 02329B76
	add r1,#0x3d	; 02329B78
	ldrb r1,[r1,#0x0]	; 02329B7A
	cmp r5,r1	; 02329B7C
	bge loc_02329B8A	; 02329B7E
	mov r0,#0x0	; 02329B80
	add sp,#0x4	; 02329B82
	pop {r4,r5}	; 02329B84
	pop {r3}	; 02329B86
	bx r3	; 02329B88
loc_02329B8A:
	bl loc_02329BB4	; 02329B8A
loc_02329B8E:
	ldr r0,[pool_02329BAC]	; 02329B8E
	add r1,r4,#0x0	; 02329B90
	bl loc_02329174	; 02329B92
	add r0,r4,#0x0	; 02329B96
	add r0,#0x3d	; 02329B98
	strb r5,[r0,#0x0]	; 02329B9A
	add r0,r4,#0x0	; 02329B9C
	bl loc_02329BCC	; 02329B9E
	add r0,r4,#0x0	; 02329BA2
	add sp,#0x4	; 02329BA4
	pop {r4,r5}	; 02329BA6
	pop {r3}	; 02329BA8
	bx r3	; 02329BAA
pool_02329BAC:
loc_02329BAC:
	.word 0x02356888	; 02329BAC
pool_02329BB0:
loc_02329BB0:
	.word 0x02356894	; 02329BB0

; ===== function loc_02329BB4 =====
loc_02329BB4:
	push {r4,lr}	; 02329BB4
	add r4,r0,#0x0	; 02329BB6
	add r0,#0x3c	; 02329BB8
	ldrb r0,[r0,#0x0]	; 02329BBA
	bl loc_0232E68C	; 02329BBC
	add r0,r4,#0x0	; 02329BC0
	bl loc_02329AFC	; 02329BC2
	pop {r4}	; 02329BC6
	pop {r3}	; 02329BC8
	bx r3	; 02329BCA

; ===== function loc_02329BCC =====
loc_02329BCC:
	push {r4,r5,lr}	; 02329BCC
	sub sp,#0x4	; 02329BCE
	add r5,r0,#0x0	; 02329BD0
	ldr r0,[pool_02329C10]	; 02329BD2
	mov r1,#0x0	; 02329BD4
	bl loc_02329164	; 02329BD6
	add r1,r0,#0x0	; 02329BDA
	cmp r1,#0x0	; 02329BDC
	beq loc_02329BFE	; 02329BDE
	ldr r4,[pool_02329C10]	; 02329BE0
loc_02329BE2:
	add r0,r5,#0x0	; 02329BE2
	add r0,#0x3d	; 02329BE4
	ldrb r2,[r0,#0x0]	; 02329BE6
	add r0,r1,#0x0	; 02329BE8
	add r0,#0x3d	; 02329BEA
	ldrb r0,[r0,#0x0]	; 02329BEC
	cmp r2,r0	; 02329BEE
	bcc loc_02329BFE	; 02329BF0
	add r0,r4,#0x0	; 02329BF2
	bl loc_02329164	; 02329BF4
	add r1,r0,#0x0	; 02329BF8
	cmp r1,#0x0	; 02329BFA
	bne loc_02329BE2	; 02329BFC
loc_02329BFE:
	ldr r0,[pool_02329C10]	; 02329BFE
	add r2,r5,#0x0	; 02329C00
	bl loc_023291B4	; 02329C02
	add sp,#0x4	; 02329C06
	pop {r4,r5}	; 02329C08
	pop {r3}	; 02329C0A
	bx r3	; 02329C0C
	.byte 0xC0, 0x46	; 02329C10
pool_02329C10:
loc_02329C10:
	.word 0x02356894	; 02329C10

; ===== function loc_02329C14 =====
loc_02329C14:
	push {r4,r5,lr}	; 02329C14
	sub sp,#0x4	; 02329C16
	add r5,r0,#0x0	; 02329C18
	add r4,r1,#0x0	; 02329C1A
	mov r1,#0x0	; 02329C1C
	bl loc_02329164	; 02329C1E
	add r1,r0,#0x0	; 02329C22
	cmp r1,#0x0	; 02329C24
	beq loc_02329C44	; 02329C26
loc_02329C28:
	add r0,r4,#0x0	; 02329C28
	add r0,#0x3d	; 02329C2A
	ldrb r2,[r0,#0x0]	; 02329C2C
	add r0,r1,#0x0	; 02329C2E
	add r0,#0x3d	; 02329C30
	ldrb r0,[r0,#0x0]	; 02329C32
	cmp r2,r0	; 02329C34
	bcc loc_02329C44	; 02329C36
	add r0,r5,#0x0	; 02329C38
	bl loc_02329164	; 02329C3A
	add r1,r0,#0x0	; 02329C3E
	cmp r1,#0x0	; 02329C40
	bne loc_02329C28	; 02329C42
loc_02329C44:
	add r0,r5,#0x0	; 02329C44
	add r2,r4,#0x0	; 02329C46
	bl loc_023291B4	; 02329C48
	str r5,[r4,#0x4]	; 02329C4C
	add sp,#0x4	; 02329C4E
	pop {r4,r5}	; 02329C50
	pop {r3}	; 02329C52
	bx r3	; 02329C54
	.byte 0x00, 0x00	; 02329C58

; ===== function loc_02329C58 =====
loc_02329C58:
	push {r4,lr}	; 02329C58
	add r4,r0,#0x0	; 02329C5A
	mov r1,#0x0	; 02329C5C
	add r0,#0x2e	; 02329C5E
	strb r1,[r0,#0x0]	; 02329C60
	add r0,r4,#0x0	; 02329C62
	add r0,#0x2d	; 02329C64
	strb r1,[r0,#0x0]	; 02329C66
	strh r1,[r4,#0x34]	; 02329C68
	strh r1,[r4,#0x3e]	; 02329C6A
	mov r1,#0x7f	; 02329C6C
	add r0,r4,#0x0	; 02329C6E
	add r0,#0x40	; 02329C70
	strb r1,[r0,#0x0]	; 02329C72
	add r0,r4,#0x0	; 02329C74
	add r0,#0x41	; 02329C76
	strb r1,[r0,#0x0]	; 02329C78
	add r0,r4,#0x0	; 02329C7A
	add r0,#0x1c	; 02329C7C
	bl loc_0232ABA0	; 02329C7E
	add r4,#0x1c	; 02329C82
	add r0,r4,#0x0	; 02329C84
	ldr r1,[pool_02329C94]	; 02329C86
	mov r2,#0x1	; 02329C88
	bl loc_0232AB84	; 02329C8A
	pop {r4}	; 02329C8E
	pop {r3}	; 02329C90
	bx r3	; 02329C92
pool_02329C94:
loc_02329C94:
	.word 0x00007F00	; 02329C94
loc_02329C98:
	push {r4,lr}	; 02329C98
	add r4,r0,#0x0	; 02329C9A
	add r2,r1,#0x0	; 02329C9C
	cmp r4,#0x0	; 02329C9E
	beq loc_02329CD0	; 02329CA0
	add r1,r4,#0x0	; 02329CA2
	add r1,#0x2c	; 02329CA4
	ldrb r1,[r1,#0x0]	; 02329CA6
	cmp r1,#0x0	; 02329CA8
	beq loc_02329CD0	; 02329CAA
	cmp r2,#0x0	; 02329CAC
	bne loc_02329CBA	; 02329CAE
	bl loc_02329BB4	; 02329CB0
	pop {r4}	; 02329CB4
	pop {r3}	; 02329CB6
	bx r3	; 02329CB8
loc_02329CBA:
	add r0,#0x1c	; 02329CBA
	mov r1,#0x0	; 02329CBC
	bl loc_0232AB84	; 02329CBE
	add r0,r4,#0x0	; 02329CC2
	mov r1,#0x0	; 02329CC4
	bl loc_02329A7C	; 02329CC6
	mov r0,#0x2	; 02329CCA
	add r4,#0x2c	; 02329CCC
	strb r0,[r4,#0x0]	; 02329CCE
loc_02329CD0:
	pop {r4}	; 02329CD0
	pop {r3}	; 02329CD2
	bx r3	; 02329CD4
	.byte 0x00, 0x00	; 02329CD8

; ===== function loc_02329CD8 =====
loc_02329CD8:
	push {r4,lr}	; 02329CD8
	add r4,r0,#0x0	; 02329CDA
	add r0,#0x3c	; 02329CDC
	ldrb r0,[r0,#0x0]	; 02329CDE
	bl loc_0232E6A4	; 02329CE0
	add r0,r4,#0x0	; 02329CE4
	bl loc_02329C58	; 02329CE6
	bl loc_0232E7E4	; 02329CEA
	str r0,[r4,#0x30]	; 02329CEE
	mov r0,#0x1	; 02329CF0
	add r4,#0x2c	; 02329CF2
	strb r0,[r4,#0x0]	; 02329CF4
	pop {r4}	; 02329CF6
	pop {r3}	; 02329CF8
	bx r3	; 02329CFA

; ===== function loc_02329CFC =====
loc_02329CFC:
	ldr r3,[pool_02329D00]	; 02329CFC
	bx r3	; 02329CFE
pool_02329D00:
loc_02329D00:
	.word loc_02329AFC + 1	; 02329D00

; ===== function loc_02329D04 =====
loc_02329D04:
	push {r4,r5,r6,lr}	; 02329D04
	add r5,r0,#0x0	; 02329D06
	add r6,r2,#0x0	; 02329D08
	ldr r3,[pool_02329D78]	; 02329D0A
	mov r2,#0x1c	; 02329D0C
	mul r1,r2	; 02329D0E
	add r4,r3,r1	; 02329D10
	ldr r1,[r5,#0x0]	; 02329D12
	cmp r1,#0x0	; 02329D14
	beq loc_02329D1C	; 02329D16
	bl loc_02329E20	; 02329D18
loc_02329D1C:
	ldrh r1,[r4,#0x8]	; 02329D1C
	ldr r0,[r4,#0x18]	; 02329D1E
	cmp r1,r0	; 02329D20
	bcc loc_02329D4E	; 02329D22
	add r0,r4,#0x0	; 02329D24
	mov r1,#0x0	; 02329D26
	bl loc_02329164	; 02329D28
	cmp r0,#0x0	; 02329D2C
	bne loc_02329D38	; 02329D2E
	mov r0,#0x0	; 02329D30
	pop {r4,r5,r6}	; 02329D32
	pop {r3}	; 02329D34
	bx r3	; 02329D36
loc_02329D38:
	add r1,r0,#0x0	; 02329D38
	add r1,#0x3d	; 02329D3A
	ldrb r1,[r1,#0x0]	; 02329D3C
	cmp r6,r1	; 02329D3E
	bge loc_02329D4A	; 02329D40
	mov r0,#0x0	; 02329D42
	pop {r4,r5,r6}	; 02329D44
	pop {r3}	; 02329D46
	bx r3	; 02329D48
loc_02329D4A:
	bl loc_02329BB4	; 02329D4A
loc_02329D4E:
	add r0,r6,#0x0	; 02329D4E
	bl loc_02329B58	; 02329D50
	add r6,r0,#0x0	; 02329D54
	cmp r6,#0x0	; 02329D56
	bne loc_02329D62	; 02329D58
	mov r0,#0x0	; 02329D5A
	pop {r4,r5,r6}	; 02329D5C
	pop {r3}	; 02329D5E
	bx r3	; 02329D60
loc_02329D62:
	add r0,r4,#0x0	; 02329D62
	add r1,r6,#0x0	; 02329D64
	bl loc_02329C14	; 02329D66
	str r5,[r6,#0x0]	; 02329D6A
	str r6,[r5,#0x0]	; 02329D6C
	add r0,r6,#0x0	; 02329D6E
	pop {r4,r5,r6}	; 02329D70
	pop {r3}	; 02329D72
	bx r3	; 02329D74
	.byte 0xC0, 0x46	; 02329D78
pool_02329D78:
loc_02329D78:
	.word 0x023568A0	; 02329D78

; ===== function loc_02329D7C =====
loc_02329D7C:
	push {r4}	; 02329D7C
	sub sp,#0x4	; 02329D7E
	ldr r4,[r0,#0x0]	; 02329D80
	cmp r4,#0x0	; 02329D82
	beq loc_02329D92	; 02329D84
	mov r3,#0x2	; 02329D86
	strh r3,[r4,#0x34]	; 02329D88
	ldr r3,[r0,#0x0]	; 02329D8A
	strh r1,[r3,#0x38]	; 02329D8C
	ldr r0,[r0,#0x0]	; 02329D8E
	strh r2,[r0,#0x3a]	; 02329D90
loc_02329D92:
	add sp,#0x4	; 02329D92
	pop {r4}	; 02329D94
	bx lr	; 02329D96

; ===== function loc_02329D98 =====
	push {lr}	; 02329D98
	sub sp,#0x4	; 02329D9A
	ldr r0,[r0,#0x0]	; 02329D9C
	cmp r0,#0x0	; 02329D9E
	beq loc_02329DAA	; 02329DA0
	add r0,#0x3c	; 02329DA2
	ldrb r0,[r0,#0x0]	; 02329DA4
	bl loc_0232E634	; 02329DA6
loc_02329DAA:
	add sp,#0x4	; 02329DAA
	pop {r3}	; 02329DAC
	bx r3	; 02329DAE

; ===== function loc_02329DB0 =====
	push {lr}	; 02329DB0
	sub sp,#0x4	; 02329DB2
	ldr r0,[r0,#0x0]	; 02329DB4
	cmp r0,#0x0	; 02329DB6
	beq loc_02329DC2	; 02329DB8
	add r0,#0x3c	; 02329DBA
	ldrb r0,[r0,#0x0]	; 02329DBC
	bl loc_0232E64C	; 02329DBE
loc_02329DC2:
	add sp,#0x4	; 02329DC2
	pop {r3}	; 02329DC4
	bx r3	; 02329DC6

; ===== function loc_02329DC8 =====
loc_02329DC8:
	push {lr}	; 02329DC8
	sub sp,#0x4	; 02329DCA
	ldr r0,[r0,#0x0]	; 02329DCC
	cmp r0,#0x0	; 02329DCE
	beq loc_02329DDA	; 02329DD0
	add r0,#0x3c	; 02329DD2
	ldrb r0,[r0,#0x0]	; 02329DD4
	bl loc_0232E664	; 02329DD6
loc_02329DDA:
	add sp,#0x4	; 02329DDA
	pop {r3}	; 02329DDC
	bx r3	; 02329DDE

; ===== function loc_02329DE0 =====
	push {lr}	; 02329DE0
	sub sp,#0x4	; 02329DE2
	ldr r0,[r0,#0x0]	; 02329DE4
	cmp r0,#0x0	; 02329DE6
	beq loc_02329DFC	; 02329DE8
	add r3,r0,#0x0	; 02329DEA
	add r3,#0x2c	; 02329DEC
	ldrb r3,[r3,#0x0]	; 02329DEE
	cmp r3,#0x2	; 02329DF0
	beq loc_02329DFC	; 02329DF2
	add r0,#0x1c	; 02329DF4
	lsl r1,r1,#0x8	; 02329DF6
	bl loc_0232AB84	; 02329DF8
loc_02329DFC:
	add sp,#0x4	; 02329DFC
	pop {r3}	; 02329DFE
	bx r3	; 02329E00
	.byte 0x00, 0x00	; 02329E04

; ===== function loc_02329E04 =====
loc_02329E04:
	ldr r0,[r0,#0x0]	; 02329E04
	cmp r0,#0x0	; 02329E06
	beq loc_02329E0E	; 02329E08
	add r0,#0x40	; 02329E0A
	strb r1,[r0,#0x0]	; 02329E0C
loc_02329E0E:
	bx lr	; 02329E0E
	.byte 0x1C, 0x21, 0x48, 0x43, 0x01, 0x49, 0x08, 0x5A, 0x70, 0x47, 0xC0, 0x46, 0xA8, 0x68, 0x35, 0x02	; 02329E20

; ===== function loc_02329E20 =====
loc_02329E20:
	ldr r2,[r0,#0x0]	; 02329E20
	cmp r2,#0x0	; 02329E22
	beq loc_02329E2C	; 02329E24
	mov r1,#0x0	; 02329E26
	str r1,[r2,#0x0]	; 02329E28
	str r1,[r0,#0x0]	; 02329E2A
loc_02329E2C:
	bx lr	; 02329E2C
	.byte 0x00, 0x00	; 02329E30

; ===== function loc_02329E30 =====
loc_02329E30:
	mov r1,#0x0	; 02329E30
	str r1,[r0,#0x0]	; 02329E32
	bx lr	; 02329E34
	.byte 0x00, 0x00	; 02329E38
loc_02329E38:
	ldr r0,[r0,#0x0]	; 02329E38
	ldr r3,[pool_02329E40]	; 02329E3A
	bx r3	; 02329E3C
	.byte 0xC0, 0x46	; 02329E40
pool_02329E40:
loc_02329E40:
	.word loc_02329C98 + 1	; 02329E40

; ===== function loc_02329E44 =====
loc_02329E44:
	push {r4,r5,r6,lr}	; 02329E44
	sub sp,#0x8	; 02329E46
	add r5,r0,#0x0	; 02329E48
	add r6,r2,#0x0	; 02329E4A
	mov r3,#0x0	; 02329E4C
	str r3,[sp,#0x0]	; 02329E4E
	add r0,r1,#0x0	; 02329E50
	add r1,r6,#0x0	; 02329E52
	add r1,#0x14	; 02329E54
	ldr r2,[pool_02329EA8]	; 02329E56
	bl loc_0232A79C	; 02329E58
	add r4,r0,#0x0	; 02329E5C
	cmp r4,#0x0	; 02329E5E
	bne loc_02329E6C	; 02329E60
	mov r0,#0x0	; 02329E62
	add sp,#0x8	; 02329E64
	pop {r4,r5,r6}	; 02329E66
	pop {r3}	; 02329E68
	bx r3	; 02329E6A
loc_02329E6C:
	mov r0,#0x0	; 02329E6C
	str r0,[r4,#0xc]	; 02329E6E
	str r5,[r4,#0x10]	; 02329E70
	str r0,[r4,#0x8]	; 02329E72
	add r0,r4,#0x0	; 02329E74
	add r0,#0x14	; 02329E76
	add r1,r6,#0x0	; 02329E78
	bl loc_0232A878	; 02329E7A
	cmp r0,#0x0	; 02329E7E
	bne loc_02329E8C	; 02329E80
	mov r0,#0x0	; 02329E82
	add sp,#0x8	; 02329E84
	pop {r4,r5,r6}	; 02329E86
	pop {r3}	; 02329E88
	bx r3	; 02329E8A
loc_02329E8C:
	str r0,[r4,#0x8]	; 02329E8C
	ldr r1,[pool_02329EAC]	; 02329E8E
	mov r0,#0x1c	; 02329E90
	mul r5,r0	; 02329E92
	add r0,r1,r5	; 02329E94
	add r0,#0xc	; 02329E96
	add r1,r4,#0x0	; 02329E98
	bl loc_02329234	; 02329E9A
	mov r0,#0x1	; 02329E9E
	add sp,#0x8	; 02329EA0
	pop {r4,r5,r6}	; 02329EA2
	pop {r3}	; 02329EA4
	bx r3	; 02329EA6
pool_02329EA8:
loc_02329EA8:
	.word 0x02329AC1	; 02329EA8
pool_02329EAC:
loc_02329EAC:
	.word 0x023568A0	; 02329EAC

; ===== function loc_02329EB0 =====
loc_02329EB0:
	lsl r1,r1,#0x10	; 02329EB0
	lsr r2,r1,#0x10	; 02329EB2
	mov r1,#0x1c	; 02329EB4
	mul r0,r1	; 02329EB6
	ldr r1,[pool_02329EC0]	; 02329EB8
	str r2,[r1,r0]	; 02329EBA
	bx lr	; 02329EBC
	.byte 0xC0, 0x46	; 02329EC0
pool_02329EC0:
loc_02329EC0:
	.word P1_BssStart + 0x25A58	; 02329EC0

; ===== function loc_02329EC4 =====
loc_02329EC4:
	push {r4,r5,r6,r7,lr}	; 02329EC4
	sub sp,#0xc	; 02329EC6
	bl loc_0232EC10	; 02329EC8
	str r0,[sp,#0x4]	; 02329ECC
	ldr r0,[pool_02329FA8]	; 02329ECE
	mov r1,#0x0	; 02329ED0
	bl loc_02329164	; 02329ED2
	add r5,r0,#0x0	; 02329ED6
	cmp r5,#0x0	; 02329ED8
	beq loc_02329FA0	; 02329EDA
	ldr r7,[pool_02329FAC]	; 02329EDC
loc_02329EDE:
	ldr r0,[pool_02329FA8]	; 02329EDE
	add r1,r5,#0x0	; 02329EE0
	bl loc_02329164	; 02329EE2
	str r0,[sp,#0x0]	; 02329EE6
	add r0,r5,#0x0	; 02329EE8
	add r0,#0x2d	; 02329EEA
	ldrb r0,[r0,#0x0]	; 02329EEC
	cmp r0,#0x0	; 02329EEE
	bne loc_02329F04	; 02329EF0
	ldr r0,[r5,#0x30]	; 02329EF2
	bl loc_0232E7B4	; 02329EF4
	cmp r0,#0x0	; 02329EF8
	beq loc_02329F04	; 02329EFA
	add r1,r5,#0x0	; 02329EFC
	add r1,#0x2d	; 02329EFE
	mov r0,#0x1	; 02329F00
	strb r0,[r1,#0x0]	; 02329F02
loc_02329F04:
	add r0,r5,#0x0	; 02329F04
	add r0,#0x2d	; 02329F06
	ldrb r0,[r0,#0x0]	; 02329F08
	cmp r0,#0x0	; 02329F0A
	beq loc_02329F28	; 02329F0C
	add r0,r5,#0x0	; 02329F0E
	add r0,#0x3c	; 02329F10
	ldrb r0,[r0,#0x0]	; 02329F12
	mov r1,#0x1	; 02329F14
	lsl r1,r0	; 02329F16
	ldr r0,[sp,#0x4]	; 02329F18
	and r0,r1	; 02329F1A
	cmp r0,#0x0	; 02329F1C
	bne loc_02329F28	; 02329F1E
	add r0,r5,#0x0	; 02329F20
	bl loc_02329AFC	; 02329F22
	b loc_02329F98	; 02329F26
loc_02329F28:
	add r0,r5,#0x0	; 02329F28
	add r0,#0x1c	; 02329F2A
	bl loc_0232AB48	; 02329F2C
	add r0,r5,#0x0	; 02329F30
	add r0,#0x41	; 02329F32
	ldrb r0,[r0,#0x0]	; 02329F34
	lsl r0,r0,#0x1	; 02329F36
	ldrsh r4,[r7,r0]	; 02329F38
	add r0,r5,#0x0	; 02329F3A
	add r0,#0x40	; 02329F3C
	ldrb r0,[r0,#0x0]	; 02329F3E
	lsl r0,r0,#0x1	; 02329F40
	ldrsh r6,[r7,r0]	; 02329F42
	add r0,r5,#0x0	; 02329F44
	add r0,#0x1c	; 02329F46
	bl loc_0232AB5C	; 02329F48
	asr r0,r0,#0x8	; 02329F4C
	lsl r0,r0,#0x1	; 02329F4E
	ldrsh r1,[r7,r0]	; 02329F50
	add r0,r6,r4	; 02329F52
	add r4,r1,r0	; 02329F54
	ldr r0,[pool_02329FB0]	; 02329F56
	cmp r4,r0	; 02329F58
	bge loc_02329F60	; 02329F5A
	lsl r4,r0,#0	; 02329F5C
	b loc_02329F66	; 02329F5E
loc_02329F60:
	cmp r4,#0x0	; 02329F60
	ble loc_02329F66	; 02329F62
	mov r4,#0x0	; 02329F64
loc_02329F66:
	mov r0,#0x3e	; 02329F66
	ldrsh r0,[r5,r0]	; 02329F68
	cmp r4,r0	; 02329F6A
	beq loc_02329F7C	; 02329F6C
	add r0,r5,#0x0	; 02329F6E
	add r0,#0x3c	; 02329F70
	ldrb r0,[r0,#0x0]	; 02329F72
	add r1,r4,#0x0	; 02329F74
	bl loc_0232E678	; 02329F76
	strh r4,[r5,#0x3e]	; 02329F7A
loc_02329F7C:
	add r0,r5,#0x0	; 02329F7C
	add r0,#0x2c	; 02329F7E
	ldrb r0,[r0,#0x0]	; 02329F80
	cmp r0,#0x2	; 02329F82
	bne loc_02329F98	; 02329F84
	add r0,r5,#0x0	; 02329F86
	add r0,#0x1c	; 02329F88
	bl loc_0232AB38	; 02329F8A
	cmp r0,#0x0	; 02329F8E
	beq loc_02329F98	; 02329F90
	add r0,r5,#0x0	; 02329F92
	bl loc_02329BB4	; 02329F94
loc_02329F98:
	ldr r5,[sp,#0x0]	; 02329F98
	lsl r0,r5,#0	; 02329F9A
	cmp r0,#0x0	; 02329F9C
	bne loc_02329EDE	; 02329F9E
loc_02329FA0:
	add sp,#0xc	; 02329FA0
	pop {r4,r5,r6,r7}	; 02329FA2
	pop {r3}	; 02329FA4
	bx r3	; 02329FA6
pool_02329FA8:
loc_02329FA8:
	.word 0x02356894	; 02329FA8
pool_02329FAC:
loc_02329FAC:
	.word 0x0233089C	; 02329FAC
pool_02329FB0:
loc_02329FB0:
	.word 0xFFFFFD2D	; 02329FB0

; ===== function loc_02329FB4 =====
loc_02329FB4:
	push {r4,r5,r6,r7,lr}	; 02329FB4
	sub sp,#0x4	; 02329FB6
	ldr r0,[pool_0232A018]	; 02329FB8
	mov r1,#0x14	; 02329FBA
	bl loc_0232928C	; 02329FBC
	ldr r0,[pool_0232A01C]	; 02329FC0
	mov r1,#0x14	; 02329FC2
	bl loc_0232928C	; 02329FC4
	mov r5,#0x0	; 02329FC8
	ldr r4,[pool_0232A020]	; 02329FCA
	add r6,r5,#0x0	; 02329FCC
	ldr r7,[pool_0232A01C]	; 02329FCE
loc_02329FD0:
	add r0,r4,#0x0	; 02329FD0
	add r0,#0x2c	; 02329FD2
	strb r6,[r0,#0x0]	; 02329FD4
	add r0,r4,#0x0	; 02329FD6
	add r0,#0x3c	; 02329FD8
	strb r5,[r0,#0x0]	; 02329FDA
	add r0,r7,#0x0	; 02329FDC
	add r1,r4,#0x0	; 02329FDE
	bl loc_02329234	; 02329FE0
	add r4,#0x44	; 02329FE4
	add r5,r5,#0x1	; 02329FE6
	cmp r5,#0x10	; 02329FE8
	blt loc_02329FD0	; 02329FEA
	mov r4,#0x0	; 02329FEC
	ldr r5,[pool_0232A024]	; 02329FEE
	add r6,r4,#0x0	; 02329FF0
	mov r7,#0x1	; 02329FF2
loc_02329FF4:
	add r0,r5,#0x0	; 02329FF4
	mov r1,#0xc	; 02329FF6
	bl loc_0232928C	; 02329FF8
	add r0,r5,#0x0	; 02329FFC
	add r0,#0xc	; 02329FFE
	add r1,r6,#0x0	; 0232A000
	bl loc_0232928C	; 0232A002
	str r7,[r5,#0x18]	; 0232A006
	add r5,#0x1c	; 0232A008
	add r4,r4,#0x1	; 0232A00A
	cmp r4,#0x20	; 0232A00C
	blt loc_02329FF4	; 0232A00E
	add sp,#0x4	; 0232A010
	pop {r4,r5,r6,r7}	; 0232A012
	pop {r3}	; 0232A014
	bx r3	; 0232A016
pool_0232A018:
loc_0232A018:
	.word 0x02356894	; 0232A018
pool_0232A01C:
loc_0232A01C:
	.word 0x02356888	; 0232A01C
pool_0232A020:
loc_0232A020:
	.word P1_BssStart + 0x25DC0	; 0232A020
pool_0232A024:
loc_0232A024:
	.word 0x023568A0	; 0232A024

; ===== function loc_0232A028 =====
	push {r4,r5,r6,r7,lr}	; 0232A028
	sub sp,#0xc	; 0232A02A
; 调度当前双缓冲区块；正常路径将两段缓冲区、块长度、用户值和上下文传给回调。
; Dispatch the current two-buffer block; normal path passes both buffers, size, user value and context.
.func P1_DispatchDualBufferBlock
	add r5,r0,#0x0	; 0232A02C
	ldr r0,[r5,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A02E
	ldr r1,[r5,#P1_DualBufferProcessorBlockCountOffset]	; 0232A030
	blx P1_SignedDivMod	; 0232A032
	str r0,[sp,#0x4]	; 0232A036
	ldr r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A038
	ldr r4,[sp,#0x4]	; 0232A03A
	mul r4,r0	; 0232A03C
	ldr r0,[r5,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A03E
	add r6,r0,r4	; 0232A040
	ldr r0,[r5,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A042
	add r7,r0,r4	; 0232A044
	add r0,r6,#0x0	; 0232A046
	ldr r1,[sp,#0x4]	; 0232A048
	blx P1_InvalidateDataCacheRange	; 0232A04A
	add r0,r7,#0x0	; 0232A04E
	ldr r1,[sp,#0x4]	; 0232A050
	blx P1_InvalidateDataCacheRange	; 0232A052
	ldr r0,[pool_0232A0C0]	; 0232A056
	ldr r0,[r0,#0x0]	; 0232A058
	cmp r0,#0x0	; 0232A05A
	beq loc_0232A090	; 0232A05C
	ldr r2,[pool_0232A0C4]	; 0232A05E
	ldr r0,[pool_0232A0C8]	; 0232A060
	ldr r0,[r0,#0x0]	; 0232A062
	mov r1,#0x14	; 0232A064
	mul r0,r1	; 0232A066
	add r1,r2,r0	; 0232A068
	str r5,[r2,r0]	; 0232A06A
	ldr r0,[sp,#0x4]	; 0232A06C
	str r0,[r1,#0x4]	; 0232A06E
	str r4,[r1,#0x8]	; 0232A070
	str r6,[r1,#0xc]	; 0232A072
	str r7,[r1,#0x10]	; 0232A074
	ldr r0,[pool_0232A0CC]	; 0232A076
	mov r2,#0x0	; 0232A078
	bl loc_0232B698	; 0232A07A
	ldr r0,[pool_0232A0C8]	; 0232A07E
	ldr r1,[r0,#0x0]	; 0232A080
	add r1,r1,#0x1	; 0232A082
	str r1,[r0,#0x0]	; 0232A084
	cmp r1,#0x8	; 0232A086
	blt loc_0232A0A0	; 0232A088
	mov r1,#0x0	; 0232A08A
	str r1,[r0,#0x0]	; 0232A08C
	b loc_0232A0A0	; 0232A08E
loc_0232A090:
	ldr r0,[r5,#P1_DualBufferProcessorCallbackContextOffset]	; 0232A090
	str r0,[sp,#0x0]	; 0232A092
	add r0,r6,#0x0	; 0232A094
	add r1,r7,#0x0	; 0232A096
	ldr r2,[sp,#0x4]	; 0232A098
	ldr r3,[r5,#P1_DualBufferProcessorUserValueOffset]	; 0232A09A
	ldr r4,[r5,#P1_DualBufferProcessorCallbackOffset]	; 0232A09C
	blx r4	; 0232A09E
loc_0232A0A0:
	add r1,r5,#0x0	; 0232A0A0
	add r1,#0x18	; 0232A0A2
	ldr r0,[r1,#0x0]	; 0232A0A4
	add r0,r0,#0x1	; 0232A0A6
	str r0,[r1,#0x0]	; 0232A0A8
	ldr r1,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A0AA
	ldr r0,[r5,#P1_DualBufferProcessorBlockCountOffset]	; 0232A0AC
	cmp r1,r0	; 0232A0AE
	blt loc_0232A0B6	; 0232A0B0
	mov r0,#0x0	; 0232A0B2
	str r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A0B4
loc_0232A0B6:
	add sp,#0xc	; 0232A0B6
	pop {r4,r5,r6,r7}	; 0232A0B8
	pop {r3}	; 0232A0BA
	bx r3	; 0232A0BC
	.byte 0xC0, 0x46	; 0232A0C0
pool_0232A0C0:
.endfunc
loc_0232A0C0:
	.word P1_DualBufferDeferredQueueGate	; 0232A0C0
pool_0232A0C4:
loc_0232A0C4:
	.word P1_DualBufferDeferredQueueEntries	; 0232A0C4
pool_0232A0C8:
loc_0232A0C8:
	.word P1_DualBufferDeferredQueueIndex	; 0232A0C8
pool_0232A0CC:
loc_0232A0CC:
	.word 0x02357068	; 0232A0CC

; ===== function loc_0232A0D0 =====
loc_0232A0D0:
	push {r4,lr}	; 0232A0D0
	sub sp,#0x8	; 0232A0D2
; 将块索引归零、清零两段缓冲区并清理缓存，然后提交状态字段指定的控制请求。
; Reset block index, clear both buffers and clean cache, then submit the state-selected control request.
.func P1_ResetDualBufferBuffers
	ldr r4,[pool_0232A12C]	; 0232A0D4
	ldr r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A0D6
	cmp r0,#0x0	; 0232A0D8
	beq loc_0232A122	; 0232A0DA
	mov r0,#0x0	; 0232A0DC
	str r0,[r4,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A0DE
	str r0,[sp,#0x0]	; 0232A0E0
	ldr r0,[sp,#0x0]	; 0232A0E2
	ldr r1,[r4,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A0E4
	ldr r2,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A0E6
	blx loc_0232E318	; 0232A0E8
	mov r0,#0x0	; 0232A0EC
	str r0,[sp,#0x4]	; 0232A0EE
	ldr r0,[sp,#0x4]	; 0232A0F0
	ldr r1,[r4,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A0F2
	ldr r2,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A0F4
	blx loc_0232E318	; 0232A0F6
	ldr r0,[r4,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A0FA
	ldr r1,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A0FC
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A0FE
	ldr r0,[r4,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A102
	ldr r1,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A104
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A106
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A10A
	cmp r0,#0x0	; 0232A10C
	blt loc_0232A116	; 0232A10E
	mov r2,#0x1	; 0232A110
	lsl r2,r0	; 0232A112
	b loc_0232A118	; 0232A114
loc_0232A116:
	mov r2,#0x0	; 0232A116
loc_0232A118:
	ldr r0,[r4,#0x20]	; 0232A118
	ldr r1,[r4,#0x24]	; 0232A11A
	mov r3,#0x0	; 0232A11C
	bl loc_0232E614	; 0232A11E
loc_0232A122:
	add sp,#0x8	; 0232A122
	pop {r4}	; 0232A124
	pop {r3}	; 0232A126
	bx r3	; 0232A128
	.byte 0xC0, 0x46	; 0232A12C
pool_0232A12C:
.endfunc
loc_0232A12C:
	.word P1_DualBufferProcessorState	; 0232A12C

; ===== function loc_0232A130 =====
loc_0232A130:
	push {r4,lr}	; 0232A130
	ldr r1,[pool_0232A16C]	; 0232A132
; 处理器有效时，依据其配置字段提交控制掩码并完成相关状态更新。
; When active, submit a control mask from configuration fields and complete related state updates.
.func P1_ApplyDualBufferProcessorSettings
	ldr r0,[r1,#P1_DualBufferProcessorActiveOffset]	; 0232A134
	cmp r0,#0x0	; 0232A136
	beq loc_0232A164	; 0232A138
	ldr r0,[r1,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A13A
	cmp r0,#0x0	; 0232A13C
	blt loc_0232A146	; 0232A13E
	mov r2,#0x1	; 0232A140
	lsl r2,r0	; 0232A142
	b loc_0232A148	; 0232A144
loc_0232A146:
	mov r2,#0x0	; 0232A146
loc_0232A148:
	ldr r0,[r1,#0x20]	; 0232A148
	ldr r1,[r1,#0x24]	; 0232A14A
	mov r3,#0x0	; 0232A14C
	bl loc_0232E5CC	; 0232A14E
	bl loc_0232E7E4	; 0232A152
	add r4,r0,#0x0	; 0232A156
	mov r0,#0x1	; 0232A158
	bl loc_0232E850	; 0232A15A
	add r0,r4,#0x0	; 0232A15E
	bl loc_0232E804	; 0232A160
loc_0232A164:
	pop {r4}	; 0232A164
	pop {r3}	; 0232A166
	bx r3	; 0232A168
	.byte 0xC0, 0x46	; 0232A16C
pool_0232A16C:
.endfunc
loc_0232A16C:
	.word P1_DualBufferProcessorState	; 0232A16C

; ===== function loc_0232A170 =====
loc_0232A170:
	push {r4,r5,r6,r7,lr}	; 0232A170
	sub sp,#0x4	; 0232A172
; 停止处理器关联服务，处理登记资源后清除其有效标志。
; Stop associated services, process registered resources, then clear the active flag.
.func P1_StopDualBufferProcessor
	ldr r4,[pool_0232A200]	; 0232A174
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A176
	cmp r0,#0x0	; 0232A178
	blt loc_0232A180	; 0232A17A
	mov r5,#0x1	; 0232A17C
	b loc_0232A182	; 0232A17E
loc_0232A180:
	mov r5,#0x0	; 0232A180
loc_0232A182:
	cmp r5,#0x0	; 0232A182
	beq loc_0232A18E	; 0232A184
	mov r2,#0x1	; 0232A186
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A188
	lsl r2,r0	; 0232A18A
	b loc_0232A190	; 0232A18C
loc_0232A18E:
	mov r2,#0x0	; 0232A18E
loc_0232A190:
	ldr r0,[r4,#0x20]	; 0232A190
	ldr r1,[r4,#0x24]	; 0232A192
	mov r3,#0x0	; 0232A194
	bl loc_0232E5CC	; 0232A196
	cmp r5,#0x0	; 0232A19A
	beq loc_0232A1C2	; 0232A19C
	bl loc_0232E7E4	; 0232A19E
	add r6,r0,#0x0	; 0232A1A2
	mov r0,#0x1	; 0232A1A4
	bl loc_0232E850	; 0232A1A6
	add r0,r6,#0x0	; 0232A1AA
	bl loc_0232E804	; 0232A1AC
	ldr r6,[pool_0232A204]	; 0232A1B0
	mov r7,#0x0	; 0232A1B2
loc_0232A1B4:
	add r0,r6,#0x0	; 0232A1B4
	add r1,r7,#0x0	; 0232A1B6
	add r2,r7,#0x0	; 0232A1B8
	bl loc_0232B620	; 0232A1BA
	cmp r0,#0x0	; 0232A1BE
	bne loc_0232A1B4	; 0232A1C0
loc_0232A1C2:
	ldr r0,[r4,#0x24]	; 0232A1C2
	cmp r0,#0x0	; 0232A1C4
	beq loc_0232A1CC	; 0232A1C6
	bl loc_023299D4	; 0232A1C8
loc_0232A1CC:
	ldr r0,[r4,#0x1c]	; 0232A1CC
	cmp r0,#0x0	; 0232A1CE
	beq loc_0232A1D6	; 0232A1D0
	bl loc_02329A00	; 0232A1D2
loc_0232A1D6:
	cmp r5,#0x0	; 0232A1D6
	beq loc_0232A1E0	; 0232A1D8
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A1DA
	bl loc_02329994	; 0232A1DC
loc_0232A1E0:
	ldr r0,[r4,#P1_DualBufferProcessorModeOffset]	; 0232A1E0
	cmp r0,#0x1	; 0232A1E2
	bne loc_0232A1F2	; 0232A1E4
	mov r0,#0x0	; 0232A1E6
	add r1,r0,#0x0	; 0232A1E8
	add r2,r0,#0x0	; 0232A1EA
	add r3,r0,#0x0	; 0232A1EC
	bl loc_0232E4B4	; 0232A1EE
loc_0232A1F2:
	mov r0,#0x0	; 0232A1F2
	str r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A1F4
	add sp,#0x4	; 0232A1F6
	pop {r4,r5,r6,r7}	; 0232A1F8
	pop {r3}	; 0232A1FA
	bx r3	; 0232A1FC
	.byte 0xC0, 0x46	; 0232A200
pool_0232A200:
.endfunc
loc_0232A200:
	.word P1_DualBufferProcessorState	; 0232A200
pool_0232A204:
loc_0232A204:
	.word 0x02357068	; 0232A204

; ===== function loc_0232A208 =====
loc_0232A208:
	push {r4,r5,r6,r7,lr}	; 0232A208
	sub sp,#0x44	; 0232A20A
; 初始化双缓冲状态，保存缓冲区、分块信息、回调及其上下文，并登记块调度函数。
; Initialize two-buffer state, store buffers/block data/callback/context, and register the block dispatcher.
.func P1_CreateDualBufferProcessor
	str r0,[sp,#0x18]	; 0232A20C
	str r1,[sp,#0x1c]	; 0232A20E
	str r2,[sp,#0x20]	; 0232A210
	str r3,[sp,#0x24]	; 0232A212
	ldr r7,[sp,#0x64]	; 0232A214
	ldr r0,[sp,#0x6c]	; 0232A216
	str r0,[sp,#0x6c]	; 0232A218
	mov r0,#0x0	; 0232A21A
	str r0,[sp,#0x30]	; 0232A21C
	mvn r5,r0	; 0232A21E
	ldr r4,[pool_0232A424]	; 0232A220
	lsl r0,r1,#0	; 0232A222
	lsl r1,r3,#0	; 0232A224
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A226
	ldr r0,[sp,#0x20]	; 0232A22A
	ldr r1,[sp,#0x24]	; 0232A22C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A22E
	ldr r0,[sp,#0x58]	; 0232A232
	cmp r0,#0x1	; 0232A234
	bne loc_0232A23C	; 0232A236
	mov r6,#0x1	; 0232A238
	b loc_0232A23E	; 0232A23A
loc_0232A23C:
	mov r6,#0x0	; 0232A23C
loc_0232A23E:
	ldr r0,[pool_0232A428]	; 0232A23E
	ldr r1,[sp,#0x68]	; 0232A240
	blx P1_SignedDivMod	; 0232A242
	str r0,[sp,#0x34]	; 0232A246
	ldr r0,[sp,#0x7c]	; 0232A248
	cmp r0,#0x0	; 0232A24A
	beq loc_0232A288	; 0232A24C
	ldr r0,[sp,#0x24]	; 0232A24E
	cmp r6,#0x0	; 0232A250
	bne loc_0232A256	; 0232A252
	asr r0,r0,#0x1	; 0232A254
loc_0232A256:
	ldr r1,[sp,#0x34]	; 0232A256
	add r1,#0x10	; 0232A258
	str r1,[sp,#0x34]	; 0232A25A
	mov r2,#0x1f	; 0232A25C
	bic r1,r2	; 0232A25E
	str r1,[sp,#0x34]	; 0232A260
	asr r1,r1,#0x5	; 0232A262
	str r1,[sp,#0x40]	; 0232A264
	ldr r1,[sp,#0x78]	; 0232A266
	blx P1_SignedDivMod	; 0232A268
	ldr r1,[sp,#0x40]	; 0232A26C
	str r1,[sp,#0x38]	; 0232A26E
	mul r1,r0	; 0232A270
	str r1,[sp,#0x38]	; 0232A272
	mov r0,#0x20	; 0232A274
	str r0,[sp,#0x3c]	; 0232A276
	cmp r6,#0x0	; 0232A278
	bne loc_0232A280	; 0232A27A
	asr r0,r0,#0x1	; 0232A27C
	str r0,[sp,#0x3c]	; 0232A27E
loc_0232A280:
	ldr r1,[sp,#0x3c]	; 0232A280
	ldr r0,[sp,#0x40]	; 0232A282
	mul r1,r0	; 0232A284
	str r1,[sp,#0x3c]	; 0232A286
loc_0232A288:
	cmp r6,#0x0	; 0232A288
	beq loc_0232A292	; 0232A28A
	mov r0,#0x0	; 0232A28C
	str r0,[sp,#0x2c]	; 0232A28E
	b loc_0232A296	; 0232A290
loc_0232A292:
	mov r0,#0x1	; 0232A292
	str r0,[sp,#0x2c]	; 0232A294
loc_0232A296:
	cmp r6,#0x0	; 0232A296
	beq loc_0232A2A0	; 0232A298
	mov r0,#0x1	; 0232A29A
	str r0,[sp,#0x28]	; 0232A29C
	b loc_0232A2A4	; 0232A29E
loc_0232A2A0:
	mov r0,#0x0	; 0232A2A0
	str r0,[sp,#0x28]	; 0232A2A2
loc_0232A2A4:
	ldr r0,[sp,#0x18]	; 0232A2A4
	cmp r0,#0x2	; 0232A2A6
	beq loc_0232A2AE	; 0232A2A8
	mov r0,#0xa	; 0232A2AA
	str r0,[sp,#0x30]	; 0232A2AC
loc_0232A2AE:
	ldr r0,[sp,#0x7c]	; 0232A2AE
	cmp r0,#0x0	; 0232A2B0
	beq loc_0232A2C8	; 0232A2B2
	bl loc_023299A8	; 0232A2B4
	add r5,r0,#0x0	; 0232A2B8
	cmp r5,#0x0	; 0232A2BA
	bge loc_0232A2C8	; 0232A2BC
	mov r0,#0x0	; 0232A2BE
	add sp,#0x44	; 0232A2C0
	pop {r4,r5,r6,r7}	; 0232A2C2
	pop {r3}	; 0232A2C4
	bx r3	; 0232A2C6
loc_0232A2C8:
	mov r0,#0x3	; 0232A2C8
	bl loc_023299E4	; 0232A2CA
	cmp r0,#0x0	; 0232A2CE
	bne loc_0232A2E6	; 0232A2D0
	cmp r5,#0x0	; 0232A2D2
	blt loc_0232A2DC	; 0232A2D4
	add r0,r5,#0x0	; 0232A2D6
	bl loc_02329994	; 0232A2D8
loc_0232A2DC:
	mov r0,#0x0	; 0232A2DC
	add sp,#0x44	; 0232A2DE
	pop {r4,r5,r6,r7}	; 0232A2E0
	pop {r3}	; 0232A2E2
	bx r3	; 0232A2E4
loc_0232A2E6:
	mov r0,#0xa	; 0232A2E6
	bl loc_02329A20	; 0232A2E8
	cmp r0,#0x0	; 0232A2EC
	bne loc_0232A30A	; 0232A2EE
	cmp r5,#0x0	; 0232A2F0
	blt loc_0232A2FA	; 0232A2F2
	add r0,r5,#0x0	; 0232A2F4
	bl loc_02329994	; 0232A2F6
loc_0232A2FA:
	mov r0,#0x3	; 0232A2FA
	bl loc_023299D4	; 0232A2FC
	mov r0,#0x0	; 0232A300
	add sp,#0x44	; 0232A302
	pop {r4,r5,r6,r7}	; 0232A304
	pop {r3}	; 0232A306
	bx r3	; 0232A308
loc_0232A30A:
	cmp r7,#0x0	; 0232A30A
	beq loc_0232A312	; 0232A30C
	mov r3,#0x1	; 0232A30E
	b loc_0232A314	; 0232A310
loc_0232A312:
	mov r3,#0x2	; 0232A312
loc_0232A314:
	ldr r0,[sp,#0x24]	; 0232A314
	lsr r6,r0,#0x2	; 0232A316
	mov r1,#0x0	; 0232A318
	str r1,[sp,#0x0]	; 0232A31A
	str r6,[sp,#0x4]	; 0232A31C
	ldr r0,[sp,#0x6c]	; 0232A31E
	str r0,[sp,#0x8]	; 0232A320
	str r1,[sp,#0xc]	; 0232A322
	ldr r0,[sp,#0x34]	; 0232A324
	str r0,[sp,#0x10]	; 0232A326
	ldr r0,[sp,#0x70]	; 0232A328
	str r0,[sp,#0x14]	; 0232A32A
	mov r0,#0x1	; 0232A32C
	ldr r1,[sp,#0x2c]	; 0232A32E
	ldr r2,[sp,#0x1c]	; 0232A330
	bl loc_0232E4D4	; 0232A332
	str r7,[sp,#0x0]	; 0232A336
	ldr r0,[sp,#0x5c]	; 0232A338
	str r0,[sp,#0x4]	; 0232A33A
	ldr r0,[sp,#0x60]	; 0232A33C
	str r0,[sp,#0x8]	; 0232A33E
	mov r0,#0x0	; 0232A340
	ldr r1,[sp,#0x28]	; 0232A342
	ldr r2,[sp,#0x1c]	; 0232A344
	add r3,r6,#0x0	; 0232A346
	bl loc_0232E590	; 0232A348
	cmp r7,#0x0	; 0232A34C
	beq loc_0232A354	; 0232A34E
	mov r3,#0x1	; 0232A350
	b loc_0232A356	; 0232A352
loc_0232A354:
	mov r3,#0x2	; 0232A354
loc_0232A356:
	mov r1,#0x0	; 0232A356
	str r1,[sp,#0x0]	; 0232A358
	str r6,[sp,#0x4]	; 0232A35A
	ldr r0,[sp,#0x6c]	; 0232A35C
	str r0,[sp,#0x8]	; 0232A35E
	str r1,[sp,#0xc]	; 0232A360
	ldr r0,[sp,#0x34]	; 0232A362
	str r0,[sp,#0x10]	; 0232A364
	ldr r0,[sp,#0x74]	; 0232A366
	str r0,[sp,#0x14]	; 0232A368
	mov r0,#0x3	; 0232A36A
	ldr r1,[sp,#0x2c]	; 0232A36C
	ldr r2,[sp,#0x20]	; 0232A36E
	bl loc_0232E4D4	; 0232A370
	str r7,[sp,#0x0]	; 0232A374
	ldr r0,[sp,#0x5c]	; 0232A376
	str r0,[sp,#0x4]	; 0232A378
	ldr r0,[sp,#0x60]	; 0232A37A
	str r0,[sp,#0x8]	; 0232A37C
	mov r0,#0x1	; 0232A37E
	ldr r1,[sp,#0x28]	; 0232A380
	ldr r2,[sp,#0x20]	; 0232A382
	add r3,r6,#0x0	; 0232A384
	bl loc_0232E590	; 0232A386
	cmp r5,#0x0	; 0232A38A
	blt loc_0232A39E	; 0232A38C
	str r4,[sp,#0x0]	; 0232A38E
	add r0,r5,#0x0	; 0232A390
	ldr r2,[sp,#0x38]	; 0232A392
	ldr r1,[sp,#0x3c]	; 0232A394
	add r1,r2,r1	; 0232A396
	ldr r3,[pool_0232A42C]	; 0232A398
	bl loc_0232E568	; 0232A39A
loc_0232A39E:
	ldr r0,[sp,#0x18]	; 0232A39E
	cmp r0,#0x1	; 0232A3A0
	bne loc_0232A3B0	; 0232A3A2
	mov r0,#0x3	; 0232A3A4
	add r1,r0,#0x0	; 0232A3A6
	mov r2,#0x1	; 0232A3A8
	add r3,r2,#0x0	; 0232A3AA
	bl loc_0232E4B4	; 0232A3AC
loc_0232A3B0:
	cmp r5,#0x0	; 0232A3B0
	blt loc_0232A3BA	; 0232A3B2
	mov r2,#0x1	; 0232A3B4
	lsl r2,r5	; 0232A3B6
	b loc_0232A3BC	; 0232A3B8
loc_0232A3BA:
	mov r2,#0x0	; 0232A3BA
loc_0232A3BC:
	ldr r0,[sp,#0x30]	; 0232A3BC
	mov r1,#0x3	; 0232A3BE
	mov r3,#0x0	; 0232A3C0
	bl loc_0232E614	; 0232A3C2
	mov r0,#0x1	; 0232A3C6
	str r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A3C8
	ldr r0,[sp,#0x18]	; 0232A3CA
	str r0,[r4,#P1_DualBufferProcessorModeOffset]	; 0232A3CC
	mov r0,#0xa	; 0232A3CE
	str r0,[r4,#0x1c]	; 0232A3D0
	ldr r0,[sp,#0x30]	; 0232A3D2
	str r0,[r4,#0x20]	; 0232A3D4
	mov r0,#0x3	; 0232A3D6
	str r0,[r4,#0x24]	; 0232A3D8
	str r5,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A3DA
	ldr r0,[sp,#0x58]	; 0232A3DC
	str r0,[r4,#P1_DualBufferProcessorUserValueOffset]	; 0232A3DE
	ldr r0,[sp,#0x1c]	; 0232A3E0
	str r0,[r4,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A3E2
	ldr r0,[sp,#0x20]	; 0232A3E4
	str r0,[r4,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A3E6
	ldr r0,[sp,#0x24]	; 0232A3E8
	str r0,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A3EA
	mov r0,#0x0	; 0232A3EC
	str r0,[r4,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A3EE
	ldr r0,[sp,#0x78]	; 0232A3F0
	str r0,[r4,#P1_DualBufferProcessorBlockCountOffset]	; 0232A3F2
	ldr r0,[sp,#0x7c]	; 0232A3F4
	str r0,[r4,#P1_DualBufferProcessorCallbackOffset]	; 0232A3F6
	ldr r0,[sp,#0x80]	; 0232A3F8
	str r0,[r4,#P1_DualBufferProcessorCallbackContextOffset]	; 0232A3FA
	ldr r0,[sp,#0x6c]	; 0232A3FC
	str r0,[r4,#P1_DualBufferProcessorLastReportedValueOffset]	; 0232A3FE
	add r0,r4,#0x0	; 0232A400
	add r0,#0x38	; 0232A402
	bl loc_0232ABA0	; 0232A404
	add r0,r4,#0x0	; 0232A408
	add r0,#0x38	; 0232A40A
	ldr r1,[sp,#0x6c]	; 0232A40C
	lsl r1,r1,#0x8	; 0232A40E
	mov r2,#0x1	; 0232A410
	bl loc_0232AB84	; 0232A412
	mov r0,#0x0	; 0232A416
	str r0,[r4,#0x48]	; 0232A418
	mov r0,#0x1	; 0232A41A
	add sp,#0x44	; 0232A41C
	pop {r4,r5,r6,r7}	; 0232A41E
	pop {r3}	; 0232A420
	bx r3	; 0232A422
pool_0232A424:
loc_0232A424:
.endfunc
	.word P1_DualBufferProcessorState	; 0232A424
pool_0232A428:
loc_0232A428:
	.word 0x00FFB0FF	; 0232A428
pool_0232A42C:
loc_0232A42C:
	.word P1_DispatchDualBufferBlock + 1	; 0232A42C

; ===== function loc_0232A430 =====
loc_0232A430:
	push {lr}	; 0232A430
	sub sp,#0x4	; 0232A432
; 仅当处理器已有效且模式字段为 1 时调用停止路径。
; Call the stop path only when the processor is active and its mode field is 1.
.func P1_StopActiveDualBufferProcessor
	ldr r0,[pool_0232A44C]	; 0232A434
	ldr r1,[r0,#P1_DualBufferProcessorActiveOffset]	; 0232A436
	cmp r1,#0x0	; 0232A438
	beq loc_0232A446	; 0232A43A
	ldr r0,[r0,#P1_DualBufferProcessorModeOffset]	; 0232A43C
	cmp r0,#0x1	; 0232A43E
	bne loc_0232A446	; 0232A440
	bl P1_StopDualBufferProcessor	; 0232A442
loc_0232A446:
	add sp,#0x4	; 0232A446
	pop {r3}	; 0232A448
	bx r3	; 0232A44A
pool_0232A44C:
loc_0232A44C:
.endfunc
	.word P1_DualBufferProcessorState	; 0232A44C

; ===== function loc_0232A450 =====
loc_0232A450:
	push {r4,r5,r6,r7,lr}	; 0232A450
	sub sp,#0x34	; 0232A452
; 清零并清理首个缓冲区，然后将参数转交给双缓冲对象构造器。
; Clear and clean the first buffer, then forward parameters to the two-buffer constructor.
.func P1_ConfigureDualBufferProcessor
	add r5,r0,#0x0	; 0232A454
	add r4,r1,#0x0	; 0232A456
	add r6,r2,#0x0	; 0232A458
	add r7,r3,#0x0	; 0232A45A
	bl P1_StopActiveDualBufferProcessor	; 0232A45C
	ldr r0,[pool_0232A4BC]	; 0232A460
	ldr r0,[r0,#0x0]	; 0232A462
	cmp r0,#0x0	; 0232A464
	beq loc_0232A472	; 0232A466
	mov r0,#0x0	; 0232A468
	add sp,#0x34	; 0232A46A
	pop {r4,r5,r6,r7}	; 0232A46C
	pop {r3}	; 0232A46E
	bx r3	; 0232A470
loc_0232A472:
	mov r0,#0x0	; 0232A472
	str r0,[sp,#0x2c]	; 0232A474
	ldr r0,[sp,#0x2c]	; 0232A476
	add r1,r5,#0x0	; 0232A478
	add r2,r4,#0x0	; 0232A47A
	blx loc_0232E318	; 0232A47C
	add r0,r5,#0x0	; 0232A480
	add r1,r4,#0x0	; 0232A482
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A484
	lsr r3,r4,#0x1	; 0232A488
	str r6,[sp,#0x0]	; 0232A48A
	mov r2,#0x0	; 0232A48C
	str r2,[sp,#0x4]	; 0232A48E
	str r2,[sp,#0x8]	; 0232A490
	mov r0,#0x1	; 0232A492
	str r0,[sp,#0xc]	; 0232A494
	str r7,[sp,#0x10]	; 0232A496
	mov r1,#0x7f	; 0232A498
	str r1,[sp,#0x14]	; 0232A49A
	str r2,[sp,#0x18]	; 0232A49C
	str r1,[sp,#0x1c]	; 0232A49E
	ldr r1,[sp,#0x48]	; 0232A4A0
	str r1,[sp,#0x20]	; 0232A4A2
	ldr r1,[sp,#0x4c]	; 0232A4A4
	str r1,[sp,#0x24]	; 0232A4A6
	ldr r1,[sp,#0x50]	; 0232A4A8
	str r1,[sp,#0x28]	; 0232A4AA
	add r1,r5,#0x0	; 0232A4AC
	add r2,r5,r3	; 0232A4AE
	bl P1_CreateDualBufferProcessor	; 0232A4B0
	add sp,#0x34	; 0232A4B4
	pop {r4,r5,r6,r7}	; 0232A4B6
	pop {r3}	; 0232A4B8
	bx r3	; 0232A4BA
pool_0232A4BC:
loc_0232A4BC:
.endfunc
	.word P1_DualBufferProcessorState	; 0232A4BC

; ===== function loc_0232A4C0 =====
loc_0232A4C0:
	push {r4,r5,lr}	; 0232A4C0
	sub sp,#0x4	; 0232A4C2
; 轮询处理状态；出现终止条件时停止，否则在状态值改变时向下层提交更新。
; Poll processor status; stop on termination, otherwise submit a changed state value to the lower layer.
.func P1_UpdateDualBufferProcessorStatus
	ldr r4,[pool_0232A51C]	; 0232A4C4
	ldr r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A4C6
	cmp r0,#0x0	; 0232A4C8
	beq loc_0232A512	; 0232A4CA
	ldr r0,[r4,#P1_DualBufferProcessorModeOffset]	; 0232A4CC
	cmp r0,#0x0	; 0232A4CE
	bne loc_0232A512	; 0232A4D0
	add r5,r4,#0x0	; 0232A4D2
	add r5,#0x38	; 0232A4D4
	add r0,r5,#0x0	; 0232A4D6
	bl loc_0232AB48	; 0232A4D8
	ldr r0,[r4,#0x48]	; 0232A4DC
	cmp r0,#0x0	; 0232A4DE
	beq loc_0232A4F8	; 0232A4E0
	add r0,r5,#0x0	; 0232A4E2
	bl loc_0232AB38	; 0232A4E4
	cmp r0,#0x0	; 0232A4E8
	beq loc_0232A4F8	; 0232A4EA
	bl P1_StopDualBufferProcessor	; 0232A4EC
	add sp,#0x4	; 0232A4F0
	pop {r4,r5}	; 0232A4F2
	pop {r3}	; 0232A4F4
	bx r3	; 0232A4F6
loc_0232A4F8:
	add r0,r5,#0x0	; 0232A4F8
	bl loc_0232AB5C	; 0232A4FA
	asr r5,r0,#0x8	; 0232A4FE
	ldr r0,[r4,#P1_DualBufferProcessorLastReportedValueOffset]	; 0232A500
	cmp r5,r0	; 0232A502
	beq loc_0232A512	; 0232A504
	ldr r0,[r4,#0x20]	; 0232A506
	add r1,r5,#0x0	; 0232A508
	mov r2,#0x0	; 0232A50A
	bl loc_0232E510	; 0232A50C
	str r5,[r4,#P1_DualBufferProcessorLastReportedValueOffset]	; 0232A510
loc_0232A512:
	add sp,#0x4	; 0232A512
	pop {r4,r5}	; 0232A514
	pop {r3}	; 0232A516
	bx r3	; 0232A518
	.byte 0xC0, 0x46	; 0232A51C
pool_0232A51C:
.endfunc
loc_0232A51C:
	.word P1_DualBufferProcessorState	; 0232A51C

; ===== function loc_0232A520 =====
loc_0232A520:
	mov r1,#0x0	; 0232A520
	ldr r0,[pool_0232A52C]	; 0232A522
; 清除处理器有效标志及延后交付队列开关。
; Clear the processor active flag and deferred-delivery queue gate.
.func P1_ClearDualBufferProcessorAndQueueState
	str r1,[r0,#0x0]	; 0232A524
	ldr r0,[pool_0232A530]	; 0232A526
	str r1,[r0,#P1_DualBufferProcessorActiveOffset]	; 0232A528
	bx lr	; 0232A52A
pool_0232A52C:
loc_0232A52C:
.endfunc
	.word P1_DualBufferDeferredQueueGate	; 0232A52C
pool_0232A530:
loc_0232A530:
	.word P1_DualBufferProcessorState	; 0232A530

; ===== function loc_0232A534 =====
loc_0232A534:
	ldr r1,[pool_0232A54C]	; 0232A534
	ldr r1,[r1,#0x0]	; 0232A536
	ldr r2,[r1,#0x7c]	; 0232A538
	ldr r1,[r2,#0x8]	; 0232A53A
	cmp r0,r1	; 0232A53C
	bcc loc_0232A544	; 0232A53E
	mov r0,#0x0	; 0232A540
	bx lr	; 0232A542
loc_0232A544:
	lsl r0,r0,#0x4	; 0232A544
	add r0,r2,r0	; 0232A546
	ldr r0,[r0,#0x14]	; 0232A548
	bx lr	; 0232A54A
pool_0232A54C:
loc_0232A54C:
	.word P1_BssStart + 0x2630C	; 0232A54C

; ===== function loc_0232A550 =====
loc_0232A550:
	ldr r1,[pool_0232A598]	; 0232A550
	ldr r1,[r1,#0x0]	; 0232A552
	add r2,r1,#0x0	; 0232A554
	add r2,#0x84	; 0232A556
	ldr r3,[r2,#0x0]	; 0232A558
	ldr r2,[r3,#0x18]	; 0232A55A
	cmp r2,#0x0	; 0232A55C
	bne loc_0232A564	; 0232A55E
	mov r3,#0x0	; 0232A560
	b loc_0232A566	; 0232A562
loc_0232A564:
	add r3,r3,r2	; 0232A564
loc_0232A566:
	cmp r3,#0x0	; 0232A566
	bne loc_0232A56E	; 0232A568
	mov r0,#0x0	; 0232A56A
	bx lr	; 0232A56C
loc_0232A56E:
	cmp r0,#0x0	; 0232A56E
	bge loc_0232A576	; 0232A570
	mov r0,#0x0	; 0232A572
	bx lr	; 0232A574
loc_0232A576:
	ldr r2,[r3,#0x0]	; 0232A576
	cmp r0,r2	; 0232A578
	bcc loc_0232A580	; 0232A57A
	mov r0,#0x0	; 0232A57C
	bx lr	; 0232A57E
loc_0232A580:
	lsl r0,r0,#0x2	; 0232A580
	add r0,r3,r0	; 0232A582
	ldr r2,[r0,#0x4]	; 0232A584
	add r1,#0x84	; 0232A586
	ldr r0,[r1,#0x0]	; 0232A588
	cmp r2,#0x0	; 0232A58A
	bne loc_0232A592	; 0232A58C
	mov r0,#0x0	; 0232A58E
	bx lr	; 0232A590
loc_0232A592:
	add r0,r0,r2	; 0232A592
	bx lr	; 0232A594
	.byte 0xC0, 0x46	; 0232A598
pool_0232A598:
loc_0232A598:
	.word P1_BssStart + 0x2630C	; 0232A598

; ===== function loc_0232A59C =====
loc_0232A59C:
	ldr r1,[pool_0232A5E4]	; 0232A59C
	ldr r1,[r1,#0x0]	; 0232A59E
	add r2,r1,#0x0	; 0232A5A0
	add r2,#0x84	; 0232A5A2
	ldr r3,[r2,#0x0]	; 0232A5A4
	ldr r2,[r3,#0x14]	; 0232A5A6
	cmp r2,#0x0	; 0232A5A8
	bne loc_0232A5B0	; 0232A5AA
	mov r3,#0x0	; 0232A5AC
	b loc_0232A5B2	; 0232A5AE
loc_0232A5B0:
	add r3,r3,r2	; 0232A5B0
loc_0232A5B2:
	cmp r3,#0x0	; 0232A5B2
	bne loc_0232A5BA	; 0232A5B4
	mov r0,#0x0	; 0232A5B6
	bx lr	; 0232A5B8
loc_0232A5BA:
	cmp r0,#0x0	; 0232A5BA
	bge loc_0232A5C2	; 0232A5BC
	mov r0,#0x0	; 0232A5BE
	bx lr	; 0232A5C0
loc_0232A5C2:
	ldr r2,[r3,#0x0]	; 0232A5C2
	cmp r0,r2	; 0232A5C4
	bcc loc_0232A5CC	; 0232A5C6
	mov r0,#0x0	; 0232A5C8
	bx lr	; 0232A5CA
loc_0232A5CC:
	lsl r0,r0,#0x2	; 0232A5CC
	add r0,r3,r0	; 0232A5CE
	ldr r2,[r0,#0x4]	; 0232A5D0
	add r1,#0x84	; 0232A5D2
	ldr r0,[r1,#0x0]	; 0232A5D4
	cmp r2,#0x0	; 0232A5D6
	bne loc_0232A5DE	; 0232A5D8
	mov r0,#0x0	; 0232A5DA
	bx lr	; 0232A5DC
loc_0232A5DE:
	add r0,r0,r2	; 0232A5DE
	bx lr	; 0232A5E0
	.byte 0xC0, 0x46	; 0232A5E4
pool_0232A5E4:
loc_0232A5E4:
	.word P1_BssStart + 0x2630C	; 0232A5E4

; ===== function loc_0232A5E8 =====
loc_0232A5E8:
	ldr r1,[pool_0232A630]	; 0232A5E8
	ldr r1,[r1,#0x0]	; 0232A5EA
	add r2,r1,#0x0	; 0232A5EC
	add r2,#0x84	; 0232A5EE
	ldr r3,[r2,#0x0]	; 0232A5F0
	ldr r2,[r3,#0x10]	; 0232A5F2
	cmp r2,#0x0	; 0232A5F4
	bne loc_0232A5FC	; 0232A5F6
	mov r3,#0x0	; 0232A5F8
	b loc_0232A5FE	; 0232A5FA
loc_0232A5FC:
	add r3,r3,r2	; 0232A5FC
loc_0232A5FE:
	cmp r3,#0x0	; 0232A5FE
	bne loc_0232A606	; 0232A600
	mov r0,#0x0	; 0232A602
	bx lr	; 0232A604
loc_0232A606:
	cmp r0,#0x0	; 0232A606
	bge loc_0232A60E	; 0232A608
	mov r0,#0x0	; 0232A60A
	bx lr	; 0232A60C
loc_0232A60E:
	ldr r2,[r3,#0x0]	; 0232A60E
	cmp r0,r2	; 0232A610
	bcc loc_0232A618	; 0232A612
	mov r0,#0x0	; 0232A614
	bx lr	; 0232A616
loc_0232A618:
	lsl r0,r0,#0x2	; 0232A618
	add r0,r3,r0	; 0232A61A
	ldr r2,[r0,#0x4]	; 0232A61C
	add r1,#0x84	; 0232A61E
	ldr r0,[r1,#0x0]	; 0232A620
	cmp r2,#0x0	; 0232A622
	bne loc_0232A62A	; 0232A624
	mov r0,#0x0	; 0232A626
	bx lr	; 0232A628
loc_0232A62A:
	add r0,r0,r2	; 0232A62A
	bx lr	; 0232A62C
	.byte 0xC0, 0x46	; 0232A630
pool_0232A630:
loc_0232A630:
	.word P1_BssStart + 0x2630C	; 0232A630

; ===== function loc_0232A634 =====
loc_0232A634:
	ldr r1,[pool_0232A67C]	; 0232A634
	ldr r1,[r1,#0x0]	; 0232A636
	add r2,r1,#0x0	; 0232A638
	add r2,#0x84	; 0232A63A
	ldr r3,[r2,#0x0]	; 0232A63C
	ldr r2,[r3,#0xc]	; 0232A63E
	cmp r2,#0x0	; 0232A640
	bne loc_0232A648	; 0232A642
	mov r3,#0x0	; 0232A644
	b loc_0232A64A	; 0232A646
loc_0232A648:
	add r3,r3,r2	; 0232A648
loc_0232A64A:
	cmp r3,#0x0	; 0232A64A
	bne loc_0232A652	; 0232A64C
	mov r0,#0x0	; 0232A64E
	bx lr	; 0232A650
loc_0232A652:
	cmp r0,#0x0	; 0232A652
	bge loc_0232A65A	; 0232A654
	mov r0,#0x0	; 0232A656
	bx lr	; 0232A658
loc_0232A65A:
	ldr r2,[r3,#0x0]	; 0232A65A
	cmp r0,r2	; 0232A65C
	bcc loc_0232A664	; 0232A65E
	mov r0,#0x0	; 0232A660
	bx lr	; 0232A662
loc_0232A664:
	lsl r0,r0,#0x2	; 0232A664
	add r0,r3,r0	; 0232A666
	ldr r2,[r0,#0x4]	; 0232A668
	add r1,#0x84	; 0232A66A
	ldr r0,[r1,#0x0]	; 0232A66C
	cmp r2,#0x0	; 0232A66E
	bne loc_0232A676	; 0232A670
	mov r0,#0x0	; 0232A672
	bx lr	; 0232A674
loc_0232A676:
	add r0,r0,r2	; 0232A676
	bx lr	; 0232A678
	.byte 0xC0, 0x46	; 0232A67C
pool_0232A67C:
loc_0232A67C:
	.word P1_BssStart + 0x2630C	; 0232A67C

; ===== function loc_0232A680 =====
loc_0232A680:
	ldr r0,[pool_0232A688]	; 0232A680
	ldr r0,[r0,#0x0]	; 0232A682
	bx lr	; 0232A684
	.byte 0xC0, 0x46	; 0232A688
pool_0232A688:
loc_0232A688:
	.word P1_BssStart + 0x2630C	; 0232A688

; ===== function loc_0232A68C =====
loc_0232A68C:
	push {r4,r5,r6,r7,lr}	; 0232A68C
	sub sp,#0x4	; 0232A68E
	add r5,r0,#0x0	; 0232A690
	add r4,r1,#0x0	; 0232A692
	add r0,r4,#0x0	; 0232A694
	add r1,r5,#0x0	; 0232A696
	mov r2,#0x30	; 0232A698
	blx loc_0232E32C	; 0232A69A
	ldr r0,[r5,#0x18]	; 0232A69E
	cmp r0,#0x0	; 0232A6A0
	bne loc_0232A6A8	; 0232A6A2
	mov r1,#0x0	; 0232A6A4
	b loc_0232A6AA	; 0232A6A6
loc_0232A6A8:
	add r1,r4,r0	; 0232A6A8
loc_0232A6AA:
	add r0,r5,#0x0	; 0232A6AA
	add r0,#0x84	; 0232A6AC
	str r1,[r0,#0x0]	; 0232A6AE
	ldr r0,[r5,#0x20]	; 0232A6B0
	cmp r0,#0x0	; 0232A6B2
	bne loc_0232A6BA	; 0232A6B4
	mov r0,#0x0	; 0232A6B6
	b loc_0232A6BC	; 0232A6B8
loc_0232A6BA:
	add r0,r4,r0	; 0232A6BA
loc_0232A6BC:
	str r0,[r5,#0x7c]	; 0232A6BC
	ldr r0,[r5,#0x10]	; 0232A6BE
	cmp r0,#0x0	; 0232A6C0
	bne loc_0232A6C8	; 0232A6C2
	mov r1,#0x0	; 0232A6C4
	b loc_0232A6CA	; 0232A6C6
loc_0232A6C8:
	add r1,r4,r0	; 0232A6C8
loc_0232A6CA:
	add r0,r5,#0x0	; 0232A6CA
	add r0,#0x80	; 0232A6CC
	str r1,[r0,#0x0]	; 0232A6CE
	mov r0,#0x0	; 0232A6D0
	ldr r3,[r5,#0x7c]	; 0232A6D2
	ldr r1,[r3,#0x8]	; 0232A6D4
	cmp r1,#0x0	; 0232A6D6
	bls loc_0232A6FC	; 0232A6D8
	add r6,r0,#0x0	; 0232A6DA
	add r2,r0,#0x0	; 0232A6DC
loc_0232A6DE:
	add r3,#0xc	; 0232A6DE
	add r7,r3,r6	; 0232A6E0
	ldr r1,[r3,r6]	; 0232A6E2
	cmp r1,#0x0	; 0232A6E4
	bne loc_0232A6EC	; 0232A6E6
	add r1,r2,#0x0	; 0232A6E8
	b loc_0232A6EE	; 0232A6EA
loc_0232A6EC:
	add r1,r4,r1	; 0232A6EC
loc_0232A6EE:
	str r1,[r7,#0x8]	; 0232A6EE
	add r6,#0x10	; 0232A6F0
	add r0,r0,#0x1	; 0232A6F2
	ldr r3,[r5,#0x7c]	; 0232A6F4
	ldr r1,[r3,#0x8]	; 0232A6F6
	cmp r0,r1	; 0232A6F8
	bcc loc_0232A6DE	; 0232A6FA
loc_0232A6FC:
	ldr r0,[pool_0232A708]	; 0232A6FC
	str r5,[r0,#0x0]	; 0232A6FE
	add sp,#0x4	; 0232A700
	pop {r4,r5,r6,r7}	; 0232A702
	pop {r3}	; 0232A704
	bx r3	; 0232A706
pool_0232A708:
loc_0232A708:
	.word P1_BssStart + 0x2630C	; 0232A708

; ===== function loc_0232A70C =====
loc_0232A70C:
	push {r4,lr}	; 0232A70C
	bl loc_0232E7E4	; 0232A70E
	add r4,r0,#0x0	; 0232A712
	mov r0,#0x1	; 0232A714
	bl loc_0232E850	; 0232A716
	add r0,r4,#0x0	; 0232A71A
	bl loc_0232E804	; 0232A71C
	pop {r4}	; 0232A720
	pop {r3}	; 0232A722
	bx r3	; 0232A724
	.byte 0x00, 0x00	; 0232A728

; ===== function loc_0232A728 =====
loc_0232A728:
	push {r4,r5,lr}	; 0232A728
	sub sp,#0x4	; 0232A72A
	add r5,r0,#0x0	; 0232A72C
	ldr r0,[r5,#0x0]	; 0232A72E
	mov r1,#0x14	; 0232A730
	mov r2,#0x4	; 0232A732
	bl loc_023297B0	; 0232A734
	add r4,r0,#0x0	; 0232A738
	cmp r4,#0x0	; 0232A73A
	bne loc_0232A748	; 0232A73C
	mov r0,#0x0	; 0232A73E
	add sp,#0x4	; 0232A740
	pop {r4,r5}	; 0232A742
	pop {r3}	; 0232A744
	bx r3	; 0232A746
loc_0232A748:
	bl loc_0232A790	; 0232A748
	add r0,r5,#0x4	; 0232A74C
	add r1,r4,#0x0	; 0232A74E
	bl loc_02329234	; 0232A750
	mov r0,#0x1	; 0232A754
	add sp,#0x4	; 0232A756
	pop {r4,r5}	; 0232A758
	pop {r3}	; 0232A75A
	bx r3	; 0232A75C
	.byte 0x00, 0x00	; 0232A760

; ===== function loc_0232A760 =====
loc_0232A760:
	push {r4,r5,lr}	; 0232A760
	sub sp,#0x4	; 0232A762
	add r5,r0,#0x0	; 0232A764
	add r4,r1,#0x0	; 0232A766
	add r0,r5,#0x4	; 0232A768
	mov r1,#0xc	; 0232A76A
	bl loc_0232928C	; 0232A76C
	str r4,[r5,#0x0]	; 0232A770
	add r0,r5,#0x0	; 0232A772
	bl loc_0232A728	; 0232A774
	cmp r0,#0x0	; 0232A778
	beq loc_0232A786	; 0232A77A
	mov r0,#0x1	; 0232A77C
	add sp,#0x4	; 0232A77E
	pop {r4,r5}	; 0232A780
	pop {r3}	; 0232A782
	bx r3	; 0232A784
loc_0232A786:
	mov r0,#0x0	; 0232A786
	add sp,#0x4	; 0232A788
	pop {r4,r5}	; 0232A78A
	pop {r3}	; 0232A78C
	bx r3	; 0232A78E

; ===== function loc_0232A790 =====
loc_0232A790:
	mov r1,#0x0	; 0232A790
	ldr r3,[pool_0232A798]	; 0232A792
	bx r3	; 0232A794
	.byte 0xC0, 0x46	; 0232A798
pool_0232A798:
loc_0232A798:
	.word loc_0232928C + 1	; 0232A798

; ===== function loc_0232A79C =====
loc_0232A79C:
	push {r4,r5,r6,r7,lr}	; 0232A79C
	sub sp,#0x4	; 0232A79E
	add r5,r0,#0x0	; 0232A7A0
	add r6,r1,#0x0	; 0232A7A2
	add r7,r2,#0x0	; 0232A7A4
	str r3,[sp,#0x0]	; 0232A7A6
	ldr r0,[r5,#0x0]	; 0232A7A8
	add r1,#0x1f	; 0232A7AA
	mov r2,#0x1f	; 0232A7AC
	bic r1,r2	; 0232A7AE
	add r1,#0x20	; 0232A7B0
	mov r2,#0x20	; 0232A7B2
	bl loc_023297B0	; 0232A7B4
	add r4,r0,#0x0	; 0232A7B8
	cmp r4,#0x0	; 0232A7BA
	bne loc_0232A7C8	; 0232A7BC
	mov r0,#0x0	; 0232A7BE
	add sp,#0x4	; 0232A7C0
	pop {r4,r5,r6,r7}	; 0232A7C2
	pop {r3}	; 0232A7C4
	bx r3	; 0232A7C6
loc_0232A7C8:
	add r0,r5,#0x4	; 0232A7C8
	mov r1,#0x0	; 0232A7CA
	bl loc_02329154	; 0232A7CC
	str r6,[r4,#0x8]	; 0232A7D0
	str r7,[r4,#0xc]	; 0232A7D2
	ldr r1,[sp,#0x0]	; 0232A7D4
	str r1,[r4,#0x10]	; 0232A7D6
	ldr r1,[sp,#0x18]	; 0232A7D8
	str r1,[r4,#0x14]	; 0232A7DA
	add r1,r4,#0x0	; 0232A7DC
	bl loc_02329234	; 0232A7DE
	add r4,#0x20	; 0232A7E2
	add r0,r4,#0x0	; 0232A7E4
	add sp,#0x4	; 0232A7E6
	pop {r4,r5,r6,r7}	; 0232A7E8
	pop {r3}	; 0232A7EA
	bx r3	; 0232A7EC
	.byte 0x00, 0x00	; 0232A7F0

; ===== function loc_0232A7F0 =====
loc_0232A7F0:
	push {r4,r5,r6,r7,lr}	; 0232A7F0
	sub sp,#0x4	; 0232A7F2
	add r7,r0,#0x0	; 0232A7F4
	add r0,r7,#0x4	; 0232A7F6
	mov r1,#0x0	; 0232A7F8
	bl loc_02329154	; 0232A7FA
	add r5,r0,#0x0	; 0232A7FE
	cmp r5,#0x0	; 0232A800
	beq loc_0232A848	; 0232A802
loc_0232A804:
	add r0,r5,#0x0	; 0232A804
	mov r1,#0x0	; 0232A806
	bl loc_02329154	; 0232A808
	add r4,r0,#0x0	; 0232A80C
	cmp r4,#0x0	; 0232A80E
	beq loc_0232A832	; 0232A810
loc_0232A812:
	ldr r6,[r4,#0xc]	; 0232A812
	cmp r6,#0x0	; 0232A814
	beq loc_0232A824	; 0232A816
	add r0,r4,#0x0	; 0232A818
	add r0,#0x20	; 0232A81A
	ldr r1,[r4,#0x8]	; 0232A81C
	ldr r2,[r4,#0x10]	; 0232A81E
	ldr r3,[r4,#0x14]	; 0232A820
	blx r6	; 0232A822
loc_0232A824:
	add r0,r5,#0x0	; 0232A824
	add r1,r4,#0x0	; 0232A826
	bl loc_02329154	; 0232A828
	add r4,r0,#0x0	; 0232A82C
	cmp r4,#0x0	; 0232A82E
	bne loc_0232A812	; 0232A830
loc_0232A832:
	add r0,r7,#0x4	; 0232A832
	add r1,r5,#0x0	; 0232A834
	bl loc_02329174	; 0232A836
	add r0,r7,#0x4	; 0232A83A
	mov r1,#0x0	; 0232A83C
	bl loc_02329154	; 0232A83E
	add r5,r0,#0x0	; 0232A842
	cmp r5,#0x0	; 0232A844
	bne loc_0232A804	; 0232A846
loc_0232A848:
	ldr r0,[r7,#0x0]	; 0232A848
	mov r1,#0x3	; 0232A84A
	bl loc_02329784	; 0232A84C
	bl loc_0232A70C	; 0232A850
	add r0,r7,#0x0	; 0232A854
	bl loc_0232A728	; 0232A856
	add sp,#0x4	; 0232A85A
	pop {r4,r5,r6,r7}	; 0232A85C
	pop {r3}	; 0232A85E
	bx r3	; 0232A860
	.byte 0x00, 0x00	; 0232A864

; ===== function loc_0232A864 =====
loc_0232A864:
	push {r4,lr}	; 0232A864
	add r4,r0,#0x0	; 0232A866
	bl loc_0232A7F0	; 0232A868
	ldr r0,[r4,#0x0]	; 0232A86C
	bl loc_023297DC	; 0232A86E
	pop {r4}	; 0232A872
	pop {r3}	; 0232A874
	bx r3	; 0232A876

; ===== function loc_0232A878 =====
loc_0232A878:
	push {r4,r5,lr}	; 0232A878
	sub sp,#0x4	; 0232A87A
	add r1,r0,r1	; 0232A87C
	add r4,r0,#0x3	; 0232A87E
	mov r0,#0x3	; 0232A880
	bic r4,r0	; 0232A882
	cmp r4,r1	; 0232A884
	bls loc_0232A892	; 0232A886
	mov r0,#0x0	; 0232A888
	add sp,#0x4	; 0232A88A
	pop {r4,r5}	; 0232A88C
	pop {r3}	; 0232A88E
	bx r3	; 0232A890
loc_0232A892:
	sub r1,r1,r4	; 0232A892
	cmp r1,#0x10	; 0232A894
	bcs loc_0232A8A2	; 0232A896
	mov r0,#0x0	; 0232A898
	add sp,#0x4	; 0232A89A
	pop {r4,r5}	; 0232A89C
	pop {r3}	; 0232A89E
	bx r3	; 0232A8A0
loc_0232A8A2:
	add r0,r4,#0x0	; 0232A8A2
	add r0,#0x10	; 0232A8A4
	sub r1,#0x10	; 0232A8A6
	mov r2,#0x0	; 0232A8A8
	bl loc_023297E4	; 0232A8AA
	add r5,r0,#0x0	; 0232A8AE
	cmp r5,#0x0	; 0232A8B0
	bne loc_0232A8BE	; 0232A8B2
	mov r0,#0x0	; 0232A8B4
	add sp,#0x4	; 0232A8B6
	pop {r4,r5}	; 0232A8B8
	pop {r3}	; 0232A8BA
	bx r3	; 0232A8BC
loc_0232A8BE:
	add r0,r4,#0x0	; 0232A8BE
	add r1,r5,#0x0	; 0232A8C0
	bl loc_0232A760	; 0232A8C2
	cmp r0,#0x0	; 0232A8C6
	bne loc_0232A8DA	; 0232A8C8
	add r0,r5,#0x0	; 0232A8CA
	bl loc_023297DC	; 0232A8CC
	mov r0,#0x0	; 0232A8D0
	add sp,#0x4	; 0232A8D2
	pop {r4,r5}	; 0232A8D4
	pop {r3}	; 0232A8D6
	bx r3	; 0232A8D8
loc_0232A8DA:
	add r0,r4,#0x0	; 0232A8DA
	add sp,#0x4	; 0232A8DC
	pop {r4,r5}	; 0232A8DE
	pop {r3}	; 0232A8E0
	bx r3	; 0232A8E2

; ===== function loc_0232A8E4 =====
loc_0232A8E4:
	push {r4,r5,r6,r7,lr}	; 0232A8E4
	sub sp,#0xc	; 0232A8E6
	str r0,[sp,#0x0]	; 0232A8E8
	add r5,r1,#0x0	; 0232A8EA
	add r6,r3,#0x0	; 0232A8EC
	ldr r7,[sp,#0x20]	; 0232A8EE
	add r0,r2,#0x0	; 0232A8F0
	bl loc_0232A5E8	; 0232A8F2
	add r4,r0,#0x0	; 0232A8F6
	cmp r4,#0x0	; 0232A8F8
	bne loc_0232A906	; 0232A8FA
	mov r0,#0x0	; 0232A8FC
	add sp,#0xc	; 0232A8FE
	pop {r4,r5,r6,r7}	; 0232A900
	pop {r3}	; 0232A902
	bx r3	; 0232A904
loc_0232A906:
	ldr r0,[sp,#0x0]	; 0232A906
	add r1,r5,#0x0	; 0232A908
	add r2,r6,#0x0	; 0232A90A
	bl loc_02329D04	; 0232A90C
	str r0,[sp,#0x4]	; 0232A910
	cmp r0,#0x0	; 0232A912
	bne loc_0232A920	; 0232A914
	mov r0,#0x0	; 0232A916
	add sp,#0xc	; 0232A918
	pop {r4,r5,r6,r7}	; 0232A91A
	pop {r3}	; 0232A91C
	bx r3	; 0232A91E
loc_0232A920:
	ldr r0,[r4,#0x0]	; 0232A920
	bl loc_0232A534	; 0232A922
	add r6,r0,#0x0	; 0232A926
	cmp r6,#0x0	; 0232A928
	bne loc_0232A93C	; 0232A92A
	ldr r0,[sp,#0x4]	; 0232A92C
	bl loc_02329CFC	; 0232A92E
	mov r0,#0x0	; 0232A932
	add sp,#0xc	; 0232A934
	pop {r4,r5,r6,r7}	; 0232A936
	pop {r3}	; 0232A938
	bx r3	; 0232A93A
loc_0232A93C:
	mov r5,#0x0	; 0232A93C
loc_0232A93E:
	ldrh r0,[r4,#0x4]	; 0232A93E
	ldr r1,[pool_0232A9C0]	; 0232A940
	cmp r0,r1	; 0232A942
	beq loc_0232A982	; 0232A944
	bl loc_0232A59C	; 0232A946
	cmp r0,#0x0	; 0232A94A
	bne loc_0232A95E	; 0232A94C
	ldr r0,[sp,#0x4]	; 0232A94E
	bl loc_02329CFC	; 0232A950
	mov r0,#0x0	; 0232A954
	add sp,#0xc	; 0232A956
	pop {r4,r5,r6,r7}	; 0232A958
	pop {r3}	; 0232A95A
	bx r3	; 0232A95C
loc_0232A95E:
	ldr r0,[r0,#0x0]	; 0232A95E
	bl loc_0232A534	; 0232A960
	add r2,r0,#0x0	; 0232A964
	cmp r2,#0x0	; 0232A966
	bne loc_0232A97A	; 0232A968
	ldr r0,[sp,#0x4]	; 0232A96A
	bl loc_02329CFC	; 0232A96C
	mov r0,#0x0	; 0232A970
	add sp,#0xc	; 0232A972
	pop {r4,r5,r6,r7}	; 0232A974
	pop {r3}	; 0232A976
	bx r3	; 0232A978
loc_0232A97A:
	add r0,r6,#0x0	; 0232A97A
	add r1,r5,#0x0	; 0232A97C
	bl loc_0232EC34	; 0232A97E
loc_0232A982:
	add r4,r4,#0x2	; 0232A982
	add r5,r5,#0x1	; 0232A984
	cmp r5,#0x4	; 0232A986
	blt loc_0232A93E	; 0232A988
	ldr r0,[sp,#0x4]	; 0232A98A
	ldr r2,[sp,#0x24]	; 0232A98C
	ldr r1,[r2,#0x18]	; 0232A98E
	add r1,r2,r1	; 0232A990
	ldr r2,[r7,#0x0]	; 0232A992
	add r3,r6,#0x0	; 0232A994
	bl loc_02329CD8	; 0232A996
	ldr r0,[sp,#0x0]	; 0232A99A
	ldrb r1,[r7,#0x6]	; 0232A99C
	bl loc_02329E04	; 0232A99E
	ldr r0,[sp,#0x0]	; 0232A9A2
	ldrb r1,[r7,#0x7]	; 0232A9A4
	bl loc_02329DC8	; 0232A9A6
	ldr r0,[sp,#0x0]	; 0232A9AA
	ldr r1,[sp,#0x28]	; 0232A9AC
	ldr r2,[sp,#0x2c]	; 0232A9AE
	bl loc_02329D7C	; 0232A9B0
	mov r0,#0x1	; 0232A9B4
	add sp,#0xc	; 0232A9B6
	pop {r4,r5,r6,r7}	; 0232A9B8
	pop {r3}	; 0232A9BA
	bx r3	; 0232A9BC
	.byte 0xC0, 0x46	; 0232A9C0
pool_0232A9C0:
loc_0232A9C0:
	.word 0x0000FFFF	; 0232A9C0

; ===== function loc_0232A9C4 =====
	push {r4,r5,r6,r7,lr}	; 0232A9C4
	sub sp,#0x14	; 0232A9C6
	str r0,[sp,#0x10]	; 0232A9C8
	add r5,r1,#0x0	; 0232A9CA
	add r4,r2,#0x0	; 0232A9CC
	add r6,r3,#0x0	; 0232A9CE
	ldr r0,[sp,#0x28]	; 0232A9D0
	bl loc_0232A634	; 0232A9D2
	cmp r0,#0x0	; 0232A9D6
	bne loc_0232A9E4	; 0232A9D8
	mov r0,#0x0	; 0232A9DA
	add sp,#0x14	; 0232A9DC
	pop {r4,r5,r6,r7}	; 0232A9DE
	pop {r3}	; 0232A9E0
	bx r3	; 0232A9E2
loc_0232A9E4:
	ldr r0,[r0,#0x0]	; 0232A9E4
	bl loc_0232A534	; 0232A9E6
	add r7,r0,#0x0	; 0232A9EA
	cmp r7,#0x0	; 0232A9EC
	bne loc_0232A9FA	; 0232A9EE
	mov r0,#0x0	; 0232A9F0
	add sp,#0x14	; 0232A9F2
	pop {r4,r5,r6,r7}	; 0232A9F4
	pop {r3}	; 0232A9F6
	bx r3	; 0232A9F8
loc_0232A9FA:
	ldr r1,[sp,#0x2c]	; 0232A9FA
	bl loc_0232AB0C	; 0232A9FC
	cmp r0,#0x0	; 0232AA00
	bne loc_0232AA0E	; 0232AA02
	mov r0,#0x0	; 0232AA04
	add sp,#0x14	; 0232AA06
	pop {r4,r5,r6,r7}	; 0232AA08
	pop {r3}	; 0232AA0A
	bx r3	; 0232AA0C
loc_0232AA0E:
	cmp r6,#0x0	; 0232AA0E
	bge loc_0232AA14	; 0232AA10
	ldrb r6,[r0,#0x8]	; 0232AA12
loc_0232AA14:
	cmp r4,#0x0	; 0232AA14
	bge loc_0232AA1A	; 0232AA16
	ldrh r4,[r0,#0x4]	; 0232AA18
loc_0232AA1A:
	cmp r5,#0x0	; 0232AA1A
	bge loc_0232AA20	; 0232AA1C
	ldrb r5,[r0,#0x9]	; 0232AA1E
loc_0232AA20:
	str r0,[sp,#0x0]	; 0232AA20
	str r7,[sp,#0x4]	; 0232AA22
	ldr r0,[sp,#0x28]	; 0232AA24
	str r0,[sp,#0x8]	; 0232AA26
	ldr r0,[sp,#0x2c]	; 0232AA28
	str r0,[sp,#0xc]	; 0232AA2A
	ldr r0,[sp,#0x10]	; 0232AA2C
	add r1,r5,#0x0	; 0232AA2E
	add r2,r4,#0x0	; 0232AA30
	add r3,r6,#0x0	; 0232AA32
	bl loc_0232A8E4	; 0232AA34
	add sp,#0x14	; 0232AA38
	pop {r4,r5,r6,r7}	; 0232AA3A
	pop {r3}	; 0232AA3C
	bx r3	; 0232AA3E
loc_0232AA40:
	push {r4,r5,r6,r7,lr}	; 0232AA40
	sub sp,#0x14	; 0232AA42
	add r7,r0,#0x0	; 0232AA44
	add r5,r1,#0x0	; 0232AA46
	add r4,r2,#0x0	; 0232AA48
	add r0,r5,#0x0	; 0232AA4A
	bl loc_0232A634	; 0232AA4C
	cmp r0,#0x0	; 0232AA50
	bne loc_0232AA5E	; 0232AA52
	mov r0,#0x0	; 0232AA54
	add sp,#0x14	; 0232AA56
	pop {r4,r5,r6,r7}	; 0232AA58
	pop {r3}	; 0232AA5A
	bx r3	; 0232AA5C
loc_0232AA5E:
	ldr r0,[r0,#0x0]	; 0232AA5E
	bl loc_0232A534	; 0232AA60
	add r6,r0,#0x0	; 0232AA64
	cmp r6,#0x0	; 0232AA66
	bne loc_0232AA74	; 0232AA68
	mov r0,#0x0	; 0232AA6A
	add sp,#0x14	; 0232AA6C
	pop {r4,r5,r6,r7}	; 0232AA6E
	pop {r3}	; 0232AA70
	bx r3	; 0232AA72
loc_0232AA74:
	add r1,r4,#0x0	; 0232AA74
	bl loc_0232AB0C	; 0232AA76
	add r3,r0,#0x0	; 0232AA7A
	cmp r3,#0x0	; 0232AA7C
	bne loc_0232AA8A	; 0232AA7E
	mov r0,#0x0	; 0232AA80
	add sp,#0x14	; 0232AA82
	pop {r4,r5,r6,r7}	; 0232AA84
	pop {r3}	; 0232AA86
	bx r3	; 0232AA88
loc_0232AA8A:
	str r3,[sp,#0x0]	; 0232AA8A
	str r6,[sp,#0x4]	; 0232AA8C
	str r5,[sp,#0x8]	; 0232AA8E
	str r4,[sp,#0xc]	; 0232AA90
	add r0,r7,#0x0	; 0232AA92
	ldrb r1,[r3,#0x9]	; 0232AA94
	ldrh r2,[r3,#0x4]	; 0232AA96
	ldrb r3,[r3,#0x8]	; 0232AA98
	bl loc_0232A8E4	; 0232AA9A
	add sp,#0x14	; 0232AA9E
	pop {r4,r5,r6,r7}	; 0232AAA0
	pop {r3}	; 0232AAA2
	bx r3	; 0232AAA4
	.byte 0x00, 0x00	; 0232AAA8

; ===== function loc_0232AAA8 =====
loc_0232AAA8:
	push {r4,r5,r6,r7,lr}	; 0232AAA8
	sub sp,#0x4	; 0232AAAA
	add r7,r0,#0x0	; 0232AAAC
	bl loc_0232A680	; 0232AAAE
	mov r6,#0x0	; 0232AAB2
	str r6,[sp,#0x0]	; 0232AAB4
loc_0232AAB6:
	add r0,r6,#0x0	; 0232AAB6
	bl loc_0232A550	; 0232AAB8
	add r5,r0,#0x0	; 0232AABC
	cmp r5,#0x0	; 0232AABE
	beq loc_0232AAFC	; 0232AAC0
	add r0,r6,#0x0	; 0232AAC2
	ldrb r1,[r5,#0x0]	; 0232AAC4
	bl loc_02329EB0	; 0232AAC6
	ldr r0,[r5,#0x4]	; 0232AACA
	cmp r0,#0x0	; 0232AACC
	beq loc_0232AAFC	; 0232AACE
	cmp r7,#0x0	; 0232AAD0
	beq loc_0232AAFC	; 0232AAD2
	ldr r4,[sp,#0x0]	; 0232AAD4
	ldrb r0,[r5,#0x0]	; 0232AAD6
	cmp r0,#0x0	; 0232AAD8
	ble loc_0232AAFC	; 0232AADA
loc_0232AADC:
	add r0,r6,#0x0	; 0232AADC
	add r1,r7,#0x0	; 0232AADE
	ldr r2,[r5,#0x4]	; 0232AAE0
	bl loc_02329E44	; 0232AAE2
	cmp r0,#0x0	; 0232AAE6
	bne loc_0232AAF4	; 0232AAE8
	mov r0,#0x0	; 0232AAEA
	add sp,#0x4	; 0232AAEC
	pop {r4,r5,r6,r7}	; 0232AAEE
	pop {r3}	; 0232AAF0
	bx r3	; 0232AAF2
loc_0232AAF4:
	add r4,r4,#0x1	; 0232AAF4
	ldrb r0,[r5,#0x0]	; 0232AAF6
	cmp r4,r0	; 0232AAF8
	blt loc_0232AADC	; 0232AAFA
loc_0232AAFC:
	add r6,r6,#0x1	; 0232AAFC
	cmp r6,#0x20	; 0232AAFE
	blt loc_0232AAB6	; 0232AB00
	mov r0,#0x1	; 0232AB02
	add sp,#0x4	; 0232AB04
	pop {r4,r5,r6,r7}	; 0232AB06
	pop {r3}	; 0232AB08
	bx r3	; 0232AB0A

; ===== function loc_0232AB0C =====
loc_0232AB0C:
	cmp r1,#0x0	; 0232AB0C
	bge loc_0232AB14	; 0232AB0E
	mov r0,#0x0	; 0232AB10
	bx lr	; 0232AB12
loc_0232AB14:
	ldr r2,[r0,#0x1c]	; 0232AB14
	cmp r1,r2	; 0232AB16
	bcc loc_0232AB1E	; 0232AB18
	mov r0,#0x0	; 0232AB1A
	bx lr	; 0232AB1C
loc_0232AB1E:
	add r0,#0x20	; 0232AB1E
	mov r2,#0xc	; 0232AB20
	mul r1,r2	; 0232AB22
	add r3,r0,r1	; 0232AB24
	ldr r2,[r0,r1]	; 0232AB26
	mov r0,#0x0	; 0232AB28
	mvn r1,r0	; 0232AB2A
	cmp r2,r1	; 0232AB2C
	bne loc_0232AB32	; 0232AB2E
	add r3,r0,#0x0	; 0232AB30
loc_0232AB32:
	add r0,r3,#0x0	; 0232AB32
	bx lr	; 0232AB34
	.byte 0x00, 0x00	; 0232AB38

; ===== function loc_0232AB38 =====
loc_0232AB38:
	ldr r1,[r0,#0x8]	; 0232AB38
	ldr r0,[r0,#0xc]	; 0232AB3A
	cmp r1,r0	; 0232AB3C
	blt loc_0232AB44	; 0232AB3E
	mov r0,#0x1	; 0232AB40
	bx lr	; 0232AB42
loc_0232AB44:
	mov r0,#0x0	; 0232AB44
	bx lr	; 0232AB46

; ===== function loc_0232AB48 =====
loc_0232AB48:
	ldr r2,[r0,#0x8]	; 0232AB48
	ldr r1,[r0,#0xc]	; 0232AB4A
	cmp r2,r1	; 0232AB4C
	bge loc_0232AB58	; 0232AB4E
	add r0,#0x8	; 0232AB50
	ldr r1,[r0,#0x0]	; 0232AB52
	add r1,r1,#0x1	; 0232AB54
	str r1,[r0,#0x0]	; 0232AB56
loc_0232AB58:
	bx lr	; 0232AB58
	.byte 0x00, 0x00	; 0232AB5C

; ===== function loc_0232AB5C =====
loc_0232AB5C:
	push {r4,lr}	; 0232AB5C
	ldr r1,[r0,#0xc]	; 0232AB5E
	ldr r2,[r0,#0x8]	; 0232AB60
	cmp r2,r1	; 0232AB62
	blt loc_0232AB6E	; 0232AB64
	ldr r0,[r0,#0x4]	; 0232AB66
	pop {r4}	; 0232AB68
	pop {r3}	; 0232AB6A
	bx r3	; 0232AB6C
loc_0232AB6E:
	ldr r4,[r0,#0x0]	; 0232AB6E
	ldr r0,[r0,#0x4]	; 0232AB70
	sub r0,r0,r4	; 0232AB72
	mul r2,r0	; 0232AB74
	add r0,r2,#0x0	; 0232AB76
	blx P1_SignedDivMod	; 0232AB78
	add r0,r4,r0	; 0232AB7C
	pop {r4}	; 0232AB7E
	pop {r3}	; 0232AB80
	bx r3	; 0232AB82

; ===== function loc_0232AB84 =====
loc_0232AB84:
	push {r4,r5,r6,lr}	; 0232AB84
	add r5,r0,#0x0	; 0232AB86
	add r4,r1,#0x0	; 0232AB88
	add r6,r2,#0x0	; 0232AB8A
	bl loc_0232AB5C	; 0232AB8C
	str r0,[r5,#0x0]	; 0232AB90
	str r4,[r5,#0x4]	; 0232AB92
	str r6,[r5,#0xc]	; 0232AB94
	mov r0,#0x0	; 0232AB96
	str r0,[r5,#0x8]	; 0232AB98
	pop {r4,r5,r6}	; 0232AB9A
	pop {r3}	; 0232AB9C
	bx r3	; 0232AB9E

; ===== function loc_0232ABA0 =====
loc_0232ABA0:
	mov r2,#0x0	; 0232ABA0
	str r2,[r0,#0x4]	; 0232ABA2
	ldr r1,[r0,#0x4]	; 0232ABA4
	str r1,[r0,#0x0]	; 0232ABA6
	str r2,[r0,#0xc]	; 0232ABA8
	ldr r1,[r0,#0xc]	; 0232ABAA
	str r1,[r0,#0x8]	; 0232ABAC
	bx lr	; 0232ABAE
.arm

; ===== function loc_0232ABB0 =====
loc_0232ABB0:
	stmdb sp!,{r4,r5,r6,lr}	; 0232ABB0
	mov r5,r0	; 0232ABB4
	mov r4,r1	; 0232ABB8
	bl P1_Arm9DisableIrqReturnPriorMask	; 0232ABBC
	cmp r5,#0x0	; 0232ABC0
	beq loc_0232ABE0	; 0232ABC4
	ldr r3,[pool_0232AC24]	; 0232ABC8
	ldr r1,[pool_0232AC28]	; 0232ABCC
	mvn r2,r4	; 0232ABD0
	ldr r1,[r3,r1]!	; 0232ABD4
	and r1,r1,r2	; 0232ABD8
	str r1,[r3,#0x0]	; 0232ABDC
loc_0232ABE0:
	bl P1_Arm9RestoreIrqMask	; 0232ABE0
	ldr r1,[pool_0232AC24]	; 0232ABE4
	add r0,r1,#0x3000	; 0232ABE8
	ldr r0,[r0,#0xff8]	; 0232ABEC
	ands r0,r4,r0	; 0232ABF0
	ldmneia sp!,{r4,r5,r6,lr}	; 0232ABF4
	bxne lr	; 0232ABF8
	ldr r0,[pool_0232AC28]	; 0232ABFC
	add r6,r1,r0	; 0232AC00
	ldr r5,[pool_0232AC2C]	; 0232AC04
loc_0232AC08:
	mov r0,r5	; 0232AC08
	blx loc_0232B270	; 0232AC0C
	ldr r0,[r6,#0x0]	; 0232AC10
	ands r0,r4,r0	; 0232AC14
	beq loc_0232AC08	; 0232AC18
	ldmia sp!,{r4,r5,r6,lr}	; 0232AC1C
	bx lr	; 0232AC20
pool_0232AC24:
loc_0232AC24:
	.word P1_DtcmRuntimeStart	; 0232AC24
pool_0232AC28:
loc_0232AC28:
	.word 0x00003FF8	; 0232AC28
pool_0232AC2C:
loc_0232AC2C:
	.word P1_DtcmRuntimeStart	; 0232AC2C
.thumb
P1_IrqHandler_0232AC30:
	mov r0,#0x7	; 0232AC30
	ldr r3,[pool_0232AC38]	; 0232AC32
	bx r3	; 0232AC34
	.byte 0xC0, 0x46	; 0232AC38
pool_0232AC38:
loc_0232AC38:
	.word loc_0232AC90 + 1	; 0232AC38
P1_IrqHandler_0232AC3C:
	mov r0,#0x6	; 0232AC3C
	ldr r3,[pool_0232AC44]	; 0232AC3E
	bx r3	; 0232AC40
	.byte 0xC0, 0x46	; 0232AC44
pool_0232AC44:
loc_0232AC44:
	.word loc_0232AC90 + 1	; 0232AC44
P1_IrqHandler_0232AC48:
	mov r0,#0x5	; 0232AC48
	ldr r3,[pool_0232AC50]	; 0232AC4A
	bx r3	; 0232AC4C
	.byte 0xC0, 0x46	; 0232AC50
pool_0232AC50:
loc_0232AC50:
	.word loc_0232AC90 + 1	; 0232AC50
P1_IrqHandler_0232AC54:
	mov r0,#0x4	; 0232AC54
	ldr r3,[pool_0232AC5C]	; 0232AC56
	bx r3	; 0232AC58
	.byte 0xC0, 0x46	; 0232AC5C
pool_0232AC5C:
loc_0232AC5C:
	.word loc_0232AC90 + 1	; 0232AC5C
P1_IrqHandler_0232AC60:
	mov r0,#0x3	; 0232AC60
	ldr r3,[pool_0232AC68]	; 0232AC62
	bx r3	; 0232AC64
	.byte 0xC0, 0x46	; 0232AC68
pool_0232AC68:
loc_0232AC68:
	.word loc_0232AC90 + 1	; 0232AC68
P1_IrqHandler_0232AC6C:
	mov r0,#0x2	; 0232AC6C
	ldr r3,[pool_0232AC74]	; 0232AC6E
	bx r3	; 0232AC70
	.byte 0xC0, 0x46	; 0232AC74
pool_0232AC74:
loc_0232AC74:
	.word loc_0232AC90 + 1	; 0232AC74
P1_IrqHandler_0232AC78:
	mov r0,#0x1	; 0232AC78
	ldr r3,[pool_0232AC80]	; 0232AC7A
	bx r3	; 0232AC7C
	.byte 0xC0, 0x46	; 0232AC80
pool_0232AC80:
loc_0232AC80:
	.word loc_0232AC90 + 1	; 0232AC80
P1_IrqHandler_0232AC84:
	mov r0,#0x0	; 0232AC84
	ldr r3,[pool_0232AC8C]	; 0232AC86
	bx r3	; 0232AC88
	.byte 0xC0, 0x46	; 0232AC8C
pool_0232AC8C:
loc_0232AC8C:
	.word loc_0232AC90 + 1	; 0232AC8C
loc_0232AC90:
	push {r4,r5,lr}	; 0232AC90
	sub sp,#0x4	; 0232AC92
	mov r5,#0x1	; 0232AC94
	lsl r2,r0,#0x1	; 0232AC96
	ldr r1,[pool_0232ACD8]	; 0232AC98
	ldrh r1,[r1,r2]	; 0232AC9A
	lsl r5,r1	; 0232AC9C
	mov r1,#0xc	; 0232AC9E
	add r4,r0,#0x0	; 0232ACA0
	mul r4,r1	; 0232ACA2
	ldr r2,[pool_0232ACDC]	; 0232ACA4
	ldr r1,[r2,r4]	; 0232ACA6
	mov r0,#0x0	; 0232ACA8
	str r0,[r2,r4]	; 0232ACAA
	cmp r1,#0x0	; 0232ACAC
	beq loc_0232ACB6	; 0232ACAE
	ldr r0,[pool_0232ACE0]	; 0232ACB0
	ldr r0,[r0,r4]	; 0232ACB2
	blx r1	; 0232ACB4
loc_0232ACB6:
	ldr r1,[pool_0232ACE4]	; 0232ACB6
	ldr r0,[pool_0232ACE8]	; 0232ACB8
	add r1,r1,r0	; 0232ACBA
	ldr r0,[r1,#0x0]	; 0232ACBC
	orr r0,r5	; 0232ACBE
	str r0,[r1,#0x0]	; 0232ACC0
	ldr r0,[pool_0232ACEC]	; 0232ACC2
	ldr r0,[r0,r4]	; 0232ACC4
	cmp r0,#0x0	; 0232ACC6
	bne loc_0232ACD0	; 0232ACC8
	add r0,r5,#0x0	; 0232ACCA
	bl loc_0232AD1C	; 0232ACCC
loc_0232ACD0:
	add sp,#0x4	; 0232ACD0
	pop {r4,r5}	; 0232ACD2
	pop {r3}	; 0232ACD4
	bx r3	; 0232ACD6
pool_0232ACD8:
loc_0232ACD8:
	.word P1_Data_02330DDC	; 0232ACD8
pool_0232ACDC:
loc_0232ACDC:
	.word P1_BssStart + 0x26310	; 0232ACDC
pool_0232ACE0:
loc_0232ACE0:
	.word P1_BssStart + 0x26318	; 0232ACE0
pool_0232ACE4:
loc_0232ACE4:
	.word P1_DtcmRuntimeStart	; 0232ACE4
pool_0232ACE8:
loc_0232ACE8:
	.word 0x00003FF8	; 0232ACE8
pool_0232ACEC:
loc_0232ACEC:
	.word P1_BssStart + 0x26314	; 0232ACEC
P1_IrqHandler_0232ACF0:
	bx lr	; 0232ACF0
	.byte 0x00, 0x00	; 0232ACF4

; ===== function loc_0232ACF4 =====
loc_0232ACF4:
	push {r4}	; 0232ACF4
	sub sp,#0x4	; 0232ACF6
	ldr r4,[pool_0232AD14]	; 0232ACF8
	ldrh r3,[r4,#0x0]	; 0232ACFA
	mov r1,#0x0	; 0232ACFC
	strh r1,[r4,#0x0]	; 0232ACFE
	ldr r2,[pool_0232AD18]	; 0232AD00
	ldr r1,[r2,#0x0]	; 0232AD02
	str r0,[r2,#0x0]	; 0232AD04
	ldrh r0,[r4,#0x0]	; 0232AD06
	strh r3,[r4,#0x0]	; 0232AD08
	add r0,r1,#0x0	; 0232AD0A
	add sp,#0x4	; 0232AD0C
	pop {r4}	; 0232AD0E
	bx lr	; 0232AD10
	.byte 0xC0, 0x46	; 0232AD14
pool_0232AD14:
loc_0232AD14:
	.word REG_IME	; 0232AD14
pool_0232AD18:
loc_0232AD18:
	.word REG_IF	; 0232AD18

; ===== function loc_0232AD1C =====
loc_0232AD1C:
	push {r4,r5}	; 0232AD1C
	ldr r5,[pool_0232AD3C]	; 0232AD1E
	ldrh r4,[r5,#0x0]	; 0232AD20
	mov r1,#0x0	; 0232AD22
	strh r1,[r5,#0x0]	; 0232AD24
	ldr r3,[pool_0232AD40]	; 0232AD26
	ldr r2,[r3,#0x0]	; 0232AD28
	add r1,r2,#0x0	; 0232AD2A
	bic r1,r0	; 0232AD2C
	str r1,[r3,#0x0]	; 0232AD2E
	ldrh r0,[r5,#0x0]	; 0232AD30
	strh r4,[r5,#0x0]	; 0232AD32
	add r0,r2,#0x0	; 0232AD34
	pop {r4,r5}	; 0232AD36
	bx lr	; 0232AD38
	.byte 0xC0, 0x46	; 0232AD3C
pool_0232AD3C:
loc_0232AD3C:
	.word REG_IME	; 0232AD3C
pool_0232AD40:
loc_0232AD40:
	.word REG_IE	; 0232AD40

; ===== function loc_0232AD44 =====
loc_0232AD44:
	push {r4,r5}	; 0232AD44
	ldr r5,[pool_0232AD64]	; 0232AD46
	ldrh r4,[r5,#0x0]	; 0232AD48
	mov r1,#0x0	; 0232AD4A
	strh r1,[r5,#0x0]	; 0232AD4C
	ldr r3,[pool_0232AD68]	; 0232AD4E
	ldr r2,[r3,#0x0]	; 0232AD50
	add r1,r2,#0x0	; 0232AD52
	orr r1,r0	; 0232AD54
	str r1,[r3,#0x0]	; 0232AD56
	ldrh r0,[r5,#0x0]	; 0232AD58
	strh r4,[r5,#0x0]	; 0232AD5A
	add r0,r2,#0x0	; 0232AD5C
	pop {r4,r5}	; 0232AD5E
	bx lr	; 0232AD60
	.byte 0xC0, 0x46	; 0232AD64
pool_0232AD64:
loc_0232AD64:
	.word REG_IME	; 0232AD64
pool_0232AD68:
loc_0232AD68:
	.word REG_IE	; 0232AD68

; ===== function loc_0232AD6C =====
loc_0232AD6C:
	push {r4}	; 0232AD6C
	sub sp,#0x4	; 0232AD6E
	ldr r4,[pool_0232AD8C]	; 0232AD70
	ldrh r3,[r4,#0x0]	; 0232AD72
	mov r1,#0x0	; 0232AD74
	strh r1,[r4,#0x0]	; 0232AD76
	ldr r2,[pool_0232AD90]	; 0232AD78
	ldr r1,[r2,#0x0]	; 0232AD7A
	str r0,[r2,#0x0]	; 0232AD7C
	ldrh r0,[r4,#0x0]	; 0232AD7E
	strh r3,[r4,#0x0]	; 0232AD80
	add r0,r1,#0x0	; 0232AD82
	add sp,#0x4	; 0232AD84
	pop {r4}	; 0232AD86
	bx lr	; 0232AD88
	.byte 0xC0, 0x46	; 0232AD8C
pool_0232AD8C:
loc_0232AD8C:
	.word REG_IME	; 0232AD8C
pool_0232AD90:
loc_0232AD90:
	.word REG_IE	; 0232AD90

; ===== function loc_0232AD94 =====
loc_0232AD94:
	push {r4,lr}	; 0232AD94
	mov r3,#0xc	; 0232AD96
	add r4,r0,#0x0	; 0232AD98
	mul r4,r3	; 0232AD9A
	ldr r3,[pool_0232ADBC]	; 0232AD9C
	str r1,[r3,r4]	; 0232AD9E
	ldr r1,[pool_0232ADC0]	; 0232ADA0
	str r2,[r1,r4]	; 0232ADA2
	mov r1,#0x1	; 0232ADA4
	add r0,r0,#0x3	; 0232ADA6
	lsl r1,r0	; 0232ADA8
	add r0,r1,#0x0	; 0232ADAA
	bl loc_0232AD44	; 0232ADAC
	mov r1,#0x1	; 0232ADB0
	ldr r0,[pool_0232ADC4]	; 0232ADB2
	str r1,[r0,r4]	; 0232ADB4
	pop {r4}	; 0232ADB6
	pop {r3}	; 0232ADB8
	bx r3	; 0232ADBA
pool_0232ADBC:
loc_0232ADBC:
	.word P1_BssStart + 0x26340	; 0232ADBC
pool_0232ADC0:
loc_0232ADC0:
	.word P1_BssStart + 0x26348	; 0232ADC0
pool_0232ADC4:
loc_0232ADC4:
	.word P1_BssStart + 0x26344	; 0232ADC4

; ===== function loc_0232ADC8 =====
loc_0232ADC8:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P1_SetIrqHandlers
	push {r4,r5,r6,r7}	; 0232ADC8
	mov r6,#0x0	; 0232ADCA
	ldr r5,[pool_0232AE24]	; 0232ADCC
	add r4,r6,#0x0	; 0232ADCE
	add r2,r6,#0x0	; 0232ADD0
loc_0232ADD2:
	add r7,r0,#0x0	; 0232ADD2
	mov r3,#0x1	; 0232ADD4
	and r7,r3	; 0232ADD6
	cmp r7,#0x0	; 0232ADD8
	beq loc_0232AE16	; 0232ADDA
	add r7,r4,#0x0	; 0232ADDC
	cmp r6,#0x8	; 0232ADDE
	blt loc_0232ADF4	; 0232ADE0
	cmp r6,#0xb	; 0232ADE2
	bgt loc_0232ADF4	; 0232ADE4
	add r3,r6,#0x0	; 0232ADE6
	sub r3,#0x8	; 0232ADE8
	mov r7,#0xc	; 0232ADEA
	mul r3,r7	; 0232ADEC
	ldr r7,[pool_0232AE28]	; 0232ADEE
	add r7,r7,r3	; 0232ADF0
	b loc_0232AE0A	; 0232ADF2
loc_0232ADF4:
	cmp r6,#0x3	; 0232ADF4
	blt loc_0232AE08	; 0232ADF6
	cmp r6,#0x6	; 0232ADF8
	bgt loc_0232AE08	; 0232ADFA
	add r3,r6,#0x1	; 0232ADFC
	mov r7,#0xc	; 0232ADFE
	mul r3,r7	; 0232AE00
	ldr r7,[pool_0232AE28]	; 0232AE02
	add r7,r7,r3	; 0232AE04
	b loc_0232AE0A	; 0232AE06
loc_0232AE08:
	str r1,[r5,#0x0]	; 0232AE08
loc_0232AE0A:
	cmp r7,#0x0	; 0232AE0A
	beq loc_0232AE16	; 0232AE0C
	str r1,[r7,#0x0]	; 0232AE0E
	str r2,[r7,#0x8]	; 0232AE10
	mov r3,#0x1	; 0232AE12
	str r3,[r7,#0x4]	; 0232AE14
loc_0232AE16:
	lsr r0,r0,#0x1	; 0232AE16
	add r5,r5,#0x4	; 0232AE18
	add r6,r6,#0x1	; 0232AE1A
	cmp r6,#0x16	; 0232AE1C
	blt loc_0232ADD2	; 0232AE1E
	pop {r4,r5,r6,r7}	; 0232AE20
	bx lr	; 0232AE22
.endfunc
pool_0232AE24:
loc_0232AE24:
	.word P1_IrqHandlers	; 0232AE24
pool_0232AE28:
loc_0232AE28:
	.word 0x02357170	; 0232AE28

; ===== function loc_0232AE2C =====
loc_0232AE2C:
	mov r1,#0x0	; 0232AE2C
	ldr r0,[pool_0232AE34]	; 0232AE2E
	strh r1,[r0,#0x0]	; 0232AE30
	bx lr	; 0232AE32
pool_0232AE34:
loc_0232AE34:
	.word P1_DtcmRuntimeStart	; 0232AE34

; ===== function loc_0232AE38 =====
loc_0232AE38:
	ldr r1,[pool_0232AE3C]	; 0232AE38
	bx r1	; 0232AE3A
pool_0232AE3C:
loc_0232AE3C:
	.word loc_0232AF84 + 1	; 0232AE3C

; ===== function loc_0232AE40 =====
loc_0232AE40:
	ldr r1,[pool_0232AE44]	; 0232AE40
	bx r1	; 0232AE42
pool_0232AE44:
loc_0232AE44:
	.word loc_0232AF20 + 1	; 0232AE44
.arm

; ===== function loc_0232AE48 =====
loc_0232AE48:
	ldr r3,[pool_0232AE98]	; 0232AE48
	ldr r1,[r3,#0x0]	; 0232AE4C
	clz r2,r1	; 0232AE50
	cmp r2,#0x20	; 0232AE54
	movne r0,#0x40	; 0232AE58
	bne loc_0232AE7C	; 0232AE5C
	add r3,r3,#0x4	; 0232AE60
	ldr r1,[r3,#0x0]	; 0232AE64
	clz r2,r1	; 0232AE68
	cmp r2,#0x20	; 0232AE6C
	ldr r0,[pool_0232AE9C]	; 0232AE70
	bxeq lr	; 0232AE74
	mov r0,#0x60	; 0232AE78
loc_0232AE7C:
	add r0,r0,r2	; 0232AE7C
	mov r1,#0x80000000	; 0232AE80
	mov r1,r1, lsr r2	; 0232AE84
	ldr r2,[r3,#0x0]	; 0232AE88
	bic r2,r2,r1	; 0232AE8C
	str r2,[r3,#0x0]	; 0232AE90
	bx lr	; 0232AE94
pool_0232AE98:
loc_0232AE98:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232AE98
pool_0232AE9C:
loc_0232AE9C:
	.word 0xFFFFFFFD	; 0232AE9C

; ===== function loc_0232AEA0 =====
loc_0232AEA0:
	ldr r3,[pool_0232AECC]	; 0232AEA0
	cmp r0,#0x60	; 0232AEA4
	addpl r3,r3,#0x4	; 0232AEA8
	subpl r0,r0,#0x60	; 0232AEAC
	submi r0,r0,#0x40	; 0232AEB0
	mov r1,#0x80000000	; 0232AEB4
	mov r1,r1, lsr r0	; 0232AEB8
	ldr r2,[r3,#0x0]	; 0232AEBC
	orr r2,r2,r1	; 0232AEC0
	str r2,[r3,#0x0]	; 0232AEC4
	bx lr	; 0232AEC8
pool_0232AECC:
loc_0232AECC:
	.word 0x027FFFB0	; 0232AECC
.thumb

; ===== function loc_0232AED0 =====
loc_0232AED0:
	ldr r0,[pool_0232AED8]	; 0232AED0
	ldr r3,[pool_0232AEDC]	; 0232AED2
	bx r3	; 0232AED4
	.byte 0xC0, 0x46	; 0232AED8
pool_0232AED8:
loc_0232AED8:
	.word 0x00001000	; 0232AED8
pool_0232AEDC:
loc_0232AEDC:
	.word P1_Arm9BusyWaitByLoop4	; 0232AEDC

; ===== function loc_0232AEE0 =====
loc_0232AEE0:
	ldrh r0,[r0,#0x4]	; 0232AEE0
	bx lr	; 0232AEE2
	ldr r1,[pool_0232AEF0]	; 0232AEE4
	ldrh r2,[r1,#0x0]	; 0232AEE6
	ldr r0,[pool_0232AEF4]	; 0232AEE8
	orr r2,r0	; 0232AEEA
	strh r2,[r1,#0x0]	; 0232AEEC
	bx lr	; 0232AEEE
pool_0232AEF0:
loc_0232AEF0:
	.word REG_EXMEMCNT_ARM9	; 0232AEF0
pool_0232AEF4:
loc_0232AEF4:
	.word 0x00000800	; 0232AEF4
	ldr r1,[pool_0232AF04]	; 0232AEF8
	ldrh r2,[r1,#0x0]	; 0232AEFA
	ldr r0,[pool_0232AF08]	; 0232AEFC
	and r2,r0	; 0232AEFE
	strh r2,[r1,#0x0]	; 0232AF00
	bx lr	; 0232AF02
pool_0232AF04:
loc_0232AF04:
	.word REG_EXMEMCNT_ARM9	; 0232AF04
pool_0232AF08:
loc_0232AF08:
	.word 0xFFFFF7FF	; 0232AF08

; ===== function loc_0232AF0C =====
loc_0232AF0C:
	ldr r1,[pool_0232AF14]	; 0232AF0C
	ldr r2,[pool_0232AF18]	; 0232AF0E
	ldr r3,[pool_0232AF1C]	; 0232AF10
	bx r3	; 0232AF12
pool_0232AF14:
loc_0232AF14:
	.word 0x027FFFE0	; 0232AF14
pool_0232AF18:
loc_0232AF18:
	.word 0x0232AEF9	; 0232AF18
pool_0232AF1C:
loc_0232AF1C:
	.word loc_0232AFBC + 1	; 0232AF1C

; ===== function loc_0232AF20 =====
loc_0232AF20:
	ldr r1,[pool_0232AF28]	; 0232AF20
	ldr r2,[pool_0232AF2C]	; 0232AF22
	ldr r3,[pool_0232AF30]	; 0232AF24
	bx r3	; 0232AF26
pool_0232AF28:
loc_0232AF28:
	.word 0x027FFFE0	; 0232AF28
pool_0232AF2C:
loc_0232AF2C:
	.word 0x0232AEE5	; 0232AF2C
pool_0232AF30:
loc_0232AF30:
	.word loc_0232B02C + 1	; 0232AF30

; ===== function loc_0232AF34 =====
loc_0232AF34:
	ldr r1,[pool_0232AF3C]	; 0232AF34
	ldr r2,[pool_0232AF40]	; 0232AF36
	ldr r3,[pool_0232AF44]	; 0232AF38
	bx r3	; 0232AF3A
pool_0232AF3C:
loc_0232AF3C:
	.word 0x027FFFE0	; 0232AF3C
pool_0232AF40:
loc_0232AF40:
	.word 0x0232AEF9	; 0232AF40
pool_0232AF44:
loc_0232AF44:
	.word loc_0232B094 + 1	; 0232AF44
	ldr r1,[pool_0232AF54]	; 0232AF48
	ldrh r2,[r1,#0x0]	; 0232AF4A
	mov r0,#0x80	; 0232AF4C
	orr r2,r0	; 0232AF4E
	strh r2,[r1,#0x0]	; 0232AF50
	bx lr	; 0232AF52
pool_0232AF54:
loc_0232AF54:
	.word REG_EXMEMCNT_ARM9	; 0232AF54
	ldr r1,[pool_0232AF64]	; 0232AF58
	ldrh r2,[r1,#0x0]	; 0232AF5A
	mov r0,#0x80	; 0232AF5C
	bic r2,r0	; 0232AF5E
	strh r2,[r1,#0x0]	; 0232AF60
	bx lr	; 0232AF62
pool_0232AF64:
loc_0232AF64:
	.word REG_EXMEMCNT_ARM9	; 0232AF64

; ===== function loc_0232AF68 =====
loc_0232AF68:
	push {lr}	; 0232AF68
	sub sp,#0x4	; 0232AF6A
	ldr r1,[pool_0232AF7C]	; 0232AF6C
	ldr r2,[pool_0232AF80]	; 0232AF6E
	mov r3,#0x1	; 0232AF70
	bl loc_0232AFCC	; 0232AF72
	add sp,#0x4	; 0232AF76
	pop {r3}	; 0232AF78
	bx r3	; 0232AF7A
pool_0232AF7C:
loc_0232AF7C:
	.word 0x027FFFE8	; 0232AF7C
pool_0232AF80:
loc_0232AF80:
	.word 0x0232AF59	; 0232AF80

; ===== function loc_0232AF84 =====
loc_0232AF84:
	push {lr}	; 0232AF84
	sub sp,#0x4	; 0232AF86
	ldr r1,[pool_0232AF98]	; 0232AF88
	ldr r2,[pool_0232AF9C]	; 0232AF8A
	mov r3,#0x1	; 0232AF8C
	bl loc_0232B03C	; 0232AF8E
	add sp,#0x4	; 0232AF92
	pop {r3}	; 0232AF94
	bx r3	; 0232AF96
pool_0232AF98:
loc_0232AF98:
	.word 0x027FFFE8	; 0232AF98
pool_0232AF9C:
loc_0232AF9C:
	.word 0x0232AF49	; 0232AF9C

; ===== function loc_0232AFA0 =====
loc_0232AFA0:
	push {lr}	; 0232AFA0
	sub sp,#0x4	; 0232AFA2
	ldr r1,[pool_0232AFB4]	; 0232AFA4
	ldr r2,[pool_0232AFB8]	; 0232AFA6
	mov r3,#0x1	; 0232AFA8
	bl loc_0232B0A4	; 0232AFAA
	add sp,#0x4	; 0232AFAE
	pop {r3}	; 0232AFB0
	bx r3	; 0232AFB2
pool_0232AFB4:
loc_0232AFB4:
	.word 0x027FFFE8	; 0232AFB4
pool_0232AFB8:
loc_0232AFB8:
	.word 0x0232AF59	; 0232AFB8
loc_0232AFBC:
	push {lr}	; 0232AFBC
	sub sp,#0x4	; 0232AFBE
	mov r3,#0x0	; 0232AFC0
	bl loc_0232AFCC	; 0232AFC2
	add sp,#0x4	; 0232AFC6
	pop {r3}	; 0232AFC8
	bx r3	; 0232AFCA

; ===== function loc_0232AFCC =====
loc_0232AFCC:
	push {r4,r5,r6,r7,lr}	; 0232AFCC
	sub sp,#0xc	; 0232AFCE
	add r5,r0,#0x0	; 0232AFD0
	add r6,r1,#0x0	; 0232AFD2
	add r4,r2,#0x0	; 0232AFD4
	add r7,r3,#0x0	; 0232AFD6
	cmp r7,#0x0	; 0232AFD8
	beq loc_0232AFE4	; 0232AFDA
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232AFDC
	str r0,[sp,#0x0]	; 0232AFE0
	b loc_0232AFEA	; 0232AFE2
loc_0232AFE4:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232AFE4
	str r0,[sp,#0x0]	; 0232AFE8
loc_0232AFEA:
	add r0,r5,#0x0	; 0232AFEA
	add r1,r6,#0x0	; 0232AFEC
	blx loc_0232E3FC	; 0232AFEE
	str r0,[sp,#0x4]	; 0232AFF2
	cmp r0,#0x0	; 0232AFF4
	bne loc_0232B000	; 0232AFF6
	cmp r4,#0x0	; 0232AFF8
	beq loc_0232AFFE	; 0232AFFA
	blx r4	; 0232AFFC
loc_0232AFFE:
	strh r5,[r6,#0x4]	; 0232AFFE
loc_0232B000:
	cmp r7,#0x0	; 0232B000
	beq loc_0232B00C	; 0232B002
	ldr r0,[sp,#0x0]	; 0232B004
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B006
	b loc_0232B012	; 0232B00A
loc_0232B00C:
	ldr r0,[sp,#0x0]	; 0232B00C
	blx P1_Arm9RestoreIrqMask	; 0232B00E
loc_0232B012:
	ldr r0,[sp,#0x4]	; 0232B012
	add sp,#0xc	; 0232B014
	pop {r4,r5,r6,r7}	; 0232B016
	pop {r3}	; 0232B018
	bx r3	; 0232B01A

; ===== function loc_0232B01C =====
loc_0232B01C:
	push {lr}	; 0232B01C
	sub sp,#0x4	; 0232B01E
	mov r3,#0x0	; 0232B020
	bl loc_0232B03C	; 0232B022
	add sp,#0x4	; 0232B026
	pop {r3}	; 0232B028
	bx r3	; 0232B02A

; ===== function loc_0232B02C =====
loc_0232B02C:
	push {lr}	; 0232B02C
	sub sp,#0x4	; 0232B02E
	mov r3,#0x0	; 0232B030
	bl loc_0232B03C	; 0232B032
	add sp,#0x4	; 0232B036
	pop {r3}	; 0232B038
	bx r3	; 0232B03A

; ===== function loc_0232B03C =====
loc_0232B03C:
	push {r4,r5,r6,r7,lr}	; 0232B03C
	sub sp,#0x4	; 0232B03E
	add r5,r1,#0x0	; 0232B040
	add r4,r2,#0x0	; 0232B042
	add r6,r3,#0x0	; 0232B044
	ldrh r1,[r5,#0x4]	; 0232B046
	cmp r0,r1	; 0232B048
	beq loc_0232B058	; 0232B04A
	mov r0,#0x1	; 0232B04C
	mvn r0,r0	; 0232B04E
	add sp,#0x4	; 0232B050
	pop {r4,r5,r6,r7}	; 0232B052
	pop {r3}	; 0232B054
	bx r3	; 0232B056
loc_0232B058:
	cmp r6,#0x0	; 0232B058
	beq loc_0232B064	; 0232B05A
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B05C
	add r7,r0,#0x0	; 0232B060
	b loc_0232B06A	; 0232B062
loc_0232B064:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B064
	add r7,r0,#0x0	; 0232B068
loc_0232B06A:
	mov r0,#0x0	; 0232B06A
	strh r0,[r5,#0x4]	; 0232B06C
	cmp r4,#0x0	; 0232B06E
	beq loc_0232B074	; 0232B070
	blx r4	; 0232B072
loc_0232B074:
	mov r0,#0x0	; 0232B074
	str r0,[r5,#0x0]	; 0232B076
	cmp r6,#0x0	; 0232B078
	beq loc_0232B084	; 0232B07A
	add r0,r7,#0x0	; 0232B07C
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B07E
	b loc_0232B08A	; 0232B082
loc_0232B084:
	add r0,r7,#0x0	; 0232B084
	blx P1_Arm9RestoreIrqMask	; 0232B086
loc_0232B08A:
	mov r0,#0x0	; 0232B08A
	add sp,#0x4	; 0232B08C
	pop {r4,r5,r6,r7}	; 0232B08E
	pop {r3}	; 0232B090
	bx r3	; 0232B092

; ===== function loc_0232B094 =====
loc_0232B094:
	push {lr}	; 0232B094
	sub sp,#0x4	; 0232B096
	mov r3,#0x0	; 0232B098
	bl loc_0232B0A4	; 0232B09A
	add sp,#0x4	; 0232B09E
	pop {r3}	; 0232B0A0
	bx r3	; 0232B0A2

; ===== function loc_0232B0A4 =====
loc_0232B0A4:
	push {r4,r5,r6,r7,lr}	; 0232B0A4
	sub sp,#0x4	; 0232B0A6
	add r5,r0,#0x0	; 0232B0A8
	add r4,r1,#0x0	; 0232B0AA
	add r6,r2,#0x0	; 0232B0AC
	add r7,r3,#0x0	; 0232B0AE
	bl loc_0232AFCC	; 0232B0B0
	cmp r0,#0x0	; 0232B0B4
	ble loc_0232B0CC	; 0232B0B6
loc_0232B0B8:
	bl loc_0232AED0	; 0232B0B8
	add r0,r5,#0x0	; 0232B0BC
	add r1,r4,#0x0	; 0232B0BE
	add r2,r6,#0x0	; 0232B0C0
	add r3,r7,#0x0	; 0232B0C2
	bl loc_0232AFCC	; 0232B0C4
	cmp r0,#0x0	; 0232B0C8
	bgt loc_0232B0B8	; 0232B0CA
loc_0232B0CC:
	add sp,#0x4	; 0232B0CC
	pop {r4,r5,r6,r7}	; 0232B0CE
	pop {r3}	; 0232B0D0
	bx r3	; 0232B0D2

; ===== function loc_0232B0D4 =====
loc_0232B0D4:
	push {r4,lr}	; 0232B0D4
	sub sp,#0x8	; 0232B0D6
	ldr r0,[pool_0232B14C]	; 0232B0D8
	ldr r1,[r0,#0x0]	; 0232B0DA
	cmp r1,#0x0	; 0232B0DC
	bne loc_0232B142	; 0232B0DE
	mov r1,#0x1	; 0232B0E0
	str r1,[r0,#0x0]	; 0232B0E2
	mov r2,#0x0	; 0232B0E4
	ldr r1,[pool_0232B150]	; 0232B0E6
	str r2,[r1,#0x0]	; 0232B0E8
	mov r0,#0x7e	; 0232B0EA
	bl loc_0232B094	; 0232B0EC
	ldr r4,[pool_0232B150]	; 0232B0F0
	ldrh r0,[r4,#0x6]	; 0232B0F2
	cmp r0,#0x0	; 0232B0F4
	beq loc_0232B102	; 0232B0F6
loc_0232B0F8:
	bl loc_0232AED0	; 0232B0F8
	ldrh r0,[r4,#0x6]	; 0232B0FC
	cmp r0,#0x0	; 0232B0FE
	bne loc_0232B0F8	; 0232B100
loc_0232B102:
	mov r0,#0x0	; 0232B102
	mvn r2,r0	; 0232B104
	ldr r1,[pool_0232B154]	; 0232B106
	str r2,[r1,#0x0]	; 0232B108
	ldr r2,[pool_0232B158]	; 0232B10A
	ldr r1,[pool_0232B15C]	; 0232B10C
	str r2,[r1,#0x0]	; 0232B10E
	str r0,[sp,#0x0]	; 0232B110
	ldr r0,[sp,#0x0]	; 0232B112
	ldr r1,[pool_0232B160]	; 0232B114
	mov r2,#0x28	; 0232B116
	blx loc_0232E318	; 0232B118
	ldr r2,[pool_0232B164]	; 0232B11C
	ldrh r1,[r2,#0x0]	; 0232B11E
	ldr r0,[pool_0232B168]	; 0232B120
	orr r1,r0	; 0232B122
	strh r1,[r2,#0x0]	; 0232B124
	ldrh r1,[r2,#0x0]	; 0232B126
	mov r0,#0x80	; 0232B128
	orr r1,r0	; 0232B12A
	strh r1,[r2,#0x0]	; 0232B12C
	mov r0,#0x7e	; 0232B12E
	ldr r1,[pool_0232B150]	; 0232B130
	mov r2,#0x0	; 0232B132
	bl loc_0232B02C	; 0232B134
	mov r0,#0x7f	; 0232B138
	ldr r1,[pool_0232B150]	; 0232B13A
	mov r2,#0x0	; 0232B13C
	bl loc_0232B094	; 0232B13E
loc_0232B142:
	add sp,#0x8	; 0232B142
	pop {r4}	; 0232B144
	pop {r3}	; 0232B146
	bx r3	; 0232B148
	.byte 0xC0, 0x46	; 0232B14C
pool_0232B14C:
loc_0232B14C:
	.word P1_BssStart + 0x26370	; 0232B14C
pool_0232B150:
loc_0232B150:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 0232B150
pool_0232B154:
loc_0232B154:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B154
pool_0232B158:
loc_0232B158:
	.word 0xFFFF0000	; 0232B158
pool_0232B15C:
loc_0232B15C:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset + 0x4	; 0232B15C
pool_0232B160:
loc_0232B160:
	.word 0x027FFFC0	; 0232B160
pool_0232B164:
loc_0232B164:
	.word REG_EXMEMCNT_ARM9	; 0232B164
pool_0232B168:
loc_0232B168:
	.word 0x00000800	; 0232B168

; ===== function loc_0232B16C =====
P1_ThreadEntry_0232B16C:
	push {lr}	; 0232B16C
	sub sp,#0x4	; 0232B16E
	blx P1_Arm9EnableIrqReturnPriorMask	; 0232B170
loc_0232B174:
	blx P1_Arm9WaitForInterrupt	; 0232B174
	b loc_0232B174	; 0232B178
	.byte 0x00, 0x00	; 0232B17C

; ===== function loc_0232B17C =====
loc_0232B17C:
	push {r4,r5,lr}	; 0232B17C
	sub sp,#0x4	; 0232B17E
	add r5,r0,#0x0	; 0232B180
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B182
	ldr r1,[pool_0232B19C]	; 0232B186
	ldr r4,[r1,#0x10]	; 0232B188
	str r5,[r1,#0x10]	; 0232B18A
	blx P1_Arm9RestoreIrqMask	; 0232B18C
	add r0,r4,#0x0	; 0232B190
	add sp,#0x4	; 0232B192
	pop {r4,r5}	; 0232B194
	pop {r3}	; 0232B196
	bx r3	; 0232B198
	.byte 0xC0, 0x46	; 0232B19C
pool_0232B19C:
loc_0232B19C:
	.word P1_BssStart + 0x26380	; 0232B19C

; ===== function loc_0232B1A0 =====
loc_0232B1A0:
	push {r4,r5,r6,lr}	; 0232B1A0
	ldr r6,[pool_0232B204]	; 0232B1A2
	ldrh r0,[r6,#0x4]	; 0232B1A4
	cmp r0,#0x0	; 0232B1A6
	bne loc_0232B1B2	; 0232B1A8
	blx P1_Arm9GetProcessorMode	; 0232B1AA
	cmp r0,#0x12	; 0232B1AE
	bne loc_0232B1BC	; 0232B1B0
loc_0232B1B2:
	mov r0,#0x1	; 0232B1B2
	strh r0,[r6,#0x0]	; 0232B1B4
	pop {r4,r5,r6}	; 0232B1B6
	pop {r3}	; 0232B1B8
	bx r3	; 0232B1BA
loc_0232B1BC:
	ldr r0,[pool_0232B208]	; 0232B1BC
	ldr r0,[r0,#0x0]	; 0232B1BE
	ldr r5,[r0,#0x0]	; 0232B1C0
	bl loc_0232B210	; 0232B1C2
	add r4,r0,#0x0	; 0232B1C6
	cmp r5,r4	; 0232B1C8
	beq loc_0232B1FE	; 0232B1CA
	cmp r4,#0x0	; 0232B1CC
	beq loc_0232B1FE	; 0232B1CE
	add r0,r5,#0x0	; 0232B1D0
	blx P1_SaveThreadContext	; 0232B1D2
	cmp r0,#0x0	; 0232B1D6
	bne loc_0232B1FE	; 0232B1D8
	ldr r0,[pool_0232B20C]	; 0232B1DA
	ldr r2,[r0,#0x0]	; 0232B1DC
	cmp r2,#0x0	; 0232B1DE
	beq loc_0232B1E8	; 0232B1E0
	add r0,r5,#0x0	; 0232B1E2
	add r1,r4,#0x0	; 0232B1E4
	blx r2	; 0232B1E6
loc_0232B1E8:
	ldr r2,[r6,#0x10]	; 0232B1E8
	cmp r2,#0x0	; 0232B1EA
	beq loc_0232B1F4	; 0232B1EC
	add r0,r5,#0x0	; 0232B1EE
	add r1,r4,#0x0	; 0232B1F0
	blx r2	; 0232B1F2
loc_0232B1F4:
	ldr r0,[pool_0232B204]	; 0232B1F4
	str r4,[r0,#0x8]	; 0232B1F6
	add r0,r4,#0x0	; 0232B1F8
	blx P1_LoadThreadContext	; 0232B1FA
loc_0232B1FE:
	pop {r4,r5,r6}	; 0232B1FE
	pop {r3}	; 0232B200
	bx r3	; 0232B202
pool_0232B204:
loc_0232B204:
	.word P1_BssStart + 0x26380	; 0232B204
pool_0232B208:
loc_0232B208:
	.word P1_BssStart + 0x26378	; 0232B208
pool_0232B20C:
loc_0232B20C:
	.word P1_BssStart + 0x26374	; 0232B20C

; ===== function loc_0232B210 =====
loc_0232B210:
	ldr r0,[pool_0232B224]	; 0232B210
	ldr r0,[r0,#0xc]	; 0232B212
	b loc_0232B218	; 0232B214
loc_0232B216:
	ldr r0,[r0,#0x68]	; 0232B216
loc_0232B218:
	cmp r0,#0x0	; 0232B218
	beq loc_0232B222	; 0232B21A
	ldr r1,[r0,#0x64]	; 0232B21C
	cmp r1,#0x1	; 0232B21E
	bne loc_0232B216	; 0232B220
loc_0232B222:
	bx lr	; 0232B222
pool_0232B224:
loc_0232B224:
	.word P1_BssStart + 0x26380	; 0232B224

; ===== function loc_0232B228 =====
loc_0232B228:
	push {r4,r5,r6,lr}	; 0232B228
	add r5,r0,#0x0	; 0232B22A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B22C
	add r4,r0,#0x0	; 0232B230
	ldrh r1,[r5,#0x0]	; 0232B232
	cmp r1,#0x0	; 0232B234
	beq loc_0232B260	; 0232B236
	ldr r0,[pool_0232B26C]	; 0232B238
	ldr r0,[r0,#0xc]	; 0232B23A
	cmp r0,#0x0	; 0232B23C
	beq loc_0232B258	; 0232B23E
	mov r3,#0x1	; 0232B240
loc_0232B242:
	ldr r2,[r0,#0x6c]	; 0232B242
	add r6,r3,#0x0	; 0232B244
	lsl r6,r2	; 0232B246
	add r2,r1,#0x0	; 0232B248
	and r2,r6	; 0232B24A
	cmp r2,#0x0	; 0232B24C
	beq loc_0232B252	; 0232B24E
	str r3,[r0,#0x64]	; 0232B250
loc_0232B252:
	ldr r0,[r0,#0x68]	; 0232B252
	cmp r0,#0x0	; 0232B254
	bne loc_0232B242	; 0232B256
loc_0232B258:
	mov r0,#0x0	; 0232B258
	strh r0,[r5,#0x0]	; 0232B25A
	bl loc_0232B1A0	; 0232B25C
loc_0232B260:
	add r0,r4,#0x0	; 0232B260
	blx P1_Arm9RestoreIrqMask	; 0232B262
	pop {r4,r5,r6}	; 0232B266
	pop {r3}	; 0232B268
	bx r3	; 0232B26A
pool_0232B26C:
loc_0232B26C:
	.word P1_BssStart + 0x26380	; 0232B26C

; ===== function loc_0232B270 =====
loc_0232B270:
	push {r4,r5,lr}	; 0232B270
	sub sp,#0x4	; 0232B272
	add r5,r0,#0x0	; 0232B274
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B276
	add r4,r0,#0x0	; 0232B27A
	ldr r0,[pool_0232B2AC]	; 0232B27C
	ldr r0,[r0,#0x0]	; 0232B27E
	ldr r1,[r0,#0x0]	; 0232B280
	cmp r5,#0x0	; 0232B282
	beq loc_0232B296	; 0232B284
	ldrh r0,[r5,#0x0]	; 0232B286
	mov r3,#0x1	; 0232B288
	ldr r2,[r1,#0x6c]	; 0232B28A
	lsl r3,r2	; 0232B28C
	lsl r2,r3,#0x10	; 0232B28E
	lsr r2,r2,#0x10	; 0232B290
	orr r0,r2	; 0232B292
	strh r0,[r5,#0x0]	; 0232B294
loc_0232B296:
	mov r0,#0x0	; 0232B296
	str r0,[r1,#0x64]	; 0232B298
	bl loc_0232B1A0	; 0232B29A
	add r0,r4,#0x0	; 0232B29E
	blx P1_Arm9RestoreIrqMask	; 0232B2A0
	add sp,#0x4	; 0232B2A4
	pop {r4,r5}	; 0232B2A6
	pop {r3}	; 0232B2A8
	bx r3	; 0232B2AA
pool_0232B2AC:
loc_0232B2AC:
	.word P1_BssStart + 0x26378	; 0232B2AC
; 线程初始 LR 指向此处；清除 ID 表项并将线程标记为终止态。
; Initial thread LR points here; clear its ID slot and mark the thread terminated.
.func P1_ExitThread
	push {r4,lr}	; 0232B2B0
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B2B2
	ldr r0,[pool_0232B2E8]	; 0232B2B6
	ldr r0,[r0,#0x0]	; 0232B2B8
	ldr r4,[r0,#0x0]	; 0232B2BA
	add r0,r4,#0x0	; 0232B2BC
	bl loc_0232B738	; 0232B2BE
	add r0,r4,#0x0	; 0232B2C2
	bl loc_0232B498	; 0232B2C4
	mov r2,#0x0	; 0232B2C8
	ldr r0,[r4,#0x6c]	; 0232B2CA
	lsl r1,r0,#0x2	; 0232B2CC
	ldr r0,[pool_0232B2EC]	; 0232B2CE
	str r2,[r0,r1]	; 0232B2D0
	mov r0,#0x2	; 0232B2D2
	str r0,[r4,#0x64]	; 0232B2D4
	add r4,#0x90	; 0232B2D6
	add r0,r4,#0x0	; 0232B2D8
	bl loc_0232B228	; 0232B2DA
	bl loc_0232B1A0	; 0232B2DE
	pop {r4}	; 0232B2E2
	pop {r3}	; 0232B2E4
	bx r3	; 0232B2E6
.endfunc
pool_0232B2E8:
loc_0232B2E8:
	.word P1_BssStart + 0x26378	; 0232B2E8
pool_0232B2EC:
loc_0232B2EC:
	.word P1_BssStart + 0x26394	; 0232B2EC

; ===== function loc_0232B2F0 =====
loc_0232B2F0:
; r0=线程，r1=入口，r2=参数，r3=栈顶；栈参数为大小/优先级。
; r0=thread, r1=entry, r2=argument, r3=stack top; stack arguments: size/priority.
.func P1_CreateThread
	push {r4,r5,r6,r7,lr}	; 0232B2F0
	sub sp,#0xc	; 0232B2F2
	add r5,r0,#0x0	; 0232B2F4
	str r1,[sp,#0x0]	; 0232B2F6
	add r7,r2,#0x0	; 0232B2F8
	add r4,r3,#0x0	; 0232B2FA
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B2FC
	str r0,[sp,#0x4]	; 0232B300
	bl loc_0232B4FC	; 0232B302
	cmp r0,#0x0	; 0232B306
	bge loc_0232B318	; 0232B308
	ldr r0,[sp,#0x4]	; 0232B30A
	blx P1_Arm9RestoreIrqMask	; 0232B30C
	add sp,#0xc	; 0232B310
	pop {r4,r5,r6,r7}	; 0232B312
	pop {r3}	; 0232B314
	bx r3	; 0232B316
loc_0232B318:
	ldr r1,[sp,#0x24]	; 0232B318
	str r1,[r5,#0x70]	; 0232B31A
	str r0,[r5,#0x6c]	; 0232B31C
	mov r1,#0x0	; 0232B31E
	str r1,[r5,#0x64]	; 0232B320
	lsl r1,r0,#0x2	; 0232B322
	ldr r0,[pool_0232B394]	; 0232B324
	str r5,[r0,r1]	; 0232B326
	add r0,r5,#0x0	; 0232B328
	bl loc_0232B4C4	; 0232B32A
	add r0,r5,#0x0	; 0232B32E
	add r0,#0x88	; 0232B330
	str r4,[r0,#0x0]	; 0232B332
	ldr r0,[sp,#0x20]	; 0232B334
	sub r6,r4,r0	; 0232B336
	add r0,r5,#0x0	; 0232B338
	add r0,#0x84	; 0232B33A
	str r6,[r0,#0x0]	; 0232B33C
	mov r1,#0x0	; 0232B33E
	add r0,r5,#0x0	; 0232B340
	add r0,#0x8c	; 0232B342
	str r1,[r0,#0x0]	; 0232B344
	ldr r0,[pool_0232B398]	; 0232B346
	add r1,r5,#0x0	; 0232B348
	add r1,#0x88	; 0232B34A
	ldr r1,[r1,#0x0]	; 0232B34C
	sub r1,r1,#0x4	; 0232B34E
	str r0,[r1,#0x0]	; 0232B350
	ldr r1,[pool_0232B39C]	; 0232B352
	add r0,r5,#0x0	; 0232B354
	add r0,#0x84	; 0232B356
	ldr r0,[r0,#0x0]	; 0232B358
	str r1,[r0,#0x0]	; 0232B35A
	add r0,r5,#0x0	; 0232B35C
	ldr r1,[sp,#0x0]	; 0232B35E
	sub r2,r4,#0x4	; 0232B360
	blx P1_InitThreadContext	; 0232B362
	str r7,[r5,#ThreadContextR0Offset]	; 0232B366
	ldr r0,[pool_0232B3A0]	; 0232B368
	str r0,[r5,#ThreadContextLrOffset]	; 0232B36A
	mov r0,#0x0	; 0232B36C
	str r0,[sp,#0x8]	; 0232B36E
	ldr r0,[sp,#0x8]	; 0232B370
	add r1,r6,#0x4	; 0232B372
	ldr r2,[sp,#0x20]	; 0232B374
	sub r2,#0x8	; 0232B376
	blx loc_0232E318	; 0232B378
	mov r0,#0x0	; 0232B37C
	str r0,[r5,#0x78]	; 0232B37E
	str r0,[r5,#0x7c]	; 0232B380
	add r5,#0x80	; 0232B382
	str r0,[r5,#0x0]	; 0232B384
	ldr r0,[sp,#0x4]	; 0232B386
	blx P1_Arm9RestoreIrqMask	; 0232B388
	add sp,#0xc	; 0232B38C
	pop {r4,r5,r6,r7}	; 0232B38E
	pop {r3}	; 0232B390
	bx r3	; 0232B392
.endfunc
pool_0232B394:
loc_0232B394:
	.word P1_BssStart + 0x26394	; 0232B394
pool_0232B398:
loc_0232B398:
	.word 0xFDDB597D	; 0232B398
pool_0232B39C:
loc_0232B39C:
	.word 0x7BF9DD5B	; 0232B39C
pool_0232B3A0:
loc_0232B3A0:
	.word P1_ExitThread + 1	; 0232B3A0

; ===== function loc_0232B3A4 =====
loc_0232B3A4:
	push {lr}	; 0232B3A4
	sub sp,#0xc	; 0232B3A6
	ldr r0,[pool_0232B454]	; 0232B3A8
	ldr r1,[r0,#0x0]	; 0232B3AA
	cmp r1,#0x0	; 0232B3AC
	bne loc_0232B44C	; 0232B3AE
	mov r1,#0x1	; 0232B3B0
	str r1,[r0,#0x0]	; 0232B3B2
	mov r1,#0x0	; 0232B3B4
	ldr r0,[pool_0232B458]	; 0232B3B6
	add r2,r1,#0x0	; 0232B3B8
loc_0232B3BA:
	str r2,[r0,#0x14]	; 0232B3BA
	add r0,r0,#0x4	; 0232B3BC
	add r1,r1,#0x1	; 0232B3BE
	cmp r1,#0x10	; 0232B3C0
	blt loc_0232B3BA	; 0232B3C2
	ldr r1,[pool_0232B45C]	; 0232B3C4
	ldr r0,[pool_0232B460]	; 0232B3C6
	str r1,[r0,#0x0]	; 0232B3C8
	mov r0,#0x10	; 0232B3CA
	ldr r1,[pool_0232B464]	; 0232B3CC
	str r0,[r1,#0x70]	; 0232B3CE
	str r2,[r1,#0x6c]	; 0232B3D0
	mov r0,#0x1	; 0232B3D2
	str r0,[r1,#0x64]	; 0232B3D4
	str r2,[r1,#0x68]	; 0232B3D6
	str r2,[r1,#0x74]	; 0232B3D8
	ldr r0,[pool_0232B458]	; 0232B3DA
	str r1,[r0,#0x14]	; 0232B3DC
	str r1,[r0,#0xc]	; 0232B3DE
	str r1,[r0,#0x8]	; 0232B3E0
	ldr r2,[pool_0232B468]	; 0232B3E2
	cmp r2,#0x0	; 0232B3E4
	bne loc_0232B3EE	; 0232B3E6
	ldr r0,[pool_0232B46C]	; 0232B3E8
	sub r3,r0,r2	; 0232B3EA
	b loc_0232B3FA	; 0232B3EC
loc_0232B3EE:
	ldr r1,[pool_0232B470]	; 0232B3EE
	ldr r0,[pool_0232B474]	; 0232B3F0
	add r1,r1,r0	; 0232B3F2
	ldr r0,[pool_0232B478]	; 0232B3F4
	sub r0,r1,r0	; 0232B3F6
	sub r3,r0,r2	; 0232B3F8
loc_0232B3FA:
	ldr r1,[pool_0232B470]	; 0232B3FA
	ldr r0,[pool_0232B474]	; 0232B3FC
	add r1,r1,r0	; 0232B3FE
	ldr r0,[pool_0232B478]	; 0232B400
	sub r1,r1,r0	; 0232B402
	ldr r2,[pool_0232B47C]	; 0232B404
	str r1,[r2,#0x8]	; 0232B406
	str r3,[r2,#0x4]	; 0232B408
	mov r0,#0x0	; 0232B40A
	str r0,[r2,#0xc]	; 0232B40C
	ldr r3,[pool_0232B480]	; 0232B40E
	sub r1,r1,#0x4	; 0232B410
	str r3,[r1,#0x0]	; 0232B412
	ldr r3,[pool_0232B484]	; 0232B414
	ldr r1,[r2,#0x4]	; 0232B416
	str r3,[r1,#0x0]	; 0232B418
	strh r0,[r2,#0x10]	; 0232B41A
	mov r2,#0x10	; 0232B41C
	ldr r1,[pool_0232B458]	; 0232B41E
	strh r2,[r1,#0x2]	; 0232B420
	strh r0,[r1,#0x0]	; 0232B422
	strh r0,[r1,#0x4]	; 0232B424
	ldr r2,[pool_0232B488]	; 0232B426
	str r1,[r2,#0x0]	; 0232B428
	bl loc_0232B17C	; 0232B42A
	mov r0,#0xc8	; 0232B42E
	str r0,[sp,#0x0]	; 0232B430
	mov r0,#0x1f	; 0232B432
	str r0,[sp,#0x4]	; 0232B434
	ldr r0,[pool_0232B48C]	; 0232B436
	ldr r1,[pool_0232B490]	; 0232B438
	mov r2,#0x0	; 0232B43A
	ldr r3,[pool_0232B494]	; 0232B43C
	bl P1_CreateThread	; 0232B43E
	mov r1,#0x20	; 0232B442
	ldr r0,[pool_0232B48C]	; 0232B444
	str r1,[r0,#0x70]	; 0232B446
	mov r1,#0x1	; 0232B448
	str r1,[r0,#0x64]	; 0232B44A
loc_0232B44C:
	add sp,#0xc	; 0232B44C
	pop {r3}	; 0232B44E
	bx r3	; 0232B450
	.byte 0xC0, 0x46	; 0232B454
pool_0232B454:
loc_0232B454:
	.word P1_BssStart + 0x2637C	; 0232B454
pool_0232B458:
loc_0232B458:
	.word P1_BssStart + 0x26380	; 0232B458
pool_0232B45C:
loc_0232B45C:
	.word 0x023571E8	; 0232B45C
pool_0232B460:
loc_0232B460:
	.word P1_BssStart + 0x26378	; 0232B460
pool_0232B464:
loc_0232B464:
	.word P1_BssStart + 0x26468	; 0232B464
pool_0232B468:
loc_0232B468:
	.word 0x00000000	; 0232B468
pool_0232B46C:
loc_0232B46C:
	.word P1_DtcmRuntimeEnd	; 0232B46C
pool_0232B470:
loc_0232B470:
	.word P1_DtcmRuntimeStart	; 0232B470
pool_0232B474:
loc_0232B474:
	.word 0x00003FC0	; 0232B474
pool_0232B478:
loc_0232B478:
	.word 0x00001000	; 0232B478
pool_0232B47C:
loc_0232B47C:
	.word P1_BssStart + 0x264E8	; 0232B47C
pool_0232B480:
loc_0232B480:
	.word 0xFDDB597D	; 0232B480
pool_0232B484:
loc_0232B484:
	.word 0x7BF9DD5B	; 0232B484
pool_0232B488:
loc_0232B488:
	.word FirmwareSystemWorkAddress + SystemWorkArm9ThreadInfoOffset	; 0232B488
pool_0232B48C:
loc_0232B48C:
	.word P1_BssStart + 0x263D4	; 0232B48C
pool_0232B490:
loc_0232B490:
	.word P1_ThreadEntry_0232B16C + 1	; 0232B490
pool_0232B494:
loc_0232B494:
	.word 0x02357424	; 0232B494

; ===== function loc_0232B498 =====
loc_0232B498:
	ldr r1,[pool_0232B4C0]	; 0232B498
	ldr r2,[r1,#0xc]	; 0232B49A
	mov r1,#0x0	; 0232B49C
	b loc_0232B4A4	; 0232B49E
loc_0232B4A0:
	add r1,r2,#0x0	; 0232B4A0
	ldr r2,[r2,#0x68]	; 0232B4A2
loc_0232B4A4:
	cmp r2,#0x0	; 0232B4A4
	beq loc_0232B4AC	; 0232B4A6
	cmp r2,r0	; 0232B4A8
	bne loc_0232B4A0	; 0232B4AA
loc_0232B4AC:
	cmp r1,#0x0	; 0232B4AC
	bne loc_0232B4B8	; 0232B4AE
	ldr r1,[r0,#0x68]	; 0232B4B0
	ldr r0,[pool_0232B4C0]	; 0232B4B2
	str r1,[r0,#0xc]	; 0232B4B4
	bx lr	; 0232B4B6
loc_0232B4B8:
	ldr r0,[r0,#0x68]	; 0232B4B8
	str r0,[r1,#0x68]	; 0232B4BA
	bx lr	; 0232B4BC
	.byte 0xC0, 0x46	; 0232B4C0
pool_0232B4C0:
loc_0232B4C0:
	.word P1_BssStart + 0x26380	; 0232B4C0

; ===== function loc_0232B4C4 =====
loc_0232B4C4:
	push {r4,r5}	; 0232B4C4
	ldr r1,[pool_0232B4F8]	; 0232B4C6
	ldr r3,[r1,#0xc]	; 0232B4C8
	add r5,r3,#0x0	; 0232B4CA
	mov r4,#0x0	; 0232B4CC
	b loc_0232B4D4	; 0232B4CE
loc_0232B4D0:
	add r4,r5,#0x0	; 0232B4D0
	ldr r5,[r5,#0x68]	; 0232B4D2
loc_0232B4D4:
	cmp r5,#0x0	; 0232B4D4
	beq loc_0232B4E0	; 0232B4D6
	ldr r2,[r5,#0x70]	; 0232B4D8
	ldr r1,[r0,#0x70]	; 0232B4DA
	cmp r2,r1	; 0232B4DC
	bcc loc_0232B4D0	; 0232B4DE
loc_0232B4E0:
	cmp r4,#0x0	; 0232B4E0
	bne loc_0232B4EE	; 0232B4E2
	str r3,[r0,#0x68]	; 0232B4E4
	ldr r1,[pool_0232B4F8]	; 0232B4E6
	str r0,[r1,#0xc]	; 0232B4E8
	pop {r4,r5}	; 0232B4EA
	bx lr	; 0232B4EC
loc_0232B4EE:
	ldr r1,[r4,#0x68]	; 0232B4EE
	str r1,[r0,#0x68]	; 0232B4F0
	str r0,[r4,#0x68]	; 0232B4F2
	pop {r4,r5}	; 0232B4F4
	bx lr	; 0232B4F6
pool_0232B4F8:
loc_0232B4F8:
	.word P1_BssStart + 0x26380	; 0232B4F8

; ===== function loc_0232B4FC =====
loc_0232B4FC:
	mov r0,#0x0	; 0232B4FC
	ldr r2,[pool_0232B514]	; 0232B4FE
loc_0232B500:
	ldr r1,[r2,#0x14]	; 0232B500
	cmp r1,#0x0	; 0232B502
	beq loc_0232B512	; 0232B504
	add r2,r2,#0x4	; 0232B506
	add r0,r0,#0x1	; 0232B508
	cmp r0,#0x10	; 0232B50A
	blt loc_0232B500	; 0232B50C
	mov r0,#0x0	; 0232B50E
	mvn r0,r0	; 0232B510
loc_0232B512:
	bx lr	; 0232B512
pool_0232B514:
loc_0232B514:
	.word P1_BssStart + 0x26380	; 0232B514
.arm

; ===== function loc_0232B518 =====
loc_0232B518:
; r0=上下文，r1=入口，r2=栈顶；保存入口+4/状态，并留出 SVC 栈。
; r0=context, r1=entry, r2=stack top; save entry+4/state and reserve the SVC stack.
.func P1_InitThreadContext
	add r1,r1,#0x4	; 0232B518
	str r1,[r0,#ThreadContextPcPlus4Offset]	; 0232B51C
	str r2,[r0,#ThreadContextSvcSpOffset]	; 0232B520
	sub r2,r2,#ThreadContextSvcStackBytes	; 0232B524
	str r2,[r0,#ThreadContextSpOffset]	; 0232B528
	ands r1,r1,#0x1	; 0232B52C
	movne r1,#0x3f	; 0232B530
	moveq r1,#0x1f	; 0232B534
	str r1,[r0,#ThreadContextCpsrOffset]	; 0232B538
	mov r1,#0x0	; 0232B53C
	str r1,[r0,#ThreadContextR0Offset]	; 0232B540
	str r1,[r0,#0x8]	; 0232B544
	str r1,[r0,#0xc]	; 0232B548
	str r1,[r0,#0x10]	; 0232B54C
	str r1,[r0,#0x14]	; 0232B550
	str r1,[r0,#0x18]	; 0232B554
	str r1,[r0,#0x1c]	; 0232B558
	str r1,[r0,#0x20]	; 0232B55C
	str r1,[r0,#0x24]	; 0232B560
	str r1,[r0,#0x28]	; 0232B564
	str r1,[r0,#0x2c]	; 0232B568
	str r1,[r0,#0x30]	; 0232B56C
	str r1,[r0,#0x34]	; 0232B570
	str r1,[r0,#ThreadContextLrOffset]	; 0232B574
	bx lr	; 0232B578
.endfunc

; ===== function loc_0232B57C =====
loc_0232B57C:
; 保存寄存器及状态；首次返回 0，恢复后从同一返回点返回 1。
; Save registers/state; return 0 now and 1 from the same return point after restoration.
.func P1_SaveThreadContext
	stmdb sp!,{r0,lr}	; 0232B57C
	add r0,r0,#ThreadContextArithmeticOffset	; 0232B580
	ldr r1,[pool_0232B5C4]	; 0232B584
	blx r1	; 0232B588
	ldmia sp!,{r0,lr}	; 0232B58C
	add r1,r0,#0x0	; 0232B590
	mrs r2,cpsr	; 0232B594
	str r2,[r1],#0x4	; 0232B598
	mov r0,#0xd3	; 0232B59C
	msr cpsr_c,r0	; 0232B5A0
	str sp,[r1,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 0232B5A4
	msr cpsr_c,r2	; 0232B5A8
	mov r0,#0x1	; 0232B5AC
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 0232B5B0
	adr r0,P1_SaveThreadContextReturn + 4	; 0232B5B4
	str r0,[r1,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 0232B5B8
	mov r0,#0x0	; 0232B5BC
P1_SaveThreadContextReturn:
	bx lr	; 0232B5C0
.endfunc
pool_0232B5C4:
loc_0232B5C4:
	.word P1_SaveArithmeticContext + 1	; 0232B5C4

; ===== function loc_0232B5C8 =====
loc_0232B5C8:
; 以 SVC 模式恢复状态和用户寄存器，再用已存 PC+4 恢复执行。
; Restore saved state/user registers in SVC mode, then resume via the saved PC+4.
.func P1_LoadThreadContext
	stmdb sp!,{r0,lr}	; 0232B5C8
	add r0,r0,#ThreadContextArithmeticOffset	; 0232B5CC
	ldr r1,[pool_0232B608]	; 0232B5D0
	blx r1	; 0232B5D4
	ldmia sp!,{r0,lr}	; 0232B5D8
	mrs r1,cpsr	; 0232B5DC
	bic r1,r1,#0x1f	; 0232B5E0
	orr r1,r1,#0xd3	; 0232B5E4
	msr cpsr_c,r1	; 0232B5E8
	ldr r1,[r0],#0x4	; 0232B5EC
	msr spsr_cxsf,r1	; 0232B5F0
	ldr sp,[r0,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 0232B5F4
	ldr lr,[r0,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 0232B5F8
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 0232B5FC
	mov r0,r0	; 0232B600
	subs pc,lr,#0x4	; 0232B604
.endfunc
pool_0232B608:
loc_0232B608:
	.word P1_RestoreArithmeticContext + 1	; 0232B608
.thumb

; ===== function loc_0232B60C =====
loc_0232B60C:
	ldr r0,[pool_0232B614]	; 0232B60C
	ldr r1,[pool_0232B618]	; 0232B60E
	str r0,[r1,#0x0]	; 0232B610
	bx lr	; 0232B612
pool_0232B614:
loc_0232B614:
	.word 0x82000001	; 0232B614
pool_0232B618:
loc_0232B618:
	.word P1_Data_02330E44	; 0232B618

; ===== function loc_0232B61C =====
loc_0232B61C:
	mov r0,#0x0	; 0232B61C
	bx lr	; 0232B61E

; ===== function loc_0232B620 =====
loc_0232B620:
	push {r4,r5,r6,r7,lr}	; 0232B620
	sub sp,#0x4	; 0232B622
	add r5,r0,#0x0	; 0232B624
	add r7,r1,#0x0	; 0232B626
	add r4,r2,#0x0	; 0232B628
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B62A
	str r0,[sp,#0x0]	; 0232B62E
	ldr r0,[r5,#0x10]	; 0232B630
	cmp r0,#0x0	; 0232B632
	bne loc_0232B65C	; 0232B634
	mov r0,#0x1	; 0232B636
	and r4,r0	; 0232B638
	add r6,r5,#0x2	; 0232B63A
loc_0232B63C:
	cmp r4,#0x0	; 0232B63C
	bne loc_0232B650	; 0232B63E
	ldr r0,[sp,#0x0]	; 0232B640
	blx P1_Arm9RestoreIrqMask	; 0232B642
	mov r0,#0x0	; 0232B646
	add sp,#0x4	; 0232B648
	pop {r4,r5,r6,r7}	; 0232B64A
	pop {r3}	; 0232B64C
	bx r3	; 0232B64E
loc_0232B650:
	add r0,r6,#0x0	; 0232B650
	bl loc_0232B270	; 0232B652
	ldr r0,[r5,#0x10]	; 0232B656
	cmp r0,#0x0	; 0232B658
	beq loc_0232B63C	; 0232B65A
loc_0232B65C:
	cmp r7,#0x0	; 0232B65C
	beq loc_0232B66A	; 0232B65E
	ldr r1,[r5,#0x4]	; 0232B660
	ldr r0,[r5,#0xc]	; 0232B662
	lsl r0,r0,#0x2	; 0232B664
	ldr r0,[r1,r0]	; 0232B666
	str r0,[r7,#0x0]	; 0232B668
loc_0232B66A:
	ldr r0,[r5,#0xc]	; 0232B66A
	add r0,r0,#0x1	; 0232B66C
	ldr r1,[r5,#0x8]	; 0232B66E
	blx P1_SignedDivMod	; 0232B670
	str r1,[r5,#0xc]	; 0232B674
	add r1,r5,#0x0	; 0232B676
	add r1,#0x10	; 0232B678
	ldr r0,[r1,#0x0]	; 0232B67A
	sub r0,r0,#0x1	; 0232B67C
	str r0,[r1,#0x0]	; 0232B67E
	add r0,r5,#0x0	; 0232B680
	bl loc_0232B228	; 0232B682
	ldr r0,[sp,#0x0]	; 0232B686
	blx P1_Arm9RestoreIrqMask	; 0232B688
	mov r0,#0x1	; 0232B68C
	add sp,#0x4	; 0232B68E
	pop {r4,r5,r6,r7}	; 0232B690
	pop {r3}	; 0232B692
	bx r3	; 0232B694
	.byte 0x00, 0x00	; 0232B698

; ===== function loc_0232B698 =====
loc_0232B698:
	push {r4,r5,r6,r7,lr}	; 0232B698
	sub sp,#0x4	; 0232B69A
	add r5,r0,#0x0	; 0232B69C
	add r6,r1,#0x0	; 0232B69E
	add r4,r2,#0x0	; 0232B6A0
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B6A2
	add r7,r0,#0x0	; 0232B6A6
	ldr r2,[r5,#0x10]	; 0232B6A8
	ldr r1,[r5,#0x8]	; 0232B6AA
	cmp r1,r2	; 0232B6AC
	bgt loc_0232B6D6	; 0232B6AE
	mov r0,#0x1	; 0232B6B0
	and r4,r0	; 0232B6B2
loc_0232B6B4:
	cmp r4,#0x0	; 0232B6B4
	bne loc_0232B6C8	; 0232B6B6
	add r0,r7,#0x0	; 0232B6B8
	blx P1_Arm9RestoreIrqMask	; 0232B6BA
	mov r0,#0x0	; 0232B6BE
	add sp,#0x4	; 0232B6C0
	pop {r4,r5,r6,r7}	; 0232B6C2
	pop {r3}	; 0232B6C4
	bx r3	; 0232B6C6
loc_0232B6C8:
	add r0,r5,#0x0	; 0232B6C8
	bl loc_0232B270	; 0232B6CA
	ldr r2,[r5,#0x10]	; 0232B6CE
	ldr r1,[r5,#0x8]	; 0232B6D0
	cmp r1,r2	; 0232B6D2
	ble loc_0232B6B4	; 0232B6D4
loc_0232B6D6:
	ldr r0,[r5,#0xc]	; 0232B6D6
	add r0,r0,r2	; 0232B6D8
	blx P1_SignedDivMod	; 0232B6DA
	ldr r2,[r5,#0x4]	; 0232B6DE
	lsl r0,r1,#0x2	; 0232B6E0
	str r6,[r2,r0]	; 0232B6E2
	add r1,r5,#0x0	; 0232B6E4
	add r1,#0x10	; 0232B6E6
	ldr r0,[r1,#0x0]	; 0232B6E8
	add r0,r0,#0x1	; 0232B6EA
	str r0,[r1,#0x0]	; 0232B6EC
	add r0,r5,#0x2	; 0232B6EE
	bl loc_0232B228	; 0232B6F0
	add r0,r7,#0x0	; 0232B6F4
	blx P1_Arm9RestoreIrqMask	; 0232B6F6
	mov r0,#0x1	; 0232B6FA
	add sp,#0x4	; 0232B6FC
	pop {r4,r5,r6,r7}	; 0232B6FE
	pop {r3}	; 0232B700
	bx r3	; 0232B702
P1_Entry_0232B704:
	mov r3,#0x0	; 0232B704
	strh r3,[r0,#0x0]	; 0232B706
	strh r3,[r0,#0x2]	; 0232B708
	str r1,[r0,#0x4]	; 0232B70A
	str r2,[r0,#0x8]	; 0232B70C
	str r3,[r0,#0xc]	; 0232B70E
	str r3,[r0,#0x10]	; 0232B710
	bx lr	; 0232B712

; ===== function loc_0232B714 =====
loc_0232B714:
	push {r4}	; 0232B714
	sub sp,#0x4	; 0232B716
	ldr r4,[r0,#0x7c]	; 0232B718
	ldr r3,[r4,#0x10]	; 0232B71A
	cmp r3,#0x0	; 0232B71C
	bne loc_0232B72A	; 0232B71E
	mov r2,#0x0	; 0232B720
	add r1,r0,#0x0	; 0232B722
	add r1,#0x80	; 0232B724
	str r2,[r1,#0x0]	; 0232B726
	b loc_0232B72E	; 0232B728
loc_0232B72A:
	mov r1,#0x0	; 0232B72A
	str r1,[r3,#0xc]	; 0232B72C
loc_0232B72E:
	str r3,[r0,#0x7c]	; 0232B72E
	add r0,r4,#0x0	; 0232B730
	add sp,#0x4	; 0232B732
	pop {r4}	; 0232B734
	bx lr	; 0232B736

; ===== function loc_0232B738 =====
loc_0232B738:
	push {r4,r5,lr}	; 0232B738
	sub sp,#0x4	; 0232B73A
	add r5,r0,#0x0	; 0232B73C
	ldr r0,[r5,#0x7c]	; 0232B73E
	cmp r0,#0x0	; 0232B740
	beq loc_0232B75A	; 0232B742
	mov r4,#0x0	; 0232B744
loc_0232B746:
	add r0,r5,#0x0	; 0232B746
	bl loc_0232B714	; 0232B748
	str r4,[r0,#0x8]	; 0232B74C
	str r4,[r0,#0x4]	; 0232B74E
	bl loc_0232B228	; 0232B750
	ldr r0,[r5,#0x7c]	; 0232B754
	cmp r0,#0x0	; 0232B756
	bne loc_0232B746	; 0232B758
loc_0232B75A:
	add sp,#0x4	; 0232B75A
	pop {r4,r5}	; 0232B75C
	pop {r3}	; 0232B75E
	bx r3	; 0232B760
	.byte 0x00, 0x00	; 0232B764

; ===== function loc_0232B764 =====
loc_0232B764:
	mov r1,#0x0	; 0232B764
	strh r1,[r0,#0x0]	; 0232B766
	str r1,[r0,#0x4]	; 0232B768
	str r1,[r0,#0x8]	; 0232B76A
	bx lr	; 0232B76C
	.byte 0x00, 0x00	; 0232B770
.arm

; ===== function loc_0232B770 =====
; 以 ARM946 cache index 遍历并清理整个 D-cache。
; Cleans the entire ARM946 D-cache by cache index.
.func P1_CleanEntireDataCacheByIndex
loc_0232B770:
	mov r1,#0x0	; 0232B770
loc_0232B774:
	mov r0,#0x0	; 0232B774
loc_0232B778:
	orr r2,r1,r0	; 0232B778
	mcr p15,0x0,r2,c7,c10,0x2	; 0232B77C
	add r0,r0,#0x20	; 0232B780
	cmp r0,#0x400	; 0232B784
	blt loc_0232B778	; 0232B788
	add r1,r1,#0x40000000	; 0232B78C
	cmp r1,#0x0	; 0232B790
	bne loc_0232B774	; 0232B794
	bx lr	; 0232B798

.endfunc

; ===== function loc_0232B79C =====
; 以 ARM946 cache index 遍历，清理并失效整个 D-cache。
; Cleans and invalidates the entire ARM946 D-cache by cache index.
.func P1_CleanAndInvalidateEntireDataCacheByIndex
loc_0232B79C:
	mov r1,#0x0	; 0232B79C
loc_0232B7A0:
	mov r0,#0x0	; 0232B7A0
loc_0232B7A4:
	orr r2,r1,r0	; 0232B7A4
	mcr p15,0x0,r2,c7,c14,0x2	; 0232B7A8
	add r0,r0,#0x20	; 0232B7AC
	cmp r0,#0x400	; 0232B7B0
	blt loc_0232B7A4	; 0232B7B4
	add r1,r1,#0x40000000	; 0232B7B8
	cmp r1,#0x0	; 0232B7BC
	bne loc_0232B7A0	; 0232B7C0
	bx lr	; 0232B7C4

.endfunc

; ===== function loc_0232B7C8 =====
; 按 ARM946 32 字节 cache line 失效指定的 D-cache 地址范围。
; Invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_InvalidateDataCacheRange
loc_0232B7C8:
	add r1,r1,r0	; 0232B7C8
	bic r0,r0,#0x1f	; 0232B7CC
loc_0232B7D0:
	mcr p15,0x0,r0,c7,c6,0x1	; 0232B7D0
	add r0,r0,#0x20	; 0232B7D4
	cmp r0,r1	; 0232B7D8
	blt loc_0232B7D0	; 0232B7DC
	bx lr	; 0232B7E0

.endfunc

; ===== function loc_0232B7E4 =====
; 按 ARM946 32 字节 cache line 清理指定的 D-cache 地址范围。
; Cleans a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanDataCacheRange
loc_0232B7E4:
	add r1,r1,r0	; 0232B7E4
	bic r0,r0,#0x1f	; 0232B7E8
loc_0232B7EC:
	mcr p15,0x0,r0,c7,c10,0x1	; 0232B7EC
	add r0,r0,#0x20	; 0232B7F0
	cmp r0,r1	; 0232B7F4
	blt loc_0232B7EC	; 0232B7F8
	bx lr	; 0232B7FC

.endfunc

; ===== function loc_0232B800 =====
; 按 ARM946 32 字节 cache line 清理并失效指定的 D-cache 地址范围。
; Cleans and invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanAndInvalidateDataCacheRange
loc_0232B800:
	add r1,r1,r0	; 0232B800
	bic r0,r0,#0x1f	; 0232B804
loc_0232B808:
	mcr p15,0x0,r0,c7,c14,0x1	; 0232B808
	add r0,r0,#0x20	; 0232B80C
	cmp r0,r1	; 0232B810
	blt loc_0232B808	; 0232B814
	bx lr	; 0232B818
.endfunc
.arm
; 排空 ARM946 写缓冲区，确保先前存储操作完成。
; Drains the ARM946 write buffer so prior stores complete.
.func P1_DrainWriteBuffer
loc_0232B81C:
	mov r0,#0x0	; 0232B81C
	mcr p15,0x0,r0,c7,c10,0x4	; 0232B820
	bx lr	; 0232B824
.endfunc
.thumb

; ===== function loc_0232B828 =====
loc_0232B828:
	push {lr}	; 0232B828
	sub sp,#0x4	; 0232B82A
	bl loc_0232B950	; 0232B82C
	bl loc_0232ECB0	; 0232B830
	bl loc_0232B0D4	; 0232B834
	bl loc_0232B94C	; 0232B838
	bl loc_0232AE2C	; 0232B83C
	bl P1_InitExceptionHandler	; 0232B840
	mov r0,#0x3	; 0232B844
	bl loc_0232E1C0	; 0232B846
	bl loc_0232C094	; 0232B84A
	bl loc_0232B3A4	; 0232B84E
	bl loc_0232C3B0	; 0232B852
	bl loc_0232FA10	; 0232B856
	add sp,#0x4	; 0232B85A
	pop {r3}	; 0232B85C
	bx r3	; 0232B85E

; ===== function loc_0232B860 =====
loc_0232B860:
	lsl r2,r0,#0x2	; 0232B860
	ldr r0,[pool_0232B868]	; 0232B862
	str r1,[r2,r0]	; 0232B864
	bx lr	; 0232B866
pool_0232B868:
loc_0232B868:
	.word 0x027FFDA0	; 0232B868

; ===== function loc_0232B86C =====
loc_0232B86C:
	lsl r2,r0,#0x2	; 0232B86C
	ldr r0,[pool_0232B874]	; 0232B86E
	str r1,[r2,r0]	; 0232B870
	bx lr	; 0232B872
pool_0232B874:
loc_0232B874:
	.word 0x027FFDC4	; 0232B874

; ===== function loc_0232B878 =====
loc_0232B878:
	cmp r0,#0x6	; 0232B878
	bhi loc_0232B8B0	; 0232B87A
	add r0,r0,r0	; 0232B87C
P1_SwitchIndexPC_0232B87C:
	add r0,pc	; 0232B87E
	ldrh r0,[r0,#(P1_SwitchTable_0232B87C - (P1_SwitchIndexPC_0232B87C + 4))]	; 0232B880
	lsl r0,r0,#0x10	; 0232B882
	asr r0,r0,#0x10	; 0232B884
P1_SwitchTargetPC_0232B87C:
	add r0,pc	; 0232B886
	bx r0	; 0232B888
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232B87C:
	.halfword (loc_0232B898 + 1) - (P1_SwitchTargetPC_0232B87C + 4)
	.halfword (loc_0232B8B0 + 1) - (P1_SwitchTargetPC_0232B87C + 4)
	.halfword (loc_0232B89C + 1) - (P1_SwitchTargetPC_0232B87C + 4)
	.halfword (loc_0232B8A0 + 1) - (P1_SwitchTargetPC_0232B87C + 4)
	.halfword (loc_0232B8A4 + 1) - (P1_SwitchTargetPC_0232B87C + 4)
	.halfword (loc_0232B8A8 + 1) - (P1_SwitchTargetPC_0232B87C + 4)
	.halfword (loc_0232B8AC + 1) - (P1_SwitchTargetPC_0232B87C + 4)
P1_SwitchTable_0232B87CEnd:
loc_0232B898:
	ldr r0,[pool_0232B8B4]	; 0232B898
	bx lr	; 0232B89A
loc_0232B89C:
	mov r0,#0x0	; 0232B89C
	bx lr	; 0232B89E
loc_0232B8A0:
	ldr r0,[pool_0232B8B8]	; 0232B8A0
	bx lr	; 0232B8A2
loc_0232B8A4:
	ldr r0,[pool_0232B8BC]	; 0232B8A4
	bx lr	; 0232B8A6
loc_0232B8A8:
	ldr r0,[pool_0232B8C0]	; 0232B8A8
	bx lr	; 0232B8AA
loc_0232B8AC:
	ldr r0,[pool_0232B8C4]	; 0232B8AC
	bx lr	; 0232B8AE
loc_0232B8B0:
	mov r0,#0x0	; 0232B8B0
	bx lr	; 0232B8B2
pool_0232B8B4:
loc_0232B8B4:
	.word P1_P345DecodeWorkspaceEnd	; 0232B8B4
pool_0232B8B8:
loc_0232B8B8:
	.word 0x01FF8320	; 0232B8B8
pool_0232B8BC:
loc_0232B8BC:
	.word P1_DtcmRuntimeEnd	; 0232B8BC
pool_0232B8C0:
loc_0232B8C0:
	.word 0x027FF000	; 0232B8C0
pool_0232B8C4:
loc_0232B8C4:
	.word Arm7SharedWramStart	; 0232B8C4

; ===== function loc_0232B8C8 =====
loc_0232B8C8:
	cmp r0,#0x6	; 0232B8C8
	bhi loc_0232B922	; 0232B8CA
	add r0,r0,r0	; 0232B8CC
P1_SwitchIndexPC_0232B8CC:
	add r0,pc	; 0232B8CE
	ldrh r0,[r0,#(P1_SwitchTable_0232B8CC - (P1_SwitchIndexPC_0232B8CC + 4))]	; 0232B8D0
	lsl r0,r0,#0x10	; 0232B8D2
	asr r0,r0,#0x10	; 0232B8D4
P1_SwitchTargetPC_0232B8CC:
	add r0,pc	; 0232B8D6
	bx r0	; 0232B8D8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232B8CC:
	.halfword (loc_0232B8E8 + 1) - (P1_SwitchTargetPC_0232B8CC + 4)
	.halfword (loc_0232B922 + 1) - (P1_SwitchTargetPC_0232B8CC + 4)
	.halfword (loc_0232B8EC + 1) - (P1_SwitchTargetPC_0232B8CC + 4)
	.halfword (loc_0232B8F0 + 1) - (P1_SwitchTargetPC_0232B8CC + 4)
	.halfword (loc_0232B8F4 + 1) - (P1_SwitchTargetPC_0232B8CC + 4)
	.halfword (loc_0232B91A + 1) - (P1_SwitchTargetPC_0232B8CC + 4)
	.halfword (loc_0232B91E + 1) - (P1_SwitchTargetPC_0232B8CC + 4)
P1_SwitchTable_0232B8CCEnd:
loc_0232B8E8:
	ldr r0,[pool_0232B928]	; 0232B8E8
	bx lr	; 0232B8EA
loc_0232B8EC:
	mov r0,#0x0	; 0232B8EC
	bx lr	; 0232B8EE
loc_0232B8F0:
	ldr r0,[pool_0232B92C]	; 0232B8F0
	bx lr	; 0232B8F2
loc_0232B8F4:
	ldr r0,[pool_0232B930]	; 0232B8F4
	ldr r1,[pool_0232B934]	; 0232B8F6
	add r2,r0,r1	; 0232B8F8
	ldr r1,[pool_0232B938]	; 0232B8FA
	sub r2,r2,r1	; 0232B8FC
	ldr r1,[pool_0232B93C]	; 0232B8FE
	cmp r1,#0x0	; 0232B900
	bne loc_0232B90E	; 0232B902
	ldr r1,[pool_0232B940]	; 0232B904
	cmp r0,r1	; 0232B906
	bcs loc_0232B924	; 0232B908
	add r0,r1,#0x0	; 0232B90A
	bx lr	; 0232B90C
loc_0232B90E:
	cmp r1,#0x0	; 0232B90E
	bge loc_0232B916	; 0232B910
	sub r0,r0,r1	; 0232B912
	bx lr	; 0232B914
loc_0232B916:
	sub r0,r2,r1	; 0232B916
	bx lr	; 0232B918
loc_0232B91A:
	ldr r0,[pool_0232B944]	; 0232B91A
	bx lr	; 0232B91C
loc_0232B91E:
	ldr r0,[pool_0232B948]	; 0232B91E
	bx lr	; 0232B920
loc_0232B922:
	mov r0,#0x0	; 0232B922
loc_0232B924:
	bx lr	; 0232B924
	.byte 0xC0, 0x46	; 0232B928
pool_0232B928:
loc_0232B928:
	.word 0x023C0000	; 0232B928
pool_0232B92C:
loc_0232B92C:
	.word 0x02000000	; 0232B92C
pool_0232B930:
loc_0232B930:
	.word P1_DtcmRuntimeStart	; 0232B930
pool_0232B934:
loc_0232B934:
	.word 0x00003F80	; 0232B934
pool_0232B938:
loc_0232B938:
	.word 0x00001000	; 0232B938
pool_0232B93C:
loc_0232B93C:
	.word 0x00000000	; 0232B93C
pool_0232B940:
loc_0232B940:
	.word P1_DtcmRuntimeEnd	; 0232B940
pool_0232B944:
loc_0232B944:
	.word 0x027FF800	; 0232B944
pool_0232B948:
loc_0232B948:
	.word Arm7SharedWramStart	; 0232B948

; ===== function loc_0232B94C =====
loc_0232B94C:
	bx lr	; 0232B94C
	.byte 0x00, 0x00	; 0232B950

; ===== function loc_0232B950 =====
loc_0232B950:
	push {lr}	; 0232B950
	sub sp,#0x4	; 0232B952
	ldr r0,[pool_0232BA04]	; 0232B954
	ldr r1,[r0,#0x0]	; 0232B956
	cmp r1,#0x0	; 0232B958
	bne loc_0232B9FC	; 0232B95A
	mov r1,#0x1	; 0232B95C
	str r1,[r0,#0x0]	; 0232B95E
	mov r0,#0x0	; 0232B960
	bl loc_0232B8C8	; 0232B962
	add r1,r0,#0x0	; 0232B966
	mov r0,#0x0	; 0232B968
	bl loc_0232B86C	; 0232B96A
	mov r0,#0x0	; 0232B96E
	bl loc_0232B878	; 0232B970
	add r1,r0,#0x0	; 0232B974
	mov r0,#0x0	; 0232B976
	bl loc_0232B860	; 0232B978
	mov r0,#0x2	; 0232B97C
	mov r1,#0x0	; 0232B97E
	bl loc_0232B860	; 0232B980
	mov r0,#0x2	; 0232B984
	mov r1,#0x0	; 0232B986
	bl loc_0232B86C	; 0232B988
	mov r0,#0x3	; 0232B98C
	bl loc_0232B8C8	; 0232B98E
	add r1,r0,#0x0	; 0232B992
	mov r0,#0x3	; 0232B994
	bl loc_0232B86C	; 0232B996
	mov r0,#0x3	; 0232B99A
	bl loc_0232B878	; 0232B99C
	add r1,r0,#0x0	; 0232B9A0
	mov r0,#0x3	; 0232B9A2
	bl loc_0232B860	; 0232B9A4
	mov r0,#0x4	; 0232B9A8
	bl loc_0232B8C8	; 0232B9AA
	add r1,r0,#0x0	; 0232B9AE
	mov r0,#0x4	; 0232B9B0
	bl loc_0232B86C	; 0232B9B2
	mov r0,#0x4	; 0232B9B6
	bl loc_0232B878	; 0232B9B8
	add r1,r0,#0x0	; 0232B9BC
	mov r0,#0x4	; 0232B9BE
	bl loc_0232B860	; 0232B9C0
	mov r0,#0x5	; 0232B9C4
	bl loc_0232B8C8	; 0232B9C6
	add r1,r0,#0x0	; 0232B9CA
	mov r0,#0x5	; 0232B9CC
	bl loc_0232B86C	; 0232B9CE
	mov r0,#0x5	; 0232B9D2
	bl loc_0232B878	; 0232B9D4
	add r1,r0,#0x0	; 0232B9D8
	mov r0,#0x5	; 0232B9DA
	bl loc_0232B860	; 0232B9DC
	mov r0,#0x6	; 0232B9E0
	bl loc_0232B8C8	; 0232B9E2
	add r1,r0,#0x0	; 0232B9E6
	mov r0,#0x6	; 0232B9E8
	bl loc_0232B86C	; 0232B9EA
	mov r0,#0x6	; 0232B9EE
	bl loc_0232B878	; 0232B9F0
	add r1,r0,#0x0	; 0232B9F4
	mov r0,#0x6	; 0232B9F6
	bl loc_0232B860	; 0232B9F8
loc_0232B9FC:
	add sp,#0x4	; 0232B9FC
	pop {r3}	; 0232B9FE
	bx r3	; 0232BA00
	.byte 0xC0, 0x46	; 0232BA04
pool_0232BA04:
loc_0232BA04:
	.word P1_BssStart + 0x265C4	; 0232BA04
.arm

; ===== function loc_0232BA08 =====
; Sets CP15 control-register c1 bit 0. / 置位 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9SetCp15ControlBit0
loc_0232BA08:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BA08
	orr r0,r0,#0x1	; 0232BA0C
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BA10
	bx lr	; 0232BA14
.endfunc

; ===== function loc_0232BA18 =====
; Clears CP15 control-register c1 bit 0. / 清除 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9ClearCp15ControlBit0
loc_0232BA18:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BA18
	bic r0,r0,#0x1	; 0232BA1C
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BA20
	bx lr	; 0232BA24
.endfunc
; 链接既有调试入口；保存现场后处理 abort/undef，最后停在等待循环。
; Chain the saved debug handler; process abort/undef context, then stop in a wait loop.
.func P1_ExceptionEntry
	ldr r12,[pool_0232BA94]	; 0232BA28
	ldr r12,[r12,#0x0]	; 0232BA2C
	cmp r12,#0x0	; 0232BA30
	movne lr,pc	; 0232BA34
	bxne r12	; 0232BA38
	ldr r12,[pool_0232BA98]	; 0232BA3C
	stmdb r12!,{r0,r1,r2,r3,sp,lr}	; 0232BA40
	and r0,sp,#0x1	; 0232BA44
	mov sp,r12	; 0232BA48
	mrs r1,cpsr	; 0232BA4C
	and r1,r1,#0x1f	; 0232BA50
	teq r1,#0x17	; 0232BA54
	bne loc_0232BA64	; 0232BA58
	bl P1_ProcessException	; 0232BA5C
	b loc_0232BA70	; 0232BA60
loc_0232BA64:
	teq r1,#0x1b	; 0232BA64
	bne loc_0232BA70	; 0232BA68
	bl P1_ProcessException	; 0232BA6C
loc_0232BA70:
	ldr r12,[pool_0232BA94]	; 0232BA70
	ldr r12,[r12,#0x0]	; 0232BA74
	cmp r12,#0x0	; 0232BA78
loc_0232BA7C:
	beq loc_0232BA7C	; 0232BA7C
loc_0232BA80:
	mov r0,r0	; 0232BA80
	b loc_0232BA80	; 0232BA84
.endfunc
	.byte 0x0F, 0x50, 0xBD, 0xE8, 0x0C, 0xD0, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1	; 0232BA94
pool_0232BA94:
loc_0232BA94:
	.word P1_PreviousExceptionHandler	; 0232BA94
pool_0232BA98:
loc_0232BA98:
	.word P1_ExceptionStackTop	; 0232BA98

; ===== function loc_0232BA9C =====
loc_0232BA9C:
; 先保存异常现场，再调用已注册的用户处理器。
; Save exception context, then invoke the registered user handler.
.func P1_ProcessException
	stmdb sp!,{lr}	; 0232BA9C
	bl P1_SaveExceptionContext	; 0232BAA0
	bl P1_CallUserExceptionHandler	; 0232BAA4
	ldmia sp!,{lr}	; 0232BAA8
	bx lr	; 0232BAAC
.endfunc

; ===== function loc_0232BAB0 =====
loc_0232BAB0:
; 收集通用寄存器、异常栈与各模式的状态，写入 BSS 上下文。
; Collect registers, exception-stack data and mode state into the BSS context.
.func P1_SaveExceptionContext
	ldr r1,[pool_0232BB3C]	; 0232BAB0
	mrs r2,cpsr	; 0232BAB4
	str r2,[r1,#0x74]	; 0232BAB8
	str r0,[r1,#0x6c]	; 0232BABC
	ldr r0,[r12,#0x0]	; 0232BAC0
	str r0,[r1,#0x4]	; 0232BAC4
	ldr r0,[r12,#0x4]	; 0232BAC8
	str r0,[r1,#0x8]	; 0232BACC
	ldr r0,[r12,#0x8]	; 0232BAD0
	str r0,[r1,#0xc]	; 0232BAD4
	ldr r0,[r12,#0xc]	; 0232BAD8
	str r0,[r1,#0x10]	; 0232BADC
	ldr r2,[r12,#0x10]	; 0232BAE0
	bic r2,r2,#0x1	; 0232BAE4
	add r0,r1,#0x14	; 0232BAE8
	stmia r0,{r4,r5,r6,r7,r8,r9,r10,r11}	; 0232BAEC
	str r12,[r1,#0x70]	; 0232BAF0
	ldr r0,[r2,#0x0]	; 0232BAF4
	str r0,[r1,#0x64]	; 0232BAF8
	ldr r3,[r2,#0x4]	; 0232BAFC
	str r3,[r1,#0x0]	; 0232BB00
	ldr r0,[r2,#0x8]	; 0232BB04
	str r0,[r1,#0x34]	; 0232BB08
	ldr r0,[r2,#0xc]	; 0232BB0C
	str r0,[r1,#0x40]	; 0232BB10
	mrs r0,cpsr	; 0232BB14
	orr r3,r3,#0x80	; 0232BB18
	bic r3,r3,#0x20	; 0232BB1C
	msr cpsr_cxsf,r3	; 0232BB20
	str sp,[r1,#0x38]	; 0232BB24
	str lr,[r1,#0x3c]	; 0232BB28
	mrs r2,spsr	; 0232BB2C
	str r2,[r1,#0x7c]	; 0232BB30
	msr cpsr_cxsf,r0	; 0232BB34
	bx lr	; 0232BB38
.endfunc
pool_0232BB3C:
loc_0232BB3C:
	.word P1_ExceptionContext	; 0232BB3C

; ===== function loc_0232BB40 =====
loc_0232BB40:
; 若已注册，临时启用保护单元并以现场/参数调用用户回调。
; If registered, enable the MPU for the user callback with context and argument.
.func P1_CallUserExceptionHandler
	stmdb sp!,{lr}	; 0232BB40
	sub sp,sp,#0x4	; 0232BB44
	ldr r0,[pool_0232BB9C]	; 0232BB48
	ldr r0,[r0,#0x0]	; 0232BB4C
	cmp r0,#0x0	; 0232BB50
	addeq sp,sp,#0x4	; 0232BB54
	ldmeqia sp!,{lr}	; 0232BB58
	bxeq lr	; 0232BB5C
	mov r0,sp	; 0232BB60
	ldr r1,[pool_0232BBA0]	; 0232BB64
	msr cpsr_cxsf,r1	; 0232BB68
	mov sp,r0	; 0232BB6C
	bl P1_Arm9SetCp15ControlBit0	; 0232BB70
	ldr r1,[pool_0232BBA4]	; 0232BB74
	ldr r0,[pool_0232BB9C]	; 0232BB78
	ldr r1,[r1,#0x0]	; 0232BB7C
	ldr r2,[r0,#0x0]	; 0232BB80
	ldr r0,[pool_0232BBA8]	; 0232BB84
	blx r2	; 0232BB88
	bl P1_Arm9ClearCp15ControlBit0	; 0232BB8C
	add sp,sp,#0x4	; 0232BB90
	ldmia sp!,{lr}	; 0232BB94
	bx lr	; 0232BB98
.endfunc
pool_0232BB9C:
loc_0232BB9C:
	.word P1_UserExceptionHandler	; 0232BB9C
pool_0232BBA0:
loc_0232BBA0:
	.word 0x0000009F	; 0232BBA0
pool_0232BBA4:
loc_0232BBA4:
	.word P1_UserExceptionArgument	; 0232BBA4
pool_0232BBA8:
loc_0232BBA8:
	.word P1_ExceptionContext	; 0232BBA8
.thumb

; ===== function loc_0232BBAC =====
loc_0232BBAC:
; 检查既有调试入口；需要时同时安装 BIOS 向量和 DTCM 中的入口副本。
; Check the saved debug entry; install the BIOS vector and DTCM copy when required.
.func P1_InitExceptionHandler
	push {lr}	; 0232BBAC
	sub sp,#0x4	; 0232BBAE
	ldr r0,[pool_0232BBF8]	; 0232BBB0
	ldr r1,[r0,#0x0]	; 0232BBB2
	ldr r0,[pool_0232BBFC]	; 0232BBB4
	cmp r1,r0	; 0232BBB6
	bcc loc_0232BBC6	; 0232BBB8
	ldr r0,[pool_0232BC00]	; 0232BBBA
	cmp r1,r0	; 0232BBBC
	bcs loc_0232BBC6	; 0232BBBE
	ldr r0,[pool_0232BC04]	; 0232BBC0
	str r1,[r0,#0x0]	; 0232BBC2
	b loc_0232BBCC	; 0232BBC4
loc_0232BBC6:
	mov r1,#0x0	; 0232BBC6
	ldr r0,[pool_0232BC04]	; 0232BBC8
	str r1,[r0,#0x0]	; 0232BBCA
loc_0232BBCC:
	ldr r0,[pool_0232BC04]	; 0232BBCC
	ldr r0,[r0,#0x0]	; 0232BBCE
	cmp r0,#0x0	; 0232BBD0
	beq loc_0232BBE0	; 0232BBD2
	bl loc_0232B60C	; 0232BBD4
	ldr r1,[pool_0232BC08]	; 0232BBD8
	and r0,r1	; 0232BBDA
	cmp r0,#0x0	; 0232BBDC
	bne loc_0232BBEA	; 0232BBDE
loc_0232BBE0:
	ldr r1,[pool_0232BC0C]	; 0232BBE0
	ldr r0,[pool_0232BBF8]	; 0232BBE2
	str r1,[r0,#0x0]	; 0232BBE4
	ldr r0,[pool_0232BC10]	; 0232BBE6
	str r1,[r0,#0x5c]	; 0232BBE8
loc_0232BBEA:
	mov r1,#0x0	; 0232BBEA
	ldr r0,[pool_0232BC14]	; 0232BBEC
	str r1,[r0,#0x0]	; 0232BBEE
	add sp,#0x4	; 0232BBF0
	pop {r3}	; 0232BBF2
	bx r3	; 0232BBF4
.endfunc
	.byte 0xC0, 0x46	; 0232BBF8
pool_0232BBF8:
loc_0232BBF8:
	.word Bios9DebugVectorAddress	; 0232BBF8
pool_0232BBFC:
loc_0232BBFC:
	.word 0x02600000	; 0232BBFC
pool_0232BC00:
loc_0232BC00:
	.word 0x02800000	; 0232BC00
pool_0232BC04:
loc_0232BC04:
	.word P1_PreviousExceptionHandler	; 0232BC04
pool_0232BC08:
loc_0232BC08:
	.word 0x40000000	; 0232BC08
pool_0232BC0C:
loc_0232BC0C:
	.word P1_ExceptionEntry	; 0232BC0C
pool_0232BC10:
loc_0232BC10:
	.word P1_DtcmExceptionVector - 0x5C	; 0232BC10
pool_0232BC14:
loc_0232BC14:
	.word P1_UserExceptionHandler	; 0232BC14

; ===== function loc_0232BC18 =====
loc_0232BC18:
	ldr r1,[pool_0232BC28]	; 0232BC18
	ldrh r3,[r1,#0x0]	; 0232BC1A
	mov r2,#0x1	; 0232BC1C
	lsl r2,r0	; 0232BC1E
	orr r3,r2	; 0232BC20
	strh r3,[r1,#0x0]	; 0232BC22
	bx lr	; 0232BC24
	.byte 0xC0, 0x46	; 0232BC28
pool_0232BC28:
loc_0232BC28:
	.word P1_BssStart + 0x26654	; 0232BC28

; ===== function loc_0232BC2C =====
loc_0232BC2C:
	push {r4,r5,lr}	; 0232BC2C
	sub sp,#0xc	; 0232BC2E
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BC30
	ldr r1,[pool_0232BC94]	; 0232BC34
	ldrh r1,[r1,#0x0]	; 0232BC36
	add r3,sp,#0x0	; 0232BC38
	strh r1,[r3,#0x0]	; 0232BC3A
	ldr r1,[pool_0232BC98]	; 0232BC3C
	ldr r5,[r1,#0x0]	; 0232BC3E
	ldr r4,[r1,#0x4]	; 0232BC40
	ldr r1,[pool_0232BC9C]	; 0232BC42
	mov r2,#0x0	; 0232BC44
	and r4,r1	; 0232BC46
	bic r5,r2	; 0232BC48
	str r5,[sp,#0x4]	; 0232BC4A
	str r4,[sp,#0x8]	; 0232BC4C
	ldr r1,[pool_0232BCA0]	; 0232BC4E
	ldr r4,[r1,#0x0]	; 0232BC50
	mov r1,#0x8	; 0232BC52
	and r4,r1	; 0232BC54
	cmp r4,#0x0	; 0232BC56
	beq loc_0232BC72	; 0232BC58
	ldrh r3,[r3,#0x0]	; 0232BC5A
	ldr r1,[pool_0232BCA4]	; 0232BC5C
	and r3,r1	; 0232BC5E
	cmp r3,#0x0	; 0232BC60
	bne loc_0232BC72	; 0232BC62
	ldr r3,[sp,#0x4]	; 0232BC64
	ldr r4,[sp,#0x8]	; 0232BC66
	mov r1,#0x1	; 0232BC68
	add r1,r3,r1	; 0232BC6A
	adc r4,r2	; 0232BC6C
	str r1,[sp,#0x4]	; 0232BC6E
	str r4,[sp,#0x8]	; 0232BC70
loc_0232BC72:
	blx P1_Arm9RestoreIrqMask	; 0232BC72
	ldr r2,[sp,#0x4]	; 0232BC76
	ldr r1,[sp,#0x8]	; 0232BC78
	lsr r0,r2,#0x10	; 0232BC7A
	lsl r1,r1,#0x10	; 0232BC7C
	orr r1,r0	; 0232BC7E
	lsl r0,r2,#0x10	; 0232BC80
	add r2,sp,#0x0	; 0232BC82
	ldrh r3,[r2,#0x0]	; 0232BC84
	asr r2,r3,#0x1f	; 0232BC86
	orr r1,r2	; 0232BC88
	orr r0,r3	; 0232BC8A
	add sp,#0xc	; 0232BC8C
	pop {r4,r5}	; 0232BC8E
	pop {r3}	; 0232BC90
	bx r3	; 0232BC92
pool_0232BC94:
loc_0232BC94:
	.word TIMER0_DATA	; 0232BC94
pool_0232BC98:
loc_0232BC98:
	.word P1_BssStart + 0x26660	; 0232BC98
pool_0232BC9C:
loc_0232BC9C:
	.word 0x0000FFFF	; 0232BC9C
pool_0232BCA0:
loc_0232BCA0:
	.word REG_IF	; 0232BCA0
pool_0232BCA4:
loc_0232BCA4:
	.word 0x00008000	; 0232BCA4

; ===== function loc_0232BCA8 =====
P1_IrqHandler_0232BCA8:
	push {r4,lr}	; 0232BCA8
	ldr r1,[pool_0232BCE4]	; 0232BCAA
	ldr r2,[r1,#0x0]	; 0232BCAC
	ldr r4,[r1,#0x4]	; 0232BCAE
	mov r3,#0x0	; 0232BCB0
	mov r0,#0x1	; 0232BCB2
	add r0,r2,r0	; 0232BCB4
	adc r4,r3	; 0232BCB6
	str r0,[r1,#0x0]	; 0232BCB8
	str r4,[r1,#0x4]	; 0232BCBA
	ldr r0,[pool_0232BCE8]	; 0232BCBC
	ldr r1,[r0,#0x0]	; 0232BCBE
	cmp r1,#0x0	; 0232BCC0
	beq loc_0232BCD2	; 0232BCC2
	ldr r2,[pool_0232BCEC]	; 0232BCC4
	strh r3,[r2,#0x0]	; 0232BCC6
	ldr r1,[pool_0232BCF0]	; 0232BCC8
	strh r3,[r1,#0x0]	; 0232BCCA
	mov r1,#0xc1	; 0232BCCC
	strh r1,[r2,#0x0]	; 0232BCCE
	str r3,[r0,#0x0]	; 0232BCD0
loc_0232BCD2:
	mov r0,#0x0	; 0232BCD2
	ldr r1,[pool_0232BCF4]	; 0232BCD4
	add r2,r0,#0x0	; 0232BCD6
	bl loc_0232AD94	; 0232BCD8
	pop {r4}	; 0232BCDC
	pop {r3}	; 0232BCDE
	bx r3	; 0232BCE0
	.byte 0xC0, 0x46	; 0232BCE4
pool_0232BCE4:
loc_0232BCE4:
	.word P1_BssStart + 0x26660	; 0232BCE4
pool_0232BCE8:
loc_0232BCE8:
	.word P1_BssStart + 0x2665C	; 0232BCE8
pool_0232BCEC:
loc_0232BCEC:
	.word TIMER0_CR	; 0232BCEC
pool_0232BCF0:
loc_0232BCF0:
	.word TIMER0_DATA	; 0232BCF0
pool_0232BCF4:
loc_0232BCF4:
	.word P1_IrqHandler_0232BCA8 + 1	; 0232BCF4

; ===== function loc_0232BCF8 =====
loc_0232BCF8:
	push {lr}	; 0232BCF8
	sub sp,#0x4	; 0232BCFA
	ldr r0,[pool_0232BD3C]	; 0232BCFC
	ldrh r1,[r0,#0x0]	; 0232BCFE
	cmp r1,#0x0	; 0232BD00
	bne loc_0232BD36	; 0232BD02
	mov r1,#0x1	; 0232BD04
	strh r1,[r0,#0x0]	; 0232BD06
	mov r0,#0x0	; 0232BD08
	bl loc_0232BC18	; 0232BD0A
	mov r2,#0x0	; 0232BD0E
	ldr r0,[pool_0232BD40]	; 0232BD10
	str r2,[r0,#0x0]	; 0232BD12
	str r2,[r0,#0x4]	; 0232BD14
	ldr r1,[pool_0232BD44]	; 0232BD16
	strh r2,[r1,#0x0]	; 0232BD18
	ldr r0,[pool_0232BD48]	; 0232BD1A
	strh r2,[r0,#0x0]	; 0232BD1C
	mov r0,#0xc1	; 0232BD1E
	strh r0,[r1,#0x0]	; 0232BD20
	mov r0,#0x8	; 0232BD22
	ldr r1,[pool_0232BD4C]	; 0232BD24
	bl loc_0232ADC8	; 0232BD26
	mov r0,#0x8	; 0232BD2A
	bl loc_0232AD44	; 0232BD2C
	mov r1,#0x0	; 0232BD30
	ldr r0,[pool_0232BD50]	; 0232BD32
	str r1,[r0,#0x0]	; 0232BD34
loc_0232BD36:
	add sp,#0x4	; 0232BD36
	pop {r3}	; 0232BD38
	bx r3	; 0232BD3A
pool_0232BD3C:
loc_0232BD3C:
	.word P1_BssStart + 0x26658	; 0232BD3C
pool_0232BD40:
loc_0232BD40:
	.word P1_BssStart + 0x26660	; 0232BD40
pool_0232BD44:
loc_0232BD44:
	.word TIMER0_CR	; 0232BD44
pool_0232BD48:
loc_0232BD48:
	.word TIMER0_DATA	; 0232BD48
pool_0232BD4C:
loc_0232BD4C:
	.word P1_IrqHandler_0232BCA8 + 1	; 0232BD4C
pool_0232BD50:
loc_0232BD50:
	.word P1_BssStart + 0x2665C	; 0232BD50
.arm
	stmdb sp!,{lr}	; 0232BD54
	blx loc_0232BDB8	; 0232BD58
	ldmia sp!,{lr}	; 0232BD5C
	bx lr	; 0232BD60
.thumb

; ===== function loc_0232BD64 =====
	push {r4,r5,r6,r7,lr}	; 0232BD64
	sub sp,#0x4	; 0232BD66
	add r5,r0,#0x0	; 0232BD68
	cmp r5,#0x0	; 0232BD6A
	beq loc_0232BDA8	; 0232BD6C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BD6E
	add r7,r0,#0x0	; 0232BD72
	ldr r0,[pool_0232BDB0]	; 0232BD74
	ldr r0,[r0,#0x0]	; 0232BD76
	cmp r0,#0x0	; 0232BD78
	beq loc_0232BD80	; 0232BD7A
	ldr r4,[r0,#0x18]	; 0232BD7C
	b loc_0232BD82	; 0232BD7E
loc_0232BD80:
	mov r4,#0x0	; 0232BD80
loc_0232BD82:
	cmp r0,#0x0	; 0232BD82
	beq loc_0232BDA2	; 0232BD84
	mov r6,#0x0	; 0232BD86
loc_0232BD88:
	ldr r1,[r0,#0x8]	; 0232BD88
	cmp r1,r5	; 0232BD8A
	bne loc_0232BD92	; 0232BD8C
	bl loc_0232BE68	; 0232BD8E
loc_0232BD92:
	add r0,r4,#0x0	; 0232BD92
	cmp r4,#0x0	; 0232BD94
	beq loc_0232BD9C	; 0232BD96
	ldr r4,[r4,#0x18]	; 0232BD98
	b loc_0232BD9E	; 0232BD9A
loc_0232BD9C:
	add r4,r6,#0x0	; 0232BD9C
loc_0232BD9E:
	cmp r0,#0x0	; 0232BD9E
	bne loc_0232BD88	; 0232BDA0
loc_0232BDA2:
	add r0,r7,#0x0	; 0232BDA2
	blx P1_Arm9RestoreIrqMask	; 0232BDA4
loc_0232BDA8:
	add sp,#0x4	; 0232BDA8
	pop {r4,r5,r6,r7}	; 0232BDAA
	pop {r3}	; 0232BDAC
	bx r3	; 0232BDAE
pool_0232BDB0:
loc_0232BDB0:
	.word P1_BssStart + 0x2666C	; 0232BDB0
	.byte 0x81, 0x60, 0x70, 0x47	; 0232BDB8

; ===== function loc_0232BDB8 =====
loc_0232BDB8:
	push {r4,r5,lr}	; 0232BDB8
	sub sp,#0x4	; 0232BDBA
	mov r1,#0x0	; 0232BDBC
	ldr r0,[pool_0232BE58]	; 0232BDBE
	strh r1,[r0,#0x0]	; 0232BDC0
	mov r0,#0x10	; 0232BDC2
	bl loc_0232AD1C	; 0232BDC4
	ldr r1,[pool_0232BE5C]	; 0232BDC8
	ldr r0,[pool_0232BE60]	; 0232BDCA
	add r2,r1,r0	; 0232BDCC
	ldr r1,[r2,#0x0]	; 0232BDCE
	mov r0,#0x10	; 0232BDD0
	orr r1,r0	; 0232BDD2
	str r1,[r2,#0x0]	; 0232BDD4
	bl loc_0232BC2C	; 0232BDD6
	ldr r2,[pool_0232BE64]	; 0232BDDA
	ldr r4,[r2,#0x0]	; 0232BDDC
	cmp r4,#0x0	; 0232BDDE
	beq loc_0232BE4E	; 0232BDE0
	ldr r5,[r4,#0xc]	; 0232BDE2
	ldr r3,[r4,#0x10]	; 0232BDE4
	sub r0,r0,r5	; 0232BDE6
	sbc r1,r3	; 0232BDE8
	bcs loc_0232BDFA	; 0232BDEA
	add r0,r4,#0x0	; 0232BDEC
	bl loc_0232C028	; 0232BDEE
	add sp,#0x4	; 0232BDF2
	pop {r4,r5}	; 0232BDF4
	pop {r3}	; 0232BDF6
	bx r3	; 0232BDF8
loc_0232BDFA:
	ldr r1,[r4,#0x18]	; 0232BDFA
	str r1,[r2,#0x0]	; 0232BDFC
	cmp r1,#0x0	; 0232BDFE
	bne loc_0232BE08	; 0232BE00
	mov r0,#0x0	; 0232BE02
	str r0,[r2,#0x4]	; 0232BE04
	b loc_0232BE0C	; 0232BE06
loc_0232BE08:
	mov r0,#0x0	; 0232BE08
	str r0,[r1,#0x14]	; 0232BE0A
loc_0232BE0C:
	ldr r5,[r4,#0x0]	; 0232BE0C
	ldr r2,[r4,#0x1c]	; 0232BE0E
	ldr r1,[r4,#0x20]	; 0232BE10
	mov r0,#0x0	; 0232BE12
	eor r1,r0	; 0232BE14
	eor r2,r0	; 0232BE16
	orr r1,r2	; 0232BE18
	bne loc_0232BE20	; 0232BE1A
	mov r0,#0x0	; 0232BE1C
	str r0,[r4,#0x0]	; 0232BE1E
loc_0232BE20:
	cmp r5,#0x0	; 0232BE20
	beq loc_0232BE28	; 0232BE22
	ldr r0,[r4,#0x4]	; 0232BE24
	blx r5	; 0232BE26
loc_0232BE28:
	ldr r2,[r4,#0x1c]	; 0232BE28
	ldr r1,[r4,#0x20]	; 0232BE2A
	mov r0,#0x0	; 0232BE2C
	eor r1,r0	; 0232BE2E
	eor r2,r0	; 0232BE30
	orr r1,r2	; 0232BE32
	beq loc_0232BE42	; 0232BE34
	str r5,[r4,#0x0]	; 0232BE36
	add r0,r4,#0x0	; 0232BE38
	mov r1,#0x0	; 0232BE3A
	add r2,r1,#0x0	; 0232BE3C
	bl loc_0232BF18	; 0232BE3E
loc_0232BE42:
	ldr r0,[pool_0232BE64]	; 0232BE42
	ldr r0,[r0,#0x0]	; 0232BE44
	cmp r0,#0x0	; 0232BE46
	beq loc_0232BE4E	; 0232BE48
	bl loc_0232C028	; 0232BE4A
loc_0232BE4E:
	add sp,#0x4	; 0232BE4E
	pop {r4,r5}	; 0232BE50
	pop {r3}	; 0232BE52
	bx r3	; 0232BE54
	.byte 0xC0, 0x46	; 0232BE58
pool_0232BE58:
loc_0232BE58:
	.word TIMER1_CR	; 0232BE58
pool_0232BE5C:
loc_0232BE5C:
	.word P1_DtcmRuntimeStart	; 0232BE5C
pool_0232BE60:
loc_0232BE60:
	.word 0x00003FF8	; 0232BE60
pool_0232BE64:
loc_0232BE64:
	.word P1_BssStart + 0x2666C	; 0232BE64

; ===== function loc_0232BE68 =====
loc_0232BE68:
	push {r4,r5,lr}	; 0232BE68
	sub sp,#0x4	; 0232BE6A
	add r5,r0,#0x0	; 0232BE6C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BE6E
	add r4,r0,#0x0	; 0232BE72
	ldr r1,[r5,#0x0]	; 0232BE74
	cmp r1,#0x0	; 0232BE76
	bne loc_0232BE86	; 0232BE78
	blx P1_Arm9RestoreIrqMask	; 0232BE7A
	add sp,#0x4	; 0232BE7E
	pop {r4,r5}	; 0232BE80
	pop {r3}	; 0232BE82
	bx r3	; 0232BE84
loc_0232BE86:
	ldr r0,[r5,#0x18]	; 0232BE86
	cmp r0,#0x0	; 0232BE88
	bne loc_0232BE94	; 0232BE8A
	ldr r2,[r5,#0x14]	; 0232BE8C
	ldr r1,[pool_0232BEC4]	; 0232BE8E
	str r2,[r1,#0x4]	; 0232BE90
	b loc_0232BE98	; 0232BE92
loc_0232BE94:
	ldr r1,[r5,#0x14]	; 0232BE94
	str r1,[r0,#0x14]	; 0232BE96
loc_0232BE98:
	ldr r1,[r5,#0x14]	; 0232BE98
	cmp r1,#0x0	; 0232BE9A
	beq loc_0232BEA2	; 0232BE9C
	str r0,[r1,#0x18]	; 0232BE9E
	b loc_0232BEAE	; 0232BEA0
loc_0232BEA2:
	ldr r1,[pool_0232BEC4]	; 0232BEA2
	str r0,[r1,#0x0]	; 0232BEA4
	cmp r0,#0x0	; 0232BEA6
	beq loc_0232BEAE	; 0232BEA8
	bl loc_0232C028	; 0232BEAA
loc_0232BEAE:
	mov r0,#0x0	; 0232BEAE
	str r0,[r5,#0x0]	; 0232BEB0
	str r0,[r5,#0x1c]	; 0232BEB2
	str r0,[r5,#0x20]	; 0232BEB4
	add r0,r4,#0x0	; 0232BEB6
	blx P1_Arm9RestoreIrqMask	; 0232BEB8
	add sp,#0x4	; 0232BEBC
	pop {r4,r5}	; 0232BEBE
	pop {r3}	; 0232BEC0
	bx r3	; 0232BEC2
pool_0232BEC4:
loc_0232BEC4:
	.word P1_BssStart + 0x2666C	; 0232BEC4
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x14, 0x1C, 0x1F, 0x1C, 0x00, 0x2D, 0x02, 0xD0	; 0232BED8
	.byte 0x28, 0x68, 0x00, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x37, 0xF9, 0x00, 0xF0, 0xF8, 0xE8, 0x00, 0x90	; 0232BEE8
	.byte 0x00, 0x20, 0xE8, 0x61, 0x28, 0x62, 0x2F, 0x60, 0x06, 0x98, 0x68, 0x60, 0xFF, 0xF7, 0x9A, 0xFE	; 0232BEF8
	.byte 0x02, 0x1C, 0x28, 0x1C, 0xB2, 0x18, 0x4C, 0x41, 0x11, 0x1C, 0x22, 0x1C, 0x00, 0xF0, 0x08, 0xF8	; 0232BF08
	.byte 0x00, 0x98, 0x00, 0xF0, 0xEE, 0xE8, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 0232BF18

; ===== function loc_0232BF18 =====
loc_0232BF18:
	push {r4,r5,r6,r7,lr}	; 0232BF18
	sub sp,#0xc	; 0232BF1A
	add r5,r0,#0x0	; 0232BF1C
	add r4,r1,#0x0	; 0232BF1E
	add r6,r2,#0x0	; 0232BF20
	ldr r2,[r5,#0x1c]	; 0232BF22
	ldr r1,[r5,#0x20]	; 0232BF24
	mov r0,#0x0	; 0232BF26
	eor r1,r0	; 0232BF28
	eor r2,r0	; 0232BF2A
	orr r1,r2	; 0232BF2C
	beq loc_0232BF72	; 0232BF2E
	bl loc_0232BC2C	; 0232BF30
	ldr r4,[r5,#0x24]	; 0232BF34
	ldr r6,[r5,#0x28]	; 0232BF36
	sub r2,r4,r0	; 0232BF38
	lsl r2,r6,#0	; 0232BF3A
	sbc r2,r1	; 0232BF3C
	bcs loc_0232BF72	; 0232BF3E
	ldr r2,[r5,#0x1c]	; 0232BF40
	str r2,[sp,#0x0]	; 0232BF42
	ldr r2,[r5,#0x20]	; 0232BF44
	str r2,[sp,#0x4]	; 0232BF46
	sub r0,r0,r4	; 0232BF48
	sbc r1,r6	; 0232BF4A
	ldr r2,[sp,#0x0]	; 0232BF4C
	ldr r3,[sp,#0x4]	; 0232BF4E
	blx loc_0232C72C	; 0232BF50
	str r0,[sp,#0x8]	; 0232BF54
	add r7,r1,#0x0	; 0232BF56
	ldr r0,[sp,#0x0]	; 0232BF58
	ldr r1,[sp,#0x4]	; 0232BF5A
	mov r3,#0x1	; 0232BF5C
	ldr r2,[sp,#0x8]	; 0232BF5E
	add r3,r2,r3	; 0232BF60
	mov r2,#0x0	; 0232BF62
	adc r7,r2	; 0232BF64
	add r2,r3,#0x0	; 0232BF66
	add r3,r7,#0x0	; 0232BF68
	blx P1_AeabiLmul	; 0232BF6A
	add r4,r4,r0	; 0232BF6E
	adc r6,r1	; 0232BF70
loc_0232BF72:
	str r4,[r5,#0xc]	; 0232BF72
	str r6,[r5,#0x10]	; 0232BF74
	ldr r0,[pool_0232BFEC]	; 0232BF76
	ldr r3,[r0,#0x0]	; 0232BF78
	cmp r3,#0x0	; 0232BF7A
	beq loc_0232BFC0	; 0232BF7C
loc_0232BF7E:
	ldr r1,[r3,#0xc]	; 0232BF7E
	ldr r0,[r3,#0x10]	; 0232BF80
	sub r2,r4,r1	; 0232BF82
	lsl r1,r6,#0	; 0232BF84
	sbc r1,r0	; 0232BF86
	mov r0,#0x0	; 0232BF88
	sub r2,r2,r0	; 0232BF8A
	sbc r1,r0	; 0232BF8C
	bge loc_0232BFBA	; 0232BF8E
	ldr r0,[r3,#0x14]	; 0232BF90
	str r0,[r5,#0x14]	; 0232BF92
	str r5,[r3,#0x14]	; 0232BF94
	str r3,[r5,#0x18]	; 0232BF96
	ldr r0,[r5,#0x14]	; 0232BF98
	cmp r0,#0x0	; 0232BF9A
	beq loc_0232BFA8	; 0232BF9C
	str r5,[r0,#0x18]	; 0232BF9E
	add sp,#0xc	; 0232BFA0
	pop {r4,r5,r6,r7}	; 0232BFA2
	pop {r3}	; 0232BFA4
	bx r3	; 0232BFA6
loc_0232BFA8:
	ldr r0,[pool_0232BFEC]	; 0232BFA8
	str r5,[r0,#0x0]	; 0232BFAA
	add r0,r5,#0x0	; 0232BFAC
	bl loc_0232C028	; 0232BFAE
	add sp,#0xc	; 0232BFB2
	pop {r4,r5,r6,r7}	; 0232BFB4
	pop {r3}	; 0232BFB6
	bx r3	; 0232BFB8
loc_0232BFBA:
	ldr r3,[r3,#0x18]	; 0232BFBA
	cmp r3,#0x0	; 0232BFBC
	bne loc_0232BF7E	; 0232BFBE
loc_0232BFC0:
	mov r0,#0x0	; 0232BFC0
	str r0,[r5,#0x18]	; 0232BFC2
	ldr r0,[pool_0232BFEC]	; 0232BFC4
	ldr r1,[r0,#0x4]	; 0232BFC6
	str r5,[r0,#0x4]	; 0232BFC8
	str r1,[r5,#0x14]	; 0232BFCA
	cmp r1,#0x0	; 0232BFCC
	beq loc_0232BFDA	; 0232BFCE
	str r5,[r1,#0x18]	; 0232BFD0
	add sp,#0xc	; 0232BFD2
	pop {r4,r5,r6,r7}	; 0232BFD4
	pop {r3}	; 0232BFD6
	bx r3	; 0232BFD8
loc_0232BFDA:
	str r5,[r0,#0x4]	; 0232BFDA
	str r5,[r0,#0x0]	; 0232BFDC
	add r0,r5,#0x0	; 0232BFDE
	bl loc_0232C028	; 0232BFE0
	add sp,#0xc	; 0232BFE4
	pop {r4,r5,r6,r7}	; 0232BFE6
	pop {r3}	; 0232BFE8
	bx r3	; 0232BFEA
pool_0232BFEC:
loc_0232BFEC:
	.word P1_BssStart + 0x2666C	; 0232BFEC
	.byte 0x00, 0x21, 0x01, 0x60, 0x81, 0x60, 0x70, 0x47	; 0232BFF8

; ===== function loc_0232BFF8 =====
	push {lr}	; 0232BFF8
	sub sp,#0x4	; 0232BFFA
	ldr r1,[pool_0232C020]	; 0232BFFC
	ldrh r0,[r1,#0x0]	; 0232BFFE
	cmp r0,#0x0	; 0232C000
	bne loc_0232C01A	; 0232C002
	mov r0,#0x1	; 0232C004
	strh r0,[r1,#0x0]	; 0232C006
	bl loc_0232BC18	; 0232C008
	mov r1,#0x0	; 0232C00C
	ldr r0,[pool_0232C024]	; 0232C00E
	str r1,[r0,#0x0]	; 0232C010
	str r1,[r0,#0x4]	; 0232C012
	mov r0,#0x10	; 0232C014
	bl loc_0232AD1C	; 0232C016
loc_0232C01A:
	add sp,#0x4	; 0232C01A
	pop {r3}	; 0232C01C
	bx r3	; 0232C01E
pool_0232C020:
loc_0232C020:
	.word P1_BssStart + 0x26668	; 0232C020
pool_0232C024:
loc_0232C024:
	.word P1_BssStart + 0x2666C	; 0232C024

; ===== function loc_0232C028 =====
loc_0232C028:
	push {r4,r5,lr}	; 0232C028
	sub sp,#0x4	; 0232C02A
	add r4,r0,#0x0	; 0232C02C
	bl loc_0232BC2C	; 0232C02E
	mov r2,#0x0	; 0232C032
	ldr r3,[pool_0232C080]	; 0232C034
	strh r2,[r3,#0x0]	; 0232C036
	ldr r3,[r4,#0xc]	; 0232C038
	ldr r4,[r4,#0x10]	; 0232C03A
	sub r5,r3,r0	; 0232C03C
	sbc r4,r1	; 0232C03E
	mov r0,#0x1	; 0232C040
	ldr r1,[pool_0232C084]	; 0232C042
	bl loc_0232AD94	; 0232C044
	mov r1,#0x0	; 0232C048
	sub r0,r5,r1	; 0232C04A
	lsl r0,r4,#0	; 0232C04C
	sbc r0,r1	; 0232C04E
	bge loc_0232C056	; 0232C050
	ldr r1,[pool_0232C088]	; 0232C052
	b loc_0232C068	; 0232C054
loc_0232C056:
	ldr r0,[pool_0232C08C]	; 0232C056
	sub r0,r5,r0	; 0232C058
	sbc r4,r1	; 0232C05A
	bge loc_0232C066	; 0232C05C
	mvn r0,r5	; 0232C05E
	lsl r0,r0,#0x10	; 0232C060
	lsr r1,r0,#0x10	; 0232C062
	b loc_0232C068	; 0232C064
loc_0232C066:
	mov r1,#0x0	; 0232C066
loc_0232C068:
	ldr r0,[pool_0232C090]	; 0232C068
	strh r1,[r0,#0x0]	; 0232C06A
	mov r1,#0xc1	; 0232C06C
	ldr r0,[pool_0232C080]	; 0232C06E
	strh r1,[r0,#0x0]	; 0232C070
	mov r0,#0x10	; 0232C072
	bl loc_0232AD44	; 0232C074
	add sp,#0x4	; 0232C078
	pop {r4,r5}	; 0232C07A
	pop {r3}	; 0232C07C
	bx r3	; 0232C07E
pool_0232C080:
loc_0232C080:
	.word TIMER1_CR	; 0232C080
pool_0232C084:
loc_0232C084:
	.word 0x0232BD54	; 0232C084
pool_0232C088:
loc_0232C088:
	.word 0x0000FFFE	; 0232C088
pool_0232C08C:
loc_0232C08C:
	.word 0x00010000	; 0232C08C
pool_0232C090:
loc_0232C090:
	.word TIMER1_DATA	; 0232C090

; ===== function loc_0232C094 =====
loc_0232C094:
	push {lr}	; 0232C094
	sub sp,#0x4	; 0232C096
	ldr r0,[pool_0232C0B8]	; 0232C098
	ldrh r1,[r0,#0x0]	; 0232C09A
	cmp r1,#0x0	; 0232C09C
	bne loc_0232C0B2	; 0232C09E
	mov r1,#0x1	; 0232C0A0
	strh r1,[r0,#0x0]	; 0232C0A2
	mov r1,#0x0	; 0232C0A4
	ldr r0,[pool_0232C0BC]	; 0232C0A6
	str r1,[r0,#0x0]	; 0232C0A8
	str r1,[r0,#0x4]	; 0232C0AA
	mov r0,#0x4	; 0232C0AC
	bl loc_0232AD1C	; 0232C0AE
loc_0232C0B2:
	add sp,#0x4	; 0232C0B2
	pop {r3}	; 0232C0B4
	bx r3	; 0232C0B6
pool_0232C0B8:
loc_0232C0B8:
	.word P1_BssStart + 0x26674	; 0232C0B8
pool_0232C0BC:
loc_0232C0BC:
	.word P1_BssStart + 0x26678	; 0232C0BC
.arm

; ===== function loc_0232C0C0 =====
; Clears CPSR I and returns the former I mask. / 清除 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9EnableIrqReturnPriorMask
loc_0232C0C0:
	mrs r0,cpsr	; 0232C0C0
	bic r1,r0,#0x80	; 0232C0C4
	msr cpsr_c,r1	; 0232C0C8
	and r0,r0,#0x80	; 0232C0CC
	bx lr	; 0232C0D0
.endfunc

; ===== function loc_0232C0D4 =====
; Sets CPSR I and returns the former I mask. / 设置 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9DisableIrqReturnPriorMask
loc_0232C0D4:
	mrs r0,cpsr	; 0232C0D4
	orr r1,r0,#0x80	; 0232C0D8
	msr cpsr_c,r1	; 0232C0DC
	and r0,r0,#0x80	; 0232C0E0
	bx lr	; 0232C0E4
.endfunc

; ===== function loc_0232C0E8 =====
; Restores CPSR I from r0 and returns the prior mask. / 按 r0 恢复 CPSR I 位并返回先前掩码。
.func P1_Arm9RestoreIrqMask
loc_0232C0E8:
	mrs r1,cpsr	; 0232C0E8
	bic r2,r1,#0x80	; 0232C0EC
	orr r2,r2,r0	; 0232C0F0
	msr cpsr_c,r2	; 0232C0F4
	and r0,r1,#0x80	; 0232C0F8
	bx lr	; 0232C0FC
.endfunc

; ===== function loc_0232C100 =====
; Sets CPSR I/F and returns the former masks. / 设置 CPSR I/F 位并返回先前掩码。
.func P1_Arm9DisableIrqFiqReturnPriorMasks
loc_0232C100:
	mrs r0,cpsr	; 0232C100
	orr r1,r0,#0xc0	; 0232C104
	msr cpsr_c,r1	; 0232C108
	and r0,r0,#0xc0	; 0232C10C
	bx lr	; 0232C110
.endfunc

; ===== function loc_0232C114 =====
; Restores CPSR I/F from r0 and returns prior masks. / 按 r0 恢复 CPSR I/F 位并返回先前掩码。
.func P1_Arm9RestoreIrqFiqMasks
loc_0232C114:
	mrs r1,cpsr	; 0232C114
	bic r2,r1,#0xc0	; 0232C118
	orr r2,r2,r0	; 0232C11C
	msr cpsr_c,r2	; 0232C120
	and r0,r1,#0xc0	; 0232C124
	bx lr	; 0232C128
.endfunc

; ===== function loc_0232C12C =====
; Returns the CPSR processor-mode bits. / 返回 CPSR 的处理器模式位。
.func P1_Arm9GetProcessorMode
loc_0232C12C:
	mrs r0,cpsr	; 0232C12C
	and r0,r0,#0x1f	; 0232C130
	bx lr	; 0232C134
.endfunc

; ===== function loc_0232C138 =====
; ARM946 CP15 wait-for-interrupt helper. / ARM946 CP15 等待中断帮助例程。
.func P1_Arm9WaitForInterrupt
loc_0232C138:
	mov r0,#0x0	; 0232C138
	mcr p15,0x0,r0,c7,c0,0x4	; 0232C13C
	bx lr	; 0232C140
.endfunc

; ===== function loc_0232C144 =====
; Decrements r0 by four until borrow. / 每次将 r0 减四，直至产生借位。
.func P1_Arm9BusyWaitByLoop4
loc_0232C144:
	subs r0,r0,#0x4	; 0232C144
	bcs loc_0232C144	; 0232C148
	bx lr	; 0232C14C
.endfunc
.thumb

; ===== function loc_0232C150 =====
loc_0232C150:
	push {lr}	; 0232C150
	sub sp,#0x4	; 0232C152
loc_0232C154:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C154
	blx P1_Arm9WaitForInterrupt	; 0232C158
	b loc_0232C154	; 0232C15C
	.byte 0x00, 0x00, 0x01, 0x1C, 0x02, 0x48, 0x06, 0x22, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFC	; 0232C16E
	.byte 0x7F, 0x02, 0xE0, 0xE3, 0x32, 0x02	; 0232C174

; ===== function loc_0232C174 =====
loc_0232C174:
	push {r4,lr}	; 0232C174
	add r4,r1,#0x0	; 0232C176
	ldr r1,[r4,#0x0]	; 0232C178
	cmp r1,#0x0	; 0232C17A
	bne loc_0232C182	; 0232C17C
	bl loc_0232AE38	; 0232C17E
loc_0232C182:
	ldr r0,[r4,#0x4]	; 0232C182
	blx P1_Arm9RestoreIrqMask	; 0232C184
	pop {r4}	; 0232C188
	pop {r3}	; 0232C18A
	bx r3	; 0232C18C
	.byte 0x00, 0x00	; 0232C190

; ===== function loc_0232C190 =====
loc_0232C190:
	push {r4,r5,r6,r7,lr}	; 0232C190
	sub sp,#0x4	; 0232C192
	add r5,r0,#0x0	; 0232C194
	add r4,r1,#0x0	; 0232C196
	ldr r7,[pool_0232C1D4]	; 0232C198
	mov r6,#0x40	; 0232C19A
loc_0232C19C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C19C
	str r0,[r4,#0x4]	; 0232C1A0
	add r0,r7,#0x0	; 0232C1A2
	bl loc_0232AEE0	; 0232C1A4
	and r0,r6	; 0232C1A8
	str r0,[r4,#0x0]	; 0232C1AA
	ldr r0,[r4,#0x0]	; 0232C1AC
	cmp r0,#0x0	; 0232C1AE
	bne loc_0232C1CA	; 0232C1B0
	add r0,r5,#0x0	; 0232C1B2
	bl loc_0232AF68	; 0232C1B4
	cmp r0,#0x0	; 0232C1B8
	beq loc_0232C1CA	; 0232C1BA
	ldr r0,[r4,#0x4]	; 0232C1BC
	blx P1_Arm9RestoreIrqMask	; 0232C1BE
	mov r0,#0x1	; 0232C1C2
	bl loc_0232C3D4	; 0232C1C4
	b loc_0232C19C	; 0232C1C8
loc_0232C1CA:
	add sp,#0x4	; 0232C1CA
	pop {r4,r5,r6,r7}	; 0232C1CC
	pop {r3}	; 0232C1CE
	bx r3	; 0232C1D0
	.byte 0xC0, 0x46	; 0232C1D4
pool_0232C1D4:
loc_0232C1D4:
	.word 0x027FFFE8	; 0232C1D4

; ===== function loc_0232C1D8 =====
loc_0232C1D8:
	push {r4}	; 0232C1D8
	sub sp,#0x4	; 0232C1DA
	ldr r4,[r0,#0x0]	; 0232C1DC
	ldr r3,[pool_0232C200]	; 0232C1DE
	ldrh r2,[r3,#0x0]	; 0232C1E0
	mov r1,#0xc	; 0232C1E2
	bic r2,r1	; 0232C1E4
	lsl r1,r4,#0x2	; 0232C1E6
	orr r2,r1	; 0232C1E8
	strh r2,[r3,#0x0]	; 0232C1EA
	ldr r2,[r0,#0x4]	; 0232C1EC
	ldrh r1,[r3,#0x0]	; 0232C1EE
	mov r0,#0x10	; 0232C1F0
	bic r1,r0	; 0232C1F2
	lsl r0,r2,#0x4	; 0232C1F4
	orr r1,r0	; 0232C1F6
	strh r1,[r3,#0x0]	; 0232C1F8
	add sp,#0x4	; 0232C1FA
	pop {r4}	; 0232C1FC
	bx lr	; 0232C1FE
pool_0232C200:
loc_0232C200:
	.word REG_EXMEMCNT_ARM9	; 0232C200

; ===== function loc_0232C204 =====
loc_0232C204:
	push {r4}	; 0232C204
	sub sp,#0x4	; 0232C206
	ldr r4,[pool_0232C234]	; 0232C208
	ldrh r2,[r4,#0x0]	; 0232C20A
	mov r1,#0xc	; 0232C20C
	and r2,r1	; 0232C20E
	asr r2,r2,#0x2	; 0232C210
	str r2,[r0,#0x0]	; 0232C212
	ldrh r3,[r4,#0x0]	; 0232C214
	mov r2,#0x10	; 0232C216
	and r3,r2	; 0232C218
	asr r3,r3,#0x4	; 0232C21A
	str r3,[r0,#0x4]	; 0232C21C
	ldrh r0,[r4,#0x0]	; 0232C21E
	bic r0,r1	; 0232C220
	orr r0,r1	; 0232C222
	strh r0,[r4,#0x0]	; 0232C224
	ldrh r0,[r4,#0x0]	; 0232C226
	bic r0,r2	; 0232C228
	strh r0,[r4,#0x0]	; 0232C22A
	add sp,#0x4	; 0232C22C
	pop {r4}	; 0232C22E
	bx lr	; 0232C230
	.byte 0xC0, 0x46	; 0232C234
pool_0232C234:
loc_0232C234:
	.word REG_EXMEMCNT_ARM9	; 0232C234

; ===== function loc_0232C238 =====
loc_0232C238:
	push {r4,lr}	; 0232C238
	sub sp,#0x10	; 0232C23A
	mov r4,#0x1	; 0232C23C
	ldr r2,[pool_0232C2E0]	; 0232C23E
	ldrh r1,[r2,#0x0]	; 0232C240
	ldr r0,[pool_0232C2E4]	; 0232C242
	cmp r1,r0	; 0232C244
	bne loc_0232C252	; 0232C246
	mov r0,#0x0	; 0232C248
	add sp,#0x10	; 0232C24A
	pop {r4}	; 0232C24C
	pop {r3}	; 0232C24E
	bx r3	; 0232C250
loc_0232C252:
	ldrb r0,[r2,#0x5]	; 0232C252
	lsl r0,r0,#0x1e	; 0232C254
	lsr r0,r0,#0x1f	; 0232C256
	cmp r0,#0x1	; 0232C258
	bne loc_0232C266	; 0232C25A
	mov r0,#0x0	; 0232C25C
	add sp,#0x10	; 0232C25E
	pop {r4}	; 0232C260
	pop {r3}	; 0232C262
	bx r3	; 0232C264
loc_0232C266:
	ldr r0,[pool_0232C2E8]	; 0232C266
	ldrh r0,[r0,#0x2]	; 0232C268
	add r1,sp,#0x0	; 0232C26A
	bl loc_0232C190	; 0232C26C
	add r0,sp,#0x8	; 0232C270
	bl loc_0232C204	; 0232C272
	ldr r2,[pool_0232C2EC]	; 0232C276
	add r0,r2,#0x0	; 0232C278
	add r0,#0xb2	; 0232C27A
	ldrb r3,[r0,#0x0]	; 0232C27C
	cmp r3,#0x96	; 0232C27E
	bne loc_0232C28E	; 0232C280
	ldr r0,[pool_0232C2E0]	; 0232C282
	ldrh r1,[r0,#0x0]	; 0232C284
	add r2,#0xbe	; 0232C286
	ldrh r0,[r2,#0x0]	; 0232C288
	cmp r1,r0	; 0232C28A
	bne loc_0232C2B6	; 0232C28C
loc_0232C28E:
	cmp r3,#0x96	; 0232C28E
	beq loc_0232C29E	; 0232C290
	ldr r0,[pool_0232C2E0]	; 0232C292
	ldrh r1,[r0,#0x0]	; 0232C294
	ldr r0,[pool_0232C2F0]	; 0232C296
	ldrh r0,[r0,#0x0]	; 0232C298
	cmp r1,r0	; 0232C29A
	bne loc_0232C2B6	; 0232C29C
loc_0232C29E:
	ldr r2,[pool_0232C2E0]	; 0232C29E
	ldr r1,[r2,#0x8]	; 0232C2A0
	ldr r0,[pool_0232C2EC]	; 0232C2A2
	add r0,#0xac	; 0232C2A4
	ldr r0,[r0,#0x0]	; 0232C2A6
	cmp r1,r0	; 0232C2A8
	beq loc_0232C2C4	; 0232C2AA
	ldrb r0,[r2,#0x5]	; 0232C2AC
	lsl r0,r0,#0x1f	; 0232C2AE
	lsr r0,r0,#0x1f	; 0232C2B0
	cmp r0,#0x0	; 0232C2B2
	beq loc_0232C2C4	; 0232C2B4
loc_0232C2B6:
	ldr r0,[pool_0232C2E0]	; 0232C2B6
	add r2,r0,#0x5	; 0232C2B8
	ldrb r1,[r2,#0x0]	; 0232C2BA
	mov r0,#0x2	; 0232C2BC
	orr r1,r0	; 0232C2BE
	strb r1,[r2,#0x0]	; 0232C2C0
	mov r4,#0x0	; 0232C2C2
loc_0232C2C4:
	add r0,sp,#0x8	; 0232C2C4
	bl loc_0232C1D8	; 0232C2C6
	ldr r0,[pool_0232C2E8]	; 0232C2CA
	ldrh r0,[r0,#0x2]	; 0232C2CC
	add r1,sp,#0x0	; 0232C2CE
	bl loc_0232C174	; 0232C2D0
	add r0,r4,#0x0	; 0232C2D4
	add sp,#0x10	; 0232C2D6
	pop {r4}	; 0232C2D8
	pop {r3}	; 0232C2DA
	bx r3	; 0232C2DC
	.byte 0xC0, 0x46	; 0232C2E0
pool_0232C2E0:
loc_0232C2E0:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C2E0
pool_0232C2E4:
loc_0232C2E4:
	.word 0x0000FFFF	; 0232C2E4
pool_0232C2E8:
loc_0232C2E8:
	.word P1_BssStart + 0x26680	; 0232C2E8
pool_0232C2EC:
loc_0232C2EC:
	.word Slot2BusBaseAddress	; 0232C2EC
pool_0232C2F0:
loc_0232C2F0:
	.word Slot2BusBaseAddress + 0x1FFFE	; 0232C2F0

; ===== function loc_0232C2F4 =====
loc_0232C2F4:
	push {lr}	; 0232C2F4
	sub sp,#0x4	; 0232C2F6
	ldr r2,[pool_0232C328]	; 0232C2F8
	ldrh r1,[r2,#0x0]	; 0232C2FA
	ldr r0,[pool_0232C32C]	; 0232C2FC
	cmp r1,r0	; 0232C2FE
	bne loc_0232C30A	; 0232C300
	mov r0,#0x0	; 0232C302
	add sp,#0x4	; 0232C304
	pop {r3}	; 0232C306
	bx r3	; 0232C308
loc_0232C30A:
	ldrb r0,[r2,#0x5]	; 0232C30A
	lsl r0,r0,#0x1e	; 0232C30C
	lsr r0,r0,#0x1f	; 0232C30E
	cmp r0,#0x0	; 0232C310
	bne loc_0232C318	; 0232C312
	bl loc_0232C238	; 0232C314
loc_0232C318:
	ldr r0,[pool_0232C328]	; 0232C318
	ldrb r0,[r0,#0x5]	; 0232C31A
	lsl r0,r0,#0x1e	; 0232C31C
	lsr r0,r0,#0x1f	; 0232C31E
	add sp,#0x4	; 0232C320
	pop {r3}	; 0232C322
	bx r3	; 0232C324
	.byte 0xC0, 0x46	; 0232C328
pool_0232C328:
loc_0232C328:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C328
pool_0232C32C:
loc_0232C32C:
	.word 0x0000FFFF	; 0232C32C

; ===== function loc_0232C330 =====
loc_0232C330:
	push {r4}	; 0232C330
	sub sp,#0x4	; 0232C332
	mov r4,#0x0	; 0232C334
	ldr r3,[pool_0232C358]	; 0232C336
	ldrh r2,[r3,#0x0]	; 0232C338
	ldr r1,[pool_0232C35C]	; 0232C33A
	cmp r2,r1	; 0232C33C
	beq loc_0232C350	; 0232C33E
	cmp r2,#0x0	; 0232C340
	beq loc_0232C350	; 0232C342
	ldrb r1,[r3,#0x0]	; 0232C344
	mvn r1,r1	; 0232C346
	and r1,r0	; 0232C348
	cmp r1,#0x0	; 0232C34A
	beq loc_0232C350	; 0232C34C
	mov r4,#0x1	; 0232C34E
loc_0232C350:
	add r0,r4,#0x0	; 0232C350
	add sp,#0x4	; 0232C352
	pop {r4}	; 0232C354
	bx lr	; 0232C356
pool_0232C358:
loc_0232C358:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C358
pool_0232C35C:
loc_0232C35C:
	.word 0x0000FFFF	; 0232C35C

; ===== function loc_0232C360 =====
loc_0232C360:
	push {r4,lr}	; 0232C360
	add r4,r0,#0x0	; 0232C362
	bl loc_0232C238	; 0232C364
	cmp r0,#0x0	; 0232C368
	beq loc_0232C37E	; 0232C36A
	add r0,r4,#0x0	; 0232C36C
	bl loc_0232C330	; 0232C36E
	cmp r0,#0x0	; 0232C372
	beq loc_0232C37E	; 0232C374
	mov r0,#0x1	; 0232C376
	pop {r4}	; 0232C378
	pop {r3}	; 0232C37A
	bx r3	; 0232C37C
loc_0232C37E:
	mov r0,#0x0	; 0232C37E
	pop {r4}	; 0232C380
	pop {r3}	; 0232C382
	bx r3	; 0232C384
	.byte 0x00, 0x00	; 0232C388

; ===== function loc_0232C388 =====
loc_0232C388:
	push {lr}	; 0232C388
	sub sp,#0x4	; 0232C38A
	mov r0,#0x0	; 0232C38C
	str r0,[sp,#0x0]	; 0232C38E
	add r0,sp,#0x0	; 0232C390
	ldr r1,[pool_0232C3A8]	; 0232C392
	ldr r2,[pool_0232C3AC]	; 0232C394
	bl loc_0232C3F2	; 0232C396
	blx loc_0232AE48	; 0232C39A
	ldr r1,[pool_0232C3A8]	; 0232C39E
	strh r0,[r1,#0x2]	; 0232C3A0
	add sp,#0x4	; 0232C3A2
	pop {r3}	; 0232C3A4
	bx r3	; 0232C3A6
pool_0232C3A8:
loc_0232C3A8:
	.word P1_BssStart + 0x26680	; 0232C3A8
pool_0232C3AC:
loc_0232C3AC:
	.word 0x05000001	; 0232C3AC

; ===== function loc_0232C3B0 =====
loc_0232C3B0:
	push {lr}	; 0232C3B0
	sub sp,#0x4	; 0232C3B2
	ldr r0,[pool_0232C3CC]	; 0232C3B4
	ldr r1,[r0,#0x0]	; 0232C3B6
	cmp r1,#0x0	; 0232C3B8
	bne loc_0232C3C4	; 0232C3BA
	mov r1,#0x1	; 0232C3BC
	str r1,[r0,#0x0]	; 0232C3BE
	bl loc_0232C388	; 0232C3C0
loc_0232C3C4:
	add sp,#0x4	; 0232C3C4
	pop {r3}	; 0232C3C6
	bx r3	; 0232C3C8
	.byte 0xC0, 0x46	; 0232C3CC
pool_0232C3CC:
loc_0232C3CC:
	.word P1_BssStart + 0x26684	; 0232C3CC
	.byte 0x00, 0xDF, 0x70, 0x47	; 0232C3D4

; ===== function loc_0232C3D4 =====
.func P1_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
loc_0232C3D4:
	swi 0x3	; 0232C3D4
	bx lr	; 0232C3D6
.endfunc
	.byte 0x00, 0x22, 0x04, 0xDF, 0x70, 0x47	; 0232C3DE

; ===== function loc_0232C3DE =====
.func P1_SwiVBlankIntrWait
; BIOS SWI #05: wait for VBlank IRQ. / BIOS SWI #05：等待 VBlank 中断。
loc_0232C3DE:
	mov r2,#0x0	; 0232C3DE
	swi 0x5	; 0232C3E0
	bx lr	; 0232C3E2
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

; ===== function loc_0232C3F2 =====
.func P1_SwiCpuSet
; BIOS SWI #0B: CpuSet copy/fill. / BIOS SWI #0B：CpuSet 复制/填充。
loc_0232C3F2:
	swi 0xb	; 0232C3F2
	bx lr	; 0232C3F4
.endfunc

; ===== function loc_0232C3F6 =====
.func P1_SwiCpuFastSet
; BIOS SWI #0C: CpuFastSet copy/fill. / BIOS SWI #0C：CpuFastSet 复制/填充。
loc_0232C3F6:
	swi 0xc	; 0232C3F6
	bx lr	; 0232C3F8
.endfunc
.func P1_SwiSqrt
; BIOS SWI #0D: integer square root. / BIOS SWI #0D：整数平方根。
	swi 0xd
	bx lr
.endfunc

; ===== function P1_SwiGetCrc16 =====
.func P1_SwiGetCrc16
; BIOS SWI #0E: CRC-16 service. / BIOS SWI #0E：CRC-16 服务。
loc_0232C3FE:
	swi 0xe	; 0232C3FE
	bx lr	; 0232C400
.endfunc
.func P1_SwiIsDebugger
; BIOS SWI #0F: detect debugger state. / BIOS SWI #0F：检测调试器状态。
	swi 0x0f
	bx lr
.endfunc

; ===== function loc_0232C406 =====
.func P1_SwiBitUnPack
; BIOS SWI #10: BitUnPack decoder. / BIOS SWI #10：BitUnPack 解码器。
loc_0232C406:
	swi 0x10	; 0232C406
	bx lr	; 0232C408
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

; ===== function loc_0232C412 =====
.func P1_SwiHuffUnComp
; BIOS SWI #13: Huffman decoder. / BIOS SWI #13：Huffman 解码器。
loc_0232C412:
	swi 0x13	; 0232C412
	bx lr	; 0232C414
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
loc_0232C420:
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
loc_0232C494:
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
P1_Cp15MpuRegion4Base:           .word P1_DtcmRuntimeStart
P1_Cp15MpuRegion5Config:         .word 0x0100002F
P1_Cp15MpuRegion6Config:         .word 0xFFFF001D
P1_Cp15MpuRegion7Config:         .word 0x027FF017
P1_Cp15InstructionAccessConfig:  .word 0x05100011
P1_Cp15DataAccessConfig:         .word 0x15111011
P1_Cp15ControlEnableMask:        .word 0x0005707D
.thumb
loc_0232C570:
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x10, 0xB4, 0x81, 0xB0, 0x00, 0x2A, 0x17, 0xD0, 0x04, 0x78, 0x40, 0x1C	; 0232C580
	.byte 0x0B, 0x78, 0x49, 0x1C, 0x9C, 0x42, 0x0E, 0xD0, 0x40, 0x1E, 0x02, 0x78, 0x48, 0x1E, 0x00, 0x78	; 0232C590
	.byte 0x82, 0x42, 0x04, 0xD2, 0x00, 0x20, 0xC0, 0x43, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x01, 0x20	; 0232C5A0
	.byte 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x52, 0x1E, 0x00, 0x2A, 0xE7, 0xD1, 0x00, 0x20, 0x01, 0xB0	; 0232C5B0
	.byte 0x10, 0xBC, 0x70, 0x47	; 0232C5B4

; Standard memset: fill r2 bytes at r0 with low byte of r1 and return original r0.
; 标准 memset：以 r1 低字节填充 r0 起始的 r2 字节，并返回原 r0。
P1_MemSet:
; ===== function loc_0232C5B4 =====
	push {r4,lr}	; 0232C5B4
	add r4,r0,#0x0	; 0232C5B6
	bl P1_MemSetCore	; 0232C5B8
	add r0,r4,#0x0	; 0232C5BC
	pop {r4}	; 0232C5BE
	pop {r3}	; 0232C5C0
	bx r3	; 0232C5C2

; ===== function loc_0232C5C4 =====
; Core byte/word fill loop; r0 advances to the end. / 核心字节/字填充循环；r0 前进至末尾。
P1_MemSetCore:
loc_0232C5C4:
	push {r4,r5}	; 0232C5C4
	lsl r1,r1,#0x18	; 0232C5C6
	lsr r1,r1,#0x18	; 0232C5C8
	cmp r2,#0x20	; 0232C5CA
	bcc loc_0232C632	; 0232C5CC
	neg r4,r0	; 0232C5CE
	mov r3,#0x3	; 0232C5D0
	and r4,r3	; 0232C5D2
	cmp r4,#0x0	; 0232C5D4
	beq loc_0232C5E8	; 0232C5D6
	sub r2,r2,r4	; 0232C5D8
	lsl r3,r1,#0x18	; 0232C5DA
	lsr r3,r3,#0x18	; 0232C5DC
loc_0232C5DE:
	strb r3,[r0,#0x0]	; 0232C5DE
	add r0,r0,#0x1	; 0232C5E0
	sub r4,r4,#0x1	; 0232C5E2
	cmp r4,#0x0	; 0232C5E4
	bne loc_0232C5DE	; 0232C5E6
loc_0232C5E8:
	cmp r1,#0x0	; 0232C5E8
	beq loc_0232C5F8	; 0232C5EA
	lsl r5,r1,#0x8	; 0232C5EC
	lsl r4,r1,#0x18	; 0232C5EE
	lsl r3,r1,#0x10	; 0232C5F0
	orr r4,r3	; 0232C5F2
	orr r5,r4	; 0232C5F4
	orr r1,r5	; 0232C5F6
loc_0232C5F8:
	lsr r4,r2,#0x5	; 0232C5F8
	cmp r4,#0x0	; 0232C5FA
	beq loc_0232C61A	; 0232C5FC
loc_0232C5FE:
	str r1,[r0,#0x0]	; 0232C5FE
	str r1,[r0,#0x4]	; 0232C600
	str r1,[r0,#0x8]	; 0232C602
	str r1,[r0,#0xc]	; 0232C604
	str r1,[r0,#0x10]	; 0232C606
	str r1,[r0,#0x14]	; 0232C608
	str r1,[r0,#0x18]	; 0232C60A
	add r3,r0,#0x0	; 0232C60C
	add r3,#0x1c	; 0232C60E
	add r0,#0x20	; 0232C610
	str r1,[r3,#0x0]	; 0232C612
	sub r4,r4,#0x1	; 0232C614
	cmp r4,#0x0	; 0232C616
	bne loc_0232C5FE	; 0232C618
loc_0232C61A:
	mov r3,#0x1f	; 0232C61A
	add r4,r2,#0x0	; 0232C61C
	and r4,r3	; 0232C61E
	lsr r3,r4,#0x2	; 0232C620
	cmp r3,#0x0	; 0232C622
	beq loc_0232C62E	; 0232C624
loc_0232C626:
	stmia r0!,{r1}	; 0232C626
	sub r3,r3,#0x1	; 0232C628
	cmp r3,#0x0	; 0232C62A
	bne loc_0232C626	; 0232C62C
loc_0232C62E:
	mov r3,#0x3	; 0232C62E
	and r2,r3	; 0232C630
loc_0232C632:
	cmp r2,#0x0	; 0232C632
	beq loc_0232C644	; 0232C634
	lsl r1,r1,#0x18	; 0232C636
	lsr r1,r1,#0x18	; 0232C638
loc_0232C63A:
	strb r1,[r0,#0x0]	; 0232C63A
	add r0,r0,#0x1	; 0232C63C
	sub r2,r2,#0x1	; 0232C63E
	cmp r2,#0x0	; 0232C640
	bne loc_0232C63A	; 0232C642
loc_0232C644:
	pop {r4,r5}	; 0232C644
	bx lr	; 0232C646

; UTF-16 strchr: find a code unit, including the terminating NUL. / UTF-16 strchr：查找码元，包括结尾 NUL。
P1_Utf16StrChr:
; ===== function loc_0232C648 =====
loc_0232C648:
	add r2,r0,#0x2	; 0232C648
	ldrh r0,[r0,#0x0]	; 0232C64A
	cmp r0,#0x0	; 0232C64C
	beq loc_0232C660	; 0232C64E
loc_0232C650:
	cmp r0,r1	; 0232C650
	bne loc_0232C658	; 0232C652
	sub r0,r2,#0x2	; 0232C654
	bx lr	; 0232C656
loc_0232C658:
	ldrh r0,[r2,#0x0]	; 0232C658
	add r2,r2,#0x2	; 0232C65A
	cmp r0,#0x0	; 0232C65C
	bne loc_0232C650	; 0232C65E
loc_0232C660:
	cmp r1,#0x0	; 0232C660
	beq loc_0232C668	; 0232C662
	mov r0,#0x0	; 0232C664
	bx lr	; 0232C666
loc_0232C668:
	sub r0,r2,#0x2	; 0232C668
	bx lr	; 0232C66A

; UTF-16 bounded comparison. / UTF-16 定长字符串比较。
P1_Utf16StrNCmp:
; ===== function loc_0232C66C =====
	push {r4}	; 0232C66C
	sub sp,#0x4	; 0232C66E
	cmp r2,#0x0	; 0232C670
	beq loc_0232C692	; 0232C672
loc_0232C674:
	ldrh r4,[r1,#0x0]	; 0232C674
	add r1,r1,#0x2	; 0232C676
	ldrh r3,[r0,#0x0]	; 0232C678
	add r0,r0,#0x2	; 0232C67A
	cmp r3,r4	; 0232C67C
	beq loc_0232C688	; 0232C67E
	sub r0,r3,r4	; 0232C680
	add sp,#0x4	; 0232C682
	pop {r4}	; 0232C684
	bx lr	; 0232C686
loc_0232C688:
	cmp r3,#0x0	; 0232C688
	beq loc_0232C692	; 0232C68A
	sub r2,r2,#0x1	; 0232C68C
	cmp r2,#0x0	; 0232C68E
	bne loc_0232C674	; 0232C690
loc_0232C692:
	mov r0,#0x0	; 0232C692
	add sp,#0x4	; 0232C694
	pop {r4}	; 0232C696
	bx lr	; 0232C698
	.byte 0x00, 0x00, 0x10, 0xB4, 0x81, 0xB0, 0x04, 0x1C, 0x22, 0x88, 0xA4, 0x1C, 0x00, 0x2A, 0xFB, 0xD1	; 0232C6AA
	.byte 0xA4, 0x1E, 0x23, 0x1C, 0x0A, 0x88, 0x89, 0x1C, 0x22, 0x80, 0xA4, 0x1C, 0x1A, 0x88, 0x00, 0x2A	; 0232C6BA
	.byte 0xF7, 0xD1, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x00, 0x00	; 0232C6C4

; UTF-16 bounded copy with NUL padding. / UTF-16 定长复制，结尾不足时补 NUL。
P1_Utf16StrNCpy:
; ===== function loc_0232C6C4 =====
loc_0232C6C4:
	push {r4,r5}	; 0232C6C4
	add r5,r0,#0x0	; 0232C6C6
	cmp r2,#0x0	; 0232C6C8
	beq loc_0232C6F8	; 0232C6CA
loc_0232C6CC:
	add r4,r5,#0x0	; 0232C6CC
	ldrh r3,[r1,#0x0]	; 0232C6CE
	add r1,r1,#0x2	; 0232C6D0
	strh r3,[r5,#0x0]	; 0232C6D2
	add r5,r5,#0x2	; 0232C6D4
	ldrh r3,[r4,#0x0]	; 0232C6D6
	cmp r3,#0x0	; 0232C6D8
	bne loc_0232C6F2	; 0232C6DA
	sub r2,r2,#0x1	; 0232C6DC
	cmp r2,#0x0	; 0232C6DE
	beq loc_0232C6F8	; 0232C6E0
	mov r1,#0x0	; 0232C6E2
loc_0232C6E4:
	strh r1,[r5,#0x0]	; 0232C6E4
	add r5,r5,#0x2	; 0232C6E6
	sub r2,r2,#0x1	; 0232C6E8
	cmp r2,#0x0	; 0232C6EA
	bne loc_0232C6E4	; 0232C6EC
	pop {r4,r5}	; 0232C6EE
	bx lr	; 0232C6F0
loc_0232C6F2:
	sub r2,r2,#0x1	; 0232C6F2
	cmp r2,#0x0	; 0232C6F4
	bne loc_0232C6CC	; 0232C6F6
loc_0232C6F8:
	pop {r4,r5}	; 0232C6F8
	bx lr	; 0232C6FA

; UTF-16 unbounded copy through the terminating NUL. / UTF-16 复制，直至结尾 NUL。
P1_Utf16StrCpy:
; ===== function loc_0232C6FC =====
loc_0232C6FC:
	push {r4}	; 0232C6FC
	sub sp,#0x4	; 0232C6FE
	add r4,r0,#0x0	; 0232C700
loc_0232C702:
	add r3,r4,#0x0	; 0232C702
	ldrh r2,[r1,#0x0]	; 0232C704
	add r1,r1,#0x2	; 0232C706
	strh r2,[r4,#0x0]	; 0232C708
	add r4,r4,#0x2	; 0232C70A
	ldrh r2,[r3,#0x0]	; 0232C70C
	cmp r2,#0x0	; 0232C70E
	bne loc_0232C702	; 0232C710
	add sp,#0x4	; 0232C712
	pop {r4}	; 0232C714
	bx lr	; 0232C716
; UTF-16 strlen: count code units before the terminating NUL. / UTF-16 strlen：统计结尾 NUL 前的码元数。
P1_Utf16StrLen:
; ===== function loc_0232C718 =====
loc_0232C718:
	mov r1,#0x0	; 0232C718
	mvn r2,r1	; 0232C71A
loc_0232C71C:
	add r2,r2,#0x1	; 0232C71C
	ldrh r1,[r0,#0x0]	; 0232C71E
	add r0,r0,#0x2	; 0232C720
	cmp r1,#0x0	; 0232C722
	bne loc_0232C71C	; 0232C724
	add r0,r2,#0x0	; 0232C726
	bx lr	; 0232C728
	.hword 0x0000	; padding / 对齐填充。
.arm

; ===== function loc_0232C72C =====
loc_0232C72C:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C72C
	mov r4,#0x0	; 0232C730
	b loc_0232C740	; 0232C734
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 0232C740
loc_0232C740:
	orrs r5,r3,r2	; 0232C740
	bne loc_0232C750	; 0232C744
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C748
	bx lr	; 0232C74C
loc_0232C750:
	orrs r5,r1,r3	; 0232C750
	bne loc_0232C7F8	; 0232C754
	mov r1,r2	; 0232C758
	bl loc_0232CB68	; 0232C75C
	cmp r4,#0x0	; 0232C760
	movne r0,r1	; 0232C764
	mov r1,#0x0	; 0232C768
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C76C
	bx lr	; 0232C770
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 0232C784
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x03, 0x40, 0x21, 0xE0, 0xC4, 0x40, 0xA0, 0xE1, 0x84, 0x40, 0xA0, 0xE1	; 0232C794
	.byte 0x02, 0x50, 0x93, 0xE1, 0x01, 0x00, 0x00, 0x1A, 0xF0, 0x58, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 0232C7A4
	.byte 0xA0, 0x5F, 0xA0, 0xE1, 0x01, 0x50, 0x85, 0xE0, 0xA2, 0x6F, 0xA0, 0xE1, 0x03, 0x60, 0x86, 0xE0	; 0232C7B4
	.byte 0x06, 0x60, 0x95, 0xE1, 0x06, 0x00, 0x00, 0x1A, 0x02, 0x10, 0xA0, 0xE1, 0x63, 0x00, 0x00, 0xEB	; 0232C7C4
	.byte 0x01, 0x40, 0x14, 0xE2, 0x01, 0x00, 0xA0, 0x11, 0xC0, 0x1F, 0xA0, 0xE1, 0xF0, 0x58, 0xBD, 0xE8	; 0232C7D4
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x00, 0x00, 0x51, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x00, 0x70, 0xE2	; 0232C7E4
	.byte 0x00, 0x10, 0xE1, 0xE2, 0x00, 0x00, 0x53, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x20, 0x72, 0xE2	; 0232C7F4
	.byte 0x00, 0x30, 0xE3, 0xE2	; 0232C7F8
loc_0232C7F8:
	orrs r5,r1,r0	; 0232C7F8
	beq loc_0232C91C	; 0232C7FC
	mov r5,#0x0	; 0232C800
	mov r6,#0x1	; 0232C804
	cmp r3,#0x0	; 0232C808
	bmi loc_0232C824	; 0232C80C
loc_0232C810:
	add r5,r5,#0x1	; 0232C810
	adds r2,r2,r2	; 0232C814
	adcs r3,r3,r3	; 0232C818
	bpl loc_0232C810	; 0232C81C
	add r6,r6,r5	; 0232C820
loc_0232C824:
	cmp r1,#0x0	; 0232C824
	blt loc_0232C844	; 0232C828
loc_0232C82C:
	cmp r6,#0x1	; 0232C82C
	beq loc_0232C844	; 0232C830
	sub r6,r6,#0x1	; 0232C834
	adds r0,r0,r0	; 0232C838
	adcs r1,r1,r1	; 0232C83C
	bpl loc_0232C82C	; 0232C840
loc_0232C844:
	mov r7,#0x0	; 0232C844
	mov r12,#0x0	; 0232C848
	mov r11,#0x0	; 0232C84C
	b loc_0232C86C	; 0232C850
loc_0232C854:
	orr r12,r12,#0x1	; 0232C854
	subs r6,r6,#0x1	; 0232C858
	beq loc_0232C8C4	; 0232C85C
	adds r0,r0,r0	; 0232C860
	adcs r1,r1,r1	; 0232C864
	adcs r7,r7,r7	; 0232C868
loc_0232C86C:
	subs r0,r0,r2	; 0232C86C
	sbcs r1,r1,r3	; 0232C870
	sbcs r7,r7,#0x0	; 0232C874
	adds r12,r12,r12	; 0232C878
	adc r11,r11,r11	; 0232C87C
	cmp r7,#0x0	; 0232C880
	bge loc_0232C854	; 0232C884
loc_0232C888:
	subs r6,r6,#0x1	; 0232C888
	beq loc_0232C8BC	; 0232C88C
	adds r0,r0,r0	; 0232C890
	adcs r1,r1,r1	; 0232C894
	adc r7,r7,r7	; 0232C898
	adds r0,r0,r2	; 0232C89C
	adcs r1,r1,r3	; 0232C8A0
	adc r7,r7,#0x0	; 0232C8A4
	adds r12,r12,r12	; 0232C8A8
	adc r11,r11,r11	; 0232C8AC
	cmp r7,#0x0	; 0232C8B0
	bge loc_0232C854	; 0232C8B4
	b loc_0232C888	; 0232C8B8
loc_0232C8BC:
	adds r0,r0,r2	; 0232C8BC
	adc r1,r1,r3	; 0232C8C0
loc_0232C8C4:
	ands r7,r4,#0x1	; 0232C8C4
	moveq r0,r12	; 0232C8C8
	moveq r1,r11	; 0232C8CC
	beq loc_0232C8FC	; 0232C8D0
	subs r7,r5,#0x20	; 0232C8D4
	movge r0,r1, lsr r7	; 0232C8D8
	bge loc_0232C920	; 0232C8DC
	rsb r7,r5,#0x20	; 0232C8E0
	mov r0,r0, lsr r5	; 0232C8E4
	orr r0,r0,r1, lsl r7	; 0232C8E8
	mov r1,r1, lsr r5	; 0232C8EC
	b loc_0232C8FC	; 0232C8F0
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 0232C8FC
loc_0232C8FC:
	cmp r4,#0x0	; 0232C8FC
	blt loc_0232C90C	; 0232C900
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C904
	bx lr	; 0232C908
loc_0232C90C:
	rsbs r0,r0,#0x0	; 0232C90C
	rsc r1,r1,#0x0	; 0232C910
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C914
	bx lr	; 0232C918
loc_0232C91C:
	mov r0,#0x0	; 0232C91C
loc_0232C920:
	mov r1,#0x0	; 0232C920
	cmp r4,#0x0	; 0232C924
	blt loc_0232C90C	; 0232C928
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232C92C
	bx lr	; 0232C930

; ARM EABI 64-bit multiply (__aeabi_lmul); the bit pattern is identical for signed and unsigned operands. / ARM EABI 64 位乘法（__aeabi_lmul）；有符号与无符号操作数的位级结果相同。
P1_AeabiLmul:
; ===== function loc_0232C934 =====
loc_0232C934:
	stmdb sp!,{r4,r5,lr}	; 0232C934
	umull r5,r4,r0,r2	; 0232C938
	mla r4,r0,r3,r4	; 0232C93C
	mla r4,r2,r1,r4	; 0232C940
	mov r1,r4	; 0232C944
	mov r0,r5	; 0232C948
	ldmia sp!,{r4,r5,lr}	; 0232C94C
	bx lr	; 0232C950

; 32-bit signed division with remainder: r0 = quotient, r1 = remainder. / 32 位有符号除法及取余：r0 为商，r1 为余数。
P1_SignedDivMod:
; ===== function loc_0232C954 =====
loc_0232C954:
	eor r12,r0,r1	; 0232C954
	and r12,r12,#0x80000000	; 0232C958
	cmp r0,#0x0	; 0232C95C
	rsblt r0,r0,#0x0	; 0232C960
	addlt r12,r12,#0x1	; 0232C964
	cmp r1,#0x0	; 0232C968
	rsblt r1,r1,#0x0	; 0232C96C
	beq loc_0232CB4C	; 0232C970
	cmp r0,r1	; 0232C974
	movcc r1,r0	; 0232C978
	movcc r0,#0x0	; 0232C97C
	bcc loc_0232CB4C	; 0232C980
	mov r2,#0x1c	; 0232C984
	mov r3,r0, lsr #0x4	; 0232C988
	cmp r1,r3, lsr #0xc	; 0232C98C
	suble r2,r2,#0x10	; 0232C990
	movle r3,r3, lsr #0x10	; 0232C994
	cmp r1,r3, lsr #0x4	; 0232C998
	suble r2,r2,#0x8	; 0232C99C
	movle r3,r3, lsr #0x8	; 0232C9A0
	cmp r1,r3	; 0232C9A4
	suble r2,r2,#0x4	; 0232C9A8
	movle r3,r3, lsr #0x4	; 0232C9AC
	mov r0,r0, lsl r2	; 0232C9B0
	rsb r1,r1,#0x0	; 0232C9B4
	adds r0,r0,r0	; 0232C9B8
	add r2,r2,r2, lsl #0x1	; 0232C9BC
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232C9C0PC:
	add pc,pc,r2, lsl #0x2	; 0232C9C0
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232C9C8
loc_0232C9C8:
P1_DivisionDispatch_0232C9C0Steps:
	adcs r3,r1,r3, lsl #0x1	; 0232C9C8
	subcc r3,r3,r1	; 0232C9CC
	adcs r0,r0,r0	; 0232C9D0
	adcs r3,r1,r3, lsl #0x1	; 0232C9D4
	subcc r3,r3,r1	; 0232C9D8
	adcs r0,r0,r0	; 0232C9DC
	adcs r3,r1,r3, lsl #0x1	; 0232C9E0
	subcc r3,r3,r1	; 0232C9E4
	adcs r0,r0,r0	; 0232C9E8
	adcs r3,r1,r3, lsl #0x1	; 0232C9EC
	subcc r3,r3,r1	; 0232C9F0
	adcs r0,r0,r0	; 0232C9F4
loc_0232C9F8:
	adcs r3,r1,r3, lsl #0x1	; 0232C9F8
	subcc r3,r3,r1	; 0232C9FC
	adcs r0,r0,r0	; 0232CA00
	adcs r3,r1,r3, lsl #0x1	; 0232CA04
	subcc r3,r3,r1	; 0232CA08
	adcs r0,r0,r0	; 0232CA0C
	adcs r3,r1,r3, lsl #0x1	; 0232CA10
	subcc r3,r3,r1	; 0232CA14
	adcs r0,r0,r0	; 0232CA18
	adcs r3,r1,r3, lsl #0x1	; 0232CA1C
	subcc r3,r3,r1	; 0232CA20
	adcs r0,r0,r0	; 0232CA24
loc_0232CA28:
	adcs r3,r1,r3, lsl #0x1	; 0232CA28
	subcc r3,r3,r1	; 0232CA2C
	adcs r0,r0,r0	; 0232CA30
	adcs r3,r1,r3, lsl #0x1	; 0232CA34
	subcc r3,r3,r1	; 0232CA38
	adcs r0,r0,r0	; 0232CA3C
	adcs r3,r1,r3, lsl #0x1	; 0232CA40
	subcc r3,r3,r1	; 0232CA44
	adcs r0,r0,r0	; 0232CA48
	adcs r3,r1,r3, lsl #0x1	; 0232CA4C
	subcc r3,r3,r1	; 0232CA50
	adcs r0,r0,r0	; 0232CA54
	adcs r3,r1,r3, lsl #0x1	; 0232CA58
	subcc r3,r3,r1	; 0232CA5C
	adcs r0,r0,r0	; 0232CA60
	adcs r3,r1,r3, lsl #0x1	; 0232CA64
	subcc r3,r3,r1	; 0232CA68
	adcs r0,r0,r0	; 0232CA6C
	adcs r3,r1,r3, lsl #0x1	; 0232CA70
	subcc r3,r3,r1	; 0232CA74
	adcs r0,r0,r0	; 0232CA78
	adcs r3,r1,r3, lsl #0x1	; 0232CA7C
	subcc r3,r3,r1	; 0232CA80
	adcs r0,r0,r0	; 0232CA84
loc_0232CA88:
	adcs r3,r1,r3, lsl #0x1	; 0232CA88
	subcc r3,r3,r1	; 0232CA8C
	adcs r0,r0,r0	; 0232CA90
	adcs r3,r1,r3, lsl #0x1	; 0232CA94
	subcc r3,r3,r1	; 0232CA98
	adcs r0,r0,r0	; 0232CA9C
	adcs r3,r1,r3, lsl #0x1	; 0232CAA0
	subcc r3,r3,r1	; 0232CAA4
	adcs r0,r0,r0	; 0232CAA8
	adcs r3,r1,r3, lsl #0x1	; 0232CAAC
	subcc r3,r3,r1	; 0232CAB0
	adcs r0,r0,r0	; 0232CAB4
	adcs r3,r1,r3, lsl #0x1	; 0232CAB8
	subcc r3,r3,r1	; 0232CABC
	adcs r0,r0,r0	; 0232CAC0
	adcs r3,r1,r3, lsl #0x1	; 0232CAC4
	subcc r3,r3,r1	; 0232CAC8
	adcs r0,r0,r0	; 0232CACC
	adcs r3,r1,r3, lsl #0x1	; 0232CAD0
	subcc r3,r3,r1	; 0232CAD4
	adcs r0,r0,r0	; 0232CAD8
	adcs r3,r1,r3, lsl #0x1	; 0232CADC
	subcc r3,r3,r1	; 0232CAE0
	adcs r0,r0,r0	; 0232CAE4
	adcs r3,r1,r3, lsl #0x1	; 0232CAE8
	subcc r3,r3,r1	; 0232CAEC
	adcs r0,r0,r0	; 0232CAF0
	adcs r3,r1,r3, lsl #0x1	; 0232CAF4
	subcc r3,r3,r1	; 0232CAF8
	adcs r0,r0,r0	; 0232CAFC
	adcs r3,r1,r3, lsl #0x1	; 0232CB00
	subcc r3,r3,r1	; 0232CB04
	adcs r0,r0,r0	; 0232CB08
	adcs r3,r1,r3, lsl #0x1	; 0232CB0C
	subcc r3,r3,r1	; 0232CB10
	adcs r0,r0,r0	; 0232CB14
	adcs r3,r1,r3, lsl #0x1	; 0232CB18
	subcc r3,r3,r1	; 0232CB1C
	adcs r0,r0,r0	; 0232CB20
	adcs r3,r1,r3, lsl #0x1	; 0232CB24
	subcc r3,r3,r1	; 0232CB28
	adcs r0,r0,r0	; 0232CB2C
	adcs r3,r1,r3, lsl #0x1	; 0232CB30
	subcc r3,r3,r1	; 0232CB34
	adcs r0,r0,r0	; 0232CB38
	adcs r3,r1,r3, lsl #0x1	; 0232CB3C
	subcc r3,r3,r1	; 0232CB40
	adcs r0,r0,r0	; 0232CB44
P1_DivisionDispatch_0232C9C0End:
.if (P1_DivisionDispatch_0232C9C0Steps != P1_DivisionDispatch_0232C9C0PC + 8) || (P1_DivisionDispatch_0232C9C0End - P1_DivisionDispatch_0232C9C0Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232CB48
loc_0232CB4C:
	ands r3,r12,#0x80000000	; 0232CB4C
	rsbne r0,r0,#0x0	; 0232CB50
	ands r3,r12,#0x1	; 0232CB54
	rsbne r1,r1,#0x0	; 0232CB58
	bx lr	; 0232CB5C

; 32-bit unsigned division with remainder; the first entry returns immediately for a zero divisor. / 32 位无符号除法及取余；除数为零时第一个入口直接返回。
P1_UnsignedDivMod:
; ===== function loc_0232CB60 =====
loc_0232CB60:
	cmp r1,#0x0	; 0232CB60
	bxeq lr	; 0232CB64

; ===== function loc_0232CB68 =====
loc_0232CB68:
	cmp r0,r1	; 0232CB68
	movcc r1,r0	; 0232CB6C
	movcc r0,#0x0	; 0232CB70
	bxcc lr	; 0232CB74
	mov r2,#0x1c	; 0232CB78
	mov r3,r0, lsr #0x4	; 0232CB7C
	cmp r1,r3, lsr #0xc	; 0232CB80
	suble r2,r2,#0x10	; 0232CB84
	movle r3,r3, lsr #0x10	; 0232CB88
	cmp r1,r3, lsr #0x4	; 0232CB8C
	suble r2,r2,#0x8	; 0232CB90
	movle r3,r3, lsr #0x8	; 0232CB94
	cmp r1,r3	; 0232CB98
	suble r2,r2,#0x4	; 0232CB9C
	movle r3,r3, lsr #0x4	; 0232CBA0
	mov r0,r0, lsl r2	; 0232CBA4
	rsb r1,r1,#0x0	; 0232CBA8
	adds r0,r0,r0	; 0232CBAC
	add r2,r2,r2, lsl #0x1	; 0232CBB0
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CBB4PC:
	add pc,pc,r2, lsl #0x2	; 0232CBB4
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CBBC
loc_0232CBBC:
P1_DivisionDispatch_0232CBB4Steps:
	adcs r3,r1,r3, lsl #0x1	; 0232CBBC
	subcc r3,r3,r1	; 0232CBC0
	adcs r0,r0,r0	; 0232CBC4
	adcs r3,r1,r3, lsl #0x1	; 0232CBC8
	subcc r3,r3,r1	; 0232CBCC
	adcs r0,r0,r0	; 0232CBD0
	adcs r3,r1,r3, lsl #0x1	; 0232CBD4
	subcc r3,r3,r1	; 0232CBD8
	adcs r0,r0,r0	; 0232CBDC
	adcs r3,r1,r3, lsl #0x1	; 0232CBE0
	subcc r3,r3,r1	; 0232CBE4
	adcs r0,r0,r0	; 0232CBE8
loc_0232CBEC:
	adcs r3,r1,r3, lsl #0x1	; 0232CBEC
	subcc r3,r3,r1	; 0232CBF0
	adcs r0,r0,r0	; 0232CBF4
	adcs r3,r1,r3, lsl #0x1	; 0232CBF8
	subcc r3,r3,r1	; 0232CBFC
	adcs r0,r0,r0	; 0232CC00
	adcs r3,r1,r3, lsl #0x1	; 0232CC04
	subcc r3,r3,r1	; 0232CC08
	adcs r0,r0,r0	; 0232CC0C
	adcs r3,r1,r3, lsl #0x1	; 0232CC10
	subcc r3,r3,r1	; 0232CC14
	adcs r0,r0,r0	; 0232CC18
loc_0232CC1C:
	adcs r3,r1,r3, lsl #0x1	; 0232CC1C
	subcc r3,r3,r1	; 0232CC20
	adcs r0,r0,r0	; 0232CC24
	adcs r3,r1,r3, lsl #0x1	; 0232CC28
	subcc r3,r3,r1	; 0232CC2C
	adcs r0,r0,r0	; 0232CC30
	adcs r3,r1,r3, lsl #0x1	; 0232CC34
	subcc r3,r3,r1	; 0232CC38
	adcs r0,r0,r0	; 0232CC3C
	adcs r3,r1,r3, lsl #0x1	; 0232CC40
	subcc r3,r3,r1	; 0232CC44
	adcs r0,r0,r0	; 0232CC48
	adcs r3,r1,r3, lsl #0x1	; 0232CC4C
	subcc r3,r3,r1	; 0232CC50
	adcs r0,r0,r0	; 0232CC54
	adcs r3,r1,r3, lsl #0x1	; 0232CC58
	subcc r3,r3,r1	; 0232CC5C
	adcs r0,r0,r0	; 0232CC60
	adcs r3,r1,r3, lsl #0x1	; 0232CC64
	subcc r3,r3,r1	; 0232CC68
	adcs r0,r0,r0	; 0232CC6C
	adcs r3,r1,r3, lsl #0x1	; 0232CC70
	subcc r3,r3,r1	; 0232CC74
	adcs r0,r0,r0	; 0232CC78
loc_0232CC7C:
	adcs r3,r1,r3, lsl #0x1	; 0232CC7C
	subcc r3,r3,r1	; 0232CC80
	adcs r0,r0,r0	; 0232CC84
	adcs r3,r1,r3, lsl #0x1	; 0232CC88
	subcc r3,r3,r1	; 0232CC8C
	adcs r0,r0,r0	; 0232CC90
	adcs r3,r1,r3, lsl #0x1	; 0232CC94
	subcc r3,r3,r1	; 0232CC98
	adcs r0,r0,r0	; 0232CC9C
	adcs r3,r1,r3, lsl #0x1	; 0232CCA0
	subcc r3,r3,r1	; 0232CCA4
	adcs r0,r0,r0	; 0232CCA8
	adcs r3,r1,r3, lsl #0x1	; 0232CCAC
	subcc r3,r3,r1	; 0232CCB0
	adcs r0,r0,r0	; 0232CCB4
	adcs r3,r1,r3, lsl #0x1	; 0232CCB8
	subcc r3,r3,r1	; 0232CCBC
	adcs r0,r0,r0	; 0232CCC0
	adcs r3,r1,r3, lsl #0x1	; 0232CCC4
	subcc r3,r3,r1	; 0232CCC8
	adcs r0,r0,r0	; 0232CCCC
	adcs r3,r1,r3, lsl #0x1	; 0232CCD0
	subcc r3,r3,r1	; 0232CCD4
	adcs r0,r0,r0	; 0232CCD8
	adcs r3,r1,r3, lsl #0x1	; 0232CCDC
	subcc r3,r3,r1	; 0232CCE0
	adcs r0,r0,r0	; 0232CCE4
	adcs r3,r1,r3, lsl #0x1	; 0232CCE8
	subcc r3,r3,r1	; 0232CCEC
	adcs r0,r0,r0	; 0232CCF0
	adcs r3,r1,r3, lsl #0x1	; 0232CCF4
	subcc r3,r3,r1	; 0232CCF8
	adcs r0,r0,r0	; 0232CCFC
	adcs r3,r1,r3, lsl #0x1	; 0232CD00
	subcc r3,r3,r1	; 0232CD04
	adcs r0,r0,r0	; 0232CD08
	adcs r3,r1,r3, lsl #0x1	; 0232CD0C
	subcc r3,r3,r1	; 0232CD10
	adcs r0,r0,r0	; 0232CD14
	adcs r3,r1,r3, lsl #0x1	; 0232CD18
	subcc r3,r3,r1	; 0232CD1C
	adcs r0,r0,r0	; 0232CD20
	adcs r3,r1,r3, lsl #0x1	; 0232CD24
	subcc r3,r3,r1	; 0232CD28
	adcs r0,r0,r0	; 0232CD2C
	adcs r3,r1,r3, lsl #0x1	; 0232CD30
	subcc r3,r3,r1	; 0232CD34
	adcs r0,r0,r0	; 0232CD38
P1_DivisionDispatch_0232CBB4End:
.if (P1_DivisionDispatch_0232CBB4Steps != P1_DivisionDispatch_0232CBB4PC + 8) || (P1_DivisionDispatch_0232CBB4End - P1_DivisionDispatch_0232CBB4Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232CD3C
	bx lr	; 0232CD40

; ===== function loc_0232CD44 =====
loc_0232CD44:
	stmdb sp!,{lr}	; 0232CD44
	blx loc_0232CE24	; 0232CD48
	mov r1,#0x0	; 0232CD4C
	str r1,[r0,#0x0]	; 0232CD50
	blx loc_0232CE2C	; 0232CD54
	mov r1,#0x0	; 0232CD58
	str r1,[r0,#0x4]	; 0232CD5C
	str r1,[r0,#0x8]	; 0232CD60
	str r1,[r0,#0xc]	; 0232CD64
	str r1,[r0,#0x10]	; 0232CD68
	str r1,[r0,#0x14]	; 0232CD6C
	ldmia sp!,{lr}	; 0232CD70
	bx lr	; 0232CD74
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x28, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232CD88
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232CD98
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 0232CDA8
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 0232CDB8
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x18, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232CDC8
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232CDD8
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 0232CDE8
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 0232CDEC
.thumb

; ===== function loc_0232CDEC =====
loc_0232CDEC:
	add r3,r0,#0x0	; 0232CDEC
	cmp r0,#0x0	; 0232CDEE
	beq loc_0232CE02	; 0232CDF0
	cmp r1,#0x0	; 0232CDF2
	beq loc_0232CE02	; 0232CDF4
	mov r2,#0x0	; 0232CDF6
loc_0232CDF8:
	strb r2,[r3,#0x0]	; 0232CDF8
	add r3,r3,#0x1	; 0232CDFA
	sub r1,r1,#0x1	; 0232CDFC
	cmp r1,#0x0	; 0232CDFE
	bne loc_0232CDF8	; 0232CE00
loc_0232CE02:
	bx lr	; 0232CE02

; ===== function loc_0232CE04 =====
loc_0232CE04:
	push {r4,lr}	; 0232CE04
	ldr r4,[pool_0232CE20]	; 0232CE06
	b loc_0232CE0E	; 0232CE08
loc_0232CE0A:
	blx r0	; 0232CE0A
	add r4,r4,#0x4	; 0232CE0C
loc_0232CE0E:
	cmp r4,#0x0	; 0232CE0E
	beq loc_0232CE18	; 0232CE10
	ldr r0,[r4,#0x0]	; 0232CE12
	cmp r0,#0x0	; 0232CE14
	bne loc_0232CE0A	; 0232CE16
loc_0232CE18:
	pop {r4}	; 0232CE18
	pop {r3}	; 0232CE1A
	bx r3	; 0232CE1C
	.byte 0xC0, 0x46	; 0232CE20
pool_0232CE20:
loc_0232CE20:
	.word 0x0233099C	; 0232CE20

; ===== function loc_0232CE24 =====
loc_0232CE24:
	ldr r0,[pool_0232CE28]	; 0232CE24
	bx lr	; 0232CE26
pool_0232CE28:
loc_0232CE28:
	.word 0x023574E8	; 0232CE28

; ===== function loc_0232CE2C =====
loc_0232CE2C:
	ldr r0,[pool_0232CE30]	; 0232CE2C
	bx lr	; 0232CE2E
pool_0232CE30:
loc_0232CE30:
	.word 0x023574EC	; 0232CE30

; ===== function loc_0232CE34 =====
loc_0232CE34:
	stmia r0!,{r1}	; 0232CE34
	mov r1,#0x0	; 0232CE36
	str r2,[r0,#0x8]	; 0232CE38
	mov r2,#0x0	; 0232CE3A
	stmia r0!,{r1,r2}	; 0232CE3C
	bx lr	; 0232CE3E

; ===== function loc_0232CE40 =====
loc_0232CE40:
	str r2,[r0,#0x0]	; 0232CE40
	str r1,[r0,#0x4]	; 0232CE42
	neg r1,r1	; 0232CE44
	str r1,[r0,#0x8]	; 0232CE46
	str r2,[r0,#0xc]	; 0232CE48
	bx lr	; 0232CE4A

; ===== function loc_0232CE4C =====
loc_0232CE4C:
	push {r4,r5,r6,r7,lr}	; 0232CE4C
	sub sp,#0x54	; 0232CE4E
	add r6,r0,#0x0	; 0232CE50
	add r5,r1,#0x0	; 0232CE52
	add r7,r2,#0x0	; 0232CE54
	cmp r7,r5	; 0232CE56
	bne loc_0232CE5E	; 0232CE58
	add r4,sp,#0x40	; 0232CE5A
	b loc_0232CE60	; 0232CE5C
loc_0232CE5E:
	add r4,r7,#0x0	; 0232CE5E
loc_0232CE60:
	ldr r0,[r6,#0x0]	; 0232CE60
	str r0,[sp,#0x10]	; 0232CE62
	ldr r0,[r6,#0x4]	; 0232CE64
	str r0,[sp,#0x14]	; 0232CE66
	asr r0,r0,#0x1f	; 0232CE68
	str r0,[sp,#0x18]	; 0232CE6A
	ldr r0,[sp,#0x10]	; 0232CE6C
	asr r0,r0,#0x1f	; 0232CE6E
	str r0,[sp,#0x1c]	; 0232CE70
	ldr r0,[sp,#0x10]	; 0232CE72
	ldr r1,[sp,#0x1c]	; 0232CE74
	ldr r2,[r5,#0x0]	; 0232CE76
	asr r3,r2,#0x1f	; 0232CE78
	blx P1_AeabiLmul	; 0232CE7A
	str r0,[sp,#0x20]	; 0232CE7E
	str r1,[sp,#0xc]	; 0232CE80
	ldr r0,[sp,#0x14]	; 0232CE82
	ldr r1,[sp,#0x18]	; 0232CE84
	ldr r2,[r5,#0x8]	; 0232CE86
	asr r3,r2,#0x1f	; 0232CE88
	blx P1_AeabiLmul	; 0232CE8A
	ldr r2,[sp,#0x20]	; 0232CE8E
	add r0,r2,r0	; 0232CE90
	ldr r2,[sp,#0xc]	; 0232CE92
	adc r2,r1	; 0232CE94
	str r2,[sp,#0xc]	; 0232CE96
	lsl r1,r2,#0x14	; 0232CE98
	lsr r0,r0,#0xc	; 0232CE9A
	orr r0,r1	; 0232CE9C
	str r0,[r4,#0x0]	; 0232CE9E
	ldr r0,[sp,#0x10]	; 0232CEA0
	ldr r1,[sp,#0x1c]	; 0232CEA2
	ldr r2,[r5,#0x4]	; 0232CEA4
	asr r3,r2,#0x1f	; 0232CEA6
	blx P1_AeabiLmul	; 0232CEA8
	str r0,[sp,#0x24]	; 0232CEAC
	str r1,[sp,#0x4]	; 0232CEAE
	ldr r0,[sp,#0x14]	; 0232CEB0
	ldr r1,[sp,#0x18]	; 0232CEB2
	ldr r2,[r5,#0xc]	; 0232CEB4
	asr r3,r2,#0x1f	; 0232CEB6
	blx P1_AeabiLmul	; 0232CEB8
	ldr r2,[sp,#0x24]	; 0232CEBC
	add r0,r2,r0	; 0232CEBE
	ldr r2,[sp,#0x4]	; 0232CEC0
	adc r2,r1	; 0232CEC2
	str r2,[sp,#0x4]	; 0232CEC4
	lsl r1,r2,#0x14	; 0232CEC6
	lsr r0,r0,#0xc	; 0232CEC8
	orr r0,r1	; 0232CECA
	str r0,[r4,#0x4]	; 0232CECC
	ldr r0,[r6,#0xc]	; 0232CECE
	str r0,[sp,#0x28]	; 0232CED0
	asr r0,r0,#0x1f	; 0232CED2
	str r0,[sp,#0x2c]	; 0232CED4
	ldr r0,[r6,#0x8]	; 0232CED6
	str r0,[sp,#0x30]	; 0232CED8
	asr r0,r0,#0x1f	; 0232CEDA
	str r0,[sp,#0x34]	; 0232CEDC
	ldr r0,[sp,#0x30]	; 0232CEDE
	ldr r1,[sp,#0x34]	; 0232CEE0
	ldr r2,[r5,#0x0]	; 0232CEE2
	asr r3,r2,#0x1f	; 0232CEE4
	blx P1_AeabiLmul	; 0232CEE6
	str r0,[sp,#0x38]	; 0232CEEA
	add r6,r1,#0x0	; 0232CEEC
	ldr r0,[sp,#0x28]	; 0232CEEE
	ldr r1,[sp,#0x2c]	; 0232CEF0
	ldr r2,[r5,#0x8]	; 0232CEF2
	asr r3,r2,#0x1f	; 0232CEF4
	blx P1_AeabiLmul	; 0232CEF6
	ldr r2,[sp,#0x38]	; 0232CEFA
	add r2,r2,r0	; 0232CEFC
	adc r6,r1	; 0232CEFE
	lsl r0,r6,#0x14	; 0232CF00
	lsr r1,r2,#0xc	; 0232CF02
	orr r1,r0	; 0232CF04
	str r1,[r4,#0x8]	; 0232CF06
	ldr r0,[sp,#0x30]	; 0232CF08
	ldr r1,[sp,#0x34]	; 0232CF0A
	ldr r2,[r5,#0x4]	; 0232CF0C
	asr r3,r2,#0x1f	; 0232CF0E
	blx P1_AeabiLmul	; 0232CF10
	str r0,[sp,#0x3c]	; 0232CF14
	add r6,r1,#0x0	; 0232CF16
	ldr r0,[sp,#0x28]	; 0232CF18
	ldr r1,[sp,#0x2c]	; 0232CF1A
	ldr r2,[r5,#0xc]	; 0232CF1C
	asr r3,r2,#0x1f	; 0232CF1E
	blx P1_AeabiLmul	; 0232CF20
	ldr r2,[sp,#0x3c]	; 0232CF24
	add r2,r2,r0	; 0232CF26
	adc r6,r1	; 0232CF28
	lsl r0,r6,#0x14	; 0232CF2A
	lsr r1,r2,#0xc	; 0232CF2C
	orr r1,r0	; 0232CF2E
	str r1,[r4,#0xc]	; 0232CF30
	add r2,sp,#0x40	; 0232CF32
	cmp r4,r2	; 0232CF34
	bne loc_0232CF40	; 0232CF36
	ldmia r2!,{r0,r1}	; 0232CF38
	stmia r7!,{r0,r1}	; 0232CF3A
	ldmia r2!,{r0,r1}	; 0232CF3C
	stmia r7!,{r0,r1}	; 0232CF3E
loc_0232CF40:
	add sp,#0x54	; 0232CF40
	pop {r4,r5,r6,r7}	; 0232CF42
	pop {r3}	; 0232CF44
	bx r3	; 0232CF46

; ===== function loc_0232CF48 =====
loc_0232CF48:
	push {r4}	; 0232CF48
	sub sp,#0x4	; 0232CF4A
	mov r4,#0x0	; 0232CF4C
	ldr r3,[pool_0232CF70]	; 0232CF4E
	strh r4,[r3,#0x0]	; 0232CF50
	ldr r2,[pool_0232CF74]	; 0232CF52
	str r0,[r2,#0x0]	; 0232CF54
	ldr r0,[pool_0232CF78]	; 0232CF56
	str r1,[r0,#0x0]	; 0232CF58
	str r4,[r0,#0x4]	; 0232CF5A
	ldr r0,[pool_0232CF7C]	; 0232CF5C
loc_0232CF5E:
	ldrh r1,[r3,#0x0]	; 0232CF5E
	and r1,r0	; 0232CF60
	cmp r1,#0x0	; 0232CF62
	bne loc_0232CF5E	; 0232CF64
	ldr r0,[pool_0232CF80]	; 0232CF66
	ldr r0,[r0,#0x0]	; 0232CF68
	add sp,#0x4	; 0232CF6A
	pop {r4}	; 0232CF6C
	bx lr	; 0232CF6E
pool_0232CF70:
loc_0232CF70:
	.word REG_DIVCNT	; 0232CF70
pool_0232CF74:
loc_0232CF74:
	.word REG_DIV_NUMER	; 0232CF74
pool_0232CF78:
loc_0232CF78:
	.word REG_DIV_DENOM	; 0232CF78
pool_0232CF7C:
loc_0232CF7C:
	.word 0x00008000	; 0232CF7C
pool_0232CF80:
loc_0232CF80:
	.word REG_DIV_RESULT	; 0232CF80

; ===== function loc_0232CF84 =====
loc_0232CF84:
	mov r2,#0x1	; 0232CF84
	ldr r1,[pool_0232CF9C]	; 0232CF86
	strh r2,[r1,#0x0]	; 0232CF88
	mov r3,#0x0	; 0232CF8A
	ldr r2,[pool_0232CFA0]	; 0232CF8C
	ldr r1,[pool_0232CFA4]	; 0232CF8E
	str r3,[r1,#0x0]	; 0232CF90
	str r2,[r1,#0x4]	; 0232CF92
	ldr r1,[pool_0232CFA8]	; 0232CF94
	str r0,[r1,#0x0]	; 0232CF96
	str r3,[r1,#0x4]	; 0232CF98
	bx lr	; 0232CF9A
pool_0232CF9C:
loc_0232CF9C:
	.word REG_DIVCNT	; 0232CF9C
pool_0232CFA0:
loc_0232CFA0:
	.word 0x00001000	; 0232CFA0
pool_0232CFA4:
loc_0232CFA4:
	.word REG_DIV_NUMER	; 0232CFA4
pool_0232CFA8:
loc_0232CFA8:
	.word REG_DIV_DENOM	; 0232CFA8

; ===== function loc_0232CFAC =====
loc_0232CFAC:
	ldr r1,[pool_0232CFD0]	; 0232CFAC
	ldr r0,[pool_0232CFD4]	; 0232CFAE
loc_0232CFB0:
	ldrh r2,[r1,#0x0]	; 0232CFB0
	and r2,r0	; 0232CFB2
	cmp r2,#0x0	; 0232CFB4
	bne loc_0232CFB0	; 0232CFB6
	ldr r0,[pool_0232CFD8]	; 0232CFB8
	ldr r2,[r0,#0x0]	; 0232CFBA
	ldr r3,[r0,#0x4]	; 0232CFBC
	mov r1,#0x0	; 0232CFBE
	ldr r0,[pool_0232CFDC]	; 0232CFC0
	add r0,r2,r0	; 0232CFC2
	adc r3,r1	; 0232CFC4
	lsl r1,r3,#0xc	; 0232CFC6
	lsr r0,r0,#0x14	; 0232CFC8
	orr r0,r1	; 0232CFCA
	bx lr	; 0232CFCC
	.byte 0xC0, 0x46	; 0232CFD0
pool_0232CFD0:
loc_0232CFD0:
	.word REG_DIVCNT	; 0232CFD0
pool_0232CFD4:
loc_0232CFD4:
	.word 0x00008000	; 0232CFD4
pool_0232CFD8:
loc_0232CFD8:
	.word REG_DIV_RESULT	; 0232CFD8
pool_0232CFDC:
loc_0232CFDC:
	.word 0x00080000	; 0232CFDC

; ===== function loc_0232CFE0 =====
loc_0232CFE0:
	push {lr}	; 0232CFE0
	sub sp,#0x4	; 0232CFE2
	bl loc_0232CF84	; 0232CFE4
	bl loc_0232CFAC	; 0232CFE8
	add sp,#0x4	; 0232CFEC
	pop {r3}	; 0232CFEE
	bx r3	; 0232CFF0
	.byte 0x00, 0x00	; 0232CFF4
.arm

; ===== function loc_0232CFF4 =====
loc_0232CFF4:
	smull r2,r1,r0,r1	; 0232CFF4
	mov r0,#0x800	; 0232CFF8
	adds r0,r2,r0	; 0232CFFC
	adc r1,r1,#0x0	; 0232D000
	mov r0,r0, lsr #0xc	; 0232D004
	orr r0,r0,r1, lsl #0x14	; 0232D008
	bx lr	; 0232D00C
.thumb

; ===== function loc_0232D010 =====
loc_0232D010:
	cmp r1,#0x0	; 0232D010
	bne loc_0232D01A	; 0232D012
	mov r1,#0x0	; 0232D014
	strh r1,[r0,#0x0]	; 0232D016
	bx lr	; 0232D018
loc_0232D01A:
	cmp r1,#0x0	; 0232D01A
	ble loc_0232D026	; 0232D01C
	ldr r2,[pool_0232D030]	; 0232D01E
	orr r1,r2	; 0232D020
	strh r1,[r0,#0x0]	; 0232D022
	bx lr	; 0232D024
loc_0232D026:
	neg r2,r1	; 0232D026
	ldr r1,[pool_0232D034]	; 0232D028
	orr r2,r1	; 0232D02A
	strh r2,[r0,#0x0]	; 0232D02C
	bx lr	; 0232D02E
pool_0232D030:
loc_0232D030:
	.word 0x00004000	; 0232D030
pool_0232D034:
loc_0232D034:
	.word 0x00008000	; 0232D034

; ===== function loc_0232D038 =====
loc_0232D038:
	ldr r2,[pool_0232D048]	; 0232D038
	ldr r3,[r2,#0x0]	; 0232D03A
	mov r1,#0x7	; 0232D03C
	bic r3,r1	; 0232D03E
	orr r3,r0	; 0232D040
	str r3,[r2,#0x0]	; 0232D042
	bx lr	; 0232D044
	.byte 0xC0, 0x46	; 0232D048
pool_0232D048:
loc_0232D048:
	.word REG_DISPCNT_B	; 0232D048

; ===== function loc_0232D04C =====
loc_0232D04C:
	push {r4}	; 0232D04C
	sub sp,#0x4	; 0232D04E
	ldr r3,[pool_0232D088]	; 0232D050
	ldr r3,[r3,#0x0]	; 0232D052
	ldr r4,[pool_0232D08C]	; 0232D054
	strh r0,[r4,#0x0]	; 0232D056
	ldr r4,[pool_0232D090]	; 0232D058
	ldrh r4,[r4,#0x0]	; 0232D05A
	cmp r4,#0x0	; 0232D05C
	bne loc_0232D062	; 0232D05E
	mov r0,#0x0	; 0232D060
loc_0232D062:
	lsl r4,r2,#0x3	; 0232D062
	ldr r2,[pool_0232D094]	; 0232D064
	and r3,r2	; 0232D066
	lsl r0,r0,#0x10	; 0232D068
	orr r3,r0	; 0232D06A
	orr r1,r3	; 0232D06C
	orr r4,r1	; 0232D06E
	ldr r0,[pool_0232D088]	; 0232D070
	str r4,[r0,#0x0]	; 0232D072
	ldr r0,[pool_0232D08C]	; 0232D074
	ldrh r0,[r0,#0x0]	; 0232D076
	cmp r0,#0x0	; 0232D078
	bne loc_0232D082	; 0232D07A
	mov r1,#0x0	; 0232D07C
	ldr r0,[pool_0232D090]	; 0232D07E
	strh r1,[r0,#0x0]	; 0232D080
loc_0232D082:
	add sp,#0x4	; 0232D082
	pop {r4}	; 0232D084
	bx lr	; 0232D086
pool_0232D088:
loc_0232D088:
	.word REG_DISPCNT_A	; 0232D088
pool_0232D08C:
loc_0232D08C:
	.word P1_BssStart + 0x266A4	; 0232D08C
pool_0232D090:
loc_0232D090:
	.word P1_Data_02330E48	; 0232D090
pool_0232D094:
loc_0232D094:
	.word 0xFFF0FFF0	; 0232D094

; ===== function loc_0232D098 =====
loc_0232D098:
	mov r1,#0x1	; 0232D098
	ldr r0,[pool_0232D0C4]	; 0232D09A
	strh r1,[r0,#0x0]	; 0232D09C
	ldr r0,[pool_0232D0C8]	; 0232D09E
	ldrh r3,[r0,#0x0]	; 0232D0A0
	cmp r3,#0x0	; 0232D0A2
	beq loc_0232D0B6	; 0232D0A4
	ldr r1,[pool_0232D0CC]	; 0232D0A6
	ldr r2,[r1,#0x0]	; 0232D0A8
	ldr r0,[pool_0232D0D0]	; 0232D0AA
	and r2,r0	; 0232D0AC
	lsl r0,r3,#0x10	; 0232D0AE
	orr r2,r0	; 0232D0B0
	str r2,[r1,#0x0]	; 0232D0B2
	bx lr	; 0232D0B4
loc_0232D0B6:
	ldr r1,[pool_0232D0CC]	; 0232D0B6
	ldr r2,[r1,#0x0]	; 0232D0B8
	ldr r0,[pool_0232D0D4]	; 0232D0BA
	orr r2,r0	; 0232D0BC
	str r2,[r1,#0x0]	; 0232D0BE
	bx lr	; 0232D0C0
	.byte 0xC0, 0x46	; 0232D0C4
pool_0232D0C4:
loc_0232D0C4:
	.word P1_Data_02330E48	; 0232D0C4
pool_0232D0C8:
loc_0232D0C8:
	.word P1_BssStart + 0x266A4	; 0232D0C8
pool_0232D0CC:
loc_0232D0CC:
	.word REG_DISPCNT_A	; 0232D0CC
pool_0232D0D0:
loc_0232D0D0:
	.word 0xFFFCFFFF	; 0232D0D0
pool_0232D0D4:
loc_0232D0D4:
	.word 0x00010000	; 0232D0D4

; ===== function loc_0232D0D8 =====
loc_0232D0D8:
	ldr r1,[pool_0232D0F8]	; 0232D0D8
	ldr r0,[r1,#0x0]	; 0232D0DA
	mov r3,#0x0	; 0232D0DC
	ldr r2,[pool_0232D0FC]	; 0232D0DE
	strh r3,[r2,#0x0]	; 0232D0E0
	ldr r2,[pool_0232D100]	; 0232D0E2
	add r3,r0,#0x0	; 0232D0E4
	and r3,r2	; 0232D0E6
	lsr r3,r3,#0x10	; 0232D0E8
	ldr r2,[pool_0232D104]	; 0232D0EA
	strh r3,[r2,#0x0]	; 0232D0EC
	ldr r2,[pool_0232D108]	; 0232D0EE
	and r0,r2	; 0232D0F0
	str r0,[r1,#0x0]	; 0232D0F2
	bx lr	; 0232D0F4
	.byte 0xC0, 0x46	; 0232D0F8
pool_0232D0F8:
loc_0232D0F8:
	.word REG_DISPCNT_A	; 0232D0F8
pool_0232D0FC:
loc_0232D0FC:
	.word P1_Data_02330E48	; 0232D0FC
pool_0232D100:
loc_0232D100:
	.word 0x00030000	; 0232D100
pool_0232D104:
loc_0232D104:
	.word P1_BssStart + 0x266A4	; 0232D104
pool_0232D108:
loc_0232D108:
	.word 0xFFFCFFFF	; 0232D108

; ===== function loc_0232D10C =====
loc_0232D10C:
	ldr r2,[pool_0232D12C]	; 0232D10C
	ldrh r3,[r2,#0x0]	; 0232D10E
	mov r1,#0x8	; 0232D110
	and r3,r1	; 0232D112
	cmp r0,#0x0	; 0232D114
	beq loc_0232D120	; 0232D116
	ldrh r0,[r2,#0x0]	; 0232D118
	orr r0,r1	; 0232D11A
	strh r0,[r2,#0x0]	; 0232D11C
	b loc_0232D126	; 0232D11E
loc_0232D120:
	ldrh r0,[r2,#0x0]	; 0232D120
	bic r0,r1	; 0232D122
	strh r0,[r2,#0x0]	; 0232D124
loc_0232D126:
	add r0,r3,#0x0	; 0232D126
	bx lr	; 0232D128
	.byte 0xC0, 0x46	; 0232D12C
pool_0232D12C:
loc_0232D12C:
	.word REG_DISPSTAT	; 0232D12C

; ===== function loc_0232D130 =====
loc_0232D130:
	push {lr}	; 0232D130
	sub sp,#0xc	; 0232D132
	ldr r0,[pool_0232D1CC]	; 0232D134
	ldrh r2,[r0,#0x0]	; 0232D136
	ldr r1,[pool_0232D1D0]	; 0232D138
	orr r2,r1	; 0232D13A
	strh r2,[r0,#0x0]	; 0232D13C
	ldrh r2,[r0,#0x0]	; 0232D13E
	ldr r1,[pool_0232D1D4]	; 0232D140
	and r2,r1	; 0232D142
	ldr r1,[pool_0232D1D8]	; 0232D144
	orr r2,r1	; 0232D146
	strh r2,[r0,#0x0]	; 0232D148
	ldrh r2,[r0,#0x0]	; 0232D14A
	mov r1,#0x1	; 0232D14C
	orr r2,r1	; 0232D14E
	strh r2,[r0,#0x0]	; 0232D150
	bl loc_0232D218	; 0232D152
	mov r2,#0x0	; 0232D156
	ldr r0,[pool_0232D1DC]	; 0232D158
	strh r2,[r0,#0x0]	; 0232D15A
	ldr r0,[pool_0232D1E0]	; 0232D15C
	str r2,[r0,#0x0]	; 0232D15E
	ldr r0,[pool_0232D1E4]	; 0232D160
	ldr r0,[r0,#0x0]	; 0232D162
	mvn r1,r2	; 0232D164
	cmp r0,r1	; 0232D166
	beq loc_0232D186	; 0232D168
	ldr r1,[pool_0232D1E8]	; 0232D16A
	mov r3,#0x60	; 0232D16C
	bl loc_0232E290	; 0232D16E
	mov r2,#0x0	; 0232D172
	ldr r0,[pool_0232D1EC]	; 0232D174
	strh r2,[r0,#0x0]	; 0232D176
	ldr r0,[pool_0232D1E4]	; 0232D178
	ldr r0,[r0,#0x0]	; 0232D17A
	ldr r1,[pool_0232D1F0]	; 0232D17C
	mov r3,#0x70	; 0232D17E
	bl loc_0232E290	; 0232D180
	b loc_0232D1A4	; 0232D184
loc_0232D186:
	str r2,[sp,#0x0]	; 0232D186
	ldr r0,[sp,#0x0]	; 0232D188
	ldr r1,[pool_0232D1E8]	; 0232D18A
	mov r2,#0x60	; 0232D18C
	blx loc_0232E318	; 0232D18E
	mov r1,#0x0	; 0232D192
	ldr r0,[pool_0232D1EC]	; 0232D194
	strh r1,[r0,#0x0]	; 0232D196
	str r1,[sp,#0x4]	; 0232D198
	ldr r0,[sp,#0x4]	; 0232D19A
	ldr r1,[pool_0232D1F0]	; 0232D19C
	mov r2,#0x70	; 0232D19E
	blx loc_0232E318	; 0232D1A0
loc_0232D1A4:
	ldr r0,[pool_0232D1F4]	; 0232D1A4
	ldr r1,[pool_0232D1F8]	; 0232D1A6
	strh r0,[r1,#0x0]	; 0232D1A8
	ldr r1,[pool_0232D1FC]	; 0232D1AA
	strh r0,[r1,#0x0]	; 0232D1AC
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
	add sp,#0xc	; 0232D1C6
	pop {r3}	; 0232D1C8
	bx r3	; 0232D1CA
pool_0232D1CC:
loc_0232D1CC:
	.word REG_POWERCNT	; 0232D1CC
pool_0232D1D0:
loc_0232D1D0:
	.word 0x00008000	; 0232D1D0
pool_0232D1D4:
loc_0232D1D4:
	.word 0xFFFFFDF1	; 0232D1D4
pool_0232D1D8:
loc_0232D1D8:
	.word 0x0000020E	; 0232D1D8
pool_0232D1DC:
loc_0232D1DC:
	.word REG_DISPSTAT	; 0232D1DC
pool_0232D1E0:
loc_0232D1E0:
	.word REG_DISPCNT_A	; 0232D1E0
pool_0232D1E4:
loc_0232D1E4:
	.word P1_Data_02330E4C	; 0232D1E4
pool_0232D1E8:
loc_0232D1E8:
	.word REG_BG0CNT	; 0232D1E8
pool_0232D1EC:
loc_0232D1EC:
	.word REG_MASTER_BRIGHT	; 0232D1EC
pool_0232D1F0:
loc_0232D1F0:
	.word REG_DISPCNT_B	; 0232D1F0
pool_0232D1F4:
loc_0232D1F4:
	.word 0x00000100	; 0232D1F4
pool_0232D1F8:
loc_0232D1F8:
	.word REG_BG2PA	; 0232D1F8
pool_0232D1FC:
loc_0232D1FC:
	.word REG_BG2PD	; 0232D1FC
pool_0232D200:
loc_0232D200:
	.word REG_BG3PA	; 0232D200
pool_0232D204:
loc_0232D204:
	.word REG_BG3PD	; 0232D204
pool_0232D208:
loc_0232D208:
	.word REG_BG2PA_SUB	; 0232D208
pool_0232D20C:
loc_0232D20C:
	.word REG_BG2PD_SUB	; 0232D20C
pool_0232D210:
loc_0232D210:
	.word REG_BG3PA_SUB	; 0232D210
pool_0232D214:
loc_0232D214:
	.word REG_BG3PD_SUB	; 0232D214

; ===== function loc_0232D218 =====
loc_0232D218:
	mov r1,#0x0	; 0232D218
	ldr r0,[pool_0232D24C]	; 0232D21A
	strh r1,[r0,#0x0]	; 0232D21C
	strh r1,[r0,#0x2]	; 0232D21E
	strh r1,[r0,#0x4]	; 0232D220
	strh r1,[r0,#0x6]	; 0232D222
	strh r1,[r0,#0x8]	; 0232D224
	strh r1,[r0,#0xa]	; 0232D226
	strh r1,[r0,#0xc]	; 0232D228
	strh r1,[r0,#0xe]	; 0232D22A
	strh r1,[r0,#0x10]	; 0232D22C
	strh r1,[r0,#0x12]	; 0232D22E
	strh r1,[r0,#0x14]	; 0232D230
	strh r1,[r0,#0x16]	; 0232D232
	strh r1,[r0,#0x18]	; 0232D234
	ldr r0,[pool_0232D250]	; 0232D236
	str r1,[r0,#0x0]	; 0232D238
	ldr r0,[pool_0232D254]	; 0232D23A
	strb r1,[r0,#0x0]	; 0232D23C
	ldr r0,[pool_0232D258]	; 0232D23E
	strb r1,[r0,#0x0]	; 0232D240
	ldr r0,[pool_0232D25C]	; 0232D242
	strb r1,[r0,#0x0]	; 0232D244
	ldr r0,[pool_0232D260]	; 0232D246
	strh r1,[r0,#0x0]	; 0232D248
	bx lr	; 0232D24A
pool_0232D24C:
loc_0232D24C:
	.word P1_BssStart + 0x266A8	; 0232D24C
pool_0232D250:
loc_0232D250:
	.word VRAM_A_CR	; 0232D250
pool_0232D254:
loc_0232D254:
	.word VRAM_E_CR	; 0232D254
pool_0232D258:
loc_0232D258:
	.word VRAM_F_CR	; 0232D258
pool_0232D25C:
loc_0232D25C:
	.word VRAM_G_CR	; 0232D25C
pool_0232D260:
loc_0232D260:
	.word VRAM_H_CR	; 0232D260

; ===== function loc_0232D264 =====
loc_0232D264:
	ldr r0,[pool_0232D26C]	; 0232D264
	ldr r3,[pool_0232D270]	; 0232D266
	bx r3	; 0232D268
	.byte 0xC0, 0x46	; 0232D26C
pool_0232D26C:
loc_0232D26C:
	.word 0x0235751C	; 0232D26C
pool_0232D270:
loc_0232D270:
	.word loc_0232D2C4 + 1	; 0232D270

; ===== function loc_0232D274 =====
loc_0232D274:
	ldr r0,[pool_0232D27C]	; 0232D274
	ldr r3,[pool_0232D280]	; 0232D276
	bx r3	; 0232D278
	.byte 0xC0, 0x46	; 0232D27C
pool_0232D27C:
loc_0232D27C:
	.word 0x0235751A	; 0232D27C
pool_0232D280:
loc_0232D280:
	.word loc_0232D2C4 + 1	; 0232D280

; ===== function loc_0232D284 =====
loc_0232D284:
	ldr r0,[pool_0232D28C]	; 0232D284
	ldr r3,[pool_0232D290]	; 0232D286
	bx r3	; 0232D288
	.byte 0xC0, 0x46	; 0232D28C
pool_0232D28C:
loc_0232D28C:
	.word 0x02357508	; 0232D28C
pool_0232D290:
loc_0232D290:
	.word loc_0232D2C4 + 1	; 0232D290

; ===== function loc_0232D294 =====
loc_0232D294:
	ldr r0,[pool_0232D29C]	; 0232D294
	ldr r3,[pool_0232D2A0]	; 0232D296
	bx r3	; 0232D298
	.byte 0xC0, 0x46	; 0232D29C
pool_0232D29C:
loc_0232D29C:
	.word 0x0235750E	; 0232D29C
pool_0232D2A0:
loc_0232D2A0:
	.word loc_0232D2C4 + 1	; 0232D2A0

; ===== function loc_0232D2A4 =====
loc_0232D2A4:
	ldr r0,[pool_0232D2AC]	; 0232D2A4
	ldr r3,[pool_0232D2B0]	; 0232D2A6
	bx r3	; 0232D2A8
	.byte 0xC0, 0x46	; 0232D2AC
pool_0232D2AC:
loc_0232D2AC:
	.word 0x0235750C	; 0232D2AC
pool_0232D2B0:
loc_0232D2B0:
	.word loc_0232D2C4 + 1	; 0232D2B0

; ===== function loc_0232D2B4 =====
loc_0232D2B4:
	ldr r0,[pool_0232D2BC]	; 0232D2B4
	ldr r3,[pool_0232D2C0]	; 0232D2B6
	bx r3	; 0232D2B8
	.byte 0xC0, 0x46	; 0232D2BC
pool_0232D2BC:
loc_0232D2BC:
	.word 0x0235750A	; 0232D2BC
pool_0232D2C0:
loc_0232D2C0:
	.word loc_0232D2C4 + 1	; 0232D2C0
loc_0232D2C4:
	ldrh r1,[r0,#0x0]	; 0232D2C4
	mov r3,#0x0	; 0232D2C6
	strh r3,[r0,#0x0]	; 0232D2C8
	mov r0,#0x1	; 0232D2CA
	add r2,r1,#0x0	; 0232D2CC
	and r2,r0	; 0232D2CE
	cmp r2,#0x0	; 0232D2D0
	beq loc_0232D2D8	; 0232D2D2
	ldr r0,[pool_0232D35C]	; 0232D2D4
	strb r3,[r0,#0x0]	; 0232D2D6
loc_0232D2D8:
	mov r0,#0x2	; 0232D2D8
	add r2,r1,#0x0	; 0232D2DA
	and r2,r0	; 0232D2DC
	cmp r2,#0x0	; 0232D2DE
	beq loc_0232D2E8	; 0232D2E0
	mov r2,#0x0	; 0232D2E2
	ldr r0,[pool_0232D360]	; 0232D2E4
	strb r2,[r0,#0x0]	; 0232D2E6
loc_0232D2E8:
	mov r0,#0x4	; 0232D2E8
	add r2,r1,#0x0	; 0232D2EA
	and r2,r0	; 0232D2EC
	cmp r2,#0x0	; 0232D2EE
	beq loc_0232D2F8	; 0232D2F0
	mov r2,#0x0	; 0232D2F2
	ldr r0,[pool_0232D364]	; 0232D2F4
	strb r2,[r0,#0x0]	; 0232D2F6
loc_0232D2F8:
	mov r0,#0x8	; 0232D2F8
	add r2,r1,#0x0	; 0232D2FA
	and r2,r0	; 0232D2FC
	cmp r2,#0x0	; 0232D2FE
	beq loc_0232D308	; 0232D300
	mov r2,#0x0	; 0232D302
	ldr r0,[pool_0232D368]	; 0232D304
	strb r2,[r0,#0x0]	; 0232D306
loc_0232D308:
	mov r0,#0x10	; 0232D308
	add r2,r1,#0x0	; 0232D30A
	and r2,r0	; 0232D30C
	cmp r2,#0x0	; 0232D30E
	beq loc_0232D318	; 0232D310
	mov r2,#0x0	; 0232D312
	ldr r0,[pool_0232D36C]	; 0232D314
	strb r2,[r0,#0x0]	; 0232D316
loc_0232D318:
	mov r0,#0x20	; 0232D318
	add r2,r1,#0x0	; 0232D31A
	and r2,r0	; 0232D31C
	cmp r2,#0x0	; 0232D31E
	beq loc_0232D328	; 0232D320
	mov r2,#0x0	; 0232D322
	ldr r0,[pool_0232D370]	; 0232D324
	strb r2,[r0,#0x0]	; 0232D326
loc_0232D328:
	mov r0,#0x40	; 0232D328
	add r2,r1,#0x0	; 0232D32A
	and r2,r0	; 0232D32C
	cmp r2,#0x0	; 0232D32E
	beq loc_0232D338	; 0232D330
	mov r2,#0x0	; 0232D332
	ldr r0,[pool_0232D374]	; 0232D334
	strb r2,[r0,#0x0]	; 0232D336
loc_0232D338:
	mov r0,#0x80	; 0232D338
	add r2,r1,#0x0	; 0232D33A
	and r2,r0	; 0232D33C
	cmp r2,#0x0	; 0232D33E
	beq loc_0232D348	; 0232D340
	mov r2,#0x0	; 0232D342
	ldr r0,[pool_0232D378]	; 0232D344
	strb r2,[r0,#0x0]	; 0232D346
loc_0232D348:
	ldr r0,[pool_0232D37C]	; 0232D348
	add r2,r1,#0x0	; 0232D34A
	and r2,r0	; 0232D34C
	cmp r2,#0x0	; 0232D34E
	beq loc_0232D358	; 0232D350
	mov r2,#0x0	; 0232D352
	ldr r0,[pool_0232D380]	; 0232D354
	strb r2,[r0,#0x0]	; 0232D356
loc_0232D358:
	add r0,r1,#0x0	; 0232D358
	bx lr	; 0232D35A
pool_0232D35C:
loc_0232D35C:
	.word VRAM_A_CR	; 0232D35C
pool_0232D360:
loc_0232D360:
	.word VRAM_B_CR	; 0232D360
pool_0232D364:
loc_0232D364:
	.word VRAM_C_CR	; 0232D364
pool_0232D368:
loc_0232D368:
	.word VRAM_D_CR	; 0232D368
pool_0232D36C:
loc_0232D36C:
	.word VRAM_E_CR	; 0232D36C
pool_0232D370:
loc_0232D370:
	.word VRAM_F_CR	; 0232D370
pool_0232D374:
loc_0232D374:
	.word VRAM_G_CR	; 0232D374
pool_0232D378:
loc_0232D378:
	.word VRAM_H_CR	; 0232D378
pool_0232D37C:
loc_0232D37C:
	.word 0x00000100	; 0232D37C
pool_0232D380:
loc_0232D380:
	.word VRAM_I_CR	; 0232D380

; ===== function loc_0232D384 =====
loc_0232D384:
	push {r4,lr}	; 0232D384
	mvn r4,r0	; 0232D386
	ldr r1,[pool_0232D3C4]	; 0232D388
	ldrh r3,[r1,#0x0]	; 0232D38A
	ldrh r2,[r1,#0x14]	; 0232D38C
	orr r3,r2	; 0232D38E
	and r4,r3	; 0232D390
	strh r4,[r1,#0x0]	; 0232D392
	strh r0,[r1,#0x14]	; 0232D394
	cmp r0,#0x0	; 0232D396
	beq loc_0232D3B4	; 0232D398
	cmp r0,#0x8	; 0232D39A
	beq loc_0232D3A6	; 0232D39C
	ldr r1,[pool_0232D3C8]	; 0232D39E
	cmp r0,r1	; 0232D3A0
	beq loc_0232D3AE	; 0232D3A2
	b loc_0232D3B4	; 0232D3A4
loc_0232D3A6:
	mov r1,#0x84	; 0232D3A6
	ldr r0,[pool_0232D3CC]	; 0232D3A8
	strb r1,[r0,#0x0]	; 0232D3AA
	b loc_0232D3B4	; 0232D3AC
loc_0232D3AE:
	mov r1,#0x82	; 0232D3AE
	ldr r0,[pool_0232D3D0]	; 0232D3B0
	strb r1,[r0,#0x0]	; 0232D3B2
loc_0232D3B4:
	ldr r0,[pool_0232D3C4]	; 0232D3B4
	ldrh r0,[r0,#0x0]	; 0232D3B6
	bl loc_0232D6A4	; 0232D3B8
	pop {r4}	; 0232D3BC
	pop {r3}	; 0232D3BE
	bx r3	; 0232D3C0
	.byte 0xC0, 0x46	; 0232D3C4
pool_0232D3C4:
loc_0232D3C4:
	.word P1_BssStart + 0x266A8	; 0232D3C4
pool_0232D3C8:
loc_0232D3C8:
	.word 0x00000100	; 0232D3C8
pool_0232D3CC:
loc_0232D3CC:
	.word VRAM_D_CR	; 0232D3CC
pool_0232D3D0:
loc_0232D3D0:
	.word VRAM_I_CR	; 0232D3D0

; ===== function loc_0232D3D4 =====
loc_0232D3D4:
	push {r4,lr}	; 0232D3D4
	mvn r4,r0	; 0232D3D6
	ldr r1,[pool_0232D42C]	; 0232D3D8
	ldrh r3,[r1,#0x0]	; 0232D3DA
	ldrh r2,[r1,#0x12]	; 0232D3DC
	orr r3,r2	; 0232D3DE
	and r4,r3	; 0232D3E0
	strh r4,[r1,#0x0]	; 0232D3E2
	strh r0,[r1,#0x12]	; 0232D3E4
	cmp r0,#0x80	; 0232D3E6
	bgt loc_0232D400	; 0232D3E8
	cmp r0,#0x80	; 0232D3EA
	bge loc_0232D416	; 0232D3EC
	cmp r0,#0x4	; 0232D3EE
	bgt loc_0232D41C	; 0232D3F0
	cmp r0,#0x0	; 0232D3F2
	blt loc_0232D41C	; 0232D3F4
	cmp r0,#0x0	; 0232D3F6
	beq loc_0232D41C	; 0232D3F8
	cmp r0,#0x4	; 0232D3FA
	beq loc_0232D408	; 0232D3FC
	b loc_0232D41C	; 0232D3FE
loc_0232D400:
	ldr r1,[pool_0232D430]	; 0232D400
	cmp r0,r1	; 0232D402
	beq loc_0232D410	; 0232D404
	b loc_0232D41C	; 0232D406
loc_0232D408:
	mov r1,#0x84	; 0232D408
	ldr r0,[pool_0232D434]	; 0232D40A
	strb r1,[r0,#0x0]	; 0232D40C
	b loc_0232D41C	; 0232D40E
loc_0232D410:
	mov r1,#0x81	; 0232D410
	ldr r0,[pool_0232D438]	; 0232D412
	strb r1,[r0,#0x0]	; 0232D414
loc_0232D416:
	mov r1,#0x81	; 0232D416
	ldr r0,[pool_0232D43C]	; 0232D418
	strb r1,[r0,#0x0]	; 0232D41A
loc_0232D41C:
	ldr r0,[pool_0232D42C]	; 0232D41C
	ldrh r0,[r0,#0x0]	; 0232D41E
	bl loc_0232D6A4	; 0232D420
	pop {r4}	; 0232D424
	pop {r3}	; 0232D426
	bx r3	; 0232D428
	.byte 0xC0, 0x46	; 0232D42C
pool_0232D42C:
loc_0232D42C:
	.word P1_BssStart + 0x266A8	; 0232D42C
pool_0232D430:
loc_0232D430:
	.word 0x00000180	; 0232D430
pool_0232D434:
loc_0232D434:
	.word VRAM_C_CR	; 0232D434
pool_0232D438:
loc_0232D438:
	.word VRAM_I_CR	; 0232D438
pool_0232D43C:
loc_0232D43C:
	.word VRAM_H_CR	; 0232D43C

; ===== function loc_0232D440 =====
loc_0232D440:
	ldr r1,[pool_0232D44C]	; 0232D440
	ldrh r2,[r1,#0x0]	; 0232D442
	orr r2,r0	; 0232D444
	strh r2,[r1,#0x0]	; 0232D446
	ldr r3,[pool_0232D450]	; 0232D448
	bx r3	; 0232D44A
pool_0232D44C:
loc_0232D44C:
	.word P1_BssStart + 0x266A8	; 0232D44C
pool_0232D450:
loc_0232D450:
	.word P1_EnableVramBanksByMask + 1	; 0232D450

; ===== function loc_0232D454 =====
loc_0232D454:
	push {r4,lr}	; 0232D454
	mvn r4,r0	; 0232D456
	ldr r1,[pool_0232D510]	; 0232D458
	ldrh r3,[r1,#0x0]	; 0232D45A
	ldrh r2,[r1,#0x4]	; 0232D45C
	orr r3,r2	; 0232D45E
	and r4,r3	; 0232D460
	strh r4,[r1,#0x0]	; 0232D462
	strh r0,[r1,#0x4]	; 0232D464
	cmp r0,#0x30	; 0232D466
	bgt loc_0232D496	; 0232D468
	cmp r0,#0x30	; 0232D46A
	bge loc_0232D4D0	; 0232D46C
	cmp r0,#0x10	; 0232D46E
	bgt loc_0232D490	; 0232D470
	cmp r0,#0x10	; 0232D472
	bge loc_0232D4D6	; 0232D474
	cmp r0,#0x3	; 0232D476
	bhi loc_0232D500	; 0232D478
	add r1,r0,r0	; 0232D47A
P1_SwitchIndexPC_0232D47A:
	add r1,pc	; 0232D47C
	ldrh r1,[r1,#(P1_SwitchTable_0232D47A - (P1_SwitchIndexPC_0232D47A + 4))]	; 0232D47E
	lsl r1,r1,#0x10	; 0232D480
	asr r1,r1,#0x10	; 0232D482
P1_SwitchTargetPC_0232D47A:
	add r1,pc	; 0232D484
	bx r1	; 0232D486
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232D47A:
	.halfword (loc_0232D500 + 1) - (P1_SwitchTargetPC_0232D47A + 4)
	.halfword (loc_0232D4BA + 1) - (P1_SwitchTargetPC_0232D47A + 4)
	.halfword (loc_0232D4C2 + 1) - (P1_SwitchTargetPC_0232D47A + 4)
	.halfword (loc_0232D4B4 + 1) - (P1_SwitchTargetPC_0232D47A + 4)
P1_SwitchTable_0232D47AEnd:
loc_0232D490:
	cmp r0,#0x20	; 0232D490
	beq loc_0232D4F2	; 0232D492
	b loc_0232D500	; 0232D494
loc_0232D496:
	cmp r0,#0x50	; 0232D496
	bgt loc_0232D4A4	; 0232D498
	cmp r0,#0x50	; 0232D49A
	bge loc_0232D4DE	; 0232D49C
	cmp r0,#0x40	; 0232D49E
	beq loc_0232D4FA	; 0232D4A0
	b loc_0232D500	; 0232D4A2
loc_0232D4A4:
	cmp r0,#0x60	; 0232D4A4
	bgt loc_0232D4AE	; 0232D4A6
	cmp r0,#0x60	; 0232D4A8
	beq loc_0232D4EC	; 0232D4AA
	b loc_0232D500	; 0232D4AC
loc_0232D4AE:
	cmp r0,#0x70	; 0232D4AE
	beq loc_0232D4CA	; 0232D4B0
	b loc_0232D500	; 0232D4B2
loc_0232D4B4:
	mov r1,#0x8a	; 0232D4B4
	ldr r0,[pool_0232D514]	; 0232D4B6
	strb r1,[r0,#0x0]	; 0232D4B8
loc_0232D4BA:
	mov r1,#0x82	; 0232D4BA
	ldr r0,[pool_0232D518]	; 0232D4BC
	strb r1,[r0,#0x0]	; 0232D4BE
	b loc_0232D500	; 0232D4C0
loc_0232D4C2:
	mov r1,#0x82	; 0232D4C2
	ldr r0,[pool_0232D514]	; 0232D4C4
	strb r1,[r0,#0x0]	; 0232D4C6
	b loc_0232D500	; 0232D4C8
loc_0232D4CA:
	mov r1,#0x9a	; 0232D4CA
	ldr r0,[pool_0232D51C]	; 0232D4CC
	strb r1,[r0,#0x0]	; 0232D4CE
loc_0232D4D0:
	mov r1,#0x92	; 0232D4D0
	ldr r0,[pool_0232D520]	; 0232D4D2
	strb r1,[r0,#0x0]	; 0232D4D4
loc_0232D4D6:
	mov r1,#0x82	; 0232D4D6
	ldr r0,[pool_0232D524]	; 0232D4D8
	strb r1,[r0,#0x0]	; 0232D4DA
	b loc_0232D500	; 0232D4DC
loc_0232D4DE:
	mov r1,#0x92	; 0232D4DE
	ldr r0,[pool_0232D51C]	; 0232D4E0
	strb r1,[r0,#0x0]	; 0232D4E2
	mov r1,#0x82	; 0232D4E4
	ldr r0,[pool_0232D524]	; 0232D4E6
	strb r1,[r0,#0x0]	; 0232D4E8
	b loc_0232D500	; 0232D4EA
loc_0232D4EC:
	mov r1,#0x8a	; 0232D4EC
	ldr r0,[pool_0232D51C]	; 0232D4EE
	strb r1,[r0,#0x0]	; 0232D4F0
loc_0232D4F2:
	mov r1,#0x82	; 0232D4F2
	ldr r0,[pool_0232D520]	; 0232D4F4
	strb r1,[r0,#0x0]	; 0232D4F6
	b loc_0232D500	; 0232D4F8
loc_0232D4FA:
	mov r1,#0x82	; 0232D4FA
	ldr r0,[pool_0232D51C]	; 0232D4FC
	strb r1,[r0,#0x0]	; 0232D4FE
loc_0232D500:
	ldr r0,[pool_0232D510]	; 0232D500
	ldrh r0,[r0,#0x0]	; 0232D502
	bl loc_0232D6A4	; 0232D504
	pop {r4}	; 0232D508
	pop {r3}	; 0232D50A
	bx r3	; 0232D50C
	.byte 0xC0, 0x46	; 0232D510
pool_0232D510:
loc_0232D510:
	.word P1_BssStart + 0x266A8	; 0232D510
pool_0232D514:
loc_0232D514:
	.word VRAM_B_CR	; 0232D514
pool_0232D518:
loc_0232D518:
	.word VRAM_A_CR	; 0232D518
pool_0232D51C:
loc_0232D51C:
	.word VRAM_G_CR	; 0232D51C
pool_0232D520:
loc_0232D520:
	.word VRAM_F_CR	; 0232D520
pool_0232D524:
loc_0232D524:
	.word VRAM_E_CR	; 0232D524

; ===== function loc_0232D528 =====
loc_0232D528:
	push {r4,lr}	; 0232D528
	mvn r4,r0	; 0232D52A
	ldr r1,[pool_0232D684]	; 0232D52C
	ldrh r3,[r1,#0x0]	; 0232D52E
	ldrh r2,[r1,#0x2]	; 0232D530
	orr r3,r2	; 0232D532
	and r4,r3	; 0232D534
	strh r4,[r1,#0x0]	; 0232D536
	strh r0,[r1,#0x2]	; 0232D538
	cmp r0,#0x40	; 0232D53A
	bgt loc_0232D5A4	; 0232D53C
	cmp r0,#0x40	; 0232D53E
	blt loc_0232D544	; 0232D540
	b loc_0232D670	; 0232D542
loc_0232D544:
	cmp r0,#0x20	; 0232D544
	bgt loc_0232D59E	; 0232D546
	cmp r0,#0x0	; 0232D548
	bge loc_0232D54E	; 0232D54A
	b loc_0232D676	; 0232D54C
loc_0232D54E:
	add r1,r0,r0	; 0232D54E
P1_SwitchIndexPC_0232D54E:
	add r1,pc	; 0232D550
	ldrh r1,[r1,#(P1_SwitchTable_0232D54E - (P1_SwitchIndexPC_0232D54E + 4))]	; 0232D552
	lsl r1,r1,#0x10	; 0232D554
	asr r1,r1,#0x10	; 0232D556
P1_SwitchTargetPC_0232D54E:
	add r1,pc	; 0232D558
	bx r1	; 0232D55A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232D54E:
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5F4 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5DA + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5EE + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5C6 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D616 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5D4 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5E8 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5B8 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D624 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D632 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5FC + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5C0 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D610 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5CE + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D5E2 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D64C + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D676 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
	.halfword (loc_0232D668 + 1) - (P1_SwitchTargetPC_0232D54E + 4)
P1_SwitchTable_0232D54EEnd:
loc_0232D59E:
	cmp r0,#0x30	; 0232D59E
	beq loc_0232D646	; 0232D5A0
	b loc_0232D676	; 0232D5A2
loc_0232D5A4:
	cmp r0,#0x60	; 0232D5A4
	bgt loc_0232D5B2	; 0232D5A6
	cmp r0,#0x60	; 0232D5A8
	bge loc_0232D662	; 0232D5AA
	cmp r0,#0x50	; 0232D5AC
	beq loc_0232D654	; 0232D5AE
	b loc_0232D676	; 0232D5B0
loc_0232D5B2:
	cmp r0,#0x70	; 0232D5B2
	beq loc_0232D640	; 0232D5B4
	b loc_0232D676	; 0232D5B6
loc_0232D5B8:
	mov r1,#0x81	; 0232D5B8
	ldr r0,[pool_0232D688]	; 0232D5BA
	strb r1,[r0,#0x0]	; 0232D5BC
	b loc_0232D676	; 0232D5BE
loc_0232D5C0:
	mov r1,#0x89	; 0232D5C0
	ldr r0,[pool_0232D688]	; 0232D5C2
	strb r1,[r0,#0x0]	; 0232D5C4
loc_0232D5C6:
	mov r1,#0x81	; 0232D5C6
	ldr r0,[pool_0232D68C]	; 0232D5C8
	strb r1,[r0,#0x0]	; 0232D5CA
	b loc_0232D676	; 0232D5CC
loc_0232D5CE:
	mov r1,#0x91	; 0232D5CE
	ldr r0,[pool_0232D688]	; 0232D5D0
	strb r1,[r0,#0x0]	; 0232D5D2
loc_0232D5D4:
	mov r1,#0x89	; 0232D5D4
	ldr r0,[pool_0232D68C]	; 0232D5D6
	strb r1,[r0,#0x0]	; 0232D5D8
loc_0232D5DA:
	mov r1,#0x81	; 0232D5DA
	ldr r0,[pool_0232D690]	; 0232D5DC
	strb r1,[r0,#0x0]	; 0232D5DE
	b loc_0232D676	; 0232D5E0
loc_0232D5E2:
	mov r1,#0x99	; 0232D5E2
	ldr r0,[pool_0232D688]	; 0232D5E4
	strb r1,[r0,#0x0]	; 0232D5E6
loc_0232D5E8:
	mov r1,#0x91	; 0232D5E8
	ldr r0,[pool_0232D68C]	; 0232D5EA
	strb r1,[r0,#0x0]	; 0232D5EC
loc_0232D5EE:
	mov r1,#0x89	; 0232D5EE
	ldr r0,[pool_0232D690]	; 0232D5F0
	strb r1,[r0,#0x0]	; 0232D5F2
loc_0232D5F4:
	mov r1,#0x81	; 0232D5F4
	ldr r0,[pool_0232D694]	; 0232D5F6
	strb r1,[r0,#0x0]	; 0232D5F8
	b loc_0232D676	; 0232D5FA
loc_0232D5FC:
	mov r1,#0x81	; 0232D5FC
	ldr r0,[pool_0232D694]	; 0232D5FE
	strb r1,[r0,#0x0]	; 0232D600
	mov r1,#0x89	; 0232D602
	ldr r0,[pool_0232D690]	; 0232D604
	strb r1,[r0,#0x0]	; 0232D606
	mov r1,#0x91	; 0232D608
	ldr r0,[pool_0232D688]	; 0232D60A
	strb r1,[r0,#0x0]	; 0232D60C
	b loc_0232D676	; 0232D60E
loc_0232D610:
	mov r1,#0x91	; 0232D610
	ldr r0,[pool_0232D688]	; 0232D612
	strb r1,[r0,#0x0]	; 0232D614
loc_0232D616:
	mov r1,#0x81	; 0232D616
	ldr r0,[pool_0232D694]	; 0232D618
	strb r1,[r0,#0x0]	; 0232D61A
	mov r1,#0x89	; 0232D61C
	ldr r0,[pool_0232D68C]	; 0232D61E
	strb r1,[r0,#0x0]	; 0232D620
	b loc_0232D676	; 0232D622
loc_0232D624:
	mov r1,#0x81	; 0232D624
	ldr r0,[pool_0232D694]	; 0232D626
	strb r1,[r0,#0x0]	; 0232D628
	mov r1,#0x89	; 0232D62A
	ldr r0,[pool_0232D688]	; 0232D62C
	strb r1,[r0,#0x0]	; 0232D62E
	b loc_0232D676	; 0232D630
loc_0232D632:
	mov r1,#0x81	; 0232D632
	ldr r0,[pool_0232D690]	; 0232D634
	strb r1,[r0,#0x0]	; 0232D636
	mov r1,#0x89	; 0232D638
	ldr r0,[pool_0232D688]	; 0232D63A
	strb r1,[r0,#0x0]	; 0232D63C
	b loc_0232D676	; 0232D63E
loc_0232D640:
	mov r1,#0x99	; 0232D640
	ldr r0,[pool_0232D698]	; 0232D642
	strb r1,[r0,#0x0]	; 0232D644
loc_0232D646:
	mov r1,#0x91	; 0232D646
	ldr r0,[pool_0232D69C]	; 0232D648
	strb r1,[r0,#0x0]	; 0232D64A
loc_0232D64C:
	mov r1,#0x81	; 0232D64C
	ldr r0,[pool_0232D6A0]	; 0232D64E
	strb r1,[r0,#0x0]	; 0232D650
	b loc_0232D676	; 0232D652
loc_0232D654:
	mov r1,#0x91	; 0232D654
	ldr r0,[pool_0232D698]	; 0232D656
	strb r1,[r0,#0x0]	; 0232D658
	mov r1,#0x81	; 0232D65A
	ldr r0,[pool_0232D6A0]	; 0232D65C
	strb r1,[r0,#0x0]	; 0232D65E
	b loc_0232D676	; 0232D660
loc_0232D662:
	mov r1,#0x89	; 0232D662
	ldr r0,[pool_0232D698]	; 0232D664
	strb r1,[r0,#0x0]	; 0232D666
loc_0232D668:
	mov r1,#0x81	; 0232D668
	ldr r0,[pool_0232D69C]	; 0232D66A
	strb r1,[r0,#0x0]	; 0232D66C
	b loc_0232D676	; 0232D66E
loc_0232D670:
	mov r1,#0x81	; 0232D670
	ldr r0,[pool_0232D698]	; 0232D672
	strb r1,[r0,#0x0]	; 0232D674
loc_0232D676:
	ldr r0,[pool_0232D684]	; 0232D676
	ldrh r0,[r0,#0x0]	; 0232D678
	bl loc_0232D6A4	; 0232D67A
	pop {r4}	; 0232D67E
	pop {r3}	; 0232D680
	bx r3	; 0232D682
pool_0232D684:
loc_0232D684:
	.word P1_BssStart + 0x266A8	; 0232D684
pool_0232D688:
loc_0232D688:
	.word VRAM_D_CR	; 0232D688
pool_0232D68C:
loc_0232D68C:
	.word VRAM_C_CR	; 0232D68C
pool_0232D690:
loc_0232D690:
	.word VRAM_B_CR	; 0232D690
pool_0232D694:
loc_0232D694:
	.word VRAM_A_CR	; 0232D694
pool_0232D698:
loc_0232D698:
	.word VRAM_G_CR	; 0232D698
pool_0232D69C:
loc_0232D69C:
	.word VRAM_F_CR	; 0232D69C
pool_0232D6A0:
loc_0232D6A0:
	.word VRAM_E_CR	; 0232D6A0

; ===== function loc_0232D6A4 =====
; Enables VRAM A--I banks selected by r0 bit mask. / 按 r0 位掩码启用 VRAM A--I bank。
.func P1_EnableVramBanksByMask
loc_0232D6A4:
	mov r1,#0x1	; 0232D6A4
	add r2,r0,#0x0	; 0232D6A6
	and r2,r1	; 0232D6A8
	cmp r2,#0x0	; 0232D6AA
	beq loc_0232D6B4	; 0232D6AC
	mov r2,#0x80	; 0232D6AE
	ldr r1,[pool_0232D734]	; 0232D6B0
	strb r2,[r1,#0x0]	; 0232D6B2
loc_0232D6B4:
	mov r1,#0x2	; 0232D6B4
	add r2,r0,#0x0	; 0232D6B6
	and r2,r1	; 0232D6B8
	cmp r2,#0x0	; 0232D6BA
	beq loc_0232D6C4	; 0232D6BC
	mov r2,#0x80	; 0232D6BE
	ldr r1,[pool_0232D738]	; 0232D6C0
	strb r2,[r1,#0x0]	; 0232D6C2
loc_0232D6C4:
	mov r1,#0x4	; 0232D6C4
	add r2,r0,#0x0	; 0232D6C6
	and r2,r1	; 0232D6C8
	cmp r2,#0x0	; 0232D6CA
	beq loc_0232D6D4	; 0232D6CC
	mov r2,#0x80	; 0232D6CE
	ldr r1,[pool_0232D73C]	; 0232D6D0
	strb r2,[r1,#0x0]	; 0232D6D2
loc_0232D6D4:
	mov r1,#0x8	; 0232D6D4
	add r2,r0,#0x0	; 0232D6D6
	and r2,r1	; 0232D6D8
	cmp r2,#0x0	; 0232D6DA
	beq loc_0232D6E4	; 0232D6DC
	mov r2,#0x80	; 0232D6DE
	ldr r1,[pool_0232D740]	; 0232D6E0
	strb r2,[r1,#0x0]	; 0232D6E2
loc_0232D6E4:
	mov r1,#0x10	; 0232D6E4
	add r2,r0,#0x0	; 0232D6E6
	and r2,r1	; 0232D6E8
	cmp r2,#0x0	; 0232D6EA
	beq loc_0232D6F4	; 0232D6EC
	mov r2,#0x80	; 0232D6EE
	ldr r1,[pool_0232D744]	; 0232D6F0
	strb r2,[r1,#0x0]	; 0232D6F2
loc_0232D6F4:
	mov r1,#0x20	; 0232D6F4
	add r2,r0,#0x0	; 0232D6F6
	and r2,r1	; 0232D6F8
	cmp r2,#0x0	; 0232D6FA
	beq loc_0232D704	; 0232D6FC
	mov r2,#0x80	; 0232D6FE
	ldr r1,[pool_0232D748]	; 0232D700
	strb r2,[r1,#0x0]	; 0232D702
loc_0232D704:
	mov r1,#0x40	; 0232D704
	add r2,r0,#0x0	; 0232D706
	and r2,r1	; 0232D708
	cmp r2,#0x0	; 0232D70A
	beq loc_0232D714	; 0232D70C
	mov r2,#0x80	; 0232D70E
	ldr r1,[pool_0232D74C]	; 0232D710
	strb r2,[r1,#0x0]	; 0232D712
loc_0232D714:
	mov r2,#0x80	; 0232D714
	add r1,r0,#0x0	; 0232D716
	and r1,r2	; 0232D718
	cmp r1,#0x0	; 0232D71A
	beq loc_0232D722	; 0232D71C
	ldr r1,[pool_0232D750]	; 0232D71E
	strb r2,[r1,#0x0]	; 0232D720
loc_0232D722:
	ldr r1,[pool_0232D754]	; 0232D722
	and r0,r1	; 0232D724
	cmp r0,#0x0	; 0232D726
	beq loc_0232D730	; 0232D728
	mov r1,#0x80	; 0232D72A
	ldr r0,[pool_0232D758]	; 0232D72C
	strb r1,[r0,#0x0]	; 0232D72E
loc_0232D730:
	bx lr	; 0232D730
.endfunc
	.byte 0xC0, 0x46	; 0232D734
pool_0232D734:
loc_0232D734:
	.word VRAM_A_CR	; 0232D734
pool_0232D738:
loc_0232D738:
	.word VRAM_B_CR	; 0232D738
pool_0232D73C:
loc_0232D73C:
	.word VRAM_C_CR	; 0232D73C
pool_0232D740:
loc_0232D740:
	.word VRAM_D_CR	; 0232D740
pool_0232D744:
loc_0232D744:
	.word VRAM_E_CR	; 0232D744
pool_0232D748:
loc_0232D748:
	.word VRAM_F_CR	; 0232D748
pool_0232D74C:
loc_0232D74C:
	.word VRAM_G_CR	; 0232D74C
pool_0232D750:
loc_0232D750:
	.word VRAM_H_CR	; 0232D750
pool_0232D754:
loc_0232D754:
	.word 0x00000100	; 0232D754
pool_0232D758:
loc_0232D758:
	.word VRAM_I_CR	; 0232D758

; ===== function loc_0232D75C =====
; Returns sub-engine BG3 character-base address, or zero for an unsupported configuration.
; 返回副引擎 BG3 字符基址；当前显示配置不支持时返回零。
.func P1_TryGetSubBg3CharacterBase
loc_0232D75C:
	ldr r0,[pool_0232D78C]	; 0232D75C
	ldr r1,[r0,#0x0]	; 0232D75E
	mov r0,#0x7	; 0232D760
	and r1,r0	; 0232D762
	ldr r0,[pool_0232D790]	; 0232D764
	ldrh r2,[r0,#0x0]	; 0232D766
	cmp r1,#0x3	; 0232D768
	blt loc_0232D77A	; 0232D76A
	cmp r1,#0x6	; 0232D76C
	bge loc_0232D788	; 0232D76E
	mov r0,#0x80	; 0232D770
	add r1,r2,#0x0	; 0232D772
	and r1,r0	; 0232D774
	cmp r1,#0x0	; 0232D776
	bne loc_0232D788	; 0232D778
loc_0232D77A:
	mov r0,#0x3c	; 0232D77A
	and r2,r0	; 0232D77C
	lsr r0,r2,#0x2	; 0232D77E
	lsl r1,r0,#0xe	; 0232D780
	ldr r0,[pool_0232D794]	; 0232D782
	add r0,r1,r0	; 0232D784
	bx lr	; 0232D786
loc_0232D788:
	mov r0,#0x0	; 0232D788
	bx lr	; 0232D78A
.endfunc
pool_0232D78C:
loc_0232D78C:
	.word REG_DISPCNT_B	; 0232D78C
pool_0232D790:
loc_0232D790:
	.word REG_BG3CNT_SUB	; 0232D790
pool_0232D794:
loc_0232D794:
	.word 0x06200000	; 0232D794

; ===== function loc_0232D798 =====
; Returns main-engine BG3 character-base address, or zero for an unsupported configuration.
; 返回主引擎 BG3 字符基址；当前显示配置不支持时返回零。
.func P1_TryGetMainBg3CharacterBase
loc_0232D798:
	ldr r0,[pool_0232D7D8]	; 0232D798
	ldr r1,[r0,#0x0]	; 0232D79A
	mov r0,#0x7	; 0232D79C
	and r1,r0	; 0232D79E
	ldr r0,[pool_0232D7DC]	; 0232D7A0
	ldrh r0,[r0,#0x0]	; 0232D7A2
	cmp r1,#0x3	; 0232D7A4
	blt loc_0232D7B6	; 0232D7A6
	cmp r1,#0x6	; 0232D7A8
	bge loc_0232D7D2	; 0232D7AA
	mov r1,#0x80	; 0232D7AC
	add r2,r0,#0x0	; 0232D7AE
	and r2,r1	; 0232D7B0
	cmp r2,#0x0	; 0232D7B2
	bne loc_0232D7D2	; 0232D7B4
loc_0232D7B6:
	ldr r1,[pool_0232D7D8]	; 0232D7B6
	ldr r2,[r1,#0x0]	; 0232D7B8
	ldr r1,[pool_0232D7E0]	; 0232D7BA
	and r2,r1	; 0232D7BC
	lsr r1,r2,#0x18	; 0232D7BE
	lsl r2,r1,#0x10	; 0232D7C0
	ldr r1,[pool_0232D7E4]	; 0232D7C2
	add r2,r2,r1	; 0232D7C4
	mov r1,#0x3c	; 0232D7C6
	and r0,r1	; 0232D7C8
	lsr r0,r0,#0x2	; 0232D7CA
	lsl r0,r0,#0xe	; 0232D7CC
	add r0,r2,r0	; 0232D7CE
	bx lr	; 0232D7D0
loc_0232D7D2:
	mov r0,#0x0	; 0232D7D2
	bx lr	; 0232D7D4
.endfunc
	.byte 0xC0, 0x46	; 0232D7D8
pool_0232D7D8:
loc_0232D7D8:
	.word REG_DISPCNT_A	; 0232D7D8
pool_0232D7DC:
loc_0232D7DC:
	.word REG_BG3CNT	; 0232D7DC
pool_0232D7E0:
loc_0232D7E0:
	.word 0x07000000	; 0232D7E0
pool_0232D7E4:
loc_0232D7E4:
	.word 0x06000000	; 0232D7E4

; ===== function loc_0232D7E8 =====
; Returns sub-engine BG2 character-base address, or zero for an unsupported configuration.
; 返回副引擎 BG2 字符基址；当前显示配置不支持时返回零。
.func P1_TryGetSubBg2CharacterBase
loc_0232D7E8:
	ldr r0,[pool_0232D814]	; 0232D7E8
	ldr r1,[r0,#0x0]	; 0232D7EA
	mov r0,#0x7	; 0232D7EC
	and r1,r0	; 0232D7EE
	ldr r0,[pool_0232D818]	; 0232D7F0
	ldrh r2,[r0,#0x0]	; 0232D7F2
	cmp r1,#0x5	; 0232D7F4
	blt loc_0232D802	; 0232D7F6
	mov r0,#0x80	; 0232D7F8
	add r1,r2,#0x0	; 0232D7FA
	and r1,r0	; 0232D7FC
	cmp r1,#0x0	; 0232D7FE
	bne loc_0232D810	; 0232D800
loc_0232D802:
	mov r0,#0x3c	; 0232D802
	and r2,r0	; 0232D804
	lsr r0,r2,#0x2	; 0232D806
	lsl r1,r0,#0xe	; 0232D808
	ldr r0,[pool_0232D81C]	; 0232D80A
	add r0,r1,r0	; 0232D80C
	bx lr	; 0232D80E
loc_0232D810:
	mov r0,#0x0	; 0232D810
	bx lr	; 0232D812
.endfunc
pool_0232D814:
loc_0232D814:
	.word REG_DISPCNT_B	; 0232D814
pool_0232D818:
loc_0232D818:
	.word REG_BG2CNT_SUB	; 0232D818
pool_0232D81C:
loc_0232D81C:
	.word 0x06200000	; 0232D81C

; ===== function loc_0232D820 =====
; Returns main-engine BG2 character-base address, or zero for an unsupported configuration.
; 返回主引擎 BG2 字符基址；当前显示配置不支持时返回零。
.func P1_TryGetMainBg2CharacterBase
loc_0232D820:
	ldr r0,[pool_0232D85C]	; 0232D820
	ldr r1,[r0,#0x0]	; 0232D822
	mov r0,#0x7	; 0232D824
	and r1,r0	; 0232D826
	ldr r0,[pool_0232D860]	; 0232D828
	ldrh r0,[r0,#0x0]	; 0232D82A
	cmp r1,#0x5	; 0232D82C
	blt loc_0232D83A	; 0232D82E
	mov r1,#0x80	; 0232D830
	add r2,r0,#0x0	; 0232D832
	and r2,r1	; 0232D834
	cmp r2,#0x0	; 0232D836
	bne loc_0232D856	; 0232D838
loc_0232D83A:
	ldr r1,[pool_0232D85C]	; 0232D83A
	ldr r2,[r1,#0x0]	; 0232D83C
	ldr r1,[pool_0232D864]	; 0232D83E
	and r2,r1	; 0232D840
	lsr r1,r2,#0x18	; 0232D842
	lsl r2,r1,#0x10	; 0232D844
	ldr r1,[pool_0232D868]	; 0232D846
	add r2,r2,r1	; 0232D848
	mov r1,#0x3c	; 0232D84A
	and r0,r1	; 0232D84C
	lsr r0,r0,#0x2	; 0232D84E
	lsl r0,r0,#0xe	; 0232D850
	add r0,r2,r0	; 0232D852
	bx lr	; 0232D854
loc_0232D856:
	mov r0,#0x0	; 0232D856
	bx lr	; 0232D858
.endfunc
	.byte 0xC0, 0x46	; 0232D85C
pool_0232D85C:
loc_0232D85C:
	.word REG_DISPCNT_A	; 0232D85C
pool_0232D860:
loc_0232D860:
	.word REG_BG2CNT	; 0232D860
pool_0232D864:
loc_0232D864:
	.word 0x07000000	; 0232D864
pool_0232D868:
loc_0232D868:
	.word 0x06000000	; 0232D868

; ===== function loc_0232D86C =====
; Returns the sub-engine BG1 character-base address.
; 返回副引擎 BG1 字符基址。
.func P1_GetSubBg1CharacterBase
loc_0232D86C:
	ldr r0,[pool_0232D880]	; 0232D86C
	ldrh r1,[r0,#0x0]	; 0232D86E
	mov r0,#0x3c	; 0232D870
	and r1,r0	; 0232D872
	asr r0,r1,#0x2	; 0232D874
	lsl r1,r0,#0xe	; 0232D876
	ldr r0,[pool_0232D884]	; 0232D878
	add r0,r1,r0	; 0232D87A
	bx lr	; 0232D87C
.endfunc
	.byte 0xC0, 0x46	; 0232D880
pool_0232D880:
loc_0232D880:
	.word REG_BG1CNT_SUB	; 0232D880
pool_0232D884:
loc_0232D884:
	.word 0x06200000	; 0232D884

; ===== function loc_0232D888 =====
; Returns the main-engine BG1 character-base address.
; 返回主引擎 BG1 字符基址。
.func P1_GetMainBg1CharacterBase
loc_0232D888:
	ldr r0,[pool_0232D8A8]	; 0232D888
	ldrh r1,[r0,#0x0]	; 0232D88A
	mov r0,#0x3c	; 0232D88C
	and r1,r0	; 0232D88E
	asr r0,r1,#0x2	; 0232D890
	lsl r2,r0,#0xe	; 0232D892
	ldr r0,[pool_0232D8AC]	; 0232D894
	ldr r1,[r0,#0x0]	; 0232D896
	ldr r0,[pool_0232D8B0]	; 0232D898
	and r1,r0	; 0232D89A
	lsr r0,r1,#0x18	; 0232D89C
	lsl r1,r0,#0x10	; 0232D89E
	ldr r0,[pool_0232D8B4]	; 0232D8A0
	add r0,r1,r0	; 0232D8A2
	add r0,r2,r0	; 0232D8A4
	bx lr	; 0232D8A6
.endfunc
pool_0232D8A8:
loc_0232D8A8:
	.word REG_BG1CNT	; 0232D8A8
pool_0232D8AC:
loc_0232D8AC:
	.word REG_DISPCNT_A	; 0232D8AC
pool_0232D8B0:
loc_0232D8B0:
	.word 0x07000000	; 0232D8B0
pool_0232D8B4:
loc_0232D8B4:
	.word 0x06000000	; 0232D8B4

; ===== function loc_0232D8B8 =====
; Returns the sub-engine BG0 character-base address.
; 返回副引擎 BG0 字符基址。
.func P1_GetSubBg0CharacterBase
loc_0232D8B8:
	ldr r0,[pool_0232D8CC]	; 0232D8B8
	ldrh r1,[r0,#0x0]	; 0232D8BA
	mov r0,#0x3c	; 0232D8BC
	and r1,r0	; 0232D8BE
	asr r0,r1,#0x2	; 0232D8C0
	lsl r1,r0,#0xe	; 0232D8C2
	ldr r0,[pool_0232D8D0]	; 0232D8C4
	add r0,r1,r0	; 0232D8C6
	bx lr	; 0232D8C8
.endfunc
	.byte 0xC0, 0x46	; 0232D8CC
pool_0232D8CC:
loc_0232D8CC:
	.word REG_BG0CNT_SUB	; 0232D8CC
pool_0232D8D0:
loc_0232D8D0:
	.word 0x06200000	; 0232D8D0
; ===== function loc_0232D8E4 =====
; Returns the main-engine BG0 character-base address.
; 返回主引擎 BG0 字符基址。
.func P1_GetMainBg0CharacterBase
loc_0232D8E4:
	ldr r0,[pool_0232D904]	; 0232D8E4
	ldrh r1,[r0,#0x0]	; 0232D8E6
	mov r0,#0x3c	; 0232D8E8
	and r1,r0	; 0232D8EA
	asr r0,r1,#0x2	; 0232D8EC
	lsl r2,r0,#0xe	; 0232D8EE
	ldr r0,[pool_0232D908]	; 0232D8F0
	ldr r1,[r0,#0x0]	; 0232D8F2
	ldr r0,[pool_0232D90C]	; 0232D8F4
	and r1,r0	; 0232D8F6
	lsr r0,r1,#0x18	; 0232D8F8
	lsl r1,r0,#0x10	; 0232D8FA
	ldr r0,[pool_0232D910]	; 0232D8FC
	add r0,r1,r0	; 0232D8FE
	add r0,r2,r0	; 0232D900
	bx lr	; 0232D902
.endfunc
pool_0232D904:
	.word REG_BG0CNT	; 0232D904
pool_0232D908:
	.word REG_DISPCNT_A	; 0232D908
pool_0232D90C:
	.word 0x07000000	; 0232D90C
pool_0232D910:
	.word 0x06000000	; 0232D910

; ===== function loc_0232D904 =====
; Resolves the sub-engine BG3 tilemap base for the active BG mode.
; 按当前 BG 模式解析副引擎 BG3 tilemap 基址。
.func P1_ResolveSubBg3TilemapAddress
loc_0232D904:
	ldr r0,[pool_0232D960]	; 0232D904
	ldr r3,[r0,#0x0]	; 0232D906
	mov r0,#0x7	; 0232D908
	and r3,r0	; 0232D90A
	ldr r0,[pool_0232D964]	; 0232D90C
	ldrh r0,[r0,#0x0]	; 0232D90E
	ldr r1,[pool_0232D968]	; 0232D910
	add r2,r0,#0x0	; 0232D912
	and r2,r1	; 0232D914
	lsr r2,r2,#0x8	; 0232D916
	cmp r3,#0x6	; 0232D918
	bhi loc_0232D95C	; 0232D91A
	add r1,r3,r3	; 0232D91C
P1_SwitchIndexPC_0232D91C:
	add r1,pc	; 0232D91E
	ldrh r1,[r1,#(P1_SwitchTable_0232D91C - (P1_SwitchIndexPC_0232D91C + 4))]	; 0232D920
	lsl r1,r1,#0x10	; 0232D922
	asr r1,r1,#0x10	; 0232D924
P1_SwitchTargetPC_0232D91C:
	add r1,pc	; 0232D926
	bx r1	; 0232D928
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232D91C:
	.halfword (loc_0232D938 + 1) - (P1_SwitchTargetPC_0232D91C + 4)
	.halfword (loc_0232D938 + 1) - (P1_SwitchTargetPC_0232D91C + 4)
	.halfword (loc_0232D938 + 1) - (P1_SwitchTargetPC_0232D91C + 4)
	.halfword (loc_0232D940 + 1) - (P1_SwitchTargetPC_0232D91C + 4)
	.halfword (loc_0232D940 + 1) - (P1_SwitchTargetPC_0232D91C + 4)
	.halfword (loc_0232D940 + 1) - (P1_SwitchTargetPC_0232D91C + 4)
	.halfword (loc_0232D958 + 1) - (P1_SwitchTargetPC_0232D91C + 4)
P1_SwitchTable_0232D91CEnd:
loc_0232D938:
	lsl r1,r2,#0xb	; 0232D938
	ldr r0,[pool_0232D96C]	; 0232D93A
	add r0,r1,r0	; 0232D93C
	bx lr	; 0232D93E
loc_0232D940:
	mov r1,#0x80	; 0232D940
	and r0,r1	; 0232D942
	cmp r0,#0x0	; 0232D944
	beq loc_0232D950	; 0232D946
	lsl r1,r2,#0xe	; 0232D948
	ldr r0,[pool_0232D96C]	; 0232D94A
	add r0,r1,r0	; 0232D94C
	bx lr	; 0232D94E
loc_0232D950:
	lsl r1,r2,#0xb	; 0232D950
	ldr r0,[pool_0232D96C]	; 0232D952
	add r0,r1,r0	; 0232D954
	bx lr	; 0232D956
loc_0232D958:
	mov r0,#0x0	; 0232D958
	bx lr	; 0232D95A
loc_0232D95C:
	mov r0,#0x0	; 0232D95C
	bx lr	; 0232D95E
.endfunc
pool_0232D960:
loc_0232D960:
	.word REG_DISPCNT_B	; 0232D960
pool_0232D964:
loc_0232D964:
	.word REG_BG3CNT_SUB	; 0232D964
pool_0232D968:
loc_0232D968:
	.word 0x00001F00	; 0232D968
pool_0232D96C:
loc_0232D96C:
	.word 0x06200000	; 0232D96C
.arm

; ===== function loc_0232D970 =====
; Resolves the main-engine BG3 tilemap base for the active BG and VRAM mode.
; 按当前 BG 与 VRAM 模式解析主引擎 BG3 tilemap 基址。
.func P1_ResolveMainBg3TilemapAddress
loc_0232D970:
	ldr r0,[pool_0232D9F8]	; 0232D970
	mov r2,#0x4000000	; 0232D974
	ldr r1,[r2,#0x0]	; 0232D978
	ldrh r3,[r0,#0x0]	; 0232D97C
	ldr r0,[r2,#0x0]	; 0232D980
	and r12,r1,#0x7	; 0232D984
	and r0,r0,#0x38000000	; 0232D988
	mov r1,r0, lsr #0x1b	; 0232D98C
	and r0,r3,#0x1f00	; 0232D990
	mov r2,r1, lsl #0x10	; 0232D994
	cmp r12,#((P1_ArmBranchTable_0232D9A0End - P1_ArmBranchTable_0232D9A0) / 4 - 1)	; 0232D998
	mov r1,r0, lsr #0x8	; 0232D99C
; ARM 的 PC 为当前地址 +8；索引选择一条 4 字节 B 指令。
; ARM reads PC+8; the index selects one 4-byte B instruction.
P1_ArmBranchTable_0232D9A0PC:
	addls pc,pc,r12, lsl #0x2	; 0232D9A0
	b loc_0232D9F0	; 0232D9A4
loc_0232D9A8:
P1_ArmBranchTable_0232D9A0:
	b loc_0232D9C4	; 0232D9A8
loc_0232D9AC:
	b loc_0232D9C4	; 0232D9AC
loc_0232D9B0:
	b loc_0232D9C4	; 0232D9B0
loc_0232D9B4:
	b loc_0232D9D0	; 0232D9B4
loc_0232D9B8:
	b loc_0232D9D0	; 0232D9B8
loc_0232D9BC:
	b loc_0232D9D0	; 0232D9BC
loc_0232D9C0:
	b loc_0232D9E8	; 0232D9C0
loc_0232D9C4:
P1_ArmBranchTable_0232D9A0End:
.if (P1_ArmBranchTable_0232D9A0 != P1_ArmBranchTable_0232D9A0PC + 8) || ((P1_ArmBranchTable_0232D9A0End - P1_ArmBranchTable_0232D9A0) % 4 != 0)
    .error "ARM branch-table layout changed"
.endif
	add r0,r2,#0x6000000	; 0232D9C4
	add r0,r0,r1, lsl #0xb	; 0232D9C8
	bx lr	; 0232D9CC
loc_0232D9D0:
	ands r0,r3,#0x80	; 0232D9D0
	movne r0,r1, lsl #0xe	; 0232D9D4
	addne r0,r0,#0x6000000	; 0232D9D8
	addeq r0,r2,#0x6000000	; 0232D9DC
	addeq r0,r0,r1, lsl #0xb	; 0232D9E0
	bx lr	; 0232D9E4
loc_0232D9E8:
	mov r0,#0x0	; 0232D9E8
	bx lr	; 0232D9EC
loc_0232D9F0:
	mov r0,#0x0	; 0232D9F0
	bx lr	; 0232D9F4
.endfunc
pool_0232D9F8:
loc_0232D9F8:
	.word REG_BG3CNT	; 0232D9F8
.thumb

; ===== function loc_0232D9FC =====
; Resolves the sub-engine BG2 tilemap base for the active BG mode.
; 按当前 BG 模式解析副引擎 BG2 tilemap 基址。
.func P1_ResolveSubBg2TilemapAddress
loc_0232D9FC:
	ldr r0,[pool_0232DA58]	; 0232D9FC
	ldr r3,[r0,#0x0]	; 0232D9FE
	mov r0,#0x7	; 0232DA00
	and r3,r0	; 0232DA02
	ldr r0,[pool_0232DA5C]	; 0232DA04
	ldrh r0,[r0,#0x0]	; 0232DA06
	ldr r1,[pool_0232DA60]	; 0232DA08
	add r2,r0,#0x0	; 0232DA0A
	and r2,r1	; 0232DA0C
	lsr r2,r2,#0x8	; 0232DA0E
	cmp r3,#0x6	; 0232DA10
	bhi loc_0232DA54	; 0232DA12
	add r1,r3,r3	; 0232DA14
P1_SwitchIndexPC_0232DA14:
	add r1,pc	; 0232DA16
	ldrh r1,[r1,#(P1_SwitchTable_0232DA14 - (P1_SwitchIndexPC_0232DA14 + 4))]	; 0232DA18
	lsl r1,r1,#0x10	; 0232DA1A
	asr r1,r1,#0x10	; 0232DA1C
P1_SwitchTargetPC_0232DA14:
	add r1,pc	; 0232DA1E
	bx r1	; 0232DA20
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232DA14:
	.halfword (loc_0232DA30 + 1) - (P1_SwitchTargetPC_0232DA14 + 4)
	.halfword (loc_0232DA30 + 1) - (P1_SwitchTargetPC_0232DA14 + 4)
	.halfword (loc_0232DA30 + 1) - (P1_SwitchTargetPC_0232DA14 + 4)
	.halfword (loc_0232DA30 + 1) - (P1_SwitchTargetPC_0232DA14 + 4)
	.halfword (loc_0232DA30 + 1) - (P1_SwitchTargetPC_0232DA14 + 4)
	.halfword (loc_0232DA38 + 1) - (P1_SwitchTargetPC_0232DA14 + 4)
	.halfword (loc_0232DA50 + 1) - (P1_SwitchTargetPC_0232DA14 + 4)
P1_SwitchTable_0232DA14End:
loc_0232DA30:
	lsl r1,r2,#0xb	; 0232DA30
	ldr r0,[pool_0232DA64]	; 0232DA32
	add r0,r1,r0	; 0232DA34
	bx lr	; 0232DA36
loc_0232DA38:
	mov r1,#0x80	; 0232DA38
	and r0,r1	; 0232DA3A
	cmp r0,#0x0	; 0232DA3C
	beq loc_0232DA48	; 0232DA3E
	lsl r1,r2,#0xe	; 0232DA40
	ldr r0,[pool_0232DA64]	; 0232DA42
	add r0,r1,r0	; 0232DA44
	bx lr	; 0232DA46
loc_0232DA48:
	lsl r1,r2,#0xb	; 0232DA48
	ldr r0,[pool_0232DA64]	; 0232DA4A
	add r0,r1,r0	; 0232DA4C
	bx lr	; 0232DA4E
loc_0232DA50:
	mov r0,#0x0	; 0232DA50
	bx lr	; 0232DA52
loc_0232DA54:
	mov r0,#0x0	; 0232DA54
	bx lr	; 0232DA56
.endfunc
pool_0232DA58:
loc_0232DA58:
	.word REG_DISPCNT_B	; 0232DA58
pool_0232DA5C:
loc_0232DA5C:
	.word REG_BG2CNT_SUB	; 0232DA5C
pool_0232DA60:
loc_0232DA60:
	.word 0x00001F00	; 0232DA60
pool_0232DA64:
loc_0232DA64:
	.word 0x06200000	; 0232DA64
.arm

; ===== function loc_0232DA68 =====
; Resolves the main-engine BG2 tilemap base for the active BG and VRAM mode.
; 按当前 BG 与 VRAM 模式解析主引擎 BG2 tilemap 基址。
.func P1_ResolveMainBg2TilemapAddress
loc_0232DA68:
	ldr r0,[pool_0232DAF0]	; 0232DA68
	mov r2,#0x4000000	; 0232DA6C
	ldr r1,[r2,#0x0]	; 0232DA70
	ldrh r3,[r0,#0x0]	; 0232DA74
	ldr r0,[r2,#0x0]	; 0232DA78
	and r12,r1,#0x7	; 0232DA7C
	and r0,r0,#0x38000000	; 0232DA80
	mov r1,r0, lsr #0x1b	; 0232DA84
	and r0,r3,#0x1f00	; 0232DA88
	mov r2,r1, lsl #0x10	; 0232DA8C
	cmp r12,#((P1_ArmBranchTable_0232DA98End - P1_ArmBranchTable_0232DA98) / 4 - 1)	; 0232DA90
	mov r1,r0, lsr #0x8	; 0232DA94
; ARM 的 PC 为当前地址 +8；索引选择一条 4 字节 B 指令。
; ARM reads PC+8; the index selects one 4-byte B instruction.
P1_ArmBranchTable_0232DA98PC:
	addls pc,pc,r12, lsl #0x2	; 0232DA98
	b loc_0232DAE8	; 0232DA9C
loc_0232DAA0:
P1_ArmBranchTable_0232DA98:
	b loc_0232DABC	; 0232DAA0
loc_0232DAA4:
	b loc_0232DABC	; 0232DAA4
loc_0232DAA8:
	b loc_0232DABC	; 0232DAA8
loc_0232DAAC:
	b loc_0232DABC	; 0232DAAC
loc_0232DAB0:
	b loc_0232DABC	; 0232DAB0
loc_0232DAB4:
	b loc_0232DAC8	; 0232DAB4
loc_0232DAB8:
	b loc_0232DAE0	; 0232DAB8
loc_0232DABC:
P1_ArmBranchTable_0232DA98End:
.if (P1_ArmBranchTable_0232DA98 != P1_ArmBranchTable_0232DA98PC + 8) || ((P1_ArmBranchTable_0232DA98End - P1_ArmBranchTable_0232DA98) % 4 != 0)
    .error "ARM branch-table layout changed"
.endif
	add r0,r2,#0x6000000	; 0232DABC
	add r0,r0,r1, lsl #0xb	; 0232DAC0
	bx lr	; 0232DAC4
loc_0232DAC8:
	ands r0,r3,#0x80	; 0232DAC8
	movne r0,r1, lsl #0xe	; 0232DACC
	addne r0,r0,#0x6000000	; 0232DAD0
	addeq r0,r2,#0x6000000	; 0232DAD4
	addeq r0,r0,r1, lsl #0xb	; 0232DAD8
	bx lr	; 0232DADC
loc_0232DAE0:
	mov r0,#0x6000000	; 0232DAE0
	bx lr	; 0232DAE4
loc_0232DAE8:
	mov r0,#0x0	; 0232DAE8
	bx lr	; 0232DAEC
.endfunc
pool_0232DAF0:
loc_0232DAF0:
	.word REG_BG2CNT	; 0232DAF0
.thumb

; ===== function loc_0232DAF4 =====
; Returns the sub-engine BG1 tilemap base from BG1CNT.
; 由 BG1CNT 返回副引擎 BG1 tilemap 基址。
.func P1_GetSubBg1TilemapBase
loc_0232DAF4:
	ldr r0,[pool_0232DB08]	; 0232DAF4
	ldrh r1,[r0,#0x0]	; 0232DAF6
	ldr r0,[pool_0232DB0C]	; 0232DAF8
	and r1,r0	; 0232DAFA
	asr r0,r1,#0x8	; 0232DAFC
	lsl r1,r0,#0xb	; 0232DAFE
	ldr r0,[pool_0232DB10]	; 0232DB00
	add r0,r1,r0	; 0232DB02
	bx lr	; 0232DB04
.endfunc
	.byte 0xC0, 0x46	; 0232DB08
pool_0232DB08:
loc_0232DB08:
	.word REG_BG1CNT_SUB	; 0232DB08
pool_0232DB0C:
loc_0232DB0C:
	.word 0x00001F00	; 0232DB0C
pool_0232DB10:
loc_0232DB10:
	.word 0x06200000	; 0232DB10

; ===== function loc_0232DB14 =====
; Returns the main-engine BG1 tilemap base from BG1CNT and VRAM bank mode.
; 由 BG1CNT 与 VRAM bank 模式返回主引擎 BG1 tilemap 基址。
.func P1_GetMainBg1TilemapBase
loc_0232DB14:
	ldr r0,[pool_0232DB34]	; 0232DB14
	ldrh r1,[r0,#0x0]	; 0232DB16
	ldr r0,[pool_0232DB38]	; 0232DB18
	and r1,r0	; 0232DB1A
	asr r0,r1,#0x8	; 0232DB1C
	lsl r2,r0,#0xb	; 0232DB1E
	ldr r0,[pool_0232DB3C]	; 0232DB20
	ldr r1,[r0,#0x0]	; 0232DB22
	ldr r0,[pool_0232DB40]	; 0232DB24
	and r1,r0	; 0232DB26
	lsr r0,r1,#0x1b	; 0232DB28
	lsl r1,r0,#0x10	; 0232DB2A
	ldr r0,[pool_0232DB44]	; 0232DB2C
	add r0,r1,r0	; 0232DB2E
	add r0,r2,r0	; 0232DB30
	bx lr	; 0232DB32
.endfunc
pool_0232DB34:
loc_0232DB34:
	.word REG_BG1CNT	; 0232DB34
pool_0232DB38:
loc_0232DB38:
	.word 0x00001F00	; 0232DB38
pool_0232DB3C:
loc_0232DB3C:
	.word REG_DISPCNT_A	; 0232DB3C
pool_0232DB40:
loc_0232DB40:
	.word 0x38000000	; 0232DB40
pool_0232DB44:
loc_0232DB44:
	.word 0x06000000	; 0232DB44

; ===== function loc_0232DB48 =====
; Returns the sub-engine BG0 tilemap base from BG0CNT.
; 由 BG0CNT 返回副引擎 BG0 tilemap 基址。
.func P1_GetSubBg0TilemapBase
loc_0232DB48:
	ldr r0,[pool_0232DB5C]	; 0232DB48
	ldrh r1,[r0,#0x0]	; 0232DB4A
	ldr r0,[pool_0232DB60]	; 0232DB4C
	and r1,r0	; 0232DB4E
	asr r0,r1,#0x8	; 0232DB50
	lsl r1,r0,#0xb	; 0232DB52
	ldr r0,[pool_0232DB64]	; 0232DB54
	add r0,r1,r0	; 0232DB56
	bx lr	; 0232DB58
.endfunc
	.byte 0xC0, 0x46	; 0232DB5C
pool_0232DB5C:
loc_0232DB5C:
	.word REG_BG0CNT_SUB	; 0232DB5C
pool_0232DB60:
loc_0232DB60:
	.word 0x00001F00	; 0232DB60
pool_0232DB64:
loc_0232DB64:
	.word 0x06200000	; 0232DB64

; ===== function loc_0232DB68 =====
; Returns the main-engine BG0 tilemap base from BG0CNT and VRAM bank mode.
; 由 BG0CNT 与 VRAM bank 模式返回主引擎 BG0 tilemap 基址。
.func P1_GetMainBg0TilemapBase
loc_0232DB68:
	ldr r0,[pool_0232DB88]	; 0232DB68
	ldrh r1,[r0,#0x0]	; 0232DB6A
	ldr r0,[pool_0232DB8C]	; 0232DB6C
	and r1,r0	; 0232DB6E
	asr r0,r1,#0x8	; 0232DB70
	lsl r2,r0,#0xb	; 0232DB72
	ldr r0,[pool_0232DB90]	; 0232DB74
	ldr r1,[r0,#0x0]	; 0232DB76
	ldr r0,[pool_0232DB94]	; 0232DB78
	and r1,r0	; 0232DB7A
	lsr r0,r1,#0x1b	; 0232DB7C
	lsl r1,r0,#0x10	; 0232DB7E
	ldr r0,[pool_0232DB98]	; 0232DB80
	add r0,r1,r0	; 0232DB82
	add r0,r2,r0	; 0232DB84
	bx lr	; 0232DB86
.endfunc
pool_0232DB88:
loc_0232DB88:
	.word REG_BG0CNT	; 0232DB88
pool_0232DB8C:
loc_0232DB8C:
	.word 0x00001F00	; 0232DB8C
pool_0232DB90:
loc_0232DB90:
	.word REG_DISPCNT_A	; 0232DB90
pool_0232DB94:
loc_0232DB94:
	.word 0x38000000	; 0232DB94
pool_0232DB98:
loc_0232DB98:
	.word 0x06000000	; 0232DB98

; ===== function loc_0232DB9C =====
loc_0232DB9C:
	cmp r2,#0x0	; 0232DB9C
	bge loc_0232DBAC	; 0232DB9E
	mov r3,#0xc0	; 0232DBA0
	orr r1,r3	; 0232DBA2
	strh r1,[r0,#0x0]	; 0232DBA4
	neg r1,r2	; 0232DBA6
	strh r1,[r0,#0x4]	; 0232DBA8
	bx lr	; 0232DBAA
loc_0232DBAC:
	mov r3,#0x80	; 0232DBAC
	orr r1,r3	; 0232DBAE
	strh r1,[r0,#0x0]	; 0232DBB0
	strh r2,[r0,#0x4]	; 0232DBB2
	bx lr	; 0232DBB4
	.byte 0x00, 0x00	; 0232DBB8

; ===== function loc_0232DBB8 =====
loc_0232DBB8:
	push {r4}	; 0232DBB8
	sub sp,#0x4	; 0232DBBA
	mov r4,#0x40	; 0232DBBC
	orr r1,r4	; 0232DBBE
	lsl r2,r2,#0x8	; 0232DBC0
	orr r1,r2	; 0232DBC2
	ldr r2,[sp,#0x8]	; 0232DBC4
	lsl r2,r2,#0x8	; 0232DBC6
	orr r3,r2	; 0232DBC8
	lsl r2,r3,#0x10	; 0232DBCA
	orr r1,r2	; 0232DBCC
	str r1,[r0,#0x0]	; 0232DBCE
	add sp,#0x4	; 0232DBD0
	pop {r4}	; 0232DBD2
	bx lr	; 0232DBD4
	.byte 0x00, 0x00	; 0232DBD8

; ===== function loc_0232DBD8 =====
P1_Entry_0232DBD8:
	push {r4,r5,r6,lr}	; 0232DBD8
	add r5,r0,#0x0	; 0232DBDA
	add r4,r1,#0x0	; 0232DBDC
	add r6,r2,#0x0	; 0232DBDE
	bl P1_TryGetSubBg3CharacterBase	; 0232DBE0
	add r2,r0,#0x0	; 0232DBE4
	ldr r0,[pool_0232DC14]	; 0232DBE6
	ldr r0,[r0,#0x0]	; 0232DBE8
	mov r1,#0x0	; 0232DBEA
	mvn r1,r1	; 0232DBEC
	cmp r0,r1	; 0232DBEE
	beq loc_0232DC02	; 0232DBF0
	add r1,r5,#0x0	; 0232DBF2
	add r2,r2,r4	; 0232DBF4
	add r3,r6,#0x0	; 0232DBF6
	bl loc_0232E24C	; 0232DBF8
	pop {r4,r5,r6}	; 0232DBFC
	pop {r3}	; 0232DBFE
	bx r3	; 0232DC00
loc_0232DC02:
	add r0,r5,#0x0	; 0232DC02
	add r1,r2,r4	; 0232DC04
	add r2,r6,#0x0	; 0232DC06
	blx loc_0232E32C	; 0232DC08
	pop {r4,r5,r6}	; 0232DC0C
	pop {r3}	; 0232DC0E
	bx r3	; 0232DC10
	.byte 0xC0, 0x46	; 0232DC14
pool_0232DC14:
loc_0232DC14:
	.word P1_Data_02330E4C	; 0232DC14

; ===== function loc_0232DC18 =====
P1_Entry_0232DC18:
	push {r4,r5,r6,lr}	; 0232DC18
	add r5,r0,#0x0	; 0232DC1A
	add r4,r1,#0x0	; 0232DC1C
	add r6,r2,#0x0	; 0232DC1E
	bl P1_TryGetMainBg3CharacterBase	; 0232DC20
	add r2,r0,#0x0	; 0232DC24
	ldr r0,[pool_0232DC54]	; 0232DC26
	ldr r0,[r0,#0x0]	; 0232DC28
	mov r1,#0x0	; 0232DC2A
	mvn r1,r1	; 0232DC2C
	cmp r0,r1	; 0232DC2E
	beq loc_0232DC42	; 0232DC30
	add r1,r5,#0x0	; 0232DC32
	add r2,r2,r4	; 0232DC34
	add r3,r6,#0x0	; 0232DC36
	bl loc_0232E24C	; 0232DC38
	pop {r4,r5,r6}	; 0232DC3C
	pop {r3}	; 0232DC3E
	bx r3	; 0232DC40
loc_0232DC42:
	add r0,r5,#0x0	; 0232DC42
	add r1,r2,r4	; 0232DC44
	add r2,r6,#0x0	; 0232DC46
	blx loc_0232E32C	; 0232DC48
	pop {r4,r5,r6}	; 0232DC4C
	pop {r3}	; 0232DC4E
	bx r3	; 0232DC50
	.byte 0xC0, 0x46	; 0232DC54
pool_0232DC54:
loc_0232DC54:
	.word P1_Data_02330E4C	; 0232DC54
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xFF, 0xF7, 0xC2, 0xFD, 0x02, 0x1C, 0x0B, 0x48	; 0232DC68
	.byte 0x00, 0x68, 0x00, 0x21, 0xC9, 0x43, 0x88, 0x42, 0x07, 0xD0, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C	; 0232DC78
	.byte 0x00, 0xF0, 0xE8, 0xFA, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x28, 0x1C, 0x11, 0x19, 0x32, 0x1C	; 0232DC88
	.byte 0x00, 0xF0, 0x50, 0xEB, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0x4C, 0x0E, 0x33, 0x02	; 0232DC98

; ===== function loc_0232DC98 =====
loc_0232DC98:
	push {r4,r5,r6,lr}	; 0232DC98
	add r5,r0,#0x0	; 0232DC9A
	add r4,r1,#0x0	; 0232DC9C
	add r6,r2,#0x0	; 0232DC9E
	bl P1_TryGetMainBg2CharacterBase	; 0232DCA0
	add r2,r0,#0x0	; 0232DCA4
	ldr r0,[pool_0232DCD4]	; 0232DCA6
	ldr r0,[r0,#0x0]	; 0232DCA8
	mov r1,#0x0	; 0232DCAA
	mvn r1,r1	; 0232DCAC
	cmp r0,r1	; 0232DCAE
	beq loc_0232DCC2	; 0232DCB0
	add r1,r5,#0x0	; 0232DCB2
	add r2,r2,r4	; 0232DCB4
	add r3,r6,#0x0	; 0232DCB6
	bl loc_0232E24C	; 0232DCB8
	pop {r4,r5,r6}	; 0232DCBC
	pop {r3}	; 0232DCBE
	bx r3	; 0232DCC0
loc_0232DCC2:
	add r0,r5,#0x0	; 0232DCC2
	add r1,r2,r4	; 0232DCC4
	add r2,r6,#0x0	; 0232DCC6
	blx loc_0232E32C	; 0232DCC8
	pop {r4,r5,r6}	; 0232DCCC
	pop {r3}	; 0232DCCE
	bx r3	; 0232DCD0
	.byte 0xC0, 0x46	; 0232DCD4
pool_0232DCD4:
loc_0232DCD4:
	.word P1_Data_02330E4C	; 0232DCD4

; ===== function loc_0232DCD8 =====
loc_0232DCD8:
	push {r4,r5,r6,lr}	; 0232DCD8
	add r5,r0,#0x0	; 0232DCDA
	add r4,r1,#0x0	; 0232DCDC
	add r6,r2,#0x0	; 0232DCDE
	bl P1_GetSubBg1CharacterBase	; 0232DCE0
	add r2,r0,#0x0	; 0232DCE4
	ldr r0,[pool_0232DD14]	; 0232DCE6
	ldr r0,[r0,#0x0]	; 0232DCE8
	mov r1,#0x0	; 0232DCEA
	mvn r1,r1	; 0232DCEC
	cmp r0,r1	; 0232DCEE
	beq loc_0232DD02	; 0232DCF0
	add r1,r5,#0x0	; 0232DCF2
	add r2,r2,r4	; 0232DCF4
	add r3,r6,#0x0	; 0232DCF6
	bl loc_0232E24C	; 0232DCF8
	pop {r4,r5,r6}	; 0232DCFC
	pop {r3}	; 0232DCFE
	bx r3	; 0232DD00
loc_0232DD02:
	add r0,r5,#0x0	; 0232DD02
	add r1,r2,r4	; 0232DD04
	add r2,r6,#0x0	; 0232DD06
	blx loc_0232E32C	; 0232DD08
	pop {r4,r5,r6}	; 0232DD0C
	pop {r3}	; 0232DD0E
	bx r3	; 0232DD10
	.byte 0xC0, 0x46	; 0232DD14
pool_0232DD14:
loc_0232DD14:
	.word P1_Data_02330E4C	; 0232DD14

; ===== function loc_0232DD18 =====
loc_0232DD18:
	push {r4,r5,r6,lr}	; 0232DD18
	add r5,r0,#0x0	; 0232DD1A
	add r4,r1,#0x0	; 0232DD1C
	add r6,r2,#0x0	; 0232DD1E
	bl P1_GetMainBg1CharacterBase	; 0232DD20
	add r2,r0,#0x0	; 0232DD24
	ldr r0,[pool_0232DD54]	; 0232DD26
	ldr r0,[r0,#0x0]	; 0232DD28
	mov r1,#0x0	; 0232DD2A
	mvn r1,r1	; 0232DD2C
	cmp r0,r1	; 0232DD2E
	beq loc_0232DD42	; 0232DD30
	add r1,r5,#0x0	; 0232DD32
	add r2,r2,r4	; 0232DD34
	add r3,r6,#0x0	; 0232DD36
	bl loc_0232E24C	; 0232DD38
	pop {r4,r5,r6}	; 0232DD3C
	pop {r3}	; 0232DD3E
	bx r3	; 0232DD40
loc_0232DD42:
	add r0,r5,#0x0	; 0232DD42
	add r1,r2,r4	; 0232DD44
	add r2,r6,#0x0	; 0232DD46
	blx loc_0232E32C	; 0232DD48
	pop {r4,r5,r6}	; 0232DD4C
	pop {r3}	; 0232DD4E
	bx r3	; 0232DD50
	.byte 0xC0, 0x46	; 0232DD54
pool_0232DD54:
loc_0232DD54:
	.word P1_Data_02330E4C	; 0232DD54

; ===== function loc_0232DD58 =====
	push {r4,r5,r6,lr}	; 0232DD58
	add r5,r0,#0x0	; 0232DD5A
	add r4,r1,#0x0	; 0232DD5C
	add r6,r2,#0x0	; 0232DD5E
	bl P1_GetSubBg0CharacterBase	; 0232DD60
	add r2,r0,#0x0	; 0232DD64
	ldr r0,[pool_0232DD94]	; 0232DD66
	ldr r0,[r0,#0x0]	; 0232DD68
	mov r1,#0x0	; 0232DD6A
	mvn r1,r1	; 0232DD6C
	cmp r0,r1	; 0232DD6E
	beq loc_0232DD82	; 0232DD70
	add r1,r5,#0x0	; 0232DD72
	add r2,r2,r4	; 0232DD74
	add r3,r6,#0x0	; 0232DD76
	bl loc_0232E24C	; 0232DD78
	pop {r4,r5,r6}	; 0232DD7C
	pop {r3}	; 0232DD7E
	bx r3	; 0232DD80
loc_0232DD82:
	add r0,r5,#0x0	; 0232DD82
	add r1,r2,r4	; 0232DD84
	add r2,r6,#0x0	; 0232DD86
	blx loc_0232E32C	; 0232DD88
	pop {r4,r5,r6}	; 0232DD8C
	pop {r3}	; 0232DD8E
	bx r3	; 0232DD90
	.byte 0xC0, 0x46	; 0232DD94
pool_0232DD94:
loc_0232DD94:
	.word P1_Data_02330E4C	; 0232DD94
P1_Entry_0232DD98:
	push {r4,r5,r6,lr}	; 0232DD98
	add r5,r0,#0x0	; 0232DD9A
	add r4,r1,#0x0	; 0232DD9C
	add r6,r2,#0x0	; 0232DD9E
	bl P1_GetMainBg0CharacterBase	; 0232DDA0
	add r2,r0,#0x0	; 0232DDA4
	ldr r0,[pool_0232DDD4]	; 0232DDA6
	ldr r0,[r0,#0x0]	; 0232DDA8
	mov r1,#0x0	; 0232DDAA
	mvn r1,r1	; 0232DDAC
	cmp r0,r1	; 0232DDAE
	beq P1_Entry_0232DDC2	; 0232DDB0
	add r1,r5,#0x0	; 0232DDB2
	add r2,r2,r4	; 0232DDB4
	add r3,r6,#0x0	; 0232DDB6
	bl loc_0232E24C	; 0232DDB8
	pop {r4,r5,r6}	; 0232DDBC
	pop {r3}	; 0232DDBE
	bx r3	; 0232DDC0
P1_Entry_0232DDC2:
	add r0,r5,#0x0	; 0232DDC2
	add r1,r2,r4	; 0232DDC4
	add r2,r6,#0x0	; 0232DDC6
	blx P1_MemCopy32	; 0232DDC8
	pop {r4,r5,r6}	; 0232DDCC
	pop {r3}	; 0232DDCE
	bx r3	; 0232DDD0
	.byte 0xC0, 0x46	; 0232DDD2
pool_0232DDD4:
	.word P1_Data_02330E4C	; 0232DDD4

; ===== function loc_0232DDD8 =====
loc_0232DDD8:
	push {r4,r5,r6,lr}	; 0232DDD8
	add r5,r0,#0x0	; 0232DDDA
	add r4,r1,#0x0	; 0232DDDC
	add r6,r2,#0x0	; 0232DDDE
	bl P1_ResolveSubBg3TilemapAddress	; 0232DDE0
	add r2,r0,#0x0	; 0232DDE4
	ldr r0,[pool_0232DE14]	; 0232DDE6
	ldr r0,[r0,#0x0]	; 0232DDE8
	mov r1,#0x0	; 0232DDEA
	mvn r1,r1	; 0232DDEC
	cmp r0,r1	; 0232DDEE
	beq loc_0232DE02	; 0232DDF0
	add r1,r5,#0x0	; 0232DDF2
	add r2,r2,r4	; 0232DDF4
	add r3,r6,#0x0	; 0232DDF6
	bl loc_0232E20C	; 0232DDF8
	pop {r4,r5,r6}	; 0232DDFC
	pop {r3}	; 0232DDFE
	bx r3	; 0232DE00
loc_0232DE02:
	add r0,r5,#0x0	; 0232DE02
	add r1,r2,r4	; 0232DE04
	add r2,r6,#0x0	; 0232DE06
	blx loc_0232E2FC	; 0232DE08
	pop {r4,r5,r6}	; 0232DE0C
	pop {r3}	; 0232DE0E
	bx r3	; 0232DE10
	.byte 0xC0, 0x46	; 0232DE14
pool_0232DE14:
loc_0232DE14:
	.word P1_Data_02330E4C	; 0232DE14

; ===== function loc_0232DE18 =====
loc_0232DE18:
	push {r4,r5,r6,lr}	; 0232DE18
	add r5,r0,#0x0	; 0232DE1A
	add r4,r1,#0x0	; 0232DE1C
	add r6,r2,#0x0	; 0232DE1E
	blx P1_ResolveMainBg3TilemapAddress	; 0232DE20
	add r2,r0,#0x0	; 0232DE24
	ldr r0,[pool_0232DE54]	; 0232DE26
	ldr r0,[r0,#0x0]	; 0232DE28
	mov r1,#0x0	; 0232DE2A
	mvn r1,r1	; 0232DE2C
	cmp r0,r1	; 0232DE2E
	beq loc_0232DE42	; 0232DE30
	add r1,r5,#0x0	; 0232DE32
	add r2,r2,r4	; 0232DE34
	add r3,r6,#0x0	; 0232DE36
	bl loc_0232E20C	; 0232DE38
	pop {r4,r5,r6}	; 0232DE3C
	pop {r3}	; 0232DE3E
	bx r3	; 0232DE40
loc_0232DE42:
	add r0,r5,#0x0	; 0232DE42
	add r1,r2,r4	; 0232DE44
	add r2,r6,#0x0	; 0232DE46
	blx loc_0232E2FC	; 0232DE48
	pop {r4,r5,r6}	; 0232DE4C
	pop {r3}	; 0232DE4E
	bx r3	; 0232DE50
	.byte 0xC0, 0x46	; 0232DE54
pool_0232DE54:
loc_0232DE54:
	.word P1_Data_02330E4C	; 0232DE54

; ===== function loc_0232DE58 =====
loc_0232DE58:
	push {r4,r5,r6,lr}	; 0232DE58
	add r5,r0,#0x0	; 0232DE5A
	add r4,r1,#0x0	; 0232DE5C
	add r6,r2,#0x0	; 0232DE5E
	bl P1_ResolveSubBg2TilemapAddress	; 0232DE60
	add r2,r0,#0x0	; 0232DE64
	ldr r0,[pool_0232DE94]	; 0232DE66
	ldr r0,[r0,#0x0]	; 0232DE68
	mov r1,#0x0	; 0232DE6A
	mvn r1,r1	; 0232DE6C
	cmp r0,r1	; 0232DE6E
	beq loc_0232DE82	; 0232DE70
	add r1,r5,#0x0	; 0232DE72
	add r2,r2,r4	; 0232DE74
	add r3,r6,#0x0	; 0232DE76
	bl loc_0232E20C	; 0232DE78
	pop {r4,r5,r6}	; 0232DE7C
	pop {r3}	; 0232DE7E
	bx r3	; 0232DE80
loc_0232DE82:
	add r0,r5,#0x0	; 0232DE82
	add r1,r2,r4	; 0232DE84
	add r2,r6,#0x0	; 0232DE86
	blx loc_0232E2FC	; 0232DE88
	pop {r4,r5,r6}	; 0232DE8C
	pop {r3}	; 0232DE8E
	bx r3	; 0232DE90
	.byte 0xC0, 0x46	; 0232DE94
pool_0232DE94:
loc_0232DE94:
	.word P1_Data_02330E4C	; 0232DE94

; ===== function loc_0232DE98 =====
loc_0232DE98:
	push {r4,r5,r6,lr}	; 0232DE98
	add r5,r0,#0x0	; 0232DE9A
	add r4,r1,#0x0	; 0232DE9C
	add r6,r2,#0x0	; 0232DE9E
	blx P1_ResolveMainBg2TilemapAddress	; 0232DEA0
	add r2,r0,#0x0	; 0232DEA4
	ldr r0,[pool_0232DED4]	; 0232DEA6
	ldr r0,[r0,#0x0]	; 0232DEA8
	mov r1,#0x0	; 0232DEAA
	mvn r1,r1	; 0232DEAC
	cmp r0,r1	; 0232DEAE
	beq loc_0232DEC2	; 0232DEB0
	add r1,r5,#0x0	; 0232DEB2
	add r2,r2,r4	; 0232DEB4
	add r3,r6,#0x0	; 0232DEB6
	bl loc_0232E20C	; 0232DEB8
	pop {r4,r5,r6}	; 0232DEBC
	pop {r3}	; 0232DEBE
	bx r3	; 0232DEC0
loc_0232DEC2:
	add r0,r5,#0x0	; 0232DEC2
	add r1,r2,r4	; 0232DEC4
	add r2,r6,#0x0	; 0232DEC6
	blx loc_0232E2FC	; 0232DEC8
	pop {r4,r5,r6}	; 0232DECC
	pop {r3}	; 0232DECE
	bx r3	; 0232DED0
	.byte 0xC0, 0x46	; 0232DED4
pool_0232DED4:
loc_0232DED4:
	.word P1_Data_02330E4C	; 0232DED4

; ===== function loc_0232DED8 =====
loc_0232DED8:
	push {r4,r5,r6,lr}	; 0232DED8
	add r5,r0,#0x0	; 0232DEDA
	add r4,r1,#0x0	; 0232DEDC
	add r6,r2,#0x0	; 0232DEDE
	bl P1_GetSubBg1TilemapBase	; 0232DEE0
	add r2,r0,#0x0	; 0232DEE4
	ldr r0,[pool_0232DF14]	; 0232DEE6
	ldr r0,[r0,#0x0]	; 0232DEE8
	mov r1,#0x0	; 0232DEEA
	mvn r1,r1	; 0232DEEC
	cmp r0,r1	; 0232DEEE
	beq loc_0232DF02	; 0232DEF0
	add r1,r5,#0x0	; 0232DEF2
	add r2,r2,r4	; 0232DEF4
	add r3,r6,#0x0	; 0232DEF6
	bl loc_0232E20C	; 0232DEF8
	pop {r4,r5,r6}	; 0232DEFC
	pop {r3}	; 0232DEFE
	bx r3	; 0232DF00
loc_0232DF02:
	add r0,r5,#0x0	; 0232DF02
	add r1,r2,r4	; 0232DF04
	add r2,r6,#0x0	; 0232DF06
	blx loc_0232E2FC	; 0232DF08
	pop {r4,r5,r6}	; 0232DF0C
	pop {r3}	; 0232DF0E
	bx r3	; 0232DF10
	.byte 0xC0, 0x46	; 0232DF14
pool_0232DF14:
loc_0232DF14:
	.word P1_Data_02330E4C	; 0232DF14

; ===== function loc_0232DF18 =====
loc_0232DF18:
	push {r4,r5,r6,lr}	; 0232DF18
	add r5,r0,#0x0	; 0232DF1A
	add r4,r1,#0x0	; 0232DF1C
	add r6,r2,#0x0	; 0232DF1E
	bl P1_GetMainBg1TilemapBase	; 0232DF20
	add r2,r0,#0x0	; 0232DF24
	ldr r0,[pool_0232DF54]	; 0232DF26
	ldr r0,[r0,#0x0]	; 0232DF28
	mov r1,#0x0	; 0232DF2A
	mvn r1,r1	; 0232DF2C
	cmp r0,r1	; 0232DF2E
	beq loc_0232DF42	; 0232DF30
	add r1,r5,#0x0	; 0232DF32
	add r2,r2,r4	; 0232DF34
	add r3,r6,#0x0	; 0232DF36
	bl loc_0232E20C	; 0232DF38
	pop {r4,r5,r6}	; 0232DF3C
	pop {r3}	; 0232DF3E
	bx r3	; 0232DF40
loc_0232DF42:
	add r0,r5,#0x0	; 0232DF42
	add r1,r2,r4	; 0232DF44
	add r2,r6,#0x0	; 0232DF46
	blx loc_0232E2FC	; 0232DF48
	pop {r4,r5,r6}	; 0232DF4C
	pop {r3}	; 0232DF4E
	bx r3	; 0232DF50
	.byte 0xC0, 0x46	; 0232DF54
pool_0232DF54:
loc_0232DF54:
	.word P1_Data_02330E4C	; 0232DF54

; ===== function loc_0232DF58 =====
loc_0232DF58:
	push {r4,r5,r6,lr}	; 0232DF58
	add r5,r0,#0x0	; 0232DF5A
	add r4,r1,#0x0	; 0232DF5C
	add r6,r2,#0x0	; 0232DF5E
	bl P1_GetSubBg0TilemapBase	; 0232DF60
	add r2,r0,#0x0	; 0232DF64
	ldr r0,[pool_0232DF94]	; 0232DF66
	ldr r0,[r0,#0x0]	; 0232DF68
	mov r1,#0x0	; 0232DF6A
	mvn r1,r1	; 0232DF6C
	cmp r0,r1	; 0232DF6E
	beq loc_0232DF82	; 0232DF70
	add r1,r5,#0x0	; 0232DF72
	add r2,r2,r4	; 0232DF74
	add r3,r6,#0x0	; 0232DF76
	bl loc_0232E20C	; 0232DF78
	pop {r4,r5,r6}	; 0232DF7C
	pop {r3}	; 0232DF7E
	bx r3	; 0232DF80
loc_0232DF82:
	add r0,r5,#0x0	; 0232DF82
	add r1,r2,r4	; 0232DF84
	add r2,r6,#0x0	; 0232DF86
	blx loc_0232E2FC	; 0232DF88
	pop {r4,r5,r6}	; 0232DF8C
	pop {r3}	; 0232DF8E
	bx r3	; 0232DF90
	.byte 0xC0, 0x46	; 0232DF94
pool_0232DF94:
loc_0232DF94:
	.word P1_Data_02330E4C	; 0232DF94

; ===== function loc_0232DF98 =====
P1_Entry_0232DF98:
	push {r4,r5,r6,lr}	; 0232DF98
	add r5,r0,#0x0	; 0232DF9A
	add r4,r1,#0x0	; 0232DF9C
	add r6,r2,#0x0	; 0232DF9E
	bl P1_GetMainBg0TilemapBase	; 0232DFA0
	add r2,r0,#0x0	; 0232DFA4
	ldr r0,[pool_0232DFD4]	; 0232DFA6
	ldr r0,[r0,#0x0]	; 0232DFA8
	mov r1,#0x0	; 0232DFAA
	mvn r1,r1	; 0232DFAC
	cmp r0,r1	; 0232DFAE
	beq loc_0232DFC2	; 0232DFB0
	add r1,r5,#0x0	; 0232DFB2
	add r2,r2,r4	; 0232DFB4
	add r3,r6,#0x0	; 0232DFB6
	bl loc_0232E20C	; 0232DFB8
	pop {r4,r5,r6}	; 0232DFBC
	pop {r3}	; 0232DFBE
	bx r3	; 0232DFC0
loc_0232DFC2:
	add r0,r5,#0x0	; 0232DFC2
	add r1,r2,r4	; 0232DFC4
	add r2,r6,#0x0	; 0232DFC6
	blx loc_0232E2FC	; 0232DFC8
	pop {r4,r5,r6}	; 0232DFCC
	pop {r3}	; 0232DFCE
	bx r3	; 0232DFD0
	.byte 0xC0, 0x46	; 0232DFD4
pool_0232DFD4:
loc_0232DFD4:
	.word P1_Data_02330E4C	; 0232DFD4

; ===== function loc_0232DFD8 =====
loc_0232DFD8:
	push {r4,r5,r6,r7,lr}	; 0232DFD8
	sub sp,#0x4	; 0232DFDA
	add r5,r0,#0x0	; 0232DFDC
	add r4,r1,#0x0	; 0232DFDE
	add r3,r2,#0x0	; 0232DFE0
	ldr r7,[pool_0232E010]	; 0232DFE2
	ldr r1,[pool_0232E014]	; 0232DFE4
	ldr r1,[r1,#0x0]	; 0232DFE6
	mov r6,#0x0	; 0232DFE8
	mvn r6,r6	; 0232DFEA
	cmp r1,r6	; 0232DFEC
	beq loc_0232E002	; 0232DFEE
	add r0,r1,#0x0	; 0232DFF0
	add r1,r5,#0x0	; 0232DFF2
	add r2,r7,r4	; 0232DFF4
	bl loc_0232E24C	; 0232DFF6
	add sp,#0x4	; 0232DFFA
	pop {r4,r5,r6,r7}	; 0232DFFC
	pop {r3}	; 0232DFFE
	bx r3	; 0232E000
loc_0232E002:
	add r1,r7,r4	; 0232E002
	blx loc_0232E32C	; 0232E004
	add sp,#0x4	; 0232E008
	pop {r4,r5,r6,r7}	; 0232E00A
	pop {r3}	; 0232E00C
	bx r3	; 0232E00E
pool_0232E010:
loc_0232E010:
	.word 0x06600000	; 0232E010
pool_0232E014:
loc_0232E014:
	.word P1_Data_02330E4C	; 0232E014

; ===== function loc_0232E018 =====
loc_0232E018:
	push {r4,r5,r6,r7,lr}	; 0232E018
	sub sp,#0x4	; 0232E01A
	add r5,r0,#0x0	; 0232E01C
	add r4,r1,#0x0	; 0232E01E
	add r3,r2,#0x0	; 0232E020
	ldr r7,[pool_0232E050]	; 0232E022
	ldr r1,[pool_0232E054]	; 0232E024
	ldr r1,[r1,#0x0]	; 0232E026
	mov r6,#0x0	; 0232E028
	mvn r6,r6	; 0232E02A
	cmp r1,r6	; 0232E02C
	beq loc_0232E042	; 0232E02E
	add r0,r1,#0x0	; 0232E030
	add r1,r5,#0x0	; 0232E032
	add r2,r7,r4	; 0232E034
	bl loc_0232E24C	; 0232E036
	add sp,#0x4	; 0232E03A
	pop {r4,r5,r6,r7}	; 0232E03C
	pop {r3}	; 0232E03E
	bx r3	; 0232E040
loc_0232E042:
	add r1,r7,r4	; 0232E042
	blx loc_0232E32C	; 0232E044
	add sp,#0x4	; 0232E048
	pop {r4,r5,r6,r7}	; 0232E04A
	pop {r3}	; 0232E04C
	bx r3	; 0232E04E
pool_0232E050:
loc_0232E050:
	.word 0x06400000	; 0232E050
pool_0232E054:
loc_0232E054:
	.word P1_Data_02330E4C	; 0232E054

; ===== function loc_0232E058 =====
loc_0232E058:
	push {r4,r5,r6,lr}	; 0232E058
	add r5,r0,#0x0	; 0232E05A
	add r4,r1,#0x0	; 0232E05C
	add r3,r2,#0x0	; 0232E05E
	ldr r1,[pool_0232E08C]	; 0232E060
	ldr r1,[r1,#0x0]	; 0232E062
	mov r6,#0x0	; 0232E064
	mvn r6,r6	; 0232E066
	cmp r1,r6	; 0232E068
	beq loc_0232E07E	; 0232E06A
	add r0,r1,#0x0	; 0232E06C
	add r1,r5,#0x0	; 0232E06E
	ldr r2,[pool_0232E090]	; 0232E070
	add r2,r4,r2	; 0232E072
	bl loc_0232E24C	; 0232E074
	pop {r4,r5,r6}	; 0232E078
	pop {r3}	; 0232E07A
	bx r3	; 0232E07C
loc_0232E07E:
	ldr r1,[pool_0232E090]	; 0232E07E
	add r1,r4,r1	; 0232E080
	blx loc_0232E32C	; 0232E082
	pop {r4,r5,r6}	; 0232E086
	pop {r3}	; 0232E088
	bx r3	; 0232E08A
pool_0232E08C:
loc_0232E08C:
	.word P1_Data_02330E4C	; 0232E08C
pool_0232E090:
loc_0232E090:
	.word 0x07000400	; 0232E090

; ===== function loc_0232E094 =====
loc_0232E094:
	push {r4,r5,r6,lr}	; 0232E094
	add r5,r0,#0x0	; 0232E096
	add r4,r1,#0x0	; 0232E098
	add r3,r2,#0x0	; 0232E09A
	ldr r1,[pool_0232E0C8]	; 0232E09C
	ldr r1,[r1,#0x0]	; 0232E09E
	mov r6,#0x0	; 0232E0A0
	mvn r6,r6	; 0232E0A2
	cmp r1,r6	; 0232E0A4
	beq loc_0232E0BA	; 0232E0A6
	add r0,r1,#0x0	; 0232E0A8
	add r1,r5,#0x0	; 0232E0AA
	ldr r2,[pool_0232E0CC]	; 0232E0AC
	add r2,r4,r2	; 0232E0AE
	bl loc_0232E24C	; 0232E0B0
	pop {r4,r5,r6}	; 0232E0B4
	pop {r3}	; 0232E0B6
	bx r3	; 0232E0B8
loc_0232E0BA:
	ldr r1,[pool_0232E0CC]	; 0232E0BA
	add r1,r4,r1	; 0232E0BC
	blx loc_0232E32C	; 0232E0BE
	pop {r4,r5,r6}	; 0232E0C2
	pop {r3}	; 0232E0C4
	bx r3	; 0232E0C6
pool_0232E0C8:
loc_0232E0C8:
	.word P1_Data_02330E4C	; 0232E0C8
pool_0232E0CC:
loc_0232E0CC:
	.word 0x07000000	; 0232E0CC

; ===== function loc_0232E0D0 =====
loc_0232E0D0:
	push {r4,r5,r6,lr}	; 0232E0D0
	add r5,r0,#0x0	; 0232E0D2
	add r4,r1,#0x0	; 0232E0D4
	add r3,r2,#0x0	; 0232E0D6
	ldr r1,[pool_0232E104]	; 0232E0D8
	ldr r1,[r1,#0x0]	; 0232E0DA
	mov r6,#0x0	; 0232E0DC
	mvn r6,r6	; 0232E0DE
	cmp r1,r6	; 0232E0E0
	beq loc_0232E0F6	; 0232E0E2
	add r0,r1,#0x0	; 0232E0E4
	add r1,r5,#0x0	; 0232E0E6
	ldr r2,[pool_0232E108]	; 0232E0E8
	add r2,r4,r2	; 0232E0EA
	bl loc_0232E20C	; 0232E0EC
	pop {r4,r5,r6}	; 0232E0F0
	pop {r3}	; 0232E0F2
	bx r3	; 0232E0F4
loc_0232E0F6:
	ldr r1,[pool_0232E108]	; 0232E0F6
	add r1,r4,r1	; 0232E0F8
	blx loc_0232E2FC	; 0232E0FA
	pop {r4,r5,r6}	; 0232E0FE
	pop {r3}	; 0232E100
	bx r3	; 0232E102
pool_0232E104:
loc_0232E104:
	.word P1_Data_02330E4C	; 0232E104
pool_0232E108:
loc_0232E108:
	.word 0x05000600	; 0232E108

; ===== function loc_0232E10C =====
loc_0232E10C:
	push {r4,r5,r6,lr}	; 0232E10C
	add r5,r0,#0x0	; 0232E10E
	add r4,r1,#0x0	; 0232E110
	add r3,r2,#0x0	; 0232E112
	ldr r1,[pool_0232E140]	; 0232E114
	ldr r1,[r1,#0x0]	; 0232E116
	mov r6,#0x0	; 0232E118
	mvn r6,r6	; 0232E11A
	cmp r1,r6	; 0232E11C
	beq loc_0232E132	; 0232E11E
	add r0,r1,#0x0	; 0232E120
	add r1,r5,#0x0	; 0232E122
	ldr r2,[pool_0232E144]	; 0232E124
	add r2,r4,r2	; 0232E126
	bl loc_0232E20C	; 0232E128
	pop {r4,r5,r6}	; 0232E12C
	pop {r3}	; 0232E12E
	bx r3	; 0232E130
loc_0232E132:
	ldr r1,[pool_0232E144]	; 0232E132
	add r1,r4,r1	; 0232E134
	blx loc_0232E2FC	; 0232E136
	pop {r4,r5,r6}	; 0232E13A
	pop {r3}	; 0232E13C
	bx r3	; 0232E13E
pool_0232E140:
loc_0232E140:
	.word P1_Data_02330E4C	; 0232E140
pool_0232E144:
loc_0232E144:
	.word 0x05000200	; 0232E144

; ===== function loc_0232E148 =====
loc_0232E148:
	push {r4,r5,r6,lr}	; 0232E148
	add r5,r0,#0x0	; 0232E14A
	add r4,r1,#0x0	; 0232E14C
	add r3,r2,#0x0	; 0232E14E
	ldr r1,[pool_0232E17C]	; 0232E150
	ldr r1,[r1,#0x0]	; 0232E152
	mov r6,#0x0	; 0232E154
	mvn r6,r6	; 0232E156
	cmp r1,r6	; 0232E158
	beq loc_0232E16E	; 0232E15A
	add r0,r1,#0x0	; 0232E15C
	add r1,r5,#0x0	; 0232E15E
	ldr r2,[pool_0232E180]	; 0232E160
	add r2,r4,r2	; 0232E162
	bl loc_0232E20C	; 0232E164
	pop {r4,r5,r6}	; 0232E168
	pop {r3}	; 0232E16A
	bx r3	; 0232E16C
loc_0232E16E:
	ldr r1,[pool_0232E180]	; 0232E16E
	add r1,r4,r1	; 0232E170
	blx loc_0232E2FC	; 0232E172
	pop {r4,r5,r6}	; 0232E176
	pop {r3}	; 0232E178
	bx r3	; 0232E17A
pool_0232E17C:
loc_0232E17C:
	.word P1_Data_02330E4C	; 0232E17C
pool_0232E180:
loc_0232E180:
	.word 0x05000400	; 0232E180

; ===== function loc_0232E184 =====
loc_0232E184:
	push {r4,r5,r6,lr}	; 0232E184
	add r5,r0,#0x0	; 0232E186
	add r4,r1,#0x0	; 0232E188
	add r3,r2,#0x0	; 0232E18A
	ldr r1,[pool_0232E1B8]	; 0232E18C
	ldr r1,[r1,#0x0]	; 0232E18E
	mov r6,#0x0	; 0232E190
	mvn r6,r6	; 0232E192
	cmp r1,r6	; 0232E194
	beq loc_0232E1AA	; 0232E196
	add r0,r1,#0x0	; 0232E198
	add r1,r5,#0x0	; 0232E19A
	ldr r2,[pool_0232E1BC]	; 0232E19C
	add r2,r4,r2	; 0232E19E
	bl loc_0232E20C	; 0232E1A0
	pop {r4,r5,r6}	; 0232E1A4
	pop {r3}	; 0232E1A6
	bx r3	; 0232E1A8
loc_0232E1AA:
	ldr r1,[pool_0232E1BC]	; 0232E1AA
	add r1,r4,r1	; 0232E1AC
	blx loc_0232E2FC	; 0232E1AE
	pop {r4,r5,r6}	; 0232E1B2
	pop {r3}	; 0232E1B4
	bx r3	; 0232E1B6
pool_0232E1B8:
loc_0232E1B8:
	.word P1_Data_02330E4C	; 0232E1B8
pool_0232E1BC:
loc_0232E1BC:
	.word 0x05000000	; 0232E1BC

; ===== function loc_0232E1C0 =====
loc_0232E1C0:
	ldr r1,[pool_0232E1C8]	; 0232E1C0
	strb r0,[r1,#0x0]	; 0232E1C2
	bx lr	; 0232E1C4
	.byte 0xC0, 0x46	; 0232E1C8
pool_0232E1C8:
loc_0232E1C8:
	.word REG_WRAMCNT	; 0232E1C8

; ===== function loc_0232E1CC =====
loc_0232E1CC:
	push {r4,lr}	; 0232E1CC
	add r4,r0,#0x0	; 0232E1CE
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E1D0
	mov r1,#0x6	; 0232E1D4
	mul r4,r1	; 0232E1D6
	add r1,r4,#0x5	; 0232E1D8
	lsl r2,r1,#0x1	; 0232E1DA
	ldr r1,[pool_0232E200]	; 0232E1DC
	add r3,r2,r1	; 0232E1DE
	ldrh r2,[r3,#0x0]	; 0232E1E0
	ldr r1,[pool_0232E204]	; 0232E1E2
	and r2,r1	; 0232E1E4
	strh r2,[r3,#0x0]	; 0232E1E6
	ldrh r2,[r3,#0x0]	; 0232E1E8
	ldr r1,[pool_0232E208]	; 0232E1EA
	and r2,r1	; 0232E1EC
	strh r2,[r3,#0x0]	; 0232E1EE
	ldrh r1,[r3,#0x0]	; 0232E1F0
	ldrh r1,[r3,#0x0]	; 0232E1F2
	blx P1_Arm9RestoreIrqMask	; 0232E1F4
	pop {r4}	; 0232E1F8
	pop {r3}	; 0232E1FA
	bx r3	; 0232E1FC
	.byte 0xC0, 0x46	; 0232E200
pool_0232E200:
loc_0232E200:
	.word REG_DMA0SAD	; 0232E200
pool_0232E204:
loc_0232E204:
	.word 0xFFFFC5FF	; 0232E204
pool_0232E208:
loc_0232E208:
	.word 0xFFFF7FFF	; 0232E208

; ===== function loc_0232E20C =====
loc_0232E20C:
	push {r4,r5,r6,lr}	; 0232E20C
	cmp r3,#0x0	; 0232E20E
	beq loc_0232E23E	; 0232E210
	mov r4,#0x3	; 0232E212
	add r5,r0,#0x0	; 0232E214
	mul r5,r4	; 0232E216
	add r4,r5,#0x2	; 0232E218
	lsl r5,r4,#0x2	; 0232E21A
	ldr r4,[pool_0232E244]	; 0232E21C
	add r4,r5,r4	; 0232E21E
	ldr r5,[pool_0232E248]	; 0232E220
loc_0232E222:
	ldr r6,[r4,#0x0]	; 0232E222
	and r6,r5	; 0232E224
	cmp r6,#0x0	; 0232E226
	bne loc_0232E222	; 0232E228
	lsr r3,r3,#0x1	; 0232E22A
	ldr r5,[pool_0232E248]	; 0232E22C
	orr r3,r5	; 0232E22E
	bl P1_SetDmaChannelRegisters	; 0232E230
	lsl r0,r5,#0	; 0232E234
loc_0232E236:
	ldr r1,[r4,#0x0]	; 0232E236
	and r1,r0	; 0232E238
	cmp r1,#0x0	; 0232E23A
	bne loc_0232E236	; 0232E23C
loc_0232E23E:
	pop {r4,r5,r6}	; 0232E23E
	pop {r3}	; 0232E240
	bx r3	; 0232E242
pool_0232E244:
loc_0232E244:
	.word REG_DMA0SAD	; 0232E244
pool_0232E248:
loc_0232E248:
	.word 0x80000000	; 0232E248

; ===== function loc_0232E24C =====
loc_0232E24C:
	push {r4,r5,r6,lr}	; 0232E24C
	cmp r3,#0x0	; 0232E24E
	beq loc_0232E27E	; 0232E250
	mov r4,#0x3	; 0232E252
	add r5,r0,#0x0	; 0232E254
	mul r5,r4	; 0232E256
	add r4,r5,#0x2	; 0232E258
	lsl r5,r4,#0x2	; 0232E25A
	ldr r4,[pool_0232E284]	; 0232E25C
	add r4,r5,r4	; 0232E25E
	ldr r5,[pool_0232E288]	; 0232E260
loc_0232E262:
	ldr r6,[r4,#0x0]	; 0232E262
	and r6,r5	; 0232E264
	cmp r6,#0x0	; 0232E266
	bne loc_0232E262	; 0232E268
	lsr r3,r3,#0x2	; 0232E26A
	ldr r5,[pool_0232E28C]	; 0232E26C
	orr r3,r5	; 0232E26E
	bl P1_SetDmaChannelRegisters	; 0232E270
	ldr r0,[pool_0232E288]	; 0232E274
loc_0232E276:
	ldr r1,[r4,#0x0]	; 0232E276
	and r1,r0	; 0232E278
	cmp r1,#0x0	; 0232E27A
	bne loc_0232E276	; 0232E27C
loc_0232E27E:
	pop {r4,r5,r6}	; 0232E27E
	pop {r3}	; 0232E280
	bx r3	; 0232E282
pool_0232E284:
loc_0232E284:
	.word REG_DMA0SAD	; 0232E284
pool_0232E288:
loc_0232E288:
	.word 0x80000000	; 0232E288
pool_0232E28C:
loc_0232E28C:
	.word 0x84000000	; 0232E28C

; ===== function loc_0232E290 =====
loc_0232E290:
	push {r4,r5,r6,lr}	; 0232E290
	add r5,r1,#0x0	; 0232E292
	cmp r3,#0x0	; 0232E294
	beq loc_0232E2CE	; 0232E296
	mov r1,#0x3	; 0232E298
	add r4,r0,#0x0	; 0232E29A
	mul r4,r1	; 0232E29C
	add r1,r4,#0x2	; 0232E29E
	lsl r4,r1,#0x2	; 0232E2A0
	ldr r1,[pool_0232E2D4]	; 0232E2A2
	add r4,r4,r1	; 0232E2A4
	ldr r1,[pool_0232E2D8]	; 0232E2A6
loc_0232E2A8:
	ldr r6,[r4,#0x0]	; 0232E2A8
	and r6,r1	; 0232E2AA
	cmp r6,#0x0	; 0232E2AC
	bne loc_0232E2A8	; 0232E2AE
	lsl r6,r0,#0x2	; 0232E2B0
	ldr r1,[pool_0232E2DC]	; 0232E2B2
	add r1,r6,r1	; 0232E2B4
	str r2,[r1,#0x0]	; 0232E2B6
	add r2,r5,#0x0	; 0232E2B8
	lsr r3,r3,#0x2	; 0232E2BA
	ldr r5,[pool_0232E2E0]	; 0232E2BC
	orr r3,r5	; 0232E2BE
	bl P1_SetDmaChannelRegisters	; 0232E2C0
	ldr r0,[pool_0232E2D8]	; 0232E2C4
loc_0232E2C6:
	ldr r1,[r4,#0x0]	; 0232E2C6
	and r1,r0	; 0232E2C8
	cmp r1,#0x0	; 0232E2CA
	bne loc_0232E2C6	; 0232E2CC
loc_0232E2CE:
	pop {r4,r5,r6}	; 0232E2CE
	pop {r3}	; 0232E2D0
	bx r3	; 0232E2D2
pool_0232E2D4:
loc_0232E2D4:
	.word REG_DMA0SAD	; 0232E2D4
pool_0232E2D8:
loc_0232E2D8:
	.word 0x80000000	; 0232E2D8
pool_0232E2DC:
loc_0232E2DC:
	.word REG_DMA0FILL	; 0232E2DC
pool_0232E2E0:
loc_0232E2E0:
	.word 0x85000000	; 0232E2E0
.arm

; ===== function loc_0232E2E4 =====
loc_0232E2E4:
	mov r3,#0x0	; 0232E2E4
loc_0232E2E8:
	cmp r3,r2	; 0232E2E8
	strlth r0,[r1,r3]	; 0232E2EC
	addlt r3,r3,#0x2	; 0232E2F0
	blt loc_0232E2E8	; 0232E2F4
	bx lr	; 0232E2F8

; ===== function loc_0232E2FC =====
loc_0232E2FC:
	mov r12,#0x0	; 0232E2FC
loc_0232E300:
	cmp r12,r2	; 0232E300
	ldrlth r3,[r0,r12]	; 0232E304
	strlth r3,[r1,r12]	; 0232E308
	addlt r12,r12,#0x2	; 0232E30C
	blt loc_0232E300	; 0232E310
	bx lr	; 0232E314

; ===== function loc_0232E318 =====
; r0=填充值，r1=目标，r2=字节数；按 32 位字写入。
; r0=value, r1=destination, r2=byte count; fills in 32-bit words.
P1_MemFill32:
loc_0232E318:
	add r12,r1,r2	; 0232E318
loc_0232E31C:
	cmp r1,r12	; 0232E31C
	stmltia r1!,{r0}	; 0232E320
	blt loc_0232E31C	; 0232E324
	bx lr	; 0232E328

; ===== function loc_0232E32C =====
; r0=源，r1=目标，r2=字节数；按 32 位字复制。
; r0=source, r1=destination, r2=byte count; copies 32-bit words.
P1_MemCopy32:
loc_0232E32C:
	add r12,r1,r2	; 0232E32C
loc_0232E330:
	cmp r1,r12	; 0232E330
	ldmltia r0!,{r2}	; 0232E334
	stmltia r1!,{r2}	; 0232E338
	blt loc_0232E330	; 0232E33C
	bx lr	; 0232E340

; ===== function loc_0232E344 =====
loc_0232E344:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 0232E344
	add r9,r1,r2	; 0232E348
	mov r12,r2, lsr #0x5	; 0232E34C
	add r12,r1,r12, lsl #0x5	; 0232E350
	mov r2,r0	; 0232E354
	mov r3,r2	; 0232E358
	mov r4,r2	; 0232E35C
	mov r5,r2	; 0232E360
	mov r6,r2	; 0232E364
	mov r7,r2	; 0232E368
	mov r8,r2	; 0232E36C
loc_0232E370:
	cmp r1,r12	; 0232E370
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 0232E374
	blt loc_0232E370	; 0232E378
loc_0232E37C:
	cmp r1,r9	; 0232E37C
	stmltia r1!,{r0}	; 0232E380
	blt loc_0232E37C	; 0232E384
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 0232E388
	bx lr	; 0232E38C

; ===== function loc_0232E390 =====
loc_0232E390:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232E390
	add r10,r1,r2	; 0232E394
	mov r12,r2, lsr #0x5	; 0232E398
	add r12,r1,r12, lsl #0x5	; 0232E39C
loc_0232E3A0:
	cmp r1,r12	; 0232E3A0
	ldmltia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232E3A4
	stmltia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232E3A8
	blt loc_0232E3A0	; 0232E3AC
loc_0232E3B0:
	cmp r1,r10	; 0232E3B0
	ldmltia r0!,{r2}	; 0232E3B4
	stmltia r1!,{r2}	; 0232E3B8
	blt loc_0232E3B0	; 0232E3BC
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232E3C0
	bx lr	; 0232E3C4

; ===== function loc_0232E3C8 =====
loc_0232E3C8:
	mov r12,#0x0	; 0232E3C8
loc_0232E3CC:
	cmp r12,r2	; 0232E3CC
	strltb r1,[r0,r12]	; 0232E3D0
	addlt r12,r12,#0x1	; 0232E3D4
	blt loc_0232E3CC	; 0232E3D8
	bx lr	; 0232E3DC
P1_Entry_0232E3E0:
	mov r12,#0x0	; 0232E3E0
P1_Entry_0232E3E4:
	cmp r12,r2	; 0232E3E4
	ldrltb r3,[r0,r12]	; 0232E3E8
	strltb r3,[r1,r12]	; 0232E3EC
	addlt r12,r12,#0x1	; 0232E3F0
	blt P1_Entry_0232E3E4	; 0232E3F4
	bx lr	; 0232E3F8

; ===== function loc_0232E3FC =====
loc_0232E3FC:
	swp r0,r0,[r1]	; 0232E3FC
	bx lr	; 0232E400
.thumb

; ===== function loc_0232E404 =====
loc_0232E404:
	push {lr}	; 0232E404
	sub sp,#0x4	; 0232E406
	ldr r0,[pool_0232E424]	; 0232E408
	ldr r1,[r0,#0x0]	; 0232E40A
	cmp r1,#0x0	; 0232E40C
	bne loc_0232E41C	; 0232E40E
	mov r1,#0x1	; 0232E410
	str r1,[r0,#0x0]	; 0232E412
	bl loc_0232EA38	; 0232E414
	bl loc_0232EB5C	; 0232E418
loc_0232E41C:
	add sp,#0x4	; 0232E41C
	pop {r3}	; 0232E41E
	bx r3	; 0232E420
	.byte 0xC0, 0x46	; 0232E424
pool_0232E424:
loc_0232E424:
	.word P1_BssStart + 0x266C4	; 0232E424

; ===== function loc_0232E428 =====
loc_0232E428:
	push {r4,r5,r6,r7,lr}	; 0232E428
	sub sp,#0x4	; 0232E42A
	add r5,r0,#0x0	; 0232E42C
	add r4,r1,#0x0	; 0232E42E
	add r6,r2,#0x0	; 0232E430
	add r7,r3,#0x0	; 0232E432
	mov r0,#0x1	; 0232E434
; 填充请求记录的命令与四个参数，并将其追加到待处理链。
; Fill a request record with a command and four arguments, then append it to the pending chain.
.func P1_QueueRequestRecord
	bl P1_AcquireRequestRecord	; 0232E436
	cmp r0,#0x0	; 0232E43A
	beq loc_0232E44E	; 0232E43C
	str r5,[r0,#P1_RequestRecordCommandOffset]	; 0232E43E
	str r4,[r0,#P1_RequestRecordArgument0Offset]	; 0232E440
	str r6,[r0,#P1_RequestRecordArgument1Offset]	; 0232E442
	str r7,[r0,#P1_RequestRecordArgument2Offset]	; 0232E444
	ldr r1,[sp,#0x18]	; 0232E446
	str r1,[r0,#P1_RequestRecordArgument3Offset]	; 0232E448
	bl P1_EnqueueRequestRecord	; 0232E44A
loc_0232E44E:
	add sp,#0x4	; 0232E44E
	pop {r4,r5,r6,r7}	; 0232E450
	pop {r3}	; 0232E452
	bx r3	; 0232E454
	.byte 0x00, 0x00	; 0232E458

; ===== function loc_0232E458 =====
loc_0232E458:
	push {lr}	; 0232E458
	sub sp,#0x4	; 0232E45A
	add r1,r0,#0x0	; 0232E45C
.endfunc
	mov r2,#0x0	; 0232E45E
	str r2,[sp,#0x0]	; 0232E460
	mov r0,#0x13	; 0232E462
	add r3,r2,#0x0	; 0232E464
	bl P1_QueueRequestRecord	; 0232E466
	add sp,#0x4	; 0232E46A
	pop {r3}	; 0232E46C
	bx r3	; 0232E46E

; ===== function loc_0232E470 =====
loc_0232E470:
	push {r4,r5,r6,lr}	; 0232E470
	sub sp,#0x8	; 0232E472
	add r6,r0,#0x0	; 0232E474
	add r5,r1,#0x0	; 0232E476
	add r4,r2,#0x0	; 0232E478
	str r3,[sp,#0x0]	; 0232E47A
	mov r0,#0x4	; 0232E47C
	ldr r1,[sp,#0x18]	; 0232E47E
	lsl r1,r1,#0x18	; 0232E480
	orr r1,r6	; 0232E482
	add r2,r5,#0x0	; 0232E484
	add r3,r4,#0x0	; 0232E486
	bl P1_QueueRequestRecord	; 0232E488
	add sp,#0x8	; 0232E48C
	pop {r4,r5,r6}	; 0232E48E
	pop {r3}	; 0232E490
	bx r3	; 0232E492

; ===== function loc_0232E494 =====
loc_0232E494:
	push {r4,r5,r6,lr}	; 0232E494
	sub sp,#0x8	; 0232E496
	add r6,r0,#0x0	; 0232E498
	add r5,r1,#0x0	; 0232E49A
	add r4,r2,#0x0	; 0232E49C
	str r3,[sp,#0x0]	; 0232E49E
	mov r0,#0x3	; 0232E4A0
	add r1,r6,#0x0	; 0232E4A2
	add r2,r5,#0x0	; 0232E4A4
	add r3,r4,#0x0	; 0232E4A6
	bl P1_QueueRequestRecord	; 0232E4A8
	add sp,#0x8	; 0232E4AC
	pop {r4,r5,r6}	; 0232E4AE
	pop {r3}	; 0232E4B0
	bx r3	; 0232E4B2

; ===== function loc_0232E4B4 =====
loc_0232E4B4:
	push {r4,r5,r6,lr}	; 0232E4B4
	sub sp,#0x8	; 0232E4B6
	add r6,r0,#0x0	; 0232E4B8
	add r5,r1,#0x0	; 0232E4BA
	add r4,r2,#0x0	; 0232E4BC
	str r3,[sp,#0x0]	; 0232E4BE
	mov r0,#0x15	; 0232E4C0
	add r1,r6,#0x0	; 0232E4C2
	add r2,r5,#0x0	; 0232E4C4
	add r3,r4,#0x0	; 0232E4C6
	bl P1_QueueRequestRecord	; 0232E4C8
	add sp,#0x8	; 0232E4CC
	pop {r4,r5,r6}	; 0232E4CE
	pop {r3}	; 0232E4D0
	bx r3	; 0232E4D2

; ===== function loc_0232E4D4 =====
loc_0232E4D4:
	push {r4,r5,lr}	; 0232E4D4
	sub sp,#0x4	; 0232E4D6
	add r5,r0,#0x0	; 0232E4D8
	ldr r4,[sp,#0x10]	; 0232E4DA
	ldr r0,[sp,#0x24]	; 0232E4DC
	lsl r0,r0,#0x10	; 0232E4DE
	lsl r3,r3,#0x1a	; 0232E4E0
	lsl r1,r1,#0x18	; 0232E4E2
	orr r3,r1	; 0232E4E4
	orr r0,r3	; 0232E4E6
	orr r4,r0	; 0232E4E8
	str r4,[sp,#0x0]	; 0232E4EA
	mov r0,#0xb	; 0232E4EC
	ldr r1,[sp,#0x20]	; 0232E4EE
	lsl r1,r1,#0x10	; 0232E4F0
	orr r1,r5	; 0232E4F2
	ldr r3,[sp,#0x14]	; 0232E4F4
	ldr r4,[sp,#0x18]	; 0232E4F6
	lsl r5,r4,#0x18	; 0232E4F8
	ldr r4,[sp,#0x1c]	; 0232E4FA
	lsl r4,r4,#0x16	; 0232E4FC
	orr r5,r4	; 0232E4FE
	orr r3,r5	; 0232E500
	bl P1_QueueRequestRecord	; 0232E502
	add sp,#0x4	; 0232E506
	pop {r4,r5}	; 0232E508
	pop {r3}	; 0232E50A
	bx r3	; 0232E50C
	.byte 0x00, 0x00	; 0232E510

; ===== function loc_0232E510 =====
loc_0232E510:
	push {r4,r5,lr}	; 0232E510
	sub sp,#0x4	; 0232E512
	add r5,r0,#0x0	; 0232E514
	add r4,r1,#0x0	; 0232E516
	add r3,r2,#0x0	; 0232E518
	mov r0,#0x0	; 0232E51A
	str r0,[sp,#0x0]	; 0232E51C
	mov r0,#0x11	; 0232E51E
	add r1,r5,#0x0	; 0232E520
	add r2,r4,#0x0	; 0232E522
	bl P1_QueueRequestRecord	; 0232E524
	add sp,#0x4	; 0232E528
	pop {r4,r5}	; 0232E52A
	pop {r3}	; 0232E52C
	bx r3	; 0232E52E

; ===== function loc_0232E530 =====
loc_0232E530:
	push {r4,lr}	; 0232E530
	sub sp,#0x8	; 0232E532
	add r4,r0,#0x0	; 0232E534
	add r2,r1,#0x0	; 0232E536
	mov r3,#0x0	; 0232E538
	str r3,[sp,#0x0]	; 0232E53A
	mov r0,#0x17	; 0232E53C
	add r1,r4,#0x0	; 0232E53E
	bl P1_QueueRequestRecord	; 0232E540
	add sp,#0x8	; 0232E544
	pop {r4}	; 0232E546
	pop {r3}	; 0232E548
	bx r3	; 0232E54A

; ===== function loc_0232E54C =====
loc_0232E54C:
	push {r4,lr}	; 0232E54C
	sub sp,#0x8	; 0232E54E
	add r4,r0,#0x0	; 0232E550
	add r2,r1,#0x0	; 0232E552
	mov r3,#0x0	; 0232E554
	str r3,[sp,#0x0]	; 0232E556
	mov r0,#0x16	; 0232E558
	add r1,r4,#0x0	; 0232E55A
	bl P1_QueueRequestRecord	; 0232E55C
	add sp,#0x8	; 0232E560
	pop {r4}	; 0232E562
	pop {r3}	; 0232E564
	bx r3	; 0232E566

; ===== function loc_0232E568 =====
loc_0232E568:
	push {r4,r5,r6,lr}	; 0232E568
	sub sp,#0x8	; 0232E56A
	add r5,r0,#0x0	; 0232E56C
	add r4,r1,#0x0	; 0232E56E
	add r6,r2,#0x0	; 0232E570
	add r1,r3,#0x0	; 0232E572
	ldr r2,[sp,#0x18]	; 0232E574
	bl loc_0232EB1C	; 0232E576
	str r0,[sp,#0x0]	; 0232E57A
	mov r0,#0xf	; 0232E57C
	add r1,r5,#0x0	; 0232E57E
	add r2,r4,#0x0	; 0232E580
	add r3,r6,#0x0	; 0232E582
	bl P1_QueueRequestRecord	; 0232E584
	add sp,#0x8	; 0232E588
	pop {r4,r5,r6}	; 0232E58A
	pop {r3}	; 0232E58C
	bx r3	; 0232E58E

; ===== function loc_0232E590 =====
loc_0232E590:
	push {r4,r5,r6,r7,lr}	; 0232E590
	sub sp,#0xc	; 0232E592
	add r6,r0,#0x0	; 0232E594
	str r1,[sp,#0x4]	; 0232E596
	mov r0,#0x0	; 0232E598
	str r0,[sp,#0x0]	; 0232E59A
	mov r0,#0xe	; 0232E59C
	add r1,r2,#0x0	; 0232E59E
	add r2,r3,#0x0	; 0232E5A0
	ldr r3,[sp,#0x28]	; 0232E5A2
	lsl r7,r3,#0x1b	; 0232E5A4
	ldr r3,[sp,#0x24]	; 0232E5A6
	lsl r5,r3,#0x1c	; 0232E5A8
	ldr r3,[sp,#0x20]	; 0232E5AA
	lsl r4,r3,#0x1d	; 0232E5AC
	lsl r3,r6,#0x1f	; 0232E5AE
	ldr r6,[sp,#0x4]	; 0232E5B0
	lsl r6,r6,#0x1e	; 0232E5B2
	orr r3,r6	; 0232E5B4
	orr r4,r3	; 0232E5B6
	orr r5,r4	; 0232E5B8
	orr r7,r5	; 0232E5BA
	add r3,r7,#0x0	; 0232E5BC
	bl P1_QueueRequestRecord	; 0232E5BE
	add sp,#0xc	; 0232E5C2
	pop {r4,r5,r6,r7}	; 0232E5C4
	pop {r3}	; 0232E5C6
	bx r3	; 0232E5C8
	.byte 0x00, 0x00	; 0232E5CC

; ===== function loc_0232E5CC =====
loc_0232E5CC:
	push {r4,r5,r6,r7,lr}	; 0232E5CC
	sub sp,#0x14	; 0232E5CE
	str r0,[sp,#0x4]	; 0232E5D0
	str r1,[sp,#0x8]	; 0232E5D2
	add r7,r2,#0x0	; 0232E5D4
	str r3,[sp,#0xc]	; 0232E5D6
	add r4,r7,#0x0	; 0232E5D8
	mov r5,#0x0	; 0232E5DA
	mov r6,#0x1	; 0232E5DC
	b loc_0232E5F2	; 0232E5DE
loc_0232E5E0:
	add r0,r4,#0x0	; 0232E5E0
	and r0,r6	; 0232E5E2
	cmp r0,#0x0	; 0232E5E4
	beq loc_0232E5EE	; 0232E5E6
	add r0,r5,#0x0	; 0232E5E8
	bl loc_0232EB44	; 0232E5EA
loc_0232E5EE:
	add r5,r5,#0x1	; 0232E5EE
	lsr r4,r4,#0x1	; 0232E5F0
loc_0232E5F2:
	cmp r5,#0x8	; 0232E5F2
	bge loc_0232E5FA	; 0232E5F4
	cmp r4,#0x0	; 0232E5F6
	bne loc_0232E5E0	; 0232E5F8
loc_0232E5FA:
	ldr r0,[sp,#0xc]	; 0232E5FA
	str r0,[sp,#0x0]	; 0232E5FC
	mov r0,#0xa	; 0232E5FE
	ldr r1,[sp,#0x4]	; 0232E600
	ldr r2,[sp,#0x8]	; 0232E602
	add r3,r7,#0x0	; 0232E604
	bl P1_QueueRequestRecord	; 0232E606
	add sp,#0x14	; 0232E60A
	pop {r4,r5,r6,r7}	; 0232E60C
	pop {r3}	; 0232E60E
	bx r3	; 0232E610
	.byte 0x00, 0x00	; 0232E614

; ===== function loc_0232E614 =====
loc_0232E614:
	push {r4,r5,r6,lr}	; 0232E614
	sub sp,#0x8	; 0232E616
	add r6,r0,#0x0	; 0232E618
	add r5,r1,#0x0	; 0232E61A
	add r4,r2,#0x0	; 0232E61C
	str r3,[sp,#0x0]	; 0232E61E
	mov r0,#0x9	; 0232E620
	add r1,r6,#0x0	; 0232E622
	add r2,r5,#0x0	; 0232E624
	add r3,r4,#0x0	; 0232E626
	bl P1_QueueRequestRecord	; 0232E628
	add sp,#0x8	; 0232E62C
	pop {r4,r5,r6}	; 0232E62E
	pop {r3}	; 0232E630
	bx r3	; 0232E632

; ===== function loc_0232E634 =====
loc_0232E634:
	push {lr}	; 0232E634
	sub sp,#0x4	; 0232E636
	add r3,r2,#0x0	; 0232E638
	mov r2,#0x1	; 0232E63A
	str r2,[sp,#0x0]	; 0232E63C
	mov r2,#0x1a	; 0232E63E
	bl loc_0232E470	; 0232E640
	add sp,#0x4	; 0232E644
	pop {r3}	; 0232E646
	bx r3	; 0232E648
	.byte 0x00, 0x00	; 0232E64C

; ===== function loc_0232E64C =====
loc_0232E64C:
	push {lr}	; 0232E64C
	sub sp,#0x4	; 0232E64E
	add r3,r2,#0x0	; 0232E650
	mov r2,#0x2	; 0232E652
	str r2,[sp,#0x0]	; 0232E654
	mov r2,#0xc	; 0232E656
	bl loc_0232E470	; 0232E658
	add sp,#0x4	; 0232E65C
	pop {r3}	; 0232E65E
	bx r3	; 0232E660
	.byte 0x00, 0x00	; 0232E664

; ===== function loc_0232E664 =====
loc_0232E664:
	push {lr}	; 0232E664
	sub sp,#0x4	; 0232E666
	add r2,r1,#0x0	; 0232E668
	mov r1,#0x4	; 0232E66A
	mov r3,#0x1	; 0232E66C
	bl loc_0232E494	; 0232E66E
	add sp,#0x4	; 0232E672
	pop {r3}	; 0232E674
	bx r3	; 0232E676

; ===== function loc_0232E678 =====
loc_0232E678:
	push {lr}	; 0232E678
	sub sp,#0x4	; 0232E67A
	add r2,r1,#0x0	; 0232E67C
	mov r1,#0x6	; 0232E67E
	mov r3,#0x2	; 0232E680
	bl loc_0232E494	; 0232E682
	add sp,#0x4	; 0232E686
	pop {r3}	; 0232E688
	bx r3	; 0232E68A

; ===== function loc_0232E68C =====
loc_0232E68C:
	push {lr}	; 0232E68C
	sub sp,#0x4	; 0232E68E
	add r1,r0,#0x0	; 0232E690
	mov r2,#0x0	; 0232E692
	str r2,[sp,#0x0]	; 0232E694
	mov r0,#0x1	; 0232E696
	add r3,r2,#0x0	; 0232E698
	bl P1_QueueRequestRecord	; 0232E69A
	add sp,#0x4	; 0232E69E
	pop {r3}	; 0232E6A0
	bx r3	; 0232E6A2

; ===== function loc_0232E6A4 =====
loc_0232E6A4:
	push {r4,r5,r6,lr}	; 0232E6A4
	sub sp,#0x8	; 0232E6A6
	add r6,r0,#0x0	; 0232E6A8
	add r5,r1,#0x0	; 0232E6AA
	add r4,r2,#0x0	; 0232E6AC
	str r3,[sp,#0x0]	; 0232E6AE
	mov r0,#0x0	; 0232E6B0
	add r1,r6,#0x0	; 0232E6B2
	add r2,r5,#0x0	; 0232E6B4
	add r3,r4,#0x0	; 0232E6B6
	bl P1_QueueRequestRecord	; 0232E6B8
	add sp,#0x8	; 0232E6BC
	pop {r4,r5,r6}	; 0232E6BE
	pop {r3}	; 0232E6C0
	bx r3	; 0232E6C2

; ===== function loc_0232E6C4 =====
loc_0232E6C4:
	ldr r1,[pool_0232E6E0]	; 0232E6C4
	ldr r0,[r1,#0x0]	; 0232E6C6
	cmp r0,#0x0	; 0232E6C8
	bne loc_0232E6D0	; 0232E6CA
	mov r0,#0x0	; 0232E6CC
	bx lr	; 0232E6CE
loc_0232E6D0:
; 从空闲请求链弹出首条记录；链耗尽时同步清空尾指针。
; Pop the first record from the free request chain; clear its tail when exhausted.
.func P1_PopFreeRequestRecord
	ldr r2,[r0,#0x0]	; 0232E6D0
	str r2,[r1,#0x0]	; 0232E6D2
	cmp r2,#0x0	; 0232E6D4
	bne loc_0232E6DE	; 0232E6D6
	mov r2,#0x0	; 0232E6D8
	ldr r1,[pool_0232E6E4]	; 0232E6DA
	str r2,[r1,#0x0]	; 0232E6DC
loc_0232E6DE:
	bx lr	; 0232E6DE
pool_0232E6E0:
loc_0232E6E0:
	.word P1_RequestFreeHead	; 0232E6E0
pool_0232E6E4:
loc_0232E6E4:
	.word P1_RequestFreeTail	; 0232E6E4

.endfunc
; ===== function loc_0232E6E8 =====
loc_0232E6E8:
	push {r4,r5,lr}	; 0232E6E8
	sub sp,#0x4	; 0232E6EA
	mov r5,#0x7	; 0232E6EC
	mov r4,#0x0	; 0232E6EE
loc_0232E6F0:
	add r0,r5,#0x0	; 0232E6F0
	add r1,r4,#0x0	; 0232E6F2
	add r2,r4,#0x0	; 0232E6F4
	bl loc_0232ED90	; 0232E6F6
	cmp r0,#0x0	; 0232E6FA
	blt loc_0232E6F0	; 0232E6FC
	add sp,#0x4	; 0232E6FE
	pop {r4,r5}	; 0232E700
	pop {r3}	; 0232E702
	bx r3	; 0232E704
	.byte 0x00, 0x00	; 0232E708

; ===== function loc_0232E708 =====
loc_0232E708:
	push {r4,r5,r6,lr}	; 0232E708
	mov r0,#0x7	; 0232E70A
	ldr r1,[pool_0232E744]	; 0232E70C
	bl P1_SetPxiReceiveCallback	; 0232E70E
	bl loc_0232B61C	; 0232E712
	cmp r0,#0x0	; 0232E716
	bne loc_0232E73E	; 0232E718
	mov r0,#0x7	; 0232E71A
	mov r1,#0x1	; 0232E71C
	bl loc_0232EE24	; 0232E71E
	cmp r0,#0x0	; 0232E722
	bne loc_0232E73E	; 0232E724
	mov r5,#0x64	; 0232E726
	mov r4,#0x7	; 0232E728
	mov r6,#0x1	; 0232E72A
loc_0232E72C:
	add r0,r5,#0x0	; 0232E72C
	blx P1_Arm9BusyWaitByLoop4	; 0232E72E
	add r0,r4,#0x0	; 0232E732
	add r1,r6,#0x0	; 0232E734
	bl loc_0232EE24	; 0232E736
	cmp r0,#0x0	; 0232E73A
	beq loc_0232E72C	; 0232E73C
loc_0232E73E:
	pop {r4,r5,r6}	; 0232E73E
	pop {r3}	; 0232E740
	bx r3	; 0232E742
pool_0232E744:
loc_0232E744:
	.word P1_PxiCallback_0232E748 + 1	; 0232E744

; ===== function loc_0232E748 =====
P1_PxiCallback_0232E748:
	push {r4,r5,lr}	; 0232E748
	sub sp,#0x4	; 0232E74A
	add r5,r1,#0x0	; 0232E74C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E74E
	add r4,r0,#0x0	; 0232E752
	add r0,r5,#0x0	; 0232E754
	bl loc_0232EAEC	; 0232E756
	add r0,r4,#0x0	; 0232E75A
	blx P1_Arm9RestoreIrqMask	; 0232E75C
	add sp,#0x4	; 0232E760
	pop {r4,r5}	; 0232E762
	pop {r3}	; 0232E764
	bx r3	; 0232E766

; ===== function loc_0232E768 =====
loc_0232E768:
	push {r4,lr}	; 0232E768
	bl loc_0232E79C	; 0232E76A
	add r4,r0,#0x0	; 0232E76E
	bl loc_0232E784	; 0232E770
	ldr r1,[pool_0232E780]	; 0232E774
	sub r1,r1,r4	; 0232E776
	sub r0,r1,r0	; 0232E778
	pop {r4}	; 0232E77A
	pop {r3}	; 0232E77C
	bx r3	; 0232E77E
pool_0232E780:
loc_0232E780:
	.word 0x00000100	; 0232E780

; ===== function loc_0232E784 =====
loc_0232E784:
	ldr r0,[pool_0232E798]	; 0232E784
	ldr r1,[r0,#0x0]	; 0232E786
	mov r0,#0x0	; 0232E788
	cmp r1,#0x0	; 0232E78A
	beq loc_0232E796	; 0232E78C
loc_0232E78E:
	add r0,r0,#0x1	; 0232E78E
	ldr r1,[r1,#0x0]	; 0232E790
	cmp r1,#0x0	; 0232E792
	bne loc_0232E78E	; 0232E794
loc_0232E796:
	bx lr	; 0232E796
pool_0232E798:
loc_0232E798:
	.word P1_RequestPendingHead	; 0232E798

; ===== function loc_0232E79C =====
loc_0232E79C:
	ldr r0,[pool_0232E7B0]	; 0232E79C
	ldr r1,[r0,#0x0]	; 0232E79E
	mov r0,#0x0	; 0232E7A0
	cmp r1,#0x0	; 0232E7A2
	beq loc_0232E7AE	; 0232E7A4
loc_0232E7A6:
	add r0,r0,#0x1	; 0232E7A6
	ldr r1,[r1,#0x0]	; 0232E7A8
	cmp r1,#0x0	; 0232E7AA
	bne loc_0232E7A6	; 0232E7AC
loc_0232E7AE:
	bx lr	; 0232E7AE
pool_0232E7B0:
loc_0232E7B0:
	.word P1_RequestFreeHead	; 0232E7B0

; ===== function loc_0232E7B4 =====
loc_0232E7B4:
	ldr r1,[pool_0232E7DC]	; 0232E7B4
	ldr r1,[r1,#0x0]	; 0232E7B6
	cmp r0,r1	; 0232E7B8
	bls loc_0232E7CC	; 0232E7BA
	sub r1,r0,r1	; 0232E7BC
	ldr r0,[pool_0232E7E0]	; 0232E7BE
	cmp r1,r0	; 0232E7C0
	bcc loc_0232E7C8	; 0232E7C2
	mov r0,#0x1	; 0232E7C4
	bx lr	; 0232E7C6
loc_0232E7C8:
	mov r0,#0x0	; 0232E7C8
	bx lr	; 0232E7CA
loc_0232E7CC:
	sub r1,r1,r0	; 0232E7CC
	ldr r0,[pool_0232E7E0]	; 0232E7CE
	cmp r1,r0	; 0232E7D0
	bcs loc_0232E7D8	; 0232E7D2
	mov r0,#0x1	; 0232E7D4
	bx lr	; 0232E7D6
loc_0232E7D8:
	mov r0,#0x0	; 0232E7D8
	bx lr	; 0232E7DA
pool_0232E7DC:
loc_0232E7DC:
	.word P1_BssStart + 0x266CC	; 0232E7DC
pool_0232E7E0:
loc_0232E7E0:
	.word 0x80000000	; 0232E7E0

; ===== function loc_0232E7E4 =====
loc_0232E7E4:
	ldr r0,[pool_0232E7F8]	; 0232E7E4
	ldr r0,[r0,#0x0]	; 0232E7E6
	cmp r0,#0x0	; 0232E7E8
	bne loc_0232E7F2	; 0232E7EA
	ldr r0,[pool_0232E7FC]	; 0232E7EC
	ldr r0,[r0,#0x0]	; 0232E7EE
	bx lr	; 0232E7F0
loc_0232E7F2:
	ldr r0,[pool_0232E800]	; 0232E7F2
	ldr r0,[r0,#0x0]	; 0232E7F4
	bx lr	; 0232E7F6
pool_0232E7F8:
loc_0232E7F8:
	.word P1_RequestPendingHead	; 0232E7F8
pool_0232E7FC:
loc_0232E7FC:
	.word P1_BssStart + 0x266CC	; 0232E7FC
pool_0232E800:
loc_0232E800:
	.word P1_BssStart + 0x266E8	; 0232E800

; ===== function loc_0232E804 =====
loc_0232E804:
	push {r4,r5,lr}	; 0232E804
	sub sp,#0x4	; 0232E806
	add r4,r0,#0x0	; 0232E808
	bl loc_0232E7B4	; 0232E80A
	cmp r0,#0x0	; 0232E80E
	bne loc_0232E848	; 0232E810
	mov r5,#0x0	; 0232E812
loc_0232E814:
	add r0,r5,#0x0	; 0232E814
	bl loc_0232E9A8	; 0232E816
	cmp r0,#0x0	; 0232E81A
	bne loc_0232E814	; 0232E81C
	add r0,r4,#0x0	; 0232E81E
	bl loc_0232E7B4	; 0232E820
	cmp r0,#0x0	; 0232E824
	bne loc_0232E848	; 0232E826
	bl loc_0232E6E8	; 0232E828
	add r0,r4,#0x0	; 0232E82C
	bl loc_0232E7B4	; 0232E82E
	cmp r0,#0x0	; 0232E832
	bne loc_0232E848	; 0232E834
	mov r5,#0x1	; 0232E836
loc_0232E838:
	add r0,r5,#0x0	; 0232E838
	bl loc_0232E9A8	; 0232E83A
	add r0,r4,#0x0	; 0232E83E
	bl loc_0232E7B4	; 0232E840
	cmp r0,#0x0	; 0232E844
	beq loc_0232E838	; 0232E846
loc_0232E848:
	add sp,#0x4	; 0232E848
	pop {r4,r5}	; 0232E84A
	pop {r3}	; 0232E84C
	bx r3	; 0232E84E

; ===== function loc_0232E850 =====
loc_0232E850:
	push {r4,lr}	; 0232E850
	add r4,r0,#0x0	; 0232E852
	ldr r0,[pool_0232E8F8]	; 0232E854
	ldr r0,[r0,#0x0]	; 0232E856
	cmp r0,#0x0	; 0232E858
	bne loc_0232E864	; 0232E85A
	mov r0,#0x1	; 0232E85C
	pop {r4}	; 0232E85E
	pop {r3}	; 0232E860
	bx r3	; 0232E862
loc_0232E864:
	ldr r0,[pool_0232E8FC]	; 0232E864
	ldr r0,[r0,#0x0]	; 0232E866
	cmp r0,#0x8	; 0232E868
	blt loc_0232E886	; 0232E86A
	cmp r4,#0x0	; 0232E86C
	bne loc_0232E878	; 0232E86E
	mov r0,#0x0	; 0232E870
	pop {r4}	; 0232E872
	pop {r3}	; 0232E874
	bx r3	; 0232E876
loc_0232E878:
	mov r0,#0x1	; 0232E878
	bl loc_0232E9A8	; 0232E87A
	ldr r0,[pool_0232E8FC]	; 0232E87E
	ldr r0,[r0,#0x0]	; 0232E880
	cmp r0,#0x8	; 0232E882
	bge loc_0232E878	; 0232E884
loc_0232E886:
	ldr r0,[pool_0232E900]	; 0232E886
	ldr r1,[pool_0232E904]	; 0232E888
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E88A
	mov r0,#0x7	; 0232E88E
	ldr r1,[pool_0232E8F8]	; 0232E890
	ldr r1,[r1,#0x0]	; 0232E892
	mov r2,#0x0	; 0232E894
	bl loc_0232ED90	; 0232E896
	cmp r0,#0x0	; 0232E89A
	bge loc_0232E8BA	; 0232E89C
	cmp r4,#0x0	; 0232E89E
	bne loc_0232E8AA	; 0232E8A0
	mov r0,#0x0	; 0232E8A2
	pop {r4}	; 0232E8A4
	pop {r3}	; 0232E8A6
	bx r3	; 0232E8A8
loc_0232E8AA:
	mov r0,#0x7	; 0232E8AA
	ldr r1,[pool_0232E8F8]	; 0232E8AC
	ldr r1,[r1,#0x0]	; 0232E8AE
	mov r2,#0x0	; 0232E8B0
	bl loc_0232ED90	; 0232E8B2
	cmp r0,#0x0	; 0232E8B6
	blt loc_0232E8AA	; 0232E8B8
loc_0232E8BA:
	ldr r0,[pool_0232E8F8]	; 0232E8BA
	ldr r4,[r0,#0x0]	; 0232E8BC
	ldr r0,[pool_0232E908]	; 0232E8BE
	ldr r2,[r0,#0x0]	; 0232E8C0
	lsl r3,r2,#0x2	; 0232E8C2
	ldr r1,[pool_0232E90C]	; 0232E8C4
	str r4,[r1,r3]	; 0232E8C6
	add r1,r2,#0x1	; 0232E8C8
	str r1,[r0,#0x0]	; 0232E8CA
	cmp r1,#0x8	; 0232E8CC
	ble loc_0232E8D4	; 0232E8CE
	mov r1,#0x0	; 0232E8D0
	str r1,[r0,#0x0]	; 0232E8D2
loc_0232E8D4:
	mov r1,#0x0	; 0232E8D4
	ldr r0,[pool_0232E8F8]	; 0232E8D6
	str r1,[r0,#0x0]	; 0232E8D8
	ldr r0,[pool_0232E910]	; 0232E8DA
	str r1,[r0,#0x0]	; 0232E8DC
	ldr r0,[pool_0232E8FC]	; 0232E8DE
	ldr r1,[r0,#0x0]	; 0232E8E0
	add r1,r1,#0x1	; 0232E8E2
	str r1,[r0,#0x0]	; 0232E8E4
	ldr r0,[pool_0232E914]	; 0232E8E6
	ldr r1,[r0,#0x0]	; 0232E8E8
	add r1,r1,#0x1	; 0232E8EA
	str r1,[r0,#0x0]	; 0232E8EC
	mov r0,#0x1	; 0232E8EE
	pop {r4}	; 0232E8F0
	pop {r3}	; 0232E8F2
	bx r3	; 0232E8F4
	.byte 0xC0, 0x46	; 0232E8F8
pool_0232E8F8:
loc_0232E8F8:
	.word P1_RequestPendingHead	; 0232E8F8
pool_0232E8FC:
loc_0232E8FC:
	.word P1_BssStart + 0x266E4	; 0232E8FC
pool_0232E900:
loc_0232E900:
	.word 0x02357800	; 0232E900
pool_0232E904:
loc_0232E904:
	.word 0x00001800	; 0232E904
pool_0232E908:
loc_0232E908:
	.word P1_BssStart + 0x266E0	; 0232E908
pool_0232E90C:
loc_0232E90C:
	.word P1_BssStart + 0x266EC	; 0232E90C
pool_0232E910:
loc_0232E910:
	.word P1_RequestPendingTail	; 0232E910
pool_0232E914:
loc_0232E914:
	.word P1_BssStart + 0x266E8	; 0232E914

; ===== function loc_0232E918 =====
loc_0232E918:
	ldr r2,[pool_0232E934]	; 0232E918
	ldr r1,[r2,#0x0]	; 0232E91A
	cmp r1,#0x0	; 0232E91C
	bne loc_0232E928	; 0232E91E
	ldr r1,[pool_0232E938]	; 0232E920
	str r0,[r1,#0x0]	; 0232E922
	str r0,[r2,#0x0]	; 0232E924
; 将请求记录追加到本地待处理单链表，并清零其 next 字段。
; Append a request record to the local pending singly linked list and clear its next field.
.func P1_EnqueueRequestRecord
	b loc_0232E92C	; 0232E926
loc_0232E928:
	str r0,[r1,#0x0]	; 0232E928
	str r0,[r2,#0x0]	; 0232E92A
loc_0232E92C:
	mov r1,#0x0	; 0232E92C
	str r1,[r0,#P1_RequestRecordNextOffset]	; 0232E92E
	bx lr	; 0232E930
	.byte 0xC0, 0x46	; 0232E934
pool_0232E934:
loc_0232E934:
	.word P1_RequestPendingTail	; 0232E934
pool_0232E938:
loc_0232E938:
	.word P1_RequestPendingHead	; 0232E938
.endfunc

; ===== function loc_0232E93C =====
loc_0232E93C:
	push {r4,lr}	; 0232E93C
	add r4,r0,#0x0	; 0232E93E
	bl loc_0232B61C	; 0232E940
	cmp r0,#0x0	; 0232E944
	beq loc_0232E950	; 0232E946
	mov r0,#0x0	; 0232E948
	pop {r4}	; 0232E94A
; 从空闲链取出请求记录；调用方要求时等待可用记录。
; Take a request record from the free chain; wait for one when the caller requires it.
.func P1_AcquireRequestRecord
	pop {r3}	; 0232E94C
	bx r3	; 0232E94E
loc_0232E950:
	bl P1_PopFreeRequestRecord	; 0232E950
	cmp r0,#0x0	; 0232E954
	bne loc_0232E9A0	; 0232E956
	cmp r4,#0x0	; 0232E958
	bne loc_0232E964	; 0232E95A
	mov r0,#0x0	; 0232E95C
	pop {r4}	; 0232E95E
	pop {r3}	; 0232E960
	bx r3	; 0232E962
loc_0232E964:
	bl loc_0232E768	; 0232E964
	cmp r0,#0x0	; 0232E968
	ble loc_0232E986	; 0232E96A
	mov r4,#0x0	; 0232E96C
loc_0232E96E:
	add r0,r4,#0x0	; 0232E96E
	bl loc_0232E9A8	; 0232E970
	cmp r0,#0x0	; 0232E974
	bne loc_0232E96E	; 0232E976
	bl P1_PopFreeRequestRecord	; 0232E978
	cmp r0,#0x0	; 0232E97C
	beq loc_0232E98C	; 0232E97E
	pop {r4}	; 0232E980
	pop {r3}	; 0232E982
	bx r3	; 0232E984
loc_0232E986:
	mov r0,#0x1	; 0232E986
	bl loc_0232E850	; 0232E988
loc_0232E98C:
	bl loc_0232E6E8	; 0232E98C
	mov r4,#0x1	; 0232E990
loc_0232E992:
	add r0,r4,#0x0	; 0232E992
	bl loc_0232E9A8	; 0232E994
	bl P1_PopFreeRequestRecord	; 0232E998
	cmp r0,#0x0	; 0232E99C
	beq loc_0232E992	; 0232E99E
loc_0232E9A0:
	pop {r4}	; 0232E9A0
	pop {r3}	; 0232E9A2
	bx r3	; 0232E9A4
	.byte 0x00, 0x00	; 0232E9A8

; ===== function loc_0232E9A8 =====
loc_0232E9A8:
	push {lr}	; 0232E9A8
	sub sp,#0x4	; 0232E9AA
	cmp r0,#0x0	; 0232E9AC
.endfunc
	bne loc_0232E9C4	; 0232E9AE
	bl loc_0232EBC8	; 0232E9B0
	ldr r1,[pool_0232EA20]	; 0232E9B4
	ldr r1,[r1,#0x0]	; 0232E9B6
	cmp r1,r0	; 0232E9B8
	bne loc_0232E9D0	; 0232E9BA
	mov r0,#0x0	; 0232E9BC
	add sp,#0x4	; 0232E9BE
	pop {r3}	; 0232E9C0
	bx r3	; 0232E9C2
loc_0232E9C4:
	bl loc_0232EBC8	; 0232E9C4
	ldr r1,[pool_0232EA20]	; 0232E9C8
	ldr r1,[r1,#0x0]	; 0232E9CA
	cmp r1,r0	; 0232E9CC
	beq loc_0232E9C4	; 0232E9CE
loc_0232E9D0:
	ldr r1,[pool_0232EA24]	; 0232E9D0
	ldr r2,[r1,#0x0]	; 0232E9D2
	lsl r3,r2,#0x2	; 0232E9D4
	ldr r0,[pool_0232EA28]	; 0232E9D6
	ldr r0,[r0,r3]	; 0232E9D8
	add r2,r2,#0x1	; 0232E9DA
	str r2,[r1,#0x0]	; 0232E9DC
	cmp r2,#0x8	; 0232E9DE
	ble loc_0232E9E6	; 0232E9E0
	mov r2,#0x0	; 0232E9E2
	str r2,[r1,#0x0]	; 0232E9E4
loc_0232E9E6:
	add r2,r0,#0x0	; 0232E9E6
	ldr r1,[r0,#0x0]	; 0232E9E8
	cmp r1,#0x0	; 0232E9EA
	beq loc_0232E9F6	; 0232E9EC
loc_0232E9EE:
	ldr r2,[r2,#0x0]	; 0232E9EE
	ldr r1,[r2,#0x0]	; 0232E9F0
	cmp r1,#0x0	; 0232E9F2
	bne loc_0232E9EE	; 0232E9F4
loc_0232E9F6:
	ldr r1,[pool_0232EA2C]	; 0232E9F6
	ldr r1,[r1,#0x0]	; 0232E9F8
	cmp r1,#0x0	; 0232E9FA
	beq loc_0232EA02	; 0232E9FC
	str r0,[r1,#0x0]	; 0232E9FE
	b loc_0232EA06	; 0232EA00
loc_0232EA02:
	ldr r1,[pool_0232EA30]	; 0232EA02
	str r0,[r1,#0x0]	; 0232EA04
loc_0232EA06:
	ldr r1,[pool_0232EA2C]	; 0232EA06
	str r2,[r1,#0x0]	; 0232EA08
	ldr r1,[pool_0232EA34]	; 0232EA0A
	ldr r2,[r1,#0x0]	; 0232EA0C
	sub r2,r2,#0x1	; 0232EA0E
	str r2,[r1,#0x0]	; 0232EA10
	ldr r1,[pool_0232EA20]	; 0232EA12
	ldr r2,[r1,#0x0]	; 0232EA14
	add r2,r2,#0x1	; 0232EA16
	str r2,[r1,#0x0]	; 0232EA18
	add sp,#0x4	; 0232EA1A
	pop {r3}	; 0232EA1C
	bx r3	; 0232EA1E
pool_0232EA20:
loc_0232EA20:
	.word P1_BssStart + 0x266CC	; 0232EA20
pool_0232EA24:
loc_0232EA24:
	.word P1_BssStart + 0x266DC	; 0232EA24
pool_0232EA28:
loc_0232EA28:
	.word P1_BssStart + 0x266EC	; 0232EA28
pool_0232EA2C:
loc_0232EA2C:
	.word P1_RequestFreeTail	; 0232EA2C
pool_0232EA30:
loc_0232EA30:
	.word P1_RequestFreeHead	; 0232EA30
pool_0232EA34:
loc_0232EA34:
	.word P1_BssStart + 0x266E4	; 0232EA34

; ===== function loc_0232EA38 =====
loc_0232EA38:
	push {r4,lr}	; 0232EA38
	bl loc_0232E708	; 0232EA3A
	ldr r3,[pool_0232EAB4]	; 0232EA3E
	ldr r0,[pool_0232EAB8]	; 0232EA40
	str r3,[r0,#0x0]	; 0232EA42
	mov r4,#0x0	; 0232EA44
	add r2,r3,#0x0	; 0232EA46
	mov r0,#0x18	; 0232EA48
loc_0232EA4A:
	add r4,r4,#0x1	; 0232EA4A
	add r1,r4,#0x0	; 0232EA4C
	mul r1,r0	; 0232EA4E
	add r1,r2,r1	; 0232EA50
	str r1,[r3,#0x0]	; 0232EA52
	add r3,#0x18	; 0232EA54
	cmp r4,#0xff	; 0232EA56
	blt loc_0232EA4A	; 0232EA58
	mov r0,#0x0	; 0232EA5A
	ldr r1,[pool_0232EABC]	; 0232EA5C
	str r0,[r1,#0x68]	; 0232EA5E
	ldr r2,[pool_0232EAC0]	; 0232EA60
	ldr r1,[pool_0232EAC4]	; 0232EA62
	str r2,[r1,#0x0]	; 0232EA64
	ldr r1,[pool_0232EAC8]	; 0232EA66
	str r0,[r1,#0x0]	; 0232EA68
	ldr r1,[pool_0232EACC]	; 0232EA6A
	str r0,[r1,#0x0]	; 0232EA6C
	ldr r1,[pool_0232EAD0]	; 0232EA6E
	str r0,[r1,#0x0]	; 0232EA70
	ldr r1,[pool_0232EAD4]	; 0232EA72
	str r0,[r1,#0x0]	; 0232EA74
	ldr r1,[pool_0232EAD8]	; 0232EA76
	str r0,[r1,#0x0]	; 0232EA78
	mov r2,#0x1	; 0232EA7A
	ldr r1,[pool_0232EADC]	; 0232EA7C
	str r2,[r1,#0x0]	; 0232EA7E
	ldr r1,[pool_0232EAE0]	; 0232EA80
	str r0,[r1,#0x0]	; 0232EA82
	ldr r0,[pool_0232EAE4]	; 0232EA84
	ldr r1,[pool_0232EAE8]	; 0232EA86
	str r0,[r1,#0x0]	; 0232EA88
	bl loc_0232EB78	; 0232EA8A
	mov r0,#0x1	; 0232EA8E
	bl P1_AcquireRequestRecord	; 0232EA90
	cmp r0,#0x0	; 0232EA94
	beq loc_0232EAAC	; 0232EA96
	mov r1,#0x19	; 0232EA98
	str r1,[r0,#0x4]	; 0232EA9A
	ldr r1,[pool_0232EAE8]	; 0232EA9C
	ldr r1,[r1,#0x0]	; 0232EA9E
	str r1,[r0,#0x8]	; 0232EAA0
	bl P1_EnqueueRequestRecord	; 0232EAA2
	mov r0,#0x1	; 0232EAA6
	bl loc_0232E850	; 0232EAA8
loc_0232EAAC:
	pop {r4}	; 0232EAAC
	pop {r3}	; 0232EAAE
	bx r3	; 0232EAB0
	.byte 0xC0, 0x46	; 0232EAB4
pool_0232EAB4:
loc_0232EAB4:
	.word P1_BssStart + 0x269A0	; 0232EAB4
pool_0232EAB8:
loc_0232EAB8:
	.word P1_RequestFreeHead	; 0232EAB8
pool_0232EABC:
loc_0232EABC:
	.word P1_BssStart + 0x28120	; 0232EABC
pool_0232EAC0:
loc_0232EAC0:
	.word 0x02358FE8	; 0232EAC0
pool_0232EAC4:
loc_0232EAC4:
	.word P1_RequestFreeTail	; 0232EAC4
pool_0232EAC8:
loc_0232EAC8:
	.word P1_RequestPendingHead	; 0232EAC8
pool_0232EACC:
loc_0232EACC:
	.word P1_RequestPendingTail	; 0232EACC
pool_0232EAD0:
loc_0232EAD0:
	.word P1_BssStart + 0x266E4	; 0232EAD0
pool_0232EAD4:
loc_0232EAD4:
	.word P1_BssStart + 0x266DC	; 0232EAD4
pool_0232EAD8:
loc_0232EAD8:
	.word P1_BssStart + 0x266E0	; 0232EAD8
pool_0232EADC:
loc_0232EADC:
	.word P1_BssStart + 0x266E8	; 0232EADC
pool_0232EAE0:
loc_0232EAE0:
	.word P1_BssStart + 0x266CC	; 0232EAE0
pool_0232EAE4:
loc_0232EAE4:
	.word 0x02357580	; 0232EAE4
pool_0232EAE8:
loc_0232EAE8:
	.word P1_BssStart + 0x28200	; 0232EAE8

; ===== function loc_0232EAEC =====
loc_0232EAEC:
	push {r4,lr}	; 0232EAEC
	ldr r4,[pool_0232EB18]	; 0232EAEE
	mov r2,#0xff	; 0232EAF0
	add r3,r0,#0x0	; 0232EAF2
	and r3,r2	; 0232EAF4
	mov r1,#0xc	; 0232EAF6
	mul r3,r1	; 0232EAF8
	add r3,r4,r3	; 0232EAFA
	asr r1,r0,#0x8	; 0232EAFC
	and r1,r2	; 0232EAFE
	ldrb r0,[r3,#0x8]	; 0232EB00
	cmp r1,r0	; 0232EB02
	bne loc_0232EB10	; 0232EB04
	ldr r1,[r3,#0x0]	; 0232EB06
	cmp r1,#0x0	; 0232EB08
	beq loc_0232EB10	; 0232EB0A
	ldr r0,[r3,#0x4]	; 0232EB0C
	blx r1	; 0232EB0E
loc_0232EB10:
	pop {r4}	; 0232EB10
	pop {r3}	; 0232EB12
	bx r3	; 0232EB14
	.byte 0xC0, 0x46	; 0232EB18
pool_0232EB18:
loc_0232EB18:
	.word 0x02359000	; 0232EB18

; ===== function loc_0232EB1C =====
loc_0232EB1C:
	push {r4}	; 0232EB1C
	sub sp,#0x4	; 0232EB1E
	ldr r4,[pool_0232EB40]	; 0232EB20
	mov r3,#0xc	; 0232EB22
	mul r0,r3	; 0232EB24
	add r3,r4,r0	; 0232EB26
	str r1,[r4,r0]	; 0232EB28
	str r2,[r3,#0x4]	; 0232EB2A
	add r1,r3,#0x0	; 0232EB2C
	add r1,#0x8	; 0232EB2E
	ldrb r0,[r1,#0x0]	; 0232EB30
	add r0,r0,#0x1	; 0232EB32
	strb r0,[r1,#0x0]	; 0232EB34
	ldrb r0,[r3,#0x8]	; 0232EB36
	add sp,#0x4	; 0232EB38
	pop {r4}	; 0232EB3A
	bx lr	; 0232EB3C
	.byte 0xC0, 0x46	; 0232EB40
pool_0232EB40:
loc_0232EB40:
	.word P1_BssStart + 0x281A0	; 0232EB40

; ===== function loc_0232EB44 =====
loc_0232EB44:
	ldr r2,[pool_0232EB58]	; 0232EB44
	mov r1,#0xc	; 0232EB46
	mul r0,r1	; 0232EB48
	add r1,r2,r0	; 0232EB4A
	add r1,#0x8	; 0232EB4C
	ldrb r0,[r1,#0x0]	; 0232EB4E
	add r0,r0,#0x1	; 0232EB50
	strb r0,[r1,#0x0]	; 0232EB52
	bx lr	; 0232EB54
	.byte 0xC0, 0x46	; 0232EB58
pool_0232EB58:
loc_0232EB58:
	.word 0x02359000	; 0232EB58

; ===== function loc_0232EB5C =====
loc_0232EB5C:
	mov r2,#0x0	; 0232EB5C
	ldr r1,[pool_0232EB74]	; 0232EB5E
	add r0,r2,#0x0	; 0232EB60
loc_0232EB62:
	str r0,[r1,#0x0]	; 0232EB62
	str r0,[r1,#0x4]	; 0232EB64
	strb r0,[r1,#0x8]	; 0232EB66
	add r1,#0xc	; 0232EB68
	add r2,r2,#0x1	; 0232EB6A
	cmp r2,#0x8	; 0232EB6C
	blt loc_0232EB62	; 0232EB6E
	bx lr	; 0232EB70
	.byte 0xC0, 0x46	; 0232EB74
pool_0232EB74:
loc_0232EB74:
	.word P1_BssStart + 0x281A0	; 0232EB74

; ===== function loc_0232EB78 =====
loc_0232EB78:
	push {r4,r5,r6,lr}	; 0232EB78
	mov r6,#0x0	; 0232EB7A
	str r6,[r0,#0x4]	; 0232EB7C
	strh r6,[r0,#0x8]	; 0232EB7E
	strh r6,[r0,#0xa]	; 0232EB80
	str r6,[r0,#0x0]	; 0232EB82
	add r4,r0,#0x0	; 0232EB84
	mvn r1,r6	; 0232EB86
	add r2,r6,#0x0	; 0232EB88
loc_0232EB8A:
	str r2,[r4,#0x40]	; 0232EB8A
	add r5,r2,#0x0	; 0232EB8C
	add r3,r4,#0x0	; 0232EB8E
loc_0232EB90:
	strh r1,[r3,#0x20]	; 0232EB90
	add r3,r3,#0x2	; 0232EB92
	add r5,r5,#0x1	; 0232EB94
	cmp r5,#0x10	; 0232EB96
	blt loc_0232EB90	; 0232EB98
	add r4,#0x24	; 0232EB9A
	add r6,r6,#0x1	; 0232EB9C
	cmp r6,#0x10	; 0232EB9E
	blt loc_0232EB8A	; 0232EBA0
	mov r3,#0x0	; 0232EBA2
	add r4,r0,#0x0	; 0232EBA4
	mvn r2,r3	; 0232EBA6
	ldr r1,[pool_0232EBC0]	; 0232EBA8
loc_0232EBAA:
	strh r2,[r4,r1]	; 0232EBAA
	add r4,r4,#0x2	; 0232EBAC
	add r3,r3,#0x1	; 0232EBAE
	cmp r3,#0x10	; 0232EBB0
	blt loc_0232EBAA	; 0232EBB2
	ldr r1,[pool_0232EBC4]	; 0232EBB4
	blx P1_CleanAndInvalidateDataCacheRange	; 0232EBB6
	pop {r4,r5,r6}	; 0232EBBA
	pop {r3}	; 0232EBBC
	bx r3	; 0232EBBE
pool_0232EBC0:
loc_0232EBC0:
	.word 0x00000260	; 0232EBC0
pool_0232EBC4:
loc_0232EBC4:
	.word 0x00000280	; 0232EBC4

; ===== function loc_0232EBC8 =====
loc_0232EBC8:
	push {lr}	; 0232EBC8
	sub sp,#0x4	; 0232EBCA
	ldr r0,[pool_0232EBE4]	; 0232EBCC
	ldr r0,[r0,#0x0]	; 0232EBCE
	ldr r1,[pool_0232EBE8]	; 0232EBD0
	blx P1_InvalidateDataCacheRange	; 0232EBD2
	ldr r0,[pool_0232EBE4]	; 0232EBD6
	ldr r0,[r0,#0x0]	; 0232EBD8
	ldr r0,[r0,#0x0]	; 0232EBDA
	add sp,#0x4	; 0232EBDC
	pop {r3}	; 0232EBDE
	bx r3	; 0232EBE0
	.byte 0xC0, 0x46	; 0232EBE4
pool_0232EBE4:
loc_0232EBE4:
	.word P1_BssStart + 0x28200	; 0232EBE4
pool_0232EBE8:
loc_0232EBE8:
	.word 0x00000280	; 0232EBE8

; ===== function loc_0232EBEC =====
	push {lr}	; 0232EBEC
	sub sp,#0x4	; 0232EBEE
	ldr r0,[pool_0232EC08]	; 0232EBF0
	ldr r0,[r0,#0x0]	; 0232EBF2
	ldr r1,[pool_0232EC0C]	; 0232EBF4
	blx P1_InvalidateDataCacheRange	; 0232EBF6
	ldr r0,[pool_0232EC08]	; 0232EBFA
	ldr r0,[r0,#0x0]	; 0232EBFC
	ldrh r0,[r0,#0x8]	; 0232EBFE
	add sp,#0x4	; 0232EC00
	pop {r3}	; 0232EC02
	bx r3	; 0232EC04
	.byte 0xC0, 0x46	; 0232EC08
pool_0232EC08:
loc_0232EC08:
	.word P1_BssStart + 0x28200	; 0232EC08
pool_0232EC0C:
loc_0232EC0C:
	.word 0x00000280	; 0232EC0C

; ===== function loc_0232EC10 =====
loc_0232EC10:
	push {lr}	; 0232EC10
	sub sp,#0x4	; 0232EC12
	ldr r0,[pool_0232EC2C]	; 0232EC14
	ldr r0,[r0,#0x0]	; 0232EC16
	ldr r1,[pool_0232EC30]	; 0232EC18
	blx P1_InvalidateDataCacheRange	; 0232EC1A
	ldr r0,[pool_0232EC2C]	; 0232EC1E
	ldr r0,[r0,#0x0]	; 0232EC20
	ldr r0,[r0,#0x4]	; 0232EC22
	add sp,#0x4	; 0232EC24
	pop {r3}	; 0232EC26
	bx r3	; 0232EC28
	.byte 0xC0, 0x46	; 0232EC2C
pool_0232EC2C:
loc_0232EC2C:
	.word P1_BssStart + 0x28200	; 0232EC2C
pool_0232EC30:
loc_0232EC30:
	.word 0x00000280	; 0232EC30

; ===== function loc_0232EC34 =====
loc_0232EC34:
	push {r4,r5,r6,r7,lr}	; 0232EC34
	sub sp,#0x4	; 0232EC36
	add r5,r0,#0x0	; 0232EC38
	add r7,r1,#0x0	; 0232EC3A
	add r4,r2,#0x0	; 0232EC3C
	lsl r2,r7,#0x3	; 0232EC3E
	add r1,r5,r2	; 0232EC40
	ldr r0,[r1,#0x18]	; 0232EC42
	cmp r0,#0x0	; 0232EC44
	beq loc_0232EC84	; 0232EC46
	cmp r4,r0	; 0232EC48
	beq loc_0232ECA6	; 0232EC4A
	ldr r6,[r0,#0x18]	; 0232EC4C
	add r3,r5,#0x0	; 0232EC4E
	add r3,#0x18	; 0232EC50
	add r3,r3,r2	; 0232EC52
	cmp r3,r6	; 0232EC54
	bne loc_0232EC66	; 0232EC56
	ldr r2,[r1,#0x1c]	; 0232EC58
	str r2,[r0,#0x18]	; 0232EC5A
	ldr r0,[r1,#0x18]	; 0232EC5C
	mov r1,#0x3c	; 0232EC5E
	blx P1_CleanDataCacheRange	; 0232EC60
	b loc_0232EC84	; 0232EC64
loc_0232EC66:
	cmp r6,#0x0	; 0232EC66
	beq loc_0232EC76	; 0232EC68
loc_0232EC6A:
	ldr r0,[r6,#0x4]	; 0232EC6A
	cmp r3,r0	; 0232EC6C
	beq loc_0232EC76	; 0232EC6E
	add r6,r0,#0x0	; 0232EC70
	cmp r0,#0x0	; 0232EC72
	bne loc_0232EC6A	; 0232EC74
loc_0232EC76:
	add r0,r5,r2	; 0232EC76
	ldr r0,[r0,#0x1c]	; 0232EC78
	str r0,[r6,#0x4]	; 0232EC7A
	add r0,r6,#0x0	; 0232EC7C
	mov r1,#0x8	; 0232EC7E
	blx P1_CleanDataCacheRange	; 0232EC80
loc_0232EC84:
	ldr r0,[r4,#0x18]	; 0232EC84
	lsl r3,r7,#0x3	; 0232EC86
	add r2,r5,#0x0	; 0232EC88
	add r2,#0x18	; 0232EC8A
	add r1,r2,r3	; 0232EC8C
	str r1,[r4,#0x18]	; 0232EC8E
	add r1,r5,r3	; 0232EC90
	str r0,[r1,#0x1c]	; 0232EC92
	str r4,[r2,r3]	; 0232EC94
	add r0,r5,#0x0	; 0232EC96
	mov r1,#0x3c	; 0232EC98
	blx P1_CleanDataCacheRange	; 0232EC9A
	add r0,r4,#0x0	; 0232EC9E
	mov r1,#0x3c	; 0232ECA0
	blx P1_CleanDataCacheRange	; 0232ECA2
loc_0232ECA6:
	add sp,#0x4	; 0232ECA6
	pop {r4,r5,r6,r7}	; 0232ECA8
	pop {r3}	; 0232ECAA
	bx r3	; 0232ECAC
	.byte 0x00, 0x00	; 0232ECB0

; ===== function loc_0232ECB0 =====
loc_0232ECB0:
	ldr r3,[pool_0232ECB4]	; 0232ECB0
	bx r3	; 0232ECB2
pool_0232ECB4:
loc_0232ECB4:
	.word loc_0232EEA0 + 1	; 0232ECB4

; ===== function loc_0232ECB8 =====
P1_IrqHandler_0232ECB8:
	push {r4,r5,r6,r7,lr}	; 0232ECB8
	sub sp,#0x4	; 0232ECBA
	ldr r5,[pool_0232ED74]	; 0232ECBC
	mov r0,#0x3	; 0232ECBE
	mvn r6,r0	; 0232ECC0
	mov r7,#0x2	; 0232ECC2
	mvn r4,r7	; 0232ECC4
loc_0232ECC6:
	ldrh r1,[r5,#0x0]	; 0232ECC6
	ldr r0,[pool_0232ED78]	; 0232ECC8
	and r1,r0	; 0232ECCA
	cmp r1,#0x0	; 0232ECCC
	beq loc_0232ECDC	; 0232ECCE
	ldrh r1,[r5,#0x0]	; 0232ECD0
	ldr r0,[pool_0232ED7C]	; 0232ECD2
	orr r1,r0	; 0232ECD4
	strh r1,[r5,#0x0]	; 0232ECD6
	add r0,r4,#0x0	; 0232ECD8
	b loc_0232ECFE	; 0232ECDA
loc_0232ECDC:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232ECDC
	ldrh r2,[r5,#0x0]	; 0232ECE0
	ldr r1,[pool_0232ED80]	; 0232ECE2
	and r2,r1	; 0232ECE4
	cmp r2,#0x0	; 0232ECE6
	beq loc_0232ECF2	; 0232ECE8
	blx P1_Arm9RestoreIrqMask	; 0232ECEA
	add r0,r6,#0x0	; 0232ECEE
	b loc_0232ECFE	; 0232ECF0
loc_0232ECF2:
	ldr r1,[pool_0232ED84]	; 0232ECF2
	ldr r1,[r1,#0x0]	; 0232ECF4
	str r1,[sp,#0x0]	; 0232ECF6
	blx P1_Arm9RestoreIrqMask	; 0232ECF8
	mov r0,#0x0	; 0232ECFC
loc_0232ECFE:
	mov r1,#0x3	; 0232ECFE
	mvn r1,r1	; 0232ED00
	cmp r0,r1	; 0232ED02
	beq loc_0232ED6A	; 0232ED04
	mvn r1,r7	; 0232ED06
	cmp r0,r1	; 0232ED08
	beq loc_0232ECC6	; 0232ED0A
	ldr r2,[sp,#0x0]	; 0232ED0C
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 0232ED0E
	lsr r0,r0,#0x1b	; 0232ED10
	cmp r0,#0x0	; 0232ED12
	beq loc_0232ECC6	; 0232ED14
	lsl r3,r0,#0x2	; 0232ED16
	ldr r1,[pool_0232ED88]	; 0232ED18
	ldr r3,[r1,r3]	; 0232ED1A
	cmp r3,#0x0	; 0232ED1C
	beq loc_0232ED2A	; 0232ED1E
	lsr r1,r2,#0x6	; 0232ED20
	lsl r2,r2,#0x1a	; 0232ED22
	lsr r2,r2,#0x1f	; 0232ED24
	blx r3	; 0232ED26
	b loc_0232ECC6	; 0232ED28
loc_0232ED2A:
	lsl r0,r2,#0x1a	; 0232ED2A
	lsr r0,r0,#0x1f	; 0232ED2C
	cmp r0,#0x0	; 0232ED2E
	bne loc_0232ECC6	; 0232ED30
	mov r0,#0x20	; 0232ED32
	orr r2,r0	; 0232ED34
	str r2,[sp,#0x0]	; 0232ED36
	ldrh r1,[r5,#0x0]	; 0232ED38
	ldr r0,[pool_0232ED78]	; 0232ED3A
	and r1,r0	; 0232ED3C
	cmp r1,#0x0	; 0232ED3E
	beq loc_0232ED4C	; 0232ED40
	ldrh r1,[r5,#0x0]	; 0232ED42
	ldr r0,[pool_0232ED7C]	; 0232ED44
	orr r1,r0	; 0232ED46
	strh r1,[r5,#0x0]	; 0232ED48
	b loc_0232ECC6	; 0232ED4A
loc_0232ED4C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232ED4C
	ldrh r1,[r5,#0x0]	; 0232ED50
	and r1,r7	; 0232ED52
	cmp r1,#0x0	; 0232ED54
	beq loc_0232ED5E	; 0232ED56
	blx P1_Arm9RestoreIrqMask	; 0232ED58
	b loc_0232ECC6	; 0232ED5C
loc_0232ED5E:
	ldr r2,[sp,#0x0]	; 0232ED5E
	ldr r1,[pool_0232ED8C]	; 0232ED60
	str r2,[r1,#0x0]	; 0232ED62
	blx P1_Arm9RestoreIrqMask	; 0232ED64
	b loc_0232ECC6	; 0232ED68
loc_0232ED6A:
	add sp,#0x4	; 0232ED6A
	pop {r4,r5,r6,r7}	; 0232ED6C
	pop {r3}	; 0232ED6E
	bx r3	; 0232ED70
	.byte 0xC0, 0x46	; 0232ED74
pool_0232ED74:
loc_0232ED74:
	.word REG_IPC_FIFO_CR	; 0232ED74
pool_0232ED78:
loc_0232ED78:
	.word 0x00004000	; 0232ED78
pool_0232ED7C:
loc_0232ED7C:
	.word 0x0000C000	; 0232ED7C
pool_0232ED80:
loc_0232ED80:
	.word 0x00000100	; 0232ED80
pool_0232ED84:
loc_0232ED84:
	.word REG_IPC_FIFO_RX	; 0232ED84
pool_0232ED88:
loc_0232ED88:
	.word P1_PxiReceiveCallbacks	; 0232ED88
pool_0232ED8C:
loc_0232ED8C:
	.word REG_IPC_FIFO_TX	; 0232ED8C

; ===== function loc_0232ED90 =====
loc_0232ED90:
	push {r4,lr}	; 0232ED90
	sub sp,#0x8	; 0232ED92
	ldr r3,[sp,#0x0]	; 0232ED94
	mov r4,#0x1f	; 0232ED96
	bic r3,r4	; 0232ED98
	and r0,r4	; 0232ED9A
	orr r3,r0	; 0232ED9C
	str r3,[sp,#0x0]	; 0232ED9E
	mov r0,#0x20	; 0232EDA0
	bic r3,r0	; 0232EDA2
	mov r0,#0x1	; 0232EDA4
	and r2,r0	; 0232EDA6
	lsl r0,r2,#0x5	; 0232EDA8
	orr r3,r0	; 0232EDAA
	str r3,[sp,#0x0]	; 0232EDAC
	mov r0,#0x3f	; 0232EDAE
	and r3,r0	; 0232EDB0
	ldr r0,[pool_0232EE10]	; 0232EDB2
	and r1,r0	; 0232EDB4
	lsl r0,r1,#0x6	; 0232EDB6
	orr r3,r0	; 0232EDB8
	str r3,[sp,#0x0]	; 0232EDBA
	ldr r2,[pool_0232EE14]	; 0232EDBC
	ldrh r1,[r2,#0x0]	; 0232EDBE
	ldr r0,[pool_0232EE18]	; 0232EDC0
	and r1,r0	; 0232EDC2
	cmp r1,#0x0	; 0232EDC4
	beq loc_0232EDDC	; 0232EDC6
	ldrh r1,[r2,#0x0]	; 0232EDC8
	ldr r0,[pool_0232EE1C]	; 0232EDCA
	orr r1,r0	; 0232EDCC
	strh r1,[r2,#0x0]	; 0232EDCE
	mov r0,#0x0	; 0232EDD0
	mvn r0,r0	; 0232EDD2
	add sp,#0x8	; 0232EDD4
	pop {r4}	; 0232EDD6
	pop {r3}	; 0232EDD8
	bx r3	; 0232EDDA
loc_0232EDDC:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EDDC
	ldr r1,[pool_0232EE14]	; 0232EDE0
	ldrh r2,[r1,#0x0]	; 0232EDE2
	mov r1,#0x2	; 0232EDE4
	and r2,r1	; 0232EDE6
	cmp r2,#0x0	; 0232EDE8
	beq loc_0232EDFC	; 0232EDEA
	blx P1_Arm9RestoreIrqMask	; 0232EDEC
	mov r0,#0x1	; 0232EDF0
	mvn r0,r0	; 0232EDF2
	add sp,#0x8	; 0232EDF4
	pop {r4}	; 0232EDF6
	pop {r3}	; 0232EDF8
	bx r3	; 0232EDFA
loc_0232EDFC:
	ldr r2,[sp,#0x0]	; 0232EDFC
	ldr r1,[pool_0232EE20]	; 0232EDFE
	str r2,[r1,#0x0]	; 0232EE00
	blx P1_Arm9RestoreIrqMask	; 0232EE02
	mov r0,#0x0	; 0232EE06
	add sp,#0x8	; 0232EE08
	pop {r4}	; 0232EE0A
	pop {r3}	; 0232EE0C
	bx r3	; 0232EE0E
pool_0232EE10:
loc_0232EE10:
	.word 0x03FFFFFF	; 0232EE10
pool_0232EE14:
loc_0232EE14:
	.word REG_IPC_FIFO_CR	; 0232EE14
pool_0232EE18:
loc_0232EE18:
	.word 0x00004000	; 0232EE18
pool_0232EE1C:
loc_0232EE1C:
	.word 0x0000C000	; 0232EE1C
pool_0232EE20:
loc_0232EE20:
	.word REG_IPC_FIFO_TX	; 0232EE20

; ===== function loc_0232EE24 =====
loc_0232EE24:
	push {r4}	; 0232EE24
	sub sp,#0x4	; 0232EE26
	mov r3,#0x1	; 0232EE28
	add r2,r3,#0x0	; 0232EE2A
	lsl r2,r0	; 0232EE2C
	ldr r4,[pool_0232EE48]	; 0232EE2E
	lsl r0,r1,#0x2	; 0232EE30
	add r1,r4,r0	; 0232EE32
	ldr r0,[pool_0232EE4C]	; 0232EE34
	ldr r0,[r1,r0]	; 0232EE36
	and r2,r0	; 0232EE38
	cmp r2,#0x0	; 0232EE3A
	bne loc_0232EE40	; 0232EE3C
	mov r3,#0x0	; 0232EE3E
loc_0232EE40:
	add r0,r3,#0x0	; 0232EE40
	add sp,#0x4	; 0232EE42
	pop {r4}	; 0232EE44
	bx lr	; 0232EE46
pool_0232EE48:
loc_0232EE48:
	.word 0x027FFC00	; 0232EE48
pool_0232EE4C:
loc_0232EE4C:
	.word 0x00000388	; 0232EE4C

; ===== function loc_0232EE50 =====
loc_0232EE50:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P1_SetPxiReceiveCallback
	push {r4,r5,lr}	; 0232EE50
	sub sp,#0x4	; 0232EE52
	add r5,r0,#0x0	; 0232EE54
	add r4,r1,#0x0	; 0232EE56
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EE58
	lsl r2,r5,#0x2	; 0232EE5C
	ldr r1,[pool_0232EE94]	; 0232EE5E
	str r4,[r1,r2]	; 0232EE60
	cmp r4,#0x0	; 0232EE62
	beq loc_0232EE78	; 0232EE64
	ldr r2,[pool_0232EE98]	; 0232EE66
	ldr r1,[pool_0232EE9C]	; 0232EE68
	add r3,r2,r1	; 0232EE6A
	ldr r2,[r3,#0x0]	; 0232EE6C
	mov r1,#0x1	; 0232EE6E
	lsl r1,r5	; 0232EE70
	orr r2,r1	; 0232EE72
	str r2,[r3,#0x0]	; 0232EE74
	b loc_0232EE88	; 0232EE76
loc_0232EE78:
	ldr r2,[pool_0232EE98]	; 0232EE78
	ldr r1,[pool_0232EE9C]	; 0232EE7A
	add r3,r2,r1	; 0232EE7C
	ldr r2,[r3,#0x0]	; 0232EE7E
	mov r1,#0x1	; 0232EE80
	lsl r1,r5	; 0232EE82
	bic r2,r1	; 0232EE84
	str r2,[r3,#0x0]	; 0232EE86
loc_0232EE88:
	blx P1_Arm9RestoreIrqMask	; 0232EE88
	add sp,#0x4	; 0232EE8C
	pop {r4,r5}	; 0232EE8E
	pop {r3}	; 0232EE90
	bx r3	; 0232EE92
.endfunc
pool_0232EE94:
loc_0232EE94:
	.word P1_PxiReceiveCallbacks	; 0232EE94
pool_0232EE98:
loc_0232EE98:
	.word FirmwareSystemWorkAddress	; 0232EE98
pool_0232EE9C:
loc_0232EE9C:
	.word SystemWorkPxiArm9AvailableOffset	; 0232EE9C

; ===== function loc_0232EEA0 =====
loc_0232EEA0:
	push {r4,r5,r6,r7,lr}	; 0232EEA0
	sub sp,#0x4	; 0232EEA2
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EEA4
	str r0,[sp,#0x0]	; 0232EEA8
	ldr r0,[pool_0232EF28]	; 0232EEAA
	ldrh r1,[r0,#0x0]	; 0232EEAC
	cmp r1,#0x0	; 0232EEAE
	bne loc_0232EF18	; 0232EEB0
	mov r1,#0x1	; 0232EEB2
	strh r1,[r0,#0x0]	; 0232EEB4
	mov r2,#0x0	; 0232EEB6
	ldr r1,[pool_0232EF2C]	; 0232EEB8
	ldr r0,[pool_0232EF30]	; 0232EEBA
	str r2,[r1,r0]	; 0232EEBC
	ldr r1,[pool_0232EF34]	; 0232EEBE
	add r0,r2,#0x0	; 0232EEC0
loc_0232EEC2:
	stmia r1!,{r0}	; 0232EEC2
	add r2,r2,#0x1	; 0232EEC4
	cmp r2,#PxiFifoChannelCount	; 0232EEC6
	blt loc_0232EEC2	; 0232EEC8
	ldr r0,[pool_0232EF38]	; 0232EECA
	ldr r1,[pool_0232EF3C]	; 0232EECC
	bl loc_0232ADC8	; 0232EECE
	ldr r0,[pool_0232EF38]	; 0232EED2
	bl loc_0232AD44	; 0232EED4
	ldr r1,[pool_0232EF40]	; 0232EED8
	ldr r0,[pool_0232EF44]	; 0232EEDA
	strh r1,[r0,#0x0]	; 0232EEDC
	mov r1,#0x0	; 0232EEDE
	ldr r0,[pool_0232EF48]	; 0232EEE0
	add r6,r1,#0x0	; 0232EEE2
	ldr r7,[pool_0232EF4C]	; 0232EEE4
	mov r4,#0xf	; 0232EEE6
loc_0232EEE8:
	ldrh r2,[r0,#0x0]	; 0232EEE8
	and r2,r4	; 0232EEEA
	lsl r3,r2,#0x8	; 0232EEEC
	strh r3,[r0,#0x0]	; 0232EEEE
	cmp r2,#0x0	; 0232EEF0
	bne loc_0232EEF8	; 0232EEF2
	cmp r1,#0x4	; 0232EEF4
	bgt loc_0232EF18	; 0232EEF6
loc_0232EEF8:
	add r3,r7,#0x0	; 0232EEF8
	ldrh r5,[r0,#0x0]	; 0232EEFA
	and r5,r4	; 0232EEFC
	cmp r5,r2	; 0232EEFE
	bne loc_0232EF14	; 0232EF00
loc_0232EF02:
	cmp r3,#0x0	; 0232EF02
	bgt loc_0232EF0A	; 0232EF04
	add r1,r6,#0x0	; 0232EF06
	b loc_0232EF14	; 0232EF08
loc_0232EF0A:
	sub r3,r3,#0x1	; 0232EF0A
	ldrh r5,[r0,#0x0]	; 0232EF0C
	and r5,r4	; 0232EF0E
	cmp r5,r2	; 0232EF10
	beq loc_0232EF02	; 0232EF12
loc_0232EF14:
	add r1,r1,#0x1	; 0232EF14
	b loc_0232EEE8	; 0232EF16
loc_0232EF18:
	ldr r0,[sp,#0x0]	; 0232EF18
	blx P1_Arm9RestoreIrqMask	; 0232EF1A
	add sp,#0x4	; 0232EF1E
	pop {r4,r5,r6,r7}	; 0232EF20
	pop {r3}	; 0232EF22
	bx r3	; 0232EF24
	.byte 0xC0, 0x46	; 0232EF28
pool_0232EF28:
loc_0232EF28:
	.word P1_BssStart + 0x28204	; 0232EF28
pool_0232EF2C:
loc_0232EF2C:
	.word FirmwareSystemWorkAddress	; 0232EF2C
pool_0232EF30:
loc_0232EF30:
	.word SystemWorkPxiArm9AvailableOffset	; 0232EF30
pool_0232EF34:
loc_0232EF34:
	.word P1_PxiReceiveCallbacks	; 0232EF34
pool_0232EF38:
loc_0232EF38:
	.word 0x00040000	; 0232EF38
pool_0232EF3C:
loc_0232EF3C:
	.word P1_IrqHandler_0232ECB8 + 1	; 0232EF3C
pool_0232EF40:
loc_0232EF40:
	.word 0x0000C408	; 0232EF40
pool_0232EF44:
loc_0232EF44:
	.word REG_IPC_FIFO_CR	; 0232EF44
pool_0232EF48:
loc_0232EF48:
	.word REG_IPC_SYNC	; 0232EF48
pool_0232EF4C:
loc_0232EF4C:
	.word 0x000003E8	; 0232EF4C

; ===== function loc_0232EF50 =====
loc_0232EF50:
; 恢复除法/开方操作数及模式。
; Restore division/square-root operands and modes.
.func P1_RestoreArithmeticContext
	ldr r3,[r0,#0x0]	; 0232EF50
	ldr r2,[r0,#0x4]	; 0232EF52
	ldr r1,[pool_0232EF7C]	; 0232EF54
	str r3,[r1,#0x0]	; 0232EF56
	str r2,[r1,#0x4]	; 0232EF58
	ldr r3,[r0,#0x8]	; 0232EF5A
	ldr r2,[r0,#0xc]	; 0232EF5C
	ldr r1,[pool_0232EF80]	; 0232EF5E
	str r3,[r1,#0x0]	; 0232EF60
	str r2,[r1,#0x4]	; 0232EF62
	ldrh r2,[r0,#0x18]	; 0232EF64
	ldr r1,[pool_0232EF84]	; 0232EF66
	strh r2,[r1,#0x0]	; 0232EF68
	ldr r3,[r0,#0x10]	; 0232EF6A
	ldr r2,[r0,#0x14]	; 0232EF6C
	ldr r1,[pool_0232EF88]	; 0232EF6E
	str r3,[r1,#0x0]	; 0232EF70
	str r2,[r1,#0x4]	; 0232EF72
	ldrh r1,[r0,#0x1a]	; 0232EF74
	ldr r0,[pool_0232EF8C]	; 0232EF76
	strh r1,[r0,#0x0]	; 0232EF78
	bx lr	; 0232EF7A
.endfunc
pool_0232EF7C:
loc_0232EF7C:
	.word REG_DIV_NUMER	; 0232EF7C
pool_0232EF80:
loc_0232EF80:
	.word REG_DIV_DENOM	; 0232EF80
pool_0232EF84:
loc_0232EF84:
	.word REG_DIVCNT	; 0232EF84
pool_0232EF88:
loc_0232EF88:
	.word REG_SQRT_PARAM	; 0232EF88
pool_0232EF8C:
loc_0232EF8C:
	.word REG_SQRTCNT	; 0232EF8C

; ===== function loc_0232EF90 =====
loc_0232EF90:
; 保存除法/开方操作数及模式，不保存结果寄存器。
; Save division/square-root operands and modes, not the result registers.
.func P1_SaveArithmeticContext
	ldr r1,[pool_0232EFC4]	; 0232EF90
	ldr r2,[r1,#0x0]	; 0232EF92
	ldr r1,[r1,#0x4]	; 0232EF94
	str r2,[r0,#0x0]	; 0232EF96
	str r1,[r0,#0x4]	; 0232EF98
	ldr r1,[pool_0232EFC8]	; 0232EF9A
	ldr r2,[r1,#0x0]	; 0232EF9C
	ldr r1,[r1,#0x4]	; 0232EF9E
	str r2,[r0,#0x8]	; 0232EFA0
	str r1,[r0,#0xc]	; 0232EFA2
	ldr r1,[pool_0232EFCC]	; 0232EFA4
	ldrh r2,[r1,#0x0]	; 0232EFA6
	mov r1,#0x3	; 0232EFA8
	and r2,r1	; 0232EFAA
	strh r2,[r0,#0x18]	; 0232EFAC
	ldr r1,[pool_0232EFD0]	; 0232EFAE
	ldr r2,[r1,#0x0]	; 0232EFB0
	ldr r1,[r1,#0x4]	; 0232EFB2
	str r2,[r0,#0x10]	; 0232EFB4
	str r1,[r0,#0x14]	; 0232EFB6
	ldr r1,[pool_0232EFD4]	; 0232EFB8
	ldrh r2,[r1,#0x0]	; 0232EFBA
	mov r1,#0x1	; 0232EFBC
	and r2,r1	; 0232EFBE
	strh r2,[r0,#0x1a]	; 0232EFC0
	bx lr	; 0232EFC2
.endfunc
pool_0232EFC4:
loc_0232EFC4:
	.word REG_DIV_NUMER	; 0232EFC4
pool_0232EFC8:
loc_0232EFC8:
	.word REG_DIV_DENOM	; 0232EFC8
pool_0232EFCC:
loc_0232EFCC:
	.word REG_DIVCNT	; 0232EFCC
pool_0232EFD0:
loc_0232EFD0:
	.word REG_SQRT_PARAM	; 0232EFD0
pool_0232EFD4:
loc_0232EFD4:
	.word REG_SQRTCNT	; 0232EFD4

; ===== function loc_0232EFD8 =====
loc_0232EFD8:
	ldr r1,[pool_0232EFE4]	; 0232EFD8
loc_0232EFDA:
	ldrh r2,[r1,#0x36]	; 0232EFDA
	and r2,r0	; 0232EFDC
	cmp r2,#0x0	; 0232EFDE
	bne loc_0232EFDA	; 0232EFE0
	bx lr	; 0232EFE2
pool_0232EFE4:
loc_0232EFE4:
	.word P1_BssStart + 0x2828C	; 0232EFE4

; ===== function loc_0232EFE8 =====
loc_0232EFE8:
	push {r4,r5,r6,r7,lr}	; 0232EFE8
	sub sp,#0x4	; 0232EFEA
	add r5,r0,#0x0	; 0232EFEC
	add r4,r1,#0x0	; 0232EFEE
	ldr r0,[pool_0232F0A8]	; 0232EFF0
	ldrh r0,[r0,#0x30]	; 0232EFF2
	cmp r0,#0x0	; 0232EFF4
	bne loc_0232F010	; 0232EFF6
	ldrh r0,[r4,#0x0]	; 0232EFF8
	strh r0,[r5,#0x0]	; 0232EFFA
	ldrh r0,[r4,#0x2]	; 0232EFFC
	strh r0,[r5,#0x2]	; 0232EFFE
	ldrh r0,[r4,#0x4]	; 0232F000
	strh r0,[r5,#0x4]	; 0232F002
	ldrh r0,[r4,#0x6]	; 0232F004
	strh r0,[r5,#0x6]	; 0232F006
	add sp,#0x4	; 0232F008
	pop {r4,r5,r6,r7}	; 0232F00A
	pop {r3}	; 0232F00C
	bx r3	; 0232F00E
loc_0232F010:
	ldrh r0,[r4,#0x4]	; 0232F010
	strh r0,[r5,#0x4]	; 0232F012
	ldrh r0,[r4,#0x6]	; 0232F014
	strh r0,[r5,#0x6]	; 0232F016
	ldrh r0,[r4,#0x4]	; 0232F018
	cmp r0,#0x0	; 0232F01A
	bne loc_0232F02C	; 0232F01C
	mov r0,#0x0	; 0232F01E
	strh r0,[r5,#0x0]	; 0232F020
	strh r0,[r5,#0x2]	; 0232F022
	add sp,#0x4	; 0232F024
	pop {r4,r5,r6,r7}	; 0232F026
	pop {r3}	; 0232F028
	bx r3	; 0232F02A
loc_0232F02C:
	ldr r0,[pool_0232F0AC]	; 0232F02C
	ldr r0,[r0,#0x8]	; 0232F02E
	asr r1,r0,#0x1f	; 0232F030
	ldrh r2,[r4,#0x0]	; 0232F032
	lsl r6,r2,#0x2	; 0232F034
	asr r3,r6,#0x1f	; 0232F036
	ldr r2,[pool_0232F0AC]	; 0232F038
	ldr r2,[r2,#0x0]	; 0232F03A
	asr r7,r2,#0x1f	; 0232F03C
	sub r2,r6,r2	; 0232F03E
	sbc r3,r7	; 0232F040
	blx P1_AeabiLmul	; 0232F042
	lsl r1,r1,#0xa	; 0232F046
	lsr r0,r0,#0x16	; 0232F048
	orr r0,r1	; 0232F04A
	strh r0,[r5,#0x0]	; 0232F04C
	mov r0,#0x0	; 0232F04E
	ldrsh r1,[r5,r0]	; 0232F050
	cmp r1,#0x0	; 0232F052
	bge loc_0232F05A	; 0232F054
	strh r0,[r5,#0x0]	; 0232F056
	b loc_0232F062	; 0232F058
loc_0232F05A:
	cmp r1,#0xff	; 0232F05A
	ble loc_0232F062	; 0232F05C
	mov r0,#0xff	; 0232F05E
	strh r0,[r5,#0x0]	; 0232F060
loc_0232F062:
	ldr r0,[pool_0232F0AC]	; 0232F062
	ldr r0,[r0,#0x14]	; 0232F064
	asr r1,r0,#0x1f	; 0232F066
	ldrh r2,[r4,#0x2]	; 0232F068
	lsl r2,r2,#0x2	; 0232F06A
	asr r3,r2,#0x1f	; 0232F06C
	ldr r4,[pool_0232F0AC]	; 0232F06E
	ldr r6,[r4,#0xc]	; 0232F070
	asr r4,r6,#0x1f	; 0232F072
	sub r2,r2,r6	; 0232F074
	sbc r3,r4	; 0232F076
	blx P1_AeabiLmul	; 0232F078
	lsl r1,r1,#0xa	; 0232F07C
	lsr r0,r0,#0x16	; 0232F07E
	orr r0,r1	; 0232F080
	strh r0,[r5,#0x2]	; 0232F082
	mov r0,#0x2	; 0232F084
	ldrsh r0,[r5,r0]	; 0232F086
	cmp r0,#0x0	; 0232F088
	bge loc_0232F098	; 0232F08A
	mov r0,#0x0	; 0232F08C
	strh r0,[r5,#0x2]	; 0232F08E
	add sp,#0x4	; 0232F090
	pop {r4,r5,r6,r7}	; 0232F092
	pop {r3}	; 0232F094
	bx r3	; 0232F096
loc_0232F098:
	cmp r0,#0xbf	; 0232F098
	ble loc_0232F0A0	; 0232F09A
	mov r0,#0xbf	; 0232F09C
	strh r0,[r5,#0x2]	; 0232F09E
loc_0232F0A0:
	add sp,#0x4	; 0232F0A0
	pop {r4,r5,r6,r7}	; 0232F0A2
	pop {r3}	; 0232F0A4
	bx r3	; 0232F0A6
pool_0232F0A8:
loc_0232F0A8:
	.word P1_BssStart + 0x2828C	; 0232F0A8
pool_0232F0AC:
loc_0232F0AC:
	.word P1_BssStart + 0x282A4	; 0232F0AC

; ===== function loc_0232F0B0 =====
loc_0232F0B0:
	push {r4,r5,r6,r7,lr}	; 0232F0B0
	sub sp,#0x24	; 0232F0B2
	add r5,r0,#0x0	; 0232F0B4
	add r4,r1,#0x0	; 0232F0B6
	add r7,r2,#0x0	; 0232F0B8
	add r6,r3,#0x0	; 0232F0BA
	ldr r2,[pool_0232F23C]	; 0232F0BC
	cmp r4,r2	; 0232F0BE
	bcs loc_0232F0D6	; 0232F0C0
	cmp r7,r2	; 0232F0C2
	bcs loc_0232F0D6	; 0232F0C4
	add r3,sp,#0x28	; 0232F0C6
	ldrh r1,[r3,#0x14]	; 0232F0C8
	cmp r1,r2	; 0232F0CA
	bcs loc_0232F0D6	; 0232F0CC
	ldrh r0,[r3,#0x18]	; 0232F0CE
	str r0,[sp,#0x20]	; 0232F0D0
	cmp r0,r2	; 0232F0D2
	bcc loc_0232F0E0	; 0232F0D4
loc_0232F0D6:
	mov r0,#0x1	; 0232F0D6
	add sp,#0x24	; 0232F0D8
	pop {r4,r5,r6,r7}	; 0232F0DA
	pop {r3}	; 0232F0DC
	bx r3	; 0232F0DE
loc_0232F0E0:
	ldr r0,[pool_0232F240]	; 0232F0E0
	cmp r6,r0	; 0232F0E2
	bcs loc_0232F0FC	; 0232F0E4
	ldrh r0,[r3,#0x1c]	; 0232F0E6
	ldr r2,[pool_0232F240]	; 0232F0E8
	cmp r0,r2	; 0232F0EA
	bcs loc_0232F0FC	; 0232F0EC
	ldrh r2,[r3,#0x10]	; 0232F0EE
	str r2,[sp,#0x1c]	; 0232F0F0
	cmp r2,#0xc0	; 0232F0F2
	bcs loc_0232F0FC	; 0232F0F4
	ldrh r2,[r3,#0x20]	; 0232F0F6
	cmp r2,#0xc0	; 0232F0F8
	bcc loc_0232F106	; 0232F0FA
loc_0232F0FC:
	mov r0,#0x1	; 0232F0FC
	add sp,#0x24	; 0232F0FE
	pop {r4,r5,r6,r7}	; 0232F100
	pop {r3}	; 0232F102
	bx r3	; 0232F104
loc_0232F106:
	cmp r6,r0	; 0232F106
	beq loc_0232F11A	; 0232F108
	ldr r0,[sp,#0x1c]	; 0232F10A
	cmp r0,r2	; 0232F10C
	beq loc_0232F11A	; 0232F10E
	cmp r4,r1	; 0232F110
	beq loc_0232F11A	; 0232F112
	ldr r0,[sp,#0x20]	; 0232F114
	cmp r7,r0	; 0232F116
	bne loc_0232F124	; 0232F118
loc_0232F11A:
	mov r0,#0x1	; 0232F11A
	add sp,#0x24	; 0232F11C
	pop {r4,r5,r6,r7}	; 0232F11E
	pop {r3}	; 0232F120
	bx r3	; 0232F122
loc_0232F124:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F124
	str r0,[sp,#0x4]	; 0232F128
	mov r3,#0x0	; 0232F12A
	ldr r0,[pool_0232F244]	; 0232F12C
	strh r3,[r0,#0x0]	; 0232F12E
	add r1,sp,#0x28	; 0232F130
	ldrh r1,[r1,#0x14]	; 0232F132
	str r1,[sp,#0xc]	; 0232F134
	sub r1,r4,r1	; 0232F136
	lsl r2,r1,#0x8	; 0232F138
	ldr r1,[pool_0232F248]	; 0232F13A
	str r2,[r1,#0x0]	; 0232F13C
	add r1,sp,#0x28	; 0232F13E
	ldrh r1,[r1,#0x1c]	; 0232F140
	str r1,[sp,#0x8]	; 0232F142
	sub r1,r6,r1	; 0232F144
	ldr r2,[pool_0232F24C]	; 0232F146
	str r1,[r2,#0x0]	; 0232F148
	str r3,[r2,#0x4]	; 0232F14A
	add r1,sp,#0x28	; 0232F14C
	ldrh r1,[r1,#0x18]	; 0232F14E
	str r1,[sp,#0x18]	; 0232F150
	sub r3,r7,r1	; 0232F152
	add r1,sp,#0x28	; 0232F154
	ldrh r1,[r1,#0x20]	; 0232F156
	str r1,[sp,#0x10]	; 0232F158
	add r1,sp,#0x28	; 0232F15A
	ldrh r2,[r1,#0x10]	; 0232F15C
	str r2,[sp,#0x14]	; 0232F15E
	ldr r1,[sp,#0x10]	; 0232F160
	sub r1,r2,r1	; 0232F162
	str r1,[sp,#0x0]	; 0232F164
	ldr r1,[pool_0232F250]	; 0232F166
loc_0232F168:
	ldrh r2,[r0,#0x0]	; 0232F168
	and r2,r1	; 0232F16A
	cmp r2,#0x0	; 0232F16C
	bne loc_0232F168	; 0232F16E
	ldr r1,[pool_0232F254]	; 0232F170
	ldr r2,[r1,#0x0]	; 0232F172
	mov r1,#0x0	; 0232F174
	strh r1,[r0,#0x0]	; 0232F176
	lsl r1,r3,#0x8	; 0232F178
	ldr r0,[pool_0232F248]	; 0232F17A
	str r1,[r0,#0x0]	; 0232F17C
	ldr r0,[pool_0232F24C]	; 0232F17E
	ldr r1,[sp,#0x0]	; 0232F180
	str r1,[r0,#0x0]	; 0232F182
	mov r1,#0x0	; 0232F184
	str r1,[r0,#0x4]	; 0232F186
	ldr r0,[pool_0232F250]	; 0232F188
	cmp r2,r0	; 0232F18A
	bge loc_0232F194	; 0232F18C
	ldr r1,[pool_0232F258]	; 0232F18E
	cmp r2,r1	; 0232F190
	bge loc_0232F1A4	; 0232F192
loc_0232F194:
	ldr r0,[sp,#0x4]	; 0232F194
	blx P1_Arm9RestoreIrqMask	; 0232F196
	mov r0,#0x1	; 0232F19A
	add sp,#0x24	; 0232F19C
	pop {r4,r5,r6,r7}	; 0232F19E
	pop {r3}	; 0232F1A0
	bx r3	; 0232F1A2
loc_0232F1A4:
	strh r2,[r5,#0x4]	; 0232F1A4
	ldr r1,[sp,#0xc]	; 0232F1A6
	add r1,r4,r1	; 0232F1A8
	lsl r2,r1,#0x8	; 0232F1AA
	mov r1,#0x4	; 0232F1AC
	ldrsh r1,[r5,r1]	; 0232F1AE
	ldr r3,[sp,#0x8]	; 0232F1B0
	add r3,r6,r3	; 0232F1B2
	mul r1,r3	; 0232F1B4
	sub r1,r2,r1	; 0232F1B6
	lsl r1,r1,#0x9	; 0232F1B8
	asr r2,r1,#0x10	; 0232F1BA
	cmp r2,r0	; 0232F1BC
	bge loc_0232F1C6	; 0232F1BE
	ldr r1,[pool_0232F258]	; 0232F1C0
	cmp r2,r1	; 0232F1C2
	bge loc_0232F1D6	; 0232F1C4
loc_0232F1C6:
	ldr r0,[sp,#0x4]	; 0232F1C6
	blx P1_Arm9RestoreIrqMask	; 0232F1C8
	mov r0,#0x1	; 0232F1CC
	add sp,#0x24	; 0232F1CE
	pop {r4,r5,r6,r7}	; 0232F1D0
	pop {r3}	; 0232F1D2
	bx r3	; 0232F1D4
loc_0232F1D6:
	strh r2,[r5,#0x0]	; 0232F1D6
	ldr r1,[pool_0232F244]	; 0232F1D8
loc_0232F1DA:
	ldrh r2,[r1,#0x0]	; 0232F1DA
	and r2,r0	; 0232F1DC
	cmp r2,#0x0	; 0232F1DE
	bne loc_0232F1DA	; 0232F1E0
	ldr r0,[pool_0232F254]	; 0232F1E2
	ldr r4,[r0,#0x0]	; 0232F1E4
	ldr r0,[sp,#0x4]	; 0232F1E6
	blx P1_Arm9RestoreIrqMask	; 0232F1E8
	ldr r1,[pool_0232F250]	; 0232F1EC
	cmp r4,r1	; 0232F1EE
	bge loc_0232F1F8	; 0232F1F0
	ldr r0,[pool_0232F258]	; 0232F1F2
	cmp r4,r0	; 0232F1F4
	bge loc_0232F202	; 0232F1F6
loc_0232F1F8:
	mov r0,#0x1	; 0232F1F8
	add sp,#0x24	; 0232F1FA
	pop {r4,r5,r6,r7}	; 0232F1FC
	pop {r3}	; 0232F1FE
	bx r3	; 0232F200
loc_0232F202:
	strh r4,[r5,#0x6]	; 0232F202
	ldr r2,[sp,#0x18]	; 0232F204
	add r2,r7,r2	; 0232F206
	lsl r3,r2,#0x8	; 0232F208
	mov r2,#0x6	; 0232F20A
	ldrsh r2,[r5,r2]	; 0232F20C
	ldr r6,[sp,#0x14]	; 0232F20E
	ldr r4,[sp,#0x10]	; 0232F210
	add r4,r6,r4	; 0232F212
	mul r2,r4	; 0232F214
	sub r2,r3,r2	; 0232F216
	lsl r2,r2,#0x9	; 0232F218
	asr r2,r2,#0x10	; 0232F21A
	cmp r2,r1	; 0232F21C
	bge loc_0232F224	; 0232F21E
	cmp r2,r0	; 0232F220
	bge loc_0232F22E	; 0232F222
loc_0232F224:
	mov r0,#0x1	; 0232F224
	add sp,#0x24	; 0232F226
	pop {r4,r5,r6,r7}	; 0232F228
	pop {r3}	; 0232F22A
	bx r3	; 0232F22C
loc_0232F22E:
	strh r2,[r5,#0x2]	; 0232F22E
	mov r0,#0x0	; 0232F230
	add sp,#0x24	; 0232F232
	pop {r4,r5,r6,r7}	; 0232F234
	pop {r3}	; 0232F236
	bx r3	; 0232F238
	.byte 0xC0, 0x46	; 0232F23C
pool_0232F23C:
loc_0232F23C:
	.word 0x00001000	; 0232F23C
pool_0232F240:
loc_0232F240:
	.word 0x00000100	; 0232F240
pool_0232F244:
loc_0232F244:
	.word REG_DIVCNT	; 0232F244
pool_0232F248:
loc_0232F248:
	.word REG_DIV_NUMER	; 0232F248
pool_0232F24C:
loc_0232F24C:
	.word REG_DIV_DENOM	; 0232F24C
pool_0232F250:
loc_0232F250:
	.word 0x00008000	; 0232F250
pool_0232F254:
loc_0232F254:
	.word REG_DIV_RESULT	; 0232F254
pool_0232F258:
loc_0232F258:
	.word 0xFFFF8000	; 0232F258

; ===== function loc_0232F25C =====
loc_0232F25C:
	push {r4,lr}	; 0232F25C
	add r4,r0,#0x0	; 0232F25E
	mov r0,#0x1	; 0232F260
	bl loc_0232EFD8	; 0232F262
	ldr r1,[pool_0232F28C]	; 0232F266
	ldrh r2,[r1,#0x34]	; 0232F268
	mov r0,#0x1	; 0232F26A
	and r2,r0	; 0232F26C
	cmp r2,#0x0	; 0232F26E
	bne loc_0232F284	; 0232F270
	ldrh r0,[r1,#0x4]	; 0232F272
	strh r0,[r4,#0x0]	; 0232F274
	ldrh r0,[r1,#0x6]	; 0232F276
	strh r0,[r4,#0x2]	; 0232F278
	ldrh r0,[r1,#0x8]	; 0232F27A
	strh r0,[r4,#0x4]	; 0232F27C
	ldrh r0,[r1,#0xa]	; 0232F27E
	strh r0,[r4,#0x6]	; 0232F280
	mov r0,#0x0	; 0232F282
loc_0232F284:
	pop {r4}	; 0232F284
	pop {r3}	; 0232F286
	bx r3	; 0232F288
	.byte 0xC0, 0x46	; 0232F28C
pool_0232F28C:
loc_0232F28C:
	.word P1_BssStart + 0x2828C	; 0232F28C

; ===== function loc_0232F290 =====
loc_0232F290:
	push {r4,lr}	; 0232F290
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F292
	add r4,r0,#0x0	; 0232F296
	mov r0,#0x6	; 0232F298
	ldr r1,[pool_0232F2F0]	; 0232F29A
	mov r2,#0x0	; 0232F29C
	bl loc_0232ED90	; 0232F29E
	cmp r0,#0x0	; 0232F2A2
	blt loc_0232F2AA	; 0232F2A4
	mov r0,#0x1	; 0232F2A6
	b loc_0232F2AC	; 0232F2A8
loc_0232F2AA:
	mov r0,#0x0	; 0232F2AA
loc_0232F2AC:
	cmp r0,#0x0	; 0232F2AC
	bne loc_0232F2D4	; 0232F2AE
	add r0,r4,#0x0	; 0232F2B0
	blx P1_Arm9RestoreIrqMask	; 0232F2B2
	ldr r1,[pool_0232F2F4]	; 0232F2B6
	ldrh r2,[r1,#0x34]	; 0232F2B8
	mov r0,#0x1	; 0232F2BA
	orr r2,r0	; 0232F2BC
	strh r2,[r1,#0x34]	; 0232F2BE
	ldr r3,[r1,#0x0]	; 0232F2C0
	cmp r3,#0x0	; 0232F2C2
	beq loc_0232F2EA	; 0232F2C4
	mov r0,#0x0	; 0232F2C6
	mov r1,#0x4	; 0232F2C8
	add r2,r0,#0x0	; 0232F2CA
	blx r3	; 0232F2CC
	pop {r4}	; 0232F2CE
	pop {r3}	; 0232F2D0
	bx r3	; 0232F2D2
loc_0232F2D4:
	ldr r1,[pool_0232F2F4]	; 0232F2D4
	ldrh r2,[r1,#0x36]	; 0232F2D6
	mov r0,#0x1	; 0232F2D8
	orr r2,r0	; 0232F2DA
	strh r2,[r1,#0x36]	; 0232F2DC
	ldrh r2,[r1,#0x34]	; 0232F2DE
	bic r2,r0	; 0232F2E0
	strh r2,[r1,#0x34]	; 0232F2E2
	add r0,r4,#0x0	; 0232F2E4
	blx P1_Arm9RestoreIrqMask	; 0232F2E6
loc_0232F2EA:
	pop {r4}	; 0232F2EA
	pop {r3}	; 0232F2EC
	bx r3	; 0232F2EE
pool_0232F2F0:
loc_0232F2F0:
	.word P1_DtcmRuntimeStart	; 0232F2F0
pool_0232F2F4:
loc_0232F2F4:
	.word P1_BssStart + 0x2828C	; 0232F2F4

; ===== function loc_0232F2F8 =====
loc_0232F2F8:
	push {r4,r5,r6,r7,lr}	; 0232F2F8
	sub sp,#0x4	; 0232F2FA
	add r4,r0,#0x0	; 0232F2FC
	cmp r4,#0x0	; 0232F2FE
	bne loc_0232F310	; 0232F300
	mov r1,#0x0	; 0232F302
	ldr r0,[pool_0232F390]	; 0232F304
	strh r1,[r0,#0x30]	; 0232F306
	add sp,#0x4	; 0232F308
	pop {r4,r5,r6,r7}	; 0232F30A
	pop {r3}	; 0232F30C
	bx r3	; 0232F30E
loc_0232F310:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F310
	add r6,r0,#0x0	; 0232F314
	mov r7,#0x4	; 0232F316
	ldrsh r5,[r4,r7]	; 0232F318
	mov r3,#0x0	; 0232F31A
	ldr r2,[pool_0232F394]	; 0232F31C
	strh r3,[r2,#0x0]	; 0232F31E
	ldr r1,[pool_0232F398]	; 0232F320
	ldr r0,[pool_0232F39C]	; 0232F322
	str r1,[r0,#0x0]	; 0232F324
	ldr r0,[pool_0232F3A0]	; 0232F326
	str r5,[r0,#0x0]	; 0232F328
	str r3,[r0,#0x4]	; 0232F32A
	ldrsh r1,[r4,r3]	; 0232F32C
	ldr r0,[pool_0232F390]	; 0232F32E
	str r1,[r0,#0x18]	; 0232F330
	ldrsh r1,[r4,r7]	; 0232F332
	str r1,[r0,#0x1c]	; 0232F334
	ldr r0,[pool_0232F3A4]	; 0232F336
loc_0232F338:
	ldrh r1,[r2,#0x0]	; 0232F338
	and r1,r0	; 0232F33A
	cmp r1,#0x0	; 0232F33C
	bne loc_0232F338	; 0232F33E
	ldr r0,[pool_0232F3A8]	; 0232F340
	ldr r0,[r0,#0x0]	; 0232F342
	ldr r3,[pool_0232F390]	; 0232F344
	str r0,[r3,#0x20]	; 0232F346
	mov r7,#0x6	; 0232F348
	ldrsh r1,[r4,r7]	; 0232F34A
	mov r0,#0x0	; 0232F34C
	strh r0,[r2,#0x0]	; 0232F34E
	ldr r5,[pool_0232F398]	; 0232F350
	ldr r2,[pool_0232F39C]	; 0232F352
	str r5,[r2,#0x0]	; 0232F354
	ldr r2,[pool_0232F3A0]	; 0232F356
	str r1,[r2,#0x0]	; 0232F358
	str r0,[r2,#0x4]	; 0232F35A
	mov r0,#0x2	; 0232F35C
	ldrsh r0,[r4,r0]	; 0232F35E
	str r0,[r3,#0x24]	; 0232F360
	ldrsh r0,[r4,r7]	; 0232F362
	str r0,[r3,#0x28]	; 0232F364
	ldr r1,[pool_0232F394]	; 0232F366
	ldr r0,[pool_0232F3A4]	; 0232F368
loc_0232F36A:
	ldrh r2,[r1,#0x0]	; 0232F36A
	and r2,r0	; 0232F36C
	cmp r2,#0x0	; 0232F36E
	bne loc_0232F36A	; 0232F370
	ldr r0,[pool_0232F3A8]	; 0232F372
	ldr r1,[r0,#0x0]	; 0232F374
	ldr r0,[pool_0232F390]	; 0232F376
	str r1,[r0,#0x2c]	; 0232F378
	add r0,r6,#0x0	; 0232F37A
	blx P1_Arm9RestoreIrqMask	; 0232F37C
	mov r1,#0x1	; 0232F380
	ldr r0,[pool_0232F390]	; 0232F382
	strh r1,[r0,#0x30]	; 0232F384
	add sp,#0x4	; 0232F386
	pop {r4,r5,r6,r7}	; 0232F388
	pop {r3}	; 0232F38A
	bx r3	; 0232F38C
	.byte 0xC0, 0x46	; 0232F390
pool_0232F390:
loc_0232F390:
	.word P1_BssStart + 0x2828C	; 0232F390
pool_0232F394:
loc_0232F394:
	.word REG_DIVCNT	; 0232F394
pool_0232F398:
loc_0232F398:
	.word 0x10000000	; 0232F398
pool_0232F39C:
loc_0232F39C:
	.word REG_DIV_NUMER	; 0232F39C
pool_0232F3A0:
loc_0232F3A0:
	.word REG_DIV_DENOM	; 0232F3A0
pool_0232F3A4:
loc_0232F3A4:
	.word 0x00008000	; 0232F3A4
pool_0232F3A8:
loc_0232F3A8:
	.word REG_DIV_RESULT	; 0232F3A8

; ===== function loc_0232F3AC =====
loc_0232F3AC:
	push {r4,r5,lr}	; 0232F3AC
	sub sp,#0x4	; 0232F3AE
	ldr r0,[pool_0232F3F4]	; 0232F3B0
	ldrh r1,[r0,#0x0]	; 0232F3B2
	cmp r1,#0x0	; 0232F3B4
	bne loc_0232F3EA	; 0232F3B6
	mov r1,#0x1	; 0232F3B8
	strh r1,[r0,#0x0]	; 0232F3BA
	bl loc_0232ECB0	; 0232F3BC
	mov r1,#0x0	; 0232F3C0
	ldr r0,[pool_0232F3F8]	; 0232F3C2
	strh r1,[r0,#0xc]	; 0232F3C4
	str r1,[r0,#0x0]	; 0232F3C6
	str r1,[r0,#0x10]	; 0232F3C8
	strh r1,[r0,#0x32]	; 0232F3CA
	strh r1,[r0,#0x30]	; 0232F3CC
	strh r1,[r0,#0x36]	; 0232F3CE
	strh r1,[r0,#0x34]	; 0232F3D0
	mov r5,#0x6	; 0232F3D2
	mov r4,#0x1	; 0232F3D4
loc_0232F3D6:
	add r0,r5,#0x0	; 0232F3D6
	add r1,r4,#0x0	; 0232F3D8
	bl loc_0232EE24	; 0232F3DA
	cmp r0,#0x0	; 0232F3DE
	beq loc_0232F3D6	; 0232F3E0
	mov r0,#0x6	; 0232F3E2
	ldr r1,[pool_0232F3FC]	; 0232F3E4
	bl P1_SetPxiReceiveCallback	; 0232F3E6
loc_0232F3EA:
	add sp,#0x4	; 0232F3EA
	pop {r4,r5}	; 0232F3EC
	pop {r3}	; 0232F3EE
	bx r3	; 0232F3F0
	.byte 0xC0, 0x46	; 0232F3F4
pool_0232F3F4:
loc_0232F3F4:
	.word P1_BssStart + 0x28288	; 0232F3F4
pool_0232F3F8:
loc_0232F3F8:
	.word P1_BssStart + 0x2828C	; 0232F3F8
pool_0232F3FC:
loc_0232F3FC:
	.word P1_PxiCallback_0232F400 + 1	; 0232F3FC

; ===== function loc_0232F400 =====
P1_PxiCallback_0232F400:
	push {r4,r5,r6,lr}	; 0232F400
	sub sp,#0x8	; 0232F402
	lsl r0,r1,#0x10	; 0232F404
	lsr r3,r0,#0x10	; 0232F406
	ldr r0,[pool_0232F584]	; 0232F408
	add r4,r3,#0x0	; 0232F40A
	and r4,r0	; 0232F40C
	lsl r0,r4,#0x8	; 0232F40E
	lsr r0,r0,#0x10	; 0232F410
	cmp r2,#0x0	; 0232F412
	beq loc_0232F438	; 0232F414
	ldr r1,[pool_0232F588]	; 0232F416
	ldrh r3,[r1,#0x34]	; 0232F418
	mov r2,#0x1	; 0232F41A
	lsl r2,r0	; 0232F41C
	orr r3,r2	; 0232F41E
	strh r3,[r1,#0x34]	; 0232F420
	ldr r3,[r1,#0x0]	; 0232F422
	cmp r3,#0x0	; 0232F424
	bne loc_0232F42A	; 0232F426
	b loc_0232F57A	; 0232F428
loc_0232F42A:
	mov r1,#0x4	; 0232F42A
	mov r2,#0x0	; 0232F42C
	blx r3	; 0232F42E
	add sp,#0x8	; 0232F430
	pop {r4,r5,r6}	; 0232F432
	pop {r3}	; 0232F434
	bx r3	; 0232F436
loc_0232F438:
	cmp r0,#0x10	; 0232F438
	bne loc_0232F4A8	; 0232F43A
	ldr r1,[pool_0232F588]	; 0232F43C
	ldrh r2,[r1,#0xc]	; 0232F43E
	add r2,r2,#0x1	; 0232F440
	strh r2,[r1,#0xc]	; 0232F442
	ldrh r3,[r1,#0xc]	; 0232F444
	ldrh r2,[r1,#0x14]	; 0232F446
	cmp r3,r2	; 0232F448
	bcc loc_0232F450	; 0232F44A
	mov r2,#0x0	; 0232F44C
	strh r2,[r1,#0xc]	; 0232F44E
loc_0232F450:
	ldr r2,[pool_0232F588]	; 0232F450
	ldr r3,[r2,#0x10]	; 0232F452
	ldrh r1,[r2,#0xc]	; 0232F454
	lsl r1,r1,#0x3	; 0232F456
	add r4,r3,r1	; 0232F458
	ldr r5,[pool_0232F58C]	; 0232F45A
	ldrh r6,[r5,#0x0]	; 0232F45C
	add r5,sp,#0x0	; 0232F45E
	strh r6,[r5,#0x0]	; 0232F460
	ldr r6,[pool_0232F590]	; 0232F462
	ldrh r6,[r6,#0x0]	; 0232F464
	strh r6,[r5,#0x2]	; 0232F466
	ldr r5,[sp,#0x0]	; 0232F468
	lsl r5,r5,#0x14	; 0232F46A
	lsr r5,r5,#0x14	; 0232F46C
	strh r5,[r3,r1]	; 0232F46E
	ldr r1,[sp,#0x0]	; 0232F470
	lsl r1,r1,#0x8	; 0232F472
	lsr r1,r1,#0x14	; 0232F474
	strh r1,[r4,#0x2]	; 0232F476
	ldr r1,[sp,#0x0]	; 0232F478
	lsl r1,r1,#0x7	; 0232F47A
	lsr r1,r1,#0x1f	; 0232F47C
	lsl r1,r1,#0x18	; 0232F47E
	lsr r1,r1,#0x18	; 0232F480
	strh r1,[r4,#0x4]	; 0232F482
	ldr r1,[sp,#0x0]	; 0232F484
	lsl r1,r1,#0x5	; 0232F486
	lsr r1,r1,#0x1e	; 0232F488
	lsl r1,r1,#0x18	; 0232F48A
	lsr r1,r1,#0x18	; 0232F48C
	strh r1,[r4,#0x6]	; 0232F48E
	ldr r3,[r2,#0x0]	; 0232F490
	cmp r3,#0x0	; 0232F492
	beq loc_0232F57A	; 0232F494
	mov r1,#0x0	; 0232F496
	ldrh r2,[r2,#0xc]	; 0232F498
	lsl r2,r2,#0x18	; 0232F49A
	lsr r2,r2,#0x18	; 0232F49C
	blx r3	; 0232F49E
	add sp,#0x8	; 0232F4A0
	pop {r4,r5,r6}	; 0232F4A2
	pop {r3}	; 0232F4A4
	bx r3	; 0232F4A6
loc_0232F4A8:
	ldr r2,[pool_0232F594]	; 0232F4A8
	and r1,r2	; 0232F4AA
	cmp r1,#0x0	; 0232F4AC
	beq loc_0232F57A	; 0232F4AE
	lsl r1,r3,#0x18	; 0232F4B0
	lsr r1,r1,#0x18	; 0232F4B2
	cmp r1,#0x4	; 0232F4B4
	bhi loc_0232F576	; 0232F4B6
	add r1,r1,r1	; 0232F4B8
P1_SwitchIndexPC_0232F4B8:
	add r1,pc	; 0232F4BA
	ldrh r1,[r1,#(P1_SwitchTable_0232F4B8 - (P1_SwitchIndexPC_0232F4B8 + 4))]	; 0232F4BC
	lsl r1,r1,#0x10	; 0232F4BE
	asr r1,r1,#0x10	; 0232F4C0
P1_SwitchTargetPC_0232F4B8:
	add r1,pc	; 0232F4C2
	bx r1	; 0232F4C4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232F4B8:
	.halfword (loc_0232F4D0 + 1) - (P1_SwitchTargetPC_0232F4B8 + 4)
	.halfword (loc_0232F576 + 1) - (P1_SwitchTargetPC_0232F4B8 + 4)
	.halfword (loc_0232F548 + 1) - (P1_SwitchTargetPC_0232F4B8 + 4)
	.halfword (loc_0232F54C + 1) - (P1_SwitchTargetPC_0232F4B8 + 4)
	.halfword (loc_0232F544 + 1) - (P1_SwitchTargetPC_0232F4B8 + 4)
P1_SwitchTable_0232F4B8End:
loc_0232F4D0:
	cmp r0,#0x0	; 0232F4D0
	beq loc_0232F4DE	; 0232F4D2
	cmp r0,#0x1	; 0232F4D4
	beq loc_0232F516	; 0232F4D6
	cmp r0,#0x2	; 0232F4D8
	beq loc_0232F51E	; 0232F4DA
	b loc_0232F524	; 0232F4DC
loc_0232F4DE:
	ldr r1,[pool_0232F58C]	; 0232F4DE
	ldrh r2,[r1,#0x0]	; 0232F4E0
	add r1,sp,#0x0	; 0232F4E2
	strh r2,[r1,#0x4]	; 0232F4E4
	ldr r2,[pool_0232F590]	; 0232F4E6
	ldrh r2,[r2,#0x0]	; 0232F4E8
	strh r2,[r1,#0x6]	; 0232F4EA
	ldr r1,[sp,#0x4]	; 0232F4EC
	lsl r2,r1,#0x14	; 0232F4EE
	lsr r2,r2,#0x14	; 0232F4F0
	ldr r3,[pool_0232F588]	; 0232F4F2
	strh r2,[r3,#0x4]	; 0232F4F4
	lsl r2,r1,#0x8	; 0232F4F6
	lsr r2,r2,#0x14	; 0232F4F8
	strh r2,[r3,#0x6]	; 0232F4FA
	lsl r2,r1,#0x7	; 0232F4FC
	lsr r2,r2,#0x1f	; 0232F4FE
	lsl r2,r2,#0x18	; 0232F500
	lsr r2,r2,#0x18	; 0232F502
	strh r2,[r3,#0x8]	; 0232F504
	lsl r1,r1,#0x5	; 0232F506
	lsr r1,r1,#0x1e	; 0232F508
	lsl r1,r1,#0x18	; 0232F50A
	lsr r1,r1,#0x18	; 0232F50C
	strh r1,[r3,#0xa]	; 0232F50E
	mov r1,#0x0	; 0232F510
	strh r1,[r3,#0x32]	; 0232F512
	b loc_0232F524	; 0232F514
loc_0232F516:
	mov r2,#0x2	; 0232F516
	ldr r1,[pool_0232F588]	; 0232F518
	strh r2,[r1,#0x32]	; 0232F51A
	b loc_0232F524	; 0232F51C
loc_0232F51E:
	mov r2,#0x0	; 0232F51E
	ldr r1,[pool_0232F588]	; 0232F520
	strh r2,[r1,#0x32]	; 0232F522
loc_0232F524:
	ldr r1,[pool_0232F588]	; 0232F524
	ldrh r3,[r1,#0x36]	; 0232F526
	mov r2,#0x1	; 0232F528
	lsl r2,r0	; 0232F52A
	bic r3,r2	; 0232F52C
	strh r3,[r1,#0x36]	; 0232F52E
	ldr r3,[r1,#0x0]	; 0232F530
	cmp r3,#0x0	; 0232F532
	beq loc_0232F57A	; 0232F534
	mov r1,#0x0	; 0232F536
	add r2,r1,#0x0	; 0232F538
	blx r3	; 0232F53A
	add sp,#0x8	; 0232F53C
	pop {r4,r5,r6}	; 0232F53E
	pop {r3}	; 0232F540
	bx r3	; 0232F542
loc_0232F544:
	mov r1,#0x3	; 0232F544
	b loc_0232F54E	; 0232F546
loc_0232F548:
	mov r1,#0x1	; 0232F548
	b loc_0232F54E	; 0232F54A
loc_0232F54C:
	mov r1,#0x2	; 0232F54C
loc_0232F54E:
	mov r4,#0x1	; 0232F54E
	lsl r4,r0	; 0232F550
	ldr r2,[pool_0232F588]	; 0232F552
	ldrh r3,[r2,#0x34]	; 0232F554
	orr r3,r4	; 0232F556
	strh r3,[r2,#0x34]	; 0232F558
	ldrh r3,[r2,#0x36]	; 0232F55A
	bic r3,r4	; 0232F55C
	strh r3,[r2,#0x36]	; 0232F55E
	ldr r3,[r2,#0x0]	; 0232F560
	cmp r3,#0x0	; 0232F562
	beq loc_0232F57A	; 0232F564
	mov r2,#0xff	; 0232F566
	and r1,r2	; 0232F568
	mov r2,#0x0	; 0232F56A
	blx r3	; 0232F56C
	add sp,#0x8	; 0232F56E
	pop {r4,r5,r6}	; 0232F570
	pop {r3}	; 0232F572
	bx r3	; 0232F574
loc_0232F576:
	bl loc_0232C150	; 0232F576
loc_0232F57A:
	add sp,#0x8	; 0232F57A
	pop {r4,r5,r6}	; 0232F57C
	pop {r3}	; 0232F57E
	bx r3	; 0232F580
	.byte 0xC0, 0x46	; 0232F584
pool_0232F584:
loc_0232F584:
	.word 0x00007F00	; 0232F584
pool_0232F588:
loc_0232F588:
	.word P1_BssStart + 0x2828C	; 0232F588
pool_0232F58C:
loc_0232F58C:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 0232F58C
pool_0232F590:
loc_0232F590:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 0232F590
pool_0232F594:
loc_0232F594:
	.word 0x01000000	; 0232F594

; ===== function loc_0232F598 =====
loc_0232F598:
	push {r4,lr}	; 0232F598
	cmp r0,#0x0	; 0232F59A
	beq loc_0232F5DE	; 0232F59C
	cmp r0,#0x1	; 0232F59E
	bne loc_0232F606	; 0232F5A0
	cmp r2,#0x0	; 0232F5A2
	bne loc_0232F5BC	; 0232F5A4
	ldr r0,[pool_0232F610]	; 0232F5A6
	ldr r2,[r0,#0x0]	; 0232F5A8
	ldr r0,[pool_0232F614]	; 0232F5AA
	ldr r0,[r0,#0x0]	; 0232F5AC
	sub r0,r2,r0	; 0232F5AE
	cmp r0,#0x7	; 0232F5B0
	bhi loc_0232F5BC	; 0232F5B2
	mov r0,#0x0	; 0232F5B4
	pop {r4}	; 0232F5B6
	pop {r3}	; 0232F5B8
	bx r3	; 0232F5BA
loc_0232F5BC:
	cmp r3,#0x0	; 0232F5BC
	beq loc_0232F5C8	; 0232F5BE
	add r0,r1,#0x0	; 0232F5C0
	bl loc_0232F7D0	; 0232F5C2
	b loc_0232F5D2	; 0232F5C6
loc_0232F5C8:
	add r0,r1,#0x0	; 0232F5C8
	mov r1,#0x0	; 0232F5CA
	add r2,r1,#0x0	; 0232F5CC
	bl loc_0232F7F0	; 0232F5CE
loc_0232F5D2:
	ldr r2,[pool_0232F618]	; 0232F5D2
	ldrh r1,[r2,#0x0]	; 0232F5D4
	mov r0,#0x1	; 0232F5D6
	orr r1,r0	; 0232F5D8
	strh r1,[r2,#0x0]	; 0232F5DA
	b loc_0232F606	; 0232F5DC
loc_0232F5DE:
	ldr r4,[pool_0232F618]	; 0232F5DE
	ldrh r2,[r4,#0x0]	; 0232F5E0
	mov r0,#0x1	; 0232F5E2
	bic r2,r0	; 0232F5E4
	strh r2,[r4,#0x0]	; 0232F5E6
	ldr r0,[pool_0232F610]	; 0232F5E8
	ldr r2,[r0,#0x0]	; 0232F5EA
	ldr r0,[pool_0232F614]	; 0232F5EC
	str r2,[r0,#0x0]	; 0232F5EE
	cmp r3,#0x0	; 0232F5F0
	beq loc_0232F5FC	; 0232F5F2
	add r0,r1,#0x0	; 0232F5F4
	bl loc_0232F7D0	; 0232F5F6
	b loc_0232F606	; 0232F5FA
loc_0232F5FC:
	add r0,r1,#0x0	; 0232F5FC
	mov r1,#0x0	; 0232F5FE
	add r2,r1,#0x0	; 0232F600
	bl loc_0232F7F0	; 0232F602
loc_0232F606:
	mov r0,#0x1	; 0232F606
	pop {r4}	; 0232F608
	pop {r3}	; 0232F60A
	bx r3	; 0232F60C
	.byte 0xC0, 0x46	; 0232F610
pool_0232F610:
loc_0232F610:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232F610
pool_0232F614:
loc_0232F614:
	.word P1_BssStart + 0x282D0	; 0232F614
pool_0232F618:
loc_0232F618:
	.word REG_POWERCNT	; 0232F618

; ===== function loc_0232F61C =====
loc_0232F61C:
	push {r4,r5,r6,r7,lr}	; 0232F61C
	sub sp,#0xc	; 0232F61E
	add r5,r0,#0x0	; 0232F620
	add r4,r1,#0x0	; 0232F622
	str r2,[sp,#0x0]	; 0232F624
	mov r6,#0x0	; 0232F626
	ldr r0,[pool_0232F6D0]	; 0232F628
	ldrh r7,[r0,#0x0]	; 0232F62A
	strh r6,[r0,#0x0]	; 0232F62C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F62E
	str r0,[sp,#0x4]	; 0232F632
	ldr r0,[pool_0232F6D4]	; 0232F634
	bl loc_0232AD1C	; 0232F636
	str r0,[sp,#0x8]	; 0232F63A
	ldr r0,[pool_0232F6D8]	; 0232F63C
	bl loc_0232AD6C	; 0232F63E
	ldr r0,[sp,#0x4]	; 0232F642
	blx P1_Arm9RestoreIrqMask	; 0232F644
	ldr r1,[pool_0232F6D0]	; 0232F648
	ldrh r0,[r1,#0x0]	; 0232F64A
	mov r0,#0x1	; 0232F64C
	strh r0,[r1,#0x0]	; 0232F64E
	mov r0,#0x10	; 0232F650
	add r1,r5,#0x0	; 0232F652
	and r1,r0	; 0232F654
	cmp r1,#0x0	; 0232F656
	beq loc_0232F666	; 0232F658
	bl loc_0232C238	; 0232F65A
	cmp r0,#0x0	; 0232F65E
	bne loc_0232F666	; 0232F660
	mov r0,#0x10	; 0232F662
	bic r5,r0	; 0232F664
loc_0232F666:
	ldr r0,[sp,#0x0]	; 0232F666
	orr r4,r0	; 0232F668
loc_0232F66A:
	lsl r0,r5,#0x10	; 0232F66A
	lsr r0,r0,#0x10	; 0232F66C
	lsl r1,r4,#0x10	; 0232F66E
	lsr r1,r1,#0x10	; 0232F670
	bl loc_0232F8F8	; 0232F672
	cmp r0,#0x0	; 0232F676
	bne loc_0232F66A	; 0232F678
	blx P1_Arm9WaitForInterrupt	; 0232F67A
	ldr r0,[pool_0232F6DC]	; 0232F67E
	blx P1_Arm9BusyWaitByLoop4	; 0232F680
	mov r0,#0x8	; 0232F684
	and r5,r0	; 0232F686
	cmp r5,#0x0	; 0232F688
	beq loc_0232F69A	; 0232F68A
	ldr r0,[pool_0232F6E0]	; 0232F68C
	ldr r1,[r0,#0x0]	; 0232F68E
	ldr r0,[pool_0232F6E4]	; 0232F690
	and r1,r0	; 0232F692
	cmp r1,#0x0	; 0232F694
	beq loc_0232F69A	; 0232F696
	mov r6,#0x1	; 0232F698
loc_0232F69A:
	cmp r6,#0x0	; 0232F69A
	bne loc_0232F6AA	; 0232F69C
	mov r0,#0x1	; 0232F69E
	add r1,r0,#0x0	; 0232F6A0
	add r2,r0,#0x0	; 0232F6A2
	mov r3,#0x0	; 0232F6A4
	bl loc_0232F598	; 0232F6A6
loc_0232F6AA:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F6AA
	ldr r0,[sp,#0x8]	; 0232F6AE
	bl loc_0232AD6C	; 0232F6B0
	ldr r0,[sp,#0x4]	; 0232F6B4
	blx P1_Arm9RestoreIrqMask	; 0232F6B6
	ldr r1,[pool_0232F6D0]	; 0232F6BA
	ldrh r0,[r1,#0x0]	; 0232F6BC
	strh r7,[r1,#0x0]	; 0232F6BE
	cmp r6,#0x0	; 0232F6C0
	beq loc_0232F6C8	; 0232F6C2
	bl loc_0232F728	; 0232F6C4
loc_0232F6C8:
	add sp,#0xc	; 0232F6C8
	pop {r4,r5,r6,r7}	; 0232F6CA
	pop {r3}	; 0232F6CC
	bx r3	; 0232F6CE
pool_0232F6D0:
loc_0232F6D0:
	.word REG_IME	; 0232F6D0
pool_0232F6D4:
loc_0232F6D4:
	.word 0x003FFFFF	; 0232F6D4
pool_0232F6D8:
loc_0232F6D8:
	.word 0x00040000	; 0232F6D8
pool_0232F6DC:
loc_0232F6DC:
	.word 0x00332340	; 0232F6DC
pool_0232F6E0:
loc_0232F6E0:
	.word REG_IF	; 0232F6E0
pool_0232F6E4:
loc_0232F6E4:
	.word 0x00100000	; 0232F6E4

; ===== function loc_0232F6E8 =====
loc_0232F6E8:
	push {r4,r5,r6,lr}	; 0232F6E8
	add r5,r0,#0x0	; 0232F6EA
	mov r4,#0x8	; 0232F6EC
	mov r6,#0x0	; 0232F6EE
loc_0232F6F0:
	add r0,r4,#0x0	; 0232F6F0
	add r1,r5,#0x0	; 0232F6F2
	add r2,r6,#0x0	; 0232F6F4
	bl loc_0232ED90	; 0232F6F6
	cmp r0,#0x0	; 0232F6FA
	bne loc_0232F6F0	; 0232F6FC
	pop {r4,r5,r6}	; 0232F6FE
	pop {r3}	; 0232F700
	bx r3	; 0232F702

; ===== function loc_0232F704 =====
loc_0232F704:
	push {r4,lr}	; 0232F704
	sub sp,#0x8	; 0232F706
	add r4,r0,#0x0	; 0232F708
	mov r0,#0x1	; 0232F70A
	add r1,sp,#0x0	; 0232F70C
	bl loc_0232F82C	; 0232F70E
	cmp r0,#0x0	; 0232F712
	bne loc_0232F720	; 0232F714
	cmp r4,#0x0	; 0232F716
	beq loc_0232F720	; 0232F718
	add r1,sp,#0x0	; 0232F71A
	ldrh r1,[r1,#0x0]	; 0232F71C
	str r1,[r4,#0x0]	; 0232F71E
loc_0232F720:
	add sp,#0x8	; 0232F720
	pop {r4}	; 0232F722
	pop {r3}	; 0232F724
	bx r3	; 0232F726

; ===== function loc_0232F728 =====
loc_0232F728:
	push {lr}	; 0232F728
	sub sp,#0x4	; 0232F72A
	ldr r0,[pool_0232F744]	; 0232F72C
	add r1,sp,#0x0	; 0232F72E
	bl loc_0232F748	; 0232F730
	cmp r0,#0x0	; 0232F734
	bne loc_0232F73E	; 0232F736
	bl loc_0232FAB4	; 0232F738
	ldr r0,[sp,#0x0]	; 0232F73C
loc_0232F73E:
	add sp,#0x4	; 0232F73E
	pop {r3}	; 0232F740
	bx r3	; 0232F742
pool_0232F744:
loc_0232F744:
	.word 0x0232FAB1	; 0232F744

; ===== function loc_0232F748 =====
loc_0232F748:
	add r3,r0,#0x0	; 0232F748
	add r2,r1,#0x0	; 0232F74A
	mov r0,#0xe	; 0232F74C
	add r1,r3,#0x0	; 0232F74E
	ldr r3,[pool_0232F754]	; 0232F750
	bx r3	; 0232F752
pool_0232F754:
loc_0232F754:
	.word loc_0232F8A4 + 1	; 0232F754

; ===== function loc_0232F758 =====
loc_0232F758:
	push {lr}	; 0232F758
	sub sp,#0x4	; 0232F75A
	ldr r2,[pool_0232F774]	; 0232F75C
	add r3,sp,#0x0	; 0232F75E
	bl loc_0232F778	; 0232F760
	cmp r0,#0x0	; 0232F764
	bne loc_0232F76E	; 0232F766
	bl loc_0232FAB4	; 0232F768
	ldr r0,[sp,#0x0]	; 0232F76C
loc_0232F76E:
	add sp,#0x4	; 0232F76E
	pop {r3}	; 0232F770
	bx r3	; 0232F772
pool_0232F774:
loc_0232F774:
	.word 0x0232FAB1	; 0232F774

; ===== function loc_0232F778 =====
loc_0232F778:
	push {r4,lr}	; 0232F778
	mov r4,#0x0	; 0232F77A
	cmp r0,#0x0	; 0232F77C
	bne loc_0232F78E	; 0232F77E
	cmp r1,#0x1	; 0232F780
	bne loc_0232F786	; 0232F782
	mov r4,#0x6	; 0232F784
loc_0232F786:
	cmp r1,#0x0	; 0232F786
	bne loc_0232F7B0	; 0232F788
	mov r4,#0x7	; 0232F78A
	b loc_0232F7B0	; 0232F78C
loc_0232F78E:
	cmp r0,#0x1	; 0232F78E
	bne loc_0232F7A0	; 0232F790
	cmp r1,#0x1	; 0232F792
	bne loc_0232F798	; 0232F794
	mov r4,#0x4	; 0232F796
loc_0232F798:
	cmp r1,#0x0	; 0232F798
	bne loc_0232F7B0	; 0232F79A
	mov r4,#0x5	; 0232F79C
	b loc_0232F7B0	; 0232F79E
loc_0232F7A0:
	cmp r0,#0x2	; 0232F7A0
	bne loc_0232F7B0	; 0232F7A2
	cmp r1,#0x1	; 0232F7A4
	bne loc_0232F7AA	; 0232F7A6
	mov r4,#0x8	; 0232F7A8
loc_0232F7AA:
	cmp r1,#0x0	; 0232F7AA
	bne loc_0232F7B0	; 0232F7AC
	mov r4,#0x9	; 0232F7AE
loc_0232F7B0:
	cmp r4,#0x0	; 0232F7B0
	beq loc_0232F7C4	; 0232F7B2
	add r0,r4,#0x0	; 0232F7B4
	add r1,r2,#0x0	; 0232F7B6
	add r2,r3,#0x0	; 0232F7B8
	bl loc_0232F8A4	; 0232F7BA
	pop {r4}	; 0232F7BE
	pop {r3}	; 0232F7C0
	bx r3	; 0232F7C2
loc_0232F7C4:
	ldr r0,[pool_0232F7CC]	; 0232F7C4
	pop {r4}	; 0232F7C6
	pop {r3}	; 0232F7C8
	bx r3	; 0232F7CA
pool_0232F7CC:
loc_0232F7CC:
	.word 0x0000FFFF	; 0232F7CC

; ===== function loc_0232F7D0 =====
loc_0232F7D0:
	push {lr}	; 0232F7D0
	sub sp,#0x4	; 0232F7D2
	ldr r1,[pool_0232F7EC]	; 0232F7D4
	add r2,sp,#0x0	; 0232F7D6
	bl loc_0232F7F0	; 0232F7D8
	cmp r0,#0x0	; 0232F7DC
	bne loc_0232F7E6	; 0232F7DE
	bl loc_0232FAB4	; 0232F7E0
	ldr r0,[sp,#0x0]	; 0232F7E4
loc_0232F7E6:
	add sp,#0x4	; 0232F7E6
	pop {r3}	; 0232F7E8
	bx r3	; 0232F7EA
pool_0232F7EC:
loc_0232F7EC:
	.word 0x0232FAB1	; 0232F7EC

; ===== function loc_0232F7F0 =====
loc_0232F7F0:
	push {lr}	; 0232F7F0
	sub sp,#0x4	; 0232F7F2
	cmp r0,#0x1	; 0232F7F4
	beq loc_0232F802	; 0232F7F6
	cmp r0,#0x2	; 0232F7F8
	beq loc_0232F80A	; 0232F7FA
	cmp r0,#0x3	; 0232F7FC
	beq loc_0232F806	; 0232F7FE
	b loc_0232F80E	; 0232F800
loc_0232F802:
	mov r0,#0x1	; 0232F802
	b loc_0232F810	; 0232F804
loc_0232F806:
	mov r0,#0x2	; 0232F806
	b loc_0232F810	; 0232F808
loc_0232F80A:
	mov r0,#0x3	; 0232F80A
	b loc_0232F810	; 0232F80C
loc_0232F80E:
	mov r0,#0x0	; 0232F80E
loc_0232F810:
	cmp r0,#0x0	; 0232F810
	beq loc_0232F81E	; 0232F812
	bl loc_0232F8A4	; 0232F814
	add sp,#0x4	; 0232F818
	pop {r3}	; 0232F81A
	bx r3	; 0232F81C
loc_0232F81E:
	ldr r0,[pool_0232F828]	; 0232F81E
	add sp,#0x4	; 0232F820
	pop {r3}	; 0232F822
	bx r3	; 0232F824
	.byte 0xC0, 0x46	; 0232F828
pool_0232F828:
loc_0232F828:
	.word 0x0000FFFF	; 0232F828

; ===== function loc_0232F82C =====
loc_0232F82C:
	push {lr}	; 0232F82C
	sub sp,#0x4	; 0232F82E
	ldr r2,[pool_0232F848]	; 0232F830
	add r3,sp,#0x0	; 0232F832
	bl loc_0232F84C	; 0232F834
	cmp r0,#0x0	; 0232F838
	bne loc_0232F842	; 0232F83A
	bl loc_0232FAB4	; 0232F83C
	ldr r0,[sp,#0x0]	; 0232F840
loc_0232F842:
	add sp,#0x4	; 0232F842
	pop {r3}	; 0232F844
	bx r3	; 0232F846
pool_0232F848:
loc_0232F848:
	.word 0x0232FAB1	; 0232F848

; ===== function loc_0232F84C =====
loc_0232F84C:
	push {r4,r5,r6,r7,lr}	; 0232F84C
	sub sp,#0x4	; 0232F84E
	add r5,r0,#0x0	; 0232F850
	add r4,r1,#0x0	; 0232F852
	add r6,r2,#0x0	; 0232F854
	add r7,r3,#0x0	; 0232F856
	bl loc_0232FAC4	; 0232F858
	cmp r0,#0x0	; 0232F85C
	bne loc_0232F86A	; 0232F85E
	mov r0,#0x1	; 0232F860
	add sp,#0x4	; 0232F862
	pop {r4,r5,r6,r7}	; 0232F864
	pop {r3}	; 0232F866
	bx r3	; 0232F868
loc_0232F86A:
	ldr r0,[pool_0232F894]	; 0232F86A
	str r6,[r0,#0x4]	; 0232F86C
	str r7,[r0,#0x8]	; 0232F86E
	lsl r2,r5,#0x3	; 0232F870
	mov r1,#0x0	; 0232F872
	ldr r0,[pool_0232F898]	; 0232F874
	strh r1,[r0,r2]	; 0232F876
	ldr r0,[pool_0232F89C]	; 0232F878
	str r4,[r0,r2]	; 0232F87A
	mov r0,#0xff	; 0232F87C
	and r5,r0	; 0232F87E
	ldr r0,[pool_0232F8A0]	; 0232F880
	orr r5,r0	; 0232F882
	add r0,r5,#0x0	; 0232F884
	bl loc_0232F6E8	; 0232F886
	mov r0,#0x0	; 0232F88A
	add sp,#0x4	; 0232F88C
	pop {r4,r5,r6,r7}	; 0232F88E
	pop {r3}	; 0232F890
	bx r3	; 0232F892
pool_0232F894:
loc_0232F894:
	.word P1_BssStart + 0x282D4	; 0232F894
pool_0232F898:
loc_0232F898:
	.word P1_BssStart + 0x282F8	; 0232F898
pool_0232F89C:
loc_0232F89C:
	.word P1_BssStart + 0x282FC	; 0232F89C
pool_0232F8A0:
loc_0232F8A0:
	.word 0x03006500	; 0232F8A0

; ===== function loc_0232F8A4 =====
loc_0232F8A4:
	push {r4,r5,r6,lr}	; 0232F8A4
	add r5,r0,#0x0	; 0232F8A6
	add r4,r1,#0x0	; 0232F8A8
	add r6,r2,#0x0	; 0232F8AA
	bl loc_0232FAC4	; 0232F8AC
	cmp r0,#0x0	; 0232F8B0
	bne loc_0232F8BC	; 0232F8B2
	mov r0,#0x1	; 0232F8B4
	pop {r4,r5,r6}	; 0232F8B6
	pop {r3}	; 0232F8B8
	bx r3	; 0232F8BA
loc_0232F8BC:
	ldr r0,[pool_0232F8E8]	; 0232F8BC
	str r4,[r0,#0x4]	; 0232F8BE
	str r6,[r0,#0x8]	; 0232F8C0
	lsr r0,r5,#0x10	; 0232F8C2
	mov r1,#0xff	; 0232F8C4
	and r0,r1	; 0232F8C6
	ldr r1,[pool_0232F8EC]	; 0232F8C8
	orr r0,r1	; 0232F8CA
	bl loc_0232F6E8	; 0232F8CC
	ldr r0,[pool_0232F8F0]	; 0232F8D0
	and r5,r0	; 0232F8D2
	ldr r0,[pool_0232F8F4]	; 0232F8D4
	orr r5,r0	; 0232F8D6
	add r0,r5,#0x0	; 0232F8D8
	bl loc_0232F6E8	; 0232F8DA
	mov r0,#0x0	; 0232F8DE
	pop {r4,r5,r6}	; 0232F8E0
	pop {r3}	; 0232F8E2
	bx r3	; 0232F8E4
	.byte 0xC0, 0x46	; 0232F8E8
pool_0232F8E8:
loc_0232F8E8:
	.word P1_BssStart + 0x282D4	; 0232F8E8
pool_0232F8EC:
loc_0232F8EC:
	.word 0x02006300	; 0232F8EC
pool_0232F8F0:
loc_0232F8F0:
	.word 0x0000FFFF	; 0232F8F0
pool_0232F8F4:
loc_0232F8F4:
	.word 0x01010000	; 0232F8F4

; ===== function loc_0232F8F8 =====
loc_0232F8F8:
	push {r4,r5,lr}	; 0232F8F8
	sub sp,#0x4	; 0232F8FA
	add r5,r0,#0x0	; 0232F8FC
	add r4,r1,#0x0	; 0232F8FE
	bl loc_0232FAC4	; 0232F900
	cmp r0,#0x0	; 0232F904
	bne loc_0232F912	; 0232F906
	mov r0,#0x1	; 0232F908
	add sp,#0x4	; 0232F90A
	pop {r4,r5}	; 0232F90C
	pop {r3}	; 0232F90E
	bx r3	; 0232F910
loc_0232F912:
	mov r1,#0x0	; 0232F912
	ldr r0,[pool_0232F960]	; 0232F914
	str r1,[r0,#0x0]	; 0232F916
	ldr r0,[pool_0232F964]	; 0232F918
	bl loc_0232F6E8	; 0232F91A
	ldr r1,[pool_0232F960]	; 0232F91E
loc_0232F920:
	ldr r0,[r1,#0x0]	; 0232F920
	cmp r0,#0x0	; 0232F922
	beq loc_0232F920	; 0232F924
	mov r0,#0x0	; 0232F926
	str r0,[r1,#0x0]	; 0232F928
	ldr r1,[pool_0232F968]	; 0232F92A
	str r0,[r1,#0x0]	; 0232F92C
	mov r1,#0x2	; 0232F92E
	add r2,r0,#0x0	; 0232F930
	add r3,r0,#0x0	; 0232F932
	bl loc_0232F598	; 0232F934
	mov r0,#0xff	; 0232F938
	and r5,r0	; 0232F93A
	ldr r0,[pool_0232F96C]	; 0232F93C
	orr r5,r0	; 0232F93E
	add r0,r5,#0x0	; 0232F940
	bl loc_0232F6E8	; 0232F942
	ldr r0,[pool_0232F970]	; 0232F946
	and r4,r0	; 0232F948
	ldr r0,[pool_0232F974]	; 0232F94A
	orr r4,r0	; 0232F94C
	add r0,r4,#0x0	; 0232F94E
	bl loc_0232F6E8	; 0232F950
	mov r0,#0x0	; 0232F954
	add sp,#0x4	; 0232F956
	pop {r4,r5}	; 0232F958
	pop {r3}	; 0232F95A
	bx r3	; 0232F95C
	.byte 0xC0, 0x46	; 0232F960
pool_0232F960:
loc_0232F960:
	.word P1_BssStart + 0x282C8	; 0232F960
pool_0232F964:
loc_0232F964:
	.word 0x03006000	; 0232F964
pool_0232F968:
loc_0232F968:
	.word P1_BssStart + 0x282CC	; 0232F968
pool_0232F96C:
loc_0232F96C:
	.word 0x02006100	; 0232F96C
pool_0232F970:
loc_0232F970:
	.word 0x0000FFFF	; 0232F970
pool_0232F974:
loc_0232F974:
	.word 0x01010000	; 0232F974

; ===== function loc_0232F978 =====
P1_PxiCallback_0232F978:
	push {lr}	; 0232F978
	sub sp,#0x4	; 0232F97A
	cmp r2,#0x0	; 0232F97C
	beq loc_0232F98C	; 0232F97E
	mov r0,#0x2	; 0232F980
	bl loc_0232FA88	; 0232F982
	add sp,#0x4	; 0232F986
	pop {r3}	; 0232F988
	bx r3	; 0232F98A
loc_0232F98C:
	ldr r0,[pool_0232F9F8]	; 0232F98C
	add r2,r1,#0x0	; 0232F98E
	and r2,r0	; 0232F990
	lsl r0,r2,#0x8	; 0232F992
	lsr r3,r0,#0x10	; 0232F994
	mov r2,#0xff	; 0232F996
	and r1,r2	; 0232F998
	lsl r0,r1,#0x10	; 0232F99A
	lsr r0,r0,#0x10	; 0232F99C
	cmp r3,#0x70	; 0232F99E
	bcc loc_0232F9C4	; 0232F9A0
	cmp r3,#0x73	; 0232F9A2
	bhi loc_0232F9C4	; 0232F9A4
	and r0,r2	; 0232F9A6
	lsl r0,r0,#0x10	; 0232F9A8
	lsr r1,r0,#0x10	; 0232F9AA
	sub r3,#0x70	; 0232F9AC
	lsl r2,r3,#0x3	; 0232F9AE
	ldr r0,[pool_0232F9FC]	; 0232F9B0
	ldr r0,[r0,r2]	; 0232F9B2
	cmp r0,#0x0	; 0232F9B4
	beq loc_0232F9BA	; 0232F9B6
	strh r1,[r0,#0x0]	; 0232F9B8
loc_0232F9BA:
	mov r1,#0x1	; 0232F9BA
	ldr r0,[pool_0232FA00]	; 0232F9BC
	strh r1,[r0,r2]	; 0232F9BE
	mov r0,#0x0	; 0232F9C0
	b loc_0232F9EC	; 0232F9C2
loc_0232F9C4:
	cmp r3,#0x60	; 0232F9C4
	bne loc_0232F9D0	; 0232F9C6
	mov r2,#0x1	; 0232F9C8
	ldr r1,[pool_0232FA04]	; 0232F9CA
	str r2,[r1,#0x0]	; 0232F9CC
	b loc_0232F9EC	; 0232F9CE
loc_0232F9D0:
	cmp r3,#0x62	; 0232F9D0
	bne loc_0232F9DC	; 0232F9D2
	mov r2,#0x1	; 0232F9D4
	ldr r1,[pool_0232FA08]	; 0232F9D6
	str r2,[r1,#0x0]	; 0232F9D8
	b loc_0232F9EC	; 0232F9DA
loc_0232F9DC:
	cmp r3,#0x67	; 0232F9DC
	bne loc_0232F9EC	; 0232F9DE
	ldr r1,[pool_0232FA0C]	; 0232F9E0
	ldr r1,[r1,#0xc]	; 0232F9E2
	cmp r1,#0x0	; 0232F9E4
	beq loc_0232F9EA	; 0232F9E6
	str r0,[r1,#0x0]	; 0232F9E8
loc_0232F9EA:
	mov r0,#0x0	; 0232F9EA
loc_0232F9EC:
	bl loc_0232FA88	; 0232F9EC
	add sp,#0x4	; 0232F9F0
	pop {r3}	; 0232F9F2
	bx r3	; 0232F9F4
	.byte 0xC0, 0x46	; 0232F9F8
pool_0232F9F8:
loc_0232F9F8:
	.word 0x00007F00	; 0232F9F8
pool_0232F9FC:
loc_0232F9FC:
	.word P1_BssStart + 0x282FC	; 0232F9FC
pool_0232FA00:
loc_0232FA00:
	.word P1_BssStart + 0x282F8	; 0232FA00
pool_0232FA04:
loc_0232FA04:
	.word P1_BssStart + 0x282C8	; 0232FA04
pool_0232FA08:
loc_0232FA08:
	.word P1_BssStart + 0x282CC	; 0232FA08
pool_0232FA0C:
loc_0232FA0C:
	.word P1_BssStart + 0x282D4	; 0232FA0C

; ===== function loc_0232FA10 =====
loc_0232FA10:
	push {r4,r5,lr}	; 0232FA10
	sub sp,#0x4	; 0232FA12
	ldr r0,[pool_0232FA6C]	; 0232FA14
	ldrh r1,[r0,#0x0]	; 0232FA16
	cmp r1,#0x0	; 0232FA18
	bne loc_0232FA62	; 0232FA1A
	mov r1,#0x1	; 0232FA1C
	strh r1,[r0,#0x0]	; 0232FA1E
	mov r1,#0x0	; 0232FA20
	ldr r0,[pool_0232FA70]	; 0232FA22
	str r1,[r0,#0x0]	; 0232FA24
	str r1,[r0,#0x4]	; 0232FA26
	bl loc_0232ECB0	; 0232FA28
	mov r5,#0x8	; 0232FA2C
	mov r4,#0x1	; 0232FA2E
loc_0232FA30:
	add r0,r5,#0x0	; 0232FA30
	add r1,r4,#0x0	; 0232FA32
	bl loc_0232EE24	; 0232FA34
	cmp r0,#0x0	; 0232FA38
	beq loc_0232FA30	; 0232FA3A
	mov r0,#0x8	; 0232FA3C
	ldr r1,[pool_0232FA74]	; 0232FA3E
	bl P1_SetPxiReceiveCallback	; 0232FA40
	mov r2,#0x0	; 0232FA44
	ldr r1,[pool_0232FA78]	; 0232FA46
	add r0,r2,#0x0	; 0232FA48
loc_0232FA4A:
	strh r0,[r1,#0x0]	; 0232FA4A
	add r1,#0x8	; 0232FA4C
	add r2,r2,#0x1	; 0232FA4E
	cmp r2,#0x4	; 0232FA50
	blt loc_0232FA4A	; 0232FA52
	ldr r0,[pool_0232FA7C]	; 0232FA54
	bl loc_0232B764	; 0232FA56
	ldr r0,[pool_0232FA80]	; 0232FA5A
	ldr r1,[r0,#0x0]	; 0232FA5C
	ldr r0,[pool_0232FA84]	; 0232FA5E
	str r1,[r0,#0x0]	; 0232FA60
loc_0232FA62:
	add sp,#0x4	; 0232FA62
	pop {r4,r5}	; 0232FA64
	pop {r3}	; 0232FA66
	bx r3	; 0232FA68
	.byte 0xC0, 0x46	; 0232FA6C
pool_0232FA6C:
loc_0232FA6C:
	.word P1_BssStart + 0x282C4	; 0232FA6C
pool_0232FA70:
loc_0232FA70:
	.word P1_BssStart + 0x282D4	; 0232FA70
pool_0232FA74:
loc_0232FA74:
	.word P1_PxiCallback_0232F978 + 1	; 0232FA74
pool_0232FA78:
loc_0232FA78:
	.word P1_BssStart + 0x282F8	; 0232FA78
pool_0232FA7C:
loc_0232FA7C:
	.word 0x02359144	; 0232FA7C
pool_0232FA80:
loc_0232FA80:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232FA80
pool_0232FA84:
loc_0232FA84:
	.word P1_BssStart + 0x282D0	; 0232FA84

; ===== function loc_0232FA88 =====
loc_0232FA88:
	push {r4,lr}	; 0232FA88
	ldr r3,[pool_0232FAAC]	; 0232FA8A
	ldr r2,[r3,#0x4]	; 0232FA8C
	ldr r1,[r3,#0x8]	; 0232FA8E
	ldr r4,[r3,#0x0]	; 0232FA90
	cmp r4,#0x0	; 0232FA92
	beq loc_0232FA9A	; 0232FA94
	mov r4,#0x0	; 0232FA96
	str r4,[r3,#0x0]	; 0232FA98
loc_0232FA9A:
	cmp r2,#0x0	; 0232FA9A
	beq loc_0232FAA6	; 0232FA9C
	mov r4,#0x0	; 0232FA9E
	ldr r3,[pool_0232FAAC]	; 0232FAA0
	str r4,[r3,#0x4]	; 0232FAA2
	blx r2	; 0232FAA4
loc_0232FAA6:
	pop {r4}	; 0232FAA6
	pop {r3}	; 0232FAA8
	bx r3	; 0232FAAA
pool_0232FAAC:
loc_0232FAAC:
	.word P1_BssStart + 0x282D4	; 0232FAAC
	str r0,[r1,#0x0]	; 0232FAB0
	bx lr	; 0232FAB2

; ===== function loc_0232FAB4 =====
loc_0232FAB4:
	ldr r1,[pool_0232FAC0]	; 0232FAB4
loc_0232FAB6:
	ldr r0,[r1,#0x0]	; 0232FAB6
	cmp r0,#0x0	; 0232FAB8
	bne loc_0232FAB6	; 0232FABA
	bx lr	; 0232FABC
	.byte 0xC0, 0x46	; 0232FAC0
pool_0232FAC0:
loc_0232FAC0:
	.word P1_BssStart + 0x282D4	; 0232FAC0

; ===== function loc_0232FAC4 =====
loc_0232FAC4:
	push {lr}	; 0232FAC4
	sub sp,#0x4	; 0232FAC6
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FAC8
	ldr r1,[pool_0232FAF0]	; 0232FACC
	ldr r2,[r1,#0x0]	; 0232FACE
	cmp r2,#0x0	; 0232FAD0
	beq loc_0232FAE0	; 0232FAD2
	blx P1_Arm9RestoreIrqMask	; 0232FAD4
	mov r0,#0x0	; 0232FAD8
	add sp,#0x4	; 0232FADA
	pop {r3}	; 0232FADC
	bx r3	; 0232FADE
loc_0232FAE0:
	mov r2,#0x1	; 0232FAE0
	str r2,[r1,#0x0]	; 0232FAE2
	blx P1_Arm9RestoreIrqMask	; 0232FAE4
	mov r0,#0x1	; 0232FAE8
	add sp,#0x4	; 0232FAEA
	pop {r3}	; 0232FAEC
	bx r3	; 0232FAEE
pool_0232FAF0:
loc_0232FAF0:
	.word P1_BssStart + 0x282D4	; 0232FAF0
.arm

; ===== function loc_0232FAF4 =====
loc_0232FAF4:
	ldr r12,[pool_0232FB08]	; 0232FAF4
loc_0232FAF8:
	ldr r0,[r12,#0x0]	; 0232FAF8
	cmp r0,#0x1	; 0232FAFC
	beq loc_0232FAF8	; 0232FB00
	bx lr	; 0232FB04
pool_0232FB08:
loc_0232FB08:
	.word P1_BssStart + 0x2831C	; 0232FB08
.thumb
	ldr r1,[pool_0232FB14]	; 0232FB0C
	str r0,[r1,#0x20]	; 0232FB0E
	bx lr	; 0232FB10
	.byte 0xC0, 0x46	; 0232FB14
pool_0232FB14:
loc_0232FB14:
	.word P1_BssStart + 0x2831C	; 0232FB14

; ===== function loc_0232FB18 =====
loc_0232FB18:
	push {r4,r5,lr}	; 0232FB18
	sub sp,#0x4	; 0232FB1A
	add r5,r0,#0x0	; 0232FB1C
	add r4,r1,#0x0	; 0232FB1E
	ldr r1,[r5,#0x0]	; 0232FB20
	cmp r1,#0x18	; 0232FB22
	bcc loc_0232FB30	; 0232FB24
	mov r0,#0x0	; 0232FB26
	add sp,#0x4	; 0232FB28
	pop {r4,r5}	; 0232FB2A
	pop {r3}	; 0232FB2C
	bx r3	; 0232FB2E
loc_0232FB30:
	ldr r0,[r5,#0x4]	; 0232FB30
	cmp r0,#0x3c	; 0232FB32
	bcc loc_0232FB40	; 0232FB34
	mov r0,#0x0	; 0232FB36
	add sp,#0x4	; 0232FB38
	pop {r4,r5}	; 0232FB3A
	pop {r3}	; 0232FB3C
	bx r3	; 0232FB3E
loc_0232FB40:
	ldr r0,[r5,#0x8]	; 0232FB40
	cmp r0,#0x3c	; 0232FB42
	bcc loc_0232FB50	; 0232FB44
	mov r0,#0x0	; 0232FB46
	add sp,#0x4	; 0232FB48
	pop {r4,r5}	; 0232FB4A
	pop {r3}	; 0232FB4C
	bx r3	; 0232FB4E
loc_0232FB50:
	cmp r1,#0xc	; 0232FB50
	bcc loc_0232FB5E	; 0232FB52
	ldr r1,[r4,#0x0]	; 0232FB54
	mov r0,#0x40	; 0232FB56
	orr r1,r0	; 0232FB58
	str r1,[r4,#0x0]	; 0232FB5A
	b loc_0232FB66	; 0232FB5C
loc_0232FB5E:
	ldr r1,[r4,#0x0]	; 0232FB5E
	mov r0,#0x40	; 0232FB60
	bic r1,r0	; 0232FB62
	str r1,[r4,#0x0]	; 0232FB64
loc_0232FB66:
	ldr r0,[r5,#0x0]	; 0232FB66
	bl loc_0232FD48	; 0232FB68
	ldr r2,[r4,#0x0]	; 0232FB6C
	mov r1,#0x3f	; 0232FB6E
	bic r2,r1	; 0232FB70
	and r0,r1	; 0232FB72
	orr r2,r0	; 0232FB74
	str r2,[r4,#0x0]	; 0232FB76
	ldr r0,[r5,#0x4]	; 0232FB78
	bl loc_0232FD48	; 0232FB7A
	ldr r2,[r4,#0x0]	; 0232FB7E
	ldr r1,[pool_0232FBB0]	; 0232FB80
	and r2,r1	; 0232FB82
	mov r1,#0x7f	; 0232FB84
	and r0,r1	; 0232FB86
	lsl r0,r0,#0x8	; 0232FB88
	orr r2,r0	; 0232FB8A
	str r2,[r4,#0x0]	; 0232FB8C
	ldr r0,[r5,#0x8]	; 0232FB8E
	bl loc_0232FD48	; 0232FB90
	ldr r2,[r4,#0x0]	; 0232FB94
	ldr r1,[pool_0232FBB4]	; 0232FB96
	and r2,r1	; 0232FB98
	mov r1,#0x7f	; 0232FB9A
	and r0,r1	; 0232FB9C
	lsl r0,r0,#0x10	; 0232FB9E
	orr r2,r0	; 0232FBA0
	str r2,[r4,#0x0]	; 0232FBA2
	mov r0,#0x1	; 0232FBA4
	add sp,#0x4	; 0232FBA6
	pop {r4,r5}	; 0232FBA8
	pop {r3}	; 0232FBAA
	bx r3	; 0232FBAC
	.byte 0xC0, 0x46	; 0232FBB0
pool_0232FBB0:
loc_0232FBB0:
	.word 0xFFFF80FF	; 0232FBB0
pool_0232FBB4:
loc_0232FBB4:
	.word 0xFF80FFFF	; 0232FBB4

; ===== function loc_0232FBB8 =====
loc_0232FBB8:
	push {r4,r5,lr}	; 0232FBB8
	sub sp,#0x4	; 0232FBBA
	add r5,r0,#0x0	; 0232FBBC
	add r4,r1,#0x0	; 0232FBBE
	ldr r0,[r5,#0x0]	; 0232FBC0
	cmp r0,#0x64	; 0232FBC2
	bcc loc_0232FBD0	; 0232FBC4
	mov r0,#0x0	; 0232FBC6
	add sp,#0x4	; 0232FBC8
	pop {r4,r5}	; 0232FBCA
	pop {r3}	; 0232FBCC
	bx r3	; 0232FBCE
loc_0232FBD0:
	ldr r1,[r5,#0x4]	; 0232FBD0
	cmp r1,#0x1	; 0232FBD2
	bcc loc_0232FBDA	; 0232FBD4
	cmp r1,#0xc	; 0232FBD6
	bls loc_0232FBE4	; 0232FBD8
loc_0232FBDA:
	mov r0,#0x0	; 0232FBDA
	add sp,#0x4	; 0232FBDC
	pop {r4,r5}	; 0232FBDE
	pop {r3}	; 0232FBE0
	bx r3	; 0232FBE2
loc_0232FBE4:
	ldr r1,[r5,#0x8]	; 0232FBE4
	cmp r1,#0x1	; 0232FBE6
	bcc loc_0232FBEE	; 0232FBE8
	cmp r1,#0x1f	; 0232FBEA
	bls loc_0232FBF8	; 0232FBEC
loc_0232FBEE:
	mov r0,#0x0	; 0232FBEE
	add sp,#0x4	; 0232FBF0
	pop {r4,r5}	; 0232FBF2
	pop {r3}	; 0232FBF4
	bx r3	; 0232FBF6
loc_0232FBF8:
	ldr r1,[r5,#0xc]	; 0232FBF8
	cmp r1,#0x7	; 0232FBFA
	blt loc_0232FC08	; 0232FBFC
	mov r0,#0x0	; 0232FBFE
	add sp,#0x4	; 0232FC00
	pop {r4,r5}	; 0232FC02
	pop {r3}	; 0232FC04
	bx r3	; 0232FC06
loc_0232FC08:
	bl loc_0232FD48	; 0232FC08
	str r0,[r4,#0x0]	; 0232FC0C
	ldr r0,[r5,#0x4]	; 0232FC0E
	bl loc_0232FD48	; 0232FC10
	ldr r2,[r4,#0x0]	; 0232FC14
	ldr r1,[pool_0232FC58]	; 0232FC16
	and r2,r1	; 0232FC18
	mov r1,#0x1f	; 0232FC1A
	and r0,r1	; 0232FC1C
	lsl r0,r0,#0x8	; 0232FC1E
	orr r2,r0	; 0232FC20
	str r2,[r4,#0x0]	; 0232FC22
	ldr r0,[r5,#0x8]	; 0232FC24
	bl loc_0232FD48	; 0232FC26
	ldr r2,[r4,#0x0]	; 0232FC2A
	ldr r1,[pool_0232FC5C]	; 0232FC2C
	and r2,r1	; 0232FC2E
	mov r1,#0x3f	; 0232FC30
	and r0,r1	; 0232FC32
	lsl r0,r0,#0x10	; 0232FC34
	orr r2,r0	; 0232FC36
	str r2,[r4,#0x0]	; 0232FC38
	ldr r2,[r4,#0x0]	; 0232FC3A
	ldr r0,[pool_0232FC60]	; 0232FC3C
	and r2,r0	; 0232FC3E
	ldr r1,[r5,#0xc]	; 0232FC40
	mov r0,#0x7	; 0232FC42
	and r1,r0	; 0232FC44
	lsl r0,r1,#0x18	; 0232FC46
	orr r2,r0	; 0232FC48
	str r2,[r4,#0x0]	; 0232FC4A
	mov r0,#0x1	; 0232FC4C
	add sp,#0x4	; 0232FC4E
	pop {r4,r5}	; 0232FC50
	pop {r3}	; 0232FC52
	bx r3	; 0232FC54
	.byte 0xC0, 0x46	; 0232FC58
pool_0232FC58:
loc_0232FC58:
	.word 0xFFFFE0FF	; 0232FC58
pool_0232FC5C:
loc_0232FC5C:
	.word 0xFFC0FFFF	; 0232FC5C
pool_0232FC60:
loc_0232FC60:
	.word 0xF8FFFFFF	; 0232FC60

; ===== function loc_0232FC64 =====
loc_0232FC64:
	push {r4,lr}	; 0232FC64
	sub sp,#0x8	; 0232FC66
	add r4,r0,#0x0	; 0232FC68
	mov r1,#0x0	; 0232FC6A
	str r1,[sp,#0x0]	; 0232FC6C
	bl loc_0232FD18	; 0232FC6E
	cmp r0,#0x0	; 0232FC72
	bne loc_0232FC80	; 0232FC74
	ldr r0,[sp,#0x0]	; 0232FC76
	add sp,#0x8	; 0232FC78
	pop {r4}	; 0232FC7A
	pop {r3}	; 0232FC7C
	bx r3	; 0232FC7E
loc_0232FC80:
	ldr r2,[sp,#0x0]	; 0232FC80
	mov r0,#0x7	; 0232FC82
	bic r2,r0	; 0232FC84
	ldr r1,[r4,#0x0]	; 0232FC86
	and r1,r0	; 0232FC88
	orr r2,r1	; 0232FC8A
	str r2,[sp,#0x0]	; 0232FC8C
	ldr r0,[r4,#0x4]	; 0232FC8E
	cmp r0,#0xc	; 0232FC90
	bcc loc_0232FC9A	; 0232FC92
	ldr r0,[pool_0232FD04]	; 0232FC94
	orr r2,r0	; 0232FC96
	str r2,[sp,#0x0]	; 0232FC98
loc_0232FC9A:
	ldr r0,[r4,#0x4]	; 0232FC9A
	bl loc_0232FD48	; 0232FC9C
	ldr r2,[sp,#0x0]	; 0232FCA0
	ldr r1,[pool_0232FD08]	; 0232FCA2
	and r2,r1	; 0232FCA4
	mov r1,#0x3f	; 0232FCA6
	and r0,r1	; 0232FCA8
	lsl r0,r0,#0x8	; 0232FCAA
	orr r2,r0	; 0232FCAC
	str r2,[sp,#0x0]	; 0232FCAE
	ldr r0,[r4,#0x8]	; 0232FCB0
	bl loc_0232FD48	; 0232FCB2
	ldr r1,[sp,#0x0]	; 0232FCB6
	ldr r2,[pool_0232FD0C]	; 0232FCB8
	and r1,r2	; 0232FCBA
	mov r2,#0x7f	; 0232FCBC
	and r0,r2	; 0232FCBE
	lsl r0,r0,#0x10	; 0232FCC0
	orr r1,r0	; 0232FCC2
	str r1,[sp,#0x0]	; 0232FCC4
	ldr r2,[r4,#0xc]	; 0232FCC6
	mov r0,#0x1	; 0232FCC8
	and r2,r0	; 0232FCCA
	cmp r2,#0x0	; 0232FCCC
	beq loc_0232FCD6	; 0232FCCE
	mov r0,#0x80	; 0232FCD0
	orr r1,r0	; 0232FCD2
	str r1,[sp,#0x0]	; 0232FCD4
loc_0232FCD6:
	ldr r1,[r4,#0xc]	; 0232FCD6
	mov r0,#0x2	; 0232FCD8
	and r1,r0	; 0232FCDA
	cmp r1,#0x0	; 0232FCDC
	beq loc_0232FCE8	; 0232FCDE
	ldr r1,[sp,#0x0]	; 0232FCE0
	ldr r0,[pool_0232FD10]	; 0232FCE2
	orr r1,r0	; 0232FCE4
	str r1,[sp,#0x0]	; 0232FCE6
loc_0232FCE8:
	ldr r1,[r4,#0xc]	; 0232FCE8
	mov r0,#0x4	; 0232FCEA
	and r1,r0	; 0232FCEC
	cmp r1,#0x0	; 0232FCEE
	beq loc_0232FCFA	; 0232FCF0
	ldr r1,[sp,#0x0]	; 0232FCF2
	ldr r0,[pool_0232FD14]	; 0232FCF4
	orr r1,r0	; 0232FCF6
	str r1,[sp,#0x0]	; 0232FCF8
loc_0232FCFA:
	ldr r0,[sp,#0x0]	; 0232FCFA
	add sp,#0x8	; 0232FCFC
	pop {r4}	; 0232FCFE
	pop {r3}	; 0232FD00
	bx r3	; 0232FD02
pool_0232FD04:
loc_0232FD04:
	.word 0x00004000	; 0232FD04
pool_0232FD08:
loc_0232FD08:
	.word 0xFFFFC0FF	; 0232FD08
pool_0232FD0C:
loc_0232FD0C:
	.word 0xFF80FFFF	; 0232FD0C
pool_0232FD10:
loc_0232FD10:
	.word 0x00008000	; 0232FD10
pool_0232FD14:
loc_0232FD14:
	.word 0x00800000	; 0232FD14

; ===== function loc_0232FD18 =====
loc_0232FD18:
	ldr r1,[r0,#0x0]	; 0232FD18
	cmp r1,#0x7	; 0232FD1A
	blt loc_0232FD22	; 0232FD1C
	mov r0,#0x0	; 0232FD1E
	bx lr	; 0232FD20
loc_0232FD22:
	ldr r1,[r0,#0x4]	; 0232FD22
	cmp r1,#0x18	; 0232FD24
	bcc loc_0232FD2C	; 0232FD26
	mov r0,#0x0	; 0232FD28
	bx lr	; 0232FD2A
loc_0232FD2C:
	ldr r1,[r0,#0x8]	; 0232FD2C
	cmp r1,#0x3c	; 0232FD2E
	bcc loc_0232FD36	; 0232FD30
	mov r0,#0x0	; 0232FD32
	bx lr	; 0232FD34
loc_0232FD36:
	ldr r1,[r0,#0xc]	; 0232FD36
	mov r0,#0x7	; 0232FD38
	bic r1,r0	; 0232FD3A
	cmp r1,#0x0	; 0232FD3C
	bne loc_0232FD44	; 0232FD3E
	mov r0,#0x1	; 0232FD40
	bx lr	; 0232FD42
loc_0232FD44:
	mov r0,#0x0	; 0232FD44
	bx lr	; 0232FD46

; ===== function loc_0232FD48 =====
loc_0232FD48:
	push {r4,r5,r6,r7,lr}	; 0232FD48
	sub sp,#0x4	; 0232FD4A
	add r5,r0,#0x0	; 0232FD4C
	mov r6,#0x0	; 0232FD4E
	ldr r0,[pool_0232FD8C]	; 0232FD50
	cmp r5,r0	; 0232FD52
	bls loc_0232FD60	; 0232FD54
	add r0,r6,#0x0	; 0232FD56
	add sp,#0x4	; 0232FD58
	pop {r4,r5,r6,r7}	; 0232FD5A
	pop {r3}	; 0232FD5C
	bx r3	; 0232FD5E
loc_0232FD60:
	add r7,r6,#0x0	; 0232FD60
	add r4,r6,#0x0	; 0232FD62
loc_0232FD64:
	add r0,r5,#0x0	; 0232FD64
	mov r1,#0xa	; 0232FD66
	blx P1_UnsignedDivMod	; 0232FD68
	lsl r1,r4	; 0232FD6C
	add r6,r6,r1	; 0232FD6E
	add r0,r5,#0x0	; 0232FD70
	mov r1,#0xa	; 0232FD72
	blx P1_UnsignedDivMod	; 0232FD74
	add r5,r0,#0x0	; 0232FD78
	add r4,r4,#0x4	; 0232FD7A
	add r7,r7,#0x1	; 0232FD7C
	cmp r7,#0x8	; 0232FD7E
	blt loc_0232FD64	; 0232FD80
	add r0,r6,#0x0	; 0232FD82
	add sp,#0x4	; 0232FD84
	pop {r4,r5,r6,r7}	; 0232FD86
	pop {r3}	; 0232FD88
	bx r3	; 0232FD8A
pool_0232FD8C:
loc_0232FD8C:
	.word 0x05F5E0FF	; 0232FD8C

; ===== function loc_0232FD90 =====
loc_0232FD90:
	push {r4,r5,r6,r7}	; 0232FD90
	mov r4,#0x0	; 0232FD92
	add r5,r4,#0x0	; 0232FD94
	add r3,r4,#0x0	; 0232FD96
	mov r1,#0xf	; 0232FD98
loc_0232FD9A:
	add r2,r0,#0x0	; 0232FD9A
	lsr r2,r3	; 0232FD9C
	and r2,r1	; 0232FD9E
	cmp r2,#0xa	; 0232FDA0
	bcc loc_0232FDAA	; 0232FDA2
	mov r0,#0x0	; 0232FDA4
	pop {r4,r5,r6,r7}	; 0232FDA6
	bx lr	; 0232FDA8
loc_0232FDAA:
	add r3,r3,#0x4	; 0232FDAA
	add r5,r5,#0x1	; 0232FDAC
	cmp r5,#0x8	; 0232FDAE
	blt loc_0232FD9A	; 0232FDB0
	mov r1,#0x0	; 0232FDB2
	mov r3,#0x1	; 0232FDB4
	add r2,r1,#0x0	; 0232FDB6
	mov r6,#0xa	; 0232FDB8
loc_0232FDBA:
	add r7,r0,#0x0	; 0232FDBA
	lsr r7,r2	; 0232FDBC
	mov r5,#0xf	; 0232FDBE
	and r7,r5	; 0232FDC0
	add r5,r3,#0x0	; 0232FDC2
	mul r5,r7	; 0232FDC4
	add r4,r4,r5	; 0232FDC6
	add r2,r2,#0x4	; 0232FDC8
	add r1,r1,#0x1	; 0232FDCA
	mul r3,r6	; 0232FDCC
	cmp r1,#0x8	; 0232FDCE
	blt loc_0232FDBA	; 0232FDD0
	add r0,r4,#0x0	; 0232FDD2
	pop {r4,r5,r6,r7}	; 0232FDD4
	bx lr	; 0232FDD6

; ===== function loc_0232FDD8 =====
P1_PxiCallback_0232FDD8:
	push {r4,r5,lr}	; 0232FDD8
	sub sp,#0x4	; 0232FDDA
	cmp r2,#0x0	; 0232FDDC
	beq loc_0232FE14	; 0232FDDE
	ldr r0,[pool_023300B4]	; 0232FDE0
	ldr r1,[r0,#0x18]	; 0232FDE2
	cmp r1,#0x0	; 0232FDE4
	beq loc_0232FDEC	; 0232FDE6
	mov r1,#0x0	; 0232FDE8
	str r1,[r0,#0x18]	; 0232FDEA
loc_0232FDEC:
	ldr r0,[pool_023300B4]	; 0232FDEC
	ldr r1,[r0,#0x0]	; 0232FDEE
	cmp r1,#0x0	; 0232FDF0
	beq loc_0232FDF8	; 0232FDF2
	mov r1,#0x0	; 0232FDF4
	str r1,[r0,#0x0]	; 0232FDF6
loc_0232FDF8:
	ldr r1,[pool_023300B4]	; 0232FDF8
	ldr r2,[r1,#0x4]	; 0232FDFA
	cmp r2,#0x0	; 0232FDFC
	bne loc_0232FE02	; 0232FDFE
	b loc_023300AC	; 0232FE00
loc_0232FE02:
	mov r0,#0x0	; 0232FE02
	str r0,[r1,#0x4]	; 0232FE04
	mov r0,#0x6	; 0232FE06
	ldr r1,[r1,#0x10]	; 0232FE08
	blx r2	; 0232FE0A
	add sp,#0x4	; 0232FE0C
	pop {r4,r5}	; 0232FE0E
	pop {r3}	; 0232FE10
	bx r3	; 0232FE12
loc_0232FE14:
	mov r2,#0xff	; 0232FE14
	add r0,r1,#0x0	; 0232FE16
	and r0,r2	; 0232FE18
	ldr r3,[pool_023300B8]	; 0232FE1A
	and r1,r3	; 0232FE1C
	lsr r1,r1,#0x8	; 0232FE1E
	lsl r1,r1,#0x18	; 0232FE20
	lsr r1,r1,#0x18	; 0232FE22
	cmp r1,#0x30	; 0232FE24
	bne loc_0232FE3C	; 0232FE26
	ldr r0,[pool_023300B4]	; 0232FE28
	ldr r0,[r0,#0x1c]	; 0232FE2A
	cmp r0,#0x0	; 0232FE2C
	bne loc_0232FE32	; 0232FE2E
	b loc_023300AC	; 0232FE30
loc_0232FE32:
	blx r0	; 0232FE32
	add sp,#0x4	; 0232FE34
	pop {r4,r5}	; 0232FE36
	pop {r3}	; 0232FE38
	bx r3	; 0232FE3A
loc_0232FE3C:
	cmp r0,#0x0	; 0232FE3C
	beq loc_0232FE42	; 0232FE3E
	b loc_02330058	; 0232FE40
loc_0232FE42:
	mov r4,#0x0	; 0232FE42
	ldr r0,[pool_023300B4]	; 0232FE44
	ldr r1,[r0,#0x14]	; 0232FE46
	cmp r1,#0xf	; 0232FE48
	bls loc_0232FE4E	; 0232FE4A
	b loc_0233004E	; 0232FE4C
loc_0232FE4E:
	add r1,r1,r1	; 0232FE4E
P1_SwitchIndexPC_0232FE4E:
	add r1,pc	; 0232FE50
	ldrh r1,[r1,#(P1_SwitchTable_0232FE4E - (P1_SwitchIndexPC_0232FE4E + 4))]	; 0232FE52
	lsl r1,r1,#0x10	; 0232FE54
	asr r1,r1,#0x10	; 0232FE56
P1_SwitchTargetPC_0232FE4E:
	add r1,pc	; 0232FE58
	bx r1	; 0232FE5A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232FE4E:
	.halfword (loc_0233004E + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_0233004E + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_0232FE7C + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_0233004E + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_0233004E + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_02330088 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_0232FEE0 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_0232FEF8 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_0232FF10 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_0232FF7E + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_0232FFE8 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_02330088 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_02330088 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_02330088 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_02330088 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
	.halfword (loc_02330088 + 1) - (P1_SwitchTargetPC_0232FE4E + 4)
P1_SwitchTable_0232FE4EEnd:
loc_0232FE7C:
	ldr r5,[r0,#0x8]	; 0232FE7C
	ldr r0,[pool_023300BC]	; 0232FE7E
	ldr r0,[r0,#0x0]	; 0232FE80
	and r0,r2	; 0232FE82
	bl loc_0232FD90	; 0232FE84
	str r0,[r5,#0x0]	; 0232FE88
	ldr r0,[pool_023300BC]	; 0232FE8A
	ldr r0,[r0,#0x0]	; 0232FE8C
	lsl r0,r0,#0x13	; 0232FE8E
	lsr r0,r0,#0x1b	; 0232FE90
	bl loc_0232FD90	; 0232FE92
	str r0,[r5,#0x4]	; 0232FE96
	ldr r0,[pool_023300BC]	; 0232FE98
	ldr r0,[r0,#0x0]	; 0232FE9A
	lsl r0,r0,#0xa	; 0232FE9C
	lsr r0,r0,#0x1a	; 0232FE9E
	bl loc_0232FD90	; 0232FEA0
	str r0,[r5,#0x8]	; 0232FEA4
	ldr r0,[pool_023300BC]	; 0232FEA6
	ldr r0,[r0,#0x0]	; 0232FEA8
	lsl r0,r0,#0x5	; 0232FEAA
	lsr r0,r0,#0x1d	; 0232FEAC
	str r0,[r5,#0xc]	; 0232FEAE
	ldr r0,[pool_023300B4]	; 0232FEB0
	ldr r5,[r0,#0xc]	; 0232FEB2
	ldr r0,[pool_023300C0]	; 0232FEB4
	ldr r0,[r0,#0x0]	; 0232FEB6
	lsl r0,r0,#0x1a	; 0232FEB8
	lsr r0,r0,#0x1a	; 0232FEBA
	bl loc_0232FD90	; 0232FEBC
	str r0,[r5,#0x0]	; 0232FEC0
	ldr r0,[pool_023300C0]	; 0232FEC2
	ldr r0,[r0,#0x0]	; 0232FEC4
	lsl r0,r0,#0x11	; 0232FEC6
	lsr r0,r0,#0x19	; 0232FEC8
	bl loc_0232FD90	; 0232FECA
	str r0,[r5,#0x4]	; 0232FECE
	ldr r0,[pool_023300C0]	; 0232FED0
	ldr r0,[r0,#0x0]	; 0232FED2
	lsl r0,r0,#0x9	; 0232FED4
	lsr r0,r0,#0x19	; 0232FED6
	bl loc_0232FD90	; 0232FED8
	str r0,[r5,#0x8]	; 0232FEDC
	b loc_02330088	; 0232FEDE
loc_0232FEE0:
	ldr r1,[r0,#0x8]	; 0232FEE0
	ldr r0,[pool_023300C4]	; 0232FEE2
	ldrh r0,[r0,#0x0]	; 0232FEE4
	lsl r0,r0,#0x1c	; 0232FEE6
	lsr r0,r0,#0x1c	; 0232FEE8
	cmp r0,#0x4	; 0232FEEA
	bne loc_0232FEF4	; 0232FEEC
	mov r0,#0x1	; 0232FEEE
	str r0,[r1,#0x0]	; 0232FEF0
	b loc_02330088	; 0232FEF2
loc_0232FEF4:
	str r4,[r1,#0x0]	; 0232FEF4
	b loc_02330088	; 0232FEF6
loc_0232FEF8:
	ldr r1,[r0,#0x8]	; 0232FEF8
	ldr r0,[pool_023300C4]	; 0232FEFA
	ldrh r0,[r0,#0x0]	; 0232FEFC
	lsl r0,r0,#0x19	; 0232FEFE
	lsr r0,r0,#0x1f	; 0232FF00
	cmp r0,#0x0	; 0232FF02
	beq loc_0232FF0C	; 0232FF04
	mov r0,#0x1	; 0232FF06
	str r0,[r1,#0x0]	; 0232FF08
	b loc_02330088	; 0232FF0A
loc_0232FF0C:
	str r4,[r1,#0x0]	; 0232FF0C
	b loc_02330088	; 0232FF0E
loc_0232FF10:
	ldr r5,[r0,#0x8]	; 0232FF10
	ldr r1,[pool_023300C0]	; 0232FF12
	ldr r0,[r1,#0x0]	; 0232FF14
	lsl r0,r0,#0x1d	; 0232FF16
	lsr r0,r0,#0x1d	; 0232FF18
	str r0,[r5,#0x0]	; 0232FF1A
	ldr r0,[r1,#0x0]	; 0232FF1C
	lsl r0,r0,#0x12	; 0232FF1E
	lsr r0,r0,#0x1a	; 0232FF20
	bl loc_0232FD90	; 0232FF22
	str r0,[r5,#0x4]	; 0232FF26
	ldr r0,[pool_023300C0]	; 0232FF28
	ldr r0,[r0,#0x0]	; 0232FF2A
	lsl r0,r0,#0x9	; 0232FF2C
	lsr r0,r0,#0x19	; 0232FF2E
	bl loc_0232FD90	; 0232FF30
	str r0,[r5,#0x8]	; 0232FF34
	lsl r0,r4,#0	; 0232FF36
	str r0,[r5,#0xc]	; 0232FF38
	ldr r0,[pool_023300C0]	; 0232FF3A
	ldr r0,[r0,#0x0]	; 0232FF3C
	lsl r0,r0,#0x18	; 0232FF3E
	lsr r0,r0,#0x1f	; 0232FF40
	cmp r0,#0x0	; 0232FF42
	beq loc_0232FF50	; 0232FF44
	add r1,r5,#0x0	; 0232FF46
	add r1,#0xc	; 0232FF48
	ldr r0,[r1,#0x0]	; 0232FF4A
	add r0,r0,#0x1	; 0232FF4C
	str r0,[r1,#0x0]	; 0232FF4E
loc_0232FF50:
	ldr r0,[pool_023300C0]	; 0232FF50
	ldr r0,[r0,#0x0]	; 0232FF52
	lsl r0,r0,#0x10	; 0232FF54
	lsr r0,r0,#0x1f	; 0232FF56
	cmp r0,#0x0	; 0232FF58
	beq loc_0232FF66	; 0232FF5A
	add r1,r5,#0x0	; 0232FF5C
	add r1,#0xc	; 0232FF5E
	ldr r0,[r1,#0x0]	; 0232FF60
	add r0,r0,#0x2	; 0232FF62
	str r0,[r1,#0x0]	; 0232FF64
loc_0232FF66:
	ldr r0,[pool_023300C0]	; 0232FF66
	ldr r0,[r0,#0x0]	; 0232FF68
	lsl r0,r0,#0x8	; 0232FF6A
	lsr r0,r0,#0x1f	; 0232FF6C
	cmp r0,#0x0	; 0232FF6E
	bne loc_0232FF74	; 0232FF70
	b loc_02330088	; 0232FF72
loc_0232FF74:
	add r5,#0xc	; 0232FF74
	ldr r0,[r5,#0x0]	; 0232FF76
	add r0,r0,#0x4	; 0232FF78
	str r0,[r5,#0x0]	; 0232FF7A
	b loc_02330088	; 0232FF7C
loc_0232FF7E:
	ldr r2,[r0,#0x18]	; 0232FF7E
	cmp r2,#0x0	; 0232FF80
	bne loc_0232FFE4	; 0232FF82
	ldr r1,[r0,#0x8]	; 0232FF84
	ldr r1,[r1,#0x0]	; 0232FF86
	cmp r1,#0x1	; 0232FF88
	bne loc_0232FFBA	; 0232FF8A
	ldr r1,[pool_023300C4]	; 0232FF8C
	ldrh r3,[r1,#0x0]	; 0232FF8E
	lsl r3,r3,#0x1c	; 0232FF90
	lsr r3,r3,#0x1c	; 0232FF92
	cmp r3,#0x4	; 0232FF94
	beq loc_02330088	; 0232FF96
	add r2,r2,#0x1	; 0232FF98
	str r2,[r0,#0x18]	; 0232FF9A
	ldrh r2,[r1,#0x0]	; 0232FF9C
	mov r0,#0xf	; 0232FF9E
	bic r2,r0	; 0232FFA0
	mov r0,#0x4	; 0232FFA2
	orr r2,r0	; 0232FFA4
	strh r2,[r1,#0x0]	; 0232FFA6
	bl loc_023304BC	; 0232FFA8
	cmp r0,#0x0	; 0232FFAC
	bne loc_02330088	; 0232FFAE
	lsl r1,r4,#0	; 0232FFB0
	ldr r0,[pool_023300B4]	; 0232FFB2
	str r1,[r0,#0x18]	; 0232FFB4
	mov r4,#0x3	; 0232FFB6
	b loc_02330088	; 0232FFB8
loc_0232FFBA:
	ldr r1,[pool_023300C4]	; 0232FFBA
	ldrh r3,[r1,#0x0]	; 0232FFBC
	lsl r3,r3,#0x1c	; 0232FFBE
	lsr r3,r3,#0x1c	; 0232FFC0
	cmp r3,#0x0	; 0232FFC2
	beq loc_02330088	; 0232FFC4
	add r2,r2,#0x1	; 0232FFC6
	str r2,[r0,#0x18]	; 0232FFC8
	ldrh r2,[r1,#0x0]	; 0232FFCA
	mov r0,#0xf	; 0232FFCC
	bic r2,r0	; 0232FFCE
	strh r2,[r1,#0x0]	; 0232FFD0
	bl loc_023304BC	; 0232FFD2
	cmp r0,#0x0	; 0232FFD6
	bne loc_02330088	; 0232FFD8
	lsl r1,r4,#0	; 0232FFDA
	ldr r0,[pool_023300B4]	; 0232FFDC
	str r1,[r0,#0x18]	; 0232FFDE
	mov r4,#0x3	; 0232FFE0
	b loc_02330088	; 0232FFE2
loc_0232FFE4:
	str r4,[r0,#0x18]	; 0232FFE4
	b loc_02330088	; 0232FFE6
loc_0232FFE8:
	ldr r2,[r0,#0x18]	; 0232FFE8
	cmp r2,#0x0	; 0232FFEA
	bne loc_0233004A	; 0232FFEC
	ldr r1,[r0,#0x8]	; 0232FFEE
	ldr r1,[r1,#0x0]	; 0232FFF0
	cmp r1,#0x1	; 0232FFF2
	bne loc_02330020	; 0232FFF4
	ldr r1,[pool_023300C4]	; 0232FFF6
	ldrh r3,[r1,#0x0]	; 0232FFF8
	lsl r3,r3,#0x19	; 0232FFFA
	lsr r3,r3,#0x1f	; 0232FFFC
	cmp r3,#0x0	; 0232FFFE
	bne loc_02330088	; 02330000
	add r2,r2,#0x1	; 02330002
	str r2,[r0,#0x18]	; 02330004
	ldrh r2,[r1,#0x0]	; 02330006
	mov r0,#0x40	; 02330008
	orr r2,r0	; 0233000A
	strh r2,[r1,#0x0]	; 0233000C
	bl loc_023304BC	; 0233000E
	cmp r0,#0x0	; 02330012
	bne loc_02330088	; 02330014
	lsl r1,r4,#0	; 02330016
	ldr r0,[pool_023300B4]	; 02330018
	str r1,[r0,#0x18]	; 0233001A
	mov r4,#0x3	; 0233001C
	b loc_02330088	; 0233001E
loc_02330020:
	ldr r1,[pool_023300C4]	; 02330020
	ldrh r3,[r1,#0x0]	; 02330022
	lsl r3,r3,#0x19	; 02330024
	lsr r3,r3,#0x1f	; 02330026
	cmp r3,#0x0	; 02330028
	beq loc_02330088	; 0233002A
	add r2,r2,#0x1	; 0233002C
	str r2,[r0,#0x18]	; 0233002E
	ldrh r2,[r1,#0x0]	; 02330030
	mov r0,#0x40	; 02330032
	bic r2,r0	; 02330034
	strh r2,[r1,#0x0]	; 02330036
	bl loc_023304BC	; 02330038
	cmp r0,#0x0	; 0233003C
	bne loc_02330088	; 0233003E
	lsl r1,r4,#0	; 02330040
	ldr r0,[pool_023300B4]	; 02330042
	str r1,[r0,#0x18]	; 02330044
	mov r4,#0x3	; 02330046
	b loc_02330088	; 02330048
loc_0233004A:
	str r4,[r0,#0x18]	; 0233004A
	b loc_02330088	; 0233004C
loc_0233004E:
	mov r4,#0x4	; 0233004E
	mov r1,#0x0	; 02330050
	ldr r0,[pool_023300B4]	; 02330052
	str r1,[r0,#0x18]	; 02330054
	b loc_02330088	; 02330056
loc_02330058:
	mov r2,#0x0	; 02330058
	ldr r1,[pool_023300B4]	; 0233005A
	str r2,[r1,#0x18]	; 0233005C
	cmp r0,#0x4	; 0233005E
	bhi loc_02330086	; 02330060
	add r0,r0,r0	; 02330062
P1_SwitchIndexPC_02330062:
	add r0,pc	; 02330064
	ldrh r0,[r0,#(P1_SwitchTable_02330062 - (P1_SwitchIndexPC_02330062 + 4))]	; 02330066
	lsl r0,r0,#0x10	; 02330068
	asr r0,r0,#0x10	; 0233006A
P1_SwitchTargetPC_02330062:
	add r0,pc	; 0233006C
	bx r0	; 0233006E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02330062:
	.halfword (loc_02330086 + 1) - (P1_SwitchTargetPC_02330062 + 4)
	.halfword (loc_0233007A + 1) - (P1_SwitchTargetPC_02330062 + 4)
	.halfword (loc_0233007E + 1) - (P1_SwitchTargetPC_02330062 + 4)
	.halfword (loc_02330082 + 1) - (P1_SwitchTargetPC_02330062 + 4)
	.halfword (loc_02330086 + 1) - (P1_SwitchTargetPC_02330062 + 4)
P1_SwitchTable_02330062End:
loc_0233007A:
	mov r4,#0x4	; 0233007A
	b loc_02330088	; 0233007C
loc_0233007E:
	mov r4,#0x5	; 0233007E
	b loc_02330088	; 02330080
loc_02330082:
	mov r4,#0x1	; 02330082
	b loc_02330088	; 02330084
loc_02330086:
	mov r4,#0x6	; 02330086
loc_02330088:
	ldr r0,[pool_023300B4]	; 02330088
	ldr r1,[r0,#0x18]	; 0233008A
	cmp r1,#0x0	; 0233008C
	bne loc_023300AC	; 0233008E
	ldr r1,[r0,#0x0]	; 02330090
	cmp r1,#0x0	; 02330092
	beq loc_0233009A	; 02330094
	mov r1,#0x0	; 02330096
	str r1,[r0,#0x0]	; 02330098
loc_0233009A:
	ldr r1,[pool_023300B4]	; 0233009A
	ldr r2,[r1,#0x4]	; 0233009C
	cmp r2,#0x0	; 0233009E
	beq loc_023300AC	; 023300A0
	mov r0,#0x0	; 023300A2
	str r0,[r1,#0x4]	; 023300A4
	add r0,r4,#0x0	; 023300A6
	ldr r1,[r1,#0x10]	; 023300A8
	blx r2	; 023300AA
loc_023300AC:
	add sp,#0x4	; 023300AC
	pop {r4,r5}	; 023300AE
	pop {r3}	; 023300B0
	bx r3	; 023300B2
pool_023300B4:
loc_023300B4:
	.word P1_BssStart + 0x2831C	; 023300B4
pool_023300B8:
loc_023300B8:
	.word 0x00007F00	; 023300B8
pool_023300BC:
loc_023300BC:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset	; 023300BC
pool_023300C0:
loc_023300C0:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 023300C0
pool_023300C4:
loc_023300C4:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x2	; 023300C4

; ===== function loc_023300C8 =====
loc_023300C8:
	push {lr}	; 023300C8
	sub sp,#0x4	; 023300CA
	ldr r2,[pool_023300EC]	; 023300CC
	mov r3,#0x0	; 023300CE
	bl loc_023300F4	; 023300D0
	ldr r1,[pool_023300F0]	; 023300D4
	str r0,[r1,#0x20]	; 023300D6
	cmp r0,#0x0	; 023300D8
	bne loc_023300E0	; 023300DA
	blx loc_0232FAF4	; 023300DC
loc_023300E0:
	ldr r0,[pool_023300F0]	; 023300E0
	ldr r0,[r0,#0x20]	; 023300E2
	add sp,#0x4	; 023300E4
	pop {r3}	; 023300E6
	bx r3	; 023300E8
	.byte 0xC0, 0x46	; 023300EC
pool_023300EC:
loc_023300EC:
	.word 0x0232FB0D	; 023300EC
pool_023300F0:
loc_023300F0:
	.word P1_BssStart + 0x2831C	; 023300F0

; ===== function loc_023300F4 =====
loc_023300F4:
	push {r4,r5,r6,r7,lr}	; 023300F4
	sub sp,#0xc	; 023300F6
	add r5,r0,#0x0	; 023300F8
	add r6,r1,#0x0	; 023300FA
	add r7,r2,#0x0	; 023300FC
	str r3,[sp,#0x0]	; 023300FE
	mov r4,#0x0	; 02330100
	cmp r5,#0x2	; 02330102
	blt loc_02330110	; 02330104
	mov r0,#0x2	; 02330106
	add sp,#0xc	; 02330108
	pop {r4,r5,r6,r7}	; 0233010A
	pop {r3}	; 0233010C
	bx r3	; 0233010E
loc_02330110:
	add r0,r6,#0x0	; 02330110
	bl loc_0232FD18	; 02330112
	cmp r0,#0x0	; 02330116
	bne loc_02330124	; 02330118
	mov r0,#0x2	; 0233011A
	add sp,#0xc	; 0233011C
	pop {r4,r5,r6,r7}	; 0233011E
	pop {r3}	; 02330120
	bx r3	; 02330122
loc_02330124:
	blx P1_Arm9DisableIrqReturnPriorMask	; 02330124
	ldr r1,[pool_0233019C]	; 02330128
	ldr r2,[r1,#0x0]	; 0233012A
	cmp r2,#0x0	; 0233012C
	beq loc_0233013E	; 0233012E
	blx P1_Arm9RestoreIrqMask	; 02330130
	mov r0,#0x1	; 02330134
	add sp,#0xc	; 02330136
	pop {r4,r5,r6,r7}	; 02330138
	pop {r3}	; 0233013A
	bx r3	; 0233013C
loc_0233013E:
	mov r2,#0x1	; 0233013E
	str r2,[r1,#0x0]	; 02330140
	blx P1_Arm9RestoreIrqMask	; 02330142
	lsl r0,r4,#0	; 02330146
	ldr r1,[pool_0233019C]	; 02330148
	str r0,[r1,#0x18]	; 0233014A
	str r7,[r1,#0x4]	; 0233014C
	ldr r0,[sp,#0x0]	; 0233014E
	str r0,[r1,#0x10]	; 02330150
	add r0,r6,#0x0	; 02330152
	bl loc_0232FC64	; 02330154
	str r0,[sp,#0x4]	; 02330158
	ldr r1,[pool_023301A0]	; 0233015A
	str r0,[r1,#0x0]	; 0233015C
	cmp r5,#0x0	; 0233015E
	beq loc_02330168	; 02330160
	cmp r5,#0x1	; 02330162
	beq loc_02330176	; 02330164
	b loc_02330182	; 02330166
loc_02330168:
	mov r1,#0xb	; 02330168
	ldr r0,[pool_0233019C]	; 0233016A
	str r1,[r0,#0x14]	; 0233016C
	bl loc_023304E0	; 0233016E
	add r4,r0,#0x0	; 02330172
	b loc_02330182	; 02330174
loc_02330176:
	mov r1,#0xc	; 02330176
	ldr r0,[pool_0233019C]	; 02330178
	str r1,[r0,#0x14]	; 0233017A
	bl loc_023304D4	; 0233017C
	add r4,r0,#0x0	; 02330180
loc_02330182:
	cmp r4,#0x0	; 02330182
	beq loc_02330190	; 02330184
	mov r0,#0x0	; 02330186
	add sp,#0xc	; 02330188
	pop {r4,r5,r6,r7}	; 0233018A
	pop {r3}	; 0233018C
	bx r3	; 0233018E
loc_02330190:
	mov r0,#0x3	; 02330190
	add sp,#0xc	; 02330192
	pop {r4,r5,r6,r7}	; 02330194
	pop {r3}	; 02330196
	bx r3	; 02330198
	.byte 0xC0, 0x46	; 0233019C
pool_0233019C:
loc_0233019C:
	.word P1_BssStart + 0x2831C	; 0233019C
pool_023301A0:
loc_023301A0:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 023301A0

; ===== function loc_023301A4 =====
loc_023301A4:
	push {lr}	; 023301A4
	sub sp,#0x4	; 023301A6
	ldr r2,[pool_023301C8]	; 023301A8
	mov r3,#0x0	; 023301AA
	bl loc_023301D0	; 023301AC
	ldr r1,[pool_023301CC]	; 023301B0
	str r0,[r1,#0x20]	; 023301B2
	cmp r0,#0x0	; 023301B4
	bne loc_023301BC	; 023301B6
	blx loc_0232FAF4	; 023301B8
loc_023301BC:
	ldr r0,[pool_023301CC]	; 023301BC
	ldr r0,[r0,#0x20]	; 023301BE
	add sp,#0x4	; 023301C0
	pop {r3}	; 023301C2
	bx r3	; 023301C4
	.byte 0xC0, 0x46	; 023301C8
pool_023301C8:
loc_023301C8:
	.word 0x0232FB0D	; 023301C8
pool_023301CC:
loc_023301CC:
	.word P1_BssStart + 0x2831C	; 023301CC

; ===== function loc_023301D0 =====
loc_023301D0:
	push {r4,r5,r6,r7,lr}	; 023301D0
	sub sp,#0x4	; 023301D2
	add r5,r0,#0x0	; 023301D4
	add r4,r1,#0x0	; 023301D6
	add r6,r2,#0x0	; 023301D8
	add r7,r3,#0x0	; 023301DA
	cmp r5,#0x2	; 023301DC
	blt loc_023301EA	; 023301DE
	mov r0,#0x2	; 023301E0
	add sp,#0x4	; 023301E2
	pop {r4,r5,r6,r7}	; 023301E4
	pop {r3}	; 023301E6
	bx r3	; 023301E8
loc_023301EA:
	ldr r0,[r4,#0x0]	; 023301EA
	cmp r0,#0x1	; 023301EC
	ble loc_023301FA	; 023301EE
	mov r0,#0x2	; 023301F0
	add sp,#0x4	; 023301F2
	pop {r4,r5,r6,r7}	; 023301F4
	pop {r3}	; 023301F6
	bx r3	; 023301F8
loc_023301FA:
	blx P1_Arm9DisableIrqReturnPriorMask	; 023301FA
	ldr r1,[pool_0233025C]	; 023301FE
	ldr r2,[r1,#0x0]	; 02330200
	cmp r2,#0x0	; 02330202
	beq loc_02330214	; 02330204
	blx P1_Arm9RestoreIrqMask	; 02330206
	mov r0,#0x1	; 0233020A
	add sp,#0x4	; 0233020C
	pop {r4,r5,r6,r7}	; 0233020E
	pop {r3}	; 02330210
	bx r3	; 02330212
loc_02330214:
	mov r2,#0x1	; 02330214
	str r2,[r1,#0x0]	; 02330216
	blx P1_Arm9RestoreIrqMask	; 02330218
	cmp r5,#0x0	; 0233021C
	beq loc_02330226	; 0233021E
	cmp r5,#0x1	; 02330220
	beq loc_0233022E	; 02330222
	b loc_02330234	; 02330224
loc_02330226:
	mov r1,#0x9	; 02330226
	ldr r0,[pool_0233025C]	; 02330228
	str r1,[r0,#0x14]	; 0233022A
	b loc_02330234	; 0233022C
loc_0233022E:
	mov r1,#0xa	; 0233022E
	ldr r0,[pool_0233025C]	; 02330230
	str r1,[r0,#0x14]	; 02330232
loc_02330234:
	mov r1,#0x0	; 02330234
	ldr r0,[pool_0233025C]	; 02330236
	str r1,[r0,#0x18]	; 02330238
	str r4,[r0,#0x8]	; 0233023A
	str r6,[r0,#0x4]	; 0233023C
	str r7,[r0,#0x10]	; 0233023E
	bl loc_023304C8	; 02330240
	cmp r0,#0x0	; 02330244
	beq loc_02330252	; 02330246
	mov r0,#0x0	; 02330248
	add sp,#0x4	; 0233024A
	pop {r4,r5,r6,r7}	; 0233024C
	pop {r3}	; 0233024E
	bx r3	; 02330250
loc_02330252:
	mov r0,#0x3	; 02330252
	add sp,#0x4	; 02330254
	pop {r4,r5,r6,r7}	; 02330256
	pop {r3}	; 02330258
	bx r3	; 0233025A
pool_0233025C:
loc_0233025C:
	.word P1_BssStart + 0x2831C	; 0233025C

; ===== function loc_02330260 =====
loc_02330260:
	ldr r1,[pool_02330268]	; 02330260
	str r0,[r1,#0x1c]	; 02330262
	bx lr	; 02330264
	.byte 0xC0, 0x46	; 02330268
pool_02330268:
loc_02330268:
	.word P1_BssStart + 0x2831C	; 02330268

; ===== function loc_0233026C =====
loc_0233026C:
	push {lr}	; 0233026C
	sub sp,#0x4	; 0233026E
	ldr r1,[pool_02330290]	; 02330270
	mov r2,#0x0	; 02330272
	bl loc_02330298	; 02330274
	ldr r1,[pool_02330294]	; 02330278
	str r0,[r1,#0x20]	; 0233027A
	cmp r0,#0x0	; 0233027C
	bne loc_02330284	; 0233027E
	blx loc_0232FAF4	; 02330280
loc_02330284:
	ldr r0,[pool_02330294]	; 02330284
	ldr r0,[r0,#0x20]	; 02330286
	add sp,#0x4	; 02330288
	pop {r3}	; 0233028A
	bx r3	; 0233028C
	.byte 0xC0, 0x46	; 02330290
pool_02330290:
loc_02330290:
	.word 0x0232FB0D	; 02330290
pool_02330294:
loc_02330294:
	.word P1_BssStart + 0x2831C	; 02330294

; ===== function loc_02330298 =====
loc_02330298:
	push {r4,r5,lr}	; 02330298
	sub sp,#0x4	; 0233029A
	add r5,r1,#0x0	; 0233029C
	add r4,r2,#0x0	; 0233029E
	ldrb r1,[r0,#0x0]	; 023302A0
	ldr r0,[pool_023302F4]	; 023302A2
	strb r1,[r0,#0x0]	; 023302A4
	blx P1_Arm9DisableIrqReturnPriorMask	; 023302A6
	ldr r1,[pool_023302F8]	; 023302AA
	ldr r2,[r1,#0x0]	; 023302AC
	cmp r2,#0x0	; 023302AE
	beq loc_023302C0	; 023302B0
	blx P1_Arm9RestoreIrqMask	; 023302B2
	mov r0,#0x1	; 023302B6
	add sp,#0x4	; 023302B8
	pop {r4,r5}	; 023302BA
	pop {r3}	; 023302BC
	bx r3	; 023302BE
loc_023302C0:
	mov r2,#0x1	; 023302C0
	str r2,[r1,#0x0]	; 023302C2
	blx P1_Arm9RestoreIrqMask	; 023302C4
	mov r1,#0xf	; 023302C8
	ldr r0,[pool_023302F8]	; 023302CA
	str r1,[r0,#0x14]	; 023302CC
	mov r1,#0x0	; 023302CE
	str r1,[r0,#0x18]	; 023302D0
	str r5,[r0,#0x4]	; 023302D2
	str r4,[r0,#0x10]	; 023302D4
	bl loc_023304B0	; 023302D6
	cmp r0,#0x0	; 023302DA
	beq loc_023302E8	; 023302DC
	mov r0,#0x0	; 023302DE
	add sp,#0x4	; 023302E0
	pop {r4,r5}	; 023302E2
	pop {r3}	; 023302E4
	bx r3	; 023302E6
loc_023302E8:
	mov r0,#0x3	; 023302E8
	add sp,#0x4	; 023302EA
	pop {r4,r5}	; 023302EC
	pop {r3}	; 023302EE
	bx r3	; 023302F0
	.byte 0xC0, 0x46	; 023302F4
pool_023302F4:
loc_023302F4:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 023302F4
pool_023302F8:
loc_023302F8:
	.word P1_BssStart + 0x2831C	; 023302F8

; ===== function loc_023302FC =====
P1_Entry_023302FC:
	push {lr}	; 023302FC
	sub sp,#0x4	; 023302FE
	ldr r2,[pool_02330320]	; 02330300
	mov r3,#0x0	; 02330302
	bl loc_02330328	; 02330304
	ldr r1,[pool_02330324]	; 02330308
	str r0,[r1,#0x20]	; 0233030A
	cmp r0,#0x0	; 0233030C
	bne loc_02330314	; 0233030E
	blx loc_0232FAF4	; 02330310
loc_02330314:
	ldr r0,[pool_02330324]	; 02330314
	ldr r0,[r0,#0x20]	; 02330316
	add sp,#0x4	; 02330318
	pop {r3}	; 0233031A
	bx r3	; 0233031C
	.byte 0xC0, 0x46	; 02330320
pool_02330320:
loc_02330320:
	.word 0x0232FB0D	; 02330320
pool_02330324:
loc_02330324:
	.word P1_BssStart + 0x2831C	; 02330324

; ===== function loc_02330328 =====
loc_02330328:
	push {r4,r5,r6,lr}	; 02330328
	add r6,r1,#0x0	; 0233032A
	add r5,r2,#0x0	; 0233032C
	add r4,r3,#0x0	; 0233032E
	ldr r1,[pool_0233039C]	; 02330330
	bl loc_0232FBB8	; 02330332
	cmp r0,#0x0	; 02330336
	bne loc_02330342	; 02330338
	mov r0,#0x2	; 0233033A
	pop {r4,r5,r6}	; 0233033C
	pop {r3}	; 0233033E
	bx r3	; 02330340
loc_02330342:
	add r0,r6,#0x0	; 02330342
	ldr r1,[pool_023303A0]	; 02330344
	bl loc_0232FB18	; 02330346
	cmp r0,#0x0	; 0233034A
	bne loc_02330356	; 0233034C
	mov r0,#0x2	; 0233034E
	pop {r4,r5,r6}	; 02330350
	pop {r3}	; 02330352
	bx r3	; 02330354
loc_02330356:
	blx P1_Arm9DisableIrqReturnPriorMask	; 02330356
	ldr r1,[pool_023303A4]	; 0233035A
	ldr r2,[r1,#0x0]	; 0233035C
	cmp r2,#0x0	; 0233035E
	beq loc_0233036E	; 02330360
	blx P1_Arm9RestoreIrqMask	; 02330362
	mov r0,#0x1	; 02330366
	pop {r4,r5,r6}	; 02330368
	pop {r3}	; 0233036A
	bx r3	; 0233036C
loc_0233036E:
	mov r2,#0x1	; 0233036E
	str r2,[r1,#0x0]	; 02330370
	blx P1_Arm9RestoreIrqMask	; 02330372
	mov r1,#0x5	; 02330376
	ldr r0,[pool_023303A4]	; 02330378
	str r1,[r0,#0x14]	; 0233037A
	mov r1,#0x0	; 0233037C
	str r1,[r0,#0x18]	; 0233037E
	str r5,[r0,#0x4]	; 02330380
	str r4,[r0,#0x10]	; 02330382
	bl loc_023304EC	; 02330384
	cmp r0,#0x0	; 02330388
	beq loc_02330394	; 0233038A
	mov r0,#0x0	; 0233038C
	pop {r4,r5,r6}	; 0233038E
	pop {r3}	; 02330390
	bx r3	; 02330392
loc_02330394:
	mov r0,#0x3	; 02330394
	pop {r4,r5,r6}	; 02330396
	pop {r3}	; 02330398
	bx r3	; 0233039A
pool_0233039C:
loc_0233039C:
	.word 0x027FFDE8	; 0233039C
pool_023303A0:
loc_023303A0:
	.word 0x027FFDEC	; 023303A0
pool_023303A4:
loc_023303A4:
	.word P1_BssStart + 0x2831C	; 023303A4

; ===== function loc_023303A8 =====
loc_023303A8:
	push {lr}	; 023303A8
	sub sp,#0x4	; 023303AA
	ldr r2,[pool_023303CC]	; 023303AC
	mov r3,#0x0	; 023303AE
	bl loc_023303D4	; 023303B0
	ldr r1,[pool_023303D0]	; 023303B4
	str r0,[r1,#0x20]	; 023303B6
	cmp r0,#0x0	; 023303B8
	bne loc_023303C0	; 023303BA
	blx loc_0232FAF4	; 023303BC
loc_023303C0:
	ldr r0,[pool_023303D0]	; 023303C0
	ldr r0,[r0,#0x20]	; 023303C2
	add sp,#0x4	; 023303C4
	pop {r3}	; 023303C6
	bx r3	; 023303C8
	.byte 0xC0, 0x46	; 023303CC
pool_023303CC:
loc_023303CC:
	.word 0x0232FB0D	; 023303CC
pool_023303D0:
loc_023303D0:
	.word P1_BssStart + 0x2831C	; 023303D0

; ===== function loc_023303D4 =====
loc_023303D4:
	push {r4,r5,r6,r7,lr}	; 023303D4
	sub sp,#0x4	; 023303D6
	add r5,r0,#0x0	; 023303D8
	add r4,r1,#0x0	; 023303DA
	add r6,r2,#0x0	; 023303DC
	add r7,r3,#0x0	; 023303DE
	blx P1_Arm9DisableIrqReturnPriorMask	; 023303E0
	ldr r1,[pool_02330430]	; 023303E4
	ldr r2,[r1,#0x0]	; 023303E6
	cmp r2,#0x0	; 023303E8
	beq loc_023303FA	; 023303EA
	blx P1_Arm9RestoreIrqMask	; 023303EC
	mov r0,#0x1	; 023303F0
	add sp,#0x4	; 023303F2
	pop {r4,r5,r6,r7}	; 023303F4
	pop {r3}	; 023303F6
	bx r3	; 023303F8
loc_023303FA:
	mov r2,#0x1	; 023303FA
	str r2,[r1,#0x0]	; 023303FC
	blx P1_Arm9RestoreIrqMask	; 023303FE
	mov r1,#0x2	; 02330402
	ldr r0,[pool_02330430]	; 02330404
	str r1,[r0,#0x14]	; 02330406
	mov r1,#0x0	; 02330408
	str r1,[r0,#0x18]	; 0233040A
	str r5,[r0,#0x8]	; 0233040C
	str r4,[r0,#0xc]	; 0233040E
	str r6,[r0,#0x4]	; 02330410
	str r7,[r0,#0x10]	; 02330412
	bl loc_023304F8	; 02330414
	cmp r0,#0x0	; 02330418
	beq loc_02330426	; 0233041A
	mov r0,#0x0	; 0233041C
	add sp,#0x4	; 0233041E
	pop {r4,r5,r6,r7}	; 02330420
	pop {r3}	; 02330422
	bx r3	; 02330424
loc_02330426:
	mov r0,#0x3	; 02330426
	add sp,#0x4	; 02330428
	pop {r4,r5,r6,r7}	; 0233042A
	pop {r3}	; 0233042C
	bx r3	; 0233042E
pool_02330430:
loc_02330430:
	.word P1_BssStart + 0x2831C	; 02330430

; ===== function loc_02330434 =====
loc_02330434:
	push {r4,r5,lr}	; 02330434
	sub sp,#0x4	; 02330436
	ldr r0,[pool_02330478]	; 02330438
	ldrh r1,[r0,#0x0]	; 0233043A
	cmp r1,#0x0	; 0233043C
	bne loc_0233046E	; 0233043E
	mov r1,#0x1	; 02330440
	strh r1,[r0,#0x0]	; 02330442
	mov r1,#0x0	; 02330444
	ldr r0,[pool_0233047C]	; 02330446
	str r1,[r0,#0x0]	; 02330448
	str r1,[r0,#0x4]	; 0233044A
	str r1,[r0,#0x1c]	; 0233044C
	str r1,[r0,#0x8]	; 0233044E
	str r1,[r0,#0xc]	; 02330450
	bl loc_0232ECB0	; 02330452
	mov r5,#0x5	; 02330456
	mov r4,#0x1	; 02330458
loc_0233045A:
	add r0,r5,#0x0	; 0233045A
	add r1,r4,#0x0	; 0233045C
	bl loc_0232EE24	; 0233045E
	cmp r0,#0x0	; 02330462
	beq loc_0233045A	; 02330464
	mov r0,#0x5	; 02330466
	ldr r1,[pool_02330480]	; 02330468
	bl P1_SetPxiReceiveCallback	; 0233046A
loc_0233046E:
	add sp,#0x4	; 0233046E
	pop {r4,r5}	; 02330470
	pop {r3}	; 02330472
	bx r3	; 02330474
	.byte 0xC0, 0x46	; 02330478
pool_02330478:
loc_02330478:
	.word P1_BssStart + 0x28318	; 02330478
pool_0233047C:
loc_0233047C:
	.word P1_BssStart + 0x2831C	; 0233047C
pool_02330480:
loc_02330480:
	.word P1_PxiCallback_0232FDD8 + 1	; 02330480
loc_02330484:
	push {lr}	; 02330484
	sub sp,#0x4	; 02330486
	add r1,r0,#0x0	; 02330488
	mov r0,#0x5	; 0233048A
	lsl r1,r1,#0x8	; 0233048C
	ldr r2,[pool_023304AC]	; 0233048E
	and r1,r2	; 02330490
	mov r2,#0x0	; 02330492
	bl loc_0232ED90	; 02330494
	cmp r0,#0x0	; 02330498
	blt loc_023304A4	; 0233049A
	mov r0,#0x1	; 0233049C
	add sp,#0x4	; 0233049E
	pop {r3}	; 023304A0
	bx r3	; 023304A2
loc_023304A4:
	mov r0,#0x0	; 023304A4
	add sp,#0x4	; 023304A6
	pop {r3}	; 023304A8
	bx r3	; 023304AA
pool_023304AC:
loc_023304AC:
	.word 0x00007F00	; 023304AC

; ===== function loc_023304B0 =====
loc_023304B0:
	mov r0,#0x28	; 023304B0
	ldr r3,[pool_023304B8]	; 023304B2
	bx r3	; 023304B4
	.byte 0xC0, 0x46	; 023304B8
pool_023304B8:
loc_023304B8:
	.word loc_02330484 + 1	; 023304B8

; ===== function loc_023304BC =====
loc_023304BC:
	mov r0,#0x27	; 023304BC
	ldr r3,[pool_023304C4]	; 023304BE
	bx r3	; 023304C0
	.byte 0xC0, 0x46	; 023304C4
pool_023304C4:
loc_023304C4:
	.word loc_02330484 + 1	; 023304C4

; ===== function loc_023304C8 =====
loc_023304C8:
	mov r0,#0x17	; 023304C8
	ldr r3,[pool_023304D0]	; 023304CA
	bx r3	; 023304CC
	.byte 0xC0, 0x46	; 023304D0
pool_023304D0:
loc_023304D0:
	.word loc_02330484 + 1	; 023304D0

; ===== function loc_023304D4 =====
loc_023304D4:
	mov r0,#0x25	; 023304D4
	ldr r3,[pool_023304DC]	; 023304D6
	bx r3	; 023304D8
	.byte 0xC0, 0x46	; 023304DC
pool_023304DC:
loc_023304DC:
	.word loc_02330484 + 1	; 023304DC

; ===== function loc_023304E0 =====
loc_023304E0:
	mov r0,#0x24	; 023304E0
	ldr r3,[pool_023304E8]	; 023304E2
	bx r3	; 023304E4
	.byte 0xC0, 0x46	; 023304E8
pool_023304E8:
loc_023304E8:
	.word loc_02330484 + 1	; 023304E8

; ===== function loc_023304EC =====
loc_023304EC:
	mov r0,#0x20	; 023304EC
	ldr r3,[pool_023304F4]	; 023304EE
	bx r3	; 023304F0
	.byte 0xC0, 0x46	; 023304F4
pool_023304F4:
loc_023304F4:
	.word loc_02330484 + 1	; 023304F4

; ===== function loc_023304F8 =====
loc_023304F8:
	mov r0,#0x10	; 023304F8
	ldr r3,[pool_02330500]	; 023304FA
	bx r3	; 023304FC
	.byte 0xC0, 0x46	; 02330500
pool_02330500:
loc_02330500:
	.word loc_02330484 + 1	; 02330500
	.byte 0x05, 0xCE, 0x32, 0x02, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00, 0x39, 0x42, 0x36, 0x02	; 02330514
	.byte 0x95, 0x7C, 0x36, 0x02, 0xA1, 0x91, 0x35, 0x02	; 02330514
P1_Data_0233051C:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0233051C
P1_Data_02330524:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 02330524
P1_Data_0233052C:
	.byte 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 0233052C
	.byte 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x05, 0x00, 0x04, 0x00	; 02330544
	.byte 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x05, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00	; 02330554
	.byte 0x05, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00	; 02330554
P1_Data_0233055C:
	.byte 0x09, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00	; 0233055C
	.byte 0x0B, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00	; 02330564
P1_Data_0233056C:
	.byte 0x05, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00	; 0233056C
	.byte 0x04, 0x00, 0x00, 0x00, 0x06, 0x00, 0x07, 0x00, 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00	; 02330584
	.byte 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00	; 02330594
	.byte 0x00, 0x00, 0x54, 0x00, 0x06, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00	; 023305A4
	.byte 0x00, 0x00, 0x30, 0x00, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 023305B4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x34, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00	; 023305C4
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023305D4
	.byte 0x00, 0x00, 0xD0, 0xFF, 0x03, 0x00, 0x00, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 023305E4
	.byte 0x00, 0x70, 0x07, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x08, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 023305F4
	.byte 0x00, 0x80, 0x08, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x07, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 02330604
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x07, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x07, 0x00	; 02330614
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x0A, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x0A, 0x00	; 02330624
	.byte 0x00, 0x60, 0x08, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x04, 0x00	; 02330634
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x08, 0x00, 0x00, 0x10, 0x07, 0x00	; 02330644
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x07, 0x00, 0x00, 0xE0, 0x04, 0x00	; 02330654
	.byte 0x00, 0x90, 0x07, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x07, 0x00	; 02330664
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x01, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x01, 0x00	; 02330674
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x04, 0x00	; 02330684
	.byte 0x00, 0x80, 0x0E, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x90, 0x0F, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 02330694
	.byte 0x00, 0x90, 0x0F, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x80, 0x0E, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 023306A4
	.byte 0x00, 0x70, 0x00, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 023306B4
	.byte 0x00, 0x80, 0x01, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 023306C4
	.byte 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00	; 023306D4
P1_Data_023306D4:
	.byte 0x0A, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00	; 023306D4
	.byte 0x06, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 023306F4
	.byte 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 023306F4
P1_Data_023306FC:
	.byte 0x00, 0x00	; 023306FC
P1_Data_023306FE:
	.byte 0x95, 0x00	; 023306FE
P1_Data_02330700:
	.byte 0x7F, 0x00, 0x00, 0x00	; 02330700
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x02, 0x00, 0x8A, 0x00, 0x74, 0x00, 0x0E, 0x00, 0x01, 0x00	; 02330714
	.byte 0x00, 0x00, 0x06, 0x00, 0x02, 0x00, 0x91, 0x00, 0x7B, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x00, 0x00	; 02330724
	.byte 0x09, 0x00, 0x02, 0x00, 0x86, 0x00, 0x70, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00	; 02330734
	.byte 0x02, 0x00, 0x8F, 0x00, 0x79, 0x00, 0x0E, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00	; 02330744
	.byte 0x8B, 0x00, 0x75, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x05, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8D, 0x00	; 02330754
	.byte 0x77, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x06, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8C, 0x00, 0x76, 0x00	; 02330764
	.byte 0x0E, 0x00, 0x01, 0x00, 0x07, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8E, 0x00, 0x78, 0x00, 0x0E, 0x00	; 02330774
	.byte 0x01, 0x00, 0x08, 0x00, 0x06, 0x00, 0x03, 0x00, 0x92, 0x00, 0x7C, 0x00, 0x0E, 0x00, 0x02, 0x00	; 02330784
	.byte 0x09, 0x00, 0x09, 0x00, 0x03, 0x00, 0x93, 0x00, 0x7D, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0A, 0x00	; 02330794
	.byte 0x09, 0x00, 0x03, 0x00, 0x94, 0x00, 0x7E, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0B, 0x00, 0x09, 0x00	; 023307A4
	.byte 0x03, 0x00, 0x88, 0x00, 0x72, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x03, 0x00	; 023307B4
	.byte 0x89, 0x00, 0x73, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x0D, 0x00, 0x0C, 0x00, 0x01, 0x00, 0x90, 0x00	; 023307C4
	.byte 0x7A, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x85, 0x00, 0x6F, 0x00	; 023307D4
	.byte 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x03, 0x00, 0x87, 0x00, 0x71, 0x00, 0x0E, 0x00	; 023307E4
	.byte 0x03, 0x00, 0x10, 0x00, 0x0C, 0x00, 0x02, 0x00, 0x85, 0x00, 0x6F, 0x00, 0x0F, 0x00, 0x11, 0x00	; 023307F4
	.byte 0x00, 0x00, 0xFF, 0xFF	; 023307F4
P1_Data_023307F8:
	.byte 0x00, 0x00, 0x60, 0x00	; 023307F8
P1_Data_023307FC:
	.byte 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00	; 023307FC
P1_Data_02330804:
	.byte 0x03, 0x00, 0x24, 0x00	; 02330804
P1_Data_02330808:
	.byte 0x01, 0x00	; 02330808
P1_Data_0233080A:
	.byte 0x01, 0x00, 0x02, 0x00, 0x2B, 0x00, 0x00, 0x00, 0x02, 0x00	; 0233080A
P1_Data_02330814:
	.byte 0x30, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00	; 02330814
	.byte 0x38, 0x00, 0x39, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330824
P1_Data_0233082C:
	.byte 0x03, 0x03, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00	; 0233082C
	.byte 0xFF, 0x0F, 0xFF, 0x0F, 0xC7, 0x01, 0x00, 0x00, 0x45, 0x82, 0x32, 0x02, 0x41, 0x82, 0x32, 0x02	; 02330844
	.byte 0x3D, 0x82, 0x32, 0x02, 0x00, 0x00, 0x00, 0x00, 0x39, 0x82, 0x32, 0x02, 0x24, 0xD4, 0x00, 0x00	; 02330854
	.byte 0x0F, 0x40, 0x00, 0x00, 0x00, 0x01, 0x81, 0x82, 0x82, 0x83, 0x0F, 0x83, 0x0C, 0xC3, 0x03, 0x83	; 02330864
	.byte 0x01, 0x83, 0x04, 0xC3, 0x08, 0x0E, 0x02, 0xC2, 0x0D, 0xC2, 0x07, 0x0B, 0x06, 0x0A, 0x05, 0x09	; 02330874
; ASCII VIB build identifier with the embedded build date. / 含内嵌构建日期的 ASCII VIB 构建标识。
P1_VibBuildIdentifier:
	.ascii "VIB2.11Oct  5 2004", 0
	.byte 0x00	; 02330887
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P1_CrtDataInitTable:
	.word P1_CopyDescriptors, P1_CopyDescriptorsEnd
	.word P1_ItcmLoadStart
	.word P1_BssStart, P3_FirmwareUiEntry
	.byte 0x2D, 0xFD, 0x5B, 0xFE, 0x97, 0xFE, 0xBB, 0xFE, 0xD4, 0xFE, 0xE7, 0xFE, 0xF7, 0xFE, 0x04, 0xFF	; 0233089C
	.byte 0x10, 0xFF, 0x1A, 0xFF, 0x23, 0xFF, 0x2C, 0xFF, 0x33, 0xFF, 0x3A, 0xFF, 0x40, 0xFF, 0x46, 0xFF	; 023308AC
	.byte 0x4C, 0xFF, 0x51, 0xFF, 0x56, 0xFF, 0x5B, 0xFF, 0x5F, 0xFF, 0x64, 0xFF, 0x68, 0xFF, 0x6C, 0xFF	; 023308BC
	.byte 0x6F, 0xFF, 0x73, 0xFF, 0x76, 0xFF, 0x7A, 0xFF, 0x7D, 0xFF, 0x80, 0xFF, 0x83, 0xFF, 0x86, 0xFF	; 023308CC
	.byte 0x88, 0xFF, 0x8B, 0xFF, 0x8E, 0xFF, 0x90, 0xFF, 0x92, 0xFF, 0x95, 0xFF, 0x97, 0xFF, 0x99, 0xFF	; 023308DC
	.byte 0x9C, 0xFF, 0x9E, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA4, 0xFF, 0xA6, 0xFF, 0xA8, 0xFF, 0xAA, 0xFF	; 023308EC
	.byte 0xAB, 0xFF, 0xAD, 0xFF, 0xAF, 0xFF, 0xB1, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB7, 0xFF	; 023308FC
	.byte 0xB9, 0xFF, 0xBA, 0xFF, 0xBC, 0xFF, 0xBD, 0xFF, 0xBF, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC3, 0xFF	; 0233090C
	.byte 0xC4, 0xFF, 0xC6, 0xFF, 0xC7, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF, 0xCB, 0xFF, 0xCC, 0xFF, 0xCD, 0xFF	; 0233091C
	.byte 0xCF, 0xFF, 0xD0, 0xFF, 0xD1, 0xFF, 0xD2, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD7, 0xFF	; 0233092C
	.byte 0xD8, 0xFF, 0xD9, 0xFF, 0xDA, 0xFF, 0xDB, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDE, 0xFF, 0xDF, 0xFF	; 0233093C
	.byte 0xE0, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE3, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF, 0xE6, 0xFF, 0xE7, 0xFF	; 0233094C
	.byte 0xE8, 0xFF, 0xE9, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEB, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEE, 0xFF	; 0233095C
	.byte 0xEF, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF1, 0xFF, 0xF2, 0xFF, 0xF3, 0xFF, 0xF4, 0xFF, 0xF4, 0xFF	; 0233096C
	.byte 0xF5, 0xFF, 0xF6, 0xFF, 0xF7, 0xFF, 0xF7, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFA, 0xFF	; 0233097C
	.byte 0xFB, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF, 0xFD, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00	; 0233098C
	.byte 0x00, 0x00, 0x00, 0x00	; 0233099C
P1_Data_023309A0:
	.byte 0x00, 0x00, 0xAA, 0x01, 0x50, 0x03, 0xED, 0x04, 0x82, 0x06, 0xFE, 0x07	; 023309A0
	.byte 0x65, 0x09, 0xB1, 0x0A, 0xE3, 0x0B, 0xF0, 0x0C, 0xD9, 0x0D, 0x9B, 0x0E, 0x37, 0x0F, 0xA6, 0x0F	; 023309AC
	.byte 0xE9, 0x0F, 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F, 0x39, 0x0F, 0xA1, 0x0E, 0xDC, 0x0D, 0xF4, 0x0C	; 023309BC
	.byte 0xE8, 0x0B, 0xBA, 0x0A, 0x6A, 0x09, 0x04, 0x08, 0x87, 0x06, 0xF9, 0x04, 0x56, 0x03, 0xB1, 0x01	; 023309CC
	.byte 0x06, 0x00, 0x5C, 0xFE, 0xB0, 0xFC, 0x13, 0xFB, 0x84, 0xF9, 0x07, 0xF8, 0x9B, 0xF6, 0x4F, 0xF5	; 023309DC
	.byte 0x21, 0xF4, 0x13, 0xF3, 0x27, 0xF2, 0x65, 0xF1, 0xCB, 0xF0, 0x5B, 0xF0, 0x17, 0xF0, 0x00, 0xF0	; 023309EC
	.byte 0x16, 0xF0, 0x58, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1, 0x21, 0xF2, 0x08, 0xF3, 0x18, 0xF4, 0x46, 0xF5	; 023309FC
	.byte 0x91, 0xF6, 0xF7, 0xF7, 0x79, 0xF9, 0x07, 0xFB, 0xA3, 0xFC, 0x49, 0xFE	; 02330A0C
P1_Data_02330A18:
	.byte 0x00, 0x10, 0xEA, 0x0F	; 02330A18
	.byte 0xA7, 0x0F, 0x39, 0x0F, 0x9E, 0x0E, 0xDC, 0x0D, 0xF4, 0x0C, 0xE8, 0x0B, 0xB5, 0x0A, 0x6A, 0x09	; 02330A1C
	.byte 0x04, 0x08, 0x87, 0x06, 0xF3, 0x04, 0x56, 0x03, 0xB1, 0x01, 0x06, 0x00, 0x56, 0xFE, 0xB0, 0xFC	; 02330A2C
	.byte 0x13, 0xFB, 0x84, 0xF9, 0x02, 0xF8, 0x9B, 0xF6, 0x4F, 0xF5, 0x21, 0xF4, 0x10, 0xF3, 0x27, 0xF2	; 02330A3C
	.byte 0x65, 0xF1, 0xCB, 0xF0, 0x5A, 0xF0, 0x17, 0xF0, 0x00, 0xF0, 0x16, 0xF0, 0x59, 0xF0, 0xC7, 0xF0	; 02330A4C
	.byte 0x5F, 0xF1, 0x21, 0xF2, 0x0C, 0xF3, 0x18, 0xF4, 0x46, 0xF5, 0x91, 0xF6, 0xFC, 0xF7, 0x79, 0xF9	; 02330A5C
	.byte 0x07, 0xFB, 0xA3, 0xFC, 0x4F, 0xFE, 0xFA, 0xFF, 0xA4, 0x01, 0x4A, 0x03, 0xED, 0x04, 0x7C, 0x06	; 02330A6C
	.byte 0xF9, 0x07, 0x5F, 0x09, 0xB1, 0x0A, 0xDF, 0x0B, 0xED, 0x0C, 0xD6, 0x0D, 0x9B, 0x0E, 0x35, 0x0F	; 02330A7C
	.byte 0xA5, 0x0F, 0xE8, 0x0F, 0x83, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0x96, 0x00, 0x00, 0x00	; 02330A8C
	.byte 0x97, 0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0x00, 0x6E, 0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x00	; 02330A9C
	.byte 0x0D, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 02330AAC
	.byte 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00	; 02330ABC
	.byte 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 02330ACC
	.byte 0x2E, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 02330ADC
	.byte 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00	; 02330AEC
P1_Data_02330AF8:
	.byte 0x01, 0x00, 0x00, 0x00	; 02330AF8
	.byte 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x00, 0x00, 0xA9, 0x00, 0x00, 0x00	; 02330AFC
P1_Data_02330B08:
	.byte 0x58, 0x00, 0x00, 0x00	; 02330B08
	.byte 0x40, 0x00, 0x00, 0x00, 0xE0, 0x11, 0x3D, 0x02, 0x80, 0x2B, 0x3D, 0x02, 0xC0, 0x3F, 0x3D, 0x02	; 02330B0C
	.byte 0x00, 0x56, 0x3D, 0x02, 0x00, 0x6C, 0x3D, 0x02, 0xE0, 0x81, 0x3D, 0x02	; 02330B1C
P1_Data_02330B28:
	.byte 0x01, 0x00, 0x02, 0x00	; 02330B28
	.byte 0x00, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330B2C
	.byte 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04, 0x00, 0x06, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330B3C
	.byte 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00	; 02330B4C
	.byte 0x01, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330B5C
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330B6C
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00	; 02330B7C
	.byte 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330B8C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330B9C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BAC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BBC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BCC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BDC
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x04, 0x00, 0x03, 0x00, 0x00, 0x00	; 02330BEC
	.byte 0x01, 0x00, 0x05, 0x00, 0x08, 0x00, 0x09, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330BFC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330C0C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0A, 0x00	; 02330C1C
	.byte 0x07, 0x00, 0x01, 0x00, 0x05, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330C2C
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330C3C
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330C4C
	.byte 0x00, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x02, 0x00	; 02330C5C
	.byte 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x00, 0x00	; 02330C6C
	.byte 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330C7C
	.byte 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00	; 02330C8C
	.byte 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00	; 02330C9C
	.byte 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00	; 02330CAC
	.byte 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00	; 02330CBC
	.byte 0x2E, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00	; 02330CCC
	.byte 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00	; 02330CDC
	.byte 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330CEC
P1_Data_02330CF8:
	.byte 0x1F, 0x00, 0x1C, 0x00	; 02330CF8
	.byte 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00	; 02330CFC
	.byte 0x1E, 0x00, 0x1F, 0x00	; 02330D0C
P1_Data_02330D10:
	.byte 0xFF, 0x00, 0x00, 0x00, 0x9B, 0x47, 0x26, 0x74, 0xBC, 0x11, 0x4F, 0x6D	; 02330D10
	.byte 0xBD, 0x11, 0xF1, 0x32, 0xD9, 0x7F, 0xE7, 0x2C, 0xA5, 0x5D, 0xBD, 0x11, 0x10, 0x46, 0xA4, 0x5D	; 02330D1C
	.byte 0x90, 0x4E, 0x73, 0x61, 0x84, 0x2A, 0x91, 0x4E, 0x6A, 0x10, 0xFE, 0x75, 0xC8, 0x29, 0x39, 0x78	; 02330D2C
	.byte 0x0E, 0x42, 0x1B, 0x5D, 0x38, 0x78, 0xA8, 0x12, 0x7D, 0x3F, 0xB9, 0x67, 0xF3, 0x26, 0xEF, 0x54	; 02330D3C
	.byte 0x23, 0x7C, 0xF2, 0x26, 0xC6, 0x6B, 0x37, 0x41, 0xAB, 0x15, 0x0D, 0x73, 0xC7, 0x6B, 0x4F, 0x3B	; 02330D4C
	.byte 0x24, 0x5F, 0xDA, 0x3D, 0x3F, 0x25, 0x49, 0x17, 0xDB, 0x3D, 0xE6, 0x70, 0x6C, 0x74, 0xF7, 0x30	; 02330D5C
	.byte 0x1F, 0x53, 0x38, 0x67, 0x1E, 0x53, 0x51, 0x1A, 0x71, 0x19, 0x7D, 0x5B, 0xD6, 0x4E, 0x70, 0x19	; 02330D6C
	.byte 0x27, 0x3F, 0xCB, 0x75, 0x62, 0x3D, 0x8C, 0x12, 0xB8, 0x74, 0xAD, 0x2F, 0xB9, 0x74, 0xFD, 0x64	; 02330D7C
	.byte 0x9A, 0x6C, 0x3A, 0x4F, 0x6D, 0x27, 0xEF, 0x73, 0xB1, 0x38, 0x3B, 0x4F, 0x1E, 0x57, 0xA3, 0x7E	; 02330D8C
	.byte 0x49, 0x62, 0x87, 0x35, 0x7C, 0x1B, 0x86, 0x35, 0xFB, 0x7A, 0xE4, 0x67, 0x92, 0x5C, 0xE5, 0x67	; 02330D9C
	.byte 0xCA, 0x2B, 0x8C, 0x43, 0x6F, 0x2E, 0x7F, 0x58, 0xB7, 0x14, 0x6E, 0x2E, 0xB9, 0x4C, 0xA2, 0x6F	; 02330DAC
	.byte 0xF0, 0x38, 0x9E, 0x71, 0x5A, 0x47, 0x3C, 0x1F, 0xD8, 0x6A, 0x5B, 0x47, 0x99, 0x51, 0x64, 0x32	; 02330DBC
	.byte 0x41, 0x7B, 0xEF, 0x49, 0x98, 0x51, 0xD7, 0x1C	; 02330DCC
P1_Data_02330DD4:
	.byte 0xC0, 0x01, 0x01, 0x04, 0x00, 0x00, 0x00, 0x00	; 02330DD4
P1_Data_02330DDC:
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 02330DDC
P1_Data_02330DEC:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P1_IrqHandlers:
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 0
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 1
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 2
	.word P1_IrqHandler_0232AC54 + 1	; IRQ 3
	.word P1_IrqHandler_0232AC48 + 1	; IRQ 4
	.word P1_IrqHandler_0232AC3C + 1	; IRQ 5
	.word P1_IrqHandler_0232AC30 + 1	; IRQ 6
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 7
	.word P1_IrqHandler_0232AC84 + 1	; IRQ 8
	.word P1_IrqHandler_0232AC78 + 1	; IRQ 9
	.word P1_IrqHandler_0232AC6C + 1	; IRQ 10
	.word P1_IrqHandler_0232AC60 + 1	; IRQ 11
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 12
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 13
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 14
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 15
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 16
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 17
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 18
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 19
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 20
	.word P1_IrqHandler_0232ACF0 + 1	; IRQ 21
P1_IrqHandlersEnd:
P1_Data_02330E44:
	.byte 0xFF, 0xFF, 0xFF, 0xFF	; 02330E44
P1_Data_02330E48:
	.byte 0x01, 0x00, 0x00, 0x00	; 02330E48
P1_Data_02330E4C:
	.byte 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330E4C
	.byte 0x00, 0x00, 0x00, 0x00	; 02330E5C
; CRT 复制后，此保存区复用为主 BSS；下游偏移仍保留原内存布局。
; After CRT copying, reuse this load area as BSS; keep the original field offsets.
P1_BssStart:
; 本 CPU 的 32 项 FIFO 回调表，按通道索引；位于 CRT 清零的 BSS。
; This CPU's 32 FIFO callback slots, indexed by channel, live in CRT-cleared BSS.
.definelabel P1_PxiReceiveCallbacks, P1_BssStart + 0x28208
.definelabel P1_PxiReceiveCallbacksEnd, P1_PxiReceiveCallbacks + PxiFifoChannelCount * 4
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
	.word Slot2BusBaseAddress + 0x180	; 01FF807C
pool_01FF8080:
	.word P1_ItcmRuntimeStart	; 01FF8080
P1_Runtime_01FF8084:
	push {r4,r5,r6,r7,lr}	; 01FF8084
	sub sp,#0xc	; 01FF8086
	blx loc_0232AE48	; 01FF8088
	lsl r0,r0,#0x10	; 01FF808C
	lsr r0,r0,#0x10	; 01FF808E
	str r0,[sp,#0x0]	; 01FF8090
	bl loc_0232AFA0	; 01FF8092
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
	bl loc_0232AE38	; 01FF810C
	ldr r0,[sp,#0x0]	; 01FF8110
	blx loc_0232AEA0	; 01FF8112
	add sp,#0xc	; 01FF8116
	pop {r4,r5,r6,r7}	; 01FF8118
	pop {r3}	; 01FF811A
	bx r3	; 01FF811C
	.byte 0xC0, 0x46	; 01FF811E
pool_01FF8120:
	.word Slot2BusBaseAddress + 0x10420	; 01FF8120
pool_01FF8124:
	.word 0x00004000	; 01FF8124
pool_01FF8128:
	.word 0x00000400	; 01FF8128
pool_01FF812C:
	.word Slot2BusBaseAddress + 0x1040A	; 01FF812C

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
	.word P1_SaveArithmeticContext + 1	; 01FF82D4
pool_01FF82D8:
	.word P1_RestoreArithmeticContext + 1	; 01FF82D8

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
	.byte 0x21, 0x06, 0xC0, 0xDE, 0x88, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 023311B8
.thumb
.close

; 请求记录的空闲链与待处理链的头、尾指针，位于 CRT 清零的 BSS。
; Free and pending request-list head/tail pointers in CRT-cleared BSS.
.definelabel P1_RequestPendingTail, P1_BssStart + 0x266D4
.definelabel P1_RequestPendingHead, P1_BssStart + 0x266D0
.definelabel P1_RequestFreeHead, P1_BssStart + 0x266C8
.definelabel P1_RequestFreeTail, P1_BssStart + 0x266D8

; 已确认的请求记录字段偏移：链指针、命令及四个参数。
; Proven request-record field offsets: link, command and four arguments.
.definelabel P1_RequestRecordNextOffset, 0x0
.definelabel P1_RequestRecordCommandOffset, 0x4
.definelabel P1_RequestRecordArgument0Offset, 0x8
.definelabel P1_RequestRecordArgument1Offset, 0xC
.definelabel P1_RequestRecordArgument2Offset, 0x10
.definelabel P1_RequestRecordArgument3Offset, 0x14

; 已确认的双缓冲回调上下文与处理器字段偏移。
; Proven field offsets for the two-buffer callback context and processor.
.definelabel P1_DualBufferCallbackContextModeOffset, 0x0
.definelabel P1_DualBufferCallbackContextWorkerOffset, 0x4
.definelabel P1_DualBufferCallbackContextArgumentOffset, 0x8
.definelabel P1_DualBufferProcessorActiveOffset, 0x0
.definelabel P1_DualBufferProcessorModeOffset, 0x4
.definelabel P1_DualBufferProcessorUserValueOffset, 0x8
.definelabel P1_DualBufferProcessorFirstBufferOffset, 0xC
.definelabel P1_DualBufferProcessorSecondBufferOffset, 0x10
.definelabel P1_DualBufferProcessorBlockByteCountOffset, 0x14
.definelabel P1_DualBufferProcessorBlockIndexOffset, 0x18
.definelabel P1_DualBufferProcessorControlMaskIndexOffset, 0x28
.definelabel P1_DualBufferProcessorBlockCountOffset, 0x2C
.definelabel P1_DualBufferProcessorCallbackOffset, 0x30
.definelabel P1_DualBufferProcessorCallbackContextOffset, 0x34
.definelabel P1_DualBufferProcessorLastReportedValueOffset, 0x4C

; 延后交付队列的门控位、环形索引和 8 个 0x14 字节条目，位于 CRT 清零的 BSS。
; Deferred-delivery queue gate, ring index and eight 0x14-byte entries in CRT-cleared BSS.
.definelabel P1_DualBufferDeferredQueueGate, P1_BssStart + 0x26204
.definelabel P1_DualBufferDeferredQueueIndex, P1_BssStart + 0x26200
.definelabel P1_DualBufferDeferredQueueEntries, P1_BssStart + 0x2626C

; 双缓冲回调上下文及处理状态，位于 CRT 清零的 BSS。
; Two-buffer callback context and processor state in CRT-cleared BSS.
.definelabel P1_DualBufferCallbackContext, P1_BssStart + 0x2593C
.definelabel P1_DualBufferProcessorState, P1_BssStart + 0x2621C

; 开合盖/休眠状态与可选回调槽，位于 CRT 清零的 BSS。
; Lid/sleep state and optional callback slots in CRT-cleared BSS.
.definelabel P1_LidAndSleepState, P1_BssStart + 0x24DD8
.definelabel P1_BeforeSleepCallbackSlot, P1_LidAndSleepState + 8
.definelabel P1_AfterSleepCallbackSlot, P1_LidAndSleepState + 12
.definelabel P1_LidOpenedCallbackSlot, P1_LidAndSleepState + 16
