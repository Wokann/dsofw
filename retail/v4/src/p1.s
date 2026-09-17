; official_v4_p1
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
	bl loc_0232D128	; 02320074
	bl loc_0232C954	; 02320078
	blx loc_0232D1E8	; 0232007C
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
	bl loc_02327A28	; 023200AA
	bl loc_0232BC48	; 023200AE
	bl loc_0232C0CC	; 023200B2
	bl loc_0232D514	; 023200B6
	bl loc_0232EEE0	; 023200BA
	ldr r1,[pool_02320214]	; 023200BE
	ldrh r2,[r1,#0x0]	; 023200C0
	ldr r0,[pool_02320218]	; 023200C2
	and r2,r0	; 023200C4
	ldr r0,[pool_0232021C]	; 023200C6
	orr r2,r0	; 023200C8
	strh r2,[r1,#0x0]	; 023200CA
	ldr r0,[pool_02320220]	; 023200CC
	bl loc_0232D740	; 023200CE
	lsl r0,r5,#0	; 023200D2
	str r0,[sp,#0x4]	; 023200D4
	ldr r0,[sp,#0x4]	; 023200D6
	ldr r1,[pool_02320224]	; 023200D8
	ldr r2,[pool_02320228]	; 023200DA
	blx loc_0232DE78	; 023200DC
	bl loc_0232D640	; 023200E0
	mov r0,#0xc0	; 023200E4
	str r0,[sp,#0x0]	; 023200E6
	ldr r0,[sp,#0x0]	; 023200E8
	ldr r1,[pool_0232022C]	; 023200EA
	ldr r2,[pool_02320230]	; 023200EC
	blx loc_0232DE78	; 023200EE
	lsl r0,r5,#0	; 023200F2
	str r0,[sp,#0x8]	; 023200F4
	ldr r0,[sp,#0x8]	; 023200F6
	ldr r1,[pool_02320234]	; 023200F8
	ldr r2,[pool_02320230]	; 023200FA
	blx loc_0232DE78	; 023200FC
	mov r0,#0x1	; 02320100
	ldr r1,[pool_02320238]	; 02320102
	bl loc_0232B1F0	; 02320104
	mov r0,#0x1	; 02320108
	bl loc_0232B16C	; 0232010A
	ldr r1,[pool_0232023C]	; 0232010E
	ldrh r0,[r1,#0x0]	; 02320110
	mov r0,#0x1	; 02320112
	strh r0,[r1,#0x0]	; 02320114
	blx P1_Arm9EnableIrqReturnPriorMask	; 02320116
	mov r0,#0x1	; 0232011A
	bl loc_0232D4F0	; 0232011C
	bl loc_0232FDAC	; 02320120
	bl loc_023278F8	; 02320124
	cmp r0,#0x0	; 02320128
	bne loc_02320206	; 0232012A
	bl loc_023276A4	; 0232012C
	bl loc_023268EC	; 02320130
	bl loc_02326A48	; 02320134
	bl loc_02324CB4	; 02320138
	bl loc_02324DFC	; 0232013C
	bl loc_02323740	; 02320140
	bl P1_InitializeFirmwareUiContext	; 02320144
	bl loc_02325884	; 02320148
	bl loc_023257A4	; 0232014C
	bl P1_GetFirmwareUiContext	; 02320150
	ldr r0,[r0,#0x0]	; 02320154
	lsl r0,r0,#0x1b	; 02320156
	lsr r0,r0,#0x1f	; 02320158
	cmp r0,#0x0	; 0232015A
	beq loc_02320162	; 0232015C
	mov r4,#0x5	; 0232015E
	b loc_02320168	; 02320160
loc_02320162:
	bl loc_02320DF0	; 02320162
	mov r5,#0x1	; 02320166
loc_02320168:
	bl P1_RefreshFirmwareUiRenderBuffers	; 02320168
	bl loc_02324C88	; 0232016C
	bl loc_02324A80	; 02320170
	bl loc_02324C6C	; 02320174
	bl loc_02324A80	; 02320178
	bl loc_02326924	; 0232017C
	bl loc_023276A4	; 02320180
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
	bl loc_023275F0	; 023201A4
	b loc_023201B4	; 023201A8
loc_023201AA:
	bl loc_02327610	; 023201AA
	b loc_023201B4	; 023201AE
loc_023201B0:
	bl loc_02327600	; 023201B0
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
	bl loc_02327670	; 023201D4
	b loc_02320200	; 023201D8
loc_023201DA:
	bl loc_0232D4BC	; 023201DA
	ldr r2,[pool_02320240]	; 023201DE
	ldr r1,[r2,#0x0]	; 023201E0
	ldr r0,[pool_02320244]	; 023201E2
	and r1,r0	; 023201E4
	str r1,[r2,#0x0]	; 023201E6
	bl loc_02327630	; 023201E8
	b loc_02320200	; 023201EC
loc_023201EE:
	bl loc_0232D4BC	; 023201EE
	ldr r2,[pool_02320240]	; 023201F2
	ldr r1,[r2,#0x0]	; 023201F4
	ldr r0,[pool_02320244]	; 023201F6
	and r1,r0	; 023201F8
	str r1,[r2,#0x0]	; 023201FA
	bl loc_02327620	; 023201FC
loc_02320200:
	bl loc_02323738	; 02320200
	b loc_02320168	; 02320204
loc_02320206:
	add sp,#0xc	; 02320206
	pop {r4,r5}	; 02320208
	pop {r3}	; 0232020A
	bx r3	; 0232020C
	.byte 0xC0, 0x46	; 02320210
pool_02320210:
loc_02320210:
	.word 0x0232FE88	; 02320210
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
	add r1,r1,r0	; 0232024C
	ldr r2,[r1,#0x0]	; 0232024E
	mov r0,#0x1	; 02320250
	orr r2,r0	; 02320252
	str r2,[r1,#0x0]	; 02320254
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
	bl loc_0232415C	; 02320268
	bl loc_02323FA4	; 0232026C
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
	bl loc_02322988	; 02320284
loc_02320288:
	bl loc_02325488	; 02320288
	bl loc_02324F78	; 0232028C
	add r0,r5,#0x0	; 02320290
	bl loc_02321D18	; 02320292
	ldr r0,[pool_023203DC]	; 02320296
	bl loc_02326A80	; 02320298
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
	bl loc_02320AAC	; 023202F2
	b loc_02320388	; 023202F6
loc_023202F8:
	bl loc_02320970	; 023202F8
	b loc_02320388	; 023202FC
loc_023202FE:
	bl loc_02320884	; 023202FE
	add r4,r0,#0x0	; 02320302
	b loc_02320388	; 02320304
loc_02320306:
	bl loc_0232081C	; 02320306
	b loc_02320388	; 0232030A
loc_0232030C:
	bl loc_023207D0	; 0232030C
	b loc_02320388	; 02320310
loc_02320312:
	add r0,r5,#0x0	; 02320312
	bl loc_023205F8	; 02320314
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
	bl loc_02326010	; 02320340
	b loc_02320388	; 02320344
loc_02320346:
	add r0,r5,#0x0	; 02320346
	add r1,r6,#0x0	; 02320348
	bl loc_02325FA8	; 0232034A
	b loc_02320388	; 0232034E
loc_02320350:
	add r0,r6,#0x0	; 02320350
	bl loc_02325F30	; 02320352
	b loc_02320388	; 02320356
loc_02320358:
	add r0,r6,#0x0	; 02320358
	bl loc_02325EA8	; 0232035A
	b loc_02320388	; 0232035E
loc_02320360:
	add r0,r6,#0x0	; 02320360
	bl loc_02325DFC	; 02320362
	b loc_02320388	; 02320366
loc_02320368:
	add r0,r6,#0x0	; 02320368
	bl loc_02325CD0	; 0232036A
	b loc_02320388	; 0232036E
loc_02320370:
	add r0,r6,#0x0	; 02320370
	bl loc_02325C60	; 02320372
	b loc_02320388	; 02320376
loc_02320378:
	add r0,r6,#0x0	; 02320378
	bl loc_02325B1C	; 0232037A
	b loc_02320388	; 0232037E
loc_02320380:
	add r0,r5,#0x0	; 02320380
	add r1,r6,#0x0	; 02320382
	bl loc_02325BA8	; 02320384
loc_02320388:
	bl loc_0232C6D8	; 02320388
	cmp r0,#0x0	; 0232038C
	beq loc_023203B0	; 0232038E
	ldr r0,[pool_023203E8]	; 02320390
	ldr r1,[pool_023203EC]	; 02320392
	mov r2,#0x30	; 02320394
	bl loc_02324BA0	; 02320396
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
	bl loc_023260B8	; 023203B2
	cmp r4,#0x0	; 023203B6
	beq loc_023203C4	; 023203B8
	ldr r1,[pool_023203D8]	; 023203BA
	ldr r2,[r1,#0x68]	; 023203BC
	mov r0,#0x2	; 023203BE
	bic r2,r0	; 023203C0
	str r2,[r1,#0x68]	; 023203C2
loc_023203C4:
	bl loc_02320AFC	; 023203C4
	add r0,r4,#0x0	; 023203C8
	pop {r4,r5,r6}	; 023203CA
	pop {r3}	; 023203CC
	bx r3	; 023203CE
pool_023203D0:
loc_023203D0:
	.word 0x02330BB4	; 023203D0
pool_023203D4:
loc_023203D4:
	.word 0x0233151C	; 023203D4
pool_023203D8:
loc_023203D8:
	.word P1_BssStart + 0x1300	; 023203D8
pool_023203DC:
loc_023203DC:
	.word 0x02331530	; 023203DC
pool_023203E0:
loc_023203E0:
	.word P1_BssStart + 0xA80	; 023203E0
pool_023203E4:
loc_023203E4:
	.word P1_BssStart + 0x100	; 023203E4
pool_023203E8:
loc_023203E8:
	.word 0x02330ACC	; 023203E8
pool_023203EC:
loc_023203EC:
	.word 0x023A5AEC	; 023203EC
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
	bl loc_023253D4	; 0232042C
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
	bl loc_023250A4	; 02320450
	b loc_023204B4	; 02320454
loc_02320456:
	cmp r1,#0x3	; 02320456
	bne loc_02320470	; 02320458
	bl loc_023253D4	; 0232045A
	mov r0,#0x1	; 0232045E
	bl loc_02322A14	; 02320460
	mov r1,#0x0	; 02320464
	ldr r0,[pool_023204C0]	; 02320466
	str r1,[r0,#0x50]	; 02320468
	mov r1,#0x3	; 0232046A
	str r1,[r0,#0x4c]	; 0232046C
	b loc_023204B4	; 0232046E
loc_02320470:
	cmp r1,#0x4	; 02320470
	bne loc_02320484	; 02320472
	bl loc_023253D4	; 02320474
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
	bl loc_023253D4	; 02320496
	mov r1,#0x0	; 0232049A
	ldr r0,[pool_023204C0]	; 0232049C
	str r1,[r0,#0x50]	; 0232049E
	mov r1,#0x6	; 023204A0
	str r1,[r0,#0x4c]	; 023204A2
	b loc_023204B4	; 023204A4
loc_023204A6:
	cmp r1,#0x0	; 023204A6
	bne loc_023204B4	; 023204A8
	bl loc_023253D4	; 023204AA
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
	bl loc_02325AA4	; 023204D8
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
	.word 0x0233151C	; 023204FC
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
	bl loc_0232D3F4	; 02320528
	ldr r0,[pool_02320558]	; 0232052C
	add r1,r5,#0x0	; 0232052E
	bl loc_0232D3F4	; 02320530
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
	ldr r2,[pool_023205E8]	; 02320562
	ldr r0,[pool_023205EC]	; 02320564
	ldr r1,[r0,#0x4]	; 02320566
	mov r0,#0x3c	; 02320568
	mul r1,r0	; 0232056A
	add r0,r2,r1	; 0232056C
	mov r1,#0x2	; 0232056E
	ldrsh r2,[r0,r1]	; 02320570
	mov r1,#0x77	; 02320572
	mvn r1,r1	; 02320574
	cmp r2,r1	; 02320576
	ble loc_0232057E	; 02320578
	sub r1,r2,#0x6	; 0232057A
	strh r1,[r0,#0x2]	; 0232057C
loc_0232057E:
	ldr r1,[pool_023205EC]	; 0232057E
	ldr r0,[r1,#0x8]	; 02320580
	add r0,r0,#0x1	; 02320582
	str r0,[r1,#0x8]	; 02320584
	cmp r0,#0x1e	; 02320586
	bgt loc_023205A6	; 02320588
	lsl r0,r0,#0x4	; 0232058A
	mov r1,#0x1e	; 0232058C
	blx P1_SignedDivMod	; 0232058E
	add r5,r0,#0x0	; 02320592
	str r5,[sp,#0x0]	; 02320594
	ldr r0,[pool_023205F0]	; 02320596
	mov r1,#0x0	; 02320598
	mov r2,#0x2	; 0232059A
	mov r3,#0x10	; 0232059C
	sub r3,r3,r5	; 0232059E
	bl loc_0232D968	; 023205A0
	b loc_023205DA	; 023205A4
loc_023205A6:
	ldr r0,[r1,#0x4]	; 023205A6
	cmp r0,#0x4	; 023205A8
	bhi loc_023205DA	; 023205AA
	add r0,r0,r0	; 023205AC
P1_SwitchIndexPC_023205AC:
	add r0,pc	; 023205AE
	ldrh r0,[r0,#(P1_SwitchTable_023205AC - (P1_SwitchIndexPC_023205AC + 4))]	; 023205B0
	lsl r0,r0,#0x10	; 023205B2
	asr r0,r0,#0x10	; 023205B4
P1_SwitchTargetPC_023205AC:
	add r0,pc	; 023205B6
	bx r0	; 023205B8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023205AC:
	.halfword (loc_023205C4 + 1) - (P1_SwitchTargetPC_023205AC + 4)
	.halfword (loc_023205D0 + 1) - (P1_SwitchTargetPC_023205AC + 4)
	.halfword (loc_023205CC + 1) - (P1_SwitchTargetPC_023205AC + 4)
	.halfword (loc_023205C8 + 1) - (P1_SwitchTargetPC_023205AC + 4)
	.halfword (loc_023205D0 + 1) - (P1_SwitchTargetPC_023205AC + 4)
P1_SwitchTable_023205ACEnd:
loc_023205C4:
	mov r4,#0x1	; 023205C4
	b loc_023205DA	; 023205C6
loc_023205C8:
	mov r4,#0x2	; 023205C8
	b loc_023205DA	; 023205CA
loc_023205CC:
	mov r4,#0x3	; 023205CC
	b loc_023205DA	; 023205CE
loc_023205D0:
	mov r0,#0x0	; 023205D0
	str r0,[r1,#0x8]	; 023205D2
	mov r1,#0x7	; 023205D4
	ldr r0,[pool_023205F4]	; 023205D6
	str r1,[r0,#0x2c]	; 023205D8
loc_023205DA:
	bl loc_02321D68	; 023205DA
	add r0,r4,#0x0	; 023205DE
	add sp,#0x4	; 023205E0
	pop {r4,r5}	; 023205E2
	pop {r3}	; 023205E4
	bx r3	; 023205E6
pool_023205E8:
loc_023205E8:
	.word 0x02330A80	; 023205E8
pool_023205EC:
loc_023205EC:
	.word P1_BssStart + 0xB00	; 023205EC
pool_023205F0:
loc_023205F0:
	.word REG_BLDCNT_SUB	; 023205F0
pool_023205F4:
loc_023205F4:
	.word P1_BssStart + 0x100	; 023205F4

; ===== function loc_023205F8 =====
loc_023205F8:
	push {r4,r5,lr}	; 023205F8
	sub sp,#0x4	; 023205FA
	add r5,r0,#0x0	; 023205FC
	ldr r0,[pool_0232079C]	; 023205FE
	bl loc_023216AC	; 02320600
	ldr r0,[pool_023207A0]	; 02320604
	ldr r4,[r0,#0x74]	; 02320606
	add r0,r5,#0x0	; 02320608
	mov r1,#0x5	; 0232060A
	bl loc_02321D10	; 0232060C
	cmp r0,#0x0	; 02320610
	bne loc_02320622	; 02320612
	mov r0,#0x1	; 02320614
	bl loc_0232414C	; 02320616
	cmp r0,#0x0	; 0232061A
	beq loc_0232062E	; 0232061C
	cmp r4,#0x0	; 0232061E
	bne loc_0232062E	; 02320620
loc_02320622:
	bl loc_023207B4	; 02320622
	mov r1,#0x0	; 02320626
	ldr r0,[pool_023207A4]	; 02320628
	str r1,[r0,#0x4]	; 0232062A
	b loc_02320792	; 0232062C
loc_0232062E:
	add r0,r5,#0x0	; 0232062E
	mov r1,#0x0	; 02320630
	bl loc_02321D10	; 02320632
	cmp r0,#0x0	; 02320636
	bne loc_02320648	; 02320638
	mov r0,#0x1	; 0232063A
	bl loc_0232414C	; 0232063C
	cmp r0,#0x0	; 02320640
	beq loc_02320662	; 02320642
	cmp r4,#0x3	; 02320644
	bne loc_02320662	; 02320646
loc_02320648:
	bl loc_023207B4	; 02320648
	mov r1,#0x3	; 0232064C
	ldr r0,[pool_023207A4]	; 0232064E
	str r1,[r0,#0x4]	; 02320650
	bl loc_02321E18	; 02320652
	ldr r1,[pool_023207A8]	; 02320656
	ldr r2,[r1,#0x68]	; 02320658
	ldr r0,[pool_023207AC]	; 0232065A
	orr r2,r0	; 0232065C
	str r2,[r1,#0x68]	; 0232065E
	b loc_02320792	; 02320660
loc_02320662:
	add r0,r5,#0x0	; 02320662
	mov r1,#0x2	; 02320664
	bl loc_02321D10	; 02320666
	cmp r0,#0x0	; 0232066A
	bne loc_0232067C	; 0232066C
	mov r0,#0x1	; 0232066E
	bl loc_0232414C	; 02320670
	cmp r0,#0x0	; 02320674
	beq loc_02320688	; 02320676
	cmp r4,#0x2	; 02320678
	bne loc_02320688	; 0232067A
loc_0232067C:
	bl loc_023207B4	; 0232067C
	mov r1,#0x2	; 02320680
	ldr r0,[pool_023207A4]	; 02320682
	str r1,[r0,#0x4]	; 02320684
	b loc_02320792	; 02320686
loc_02320688:
	ldr r0,[pool_023207A8]	; 02320688
	ldr r0,[r0,#0x68]	; 0232068A
	lsl r0,r0,#0x1b	; 0232068C
	lsr r0,r0,#0x1f	; 0232068E
	cmp r0,#0x0	; 02320690
	beq loc_023206A0	; 02320692
	add r0,r5,#0x0	; 02320694
	mov r1,#0x1	; 02320696
	bl loc_02321D10	; 02320698
	cmp r0,#0x0	; 0232069C
	bne loc_023206AE	; 0232069E
loc_023206A0:
	mov r0,#0x1	; 023206A0
	bl loc_0232414C	; 023206A2
	cmp r0,#0x0	; 023206A6
	beq loc_023206BA	; 023206A8
	cmp r4,#0x4	; 023206AA
	bne loc_023206BA	; 023206AC
loc_023206AE:
	bl loc_023207B4	; 023206AE
	mov r1,#0x4	; 023206B2
	ldr r0,[pool_023207A4]	; 023206B4
	str r1,[r0,#0x4]	; 023206B6
	b loc_02320792	; 023206B8
loc_023206BA:
	ldr r0,[pool_023207A8]	; 023206BA
	ldr r0,[r0,#0x68]	; 023206BC
	lsl r0,r0,#0x1a	; 023206BE
	lsr r0,r0,#0x1f	; 023206C0
	cmp r0,#0x0	; 023206C2
	beq loc_023206D2	; 023206C4
	add r0,r5,#0x0	; 023206C6
	mov r1,#0x3	; 023206C8
	bl loc_02321D10	; 023206CA
	cmp r0,#0x0	; 023206CE
	bne loc_023206E0	; 023206D0
loc_023206D2:
	mov r0,#0x1	; 023206D2
	bl loc_0232414C	; 023206D4
	cmp r0,#0x0	; 023206D8
	beq loc_023206EC	; 023206DA
	cmp r4,#0x1	; 023206DC
	bne loc_023206EC	; 023206DE
loc_023206E0:
	bl loc_023207B4	; 023206E0
	mov r1,#0x1	; 023206E4
	ldr r0,[pool_023207A4]	; 023206E6
	str r1,[r0,#0x4]	; 023206E8
	b loc_02320792	; 023206EA
loc_023206EC:
	add r0,r5,#0x0	; 023206EC
	mov r1,#0x4	; 023206EE
	bl loc_02321D08	; 023206F0
	cmp r0,#0x0	; 023206F4
	bne loc_02320706	; 023206F6
	mov r0,#0x1	; 023206F8
	bl loc_0232414C	; 023206FA
	cmp r0,#0x0	; 023206FE
	beq loc_02320722	; 02320700
	cmp r4,#0x5	; 02320702
	bne loc_02320722	; 02320704
loc_02320706:
	mov r0,#0x26	; 02320706
	bl loc_02323724	; 02320708
	bl loc_023253E4	; 0232070C
	ldr r1,[pool_023207A8]	; 02320710
	ldr r2,[r1,#0x68]	; 02320712
	mov r0,#0x80	; 02320714
	orr r2,r0	; 02320716
	str r2,[r1,#0x68]	; 02320718
	mov r1,#0x8	; 0232071A
	ldr r0,[pool_023207A0]	; 0232071C
	str r1,[r0,#0x2c]	; 0232071E
	b loc_02320792	; 02320720
loc_02320722:
	add r0,r5,#0x0	; 02320722
	mov r1,#0x6	; 02320724
	bl loc_02321D08	; 02320726
	cmp r0,#0x0	; 0232072A
	bne loc_0232073C	; 0232072C
	mov r0,#0x1	; 0232072E
	bl loc_0232414C	; 02320730
	cmp r0,#0x0	; 02320734
	beq loc_02320792	; 02320736
	cmp r4,#0x6	; 02320738
	bne loc_02320792	; 0232073A
loc_0232073C:
	bl P1_GetFirmwareUiContext	; 0232073C
	add r4,r0,#0x0	; 02320740
	bl P1_GetFirmwareUiContext	; 02320742
	ldr r0,[r0,#0x0]	; 02320746
	lsl r0,r0,#0x16	; 02320748
	lsr r0,r0,#0x1f	; 0232074A
	cmp r0,#0x0	; 0232074C
	bne loc_02320754	; 0232074E
	mov r2,#0x1	; 02320750
	b loc_02320756	; 02320752
loc_02320754:
	mov r2,#0x0	; 02320754
loc_02320756:
	ldr r1,[r4,#0x0]	; 02320756
	ldr r0,[pool_023207B0]	; 02320758
	and r1,r0	; 0232075A
	mov r0,#0x1	; 0232075C
	and r2,r0	; 0232075E
	lsl r0,r2,#0x9	; 02320760
	orr r1,r0	; 02320762
	str r1,[r4,#0x0]	; 02320764
	bl P1_GetFirmwareUiContext	; 02320766
	ldr r0,[r0,#0x0]	; 0232076A
	lsl r0,r0,#0x16	; 0232076C
	lsr r0,r0,#0x1f	; 0232076E
	cmp r0,#0x0	; 02320770
	beq loc_02320784	; 02320772
	mov r0,#0x2d	; 02320774
	bl loc_02323724	; 02320776
	mov r0,#0x2	; 0232077A
	mov r1,#0x1	; 0232077C
	bl loc_0232F200	; 0232077E
	b loc_02320792	; 02320782
loc_02320784:
	mov r0,#0x2e	; 02320784
	bl loc_02323724	; 02320786
	mov r0,#0x2	; 0232078A
	mov r1,#0x0	; 0232078C
	bl loc_0232F200	; 0232078E
loc_02320792:
	add sp,#0x4	; 02320792
	pop {r4,r5}	; 02320794
	pop {r3}	; 02320796
	bx r3	; 02320798
	.byte 0xC0, 0x46	; 0232079C
pool_0232079C:
loc_0232079C:
	.word 0x02330A80	; 0232079C
pool_023207A0:
loc_023207A0:
	.word P1_BssStart + 0x100	; 023207A0
pool_023207A4:
loc_023207A4:
	.word P1_BssStart + 0xB00	; 023207A4
pool_023207A8:
loc_023207A8:
	.word P1_BssStart + 0x1300	; 023207A8
pool_023207AC:
loc_023207AC:
	.word 0x00000800	; 023207AC
pool_023207B0:
loc_023207B0:
	.word 0xFFFFFDFF	; 023207B0

; ===== function loc_023207B4 =====
loc_023207B4:
	push {lr}	; 023207B4
	sub sp,#0x4	; 023207B6
	mov r0,#0x1a	; 023207B8
	bl loc_02323724	; 023207BA
	mov r1,#0x6	; 023207BE
	ldr r0,[pool_023207CC]	; 023207C0
	str r1,[r0,#0x2c]	; 023207C2
	add sp,#0x4	; 023207C4
	pop {r3}	; 023207C6
	bx r3	; 023207C8
	.byte 0xC0, 0x46	; 023207CC
pool_023207CC:
loc_023207CC:
	.word P1_BssStart + 0x100	; 023207CC

; ===== function loc_023207D0 =====
loc_023207D0:
	push {lr}	; 023207D0
	sub sp,#0x4	; 023207D2
	ldr r0,[pool_0232080C]	; 023207D4
	ldr r1,[r0,#0x8]	; 023207D6
	add r1,r1,#0x1	; 023207D8
	str r1,[r0,#0x8]	; 023207DA
	cmp r1,#0xf	; 023207DC
	bgt loc_023207F6	; 023207DE
	lsl r0,r1,#0x4	; 023207E0
	mov r1,#0xf	; 023207E2
	blx P1_SignedDivMod	; 023207E4
	mov r1,#0x10	; 023207E8
	sub r1,r1,r0	; 023207EA
	lsl r1,r1,#0x8	; 023207EC
	orr r0,r1	; 023207EE
	ldr r1,[pool_02320810]	; 023207F0
	strh r0,[r1,#0x0]	; 023207F2
	b loc_02320804	; 023207F4
loc_023207F6:
	mov r2,#0x0	; 023207F6
	ldr r1,[pool_02320814]	; 023207F8
	strh r2,[r1,#0x0]	; 023207FA
	str r2,[r0,#0x8]	; 023207FC
	mov r1,#0x5	; 023207FE
	ldr r0,[pool_02320818]	; 02320800
	str r1,[r0,#0x2c]	; 02320802
loc_02320804:
	add sp,#0x4	; 02320804
	pop {r3}	; 02320806
	bx r3	; 02320808
	.byte 0xC0, 0x46	; 0232080C
pool_0232080C:
loc_0232080C:
	.word P1_BssStart + 0xB00	; 0232080C
pool_02320810:
loc_02320810:
	.word REG_BLDALPHA_SUB	; 02320810
pool_02320814:
loc_02320814:
	.word REG_BLDCNT_SUB	; 02320814
pool_02320818:
loc_02320818:
	.word P1_BssStart + 0x100	; 02320818

; ===== function loc_0232081C =====
loc_0232081C:
	push {lr}	; 0232081C
	sub sp,#0x4	; 0232081E
	ldr r0,[pool_02320870]	; 02320820
	ldr r1,[r0,#0x8]	; 02320822
	add r1,r1,#0x1	; 02320824
	str r1,[r0,#0x8]	; 02320826
	cmp r1,#0xf	; 02320828
	bgt loc_02320842	; 0232082A
	lsl r0,r1,#0x4	; 0232082C
	mov r1,#0xf	; 0232082E
	blx P1_SignedDivMod	; 02320830
	mov r1,#0x10	; 02320834
	sub r1,r1,r0	; 02320836
	lsl r1,r1,#0x8	; 02320838
	orr r0,r1	; 0232083A
	ldr r1,[pool_02320874]	; 0232083C
	strh r0,[r1,#0x0]	; 0232083E
	b loc_02320868	; 02320840
loc_02320842:
	mov r0,#0x10	; 02320842
	str r0,[sp,#0x0]	; 02320844
	ldr r0,[pool_02320878]	; 02320846
	mov r1,#0x0	; 02320848
	mov r2,#0x2	; 0232084A
	add r3,r1,#0x0	; 0232084C
	bl loc_0232D968	; 0232084E
	mov r1,#0x0	; 02320852
	ldr r0,[pool_02320870]	; 02320854
	str r1,[r0,#0x8]	; 02320856
	ldr r1,[pool_0232087C]	; 02320858
	ldr r2,[r1,#0x68]	; 0232085A
	mov r0,#0x2	; 0232085C
	orr r2,r0	; 0232085E
	str r2,[r1,#0x68]	; 02320860
	mov r1,#0x4	; 02320862
	ldr r0,[pool_02320880]	; 02320864
	str r1,[r0,#0x2c]	; 02320866
loc_02320868:
	add sp,#0x4	; 02320868
	pop {r3}	; 0232086A
	bx r3	; 0232086C
	.byte 0xC0, 0x46	; 02320870
pool_02320870:
loc_02320870:
	.word P1_BssStart + 0xB00	; 02320870
pool_02320874:
loc_02320874:
	.word REG_BLDALPHA_SUB	; 02320874
pool_02320878:
loc_02320878:
	.word REG_BLDCNT_SUB	; 02320878
pool_0232087C:
loc_0232087C:
	.word P1_BssStart + 0x1300	; 0232087C
pool_02320880:
loc_02320880:
	.word P1_BssStart + 0x100	; 02320880

; ===== function loc_02320884 =====
loc_02320884:
	push {r4,r5,lr}	; 02320884
	sub sp,#0x4	; 02320886
	mov r5,#0x0	; 02320888
	bl P1_GetFirmwareUiContext	; 0232088A
	add r4,r0,#0x0	; 0232088E
	ldr r0,[pool_02320948]	; 02320890
	bl loc_02321914	; 02320892
	ldr r0,[pool_0232094C]	; 02320896
	ldr r1,[r0,#0x8]	; 02320898
	add r1,r1,#0x1	; 0232089A
	str r1,[r0,#0x8]	; 0232089C
	cmp r1,#0xf	; 0232089E
	bgt loc_023208D0	; 023208A0
	lsl r0,r1,#0x4	; 023208A2
	mov r1,#0xf	; 023208A4
	blx P1_SignedDivMod	; 023208A6
	mov r1,#0x10	; 023208AA
	sub r1,r1,r0	; 023208AC
	lsl r0,r0,#0x8	; 023208AE
	orr r1,r0	; 023208B0
	ldr r0,[pool_02320950]	; 023208B2
	strh r1,[r0,#0x0]	; 023208B4
	ldr r0,[pool_0232094C]	; 023208B6
	ldr r0,[r0,#0x8]	; 023208B8
	cmp r0,#0xf	; 023208BA
	bne loc_0232093C	; 023208BC
	ldr r1,[pool_02320954]	; 023208BE
	ldr r2,[r1,#0x68]	; 023208C0
	mov r0,#0x1	; 023208C2
	bic r2,r0	; 023208C4
	str r2,[r1,#0x68]	; 023208C6
	ldr r0,[pool_02320958]	; 023208C8
	and r2,r0	; 023208CA
	str r2,[r1,#0x68]	; 023208CC
	b loc_0232093C	; 023208CE
loc_023208D0:
	ldr r1,[r4,#0x0]	; 023208D0
	lsl r0,r1,#0x1a	; 023208D2
	lsr r0,r0,#0x1f	; 023208D4
	cmp r0,#0x0	; 023208D6
	bne loc_023208E2	; 023208D8
	lsl r0,r1,#0x19	; 023208DA
	lsr r0,r0,#0x1f	; 023208DC
	cmp r0,#0x0	; 023208DE
	beq loc_023208EA	; 023208E0
loc_023208E2:
	bl loc_023236D0	; 023208E2
	mov r5,#0x4	; 023208E6
	b loc_0232093C	; 023208E8
loc_023208EA:
	lsl r0,r1,#0x17	; 023208EA
	lsr r0,r0,#0x1f	; 023208EC
	cmp r0,#0x0	; 023208EE
	beq loc_023208FA	; 023208F0
	bl loc_023236D0	; 023208F2
	mov r5,#0x1	; 023208F6
	b loc_0232093C	; 023208F8
loc_023208FA:
	bl loc_023236D0	; 023208FA
	ldr r1,[pool_0232095C]	; 023208FE
	ldr r2,[r1,#0x0]	; 02320900
	ldr r0,[pool_02320960]	; 02320902
	and r2,r0	; 02320904
	ldr r0,[pool_02320964]	; 02320906
	orr r2,r0	; 02320908
	str r2,[r1,#0x0]	; 0232090A
	mov r0,#0x10	; 0232090C
	str r0,[sp,#0x0]	; 0232090E
	ldr r0,[pool_02320968]	; 02320910
	mov r1,#0x2	; 02320912
	mov r2,#0x20	; 02320914
	lsl r3,r5,#0	; 02320916
	bl loc_0232D968	; 02320918
	bl loc_02322A60	; 0232091C
	ldr r1,[pool_02320954]	; 02320920
	ldr r2,[r1,#0x68]	; 02320922
	mov r0,#0x8	; 02320924
	orr r2,r0	; 02320926
	str r2,[r1,#0x68]	; 02320928
	mov r0,#0x4	; 0232092A
	orr r2,r0	; 0232092C
	str r2,[r1,#0x68]	; 0232092E
	lsl r1,r5,#0	; 02320930
	ldr r0,[pool_0232094C]	; 02320932
	str r1,[r0,#0x8]	; 02320934
	mov r1,#0x3	; 02320936
	ldr r0,[pool_0232096C]	; 02320938
	str r1,[r0,#0x2c]	; 0232093A
loc_0232093C:
	add r0,r5,#0x0	; 0232093C
	add sp,#0x4	; 0232093E
	pop {r4,r5}	; 02320940
	pop {r3}	; 02320942
	bx r3	; 02320944
	.byte 0xC0, 0x46	; 02320948
pool_02320948:
loc_02320948:
	.word 0x02330C00	; 02320948
pool_0232094C:
loc_0232094C:
	.word P1_BssStart + 0xB00	; 0232094C
pool_02320950:
loc_02320950:
	.word REG_BLDALPHA_SUB	; 02320950
pool_02320954:
loc_02320954:
	.word P1_BssStart + 0x1300	; 02320954
pool_02320958:
loc_02320958:
	.word 0xFFFFFDFF	; 02320958
pool_0232095C:
loc_0232095C:
	.word REG_DISPCNT_B	; 0232095C
pool_02320960:
loc_02320960:
	.word 0xFFFFE0FF	; 02320960
pool_02320964:
loc_02320964:
	.word 0x00001200	; 02320964
pool_02320968:
loc_02320968:
	.word REG_BLDCNT_SUB	; 02320968
pool_0232096C:
loc_0232096C:
	.word P1_BssStart + 0x100	; 0232096C

; ===== function loc_02320970 =====
loc_02320970:
	push {r4,r5,lr}	; 02320970
	sub sp,#0x4	; 02320972
	ldr r0,[pool_02320A90]	; 02320974
	ldr r1,[r0,#0x8]	; 02320976
	add r1,r1,#0x1	; 02320978
	str r1,[r0,#0x8]	; 0232097A
	ldr r0,[pool_02320A94]	; 0232097C
	bl loc_02321914	; 0232097E
	ldr r0,[pool_02320A98]	; 02320982
	ldr r0,[r0,#0x68]	; 02320984
	lsl r0,r0,#0x17	; 02320986
	lsr r0,r0,#0x1f	; 02320988
	cmp r0,#0x0	; 0232098A
	beq loc_023209F6	; 0232098C
	ldr r0,[pool_02320A90]	; 0232098E
	ldr r5,[r0,#0x8]	; 02320990
	sub r5,#0x5a	; 02320992
	add r0,r5,#0x0	; 02320994
	mov r1,#0x1e	; 02320996
	blx P1_SignedDivMod	; 02320998
	add r4,r1,#0x0	; 0232099C
	add r0,r5,#0x0	; 0232099E
	mov r1,#0x1e	; 023209A0
	blx P1_SignedDivMod	; 023209A2
	mov r1,#0x1	; 023209A6
	and r0,r1	; 023209A8
	cmp r0,#0x0	; 023209AA
	beq loc_023209D4	; 023209AC
	mov r0,#0x1f	; 023209AE
	add r5,r4,#0x0	; 023209B0
	mul r5,r0	; 023209B2
	add r0,r5,#0x0	; 023209B4
	mov r1,#0x1e	; 023209B6
	blx P1_SignedDivMod	; 023209B8
	ldr r1,[pool_02320A98]	; 023209BC
	str r0,[r1,#0x5c]	; 023209BE
	mov r1,#0x1e	; 023209C0
	sub r2,r1,r4	; 023209C2
	mov r0,#0x14	; 023209C4
	mul r2,r0	; 023209C6
	add r0,r5,r2	; 023209C8
	blx P1_SignedDivMod	; 023209CA
	ldr r1,[pool_02320A98]	; 023209CE
	str r0,[r1,#0x60]	; 023209D0
	b loc_023209F6	; 023209D2
loc_023209D4:
	mov r1,#0x1e	; 023209D4
	sub r5,r1,r4	; 023209D6
	mov r0,#0x1f	; 023209D8
	mul r5,r0	; 023209DA
	add r0,r5,#0x0	; 023209DC
	blx P1_SignedDivMod	; 023209DE
	ldr r1,[pool_02320A98]	; 023209E2
	str r0,[r1,#0x5c]	; 023209E4
	mov r0,#0x14	; 023209E6
	mul r4,r0	; 023209E8
	add r0,r4,r5	; 023209EA
	mov r1,#0x1e	; 023209EC
	blx P1_SignedDivMod	; 023209EE
	ldr r1,[pool_02320A98]	; 023209F2
	str r0,[r1,#0x60]	; 023209F4
loc_023209F6:
	ldr r0,[pool_02320A90]	; 023209F6
	ldr r0,[r0,#0x8]	; 023209F8
	cmp r0,#0x5a	; 023209FA
	bne loc_02320A08	; 023209FC
	ldr r1,[pool_02320A98]	; 023209FE
	ldr r2,[r1,#0x68]	; 02320A00
	ldr r0,[pool_02320A9C]	; 02320A02
	orr r2,r0	; 02320A04
	str r2,[r1,#0x68]	; 02320A06
loc_02320A08:
	ldr r0,[pool_02320A90]	; 02320A08
	ldr r0,[r0,#0x8]	; 02320A0A
	cmp r0,#0x5a	; 02320A0C
	ble loc_02320A86	; 02320A0E
	ldr r0,[pool_02320AA0]	; 02320A10
	bl loc_0232413C	; 02320A12
	cmp r0,#0x0	; 02320A16
	bne loc_02320A48	; 02320A18
	bl loc_02324120	; 02320A1A
	cmp r0,#0x0	; 02320A1E
	bne loc_02320A48	; 02320A20
	ldr r0,[pool_02320A90]	; 02320A22
	ldr r1,[r0,#0x8]	; 02320A24
	ldr r0,[pool_02320AA4]	; 02320A26
	cmp r1,r0	; 02320A28
	bgt loc_02320A48	; 02320A2A
	bl P1_GetFirmwareUiContext	; 02320A2C
	ldr r0,[r0,#0x0]	; 02320A30
	lsl r0,r0,#0x17	; 02320A32
	lsr r0,r0,#0x1f	; 02320A34
	cmp r0,#0x0	; 02320A36
	bne loc_02320A48	; 02320A38
	bl P1_GetFirmwareUiContext	; 02320A3A
	ldr r0,[r0,#0x0]	; 02320A3E
	lsl r0,r0,#0x19	; 02320A40
	lsr r0,r0,#0x1f	; 02320A42
	cmp r0,#0x0	; 02320A44
	beq loc_02320A86	; 02320A46
loc_02320A48:
	ldr r0,[pool_02320A90]	; 02320A48
	ldr r1,[r0,#0x8]	; 02320A4A
	ldr r0,[pool_02320AA4]	; 02320A4C
	cmp r1,r0	; 02320A4E
	bgt loc_02320A74	; 02320A50
	bl P1_GetFirmwareUiContext	; 02320A52
	ldr r0,[r0,#0x0]	; 02320A56
	lsl r0,r0,#0x17	; 02320A58
	lsr r0,r0,#0x1f	; 02320A5A
	cmp r0,#0x0	; 02320A5C
	bne loc_02320A74	; 02320A5E
	bl P1_GetFirmwareUiContext	; 02320A60
	ldr r0,[r0,#0x0]	; 02320A64
	lsl r0,r0,#0x19	; 02320A66
	lsr r0,r0,#0x1f	; 02320A68
	cmp r0,#0x0	; 02320A6A
	bne loc_02320A74	; 02320A6C
	mov r0,#0x31	; 02320A6E
	bl loc_02323724	; 02320A70
loc_02320A74:
	ldr r0,[pool_02320A94]	; 02320A74
	bl loc_023218F0	; 02320A76
	mov r1,#0x0	; 02320A7A
	ldr r0,[pool_02320A90]	; 02320A7C
	str r1,[r0,#0x8]	; 02320A7E
	mov r1,#0x2	; 02320A80
	ldr r0,[pool_02320AA8]	; 02320A82
	str r1,[r0,#0x2c]	; 02320A84
loc_02320A86:
	add sp,#0x4	; 02320A86
	pop {r4,r5}	; 02320A88
	pop {r3}	; 02320A8A
	bx r3	; 02320A8C
	.byte 0xC0, 0x46	; 02320A90
pool_02320A90:
loc_02320A90:
	.word P1_BssStart + 0xB00	; 02320A90
pool_02320A94:
loc_02320A94:
	.word 0x02330C00	; 02320A94
pool_02320A98:
loc_02320A98:
	.word P1_BssStart + 0x1300	; 02320A98
pool_02320A9C:
loc_02320A9C:
	.word 0x00000100	; 02320A9C
pool_02320AA0:
loc_02320AA0:
	.word 0x00000FFF	; 02320AA0
pool_02320AA4:
loc_02320AA4:
	.word 0x00000E10	; 02320AA4
pool_02320AA8:
loc_02320AA8:
	.word P1_BssStart + 0x100	; 02320AA8

; ===== function loc_02320AAC =====
loc_02320AAC:
	push {lr}	; 02320AAC
	sub sp,#0x4	; 02320AAE
	ldr r0,[pool_02320AEC]	; 02320AB0
	ldr r1,[r0,#0x8]	; 02320AB2
	add r1,r1,#0x1	; 02320AB4
	str r1,[r0,#0x8]	; 02320AB6
	ldr r0,[pool_02320AF0]	; 02320AB8
	bl loc_02321914	; 02320ABA
	ldr r0,[pool_02320AEC]	; 02320ABE
	ldr r1,[r0,#0x8]	; 02320AC0
	cmp r1,#0xf	; 02320AC2
	bgt loc_02320ADC	; 02320AC4
	lsl r0,r1,#0x4	; 02320AC6
	mov r1,#0xf	; 02320AC8
	blx P1_SignedDivMod	; 02320ACA
	mov r1,#0x10	; 02320ACE
	sub r1,r1,r0	; 02320AD0
	lsl r1,r1,#0x8	; 02320AD2
	orr r0,r1	; 02320AD4
	ldr r1,[pool_02320AF4]	; 02320AD6
	strh r0,[r1,#0x0]	; 02320AD8
	b loc_02320AE6	; 02320ADA
loc_02320ADC:
	mov r1,#0x0	; 02320ADC
	str r1,[r0,#0x8]	; 02320ADE
	mov r1,#0x1	; 02320AE0
	ldr r0,[pool_02320AF8]	; 02320AE2
	str r1,[r0,#0x2c]	; 02320AE4
loc_02320AE6:
	add sp,#0x4	; 02320AE6
	pop {r3}	; 02320AE8
	bx r3	; 02320AEA
pool_02320AEC:
loc_02320AEC:
	.word P1_BssStart + 0xB00	; 02320AEC
pool_02320AF0:
loc_02320AF0:
	.word 0x02330C00	; 02320AF0
pool_02320AF4:
loc_02320AF4:
	.word REG_BLDALPHA_SUB	; 02320AF4
pool_02320AF8:
loc_02320AF8:
	.word P1_BssStart + 0x100	; 02320AF8

; ===== function loc_02320AFC =====
loc_02320AFC:
	push {r4,r5,r6,r7,lr}	; 02320AFC
	sub sp,#0x54	; 02320AFE
	bl loc_02323E7C	; 02320B00
	add r7,r0,#0x0	; 02320B04
	bl loc_02325540	; 02320B06
	bl loc_023250FC	; 02320B0A
	ldr r0,[pool_02320DA4]	; 02320B0E
	ldr r0,[r0,#0x54]	; 02320B10
	lsl r0,r0,#0x1e	; 02320B12
	lsr r0,r0,#0x1f	; 02320B14
	cmp r0,#0x0	; 02320B16
	beq loc_02320B36	; 02320B18
	mov r0,#0x1	; 02320B1A
	str r0,[sp,#0x0]	; 02320B1C
	ldr r0,[pool_02320DA8]	; 02320B1E
	mov r1,#0x0	; 02320B20
	add r2,r1,#0x0	; 02320B22
	add r3,r1,#0x0	; 02320B24
	bl loc_02323780	; 02320B26
	add r0,r7,#0x0	; 02320B2A
	ldr r1,[pool_02320DAC]	; 02320B2C
	ldr r2,[pool_02320DB0]	; 02320B2E
	mov r3,#0x0	; 02320B30
	bl loc_02323C6C	; 02320B32
loc_02320B36:
	ldr r0,[pool_02320DB4]	; 02320B36
	ldr r0,[r0,#0x68]	; 02320B38
	lsl r0,r0,#0x1f	; 02320B3A
	lsr r0,r0,#0x1f	; 02320B3C
	cmp r0,#0x0	; 02320B3E
	beq loc_02320B50	; 02320B40
	add r0,r7,#0x0	; 02320B42
	ldr r1,[pool_02320DB8]	; 02320B44
	ldr r2,[pool_02320DBC]	; 02320B46
	ldr r2,[r2,#0x14]	; 02320B48
	mov r3,#0x1	; 02320B4A
	bl loc_02323BC4	; 02320B4C
loc_02320B50:
	ldr r0,[pool_02320DB4]	; 02320B50
	ldr r1,[r0,#0x68]	; 02320B52
	lsl r0,r1,#0x16	; 02320B54
	lsr r0,r0,#0x1f	; 02320B56
	cmp r0,#0x0	; 02320B58
	beq loc_02320B66	; 02320B5A
	ldr r0,[pool_02320DC0]	; 02320B5C
	lsl r1,r1,#0x1b	; 02320B5E
	lsr r1,r1,#0x1f	; 02320B60
	bl loc_02321A24	; 02320B62
loc_02320B66:
	ldr r0,[pool_02320DB4]	; 02320B66
	ldr r0,[r0,#0x68]	; 02320B68
	lsl r0,r0,#0x1e	; 02320B6A
	lsr r0,r0,#0x1f	; 02320B6C
	cmp r0,#0x0	; 02320B6E
	bne loc_02320B74	; 02320B70
	b loc_02320D9C	; 02320B72
loc_02320B74:
	mov r4,#0x0	; 02320B74
loc_02320B76:
	add r1,r4,#0x0	; 02320B76
	mov r0,#0xc	; 02320B78
	mul r1,r0	; 02320B7A
	ldr r0,[pool_02320DC4]	; 02320B7C
	add r5,r0,r1	; 02320B7E
	ldr r0,[r5,#0x4]	; 02320B80
	ldr r1,[pool_02320DC8]	; 02320B82
	blx P1_SignedDivMod	; 02320B84
	ldr r1,[pool_02320DBC]	; 02320B88
	ldr r1,[r1,#0x10]	; 02320B8A
	add r6,r1,r0	; 02320B8C
	cmp r6,#0xf0	; 02320B8E
	ble loc_02320B94	; 02320B90
	mov r6,#0xf0	; 02320B92
loc_02320B94:
	ldr r0,[r5,#0x0]	; 02320B94
	ldr r1,[pool_02320DC8]	; 02320B96
	blx P1_SignedDivMod	; 02320B98
	str r0,[sp,#0x0]	; 02320B9C
	str r6,[sp,#0x4]	; 02320B9E
	mov r0,#0x1	; 02320BA0
	str r0,[sp,#0x8]	; 02320BA2
	add r0,r7,#0x0	; 02320BA4
	ldr r1,[pool_02320DAC]	; 02320BA6
	ldr r2,[pool_02320DCC]	; 02320BA8
	ldr r3,[r5,#0x8]	; 02320BAA
	bl loc_02323B70	; 02320BAC
	add r4,r4,#0x1	; 02320BB0
	cmp r4,#0x4	; 02320BB2
	blt loc_02320B76	; 02320BB4
	mov r0,#0x0	; 02320BB6
	str r0,[sp,#0x24]	; 02320BB8
	ldr r1,[pool_02320DD0]	; 02320BBA
	ldr r0,[r1,#0x4]	; 02320BBC
	str r0,[sp,#0x18]	; 02320BBE
	ldr r0,[r1,#0x8]	; 02320BC0
	str r0,[sp,#0x1c]	; 02320BC2
	ldr r0,[r1,#0x0]	; 02320BC4
	str r0,[sp,#0x20]	; 02320BC6
	ldr r0,[sp,#0x24]	; 02320BC8
	str r0,[sp,#0x28]	; 02320BCA
	str r0,[sp,#0x2c]	; 02320BCC
	str r0,[sp,#0x30]	; 02320BCE
	str r0,[sp,#0x40]	; 02320BD0
	str r0,[sp,#0x3c]	; 02320BD2
	str r0,[sp,#0x38]	; 02320BD4
	str r0,[sp,#0x34]	; 02320BD6
	str r0,[sp,#0x44]	; 02320BD8
loc_02320BDA:
	ldr r1,[sp,#0x24]	; 02320BDA
	mov r0,#0x3c	; 02320BDC
	mul r1,r0	; 02320BDE
	ldr r0,[pool_02320DD4]	; 02320BE0
	add r5,r0,r1	; 02320BE2
	mov r4,#0x1	; 02320BE4
	mov r0,#0x2	; 02320BE6
	ldrsh r1,[r5,r0]	; 02320BE8
	ldr r0,[pool_02320DBC]	; 02320BEA
	ldr r0,[r0,#0x10]	; 02320BEC
	add r6,r1,r0	; 02320BEE
	cmp r6,#0x80	; 02320BF0
	ble loc_02320BF6	; 02320BF2
	mov r6,#0x80	; 02320BF4
loc_02320BF6:
	ldr r0,[pool_02320DBC]	; 02320BF6
	ldr r1,[r0,#0x4]	; 02320BF8
	ldr r0,[sp,#0x24]	; 02320BFA
	cmp r0,r1	; 02320BFC
	bne loc_02320C02	; 02320BFE
	ldr r4,[sp,#0x28]	; 02320C00
loc_02320C02:
	ldr r0,[r5,#0x8]	; 02320C02
	cmp r0,#0x0	; 02320C04
	blt loc_02320C1A	; 02320C06
	str r4,[sp,#0x0]	; 02320C08
	add r0,r5,#0x0	; 02320C0A
	add r0,#0x10	; 02320C0C
	ldr r1,[sp,#0x30]	; 02320C0E
	ldrsh r1,[r5,r1]	; 02320C10
	add r2,r6,#0x0	; 02320C12
	mov r3,#0x1	; 02320C14
	bl loc_02323780	; 02320C16
loc_02320C1A:
	ldr r0,[pool_02320DD8]	; 02320C1A
	ldr r1,[r5,#0xc]	; 02320C1C
	bl loc_02321D00	; 02320C1E
	cmp r0,#0x0	; 02320C22
	beq loc_02320C30	; 02320C24
	cmp r0,#0x1	; 02320C26
	beq loc_02320C30	; 02320C28
	cmp r0,#0x2	; 02320C2A
	beq loc_02320C36	; 02320C2C
	b loc_02320C3C	; 02320C2E
loc_02320C30:
	ldr r0,[sp,#0x18]	; 02320C30
	str r0,[sp,#0x14]	; 02320C32
	b loc_02320C40	; 02320C34
loc_02320C36:
	ldr r0,[sp,#0x1c]	; 02320C36
	str r0,[sp,#0x14]	; 02320C38
	b loc_02320C40	; 02320C3A
loc_02320C3C:
	ldr r0,[sp,#0x20]	; 02320C3C
	str r0,[sp,#0x14]	; 02320C3E
loc_02320C40:
	ldr r0,[sp,#0x24]	; 02320C40
	cmp r0,#0x4	; 02320C42
	bne loc_02320CA8	; 02320C44
	ldr r0,[pool_02320DB4]	; 02320C46
	ldr r0,[r0,#0x68]	; 02320C48
	lsl r0,r0,#0x1b	; 02320C4A
	lsr r0,r0,#0x1f	; 02320C4C
	cmp r0,#0x0	; 02320C4E
	beq loc_02320C84	; 02320C50
	ldr r0,[sp,#0x34]	; 02320C52
	ldrsh r1,[r5,r0]	; 02320C54
	add r1,#0x28	; 02320C56
	ldr r0,[pool_02320DDC]	; 02320C58
	and r1,r0	; 02320C5A
	lsl r1,r1,#0x10	; 02320C5C
	add r0,r6,#0x0	; 02320C5E
	add r0,#0x4f	; 02320C60
	mov r2,#0xff	; 02320C62
	and r0,r2	; 02320C64
	lsl r2,r4,#0xa	; 02320C66
	orr r0,r2	; 02320C68
	ldr r2,[pool_02320DE0]	; 02320C6A
	orr r0,r2	; 02320C6C
	orr r1,r0	; 02320C6E
	str r1,[sp,#0x48]	; 02320C70
	ldr r1,[pool_02320DE4]	; 02320C72
	add r0,sp,#0x48	; 02320C74
	strh r1,[r0,#0x4]	; 02320C76
	add r0,r7,#0x0	; 02320C78
	add r1,sp,#0x48	; 02320C7A
	ldr r2,[sp,#0x2c]	; 02320C7C
	bl loc_023239A0	; 02320C7E
	b loc_02320D16	; 02320C82
loc_02320C84:
	mov r0,#0x4	; 02320C84
	str r0,[sp,#0x14]	; 02320C86
	ldr r0,[sp,#0x38]	; 02320C88
	ldrsh r0,[r5,r0]	; 02320C8A
	str r0,[sp,#0x0]	; 02320C8C
	str r6,[sp,#0x4]	; 02320C8E
	mov r0,#0x4	; 02320C90
	str r0,[sp,#0x8]	; 02320C92
	str r4,[sp,#0xc]	; 02320C94
	mov r0,#0x1	; 02320C96
	str r0,[sp,#0x10]	; 02320C98
	add r0,r7,#0x0	; 02320C9A
	ldr r1,[pool_02320DAC]	; 02320C9C
	ldr r2,[pool_02320DCC]	; 02320C9E
	mov r3,#0x4	; 02320CA0
	bl loc_02323A34	; 02320CA2
	b loc_02320D16	; 02320CA6
loc_02320CA8:
	cmp r0,#0x1	; 02320CA8
	bne loc_02320CEC	; 02320CAA
	ldr r0,[pool_02320DB4]	; 02320CAC
	ldr r1,[r0,#0x68]	; 02320CAE
	lsl r0,r1,#0x1a	; 02320CB0
	lsr r0,r0,#0x1f	; 02320CB2
	cmp r0,#0x0	; 02320CB4
	bne loc_02320CCC	; 02320CB6
	mov r0,#0x4	; 02320CB8
	str r0,[sp,#0x14]	; 02320CBA
	lsl r0,r1,#0x19	; 02320CBC
	lsr r0,r0,#0x1f	; 02320CBE
	cmp r0,#0x0	; 02320CC0
	bne loc_02320CC8	; 02320CC2
	mov r1,#0x4	; 02320CC4
	b loc_02320CCE	; 02320CC6
loc_02320CC8:
	ldr r1,[sp,#0x20]	; 02320CC8
	b loc_02320CCE	; 02320CCA
loc_02320CCC:
	ldr r1,[sp,#0x20]	; 02320CCC
loc_02320CCE:
	ldr r0,[sp,#0x3c]	; 02320CCE
	ldrsh r0,[r5,r0]	; 02320CD0
	str r0,[sp,#0x0]	; 02320CD2
	str r6,[sp,#0x4]	; 02320CD4
	str r1,[sp,#0x8]	; 02320CD6
	str r4,[sp,#0xc]	; 02320CD8
	mov r0,#0x1	; 02320CDA
	str r0,[sp,#0x10]	; 02320CDC
	add r0,r7,#0x0	; 02320CDE
	ldr r1,[pool_02320DAC]	; 02320CE0
	ldr r2,[pool_02320DCC]	; 02320CE2
	mov r3,#0x5	; 02320CE4
	bl loc_02323A34	; 02320CE6
	b loc_02320D16	; 02320CEA
loc_02320CEC:
	cmp r0,#0x3	; 02320CEC
	bne loc_02320D16	; 02320CEE
	ldr r0,[pool_02320DB4]	; 02320CF0
	ldr r0,[r0,#0x58]	; 02320CF2
	cmp r0,#0x0	; 02320CF4
	bne loc_02320D16	; 02320CF6
	ldr r0,[sp,#0x40]	; 02320CF8
	ldrsh r0,[r5,r0]	; 02320CFA
	str r0,[sp,#0x0]	; 02320CFC
	str r6,[sp,#0x4]	; 02320CFE
	ldr r0,[sp,#0x14]	; 02320D00
	str r0,[sp,#0x8]	; 02320D02
	str r4,[sp,#0xc]	; 02320D04
	mov r0,#0x1	; 02320D06
	str r0,[sp,#0x10]	; 02320D08
	add r0,r7,#0x0	; 02320D0A
	ldr r1,[pool_02320DAC]	; 02320D0C
	ldr r2,[pool_02320DCC]	; 02320D0E
	mov r3,#0xd	; 02320D10
	bl loc_02323A34	; 02320D12
loc_02320D16:
	ldr r0,[sp,#0x44]	; 02320D16
	ldrsh r0,[r5,r0]	; 02320D18
	str r0,[sp,#0x0]	; 02320D1A
	str r6,[sp,#0x4]	; 02320D1C
	ldr r0,[sp,#0x14]	; 02320D1E
	str r0,[sp,#0x8]	; 02320D20
	str r4,[sp,#0xc]	; 02320D22
	mov r0,#0x1	; 02320D24
	str r0,[sp,#0x10]	; 02320D26
	add r0,r7,#0x0	; 02320D28
	ldr r1,[pool_02320DAC]	; 02320D2A
	ldr r2,[pool_02320DCC]	; 02320D2C
	ldr r3,[r5,#0x4]	; 02320D2E
	bl loc_02323A34	; 02320D30
	ldr r0,[sp,#0x24]	; 02320D34
	add r0,r0,#0x1	; 02320D36
	str r0,[sp,#0x24]	; 02320D38
	cmp r0,#0x5	; 02320D3A
	bge loc_02320D40	; 02320D3C
	b loc_02320BDA	; 02320D3E
loc_02320D40:
	ldr r0,[pool_02320DBC]	; 02320D40
	ldr r4,[r0,#0x10]	; 02320D42
	cmp r4,#0x30	; 02320D44
	blt loc_02320D4A	; 02320D46
	mov r4,#0x30	; 02320D48
loc_02320D4A:
	bl P1_GetFirmwareUiContext	; 02320D4A
	mov r1,#0x0	; 02320D4E
	str r1,[sp,#0x0]	; 02320D50
	str r4,[sp,#0x4]	; 02320D52
	ldr r0,[r0,#0x0]	; 02320D54
	lsl r0,r0,#0x16	; 02320D56
	lsr r0,r0,#0x1f	; 02320D58
	lsl r1,r0,#0x2	; 02320D5A
	ldr r0,[pool_02320DE8]	; 02320D5C
	ldr r0,[r0,r1]	; 02320D5E
	str r0,[sp,#0x8]	; 02320D60
	mov r0,#0x1	; 02320D62
	str r0,[sp,#0xc]	; 02320D64
	str r0,[sp,#0x10]	; 02320D66
	add r0,r7,#0x0	; 02320D68
	ldr r1,[pool_02320DAC]	; 02320D6A
	ldr r2,[pool_02320DCC]	; 02320D6C
	mov r3,#0x8	; 02320D6E
	bl loc_02323A34	; 02320D70
	mov r0,#0x0	; 02320D74
	str r0,[sp,#0x0]	; 02320D76
	str r4,[sp,#0x4]	; 02320D78
	ldr r0,[pool_02320DB4]	; 02320D7A
	ldr r0,[r0,#0x68]	; 02320D7C
	lsl r0,r0,#0x18	; 02320D7E
	lsr r0,r0,#0x1f	; 02320D80
	lsl r1,r0,#0x2	; 02320D82
	ldr r0,[pool_02320DEC]	; 02320D84
	ldr r0,[r0,r1]	; 02320D86
	str r0,[sp,#0x8]	; 02320D88
	mov r0,#0x1	; 02320D8A
	str r0,[sp,#0xc]	; 02320D8C
	str r0,[sp,#0x10]	; 02320D8E
	add r0,r7,#0x0	; 02320D90
	ldr r1,[pool_02320DAC]	; 02320D92
	ldr r2,[pool_02320DCC]	; 02320D94
	mov r3,#0x7	; 02320D96
	bl loc_02323A34	; 02320D98
loc_02320D9C:
	add sp,#0x54	; 02320D9C
	pop {r4,r5,r6,r7}	; 02320D9E
	pop {r3}	; 02320DA0
	bx r3	; 02320DA2
pool_02320DA4:
loc_02320DA4:
	.word P1_BssStart + 0xA80	; 02320DA4
pool_02320DA8:
loc_02320DA8:
	.word 0x02331558	; 02320DA8
pool_02320DAC:
loc_02320DAC:
	.word 0x023C1178	; 02320DAC
pool_02320DB0:
loc_02320DB0:
	.word 0x023A508C	; 02320DB0
pool_02320DB4:
loc_02320DB4:
	.word P1_BssStart + 0x1300	; 02320DB4
pool_02320DB8:
loc_02320DB8:
	.word 0x023D3ABC	; 02320DB8
pool_02320DBC:
loc_02320DBC:
	.word P1_BssStart + 0xB00	; 02320DBC
pool_02320DC0:
loc_02320DC0:
	.word 0x02330C00	; 02320DC0
pool_02320DC4:
loc_02320DC4:
	.word 0x02330BC4	; 02320DC4
pool_02320DC8:
loc_02320DC8:
	.word 0x00001000	; 02320DC8
pool_02320DCC:
loc_02320DCC:
	.word 0x023A4FE4	; 02320DCC
pool_02320DD0:
loc_02320DD0:
	.word P1_Data_0232FEA4	; 02320DD0
pool_02320DD4:
loc_02320DD4:
	.word 0x02330A80	; 02320DD4
pool_02320DD8:
loc_02320DD8:
	.word 0x02330BB4	; 02320DD8
pool_02320DDC:
loc_02320DDC:
	.word 0x000001FF	; 02320DDC
pool_02320DE0:
loc_02320DE0:
	.word 0x80000000	; 02320DE0
pool_02320DE4:
loc_02320DE4:
	.word 0x0000E7FC	; 02320DE4
pool_02320DE8:
loc_02320DE8:
	.word P1_Data_0232FE9C	; 02320DE8
pool_02320DEC:
loc_02320DEC:
	.word P1_Data_0232FE94	; 02320DEC

; ===== function loc_02320DF0 =====
loc_02320DF0:
	push {r4,r5,r6,r7,lr}	; 02320DF0
	sub sp,#0x12c	; 02320DF2
	bl loc_0232425C	; 02320DF4
	bl loc_0232415C	; 02320DF8
	mov r0,#0x0	; 02320DFC
	str r0,[sp,#0x8]	; 02320DFE
	ldr r0,[sp,#0x8]	; 02320E00
	ldr r1,[pool_023211C4]	; 02320E02
	ldr r2,[pool_023211C8]	; 02320E04
	blx loc_0232DE78	; 02320E06
	ldr r0,[pool_023211CC]	; 02320E0A
	bl loc_02321D54	; 02320E0C
	mov r5,#0x0	; 02320E10
	ldr r4,[pool_023211C4]	; 02320E12
	ldr r6,[pool_023211D0]	; 02320E14
	mov r7,#0x3c	; 02320E16
loc_02320E18:
	add r0,r5,#0x0	; 02320E18
	mul r0,r7	; 02320E1A
	lsl r1,r5,#0x4	; 02320E1C
	add r3,r6,r1	; 02320E1E
	add r2,r4,r0	; 02320E20
	ldmia r3!,{r0,r1}	; 02320E22
	stmia r2!,{r0,r1}	; 02320E24
	ldmia r3!,{r0,r1}	; 02320E26
	stmia r2!,{r0,r1}	; 02320E28
	add r5,r5,#0x1	; 02320E2A
	cmp r5,#0x5	; 02320E2C
	blt loc_02320E18	; 02320E2E
	mov r1,#0x5	; 02320E30
	ldr r0,[pool_023211D4]	; 02320E32
	str r1,[r0,#0x30]	; 02320E34
	mov r0,#0x0	; 02320E36
	mvn r1,r0	; 02320E38
	ldr r0,[pool_023211D8]	; 02320E3A
	str r1,[r0,#0x4]	; 02320E3C
	mov r0,#0x1f	; 02320E3E
	ldr r1,[pool_023211DC]	; 02320E40
	str r0,[r1,#0x5c]	; 02320E42
	str r0,[r1,#0x60]	; 02320E44
	ldr r0,[pool_023211E0]	; 02320E46
	ldrh r0,[r0,#0x0]	; 02320E48
	lsl r0,r0,#0x1d	; 02320E4A
	lsr r0,r0,#0x1d	; 02320E4C
	str r0,[r1,#0x58]	; 02320E4E
	bl loc_02324DF0	; 02320E50
	add r0,sp,#0x14	; 02320E54
	bl loc_02326A64	; 02320E56
	ldr r1,[sp,#0x18]	; 02320E5A
	ldr r2,[pool_023211E4]	; 02320E5C
	ldrb r0,[r2,#0x0]	; 02320E5E
	cmp r1,r0	; 02320E60
	bne loc_02320E70	; 02320E62
	ldr r1,[sp,#0x1c]	; 02320E64
	ldrb r0,[r2,#0x1]	; 02320E66
	cmp r1,r0	; 02320E68
	bne loc_02320E70	; 02320E6A
	mov r3,#0x1	; 02320E6C
	b loc_02320E72	; 02320E6E
loc_02320E70:
	mov r3,#0x0	; 02320E70
loc_02320E72:
	ldr r1,[pool_023211DC]	; 02320E72
	ldr r2,[r1,#0x68]	; 02320E74
	ldr r0,[pool_023211E8]	; 02320E76
	and r2,r0	; 02320E78
	mov r0,#0x1	; 02320E7A
	and r3,r0	; 02320E7C
	lsl r0,r3,#0xa	; 02320E7E
	orr r2,r0	; 02320E80
	str r2,[r1,#0x68]	; 02320E82
	bl loc_0232D4BC	; 02320E84
	ldr r2,[pool_023211EC]	; 02320E88
	ldr r1,[r2,#0x0]	; 02320E8A
	ldr r0,[pool_023211F0]	; 02320E8C
	and r1,r0	; 02320E8E
	str r1,[r2,#0x0]	; 02320E90
	ldr r0,[pool_023211F4]	; 02320E92
	bl loc_0232D740	; 02320E94
	mov r0,#0x0	; 02320E98
	str r0,[sp,#0xc]	; 02320E9A
	ldr r0,[sp,#0xc]	; 02320E9C
	ldr r1,[pool_023211F8]	; 02320E9E
	ldr r2,[pool_023211FC]	; 02320EA0
	blx loc_0232DE78	; 02320EA2
	bl loc_0232D640	; 02320EA6
	mov r0,#0xc0	; 02320EAA
	str r0,[sp,#0x4]	; 02320EAC
	ldr r0,[sp,#0x4]	; 02320EAE
	ldr r1,[pool_02321200]	; 02320EB0
	ldr r2,[pool_02321204]	; 02320EB2
	blx loc_0232DE78	; 02320EB4
	mov r0,#0x0	; 02320EB8
	str r0,[sp,#0x10]	; 02320EBA
	ldr r0,[sp,#0x10]	; 02320EBC
	ldr r1,[pool_02321208]	; 02320EBE
	ldr r2,[pool_02321204]	; 02320EC0
	blx loc_0232DE78	; 02320EC2
	mov r0,#0x1	; 02320EC6
	bl loc_02326D80	; 02320EC8
	mov r0,#0x2	; 02320ECC
	bl loc_02326D54	; 02320ECE
	mov r0,#0x1	; 02320ED2
	mov r1,#0x0	; 02320ED4
	add r2,r1,#0x0	; 02320ED6
	bl loc_0232D430	; 02320ED8
	ldr r2,[pool_0232120C]	; 02320EDC
	ldrh r1,[r2,#0x0]	; 02320EDE
	mov r0,#0x43	; 02320EE0
	and r1,r0	; 02320EE2
	mov r0,#0x8	; 02320EE4
	orr r1,r0	; 02320EE6
	strh r1,[r2,#0x0]	; 02320EE8
	ldrh r1,[r2,#0x0]	; 02320EEA
	mov r0,#0x3	; 02320EEC
	bic r1,r0	; 02320EEE
	strh r1,[r2,#0x0]	; 02320EF0
	mov r1,#0x0	; 02320EF2
	ldr r0,[pool_02321210]	; 02320EF4
	str r1,[r0,#0x0]	; 02320EF6
	ldr r2,[pool_02321214]	; 02320EF8
	ldr r3,[r2,#0x0]	; 02320EFA
	ldr r0,[pool_02321218]	; 02320EFC
	and r3,r0	; 02320EFE
	ldr r0,[pool_0232121C]	; 02320F00
	orr r3,r0	; 02320F02
	str r3,[r2,#0x0]	; 02320F04
	ldr r2,[pool_02321220]	; 02320F06
	ldr r0,[pool_02321224]	; 02320F08
	sub r6,r2,r0	; 02320F0A
	add r2,r6,#0x0	; 02320F0C
	bl loc_0232DA50	; 02320F0E
	ldr r1,[pool_02321228]	; 02320F12
	ldr r0,[pool_0232122C]	; 02320F14
	sub r7,r1,r0	; 02320F16
	mov r1,#0x0	; 02320F18
	add r2,r7,#0x0	; 02320F1A
	bl loc_0232DD20	; 02320F1C
	ldr r0,[pool_02321230]	; 02320F20
	mov r1,#0x0	; 02320F22
	ldr r2,[pool_02321234]	; 02320F24
	sub r2,r2,r0	; 02320F26
	bl loc_0232DB90	; 02320F28
	ldr r0,[pool_02321238]	; 02320F2C
	mov r1,#0x0	; 02320F2E
	ldr r2,[pool_0232123C]	; 02320F30
	sub r2,r2,r0	; 02320F32
	bl loc_0232DCD0	; 02320F34
	ldr r0,[pool_02321240]	; 02320F38
	mov r1,#0x0	; 02320F3A
	mov r2,#0x2	; 02320F3C
	bl loc_0232DD20	; 02320F3E
	mov r0,#0x4	; 02320F42
	bl loc_02326D28	; 02320F44
	mov r0,#0x8	; 02320F48
	bl loc_02326CFC	; 02320F4A
	mov r0,#0x0	; 02320F4E
	bl loc_0232D41C	; 02320F50
	ldr r4,[pool_02321244]	; 02320F54
	ldrh r2,[r4,#0x0]	; 02320F56
	mov r1,#0x43	; 02320F58
	and r2,r1	; 02320F5A
	ldr r0,[pool_02321248]	; 02320F5C
	orr r2,r0	; 02320F5E
	strh r2,[r4,#0x0]	; 02320F60
	ldrh r0,[r4,#0x0]	; 02320F62
	mov r2,#0x3	; 02320F64
	bic r0,r2	; 02320F66
	strh r0,[r4,#0x0]	; 02320F68
	ldrh r0,[r4,#0x0]	; 02320F6A
	mov r3,#0x40	; 02320F6C
	bic r0,r3	; 02320F6E
	strh r0,[r4,#0x0]	; 02320F70
	ldr r4,[pool_0232124C]	; 02320F72
	mov r0,#0x0	; 02320F74
	str r0,[r4,#0x0]	; 02320F76
	ldr r4,[pool_02321250]	; 02320F78
	ldrh r5,[r4,#0x0]	; 02320F7A
	and r5,r1	; 02320F7C
	ldr r0,[pool_02321254]	; 02320F7E
	orr r5,r0	; 02320F80
	strh r5,[r4,#0x0]	; 02320F82
	ldrh r0,[r4,#0x0]	; 02320F84
	bic r0,r2	; 02320F86
	orr r0,r2	; 02320F88
	strh r0,[r4,#0x0]	; 02320F8A
	ldrh r0,[r4,#0x0]	; 02320F8C
	bic r0,r3	; 02320F8E
	strh r0,[r4,#0x0]	; 02320F90
	ldr r4,[pool_02321258]	; 02320F92
	ldr r0,[pool_0232125C]	; 02320F94
	str r4,[r0,#0x0]	; 02320F96
	ldr r0,[pool_02321260]	; 02320F98
	ldrh r4,[r0,#0x0]	; 02320F9A
	and r4,r1	; 02320F9C
	ldr r1,[pool_02321264]	; 02320F9E
	orr r4,r1	; 02320FA0
	strh r4,[r0,#0x0]	; 02320FA2
	ldrh r1,[r0,#0x0]	; 02320FA4
	bic r1,r2	; 02320FA6
	strh r1,[r0,#0x0]	; 02320FA8
	ldrh r1,[r0,#0x0]	; 02320FAA
	bic r1,r3	; 02320FAC
	strh r1,[r0,#0x0]	; 02320FAE
	ldr r1,[pool_02321268]	; 02320FB0
	mov r0,#0x0	; 02320FB2
	str r0,[r1,#0x0]	; 02320FB4
	ldr r2,[pool_02321214]	; 02320FB6
	ldr r3,[r2,#0x0]	; 02320FB8
	ldr r0,[pool_0232126C]	; 02320FBA
	and r3,r0	; 02320FBC
	ldr r1,[pool_02321270]	; 02320FBE
	orr r3,r1	; 02320FC0
	str r3,[r2,#0x0]	; 02320FC2
	ldr r2,[pool_023211EC]	; 02320FC4
	ldr r3,[r2,#0x0]	; 02320FC6
	and r3,r0	; 02320FC8
	orr r3,r1	; 02320FCA
	str r3,[r2,#0x0]	; 02320FCC
	ldr r0,[pool_02321224]	; 02320FCE
	mov r1,#0x0	; 02320FD0
	add r2,r6,#0x0	; 02320FD2
	bl loc_0232DA28	; 02320FD4
	mov r4,#0x0	; 02320FD8
	ldr r6,[pool_02321274]	; 02320FDA
loc_02320FDC:
	lsl r5,r4,#0x6	; 02320FDC
	lsl r0,r4,#0x7	; 02320FDE
	add r0,r6,r0	; 02320FE0
	add r1,r5,#0x0	; 02320FE2
	mov r2,#0x40	; 02320FE4
	bl loc_0232DB68	; 02320FE6
	lsl r0,r4,#0x1	; 02320FEA
	add r0,r0,#0x1	; 02320FEC
	lsl r0,r0,#0x6	; 02320FEE
	add r0,r6,r0	; 02320FF0
	ldr r1,[pool_02321278]	; 02320FF2
	add r1,r5,r1	; 02320FF4
	mov r2,#0x40	; 02320FF6
	bl loc_0232DB68	; 02320FF8
	add r4,r4,#0x1	; 02320FFC
	cmp r4,#0x20	; 02320FFE
	blt loc_02320FDC	; 02321000
	bl loc_0232527C	; 02321002
	ldr r0,[pool_0232127C]	; 02321006
	ldr r1,[pool_02321280]	; 02321008
	ldr r2,[pool_02321284]	; 0232100A
	sub r2,r2,r0	; 0232100C
	blx loc_0232DE60	; 0232100E
	ldr r0,[pool_02321288]	; 02321012
	ldr r1,[pool_0232128C]	; 02321014
	ldr r2,[pool_02321290]	; 02321016
	sub r2,r2,r0	; 02321018
	blx loc_0232DE60	; 0232101A
	ldr r0,[pool_02321294]	; 0232101E
	ldr r1,[pool_02321298]	; 02321020
	ldr r2,[pool_0232129C]	; 02321022
	sub r2,r2,r0	; 02321024
	blx loc_0232DE60	; 02321026
	ldr r0,[pool_023212A0]	; 0232102A
	ldr r1,[pool_023212A4]	; 0232102C
	ldr r2,[pool_023212A8]	; 0232102E
	sub r2,r2,r0	; 02321030
	blx loc_0232DE60	; 02321032
	bl loc_02323E7C	; 02321036
	bl loc_02324054	; 0232103A
	bl loc_02323E7C	; 0232103E
	ldr r1,[pool_023212AC]	; 02321042
	bl loc_02323FC0	; 02321044
	bl loc_02323E7C	; 02321048
	ldr r1,[pool_023212B0]	; 0232104C
	bl loc_02323FC0	; 0232104E
	bl loc_02323E84	; 02321052
	ldr r1,[pool_023212B4]	; 02321056
	bl loc_02323FC0	; 02321058
	mov r0,#0x25	; 0232105C
	mov r1,#0x29	; 0232105E
	mov r2,#0x6	; 02321060
	bl loc_02325650	; 02321062
	bl loc_0232524C	; 02321066
	bl loc_02324C6C	; 0232106A
	add r4,r0,#0x0	; 0232106E
	ldr r0,[pool_023212AC]	; 02321070
	bl loc_023291BC	; 02321072
	add r5,r0,#0x0	; 02321076
	ldr r0,[pool_023212B0]	; 02321078
	bl loc_023291BC	; 0232107A
	add r1,r0,#0x0	; 0232107E
	add r0,r4,#0x0	; 02321080
	add r1,r5,r1	; 02321082
	bl loc_02324C2C	; 02321084
	add r0,r4,#0x0	; 02321088
	bl loc_02325604	; 0232108A
	add r0,r4,#0x0	; 0232108E
	bl loc_023251FC	; 02321090
	mov r5,#0x0	; 02321094
	ldr r6,[pool_023211C4]	; 02321096
loc_02321098:
	add r1,r5,#0x0	; 02321098
	mov r0,#0x3c	; 0232109A
	mul r1,r0	; 0232109C
	add r1,r6,r1	; 0232109E
	ldr r3,[r1,#0x8]	; 023210A0
	cmp r3,#0x0	; 023210A2
	blt loc_023210B0	; 023210A4
	add r0,r4,#0x0	; 023210A6
	add r1,#0x10	; 023210A8
	ldr r2,[pool_023212B8]	; 023210AA
	bl loc_02324BF8	; 023210AC
loc_023210B0:
	add r5,r5,#0x1	; 023210B0
	cmp r5,#0x5	; 023210B2
	blt loc_02321098	; 023210B4
	ldr r0,[pool_023212BC]	; 023210B6
	ldr r1,[r0,#0x0]	; 023210B8
	mov r0,#0x2	; 023210BA
	and r1,r0	; 023210BC
	cmp r1,#0x0	; 023210BE
	beq loc_023210C6	; 023210C0
	mov r2,#0x1	; 023210C2
	b loc_023210C8	; 023210C4
loc_023210C6:
	mov r2,#0x0	; 023210C6
loc_023210C8:
	ldr r0,[pool_023211DC]	; 023210C8
	ldr r1,[r0,#0x68]	; 023210CA
	mov r3,#0x10	; 023210CC
	bic r1,r3	; 023210CE
	mov r3,#0x1	; 023210D0
	and r2,r3	; 023210D2
	lsl r2,r2,#0x4	; 023210D4
	orr r1,r2	; 023210D6
	str r1,[r0,#0x68]	; 023210D8
	lsl r0,r1,#0x1b	; 023210DA
	lsr r0,r0,#0x1f	; 023210DC
	cmp r0,#0x0	; 023210DE
	beq loc_0232110E	; 023210E0
	add r0,sp,#0x24	; 023210E2
	ldr r1,[pool_023212C0]	; 023210E4
	bl loc_0232D1D0	; 023210E6
	ldr r0,[pool_023212C4]	; 023210EA
	bl loc_02327108	; 023210EC
	ldr r0,[pool_023212C8]	; 023210F0
	ldr r1,[pool_023212CC]	; 023210F2
	ldr r2,[pool_023212D0]	; 023210F4
	bl loc_0232DC08	; 023210F6
	add r0,sp,#0x24	; 023210FA
	bl loc_023214C8	; 023210FC
	ldr r0,[pool_023211D4]	; 02321100
	add r1,sp,#0x24	; 02321102
	bl loc_02324B44	; 02321104
	bl loc_02326534	; 02321108
	b loc_0232111E	; 0232110C
loc_0232110E:
	ldr r0,[pool_023211D4]	; 0232110E
	ldr r1,[pool_023212B8]	; 02321110
	mov r2,#0x2d	; 02321112
	bl loc_02324BA0	; 02321114
	mov r1,#0x4	; 02321118
	ldr r0,[pool_023211D4]	; 0232111A
	strh r1,[r0,#0x16]	; 0232111C
loc_0232111E:
	ldr r0,[pool_023212BC]	; 0232111E
	ldr r0,[r0,#0x0]	; 02321120
	mov r2,#0x1	; 02321122
	and r0,r2	; 02321124
	cmp r0,#0x0	; 02321126
	bne loc_0232112C	; 02321128
	mov r2,#0x0	; 0232112A
loc_0232112C:
	ldr r0,[pool_023211DC]	; 0232112C
	ldr r1,[r0,#0x68]	; 0232112E
	mov r3,#0x20	; 02321130
	bic r1,r3	; 02321132
	mov r3,#0x1	; 02321134
	and r2,r3	; 02321136
	lsl r2,r2,#0x5	; 02321138
	orr r1,r2	; 0232113A
	str r1,[r0,#0x68]	; 0232113C
	lsl r0,r1,#0x1a	; 0232113E
	lsr r0,r0,#0x1f	; 02321140
	cmp r0,#0x0	; 02321142
	beq loc_02321152	; 02321144
	ldr r0,[pool_023212D4]	; 02321146
	ldr r1,[pool_023212B8]	; 02321148
	mov r2,#0x2f	; 0232114A
	bl loc_02324BA0	; 0232114C
	b loc_0232118C	; 02321150
loc_02321152:
	bl loc_0232C620	; 02321152
	ldr r1,[pool_023211DC]	; 02321156
	ldr r2,[r1,#0x68]	; 02321158
	mov r3,#0x40	; 0232115A
	bic r2,r3	; 0232115C
	mov r3,#0x1	; 0232115E
	and r0,r3	; 02321160
	lsl r0,r0,#0x6	; 02321162
	orr r2,r0	; 02321164
	str r2,[r1,#0x68]	; 02321166
	lsl r0,r2,#0x19	; 02321168
	lsr r0,r0,#0x1f	; 0232116A
	cmp r0,#0x0	; 0232116C
	beq loc_0232117C	; 0232116E
	ldr r0,[pool_023212D4]	; 02321170
	ldr r1,[pool_023212B8]	; 02321172
	mov r2,#0x31	; 02321174
	bl loc_02324BA0	; 02321176
	b loc_0232118C	; 0232117A
loc_0232117C:
	ldr r0,[pool_023212D4]	; 0232117C
	ldr r1,[pool_023212B8]	; 0232117E
	mov r2,#0x30	; 02321180
	bl loc_02324BA0	; 02321182
	mov r1,#0x4	; 02321186
	ldr r0,[pool_023212D8]	; 02321188
	strh r1,[r0,#0x22]	; 0232118A
loc_0232118C:
	add r0,r4,#0x0	; 0232118C
	ldr r1,[pool_023212DC]	; 0232118E
	ldr r2,[pool_023212E0]	; 02321190
	mov r3,#0x61	; 02321192
	bl loc_02324BF8	; 02321194
	bl P1_GetFirmwareUiContext	; 02321198
	ldr r0,[r0,#0x0]	; 0232119C
	lsl r0,r0,#0x17	; 0232119E
	lsr r0,r0,#0x1f	; 023211A0
	cmp r0,#0x0	; 023211A2
	bne loc_023211A8	; 023211A4
	b loc_0232130E	; 023211A6
loc_023211A8:
	ldr r1,[pool_023211DC]	; 023211A8
	ldr r2,[r1,#0x68]	; 023211AA
	ldr r0,[pool_023212D0]	; 023211AC
	orr r2,r0	; 023211AE
	str r2,[r1,#0x68]	; 023211B0
	ldr r1,[pool_023211EC]	; 023211B2
	ldr r2,[r1,#0x0]	; 023211B4
	ldr r0,[pool_02321218]	; 023211B6
	and r2,r0	; 023211B8
	ldr r0,[pool_0232121C]	; 023211BA
	orr r2,r0	; 023211BC
	str r2,[r1,#0x0]	; 023211BE
	ldr r0,[pool_023212E4]	; 023211C0
	b loc_023212E8	; 023211C2
pool_023211C4:
loc_023211C4:
	.word 0x02330A80	; 023211C4
pool_023211C8:
loc_023211C8:
	.word 0x0000136C	; 023211C8
pool_023211CC:
loc_023211CC:
	.word 0x02330BB4	; 023211CC
pool_023211D0:
loc_023211D0:
	.word 0x0232FF0C	; 023211D0
pool_023211D4:
loc_023211D4:
	.word P1_BssStart + 0x100	; 023211D4
pool_023211D8:
loc_023211D8:
	.word P1_BssStart + 0xB00	; 023211D8
pool_023211DC:
loc_023211DC:
	.word P1_BssStart + 0x1300	; 023211DC
pool_023211E0:
loc_023211E0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023211E0
pool_023211E4:
loc_023211E4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 023211E4
pool_023211E8:
loc_023211E8:
	.word 0xFFFFFBFF	; 023211E8
pool_023211EC:
loc_023211EC:
	.word REG_DISPCNT_B	; 023211EC
pool_023211F0:
loc_023211F0:
	.word 0xFFFEFFFF	; 023211F0
pool_023211F4:
loc_023211F4:
	.word 0x000001FF	; 023211F4
pool_023211F8:
loc_023211F8:
	.word 0x06800000	; 023211F8
pool_023211FC:
loc_023211FC:
	.word 0x000A4000	; 023211FC
pool_02321200:
loc_02321200:
	.word 0x07000400	; 02321200
pool_02321204:
loc_02321204:
	.word 0x00000400	; 02321204
pool_02321208:
loc_02321208:
	.word 0x05000400	; 02321208
pool_0232120C:
loc_0232120C:
	.word REG_BG1CNT	; 0232120C
pool_02321210:
loc_02321210:
	.word REG_BG1HOFS	; 02321210
pool_02321214:
loc_02321214:
	.word REG_DISPCNT_A	; 02321214
pool_02321218:
loc_02321218:
	.word 0xFFFFE0FF	; 02321218
pool_0232121C:
loc_0232121C:
	.word 0x00001000	; 0232121C
pool_02321220:
loc_02321220:
	.word 0x023B0240	; 02321220
pool_02321224:
loc_02321224:
	.word 0x023AE640	; 02321224
pool_02321228:
loc_02321228:
	.word 0x023BBFC0	; 02321228
pool_0232122C:
loc_0232122C:
	.word 0x023BBDC0	; 0232122C
pool_02321230:
loc_02321230:
	.word 0x023B7DC0	; 02321230
pool_02321234:
loc_02321234:
	.word 0x023B85C0	; 02321234
pool_02321238:
loc_02321238:
	.word 0x023BCDC0	; 02321238
pool_0232123C:
loc_0232123C:
	.word 0x023BCFC0	; 0232123C
pool_02321240:
loc_02321240:
	.word 0x0233003C	; 02321240
pool_02321244:
loc_02321244:
	.word REG_BG0CNT_SUB	; 02321244
pool_02321248:
loc_02321248:
	.word 0x00001018	; 02321248
pool_0232124C:
loc_0232124C:
	.word REG_BG0HOFS_SUB	; 0232124C
pool_02321250:
loc_02321250:
	.word REG_BG1CNT_SUB	; 02321250
pool_02321254:
loc_02321254:
	.word 0x00004110	; 02321254
pool_02321258:
loc_02321258:
	.word 0x00190011	; 02321258
pool_0232125C:
loc_0232125C:
	.word REG_BG1HOFS_SUB	; 0232125C
pool_02321260:
loc_02321260:
	.word REG_BG3CNT_SUB	; 02321260
pool_02321264:
loc_02321264:
	.word 0x00000810	; 02321264
pool_02321268:
loc_02321268:
	.word REG_BG3HOFS_SUB	; 02321268
pool_0232126C:
loc_0232126C:
	.word 0xFFCFFFEF	; 0232126C
pool_02321270:
loc_02321270:
	.word 0x00200010	; 02321270
pool_02321274:
loc_02321274:
	.word 0x023BA5C0	; 02321274
pool_02321278:
loc_02321278:
	.word 0x00000800	; 02321278
pool_0232127C:
loc_0232127C:
	.word 0x023B6DC0	; 0232127C
pool_02321280:
loc_02321280:
	.word 0x06200000	; 02321280
pool_02321284:
loc_02321284:
	.word 0x023B75C0	; 02321284
pool_02321288:
loc_02321288:
	.word 0x023B9DC0	; 02321288
pool_0232128C:
loc_0232128C:
	.word 0x06203000	; 0232128C
pool_02321290:
loc_02321290:
	.word 0x023BA5C0	; 02321290
pool_02321294:
loc_02321294:
	.word 0x023B95C0	; 02321294
pool_02321298:
loc_02321298:
	.word 0x06203800	; 02321298
pool_0232129C:
loc_0232129C:
	.word 0x023B9DC0	; 0232129C
pool_023212A0:
loc_023212A0:
	.word 0x023B75C0	; 023212A0
pool_023212A4:
loc_023212A4:
	.word 0x06204800	; 023212A4
pool_023212A8:
loc_023212A8:
	.word 0x023B7DC0	; 023212A8
pool_023212AC:
loc_023212AC:
	.word 0x023C1178	; 023212AC
pool_023212B0:
loc_023212B0:
	.word 0x023D3ABC	; 023212B0
pool_023212B4:
loc_023212B4:
	.word 0x023D3C10	; 023212B4
pool_023212B8:
loc_023212B8:
	.word 0x023A5AEC	; 023212B8
pool_023212BC:
loc_023212BC:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023212BC
pool_023212C0:
loc_023212C0:
	.word 0x00000102	; 023212C0
pool_023212C4:
loc_023212C4:
	.word 0x02331598	; 023212C4
pool_023212C8:
loc_023212C8:
	.word 0x023315B8	; 023212C8
pool_023212CC:
loc_023212CC:
	.word 0x0001FE00	; 023212CC
pool_023212D0:
loc_023212D0:
	.word 0x00000200	; 023212D0
pool_023212D4:
loc_023212D4:
	.word 0x02330ACC	; 023212D4
pool_023212D8:
loc_023212D8:
	.word P1_BssStart + 0x40	; 023212D8
pool_023212DC:
loc_023212DC:
	.word 0x02331558	; 023212DC
pool_023212E0:
loc_023212E0:
	.word 0x023A5BC4	; 023212E0
pool_023212E4:
loc_023212E4:
	.word 0x023BC5C0	; 023212E4
loc_023212E8:
	mov r1,#0x0	; 023212E8
	ldr r2,[pool_02321410]	; 023212EA
	sub r2,r2,r0	; 023212EC
	bl loc_0232DCA8	; 023212EE
	ldr r0,[pool_02321414]	; 023212F2
	mov r1,#0x0	; 023212F4
	add r2,r7,#0x0	; 023212F6
	bl loc_0232DCF8	; 023212F8
	ldr r0,[pool_02321418]	; 023212FC
	mov r1,#0x0	; 023212FE
	mov r2,#0x2	; 02321300
	bl loc_0232DCF8	; 02321302
	mov r1,#0x1	; 02321306
	ldr r0,[pool_0232141C]	; 02321308
	str r1,[r0,#0x2c]	; 0232130A
	b loc_023213C8	; 0232130C
loc_0232130E:
	mov r0,#0x0	; 0232130E
	ldr r1,[pool_02321420]	; 02321310
	ldr r1,[r1,#0x58]	; 02321312
	cmp r1,#0x5	; 02321314
	bhi loc_0232136C	; 02321316
	add r1,r1,r1	; 02321318
P1_SwitchIndexPC_02321318:
	add r1,pc	; 0232131A
	ldrh r1,[r1,#(P1_SwitchTable_02321318 - (P1_SwitchIndexPC_02321318 + 4))]	; 0232131C
	lsl r1,r1,#0x10	; 0232131E
	asr r1,r1,#0x10	; 02321320
P1_SwitchTargetPC_02321318:
	add r1,pc	; 02321322
	bx r1	; 02321324
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02321318:
	.halfword (loc_02321332 + 1) - (P1_SwitchTargetPC_02321318 + 4)
	.halfword (loc_0232133C + 1) - (P1_SwitchTargetPC_02321318 + 4)
	.halfword (loc_02321346 + 1) - (P1_SwitchTargetPC_02321318 + 4)
	.halfword (loc_02321350 + 1) - (P1_SwitchTargetPC_02321318 + 4)
	.halfword (loc_0232135A + 1) - (P1_SwitchTargetPC_02321318 + 4)
	.halfword (loc_02321364 + 1) - (P1_SwitchTargetPC_02321318 + 4)
P1_SwitchTable_02321318End:
loc_02321332:
	ldr r0,[pool_02321424]	; 02321332
	ldr r2,[pool_02321428]	; 02321334
	ldr r1,[pool_0232142C]	; 02321336
	str r2,[r1,#0x14]	; 02321338
	b loc_0232136C	; 0232133A
loc_0232133C:
	ldr r0,[pool_02321430]	; 0232133C
	ldr r2,[pool_02321434]	; 0232133E
	ldr r1,[pool_0232142C]	; 02321340
	str r2,[r1,#0x14]	; 02321342
	b loc_0232136C	; 02321344
loc_02321346:
	ldr r0,[pool_02321438]	; 02321346
	ldr r2,[pool_0232143C]	; 02321348
	ldr r1,[pool_0232142C]	; 0232134A
	str r2,[r1,#0x14]	; 0232134C
	b loc_0232136C	; 0232134E
loc_02321350:
	ldr r0,[pool_02321440]	; 02321350
	ldr r2,[pool_02321444]	; 02321352
	ldr r1,[pool_0232142C]	; 02321354
	str r2,[r1,#0x14]	; 02321356
	b loc_0232136C	; 02321358
loc_0232135A:
	ldr r0,[pool_02321448]	; 0232135A
	ldr r2,[pool_0232144C]	; 0232135C
	ldr r1,[pool_0232142C]	; 0232135E
	str r2,[r1,#0x14]	; 02321360
	b loc_0232136C	; 02321362
loc_02321364:
	ldr r0,[pool_02321450]	; 02321364
	ldr r2,[pool_02321454]	; 02321366
	ldr r1,[pool_0232142C]	; 02321368
	str r2,[r1,#0x14]	; 0232136A
loc_0232136C:
	mov r1,#0x1	; 0232136C
	bl loc_023256D0	; 0232136E
	ldr r1,[pool_02321420]	; 02321372
	ldr r2,[r1,#0x68]	; 02321374
	mov r0,#0x1	; 02321376
	bic r2,r0	; 02321378
	orr r2,r0	; 0232137A
	str r2,[r1,#0x68]	; 0232137C
	ldr r0,[pool_02321458]	; 0232137E
	orr r2,r0	; 02321380
	str r2,[r1,#0x68]	; 02321382
	mov r1,#0x0	; 02321384
	ldr r0,[pool_0232141C]	; 02321386
	str r1,[r0,#0x2c]	; 02321388
	ldr r2,[pool_0232145C]	; 0232138A
	ldr r0,[pool_02321460]	; 0232138C
	sub r4,r2,r0	; 0232138E
	add r2,r4,#0x0	; 02321390
	bl loc_0232DCA8	; 02321392
	ldr r0,[pool_02321460]	; 02321396
	mov r1,#0x0	; 02321398
	add r2,r4,#0x0	; 0232139A
	bl loc_0232DCF8	; 0232139C
	ldr r0,[pool_02321464]	; 023213A0
	mov r1,#0x0	; 023213A2
	mov r2,#0x2	; 023213A4
	bl loc_0232DCF8	; 023213A6
	ldr r1,[pool_02321468]	; 023213AA
	ldr r2,[r1,#0x0]	; 023213AC
	ldr r0,[pool_0232146C]	; 023213AE
	and r2,r0	; 023213B0
	ldr r0,[pool_02321470]	; 023213B2
	orr r2,r0	; 023213B4
	str r2,[r1,#0x0]	; 023213B6
	mov r0,#0x10	; 023213B8
	str r0,[sp,#0x0]	; 023213BA
	ldr r0,[pool_02321474]	; 023213BC
	mov r1,#0x1	; 023213BE
	mov r2,#0x20	; 023213C0
	mov r3,#0x0	; 023213C2
	bl loc_0232D968	; 023213C4
loc_023213C8:
	ldr r0,[pool_02321478]	; 023213C8
	bl loc_02321874	; 023213CA
	ldr r0,[pool_0232147C]	; 023213CE
	bl loc_0232197C	; 023213D0
	ldr r0,[pool_02321480]	; 023213D4
	mov r1,#0x12	; 023213D6
	mov r2,#0x8	; 023213D8
	bl loc_02326094	; 023213DA
	ldr r0,[pool_02321484]	; 023213DE
	bl loc_023265E8	; 023213E0
	mov r0,#0x1	; 023213E4
	ldr r1,[pool_02321488]	; 023213E6
	bl loc_0232B1F0	; 023213E8
	mov r0,#0x1	; 023213EC
	bl loc_0232B16C	; 023213EE
	mov r0,#0x1	; 023213F2
	bl loc_0232D4F0	; 023213F4
	bl loc_0232D47C	; 023213F8
	ldr r2,[pool_02321468]	; 023213FC
	ldr r1,[r2,#0x0]	; 023213FE
	ldr r0,[pool_0232148C]	; 02321400
	orr r1,r0	; 02321402
	str r1,[r2,#0x0]	; 02321404
	add sp,#0x12c	; 02321406
	pop {r4,r5,r6,r7}	; 02321408
	pop {r3}	; 0232140A
	bx r3	; 0232140C
	.byte 0xC0, 0x46	; 02321410
pool_02321410:
loc_02321410:
	.word 0x023BC7C0	; 02321410
pool_02321414:
loc_02321414:
	.word 0x023BBDC0	; 02321414
pool_02321418:
loc_02321418:
	.word 0x02330040	; 02321418
pool_0232141C:
loc_0232141C:
	.word P1_BssStart + 0x100	; 0232141C
pool_02321420:
loc_02321420:
	.word P1_BssStart + 0x1300	; 02321420
pool_02321424:
loc_02321424:
	.word 0x023A6E1C	; 02321424
pool_02321428:
loc_02321428:
	.word 0x023A59EC	; 02321428
pool_0232142C:
loc_0232142C:
	.word P1_BssStart + 0xB00	; 0232142C
pool_02321430:
loc_02321430:
	.word 0x023A741C	; 02321430
pool_02321434:
loc_02321434:
	.word 0x023A5A0C	; 02321434
pool_02321438:
loc_02321438:
	.word 0x023A651C	; 02321438
pool_0232143C:
loc_0232143C:
	.word 0x023A59BC	; 0232143C
pool_02321440:
loc_02321440:
	.word 0x023A67E8	; 02321440
pool_02321444:
loc_02321444:
	.word 0x023A59CC	; 02321444
pool_02321448:
loc_02321448:
	.word 0x023A6AFC	; 02321448
pool_0232144C:
loc_0232144C:
	.word 0x023A59DC	; 0232144C
pool_02321450:
loc_02321450:
	.word 0x023A7104	; 02321450
pool_02321454:
loc_02321454:
	.word 0x023A59FC	; 02321454
pool_02321458:
loc_02321458:
	.word 0x00000200	; 02321458
pool_0232145C:
loc_0232145C:
	.word 0x023BCDC0	; 0232145C
pool_02321460:
loc_02321460:
	.word 0x023BCBC0	; 02321460
pool_02321464:
loc_02321464:
	.word 0x02330044	; 02321464
pool_02321468:
loc_02321468:
	.word REG_DISPCNT_B	; 02321468
pool_0232146C:
loc_0232146C:
	.word 0xFFFFE0FF	; 0232146C
pool_02321470:
loc_02321470:
	.word 0x00001100	; 02321470
pool_02321474:
loc_02321474:
	.word REG_BLDCNT_SUB	; 02321474
pool_02321478:
loc_02321478:
	.word 0x02330A80	; 02321478
pool_0232147C:
loc_0232147C:
	.word 0x02330C00	; 0232147C
pool_02321480:
loc_02321480:
	.word 0x0233151C	; 02321480
pool_02321484:
loc_02321484:
	.word 0x02321555	; 02321484
pool_02321488:
loc_02321488:
	.word P1_IrqHandler_0232159C + 1	; 02321488
pool_0232148C:
loc_0232148C:
	.word 0x00010000	; 0232148C

; ===== function loc_02321490 =====
loc_02321490:
	push {lr}	; 02321490
	sub sp,#0x4	; 02321492
	bl P1_GetFirmwareUiContext	; 02321494
	ldr r0,[r0,#0x0]	; 02321498
	lsl r0,r0,#0x17	; 0232149A
	lsr r0,r0,#0x1f	; 0232149C
	cmp r0,#0x0	; 0232149E
	bne loc_023214B6	; 023214A0
	ldr r0,[pool_023214C4]	; 023214A2
	ldr r0,[r0,#0x68]	; 023214A4
	lsl r0,r0,#0x15	; 023214A6
	lsr r0,r0,#0x1f	; 023214A8
	cmp r0,#0x0	; 023214AA
	beq loc_023214B6	; 023214AC
	mov r0,#0x2	; 023214AE
	bl loc_02323724	; 023214B0
	b loc_023214BC	; 023214B4
loc_023214B6:
	mov r0,#0x1	; 023214B6
	bl loc_02323724	; 023214B8
loc_023214BC:
	add sp,#0x4	; 023214BC
	pop {r3}	; 023214BE
	bx r3	; 023214C0
	.byte 0xC0, 0x46	; 023214C4
pool_023214C4:
loc_023214C4:
	.word P1_BssStart + 0x1300	; 023214C4

; ===== function loc_023214C8 =====
loc_023214C8:
	push {r4,r5,r6,r7,lr}	; 023214C8
	sub sp,#0x4	; 023214CA
	ldr r1,[pool_02321534]	; 023214CC
	ldr r4,[r1,#0x58]	; 023214CE
	ldr r3,[pool_02321538]	; 023214D0
	lsl r1,r4,#0x8	; 023214D2
	add r2,r3,r1	; 023214D4
	ldr r1,[pool_0232153C]	; 023214D6
	ldrh r1,[r2,r1]	; 023214D8
	cmp r1,#0x0	; 023214DA
	bne loc_0232150E	; 023214DC
	cmp r4,#0x0	; 023214DE
	bne loc_023214E6	; 023214E0
	ldr r2,[pool_02321540]	; 023214E2
	b loc_023214F0	; 023214E4
loc_023214E6:
	cmp r4,#0x1	; 023214E6
	bne loc_023214EE	; 023214E8
	ldr r2,[pool_02321544]	; 023214EA
	b loc_023214F0	; 023214EC
loc_023214EE:
	ldr r2,[pool_02321548]	; 023214EE
loc_023214F0:
	mov r5,#0x0	; 023214F0
	ldr r6,[pool_0232153C]	; 023214F2
	b loc_0232150A	; 023214F4
loc_023214F6:
	lsl r1,r5,#0x1	; 023214F6
	ldrsh r1,[r2,r1]	; 023214F8
	lsl r7,r1,#0x8	; 023214FA
	add r7,r3,r7	; 023214FC
	ldrh r7,[r7,r6]	; 023214FE
	cmp r7,#0x0	; 02321500
	beq loc_02321508	; 02321502
	add r4,r1,#0x0	; 02321504
	b loc_0232150E	; 02321506
loc_02321508:
	add r5,r5,#0x1	; 02321508
loc_0232150A:
	cmp r5,#0x6	; 0232150A
	blt loc_023214F6	; 0232150C
loc_0232150E:
	mov r1,#0x0	; 0232150E
	ldr r3,[pool_0232154C]	; 02321510
	lsl r2,r4,#0x8	; 02321512
	add r5,r3,r2	; 02321514
	ldr r2,[pool_02321550]	; 02321516
loc_02321518:
	lsl r4,r1,#0x1	; 02321518
	add r3,r5,r4	; 0232151A
	ldrh r3,[r3,r2]	; 0232151C
	strh r3,[r0,r4]	; 0232151E
	add r1,r1,#0x1	; 02321520
	cmp r1,#0x80	; 02321522
	blt loc_02321518	; 02321524
	mov r2,#0x0	; 02321526
	lsl r1,r1,#0x1	; 02321528
	strh r2,[r0,r1]	; 0232152A
	add sp,#0x4	; 0232152C
	pop {r4,r5,r6,r7}	; 0232152E
	pop {r3}	; 02321530
	bx r3	; 02321532
pool_02321534:
loc_02321534:
	.word P1_BssStart + 0x1300	; 02321534
pool_02321538:
loc_02321538:
	.word 0x023315B8	; 02321538
pool_0232153C:
loc_0232153C:
	.word 0x00000220	; 0232153C
pool_02321540:
loc_02321540:
	.word 0x0232FEB0	; 02321540
pool_02321544:
loc_02321544:
	.word 0x0232FEC8	; 02321544
pool_02321548:
loc_02321548:
	.word 0x0232FEBC	; 02321548
pool_0232154C:
loc_0232154C:
	.word 0x02330A80	; 0232154C
pool_02321550:
loc_02321550:
	.word 0x00000D58	; 02321550

; ===== function loc_02321554 =====
	push {lr}	; 02321554
	sub sp,#0x4	; 02321556
	mov r1,#0x0	; 02321558
	ldr r0,[pool_02321594]	; 0232155A
	str r1,[r0,#0x20]	; 0232155C
	bl P1_GetFirmwareUiContext	; 0232155E
	ldr r0,[r0,#0x0]	; 02321562
	lsl r0,r0,#0x16	; 02321564
	lsr r0,r0,#0x1f	; 02321566
	cmp r0,#0x0	; 02321568
	beq loc_0232158E	; 0232156A
	bl P1_GetFirmwareUiContext	; 0232156C
	ldr r0,[r0,#0x0]	; 02321570
	lsl r0,r0,#0x15	; 02321572
	lsr r0,r0,#0x1f	; 02321574
	cmp r0,#0x0	; 02321576
	bne loc_02321582	; 02321578
	mov r0,#0x2	; 0232157A
	mov r1,#0x1	; 0232157C
	bl loc_0232F200	; 0232157E
loc_02321582:
	bl P1_GetFirmwareUiContext	; 02321582
	ldr r2,[r0,#0x0]	; 02321586
	ldr r1,[pool_02321598]	; 02321588
	orr r2,r1	; 0232158A
	str r2,[r0,#0x0]	; 0232158C
loc_0232158E:
	add sp,#0x4	; 0232158E
	pop {r3}	; 02321590
	bx r3	; 02321592
pool_02321594:
loc_02321594:
	.word P1_BssStart + 0xA80	; 02321594
pool_02321598:
loc_02321598:
	.word 0x00000400	; 02321598

; ===== function loc_0232159C =====
P1_IrqHandler_0232159C:
	push {r4,lr}	; 0232159C
	ldr r1,[pool_02321674]	; 0232159E
	ldr r0,[pool_02321678]	; 023215A0
	add r1,r1,r0	; 023215A2
	ldr r2,[r1,#0x0]	; 023215A4
	mov r0,#0x1	; 023215A6
	orr r2,r0	; 023215A8
	str r2,[r1,#0x0]	; 023215AA
	ldr r0,[pool_0232167C]	; 023215AC
	ldr r0,[r0,#0x68]	; 023215AE
	lsl r0,r0,#0x1c	; 023215B0
	lsr r0,r0,#0x1f	; 023215B2
	cmp r0,#0x0	; 023215B4
	beq loc_02321610	; 023215B6
	ldr r0,[pool_02321680]	; 023215B8
	ldrb r0,[r0,#0x0]	; 023215BA
	lsl r0,r0,#0x1c	; 023215BC
	lsr r4,r0,#0x1c	; 023215BE
	ldr r0,[pool_02321684]	; 023215C0
	mov r1,#0x0	; 023215C2
	ldr r2,[pool_02321688]	; 023215C4
	sub r2,r2,r0	; 023215C6
	bl loc_0232DCA8	; 023215C8
	ldr r0,[pool_0232168C]	; 023215CC
	ldr r1,[pool_02321690]	; 023215CE
	mov r2,#0x20	; 023215D0
	bl loc_0232DCA8	; 023215D2
	ldr r0,[pool_02321694]	; 023215D6
	mov r1,#0x0	; 023215D8
	ldr r2,[pool_02321698]	; 023215DA
	sub r2,r2,r0	; 023215DC
	bl loc_0232DCF8	; 023215DE
	ldr r0,[pool_0232169C]	; 023215E2
	mov r1,#0x0	; 023215E4
	mov r2,#0x2	; 023215E6
	bl loc_0232DCF8	; 023215E8
	ldr r1,[pool_023216A0]	; 023215EC
	lsl r0,r4,#0x5	; 023215EE
	add r4,r1,r0	; 023215F0
	add r0,r4,#0x0	; 023215F2
	ldr r1,[pool_023216A4]	; 023215F4
	mov r2,#0x20	; 023215F6
	bl loc_0232DCF8	; 023215F8
	add r0,r4,#0x0	; 023215FC
	ldr r1,[pool_023216A4]	; 023215FE
	mov r2,#0x20	; 02321600
	bl loc_0232DCA8	; 02321602
	ldr r1,[pool_0232167C]	; 02321606
	ldr r2,[r1,#0x68]	; 02321608
	mov r0,#0x8	; 0232160A
	bic r2,r0	; 0232160C
	str r2,[r1,#0x68]	; 0232160E
loc_02321610:
	ldr r2,[pool_0232167C]	; 02321610
	ldr r0,[r2,#0x68]	; 02321612
	lsl r0,r0,#0x1f	; 02321614
	lsr r0,r0,#0x1f	; 02321616
	cmp r0,#0x0	; 02321618
	beq loc_02321652	; 0232161A
	ldr r0,[r2,#0x60]	; 0232161C
	ldr r4,[r2,#0x5c]	; 0232161E
	lsl r3,r4,#0xa	; 02321620
	lsl r1,r4,#0x5	; 02321622
	orr r4,r1	; 02321624
	orr r3,r4	; 02321626
	lsl r1,r3,#0x10	; 02321628
	lsr r1,r1,#0x10	; 0232162A
	lsl r4,r1,#0x10	; 0232162C
	lsl r3,r0,#0xa	; 0232162E
	lsl r1,r0,#0x5	; 02321630
	orr r0,r1	; 02321632
	orr r3,r0	; 02321634
	lsl r0,r3,#0x10	; 02321636
	lsr r0,r0,#0x10	; 02321638
	orr r4,r0	; 0232163A
	str r4,[r2,#0x64]	; 0232163C
	ldr r4,[pool_023216A8]	; 0232163E
	add r0,r4,#0x0	; 02321640
	mov r1,#0x4	; 02321642
	blx P1_CleanDataCacheRange	; 02321644
	add r0,r4,#0x0	; 02321648
	mov r1,#0xe	; 0232164A
	mov r2,#0x4	; 0232164C
	bl loc_0232DCF8	; 0232164E
loc_02321652:
	ldr r0,[pool_0232167C]	; 02321652
	ldr r0,[r0,#0x68]	; 02321654
	lsl r1,r0,#0x1d	; 02321656
	lsr r1,r1,#0x1f	; 02321658
	cmp r1,#0x0	; 0232165A
	beq loc_0232166A	; 0232165C
	lsl r0,r0,#0x14	; 0232165E
	lsr r0,r0,#0x1f	; 02321660
	cmp r0,#0x0	; 02321662
	bne loc_0232166A	; 02321664
	bl loc_02322908	; 02321666
loc_0232166A:
	bl loc_02323E8C	; 0232166A
	pop {r4}	; 0232166E
	pop {r3}	; 02321670
	bx r3	; 02321672
pool_02321674:
loc_02321674:
	.word 0x03000000	; 02321674
pool_02321678:
loc_02321678:
	.word 0x00003FF8	; 02321678
pool_0232167C:
loc_0232167C:
	.word P1_BssStart + 0x1300	; 0232167C
pool_02321680:
loc_02321680:
	.word FirmwareUserSettingsSharedAddress + UserSettingsThemeOffset	; 02321680
pool_02321684:
loc_02321684:
	.word 0x023BC5C0	; 02321684
pool_02321688:
loc_02321688:
	.word 0x023BC7C0	; 02321688
pool_0232168C:
loc_0232168C:
	.word 0x023317B8	; 0232168C
pool_02321690:
loc_02321690:
	.word 0x000001C0	; 02321690
pool_02321694:
loc_02321694:
	.word 0x023BBDC0	; 02321694
pool_02321698:
loc_02321698:
	.word 0x023BBFC0	; 02321698
pool_0232169C:
loc_0232169C:
	.word 0x02330048	; 0232169C
pool_023216A0:
loc_023216A0:
	.word 0x023BC9C0	; 023216A0
pool_023216A4:
loc_023216A4:
	.word 0x000001E0	; 023216A4
pool_023216A8:
loc_023216A8:
	.word 0x02331DE4	; 023216A8

; ===== function loc_023216AC =====
loc_023216AC:
	push {r4,r5,r6,r7,lr}	; 023216AC
	sub sp,#0xc	; 023216AE
	add r7,r0,#0x0	; 023216B0
	ldr r0,[pool_02321864]	; 023216B2
	add r4,r7,r0	; 023216B4
	ldr r5,[r4,#0x30]	; 023216B6
	mov r0,#0x40	; 023216B8
	bl loc_0232414C	; 023216BA
	str r0,[sp,#0x8]	; 023216BE
	mov r0,#0x80	; 023216C0
	bl loc_0232414C	; 023216C2
	str r0,[sp,#0x0]	; 023216C6
	mov r0,#0x20	; 023216C8
	bl loc_0232414C	; 023216CA
	add r6,r0,#0x0	; 023216CE
	mov r0,#0x10	; 023216D0
	bl loc_0232414C	; 023216D2
	cmp r5,#0x6	; 023216D6
	bls loc_023216DC	; 023216D8
	b loc_02321802	; 023216DA
loc_023216DC:
	add r1,r5,r5	; 023216DC
P1_SwitchIndexPC_023216DC:
	add r1,pc	; 023216DE
	ldrh r1,[r1,#(P1_SwitchTable_023216DC - (P1_SwitchIndexPC_023216DC + 4))]	; 023216E0
	lsl r1,r1,#0x10	; 023216E2
	asr r1,r1,#0x10	; 023216E4
P1_SwitchTargetPC_023216DC:
	add r1,pc	; 023216E6
	bx r1	; 023216E8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023216DC:
	.halfword (loc_023217B2 + 1) - (P1_SwitchTargetPC_023216DC + 4)
	.halfword (loc_0232177A + 1) - (P1_SwitchTargetPC_023216DC + 4)
	.halfword (loc_02321724 + 1) - (P1_SwitchTargetPC_023216DC + 4)
	.halfword (loc_02321724 + 1) - (P1_SwitchTargetPC_023216DC + 4)
	.halfword (loc_023216F8 + 1) - (P1_SwitchTargetPC_023216DC + 4)
	.halfword (loc_023217F0 + 1) - (P1_SwitchTargetPC_023216DC + 4)
	.halfword (loc_023217FA + 1) - (P1_SwitchTargetPC_023216DC + 4)
P1_SwitchTable_023216DCEnd:
loc_023216F8:
	ldr r1,[sp,#0x0]	; 023216F8
	cmp r1,#0x0	; 023216FA
	beq loc_02321710	; 023216FC
	ldr r0,[r4,#0x34]	; 023216FE
	cmp r0,#0x3	; 02321700
	bne loc_0232170A	; 02321702
	mov r0,#0x3	; 02321704
	str r0,[r4,#0x30]	; 02321706
	b loc_02321802	; 02321708
loc_0232170A:
	mov r0,#0x2	; 0232170A
	str r0,[r4,#0x30]	; 0232170C
	b loc_02321802	; 0232170E
loc_02321710:
	cmp r6,#0x0	; 02321710
	beq loc_0232171A	; 02321712
	mov r0,#0x3	; 02321714
	str r0,[r4,#0x34]	; 02321716
	b loc_02321802	; 02321718
loc_0232171A:
	cmp r0,#0x0	; 0232171A
	beq loc_02321802	; 0232171C
	mov r0,#0x2	; 0232171E
	str r0,[r4,#0x34]	; 02321720
	b loc_02321802	; 02321722
loc_02321724:
	ldr r1,[sp,#0x8]	; 02321724
	cmp r1,#0x0	; 02321726
	beq loc_0232173C	; 02321728
	ldr r1,[pool_02321868]	; 0232172A
	ldr r1,[r7,r1]	; 0232172C
	lsl r1,r1,#0x1b	; 0232172E
	lsr r1,r1,#0x1f	; 02321730
	cmp r1,#0x0	; 02321732
	beq loc_0232173C	; 02321734
	mov r0,#0x4	; 02321736
	str r0,[r4,#0x30]	; 02321738
	b loc_02321802	; 0232173A
loc_0232173C:
	ldr r1,[sp,#0x0]	; 0232173C
	cmp r1,#0x0	; 0232173E
	beq loc_0232175A	; 02321740
	ldr r0,[pool_02321868]	; 02321742
	ldr r0,[r7,r0]	; 02321744
	lsl r0,r0,#0x1a	; 02321746
	lsr r0,r0,#0x1f	; 02321748
	cmp r0,#0x0	; 0232174A
	beq loc_02321754	; 0232174C
	mov r0,#0x1	; 0232174E
	str r0,[r4,#0x30]	; 02321750
	b loc_02321802	; 02321752
loc_02321754:
	mov r0,#0x0	; 02321754
	str r0,[r4,#0x30]	; 02321756
	b loc_02321802	; 02321758
loc_0232175A:
	cmp r0,#0x0	; 0232175A
	beq loc_0232176A	; 0232175C
	cmp r5,#0x3	; 0232175E
	bne loc_0232176A	; 02321760
	mov r0,#0x2	; 02321762
	str r0,[r4,#0x30]	; 02321764
	str r0,[r4,#0x34]	; 02321766
	b loc_02321802	; 02321768
loc_0232176A:
	cmp r6,#0x0	; 0232176A
	beq loc_02321802	; 0232176C
	cmp r5,#0x2	; 0232176E
	bne loc_02321802	; 02321770
	mov r0,#0x3	; 02321772
	str r0,[r4,#0x30]	; 02321774
	str r0,[r4,#0x34]	; 02321776
	b loc_02321802	; 02321778
loc_0232177A:
	ldr r1,[sp,#0x8]	; 0232177A
	cmp r1,#0x0	; 0232177C
	beq loc_02321792	; 0232177E
	ldr r0,[r4,#0x34]	; 02321780
	cmp r0,#0x3	; 02321782
	bne loc_0232178C	; 02321784
	mov r0,#0x3	; 02321786
	str r0,[r4,#0x30]	; 02321788
	b loc_02321802	; 0232178A
loc_0232178C:
	mov r0,#0x2	; 0232178C
	str r0,[r4,#0x30]	; 0232178E
	b loc_02321802	; 02321790
loc_02321792:
	ldr r1,[sp,#0x0]	; 02321792
	cmp r1,#0x0	; 02321794
	beq loc_0232179E	; 02321796
	mov r0,#0x0	; 02321798
	str r0,[r4,#0x30]	; 0232179A
	b loc_02321802	; 0232179C
loc_0232179E:
	cmp r6,#0x0	; 0232179E
	beq loc_023217A8	; 023217A0
	mov r0,#0x3	; 023217A2
	str r0,[r4,#0x34]	; 023217A4
	b loc_02321802	; 023217A6
loc_023217A8:
	cmp r0,#0x0	; 023217A8
	beq loc_02321802	; 023217AA
	mov r0,#0x2	; 023217AC
	str r0,[r4,#0x34]	; 023217AE
	b loc_02321802	; 023217B0
loc_023217B2:
	ldr r1,[sp,#0x8]	; 023217B2
	cmp r1,#0x0	; 023217B4
	beq loc_023217DC	; 023217B6
	ldr r0,[pool_02321868]	; 023217B8
	ldr r0,[r7,r0]	; 023217BA
	lsl r0,r0,#0x1a	; 023217BC
	lsr r0,r0,#0x1f	; 023217BE
	cmp r0,#0x0	; 023217C0
	beq loc_023217CA	; 023217C2
	mov r0,#0x1	; 023217C4
	str r0,[r4,#0x30]	; 023217C6
	b loc_02321802	; 023217C8
loc_023217CA:
	ldr r0,[r4,#0x34]	; 023217CA
	cmp r0,#0x3	; 023217CC
	bne loc_023217D6	; 023217CE
	mov r0,#0x3	; 023217D0
	str r0,[r4,#0x30]	; 023217D2
	b loc_02321802	; 023217D4
loc_023217D6:
	mov r0,#0x2	; 023217D6
	str r0,[r4,#0x30]	; 023217D8
	b loc_02321802	; 023217DA
loc_023217DC:
	cmp r0,#0x0	; 023217DC
	beq loc_023217E6	; 023217DE
	mov r0,#0x5	; 023217E0
	str r0,[r4,#0x30]	; 023217E2
	b loc_02321802	; 023217E4
loc_023217E6:
	cmp r6,#0x0	; 023217E6
	beq loc_02321802	; 023217E8
	mov r0,#0x6	; 023217EA
	str r0,[r4,#0x30]	; 023217EC
	b loc_02321802	; 023217EE
loc_023217F0:
	cmp r6,#0x0	; 023217F0
	beq loc_02321802	; 023217F2
	mov r0,#0x0	; 023217F4
	str r0,[r4,#0x30]	; 023217F6
	b loc_02321802	; 023217F8
loc_023217FA:
	cmp r0,#0x0	; 023217FA
	beq loc_02321802	; 023217FC
	mov r0,#0x0	; 023217FE
	str r0,[r4,#0x30]	; 02321800
loc_02321802:
	ldr r0,[r4,#0x30]	; 02321802
	cmp r5,r0	; 02321804
	beq loc_0232180E	; 02321806
	mov r0,#0x1d	; 02321808
	bl loc_02323724	; 0232180A
loc_0232180E:
	mov r5,#0x0	; 0232180E
loc_02321810:
	add r7,r5,#0x0	; 02321810
	mov r0,#0xc	; 02321812
	mul r7,r0	; 02321814
	add r6,r4,r7	; 02321816
	ldr r0,[r4,#0x30]	; 02321818
	lsl r1,r0,#0x5	; 0232181A
	ldr r0,[pool_0232186C]	; 0232181C
	add r2,r0,r1	; 0232181E
	lsl r1,r5,#0x3	; 02321820
	add r0,r2,r1	; 02321822
	str r0,[sp,#0x4]	; 02321824
	ldr r0,[r4,r7]	; 02321826
	lsl r0,r0,#0x3	; 02321828
	ldr r1,[r2,r1]	; 0232182A
	lsl r1,r1,#0x1	; 0232182C
	add r1,r0,r1	; 0232182E
	ldr r0,[pool_02321870]	; 02321830
	add r0,r1,r0	; 02321832
	mov r1,#0xa	; 02321834
	blx P1_SignedDivMod	; 02321836
	str r0,[r4,r7]	; 0232183A
	ldr r0,[r6,#0x4]	; 0232183C
	lsl r1,r0,#0x3	; 0232183E
	ldr r0,[sp,#0x4]	; 02321840
	ldr r0,[r0,#0x4]	; 02321842
	lsl r0,r0,#0x1	; 02321844
	add r1,r1,r0	; 02321846
	ldr r0,[pool_02321870]	; 02321848
	add r0,r1,r0	; 0232184A
	mov r1,#0xa	; 0232184C
	blx P1_SignedDivMod	; 0232184E
	str r0,[r6,#0x4]	; 02321852
	add r5,r5,#0x1	; 02321854
	cmp r5,#0x4	; 02321856
	blt loc_02321810	; 02321858
	add sp,#0xc	; 0232185A
	pop {r4,r5,r6,r7}	; 0232185C
	pop {r3}	; 0232185E
	bx r3	; 02321860
	.byte 0xC0, 0x46	; 02321864
pool_02321864:
loc_02321864:
	.word 0x00000144	; 02321864
pool_02321868:
loc_02321868:
	.word 0x00001368	; 02321868
pool_0232186C:
loc_0232186C:
	.word 0x0232FF5C	; 0232186C
pool_02321870:
loc_02321870:
	.word 0x00000800	; 02321870

; ===== function loc_02321874 =====
loc_02321874:
	push {r4,r5,r6,r7,lr}	; 02321874
	sub sp,#0x4	; 02321876
	ldr r1,[pool_023218E0]	; 02321878
	add r5,r0,r1	; 0232187A
	ldr r0,[pool_023218E4]	; 0232187C
	ldr r0,[r0,#0x68]	; 0232187E
	lsl r1,r0,#0x1b	; 02321880
	lsr r1,r1,#0x1f	; 02321882
	cmp r1,#0x0	; 02321884
	beq loc_0232188E	; 02321886
	mov r0,#0x4	; 02321888
	str r0,[r5,#0x30]	; 0232188A
	b loc_023218A0	; 0232188C
loc_0232188E:
	lsl r0,r0,#0x1a	; 0232188E
	lsr r0,r0,#0x1f	; 02321890
	cmp r0,#0x0	; 02321892
	beq loc_0232189C	; 02321894
	mov r0,#0x1	; 02321896
	str r0,[r5,#0x30]	; 02321898
	b loc_023218A0	; 0232189A
loc_0232189C:
	mov r0,#0x3	; 0232189C
	str r0,[r5,#0x30]	; 0232189E
loc_023218A0:
	mov r0,#0x3	; 023218A0
	str r0,[r5,#0x34]	; 023218A2
	mov r6,#0x0	; 023218A4
	ldr r2,[pool_023218E8]	; 023218A6
	ldr r0,[pool_023218EC]	; 023218A8
loc_023218AA:
	add r3,r6,#0x0	; 023218AA
	mov r1,#0xc	; 023218AC
	mul r3,r1	; 023218AE
	add r4,r5,r3	; 023218B0
	lsl r1,r6,#0x2	; 023218B2
	ldr r1,[r2,r1]	; 023218B4
	str r1,[r4,#0x8]	; 023218B6
	lsl r1,r6,#0x3	; 023218B8
	ldr r7,[r5,#0x30]	; 023218BA
	lsl r7,r7,#0x5	; 023218BC
	add r7,r0,r7	; 023218BE
	ldr r7,[r1,r7]	; 023218C0
	str r7,[r5,r3]	; 023218C2
	ldr r3,[r5,#0x30]	; 023218C4
	lsl r3,r3,#0x5	; 023218C6
	add r3,r0,r3	; 023218C8
	add r1,r1,r3	; 023218CA
	ldr r1,[r1,#0x4]	; 023218CC
	str r1,[r4,#0x4]	; 023218CE
	add r6,r6,#0x1	; 023218D0
	cmp r6,#0x4	; 023218D2
	blt loc_023218AA	; 023218D4
	add sp,#0x4	; 023218D6
	pop {r4,r5,r6,r7}	; 023218D8
	pop {r3}	; 023218DA
	bx r3	; 023218DC
	.byte 0xC0, 0x46	; 023218E0
pool_023218E0:
loc_023218E0:
	.word 0x00000144	; 023218E0
pool_023218E4:
loc_023218E4:
	.word P1_BssStart + 0x1300	; 023218E4
pool_023218E8:
loc_023218E8:
	.word P1_Data_0232FED4	; 023218E8
pool_023218EC:
loc_023218EC:
	.word 0x0232FF5C	; 023218EC

; ===== function loc_023218F0 =====
loc_023218F0:
	push {lr}	; 023218F0
	sub sp,#0x4	; 023218F2
	mov r1,#0x1	; 023218F4
	str r1,[r0,#0x8]	; 023218F6
	mov r0,#0x0	; 023218F8
	str r0,[sp,#0x0]	; 023218FA
	ldr r0,[pool_02321910]	; 023218FC
	mov r1,#0x10	; 023218FE
	mov r2,#0x20	; 02321900
	add r3,r1,#0x0	; 02321902
	bl loc_0232D968	; 02321904
	add sp,#0x4	; 02321908
	pop {r3}	; 0232190A
	bx r3	; 0232190C
	.byte 0xC0, 0x46	; 02321910
pool_02321910:
loc_02321910:
	.word REG_BLDCNT	; 02321910

; ===== function loc_02321914 =====
loc_02321914:
	push {r4,r5,r6,r7,lr}	; 02321914
	sub sp,#0x4	; 02321916
	add r5,r0,#0x0	; 02321918
	mov r4,#0x0	; 0232191A
	add r6,r5,#0x0	; 0232191C
	add r6,#0xc	; 0232191E
	mov r7,#0x74	; 02321920
loc_02321922:
	add r0,r4,#0x0	; 02321922
	mul r0,r7	; 02321924
	add r0,r6,r0	; 02321926
	ldr r1,[r5,#0x0]	; 02321928
	bl loc_02321BEC	; 0232192A
	add r4,r4,#0x1	; 0232192E
	cmp r4,#0x14	; 02321930
	blt loc_02321922	; 02321932
	ldr r0,[r5,#0x0]	; 02321934
	cmp r0,#0x78	; 02321936
	bge loc_0232193E	; 02321938
	add r0,r0,#0x1	; 0232193A
	str r0,[r5,#0x0]	; 0232193C
loc_0232193E:
	ldr r0,[r5,#0x0]	; 0232193E
	cmp r0,#0x1d	; 02321940
	bne loc_02321948	; 02321942
	bl loc_02321490	; 02321944
loc_02321948:
	ldr r0,[r5,#0x8]	; 02321948
	cmp r0,#0x0	; 0232194A
	beq loc_0232196E	; 0232194C
	ldr r0,[r5,#0x4]	; 0232194E
	add r0,r0,#0x1	; 02321950
	str r0,[r5,#0x4]	; 02321952
	ldr r0,[r5,#0x4]	; 02321954
	cmp r0,#0xf	; 02321956
	bgt loc_0232196E	; 02321958
	lsl r0,r0,#0x4	; 0232195A
	mov r1,#0xf	; 0232195C
	blx P1_SignedDivMod	; 0232195E
	mov r1,#0x10	; 02321962
	sub r1,r1,r0	; 02321964
	lsl r0,r0,#0x8	; 02321966
	orr r1,r0	; 02321968
	ldr r0,[pool_02321978]	; 0232196A
	strh r1,[r0,#0x0]	; 0232196C
loc_0232196E:
	add sp,#0x4	; 0232196E
	pop {r4,r5,r6,r7}	; 02321970
	pop {r3}	; 02321972
	bx r3	; 02321974
	.byte 0xC0, 0x46	; 02321978
pool_02321978:
loc_02321978:
	.word REG_BLDALPHA	; 02321978

; ===== function loc_0232197C =====
loc_0232197C:
	push {r4,r5,r6,r7,lr}	; 0232197C
	sub sp,#0x1c	; 0232197E
	str r0,[sp,#0x0]	; 02321980
	mov r5,#0x0	; 02321982
	str r5,[sp,#0x4]	; 02321984
	str r5,[sp,#0x10]	; 02321986
	str r5,[sp,#0x8]	; 02321988
loc_0232198A:
	ldr r2,[sp,#0x0]	; 0232198A
	add r2,#0xc	; 0232198C
	ldr r1,[sp,#0x4]	; 0232198E
	mov r0,#0x74	; 02321990
	mul r1,r0	; 02321992
	add r4,r2,r1	; 02321994
	ldr r0,[pool_02321A20]	; 02321996
	ldrh r0,[r0,r5]	; 02321998
	str r0,[r4,#0x70]	; 0232199A
	add r5,r5,#0x2	; 0232199C
	ldr r7,[sp,#0x8]	; 0232199E
	b loc_023219F4	; 023219A0
loc_023219A2:
	add r1,r7,#0x0	; 023219A2
	str r1,[sp,#0xc]	; 023219A4
	mov r0,#0x18	; 023219A6
	mul r1,r0	; 023219A8
	str r1,[sp,#0xc]	; 023219AA
	add r6,r4,r1	; 023219AC
	ldr r0,[pool_02321A20]	; 023219AE
	add r0,r0,r5	; 023219B0
	add r1,sp,#0x14	; 023219B2
	mov r2,#0x8	; 023219B4
	blx loc_0232DE30	; 023219B6
	add r5,#0x8	; 023219BA
	add r0,sp,#0x14	; 023219BC
	ldrb r1,[r0,#0x0]	; 023219BE
	ldr r0,[sp,#0xc]	; 023219C0
	str r1,[r4,r0]	; 023219C2
	add r0,sp,#0x14	; 023219C4
	ldrb r0,[r0,#0x1]	; 023219C6
	lsl r0,r0,#0xc	; 023219C8
	asr r0,r0,#0x4	; 023219CA
	str r0,[r6,#0x14]	; 023219CC
	add r1,sp,#0x14	; 023219CE
	mov r0,#0x2	; 023219D0
	ldrsh r0,[r1,r0]	; 023219D2
	lsl r0,r0,#0xc	; 023219D4
	str r0,[r6,#0x4]	; 023219D6
	mov r0,#0x4	; 023219D8
	ldrsh r0,[r1,r0]	; 023219DA
	lsl r0,r0,#0xc	; 023219DC
	str r0,[r6,#0x8]	; 023219DE
	lsl r0,r1,#0	; 023219E0
	ldrb r0,[r0,#0x6]	; 023219E2
	lsl r0,r0,#0xc	; 023219E4
	str r0,[r6,#0xc]	; 023219E6
	lsl r0,r1,#0	; 023219E8
	ldrb r0,[r0,#0x7]	; 023219EA
	lsl r0,r0,#0xc	; 023219EC
	asr r0,r0,#0x4	; 023219EE
	str r0,[r6,#0x10]	; 023219F0
	add r7,r7,#0x1	; 023219F2
loc_023219F4:
	ldr r0,[r4,#0x70]	; 023219F4
	cmp r7,r0	; 023219F6
	bcc loc_023219A2	; 023219F8
	ldr r0,[sp,#0x10]	; 023219FA
	str r0,[r4,#0x60]	; 023219FC
	str r0,[r4,#0x64]	; 023219FE
	str r0,[r4,#0x68]	; 02321A00
	str r0,[r4,#0x6c]	; 02321A02
	ldr r0,[sp,#0x4]	; 02321A04
	add r0,r0,#0x1	; 02321A06
	str r0,[sp,#0x4]	; 02321A08
	cmp r0,#0x14	; 02321A0A
	blt loc_0232198A	; 02321A0C
	ldr r1,[sp,#0x10]	; 02321A0E
	ldr r0,[sp,#0x0]	; 02321A10
	str r1,[r0,#0x0]	; 02321A12
	str r1,[r0,#0x4]	; 02321A14
	str r1,[r0,#0x8]	; 02321A16
	add sp,#0x1c	; 02321A18
	pop {r4,r5,r6,r7}	; 02321A1A
	pop {r3}	; 02321A1C
	bx r3	; 02321A1E
pool_02321A20:
loc_02321A20:
	.word P5_Data_023AE498	; 02321A20

; ===== function loc_02321A24 =====
loc_02321A24:
	push {r4,r5,r6,r7,lr}	; 02321A24
	sub sp,#0x1c	; 02321A26
	str r0,[sp,#0xc]	; 02321A28
	str r1,[sp,#0x10]	; 02321A2A
	mov r5,#0x0	; 02321A2C
	str r5,[sp,#0x14]	; 02321A2E
loc_02321A30:
	ldr r2,[sp,#0xc]	; 02321A30
	add r2,#0xc	; 02321A32
	add r1,r5,#0x0	; 02321A34
	mov r0,#0x74	; 02321A36
	mul r1,r0	; 02321A38
	add r6,r2,r1	; 02321A3A
	ldr r0,[r6,#0x68]	; 02321A3C
	asr r4,r0,#0xc	; 02321A3E
	cmp r4,#0x0	; 02321A40
	bge loc_02321A48	; 02321A42
	ldr r4,[sp,#0x14]	; 02321A44
	b loc_02321A4E	; 02321A46
loc_02321A48:
	cmp r4,#0xf	; 02321A48
	blt loc_02321A4E	; 02321A4A
	mov r4,#0xe	; 02321A4C
loc_02321A4E:
	ldr r0,[r6,#0x70]	; 02321A4E
	cmp r0,#0x0	; 02321A50
	beq loc_02321ADC	; 02321A52
	cmp r4,#0x0	; 02321A54
	beq loc_02321ADC	; 02321A56
	ldr r1,[r6,#0x60]	; 02321A58
	ldr r0,[pool_02321AEC]	; 02321A5A
	add r0,r1,r0	; 02321A5C
	ldr r1,[pool_02321AF0]	; 02321A5E
	bl loc_0232D32C	; 02321A60
	str r0,[sp,#0x18]	; 02321A64
	ldr r1,[r6,#0x64]	; 02321A66
	ldr r0,[pool_02321AEC]	; 02321A68
	add r0,r1,r0	; 02321A6A
	ldr r1,[pool_02321AF0]	; 02321A6C
	bl loc_0232D32C	; 02321A6E
	add r7,r0,#0x0	; 02321A72
	cmp r5,#0xc	; 02321A74
	bge loc_02321AC4	; 02321A76
	lsl r1,r5,#0x1	; 02321A78
	ldr r0,[pool_02321AF4]	; 02321A7A
	ldrsh r6,[r0,r1]	; 02321A7C
	cmp r6,#0xb	; 02321A7E
	bne loc_02321AAC	; 02321A80
	ldr r0,[sp,#0x10]	; 02321A82
	cmp r0,#0x0	; 02321A84
	beq loc_02321ADC	; 02321A86
	ldr r0,[sp,#0x18]	; 02321A88
	add r0,#0xe	; 02321A8A
	add r1,r7,#0x7	; 02321A8C
	add r2,r4,#0x0	; 02321A8E
	bl loc_023264A0	; 02321A90
	bl loc_02323E84	; 02321A94
	ldr r1,[sp,#0x18]	; 02321A98
	str r1,[sp,#0x0]	; 02321A9A
	str r7,[sp,#0x4]	; 02321A9C
	str r4,[sp,#0x8]	; 02321A9E
	ldr r1,[pool_02321AF8]	; 02321AA0
	ldr r2,[pool_02321AFC]	; 02321AA2
	add r3,r6,#0x0	; 02321AA4
	bl loc_02323BEC	; 02321AA6
	b loc_02321ADC	; 02321AAA
loc_02321AAC:
	bl loc_02323E84	; 02321AAC
	ldr r1,[sp,#0x18]	; 02321AB0
	str r1,[sp,#0x0]	; 02321AB2
	str r7,[sp,#0x4]	; 02321AB4
	str r4,[sp,#0x8]	; 02321AB6
	ldr r1,[pool_02321AF8]	; 02321AB8
	ldr r2,[pool_02321AFC]	; 02321ABA
	add r3,r6,#0x0	; 02321ABC
	bl loc_02323BEC	; 02321ABE
	b loc_02321ADC	; 02321AC2
loc_02321AC4:
	ldr r0,[r6,#0x6c]	; 02321AC4
	bl loc_0232D3C4	; 02321AC6
	str r0,[sp,#0x0]	; 02321ACA
	lsl r1,r5,#0x1	; 02321ACC
	ldr r0,[pool_02321AF4]	; 02321ACE
	ldrsh r0,[r0,r1]	; 02321AD0
	ldr r1,[sp,#0x18]	; 02321AD2
	add r2,r7,#0x0	; 02321AD4
	add r3,r4,#0x0	; 02321AD6
	bl loc_02321B00	; 02321AD8
loc_02321ADC:
	add r5,r5,#0x1	; 02321ADC
	cmp r5,#0x14	; 02321ADE
	blt loc_02321A30	; 02321AE0
	add sp,#0x1c	; 02321AE2
	pop {r4,r5,r6,r7}	; 02321AE4
	pop {r3}	; 02321AE6
	bx r3	; 02321AE8
	.byte 0xC0, 0x46	; 02321AEC
pool_02321AEC:
loc_02321AEC:
	.word 0x00000800	; 02321AEC
pool_02321AF0:
loc_02321AF0:
	.word 0x00001000	; 02321AF0
pool_02321AF4:
loc_02321AF4:
	.word P1_Data_0232FEE4	; 02321AF4
pool_02321AF8:
loc_02321AF8:
	.word 0x023D3C10	; 02321AF8
pool_02321AFC:
loc_02321AFC:
	.word 0x023A579C	; 02321AFC

; ===== function loc_02321B00 =====
loc_02321B00:
	push {r4,r5,r6,r7,lr}	; 02321B00
	sub sp,#0x34	; 02321B02
	str r1,[sp,#0x0]	; 02321B04
	str r2,[sp,#0x4]	; 02321B06
	str r3,[sp,#0x8]	; 02321B08
	ldr r7,[pool_02321BDC]	; 02321B0A
	add r7,#0x8	; 02321B0C
	lsl r0,r0,#0x3	; 02321B0E
	str r0,[sp,#0x14]	; 02321B10
	add r5,r7,r0	; 02321B12
	ldr r0,[pool_02321BE0]	; 02321B14
	ldr r1,[r5,#0x4]	; 02321B16
	bl loc_023291C8	; 02321B18
	add r6,r0,#0x0	; 02321B1C
	ldr r0,[pool_02321BE0]	; 02321B1E
	ldr r1,[r5,#0x4]	; 02321B20
	bl loc_023291B0	; 02321B22
	add r4,r0,#0x0	; 02321B26
	ldr r0,[pool_02321BE0]	; 02321B28
	ldr r1,[r5,#0x4]	; 02321B2A
	bl loc_023291E0	; 02321B2C
	str r0,[sp,#0xc]	; 02321B30
	mov r1,sp	; 02321B32
	sub r1,r1,#0x4	; 02321B34
	ldr r0,[sp,#0x14]	; 02321B36
	ldrh r0,[r7,r0]	; 02321B38
	strh r0,[r1,#0x0]	; 02321B3A
	ldmia r1!,{r0}	; 02321B3C
	ldrb r1,[r4,#0x0]	; 02321B3E
	bl loc_023290E0	; 02321B40
	ldr r1,[sp,#0x0]	; 02321B44
	add r0,r1,r0	; 02321B46
	str r0,[sp,#0x0]	; 02321B48
	mov r1,sp	; 02321B4A
	sub r1,r1,#0x4	; 02321B4C
	ldrh r0,[r5,#0x2]	; 02321B4E
	strh r0,[r1,#0x0]	; 02321B50
	ldmia r1!,{r0}	; 02321B52
	ldrb r1,[r4,#0x1]	; 02321B54
	bl loc_023290A8	; 02321B56
	ldr r1,[sp,#0x4]	; 02321B5A
	add r0,r1,r0	; 02321B5C
	str r0,[sp,#0x4]	; 02321B5E
	ldr r0,[sp,#0x48]	; 02321B60
	cmp r0,#0x0	; 02321B62
	beq loc_02321BD4	; 02321B64
	str r0,[sp,#0x2c]	; 02321B66
	str r0,[sp,#0x20]	; 02321B68
	mov r5,#0x0	; 02321B6A
	str r5,[sp,#0x28]	; 02321B6C
	str r5,[sp,#0x24]	; 02321B6E
	ldr r0,[sp,#0x8]	; 02321B70
	lsl r0,r0,#0xc	; 02321B72
	str r0,[sp,#0x10]	; 02321B74
	b loc_02321BCE	; 02321B76
loc_02321B78:
	ldrh r7,[r6,#0x8]	; 02321B78
	ldr r0,[r6,#0x0]	; 02321B7A
	lsl r1,r0,#0x10	; 02321B7C
	lsr r1,r1,#0x1e	; 02321B7E
	lsl r2,r1,#0xe	; 02321B80
	lsr r1,r0,#0x1e	; 02321B82
	lsl r1,r1,#0x1e	; 02321B84
	orr r2,r1	; 02321B86
	lsl r0,r0,#0x7	; 02321B88
	lsr r1,r0,#0x17	; 02321B8A
	ldr r0,[sp,#0x0]	; 02321B8C
	add r0,r0,r1	; 02321B8E
	ldrb r1,[r4,#0x0]	; 02321B90
	lsr r1,r1,#0x1	; 02321B92
	sub r1,r0,r1	; 02321B94
	ldr r0,[pool_02321BE4]	; 02321B96
	and r1,r0	; 02321B98
	lsl r1,r1,#0x10	; 02321B9A
	ldrb r3,[r6,#0x0]	; 02321B9C
	ldr r0,[sp,#0x4]	; 02321B9E
	add r0,r0,r3	; 02321BA0
	ldrb r3,[r4,#0x1]	; 02321BA2
	lsr r3,r3,#0x1	; 02321BA4
	sub r3,r0,r3	; 02321BA6
	mov r0,#0xff	; 02321BA8
	and r3,r0	; 02321BAA
	orr r2,r3	; 02321BAC
	orr r1,r2	; 02321BAE
	ldr r0,[pool_02321BE8]	; 02321BB0
	orr r1,r0	; 02321BB2
	str r1,[sp,#0x18]	; 02321BB4
	ldr r1,[sp,#0x10]	; 02321BB6
	orr r1,r7	; 02321BB8
	add r0,sp,#0x18	; 02321BBA
	strh r1,[r0,#0x4]	; 02321BBC
	bl loc_02323E84	; 02321BBE
	add r1,sp,#0x18	; 02321BC2
	add r2,sp,#0x20	; 02321BC4
	bl loc_023239A0	; 02321BC6
	add r5,r5,#0x1	; 02321BCA
	add r6,#0xc	; 02321BCC
loc_02321BCE:
	ldr r0,[sp,#0xc]	; 02321BCE
	cmp r5,r0	; 02321BD0
	blt loc_02321B78	; 02321BD2
loc_02321BD4:
	add sp,#0x34	; 02321BD4
	pop {r4,r5,r6,r7}	; 02321BD6
	pop {r3}	; 02321BD8
	bx r3	; 02321BDA
pool_02321BDC:
loc_02321BDC:
	.word 0x023A579C	; 02321BDC
pool_02321BE0:
loc_02321BE0:
	.word 0x023D3C10	; 02321BE0
pool_02321BE4:
loc_02321BE4:
	.word 0x000001FF	; 02321BE4
pool_02321BE8:
loc_02321BE8:
	.word 0x00000300	; 02321BE8

; ===== function loc_02321BEC =====
loc_02321BEC:
	push {r4,r5,r6,r7,lr}	; 02321BEC
	sub sp,#0x14	; 02321BEE
	add r5,r0,#0x0	; 02321BF0
	str r1,[sp,#0x8]	; 02321BF2
	mov r7,#0x0	; 02321BF4
	add r6,r7,#0x0	; 02321BF6
	add r3,r7,#0x0	; 02321BF8
	ldr r2,[r5,#0x70]	; 02321BFA
	b loc_02321C10	; 02321BFC
loc_02321BFE:
	add r4,r3,#0x0	; 02321BFE
	mov r0,#0x18	; 02321C00
	mul r4,r0	; 02321C02
	ldr r1,[r5,r4]	; 02321C04
	ldr r0,[sp,#0x8]	; 02321C06
	cmp r1,r0	; 02321C08
	bhi loc_02321C0E	; 02321C0A
	add r7,r5,r4	; 02321C0C
loc_02321C0E:
	add r3,r3,#0x1	; 02321C0E
loc_02321C10:
	cmp r3,r2	; 02321C10
	bcc loc_02321BFE	; 02321C12
	sub r3,r2,#0x1	; 02321C14
	mov r4,#0x18	; 02321C16
	b loc_02321C2A	; 02321C18
loc_02321C1A:
	add r2,r3,#0x0	; 02321C1A
	mul r2,r4	; 02321C1C
	ldr r1,[r5,r2]	; 02321C1E
	ldr r0,[sp,#0x8]	; 02321C20
	cmp r1,r0	; 02321C22
	bls loc_02321C28	; 02321C24
	add r6,r5,r2	; 02321C26
loc_02321C28:
	sub r3,r3,#0x1	; 02321C28
loc_02321C2A:
	cmp r3,#0x0	; 02321C2A
	bge loc_02321C1A	; 02321C2C
	cmp r7,#0x0	; 02321C2E
	bne loc_02321C44	; 02321C30
	mov r2,#0x0	; 02321C32
loc_02321C34:
	lsl r0,r2,#0x2	; 02321C34
	add r1,r5,r0	; 02321C36
	ldr r0,[r1,#0x4]	; 02321C38
	str r0,[r1,#0x60]	; 02321C3A
	add r2,r2,#0x1	; 02321C3C
	cmp r2,#0x4	; 02321C3E
	blt loc_02321C34	; 02321C40
	b loc_02321C9E	; 02321C42
loc_02321C44:
	cmp r6,#0x0	; 02321C44
	bne loc_02321C66	; 02321C46
	mov r0,#0x0	; 02321C48
	mov r1,#0x18	; 02321C4A
loc_02321C4C:
	lsl r4,r0,#0x2	; 02321C4C
	ldr r2,[r5,#0x70]	; 02321C4E
	mul r2,r1	; 02321C50
	add r2,r5,r2	; 02321C52
	add r2,r4,r2	; 02321C54
	sub r2,#0x14	; 02321C56
	ldr r3,[r2,#0x0]	; 02321C58
	add r2,r5,r4	; 02321C5A
	str r3,[r2,#0x60]	; 02321C5C
	add r0,r0,#0x1	; 02321C5E
	cmp r0,#0x4	; 02321C60
	blt loc_02321C4C	; 02321C62
	b loc_02321C9E	; 02321C64
loc_02321C66:
	mov r4,#0x0	; 02321C66
	str r4,[sp,#0x10]	; 02321C68
loc_02321C6A:
	cmp r4,#0x2	; 02321C6A
	bne loc_02321C72	; 02321C6C
	ldr r3,[sp,#0x10]	; 02321C6E
	b loc_02321C74	; 02321C70
loc_02321C72:
	ldr r3,[r7,#0x14]	; 02321C72
loc_02321C74:
	lsl r0,r4,#0x2	; 02321C74
	str r0,[sp,#0xc]	; 02321C76
	ldr r0,[r6,#0x0]	; 02321C78
	str r0,[sp,#0x0]	; 02321C7A
	ldr r0,[sp,#0xc]	; 02321C7C
	add r0,r6,r0	; 02321C7E
	ldr r0,[r0,#0x4]	; 02321C80
	str r0,[sp,#0x4]	; 02321C82
	ldr r0,[sp,#0x8]	; 02321C84
	ldr r1,[r7,#0x0]	; 02321C86
	ldr r2,[sp,#0xc]	; 02321C88
	add r2,r7,r2	; 02321C8A
	ldr r2,[r2,#0x4]	; 02321C8C
	bl loc_02321CA8	; 02321C8E
	ldr r1,[sp,#0xc]	; 02321C92
	add r1,r5,r1	; 02321C94
	str r0,[r1,#0x60]	; 02321C96
	add r4,r4,#0x1	; 02321C98
	cmp r4,#0x4	; 02321C9A
	blt loc_02321C6A	; 02321C9C
loc_02321C9E:
	add sp,#0x14	; 02321C9E
	pop {r4,r5,r6,r7}	; 02321CA0
	pop {r3}	; 02321CA2
	bx r3	; 02321CA4
	.byte 0x00, 0x00	; 02321CA8

; ===== function loc_02321CA8 =====
loc_02321CA8:
	push {r4,r5,r6,r7,lr}	; 02321CA8
	sub sp,#0x4	; 02321CAA
	add r4,r2,#0x0	; 02321CAC
	add r7,r3,#0x0	; 02321CAE
	sub r0,r0,r1	; 02321CB0
	lsl r0,r0,#0xc	; 02321CB2
	ldr r2,[sp,#0x18]	; 02321CB4
	sub r1,r2,r1	; 02321CB6
	blx P1_SignedDivMod	; 02321CB8
	add r5,r0,#0x0	; 02321CBC
	ldr r0,[pool_02321CFC]	; 02321CBE
	sub r0,r0,r5	; 02321CC0
	str r0,[sp,#0x0]	; 02321CC2
	add r1,r4,#0x0	; 02321CC4
	blx loc_0232D3D8	; 02321CC6
	add r6,r0,#0x0	; 02321CCA
	ldr r0,[sp,#0x0]	; 02321CCC
	ldr r1,[pool_02321CFC]	; 02321CCE
	add r1,r5,r1	; 02321CD0
	blx loc_0232D3D8	; 02321CD2
	add r1,r7,#0x0	; 02321CD6
	blx loc_0232D3D8	; 02321CD8
	ldr r1,[sp,#0x1c]	; 02321CDC
	sub r1,r1,r4	; 02321CDE
	blx loc_0232D3D8	; 02321CE0
	add r4,r0,#0x0	; 02321CE4
	add r0,r5,#0x0	; 02321CE6
	ldr r1,[sp,#0x1c]	; 02321CE8
	blx loc_0232D3D8	; 02321CEA
	add r0,r4,r0	; 02321CEE
	add r0,r6,r0	; 02321CF0
	add sp,#0x4	; 02321CF2
	pop {r4,r5,r6,r7}	; 02321CF4
	pop {r3}	; 02321CF6
	bx r3	; 02321CF8
	.byte 0xC0, 0x46	; 02321CFC
pool_02321CFC:
loc_02321CFC:
	.word 0x00001000	; 02321CFC

; ===== function loc_02321D00 =====
loc_02321D00:
	ldr r3,[pool_02321D04]	; 02321D00
	bx r3	; 02321D02
pool_02321D04:
loc_02321D04:
	.word loc_02324338 + 1	; 02321D04

; ===== function loc_02321D08 =====
loc_02321D08:
	ldr r3,[pool_02321D0C]	; 02321D08
	bx r3	; 02321D0A
pool_02321D0C:
loc_02321D0C:
	.word loc_02324348 + 1	; 02321D0C

; ===== function loc_02321D10 =====
loc_02321D10:
	ldr r3,[pool_02321D14]	; 02321D10
	bx r3	; 02321D12
pool_02321D14:
loc_02321D14:
	.word loc_0232435C + 1	; 02321D14

; ===== function loc_02321D18 =====
loc_02321D18:
	push {r4,lr}	; 02321D18
	add r4,r0,#0x0	; 02321D1A
	ldr r1,[pool_02321D50]	; 02321D1C
	bl loc_02324370	; 02321D1E
	mov r0,#0x0	; 02321D22
	bl loc_023253F4	; 02321D24
	cmp r0,#0x0	; 02321D28
	beq loc_02321D32	; 02321D2A
	mov r0,#0x0	; 02321D2C
	str r0,[r4,#0xc]	; 02321D2E
	b loc_02321D48	; 02321D30
loc_02321D32:
	mov r0,#0x1	; 02321D32
	bl loc_023253F4	; 02321D34
	cmp r0,#0x0	; 02321D38
	beq loc_02321D42	; 02321D3A
	mov r0,#0x1	; 02321D3C
	str r0,[r4,#0xc]	; 02321D3E
	b loc_02321D48	; 02321D40
loc_02321D42:
	mov r0,#0x0	; 02321D42
	mvn r0,r0	; 02321D44
	str r0,[r4,#0xc]	; 02321D46
loc_02321D48:
	pop {r4}	; 02321D48
	pop {r3}	; 02321D4A
	bx r3	; 02321D4C
	.byte 0xC0, 0x46	; 02321D50
pool_02321D50:
loc_02321D50:
	.word 0x023A4AE8	; 02321D50

; ===== function loc_02321D54 =====
loc_02321D54:
	push {r4,lr}	; 02321D54
	add r4,r0,#0x0	; 02321D56
	bl loc_0232441C	; 02321D58
	mov r0,#0x0	; 02321D5C
	mvn r0,r0	; 02321D5E
	str r0,[r4,#0xc]	; 02321D60
	pop {r4}	; 02321D62
	pop {r3}	; 02321D64
	bx r3	; 02321D66

; ===== function loc_02321D68 =====
loc_02321D68:
	push {r4,lr}	; 02321D68
	sub sp,#0x8	; 02321D6A
	ldr r0,[pool_02321DF8]	; 02321D6C
	ldr r0,[r0,#0x0]	; 02321D6E
	cmp r0,#0x0	; 02321D70
	beq loc_02321DE2	; 02321D72
	ldr r0,[pool_02321DFC]	; 02321D74
	ldr r0,[r0,#0x0]	; 02321D76
	cmp r0,#0x0	; 02321D78
	beq loc_02321D84	; 02321D7A
	ldr r0,[pool_02321E00]	; 02321D7C
	ldr r0,[r0,#0x0]	; 02321D7E
	cmp r0,#0xf	; 02321D80
	bge loc_02321DE2	; 02321D82
loc_02321D84:
	ldr r0,[pool_02321E00]	; 02321D84
	ldr r1,[r0,#0x0]	; 02321D86
	add r1,r1,#0x1	; 02321D88
	str r1,[r0,#0x0]	; 02321D8A
	lsl r0,r1,#0x4	; 02321D8C
	mov r1,#0xf	; 02321D8E
	blx P1_SignedDivMod	; 02321D90
	mov r3,#0x10	; 02321D94
	sub r1,r3,r0	; 02321D96
	lsl r0,r0,#0x8	; 02321D98
	orr r1,r0	; 02321D9A
	ldr r0,[pool_02321E04]	; 02321D9C
	strh r1,[r0,#0x0]	; 02321D9E
	ldr r0,[pool_02321DFC]	; 02321DA0
	ldr r0,[r0,#0x0]	; 02321DA2
	cmp r0,#0x0	; 02321DA4
	bne loc_02321DE2	; 02321DA6
	ldr r0,[pool_02321E00]	; 02321DA8
	ldr r0,[r0,#0x0]	; 02321DAA
	cmp r0,#0xf	; 02321DAC
	bne loc_02321DE2	; 02321DAE
	ldr r1,[pool_02321E08]	; 02321DB0
	ldr r4,[r1,#0x0]	; 02321DB2
	mov r0,#0x12	; 02321DB4
	bic r4,r0	; 02321DB6
	str r4,[r1,#0x0]	; 02321DB8
	ldr r1,[pool_02321E0C]	; 02321DBA
	ldr r2,[r1,#0x0]	; 02321DBC
	ldr r0,[pool_02321E10]	; 02321DBE
	and r2,r0	; 02321DC0
	lsl r0,r4,#0x8	; 02321DC2
	orr r2,r0	; 02321DC4
	str r2,[r1,#0x0]	; 02321DC6
	mov r0,#0x0	; 02321DC8
	str r0,[sp,#0x0]	; 02321DCA
	ldr r0,[pool_02321E14]	; 02321DCC
	mov r1,#0x4	; 02321DCE
	mov r2,#0x8	; 02321DD0
	bl loc_0232D968	; 02321DD2
	mov r1,#0x0	; 02321DD6
	ldr r0,[pool_02321E00]	; 02321DD8
	str r1,[r0,#0x0]	; 02321DDA
	mov r1,#0x1	; 02321DDC
	ldr r0,[pool_02321DFC]	; 02321DDE
	str r1,[r0,#0x0]	; 02321DE0
loc_02321DE2:
	bl loc_0232333C	; 02321DE2
	bl loc_02322A84	; 02321DE6
	bl loc_023230CC	; 02321DEA
	add sp,#0x8	; 02321DEE
	pop {r4}	; 02321DF0
	pop {r3}	; 02321DF2
	bx r3	; 02321DF4
	.byte 0xC0, 0x46	; 02321DF8
pool_02321DF8:
loc_02321DF8:
	.word P1_BssStart + 0x1384	; 02321DF8
pool_02321DFC:
loc_02321DFC:
	.word P1_BssStart + 0x1380	; 02321DFC
pool_02321E00:
loc_02321E00:
	.word P1_BssStart + 0x1378	; 02321E00
pool_02321E04:
loc_02321E04:
	.word REG_BLDALPHA	; 02321E04
pool_02321E08:
loc_02321E08:
	.word P1_BssStart + 0x1370	; 02321E08
pool_02321E0C:
loc_02321E0C:
	.word REG_DISPCNT_A	; 02321E0C
pool_02321E10:
loc_02321E10:
	.word 0xFFFFE0FF	; 02321E10
pool_02321E14:
loc_02321E14:
	.word REG_BLDCNT	; 02321E14

; ===== function loc_02321E18 =====
loc_02321E18:
	push {lr}	; 02321E18
	sub sp,#0x4	; 02321E1A
	mov r0,#0x0	; 02321E1C
	str r0,[sp,#0x0]	; 02321E1E
	ldr r0,[pool_02321E38]	; 02321E20
	mov r1,#0x12	; 02321E22
	mov r2,#0x1c	; 02321E24
	mov r3,#0x10	; 02321E26
	bl loc_0232D968	; 02321E28
	mov r1,#0x1	; 02321E2C
	ldr r0,[pool_02321E3C]	; 02321E2E
	str r1,[r0,#0x0]	; 02321E30
	add sp,#0x4	; 02321E32
	pop {r3}	; 02321E34
	bx r3	; 02321E36
pool_02321E38:
loc_02321E38:
	.word REG_BLDCNT	; 02321E38
pool_02321E3C:
loc_02321E3C:
	.word P1_BssStart + 0x1384	; 02321E3C

; ===== function loc_02321E40 =====
loc_02321E40:
	push {lr}	; 02321E40
	sub sp,#0x4	; 02321E42
	mov r1,#0x1	; 02321E44
	ldr r0,[pool_02321E78]	; 02321E46
	str r1,[r0,#0x0]	; 02321E48
	mov r1,#0x0	; 02321E4A
	ldr r0,[pool_02321E7C]	; 02321E4C
	str r1,[r0,#0x0]	; 02321E4E
	bl loc_02321F60	; 02321E50
	bl loc_0232336C	; 02321E54
	bl loc_023230EC	; 02321E58
	bl loc_02322CBC	; 02321E5C
	bl loc_023235E4	; 02321E60
	ldr r0,[pool_02321E80]	; 02321E64
	bl loc_02322884	; 02321E66
	mov r1,#0x0	; 02321E6A
	ldr r0,[pool_02321E84]	; 02321E6C
	str r1,[r0,#0x8]	; 02321E6E
	add sp,#0x4	; 02321E70
	pop {r3}	; 02321E72
	bx r3	; 02321E74
	.byte 0xC0, 0x46	; 02321E78
pool_02321E78:
loc_02321E78:
	.word P1_BssStart + 0x137C	; 02321E78
pool_02321E7C:
loc_02321E7C:
	.word P1_BssStart + 0x1374	; 02321E7C
pool_02321E80:
loc_02321E80:
	.word 0x02331E08	; 02321E80
pool_02321E84:
loc_02321E84:
	.word P1_BssStart + 0x1444	; 02321E84

; ===== function loc_02321E88 =====
loc_02321E88:
	push {lr}	; 02321E88
	sub sp,#0x4	; 02321E8A
	ldr r1,[pool_02321EC8]	; 02321E8C
	ldr r2,[r1,#0x0]	; 02321E8E
	mov r0,#0xe	; 02321E90
	mul r2,r0	; 02321E92
	ldr r0,[pool_02321ECC]	; 02321E94
	ldrh r0,[r0,r2]	; 02321E96
	cmp r0,#0x0	; 02321E98
	bne loc_02321EA0	; 02321E9A
	mov r0,#0x0	; 02321E9C
	b loc_02321EC2	; 02321E9E
loc_02321EA0:
	cmp r0,#0x2	; 02321EA0
	blt loc_02321EAA	; 02321EA2
	mov r0,#0xf	; 02321EA4
	mvn r0,r0	; 02321EA6
	b loc_02321EC2	; 02321EA8
loc_02321EAA:
	mov r0,#0x6	; 02321EAA
	ldrsh r0,[r1,r0]	; 02321EAC
	lsl r0,r0,#0x6	; 02321EAE
	mov r1,#0xf	; 02321EB0
	blx P1_SignedDivMod	; 02321EB2
	sub r0,#0x30	; 02321EB6
	cmp r0,#0x0	; 02321EB8
	ble loc_02321EC0	; 02321EBA
	neg r0,r0	; 02321EBC
	b loc_02321EC2	; 02321EBE
loc_02321EC0:
	mov r0,#0x0	; 02321EC0
loc_02321EC2:
	add sp,#0x4	; 02321EC2
	pop {r3}	; 02321EC4
	bx r3	; 02321EC6
pool_02321EC8:
loc_02321EC8:
	.word P1_BssStart + 0x1444	; 02321EC8
pool_02321ECC:
loc_02321ECC:
	.word P1_Data_02330074	; 02321ECC

; ===== function loc_02321ED0 =====
P1_Entry_02321ED0:
	push {r4,lr}	; 02321ED0
	sub sp,#0x128	; 02321ED2
	add r4,r0,#0x0	; 02321ED4
	cmp r4,#0x0	; 02321ED6
	beq loc_02321F38	; 02321ED8
	add r0,sp,#0x0	; 02321EDA
	ldr r1,[pool_02321F44]	; 02321EDC
	add r1,r4,r1	; 02321EDE
	mov r2,#0x30	; 02321EE0
	bl P1_Utf16StrNCpy	; 02321EE2
	mov r1,#0x0	; 02321EE6
	add r0,sp,#0x40	; 02321EE8
	strh r1,[r0,#0x20]	; 02321EEA
	add r0,sp,#0x60	; 02321EEC
	add r0,#0x2	; 02321EEE
	ldr r1,[pool_02321F48]	; 02321EF0
	add r1,r4,r1	; 02321EF2
	mov r2,#0x60	; 02321EF4
	bl P1_Utf16StrNCpy	; 02321EF6
	mov r1,#0x0	; 02321EFA
	add r0,sp,#0x120	; 02321EFC
	add r0,#0x2	; 02321EFE
	strh r1,[r0,#0x0]	; 02321F00
	mov r0,#0x11	; 02321F02
	bl loc_02322134	; 02321F04
	ldr r0,[pool_02321F4C]	; 02321F08
	add r1,sp,#0x0	; 02321F0A
	bl loc_02324B44	; 02321F0C
	ldr r0,[pool_02321F50]	; 02321F10
	add r1,sp,#0x60	; 02321F12
	add r1,#0x2	; 02321F14
	bl loc_02324B44	; 02321F16
	add r0,r4,#0x0	; 02321F1A
	add r0,#0x20	; 02321F1C
	ldr r1,[pool_02321F54]	; 02321F1E
	ldr r2,[pool_02321F58]	; 02321F20
	bl loc_0232DC30	; 02321F22
	add r0,r4,#0x0	; 02321F26
	ldr r1,[pool_02321F5C]	; 02321F28
	mov r2,#0x20	; 02321F2A
	bl loc_0232DCD0	; 02321F2C
	add r0,r4,#0x0	; 02321F30
	bl loc_02323554	; 02321F32
	b loc_02321F3C	; 02321F36
loc_02321F38:
	bl loc_02323548	; 02321F38
loc_02321F3C:
	add sp,#0x128	; 02321F3C
	pop {r4}	; 02321F3E
	pop {r3}	; 02321F40
	bx r3	; 02321F42
pool_02321F44:
loc_02321F44:
	.word 0x00000238	; 02321F44
pool_02321F48:
loc_02321F48:
	.word 0x00000298	; 02321F48
pool_02321F4C:
loc_02321F4C:
	.word 0x02331EFC	; 02321F4C
pool_02321F50:
loc_02321F50:
	.word 0x02331F80	; 02321F50
pool_02321F54:
loc_02321F54:
	.word 0x0001EE00	; 02321F54
pool_02321F58:
loc_02321F58:
	.word 0x00000200	; 02321F58
pool_02321F5C:
loc_02321F5C:
	.word 0x00000140	; 02321F5C

; ===== function loc_02321F60 =====
loc_02321F60:
	push {r4,r5,r6,r7,lr}	; 02321F60
	sub sp,#0xc	; 02321F62
	ldr r0,[pool_023220B4]	; 02321F64
	ldrb r0,[r0,#0x0]	; 02321F66
	lsl r0,r0,#0x1c	; 02321F68
	lsr r7,r0,#0x1c	; 02321F6A
	mov r1,#0x1f	; 02321F6C
	ldr r0,[pool_023220B8]	; 02321F6E
	str r1,[r0,#0x0]	; 02321F70
	ldr r2,[pool_023220BC]	; 02321F72
	ldr r3,[r2,#0x0]	; 02321F74
	ldr r0,[pool_023220C0]	; 02321F76
	and r3,r0	; 02321F78
	ldr r0,[pool_023220C4]	; 02321F7A
	orr r3,r0	; 02321F7C
	str r3,[r2,#0x0]	; 02321F7E
	ldr r0,[pool_023220C8]	; 02321F80
	mov r2,#0x10	; 02321F82
	bl loc_0232D94C	; 02321F84
	ldr r5,[pool_023220CC]	; 02321F88
	ldrh r2,[r5,#0x0]	; 02321F8A
	mov r0,#0x43	; 02321F8C
	and r2,r0	; 02321F8E
	mov r1,#0x10	; 02321F90
	orr r2,r1	; 02321F92
	strh r2,[r5,#0x0]	; 02321F94
	ldr r4,[pool_023220D0]	; 02321F96
	ldrh r2,[r4,#0x0]	; 02321F98
	and r2,r0	; 02321F9A
	ldr r1,[pool_023220D4]	; 02321F9C
	orr r2,r1	; 02321F9E
	strh r2,[r4,#0x0]	; 02321FA0
	ldr r3,[pool_023220D8]	; 02321FA2
	ldrh r2,[r3,#0x0]	; 02321FA4
	and r2,r0	; 02321FA6
	ldr r1,[pool_023220DC]	; 02321FA8
	orr r2,r1	; 02321FAA
	strh r2,[r3,#0x0]	; 02321FAC
	ldr r1,[pool_023220E0]	; 02321FAE
	ldrh r2,[r1,#0x0]	; 02321FB0
	and r2,r0	; 02321FB2
	ldr r0,[pool_023220E4]	; 02321FB4
	orr r2,r0	; 02321FB6
	strh r2,[r1,#0x0]	; 02321FB8
	ldrh r2,[r5,#0x0]	; 02321FBA
	mov r0,#0x3	; 02321FBC
	bic r2,r0	; 02321FBE
	strh r2,[r5,#0x0]	; 02321FC0
	ldrh r2,[r4,#0x0]	; 02321FC2
	bic r2,r0	; 02321FC4
	strh r2,[r4,#0x0]	; 02321FC6
	ldrh r2,[r3,#0x0]	; 02321FC8
	bic r2,r0	; 02321FCA
	orr r2,r0	; 02321FCC
	strh r2,[r3,#0x0]	; 02321FCE
	ldrh r2,[r1,#0x0]	; 02321FD0
	bic r2,r0	; 02321FD2
	orr r2,r0	; 02321FD4
	strh r2,[r1,#0x0]	; 02321FD6
	mov r1,#0x0	; 02321FD8
	ldr r0,[pool_023220E8]	; 02321FDA
	str r1,[r0,#0x0]	; 02321FDC
	ldr r0,[pool_023220EC]	; 02321FDE
	str r1,[r0,#0x0]	; 02321FE0
	ldr r0,[pool_023220F0]	; 02321FE2
	str r1,[r0,#0x0]	; 02321FE4
	ldr r0,[pool_023220F4]	; 02321FE6
	str r1,[r0,#0x0]	; 02321FE8
	bl P1_GetMainBg1TilemapBase	; 02321FEA
	add r5,r0,#0x0	; 02321FEE
	mov r3,#0x0	; 02321FF0
	str r3,[sp,#0x0]	; 02321FF2
loc_02321FF4:
	ldr r4,[sp,#0x0]	; 02321FF4
	lsl r2,r3,#0x5	; 02321FF6
	lsl r0,r3,#0x6	; 02321FF8
	add r1,r5,r0	; 02321FFA
loc_02321FFC:
	add r0,r4,r2	; 02321FFC
	ldr r6,[pool_023220F8]	; 02321FFE
	orr r0,r6	; 02322000
	lsl r6,r4,#0x1	; 02322002
	strh r0,[r1,r6]	; 02322004
	add r4,r4,#0x1	; 02322006
	cmp r4,#0x20	; 02322008
	blt loc_02321FFC	; 0232200A
	add r3,r3,#0x1	; 0232200C
	cmp r3,#0x18	; 0232200E
	blt loc_02321FF4	; 02322010
	bl P1_GetMainBg1CharacterBase	; 02322012
	add r1,r0,#0x0	; 02322016
	mov r0,#0x0	; 02322018
	str r0,[sp,#0x4]	; 0232201A
	ldr r0,[sp,#0x4]	; 0232201C
	ldr r2,[pool_023220FC]	; 0232201E
	blx loc_0232DE4C	; 02322020
	ldr r0,[pool_02322100]	; 02322024
	mov r1,#0x0	; 02322026
	ldr r2,[pool_02322104]	; 02322028
	sub r2,r2,r0	; 0232202A
	bl loc_0232DA00	; 0232202C
	ldr r0,[pool_02322108]	; 02322030
	mov r1,#0x0	; 02322032
	ldr r2,[pool_0232210C]	; 02322034
	sub r2,r2,r0	; 02322036
	bl loc_0232DD20	; 02322038
	mov r1,#0x0	; 0232203C
	ldr r0,[pool_02322110]	; 0232203E
	strh r1,[r0,#0x0]	; 02322040
	mov r1,#0x2	; 02322042
	blx P1_CleanDataCacheRange	; 02322044
	ldr r0,[pool_02322110]	; 02322048
	mov r1,#0x0	; 0232204A
	mov r2,#0x2	; 0232204C
	bl loc_0232DD20	; 0232204E
	ldr r1,[pool_02322114]	; 02322052
	lsl r0,r7,#0x5	; 02322054
	add r5,r1,r0	; 02322056
	add r0,r5,#0x0	; 02322058
	ldr r1,[pool_02322118]	; 0232205A
	mov r2,#0x20	; 0232205C
	bl loc_0232DD20	; 0232205E
	ldr r0,[pool_0232211C]	; 02322062
	mov r1,#0x0	; 02322064
	ldr r2,[pool_02322120]	; 02322066
	sub r2,r2,r0	; 02322068
	bl loc_0232DB40	; 0232206A
	ldr r0,[pool_02322124]	; 0232206E
	mov r1,#0x0	; 02322070
	ldr r2,[pool_02322128]	; 02322072
	sub r2,r2,r0	; 02322074
	bl loc_0232DAF0	; 02322076
	bl loc_02323E84	; 0232207A
	bl loc_02324054	; 0232207E
	bl loc_02323E84	; 02322082
	ldr r1,[pool_0232212C]	; 02322086
	bl loc_02323FC0	; 02322088
	bl loc_02324C88	; 0232208C
	add r4,r0,#0x0	; 02322090
	bl loc_02323E84	; 02322092
	add r2,r0,#0x0	; 02322096
	add r0,r4,#0x0	; 02322098
	ldr r1,[pool_02322130]	; 0232209A
	ldr r1,[r2,r1]	; 0232209C
	bl loc_02324C2C	; 0232209E
	add r0,r5,#0x0	; 023220A2
	ldr r1,[pool_02322118]	; 023220A4
	mov r2,#0x20	; 023220A6
	bl loc_0232DCD0	; 023220A8
	add sp,#0xc	; 023220AC
	pop {r4,r5,r6,r7}	; 023220AE
	pop {r3}	; 023220B0
	bx r3	; 023220B2
pool_023220B4:
loc_023220B4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsThemeOffset	; 023220B4
pool_023220B8:
loc_023220B8:
	.word P1_BssStart + 0x1370	; 023220B8
pool_023220BC:
loc_023220BC:
	.word REG_DISPCNT_A	; 023220BC
pool_023220C0:
loc_023220C0:
	.word 0xFFFFE0FF	; 023220C0
pool_023220C4:
loc_023220C4:
	.word 0x00001F00	; 023220C4
pool_023220C8:
loc_023220C8:
	.word REG_BLDCNT	; 023220C8
pool_023220CC:
loc_023220CC:
	.word REG_BG0CNT	; 023220CC
pool_023220D0:
loc_023220D0:
	.word REG_BG1CNT	; 023220D0
pool_023220D4:
loc_023220D4:
	.word 0x00000D08	; 023220D4
pool_023220D8:
loc_023220D8:
	.word REG_BG2CNT	; 023220D8
pool_023220DC:
loc_023220DC:
	.word 0x00000E10	; 023220DC
pool_023220E0:
loc_023220E0:
	.word REG_BG3CNT	; 023220E0
pool_023220E4:
loc_023220E4:
	.word 0x00000F10	; 023220E4
pool_023220E8:
loc_023220E8:
	.word REG_BG0HOFS	; 023220E8
pool_023220EC:
loc_023220EC:
	.word REG_BG1HOFS	; 023220EC
pool_023220F0:
loc_023220F0:
	.word REG_BG2HOFS	; 023220F0
pool_023220F4:
loc_023220F4:
	.word REG_BG3HOFS	; 023220F4
pool_023220F8:
loc_023220F8:
	.word 0x00003000	; 023220F8
pool_023220FC:
loc_023220FC:
	.word 0x00008000	; 023220FC
pool_02322100:
loc_02322100:
	.word 0x023AE640	; 02322100
pool_02322104:
loc_02322104:
	.word 0x023B0240	; 02322104
pool_02322108:
loc_02322108:
	.word 0x023BBDC0	; 02322108
pool_0232210C:
loc_0232210C:
	.word 0x023BBFC0	; 0232210C
pool_02322110:
loc_02322110:
	.word P1_BssStart + 0x136C	; 02322110
pool_02322114:
loc_02322114:
	.word 0x023BC9C0	; 02322114
pool_02322118:
loc_02322118:
	.word 0x000001E0	; 02322118
pool_0232211C:
loc_0232211C:
	.word 0x023B85C0	; 0232211C
pool_02322120:
loc_02322120:
	.word 0x023B8DC0	; 02322120
pool_02322124:
loc_02322124:
	.word 0x023B6DC0	; 02322124
pool_02322128:
loc_02322128:
	.word 0x023B75C0	; 02322128
pool_0232212C:
loc_0232212C:
	.word 0x023C1178	; 0232212C
pool_02322130:
loc_02322130:
	.word 0x0000062C	; 02322130

; ===== function loc_02322134 =====
loc_02322134:
	push {r4,r5,r6,lr}	; 02322134
	add r6,r0,#0x0	; 02322136
	mov r0,#0xe	; 02322138
	add r4,r6,#0x0	; 0232213A
	mul r4,r0	; 0232213C
	ldr r5,[pool_02322190]	; 0232213E
	ldrh r3,[r5,r4]	; 02322140
	ldr r1,[pool_02322194]	; 02322142
	ldr r2,[r1,#0x0]	; 02322144
	mul r2,r0	; 02322146
	ldrh r0,[r5,r2]	; 02322148
	cmp r3,r0	; 0232214A
	bcc loc_0232217E	; 0232214C
	sub r5,r3,#0x1	; 0232214E
	mov r0,#0x2c	; 02322150
	mul r5,r0	; 02322152
	ldr r0,[pool_02322198]	; 02322154
	add r0,r0,r5	; 02322156
	ldr r1,[pool_0232219C]	; 02322158
	ldr r2,[pool_023221A0]	; 0232215A
	ldrh r2,[r2,r4]	; 0232215C
	bl loc_02324BA0	; 0232215E
	ldr r0,[pool_023221A4]	; 02322162
	add r0,r0,r5	; 02322164
	ldr r1,[pool_0232219C]	; 02322166
	ldr r2,[pool_023221A8]	; 02322168
	ldrh r2,[r2,r4]	; 0232216A
	bl loc_02324BA0	; 0232216C
	ldr r0,[pool_02322194]	; 02322170
	str r6,[r0,#0x0]	; 02322172
	mov r1,#0x0	; 02322174
	strh r1,[r0,#0x6]	; 02322176
	mov r1,#0x1	; 02322178
	strh r1,[r0,#0x4]	; 0232217A
	b loc_02322188	; 0232217C
loc_0232217E:
	mov r0,#0xf	; 0232217E
	strh r0,[r1,#0x6]	; 02322180
	mov r0,#0x0	; 02322182
	mvn r0,r0	; 02322184
	strh r0,[r1,#0x4]	; 02322186
loc_02322188:
	pop {r4,r5,r6}	; 02322188
	pop {r3}	; 0232218A
	bx r3	; 0232218C
	.byte 0xC0, 0x46	; 02322190
pool_02322190:
loc_02322190:
	.word P1_Data_02330074	; 02322190
pool_02322194:
loc_02322194:
	.word P1_BssStart + 0x1444	; 02322194
pool_02322198:
loc_02322198:
	.word 0x02331ED0	; 02322198
pool_0232219C:
loc_0232219C:
	.word 0x023A6174	; 0232219C
pool_023221A0:
loc_023221A0:
	.word P1_Data_02330076	; 023221A0
pool_023221A4:
loc_023221A4:
	.word 0x02331F54	; 023221A4
pool_023221A8:
loc_023221A8:
	.word P1_Data_02330078	; 023221A8

; ===== function loc_023221AC =====
loc_023221AC:
	push {r4,r5,r6,r7,lr}	; 023221AC
	sub sp,#0x4	; 023221AE
	mov r5,#0x0	; 023221B0
	ldr r7,[pool_023221FC]	; 023221B2
	b loc_023221E2	; 023221B4
loc_023221B6:
	lsl r0,r5,#0x1	; 023221B6
	add r0,r2,r0	; 023221B8
	ldrh r1,[r0,#0x6]	; 023221BA
	mov r0,#0xe	; 023221BC
	mul r1,r0	; 023221BE
	add r4,r7,r1	; 023221C0
	add r6,r5,#0x0	; 023221C2
	mov r0,#0x2c	; 023221C4
	mul r6,r0	; 023221C6
	ldr r0,[pool_02322200]	; 023221C8
	add r0,r0,r6	; 023221CA
	ldr r1,[pool_02322204]	; 023221CC
	ldrh r2,[r4,#0x2]	; 023221CE
	bl loc_02324BA0	; 023221D0
	ldr r0,[pool_02322208]	; 023221D4
	add r0,r0,r6	; 023221D6
	ldr r1,[pool_02322204]	; 023221D8
	ldrh r2,[r4,#0x4]	; 023221DA
	bl loc_02324BA0	; 023221DC
	add r5,r5,#0x1	; 023221E0
loc_023221E2:
	ldr r0,[pool_0232220C]	; 023221E2
	ldr r1,[r0,#0x0]	; 023221E4
	mov r0,#0xe	; 023221E6
	mul r1,r0	; 023221E8
	add r2,r7,r1	; 023221EA
	ldrh r0,[r7,r1]	; 023221EC
	cmp r5,r0	; 023221EE
	blt loc_023221B6	; 023221F0
	add sp,#0x4	; 023221F2
	pop {r4,r5,r6,r7}	; 023221F4
	pop {r3}	; 023221F6
	bx r3	; 023221F8
	.byte 0xC0, 0x46	; 023221FC
pool_023221FC:
loc_023221FC:
	.word 0x02330074	; 023221FC
pool_02322200:
loc_02322200:
	.word 0x02331ED0	; 02322200
pool_02322204:
loc_02322204:
	.word 0x023A6174	; 02322204
pool_02322208:
loc_02322208:
	.word 0x02331F54	; 02322208
pool_0232220C:
loc_0232220C:
	.word P1_BssStart + 0x1444	; 0232220C

; ===== function loc_02322210 =====
loc_02322210:
	push {r4,r5,r6,r7,lr}	; 02322210
	sub sp,#0x24	; 02322212
	ldr r2,[pool_02322400]	; 02322214
	ldr r0,[r2,#0x8]	; 02322216
	cmp r0,#0x0	; 02322218
	bne loc_0232221E	; 0232221A
	b loc_023223F6	; 0232221C
loc_0232221E:
	mov r0,#0x6	; 0232221E
	ldrsh r3,[r2,r0]	; 02322220
	mov r1,#0x4	; 02322222
	ldrsh r1,[r2,r1]	; 02322224
	add r3,r3,r1	; 02322226
	strh r3,[r2,#0x6]	; 02322228
	cmp r1,#0x1	; 0232222A
	bne loc_02322238	; 0232222C
	ldrsh r0,[r2,r0]	; 0232222E
	cmp r0,#0xf	; 02322230
	bne loc_02322238	; 02322232
	mov r0,#0x0	; 02322234
	strh r0,[r2,#0x4]	; 02322236
loc_02322238:
	ldr r0,[pool_02322400]	; 02322238
	mov r1,#0x4	; 0232223A
	ldrsh r3,[r0,r1]	; 0232223C
	mov r2,#0x0	; 0232223E
	mvn r1,r2	; 02322240
	cmp r3,r1	; 02322242
	bne loc_02322272	; 02322244
	mov r1,#0x6	; 02322246
	ldrsh r1,[r0,r1]	; 02322248
	cmp r1,#0x0	; 0232224A
	bne loc_02322272	; 0232224C
	strh r2,[r0,#0x4]	; 0232224E
	ldr r1,[r0,#0x0]	; 02322250
	mov r3,#0xe	; 02322252
	mul r1,r3	; 02322254
	ldr r3,[pool_02322404]	; 02322256
	ldrh r4,[r3,r1]	; 02322258
	cmp r4,#0x1	; 0232225A
	bne loc_02322262	; 0232225C
	str r2,[r0,#0x0]	; 0232225E
	b loc_02322272	; 02322260
loc_02322262:
	mov r2,#0xf	; 02322262
	strh r2,[r0,#0x6]	; 02322264
	ldr r3,[pool_02322408]	; 02322266
	sub r2,r4,#0x2	; 02322268
	lsl r2,r2,#0x1	; 0232226A
	add r1,r3,r1	; 0232226C
	ldrh r1,[r2,r1]	; 0232226E
	str r1,[r0,#0x0]	; 02322270
loc_02322272:
	bl loc_02323E84	; 02322272
	str r0,[sp,#0xc]	; 02322276
	ldr r0,[pool_02322400]	; 02322278
	ldr r1,[r0,#0x0]	; 0232227A
	mov r0,#0xe	; 0232227C
	mul r1,r0	; 0232227E
	ldr r0,[pool_02322404]	; 02322280
	ldrh r5,[r0,r1]	; 02322282
	b loc_023223F0	; 02322284
loc_02322286:
	sub r7,r5,#0x1	; 02322286
	ldr r0,[pool_02322400]	; 02322288
	ldr r1,[r0,#0x0]	; 0232228A
	mov r0,#0xe	; 0232228C
	mul r1,r0	; 0232228E
	ldr r0,[pool_02322404]	; 02322290
	ldrh r0,[r0,r1]	; 02322292
	sub r0,r0,r5	; 02322294
	str r0,[sp,#0x10]	; 02322296
	neg r0,r0	; 02322298
	lsl r6,r0,#0x4	; 0232229A
	ldr r1,[pool_02322400]	; 0232229C
	mov r0,#0x6	; 0232229E
	ldrsh r0,[r1,r0]	; 023222A0
	lsl r0,r0,#0x6	; 023222A2
	mov r1,#0xf	; 023222A4
	blx P1_SignedDivMod	; 023222A6
	add r1,r6,#0x0	; 023222AA
	add r1,#0x40	; 023222AC
	sub r0,r1,r0	; 023222AE
	lsl r0,r0,#0x10	; 023222B0
	asr r4,r0,#0x10	; 023222B2
	ldr r0,[sp,#0x10]	; 023222B4
	cmp r0,#0x0	; 023222B6
	ble loc_023222C2	; 023222B8
	add r6,#0x10	; 023222BA
	cmp r4,r6	; 023222BC
	blt loc_023222C2	; 023222BE
	add r4,r6,#0x0	; 023222C0
loc_023222C2:
	bl loc_023235C8	; 023222C2
	sub r4,r4,r0	; 023222C6
	lsl r0,r4,#0x10	; 023222C8
	asr r6,r0,#0x10	; 023222CA
	add r1,r7,#0x0	; 023222CC
	str r1,[sp,#0x18]	; 023222CE
	mov r0,#0x2c	; 023222D0
	mul r1,r0	; 023222D2
	str r1,[sp,#0x18]	; 023222D4
	mov r0,#0x1	; 023222D6
	str r0,[sp,#0x0]	; 023222D8
	ldr r1,[pool_0232240C]	; 023222DA
	ldr r0,[sp,#0x18]	; 023222DC
	add r0,r1,r0	; 023222DE
	mov r1,#0x0	; 023222E0
	add r2,r6,#0x0	; 023222E2
	lsl r3,r1,#0	; 023222E4
	bl loc_02323780	; 023222E6
	mov r0,#0x1	; 023222EA
	str r0,[sp,#0x0]	; 023222EC
	ldr r1,[pool_02322410]	; 023222EE
	ldr r0,[sp,#0x18]	; 023222F0
	add r0,r1,r0	; 023222F2
	mov r1,#0x0	; 023222F4
	add r2,r6,#0x0	; 023222F6
	lsl r3,r1,#0	; 023222F8
	bl loc_02323780	; 023222FA
	ldr r0,[pool_02322400]	; 023222FE
	ldr r0,[r0,#0x0]	; 02322300
	mov r1,#0xe	; 02322302
	mul r0,r1	; 02322304
	lsl r2,r7,#0x1	; 02322306
	ldr r1,[pool_02322404]	; 02322308
	add r0,r1,r0	; 0232230A
	add r0,r2,r0	; 0232230C
	ldrh r3,[r0,#0x6]	; 0232230E
	cmp r3,#0x11	; 02322310
	bne loc_0232239E	; 02322312
	ldr r0,[pool_02322414]	; 02322314
	mov r1,#0x0	; 02322316
	bl loc_0232926C	; 02322318
	add r6,r0,#0x0	; 0232231C
	bl P3_Entry_0236782C	; 0232231E
	cmp r0,#0x3	; 02322322
	bhi loc_02322352	; 02322324
	add r0,r0,r0	; 02322326
P1_SwitchIndexPC_02322326:
	add r0,pc	; 02322328
	ldrh r0,[r0,#(P1_SwitchTable_02322326 - (P1_SwitchIndexPC_02322326 + 4))]	; 0232232A
	lsl r0,r0,#0x10	; 0232232C
	asr r0,r0,#0x10	; 0232232E
P1_SwitchTargetPC_02322326:
	add r0,pc	; 02322330
	bx r0	; 02322332
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02322326:
	.halfword (loc_0232233C + 1) - (P1_SwitchTargetPC_02322326 + 4)
	.halfword (loc_02322342 + 1) - (P1_SwitchTargetPC_02322326 + 4)
	.halfword (loc_02322348 + 1) - (P1_SwitchTargetPC_02322326 + 4)
	.halfword (loc_0232234E + 1) - (P1_SwitchTargetPC_02322326 + 4)
P1_SwitchTable_02322326End:
loc_0232233C:
	mov r0,#0x13	; 0232233C
	str r0,[sp,#0x14]	; 0232233E
	b loc_02322352	; 02322340
loc_02322342:
	mov r0,#0x14	; 02322342
	str r0,[sp,#0x14]	; 02322344
	b loc_02322352	; 02322346
loc_02322348:
	mov r0,#0x15	; 02322348
	str r0,[sp,#0x14]	; 0232234A
	b loc_02322352	; 0232234C
loc_0232234E:
	mov r0,#0x16	; 0232234E
	str r0,[sp,#0x14]	; 02322350
loc_02322352:
	bl loc_02323E84	; 02322352
	mov r1,#0x0	; 02322356
	str r1,[sp,#0x0]	; 02322358
	str r4,[sp,#0x4]	; 0232235A
	ldr r1,[pool_02322418]	; 0232235C
	ldr r2,[pool_0232241C]	; 0232235E
	ldr r3,[sp,#0x14]	; 02322360
	bl loc_02323C40	; 02322362
	mov r0,#0x0	; 02322366
	ldrsh r0,[r6,r0]	; 02322368
	lsl r0,r0,#0x14	; 0232236A
	asr r1,r0,#0x14	; 0232236C
	ldr r0,[pool_02322420]	; 0232236E
	and r1,r0	; 02322370
	lsl r0,r1,#0x10	; 02322372
	mov r1,#0x2	; 02322374
	ldrsh r1,[r6,r1]	; 02322376
	lsl r1,r1,#0x14	; 02322378
	asr r1,r1,#0x14	; 0232237A
	add r2,r1,r4	; 0232237C
	mov r1,#0xff	; 0232237E
	and r2,r1	; 02322380
	ldr r1,[pool_02322424]	; 02322382
	orr r2,r1	; 02322384
	orr r0,r2	; 02322386
	str r0,[sp,#0x1c]	; 02322388
	ldr r1,[pool_02322428]	; 0232238A
	add r0,sp,#0x1c	; 0232238C
	strh r1,[r0,#0x4]	; 0232238E
	bl loc_02323E84	; 02322390
	add r1,sp,#0x1c	; 02322394
	mov r2,#0x0	; 02322396
	bl loc_023239A0	; 02322398
	b loc_023223DC	; 0232239C
loc_0232239E:
	add r1,r3,#0x0	; 0232239E
	mov r0,#0xe	; 023223A0
	mul r1,r0	; 023223A2
	ldr r0,[pool_02322404]	; 023223A4
	add r1,r0,r1	; 023223A6
	mov r0,#0xc	; 023223A8
	ldrsh r0,[r1,r0]	; 023223AA
	mov r1,#0x0	; 023223AC
	mvn r1,r1	; 023223AE
	cmp r0,r1	; 023223B0
	bne loc_023223C8	; 023223B2
	mov r0,#0x0	; 023223B4
	str r0,[sp,#0x0]	; 023223B6
	str r4,[sp,#0x4]	; 023223B8
	ldr r0,[sp,#0xc]	; 023223BA
	ldr r1,[pool_02322418]	; 023223BC
	ldr r2,[pool_0232241C]	; 023223BE
	sub r3,r3,#0x1	; 023223C0
	bl loc_02323C40	; 023223C2
	b loc_023223DC	; 023223C6
loc_023223C8:
	mov r1,#0x0	; 023223C8
	str r1,[sp,#0x0]	; 023223CA
	str r4,[sp,#0x4]	; 023223CC
	str r0,[sp,#0x8]	; 023223CE
	ldr r0,[sp,#0xc]	; 023223D0
	ldr r1,[pool_02322418]	; 023223D2
	ldr r2,[pool_0232241C]	; 023223D4
	sub r3,r3,#0x1	; 023223D6
	bl loc_02323BEC	; 023223D8
loc_023223DC:
	mov r0,#0x0	; 023223DC
	str r0,[sp,#0x0]	; 023223DE
	str r4,[sp,#0x4]	; 023223E0
	ldr r0,[sp,#0xc]	; 023223E2
	ldr r1,[pool_02322418]	; 023223E4
	ldr r2,[pool_0232241C]	; 023223E6
	mov r3,#0x10	; 023223E8
	bl loc_02323C40	; 023223EA
	sub r5,r5,#0x1	; 023223EE
loc_023223F0:
	cmp r5,#0x0	; 023223F0
	ble loc_023223F6	; 023223F2
	b loc_02322286	; 023223F4
loc_023223F6:
	add sp,#0x24	; 023223F6
	pop {r4,r5,r6,r7}	; 023223F8
	pop {r3}	; 023223FA
	bx r3	; 023223FC
	.byte 0xC0, 0x46	; 02322400
pool_02322400:
loc_02322400:
	.word P1_BssStart + 0x1444	; 02322400
pool_02322404:
loc_02322404:
	.word P1_Data_02330074	; 02322404
pool_02322408:
loc_02322408:
	.word 0x0233007A	; 02322408
pool_0232240C:
loc_0232240C:
	.word 0x02331ED0	; 0232240C
pool_02322410:
loc_02322410:
	.word 0x02331F54	; 02322410
pool_02322414:
loc_02322414:
	.word 0x023A4BC8	; 02322414
pool_02322418:
loc_02322418:
	.word 0x023C1178	; 02322418
pool_0232241C:
loc_0232241C:
	.word 0x023A526C	; 0232241C
pool_02322420:
loc_02322420:
	.word 0x000001FF	; 02322420
pool_02322424:
loc_02322424:
	.word 0x80000000	; 02322424
pool_02322428:
loc_02322428:
	.word 0x0000A3DC	; 02322428

; ===== function loc_0232242C =====
P1_Entry_0232242C:
	push {r4,r5,r6,r7,lr}	; 0232242C
	sub sp,#0x4	; 0232242E
	mov r1,#0x1	; 02322430
	ldr r0,[pool_02322474]	; 02322432
	str r1,[r0,#0x8]	; 02322434
	mov r5,#0x0	; 02322436
	str r5,[r0,#0x0]	; 02322438
	strh r5,[r0,#0x4]	; 0232243A
	strh r5,[r0,#0x6]	; 0232243C
	ldr r6,[pool_02322478]	; 0232243E
	ldr r7,[pool_0232247C]	; 02322440
loc_02322442:
	add r4,r5,#0x0	; 02322442
	mov r0,#0x2c	; 02322444
	mul r4,r0	; 02322446
	bl loc_02324C88	; 02322448
	add r1,r6,r4	; 0232244C
	ldr r2,[pool_02322480]	; 0232244E
	mov r3,#0x95	; 02322450
	bl loc_02324BF8	; 02322452
	bl loc_02324C88	; 02322456
	add r1,r7,r4	; 0232245A
	ldr r2,[pool_02322480]	; 0232245C
	mov r3,#0x7f	; 0232245E
	bl loc_02324BF8	; 02322460
	add r5,r5,#0x1	; 02322464
	cmp r5,#0x3	; 02322466
	blt loc_02322442	; 02322468
	add sp,#0x4	; 0232246A
	pop {r4,r5,r6,r7}	; 0232246C
	pop {r3}	; 0232246E
	bx r3	; 02322470
	.byte 0xC0, 0x46	; 02322474
pool_02322474:
loc_02322474:
	.word P1_BssStart + 0x1444	; 02322474
pool_02322478:
loc_02322478:
	.word 0x02331ED0	; 02322478
pool_0232247C:
loc_0232247C:
	.word 0x02331F54	; 0232247C
pool_02322480:
loc_02322480:
	.word 0x023A6174	; 02322480

; ===== function loc_02322484 =====
loc_02322484:
	ldr r0,[pool_023224D4]	; 02322484
	ldr r0,[r0,#0x0]	; 02322486
	cmp r0,#0x5	; 02322488
	bhi loc_023224CE	; 0232248A
	add r0,r0,r0	; 0232248C
P1_SwitchIndexPC_0232248C:
	add r0,pc	; 0232248E
	ldrh r0,[r0,#(P1_SwitchTable_0232248C - (P1_SwitchIndexPC_0232248C + 4))]	; 02322490
	lsl r0,r0,#0x10	; 02322492
	asr r0,r0,#0x10	; 02322494
P1_SwitchTargetPC_0232248C:
	add r0,pc	; 02322496
	bx r0	; 02322498
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232248C:
	.halfword (loc_023224A6 + 1) - (P1_SwitchTargetPC_0232248C + 4)
	.halfword (loc_023224AA + 1) - (P1_SwitchTargetPC_0232248C + 4)
	.halfword (loc_023224B2 + 1) - (P1_SwitchTargetPC_0232248C + 4)
	.halfword (loc_023224BA + 1) - (P1_SwitchTargetPC_0232248C + 4)
	.halfword (loc_023224BE + 1) - (P1_SwitchTargetPC_0232248C + 4)
	.halfword (loc_023224C6 + 1) - (P1_SwitchTargetPC_0232248C + 4)
P1_SwitchTable_0232248CEnd:
loc_023224A6:
	mov r0,#0x0	; 023224A6
	bx lr	; 023224A8
loc_023224AA:
	ldr r0,[pool_023224D8]	; 023224AA
	ldr r0,[r0,#0x38]	; 023224AC
	neg r0,r0	; 023224AE
	bx lr	; 023224B0
loc_023224B2:
	ldr r0,[pool_023224D8]	; 023224B2
	ldr r0,[r0,#0x38]	; 023224B4
	sub r0,#0x10	; 023224B6
	bx lr	; 023224B8
loc_023224BA:
	mov r0,#0x0	; 023224BA
	bx lr	; 023224BC
loc_023224BE:
	ldr r0,[pool_023224D8]	; 023224BE
	ldr r0,[r0,#0x38]	; 023224C0
	neg r0,r0	; 023224C2
	bx lr	; 023224C4
loc_023224C6:
	ldr r0,[pool_023224D8]	; 023224C6
	ldr r0,[r0,#0x38]	; 023224C8
	sub r0,#0x10	; 023224CA
	bx lr	; 023224CC
loc_023224CE:
	mov r0,#0x0	; 023224CE
	bx lr	; 023224D0
	.byte 0xC0, 0x46	; 023224D4
pool_023224D4:
loc_023224D4:
	.word P1_BssStart + 0x1388	; 023224D4
pool_023224D8:
loc_023224D8:
	.word P1_BssStart + 0x1408	; 023224D8

; ===== function loc_023224DC =====
loc_023224DC:
	ldr r0,[pool_0232250C]	; 023224DC
	ldr r0,[r0,#0x0]	; 023224DE
	cmp r0,#0x5	; 023224E0
	bhi loc_02322506	; 023224E2
	add r0,r0,r0	; 023224E4
P1_SwitchIndexPC_023224E4:
	add r0,pc	; 023224E6
	ldrh r0,[r0,#(P1_SwitchTable_023224E4 - (P1_SwitchIndexPC_023224E4 + 4))]	; 023224E8
	lsl r0,r0,#0x10	; 023224EA
	asr r0,r0,#0x10	; 023224EC
P1_SwitchTargetPC_023224E4:
	add r0,pc	; 023224EE
	bx r0	; 023224F0
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023224E4:
	.halfword (loc_02322502 + 1) - (P1_SwitchTargetPC_023224E4 + 4)
	.halfword (loc_02322502 + 1) - (P1_SwitchTargetPC_023224E4 + 4)
	.halfword (loc_023224FE + 1) - (P1_SwitchTargetPC_023224E4 + 4)
	.halfword (loc_023224FE + 1) - (P1_SwitchTargetPC_023224E4 + 4)
	.halfword (loc_023224FE + 1) - (P1_SwitchTargetPC_023224E4 + 4)
	.halfword (loc_02322502 + 1) - (P1_SwitchTargetPC_023224E4 + 4)
P1_SwitchTable_023224E4End:
loc_023224FE:
	mov r0,#0x1	; 023224FE
	bx lr	; 02322500
loc_02322502:
	mov r0,#0x0	; 02322502
	bx lr	; 02322504
loc_02322506:
	mov r0,#0x0	; 02322506
	bx lr	; 02322508
	.byte 0xC0, 0x46	; 0232250C
pool_0232250C:
loc_0232250C:
	.word P1_BssStart + 0x1388	; 0232250C

; ===== function loc_02322510 =====
loc_02322510:
	push {lr}	; 02322510
	sub sp,#0x4	; 02322512
	ldr r0,[r0,#0x0]	; 02322514
	cmp r0,#0x5	; 02322516
	bhi loc_02322556	; 02322518
	add r0,r0,r0	; 0232251A
P1_SwitchIndexPC_0232251A:
	add r0,pc	; 0232251C
	ldrh r0,[r0,#(P1_SwitchTable_0232251A - (P1_SwitchIndexPC_0232251A + 4))]	; 0232251E
	lsl r0,r0,#0x10	; 02322520
	asr r0,r0,#0x10	; 02322522
P1_SwitchTargetPC_0232251A:
	add r0,pc	; 02322524
	bx r0	; 02322526
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232251A:
	.halfword (loc_02322544 + 1) - (P1_SwitchTargetPC_0232251A + 4)
	.halfword (loc_02322544 + 1) - (P1_SwitchTargetPC_0232251A + 4)
	.halfword (loc_02322534 + 1) - (P1_SwitchTargetPC_0232251A + 4)
	.halfword (loc_02322534 + 1) - (P1_SwitchTargetPC_0232251A + 4)
	.halfword (loc_02322534 + 1) - (P1_SwitchTargetPC_0232251A + 4)
	.halfword (loc_02322544 + 1) - (P1_SwitchTargetPC_0232251A + 4)
P1_SwitchTable_0232251AEnd:
loc_02322534:
	ldr r1,[pool_02322574]	; 02322534
	ldr r2,[r1,#0x0]	; 02322536
	ldr r0,[pool_02322578]	; 02322538
	and r2,r0	; 0232253A
	ldr r0,[pool_0232257C]	; 0232253C
	orr r2,r0	; 0232253E
	str r2,[r1,#0x0]	; 02322540
	b loc_02322556	; 02322542
loc_02322544:
	ldr r1,[pool_02322574]	; 02322544
	ldr r2,[r1,#0x0]	; 02322546
	ldr r0,[pool_02322578]	; 02322548
	and r2,r0	; 0232254A
	ldr r0,[pool_02322580]	; 0232254C
	ldr r0,[r0,#0x0]	; 0232254E
	lsl r0,r0,#0x8	; 02322550
	orr r2,r0	; 02322552
	str r2,[r1,#0x0]	; 02322554
loc_02322556:
	ldr r0,[pool_02322584]	; 02322556
	ldr r0,[r0,#0x0]	; 02322558
	cmp r0,#0x10	; 0232255A
	bne loc_0232256C	; 0232255C
	bl loc_02322484	; 0232255E
	add r2,r0,#0x0	; 02322562
	ldr r0,[pool_02322588]	; 02322564
	mov r1,#0x1f	; 02322566
	bl loc_0232D94C	; 02322568
loc_0232256C:
	add sp,#0x4	; 0232256C
	pop {r3}	; 0232256E
	bx r3	; 02322570
	.byte 0xC0, 0x46	; 02322574
pool_02322574:
loc_02322574:
	.word REG_DISPCNT_A	; 02322574
pool_02322578:
loc_02322578:
	.word 0xFFFFE0FF	; 02322578
pool_0232257C:
loc_0232257C:
	.word 0x00001000	; 0232257C
pool_02322580:
loc_02322580:
	.word P1_BssStart + 0x1370	; 02322580
pool_02322584:
loc_02322584:
	.word P1_BssStart + 0x1374	; 02322584
pool_02322588:
loc_02322588:
	.word REG_BLDCNT	; 02322588

; ===== function loc_0232258C =====
loc_0232258C:
	push {r4,r5,r6,r7,lr}	; 0232258C
	sub sp,#0x44	; 0232258E
	add r5,r0,#0x0	; 02322590
	add r0,#0xb8	; 02322592
	ldr r0,[r0,#0x0]	; 02322594
	cmp r0,#0x10	; 02322596
	bge loc_023225D2	; 02322598
	ldr r0,[r5,#0x0]	; 0232259A
	cmp r0,#0x0	; 0232259C
	beq loc_023225B2	; 0232259E
	cmp r0,#0x3	; 023225A0
	beq loc_023225B2	; 023225A2
	add r0,r5,#0x0	; 023225A4
	add r0,#0xb8	; 023225A6
	ldr r0,[r0,#0x0]	; 023225A8
	add r1,r0,#0x1	; 023225AA
	add r0,r5,#0x0	; 023225AC
	add r0,#0xb8	; 023225AE
	str r1,[r0,#0x0]	; 023225B0
loc_023225B2:
	add r0,r5,#0x0	; 023225B2
	add r0,#0xb8	; 023225B4
	ldr r0,[r0,#0x0]	; 023225B6
	cmp r0,#0x10	; 023225B8
	bne loc_023225D2	; 023225BA
	mov r1,#0x0	; 023225BC
	add r0,r5,#0x0	; 023225BE
	add r0,#0xb8	; 023225C0
	str r1,[r0,#0x0]	; 023225C2
	ldr r0,[r5,#0x0]	; 023225C4
	add r0,r0,#0x1	; 023225C6
	str r0,[r5,#0x0]	; 023225C8
	ldr r0,[r5,#0x0]	; 023225CA
	cmp r0,#0x6	; 023225CC
	bne loc_023225D2	; 023225CE
	str r1,[r5,#0x0]	; 023225D0
loc_023225D2:
	bl loc_023224DC	; 023225D2
	cmp r0,#0x0	; 023225D6
	bne loc_023225DC	; 023225D8
	b loc_023227C8	; 023225DA
loc_023225DC:
	add r0,sp,#0x30	; 023225DC
	ldr r1,[r5,#0x4]	; 023225DE
	bl loc_023227E0	; 023225E0
	add r0,r5,#0x0	; 023225E4
	add r0,#0x8c	; 023225E6
	add r1,sp,#0x30	; 023225E8
	bl loc_02324B44	; 023225EA
	ldr r0,[r5,#0x4]	; 023225EE
	cmp r0,#0x0	; 023225F0
	bne loc_02322606	; 023225F2
	mov r0,#0x9c	; 023225F4
	bl loc_02324DE0	; 023225F6
	add r1,r0,#0x0	; 023225FA
	add r0,r5,#0x0	; 023225FC
	add r0,#0x60	; 023225FE
	bl loc_02324B44	; 02322600
	b loc_02322616	; 02322604
loc_02322606:
	mov r0,#0x9d	; 02322606
	bl loc_02324DE0	; 02322608
	add r1,r0,#0x0	; 0232260C
	add r0,r5,#0x0	; 0232260E
	add r0,#0x60	; 02322610
	bl loc_02324B44	; 02322612
loc_02322616:
	add r0,sp,#0x24	; 02322616
	bl loc_02326A80	; 02322618
	ldr r4,[sp,#0x24]	; 0232261C
	add r0,r4,#0x0	; 0232261E
	mov r1,#0xa	; 02322620
	blx P1_UnsignedDivMod	; 02322622
	str r0,[sp,#0x10]	; 02322626
	add r0,r4,#0x0	; 02322628
	mov r1,#0xa	; 0232262A
	blx P1_UnsignedDivMod	; 0232262C
	add r7,r1,#0x0	; 02322630
	ldr r4,[sp,#0x28]	; 02322632
	add r0,r4,#0x0	; 02322634
	mov r1,#0xa	; 02322636
	blx P1_UnsignedDivMod	; 02322638
	str r0,[sp,#0x14]	; 0232263C
	add r0,r4,#0x0	; 0232263E
	mov r1,#0xa	; 02322640
	blx P1_UnsignedDivMod	; 02322642
	str r1,[sp,#0xc]	; 02322646
	ldr r0,[pool_023227D0]	; 02322648
	ldrb r4,[r0,#0x0]	; 0232264A
	add r0,r4,#0x0	; 0232264C
	mov r1,#0xa	; 0232264E
	blx P1_SignedDivMod	; 02322650
	str r0,[sp,#0x18]	; 02322654
	add r0,r4,#0x0	; 02322656
	mov r1,#0xa	; 02322658
	blx P1_SignedDivMod	; 0232265A
	str r1,[sp,#0x8]	; 0232265E
	ldr r0,[pool_023227D0]	; 02322660
	ldrb r4,[r0,#0x1]	; 02322662
	add r0,r4,#0x0	; 02322664
	mov r1,#0xa	; 02322666
	blx P1_SignedDivMod	; 02322668
	str r0,[sp,#0x1c]	; 0232266C
	add r0,r4,#0x0	; 0232266E
	mov r1,#0xa	; 02322670
	blx P1_SignedDivMod	; 02322672
	add r6,r1,#0x0	; 02322676
	mov r4,#0x0	; 02322678
	str r4,[sp,#0x20]	; 0232267A
loc_0232267C:
	mov r0,#0x1	; 0232267C
	str r0,[sp,#0x0]	; 0232267E
	add r2,r5,#0x0	; 02322680
	add r2,#0x8	; 02322682
	add r1,r4,#0x0	; 02322684
	mov r0,#0x2c	; 02322686
	mul r1,r0	; 02322688
	add r0,r2,r1	; 0232268A
	ldr r1,[sp,#0x20]	; 0232268C
	lsl r2,r1,#0	; 0232268E
	lsl r3,r1,#0	; 02322690
	bl loc_02323780	; 02322692
	add r4,r4,#0x1	; 02322696
	cmp r4,#0x2	; 02322698
	blt loc_0232267C	; 0232269A
	mov r0,#0x1	; 0232269C
	str r0,[sp,#0x0]	; 0232269E
	add r0,r5,#0x0	; 023226A0
	add r0,#0x60	; 023226A2
	mov r1,#0x0	; 023226A4
	add r2,r1,#0x0	; 023226A6
	add r3,r1,#0x0	; 023226A8
	bl loc_02323780	; 023226AA
	mov r0,#0x1	; 023226AE
	str r0,[sp,#0x0]	; 023226B0
	add r5,#0x8c	; 023226B2
	add r0,r5,#0x0	; 023226B4
	mov r1,#0x0	; 023226B6
	add r2,r1,#0x0	; 023226B8
	add r3,r1,#0x0	; 023226BA
	bl loc_02323780	; 023226BC
	bl loc_02323E84	; 023226C0
	mov r1,#0x3e	; 023226C4
	str r1,[sp,#0x0]	; 023226C6
	mov r1,#0x20	; 023226C8
	str r1,[sp,#0x4]	; 023226CA
	ldr r1,[pool_023227D4]	; 023226CC
	ldr r2,[pool_023227D8]	; 023226CE
	ldr r3,[sp,#0x10]	; 023226D0
	lsl r4,r3,#0x2	; 023226D2
	ldr r3,[pool_023227DC]	; 023226D4
	ldr r3,[r3,r4]	; 023226D6
	bl loc_02323C40	; 023226D8
	bl loc_02323E84	; 023226DC
	mov r1,#0x5d	; 023226E0
	str r1,[sp,#0x0]	; 023226E2
	mov r1,#0x20	; 023226E4
	str r1,[sp,#0x4]	; 023226E6
	ldr r1,[pool_023227D4]	; 023226E8
	ldr r2,[pool_023227D8]	; 023226EA
	lsl r4,r7,#0x2	; 023226EC
	ldr r3,[pool_023227DC]	; 023226EE
	ldr r3,[r3,r4]	; 023226F0
	bl loc_02323C40	; 023226F2
	bl loc_02323E84	; 023226F6
	mov r1,#0x74	; 023226FA
	str r1,[sp,#0x0]	; 023226FC
	mov r1,#0x20	; 023226FE
	str r1,[sp,#0x4]	; 02322700
	ldr r1,[pool_023227D4]	; 02322702
	ldr r2,[pool_023227D8]	; 02322704
	mov r3,#0x0	; 02322706
	bl loc_02323C40	; 02322708
	bl loc_02323E84	; 0232270C
	mov r1,#0x8b	; 02322710
	str r1,[sp,#0x0]	; 02322712
	mov r1,#0x20	; 02322714
	str r1,[sp,#0x4]	; 02322716
	ldr r1,[pool_023227D4]	; 02322718
	ldr r2,[pool_023227D8]	; 0232271A
	ldr r3,[sp,#0x14]	; 0232271C
	lsl r4,r3,#0x2	; 0232271E
	ldr r3,[pool_023227DC]	; 02322720
	ldr r3,[r3,r4]	; 02322722
	bl loc_02323C40	; 02322724
	bl loc_02323E84	; 02322728
	mov r1,#0xaa	; 0232272C
	str r1,[sp,#0x0]	; 0232272E
	mov r1,#0x20	; 02322730
	str r1,[sp,#0x4]	; 02322732
	ldr r1,[pool_023227D4]	; 02322734
	ldr r2,[pool_023227D8]	; 02322736
	ldr r3,[sp,#0xc]	; 02322738
	lsl r4,r3,#0x2	; 0232273A
	ldr r3,[pool_023227DC]	; 0232273C
	ldr r3,[r3,r4]	; 0232273E
	bl loc_02323C40	; 02322740
	bl loc_02323E84	; 02322744
	mov r1,#0x3e	; 02322748
	str r1,[sp,#0x0]	; 0232274A
	mov r1,#0x6e	; 0232274C
	str r1,[sp,#0x4]	; 0232274E
	ldr r1,[pool_023227D4]	; 02322750
	ldr r2,[pool_023227D8]	; 02322752
	ldr r3,[sp,#0x18]	; 02322754
	lsl r4,r3,#0x2	; 02322756
	ldr r3,[pool_023227DC]	; 02322758
	ldr r3,[r3,r4]	; 0232275A
	bl loc_02323C40	; 0232275C
	bl loc_02323E84	; 02322760
	mov r1,#0x5d	; 02322764
	str r1,[sp,#0x0]	; 02322766
	mov r1,#0x6e	; 02322768
	str r1,[sp,#0x4]	; 0232276A
	ldr r1,[pool_023227D4]	; 0232276C
	ldr r2,[pool_023227D8]	; 0232276E
	ldr r3,[sp,#0x8]	; 02322770
	lsl r4,r3,#0x2	; 02322772
	ldr r3,[pool_023227DC]	; 02322774
	ldr r3,[r3,r4]	; 02322776
	bl loc_02323C40	; 02322778
	bl loc_02323E84	; 0232277C
	mov r1,#0x74	; 02322780
	str r1,[sp,#0x0]	; 02322782
	mov r1,#0x6e	; 02322784
	str r1,[sp,#0x4]	; 02322786
	ldr r1,[pool_023227D4]	; 02322788
	ldr r2,[pool_023227D8]	; 0232278A
	mov r3,#0x0	; 0232278C
	bl loc_02323C40	; 0232278E
	bl loc_02323E84	; 02322792
	mov r1,#0x8b	; 02322796
	str r1,[sp,#0x0]	; 02322798
	mov r1,#0x6e	; 0232279A
	str r1,[sp,#0x4]	; 0232279C
	ldr r1,[pool_023227D4]	; 0232279E
	ldr r2,[pool_023227D8]	; 023227A0
	ldr r3,[sp,#0x1c]	; 023227A2
	lsl r4,r3,#0x2	; 023227A4
	ldr r3,[pool_023227DC]	; 023227A6
	ldr r3,[r3,r4]	; 023227A8
	bl loc_02323C40	; 023227AA
	bl loc_02323E84	; 023227AE
	mov r1,#0xaa	; 023227B2
	str r1,[sp,#0x0]	; 023227B4
	mov r1,#0x6e	; 023227B6
	str r1,[sp,#0x4]	; 023227B8
	ldr r1,[pool_023227D4]	; 023227BA
	ldr r2,[pool_023227D8]	; 023227BC
	lsl r4,r6,#0x2	; 023227BE
	ldr r3,[pool_023227DC]	; 023227C0
	ldr r3,[r3,r4]	; 023227C2
	bl loc_02323C40	; 023227C4
loc_023227C8:
	add sp,#0x44	; 023227C8
	pop {r4,r5,r6,r7}	; 023227CA
	pop {r3}	; 023227CC
	bx r3	; 023227CE
pool_023227D0:
loc_023227D0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsAlarmHourOffset	; 023227D0
pool_023227D4:
loc_023227D4:
	.word 0x023C1178	; 023227D4
pool_023227D8:
loc_023227D8:
	.word 0x023A5884	; 023227D8
pool_023227DC:
loc_023227DC:
	.word P1_Data_0233004C	; 023227DC

; ===== function loc_023227E0 =====
loc_023227E0:
	push {r4,r5,r6,r7,lr}	; 023227E0
	sub sp,#0xc	; 023227E2
	add r5,r0,#0x0	; 023227E4
	add r4,r1,#0x0	; 023227E6
	add r0,sp,#0x0	; 023227E8
	bl loc_02326A80	; 023227EA
	ldr r3,[sp,#0x8]	; 023227EE
	ldr r2,[sp,#0x4]	; 023227F0
	ldr r0,[sp,#0x0]	; 023227F2
	mov r1,#0x3c	; 023227F4
	mul r0,r1	; 023227F6
	add r0,r2,r0	; 023227F8
	mul r0,r1	; 023227FA
	add r0,r3,r0	; 023227FC
	ldr r2,[pool_02322878]	; 023227FE
	ldrb r3,[r2,#0x1]	; 02322800
	ldrb r2,[r2,#0x0]	; 02322802
	mul r2,r1	; 02322804
	add r2,r3,r2	; 02322806
	mul r2,r1	; 02322808
	cmp r4,#0x0	; 0232280A
	bne loc_0232281E	; 0232280C
	cmp r0,r2	; 0232280E
	bhi loc_02322816	; 02322810
	sub r4,r2,r0	; 02322812
	b loc_0232282C	; 02322814
loc_02322816:
	sub r1,r0,r2	; 02322816
	ldr r0,[pool_0232287C]	; 02322818
	sub r4,r0,r1	; 0232281A
	b loc_0232282C	; 0232281C
loc_0232281E:
	cmp r2,r0	; 0232281E
	bhi loc_02322826	; 02322820
	sub r4,r0,r2	; 02322822
	b loc_0232282C	; 02322824
loc_02322826:
	sub r1,r2,r0	; 02322826
	ldr r0,[pool_0232287C]	; 02322828
	sub r4,r0,r1	; 0232282A
loc_0232282C:
	add r0,r4,#0x0	; 0232282C
	ldr r1,[pool_02322880]	; 0232282E
	blx P1_UnsignedDivMod	; 02322830
	add r6,r0,#0x0	; 02322834
	ldr r0,[pool_02322880]	; 02322836
	add r1,r6,#0x0	; 02322838
	mul r1,r0	; 0232283A
	sub r4,r4,r1	; 0232283C
	add r0,r4,#0x0	; 0232283E
	mov r1,#0x3c	; 02322840
	blx P1_UnsignedDivMod	; 02322842
	add r7,r0,#0x0	; 02322846
	mov r0,#0x3c	; 02322848
	add r1,r7,#0x0	; 0232284A
	mul r1,r0	; 0232284C
	sub r4,r4,r1	; 0232284E
	add r0,r5,#0x0	; 02322850
	add r1,r6,#0x0	; 02322852
	bl loc_02325A64	; 02322854
	mov r1,#0x3a	; 02322858
	strh r1,[r0,#0x0]	; 0232285A
	add r0,r0,#0x2	; 0232285C
	add r1,r7,#0x0	; 0232285E
	bl loc_02325A64	; 02322860
	mov r1,#0x3a	; 02322864
	strh r1,[r0,#0x0]	; 02322866
	add r0,r0,#0x2	; 02322868
	add r1,r4,#0x0	; 0232286A
	bl loc_02325A64	; 0232286C
	add sp,#0xc	; 02322870
	pop {r4,r5,r6,r7}	; 02322872
	pop {r3}	; 02322874
	bx r3	; 02322876
pool_02322878:
loc_02322878:
	.word FirmwareUserSettingsSharedAddress + UserSettingsAlarmHourOffset	; 02322878
pool_0232287C:
loc_0232287C:
	.word 0x00015180	; 0232287C
pool_02322880:
loc_02322880:
	.word 0x00000E10	; 02322880

; ===== function loc_02322884 =====
loc_02322884:
	push {r4,r5,lr}	; 02322884
	sub sp,#0x4	; 02322886
	add r5,r0,#0x0	; 02322888
	bl loc_02324C88	; 0232288A
	add r4,r0,#0x0	; 0232288E
	mov r1,#0x0	; 02322890
	str r1,[r5,#0x0]	; 02322892
	str r1,[r5,#0x4]	; 02322894
	add r1,r5,#0x0	; 02322896
	add r1,#0x8	; 02322898
	ldr r2,[pool_023228F8]	; 0232289A
	mov r3,#0x9e	; 0232289C
	bl loc_02324BF8	; 0232289E
	add r0,r5,#0x0	; 023228A2
	add r0,#0x8	; 023228A4
	ldr r1,[pool_023228F8]	; 023228A6
	mov r2,#0x9a	; 023228A8
	bl loc_02324BA0	; 023228AA
	add r0,r4,#0x0	; 023228AE
	add r1,r5,#0x0	; 023228B0
	add r1,#0x34	; 023228B2
	ldr r2,[pool_023228F8]	; 023228B4
	mov r3,#0x9e	; 023228B6
	bl loc_02324BF8	; 023228B8
	add r0,r5,#0x0	; 023228BC
	add r0,#0x34	; 023228BE
	ldr r1,[pool_023228F8]	; 023228C0
	mov r2,#0x9f	; 023228C2
	bl loc_02324BA0	; 023228C4
	add r0,r4,#0x0	; 023228C8
	add r1,r5,#0x0	; 023228CA
	add r1,#0x60	; 023228CC
	ldr r2,[pool_023228F8]	; 023228CE
	mov r3,#0x9e	; 023228D0
	bl loc_02324BF8	; 023228D2
	add r0,r4,#0x0	; 023228D6
	add r1,r5,#0x0	; 023228D8
	add r1,#0x8c	; 023228DA
	ldr r2,[pool_023228F8]	; 023228DC
	mov r3,#0x9e	; 023228DE
	bl loc_02324BF8	; 023228E0
	add r5,#0x8c	; 023228E4
	add r0,r5,#0x0	; 023228E6
	ldr r1,[pool_023228F8]	; 023228E8
	mov r2,#0x9b	; 023228EA
	bl loc_02324BA0	; 023228EC
	add sp,#0x4	; 023228F0
	pop {r4,r5}	; 023228F2
	pop {r3}	; 023228F4
	bx r3	; 023228F6
pool_023228F8:
loc_023228F8:
	.word 0x023A64B8	; 023228F8

; ===== function loc_023228FC =====
loc_023228FC:
	ldr r1,[pool_02322904]	; 023228FC
	str r0,[r1,#0x4]	; 023228FE
	bx lr	; 02322900
	.byte 0xC0, 0x46	; 02322904
pool_02322904:
loc_02322904:
	.word P1_BssStart + 0x1388	; 02322904

; ===== function loc_02322908 =====
loc_02322908:
	push {lr}	; 02322908
	sub sp,#0x4	; 0232290A
	ldr r0,[pool_02322950]	; 0232290C
	ldr r0,[r0,#0x0]	; 0232290E
	cmp r0,#0x0	; 02322910
	beq loc_0232294A	; 02322912
	bl loc_02321E88	; 02322914
	neg r0,r0	; 02322918
	lsl r1,r0,#0x10	; 0232291A
	ldr r0,[pool_02322954]	; 0232291C
	and r1,r0	; 0232291E
	ldr r0,[pool_02322958]	; 02322920
	str r1,[r0,#0x0]	; 02322922
	bl loc_02321E88	; 02322924
	neg r0,r0	; 02322928
	lsl r1,r0,#0x10	; 0232292A
	ldr r0,[pool_02322954]	; 0232292C
	and r1,r0	; 0232292E
	ldr r0,[pool_0232295C]	; 02322930
	str r1,[r0,#0x0]	; 02322932
	bl loc_02321E88	; 02322934
	neg r0,r0	; 02322938
	lsl r1,r0,#0x10	; 0232293A
	ldr r0,[pool_02322954]	; 0232293C
	and r1,r0	; 0232293E
	ldr r0,[pool_02322960]	; 02322940
	str r1,[r0,#0x0]	; 02322942
	ldr r0,[pool_02322964]	; 02322944
	bl loc_02322510	; 02322946
loc_0232294A:
	add sp,#0x4	; 0232294A
	pop {r3}	; 0232294C
	bx r3	; 0232294E
pool_02322950:
loc_02322950:
	.word P1_BssStart + 0x137C	; 02322950
pool_02322954:
loc_02322954:
	.word 0x01FF0000	; 02322954
pool_02322958:
loc_02322958:
	.word REG_BG1HOFS	; 02322958
pool_0232295C:
loc_0232295C:
	.word REG_BG2HOFS	; 0232295C
pool_02322960:
loc_02322960:
	.word REG_BG3HOFS	; 02322960
pool_02322964:
loc_02322964:
	.word 0x02331E08	; 02322964

; ===== function loc_02322968 =====
P1_Entry_02322968:
	push {lr}	; 02322968
	sub sp,#0x4	; 0232296A
	ldr r0,[pool_02322984]	; 0232296C
	ldr r0,[r0,#0x0]	; 0232296E
	cmp r0,#0x0	; 02322970
	beq loc_0232297C	; 02322972
	bl loc_023230DC	; 02322974
	bl loc_023221AC	; 02322978
loc_0232297C:
	add sp,#0x4	; 0232297C
	pop {r3}	; 0232297E
	bx r3	; 02322980
	.byte 0xC0, 0x46	; 02322984
pool_02322984:
loc_02322984:
	.word P1_BssStart + 0x137C	; 02322984

; ===== function loc_02322988 =====
loc_02322988:
	push {lr}	; 02322988
	sub sp,#0x4	; 0232298A
	ldr r0,[pool_023229F0]	; 0232298C
	ldr r0,[r0,#0x0]	; 0232298E
	cmp r0,#0x0	; 02322990
	beq loc_023229EA	; 02322992
	ldr r0,[pool_023229F4]	; 02322994
	ldr r1,[r0,#0x0]	; 02322996
	cmp r1,#0x10	; 02322998
	bge loc_023229C8	; 0232299A
	add r1,r1,#0x1	; 0232299C
	str r1,[r0,#0x0]	; 0232299E
	lsl r0,r1,#0x4	; 023229A0
	mov r1,#0x10	; 023229A2
	blx P1_SignedDivMod	; 023229A4
	add r3,r0,#0x0	; 023229A8
	ldr r0,[pool_023229F8]	; 023229AA
	mov r1,#0x1f	; 023229AC
	mov r2,#0x10	; 023229AE
	sub r2,r2,r3	; 023229B0
	bl loc_0232D94C	; 023229B2
	ldr r0,[pool_023229F4]	; 023229B6
	ldr r0,[r0,#0x0]	; 023229B8
	cmp r0,#0x10	; 023229BA
	bne loc_023229C8	; 023229BC
	mov r1,#0x0	; 023229BE
	ldr r0,[pool_023229F8]	; 023229C0
	strh r1,[r0,#0x0]	; 023229C2
	bl loc_02323360	; 023229C4
loc_023229C8:
	ldr r0,[pool_023229FC]	; 023229C8
	bl loc_0232258C	; 023229CA
	bl loc_023224DC	; 023229CE
	cmp r0,#0x0	; 023229D2
	bne loc_023229EA	; 023229D4
	bl loc_0232333C	; 023229D6
	bl loc_02323430	; 023229DA
	bl loc_02322210	; 023229DE
	bl loc_023230CC	; 023229E2
	bl loc_02322A84	; 023229E6
loc_023229EA:
	add sp,#0x4	; 023229EA
	pop {r3}	; 023229EC
	bx r3	; 023229EE
pool_023229F0:
loc_023229F0:
	.word P1_BssStart + 0x137C	; 023229F0
pool_023229F4:
loc_023229F4:
	.word P1_BssStart + 0x1374	; 023229F4
pool_023229F8:
loc_023229F8:
	.word REG_BLDCNT	; 023229F8
pool_023229FC:
loc_023229FC:
	.word 0x02331E08	; 023229FC

; ===== function loc_02322A00 =====
loc_02322A00:
	ldr r0,[pool_02322A08]	; 02322A00
	ldr r0,[r0,#0x0]	; 02322A02
	bx lr	; 02322A04
	.byte 0xC0, 0x46	; 02322A08
pool_02322A08:
loc_02322A08:
	.word P1_BssStart + 0x1444	; 02322A08

; ===== function loc_02322A0C =====
loc_02322A0C:
	ldr r3,[pool_02322A10]	; 02322A0C
	bx r3	; 02322A0E
pool_02322A10:
loc_02322A10:
	.word loc_02322134 + 1	; 02322A10

; ===== function loc_02322A14 =====
loc_02322A14:
	push {lr}	; 02322A14
	sub sp,#0x4	; 02322A16
	cmp r0,#0x0	; 02322A18
	beq loc_02322A20	; 02322A1A
	mov r2,#0x1	; 02322A1C
	b loc_02322A22	; 02322A1E
loc_02322A20:
	mov r2,#0x4	; 02322A20
loc_02322A22:
	ldr r1,[pool_02322A48]	; 02322A22
	str r2,[r1,#0x0]	; 02322A24
	cmp r0,#0x0	; 02322A26
	beq loc_02322A42	; 02322A28
	mov r0,#0x0	; 02322A2A
	str r0,[r1,#0x4]	; 02322A2C
	ldr r0,[pool_02322A4C]	; 02322A2E
	ldr r1,[pool_02322A50]	; 02322A30
	mov r2,#0x9a	; 02322A32
	bl loc_02324BA0	; 02322A34
	ldr r0,[pool_02322A54]	; 02322A38
	ldr r1,[pool_02322A50]	; 02322A3A
	mov r2,#0x9f	; 02322A3C
	bl loc_02324BA0	; 02322A3E
loc_02322A42:
	add sp,#0x4	; 02322A42
	pop {r3}	; 02322A44
	bx r3	; 02322A46
pool_02322A48:
loc_02322A48:
	.word P1_BssStart + 0x1388	; 02322A48
pool_02322A4C:
loc_02322A4C:
	.word 0x02331E10	; 02322A4C
pool_02322A50:
loc_02322A50:
	.word 0x023A64B8	; 02322A50
pool_02322A54:
loc_02322A54:
	.word 0x02331E3C	; 02322A54
P1_Entry_02322A58:
	ldr r3,[pool_02322A5C]	; 02322A58
	bx r3	; 02322A5A
pool_02322A5C:
	.word P1_Entry_0232242C + 1	; 02322A5C

; ===== function loc_02322A60 =====
loc_02322A60:
	push {lr}	; 02322A60
	sub sp,#0x4	; 02322A62
	ldr r0,[pool_02322A7C]	; 02322A64
	mov r1,#0x0	; 02322A66
	ldr r2,[pool_02322A80]	; 02322A68
	sub r2,r2,r0	; 02322A6A
	bl loc_0232DCD0	; 02322A6C
	bl loc_02321E40	; 02322A70
	add sp,#0x4	; 02322A74
	pop {r3}	; 02322A76
	bx r3	; 02322A78
	.byte 0xC0, 0x46	; 02322A7C
pool_02322A7C:
loc_02322A7C:
	.word 0x023BC7C0	; 02322A7C
pool_02322A80:
loc_02322A80:
	.word 0x023BC9C0	; 02322A80

; ===== function loc_02322A84 =====
loc_02322A84:
	push {r4,r5,lr}	; 02322A84
	sub sp,#0x4c	; 02322A86
	add r0,sp,#0x40	; 02322A88
	bl loc_02326A80	; 02322A8A
	ldr r0,[sp,#0x44]	; 02322A8E
	cmp r0,#0x0	; 02322A90
	bne loc_02322AA4	; 02322A92
	ldr r0,[pool_02322C80]	; 02322A94
	ldr r0,[r0,#0x4]	; 02322A96
	cmp r0,#0x0	; 02322A98
	beq loc_02322AA4	; 02322A9A
	mov r0,#0x2b	; 02322A9C
	bl loc_02323724	; 02322A9E
	b loc_02322AC8	; 02322AA2
loc_02322AA4:
	ldr r1,[sp,#0x48]	; 02322AA4
	cmp r1,#0x0	; 02322AA6
	bne loc_02322ABA	; 02322AA8
	ldr r0,[pool_02322C80]	; 02322AAA
	ldr r0,[r0,#0x8]	; 02322AAC
	cmp r0,#0x0	; 02322AAE
	beq loc_02322ABA	; 02322AB0
	mov r0,#0x29	; 02322AB2
	bl loc_02323724	; 02322AB4
	b loc_02322AC8	; 02322AB8
loc_02322ABA:
	ldr r0,[pool_02322C80]	; 02322ABA
	ldr r0,[r0,#0x8]	; 02322ABC
	cmp r1,r0	; 02322ABE
	beq loc_02322AC8	; 02322AC0
	mov r0,#0x2a	; 02322AC2
	bl loc_02323724	; 02322AC4
loc_02322AC8:
	add r3,sp,#0x40	; 02322AC8
	ldr r2,[pool_02322C80]	; 02322ACA
	ldmia r3!,{r0,r1}	; 02322ACC
	stmia r2!,{r0,r1}	; 02322ACE
	ldr r0,[r3,#0x0]	; 02322AD0
	str r0,[r2,#0x0]	; 02322AD2
	ldr r0,[sp,#0x44]	; 02322AD4
	mov r1,#0xc	; 02322AD6
	blx P1_UnsignedDivMod	; 02322AD8
	add r4,r0,#0x0	; 02322ADC
	ldr r0,[sp,#0x40]	; 02322ADE
	mov r1,#0xc	; 02322AE0
	blx P1_UnsignedDivMod	; 02322AE2
	mov r0,#0x5	; 02322AE6
	mul r1,r0	; 02322AE8
	add r5,r4,r1	; 02322AEA
	bl loc_02323E84	; 02322AEC
	add r4,r0,#0x0	; 02322AF0
	bl loc_02321E88	; 02322AF2
	mov r1,#0x0	; 02322AF6
	str r1,[sp,#0x0]	; 02322AF8
	str r0,[sp,#0x4]	; 02322AFA
	add r0,r4,#0x0	; 02322AFC
	ldr r1,[pool_02322C84]	; 02322AFE
	ldr r2,[pool_02322C88]	; 02322B00
	mov r3,#0xd	; 02322B02
	bl loc_02323C40	; 02322B04
	ldr r0,[pool_02322C8C]	; 02322B08
	bl loc_0232D3C4	; 02322B0A
	add r4,r0,#0x0	; 02322B0E
	ldr r0,[pool_02322C90]	; 02322B10
	bl loc_0232D3C4	; 02322B12
	add r1,r0,#0x0	; 02322B16
	add r0,sp,#0x20	; 02322B18
	add r2,r4,#0x0	; 02322B1A
	bl loc_0232D218	; 02322B1C
	ldr r0,[sp,#0x48]	; 02322B20
	lsl r3,r0,#0x1	; 02322B22
	add r0,sp,#0x10	; 02322B24
	ldr r1,[pool_02322C94]	; 02322B26
	ldrsh r1,[r1,r3]	; 02322B28
	ldr r2,[pool_02322C98]	; 02322B2A
	ldrsh r2,[r2,r3]	; 02322B2C
	bl loc_0232D224	; 02322B2E
	add r0,sp,#0x20	; 02322B32
	add r1,sp,#0x10	; 02322B34
	add r2,sp,#0x30	; 02322B36
	bl loc_0232D230	; 02322B38
	bl loc_02321E88	; 02322B3C
	add r0,#0x20	; 02322B40
	mov r1,#0xff	; 02322B42
	and r0,r1	; 02322B44
	ldr r1,[pool_02322C9C]	; 02322B46
	orr r0,r1	; 02322B48
	str r0,[sp,#0x8]	; 02322B4A
	ldr r1,[pool_02322CA0]	; 02322B4C
	add r0,sp,#0x8	; 02322B4E
	strh r1,[r0,#0x4]	; 02322B50
	bl loc_02323E84	; 02322B52
	add r1,sp,#0x8	; 02322B56
	add r2,sp,#0x30	; 02322B58
	bl loc_023239A0	; 02322B5A
	ldr r0,[pool_02322CA4]	; 02322B5E
	bl loc_0232D3C4	; 02322B60
	add r4,r0,#0x0	; 02322B64
	ldr r0,[pool_02322C90]	; 02322B66
	bl loc_0232D3C4	; 02322B68
	add r1,r0,#0x0	; 02322B6C
	add r0,sp,#0x20	; 02322B6E
	add r2,r4,#0x0	; 02322B70
	bl loc_0232D218	; 02322B72
	ldr r0,[sp,#0x44]	; 02322B76
	lsl r3,r0,#0x1	; 02322B78
	add r0,sp,#0x10	; 02322B7A
	ldr r1,[pool_02322C94]	; 02322B7C
	ldrsh r1,[r1,r3]	; 02322B7E
	ldr r2,[pool_02322C98]	; 02322B80
	ldrsh r2,[r2,r3]	; 02322B82
	bl loc_0232D224	; 02322B84
	add r0,sp,#0x20	; 02322B88
	add r1,sp,#0x10	; 02322B8A
	add r2,sp,#0x30	; 02322B8C
	bl loc_0232D230	; 02322B8E
	bl loc_02321E88	; 02322B92
	add r0,#0x20	; 02322B96
	mov r1,#0xff	; 02322B98
	and r0,r1	; 02322B9A
	ldr r1,[pool_02322C9C]	; 02322B9C
	orr r0,r1	; 02322B9E
	str r0,[sp,#0x8]	; 02322BA0
	ldr r1,[pool_02322CA8]	; 02322BA2
	add r0,sp,#0x8	; 02322BA4
	strh r1,[r0,#0x4]	; 02322BA6
	bl loc_02323E84	; 02322BA8
	add r1,sp,#0x8	; 02322BAC
	add r2,sp,#0x30	; 02322BAE
	bl loc_023239A0	; 02322BB0
	ldr r0,[pool_02322CAC]	; 02322BB4
	bl loc_0232D3C4	; 02322BB6
	add r4,r0,#0x0	; 02322BBA
	ldr r0,[pool_02322C90]	; 02322BBC
	bl loc_0232D3C4	; 02322BBE
	add r1,r0,#0x0	; 02322BC2
	add r0,sp,#0x20	; 02322BC4
	add r2,r4,#0x0	; 02322BC6
	bl loc_0232D218	; 02322BC8
	lsl r3,r5,#0x1	; 02322BCC
	add r0,sp,#0x10	; 02322BCE
	ldr r1,[pool_02322C94]	; 02322BD0
	ldrsh r1,[r1,r3]	; 02322BD2
	ldr r2,[pool_02322C98]	; 02322BD4
	ldrsh r2,[r2,r3]	; 02322BD6
	bl loc_0232D224	; 02322BD8
	add r0,sp,#0x20	; 02322BDC
	add r1,sp,#0x10	; 02322BDE
	add r2,sp,#0x30	; 02322BE0
	bl loc_0232D230	; 02322BE2
	bl loc_02321E88	; 02322BE6
	add r0,#0x20	; 02322BEA
	mov r1,#0xff	; 02322BEC
	and r0,r1	; 02322BEE
	ldr r1,[pool_02322C9C]	; 02322BF0
	orr r0,r1	; 02322BF2
	str r0,[sp,#0x8]	; 02322BF4
	ldr r1,[pool_02322CA8]	; 02322BF6
	add r0,sp,#0x8	; 02322BF8
	strh r1,[r0,#0x4]	; 02322BFA
	bl loc_02323E84	; 02322BFC
	add r1,sp,#0x8	; 02322C00
	add r2,sp,#0x30	; 02322C02
	bl loc_023239A0	; 02322C04
	ldr r0,[pool_02322CB0]	; 02322C08
	ldrb r0,[r0,#0x1]	; 02322C0A
	mov r1,#0xc	; 02322C0C
	blx P1_SignedDivMod	; 02322C0E
	add r4,r0,#0x0	; 02322C12
	ldr r0,[pool_02322CB0]	; 02322C14
	ldrb r0,[r0,#0x0]	; 02322C16
	mov r1,#0xc	; 02322C18
	blx P1_SignedDivMod	; 02322C1A
	mov r0,#0x5	; 02322C1E
	mul r1,r0	; 02322C20
	add r5,r4,r1	; 02322C22
	ldr r0,[pool_02322CB4]	; 02322C24
	bl loc_0232D3C4	; 02322C26
	add r4,r0,#0x0	; 02322C2A
	ldr r0,[pool_02322C90]	; 02322C2C
	bl loc_0232D3C4	; 02322C2E
	add r1,r0,#0x0	; 02322C32
	add r0,sp,#0x20	; 02322C34
	add r2,r4,#0x0	; 02322C36
	bl loc_0232D218	; 02322C38
	lsl r3,r5,#0x1	; 02322C3C
	add r0,sp,#0x10	; 02322C3E
	ldr r1,[pool_02322C94]	; 02322C40
	ldrsh r1,[r1,r3]	; 02322C42
	ldr r2,[pool_02322C98]	; 02322C44
	ldrsh r2,[r2,r3]	; 02322C46
	bl loc_0232D224	; 02322C48
	add r0,sp,#0x20	; 02322C4C
	add r1,sp,#0x10	; 02322C4E
	add r2,sp,#0x30	; 02322C50
	bl loc_0232D230	; 02322C52
	bl loc_02321E88	; 02322C56
	add r0,#0x20	; 02322C5A
	mov r1,#0xff	; 02322C5C
	and r0,r1	; 02322C5E
	ldr r1,[pool_02322C9C]	; 02322C60
	orr r0,r1	; 02322C62
	str r0,[sp,#0x8]	; 02322C64
	ldr r1,[pool_02322CB8]	; 02322C66
	add r0,sp,#0x8	; 02322C68
	strh r1,[r0,#0x4]	; 02322C6A
	bl loc_02323E84	; 02322C6C
	add r1,sp,#0x8	; 02322C70
	add r2,sp,#0x30	; 02322C72
	bl loc_023239A0	; 02322C74
	add sp,#0x4c	; 02322C78
	pop {r4,r5}	; 02322C7A
	pop {r3}	; 02322C7C
	bx r3	; 02322C7E
pool_02322C80:
loc_02322C80:
	.word P1_BssStart + 0x1558	; 02322C80
pool_02322C84:
loc_02322C84:
	.word 0x023C1178	; 02322C84
pool_02322C88:
loc_02322C88:
	.word 0x023A580C	; 02322C88
pool_02322C8C:
loc_02322C8C:
	.word 0x00009000	; 02322C8C
pool_02322C90:
loc_02322C90:
	.word 0x00001000	; 02322C90
pool_02322C94:
loc_02322C94:
	.word P1_Data_023305A0	; 02322C94
pool_02322C98:
loc_02322C98:
	.word P1_Data_02330618	; 02322C98
pool_02322C9C:
loc_02322C9C:
	.word 0xC0000300	; 02322C9C
pool_02322CA0:
loc_02322CA0:
	.word 0x0000F3F0	; 02322CA0
pool_02322CA4:
loc_02322CA4:
	.word 0x00008000	; 02322CA4
pool_02322CA8:
loc_02322CA8:
	.word 0x000023F0	; 02322CA8
pool_02322CAC:
loc_02322CAC:
	.word 0x00006000	; 02322CAC
pool_02322CB0:
loc_02322CB0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsAlarmHourOffset	; 02322CB0
pool_02322CB4:
loc_02322CB4:
	.word 0x00004000	; 02322CB4
pool_02322CB8:
loc_02322CB8:
	.word 0x000053E0	; 02322CB8

; ===== function loc_02322CBC =====
loc_02322CBC:
	push {lr}	; 02322CBC
	sub sp,#0x1c	; 02322CBE
	mov r0,#0x0	; 02322CC0
	str r0,[sp,#0x0]	; 02322CC2
	str r0,[sp,#0x4]	; 02322CC4
	add r0,sp,#0x8	; 02322CC6
	ldr r2,[pool_02322D48]	; 02322CC8
	ldr r1,[pool_02322D4C]	; 02322CCA
	add r1,r2,r1	; 02322CCC
	mov r2,#0x40	; 02322CCE
	add r3,r2,#0x0	; 02322CD0
	bl loc_02329028	; 02322CD2
	mov r0,#0x1c	; 02322CD6
	str r0,[sp,#0x0]	; 02322CD8
	mov r0,#0x7	; 02322CDA
	str r0,[sp,#0x4]	; 02322CDC
	add r0,sp,#0x8	; 02322CDE
	mov r1,#0x1f	; 02322CE0
	mov r2,#0x20	; 02322CE2
	add r3,r1,#0x0	; 02322CE4
	bl loc_02324458	; 02322CE6
	mov r0,#0x1c	; 02322CEA
	str r0,[sp,#0x0]	; 02322CEC
	mov r0,#0x7	; 02322CEE
	str r0,[sp,#0x4]	; 02322CF0
	add r0,sp,#0x8	; 02322CF2
	mov r1,#0x20	; 02322CF4
	add r2,r1,#0x0	; 02322CF6
	add r3,r1,#0x0	; 02322CF8
	bl loc_02324458	; 02322CFA
	mov r0,#0x0	; 02322CFE
	str r0,[sp,#0x0]	; 02322D00
	str r0,[sp,#0x4]	; 02322D02
	add r0,sp,#0x8	; 02322D04
	ldr r2,[pool_02322D48]	; 02322D06
	ldr r1,[pool_02322D50]	; 02322D08
	add r1,r2,r1	; 02322D0A
	mov r2,#0x40	; 02322D0C
	add r3,r2,#0x0	; 02322D0E
	bl loc_02329028	; 02322D10
	mov r0,#0x1c	; 02322D14
	str r0,[sp,#0x0]	; 02322D16
	mov r0,#0x8	; 02322D18
	str r0,[sp,#0x4]	; 02322D1A
	add r0,sp,#0x8	; 02322D1C
	mov r1,#0x1f	; 02322D1E
	mov r2,#0x20	; 02322D20
	add r3,r1,#0x0	; 02322D22
	bl loc_02324458	; 02322D24
	mov r0,#0x1c	; 02322D28
	str r0,[sp,#0x0]	; 02322D2A
	mov r0,#0x8	; 02322D2C
	str r0,[sp,#0x4]	; 02322D2E
	add r0,sp,#0x8	; 02322D30
	mov r1,#0x20	; 02322D32
	add r2,r1,#0x0	; 02322D34
	add r3,r1,#0x0	; 02322D36
	bl loc_02324458	; 02322D38
	ldr r0,[pool_02322D54]	; 02322D3C
	bl loc_02326A80	; 02322D3E
	add sp,#0x1c	; 02322D42
	pop {r3}	; 02322D44
	bx r3	; 02322D46
pool_02322D48:
loc_02322D48:
	.word 0x06400000	; 02322D48
pool_02322D4C:
loc_02322D4C:
	.word 0x0001F000	; 02322D4C
pool_02322D50:
loc_02322D50:
	.word 0x0001F800	; 02322D50
pool_02322D54:
loc_02322D54:
	.word 0x02331FD8	; 02322D54
loc_02322D58:
	push {r4,r5,lr}	; 02322D58
	sub sp,#0x1c	; 02322D5A
	add r5,r0,#0x0	; 02322D5C
	add r0,sp,#0xc	; 02322D5E
	bl loc_02326A64	; 02322D60
	ldr r1,[sp,#0x14]	; 02322D64
	ldr r0,[r5,#0x0]	; 02322D66
	cmp r1,r0	; 02322D68
	bne loc_02322D7C	; 02322D6A
	ldr r1,[sp,#0x10]	; 02322D6C
	ldr r0,[r5,#0x4]	; 02322D6E
	cmp r1,r0	; 02322D70
	bne loc_02322D7C	; 02322D72
	ldr r1,[sp,#0xc]	; 02322D74
	ldr r0,[r5,#0x8]	; 02322D76
	cmp r1,r0	; 02322D78
	beq loc_02322D82	; 02322D7A
loc_02322D7C:
	add r0,r5,#0x0	; 02322D7C
	bl loc_02322E4C	; 02322D7E
loc_02322D82:
	bl loc_02323E84	; 02322D82
	add r4,r0,#0x0	; 02322D86
	bl loc_02321E88	; 02322D88
	ldrh r1,[r5,#0xc]	; 02322D8C
	str r1,[sp,#0x0]	; 02322D8E
	ldrh r1,[r5,#0xe]	; 02322D90
	add r0,r1,r0	; 02322D92
	str r0,[sp,#0x4]	; 02322D94
	mov r0,#0x1	; 02322D96
	str r0,[sp,#0x8]	; 02322D98
	add r0,r4,#0x0	; 02322D9A
	ldr r1,[pool_02322DB0]	; 02322D9C
	ldr r2,[pool_02322DB4]	; 02322D9E
	mov r3,#0x0	; 02322DA0
	bl loc_02323AEC	; 02322DA2
	add sp,#0x1c	; 02322DA6
	pop {r4,r5}	; 02322DA8
	pop {r3}	; 02322DAA
	bx r3	; 02322DAC
	.byte 0xC0, 0x46	; 02322DB0
pool_02322DB0:
loc_02322DB0:
	.word 0x023C1178	; 02322DB0
pool_02322DB4:
loc_02322DB4:
	.word 0x023A580C	; 02322DB4

; ===== function loc_02322DB8 =====
loc_02322DB8:
	push {r4,r5,r6,r7,lr}	; 02322DB8
	sub sp,#0x4	; 02322DBA
	add r4,r0,#0x0	; 02322DBC
	blx P1_GetMainBg2TilemapAddress	; 02322DBE
	add r7,r0,#0x0	; 02322DC2
	cmp r4,#0x0	; 02322DC4
	beq loc_02322DCC	; 02322DC6
	mov r6,#0xf	; 02322DC8
	b loc_02322DCE	; 02322DCA
loc_02322DCC:
	mov r6,#0x11	; 02322DCC
loc_02322DCE:
	mov r4,#0x0	; 02322DCE
	str r4,[sp,#0x0]	; 02322DD0
loc_02322DD2:
	ldr r5,[sp,#0x0]	; 02322DD2
	add r0,r6,r4	; 02322DD4
	lsl r1,r0,#0x6	; 02322DD6
	ldr r0,[pool_02322E04]	; 02322DD8
	add r3,r0,r1	; 02322DDA
	add r0,r4,#0x0	; 02322DDC
	add r0,#0x11	; 02322DDE
	lsl r0,r0,#0x6	; 02322DE0
	add r2,r7,r0	; 02322DE2
loc_02322DE4:
	add r0,r5,#0x0	; 02322DE4
	add r0,#0xf	; 02322DE6
	lsl r1,r0,#0x1	; 02322DE8
	ldrh r0,[r3,r1]	; 02322DEA
	strh r0,[r2,r1]	; 02322DEC
	add r5,r5,#0x1	; 02322DEE
	cmp r5,#0x10	; 02322DF0
	blt loc_02322DE4	; 02322DF2
	add r4,r4,#0x1	; 02322DF4
	cmp r4,#0x4	; 02322DF6
	blt loc_02322DD2	; 02322DF8
	add sp,#0x4	; 02322DFA
	pop {r4,r5,r6,r7}	; 02322DFC
	pop {r3}	; 02322DFE
	bx r3	; 02322E00
	.byte 0xC0, 0x46	; 02322E04
pool_02322E04:
loc_02322E04:
	.word 0x023B85C0	; 02322E04

; ===== function loc_02322E08 =====
loc_02322E08:
	push {r4,r5,r6,r7,lr}	; 02322E08
	sub sp,#0x4	; 02322E0A
	add r4,r0,#0x0	; 02322E0C
	add r7,r1,#0x0	; 02322E0E
	add r5,r2,#0x0	; 02322E10
	ldr r0,[pool_02322E48]	; 02322E12
	add r0,r4,r0	; 02322E14
	mov r2,#0x1	; 02322E16
	bl loc_02326AE0	; 02322E18
	add r6,r0,#0x0	; 02322E1C
	add r0,r4,#0x0	; 02322E1E
	add r1,r7,#0x0	; 02322E20
	mov r2,#0x0	; 02322E22
	bl loc_02326B44	; 02322E24
	add r4,r0,#0x0	; 02322E28
	add r0,r6,#0x7	; 02322E2A
	sub r0,r0,r5	; 02322E2C
	mov r1,#0x7	; 02322E2E
	blx P1_SignedDivMod	; 02322E30
	add r0,r1,r4	; 02322E34
	cmp r0,#0x23	; 02322E36
	ble loc_02322E3E	; 02322E38
	mov r0,#0x1	; 02322E3A
	b loc_02322E40	; 02322E3C
loc_02322E3E:
	mov r0,#0x0	; 02322E3E
loc_02322E40:
	add sp,#0x4	; 02322E40
	pop {r4,r5,r6,r7}	; 02322E42
	pop {r3}	; 02322E44
	bx r3	; 02322E46
pool_02322E48:
loc_02322E48:
	.word 0x000007D0	; 02322E48

; ===== function loc_02322E4C =====
loc_02322E4C:
	push {r4,r5,r6,r7,lr}	; 02322E4C
	sub sp,#0xb4	; 02322E4E
	add r4,r0,#0x0	; 02322E50
	ldr r5,[pool_0232309C]	; 02322E52
	add r3,sp,#0x58	; 02322E54
	mov r2,#0x3	; 02322E56
loc_02322E58:
	ldmia r5!,{r0,r1}	; 02322E58
	stmia r3!,{r0,r1}	; 02322E5A
	sub r2,r2,#0x1	; 02322E5C
	cmp r2,#0x0	; 02322E5E
	bne loc_02322E58	; 02322E60
	ldr r0,[r5,#0x0]	; 02322E62
	str r0,[r3,#0x0]	; 02322E64
	ldr r5,[pool_023230A0]	; 02322E66
	add r3,sp,#0x74	; 02322E68
	mov r2,#0x3	; 02322E6A
loc_02322E6C:
	ldmia r5!,{r0,r1}	; 02322E6C
	stmia r3!,{r0,r1}	; 02322E6E
	sub r2,r2,#0x1	; 02322E70
	cmp r2,#0x0	; 02322E72
	bne loc_02322E6C	; 02322E74
	ldr r0,[r5,#0x0]	; 02322E76
	str r0,[r3,#0x0]	; 02322E78
	add r0,sp,#0x48	; 02322E7A
	bl loc_02326A64	; 02322E7C
	ldr r0,[sp,#0x48]	; 02322E80
	str r0,[r4,#0x8]	; 02322E82
	ldr r0,[sp,#0x4c]	; 02322E84
	str r0,[r4,#0x4]	; 02322E86
	ldr r0,[sp,#0x50]	; 02322E88
	str r0,[r4,#0x0]	; 02322E8A
	bl P1_GetMainBg1CharacterBase	; 02322E8C
	add r1,r0,#0x0	; 02322E90
	mov r0,#0x0	; 02322E92
	str r0,[sp,#0x34]	; 02322E94
	ldr r0,[sp,#0x34]	; 02322E96
	ldr r2,[pool_023230A4]	; 02322E98
	blx loc_0232DE78	; 02322E9A
	bl P1_GetMainBg1CharacterBase	; 02322E9E
	add r5,r0,#0x0	; 02322EA2
	bl loc_02324CAC	; 02322EA4
	mov r1,#0x0	; 02322EA8
	str r1,[sp,#0x0]	; 02322EAA
	str r0,[sp,#0x4]	; 02322EAC
	add r0,sp,#0x38	; 02322EAE
	add r1,r5,#0x0	; 02322EB0
	ldr r2,[pool_023230A8]	; 02322EB2
	mov r3,#0xc0	; 02322EB4
	bl loc_02329028	; 02322EB6
	add r0,sp,#0x24	; 02322EBA
	ldr r1,[sp,#0x48]	; 02322EBC
	bl loc_02325A64	; 02322EBE
	add r0,sp,#0x2c	; 02322EC2
	ldr r1,[sp,#0x4c]	; 02322EC4
	bl loc_02325A64	; 02322EC6
	ldr r0,[pool_023230AC]	; 02322ECA
	ldrh r0,[r0,#0x0]	; 02322ECC
	lsl r0,r0,#0x1d	; 02322ECE
	lsr r0,r0,#0x1d	; 02322ED0
	cmp r0,#0x5	; 02322ED2
	bhi loc_02322EF0	; 02322ED4
	add r0,r0,r0	; 02322ED6
P1_SwitchIndexPC_02322ED6:
	add r0,pc	; 02322ED8
	ldrh r0,[r0,#(P1_SwitchTable_02322ED6 - (P1_SwitchIndexPC_02322ED6 + 4))]	; 02322EDA
	lsl r0,r0,#0x10	; 02322EDC
	asr r0,r0,#0x10	; 02322EDE
P1_SwitchTargetPC_02322ED6:
	add r0,pc	; 02322EE0
	bx r0	; 02322EE2
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02322ED6:
	.halfword (loc_02322EF0 + 1) - (P1_SwitchTargetPC_02322ED6 + 4)
	.halfword (loc_02322F04 + 1) - (P1_SwitchTargetPC_02322ED6 + 4)
	.halfword (loc_02322F04 + 1) - (P1_SwitchTargetPC_02322ED6 + 4)
	.halfword (loc_02322EFA + 1) - (P1_SwitchTargetPC_02322ED6 + 4)
	.halfword (loc_02322F04 + 1) - (P1_SwitchTargetPC_02322ED6 + 4)
	.halfword (loc_02322F04 + 1) - (P1_SwitchTargetPC_02322ED6 + 4)
P1_SwitchTable_02322ED6End:
loc_02322EF0:
	add r0,sp,#0x90	; 02322EF0
	ldr r1,[pool_023230B0]	; 02322EF2
	bl P1_Utf16StrCpy	; 02322EF4
	b loc_02322F0C	; 02322EF8
loc_02322EFA:
	add r0,sp,#0x90	; 02322EFA
	ldr r1,[pool_023230B4]	; 02322EFC
	bl P1_Utf16StrCpy	; 02322EFE
	b loc_02322F0C	; 02322F02
loc_02322F04:
	add r0,sp,#0x90	; 02322F04
	ldr r1,[pool_023230B8]	; 02322F06
	bl P1_Utf16StrCpy	; 02322F08
loc_02322F0C:
	add r0,sp,#0x90	; 02322F0C
	mov r1,#0x59	; 02322F0E
	bl P1_Utf16StrChr	; 02322F10
	add r1,sp,#0x24	; 02322F14
	mov r2,#0x2	; 02322F16
	bl P1_Utf16StrNCpy	; 02322F18
	add r0,sp,#0x90	; 02322F1C
	mov r1,#0x4d	; 02322F1E
	bl P1_Utf16StrChr	; 02322F20
	add r1,sp,#0x2c	; 02322F24
	mov r2,#0x2	; 02322F26
	bl P1_Utf16StrNCpy	; 02322F28
	ldr r0,[pool_023230BC]	; 02322F2C
	mov r1,#0x0	; 02322F2E
	bl loc_02329198	; 02322F30
	add r1,r0,#0x0	; 02322F34
	add r0,sp,#0x38	; 02322F36
	add r2,sp,#0x90	; 02322F38
	bl loc_02329118	; 02322F3A
	mov r5,#0x0	; 02322F3E
	b loc_02322F8A	; 02322F40
loc_02322F42:
	ldr r0,[pool_023230BC]	; 02322F42
	add r1,r5,#0x1	; 02322F44
	bl loc_02329198	; 02322F46
	add r6,r0,#0x0	; 02322F4A
	bl loc_02324C9C	; 02322F4C
	add r7,r0,#0x0	; 02322F50
	lsl r1,r5,#0x2	; 02322F52
	add r0,sp,#0x58	; 02322F54
	ldr r0,[r0,r1]	; 02322F56
	bl loc_02324DE0	; 02322F58
	mov r1,#0x4	; 02322F5C
	ldrsb r1,[r6,r1]	; 02322F5E
	str r1,[sp,#0x0]	; 02322F60
	mov r1,#0x5	; 02322F62
	ldrsb r1,[r6,r1]	; 02322F64
	str r1,[sp,#0x4]	; 02322F66
	str r0,[sp,#0x8]	; 02322F68
	ldrb r0,[r6,#0x6]	; 02322F6A
	str r0,[sp,#0xc]	; 02322F6C
	add r0,r7,#0x0	; 02322F6E
	add r1,sp,#0x38	; 02322F70
	mov r7,sp	; 02322F72
	sub r7,r7,#0x4	; 02322F74
	ldrh r2,[r6,#0x0]	; 02322F76
	strh r2,[r7,#0x0]	; 02322F78
	add r3,r7,#0x0	; 02322F7A
	ldmia r3!,{r2}	; 02322F7C
	ldrh r3,[r6,#0x2]	; 02322F7E
	strh r3,[r7,#0x0]	; 02322F80
	ldmia r7!,{r3}	; 02322F82
	bl loc_02328CC8	; 02322F84
	add r5,r5,#0x1	; 02322F88
loc_02322F8A:
	cmp r5,#0x7	; 02322F8A
	bcc loc_02322F42	; 02322F8C
	ldr r0,[pool_023230BC]	; 02322F8E
	mov r1,#0x1	; 02322F90
	bl loc_02329198	; 02322F92
	ldrh r1,[r0,#0x0]	; 02322F96
	add r0,sp,#0x20	; 02322F98
	strh r1,[r0,#0x2]	; 02322F9A
	ldrh r1,[r0,#0x2]	; 02322F9C
	strh r1,[r0,#0x0]	; 02322F9E
	mov r5,#0x0	; 02322FA0
	ldr r1,[sp,#0x48]	; 02322FA2
	ldr r0,[pool_023230C0]	; 02322FA4
	add r0,r1,r0	; 02322FA6
	ldr r1,[sp,#0x4c]	; 02322FA8
	mov r2,#0x1	; 02322FAA
	bl loc_02326AE0	; 02322FAC
	add r0,r0,#0x7	; 02322FB0
	sub r0,r0,r5	; 02322FB2
	mov r1,#0x7	; 02322FB4
	blx P1_SignedDivMod	; 02322FB6
	add r7,r1,#0x0	; 02322FBA
	ldr r0,[r4,#0x0]	; 02322FBC
	add r0,r7,r0	; 02322FBE
	sub r0,r0,#0x1	; 02322FC0
	mov r1,#0x7	; 02322FC2
	blx P1_SignedDivMod	; 02322FC4
	lsl r0,r1,#0x4	; 02322FC8
	strh r0,[r4,#0xc]	; 02322FCA
	ldr r0,[r4,#0x0]	; 02322FCC
	add r0,r7,r0	; 02322FCE
	sub r0,r0,#0x1	; 02322FD0
	mov r1,#0x7	; 02322FD2
	blx P1_SignedDivMod	; 02322FD4
	lsl r0,r0,#0x4	; 02322FD8
	strh r0,[r4,#0xe]	; 02322FDA
	add r4,sp,#0x20	; 02322FDC
	str r5,[sp,#0x14]	; 02322FDE
	str r5,[sp,#0x18]	; 02322FE0
	str r5,[sp,#0x1c]	; 02322FE2
	b loc_0232306A	; 02322FE4
loc_02322FE6:
	add r0,r7,r5	; 02322FE6
	str r0,[sp,#0x10]	; 02322FE8
	mov r1,#0x7	; 02322FEA
	blx P1_SignedDivMod	; 02322FEC
	add r6,r1,#0x0	; 02322FF0
	add r0,sp,#0x90	; 02322FF2
	add r1,r5,#0x1	; 02322FF4
	lsl r1,r1,#0x10	; 02322FF6
	lsr r1,r1,#0x10	; 02322FF8
	bl loc_02325A3C	; 02322FFA
	ldr r0,[sp,#0x1c]	; 02322FFE
	ldrsh r0,[r4,r0]	; 02323000
	ldr r1,[pool_023230C4]	; 02323002
	and r0,r1	; 02323004
	lsl r1,r6,#0x4	; 02323006
	add r1,#0x88	; 02323008
	lsl r1,r1,#0x10	; 0232300A
	asr r2,r1,#0x10	; 0232300C
	ldr r1,[pool_023230C8]	; 0232300E
	and r2,r1	; 02323010
	orr r0,r2	; 02323012
	strh r0,[r4,#0x0]	; 02323014
	ldr r0,[sp,#0x10]	; 02323016
	mov r1,#0x7	; 02323018
	blx P1_SignedDivMod	; 0232301A
	mov r1,#0x2	; 0232301E
	ldrsh r1,[r4,r1]	; 02323020
	ldr r2,[pool_023230C4]	; 02323022
	and r1,r2	; 02323024
	add r0,r0,#0x1	; 02323026
	lsl r0,r0,#0x4	; 02323028
	add r0,#0x37	; 0232302A
	lsl r0,r0,#0x10	; 0232302C
	asr r2,r0,#0x10	; 0232302E
	ldr r0,[pool_023230C8]	; 02323030
	and r2,r0	; 02323032
	orr r1,r2	; 02323034
	strh r1,[r4,#0x2]	; 02323036
	bl loc_02324C9C	; 02323038
	mov r1,#0x1	; 0232303C
	str r1,[sp,#0x0]	; 0232303E
	ldr r1,[sp,#0x14]	; 02323040
	str r1,[sp,#0x4]	; 02323042
	add r1,sp,#0x90	; 02323044
	str r1,[sp,#0x8]	; 02323046
	lsl r2,r6,#0x2	; 02323048
	add r1,sp,#0x74	; 0232304A
	ldr r1,[r1,r2]	; 0232304C
	str r1,[sp,#0xc]	; 0232304E
	add r1,sp,#0x38	; 02323050
	mov r6,sp	; 02323052
	sub r6,r6,#0x4	; 02323054
	ldrh r2,[r4,#0x0]	; 02323056
	strh r2,[r6,#0x0]	; 02323058
	add r3,r6,#0x0	; 0232305A
	ldmia r3!,{r2}	; 0232305C
	ldrh r3,[r4,#0x2]	; 0232305E
	strh r3,[r6,#0x0]	; 02323060
	ldmia r6!,{r3}	; 02323062
	bl loc_02328CC8	; 02323064
	add r5,r5,#0x1	; 02323068
loc_0232306A:
	ldr r0,[sp,#0x48]	; 0232306A
	ldr r1,[sp,#0x4c]	; 0232306C
	ldr r2,[sp,#0x18]	; 0232306E
	bl loc_02326B44	; 02323070
	cmp r5,r0	; 02323074
	bcc loc_02322FE6	; 02323076
	ldr r0,[sp,#0x48]	; 02323078
	ldr r1,[sp,#0x4c]	; 0232307A
	mov r2,#0x0	; 0232307C
	bl loc_02322E08	; 0232307E
	cmp r0,#0x0	; 02323082
	beq loc_0232308E	; 02323084
	mov r0,#0x1	; 02323086
	bl loc_02322DB8	; 02323088
	b loc_02323094	; 0232308C
loc_0232308E:
	mov r0,#0x0	; 0232308E
	bl loc_02322DB8	; 02323090
loc_02323094:
	add sp,#0xb4	; 02323094
	pop {r4,r5,r6,r7}	; 02323096
	pop {r3}	; 02323098
	bx r3	; 0232309A
pool_0232309C:
loc_0232309C:
	.word 0x02330690	; 0232309C
pool_023230A0:
loc_023230A0:
	.word 0x023306AC	; 023230A0
pool_023230A4:
loc_023230A4:
	.word 0x00006000	; 023230A4
pool_023230A8:
loc_023230A8:
	.word 0x00000100	; 023230A8
pool_023230AC:
loc_023230AC:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023230AC
pool_023230B0:
loc_023230B0:
	.word 0x023306C8	; 023230B0
pool_023230B4:
loc_023230B4:
	.word 0x023306D8	; 023230B4
pool_023230B8:
loc_023230B8:
	.word 0x023306E8	; 023230B8
pool_023230BC:
loc_023230BC:
	.word 0x023A641C	; 023230BC
pool_023230C0:
loc_023230C0:
	.word 0x000007D0	; 023230C0
pool_023230C4:
loc_023230C4:
	.word 0xFFFFF000	; 023230C4
pool_023230C8:
loc_023230C8:
	.word 0x00000FFF	; 023230C8

; ===== function loc_023230CC =====
loc_023230CC:
	ldr r0,[pool_023230D4]	; 023230CC
	ldr r3,[pool_023230D8]	; 023230CE
	bx r3	; 023230D0
	.byte 0xC0, 0x46	; 023230D4
pool_023230D4:
loc_023230D4:
	.word 0x02331FE4	; 023230D4
pool_023230D8:
loc_023230D8:
	.word loc_02322D58 + 1	; 023230D8

; ===== function loc_023230DC =====
loc_023230DC:
	ldr r0,[pool_023230E4]	; 023230DC
	ldr r3,[pool_023230E8]	; 023230DE
	bx r3	; 023230E0
	.byte 0xC0, 0x46	; 023230E4
pool_023230E4:
loc_023230E4:
	.word 0x02331FE4	; 023230E4
pool_023230E8:
loc_023230E8:
	.word loc_02322E4C + 1	; 023230E8

; ===== function loc_023230EC =====
loc_023230EC:
	ldr r0,[pool_023230F4]	; 023230EC
	ldr r3,[pool_023230F8]	; 023230EE
	bx r3	; 023230F0
	.byte 0xC0, 0x46	; 023230F4
pool_023230F4:
loc_023230F4:
	.word 0x02331FE4	; 023230F4
pool_023230F8:
loc_023230F8:
	.word loc_02322E4C + 1	; 023230F8

; ===== function loc_023230FC =====
loc_023230FC:
	push {r4,r5,lr}	; 023230FC
	sub sp,#0x24	; 023230FE
	ldr r0,[pool_023232C0]	; 02323100
	ldr r1,[r0,#0x8]	; 02323102
	cmp r1,#0x0	; 02323104
	bne loc_0232310A	; 02323106
	b loc_023232B6	; 02323108
loc_0232310A:
	ldr r1,[r0,#0x4]	; 0232310A
	cmp r1,#0xa	; 0232310C
	bge loc_02323114	; 0232310E
	add r1,r1,#0x1	; 02323110
	str r1,[r0,#0x4]	; 02323112
loc_02323114:
	ldr r0,[pool_023232C0]	; 02323114
	ldr r0,[r0,#0x4]	; 02323116
	lsl r0,r0,#0x4	; 02323118
	mov r1,#0xa	; 0232311A
	blx P1_SignedDivMod	; 0232311C
	add r4,r0,#0x0	; 02323120
	sub r4,#0x10	; 02323122
	add r0,sp,#0x10	; 02323124
	bl loc_02326408	; 02323126
	ldr r0,[pool_023232C4]	; 0232312A
	ldr r1,[r0,#0x0]	; 0232312C
	add r1,r1,#0x1	; 0232312E
	str r1,[r0,#0x0]	; 02323130
	cmp r1,#0x1e	; 02323132
	bge loc_0232313E	; 02323134
	mov r1,#0x7f	; 02323136
	add r0,sp,#0xc	; 02323138
	strh r1,[r0,#0x8]	; 0232313A
	b loc_02323146	; 0232313C
loc_0232313E:
	cmp r1,#0x3c	; 0232313E
	bne loc_02323146	; 02323140
	mov r1,#0x0	; 02323142
	str r1,[r0,#0x0]	; 02323144
loc_02323146:
	ldr r0,[pool_023232C8]	; 02323146
	add r1,sp,#0x10	; 02323148
	bl loc_02324B44	; 0232314A
	add r0,sp,#0x10	; 0232314E
	bl loc_023263B8	; 02323150
	ldr r0,[pool_023232CC]	; 02323154
	add r1,sp,#0x10	; 02323156
	bl loc_02324B44	; 02323158
	bl loc_02323E84	; 0232315C
	add r5,r0,#0x0	; 02323160
	mov r0,#0x1	; 02323162
	str r0,[sp,#0x0]	; 02323164
	ldr r0,[pool_023232C8]	; 02323166
	mov r1,#0x0	; 02323168
	add r2,r4,#0x0	; 0232316A
	add r3,r1,#0x0	; 0232316C
	bl loc_02323780	; 0232316E
	mov r0,#0x1	; 02323172
	str r0,[sp,#0x0]	; 02323174
	ldr r0,[pool_023232CC]	; 02323176
	mov r1,#0x0	; 02323178
	add r2,r4,#0x0	; 0232317A
	add r3,r1,#0x0	; 0232317C
	bl loc_02323780	; 0232317E
	mov r0,#0x1	; 02323182
	str r0,[sp,#0x0]	; 02323184
	ldr r0,[pool_023232D0]	; 02323186
	mov r1,#0x0	; 02323188
	add r2,r4,#0x0	; 0232318A
	add r3,r1,#0x0	; 0232318C
	bl loc_02323780	; 0232318E
	mov r0,#0x0	; 02323192
	str r0,[sp,#0x0]	; 02323194
	str r4,[sp,#0x4]	; 02323196
	add r0,r5,#0x0	; 02323198
	ldr r1,[pool_023232D4]	; 0232319A
	ldr r2,[pool_023232D8]	; 0232319C
	mov r3,#0x6	; 0232319E
	bl loc_02323C40	; 023231A0
	mov r0,#0x0	; 023231A4
	str r0,[sp,#0x0]	; 023231A6
	str r4,[sp,#0x4]	; 023231A8
	add r0,r5,#0x0	; 023231AA
	ldr r1,[pool_023232D4]	; 023231AC
	ldr r2,[pool_023232D8]	; 023231AE
	mov r3,#0x7	; 023231B0
	bl loc_02323C40	; 023231B2
	mov r0,#0x0	; 023231B6
	str r0,[sp,#0x0]	; 023231B8
	str r4,[sp,#0x4]	; 023231BA
	add r0,r5,#0x0	; 023231BC
	ldr r1,[pool_023232D4]	; 023231BE
	ldr r2,[pool_023232D8]	; 023231C0
	mov r3,#0x8	; 023231C2
	bl loc_02323C40	; 023231C4
	mov r0,#0x0	; 023231C8
	str r0,[sp,#0x0]	; 023231CA
	str r4,[sp,#0x4]	; 023231CC
	add r0,r5,#0x0	; 023231CE
	ldr r1,[pool_023232D4]	; 023231D0
	ldr r2,[pool_023232D8]	; 023231D2
	mov r3,#0x9	; 023231D4
	bl loc_02323C40	; 023231D6
	mov r0,#0x0	; 023231DA
	str r0,[sp,#0x0]	; 023231DC
	str r4,[sp,#0x4]	; 023231DE
	add r0,r5,#0x0	; 023231E0
	ldr r1,[pool_023232D4]	; 023231E2
	ldr r2,[pool_023232D8]	; 023231E4
	mov r3,#0xa	; 023231E6
	bl loc_02323C40	; 023231E8
	bl P1_GetFirmwareUiContext	; 023231EC
	ldr r0,[r0,#0x4]	; 023231F0
	mov r1,#0x14	; 023231F2
	blx P1_UnsignedDivMod	; 023231F4
	cmp r1,#0x1	; 023231F8
	bne loc_02323222	; 023231FA
	add r0,sp,#0xc	; 023231FC
	bl loc_0232F1A8	; 023231FE
	cmp r0,#0x0	; 02323202
	bne loc_0232321C	; 02323204
	ldr r0,[sp,#0xc]	; 02323206
	cmp r0,#0x0	; 02323208
	bne loc_02323214	; 0232320A
	mov r1,#0x1	; 0232320C
	ldr r0,[pool_023232DC]	; 0232320E
	str r1,[r0,#0x0]	; 02323210
	b loc_02323222	; 02323212
loc_02323214:
	mov r1,#0x0	; 02323214
	ldr r0,[pool_023232DC]	; 02323216
	str r1,[r0,#0x0]	; 02323218
	b loc_02323222	; 0232321A
loc_0232321C:
	mov r1,#0x1	; 0232321C
	ldr r0,[pool_023232DC]	; 0232321E
	str r1,[r0,#0x0]	; 02323220
loc_02323222:
	ldr r0,[pool_023232E0]	; 02323222
	ldr r1,[r0,#0x0]	; 02323224
	add r1,r1,#0x1	; 02323226
	str r1,[r0,#0x0]	; 02323228
	cmp r1,#0x3c	; 0232322A
	bne loc_02323232	; 0232322C
	mov r1,#0x0	; 0232322E
	str r1,[r0,#0x0]	; 02323230
loc_02323232:
	ldr r0,[pool_023232DC]	; 02323232
	ldr r1,[r0,#0x0]	; 02323234
	cmp r1,#0x0	; 02323236
	bne loc_02323242	; 02323238
	ldr r0,[pool_023232E0]	; 0232323A
	ldr r0,[r0,#0x0]	; 0232323C
	cmp r0,#0x1e	; 0232323E
	bge loc_0232325C	; 02323240
loc_02323242:
	cmp r1,#0x0	; 02323242
	beq loc_0232324A	; 02323244
	mov r3,#0xb	; 02323246
	b loc_0232324C	; 02323248
loc_0232324A:
	mov r3,#0x5	; 0232324A
loc_0232324C:
	mov r0,#0x0	; 0232324C
	str r0,[sp,#0x0]	; 0232324E
	str r4,[sp,#0x4]	; 02323250
	add r0,r5,#0x0	; 02323252
	ldr r1,[pool_023232D4]	; 02323254
	ldr r2,[pool_023232D8]	; 02323256
	bl loc_02323C40	; 02323258
loc_0232325C:
	ldr r0,[pool_023232E4]	; 0232325C
	ldrh r0,[r0,#0x0]	; 0232325E
	lsl r0,r0,#0x1c	; 02323260
	lsr r0,r0,#0x1f	; 02323262
	cmp r0,#0x0	; 02323264
	beq loc_0232326C	; 02323266
	mov r3,#0xc	; 02323268
	b loc_0232326E	; 0232326A
loc_0232326C:
	mov r3,#0x2	; 0232326C
loc_0232326E:
	mov r0,#0x0	; 0232326E
	str r0,[sp,#0x0]	; 02323270
	str r4,[sp,#0x4]	; 02323272
	add r0,r5,#0x0	; 02323274
	ldr r1,[pool_023232D4]	; 02323276
	ldr r2,[pool_023232D8]	; 02323278
	bl loc_02323C40	; 0232327A
	ldr r0,[pool_023232E4]	; 0232327E
	ldrh r0,[r0,#0x0]	; 02323280
	lsl r0,r0,#0x19	; 02323282
	lsr r0,r0,#0x1f	; 02323284
	cmp r0,#0x0	; 02323286
	beq loc_0232328E	; 02323288
	mov r3,#0x3	; 0232328A
	b loc_02323290	; 0232328C
loc_0232328E:
	mov r3,#0x4	; 0232328E
loc_02323290:
	mov r0,#0x0	; 02323290
	str r0,[sp,#0x0]	; 02323292
	str r4,[sp,#0x4]	; 02323294
	add r0,r5,#0x0	; 02323296
	ldr r1,[pool_023232D4]	; 02323298
	ldr r2,[pool_023232D8]	; 0232329A
	bl loc_02323C40	; 0232329C
	mov r0,#0x0	; 023232A0
	str r0,[sp,#0x0]	; 023232A2
	str r4,[sp,#0x4]	; 023232A4
	mov r0,#0xf	; 023232A6
	str r0,[sp,#0x8]	; 023232A8
	add r0,r5,#0x0	; 023232AA
	ldr r1,[pool_023232D4]	; 023232AC
	ldr r2,[pool_023232D8]	; 023232AE
	mov r3,#0x1	; 023232B0
	bl loc_02323BEC	; 023232B2
loc_023232B6:
	add sp,#0x24	; 023232B6
	pop {r4,r5}	; 023232B8
	pop {r3}	; 023232BA
	bx r3	; 023232BC
	.byte 0xC0, 0x46	; 023232C0
pool_023232C0:
loc_023232C0:
	.word P1_BssStart + 0x15FC	; 023232C0
pool_023232C4:
loc_023232C4:
	.word P1_BssStart + 0x1578	; 023232C4
pool_023232C8:
loc_023232C8:
	.word 0x02331FFC	; 023232C8
pool_023232CC:
loc_023232CC:
	.word 0x02332028	; 023232CC
pool_023232D0:
loc_023232D0:
	.word 0x02332054	; 023232D0
pool_023232D4:
loc_023232D4:
	.word 0x023C1178	; 023232D4
pool_023232D8:
loc_023232D8:
	.word 0x023A580C	; 023232D8
pool_023232DC:
loc_023232DC:
	.word P1_Data_023306F8	; 023232DC
pool_023232E0:
loc_023232E0:
	.word P1_BssStart + 0x1574	; 023232E0
pool_023232E4:
loc_023232E4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023232E4

; ===== function loc_023232E8 =====
loc_023232E8:
	push {lr}	; 023232E8
	sub sp,#0x4	; 023232EA
	bl loc_02324C88	; 023232EC
	ldr r1,[pool_02323328]	; 023232F0
	ldr r2,[pool_0232332C]	; 023232F2
	mov r3,#0x81	; 023232F4
	bl loc_02324BF8	; 023232F6
	bl loc_02324C88	; 023232FA
	ldr r1,[pool_02323330]	; 023232FE
	ldr r2,[pool_0232332C]	; 02323300
	mov r3,#0x6c	; 02323302
	bl loc_02324BF8	; 02323304
	bl loc_02324C88	; 02323308
	ldr r1,[pool_02323334]	; 0232330C
	ldr r2,[pool_0232332C]	; 0232330E
	mov r3,#0x6d	; 02323310
	bl loc_02324BF8	; 02323312
	mov r1,#0x0	; 02323316
	ldr r0,[pool_02323338]	; 02323318
	str r1,[r0,#0x4]	; 0232331A
	str r1,[r0,#0x8]	; 0232331C
	bl loc_02323344	; 0232331E
	add sp,#0x4	; 02323322
	pop {r3}	; 02323324
	bx r3	; 02323326
pool_02323328:
loc_02323328:
	.word 0x02332054	; 02323328
pool_0232332C:
loc_0232332C:
	.word 0x023A641C	; 0232332C
pool_02323330:
loc_02323330:
	.word 0x02331FFC	; 02323330
pool_02323334:
loc_02323334:
	.word 0x02332028	; 02323334
pool_02323338:
loc_02323338:
	.word P1_BssStart + 0x15FC	; 02323338

; ===== function loc_0232333C =====
loc_0232333C:
	ldr r3,[pool_02323340]	; 0232333C
	bx r3	; 0232333E
pool_02323340:
loc_02323340:
	.word loc_023230FC + 1	; 02323340

; ===== function loc_02323344 =====
loc_02323344:
	push {lr}	; 02323344
	sub sp,#0x4	; 02323346
	bl loc_02326474	; 02323348
	add r1,r0,#0x0	; 0232334C
	ldr r0,[pool_0232335C]	; 0232334E
	bl loc_02324B44	; 02323350
	add sp,#0x4	; 02323354
	pop {r3}	; 02323356
	bx r3	; 02323358
	.byte 0xC0, 0x46	; 0232335C
pool_0232335C:
loc_0232335C:
	.word 0x02332054	; 0232335C

; ===== function loc_02323360 =====
loc_02323360:
	mov r1,#0x1	; 02323360
	ldr r0,[pool_02323368]	; 02323362
	str r1,[r0,#0x8]	; 02323364
	bx lr	; 02323366
pool_02323368:
loc_02323368:
	.word P1_BssStart + 0x15FC	; 02323368

; ===== function loc_0232336C =====
loc_0232336C:
	ldr r3,[pool_02323370]	; 0232336C
	bx r3	; 0232336E
pool_02323370:
loc_02323370:
	.word loc_023232E8 + 1	; 02323370

; ===== function loc_02323374 =====
loc_02323374:
	push {r4,lr}	; 02323374
	ldr r1,[pool_0232339C]	; 02323376
	mov r0,#0x4	; 02323378
	ldrsh r4,[r1,r0]	; 0232337A
	sub r4,#0xf	; 0232337C
	bl loc_023233A0	; 0232337E
	mov r1,#0xc	; 02323382
	mul r0,r1	; 02323384
	mul r4,r0	; 02323386
	add r0,r4,#0x0	; 02323388
	ldr r2,[pool_0232339C]	; 0232338A
	mov r1,#0x6	; 0232338C
	ldrsh r1,[r2,r1]	; 0232338E
	sub r1,#0xf	; 02323390
	blx P1_SignedDivMod	; 02323392
	pop {r4}	; 02323396
	pop {r3}	; 02323398
	bx r3	; 0232339A
pool_0232339C:
loc_0232339C:
	.word P1_BssStart + 0x1608	; 0232339C

; ===== function loc_023233A0 =====
loc_023233A0:
	push {lr}	; 023233A0
	sub sp,#0x4	; 023233A2
	ldr r0,[pool_023233BC]	; 023233A4
	ldr r0,[r0,#0x20]	; 023233A6
	add r0,r0,#0x1	; 023233A8
	mov r1,#0x3	; 023233AA
	blx P1_SignedDivMod	; 023233AC
	cmp r0,#0x0	; 023233B0
	bne loc_023233B6	; 023233B2
	mov r0,#0x1	; 023233B4
loc_023233B6:
	add sp,#0x4	; 023233B6
	pop {r3}	; 023233B8
	bx r3	; 023233BA
pool_023233BC:
loc_023233BC:
	.word P1_BssStart + 0x1888	; 023233BC

; ===== function loc_023233C0 =====
loc_023233C0:
	push {r4,r5,lr}	; 023233C0
	sub sp,#0x1c	; 023233C2
	add r5,r0,#0x0	; 023233C4
	add r4,r1,#0x0	; 023233C6
	cmp r5,#0xf	; 023233C8
	bge loc_02323418	; 023233CA
	add r0,sp,#0x0	; 023233CC
	add r1,r4,#0x2	; 023233CE
	ldrb r2,[r4,#0x1]	; 023233D0
	bl P1_Utf16StrNCpy	; 023233D2
	mov r2,#0x0	; 023233D6
	ldrb r0,[r4,#0x1]	; 023233D8
	lsl r0,r0,#0x1	; 023233DA
	add r1,sp,#0x0	; 023233DC
	strh r2,[r1,r0]	; 023233DE
	ldr r3,[pool_02323420]	; 023233E0
	mov r0,#0x2c	; 023233E2
	add r2,r5,#0x0	; 023233E4
	mul r2,r0	; 023233E6
	add r0,r3,r2	; 023233E8
	add r2,r5,#0x1	; 023233EA
	bl loc_02324B1C	; 023233EC
	ldr r0,[pool_02323424]	; 023233F0
	mov r1,#0x3	; 023233F2
	bl loc_02329198	; 023233F4
	ldrb r1,[r0,#0x6]	; 023233F8
	ldr r0,[pool_02323428]	; 023233FA
	ldrb r2,[r4,#0x0]	; 023233FC
	lsl r2,r2,#0x1c	; 023233FE
	lsr r2,r2,#0x1c	; 02323400
	lsl r2,r2,#0x5	; 02323402
	add r2,r0,r2	; 02323404
	lsl r0,r1,#0x1	; 02323406
	add r0,r2,r0	; 02323408
	add r1,r5,#0x1	; 0232340A
	lsl r2,r1,#0x1	; 0232340C
	ldr r1,[pool_0232342C]	; 0232340E
	add r1,r2,r1	; 02323410
	mov r2,#0x2	; 02323412
	bl loc_0232DCD0	; 02323414
loc_02323418:
	add sp,#0x1c	; 02323418
	pop {r4,r5}	; 0232341A
	pop {r3}	; 0232341C
	bx r3	; 0232341E
pool_02323420:
loc_02323420:
	.word 0x02332094	; 02323420
pool_02323424:
loc_02323424:
	.word 0x023A6174	; 02323424
pool_02323428:
loc_02323428:
	.word 0x023BC9C0	; 02323428
pool_0232342C:
loc_0232342C:
	.word 0x000001C0	; 0232342C

; ===== function loc_02323430 =====
loc_02323430:
	push {r4,r5,r6,r7,lr}	; 02323430
	sub sp,#0x14	; 02323432
	bl loc_023233A0	; 02323434
	ldr r0,[pool_02323530]	; 02323438
	ldr r1,[r0,#0x0]	; 0232343A
	cmp r1,#0x3	; 0232343C
	bhi loc_023234B0	; 0232343E
	add r1,r1,r1	; 02323440
P1_SwitchIndexPC_02323440:
	add r1,pc	; 02323442
	ldrh r1,[r1,#(P1_SwitchTable_02323440 - (P1_SwitchIndexPC_02323440 + 4))]	; 02323444
	lsl r1,r1,#0x10	; 02323446
	asr r1,r1,#0x10	; 02323448
P1_SwitchTargetPC_02323440:
	add r1,pc	; 0232344A
	bx r1	; 0232344C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02323440:
	.halfword (loc_02323456 + 1) - (P1_SwitchTargetPC_02323440 + 4)
	.halfword (loc_02323458 + 1) - (P1_SwitchTargetPC_02323440 + 4)
	.halfword (loc_023234B0 + 1) - (P1_SwitchTargetPC_02323440 + 4)
	.halfword (loc_0232348A + 1) - (P1_SwitchTargetPC_02323440 + 4)
P1_SwitchTable_02323440End:
loc_02323456:
	b loc_02323528	; 02323456
loc_02323458:
	mov r1,#0x4	; 02323458
	ldrsh r2,[r0,r1]	; 0232345A
	mov r1,#0x6	; 0232345C
	ldrsh r1,[r0,r1]	; 0232345E
	cmp r2,r1	; 02323460
	bge loc_02323468	; 02323462
	add r1,r2,#0x1	; 02323464
	strh r1,[r0,#0x4]	; 02323466
loc_02323468:
	bl loc_02322A00	; 02323468
	cmp r0,#0x11	; 0232346C
	beq loc_02323476	; 0232346E
	mov r0,#0x11	; 02323470
	bl loc_02322A0C	; 02323472
loc_02323476:
	ldr r1,[pool_02323530]	; 02323476
	mov r0,#0x4	; 02323478
	ldrsh r2,[r1,r0]	; 0232347A
	mov r0,#0x6	; 0232347C
	ldrsh r0,[r1,r0]	; 0232347E
	cmp r2,r0	; 02323480
	bne loc_023234B0	; 02323482
	mov r0,#0x2	; 02323484
	str r0,[r1,#0x0]	; 02323486
	b loc_023234B0	; 02323488
loc_0232348A:
	mov r1,#0x4	; 0232348A
	ldrsh r2,[r0,r1]	; 0232348C
	cmp r2,#0x0	; 0232348E
	ble loc_023234A2	; 02323490
	sub r2,r2,#0x1	; 02323492
	strh r2,[r0,#0x4]	; 02323494
	ldrsh r0,[r0,r1]	; 02323496
	cmp r0,#0xf	; 02323498
	bne loc_023234A2	; 0232349A
	mov r0,#0xf	; 0232349C
	bl loc_02322A0C	; 0232349E
loc_023234A2:
	ldr r1,[pool_02323530]	; 023234A2
	mov r0,#0x4	; 023234A4
	ldrsh r0,[r1,r0]	; 023234A6
	cmp r0,#0x0	; 023234A8
	bne loc_023234B0	; 023234AA
	mov r0,#0x0	; 023234AC
	str r0,[r1,#0x0]	; 023234AE
loc_023234B0:
	mov r5,#0x0	; 023234B0
	add r4,r5,#0x0	; 023234B2
	b loc_023234FE	; 023234B4
loc_023234B6:
	ldr r3,[pool_02323534]	; 023234B6
	add r2,sp,#0x8	; 023234B8
	ldmia r3!,{r0,r1}	; 023234BA
	stmia r2!,{r0,r1}	; 023234BC
	ldr r0,[r3,#0x0]	; 023234BE
	str r0,[r2,#0x0]	; 023234C0
	bl loc_023235C8	; 023234C2
	add r7,r0,#0x0	; 023234C6
	add r0,r5,#0x0	; 023234C8
	mov r1,#0x3	; 023234CA
	blx P1_SignedDivMod	; 023234CC
	add r6,r1,#0x0	; 023234D0
	add r0,r5,#0x0	; 023234D2
	mov r1,#0x3	; 023234D4
	blx P1_SignedDivMod	; 023234D6
	add r2,r0,#0x0	; 023234DA
	str r4,[sp,#0x0]	; 023234DC
	add r0,r5,#0x0	; 023234DE
	mov r1,#0x2c	; 023234E0
	mul r0,r1	; 023234E2
	ldr r1,[pool_02323538]	; 023234E4
	add r0,r1,r0	; 023234E6
	lsl r3,r6,#0x2	; 023234E8
	add r1,sp,#0x8	; 023234EA
	ldr r1,[r1,r3]	; 023234EC
	mov r3,#0xc	; 023234EE
	mul r2,r3	; 023234F0
	sub r3,r3,r7	; 023234F2
	add r2,r2,r3	; 023234F4
	add r3,r4,#0x0	; 023234F6
	bl loc_02323780	; 023234F8
	add r5,r5,#0x1	; 023234FC
loc_023234FE:
	ldr r0,[pool_0232353C]	; 023234FE
	ldr r0,[r0,#0x20]	; 02323500
	sub r0,r0,#0x1	; 02323502
	cmp r5,r0	; 02323504
	blt loc_023234B6	; 02323506
	bl loc_02323E84	; 02323508
	add r4,r0,#0x0	; 0232350C
	bl loc_023235C8	; 0232350E
	mov r1,#0x0	; 02323512
	str r1,[sp,#0x0]	; 02323514
	mov r1,#0xc	; 02323516
	sub r0,r1,r0	; 02323518
	str r0,[sp,#0x4]	; 0232351A
	add r0,r4,#0x0	; 0232351C
	ldr r1,[pool_02323540]	; 0232351E
	ldr r2,[pool_02323544]	; 02323520
	mov r3,#0x11	; 02323522
	bl loc_02323C40	; 02323524
loc_02323528:
	add sp,#0x14	; 02323528
	pop {r4,r5,r6,r7}	; 0232352A
	pop {r3}	; 0232352C
	bx r3	; 0232352E
pool_02323530:
loc_02323530:
	.word P1_BssStart + 0x1608	; 02323530
pool_02323534:
loc_02323534:
	.word 0x023306FC	; 02323534
pool_02323538:
loc_02323538:
	.word 0x02332094	; 02323538
pool_0232353C:
loc_0232353C:
	.word P1_BssStart + 0x1888	; 0232353C
pool_02323540:
loc_02323540:
	.word 0x023C1178	; 02323540
pool_02323544:
loc_02323544:
	.word 0x023A526C	; 02323544

; ===== function loc_02323548 =====
loc_02323548:
	mov r1,#0x3	; 02323548
	ldr r0,[pool_02323550]	; 0232354A
	str r1,[r0,#0x0]	; 0232354C
	bx lr	; 0232354E
pool_02323550:
loc_02323550:
	.word P1_BssStart + 0x1608	; 02323550

; ===== function loc_02323554 =====
loc_02323554:
	push {r4,r5,r6,r7,lr}	; 02323554
	sub sp,#0x4	; 02323556
	add r5,r0,#0x0	; 02323558
	ldr r0,[pool_023235B4]	; 0232355A
	str r5,[r0,#0x8]	; 0232355C
	mov r1,#0x1	; 0232355E
	str r1,[r0,#0x0]	; 02323560
	mov r4,#0x0	; 02323562
	add r6,r4,#0x0	; 02323564
	ldr r7,[pool_023235B8]	; 02323566
loc_02323568:
	ldrh r1,[r5,r7]	; 02323568
	mov r0,#0x2	; 0232356A
	lsl r0,r4	; 0232356C
	and r1,r0	; 0232356E
	cmp r1,#0x0	; 02323570
	beq loc_02323588	; 02323572
	add r0,r6,#0x0	; 02323574
	ldr r1,[pool_023235BC]	; 02323576
	add r3,r5,r1	; 02323578
	add r2,r4,#0x0	; 0232357A
	mov r1,#0x16	; 0232357C
	mul r2,r1	; 0232357E
	add r1,r3,r2	; 02323580
	bl loc_023233C0	; 02323582
	add r6,r6,#0x1	; 02323586
loc_02323588:
	add r4,r4,#0x1	; 02323588
	cmp r4,#0xf	; 0232358A
	blt loc_02323568	; 0232358C
	ldr r0,[pool_023235C0]	; 0232358E
	ldrb r1,[r5,r0]	; 02323590
	ldr r0,[pool_023235C4]	; 02323592
	str r1,[r0,#0x20]	; 02323594
	mov r1,#0x0	; 02323596
	ldr r0,[pool_023235B4]	; 02323598
	strh r1,[r0,#0x4]	; 0232359A
	bl loc_023233A0	; 0232359C
	mov r1,#0x3	; 023235A0
	mul r0,r1	; 023235A2
	add r0,#0xf	; 023235A4
	ldr r1,[pool_023235B4]	; 023235A6
	strh r0,[r1,#0x6]	; 023235A8
	add sp,#0x4	; 023235AA
	pop {r4,r5,r6,r7}	; 023235AC
	pop {r3}	; 023235AE
	bx r3	; 023235B0
	.byte 0xC0, 0x46	; 023235B4
pool_023235B4:
loc_023235B4:
	.word P1_BssStart + 0x1608	; 023235B4
pool_023235B8:
loc_023235B8:
	.word 0x0000035A	; 023235B8
pool_023235BC:
loc_023235BC:
	.word 0x0000035E	; 023235BC
pool_023235C0:
loc_023235C0:
	.word 0x00000358	; 023235C0
pool_023235C4:
loc_023235C4:
	.word P1_BssStart + 0x1888	; 023235C4

; ===== function loc_023235C8 =====
loc_023235C8:
	push {lr}	; 023235C8
	sub sp,#0x4	; 023235CA
	bl loc_02323374	; 023235CC
	cmp r0,#0x0	; 023235D0
	bge loc_023235D8	; 023235D2
	mov r0,#0x0	; 023235D4
	b loc_023235DC	; 023235D6
loc_023235D8:
	bl loc_02323374	; 023235D8
loc_023235DC:
	add sp,#0x4	; 023235DC
	pop {r3}	; 023235DE
	bx r3	; 023235E0
	.byte 0x00, 0x00	; 023235E4

; ===== function loc_023235E4 =====
loc_023235E4:
	push {r4,r5,r6,r7,lr}	; 023235E4
	sub sp,#0x4	; 023235E6
	ldr r0,[pool_02323624]	; 023235E8
	mov r1,#0x0	; 023235EA
	ldr r2,[pool_02323628]	; 023235EC
	blx loc_0232DEFC	; 023235EE
	mov r5,#0x0	; 023235F2
	ldr r4,[pool_0232362C]	; 023235F4
	ldr r7,[pool_02323630]	; 023235F6
	mov r6,#0x2c	; 023235F8
loc_023235FA:
	bl loc_02324C88	; 023235FA
	add r1,r5,#0x0	; 023235FE
	mul r1,r6	; 02323600
	add r1,r4,r1	; 02323602
	add r2,r7,#0x0	; 02323604
	mov r3,#0x3	; 02323606
	bl loc_02324BD4	; 02323608
	add r5,r5,#0x1	; 0232360C
	cmp r5,#0xf	; 0232360E
	blt loc_023235FA	; 02323610
	mov r1,#0x0	; 02323612
	ldr r0,[pool_02323624]	; 02323614
	str r1,[r0,#0x0]	; 02323616
	mov r1,#0x1e	; 02323618
	strh r1,[r0,#0x6]	; 0232361A
	add sp,#0x4	; 0232361C
	pop {r4,r5,r6,r7}	; 0232361E
	pop {r3}	; 02323620
	bx r3	; 02323622
pool_02323624:
loc_02323624:
	.word P1_BssStart + 0x1608	; 02323624
pool_02323628:
loc_02323628:
	.word 0x000002A4	; 02323628
pool_0232362C:
loc_0232362C:
	.word 0x02332094	; 0232362C
pool_02323630:
loc_02323630:
	.word 0x023A6174	; 02323630

; ===== function loc_02323634 =====
loc_02323634:
	push {r4,r5,r6,lr}	; 02323634
	bl loc_0232E720	; 02323636
	add r6,r0,#0x0	; 0232363A
	mov r5,#0x0	; 0232363C
	add r4,r5,#0x0	; 0232363E
	ldr r0,[pool_02323698]	; 02323640
	ldr r1,[r0,#0x0]	; 02323642
	cmp r1,#0x1e	; 02323644
	bcs loc_0232364C	; 02323646
	add r1,r1,#0x1	; 02323648
	str r1,[r0,#0x0]	; 0232364A
loc_0232364C:
	ldr r0,[pool_02323698]	; 0232364C
	ldr r0,[r0,#0x0]	; 0232364E
	cmp r0,#0x1e	; 02323650
	bcc loc_02323692	; 02323652
	b loc_02323660	; 02323654
loc_02323656:
	add r0,r4,#0x0	; 02323656
	bl loc_0232A240	; 02323658
	add r4,r4,#0x1	; 0232365C
	add r5,r5,r0	; 0232365E
loc_02323660:
	cmp r5,#0x0	; 02323660
	bne loc_02323668	; 02323662
	cmp r4,#0x10	; 02323664
	bcc loc_02323656	; 02323666
loc_02323668:
	ldr r0,[pool_0232369C]	; 02323668
	and r6,r0	; 0232366A
	cmp r6,#0x0	; 0232366C
	bne loc_0232368C	; 0232366E
	cmp r5,#0x0	; 02323670
	bne loc_0232368C	; 02323672
	ldr r0,[pool_02323698]	; 02323674
	ldr r1,[r0,#0x0]	; 02323676
	add r1,r1,#0x1	; 02323678
	str r1,[r0,#0x0]	; 0232367A
	cmp r1,#0x28	; 0232367C
	bcc loc_02323692	; 0232367E
	bl loc_023236D0	; 02323680
	mov r1,#0x0	; 02323684
	ldr r0,[pool_02323698]	; 02323686
	str r1,[r0,#0x0]	; 02323688
	b loc_02323692	; 0232368A
loc_0232368C:
	mov r1,#0x1e	; 0232368C
	ldr r0,[pool_02323698]	; 0232368E
	str r1,[r0,#0x0]	; 02323690
loc_02323692:
	pop {r4,r5,r6}	; 02323692
	pop {r3}	; 02323694
	bx r3	; 02323696
pool_02323698:
loc_02323698:
	.word P1_BssStart + 0x18B0	; 02323698
pool_0232369C:
loc_0232369C:
	.word 0x0000FFF5	; 0232369C

; ===== function loc_023236A0 =====
loc_023236A0:
	push {lr}	; 023236A0
	sub sp,#0x4	; 023236A2
	ldr r0,[pool_023236B8]	; 023236A4
	ldr r0,[r0,#0x0]	; 023236A6
	cmp r0,#0x1	; 023236A8
	bne loc_023236B0	; 023236AA
	bl loc_02323634	; 023236AC
loc_023236B0:
	add sp,#0x4	; 023236B0
	pop {r3}	; 023236B2
	bx r3	; 023236B4
	.byte 0xC0, 0x46	; 023236B8
pool_023236B8:
loc_023236B8:
	.word P1_BssStart + 0x18B4	; 023236B8
	.byte 0x02, 0x21, 0x02, 0x48, 0x01, 0x60, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0x34, 0x23, 0x33, 0x02	; 023236CC
	.byte 0x25, 0x94, 0x32, 0x02	; 023236D0

; ===== function loc_023236D0 =====
loc_023236D0:
	push {lr}	; 023236D0
	sub sp,#0x4	; 023236D2
	bl loc_02329424	; 023236D4
	ldr r0,[pool_023236F4]	; 023236D8
	ldr r1,[pool_023236F8]	; 023236DA
	mov r2,#0x1	; 023236DC
	bl loc_02329444	; 023236DE
	ldr r0,[pool_023236FC]	; 023236E2
	ldr r1,[r0,#0x0]	; 023236E4
	cmp r1,#0x0	; 023236E6
	bne loc_023236EE	; 023236E8
	mov r1,#0x1	; 023236EA
	str r1,[r0,#0x0]	; 023236EC
loc_023236EE:
	add sp,#0x4	; 023236EE
	pop {r3}	; 023236F0
	bx r3	; 023236F2
pool_023236F4:
loc_023236F4:
	.word 0x023323C0	; 023236F4
pool_023236F8:
loc_023236F8:
	.word 0x00001000	; 023236F8
pool_023236FC:
loc_023236FC:
	.word P1_BssStart + 0x18B4	; 023236FC

; ===== function loc_02323700 =====
loc_02323700:
	mov r1,#0x0	; 02323700
	ldr r3,[pool_02323708]	; 02323702
	bx r3	; 02323704
	.byte 0xC0, 0x46	; 02323708
pool_02323708:
loc_02323708:
	.word loc_0232A268 + 1	; 02323708

; ===== function loc_0232370C =====
loc_0232370C:
	add r2,r0,#0x0	; 0232370C
	add r0,r1,#0x0	; 0232370E
	mov r1,#0x0	; 02323710
	ldr r3,[pool_02323718]	; 02323712
	bx r3	; 02323714
	.byte 0xC0, 0x46	; 02323718
pool_02323718:
loc_02323718:
	.word loc_0232AE6C + 1	; 02323718
loc_0232371C:
	ldr r3,[pool_02323720]	; 0232371C
	bx r3	; 0232371E
pool_02323720:
loc_02323720:
	.word loc_0232A260 + 1	; 02323720

; ===== function loc_02323724 =====
loc_02323724:
	add r2,r0,#0x0	; 02323724
	ldr r0,[pool_02323730]	; 02323726
	mov r1,#0x0	; 02323728
	ldr r3,[pool_02323734]	; 0232372A
	bx r3	; 0232372C
	.byte 0xC0, 0x46	; 02323730
pool_02323730:
loc_02323730:
	.word 0x0233232C	; 02323730
pool_02323734:
loc_02323734:
	.word loc_0232AE6C + 1	; 02323734

; ===== function loc_02323738 =====
loc_02323738:
	ldr r3,[pool_0232373C]	; 02323738
	bx r3	; 0232373A
pool_0232373C:
loc_0232373C:
	.word loc_02329D74 + 1	; 0232373C

; ===== function loc_02323740 =====
loc_02323740:
	push {lr}	; 02323740
	sub sp,#0x4	; 02323742
	bl loc_02329D98	; 02323744
	ldr r0,[pool_0232376C]	; 02323748
	ldr r1,[pool_02323770]	; 0232374A
	mov r2,#0x1	; 0232374C
	bl loc_02329444	; 0232374E
	ldr r0,[pool_02323774]	; 02323752
	ldr r1,[pool_02323778]	; 02323754
	bl loc_0232AAB8	; 02323756
	mov r0,#0x0	; 0232375A
	bl loc_0232AED4	; 0232375C
	ldr r0,[pool_0232377C]	; 02323760
	bl loc_0232A260	; 02323762
	add sp,#0x4	; 02323766
	pop {r3}	; 02323768
	bx r3	; 0232376A
pool_0232376C:
loc_0232376C:
	.word 0x023323C0	; 0232376C
pool_02323770:
loc_02323770:
	.word 0x00001000	; 02323770
pool_02323774:
loc_02323774:
	.word 0x02332338	; 02323774
pool_02323778:
loc_02323778:
	.word 0x023ABA78	; 02323778
pool_0232377C:
loc_0232377C:
	.word 0x0233232C	; 0232377C

; ===== function loc_02323780 =====
loc_02323780:
	push {r4,r5,r6,r7,lr}	; 02323780
	sub sp,#0x2c	; 02323782
	add r5,r0,#0x0	; 02323784
	str r1,[sp,#0x0]	; 02323786
	str r2,[sp,#0x4]	; 02323788
	add r6,r3,#0x0	; 0232378A
	ldr r0,[r5,#0x24]	; 0232378C
	ldrh r0,[r0,#0x10]	; 0232378E
	cmp r0,#0x0	; 02323790
	beq loc_0232379C	; 02323792
	bl loc_02323E84	; 02323794
	str r0,[sp,#0x8]	; 02323798
	b loc_023237A2	; 0232379A
loc_0232379C:
	bl loc_02323E7C	; 0232379C
	str r0,[sp,#0x8]	; 023237A0
loc_023237A2:
	ldr r0,[r5,#0x10]	; 023237A2
	bl loc_023238E0	; 023237A4
	mov r1,#0x4	; 023237A8
	blx P1_SignedDivMod	; 023237AA
	str r0,[sp,#0xc]	; 023237AE
	mov r4,#0x0	; 023237B0
	ldr r0,[sp,#0x40]	; 023237B2
	lsl r0,r0,#0xa	; 023237B4
	str r0,[sp,#0x18]	; 023237B6
	lsl r0,r6,#0xa	; 023237B8
	str r0,[sp,#0x1c]	; 023237BA
	str r4,[sp,#0x20]	; 023237BC
	b loc_0232381E	; 023237BE
loc_023237C0:
	ldrh r0,[r5,#0x16]	; 023237C0
	str r0,[sp,#0x14]	; 023237C2
	ldrh r1,[r5,#0x14]	; 023237C4
	ldr r0,[sp,#0xc]	; 023237C6
	mul r0,r4	; 023237C8
	add r0,r1,r0	; 023237CA
	str r0,[sp,#0x10]	; 023237CC
	ldr r7,[r5,#0x10]	; 023237CE
	mov r0,#0xa	; 023237D0
	ldrsh r1,[r5,r0]	; 023237D2
	ldr r0,[sp,#0x4]	; 023237D4
	add r6,r1,r0	; 023237D6
	add r0,r7,#0x0	; 023237D8
	bl loc_02323830	; 023237DA
	mov r1,#0x8	; 023237DE
	ldrsh r2,[r5,r1]	; 023237E0
	ldr r1,[sp,#0x0]	; 023237E2
	add r2,r2,r1	; 023237E4
	add r1,r4,#0x0	; 023237E6
	mul r1,r0	; 023237E8
	add r1,r2,r1	; 023237EA
	ldr r0,[pool_0232382C]	; 023237EC
	and r1,r0	; 023237EE
	lsl r1,r1,#0x10	; 023237F0
	mov r0,#0xff	; 023237F2
	and r6,r0	; 023237F4
	ldr r0,[sp,#0x18]	; 023237F6
	orr r6,r0	; 023237F8
	orr r7,r6	; 023237FA
	orr r1,r7	; 023237FC
	str r1,[sp,#0x24]	; 023237FE
	ldr r0,[sp,#0x14]	; 02323800
	lsl r2,r0,#0xc	; 02323802
	ldr r1,[sp,#0x10]	; 02323804
	ldr r0,[sp,#0x1c]	; 02323806
	orr r1,r0	; 02323808
	str r1,[sp,#0x10]	; 0232380A
	orr r2,r1	; 0232380C
	add r0,sp,#0x24	; 0232380E
	strh r2,[r0,#0x4]	; 02323810
	ldr r0,[sp,#0x8]	; 02323812
	add r1,sp,#0x24	; 02323814
	ldr r2,[sp,#0x20]	; 02323816
	bl loc_023239A0	; 02323818
	add r4,r4,#0x1	; 0232381C
loc_0232381E:
	ldrh r0,[r5,#0x18]	; 0232381E
	cmp r4,r0	; 02323820
	blt loc_023237C0	; 02323822
	add sp,#0x2c	; 02323824
	pop {r4,r5,r6,r7}	; 02323826
	pop {r3}	; 02323828
	bx r3	; 0232382A
pool_0232382C:
loc_0232382C:
	.word 0x000001FF	; 0232382C

; ===== function loc_02323830 =====
loc_02323830:
	ldr r1,[pool_023238B4]	; 02323830
	cmp r0,r1	; 02323832
	bgt loc_0232386C	; 02323834
	cmp r0,r1	; 02323836
	bge loc_023238A8	; 02323838
	ldr r1,[pool_023238B8]	; 0232383A
	cmp r0,r1	; 0232383C
	bgt loc_02323858	; 0232383E
	cmp r0,r1	; 02323840
	bge loc_023238A4	; 02323842
	ldr r1,[pool_023238BC]	; 02323844
	cmp r0,r1	; 02323846
	bgt loc_02323850	; 02323848
	cmp r0,r1	; 0232384A
	beq loc_023238A8	; 0232384C
	b loc_023238B0	; 0232384E
loc_02323850:
	ldr r1,[pool_023238C0]	; 02323850
	cmp r0,r1	; 02323852
	beq loc_023238A8	; 02323854
	b loc_023238B0	; 02323856
loc_02323858:
	ldr r1,[pool_023238C4]	; 02323858
	cmp r0,r1	; 0232385A
	bgt loc_02323864	; 0232385C
	cmp r0,r1	; 0232385E
	beq loc_023238AC	; 02323860
	b loc_023238B0	; 02323862
loc_02323864:
	ldr r1,[pool_023238C8]	; 02323864
	cmp r0,r1	; 02323866
	beq loc_023238AC	; 02323868
	b loc_023238B0	; 0232386A
loc_0232386C:
	ldr r1,[pool_023238CC]	; 0232386C
	cmp r0,r1	; 0232386E
	bgt loc_02323888	; 02323870
	cmp r0,r1	; 02323872
	bge loc_023238A0	; 02323874
	cmp r0,#0x0	; 02323876
	bgt loc_02323880	; 02323878
	cmp r0,#0x0	; 0232387A
	beq loc_023238A0	; 0232387C
	b loc_023238B0	; 0232387E
loc_02323880:
	ldr r1,[pool_023238D0]	; 02323880
	cmp r0,r1	; 02323882
	beq loc_023238A4	; 02323884
	b loc_023238B0	; 02323886
loc_02323888:
	ldr r1,[pool_023238D4]	; 02323888
	cmp r0,r1	; 0232388A
	bgt loc_0232389A	; 0232388C
	cmp r0,r1	; 0232388E
	bge loc_023238A8	; 02323890
	ldr r1,[pool_023238D8]	; 02323892
	cmp r0,r1	; 02323894
	beq loc_023238A4	; 02323896
	b loc_023238B0	; 02323898
loc_0232389A:
	ldr r1,[pool_023238DC]	; 0232389A
	cmp r0,r1	; 0232389C
	bne loc_023238B0	; 0232389E
loc_023238A0:
	mov r0,#0x8	; 023238A0
	bx lr	; 023238A2
loc_023238A4:
	mov r0,#0x10	; 023238A4
	bx lr	; 023238A6
loc_023238A8:
	mov r0,#0x20	; 023238A8
	bx lr	; 023238AA
loc_023238AC:
	mov r0,#0x40	; 023238AC
	bx lr	; 023238AE
loc_023238B0:
	mov r0,#0x0	; 023238B0
	bx lr	; 023238B2
pool_023238B4:
loc_023238B4:
	.word 0xC0008000	; 023238B4
pool_023238B8:
loc_023238B8:
	.word 0x80008000	; 023238B8
pool_023238BC:
loc_023238BC:
	.word 0x80000000	; 023238BC
pool_023238C0:
loc_023238C0:
	.word 0x80004000	; 023238C0
pool_023238C4:
loc_023238C4:
	.word 0xC0000000	; 023238C4
pool_023238C8:
loc_023238C8:
	.word 0xC0004000	; 023238C8
pool_023238CC:
loc_023238CC:
	.word 0x00008000	; 023238CC
pool_023238D0:
loc_023238D0:
	.word 0x00004000	; 023238D0
pool_023238D4:
loc_023238D4:
	.word 0x40004000	; 023238D4
pool_023238D8:
loc_023238D8:
	.word 0x40000000	; 023238D8
pool_023238DC:
loc_023238DC:
	.word 0x40008000	; 023238DC

; ===== function loc_023238E0 =====
loc_023238E0:
	ldr r1,[pool_02323974]	; 023238E0
	cmp r0,r1	; 023238E2
	bgt loc_0232391C	; 023238E4
	cmp r0,r1	; 023238E6
	bge loc_02323966	; 023238E8
	ldr r1,[pool_02323978]	; 023238EA
	cmp r0,r1	; 023238EC
	bgt loc_02323908	; 023238EE
	cmp r0,r1	; 023238F0
	bge loc_0232395E	; 023238F2
	ldr r1,[pool_0232397C]	; 023238F4
	cmp r0,r1	; 023238F6
	bgt loc_02323900	; 023238F8
	cmp r0,r1	; 023238FA
	beq loc_02323962	; 023238FC
	b loc_0232396E	; 023238FE
loc_02323900:
	ldr r1,[pool_02323980]	; 02323900
	cmp r0,r1	; 02323902
	beq loc_0232395E	; 02323904
	b loc_0232396E	; 02323906
loc_02323908:
	ldr r1,[pool_02323984]	; 02323908
	cmp r0,r1	; 0232390A
	bgt loc_02323914	; 0232390C
	cmp r0,r1	; 0232390E
	beq loc_0232396A	; 02323910
	b loc_0232396E	; 02323912
loc_02323914:
	ldr r1,[pool_02323988]	; 02323914
	cmp r0,r1	; 02323916
	beq loc_02323966	; 02323918
	b loc_0232396E	; 0232391A
loc_0232391C:
	ldr r1,[pool_0232398C]	; 0232391C
	cmp r0,r1	; 0232391E
	bgt loc_02323938	; 02323920
	cmp r0,r1	; 02323922
	bge loc_02323956	; 02323924
	cmp r0,#0x0	; 02323926
	bgt loc_02323930	; 02323928
	cmp r0,#0x0	; 0232392A
	beq loc_02323952	; 0232392C
	b loc_0232396E	; 0232392E
loc_02323930:
	ldr r1,[pool_02323990]	; 02323930
	cmp r0,r1	; 02323932
	beq loc_02323956	; 02323934
	b loc_0232396E	; 02323936
loc_02323938:
	ldr r1,[pool_02323994]	; 02323938
	cmp r0,r1	; 0232393A
	bgt loc_0232394A	; 0232393C
	cmp r0,r1	; 0232393E
	bge loc_0232395A	; 02323940
	ldr r1,[pool_02323998]	; 02323942
	cmp r0,r1	; 02323944
	beq loc_0232395A	; 02323946
	b loc_0232396E	; 02323948
loc_0232394A:
	ldr r1,[pool_0232399C]	; 0232394A
	cmp r0,r1	; 0232394C
	beq loc_0232395A	; 0232394E
	b loc_0232396E	; 02323950
loc_02323952:
	mov r0,#0x1	; 02323952
	bx lr	; 02323954
loc_02323956:
	mov r0,#0x2	; 02323956
	bx lr	; 02323958
loc_0232395A:
	mov r0,#0x4	; 0232395A
	bx lr	; 0232395C
loc_0232395E:
	mov r0,#0x8	; 0232395E
	bx lr	; 02323960
loc_02323962:
	mov r0,#0x10	; 02323962
	bx lr	; 02323964
loc_02323966:
	mov r0,#0x20	; 02323966
	bx lr	; 02323968
loc_0232396A:
	mov r0,#0x40	; 0232396A
	bx lr	; 0232396C
loc_0232396E:
	mov r0,#0x0	; 0232396E
	bx lr	; 02323970
	.byte 0xC0, 0x46	; 02323974
pool_02323974:
loc_02323974:
	.word 0xC0008000	; 02323974
pool_02323978:
loc_02323978:
	.word 0x80008000	; 02323978
pool_0232397C:
loc_0232397C:
	.word 0x80000000	; 0232397C
pool_02323980:
loc_02323980:
	.word 0x80004000	; 02323980
pool_02323984:
loc_02323984:
	.word 0xC0000000	; 02323984
pool_02323988:
loc_02323988:
	.word 0xC0004000	; 02323988
pool_0232398C:
loc_0232398C:
	.word 0x00008000	; 0232398C
pool_02323990:
loc_02323990:
	.word 0x00004000	; 02323990
pool_02323994:
loc_02323994:
	.word 0x40004000	; 02323994
pool_02323998:
loc_02323998:
	.word 0x40000000	; 02323998
pool_0232399C:
loc_0232399C:
	.word 0x40008000	; 0232399C

; ===== function loc_023239A0 =====
loc_023239A0:
	push {r4,r5,lr}	; 023239A0
	sub sp,#0x4	; 023239A2
	add r3,r0,#0x0	; 023239A4
	ldr r0,[pool_02323A24]	; 023239A6
	ldr r4,[r3,r0]	; 023239A8
	cmp r4,#0x7f	; 023239AA
	bne loc_023239B2	; 023239AC
	mov r0,#0x0	; 023239AE
	b loc_02323A1C	; 023239B0
loc_023239B2:
	cmp r2,#0x0	; 023239B2
	beq loc_023239C2	; 023239B4
	ldr r0,[pool_02323A28]	; 023239B6
	ldr r0,[r3,r0]	; 023239B8
	cmp r0,#0x1f	; 023239BA
	bne loc_023239C2	; 023239BC
	mov r0,#0x0	; 023239BE
	b loc_02323A1C	; 023239C0
loc_023239C2:
	lsl r5,r4,#0x3	; 023239C2
	add r0,r3,r5	; 023239C4
	ldr r4,[r1,#0x0]	; 023239C6
	ldr r1,[r1,#0x4]	; 023239C8
	str r4,[r3,r5]	; 023239CA
	str r1,[r0,#0x4]	; 023239CC
	cmp r2,#0x0	; 023239CE
	beq loc_023239D8	; 023239D0
	ldr r0,[pool_02323A28]	; 023239D2
	ldr r0,[r3,r0]	; 023239D4
	b loc_023239DA	; 023239D6
loc_023239D8:
	mov r0,#0x0	; 023239D8
loc_023239DA:
	ldr r1,[pool_02323A24]	; 023239DA
	ldr r1,[r3,r1]	; 023239DC
	lsl r5,r1,#0x3	; 023239DE
	ldr r4,[r3,r5]	; 023239E0
	ldr r1,[pool_02323A2C]	; 023239E2
	and r4,r1	; 023239E4
	mov r1,#0x1f	; 023239E6
	and r0,r1	; 023239E8
	lsl r0,r0,#0x19	; 023239EA
	orr r4,r0	; 023239EC
	str r4,[r3,r5]	; 023239EE
	cmp r2,#0x0	; 023239F0
	beq loc_02323A10	; 023239F2
	ldr r0,[pool_02323A28]	; 023239F4
	add r4,r3,r0	; 023239F6
	ldr r0,[r4,#0x0]	; 023239F8
	lsl r0,r0,#0x4	; 023239FA
	add r1,r3,r0	; 023239FC
	ldr r0,[pool_02323A30]	; 023239FE
	add r5,r1,r0	; 02323A00
	ldmia r2!,{r0,r1}	; 02323A02
	stmia r5!,{r0,r1}	; 02323A04
	ldmia r2!,{r0,r1}	; 02323A06
	stmia r5!,{r0,r1}	; 02323A08
	ldr r0,[r4,#0x0]	; 02323A0A
	add r0,r0,#0x1	; 02323A0C
	str r0,[r4,#0x0]	; 02323A0E
loc_02323A10:
	ldr r0,[pool_02323A24]	; 02323A10
	add r0,r3,r0	; 02323A12
	ldr r1,[r0,#0x0]	; 02323A14
	add r1,r1,#0x1	; 02323A16
	str r1,[r0,#0x0]	; 02323A18
	mov r0,#0x1	; 02323A1A
loc_02323A1C:
	add sp,#0x4	; 02323A1C
	pop {r4,r5}	; 02323A1E
	pop {r3}	; 02323A20
	bx r3	; 02323A22
pool_02323A24:
loc_02323A24:
	.word 0x00000600	; 02323A24
pool_02323A28:
loc_02323A28:
	.word 0x00000604	; 02323A28
pool_02323A2C:
loc_02323A2C:
	.word 0xC1FFFFFF	; 02323A2C
pool_02323A30:
loc_02323A30:
	.word 0x00000400	; 02323A30

; ===== function loc_02323A34 =====
loc_02323A34:
	push {r4,lr}	; 02323A34
	sub sp,#0x18	; 02323A36
	add r4,r0,#0x0	; 02323A38
	ldr r0,[sp,#0x20]	; 02323A3A
	str r0,[sp,#0x0]	; 02323A3C
	ldr r0,[sp,#0x24]	; 02323A3E
	str r0,[sp,#0x4]	; 02323A40
	ldr r0,[sp,#0x28]	; 02323A42
	str r0,[sp,#0x8]	; 02323A44
	ldr r0,[sp,#0x2c]	; 02323A46
	str r0,[sp,#0xc]	; 02323A48
	ldr r0,[sp,#0x30]	; 02323A4A
	str r0,[sp,#0x10]	; 02323A4C
	add r0,r1,#0x0	; 02323A4E
	add r1,r2,#0x0	; 02323A50
	add r2,r4,#0x0	; 02323A52
	bl loc_02323CEC	; 02323A54
	add sp,#0x18	; 02323A58
	pop {r4}	; 02323A5A
	pop {r3}	; 02323A5C
	bx r3	; 02323A5E

; ===== function loc_02323A60 =====
P1_Entry_02323A60:
	push {r4,lr}	; 02323A60
	sub sp,#0x18	; 02323A62
	add r4,r0,#0x0	; 02323A64
	ldr r0,[sp,#0x20]	; 02323A66
	str r0,[sp,#0x0]	; 02323A68
	ldr r0,[sp,#0x24]	; 02323A6A
	str r0,[sp,#0x4]	; 02323A6C
	mov r0,#0x0	; 02323A6E
	mvn r0,r0	; 02323A70
	str r0,[sp,#0x8]	; 02323A72
	ldr r0,[sp,#0x28]	; 02323A74
	str r0,[sp,#0xc]	; 02323A76
	ldr r0,[sp,#0x2c]	; 02323A78
	str r0,[sp,#0x10]	; 02323A7A
	add r0,r1,#0x0	; 02323A7C
	add r1,r2,#0x0	; 02323A7E
	add r2,r4,#0x0	; 02323A80
	bl loc_02323CEC	; 02323A82
	add sp,#0x18	; 02323A86
	pop {r4}	; 02323A88
	pop {r3}	; 02323A8A
	bx r3	; 02323A8C
	.byte 0x00, 0x00, 0x10, 0xB5, 0x86, 0xB0, 0x04, 0x1C, 0x08, 0x98, 0x00, 0x90, 0x09, 0x98, 0x01, 0x90	; 02323A9E
	.byte 0x0A, 0x98, 0x02, 0x90, 0x00, 0x20, 0xC0, 0x43, 0x03, 0x90, 0x0B, 0x98, 0x04, 0x90, 0x08, 0x1C	; 02323AAE
	.byte 0x11, 0x1C, 0x22, 0x1C, 0x00, 0xF0, 0x1B, 0xF9, 0x06, 0xB0, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 02323ABE
	.byte 0x00, 0x00, 0x30, 0xB5, 0x85, 0xB0, 0x04, 0x1C, 0x00, 0x25, 0x00, 0x95, 0x01, 0x95, 0x08, 0x98	; 02323ACE
	.byte 0x02, 0x90, 0xE8, 0x43, 0x03, 0x90, 0x09, 0x98, 0x04, 0x90, 0x08, 0x1C, 0x11, 0x1C, 0x22, 0x1C	; 02323ADE
	.byte 0x00, 0xF0, 0x05, 0xF9, 0x05, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 02323AEC

; ===== function loc_02323AEC =====
loc_02323AEC:
	push {r4,lr}	; 02323AEC
	sub sp,#0x18	; 02323AEE
	add r4,r0,#0x0	; 02323AF0
	ldr r0,[sp,#0x20]	; 02323AF2
	str r0,[sp,#0x0]	; 02323AF4
	ldr r0,[sp,#0x24]	; 02323AF6
	str r0,[sp,#0x4]	; 02323AF8
	mov r0,#0x0	; 02323AFA
	mvn r0,r0	; 02323AFC
	str r0,[sp,#0x8]	; 02323AFE
	str r0,[sp,#0xc]	; 02323B00
	ldr r0,[sp,#0x28]	; 02323B02
	str r0,[sp,#0x10]	; 02323B04
	add r0,r1,#0x0	; 02323B06
	add r1,r2,#0x0	; 02323B08
	add r2,r4,#0x0	; 02323B0A
	bl loc_02323CEC	; 02323B0C
	add sp,#0x18	; 02323B10
	pop {r4}	; 02323B12
	pop {r3}	; 02323B14
	bx r3	; 02323B16

; ===== function loc_02323B18 =====
	push {r4,lr}	; 02323B18
	sub sp,#0x18	; 02323B1A
	add r4,r0,#0x0	; 02323B1C
	mov r0,#0x0	; 02323B1E
	str r0,[sp,#0x0]	; 02323B20
	str r0,[sp,#0x4]	; 02323B22
	mvn r0,r0	; 02323B24
	str r0,[sp,#0x8]	; 02323B26
	str r0,[sp,#0xc]	; 02323B28
	ldr r0,[sp,#0x20]	; 02323B2A
	str r0,[sp,#0x10]	; 02323B2C
	add r0,r1,#0x0	; 02323B2E
	add r1,r2,#0x0	; 02323B30
	add r2,r4,#0x0	; 02323B32
	bl loc_02323CEC	; 02323B34
	add sp,#0x18	; 02323B38
	pop {r4}	; 02323B3A
	pop {r3}	; 02323B3C
	bx r3	; 02323B3E
P1_Entry_02323B40:
	push {r4,lr}	; 02323B40
	sub sp,#0x18	; 02323B42
	add r4,r0,#0x0	; 02323B44
	ldr r0,[sp,#0x20]	; 02323B46
	str r0,[sp,#0x0]	; 02323B48
	ldr r0,[sp,#0x24]	; 02323B4A
	str r0,[sp,#0x4]	; 02323B4C
	ldr r0,[sp,#0x28]	; 02323B4E
	str r0,[sp,#0x8]	; 02323B50
	ldr r0,[sp,#0x2c]	; 02323B52
	str r0,[sp,#0xc]	; 02323B54
	mov r0,#0x0	; 02323B56
	mvn r0,r0	; 02323B58
	str r0,[sp,#0x10]	; 02323B5A
	add r0,r1,#0x0	; 02323B5C
	add r1,r2,#0x0	; 02323B5E
	add r2,r4,#0x0	; 02323B60
	bl loc_02323CEC	; 02323B62
	add sp,#0x18	; 02323B66
	pop {r4}	; 02323B68
	pop {r3}	; 02323B6A
	bx r3	; 02323B6C
	.byte 0x00, 0x00	; 02323B6E

; ===== function loc_02323B70 =====
loc_02323B70:
	push {r4,r5,lr}	; 02323B70
	sub sp,#0x14	; 02323B72
	add r4,r0,#0x0	; 02323B74
	ldr r0,[sp,#0x20]	; 02323B76
	str r0,[sp,#0x0]	; 02323B78
	ldr r0,[sp,#0x24]	; 02323B7A
	str r0,[sp,#0x4]	; 02323B7C
	mov r0,#0x0	; 02323B7E
	mvn r5,r0	; 02323B80
	str r5,[sp,#0x8]	; 02323B82
	ldr r0,[sp,#0x28]	; 02323B84
	str r0,[sp,#0xc]	; 02323B86
	str r5,[sp,#0x10]	; 02323B88
	add r0,r1,#0x0	; 02323B8A
	add r1,r2,#0x0	; 02323B8C
	add r2,r4,#0x0	; 02323B8E
	bl loc_02323CEC	; 02323B90
	add sp,#0x14	; 02323B94
	pop {r4,r5}	; 02323B96
	pop {r3}	; 02323B98
	bx r3	; 02323B9A

; ===== function loc_02323B9C =====
P1_Entry_02323B9C:
	push {r4,r5,lr}	; 02323B9C
	sub sp,#0x14	; 02323B9E
	add r4,r0,#0x0	; 02323BA0
	mov r0,#0x0	; 02323BA2
	str r0,[sp,#0x0]	; 02323BA4
	str r0,[sp,#0x4]	; 02323BA6
	mvn r5,r0	; 02323BA8
	str r5,[sp,#0x8]	; 02323BAA
	ldr r0,[sp,#0x20]	; 02323BAC
	str r0,[sp,#0xc]	; 02323BAE
	str r5,[sp,#0x10]	; 02323BB0
	add r0,r1,#0x0	; 02323BB2
	add r1,r2,#0x0	; 02323BB4
	add r2,r4,#0x0	; 02323BB6
	bl loc_02323CEC	; 02323BB8
	add sp,#0x14	; 02323BBC
	pop {r4,r5}	; 02323BBE
	pop {r3}	; 02323BC0
	bx r3	; 02323BC2

; ===== function loc_02323BC4 =====
loc_02323BC4:
	push {r4,r5,lr}	; 02323BC4
	sub sp,#0x14	; 02323BC6
	add r5,r0,#0x0	; 02323BC8
	mov r4,#0x0	; 02323BCA
	str r4,[sp,#0x0]	; 02323BCC
	mvn r0,r4	; 02323BCE
	str r0,[sp,#0x4]	; 02323BD0
	str r3,[sp,#0x8]	; 02323BD2
	str r0,[sp,#0xc]	; 02323BD4
	add r0,r1,#0x0	; 02323BD6
	add r1,r2,#0x0	; 02323BD8
	add r2,r5,#0x0	; 02323BDA
	add r3,r4,#0x0	; 02323BDC
	bl loc_02323C94	; 02323BDE
	add sp,#0x14	; 02323BE2
	pop {r4,r5}	; 02323BE4
	pop {r3}	; 02323BE6
	bx r3	; 02323BE8
	.byte 0x00, 0x00	; 02323BEC

; ===== function loc_02323BEC =====
loc_02323BEC:
	push {r4,lr}	; 02323BEC
	sub sp,#0x18	; 02323BEE
	add r4,r0,#0x0	; 02323BF0
	ldr r0,[sp,#0x20]	; 02323BF2
	str r0,[sp,#0x0]	; 02323BF4
	ldr r0,[sp,#0x24]	; 02323BF6
	str r0,[sp,#0x4]	; 02323BF8
	ldr r0,[sp,#0x28]	; 02323BFA
	str r0,[sp,#0x8]	; 02323BFC
	mov r0,#0x0	; 02323BFE
	mvn r0,r0	; 02323C00
	str r0,[sp,#0xc]	; 02323C02
	str r0,[sp,#0x10]	; 02323C04
	add r0,r1,#0x0	; 02323C06
	add r1,r2,#0x0	; 02323C08
	add r2,r4,#0x0	; 02323C0A
	bl loc_02323CEC	; 02323C0C
	add sp,#0x18	; 02323C10
	pop {r4}	; 02323C12
	pop {r3}	; 02323C14
	bx r3	; 02323C16

; ===== function loc_02323C18 =====
P1_Entry_02323C18:
	push {r4,r5,lr}	; 02323C18
	sub sp,#0x14	; 02323C1A
	add r4,r0,#0x0	; 02323C1C
	mov r5,#0x0	; 02323C1E
	str r5,[sp,#0x0]	; 02323C20
	str r5,[sp,#0x4]	; 02323C22
	ldr r0,[sp,#0x20]	; 02323C24
	str r0,[sp,#0x8]	; 02323C26
	mvn r0,r5	; 02323C28
	str r0,[sp,#0xc]	; 02323C2A
	str r0,[sp,#0x10]	; 02323C2C
	add r0,r1,#0x0	; 02323C2E
	add r1,r2,#0x0	; 02323C30
	add r2,r4,#0x0	; 02323C32
	bl loc_02323CEC	; 02323C34
	add sp,#0x14	; 02323C38
	pop {r4,r5}	; 02323C3A
	pop {r3}	; 02323C3C
	bx r3	; 02323C3E

; ===== function loc_02323C40 =====
loc_02323C40:
	push {r4,lr}	; 02323C40
	sub sp,#0x18	; 02323C42
	add r4,r0,#0x0	; 02323C44
	ldr r0,[sp,#0x20]	; 02323C46
	str r0,[sp,#0x0]	; 02323C48
	ldr r0,[sp,#0x24]	; 02323C4A
	str r0,[sp,#0x4]	; 02323C4C
	mov r0,#0x0	; 02323C4E
	mvn r0,r0	; 02323C50
	str r0,[sp,#0x8]	; 02323C52
	str r0,[sp,#0xc]	; 02323C54
	str r0,[sp,#0x10]	; 02323C56
	add r0,r1,#0x0	; 02323C58
	add r1,r2,#0x0	; 02323C5A
	add r2,r4,#0x0	; 02323C5C
	bl loc_02323CEC	; 02323C5E
	add sp,#0x18	; 02323C62
	pop {r4}	; 02323C64
	pop {r3}	; 02323C66
	bx r3	; 02323C68
	.byte 0x00, 0x00	; 02323C6C

; ===== function loc_02323C6C =====
loc_02323C6C:
	push {r4,lr}	; 02323C6C
	sub sp,#0x18	; 02323C6E
	add r4,r0,#0x0	; 02323C70
	mov r0,#0x0	; 02323C72
	str r0,[sp,#0x0]	; 02323C74
	str r0,[sp,#0x4]	; 02323C76
	mvn r0,r0	; 02323C78
	str r0,[sp,#0x8]	; 02323C7A
	str r0,[sp,#0xc]	; 02323C7C
	str r0,[sp,#0x10]	; 02323C7E
	add r0,r1,#0x0	; 02323C80
	add r1,r2,#0x0	; 02323C82
	add r2,r4,#0x0	; 02323C84
	bl loc_02323CEC	; 02323C86
	add sp,#0x18	; 02323C8A
	pop {r4}	; 02323C8C
	pop {r3}	; 02323C8E
	bx r3	; 02323C90
	.byte 0x00, 0x00	; 02323C94

; ===== function loc_02323C94 =====
loc_02323C94:
	push {r4,r5,r6,r7,lr}	; 02323C94
	sub sp,#0x24	; 02323C96
	str r0,[sp,#0x14]	; 02323C98
	add r5,r1,#0x0	; 02323C9A
	str r2,[sp,#0x18]	; 02323C9C
	str r3,[sp,#0x1c]	; 02323C9E
	ldr r6,[sp,#0x38]	; 02323CA0
	ldr r7,[sp,#0x3c]	; 02323CA2
	ldr r0,[sp,#0x40]	; 02323CA4
	str r0,[sp,#0x40]	; 02323CA6
	ldr r0,[sp,#0x44]	; 02323CA8
	str r0,[sp,#0x44]	; 02323CAA
	ldrh r0,[r5,#0x6]	; 02323CAC
	str r0,[sp,#0x20]	; 02323CAE
	mov r4,#0x0	; 02323CB0
	b loc_02323CDA	; 02323CB2
loc_02323CB4:
	ldr r0,[sp,#0x1c]	; 02323CB4
	str r0,[sp,#0x0]	; 02323CB6
	str r6,[sp,#0x4]	; 02323CB8
	str r7,[sp,#0x8]	; 02323CBA
	ldr r0,[sp,#0x40]	; 02323CBC
	str r0,[sp,#0xc]	; 02323CBE
	ldr r0,[sp,#0x44]	; 02323CC0
	str r0,[sp,#0x10]	; 02323CC2
	ldr r0,[sp,#0x14]	; 02323CC4
	add r1,r5,#0x0	; 02323CC6
	ldr r2,[sp,#0x18]	; 02323CC8
	add r3,r4,#0x0	; 02323CCA
	bl loc_02323CEC	; 02323CCC
	cmp r0,#0x0	; 02323CD0
	bne loc_02323CD8	; 02323CD2
	mov r0,#0x0	; 02323CD4
	b loc_02323CE2	; 02323CD6
loc_02323CD8:
	add r4,r4,#0x1	; 02323CD8
loc_02323CDA:
	ldr r0,[sp,#0x20]	; 02323CDA
	cmp r4,r0	; 02323CDC
	blt loc_02323CB4	; 02323CDE
	mov r0,#0x1	; 02323CE0
loc_02323CE2:
	add sp,#0x24	; 02323CE2
	pop {r4,r5,r6,r7}	; 02323CE4
	pop {r3}	; 02323CE6
	bx r3	; 02323CE8
	.byte 0x00, 0x00	; 02323CEC

; ===== function loc_02323CEC =====
loc_02323CEC:
	push {r4,r5,r6,r7,lr}	; 02323CEC
	sub sp,#0x1c	; 02323CEE
	str r0,[sp,#0x10]	; 02323CF0
	str r2,[sp,#0x14]	; 02323CF2
	add r4,r1,#0x0	; 02323CF4
	add r4,#0x8	; 02323CF6
	lsl r7,r3,#0x3	; 02323CF8
	add r5,r4,r7	; 02323CFA
	ldr r1,[r5,#0x4]	; 02323CFC
	bl loc_023291B0	; 02323CFE
	add r6,r0,#0x0	; 02323D02
	mov r1,sp	; 02323D04
	sub r1,r1,#0x4	; 02323D06
	ldrh r0,[r4,r7]	; 02323D08
	strh r0,[r1,#0x0]	; 02323D0A
	ldmia r1!,{r0}	; 02323D0C
	ldrb r1,[r6,#0x0]	; 02323D0E
	bl loc_023290E0	; 02323D10
	ldr r1,[sp,#0x30]	; 02323D14
	add r0,r1,r0	; 02323D16
	str r0,[sp,#0x30]	; 02323D18
	mov r1,sp	; 02323D1A
	sub r1,r1,#0x4	; 02323D1C
	ldrh r0,[r5,#0x2]	; 02323D1E
	strh r0,[r1,#0x0]	; 02323D20
	ldmia r1!,{r0}	; 02323D22
	ldrb r1,[r6,#0x1]	; 02323D24
	bl loc_023290A8	; 02323D26
	ldr r1,[sp,#0x34]	; 02323D2A
	add r3,r1,r0	; 02323D2C
	str r3,[sp,#0x34]	; 02323D2E
	ldr r0,[sp,#0x38]	; 02323D30
	str r0,[sp,#0x0]	; 02323D32
	ldr r0,[sp,#0x3c]	; 02323D34
	str r0,[sp,#0x4]	; 02323D36
	ldr r0,[sp,#0x40]	; 02323D38
	str r0,[sp,#0x8]	; 02323D3A
	ldr r0,[r5,#0x4]	; 02323D3C
	str r0,[sp,#0xc]	; 02323D3E
	ldr r0,[sp,#0x10]	; 02323D40
	ldr r1,[sp,#0x14]	; 02323D42
	ldr r2,[sp,#0x30]	; 02323D44
	bl loc_02323D54	; 02323D46
	add sp,#0x1c	; 02323D4A
	pop {r4,r5,r6,r7}	; 02323D4C
	pop {r3}	; 02323D4E
	bx r3	; 02323D50
	.byte 0x00, 0x00	; 02323D54

; ===== function loc_02323D54 =====
loc_02323D54:
	push {r4,r5,r6,r7,lr}	; 02323D54
	sub sp,#0x14	; 02323D56
	add r5,r0,#0x0	; 02323D58
	add r4,r1,#0x0	; 02323D5A
	str r2,[sp,#0x0]	; 02323D5C
	str r3,[sp,#0x4]	; 02323D5E
	ldr r1,[sp,#0x28]	; 02323D60
	str r1,[sp,#0x28]	; 02323D62
	ldr r1,[sp,#0x2c]	; 02323D64
	str r1,[sp,#0x2c]	; 02323D66
	ldr r1,[sp,#0x30]	; 02323D68
	str r1,[sp,#0x30]	; 02323D6A
	ldr r1,[sp,#0x34]	; 02323D6C
	bl loc_023291E0	; 02323D6E
	str r0,[sp,#0x8]	; 02323D72
	add r0,r5,#0x0	; 02323D74
	ldr r1,[sp,#0x34]	; 02323D76
	bl loc_023291C8	; 02323D78
	add r7,r0,#0x0	; 02323D7C
	add r0,r5,#0x0	; 02323D7E
	ldr r1,[sp,#0x34]	; 02323D80
	bl loc_023291B0	; 02323D82
	mov r2,#0x0	; 02323D86
	str r2,[sp,#0xc]	; 02323D88
	ldr r0,[pool_02323E58]	; 02323D8A
	ldr r1,[r4,r0]	; 02323D8C
	b loc_02323DA6	; 02323D8E
loc_02323D90:
	lsl r0,r2,#0x3	; 02323D90
	add r0,r4,r0	; 02323D92
	ldr r3,[pool_02323E5C]	; 02323D94
	ldr r3,[r0,r3]	; 02323D96
	cmp r3,r5	; 02323D98
	bne loc_02323DA4	; 02323D9A
	ldr r3,[pool_02323E60]	; 02323D9C
	ldr r0,[r0,r3]	; 02323D9E
	lsr r0,r0,#0x7	; 02323DA0
	str r0,[sp,#0xc]	; 02323DA2
loc_02323DA4:
	add r2,r2,#0x1	; 02323DA4
loc_02323DA6:
	cmp r2,r1	; 02323DA6
	blt loc_02323D90	; 02323DA8
	mov r1,#0x0	; 02323DAA
	b loc_02323E46	; 02323DAC
loc_02323DAE:
	ldr r0,[pool_02323E64]	; 02323DAE
	ldr r0,[r4,r0]	; 02323DB0
	lsl r0,r0,#0x3	; 02323DB2
	add r2,r4,r0	; 02323DB4
	ldr r5,[r7,#0x0]	; 02323DB6
	ldr r3,[r7,#0x4]	; 02323DB8
	str r5,[r4,r0]	; 02323DBA
	str r3,[r2,#0x4]	; 02323DBC
	ldrh r6,[r2,#0x4]	; 02323DBE
	ldr r3,[pool_02323E68]	; 02323DC0
	and r6,r3	; 02323DC2
	ldrh r5,[r7,#0x8]	; 02323DC4
	ldr r3,[sp,#0xc]	; 02323DC6
	add r3,r5,r3	; 02323DC8
	orr r6,r3	; 02323DCA
	strh r6,[r2,#0x4]	; 02323DCC
	ldr r5,[r4,r0]	; 02323DCE
	add r6,r5,#0x0	; 02323DD0
	ldr r3,[pool_02323E6C]	; 02323DD2
	and r6,r3	; 02323DD4
	lsl r3,r5,#0x7	; 02323DD6
	lsr r5,r3,#0x17	; 02323DD8
	ldr r3,[sp,#0x0]	; 02323DDA
	add r5,r5,r3	; 02323DDC
	ldr r3,[pool_02323E70]	; 02323DDE
	and r5,r3	; 02323DE0
	lsl r3,r5,#0x10	; 02323DE2
	orr r6,r3	; 02323DE4
	str r6,[r4,r0]	; 02323DE6
	ldrb r5,[r4,r0]	; 02323DE8
	ldr r3,[sp,#0x4]	; 02323DEA
	add r3,r5,r3	; 02323DEC
	strb r3,[r4,r0]	; 02323DEE
	ldr r0,[sp,#0x28]	; 02323DF0
	cmp r0,#0x0	; 02323DF2
	blt loc_02323E08	; 02323DF4
	ldr r0,[r2,#0x4]	; 02323DF6
	ldr r3,[pool_02323E74]	; 02323DF8
	and r0,r3	; 02323DFA
	ldr r5,[sp,#0x28]	; 02323DFC
	mov r3,#0xf	; 02323DFE
	and r5,r3	; 02323E00
	lsl r3,r5,#0xc	; 02323E02
	orr r0,r3	; 02323E04
	str r0,[r2,#0x4]	; 02323E06
loc_02323E08:
	ldr r0,[sp,#0x2c]	; 02323E08
	cmp r0,#0x0	; 02323E0A
	blt loc_02323E20	; 02323E0C
	ldr r0,[r2,#0x0]	; 02323E0E
	ldr r3,[pool_02323E78]	; 02323E10
	and r0,r3	; 02323E12
	ldr r5,[sp,#0x2c]	; 02323E14
	mov r3,#0x3	; 02323E16
	and r5,r3	; 02323E18
	lsl r3,r5,#0xa	; 02323E1A
	orr r0,r3	; 02323E1C
	str r0,[r2,#0x0]	; 02323E1E
loc_02323E20:
	ldr r0,[sp,#0x30]	; 02323E20
	cmp r0,#0x0	; 02323E22
	blt loc_02323E38	; 02323E24
	ldr r0,[r2,#0x4]	; 02323E26
	ldr r3,[pool_02323E78]	; 02323E28
	and r0,r3	; 02323E2A
	ldr r5,[sp,#0x30]	; 02323E2C
	mov r3,#0x3	; 02323E2E
	and r5,r3	; 02323E30
	lsl r3,r5,#0xa	; 02323E32
	orr r0,r3	; 02323E34
	str r0,[r2,#0x4]	; 02323E36
loc_02323E38:
	ldr r0,[pool_02323E64]	; 02323E38
	ldr r0,[r4,r0]	; 02323E3A
	add r2,r0,#0x1	; 02323E3C
	ldr r0,[pool_02323E64]	; 02323E3E
	str r2,[r4,r0]	; 02323E40
	add r1,r1,#0x1	; 02323E42
	add r7,#0xc	; 02323E44
loc_02323E46:
	ldr r0,[sp,#0x8]	; 02323E46
	cmp r1,r0	; 02323E48
	blt loc_02323DAE	; 02323E4A
	mov r0,#0x1	; 02323E4C
	add sp,#0x14	; 02323E4E
	pop {r4,r5,r6,r7}	; 02323E50
	pop {r3}	; 02323E52
	bx r3	; 02323E54
	.byte 0xC0, 0x46	; 02323E58
pool_02323E58:
loc_02323E58:
	.word 0x00000628	; 02323E58
pool_02323E5C:
loc_02323E5C:
	.word 0x00000608	; 02323E5C
pool_02323E60:
loc_02323E60:
	.word 0x0000060C	; 02323E60
pool_02323E64:
loc_02323E64:
	.word 0x00000600	; 02323E64
pool_02323E68:
loc_02323E68:
	.word 0xFFFFFC00	; 02323E68
pool_02323E6C:
loc_02323E6C:
	.word 0xFE00FFFF	; 02323E6C
pool_02323E70:
loc_02323E70:
	.word 0x000001FF	; 02323E70
pool_02323E74:
loc_02323E74:
	.word 0xFFFF0FFF	; 02323E74
pool_02323E78:
loc_02323E78:
	.word 0xFFFFF3FF	; 02323E78

; ===== function loc_02323E7C =====
loc_02323E7C:
	ldr r0,[pool_02323E80]	; 02323E7C
	bx lr	; 02323E7E
pool_02323E80:
loc_02323E80:
	.word 0x023339F0	; 02323E80

; ===== function loc_02323E84 =====
loc_02323E84:
	ldr r0,[pool_02323E88]	; 02323E84
	bx lr	; 02323E86
pool_02323E88:
loc_02323E88:
	.word 0x023333C0	; 02323E88

; ===== function loc_02323E8C =====
loc_02323E8C:
	push {lr}	; 02323E8C
	sub sp,#0x4	; 02323E8E
	ldr r0,[pool_02323EB4]	; 02323E90
	ldr r0,[r0,#0x60]	; 02323E92
	cmp r0,#0x0	; 02323E94
	beq loc_02323EAC	; 02323E96
	ldr r0,[pool_02323EB8]	; 02323E98
	mov r1,#0x0	; 02323E9A
	ldr r2,[pool_02323EBC]	; 02323E9C
	bl loc_0232DC80	; 02323E9E
	ldr r0,[pool_02323EC0]	; 02323EA2
	mov r1,#0x0	; 02323EA4
	ldr r2,[pool_02323EBC]	; 02323EA6
	bl loc_0232DC58	; 02323EA8
loc_02323EAC:
	add sp,#0x4	; 02323EAC
	pop {r3}	; 02323EAE
	bx r3	; 02323EB0
	.byte 0xC0, 0x46	; 02323EB4
pool_02323EB4:
loc_02323EB4:
	.word P1_BssStart + 0x3540	; 02323EB4
pool_02323EB8:
loc_02323EB8:
	.word 0x023333C0	; 02323EB8
pool_02323EBC:
loc_02323EBC:
	.word 0x00000400	; 02323EBC
pool_02323EC0:
loc_02323EC0:
	.word 0x023339F0	; 02323EC0

; ===== function loc_02323EC4 =====
; 更新 UI 工作缓冲区、清理其数据缓存，并在 VBlank 前提交。
; Updates UI work buffers, cleans their D-cache, then commits before VBlank.
.func P1_RefreshFirmwareUiRenderBuffers
loc_02323EC4:
	push {r4,r5,r6,r7,lr}	; 02323EC4
	sub sp,#0xc	; 02323EC6
	mov r0,#0xc0	; 02323EC8
	str r0,[sp,#0x0]	; 02323ECA
	ldr r0,[pool_02323F74]	; 02323ECC
	ldr r3,[r0,#0x0]	; 02323ECE
	ldr r0,[sp,#0x0]	; 02323ED0
	ldr r2,[pool_02323F78]	; 02323ED2
	lsl r1,r3,#0x3	; 02323ED4
	add r1,r2,r1	; 02323ED6
	mov r2,#0x80	; 02323ED8
	sub r2,r2,r3	; 02323EDA
	lsl r2,r2,#0x3	; 02323EDC
	blx loc_0232DE78	; 02323EDE
	mov r0,#0xc0	; 02323EE2
	str r0,[sp,#0x4]	; 02323EE4
	ldr r0,[pool_02323F7C]	; 02323EE6
	ldr r3,[r0,#0x30]	; 02323EE8
	ldr r0,[sp,#0x4]	; 02323EEA
	ldr r2,[pool_02323F80]	; 02323EEC
	lsl r1,r3,#0x3	; 02323EEE
	add r1,r2,r1	; 02323EF0
	mov r2,#0x80	; 02323EF2
	sub r2,r2,r3	; 02323EF4
	lsl r2,r2,#0x3	; 02323EF6
	blx loc_0232DE78	; 02323EF8
	mov r5,#0x0	; 02323EFC
	ldr r3,[pool_02323F78]	; 02323EFE
	ldr r0,[pool_02323F80]	; 02323F00
	ldr r7,[pool_02323F84]	; 02323F02
loc_02323F04:
	lsl r1,r5,#0x4	; 02323F04
	add r4,r3,r1	; 02323F06
	lsl r2,r5,#0x5	; 02323F08
	add r1,r3,r2	; 02323F0A
	ldr r6,[pool_02323F88]	; 02323F0C
	ldr r6,[r4,r6]	; 02323F0E
	asr r6,r6,#0x4	; 02323F10
	strh r6,[r1,#0x6]	; 02323F12
	ldr r6,[pool_02323F8C]	; 02323F14
	ldr r6,[r4,r6]	; 02323F16
	asr r6,r6,#0x4	; 02323F18
	strh r6,[r1,#0xe]	; 02323F1A
	ldr r6,[pool_02323F90]	; 02323F1C
	ldr r6,[r4,r6]	; 02323F1E
	asr r6,r6,#0x4	; 02323F20
	strh r6,[r1,#0x16]	; 02323F22
	ldr r6,[pool_02323F94]	; 02323F24
	ldr r6,[r4,r6]	; 02323F26
	asr r6,r6,#0x4	; 02323F28
	strh r6,[r1,#0x1e]	; 02323F2A
	add r1,r0,r2	; 02323F2C
	ldr r2,[pool_02323F98]	; 02323F2E
	ldr r2,[r4,r2]	; 02323F30
	asr r2,r2,#0x4	; 02323F32
	strh r2,[r1,#0x6]	; 02323F34
	ldr r2,[pool_02323F9C]	; 02323F36
	ldr r2,[r4,r2]	; 02323F38
	asr r2,r2,#0x4	; 02323F3A
	strh r2,[r1,#0xe]	; 02323F3C
	ldr r2,[pool_02323FA0]	; 02323F3E
	ldr r2,[r4,r2]	; 02323F40
	asr r2,r2,#0x4	; 02323F42
	strh r2,[r1,#0x16]	; 02323F44
	ldr r2,[r4,r7]	; 02323F46
	asr r2,r2,#0x4	; 02323F48
	strh r2,[r1,#0x1e]	; 02323F4A
	add r5,r5,#0x1	; 02323F4C
	cmp r5,#0x20	; 02323F4E
	blt loc_02323F04	; 02323F50
	add r0,r3,#0x0	; 02323F52
	ldr r1,[pool_02323F88]	; 02323F54
	blx P1_CleanDataCacheRange	; 02323F56
	ldr r0,[pool_02323F80]	; 02323F5A
	ldr r1,[pool_02323F88]	; 02323F5C
	blx P1_CleanDataCacheRange	; 02323F5E
	mov r1,#0x1	; 02323F62
	ldr r0,[pool_02323F7C]	; 02323F64
	str r1,[r0,#0x60]	; 02323F66
	bl loc_0232C7C2	; 02323F68
	add sp,#0xc	; 02323F6C
	pop {r4,r5,r6,r7}	; 02323F6E
	pop {r3}	; 02323F70
	bx r3	; 02323F72
.endfunc
pool_02323F74:
loc_02323F74:
	.word P1_BssStart + 0x2F40	; 02323F74
pool_02323F78:
loc_02323F78:
	.word 0x023333C0	; 02323F78
pool_02323F7C:
loc_02323F7C:
	.word P1_BssStart + 0x3540	; 02323F7C
pool_02323F80:
loc_02323F80:
	.word 0x023339F0	; 02323F80
pool_02323F84:
loc_02323F84:
	.word 0x00000A3C	; 02323F84
pool_02323F88:
loc_02323F88:
	.word 0x00000400	; 02323F88
pool_02323F8C:
loc_02323F8C:
	.word 0x00000404	; 02323F8C
pool_02323F90:
loc_02323F90:
	.word 0x00000408	; 02323F90
pool_02323F94:
loc_02323F94:
	.word 0x0000040C	; 02323F94
pool_02323F98:
loc_02323F98:
	.word 0x00000A30	; 02323F98
pool_02323F9C:
loc_02323F9C:
	.word 0x00000A34	; 02323F9C
pool_02323FA0:
loc_02323FA0:
	.word 0x00000A38	; 02323FA0

; ===== function loc_02323FA4 =====
loc_02323FA4:
	mov r2,#0x0	; 02323FA4
	ldr r1,[pool_02323FB8]	; 02323FA6
	str r2,[r1,#0x30]	; 02323FA8
	ldr r0,[pool_02323FBC]	; 02323FAA
	str r2,[r0,#0x0]	; 02323FAC
	str r2,[r1,#0x34]	; 02323FAE
	str r2,[r0,#0x4]	; 02323FB0
	str r2,[r1,#0x60]	; 02323FB2
	bx lr	; 02323FB4
	.byte 0xC0, 0x46	; 02323FB8
pool_02323FB8:
loc_02323FB8:
	.word P1_BssStart + 0x3540	; 02323FB8
pool_02323FBC:
loc_02323FBC:
	.word P1_BssStart + 0x2F40	; 02323FBC

; ===== function loc_02323FC0 =====
loc_02323FC0:
	push {r4,r5,r6,lr}	; 02323FC0
	add r5,r0,#0x0	; 02323FC2
	add r4,r1,#0x0	; 02323FC4
	ldr r0,[pool_02324040]	; 02323FC6
	add r1,r5,r0	; 02323FC8
	ldr r0,[r1,#0x0]	; 02323FCA
	lsl r0,r0,#0x3	; 02323FCC
	add r2,r5,r0	; 02323FCE
	ldr r0,[pool_02324044]	; 02323FD0
	str r4,[r2,r0]	; 02323FD2
	ldr r0,[pool_02324048]	; 02323FD4
	ldr r0,[r5,r0]	; 02323FD6
	ldr r1,[r1,#0x0]	; 02323FD8
	lsl r1,r1,#0x3	; 02323FDA
	add r2,r5,r1	; 02323FDC
	ldr r1,[pool_0232404C]	; 02323FDE
	str r0,[r2,r1]	; 02323FE0
	ldr r0,[pool_02324050]	; 02323FE2
	cmp r5,r0	; 02323FE4
	bne loc_02324004	; 02323FE6
	add r0,r4,#0x0	; 02323FE8
	bl loc_023291C0	; 02323FEA
	add r6,r0,#0x0	; 02323FEE
	add r0,r4,#0x0	; 02323FF0
	bl loc_023291BC	; 02323FF2
	add r2,r0,#0x0	; 02323FF6
	add r0,r6,#0x0	; 02323FF8
	ldr r1,[pool_02324048]	; 02323FFA
	ldr r1,[r5,r1]	; 02323FFC
	bl loc_0232DC30	; 02323FFE
	b loc_0232401E	; 02324002
loc_02324004:
	add r0,r4,#0x0	; 02324004
	bl loc_023291C0	; 02324006
	add r6,r0,#0x0	; 0232400A
	add r0,r4,#0x0	; 0232400C
	bl loc_023291BC	; 0232400E
	add r2,r0,#0x0	; 02324012
	add r0,r6,#0x0	; 02324014
	ldr r1,[pool_02324048]	; 02324016
	ldr r1,[r5,r1]	; 02324018
	bl loc_0232DC08	; 0232401A
loc_0232401E:
	add r0,r4,#0x0	; 0232401E
	bl loc_023291BC	; 02324020
	ldr r1,[pool_02324048]	; 02324024
	add r1,r5,r1	; 02324026
	ldr r2,[r1,#0x0]	; 02324028
	add r0,r2,r0	; 0232402A
	str r0,[r1,#0x0]	; 0232402C
	ldr r0,[pool_02324040]	; 0232402E
	add r0,r5,r0	; 02324030
	ldr r1,[r0,#0x0]	; 02324032
	add r1,r1,#0x1	; 02324034
	str r1,[r0,#0x0]	; 02324036
	pop {r4,r5,r6}	; 02324038
	pop {r3}	; 0232403A
	bx r3	; 0232403C
	.byte 0xC0, 0x46	; 02324040
pool_02324040:
loc_02324040:
	.word 0x00000628	; 02324040
pool_02324044:
loc_02324044:
	.word 0x00000608	; 02324044
pool_02324048:
loc_02324048:
	.word 0x0000062C	; 02324048
pool_0232404C:
loc_0232404C:
	.word 0x0000060C	; 0232404C
pool_02324050:
loc_02324050:
	.word 0x023333C0	; 02324050

; ===== function loc_02324054 =====
loc_02324054:
	push {r4,r5,lr}	; 02324054
	sub sp,#0x4	; 02324056
	mov r5,#0x0	; 02324058
	add r3,r5,#0x0	; 0232405A
	ldr r1,[pool_02324088]	; 0232405C
	ldr r2,[pool_0232408C]	; 0232405E
loc_02324060:
	lsl r4,r5,#0x3	; 02324060
	add r4,r0,r4	; 02324062
	str r3,[r4,r1]	; 02324064
	str r3,[r4,r2]	; 02324066
	add r5,r5,#0x1	; 02324068
	cmp r5,#0x4	; 0232406A
	blt loc_02324060	; 0232406C
	ldr r1,[pool_02324090]	; 0232406E
	str r3,[r0,r1]	; 02324070
	ldr r1,[pool_02324094]	; 02324072
	str r3,[r0,r1]	; 02324074
	ldr r1,[pool_02324098]	; 02324076
	str r3,[r0,r1]	; 02324078
	ldr r1,[pool_0232409C]	; 0232407A
	str r3,[r0,r1]	; 0232407C
	add sp,#0x4	; 0232407E
	pop {r4,r5}	; 02324080
	pop {r3}	; 02324082
	bx r3	; 02324084
	.byte 0xC0, 0x46	; 02324088
pool_02324088:
loc_02324088:
	.word 0x00000608	; 02324088
pool_0232408C:
loc_0232408C:
	.word 0x0000060C	; 0232408C
pool_02324090:
loc_02324090:
	.word 0x00000628	; 02324090
pool_02324094:
loc_02324094:
	.word 0x0000062C	; 02324094
pool_02324098:
loc_02324098:
	.word 0x00000600	; 02324098
pool_0232409C:
loc_0232409C:
	.word 0x00000604	; 0232409C
	.byte 0x00, 0x04, 0x02, 0x0C, 0x05, 0x48, 0xC1, 0x88, 0x91, 0x43, 0xC1, 0x80, 0x81, 0x88, 0x91, 0x43	; 023240A0
	.byte 0x81, 0x80, 0x01, 0x89, 0x91, 0x43, 0x01, 0x81, 0x70, 0x47, 0xC0, 0x46, 0x24, 0x40, 0x33, 0x02	; 023240B0
P1_Entry_023240C0:
	mov r1,#0x0	; 023240C0
	ldr r0,[pool_023240C8]	; 023240C2
	str r1,[r0,#0x24]	; 023240C4
	bx lr	; 023240C6
pool_023240C8:
	.word P1_BssStart + 0x35A4	; 023240C8
P1_Entry_023240CC:
	mov r1,#0x1	; 023240CC
	ldr r0,[pool_023240D4]	; 023240CE
	str r1,[r0,#0x24]	; 023240D0
	bx lr	; 023240D2
pool_023240D4:
	.word P1_BssStart + 0x35A4	; 023240D4
P1_Entry_023240D8:
	ldr r0,[pool_023240E0]	; 023240D8
	ldr r0,[r0,#0x0]	; 023240DA
	bx lr	; 023240DC
	.byte 0xC0, 0x46	; 023240DE
pool_023240E0:
	.word P1_BssStart + 0x35A4	; 023240E0
P1_Entry_023240E4:
	ldr r1,[pool_023240EC]	; 023240E4
	strh r0,[r1,#0xa]	; 023240E6
	bx lr	; 023240E8
	.byte 0xC0, 0x46	; 023240EA
pool_023240EC:
	.word P1_BssStart + 0x35A4	; 023240EC
P1_Entry_023240F0:
	ldr r0,[pool_023240F8]	; 023240F0
	ldr r0,[r0,#0x18]	; 023240F2
	bx lr	; 023240F4
	.byte 0xC0, 0x46	; 023240F6
pool_023240F8:
	.word P1_BssStart + 0x35A4	; 023240F8

; ===== function loc_023240FC =====
loc_023240FC:
	ldr r0,[pool_02324104]	; 023240FC
	ldrh r0,[r0,#0x16]	; 023240FE
	bx lr	; 02324100
	.byte 0xC0, 0x46	; 02324104
pool_02324104:
loc_02324104:
	.word P1_BssStart + 0x35A4	; 02324104

; ===== function loc_02324108 =====
loc_02324108:
	ldr r0,[pool_02324110]	; 02324108
	ldrh r0,[r0,#0x14]	; 0232410A
	bx lr	; 0232410C
	.byte 0xC0, 0x46	; 02324110
pool_02324110:
loc_02324110:
	.word P1_BssStart + 0x35A4	; 02324110

; ===== function loc_02324114 =====
loc_02324114:
	ldr r0,[pool_0232411C]	; 02324114
	ldr r0,[r0,#0x1c]	; 02324116
	bx lr	; 02324118
	.byte 0xC0, 0x46	; 0232411C
pool_0232411C:
loc_0232411C:
	.word P1_BssStart + 0x35A4	; 0232411C

; ===== function loc_02324120 =====
loc_02324120:
	ldr r0,[pool_02324128]	; 02324120
	ldrh r0,[r0,#0x20]	; 02324122
	bx lr	; 02324124
	.byte 0xC0, 0x46	; 02324128
pool_02324128:
loc_02324128:
	.word P1_BssStart + 0x35A4	; 02324128
	.byte 0x02, 0x49, 0x09, 0x89, 0x01, 0x40, 0x08, 0x1C, 0x70, 0x47, 0xC0, 0x46, 0x24, 0x40, 0x33, 0x02	; 0232413C

; ===== function loc_0232413C =====
loc_0232413C:
	ldr r1,[pool_02324148]	; 0232413C
	ldrh r1,[r1,#0x6]	; 0232413E
	and r1,r0	; 02324140
	add r0,r1,#0x0	; 02324142
	bx lr	; 02324144
	.byte 0xC0, 0x46	; 02324148
pool_02324148:
loc_02324148:
	.word P1_BssStart + 0x35A4	; 02324148

; ===== function loc_0232414C =====
loc_0232414C:
	ldr r1,[pool_02324158]	; 0232414C
	ldrh r1,[r1,#0x4]	; 0232414E
	and r1,r0	; 02324150
	add r0,r1,#0x0	; 02324152
	bx lr	; 02324154
	.byte 0xC0, 0x46	; 02324158
pool_02324158:
loc_02324158:
	.word P1_BssStart + 0x35A4	; 02324158

; ===== function loc_0232415C =====
loc_0232415C:
	push {r4,lr}	; 0232415C
	sub sp,#0x10	; 0232415E
	ldr r0,[pool_02324248]	; 02324160
	ldrh r1,[r0,#0x0]	; 02324162
	ldr r0,[pool_0232424C]	; 02324164
	ldrh r0,[r0,#0x0]	; 02324166
	orr r1,r0	; 02324168
	ldr r0,[pool_02324250]	; 0232416A
	eor r1,r0	; 0232416C
	and r1,r0	; 0232416E
	lsl r0,r1,#0x10	; 02324170
	lsr r3,r0,#0x10	; 02324172
	ldr r0,[pool_02324254]	; 02324174
	ldrh r1,[r0,#0x6]	; 02324176
	add r2,r3,#0x0	; 02324178
	eor r2,r1	; 0232417A
	add r1,r3,#0x0	; 0232417C
	and r1,r2	; 0232417E
	strh r1,[r0,#0x4]	; 02324180
	mvn r1,r3	; 02324182
	and r1,r2	; 02324184
	strh r1,[r0,#0x8]	; 02324186
	strh r3,[r0,#0x6]	; 02324188
	ldrh r2,[r0,#0x6]	; 0232418A
	ldrh r1,[r0,#0xa]	; 0232418C
	and r2,r1	; 0232418E
	cmp r2,#0x0	; 02324190
	beq loc_0232419C	; 02324192
	ldr r1,[r0,#0x0]	; 02324194
	add r1,r1,#0x1	; 02324196
	str r1,[r0,#0x0]	; 02324198
	b loc_023241A0	; 0232419A
loc_0232419C:
	mov r1,#0x0	; 0232419C
	str r1,[r0,#0x0]	; 0232419E
loc_023241A0:
	ldr r0,[pool_02324254]	; 023241A0
	ldr r0,[r0,#0x24]	; 023241A2
	cmp r0,#0x0	; 023241A4
	beq loc_0232423E	; 023241A6
	add r4,sp,#0x0	; 023241A8
loc_023241AA:
	bl loc_0232EDC4	; 023241AA
	add r0,r4,#0x0	; 023241AE
	bl loc_0232ED90	; 023241B0
	cmp r0,#0x0	; 023241B4
	bne loc_023241AA	; 023241B6
	add r0,sp,#0x8	; 023241B8
	add r1,sp,#0x0	; 023241BA
	bl loc_0232EB1C	; 023241BC
	add r0,sp,#0x0	; 023241C0
	ldrh r0,[r0,#0xe]	; 023241C2
	cmp r0,#0x0	; 023241C4
	beq loc_023241E2	; 023241C6
	ldr r3,[pool_02324258]	; 023241C8
	add r2,sp,#0x8	; 023241CA
	mov r1,#0x4	; 023241CC
loc_023241CE:
	ldrh r0,[r3,#0x0]	; 023241CE
	add r3,r3,#0x2	; 023241D0
	strh r0,[r2,#0x0]	; 023241D2
	add r2,r2,#0x2	; 023241D4
	sub r1,r1,#0x1	; 023241D6
	cmp r1,#0x0	; 023241D8
	bne loc_023241CE	; 023241DA
	mov r1,#0x0	; 023241DC
	add r0,sp,#0x0	; 023241DE
	strh r1,[r0,#0xc]	; 023241E0
loc_023241E2:
	add r0,sp,#0x0	; 023241E2
	ldrh r0,[r0,#0xc]	; 023241E4
	ldr r1,[pool_02324254]	; 023241E6
	ldrh r2,[r1,#0x10]	; 023241E8
	cmp r0,r2	; 023241EA
	beq loc_02324202	; 023241EC
	cmp r0,#0x0	; 023241EE
	beq loc_023241F6	; 023241F0
	mov r2,#0x1	; 023241F2
	b loc_023241F8	; 023241F4
loc_023241F6:
	mov r2,#0x3	; 023241F6
loc_023241F8:
	ldr r1,[pool_02324254]	; 023241F8
	str r2,[r1,#0x1c]	; 023241FA
	mov r2,#0x0	; 023241FC
	str r2,[r1,#0x18]	; 023241FE
	b loc_02324216	; 02324200
loc_02324202:
	cmp r0,#0x0	; 02324202
	beq loc_02324212	; 02324204
	mov r2,#0x2	; 02324206
	str r2,[r1,#0x1c]	; 02324208
	ldr r2,[r1,#0x18]	; 0232420A
	add r2,r2,#0x1	; 0232420C
	str r2,[r1,#0x18]	; 0232420E
	b loc_02324216	; 02324210
loc_02324212:
	mov r2,#0x0	; 02324212
	str r2,[r1,#0x1c]	; 02324214
loc_02324216:
	cmp r0,#0x0	; 02324216
	beq loc_02324226	; 02324218
	add r2,sp,#0x0	; 0232421A
	ldrh r3,[r2,#0x8]	; 0232421C
	ldr r1,[pool_02324254]	; 0232421E
	strh r3,[r1,#0x14]	; 02324220
	ldrh r2,[r2,#0xa]	; 02324222
	strh r2,[r1,#0x16]	; 02324224
loc_02324226:
	ldr r1,[pool_02324254]	; 02324226
	strh r0,[r1,#0x20]	; 02324228
	add r3,sp,#0x8	; 0232422A
	ldr r2,[pool_02324258]	; 0232422C
	mov r1,#0x4	; 0232422E
loc_02324230:
	ldrh r0,[r3,#0x0]	; 02324230
	add r3,r3,#0x2	; 02324232
	strh r0,[r2,#0x0]	; 02324234
	add r2,r2,#0x2	; 02324236
	sub r1,r1,#0x1	; 02324238
	cmp r1,#0x0	; 0232423A
	bne loc_02324230	; 0232423C
loc_0232423E:
	add sp,#0x10	; 0232423E
	pop {r4}	; 02324240
	pop {r3}	; 02324242
	bx r3	; 02324244
	.byte 0xC0, 0x46	; 02324248
pool_02324248:
loc_02324248:
	.word REG_KEYINPUT	; 02324248
pool_0232424C:
loc_0232424C:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 0232424C
pool_02324250:
loc_02324250:
	.word 0x00002FFF	; 02324250
pool_02324254:
loc_02324254:
	.word P1_BssStart + 0x35A4	; 02324254
pool_02324258:
loc_02324258:
	.word P1_BssStart + 0x35B0	; 02324258

; ===== function loc_0232425C =====
loc_0232425C:
	push {lr}	; 0232425C
	sub sp,#0x4	; 0232425E
	bl loc_02324274	; 02324260
	mov r1,#0x1	; 02324264
	ldr r0,[pool_02324270]	; 02324266
	str r1,[r0,#0x24]	; 02324268
	add sp,#0x4	; 0232426A
	pop {r3}	; 0232426C
	bx r3	; 0232426E
pool_02324270:
loc_02324270:
	.word P1_BssStart + 0x35A4	; 02324270

; ===== function loc_02324274 =====
loc_02324274:
	push {lr}	; 02324274
	sub sp,#0x4	; 02324276
	mov r0,#0x0	; 02324278
	str r0,[sp,#0x0]	; 0232427A
	ldr r0,[sp,#0x0]	; 0232427C
	ldr r1,[pool_0232428C]	; 0232427E
	mov r2,#0x28	; 02324280
	blx loc_0232DE78	; 02324282
	add sp,#0x4	; 02324286
	pop {r3}	; 02324288
	bx r3	; 0232428A
pool_0232428C:
loc_0232428C:
	.word 0x02334024	; 0232428C

; ===== function loc_02324290 =====
loc_02324290:
	push {lr}	; 02324290
	sub sp,#0x4	; 02324292
	bl loc_02324338	; 02324294
	cmp r0,#0x0	; 02324298
	beq loc_023242A6	; 0232429A
	cmp r0,#0x1	; 0232429C
	beq loc_023242A6	; 0232429E
	cmp r0,#0x2	; 023242A0
	beq loc_023242AA	; 023242A2
	b loc_023242AE	; 023242A4
loc_023242A6:
	mov r0,#0x3	; 023242A6
	b loc_023242B0	; 023242A8
loc_023242AA:
	mov r0,#0xf	; 023242AA
	b loc_023242B0	; 023242AC
loc_023242AE:
	mov r0,#0x2	; 023242AE
loc_023242B0:
	add sp,#0x4	; 023242B0
	pop {r3}	; 023242B2
	bx r3	; 023242B4
	.byte 0x00, 0x00	; 023242B6
P1_Entry_023242B8:
	push {r4,r5,lr}	; 023242B8
	sub sp,#0x4	; 023242BA
	add r5,r0,#0x0	; 023242BC
	add r4,r1,#0x0	; 023242BE
	bl loc_02324348	; 023242C0
	cmp r0,#0x0	; 023242C4
	bne P1_Entry_023242EC	; 023242C6
	add r0,r5,#0x0	; 023242C8
	add r1,r4,#0x0	; 023242CA
	bl loc_02324338	; 023242CC
	cmp r0,#0x1	; 023242D0
	bne P1_Entry_023242F0	; 023242D2
	bl P1_Entry_023240F0	; 023242D4
	cmp r0,#0x1e	; 023242D8
	bls P1_Entry_023242F0	; 023242DA
	bl P1_Entry_023240F0	; 023242DC
	sub r0,#0x1e	; 023242E0
	mov r1,#0xa	; 023242E2
	blx P1_UnsignedDivMod	; 023242E4
	cmp r1,#0x0	; 023242E8
	bne P1_Entry_023242F0	; 023242EA
P1_Entry_023242EC:
	mov r0,#0x1	; 023242EC
	b P1_Entry_023242F2	; 023242EE
P1_Entry_023242F0:
	mov r0,#0x0	; 023242F0
P1_Entry_023242F2:
	add sp,#0x4	; 023242F2
	pop {r4,r5}	; 023242F4
	pop {r3}	; 023242F6
	bx r3	; 023242F8
	.byte 0x00, 0x00	; 023242FA
P1_Entry_023242FC:
	push {r4,lr}	; 023242FC
	add r4,r0,#0x0	; 023242FE
	bl loc_0232414C	; 02324300
	cmp r0,#0x0	; 02324304
	bne P1_Entry_0232432A	; 02324306
	add r0,r4,#0x0	; 02324308
	bl loc_0232413C	; 0232430A
	cmp r0,#0x0	; 0232430E
	beq P1_Entry_0232432E	; 02324310
	bl P1_Entry_023240D8	; 02324312
	cmp r0,#0x1e	; 02324316
	bls P1_Entry_0232432E	; 02324318
	bl P1_Entry_023240D8	; 0232431A
	sub r0,#0x1e	; 0232431E
	mov r1,#0xa	; 02324320
	blx P1_UnsignedDivMod	; 02324322
	cmp r1,#0x0	; 02324326
	bne P1_Entry_0232432E	; 02324328
P1_Entry_0232432A:
	mov r0,#0x1	; 0232432A
	b P1_Entry_02324330	; 0232432C
P1_Entry_0232432E:
	mov r0,#0x0	; 0232432E
P1_Entry_02324330:
	pop {r4}	; 02324330
	pop {r3}	; 02324332
	bx r3	; 02324334
	.byte 0x00, 0x00	; 02324336

; ===== function loc_02324338 =====
loc_02324338:
	mov r2,#0x0	; 02324338
	mvn r3,r2	; 0232433A
	ldr r2,[r0,#0x0]	; 0232433C
	cmp r2,r1	; 0232433E
	bne loc_02324344	; 02324340
	ldr r3,[r0,#0x8]	; 02324342
loc_02324344:
	add r0,r3,#0x0	; 02324344
	bx lr	; 02324346

; ===== function loc_02324348 =====
loc_02324348:
	ldr r2,[r0,#0x8]	; 02324348
	cmp r2,#0x0	; 0232434A
	bne loc_02324358	; 0232434C
	ldr r0,[r0,#0x0]	; 0232434E
	cmp r0,r1	; 02324350
	bne loc_02324358	; 02324352
	mov r0,#0x1	; 02324354
	bx lr	; 02324356
loc_02324358:
	mov r0,#0x0	; 02324358
	bx lr	; 0232435A

; ===== function loc_0232435C =====
loc_0232435C:
	ldr r2,[r0,#0x8]	; 0232435C
	cmp r2,#0x3	; 0232435E
	bne loc_0232436C	; 02324360
	ldr r0,[r0,#0x4]	; 02324362
	cmp r0,r1	; 02324364
	bne loc_0232436C	; 02324366
	mov r0,#0x1	; 02324368
	bx lr	; 0232436A
loc_0232436C:
	mov r0,#0x0	; 0232436C
	bx lr	; 0232436E

; ===== function loc_02324370 =====
loc_02324370:
	push {r4,r5,r6,r7,lr}	; 02324370
	sub sp,#0x4	; 02324372
	add r5,r0,#0x0	; 02324374
	add r4,r1,#0x0	; 02324376
	bl loc_02324108	; 02324378
	add r6,r0,#0x0	; 0232437C
	bl loc_023240FC	; 0232437E
	add r7,r0,#0x0	; 02324382
	bl loc_02324114	; 02324384
	cmp r0,#0x1	; 02324388
	bne loc_023243AC	; 0232438A
	add r0,r4,#0x0	; 0232438C
	add r1,r6,#0x0	; 0232438E
	add r2,r7,#0x0	; 02324390
	bl loc_023291F0	; 02324392
	str r0,[r5,#0x4]	; 02324396
	ldr r0,[r5,#0x4]	; 02324398
	str r0,[r5,#0x0]	; 0232439A
	ldr r1,[r5,#0x0]	; 0232439C
	mov r2,#0x0	; 0232439E
	mvn r0,r2	; 023243A0
	cmp r1,r0	; 023243A2
	bne loc_023243A8	; 023243A4
	add r2,r0,#0x0	; 023243A6
loc_023243A8:
	str r2,[r5,#0x8]	; 023243A8
	b loc_02324412	; 023243AA
loc_023243AC:
	ldr r1,[r5,#0x0]	; 023243AC
	mov r0,#0x0	; 023243AE
	mvn r0,r0	; 023243B0
	cmp r1,r0	; 023243B2
	beq loc_023243DC	; 023243B4
	bl loc_02324114	; 023243B6
	cmp r0,#0x2	; 023243BA
	bne loc_023243DC	; 023243BC
	add r0,r4,#0x0	; 023243BE
	add r1,r6,#0x0	; 023243C0
	add r2,r7,#0x0	; 023243C2
	bl loc_023291F0	; 023243C4
	str r0,[r5,#0x4]	; 023243C8
	ldr r1,[r5,#0x0]	; 023243CA
	ldr r0,[r5,#0x4]	; 023243CC
	cmp r1,r0	; 023243CE
	bne loc_023243D6	; 023243D0
	mov r0,#0x1	; 023243D2
	b loc_023243D8	; 023243D4
loc_023243D6:
	mov r0,#0x2	; 023243D6
loc_023243D8:
	str r0,[r5,#0x8]	; 023243D8
	b loc_02324412	; 023243DA
loc_023243DC:
	ldr r1,[r5,#0x0]	; 023243DC
	mov r0,#0x0	; 023243DE
	mvn r0,r0	; 023243E0
	cmp r1,r0	; 023243E2
	beq loc_0232440C	; 023243E4
	bl loc_02324114	; 023243E6
	cmp r0,#0x3	; 023243EA
	bne loc_0232440C	; 023243EC
	add r0,r4,#0x0	; 023243EE
	add r1,r6,#0x0	; 023243F0
	add r2,r7,#0x0	; 023243F2
	bl loc_023291F0	; 023243F4
	str r0,[r5,#0x4]	; 023243F8
	ldr r1,[r5,#0x0]	; 023243FA
	ldr r0,[r5,#0x4]	; 023243FC
	cmp r1,r0	; 023243FE
	bne loc_02324406	; 02324400
	mov r0,#0x3	; 02324402
	b loc_02324408	; 02324404
loc_02324406:
	mov r0,#0x2	; 02324406
loc_02324408:
	str r0,[r5,#0x8]	; 02324408
	b loc_02324412	; 0232440A
loc_0232440C:
	add r0,r5,#0x0	; 0232440C
	bl loc_0232441C	; 0232440E
loc_02324412:
	add sp,#0x4	; 02324412
	pop {r4,r5,r6,r7}	; 02324414
	pop {r3}	; 02324416
	bx r3	; 02324418
	.byte 0x00, 0x00	; 0232441C

; ===== function loc_0232441C =====
loc_0232441C:
	mov r1,#0x0	; 0232441C
	mvn r1,r1	; 0232441E
	str r1,[r0,#0x0]	; 02324420
	str r1,[r0,#0x4]	; 02324422
	str r1,[r0,#0x8]	; 02324424
	bx lr	; 02324426

; ===== function loc_02324428 =====
	push {r4,r5,r6,r7,lr}	; 02324428
	sub sp,#0x14	; 0232442A
	add r7,r0,#0x0	; 0232442C
	str r1,[sp,#0x8]	; 0232442E
	add r5,r2,#0x0	; 02324430
	str r3,[sp,#0xc]	; 02324432
	ldr r4,[sp,#0x28]	; 02324434
	ldr r6,[sp,#0x2c]	; 02324436
	b loc_0232444C	; 02324438
loc_0232443A:
	str r5,[sp,#0x0]	; 0232443A
	str r6,[sp,#0x4]	; 0232443C
	add r0,r7,#0x0	; 0232443E
	ldr r1,[sp,#0x8]	; 02324440
	add r2,r5,#0x0	; 02324442
	ldr r3,[sp,#0xc]	; 02324444
	bl loc_02324458	; 02324446
	add r5,r5,#0x1	; 0232444A
loc_0232444C:
	cmp r5,r4	; 0232444C
	blt loc_0232443A	; 0232444E
	add sp,#0x14	; 02324450
	pop {r4,r5,r6,r7}	; 02324452
	pop {r3}	; 02324454
	bx r3	; 02324456

; ===== function loc_02324458 =====
loc_02324458:
	push {r4,r5,r6,r7,lr}	; 02324458
	sub sp,#0x1c	; 0232445A
	str r0,[sp,#0x0]	; 0232445C
	add r5,r1,#0x0	; 0232445E
	add r4,r2,#0x0	; 02324460
	add r7,r3,#0x0	; 02324462
	ldr r6,[sp,#0x30]	; 02324464
	ldr r0,[sp,#0x34]	; 02324466
	str r0,[sp,#0x34]	; 02324468
	add r0,r5,#0x0	; 0232446A
	add r1,r7,#0x0	; 0232446C
	bl loc_0232450C	; 0232446E
	str r0,[sp,#0x14]	; 02324472
	add r0,r4,#0x0	; 02324474
	add r1,r6,#0x0	; 02324476
	bl loc_0232450C	; 02324478
	ldr r1,[sp,#0x14]	; 0232447C
	cmp r1,r0	; 0232447E
	ble loc_023244C4	; 02324480
	cmp r5,r7	; 02324482
	ble loc_02324492	; 02324484
	add r0,r5,#0x0	; 02324486
	add r5,r7,#0x0	; 02324488
	add r7,r0,#0x0	; 0232448A
	add r0,r4,#0x0	; 0232448C
	add r4,r6,#0x0	; 0232448E
	add r6,r0,#0x0	; 02324490
loc_02324492:
	sub r0,r7,r5	; 02324492
	str r0,[sp,#0x4]	; 02324494
	sub r0,r6,r4	; 02324496
	lsl r0,r0,#0xc	; 02324498
	ldr r1,[sp,#0x4]	; 0232449A
	blx P1_SignedDivMod	; 0232449C
	str r0,[sp,#0xc]	; 023244A0
	mov r6,#0x0	; 023244A2
	add r7,r6,#0x0	; 023244A4
	b loc_023244BC	; 023244A6
loc_023244A8:
	ldr r0,[sp,#0x0]	; 023244A8
	add r1,r5,r6	; 023244AA
	asr r2,r7,#0xc	; 023244AC
	add r2,r4,r2	; 023244AE
	ldr r3,[sp,#0x34]	; 023244B0
	bl loc_02324518	; 023244B2
	add r6,r6,#0x1	; 023244B6
	ldr r0,[sp,#0xc]	; 023244B8
	add r7,r7,r0	; 023244BA
loc_023244BC:
	ldr r0,[sp,#0x4]	; 023244BC
	cmp r6,r0	; 023244BE
	blt loc_023244A8	; 023244C0
	b loc_02324504	; 023244C2
loc_023244C4:
	cmp r4,r6	; 023244C4
	ble loc_023244D4	; 023244C6
	add r0,r5,#0x0	; 023244C8
	add r5,r7,#0x0	; 023244CA
	add r7,r0,#0x0	; 023244CC
	add r0,r4,#0x0	; 023244CE
	add r4,r6,#0x0	; 023244D0
	add r6,r0,#0x0	; 023244D2
loc_023244D4:
	sub r0,r6,r4	; 023244D4
	str r0,[sp,#0x8]	; 023244D6
	sub r0,r7,r5	; 023244D8
	lsl r0,r0,#0xc	; 023244DA
	ldr r1,[sp,#0x8]	; 023244DC
	blx P1_SignedDivMod	; 023244DE
	str r0,[sp,#0x10]	; 023244E2
	mov r6,#0x0	; 023244E4
	add r7,r6,#0x0	; 023244E6
	b loc_023244FE	; 023244E8
loc_023244EA:
	ldr r0,[sp,#0x0]	; 023244EA
	asr r1,r7,#0xc	; 023244EC
	add r1,r5,r1	; 023244EE
	add r2,r4,r6	; 023244F0
	ldr r3,[sp,#0x34]	; 023244F2
	bl loc_02324518	; 023244F4
	add r6,r6,#0x1	; 023244F8
	ldr r0,[sp,#0x10]	; 023244FA
	add r7,r7,r0	; 023244FC
loc_023244FE:
	ldr r0,[sp,#0x8]	; 023244FE
	cmp r6,r0	; 02324500
	blt loc_023244EA	; 02324502
loc_02324504:
	add sp,#0x1c	; 02324504
	pop {r4,r5,r6,r7}	; 02324506
	pop {r3}	; 02324508
	bx r3	; 0232450A

; ===== function loc_0232450C =====
loc_0232450C:
	cmp r0,r1	; 0232450C
	ble loc_02324514	; 0232450E
	sub r0,r0,r1	; 02324510
	bx lr	; 02324512
loc_02324514:
	sub r0,r1,r0	; 02324514
	bx lr	; 02324516

; ===== function loc_02324518 =====
loc_02324518:
	push {r4,r5,r6,r7,lr}	; 02324518
	sub sp,#0x1c	; 0232451A
	add r5,r0,#0x0	; 0232451C
	add r4,r1,#0x0	; 0232451E
	add r6,r2,#0x0	; 02324520
	str r3,[sp,#0x0]	; 02324522
	asr r0,r4,#0x3	; 02324524
	str r0,[sp,#0x4]	; 02324526
	asr r0,r6,#0x3	; 02324528
	str r0,[sp,#0x8]	; 0232452A
	mov r1,#0x3	; 0232452C
	add r0,r4,#0x0	; 0232452E
	str r0,[sp,#0xc]	; 02324530
	and r0,r1	; 02324532
	str r0,[sp,#0xc]	; 02324534
	asr r7,r4,#0x2	; 02324536
	mov r0,#0x1	; 02324538
	and r7,r0	; 0232453A
	mov r1,#0x7	; 0232453C
	add r0,r6,#0x0	; 0232453E
	str r0,[sp,#0x10]	; 02324540
	and r0,r1	; 02324542
	str r0,[sp,#0x10]	; 02324544
	ldrh r0,[r5,#0x4]	; 02324546
	str r0,[sp,#0x14]	; 02324548
	lsl r0,r0,#0x4	; 0232454A
	mov r1,#0x8	; 0232454C
	blx P1_SignedDivMod	; 0232454E
	ldr r1,[r5,#0x0]	; 02324552
	ldr r2,[sp,#0x14]	; 02324554
	cmp r4,r2	; 02324556
	bgt loc_02324592	; 02324558
	ldrh r2,[r5,#0x6]	; 0232455A
	cmp r6,r2	; 0232455C
	bgt loc_02324592	; 0232455E
	ldr r2,[sp,#0x4]	; 02324560
	lsl r3,r2,#0x4	; 02324562
	ldr r2,[sp,#0x8]	; 02324564
	mul r0,r2	; 02324566
	add r0,r3,r0	; 02324568
	lsl r0,r0,#0x1	; 0232456A
	add r4,r1,r0	; 0232456C
	ldr r0,[sp,#0x10]	; 0232456E
	lsl r0,r0,#0x1	; 02324570
	add r0,r7,r0	; 02324572
	lsl r3,r0,#0x1	; 02324574
	ldr r0,[sp,#0xc]	; 02324576
	lsl r2,r0,#0x2	; 02324578
	ldrh r1,[r4,r3]	; 0232457A
	mov r0,#0xf	; 0232457C
	add r5,r0,#0x0	; 0232457E
	lsl r5,r2	; 02324580
	bic r1,r5	; 02324582
	ldr r5,[sp,#0x0]	; 02324584
	lsl r5,r5,#0x18	; 02324586
	lsr r5,r5,#0x18	; 02324588
	and r5,r0	; 0232458A
	lsl r5,r2	; 0232458C
	orr r1,r5	; 0232458E
	strh r1,[r4,r3]	; 02324590
loc_02324592:
	add sp,#0x1c	; 02324592
	pop {r4,r5,r6,r7}	; 02324594
	pop {r3}	; 02324596
	bx r3	; 02324598
	.byte 0x00, 0x00	; 0232459C

; ===== function loc_0232459C =====
loc_0232459C:
	ldr r0,[pool_023245A0]	; 0232459C
	bx lr	; 0232459E
pool_023245A0:
loc_023245A0:
	.word 0x0233404C	; 023245A0

; ===== function loc_023245A4 =====
loc_023245A4:
	push {lr}	; 023245A4
	sub sp,#0x4	; 023245A6
	cmp r0,#0x8	; 023245A8
	bhi loc_023245FA	; 023245AA
	add r0,r0,r0	; 023245AC
P1_SwitchIndexPC_023245AC:
	add r0,pc	; 023245AE
	ldrh r0,[r0,#(P1_SwitchTable_023245AC - (P1_SwitchIndexPC_023245AC + 4))]	; 023245B0
	lsl r0,r0,#0x10	; 023245B2
	asr r0,r0,#0x10	; 023245B4
P1_SwitchTargetPC_023245AC:
	add r0,pc	; 023245B6
	bx r0	; 023245B8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023245AC:
	.halfword (loc_023245FA + 1) - (P1_SwitchTargetPC_023245AC + 4)
	.halfword (loc_023245CC + 1) - (P1_SwitchTargetPC_023245AC + 4)
	.halfword (loc_023245D8 + 1) - (P1_SwitchTargetPC_023245AC + 4)
	.halfword (loc_023245FA + 1) - (P1_SwitchTargetPC_023245AC + 4)
	.halfword (loc_023245E4 + 1) - (P1_SwitchTargetPC_023245AC + 4)
	.halfword (loc_023245FA + 1) - (P1_SwitchTargetPC_023245AC + 4)
	.halfword (loc_023245FA + 1) - (P1_SwitchTargetPC_023245AC + 4)
	.halfword (loc_023245FA + 1) - (P1_SwitchTargetPC_023245AC + 4)
	.halfword (loc_023245F0 + 1) - (P1_SwitchTargetPC_023245AC + 4)
P1_SwitchTable_023245ACEnd:
loc_023245CC:
	ldr r0,[pool_02324600]	; 023245CC
	mov r1,#0x0	; 023245CE
	ldr r2,[pool_02324604]	; 023245D0
	bl loc_0232DBB8	; 023245D2
	b loc_023245FA	; 023245D6
loc_023245D8:
	ldr r0,[pool_02324600]	; 023245D8
	mov r1,#0x0	; 023245DA
	ldr r2,[pool_02324604]	; 023245DC
	bl loc_0232DB68	; 023245DE
	b loc_023245FA	; 023245E2
loc_023245E4:
	ldr r0,[pool_02324600]	; 023245E4
	mov r1,#0x0	; 023245E6
	ldr r2,[pool_02324604]	; 023245E8
	bl loc_0232DB18	; 023245EA
	b loc_023245FA	; 023245EE
loc_023245F0:
	ldr r0,[pool_02324600]	; 023245F0
	mov r1,#0x0	; 023245F2
	ldr r2,[pool_02324604]	; 023245F4
	bl loc_0232DAC8	; 023245F6
loc_023245FA:
	add sp,#0x4	; 023245FA
	pop {r3}	; 023245FC
	bx r3	; 023245FE
pool_02324600:
loc_02324600:
	.word 0x0233404C	; 02324600
pool_02324604:
loc_02324604:
	.word 0x00000600	; 02324604

; ===== function loc_02324608 =====
P1_Entry_02324608:
	push {lr}	; 02324608
	sub sp,#0x4	; 0232460A
	mov r0,#0x0	; 0232460C
	str r0,[sp,#0x0]	; 0232460E
	ldr r0,[sp,#0x0]	; 02324610
	ldr r1,[pool_02324628]	; 02324612
	ldr r2,[pool_0232462C]	; 02324614
	blx loc_0232DE78	; 02324616
	ldr r0,[pool_02324628]	; 0232461A
	ldr r1,[pool_0232462C]	; 0232461C
	blx P1_CleanDataCacheRange	; 0232461E
	add sp,#0x4	; 02324622
	pop {r3}	; 02324624
	bx r3	; 02324626
pool_02324628:
loc_02324628:
	.word 0x0233404C	; 02324628
pool_0232462C:
loc_0232462C:
	.word 0x00000600	; 0232462C

; ===== function loc_02324630 =====
loc_02324630:
	push {r4,r5,r6,r7,lr}	; 02324630
	sub sp,#0x54	; 02324632
	add r5,r0,#0x0	; 02324634
	add r4,r1,#0x0	; 02324636
	add r7,r2,#0x0	; 02324638
	str r3,[sp,#0x20]	; 0232463A
	ldr r0,[sp,#0x74]	; 0232463C
	str r0,[sp,#0x74]	; 0232463E
	ldr r1,[pool_0232477C]	; 02324640
	ldrh r2,[r1,#0x0]	; 02324642
	add r0,sp,#0x38	; 02324644
	strh r2,[r0,#0x18]	; 02324646
	ldrh r1,[r1,#0x2]	; 02324648
	strh r1,[r0,#0x1a]	; 0232464A
	ldr r0,[sp,#0x68]	; 0232464C
	ldr r1,[pool_02324780]	; 0232464E
	cmp r0,r1	; 02324650
	bne loc_0232466E	; 02324652
	add r0,r7,#0x0	; 02324654
	lsl r1,r3,#0	; 02324656
	bl loc_02329198	; 02324658
	ldr r0,[r0,#0x8]	; 0232465C
	cmp r0,#0x0	; 0232465E
	beq loc_02324668	; 02324660
	add r0,r7,r0	; 02324662
	str r0,[sp,#0x28]	; 02324664
	b loc_0232467E	; 02324666
loc_02324668:
	add r0,sp,#0x50	; 02324668
	str r0,[sp,#0x28]	; 0232466A
	b loc_0232467E	; 0232466C
loc_0232466E:
	bl loc_02324DE0	; 0232466E
	str r0,[sp,#0x28]	; 02324672
	ldrh r0,[r0,#0x0]	; 02324674
	cmp r0,#0x0	; 02324676
	bne loc_0232467E	; 02324678
	add r0,sp,#0x50	; 0232467A
	str r0,[sp,#0x28]	; 0232467C
loc_0232467E:
	ldr r0,[sp,#0x6c]	; 0232467E
	cmp r0,#0x0	; 02324680
	beq loc_02324686	; 02324682
	str r0,[sp,#0x28]	; 02324684
loc_02324686:
	add r0,sp,#0x48	; 02324686
	str r0,[sp,#0x0]	; 02324688
	add r0,sp,#0x4c	; 0232468A
	str r0,[sp,#0x4]	; 0232468C
	ldr r0,[sp,#0x28]	; 0232468E
	str r0,[sp,#0x8]	; 02324690
	add r0,r7,#0x0	; 02324692
	ldr r1,[sp,#0x20]	; 02324694
	add r2,sp,#0x40	; 02324696
	add r3,sp,#0x44	; 02324698
	bl loc_023248AC	; 0232469A
	str r5,[r4,#0x24]	; 0232469E
	str r7,[r4,#0x20]	; 023246A0
	ldr r0,[sp,#0x68]	; 023246A2
	strh r0,[r4,#0x1a]	; 023246A4
	ldr r0,[sp,#0x20]	; 023246A6
	strh r0,[r4,#0x1c]	; 023246A8
	mov r1,#0x0	; 023246AA
	add r0,r4,#0x0	; 023246AC
	add r0,#0x28	; 023246AE
	strb r1,[r0,#0x0]	; 023246B0
	add r0,r7,#0x0	; 023246B2
	ldr r1,[sp,#0x20]	; 023246B4
	bl loc_02329198	; 023246B6
	ldrh r0,[r0,#0x6]	; 023246BA
	lsl r0,r0,#0x14	; 023246BC
	lsr r0,r0,#0x1c	; 023246BE
	strh r0,[r4,#0x16]	; 023246C0
	ldr r0,[sp,#0x40]	; 023246C2
	strh r0,[r4,#0x8]	; 023246C4
	ldr r0,[sp,#0x44]	; 023246C6
	strh r0,[r4,#0xa]	; 023246C8
	ldr r0,[sp,#0x48]	; 023246CA
	strb r0,[r4,#0xc]	; 023246CC
	ldr r0,[sp,#0x4c]	; 023246CE
	strb r0,[r4,#0xd]	; 023246D0
	ldr r0,[sp,#0x70]	; 023246D2
	cmp r0,#0x0	; 023246D4
	beq loc_02324708	; 023246D6
	add r0,r5,#0x0	; 023246D8
	add r1,r4,#0x0	; 023246DA
	bl loc_02329670	; 023246DC
	ldrh r0,[r5,#0xe]	; 023246E0
	strh r0,[r4,#0x14]	; 023246E2
	ldr r0,[sp,#0x48]	; 023246E4
	ldr r1,[sp,#0x4c]	; 023246E6
	bl loc_02324920	; 023246E8
	str r0,[r4,#0x10]	; 023246EC
	ldr r0,[r4,#0x10]	; 023246EE
	add r1,sp,#0x38	; 023246F0
	add r2,sp,#0x3c	; 023246F2
	bl loc_02324990	; 023246F4
	ldr r0,[sp,#0x48]	; 023246F8
	sub r0,r0,#0x1	; 023246FA
	ldr r1,[sp,#0x38]	; 023246FC
	blx P1_SignedDivMod	; 023246FE
	add r0,r0,#0x1	; 02324702
	strh r0,[r4,#0x18]	; 02324704
	b loc_02324712	; 02324706
loc_02324708:
	ldr r0,[r4,#0x10]	; 02324708
	add r1,sp,#0x38	; 0232470A
	add r2,sp,#0x3c	; 0232470C
	bl loc_02324990	; 0232470E
loc_02324712:
	ldrh r0,[r4,#0x14]	; 02324712
	str r0,[sp,#0x34]	; 02324714
	mov r0,#0x0	; 02324716
	str r0,[sp,#0x24]	; 02324718
	str r0,[sp,#0x2c]	; 0232471A
	b loc_02324760	; 0232471C
loc_0232471E:
	ldr r0,[sp,#0x38]	; 0232471E
	str r0,[sp,#0x30]	; 02324720
	ldr r0,[sp,#0x2c]	; 02324722
	str r0,[sp,#0x0]	; 02324724
	ldr r0,[sp,#0x30]	; 02324726
	str r0,[sp,#0x4]	; 02324728
	ldr r0,[sp,#0x3c]	; 0232472A
	str r0,[sp,#0x8]	; 0232472C
	ldr r0,[sp,#0x34]	; 0232472E
	str r0,[sp,#0xc]	; 02324730
	ldr r0,[sp,#0x40]	; 02324732
	str r0,[sp,#0x10]	; 02324734
	ldr r0,[sp,#0x44]	; 02324736
	str r0,[sp,#0x14]	; 02324738
	ldr r0,[sp,#0x28]	; 0232473A
	str r0,[sp,#0x18]	; 0232473C
	ldr r0,[sp,#0x74]	; 0232473E
	str r0,[sp,#0x1c]	; 02324740
	add r0,r5,#0x0	; 02324742
	add r1,r7,#0x0	; 02324744
	ldr r2,[sp,#0x20]	; 02324746
	ldr r6,[sp,#0x24]	; 02324748
	ldr r3,[sp,#0x30]	; 0232474A
	mul r3,r6	; 0232474C
	str r3,[sp,#0x30]	; 0232474E
	bl loc_02324784	; 02324750
	ldr r1,[sp,#0x34]	; 02324754
	add r0,r1,r0	; 02324756
	str r0,[sp,#0x34]	; 02324758
	ldr r0,[sp,#0x24]	; 0232475A
	add r0,r0,#0x1	; 0232475C
	str r0,[sp,#0x24]	; 0232475E
loc_02324760:
	ldrh r1,[r4,#0x18]	; 02324760
	ldr r0,[sp,#0x24]	; 02324762
	cmp r0,r1	; 02324764
	blt loc_0232471E	; 02324766
	ldr r0,[sp,#0x70]	; 02324768
	cmp r0,#0x0	; 0232476A
	beq loc_02324772	; 0232476C
	ldr r0,[sp,#0x34]	; 0232476E
	strh r0,[r5,#0xe]	; 02324770
loc_02324772:
	add sp,#0x54	; 02324772
	pop {r4,r5,r6,r7}	; 02324774
	pop {r3}	; 02324776
	bx r3	; 02324778
	.byte 0xC0, 0x46	; 0232477C
pool_0232477C:
loc_0232477C:
	.word P1_Data_02330708	; 0232477C
pool_02324780:
loc_02324780:
	.word 0x0000FFFF	; 02324780

; ===== function loc_02324784 =====
loc_02324784:
	push {r4,r5,r6,r7,lr}	; 02324784
	sub sp,#0x34	; 02324786
	add r5,r0,#0x0	; 02324788
	str r1,[sp,#0x10]	; 0232478A
	str r2,[sp,#0x14]	; 0232478C
	str r3,[sp,#0x18]	; 0232478E
	ldr r0,[sp,#0x4c]	; 02324790
	mov r1,#0x8	; 02324792
	blx P1_SignedDivMod	; 02324794
	add r6,r0,#0x0	; 02324798
	ldr r0,[sp,#0x50]	; 0232479A
	mov r1,#0x8	; 0232479C
	blx P1_SignedDivMod	; 0232479E
	mul r6,r0	; 023247A2
	ldr r1,[sp,#0x54]	; 023247A4
	ldrh r0,[r5,#0xc]	; 023247A6
	sub r0,r1,r0	; 023247A8
	lsl r4,r0,#0x7	; 023247AA
	bl loc_02324CAC	; 023247AC
	add r7,r0,#0x0	; 023247B0
	ldr r0,[sp,#0x10]	; 023247B2
	ldr r1,[sp,#0x14]	; 023247B4
	bl loc_02329198	; 023247B6
	mov r0,#0x0	; 023247BA
	str r0,[sp,#0x20]	; 023247BC
	ldr r0,[sp,#0x4c]	; 023247BE
	ldr r1,[sp,#0x50]	; 023247C0
	mul r0,r1	; 023247C2
	mov r1,#0x2	; 023247C4
	blx P1_SignedDivMod	; 023247C6
	add r2,r0,#0x0	; 023247CA
	ldr r0,[sp,#0x20]	; 023247CC
	ldr r1,[r5,#0x14]	; 023247CE
	add r1,r1,r4	; 023247D0
	blx loc_0232DE78	; 023247D2
	mov r0,#0x0	; 023247D6
	str r0,[sp,#0x0]	; 023247D8
	str r7,[sp,#0x4]	; 023247DA
	add r0,sp,#0x24	; 023247DC
	ldr r1,[r5,#0x14]	; 023247DE
	add r1,r1,r4	; 023247E0
	ldr r2,[sp,#0x4c]	; 023247E2
	lsl r2,r2,#0x10	; 023247E4
	lsr r2,r2,#0x10	; 023247E6
	ldr r3,[sp,#0x50]	; 023247E8
	lsl r3,r3,#0x10	; 023247EA
	lsr r3,r3,#0x10	; 023247EC
	bl loc_02329028	; 023247EE
	ldr r0,[sp,#0x10]	; 023247F2
	ldr r1,[sp,#0x14]	; 023247F4
	bl loc_02329198	; 023247F6
	add r4,r0,#0x0	; 023247FA
	add r5,sp,#0x1c	; 023247FC
	ldrh r1,[r4,#0x0]	; 023247FE
	add r0,sp,#0x1c	; 02324800
	strh r1,[r0,#0x0]	; 02324802
	mov r0,#0x0	; 02324804
	ldrsh r1,[r5,r0]	; 02324806
	add r3,r1,#0x0	; 02324808
	ldr r0,[pool_023248A4]	; 0232480A
	and r3,r0	; 0232480C
	lsl r0,r1,#0x14	; 0232480E
	asr r2,r0,#0x14	; 02324810
	ldr r1,[sp,#0x58]	; 02324812
	ldr r0,[sp,#0x18]	; 02324814
	add r0,r1,r0	; 02324816
	sub r0,r2,r0	; 02324818
	lsl r0,r0,#0x10	; 0232481A
	asr r1,r0,#0x10	; 0232481C
	ldr r0,[pool_023248A8]	; 0232481E
	and r1,r0	; 02324820
	orr r3,r1	; 02324822
	strh r3,[r5,#0x0]	; 02324824
	add r5,sp,#0x1c	; 02324826
	add r5,#0x2	; 02324828
	ldrh r1,[r4,#0x2]	; 0232482A
	add r0,sp,#0x1c	; 0232482C
	strh r1,[r0,#0x2]	; 0232482E
	mov r0,#0x0	; 02324830
	ldrsh r1,[r5,r0]	; 02324832
	add r3,r1,#0x0	; 02324834
	ldr r0,[pool_023248A4]	; 02324836
	and r3,r0	; 02324838
	lsl r0,r1,#0x14	; 0232483A
	asr r2,r0,#0x14	; 0232483C
	ldr r1,[sp,#0x5c]	; 0232483E
	ldr r0,[sp,#0x48]	; 02324840
	add r0,r1,r0	; 02324842
	sub r0,r2,r0	; 02324844
	lsl r0,r0,#0x10	; 02324846
	asr r1,r0,#0x10	; 02324848
	ldr r0,[pool_023248A8]	; 0232484A
	and r1,r0	; 0232484C
	orr r3,r1	; 0232484E
	strh r3,[r5,#0x0]	; 02324850
	ldr r0,[sp,#0x64]	; 02324852
	mov r1,#0x0	; 02324854
	mvn r1,r1	; 02324856
	cmp r0,r1	; 02324858
	bne loc_0232485E	; 0232485A
	ldrb r0,[r4,#0x6]	; 0232485C
loc_0232485E:
	mov r1,#0x4	; 0232485E
	ldrsb r1,[r4,r1]	; 02324860
	str r1,[sp,#0x0]	; 02324862
	mov r1,#0x5	; 02324864
	ldrsb r1,[r4,r1]	; 02324866
	str r1,[sp,#0x4]	; 02324868
	ldr r1,[sp,#0x60]	; 0232486A
	str r1,[sp,#0x8]	; 0232486C
	str r0,[sp,#0xc]	; 0232486E
	ldrh r0,[r4,#0x6]	; 02324870
	lsl r0,r0,#0x10	; 02324872
	lsr r0,r0,#0x1c	; 02324874
	lsl r0,r0,#0x5	; 02324876
	add r0,r7,r0	; 02324878
	add r1,sp,#0x24	; 0232487A
	mov r4,sp	; 0232487C
	sub r4,r4,#0x4	; 0232487E
	add r5,sp,#0x1c	; 02324880
	ldrh r2,[r5,#0x0]	; 02324882
	strh r2,[r4,#0x0]	; 02324884
	add r3,r4,#0x0	; 02324886
	ldmia r3!,{r2}	; 02324888
	ldrh r3,[r5,#0x2]	; 0232488A
	strh r3,[r4,#0x0]	; 0232488C
	ldmia r4!,{r3}	; 0232488E
	bl loc_02328CC8	; 02324890
	add r0,r6,#0x0	; 02324894
	mov r1,#0x4	; 02324896
	blx P1_SignedDivMod	; 02324898
	add sp,#0x34	; 0232489C
	pop {r4,r5,r6,r7}	; 0232489E
	pop {r3}	; 023248A0
	bx r3	; 023248A2
pool_023248A4:
loc_023248A4:
	.word 0xFFFFF000	; 023248A4
pool_023248A8:
loc_023248A8:
	.word 0x00000FFF	; 023248A8

; ===== function loc_023248AC =====
loc_023248AC:
	push {r4,r5,r6,r7,lr}	; 023248AC
	sub sp,#0x4	; 023248AE
	add r7,r2,#0x0	; 023248B0
	str r3,[sp,#0x0]	; 023248B2
	ldr r5,[sp,#0x18]	; 023248B4
	ldr r6,[sp,#0x1c]	; 023248B6
	bl loc_02329198	; 023248B8
	add r4,r0,#0x0	; 023248BC
	bl loc_02324CAC	; 023248BE
	ldrh r1,[r4,#0x6]	; 023248C2
	lsl r1,r1,#0x10	; 023248C4
	lsr r1,r1,#0x1c	; 023248C6
	lsl r1,r1,#0x5	; 023248C8
	add r0,r0,r1	; 023248CA
	ldr r1,[sp,#0x20]	; 023248CC
	mov r2,#0x4	; 023248CE
	ldrsb r2,[r4,r2]	; 023248D0
	bl loc_02328C18	; 023248D2
	str r0,[r5,#0x0]	; 023248D6
	bl loc_02324CAC	; 023248D8
	ldrh r1,[r4,#0x6]	; 023248DC
	lsl r1,r1,#0x10	; 023248DE
	lsr r1,r1,#0x1c	; 023248E0
	lsl r1,r1,#0x5	; 023248E2
	add r0,r0,r1	; 023248E4
	ldr r1,[sp,#0x20]	; 023248E6
	mov r2,#0x5	; 023248E8
	ldrsb r2,[r4,r2]	; 023248EA
	bl loc_02328BF8	; 023248EC
	str r0,[r6,#0x0]	; 023248F0
	mov r1,sp	; 023248F2
	sub r1,r1,#0x4	; 023248F4
	ldrh r0,[r4,#0x0]	; 023248F6
	strh r0,[r1,#0x0]	; 023248F8
	ldmia r1!,{r0}	; 023248FA
	ldr r1,[r5,#0x0]	; 023248FC
	bl loc_023290E0	; 023248FE
	str r0,[r7,#0x0]	; 02324902
	mov r1,sp	; 02324904
	sub r1,r1,#0x4	; 02324906
	ldrh r0,[r4,#0x2]	; 02324908
	strh r0,[r1,#0x0]	; 0232490A
	ldmia r1!,{r0}	; 0232490C
	ldr r1,[r6,#0x0]	; 0232490E
	bl loc_023290A8	; 02324910
	ldr r1,[sp,#0x0]	; 02324914
	str r0,[r1,#0x0]	; 02324916
	add sp,#0x4	; 02324918
	pop {r4,r5,r6,r7}	; 0232491A
	pop {r3}	; 0232491C
	bx r3	; 0232491E

; ===== function loc_02324920 =====
loc_02324920:
	push {r4,r5,lr}	; 02324920
	sub sp,#0x4	; 02324922
	add r5,r1,#0x0	; 02324924
	sub r0,r0,#0x1	; 02324926
	mov r1,#0x8	; 02324928
	blx P1_SignedDivMod	; 0232492A
	add r4,r0,#0x1	; 0232492E
	sub r0,r5,#0x1	; 02324930
	mov r1,#0x8	; 02324932
	blx P1_SignedDivMod	; 02324934
	add r0,r0,#0x1	; 02324938
	cmp r4,#0x2	; 0232493A
	bgt loc_0232494A	; 0232493C
	cmp r0,#0x2	; 0232493E
	bgt loc_02324946	; 02324940
	ldr r0,[pool_0232497C]	; 02324942
	b loc_02324974	; 02324944
loc_02324946:
	ldr r0,[pool_02324980]	; 02324946
	b loc_02324974	; 02324948
loc_0232494A:
	cmp r4,#0x4	; 0232494A
	bgt loc_02324962	; 0232494C
	cmp r0,#0x2	; 0232494E
	bgt loc_02324956	; 02324950
	ldr r0,[pool_02324984]	; 02324952
	b loc_02324974	; 02324954
loc_02324956:
	cmp r0,#0x4	; 02324956
	bgt loc_0232495E	; 02324958
	ldr r0,[pool_02324980]	; 0232495A
	b loc_02324974	; 0232495C
loc_0232495E:
	ldr r0,[pool_02324988]	; 0232495E
	b loc_02324974	; 02324960
loc_02324962:
	cmp r0,#0x2	; 02324962
	bgt loc_0232496A	; 02324964
	ldr r0,[pool_02324984]	; 02324966
	b loc_02324974	; 02324968
loc_0232496A:
	cmp r0,#0x4	; 0232496A
	bgt loc_02324972	; 0232496C
	ldr r0,[pool_0232498C]	; 0232496E
	b loc_02324974	; 02324970
loc_02324972:
	ldr r0,[pool_02324988]	; 02324972
loc_02324974:
	add sp,#0x4	; 02324974
	pop {r4,r5}	; 02324976
	pop {r3}	; 02324978
	bx r3	; 0232497A
pool_0232497C:
loc_0232497C:
	.word 0x40000000	; 0232497C
pool_02324980:
loc_02324980:
	.word 0x80000000	; 02324980
pool_02324984:
loc_02324984:
	.word 0x80004000	; 02324984
pool_02324988:
loc_02324988:
	.word 0xC0000000	; 02324988
pool_0232498C:
loc_0232498C:
	.word 0xC0004000	; 0232498C

; ===== function loc_02324990 =====
loc_02324990:
	push {r4,lr}	; 02324990
	ldr r4,[pool_02324A54]	; 02324992
	cmp r0,r4	; 02324994
	bgt loc_023249CE	; 02324996
	cmp r0,r4	; 02324998
	bge loc_02324A46	; 0232499A
	ldr r4,[pool_02324A58]	; 0232499C
	cmp r0,r4	; 0232499E
	bgt loc_023249BA	; 023249A0
	cmp r0,r4	; 023249A2
	bge loc_02324A40	; 023249A4
	ldr r4,[pool_02324A5C]	; 023249A6
	cmp r0,r4	; 023249A8
	bgt loc_023249B2	; 023249AA
	cmp r0,r4	; 023249AC
	beq loc_02324A10	; 023249AE
	b loc_02324A4A	; 023249B0
loc_023249B2:
	ldr r4,[pool_02324A60]	; 023249B2
	cmp r0,r4	; 023249B4
	beq loc_02324A28	; 023249B6
	b loc_02324A4A	; 023249B8
loc_023249BA:
	ldr r4,[pool_02324A64]	; 023249BA
	cmp r0,r4	; 023249BC
	bgt loc_023249C6	; 023249BE
	cmp r0,r4	; 023249C0
	beq loc_02324A16	; 023249C2
	b loc_02324A4A	; 023249C4
loc_023249C6:
	ldr r4,[pool_02324A68]	; 023249C6
	cmp r0,r4	; 023249C8
	beq loc_02324A2E	; 023249CA
	b loc_02324A4A	; 023249CC
loc_023249CE:
	ldr r4,[pool_02324A6C]	; 023249CE
	cmp r0,r4	; 023249D0
	bgt loc_023249EA	; 023249D2
	cmp r0,r4	; 023249D4
	bge loc_02324A34	; 023249D6
	cmp r0,#0x0	; 023249D8
	bgt loc_023249E2	; 023249DA
	cmp r0,#0x0	; 023249DC
	beq loc_02324A04	; 023249DE
	b loc_02324A4A	; 023249E0
loc_023249E2:
	ldr r4,[pool_02324A70]	; 023249E2
	cmp r0,r4	; 023249E4
	beq loc_02324A1C	; 023249E6
	b loc_02324A4A	; 023249E8
loc_023249EA:
	ldr r4,[pool_02324A74]	; 023249EA
	cmp r0,r4	; 023249EC
	bgt loc_023249FC	; 023249EE
	cmp r0,r4	; 023249F0
	bge loc_02324A22	; 023249F2
	ldr r4,[pool_02324A78]	; 023249F4
	cmp r0,r4	; 023249F6
	beq loc_02324A0A	; 023249F8
	b loc_02324A4A	; 023249FA
loc_023249FC:
	ldr r4,[pool_02324A7C]	; 023249FC
	cmp r0,r4	; 023249FE
	beq loc_02324A3A	; 02324A00
	b loc_02324A4A	; 02324A02
loc_02324A04:
	mov r3,#0x8	; 02324A04
	add r0,r3,#0x0	; 02324A06
	b loc_02324A4A	; 02324A08
loc_02324A0A:
	mov r3,#0x10	; 02324A0A
	add r0,r3,#0x0	; 02324A0C
	b loc_02324A4A	; 02324A0E
loc_02324A10:
	mov r3,#0x20	; 02324A10
	add r0,r3,#0x0	; 02324A12
	b loc_02324A4A	; 02324A14
loc_02324A16:
	mov r3,#0x40	; 02324A16
	add r0,r3,#0x0	; 02324A18
	b loc_02324A4A	; 02324A1A
loc_02324A1C:
	mov r3,#0x10	; 02324A1C
	mov r0,#0x8	; 02324A1E
	b loc_02324A4A	; 02324A20
loc_02324A22:
	mov r3,#0x20	; 02324A22
	mov r0,#0x8	; 02324A24
	b loc_02324A4A	; 02324A26
loc_02324A28:
	mov r3,#0x20	; 02324A28
	mov r0,#0x10	; 02324A2A
	b loc_02324A4A	; 02324A2C
loc_02324A2E:
	mov r3,#0x40	; 02324A2E
	mov r0,#0x20	; 02324A30
	b loc_02324A4A	; 02324A32
loc_02324A34:
	mov r3,#0x8	; 02324A34
	mov r0,#0x10	; 02324A36
	b loc_02324A4A	; 02324A38
loc_02324A3A:
	mov r3,#0x8	; 02324A3A
	mov r0,#0x20	; 02324A3C
	b loc_02324A4A	; 02324A3E
loc_02324A40:
	mov r3,#0x10	; 02324A40
	mov r0,#0x20	; 02324A42
	b loc_02324A4A	; 02324A44
loc_02324A46:
	mov r3,#0x20	; 02324A46
	mov r0,#0x40	; 02324A48
loc_02324A4A:
	str r3,[r1,#0x0]	; 02324A4A
	str r0,[r2,#0x0]	; 02324A4C
	pop {r4}	; 02324A4E
	pop {r3}	; 02324A50
	bx r3	; 02324A52
pool_02324A54:
loc_02324A54:
	.word 0xC0008000	; 02324A54
pool_02324A58:
loc_02324A58:
	.word 0x80008000	; 02324A58
pool_02324A5C:
loc_02324A5C:
	.word 0x80000000	; 02324A5C
pool_02324A60:
loc_02324A60:
	.word 0x80004000	; 02324A60
pool_02324A64:
loc_02324A64:
	.word 0xC0000000	; 02324A64
pool_02324A68:
loc_02324A68:
	.word 0xC0004000	; 02324A68
pool_02324A6C:
loc_02324A6C:
	.word 0x00008000	; 02324A6C
pool_02324A70:
loc_02324A70:
	.word 0x00004000	; 02324A70
pool_02324A74:
loc_02324A74:
	.word 0x40004000	; 02324A74
pool_02324A78:
loc_02324A78:
	.word 0x40000000	; 02324A78
pool_02324A7C:
loc_02324A7C:
	.word 0x40008000	; 02324A7C

; ===== function loc_02324A80 =====
loc_02324A80:
	push {r4,r5,lr}	; 02324A80
	sub sp,#0x4	; 02324A82
	add r5,r0,#0x0	; 02324A84
	mov r4,#0x0	; 02324A86
	b loc_02324A9A	; 02324A88
loc_02324A8A:
	add r0,r4,#0x0	; 02324A8A
	add r0,#0x28	; 02324A8C
	ldrb r0,[r0,#0x0]	; 02324A8E
	cmp r0,#0x0	; 02324A90
	bne loc_02324A9A	; 02324A92
	add r0,r4,#0x0	; 02324A94
	bl loc_02324AB0	; 02324A96
loc_02324A9A:
	add r0,r5,#0x0	; 02324A9A
	add r1,r4,#0x0	; 02324A9C
	bl loc_023295A0	; 02324A9E
	add r4,r0,#0x0	; 02324AA2
	cmp r4,#0x0	; 02324AA4
	bne loc_02324A8A	; 02324AA6
	add sp,#0x4	; 02324AA8
	pop {r4,r5}	; 02324AAA
	pop {r3}	; 02324AAC
	bx r3	; 02324AAE

; ===== function loc_02324AB0 =====
loc_02324AB0:
	push {r4,r5,r6,r7,lr}	; 02324AB0
	sub sp,#0xc	; 02324AB2
	add r5,r0,#0x0	; 02324AB4
	ldrh r1,[r5,#0x14]	; 02324AB6
	ldr r0,[r5,#0x24]	; 02324AB8
	ldrh r0,[r0,#0xc]	; 02324ABA
	sub r0,r1,r0	; 02324ABC
	lsl r4,r0,#0x7	; 02324ABE
	lsl r6,r1,#0x7	; 02324AC0
	ldr r0,[r5,#0x10]	; 02324AC2
	add r1,sp,#0x0	; 02324AC4
	add r2,sp,#0x4	; 02324AC6
	bl loc_02324990	; 02324AC8
	ldrh r0,[r5,#0x18]	; 02324ACC
	ldr r2,[sp,#0x0]	; 02324ACE
	ldr r1,[sp,#0x4]	; 02324AD0
	mul r2,r1	; 02324AD2
	mul r0,r2	; 02324AD4
	mov r1,#0x2	; 02324AD6
	blx P1_SignedDivMod	; 02324AD8
	add r7,r0,#0x0	; 02324ADC
	ldr r0,[r5,#0x24]	; 02324ADE
	ldr r0,[r0,#0x14]	; 02324AE0
	add r0,r0,r4	; 02324AE2
	add r1,r7,#0x0	; 02324AE4
	blx P1_CleanDataCacheRange	; 02324AE6
	ldr r1,[r5,#0x24]	; 02324AEA
	ldrh r0,[r1,#0x10]	; 02324AEC
	cmp r0,#0x0	; 02324AEE
	beq loc_02324B00	; 02324AF0
	ldr r0,[r1,#0x14]	; 02324AF2
	add r0,r0,r4	; 02324AF4
	add r1,r6,#0x0	; 02324AF6
	add r2,r7,#0x0	; 02324AF8
	bl loc_0232DC30	; 02324AFA
	b loc_02324B0C	; 02324AFE
loc_02324B00:
	ldr r0,[r1,#0x14]	; 02324B00
	add r0,r0,r4	; 02324B02
	add r1,r6,#0x0	; 02324B04
	add r2,r7,#0x0	; 02324B06
	bl loc_0232DC08	; 02324B08
loc_02324B0C:
	mov r0,#0x1	; 02324B0C
	add r5,#0x28	; 02324B0E
	strb r0,[r5,#0x0]	; 02324B10
	add sp,#0xc	; 02324B12
	pop {r4,r5,r6,r7}	; 02324B14
	pop {r3}	; 02324B16
	bx r3	; 02324B18
	.byte 0x00, 0x00	; 02324B1C

; ===== function loc_02324B1C =====
loc_02324B1C:
	push {lr}	; 02324B1C
	sub sp,#0x14	; 02324B1E
	add r3,r0,#0x0	; 02324B20
	ldr r0,[pool_02324B40]	; 02324B22
	str r0,[sp,#0x0]	; 02324B24
	str r1,[sp,#0x4]	; 02324B26
	mov r0,#0x0	; 02324B28
	str r0,[sp,#0x8]	; 02324B2A
	str r2,[sp,#0xc]	; 02324B2C
	ldr r0,[r3,#0x24]	; 02324B2E
	add r1,r3,#0x0	; 02324B30
	ldr r2,[r3,#0x20]	; 02324B32
	ldrh r3,[r3,#0x1c]	; 02324B34
	bl loc_02324630	; 02324B36
	add sp,#0x14	; 02324B3A
	pop {r3}	; 02324B3C
	bx r3	; 02324B3E
pool_02324B40:
loc_02324B40:
	.word 0x0000FFFF	; 02324B40

; ===== function loc_02324B44 =====
loc_02324B44:
	push {lr}	; 02324B44
	sub sp,#0x14	; 02324B46
	add r3,r0,#0x0	; 02324B48
	ldr r0,[pool_02324B6C]	; 02324B4A
	str r0,[sp,#0x0]	; 02324B4C
	str r1,[sp,#0x4]	; 02324B4E
	mov r0,#0x0	; 02324B50
	str r0,[sp,#0x8]	; 02324B52
	mvn r0,r0	; 02324B54
	str r0,[sp,#0xc]	; 02324B56
	ldr r0,[r3,#0x24]	; 02324B58
	add r1,r3,#0x0	; 02324B5A
	ldr r2,[r3,#0x20]	; 02324B5C
	ldrh r3,[r3,#0x1c]	; 02324B5E
	bl loc_02324630	; 02324B60
	add sp,#0x14	; 02324B64
	pop {r3}	; 02324B66
	bx r3	; 02324B68
	.byte 0xC0, 0x46	; 02324B6C
pool_02324B6C:
loc_02324B6C:
	.word 0x0000FFFF	; 02324B6C

; ===== function loc_02324B70 =====
	push {r4,r5,lr}	; 02324B70
	sub sp,#0x14	; 02324B72
	add r5,r0,#0x0	; 02324B74
	add r4,r1,#0x0	; 02324B76
	add r3,r2,#0x0	; 02324B78
	ldr r0,[pool_02324B9C]	; 02324B7A
	str r0,[sp,#0x0]	; 02324B7C
	mov r0,#0x0	; 02324B7E
	str r0,[sp,#0x4]	; 02324B80
	str r0,[sp,#0x8]	; 02324B82
	mvn r0,r0	; 02324B84
	str r0,[sp,#0xc]	; 02324B86
	ldr r0,[r5,#0x24]	; 02324B88
	add r1,r5,#0x0	; 02324B8A
	add r2,r4,#0x0	; 02324B8C
	bl loc_02324630	; 02324B8E
	add sp,#0x14	; 02324B92
	pop {r4,r5}	; 02324B94
	pop {r3}	; 02324B96
	bx r3	; 02324B98
	.byte 0xC0, 0x46	; 02324B9C
pool_02324B9C:
loc_02324B9C:
	.word 0x0000FFFF	; 02324B9C

; ===== function loc_02324BA0 =====
loc_02324BA0:
	push {r4,r5,r6,lr}	; 02324BA0
	sub sp,#0x10	; 02324BA2
	add r5,r0,#0x0	; 02324BA4
	add r4,r1,#0x0	; 02324BA6
	add r6,r2,#0x0	; 02324BA8
	add r0,r6,#0x0	; 02324BAA
	bl loc_02324DD4	; 02324BAC
	add r3,r0,#0x0	; 02324BB0
	str r6,[sp,#0x0]	; 02324BB2
	mov r0,#0x0	; 02324BB4
	str r0,[sp,#0x4]	; 02324BB6
	str r0,[sp,#0x8]	; 02324BB8
	mvn r0,r0	; 02324BBA
	str r0,[sp,#0xc]	; 02324BBC
	ldr r0,[r5,#0x24]	; 02324BBE
	add r1,r5,#0x0	; 02324BC0
	add r2,r4,#0x0	; 02324BC2
	lsl r3,r3,#0x10	; 02324BC4
	lsr r3,r3,#0x10	; 02324BC6
	bl loc_02324630	; 02324BC8
	add sp,#0x10	; 02324BCC
	pop {r4,r5,r6}	; 02324BCE
	pop {r3}	; 02324BD0
	bx r3	; 02324BD2

; ===== function loc_02324BD4 =====
loc_02324BD4:
	push {r4,r5,lr}	; 02324BD4
	sub sp,#0x14	; 02324BD6
	ldr r4,[pool_02324BF4]	; 02324BD8
	str r4,[sp,#0x0]	; 02324BDA
	mov r5,#0x0	; 02324BDC
	str r5,[sp,#0x4]	; 02324BDE
	mov r4,#0x1	; 02324BE0
	str r4,[sp,#0x8]	; 02324BE2
	mvn r4,r5	; 02324BE4
	str r4,[sp,#0xc]	; 02324BE6
	bl loc_02324630	; 02324BE8
	add sp,#0x14	; 02324BEC
	pop {r4,r5}	; 02324BEE
	pop {r3}	; 02324BF0
	bx r3	; 02324BF2
pool_02324BF4:
loc_02324BF4:
	.word 0x0000FFFF	; 02324BF4

; ===== function loc_02324BF8 =====
loc_02324BF8:
	push {r4,r5,r6,r7,lr}	; 02324BF8
	sub sp,#0x14	; 02324BFA
	add r5,r0,#0x0	; 02324BFC
	add r4,r1,#0x0	; 02324BFE
	add r6,r2,#0x0	; 02324C00
	add r7,r3,#0x0	; 02324C02
	add r0,r7,#0x0	; 02324C04
	bl loc_02324DD4	; 02324C06
	add r3,r0,#0x0	; 02324C0A
	str r7,[sp,#0x0]	; 02324C0C
	mov r1,#0x0	; 02324C0E
	str r1,[sp,#0x4]	; 02324C10
	mov r0,#0x1	; 02324C12
	str r0,[sp,#0x8]	; 02324C14
	mvn r0,r1	; 02324C16
	str r0,[sp,#0xc]	; 02324C18
	add r0,r5,#0x0	; 02324C1A
	add r1,r4,#0x0	; 02324C1C
	add r2,r6,#0x0	; 02324C1E
	bl loc_02324630	; 02324C20
	add sp,#0x14	; 02324C24
	pop {r4,r5,r6,r7}	; 02324C26
	pop {r3}	; 02324C28
	bx r3	; 02324C2A

; ===== function loc_02324C2C =====
loc_02324C2C:
	push {r4,r5,lr}	; 02324C2C
	sub sp,#0x4	; 02324C2E
	add r5,r0,#0x0	; 02324C30
	add r4,r1,#0x0	; 02324C32
	mov r1,#0x0	; 02324C34
	bl loc_023296C4	; 02324C36
	ldr r0,[pool_02324C64]	; 02324C3A
	ldrh r0,[r0,#0x0]	; 02324C3C
	lsl r0,r0,#0x1d	; 02324C3E
	lsr r0,r0,#0x1d	; 02324C40
	bl loc_02324DF0	; 02324C42
	lsl r0,r4,#0x9	; 02324C46
	lsr r0,r0,#0x10	; 02324C48
	strh r0,[r5,#0xc]	; 02324C4A
	strh r0,[r5,#0xe]	; 02324C4C
	mov r0,#0x0	; 02324C4E
	str r0,[sp,#0x0]	; 02324C50
	ldr r0,[sp,#0x0]	; 02324C52
	ldr r1,[r5,#0x14]	; 02324C54
	ldr r2,[pool_02324C68]	; 02324C56
	blx loc_0232DE78	; 02324C58
	add sp,#0x4	; 02324C5C
	pop {r4,r5}	; 02324C5E
	pop {r3}	; 02324C60
	bx r3	; 02324C62
pool_02324C64:
loc_02324C64:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02324C64
pool_02324C68:
loc_02324C68:
	.word 0x00010000	; 02324C68

; ===== function loc_02324C6C =====
loc_02324C6C:
	mov r1,#0x0	; 02324C6C
	ldr r0,[pool_02324C7C]	; 02324C6E
	strh r1,[r0,#0x28]	; 02324C70
	ldr r1,[pool_02324C80]	; 02324C72
	str r1,[r0,#0x2c]	; 02324C74
	ldr r0,[pool_02324C84]	; 02324C76
	bx lr	; 02324C78
	.byte 0xC0, 0x46	; 02324C7C
pool_02324C7C:
loc_02324C7C:
	.word P1_BssStart + 0x3BCC	; 02324C7C
pool_02324C80:
loc_02324C80:
	.word 0x0234467C	; 02324C80
pool_02324C84:
loc_02324C84:
	.word 0x02334664	; 02324C84

; ===== function loc_02324C88 =====
loc_02324C88:
	mov r1,#0x1	; 02324C88
	ldr r0,[pool_02324C94]	; 02324C8A
	strh r1,[r0,#0x10]	; 02324C8C
	ldr r1,[pool_02324C98]	; 02324C8E
	str r1,[r0,#0x14]	; 02324C90
	bx lr	; 02324C92
pool_02324C94:
loc_02324C94:
	.word P1_BssStart + 0x3BCC	; 02324C94
pool_02324C98:
loc_02324C98:
	.word 0x0233467C	; 02324C98

; ===== function loc_02324C9C =====
loc_02324C9C:
	ldr r0,[pool_02324CA0]	; 02324C9C
	bx lr	; 02324C9E
pool_02324CA0:
loc_02324CA0:
	.word 0x0235469C	; 02324CA0
P1_Entry_02324CA4:
	ldr r0,[pool_02324CA8]	; 02324CA4
	bx lr	; 02324CA6
pool_02324CA8:
	.word 0x0235467C	; 02324CA8

; ===== function loc_02324CAC =====
loc_02324CAC:
	ldr r0,[pool_02324CB0]	; 02324CAC
	bx lr	; 02324CAE
pool_02324CB0:
loc_02324CB0:
	.word 0x0235467C	; 02324CB0

; ===== function loc_02324CB4 =====
loc_02324CB4:
	push {r4,r5,r6,lr}	; 02324CB4
	ldr r0,[pool_02324CFC]	; 02324CB6
	ldr r1,[pool_02324D00]	; 02324CB8
	ldr r2,[pool_02324D04]	; 02324CBA
	bl loc_02329038	; 02324CBC
	ldr r0,[pool_02324D08]	; 02324CC0
	ldr r1,[pool_02324D0C]	; 02324CC2
	ldr r2,[pool_02324D10]	; 02324CC4
	bl loc_02329038	; 02324CC6
	ldr r0,[pool_02324D14]	; 02324CCA
	ldr r1,[pool_02324D18]	; 02324CCC
	ldr r2,[pool_02324D1C]	; 02324CCE
	bl loc_02329038	; 02324CD0
	ldr r0,[pool_02324D20]	; 02324CD4
	ldr r1,[pool_02324D24]	; 02324CD6
	ldr r2,[pool_02324D28]	; 02324CD8
	bl loc_02329038	; 02324CDA
	mov r5,#0x0	; 02324CDE
	ldr r4,[pool_02324CFC]	; 02324CE0
	ldr r6,[pool_02324D2C]	; 02324CE2
	b loc_02324CF2	; 02324CE4
loc_02324CE6:
	lsl r0,r5,#0x5	; 02324CE6
	add r0,r4,r0	; 02324CE8
	ldrh r1,[r6,#0x0]	; 02324CEA
	bl loc_02328BC4	; 02324CEC
	add r5,r5,#0x1	; 02324CF0
loc_02324CF2:
	cmp r5,#0x4	; 02324CF2
	bcc loc_02324CE6	; 02324CF4
	pop {r4,r5,r6}	; 02324CF6
	pop {r3}	; 02324CF8
	bx r3	; 02324CFA
pool_02324CFC:
loc_02324CFC:
	.word 0x0235467C	; 02324CFC
pool_02324D00:
loc_02324D00:
	.word 0x023A80CC	; 02324D00
pool_02324D04:
loc_02324D04:
	.word 0x023A7744	; 02324D04
pool_02324D08:
loc_02324D08:
	.word 0x0235469C	; 02324D08
pool_02324D0C:
loc_02324D0C:
	.word 0x023AA518	; 02324D0C
pool_02324D10:
loc_02324D10:
	.word 0x023A7920	; 02324D10
pool_02324D14:
loc_02324D14:
	.word 0x023546BC	; 02324D14
pool_02324D18:
loc_02324D18:
	.word 0x023A7FBC	; 02324D18
pool_02324D1C:
loc_02324D1C:
	.word 0x023A76F8	; 02324D1C
pool_02324D20:
loc_02324D20:
	.word 0x023546DC	; 02324D20
pool_02324D24:
loc_02324D24:
	.word 0x023A7A28	; 02324D24
pool_02324D28:
loc_02324D28:
	.word 0x023A7684	; 02324D28
pool_02324D2C:
loc_02324D2C:
	.word 0x0233070C	; 02324D2C
loc_02324D30:
	push {r4,r5,r6,r7,lr}	; 02324D30
	sub sp,#0x4	; 02324D32
	lsl r2,r1,#0x3	; 02324D34
	ldr r1,[pool_02324DC4]	; 02324D36
	ldr r3,[r1,r2]	; 02324D38
	ldr r1,[pool_02324DC8]	; 02324D3A
	ldr r2,[r1,r2]	; 02324D3C
	ldr r1,[pool_02324DCC]	; 02324D3E
	and r0,r1	; 02324D40
	lsl r0,r0,#0x2	; 02324D42
	ldr r0,[r2,r0]	; 02324D44
	add r1,r3,r0	; 02324D46
	ldr r0,[pool_02324DD0]	; 02324D48
	mov r3,#0x3	; 02324D4A
	mov r4,#0x3f	; 02324D4C
	mov r2,#0xf	; 02324D4E
	b loc_02324DAE	; 02324D50
loc_02324D52:
	cmp r5,#0x80	; 02324D52
	bcs loc_02324D5C	; 02324D54
	strh r5,[r0,#0x0]	; 02324D56
	add r1,r1,#0x1	; 02324D58
	b loc_02324DAC	; 02324D5A
loc_02324D5C:
	cmp r5,#0xe0	; 02324D5C
	bcc loc_02324D80	; 02324D5E
	ldrb r6,[r1,#0x1]	; 02324D60
	and r5,r2	; 02324D62
	lsl r7,r5,#0x4	; 02324D64
	asr r5,r6,#0x2	; 02324D66
	and r5,r2	; 02324D68
	orr r7,r5	; 02324D6A
	lsl r5,r7,#0x8	; 02324D6C
	and r6,r3	; 02324D6E
	lsl r7,r6,#0x6	; 02324D70
	ldrb r6,[r1,#0x2]	; 02324D72
	and r6,r4	; 02324D74
	orr r7,r6	; 02324D76
	orr r5,r7	; 02324D78
	strh r5,[r0,#0x0]	; 02324D7A
	add r1,r1,#0x3	; 02324D7C
	b loc_02324DAC	; 02324D7E
loc_02324D80:
	add r7,r5,#0x0	; 02324D80
	mov r6,#0xe0	; 02324D82
	and r7,r6	; 02324D84
	cmp r7,#0xc0	; 02324D86
	bne loc_02324DAC	; 02324D88
	add r7,r5,#0x0	; 02324D8A
	mov r6,#0x1c	; 02324D8C
	and r7,r6	; 02324D8E
	asr r6,r7,#0x2	; 02324D90
	lsl r6,r6,#0x10	; 02324D92
	lsr r6,r6,#0x8	; 02324D94
	and r5,r3	; 02324D96
	lsl r5,r5,#0x16	; 02324D98
	lsr r5,r5,#0x10	; 02324D9A
	ldrb r7,[r1,#0x1]	; 02324D9C
	and r7,r4	; 02324D9E
	lsl r7,r7,#0x10	; 02324DA0
	lsr r7,r7,#0x10	; 02324DA2
	orr r5,r7	; 02324DA4
	orr r6,r5	; 02324DA6
	strh r6,[r0,#0x0]	; 02324DA8
	add r1,r1,#0x2	; 02324DAA
loc_02324DAC:
	add r0,r0,#0x2	; 02324DAC
loc_02324DAE:
	ldrb r5,[r1,#0x0]	; 02324DAE
	cmp r5,#0x0	; 02324DB0
	bne loc_02324D52	; 02324DB2
	mov r1,#0x0	; 02324DB4
	strh r1,[r0,#0x0]	; 02324DB6
	ldr r0,[pool_02324DD0]	; 02324DB8
	add sp,#0x4	; 02324DBA
	pop {r4,r5,r6,r7}	; 02324DBC
	pop {r3}	; 02324DBE
	bx r3	; 02324DC0
	.byte 0xC0, 0x46	; 02324DC4
pool_02324DC4:
loc_02324DC4:
	.word P1_BssStart + 0x23C84	; 02324DC4
pool_02324DC8:
loc_02324DC8:
	.word P1_BssStart + 0x23C80	; 02324DC8
pool_02324DCC:
loc_02324DCC:
	.word 0x0000FFFF	; 02324DCC
pool_02324DD0:
loc_02324DD0:
	.word 0x02354730	; 02324DD0

; ===== function loc_02324DD4 =====
loc_02324DD4:
	lsl r1,r0,#0x1	; 02324DD4
	ldr r0,[pool_02324DDC]	; 02324DD6
	ldrh r0,[r0,r1]	; 02324DD8
	bx lr	; 02324DDA
pool_02324DDC:
loc_02324DDC:
	.word P1_Data_02330728	; 02324DDC

; ===== function loc_02324DE0 =====
loc_02324DE0:
	ldr r1,[pool_02324DE8]	; 02324DE0
	ldr r1,[r1,#0x0]	; 02324DE2
	ldr r3,[pool_02324DEC]	; 02324DE4
	bx r3	; 02324DE6
pool_02324DE8:
loc_02324DE8:
	.word P1_BssStart + 0x23C7C	; 02324DE8
pool_02324DEC:
loc_02324DEC:
	.word loc_02324D30 + 1	; 02324DEC

; ===== function loc_02324DF0 =====
loc_02324DF0:
	ldr r1,[pool_02324DF8]	; 02324DF0
	str r0,[r1,#0x0]	; 02324DF2
	bx lr	; 02324DF4
	.byte 0xC0, 0x46	; 02324DF8
pool_02324DF8:
loc_02324DF8:
	.word P1_BssStart + 0x23C7C	; 02324DF8

; ===== function loc_02324DFC =====
loc_02324DFC:
	push {r4,r5,r6,lr}	; 02324DFC
	sub sp,#0x18	; 02324DFE
	ldr r4,[pool_02324E3C]	; 02324E00
	add r3,sp,#0x0	; 02324E02
	mov r2,#0x3	; 02324E04
loc_02324E06:
	ldmia r4!,{r0,r1}	; 02324E06
	stmia r3!,{r0,r1}	; 02324E08
	sub r2,r2,#0x1	; 02324E0A
	cmp r2,#0x0	; 02324E0C
	bne loc_02324E06	; 02324E0E
	mov r5,#0x0	; 02324E10
	add r4,sp,#0x0	; 02324E12
	ldr r6,[pool_02324E40]	; 02324E14
loc_02324E16:
	lsl r0,r5,#0x2	; 02324E16
	ldr r0,[r4,r0]	; 02324E18
	lsl r1,r5,#0x3	; 02324E1A
	add r1,r6,r1	; 02324E1C
	bl loc_02324E4C	; 02324E1E
	add r5,r5,#0x1	; 02324E22
	cmp r5,#0x6	; 02324E24
	blt loc_02324E16	; 02324E26
	ldr r0,[pool_02324E44]	; 02324E28
	ldrh r0,[r0,#0x0]	; 02324E2A
	lsl r0,r0,#0x1d	; 02324E2C
	lsr r1,r0,#0x1d	; 02324E2E
	ldr r0,[pool_02324E48]	; 02324E30
	str r1,[r0,#0x0]	; 02324E32
	add sp,#0x18	; 02324E34
	pop {r4,r5,r6}	; 02324E36
	pop {r3}	; 02324E38
	bx r3	; 02324E3A
pool_02324E3C:
loc_02324E3C:
	.word 0x02330710	; 02324E3C
pool_02324E40:
loc_02324E40:
	.word 0x02354700	; 02324E40
pool_02324E44:
loc_02324E44:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02324E44
pool_02324E48:
loc_02324E48:
	.word P1_BssStart + 0x23C7C	; 02324E48

; ===== function loc_02324E4C =====
loc_02324E4C:
	push {r4,r5,r6,lr}	; 02324E4C
	ldr r2,[r0,#0xc]	; 02324E4E
	add r0,#0x20	; 02324E50
	mov r3,#0x0	; 02324E52
	str r3,[r1,#0x0]	; 02324E54
	str r3,[r1,#0x4]	; 02324E56
	ldr r5,[pool_02324E88]	; 02324E58
	ldr r4,[pool_02324E8C]	; 02324E5A
	b loc_02324E7E	; 02324E5C
loc_02324E5E:
	ldr r6,[r0,#0x0]	; 02324E5E
	cmp r6,r5	; 02324E60
	beq loc_02324E6A	; 02324E62
	cmp r6,r4	; 02324E64
	beq loc_02324E72	; 02324E66
	b loc_02324E78	; 02324E68
loc_02324E6A:
	add r6,r0,#0x0	; 02324E6A
	add r6,#0x10	; 02324E6C
	str r6,[r1,#0x0]	; 02324E6E
	b loc_02324E78	; 02324E70
loc_02324E72:
	add r6,r0,#0x0	; 02324E72
	add r6,#0x8	; 02324E74
	str r6,[r1,#0x4]	; 02324E76
loc_02324E78:
	ldr r6,[r0,#0x4]	; 02324E78
	add r0,r0,r6	; 02324E7A
	add r3,r3,#0x1	; 02324E7C
loc_02324E7E:
	cmp r3,r2	; 02324E7E
	blt loc_02324E5E	; 02324E80
	pop {r4,r5,r6}	; 02324E82
	pop {r3}	; 02324E84
	bx r3	; 02324E86
pool_02324E88:
loc_02324E88:
	.word 0x31464E49	; 02324E88
pool_02324E8C:
loc_02324E8C:
	.word 0x31544144	; 02324E8C
	.byte 0x01, 0x48, 0xC0, 0x69, 0x70, 0x47, 0xC0, 0x46, 0x30, 0x4B, 0x35, 0x02	; 02324E90
P1_Entry_02324E9C:
	push {lr}	; 02324E9C
	sub sp,#0x4	; 02324E9E
	ldr r0,[pool_02324EBC]	; 02324EA0
	ldr r1,[pool_02324EC0]	; 02324EA2
	mov r2,#0x35	; 02324EA4
	bl loc_02324BA0	; 02324EA6
	ldr r0,[pool_02324EC4]	; 02324EAA
	ldr r1,[pool_02324EC0]	; 02324EAC
	mov r2,#0x36	; 02324EAE
	bl loc_02324BA0	; 02324EB0
	add sp,#0x4	; 02324EB4
	pop {r3}	; 02324EB6
	bx r3	; 02324EB8
	.byte 0xC0, 0x46	; 02324EBA
pool_02324EBC:
	.word 0x02354B90	; 02324EBC
pool_02324EC0:
	.word 0x023A5B84	; 02324EC0
pool_02324EC4:
	.word 0x02354BBC	; 02324EC4
P1_Entry_02324EC8:
	push {r4,r5,r6,lr}	; 02324EC8
	mov r4,#0x0	; 02324ECA
	mvn r5,r4	; 02324ECC
	ldr r0,[pool_02324F6C]	; 02324ECE
	ldr r1,[r0,#0x18]	; 02324ED0
	cmp r1,#0x2	; 02324ED2
	bne P1_Entry_02324F62	; 02324ED4
	ldr r0,[r0,#0x1c]	; 02324ED6
	cmp r0,#0x1	; 02324ED8
	bne P1_Entry_02324F62	; 02324EDA
	add r6,r4,#0x0	; 02324EDC
	ldr r0,[pool_02324F70]	; 02324EDE
	ldr r1,[pool_02324F74]	; 02324EE0
	bl loc_02324370	; 02324EE2
	ldr r0,[pool_02324F70]	; 02324EE6
	mov r1,#0x1	; 02324EE8
	bl loc_0232435C	; 02324EEA
	cmp r0,#0x0	; 02324EEE
	beq P1_Entry_02324EFA	; 02324EF0
	mov r4,#0x1	; 02324EF2
	ldr r0,[pool_02324F6C]	; 02324EF4
	str r4,[r0,#0x20]	; 02324EF6
	b P1_Entry_02324F0E	; 02324EF8
P1_Entry_02324EFA:
	ldr r0,[pool_02324F70]	; 02324EFA
	lsl r1,r4,#0	; 02324EFC
	bl loc_0232435C	; 02324EFE
	cmp r0,#0x0	; 02324F02
	beq P1_Entry_02324F0E	; 02324F04
	lsl r1,r4,#0	; 02324F06
	ldr r0,[pool_02324F6C]	; 02324F08
	str r1,[r0,#0x20]	; 02324F0A
	mov r6,#0x1	; 02324F0C
P1_Entry_02324F0E:
	mov r0,#0x20	; 02324F0E
	bl loc_0232414C	; 02324F10
	cmp r0,#0x0	; 02324F14
	beq P1_Entry_02324F26	; 02324F16
	mov r1,#0x0	; 02324F18
	ldr r0,[pool_02324F6C]	; 02324F1A
	str r1,[r0,#0x20]	; 02324F1C
	mov r0,#0x1d	; 02324F1E
	bl loc_02323724	; 02324F20
	b P1_Entry_02324F62	; 02324F24
P1_Entry_02324F26:
	mov r0,#0x10	; 02324F26
	bl loc_0232414C	; 02324F28
	cmp r0,#0x0	; 02324F2C
	beq P1_Entry_02324F3E	; 02324F2E
	mov r1,#0x1	; 02324F30
	ldr r0,[pool_02324F6C]	; 02324F32
	str r1,[r0,#0x20]	; 02324F34
	mov r0,#0x1d	; 02324F36
	bl loc_02323724	; 02324F38
	b P1_Entry_02324F62	; 02324F3C
P1_Entry_02324F3E:
	mov r0,#0x1	; 02324F3E
	bl loc_0232414C	; 02324F40
	cmp r0,#0x0	; 02324F44
	bne P1_Entry_02324F4C	; 02324F46
	cmp r4,#0x0	; 02324F48
	beq P1_Entry_02324F52	; 02324F4A
P1_Entry_02324F4C:
	ldr r0,[pool_02324F6C]	; 02324F4C
	ldr r5,[r0,#0x20]	; 02324F4E
	b P1_Entry_02324F62	; 02324F50
P1_Entry_02324F52:
	mov r0,#0x2	; 02324F52
	bl loc_0232414C	; 02324F54
	cmp r0,#0x0	; 02324F58
	bne P1_Entry_02324F60	; 02324F5A
	cmp r6,#0x0	; 02324F5C
	beq P1_Entry_02324F62	; 02324F5E
P1_Entry_02324F60:
	mov r5,#0x0	; 02324F60
P1_Entry_02324F62:
	add r0,r5,#0x0	; 02324F62
	pop {r4,r5,r6}	; 02324F64
	pop {r3}	; 02324F66
	bx r3	; 02324F68
	.byte 0xC0, 0x46	; 02324F6A
pool_02324F6C:
	.word P1_BssStart + 0x240B0	; 02324F6C
pool_02324F70:
	.word 0x02354B58	; 02324F70
pool_02324F74:
	.word 0x023A4B1C	; 02324F74

; ===== function loc_02324F78 =====
loc_02324F78:
	push {lr}	; 02324F78
	sub sp,#0x4	; 02324F7A
	bl loc_023252C8	; 02324F7C
	ldr r0,[pool_02325058]	; 02324F80
	ldr r1,[r0,#0x14]	; 02324F82
	cmp r1,#0x0	; 02324F84
	blt loc_02325050	; 02324F86
	ldr r1,[r0,#0x1c]	; 02324F88
	cmp r1,#0x0	; 02324F8A
	beq loc_02324F98	; 02324F8C
	cmp r1,#0x1	; 02324F8E
	beq loc_02324FCA	; 02324F90
	cmp r1,#0x2	; 02324F92
	beq loc_02325028	; 02324F94
	b loc_02325050	; 02324F96
loc_02324F98:
	ldr r1,[r0,#0x10]	; 02324F98
	add r2,r1,#0x1	; 02324F9A
	str r2,[r0,#0x10]	; 02324F9C
	cmp r2,#0xf	; 02324F9E
	bgt loc_02324FB4	; 02324FA0
	mov r1,#0xf	; 02324FA2
	sub r0,r1,r2	; 02324FA4
	mov r2,#0x78	; 02324FA6
	mul r0,r2	; 02324FA8
	blx P1_SignedDivMod	; 02324FAA
	ldr r1,[pool_02325058]	; 02324FAE
	str r0,[r1,#0x0]	; 02324FB0
	b loc_02325050	; 02324FB2
loc_02324FB4:
	ldr r0,[r0,#0x18]	; 02324FB4
	cmp r0,#0x1	; 02324FB6
	bne loc_02324FBE	; 02324FB8
	bl loc_023252FC	; 02324FBA
loc_02324FBE:
	mov r1,#0x0	; 02324FBE
	ldr r0,[pool_02325058]	; 02324FC0
	str r1,[r0,#0x10]	; 02324FC2
	mov r1,#0x1	; 02324FC4
	str r1,[r0,#0x1c]	; 02324FC6
	b loc_02325050	; 02324FC8
loc_02324FCA:
	ldr r1,[r0,#0x18]	; 02324FCA
	cmp r1,#0x0	; 02324FCC
	bne loc_02324FE4	; 02324FCE
	ldr r1,[r0,#0x10]	; 02324FD0
	add r1,r1,#0x1	; 02324FD2
	str r1,[r0,#0x10]	; 02324FD4
	cmp r1,#0x78	; 02324FD6
	ble loc_02325050	; 02324FD8
	mov r1,#0x0	; 02324FDA
	str r1,[r0,#0x10]	; 02324FDC
	mov r1,#0x2	; 02324FDE
	str r1,[r0,#0x1c]	; 02324FE0
	b loc_02325050	; 02324FE2
loc_02324FE4:
	cmp r1,#0x1	; 02324FE4
	bne loc_0232500A	; 02324FE6
	ldr r1,[r0,#0x10]	; 02324FE8
	add r1,r1,#0x1	; 02324FEA
	str r1,[r0,#0x10]	; 02324FEC
	ldr r0,[r0,#0x24]	; 02324FEE
	cmp r0,#0x0	; 02324FF0
	beq loc_02325050	; 02324FF2
	bl loc_023252F0	; 02324FF4
	ldr r0,[pool_02325058]	; 02324FF8
	ldr r1,[r0,#0x10]	; 02324FFA
	cmp r1,#0x1e	; 02324FFC
	ble loc_02325050	; 02324FFE
	mov r1,#0x0	; 02325000
	str r1,[r0,#0x10]	; 02325002
	mov r1,#0x2	; 02325004
	str r1,[r0,#0x1c]	; 02325006
	b loc_02325050	; 02325008
loc_0232500A:
	cmp r1,#0x2	; 0232500A
	bne loc_02325050	; 0232500C
	ldr r1,[r0,#0x10]	; 0232500E
	add r1,r1,#0x1	; 02325010
	str r1,[r0,#0x10]	; 02325012
	cmp r1,#0x1e	; 02325014
	ble loc_02325050	; 02325016
	ldr r1,[r0,#0x24]	; 02325018
	cmp r1,#0x0	; 0232501A
	beq loc_02325050	; 0232501C
	mov r1,#0x0	; 0232501E
	str r1,[r0,#0x10]	; 02325020
	mov r1,#0x2	; 02325022
	str r1,[r0,#0x1c]	; 02325024
	b loc_02325050	; 02325026
loc_02325028:
	ldr r1,[r0,#0x10]	; 02325028
	add r2,r1,#0x1	; 0232502A
	str r2,[r0,#0x10]	; 0232502C
	cmp r2,#0xf	; 0232502E
	bgt loc_02325048	; 02325030
	mov r1,#0xf	; 02325032
	sub r0,r1,r2	; 02325034
	mov r2,#0x78	; 02325036
	mul r0,r2	; 02325038
	blx P1_SignedDivMod	; 0232503A
	mov r1,#0x78	; 0232503E
	sub r1,r1,r0	; 02325040
	ldr r0,[pool_02325058]	; 02325042
	str r1,[r0,#0x0]	; 02325044
	b loc_02325050	; 02325046
loc_02325048:
	bl loc_023252FC	; 02325048
	bl loc_0232524C	; 0232504C
loc_02325050:
	add sp,#0x4	; 02325050
	pop {r3}	; 02325052
	bx r3	; 02325054
	.byte 0xC0, 0x46	; 02325058
pool_02325058:
loc_02325058:
	.word P1_BssStart + 0x240B0	; 02325058

; ===== function loc_0232505C =====
loc_0232505C:
	ldr r0,[pool_0232506C]	; 0232505C
	ldr r2,[r0,#0x14]	; 0232505E
	mov r0,#0x0	; 02325060
	mvn r1,r0	; 02325062
	cmp r2,r1	; 02325064
	beq loc_0232506A	; 02325066
	mov r0,#0x1	; 02325068
loc_0232506A:
	bx lr	; 0232506A
pool_0232506C:
loc_0232506C:
	.word P1_BssStart + 0x240B0	; 0232506C

; ===== function loc_02325070 =====
loc_02325070:
	ldr r0,[pool_02325078]	; 02325070
	ldr r0,[r0,#0x24]	; 02325072
	bx lr	; 02325074
	.byte 0xC0, 0x46	; 02325078
pool_02325078:
loc_02325078:
	.word P1_BssStart + 0x240B0	; 02325078

; ===== function loc_0232507C =====
loc_0232507C:
	mov r1,#0x1	; 0232507C
	ldr r0,[pool_02325084]	; 0232507E
	str r1,[r0,#0x24]	; 02325080
	bx lr	; 02325082
pool_02325084:
loc_02325084:
	.word P1_BssStart + 0x240B0	; 02325084

; ===== function loc_02325088 =====
loc_02325088:
	push {r4,lr}	; 02325088
	add r4,r2,#0x0	; 0232508A
	bl loc_023250CC	; 0232508C
	ldr r0,[pool_023250A0]	; 02325090
	add r1,r4,#0x0	; 02325092
	bl loc_02324B44	; 02325094
	pop {r4}	; 02325098
	pop {r3}	; 0232509A
	bx r3	; 0232509C
	.byte 0xC0, 0x46	; 023250A0
pool_023250A0:
loc_023250A0:
	.word 0x02354B64	; 023250A0

; ===== function loc_023250A4 =====
loc_023250A4:
	push {lr}	; 023250A4
	sub sp,#0x4	; 023250A6
	bl loc_023250CC	; 023250A8
	ldr r0,[pool_023250C0]	; 023250AC
	ldr r1,[pool_023250C4]	; 023250AE
	ldr r2,[pool_023250C8]	; 023250B0
	ldr r2,[r2,#0x14]	; 023250B2
	bl loc_02324BA0	; 023250B4
	add sp,#0x4	; 023250B8
	pop {r3}	; 023250BA
	bx r3	; 023250BC
	.byte 0xC0, 0x46	; 023250C0
pool_023250C0:
loc_023250C0:
	.word 0x02354B64	; 023250C0
pool_023250C4:
loc_023250C4:
	.word 0x023A5B84	; 023250C4
pool_023250C8:
loc_023250C8:
	.word P1_BssStart + 0x240B0	; 023250C8

; ===== function loc_023250CC =====
loc_023250CC:
	push {r4,r5,lr}	; 023250CC
	sub sp,#0x4	; 023250CE
	add r5,r0,#0x0	; 023250D0
	add r4,r1,#0x0	; 023250D2
	bl loc_023252F0	; 023250D4
	bl loc_0232524C	; 023250D8
	ldr r1,[pool_023250F8]	; 023250DC
	str r5,[r1,#0x14]	; 023250DE
	str r4,[r1,#0x18]	; 023250E0
	cmp r4,#0x2	; 023250E2
	bne loc_023250F0	; 023250E4
	mov r0,#0xd	; 023250E6
	mvn r0,r0	; 023250E8
	str r0,[r1,#0x4]	; 023250EA
	mov r0,#0x8	; 023250EC
	str r0,[r1,#0x8]	; 023250EE
loc_023250F0:
	add sp,#0x4	; 023250F0
	pop {r4,r5}	; 023250F2
	pop {r3}	; 023250F4
	bx r3	; 023250F6
pool_023250F8:
loc_023250F8:
	.word P1_BssStart + 0x240B0	; 023250F8

; ===== function loc_023250FC =====
loc_023250FC:
	push {r4,lr}	; 023250FC
	sub sp,#0x10	; 023250FE
	ldr r0,[pool_023251E0]	; 02325100
	ldr r1,[r0,#0x14]	; 02325102
	cmp r1,#0x0	; 02325104
	blt loc_023251D8	; 02325106
	ldr r0,[r0,#0x18]	; 02325108
	cmp r0,#0x2	; 0232510A
	bne loc_0232518E	; 0232510C
	bl loc_02323E7C	; 0232510E
	ldr r1,[pool_023251E0]	; 02325112
	ldr r2,[r1,#0xc]	; 02325114
	str r2,[sp,#0x0]	; 02325116
	ldr r1,[r1,#0x0]	; 02325118
	str r1,[sp,#0x4]	; 0232511A
	ldr r1,[pool_023251E4]	; 0232511C
	ldr r2,[pool_023251E8]	; 0232511E
	mov r3,#0x4	; 02325120
	bl loc_02323C40	; 02325122
	mov r1,#0x0	; 02325126
	str r1,[sp,#0x0]	; 02325128
	ldr r0,[pool_023251EC]	; 0232512A
	ldr r2,[pool_023251E0]	; 0232512C
	ldr r2,[r2,#0x0]	; 0232512E
	add r3,r1,#0x0	; 02325130
	bl loc_02323780	; 02325132
	mov r1,#0x0	; 02325136
	str r1,[sp,#0x0]	; 02325138
	ldr r0,[pool_023251F0]	; 0232513A
	ldr r2,[pool_023251E0]	; 0232513C
	ldr r2,[r2,#0x0]	; 0232513E
	add r3,r1,#0x0	; 02325140
	bl loc_02323780	; 02325142
	ldr r0,[pool_023251F4]	; 02325146
	mov r1,#0x1	; 02325148
	bl loc_02324290	; 0232514A
	add r4,r0,#0x0	; 0232514E
	bl loc_02323E7C	; 02325150
	mov r1,#0x0	; 02325154
	str r1,[sp,#0x0]	; 02325156
	ldr r1,[pool_023251E0]	; 02325158
	ldr r1,[r1,#0x0]	; 0232515A
	str r1,[sp,#0x4]	; 0232515C
	str r4,[sp,#0x8]	; 0232515E
	ldr r1,[pool_023251E4]	; 02325160
	ldr r2,[pool_023251E8]	; 02325162
	mov r3,#0x2	; 02325164
	bl loc_02323BEC	; 02325166
	ldr r0,[pool_023251F4]	; 0232516A
	mov r1,#0x0	; 0232516C
	bl loc_02324290	; 0232516E
	add r4,r0,#0x0	; 02325172
	bl loc_02323E7C	; 02325174
	mov r1,#0x0	; 02325178
	str r1,[sp,#0x0]	; 0232517A
	ldr r1,[pool_023251E0]	; 0232517C
	ldr r1,[r1,#0x0]	; 0232517E
	str r1,[sp,#0x4]	; 02325180
	str r4,[sp,#0x8]	; 02325182
	ldr r1,[pool_023251E4]	; 02325184
	ldr r2,[pool_023251E8]	; 02325186
	mov r3,#0x3	; 02325188
	bl loc_02323BEC	; 0232518A
loc_0232518E:
	mov r1,#0x0	; 0232518E
	str r1,[sp,#0x0]	; 02325190
	ldr r0,[pool_023251F8]	; 02325192
	ldr r2,[pool_023251E0]	; 02325194
	ldr r3,[r2,#0x0]	; 02325196
	ldr r2,[r2,#0x4]	; 02325198
	add r2,r3,r2	; 0232519A
	add r3,r1,#0x0	; 0232519C
	bl loc_02323780	; 0232519E
	bl loc_02323E7C	; 023251A2
	mov r1,#0x0	; 023251A6
	str r1,[sp,#0x0]	; 023251A8
	ldr r1,[pool_023251E0]	; 023251AA
	ldr r2,[r1,#0x0]	; 023251AC
	ldr r1,[r1,#0x8]	; 023251AE
	add r1,r2,r1	; 023251B0
	str r1,[sp,#0x4]	; 023251B2
	ldr r1,[pool_023251E4]	; 023251B4
	ldr r2,[pool_023251E8]	; 023251B6
	mov r3,#0x1	; 023251B8
	bl loc_02323C40	; 023251BA
	bl loc_02323E7C	; 023251BE
	mov r3,#0x0	; 023251C2
	str r3,[sp,#0x0]	; 023251C4
	ldr r1,[pool_023251E0]	; 023251C6
	ldr r2,[r1,#0x0]	; 023251C8
	ldr r1,[r1,#0x4]	; 023251CA
	add r1,r2,r1	; 023251CC
	str r1,[sp,#0x4]	; 023251CE
	ldr r1,[pool_023251E4]	; 023251D0
	ldr r2,[pool_023251E8]	; 023251D2
	bl loc_02323C40	; 023251D4
loc_023251D8:
	add sp,#0x10	; 023251D8
	pop {r4}	; 023251DA
	pop {r3}	; 023251DC
	bx r3	; 023251DE
pool_023251E0:
loc_023251E0:
	.word P1_BssStart + 0x240B0	; 023251E0
pool_023251E4:
loc_023251E4:
	.word 0x023C1178	; 023251E4
pool_023251E8:
loc_023251E8:
	.word 0x023A505C	; 023251E8
pool_023251EC:
loc_023251EC:
	.word 0x02354B90	; 023251EC
pool_023251F0:
loc_023251F0:
	.word 0x02354BBC	; 023251F0
pool_023251F4:
loc_023251F4:
	.word 0x02354B58	; 023251F4
pool_023251F8:
loc_023251F8:
	.word 0x02354B64	; 023251F8

; ===== function loc_023251FC =====
loc_023251FC:
	push {r4,lr}	; 023251FC
	add r4,r0,#0x0	; 023251FE
	ldr r1,[pool_0232523C]	; 02325200
	ldr r2,[pool_02325240]	; 02325202
	mov r3,#0x5d	; 02325204
	bl loc_02324BF8	; 02325206
	add r0,r4,#0x0	; 0232520A
	ldr r1,[pool_02325244]	; 0232520C
	ldr r2,[pool_02325240]	; 0232520E
	mov r3,#0x1	; 02325210
	bl loc_02324BD4	; 02325212
	add r0,r4,#0x0	; 02325216
	ldr r1,[pool_02325248]	; 02325218
	ldr r2,[pool_02325240]	; 0232521A
	mov r3,#0x2	; 0232521C
	bl loc_02324BD4	; 0232521E
	ldr r0,[pool_02325244]	; 02325222
	ldr r1,[pool_02325240]	; 02325224
	mov r2,#0x35	; 02325226
	bl loc_02324BA0	; 02325228
	ldr r0,[pool_02325248]	; 0232522C
	ldr r1,[pool_02325240]	; 0232522E
	mov r2,#0x36	; 02325230
	bl loc_02324BA0	; 02325232
	pop {r4}	; 02325236
	pop {r3}	; 02325238
	bx r3	; 0232523A
pool_0232523C:
loc_0232523C:
	.word 0x02354B64	; 0232523C
pool_02325240:
loc_02325240:
	.word 0x023A5B84	; 02325240
pool_02325244:
loc_02325244:
	.word 0x02354B90	; 02325244
pool_02325248:
loc_02325248:
	.word 0x02354BBC	; 02325248

; ===== function loc_0232524C =====
loc_0232524C:
	mov r1,#0x78	; 0232524C
	ldr r0,[pool_02325270]	; 0232524E
	str r1,[r0,#0x0]	; 02325250
	mov r1,#0x0	; 02325252
	mvn r2,r1	; 02325254
	str r2,[r0,#0x14]	; 02325256
	str r1,[r0,#0x4]	; 02325258
	str r1,[r0,#0x8]	; 0232525A
	str r1,[r0,#0xc]	; 0232525C
	str r1,[r0,#0x10]	; 0232525E
	str r1,[r0,#0x18]	; 02325260
	str r1,[r0,#0x1c]	; 02325262
	str r1,[r0,#0x20]	; 02325264
	str r1,[r0,#0x24]	; 02325266
	ldr r0,[pool_02325274]	; 02325268
	ldr r3,[pool_02325278]	; 0232526A
	bx r3	; 0232526C
	.byte 0xC0, 0x46	; 02325270
pool_02325270:
loc_02325270:
	.word P1_BssStart + 0x240B0	; 02325270
pool_02325274:
loc_02325274:
	.word 0x02354B58	; 02325274
pool_02325278:
loc_02325278:
	.word loc_0232441C + 1	; 02325278

; ===== function loc_0232527C =====
loc_0232527C:
	push {lr}	; 0232527C
	sub sp,#0x4	; 0232527E
	ldr r1,[pool_023252B8]	; 02325280
	ldrh r2,[r1,#0x0]	; 02325282
	mov r0,#0x43	; 02325284
	and r2,r0	; 02325286
	ldr r0,[pool_023252BC]	; 02325288
	orr r2,r0	; 0232528A
	strh r2,[r1,#0x0]	; 0232528C
	bl loc_0232459C	; 0232528E
	add r1,r0,#0x0	; 02325292
	ldr r0,[pool_023252C0]	; 02325294
	str r0,[sp,#0x0]	; 02325296
	ldr r0,[sp,#0x0]	; 02325298
	ldr r2,[pool_023252C4]	; 0232529A
	blx loc_0232DE78	; 0232529C
	bl loc_0232459C	; 023252A0
	ldr r1,[pool_023252C4]	; 023252A4
	blx P1_CleanDataCacheRange	; 023252A6
	mov r0,#0x8	; 023252AA
	bl loc_023245A4	; 023252AC
	add sp,#0x4	; 023252B0
	pop {r3}	; 023252B2
	bx r3	; 023252B4
	.byte 0xC0, 0x46	; 023252B8
pool_023252B8:
loc_023252B8:
	.word REG_BG3CNT_SUB	; 023252B8
pool_023252BC:
loc_023252BC:
	.word 0x00000810	; 023252BC
pool_023252C0:
loc_023252C0:
	.word 0x005F005F	; 023252C0
pool_023252C4:
loc_023252C4:
	.word 0x00000600	; 023252C4

; ===== function loc_023252C8 =====
loc_023252C8:
	ldr r0,[pool_023252E8]	; 023252C8
	ldr r1,[r0,#0x20]	; 023252CA
	lsl r2,r1,#0x1	; 023252CC
	ldr r1,[pool_023252EC]	; 023252CE
	ldrh r2,[r1,r2]	; 023252D0
	ldr r1,[r0,#0xc]	; 023252D2
	cmp r1,r2	; 023252D4
	bge loc_023252DE	; 023252D6
	add r1,#0x10	; 023252D8
	str r1,[r0,#0xc]	; 023252DA
	bx lr	; 023252DC
loc_023252DE:
	cmp r1,r2	; 023252DE
	ble loc_023252E6	; 023252E0
	sub r1,#0x10	; 023252E2
	str r1,[r0,#0xc]	; 023252E4
loc_023252E6:
	bx lr	; 023252E6
pool_023252E8:
loc_023252E8:
	.word P1_BssStart + 0x240B0	; 023252E8
pool_023252EC:
loc_023252EC:
	.word P1_Data_02330170	; 023252EC

; ===== function loc_023252F0 =====
loc_023252F0:
	mov r1,#0x0	; 023252F0
	ldr r0,[pool_023252F8]	; 023252F2
	str r1,[r0,#0x8]	; 023252F4
	bx lr	; 023252F6
pool_023252F8:
loc_023252F8:
	.word P1_BssStart + 0x24168	; 023252F8

; ===== function loc_023252FC =====
loc_023252FC:
	mov r1,#0x1	; 023252FC
	ldr r0,[pool_02325304]	; 023252FE
	str r1,[r0,#0x8]	; 02325300
	bx lr	; 02325302
pool_02325304:
loc_02325304:
	.word P1_BssStart + 0x24168	; 02325304

; ===== function loc_02325308 =====
loc_02325308:
	ldr r1,[pool_02325320]	; 02325308
	ldr r2,[r1,#0x0]	; 0232530A
	mov r0,#0x1	; 0232530C
	and r2,r0	; 0232530E
	cmp r2,#0x0	; 02325310
	bne loc_0232531A	; 02325312
	ldr r1,[r1,#0x4]	; 02325314
	cmp r1,#0x18	; 02325316
	beq loc_0232531C	; 02325318
loc_0232531A:
	mov r0,#0x0	; 0232531A
loc_0232531C:
	bx lr	; 0232531C
	.byte 0xC0, 0x46	; 02325320
pool_02325320:
loc_02325320:
	.word P1_BssStart + 0x24168	; 02325320
	.byte 0x06, 0x49, 0x0A, 0x68, 0x02, 0x20, 0x02, 0x40, 0x00, 0x2A, 0x04, 0xD0, 0x08, 0x6A, 0x00, 0x28	; 02325324
	.byte 0x01, 0xD1, 0x01, 0x20, 0x70, 0x47, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xE8, 0x4B, 0x35, 0x02	; 02325334
P1_Entry_02325344:
	ldr r1,[pool_02325360]	; 02325344
	ldr r2,[r1,#0x0]	; 02325346
	ldr r0,[pool_02325364]	; 02325348
	ldr r0,[r0,#0x4]	; 0232534A
	add r3,r2,#0x0	; 0232534C
	and r3,r0	; 0232534E
	cmp r3,#0x0	; 02325350
	beq P1_Entry_0232535E	; 02325352
	mov r0,#0x4	; 02325354
	bic r2,r0	; 02325356
	str r2,[r1,#0x0]	; 02325358
	mov r0,#0x1	; 0232535A
	str r0,[r1,#0x68]	; 0232535C
P1_Entry_0232535E:
	bx lr	; 0232535E
pool_02325360:
	.word P1_BssStart + 0x24168	; 02325360
pool_02325364:
	.word P1_Data_02330174	; 02325364
P1_Entry_02325368:
	ldr r1,[pool_02325384]	; 02325368
	ldr r2,[r1,#0x0]	; 0232536A
	ldr r0,[pool_02325388]	; 0232536C
	ldr r0,[r0,#0x4]	; 0232536E
	add r3,r2,#0x0	; 02325370
	and r3,r0	; 02325372
	cmp r3,#0x0	; 02325374
	bne P1_Entry_02325382	; 02325376
	mov r0,#0x4	; 02325378
	orr r2,r0	; 0232537A
	str r2,[r1,#0x0]	; 0232537C
	mov r0,#0x1	; 0232537E
	str r0,[r1,#0x68]	; 02325380
P1_Entry_02325382:
	bx lr	; 02325382
pool_02325384:
	.word P1_BssStart + 0x24168	; 02325384
pool_02325388:
	.word P1_Data_02330174	; 02325388
P1_Entry_0232538C:
	ldr r1,[pool_023253A8]	; 0232538C
	ldr r2,[r1,#0x0]	; 0232538E
	ldr r0,[pool_023253AC]	; 02325390
	ldr r0,[r0,#0x0]	; 02325392
	add r3,r2,#0x0	; 02325394
	and r3,r0	; 02325396
	cmp r3,#0x0	; 02325398
	beq P1_Entry_023253A6	; 0232539A
	mov r0,#0x2	; 0232539C
	bic r2,r0	; 0232539E
	str r2,[r1,#0x0]	; 023253A0
	mov r0,#0x1	; 023253A2
	str r0,[r1,#0x28]	; 023253A4
P1_Entry_023253A6:
	bx lr	; 023253A6
pool_023253A8:
	.word P1_BssStart + 0x24168	; 023253A8
pool_023253AC:
	.word P1_Data_02330174	; 023253AC
P1_Entry_023253B0:
	ldr r1,[pool_023253CC]	; 023253B0
	ldr r2,[r1,#0x0]	; 023253B2
	ldr r0,[pool_023253D0]	; 023253B4
	ldr r0,[r0,#0x0]	; 023253B6
	add r3,r2,#0x0	; 023253B8
	and r3,r0	; 023253BA
	cmp r3,#0x0	; 023253BC
	bne P1_Entry_023253CA	; 023253BE
	mov r0,#0x2	; 023253C0
	orr r2,r0	; 023253C2
	str r2,[r1,#0x0]	; 023253C4
	mov r0,#0x1	; 023253C6
	str r0,[r1,#0x28]	; 023253C8
P1_Entry_023253CA:
	bx lr	; 023253CA
pool_023253CC:
	.word P1_BssStart + 0x24168	; 023253CC
pool_023253D0:
	.word P1_Data_02330174	; 023253D0

; ===== function loc_023253D4 =====
loc_023253D4:
	ldr r1,[pool_023253E0]	; 023253D4
	ldr r2,[r1,#0x0]	; 023253D6
	mov r0,#0x1	; 023253D8
	bic r2,r0	; 023253DA
	str r2,[r1,#0x0]	; 023253DC
	bx lr	; 023253DE
pool_023253E0:
loc_023253E0:
	.word P1_BssStart + 0x24168	; 023253E0

; ===== function loc_023253E4 =====
loc_023253E4:
	ldr r1,[pool_023253F0]	; 023253E4
	ldr r2,[r1,#0x0]	; 023253E6
	mov r0,#0x1	; 023253E8
	orr r2,r0	; 023253EA
	str r2,[r1,#0x0]	; 023253EC
	bx lr	; 023253EE
pool_023253F0:
loc_023253F0:
	.word P1_BssStart + 0x24168	; 023253F0

; ===== function loc_023253F4 =====
loc_023253F4:
	push {r4,r5,r6,lr}	; 023253F4
	ldr r2,[pool_0232544C]	; 023253F6
	lsl r1,r0,#0x6	; 023253F8
	add r1,r2,r1	; 023253FA
	lsl r3,r0,#0x2	; 023253FC
	ldr r2,[pool_02325450]	; 023253FE
	ldr r4,[r2,r3]	; 02325400
	ldr r2,[pool_02325454]	; 02325402
	ldr r3,[r2,#0x8]	; 02325404
	cmp r3,#0x0	; 02325406
	beq loc_0232541C	; 02325408
	ldr r2,[r2,#0x0]	; 0232540A
	and r2,r4	; 0232540C
	cmp r2,#0x0	; 0232540E
	beq loc_0232541C	; 02325410
	ldr r1,[r1,#0x8]	; 02325412
	cmp r1,#0x0	; 02325414
	bne loc_0232541C	; 02325416
	mov r5,#0x1	; 02325418
	b loc_0232541E	; 0232541A
loc_0232541C:
	mov r5,#0x0	; 0232541C
loc_0232541E:
	lsl r4,r0,#0x3	; 0232541E
	ldr r0,[pool_02325458]	; 02325420
	ldr r1,[pool_0232545C]	; 02325422
	ldrh r1,[r1,r4]	; 02325424
	bl loc_0232435C	; 02325426
	add r6,r0,#0x0	; 0232542A
	ldr r0,[pool_02325460]	; 0232542C
	ldrh r0,[r0,r4]	; 0232542E
	bl loc_0232414C	; 02325430
	cmp r5,#0x0	; 02325434
	beq loc_02325444	; 02325436
	cmp r6,#0x0	; 02325438
	bne loc_02325440	; 0232543A
	cmp r0,#0x0	; 0232543C
	beq loc_02325444	; 0232543E
loc_02325440:
	mov r0,#0x1	; 02325440
	b loc_02325446	; 02325442
loc_02325444:
	mov r0,#0x0	; 02325444
loc_02325446:
	pop {r4,r5,r6}	; 02325446
	pop {r3}	; 02325448
	bx r3	; 0232544A
pool_0232544C:
loc_0232544C:
	.word 0x02354C00	; 0232544C
pool_02325450:
loc_02325450:
	.word P1_Data_02330174	; 02325450
pool_02325454:
loc_02325454:
	.word P1_BssStart + 0x24168	; 02325454
pool_02325458:
loc_02325458:
	.word 0x02354BF4	; 02325458
pool_0232545C:
loc_0232545C:
	.word P1_Data_02330180	; 0232545C
pool_02325460:
loc_02325460:
	.word P1_Data_02330182	; 02325460
P1_Entry_02325464:
	lsl r2,r1,#0x6	; 02325464
	ldr r1,[pool_0232547C]	; 02325466
	ldr r1,[r1,r2]	; 02325468
	cmp r0,r1	; 0232546A
	beq P1_Entry_02325478	; 0232546C
	ldr r1,[pool_02325480]	; 0232546E
	str r0,[r1,r2]	; 02325470
	mov r1,#0x1	; 02325472
	ldr r0,[pool_02325484]	; 02325474
	str r1,[r0,r2]	; 02325476
P1_Entry_02325478:
	bx lr	; 02325478
	.byte 0xC0, 0x46	; 0232547A
pool_0232547C:
	.word P1_BssStart + 0x24180	; 0232547C
pool_02325480:
	.word P1_BssStart + 0x24184	; 02325480
pool_02325484:
	.word P1_BssStart + 0x24190	; 02325484

; ===== function loc_02325488 =====
loc_02325488:
	push {r4,r5,r6,r7,lr}	; 02325488
	sub sp,#0xc	; 0232548A
	ldr r1,[pool_02325528]	; 0232548C
	ldr r2,[r1,#0x0]	; 0232548E
	mov r0,#0x1	; 02325490
	and r2,r0	; 02325492
	cmp r2,#0x0	; 02325494
	beq loc_023254A4	; 02325496
	ldr r0,[r1,#0x4]	; 02325498
	cmp r0,#0x0	; 0232549A
	beq loc_023254AE	; 0232549C
	sub r0,r0,#0x2	; 0232549E
	str r0,[r1,#0x4]	; 023254A0
	b loc_023254AE	; 023254A2
loc_023254A4:
	ldr r0,[r1,#0x4]	; 023254A4
	cmp r0,#0x18	; 023254A6
	beq loc_023254AE	; 023254A8
	add r0,r0,#0x2	; 023254AA
	str r0,[r1,#0x4]	; 023254AC
loc_023254AE:
	mov r5,#0x0	; 023254AE
	add r7,r5,#0x0	; 023254B0
	mvn r6,r5	; 023254B2
	str r5,[sp,#0x0]	; 023254B4
	str r5,[sp,#0x4]	; 023254B6
loc_023254B8:
	lsl r1,r5,#0x6	; 023254B8
	ldr r0,[pool_0232552C]	; 023254BA
	add r4,r0,r1	; 023254BC
	ldr r0,[r4,#0x10]	; 023254BE
	cmp r0,#0x0	; 023254C0
	beq loc_02325508	; 023254C2
	ldr r0,[r4,#0x8]	; 023254C4
	cmp r0,#0x18	; 023254C6
	beq loc_023254D0	; 023254C8
	add r0,r0,#0x2	; 023254CA
	str r0,[r4,#0x8]	; 023254CC
	b loc_02325512	; 023254CE
loc_023254D0:
	ldr r0,[pool_02325528]	; 023254D0
	ldr r0,[r0,#0x0]	; 023254D2
	lsl r2,r5,#0x2	; 023254D4
	ldr r1,[pool_02325530]	; 023254D6
	ldr r1,[r1,r2]	; 023254D8
	and r0,r1	; 023254DA
	cmp r0,#0x0	; 023254DC
	beq loc_023254E6	; 023254DE
	mov r0,#0x1	; 023254E0
	str r0,[r4,#0xc]	; 023254E2
	b loc_023254E8	; 023254E4
loc_023254E6:
	str r7,[r4,#0xc]	; 023254E6
loc_023254E8:
	ldr r1,[r4,#0x4]	; 023254E8
	ldr r0,[sp,#0x4]	; 023254EA
	mvn r0,r0	; 023254EC
	cmp r1,r0	; 023254EE
	beq loc_02325502	; 023254F0
	str r1,[r4,#0x0]	; 023254F2
	add r0,r4,#0x0	; 023254F4
	add r0,#0x14	; 023254F6
	ldr r1,[pool_02325534]	; 023254F8
	ldr r2,[r4,#0x0]	; 023254FA
	bl loc_02324BA0	; 023254FC
	str r6,[r4,#0x4]	; 02325500
loc_02325502:
	ldr r0,[sp,#0x0]	; 02325502
	str r0,[r4,#0x10]	; 02325504
	b loc_02325512	; 02325506
loc_02325508:
	ldr r0,[r4,#0x8]	; 02325508
	cmp r0,#0x0	; 0232550A
	beq loc_02325512	; 0232550C
	sub r0,r0,#0x2	; 0232550E
	str r0,[r4,#0x8]	; 02325510
loc_02325512:
	add r5,r5,#0x1	; 02325512
	cmp r5,#0x2	; 02325514
	blt loc_023254B8	; 02325516
	ldr r0,[pool_02325538]	; 02325518
	ldr r1,[pool_0232553C]	; 0232551A
	bl loc_02324370	; 0232551C
	add sp,#0xc	; 02325520
	pop {r4,r5,r6,r7}	; 02325522
	pop {r3}	; 02325524
	bx r3	; 02325526
pool_02325528:
loc_02325528:
	.word P1_BssStart + 0x24168	; 02325528
pool_0232552C:
loc_0232552C:
	.word 0x02354C00	; 0232552C
pool_02325530:
loc_02325530:
	.word P1_Data_02330174	; 02325530
pool_02325534:
loc_02325534:
	.word 0x023A5ACC	; 02325534
pool_02325538:
loc_02325538:
	.word 0x02354BF4	; 02325538
pool_0232553C:
loc_0232553C:
	.word 0x023A4AD4	; 0232553C

; ===== function loc_02325540 =====
loc_02325540:
	push {r4,r5,r6,r7,lr}	; 02325540
	sub sp,#0x1c	; 02325542
	bl loc_02323E7C	; 02325544
	add r7,r0,#0x0	; 02325548
	mov r5,#0x0	; 0232554A
	str r5,[sp,#0x10]	; 0232554C
	str r5,[sp,#0x14]	; 0232554E
loc_02325550:
	lsl r1,r5,#0x6	; 02325550
	ldr r0,[pool_023255EC]	; 02325552
	add r4,r0,r1	; 02325554
	ldr r0,[r4,#0xc]	; 02325556
	cmp r0,#0x0	; 02325558
	beq loc_023255B2	; 0232555A
	ldr r1,[r4,#0x8]	; 0232555C
	cmp r1,#0x18	; 0232555E
	beq loc_023255B2	; 02325560
	ldr r0,[pool_023255F0]	; 02325562
	ldr r0,[r0,#0x4]	; 02325564
	add r6,r0,r1	; 02325566
	ldr r0,[pool_023255F0]	; 02325568
	ldr r0,[r0,#0x8]	; 0232556A
	cmp r0,#0x0	; 0232556C
	beq loc_02325582	; 0232556E
	ldr r0,[pool_023255F4]	; 02325570
	lsl r2,r5,#0x3	; 02325572
	ldr r1,[pool_023255F8]	; 02325574
	add r1,r1,r2	; 02325576
	ldrh r1,[r1,#0x4]	; 02325578
	bl loc_02324290	; 0232557A
	str r0,[sp,#0xc]	; 0232557E
	b loc_02325586	; 02325580
loc_02325582:
	mov r0,#0x2	; 02325582
	str r0,[sp,#0xc]	; 02325584
loc_02325586:
	ldr r0,[sp,#0x10]	; 02325586
	str r0,[sp,#0x0]	; 02325588
	add r4,#0x14	; 0232558A
	add r0,r4,#0x0	; 0232558C
	ldr r1,[sp,#0x10]	; 0232558E
	add r2,r6,#0x0	; 02325590
	lsl r3,r1,#0	; 02325592
	bl loc_02323780	; 02325594
	ldr r0,[sp,#0x14]	; 02325598
	str r0,[sp,#0x0]	; 0232559A
	str r6,[sp,#0x4]	; 0232559C
	ldr r0,[sp,#0xc]	; 0232559E
	str r0,[sp,#0x8]	; 023255A0
	add r0,r7,#0x0	; 023255A2
	ldr r1,[pool_023255FC]	; 023255A4
	ldr r2,[pool_02325600]	; 023255A6
	lsl r4,r5,#0x3	; 023255A8
	ldr r3,[pool_023255F8]	; 023255AA
	ldrh r3,[r3,r4]	; 023255AC
	bl loc_02323BEC	; 023255AE
loc_023255B2:
	add r5,r5,#0x1	; 023255B2
	cmp r5,#0x2	; 023255B4
	blt loc_02325550	; 023255B6
	mov r3,#0x0	; 023255B8
	str r3,[sp,#0x0]	; 023255BA
	ldr r0,[pool_023255F0]	; 023255BC
	ldr r0,[r0,#0x4]	; 023255BE
	neg r0,r0	; 023255C0
	str r0,[sp,#0x4]	; 023255C2
	add r0,r7,#0x0	; 023255C4
	ldr r1,[pool_023255FC]	; 023255C6
	ldr r2,[pool_02325600]	; 023255C8
	bl loc_02323C40	; 023255CA
	mov r0,#0x0	; 023255CE
	str r0,[sp,#0x0]	; 023255D0
	ldr r0,[pool_023255F0]	; 023255D2
	ldr r0,[r0,#0x4]	; 023255D4
	str r0,[sp,#0x4]	; 023255D6
	add r0,r7,#0x0	; 023255D8
	ldr r1,[pool_023255FC]	; 023255DA
	ldr r2,[pool_02325600]	; 023255DC
	mov r3,#0x1	; 023255DE
	bl loc_02323C40	; 023255E0
	add sp,#0x1c	; 023255E4
	pop {r4,r5,r6,r7}	; 023255E6
	pop {r3}	; 023255E8
	bx r3	; 023255EA
pool_023255EC:
loc_023255EC:
	.word 0x02354C00	; 023255EC
pool_023255F0:
loc_023255F0:
	.word P1_BssStart + 0x24168	; 023255F0
pool_023255F4:
loc_023255F4:
	.word 0x02354BF4	; 023255F4
pool_023255F8:
loc_023255F8:
	.word P1_Data_0233017C	; 023255F8
pool_023255FC:
loc_023255FC:
	.word 0x023C1178	; 023255FC
pool_02325600:
loc_02325600:
	.word 0x023A4FBC	; 02325600

; ===== function loc_02325604 =====
loc_02325604:
	push {r4,r5,r6,r7,lr}	; 02325604
	sub sp,#0x4	; 02325606
	str r0,[sp,#0x0]	; 02325608
	mov r5,#0x0	; 0232560A
loc_0232560C:
	lsl r4,r5,#0x6	; 0232560C
	ldr r0,[pool_02325644]	; 0232560E
	add r7,r0,r4	; 02325610
	ldr r0,[sp,#0x0]	; 02325612
	add r1,r7,#0x0	; 02325614
	add r1,#0x14	; 02325616
	ldr r2,[pool_02325648]	; 02325618
	lsl r6,r5,#0x3	; 0232561A
	ldr r3,[pool_0232564C]	; 0232561C
	add r3,r3,r6	; 0232561E
	ldrh r3,[r3,#0x2]	; 02325620
	bl loc_02324BF8	; 02325622
	add r7,#0x14	; 02325626
	add r0,r7,#0x0	; 02325628
	ldr r1,[pool_02325648]	; 0232562A
	ldr r2,[pool_02325644]	; 0232562C
	ldr r2,[r2,r4]	; 0232562E
	bl loc_02324BA0	; 02325630
	add r5,r5,#0x1	; 02325634
	cmp r5,#0x2	; 02325636
	blt loc_0232560C	; 02325638
	add sp,#0x4	; 0232563A
	pop {r4,r5,r6,r7}	; 0232563C
	pop {r3}	; 0232563E
	bx r3	; 02325640
	.byte 0xC0, 0x46	; 02325644
pool_02325644:
loc_02325644:
	.word P1_BssStart + 0x24180	; 02325644
pool_02325648:
loc_02325648:
	.word 0x023A5ACC	; 02325648
pool_0232564C:
loc_0232564C:
	.word 0x0233017C	; 0232564C

; ===== function loc_02325650 =====
loc_02325650:
	push {r4,r5,r6,r7,lr}	; 02325650
	sub sp,#0xc	; 02325652
	str r0,[sp,#0x4]	; 02325654
	add r7,r1,#0x0	; 02325656
	add r4,r2,#0x0	; 02325658
	mov r3,#0x0	; 0232565A
	mvn r1,r3	; 0232565C
	add r0,r3,#0x0	; 0232565E
loc_02325660:
	lsl r5,r3,#0x6	; 02325660
	ldr r2,[pool_023256C0]	; 02325662
	add r2,r2,r5	; 02325664
	str r1,[r2,#0x4]	; 02325666
	str r0,[r2,#0x10]	; 02325668
	lsl r6,r3,#0x2	; 0232566A
	ldr r5,[pool_023256C4]	; 0232566C
	ldr r6,[r5,r6]	; 0232566E
	add r5,r4,#0x0	; 02325670
	str r5,[sp,#0x0]	; 02325672
	and r5,r6	; 02325674
	str r5,[sp,#0x0]	; 02325676
	cmp r5,#0x0	; 02325678
	beq loc_02325684	; 0232567A
	mov r5,#0x1	; 0232567C
	str r5,[r2,#0xc]	; 0232567E
	str r0,[r2,#0x8]	; 02325680
	b loc_0232568A	; 02325682
loc_02325684:
	str r0,[r2,#0xc]	; 02325684
	mov r5,#0x18	; 02325686
	str r5,[r2,#0x8]	; 02325688
loc_0232568A:
	add r3,r3,#0x1	; 0232568A
	cmp r3,#0x2	; 0232568C
	blt loc_02325660	; 0232568E
	ldr r1,[pool_023256C8]	; 02325690
	ldr r0,[sp,#0x4]	; 02325692
	str r0,[r1,#0x18]	; 02325694
	str r7,[r1,#0x58]	; 02325696
	str r4,[r1,#0x0]	; 02325698
	mov r0,#0x1	; 0232569A
	and r4,r0	; 0232569C
	cmp r4,#0x0	; 0232569E
	beq loc_023256A8	; 023256A0
	mov r0,#0x0	; 023256A2
	str r0,[r1,#0x4]	; 023256A4
	b loc_023256AC	; 023256A6
loc_023256A8:
	mov r0,#0x18	; 023256A8
	str r0,[r1,#0x4]	; 023256AA
loc_023256AC:
	mov r1,#0x1	; 023256AC
	ldr r0,[pool_023256C8]	; 023256AE
	str r1,[r0,#0x8]	; 023256B0
	ldr r0,[pool_023256CC]	; 023256B2
	bl loc_0232441C	; 023256B4
	add sp,#0xc	; 023256B8
	pop {r4,r5,r6,r7}	; 023256BA
	pop {r3}	; 023256BC
	bx r3	; 023256BE
pool_023256C0:
loc_023256C0:
	.word 0x02354C00	; 023256C0
pool_023256C4:
loc_023256C4:
	.word P1_Data_02330174	; 023256C4
pool_023256C8:
loc_023256C8:
	.word P1_BssStart + 0x24168	; 023256C8
pool_023256CC:
loc_023256CC:
	.word 0x02354BF4	; 023256CC

; ===== function loc_023256D0 =====
loc_023256D0:
	push {r4,r5,r6,lr}	; 023256D0
	sub sp,#0x8	; 023256D2
	add r5,r0,#0x0	; 023256D4
	mov r4,#0x0	; 023256D6
	add r6,r4,#0x0	; 023256D8
	cmp r1,#0x8	; 023256DA
	bhi loc_02325734	; 023256DC
	add r0,r1,r1	; 023256DE
P1_SwitchIndexPC_023256DE:
	add r0,pc	; 023256E0
	ldrh r0,[r0,#(P1_SwitchTable_023256DE - (P1_SwitchIndexPC_023256DE + 4))]	; 023256E2
	lsl r0,r0,#0x10	; 023256E4
	asr r0,r0,#0x10	; 023256E6
P1_SwitchTargetPC_023256DE:
	add r0,pc	; 023256E8
	bx r0	; 023256EA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023256DE:
	.halfword (loc_02325734 + 1) - (P1_SwitchTargetPC_023256DE + 4)
	.halfword (loc_023256FE + 1) - (P1_SwitchTargetPC_023256DE + 4)
	.halfword (loc_0232570C + 1) - (P1_SwitchTargetPC_023256DE + 4)
	.halfword (loc_02325734 + 1) - (P1_SwitchTargetPC_023256DE + 4)
	.halfword (loc_0232571A + 1) - (P1_SwitchTargetPC_023256DE + 4)
	.halfword (loc_02325734 + 1) - (P1_SwitchTargetPC_023256DE + 4)
	.halfword (loc_02325734 + 1) - (P1_SwitchTargetPC_023256DE + 4)
	.halfword (loc_02325734 + 1) - (P1_SwitchTargetPC_023256DE + 4)
	.halfword (loc_02325728 + 1) - (P1_SwitchTargetPC_023256DE + 4)
P1_SwitchTable_023256DEEnd:
loc_023256FE:
	bl P1_GetSubBg0TilemapBase	; 023256FE
	add r4,r0,#0x0	; 02325702
	bl P1_GetSubBg0CharacterBase	; 02325704
	add r6,r0,#0x0	; 02325708
	b loc_02325734	; 0232570A
loc_0232570C:
	bl P1_GetSubBg1TilemapBase	; 0232570C
	add r4,r0,#0x0	; 02325710
	bl P1_GetSubBg1CharacterBase	; 02325712
	add r6,r0,#0x0	; 02325716
	b loc_02325734	; 02325718
loc_0232571A:
	bl loc_02326CA8	; 0232571A
	add r4,r0,#0x0	; 0232571E
	bl loc_02326C08	; 02325720
	add r6,r0,#0x0	; 02325724
	b loc_02325734	; 02325726
loc_02325728:
	bl loc_02326C54	; 02325728
	add r4,r0,#0x0	; 0232572C
	bl loc_02326BBC	; 0232572E
	add r6,r0,#0x0	; 02325732
loc_02325734:
	mov r2,#0x0	; 02325734
	ldr r1,[pool_0232576C]	; 02325736
loc_02325738:
	lsl r0,r2,#0x1	; 02325738
	strh r2,[r4,r0]	; 0232573A
	add r0,r2,#0x1	; 0232573C
	lsl r0,r0,#0x10	; 0232573E
	lsr r2,r0,#0x10	; 02325740
	cmp r2,r1	; 02325742
	bcc loc_02325738	; 02325744
	bl loc_02324CAC	; 02325746
	mov r1,#0x0	; 0232574A
	str r1,[sp,#0x0]	; 0232574C
	str r0,[sp,#0x4]	; 0232574E
	ldr r0,[pool_02325770]	; 02325750
	add r1,r6,#0x0	; 02325752
	ldr r2,[pool_02325774]	; 02325754
	mov r3,#0xc0	; 02325756
	bl loc_02329028	; 02325758
	ldr r0,[pool_02325770]	; 0232575C
	add r1,r5,#0x0	; 0232575E
	bl loc_02329160	; 02325760
	add sp,#0x8	; 02325764
	pop {r4,r5,r6}	; 02325766
	pop {r3}	; 02325768
	bx r3	; 0232576A
pool_0232576C:
loc_0232576C:
	.word 0x00000300	; 0232576C
pool_02325770:
loc_02325770:
	.word 0x02354C80	; 02325770
pool_02325774:
loc_02325774:
	.word 0x00000100	; 02325774

; Returns the fixed firmware UI/boot shared-context address.
; 返回固件 UI/启动共享上下文的固定地址。
.func P1_GetFirmwareUiContext
loc_02325778:
	ldr r0,[pool_0232577C]	; 02325778
	bx lr	; 0232577A
.endfunc
pool_0232577C:
loc_0232577C:
	.word 0x02354C90	; 0232577C

; Initializes the first known fields of the shared firmware UI/boot context.
; 初始化固件 UI/启动共享上下文中已确认的首批字段。
P1_InitializeFirmwareUiContext:
loc_02325780:
	mov r2,#0x0	; 02325780
	ldr r1,[pool_02325798]	; 02325782
	str r2,[r1,#0x0]	; 02325784
	str r2,[r1,#0x4]	; 02325786
	ldr r0,[pool_0232579C]	; 02325788
	orr r2,r0	; 0232578A
	str r2,[r1,#0x0]	; 0232578C
	ldr r0,[pool_023257A0]	; 0232578E
	orr r2,r0	; 02325790
	str r2,[r1,#0x0]	; 02325792
	bx lr	; 02325794
	.byte 0xC0, 0x46	; 02325798
pool_02325798:
loc_02325798:
	.word P1_BssStart + 0x24210	; 02325798
pool_0232579C:
loc_0232579C:
	.word 0x00000200	; 0232579C
pool_023257A0:
loc_023257A0:
	.word 0x00000400	; 023257A0

; ===== function loc_023257A4 =====
loc_023257A4:
	push {r4,r5,r6,r7,lr}	; 023257A4
	sub sp,#0x4	; 023257A6
	bl P1_GetFirmwareUiContext	; 023257A8
	add r5,r0,#0x0	; 023257AC
	ldr r0,[pool_0232586C]	; 023257AE
	ldrh r1,[r0,#0x0]	; 023257B0
	ldr r0,[pool_02325870]	; 023257B2
	ldrh r0,[r0,#0x0]	; 023257B4
	orr r1,r0	; 023257B6
	ldr r0,[pool_02325874]	; 023257B8
	eor r1,r0	; 023257BA
	and r1,r0	; 023257BC
	lsl r0,r1,#0x10	; 023257BE
	lsr r1,r0,#0x10	; 023257C0
	ldr r0,[r5,#0x0]	; 023257C2
	lsl r2,r0,#0x19	; 023257C4
	lsr r2,r2,#0x1f	; 023257C6
	cmp r2,#0x0	; 023257C8
	bne loc_02325862	; 023257CA
	lsl r2,r0,#0x17	; 023257CC
	lsr r2,r2,#0x1f	; 023257CE
	cmp r2,#0x0	; 023257D0
	beq loc_023257E6	; 023257D2
	ldr r2,[pool_02325878]	; 023257D4
	add r3,r1,#0x0	; 023257D6
	and r3,r2	; 023257D8
	cmp r3,r2	; 023257DA
	bne loc_023257E6	; 023257DC
	mov r1,#0x10	; 023257DE
	orr r0,r1	; 023257E0
	str r0,[r5,#0x0]	; 023257E2
	b loc_02325862	; 023257E4
loc_023257E6:
	ldr r0,[pool_0232587C]	; 023257E6
	ldrh r0,[r0,#0x0]	; 023257E8
	lsl r0,r0,#0x19	; 023257EA
	lsr r0,r0,#0x1f	; 023257EC
	cmp r0,#0x0	; 023257EE
	beq loc_02325862	; 023257F0
	ldr r0,[pool_02325880]	; 023257F2
	ldr r0,[r0,#0x0]	; 023257F4
	mov r2,#0x1	; 023257F6
	and r0,r2	; 023257F8
	cmp r0,#0x0	; 023257FA
	bne loc_02325800	; 023257FC
	mov r2,#0x0	; 023257FE
loc_02325800:
	cmp r2,#0x0	; 02325800
	beq loc_02325862	; 02325802
	ldr r0,[r5,#0x0]	; 02325804
	lsl r0,r0,#0x1c	; 02325806
	lsr r0,r0,#0x1f	; 02325808
	cmp r0,#0x0	; 0232580A
	bne loc_02325862	; 0232580C
	ldr r0,[pool_02325880]	; 0232580E
	ldr r2,[r0,#0x0]	; 02325810
	mov r0,#0x2	; 02325812
	and r2,r0	; 02325814
	cmp r2,#0x0	; 02325816
	beq loc_0232581E	; 02325818
	mov r0,#0x1	; 0232581A
	b loc_02325820	; 0232581C
loc_0232581E:
	mov r0,#0x0	; 0232581E
loc_02325820:
	cmp r0,#0x0	; 02325820
	bne loc_0232582E	; 02325822
	ldr r1,[r5,#0x0]	; 02325824
	mov r0,#0x10	; 02325826
	orr r1,r0	; 02325828
	str r1,[r5,#0x0]	; 0232582A
	b loc_02325862	; 0232582C
loc_0232582E:
	mov r4,#0x0	; 0232582E
	ldr r7,[pool_0232586C]	; 02325830
	ldr r6,[pool_02325874]	; 02325832
	b loc_0232585A	; 02325834
loc_02325836:
	bl loc_0232C7C2	; 02325836
	ldrh r1,[r7,#0x0]	; 0232583A
	ldr r0,[pool_02325870]	; 0232583C
	ldrh r0,[r0,#0x0]	; 0232583E
	orr r1,r0	; 02325840
	eor r1,r6	; 02325842
	and r1,r6	; 02325844
	lsl r0,r1,#0x10	; 02325846
	lsr r1,r0,#0x10	; 02325848
	add r4,r4,#0x1	; 0232584A
	cmp r4,#0x1e	; 0232584C
	blt loc_0232585A	; 0232584E
	ldr r1,[r5,#0x0]	; 02325850
	mov r0,#0x10	; 02325852
	orr r1,r0	; 02325854
	str r1,[r5,#0x0]	; 02325856
	b loc_02325862	; 02325858
loc_0232585A:
	mov r0,#0x2	; 0232585A
	and r1,r0	; 0232585C
	cmp r1,#0x0	; 0232585E
	bne loc_02325836	; 02325860
loc_02325862:
	add sp,#0x4	; 02325862
	pop {r4,r5,r6,r7}	; 02325864
	pop {r3}	; 02325866
	bx r3	; 02325868
	.byte 0xC0, 0x46	; 0232586C
pool_0232586C:
loc_0232586C:
	.word REG_KEYINPUT	; 0232586C
pool_02325870:
loc_02325870:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 02325870
pool_02325874:
loc_02325874:
	.word 0x00002FFF	; 02325874
pool_02325878:
loc_02325878:
	.word 0x00000E03	; 02325878
pool_0232587C:
loc_0232587C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 0232587C
pool_02325880:
loc_02325880:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02325880

; ===== function loc_02325884 =====
loc_02325884:
	push {r4,r5,r6,r7,lr}	; 02325884
	sub sp,#0x4	; 02325886
	bl P1_GetFirmwareUiContext	; 02325888
	add r1,r0,#0x0	; 0232588C
	ldr r0,[pool_02325A1C]	; 0232588E
	ldrh r2,[r0,#0x0]	; 02325890
	ldr r0,[pool_02325A20]	; 02325892
	ldrh r0,[r0,#0x0]	; 02325894
	orr r2,r0	; 02325896
	ldr r0,[pool_02325A24]	; 02325898
	eor r2,r0	; 0232589A
	and r2,r0	; 0232589C
	lsl r0,r2,#0x10	; 0232589E
	lsr r0,r0,#0x10	; 023258A0
	ldr r3,[r1,#0x0]	; 023258A2
	mov r2,#0x4	; 023258A4
	bic r3,r2	; 023258A6
	ldr r4,[pool_02325A28]	; 023258A8
	ldrh r2,[r4,#0x0]	; 023258AA
	lsl r2,r2,#0x16	; 023258AC
	lsr r5,r2,#0x1f	; 023258AE
	mov r2,#0x1	; 023258B0
	and r5,r2	; 023258B2
	lsl r5,r5,#0x2	; 023258B4
	orr r3,r5	; 023258B6
	str r3,[r1,#0x0]	; 023258B8
	ldrh r6,[r4,#0x0]	; 023258BA
	lsl r3,r6,#0x15	; 023258BC
	lsr r7,r3,#0x1f	; 023258BE
	lsl r3,r6,#0x11	; 023258C0
	lsr r5,r3,#0x1f	; 023258C2
	lsl r3,r6,#0x14	; 023258C4
	lsr r4,r3,#0x1f	; 023258C6
	lsl r3,r6,#0x12	; 023258C8
	lsr r3,r3,#0x1f	; 023258CA
	lsl r6,r6,#0x10	; 023258CC
	lsr r6,r6,#0x1f	; 023258CE
	and r3,r6	; 023258D0
	and r4,r3	; 023258D2
	and r5,r4	; 023258D4
	and r7,r5	; 023258D6
	cmp r7,#0x0	; 023258D8
	beq loc_023258DE	; 023258DA
	mov r2,#0x0	; 023258DC
loc_023258DE:
	ldr r4,[r1,#0x0]	; 023258DE
	mov r3,#0x1	; 023258E0
	bic r4,r3	; 023258E2
	and r2,r3	; 023258E4
	orr r4,r2	; 023258E6
	str r4,[r1,#0x0]	; 023258E8
	ldr r2,[r1,#0x0]	; 023258EA
	mov r4,#0x2	; 023258EC
	bic r2,r4	; 023258EE
	ldr r4,[pool_02325A28]	; 023258F0
	ldrh r4,[r4,#0x0]	; 023258F2
	lsl r4,r4,#0x12	; 023258F4
	lsr r4,r4,#0x1f	; 023258F6
	and r4,r3	; 023258F8
	lsl r4,r4,#0x1	; 023258FA
	orr r2,r4	; 023258FC
	str r2,[r1,#0x0]	; 023258FE
	ldr r6,[r1,#0x0]	; 02325900
	ldr r4,[pool_02325A2C]	; 02325902
	add r2,r6,#0x0	; 02325904
	and r2,r4	; 02325906
	lsl r4,r6,#0x1f	; 02325908
	lsr r5,r4,#0x1f	; 0232590A
	lsl r4,r6,#0x1d	; 0232590C
	lsr r4,r4,#0x1f	; 0232590E
	orr r5,r4	; 02325910
	and r5,r3	; 02325912
	lsl r4,r5,#0x8	; 02325914
	orr r2,r4	; 02325916
	str r2,[r1,#0x0]	; 02325918
	mov r2,#0x8	; 0232591A
	add r4,r0,#0x0	; 0232591C
	and r4,r2	; 0232591E
	cmp r4,#0x0	; 02325920
	bne loc_02325926	; 02325922
	mov r3,#0x0	; 02325924
loc_02325926:
	ldr r5,[r1,#0x0]	; 02325926
	mov r2,#0x8	; 02325928
	bic r5,r2	; 0232592A
	mov r4,#0x1	; 0232592C
	and r3,r4	; 0232592E
	lsl r2,r3,#0x3	; 02325930
	orr r5,r2	; 02325932
	str r5,[r1,#0x0]	; 02325934
	mov r3,#0x0	; 02325936
	add r2,r3,#0x0	; 02325938
	ldr r5,[pool_02325A30]	; 0232593A
	ldr r6,[r5,#0x0]	; 0232593C
	mov r5,#0x2	; 0232593E
	and r6,r5	; 02325940
	cmp r6,#0x0	; 02325942
	bne loc_02325948	; 02325944
	add r4,r3,#0x0	; 02325946
loc_02325948:
	cmp r4,#0x0	; 02325948
	beq loc_02325958	; 0232594A
	ldr r4,[r1,#0x0]	; 0232594C
	lsl r4,r4,#0x17	; 0232594E
	lsr r4,r4,#0x1f	; 02325950
	cmp r4,#0x0	; 02325952
	beq loc_02325958	; 02325954
	mov r2,#0x1	; 02325956
loc_02325958:
	cmp r2,#0x0	; 02325958
	beq loc_02325966	; 0232595A
	ldr r2,[pool_02325A34]	; 0232595C
	and r0,r2	; 0232595E
	cmp r0,r2	; 02325960
	bne loc_02325966	; 02325962
	mov r3,#0x1	; 02325964
loc_02325966:
	ldr r4,[r1,#0x0]	; 02325966
	mov r0,#0x40	; 02325968
	bic r4,r0	; 0232596A
	mov r0,#0x1	; 0232596C
	and r3,r0	; 0232596E
	lsl r2,r3,#0x6	; 02325970
	orr r4,r2	; 02325972
	str r4,[r1,#0x0]	; 02325974
	mov r2,#0x0	; 02325976
	ldr r3,[pool_02325A30]	; 02325978
	ldr r4,[r3,#0x0]	; 0232597A
	mov r3,#0x2	; 0232597C
	and r4,r3	; 0232597E
	cmp r4,#0x0	; 02325980
	bne loc_02325986	; 02325982
	add r0,r2,#0x0	; 02325984
loc_02325986:
	cmp r0,#0x0	; 02325986
	beq loc_023259B6	; 02325988
	mov r0,#0x0	; 0232598A
	ldr r3,[pool_02325A30]	; 0232598C
	ldr r4,[r3,#0x0]	; 0232598E
	mov r3,#0x2	; 02325990
	and r4,r3	; 02325992
	cmp r4,#0x0	; 02325994
	beq loc_0232599C	; 02325996
	mov r3,#0x1	; 02325998
	b loc_0232599E	; 0232599A
loc_0232599C:
	add r3,r0,#0x0	; 0232599C
loc_0232599E:
	cmp r3,#0x0	; 0232599E
	beq loc_023259B0	; 023259A0
	ldr r3,[pool_02325A38]	; 023259A2
	ldrb r3,[r3,#0x0]	; 023259A4
	lsl r3,r3,#0x1d	; 023259A6
	lsr r3,r3,#0x1f	; 023259A8
	cmp r3,#0x0	; 023259AA
	beq loc_023259B0	; 023259AC
	mov r0,#0x1	; 023259AE
loc_023259B0:
	cmp r0,#0x0	; 023259B0
	beq loc_023259B6	; 023259B2
	mov r2,#0x1	; 023259B4
loc_023259B6:
	ldr r4,[r1,#0x0]	; 023259B6
	mov r3,#0x40	; 023259B8
	add r0,r4,#0x0	; 023259BA
	bic r0,r3	; 023259BC
	lsl r3,r4,#0x19	; 023259BE
	lsr r4,r3,#0x1f	; 023259C0
	orr r4,r2	; 023259C2
	mov r3,#0x1	; 023259C4
	and r4,r3	; 023259C6
	lsl r2,r4,#0x6	; 023259C8
	orr r0,r2	; 023259CA
	str r0,[r1,#0x0]	; 023259CC
	mov r2,#0x0	; 023259CE
	add r0,r2,#0x0	; 023259D0
	ldr r4,[pool_02325A28]	; 023259D2
	ldrh r4,[r4,#0x0]	; 023259D4
	lsl r4,r4,#0x19	; 023259D6
	lsr r4,r4,#0x1f	; 023259D8
	cmp r4,#0x0	; 023259DA
	beq loc_023259F2	; 023259DC
	ldr r4,[pool_02325A30]	; 023259DE
	ldr r5,[r4,#0x0]	; 023259E0
	mov r4,#0x2	; 023259E2
	and r5,r4	; 023259E4
	cmp r5,#0x0	; 023259E6
	bne loc_023259EC	; 023259E8
	add r3,r2,#0x0	; 023259EA
loc_023259EC:
	cmp r3,#0x0	; 023259EC
	beq loc_023259F2	; 023259EE
	mov r0,#0x1	; 023259F0
loc_023259F2:
	cmp r0,#0x0	; 023259F2
	beq loc_02325A02	; 023259F4
	ldr r0,[r1,#0x0]	; 023259F6
	lsl r0,r0,#0x1c	; 023259F8
	lsr r0,r0,#0x1f	; 023259FA
	cmp r0,#0x0	; 023259FC
	bne loc_02325A02	; 023259FE
	mov r2,#0x1	; 02325A00
loc_02325A02:
	ldr r3,[r1,#0x0]	; 02325A02
	mov r0,#0x20	; 02325A04
	bic r3,r0	; 02325A06
	mov r0,#0x1	; 02325A08
	and r2,r0	; 02325A0A
	lsl r0,r2,#0x5	; 02325A0C
	orr r3,r0	; 02325A0E
	str r3,[r1,#0x0]	; 02325A10
	add sp,#0x4	; 02325A12
	pop {r4,r5,r6,r7}	; 02325A14
	pop {r3}	; 02325A16
	bx r3	; 02325A18
	.byte 0xC0, 0x46	; 02325A1C
pool_02325A1C:
loc_02325A1C:
	.word REG_KEYINPUT	; 02325A1C
pool_02325A20:
loc_02325A20:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 02325A20
pool_02325A24:
loc_02325A24:
	.word 0x00002FFF	; 02325A24
pool_02325A28:
loc_02325A28:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02325A28
pool_02325A2C:
loc_02325A2C:
	.word 0xFFFFFEFF	; 02325A2C
pool_02325A30:
loc_02325A30:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02325A30
pool_02325A34:
loc_02325A34:
	.word 0x00000D03	; 02325A34
pool_02325A38:
loc_02325A38:
	.word NdsCartHeaderRamAddress + 0x1F	; 02325A38

; ===== function loc_02325A3C =====
loc_02325A3C:
	push {lr}	; 02325A3C
	sub sp,#0x4	; 02325A3E
	cmp r1,#0xa	; 02325A40
	bge loc_02325A54	; 02325A42
	lsl r2,r1,#0x1	; 02325A44
	ldr r1,[pool_02325A60]	; 02325A46
	ldrh r1,[r1,r2]	; 02325A48
	strh r1,[r0,#0x0]	; 02325A4A
	mov r1,#0x0	; 02325A4C
	strh r1,[r0,#0x2]	; 02325A4E
	add r0,r0,#0x2	; 02325A50
	b loc_02325A58	; 02325A52
loc_02325A54:
	bl loc_02325A64	; 02325A54
loc_02325A58:
	add sp,#0x4	; 02325A58
	pop {r3}	; 02325A5A
	bx r3	; 02325A5C
	.byte 0xC0, 0x46	; 02325A60
pool_02325A60:
loc_02325A60:
	.word P1_Data_0233018C	; 02325A60

; ===== function loc_02325A64 =====
loc_02325A64:
	push {r4,r5,lr}	; 02325A64
	sub sp,#0x4	; 02325A66
	add r5,r0,#0x0	; 02325A68
	add r4,r1,#0x0	; 02325A6A
	add r0,r4,#0x0	; 02325A6C
	mov r1,#0xa	; 02325A6E
	blx P1_SignedDivMod	; 02325A70
	mov r1,#0xa	; 02325A74
	blx P1_SignedDivMod	; 02325A76
	lsl r1,r1,#0x1	; 02325A7A
	ldr r0,[pool_02325AA0]	; 02325A7C
	ldrh r0,[r0,r1]	; 02325A7E
	strh r0,[r5,#0x0]	; 02325A80
	add r0,r4,#0x0	; 02325A82
	mov r1,#0xa	; 02325A84
	blx P1_SignedDivMod	; 02325A86
	lsl r1,r1,#0x1	; 02325A8A
	ldr r0,[pool_02325AA0]	; 02325A8C
	ldrh r0,[r0,r1]	; 02325A8E
	strh r0,[r5,#0x2]	; 02325A90
	mov r0,#0x0	; 02325A92
	strh r0,[r5,#0x4]	; 02325A94
	add r0,r5,#0x4	; 02325A96
	add sp,#0x4	; 02325A98
	pop {r4,r5}	; 02325A9A
	pop {r3}	; 02325A9C
	bx r3	; 02325A9E
pool_02325AA0:
loc_02325AA0:
	.word P1_Data_0233018C	; 02325AA0

; ===== function loc_02325AA4 =====
loc_02325AA4:
	push {r4,r5,r6,r7,lr}	; 02325AA4
	sub sp,#0x1fc	; 02325AA6
	sub sp,#0x10	; 02325AA8
	add r5,r0,#0x0	; 02325AAA
	mov r4,#0x0	; 02325AAC
	add r0,sp,#0x8	; 02325AAE
	ldr r1,[pool_02325B10]	; 02325AB0
	bl loc_0232D1D0	; 02325AB2
	mov r0,#0x39	; 02325AB6
	bl loc_02324DE0	; 02325AB8
	add r6,r0,#0x0	; 02325ABC
	add r0,sp,#0x0	; 02325ABE
	ldr r1,[r5,#0x10]	; 02325AC0
	ldrb r1,[r1,#0x0]	; 02325AC2
	bl loc_02325A64	; 02325AC4
	add r0,sp,#0x4	; 02325AC8
	ldr r1,[r5,#0x10]	; 02325ACA
	ldrb r1,[r1,#0x1]	; 02325ACC
	bl loc_02325A64	; 02325ACE
	lsl r3,r4,#0	; 02325AD2
	add r0,sp,#0x8	; 02325AD4
	add r7,sp,#0x0	; 02325AD6
	b loc_02325AEE	; 02325AD8
loc_02325ADA:
	ldr r5,[pool_02325B14]	; 02325ADA
	cmp r2,r5	; 02325ADC
	bne loc_02325AEA	; 02325ADE
	lsl r2,r4,#0x1	; 02325AE0
	add r4,r4,#0x1	; 02325AE2
	ldrh r2,[r7,r2]	; 02325AE4
	strh r2,[r0,r1]	; 02325AE6
	b loc_02325AEC	; 02325AE8
loc_02325AEA:
	strh r2,[r0,r1]	; 02325AEA
loc_02325AEC:
	add r3,r3,#0x1	; 02325AEC
loc_02325AEE:
	lsl r1,r3,#0x1	; 02325AEE
	ldrh r2,[r6,r1]	; 02325AF0
	cmp r2,#0x0	; 02325AF2
	beq loc_02325AFC	; 02325AF4
	ldr r5,[pool_02325B18]	; 02325AF6
	cmp r3,r5	; 02325AF8
	blt loc_02325ADA	; 02325AFA
loc_02325AFC:
	mov r0,#0x39	; 02325AFC
	mov r1,#0x1	; 02325AFE
	add r2,sp,#0x8	; 02325B00
	bl loc_02325088	; 02325B02
	add sp,#0x1fc	; 02325B06
	add sp,#0x10	; 02325B08
	pop {r4,r5,r6,r7}	; 02325B0A
	pop {r3}	; 02325B0C
	bx r3	; 02325B0E
pool_02325B10:
loc_02325B10:
	.word 0x00000200	; 02325B10
pool_02325B14:
loc_02325B14:
	.word 0x000025CF	; 02325B14
pool_02325B18:
loc_02325B18:
	.word 0x00000100	; 02325B18

; ===== function loc_02325B1C =====
loc_02325B1C:
	push {r4,lr}	; 02325B1C
	sub sp,#0x8	; 02325B1E
	add r4,r0,#0x0	; 02325B20
	ldr r0,[r4,#0x0]	; 02325B22
	cmp r0,#0x0	; 02325B24
	bne loc_02325B40	; 02325B26
	mov r0,#0x0	; 02325B28
	str r0,[sp,#0x0]	; 02325B2A
	ldr r0,[pool_02325B98]	; 02325B2C
	ldr r1,[r4,#0xc]	; 02325B2E
	ldr r2,[r4,#0x8]	; 02325B30
	mov r3,#0x10	; 02325B32
	bl loc_0232D968	; 02325B34
	ldr r0,[r4,#0x0]	; 02325B38
	add r0,r0,#0x1	; 02325B3A
	str r0,[r4,#0x0]	; 02325B3C
	b loc_02325B90	; 02325B3E
loc_02325B40:
	cmp r0,#0xf	; 02325B40
	bgt loc_02325B60	; 02325B42
	lsl r0,r0,#0x4	; 02325B44
	mov r1,#0xf	; 02325B46
	blx P1_SignedDivMod	; 02325B48
	mov r1,#0x10	; 02325B4C
	sub r1,r1,r0	; 02325B4E
	lsl r0,r0,#0x8	; 02325B50
	orr r1,r0	; 02325B52
	ldr r0,[pool_02325B9C]	; 02325B54
	strh r1,[r0,#0x0]	; 02325B56
	ldr r0,[r4,#0x0]	; 02325B58
	add r0,r0,#0x1	; 02325B5A
	str r0,[r4,#0x0]	; 02325B5C
	b loc_02325B90	; 02325B5E
loc_02325B60:
	mov r0,#0x0	; 02325B60
	str r0,[r4,#0x0]	; 02325B62
	ldr r2,[r4,#0x38]	; 02325B64
	mov r1,#0x4	; 02325B66
	bic r2,r1	; 02325B68
	str r2,[r4,#0x38]	; 02325B6A
	ldr r2,[r4,#0x38]	; 02325B6C
	mov r1,#0x10	; 02325B6E
	orr r2,r1	; 02325B70
	str r2,[r4,#0x38]	; 02325B72
	ldr r2,[pool_02325BA0]	; 02325B74
	ldr r3,[r2,#0x0]	; 02325B76
	ldr r1,[pool_02325BA4]	; 02325B78
	and r3,r1	; 02325B7A
	ldr r1,[r4,#0x8]	; 02325B7C
	lsl r1,r1,#0x8	; 02325B7E
	orr r3,r1	; 02325B80
	str r3,[r2,#0x0]	; 02325B82
	ldr r1,[pool_02325B98]	; 02325B84
	strh r0,[r1,#0x0]	; 02325B86
	bl loc_023253E4	; 02325B88
	mov r0,#0x0	; 02325B8C
	str r0,[r4,#0x30]	; 02325B8E
loc_02325B90:
	add sp,#0x8	; 02325B90
	pop {r4}	; 02325B92
	pop {r3}	; 02325B94
	bx r3	; 02325B96
pool_02325B98:
loc_02325B98:
	.word REG_BLDCNT_SUB	; 02325B98
pool_02325B9C:
loc_02325B9C:
	.word REG_BLDALPHA_SUB	; 02325B9C
pool_02325BA0:
loc_02325BA0:
	.word REG_DISPCNT_B	; 02325BA0
pool_02325BA4:
loc_02325BA4:
	.word 0xFFFFE0FF	; 02325BA4

; ===== function loc_02325BA8 =====
loc_02325BA8:
	push {r4,r5,lr}	; 02325BA8
	sub sp,#0x4	; 02325BAA
	add r5,r1,#0x0	; 02325BAC
	mov r4,#0x0	; 02325BAE
	str r4,[sp,#0x0]	; 02325BB0
	ldr r0,[pool_02325C5C]	; 02325BB2
	mov r1,#0x10	; 02325BB4
	ldr r2,[r5,#0xc]	; 02325BB6
	add r3,r1,#0x0	; 02325BB8
	bl loc_0232D968	; 02325BBA
	bl loc_0232505C	; 02325BBE
	cmp r0,#0x0	; 02325BC2
	bne loc_02325BD6	; 02325BC4
	ldr r0,[r5,#0x38]	; 02325BC6
	lsl r0,r0,#0x1a	; 02325BC8
	lsr r4,r0,#0x1f	; 02325BCA
	mov r0,#0x0	; 02325BCC
	str r0,[r5,#0x0]	; 02325BCE
	str r0,[r5,#0x4]	; 02325BD0
	str r0,[r5,#0x30]	; 02325BD2
	b loc_02325C52	; 02325BD4
loc_02325BD6:
	bl loc_02325070	; 02325BD6
	cmp r0,#0x0	; 02325BDA
	bne loc_02325C52	; 02325BDC
	lsl r0,r4,#0	; 02325BDE
	bl loc_023253F4	; 02325BE0
	cmp r0,#0x0	; 02325BE4
	beq loc_02325C0E	; 02325BE6
	mov r0,#0x1b	; 02325BE8
	bl loc_02323724	; 02325BEA
	bl loc_0232507C	; 02325BEE
	lsl r0,r4,#0	; 02325BF2
	bl loc_02322A14	; 02325BF4
	ldr r1,[r5,#0x38]	; 02325BF8
	mov r0,#0x20	; 02325BFA
	orr r1,r0	; 02325BFC
	str r1,[r5,#0x38]	; 02325BFE
	mov r0,#0x9	; 02325C00
	str r0,[r5,#0x34]	; 02325C02
	bl loc_0232660C	; 02325C04
	bl loc_0232696C	; 02325C08
	b loc_02325C52	; 02325C0C
loc_02325C0E:
	mov r0,#0x1	; 02325C0E
	bl loc_023253F4	; 02325C10
	cmp r0,#0x0	; 02325C14
	beq loc_02325C34	; 02325C16
	lsl r0,r4,#0	; 02325C18
	str r0,[r5,#0x4]	; 02325C1A
	add r0,r5,#0x0	; 02325C1C
	mov r1,#0x5	; 02325C1E
	bl loc_02326214	; 02325C20
	mov r0,#0x20	; 02325C24
	bl loc_02323724	; 02325C26
	bl loc_0232507C	; 02325C2A
	mov r0,#0x4	; 02325C2E
	str r0,[r5,#0x34]	; 02325C30
	b loc_02325C52	; 02325C32
loc_02325C34:
	add r0,r5,#0x0	; 02325C34
	bl loc_02326258	; 02325C36
	cmp r0,#0x0	; 02325C3A
	beq loc_02325C52	; 02325C3C
	lsl r0,r4,#0	; 02325C3E
	str r0,[r5,#0x4]	; 02325C40
	add r0,r5,#0x0	; 02325C42
	mov r1,#0x5	; 02325C44
	bl loc_02326214	; 02325C46
	bl loc_0232507C	; 02325C4A
	mov r0,#0x4	; 02325C4E
	str r0,[r5,#0x34]	; 02325C50
loc_02325C52:
	add r0,r4,#0x0	; 02325C52
	add sp,#0x4	; 02325C54
	pop {r4,r5}	; 02325C56
	pop {r3}	; 02325C58
	bx r3	; 02325C5A
pool_02325C5C:
loc_02325C5C:
	.word REG_BLDCNT_SUB	; 02325C5C

; ===== function loc_02325C60 =====
loc_02325C60:
	push {r4,lr}	; 02325C60
	sub sp,#0x8	; 02325C62
	add r4,r0,#0x0	; 02325C64
	ldr r0,[r4,#0x0]	; 02325C66
	cmp r0,#0x0	; 02325C68
	bne loc_02325C84	; 02325C6A
	mov r0,#0x0	; 02325C6C
	str r0,[sp,#0x0]	; 02325C6E
	ldr r0,[pool_02325CC8]	; 02325C70
	mov r1,#0x10	; 02325C72
	ldr r2,[r4,#0xc]	; 02325C74
	add r3,r1,#0x0	; 02325C76
	bl loc_0232D968	; 02325C78
	ldr r0,[r4,#0x0]	; 02325C7C
	add r0,r0,#0x1	; 02325C7E
	str r0,[r4,#0x0]	; 02325C80
	b loc_02325CC0	; 02325C82
loc_02325C84:
	cmp r0,#0xf	; 02325C84
	bgt loc_02325CA4	; 02325C86
	lsl r0,r0,#0x4	; 02325C88
	mov r1,#0xf	; 02325C8A
	blx P1_SignedDivMod	; 02325C8C
	mov r1,#0x10	; 02325C90
	sub r1,r1,r0	; 02325C92
	lsl r0,r0,#0x8	; 02325C94
	orr r1,r0	; 02325C96
	ldr r0,[pool_02325CCC]	; 02325C98
	strh r1,[r0,#0x0]	; 02325C9A
	ldr r0,[r4,#0x0]	; 02325C9C
	add r0,r0,#0x1	; 02325C9E
	str r0,[r4,#0x0]	; 02325CA0
	b loc_02325CC0	; 02325CA2
loc_02325CA4:
	mov r0,#0x0	; 02325CA4
	str r0,[r4,#0x0]	; 02325CA6
	ldr r1,[r4,#0x38]	; 02325CA8
	mov r0,#0x2	; 02325CAA
	bic r1,r0	; 02325CAC
	str r1,[r4,#0x38]	; 02325CAE
	mov r0,#0x38	; 02325CB0
	mov r1,#0x1	; 02325CB2
	bl loc_023250A4	; 02325CB4
	bl loc_023253E4	; 02325CB8
	mov r0,#0x8	; 02325CBC
	str r0,[r4,#0x30]	; 02325CBE
loc_02325CC0:
	add sp,#0x8	; 02325CC0
	pop {r4}	; 02325CC2
	pop {r3}	; 02325CC4
	bx r3	; 02325CC6
pool_02325CC8:
loc_02325CC8:
	.word REG_BLDCNT_SUB	; 02325CC8
pool_02325CCC:
loc_02325CCC:
	.word REG_BLDALPHA_SUB	; 02325CCC

; ===== function loc_02325CD0 =====
loc_02325CD0:
	push {r4,r5,r6,lr}	; 02325CD0
	add r5,r0,#0x0	; 02325CD2
	ldr r1,[r5,#0x14]	; 02325CD4
	ldr r3,[r5,#0x18]	; 02325CD6
	mov r2,#0x3c	; 02325CD8
	add r0,r1,#0x0	; 02325CDA
	mul r0,r2	; 02325CDC
	add r4,r3,r0	; 02325CDE
	ldr r3,[r5,#0x10]	; 02325CE0
	ldrb r0,[r3,#0x0]	; 02325CE2
	ldrb r6,[r3,#0x1]	; 02325CE4
	add r3,r0,#0x0	; 02325CE6
	mul r3,r2	; 02325CE8
	add r6,r6,r3	; 02325CEA
	cmp r1,r0	; 02325CEC
	bcs loc_02325CF4	; 02325CEE
	ldr r0,[pool_02325DF0]	; 02325CF0
	add r4,r4,r0	; 02325CF2
loc_02325CF4:
	ldr r0,[pool_02325DF4]	; 02325CF4
	bl loc_0232414C	; 02325CF6
	cmp r0,#0x0	; 02325CFA
	bne loc_02325D06	; 02325CFC
	bl loc_02324120	; 02325CFE
	cmp r0,#0x0	; 02325D02
	beq loc_02325D32	; 02325D04
loc_02325D06:
	add r0,r5,#0x0	; 02325D06
	mov r1,#0x1	; 02325D08
	bl loc_02326214	; 02325D0A
	add r0,r5,#0x0	; 02325D0E
	bl loc_023261D4	; 02325D10
	add r0,r5,#0x0	; 02325D14
	add r0,#0x2c	; 02325D16
	bl loc_02323700	; 02325D18
	bl loc_0232696C	; 02325D1C
	mov r0,#0x0	; 02325D20
	str r0,[r5,#0x0]	; 02325D22
	str r0,[r5,#0x4]	; 02325D24
	mov r0,#0x7	; 02325D26
	str r0,[r5,#0x30]	; 02325D28
	mov r0,#0x28	; 02325D2A
	bl loc_02323724	; 02325D2C
	b loc_02325DEA	; 02325D30
loc_02325D32:
	add r6,#0x3c	; 02325D32
	cmp r4,r6	; 02325D34
	blt loc_02325D74	; 02325D36
	mov r0,#0x0	; 02325D38
	str r0,[r5,#0x0]	; 02325D3A
	str r0,[r5,#0x4]	; 02325D3C
	ldr r1,[r5,#0x38]	; 02325D3E
	mov r0,#0x4	; 02325D40
	bic r1,r0	; 02325D42
	str r1,[r5,#0x38]	; 02325D44
	mov r0,#0x5	; 02325D46
	str r0,[r5,#0x30]	; 02325D48
	add r0,r5,#0x0	; 02325D4A
	add r0,#0x3c	; 02325D4C
	ldr r1,[pool_02325DF8]	; 02325D4E
	mov r2,#0x5e	; 02325D50
	bl loc_02324BA0	; 02325D52
	mov r0,#0x0	; 02325D56
	bl loc_023228FC	; 02325D58
	add r0,r5,#0x0	; 02325D5C
	add r0,#0x2c	; 02325D5E
	bl loc_02323700	; 02325D60
	bl loc_0232696C	; 02325D64
	bl loc_02326640	; 02325D68
	add r0,r5,#0x0	; 02325D6C
	bl loc_0232666C	; 02325D6E
	b loc_02325DEA	; 02325D72
loc_02325D74:
	ldr r0,[r5,#0x38]	; 02325D74
	lsl r0,r0,#0x1c	; 02325D76
	lsr r0,r0,#0x1f	; 02325D78
	cmp r0,#0x0	; 02325D7A
	beq loc_02325DAC	; 02325D7C
	add r0,r5,#0x0	; 02325D7E
	bl loc_02326258	; 02325D80
	cmp r0,#0x0	; 02325D84
	beq loc_02325DEA	; 02325D86
	add r0,r5,#0x0	; 02325D88
	mov r1,#0x5	; 02325D8A
	bl loc_02326214	; 02325D8C
	mov r0,#0x0	; 02325D90
	str r0,[r5,#0x0]	; 02325D92
	str r0,[r5,#0x4]	; 02325D94
	ldr r1,[r5,#0x38]	; 02325D96
	mov r0,#0x8	; 02325D98
	bic r1,r0	; 02325D9A
	str r1,[r5,#0x38]	; 02325D9C
	add r5,#0x2c	; 02325D9E
	add r0,r5,#0x0	; 02325DA0
	bl loc_02323700	; 02325DA2
	bl loc_0232696C	; 02325DA6
	b loc_02325DEA	; 02325DAA
loc_02325DAC:
	add r0,r5,#0x0	; 02325DAC
	bl loc_02326184	; 02325DAE
	add r0,r5,#0x0	; 02325DB2
	bl loc_02326258	; 02325DB4
	cmp r0,#0x0	; 02325DB8
	beq loc_02325DEA	; 02325DBA
	add r0,r5,#0x0	; 02325DBC
	mov r1,#0x1	; 02325DBE
	bl loc_02326214	; 02325DC0
	mov r0,#0x0	; 02325DC4
	str r0,[r5,#0x0]	; 02325DC6
	str r0,[r5,#0x4]	; 02325DC8
	ldr r1,[r5,#0x38]	; 02325DCA
	mov r0,#0x8	; 02325DCC
	orr r1,r0	; 02325DCE
	str r1,[r5,#0x38]	; 02325DD0
	add r0,r5,#0x0	; 02325DD2
	bl loc_023261D4	; 02325DD4
	mov r0,#0x27	; 02325DD8
	add r5,#0x2c	; 02325DDA
	add r1,r5,#0x0	; 02325DDC
	bl loc_0232370C	; 02325DDE
	mov r0,#0x2	; 02325DE2
	mov r1,#0x0	; 02325DE4
	bl loc_02326984	; 02325DE6
loc_02325DEA:
	pop {r4,r5,r6}	; 02325DEA
	pop {r3}	; 02325DEC
	bx r3	; 02325DEE
pool_02325DF0:
loc_02325DF0:
	.word 0x000005A0	; 02325DF0
pool_02325DF4:
loc_02325DF4:
	.word 0x00000CFF	; 02325DF4
pool_02325DF8:
loc_02325DF8:
	.word 0x023A5BC4	; 02325DF8

; ===== function loc_02325DFC =====
loc_02325DFC:
	push {r4,lr}	; 02325DFC
	add r4,r0,#0x0	; 02325DFE
	ldr r0,[pool_02325EA0]	; 02325E00
	bl loc_0232414C	; 02325E02
	cmp r0,#0x0	; 02325E06
	bne loc_02325E12	; 02325E08
	bl loc_02324120	; 02325E0A
	cmp r0,#0x0	; 02325E0E
	beq loc_02325E32	; 02325E10
loc_02325E12:
	add r0,r4,#0x0	; 02325E12
	mov r1,#0x1	; 02325E14
	bl loc_02326214	; 02325E16
	mov r0,#0x28	; 02325E1A
	bl loc_02323724	; 02325E1C
	add r0,r4,#0x0	; 02325E20
	bl loc_023261D4	; 02325E22
	mov r0,#0x7	; 02325E26
	str r0,[r4,#0x30]	; 02325E28
	mov r0,#0x0	; 02325E2A
	str r0,[r4,#0x0]	; 02325E2C
	str r0,[r4,#0x4]	; 02325E2E
	b loc_02325E9A	; 02325E30
loc_02325E32:
	add r0,r4,#0x0	; 02325E32
	bl loc_02326184	; 02325E34
	ldr r2,[r4,#0x10]	; 02325E38
	ldr r1,[r4,#0x14]	; 02325E3A
	ldrb r0,[r2,#0x0]	; 02325E3C
	cmp r1,r0	; 02325E3E
	bne loc_02325E9A	; 02325E40
	ldr r1,[r4,#0x18]	; 02325E42
	ldrb r0,[r2,#0x1]	; 02325E44
	cmp r1,r0	; 02325E46
	bne loc_02325E9A	; 02325E48
	add r0,r4,#0x0	; 02325E4A
	mov r1,#0x1	; 02325E4C
	bl loc_02326214	; 02325E4E
	mov r0,#0x1	; 02325E52
	bl loc_023228FC	; 02325E54
	add r0,r4,#0x0	; 02325E58
	bl loc_023261D4	; 02325E5A
	add r0,r4,#0x0	; 02325E5E
	add r0,#0x3c	; 02325E60
	ldr r1,[pool_02325EA4]	; 02325E62
	mov r2,#0x5f	; 02325E64
	bl loc_02324BA0	; 02325E66
	ldr r1,[r4,#0x38]	; 02325E6A
	mov r0,#0x8	; 02325E6C
	orr r1,r0	; 02325E6E
	str r1,[r4,#0x38]	; 02325E70
	ldr r1,[r4,#0x38]	; 02325E72
	mov r0,#0x4	; 02325E74
	orr r1,r0	; 02325E76
	str r1,[r4,#0x38]	; 02325E78
	mov r0,#0x0	; 02325E7A
	str r0,[r4,#0x0]	; 02325E7C
	str r0,[r4,#0x4]	; 02325E7E
	mov r0,#0x6	; 02325E80
	str r0,[r4,#0x30]	; 02325E82
	mov r0,#0x27	; 02325E84
	add r4,#0x2c	; 02325E86
	add r1,r4,#0x0	; 02325E88
	bl loc_0232370C	; 02325E8A
	mov r0,#0x2	; 02325E8E
	mov r1,#0x0	; 02325E90
	bl loc_02326984	; 02325E92
	bl loc_023266CC	; 02325E96
loc_02325E9A:
	pop {r4}	; 02325E9A
	pop {r3}	; 02325E9C
	bx r3	; 02325E9E
pool_02325EA0:
loc_02325EA0:
	.word 0x00000CFF	; 02325EA0
pool_02325EA4:
loc_02325EA4:
	.word 0x023A5BC4	; 02325EA4

; ===== function loc_02325EA8 =====
loc_02325EA8:
	push {r4,lr}	; 02325EA8
	sub sp,#0x8	; 02325EAA
	add r4,r0,#0x0	; 02325EAC
	bl loc_02325308	; 02325EAE
	cmp r0,#0x0	; 02325EB2
	beq loc_02325F1E	; 02325EB4
	ldr r0,[r4,#0x0]	; 02325EB6
	cmp r0,#0x0	; 02325EB8
	bne loc_02325EDA	; 02325EBA
	mov r1,#0x10	; 02325EBC
	str r1,[sp,#0x0]	; 02325EBE
	ldr r0,[pool_02325F28]	; 02325EC0
	ldr r2,[r4,#0xc]	; 02325EC2
	mov r3,#0x0	; 02325EC4
	bl loc_0232D968	; 02325EC6
	ldr r1,[r4,#0x38]	; 02325ECA
	mov r0,#0x2	; 02325ECC
	orr r1,r0	; 02325ECE
	str r1,[r4,#0x38]	; 02325ED0
	ldr r0,[r4,#0x0]	; 02325ED2
	add r0,r0,#0x1	; 02325ED4
	str r0,[r4,#0x0]	; 02325ED6
	b loc_02325F1E	; 02325ED8
loc_02325EDA:
	cmp r0,#0xf	; 02325EDA
	bgt loc_02325EFA	; 02325EDC
	lsl r0,r0,#0x4	; 02325EDE
	mov r1,#0xf	; 02325EE0
	blx P1_SignedDivMod	; 02325EE2
	mov r1,#0x10	; 02325EE6
	sub r1,r1,r0	; 02325EE8
	lsl r1,r1,#0x8	; 02325EEA
	orr r0,r1	; 02325EEC
	ldr r1,[pool_02325F2C]	; 02325EEE
	strh r0,[r1,#0x0]	; 02325EF0
	ldr r0,[r4,#0x0]	; 02325EF2
	add r0,r0,#0x1	; 02325EF4
	str r0,[r4,#0x0]	; 02325EF6
	b loc_02325F1E	; 02325EF8
loc_02325EFA:
	mov r0,#0x0	; 02325EFA
	str r0,[r4,#0x0]	; 02325EFC
	ldr r1,[r4,#0x38]	; 02325EFE
	lsl r0,r1,#0x1d	; 02325F00
	lsr r0,r0,#0x1f	; 02325F02
	cmp r0,#0x0	; 02325F04
	beq loc_02325F14	; 02325F06
	mov r0,#0x8	; 02325F08
	bic r1,r0	; 02325F0A
	str r1,[r4,#0x38]	; 02325F0C
	mov r0,#0x6	; 02325F0E
	str r0,[r4,#0x30]	; 02325F10
	b loc_02325F1E	; 02325F12
loc_02325F14:
	add r0,r4,#0x0	; 02325F14
	bl loc_0232666C	; 02325F16
	mov r0,#0x5	; 02325F1A
	str r0,[r4,#0x30]	; 02325F1C
loc_02325F1E:
	add sp,#0x8	; 02325F1E
	pop {r4}	; 02325F20
	pop {r3}	; 02325F22
	bx r3	; 02325F24
	.byte 0xC0, 0x46	; 02325F28
pool_02325F28:
loc_02325F28:
	.word REG_BLDCNT_SUB	; 02325F28
pool_02325F2C:
loc_02325F2C:
	.word REG_BLDALPHA_SUB	; 02325F2C

; ===== function loc_02325F30 =====
loc_02325F30:
	push {r4,lr}	; 02325F30
	sub sp,#0x8	; 02325F32
	add r4,r0,#0x0	; 02325F34
	ldr r0,[r4,#0x0]	; 02325F36
	cmp r0,#0x0	; 02325F38
	bne loc_02325F68	; 02325F3A
	ldr r2,[pool_02325F98]	; 02325F3C
	ldr r3,[r2,#0x0]	; 02325F3E
	ldr r0,[pool_02325F9C]	; 02325F40
	and r3,r0	; 02325F42
	ldr r1,[r4,#0x8]	; 02325F44
	ldr r0,[r4,#0xc]	; 02325F46
	orr r1,r0	; 02325F48
	lsl r0,r1,#0x8	; 02325F4A
	orr r3,r0	; 02325F4C
	str r3,[r2,#0x0]	; 02325F4E
	mov r0,#0x10	; 02325F50
	str r0,[sp,#0x0]	; 02325F52
	ldr r0,[pool_02325FA0]	; 02325F54
	ldr r1,[r4,#0xc]	; 02325F56
	ldr r2,[r4,#0x8]	; 02325F58
	mov r3,#0x0	; 02325F5A
	bl loc_0232D968	; 02325F5C
	ldr r0,[r4,#0x0]	; 02325F60
	add r0,r0,#0x1	; 02325F62
	str r0,[r4,#0x0]	; 02325F64
	b loc_02325F90	; 02325F66
loc_02325F68:
	cmp r0,#0xf	; 02325F68
	bgt loc_02325F88	; 02325F6A
	lsl r0,r0,#0x4	; 02325F6C
	mov r1,#0xf	; 02325F6E
	blx P1_SignedDivMod	; 02325F70
	mov r1,#0x10	; 02325F74
	sub r1,r1,r0	; 02325F76
	lsl r1,r1,#0x8	; 02325F78
	orr r0,r1	; 02325F7A
	ldr r1,[pool_02325FA4]	; 02325F7C
	strh r0,[r1,#0x0]	; 02325F7E
	ldr r0,[r4,#0x0]	; 02325F80
	add r0,r0,#0x1	; 02325F82
	str r0,[r4,#0x0]	; 02325F84
	b loc_02325F90	; 02325F86
loc_02325F88:
	mov r0,#0x0	; 02325F88
	str r0,[r4,#0x0]	; 02325F8A
	mov r0,#0x4	; 02325F8C
	str r0,[r4,#0x30]	; 02325F8E
loc_02325F90:
	add sp,#0x8	; 02325F90
	pop {r4}	; 02325F92
	pop {r3}	; 02325F94
	bx r3	; 02325F96
pool_02325F98:
loc_02325F98:
	.word REG_DISPCNT_B	; 02325F98
pool_02325F9C:
loc_02325F9C:
	.word 0xFFFFE0FF	; 02325F9C
pool_02325FA0:
loc_02325FA0:
	.word REG_BLDCNT_SUB	; 02325FA0
pool_02325FA4:
loc_02325FA4:
	.word REG_BLDALPHA_SUB	; 02325FA4

; ===== function loc_02325FA8 =====
loc_02325FA8:
	push {r4,lr}	; 02325FA8
	add r4,r1,#0x0	; 02325FAA
	bl loc_0232505C	; 02325FAC
	cmp r0,#0x0	; 02325FB0
	bne loc_02325FBE	; 02325FB2
	mov r0,#0x0	; 02325FB4
	str r0,[r4,#0x30]	; 02325FB6
	mov r0,#0x3	; 02325FB8
	str r0,[r4,#0x34]	; 02325FBA
	b loc_0232600A	; 02325FBC
loc_02325FBE:
	bl loc_02325070	; 02325FBE
	cmp r0,#0x0	; 02325FC2
	bne loc_0232600A	; 02325FC4
	mov r0,#0x0	; 02325FC6
	bl loc_023253F4	; 02325FC8
	cmp r0,#0x0	; 02325FCC
	beq loc_02325FEA	; 02325FCE
	mov r0,#0x1a	; 02325FD0
	bl loc_02323724	; 02325FD2
	ldr r1,[r4,#0x38]	; 02325FD6
	mov r0,#0x1	; 02325FD8
	bic r1,r0	; 02325FDA
	orr r1,r0	; 02325FDC
	str r1,[r4,#0x38]	; 02325FDE
	bl loc_0232507C	; 02325FE0
	bl loc_02326944	; 02325FE4
	b loc_0232600A	; 02325FE8
loc_02325FEA:
	mov r0,#0x1	; 02325FEA
	bl loc_023253F4	; 02325FEC
	cmp r0,#0x0	; 02325FF0
	beq loc_0232600A	; 02325FF2
	mov r0,#0x20	; 02325FF4
	bl loc_02323724	; 02325FF6
	ldr r1,[r4,#0x38]	; 02325FFA
	mov r0,#0x1	; 02325FFC
	bic r1,r0	; 02325FFE
	str r1,[r4,#0x38]	; 02326000
	bl loc_0232507C	; 02326002
	bl loc_02326954	; 02326006
loc_0232600A:
	pop {r4}	; 0232600A
	pop {r3}	; 0232600C
	bx r3	; 0232600E

; ===== function loc_02326010 =====
loc_02326010:
	push {r4,r5,lr}	; 02326010
	sub sp,#0x4	; 02326012
	add r5,r1,#0x0	; 02326014
	mov r4,#0x0	; 02326016
	bl loc_0232505C	; 02326018
	cmp r0,#0x0	; 0232601C
	bne loc_02326038	; 0232601E
	ldr r0,[r5,#0x38]	; 02326020
	lsl r0,r0,#0x1a	; 02326022
	lsr r4,r0,#0x1f	; 02326024
	add r0,r5,#0x0	; 02326026
	add r0,#0x3c	; 02326028
	ldr r1,[pool_02326090]	; 0232602A
	mov r2,#0x5e	; 0232602C
	bl loc_02324BA0	; 0232602E
	mov r0,#0x0	; 02326032
	str r0,[r5,#0x30]	; 02326034
	b loc_02326086	; 02326036
loc_02326038:
	bl loc_02325070	; 02326038
	cmp r0,#0x0	; 0232603C
	bne loc_02326086	; 0232603E
	lsl r0,r4,#0	; 02326040
	bl loc_023253F4	; 02326042
	cmp r0,#0x0	; 02326046
	beq loc_0232606A	; 02326048
	mov r0,#0x1b	; 0232604A
	bl loc_02323724	; 0232604C
	bl loc_0232507C	; 02326050
	mov r0,#0x1	; 02326054
	bl loc_0232C744	; 02326056
	cmp r0,#0x0	; 0232605A
	beq loc_02326064	; 0232605C
	mov r0,#0x2	; 0232605E
	str r0,[r5,#0x34]	; 02326060
	b loc_02326086	; 02326062
loc_02326064:
	mov r0,#0x3	; 02326064
	str r0,[r5,#0x34]	; 02326066
	b loc_02326086	; 02326068
loc_0232606A:
	mov r0,#0x1	; 0232606A
	bl loc_023253F4	; 0232606C
	cmp r0,#0x0	; 02326070
	beq loc_02326086	; 02326072
	mov r0,#0x20	; 02326074
	bl loc_02323724	; 02326076
	ldr r1,[r5,#0x38]	; 0232607A
	mov r0,#0x20	; 0232607C
	orr r1,r0	; 0232607E
	str r1,[r5,#0x38]	; 02326080
	bl loc_0232507C	; 02326082
loc_02326086:
	add r0,r4,#0x0	; 02326086
	add sp,#0x4	; 02326088
	pop {r4,r5}	; 0232608A
	pop {r3}	; 0232608C
	bx r3	; 0232608E
pool_02326090:
loc_02326090:
	.word 0x023A5BC4	; 02326090

; ===== function loc_02326094 =====
loc_02326094:
	ldr r3,[pool_023260B0]	; 02326094
	str r3,[r0,#0x10]	; 02326096
	str r1,[r0,#0x8]	; 02326098
	str r2,[r0,#0xc]	; 0232609A
	ldr r2,[r0,#0x38]	; 0232609C
	mov r1,#0x10	; 0232609E
	orr r2,r1	; 023260A0
	str r2,[r0,#0x38]	; 023260A2
	mov r1,#0x0	; 023260A4
	str r1,[r0,#0x0]	; 023260A6
	str r1,[r0,#0x4]	; 023260A8
	add r0,#0x2c	; 023260AA
	ldr r3,[pool_023260B4]	; 023260AC
	bx r3	; 023260AE
pool_023260B0:
loc_023260B0:
	.word 0x027FFCD2	; 023260B0
pool_023260B4:
loc_023260B4:
	.word loc_0232371C + 1	; 023260B4

; ===== function loc_023260B8 =====
loc_023260B8:
	push {r4,r5,r6,r7,lr}	; 023260B8
	sub sp,#0x1fc	; 023260BA
	sub sp,#0x10	; 023260BC
	add r5,r0,#0x0	; 023260BE
	ldr r1,[r5,#0x38]	; 023260C0
	lsl r0,r1,#0x1d	; 023260C2
	lsr r0,r0,#0x1f	; 023260C4
	cmp r0,#0x0	; 023260C6
	beq loc_02326168	; 023260C8
	ldr r0,[r5,#0x1c]	; 023260CA
	cmp r0,#0x0	; 023260CC
	bne loc_02326162	; 023260CE
	lsl r0,r1,#0x1b	; 023260D0
	lsr r0,r0,#0x1f	; 023260D2
	cmp r0,#0x0	; 023260D4
	bne loc_02326168	; 023260D6
	add r0,sp,#0x8	; 023260D8
	ldr r1,[pool_02326174]	; 023260DA
	bl loc_0232D1D0	; 023260DC
	mov r0,#0x60	; 023260E0
	bl loc_02324DE0	; 023260E2
	add r7,r0,#0x0	; 023260E6
	mov r6,#0x0	; 023260E8
	ldr r2,[r5,#0x10]	; 023260EA
	ldrb r1,[r2,#0x0]	; 023260EC
	ldr r0,[r5,#0x14]	; 023260EE
	ldr r3,[r5,#0x18]	; 023260F0
	ldrb r2,[r2,#0x1]	; 023260F2
	sub r4,r3,r2	; 023260F4
	sub r3,r0,r1	; 023260F6
	mov r2,#0x3c	; 023260F8
	mul r3,r2	; 023260FA
	add r4,r4,r3	; 023260FC
	cmp r0,r1	; 023260FE
	bcs loc_02326106	; 02326100
	ldr r0,[pool_02326178]	; 02326102
	add r4,r4,r0	; 02326104
loc_02326106:
	add r0,r4,#0x0	; 02326106
	mov r1,#0x3c	; 02326108
	blx P1_SignedDivMod	; 0232610A
	add r1,r0,#0x0	; 0232610E
	add r0,sp,#0x0	; 02326110
	bl loc_02325A64	; 02326112
	add r0,r4,#0x0	; 02326116
	mov r1,#0x3c	; 02326118
	blx P1_SignedDivMod	; 0232611A
	add r0,sp,#0x4	; 0232611E
	bl loc_02325A64	; 02326120
	mov r2,#0x0	; 02326124
	add r4,sp,#0x8	; 02326126
	b loc_02326140	; 02326128
loc_0232612A:
	ldr r3,[pool_0232617C]	; 0232612A
	cmp r1,r3	; 0232612C
	bne loc_0232613C	; 0232612E
	lsl r3,r6,#0x1	; 02326130
	add r6,r6,#0x1	; 02326132
	add r1,sp,#0x0	; 02326134
	ldrh r1,[r1,r3]	; 02326136
	strh r1,[r4,r0]	; 02326138
	b loc_0232613E	; 0232613A
loc_0232613C:
	strh r1,[r4,r0]	; 0232613C
loc_0232613E:
	add r2,r2,#0x1	; 0232613E
loc_02326140:
	lsl r0,r2,#0x1	; 02326140
	ldrh r1,[r7,r0]	; 02326142
	cmp r1,#0x0	; 02326144
	beq loc_0232614E	; 02326146
	ldr r3,[pool_02326180]	; 02326148
	cmp r2,r3	; 0232614A
	blt loc_0232612A	; 0232614C
loc_0232614E:
	add r0,r5,#0x0	; 0232614E
	add r0,#0x3c	; 02326150
	add r1,sp,#0x8	; 02326152
	bl loc_02324B44	; 02326154
	ldr r1,[r5,#0x38]	; 02326158
	mov r0,#0x10	; 0232615A
	orr r1,r0	; 0232615C
	str r1,[r5,#0x38]	; 0232615E
	b loc_02326168	; 02326160
loc_02326162:
	mov r0,#0x10	; 02326162
	bic r1,r0	; 02326164
	str r1,[r5,#0x38]	; 02326166
loc_02326168:
	add sp,#0x1fc	; 02326168
	add sp,#0x10	; 0232616A
	pop {r4,r5,r6,r7}	; 0232616C
	pop {r3}	; 0232616E
	bx r3	; 02326170
	.byte 0xC0, 0x46	; 02326174
pool_02326174:
loc_02326174:
	.word 0x00000200	; 02326174
pool_02326178:
loc_02326178:
	.word 0x000005A0	; 02326178
pool_0232617C:
loc_0232617C:
	.word 0x000025CF	; 0232617C
pool_02326180:
loc_02326180:
	.word 0x00000100	; 02326180

; ===== function loc_02326184 =====
loc_02326184:
	push {lr}	; 02326184
	sub sp,#0x4	; 02326186
	ldr r2,[r0,#0x4]	; 02326188
	ldr r1,[pool_023261A0]	; 0232618A
	cmp r2,r1	; 0232618C
	ble loc_02326196	; 0232618E
	bl loc_023261A4	; 02326190
	b loc_0232619A	; 02326194
loc_02326196:
	add r1,r2,#0x1	; 02326196
	str r1,[r0,#0x4]	; 02326198
loc_0232619A:
	add sp,#0x4	; 0232619A
	pop {r3}	; 0232619C
	bx r3	; 0232619E
pool_023261A0:
loc_023261A0:
	.word 0x0000012C	; 023261A0

; ===== function loc_023261A4 =====
loc_023261A4:
	push {lr}	; 023261A4
	sub sp,#0x4	; 023261A6
	bl P1_GetFirmwareUiContext	; 023261A8
	ldr r0,[r0,#0x0]	; 023261AC
	lsl r0,r0,#0x15	; 023261AE
	lsr r0,r0,#0x1f	; 023261B0
	cmp r0,#0x0	; 023261B2
	beq loc_023261BE	; 023261B4
	mov r0,#0x2	; 023261B6
	mov r1,#0x0	; 023261B8
	bl loc_0232F200	; 023261BA
loc_023261BE:
	bl P1_GetFirmwareUiContext	; 023261BE
	ldr r2,[r0,#0x0]	; 023261C2
	ldr r1,[pool_023261D0]	; 023261C4
	and r2,r1	; 023261C6
	str r2,[r0,#0x0]	; 023261C8
	add sp,#0x4	; 023261CA
	pop {r3}	; 023261CC
	bx r3	; 023261CE
pool_023261D0:
loc_023261D0:
	.word 0xFFFFFBFF	; 023261D0

; ===== function loc_023261D4 =====
loc_023261D4:
	push {lr}	; 023261D4
	sub sp,#0x4	; 023261D6
	bl P1_GetFirmwareUiContext	; 023261D8
	ldr r0,[r0,#0x0]	; 023261DC
	lsl r0,r0,#0x16	; 023261DE
	lsr r0,r0,#0x1f	; 023261E0
	cmp r0,#0x0	; 023261E2
	beq loc_023261FC	; 023261E4
	bl P1_GetFirmwareUiContext	; 023261E6
	ldr r0,[r0,#0x0]	; 023261EA
	lsl r0,r0,#0x15	; 023261EC
	lsr r0,r0,#0x1f	; 023261EE
	cmp r0,#0x0	; 023261F0
	bne loc_023261FC	; 023261F2
	mov r0,#0x2	; 023261F4
	mov r1,#0x1	; 023261F6
	bl loc_0232F200	; 023261F8
loc_023261FC:
	bl P1_GetFirmwareUiContext	; 023261FC
	ldr r2,[r0,#0x0]	; 02326200
	ldr r1,[pool_02326210]	; 02326202
	orr r2,r1	; 02326204
	str r2,[r0,#0x0]	; 02326206
	add sp,#0x4	; 02326208
	pop {r3}	; 0232620A
	bx r3	; 0232620C
	.byte 0xC0, 0x46	; 02326210
pool_02326210:
loc_02326210:
	.word 0x00000400	; 02326210

; ===== function loc_02326214 =====
loc_02326214:
	push {r4,r5,r6,lr}	; 02326214
	add r4,r0,#0x0	; 02326216
	add r3,r1,#0x0	; 02326218
	add r6,r4,#0x0	; 0232621A
	add r6,#0x14	; 0232621C
	add r5,r4,#0x0	; 0232621E
	add r5,#0x20	; 02326220
	add r2,r5,#0x0	; 02326222
	ldmia r6!,{r0,r1}	; 02326224
	stmia r5!,{r0,r1}	; 02326226
	ldr r0,[r6,#0x0]	; 02326228
	str r0,[r5,#0x0]	; 0232622A
	ldr r0,[r4,#0x24]	; 0232622C
	add r0,r0,r3	; 0232622E
	cmp r0,#0x3c	; 02326230
	bcc loc_02326250	; 02326232
	ldr r0,[r4,#0x20]	; 02326234
	cmp r0,#0x17	; 02326236
	bne loc_02326240	; 02326238
	mov r0,#0x0	; 0232623A
	str r0,[r4,#0x20]	; 0232623C
	b loc_02326246	; 0232623E
loc_02326240:
	ldr r0,[r2,#0x0]	; 02326240
	add r0,r0,#0x1	; 02326242
	str r0,[r2,#0x0]	; 02326244
loc_02326246:
	ldr r0,[r4,#0x24]	; 02326246
	sub r3,#0x3c	; 02326248
	add r0,r0,r3	; 0232624A
	str r0,[r4,#0x24]	; 0232624C
	b loc_02326252	; 0232624E
loc_02326250:
	str r0,[r4,#0x24]	; 02326250
loc_02326252:
	pop {r4,r5,r6}	; 02326252
	pop {r3}	; 02326254
	bx r3	; 02326256

; ===== function loc_02326258 =====
loc_02326258:
	ldr r2,[r0,#0x20]	; 02326258
	ldr r1,[r0,#0x14]	; 0232625A
	cmp r2,r1	; 0232625C
	bne loc_02326274	; 0232625E
	ldr r2,[r0,#0x24]	; 02326260
	ldr r1,[r0,#0x18]	; 02326262
	cmp r2,r1	; 02326264
	bne loc_02326274	; 02326266
	ldr r1,[r0,#0x28]	; 02326268
	ldr r0,[r0,#0x1c]	; 0232626A
	cmp r1,r0	; 0232626C
	bne loc_02326274	; 0232626E
	mov r0,#0x1	; 02326270
	bx lr	; 02326272
loc_02326274:
	mov r0,#0x0	; 02326274
	bx lr	; 02326276

; ===== function loc_02326278 =====
loc_02326278:
	push {lr}	; 02326278
	sub sp,#0x4	; 0232627A
	ldr r1,[pool_023262C0]	; 0232627C
	ldrh r1,[r1,#0x0]	; 0232627E
	lsl r1,r1,#0x1d	; 02326280
	lsr r1,r1,#0x1d	; 02326282
	cmp r1,#0x5	; 02326284
	bhi loc_023262A2	; 02326286
	add r1,r1,r1	; 02326288
P1_SwitchIndexPC_02326288:
	add r1,pc	; 0232628A
	ldrh r1,[r1,#(P1_SwitchTable_02326288 - (P1_SwitchIndexPC_02326288 + 4))]	; 0232628C
	lsl r1,r1,#0x10	; 0232628E
	asr r1,r1,#0x10	; 02326290
P1_SwitchTargetPC_02326288:
	add r1,pc	; 02326292
	bx r1	; 02326294
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02326288:
	.halfword (loc_023262A2 + 1) - (P1_SwitchTargetPC_02326288 + 4)
	.halfword (loc_023262A2 + 1) - (P1_SwitchTargetPC_02326288 + 4)
	.halfword (loc_023262B2 + 1) - (P1_SwitchTargetPC_02326288 + 4)
	.halfword (loc_023262AA + 1) - (P1_SwitchTargetPC_02326288 + 4)
	.halfword (loc_023262B2 + 1) - (P1_SwitchTargetPC_02326288 + 4)
	.halfword (loc_023262B2 + 1) - (P1_SwitchTargetPC_02326288 + 4)
P1_SwitchTable_02326288End:
loc_023262A2:
	ldr r1,[pool_023262C4]	; 023262A2
	bl P1_Utf16StrCpy	; 023262A4
	b loc_023262B8	; 023262A8
loc_023262AA:
	ldr r1,[pool_023262C8]	; 023262AA
	bl P1_Utf16StrCpy	; 023262AC
	b loc_023262B8	; 023262B0
loc_023262B2:
	ldr r1,[pool_023262CC]	; 023262B2
	bl P1_Utf16StrCpy	; 023262B4
loc_023262B8:
	add sp,#0x4	; 023262B8
	pop {r3}	; 023262BA
	bx r3	; 023262BC
	.byte 0xC0, 0x46	; 023262C0
pool_023262C0:
loc_023262C0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023262C0
pool_023262C4:
loc_023262C4:
	.word 0x02330870	; 023262C4
pool_023262C8:
loc_023262C8:
	.word 0x0233087C	; 023262C8
pool_023262CC:
loc_023262CC:
	.word 0x0233088C	; 023262CC

; ===== function loc_023262D0 =====
P1_Entry_023262D0:
	push {lr}	; 023262D0
	sub sp,#0x4	; 023262D2
	ldr r1,[pool_02326320]	; 023262D4
	ldrh r1,[r1,#0x0]	; 023262D6
	lsl r1,r1,#0x1d	; 023262D8
	lsr r1,r1,#0x1d	; 023262DA
	cmp r1,#0x5	; 023262DC
	bhi loc_023262FA	; 023262DE
	add r1,r1,r1	; 023262E0
P1_SwitchIndexPC_023262E0:
	add r1,pc	; 023262E2
	ldrh r1,[r1,#(P1_SwitchTable_023262E0 - (P1_SwitchIndexPC_023262E0 + 4))]	; 023262E4
	lsl r1,r1,#0x10	; 023262E6
	asr r1,r1,#0x10	; 023262E8
P1_SwitchTargetPC_023262E0:
	add r1,pc	; 023262EA
	bx r1	; 023262EC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023262E0:
	.halfword (loc_023262FA + 1) - (P1_SwitchTargetPC_023262E0 + 4)
	.halfword (loc_02326302 + 1) - (P1_SwitchTargetPC_023262E0 + 4)
	.halfword (loc_02326312 + 1) - (P1_SwitchTargetPC_023262E0 + 4)
	.halfword (loc_0232630A + 1) - (P1_SwitchTargetPC_023262E0 + 4)
	.halfword (loc_02326312 + 1) - (P1_SwitchTargetPC_023262E0 + 4)
	.halfword (loc_02326312 + 1) - (P1_SwitchTargetPC_023262E0 + 4)
P1_SwitchTable_023262E0End:
loc_023262FA:
	ldr r1,[pool_02326324]	; 023262FA
	bl P1_Utf16StrCpy	; 023262FC
	b loc_02326318	; 02326300
loc_02326302:
	ldr r1,[pool_02326328]	; 02326302
	bl P1_Utf16StrCpy	; 02326304
	b loc_02326318	; 02326308
loc_0232630A:
	ldr r1,[pool_0232632C]	; 0232630A
	bl P1_Utf16StrCpy	; 0232630C
	b loc_02326318	; 02326310
loc_02326312:
	ldr r1,[pool_02326330]	; 02326312
	bl P1_Utf16StrCpy	; 02326314
loc_02326318:
	add sp,#0x4	; 02326318
	pop {r3}	; 0232631A
	bx r3	; 0232631C
	.byte 0xC0, 0x46	; 02326320
pool_02326320:
loc_02326320:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02326320
pool_02326324:
loc_02326324:
	.word 0x02330898	; 02326324
pool_02326328:
loc_02326328:
	.word 0x023308B0	; 02326328
pool_0232632C:
loc_0232632C:
	.word 0x023308C8	; 0232632C
pool_02326330:
loc_02326330:
	.word 0x023308E0	; 02326330

; ===== function loc_02326334 =====
loc_02326334:
	push {r4,r5,r6,lr}	; 02326334
	sub sp,#0x18	; 02326336
	add r5,r0,#0x0	; 02326338
	add r4,r2,#0x0	; 0232633A
	add r6,r3,#0x0	; 0232633C
	add r0,sp,#0x10	; 0232633E
	bl loc_02325A64	; 02326340
	add r0,sp,#0x8	; 02326344
	add r1,r4,#0x0	; 02326346
	bl loc_02325A64	; 02326348
	add r0,sp,#0x0	; 0232634C
	add r1,r6,#0x0	; 0232634E
	bl loc_02325A64	; 02326350
	add r0,r5,#0x0	; 02326354
	mov r1,#0x59	; 02326356
	bl P1_Utf16StrChr	; 02326358
	cmp r0,#0x0	; 0232635C
	beq loc_02326368	; 0232635E
	add r1,sp,#0x10	; 02326360
	mov r2,#0x2	; 02326362
	bl P1_Utf16StrNCpy	; 02326364
loc_02326368:
	add r0,r5,#0x0	; 02326368
	mov r1,#0x4d	; 0232636A
	bl P1_Utf16StrChr	; 0232636C
	cmp r0,#0x0	; 02326370
	beq loc_0232637C	; 02326372
	add r1,sp,#0x8	; 02326374
	mov r2,#0x2	; 02326376
	bl P1_Utf16StrNCpy	; 02326378
loc_0232637C:
	add r0,r5,#0x0	; 0232637C
	mov r1,#0x44	; 0232637E
	bl P1_Utf16StrChr	; 02326380
	cmp r0,#0x0	; 02326384
	beq loc_02326390	; 02326386
	add r1,sp,#0x0	; 02326388
	mov r2,#0x2	; 0232638A
	bl P1_Utf16StrNCpy	; 0232638C
loc_02326390:
	add sp,#0x18	; 02326390
	pop {r4,r5,r6}	; 02326392
	pop {r3}	; 02326394
	bx r3	; 02326396

; ===== function loc_02326398 =====
P1_Entry_02326398:
	push {r4,lr}	; 02326398
	add r4,r0,#0x0	; 0232639A
	bl loc_02326278	; 0232639C
	add r0,r4,#0x0	; 023263A0
	mov r1,#0x0	; 023263A2
	ldr r3,[pool_023263B4]	; 023263A4
	ldrb r2,[r3,#0x0]	; 023263A6
	ldrb r3,[r3,#0x1]	; 023263A8
	bl loc_02326334	; 023263AA
	pop {r4}	; 023263AE
	pop {r3}	; 023263B0
	bx r3	; 023263B2
pool_023263B4:
loc_023263B4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 023263B4

; ===== function loc_023263B8 =====
loc_023263B8:
	push {r4,lr}	; 023263B8
	sub sp,#0x10	; 023263BA
	add r4,r0,#0x0	; 023263BC
	add r0,sp,#0x0	; 023263BE
	bl loc_02326A64	; 023263C0
	add r0,r4,#0x0	; 023263C4
	bl loc_02326278	; 023263C6
	add r0,r4,#0x0	; 023263CA
	mov r1,#0x0	; 023263CC
	ldr r2,[sp,#0x4]	; 023263CE
	ldr r3,[sp,#0x8]	; 023263D0
	bl loc_02326334	; 023263D2
	add sp,#0x10	; 023263D6
	pop {r4}	; 023263D8
	pop {r3}	; 023263DA
	bx r3	; 023263DC
	.byte 0x00, 0x00	; 023263DE
P1_Entry_023263E0:
	push {r4,lr}	; 023263E0
	sub sp,#0x10	; 023263E2
	add r4,r0,#0x0	; 023263E4
	add r0,sp,#0x0	; 023263E6
	bl loc_02326A64	; 023263E8
	add r0,r4,#0x0	; 023263EC
	bl P1_Entry_023262D0	; 023263EE
	add r0,r4,#0x0	; 023263F2
	ldr r1,[sp,#0x0]	; 023263F4
	ldr r2,[sp,#0x4]	; 023263F6
	ldr r3,[sp,#0x8]	; 023263F8
	bl loc_02326334	; 023263FA
	add sp,#0x10	; 023263FE
	pop {r4}	; 02326400
	pop {r3}	; 02326402
	bx r3	; 02326404
	.byte 0x00, 0x00	; 02326406

; ===== function loc_02326408 =====
loc_02326408:
	push {r4,lr}	; 02326408
	sub sp,#0x10	; 0232640A
	add r4,r0,#0x0	; 0232640C
	add r0,sp,#0x0	; 0232640E
	bl loc_02326A80	; 02326410
	add r0,r4,#0x0	; 02326414
	ldr r1,[sp,#0x0]	; 02326416
	bl loc_02325A64	; 02326418
	mov r1,#0x3a	; 0232641C
	strh r1,[r0,#0x0]	; 0232641E
	add r0,r0,#0x2	; 02326420
	ldr r1,[sp,#0x4]	; 02326422
	bl loc_02325A64	; 02326424
	add sp,#0x10	; 02326428
	pop {r4}	; 0232642A
	pop {r3}	; 0232642C
	bx r3	; 0232642E
P1_Entry_02326430:
	ldr r0,[pool_02326440]	; 02326430
	ldrb r0,[r0,#0x0]	; 02326432
	lsl r0,r0,#0x1c	; 02326434
	lsr r0,r0,#0x1c	; 02326436
	cmp r0,#0x10	; 02326438
	blt P1_Entry_0232643E	; 0232643A
	mov r0,#0x1	; 0232643C
P1_Entry_0232643E:
	bx lr	; 0232643E
pool_02326440:
	.word FirmwareUserSettingsSharedAddress + UserSettingsThemeOffset	; 02326440
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x48, 0x09, 0x49, 0x02, 0x1C, 0x34, 0x32, 0x12, 0x78, 0x52, 0x00	; 02326444
	.byte 0x07, 0xF0, 0xEC, 0xEC, 0x00, 0x22, 0x04, 0x48, 0x34, 0x30, 0x00, 0x78, 0x41, 0x00, 0x03, 0x48	; 02326454
	.byte 0x42, 0x52, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x9C, 0xFC, 0x7F, 0x02, 0xB0, 0x4C, 0x35, 0x02	; 02326464

; ===== function loc_02326474 =====
loc_02326474:
	push {lr}	; 02326474
	sub sp,#0x4	; 02326476
	ldr r0,[pool_02326498]	; 02326478
	ldr r1,[pool_0232649C]	; 0232647A
	ldrb r2,[r0,#0x14]	; 0232647C
	lsl r2,r2,#0x1	; 0232647E
	blx loc_0232DE30	; 02326480
	mov r2,#0x0	; 02326484
	ldr r0,[pool_02326498]	; 02326486
	ldrb r0,[r0,#0x14]	; 02326488
	lsl r1,r0,#0x1	; 0232648A
	ldr r0,[pool_0232649C]	; 0232648C
	strh r2,[r0,r1]	; 0232648E
	add sp,#0x4	; 02326490
	pop {r3}	; 02326492
	bx r3	; 02326494
	.byte 0xC0, 0x46	; 02326498
pool_02326498:
loc_02326498:
	.word FirmwareUserSettingsSharedAddress + UserSettingsNameOffset	; 02326498
pool_0232649C:
loc_0232649C:
	.word P1_BssStart + 0x24218	; 0232649C

; ===== function loc_023264A0 =====
loc_023264A0:
	push {r4,r5,r6,r7,lr}	; 023264A0
	sub sp,#0x14	; 023264A2
	add r6,r0,#0x0	; 023264A4
	add r7,r1,#0x0	; 023264A6
	add r5,r2,#0x0	; 023264A8
	bl loc_02323E84	; 023264AA
	str r0,[sp,#0x0]	; 023264AE
	mov r4,#0x0	; 023264B0
	str r4,[sp,#0x4]	; 023264B2
loc_023264B4:
	lsl r1,r4,#0x3	; 023264B4
	ldr r0,[pool_0232651C]	; 023264B6
	add r1,r0,r1	; 023264B8
	ldr r0,[pool_02326520]	; 023264BA
	ldr r0,[r1,r0]	; 023264BC
	ldr r2,[pool_02326524]	; 023264BE
	ldr r1,[r1,r2]	; 023264C0
	str r0,[sp,#0x8]	; 023264C2
	str r1,[sp,#0xc]	; 023264C4
	add r0,sp,#0x8	; 023264C6
	ldr r2,[r0,#0x0]	; 023264C8
	add r0,r2,#0x0	; 023264CA
	ldr r1,[pool_02326528]	; 023264CC
	and r0,r1	; 023264CE
	lsl r1,r2,#0x7	; 023264D0
	lsr r1,r1,#0x17	; 023264D2
	add r2,r1,r6	; 023264D4
	ldr r1,[pool_0232652C]	; 023264D6
	and r2,r1	; 023264D8
	lsl r1,r2,#0x10	; 023264DA
	orr r0,r1	; 023264DC
	add r1,sp,#0x8	; 023264DE
	str r0,[r1,#0x0]	; 023264E0
	add r0,sp,#0x8	; 023264E2
	ldrb r0,[r0,#0x0]	; 023264E4
	add r1,r0,r7	; 023264E6
	add r0,sp,#0x8	; 023264E8
	strb r1,[r0,#0x0]	; 023264EA
	cmp r5,#0x0	; 023264EC
	blt loc_02326502	; 023264EE
	ldr r0,[sp,#0xc]	; 023264F0
	ldr r1,[pool_02326530]	; 023264F2
	and r0,r1	; 023264F4
	add r2,r5,#0x0	; 023264F6
	mov r1,#0xf	; 023264F8
	and r2,r1	; 023264FA
	lsl r1,r2,#0xc	; 023264FC
	orr r0,r1	; 023264FE
	str r0,[sp,#0xc]	; 02326500
loc_02326502:
	ldr r0,[sp,#0x0]	; 02326502
	add r1,sp,#0x8	; 02326504
	ldr r2,[sp,#0x4]	; 02326506
	bl loc_023239A0	; 02326508
	add r4,r4,#0x1	; 0232650C
	cmp r4,#0x1a	; 0232650E
	blt loc_023264B4	; 02326510
	add sp,#0x14	; 02326512
	pop {r4,r5,r6,r7}	; 02326514
	pop {r3}	; 02326516
	bx r3	; 02326518
	.byte 0xC0, 0x46	; 0232651C
pool_0232651C:
loc_0232651C:
	.word 0x02354CE8	; 0232651C
pool_02326520:
loc_02326520:
	.word 0x00000AA0	; 02326520
pool_02326524:
loc_02326524:
	.word 0x00000AA4	; 02326524
pool_02326528:
loc_02326528:
	.word 0xFE00FFFF	; 02326528
pool_0232652C:
loc_0232652C:
	.word 0x000001FF	; 0232652C
pool_02326530:
loc_02326530:
	.word 0xFFFF0FFF	; 02326530

; ===== function loc_02326534 =====
loc_02326534:
	push {r4,r5,r6,r7,lr}	; 02326534
	sub sp,#0x4	; 02326536
	ldr r0,[pool_023265BC]	; 02326538
	ldr r1,[pool_023265C0]	; 0232653A
	mov r2,#0x8	; 0232653C
	ldr r3,[pool_023265C4]	; 0232653E
	bl loc_0232864C	; 02326540
	ldr r0,[pool_023265C0]	; 02326544
	ldr r1,[pool_023265C8]	; 02326546
	blx P1_CleanDataCacheRange	; 02326548
	mov r5,#0x0	; 0232654C
	ldr r4,[pool_023265C0]	; 0232654E
	mov r7,#0x20	; 02326550
	ldr r6,[pool_023265CC]	; 02326552
loc_02326554:
	lsl r0,r5,#0x5	; 02326554
	add r0,r4,r0	; 02326556
	lsl r1,r5,#0x7	; 02326558
	add r1,r1,r6	; 0232655A
	add r2,r7,#0x0	; 0232655C
	bl loc_0232DC30	; 0232655E
	add r5,r5,#0x1	; 02326562
	cmp r5,#0x1a	; 02326564
	blt loc_02326554	; 02326566
	ldr r0,[pool_023265D0]	; 02326568
	ldr r1,[pool_023265D4]	; 0232656A
	mov r2,#0x2	; 0232656C
	bl loc_0232DCD0	; 0232656E
	mov r2,#0x0	; 02326572
	str r2,[sp,#0x0]	; 02326574
loc_02326576:
	ldr r5,[sp,#0x0]	; 02326576
	lsl r4,r2,#0x3	; 02326578
	mov r0,#0xff	; 0232657A
	and r4,r0	; 0232657C
	add r7,r2,#0x0	; 0232657E
	mov r0,#0xd	; 02326580
	mul r7,r0	; 02326582
	lsl r1,r7,#0x3	; 02326584
	ldr r0,[pool_023265C0]	; 02326586
	add r3,r0,r1	; 02326588
loc_0232658A:
	lsl r6,r5,#0x3	; 0232658A
	add r1,r3,r6	; 0232658C
	ldr r0,[pool_023265D8]	; 0232658E
	and r6,r0	; 02326590
	lsl r6,r6,#0x10	; 02326592
	orr r6,r4	; 02326594
	ldr r0,[pool_023265DC]	; 02326596
	str r6,[r1,r0]	; 02326598
	add r6,r5,r7	; 0232659A
	ldr r0,[pool_023265C8]	; 0232659C
	add r0,r6,r0	; 0232659E
	ldr r6,[pool_023265E0]	; 023265A0
	orr r0,r6	; 023265A2
	ldr r6,[pool_023265E4]	; 023265A4
	strh r0,[r1,r6]	; 023265A6
	add r5,r5,#0x1	; 023265A8
	cmp r5,#0xd	; 023265AA
	blt loc_0232658A	; 023265AC
	add r2,r2,#0x1	; 023265AE
	cmp r2,#0x2	; 023265B0
	blt loc_02326576	; 023265B2
	add sp,#0x4	; 023265B4
	pop {r4,r5,r6,r7}	; 023265B6
	pop {r3}	; 023265B8
	bx r3	; 023265BA
pool_023265BC:
loc_023265BC:
	.word 0x027FFEC0	; 023265BC
pool_023265C0:
loc_023265C0:
	.word 0x02354CE8	; 023265C0
pool_023265C4:
loc_023265C4:
	.word 0x02355088	; 023265C4
pool_023265C8:
loc_023265C8:
	.word 0x000003A0	; 023265C8
pool_023265CC:
loc_023265CC:
	.word 0x0001D000	; 023265CC
pool_023265D0:
loc_023265D0:
	.word 0x023301A0	; 023265D0
pool_023265D4:
loc_023265D4:
	.word 0x000001F0	; 023265D4
pool_023265D8:
loc_023265D8:
	.word 0x000001FF	; 023265D8
pool_023265DC:
loc_023265DC:
	.word 0x00000AA0	; 023265DC
pool_023265E0:
loc_023265E0:
	.word 0x0000F000	; 023265E0
pool_023265E4:
loc_023265E4:
	.word 0x00000AA4	; 023265E4

; ===== function loc_023265E8 =====
loc_023265E8:
	ldr r1,[pool_023265F0]	; 023265E8
	str r0,[r1,#0x0]	; 023265EA
	bx lr	; 023265EC
	.byte 0xC0, 0x46	; 023265F0
pool_023265F0:
loc_023265F0:
	.word P1_BssStart + 0x24DE8	; 023265F0
	.byte 0x01, 0x49, 0x08, 0x60, 0x70, 0x47, 0xC0, 0x46, 0x64, 0x58, 0x35, 0x02, 0x01, 0x49, 0x08, 0x60	; 02326604
	.byte 0x70, 0x47, 0xC0, 0x46, 0x60, 0x58, 0x35, 0x02	; 0232660C

; ===== function loc_0232660C =====
loc_0232660C:
	push {lr}	; 0232660C
	sub sp,#0x4	; 0232660E
	ldr r0,[pool_0232663C]	; 02326610
	ldr r1,[r0,#0x0]	; 02326612
	mov r0,#0x1	; 02326614
	and r1,r0	; 02326616
	cmp r1,#0x1	; 02326618
	bne loc_02326636	; 0232661A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232661C
	ldr r2,[pool_0232663C]	; 02326620
	ldr r3,[r2,#0x0]	; 02326622
	mov r1,#0x1	; 02326624
	bic r3,r1	; 02326626
	str r3,[r2,#0x0]	; 02326628
	ldr r3,[r2,#0x0]	; 0232662A
	mov r1,#0x2	; 0232662C
	bic r3,r1	; 0232662E
	str r3,[r2,#0x0]	; 02326630
	blx P1_Arm9RestoreIrqMask	; 02326632
loc_02326636:
	add sp,#0x4	; 02326636
	pop {r3}	; 02326638
	bx r3	; 0232663A
pool_0232663C:
loc_0232663C:
	.word P1_BssStart + 0x24DD8	; 0232663C

; ===== function loc_02326640 =====
loc_02326640:
	push {lr}	; 02326640
	sub sp,#0x4	; 02326642
	ldr r0,[pool_02326668]	; 02326644
	ldr r1,[r0,#0x0]	; 02326646
	mov r0,#0x1	; 02326648
	and r1,r0	; 0232664A
	cmp r1,#0x1	; 0232664C
	bne loc_02326662	; 0232664E
	blx P1_Arm9DisableIrqReturnPriorMask	; 02326650
	ldr r2,[pool_02326668]	; 02326654
	ldr r3,[r2,#0x0]	; 02326656
	mov r1,#0x2	; 02326658
	bic r3,r1	; 0232665A
	str r3,[r2,#0x0]	; 0232665C
	blx P1_Arm9RestoreIrqMask	; 0232665E
loc_02326662:
	add sp,#0x4	; 02326662
	pop {r3}	; 02326664
	bx r3	; 02326666
pool_02326668:
loc_02326668:
	.word P1_BssStart + 0x24DD8	; 02326668

; ===== function loc_0232666C =====
loc_0232666C:
	push {lr}	; 0232666C
	sub sp,#0x4	; 0232666E
	ldr r2,[pool_023266BC]	; 02326670
	ldr r3,[r2,#0x0]	; 02326672
	mov r1,#0x10	; 02326674
	and r3,r1	; 02326676
	cmp r3,#0x10	; 02326678
	beq loc_023266B4	; 0232667A
	ldr r1,[r2,#0x0]	; 0232667C
	mov r3,#0x1	; 0232667E
	orr r1,r3	; 02326680
	str r1,[r2,#0x0]	; 02326682
	ldr r1,[r0,#0x10]	; 02326684
	ldrb r2,[r1,#0x0]	; 02326686
	ldr r1,[pool_023266C0]	; 02326688
	str r2,[r1,#0x4]	; 0232668A
	ldr r0,[r0,#0x10]	; 0232668C
	ldrb r0,[r0,#0x1]	; 0232668E
	str r0,[r1,#0x8]	; 02326690
	mov r0,#0x6	; 02326692
	str r0,[r1,#0xc]	; 02326694
	ldr r0,[pool_023266C4]	; 02326696
	str r3,[r0,#0x0]	; 02326698
	ldr r0,[pool_023266C8]	; 0232669A
	bl loc_0232FBF0	; 0232669C
	mov r0,#0x0	; 023266A0
	ldr r1,[pool_023266C4]	; 023266A2
	bl loc_0232FB58	; 023266A4
	mov r0,#0x0	; 023266A8
	ldr r1,[pool_023266C0]	; 023266AA
	bl loc_0232FAAC	; 023266AC
	mov r0,#0x1	; 023266B0
	b loc_023266B6	; 023266B2
loc_023266B4:
	mov r0,#0x0	; 023266B4
loc_023266B6:
	add sp,#0x4	; 023266B6
	pop {r3}	; 023266B8
	bx r3	; 023266BA
pool_023266BC:
loc_023266BC:
	.word P1_BssStart + 0x24DD8	; 023266BC
pool_023266C0:
loc_023266C0:
	.word P1_BssStart + 0x24DEC	; 023266C0
pool_023266C4:
loc_023266C4:
	.word P1_BssStart + 0x24DDC	; 023266C4
pool_023266C8:
loc_023266C8:
	.word 0x023266CD	; 023266C8

; ===== function loc_023266CC =====
loc_023266CC:
	ldr r1,[pool_023266E4]	; 023266CC
	ldr r2,[r1,#0x0]	; 023266CE
	mov r0,#0x1	; 023266D0
	and r2,r0	; 023266D2
	cmp r2,#0x1	; 023266D4
	bne loc_023266E0	; 023266D6
	ldr r2,[r1,#0x0]	; 023266D8
	mov r0,#0x2	; 023266DA
	orr r2,r0	; 023266DC
	str r2,[r1,#0x0]	; 023266DE
loc_023266E0:
	bx lr	; 023266E0
	.byte 0xC0, 0x46	; 023266E4
pool_023266E4:
loc_023266E4:
	.word P1_BssStart + 0x24DD8	; 023266E4

; ===== function loc_023266E8 =====
loc_023266E8:
	push {lr}	; 023266E8
	sub sp,#0x4	; 023266EA
	ldr r0,[pool_023268B4]	; 023266EC
	ldrh r1,[r0,#0x0]	; 023266EE
	ldr r0,[pool_023268B8]	; 023266F0
	and r1,r0	; 023266F2
	asr r0,r1,#0xf	; 023266F4
	ldr r1,[pool_023268BC]	; 023266F6
	ldr r2,[r1,#0x0]	; 023266F8
	ldr r1,[pool_023268C0]	; 023266FA
	and r2,r1	; 023266FC
	cmp r2,r1	; 023266FE
	bne loc_02326706	; 02326700
	mov r3,#0x1	; 02326702
	b loc_02326708	; 02326704
loc_02326706:
	mov r3,#0x0	; 02326706
loc_02326708:
	mvn r2,r0	; 02326708
	add r1,r0,#0x0	; 0232670A
	eor r1,r3	; 0232670C
	and r2,r1	; 0232670E
	cmp r2,#0x0	; 02326710
	beq loc_02326720	; 02326712
	ldr r2,[pool_023268BC]	; 02326714
	ldr r3,[r2,#0x0]	; 02326716
	ldr r1,[pool_023268C4]	; 02326718
	orr r3,r1	; 0232671A
	str r3,[r2,#0x0]	; 0232671C
	b loc_0232672A	; 0232671E
loc_02326720:
	ldr r2,[pool_023268BC]	; 02326720
	ldr r3,[r2,#0x0]	; 02326722
	ldr r1,[pool_023268C8]	; 02326724
	and r3,r1	; 02326726
	str r3,[r2,#0x0]	; 02326728
loc_0232672A:
	cmp r0,#0x0	; 0232672A
	beq loc_0232673A	; 0232672C
	ldr r1,[pool_023268BC]	; 0232672E
	ldr r2,[r1,#0x0]	; 02326730
	ldr r0,[pool_023268C0]	; 02326732
	orr r2,r0	; 02326734
	str r2,[r1,#0x0]	; 02326736
	b loc_02326744	; 02326738
loc_0232673A:
	ldr r1,[pool_023268BC]	; 0232673A
	ldr r2,[r1,#0x0]	; 0232673C
	ldr r0,[pool_023268CC]	; 0232673E
	and r2,r0	; 02326740
	str r2,[r1,#0x0]	; 02326742
loc_02326744:
	ldr r1,[pool_023268BC]	; 02326744
	ldr r2,[r1,#0x0]	; 02326746
	mov r0,#0x2	; 02326748
	and r2,r0	; 0232674A
	cmp r2,#0x2	; 0232674C
	beq loc_023267D8	; 0232674E
	ldr r0,[pool_023268B4]	; 02326750
	ldrh r2,[r0,#0x0]	; 02326752
	ldr r0,[pool_023268B8]	; 02326754
	and r2,r0	; 02326756
	asr r0,r2,#0xf	; 02326758
	cmp r0,#0x0	; 0232675A
	beq loc_023267D8	; 0232675C
	ldr r2,[r1,#0x0]	; 0232675E
	mov r0,#0x40	; 02326760
	orr r2,r0	; 02326762
	str r2,[r1,#0x0]	; 02326764
	bl loc_02329D48	; 02326766
	ldr r0,[pool_023268D0]	; 0232676A
	ldr r0,[r0,#0x0]	; 0232676C
	cmp r0,#0x0	; 0232676E
	beq loc_02326774	; 02326770
	blx r0	; 02326772
loc_02326774:
	bl loc_02327C14	; 02326774
	mov r0,#0x1	; 02326778
	add r1,r0,#0x0	; 0232677A
	blx loc_0232AFD8	; 0232677C
	bl loc_0232696C	; 02326780
	bl loc_0232D4BC	; 02326784
	ldr r2,[pool_023268D4]	; 02326788
	ldr r1,[r2,#0x0]	; 0232678A
	ldr r0,[pool_023268D8]	; 0232678C
	and r1,r0	; 0232678E
	str r1,[r2,#0x0]	; 02326790
	mov r0,#0x1	; 02326792
	add r1,r0,#0x0	; 02326794
	blx loc_0232AFD8	; 02326796
	ldr r0,[pool_023268BC]	; 0232679A
	ldr r1,[r0,#0x0]	; 0232679C
	mov r0,#0x1	; 0232679E
	and r1,r0	; 023267A0
	cmp r1,#0x1	; 023267A2
	bne loc_023267AA	; 023267A4
	mov r0,#0x2	; 023267A6
	b loc_023267AC	; 023267A8
loc_023267AA:
	mov r0,#0x0	; 023267AA
loc_023267AC:
	mov r1,#0x4	; 023267AC
	orr r0,r1	; 023267AE
	mov r1,#0x0	; 023267B0
	add r2,r1,#0x0	; 023267B2
	bl loc_0232F0C0	; 023267B4
	mov r0,#0x1	; 023267B8
	add r1,r0,#0x0	; 023267BA
	blx loc_0232AFD8	; 023267BC
	mov r0,#0x1	; 023267C0
	add r1,r0,#0x0	; 023267C2
	blx loc_0232AFD8	; 023267C4
	bl loc_0232D47C	; 023267C8
	ldr r2,[pool_023268D4]	; 023267CC
	ldr r1,[r2,#0x0]	; 023267CE
	ldr r0,[pool_023268DC]	; 023267D0
	orr r1,r0	; 023267D2
	str r1,[r2,#0x0]	; 023267D4
	b loc_0232680E	; 023267D6
loc_023267D8:
	bl P1_GetFirmwareUiContext	; 023267D8
	ldr r0,[r0,#0x0]	; 023267DC
	lsl r0,r0,#0x16	; 023267DE
	lsr r0,r0,#0x1f	; 023267E0
	cmp r0,#0x0	; 023267E2
	beq loc_0232680E	; 023267E4
	bl P1_GetFirmwareUiContext	; 023267E6
	ldr r0,[r0,#0x0]	; 023267EA
	lsl r0,r0,#0x15	; 023267EC
	lsr r0,r0,#0x1f	; 023267EE
	cmp r0,#0x0	; 023267F0
	beq loc_0232680E	; 023267F2
	ldr r0,[pool_023268B4]	; 023267F4
	ldrh r1,[r0,#0x0]	; 023267F6
	ldr r0,[pool_023268B8]	; 023267F8
	and r1,r0	; 023267FA
	asr r0,r1,#0xf	; 023267FC
	cmp r0,#0x0	; 023267FE
	beq loc_02326806	; 02326800
	mov r1,#0x0	; 02326802
	b loc_02326808	; 02326804
loc_02326806:
	mov r1,#0x1	; 02326806
loc_02326808:
	mov r0,#0x2	; 02326808
	bl loc_0232F200	; 0232680A
loc_0232680E:
	ldr r0,[pool_023268BC]	; 0232680E
	ldr r1,[r0,#0x0]	; 02326810
	mov r0,#0x40	; 02326812
	and r1,r0	; 02326814
	cmp r1,#0x40	; 02326816
	bne loc_02326862	; 02326818
	bl loc_02327C34	; 0232681A
	bl loc_02327C14	; 0232681E
	bl loc_02327C34	; 02326822
	cmp r0,#0x0	; 02326826
	bne loc_02326844	; 02326828
	ldr r0,[pool_023268E0]	; 0232682A
	ldr r0,[r0,#0x0]	; 0232682C
	mov r1,#0x1	; 0232682E
	and r0,r1	; 02326830
	cmp r0,#0x0	; 02326832
	bne loc_02326838	; 02326834
	mov r1,#0x0	; 02326836
loc_02326838:
	cmp r1,#0x0	; 02326838
	beq loc_02326848	; 0232683A
	bl loc_0232C6D8	; 0232683C
	cmp r0,#0x0	; 02326840
	beq loc_02326848	; 02326842
loc_02326844:
	bl loc_0232F1D0	; 02326844
loc_02326848:
	ldr r0,[pool_023268E4]	; 02326848
	ldr r0,[r0,#0x0]	; 0232684A
	cmp r0,#0x0	; 0232684C
	beq loc_02326852	; 0232684E
	blx r0	; 02326850
loc_02326852:
	bl loc_02329D40	; 02326852
	ldr r1,[pool_023268BC]	; 02326856
	ldr r2,[r1,#0x0]	; 02326858
	mov r0,#0x40	; 0232685A
	bic r2,r0	; 0232685C
	str r2,[r1,#0x0]	; 0232685E
	b loc_023268AE	; 02326860
loc_02326862:
	bl loc_02327C34	; 02326862
	cmp r0,#0x0	; 02326866
	bne loc_02326884	; 02326868
	ldr r0,[pool_023268E0]	; 0232686A
	ldr r0,[r0,#0x0]	; 0232686C
	mov r1,#0x1	; 0232686E
	and r0,r1	; 02326870
	cmp r0,#0x0	; 02326872
	bne loc_02326878	; 02326874
	mov r1,#0x0	; 02326876
loc_02326878:
	cmp r1,#0x0	; 02326878
	beq loc_02326898	; 0232687A
	bl loc_0232C6D8	; 0232687C
	cmp r0,#0x0	; 02326880
	beq loc_02326898	; 02326882
loc_02326884:
	bl loc_02329D48	; 02326884
	ldr r0,[pool_023268D0]	; 02326888
	ldr r0,[r0,#0x0]	; 0232688A
	cmp r0,#0x0	; 0232688C
	beq loc_02326892	; 0232688E
	blx r0	; 02326890
loc_02326892:
	bl loc_0232C538	; 02326892
	b loc_023268AE	; 02326896
loc_02326898:
	ldr r0,[pool_023268BC]	; 02326898
	ldr r1,[r0,#0x0]	; 0232689A
	ldr r0,[pool_023268C4]	; 0232689C
	and r1,r0	; 0232689E
	cmp r1,r0	; 023268A0
	bne loc_023268AE	; 023268A2
	ldr r0,[pool_023268E8]	; 023268A4
	ldr r0,[r0,#0x0]	; 023268A6
	cmp r0,#0x0	; 023268A8
	beq loc_023268AE	; 023268AA
	blx r0	; 023268AC
loc_023268AE:
	add sp,#0x4	; 023268AE
	pop {r3}	; 023268B0
	bx r3	; 023268B2
pool_023268B4:
loc_023268B4:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 023268B4
pool_023268B8:
loc_023268B8:
	.word 0x00008000	; 023268B8
pool_023268BC:
loc_023268BC:
	.word P1_BssStart + 0x24DD8	; 023268BC
pool_023268C0:
loc_023268C0:
	.word 0x00000200	; 023268C0
pool_023268C4:
loc_023268C4:
	.word 0x00000100	; 023268C4
pool_023268C8:
loc_023268C8:
	.word 0xFFFFFEFF	; 023268C8
pool_023268CC:
loc_023268CC:
	.word 0xFFFFFDFF	; 023268CC
pool_023268D0:
loc_023268D0:
	.word P1_BssStart + 0x24DE0	; 023268D0
pool_023268D4:
loc_023268D4:
	.word REG_DISPCNT_B	; 023268D4
pool_023268D8:
loc_023268D8:
	.word 0xFFFEFFFF	; 023268D8
pool_023268DC:
loc_023268DC:
	.word 0x00010000	; 023268DC
pool_023268E0:
loc_023268E0:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023268E0
pool_023268E4:
loc_023268E4:
	.word P1_BssStart + 0x24DE4	; 023268E4
pool_023268E8:
loc_023268E8:
	.word P1_BssStart + 0x24DE8	; 023268E8

; ===== function loc_023268EC =====
loc_023268EC:
	push {lr}	; 023268EC
	sub sp,#0x4	; 023268EE
	mov r0,#0x0	; 023268F0
	ldr r1,[pool_02326914]	; 023268F2
	str r0,[r1,#0x0]	; 023268F4
	ldr r1,[pool_02326918]	; 023268F6
	str r0,[r1,#0x0]	; 023268F8
	ldr r1,[pool_0232691C]	; 023268FA
	str r0,[r1,#0x0]	; 023268FC
	ldr r1,[pool_02326920]	; 023268FE
	str r0,[r1,#0x0]	; 02326900
	bl loc_0232FB58	; 02326902
	mov r0,#0x1	; 02326906
	ldr r1,[pool_02326920]	; 02326908
	bl loc_0232FB58	; 0232690A
	add sp,#0x4	; 0232690E
	pop {r3}	; 02326910
	bx r3	; 02326912
pool_02326914:
loc_02326914:
	.word P1_BssStart + 0x24DD8	; 02326914
pool_02326918:
loc_02326918:
	.word P1_BssStart + 0x24DE0	; 02326918
pool_0232691C:
loc_0232691C:
	.word P1_BssStart + 0x24DE4	; 0232691C
pool_02326920:
loc_02326920:
	.word P1_BssStart + 0x24DDC	; 02326920

; ===== function loc_02326924 =====
loc_02326924:
	push {lr}	; 02326924
	sub sp,#0x4	; 02326926
	bl loc_023266E8	; 02326928
	bl loc_023269D4	; 0232692C
	bl loc_023236A0	; 02326930
	bl P1_GetFirmwareUiContext	; 02326934
	ldr r1,[r0,#0x4]	; 02326938
	add r1,r1,#0x1	; 0232693A
	str r1,[r0,#0x4]	; 0232693C
	add sp,#0x4	; 0232693E
	pop {r3}	; 02326940
	bx r3	; 02326942

; ===== function loc_02326944 =====
loc_02326944:
	ldr r1,[pool_02326950]	; 02326944
	ldr r2,[r1,#0x0]	; 02326946
	mov r0,#0x2	; 02326948
	bic r2,r0	; 0232694A
	str r2,[r1,#0x0]	; 0232694C
	bx lr	; 0232694E
pool_02326950:
loc_02326950:
	.word P1_BssStart + 0x24DFC	; 02326950

; ===== function loc_02326954 =====
loc_02326954:
	ldr r1,[pool_02326964]	; 02326954
	ldr r2,[r1,#0x0]	; 02326956
	mov r0,#0x2	; 02326958
	orr r2,r0	; 0232695A
	str r2,[r1,#0x0]	; 0232695C
	mov r0,#0x0	; 0232695E
	ldr r3,[pool_02326968]	; 02326960
	bx r3	; 02326962
pool_02326964:
loc_02326964:
	.word P1_BssStart + 0x24DFC	; 02326964
pool_02326968:
loc_02326968:
	.word loc_023294AC + 1	; 02326968

; ===== function loc_0232696C =====
loc_0232696C:
	ldr r1,[pool_0232697C]	; 0232696C
	ldr r2,[r1,#0x0]	; 0232696E
	mov r0,#0x1	; 02326970
	bic r2,r0	; 02326972
	str r2,[r1,#0x0]	; 02326974
	mov r0,#0x0	; 02326976
	ldr r3,[pool_02326980]	; 02326978
	bx r3	; 0232697A
pool_0232697C:
loc_0232697C:
	.word P1_BssStart + 0x24DFC	; 0232697C
pool_02326980:
loc_02326980:
	.word loc_023294AC + 1	; 02326980

; ===== function loc_02326984 =====
loc_02326984:
	push {r4,lr}	; 02326984
	cmp r1,#0x0	; 02326986
	beq loc_02326992	; 02326988
	ldr r2,[pool_023269D0]	; 0232698A
	ldr r2,[r2,#0x8]	; 0232698C
	cmp r2,r0	; 0232698E
	bne loc_0232699E	; 02326990
loc_02326992:
	ldr r2,[pool_023269D0]	; 02326992
	ldr r3,[r2,#0x0]	; 02326994
	mov r2,#0x1	; 02326996
	and r3,r2	; 02326998
	cmp r3,#0x1	; 0232699A
	beq loc_023269AC	; 0232699C
loc_0232699E:
	mov r2,#0x0	; 0232699E
	ldr r3,[pool_023269D0]	; 023269A0
	str r2,[r3,#0x4]	; 023269A2
	ldr r4,[r3,#0x0]	; 023269A4
	mov r2,#0x1	; 023269A6
	orr r4,r2	; 023269A8
	str r4,[r3,#0x0]	; 023269AA
loc_023269AC:
	cmp r1,#0x0	; 023269AC
	beq loc_023269BC	; 023269AE
	ldr r2,[pool_023269D0]	; 023269B0
	ldr r3,[r2,#0x0]	; 023269B2
	mov r1,#0x4	; 023269B4
	orr r3,r1	; 023269B6
	str r3,[r2,#0x0]	; 023269B8
	b loc_023269C6	; 023269BA
loc_023269BC:
	ldr r2,[pool_023269D0]	; 023269BC
	ldr r3,[r2,#0x0]	; 023269BE
	mov r1,#0x4	; 023269C0
	bic r3,r1	; 023269C2
	str r3,[r2,#0x0]	; 023269C4
loc_023269C6:
	ldr r1,[pool_023269D0]	; 023269C6
	str r0,[r1,#0x8]	; 023269C8
	pop {r4}	; 023269CA
	pop {r3}	; 023269CC
	bx r3	; 023269CE
pool_023269D0:
loc_023269D0:
	.word P1_BssStart + 0x24DFC	; 023269D0

; ===== function loc_023269D4 =====
loc_023269D4:
	push {lr}	; 023269D4
	sub sp,#0x4	; 023269D6
	ldr r2,[pool_02326A40]	; 023269D8
	ldr r0,[r2,#0x0]	; 023269DA
	mov r1,#0x1	; 023269DC
	and r0,r1	; 023269DE
	cmp r0,#0x1	; 023269E0
	bne loc_02326A32	; 023269E2
	ldr r3,[r2,#0x0]	; 023269E4
	mov r0,#0x2	; 023269E6
	and r3,r0	; 023269E8
	cmp r3,#0x2	; 023269EA
	beq loc_02326A32	; 023269EC
	ldr r0,[r2,#0x8]	; 023269EE
	lsl r3,r0,#0x2	; 023269F0
	ldr r0,[pool_02326A44]	; 023269F2
	ldr r3,[r0,r3]	; 023269F4
	ldr r0,[r2,#0x4]	; 023269F6
	lsr r3,r0	; 023269F8
	and r3,r1	; 023269FA
	lsl r0,r3,#0x10	; 023269FC
	lsr r0,r0,#0x10	; 023269FE
	bl loc_023294AC	; 02326A00
	ldr r0,[pool_02326A40]	; 02326A04
	ldr r1,[r0,#0x4]	; 02326A06
	add r1,r1,#0x1	; 02326A08
	str r1,[r0,#0x4]	; 02326A0A
	ldr r1,[r0,#0x4]	; 02326A0C
	cmp r1,#0x20	; 02326A0E
	blt loc_02326A22	; 02326A10
	ldr r1,[r0,#0x0]	; 02326A12
	mov r0,#0x4	; 02326A14
	and r1,r0	; 02326A16
	cmp r1,#0x4	; 02326A18
	bne loc_02326A22	; 02326A1A
	bl loc_0232696C	; 02326A1C
	b loc_02326A38	; 02326A20
loc_02326A22:
	ldr r0,[pool_02326A40]	; 02326A22
	ldr r0,[r0,#0x4]	; 02326A24
	mov r1,#0x20	; 02326A26
	blx P1_SignedDivMod	; 02326A28
	ldr r0,[pool_02326A40]	; 02326A2C
	str r1,[r0,#0x4]	; 02326A2E
	b loc_02326A38	; 02326A30
loc_02326A32:
	mov r0,#0x0	; 02326A32
	bl loc_023294AC	; 02326A34
loc_02326A38:
	add sp,#0x4	; 02326A38
	pop {r3}	; 02326A3A
	bx r3	; 02326A3C
	.byte 0xC0, 0x46	; 02326A40
pool_02326A40:
loc_02326A40:
	.word P1_BssStart + 0x24DFC	; 02326A40
pool_02326A44:
loc_02326A44:
	.word P1_Data_023301A4	; 02326A44

; ===== function loc_02326A48 =====
loc_02326A48:
	push {lr}	; 02326A48
	sub sp,#0x4	; 02326A4A
	ldr r0,[pool_02326A60]	; 02326A4C
	mov r1,#0x0	; 02326A4E
	mov r2,#0xc	; 02326A50
	blx loc_0232DEFC	; 02326A52
	bl loc_023294F8	; 02326A56
	add sp,#0x4	; 02326A5A
	pop {r3}	; 02326A5C
	bx r3	; 02326A5E
pool_02326A60:
loc_02326A60:
	.word 0x0235587C	; 02326A60

; ===== function loc_02326A64 =====
loc_02326A64:
	push {r4,lr}	; 02326A64
	add r4,r0,#0x0	; 02326A66
	bl loc_02326A9C	; 02326A68
	ldr r2,[pool_02326A7C]	; 02326A6C
	ldmia r2!,{r0,r1}	; 02326A6E
	stmia r4!,{r0,r1}	; 02326A70
	ldmia r2!,{r0,r1}	; 02326A72
	stmia r4!,{r0,r1}	; 02326A74
	pop {r4}	; 02326A76
	pop {r3}	; 02326A78
	bx r3	; 02326A7A
pool_02326A7C:
loc_02326A7C:
	.word 0x02355894	; 02326A7C

; ===== function loc_02326A80 =====
loc_02326A80:
	push {r4,lr}	; 02326A80
	add r4,r0,#0x0	; 02326A82
	bl loc_02326A9C	; 02326A84
	ldr r2,[pool_02326A98]	; 02326A88
	ldmia r2!,{r0,r1}	; 02326A8A
	stmia r4!,{r0,r1}	; 02326A8C
	ldr r0,[r2,#0x0]	; 02326A8E
	str r0,[r4,#0x0]	; 02326A90
	pop {r4}	; 02326A92
	pop {r3}	; 02326A94
	bx r3	; 02326A96
pool_02326A98:
loc_02326A98:
	.word 0x02355888	; 02326A98

; ===== function loc_02326A9C =====
loc_02326A9C:
	push {lr}	; 02326A9C
	sub sp,#0x4	; 02326A9E
	bl P1_GetFirmwareUiContext	; 02326AA0
	ldr r0,[r0,#0x4]	; 02326AA4
	mov r1,#0x14	; 02326AA6
	blx P1_UnsignedDivMod	; 02326AA8
	cmp r1,#0x0	; 02326AAC
	bne loc_02326AD2	; 02326AAE
	ldr r0,[pool_02326AD8]	; 02326AB0
	ldr r1,[pool_02326ADC]	; 02326AB2
	bl loc_0232FD20	; 02326AB4
	cmp r0,#0x0	; 02326AB8
	beq loc_02326AD2	; 02326ABA
	mov r2,#0x0	; 02326ABC
	ldr r0,[pool_02326AD8]	; 02326ABE
	str r2,[r0,#0x0]	; 02326AC0
	mov r1,#0x1	; 02326AC2
	str r1,[r0,#0x4]	; 02326AC4
	str r1,[r0,#0x8]	; 02326AC6
	str r2,[r0,#0xc]	; 02326AC8
	ldr r0,[pool_02326ADC]	; 02326ACA
	str r2,[r0,#0x0]	; 02326ACC
	str r2,[r0,#0x4]	; 02326ACE
	str r2,[r0,#0x8]	; 02326AD0
loc_02326AD2:
	add sp,#0x4	; 02326AD2
	pop {r3}	; 02326AD4
	bx r3	; 02326AD6
pool_02326AD8:
loc_02326AD8:
	.word P1_BssStart + 0x24E14	; 02326AD8
pool_02326ADC:
loc_02326ADC:
	.word P1_BssStart + 0x24E08	; 02326ADC

; ===== function loc_02326AE0 =====
loc_02326AE0:
	push {r4,r5,r6,r7,lr}	; 02326AE0
	sub sp,#0xc	; 02326AE2
	add r5,r0,#0x0	; 02326AE4
	add r4,r1,#0x0	; 02326AE6
	add r6,r2,#0x0	; 02326AE8
	sub r0,r4,#0x1	; 02326AEA
	cmp r0,#0x1	; 02326AEC
	bhi loc_02326AF4	; 02326AEE
	sub r5,r5,#0x1	; 02326AF0
	add r4,#0xc	; 02326AF2
loc_02326AF4:
	add r0,r5,#0x0	; 02326AF4
	ldr r1,[pool_02326B40]	; 02326AF6
	blx P1_SignedDivMod	; 02326AF8
	add r7,r0,#0x0	; 02326AFC
	add r0,r5,#0x0	; 02326AFE
	mov r1,#0x4	; 02326B00
	blx P1_SignedDivMod	; 02326B02
	str r0,[sp,#0x0]	; 02326B06
	add r0,r5,#0x0	; 02326B08
	mov r1,#0x64	; 02326B0A
	blx P1_SignedDivMod	; 02326B0C
	str r0,[sp,#0x4]	; 02326B10
	mov r0,#0xd	; 02326B12
	mul r4,r0	; 02326B14
	add r4,#0x8	; 02326B16
	add r0,r4,#0x0	; 02326B18
	mov r1,#0x5	; 02326B1A
	blx P1_SignedDivMod	; 02326B1C
	ldr r1,[sp,#0x0]	; 02326B20
	add r2,r5,r1	; 02326B22
	ldr r1,[sp,#0x4]	; 02326B24
	sub r1,r2,r1	; 02326B26
	add r1,r7,r1	; 02326B28
	add r0,r1,r0	; 02326B2A
	add r0,r6,r0	; 02326B2C
	mov r1,#0x7	; 02326B2E
	blx P1_SignedDivMod	; 02326B30
	add r0,r1,#0x0	; 02326B34
	add sp,#0xc	; 02326B36
	pop {r4,r5,r6,r7}	; 02326B38
	pop {r3}	; 02326B3A
	bx r3	; 02326B3C
	.byte 0xC0, 0x46	; 02326B40
pool_02326B40:
loc_02326B40:
	.word 0x00000190	; 02326B40

; ===== function loc_02326B44 =====
loc_02326B44:
	push {r4,r5,r6,lr}	; 02326B44
	sub sp,#0x18	; 02326B46
	add r4,r1,#0x0	; 02326B48
	ldr r6,[pool_02326B80]	; 02326B4A
	add r5,sp,#0x0	; 02326B4C
	mov r3,#0xc	; 02326B4E
loc_02326B50:
	ldrh r1,[r6,#0x0]	; 02326B50
	add r6,r6,#0x2	; 02326B52
	strh r1,[r5,#0x0]	; 02326B54
	add r5,r5,#0x2	; 02326B56
	sub r3,r3,#0x1	; 02326B58
	cmp r3,#0x0	; 02326B5A
	bne loc_02326B50	; 02326B5C
	cmp r2,#0x1	; 02326B5E
	beq loc_02326B6A	; 02326B60
	bl loc_02326B88	; 02326B62
	cmp r0,#0x0	; 02326B66
	beq loc_02326B70	; 02326B68
loc_02326B6A:
	mov r1,#0x1d	; 02326B6A
	add r0,sp,#0x0	; 02326B6C
	strh r1,[r0,#0x2]	; 02326B6E
loc_02326B70:
	lsl r1,r4,#0x1	; 02326B70
	ldr r0,[pool_02326B84]	; 02326B72
	add r0,sp	; 02326B74
	ldrh r0,[r0,r1]	; 02326B76
	add sp,#0x18	; 02326B78
	pop {r4,r5,r6}	; 02326B7A
	pop {r3}	; 02326B7C
	bx r3	; 02326B7E
pool_02326B80:
loc_02326B80:
	.word P1_Data_023308F8	; 02326B80
pool_02326B84:
loc_02326B84:
	.word 0xFFFFFFFE	; 02326B84

; ===== function loc_02326B88 =====
loc_02326B88:
	push {r4,lr}	; 02326B88
	add r4,r0,#0x0	; 02326B8A
	mov r1,#0x3	; 02326B8C
	add r2,r4,#0x0	; 02326B8E
	and r2,r1	; 02326B90
	cmp r2,#0x0	; 02326B92
	bne loc_02326BA0	; 02326B94
	mov r1,#0x64	; 02326B96
	blx P1_UnsignedDivMod	; 02326B98
	cmp r1,#0x0	; 02326B9C
	bne loc_02326BAC	; 02326B9E
loc_02326BA0:
	add r0,r4,#0x0	; 02326BA0
	ldr r1,[pool_02326BB8]	; 02326BA2
	blx P1_UnsignedDivMod	; 02326BA4
	cmp r1,#0x0	; 02326BA8
	bne loc_02326BB0	; 02326BAA
loc_02326BAC:
	mov r0,#0x1	; 02326BAC
	b loc_02326BB2	; 02326BAE
loc_02326BB0:
	mov r0,#0x0	; 02326BB0
loc_02326BB2:
	pop {r4}	; 02326BB2
	pop {r3}	; 02326BB4
	bx r3	; 02326BB6
pool_02326BB8:
loc_02326BB8:
	.word 0x00000190	; 02326BB8

; ===== function loc_02326BBC =====
loc_02326BBC:
	ldr r0,[pool_02326BD0]	; 02326BBC
	ldrh r1,[r0,#0x0]	; 02326BBE
	mov r0,#0x3c	; 02326BC0
	and r1,r0	; 02326BC2
	lsr r0,r1,#0x2	; 02326BC4
	lsl r1,r0,#0xe	; 02326BC6
	ldr r0,[pool_02326BD4]	; 02326BC8
	add r0,r1,r0	; 02326BCA
	bx lr	; 02326BCC
	.byte 0xC0, 0x46	; 02326BD0
pool_02326BD0:
loc_02326BD0:
	.word REG_BG3CNT_SUB	; 02326BD0
pool_02326BD4:
loc_02326BD4:
	.word 0x06200000	; 02326BD4

; ===== function loc_02326BD8 =====
loc_02326BD8:
	ldr r0,[pool_02326BF8]	; 02326BD8
	ldrh r0,[r0,#0x0]	; 02326BDA
	ldr r1,[pool_02326BFC]	; 02326BDC
	ldr r2,[r1,#0x0]	; 02326BDE
	ldr r1,[pool_02326C00]	; 02326BE0
	and r2,r1	; 02326BE2
	lsr r1,r2,#0x18	; 02326BE4
	lsl r2,r1,#0x10	; 02326BE6
	ldr r1,[pool_02326C04]	; 02326BE8
	add r2,r2,r1	; 02326BEA
	mov r1,#0x3c	; 02326BEC
	and r0,r1	; 02326BEE
	lsr r0,r0,#0x2	; 02326BF0
	lsl r0,r0,#0xe	; 02326BF2
	add r0,r2,r0	; 02326BF4
	bx lr	; 02326BF6
pool_02326BF8:
loc_02326BF8:
	.word REG_BG3CNT	; 02326BF8
pool_02326BFC:
loc_02326BFC:
	.word REG_DISPCNT_A	; 02326BFC
pool_02326C00:
loc_02326C00:
	.word 0x07000000	; 02326C00
pool_02326C04:
loc_02326C04:
	.word 0x06000000	; 02326C04

; ===== function loc_02326C08 =====
loc_02326C08:
	ldr r0,[pool_02326C1C]	; 02326C08
	ldrh r1,[r0,#0x0]	; 02326C0A
	mov r0,#0x3c	; 02326C0C
	and r1,r0	; 02326C0E
	lsr r0,r1,#0x2	; 02326C10
	lsl r1,r0,#0xe	; 02326C12
	ldr r0,[pool_02326C20]	; 02326C14
	add r0,r1,r0	; 02326C16
	bx lr	; 02326C18
	.byte 0xC0, 0x46	; 02326C1C
pool_02326C1C:
loc_02326C1C:
	.word REG_BG2CNT_SUB	; 02326C1C
pool_02326C20:
loc_02326C20:
	.word 0x06200000	; 02326C20

; ===== function loc_02326C24 =====
loc_02326C24:
	ldr r0,[pool_02326C44]	; 02326C24
	ldrh r0,[r0,#0x0]	; 02326C26
	ldr r1,[pool_02326C48]	; 02326C28
	ldr r2,[r1,#0x0]	; 02326C2A
	ldr r1,[pool_02326C4C]	; 02326C2C
	and r2,r1	; 02326C2E
	lsr r1,r2,#0x18	; 02326C30
	lsl r2,r1,#0x10	; 02326C32
	ldr r1,[pool_02326C50]	; 02326C34
	add r2,r2,r1	; 02326C36
	mov r1,#0x3c	; 02326C38
	and r0,r1	; 02326C3A
	lsr r0,r0,#0x2	; 02326C3C
	lsl r0,r0,#0xe	; 02326C3E
	add r0,r2,r0	; 02326C40
	bx lr	; 02326C42
pool_02326C44:
loc_02326C44:
	.word REG_BG2CNT	; 02326C44
pool_02326C48:
loc_02326C48:
	.word REG_DISPCNT_A	; 02326C48
pool_02326C4C:
loc_02326C4C:
	.word 0x07000000	; 02326C4C
pool_02326C50:
loc_02326C50:
	.word 0x06000000	; 02326C50

; ===== function loc_02326C54 =====
loc_02326C54:
	ldr r0,[pool_02326C68]	; 02326C54
	ldrh r1,[r0,#0x0]	; 02326C56
	ldr r0,[pool_02326C6C]	; 02326C58
	and r1,r0	; 02326C5A
	lsr r0,r1,#0x8	; 02326C5C
	lsl r1,r0,#0xb	; 02326C5E
	ldr r0,[pool_02326C70]	; 02326C60
	add r0,r1,r0	; 02326C62
	bx lr	; 02326C64
	.byte 0xC0, 0x46	; 02326C68
pool_02326C68:
loc_02326C68:
	.word REG_BG3CNT_SUB	; 02326C68
pool_02326C6C:
loc_02326C6C:
	.word 0x00001F00	; 02326C6C
pool_02326C70:
loc_02326C70:
	.word 0x06200000	; 02326C70
.arm

; ===== function loc_02326C74 =====
; Computes the main-engine BG3 tile map address. / 计算主引擎 BG3 tile map 地址。
.func P1_GetMainBg3TilemapAddress
loc_02326C74:
	ldr r1,[pool_02326CA4]	; 02326C74
	mov r0,#0x4000000	; 02326C78
	ldrh r2,[r1,#0x0]	; 02326C7C
	ldr r0,[r0,#0x0]	; 02326C80
	and r0,r0,#0x38000000	; 02326C84
	mov r0,r0, lsr #0x1b	; 02326C88
	mov r1,r0, lsl #0x10	; 02326C8C
	and r0,r2,#0x1f00	; 02326C90
	add r1,r1,#0x6000000	; 02326C94
	mov r0,r0, lsr #0x8	; 02326C98
	add r0,r1,r0, lsl #0xb	; 02326C9C
	bx lr	; 02326CA0
.endfunc
pool_02326CA4:
loc_02326CA4:
	.word REG_BG3CNT	; 02326CA4
.thumb

; ===== function loc_02326CA8 =====
loc_02326CA8:
	ldr r0,[pool_02326CBC]	; 02326CA8
	ldrh r1,[r0,#0x0]	; 02326CAA
	ldr r0,[pool_02326CC0]	; 02326CAC
	and r1,r0	; 02326CAE
	lsr r0,r1,#0x8	; 02326CB0
	lsl r1,r0,#0xb	; 02326CB2
	ldr r0,[pool_02326CC4]	; 02326CB4
	add r0,r1,r0	; 02326CB6
	bx lr	; 02326CB8
	.byte 0xC0, 0x46	; 02326CBC
pool_02326CBC:
loc_02326CBC:
	.word REG_BG2CNT_SUB	; 02326CBC
pool_02326CC0:
loc_02326CC0:
	.word 0x00001F00	; 02326CC0
pool_02326CC4:
loc_02326CC4:
	.word 0x06200000	; 02326CC4
.arm

; ===== function loc_02326CC8 =====
; Computes the main-engine BG2 tile map address. / 计算主引擎 BG2 tile map 地址。
.func P1_GetMainBg2TilemapAddress
loc_02326CC8:
	ldr r1,[pool_02326CF8]	; 02326CC8
	mov r0,#0x4000000	; 02326CCC
	ldrh r2,[r1,#0x0]	; 02326CD0
	ldr r0,[r0,#0x0]	; 02326CD4
	and r0,r0,#0x38000000	; 02326CD8
	mov r0,r0, lsr #0x1b	; 02326CDC
	mov r1,r0, lsl #0x10	; 02326CE0
	and r0,r2,#0x1f00	; 02326CE4
	add r1,r1,#0x6000000	; 02326CE8
	mov r0,r0, lsr #0x8	; 02326CEC
	add r0,r1,r0, lsl #0xb	; 02326CF0
	bx lr	; 02326CF4
.endfunc
pool_02326CF8:
loc_02326CF8:
	.word REG_BG2CNT	; 02326CF8
.thumb

; ===== function loc_02326CFC =====
loc_02326CFC:
	push {r4,lr}	; 02326CFC
	mvn r4,r0	; 02326CFE
	ldr r1,[pool_02326D20]	; 02326D00
	ldrh r3,[r1,#0x0]	; 02326D02
	ldrh r2,[r1,#0x14]	; 02326D04
	orr r3,r2	; 02326D06
	and r4,r3	; 02326D08
	strh r4,[r1,#0x0]	; 02326D0A
	strh r0,[r1,#0x14]	; 02326D0C
	mov r2,#0x84	; 02326D0E
	ldr r0,[pool_02326D24]	; 02326D10
	strb r2,[r0,#0x0]	; 02326D12
	ldrh r0,[r1,#0x0]	; 02326D14
	bl loc_0232D754	; 02326D16
	pop {r4}	; 02326D1A
	pop {r3}	; 02326D1C
	bx r3	; 02326D1E
pool_02326D20:
loc_02326D20:
	.word P1_BssStart + 0x266B0	; 02326D20
pool_02326D24:
loc_02326D24:
	.word VRAM_D_CR	; 02326D24

; ===== function loc_02326D28 =====
loc_02326D28:
	push {r4,lr}	; 02326D28
	mvn r4,r0	; 02326D2A
	ldr r1,[pool_02326D4C]	; 02326D2C
	ldrh r3,[r1,#0x0]	; 02326D2E
	ldrh r2,[r1,#0x12]	; 02326D30
	orr r3,r2	; 02326D32
	and r4,r3	; 02326D34
	strh r4,[r1,#0x0]	; 02326D36
	strh r0,[r1,#0x12]	; 02326D38
	mov r2,#0x84	; 02326D3A
	ldr r0,[pool_02326D50]	; 02326D3C
	strb r2,[r0,#0x0]	; 02326D3E
	ldrh r0,[r1,#0x0]	; 02326D40
	bl loc_0232D754	; 02326D42
	pop {r4}	; 02326D46
	pop {r3}	; 02326D48
	bx r3	; 02326D4A
pool_02326D4C:
loc_02326D4C:
	.word P1_BssStart + 0x266B0	; 02326D4C
pool_02326D50:
loc_02326D50:
	.word VRAM_C_CR	; 02326D50

; ===== function loc_02326D54 =====
loc_02326D54:
	push {r4,lr}	; 02326D54
	mvn r4,r0	; 02326D56
	ldr r1,[pool_02326D78]	; 02326D58
	ldrh r3,[r1,#0x0]	; 02326D5A
	ldrh r2,[r1,#0x4]	; 02326D5C
	orr r3,r2	; 02326D5E
	and r4,r3	; 02326D60
	strh r4,[r1,#0x0]	; 02326D62
	strh r0,[r1,#0x4]	; 02326D64
	mov r2,#0x82	; 02326D66
	ldr r0,[pool_02326D7C]	; 02326D68
	strb r2,[r0,#0x0]	; 02326D6A
	ldrh r0,[r1,#0x0]	; 02326D6C
	bl loc_0232D754	; 02326D6E
	pop {r4}	; 02326D72
	pop {r3}	; 02326D74
	bx r3	; 02326D76
pool_02326D78:
loc_02326D78:
	.word P1_BssStart + 0x266B0	; 02326D78
pool_02326D7C:
loc_02326D7C:
	.word VRAM_B_CR	; 02326D7C

; ===== function loc_02326D80 =====
loc_02326D80:
	push {r4,lr}	; 02326D80
	mvn r4,r0	; 02326D82
	ldr r1,[pool_02326DA4]	; 02326D84
	ldrh r3,[r1,#0x0]	; 02326D86
	ldrh r2,[r1,#0x2]	; 02326D88
	orr r3,r2	; 02326D8A
	and r4,r3	; 02326D8C
	strh r4,[r1,#0x0]	; 02326D8E
	strh r0,[r1,#0x2]	; 02326D90
	mov r2,#0x81	; 02326D92
	ldr r0,[pool_02326DA8]	; 02326D94
	strb r2,[r0,#0x0]	; 02326D96
	ldrh r0,[r1,#0x0]	; 02326D98
	bl loc_0232D754	; 02326D9A
	pop {r4}	; 02326D9E
	pop {r3}	; 02326DA0
	bx r3	; 02326DA2
pool_02326DA4:
loc_02326DA4:
	.word P1_BssStart + 0x266B0	; 02326DA4
pool_02326DA8:
loc_02326DA8:
	.word VRAM_A_CR	; 02326DA8

; ===== function loc_02326DAC =====
loc_02326DAC:
	push {r4,r5,lr}	; 02326DAC
	sub sp,#0x4	; 02326DAE
	ldr r0,[pool_02326E04]	; 02326DB0
	ldr r1,[pool_02326E08]	; 02326DB2
	blx loc_02328690	; 02326DB4
	add r5,r0,#0x0	; 02326DB8
	ldr r1,[pool_02326E0C]	; 02326DBA
	ldr r0,[r1,#0xc]	; 02326DBC
	ldr r1,[r1,#0x10]	; 02326DBE
	blx loc_02328690	; 02326DC0
	add r4,r0,#0x0	; 02326DC4
	ldr r0,[pool_02326E10]	; 02326DC6
	ldr r1,[pool_02326E04]	; 02326DC8
	add r2,r5,#0x0	; 02326DCA
	bl loc_0232C7E2	; 02326DCC
	ldr r1,[pool_02326E0C]	; 02326DD0
	ldr r1,[r1,#0xc]	; 02326DD2
	add r2,r4,#0x0	; 02326DD4
	bl loc_0232C7E2	; 02326DD6
	add r4,r0,#0x0	; 02326DDA
	blx P1_CleanAndInvalidateEntireDataCacheByIndex	; 02326DDC
	ldr r0,[pool_02326E0C]	; 02326DE0
	ldrh r0,[r0,#0x16]	; 02326DE2
	cmp r4,r0	; 02326DE4
	bne loc_02326DF6	; 02326DE6
	ldr r0,[pool_02326E14]	; 02326DE8
	bl P1_OrSharedEventFlags	; 02326DEA
	add sp,#0x4	; 02326DEE
	pop {r4,r5}	; 02326DF0
	pop {r3}	; 02326DF2
	bx r3	; 02326DF4
loc_02326DF6:
	ldr r0,[pool_02326E18]	; 02326DF6
	bl P1_OrSharedEventFlags	; 02326DF8
	add sp,#0x4	; 02326DFC
	pop {r4,r5}	; 02326DFE
	pop {r3}	; 02326E00
	bx r3	; 02326E02
pool_02326E04:
loc_02326E04:
	.word 0x02358DC0	; 02326E04
pool_02326E08:
loc_02326E08:
	.word 0x022C0000	; 02326E08
pool_02326E0C:
loc_02326E0C:
	.word 0x027FF860	; 02326E0C
pool_02326E10:
loc_02326E10:
	.word 0x0000FFFF	; 02326E10
pool_02326E14:
loc_02326E14:
	.word 0x00000400	; 02326E14
pool_02326E18:
loc_02326E18:
	.word 0x00000408	; 02326E18

; ===== function loc_02326E1C =====
loc_02326E1C:
	push {r4,lr}	; 02326E1C
	ldr r0,[pool_02326E4C]	; 02326E1E
	ldr r1,[pool_02326E50]	; 02326E20
	blx loc_02328690	; 02326E22
	add r2,r0,#0x0	; 02326E26
	ldr r0,[pool_02326E54]	; 02326E28
	ldr r1,[pool_02326E4C]	; 02326E2A
	bl loc_0232C7E2	; 02326E2C
	add r4,r0,#0x0	; 02326E30
	blx P1_CleanAndInvalidateEntireDataCacheByIndex	; 02326E32
	ldr r0,[pool_02326E58]	; 02326E36
	ldrh r0,[r0,#0x0]	; 02326E38
	cmp r4,r0	; 02326E3A
	bne loc_02326E44	; 02326E3C
	ldr r0,[pool_02326E5C]	; 02326E3E
	bl P1_OrSharedEventFlags	; 02326E40
loc_02326E44:
	pop {r4}	; 02326E44
	pop {r3}	; 02326E46
	bx r3	; 02326E48
	.byte 0xC0, 0x46	; 02326E4C
pool_02326E4C:
loc_02326E4C:
	.word 0x023A4A00	; 02326E4C
pool_02326E50:
loc_02326E50:
	.word 0x022C0000	; 02326E50
pool_02326E54:
loc_02326E54:
	.word 0x0000FFFF	; 02326E54
pool_02326E58:
loc_02326E58:
	.word FirmwareBootSharedAddress + BootSharedP5Crc16Offset	; 02326E58
pool_02326E5C:
loc_02326E5C:
	.word 0x10000000	; 02326E5C

; ===== function loc_02326E60 =====
loc_02326E60:
; 发布前 0x18 字节启动信息，再补 ARM7 BIOS CRC 与 RTC 随机值。
; Publish 0x18 boot-info bytes, then update the ARM7 BIOS CRC and RTC random byte.
.func P1_PublishBootInfo
	push {lr}	; 02326E60
	sub sp,#0x4	; 02326E62
	ldr r0,[pool_02326E84]	; 02326E64
	ldr r1,[pool_02326E88]	; 02326E66
	mov r2,#0x18	; 02326E68
	blx loc_0232DEC4	; 02326E6A
	ldr r0,[pool_02326E8C]	; 02326E6E
	ldrh r1,[r0,#0x0]	; 02326E70
	ldr r0,[pool_02326E90]	; 02326E72
	strh r1,[r0,#0x0]	; 02326E74
	ldr r0,[pool_02326E94]	; 02326E76
	ldrb r1,[r0,#0x0]	; 02326E78
	ldr r0,[pool_02326E98]	; 02326E7A
	strb r1,[r0,#0x0]	; 02326E7C
	add sp,#0x4	; 02326E7E
	pop {r3}	; 02326E80
	bx r3	; 02326E82
.endfunc
pool_02326E84:
loc_02326E84:
	.word 0x027FF800	; 02326E84
pool_02326E88:
loc_02326E88:
	.word 0x027FFC00	; 02326E88
pool_02326E8C:
loc_02326E8C:
	.word 0x027FF850	; 02326E8C
pool_02326E90:
loc_02326E90:
	.word FirmwareBootInfoAddress + BootInfoBios7Crc16Offset	; 02326E90
pool_02326E94:
loc_02326E94:
	.word 0x027FF818	; 02326E94
pool_02326E98:
loc_02326E98:
	.word FirmwareBootInfoAddress + BootInfoRtcRandomOffset	; 02326E98

; ===== function loc_02326E9C =====
loc_02326E9C:
	push {r4,r5,r6,r7,lr}	; 02326E9C
	sub sp,#0x4	; 02326E9E
	ldr r5,[pool_02326F50]	; 02326EA0
	mov r0,#0x6d	; 02326EA2
	bl loc_0232B3C8	; 02326EA4
	blx P1_Arm9DisableIrqReturnPriorMask	; 02326EA8
	str r0,[sp,#0x0]	; 02326EAC
	ldr r2,[pool_02326F54]	; 02326EAE
	ldrh r1,[r2,#0x0]	; 02326EB0
	ldr r0,[pool_02326F58]	; 02326EB2
	and r1,r0	; 02326EB4
	asr r4,r1,#0xf	; 02326EB6
	ldrh r1,[r2,#0x0]	; 02326EB8
	mov r0,#0xc	; 02326EBA
	and r1,r0	; 02326EBC
	asr r6,r1,#0x2	; 02326EBE
	ldrh r1,[r2,#0x0]	; 02326EC0
	mov r3,#0x10	; 02326EC2
	and r1,r3	; 02326EC4
	asr r7,r1,#0x4	; 02326EC6
	ldrh r1,[r2,#0x0]	; 02326EC8
	bic r1,r0	; 02326ECA
	orr r1,r0	; 02326ECC
	strh r1,[r2,#0x0]	; 02326ECE
	ldrh r0,[r2,#0x0]	; 02326ED0
	bic r0,r3	; 02326ED2
	strh r0,[r2,#0x0]	; 02326ED4
	ldrh r1,[r2,#0x0]	; 02326ED6
	ldr r0,[pool_02326F5C]	; 02326ED8
	and r1,r0	; 02326EDA
	strh r1,[r2,#0x0]	; 02326EDC
	mov r0,#0x0	; 02326EDE
	ldr r1,[pool_02326F60]	; 02326EE0
	ldr r2,[pool_02326F64]	; 02326EE2
	mov r3,#0x40	; 02326EE4
	bl loc_0232DD94	; 02326EE6
	ldr r0,[pool_02326F54]	; 02326EEA
	ldrh r1,[r0,#0x0]	; 02326EEC
	ldr r2,[pool_02326F5C]	; 02326EEE
	and r1,r2	; 02326EF0
	lsl r2,r4,#0xf	; 02326EF2
	orr r1,r2	; 02326EF4
	strh r1,[r0,#0x0]	; 02326EF6
	ldrh r2,[r0,#0x0]	; 02326EF8
	mov r1,#0xc	; 02326EFA
	bic r2,r1	; 02326EFC
	lsl r1,r6,#0x2	; 02326EFE
	orr r2,r1	; 02326F00
	strh r2,[r0,#0x0]	; 02326F02
	ldrh r2,[r0,#0x0]	; 02326F04
	mov r1,#0x10	; 02326F06
	bic r2,r1	; 02326F08
	lsl r1,r7,#0x4	; 02326F0A
	orr r2,r1	; 02326F0C
	strh r2,[r0,#0x0]	; 02326F0E
	ldr r0,[sp,#0x0]	; 02326F10
	blx P1_Arm9RestoreIrqMask	; 02326F12
	mov r0,#0x6d	; 02326F16
	bl loc_0232B260	; 02326F18
	add r0,r5,#0x0	; 02326F1C
	add r0,#0xbe	; 02326F1E
	ldrh r1,[r0,#0x0]	; 02326F20
	ldr r0,[pool_02326F68]	; 02326F22
	strh r1,[r0,#0x0]	; 02326F24
	mov r2,#0x0	; 02326F26
	ldr r0,[pool_02326F6C]	; 02326F28
loc_02326F2A:
	add r1,r5,r2	; 02326F2A
	add r1,#0xb5	; 02326F2C
	ldrb r1,[r1,#0x0]	; 02326F2E
	strb r1,[r2,r0]	; 02326F30
	add r2,r2,#0x1	; 02326F32
	cmp r2,#0x3	; 02326F34
	blt loc_02326F2A	; 02326F36
	add r0,r5,#0x0	; 02326F38
	add r0,#0xb0	; 02326F3A
	ldrh r0,[r0,#0x0]	; 02326F3C
	ldr r1,[pool_02326F68]	; 02326F3E
	strh r0,[r1,#0x6]	; 02326F40
	add r5,#0xac	; 02326F42
	ldr r0,[r5,#0x0]	; 02326F44
	str r0,[r1,#0x8]	; 02326F46
	add sp,#0x4	; 02326F48
	pop {r4,r5,r6,r7}	; 02326F4A
	pop {r3}	; 02326F4C
	bx r3	; 02326F4E
pool_02326F50:
loc_02326F50:
	.word 0x023558C0	; 02326F50
pool_02326F54:
loc_02326F54:
	.word REG_EXMEMCNT_ARM9	; 02326F54
pool_02326F58:
loc_02326F58:
	.word 0x00008000	; 02326F58
pool_02326F5C:
loc_02326F5C:
	.word 0xFFFF7FFF	; 02326F5C
pool_02326F60:
loc_02326F60:
	.word 0x08000080	; 02326F60
pool_02326F64:
loc_02326F64:
	.word 0x02355940	; 02326F64
pool_02326F68:
loc_02326F68:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 02326F68
pool_02326F6C:
loc_02326F6C:
	.word 0x027FFC32	; 02326F6C

; ===== function loc_02326F70 =====
loc_02326F70:
	push {r4}	; 02326F70
	sub sp,#0x4	; 02326F72
	ldr r1,[pool_02326FA8]	; 02326F74
	mov r2,#0x4e	; 02326F76
	sub r2,r2,#0x1	; 02326F78
	lsl r2,r2,#0x10	; 02326F7A
	lsr r4,r2,#0x10	; 02326F7C
loc_02326F7E:
	ldrh r3,[r1,#0x0]	; 02326F7E
	add r1,r1,#0x2	; 02326F80
	ldrh r2,[r0,#0x0]	; 02326F82
	add r0,r0,#0x2	; 02326F84
	cmp r3,r2	; 02326F86
	beq loc_02326F92	; 02326F88
	mov r0,#0x0	; 02326F8A
	add sp,#0x4	; 02326F8C
	pop {r4}	; 02326F8E
	bx lr	; 02326F90
loc_02326F92:
	add r3,r4,#0x0	; 02326F92
	sub r2,r4,#0x1	; 02326F94
	lsl r2,r2,#0x10	; 02326F96
	lsr r4,r2,#0x10	; 02326F98
	cmp r3,#0x0	; 02326F9A
	bne loc_02326F7E	; 02326F9C
	mov r0,#0x1	; 02326F9E
	add sp,#0x4	; 02326FA0
	pop {r4}	; 02326FA2
	bx lr	; 02326FA4
	.byte 0xC0, 0x46	; 02326FA8
pool_02326FA8:
loc_02326FA8:
	.word Bios9NintendoLogoAddress	; 02326FA8

; ===== function loc_02326FAC =====
loc_02326FAC:
	ldr r0,[pool_02326FCC]	; 02326FAC
	ldrh r1,[r0,#0x0]	; 02326FAE
	ldr r0,[pool_02326FD0]	; 02326FB0
	cmp r1,r0	; 02326FB2
	bne loc_02326FC6	; 02326FB4
	ldr r0,[pool_02326FD4]	; 02326FB6
	ldrh r1,[r0,#0x0]	; 02326FB8
	ldr r0,[pool_02326FD8]	; 02326FBA
	ldrh r0,[r0,#0x0]	; 02326FBC
	cmp r1,r0	; 02326FBE
	bne loc_02326FC6	; 02326FC0
	mov r0,#0x1	; 02326FC2
	bx lr	; 02326FC4
loc_02326FC6:
	mov r0,#0x0	; 02326FC6
	bx lr	; 02326FC8
	.byte 0xC0, 0x46	; 02326FCC
pool_02326FCC:
loc_02326FCC:
	.word NdsCartHeaderRamAddress + 0x15C	; 02326FCC
pool_02326FD0:
loc_02326FD0:
	.word 0x0000CF56	; 02326FD0
pool_02326FD4:
loc_02326FD4:
	.word NdsCartHeaderRamAddress + 0x15E	; 02326FD4
pool_02326FD8:
loc_02326FD8:
	.word 0x027FF808	; 02326FD8

; ===== function loc_02326FDC =====
loc_02326FDC:
	add r1,r0,#0x0	; 02326FDC
	mov r0,#0x2	; 02326FDE
	mov r2,#0x0	; 02326FE0
	ldr r3,[pool_02326FE8]	; 02326FE2
	bx r3	; 02326FE4
	.byte 0xC0, 0x46	; 02326FE8
pool_02326FE8:
loc_02326FE8:
	.word loc_0232E8C4 + 1	; 02326FE8

; ===== function loc_02326FEC =====
loc_02326FEC:
	push {lr}	; 02326FEC
	sub sp,#0x4	; 02326FEE
	ldr r0,[pool_02327004]	; 02326FF0
	ldrb r1,[r0,#0x0]	; 02326FF2
	add r0,sp,#0x0	; 02326FF4
	strb r1,[r0,#0x0]	; 02326FF6
	add r0,sp,#0x0	; 02326FF8
	bl loc_0232FBFC	; 02326FFA
	add sp,#0x4	; 02326FFE
	pop {r3}	; 02327000
	bx r3	; 02327002
pool_02327004:
loc_02327004:
	.word FirmwareUserSettingsSharedAddress + 0x67	; 02327004

; ===== function loc_02327008 =====
loc_02327008:
	push {lr}	; 02327008
	sub sp,#0x1c	; 0232700A
	ldr r0,[pool_02327048]	; 0232700C
	ldrb r0,[r0,#0x0]	; 0232700E
	str r0,[sp,#0x0]	; 02327010
	ldr r0,[pool_0232704C]	; 02327012
	ldrh r0,[r0,#0x0]	; 02327014
	str r0,[sp,#0x4]	; 02327016
	ldr r0,[pool_02327050]	; 02327018
	ldrh r0,[r0,#0x0]	; 0232701A
	str r0,[sp,#0x8]	; 0232701C
	ldr r0,[pool_02327054]	; 0232701E
	ldrb r0,[r0,#0x0]	; 02327020
	str r0,[sp,#0xc]	; 02327022
	ldr r0,[pool_02327058]	; 02327024
	ldrb r0,[r0,#0x0]	; 02327026
	str r0,[sp,#0x10]	; 02327028
	add r0,sp,#0x14	; 0232702A
	ldr r1,[pool_0232705C]	; 0232702C
	ldrh r1,[r1,#0x0]	; 0232702E
	ldr r2,[pool_02327060]	; 02327030
	ldrh r2,[r2,#0x0]	; 02327032
	ldr r3,[pool_02327064]	; 02327034
	ldrb r3,[r3,#0x0]	; 02327036
	bl loc_0232EBE4	; 02327038
	add r0,sp,#0x14	; 0232703C
	bl loc_0232EE2C	; 0232703E
	add sp,#0x1c	; 02327042
	pop {r3}	; 02327044
	bx r3	; 02327046
pool_02327048:
loc_02327048:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelY1Offset	; 02327048
pool_0232704C:
loc_0232704C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcX2Offset	; 0232704C
pool_02327050:
loc_02327050:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcY2Offset	; 02327050
pool_02327054:
loc_02327054:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelX2Offset	; 02327054
pool_02327058:
loc_02327058:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelY2Offset	; 02327058
pool_0232705C:
loc_0232705C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcX1Offset	; 0232705C
pool_02327060:
loc_02327060:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcY1Offset	; 02327060
pool_02327064:
loc_02327064:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelX1Offset	; 02327064

; ===== function loc_02327068 =====
loc_02327068:
	push {r4,r5,lr}	; 02327068
	sub sp,#0x4	; 0232706A
	ldr r5,[pool_023270F0]	; 0232706C
	bl loc_02326FAC	; 0232706E
	cmp r0,#0x0	; 02327072
	beq loc_0232707E	; 02327074
	ldr r0,[pool_023270F4]	; 02327076
	ldr r0,[r0,#0x0]	; 02327078
	cmp r0,#0x0	; 0232707A
	bne loc_0232708C	; 0232707C
loc_0232707E:
	mov r1,#0x0	; 0232707E
	ldr r0,[pool_023270F8]	; 02327080
	str r1,[r0,#0x0]	; 02327082
	add sp,#0x4	; 02327084
	pop {r4,r5}	; 02327086
	pop {r3}	; 02327088
	bx r3	; 0232708A
loc_0232708C:
	blx loc_0232B270	; 0232708C
	add r4,r0,#0x0	; 02327090
	cmp r4,#0x0	; 02327092
	beq loc_023270C2	; 02327094
	lsl r0,r4,#0x10	; 02327096
	lsr r0,r0,#0x10	; 02327098
	bl loc_0232B35C	; 0232709A
	add r0,r5,#0x0	; 0232709E
	ldr r1,[pool_023270FC]	; 023270A0
	blx P1_CleanAndInvalidateDataCacheRange	; 023270A2
	ldr r0,[pool_023270F4]	; 023270A6
	ldr r0,[r0,#0x0]	; 023270A8
	add r1,r5,#0x0	; 023270AA
	ldr r2,[pool_023270FC]	; 023270AC
	bl loc_02327B74	; 023270AE
	lsl r0,r4,#0x10	; 023270B2
	lsr r0,r0,#0x10	; 023270B4
	bl loc_0232B268	; 023270B6
	lsl r0,r4,#0x10	; 023270BA
	lsr r0,r0,#0x10	; 023270BC
	blx loc_0232B2C8	; 023270BE
loc_023270C2:
	ldr r0,[pool_02327100]	; 023270C2
	add r1,r5,#0x0	; 023270C4
	add r1,#0x20	; 023270C6
	ldr r2,[pool_02327104]	; 023270C8
	bl loc_0232C7E2	; 023270CA
	ldrh r1,[r5,#0x2]	; 023270CE
	cmp r1,r0	; 023270D0
	beq loc_023270E2	; 023270D2
	mov r1,#0x0	; 023270D4
	ldr r0,[pool_023270F8]	; 023270D6
	str r1,[r0,#0x0]	; 023270D8
	add sp,#0x4	; 023270DA
	pop {r4,r5}	; 023270DC
	pop {r3}	; 023270DE
	bx r3	; 023270E0
loc_023270E2:
	mov r1,#0x1	; 023270E2
	ldr r0,[pool_023270F8]	; 023270E4
	str r1,[r0,#0x0]	; 023270E6
	add sp,#0x4	; 023270E8
	pop {r4,r5}	; 023270EA
	pop {r3}	; 023270EC
	bx r3	; 023270EE
pool_023270F0:
loc_023270F0:
	.word 0x02355980	; 023270F0
pool_023270F4:
loc_023270F4:
	.word NdsCartHeaderRamAddress + 0x68	; 023270F4
pool_023270F8:
loc_023270F8:
	.word P1_BssStart + 0x24E24	; 023270F8
pool_023270FC:
loc_023270FC:
	.word 0x00000840	; 023270FC
pool_02327100:
loc_02327100:
	.word 0x0000FFFF	; 02327100
pool_02327104:
loc_02327104:
	.word 0x00000820	; 02327104

; ===== function loc_02327108 =====
loc_02327108:
	push {lr}	; 02327108
	sub sp,#0x4	; 0232710A
	add r1,r0,#0x0	; 0232710C
	ldr r0,[pool_02327130]	; 0232710E
	ldr r0,[r0,#0x0]	; 02327110
	cmp r0,#0x0	; 02327112
	bne loc_0232711E	; 02327114
	mov r0,#0x0	; 02327116
	add sp,#0x4	; 02327118
	pop {r3}	; 0232711A
	bx r3	; 0232711C
loc_0232711E:
	ldr r0,[pool_02327134]	; 0232711E
	ldr r2,[pool_02327138]	; 02327120
	blx loc_0232DE30	; 02327122
	mov r0,#0x1	; 02327126
	add sp,#0x4	; 02327128
	pop {r3}	; 0232712A
	bx r3	; 0232712C
	.byte 0xC0, 0x46	; 02327130
pool_02327130:
loc_02327130:
	.word P1_BssStart + 0x24E24	; 02327130
pool_02327134:
loc_02327134:
	.word 0x02355980	; 02327134
pool_02327138:
loc_02327138:
	.word 0x00000840	; 02327138

; ===== function loc_0232713C =====
loc_0232713C:
	ldr r1,[r0,#0x0]	; 0232713C
	cmp r1,#0x17	; 0232713E
	bhi loc_0232714E	; 02327140
	ldr r1,[r0,#0x4]	; 02327142
	cmp r1,#0x3b	; 02327144
	bhi loc_0232714E	; 02327146
	ldr r0,[r0,#0x8]	; 02327148
	cmp r0,#0x3b	; 0232714A
	bls loc_02327152	; 0232714C
loc_0232714E:
	mov r0,#0x0	; 0232714E
	bx lr	; 02327150
loc_02327152:
	mov r0,#0x1	; 02327152
	bx lr	; 02327154
	.byte 0x00, 0x00	; 02327158

; ===== function loc_02327158 =====
loc_02327158:
	ldr r1,[r0,#0x0]	; 02327158
	cmp r1,#0x64	; 0232715A
	bcs loc_02327178	; 0232715C
	ldr r1,[r0,#0x4]	; 0232715E
	cmp r1,#0x1	; 02327160
	bcc loc_02327178	; 02327162
	cmp r1,#0xc	; 02327164
	bhi loc_02327178	; 02327166
	ldr r1,[r0,#0x8]	; 02327168
	cmp r1,#0x1	; 0232716A
	bcc loc_02327178	; 0232716C
	cmp r1,#0x1f	; 0232716E
	bhi loc_02327178	; 02327170
	ldr r0,[r0,#0xc]	; 02327172
	cmp r0,#0x7	; 02327174
	blt loc_0232717C	; 02327176
loc_02327178:
	mov r0,#0x0	; 02327178
	bx lr	; 0232717A
loc_0232717C:
	mov r0,#0x1	; 0232717C
	bx lr	; 0232717E

; ===== function loc_02327180 =====
loc_02327180:
	push {r4,lr}	; 02327180
	sub sp,#0x20	; 02327182
	mov r4,#0x0	; 02327184
	ldr r0,[pool_0232721C]	; 02327186
	bl loc_023283E4	; 02327188
	ldr r1,[pool_02327220]	; 0232718C
	str r0,[r1,#0x0]	; 0232718E
	ldr r0,[r1,#0x0]	; 02327190
	cmp r0,#0x0	; 02327192
	beq loc_023271C8	; 02327194
	lsl r0,r4,#0	; 02327196
	str r0,[sp,#0x0]	; 02327198
	add r0,sp,#0x0	; 0232719A
	ldr r1,[pool_0232721C]	; 0232719C
	ldr r2,[pool_02327224]	; 0232719E
	bl loc_0232C7DA	; 023271A0
	ldr r0,[pool_02327228]	; 023271A4
	ldrh r2,[r0,#0x0]	; 023271A6
	ldr r1,[pool_0232722C]	; 023271A8
	orr r2,r1	; 023271AA
	strh r2,[r0,#0x0]	; 023271AC
	mov r2,#0x5	; 023271AE
	ldr r1,[pool_0232721C]	; 023271B0
	strb r2,[r1,#0x0]	; 023271B2
	ldrh r2,[r0,#0x0]	; 023271B4
	mov r1,#0x7	; 023271B6
	bic r2,r1	; 023271B8
	mov r1,#0x1	; 023271BA
	orr r2,r1	; 023271BC
	strh r2,[r0,#0x0]	; 023271BE
	ldr r0,[pool_02327230]	; 023271C0
	strb r1,[r0,#0x0]	; 023271C2
	ldr r0,[pool_02327234]	; 023271C4
	strb r1,[r0,#0x0]	; 023271C6
loc_023271C8:
	ldr r0,[pool_02327238]	; 023271C8
	ldrb r1,[r0,#0x0]	; 023271CA
	mov r0,#0x1	; 023271CC
	and r1,r0	; 023271CE
	cmp r1,#0x0	; 023271D0
	beq loc_023271D6	; 023271D2
	add r4,r0,#0x0	; 023271D4
loc_023271D6:
	add r0,sp,#0x4	; 023271D6
	add r1,sp,#0x14	; 023271D8
	bl loc_0232FD20	; 023271DA
	add r0,sp,#0x4	; 023271DE
	bl loc_02327158	; 023271E0
	cmp r0,#0x0	; 023271E4
	beq loc_023271F2	; 023271E6
	add r0,sp,#0x14	; 023271E8
	bl loc_0232713C	; 023271EA
	cmp r0,#0x0	; 023271EE
	bne loc_023271F4	; 023271F0
loc_023271F2:
	mov r4,#0x1	; 023271F2
loc_023271F4:
	cmp r4,#0x0	; 023271F4
	beq loc_02327214	; 023271F6
	ldr r2,[pool_02327228]	; 023271F8
	ldrh r1,[r2,#0x0]	; 023271FA
	ldr r0,[pool_0232723C]	; 023271FC
	and r1,r0	; 023271FE
	strh r1,[r2,#0x0]	; 02327200
	mov r1,#0x0	; 02327202
	ldr r0,[pool_02327240]	; 02327204
	str r1,[r0,#0x0]	; 02327206
	str r1,[r0,#0x4]	; 02327208
	ldr r0,[pool_02327244]	; 0232720A
	strb r1,[r0,#0x0]	; 0232720C
	ldr r0,[pool_0232721C]	; 0232720E
	bl loc_023282B8	; 02327210
loc_02327214:
	add sp,#0x20	; 02327214
	pop {r4}	; 02327216
	pop {r3}	; 02327218
	bx r3	; 0232721A
pool_0232721C:
loc_0232721C:
	.word FirmwareUserSettingsSharedAddress	; 0232721C
pool_02327220:
loc_02327220:
	.word 0x027FF864	; 02327220
pool_02327224:
loc_02327224:
	.word 0x0100001C	; 02327224
pool_02327228:
loc_02327228:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02327228
pool_0232722C:
loc_0232722C:
	.word 0x00000200	; 0232722C
pool_02327230:
loc_02327230:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 02327230
pool_02327234:
loc_02327234:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthDayOffset	; 02327234
pool_02327238:
loc_02327238:
	.word 0x027FF818	; 02327238
pool_0232723C:
loc_0232723C:
	.word 0xFFFFBFFF	; 0232723C
pool_02327240:
loc_02327240:
	.word FirmwareUserSettingsSharedAddress + UserSettingsRtcOffset	; 02327240
pool_02327244:
loc_02327244:
	.word FirmwareUserSettingsSharedAddress + 0x66	; 02327244
.arm
; 此段随后覆盖复制至 ITCM；运行入口不是 CRT 初始内容。
; This stub later replaces ITCM contents; its entry is not the CRT image.
P1_TransitionCopySource:
.func P1_TransitionLoadEntry
	ldr r0,[pool_0232728C]	; 02327248
	mov r1,#0x9	; 0232724C
	str r1,[r0,#0x0]	; 02327250
	ldr r1,[pool_02327290]	; 02327254
	b loc_02327264	; 02327258
loc_0232725C:
	mov r0,#0x400	; 0232725C
	swi 0x30000	; 02327260
loc_02327264:
	ldr r0,[r1,#0x0]	; 02327264
	cmp r0,#0xa	; 02327268
	bne loc_0232725C	; 0232726C
	ldr r1,[pool_02327294]	; 02327270
	ldrh r0,[r1,#0x0]	; 02327274
	bic r0,r0,#0x4000	; 02327278
	strh r0,[r1,#0x0]	; 0232727C
	mov r0,#0x0	; 02327280
	mcr p15,0x0,r0,c7,c0,0x4	; 02327284
	bx lr	; 02327288
.endfunc
.definelabel P1_TransitionItcmBase, 0x01FF8000
.definelabel P1_TransitionRuntimeEntry, P1_TransitionItcmBase + (P1_TransitionLoadEntry - P1_TransitionCopySource)
pool_0232728C:
loc_0232728C:
	.word 0x027FF880	; 0232728C
pool_02327290:
loc_02327290:
	.word 0x027FF884	; 02327290
pool_02327294:
loc_02327294:
	.word REG_EXMEMCNT_ARM9	; 02327294
.thumb

; ===== function loc_02327298 =====
loc_02327298:
	push {lr}	; 02327298
	sub sp,#0x4	; 0232729A
	mov r0,#0x3	; 0232729C
	bl loc_0232D740	; 0232729E
	mov r0,#0x0	; 023272A2
	str r0,[sp,#0x0]	; 023272A4
	ldr r0,[sp,#0x0]	; 023272A6
	ldr r1,[pool_023272B8]	; 023272A8
	ldr r2,[pool_023272BC]	; 023272AA
	blx loc_0232DE78	; 023272AC
	add sp,#0x4	; 023272B0
	pop {r3}	; 023272B2
	bx r3	; 023272B4
	.byte 0xC0, 0x46	; 023272B8
pool_023272B8:
loc_023272B8:
	.word 0x06800000	; 023272B8
pool_023272BC:
loc_023272BC:
	.word 0x00040000	; 023272BC

; ===== function loc_023272C0 =====
loc_023272C0:
	push {lr}	; 023272C0
	sub sp,#0x4	; 023272C2
	ldr r0,[pool_02327374]	; 023272C4
	ldrh r0,[r0,#0x0]	; 023272C6
	lsl r0,r0,#0x1c	; 023272C8
	lsr r0,r0,#0x1f	; 023272CA
	cmp r0,#0x0	; 023272CC
	beq loc_023272E2	; 023272CE
	ldr r0,[pool_02327378]	; 023272D0
	ldr r0,[r0,#0x0]	; 023272D2
	cmp r0,#0x0	; 023272D4
	bne loc_023272E2	; 023272D6
	mov r0,#0x0	; 023272D8
	add r1,r0,#0x0	; 023272DA
	bl loc_0232F200	; 023272DC
	b loc_023272EA	; 023272E0
loc_023272E2:
	mov r0,#0x1	; 023272E2
	mov r1,#0x0	; 023272E4
	bl loc_0232F200	; 023272E6
loc_023272EA:
	ldr r1,[pool_0232737C]	; 023272EA
	ldrh r0,[r1,#0x0]	; 023272EC
	mov r0,#0x0	; 023272EE
	strh r0,[r1,#0x0]	; 023272F0
	bl loc_0232B194	; 023272F2
	bl loc_0232D670	; 023272F6
	bl loc_0232D660	; 023272FA
	bl loc_0232D630	; 023272FE
	bl loc_0232D620	; 02327302
	bl loc_0232D650	; 02327306
	ldr r0,[pool_02327380]	; 0232730A
	bl loc_0232D740	; 0232730C
	mov r0,#0x0	; 02327310
	str r0,[sp,#0x0]	; 02327312
	ldr r0,[sp,#0x0]	; 02327314
	ldr r1,[pool_02327384]	; 02327316
	ldr r2,[pool_02327388]	; 02327318
	blx loc_0232DE78	; 0232731A
	bl loc_0232D640	; 0232731E
	bl loc_02327298	; 02327322
	bl loc_0232D47C	; 02327326
	ldr r0,[pool_0232738C]	; 0232732A
	ldrh r2,[r0,#0x0]	; 0232732C
	mov r1,#0x2	; 0232732E
	orr r2,r1	; 02327330
	strh r2,[r0,#0x0]	; 02327332
	ldrh r2,[r0,#0x0]	; 02327334
	ldr r1,[pool_02327390]	; 02327336
	and r2,r1	; 02327338
	strh r2,[r0,#0x0]	; 0232733A
	ldrh r2,[r0,#0x0]	; 0232733C
	mov r1,#0xc	; 0232733E
	bic r2,r1	; 02327340
	strh r2,[r0,#0x0]	; 02327342
	ldr r1,[pool_02327374]	; 02327344
	ldrh r1,[r1,#0x0]	; 02327346
	lsl r1,r1,#0x1c	; 02327348
	lsr r1,r1,#0x1f	; 0232734A
	cmp r1,#0x0	; 0232734C
	beq loc_02327360	; 0232734E
	ldr r1,[pool_02327378]	; 02327350
	ldr r1,[r1,#0x0]	; 02327352
	cmp r1,#0x0	; 02327354
	bne loc_02327360	; 02327356
	ldrh r2,[r0,#0x0]	; 02327358
	ldr r1,[pool_02327394]	; 0232735A
	and r2,r1	; 0232735C
	strh r2,[r0,#0x0]	; 0232735E
loc_02327360:
; CpuFastSet 的 0x100 个字复制 0x400 字节，再进入新的 ITCM 段。
; CpuFastSet copies 0x100 words (0x400 bytes), then enters the new ITCM stub.
	ldr r0,[pool_02327398]	; 02327360
	ldr r1,[pool_0232739C]	; 02327362
	ldr r2,[pool_023273A0]	; 02327364
	bl loc_0232C7DA	; 02327366
	ldr r0,[pool_0232739C]	; 0232736A
	blx r0	; 0232736C
	add sp,#0x4	; 0232736E
	pop {r3}	; 02327370
	bx r3	; 02327372
pool_02327374:
loc_02327374:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02327374
pool_02327378:
loc_02327378:
	.word 0x027FF864	; 02327378
pool_0232737C:
loc_0232737C:
	.word REG_IME	; 0232737C
pool_02327380:
loc_02327380:
	.word 0x000001FF	; 02327380
pool_02327384:
loc_02327384:
	.word 0x06800000	; 02327384
pool_02327388:
loc_02327388:
	.word 0x000A4000	; 02327388
pool_0232738C:
loc_0232738C:
	.word REG_POWERCNT	; 0232738C
pool_02327390:
loc_02327390:
	.word 0xFFFFFDFF	; 02327390
pool_02327394:
loc_02327394:
	.word 0xFFFF7FFF	; 02327394
pool_02327398:
loc_02327398:
	.word P1_TransitionCopySource	; 02327398
pool_0232739C:
loc_0232739C:
	.word P1_TransitionRuntimeEntry	; 0232739C
pool_023273A0:
loc_023273A0:
	.word 0x00000100	; 023273A0

; ===== function loc_023273A4 =====
loc_023273A4:
	push {lr}	; 023273A4
	sub sp,#0x24	; 023273A6
	mov r0,#0x0	; 023273A8
	bl loc_0232B194	; 023273AA
	mov r0,#0x0	; 023273AE
	mvn r0,r0	; 023273B0
	bl loc_0232B11C	; 023273B2
	ldr r0,[pool_02327458]	; 023273B6
	bl loc_0232D740	; 023273B8
	mov r0,#0x0	; 023273BC
	str r0,[sp,#0x0]	; 023273BE
	ldr r0,[sp,#0x0]	; 023273C0
	ldr r1,[pool_0232745C]	; 023273C2
	ldr r2,[pool_02327460]	; 023273C4
	blx loc_0232DE78	; 023273C6
	bl loc_0232D640	; 023273CA
	mov r0,#0x0	; 023273CE
	str r0,[sp,#0x4]	; 023273D0
	ldr r0,[sp,#0x4]	; 023273D2
	ldr r1,[pool_02327464]	; 023273D4
	ldr r2,[pool_02327468]	; 023273D6
	blx loc_0232DE78	; 023273D8
	mov r0,#0x0	; 023273DC
	str r0,[sp,#0x8]	; 023273DE
	ldr r0,[sp,#0x8]	; 023273E0
	ldr r1,[pool_0232746C]	; 023273E2
	ldr r2,[pool_02327468]	; 023273E4
	blx loc_0232DE78	; 023273E6
	mov r0,#0x0	; 023273EA
	str r0,[sp,#0xc]	; 023273EC
	ldr r0,[sp,#0xc]	; 023273EE
	ldr r1,[pool_02327470]	; 023273F0
	ldr r2,[pool_02327468]	; 023273F2
	blx loc_0232DE78	; 023273F4
	mov r0,#0x0	; 023273F8
	str r0,[sp,#0x10]	; 023273FA
	ldr r0,[sp,#0x10]	; 023273FC
	ldr r1,[pool_02327474]	; 023273FE
	ldr r2,[pool_02327468]	; 02327400
	blx loc_0232DE78	; 02327402
	mov r0,#0x0	; 02327406
	str r0,[sp,#0x14]	; 02327408
	ldr r0,[sp,#0x14]	; 0232740A
	ldr r1,[pool_02327478]	; 0232740C
	ldr r2,[pool_0232747C]	; 0232740E
	blx loc_0232DE78	; 02327410
	mov r0,#0x0	; 02327414
	str r0,[sp,#0x18]	; 02327416
	ldr r0,[sp,#0x18]	; 02327418
	ldr r1,[pool_02327480]	; 0232741A
	mov r2,#0x40	; 0232741C
	blx loc_0232DE78	; 0232741E
	mov r0,#0x0	; 02327422
	str r0,[sp,#0x1c]	; 02327424
	ldr r0,[sp,#0x1c]	; 02327426
	ldr r1,[pool_02327484]	; 02327428
	mov r2,#0x6e	; 0232742A
	blx loc_0232DE78	; 0232742C
	mov r0,#0x0	; 02327430
	ldr r1,[pool_02327480]	; 02327432
	strh r0,[r1,#0x0]	; 02327434
	ldr r1,[pool_02327488]	; 02327436
	str r0,[r1,#0x0]	; 02327438
	mov r2,#0x1	; 0232743A
	ldr r1,[pool_0232748C]	; 0232743C
	str r2,[r1,#0x0]	; 0232743E
	str r0,[r1,#0x4]	; 02327440
	ldr r2,[pool_02327490]	; 02327442
	ldr r1,[pool_02327494]	; 02327444
	strh r2,[r1,#0x0]	; 02327446
	ldr r1,[pool_02327498]	; 02327448
	str r0,[r1,#0x0]	; 0232744A
	ldr r1,[pool_0232749C]	; 0232744C
	strh r0,[r1,#0x0]	; 0232744E
	add sp,#0x24	; 02327450
	pop {r3}	; 02327452
	bx r3	; 02327454
	.byte 0xC0, 0x46	; 02327458
pool_02327458:
loc_02327458:
	.word 0x000001FF	; 02327458
pool_0232745C:
loc_0232745C:
	.word 0x06800000	; 0232745C
pool_02327460:
loc_02327460:
	.word 0x000A4000	; 02327460
pool_02327464:
loc_02327464:
	.word 0x07000000	; 02327464
pool_02327468:
loc_02327468:
	.word 0x00000400	; 02327468
pool_0232746C:
loc_0232746C:
	.word 0x05000000	; 0232746C
pool_02327470:
loc_02327470:
	.word 0x07000400	; 02327470
pool_02327474:
loc_02327474:
	.word 0x05000400	; 02327474
pool_02327478:
loc_02327478:
	.word REG_BG0CNT	; 02327478
pool_0232747C:
loc_0232747C:
	.word 0x0000012C	; 0232747C
pool_02327480:
loc_02327480:
	.word REG_DIVCNT	; 02327480
pool_02327484:
loc_02327484:
	.word REG_DISPCNT_B	; 02327484
pool_02327488:
loc_02327488:
	.word REG_DIV_NUMER	; 02327488
pool_0232748C:
loc_0232748C:
	.word REG_DIV_DENOM	; 0232748C
pool_02327490:
loc_02327490:
	.word 0x00004008	; 02327490
pool_02327494:
loc_02327494:
	.word REG_IPC_FIFO_CR	; 02327494
pool_02327498:
loc_02327498:
	.word REG_DISPCNT_A	; 02327498
pool_0232749C:
loc_0232749C:
	.word REG_DISPSTAT	; 0232749C

; ===== function loc_023274A0 =====
loc_023274A0:
	ldr r1,[pool_023274B4]	; 023274A0
	ldr r1,[r1,#0x0]	; 023274A2
	and r1,r0	; 023274A4
	cmp r1,#0x0	; 023274A6
	beq loc_023274AE	; 023274A8
	mov r0,#0x1	; 023274AA
	bx lr	; 023274AC
loc_023274AE:
	mov r0,#0x0	; 023274AE
	bx lr	; 023274B0
	.byte 0xC0, 0x46	; 023274B4
pool_023274B4:
loc_023274B4:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023274B4

; ===== function loc_023274B8 =====
loc_023274B8:
	ldr r0,[pool_023274E8]	; 023274B8
	ldr r2,[r0,#0x0]	; 023274BA
	ldr r1,[pool_023274EC]	; 023274BC
	cmp r2,r1	; 023274BE
	bcc loc_023274E2	; 023274C0
	ldr r0,[pool_023274F0]	; 023274C2
	cmp r2,r0	; 023274C4
	bcs loc_023274E2	; 023274C6
	ldr r0,[pool_023274F4]	; 023274C8
	ldr r2,[r0,#0x0]	; 023274CA
	cmp r2,r1	; 023274CC
	bcc loc_023274D6	; 023274CE
	ldr r0,[pool_023274F8]	; 023274D0
	cmp r2,r0	; 023274D2
	bcc loc_023274E4	; 023274D4
loc_023274D6:
	ldr r0,[pool_023274FC]	; 023274D6
	cmp r2,r0	; 023274D8
	bcc loc_023274E2	; 023274DA
	ldr r0,[pool_02327500]	; 023274DC
	cmp r2,r0	; 023274DE
	bcc loc_023274E4	; 023274E0
loc_023274E2:
	b loc_023274E2	; 023274E2
loc_023274E4:
	bx lr	; 023274E4
	.byte 0xC0, 0x46	; 023274E8
pool_023274E8:
loc_023274E8:
	.word NdsCartHeaderArm9EntryAddress	; 023274E8
pool_023274EC:
loc_023274EC:
	.word 0x02000000	; 023274EC
pool_023274F0:
loc_023274F0:
	.word 0x02280000	; 023274F0
pool_023274F4:
loc_023274F4:
	.word NdsCartHeaderArm7EntryAddress	; 023274F4
pool_023274F8:
loc_023274F8:
	.word 0x023FE000	; 023274F8
pool_023274FC:
loc_023274FC:
	.word 0x037F8000	; 023274FC
pool_02327500:
loc_02327500:
	.word 0x0380F000	; 02327500

; ===== function loc_02327504 =====
loc_02327504:
	push {r4,lr}	; 02327504
	bl loc_023274B8	; 02327506
	ldr r0,[pool_02327580]	; 0232750A
	ldr r1,[pool_02327584]	; 0232750C
	ldr r2,[pool_02327588]	; 0232750E
	sub r2,r2,r0	; 02327510
	blx loc_0232DEC4	; 02327512
	ldr r0,[pool_02327580]	; 02327516
	ldr r1,[pool_0232758C]	; 02327518
	blx P1_CleanDataCacheRange	; 0232751A
	mov r4,#0x0	; 0232751E
loc_02327520:
	add r0,r4,#0x0	; 02327520
	bl loc_0232DD54	; 02327522
	add r4,r4,#0x1	; 02327526
	cmp r4,#0x3	; 02327528
	ble loc_02327520	; 0232752A
	bl loc_02327C14	; 0232752C
	bl loc_023273A4	; 02327530
	mov r0,#0x0	; 02327534
	bl loc_0232D4F0	; 02327536
	ldr r0,[pool_02327590]	; 0232753A
	ldr r1,[pool_02327594]	; 0232753C
	bl loc_0232B1F0	; 0232753E
	ldr r0,[pool_02327590]	; 02327542
	bl loc_0232B194	; 02327544
	ldr r1,[pool_02327598]	; 02327548
	ldr r0,[pool_0232759C]	; 0232754A
	strh r1,[r0,#0x0]	; 0232754C
	mov r1,#0x7	; 0232754E
	ldr r0,[pool_023275A0]	; 02327550
	str r1,[r0,#0x0]	; 02327552
	mov r0,#0x1	; 02327554
	ldr r1,[pool_02327590]	; 02327556
	blx loc_0232AFD8	; 02327558
	ldr r2,[pool_0232759C]	; 0232755C
	ldrh r1,[r2,#0x0]	; 0232755E
	ldr r0,[pool_023275A4]	; 02327560
	and r1,r0	; 02327562
	strh r1,[r2,#0x0]	; 02327564
	ldr r1,[pool_023275A8]	; 02327566
	ldrh r0,[r1,#0x0]	; 02327568
	mov r0,#0x0	; 0232756A
	strh r0,[r1,#0x0]	; 0232756C
	bl loc_0232B194	; 0232756E
	mov r0,#0x0	; 02327572
	mvn r0,r0	; 02327574
	bl loc_0232B11C	; 02327576
	pop {r4}	; 0232757A
	pop {r3}	; 0232757C
	bx r3	; 0232757E
pool_02327580:
loc_02327580:
	.word 0x02327CF0	; 02327580
pool_02327584:
loc_02327584:
	.word 0x023FEE00	; 02327584
pool_02327588:
loc_02327588:
	.word 0x02327E58	; 02327588
pool_0232758C:
loc_0232758C:
	.word 0x00000200	; 0232758C
pool_02327590:
loc_02327590:
	.word 0x00010000	; 02327590
pool_02327594:
loc_02327594:
	.word P1_IrqHandler_023275AC + 1	; 02327594
pool_02327598:
loc_02327598:
	.word 0x00004F00	; 02327598
pool_0232759C:
loc_0232759C:
	.word REG_IPC_SYNC	; 0232759C
pool_023275A0:
loc_023275A0:
	.word 0x027FF880	; 023275A0
pool_023275A4:
loc_023275A4:
	.word 0x00000F00	; 023275A4
pool_023275A8:
loc_023275A8:
	.word REG_IME	; 023275A8
P1_IrqHandler_023275AC:
	ldr r1,[pool_023275BC]	; 023275AC
	ldr r0,[pool_023275C0]	; 023275AE
	add r1,r1,r0	; 023275B0
	ldr r2,[r1,#0x0]	; 023275B2
	ldr r0,[pool_023275C4]	; 023275B4
	orr r2,r0	; 023275B6
	str r2,[r1,#0x0]	; 023275B8
	bx lr	; 023275BA
pool_023275BC:
loc_023275BC:
	.word 0x03000000	; 023275BC
pool_023275C0:
loc_023275C0:
	.word 0x00003FF8	; 023275C0
pool_023275C4:
loc_023275C4:
	.word 0x00010000	; 023275C4

; ===== function loc_023275C8 =====
loc_023275C8:
; 将参数中的事件位并入双核共享位图。
; OR the requested event bits into the shared bitmap.
.func P1_OrSharedEventFlags
	push {r4,lr}	; 023275C8
	add r4,r0,#0x0	; 023275CA
	mov r0,#0x6e	; 023275CC
	ldr r1,[pool_023275EC]	; 023275CE
	mov r2,#0x0	; 023275D0
	bl loc_0232B4BC	; 023275D2
	ldr r1,[pool_023275EC]	; 023275D6
	ldr r0,[r1,#0x8]	; 023275D8
	orr r0,r4	; 023275DA
	str r0,[r1,#0x8]	; 023275DC
	mov r0,#0x6e	; 023275DE
	mov r2,#0x0	; 023275E0
	bl loc_0232B444	; 023275E2
	pop {r4}	; 023275E6
	pop {r3}	; 023275E8
	bx r3	; 023275EA
.endfunc
pool_023275EC:
loc_023275EC:
	.word FirmwareBootSharedAddress + BootSharedEventSyncOffset	; 023275EC

; ===== function loc_023275F0 =====
loc_023275F0:
	ldr r0,[pool_023275F8]	; 023275F0
	ldr r3,[pool_023275FC]	; 023275F2
	bx r3	; 023275F4
	.byte 0xC0, 0x46	; 023275F8
pool_023275F8:
loc_023275F8:
	.word 0x80000040	; 023275F8
pool_023275FC:
loc_023275FC:
	.word P1_OrSharedEventFlags + 1	; 023275FC

; ===== function loc_02327600 =====
loc_02327600:
	ldr r0,[pool_02327608]	; 02327600
	ldr r3,[pool_0232760C]	; 02327602
	bx r3	; 02327604
	.byte 0xC0, 0x46	; 02327608
pool_02327608:
loc_02327608:
	.word 0x80000100	; 02327608
pool_0232760C:
loc_0232760C:
	.word P1_OrSharedEventFlags + 1	; 0232760C

; ===== function loc_02327610 =====
loc_02327610:
	ldr r0,[pool_02327618]	; 02327610
	ldr r3,[pool_0232761C]	; 02327612
	bx r3	; 02327614
	.byte 0xC0, 0x46	; 02327618
pool_02327618:
loc_02327618:
	.word 0x80000080	; 02327618
pool_0232761C:
loc_0232761C:
	.word P1_OrSharedEventFlags + 1	; 0232761C

; ===== function loc_02327620 =====
loc_02327620:
	ldr r0,[pool_02327628]	; 02327620
	ldr r3,[pool_0232762C]	; 02327622
	bx r3	; 02327624
	.byte 0xC0, 0x46	; 02327628
pool_02327628:
loc_02327628:
	.word 0x80000010	; 02327628
pool_0232762C:
loc_0232762C:
	.word P1_OrSharedEventFlags + 1	; 0232762C

; ===== function loc_02327630 =====
loc_02327630:
	push {lr}	; 02327630
	sub sp,#0x4	; 02327632
	ldr r0,[pool_02327664]	; 02327634
	bl loc_02326F70	; 02327636
	cmp r0,#0x0	; 0232763A
	beq loc_02327648	; 0232763C
	ldr r1,[pool_02327668]	; 0232763E
	mov r0,#0x0	; 02327640
	ldrsh r0,[r1,r0]	; 02327642
	cmp r0,#0x1	; 02327644
	bne loc_02327656	; 02327646
loc_02327648:
	mov r0,#0x4	; 02327648
	bl P1_OrSharedEventFlags	; 0232764A
	mov r0,#0x0	; 0232764E
	add sp,#0x4	; 02327650
	pop {r3}	; 02327652
	bx r3	; 02327654
loc_02327656:
	ldr r0,[pool_0232766C]	; 02327656
	bl P1_OrSharedEventFlags	; 02327658
	mov r0,#0x1	; 0232765C
	add sp,#0x4	; 0232765E
	pop {r3}	; 02327660
	bx r3	; 02327662
pool_02327664:
loc_02327664:
	.word 0x027FFEC0	; 02327664
pool_02327668:
loc_02327668:
	.word 0x027FF812	; 02327668
pool_0232766C:
loc_0232766C:
	.word 0x80000020	; 0232766C

; ===== function loc_02327670 =====
loc_02327670:
	push {lr}	; 02327670
	sub sp,#0x4	; 02327672
	ldr r0,[pool_02327698]	; 02327674
	ldr r2,[r0,#0x0]	; 02327676
	mov r0,#0x8	; 02327678
	add r1,r2,#0x0	; 0232767A
	and r1,r0	; 0232767C
	cmp r1,#0x0	; 0232767E
	bne loc_02327690	; 02327680
	ldr r0,[pool_0232769C]	; 02327682
	and r2,r0	; 02327684
	cmp r2,#0x0	; 02327686
	beq loc_02327690	; 02327688
	ldr r0,[pool_023276A0]	; 0232768A
	bl P1_OrSharedEventFlags	; 0232768C
loc_02327690:
	add sp,#0x4	; 02327690
	pop {r3}	; 02327692
	bx r3	; 02327694
	.byte 0xC0, 0x46	; 02327698
pool_02327698:
loc_02327698:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327698
pool_0232769C:
loc_0232769C:
	.word 0x00000400	; 0232769C
pool_023276A0:
loc_023276A0:
	.word 0x08000000	; 023276A0

; ===== function loc_023276A4 =====
loc_023276A4:
	push {r4,lr}	; 023276A4
	sub sp,#0x10	; 023276A6
	ldr r0,[pool_02327898]	; 023276A8
	ldr r1,[r0,#0x20]	; 023276AA
	cmp r1,#0x8	; 023276AC
	bls loc_023276B2	; 023276AE
	b loc_0232788E	; 023276B0
loc_023276B2:
	add r1,r1,r1	; 023276B2
P1_SwitchIndexPC_023276B2:
	add r1,pc	; 023276B4
	ldrh r1,[r1,#(P1_SwitchTable_023276B2 - (P1_SwitchIndexPC_023276B2 + 4))]	; 023276B6
	lsl r1,r1,#0x10	; 023276B8
	asr r1,r1,#0x10	; 023276BA
P1_SwitchTargetPC_023276B2:
	add r1,pc	; 023276BC
	bx r1	; 023276BE
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023276B2:
	.halfword (loc_0232788E + 1) - (P1_SwitchTargetPC_023276B2 + 4)
	.halfword (loc_0232788E + 1) - (P1_SwitchTargetPC_023276B2 + 4)
	.halfword (loc_023276D2 + 1) - (P1_SwitchTargetPC_023276B2 + 4)
	.halfword (loc_0232772A + 1) - (P1_SwitchTargetPC_023276B2 + 4)
	.halfword (loc_0232777A + 1) - (P1_SwitchTargetPC_023276B2 + 4)
	.halfword (loc_02327794 + 1) - (P1_SwitchTargetPC_023276B2 + 4)
	.halfword (loc_023277A6 + 1) - (P1_SwitchTargetPC_023276B2 + 4)
	.halfword (loc_0232788E + 1) - (P1_SwitchTargetPC_023276B2 + 4)
	.halfword (loc_023277F8 + 1) - (P1_SwitchTargetPC_023276B2 + 4)
P1_SwitchTable_023276B2End:
loc_023276D2:
	bl loc_02327180	; 023276D2
	bl loc_02327008	; 023276D6
	bl loc_02326FEC	; 023276DA
	mov r4,#0x0	; 023276DE
	bl loc_02326FAC	; 023276E0
	cmp r0,#0x0	; 023276E4
	beq loc_023276FA	; 023276E6
	mov r0,#0x2	; 023276E8
	orr r4,r0	; 023276EA
	ldr r0,[pool_0232789C]	; 023276EC
	bl loc_02326F70	; 023276EE
	cmp r0,#0x0	; 023276F2
	bne loc_023276FA	; 023276F4
	mov r0,#0x4	; 023276F6
	orr r4,r0	; 023276F8
loc_023276FA:
	bl loc_023285A4	; 023276FA
	cmp r0,#0x0	; 023276FE
	beq loc_02327710	; 02327700
	mov r0,#0x1	; 02327702
	orr r4,r0	; 02327704
	ldr r2,[pool_023278A0]	; 02327706
	ldrb r1,[r2,#0x0]	; 02327708
	bic r1,r0	; 0232770A
	orr r1,r0	; 0232770C
	strb r1,[r2,#0x0]	; 0232770E
loc_02327710:
	bl loc_02326E9C	; 02327710
	bl P1_Runtime_01FF8084	; 02327714
	ldr r0,[pool_023278A4]	; 02327718
	orr r4,r0	; 0232771A
	add r0,r4,#0x0	; 0232771C
	bl P1_OrSharedEventFlags	; 0232771E
	mov r1,#0x3	; 02327722
	ldr r0,[pool_02327898]	; 02327724
	str r1,[r0,#0x20]	; 02327726
	b loc_0232788E	; 02327728
loc_0232772A:
	ldr r3,[pool_023278A8]	; 0232772A
	ldr r2,[r3,#0x0]	; 0232772C
	ldr r1,[pool_023278AC]	; 0232772E
	and r2,r1	; 02327730
	cmp r2,#0x0	; 02327732
	bne loc_02327738	; 02327734
	b loc_0232788E	; 02327736
loc_02327738:
	ldr r2,[r3,#0x0]	; 02327738
	mov r1,#0x20	; 0232773A
	and r2,r1	; 0232773C
	cmp r2,#0x0	; 0232773E
	beq loc_02327750	; 02327740
	mov r0,#0x3	; 02327742
	bl loc_02326FDC	; 02327744
	mov r1,#0x4	; 02327748
	ldr r0,[pool_02327898]	; 0232774A
	str r1,[r0,#0x20]	; 0232774C
	b loc_0232788E	; 0232774E
loc_02327750:
	ldr r2,[r3,#0x0]	; 02327750
	mov r1,#0x10	; 02327752
	and r2,r1	; 02327754
	cmp r2,#0x0	; 02327756
	beq loc_02327760	; 02327758
	mov r1,#0x5	; 0232775A
	str r1,[r0,#0x20]	; 0232775C
	b loc_0232788E	; 0232775E
loc_02327760:
	ldr r1,[r3,#0x0]	; 02327760
	ldr r0,[pool_023278B0]	; 02327762
	and r1,r0	; 02327764
	cmp r1,#0x0	; 02327766
	bne loc_0232776C	; 02327768
	b loc_0232788E	; 0232776A
loc_0232776C:
	mov r0,#0x6	; 0232776C
	bl loc_02326FDC	; 0232776E
	mov r1,#0x6	; 02327772
	ldr r0,[pool_02327898]	; 02327774
	str r1,[r0,#0x20]	; 02327776
	b loc_0232788E	; 02327778
loc_0232777A:
	ldr r0,[pool_023278B4]	; 0232777A
	bl loc_023274A0	; 0232777C
	cmp r0,#0x0	; 02327780
	bne loc_02327786	; 02327782
	b loc_0232788E	; 02327784
loc_02327786:
	bl loc_02327504	; 02327786
	mov r0,#0x1	; 0232778A
	add sp,#0x10	; 0232778C
	pop {r4}	; 0232778E
	pop {r3}	; 02327790
	bx r3	; 02327792
loc_02327794:
	ldr r0,[r0,#0x24]	; 02327794
	cmp r0,#0x2	; 02327796
	bne loc_0232788E	; 02327798
	mov r0,#0x4	; 0232779A
	bl loc_02326FDC	; 0232779C
	bl loc_023272C0	; 023277A0
	b loc_0232788E	; 023277A4
loc_023277A6:
	ldr r0,[pool_023278A8]	; 023277A6
	ldr r1,[r0,#0x0]	; 023277A8
	ldr r0,[pool_023278B8]	; 023277AA
	and r1,r0	; 023277AC
	cmp r1,#0x0	; 023277AE
	beq loc_0232788E	; 023277B0
	bl loc_02326DAC	; 023277B2
	ldr r0,[pool_023278BC]	; 023277B6
	bl P1_OrSharedEventFlags	; 023277B8
	mov r0,#0x0	; 023277BC
	str r0,[sp,#0x4]	; 023277BE
	ldr r0,[sp,#0x4]	; 023277C0
	ldr r1,[pool_023278C0]	; 023277C2
	ldr r2,[pool_023278C4]	; 023277C4
	blx loc_0232DE78	; 023277C6
; 按此版本的零区起点和字节数清零，SWI 参数换算为 32 位字数。
; Clear this version's zero area; convert its byte size to the SWI word count.
	ldr r2,[pool_023278C8]	; 023277CA
	cmp r2,#0x0	; 023277CC
	beq loc_023277E6	; 023277CE
	mov r0,#0x0	; 023277D0
	str r0,[sp,#0x0]	; 023277D2
	add r0,sp,#0x0	; 023277D4
	ldr r1,[pool_023278CC]	; 023277D6
	lsr r2,r2,#0x2	; 023277D8
	ldr r3,[pool_023278D0]	; 023277DA
	and r2,r3	; 023277DC
	ldr r3,[pool_023278D4]	; 023277DE
	orr r2,r3	; 023277E0
	bl loc_0232C7DA	; 023277E2
loc_023277E6:
	blx P1_CleanEntireDataCacheByIndex	; 023277E6
	mov r0,#0x7	; 023277EA
	bl loc_02326FDC	; 023277EC
	mov r1,#0x8	; 023277F0
	ldr r0,[pool_02327898]	; 023277F2
	str r1,[r0,#0x20]	; 023277F4
	b loc_0232788E	; 023277F6
loc_023277F8:
	ldr r0,[pool_023278A8]	; 023277F8
	ldr r2,[r0,#0x0]	; 023277FA
	ldr r1,[pool_023278D8]	; 023277FC
	and r2,r1	; 023277FE
	cmp r2,#0x0	; 02327800
	beq loc_0232788E	; 02327802
	ldr r2,[r0,#0x0]	; 02327804
	ldr r1,[pool_023278DC]	; 02327806
	and r2,r1	; 02327808
	cmp r2,#0x0	; 0232780A
	beq loc_0232788E	; 0232780C
	ldr r2,[r0,#0x0]	; 0232780E
	mov r1,#0x80	; 02327810
	and r2,r1	; 02327812
	cmp r2,#0x0	; 02327814
	beq loc_02327822	; 02327816
	ldr r0,[pool_023278E0]	; 02327818
	ldr r0,[r0,#0x0]	; 0232781A
	ldr r0,[r0,#0x0]	; 0232781C
	blx r0	; 0232781E
	b loc_02327884	; 02327820
loc_02327822:
	ldr r2,[r0,#0x0]	; 02327822
	ldr r1,[pool_023278E4]	; 02327824
	and r2,r1	; 02327826
	cmp r2,#0x0	; 02327828
	beq loc_02327872	; 0232782A
	ldr r1,[r0,#0x0]	; 0232782C
	mov r0,#0x2	; 0232782E
	and r1,r0	; 02327830
	cmp r1,#0x0	; 02327832
	beq loc_0232783A	; 02327834
	mov r0,#0x1	; 02327836
	b loc_0232783C	; 02327838
loc_0232783A:
	mov r0,#0x0	; 0232783A
loc_0232783C:
	cmp r0,#0x0	; 0232783C
	beq loc_02327860	; 0232783E
	ldr r0,[pool_02327898]	; 02327840
	ldr r1,[r0,#0x0]	; 02327842
	ldr r0,[pool_023278E8]	; 02327844
	str r1,[r0,#0x0]	; 02327846
	ldr r0,[pool_023278EC]	; 02327848
	ldr r1,[pool_023278F0]	; 0232784A
	ldr r2,[pool_023278F4]	; 0232784C
	blx loc_0232DEC4	; 0232784E
	mov r0,#0x0	; 02327852
	str r0,[sp,#0x8]	; 02327854
	ldr r0,[sp,#0x8]	; 02327856
	ldr r1,[pool_023278EC]	; 02327858
	ldr r2,[pool_023278F4]	; 0232785A
	blx loc_0232DE78	; 0232785C
loc_02327860:
	ldr r0,[pool_023278E0]	; 02327860
	ldr r0,[r0,#0x0]	; 02327862
	ldr r0,[r0,#0x4]	; 02327864
	blx r0	; 02327866
	blx P1_CleanEntireDataCacheByIndex	; 02327868
	bl loc_02327504	; 0232786C
	b loc_02327884	; 02327870
loc_02327872:
	ldr r1,[r0,#0x0]	; 02327872
	mov r0,#0x40	; 02327874
	and r1,r0	; 02327876
	cmp r1,#0x0	; 02327878
	beq loc_02327884	; 0232787A
	ldr r0,[pool_023278E0]	; 0232787C
	ldr r0,[r0,#0x0]	; 0232787E
	ldr r0,[r0,#0x8]	; 02327880
	blx r0	; 02327882
loc_02327884:
	mov r0,#0x1	; 02327884
	add sp,#0x10	; 02327886
	pop {r4}	; 02327888
	pop {r3}	; 0232788A
	bx r3	; 0232788C
loc_0232788E:
	mov r0,#0x0	; 0232788E
	add sp,#0x10	; 02327890
	pop {r4}	; 02327892
	pop {r3}	; 02327894
	bx r3	; 02327896
pool_02327898:
loc_02327898:
	.word 0x027FF860	; 02327898
pool_0232789C:
loc_0232789C:
	.word 0x027FFEC0	; 0232789C
pool_023278A0:
loc_023278A0:
	.word FirmwareBootInfoAddress + BootInfoGbaFlagsOffset	; 023278A0
pool_023278A4:
loc_023278A4:
	.word 0x20000000	; 023278A4
pool_023278A8:
loc_023278A8:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023278A8
pool_023278AC:
loc_023278AC:
	.word 0x80000000	; 023278AC
pool_023278B0:
loc_023278B0:
	.word 0x000001C0	; 023278B0
pool_023278B4:
loc_023278B4:
	.word 0x00000200	; 023278B4
pool_023278B8:
loc_023278B8:
	.word 0x00001000	; 023278B8
pool_023278BC:
loc_023278BC:
	.word 0x00000400	; 023278BC
pool_023278C0:
loc_023278C0:
	.word 0x02000000	; 023278C0
pool_023278C4:
loc_023278C4:
	.word 0x00300000	; 023278C4
pool_023278C8:
loc_023278C8:
	.word UiBootZeroBytes	; 023278C8
pool_023278CC:
loc_023278CC:
	.word UiBootZeroStart	; 023278CC
pool_023278D0:
loc_023278D0:
	.word 0x001FFFFF	; 023278D0
pool_023278D4:
loc_023278D4:
	.word 0x01000000	; 023278D4
pool_023278D8:
loc_023278D8:
	.word 0x40000000	; 023278D8
pool_023278DC:
loc_023278DC:
	.word 0x08000000	; 023278DC
pool_023278E0:
loc_023278E0:
	.word P1_BssStart + 0x24E28	; 023278E0
pool_023278E4:
loc_023278E4:
	.word 0x00000100	; 023278E4
pool_023278E8:
loc_023278E8:
	.word NdsCartHeaderArm7RamAddress	; 023278E8
pool_023278EC:
loc_023278EC:
	.word 0x027FFE00	; 023278EC
pool_023278F0:
loc_023278F0:
	.word 0x023FE940	; 023278F0
pool_023278F4:
loc_023278F4:
	.word 0x00000160	; 023278F4

; ===== function loc_023278F8 =====
loc_023278F8:
	push {r4,r5,r6,r7,lr}	; 023278F8
	sub sp,#0x4	; 023278FA
	ldr r4,[pool_02327948]	; 023278FC
	ldr r6,[pool_0232794C]	; 023278FE
	ldr r7,[pool_02327950]	; 02327900
loc_02327902:
	ldr r5,[r6,#0x0]	; 02327902
	ldr r0,[pool_02327954]	; 02327904
	bl loc_0232C7B8	; 02327906
	add r0,r5,#0x0	; 0232790A
	and r0,r4	; 0232790C
	cmp r0,#0x0	; 0232790E
	bne loc_02327924	; 02327910
	and r5,r7	; 02327912
	cmp r5,#0x0	; 02327914
	beq loc_02327902	; 02327916
	bl loc_02326E1C	; 02327918
	add r0,r4,#0x0	; 0232791C
	bl P1_OrSharedEventFlags	; 0232791E
	b loc_02327902	; 02327922
loc_02327924:
	mov r1,#0x2	; 02327924
	ldr r0,[pool_02327958]	; 02327926
	str r1,[r0,#0x0]	; 02327928
	ldr r2,[pool_0232795C]	; 0232792A
	ldrh r1,[r2,#0x0]	; 0232792C
	mov r0,#0x1	; 0232792E
	orr r1,r0	; 02327930
	strh r1,[r2,#0x0]	; 02327932
	bl loc_02327CD0	; 02327934
	bl loc_02327068	; 02327938
	mov r0,#0x0	; 0232793C
	add sp,#0x4	; 0232793E
	pop {r4,r5,r6,r7}	; 02327940
	pop {r3}	; 02327942
	bx r3	; 02327944
	.byte 0xC0, 0x46	; 02327948
pool_02327948:
loc_02327948:
	.word 0x00000800	; 02327948
pool_0232794C:
loc_0232794C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232794C
pool_02327950:
loc_02327950:
	.word 0x00002000	; 02327950
pool_02327954:
loc_02327954:
	.word 0x00001000	; 02327954
pool_02327958:
loc_02327958:
	.word 0x027FF880	; 02327958
pool_0232795C:
loc_0232795C:
	.word REG_POSTFLG	; 0232795C

; ===== function P1_ClipMemoryRangeToBounds =====
; Rejects a (start,length) range outside the supplied bounds; trims a range that crosses the upper bound.
; 将越出给定边界的（起始地址、长度）范围置零；超过上界时截短长度。
.func P1_ClipMemoryRangeToBounds
loc_02327960:
	push {r4,r5}	; 02327960
	ldr r5,[r0,#0x0]	; 02327962
	ldr r3,[r0,#0x4]	; 02327964
	add r4,r5,r3	; 02327966
	cmp r5,r1	; 02327968
	bcc loc_02327970	; 0232796A
	cmp r5,r2	; 0232796C
	bls loc_02327978	; 0232796E
loc_02327970:
	mov r1,#0x0	; 02327970
	str r1,[r0,#0x4]	; 02327972
	pop {r4,r5}	; 02327974
	bx lr	; 02327976
loc_02327978:
	cmp r4,r2	; 02327978
	bls loc_02327982	; 0232797A
	sub r1,r4,r2	; 0232797C
	sub r1,r3,r1	; 0232797E
	str r1,[r0,#0x4]	; 02327980
loc_02327982:
	pop {r4,r5}	; 02327982
	bx lr	; 02327984
.endfunc
	.byte 0x00, 0x00	; 02327988

; ===== function P1_ConstrainNdsHeaderImageLoadRanges =====
; Constrains ARM7/ARM9 image load ranges recorded in the copied NDS card header before boot.
; 启动前约束复制到 RAM 的 NDS 卡带头内 ARM7/ARM9 映像装载范围。
.func P1_ConstrainNdsHeaderImageLoadRanges
loc_02327988:
	push {lr}	; 02327988
	sub sp,#0x4	; 0232798A
	bl loc_02326FAC	; 0232798C
	cmp r0,#0x0	; 02327990
	beq loc_023279F4	; 02327992
	ldr r0,[pool_023279FC]	; 02327994
	ldr r2,[r0,#0x0]	; 02327996
	ldr r1,[pool_02327A00]	; 02327998
	cmp r2,r1	; 0232799A
	bcc loc_023279B2	; 0232799C
	ldr r2,[pool_02327A04]	; 0232799E
	bl P1_ClipMemoryRangeToBounds	; 023279A0
	ldr r2,[pool_023279FC]	; 023279A4
	ldr r1,[r2,#0x0]	; 023279A6
	ldr r0,[pool_02327A08]	; 023279A8
	str r1,[r0,#0x0]	; 023279AA
	ldr r0,[pool_02327A0C]	; 023279AC
	str r0,[r2,#0x0]	; 023279AE
	b loc_023279EA	; 023279B0
loc_023279B2:
	ldr r1,[pool_02327A10]	; 023279B2
	ldr r2,[pool_02327A14]	; 023279B4
	bl P1_ClipMemoryRangeToBounds	; 023279B6
	ldr r1,[pool_023279FC]	; 023279BA
	ldr r3,[r1,#0x0]	; 023279BC
	ldr r0,[pool_02327A18]	; 023279BE
	cmp r3,r0	; 023279C0
	bcc loc_023279DA	; 023279C2
	ldr r0,[pool_02327A08]	; 023279C4
	str r3,[r0,#0x0]	; 023279C6
	ldr r0,[pool_02327A0C]	; 023279C8
	str r0,[r1,#0x0]	; 023279CA
	ldr r2,[pool_02327A1C]	; 023279CC
	ldr r1,[r2,#0x0]	; 023279CE
	ldr r0,[pool_02327A20]	; 023279D0
	cmp r1,r0	; 023279D2
	bls loc_023279EA	; 023279D4
	str r0,[r2,#0x0]	; 023279D6
	b loc_023279EA	; 023279D8
loc_023279DA:
	ldr r2,[pool_02327A1C]	; 023279DA
	ldr r1,[r2,#0x0]	; 023279DC
	add r3,r3,r1	; 023279DE
	cmp r3,r0	; 023279E0
	bls loc_023279EA	; 023279E2
	sub r0,r3,r0	; 023279E4
	sub r0,r1,r0	; 023279E6
	str r0,[r2,#0x0]	; 023279E8
loc_023279EA:
	ldr r0,[pool_02327A24]	; 023279EA
	ldr r1,[pool_02327A10]	; 023279EC
	ldr r2,[pool_02327A0C]	; 023279EE
	bl P1_ClipMemoryRangeToBounds	; 023279F0
loc_023279F4:
	add sp,#0x4	; 023279F4
	pop {r3}	; 023279F6
	bx r3	; 023279F8
.endfunc
	.byte 0xC0, 0x46	; 023279FC
pool_023279FC:
loc_023279FC:
	.word NdsCartHeaderArm7RamAddress	; 023279FC
pool_02327A00:
loc_02327A00:
	.word 0x037F8000	; 02327A00
pool_02327A04:
loc_02327A04:
	.word 0x0380F000	; 02327A04
pool_02327A08:
loc_02327A08:
	.word 0x027FF860	; 02327A08
pool_02327A0C:
loc_02327A0C:
	.word 0x022C0000	; 02327A0C
pool_02327A10:
loc_02327A10:
	.word 0x02000000	; 02327A10
pool_02327A14:
loc_02327A14:
	.word 0x023FE000	; 02327A14
pool_02327A18:
loc_02327A18:
	.word 0x02300000	; 02327A18
pool_02327A1C:
loc_02327A1C:
	.word NdsCartHeaderArm7SizeAddress	; 02327A1C
pool_02327A20:
loc_02327A20:
	.word 0x00040000	; 02327A20
pool_02327A24:
loc_02327A24:
	.word NdsCartHeaderArm9RamAddress	; 02327A24

; ===== function loc_02327A28 =====
loc_02327A28:
	push {r4,lr}	; 02327A28
	sub sp,#0x8	; 02327A2A
	add r4,r0,#0x0	; 02327A2C
	ldr r2,[pool_02327AA0]	; 02327A2E
	ldrh r1,[r2,#0x0]	; 02327A30
	ldr r0,[pool_02327AA4]	; 02327A32
	orr r1,r0	; 02327A34
	strh r1,[r2,#0x0]	; 02327A36
	ldrh r1,[r2,#0x0]	; 02327A38
	mov r0,#0xc	; 02327A3A
	bic r1,r0	; 02327A3C
	strh r1,[r2,#0x0]	; 02327A3E
	ldrh r1,[r2,#0x0]	; 02327A40
	mov r0,#0x10	; 02327A42
	bic r1,r0	; 02327A44
	strh r1,[r2,#0x0]	; 02327A46
	mov r0,#0x3	; 02327A48
	bl loc_0232DD48	; 02327A4A
	ldr r0,[pool_02327AA8]	; 02327A4E
	ldr r1,[pool_02327AAC]	; 02327A50
	blx P1_InvalidateDataCacheRange	; 02327A52
	mov r0,#0x0	; 02327A56
	str r0,[sp,#0x0]	; 02327A58
	add r0,sp,#0x0	; 02327A5A
	ldr r1,[pool_02327AB0]	; 02327A5C
	ldr r2,[pool_02327AB4]	; 02327A5E
	bl loc_0232C7DA	; 02327A60
	ldr r0,[pool_02327AB8]	; 02327A64
	str r4,[r0,#0x0]	; 02327A66
	mov r1,#0x1	; 02327A68
	ldr r0,[pool_02327ABC]	; 02327A6A
	str r1,[r0,#0x0]	; 02327A6C
	bl P1_ConstrainNdsHeaderImageLoadRanges	; 02327A6E
	bl loc_02326E60	; 02327A72
	ldr r0,[pool_02327AC0]	; 02327A76
	add r0,#0x19	; 02327A78
	mov r1,#0x0	; 02327A7A
	mov r2,#0x37	; 02327A7C
	blx loc_0232DEFC	; 02327A7E
	ldr r1,[pool_02327AC4]	; 02327A82
	mov r0,#0x0	; 02327A84
	ldrsh r0,[r1,r0]	; 02327A86
	cmp r0,#0x0	; 02327A88
	bne loc_02327A96	; 02327A8A
	ldr r2,[pool_02327AC8]	; 02327A8C
	ldr r1,[r2,#0x0]	; 02327A8E
	ldr r0,[pool_02327ACC]	; 02327A90
	orr r1,r0	; 02327A92
	str r1,[r2,#0x0]	; 02327A94
loc_02327A96:
	add sp,#0x8	; 02327A96
	pop {r4}	; 02327A98
	pop {r3}	; 02327A9A
	bx r3	; 02327A9C
	.byte 0xC0, 0x46	; 02327AA0
pool_02327AA0:
loc_02327AA0:
	.word REG_EXMEMCNT_ARM9	; 02327AA0
pool_02327AA4:
loc_02327AA4:
	.word 0x00008000	; 02327AA4
pool_02327AA8:
loc_02327AA8:
	.word 0x022C0000	; 02327AA8
pool_02327AAC:
loc_02327AAC:
	.word 0x00040000	; 02327AAC
pool_02327AB0:
loc_02327AB0:
	.word 0x027FF860	; 02327AB0
pool_02327AB4:
loc_02327AB4:
	.word 0x0100001B	; 02327AB4
pool_02327AB8:
loc_02327AB8:
	.word P1_BssStart + 0x24E28	; 02327AB8
pool_02327ABC:
loc_02327ABC:
	.word 0x027FF880	; 02327ABC
pool_02327AC0:
loc_02327AC0:
	.word 0x027FF800	; 02327AC0
pool_02327AC4:
loc_02327AC4:
	.word 0x027FF814	; 02327AC4
pool_02327AC8:
loc_02327AC8:
	.word NdsCartHeaderRamAddress + 0x60	; 02327AC8
pool_02327ACC:
loc_02327ACC:
	.word 0x00406000	; 02327ACC

; ===== function loc_02327AD0 =====
loc_02327AD0:
	push {r4,r5}	; 02327AD0
	mov r2,#0x80	; 02327AD2
	ldr r1,[pool_02327B00]	; 02327AD4
	strb r2,[r1,#0x0]	; 02327AD6
	mov r2,#0x0	; 02327AD8
	ldr r1,[pool_02327B04]	; 02327ADA
	mov r3,#0x1	; 02327ADC
loc_02327ADE:
	sub r4,r3,r2	; 02327ADE
	lsl r4,r4,#0x2	; 02327AE0
	ldr r5,[r0,r4]	; 02327AE2
	lsr r4,r5,#0x18	; 02327AE4
	strb r4,[r1,#0x0]	; 02327AE6
	lsr r4,r5,#0x10	; 02327AE8
	strb r4,[r1,#0x1]	; 02327AEA
	lsr r4,r5,#0x8	; 02327AEC
	strb r4,[r1,#0x2]	; 02327AEE
	strb r5,[r1,#0x3]	; 02327AF0
	add r1,r1,#0x4	; 02327AF2
	add r2,r2,#0x1	; 02327AF4
	cmp r2,#0x2	; 02327AF6
	blt loc_02327ADE	; 02327AF8
	pop {r4,r5}	; 02327AFA
	bx lr	; 02327AFC
	.byte 0xC0, 0x46	; 02327B00
pool_02327B00:
loc_02327B00:
	.word REG_AUXSPICNT + 1	; 02327B00
pool_02327B04:
loc_02327B04:
	.word REG_GCCMDOUT	; 02327B04

; ===== function loc_02327B08 =====
loc_02327B08:
	push {r4,r5,r6,r7,lr}	; 02327B08
	sub sp,#0xc	; 02327B0A
	add r5,r1,#0x0	; 02327B0C
	add r4,r2,#0x0	; 02327B0E
	lsl r1,r0,#0x18	; 02327B10
	str r1,[sp,#0x0]	; 02327B12
	lsr r1,r0,#0x8	; 02327B14
	ldr r0,[pool_02327B58]	; 02327B16
	orr r1,r0	; 02327B18
	str r1,[sp,#0x4]	; 02327B1A
	add r0,sp,#0x0	; 02327B1C
	bl loc_02327AD0	; 02327B1E
	ldr r0,[pool_02327B5C]	; 02327B22
	ldr r1,[r0,#0x0]	; 02327B24
	ldr r0,[pool_02327B60]	; 02327B26
	orr r1,r0	; 02327B28
	ldr r0,[pool_02327B64]	; 02327B2A
	str r1,[r0,#0x0]	; 02327B2C
	add r2,r5,r4	; 02327B2E
	ldr r7,[pool_02327B68]	; 02327B30
	ldr r3,[pool_02327B6C]	; 02327B32
	ldr r4,[pool_02327B70]	; 02327B34
loc_02327B36:
	ldr r1,[r0,#0x0]	; 02327B36
	add r6,r1,#0x0	; 02327B38
	and r6,r4	; 02327B3A
	cmp r6,#0x0	; 02327B3C
	beq loc_02327B4A	; 02327B3E
	ldr r6,[r7,#0x0]	; 02327B40
	cmp r5,r2	; 02327B42
	bcs loc_02327B48	; 02327B44
	str r6,[r5,#0x0]	; 02327B46
loc_02327B48:
	add r5,r5,#0x4	; 02327B48
loc_02327B4A:
	and r1,r3	; 02327B4A
	cmp r1,#0x0	; 02327B4C
	bne loc_02327B36	; 02327B4E
	add sp,#0xc	; 02327B50
	pop {r4,r5,r6,r7}	; 02327B52
	pop {r3}	; 02327B54
	bx r3	; 02327B56
pool_02327B58:
loc_02327B58:
	.word 0xB7000000	; 02327B58
pool_02327B5C:
loc_02327B5C:
	.word NdsCartHeaderRamAddress + 0x60	; 02327B5C
pool_02327B60:
loc_02327B60:
	.word 0xA1000000	; 02327B60
pool_02327B64:
loc_02327B64:
	.word REG_ROMCTRL	; 02327B64
pool_02327B68:
loc_02327B68:
	.word REG_GCDATAIN	; 02327B68
pool_02327B6C:
loc_02327B6C:
	.word 0x80000000	; 02327B6C
pool_02327B70:
loc_02327B70:
	.word 0x00800000	; 02327B70

; ===== function loc_02327B74 =====
loc_02327B74:
	push {r4,r5,r6,r7,lr}	; 02327B74
	sub sp,#0x4	; 02327B76
	add r6,r0,#0x0	; 02327B78
	add r7,r1,#0x0	; 02327B7A
	add r5,r2,#0x0	; 02327B7C
	add r4,r5,#0x0	; 02327B7E
	cmp r5,#0x0	; 02327B80
	ble loc_02327BA4	; 02327B82
loc_02327B84:
	ldr r0,[pool_02327BAC]	; 02327B84
	cmp r4,r0	; 02327B86
	blt loc_02327B8E	; 02327B88
	lsl r5,r0,#0	; 02327B8A
	b loc_02327B90	; 02327B8C
loc_02327B8E:
	add r5,r4,#0x0	; 02327B8E
loc_02327B90:
	add r0,r6,#0x0	; 02327B90
	add r1,r7,#0x0	; 02327B92
	add r2,r5,#0x0	; 02327B94
	bl loc_02327B08	; 02327B96
	add r6,r6,r5	; 02327B9A
	add r7,r7,r5	; 02327B9C
	sub r4,r4,r5	; 02327B9E
	cmp r4,#0x0	; 02327BA0
	bgt loc_02327B84	; 02327BA2
loc_02327BA4:
	add sp,#0x4	; 02327BA4
	pop {r4,r5,r6,r7}	; 02327BA6
	pop {r3}	; 02327BA8
	bx r3	; 02327BAA
pool_02327BAC:
loc_02327BAC:
	.word 0x00000200	; 02327BAC

; ===== function loc_02327BB0 =====
loc_02327BB0:
	push {lr}	; 02327BB0
	sub sp,#0xc	; 02327BB2
	mov r0,#0x0	; 02327BB4
	str r0,[sp,#0x0]	; 02327BB6
	ldr r0,[pool_02327BD4]	; 02327BB8
	str r0,[sp,#0x4]	; 02327BBA
	add r0,sp,#0x0	; 02327BBC
	bl loc_02327AD0	; 02327BBE
	ldr r0,[pool_02327BD8]	; 02327BC2
	ldr r1,[r0,#0x4]	; 02327BC4
	ldr r0,[pool_02327BDC]	; 02327BC6
	orr r1,r0	; 02327BC8
	ldr r0,[pool_02327BE0]	; 02327BCA
	str r1,[r0,#0x0]	; 02327BCC
	add sp,#0xc	; 02327BCE
	pop {r3}	; 02327BD0
	bx r3	; 02327BD2
pool_02327BD4:
loc_02327BD4:
	.word 0xB8000000	; 02327BD4
pool_02327BD8:
loc_02327BD8:
	.word P1_BssStart + 0x25740	; 02327BD8
pool_02327BDC:
loc_02327BDC:
	.word 0xA7000000	; 02327BDC
pool_02327BE0:
loc_02327BE0:
	.word REG_ROMCTRL	; 02327BE0

; ===== function loc_02327BE4 =====
loc_02327BE4:
	ldr r0,[pool_02327BF8]	; 02327BE4
	ldr r1,[r0,#0x0]	; 02327BE6
	ldr r0,[pool_02327BFC]	; 02327BE8
	and r1,r0	; 02327BEA
	cmp r1,#0x0	; 02327BEC
	beq loc_02327BF4	; 02327BEE
	mov r0,#0x1	; 02327BF0
	bx lr	; 02327BF2
loc_02327BF4:
	mov r0,#0x0	; 02327BF4
	bx lr	; 02327BF6
pool_02327BF8:
loc_02327BF8:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327BF8
pool_02327BFC:
loc_02327BFC:
	.word 0x00000200	; 02327BFC

; ===== function loc_02327C00 =====
loc_02327C00:
	ldr r0,[pool_02327C10]	; 02327C00
	ldr r0,[r0,#0x0]	; 02327C02
	cmp r0,#0x1	; 02327C04
	bne loc_02327C0C	; 02327C06
	mov r0,#0x1	; 02327C08
	bx lr	; 02327C0A
loc_02327C0C:
	mov r0,#0x0	; 02327C0C
	bx lr	; 02327C0E
pool_02327C10:
loc_02327C10:
	.word P1_BssStart + 0x25740	; 02327C10

; ===== function loc_02327C14 =====
loc_02327C14:
	push {lr}	; 02327C14
	sub sp,#0x4	; 02327C16
	bl loc_02327C00	; 02327C18
	cmp r0,#0x0	; 02327C1C
	beq loc_02327C2C	; 02327C1E
loc_02327C20:
	bl loc_02327C34	; 02327C20
	bl loc_02327C00	; 02327C24
	cmp r0,#0x0	; 02327C28
	bne loc_02327C20	; 02327C2A
loc_02327C2C:
	add sp,#0x4	; 02327C2C
	pop {r3}	; 02327C2E
	bx r3	; 02327C30
	.byte 0x00, 0x00	; 02327C34

; ===== function loc_02327C34 =====
loc_02327C34:
	push {lr}	; 02327C34
	sub sp,#0x4	; 02327C36
	bl loc_02327BE4	; 02327C38
	cmp r0,#0x0	; 02327C3C
	bne loc_02327C48	; 02327C3E
	mov r0,#0x0	; 02327C40
	add sp,#0x4	; 02327C42
	pop {r3}	; 02327C44
	bx r3	; 02327C46
loc_02327C48:
	ldr r0,[pool_02327CB8]	; 02327C48
	ldr r1,[r0,#0x0]	; 02327C4A
	cmp r1,#0x0	; 02327C4C
	beq loc_02327C56	; 02327C4E
	cmp r1,#0x1	; 02327C50
	beq loc_02327C6C	; 02327C52
	b loc_02327CAE	; 02327C54
loc_02327C56:
	ldrh r0,[r0,#0x8]	; 02327C56
	bl loc_0232B334	; 02327C58
	cmp r0,#0x0	; 02327C5C
	bne loc_02327CAE	; 02327C5E
	bl loc_02327BB0	; 02327C60
	mov r1,#0x1	; 02327C64
	ldr r0,[pool_02327CB8]	; 02327C66
	str r1,[r0,#0x0]	; 02327C68
	b loc_02327CAE	; 02327C6A
loc_02327C6C:
	ldr r0,[pool_02327CBC]	; 02327C6C
	ldr r1,[r0,#0x0]	; 02327C6E
	ldr r0,[pool_02327CC0]	; 02327C70
	and r1,r0	; 02327C72
	cmp r1,#0x0	; 02327C74
	beq loc_02327CAE	; 02327C76
	ldr r0,[pool_02327CC4]	; 02327C78
	ldr r1,[r0,#0x0]	; 02327C7A
	ldr r0,[pool_02327CC8]	; 02327C7C
	ldr r0,[r0,#0x0]	; 02327C7E
	cmp r1,r0	; 02327C80
	beq loc_02327CA0	; 02327C82
	ldr r0,[pool_02327CCC]	; 02327C84
	ldr r1,[r0,#0x0]	; 02327C86
	mov r0,#0x2	; 02327C88
	and r1,r0	; 02327C8A
	cmp r1,#0x0	; 02327C8C
	beq loc_02327C94	; 02327C8E
	mov r0,#0x1	; 02327C90
	b loc_02327C96	; 02327C92
loc_02327C94:
	mov r0,#0x0	; 02327C94
loc_02327C96:
	cmp r0,#0x0	; 02327C96
	beq loc_02327CA0	; 02327C98
	mov r1,#0x1	; 02327C9A
	ldr r0,[pool_02327CB8]	; 02327C9C
	strh r1,[r0,#0xa]	; 02327C9E
loc_02327CA0:
	ldr r0,[pool_02327CB8]	; 02327CA0
	ldrh r0,[r0,#0x8]	; 02327CA2
	bl loc_0232B348	; 02327CA4
	mov r1,#0x0	; 02327CA8
	ldr r0,[pool_02327CB8]	; 02327CAA
	str r1,[r0,#0x0]	; 02327CAC
loc_02327CAE:
	ldr r0,[pool_02327CB8]	; 02327CAE
	ldrh r0,[r0,#0xa]	; 02327CB0
	add sp,#0x4	; 02327CB2
	pop {r3}	; 02327CB4
	bx r3	; 02327CB6
pool_02327CB8:
loc_02327CB8:
	.word P1_BssStart + 0x25740	; 02327CB8
pool_02327CBC:
loc_02327CBC:
	.word REG_ROMCTRL	; 02327CBC
pool_02327CC0:
loc_02327CC0:
	.word 0x00800000	; 02327CC0
pool_02327CC4:
loc_02327CC4:
	.word REG_GCDATAIN	; 02327CC4
pool_02327CC8:
loc_02327CC8:
	.word 0x027FF800	; 02327CC8
pool_02327CCC:
loc_02327CCC:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327CCC

; ===== function loc_02327CD0 =====
loc_02327CD0:
	push {lr}	; 02327CD0
	sub sp,#0x4	; 02327CD2
	blx loc_0232B270	; 02327CD4
	ldr r1,[pool_02327CE8]	; 02327CD8
	strh r0,[r1,#0x8]	; 02327CDA
	ldr r0,[pool_02327CEC]	; 02327CDC
	ldr r0,[r0,#0x0]	; 02327CDE
	str r0,[r1,#0x4]	; 02327CE0
	add sp,#0x4	; 02327CE2
	pop {r3}	; 02327CE4
	bx r3	; 02327CE6
pool_02327CE8:
loc_02327CE8:
	.word P1_BssStart + 0x25740	; 02327CE8
pool_02327CEC:
loc_02327CEC:
	.word NdsCartHeaderRamAddress + 0x60	; 02327CEC
.arm
	mov r0,#0x0	; 02327CF0
	mcr p15,0x0,r0,c7,c6,0x0	; 02327CF4
	ldr r1,[pool_02327D70]	; 02327CF8
loc_02327CFC:
	ldrh r0,[r1,#0x0]	; 02327CFC
	and r0,r0,#0xf	; 02327D00
	cmp r0,#0x2	; 02327D04
	bne loc_02327CFC	; 02327D08
	mov r0,#0x200	; 02327D0C
	strh r0,[r1,#0x0]	; 02327D10
	ldr r1,[pool_02327D70]	; 02327D14
loc_02327D18:
	ldrh r0,[r1,#0x0]	; 02327D18
	and r0,r0,#0xf	; 02327D1C
	cmp r0,#0x1	; 02327D20
	bne loc_02327D18	; 02327D24
	mov r0,#0x100	; 02327D28
	strh r0,[r1,#0x0]	; 02327D2C
	bl loc_02327DA4	; 02327D30
	bl loc_02327D7C	; 02327D34
	ldr r1,[pool_02327D70]	; 02327D38
loc_02327D3C:
	ldrh r0,[r1,#0x0]	; 02327D3C
	and r0,r0,#0xf	; 02327D40
	cmp r0,#0x1	; 02327D44
	beq loc_02327D3C	; 02327D48
	mov r0,#0x0	; 02327D4C
	strh r0,[r1,#0x0]	; 02327D50
	ldr r3,[pool_02327D74]	; 02327D54
	ldr r12,[r3,#-0x1dc]	; 02327D58
	mov lr,r12	; 02327D5C
	ldr r11,[pool_02327D78]	; 02327D60
	ldmia r11,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10}	; 02327D64
	mov r11,#0x0	; 02327D68
	bx r12	; 02327D6C
pool_02327D70:
loc_02327D70:
	.word REG_IPC_SYNC	; 02327D70
pool_02327D74:
loc_02327D74:
; 基准为头部 RAM 视图 +0x200；负偏移实际读取 ARM9/ARM7 入口字段。
; Addressing anchor: the negative offset above reads the ARM9/ARM7 entry field.
	.word NdsCartHeaderRamAddress + 0x200	; 02327D74
pool_02327D78:
loc_02327D78:
	.word 0x03000000	; 02327D78

; ===== function loc_02327D7C =====
loc_02327D7C:
	ldr r0,[pool_02327DA0]	; 02327D7C
	mcr p15,0x0,r0,c1,c0,0x0	; 02327D80
	mov r0,#0x0	; 02327D84
	mcr p15,0x0,r0,c6,c5,0x0	; 02327D88
	mov r0,#0x0	; 02327D8C
	mcr p15,0x0,r0,c7,c5,0x0	; 02327D90
	mcr p15,0x0,r0,c7,c6,0x0	; 02327D94
	mcr p15,0x0,r0,c7,c10,0x4	; 02327D98
	bx lr	; 02327D9C
pool_02327DA0:
loc_02327DA0:
	.word 0x00012078	; 02327DA0

; ===== function loc_02327DA4 =====
loc_02327DA4:
	mov r12,lr	; 02327DA4
	mov r0,#0xd3	; 02327DA8
	msr cpsr_cxsf,r0	; 02327DAC
	ldr r0,[pool_02327E14]	; 02327DB0
	add r0,r0,#0x3fc0	; 02327DB4
	mov sp,r0	; 02327DB8
	mov lr,#0x0	; 02327DBC
	msr spsr_cxsf,lr	; 02327DC0
	mov r0,#0xd2	; 02327DC4
	msr cpsr_cxsf,r0	; 02327DC8
	ldr r0,[pool_02327E14]	; 02327DCC
	add r0,r0,#0x3fc0	; 02327DD0
	sub r0,r0,#0x40	; 02327DD4
	mov sp,r0	; 02327DD8
	mov lr,#0x0	; 02327DDC
	msr spsr_cxsf,lr	; 02327DE0
	ldr r1,[pool_02327E18]	; 02327DE4
	sub r1,r0,r1	; 02327DE8
	mov r0,#0xdf	; 02327DEC
	msr cpsr_cxsf,r0	; 02327DF0
	sub sp,r1,#0x4	; 02327DF4
	ldr r0,[pool_02327E1C]	; 02327DF8
	mov r1,#0x8000	; 02327DFC
	bl loc_02327E20	; 02327E00
	ldr r0,[pool_02327E14]	; 02327E04
	mov r1,#0x4000	; 02327E08
	bl loc_02327E20	; 02327E0C
	bx r12	; 02327E10
pool_02327E14:
loc_02327E14:
	.word 0x03000000	; 02327E14
pool_02327E18:
loc_02327E18:
	.word 0x00001000	; 02327E18
pool_02327E1C:
loc_02327E1C:
	.word 0x01FF8000	; 02327E1C

; ===== function loc_02327E20 =====
loc_02327E20:
	add r2,r0,r1	; 02327E20
	mov r1,r1, lsr #0x5	; 02327E24
	mov r3,#0x0	; 02327E28
	mov r4,r3	; 02327E2C
	mov r5,r3	; 02327E30
	mov r6,r3	; 02327E34
	mov r7,r3	; 02327E38
	mov r8,r3	; 02327E3C
	mov r9,r3	; 02327E40
	mov r10,r3	; 02327E44
loc_02327E48:
	cmp r0,r2	; 02327E48
	stmltia r0!,{r3,r4,r5,r6,r7,r8,r9,r10}	; 02327E4C
	blt loc_02327E48	; 02327E50
	bx lr	; 02327E54
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 02327E5C
.thumb
P1_PxiCallback_02327E5C:
	push {r4}	; 02327E5C
	sub sp,#0x4	; 02327E5E
	mov r4,#0xff	; 02327E60
	and r1,r4	; 02327E62
	ldr r3,[pool_02327E80]	; 02327E64
	strh r1,[r3,#0x0]	; 02327E66
	mov r1,#0x1	; 02327E68
	ldr r0,[pool_02327E84]	; 02327E6A
	str r1,[r0,#0x0]	; 02327E6C
	cmp r2,#0x0	; 02327E6E
	beq loc_02327E74	; 02327E70
	strh r4,[r3,#0x0]	; 02327E72
loc_02327E74:
	ldr r0,[pool_02327E80]	; 02327E74
	ldrh r0,[r0,#0x0]	; 02327E76
	add sp,#0x4	; 02327E78
	pop {r4}	; 02327E7A
	bx lr	; 02327E7C
	.byte 0xC0, 0x46	; 02327E80
pool_02327E80:
loc_02327E80:
	.word P1_BssStart + 0x2574C	; 02327E80
pool_02327E84:
loc_02327E84:
	.word P1_BssStart + 0x25754	; 02327E84

; ===== function loc_02327E88 =====
loc_02327E88:
	push {r4,r5,r6,r7,lr}	; 02327E88
	sub sp,#0xb4	; 02327E8A
	add r6,r0,#0x0	; 02327E8C
	str r1,[sp,#0x0]	; 02327E8E
	str r2,[sp,#0x4]	; 02327E90
	str r3,[sp,#0x8]	; 02327E92
	mov r4,#0x0	; 02327E94
	lsl r0,r1,#0	; 02327E96
	lsr r0,r0,#0x10	; 02327E98
	str r0,[sp,#0x2c]	; 02327E9A
	mov r1,#0xff	; 02327E9C
	and r0,r1	; 02327E9E
	str r0,[sp,#0x2c]	; 02327EA0
	ldr r1,[pool_023281A8]	; 02327EA2
	str r0,[sp,#0x1c]	; 02327EA4
	orr r0,r1	; 02327EA6
	str r0,[sp,#0x1c]	; 02327EA8
	ldr r0,[pool_023281AC]	; 02327EAA
	ldr r1,[sp,#0x0]	; 02327EAC
	and r1,r0	; 02327EAE
	str r1,[sp,#0x0]	; 02327EB0
	ldr r1,[pool_023281B0]	; 02327EB2
	ldr r2,[sp,#0x0]	; 02327EB4
	orr r2,r1	; 02327EB6
	str r2,[sp,#0x0]	; 02327EB8
	ldr r2,[sp,#0x4]	; 02327EBA
	str r2,[sp,#0x20]	; 02327EBC
	and r2,r0	; 02327EBE
	str r2,[sp,#0x20]	; 02327EC0
	ldr r5,[pool_023281B4]	; 02327EC2
	orr r2,r5	; 02327EC4
	str r2,[sp,#0x20]	; 02327EC6
	lsl r2,r3,#0	; 02327EC8
	lsr r2,r2,#0x10	; 02327ECA
	str r2,[sp,#0x30]	; 02327ECC
	ldr r3,[pool_023281B8]	; 02327ECE
	str r2,[sp,#0x24]	; 02327ED0
	orr r2,r3	; 02327ED2
	str r2,[sp,#0x24]	; 02327ED4
	ldr r2,[sp,#0x8]	; 02327ED6
	and r2,r0	; 02327ED8
	str r2,[sp,#0x8]	; 02327EDA
	ldr r3,[pool_023281BC]	; 02327EDC
	str r2,[sp,#0x28]	; 02327EDE
	orr r2,r3	; 02327EE0
	str r2,[sp,#0x28]	; 02327EE2
	ldr r3,[pool_023281C0]	; 02327EE4
	ldr r2,[sp,#0x2c]	; 02327EE6
	orr r2,r3	; 02327EE8
	str r2,[sp,#0x2c]	; 02327EEA
	ldr r3,[sp,#0x4]	; 02327EEC
	ldr r2,[pool_023281C4]	; 02327EEE
	orr r3,r2	; 02327EF0
	str r3,[sp,#0x4]	; 02327EF2
	ldr r2,[sp,#0x30]	; 02327EF4
	orr r2,r5	; 02327EF6
	str r2,[sp,#0x30]	; 02327EF8
	ldr r3,[pool_023281C8]	; 02327EFA
	ldr r2,[sp,#0x8]	; 02327EFC
	orr r2,r3	; 02327EFE
	str r2,[sp,#0x8]	; 02327F00
	ldr r2,[pool_023281CC]	; 02327F02
	lsr r2,r2,#0x18	; 02327F04
	str r2,[sp,#0x34]	; 02327F06
	ldr r3,[pool_023281D0]	; 02327F08
	orr r2,r3	; 02327F0A
	str r2,[sp,#0x34]	; 02327F0C
	ldr r2,[pool_023281CC]	; 02327F0E
	lsr r2,r2,#0x8	; 02327F10
	str r2,[sp,#0x38]	; 02327F12
	and r2,r0	; 02327F14
	str r2,[sp,#0x38]	; 02327F16
	orr r2,r1	; 02327F18
	str r2,[sp,#0x38]	; 02327F1A
	ldr r0,[pool_023281CC]	; 02327F1C
	lsl r0,r0,#0x8	; 02327F1E
	str r0,[sp,#0x3c]	; 02327F20
	ldr r1,[pool_023281D4]	; 02327F22
	and r0,r1	; 02327F24
	str r0,[sp,#0x3c]	; 02327F26
	ldr r1,[pool_023281D8]	; 02327F28
	orr r0,r1	; 02327F2A
	str r0,[sp,#0x3c]	; 02327F2C
	str r4,[sp,#0xb0]	; 02327F2E
	str r4,[sp,#0xac]	; 02327F30
	mov r5,#0x4	; 02327F32
	str r4,[sp,#0xa8]	; 02327F34
	str r4,[sp,#0x98]	; 02327F36
	str r4,[sp,#0xa0]	; 02327F38
	str r4,[sp,#0xa4]	; 02327F3A
	str r4,[sp,#0x9c]	; 02327F3C
	str r4,[sp,#0x94]	; 02327F3E
	str r4,[sp,#0x74]	; 02327F40
	str r4,[sp,#0x7c]	; 02327F42
	str r4,[sp,#0x84]	; 02327F44
	str r4,[sp,#0x8c]	; 02327F46
	str r4,[sp,#0x90]	; 02327F48
	str r4,[sp,#0x88]	; 02327F4A
	str r4,[sp,#0x80]	; 02327F4C
	str r4,[sp,#0x78]	; 02327F4E
	str r4,[sp,#0x70]	; 02327F50
	str r4,[sp,#0x6c]	; 02327F52
	str r4,[sp,#0x44]	; 02327F54
	str r4,[sp,#0x4c]	; 02327F56
	str r4,[sp,#0x54]	; 02327F58
	str r4,[sp,#0x5c]	; 02327F5A
	str r4,[sp,#0x64]	; 02327F5C
	str r4,[sp,#0x68]	; 02327F5E
	str r4,[sp,#0x60]	; 02327F60
	str r4,[sp,#0x58]	; 02327F62
	str r4,[sp,#0x50]	; 02327F64
	str r4,[sp,#0x48]	; 02327F66
	str r4,[sp,#0x40]	; 02327F68
	add r7,r4,#0x0	; 02327F6A
loc_02327F6C:
	cmp r4,#0x0	; 02327F6C
	beq loc_02327F72	; 02327F6E
	b loc_023280D2	; 02327F70
loc_02327F72:
	ldr r0,[pool_023281DC]	; 02327F72
	str r7,[r0,#0x0]	; 02327F74
	cmp r6,#0x6	; 02327F76
	bhi loc_02327F6C	; 02327F78
	add r0,r6,r6	; 02327F7A
P1_SwitchIndexPC_02327F7A:
	add r0,pc	; 02327F7C
	ldrh r0,[r0,#(P1_SwitchTable_02327F7A - (P1_SwitchIndexPC_02327F7A + 4))]	; 02327F7E
	lsl r0,r0,#0x10	; 02327F80
	asr r0,r0,#0x10	; 02327F82
P1_SwitchTargetPC_02327F7A:
	add r0,pc	; 02327F84
	bx r0	; 02327F86
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02327F7A:
	.halfword (loc_02327F6C + 1) - (P1_SwitchTargetPC_02327F7A + 4)
	.halfword (loc_02327F96 + 1) - (P1_SwitchTargetPC_02327F7A + 4)
	.halfword (loc_02328006 + 1) - (P1_SwitchTargetPC_02327F7A + 4)
	.halfword (loc_0232801C + 1) - (P1_SwitchTargetPC_02327F7A + 4)
	.halfword (loc_02328082 + 1) - (P1_SwitchTargetPC_02327F7A + 4)
	.halfword (loc_02328082 + 1) - (P1_SwitchTargetPC_02327F7A + 4)
	.halfword (loc_023280BC + 1) - (P1_SwitchTargetPC_02327F7A + 4)
P1_SwitchTable_02327F7AEnd:
loc_02327F96:
	add r0,r5,#0x0	; 02327F96
	ldr r1,[sp,#0x1c]	; 02327F98
	add r2,r7,#0x0	; 02327F9A
	bl loc_0232E8C4	; 02327F9C
	cmp r0,#0x0	; 02327FA0
	bge loc_02327FA8	; 02327FA2
	ldr r4,[sp,#0x40]	; 02327FA4
	b loc_02327F6C	; 02327FA6
loc_02327FA8:
	add r0,r5,#0x0	; 02327FA8
	ldr r1,[sp,#0x0]	; 02327FAA
	ldr r2,[sp,#0x44]	; 02327FAC
	bl loc_0232E8C4	; 02327FAE
	cmp r0,#0x0	; 02327FB2
	bge loc_02327FBA	; 02327FB4
	ldr r4,[sp,#0x48]	; 02327FB6
	b loc_02327F6C	; 02327FB8
loc_02327FBA:
	add r0,r5,#0x0	; 02327FBA
	ldr r1,[pool_023281C4]	; 02327FBC
	ldr r2,[sp,#0x4c]	; 02327FBE
	bl loc_0232E8C4	; 02327FC0
	cmp r0,#0x0	; 02327FC4
	bge loc_02327FCC	; 02327FC6
	ldr r4,[sp,#0x50]	; 02327FC8
	b loc_02327F6C	; 02327FCA
loc_02327FCC:
	add r0,r5,#0x0	; 02327FCC
	ldr r1,[sp,#0x20]	; 02327FCE
	ldr r2,[sp,#0x54]	; 02327FD0
	bl loc_0232E8C4	; 02327FD2
	cmp r0,#0x0	; 02327FD6
	bge loc_02327FDE	; 02327FD8
	ldr r4,[sp,#0x58]	; 02327FDA
	b loc_02327F6C	; 02327FDC
loc_02327FDE:
	add r0,r5,#0x0	; 02327FDE
	ldr r1,[sp,#0x24]	; 02327FE0
	ldr r2,[sp,#0x5c]	; 02327FE2
	bl loc_0232E8C4	; 02327FE4
	cmp r0,#0x0	; 02327FE8
	bge loc_02327FF0	; 02327FEA
	ldr r4,[sp,#0x60]	; 02327FEC
	b loc_02327F6C	; 02327FEE
loc_02327FF0:
	add r0,r5,#0x0	; 02327FF0
	ldr r1,[sp,#0x28]	; 02327FF2
	ldr r2,[sp,#0x64]	; 02327FF4
	bl loc_0232E8C4	; 02327FF6
	cmp r0,#0x0	; 02327FFA
	bge loc_02328002	; 02327FFC
	ldr r4,[sp,#0x68]	; 02327FFE
	b loc_02327F6C	; 02328000
loc_02328002:
	mov r4,#0x1	; 02328002
	b loc_02327F6C	; 02328004
loc_02328006:
	add r0,r5,#0x0	; 02328006
	ldr r1,[pool_023281E0]	; 02328008
	add r2,r7,#0x0	; 0232800A
	bl loc_0232E8C4	; 0232800C
	cmp r0,#0x0	; 02328010
	blt loc_02328018	; 02328012
	mov r4,#0x1	; 02328014
	b loc_02327F6C	; 02328016
loc_02328018:
	ldr r4,[sp,#0x6c]	; 02328018
	b loc_02327F6C	; 0232801A
loc_0232801C:
	add r0,r5,#0x0	; 0232801C
	ldr r1,[sp,#0x2c]	; 0232801E
	add r2,r7,#0x0	; 02328020
	bl loc_0232E8C4	; 02328022
	cmp r0,#0x0	; 02328026
	bge loc_0232802E	; 02328028
	ldr r4,[sp,#0x70]	; 0232802A
	b loc_02328078	; 0232802C
loc_0232802E:
	add r0,r5,#0x0	; 0232802E
	ldr r1,[sp,#0x0]	; 02328030
	ldr r2,[sp,#0x74]	; 02328032
	bl loc_0232E8C4	; 02328034
	cmp r0,#0x0	; 02328038
	bge loc_02328040	; 0232803A
	ldr r4,[sp,#0x78]	; 0232803C
	b loc_02328078	; 0232803E
loc_02328040:
	add r0,r5,#0x0	; 02328040
	ldr r1,[sp,#0x4]	; 02328042
	ldr r2,[sp,#0x7c]	; 02328044
	bl loc_0232E8C4	; 02328046
	cmp r0,#0x0	; 0232804A
	bge loc_02328052	; 0232804C
	ldr r4,[sp,#0x80]	; 0232804E
	b loc_02328078	; 02328050
loc_02328052:
	add r0,r5,#0x0	; 02328052
	ldr r1,[sp,#0x30]	; 02328054
	ldr r2,[sp,#0x84]	; 02328056
	bl loc_0232E8C4	; 02328058
	cmp r0,#0x0	; 0232805C
	bge loc_02328064	; 0232805E
	ldr r4,[sp,#0x88]	; 02328060
	b loc_02328078	; 02328062
loc_02328064:
	add r0,r5,#0x0	; 02328064
	ldr r1,[sp,#0x8]	; 02328066
	ldr r2,[sp,#0x8c]	; 02328068
	bl loc_0232E8C4	; 0232806A
	cmp r0,#0x0	; 0232806E
	bge loc_02328076	; 02328070
	ldr r4,[sp,#0x90]	; 02328072
	b loc_02328078	; 02328074
loc_02328076:
	mov r4,#0x1	; 02328076
loc_02328078:
	bl loc_0232C000	; 02328078
	str r0,[sp,#0x14]	; 0232807C
	str r1,[sp,#0x10]	; 0232807E
	b loc_02327F6C	; 02328080
loc_02328082:
	add r0,r5,#0x0	; 02328082
	ldr r1,[sp,#0x34]	; 02328084
	add r2,r7,#0x0	; 02328086
	bl loc_0232E8C4	; 02328088
	cmp r0,#0x0	; 0232808C
	bge loc_02328094	; 0232808E
	ldr r4,[sp,#0x94]	; 02328090
	b loc_02327F6C	; 02328092
loc_02328094:
	add r0,r5,#0x0	; 02328094
	ldr r1,[sp,#0x38]	; 02328096
	ldr r2,[sp,#0x98]	; 02328098
	bl loc_0232E8C4	; 0232809A
	cmp r0,#0x0	; 0232809E
	bge loc_023280A6	; 023280A0
	ldr r4,[sp,#0x9c]	; 023280A2
	b loc_02327F6C	; 023280A4
loc_023280A6:
	add r0,r5,#0x0	; 023280A6
	ldr r1,[sp,#0x3c]	; 023280A8
	ldr r2,[sp,#0xa0]	; 023280AA
	bl loc_0232E8C4	; 023280AC
	cmp r0,#0x0	; 023280B0
	bge loc_023280B8	; 023280B2
	ldr r4,[sp,#0xa4]	; 023280B4
	b loc_02327F6C	; 023280B6
loc_023280B8:
	mov r4,#0x1	; 023280B8
	b loc_02327F6C	; 023280BA
loc_023280BC:
	add r0,r5,#0x0	; 023280BC
	ldr r1,[pool_023281E4]	; 023280BE
	add r2,r7,#0x0	; 023280C0
	bl loc_0232E8C4	; 023280C2
	cmp r0,#0x0	; 023280C6
	blt loc_023280CE	; 023280C8
	mov r4,#0x1	; 023280CA
	b loc_02327F6C	; 023280CC
loc_023280CE:
	ldr r4,[sp,#0xa8]	; 023280CE
	b loc_02327F6C	; 023280D0
loc_023280D2:
	ldr r0,[pool_023281DC]	; 023280D2
	ldr r0,[r0,#0x0]	; 023280D4
	cmp r0,#0x1	; 023280D6
	beq loc_023280DC	; 023280D8
	b loc_02327F6C	; 023280DA
loc_023280DC:
	ldr r4,[sp,#0xac]	; 023280DC
	ldr r0,[pool_023281E8]	; 023280DE
	ldrh r0,[r0,#0x0]	; 023280E0
	cmp r0,#0x0	; 023280E2
	bne loc_0232819C	; 023280E4
	cmp r6,#0x6	; 023280E6
	bls loc_023280EC	; 023280E8
	b loc_02327F6C	; 023280EA
loc_023280EC:
	add r0,r6,r6	; 023280EC
P1_SwitchIndexPC_023280EC:
	add r0,pc	; 023280EE
	ldrh r0,[r0,#(P1_SwitchTable_023280EC - (P1_SwitchIndexPC_023280EC + 4))]	; 023280F0
	lsl r0,r0,#0x10	; 023280F2
	asr r0,r0,#0x10	; 023280F4
P1_SwitchTargetPC_023280EC:
	add r0,pc	; 023280F6
	bx r0	; 023280F8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023280EC:
	.halfword (loc_02327F6C + 1) - (P1_SwitchTargetPC_023280EC + 4)
	.halfword (loc_02328108 + 1) - (P1_SwitchTargetPC_023280EC + 4)
	.halfword (loc_02328112 + 1) - (P1_SwitchTargetPC_023280EC + 4)
	.halfword (loc_02328116 + 1) - (P1_SwitchTargetPC_023280EC + 4)
	.halfword (loc_0232811A + 1) - (P1_SwitchTargetPC_023280EC + 4)
	.halfword (loc_0232811A + 1) - (P1_SwitchTargetPC_023280EC + 4)
	.halfword (loc_02328192 + 1) - (P1_SwitchTargetPC_023280EC + 4)
P1_SwitchTable_023280ECEnd:
loc_02328108:
	mov r0,#0x1	; 02328108
	add sp,#0xb4	; 0232810A
	pop {r4,r5,r6,r7}	; 0232810C
	pop {r3}	; 0232810E
	bx r3	; 02328110
loc_02328112:
	add r6,r5,#0x0	; 02328112
	b loc_02327F6C	; 02328114
loc_02328116:
	mov r6,#0x5	; 02328116
	b loc_02327F6C	; 02328118
loc_0232811A:
	ldr r0,[pool_023281CC]	; 0232811A
	mov r1,#0x1	; 0232811C
	blx P1_InvalidateDataCacheRange	; 0232811E
	cmp r6,#0x4	; 02328122
	bne loc_02328140	; 02328124
	ldr r0,[pool_023281CC]	; 02328126
	ldrb r1,[r0,#0x0]	; 02328128
	mov r0,#0x2	; 0232812A
	and r1,r0	; 0232812C
	cmp r1,#0x0	; 0232812E
	beq loc_02328136	; 02328130
	mov r6,#0x3	; 02328132
	b loc_02327F6C	; 02328134
loc_02328136:
	mov r0,#0x0	; 02328136
	add sp,#0xb4	; 02328138
	pop {r4,r5,r6,r7}	; 0232813A
	pop {r3}	; 0232813C
	bx r3	; 0232813E
loc_02328140:
	ldr r0,[pool_023281CC]	; 02328140
	ldrb r1,[r0,#0x0]	; 02328142
	add r2,r1,#0x0	; 02328144
	mov r0,#0x1	; 02328146
	and r2,r0	; 02328148
	cmp r2,#0x0	; 0232814A
	beq loc_0232819E	; 0232814C
	mov r0,#0x20	; 0232814E
	and r1,r0	; 02328150
	cmp r1,#0x0	; 02328152
	bne loc_02328186	; 02328154
	bl loc_0232C000	; 02328156
	add r3,r0,#0x0	; 0232815A
	add r2,r1,#0x0	; 0232815C
	ldr r0,[sp,#0x14]	; 0232815E
	sub r1,r3,r0	; 02328160
	ldr r0,[sp,#0x10]	; 02328162
	sbc r2,r0	; 02328164
	lsr r0,r1,#0x1a	; 02328166
	lsl r2,r2,#0x6	; 02328168
	orr r2,r0	; 0232816A
	lsl r0,r1,#0x6	; 0232816C
	add r1,r2,#0x0	; 0232816E
	ldr r2,[pool_023281EC]	; 02328170
	ldr r3,[sp,#0xb0]	; 02328172
	blx loc_0232CB10	; 02328174
	add r3,r0,#0x0	; 02328178
	add r2,r1,#0x0	; 0232817A
	mov r1,#0x0	; 0232817C
	ldr r0,[pool_023281F0]	; 0232817E
	sub r0,r0,r3	; 02328180
	sbc r1,r2	; 02328182
	bcs loc_0232818A	; 02328184
loc_02328186:
	mov r6,#0x6	; 02328186
	b loc_02327F6C	; 02328188
loc_0232818A:
	ldr r0,[pool_023281F4]	; 0232818A
	bl loc_0232C7B8	; 0232818C
	b loc_02327F6C	; 02328190
loc_02328192:
	lsl r0,r4,#0	; 02328192
	add sp,#0xb4	; 02328194
	pop {r4,r5,r6,r7}	; 02328196
	pop {r3}	; 02328198
	bx r3	; 0232819A
loc_0232819C:
	lsl r0,r4,#0	; 0232819C
loc_0232819E:
	add sp,#0xb4	; 0232819E
	pop {r4,r5,r6,r7}	; 023281A0
	pop {r3}	; 023281A2
	bx r3	; 023281A4
	.byte 0xC0, 0x46	; 023281A8
pool_023281A8:
loc_023281A8:
	.word 0x02002300	; 023281A8
pool_023281AC:
loc_023281AC:
	.word 0x0000FFFF	; 023281AC
pool_023281B0:
loc_023281B0:
	.word 0x00010000	; 023281B0
pool_023281B4:
loc_023281B4:
	.word 0x00030000	; 023281B4
pool_023281B8:
loc_023281B8:
	.word 0x00040000	; 023281B8
pool_023281BC:
loc_023281BC:
	.word 0x01050000	; 023281BC
pool_023281C0:
loc_023281C0:
	.word 0x02002500	; 023281C0
pool_023281C4:
loc_023281C4:
	.word 0x00020000	; 023281C4
pool_023281C8:
loc_023281C8:
	.word 0x01040000	; 023281C8
pool_023281CC:
loc_023281CC:
	.word P1_BssStart + 0x257E0	; 023281CC
pool_023281D0:
loc_023281D0:
	.word 0x02002200	; 023281D0
pool_023281D4:
loc_023281D4:
	.word 0x0000FF00	; 023281D4
pool_023281D8:
loc_023281D8:
	.word 0x01020000	; 023281D8
pool_023281DC:
loc_023281DC:
	.word P1_BssStart + 0x25754	; 023281DC
pool_023281E0:
loc_023281E0:
	.word 0x03002000	; 023281E0
pool_023281E4:
loc_023281E4:
	.word 0x03002D00	; 023281E4
pool_023281E8:
loc_023281E8:
	.word P1_BssStart + 0x2574C	; 023281E8
pool_023281EC:
loc_023281EC:
	.word 0x000082EA	; 023281EC
pool_023281F0:
loc_023281F0:
	.word 0x00000FA0	; 023281F0
pool_023281F4:
loc_023281F4:
	.word 0x00004000	; 023281F4

; ===== function loc_023281F8 =====
loc_023281F8:
	push {r4,r5,r6,r7,lr}	; 023281F8
	sub sp,#0x4	; 023281FA
	add r7,r0,#0x0	; 023281FC
	mov r6,#0x0	; 023281FE
	add r5,r6,#0x0	; 02328200
loc_02328202:
	lsl r0,r5,#0x7	; 02328202
	add r4,r7,r0	; 02328204
	ldr r0,[pool_023282B0]	; 02328206
	add r1,r4,#0x0	; 02328208
	mov r2,#0x70	; 0232820A
	bl loc_0232C7E2	; 0232820C
	add r1,r4,#0x0	; 02328210
	add r1,#0x72	; 02328212
	ldrh r1,[r1,#0x0]	; 02328214
	cmp r0,r1	; 02328216
	bne loc_0232823E	; 02328218
	add r0,r4,#0x0	; 0232821A
	add r0,#0x70	; 0232821C
	ldrh r0,[r0,#0x0]	; 0232821E
	cmp r0,#0x80	; 02328220
	bcs loc_0232823E	; 02328222
	ldrb r0,[r4,#0x0]	; 02328224
	cmp r0,#0x5	; 02328226
	bne loc_0232823E	; 02328228
	add r0,r4,#0x0	; 0232822A
	bl loc_0232836C	; 0232822C
	cmp r0,#0x0	; 02328230
	beq loc_0232823E	; 02328232
	mov r0,#0x1	; 02328234
	lsl r0,r5	; 02328236
	orr r6,r0	; 02328238
	lsl r0,r6,#0x10	; 0232823A
	lsr r6,r0,#0x10	; 0232823C
loc_0232823E:
	add r0,r5,#0x1	; 0232823E
	lsl r0,r0,#0x10	; 02328240
	lsr r5,r0,#0x10	; 02328242
	cmp r5,#0x2	; 02328244
	bcc loc_02328202	; 02328246
	cmp r6,#0x3	; 02328248
	bne loc_02328274	; 0232824A
	add r0,r7,#0x0	; 0232824C
	add r0,#0x70	; 0232824E
	ldrh r0,[r0,#0x0]	; 02328250
	add r1,r0,#0x1	; 02328252
	mov r0,#0x7f	; 02328254
	and r1,r0	; 02328256
	lsl r0,r1,#0x18	; 02328258
	lsr r1,r0,#0x18	; 0232825A
	add r7,#0xf0	; 0232825C
	ldrh r0,[r7,#0x0]	; 0232825E
	cmp r1,r0	; 02328260
	bne loc_0232826C	; 02328262
	mov r1,#0x1	; 02328264
	ldr r0,[pool_023282B4]	; 02328266
	strh r1,[r0,#0x0]	; 02328268
	b loc_023282A4	; 0232826A
loc_0232826C:
	mov r1,#0x0	; 0232826C
	ldr r0,[pool_023282B4]	; 0232826E
	strh r1,[r0,#0x0]	; 02328270
	b loc_023282A4	; 02328272
loc_02328274:
	cmp r6,#0x0	; 02328274
	beq loc_0232829A	; 02328276
	mov r1,#0x0	; 02328278
	ldr r0,[pool_023282B4]	; 0232827A
	strh r1,[r0,#0x0]	; 0232827C
	mov r2,#0x1	; 0232827E
loc_02328280:
	ldrh r1,[r0,#0x0]	; 02328280
	add r3,r2,#0x0	; 02328282
	lsl r3,r1	; 02328284
	add r4,r6,#0x0	; 02328286
	and r4,r3	; 02328288
	cmp r4,#0x0	; 0232828A
	bne loc_023282A4	; 0232828C
	add r1,r1,#0x1	; 0232828E
	strh r1,[r0,#0x0]	; 02328290
	ldrh r1,[r0,#0x0]	; 02328292
	cmp r1,#0x2	; 02328294
	bcc loc_02328280	; 02328296
	b loc_023282A4	; 02328298
loc_0232829A:
	mov r0,#0x1	; 0232829A
	add sp,#0x4	; 0232829C
	pop {r4,r5,r6,r7}	; 0232829E
	pop {r3}	; 023282A0
	bx r3	; 023282A2
loc_023282A4:
	mov r0,#0x0	; 023282A4
	add sp,#0x4	; 023282A6
	pop {r4,r5,r6,r7}	; 023282A8
	pop {r3}	; 023282AA
	bx r3	; 023282AC
	.byte 0xC0, 0x46	; 023282B0
pool_023282B0:
loc_023282B0:
	.word 0x0000FFFF	; 023282B0
pool_023282B4:
loc_023282B4:
	.word P1_Data_02330910	; 023282B4

; ===== function loc_023282B8 =====
loc_023282B8:
	push {r4,r5,r6,r7,lr}	; 023282B8
	sub sp,#0x4	; 023282BA
	add r4,r0,#0x0	; 023282BC
	ldr r0,[pool_02328354]	; 023282BE
	ldrh r0,[r0,#0x0]	; 023282C0
	cmp r0,#0xff	; 023282C2
	bne loc_023282D6	; 023282C4
	mov r0,#0x0	; 023282C6
	bl loc_023283E4	; 023282C8
	cmp r0,#0x0	; 023282CC
	beq loc_023282D6	; 023282CE
	mov r1,#0x0	; 023282D0
	ldr r0,[pool_02328354]	; 023282D2
	strh r1,[r0,#0x0]	; 023282D4
loc_023282D6:
	mov r0,#0x5	; 023282D6
	strb r0,[r4,#0x0]	; 023282D8
	ldr r3,[pool_02328358]	; 023282DA
	mov r2,#0xe	; 023282DC
loc_023282DE:
	ldmia r4!,{r0,r1}	; 023282DE
	stmia r3!,{r0,r1}	; 023282E0
	sub r2,r2,#0x1	; 023282E2
	cmp r2,#0x0	; 023282E4
	bne loc_023282DE	; 023282E6
	ldr r0,[pool_0232835C]	; 023282E8
	ldr r1,[pool_02328358]	; 023282EA
	mov r2,#0x70	; 023282EC
	bl loc_0232C7E2	; 023282EE
	ldr r1,[pool_02328358]	; 023282F2
	add r1,#0x72	; 023282F4
	strh r0,[r1,#0x0]	; 023282F6
	ldr r1,[pool_02328360]	; 023282F8
	ldrh r2,[r1,#0x0]	; 023282FA
	ldr r0,[pool_02328358]	; 023282FC
	add r0,#0x70	; 023282FE
	strh r2,[r0,#0x0]	; 02328300
	ldrh r0,[r1,#0x0]	; 02328302
	add r2,r0,#0x1	; 02328304
	mov r0,#0x7f	; 02328306
	and r2,r0	; 02328308
	lsl r0,r2,#0x18	; 0232830A
	lsr r0,r0,#0x18	; 0232830C
	strh r0,[r1,#0x0]	; 0232830E
	ldr r0,[pool_02328358]	; 02328310
	mov r1,#0x80	; 02328312
	blx P1_CleanAndInvalidateDataCacheRange	; 02328314
	mov r0,#0x8	; 02328318
	sub r5,r0,#0x1	; 0232831A
	ldr r4,[pool_02328354]	; 0232831C
	ldr r6,[pool_02328364]	; 0232831E
	mov r7,#0x1	; 02328320
loc_02328322:
	ldrh r0,[r4,#0x0]	; 02328322
	eor r0,r7	; 02328324
	strh r0,[r4,#0x0]	; 02328326
	mov r0,#0x2	; 02328328
	ldr r1,[r6,#0x0]	; 0232832A
	ldrh r2,[r4,#0x0]	; 0232832C
	lsl r2,r2,#0x8	; 0232832E
	add r1,r1,r2	; 02328330
	mov r2,#0x80	; 02328332
	ldr r3,[pool_02328358]	; 02328334
	bl loc_02327E88	; 02328336
	cmp r0,#0x0	; 0232833A
	bne loc_0232834C	; 0232833C
	ldr r0,[pool_02328368]	; 0232833E
	bl loc_0232C7B8	; 02328340
	add r0,r5,#0x0	; 02328344
	sub r5,r5,#0x1	; 02328346
	cmp r0,#0x0	; 02328348
	bne loc_02328322	; 0232834A
loc_0232834C:
	add sp,#0x4	; 0232834C
	pop {r4,r5,r6,r7}	; 0232834E
	pop {r3}	; 02328350
	bx r3	; 02328352
pool_02328354:
loc_02328354:
	.word P1_Data_02330910	; 02328354
pool_02328358:
loc_02328358:
	.word P1_BssStart + 0x25760	; 02328358
pool_0232835C:
loc_0232835C:
	.word 0x0000FFFF	; 0232835C
pool_02328360:
loc_02328360:
	.word P1_BssStart + 0x25750	; 02328360
pool_02328364:
loc_02328364:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 02328364
pool_02328368:
loc_02328368:
	.word 0x00004000	; 02328368

; ===== function loc_0232836C =====
loc_0232836C:
	add r1,r0,#0x0	; 0232836C
	add r1,#0x64	; 0232836E
	ldrh r1,[r1,#0x0]	; 02328370
	lsl r2,r1,#0x12	; 02328372
	lsr r2,r2,#0x1f	; 02328374
	cmp r2,#0x0	; 02328376
	beq loc_02328386	; 02328378
	lsl r1,r1,#0x1d	; 0232837A
	lsr r1,r1,#0x1d	; 0232837C
	cmp r1,#0x6	; 0232837E
	bcc loc_02328386	; 02328380
	mov r0,#0x0	; 02328382
	bx lr	; 02328384
loc_02328386:
	add r1,r0,#0x0	; 02328386
	add r1,#0x64	; 02328388
	ldrh r1,[r1,#0x0]	; 0232838A
	lsl r1,r1,#0x15	; 0232838C
	lsr r1,r1,#0x1f	; 0232838E
	cmp r1,#0x0	; 02328390
	beq loc_023283A4	; 02328392
	ldrb r1,[r0,#0x3]	; 02328394
	cmp r1,#0xc	; 02328396
	bhi loc_023283A0	; 02328398
	ldrb r1,[r0,#0x4]	; 0232839A
	cmp r1,#0x1f	; 0232839C
	bls loc_023283A4	; 0232839E
loc_023283A0:
	mov r0,#0x0	; 023283A0
	bx lr	; 023283A2
loc_023283A4:
	add r1,r0,#0x0	; 023283A4
	add r1,#0x64	; 023283A6
	ldrh r1,[r1,#0x0]	; 023283A8
	lsl r1,r1,#0x10	; 023283AA
	lsr r1,r1,#0x1f	; 023283AC
	cmp r1,#0x0	; 023283AE
	beq loc_023283BC	; 023283B0
	ldrb r1,[r0,#0x1a]	; 023283B2
	cmp r1,#0xa	; 023283B4
	bls loc_023283BC	; 023283B6
	mov r0,#0x0	; 023283B8
	bx lr	; 023283BA
loc_023283BC:
	add r1,r0,#0x0	; 023283BC
	add r1,#0x50	; 023283BE
	ldrb r1,[r1,#0x0]	; 023283C0
	cmp r1,#0x1a	; 023283C2
	bls loc_023283CA	; 023283C4
	mov r0,#0x0	; 023283C6
	bx lr	; 023283C8
loc_023283CA:
	add r1,r0,#0x0	; 023283CA
	add r1,#0x52	; 023283CC
	ldrb r1,[r1,#0x0]	; 023283CE
	cmp r1,#0x17	; 023283D0
	bhi loc_023283DC	; 023283D2
	add r0,#0x53	; 023283D4
	ldrb r0,[r0,#0x0]	; 023283D6
	cmp r0,#0x3b	; 023283D8
	bls loc_023283E0	; 023283DA
loc_023283DC:
	mov r0,#0x0	; 023283DC
	bx lr	; 023283DE
loc_023283E0:
	mov r0,#0x1	; 023283E0
	bx lr	; 023283E2

; ===== function loc_023283E4 =====
loc_023283E4:
	push {r4,r5,r6,r7,lr}	; 023283E4
	sub sp,#0xc	; 023283E6
	str r0,[sp,#0x0]	; 023283E8
	mov r0,#0x0	; 023283EA
	str r0,[sp,#0x4]	; 023283EC
	ldr r5,[pool_02328478]	; 023283EE
	mov r0,#0x4	; 023283F0
	ldr r1,[pool_0232847C]	; 023283F2
	bl P1_SetPxiReceiveCallback	; 023283F4
	mov r6,#0x1	; 023283F8
	ldr r4,[pool_02328480]	; 023283FA
	mov r7,#0x80	; 023283FC
loc_023283FE:
	add r0,r6,#0x0	; 023283FE
	ldr r1,[r4,#0x0]	; 02328400
	add r2,r7,#0x0	; 02328402
	add r3,r5,#0x0	; 02328404
	bl loc_02327E88	; 02328406
	cmp r0,#0x0	; 0232840A
	beq loc_023283FE	; 0232840C
	mov r7,#0x1	; 0232840E
	ldr r4,[pool_02328480]	; 02328410
	ldr r6,[pool_02328484]	; 02328412
loc_02328414:
	add r0,r7,#0x0	; 02328414
	ldr r1,[r4,#0x0]	; 02328416
	add r1,r1,r6	; 02328418
	mov r2,#0x80	; 0232841A
	add r3,r5,#0x0	; 0232841C
	add r3,#0x80	; 0232841E
	bl loc_02327E88	; 02328420
	cmp r0,#0x0	; 02328424
	beq loc_02328414	; 02328426
	add r0,r5,#0x0	; 02328428
	ldr r1,[pool_02328484]	; 0232842A
	blx P1_InvalidateDataCacheRange	; 0232842C
	add r0,r5,#0x0	; 02328430
	bl loc_023281F8	; 02328432
	cmp r0,#0x0	; 02328436
	beq loc_02328444	; 02328438
	mov r0,#0x1	; 0232843A
	str r0,[sp,#0x4]	; 0232843C
	ldr r1,[pool_02328488]	; 0232843E
	strh r0,[r1,#0x0]	; 02328440
	b loc_0232846C	; 02328442
loc_02328444:
	ldr r0,[pool_0232848C]	; 02328444
	ldrh r0,[r0,#0x0]	; 02328446
	lsl r0,r0,#0x7	; 02328448
	add r0,r5,r0	; 0232844A
	add r1,r0,#0x0	; 0232844C
	add r1,#0x70	; 0232844E
	ldrh r1,[r1,#0x0]	; 02328450
	add r2,r1,#0x1	; 02328452
	mov r1,#0x7f	; 02328454
	and r2,r1	; 02328456
	lsl r1,r2,#0x18	; 02328458
	lsr r2,r1,#0x18	; 0232845A
	ldr r1,[pool_02328488]	; 0232845C
	strh r2,[r1,#0x0]	; 0232845E
	ldr r1,[sp,#0x0]	; 02328460
	cmp r1,#0x0	; 02328462
	beq loc_0232846C	; 02328464
	mov r2,#0x38	; 02328466
	bl loc_0232C7D6	; 02328468
loc_0232846C:
	ldr r0,[sp,#0x4]	; 0232846C
	add sp,#0xc	; 0232846E
	pop {r4,r5,r6,r7}	; 02328470
	pop {r3}	; 02328472
	bx r3	; 02328474
	.byte 0xC0, 0x46	; 02328478
pool_02328478:
loc_02328478:
	.word 0x023561E0	; 02328478
pool_0232847C:
loc_0232847C:
	.word P1_PxiCallback_02327E5C + 1	; 0232847C
pool_02328480:
loc_02328480:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 02328480
pool_02328484:
loc_02328484:
	.word 0x00000100	; 02328484
pool_02328488:
loc_02328488:
	.word P1_BssStart + 0x25750	; 02328488
pool_0232848C:
loc_0232848C:
	.word P1_Data_02330910	; 0232848C

; ===== function loc_02328490 =====
loc_02328490:
	push {r4,r5}	; 02328490
	mov r4,#0x3	; 02328492
	mov r3,#0x0	; 02328494
loc_02328496:
	ldrb r2,[r0,#0x0]	; 02328496
	ror r3,r4	; 02328498
	mov r5,#0x4	; 0232849A
loc_0232849C:
	eor r3,r2	; 0232849C
	lsl r2,r2,#0x8	; 0232849E
	sub r5,#0x1	; 023284A0
	bgt loc_0232849C	; 023284A2
	add r0,#0x1	; 023284A4
	sub r1,#0x1	; 023284A6
	bgt loc_02328496	; 023284A8
	add r0,r3,#0x0	; 023284AA
	lsl r0,r0,#0x1b	; 023284AC
	lsr r0,r0,#0x1e	; 023284AE
	pop {r4,r5}	; 023284B0
	bx lr	; 023284B2

; ===== function loc_023284B4 =====
loc_023284B4:
	add r2,r0,#0x0	; 023284B4
	mov r0,#0x14	; 023284B6
	mul r1,r0	; 023284B8
	ldr r0,[pool_023284C8]	; 023284BA
	add r0,r1,r0	; 023284BC
	add r1,r2,r1	; 023284BE
	mov r2,#0xa	; 023284C0
	ldr r3,[pool_023284CC]	; 023284C2
	bx r3	; 023284C4
	.byte 0xC0, 0x46	; 023284C8
pool_023284C8:
loc_023284C8:
	.word 0x08000004	; 023284C8
pool_023284CC:
loc_023284CC:
	.word P1_SwiCpuSet + 1	; 023284CC

; ===== function loc_023284D0 =====
loc_023284D0:
	push {r4,r5,r6,r7,lr}	; 023284D0
	sub sp,#0x4	; 023284D2
	add r6,r0,#0x0	; 023284D4
	ldr r0,[pool_0232853C]	; 023284D6
	ldrb r1,[r0,#0x0]	; 023284D8
	mov r0,#0x80	; 023284DA
	and r1,r0	; 023284DC
	cmp r1,#0x0	; 023284DE
	beq loc_023284E6	; 023284E0
	ldr r0,[pool_02328540]	; 023284E2
	b loc_023284E8	; 023284E4
loc_023284E6:
	ldr r0,[pool_02328544]	; 023284E6
loc_023284E8:
	add r1,r6,#0x0	; 023284E8
	mov r2,#0xa	; 023284EA
	bl loc_0232C7D6	; 023284EC
	ldr r0,[pool_02328548]	; 023284F0
	sub r0,r0,#0x1	; 023284F2
	mov r1,#0x1b	; 023284F4
	bl loc_02328490	; 023284F6
	ldr r3,[pool_0232854C]	; 023284FA
	ldr r1,[pool_02328548]	; 023284FC
	ldrb r2,[r1,#0x0]	; 023284FE
	mov r1,#0x3	; 02328500
	and r2,r1	; 02328502
	mov r1,#0x30	; 02328504
	mul r2,r1	; 02328506
	add r2,r3,r2	; 02328508
	mov r1,#0xc	; 0232850A
	mul r0,r1	; 0232850C
	add r5,r2,r0	; 0232850E
	mov r4,#0x0	; 02328510
	ldr r7,[pool_02328550]	; 02328512
loc_02328514:
	add r0,r6,#0x0	; 02328514
	add r1,r4,#0x0	; 02328516
	bl loc_023284B4	; 02328518
	cmp r4,#0x3	; 0232851C
	blt loc_0232852C	; 0232851E
	cmp r4,#0x9	; 02328520
	bge loc_0232852C	; 02328522
	ldrh r0,[r5,#0x0]	; 02328524
	add r5,r5,#0x2	; 02328526
	lsl r0,r0,#0x1	; 02328528
	ldrh r0,[r0,r7]	; 0232852A
loc_0232852C:
	add r4,r4,#0x1	; 0232852C
	cmp r4,#0xb	; 0232852E
	blt loc_02328514	; 02328530
	add sp,#0x4	; 02328532
	pop {r4,r5,r6,r7}	; 02328534
	pop {r3}	; 02328536
	bx r3	; 02328538
	.byte 0xC0, 0x46	; 0232853C
pool_0232853C:
loc_0232853C:
	.word 0x080000B4	; 0232853C
pool_02328540:
loc_02328540:
	.word 0x09FE1FE0	; 02328540
pool_02328544:
loc_02328544:
	.word 0x09FFFFE0	; 02328544
pool_02328548:
loc_02328548:
	.word 0x0800009E	; 02328548
pool_0232854C:
loc_0232854C:
	.word 0x02330914	; 0232854C
pool_02328550:
loc_02328550:
	.word 0x08000000	; 02328550

; ===== function loc_02328554 =====
loc_02328554:
	push {r4,r5,r6,r7}	; 02328554
	mov r5,#0x0	; 02328556
	ldr r3,[pool_0232859C]	; 02328558
	ldr r2,[pool_023285A0]	; 0232855A
	mov r1,#0x3	; 0232855C
	add r4,r2,#0x0	; 0232855E
	eor r4,r1	; 02328560
	lsl r1,r4,#0x10	; 02328562
	lsr r1,r1,#0x10	; 02328564
	mov r6,#0x84	; 02328566
loc_02328568:
	add r4,r2,#0x0	; 02328568
	cmp r5,#0x4c	; 0232856A
	bne loc_02328576	; 0232856C
	eor r4,r6	; 0232856E
	lsl r4,r4,#0x10	; 02328570
	lsr r4,r4,#0x10	; 02328572
	b loc_0232857C	; 02328574
loc_02328576:
	cmp r5,#0x4d	; 02328576
	bne loc_0232857C	; 02328578
	add r4,r1,#0x0	; 0232857A
loc_0232857C:
	ldrh r7,[r0,#0x0]	; 0232857C
	and r4,r7	; 0232857E
	ldrh r7,[r3,#0x0]	; 02328580
	cmp r4,r7	; 02328582
	beq loc_0232858C	; 02328584
	mov r0,#0x0	; 02328586
	pop {r4,r5,r6,r7}	; 02328588
	bx lr	; 0232858A
loc_0232858C:
	add r3,r3,#0x2	; 0232858C
	add r0,r0,#0x2	; 0232858E
	add r5,r5,#0x1	; 02328590
	cmp r5,#0x4e	; 02328592
	blt loc_02328568	; 02328594
	mov r0,#0x1	; 02328596
	pop {r4,r5,r6,r7}	; 02328598
	bx lr	; 0232859A
pool_0232859C:
loc_0232859C:
	.word 0xFFFF0020	; 0232859C
pool_023285A0:
loc_023285A0:
	.word 0x0000FFFF	; 023285A0

; ===== function loc_023285A4 =====
loc_023285A4:
	push {r4,lr}	; 023285A4
	mov r0,#0x6d	; 023285A6
	bl loc_0232B3C8	; 023285A8
	ldr r0,[pool_023285C8]	; 023285AC
	bl loc_023284D0	; 023285AE
	ldr r0,[pool_023285C8]	; 023285B2
	bl loc_02328554	; 023285B4
	add r4,r0,#0x0	; 023285B8
	mov r0,#0x6d	; 023285BA
	bl loc_0232B260	; 023285BC
	add r0,r4,#0x0	; 023285C0
	pop {r4}	; 023285C2
	pop {r3}	; 023285C4
	bx r3	; 023285C6
pool_023285C8:
loc_023285C8:
	.word 0x023562E0	; 023285C8

; ===== function loc_023285CC =====
loc_023285CC:
	push {r0,r1,r2,r4,lr}	; 023285CC
	ldr r0,[pool_02328610]	; 023285CE
	add r1,r2,#0x0	; 023285D0
	add r4,r1,#0x0	; 023285D2
	mov r2,#0x24	; 023285D4
	blx loc_0232DE30	; 023285D6
	ldr r0,[sp,#0x0]	; 023285DA
	mov r2,#0x24	; 023285DC
	add r1,r4,r2	; 023285DE
	mov r2,#0x9c	; 023285E0
	blx loc_0232DE30	; 023285E2
	add r0,r4,#0x0	; 023285E6
	ldr r1,[sp,#0x4]	; 023285E8
	mov r2,#0x1	; 023285EA
	lsl r2,r2,#0x8	; 023285EC
	add r2,r2,r1	; 023285EE
	ldr r3,[pool_02328614]	; 023285F0
	bl loc_0232C7F6	; 023285F2
	ldr r0,[sp,#0x4]	; 023285F6
	ldr r2,[pool_02328618]	; 023285F8
	str r2,[r0,#0x0]	; 023285FA
	add r1,r4,#0x0	; 023285FC
	bl loc_02328620	; 023285FE
	add r0,r4,#0x0	; 02328602
	ldr r1,[sp,#0x4]	; 02328604
	ldr r2,[pool_0232861C]	; 02328606
	bl loc_0232C7EA	; 02328608
	pop {r0,r1,r2,r4,pc}	; 0232860C
	.byte 0xC0, 0x46	; 02328610
pool_02328610:
loc_02328610:
	.word 0x023301C8	; 02328610
pool_02328614:
loc_02328614:
	.word 0x023301B4	; 02328614
pool_02328618:
loc_02328618:
	.word 0x0000D082	; 02328618
pool_0232861C:
loc_0232861C:
	.word 0x023309D4	; 0232861C

; ===== function loc_02328620 =====
.func P1_SwiDiff16UnFilter
; BIOS SWI #18: differential 16-bit decompression. / BIOS SWI #18：差分 16 位解压。
loc_02328620:
	swi 0x18	; 02328620
	bx lr	; 02328622
.endfunc

; ===== function loc_02328624 =====
loc_02328624:
	ldr r0,[r0,#0x0]	; 02328624
	bx lr	; 02328626
	ldrb r0,[r0,#0x0]	; 02328628
	bx lr	; 0232862A
	mov r0,#0x0	; 0232862C
	bx lr	; 0232862E

; ===== function loc_02328630 =====
	push {lr}	; 02328630
	sub sp,#0x4	; 02328632
	cmp r2,#0x0	; 02328634
	beq loc_02328642	; 02328636
	bl loc_02328624	; 02328638
	add sp,#0x4	; 0232863C
	pop {r3}	; 0232863E
	bx r3	; 02328640
loc_02328642:
	mov r0,#0x0	; 02328642
	add sp,#0x4	; 02328644
	pop {r3}	; 02328646
	bx r3	; 02328648
	.byte 0x00, 0x00	; 0232864C

; ===== function loc_0232864C =====
loc_0232864C:
	push {r4,r5,r6,lr}	; 0232864C
	sub sp,#0x100	; 0232864E
	add r5,r1,#0x0	; 02328650
	add r4,r3,#0x0	; 02328652
	ldr r1,[pool_02328680]	; 02328654
	ldr r3,[r1,#0x4]	; 02328656
	ldr r6,[pool_02328684]	; 02328658
	and r3,r6	; 0232865A
	sub r6,r2,#0x1	; 0232865C
	ldr r2,[pool_02328688]	; 0232865E
	and r6,r2	; 02328660
	orr r3,r6	; 02328662
	str r3,[r1,#0x4]	; 02328664
	add r1,r4,#0x0	; 02328666
	add r2,sp,#0x0	; 02328668
	bl loc_023285CC	; 0232866A
	add r0,r4,#0x0	; 0232866E
	add r1,r5,#0x0	; 02328670
	ldr r2,[pool_0232868C]	; 02328672
	blx loc_0232DEC4	; 02328674
	add sp,#0x100	; 02328678
	pop {r4,r5,r6}	; 0232867A
	pop {r3}	; 0232867C
	bx r3	; 0232867E
pool_02328680:
loc_02328680:
	.word P1_Data_023309D4	; 02328680
pool_02328684:
loc_02328684:
	.word 0x80000000	; 02328684
pool_02328688:
loc_02328688:
	.word 0x7FFFFFFF	; 02328688
pool_0232868C:
loc_0232868C:
	.word 0x00000340	; 0232868C
.arm

; ===== function loc_02328690 =====
loc_02328690:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}	; 02328690
	sub sp,sp,#0x4	; 02328694
	ldr r4,[r1,#0x4]	; 02328698
	eor r5,r4,r4, ror #0x10	; 0232869C
	bic r5,r5,#0xff0000	; 023286A0
	mov r4,r4, ror #0x8	; 023286A4
	eor r4,r4,r5, lsr #0x8	; 023286A8
	bic r4,r4,#0xff000000	; 023286AC
	str r4,[sp,#0x0]	; 023286B0
	add r5,r0,r4	; 023286B4
	ldr r6,[pool_02328AA8]	; 023286B8
	cmp r5,r6	; 023286BC
	bls loc_023286D0	; 023286C0
	mov r0,#0x0	; 023286C4
	add sp,sp,#0x4	; 023286C8
	bl loc_023289F8	; 023286CC
loc_023286D0:
	ldr r5,[r1,#0x8]	; 023286D0
	eor r6,r5,r5, ror #0x10	; 023286D4
	bic r6,r6,#0xff0000	; 023286D8
	mov r5,r5, ror #0x8	; 023286DC
	eor r5,r5,r6, lsr #0x8	; 023286E0
	ldr r2,[pool_02328AAC]	; 023286E4
	add r3,r1,#0xc	; 023286E8
	str r3,[r2,#0x10]	; 023286EC
	add r3,r1,r5	; 023286F0
	str r3,[r2,#0x14]	; 023286F4
	mov r3,#0x0	; 023286F8
	str r3,[r2,#0x0]	; 023286FC
	str r3,[r2,#0x4]	; 02328700
	mov r3,#0x200	; 02328704
	str r3,[r2,#0x8]	; 02328708
	mov r3,#0x800	; 0232870C
	str r3,[r2,#0xc]	; 02328710
	ldr r11,[pool_02328AAC]	; 02328714
	mov r12,#0x20	; 02328718
	bl loc_02328A00	; 0232871C
	ldr r11,[pool_02328AB0]	; 02328720
	mov r12,#0x20	; 02328724
	bl loc_02328A00	; 02328728
	ldr r11,[pool_02328AAC]	; 0232872C
	ldr r2,[pool_02328AB4]	; 02328730
	mov r1,r2	; 02328734
	ldr r5,[r11,#0x8]	; 02328738
	mov r6,r5	; 0232873C
loc_02328740:
	ldr r8,[r11,#0x0]	; 02328740
	ldr r9,[r11,#0x10]	; 02328744
	ldr r10,[r11,#0x18]	; 02328748
	mov r7,r10, lsr #0x1f	; 0232874C
	cmp r8,#0x1f	; 02328750
	bne loc_02328778	; 02328754
	ldr r3,[r9],#0x4	; 02328758
	eor r10,r3,r3, ror #0x10	; 0232875C
	bic r10,r10,#0xff0000	; 02328760
	mov r3,r3, ror #0x8	; 02328764
	eor r3,r3,r10, lsr #0x8	; 02328768
	str r9,[r11,#0x10]	; 0232876C
	mov r8,#0x0	; 02328770
	b loc_02328780	; 02328774
loc_02328778:
	mov r3,r10, lsl #0x1	; 02328778
	add r8,r8,#0x1	; 0232877C
loc_02328780:
	str r3,[r11,#0x18]	; 02328780
	str r8,[r11,#0x0]	; 02328784
	cmp r7,#0x0	; 02328788
	beq loc_023287AC	; 0232878C
	orr r8,r5,#0x8000	; 02328790
	orr r9,r5,#0x4000	; 02328794
	strh r8,[r2],#0x2	; 02328798
	strh r9,[r2],#0x2	; 0232879C
	add r5,r5,#0x1	; 023287A0
	add r6,r6,#0x1	; 023287A4
	b loc_02328740	; 023287A8
loc_023287AC:
	mov r12,#0x9	; 023287AC
	bl loc_02328A00	; 023287B0
	mov r10,#0x4000	; 023287B4
	ldr r12,[pool_02328AB8]	; 023287B8
	ldr r3,[pool_02328ABC]	; 023287BC
	sub r10,r10,#0x1	; 023287C0
loc_023287C4:
	ldrh r8,[r2,#-0x2]!	; 023287C4
	and r9,r8,r10	; 023287C8
	mov lr,r9, lsl #0x1	; 023287CC
	tst r8,#0x8000	; 023287D0
	beq loc_023287EC	; 023287D4
	strh r7,[r3,lr]	; 023287D8
	mov r7,r9	; 023287DC
	cmp r2,r1	; 023287E0
	bne loc_023287C4	; 023287E4
	b loc_023287F8	; 023287E8
loc_023287EC:
	strh r7,[r12,lr]	; 023287EC
	mov r5,r6	; 023287F0
	b loc_02328740	; 023287F4
loc_023287F8:
	str r7,[r11,#0x20]	; 023287F8
	ldr r11,[pool_02328AB0]	; 023287FC
	ldr r2,[pool_02328AB4]	; 02328800
	mov r1,r2	; 02328804
	ldr r5,[r11,#0x8]	; 02328808
	mov r6,r5	; 0232880C
loc_02328810:
	ldr r8,[r11,#0x0]	; 02328810
	ldr r9,[r11,#0x10]	; 02328814
	ldr r10,[r11,#0x18]	; 02328818
	mov r7,r10, lsr #0x1f	; 0232881C
	cmp r8,#0x1f	; 02328820
	bne loc_02328848	; 02328824
	ldr r3,[r9],#0x4	; 02328828
	eor r10,r3,r3, ror #0x10	; 0232882C
	bic r10,r10,#0xff0000	; 02328830
	mov r3,r3, ror #0x8	; 02328834
	eor r3,r3,r10, lsr #0x8	; 02328838
	str r9,[r11,#0x10]	; 0232883C
	mov r8,#0x0	; 02328840
	b loc_02328850	; 02328844
loc_02328848:
	mov r3,r10, lsl #0x1	; 02328848
	add r8,r8,#0x1	; 0232884C
loc_02328850:
	str r3,[r11,#0x18]	; 02328850
	str r8,[r11,#0x0]	; 02328854
	cmp r7,#0x0	; 02328858
	beq loc_0232887C	; 0232885C
	orr r8,r5,#0x8000	; 02328860
	orr r9,r5,#0x4000	; 02328864
	strh r8,[r2],#0x2	; 02328868
	strh r9,[r2],#0x2	; 0232886C
	add r5,r5,#0x1	; 02328870
	add r6,r6,#0x1	; 02328874
	b loc_02328810	; 02328878
loc_0232887C:
	mov r12,#0xb	; 0232887C
	bl loc_02328A00	; 02328880
	mov r10,#0x4000	; 02328884
	ldr r12,[pool_02328AC0]	; 02328888
	ldr r3,[pool_02328AC4]	; 0232888C
	sub r10,r10,#0x1	; 02328890
loc_02328894:
	ldrh r8,[r2,#-0x2]!	; 02328894
	and r9,r8,r10	; 02328898
	mov lr,r9, lsl #0x1	; 0232889C
	tst r8,#0x8000	; 023288A0
	beq loc_023288BC	; 023288A4
	strh r7,[r3,lr]	; 023288A8
	mov r7,r9	; 023288AC
	cmp r2,r1	; 023288B0
	bne loc_02328894	; 023288B4
	b loc_023288C8	; 023288B8
loc_023288BC:
	strh r7,[r12,lr]	; 023288BC
	mov r5,r6	; 023288C0
	b loc_02328810	; 023288C4
loc_023288C8:
	str r7,[r11,#0x20]	; 023288C8
loc_023288CC:
	cmp r4,#0x0	; 023288CC
	beq loc_023289F4	; 023288D0
	ldr r11,[pool_02328AAC]	; 023288D4
	ldr r1,[pool_02328AB8]	; 023288D8
	ldr r2,[pool_02328ABC]	; 023288DC
	ldr r5,[r11,#0x20]	; 023288E0
	ldr r8,[r11,#0x0]	; 023288E4
	ldr r9,[r11,#0x10]	; 023288E8
	ldr r10,[r11,#0x18]	; 023288EC
loc_023288F0:
	cmp r5,#0x200	; 023288F0
	bcc loc_0232893C	; 023288F4
	mov r7,r10, lsr #0x1f	; 023288F8
	cmp r8,#0x1f	; 023288FC
	bne loc_02328920	; 02328900
	ldr r10,[r9],#0x4	; 02328904
	eor r3,r10,r10, ror #0x10	; 02328908
	bic r3,r3,#0xff0000	; 0232890C
	mov r10,r10, ror #0x8	; 02328910
	eor r10,r10,r3, lsr #0x8	; 02328914
	mov r8,#0x0	; 02328918
	b loc_02328928	; 0232891C
loc_02328920:
	mov r10,r10, lsl #0x1	; 02328920
	add r8,r8,#0x1	; 02328924
loc_02328928:
	mov r3,r5, lsl #0x1	; 02328928
	cmp r7,#0x0	; 0232892C
	ldreqh r5,[r1,r3]	; 02328930
	ldrneh r5,[r2,r3]	; 02328934
	b loc_023288F0	; 02328938
loc_0232893C:
	str r8,[r11,#0x0]	; 0232893C
	str r9,[r11,#0x10]	; 02328940
	str r10,[r11,#0x18]	; 02328944
	cmp r5,#0x100	; 02328948
	bcs loc_0232895C	; 0232894C
	strb r5,[r0],#0x1	; 02328950
	sub r4,r4,#0x1	; 02328954
	b loc_023288CC	; 02328958
loc_0232895C:
	ldr r11,[pool_02328AB0]	; 0232895C
	ldr r1,[pool_02328AC0]	; 02328960
	ldr r2,[pool_02328AC4]	; 02328964
	ldr r6,[r11,#0x20]	; 02328968
	ldr r8,[r11,#0x0]	; 0232896C
	ldr r9,[r11,#0x10]	; 02328970
	ldr r10,[r11,#0x18]	; 02328974
loc_02328978:
	cmp r6,#0x800	; 02328978
	bcc loc_023289C4	; 0232897C
	mov r7,r10, lsr #0x1f	; 02328980
	cmp r8,#0x1f	; 02328984
	bne loc_023289A8	; 02328988
	ldr r10,[r9],#0x4	; 0232898C
	eor r3,r10,r10, ror #0x10	; 02328990
	bic r3,r3,#0xff0000	; 02328994
	mov r10,r10, ror #0x8	; 02328998
	eor r10,r10,r3, lsr #0x8	; 0232899C
	mov r8,#0x0	; 023289A0
	b loc_023289B0	; 023289A4
loc_023289A8:
	mov r10,r10, lsl #0x1	; 023289A8
	add r8,r8,#0x1	; 023289AC
loc_023289B0:
	mov r3,r6, lsl #0x1	; 023289B0
	cmp r7,#0x0	; 023289B4
	ldreqh r6,[r1,r3]	; 023289B8
	ldrneh r6,[r2,r3]	; 023289BC
	b loc_02328978	; 023289C0
loc_023289C4:
	str r8,[r11,#0x0]	; 023289C4
	str r9,[r11,#0x10]	; 023289C8
	str r10,[r11,#0x18]	; 023289CC
	sub r3,r0,r6	; 023289D0
	sub r5,r5,#0xfd	; 023289D4
	sub r3,r3,#0x1	; 023289D8
	sub r4,r4,r5	; 023289DC
loc_023289E0:
	ldrb r11,[r3],#0x1	; 023289E0
	subs r5,r5,#0x1	; 023289E4
	strb r11,[r0],#0x1	; 023289E8
	bne loc_023289E0	; 023289EC
	b loc_023288CC	; 023289F0
loc_023289F4:
	ldr r0,[sp],#0x4	; 023289F4

; ===== function loc_023289F8 =====
loc_023289F8:
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}	; 023289F8
	bx lr	; 023289FC

; ===== function loc_02328A00 =====
loc_02328A00:
	ldr r8,[r11,#0x0]	; 02328A00
	ldr r9,[r11,#0x10]	; 02328A04
	ldr r10,[r11,#0x18]	; 02328A08
	mov r7,#0x20	; 02328A0C
	sub r7,r7,r12	; 02328A10
	mov r7,r10, lsr r7	; 02328A14
	add r3,r8,r12	; 02328A18
	cmp r3,#0x20	; 02328A1C
	beq loc_02328A6C	; 02328A20
	bcc loc_02328A94	; 02328A24
	ldr r3,[r9],#0x4	; 02328A28
	eor r10,r3,r3, ror #0x10	; 02328A2C
	bic r10,r10,#0xff0000	; 02328A30
	mov r3,r3, ror #0x8	; 02328A34
	eor r3,r3,r10, lsr #0x8	; 02328A38
	str r9,[r11,#0x10]	; 02328A3C
	mov r10,#0x40	; 02328A40
	sub r9,r10,r12	; 02328A44
	sub r9,r9,r8	; 02328A48
	mov r9,r3, lsr r9	; 02328A4C
	orr r7,r7,r9	; 02328A50
	sub r12,r12,#0x20	; 02328A54
	add r8,r8,r12	; 02328A58
	str r8,[r11,#0x0]	; 02328A5C
	mov r12,r3, lsl r8	; 02328A60
	str r12,[r11,#0x18]	; 02328A64
	bx lr	; 02328A68
loc_02328A6C:
	ldr r3,[r9],#0x4	; 02328A6C
	eor r10,r3,r3, ror #0x10	; 02328A70
	bic r10,r10,#0xff0000	; 02328A74
	mov r3,r3, ror #0x8	; 02328A78
	eor r3,r3,r10, lsr #0x8	; 02328A7C
	str r9,[r11,#0x10]	; 02328A80
	str r3,[r11,#0x18]	; 02328A84
	mov r3,#0x0	; 02328A88
	str r3,[r11,#0x0]	; 02328A8C
	bx lr	; 02328A90
loc_02328A94:
	mov r3,r10, lsl r12	; 02328A94
	str r3,[r11,#0x18]	; 02328A98
	add r10,r8,r12	; 02328A9C
	str r10,[r11,#0x0]	; 02328AA0
	bx lr	; 02328AA4
pool_02328AA8:
loc_02328AA8:
	.word 0x023FE000	; 02328AA8
pool_02328AAC:
loc_02328AAC:
	.word 0x023DF1C0	; 02328AAC
pool_02328AB0:
loc_02328AB0:
	.word 0x023DF1C4	; 02328AB0
pool_02328AB4:
loc_02328AB4:
	.word 0x023DF200	; 02328AB4
pool_02328AB8:
loc_02328AB8:
	.word 0x023E0400	; 02328AB8
pool_02328ABC:
loc_02328ABC:
	.word 0x023DF400	; 02328ABC
pool_02328AC0:
loc_02328AC0:
	.word 0x023E1400	; 02328AC0
pool_02328AC4:
loc_02328AC4:
	.word 0x023E5400	; 02328AC4
	.byte 0x10, 0xB5, 0x00, 0xF0, 0x3B, 0xF8, 0x04, 0x1C, 0x00, 0x2C, 0x24, 0xD0, 0x14, 0x48, 0x10, 0x30	; 02328AD8
	.byte 0x14, 0x49, 0x02, 0x22, 0x00, 0xF0, 0x54, 0xF8, 0x00, 0x28, 0x1C, 0xD1, 0x10, 0x48, 0x80, 0x7F	; 02328AE8
	.byte 0x00, 0x28, 0x18, 0xD1, 0x10, 0x4A, 0x61, 0x1E, 0xB8, 0x20, 0x41, 0x43, 0x54, 0x18, 0x0F, 0x48	; 02328AF8
	.byte 0x0F, 0x49, 0x10, 0x4A, 0x05, 0xF0, 0x0A, 0xEA, 0x20, 0x1C, 0x0F, 0x49, 0xB8, 0x22, 0x05, 0xF0	; 02328B08
	.byte 0x06, 0xEA, 0x20, 0x1C, 0xB0, 0x30, 0x01, 0x68, 0xB4, 0x34, 0x20, 0x68, 0x01, 0x60, 0x01, 0x20	; 02328B18
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02328B28
	.byte 0x00, 0xFE, 0x7F, 0x02, 0xDC, 0x09, 0x33, 0x02, 0xEC, 0x02, 0x33, 0x02, 0xEC, 0x01, 0x33, 0x02	; 02328B38
	.byte 0x00, 0x50, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x52, 0x00, 0x02, 0x00, 0xB5, 0x81, 0xB0	; 02328B48
	.byte 0x0C, 0x48, 0x0D, 0x49, 0x04, 0x22, 0x00, 0xF0, 0x1B, 0xF8, 0x00, 0x28, 0x03, 0xD1, 0x01, 0x20	; 02328B58
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x07, 0x48, 0x08, 0x49, 0x04, 0x22, 0x00, 0xF0, 0x10, 0xF8	; 02328B68
	.byte 0x00, 0x28, 0x03, 0xD0, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x02, 0x20, 0x01, 0xB0	; 02328B78
	.byte 0x08, 0xBC, 0x18, 0x47, 0x0C, 0xFE, 0x7F, 0x02, 0xE0, 0x09, 0x33, 0x02, 0xE8, 0x09, 0x33, 0x02	; 02328B88
	.byte 0x10, 0xB4, 0x81, 0xB0, 0x00, 0x2A, 0x03, 0xD1, 0x00, 0x20, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47	; 02328B98
	.byte 0x0C, 0x78, 0x03, 0x78, 0xA3, 0x42, 0x0C, 0xD1, 0x52, 0x1E, 0x00, 0x2A, 0x03, 0xD1, 0x00, 0x20	; 02328BA8
	.byte 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x40, 0x1C, 0x49, 0x1C, 0x0C, 0x78, 0x03, 0x78, 0xA3, 0x42	; 02328BB8
	.byte 0xF2, 0xD0, 0x18, 0x1B, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x00, 0x00	; 02328BC4
.thumb

; ===== function loc_02328BC4 =====
loc_02328BC4:
	push {r4,lr}	; 02328BC4
	add r4,r0,#0x0	; 02328BC6
	bl loc_02328F70	; 02328BC8
	ldrh r1,[r4,#0x12]	; 02328BCC
	cmp r0,r1	; 02328BCE
	beq loc_02328BDC	; 02328BD0
	strh r0,[r4,#0x12]	; 02328BD2
	mov r0,#0x1	; 02328BD4
	pop {r4}	; 02328BD6
	pop {r3}	; 02328BD8
	bx r3	; 02328BDA
loc_02328BDC:
	mov r0,#0x0	; 02328BDC
	pop {r4}	; 02328BDE
	pop {r3}	; 02328BE0
	bx r3	; 02328BE2

; ===== function loc_02328BE4 =====
P1_Entry_02328BE4:
	push {r4,lr}	; 02328BE4
	add r4,r0,#0x0	; 02328BE6
	bl loc_02328F70	; 02328BE8
	ldr r1,[r4,#0xc]	; 02328BEC
	lsl r0,r0,#0x1	; 02328BEE
	ldrb r0,[r1,r0]	; 02328BF0
	pop {r4}	; 02328BF2
	pop {r3}	; 02328BF4
	bx r3	; 02328BF6

; ===== function loc_02328BF8 =====
loc_02328BF8:
	ldrh r0,[r0,#0x16]	; 02328BF8
	lsl r0,r0,#0x16	; 02328BFA
	lsr r0,r0,#0x1b	; 02328BFC
	ldrh r3,[r1,#0x0]	; 02328BFE
	cmp r3,#0x0	; 02328C00
	beq loc_02328C14	; 02328C02
	add r2,r2,r0	; 02328C04
loc_02328C06:
	cmp r3,#0xa	; 02328C06
	bne loc_02328C0C	; 02328C08
	add r0,r0,r2	; 02328C0A
loc_02328C0C:
	add r1,r1,#0x2	; 02328C0C
	ldrh r3,[r1,#0x0]	; 02328C0E
	cmp r3,#0x0	; 02328C10
	bne loc_02328C06	; 02328C12
loc_02328C14:
	bx lr	; 02328C14
	.byte 0x00, 0x00	; 02328C18

; ===== function loc_02328C18 =====
loc_02328C18:
	push {r4,r5,r6,r7,lr}	; 02328C18
	sub sp,#0x4	; 02328C1A
	add r5,r0,#0x0	; 02328C1C
	add r6,r2,#0x0	; 02328C1E
	mov r4,#0x0	; 02328C20
	str r4,[sp,#0x0]	; 02328C22
	cmp r1,#0x0	; 02328C24
	beq loc_02328C42	; 02328C26
	add r7,sp,#0x0	; 02328C28
loc_02328C2A:
	add r0,r5,#0x0	; 02328C2A
	add r2,r7,#0x0	; 02328C2C
	add r3,r6,#0x0	; 02328C2E
	bl loc_02328C4C	; 02328C30
	add r1,r0,#0x0	; 02328C34
	ldr r0,[sp,#0x0]	; 02328C36
	cmp r4,r0	; 02328C38
	bge loc_02328C3E	; 02328C3A
	add r4,r0,#0x0	; 02328C3C
loc_02328C3E:
	cmp r1,#0x0	; 02328C3E
	bne loc_02328C2A	; 02328C40
loc_02328C42:
	add r0,r4,#0x0	; 02328C42
	add sp,#0x4	; 02328C44
	pop {r4,r5,r6,r7}	; 02328C46
	pop {r3}	; 02328C48
	bx r3	; 02328C4A

; ===== function loc_02328C4C =====
loc_02328C4C:
	push {r4,r5,r6,r7,lr}	; 02328C4C
	sub sp,#0x4	; 02328C4E
	add r7,r0,#0x0	; 02328C50
	add r5,r1,#0x0	; 02328C52
	str r2,[sp,#0x0]	; 02328C54
	add r6,r3,#0x0	; 02328C56
	mov r4,#0x0	; 02328C58
	ldrh r1,[r5,#0x0]	; 02328C5A
	cmp r1,#0x0	; 02328C5C
	beq loc_02328C94	; 02328C5E
loc_02328C60:
	cmp r1,#0xa	; 02328C60
	bne loc_02328C7E	; 02328C62
	ldr r0,[sp,#0x0]	; 02328C64
	cmp r0,#0x0	; 02328C66
	beq loc_02328C74	; 02328C68
	cmp r4,r6	; 02328C6A
	ble loc_02328C70	; 02328C6C
	sub r4,r4,r6	; 02328C6E
loc_02328C70:
	ldr r0,[sp,#0x0]	; 02328C70
	str r4,[r0,#0x0]	; 02328C72
loc_02328C74:
	add r0,r5,#0x2	; 02328C74
	add sp,#0x4	; 02328C76
	pop {r4,r5,r6,r7}	; 02328C78
	pop {r3}	; 02328C7A
	bx r3	; 02328C7C
loc_02328C7E:
	cmp r1,#0xd	; 02328C7E
	beq loc_02328C8C	; 02328C80
	add r0,r7,#0x0	; 02328C82
	bl loc_02328CB0	; 02328C84
	add r0,r6,r0	; 02328C88
	add r4,r4,r0	; 02328C8A
loc_02328C8C:
	add r5,r5,#0x2	; 02328C8C
	ldrh r1,[r5,#0x0]	; 02328C8E
	cmp r1,#0x0	; 02328C90
	bne loc_02328C60	; 02328C92
loc_02328C94:
	ldr r0,[sp,#0x0]	; 02328C94
	cmp r0,#0x0	; 02328C96
	beq loc_02328CA4	; 02328C98
	cmp r4,r6	; 02328C9A
	ble loc_02328CA0	; 02328C9C
	sub r4,r4,r6	; 02328C9E
loc_02328CA0:
	ldr r0,[sp,#0x0]	; 02328CA0
	str r4,[r0,#0x0]	; 02328CA2
loc_02328CA4:
	mov r0,#0x0	; 02328CA4
	add sp,#0x4	; 02328CA6
	pop {r4,r5,r6,r7}	; 02328CA8
	pop {r3}	; 02328CAA
	bx r3	; 02328CAC
	.byte 0x00, 0x00	; 02328CB0

; ===== function loc_02328CB0 =====
loc_02328CB0:
	push {r4,lr}	; 02328CB0
	add r4,r0,#0x0	; 02328CB2
	bl loc_02328F70	; 02328CB4
	ldr r1,[r4,#0xc]	; 02328CB8
	lsl r0,r0,#0x1	; 02328CBA
	add r0,r1,r0	; 02328CBC
	ldrb r0,[r0,#0x1]	; 02328CBE
	pop {r4}	; 02328CC0
	pop {r3}	; 02328CC2
	bx r3	; 02328CC4
	.byte 0x00, 0x00	; 02328CC8

; ===== function loc_02328CC8 =====
loc_02328CC8:
	push {r0,r1,r2,r3}	; 02328CC8
	push {r4,r5,r6,r7,lr}	; 02328CCA
	sub sp,#0x1c	; 02328CCC
	add r5,r0,#0x0	; 02328CCE
	str r1,[sp,#0x8]	; 02328CD0
	ldr r1,[sp,#0x40]	; 02328CD2
	str r1,[sp,#0x40]	; 02328CD4
	ldr r1,[sp,#0x44]	; 02328CD6
	str r1,[sp,#0x44]	; 02328CD8
	ldr r6,[sp,#0x48]	; 02328CDA
	ldr r1,[sp,#0x4c]	; 02328CDC
	str r1,[sp,#0x4c]	; 02328CDE
	add r1,r6,#0x0	; 02328CE0
	ldr r2,[sp,#0x40]	; 02328CE2
	bl loc_02328C18	; 02328CE4
	add r4,r0,#0x0	; 02328CE8
	add r0,r5,#0x0	; 02328CEA
	add r1,r6,#0x0	; 02328CEC
	ldr r2,[sp,#0x44]	; 02328CEE
	bl loc_02328BF8	; 02328CF0
	str r0,[sp,#0x14]	; 02328CF4
	mov r1,sp	; 02328CF6
	sub r1,r1,#0x4	; 02328CF8
	add r0,sp,#0x30	; 02328CFA
	ldrh r0,[r0,#0x8]	; 02328CFC
	strh r0,[r1,#0x0]	; 02328CFE
	ldmia r1!,{r0}	; 02328D00
	add r1,r4,#0x0	; 02328D02
	bl loc_023290E0	; 02328D04
	add r7,r0,#0x0	; 02328D08
	mov r1,sp	; 02328D0A
	sub r1,r1,#0x4	; 02328D0C
	add r0,sp,#0x30	; 02328D0E
	ldrh r0,[r0,#0xc]	; 02328D10
	strh r0,[r1,#0x0]	; 02328D12
	ldmia r1!,{r0}	; 02328D14
	ldr r1,[sp,#0x14]	; 02328D16
	bl loc_023290A8	; 02328D18
	str r0,[sp,#0x10]	; 02328D1C
	mov r1,sp	; 02328D1E
	sub r1,r1,#0x4	; 02328D20
	add r0,sp,#0x30	; 02328D22
	ldrh r0,[r0,#0x8]	; 02328D24
	strh r0,[r1,#0x0]	; 02328D26
	ldmia r1!,{r0}	; 02328D28
	add r1,r4,#0x0	; 02328D2A
	bl loc_02328DD8	; 02328D2C
	add r4,r7,r0	; 02328D30
	str r4,[sp,#0xc]	; 02328D32
	add r0,r5,#0x0	; 02328D34
	add r1,r6,#0x0	; 02328D36
	add r2,sp,#0x18	; 02328D38
	ldr r3,[sp,#0x40]	; 02328D3A
	bl loc_02328C4C	; 02328D3C
	mov r1,sp	; 02328D40
	sub r1,r1,#0x4	; 02328D42
	add r0,sp,#0x30	; 02328D44
	ldrh r0,[r0,#0x8]	; 02328D46
	strh r0,[r1,#0x0]	; 02328D48
	ldmia r1!,{r0}	; 02328D4A
	ldr r1,[sp,#0x18]	; 02328D4C
	bl loc_02328DD8	; 02328D4E
	sub r4,r4,r0	; 02328D52
	ldrh r1,[r6,#0x0]	; 02328D54
	cmp r1,#0x0	; 02328D56
	beq loc_02328DCC	; 02328D58
loc_02328D5A:
	cmp r1,#0xa	; 02328D5A
	bne loc_02328D92	; 02328D5C
	add r0,r5,#0x0	; 02328D5E
	add r1,r6,#0x2	; 02328D60
	add r2,sp,#0x18	; 02328D62
	ldr r3,[sp,#0x40]	; 02328D64
	bl loc_02328C4C	; 02328D66
	mov r1,sp	; 02328D6A
	sub r1,r1,#0x4	; 02328D6C
	add r0,sp,#0x30	; 02328D6E
	ldrh r0,[r0,#0x8]	; 02328D70
	strh r0,[r1,#0x0]	; 02328D72
	ldmia r1!,{r0}	; 02328D74
	ldr r1,[sp,#0x18]	; 02328D76
	bl loc_02328DD8	; 02328D78
	ldr r1,[sp,#0xc]	; 02328D7C
	sub r4,r1,r0	; 02328D7E
	ldrh r0,[r5,#0x16]	; 02328D80
	lsl r0,r0,#0x16	; 02328D82
	lsr r1,r0,#0x1b	; 02328D84
	ldr r0,[sp,#0x44]	; 02328D86
	add r1,r1,r0	; 02328D88
	ldr r0,[sp,#0x10]	; 02328D8A
	add r0,r0,r1	; 02328D8C
	str r0,[sp,#0x10]	; 02328D8E
	b loc_02328DC4	; 02328D90
loc_02328D92:
	cmp r1,#0xd	; 02328D92
	beq loc_02328DC4	; 02328D94
	add r0,r5,#0x0	; 02328D96
	bl loc_02328F70	; 02328D98
	lsl r0,r0,#0x10	; 02328D9C
	lsr r0,r0,#0x10	; 02328D9E
	lsl r7,r0,#0x1	; 02328DA0
	str r0,[sp,#0x0]	; 02328DA2
	ldr r0,[sp,#0x4c]	; 02328DA4
	str r0,[sp,#0x4]	; 02328DA6
	add r0,r5,#0x0	; 02328DA8
	ldr r1,[sp,#0x8]	; 02328DAA
	ldr r2,[r5,#0xc]	; 02328DAC
	ldrb r2,[r2,r7]	; 02328DAE
	sub r2,r4,r2	; 02328DB0
	ldr r3,[sp,#0x10]	; 02328DB2
	bl loc_02328E0C	; 02328DB4
	ldr r0,[r5,#0xc]	; 02328DB8
	add r0,r0,r7	; 02328DBA
	ldrb r1,[r0,#0x1]	; 02328DBC
	ldr r0,[sp,#0x40]	; 02328DBE
	add r0,r0,r1	; 02328DC0
	add r4,r4,r0	; 02328DC2
loc_02328DC4:
	add r6,r6,#0x2	; 02328DC4
	ldrh r1,[r6,#0x0]	; 02328DC6
	cmp r1,#0x0	; 02328DC8
	bne loc_02328D5A	; 02328DCA
loc_02328DCC:
	add sp,#0x1c	; 02328DCC
	pop {r4,r5,r6,r7}	; 02328DCE
	pop {r3}	; 02328DD0
	add sp,#0x10	; 02328DD2
	bx r3	; 02328DD4
	.byte 0x00, 0x00	; 02328DD8

; ===== function loc_02328DD8 =====
loc_02328DD8:
	push {r0,r1,r2,r3}	; 02328DD8
	push {lr}	; 02328DDA
	sub sp,#0x4	; 02328DDC
	add r0,sp,#0x8	; 02328DDE
	ldrh r0,[r0,#0x0]	; 02328DE0
	lsl r0,r0,#0x10	; 02328DE2
	lsr r0,r0,#0x1e	; 02328DE4
	cmp r0,#0x1	; 02328DE6
	bne loc_02328DFA	; 02328DE8
	add r0,r1,#0x1	; 02328DEA
	mov r1,#0x2	; 02328DEC
	blx P1_SignedDivMod	; 02328DEE
	add sp,#0x4	; 02328DF2
	pop {r3}	; 02328DF4
	add sp,#0x10	; 02328DF6
	bx r3	; 02328DF8
loc_02328DFA:
	cmp r0,#0x2	; 02328DFA
	beq loc_02328E00	; 02328DFC
	mov r1,#0x0	; 02328DFE
loc_02328E00:
	add r0,r1,#0x0	; 02328E00
	add sp,#0x4	; 02328E02
	pop {r3}	; 02328E04
	add sp,#0x10	; 02328E06
	bx r3	; 02328E08
	.byte 0x00, 0x00	; 02328E0C

; ===== function loc_02328E0C =====
loc_02328E0C:
	push {r4,r5,r6,r7,lr}	; 02328E0C
	sub sp,#0x2c	; 02328E0E
	str r1,[sp,#0x0]	; 02328E10
	str r2,[sp,#0x4]	; 02328E12
	str r3,[sp,#0x8]	; 02328E14
	ldr r1,[sp,#0x44]	; 02328E16
	str r1,[sp,#0x44]	; 02328E18
	mov r5,#0x0	; 02328E1A
	add r4,r5,#0x0	; 02328E1C
	ldrh r2,[r0,#0x16]	; 02328E1E
	add r1,sp,#0x24	; 02328E20
	strh r2,[r1,#0x0]	; 02328E22
	ldr r2,[r0,#0x0]	; 02328E24
	mov r3,#0x14	; 02328E26
	ldrsh r3,[r0,r3]	; 02328E28
	add r0,sp,#0x30	; 02328E2A
	ldrh r0,[r0,#0x10]	; 02328E2C
	mul r3,r0	; 02328E2E
	lsl r0,r3,#0x1	; 02328E30
	add r7,r2,r0	; 02328E32
	str r5,[sp,#0xc]	; 02328E34
	ldrh r1,[r1,#0x0]	; 02328E36
	lsl r0,r1,#0x16	; 02328E38
	lsr r0,r0,#0x1b	; 02328E3A
	str r0,[sp,#0x14]	; 02328E3C
	cmp r0,#0x0	; 02328E3E
	ble loc_02328EA0	; 02328E40
	lsl r0,r1,#0x1b	; 02328E42
	lsr r0,r0,#0x1b	; 02328E44
	str r0,[sp,#0x10]	; 02328E46
	str r5,[sp,#0x20]	; 02328E48
	str r5,[sp,#0x1c]	; 02328E4A
loc_02328E4C:
	ldr r6,[sp,#0x1c]	; 02328E4C
	ldr r0,[sp,#0x10]	; 02328E4E
	cmp r0,#0x0	; 02328E50
	ble loc_02328E94	; 02328E52
	ldr r1,[sp,#0x8]	; 02328E54
	ldr r0,[sp,#0xc]	; 02328E56
	add r0,r1,r0	; 02328E58
	str r0,[sp,#0x18]	; 02328E5A
loc_02328E5C:
	cmp r4,#0x0	; 02328E5C
	bne loc_02328E62	; 02328E5E
	ldrh r5,[r7,#0x0]	; 02328E60
loc_02328E62:
	add r1,r5,#0x0	; 02328E62
	mov r0,#0x1	; 02328E64
	and r1,r0	; 02328E66
	cmp r1,#0x0	; 02328E68
	bne loc_02328E7A	; 02328E6A
	ldr r0,[sp,#0x0]	; 02328E6C
	ldr r1,[sp,#0x4]	; 02328E6E
	add r1,r1,r6	; 02328E70
	ldr r2,[sp,#0x18]	; 02328E72
	ldr r3,[sp,#0x44]	; 02328E74
	bl loc_02328EDC	; 02328E76
loc_02328E7A:
	lsl r0,r5,#0xf	; 02328E7A
	lsr r5,r0,#0x10	; 02328E7C
	add r0,r4,#0x1	; 02328E7E
	lsl r0,r0,#0x10	; 02328E80
	lsr r4,r0,#0x10	; 02328E82
	cmp r4,#0xf	; 02328E84
	bls loc_02328E8C	; 02328E86
	ldr r4,[sp,#0x20]	; 02328E88
	add r7,r7,#0x2	; 02328E8A
loc_02328E8C:
	add r6,r6,#0x1	; 02328E8C
	ldr r0,[sp,#0x10]	; 02328E8E
	cmp r6,r0	; 02328E90
	blt loc_02328E5C	; 02328E92
loc_02328E94:
	ldr r0,[sp,#0xc]	; 02328E94
	add r1,r0,#0x1	; 02328E96
	str r1,[sp,#0xc]	; 02328E98
	ldr r0,[sp,#0x14]	; 02328E9A
	cmp r1,r0	; 02328E9C
	blt loc_02328E4C	; 02328E9E
loc_02328EA0:
	add sp,#0x2c	; 02328EA0
	pop {r4,r5,r6,r7}	; 02328EA2
	pop {r3}	; 02328EA4
	bx r3	; 02328EA6

; ===== function loc_02328EA8 =====
P1_Entry_02328EA8:
	push {r4,r5,r6,r7,lr}	; 02328EA8
	sub sp,#0xc	; 02328EAA
	add r5,r0,#0x0	; 02328EAC
	add r4,r1,#0x0	; 02328EAE
	add r6,r2,#0x0	; 02328EB0
	add r7,r3,#0x0	; 02328EB2
	add r1,sp,#0x10	; 02328EB4
	ldrh r1,[r1,#0x10]	; 02328EB6
	bl loc_02328F70	; 02328EB8
	lsl r0,r0,#0x10	; 02328EBC
	lsr r0,r0,#0x10	; 02328EBE
	str r0,[sp,#0x0]	; 02328EC0
	ldr r0,[sp,#0x24]	; 02328EC2
	str r0,[sp,#0x4]	; 02328EC4
	add r0,r5,#0x0	; 02328EC6
	add r1,r4,#0x0	; 02328EC8
	add r2,r6,#0x0	; 02328ECA
	add r3,r7,#0x0	; 02328ECC
	bl loc_02328E0C	; 02328ECE
	add sp,#0xc	; 02328ED2
	pop {r4,r5,r6,r7}	; 02328ED4
	pop {r3}	; 02328ED6
	bx r3	; 02328ED8
	.byte 0x00, 0x00	; 02328EDC

; ===== function loc_02328EDC =====
loc_02328EDC:
	push {r4,lr}	; 02328EDC
	ldrh r4,[r0,#0x8]	; 02328EDE
	cmp r4,#0x0	; 02328EE0
	bne loc_02328EE8	; 02328EE2
	bl loc_02328EF0	; 02328EE4
loc_02328EE8:
	pop {r4}	; 02328EE8
	pop {r3}	; 02328EEA
	bx r3	; 02328EEC
	.byte 0x00, 0x00	; 02328EF0

; ===== function loc_02328EF0 =====
loc_02328EF0:
	push {r4,r5,r6,r7}	; 02328EF0
	sub sp,#0x18	; 02328EF2
	add r4,r0,#0x0	; 02328EF4
	add r0,r1,#0x0	; 02328EF6
	add r5,r2,#0x0	; 02328EF8
	str r3,[sp,#0x0]	; 02328EFA
	asr r3,r0,#0x3	; 02328EFC
	asr r7,r5,#0x3	; 02328EFE
	mov r2,#0x3	; 02328F00
	str r1,[sp,#0x10]	; 02328F02
	and r1,r2	; 02328F04
	str r1,[sp,#0x10]	; 02328F06
	asr r2,r0,#0x2	; 02328F08
	mov r1,#0x1	; 02328F0A
	and r2,r1	; 02328F0C
	mov r6,#0x7	; 02328F0E
	add r1,r5,#0x0	; 02328F10
	str r1,[sp,#0x4]	; 02328F12
	and r1,r6	; 02328F14
	str r1,[sp,#0x4]	; 02328F16
	ldrh r1,[r4,#0x4]	; 02328F18
	str r1,[sp,#0x8]	; 02328F1A
	lsl r1,r1,#0x4	; 02328F1C
	asr r1,r1,#0x3	; 02328F1E
	ldr r6,[r4,#0x0]	; 02328F20
	str r6,[sp,#0xc]	; 02328F22
	cmp r0,#0x0	; 02328F24
	blt loc_02328F68	; 02328F26
	ldr r6,[sp,#0x8]	; 02328F28
	cmp r0,r6	; 02328F2A
	bge loc_02328F68	; 02328F2C
	cmp r5,#0x0	; 02328F2E
	blt loc_02328F68	; 02328F30
	ldrh r0,[r4,#0x6]	; 02328F32
	cmp r5,r0	; 02328F34
	bge loc_02328F68	; 02328F36
	lsl r0,r3,#0x4	; 02328F38
	mul r1,r7	; 02328F3A
	add r0,r0,r1	; 02328F3C
	lsl r1,r0,#0x1	; 02328F3E
	ldr r0,[sp,#0xc]	; 02328F40
	add r4,r0,r1	; 02328F42
	ldr r0,[sp,#0x4]	; 02328F44
	lsl r0,r0,#0x1	; 02328F46
	add r0,r2,r0	; 02328F48
	lsl r3,r0,#0x1	; 02328F4A
	ldr r0,[sp,#0x10]	; 02328F4C
	lsl r2,r0,#0x2	; 02328F4E
	ldrh r1,[r4,r3]	; 02328F50
	mov r0,#0xf	; 02328F52
	add r5,r0,#0x0	; 02328F54
	lsl r5,r2	; 02328F56
	bic r1,r5	; 02328F58
	ldr r5,[sp,#0x0]	; 02328F5A
	lsl r5,r5,#0x18	; 02328F5C
	lsr r5,r5,#0x18	; 02328F5E
	and r5,r0	; 02328F60
	lsl r5,r2	; 02328F62
	orr r1,r5	; 02328F64
	strh r1,[r4,r3]	; 02328F66
loc_02328F68:
	add sp,#0x18	; 02328F68
	pop {r4,r5,r6,r7}	; 02328F6A
	bx lr	; 02328F6C
	.byte 0x00, 0x00	; 02328F70

; ===== function loc_02328F70 =====
loc_02328F70:
	push {r4,r5,r6,r7,lr}	; 02328F70
	sub sp,#0x14	; 02328F72
	str r0,[sp,#0x8]	; 02328F74
	add r6,r1,#0x0	; 02328F76
	mov r5,#0x0	; 02328F78
	add r7,r5,#0x0	; 02328F7A
	ldrh r0,[r0,#0x1a]	; 02328F7C
	str r0,[sp,#0xc]	; 02328F7E
	cmp r0,#0x0	; 02328F80
	ble loc_02328FC2	; 02328F82
	ldr r0,[sp,#0x8]	; 02328F84
	ldr r2,[r0,#0x8]	; 02328F86
	add r4,r2,#0x0	; 02328F88
	add r3,r5,#0x0	; 02328F8A
loc_02328F8C:
	ldrh r0,[r4,#0x0]	; 02328F8C
	cmp r0,r6	; 02328F8E
	bhi loc_02328FAA	; 02328F90
	add r0,r2,r3	; 02328F92
	ldrh r0,[r0,#0x2]	; 02328F94
	cmp r6,r0	; 02328F96
	bhi loc_02328FAA	; 02328F98
	add r1,r5,r6	; 02328F9A
	lsl r0,r7,#0x2	; 02328F9C
	ldrh r0,[r2,r0]	; 02328F9E
	sub r0,r1,r0	; 02328FA0
	add sp,#0x14	; 02328FA2
	pop {r4,r5,r6,r7}	; 02328FA4
	pop {r3}	; 02328FA6
	bx r3	; 02328FA8
loc_02328FAA:
	add r0,r2,r3	; 02328FAA
	ldrh r1,[r0,#0x2]	; 02328FAC
	ldrh r0,[r2,r3]	; 02328FAE
	sub r0,r1,r0	; 02328FB0
	add r0,r0,#0x1	; 02328FB2
	add r5,r5,r0	; 02328FB4
	add r4,r4,#0x4	; 02328FB6
	add r3,r3,#0x4	; 02328FB8
	add r7,r7,#0x1	; 02328FBA
	ldr r0,[sp,#0xc]	; 02328FBC
	cmp r7,r0	; 02328FBE
	blt loc_02328F8C	; 02328FC0
loc_02328FC2:
	lsl r0,r5,#0x10	; 02328FC2
	lsr r0,r0,#0x10	; 02328FC4
	str r0,[sp,#0x0]	; 02328FC6
	ldr r0,[sp,#0x8]	; 02328FC8
	ldrh r0,[r0,#0x12]	; 02328FCA
	str r0,[sp,#0x4]	; 02328FCC
	add r0,r6,#0x0	; 02328FCE
	mov r1,#0x0	; 02328FD0
	ldr r2,[sp,#0x8]	; 02328FD2
	ldrh r2,[r2,#0x18]	; 02328FD4
	sub r2,r2,#0x1	; 02328FD6
	ldr r3,[sp,#0x8]	; 02328FD8
	ldr r3,[r3,#0x4]	; 02328FDA
	bl loc_02328FE8	; 02328FDC
	add sp,#0x14	; 02328FE0
	pop {r4,r5,r6,r7}	; 02328FE2
	pop {r3}	; 02328FE4
	bx r3	; 02328FE6

; ===== function loc_02328FE8 =====
loc_02328FE8:
	push {r4,r5}	; 02328FE8
	cmp r1,r2	; 02328FEA
	bgt loc_02329018	; 02328FEC
loc_02328FEE:
	sub r4,r2,r1	; 02328FEE
	asr r4,r4,#0x1	; 02328FF0
	add r4,r1,r4	; 02328FF2
	lsl r5,r4,#0x1	; 02328FF4
	ldrh r5,[r3,r5]	; 02328FF6
	cmp r5,r0	; 02328FF8
	bls loc_02329000	; 02328FFA
	sub r2,r4,#0x1	; 02328FFC
	b loc_02329014	; 02328FFE
loc_02329000:
	cmp r5,r0	; 02329000
	bcs loc_02329008	; 02329002
	add r1,r4,#0x1	; 02329004
	b loc_02329014	; 02329006
loc_02329008:
	ldr r0,[pool_02329024]	; 02329008
	add r0,sp	; 0232900A
	ldrh r0,[r0,#0x10]	; 0232900C
	add r0,r0,r4	; 0232900E
	pop {r4,r5}	; 02329010
	bx lr	; 02329012
loc_02329014:
	cmp r1,r2	; 02329014
	ble loc_02328FEE	; 02329016
loc_02329018:
	ldr r0,[pool_02329024]	; 02329018
	add r0,sp	; 0232901A
	ldrh r0,[r0,#0x14]	; 0232901C
	pop {r4,r5}	; 0232901E
	bx lr	; 02329020
	.byte 0xC0, 0x46	; 02329024
pool_02329024:
loc_02329024:
	.word 0xFFFFFFF8	; 02329024

; ===== function loc_02329028 =====
loc_02329028:
	str r1,[r0,#0x0]	; 02329028
	strh r2,[r0,#0x4]	; 0232902A
	strh r3,[r0,#0x6]	; 0232902C
	ldr r1,[sp,#0x0]	; 0232902E
	strh r1,[r0,#0x8]	; 02329030
	ldr r1,[sp,#0x4]	; 02329032
	str r1,[r0,#0xc]	; 02329034
	bx lr	; 02329036

; ===== function loc_02329038 =====
loc_02329038:
	push {r4}	; 02329038
	sub sp,#0x4	; 0232903A
	ldrh r3,[r1,#0x6]	; 0232903C
	strh r3,[r0,#0x10]	; 0232903E
	ldrh r3,[r1,#0x8]	; 02329040
	strh r3,[r0,#0x16]	; 02329042
	add r1,#0xa	; 02329044
	str r1,[r0,#0xc]	; 02329046
	ldr r3,[r0,#0xc]	; 02329048
	ldrh r1,[r0,#0x10]	; 0232904A
	lsl r1,r1,#0x1	; 0232904C
	add r1,r3,r1	; 0232904E
	str r1,[r0,#0x0]	; 02329050
	ldrh r1,[r0,#0x16]	; 02329052
	lsl r3,r1,#0x1b	; 02329054
	lsr r3,r3,#0x1b	; 02329056
	lsl r1,r1,#0x16	; 02329058
	lsr r1,r1,#0x1b	; 0232905A
	mul r3,r1	; 0232905C
	add r3,#0xf	; 0232905E
	asr r1,r3,#0x4	; 02329060
	strh r1,[r0,#0x14]	; 02329062
	mov r1,#0x0	; 02329064
	strh r1,[r0,#0x12]	; 02329066
	ldr r3,[r0,#0x1c]	; 02329068
	mov r1,#0x1	; 0232906A
	bic r3,r1	; 0232906C
	orr r3,r1	; 0232906E
	str r3,[r0,#0x1c]	; 02329070
	ldr r3,[r0,#0x1c]	; 02329072
	mov r1,#0x2	; 02329074
	orr r3,r1	; 02329076
	str r3,[r0,#0x1c]	; 02329078
	add r4,r2,#0x0	; 0232907A
	add r4,#0x8	; 0232907C
	ldr r1,[r4,#0x4]	; 0232907E
	add r1,r2,r1	; 02329080
	ldrh r1,[r1,#0x8]	; 02329082
	strh r1,[r0,#0x18]	; 02329084
	add r3,r2,#0x0	; 02329086
	add r3,#0xc	; 02329088
	ldr r1,[r4,#0x4]	; 0232908A
	add r1,r3,r1	; 0232908C
	str r1,[r0,#0x4]	; 0232908E
	ldr r1,[r2,#0x8]	; 02329090
	add r1,r2,r1	; 02329092
	ldrh r1,[r1,#0x8]	; 02329094
	strh r1,[r0,#0x1a]	; 02329096
	add r3,r2,#0x0	; 02329098
	add r3,#0xa	; 0232909A
	ldr r1,[r2,#0x8]	; 0232909C
	add r1,r3,r1	; 0232909E
	str r1,[r0,#0x8]	; 023290A0
	add sp,#0x4	; 023290A2
	pop {r4}	; 023290A4
	bx lr	; 023290A6

; ===== function loc_023290A8 =====
loc_023290A8:
	push {r0,r1,r2,r3}	; 023290A8
	push {r4,lr}	; 023290AA
	add r2,sp,#0x8	; 023290AC
	mov r0,#0x0	; 023290AE
	ldrsh r0,[r2,r0]	; 023290B0
	lsl r0,r0,#0x14	; 023290B2
	asr r4,r0,#0x14	; 023290B4
	ldrh r0,[r2,#0x0]	; 023290B6
	lsl r0,r0,#0x12	; 023290B8
	lsr r0,r0,#0x1e	; 023290BA
	cmp r0,#0x1	; 023290BC
	beq loc_023290C6	; 023290BE
	cmp r0,#0x2	; 023290C0
	beq loc_023290D2	; 023290C2
	b loc_023290D4	; 023290C4
loc_023290C6:
	add r0,r1,#0x1	; 023290C6
	mov r1,#0x2	; 023290C8
	blx P1_SignedDivMod	; 023290CA
	sub r4,r4,r0	; 023290CE
	b loc_023290D4	; 023290D0
loc_023290D2:
	sub r4,r4,r1	; 023290D2
loc_023290D4:
	add r0,r4,#0x0	; 023290D4
	pop {r4}	; 023290D6
	pop {r3}	; 023290D8
	add sp,#0x10	; 023290DA
	bx r3	; 023290DC
	.byte 0x00, 0x00	; 023290E0

; ===== function loc_023290E0 =====
loc_023290E0:
	push {r0,r1,r2,r3}	; 023290E0
	push {r4,lr}	; 023290E2
	add r2,sp,#0x8	; 023290E4
	mov r0,#0x0	; 023290E6
	ldrsh r0,[r2,r0]	; 023290E8
	lsl r0,r0,#0x14	; 023290EA
	asr r4,r0,#0x14	; 023290EC
	ldrh r0,[r2,#0x0]	; 023290EE
	lsl r0,r0,#0x12	; 023290F0
	lsr r0,r0,#0x1e	; 023290F2
	cmp r0,#0x1	; 023290F4
	beq loc_023290FE	; 023290F6
	cmp r0,#0x2	; 023290F8
	beq loc_0232910A	; 023290FA
	b loc_0232910C	; 023290FC
loc_023290FE:
	add r0,r1,#0x1	; 023290FE
	mov r1,#0x2	; 02329100
	blx P1_SignedDivMod	; 02329102
	sub r4,r4,r0	; 02329106
	b loc_0232910C	; 02329108
loc_0232910A:
	sub r4,r4,r1	; 0232910A
loc_0232910C:
	add r0,r4,#0x0	; 0232910C
	pop {r4}	; 0232910E
	pop {r3}	; 02329110
	add sp,#0x10	; 02329112
	bx r3	; 02329114
	.byte 0x00, 0x00	; 02329118

; ===== function loc_02329118 =====
loc_02329118:
	push {r4,r5,lr}	; 02329118
	sub sp,#0x14	; 0232911A
	add r4,r0,#0x0	; 0232911C
	add r3,r1,#0x0	; 0232911E
	mov r0,#0x4	; 02329120
	ldrsb r0,[r3,r0]	; 02329122
	str r0,[sp,#0x0]	; 02329124
	mov r0,#0x5	; 02329126
	ldrsb r0,[r3,r0]	; 02329128
	str r0,[sp,#0x4]	; 0232912A
	str r2,[sp,#0x8]	; 0232912C
	ldrb r0,[r3,#0x6]	; 0232912E
	str r0,[sp,#0xc]	; 02329130
	ldr r1,[r4,#0xc]	; 02329132
	ldrh r0,[r3,#0x6]	; 02329134
	lsl r0,r0,#0x10	; 02329136
	lsr r0,r0,#0x1c	; 02329138
	lsl r0,r0,#0x5	; 0232913A
	add r0,r1,r0	; 0232913C
	add r1,r4,#0x0	; 0232913E
	mov r4,sp	; 02329140
	sub r4,r4,#0x4	; 02329142
	ldrh r2,[r3,#0x0]	; 02329144
	strh r2,[r4,#0x0]	; 02329146
	add r5,r4,#0x0	; 02329148
	ldmia r5!,{r2}	; 0232914A
	ldrh r3,[r3,#0x2]	; 0232914C
	strh r3,[r4,#0x0]	; 0232914E
	ldmia r4!,{r3}	; 02329150
	bl loc_02328CC8	; 02329152
	add sp,#0x14	; 02329156
	pop {r4,r5}	; 02329158
	pop {r3}	; 0232915A
	bx r3	; 0232915C
	.byte 0x00, 0x00	; 02329160

; ===== function loc_02329160 =====
loc_02329160:
	push {r4,r5,r6,r7,lr}	; 02329160
	sub sp,#0x4	; 02329162
	add r7,r0,#0x0	; 02329164
	str r1,[sp,#0x0]	; 02329166
	ldrh r6,[r1,#0x6]	; 02329168
	lsl r4,r1,#0	; 0232916A
	add r4,#0x8	; 0232916C
	mov r5,#0x0	; 0232916E
	cmp r6,#0x0	; 02329170
	ble loc_0232918E	; 02329172
loc_02329174:
	ldr r3,[r4,#0x8]	; 02329174
	cmp r3,#0x0	; 02329176
	beq loc_02329186	; 02329178
	add r0,r7,#0x0	; 0232917A
	add r1,r4,#0x0	; 0232917C
	ldr r2,[sp,#0x0]	; 0232917E
	add r2,r2,r3	; 02329180
	bl loc_02329118	; 02329182
loc_02329186:
	add r4,#0xc	; 02329186
	add r5,r5,#0x1	; 02329188
	cmp r5,r6	; 0232918A
	blt loc_02329174	; 0232918C
loc_0232918E:
	add sp,#0x4	; 0232918E
	pop {r4,r5,r6,r7}	; 02329190
	pop {r3}	; 02329192
	bx r3	; 02329194
	.byte 0x00, 0x00	; 02329198

; ===== function loc_02329198 =====
loc_02329198:
	ldrh r2,[r0,#0x6]	; 02329198
	add r0,#0x8	; 0232919A
	cmp r1,#0x0	; 0232919C
	blt loc_023291A4	; 0232919E
	cmp r1,r2	; 023291A0
	blt loc_023291A8	; 023291A2
loc_023291A4:
	mov r0,#0x0	; 023291A4
	bx lr	; 023291A6
loc_023291A8:
	mov r2,#0xc	; 023291A8
	mul r1,r2	; 023291AA
	add r0,r0,r1	; 023291AC
	bx lr	; 023291AE

; ===== function loc_023291B0 =====
loc_023291B0:
	ldr r2,[r0,#0x8]	; 023291B0
	add r2,r0,r2	; 023291B2
	mov r0,#0x6	; 023291B4
	mul r1,r0	; 023291B6
	add r0,r2,r1	; 023291B8
	bx lr	; 023291BA

; ===== function loc_023291BC =====
loc_023291BC:
	ldr r0,[r0,#0x14]	; 023291BC
	bx lr	; 023291BE

; ===== function loc_023291C0 =====
loc_023291C0:
	ldr r1,[r0,#0x10]	; 023291C0
	add r0,r0,r1	; 023291C2
	bx lr	; 023291C4
	.byte 0x00, 0x00	; 023291C8

; ===== function loc_023291C8 =====
loc_023291C8:
	ldr r2,[r0,#0xc]	; 023291C8
	add r2,r0,r2	; 023291CA
	ldr r3,[r0,#0x8]	; 023291CC
	add r3,r0,r3	; 023291CE
	mov r0,#0x6	; 023291D0
	mul r1,r0	; 023291D2
	add r0,r3,r1	; 023291D4
	ldrh r1,[r0,#0x2]	; 023291D6
	mov r0,#0xc	; 023291D8
	mul r1,r0	; 023291DA
	add r0,r2,r1	; 023291DC
	bx lr	; 023291DE

; ===== function loc_023291E0 =====
loc_023291E0:
	ldr r2,[r0,#0x8]	; 023291E0
	add r2,r0,r2	; 023291E2
	mov r0,#0x6	; 023291E4
	mul r1,r0	; 023291E6
	add r0,r2,r1	; 023291E8
	ldrh r0,[r0,#0x4]	; 023291EA
	bx lr	; 023291EC
	.byte 0x00, 0x00	; 023291F0

; ===== function loc_023291F0 =====
loc_023291F0:
	push {r4,r5,r6,r7,lr}	; 023291F0
	sub sp,#0xc	; 023291F2
	str r0,[sp,#0x0]	; 023291F4
	add r7,r1,#0x0	; 023291F6
	str r2,[sp,#0x4]	; 023291F8
	lsl r4,r0,#0	; 023291FA
	add r4,#0x8	; 023291FC
	mov r5,#0x0	; 023291FE
	bl loc_0232929C	; 02329200
	cmp r0,#0x0	; 02329204
	ble loc_0232925E	; 02329206
loc_02329208:
	mov r1,sp	; 02329208
	sub r1,r1,#0x4	; 0232920A
	ldrh r0,[r4,#0x0]	; 0232920C
	strh r0,[r1,#0x0]	; 0232920E
	ldmia r1!,{r0}	; 02329210
	ldrb r1,[r4,#0x4]	; 02329212
	bl loc_023290E0	; 02329214
	add r6,r0,#0x0	; 02329218
	mov r1,sp	; 0232921A
	sub r1,r1,#0x4	; 0232921C
	ldrh r0,[r4,#0x2]	; 0232921E
	strh r0,[r1,#0x0]	; 02329220
	ldmia r1!,{r0}	; 02329222
	ldrb r1,[r4,#0x5]	; 02329224
	bl loc_023290A8	; 02329226
	ldrb r1,[r4,#0x4]	; 0232922A
	add r2,r6,r1	; 0232922C
	ldrb r1,[r4,#0x5]	; 0232922E
	add r1,r0,r1	; 02329230
	cmp r6,r7	; 02329232
	bgt loc_02329250	; 02329234
	cmp r7,r2	; 02329236
	bgt loc_02329250	; 02329238
	ldr r2,[sp,#0x4]	; 0232923A
	cmp r0,r2	; 0232923C
	bgt loc_02329250	; 0232923E
	lsl r0,r2,#0	; 02329240
	cmp r0,r1	; 02329242
	bgt loc_02329250	; 02329244
	add r0,r5,#0x0	; 02329246
	add sp,#0xc	; 02329248
	pop {r4,r5,r6,r7}	; 0232924A
	pop {r3}	; 0232924C
	bx r3	; 0232924E
loc_02329250:
	add r5,r5,#0x1	; 02329250
	add r4,r4,#0x6	; 02329252
	ldr r0,[sp,#0x0]	; 02329254
	bl loc_0232929C	; 02329256
	cmp r5,r0	; 0232925A
	blt loc_02329208	; 0232925C
loc_0232925E:
	mov r0,#0x0	; 0232925E
	mvn r0,r0	; 02329260
	add sp,#0xc	; 02329262
	pop {r4,r5,r6,r7}	; 02329264
	pop {r3}	; 02329266
	bx r3	; 02329268
	.byte 0x00, 0x00	; 0232926C

; ===== function loc_0232926C =====
loc_0232926C:
	push {r4,r5,lr}	; 0232926C
	sub sp,#0x4	; 0232926E
	add r5,r1,#0x0	; 02329270
	add r4,r0,#0x0	; 02329272
	add r4,#0x8	; 02329274
	cmp r5,#0x0	; 02329276
	blt loc_02329282	; 02329278
	bl loc_0232929C	; 0232927A
	cmp r5,r0	; 0232927E
	blt loc_0232928C	; 02329280
loc_02329282:
	mov r0,#0x0	; 02329282
	add sp,#0x4	; 02329284
	pop {r4,r5}	; 02329286
	pop {r3}	; 02329288
	bx r3	; 0232928A
loc_0232928C:
	mov r0,#0x6	; 0232928C
	mul r5,r0	; 0232928E
	add r0,r4,r5	; 02329290
	add sp,#0x4	; 02329292
	pop {r4,r5}	; 02329294
	pop {r3}	; 02329296
	bx r3	; 02329298
	.byte 0x00, 0x00	; 0232929C

; ===== function loc_0232929C =====
loc_0232929C:
	ldrh r0,[r0,#0x6]	; 0232929C
	bx lr	; 0232929E

; ===== function loc_023292A0 =====
loc_023292A0:
	push {r4,r5,r6,r7,lr}	; 023292A0
	sub sp,#0x14	; 023292A2
	str r0,[sp,#0x0]	; 023292A4
	str r1,[sp,#0x4]	; 023292A6
	str r2,[sp,#0x8]	; 023292A8
	str r3,[sp,#0xc]	; 023292AA
	lsl r0,r2,#0	; 023292AC
	lsr r6,r0,#0x1	; 023292AE
	mov r5,#0x0	; 023292B0
	add r4,sp,#0x10	; 023292B2
	ldr r1,[pool_023293E0]	; 023292B4
	ldr r7,[pool_023293E4]	; 023292B6
loc_023292B8:
	add r0,r5,r6	; 023292B8
	sub r0,r0,#0x2	; 023292BA
	lsl r3,r0,#0x1	; 023292BC
	ldr r0,[sp,#0x0]	; 023292BE
	ldrsh r2,[r0,r3]	; 023292C0
	ldr r0,[sp,#0x4]	; 023292C2
	ldrsh r0,[r0,r3]	; 023292C4
	sub r0,r2,r0	; 023292C6
	cmp r0,r1	; 023292C8
	bge loc_023292D0	; 023292CA
	add r0,r1,#0x0	; 023292CC
	b loc_023292D6	; 023292CE
loc_023292D0:
	cmp r0,r7	; 023292D0
	blt loc_023292D6	; 023292D2
	ldr r0,[pool_023293E8]	; 023292D4
loc_023292D6:
	strh r0,[r4,#0x0]	; 023292D6
	add r4,r4,#0x2	; 023292D8
	add r5,r5,#0x1	; 023292DA
	cmp r5,#0x2	; 023292DC
	blt loc_023292B8	; 023292DE
	sub r0,r6,#0x1	; 023292E0
	cmp r0,#0x2	; 023292E2
	blt loc_0232935E	; 023292E4
	lsl r3,r0,#0x1	; 023292E6
	ldr r1,[sp,#0x0]	; 023292E8
	add r2,r1,r3	; 023292EA
	ldr r1,[sp,#0x4]	; 023292EC
	add r1,r1,r3	; 023292EE
	ldr r7,[pool_023293E0]	; 023292F0
	mov r4,#0x0	; 023292F2
loc_023292F4:
	sub r3,r0,#0x2	; 023292F4
	lsl r6,r3,#0x1	; 023292F6
	ldr r3,[sp,#0x0]	; 023292F8
	ldrsh r5,[r3,r6]	; 023292FA
	ldr r3,[sp,#0x4]	; 023292FC
	ldrsh r3,[r3,r6]	; 023292FE
	sub r6,r5,r3	; 02329300
	cmp r6,#0x0	; 02329302
	blt loc_0232932E	; 02329304
	ldrsh r3,[r2,r4]	; 02329306
	add r5,r6,r3	; 02329308
	ldr r3,[pool_023293E4]	; 0232930A
	cmp r5,r3	; 0232930C
	bge loc_02329316	; 0232930E
	lsl r3,r5,#0x10	; 02329310
	asr r3,r3,#0x10	; 02329312
	b loc_02329318	; 02329314
loc_02329316:
	ldr r3,[pool_023293E8]	; 02329316
loc_02329318:
	strh r3,[r2,#0x0]	; 02329318
	ldrsh r3,[r1,r4]	; 0232931A
	sub r3,r3,r6	; 0232931C
	cmp r3,r7	; 0232931E
	blt loc_02329328	; 02329320
	lsl r3,r3,#0x10	; 02329322
	asr r3,r3,#0x10	; 02329324
	b loc_0232932A	; 02329326
loc_02329328:
	add r3,r7,#0x0	; 02329328
loc_0232932A:
	strh r3,[r1,#0x0]	; 0232932A
	b loc_02329354	; 0232932C
loc_0232932E:
	ldrsh r3,[r2,r4]	; 0232932E
	add r3,r6,r3	; 02329330
	cmp r3,r7	; 02329332
	blt loc_0232933C	; 02329334
	lsl r3,r3,#0x10	; 02329336
	asr r3,r3,#0x10	; 02329338
	b loc_0232933E	; 0232933A
loc_0232933C:
	add r3,r7,#0x0	; 0232933C
loc_0232933E:
	strh r3,[r2,#0x0]	; 0232933E
	ldrsh r3,[r1,r4]	; 02329340
	sub r5,r3,r6	; 02329342
	ldr r3,[pool_023293E4]	; 02329344
	cmp r5,r3	; 02329346
	bge loc_02329350	; 02329348
	lsl r3,r5,#0x10	; 0232934A
	asr r3,r3,#0x10	; 0232934C
	b loc_02329352	; 0232934E
loc_02329350:
	ldr r3,[pool_023293E8]	; 02329350
loc_02329352:
	strh r3,[r1,#0x0]	; 02329352
loc_02329354:
	sub r2,r2,#0x2	; 02329354
	sub r1,r1,#0x2	; 02329356
	sub r0,r0,#0x1	; 02329358
	cmp r0,#0x2	; 0232935A
	bge loc_023292F4	; 0232935C
loc_0232935E:
	mov r1,#0x1	; 0232935E
	ldr r0,[sp,#0xc]	; 02329360
	add r4,r0,#0x4	; 02329362
	ldr r0,[sp,#0x0]	; 02329364
	add r3,r0,#0x2	; 02329366
	ldr r0,[sp,#0x4]	; 02329368
	add r2,r0,#0x2	; 0232936A
	ldr r0,[pool_023293E0]	; 0232936C
loc_0232936E:
	mov r5,#0x0	; 0232936E
	ldrsh r6,[r3,r5]	; 02329370
	ldr r5,[r4,#0xc]	; 02329372
	add r6,r6,r5	; 02329374
	cmp r6,r0	; 02329376
	bge loc_0232937E	; 02329378
	add r6,r0,#0x0	; 0232937A
	b loc_02329386	; 0232937C
loc_0232937E:
	ldr r5,[pool_023293E4]	; 0232937E
	cmp r6,r5	; 02329380
	blt loc_02329386	; 02329382
	ldr r6,[pool_023293E8]	; 02329384
loc_02329386:
	strh r6,[r3,#0x0]	; 02329386
	mov r5,#0x0	; 02329388
	ldrsh r6,[r2,r5]	; 0232938A
	ldr r5,[r4,#0xc]	; 0232938C
	sub r6,r6,r5	; 0232938E
	cmp r6,r0	; 02329390
	bge loc_02329398	; 02329392
	add r6,r0,#0x0	; 02329394
	b loc_023293A0	; 02329396
loc_02329398:
	ldr r5,[pool_023293E4]	; 02329398
	cmp r6,r5	; 0232939A
	blt loc_023293A0	; 0232939C
	ldr r6,[pool_023293E8]	; 0232939E
loc_023293A0:
	strh r6,[r2,#0x0]	; 023293A0
	sub r4,r4,#0x4	; 023293A2
	sub r3,r3,#0x2	; 023293A4
	sub r2,r2,#0x2	; 023293A6
	sub r1,r1,#0x1	; 023293A8
	cmp r1,#0x0	; 023293AA
	bge loc_0232936E	; 023293AC
	mov r3,#0x0	; 023293AE
	add r4,sp,#0x10	; 023293B0
	add r1,r3,#0x0	; 023293B2
loc_023293B4:
	ldrsh r2,[r4,r1]	; 023293B4
	ldr r0,[sp,#0xc]	; 023293B6
	str r2,[r0,#0xc]	; 023293B8
	add r4,r4,#0x2	; 023293BA
	add r0,r0,#0x4	; 023293BC
	str r0,[sp,#0xc]	; 023293BE
	add r3,r3,#0x1	; 023293C0
	cmp r3,#0x2	; 023293C2
	blt loc_023293B4	; 023293C4
	ldr r0,[sp,#0x0]	; 023293C6
	ldr r1,[sp,#0x8]	; 023293C8
	blx P1_CleanAndInvalidateDataCacheRange	; 023293CA
	ldr r0,[sp,#0x4]	; 023293CE
	ldr r1,[sp,#0x8]	; 023293D0
	blx P1_CleanAndInvalidateDataCacheRange	; 023293D2
	add sp,#0x14	; 023293D6
	pop {r4,r5,r6,r7}	; 023293D8
	pop {r3}	; 023293DA
	bx r3	; 023293DC
	.byte 0xC0, 0x46	; 023293E0
pool_023293E0:
loc_023293E0:
	.word 0xFFFF8000	; 023293E0
pool_023293E4:
loc_023293E4:
	.word 0x00008000	; 023293E4
pool_023293E8:
loc_023293E8:
	.word 0x00007FFF	; 023293E8

; ===== function loc_023293EC =====
	push {r4,r5,r6,r7,lr}	; 023293EC
	sub sp,#0xc	; 023293EE
	add r7,r0,#0x0	; 023293F0
	str r1,[sp,#0x4]	; 023293F2
	str r2,[sp,#0x8]	; 023293F4
	ldr r4,[sp,#0x20]	; 023293F6
	ldr r6,[r4,#0x4]	; 023293F8
	cmp r6,#0x0	; 023293FA
	beq loc_02329404	; 023293FC
	ldr r5,[r4,#0x8]	; 023293FE
	str r5,[sp,#0x0]	; 02329400
	blx r6	; 02329402
loc_02329404:
	ldr r0,[r4,#0x0]	; 02329404
	cmp r0,#0x0	; 02329406
	beq loc_0232941A	; 02329408
	cmp r0,#0x1	; 0232940A
	bne loc_0232941A	; 0232940C
	add r0,r7,#0x0	; 0232940E
	ldr r1,[sp,#0x4]	; 02329410
	ldr r2,[sp,#0x8]	; 02329412
	add r3,r4,#0x0	; 02329414
	bl loc_023292A0	; 02329416
loc_0232941A:
	add sp,#0xc	; 0232941A
	pop {r4,r5,r6,r7}	; 0232941C
	pop {r3}	; 0232941E
	bx r3	; 02329420
	.byte 0x00, 0x00	; 02329424

; ===== function loc_02329424 =====
loc_02329424:
	push {lr}	; 02329424
	sub sp,#0x4	; 02329426
	ldr r0,[pool_02329440]	; 02329428
	ldr r0,[r0,#0x0]	; 0232942A
	cmp r0,#0x1	; 0232942C
	bne loc_02329436	; 0232942E
	mov r0,#0x0	; 02329430
	bl loc_0232DF8C	; 02329432
loc_02329436:
	bl loc_0232A85C	; 02329436
	add sp,#0x4	; 0232943A
	pop {r3}	; 0232943C
	bx r3	; 0232943E
pool_02329440:
loc_02329440:
	.word P1_BssStart + 0x2593C	; 02329440

; ===== function loc_02329444 =====
loc_02329444:
	push {r4,r5,r6,lr}	; 02329444
	sub sp,#0x10	; 02329446
	add r5,r0,#0x0	; 02329448
	add r6,r1,#0x0	; 0232944A
	add r4,r2,#0x0	; 0232944C
	mov r1,#0x0	; 0232944E
	add r0,sp,#0xc	; 02329450
	strh r1,[r0,#0x0]	; 02329452
	ldrh r0,[r0,#0x0]	; 02329454
	ldr r1,[pool_0232948C]	; 02329456
	mov r2,#0xc0	; 02329458
	blx loc_0232DE18	; 0232945A
	ldr r0,[pool_02329490]	; 0232945E
	str r4,[r0,#0x0]	; 02329460
	cmp r4,#0x1	; 02329462
	bne loc_0232946C	; 02329464
	ldr r0,[pool_02329494]	; 02329466
	bl loc_0232DF8C	; 02329468
loc_0232946C:
	mov r0,#0x2	; 0232946C
	str r0,[sp,#0x0]	; 0232946E
	ldr r0,[pool_02329498]	; 02329470
	str r0,[sp,#0x4]	; 02329472
	ldr r0,[pool_02329490]	; 02329474
	str r0,[sp,#0x8]	; 02329476
	add r0,r5,#0x0	; 02329478
	add r1,r6,#0x0	; 0232947A
	mov r2,#0x0	; 0232947C
	ldr r3,[pool_0232949C]	; 0232947E
	bl loc_0232A87C	; 02329480
	add sp,#0x10	; 02329484
	pop {r4,r5,r6}	; 02329486
	pop {r3}	; 02329488
	bx r3	; 0232948A
pool_0232948C:
loc_0232948C:
	.word 0x023563C8	; 0232948C
pool_02329490:
loc_02329490:
	.word P1_BssStart + 0x2593C	; 02329490
pool_02329494:
loc_02329494:
	.word 0x00003000	; 02329494
pool_02329498:
loc_02329498:
	.word 0x023293ED	; 02329498
pool_0232949C:
loc_0232949C:
	.word 0x00007D00	; 0232949C

; ===== function loc_023294A0 =====
loc_023294A0:
	mov r0,#0x1	; 023294A0
	ldr r3,[pool_023294A8]	; 023294A2
	bx r3	; 023294A4
	.byte 0xC0, 0x46	; 023294A8
pool_023294A8:
loc_023294A8:
	.word loc_0232C744 + 1	; 023294A8

; ===== function loc_023294AC =====
loc_023294AC:
	push {r4,r5,lr}	; 023294AC
	sub sp,#0x4	; 023294AE
	add r5,r0,#0x0	; 023294B0
	bl loc_023294A0	; 023294B2
	cmp r0,#0x0	; 023294B6
	bne loc_023294C6	; 023294B8
	mov r0,#0x2	; 023294BA
	mvn r0,r0	; 023294BC
	add sp,#0x4	; 023294BE
	pop {r4,r5}	; 023294C0
	pop {r3}	; 023294C2
	bx r3	; 023294C4
loc_023294C6:
	bl loc_02329564	; 023294C6
	add r4,r0,#0x0	; 023294CA
	mov r0,#0x0	; 023294CC
	mvn r0,r0	; 023294CE
	cmp r4,r0	; 023294D0
	beq loc_023294EE	; 023294D2
	add r0,r5,#0x0	; 023294D4
	bl loc_02329520	; 023294D6
	lsl r0,r4,#0x10	; 023294DA
	lsr r0,r0,#0x10	; 023294DC
	bl loc_02329540	; 023294DE
	mov r1,#0x1	; 023294E2
	mvn r1,r1	; 023294E4
	cmp r0,r1	; 023294E6
	beq loc_023294EC	; 023294E8
	mov r1,#0x0	; 023294EA
loc_023294EC:
	add r0,r1,#0x0	; 023294EC
loc_023294EE:
	add sp,#0x4	; 023294EE
	pop {r4,r5}	; 023294F0
	pop {r3}	; 023294F2
	bx r3	; 023294F4
	.byte 0x00, 0x00	; 023294F8

; ===== function loc_023294F8 =====
loc_023294F8:
	push {lr}	; 023294F8
	sub sp,#0x4	; 023294FA
	mov r3,#0x0	; 023294FC
	ldr r2,[pool_0232951C]	; 023294FE
	add r0,r3,#0x0	; 02329500
loc_02329502:
	ldrsb r1,[r2,r0]	; 02329502
	add r2,r2,#0x1	; 02329504
	add r3,r3,#0x1	; 02329506
	cmp r3,#0x13	; 02329508
	bcc loc_02329502	; 0232950A
	bl loc_0232C794	; 0232950C
	mov r0,#0x1	; 02329510
	bl loc_0232C714	; 02329512
	add sp,#0x4	; 02329516
	pop {r3}	; 02329518
	bx r3	; 0232951A
pool_0232951C:
loc_0232951C:
	.word P1_VibBuildIdentifier	; 0232951C

; ===== function loc_02329520 =====
loc_02329520:
	push {r4,lr}	; 02329520
	add r4,r0,#0x0	; 02329522
	bl loc_023294A0	; 02329524
	cmp r0,#0x1	; 02329528
	bne loc_02329534	; 0232952A
	mov r0,#0x1	; 0232952C
	and r4,r0	; 0232952E
	ldr r0,[pool_0232953C]	; 02329530
	strh r4,[r0,#0x0]	; 02329532
loc_02329534:
	pop {r4}	; 02329534
	pop {r3}	; 02329536
	bx r3	; 02329538
	.byte 0xC0, 0x46	; 0232953C
pool_0232953C:
loc_0232953C:
	.word 0x08000004	; 0232953C

; ===== function loc_02329540 =====
loc_02329540:
	push {r4,r5,lr}	; 02329540
	sub sp,#0x4	; 02329542
	add r5,r0,#0x0	; 02329544
	bl loc_0232B3AC	; 02329546
	add r4,r0,#0x0	; 0232954A
	add r0,r5,#0x0	; 0232954C
	blx loc_0232B2C8	; 0232954E
	mov r0,#0x1	; 02329552
	mvn r0,r0	; 02329554
	cmp r4,r0	; 02329556
	beq loc_0232955C	; 02329558
	mov r0,#0x0	; 0232955A
loc_0232955C:
	add sp,#0x4	; 0232955C
	pop {r4,r5}	; 0232955E
	pop {r3}	; 02329560
	bx r3	; 02329562

; ===== function loc_02329564 =====
loc_02329564:
	push {r4,lr}	; 02329564
	blx loc_0232B270	; 02329566
	add r4,r0,#0x0	; 0232956A
	mov r0,#0x2	; 0232956C
	mvn r0,r0	; 0232956E
	cmp r4,r0	; 02329570
	bne loc_0232957E	; 02329572
	mov r0,#0x0	; 02329574
	mvn r0,r0	; 02329576
	pop {r4}	; 02329578
	pop {r3}	; 0232957A
	bx r3	; 0232957C
loc_0232957E:
	lsl r0,r4,#0x10	; 0232957E
	lsr r0,r0,#0x10	; 02329580
	bl loc_0232B3C8	; 02329582
	add r0,r4,#0x0	; 02329586
	pop {r4}	; 02329588
	pop {r3}	; 0232958A
	bx r3	; 0232958C
	.byte 0x00, 0x00	; 02329590

; ===== function loc_02329590 =====
loc_02329590:
	cmp r1,#0x0	; 02329590
	bne loc_02329598	; 02329592
	ldr r0,[r0,#0x4]	; 02329594
	bx lr	; 02329596
loc_02329598:
	ldrh r0,[r0,#0xa]	; 02329598
	ldr r0,[r1,r0]	; 0232959A
	bx lr	; 0232959C
	.byte 0x00, 0x00	; 023295A0

; ===== function loc_023295A0 =====
loc_023295A0:
	cmp r1,#0x0	; 023295A0
	bne loc_023295A8	; 023295A2
	ldr r0,[r0,#0x0]	; 023295A4
	bx lr	; 023295A6
loc_023295A8:
	ldrh r0,[r0,#0xa]	; 023295A8
	add r0,r1,r0	; 023295AA
	ldr r0,[r0,#0x4]	; 023295AC
	bx lr	; 023295AE

; ===== function loc_023295B0 =====
loc_023295B0:
	push {r4}	; 023295B0
	sub sp,#0x4	; 023295B2
	ldrh r4,[r0,#0xa]	; 023295B4
	add r2,r1,r4	; 023295B6
	ldr r1,[r1,r4]	; 023295B8
	cmp r1,#0x0	; 023295BA
	bne loc_023295C4	; 023295BC
	ldr r1,[r2,#0x4]	; 023295BE
	str r1,[r0,#0x0]	; 023295C0
	b loc_023295CA	; 023295C2
loc_023295C4:
	ldr r3,[r2,#0x4]	; 023295C4
	add r1,r1,r4	; 023295C6
	str r3,[r1,#0x4]	; 023295C8
loc_023295CA:
	ldr r4,[r2,#0x4]	; 023295CA
	cmp r4,#0x0	; 023295CC
	bne loc_023295D6	; 023295CE
	ldr r1,[r2,#0x0]	; 023295D0
	str r1,[r0,#0x4]	; 023295D2
	b loc_023295DC	; 023295D4
loc_023295D6:
	ldr r3,[r2,#0x0]	; 023295D6
	ldrh r1,[r0,#0xa]	; 023295D8
	str r3,[r4,r1]	; 023295DA
loc_023295DC:
	mov r1,#0x0	; 023295DC
	str r1,[r2,#0x0]	; 023295DE
	str r1,[r2,#0x4]	; 023295E0
	ldrh r1,[r0,#0x8]	; 023295E2
	sub r1,r1,#0x1	; 023295E4
	strh r1,[r0,#0x8]	; 023295E6
	add sp,#0x4	; 023295E8
	pop {r4}	; 023295EA
	bx lr	; 023295EC
	.byte 0x00, 0x00	; 023295F0

; ===== function loc_023295F0 =====
loc_023295F0:
	push {r4,r5,lr}	; 023295F0
	sub sp,#0x4	; 023295F2
	cmp r1,#0x0	; 023295F4
	bne loc_02329606	; 023295F6
	add r1,r2,#0x0	; 023295F8
	bl loc_02329670	; 023295FA
	add sp,#0x4	; 023295FE
	pop {r4,r5}	; 02329600
	pop {r3}	; 02329602
	bx r3	; 02329604
loc_02329606:
	ldr r3,[r0,#0x0]	; 02329606
	cmp r1,r3	; 02329608
	bne loc_0232961A	; 0232960A
	add r1,r2,#0x0	; 0232960C
	bl loc_0232963C	; 0232960E
	add sp,#0x4	; 02329612
	pop {r4,r5}	; 02329614
	pop {r3}	; 02329616
	bx r3	; 02329618
loc_0232961A:
	ldrh r5,[r0,#0xa]	; 0232961A
	add r4,r2,r5	; 0232961C
	ldr r3,[r1,r5]	; 0232961E
	str r3,[r2,r5]	; 02329620
	str r1,[r4,#0x4]	; 02329622
	add r3,r3,r5	; 02329624
	str r2,[r3,#0x4]	; 02329626
	ldrh r3,[r0,#0xa]	; 02329628
	str r2,[r1,r3]	; 0232962A
	ldrh r1,[r0,#0x8]	; 0232962C
	add r1,r1,#0x1	; 0232962E
	strh r1,[r0,#0x8]	; 02329630
	add sp,#0x4	; 02329632
	pop {r4,r5}	; 02329634
	pop {r3}	; 02329636
	bx r3	; 02329638
	.byte 0x00, 0x00	; 0232963C

; ===== function loc_0232963C =====
loc_0232963C:
	push {r4,lr}	; 0232963C
	ldr r2,[r0,#0x0]	; 0232963E
	cmp r2,#0x0	; 02329640
	bne loc_0232964E	; 02329642
	bl loc_023296A4	; 02329644
	pop {r4}	; 02329648
	pop {r3}	; 0232964A
	bx r3	; 0232964C
loc_0232964E:
	ldrh r3,[r0,#0xa]	; 0232964E
	add r4,r1,r3	; 02329650
	mov r2,#0x0	; 02329652
	str r2,[r1,r3]	; 02329654
	ldr r2,[r0,#0x0]	; 02329656
	str r2,[r4,#0x4]	; 02329658
	ldr r3,[r0,#0x0]	; 0232965A
	ldrh r2,[r0,#0xa]	; 0232965C
	str r1,[r3,r2]	; 0232965E
	str r1,[r0,#0x0]	; 02329660
	ldrh r1,[r0,#0x8]	; 02329662
	add r1,r1,#0x1	; 02329664
	strh r1,[r0,#0x8]	; 02329666
	pop {r4}	; 02329668
	pop {r3}	; 0232966A
	bx r3	; 0232966C
	.byte 0x00, 0x00	; 02329670

; ===== function loc_02329670 =====
loc_02329670:
	push {r4,lr}	; 02329670
	ldr r2,[r0,#0x0]	; 02329672
	cmp r2,#0x0	; 02329674
	bne loc_02329682	; 02329676
	bl loc_023296A4	; 02329678
	pop {r4}	; 0232967C
	pop {r3}	; 0232967E
	bx r3	; 02329680
loc_02329682:
	ldrh r3,[r0,#0xa]	; 02329682
	add r4,r1,r3	; 02329684
	ldr r2,[r0,#0x4]	; 02329686
	str r2,[r1,r3]	; 02329688
	mov r2,#0x0	; 0232968A
	str r2,[r4,#0x4]	; 0232968C
	ldr r3,[r0,#0x4]	; 0232968E
	ldrh r2,[r0,#0xa]	; 02329690
	add r2,r3,r2	; 02329692
	str r1,[r2,#0x4]	; 02329694
	str r1,[r0,#0x4]	; 02329696
	ldrh r1,[r0,#0x8]	; 02329698
	add r1,r1,#0x1	; 0232969A
	strh r1,[r0,#0x8]	; 0232969C
	pop {r4}	; 0232969E
	pop {r3}	; 023296A0
	bx r3	; 023296A2

; ===== function loc_023296A4 =====
loc_023296A4:
	push {r4}	; 023296A4
	sub sp,#0x4	; 023296A6
	ldrh r3,[r0,#0xa]	; 023296A8
	add r4,r1,r3	; 023296AA
	mov r2,#0x0	; 023296AC
	str r2,[r4,#0x4]	; 023296AE
	str r2,[r1,r3]	; 023296B0
	str r1,[r0,#0x0]	; 023296B2
	str r1,[r0,#0x4]	; 023296B4
	ldrh r1,[r0,#0x8]	; 023296B6
	add r1,r1,#0x1	; 023296B8
	strh r1,[r0,#0x8]	; 023296BA
	add sp,#0x4	; 023296BC
	pop {r4}	; 023296BE
	bx lr	; 023296C0
	.byte 0x00, 0x00	; 023296C4

; ===== function loc_023296C4 =====
loc_023296C4:
	mov r2,#0x0	; 023296C4
	str r2,[r0,#0x0]	; 023296C6
	str r2,[r0,#0x4]	; 023296C8
	strh r2,[r0,#0x8]	; 023296CA
	strh r1,[r0,#0xa]	; 023296CC
	bx lr	; 023296CE

; ===== function loc_023296D0 =====
loc_023296D0:
	push {r4,lr}	; 023296D0
	add r4,r0,#0x0	; 023296D2
	bl loc_02329748	; 023296D4
	add r1,r4,#0x0	; 023296D8
	bl loc_023295B0	; 023296DA
	pop {r4}	; 023296DE
	pop {r3}	; 023296E0
	bx r3	; 023296E2

; ===== function loc_023296E4 =====
loc_023296E4:
	push {r4,lr}	; 023296E4
	add r4,r0,#0x0	; 023296E6
	str r1,[r4,#0x0]	; 023296E8
	str r2,[r4,#0x18]	; 023296EA
	str r3,[r4,#0x1c]	; 023296EC
	mov r0,#0x0	; 023296EE
	str r0,[r4,#0x20]	; 023296F0
	ldr r1,[r4,#0x20]	; 023296F2
	mov r0,#0xff	; 023296F4
	bic r1,r0	; 023296F6
	str r1,[r4,#0x20]	; 023296F8
	ldr r2,[r4,#0x20]	; 023296FA
	ldr r1,[pool_0232973C]	; 023296FC
	add r1,sp	; 023296FE
	ldrh r1,[r1,#0x10]	; 02329700
	and r1,r0	; 02329702
	orr r2,r1	; 02329704
	str r2,[r4,#0x20]	; 02329706
	add r0,r4,#0x0	; 02329708
	add r0,#0xc	; 0232970A
	mov r1,#0x4	; 0232970C
	bl loc_023296C4	; 0232970E
	ldr r0,[pool_02329740]	; 02329712
	ldr r0,[r0,#0x0]	; 02329714
	cmp r0,#0x0	; 02329716
	bne loc_02329728	; 02329718
	ldr r0,[pool_02329744]	; 0232971A
	mov r1,#0x4	; 0232971C
	bl loc_023296C4	; 0232971E
	mov r1,#0x1	; 02329722
	ldr r0,[pool_02329740]	; 02329724
	str r1,[r0,#0x0]	; 02329726
loc_02329728:
	add r0,r4,#0x0	; 02329728
	bl loc_02329748	; 0232972A
	add r1,r4,#0x0	; 0232972E
	bl loc_02329670	; 02329730
	pop {r4}	; 02329734
	pop {r3}	; 02329736
	bx r3	; 02329738
	.byte 0xC0, 0x46	; 0232973C
pool_0232973C:
loc_0232973C:
	.word 0xFFFFFFF8	; 0232973C
pool_02329740:
loc_02329740:
	.word P1_BssStart + 0x25A08	; 02329740
pool_02329744:
loc_02329744:
	.word 0x0235648C	; 02329744

; ===== function loc_02329748 =====
loc_02329748:
	push {r4,lr}	; 02329748
	add r1,r0,#0x0	; 0232974A
	ldr r4,[pool_02329764]	; 0232974C
	add r0,r4,#0x0	; 0232974E
	bl loc_02329768	; 02329750
	cmp r0,#0x0	; 02329754
	beq loc_0232975C	; 02329756
	add r4,r0,#0x0	; 02329758
	add r4,#0xc	; 0232975A
loc_0232975C:
	add r0,r4,#0x0	; 0232975C
	pop {r4}	; 0232975E
	pop {r3}	; 02329760
	bx r3	; 02329762
pool_02329764:
loc_02329764:
	.word 0x0235648C	; 02329764

; ===== function loc_02329768 =====
loc_02329768:
	push {r4,r5,r6,lr}	; 02329768
	add r6,r0,#0x0	; 0232976A
	add r5,r1,#0x0	; 0232976C
	mov r1,#0x0	; 0232976E
	bl loc_023295A0	; 02329770
	add r4,r0,#0x0	; 02329774
	cmp r4,#0x0	; 02329776
	beq loc_023297AA	; 02329778
loc_0232977A:
	ldr r0,[r4,#0x18]	; 0232977A
	cmp r0,r5	; 0232977C
	bhi loc_0232979C	; 0232977E
	ldr r0,[r4,#0x1c]	; 02329780
	cmp r5,r0	; 02329782
	bcs loc_0232979C	; 02329784
	add r0,r4,#0x0	; 02329786
	add r0,#0xc	; 02329788
	add r1,r5,#0x0	; 0232978A
	bl loc_02329768	; 0232978C
	cmp r0,#0x0	; 02329790
	bne loc_023297AC	; 02329792
	add r0,r4,#0x0	; 02329794
	pop {r4,r5,r6}	; 02329796
	pop {r3}	; 02329798
	bx r3	; 0232979A
loc_0232979C:
	add r0,r6,#0x0	; 0232979C
	add r1,r4,#0x0	; 0232979E
	bl loc_023295A0	; 023297A0
	add r4,r0,#0x0	; 023297A4
	cmp r4,#0x0	; 023297A6
	bne loc_0232977A	; 023297A8
loc_023297AA:
	mov r0,#0x0	; 023297AA
loc_023297AC:
	pop {r4,r5,r6}	; 023297AC
	pop {r3}	; 023297AE
	bx r3	; 023297B0
	.byte 0x00, 0x00	; 023297B2
P1_Entry_023297B4:
	push {r4,r5,lr}	; 023297B4
	sub sp,#0xc	; 023297B6
	add r5,r0,#0x0	; 023297B8
	add r5,#0x24	; 023297BA
	add r4,r1,#0x0	; 023297BC
	sub r4,#0x10	; 023297BE
	add r0,sp,#0x0	; 023297C0
	add r1,r4,#0x0	; 023297C2
	bl P1_Entry_02329B98	; 023297C4
	add r0,r5,#0x0	; 023297C8
	add r0,#0x8	; 023297CA
	add r1,r4,#0x0	; 023297CC
	bl P1_Entry_02329B7C	; 023297CE
	add r0,r5,#0x0	; 023297D2
	add r1,sp,#0x0	; 023297D4
	bl P1_Entry_0232983C	; 023297D6
	add sp,#0xc	; 023297DA
	pop {r4,r5}	; 023297DC
	pop {r3}	; 023297DE
	bx r3	; 023297E0
	.byte 0x00, 0x00	; 023297E2
P1_Entry_023297E4:
	push {lr}	; 023297E4
	sub sp,#0x4	; 023297E6
	cmp r1,#0x0	; 023297E8
	bne P1_Entry_023297EE	; 023297EA
	mov r1,#0x1	; 023297EC
P1_Entry_023297EE:
	add r1,r1,#0x3	; 023297EE
	mov r3,#0x3	; 023297F0
	bic r1,r3	; 023297F2
	cmp r2,#0x0	; 023297F4
	blt P1_Entry_02329802	; 023297F6
	bl P1_Entry_02329958	; 023297F8
	add sp,#0x4	; 023297FC
	pop {r3}	; 023297FE
	bx r3	; 02329800
P1_Entry_02329802:
	neg r2,r2	; 02329802
	bl P1_Entry_023298D0	; 02329804
	add sp,#0x4	; 02329808
	pop {r3}	; 0232980A
	bx r3	; 0232980C
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x09, 0x18, 0x03, 0x23, 0x99, 0x43, 0xC0, 0x1C, 0x98, 0x43	; 0232980E
	.byte 0x88, 0x42, 0x02, 0xD8, 0x0B, 0x1A, 0x4C, 0x2B, 0x03, 0xD2, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC	; 0232981E
	.byte 0x18, 0x47, 0x00, 0xF0, 0x5C, 0xF9, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 0232982E
P1_Entry_0232983C:
	push {r4,r5,r6,lr}	; 0232983C
	sub sp,#0x8	; 0232983E
	add r6,r0,#0x0	; 02329840
	add r5,r1,#0x0	; 02329842
	mov r4,#0x0	; 02329844
	ldr r1,[r5,#0x0]	; 02329846
	ldr r0,[r5,#0x4]	; 02329848
	str r1,[sp,#0x0]	; 0232984A
	str r0,[sp,#0x4]	; 0232984C
	ldr r1,[r6,#0x0]	; 0232984E
	cmp r1,#0x0	; 02329850
	beq P1_Entry_0232987C	; 02329852
	ldr r0,[r5,#0x0]	; 02329854
P1_Entry_02329856:
	cmp r1,r0	; 02329856
	bcs P1_Entry_0232985E	; 02329858
	add r4,r1,#0x0	; 0232985A
	b P1_Entry_02329876	; 0232985C
P1_Entry_0232985E:
	ldr r0,[r5,#0x4]	; 0232985E
	cmp r1,r0	; 02329860
	bne P1_Entry_0232987C	; 02329862
	ldr r2,[r1,#0x4]	; 02329864
	add r0,r1,#0x0	; 02329866
	add r0,#0x10	; 02329868
	add r0,r2,r0	; 0232986A
	str r0,[sp,#0x4]	; 0232986C
	add r0,r6,#0x0	; 0232986E
	bl P1_Entry_02329B7C	; 02329870
	b P1_Entry_0232987C	; 02329874
P1_Entry_02329876:
	ldr r1,[r1,#0xc]	; 02329876
	cmp r1,#0x0	; 02329878
	bne P1_Entry_02329856	; 0232987A
P1_Entry_0232987C:
	cmp r4,#0x0	; 0232987C
	beq P1_Entry_0232989A	; 0232987E
	ldr r1,[r4,#0x4]	; 02329880
	add r0,r4,#0x0	; 02329882
	add r0,#0x10	; 02329884
	add r1,r1,r0	; 02329886
	ldr r0,[r5,#0x0]	; 02329888
	cmp r1,r0	; 0232988A
	bne P1_Entry_0232989A	; 0232988C
	str r4,[sp,#0x0]	; 0232988E
	add r0,r6,#0x0	; 02329890
	add r1,r4,#0x0	; 02329892
	bl P1_Entry_02329B7C	; 02329894
	add r4,r0,#0x0	; 02329898
P1_Entry_0232989A:
	ldr r1,[sp,#0x4]	; 0232989A
	ldr r0,[sp,#0x0]	; 0232989C
	sub r0,r1,r0	; 0232989E
	cmp r0,#0x10	; 023298A0
	bcs P1_Entry_023298AE	; 023298A2
	mov r0,#0x0	; 023298A4
	add sp,#0x8	; 023298A6
	pop {r4,r5,r6}	; 023298A8
	pop {r3}	; 023298AA
	bx r3	; 023298AC
P1_Entry_023298AE:
	add r0,sp,#0x0	; 023298AE
	ldr r1,[pool_023298CC]	; 023298B0
	bl loc_02329B40	; 023298B2
	add r1,r0,#0x0	; 023298B6
	add r0,r6,#0x0	; 023298B8
	add r2,r4,#0x0	; 023298BA
	bl P1_Entry_02329B5C	; 023298BC
	mov r0,#0x1	; 023298C0
	add sp,#0x8	; 023298C2
	pop {r4,r5,r6}	; 023298C4
	pop {r3}	; 023298C6
	bx r3	; 023298C8
	.byte 0xC0, 0x46	; 023298CA
pool_023298CC:
	.word 0x00004652	; 023298CC
P1_Entry_023298D0:
	push {r4,r5,r6,r7,lr}	; 023298D0
	sub sp,#0x14	; 023298D2
	add r3,r1,#0x0	; 023298D4
	str r0,[sp,#0xc]	; 023298D6
	add r0,#0x24	; 023298D8
	str r0,[sp,#0xc]	; 023298DA
	ldrh r0,[r0,#0x12]	; 023298DC
	mov r7,#0x1	; 023298DE
	and r0,r7	; 023298E0
	lsl r0,r0,#0x10	; 023298E2
	lsr r0,r0,#0x10	; 023298E4
	cmp r0,#0x0	; 023298E6
	beq P1_Entry_023298EC	; 023298E8
	mov r7,#0x0	; 023298EA
P1_Entry_023298EC:
	mov r0,#0x0	; 023298EC
	str r0,[sp,#0x4]	; 023298EE
	mvn r0,r0	; 023298F0
	ldr r1,[sp,#0x4]	; 023298F2
	str r1,[sp,#0x8]	; 023298F4
	ldr r1,[sp,#0xc]	; 023298F6
	ldr r1,[r1,#0x4]	; 023298F8
	cmp r1,#0x0	; 023298FA
	beq P1_Entry_02329930	; 023298FC
	sub r2,r2,#0x1	; 023298FE
	mvn r2,r2	; 02329900
	str r2,[sp,#0x10]	; 02329902
P1_Entry_02329904:
	add r6,r1,#0x0	; 02329904
	add r6,#0x10	; 02329906
	ldr r5,[r1,#0x4]	; 02329908
	add r2,r5,r6	; 0232990A
	sub r2,r2,r3	; 0232990C
	ldr r4,[sp,#0x10]	; 0232990E
	and r4,r2	; 02329910
	sub r2,r4,r6	; 02329912
	cmp r2,#0x0	; 02329914
	blt P1_Entry_0232992A	; 02329916
	cmp r0,r5	; 02329918
	bls P1_Entry_0232992A	; 0232991A
	str r1,[sp,#0x4]	; 0232991C
	add r0,r5,#0x0	; 0232991E
	str r4,[sp,#0x8]	; 02329920
	cmp r7,#0x0	; 02329922
	bne P1_Entry_02329930	; 02329924
	cmp r5,r3	; 02329926
	beq P1_Entry_02329930	; 02329928
P1_Entry_0232992A:
	ldr r1,[r1,#0x8]	; 0232992A
	cmp r1,#0x0	; 0232992C
	bne P1_Entry_02329904	; 0232992E
P1_Entry_02329930:
	ldr r0,[sp,#0x4]	; 02329930
	cmp r0,#0x0	; 02329932
	beq P1_Entry_0232994C	; 02329934
	mov r0,#0x1	; 02329936
	str r0,[sp,#0x0]	; 02329938
	ldr r0,[sp,#0xc]	; 0232993A
	ldr r1,[sp,#0x4]	; 0232993C
	ldr r2,[sp,#0x8]	; 0232993E
	bl P1_Entry_023299E0	; 02329940
	add sp,#0x14	; 02329944
	pop {r4,r5,r6,r7}	; 02329946
	pop {r3}	; 02329948
	bx r3	; 0232994A
P1_Entry_0232994C:
	mov r0,#0x0	; 0232994C
	add sp,#0x14	; 0232994E
	pop {r4,r5,r6,r7}	; 02329950
	pop {r3}	; 02329952
	bx r3	; 02329954
	.byte 0x00, 0x00	; 02329956
P1_Entry_02329958:
	push {r4,r5,r6,r7,lr}	; 02329958
	sub sp,#0x14	; 0232995A
	add r3,r1,#0x0	; 0232995C
	str r0,[sp,#0xc]	; 0232995E
	add r0,#0x24	; 02329960
	str r0,[sp,#0xc]	; 02329962
	ldrh r0,[r0,#0x12]	; 02329964
	mov r7,#0x1	; 02329966
	and r0,r7	; 02329968
	lsl r0,r0,#0x10	; 0232996A
	lsr r0,r0,#0x10	; 0232996C
	cmp r0,#0x0	; 0232996E
	beq P1_Entry_02329974	; 02329970
	mov r7,#0x0	; 02329972
P1_Entry_02329974:
	mov r0,#0x0	; 02329974
	str r0,[sp,#0x4]	; 02329976
	mvn r0,r0	; 02329978
	ldr r1,[sp,#0x4]	; 0232997A
	str r1,[sp,#0x8]	; 0232997C
	ldr r1,[sp,#0xc]	; 0232997E
	ldr r1,[r1,#0x0]	; 02329980
	cmp r1,#0x0	; 02329982
	beq P1_Entry_023299B8	; 02329984
	sub r6,r2,#0x1	; 02329986
	mvn r2,r6	; 02329988
	str r2,[sp,#0x10]	; 0232998A
P1_Entry_0232998C:
	add r5,r1,#0x0	; 0232998C
	add r5,#0x10	; 0232998E
	add r2,r6,r5	; 02329990
	ldr r4,[sp,#0x10]	; 02329992
	and r4,r2	; 02329994
	ldr r2,[r1,#0x4]	; 02329996
	sub r5,r4,r5	; 02329998
	add r5,r3,r5	; 0232999A
	cmp r2,r5	; 0232999C
	bcc P1_Entry_023299B2	; 0232999E
	cmp r0,r2	; 023299A0
	bls P1_Entry_023299B2	; 023299A2
	str r1,[sp,#0x4]	; 023299A4
	add r0,r2,#0x0	; 023299A6
	str r4,[sp,#0x8]	; 023299A8
	cmp r7,#0x0	; 023299AA
	bne P1_Entry_023299B8	; 023299AC
	cmp r2,r3	; 023299AE
	beq P1_Entry_023299B8	; 023299B0
P1_Entry_023299B2:
	ldr r1,[r1,#0xc]	; 023299B2
	cmp r1,#0x0	; 023299B4
	bne P1_Entry_0232998C	; 023299B6
P1_Entry_023299B8:
	ldr r0,[sp,#0x4]	; 023299B8
	cmp r0,#0x0	; 023299BA
	beq P1_Entry_023299D4	; 023299BC
	mov r0,#0x0	; 023299BE
	str r0,[sp,#0x0]	; 023299C0
	ldr r0,[sp,#0xc]	; 023299C2
	ldr r1,[sp,#0x4]	; 023299C4
	ldr r2,[sp,#0x8]	; 023299C6
	bl P1_Entry_023299E0	; 023299C8
	add sp,#0x14	; 023299CC
	pop {r4,r5,r6,r7}	; 023299CE
	pop {r3}	; 023299D0
	bx r3	; 023299D2
P1_Entry_023299D4:
	mov r0,#0x0	; 023299D4
	add sp,#0x14	; 023299D6
	pop {r4,r5,r6,r7}	; 023299D8
	pop {r3}	; 023299DA
	bx r3	; 023299DC
	.byte 0x00, 0x00	; 023299DE
P1_Entry_023299E0:
	push {r4,r5,r6,r7,lr}	; 023299E0
	sub sp,#0x1c	; 023299E2
	add r5,r0,#0x0	; 023299E4
	add r7,r1,#0x0	; 023299E6
	add r4,r2,#0x0	; 023299E8
	add r6,r3,#0x0	; 023299EA
	add r0,sp,#0x0	; 023299EC
	bl P1_Entry_02329B98	; 023299EE
	ldr r0,[sp,#0x4]	; 023299F2
	str r0,[sp,#0xc]	; 023299F4
	add r0,r6,r4	; 023299F6
	str r0,[sp,#0x8]	; 023299F8
	add r6,r4,#0x0	; 023299FA
	sub r6,#0x10	; 023299FC
	str r6,[sp,#0x4]	; 023299FE
	add r0,r5,#0x0	; 02329A00
	add r1,r7,#0x0	; 02329A02
	bl P1_Entry_02329B7C	; 02329A04
	add r7,r0,#0x0	; 02329A08
	ldr r1,[sp,#0x0]	; 02329A0A
	ldr r0,[sp,#0x4]	; 02329A0C
	sub r0,r0,r1	; 02329A0E
	cmp r0,#0x10	; 02329A10
	bcs P1_Entry_02329A18	; 02329A12
	str r1,[sp,#0x4]	; 02329A14
	b P1_Entry_02329A2C	; 02329A16
P1_Entry_02329A18:
	add r0,sp,#0x0	; 02329A18
	ldr r1,[pool_02329ADC]	; 02329A1A
	bl loc_02329B40	; 02329A1C
	add r1,r0,#0x0	; 02329A20
	add r0,r5,#0x0	; 02329A22
	add r2,r7,#0x0	; 02329A24
	bl P1_Entry_02329B5C	; 02329A26
	add r7,r0,#0x0	; 02329A2A
P1_Entry_02329A2C:
	ldr r1,[sp,#0xc]	; 02329A2C
	ldr r0,[sp,#0x8]	; 02329A2E
	sub r0,r1,r0	; 02329A30
	cmp r0,#0x10	; 02329A32
	bcs P1_Entry_02329A3A	; 02329A34
	str r1,[sp,#0x8]	; 02329A36
	b P1_Entry_02329A4C	; 02329A38
P1_Entry_02329A3A:
	add r0,sp,#0x8	; 02329A3A
	ldr r1,[pool_02329ADC]	; 02329A3C
	bl loc_02329B40	; 02329A3E
	add r1,r0,#0x0	; 02329A42
	add r0,r5,#0x0	; 02329A44
	add r2,r7,#0x0	; 02329A46
	bl P1_Entry_02329B5C	; 02329A48
P1_Entry_02329A4C:
	ldr r1,[sp,#0x4]	; 02329A4C
	ldr r0,[sp,#0x8]	; 02329A4E
	sub r2,r0,r1	; 02329A50
	sub r0,r5,#0x4	; 02329A52
	ldr r3,[r0,#0x0]	; 02329A54
	mov r0,#0xff	; 02329A56
	and r3,r0	; 02329A58
	lsl r0,r3,#0x10	; 02329A5A
	lsr r3,r0,#0x10	; 02329A5C
	mov r0,#0x1	; 02329A5E
	and r3,r0	; 02329A60
	cmp r3,#0x0	; 02329A62
	beq P1_Entry_02329A70	; 02329A64
	mov r0,#0x0	; 02329A66
	str r0,[sp,#0x18]	; 02329A68
	ldr r0,[sp,#0x18]	; 02329A6A
	blx P1_MemFill32	; 02329A6C
P1_Entry_02329A70:
	str r6,[sp,#0x10]	; 02329A70
	ldr r0,[sp,#0x8]	; 02329A72
	str r0,[sp,#0x14]	; 02329A74
	add r0,sp,#0x10	; 02329A76
	ldr r1,[pool_02329AE0]	; 02329A78
	bl loc_02329B40	; 02329A7A
	add r1,r0,#0x0	; 02329A7E
	ldrh r2,[r1,#0x2]	; 02329A80
	ldr r0,[pool_02329AE4]	; 02329A82
	and r2,r0	; 02329A84
	strh r2,[r1,#0x2]	; 02329A86
	ldrh r0,[r1,#0x2]	; 02329A88
	add r2,sp,#0x20	; 02329A8A
	ldrh r3,[r2,#0x10]	; 02329A8C
	mov r2,#0x1	; 02329A8E
	and r3,r2	; 02329A90
	lsl r2,r3,#0xf	; 02329A92
	orr r0,r2	; 02329A94
	strh r0,[r1,#0x2]	; 02329A96
	ldr r0,[sp,#0x4]	; 02329A98
	sub r3,r1,r0	; 02329A9A
	ldrh r2,[r1,#0x2]	; 02329A9C
	ldr r0,[pool_02329AE8]	; 02329A9E
	and r2,r0	; 02329AA0
	strh r2,[r1,#0x2]	; 02329AA2
	ldrh r0,[r1,#0x2]	; 02329AA4
	lsl r2,r3,#0x10	; 02329AA6
	lsr r3,r2,#0x10	; 02329AA8
	mov r2,#0x7f	; 02329AAA
	and r3,r2	; 02329AAC
	lsl r2,r3,#0x8	; 02329AAE
	orr r0,r2	; 02329AB0
	strh r0,[r1,#0x2]	; 02329AB2
	ldrh r3,[r5,#0x10]	; 02329AB4
	mov r0,#0xff	; 02329AB6
	and r3,r0	; 02329AB8
	ldrh r2,[r1,#0x2]	; 02329ABA
	bic r2,r0	; 02329ABC
	strh r2,[r1,#0x2]	; 02329ABE
	ldrh r0,[r1,#0x2]	; 02329AC0
	orr r0,r3	; 02329AC2
	strh r0,[r1,#0x2]	; 02329AC4
	add r0,r5,#0x0	; 02329AC6
	add r0,#0x8	; 02329AC8
	ldr r2,[r5,#0xc]	; 02329ACA
	bl P1_Entry_02329B5C	; 02329ACC
	add r0,r4,#0x0	; 02329AD0
	add sp,#0x1c	; 02329AD2
	pop {r4,r5,r6,r7}	; 02329AD4
	pop {r3}	; 02329AD6
	bx r3	; 02329AD8
	.byte 0xC0, 0x46	; 02329ADA
pool_02329ADC:
	.word 0x00004652	; 02329ADC
pool_02329AE0:
	.word 0x00005544	; 02329AE0
pool_02329AE4:
	.word 0xFFFF7FFF	; 02329AE4
pool_02329AE8:
	.word 0xFFFF80FF	; 02329AE8

; ===== function loc_02329AEC =====
	push {r4,r5,lr}	; 02329AEC
	sub sp,#0xc	; 02329AEE
	add r5,r0,#0x0	; 02329AF0
	add r3,r1,#0x0	; 02329AF2
	add r4,r5,#0x0	; 02329AF4
	add r4,#0x24	; 02329AF6
	str r2,[sp,#0x0]	; 02329AF8
	ldr r1,[pool_02329B38]	; 02329AFA
	add r2,r4,#0x0	; 02329AFC
	add r2,#0x14	; 02329AFE
	bl loc_023296E4	; 02329B00
	mov r0,#0x0	; 02329B04
	strh r0,[r4,#0x10]	; 02329B06
	strh r0,[r4,#0x12]	; 02329B08
	ldrh r1,[r4,#0x12]	; 02329B0A
	mov r0,#0x1	; 02329B0C
	bic r1,r0	; 02329B0E
	strh r1,[r4,#0x12]	; 02329B10
	ldr r0,[r5,#0x18]	; 02329B12
	str r0,[sp,#0x4]	; 02329B14
	ldr r0,[r5,#0x1c]	; 02329B16
	str r0,[sp,#0x8]	; 02329B18
	add r0,sp,#0x4	; 02329B1A
	ldr r1,[pool_02329B3C]	; 02329B1C
	bl loc_02329B40	; 02329B1E
	str r0,[r5,#0x24]	; 02329B22
	str r0,[r4,#0x4]	; 02329B24
	mov r0,#0x0	; 02329B26
	str r0,[r4,#0x8]	; 02329B28
	str r0,[r4,#0xc]	; 02329B2A
	add r0,r5,#0x0	; 02329B2C
	add sp,#0xc	; 02329B2E
	pop {r4,r5}	; 02329B30
	pop {r3}	; 02329B32
	bx r3	; 02329B34
	.byte 0xC0, 0x46	; 02329B38
pool_02329B38:
loc_02329B38:
	.word 0x45585048	; 02329B38
pool_02329B3C:
loc_02329B3C:
	.word 0x00004652	; 02329B3C

; ===== function loc_02329B40 =====
loc_02329B40:
	ldr r3,[r0,#0x0]	; 02329B40
	strh r1,[r3,#0x0]	; 02329B42
	mov r2,#0x0	; 02329B44
	strh r2,[r3,#0x2]	; 02329B46
	ldr r1,[r0,#0x4]	; 02329B48
	add r0,r3,#0x0	; 02329B4A
	add r0,#0x10	; 02329B4C
	sub r0,r1,r0	; 02329B4E
	str r0,[r3,#0x4]	; 02329B50
	str r2,[r3,#0x8]	; 02329B52
	str r2,[r3,#0xc]	; 02329B54
	add r0,r3,#0x0	; 02329B56
	bx lr	; 02329B58
	.byte 0x00, 0x00	; 02329B5A
P1_Entry_02329B5C:
	str r2,[r1,#0x8]	; 02329B5C
	cmp r2,#0x0	; 02329B5E
	beq P1_Entry_02329B68	; 02329B60
	ldr r3,[r2,#0xc]	; 02329B62
	str r1,[r2,#0xc]	; 02329B64
	b P1_Entry_02329B6C	; 02329B66
P1_Entry_02329B68:
	ldr r3,[r0,#0x0]	; 02329B68
	str r1,[r0,#0x0]	; 02329B6A
P1_Entry_02329B6C:
	str r3,[r1,#0xc]	; 02329B6C
	cmp r3,#0x0	; 02329B6E
	beq P1_Entry_02329B76	; 02329B70
	str r1,[r3,#0x8]	; 02329B72
	b P1_Entry_02329B78	; 02329B74
P1_Entry_02329B76:
	str r1,[r0,#0x4]	; 02329B76
P1_Entry_02329B78:
	add r0,r1,#0x0	; 02329B78
	bx lr	; 02329B7A
P1_Entry_02329B7C:
	ldr r2,[r1,#0x8]	; 02329B7C
	ldr r1,[r1,#0xc]	; 02329B7E
	cmp r2,#0x0	; 02329B80
	beq P1_Entry_02329B88	; 02329B82
	str r1,[r2,#0xc]	; 02329B84
	b P1_Entry_02329B8A	; 02329B86
P1_Entry_02329B88:
	str r1,[r0,#0x0]	; 02329B88
P1_Entry_02329B8A:
	cmp r1,#0x0	; 02329B8A
	beq P1_Entry_02329B92	; 02329B8C
	str r2,[r1,#0x8]	; 02329B8E
	b P1_Entry_02329B94	; 02329B90
P1_Entry_02329B92:
	str r2,[r0,#0x4]	; 02329B92
P1_Entry_02329B94:
	add r0,r2,#0x0	; 02329B94
	bx lr	; 02329B96
P1_Entry_02329B98:
	ldrh r2,[r1,#0x2]	; 02329B98
	asr r3,r2,#0x8	; 02329B9A
	mov r2,#0x7f	; 02329B9C
	and r3,r2	; 02329B9E
	lsl r2,r3,#0x10	; 02329BA0
	lsr r2,r2,#0x10	; 02329BA2
	sub r2,r1,r2	; 02329BA4
	str r2,[r0,#0x0]	; 02329BA6
	ldr r2,[r1,#0x4]	; 02329BA8
	add r1,#0x10	; 02329BAA
	add r1,r2,r1	; 02329BAC
	str r1,[r0,#0x4]	; 02329BAE
	bx lr	; 02329BB0
	.byte 0x00, 0x00	; 02329BB2

; ===== function loc_02329BB4 =====
loc_02329BB4:
	push {r4,r5,lr}	; 02329BB4
	sub sp,#0x4	; 02329BB6
	add r5,r0,#0x0	; 02329BB8
	add r4,r1,#0x0	; 02329BBA
	mov r1,#0x1	; 02329BBC
	add r2,r4,#0x0	; 02329BBE
	and r2,r1	; 02329BC0
	cmp r2,#0x0	; 02329BC2
	beq loc_02329BCA	; 02329BC4
	bl loc_02329C5C	; 02329BC6
loc_02329BCA:
	mov r0,#0x2	; 02329BCA
	and r4,r0	; 02329BCC
	cmp r4,#0x0	; 02329BCE
	beq loc_02329BD8	; 02329BD0
	add r0,r5,#0x0	; 02329BD2
	bl loc_02329C40	; 02329BD4
loc_02329BD8:
	add sp,#0x4	; 02329BD8
	pop {r4,r5}	; 02329BDA
	pop {r3}	; 02329BDC
	bx r3	; 02329BDE

; ===== function loc_02329BE0 =====
loc_02329BE0:
	push {lr}	; 02329BE0
	sub sp,#0x4	; 02329BE2
	add r0,#0x24	; 02329BE4
	cmp r1,#0x0	; 02329BE6
	bne loc_02329BEC	; 02329BE8
	mov r1,#0x1	; 02329BEA
loc_02329BEC:
	add r1,r1,#0x3	; 02329BEC
	mov r3,#0x3	; 02329BEE
	bic r1,r3	; 02329BF0
	cmp r2,#0x0	; 02329BF2
	blt loc_02329C00	; 02329BF4
	bl loc_02329CBC	; 02329BF6
	add sp,#0x4	; 02329BFA
	pop {r3}	; 02329BFC
	bx r3	; 02329BFE
loc_02329C00:
	neg r2,r2	; 02329C00
	bl loc_02329C6C	; 02329C02
	add sp,#0x4	; 02329C06
	pop {r3}	; 02329C08
	bx r3	; 02329C0A

; ===== function loc_02329C0C =====
loc_02329C0C:
	ldr r3,[pool_02329C10]	; 02329C0C
	bx r3	; 02329C0E
pool_02329C10:
loc_02329C10:
	.word loc_023296D0 + 1	; 02329C10

; ===== function loc_02329C14 =====
loc_02329C14:
	push {lr}	; 02329C14
	sub sp,#0x4	; 02329C16
	add r1,r1,r0	; 02329C18
	mov r3,#0x3	; 02329C1A
	bic r1,r3	; 02329C1C
	add r0,r0,#0x3	; 02329C1E
	bic r0,r3	; 02329C20
	cmp r0,r1	; 02329C22
	bhi loc_02329C2C	; 02329C24
	sub r3,r1,r0	; 02329C26
	cmp r3,#0x30	; 02329C28
	bcs loc_02329C34	; 02329C2A
loc_02329C2C:
	mov r0,#0x0	; 02329C2C
	add sp,#0x4	; 02329C2E
	pop {r3}	; 02329C30
	bx r3	; 02329C32
loc_02329C34:
	bl loc_02329D0C	; 02329C34
	add sp,#0x4	; 02329C38
	pop {r3}	; 02329C3A
	bx r3	; 02329C3C
	.byte 0x00, 0x00	; 02329C40

; ===== function loc_02329C40 =====
loc_02329C40:
	add r2,r0,#0x0	; 02329C40
	add r2,#0x24	; 02329C42
	ldr r3,[r2,#0x8]	; 02329C44
	cmp r3,#0x0	; 02329C46
	beq loc_02329C54	; 02329C48
loc_02329C4A:
	ldr r1,[r0,#0x1c]	; 02329C4A
	str r1,[r3,#0x8]	; 02329C4C
	ldr r3,[r3,#0xc]	; 02329C4E
	cmp r3,#0x0	; 02329C50
	bne loc_02329C4A	; 02329C52
loc_02329C54:
	ldr r0,[r0,#0x1c]	; 02329C54
	str r0,[r2,#0x4]	; 02329C56
	bx lr	; 02329C58
	.byte 0x00, 0x00	; 02329C5C

; ===== function loc_02329C5C =====
loc_02329C5C:
	add r2,r0,#0x0	; 02329C5C
	add r2,#0x24	; 02329C5E
	ldr r1,[r0,#0x18]	; 02329C60
	str r1,[r0,#0x24]	; 02329C62
	mov r0,#0x0	; 02329C64
	str r0,[r2,#0x8]	; 02329C66
	bx lr	; 02329C68
	.byte 0x00, 0x00	; 02329C6C

; ===== function loc_02329C6C =====
loc_02329C6C:
	push {r4,r5,lr}	; 02329C6C
	sub sp,#0x4	; 02329C6E
	add r5,r0,#0x0	; 02329C70
	ldr r0,[r5,#0x4]	; 02329C72
	sub r2,r2,#0x1	; 02329C74
	mvn r4,r2	; 02329C76
	sub r1,r0,r1	; 02329C78
	and r4,r1	; 02329C7A
	ldr r1,[r5,#0x0]	; 02329C7C
	cmp r4,r1	; 02329C7E
	bcs loc_02329C8C	; 02329C80
	mov r0,#0x0	; 02329C82
	add sp,#0x4	; 02329C84
	pop {r4,r5}	; 02329C86
	pop {r3}	; 02329C88
	bx r3	; 02329C8A
loc_02329C8C:
	sub r2,r0,r4	; 02329C8C
	sub r0,r5,#0x4	; 02329C8E
	ldr r1,[r0,#0x0]	; 02329C90
	mov r0,#0xff	; 02329C92
	and r1,r0	; 02329C94
	lsl r0,r1,#0x10	; 02329C96
	lsr r1,r0,#0x10	; 02329C98
	mov r0,#0x1	; 02329C9A
	and r1,r0	; 02329C9C
	cmp r1,#0x0	; 02329C9E
	beq loc_02329CAE	; 02329CA0
	mov r0,#0x0	; 02329CA2
	str r0,[sp,#0x0]	; 02329CA4
	ldr r0,[sp,#0x0]	; 02329CA6
	add r1,r4,#0x0	; 02329CA8
	blx loc_0232DE4C	; 02329CAA
loc_02329CAE:
	str r4,[r5,#0x4]	; 02329CAE
	add r0,r4,#0x0	; 02329CB0
	add sp,#0x4	; 02329CB2
	pop {r4,r5}	; 02329CB4
	pop {r3}	; 02329CB6
	bx r3	; 02329CB8
	.byte 0x00, 0x00	; 02329CBC

; ===== function loc_02329CBC =====
loc_02329CBC:
	push {r4,r5,r6,lr}	; 02329CBC
	sub sp,#0x8	; 02329CBE
	add r5,r0,#0x0	; 02329CC0
	ldr r3,[r5,#0x0]	; 02329CC2
	sub r0,r2,#0x1	; 02329CC4
	mvn r4,r0	; 02329CC6
	add r0,r0,r3	; 02329CC8
	and r4,r0	; 02329CCA
	add r6,r1,r4	; 02329CCC
	ldr r0,[r5,#0x4]	; 02329CCE
	cmp r6,r0	; 02329CD0
	bls loc_02329CDE	; 02329CD2
	mov r0,#0x0	; 02329CD4
	add sp,#0x8	; 02329CD6
	pop {r4,r5,r6}	; 02329CD8
	pop {r3}	; 02329CDA
	bx r3	; 02329CDC
loc_02329CDE:
	sub r2,r6,r3	; 02329CDE
	sub r0,r5,#0x4	; 02329CE0
	ldr r1,[r0,#0x0]	; 02329CE2
	mov r0,#0xff	; 02329CE4
	and r1,r0	; 02329CE6
	lsl r0,r1,#0x10	; 02329CE8
	lsr r1,r0,#0x10	; 02329CEA
	mov r0,#0x1	; 02329CEC
	and r1,r0	; 02329CEE
	cmp r1,#0x0	; 02329CF0
	beq loc_02329D00	; 02329CF2
	mov r0,#0x0	; 02329CF4
	str r0,[sp,#0x0]	; 02329CF6
	ldr r0,[sp,#0x0]	; 02329CF8
	add r1,r3,#0x0	; 02329CFA
	blx loc_0232DE4C	; 02329CFC
loc_02329D00:
	str r6,[r5,#0x0]	; 02329D00
	add r0,r4,#0x0	; 02329D02
	add sp,#0x8	; 02329D04
	pop {r4,r5,r6}	; 02329D06
	pop {r3}	; 02329D08
	bx r3	; 02329D0A

; ===== function loc_02329D0C =====
loc_02329D0C:
	push {r4,r5,lr}	; 02329D0C
	sub sp,#0x4	; 02329D0E
	add r5,r0,#0x0	; 02329D10
	add r3,r1,#0x0	; 02329D12
	add r4,r5,#0x0	; 02329D14
	add r4,#0x24	; 02329D16
	str r2,[sp,#0x0]	; 02329D18
	ldr r1,[pool_02329D3C]	; 02329D1A
	add r2,r4,#0x0	; 02329D1C
	add r2,#0xc	; 02329D1E
	bl loc_023296E4	; 02329D20
	ldr r0,[r5,#0x18]	; 02329D24
	str r0,[r5,#0x24]	; 02329D26
	ldr r0,[r5,#0x1c]	; 02329D28
	str r0,[r4,#0x4]	; 02329D2A
	mov r0,#0x0	; 02329D2C
	str r0,[r4,#0x8]	; 02329D2E
	add r0,r5,#0x0	; 02329D30
	add sp,#0x4	; 02329D32
	pop {r4,r5}	; 02329D34
	pop {r3}	; 02329D36
	bx r3	; 02329D38
	.byte 0xC0, 0x46	; 02329D3C
pool_02329D3C:
loc_02329D3C:
	.word 0x46524D48	; 02329D3C

; ===== function loc_02329D40 =====
loc_02329D40:
	ldr r3,[pool_02329D44]	; 02329D40
	bx r3	; 02329D42
pool_02329D44:
loc_02329D44:
	.word loc_0232A4FC + 1	; 02329D44

; ===== function loc_02329D48 =====
loc_02329D48:
	push {r4,lr}	; 02329D48
	bl loc_0232A55C	; 02329D4A
	mov r0,#0x0	; 02329D4E
	add r1,r0,#0x0	; 02329D50
	add r2,r0,#0x0	; 02329D52
	add r3,r0,#0x0	; 02329D54
	bl loc_0232E100	; 02329D56
	bl loc_0232E318	; 02329D5A
	add r4,r0,#0x0	; 02329D5E
	mov r0,#0x1	; 02329D60
	bl loc_0232E384	; 02329D62
	add r0,r4,#0x0	; 02329D66
	bl loc_0232E338	; 02329D68
	pop {r4}	; 02329D6C
	pop {r3}	; 02329D6E
	bx r3	; 02329D70
	.byte 0x00, 0x00	; 02329D74

; ===== function loc_02329D74 =====
loc_02329D74:
	push {r4,lr}	; 02329D74
	mov r4,#0x0	; 02329D76
loc_02329D78:
	add r0,r4,#0x0	; 02329D78
	bl loc_0232E4DC	; 02329D7A
	cmp r0,#0x0	; 02329D7E
	bne loc_02329D78	; 02329D80
	bl loc_0232A2F4	; 02329D82
	bl loc_0232A8EC	; 02329D86
	mov r0,#0x0	; 02329D8A
	bl loc_0232E384	; 02329D8C
	pop {r4}	; 02329D90
	pop {r3}	; 02329D92
	bx r3	; 02329D94
	.byte 0x00, 0x00	; 02329D98

; ===== function loc_02329D98 =====
loc_02329D98:
	push {lr}	; 02329D98
	sub sp,#0x4	; 02329D9A
	ldr r0,[pool_02329DC0]	; 02329D9C
	ldr r1,[r0,#0x0]	; 02329D9E
	cmp r1,#0x0	; 02329DA0
	bne loc_02329DB8	; 02329DA2
	mov r1,#0x1	; 02329DA4
	str r1,[r0,#0x0]	; 02329DA6
	bl loc_0232DF38	; 02329DA8
	bl loc_02329E90	; 02329DAC
	bl loc_0232A94C	; 02329DB0
	bl loc_0232A3E4	; 02329DB4
loc_02329DB8:
	add sp,#0x4	; 02329DB8
	pop {r3}	; 02329DBA
	bx r3	; 02329DBC
	.byte 0xC0, 0x46	; 02329DC0
pool_02329DC0:
loc_02329DC0:
	.word P1_BssStart + 0x25A18	; 02329DC0

; ===== function loc_02329DC4 =====
loc_02329DC4:
	ldr r1,[pool_02329DD4]	; 02329DC4
	ldr r3,[r1,#0x0]	; 02329DC6
	mov r2,#0x1	; 02329DC8
	lsl r2,r0	; 02329DCA
	bic r3,r2	; 02329DCC
	str r3,[r1,#0x0]	; 02329DCE
	bx lr	; 02329DD0
	.byte 0xC0, 0x46	; 02329DD4
pool_02329DD4:
loc_02329DD4:
	.word P1_BssStart + 0x25A20	; 02329DD4

; ===== function loc_02329DD8 =====
loc_02329DD8:
	mov r3,#0x1	; 02329DD8
	mov r0,#0x0	; 02329DDA
	ldr r1,[pool_02329E00]	; 02329DDC
	ldr r2,[r1,#0x0]	; 02329DDE
loc_02329DE0:
	add r1,r2,#0x0	; 02329DE0
	and r1,r3	; 02329DE2
	cmp r1,#0x0	; 02329DE4
	bne loc_02329DF2	; 02329DE6
	ldr r1,[pool_02329E00]	; 02329DE8
	ldr r2,[r1,#0x0]	; 02329DEA
	orr r2,r3	; 02329DEC
	str r2,[r1,#0x0]	; 02329DEE
	bx lr	; 02329DF0
loc_02329DF2:
	add r0,r0,#0x1	; 02329DF2
	lsl r3,r3,#0x1	; 02329DF4
	cmp r0,#0x8	; 02329DF6
	blt loc_02329DE0	; 02329DF8
	mov r0,#0x0	; 02329DFA
	mvn r0,r0	; 02329DFC
	bx lr	; 02329DFE
pool_02329E00:
loc_02329E00:
	.word P1_BssStart + 0x25A20	; 02329E00

; ===== function loc_02329E04 =====
loc_02329E04:
	ldr r1,[pool_02329E10]	; 02329E04
	ldr r2,[r1,#0x0]	; 02329E06
	bic r2,r0	; 02329E08
	str r2,[r1,#0x0]	; 02329E0A
	bx lr	; 02329E0C
	.byte 0xC0, 0x46	; 02329E10
pool_02329E10:
loc_02329E10:
	.word P1_BssStart + 0x25A1C	; 02329E10

; ===== function loc_02329E14 =====
loc_02329E14:
	ldr r1,[pool_02329E2C]	; 02329E14
	ldr r2,[r1,#0x0]	; 02329E16
	add r3,r0,#0x0	; 02329E18
	and r3,r2	; 02329E1A
	cmp r3,#0x0	; 02329E1C
	beq loc_02329E24	; 02329E1E
	mov r0,#0x0	; 02329E20
	bx lr	; 02329E22
loc_02329E24:
	orr r2,r0	; 02329E24
	str r2,[r1,#0x0]	; 02329E26
	mov r0,#0x1	; 02329E28
	bx lr	; 02329E2A
pool_02329E2C:
loc_02329E2C:
	.word P1_BssStart + 0x25A1C	; 02329E2C

; ===== function loc_02329E30 =====
loc_02329E30:
	push {r4,lr}	; 02329E30
	add r4,r0,#0x0	; 02329E32
	cmp r4,#0x0	; 02329E34
	beq loc_02329E46	; 02329E36
	mov r1,#0x0	; 02329E38
	bl loc_0232E064	; 02329E3A
	ldr r0,[pool_02329E4C]	; 02329E3E
	ldr r1,[r0,#0x0]	; 02329E40
	bic r1,r4	; 02329E42
	str r1,[r0,#0x0]	; 02329E44
loc_02329E46:
	pop {r4}	; 02329E46
	pop {r3}	; 02329E48
	bx r3	; 02329E4A
pool_02329E4C:
loc_02329E4C:
	.word P1_BssStart + 0x25A24	; 02329E4C

; ===== function loc_02329E50 =====
loc_02329E50:
	push {r4,lr}	; 02329E50
	add r4,r0,#0x0	; 02329E52
	cmp r4,#0x0	; 02329E54
	bne loc_02329E60	; 02329E56
	mov r0,#0x1	; 02329E58
	pop {r4}	; 02329E5A
	pop {r3}	; 02329E5C
	bx r3	; 02329E5E
loc_02329E60:
	ldr r1,[pool_02329E8C]	; 02329E60
	ldr r1,[r1,#0x0]	; 02329E62
	add r2,r4,#0x0	; 02329E64
	and r2,r1	; 02329E66
	cmp r2,#0x0	; 02329E68
	beq loc_02329E74	; 02329E6A
	mov r0,#0x0	; 02329E6C
	pop {r4}	; 02329E6E
	pop {r3}	; 02329E70
	bx r3	; 02329E72
loc_02329E74:
	mov r1,#0x0	; 02329E74
	bl loc_0232E080	; 02329E76
	ldr r0,[pool_02329E8C]	; 02329E7A
	ldr r1,[r0,#0x0]	; 02329E7C
	orr r1,r4	; 02329E7E
	str r1,[r0,#0x0]	; 02329E80
	mov r0,#0x1	; 02329E82
	pop {r4}	; 02329E84
	pop {r3}	; 02329E86
	bx r3	; 02329E88
	.byte 0xC0, 0x46	; 02329E8C
pool_02329E8C:
loc_02329E8C:
	.word P1_BssStart + 0x25A24	; 02329E8C

; ===== function loc_02329E90 =====
loc_02329E90:
	mov r1,#0x0	; 02329E90
	ldr r0,[pool_02329EA0]	; 02329E92
	str r1,[r0,#0x0]	; 02329E94
	ldr r0,[pool_02329EA4]	; 02329E96
	str r1,[r0,#0x0]	; 02329E98
	ldr r0,[pool_02329EA8]	; 02329E9A
	str r1,[r0,#0x0]	; 02329E9C
	bx lr	; 02329E9E
pool_02329EA0:
loc_02329EA0:
	.word P1_BssStart + 0x25A24	; 02329EA0
pool_02329EA4:
loc_02329EA4:
	.word P1_BssStart + 0x25A1C	; 02329EA4
pool_02329EA8:
loc_02329EA8:
	.word P1_BssStart + 0x25A20	; 02329EA8

; ===== function loc_02329EAC =====
loc_02329EAC:
	push {r4,r5,r6,lr}	; 02329EAC
	add r5,r0,#0x0	; 02329EAE
	add r6,r1,#0x0	; 02329EB0
	ldr r4,[r5,#0x4]	; 02329EB2
	cmp r4,#0x0	; 02329EB4
	beq loc_02329EC4	; 02329EB6
	add r0,r4,#0x0	; 02329EB8
	add r1,r5,#0x0	; 02329EBA
	bl loc_023295B0	; 02329EBC
	mov r0,#0x0	; 02329EC0
	str r0,[r5,#0x4]	; 02329EC2
loc_02329EC4:
	ldr r0,[pool_02329EEC]	; 02329EC4
	add r1,r5,#0x0	; 02329EC6
	bl loc_023295B0	; 02329EC8
	add r0,r5,#0x0	; 02329ECC
	add r0,#0x3d	; 02329ECE
	strb r6,[r0,#0x0]	; 02329ED0
	cmp r4,#0x0	; 02329ED2
	beq loc_02329EDE	; 02329ED4
	add r0,r4,#0x0	; 02329ED6
	add r1,r5,#0x0	; 02329ED8
	bl loc_0232A044	; 02329EDA
loc_02329EDE:
	add r0,r5,#0x0	; 02329EDE
	bl loc_02329FFC	; 02329EE0
	pop {r4,r5,r6}	; 02329EE4
	pop {r3}	; 02329EE6
	bx r3	; 02329EE8
	.byte 0xC0, 0x46	; 02329EEC
pool_02329EEC:
loc_02329EEC:
	.word 0x023564B4	; 02329EEC

; ===== function loc_02329EF0 =====
	push {r4,lr}	; 02329EF0
	add r4,r0,#0x0	; 02329EF2
	ldr r0,[r4,#0x8]	; 02329EF4
	cmp r0,#0x0	; 02329EF6
	beq loc_02329F20	; 02329EF8
	bl loc_0232AC90	; 02329EFA
	ldr r1,[r4,#0xc]	; 02329EFE
	cmp r1,#0x0	; 02329F00
	beq loc_02329F0E	; 02329F02
	mov r0,#0x0	; 02329F04
	str r0,[r1,#0x8]	; 02329F06
	pop {r4}	; 02329F08
	pop {r3}	; 02329F0A
	bx r3	; 02329F0C
loc_02329F0E:
	ldr r2,[pool_02329F28]	; 02329F0E
	ldr r1,[r4,#0x10]	; 02329F10
	mov r0,#0x1c	; 02329F12
	mul r1,r0	; 02329F14
	add r0,r2,r1	; 02329F16
	add r0,#0xc	; 02329F18
	add r1,r4,#0x0	; 02329F1A
	bl loc_023295B0	; 02329F1C
loc_02329F20:
	pop {r4}	; 02329F20
	pop {r3}	; 02329F22
	bx r3	; 02329F24
	.byte 0xC0, 0x46	; 02329F28
pool_02329F28:
loc_02329F28:
	.word 0x023564C0	; 02329F28

; ===== function loc_02329F2C =====
loc_02329F2C:
	push {r4,r5,lr}	; 02329F2C
	sub sp,#0x4	; 02329F2E
	add r5,r0,#0x0	; 02329F30
	ldr r1,[r5,#0x0]	; 02329F32
	cmp r1,#0x0	; 02329F34
	beq loc_02329F3E	; 02329F36
	mov r0,#0x0	; 02329F38
	str r0,[r1,#0x0]	; 02329F3A
	str r0,[r5,#0x0]	; 02329F3C
loc_02329F3E:
	ldr r4,[r5,#0x4]	; 02329F3E
	add r0,r4,#0x0	; 02329F40
	add r1,r5,#0x0	; 02329F42
	bl loc_023295B0	; 02329F44
	mov r0,#0x0	; 02329F48
	str r0,[r5,#0x4]	; 02329F4A
	ldr r1,[r5,#0x8]	; 02329F4C
	cmp r1,#0x0	; 02329F4E
	beq loc_02329F62	; 02329F50
	add r4,#0xc	; 02329F52
	add r0,r4,#0x0	; 02329F54
	bl loc_02329670	; 02329F56
	mov r1,#0x0	; 02329F5A
	ldr r0,[r5,#0x8]	; 02329F5C
	str r1,[r0,#0xc]	; 02329F5E
	str r1,[r5,#0x8]	; 02329F60
loc_02329F62:
	ldr r0,[pool_02329F80]	; 02329F62
	add r1,r5,#0x0	; 02329F64
	bl loc_023295B0	; 02329F66
	ldr r0,[pool_02329F84]	; 02329F6A
	add r1,r5,#0x0	; 02329F6C
	bl loc_02329670	; 02329F6E
	mov r0,#0x0	; 02329F72
	add r5,#0x2c	; 02329F74
	strb r0,[r5,#0x0]	; 02329F76
	add sp,#0x4	; 02329F78
	pop {r4,r5}	; 02329F7A
	pop {r3}	; 02329F7C
	bx r3	; 02329F7E
pool_02329F80:
loc_02329F80:
	.word 0x023564B4	; 02329F80
pool_02329F84:
loc_02329F84:
	.word 0x023564A8	; 02329F84

; ===== function loc_02329F88 =====
loc_02329F88:
	push {r4,r5,lr}	; 02329F88
	sub sp,#0x4	; 02329F8A
	add r5,r0,#0x0	; 02329F8C
	ldr r0,[pool_02329FDC]	; 02329F8E
	mov r1,#0x0	; 02329F90
	bl loc_023295A0	; 02329F92
	add r4,r0,#0x0	; 02329F96
	cmp r4,#0x0	; 02329F98
	bne loc_02329FBE	; 02329F9A
	ldr r0,[pool_02329FE0]	; 02329F9C
	mov r1,#0x0	; 02329F9E
	bl loc_023295A0	; 02329FA0
	add r4,r0,#0x0	; 02329FA4
	add r1,r4,#0x0	; 02329FA6
	add r1,#0x3d	; 02329FA8
	ldrb r1,[r1,#0x0]	; 02329FAA
	cmp r5,r1	; 02329FAC
	bge loc_02329FBA	; 02329FAE
	mov r0,#0x0	; 02329FB0
	add sp,#0x4	; 02329FB2
	pop {r4,r5}	; 02329FB4
	pop {r3}	; 02329FB6
	bx r3	; 02329FB8
loc_02329FBA:
	bl loc_02329FE4	; 02329FBA
loc_02329FBE:
	ldr r0,[pool_02329FDC]	; 02329FBE
	add r1,r4,#0x0	; 02329FC0
	bl loc_023295B0	; 02329FC2
	add r0,r4,#0x0	; 02329FC6
	add r0,#0x3d	; 02329FC8
	strb r5,[r0,#0x0]	; 02329FCA
	add r0,r4,#0x0	; 02329FCC
	bl loc_02329FFC	; 02329FCE
	add r0,r4,#0x0	; 02329FD2
	add sp,#0x4	; 02329FD4
	pop {r4,r5}	; 02329FD6
	pop {r3}	; 02329FD8
	bx r3	; 02329FDA
pool_02329FDC:
loc_02329FDC:
	.word 0x023564A8	; 02329FDC
pool_02329FE0:
loc_02329FE0:
	.word 0x023564B4	; 02329FE0

; ===== function loc_02329FE4 =====
loc_02329FE4:
	push {r4,lr}	; 02329FE4
	add r4,r0,#0x0	; 02329FE6
	add r0,#0x3c	; 02329FE8
	ldrb r0,[r0,#0x0]	; 02329FEA
	bl loc_0232E1C0	; 02329FEC
	add r0,r4,#0x0	; 02329FF0
	bl loc_02329F2C	; 02329FF2
	pop {r4}	; 02329FF6
	pop {r3}	; 02329FF8
	bx r3	; 02329FFA

; ===== function loc_02329FFC =====
loc_02329FFC:
	push {r4,r5,lr}	; 02329FFC
	sub sp,#0x4	; 02329FFE
	add r5,r0,#0x0	; 0232A000
	ldr r0,[pool_0232A040]	; 0232A002
	mov r1,#0x0	; 0232A004
	bl loc_023295A0	; 0232A006
	add r1,r0,#0x0	; 0232A00A
	cmp r1,#0x0	; 0232A00C
	beq loc_0232A02E	; 0232A00E
	ldr r4,[pool_0232A040]	; 0232A010
loc_0232A012:
	add r0,r5,#0x0	; 0232A012
	add r0,#0x3d	; 0232A014
	ldrb r2,[r0,#0x0]	; 0232A016
	add r0,r1,#0x0	; 0232A018
	add r0,#0x3d	; 0232A01A
	ldrb r0,[r0,#0x0]	; 0232A01C
	cmp r2,r0	; 0232A01E
	bcc loc_0232A02E	; 0232A020
	add r0,r4,#0x0	; 0232A022
	bl loc_023295A0	; 0232A024
	add r1,r0,#0x0	; 0232A028
	cmp r1,#0x0	; 0232A02A
	bne loc_0232A012	; 0232A02C
loc_0232A02E:
	ldr r0,[pool_0232A040]	; 0232A02E
	add r2,r5,#0x0	; 0232A030
	bl loc_023295F0	; 0232A032
	add sp,#0x4	; 0232A036
	pop {r4,r5}	; 0232A038
	pop {r3}	; 0232A03A
	bx r3	; 0232A03C
	.byte 0xC0, 0x46	; 0232A040
pool_0232A040:
loc_0232A040:
	.word 0x023564B4	; 0232A040

; ===== function loc_0232A044 =====
loc_0232A044:
	push {r4,r5,lr}	; 0232A044
	sub sp,#0x4	; 0232A046
	add r5,r0,#0x0	; 0232A048
	add r4,r1,#0x0	; 0232A04A
	mov r1,#0x0	; 0232A04C
	bl loc_023295A0	; 0232A04E
	add r1,r0,#0x0	; 0232A052
	cmp r1,#0x0	; 0232A054
	beq loc_0232A074	; 0232A056
loc_0232A058:
	add r0,r4,#0x0	; 0232A058
	add r0,#0x3d	; 0232A05A
	ldrb r2,[r0,#0x0]	; 0232A05C
	add r0,r1,#0x0	; 0232A05E
	add r0,#0x3d	; 0232A060
	ldrb r0,[r0,#0x0]	; 0232A062
	cmp r2,r0	; 0232A064
	bcc loc_0232A074	; 0232A066
	add r0,r5,#0x0	; 0232A068
	bl loc_023295A0	; 0232A06A
	add r1,r0,#0x0	; 0232A06E
	cmp r1,#0x0	; 0232A070
	bne loc_0232A058	; 0232A072
loc_0232A074:
	add r0,r5,#0x0	; 0232A074
	add r2,r4,#0x0	; 0232A076
	bl loc_023295F0	; 0232A078
	str r5,[r4,#0x4]	; 0232A07C
	add sp,#0x4	; 0232A07E
	pop {r4,r5}	; 0232A080
	pop {r3}	; 0232A082
	bx r3	; 0232A084
	.byte 0x00, 0x00	; 0232A088

; ===== function loc_0232A088 =====
loc_0232A088:
	push {r4,lr}	; 0232A088
	add r4,r0,#0x0	; 0232A08A
	mov r1,#0x0	; 0232A08C
	add r0,#0x2e	; 0232A08E
	strb r1,[r0,#0x0]	; 0232A090
	add r0,r4,#0x0	; 0232A092
	add r0,#0x2d	; 0232A094
	strb r1,[r0,#0x0]	; 0232A096
	strh r1,[r4,#0x34]	; 0232A098
	strh r1,[r4,#0x3e]	; 0232A09A
	mov r1,#0x7f	; 0232A09C
	add r0,r4,#0x0	; 0232A09E
	add r0,#0x40	; 0232A0A0
	strb r1,[r0,#0x0]	; 0232A0A2
	add r0,r4,#0x0	; 0232A0A4
	add r0,#0x41	; 0232A0A6
	strb r1,[r0,#0x0]	; 0232A0A8
	add r0,r4,#0x0	; 0232A0AA
	add r0,#0x1c	; 0232A0AC
	bl loc_0232AFC8	; 0232A0AE
	add r4,#0x1c	; 0232A0B2
	add r0,r4,#0x0	; 0232A0B4
	ldr r1,[pool_0232A0C4]	; 0232A0B6
	mov r2,#0x1	; 0232A0B8
	bl loc_0232AFAC	; 0232A0BA
	pop {r4}	; 0232A0BE
	pop {r3}	; 0232A0C0
	bx r3	; 0232A0C2
pool_0232A0C4:
loc_0232A0C4:
	.word 0x00007F00	; 0232A0C4
loc_0232A0C8:
	push {r4,lr}	; 0232A0C8
	add r4,r0,#0x0	; 0232A0CA
	add r2,r1,#0x0	; 0232A0CC
	cmp r4,#0x0	; 0232A0CE
	beq loc_0232A100	; 0232A0D0
	add r1,r4,#0x0	; 0232A0D2
	add r1,#0x2c	; 0232A0D4
	ldrb r1,[r1,#0x0]	; 0232A0D6
	cmp r1,#0x0	; 0232A0D8
	beq loc_0232A100	; 0232A0DA
	cmp r2,#0x0	; 0232A0DC
	bne loc_0232A0EA	; 0232A0DE
	bl loc_02329FE4	; 0232A0E0
	pop {r4}	; 0232A0E4
	pop {r3}	; 0232A0E6
	bx r3	; 0232A0E8
loc_0232A0EA:
	add r0,#0x1c	; 0232A0EA
	mov r1,#0x0	; 0232A0EC
	bl loc_0232AFAC	; 0232A0EE
	add r0,r4,#0x0	; 0232A0F2
	mov r1,#0x0	; 0232A0F4
	bl loc_02329EAC	; 0232A0F6
	mov r0,#0x2	; 0232A0FA
	add r4,#0x2c	; 0232A0FC
	strb r0,[r4,#0x0]	; 0232A0FE
loc_0232A100:
	pop {r4}	; 0232A100
	pop {r3}	; 0232A102
	bx r3	; 0232A104
	.byte 0x00, 0x00	; 0232A108

; ===== function loc_0232A108 =====
loc_0232A108:
	push {r4,lr}	; 0232A108
	add r4,r0,#0x0	; 0232A10A
	add r0,#0x3c	; 0232A10C
	ldrb r0,[r0,#0x0]	; 0232A10E
	bl loc_0232E1D8	; 0232A110
	add r0,r4,#0x0	; 0232A114
	bl loc_0232A088	; 0232A116
	bl loc_0232E318	; 0232A11A
	str r0,[r4,#0x30]	; 0232A11E
	mov r0,#0x1	; 0232A120
	add r4,#0x2c	; 0232A122
	strb r0,[r4,#0x0]	; 0232A124
	pop {r4}	; 0232A126
	pop {r3}	; 0232A128
	bx r3	; 0232A12A

; ===== function loc_0232A12C =====
loc_0232A12C:
	ldr r3,[pool_0232A130]	; 0232A12C
	bx r3	; 0232A12E
pool_0232A130:
loc_0232A130:
	.word loc_02329F2C + 1	; 0232A130

; ===== function loc_0232A134 =====
loc_0232A134:
	push {r4,r5,r6,lr}	; 0232A134
	add r5,r0,#0x0	; 0232A136
	add r6,r2,#0x0	; 0232A138
	ldr r3,[pool_0232A1A8]	; 0232A13A
	mov r2,#0x1c	; 0232A13C
	mul r1,r2	; 0232A13E
	add r4,r3,r1	; 0232A140
	ldr r1,[r5,#0x0]	; 0232A142
	cmp r1,#0x0	; 0232A144
	beq loc_0232A14C	; 0232A146
	bl loc_0232A250	; 0232A148
loc_0232A14C:
	ldrh r1,[r4,#0x8]	; 0232A14C
	ldr r0,[r4,#0x18]	; 0232A14E
	cmp r1,r0	; 0232A150
	bcc loc_0232A17E	; 0232A152
	add r0,r4,#0x0	; 0232A154
	mov r1,#0x0	; 0232A156
	bl loc_023295A0	; 0232A158
	cmp r0,#0x0	; 0232A15C
	bne loc_0232A168	; 0232A15E
	mov r0,#0x0	; 0232A160
	pop {r4,r5,r6}	; 0232A162
	pop {r3}	; 0232A164
	bx r3	; 0232A166
loc_0232A168:
	add r1,r0,#0x0	; 0232A168
	add r1,#0x3d	; 0232A16A
	ldrb r1,[r1,#0x0]	; 0232A16C
	cmp r6,r1	; 0232A16E
	bge loc_0232A17A	; 0232A170
	mov r0,#0x0	; 0232A172
	pop {r4,r5,r6}	; 0232A174
	pop {r3}	; 0232A176
	bx r3	; 0232A178
loc_0232A17A:
	bl loc_02329FE4	; 0232A17A
loc_0232A17E:
	add r0,r6,#0x0	; 0232A17E
	bl loc_02329F88	; 0232A180
	add r6,r0,#0x0	; 0232A184
	cmp r6,#0x0	; 0232A186
	bne loc_0232A192	; 0232A188
	mov r0,#0x0	; 0232A18A
	pop {r4,r5,r6}	; 0232A18C
	pop {r3}	; 0232A18E
	bx r3	; 0232A190
loc_0232A192:
	add r0,r4,#0x0	; 0232A192
	add r1,r6,#0x0	; 0232A194
	bl loc_0232A044	; 0232A196
	str r5,[r6,#0x0]	; 0232A19A
	str r6,[r5,#0x0]	; 0232A19C
	add r0,r6,#0x0	; 0232A19E
	pop {r4,r5,r6}	; 0232A1A0
	pop {r3}	; 0232A1A2
	bx r3	; 0232A1A4
	.byte 0xC0, 0x46	; 0232A1A8
pool_0232A1A8:
loc_0232A1A8:
	.word 0x023564C0	; 0232A1A8

; ===== function loc_0232A1AC =====
loc_0232A1AC:
	push {r4}	; 0232A1AC
	sub sp,#0x4	; 0232A1AE
	ldr r4,[r0,#0x0]	; 0232A1B0
	cmp r4,#0x0	; 0232A1B2
	beq loc_0232A1C2	; 0232A1B4
	mov r3,#0x2	; 0232A1B6
	strh r3,[r4,#0x34]	; 0232A1B8
	ldr r3,[r0,#0x0]	; 0232A1BA
	strh r1,[r3,#0x38]	; 0232A1BC
	ldr r0,[r0,#0x0]	; 0232A1BE
	strh r2,[r0,#0x3a]	; 0232A1C0
loc_0232A1C2:
	add sp,#0x4	; 0232A1C2
	pop {r4}	; 0232A1C4
	bx lr	; 0232A1C6

; ===== function loc_0232A1C8 =====
	push {lr}	; 0232A1C8
	sub sp,#0x4	; 0232A1CA
	ldr r0,[r0,#0x0]	; 0232A1CC
	cmp r0,#0x0	; 0232A1CE
	beq loc_0232A1DA	; 0232A1D0
	add r0,#0x3c	; 0232A1D2
	ldrb r0,[r0,#0x0]	; 0232A1D4
	bl loc_0232E168	; 0232A1D6
loc_0232A1DA:
	add sp,#0x4	; 0232A1DA
	pop {r3}	; 0232A1DC
	bx r3	; 0232A1DE

; ===== function loc_0232A1E0 =====
	push {lr}	; 0232A1E0
	sub sp,#0x4	; 0232A1E2
	ldr r0,[r0,#0x0]	; 0232A1E4
	cmp r0,#0x0	; 0232A1E6
	beq loc_0232A1F2	; 0232A1E8
	add r0,#0x3c	; 0232A1EA
	ldrb r0,[r0,#0x0]	; 0232A1EC
	bl loc_0232E180	; 0232A1EE
loc_0232A1F2:
	add sp,#0x4	; 0232A1F2
	pop {r3}	; 0232A1F4
	bx r3	; 0232A1F6

; ===== function loc_0232A1F8 =====
loc_0232A1F8:
	push {lr}	; 0232A1F8
	sub sp,#0x4	; 0232A1FA
	ldr r0,[r0,#0x0]	; 0232A1FC
	cmp r0,#0x0	; 0232A1FE
	beq loc_0232A20A	; 0232A200
	add r0,#0x3c	; 0232A202
	ldrb r0,[r0,#0x0]	; 0232A204
	bl loc_0232E198	; 0232A206
loc_0232A20A:
	add sp,#0x4	; 0232A20A
	pop {r3}	; 0232A20C
	bx r3	; 0232A20E

; ===== function loc_0232A210 =====
	push {lr}	; 0232A210
	sub sp,#0x4	; 0232A212
	ldr r0,[r0,#0x0]	; 0232A214
	cmp r0,#0x0	; 0232A216
	beq loc_0232A22C	; 0232A218
	add r3,r0,#0x0	; 0232A21A
	add r3,#0x2c	; 0232A21C
	ldrb r3,[r3,#0x0]	; 0232A21E
	cmp r3,#0x2	; 0232A220
	beq loc_0232A22C	; 0232A222
	add r0,#0x1c	; 0232A224
	lsl r1,r1,#0x8	; 0232A226
	bl loc_0232AFAC	; 0232A228
loc_0232A22C:
	add sp,#0x4	; 0232A22C
	pop {r3}	; 0232A22E
	bx r3	; 0232A230
	.byte 0x00, 0x00	; 0232A234

; ===== function loc_0232A234 =====
loc_0232A234:
	ldr r0,[r0,#0x0]	; 0232A234
	cmp r0,#0x0	; 0232A236
	beq loc_0232A23E	; 0232A238
	add r0,#0x40	; 0232A23A
	strb r1,[r0,#0x0]	; 0232A23C
loc_0232A23E:
	bx lr	; 0232A23E

; ===== function loc_0232A240 =====
loc_0232A240:
	mov r1,#0x1c	; 0232A240
	mul r0,r1	; 0232A242
	ldr r1,[pool_0232A24C]	; 0232A244
	ldrh r0,[r1,r0]	; 0232A246
	bx lr	; 0232A248
	.byte 0xC0, 0x46	; 0232A24C
pool_0232A24C:
loc_0232A24C:
	.word P1_BssStart + 0x25A48	; 0232A24C

; ===== function loc_0232A250 =====
loc_0232A250:
	ldr r2,[r0,#0x0]	; 0232A250
	cmp r2,#0x0	; 0232A252
	beq loc_0232A25C	; 0232A254
	mov r1,#0x0	; 0232A256
	str r1,[r2,#0x0]	; 0232A258
	str r1,[r0,#0x0]	; 0232A25A
loc_0232A25C:
	bx lr	; 0232A25C
	.byte 0x00, 0x00	; 0232A260

; ===== function loc_0232A260 =====
loc_0232A260:
	mov r1,#0x0	; 0232A260
	str r1,[r0,#0x0]	; 0232A262
	bx lr	; 0232A264
	.byte 0x00, 0x00	; 0232A268
loc_0232A268:
	ldr r0,[r0,#0x0]	; 0232A268
	ldr r3,[pool_0232A270]	; 0232A26A
	bx r3	; 0232A26C
	.byte 0xC0, 0x46	; 0232A270
pool_0232A270:
loc_0232A270:
	.word loc_0232A0C8 + 1	; 0232A270

; ===== function loc_0232A274 =====
loc_0232A274:
	push {r4,r5,r6,lr}	; 0232A274
	sub sp,#0x8	; 0232A276
	add r5,r0,#0x0	; 0232A278
	add r6,r2,#0x0	; 0232A27A
	mov r3,#0x0	; 0232A27C
	str r3,[sp,#0x0]	; 0232A27E
	add r0,r1,#0x0	; 0232A280
	add r1,r6,#0x0	; 0232A282
	add r1,#0x14	; 0232A284
	ldr r2,[pool_0232A2D8]	; 0232A286
	bl loc_0232ABC8	; 0232A288
	add r4,r0,#0x0	; 0232A28C
	cmp r4,#0x0	; 0232A28E
	bne loc_0232A29C	; 0232A290
	mov r0,#0x0	; 0232A292
	add sp,#0x8	; 0232A294
	pop {r4,r5,r6}	; 0232A296
	pop {r3}	; 0232A298
	bx r3	; 0232A29A
loc_0232A29C:
	mov r0,#0x0	; 0232A29C
	str r0,[r4,#0xc]	; 0232A29E
	str r5,[r4,#0x10]	; 0232A2A0
	str r0,[r4,#0x8]	; 0232A2A2
	add r0,r4,#0x0	; 0232A2A4
	add r0,#0x14	; 0232A2A6
	add r1,r6,#0x0	; 0232A2A8
	bl loc_0232ACA4	; 0232A2AA
	cmp r0,#0x0	; 0232A2AE
	bne loc_0232A2BC	; 0232A2B0
	mov r0,#0x0	; 0232A2B2
	add sp,#0x8	; 0232A2B4
	pop {r4,r5,r6}	; 0232A2B6
	pop {r3}	; 0232A2B8
	bx r3	; 0232A2BA
loc_0232A2BC:
	str r0,[r4,#0x8]	; 0232A2BC
	ldr r1,[pool_0232A2DC]	; 0232A2BE
	mov r0,#0x1c	; 0232A2C0
	mul r5,r0	; 0232A2C2
	add r0,r1,r5	; 0232A2C4
	add r0,#0xc	; 0232A2C6
	add r1,r4,#0x0	; 0232A2C8
	bl loc_02329670	; 0232A2CA
	mov r0,#0x1	; 0232A2CE
	add sp,#0x8	; 0232A2D0
	pop {r4,r5,r6}	; 0232A2D2
	pop {r3}	; 0232A2D4
	bx r3	; 0232A2D6
pool_0232A2D8:
loc_0232A2D8:
	.word 0x02329EF1	; 0232A2D8
pool_0232A2DC:
loc_0232A2DC:
	.word 0x023564C0	; 0232A2DC

; ===== function loc_0232A2E0 =====
loc_0232A2E0:
	lsl r1,r1,#0x10	; 0232A2E0
	lsr r2,r1,#0x10	; 0232A2E2
	mov r1,#0x1c	; 0232A2E4
	mul r0,r1	; 0232A2E6
	ldr r1,[pool_0232A2F0]	; 0232A2E8
	str r2,[r1,r0]	; 0232A2EA
	bx lr	; 0232A2EC
	.byte 0xC0, 0x46	; 0232A2F0
pool_0232A2F0:
loc_0232A2F0:
	.word P1_BssStart + 0x25A58	; 0232A2F0

; ===== function loc_0232A2F4 =====
loc_0232A2F4:
	push {r4,r5,r6,r7,lr}	; 0232A2F4
	sub sp,#0xc	; 0232A2F6
	bl loc_0232E744	; 0232A2F8
	str r0,[sp,#0x4]	; 0232A2FC
	ldr r0,[pool_0232A3D8]	; 0232A2FE
	mov r1,#0x0	; 0232A300
	bl loc_023295A0	; 0232A302
	add r5,r0,#0x0	; 0232A306
	cmp r5,#0x0	; 0232A308
	beq loc_0232A3D0	; 0232A30A
	ldr r7,[pool_0232A3DC]	; 0232A30C
loc_0232A30E:
	ldr r0,[pool_0232A3D8]	; 0232A30E
	add r1,r5,#0x0	; 0232A310
	bl loc_023295A0	; 0232A312
	str r0,[sp,#0x0]	; 0232A316
	add r0,r5,#0x0	; 0232A318
	add r0,#0x2d	; 0232A31A
	ldrb r0,[r0,#0x0]	; 0232A31C
	cmp r0,#0x0	; 0232A31E
	bne loc_0232A334	; 0232A320
	ldr r0,[r5,#0x30]	; 0232A322
	bl loc_0232E2E8	; 0232A324
	cmp r0,#0x0	; 0232A328
	beq loc_0232A334	; 0232A32A
	add r1,r5,#0x0	; 0232A32C
	add r1,#0x2d	; 0232A32E
	mov r0,#0x1	; 0232A330
	strb r0,[r1,#0x0]	; 0232A332
loc_0232A334:
	add r0,r5,#0x0	; 0232A334
	add r0,#0x2d	; 0232A336
	ldrb r0,[r0,#0x0]	; 0232A338
	cmp r0,#0x0	; 0232A33A
	beq loc_0232A358	; 0232A33C
	add r0,r5,#0x0	; 0232A33E
	add r0,#0x3c	; 0232A340
	ldrb r0,[r0,#0x0]	; 0232A342
	mov r1,#0x1	; 0232A344
	lsl r1,r0	; 0232A346
	ldr r0,[sp,#0x4]	; 0232A348
	and r0,r1	; 0232A34A
	cmp r0,#0x0	; 0232A34C
	bne loc_0232A358	; 0232A34E
	add r0,r5,#0x0	; 0232A350
	bl loc_02329F2C	; 0232A352
	b loc_0232A3C8	; 0232A356
loc_0232A358:
	add r0,r5,#0x0	; 0232A358
	add r0,#0x1c	; 0232A35A
	bl loc_0232AF74	; 0232A35C
	add r0,r5,#0x0	; 0232A360
	add r0,#0x41	; 0232A362
	ldrb r0,[r0,#0x0]	; 0232A364
	lsl r0,r0,#0x1	; 0232A366
	ldrsh r4,[r7,r0]	; 0232A368
	add r0,r5,#0x0	; 0232A36A
	add r0,#0x40	; 0232A36C
	ldrb r0,[r0,#0x0]	; 0232A36E
	lsl r0,r0,#0x1	; 0232A370
	ldrsh r6,[r7,r0]	; 0232A372
	add r0,r5,#0x0	; 0232A374
	add r0,#0x1c	; 0232A376
	bl loc_0232AF84	; 0232A378
	asr r0,r0,#0x8	; 0232A37C
	lsl r0,r0,#0x1	; 0232A37E
	ldrsh r1,[r7,r0]	; 0232A380
	add r0,r6,r4	; 0232A382
	add r4,r1,r0	; 0232A384
	ldr r0,[pool_0232A3E0]	; 0232A386
	cmp r4,r0	; 0232A388
	bge loc_0232A390	; 0232A38A
	lsl r4,r0,#0	; 0232A38C
	b loc_0232A396	; 0232A38E
loc_0232A390:
	cmp r4,#0x0	; 0232A390
	ble loc_0232A396	; 0232A392
	mov r4,#0x0	; 0232A394
loc_0232A396:
	mov r0,#0x3e	; 0232A396
	ldrsh r0,[r5,r0]	; 0232A398
	cmp r4,r0	; 0232A39A
	beq loc_0232A3AC	; 0232A39C
	add r0,r5,#0x0	; 0232A39E
	add r0,#0x3c	; 0232A3A0
	ldrb r0,[r0,#0x0]	; 0232A3A2
	add r1,r4,#0x0	; 0232A3A4
	bl loc_0232E1AC	; 0232A3A6
	strh r4,[r5,#0x3e]	; 0232A3AA
loc_0232A3AC:
	add r0,r5,#0x0	; 0232A3AC
	add r0,#0x2c	; 0232A3AE
	ldrb r0,[r0,#0x0]	; 0232A3B0
	cmp r0,#0x2	; 0232A3B2
	bne loc_0232A3C8	; 0232A3B4
	add r0,r5,#0x0	; 0232A3B6
	add r0,#0x1c	; 0232A3B8
	bl loc_0232AF64	; 0232A3BA
	cmp r0,#0x0	; 0232A3BE
	beq loc_0232A3C8	; 0232A3C0
	add r0,r5,#0x0	; 0232A3C2
	bl loc_02329FE4	; 0232A3C4
loc_0232A3C8:
	ldr r5,[sp,#0x0]	; 0232A3C8
	lsl r0,r5,#0	; 0232A3CA
	cmp r0,#0x0	; 0232A3CC
	bne loc_0232A30E	; 0232A3CE
loc_0232A3D0:
	add sp,#0xc	; 0232A3D0
	pop {r4,r5,r6,r7}	; 0232A3D2
	pop {r3}	; 0232A3D4
	bx r3	; 0232A3D6
pool_0232A3D8:
loc_0232A3D8:
	.word 0x023564B4	; 0232A3D8
pool_0232A3DC:
loc_0232A3DC:
	.word 0x02330484	; 0232A3DC
pool_0232A3E0:
loc_0232A3E0:
	.word 0xFFFFFD2D	; 0232A3E0

; ===== function loc_0232A3E4 =====
loc_0232A3E4:
	push {r4,r5,r6,r7,lr}	; 0232A3E4
	sub sp,#0x4	; 0232A3E6
	ldr r0,[pool_0232A448]	; 0232A3E8
	mov r1,#0x14	; 0232A3EA
	bl loc_023296C4	; 0232A3EC
	ldr r0,[pool_0232A44C]	; 0232A3F0
	mov r1,#0x14	; 0232A3F2
	bl loc_023296C4	; 0232A3F4
	mov r5,#0x0	; 0232A3F8
	ldr r4,[pool_0232A450]	; 0232A3FA
	add r6,r5,#0x0	; 0232A3FC
	ldr r7,[pool_0232A44C]	; 0232A3FE
loc_0232A400:
	add r0,r4,#0x0	; 0232A400
	add r0,#0x2c	; 0232A402
	strb r6,[r0,#0x0]	; 0232A404
	add r0,r4,#0x0	; 0232A406
	add r0,#0x3c	; 0232A408
	strb r5,[r0,#0x0]	; 0232A40A
	add r0,r7,#0x0	; 0232A40C
	add r1,r4,#0x0	; 0232A40E
	bl loc_02329670	; 0232A410
	add r4,#0x44	; 0232A414
	add r5,r5,#0x1	; 0232A416
	cmp r5,#0x10	; 0232A418
	blt loc_0232A400	; 0232A41A
	mov r4,#0x0	; 0232A41C
	ldr r5,[pool_0232A454]	; 0232A41E
	add r6,r4,#0x0	; 0232A420
	mov r7,#0x1	; 0232A422
loc_0232A424:
	add r0,r5,#0x0	; 0232A424
	mov r1,#0xc	; 0232A426
	bl loc_023296C4	; 0232A428
	add r0,r5,#0x0	; 0232A42C
	add r0,#0xc	; 0232A42E
	add r1,r6,#0x0	; 0232A430
	bl loc_023296C4	; 0232A432
	str r7,[r5,#0x18]	; 0232A436
	add r5,#0x1c	; 0232A438
	add r4,r4,#0x1	; 0232A43A
	cmp r4,#0x20	; 0232A43C
	blt loc_0232A424	; 0232A43E
	add sp,#0x4	; 0232A440
	pop {r4,r5,r6,r7}	; 0232A442
	pop {r3}	; 0232A444
	bx r3	; 0232A446
pool_0232A448:
loc_0232A448:
	.word 0x023564B4	; 0232A448
pool_0232A44C:
loc_0232A44C:
	.word 0x023564A8	; 0232A44C
pool_0232A450:
loc_0232A450:
	.word P1_BssStart + 0x25DC0	; 0232A450
pool_0232A454:
loc_0232A454:
	.word 0x023564C0	; 0232A454

; ===== function loc_0232A458 =====
	push {r4,r5,r6,r7,lr}	; 0232A458
	sub sp,#0xc	; 0232A45A
	add r5,r0,#0x0	; 0232A45C
	ldr r0,[r5,#0x14]	; 0232A45E
	ldr r1,[r5,#0x2c]	; 0232A460
	blx P1_SignedDivMod	; 0232A462
	str r0,[sp,#0x4]	; 0232A466
	ldr r0,[r5,#0x18]	; 0232A468
	ldr r4,[sp,#0x4]	; 0232A46A
	mul r4,r0	; 0232A46C
	ldr r0,[r5,#0xc]	; 0232A46E
	add r6,r0,r4	; 0232A470
	ldr r0,[r5,#0x10]	; 0232A472
	add r7,r0,r4	; 0232A474
	add r0,r6,#0x0	; 0232A476
	ldr r1,[sp,#0x4]	; 0232A478
	blx P1_InvalidateDataCacheRange	; 0232A47A
	add r0,r7,#0x0	; 0232A47E
	ldr r1,[sp,#0x4]	; 0232A480
	blx P1_InvalidateDataCacheRange	; 0232A482
	ldr r0,[pool_0232A4EC]	; 0232A486
	ldr r0,[r0,#0x0]	; 0232A488
	cmp r0,#0x0	; 0232A48A
	beq loc_0232A4C0	; 0232A48C
	ldr r2,[pool_0232A4F0]	; 0232A48E
	ldr r0,[pool_0232A4F4]	; 0232A490
	ldr r0,[r0,#0x0]	; 0232A492
	mov r1,#0x14	; 0232A494
	mul r0,r1	; 0232A496
	add r1,r2,r0	; 0232A498
	str r5,[r2,r0]	; 0232A49A
	ldr r0,[sp,#0x4]	; 0232A49C
	str r0,[r1,#0x4]	; 0232A49E
	str r4,[r1,#0x8]	; 0232A4A0
	str r6,[r1,#0xc]	; 0232A4A2
	str r7,[r1,#0x10]	; 0232A4A4
	ldr r0,[pool_0232A4F8]	; 0232A4A6
	mov r2,#0x0	; 0232A4A8
	bl loc_0232BABC	; 0232A4AA
	ldr r0,[pool_0232A4F4]	; 0232A4AE
	ldr r1,[r0,#0x0]	; 0232A4B0
	add r1,r1,#0x1	; 0232A4B2
	str r1,[r0,#0x0]	; 0232A4B4
	cmp r1,#0x8	; 0232A4B6
	blt loc_0232A4D0	; 0232A4B8
	mov r1,#0x0	; 0232A4BA
	str r1,[r0,#0x0]	; 0232A4BC
	b loc_0232A4D0	; 0232A4BE
loc_0232A4C0:
	ldr r0,[r5,#0x34]	; 0232A4C0
	str r0,[sp,#0x0]	; 0232A4C2
	add r0,r6,#0x0	; 0232A4C4
	add r1,r7,#0x0	; 0232A4C6
	ldr r2,[sp,#0x4]	; 0232A4C8
	ldr r3,[r5,#0x8]	; 0232A4CA
	ldr r4,[r5,#0x30]	; 0232A4CC
	blx r4	; 0232A4CE
loc_0232A4D0:
	ldr r0,[r5,#0x18]	; 0232A4D0
	add r0,r0,#0x1	; 0232A4D2
	str r0,[r5,#0x18]	; 0232A4D4
	ldr r1,[r5,#0x18]	; 0232A4D6
	ldr r0,[r5,#0x2c]	; 0232A4D8
	cmp r1,r0	; 0232A4DA
	blt loc_0232A4E2	; 0232A4DC
	mov r0,#0x0	; 0232A4DE
	str r0,[r5,#0x18]	; 0232A4E0
loc_0232A4E2:
	add sp,#0xc	; 0232A4E2
	pop {r4,r5,r6,r7}	; 0232A4E4
	pop {r3}	; 0232A4E6
	bx r3	; 0232A4E8
	.byte 0xC0, 0x46	; 0232A4EC
pool_0232A4EC:
loc_0232A4EC:
	.word P1_BssStart + 0x26204	; 0232A4EC
pool_0232A4F0:
loc_0232A4F0:
	.word P1_BssStart + 0x2626C	; 0232A4F0
pool_0232A4F4:
loc_0232A4F4:
	.word P1_BssStart + 0x26200	; 0232A4F4
pool_0232A4F8:
loc_0232A4F8:
	.word 0x02356C88	; 0232A4F8

; ===== function loc_0232A4FC =====
loc_0232A4FC:
	push {r4,lr}	; 0232A4FC
	sub sp,#0x8	; 0232A4FE
	ldr r4,[pool_0232A558]	; 0232A500
	ldr r0,[r4,#0x0]	; 0232A502
	cmp r0,#0x0	; 0232A504
	beq loc_0232A54E	; 0232A506
	mov r0,#0x0	; 0232A508
	str r0,[r4,#0x18]	; 0232A50A
	str r0,[sp,#0x0]	; 0232A50C
	ldr r0,[sp,#0x0]	; 0232A50E
	ldr r1,[r4,#0xc]	; 0232A510
	ldr r2,[r4,#0x14]	; 0232A512
	blx loc_0232DE4C	; 0232A514
	mov r0,#0x0	; 0232A518
	str r0,[sp,#0x4]	; 0232A51A
	ldr r0,[sp,#0x4]	; 0232A51C
	ldr r1,[r4,#0x10]	; 0232A51E
	ldr r2,[r4,#0x14]	; 0232A520
	blx loc_0232DE4C	; 0232A522
	ldr r0,[r4,#0xc]	; 0232A526
	ldr r1,[r4,#0x14]	; 0232A528
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A52A
	ldr r0,[r4,#0x10]	; 0232A52E
	ldr r1,[r4,#0x14]	; 0232A530
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A532
	ldr r0,[r4,#0x28]	; 0232A536
	cmp r0,#0x0	; 0232A538
	blt loc_0232A542	; 0232A53A
	mov r2,#0x1	; 0232A53C
	lsl r2,r0	; 0232A53E
	b loc_0232A544	; 0232A540
loc_0232A542:
	mov r2,#0x0	; 0232A542
loc_0232A544:
	ldr r0,[r4,#0x20]	; 0232A544
	ldr r1,[r4,#0x24]	; 0232A546
	mov r3,#0x0	; 0232A548
	bl loc_0232E148	; 0232A54A
loc_0232A54E:
	add sp,#0x8	; 0232A54E
	pop {r4}	; 0232A550
	pop {r3}	; 0232A552
	bx r3	; 0232A554
	.byte 0xC0, 0x46	; 0232A558
pool_0232A558:
loc_0232A558:
	.word P1_BssStart + 0x2621C	; 0232A558

; ===== function loc_0232A55C =====
loc_0232A55C:
	push {r4,lr}	; 0232A55C
	ldr r1,[pool_0232A598]	; 0232A55E
	ldr r0,[r1,#0x0]	; 0232A560
	cmp r0,#0x0	; 0232A562
	beq loc_0232A590	; 0232A564
	ldr r0,[r1,#0x28]	; 0232A566
	cmp r0,#0x0	; 0232A568
	blt loc_0232A572	; 0232A56A
	mov r2,#0x1	; 0232A56C
	lsl r2,r0	; 0232A56E
	b loc_0232A574	; 0232A570
loc_0232A572:
	mov r2,#0x0	; 0232A572
loc_0232A574:
	ldr r0,[r1,#0x20]	; 0232A574
	ldr r1,[r1,#0x24]	; 0232A576
	mov r3,#0x0	; 0232A578
	bl loc_0232E100	; 0232A57A
	bl loc_0232E318	; 0232A57E
	add r4,r0,#0x0	; 0232A582
	mov r0,#0x1	; 0232A584
	bl loc_0232E384	; 0232A586
	add r0,r4,#0x0	; 0232A58A
	bl loc_0232E338	; 0232A58C
loc_0232A590:
	pop {r4}	; 0232A590
	pop {r3}	; 0232A592
	bx r3	; 0232A594
	.byte 0xC0, 0x46	; 0232A598
pool_0232A598:
loc_0232A598:
	.word P1_BssStart + 0x2621C	; 0232A598

; ===== function loc_0232A59C =====
loc_0232A59C:
	push {r4,r5,r6,r7,lr}	; 0232A59C
	sub sp,#0x4	; 0232A59E
	ldr r4,[pool_0232A62C]	; 0232A5A0
	ldr r0,[r4,#0x28]	; 0232A5A2
	cmp r0,#0x0	; 0232A5A4
	blt loc_0232A5AC	; 0232A5A6
	mov r5,#0x1	; 0232A5A8
	b loc_0232A5AE	; 0232A5AA
loc_0232A5AC:
	mov r5,#0x0	; 0232A5AC
loc_0232A5AE:
	cmp r5,#0x0	; 0232A5AE
	beq loc_0232A5BA	; 0232A5B0
	mov r2,#0x1	; 0232A5B2
	ldr r0,[r4,#0x28]	; 0232A5B4
	lsl r2,r0	; 0232A5B6
	b loc_0232A5BC	; 0232A5B8
loc_0232A5BA:
	mov r2,#0x0	; 0232A5BA
loc_0232A5BC:
	ldr r0,[r4,#0x20]	; 0232A5BC
	ldr r1,[r4,#0x24]	; 0232A5BE
	mov r3,#0x0	; 0232A5C0
	bl loc_0232E100	; 0232A5C2
	cmp r5,#0x0	; 0232A5C6
	beq loc_0232A5EE	; 0232A5C8
	bl loc_0232E318	; 0232A5CA
	add r6,r0,#0x0	; 0232A5CE
	mov r0,#0x1	; 0232A5D0
	bl loc_0232E384	; 0232A5D2
	add r0,r6,#0x0	; 0232A5D6
	bl loc_0232E338	; 0232A5D8
	ldr r6,[pool_0232A630]	; 0232A5DC
	mov r7,#0x0	; 0232A5DE
loc_0232A5E0:
	add r0,r6,#0x0	; 0232A5E0
	add r1,r7,#0x0	; 0232A5E2
	add r2,r7,#0x0	; 0232A5E4
	bl loc_0232BA48	; 0232A5E6
	cmp r0,#0x0	; 0232A5EA
	bne loc_0232A5E0	; 0232A5EC
loc_0232A5EE:
	ldr r0,[r4,#0x24]	; 0232A5EE
	cmp r0,#0x0	; 0232A5F0
	beq loc_0232A5F8	; 0232A5F2
	bl loc_02329E04	; 0232A5F4
loc_0232A5F8:
	ldr r0,[r4,#0x1c]	; 0232A5F8
	cmp r0,#0x0	; 0232A5FA
	beq loc_0232A602	; 0232A5FC
	bl loc_02329E30	; 0232A5FE
loc_0232A602:
	cmp r5,#0x0	; 0232A602
	beq loc_0232A60C	; 0232A604
	ldr r0,[r4,#0x28]	; 0232A606
	bl loc_02329DC4	; 0232A608
loc_0232A60C:
	ldr r0,[r4,#0x4]	; 0232A60C
	cmp r0,#0x1	; 0232A60E
	bne loc_0232A61E	; 0232A610
	mov r0,#0x0	; 0232A612
	add r1,r0,#0x0	; 0232A614
	add r2,r0,#0x0	; 0232A616
	add r3,r0,#0x0	; 0232A618
	bl loc_0232DFE8	; 0232A61A
loc_0232A61E:
	mov r0,#0x0	; 0232A61E
	str r0,[r4,#0x0]	; 0232A620
	add sp,#0x4	; 0232A622
	pop {r4,r5,r6,r7}	; 0232A624
	pop {r3}	; 0232A626
	bx r3	; 0232A628
	.byte 0xC0, 0x46	; 0232A62C
pool_0232A62C:
loc_0232A62C:
	.word P1_BssStart + 0x2621C	; 0232A62C
pool_0232A630:
loc_0232A630:
	.word 0x02356C88	; 0232A630

; ===== function loc_0232A634 =====
loc_0232A634:
	push {r4,r5,r6,r7,lr}	; 0232A634
	sub sp,#0x44	; 0232A636
	str r0,[sp,#0x18]	; 0232A638
	str r1,[sp,#0x1c]	; 0232A63A
	str r2,[sp,#0x20]	; 0232A63C
	str r3,[sp,#0x24]	; 0232A63E
	ldr r7,[sp,#0x64]	; 0232A640
	ldr r0,[sp,#0x6c]	; 0232A642
	str r0,[sp,#0x6c]	; 0232A644
	mov r0,#0x0	; 0232A646
	str r0,[sp,#0x30]	; 0232A648
	mvn r5,r0	; 0232A64A
	ldr r4,[pool_0232A850]	; 0232A64C
	lsl r0,r1,#0	; 0232A64E
	lsl r1,r3,#0	; 0232A650
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A652
	ldr r0,[sp,#0x20]	; 0232A656
	ldr r1,[sp,#0x24]	; 0232A658
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A65A
	ldr r0,[sp,#0x58]	; 0232A65E
	cmp r0,#0x1	; 0232A660
	bne loc_0232A668	; 0232A662
	mov r6,#0x1	; 0232A664
	b loc_0232A66A	; 0232A666
loc_0232A668:
	mov r6,#0x0	; 0232A668
loc_0232A66A:
	ldr r0,[pool_0232A854]	; 0232A66A
	ldr r1,[sp,#0x68]	; 0232A66C
	blx P1_SignedDivMod	; 0232A66E
	str r0,[sp,#0x34]	; 0232A672
	ldr r0,[sp,#0x7c]	; 0232A674
	cmp r0,#0x0	; 0232A676
	beq loc_0232A6B4	; 0232A678
	ldr r0,[sp,#0x24]	; 0232A67A
	cmp r6,#0x0	; 0232A67C
	bne loc_0232A682	; 0232A67E
	asr r0,r0,#0x1	; 0232A680
loc_0232A682:
	ldr r1,[sp,#0x34]	; 0232A682
	add r1,#0x10	; 0232A684
	str r1,[sp,#0x34]	; 0232A686
	mov r2,#0x1f	; 0232A688
	bic r1,r2	; 0232A68A
	str r1,[sp,#0x34]	; 0232A68C
	asr r1,r1,#0x5	; 0232A68E
	str r1,[sp,#0x40]	; 0232A690
	ldr r1,[sp,#0x78]	; 0232A692
	blx P1_SignedDivMod	; 0232A694
	ldr r1,[sp,#0x40]	; 0232A698
	str r1,[sp,#0x38]	; 0232A69A
	mul r1,r0	; 0232A69C
	str r1,[sp,#0x38]	; 0232A69E
	mov r0,#0x20	; 0232A6A0
	str r0,[sp,#0x3c]	; 0232A6A2
	cmp r6,#0x0	; 0232A6A4
	bne loc_0232A6AC	; 0232A6A6
	asr r0,r0,#0x1	; 0232A6A8
	str r0,[sp,#0x3c]	; 0232A6AA
loc_0232A6AC:
	ldr r1,[sp,#0x3c]	; 0232A6AC
	ldr r0,[sp,#0x40]	; 0232A6AE
	mul r1,r0	; 0232A6B0
	str r1,[sp,#0x3c]	; 0232A6B2
loc_0232A6B4:
	cmp r6,#0x0	; 0232A6B4
	beq loc_0232A6BE	; 0232A6B6
	mov r0,#0x0	; 0232A6B8
	str r0,[sp,#0x2c]	; 0232A6BA
	b loc_0232A6C2	; 0232A6BC
loc_0232A6BE:
	mov r0,#0x1	; 0232A6BE
	str r0,[sp,#0x2c]	; 0232A6C0
loc_0232A6C2:
	cmp r6,#0x0	; 0232A6C2
	beq loc_0232A6CC	; 0232A6C4
	mov r0,#0x1	; 0232A6C6
	str r0,[sp,#0x28]	; 0232A6C8
	b loc_0232A6D0	; 0232A6CA
loc_0232A6CC:
	mov r0,#0x0	; 0232A6CC
	str r0,[sp,#0x28]	; 0232A6CE
loc_0232A6D0:
	ldr r0,[sp,#0x18]	; 0232A6D0
	cmp r0,#0x2	; 0232A6D2
	beq loc_0232A6DA	; 0232A6D4
	mov r0,#0xa	; 0232A6D6
	str r0,[sp,#0x30]	; 0232A6D8
loc_0232A6DA:
	ldr r0,[sp,#0x7c]	; 0232A6DA
	cmp r0,#0x0	; 0232A6DC
	beq loc_0232A6F4	; 0232A6DE
	bl loc_02329DD8	; 0232A6E0
	add r5,r0,#0x0	; 0232A6E4
	cmp r5,#0x0	; 0232A6E6
	bge loc_0232A6F4	; 0232A6E8
	mov r0,#0x0	; 0232A6EA
	add sp,#0x44	; 0232A6EC
	pop {r4,r5,r6,r7}	; 0232A6EE
	pop {r3}	; 0232A6F0
	bx r3	; 0232A6F2
loc_0232A6F4:
	mov r0,#0x3	; 0232A6F4
	bl loc_02329E14	; 0232A6F6
	cmp r0,#0x0	; 0232A6FA
	bne loc_0232A712	; 0232A6FC
	cmp r5,#0x0	; 0232A6FE
	blt loc_0232A708	; 0232A700
	add r0,r5,#0x0	; 0232A702
	bl loc_02329DC4	; 0232A704
loc_0232A708:
	mov r0,#0x0	; 0232A708
	add sp,#0x44	; 0232A70A
	pop {r4,r5,r6,r7}	; 0232A70C
	pop {r3}	; 0232A70E
	bx r3	; 0232A710
loc_0232A712:
	mov r0,#0xa	; 0232A712
	bl loc_02329E50	; 0232A714
	cmp r0,#0x0	; 0232A718
	bne loc_0232A736	; 0232A71A
	cmp r5,#0x0	; 0232A71C
	blt loc_0232A726	; 0232A71E
	add r0,r5,#0x0	; 0232A720
	bl loc_02329DC4	; 0232A722
loc_0232A726:
	mov r0,#0x3	; 0232A726
	bl loc_02329E04	; 0232A728
	mov r0,#0x0	; 0232A72C
	add sp,#0x44	; 0232A72E
	pop {r4,r5,r6,r7}	; 0232A730
	pop {r3}	; 0232A732
	bx r3	; 0232A734
loc_0232A736:
	cmp r7,#0x0	; 0232A736
	beq loc_0232A73E	; 0232A738
	mov r3,#0x1	; 0232A73A
	b loc_0232A740	; 0232A73C
loc_0232A73E:
	mov r3,#0x2	; 0232A73E
loc_0232A740:
	ldr r0,[sp,#0x24]	; 0232A740
	lsr r6,r0,#0x2	; 0232A742
	mov r1,#0x0	; 0232A744
	str r1,[sp,#0x0]	; 0232A746
	str r6,[sp,#0x4]	; 0232A748
	ldr r0,[sp,#0x6c]	; 0232A74A
	str r0,[sp,#0x8]	; 0232A74C
	str r1,[sp,#0xc]	; 0232A74E
	ldr r0,[sp,#0x34]	; 0232A750
	str r0,[sp,#0x10]	; 0232A752
	ldr r0,[sp,#0x70]	; 0232A754
	str r0,[sp,#0x14]	; 0232A756
	mov r0,#0x1	; 0232A758
	ldr r1,[sp,#0x2c]	; 0232A75A
	ldr r2,[sp,#0x1c]	; 0232A75C
	bl loc_0232E008	; 0232A75E
	str r7,[sp,#0x0]	; 0232A762
	ldr r0,[sp,#0x5c]	; 0232A764
	str r0,[sp,#0x4]	; 0232A766
	ldr r0,[sp,#0x60]	; 0232A768
	str r0,[sp,#0x8]	; 0232A76A
	mov r0,#0x0	; 0232A76C
	ldr r1,[sp,#0x28]	; 0232A76E
	ldr r2,[sp,#0x1c]	; 0232A770
	add r3,r6,#0x0	; 0232A772
	bl loc_0232E0C4	; 0232A774
	cmp r7,#0x0	; 0232A778
	beq loc_0232A780	; 0232A77A
	mov r3,#0x1	; 0232A77C
	b loc_0232A782	; 0232A77E
loc_0232A780:
	mov r3,#0x2	; 0232A780
loc_0232A782:
	mov r1,#0x0	; 0232A782
	str r1,[sp,#0x0]	; 0232A784
	str r6,[sp,#0x4]	; 0232A786
	ldr r0,[sp,#0x6c]	; 0232A788
	str r0,[sp,#0x8]	; 0232A78A
	str r1,[sp,#0xc]	; 0232A78C
	ldr r0,[sp,#0x34]	; 0232A78E
	str r0,[sp,#0x10]	; 0232A790
	ldr r0,[sp,#0x74]	; 0232A792
	str r0,[sp,#0x14]	; 0232A794
	mov r0,#0x3	; 0232A796
	ldr r1,[sp,#0x2c]	; 0232A798
	ldr r2,[sp,#0x20]	; 0232A79A
	bl loc_0232E008	; 0232A79C
	str r7,[sp,#0x0]	; 0232A7A0
	ldr r0,[sp,#0x5c]	; 0232A7A2
	str r0,[sp,#0x4]	; 0232A7A4
	ldr r0,[sp,#0x60]	; 0232A7A6
	str r0,[sp,#0x8]	; 0232A7A8
	mov r0,#0x1	; 0232A7AA
	ldr r1,[sp,#0x28]	; 0232A7AC
	ldr r2,[sp,#0x20]	; 0232A7AE
	add r3,r6,#0x0	; 0232A7B0
	bl loc_0232E0C4	; 0232A7B2
	cmp r5,#0x0	; 0232A7B6
	blt loc_0232A7CA	; 0232A7B8
	str r4,[sp,#0x0]	; 0232A7BA
	add r0,r5,#0x0	; 0232A7BC
	ldr r2,[sp,#0x38]	; 0232A7BE
	ldr r1,[sp,#0x3c]	; 0232A7C0
	add r1,r2,r1	; 0232A7C2
	ldr r3,[pool_0232A858]	; 0232A7C4
	bl loc_0232E09C	; 0232A7C6
loc_0232A7CA:
	ldr r0,[sp,#0x18]	; 0232A7CA
	cmp r0,#0x1	; 0232A7CC
	bne loc_0232A7DC	; 0232A7CE
	mov r0,#0x3	; 0232A7D0
	add r1,r0,#0x0	; 0232A7D2
	mov r2,#0x1	; 0232A7D4
	add r3,r2,#0x0	; 0232A7D6
	bl loc_0232DFE8	; 0232A7D8
loc_0232A7DC:
	cmp r5,#0x0	; 0232A7DC
	blt loc_0232A7E6	; 0232A7DE
	mov r2,#0x1	; 0232A7E0
	lsl r2,r5	; 0232A7E2
	b loc_0232A7E8	; 0232A7E4
loc_0232A7E6:
	mov r2,#0x0	; 0232A7E6
loc_0232A7E8:
	ldr r0,[sp,#0x30]	; 0232A7E8
	mov r1,#0x3	; 0232A7EA
	mov r3,#0x0	; 0232A7EC
	bl loc_0232E148	; 0232A7EE
	mov r0,#0x1	; 0232A7F2
	str r0,[r4,#0x0]	; 0232A7F4
	ldr r0,[sp,#0x18]	; 0232A7F6
	str r0,[r4,#0x4]	; 0232A7F8
	mov r0,#0xa	; 0232A7FA
	str r0,[r4,#0x1c]	; 0232A7FC
	ldr r0,[sp,#0x30]	; 0232A7FE
	str r0,[r4,#0x20]	; 0232A800
	mov r0,#0x3	; 0232A802
	str r0,[r4,#0x24]	; 0232A804
	str r5,[r4,#0x28]	; 0232A806
	ldr r0,[sp,#0x58]	; 0232A808
	str r0,[r4,#0x8]	; 0232A80A
	ldr r0,[sp,#0x1c]	; 0232A80C
	str r0,[r4,#0xc]	; 0232A80E
	ldr r0,[sp,#0x20]	; 0232A810
	str r0,[r4,#0x10]	; 0232A812
	ldr r0,[sp,#0x24]	; 0232A814
	str r0,[r4,#0x14]	; 0232A816
	mov r0,#0x0	; 0232A818
	str r0,[r4,#0x18]	; 0232A81A
	ldr r0,[sp,#0x78]	; 0232A81C
	str r0,[r4,#0x2c]	; 0232A81E
	ldr r0,[sp,#0x7c]	; 0232A820
	str r0,[r4,#0x30]	; 0232A822
	ldr r0,[sp,#0x80]	; 0232A824
	str r0,[r4,#0x34]	; 0232A826
	ldr r0,[sp,#0x6c]	; 0232A828
	str r0,[r4,#0x4c]	; 0232A82A
	add r0,r4,#0x0	; 0232A82C
	add r0,#0x38	; 0232A82E
	bl loc_0232AFC8	; 0232A830
	add r0,r4,#0x0	; 0232A834
	add r0,#0x38	; 0232A836
	ldr r1,[sp,#0x6c]	; 0232A838
	lsl r1,r1,#0x8	; 0232A83A
	mov r2,#0x1	; 0232A83C
	bl loc_0232AFAC	; 0232A83E
	mov r0,#0x0	; 0232A842
	str r0,[r4,#0x48]	; 0232A844
	mov r0,#0x1	; 0232A846
	add sp,#0x44	; 0232A848
	pop {r4,r5,r6,r7}	; 0232A84A
	pop {r3}	; 0232A84C
	bx r3	; 0232A84E
pool_0232A850:
loc_0232A850:
	.word 0x02356C9C	; 0232A850
pool_0232A854:
loc_0232A854:
	.word 0x00FFB0FF	; 0232A854
pool_0232A858:
loc_0232A858:
	.word 0x0232A459	; 0232A858

; ===== function loc_0232A85C =====
loc_0232A85C:
	push {lr}	; 0232A85C
	sub sp,#0x4	; 0232A85E
	ldr r0,[pool_0232A878]	; 0232A860
	ldr r1,[r0,#0x0]	; 0232A862
	cmp r1,#0x0	; 0232A864
	beq loc_0232A872	; 0232A866
	ldr r0,[r0,#0x4]	; 0232A868
	cmp r0,#0x1	; 0232A86A
	bne loc_0232A872	; 0232A86C
	bl loc_0232A59C	; 0232A86E
loc_0232A872:
	add sp,#0x4	; 0232A872
	pop {r3}	; 0232A874
	bx r3	; 0232A876
pool_0232A878:
loc_0232A878:
	.word P1_BssStart + 0x2621C	; 0232A878

; ===== function loc_0232A87C =====
loc_0232A87C:
	push {r4,r5,r6,r7,lr}	; 0232A87C
	sub sp,#0x34	; 0232A87E
	add r5,r0,#0x0	; 0232A880
	add r4,r1,#0x0	; 0232A882
	add r6,r2,#0x0	; 0232A884
	add r7,r3,#0x0	; 0232A886
	bl loc_0232A85C	; 0232A888
	ldr r0,[pool_0232A8E8]	; 0232A88C
	ldr r0,[r0,#0x0]	; 0232A88E
	cmp r0,#0x0	; 0232A890
	beq loc_0232A89E	; 0232A892
	mov r0,#0x0	; 0232A894
	add sp,#0x34	; 0232A896
	pop {r4,r5,r6,r7}	; 0232A898
	pop {r3}	; 0232A89A
	bx r3	; 0232A89C
loc_0232A89E:
	mov r0,#0x0	; 0232A89E
	str r0,[sp,#0x2c]	; 0232A8A0
	ldr r0,[sp,#0x2c]	; 0232A8A2
	add r1,r5,#0x0	; 0232A8A4
	add r2,r4,#0x0	; 0232A8A6
	blx loc_0232DE4C	; 0232A8A8
	add r0,r5,#0x0	; 0232A8AC
	add r1,r4,#0x0	; 0232A8AE
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A8B0
	lsr r3,r4,#0x1	; 0232A8B4
	str r6,[sp,#0x0]	; 0232A8B6
	mov r2,#0x0	; 0232A8B8
	str r2,[sp,#0x4]	; 0232A8BA
	str r2,[sp,#0x8]	; 0232A8BC
	mov r0,#0x1	; 0232A8BE
	str r0,[sp,#0xc]	; 0232A8C0
	str r7,[sp,#0x10]	; 0232A8C2
	mov r1,#0x7f	; 0232A8C4
	str r1,[sp,#0x14]	; 0232A8C6
	str r2,[sp,#0x18]	; 0232A8C8
	str r1,[sp,#0x1c]	; 0232A8CA
	ldr r1,[sp,#0x48]	; 0232A8CC
	str r1,[sp,#0x20]	; 0232A8CE
	ldr r1,[sp,#0x4c]	; 0232A8D0
	str r1,[sp,#0x24]	; 0232A8D2
	ldr r1,[sp,#0x50]	; 0232A8D4
	str r1,[sp,#0x28]	; 0232A8D6
	add r1,r5,#0x0	; 0232A8D8
	add r2,r5,r3	; 0232A8DA
	bl loc_0232A634	; 0232A8DC
	add sp,#0x34	; 0232A8E0
	pop {r4,r5,r6,r7}	; 0232A8E2
	pop {r3}	; 0232A8E4
	bx r3	; 0232A8E6
pool_0232A8E8:
loc_0232A8E8:
	.word P1_BssStart + 0x2621C	; 0232A8E8

; ===== function loc_0232A8EC =====
loc_0232A8EC:
	push {r4,r5,lr}	; 0232A8EC
	sub sp,#0x4	; 0232A8EE
	ldr r4,[pool_0232A948]	; 0232A8F0
	ldr r0,[r4,#0x0]	; 0232A8F2
	cmp r0,#0x0	; 0232A8F4
	beq loc_0232A93E	; 0232A8F6
	ldr r0,[r4,#0x4]	; 0232A8F8
	cmp r0,#0x0	; 0232A8FA
	bne loc_0232A93E	; 0232A8FC
	add r5,r4,#0x0	; 0232A8FE
	add r5,#0x38	; 0232A900
	add r0,r5,#0x0	; 0232A902
	bl loc_0232AF74	; 0232A904
	ldr r0,[r4,#0x48]	; 0232A908
	cmp r0,#0x0	; 0232A90A
	beq loc_0232A924	; 0232A90C
	add r0,r5,#0x0	; 0232A90E
	bl loc_0232AF64	; 0232A910
	cmp r0,#0x0	; 0232A914
	beq loc_0232A924	; 0232A916
	bl loc_0232A59C	; 0232A918
	add sp,#0x4	; 0232A91C
	pop {r4,r5}	; 0232A91E
	pop {r3}	; 0232A920
	bx r3	; 0232A922
loc_0232A924:
	add r0,r5,#0x0	; 0232A924
	bl loc_0232AF84	; 0232A926
	asr r5,r0,#0x8	; 0232A92A
	ldr r0,[r4,#0x4c]	; 0232A92C
	cmp r5,r0	; 0232A92E
	beq loc_0232A93E	; 0232A930
	ldr r0,[r4,#0x20]	; 0232A932
	add r1,r5,#0x0	; 0232A934
	mov r2,#0x0	; 0232A936
	bl loc_0232E044	; 0232A938
	str r5,[r4,#0x4c]	; 0232A93C
loc_0232A93E:
	add sp,#0x4	; 0232A93E
	pop {r4,r5}	; 0232A940
	pop {r3}	; 0232A942
	bx r3	; 0232A944
	.byte 0xC0, 0x46	; 0232A948
pool_0232A948:
loc_0232A948:
	.word P1_BssStart + 0x2621C	; 0232A948

; ===== function loc_0232A94C =====
loc_0232A94C:
	mov r1,#0x0	; 0232A94C
	ldr r0,[pool_0232A958]	; 0232A94E
	str r1,[r0,#0x0]	; 0232A950
	ldr r0,[pool_0232A95C]	; 0232A952
	str r1,[r0,#0x0]	; 0232A954
	bx lr	; 0232A956
pool_0232A958:
loc_0232A958:
	.word P1_BssStart + 0x26204	; 0232A958
pool_0232A95C:
loc_0232A95C:
	.word P1_BssStart + 0x2621C	; 0232A95C

; ===== function loc_0232A960 =====
loc_0232A960:
	ldr r1,[pool_0232A978]	; 0232A960
	ldr r1,[r1,#0x0]	; 0232A962
	ldr r2,[r1,#0x7c]	; 0232A964
	ldr r1,[r2,#0x8]	; 0232A966
	cmp r0,r1	; 0232A968
	bcc loc_0232A970	; 0232A96A
	mov r0,#0x0	; 0232A96C
	bx lr	; 0232A96E
loc_0232A970:
	lsl r0,r0,#0x4	; 0232A970
	add r0,r2,r0	; 0232A972
	ldr r0,[r0,#0x14]	; 0232A974
	bx lr	; 0232A976
pool_0232A978:
loc_0232A978:
	.word P1_BssStart + 0x2630C	; 0232A978

; ===== function loc_0232A97C =====
loc_0232A97C:
	ldr r1,[pool_0232A9C4]	; 0232A97C
	ldr r1,[r1,#0x0]	; 0232A97E
	add r2,r1,#0x0	; 0232A980
	add r2,#0x84	; 0232A982
	ldr r3,[r2,#0x0]	; 0232A984
	ldr r2,[r3,#0x18]	; 0232A986
	cmp r2,#0x0	; 0232A988
	bne loc_0232A990	; 0232A98A
	mov r3,#0x0	; 0232A98C
	b loc_0232A992	; 0232A98E
loc_0232A990:
	add r3,r3,r2	; 0232A990
loc_0232A992:
	cmp r3,#0x0	; 0232A992
	bne loc_0232A99A	; 0232A994
	mov r0,#0x0	; 0232A996
	bx lr	; 0232A998
loc_0232A99A:
	cmp r0,#0x0	; 0232A99A
	bge loc_0232A9A2	; 0232A99C
	mov r0,#0x0	; 0232A99E
	bx lr	; 0232A9A0
loc_0232A9A2:
	ldr r2,[r3,#0x0]	; 0232A9A2
	cmp r0,r2	; 0232A9A4
	bcc loc_0232A9AC	; 0232A9A6
	mov r0,#0x0	; 0232A9A8
	bx lr	; 0232A9AA
loc_0232A9AC:
	lsl r0,r0,#0x2	; 0232A9AC
	add r0,r3,r0	; 0232A9AE
	ldr r2,[r0,#0x4]	; 0232A9B0
	add r1,#0x84	; 0232A9B2
	ldr r0,[r1,#0x0]	; 0232A9B4
	cmp r2,#0x0	; 0232A9B6
	bne loc_0232A9BE	; 0232A9B8
	mov r0,#0x0	; 0232A9BA
	bx lr	; 0232A9BC
loc_0232A9BE:
	add r0,r0,r2	; 0232A9BE
	bx lr	; 0232A9C0
	.byte 0xC0, 0x46	; 0232A9C4
pool_0232A9C4:
loc_0232A9C4:
	.word P1_BssStart + 0x2630C	; 0232A9C4

; ===== function loc_0232A9C8 =====
loc_0232A9C8:
	ldr r1,[pool_0232AA10]	; 0232A9C8
	ldr r1,[r1,#0x0]	; 0232A9CA
	add r2,r1,#0x0	; 0232A9CC
	add r2,#0x84	; 0232A9CE
	ldr r3,[r2,#0x0]	; 0232A9D0
	ldr r2,[r3,#0x14]	; 0232A9D2
	cmp r2,#0x0	; 0232A9D4
	bne loc_0232A9DC	; 0232A9D6
	mov r3,#0x0	; 0232A9D8
	b loc_0232A9DE	; 0232A9DA
loc_0232A9DC:
	add r3,r3,r2	; 0232A9DC
loc_0232A9DE:
	cmp r3,#0x0	; 0232A9DE
	bne loc_0232A9E6	; 0232A9E0
	mov r0,#0x0	; 0232A9E2
	bx lr	; 0232A9E4
loc_0232A9E6:
	cmp r0,#0x0	; 0232A9E6
	bge loc_0232A9EE	; 0232A9E8
	mov r0,#0x0	; 0232A9EA
	bx lr	; 0232A9EC
loc_0232A9EE:
	ldr r2,[r3,#0x0]	; 0232A9EE
	cmp r0,r2	; 0232A9F0
	bcc loc_0232A9F8	; 0232A9F2
	mov r0,#0x0	; 0232A9F4
	bx lr	; 0232A9F6
loc_0232A9F8:
	lsl r0,r0,#0x2	; 0232A9F8
	add r0,r3,r0	; 0232A9FA
	ldr r2,[r0,#0x4]	; 0232A9FC
	add r1,#0x84	; 0232A9FE
	ldr r0,[r1,#0x0]	; 0232AA00
	cmp r2,#0x0	; 0232AA02
	bne loc_0232AA0A	; 0232AA04
	mov r0,#0x0	; 0232AA06
	bx lr	; 0232AA08
loc_0232AA0A:
	add r0,r0,r2	; 0232AA0A
	bx lr	; 0232AA0C
	.byte 0xC0, 0x46	; 0232AA10
pool_0232AA10:
loc_0232AA10:
	.word P1_BssStart + 0x2630C	; 0232AA10

; ===== function loc_0232AA14 =====
loc_0232AA14:
	ldr r1,[pool_0232AA5C]	; 0232AA14
	ldr r1,[r1,#0x0]	; 0232AA16
	add r2,r1,#0x0	; 0232AA18
	add r2,#0x84	; 0232AA1A
	ldr r3,[r2,#0x0]	; 0232AA1C
	ldr r2,[r3,#0x10]	; 0232AA1E
	cmp r2,#0x0	; 0232AA20
	bne loc_0232AA28	; 0232AA22
	mov r3,#0x0	; 0232AA24
	b loc_0232AA2A	; 0232AA26
loc_0232AA28:
	add r3,r3,r2	; 0232AA28
loc_0232AA2A:
	cmp r3,#0x0	; 0232AA2A
	bne loc_0232AA32	; 0232AA2C
	mov r0,#0x0	; 0232AA2E
	bx lr	; 0232AA30
loc_0232AA32:
	cmp r0,#0x0	; 0232AA32
	bge loc_0232AA3A	; 0232AA34
	mov r0,#0x0	; 0232AA36
	bx lr	; 0232AA38
loc_0232AA3A:
	ldr r2,[r3,#0x0]	; 0232AA3A
	cmp r0,r2	; 0232AA3C
	bcc loc_0232AA44	; 0232AA3E
	mov r0,#0x0	; 0232AA40
	bx lr	; 0232AA42
loc_0232AA44:
	lsl r0,r0,#0x2	; 0232AA44
	add r0,r3,r0	; 0232AA46
	ldr r2,[r0,#0x4]	; 0232AA48
	add r1,#0x84	; 0232AA4A
	ldr r0,[r1,#0x0]	; 0232AA4C
	cmp r2,#0x0	; 0232AA4E
	bne loc_0232AA56	; 0232AA50
	mov r0,#0x0	; 0232AA52
	bx lr	; 0232AA54
loc_0232AA56:
	add r0,r0,r2	; 0232AA56
	bx lr	; 0232AA58
	.byte 0xC0, 0x46	; 0232AA5C
pool_0232AA5C:
loc_0232AA5C:
	.word P1_BssStart + 0x2630C	; 0232AA5C

; ===== function loc_0232AA60 =====
loc_0232AA60:
	ldr r1,[pool_0232AAA8]	; 0232AA60
	ldr r1,[r1,#0x0]	; 0232AA62
	add r2,r1,#0x0	; 0232AA64
	add r2,#0x84	; 0232AA66
	ldr r3,[r2,#0x0]	; 0232AA68
	ldr r2,[r3,#0xc]	; 0232AA6A
	cmp r2,#0x0	; 0232AA6C
	bne loc_0232AA74	; 0232AA6E
	mov r3,#0x0	; 0232AA70
	b loc_0232AA76	; 0232AA72
loc_0232AA74:
	add r3,r3,r2	; 0232AA74
loc_0232AA76:
	cmp r3,#0x0	; 0232AA76
	bne loc_0232AA7E	; 0232AA78
	mov r0,#0x0	; 0232AA7A
	bx lr	; 0232AA7C
loc_0232AA7E:
	cmp r0,#0x0	; 0232AA7E
	bge loc_0232AA86	; 0232AA80
	mov r0,#0x0	; 0232AA82
	bx lr	; 0232AA84
loc_0232AA86:
	ldr r2,[r3,#0x0]	; 0232AA86
	cmp r0,r2	; 0232AA88
	bcc loc_0232AA90	; 0232AA8A
	mov r0,#0x0	; 0232AA8C
	bx lr	; 0232AA8E
loc_0232AA90:
	lsl r0,r0,#0x2	; 0232AA90
	add r0,r3,r0	; 0232AA92
	ldr r2,[r0,#0x4]	; 0232AA94
	add r1,#0x84	; 0232AA96
	ldr r0,[r1,#0x0]	; 0232AA98
	cmp r2,#0x0	; 0232AA9A
	bne loc_0232AAA2	; 0232AA9C
	mov r0,#0x0	; 0232AA9E
	bx lr	; 0232AAA0
loc_0232AAA2:
	add r0,r0,r2	; 0232AAA2
	bx lr	; 0232AAA4
	.byte 0xC0, 0x46	; 0232AAA8
pool_0232AAA8:
loc_0232AAA8:
	.word P1_BssStart + 0x2630C	; 0232AAA8

; ===== function loc_0232AAAC =====
loc_0232AAAC:
	ldr r0,[pool_0232AAB4]	; 0232AAAC
	ldr r0,[r0,#0x0]	; 0232AAAE
	bx lr	; 0232AAB0
	.byte 0xC0, 0x46	; 0232AAB4
pool_0232AAB4:
loc_0232AAB4:
	.word P1_BssStart + 0x2630C	; 0232AAB4

; ===== function loc_0232AAB8 =====
loc_0232AAB8:
	push {r4,r5,r6,r7,lr}	; 0232AAB8
	sub sp,#0x4	; 0232AABA
	add r5,r0,#0x0	; 0232AABC
	add r4,r1,#0x0	; 0232AABE
	add r0,r4,#0x0	; 0232AAC0
	add r1,r5,#0x0	; 0232AAC2
	mov r2,#0x30	; 0232AAC4
	blx loc_0232DE60	; 0232AAC6
	ldr r0,[r5,#0x18]	; 0232AACA
	cmp r0,#0x0	; 0232AACC
	bne loc_0232AAD4	; 0232AACE
	mov r1,#0x0	; 0232AAD0
	b loc_0232AAD6	; 0232AAD2
loc_0232AAD4:
	add r1,r4,r0	; 0232AAD4
loc_0232AAD6:
	add r0,r5,#0x0	; 0232AAD6
	add r0,#0x84	; 0232AAD8
	str r1,[r0,#0x0]	; 0232AADA
	ldr r0,[r5,#0x20]	; 0232AADC
	cmp r0,#0x0	; 0232AADE
	bne loc_0232AAE6	; 0232AAE0
	mov r0,#0x0	; 0232AAE2
	b loc_0232AAE8	; 0232AAE4
loc_0232AAE6:
	add r0,r4,r0	; 0232AAE6
loc_0232AAE8:
	str r0,[r5,#0x7c]	; 0232AAE8
	ldr r0,[r5,#0x10]	; 0232AAEA
	cmp r0,#0x0	; 0232AAEC
	bne loc_0232AAF4	; 0232AAEE
	mov r1,#0x0	; 0232AAF0
	b loc_0232AAF6	; 0232AAF2
loc_0232AAF4:
	add r1,r4,r0	; 0232AAF4
loc_0232AAF6:
	add r0,r5,#0x0	; 0232AAF6
	add r0,#0x80	; 0232AAF8
	str r1,[r0,#0x0]	; 0232AAFA
	mov r0,#0x0	; 0232AAFC
	ldr r3,[r5,#0x7c]	; 0232AAFE
	ldr r1,[r3,#0x8]	; 0232AB00
	cmp r1,#0x0	; 0232AB02
	bls loc_0232AB28	; 0232AB04
	add r6,r0,#0x0	; 0232AB06
	add r2,r0,#0x0	; 0232AB08
loc_0232AB0A:
	add r3,#0xc	; 0232AB0A
	add r7,r3,r6	; 0232AB0C
	ldr r1,[r3,r6]	; 0232AB0E
	cmp r1,#0x0	; 0232AB10
	bne loc_0232AB18	; 0232AB12
	add r1,r2,#0x0	; 0232AB14
	b loc_0232AB1A	; 0232AB16
loc_0232AB18:
	add r1,r4,r1	; 0232AB18
loc_0232AB1A:
	str r1,[r7,#0x8]	; 0232AB1A
	add r6,#0x10	; 0232AB1C
	add r0,r0,#0x1	; 0232AB1E
	ldr r3,[r5,#0x7c]	; 0232AB20
	ldr r1,[r3,#0x8]	; 0232AB22
	cmp r0,r1	; 0232AB24
	bcc loc_0232AB0A	; 0232AB26
loc_0232AB28:
	ldr r0,[pool_0232AB34]	; 0232AB28
	str r5,[r0,#0x0]	; 0232AB2A
	add sp,#0x4	; 0232AB2C
	pop {r4,r5,r6,r7}	; 0232AB2E
	pop {r3}	; 0232AB30
	bx r3	; 0232AB32
pool_0232AB34:
loc_0232AB34:
	.word P1_BssStart + 0x2630C	; 0232AB34

; ===== function loc_0232AB38 =====
loc_0232AB38:
	push {r4,lr}	; 0232AB38
	bl loc_0232E318	; 0232AB3A
	add r4,r0,#0x0	; 0232AB3E
	mov r0,#0x1	; 0232AB40
	bl loc_0232E384	; 0232AB42
	add r0,r4,#0x0	; 0232AB46
	bl loc_0232E338	; 0232AB48
	pop {r4}	; 0232AB4C
	pop {r3}	; 0232AB4E
	bx r3	; 0232AB50
	.byte 0x00, 0x00	; 0232AB54

; ===== function loc_0232AB54 =====
loc_0232AB54:
	push {r4,r5,lr}	; 0232AB54
	sub sp,#0x4	; 0232AB56
	add r5,r0,#0x0	; 0232AB58
	ldr r0,[r5,#0x0]	; 0232AB5A
	mov r1,#0x14	; 0232AB5C
	mov r2,#0x4	; 0232AB5E
	bl loc_02329BE0	; 0232AB60
	add r4,r0,#0x0	; 0232AB64
	cmp r4,#0x0	; 0232AB66
	bne loc_0232AB74	; 0232AB68
	mov r0,#0x0	; 0232AB6A
	add sp,#0x4	; 0232AB6C
	pop {r4,r5}	; 0232AB6E
	pop {r3}	; 0232AB70
	bx r3	; 0232AB72
loc_0232AB74:
	bl loc_0232ABBC	; 0232AB74
	add r0,r5,#0x4	; 0232AB78
	add r1,r4,#0x0	; 0232AB7A
	bl loc_02329670	; 0232AB7C
	mov r0,#0x1	; 0232AB80
	add sp,#0x4	; 0232AB82
	pop {r4,r5}	; 0232AB84
	pop {r3}	; 0232AB86
	bx r3	; 0232AB88
	.byte 0x00, 0x00	; 0232AB8C

; ===== function loc_0232AB8C =====
loc_0232AB8C:
	push {r4,r5,lr}	; 0232AB8C
	sub sp,#0x4	; 0232AB8E
	add r5,r0,#0x0	; 0232AB90
	add r4,r1,#0x0	; 0232AB92
	add r0,r5,#0x4	; 0232AB94
	mov r1,#0xc	; 0232AB96
	bl loc_023296C4	; 0232AB98
	str r4,[r5,#0x0]	; 0232AB9C
	add r0,r5,#0x0	; 0232AB9E
	bl loc_0232AB54	; 0232ABA0
	cmp r0,#0x0	; 0232ABA4
	beq loc_0232ABB2	; 0232ABA6
	mov r0,#0x1	; 0232ABA8
	add sp,#0x4	; 0232ABAA
	pop {r4,r5}	; 0232ABAC
	pop {r3}	; 0232ABAE
	bx r3	; 0232ABB0
loc_0232ABB2:
	mov r0,#0x0	; 0232ABB2
	add sp,#0x4	; 0232ABB4
	pop {r4,r5}	; 0232ABB6
	pop {r3}	; 0232ABB8
	bx r3	; 0232ABBA

; ===== function loc_0232ABBC =====
loc_0232ABBC:
	mov r1,#0x0	; 0232ABBC
	ldr r3,[pool_0232ABC4]	; 0232ABBE
	bx r3	; 0232ABC0
	.byte 0xC0, 0x46	; 0232ABC4
pool_0232ABC4:
loc_0232ABC4:
	.word loc_023296C4 + 1	; 0232ABC4

; ===== function loc_0232ABC8 =====
loc_0232ABC8:
	push {r4,r5,r6,r7,lr}	; 0232ABC8
	sub sp,#0x4	; 0232ABCA
	add r5,r0,#0x0	; 0232ABCC
	add r6,r1,#0x0	; 0232ABCE
	add r7,r2,#0x0	; 0232ABD0
	str r3,[sp,#0x0]	; 0232ABD2
	ldr r0,[r5,#0x0]	; 0232ABD4
	add r1,#0x1f	; 0232ABD6
	mov r2,#0x1f	; 0232ABD8
	bic r1,r2	; 0232ABDA
	add r1,#0x20	; 0232ABDC
	mov r2,#0x20	; 0232ABDE
	bl loc_02329BE0	; 0232ABE0
	add r4,r0,#0x0	; 0232ABE4
	cmp r4,#0x0	; 0232ABE6
	bne loc_0232ABF4	; 0232ABE8
	mov r0,#0x0	; 0232ABEA
	add sp,#0x4	; 0232ABEC
	pop {r4,r5,r6,r7}	; 0232ABEE
	pop {r3}	; 0232ABF0
	bx r3	; 0232ABF2
loc_0232ABF4:
	add r0,r5,#0x4	; 0232ABF4
	mov r1,#0x0	; 0232ABF6
	bl loc_02329590	; 0232ABF8
	str r6,[r4,#0x8]	; 0232ABFC
	str r7,[r4,#0xc]	; 0232ABFE
	ldr r1,[sp,#0x0]	; 0232AC00
	str r1,[r4,#0x10]	; 0232AC02
	ldr r1,[sp,#0x18]	; 0232AC04
	str r1,[r4,#0x14]	; 0232AC06
	add r1,r4,#0x0	; 0232AC08
	bl loc_02329670	; 0232AC0A
	add r4,#0x20	; 0232AC0E
	add r0,r4,#0x0	; 0232AC10
	add sp,#0x4	; 0232AC12
	pop {r4,r5,r6,r7}	; 0232AC14
	pop {r3}	; 0232AC16
	bx r3	; 0232AC18
	.byte 0x00, 0x00	; 0232AC1C

; ===== function loc_0232AC1C =====
loc_0232AC1C:
	push {r4,r5,r6,r7,lr}	; 0232AC1C
	sub sp,#0x4	; 0232AC1E
	add r7,r0,#0x0	; 0232AC20
	add r0,r7,#0x4	; 0232AC22
	mov r1,#0x0	; 0232AC24
	bl loc_02329590	; 0232AC26
	add r5,r0,#0x0	; 0232AC2A
	cmp r5,#0x0	; 0232AC2C
	beq loc_0232AC74	; 0232AC2E
loc_0232AC30:
	add r0,r5,#0x0	; 0232AC30
	mov r1,#0x0	; 0232AC32
	bl loc_02329590	; 0232AC34
	add r4,r0,#0x0	; 0232AC38
	cmp r4,#0x0	; 0232AC3A
	beq loc_0232AC5E	; 0232AC3C
loc_0232AC3E:
	ldr r6,[r4,#0xc]	; 0232AC3E
	cmp r6,#0x0	; 0232AC40
	beq loc_0232AC50	; 0232AC42
	add r0,r4,#0x0	; 0232AC44
	add r0,#0x20	; 0232AC46
	ldr r1,[r4,#0x8]	; 0232AC48
	ldr r2,[r4,#0x10]	; 0232AC4A
	ldr r3,[r4,#0x14]	; 0232AC4C
	blx r6	; 0232AC4E
loc_0232AC50:
	add r0,r5,#0x0	; 0232AC50
	add r1,r4,#0x0	; 0232AC52
	bl loc_02329590	; 0232AC54
	add r4,r0,#0x0	; 0232AC58
	cmp r4,#0x0	; 0232AC5A
	bne loc_0232AC3E	; 0232AC5C
loc_0232AC5E:
	add r0,r7,#0x4	; 0232AC5E
	add r1,r5,#0x0	; 0232AC60
	bl loc_023295B0	; 0232AC62
	add r0,r7,#0x4	; 0232AC66
	mov r1,#0x0	; 0232AC68
	bl loc_02329590	; 0232AC6A
	add r5,r0,#0x0	; 0232AC6E
	cmp r5,#0x0	; 0232AC70
	bne loc_0232AC30	; 0232AC72
loc_0232AC74:
	ldr r0,[r7,#0x0]	; 0232AC74
	mov r1,#0x3	; 0232AC76
	bl loc_02329BB4	; 0232AC78
	bl loc_0232AB38	; 0232AC7C
	add r0,r7,#0x0	; 0232AC80
	bl loc_0232AB54	; 0232AC82
	add sp,#0x4	; 0232AC86
	pop {r4,r5,r6,r7}	; 0232AC88
	pop {r3}	; 0232AC8A
	bx r3	; 0232AC8C
	.byte 0x00, 0x00	; 0232AC90

; ===== function loc_0232AC90 =====
loc_0232AC90:
	push {r4,lr}	; 0232AC90
	add r4,r0,#0x0	; 0232AC92
	bl loc_0232AC1C	; 0232AC94
	ldr r0,[r4,#0x0]	; 0232AC98
	bl loc_02329C0C	; 0232AC9A
	pop {r4}	; 0232AC9E
	pop {r3}	; 0232ACA0
	bx r3	; 0232ACA2

; ===== function loc_0232ACA4 =====
loc_0232ACA4:
	push {r4,r5,lr}	; 0232ACA4
	sub sp,#0x4	; 0232ACA6
	add r1,r0,r1	; 0232ACA8
	add r4,r0,#0x3	; 0232ACAA
	mov r0,#0x3	; 0232ACAC
	bic r4,r0	; 0232ACAE
	cmp r4,r1	; 0232ACB0
	bls loc_0232ACBE	; 0232ACB2
	mov r0,#0x0	; 0232ACB4
	add sp,#0x4	; 0232ACB6
	pop {r4,r5}	; 0232ACB8
	pop {r3}	; 0232ACBA
	bx r3	; 0232ACBC
loc_0232ACBE:
	sub r1,r1,r4	; 0232ACBE
	cmp r1,#0x10	; 0232ACC0
	bcs loc_0232ACCE	; 0232ACC2
	mov r0,#0x0	; 0232ACC4
	add sp,#0x4	; 0232ACC6
	pop {r4,r5}	; 0232ACC8
	pop {r3}	; 0232ACCA
	bx r3	; 0232ACCC
loc_0232ACCE:
	add r0,r4,#0x0	; 0232ACCE
	add r0,#0x10	; 0232ACD0
	sub r1,#0x10	; 0232ACD2
	mov r2,#0x0	; 0232ACD4
	bl loc_02329C14	; 0232ACD6
	add r5,r0,#0x0	; 0232ACDA
	cmp r5,#0x0	; 0232ACDC
	bne loc_0232ACEA	; 0232ACDE
	mov r0,#0x0	; 0232ACE0
	add sp,#0x4	; 0232ACE2
	pop {r4,r5}	; 0232ACE4
	pop {r3}	; 0232ACE6
	bx r3	; 0232ACE8
loc_0232ACEA:
	add r0,r4,#0x0	; 0232ACEA
	add r1,r5,#0x0	; 0232ACEC
	bl loc_0232AB8C	; 0232ACEE
	cmp r0,#0x0	; 0232ACF2
	bne loc_0232AD06	; 0232ACF4
	add r0,r5,#0x0	; 0232ACF6
	bl loc_02329C0C	; 0232ACF8
	mov r0,#0x0	; 0232ACFC
	add sp,#0x4	; 0232ACFE
	pop {r4,r5}	; 0232AD00
	pop {r3}	; 0232AD02
	bx r3	; 0232AD04
loc_0232AD06:
	add r0,r4,#0x0	; 0232AD06
	add sp,#0x4	; 0232AD08
	pop {r4,r5}	; 0232AD0A
	pop {r3}	; 0232AD0C
	bx r3	; 0232AD0E

; ===== function loc_0232AD10 =====
loc_0232AD10:
	push {r4,r5,r6,r7,lr}	; 0232AD10
	sub sp,#0xc	; 0232AD12
	str r0,[sp,#0x0]	; 0232AD14
	add r5,r1,#0x0	; 0232AD16
	add r6,r3,#0x0	; 0232AD18
	ldr r7,[sp,#0x20]	; 0232AD1A
	add r0,r2,#0x0	; 0232AD1C
	bl loc_0232AA14	; 0232AD1E
	add r4,r0,#0x0	; 0232AD22
	cmp r4,#0x0	; 0232AD24
	bne loc_0232AD32	; 0232AD26
	mov r0,#0x0	; 0232AD28
	add sp,#0xc	; 0232AD2A
	pop {r4,r5,r6,r7}	; 0232AD2C
	pop {r3}	; 0232AD2E
	bx r3	; 0232AD30
loc_0232AD32:
	ldr r0,[sp,#0x0]	; 0232AD32
	add r1,r5,#0x0	; 0232AD34
	add r2,r6,#0x0	; 0232AD36
	bl loc_0232A134	; 0232AD38
	str r0,[sp,#0x4]	; 0232AD3C
	cmp r0,#0x0	; 0232AD3E
	bne loc_0232AD4C	; 0232AD40
	mov r0,#0x0	; 0232AD42
	add sp,#0xc	; 0232AD44
	pop {r4,r5,r6,r7}	; 0232AD46
	pop {r3}	; 0232AD48
	bx r3	; 0232AD4A
loc_0232AD4C:
	ldr r0,[r4,#0x0]	; 0232AD4C
	bl loc_0232A960	; 0232AD4E
	add r6,r0,#0x0	; 0232AD52
	cmp r6,#0x0	; 0232AD54
	bne loc_0232AD68	; 0232AD56
	ldr r0,[sp,#0x4]	; 0232AD58
	bl loc_0232A12C	; 0232AD5A
	mov r0,#0x0	; 0232AD5E
	add sp,#0xc	; 0232AD60
	pop {r4,r5,r6,r7}	; 0232AD62
	pop {r3}	; 0232AD64
	bx r3	; 0232AD66
loc_0232AD68:
	mov r5,#0x0	; 0232AD68
loc_0232AD6A:
	ldrh r0,[r4,#0x4]	; 0232AD6A
	ldr r1,[pool_0232ADEC]	; 0232AD6C
	cmp r0,r1	; 0232AD6E
	beq loc_0232ADAE	; 0232AD70
	bl loc_0232A9C8	; 0232AD72
	cmp r0,#0x0	; 0232AD76
	bne loc_0232AD8A	; 0232AD78
	ldr r0,[sp,#0x4]	; 0232AD7A
	bl loc_0232A12C	; 0232AD7C
	mov r0,#0x0	; 0232AD80
	add sp,#0xc	; 0232AD82
	pop {r4,r5,r6,r7}	; 0232AD84
	pop {r3}	; 0232AD86
	bx r3	; 0232AD88
loc_0232AD8A:
	ldr r0,[r0,#0x0]	; 0232AD8A
	bl loc_0232A960	; 0232AD8C
	add r2,r0,#0x0	; 0232AD90
	cmp r2,#0x0	; 0232AD92
	bne loc_0232ADA6	; 0232AD94
	ldr r0,[sp,#0x4]	; 0232AD96
	bl loc_0232A12C	; 0232AD98
	mov r0,#0x0	; 0232AD9C
	add sp,#0xc	; 0232AD9E
	pop {r4,r5,r6,r7}	; 0232ADA0
	pop {r3}	; 0232ADA2
	bx r3	; 0232ADA4
loc_0232ADA6:
	add r0,r6,#0x0	; 0232ADA6
	add r1,r5,#0x0	; 0232ADA8
	bl loc_0232E768	; 0232ADAA
loc_0232ADAE:
	add r4,r4,#0x2	; 0232ADAE
	add r5,r5,#0x1	; 0232ADB0
	cmp r5,#0x4	; 0232ADB2
	blt loc_0232AD6A	; 0232ADB4
	ldr r0,[sp,#0x4]	; 0232ADB6
	ldr r2,[sp,#0x24]	; 0232ADB8
	ldr r1,[r2,#0x18]	; 0232ADBA
	add r1,r2,r1	; 0232ADBC
	ldr r2,[r7,#0x0]	; 0232ADBE
	add r3,r6,#0x0	; 0232ADC0
	bl loc_0232A108	; 0232ADC2
	ldr r0,[sp,#0x0]	; 0232ADC6
	ldrb r1,[r7,#0x6]	; 0232ADC8
	bl loc_0232A234	; 0232ADCA
	ldr r0,[sp,#0x0]	; 0232ADCE
	ldrb r1,[r7,#0x7]	; 0232ADD0
	bl loc_0232A1F8	; 0232ADD2
	ldr r0,[sp,#0x0]	; 0232ADD6
	ldr r1,[sp,#0x28]	; 0232ADD8
	ldr r2,[sp,#0x2c]	; 0232ADDA
	bl loc_0232A1AC	; 0232ADDC
	mov r0,#0x1	; 0232ADE0
	add sp,#0xc	; 0232ADE2
	pop {r4,r5,r6,r7}	; 0232ADE4
	pop {r3}	; 0232ADE6
	bx r3	; 0232ADE8
	.byte 0xC0, 0x46	; 0232ADEC
pool_0232ADEC:
loc_0232ADEC:
	.word 0x0000FFFF	; 0232ADEC

; ===== function loc_0232ADF0 =====
	push {r4,r5,r6,r7,lr}	; 0232ADF0
	sub sp,#0x14	; 0232ADF2
	str r0,[sp,#0x10]	; 0232ADF4
	add r5,r1,#0x0	; 0232ADF6
	add r4,r2,#0x0	; 0232ADF8
	add r6,r3,#0x0	; 0232ADFA
	ldr r0,[sp,#0x28]	; 0232ADFC
	bl loc_0232AA60	; 0232ADFE
	cmp r0,#0x0	; 0232AE02
	bne loc_0232AE10	; 0232AE04
	mov r0,#0x0	; 0232AE06
	add sp,#0x14	; 0232AE08
	pop {r4,r5,r6,r7}	; 0232AE0A
	pop {r3}	; 0232AE0C
	bx r3	; 0232AE0E
loc_0232AE10:
	ldr r0,[r0,#0x0]	; 0232AE10
	bl loc_0232A960	; 0232AE12
	add r7,r0,#0x0	; 0232AE16
	cmp r7,#0x0	; 0232AE18
	bne loc_0232AE26	; 0232AE1A
	mov r0,#0x0	; 0232AE1C
	add sp,#0x14	; 0232AE1E
	pop {r4,r5,r6,r7}	; 0232AE20
	pop {r3}	; 0232AE22
	bx r3	; 0232AE24
loc_0232AE26:
	ldr r1,[sp,#0x2c]	; 0232AE26
	bl loc_0232AF38	; 0232AE28
	cmp r0,#0x0	; 0232AE2C
	bne loc_0232AE3A	; 0232AE2E
	mov r0,#0x0	; 0232AE30
	add sp,#0x14	; 0232AE32
	pop {r4,r5,r6,r7}	; 0232AE34
	pop {r3}	; 0232AE36
	bx r3	; 0232AE38
loc_0232AE3A:
	cmp r6,#0x0	; 0232AE3A
	bge loc_0232AE40	; 0232AE3C
	ldrb r6,[r0,#0x8]	; 0232AE3E
loc_0232AE40:
	cmp r4,#0x0	; 0232AE40
	bge loc_0232AE46	; 0232AE42
	ldrh r4,[r0,#0x4]	; 0232AE44
loc_0232AE46:
	cmp r5,#0x0	; 0232AE46
	bge loc_0232AE4C	; 0232AE48
	ldrb r5,[r0,#0x9]	; 0232AE4A
loc_0232AE4C:
	str r0,[sp,#0x0]	; 0232AE4C
	str r7,[sp,#0x4]	; 0232AE4E
	ldr r0,[sp,#0x28]	; 0232AE50
	str r0,[sp,#0x8]	; 0232AE52
	ldr r0,[sp,#0x2c]	; 0232AE54
	str r0,[sp,#0xc]	; 0232AE56
	ldr r0,[sp,#0x10]	; 0232AE58
	add r1,r5,#0x0	; 0232AE5A
	add r2,r4,#0x0	; 0232AE5C
	add r3,r6,#0x0	; 0232AE5E
	bl loc_0232AD10	; 0232AE60
	add sp,#0x14	; 0232AE64
	pop {r4,r5,r6,r7}	; 0232AE66
	pop {r3}	; 0232AE68
	bx r3	; 0232AE6A
loc_0232AE6C:
	push {r4,r5,r6,r7,lr}	; 0232AE6C
	sub sp,#0x14	; 0232AE6E
	add r7,r0,#0x0	; 0232AE70
	add r5,r1,#0x0	; 0232AE72
	add r4,r2,#0x0	; 0232AE74
	add r0,r5,#0x0	; 0232AE76
	bl loc_0232AA60	; 0232AE78
	cmp r0,#0x0	; 0232AE7C
	bne loc_0232AE8A	; 0232AE7E
	mov r0,#0x0	; 0232AE80
	add sp,#0x14	; 0232AE82
	pop {r4,r5,r6,r7}	; 0232AE84
	pop {r3}	; 0232AE86
	bx r3	; 0232AE88
loc_0232AE8A:
	ldr r0,[r0,#0x0]	; 0232AE8A
	bl loc_0232A960	; 0232AE8C
	add r6,r0,#0x0	; 0232AE90
	cmp r6,#0x0	; 0232AE92
	bne loc_0232AEA0	; 0232AE94
	mov r0,#0x0	; 0232AE96
	add sp,#0x14	; 0232AE98
	pop {r4,r5,r6,r7}	; 0232AE9A
	pop {r3}	; 0232AE9C
	bx r3	; 0232AE9E
loc_0232AEA0:
	add r1,r4,#0x0	; 0232AEA0
	bl loc_0232AF38	; 0232AEA2
	add r3,r0,#0x0	; 0232AEA6
	cmp r3,#0x0	; 0232AEA8
	bne loc_0232AEB6	; 0232AEAA
	mov r0,#0x0	; 0232AEAC
	add sp,#0x14	; 0232AEAE
	pop {r4,r5,r6,r7}	; 0232AEB0
	pop {r3}	; 0232AEB2
	bx r3	; 0232AEB4
loc_0232AEB6:
	str r3,[sp,#0x0]	; 0232AEB6
	str r6,[sp,#0x4]	; 0232AEB8
	str r5,[sp,#0x8]	; 0232AEBA
	str r4,[sp,#0xc]	; 0232AEBC
	add r0,r7,#0x0	; 0232AEBE
	ldrb r1,[r3,#0x9]	; 0232AEC0
	ldrh r2,[r3,#0x4]	; 0232AEC2
	ldrb r3,[r3,#0x8]	; 0232AEC4
	bl loc_0232AD10	; 0232AEC6
	add sp,#0x14	; 0232AECA
	pop {r4,r5,r6,r7}	; 0232AECC
	pop {r3}	; 0232AECE
	bx r3	; 0232AED0
	.byte 0x00, 0x00	; 0232AED4

; ===== function loc_0232AED4 =====
loc_0232AED4:
	push {r4,r5,r6,r7,lr}	; 0232AED4
	sub sp,#0x4	; 0232AED6
	add r7,r0,#0x0	; 0232AED8
	bl loc_0232AAAC	; 0232AEDA
	mov r6,#0x0	; 0232AEDE
	str r6,[sp,#0x0]	; 0232AEE0
loc_0232AEE2:
	add r0,r6,#0x0	; 0232AEE2
	bl loc_0232A97C	; 0232AEE4
	add r5,r0,#0x0	; 0232AEE8
	cmp r5,#0x0	; 0232AEEA
	beq loc_0232AF28	; 0232AEEC
	add r0,r6,#0x0	; 0232AEEE
	ldrb r1,[r5,#0x0]	; 0232AEF0
	bl loc_0232A2E0	; 0232AEF2
	ldr r0,[r5,#0x4]	; 0232AEF6
	cmp r0,#0x0	; 0232AEF8
	beq loc_0232AF28	; 0232AEFA
	cmp r7,#0x0	; 0232AEFC
	beq loc_0232AF28	; 0232AEFE
	ldr r4,[sp,#0x0]	; 0232AF00
	ldrb r0,[r5,#0x0]	; 0232AF02
	cmp r0,#0x0	; 0232AF04
	ble loc_0232AF28	; 0232AF06
loc_0232AF08:
	add r0,r6,#0x0	; 0232AF08
	add r1,r7,#0x0	; 0232AF0A
	ldr r2,[r5,#0x4]	; 0232AF0C
	bl loc_0232A274	; 0232AF0E
	cmp r0,#0x0	; 0232AF12
	bne loc_0232AF20	; 0232AF14
	mov r0,#0x0	; 0232AF16
	add sp,#0x4	; 0232AF18
	pop {r4,r5,r6,r7}	; 0232AF1A
	pop {r3}	; 0232AF1C
	bx r3	; 0232AF1E
loc_0232AF20:
	add r4,r4,#0x1	; 0232AF20
	ldrb r0,[r5,#0x0]	; 0232AF22
	cmp r4,r0	; 0232AF24
	blt loc_0232AF08	; 0232AF26
loc_0232AF28:
	add r6,r6,#0x1	; 0232AF28
	cmp r6,#0x20	; 0232AF2A
	blt loc_0232AEE2	; 0232AF2C
	mov r0,#0x1	; 0232AF2E
	add sp,#0x4	; 0232AF30
	pop {r4,r5,r6,r7}	; 0232AF32
	pop {r3}	; 0232AF34
	bx r3	; 0232AF36

; ===== function loc_0232AF38 =====
loc_0232AF38:
	cmp r1,#0x0	; 0232AF38
	bge loc_0232AF40	; 0232AF3A
	mov r0,#0x0	; 0232AF3C
	bx lr	; 0232AF3E
loc_0232AF40:
	ldr r2,[r0,#0x1c]	; 0232AF40
	cmp r1,r2	; 0232AF42
	bcc loc_0232AF4A	; 0232AF44
	mov r0,#0x0	; 0232AF46
	bx lr	; 0232AF48
loc_0232AF4A:
	add r0,#0x20	; 0232AF4A
	mov r2,#0xc	; 0232AF4C
	mul r1,r2	; 0232AF4E
	add r3,r0,r1	; 0232AF50
	ldr r2,[r0,r1]	; 0232AF52
	mov r0,#0x0	; 0232AF54
	mvn r1,r0	; 0232AF56
	cmp r2,r1	; 0232AF58
	bne loc_0232AF5E	; 0232AF5A
	add r3,r0,#0x0	; 0232AF5C
loc_0232AF5E:
	add r0,r3,#0x0	; 0232AF5E
	bx lr	; 0232AF60
	.byte 0x00, 0x00	; 0232AF64

; ===== function loc_0232AF64 =====
loc_0232AF64:
	ldr r1,[r0,#0x8]	; 0232AF64
	ldr r0,[r0,#0xc]	; 0232AF66
	cmp r1,r0	; 0232AF68
	blt loc_0232AF70	; 0232AF6A
	mov r0,#0x1	; 0232AF6C
	bx lr	; 0232AF6E
loc_0232AF70:
	mov r0,#0x0	; 0232AF70
	bx lr	; 0232AF72

; ===== function loc_0232AF74 =====
loc_0232AF74:
	ldr r2,[r0,#0x8]	; 0232AF74
	ldr r1,[r0,#0xc]	; 0232AF76
	cmp r2,r1	; 0232AF78
	bge loc_0232AF80	; 0232AF7A
	add r1,r2,#0x1	; 0232AF7C
	str r1,[r0,#0x8]	; 0232AF7E
loc_0232AF80:
	bx lr	; 0232AF80
	.byte 0x00, 0x00	; 0232AF84

; ===== function loc_0232AF84 =====
loc_0232AF84:
	push {r4,lr}	; 0232AF84
	ldr r1,[r0,#0xc]	; 0232AF86
	ldr r2,[r0,#0x8]	; 0232AF88
	cmp r2,r1	; 0232AF8A
	blt loc_0232AF96	; 0232AF8C
	ldr r0,[r0,#0x4]	; 0232AF8E
	pop {r4}	; 0232AF90
	pop {r3}	; 0232AF92
	bx r3	; 0232AF94
loc_0232AF96:
	ldr r4,[r0,#0x0]	; 0232AF96
	ldr r0,[r0,#0x4]	; 0232AF98
	sub r0,r0,r4	; 0232AF9A
	mul r2,r0	; 0232AF9C
	add r0,r2,#0x0	; 0232AF9E
	blx P1_SignedDivMod	; 0232AFA0
	add r0,r4,r0	; 0232AFA4
	pop {r4}	; 0232AFA6
	pop {r3}	; 0232AFA8
	bx r3	; 0232AFAA

; ===== function loc_0232AFAC =====
loc_0232AFAC:
	push {r4,r5,r6,lr}	; 0232AFAC
	add r5,r0,#0x0	; 0232AFAE
	add r4,r1,#0x0	; 0232AFB0
	add r6,r2,#0x0	; 0232AFB2
	bl loc_0232AF84	; 0232AFB4
	str r0,[r5,#0x0]	; 0232AFB8
	str r4,[r5,#0x4]	; 0232AFBA
	str r6,[r5,#0xc]	; 0232AFBC
	mov r0,#0x0	; 0232AFBE
	str r0,[r5,#0x8]	; 0232AFC0
	pop {r4,r5,r6}	; 0232AFC2
	pop {r3}	; 0232AFC4
	bx r3	; 0232AFC6

; ===== function loc_0232AFC8 =====
loc_0232AFC8:
	mov r2,#0x0	; 0232AFC8
	str r2,[r0,#0x4]	; 0232AFCA
	ldr r1,[r0,#0x4]	; 0232AFCC
	str r1,[r0,#0x0]	; 0232AFCE
	str r2,[r0,#0xc]	; 0232AFD0
	ldr r1,[r0,#0xc]	; 0232AFD2
	str r1,[r0,#0x8]	; 0232AFD4
	bx lr	; 0232AFD6
.arm

; ===== function loc_0232AFD8 =====
loc_0232AFD8:
	stmdb sp!,{r4,r5,r6,lr}	; 0232AFD8
	mov r5,r0	; 0232AFDC
	mov r4,r1	; 0232AFE0
	bl P1_Arm9DisableIrqReturnPriorMask	; 0232AFE4
	cmp r5,#0x0	; 0232AFE8
	beq loc_0232B008	; 0232AFEC
	ldr r1,[pool_0232B04C]	; 0232AFF0
	mvn r2,r4	; 0232AFF4
	add r1,r1,#0x3000	; 0232AFF8
	ldr r3,[r1,#0xff8]	; 0232AFFC
	and r2,r3,r2	; 0232B000
	str r2,[r1,#0xff8]	; 0232B004
loc_0232B008:
	bl P1_Arm9RestoreIrqMask	; 0232B008
	ldr r1,[pool_0232B04C]	; 0232B00C
	add r0,r1,#0x3000	; 0232B010
	ldr r0,[r0,#0xff8]	; 0232B014
	ands r0,r4,r0	; 0232B018
	ldmneia sp!,{r4,r5,r6,lr}	; 0232B01C
	bxne lr	; 0232B020
	ldr r0,[pool_0232B050]	; 0232B024
	add r6,r1,r0	; 0232B028
	ldr r5,[pool_0232B054]	; 0232B02C
loc_0232B030:
	mov r0,r5	; 0232B030
	blx loc_0232B698	; 0232B034
	ldr r0,[r6,#0x0]	; 0232B038
	ands r0,r4,r0	; 0232B03C
	beq loc_0232B030	; 0232B040
	ldmia sp!,{r4,r5,r6,lr}	; 0232B044
	bx lr	; 0232B048
pool_0232B04C:
loc_0232B04C:
	.word P1_DtcmRuntimeStart	; 0232B04C
pool_0232B050:
loc_0232B050:
	.word 0x00003FF8	; 0232B050
pool_0232B054:
loc_0232B054:
	.word 0x03000000	; 0232B054
.thumb
P1_IrqHandler_0232B058:
	mov r0,#0x7	; 0232B058
	ldr r3,[pool_0232B060]	; 0232B05A
	bx r3	; 0232B05C
	.byte 0xC0, 0x46	; 0232B060
pool_0232B060:
loc_0232B060:
	.word loc_0232B0B8 + 1	; 0232B060
P1_IrqHandler_0232B064:
	mov r0,#0x6	; 0232B064
	ldr r3,[pool_0232B06C]	; 0232B066
	bx r3	; 0232B068
	.byte 0xC0, 0x46	; 0232B06C
pool_0232B06C:
loc_0232B06C:
	.word loc_0232B0B8 + 1	; 0232B06C
P1_IrqHandler_0232B070:
	mov r0,#0x5	; 0232B070
	ldr r3,[pool_0232B078]	; 0232B072
	bx r3	; 0232B074
	.byte 0xC0, 0x46	; 0232B078
pool_0232B078:
loc_0232B078:
	.word loc_0232B0B8 + 1	; 0232B078
P1_IrqHandler_0232B07C:
	mov r0,#0x4	; 0232B07C
	ldr r3,[pool_0232B084]	; 0232B07E
	bx r3	; 0232B080
	.byte 0xC0, 0x46	; 0232B084
pool_0232B084:
loc_0232B084:
	.word loc_0232B0B8 + 1	; 0232B084
P1_IrqHandler_0232B088:
	mov r0,#0x3	; 0232B088
	ldr r3,[pool_0232B090]	; 0232B08A
	bx r3	; 0232B08C
	.byte 0xC0, 0x46	; 0232B090
pool_0232B090:
loc_0232B090:
	.word loc_0232B0B8 + 1	; 0232B090
P1_IrqHandler_0232B094:
	mov r0,#0x2	; 0232B094
	ldr r3,[pool_0232B09C]	; 0232B096
	bx r3	; 0232B098
	.byte 0xC0, 0x46	; 0232B09C
pool_0232B09C:
loc_0232B09C:
	.word loc_0232B0B8 + 1	; 0232B09C
P1_IrqHandler_0232B0A0:
	mov r0,#0x1	; 0232B0A0
	ldr r3,[pool_0232B0A8]	; 0232B0A2
	bx r3	; 0232B0A4
	.byte 0xC0, 0x46	; 0232B0A8
pool_0232B0A8:
loc_0232B0A8:
	.word loc_0232B0B8 + 1	; 0232B0A8
P1_IrqHandler_0232B0AC:
	mov r0,#0x0	; 0232B0AC
	ldr r3,[pool_0232B0B4]	; 0232B0AE
	bx r3	; 0232B0B0
	.byte 0xC0, 0x46	; 0232B0B4
pool_0232B0B4:
loc_0232B0B4:
	.word loc_0232B0B8 + 1	; 0232B0B4
loc_0232B0B8:
	push {r4,r5,lr}	; 0232B0B8
	sub sp,#0x4	; 0232B0BA
	mov r5,#0x1	; 0232B0BC
	lsl r2,r0,#0x1	; 0232B0BE
	ldr r1,[pool_0232B100]	; 0232B0C0
	ldrh r1,[r1,r2]	; 0232B0C2
	lsl r5,r1	; 0232B0C4
	mov r1,#0xc	; 0232B0C6
	add r4,r0,#0x0	; 0232B0C8
	mul r4,r1	; 0232B0CA
	ldr r2,[pool_0232B104]	; 0232B0CC
	ldr r1,[r2,r4]	; 0232B0CE
	mov r0,#0x0	; 0232B0D0
	str r0,[r2,r4]	; 0232B0D2
	cmp r1,#0x0	; 0232B0D4
	beq loc_0232B0DE	; 0232B0D6
	ldr r0,[pool_0232B108]	; 0232B0D8
	ldr r0,[r0,r4]	; 0232B0DA
	blx r1	; 0232B0DC
loc_0232B0DE:
	ldr r1,[pool_0232B10C]	; 0232B0DE
	ldr r0,[pool_0232B110]	; 0232B0E0
	add r0,r1,r0	; 0232B0E2
	ldr r1,[r0,#0x0]	; 0232B0E4
	orr r1,r5	; 0232B0E6
	str r1,[r0,#0x0]	; 0232B0E8
	ldr r0,[pool_0232B114]	; 0232B0EA
	ldr r0,[r0,r4]	; 0232B0EC
	cmp r0,#0x0	; 0232B0EE
	bne loc_0232B0F8	; 0232B0F0
	add r0,r5,#0x0	; 0232B0F2
	bl loc_0232B144	; 0232B0F4
loc_0232B0F8:
	add sp,#0x4	; 0232B0F8
	pop {r4,r5}	; 0232B0FA
	pop {r3}	; 0232B0FC
	bx r3	; 0232B0FE
pool_0232B100:
loc_0232B100:
	.word P1_Data_023309F0	; 0232B100
pool_0232B104:
loc_0232B104:
	.word P1_BssStart + 0x26310	; 0232B104
pool_0232B108:
loc_0232B108:
	.word P1_BssStart + 0x26318	; 0232B108
pool_0232B10C:
loc_0232B10C:
	.word 0x03000000	; 0232B10C
pool_0232B110:
loc_0232B110:
	.word 0x00003FF8	; 0232B110
pool_0232B114:
loc_0232B114:
	.word P1_BssStart + 0x26314	; 0232B114
P1_IrqHandler_0232B118:
	bx lr	; 0232B118
	.byte 0x00, 0x00	; 0232B11C

; ===== function loc_0232B11C =====
loc_0232B11C:
	push {r4}	; 0232B11C
	sub sp,#0x4	; 0232B11E
	ldr r4,[pool_0232B13C]	; 0232B120
	ldrh r3,[r4,#0x0]	; 0232B122
	mov r1,#0x0	; 0232B124
	strh r1,[r4,#0x0]	; 0232B126
	ldr r2,[pool_0232B140]	; 0232B128
	ldr r1,[r2,#0x0]	; 0232B12A
	str r0,[r2,#0x0]	; 0232B12C
	ldrh r0,[r4,#0x0]	; 0232B12E
	strh r3,[r4,#0x0]	; 0232B130
	add r0,r1,#0x0	; 0232B132
	add sp,#0x4	; 0232B134
	pop {r4}	; 0232B136
	bx lr	; 0232B138
	.byte 0xC0, 0x46	; 0232B13C
pool_0232B13C:
loc_0232B13C:
	.word REG_IME	; 0232B13C
pool_0232B140:
loc_0232B140:
	.word REG_IF	; 0232B140

; ===== function loc_0232B144 =====
loc_0232B144:
	push {r4,r5}	; 0232B144
	ldr r5,[pool_0232B164]	; 0232B146
	ldrh r4,[r5,#0x0]	; 0232B148
	mov r1,#0x0	; 0232B14A
	strh r1,[r5,#0x0]	; 0232B14C
	ldr r3,[pool_0232B168]	; 0232B14E
	ldr r2,[r3,#0x0]	; 0232B150
	add r1,r2,#0x0	; 0232B152
	bic r1,r0	; 0232B154
	str r1,[r3,#0x0]	; 0232B156
	ldrh r0,[r5,#0x0]	; 0232B158
	strh r4,[r5,#0x0]	; 0232B15A
	add r0,r2,#0x0	; 0232B15C
	pop {r4,r5}	; 0232B15E
	bx lr	; 0232B160
	.byte 0xC0, 0x46	; 0232B164
pool_0232B164:
loc_0232B164:
	.word REG_IME	; 0232B164
pool_0232B168:
loc_0232B168:
	.word REG_IE	; 0232B168

; ===== function loc_0232B16C =====
loc_0232B16C:
	push {r4,r5}	; 0232B16C
	ldr r5,[pool_0232B18C]	; 0232B16E
	ldrh r4,[r5,#0x0]	; 0232B170
	mov r1,#0x0	; 0232B172
	strh r1,[r5,#0x0]	; 0232B174
	ldr r3,[pool_0232B190]	; 0232B176
	ldr r2,[r3,#0x0]	; 0232B178
	add r1,r2,#0x0	; 0232B17A
	orr r1,r0	; 0232B17C
	str r1,[r3,#0x0]	; 0232B17E
	ldrh r0,[r5,#0x0]	; 0232B180
	strh r4,[r5,#0x0]	; 0232B182
	add r0,r2,#0x0	; 0232B184
	pop {r4,r5}	; 0232B186
	bx lr	; 0232B188
	.byte 0xC0, 0x46	; 0232B18C
pool_0232B18C:
loc_0232B18C:
	.word REG_IME	; 0232B18C
pool_0232B190:
loc_0232B190:
	.word REG_IE	; 0232B190

; ===== function loc_0232B194 =====
loc_0232B194:
	push {r4}	; 0232B194
	sub sp,#0x4	; 0232B196
	ldr r4,[pool_0232B1B4]	; 0232B198
	ldrh r3,[r4,#0x0]	; 0232B19A
	mov r1,#0x0	; 0232B19C
	strh r1,[r4,#0x0]	; 0232B19E
	ldr r2,[pool_0232B1B8]	; 0232B1A0
	ldr r1,[r2,#0x0]	; 0232B1A2
	str r0,[r2,#0x0]	; 0232B1A4
	ldrh r0,[r4,#0x0]	; 0232B1A6
	strh r3,[r4,#0x0]	; 0232B1A8
	add r0,r1,#0x0	; 0232B1AA
	add sp,#0x4	; 0232B1AC
	pop {r4}	; 0232B1AE
	bx lr	; 0232B1B0
	.byte 0xC0, 0x46	; 0232B1B4
pool_0232B1B4:
loc_0232B1B4:
	.word REG_IME	; 0232B1B4
pool_0232B1B8:
loc_0232B1B8:
	.word REG_IE	; 0232B1B8

; ===== function loc_0232B1BC =====
loc_0232B1BC:
	push {r4,lr}	; 0232B1BC
	mov r3,#0xc	; 0232B1BE
	add r4,r0,#0x0	; 0232B1C0
	mul r4,r3	; 0232B1C2
	ldr r3,[pool_0232B1E4]	; 0232B1C4
	str r1,[r3,r4]	; 0232B1C6
	ldr r1,[pool_0232B1E8]	; 0232B1C8
	str r2,[r1,r4]	; 0232B1CA
	mov r1,#0x1	; 0232B1CC
	add r0,r0,#0x3	; 0232B1CE
	lsl r1,r0	; 0232B1D0
	add r0,r1,#0x0	; 0232B1D2
	bl loc_0232B16C	; 0232B1D4
	mov r1,#0x1	; 0232B1D8
	ldr r0,[pool_0232B1EC]	; 0232B1DA
	str r1,[r0,r4]	; 0232B1DC
	pop {r4}	; 0232B1DE
	pop {r3}	; 0232B1E0
	bx r3	; 0232B1E2
pool_0232B1E4:
loc_0232B1E4:
	.word P1_BssStart + 0x26340	; 0232B1E4
pool_0232B1E8:
loc_0232B1E8:
	.word P1_BssStart + 0x26348	; 0232B1E8
pool_0232B1EC:
loc_0232B1EC:
	.word P1_BssStart + 0x26344	; 0232B1EC

; ===== function loc_0232B1F0 =====
loc_0232B1F0:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P1_SetIrqHandlers
	push {r4,r5,r6,r7}	; 0232B1F0
	mov r6,#0x0	; 0232B1F2
	ldr r5,[pool_0232B24C]	; 0232B1F4
	add r4,r6,#0x0	; 0232B1F6
	add r2,r6,#0x0	; 0232B1F8
loc_0232B1FA:
	add r7,r0,#0x0	; 0232B1FA
	mov r3,#0x1	; 0232B1FC
	and r7,r3	; 0232B1FE
	cmp r7,#0x0	; 0232B200
	beq loc_0232B23E	; 0232B202
	add r7,r4,#0x0	; 0232B204
	cmp r6,#0x8	; 0232B206
	blt loc_0232B21C	; 0232B208
	cmp r6,#0xb	; 0232B20A
	bgt loc_0232B21C	; 0232B20C
	add r3,r6,#0x0	; 0232B20E
	sub r3,#0x8	; 0232B210
	mov r7,#0xc	; 0232B212
	mul r3,r7	; 0232B214
	ldr r7,[pool_0232B250]	; 0232B216
	add r7,r7,r3	; 0232B218
	b loc_0232B232	; 0232B21A
loc_0232B21C:
	cmp r6,#0x3	; 0232B21C
	blt loc_0232B230	; 0232B21E
	cmp r6,#0x6	; 0232B220
	bgt loc_0232B230	; 0232B222
	add r3,r6,#0x1	; 0232B224
	mov r7,#0xc	; 0232B226
	mul r3,r7	; 0232B228
	ldr r7,[pool_0232B250]	; 0232B22A
	add r7,r7,r3	; 0232B22C
	b loc_0232B232	; 0232B22E
loc_0232B230:
	str r1,[r5,#0x0]	; 0232B230
loc_0232B232:
	cmp r7,#0x0	; 0232B232
	beq loc_0232B23E	; 0232B234
	str r1,[r7,#0x0]	; 0232B236
	str r2,[r7,#0x8]	; 0232B238
	mov r3,#0x1	; 0232B23A
	str r3,[r7,#0x4]	; 0232B23C
loc_0232B23E:
	lsr r0,r0,#0x1	; 0232B23E
	add r5,r5,#0x4	; 0232B240
	add r6,r6,#0x1	; 0232B242
	cmp r6,#0x16	; 0232B244
	blt loc_0232B1FA	; 0232B246
	pop {r4,r5,r6,r7}	; 0232B248
	bx lr	; 0232B24A
.endfunc
pool_0232B24C:
loc_0232B24C:
	.word P1_IrqHandlers	; 0232B24C
pool_0232B250:
loc_0232B250:
	.word 0x02356D90	; 0232B250

; ===== function loc_0232B254 =====
loc_0232B254:
	mov r1,#0x0	; 0232B254
	ldr r0,[pool_0232B25C]	; 0232B256
	strh r1,[r0,#0x0]	; 0232B258
	bx lr	; 0232B25A
pool_0232B25C:
loc_0232B25C:
	.word P1_DtcmRuntimeStart	; 0232B25C

; ===== function loc_0232B260 =====
loc_0232B260:
	ldr r1,[pool_0232B264]	; 0232B260
	bx r1	; 0232B262
pool_0232B264:
loc_0232B264:
	.word loc_0232B3AC + 1	; 0232B264

; ===== function loc_0232B268 =====
loc_0232B268:
	ldr r1,[pool_0232B26C]	; 0232B268
	bx r1	; 0232B26A
pool_0232B26C:
loc_0232B26C:
	.word loc_0232B348 + 1	; 0232B26C
.arm

; ===== function loc_0232B270 =====
loc_0232B270:
	ldr r3,[pool_0232B2C0]	; 0232B270
	ldr r1,[r3,#0x0]	; 0232B274
	clz r2,r1	; 0232B278
	cmp r2,#0x20	; 0232B27C
	movne r0,#0x40	; 0232B280
	bne loc_0232B2A4	; 0232B284
	add r3,r3,#0x4	; 0232B288
	ldr r1,[r3,#0x0]	; 0232B28C
	clz r2,r1	; 0232B290
	cmp r2,#0x20	; 0232B294
	ldr r0,[pool_0232B2C4]	; 0232B298
	bxeq lr	; 0232B29C
	mov r0,#0x60	; 0232B2A0
loc_0232B2A4:
	add r0,r0,r2	; 0232B2A4
	mov r1,#0x80000000	; 0232B2A8
	mov r1,r1, lsr r2	; 0232B2AC
	ldr r2,[r3,#0x0]	; 0232B2B0
	bic r2,r2,r1	; 0232B2B4
	str r2,[r3,#0x0]	; 0232B2B8
	bx lr	; 0232B2BC
pool_0232B2C0:
loc_0232B2C0:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B2C0
pool_0232B2C4:
loc_0232B2C4:
	.word 0xFFFFFFFD	; 0232B2C4

; ===== function loc_0232B2C8 =====
loc_0232B2C8:
	ldr r3,[pool_0232B2F4]	; 0232B2C8
	cmp r0,#0x60	; 0232B2CC
	addpl r3,r3,#0x4	; 0232B2D0
	subpl r0,r0,#0x60	; 0232B2D4
	submi r0,r0,#0x40	; 0232B2D8
	mov r1,#0x80000000	; 0232B2DC
	mov r1,r1, lsr r0	; 0232B2E0
	ldr r2,[r3,#0x0]	; 0232B2E4
	orr r2,r2,r1	; 0232B2E8
	str r2,[r3,#0x0]	; 0232B2EC
	bx lr	; 0232B2F0
pool_0232B2F4:
loc_0232B2F4:
	.word 0x027FFFB0	; 0232B2F4
.thumb

; ===== function loc_0232B2F8 =====
loc_0232B2F8:
	ldr r0,[pool_0232B300]	; 0232B2F8
	ldr r3,[pool_0232B304]	; 0232B2FA
	bx r3	; 0232B2FC
	.byte 0xC0, 0x46	; 0232B300
pool_0232B300:
loc_0232B300:
	.word 0x00001000	; 0232B300
pool_0232B304:
loc_0232B304:
	.word P1_Arm9BusyWaitByLoop4	; 0232B304

; ===== function loc_0232B308 =====
loc_0232B308:
	ldrh r0,[r0,#0x4]	; 0232B308
	bx lr	; 0232B30A
	ldr r1,[pool_0232B318]	; 0232B30C
	ldrh r2,[r1,#0x0]	; 0232B30E
	ldr r0,[pool_0232B31C]	; 0232B310
	orr r2,r0	; 0232B312
	strh r2,[r1,#0x0]	; 0232B314
	bx lr	; 0232B316
pool_0232B318:
loc_0232B318:
	.word REG_EXMEMCNT_ARM9	; 0232B318
pool_0232B31C:
loc_0232B31C:
	.word 0x00000800	; 0232B31C
	ldr r1,[pool_0232B32C]	; 0232B320
	ldrh r2,[r1,#0x0]	; 0232B322
	ldr r0,[pool_0232B330]	; 0232B324
	and r2,r0	; 0232B326
	strh r2,[r1,#0x0]	; 0232B328
	bx lr	; 0232B32A
pool_0232B32C:
loc_0232B32C:
	.word REG_EXMEMCNT_ARM9	; 0232B32C
pool_0232B330:
loc_0232B330:
	.word 0xFFFFF7FF	; 0232B330

; ===== function loc_0232B334 =====
loc_0232B334:
	ldr r1,[pool_0232B33C]	; 0232B334
	ldr r2,[pool_0232B340]	; 0232B336
	ldr r3,[pool_0232B344]	; 0232B338
	bx r3	; 0232B33A
pool_0232B33C:
loc_0232B33C:
	.word 0x027FFFE0	; 0232B33C
pool_0232B340:
loc_0232B340:
	.word 0x0232B321	; 0232B340
pool_0232B344:
loc_0232B344:
	.word loc_0232B3E4 + 1	; 0232B344

; ===== function loc_0232B348 =====
loc_0232B348:
	ldr r1,[pool_0232B350]	; 0232B348
	ldr r2,[pool_0232B354]	; 0232B34A
	ldr r3,[pool_0232B358]	; 0232B34C
	bx r3	; 0232B34E
pool_0232B350:
loc_0232B350:
	.word 0x027FFFE0	; 0232B350
pool_0232B354:
loc_0232B354:
	.word 0x0232B30D	; 0232B354
pool_0232B358:
loc_0232B358:
	.word loc_0232B454 + 1	; 0232B358

; ===== function loc_0232B35C =====
loc_0232B35C:
	ldr r1,[pool_0232B364]	; 0232B35C
	ldr r2,[pool_0232B368]	; 0232B35E
	ldr r3,[pool_0232B36C]	; 0232B360
	bx r3	; 0232B362
pool_0232B364:
loc_0232B364:
	.word 0x027FFFE0	; 0232B364
pool_0232B368:
loc_0232B368:
	.word 0x0232B321	; 0232B368
pool_0232B36C:
loc_0232B36C:
	.word loc_0232B4BC + 1	; 0232B36C
	ldr r1,[pool_0232B37C]	; 0232B370
	ldrh r2,[r1,#0x0]	; 0232B372
	mov r0,#0x80	; 0232B374
	orr r2,r0	; 0232B376
	strh r2,[r1,#0x0]	; 0232B378
	bx lr	; 0232B37A
pool_0232B37C:
loc_0232B37C:
	.word REG_EXMEMCNT_ARM9	; 0232B37C
	ldr r1,[pool_0232B38C]	; 0232B380
	ldrh r2,[r1,#0x0]	; 0232B382
	mov r0,#0x80	; 0232B384
	bic r2,r0	; 0232B386
	strh r2,[r1,#0x0]	; 0232B388
	bx lr	; 0232B38A
pool_0232B38C:
loc_0232B38C:
	.word REG_EXMEMCNT_ARM9	; 0232B38C

; ===== function loc_0232B390 =====
loc_0232B390:
	push {lr}	; 0232B390
	sub sp,#0x4	; 0232B392
	ldr r1,[pool_0232B3A4]	; 0232B394
	ldr r2,[pool_0232B3A8]	; 0232B396
	mov r3,#0x1	; 0232B398
	bl loc_0232B3F4	; 0232B39A
	add sp,#0x4	; 0232B39E
	pop {r3}	; 0232B3A0
	bx r3	; 0232B3A2
pool_0232B3A4:
loc_0232B3A4:
	.word 0x027FFFE8	; 0232B3A4
pool_0232B3A8:
loc_0232B3A8:
	.word 0x0232B381	; 0232B3A8

; ===== function loc_0232B3AC =====
loc_0232B3AC:
	push {lr}	; 0232B3AC
	sub sp,#0x4	; 0232B3AE
	ldr r1,[pool_0232B3C0]	; 0232B3B0
	ldr r2,[pool_0232B3C4]	; 0232B3B2
	mov r3,#0x1	; 0232B3B4
	bl loc_0232B464	; 0232B3B6
	add sp,#0x4	; 0232B3BA
	pop {r3}	; 0232B3BC
	bx r3	; 0232B3BE
pool_0232B3C0:
loc_0232B3C0:
	.word 0x027FFFE8	; 0232B3C0
pool_0232B3C4:
loc_0232B3C4:
	.word 0x0232B371	; 0232B3C4

; ===== function loc_0232B3C8 =====
loc_0232B3C8:
	push {lr}	; 0232B3C8
	sub sp,#0x4	; 0232B3CA
	ldr r1,[pool_0232B3DC]	; 0232B3CC
	ldr r2,[pool_0232B3E0]	; 0232B3CE
	mov r3,#0x1	; 0232B3D0
	bl loc_0232B4CC	; 0232B3D2
	add sp,#0x4	; 0232B3D6
	pop {r3}	; 0232B3D8
	bx r3	; 0232B3DA
pool_0232B3DC:
loc_0232B3DC:
	.word 0x027FFFE8	; 0232B3DC
pool_0232B3E0:
loc_0232B3E0:
	.word 0x0232B381	; 0232B3E0
loc_0232B3E4:
	push {lr}	; 0232B3E4
	sub sp,#0x4	; 0232B3E6
	mov r3,#0x0	; 0232B3E8
	bl loc_0232B3F4	; 0232B3EA
	add sp,#0x4	; 0232B3EE
	pop {r3}	; 0232B3F0
	bx r3	; 0232B3F2

; ===== function loc_0232B3F4 =====
loc_0232B3F4:
	push {r4,r5,r6,r7,lr}	; 0232B3F4
	sub sp,#0xc	; 0232B3F6
	add r5,r0,#0x0	; 0232B3F8
	add r6,r1,#0x0	; 0232B3FA
	add r4,r2,#0x0	; 0232B3FC
	add r7,r3,#0x0	; 0232B3FE
	cmp r7,#0x0	; 0232B400
	beq loc_0232B40C	; 0232B402
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B404
	str r0,[sp,#0x0]	; 0232B408
	b loc_0232B412	; 0232B40A
loc_0232B40C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B40C
	str r0,[sp,#0x0]	; 0232B410
loc_0232B412:
	add r0,r5,#0x0	; 0232B412
	add r1,r6,#0x0	; 0232B414
	blx loc_0232DF30	; 0232B416
	str r0,[sp,#0x4]	; 0232B41A
	cmp r0,#0x0	; 0232B41C
	bne loc_0232B428	; 0232B41E
	cmp r4,#0x0	; 0232B420
	beq loc_0232B426	; 0232B422
	blx r4	; 0232B424
loc_0232B426:
	strh r5,[r6,#0x4]	; 0232B426
loc_0232B428:
	cmp r7,#0x0	; 0232B428
	beq loc_0232B434	; 0232B42A
	ldr r0,[sp,#0x0]	; 0232B42C
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B42E
	b loc_0232B43A	; 0232B432
loc_0232B434:
	ldr r0,[sp,#0x0]	; 0232B434
	blx P1_Arm9RestoreIrqMask	; 0232B436
loc_0232B43A:
	ldr r0,[sp,#0x4]	; 0232B43A
	add sp,#0xc	; 0232B43C
	pop {r4,r5,r6,r7}	; 0232B43E
	pop {r3}	; 0232B440
	bx r3	; 0232B442

; ===== function loc_0232B444 =====
loc_0232B444:
	push {lr}	; 0232B444
	sub sp,#0x4	; 0232B446
	mov r3,#0x0	; 0232B448
	bl loc_0232B464	; 0232B44A
	add sp,#0x4	; 0232B44E
	pop {r3}	; 0232B450
	bx r3	; 0232B452

; ===== function loc_0232B454 =====
loc_0232B454:
	push {lr}	; 0232B454
	sub sp,#0x4	; 0232B456
	mov r3,#0x0	; 0232B458
	bl loc_0232B464	; 0232B45A
	add sp,#0x4	; 0232B45E
	pop {r3}	; 0232B460
	bx r3	; 0232B462

; ===== function loc_0232B464 =====
loc_0232B464:
	push {r4,r5,r6,r7,lr}	; 0232B464
	sub sp,#0x4	; 0232B466
	add r5,r1,#0x0	; 0232B468
	add r4,r2,#0x0	; 0232B46A
	add r6,r3,#0x0	; 0232B46C
	ldrh r1,[r5,#0x4]	; 0232B46E
	cmp r0,r1	; 0232B470
	beq loc_0232B480	; 0232B472
	mov r0,#0x1	; 0232B474
	mvn r0,r0	; 0232B476
	add sp,#0x4	; 0232B478
	pop {r4,r5,r6,r7}	; 0232B47A
	pop {r3}	; 0232B47C
	bx r3	; 0232B47E
loc_0232B480:
	cmp r6,#0x0	; 0232B480
	beq loc_0232B48C	; 0232B482
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B484
	add r7,r0,#0x0	; 0232B488
	b loc_0232B492	; 0232B48A
loc_0232B48C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B48C
	add r7,r0,#0x0	; 0232B490
loc_0232B492:
	mov r0,#0x0	; 0232B492
	strh r0,[r5,#0x4]	; 0232B494
	cmp r4,#0x0	; 0232B496
	beq loc_0232B49C	; 0232B498
	blx r4	; 0232B49A
loc_0232B49C:
	mov r0,#0x0	; 0232B49C
	str r0,[r5,#0x0]	; 0232B49E
	cmp r6,#0x0	; 0232B4A0
	beq loc_0232B4AC	; 0232B4A2
	add r0,r7,#0x0	; 0232B4A4
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B4A6
	b loc_0232B4B2	; 0232B4AA
loc_0232B4AC:
	add r0,r7,#0x0	; 0232B4AC
	blx P1_Arm9RestoreIrqMask	; 0232B4AE
loc_0232B4B2:
	mov r0,#0x0	; 0232B4B2
	add sp,#0x4	; 0232B4B4
	pop {r4,r5,r6,r7}	; 0232B4B6
	pop {r3}	; 0232B4B8
	bx r3	; 0232B4BA

; ===== function loc_0232B4BC =====
loc_0232B4BC:
	push {lr}	; 0232B4BC
	sub sp,#0x4	; 0232B4BE
	mov r3,#0x0	; 0232B4C0
	bl loc_0232B4CC	; 0232B4C2
	add sp,#0x4	; 0232B4C6
	pop {r3}	; 0232B4C8
	bx r3	; 0232B4CA

; ===== function loc_0232B4CC =====
loc_0232B4CC:
	push {r4,r5,r6,r7,lr}	; 0232B4CC
	sub sp,#0x4	; 0232B4CE
	add r5,r0,#0x0	; 0232B4D0
	add r4,r1,#0x0	; 0232B4D2
	add r6,r2,#0x0	; 0232B4D4
	add r7,r3,#0x0	; 0232B4D6
	bl loc_0232B3F4	; 0232B4D8
	cmp r0,#0x0	; 0232B4DC
	ble loc_0232B4F4	; 0232B4DE
loc_0232B4E0:
	bl loc_0232B2F8	; 0232B4E0
	add r0,r5,#0x0	; 0232B4E4
	add r1,r4,#0x0	; 0232B4E6
	add r2,r6,#0x0	; 0232B4E8
	add r3,r7,#0x0	; 0232B4EA
	bl loc_0232B3F4	; 0232B4EC
	cmp r0,#0x0	; 0232B4F0
	bgt loc_0232B4E0	; 0232B4F2
loc_0232B4F4:
	add sp,#0x4	; 0232B4F4
	pop {r4,r5,r6,r7}	; 0232B4F6
	pop {r3}	; 0232B4F8
	bx r3	; 0232B4FA

; ===== function loc_0232B4FC =====
loc_0232B4FC:
	push {r4,lr}	; 0232B4FC
	sub sp,#0x8	; 0232B4FE
	ldr r0,[pool_0232B574]	; 0232B500
	ldr r1,[r0,#0x0]	; 0232B502
	cmp r1,#0x0	; 0232B504
	bne loc_0232B56A	; 0232B506
	mov r1,#0x1	; 0232B508
	str r1,[r0,#0x0]	; 0232B50A
	mov r2,#0x0	; 0232B50C
	ldr r1,[pool_0232B578]	; 0232B50E
	str r2,[r1,#0x0]	; 0232B510
	mov r0,#0x7e	; 0232B512
	bl loc_0232B4BC	; 0232B514
	ldr r4,[pool_0232B578]	; 0232B518
	ldrh r0,[r4,#0x6]	; 0232B51A
	cmp r0,#0x0	; 0232B51C
	beq loc_0232B52A	; 0232B51E
loc_0232B520:
	bl loc_0232B2F8	; 0232B520
	ldrh r0,[r4,#0x6]	; 0232B524
	cmp r0,#0x0	; 0232B526
	bne loc_0232B520	; 0232B528
loc_0232B52A:
	mov r0,#0x0	; 0232B52A
	mvn r2,r0	; 0232B52C
	ldr r1,[pool_0232B57C]	; 0232B52E
	str r2,[r1,#0x0]	; 0232B530
	ldr r2,[pool_0232B580]	; 0232B532
	ldr r1,[pool_0232B584]	; 0232B534
	str r2,[r1,#0x0]	; 0232B536
	str r0,[sp,#0x0]	; 0232B538
	ldr r0,[sp,#0x0]	; 0232B53A
	ldr r1,[pool_0232B588]	; 0232B53C
	mov r2,#0x28	; 0232B53E
	blx loc_0232DE4C	; 0232B540
	ldr r2,[pool_0232B58C]	; 0232B544
	ldrh r1,[r2,#0x0]	; 0232B546
	ldr r0,[pool_0232B590]	; 0232B548
	orr r1,r0	; 0232B54A
	strh r1,[r2,#0x0]	; 0232B54C
	ldrh r1,[r2,#0x0]	; 0232B54E
	mov r0,#0x80	; 0232B550
	orr r1,r0	; 0232B552
	strh r1,[r2,#0x0]	; 0232B554
	mov r0,#0x7e	; 0232B556
	ldr r1,[pool_0232B578]	; 0232B558
	mov r2,#0x0	; 0232B55A
	bl loc_0232B454	; 0232B55C
	mov r0,#0x7f	; 0232B560
	ldr r1,[pool_0232B578]	; 0232B562
	mov r2,#0x0	; 0232B564
	bl loc_0232B4BC	; 0232B566
loc_0232B56A:
	add sp,#0x8	; 0232B56A
	pop {r4}	; 0232B56C
	pop {r3}	; 0232B56E
	bx r3	; 0232B570
	.byte 0xC0, 0x46	; 0232B574
pool_0232B574:
loc_0232B574:
	.word P1_BssStart + 0x26370	; 0232B574
pool_0232B578:
loc_0232B578:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 0232B578
pool_0232B57C:
loc_0232B57C:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B57C
pool_0232B580:
loc_0232B580:
	.word 0xFFFF0000	; 0232B580
pool_0232B584:
loc_0232B584:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset + 0x4	; 0232B584
pool_0232B588:
loc_0232B588:
	.word 0x027FFFC0	; 0232B588
pool_0232B58C:
loc_0232B58C:
	.word REG_EXMEMCNT_ARM9	; 0232B58C
pool_0232B590:
loc_0232B590:
	.word 0x00000800	; 0232B590

; ===== function loc_0232B594 =====
P1_ThreadEntry_0232B594:
	push {lr}	; 0232B594
	sub sp,#0x4	; 0232B596
	blx P1_Arm9EnableIrqReturnPriorMask	; 0232B598
loc_0232B59C:
	blx P1_Arm9WaitForInterrupt	; 0232B59C
	b loc_0232B59C	; 0232B5A0
	.byte 0x00, 0x00	; 0232B5A4

; ===== function loc_0232B5A4 =====
loc_0232B5A4:
	push {r4,r5,lr}	; 0232B5A4
	sub sp,#0x4	; 0232B5A6
	add r5,r0,#0x0	; 0232B5A8
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B5AA
	ldr r1,[pool_0232B5C4]	; 0232B5AE
	ldr r4,[r1,#0x10]	; 0232B5B0
	str r5,[r1,#0x10]	; 0232B5B2
	blx P1_Arm9RestoreIrqMask	; 0232B5B4
	add r0,r4,#0x0	; 0232B5B8
	add sp,#0x4	; 0232B5BA
	pop {r4,r5}	; 0232B5BC
	pop {r3}	; 0232B5BE
	bx r3	; 0232B5C0
	.byte 0xC0, 0x46	; 0232B5C4
pool_0232B5C4:
loc_0232B5C4:
	.word P1_BssStart + 0x26380	; 0232B5C4

; ===== function loc_0232B5C8 =====
loc_0232B5C8:
	push {r4,r5,r6,lr}	; 0232B5C8
	ldr r6,[pool_0232B62C]	; 0232B5CA
	ldrh r0,[r6,#0x4]	; 0232B5CC
	cmp r0,#0x0	; 0232B5CE
	bne loc_0232B5DA	; 0232B5D0
	blx P1_Arm9GetProcessorMode	; 0232B5D2
	cmp r0,#0x12	; 0232B5D6
	bne loc_0232B5E4	; 0232B5D8
loc_0232B5DA:
	mov r0,#0x1	; 0232B5DA
	strh r0,[r6,#0x0]	; 0232B5DC
	pop {r4,r5,r6}	; 0232B5DE
	pop {r3}	; 0232B5E0
	bx r3	; 0232B5E2
loc_0232B5E4:
	ldr r0,[pool_0232B630]	; 0232B5E4
	ldr r0,[r0,#0x0]	; 0232B5E6
	ldr r5,[r0,#0x0]	; 0232B5E8
	bl loc_0232B638	; 0232B5EA
	add r4,r0,#0x0	; 0232B5EE
	cmp r5,r4	; 0232B5F0
	beq loc_0232B626	; 0232B5F2
	cmp r4,#0x0	; 0232B5F4
	beq loc_0232B626	; 0232B5F6
	add r0,r5,#0x0	; 0232B5F8
	blx P1_SaveThreadContext	; 0232B5FA
	cmp r0,#0x0	; 0232B5FE
	bne loc_0232B626	; 0232B600
	ldr r0,[pool_0232B634]	; 0232B602
	ldr r2,[r0,#0x0]	; 0232B604
	cmp r2,#0x0	; 0232B606
	beq loc_0232B610	; 0232B608
	add r0,r5,#0x0	; 0232B60A
	add r1,r4,#0x0	; 0232B60C
	blx r2	; 0232B60E
loc_0232B610:
	ldr r2,[r6,#0x10]	; 0232B610
	cmp r2,#0x0	; 0232B612
	beq loc_0232B61C	; 0232B614
	add r0,r5,#0x0	; 0232B616
	add r1,r4,#0x0	; 0232B618
	blx r2	; 0232B61A
loc_0232B61C:
	ldr r0,[pool_0232B62C]	; 0232B61C
	str r4,[r0,#0x8]	; 0232B61E
	add r0,r4,#0x0	; 0232B620
	blx P1_LoadThreadContext	; 0232B622
loc_0232B626:
	pop {r4,r5,r6}	; 0232B626
	pop {r3}	; 0232B628
	bx r3	; 0232B62A
pool_0232B62C:
loc_0232B62C:
	.word P1_BssStart + 0x26380	; 0232B62C
pool_0232B630:
loc_0232B630:
	.word P1_BssStart + 0x26378	; 0232B630
pool_0232B634:
loc_0232B634:
	.word P1_BssStart + 0x26374	; 0232B634

; ===== function loc_0232B638 =====
loc_0232B638:
	ldr r0,[pool_0232B64C]	; 0232B638
	ldr r0,[r0,#0xc]	; 0232B63A
	b loc_0232B640	; 0232B63C
loc_0232B63E:
	ldr r0,[r0,#0x68]	; 0232B63E
loc_0232B640:
	cmp r0,#0x0	; 0232B640
	beq loc_0232B64A	; 0232B642
	ldr r1,[r0,#0x64]	; 0232B644
	cmp r1,#0x1	; 0232B646
	bne loc_0232B63E	; 0232B648
loc_0232B64A:
	bx lr	; 0232B64A
pool_0232B64C:
loc_0232B64C:
	.word P1_BssStart + 0x26380	; 0232B64C

; ===== function loc_0232B650 =====
loc_0232B650:
	push {r4,r5,r6,lr}	; 0232B650
	add r5,r0,#0x0	; 0232B652
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B654
	add r4,r0,#0x0	; 0232B658
	ldrh r1,[r5,#0x0]	; 0232B65A
	cmp r1,#0x0	; 0232B65C
	beq loc_0232B688	; 0232B65E
	ldr r0,[pool_0232B694]	; 0232B660
	ldr r0,[r0,#0xc]	; 0232B662
	cmp r0,#0x0	; 0232B664
	beq loc_0232B680	; 0232B666
	mov r3,#0x1	; 0232B668
loc_0232B66A:
	ldr r2,[r0,#0x6c]	; 0232B66A
	add r6,r3,#0x0	; 0232B66C
	lsl r6,r2	; 0232B66E
	add r2,r1,#0x0	; 0232B670
	and r2,r6	; 0232B672
	cmp r2,#0x0	; 0232B674
	beq loc_0232B67A	; 0232B676
	str r3,[r0,#0x64]	; 0232B678
loc_0232B67A:
	ldr r0,[r0,#0x68]	; 0232B67A
	cmp r0,#0x0	; 0232B67C
	bne loc_0232B66A	; 0232B67E
loc_0232B680:
	mov r0,#0x0	; 0232B680
	strh r0,[r5,#0x0]	; 0232B682
	bl loc_0232B5C8	; 0232B684
loc_0232B688:
	add r0,r4,#0x0	; 0232B688
	blx P1_Arm9RestoreIrqMask	; 0232B68A
	pop {r4,r5,r6}	; 0232B68E
	pop {r3}	; 0232B690
	bx r3	; 0232B692
pool_0232B694:
loc_0232B694:
	.word P1_BssStart + 0x26380	; 0232B694

; ===== function loc_0232B698 =====
loc_0232B698:
	push {r4,r5,lr}	; 0232B698
	sub sp,#0x4	; 0232B69A
	add r5,r0,#0x0	; 0232B69C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B69E
	add r4,r0,#0x0	; 0232B6A2
	ldr r0,[pool_0232B6D4]	; 0232B6A4
	ldr r0,[r0,#0x0]	; 0232B6A6
	ldr r1,[r0,#0x0]	; 0232B6A8
	cmp r5,#0x0	; 0232B6AA
	beq loc_0232B6BE	; 0232B6AC
	ldrh r0,[r5,#0x0]	; 0232B6AE
	mov r3,#0x1	; 0232B6B0
	ldr r2,[r1,#0x6c]	; 0232B6B2
	lsl r3,r2	; 0232B6B4
	lsl r2,r3,#0x10	; 0232B6B6
	lsr r2,r2,#0x10	; 0232B6B8
	orr r0,r2	; 0232B6BA
	strh r0,[r5,#0x0]	; 0232B6BC
loc_0232B6BE:
	mov r0,#0x0	; 0232B6BE
	str r0,[r1,#0x64]	; 0232B6C0
	bl loc_0232B5C8	; 0232B6C2
	add r0,r4,#0x0	; 0232B6C6
	blx P1_Arm9RestoreIrqMask	; 0232B6C8
	add sp,#0x4	; 0232B6CC
	pop {r4,r5}	; 0232B6CE
	pop {r3}	; 0232B6D0
	bx r3	; 0232B6D2
pool_0232B6D4:
loc_0232B6D4:
	.word P1_BssStart + 0x26378	; 0232B6D4
; 线程初始 LR 指向此处；清除 ID 表项并将线程标记为终止态。
; Initial thread LR points here; clear its ID slot and mark the thread terminated.
.func P1_ExitThread
	push {r4,lr}	; 0232B6D8
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B6DA
	ldr r0,[pool_0232B710]	; 0232B6DE
	ldr r0,[r0,#0x0]	; 0232B6E0
	ldr r4,[r0,#0x0]	; 0232B6E2
	add r0,r4,#0x0	; 0232B6E4
	bl loc_0232BB58	; 0232B6E6
	add r0,r4,#0x0	; 0232B6EA
	bl loc_0232B8C0	; 0232B6EC
	mov r2,#0x0	; 0232B6F0
	ldr r0,[r4,#0x6c]	; 0232B6F2
	lsl r1,r0,#0x2	; 0232B6F4
	ldr r0,[pool_0232B714]	; 0232B6F6
	str r2,[r0,r1]	; 0232B6F8
	mov r0,#0x2	; 0232B6FA
	str r0,[r4,#0x64]	; 0232B6FC
	add r4,#0x90	; 0232B6FE
	add r0,r4,#0x0	; 0232B700
	bl loc_0232B650	; 0232B702
	bl loc_0232B5C8	; 0232B706
	pop {r4}	; 0232B70A
	pop {r3}	; 0232B70C
	bx r3	; 0232B70E
.endfunc
pool_0232B710:
loc_0232B710:
	.word P1_BssStart + 0x26378	; 0232B710
pool_0232B714:
loc_0232B714:
	.word P1_BssStart + 0x26394	; 0232B714

; ===== function loc_0232B718 =====
loc_0232B718:
; r0=线程，r1=入口，r2=参数，r3=栈顶；栈参数为大小/优先级。
; r0=thread, r1=entry, r2=argument, r3=stack top; stack arguments: size/priority.
.func P1_CreateThread
	push {r4,r5,r6,r7,lr}	; 0232B718
	sub sp,#0xc	; 0232B71A
	add r5,r0,#0x0	; 0232B71C
	str r1,[sp,#0x0]	; 0232B71E
	add r7,r2,#0x0	; 0232B720
	add r4,r3,#0x0	; 0232B722
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B724
	str r0,[sp,#0x4]	; 0232B728
	bl loc_0232B924	; 0232B72A
	cmp r0,#0x0	; 0232B72E
	bge loc_0232B740	; 0232B730
	ldr r0,[sp,#0x4]	; 0232B732
	blx P1_Arm9RestoreIrqMask	; 0232B734
	add sp,#0xc	; 0232B738
	pop {r4,r5,r6,r7}	; 0232B73A
	pop {r3}	; 0232B73C
	bx r3	; 0232B73E
loc_0232B740:
	ldr r1,[sp,#0x24]	; 0232B740
	str r1,[r5,#0x70]	; 0232B742
	str r0,[r5,#0x6c]	; 0232B744
	mov r1,#0x0	; 0232B746
	str r1,[r5,#0x64]	; 0232B748
	lsl r1,r0,#0x2	; 0232B74A
	ldr r0,[pool_0232B7BC]	; 0232B74C
	str r5,[r0,r1]	; 0232B74E
	add r0,r5,#0x0	; 0232B750
	bl loc_0232B8EC	; 0232B752
	add r0,r5,#0x0	; 0232B756
	add r0,#0x88	; 0232B758
	str r4,[r0,#0x0]	; 0232B75A
	ldr r0,[sp,#0x20]	; 0232B75C
	sub r6,r4,r0	; 0232B75E
	add r0,r5,#0x0	; 0232B760
	add r0,#0x84	; 0232B762
	str r6,[r0,#0x0]	; 0232B764
	mov r1,#0x0	; 0232B766
	add r0,r5,#0x0	; 0232B768
	add r0,#0x8c	; 0232B76A
	str r1,[r0,#0x0]	; 0232B76C
	ldr r0,[pool_0232B7C0]	; 0232B76E
	add r1,r5,#0x0	; 0232B770
	add r1,#0x88	; 0232B772
	ldr r1,[r1,#0x0]	; 0232B774
	sub r1,r1,#0x4	; 0232B776
	str r0,[r1,#0x0]	; 0232B778
	ldr r1,[pool_0232B7C4]	; 0232B77A
	add r0,r5,#0x0	; 0232B77C
	add r0,#0x84	; 0232B77E
	ldr r0,[r0,#0x0]	; 0232B780
	str r1,[r0,#0x0]	; 0232B782
	add r0,r5,#0x0	; 0232B784
	ldr r1,[sp,#0x0]	; 0232B786
	sub r2,r4,#0x4	; 0232B788
	blx P1_InitThreadContext	; 0232B78A
	str r7,[r5,#ThreadContextR0Offset]	; 0232B78E
	ldr r0,[pool_0232B7C8]	; 0232B790
	str r0,[r5,#ThreadContextLrOffset]	; 0232B792
	mov r0,#0x0	; 0232B794
	str r0,[sp,#0x8]	; 0232B796
	ldr r0,[sp,#0x8]	; 0232B798
	add r1,r6,#0x4	; 0232B79A
	ldr r2,[sp,#0x20]	; 0232B79C
	sub r2,#0x8	; 0232B79E
	blx loc_0232DE4C	; 0232B7A0
	mov r0,#0x0	; 0232B7A4
	str r0,[r5,#0x78]	; 0232B7A6
	str r0,[r5,#0x7c]	; 0232B7A8
	add r5,#0x80	; 0232B7AA
	str r0,[r5,#0x0]	; 0232B7AC
	ldr r0,[sp,#0x4]	; 0232B7AE
	blx P1_Arm9RestoreIrqMask	; 0232B7B0
	add sp,#0xc	; 0232B7B4
	pop {r4,r5,r6,r7}	; 0232B7B6
	pop {r3}	; 0232B7B8
	bx r3	; 0232B7BA
.endfunc
pool_0232B7BC:
loc_0232B7BC:
	.word P1_BssStart + 0x26394	; 0232B7BC
pool_0232B7C0:
loc_0232B7C0:
	.word 0xFDDB597D	; 0232B7C0
pool_0232B7C4:
loc_0232B7C4:
	.word 0x7BF9DD5B	; 0232B7C4
pool_0232B7C8:
loc_0232B7C8:
	.word P1_ExitThread + 1	; 0232B7C8

; ===== function loc_0232B7CC =====
loc_0232B7CC:
	push {lr}	; 0232B7CC
	sub sp,#0xc	; 0232B7CE
	ldr r0,[pool_0232B87C]	; 0232B7D0
	ldr r1,[r0,#0x0]	; 0232B7D2
	cmp r1,#0x0	; 0232B7D4
	bne loc_0232B874	; 0232B7D6
	mov r1,#0x1	; 0232B7D8
	str r1,[r0,#0x0]	; 0232B7DA
	mov r1,#0x0	; 0232B7DC
	ldr r0,[pool_0232B880]	; 0232B7DE
	add r2,r1,#0x0	; 0232B7E0
loc_0232B7E2:
	str r2,[r0,#0x14]	; 0232B7E2
	add r0,r0,#0x4	; 0232B7E4
	add r1,r1,#0x1	; 0232B7E6
	cmp r1,#0x10	; 0232B7E8
	blt loc_0232B7E2	; 0232B7EA
	ldr r1,[pool_0232B884]	; 0232B7EC
	ldr r0,[pool_0232B888]	; 0232B7EE
	str r1,[r0,#0x0]	; 0232B7F0
	mov r0,#0x10	; 0232B7F2
	ldr r1,[pool_0232B88C]	; 0232B7F4
	str r0,[r1,#0x70]	; 0232B7F6
	str r2,[r1,#0x6c]	; 0232B7F8
	mov r0,#0x1	; 0232B7FA
	str r0,[r1,#0x64]	; 0232B7FC
	str r2,[r1,#0x68]	; 0232B7FE
	str r2,[r1,#0x74]	; 0232B800
	ldr r0,[pool_0232B880]	; 0232B802
	str r1,[r0,#0x14]	; 0232B804
	str r1,[r0,#0xc]	; 0232B806
	str r1,[r0,#0x8]	; 0232B808
	ldr r2,[pool_0232B890]	; 0232B80A
	cmp r2,#0x0	; 0232B80C
	bne loc_0232B816	; 0232B80E
	ldr r0,[pool_0232B894]	; 0232B810
	sub r3,r0,r2	; 0232B812
	b loc_0232B822	; 0232B814
loc_0232B816:
	ldr r1,[pool_0232B898]	; 0232B816
	ldr r0,[pool_0232B89C]	; 0232B818
	add r1,r1,r0	; 0232B81A
	ldr r0,[pool_0232B8A0]	; 0232B81C
	sub r0,r1,r0	; 0232B81E
	sub r3,r0,r2	; 0232B820
loc_0232B822:
	ldr r1,[pool_0232B898]	; 0232B822
	ldr r0,[pool_0232B89C]	; 0232B824
	add r1,r1,r0	; 0232B826
	ldr r0,[pool_0232B8A0]	; 0232B828
	sub r1,r1,r0	; 0232B82A
	ldr r2,[pool_0232B8A4]	; 0232B82C
	str r1,[r2,#0x8]	; 0232B82E
	str r3,[r2,#0x4]	; 0232B830
	mov r0,#0x0	; 0232B832
	str r0,[r2,#0xc]	; 0232B834
	ldr r3,[pool_0232B8A8]	; 0232B836
	sub r1,r1,#0x4	; 0232B838
	str r3,[r1,#0x0]	; 0232B83A
	ldr r3,[pool_0232B8AC]	; 0232B83C
	ldr r1,[r2,#0x4]	; 0232B83E
	str r3,[r1,#0x0]	; 0232B840
	strh r0,[r2,#0x10]	; 0232B842
	mov r2,#0x10	; 0232B844
	ldr r1,[pool_0232B880]	; 0232B846
	strh r2,[r1,#0x2]	; 0232B848
	strh r0,[r1,#0x0]	; 0232B84A
	strh r0,[r1,#0x4]	; 0232B84C
	ldr r2,[pool_0232B8B0]	; 0232B84E
	str r1,[r2,#0x0]	; 0232B850
	bl loc_0232B5A4	; 0232B852
	mov r0,#0xc8	; 0232B856
	str r0,[sp,#0x0]	; 0232B858
	mov r0,#0x1f	; 0232B85A
	str r0,[sp,#0x4]	; 0232B85C
	ldr r0,[pool_0232B8B4]	; 0232B85E
	ldr r1,[pool_0232B8B8]	; 0232B860
	mov r2,#0x0	; 0232B862
	ldr r3,[pool_0232B8BC]	; 0232B864
	bl P1_CreateThread	; 0232B866
	mov r1,#0x20	; 0232B86A
	ldr r0,[pool_0232B8B4]	; 0232B86C
	str r1,[r0,#0x70]	; 0232B86E
	mov r1,#0x1	; 0232B870
	str r1,[r0,#0x64]	; 0232B872
loc_0232B874:
	add sp,#0xc	; 0232B874
	pop {r3}	; 0232B876
	bx r3	; 0232B878
	.byte 0xC0, 0x46	; 0232B87C
pool_0232B87C:
loc_0232B87C:
	.word P1_BssStart + 0x2637C	; 0232B87C
pool_0232B880:
loc_0232B880:
	.word P1_BssStart + 0x26380	; 0232B880
pool_0232B884:
loc_0232B884:
	.word 0x02356E08	; 0232B884
pool_0232B888:
loc_0232B888:
	.word P1_BssStart + 0x26378	; 0232B888
pool_0232B88C:
loc_0232B88C:
	.word P1_BssStart + 0x26468	; 0232B88C
pool_0232B890:
loc_0232B890:
	.word 0x00000000	; 0232B890
pool_0232B894:
loc_0232B894:
	.word 0x03000020	; 0232B894
pool_0232B898:
loc_0232B898:
	.word 0x03000000	; 0232B898
pool_0232B89C:
loc_0232B89C:
	.word 0x00003FC0	; 0232B89C
pool_0232B8A0:
loc_0232B8A0:
	.word 0x00001000	; 0232B8A0
pool_0232B8A4:
loc_0232B8A4:
	.word P1_BssStart + 0x264E8	; 0232B8A4
pool_0232B8A8:
loc_0232B8A8:
	.word 0xFDDB597D	; 0232B8A8
pool_0232B8AC:
loc_0232B8AC:
	.word 0x7BF9DD5B	; 0232B8AC
pool_0232B8B0:
loc_0232B8B0:
	.word FirmwareSystemWorkAddress + SystemWorkArm9ThreadInfoOffset	; 0232B8B0
pool_0232B8B4:
loc_0232B8B4:
	.word P1_BssStart + 0x263D4	; 0232B8B4
pool_0232B8B8:
loc_0232B8B8:
	.word P1_ThreadEntry_0232B594 + 1	; 0232B8B8
pool_0232B8BC:
loc_0232B8BC:
	.word 0x02357044	; 0232B8BC

; ===== function loc_0232B8C0 =====
loc_0232B8C0:
	ldr r1,[pool_0232B8E8]	; 0232B8C0
	ldr r2,[r1,#0xc]	; 0232B8C2
	mov r1,#0x0	; 0232B8C4
	b loc_0232B8CC	; 0232B8C6
loc_0232B8C8:
	add r1,r2,#0x0	; 0232B8C8
	ldr r2,[r2,#0x68]	; 0232B8CA
loc_0232B8CC:
	cmp r2,#0x0	; 0232B8CC
	beq loc_0232B8D4	; 0232B8CE
	cmp r2,r0	; 0232B8D0
	bne loc_0232B8C8	; 0232B8D2
loc_0232B8D4:
	cmp r1,#0x0	; 0232B8D4
	bne loc_0232B8E0	; 0232B8D6
	ldr r1,[r0,#0x68]	; 0232B8D8
	ldr r0,[pool_0232B8E8]	; 0232B8DA
	str r1,[r0,#0xc]	; 0232B8DC
	bx lr	; 0232B8DE
loc_0232B8E0:
	ldr r0,[r0,#0x68]	; 0232B8E0
	str r0,[r1,#0x68]	; 0232B8E2
	bx lr	; 0232B8E4
	.byte 0xC0, 0x46	; 0232B8E8
pool_0232B8E8:
loc_0232B8E8:
	.word P1_BssStart + 0x26380	; 0232B8E8

; ===== function loc_0232B8EC =====
loc_0232B8EC:
	push {r4,r5}	; 0232B8EC
	ldr r1,[pool_0232B920]	; 0232B8EE
	ldr r3,[r1,#0xc]	; 0232B8F0
	add r5,r3,#0x0	; 0232B8F2
	mov r4,#0x0	; 0232B8F4
	b loc_0232B8FC	; 0232B8F6
loc_0232B8F8:
	add r4,r5,#0x0	; 0232B8F8
	ldr r5,[r5,#0x68]	; 0232B8FA
loc_0232B8FC:
	cmp r5,#0x0	; 0232B8FC
	beq loc_0232B908	; 0232B8FE
	ldr r2,[r5,#0x70]	; 0232B900
	ldr r1,[r0,#0x70]	; 0232B902
	cmp r2,r1	; 0232B904
	bcc loc_0232B8F8	; 0232B906
loc_0232B908:
	cmp r4,#0x0	; 0232B908
	bne loc_0232B916	; 0232B90A
	str r3,[r0,#0x68]	; 0232B90C
	ldr r1,[pool_0232B920]	; 0232B90E
	str r0,[r1,#0xc]	; 0232B910
	pop {r4,r5}	; 0232B912
	bx lr	; 0232B914
loc_0232B916:
	ldr r1,[r4,#0x68]	; 0232B916
	str r1,[r0,#0x68]	; 0232B918
	str r0,[r4,#0x68]	; 0232B91A
	pop {r4,r5}	; 0232B91C
	bx lr	; 0232B91E
pool_0232B920:
loc_0232B920:
	.word P1_BssStart + 0x26380	; 0232B920

; ===== function loc_0232B924 =====
loc_0232B924:
	mov r0,#0x0	; 0232B924
	ldr r2,[pool_0232B93C]	; 0232B926
loc_0232B928:
	ldr r1,[r2,#0x14]	; 0232B928
	cmp r1,#0x0	; 0232B92A
	beq loc_0232B93A	; 0232B92C
	add r2,r2,#0x4	; 0232B92E
	add r0,r0,#0x1	; 0232B930
	cmp r0,#0x10	; 0232B932
	blt loc_0232B928	; 0232B934
	mov r0,#0x0	; 0232B936
	mvn r0,r0	; 0232B938
loc_0232B93A:
	bx lr	; 0232B93A
pool_0232B93C:
loc_0232B93C:
	.word P1_BssStart + 0x26380	; 0232B93C
.arm

; ===== function loc_0232B940 =====
loc_0232B940:
; r0=上下文，r1=入口，r2=栈顶；保存入口+4/状态，并留出 SVC 栈。
; r0=context, r1=entry, r2=stack top; save entry+4/state and reserve the SVC stack.
.func P1_InitThreadContext
	add r1,r1,#0x4	; 0232B940
	str r1,[r0,#ThreadContextPcPlus4Offset]	; 0232B944
	str r2,[r0,#ThreadContextSvcSpOffset]	; 0232B948
	sub r2,r2,#ThreadContextSvcStackBytes	; 0232B94C
	str r2,[r0,#ThreadContextSpOffset]	; 0232B950
	ands r1,r1,#0x1	; 0232B954
	movne r1,#0x3f	; 0232B958
	moveq r1,#0x1f	; 0232B95C
	str r1,[r0,#ThreadContextCpsrOffset]	; 0232B960
	mov r1,#0x0	; 0232B964
	str r1,[r0,#ThreadContextR0Offset]	; 0232B968
	str r1,[r0,#0x8]	; 0232B96C
	str r1,[r0,#0xc]	; 0232B970
	str r1,[r0,#0x10]	; 0232B974
	str r1,[r0,#0x14]	; 0232B978
	str r1,[r0,#0x18]	; 0232B97C
	str r1,[r0,#0x1c]	; 0232B980
	str r1,[r0,#0x20]	; 0232B984
	str r1,[r0,#0x24]	; 0232B988
	str r1,[r0,#0x28]	; 0232B98C
	str r1,[r0,#0x2c]	; 0232B990
	str r1,[r0,#0x30]	; 0232B994
	str r1,[r0,#0x34]	; 0232B998
	str r1,[r0,#ThreadContextLrOffset]	; 0232B99C
	bx lr	; 0232B9A0
.endfunc

; ===== function loc_0232B9A4 =====
loc_0232B9A4:
; 保存寄存器及状态；首次返回 0，恢复后从同一返回点返回 1。
; Save registers/state; return 0 now and 1 from the same return point after restoration.
.func P1_SaveThreadContext
	stmdb sp!,{r0,lr}	; 0232B9A4
	add r0,r0,#ThreadContextArithmeticOffset	; 0232B9A8
	ldr r1,[pool_0232B9EC]	; 0232B9AC
	blx r1	; 0232B9B0
	ldmia sp!,{r0,lr}	; 0232B9B4
	add r1,r0,#0x0	; 0232B9B8
	mrs r2,cpsr	; 0232B9BC
	str r2,[r1],#0x4	; 0232B9C0
	mov r0,#0xd3	; 0232B9C4
	msr cpsr_c,r0	; 0232B9C8
	str sp,[r1,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 0232B9CC
	msr cpsr_c,r2	; 0232B9D0
	mov r0,#0x1	; 0232B9D4
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 0232B9D8
	adr r0,P1_SaveThreadContextReturn + 4	; 0232B9DC
	str r0,[r1,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 0232B9E0
	mov r0,#0x0	; 0232B9E4
P1_SaveThreadContextReturn:
	bx lr	; 0232B9E8
.endfunc
pool_0232B9EC:
loc_0232B9EC:
	.word P1_SaveArithmeticContext + 1	; 0232B9EC

; ===== function loc_0232B9F0 =====
loc_0232B9F0:
; 以 SVC 模式恢复状态和用户寄存器，再用已存 PC+4 恢复执行。
; Restore saved state/user registers in SVC mode, then resume via the saved PC+4.
.func P1_LoadThreadContext
	stmdb sp!,{r0,lr}	; 0232B9F0
	add r0,r0,#ThreadContextArithmeticOffset	; 0232B9F4
	ldr r1,[pool_0232BA30]	; 0232B9F8
	blx r1	; 0232B9FC
	ldmia sp!,{r0,lr}	; 0232BA00
	mrs r1,cpsr	; 0232BA04
	bic r1,r1,#0x1f	; 0232BA08
	orr r1,r1,#0xd3	; 0232BA0C
	msr cpsr_c,r1	; 0232BA10
	ldr r1,[r0],#0x4	; 0232BA14
	msr spsr_cxsf,r1	; 0232BA18
	ldr sp,[r0,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 0232BA1C
	ldr lr,[r0,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 0232BA20
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 0232BA24
	mov r0,r0	; 0232BA28
	subs pc,lr,#0x4	; 0232BA2C
.endfunc
pool_0232BA30:
loc_0232BA30:
	.word P1_RestoreArithmeticContext + 1	; 0232BA30
.thumb

; ===== function loc_0232BA34 =====
loc_0232BA34:
	ldr r0,[pool_0232BA3C]	; 0232BA34
	ldr r1,[pool_0232BA40]	; 0232BA36
	str r0,[r1,#0x0]	; 0232BA38
	bx lr	; 0232BA3A
pool_0232BA3C:
loc_0232BA3C:
	.word 0x82000001	; 0232BA3C
pool_0232BA40:
loc_0232BA40:
	.word P1_Data_02330A58	; 0232BA40

; ===== function loc_0232BA44 =====
loc_0232BA44:
	mov r0,#0x0	; 0232BA44
	bx lr	; 0232BA46

; ===== function loc_0232BA48 =====
loc_0232BA48:
	push {r4,r5,r6,r7,lr}	; 0232BA48
	sub sp,#0x4	; 0232BA4A
	add r5,r0,#0x0	; 0232BA4C
	add r7,r1,#0x0	; 0232BA4E
	add r4,r2,#0x0	; 0232BA50
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BA52
	str r0,[sp,#0x0]	; 0232BA56
	ldr r0,[r5,#0x10]	; 0232BA58
	cmp r0,#0x0	; 0232BA5A
	bne loc_0232BA84	; 0232BA5C
	mov r0,#0x1	; 0232BA5E
	and r4,r0	; 0232BA60
	add r6,r5,#0x2	; 0232BA62
loc_0232BA64:
	cmp r4,#0x0	; 0232BA64
	bne loc_0232BA78	; 0232BA66
	ldr r0,[sp,#0x0]	; 0232BA68
	blx P1_Arm9RestoreIrqMask	; 0232BA6A
	mov r0,#0x0	; 0232BA6E
	add sp,#0x4	; 0232BA70
	pop {r4,r5,r6,r7}	; 0232BA72
	pop {r3}	; 0232BA74
	bx r3	; 0232BA76
loc_0232BA78:
	add r0,r6,#0x0	; 0232BA78
	bl loc_0232B698	; 0232BA7A
	ldr r0,[r5,#0x10]	; 0232BA7E
	cmp r0,#0x0	; 0232BA80
	beq loc_0232BA64	; 0232BA82
loc_0232BA84:
	cmp r7,#0x0	; 0232BA84
	beq loc_0232BA92	; 0232BA86
	ldr r1,[r5,#0x4]	; 0232BA88
	ldr r0,[r5,#0xc]	; 0232BA8A
	lsl r0,r0,#0x2	; 0232BA8C
	ldr r0,[r1,r0]	; 0232BA8E
	str r0,[r7,#0x0]	; 0232BA90
loc_0232BA92:
	ldr r0,[r5,#0xc]	; 0232BA92
	add r0,r0,#0x1	; 0232BA94
	ldr r1,[r5,#0x8]	; 0232BA96
	blx P1_SignedDivMod	; 0232BA98
	str r1,[r5,#0xc]	; 0232BA9C
	ldr r0,[r5,#0x10]	; 0232BA9E
	sub r0,r0,#0x1	; 0232BAA0
	str r0,[r5,#0x10]	; 0232BAA2
	add r0,r5,#0x0	; 0232BAA4
	bl loc_0232B650	; 0232BAA6
	ldr r0,[sp,#0x0]	; 0232BAAA
	blx P1_Arm9RestoreIrqMask	; 0232BAAC
	mov r0,#0x1	; 0232BAB0
	add sp,#0x4	; 0232BAB2
	pop {r4,r5,r6,r7}	; 0232BAB4
	pop {r3}	; 0232BAB6
	bx r3	; 0232BAB8
	.byte 0x00, 0x00	; 0232BABC

; ===== function loc_0232BABC =====
loc_0232BABC:
	push {r4,r5,r6,r7,lr}	; 0232BABC
	sub sp,#0x4	; 0232BABE
	add r5,r0,#0x0	; 0232BAC0
	add r6,r1,#0x0	; 0232BAC2
	add r4,r2,#0x0	; 0232BAC4
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BAC6
	add r7,r0,#0x0	; 0232BACA
	ldr r2,[r5,#0x10]	; 0232BACC
	ldr r1,[r5,#0x8]	; 0232BACE
	cmp r1,r2	; 0232BAD0
	bgt loc_0232BAFA	; 0232BAD2
	mov r0,#0x1	; 0232BAD4
	and r4,r0	; 0232BAD6
loc_0232BAD8:
	cmp r4,#0x0	; 0232BAD8
	bne loc_0232BAEC	; 0232BADA
	add r0,r7,#0x0	; 0232BADC
	blx P1_Arm9RestoreIrqMask	; 0232BADE
	mov r0,#0x0	; 0232BAE2
	add sp,#0x4	; 0232BAE4
	pop {r4,r5,r6,r7}	; 0232BAE6
	pop {r3}	; 0232BAE8
	bx r3	; 0232BAEA
loc_0232BAEC:
	add r0,r5,#0x0	; 0232BAEC
	bl loc_0232B698	; 0232BAEE
	ldr r2,[r5,#0x10]	; 0232BAF2
	ldr r1,[r5,#0x8]	; 0232BAF4
	cmp r1,r2	; 0232BAF6
	ble loc_0232BAD8	; 0232BAF8
loc_0232BAFA:
	ldr r0,[r5,#0xc]	; 0232BAFA
	add r0,r0,r2	; 0232BAFC
	blx P1_SignedDivMod	; 0232BAFE
	ldr r2,[r5,#0x4]	; 0232BB02
	lsl r0,r1,#0x2	; 0232BB04
	str r6,[r2,r0]	; 0232BB06
	ldr r0,[r5,#0x10]	; 0232BB08
	add r0,r0,#0x1	; 0232BB0A
	str r0,[r5,#0x10]	; 0232BB0C
	add r0,r5,#0x2	; 0232BB0E
	bl loc_0232B650	; 0232BB10
	add r0,r7,#0x0	; 0232BB14
	blx P1_Arm9RestoreIrqMask	; 0232BB16
	mov r0,#0x1	; 0232BB1A
	add sp,#0x4	; 0232BB1C
	pop {r4,r5,r6,r7}	; 0232BB1E
	pop {r3}	; 0232BB20
	bx r3	; 0232BB22
P1_Entry_0232BB24:
	mov r3,#0x0	; 0232BB24
	strh r3,[r0,#0x0]	; 0232BB26
	strh r3,[r0,#0x2]	; 0232BB28
	str r1,[r0,#0x4]	; 0232BB2A
	str r2,[r0,#0x8]	; 0232BB2C
	str r3,[r0,#0xc]	; 0232BB2E
	str r3,[r0,#0x10]	; 0232BB30
	bx lr	; 0232BB32

; ===== function loc_0232BB34 =====
loc_0232BB34:
	push {r4}	; 0232BB34
	sub sp,#0x4	; 0232BB36
	ldr r4,[r0,#0x7c]	; 0232BB38
	ldr r3,[r4,#0x10]	; 0232BB3A
	cmp r3,#0x0	; 0232BB3C
	bne loc_0232BB4A	; 0232BB3E
	mov r2,#0x0	; 0232BB40
	add r1,r0,#0x0	; 0232BB42
	add r1,#0x80	; 0232BB44
	str r2,[r1,#0x0]	; 0232BB46
	b loc_0232BB4E	; 0232BB48
loc_0232BB4A:
	mov r1,#0x0	; 0232BB4A
	str r1,[r3,#0xc]	; 0232BB4C
loc_0232BB4E:
	str r3,[r0,#0x7c]	; 0232BB4E
	add r0,r4,#0x0	; 0232BB50
	add sp,#0x4	; 0232BB52
	pop {r4}	; 0232BB54
	bx lr	; 0232BB56

; ===== function loc_0232BB58 =====
loc_0232BB58:
	push {r4,r5,lr}	; 0232BB58
	sub sp,#0x4	; 0232BB5A
	add r5,r0,#0x0	; 0232BB5C
	ldr r0,[r5,#0x7c]	; 0232BB5E
	cmp r0,#0x0	; 0232BB60
	beq loc_0232BB7A	; 0232BB62
	mov r4,#0x0	; 0232BB64
loc_0232BB66:
	add r0,r5,#0x0	; 0232BB66
	bl loc_0232BB34	; 0232BB68
	str r4,[r0,#0x8]	; 0232BB6C
	str r4,[r0,#0x4]	; 0232BB6E
	bl loc_0232B650	; 0232BB70
	ldr r0,[r5,#0x7c]	; 0232BB74
	cmp r0,#0x0	; 0232BB76
	bne loc_0232BB66	; 0232BB78
loc_0232BB7A:
	add sp,#0x4	; 0232BB7A
	pop {r4,r5}	; 0232BB7C
	pop {r3}	; 0232BB7E
	bx r3	; 0232BB80
	.byte 0x00, 0x00	; 0232BB84

; ===== function loc_0232BB84 =====
loc_0232BB84:
	mov r1,#0x0	; 0232BB84
	strh r1,[r0,#0x0]	; 0232BB86
	str r1,[r0,#0x4]	; 0232BB88
	str r1,[r0,#0x8]	; 0232BB8A
	bx lr	; 0232BB8C
	.byte 0x00, 0x00	; 0232BB90
.arm

; ===== function loc_0232BB90 =====
; 以 ARM946 cache index 遍历并清理整个 D-cache。
; Cleans the entire ARM946 D-cache by cache index.
.func P1_CleanEntireDataCacheByIndex
loc_0232BB90:
	mov r1,#0x0	; 0232BB90
loc_0232BB94:
	mov r0,#0x0	; 0232BB94
loc_0232BB98:
	orr r2,r1,r0	; 0232BB98
	mcr p15,0x0,r2,c7,c10,0x2	; 0232BB9C
	add r0,r0,#0x20	; 0232BBA0
	cmp r0,#0x400	; 0232BBA4
	blt loc_0232BB98	; 0232BBA8
	add r1,r1,#0x40000000	; 0232BBAC
	cmp r1,#0x0	; 0232BBB0
	bne loc_0232BB94	; 0232BBB4
	bx lr	; 0232BBB8

.endfunc

; ===== function loc_0232BBBC =====
; 以 ARM946 cache index 遍历，清理并失效整个 D-cache。
; Cleans and invalidates the entire ARM946 D-cache by cache index.
.func P1_CleanAndInvalidateEntireDataCacheByIndex
loc_0232BBBC:
	mov r1,#0x0	; 0232BBBC
loc_0232BBC0:
	mov r0,#0x0	; 0232BBC0
loc_0232BBC4:
	orr r2,r1,r0	; 0232BBC4
	mcr p15,0x0,r2,c7,c14,0x2	; 0232BBC8
	add r0,r0,#0x20	; 0232BBCC
	cmp r0,#0x400	; 0232BBD0
	blt loc_0232BBC4	; 0232BBD4
	add r1,r1,#0x40000000	; 0232BBD8
	cmp r1,#0x0	; 0232BBDC
	bne loc_0232BBC0	; 0232BBE0
	bx lr	; 0232BBE4

.endfunc

; ===== function loc_0232BBE8 =====
; 按 ARM946 32 字节 cache line 失效指定的 D-cache 地址范围。
; Invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_InvalidateDataCacheRange
loc_0232BBE8:
	add r1,r1,r0	; 0232BBE8
	bic r0,r0,#0x1f	; 0232BBEC
loc_0232BBF0:
	mcr p15,0x0,r0,c7,c6,0x1	; 0232BBF0
	add r0,r0,#0x20	; 0232BBF4
	cmp r0,r1	; 0232BBF8
	blt loc_0232BBF0	; 0232BBFC
	bx lr	; 0232BC00

.endfunc

; ===== function loc_0232BC04 =====
; 按 ARM946 32 字节 cache line 清理指定的 D-cache 地址范围。
; Cleans a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanDataCacheRange
loc_0232BC04:
	add r1,r1,r0	; 0232BC04
	bic r0,r0,#0x1f	; 0232BC08
loc_0232BC0C:
	mcr p15,0x0,r0,c7,c10,0x1	; 0232BC0C
	add r0,r0,#0x20	; 0232BC10
	cmp r0,r1	; 0232BC14
	blt loc_0232BC0C	; 0232BC18
	bx lr	; 0232BC1C

.endfunc

; ===== function loc_0232BC20 =====
; 按 ARM946 32 字节 cache line 清理并失效指定的 D-cache 地址范围。
; Cleans and invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanAndInvalidateDataCacheRange
loc_0232BC20:
	add r1,r1,r0	; 0232BC20
	bic r0,r0,#0x1f	; 0232BC24
loc_0232BC28:
	mcr p15,0x0,r0,c7,c14,0x1	; 0232BC28
	add r0,r0,#0x20	; 0232BC2C
	cmp r0,r1	; 0232BC30
	blt loc_0232BC28	; 0232BC34
	bx lr	; 0232BC38
.endfunc
.arm
; 排空 ARM946 写缓冲区，确保先前存储操作完成。
; Drains the ARM946 write buffer so prior stores complete.
.func P1_DrainWriteBuffer
loc_0232BC3C:
	mov r0,#0x0	; 0232BC3C
	mcr p15,0x0,r0,c7,c10,0x4	; 0232BC40
	bx lr	; 0232BC44
.endfunc
.thumb

; ===== function loc_0232BC48 =====
loc_0232BC48:
	push {lr}	; 0232BC48
	sub sp,#0x4	; 0232BC4A
	bl loc_0232BD70	; 0232BC4C
	bl loc_0232E7E4	; 0232BC50
	bl loc_0232B4FC	; 0232BC54
	bl loc_0232BD6C	; 0232BC58
	bl loc_0232B254	; 0232BC5C
	bl P1_InitExceptionHandler	; 0232BC60
	mov r0,#0x3	; 0232BC64
	bl loc_0232DD48	; 0232BC66
	bl loc_0232C468	; 0232BC6A
	bl loc_0232B7CC	; 0232BC6E
	bl loc_0232C794	; 0232BC72
	bl loc_0232F4B8	; 0232BC76
	add sp,#0x4	; 0232BC7A
	pop {r3}	; 0232BC7C
	bx r3	; 0232BC7E

; ===== function loc_0232BC80 =====
loc_0232BC80:
	lsl r2,r0,#0x2	; 0232BC80
	ldr r0,[pool_0232BC88]	; 0232BC82
	str r1,[r2,r0]	; 0232BC84
	bx lr	; 0232BC86
pool_0232BC88:
loc_0232BC88:
	.word 0x027FFDA0	; 0232BC88

; ===== function loc_0232BC8C =====
loc_0232BC8C:
	lsl r2,r0,#0x2	; 0232BC8C
	ldr r0,[pool_0232BC94]	; 0232BC8E
	str r1,[r2,r0]	; 0232BC90
	bx lr	; 0232BC92
pool_0232BC94:
loc_0232BC94:
	.word 0x027FFDC4	; 0232BC94

; ===== function loc_0232BC98 =====
loc_0232BC98:
	cmp r0,#0x6	; 0232BC98
	bhi loc_0232BCD0	; 0232BC9A
	add r0,r0,r0	; 0232BC9C
P1_SwitchIndexPC_0232BC9C:
	add r0,pc	; 0232BC9E
	ldrh r0,[r0,#(P1_SwitchTable_0232BC9C - (P1_SwitchIndexPC_0232BC9C + 4))]	; 0232BCA0
	lsl r0,r0,#0x10	; 0232BCA2
	asr r0,r0,#0x10	; 0232BCA4
P1_SwitchTargetPC_0232BC9C:
	add r0,pc	; 0232BCA6
	bx r0	; 0232BCA8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232BC9C:
	.halfword (loc_0232BCB8 + 1) - (P1_SwitchTargetPC_0232BC9C + 4)
	.halfword (loc_0232BCD0 + 1) - (P1_SwitchTargetPC_0232BC9C + 4)
	.halfword (loc_0232BCBC + 1) - (P1_SwitchTargetPC_0232BC9C + 4)
	.halfword (loc_0232BCC0 + 1) - (P1_SwitchTargetPC_0232BC9C + 4)
	.halfword (loc_0232BCC4 + 1) - (P1_SwitchTargetPC_0232BC9C + 4)
	.halfword (loc_0232BCC8 + 1) - (P1_SwitchTargetPC_0232BC9C + 4)
	.halfword (loc_0232BCCC + 1) - (P1_SwitchTargetPC_0232BC9C + 4)
P1_SwitchTable_0232BC9CEnd:
loc_0232BCB8:
	ldr r0,[pool_0232BCD4]	; 0232BCB8
	bx lr	; 0232BCBA
loc_0232BCBC:
	mov r0,#0x0	; 0232BCBC
	bx lr	; 0232BCBE
loc_0232BCC0:
	ldr r0,[pool_0232BCD8]	; 0232BCC0
	bx lr	; 0232BCC2
loc_0232BCC4:
	ldr r0,[pool_0232BCDC]	; 0232BCC4
	bx lr	; 0232BCC6
loc_0232BCC8:
	ldr r0,[pool_0232BCE0]	; 0232BCC8
	bx lr	; 0232BCCA
loc_0232BCCC:
	ldr r0,[pool_0232BCE4]	; 0232BCCC
	bx lr	; 0232BCCE
loc_0232BCD0:
	mov r0,#0x0	; 0232BCD0
	bx lr	; 0232BCD2
pool_0232BCD4:
loc_0232BCD4:
	.word 0x023E9400	; 0232BCD4
pool_0232BCD8:
loc_0232BCD8:
	.word 0x01FF8320	; 0232BCD8
pool_0232BCDC:
loc_0232BCDC:
	.word 0x03000020	; 0232BCDC
pool_0232BCE0:
loc_0232BCE0:
	.word 0x027FF000	; 0232BCE0
pool_0232BCE4:
loc_0232BCE4:
	.word 0x037F8000	; 0232BCE4

; ===== function loc_0232BCE8 =====
loc_0232BCE8:
	cmp r0,#0x6	; 0232BCE8
	bhi loc_0232BD42	; 0232BCEA
	add r0,r0,r0	; 0232BCEC
P1_SwitchIndexPC_0232BCEC:
	add r0,pc	; 0232BCEE
	ldrh r0,[r0,#(P1_SwitchTable_0232BCEC - (P1_SwitchIndexPC_0232BCEC + 4))]	; 0232BCF0
	lsl r0,r0,#0x10	; 0232BCF2
	asr r0,r0,#0x10	; 0232BCF4
P1_SwitchTargetPC_0232BCEC:
	add r0,pc	; 0232BCF6
	bx r0	; 0232BCF8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232BCEC:
	.halfword (loc_0232BD08 + 1) - (P1_SwitchTargetPC_0232BCEC + 4)
	.halfword (loc_0232BD42 + 1) - (P1_SwitchTargetPC_0232BCEC + 4)
	.halfword (loc_0232BD0C + 1) - (P1_SwitchTargetPC_0232BCEC + 4)
	.halfword (loc_0232BD10 + 1) - (P1_SwitchTargetPC_0232BCEC + 4)
	.halfword (loc_0232BD14 + 1) - (P1_SwitchTargetPC_0232BCEC + 4)
	.halfword (loc_0232BD3A + 1) - (P1_SwitchTargetPC_0232BCEC + 4)
	.halfword (loc_0232BD3E + 1) - (P1_SwitchTargetPC_0232BCEC + 4)
P1_SwitchTable_0232BCECEnd:
loc_0232BD08:
	ldr r0,[pool_0232BD48]	; 0232BD08
	bx lr	; 0232BD0A
loc_0232BD0C:
	mov r0,#0x0	; 0232BD0C
	bx lr	; 0232BD0E
loc_0232BD10:
	ldr r0,[pool_0232BD4C]	; 0232BD10
	bx lr	; 0232BD12
loc_0232BD14:
	ldr r0,[pool_0232BD50]	; 0232BD14
	ldr r1,[pool_0232BD54]	; 0232BD16
	add r2,r0,r1	; 0232BD18
	ldr r1,[pool_0232BD58]	; 0232BD1A
	sub r2,r2,r1	; 0232BD1C
	ldr r1,[pool_0232BD5C]	; 0232BD1E
	cmp r1,#0x0	; 0232BD20
	bne loc_0232BD2E	; 0232BD22
	ldr r1,[pool_0232BD60]	; 0232BD24
	cmp r0,r1	; 0232BD26
	bcs loc_0232BD44	; 0232BD28
	add r0,r1,#0x0	; 0232BD2A
	bx lr	; 0232BD2C
loc_0232BD2E:
	cmp r1,#0x0	; 0232BD2E
	bge loc_0232BD36	; 0232BD30
	sub r0,r0,r1	; 0232BD32
	bx lr	; 0232BD34
loc_0232BD36:
	sub r0,r2,r1	; 0232BD36
	bx lr	; 0232BD38
loc_0232BD3A:
	ldr r0,[pool_0232BD64]	; 0232BD3A
	bx lr	; 0232BD3C
loc_0232BD3E:
	ldr r0,[pool_0232BD68]	; 0232BD3E
	bx lr	; 0232BD40
loc_0232BD42:
	mov r0,#0x0	; 0232BD42
loc_0232BD44:
	bx lr	; 0232BD44
	.byte 0xC0, 0x46	; 0232BD48
pool_0232BD48:
loc_0232BD48:
	.word 0x023C0000	; 0232BD48
pool_0232BD4C:
loc_0232BD4C:
	.word 0x02000000	; 0232BD4C
pool_0232BD50:
loc_0232BD50:
	.word 0x03000000	; 0232BD50
pool_0232BD54:
loc_0232BD54:
	.word 0x00003F80	; 0232BD54
pool_0232BD58:
loc_0232BD58:
	.word 0x00001000	; 0232BD58
pool_0232BD5C:
loc_0232BD5C:
	.word 0x00000000	; 0232BD5C
pool_0232BD60:
loc_0232BD60:
	.word 0x03000020	; 0232BD60
pool_0232BD64:
loc_0232BD64:
	.word 0x027FF800	; 0232BD64
pool_0232BD68:
loc_0232BD68:
	.word 0x037F8000	; 0232BD68

; ===== function loc_0232BD6C =====
loc_0232BD6C:
	bx lr	; 0232BD6C
	.byte 0x00, 0x00	; 0232BD70

; ===== function loc_0232BD70 =====
loc_0232BD70:
	push {lr}	; 0232BD70
	sub sp,#0x4	; 0232BD72
	ldr r0,[pool_0232BDB4]	; 0232BD74
	ldr r1,[r0,#0x0]	; 0232BD76
	cmp r1,#0x0	; 0232BD78
	bne loc_0232BDAE	; 0232BD7A
	mov r1,#0x1	; 0232BD7C
	str r1,[r0,#0x0]	; 0232BD7E
	mov r0,#0x0	; 0232BD80
	bl loc_0232BDB8	; 0232BD82
	mov r0,#0x2	; 0232BD86
	mov r1,#0x0	; 0232BD88
	bl loc_0232BC80	; 0232BD8A
	mov r0,#0x2	; 0232BD8E
	mov r1,#0x0	; 0232BD90
	bl loc_0232BC8C	; 0232BD92
	mov r0,#0x3	; 0232BD96
	bl loc_0232BDB8	; 0232BD98
	mov r0,#0x4	; 0232BD9C
	bl loc_0232BDB8	; 0232BD9E
	mov r0,#0x5	; 0232BDA2
	bl loc_0232BDB8	; 0232BDA4
	mov r0,#0x6	; 0232BDA8
	bl loc_0232BDB8	; 0232BDAA
loc_0232BDAE:
	add sp,#0x4	; 0232BDAE
	pop {r3}	; 0232BDB0
	bx r3	; 0232BDB2
pool_0232BDB4:
loc_0232BDB4:
	.word P1_BssStart + 0x265C4	; 0232BDB4

; ===== function loc_0232BDB8 =====
loc_0232BDB8:
	push {r4,lr}	; 0232BDB8
	add r4,r0,#0x0	; 0232BDBA
	bl loc_0232BCE8	; 0232BDBC
	add r1,r0,#0x0	; 0232BDC0
	add r0,r4,#0x0	; 0232BDC2
	bl loc_0232BC8C	; 0232BDC4
	add r0,r4,#0x0	; 0232BDC8
	bl loc_0232BC98	; 0232BDCA
	add r1,r0,#0x0	; 0232BDCE
	add r0,r4,#0x0	; 0232BDD0
	bl loc_0232BC80	; 0232BDD2
	pop {r4}	; 0232BDD6
	pop {r3}	; 0232BDD8
	bx r3	; 0232BDDA
.arm

; ===== function loc_0232BDDC =====
; Sets CP15 control-register c1 bit 0. / 置位 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9SetCp15ControlBit0
loc_0232BDDC:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BDDC
	orr r0,r0,#0x1	; 0232BDE0
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BDE4
	bx lr	; 0232BDE8
.endfunc

; ===== function loc_0232BDEC =====
; Clears CP15 control-register c1 bit 0. / 清除 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9ClearCp15ControlBit0
loc_0232BDEC:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BDEC
	bic r0,r0,#0x1	; 0232BDF0
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BDF4
	bx lr	; 0232BDF8
.endfunc
; 链接既有调试入口；保存现场后处理 abort/undef，最后停在等待循环。
; Chain the saved debug handler; process abort/undef context, then stop in a wait loop.
.func P1_ExceptionEntry
	ldr r12,[pool_0232BE68]	; 0232BDFC
	ldr r12,[r12,#0x0]	; 0232BE00
	cmp r12,#0x0	; 0232BE04
	movne lr,pc	; 0232BE08
	bxne r12	; 0232BE0C
	ldr r12,[pool_0232BE6C]	; 0232BE10
	stmdb r12!,{r0,r1,r2,r3,sp,lr}	; 0232BE14
	and r0,sp,#0x1	; 0232BE18
	mov sp,r12	; 0232BE1C
	mrs r1,cpsr	; 0232BE20
	and r1,r1,#0x1f	; 0232BE24
	teq r1,#0x17	; 0232BE28
	bne loc_0232BE38	; 0232BE2C
	bl P1_ProcessException	; 0232BE30
	b loc_0232BE44	; 0232BE34
loc_0232BE38:
	teq r1,#0x1b	; 0232BE38
	bne loc_0232BE44	; 0232BE3C
	bl P1_ProcessException	; 0232BE40
loc_0232BE44:
	ldr r12,[pool_0232BE68]	; 0232BE44
	ldr r12,[r12,#0x0]	; 0232BE48
	cmp r12,#0x0	; 0232BE4C
loc_0232BE50:
	beq loc_0232BE50	; 0232BE50
loc_0232BE54:
	mov r0,r0	; 0232BE54
	b loc_0232BE54	; 0232BE58
.endfunc
	.byte 0x0F, 0x50, 0xBD, 0xE8, 0x0C, 0xD0, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1	; 0232BE68
pool_0232BE68:
loc_0232BE68:
	.word P1_PreviousExceptionHandler	; 0232BE68
pool_0232BE6C:
loc_0232BE6C:
	.word P1_ExceptionStackTop	; 0232BE6C

; ===== function loc_0232BE70 =====
loc_0232BE70:
; 先保存异常现场，再调用已注册的用户处理器。
; Save exception context, then invoke the registered user handler.
.func P1_ProcessException
	stmdb sp!,{lr}	; 0232BE70
	bl P1_SaveExceptionContext	; 0232BE74
	bl P1_CallUserExceptionHandler	; 0232BE78
	ldmia sp!,{lr}	; 0232BE7C
	bx lr	; 0232BE80
.endfunc

; ===== function loc_0232BE84 =====
loc_0232BE84:
; 收集通用寄存器、异常栈与各模式的状态，写入 BSS 上下文。
; Collect registers, exception-stack data and mode state into the BSS context.
.func P1_SaveExceptionContext
	ldr r1,[pool_0232BF10]	; 0232BE84
	mrs r2,cpsr	; 0232BE88
	str r2,[r1,#0x74]	; 0232BE8C
	str r0,[r1,#0x6c]	; 0232BE90
	ldr r0,[r12,#0x0]	; 0232BE94
	str r0,[r1,#0x4]	; 0232BE98
	ldr r0,[r12,#0x4]	; 0232BE9C
	str r0,[r1,#0x8]	; 0232BEA0
	ldr r0,[r12,#0x8]	; 0232BEA4
	str r0,[r1,#0xc]	; 0232BEA8
	ldr r0,[r12,#0xc]	; 0232BEAC
	str r0,[r1,#0x10]	; 0232BEB0
	ldr r2,[r12,#0x10]	; 0232BEB4
	bic r2,r2,#0x1	; 0232BEB8
	add r0,r1,#0x14	; 0232BEBC
	stmia r0,{r4,r5,r6,r7,r8,r9,r10,r11}	; 0232BEC0
	str r12,[r1,#0x70]	; 0232BEC4
	ldr r0,[r2,#0x0]	; 0232BEC8
	str r0,[r1,#0x64]	; 0232BECC
	ldr r3,[r2,#0x4]	; 0232BED0
	str r3,[r1,#0x0]	; 0232BED4
	ldr r0,[r2,#0x8]	; 0232BED8
	str r0,[r1,#0x34]	; 0232BEDC
	ldr r0,[r2,#0xc]	; 0232BEE0
	str r0,[r1,#0x40]	; 0232BEE4
	mrs r0,cpsr	; 0232BEE8
	orr r3,r3,#0x80	; 0232BEEC
	bic r3,r3,#0x20	; 0232BEF0
	msr cpsr_cxsf,r3	; 0232BEF4
	str sp,[r1,#0x38]	; 0232BEF8
	str lr,[r1,#0x3c]	; 0232BEFC
	mrs r2,spsr	; 0232BF00
	str r2,[r1,#0x7c]	; 0232BF04
	msr cpsr_cxsf,r0	; 0232BF08
	bx lr	; 0232BF0C
.endfunc
pool_0232BF10:
loc_0232BF10:
	.word P1_ExceptionContext	; 0232BF10

; ===== function loc_0232BF14 =====
loc_0232BF14:
; 若已注册，临时启用保护单元并以现场/参数调用用户回调。
; If registered, enable the MPU for the user callback with context and argument.
.func P1_CallUserExceptionHandler
	stmdb sp!,{lr}	; 0232BF14
	sub sp,sp,#0x4	; 0232BF18
	ldr r0,[pool_0232BF70]	; 0232BF1C
	ldr r0,[r0,#0x0]	; 0232BF20
	cmp r0,#0x0	; 0232BF24
	addeq sp,sp,#0x4	; 0232BF28
	ldmeqia sp!,{lr}	; 0232BF2C
	bxeq lr	; 0232BF30
	mov r0,sp	; 0232BF34
	ldr r1,[pool_0232BF74]	; 0232BF38
	msr cpsr_cxsf,r1	; 0232BF3C
	mov sp,r0	; 0232BF40
	bl P1_Arm9SetCp15ControlBit0	; 0232BF44
	ldr r1,[pool_0232BF78]	; 0232BF48
	ldr r0,[pool_0232BF70]	; 0232BF4C
	ldr r1,[r1,#0x0]	; 0232BF50
	ldr r2,[r0,#0x0]	; 0232BF54
	ldr r0,[pool_0232BF7C]	; 0232BF58
	blx r2	; 0232BF5C
	bl P1_Arm9ClearCp15ControlBit0	; 0232BF60
	add sp,sp,#0x4	; 0232BF64
	ldmia sp!,{lr}	; 0232BF68
	bx lr	; 0232BF6C
.endfunc
pool_0232BF70:
loc_0232BF70:
	.word P1_UserExceptionHandler	; 0232BF70
pool_0232BF74:
loc_0232BF74:
	.word 0x0000009F	; 0232BF74
pool_0232BF78:
loc_0232BF78:
	.word P1_UserExceptionArgument	; 0232BF78
pool_0232BF7C:
loc_0232BF7C:
	.word P1_ExceptionContext	; 0232BF7C
.thumb

; ===== function loc_0232BF80 =====
loc_0232BF80:
; 检查既有调试入口；需要时同时安装 BIOS 向量和 DTCM 中的入口副本。
; Check the saved debug entry; install the BIOS vector and DTCM copy when required.
.func P1_InitExceptionHandler
	push {lr}	; 0232BF80
	sub sp,#0x4	; 0232BF82
	ldr r0,[pool_0232BFCC]	; 0232BF84
	ldr r1,[r0,#0x0]	; 0232BF86
	ldr r0,[pool_0232BFD0]	; 0232BF88
	cmp r1,r0	; 0232BF8A
	bcc loc_0232BF9A	; 0232BF8C
	ldr r0,[pool_0232BFD4]	; 0232BF8E
	cmp r1,r0	; 0232BF90
	bcs loc_0232BF9A	; 0232BF92
	ldr r0,[pool_0232BFD8]	; 0232BF94
	str r1,[r0,#0x0]	; 0232BF96
	b loc_0232BFA0	; 0232BF98
loc_0232BF9A:
	mov r1,#0x0	; 0232BF9A
	ldr r0,[pool_0232BFD8]	; 0232BF9C
	str r1,[r0,#0x0]	; 0232BF9E
loc_0232BFA0:
	ldr r0,[pool_0232BFD8]	; 0232BFA0
	ldr r0,[r0,#0x0]	; 0232BFA2
	cmp r0,#0x0	; 0232BFA4
	beq loc_0232BFB4	; 0232BFA6
	bl loc_0232BA34	; 0232BFA8
	ldr r1,[pool_0232BFDC]	; 0232BFAC
	and r0,r1	; 0232BFAE
	cmp r0,#0x0	; 0232BFB0
	bne loc_0232BFBE	; 0232BFB2
loc_0232BFB4:
	ldr r1,[pool_0232BFE0]	; 0232BFB4
	ldr r0,[pool_0232BFCC]	; 0232BFB6
	str r1,[r0,#0x0]	; 0232BFB8
	ldr r0,[pool_0232BFE4]	; 0232BFBA
	str r1,[r0,#0x5c]	; 0232BFBC
loc_0232BFBE:
	mov r1,#0x0	; 0232BFBE
	ldr r0,[pool_0232BFE8]	; 0232BFC0
	str r1,[r0,#0x0]	; 0232BFC2
	add sp,#0x4	; 0232BFC4
	pop {r3}	; 0232BFC6
	bx r3	; 0232BFC8
.endfunc
	.byte 0xC0, 0x46	; 0232BFCC
pool_0232BFCC:
loc_0232BFCC:
	.word Bios9DebugVectorAddress	; 0232BFCC
pool_0232BFD0:
loc_0232BFD0:
	.word 0x02600000	; 0232BFD0
pool_0232BFD4:
loc_0232BFD4:
	.word 0x02800000	; 0232BFD4
pool_0232BFD8:
loc_0232BFD8:
	.word P1_PreviousExceptionHandler	; 0232BFD8
pool_0232BFDC:
loc_0232BFDC:
	.word 0x40000000	; 0232BFDC
pool_0232BFE0:
loc_0232BFE0:
	.word P1_ExceptionEntry	; 0232BFE0
pool_0232BFE4:
loc_0232BFE4:
	.word P1_DtcmExceptionVector - 0x5C	; 0232BFE4
pool_0232BFE8:
loc_0232BFE8:
	.word P1_UserExceptionHandler	; 0232BFE8

; ===== function loc_0232BFEC =====
loc_0232BFEC:
	ldr r1,[pool_0232BFFC]	; 0232BFEC
	ldrh r3,[r1,#0x0]	; 0232BFEE
	mov r2,#0x1	; 0232BFF0
	lsl r2,r0	; 0232BFF2
	orr r3,r2	; 0232BFF4
	strh r3,[r1,#0x0]	; 0232BFF6
	bx lr	; 0232BFF8
	.byte 0xC0, 0x46	; 0232BFFC
pool_0232BFFC:
loc_0232BFFC:
	.word P1_BssStart + 0x26654	; 0232BFFC

; ===== function loc_0232C000 =====
loc_0232C000:
	push {r4,r5,lr}	; 0232C000
	sub sp,#0xc	; 0232C002
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C004
	ldr r1,[pool_0232C068]	; 0232C008
	ldrh r1,[r1,#0x0]	; 0232C00A
	add r3,sp,#0x0	; 0232C00C
	strh r1,[r3,#0x0]	; 0232C00E
	ldr r1,[pool_0232C06C]	; 0232C010
	ldr r5,[r1,#0x0]	; 0232C012
	ldr r4,[r1,#0x4]	; 0232C014
	ldr r1,[pool_0232C070]	; 0232C016
	mov r2,#0x0	; 0232C018
	and r4,r1	; 0232C01A
	bic r5,r2	; 0232C01C
	str r5,[sp,#0x4]	; 0232C01E
	str r4,[sp,#0x8]	; 0232C020
	ldr r1,[pool_0232C074]	; 0232C022
	ldr r4,[r1,#0x0]	; 0232C024
	mov r1,#0x8	; 0232C026
	and r4,r1	; 0232C028
	cmp r4,#0x0	; 0232C02A
	beq loc_0232C046	; 0232C02C
	ldrh r3,[r3,#0x0]	; 0232C02E
	ldr r1,[pool_0232C078]	; 0232C030
	and r3,r1	; 0232C032
	cmp r3,#0x0	; 0232C034
	bne loc_0232C046	; 0232C036
	ldr r3,[sp,#0x4]	; 0232C038
	ldr r4,[sp,#0x8]	; 0232C03A
	mov r1,#0x1	; 0232C03C
	add r1,r3,r1	; 0232C03E
	adc r4,r2	; 0232C040
	str r1,[sp,#0x4]	; 0232C042
	str r4,[sp,#0x8]	; 0232C044
loc_0232C046:
	blx P1_Arm9RestoreIrqMask	; 0232C046
	ldr r2,[sp,#0x4]	; 0232C04A
	ldr r1,[sp,#0x8]	; 0232C04C
	lsr r0,r2,#0x10	; 0232C04E
	lsl r1,r1,#0x10	; 0232C050
	orr r1,r0	; 0232C052
	lsl r0,r2,#0x10	; 0232C054
	add r2,sp,#0x0	; 0232C056
	ldrh r3,[r2,#0x0]	; 0232C058
	asr r2,r3,#0x1f	; 0232C05A
	orr r1,r2	; 0232C05C
	orr r0,r3	; 0232C05E
	add sp,#0xc	; 0232C060
	pop {r4,r5}	; 0232C062
	pop {r3}	; 0232C064
	bx r3	; 0232C066
pool_0232C068:
loc_0232C068:
	.word TIMER0_DATA	; 0232C068
pool_0232C06C:
loc_0232C06C:
	.word P1_BssStart + 0x26660	; 0232C06C
pool_0232C070:
loc_0232C070:
	.word 0x0000FFFF	; 0232C070
pool_0232C074:
loc_0232C074:
	.word REG_IF	; 0232C074
pool_0232C078:
loc_0232C078:
	.word 0x00008000	; 0232C078

; ===== function loc_0232C07C =====
P1_IrqHandler_0232C07C:
	push {r4,lr}	; 0232C07C
	ldr r1,[pool_0232C0B8]	; 0232C07E
	ldr r2,[r1,#0x0]	; 0232C080
	ldr r4,[r1,#0x4]	; 0232C082
	mov r3,#0x0	; 0232C084
	mov r0,#0x1	; 0232C086
	add r0,r2,r0	; 0232C088
	adc r4,r3	; 0232C08A
	str r0,[r1,#0x0]	; 0232C08C
	str r4,[r1,#0x4]	; 0232C08E
	ldr r0,[pool_0232C0BC]	; 0232C090
	ldr r1,[r0,#0x0]	; 0232C092
	cmp r1,#0x0	; 0232C094
	beq loc_0232C0A6	; 0232C096
	ldr r2,[pool_0232C0C0]	; 0232C098
	strh r3,[r2,#0x0]	; 0232C09A
	ldr r1,[pool_0232C0C4]	; 0232C09C
	strh r3,[r1,#0x0]	; 0232C09E
	mov r1,#0xc1	; 0232C0A0
	strh r1,[r2,#0x0]	; 0232C0A2
	str r3,[r0,#0x0]	; 0232C0A4
loc_0232C0A6:
	mov r0,#0x0	; 0232C0A6
	ldr r1,[pool_0232C0C8]	; 0232C0A8
	add r2,r0,#0x0	; 0232C0AA
	bl loc_0232B1BC	; 0232C0AC
	pop {r4}	; 0232C0B0
	pop {r3}	; 0232C0B2
	bx r3	; 0232C0B4
	.byte 0xC0, 0x46	; 0232C0B8
pool_0232C0B8:
loc_0232C0B8:
	.word P1_BssStart + 0x26660	; 0232C0B8
pool_0232C0BC:
loc_0232C0BC:
	.word P1_BssStart + 0x2665C	; 0232C0BC
pool_0232C0C0:
loc_0232C0C0:
	.word TIMER0_CR	; 0232C0C0
pool_0232C0C4:
loc_0232C0C4:
	.word TIMER0_DATA	; 0232C0C4
pool_0232C0C8:
loc_0232C0C8:
	.word 0x0232C07D	; 0232C0C8

; ===== function loc_0232C0CC =====
loc_0232C0CC:
	push {lr}	; 0232C0CC
	sub sp,#0x4	; 0232C0CE
	ldr r0,[pool_0232C110]	; 0232C0D0
	ldrh r1,[r0,#0x0]	; 0232C0D2
	cmp r1,#0x0	; 0232C0D4
	bne loc_0232C10A	; 0232C0D6
	mov r1,#0x1	; 0232C0D8
	strh r1,[r0,#0x0]	; 0232C0DA
	mov r0,#0x0	; 0232C0DC
	bl loc_0232BFEC	; 0232C0DE
	mov r2,#0x0	; 0232C0E2
	ldr r0,[pool_0232C114]	; 0232C0E4
	str r2,[r0,#0x0]	; 0232C0E6
	str r2,[r0,#0x4]	; 0232C0E8
	ldr r1,[pool_0232C118]	; 0232C0EA
	strh r2,[r1,#0x0]	; 0232C0EC
	ldr r0,[pool_0232C11C]	; 0232C0EE
	strh r2,[r0,#0x0]	; 0232C0F0
	mov r0,#0xc1	; 0232C0F2
	strh r0,[r1,#0x0]	; 0232C0F4
	mov r0,#0x8	; 0232C0F6
	ldr r1,[pool_0232C120]	; 0232C0F8
	bl loc_0232B1F0	; 0232C0FA
	mov r0,#0x8	; 0232C0FE
	bl loc_0232B16C	; 0232C100
	mov r1,#0x0	; 0232C104
	ldr r0,[pool_0232C124]	; 0232C106
	str r1,[r0,#0x0]	; 0232C108
loc_0232C10A:
	add sp,#0x4	; 0232C10A
	pop {r3}	; 0232C10C
	bx r3	; 0232C10E
pool_0232C110:
loc_0232C110:
	.word P1_BssStart + 0x26658	; 0232C110
pool_0232C114:
loc_0232C114:
	.word P1_BssStart + 0x26660	; 0232C114
pool_0232C118:
loc_0232C118:
	.word TIMER0_CR	; 0232C118
pool_0232C11C:
loc_0232C11C:
	.word TIMER0_DATA	; 0232C11C
pool_0232C120:
loc_0232C120:
	.word P1_IrqHandler_0232C07C + 1	; 0232C120
pool_0232C124:
loc_0232C124:
	.word P1_BssStart + 0x2665C	; 0232C124
.arm
	stmdb sp!,{lr}	; 0232C128
	blx loc_0232C18C	; 0232C12C
	ldmia sp!,{lr}	; 0232C130
	bx lr	; 0232C134
.thumb

; ===== function loc_0232C138 =====
P1_Entry_0232C138:
	push {r4,r5,r6,r7,lr}	; 0232C138
	sub sp,#0x4	; 0232C13A
	add r5,r0,#0x0	; 0232C13C
	cmp r5,#0x0	; 0232C13E
	beq loc_0232C17C	; 0232C140
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C142
	add r7,r0,#0x0	; 0232C146
	ldr r0,[pool_0232C184]	; 0232C148
	ldr r0,[r0,#0x0]	; 0232C14A
	cmp r0,#0x0	; 0232C14C
	beq loc_0232C154	; 0232C14E
	ldr r4,[r0,#0x18]	; 0232C150
	b loc_0232C156	; 0232C152
loc_0232C154:
	mov r4,#0x0	; 0232C154
loc_0232C156:
	cmp r0,#0x0	; 0232C156
	beq loc_0232C176	; 0232C158
	mov r6,#0x0	; 0232C15A
loc_0232C15C:
	ldr r1,[r0,#0x8]	; 0232C15C
	cmp r1,r5	; 0232C15E
	bne loc_0232C166	; 0232C160
	bl loc_0232C23C	; 0232C162
loc_0232C166:
	add r0,r4,#0x0	; 0232C166
	cmp r4,#0x0	; 0232C168
	beq loc_0232C170	; 0232C16A
	ldr r4,[r4,#0x18]	; 0232C16C
	b loc_0232C172	; 0232C16E
loc_0232C170:
	add r4,r6,#0x0	; 0232C170
loc_0232C172:
	cmp r0,#0x0	; 0232C172
	bne loc_0232C15C	; 0232C174
loc_0232C176:
	add r0,r7,#0x0	; 0232C176
	blx P1_Arm9RestoreIrqMask	; 0232C178
loc_0232C17C:
	add sp,#0x4	; 0232C17C
	pop {r4,r5,r6,r7}	; 0232C17E
	pop {r3}	; 0232C180
	bx r3	; 0232C182
pool_0232C184:
loc_0232C184:
	.word P1_BssStart + 0x2666C	; 0232C184
P1_Entry_0232C188:
	str r1,[r0,#0x8]	; 0232C188
	bx lr	; 0232C18A

; ===== function loc_0232C18C =====
loc_0232C18C:
	push {r4,r5,lr}	; 0232C18C
	sub sp,#0x4	; 0232C18E
	mov r1,#0x0	; 0232C190
	ldr r0,[pool_0232C22C]	; 0232C192
	strh r1,[r0,#0x0]	; 0232C194
	mov r0,#0x10	; 0232C196
	bl loc_0232B144	; 0232C198
	ldr r1,[pool_0232C230]	; 0232C19C
	ldr r0,[pool_0232C234]	; 0232C19E
	add r1,r1,r0	; 0232C1A0
	ldr r2,[r1,#0x0]	; 0232C1A2
	mov r0,#0x10	; 0232C1A4
	orr r2,r0	; 0232C1A6
	str r2,[r1,#0x0]	; 0232C1A8
	bl loc_0232C000	; 0232C1AA
	ldr r2,[pool_0232C238]	; 0232C1AE
	ldr r4,[r2,#0x0]	; 0232C1B0
	cmp r4,#0x0	; 0232C1B2
	beq loc_0232C222	; 0232C1B4
	ldr r5,[r4,#0xc]	; 0232C1B6
	ldr r3,[r4,#0x10]	; 0232C1B8
	sub r0,r0,r5	; 0232C1BA
	sbc r1,r3	; 0232C1BC
	bcs loc_0232C1CE	; 0232C1BE
	add r0,r4,#0x0	; 0232C1C0
	bl loc_0232C3FC	; 0232C1C2
	add sp,#0x4	; 0232C1C6
	pop {r4,r5}	; 0232C1C8
	pop {r3}	; 0232C1CA
	bx r3	; 0232C1CC
loc_0232C1CE:
	ldr r1,[r4,#0x18]	; 0232C1CE
	str r1,[r2,#0x0]	; 0232C1D0
	cmp r1,#0x0	; 0232C1D2
	bne loc_0232C1DC	; 0232C1D4
	mov r0,#0x0	; 0232C1D6
	str r0,[r2,#0x4]	; 0232C1D8
	b loc_0232C1E0	; 0232C1DA
loc_0232C1DC:
	mov r0,#0x0	; 0232C1DC
	str r0,[r1,#0x14]	; 0232C1DE
loc_0232C1E0:
	ldr r5,[r4,#0x0]	; 0232C1E0
	ldr r2,[r4,#0x1c]	; 0232C1E2
	ldr r1,[r4,#0x20]	; 0232C1E4
	mov r0,#0x0	; 0232C1E6
	eor r1,r0	; 0232C1E8
	eor r2,r0	; 0232C1EA
	orr r1,r2	; 0232C1EC
	bne loc_0232C1F4	; 0232C1EE
	mov r0,#0x0	; 0232C1F0
	str r0,[r4,#0x0]	; 0232C1F2
loc_0232C1F4:
	cmp r5,#0x0	; 0232C1F4
	beq loc_0232C1FC	; 0232C1F6
	ldr r0,[r4,#0x4]	; 0232C1F8
	blx r5	; 0232C1FA
loc_0232C1FC:
	ldr r2,[r4,#0x1c]	; 0232C1FC
	ldr r1,[r4,#0x20]	; 0232C1FE
	mov r0,#0x0	; 0232C200
	eor r1,r0	; 0232C202
	eor r2,r0	; 0232C204
	orr r1,r2	; 0232C206
	beq loc_0232C216	; 0232C208
	str r5,[r4,#0x0]	; 0232C20A
	add r0,r4,#0x0	; 0232C20C
	mov r1,#0x0	; 0232C20E
	add r2,r1,#0x0	; 0232C210
	bl loc_0232C2EC	; 0232C212
loc_0232C216:
	ldr r0,[pool_0232C238]	; 0232C216
	ldr r0,[r0,#0x0]	; 0232C218
	cmp r0,#0x0	; 0232C21A
	beq loc_0232C222	; 0232C21C
	bl loc_0232C3FC	; 0232C21E
loc_0232C222:
	add sp,#0x4	; 0232C222
	pop {r4,r5}	; 0232C224
	pop {r3}	; 0232C226
	bx r3	; 0232C228
	.byte 0xC0, 0x46	; 0232C22C
pool_0232C22C:
loc_0232C22C:
	.word TIMER1_CR	; 0232C22C
pool_0232C230:
loc_0232C230:
	.word 0x03000000	; 0232C230
pool_0232C234:
loc_0232C234:
	.word 0x00003FF8	; 0232C234
pool_0232C238:
loc_0232C238:
	.word P1_BssStart + 0x2666C	; 0232C238

; ===== function loc_0232C23C =====
loc_0232C23C:
	push {r4,r5,lr}	; 0232C23C
	sub sp,#0x4	; 0232C23E
	add r5,r0,#0x0	; 0232C240
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C242
	add r4,r0,#0x0	; 0232C246
	ldr r1,[r5,#0x0]	; 0232C248
	cmp r1,#0x0	; 0232C24A
	bne loc_0232C25A	; 0232C24C
	blx P1_Arm9RestoreIrqMask	; 0232C24E
	add sp,#0x4	; 0232C252
	pop {r4,r5}	; 0232C254
	pop {r3}	; 0232C256
	bx r3	; 0232C258
loc_0232C25A:
	ldr r0,[r5,#0x18]	; 0232C25A
	cmp r0,#0x0	; 0232C25C
	bne loc_0232C268	; 0232C25E
	ldr r2,[r5,#0x14]	; 0232C260
	ldr r1,[pool_0232C298]	; 0232C262
	str r2,[r1,#0x4]	; 0232C264
	b loc_0232C26C	; 0232C266
loc_0232C268:
	ldr r1,[r5,#0x14]	; 0232C268
	str r1,[r0,#0x14]	; 0232C26A
loc_0232C26C:
	ldr r1,[r5,#0x14]	; 0232C26C
	cmp r1,#0x0	; 0232C26E
	beq loc_0232C276	; 0232C270
	str r0,[r1,#0x18]	; 0232C272
	b loc_0232C282	; 0232C274
loc_0232C276:
	ldr r1,[pool_0232C298]	; 0232C276
	str r0,[r1,#0x0]	; 0232C278
	cmp r0,#0x0	; 0232C27A
	beq loc_0232C282	; 0232C27C
	bl loc_0232C3FC	; 0232C27E
loc_0232C282:
	mov r0,#0x0	; 0232C282
	str r0,[r5,#0x0]	; 0232C284
	str r0,[r5,#0x1c]	; 0232C286
	str r0,[r5,#0x20]	; 0232C288
	add r0,r4,#0x0	; 0232C28A
	blx P1_Arm9RestoreIrqMask	; 0232C28C
	add sp,#0x4	; 0232C290
	pop {r4,r5}	; 0232C292
	pop {r3}	; 0232C294
	bx r3	; 0232C296
pool_0232C298:
loc_0232C298:
	.word P1_BssStart + 0x2666C	; 0232C298
P1_Entry_0232C29C:
	push {r4,r5,r6,r7,lr}	; 0232C29C
	sub sp,#0x4	; 0232C29E
	add r5,r0,#0x0	; 0232C2A0
	add r6,r1,#0x0	; 0232C2A2
	add r4,r2,#0x0	; 0232C2A4
	add r7,r3,#0x0	; 0232C2A6
	cmp r5,#0x0	; 0232C2A8
	beq P1_Entry_0232C2B2	; 0232C2AA
	ldr r0,[r5,#0x0]	; 0232C2AC
	cmp r0,#0x0	; 0232C2AE
	beq P1_Entry_0232C2B6	; 0232C2B0
P1_Entry_0232C2B2:
	bl loc_0232C538	; 0232C2B2
P1_Entry_0232C2B6:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C2B6
	str r0,[sp,#0x0]	; 0232C2BA
	mov r0,#0x0	; 0232C2BC
	str r0,[r5,#0x1c]	; 0232C2BE
	str r0,[r5,#0x20]	; 0232C2C0
	str r7,[r5,#0x0]	; 0232C2C2
	ldr r0,[sp,#0x18]	; 0232C2C4
	str r0,[r5,#0x4]	; 0232C2C6
	bl loc_0232C000	; 0232C2C8
	add r2,r0,#0x0	; 0232C2CC
	add r0,r5,#0x0	; 0232C2CE
	add r2,r6,r2	; 0232C2D0
	adc r4,r1	; 0232C2D2
	add r1,r2,#0x0	; 0232C2D4
	add r2,r4,#0x0	; 0232C2D6
	bl loc_0232C2EC	; 0232C2D8
	ldr r0,[sp,#0x0]	; 0232C2DC
	blx P1_Arm9RestoreIrqMask	; 0232C2DE
	add sp,#0x4	; 0232C2E2
	pop {r4,r5,r6,r7}	; 0232C2E4
	pop {r3}	; 0232C2E6
	bx r3	; 0232C2E8
	.byte 0x00, 0x00	; 0232C2EA

; ===== function loc_0232C2EC =====
loc_0232C2EC:
	push {r4,r5,r6,r7,lr}	; 0232C2EC
	sub sp,#0xc	; 0232C2EE
	add r5,r0,#0x0	; 0232C2F0
	add r4,r1,#0x0	; 0232C2F2
	add r6,r2,#0x0	; 0232C2F4
	ldr r2,[r5,#0x1c]	; 0232C2F6
	ldr r1,[r5,#0x20]	; 0232C2F8
	mov r0,#0x0	; 0232C2FA
	eor r1,r0	; 0232C2FC
	eor r2,r0	; 0232C2FE
	orr r1,r2	; 0232C300
	beq loc_0232C346	; 0232C302
	bl loc_0232C000	; 0232C304
	ldr r4,[r5,#0x24]	; 0232C308
	ldr r6,[r5,#0x28]	; 0232C30A
	sub r2,r4,r0	; 0232C30C
	lsl r2,r6,#0	; 0232C30E
	sbc r2,r1	; 0232C310
	bcs loc_0232C346	; 0232C312
	ldr r2,[r5,#0x1c]	; 0232C314
	str r2,[sp,#0x0]	; 0232C316
	ldr r2,[r5,#0x20]	; 0232C318
	str r2,[sp,#0x4]	; 0232C31A
	sub r0,r0,r4	; 0232C31C
	sbc r1,r6	; 0232C31E
	ldr r2,[sp,#0x0]	; 0232C320
	ldr r3,[sp,#0x4]	; 0232C322
	blx loc_0232CB10	; 0232C324
	str r0,[sp,#0x8]	; 0232C328
	add r7,r1,#0x0	; 0232C32A
	ldr r0,[sp,#0x0]	; 0232C32C
	ldr r1,[sp,#0x4]	; 0232C32E
	mov r3,#0x1	; 0232C330
	ldr r2,[sp,#0x8]	; 0232C332
	add r3,r2,r3	; 0232C334
	mov r2,#0x0	; 0232C336
	adc r7,r2	; 0232C338
	add r2,r3,#0x0	; 0232C33A
	add r3,r7,#0x0	; 0232C33C
	blx P1_AeabiLmul	; 0232C33E
	add r4,r4,r0	; 0232C342
	adc r6,r1	; 0232C344
loc_0232C346:
	str r4,[r5,#0xc]	; 0232C346
	str r6,[r5,#0x10]	; 0232C348
	ldr r0,[pool_0232C3C0]	; 0232C34A
	ldr r3,[r0,#0x0]	; 0232C34C
	cmp r3,#0x0	; 0232C34E
	beq loc_0232C394	; 0232C350
loc_0232C352:
	ldr r1,[r3,#0xc]	; 0232C352
	ldr r0,[r3,#0x10]	; 0232C354
	sub r2,r4,r1	; 0232C356
	lsl r1,r6,#0	; 0232C358
	sbc r1,r0	; 0232C35A
	mov r0,#0x0	; 0232C35C
	sub r2,r2,r0	; 0232C35E
	sbc r1,r0	; 0232C360
	bge loc_0232C38E	; 0232C362
	ldr r0,[r3,#0x14]	; 0232C364
	str r0,[r5,#0x14]	; 0232C366
	str r5,[r3,#0x14]	; 0232C368
	str r3,[r5,#0x18]	; 0232C36A
	ldr r0,[r5,#0x14]	; 0232C36C
	cmp r0,#0x0	; 0232C36E
	beq loc_0232C37C	; 0232C370
	str r5,[r0,#0x18]	; 0232C372
	add sp,#0xc	; 0232C374
	pop {r4,r5,r6,r7}	; 0232C376
	pop {r3}	; 0232C378
	bx r3	; 0232C37A
loc_0232C37C:
	ldr r0,[pool_0232C3C0]	; 0232C37C
	str r5,[r0,#0x0]	; 0232C37E
	add r0,r5,#0x0	; 0232C380
	bl loc_0232C3FC	; 0232C382
	add sp,#0xc	; 0232C386
	pop {r4,r5,r6,r7}	; 0232C388
	pop {r3}	; 0232C38A
	bx r3	; 0232C38C
loc_0232C38E:
	ldr r3,[r3,#0x18]	; 0232C38E
	cmp r3,#0x0	; 0232C390
	bne loc_0232C352	; 0232C392
loc_0232C394:
	mov r0,#0x0	; 0232C394
	str r0,[r5,#0x18]	; 0232C396
	ldr r0,[pool_0232C3C0]	; 0232C398
	ldr r1,[r0,#0x4]	; 0232C39A
	str r5,[r0,#0x4]	; 0232C39C
	str r1,[r5,#0x14]	; 0232C39E
	cmp r1,#0x0	; 0232C3A0
	beq loc_0232C3AE	; 0232C3A2
	str r5,[r1,#0x18]	; 0232C3A4
	add sp,#0xc	; 0232C3A6
	pop {r4,r5,r6,r7}	; 0232C3A8
	pop {r3}	; 0232C3AA
	bx r3	; 0232C3AC
loc_0232C3AE:
	str r5,[r0,#0x4]	; 0232C3AE
	str r5,[r0,#0x0]	; 0232C3B0
	add r0,r5,#0x0	; 0232C3B2
	bl loc_0232C3FC	; 0232C3B4
	add sp,#0xc	; 0232C3B8
	pop {r4,r5,r6,r7}	; 0232C3BA
	pop {r3}	; 0232C3BC
	bx r3	; 0232C3BE
pool_0232C3C0:
loc_0232C3C0:
	.word P1_BssStart + 0x2666C	; 0232C3C0
P1_Entry_0232C3C4:
	mov r1,#0x0	; 0232C3C4
	str r1,[r0,#0x0]	; 0232C3C6
	str r1,[r0,#0x8]	; 0232C3C8
	bx lr	; 0232C3CA

; ===== function loc_0232C3CC =====
P1_Entry_0232C3CC:
	push {lr}	; 0232C3CC
	sub sp,#0x4	; 0232C3CE
	ldr r1,[pool_0232C3F4]	; 0232C3D0
	ldrh r0,[r1,#0x0]	; 0232C3D2
	cmp r0,#0x0	; 0232C3D4
	bne loc_0232C3EE	; 0232C3D6
	mov r0,#0x1	; 0232C3D8
	strh r0,[r1,#0x0]	; 0232C3DA
	bl loc_0232BFEC	; 0232C3DC
	mov r1,#0x0	; 0232C3E0
	ldr r0,[pool_0232C3F8]	; 0232C3E2
	str r1,[r0,#0x0]	; 0232C3E4
	str r1,[r0,#0x4]	; 0232C3E6
	mov r0,#0x10	; 0232C3E8
	bl loc_0232B144	; 0232C3EA
loc_0232C3EE:
	add sp,#0x4	; 0232C3EE
	pop {r3}	; 0232C3F0
	bx r3	; 0232C3F2
pool_0232C3F4:
loc_0232C3F4:
	.word P1_BssStart + 0x26668	; 0232C3F4
pool_0232C3F8:
loc_0232C3F8:
	.word P1_BssStart + 0x2666C	; 0232C3F8

; ===== function loc_0232C3FC =====
loc_0232C3FC:
	push {r4,r5,lr}	; 0232C3FC
	sub sp,#0x4	; 0232C3FE
	add r4,r0,#0x0	; 0232C400
	bl loc_0232C000	; 0232C402
	mov r2,#0x0	; 0232C406
	ldr r3,[pool_0232C454]	; 0232C408
	strh r2,[r3,#0x0]	; 0232C40A
	ldr r3,[r4,#0xc]	; 0232C40C
	ldr r4,[r4,#0x10]	; 0232C40E
	sub r5,r3,r0	; 0232C410
	sbc r4,r1	; 0232C412
	mov r0,#0x1	; 0232C414
	ldr r1,[pool_0232C458]	; 0232C416
	bl loc_0232B1BC	; 0232C418
	mov r1,#0x0	; 0232C41C
	sub r0,r5,r1	; 0232C41E
	lsl r0,r4,#0	; 0232C420
	sbc r0,r1	; 0232C422
	bge loc_0232C42A	; 0232C424
	ldr r1,[pool_0232C45C]	; 0232C426
	b loc_0232C43C	; 0232C428
loc_0232C42A:
	ldr r0,[pool_0232C460]	; 0232C42A
	sub r0,r5,r0	; 0232C42C
	sbc r4,r1	; 0232C42E
	bge loc_0232C43A	; 0232C430
	mvn r0,r5	; 0232C432
	lsl r0,r0,#0x10	; 0232C434
	lsr r1,r0,#0x10	; 0232C436
	b loc_0232C43C	; 0232C438
loc_0232C43A:
	mov r1,#0x0	; 0232C43A
loc_0232C43C:
	ldr r0,[pool_0232C464]	; 0232C43C
	strh r1,[r0,#0x0]	; 0232C43E
	mov r1,#0xc1	; 0232C440
	ldr r0,[pool_0232C454]	; 0232C442
	strh r1,[r0,#0x0]	; 0232C444
	mov r0,#0x10	; 0232C446
	bl loc_0232B16C	; 0232C448
	add sp,#0x4	; 0232C44C
	pop {r4,r5}	; 0232C44E
	pop {r3}	; 0232C450
	bx r3	; 0232C452
pool_0232C454:
loc_0232C454:
	.word TIMER1_CR	; 0232C454
pool_0232C458:
loc_0232C458:
	.word 0x0232C128	; 0232C458
pool_0232C45C:
loc_0232C45C:
	.word 0x0000FFFE	; 0232C45C
pool_0232C460:
loc_0232C460:
	.word 0x00010000	; 0232C460
pool_0232C464:
loc_0232C464:
	.word TIMER1_DATA	; 0232C464

; ===== function loc_0232C468 =====
loc_0232C468:
	push {lr}	; 0232C468
	sub sp,#0x4	; 0232C46A
	ldr r0,[pool_0232C498]	; 0232C46C
	ldrh r1,[r0,#0x0]	; 0232C46E
	cmp r1,#0x0	; 0232C470
	bne loc_0232C490	; 0232C472
	mov r1,#0x1	; 0232C474
	strh r1,[r0,#0x0]	; 0232C476
	mov r1,#0x0	; 0232C478
	ldr r0,[pool_0232C49C]	; 0232C47A
	str r1,[r0,#0x0]	; 0232C47C
	str r1,[r0,#0x4]	; 0232C47E
	mov r0,#0x4	; 0232C480
	bl loc_0232B144	; 0232C482
	mov r1,#0x0	; 0232C486
	ldr r0,[pool_0232C4A0]	; 0232C488
	str r1,[r0,#0x0]	; 0232C48A
	ldr r0,[pool_0232C4A4]	; 0232C48C
	str r1,[r0,#0x0]	; 0232C48E
loc_0232C490:
	add sp,#0x4	; 0232C490
	pop {r3}	; 0232C492
	bx r3	; 0232C494
	.byte 0xC0, 0x46	; 0232C498
pool_0232C498:
loc_0232C498:
	.word P1_BssStart + 0x26674	; 0232C498
pool_0232C49C:
loc_0232C49C:
	.word P1_BssStart + 0x26680	; 0232C49C
pool_0232C4A0:
loc_0232C4A0:
	.word P1_BssStart + 0x2667C	; 0232C4A0
pool_0232C4A4:
loc_0232C4A4:
	.word P1_BssStart + 0x26678	; 0232C4A4
.arm

; ===== function loc_0232C4A8 =====
; Clears CPSR I and returns the former I mask. / 清除 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9EnableIrqReturnPriorMask
loc_0232C4A8:
	mrs r0,cpsr	; 0232C4A8
	bic r1,r0,#0x80	; 0232C4AC
	msr cpsr_c,r1	; 0232C4B0
	and r0,r0,#0x80	; 0232C4B4
	bx lr	; 0232C4B8
.endfunc

; ===== function loc_0232C4BC =====
; Sets CPSR I and returns the former I mask. / 设置 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9DisableIrqReturnPriorMask
loc_0232C4BC:
	mrs r0,cpsr	; 0232C4BC
	orr r1,r0,#0x80	; 0232C4C0
	msr cpsr_c,r1	; 0232C4C4
	and r0,r0,#0x80	; 0232C4C8
	bx lr	; 0232C4CC
.endfunc

; ===== function loc_0232C4D0 =====
; Restores CPSR I from r0 and returns the prior mask. / 按 r0 恢复 CPSR I 位并返回先前掩码。
.func P1_Arm9RestoreIrqMask
loc_0232C4D0:
	mrs r1,cpsr	; 0232C4D0
	bic r2,r1,#0x80	; 0232C4D4
	orr r2,r2,r0	; 0232C4D8
	msr cpsr_c,r2	; 0232C4DC
	and r0,r1,#0x80	; 0232C4E0
	bx lr	; 0232C4E4
.endfunc

; ===== function loc_0232C4E8 =====
; Sets CPSR I/F and returns the former masks. / 设置 CPSR I/F 位并返回先前掩码。
.func P1_Arm9DisableIrqFiqReturnPriorMasks
loc_0232C4E8:
	mrs r0,cpsr	; 0232C4E8
	orr r1,r0,#0xc0	; 0232C4EC
	msr cpsr_c,r1	; 0232C4F0
	and r0,r0,#0xc0	; 0232C4F4
	bx lr	; 0232C4F8
.endfunc

; ===== function loc_0232C4FC =====
; Restores CPSR I/F from r0 and returns prior masks. / 按 r0 恢复 CPSR I/F 位并返回先前掩码。
.func P1_Arm9RestoreIrqFiqMasks
loc_0232C4FC:
	mrs r1,cpsr	; 0232C4FC
	bic r2,r1,#0xc0	; 0232C500
	orr r2,r2,r0	; 0232C504
	msr cpsr_c,r2	; 0232C508
	and r0,r1,#0xc0	; 0232C50C
	bx lr	; 0232C510
.endfunc

; ===== function loc_0232C514 =====
; Returns the CPSR processor-mode bits. / 返回 CPSR 的处理器模式位。
.func P1_Arm9GetProcessorMode
loc_0232C514:
	mrs r0,cpsr	; 0232C514
	and r0,r0,#0x1f	; 0232C518
	bx lr	; 0232C51C
.endfunc

; ===== function loc_0232C520 =====
; ARM946 CP15 wait-for-interrupt helper. / ARM946 CP15 等待中断帮助例程。
.func P1_Arm9WaitForInterrupt
loc_0232C520:
	mov r0,#0x0	; 0232C520
	mcr p15,0x0,r0,c7,c0,0x4	; 0232C524
	bx lr	; 0232C528
.endfunc

; ===== function loc_0232C52C =====
; Decrements r0 by four until borrow. / 每次将 r0 减四，直至产生借位。
.func P1_Arm9BusyWaitByLoop4
loc_0232C52C:
	subs r0,r0,#0x4	; 0232C52C
	bcs loc_0232C52C	; 0232C530
	bx lr	; 0232C534
.endfunc
.thumb

; ===== function loc_0232C538 =====
loc_0232C538:
	push {lr}	; 0232C538
	sub sp,#0x4	; 0232C53A
loc_0232C53C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C53C
	blx P1_Arm9WaitForInterrupt	; 0232C540
	b loc_0232C53C	; 0232C544
	.byte 0x00, 0x00, 0x01, 0x1C, 0x02, 0x48, 0x06, 0x22, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFC	; 0232C556
	.byte 0x7F, 0x02, 0x14, 0xDF, 0x32, 0x02	; 0232C55C

; ===== function loc_0232C55C =====
loc_0232C55C:
	push {r4,lr}	; 0232C55C
	add r4,r1,#0x0	; 0232C55E
	ldr r1,[r4,#0x0]	; 0232C560
	cmp r1,#0x0	; 0232C562
	bne loc_0232C56A	; 0232C564
	bl loc_0232B260	; 0232C566
loc_0232C56A:
	ldr r0,[r4,#0x4]	; 0232C56A
	blx P1_Arm9RestoreIrqMask	; 0232C56C
	pop {r4}	; 0232C570
	pop {r3}	; 0232C572
	bx r3	; 0232C574
	.byte 0x00, 0x00	; 0232C578

; ===== function loc_0232C578 =====
loc_0232C578:
	push {r4,r5,r6,r7,lr}	; 0232C578
	sub sp,#0x4	; 0232C57A
	add r5,r0,#0x0	; 0232C57C
	add r4,r1,#0x0	; 0232C57E
	ldr r7,[pool_0232C5BC]	; 0232C580
	mov r6,#0x40	; 0232C582
loc_0232C584:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C584
	str r0,[r4,#0x4]	; 0232C588
	add r0,r7,#0x0	; 0232C58A
	bl loc_0232B308	; 0232C58C
	and r0,r6	; 0232C590
	str r0,[r4,#0x0]	; 0232C592
	ldr r0,[r4,#0x0]	; 0232C594
	cmp r0,#0x0	; 0232C596
	bne loc_0232C5B2	; 0232C598
	add r0,r5,#0x0	; 0232C59A
	bl loc_0232B390	; 0232C59C
	cmp r0,#0x0	; 0232C5A0
	beq loc_0232C5B2	; 0232C5A2
	ldr r0,[r4,#0x4]	; 0232C5A4
	blx P1_Arm9RestoreIrqMask	; 0232C5A6
	mov r0,#0x1	; 0232C5AA
	bl loc_0232C7B8	; 0232C5AC
	b loc_0232C584	; 0232C5B0
loc_0232C5B2:
	add sp,#0x4	; 0232C5B2
	pop {r4,r5,r6,r7}	; 0232C5B4
	pop {r3}	; 0232C5B6
	bx r3	; 0232C5B8
	.byte 0xC0, 0x46	; 0232C5BC
pool_0232C5BC:
loc_0232C5BC:
	.word 0x027FFFE8	; 0232C5BC

; ===== function loc_0232C5C0 =====
loc_0232C5C0:
	push {r4}	; 0232C5C0
	sub sp,#0x4	; 0232C5C2
	ldr r4,[r0,#0x0]	; 0232C5C4
	ldr r3,[pool_0232C5E8]	; 0232C5C6
	ldrh r2,[r3,#0x0]	; 0232C5C8
	mov r1,#0xc	; 0232C5CA
	bic r2,r1	; 0232C5CC
	lsl r1,r4,#0x2	; 0232C5CE
	orr r2,r1	; 0232C5D0
	strh r2,[r3,#0x0]	; 0232C5D2
	ldr r2,[r0,#0x4]	; 0232C5D4
	ldrh r1,[r3,#0x0]	; 0232C5D6
	mov r0,#0x10	; 0232C5D8
	bic r1,r0	; 0232C5DA
	lsl r0,r2,#0x4	; 0232C5DC
	orr r1,r0	; 0232C5DE
	strh r1,[r3,#0x0]	; 0232C5E0
	add sp,#0x4	; 0232C5E2
	pop {r4}	; 0232C5E4
	bx lr	; 0232C5E6
pool_0232C5E8:
loc_0232C5E8:
	.word REG_EXMEMCNT_ARM9	; 0232C5E8

; ===== function loc_0232C5EC =====
loc_0232C5EC:
	push {r4}	; 0232C5EC
	sub sp,#0x4	; 0232C5EE
	ldr r4,[pool_0232C61C]	; 0232C5F0
	ldrh r2,[r4,#0x0]	; 0232C5F2
	mov r1,#0xc	; 0232C5F4
	and r2,r1	; 0232C5F6
	asr r2,r2,#0x2	; 0232C5F8
	str r2,[r0,#0x0]	; 0232C5FA
	ldrh r3,[r4,#0x0]	; 0232C5FC
	mov r2,#0x10	; 0232C5FE
	and r3,r2	; 0232C600
	asr r3,r3,#0x4	; 0232C602
	str r3,[r0,#0x4]	; 0232C604
	ldrh r0,[r4,#0x0]	; 0232C606
	bic r0,r1	; 0232C608
	orr r0,r1	; 0232C60A
	strh r0,[r4,#0x0]	; 0232C60C
	ldrh r0,[r4,#0x0]	; 0232C60E
	bic r0,r2	; 0232C610
	strh r0,[r4,#0x0]	; 0232C612
	add sp,#0x4	; 0232C614
	pop {r4}	; 0232C616
	bx lr	; 0232C618
	.byte 0xC0, 0x46	; 0232C61C
pool_0232C61C:
loc_0232C61C:
	.word REG_EXMEMCNT_ARM9	; 0232C61C

; ===== function loc_0232C620 =====
loc_0232C620:
	push {r4,lr}	; 0232C620
	sub sp,#0x10	; 0232C622
	mov r4,#0x1	; 0232C624
	ldr r2,[pool_0232C6C4]	; 0232C626
	ldrh r1,[r2,#0x0]	; 0232C628
	ldr r0,[pool_0232C6C8]	; 0232C62A
	cmp r1,r0	; 0232C62C
	bne loc_0232C63A	; 0232C62E
	mov r0,#0x0	; 0232C630
	add sp,#0x10	; 0232C632
	pop {r4}	; 0232C634
	pop {r3}	; 0232C636
	bx r3	; 0232C638
loc_0232C63A:
	ldrb r0,[r2,#0x5]	; 0232C63A
	lsl r0,r0,#0x1e	; 0232C63C
	lsr r0,r0,#0x1f	; 0232C63E
	cmp r0,#0x1	; 0232C640
	bne loc_0232C64E	; 0232C642
	mov r0,#0x0	; 0232C644
	add sp,#0x10	; 0232C646
	pop {r4}	; 0232C648
	pop {r3}	; 0232C64A
	bx r3	; 0232C64C
loc_0232C64E:
	ldr r0,[pool_0232C6CC]	; 0232C64E
	ldrh r0,[r0,#0x2]	; 0232C650
	add r1,sp,#0x0	; 0232C652
	bl loc_0232C578	; 0232C654
	add r0,sp,#0x8	; 0232C658
	bl loc_0232C5EC	; 0232C65A
	ldr r2,[pool_0232C6D0]	; 0232C65E
	add r0,r2,#0x0	; 0232C660
	add r0,#0xb2	; 0232C662
	ldrb r3,[r0,#0x0]	; 0232C664
	cmp r3,#0x96	; 0232C666
	bne loc_0232C676	; 0232C668
	ldr r0,[pool_0232C6C4]	; 0232C66A
	ldrh r1,[r0,#0x0]	; 0232C66C
	add r2,#0xbe	; 0232C66E
	ldrh r0,[r2,#0x0]	; 0232C670
	cmp r1,r0	; 0232C672
	bne loc_0232C69E	; 0232C674
loc_0232C676:
	cmp r3,#0x96	; 0232C676
	beq loc_0232C686	; 0232C678
	ldr r0,[pool_0232C6C4]	; 0232C67A
	ldrh r1,[r0,#0x0]	; 0232C67C
	ldr r0,[pool_0232C6D4]	; 0232C67E
	ldrh r0,[r0,#0x0]	; 0232C680
	cmp r1,r0	; 0232C682
	bne loc_0232C69E	; 0232C684
loc_0232C686:
	ldr r2,[pool_0232C6C4]	; 0232C686
	ldr r1,[r2,#0x8]	; 0232C688
	ldr r0,[pool_0232C6D0]	; 0232C68A
	add r0,#0xac	; 0232C68C
	ldr r0,[r0,#0x0]	; 0232C68E
	cmp r1,r0	; 0232C690
	beq loc_0232C6AA	; 0232C692
	ldrb r0,[r2,#0x5]	; 0232C694
	lsl r0,r0,#0x1f	; 0232C696
	lsr r0,r0,#0x1f	; 0232C698
	cmp r0,#0x0	; 0232C69A
	beq loc_0232C6AA	; 0232C69C
loc_0232C69E:
	ldr r2,[pool_0232C6C4]	; 0232C69E
	ldrb r1,[r2,#0x5]	; 0232C6A0
	mov r0,#0x2	; 0232C6A2
	orr r1,r0	; 0232C6A4
	strb r1,[r2,#0x5]	; 0232C6A6
	mov r4,#0x0	; 0232C6A8
loc_0232C6AA:
	add r0,sp,#0x8	; 0232C6AA
	bl loc_0232C5C0	; 0232C6AC
	ldr r0,[pool_0232C6CC]	; 0232C6B0
	ldrh r0,[r0,#0x2]	; 0232C6B2
	add r1,sp,#0x0	; 0232C6B4
	bl loc_0232C55C	; 0232C6B6
	add r0,r4,#0x0	; 0232C6BA
	add sp,#0x10	; 0232C6BC
	pop {r4}	; 0232C6BE
	pop {r3}	; 0232C6C0
	bx r3	; 0232C6C2
pool_0232C6C4:
loc_0232C6C4:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C6C4
pool_0232C6C8:
loc_0232C6C8:
	.word 0x0000FFFF	; 0232C6C8
pool_0232C6CC:
loc_0232C6CC:
	.word P1_BssStart + 0x26688	; 0232C6CC
pool_0232C6D0:
loc_0232C6D0:
	.word 0x08000000	; 0232C6D0
pool_0232C6D4:
loc_0232C6D4:
	.word 0x0801FFFE	; 0232C6D4

; ===== function loc_0232C6D8 =====
loc_0232C6D8:
	push {lr}	; 0232C6D8
	sub sp,#0x4	; 0232C6DA
	ldr r2,[pool_0232C70C]	; 0232C6DC
	ldrh r1,[r2,#0x0]	; 0232C6DE
	ldr r0,[pool_0232C710]	; 0232C6E0
	cmp r1,r0	; 0232C6E2
	bne loc_0232C6EE	; 0232C6E4
	mov r0,#0x0	; 0232C6E6
	add sp,#0x4	; 0232C6E8
	pop {r3}	; 0232C6EA
	bx r3	; 0232C6EC
loc_0232C6EE:
	ldrb r0,[r2,#0x5]	; 0232C6EE
	lsl r0,r0,#0x1e	; 0232C6F0
	lsr r0,r0,#0x1f	; 0232C6F2
	cmp r0,#0x0	; 0232C6F4
	bne loc_0232C6FC	; 0232C6F6
	bl loc_0232C620	; 0232C6F8
loc_0232C6FC:
	ldr r0,[pool_0232C70C]	; 0232C6FC
	ldrb r0,[r0,#0x5]	; 0232C6FE
	lsl r0,r0,#0x1e	; 0232C700
	lsr r0,r0,#0x1f	; 0232C702
	add sp,#0x4	; 0232C704
	pop {r3}	; 0232C706
	bx r3	; 0232C708
	.byte 0xC0, 0x46	; 0232C70C
pool_0232C70C:
loc_0232C70C:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C70C
pool_0232C710:
loc_0232C710:
	.word 0x0000FFFF	; 0232C710

; ===== function loc_0232C714 =====
loc_0232C714:
	push {r4}	; 0232C714
	sub sp,#0x4	; 0232C716
	mov r4,#0x0	; 0232C718
	ldr r3,[pool_0232C73C]	; 0232C71A
	ldrh r2,[r3,#0x0]	; 0232C71C
	ldr r1,[pool_0232C740]	; 0232C71E
	cmp r2,r1	; 0232C720
	beq loc_0232C734	; 0232C722
	cmp r2,#0x0	; 0232C724
	beq loc_0232C734	; 0232C726
	ldrb r1,[r3,#0x0]	; 0232C728
	mvn r1,r1	; 0232C72A
	and r1,r0	; 0232C72C
	cmp r1,#0x0	; 0232C72E
	beq loc_0232C734	; 0232C730
	mov r4,#0x1	; 0232C732
loc_0232C734:
	add r0,r4,#0x0	; 0232C734
	add sp,#0x4	; 0232C736
	pop {r4}	; 0232C738
	bx lr	; 0232C73A
pool_0232C73C:
loc_0232C73C:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C73C
pool_0232C740:
loc_0232C740:
	.word 0x0000FFFF	; 0232C740

; ===== function loc_0232C744 =====
loc_0232C744:
	push {r4,lr}	; 0232C744
	add r4,r0,#0x0	; 0232C746
	bl loc_0232C620	; 0232C748
	cmp r0,#0x0	; 0232C74C
	beq loc_0232C762	; 0232C74E
	add r0,r4,#0x0	; 0232C750
	bl loc_0232C714	; 0232C752
	cmp r0,#0x0	; 0232C756
	beq loc_0232C762	; 0232C758
	mov r0,#0x1	; 0232C75A
	pop {r4}	; 0232C75C
	pop {r3}	; 0232C75E
	bx r3	; 0232C760
loc_0232C762:
	mov r0,#0x0	; 0232C762
	pop {r4}	; 0232C764
	pop {r3}	; 0232C766
	bx r3	; 0232C768
	.byte 0x00, 0x00	; 0232C76C

; ===== function loc_0232C76C =====
loc_0232C76C:
	push {lr}	; 0232C76C
	sub sp,#0x4	; 0232C76E
	mov r0,#0x0	; 0232C770
	str r0,[sp,#0x0]	; 0232C772
	add r0,sp,#0x0	; 0232C774
	ldr r1,[pool_0232C78C]	; 0232C776
	ldr r2,[pool_0232C790]	; 0232C778
	bl loc_0232C7D6	; 0232C77A
	blx loc_0232B270	; 0232C77E
	ldr r1,[pool_0232C78C]	; 0232C782
	strh r0,[r1,#0x2]	; 0232C784
	add sp,#0x4	; 0232C786
	pop {r3}	; 0232C788
	bx r3	; 0232C78A
pool_0232C78C:
loc_0232C78C:
	.word P1_BssStart + 0x26688	; 0232C78C
pool_0232C790:
loc_0232C790:
	.word 0x05000001	; 0232C790

; ===== function loc_0232C794 =====
loc_0232C794:
	push {lr}	; 0232C794
	sub sp,#0x4	; 0232C796
	ldr r0,[pool_0232C7B0]	; 0232C798
	ldr r1,[r0,#0x0]	; 0232C79A
	cmp r1,#0x0	; 0232C79C
	bne loc_0232C7A8	; 0232C79E
	mov r1,#0x1	; 0232C7A0
	str r1,[r0,#0x0]	; 0232C7A2
	bl loc_0232C76C	; 0232C7A4
loc_0232C7A8:
	add sp,#0x4	; 0232C7A8
	pop {r3}	; 0232C7AA
	bx r3	; 0232C7AC
	.byte 0xC0, 0x46	; 0232C7B0
pool_0232C7B0:
loc_0232C7B0:
	.word P1_BssStart + 0x2668C	; 0232C7B0
	.byte 0x00, 0xDF, 0x70, 0x47	; 0232C7B8

; ===== function loc_0232C7B8 =====
.func P1_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
loc_0232C7B8:
	swi 0x3	; 0232C7B8
	bx lr	; 0232C7BA
.endfunc
	.byte 0x00, 0x22, 0x04, 0xDF, 0x70, 0x47	; 0232C7C2

; ===== function loc_0232C7C2 =====
.func P1_SwiVBlankIntrWait
; BIOS SWI #05: wait for VBlank IRQ. / BIOS SWI #05：等待 VBlank 中断。
loc_0232C7C2:
	mov r2,#0x0	; 0232C7C2
	swi 0x5	; 0232C7C4
	bx lr	; 0232C7C6
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

; ===== function loc_0232C7D6 =====
.func P1_SwiCpuSet
; BIOS SWI #0B: CpuSet copy/fill. / BIOS SWI #0B：CpuSet 复制/填充。
loc_0232C7D6:
	swi 0xb	; 0232C7D6
	bx lr	; 0232C7D8
.endfunc

; ===== function loc_0232C7DA =====
.func P1_SwiCpuFastSet
; BIOS SWI #0C: CpuFastSet copy/fill. / BIOS SWI #0C：CpuFastSet 复制/填充。
loc_0232C7DA:
	swi 0xc	; 0232C7DA
	bx lr	; 0232C7DC
.endfunc
.func P1_SwiSqrt
; BIOS SWI #0D: integer square root. / BIOS SWI #0D：整数平方根。
	swi 0xd
	bx lr
.endfunc

; ===== function loc_0232C7E2 =====
.func P1_SwiGetCrc16
; BIOS SWI #0E: CRC-16 service. / BIOS SWI #0E：CRC-16 服务。
loc_0232C7E2:
	swi 0xe	; 0232C7E2
	bx lr	; 0232C7E4
.endfunc
.func P1_SwiIsDebugger
; BIOS SWI #0F: detect debugger state. / BIOS SWI #0F：检测调试器状态。
	swi 0x0f
	bx lr
.endfunc

; ===== function loc_0232C7EA =====
.func P1_SwiBitUnPack
; BIOS SWI #10: BitUnPack decoder. / BIOS SWI #10：BitUnPack 解码器。
loc_0232C7EA:
	swi 0x10	; 0232C7EA
	bx lr	; 0232C7EC
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

; ===== function loc_0232C7F6 =====
.func P1_SwiHuffUnComp
; BIOS SWI #13: Huffman decoder. / BIOS SWI #13：Huffman 解码器。
loc_0232C7F6:
	swi 0x13	; 0232C7F6
	bx lr	; 0232C7F8
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
loc_0232C804:
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
loc_0232C878:
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
loc_0232C954:
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x10, 0xB4, 0x81, 0xB0, 0x00, 0x2A, 0x17, 0xD0, 0x04, 0x78, 0x40, 0x1C	; 0232C964
	.byte 0x0B, 0x78, 0x49, 0x1C, 0x9C, 0x42, 0x0E, 0xD0, 0x40, 0x1E, 0x02, 0x78, 0x48, 0x1E, 0x00, 0x78	; 0232C974
	.byte 0x82, 0x42, 0x04, 0xD2, 0x00, 0x20, 0xC0, 0x43, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x01, 0x20	; 0232C984
	.byte 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x52, 0x1E, 0x00, 0x2A, 0xE7, 0xD1, 0x00, 0x20, 0x01, 0xB0	; 0232C994
	.byte 0x10, 0xBC, 0x70, 0x47	; 0232C998

; Standard memset: fill r2 bytes at r0 with low byte of r1 and return original r0.
; 标准 memset：以 r1 低字节填充 r0 起始的 r2 字节，并返回原 r0。
P1_MemSet:
; ===== function loc_0232C998 =====
	push {r4,lr}	; 0232C998
	add r4,r0,#0x0	; 0232C99A
	bl P1_MemSetCore	; 0232C99C
	add r0,r4,#0x0	; 0232C9A0
	pop {r4}	; 0232C9A2
	pop {r3}	; 0232C9A4
	bx r3	; 0232C9A6

; ===== function loc_0232C9A8 =====
; Core byte/word fill loop; r0 advances to the end. / 核心字节/字填充循环；r0 前进至末尾。
P1_MemSetCore:
loc_0232C9A8:
	push {r4,r5}	; 0232C9A8
	lsl r1,r1,#0x18	; 0232C9AA
	lsr r1,r1,#0x18	; 0232C9AC
	cmp r2,#0x20	; 0232C9AE
	bcc loc_0232CA16	; 0232C9B0
	neg r4,r0	; 0232C9B2
	mov r3,#0x3	; 0232C9B4
	and r4,r3	; 0232C9B6
	cmp r4,#0x0	; 0232C9B8
	beq loc_0232C9CC	; 0232C9BA
	sub r2,r2,r4	; 0232C9BC
	lsl r3,r1,#0x18	; 0232C9BE
	lsr r3,r3,#0x18	; 0232C9C0
loc_0232C9C2:
	strb r3,[r0,#0x0]	; 0232C9C2
	add r0,r0,#0x1	; 0232C9C4
	sub r4,r4,#0x1	; 0232C9C6
	cmp r4,#0x0	; 0232C9C8
	bne loc_0232C9C2	; 0232C9CA
loc_0232C9CC:
	cmp r1,#0x0	; 0232C9CC
	beq loc_0232C9DC	; 0232C9CE
	lsl r5,r1,#0x8	; 0232C9D0
	lsl r4,r1,#0x18	; 0232C9D2
	lsl r3,r1,#0x10	; 0232C9D4
	orr r4,r3	; 0232C9D6
	orr r5,r4	; 0232C9D8
	orr r1,r5	; 0232C9DA
loc_0232C9DC:
	lsr r4,r2,#0x5	; 0232C9DC
	cmp r4,#0x0	; 0232C9DE
	beq loc_0232C9FE	; 0232C9E0
loc_0232C9E2:
	str r1,[r0,#0x0]	; 0232C9E2
	str r1,[r0,#0x4]	; 0232C9E4
	str r1,[r0,#0x8]	; 0232C9E6
	str r1,[r0,#0xc]	; 0232C9E8
	str r1,[r0,#0x10]	; 0232C9EA
	str r1,[r0,#0x14]	; 0232C9EC
	str r1,[r0,#0x18]	; 0232C9EE
	add r3,r0,#0x0	; 0232C9F0
	add r3,#0x1c	; 0232C9F2
	add r0,#0x20	; 0232C9F4
	str r1,[r3,#0x0]	; 0232C9F6
	sub r4,r4,#0x1	; 0232C9F8
	cmp r4,#0x0	; 0232C9FA
	bne loc_0232C9E2	; 0232C9FC
loc_0232C9FE:
	mov r3,#0x1f	; 0232C9FE
	add r4,r2,#0x0	; 0232CA00
	and r4,r3	; 0232CA02
	lsr r3,r4,#0x2	; 0232CA04
	cmp r3,#0x0	; 0232CA06
	beq loc_0232CA12	; 0232CA08
loc_0232CA0A:
	stmia r0!,{r1}	; 0232CA0A
	sub r3,r3,#0x1	; 0232CA0C
	cmp r3,#0x0	; 0232CA0E
	bne loc_0232CA0A	; 0232CA10
loc_0232CA12:
	mov r3,#0x3	; 0232CA12
	and r2,r3	; 0232CA14
loc_0232CA16:
	cmp r2,#0x0	; 0232CA16
	beq loc_0232CA28	; 0232CA18
	lsl r1,r1,#0x18	; 0232CA1A
	lsr r1,r1,#0x18	; 0232CA1C
loc_0232CA1E:
	strb r1,[r0,#0x0]	; 0232CA1E
	add r0,r0,#0x1	; 0232CA20
	sub r2,r2,#0x1	; 0232CA22
	cmp r2,#0x0	; 0232CA24
	bne loc_0232CA1E	; 0232CA26
loc_0232CA28:
	pop {r4,r5}	; 0232CA28
	bx lr	; 0232CA2A

; UTF-16 strchr: find a code unit, including the terminating NUL. / UTF-16 strchr：查找码元，包括结尾 NUL。
P1_Utf16StrChr:
; ===== function loc_0232CA2C =====
loc_0232CA2C:
	add r2,r0,#0x2	; 0232CA2C
	ldrh r0,[r0,#0x0]	; 0232CA2E
	cmp r0,#0x0	; 0232CA30
	beq loc_0232CA44	; 0232CA32
loc_0232CA34:
	cmp r0,r1	; 0232CA34
	bne loc_0232CA3C	; 0232CA36
	sub r0,r2,#0x2	; 0232CA38
	bx lr	; 0232CA3A
loc_0232CA3C:
	ldrh r0,[r2,#0x0]	; 0232CA3C
	add r2,r2,#0x2	; 0232CA3E
	cmp r0,#0x0	; 0232CA40
	bne loc_0232CA34	; 0232CA42
loc_0232CA44:
	cmp r1,#0x0	; 0232CA44
	beq loc_0232CA4C	; 0232CA46
	mov r0,#0x0	; 0232CA48
	bx lr	; 0232CA4A
loc_0232CA4C:
	sub r0,r2,#0x2	; 0232CA4C
	bx lr	; 0232CA4E

; UTF-16 bounded comparison. / UTF-16 定长字符串比较。
P1_Utf16StrNCmp:
; ===== function loc_0232CA50 =====
	push {r4}	; 0232CA50
	sub sp,#0x4	; 0232CA52
	cmp r2,#0x0	; 0232CA54
	beq loc_0232CA76	; 0232CA56
loc_0232CA58:
	ldrh r4,[r1,#0x0]	; 0232CA58
	add r1,r1,#0x2	; 0232CA5A
	ldrh r3,[r0,#0x0]	; 0232CA5C
	add r0,r0,#0x2	; 0232CA5E
	cmp r3,r4	; 0232CA60
	beq loc_0232CA6C	; 0232CA62
	sub r0,r3,r4	; 0232CA64
	add sp,#0x4	; 0232CA66
	pop {r4}	; 0232CA68
	bx lr	; 0232CA6A
loc_0232CA6C:
	cmp r3,#0x0	; 0232CA6C
	beq loc_0232CA76	; 0232CA6E
	sub r2,r2,#0x1	; 0232CA70
	cmp r2,#0x0	; 0232CA72
	bne loc_0232CA58	; 0232CA74
loc_0232CA76:
	mov r0,#0x0	; 0232CA76
	add sp,#0x4	; 0232CA78
	pop {r4}	; 0232CA7A
	bx lr	; 0232CA7C
	.byte 0x00, 0x00, 0x10, 0xB4, 0x81, 0xB0, 0x04, 0x1C, 0x22, 0x88, 0xA4, 0x1C, 0x00, 0x2A, 0xFB, 0xD1	; 0232CA8E
	.byte 0xA4, 0x1E, 0x23, 0x1C, 0x0A, 0x88, 0x89, 0x1C, 0x22, 0x80, 0xA4, 0x1C, 0x1A, 0x88, 0x00, 0x2A	; 0232CA9E
	.byte 0xF7, 0xD1, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x00, 0x00	; 0232CAA8

; UTF-16 bounded copy with NUL padding. / UTF-16 定长复制，结尾不足时补 NUL。
P1_Utf16StrNCpy:
; ===== function loc_0232CAA8 =====
loc_0232CAA8:
	push {r4,r5}	; 0232CAA8
	add r5,r0,#0x0	; 0232CAAA
	cmp r2,#0x0	; 0232CAAC
	beq loc_0232CADC	; 0232CAAE
loc_0232CAB0:
	add r4,r5,#0x0	; 0232CAB0
	ldrh r3,[r1,#0x0]	; 0232CAB2
	add r1,r1,#0x2	; 0232CAB4
	strh r3,[r5,#0x0]	; 0232CAB6
	add r5,r5,#0x2	; 0232CAB8
	ldrh r3,[r4,#0x0]	; 0232CABA
	cmp r3,#0x0	; 0232CABC
	bne loc_0232CAD6	; 0232CABE
	sub r2,r2,#0x1	; 0232CAC0
	cmp r2,#0x0	; 0232CAC2
	beq loc_0232CADC	; 0232CAC4
	mov r1,#0x0	; 0232CAC6
loc_0232CAC8:
	strh r1,[r5,#0x0]	; 0232CAC8
	add r5,r5,#0x2	; 0232CACA
	sub r2,r2,#0x1	; 0232CACC
	cmp r2,#0x0	; 0232CACE
	bne loc_0232CAC8	; 0232CAD0
	pop {r4,r5}	; 0232CAD2
	bx lr	; 0232CAD4
loc_0232CAD6:
	sub r2,r2,#0x1	; 0232CAD6
	cmp r2,#0x0	; 0232CAD8
	bne loc_0232CAB0	; 0232CADA
loc_0232CADC:
	pop {r4,r5}	; 0232CADC
	bx lr	; 0232CADE

; UTF-16 unbounded copy through the terminating NUL. / UTF-16 复制，直至结尾 NUL。
P1_Utf16StrCpy:
; ===== function loc_0232CAE0 =====
loc_0232CAE0:
	push {r4}	; 0232CAE0
	sub sp,#0x4	; 0232CAE2
	add r4,r0,#0x0	; 0232CAE4
loc_0232CAE6:
	add r3,r4,#0x0	; 0232CAE6
	ldrh r2,[r1,#0x0]	; 0232CAE8
	add r1,r1,#0x2	; 0232CAEA
	strh r2,[r4,#0x0]	; 0232CAEC
	add r4,r4,#0x2	; 0232CAEE
	ldrh r2,[r3,#0x0]	; 0232CAF0
	cmp r2,#0x0	; 0232CAF2
	bne loc_0232CAE6	; 0232CAF4
	add sp,#0x4	; 0232CAF6
	pop {r4}	; 0232CAF8
	bx lr	; 0232CAFA
; UTF-16 strlen: count code units before the terminating NUL. / UTF-16 strlen：统计结尾 NUL 前的码元数。
P1_Utf16StrLen:
; ===== function loc_0232CAFC =====
loc_0232CAFC:
	mov r1,#0x0	; 0232CAFC
	mvn r2,r1	; 0232CAFE
loc_0232CB00:
	add r2,r2,#0x1	; 0232CB00
	ldrh r1,[r0,#0x0]	; 0232CB02
	add r0,r0,#0x2	; 0232CB04
	cmp r1,#0x0	; 0232CB06
	bne loc_0232CB00	; 0232CB08
	add r0,r2,#0x0	; 0232CB0A
	bx lr	; 0232CB0C
	.hword 0x0000	; padding / 对齐填充。
.arm

; ===== function loc_0232CB10 =====
loc_0232CB10:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CB10
	mov r4,#0x0	; 0232CB14
	b loc_0232CB24	; 0232CB18
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 0232CB24
loc_0232CB24:
	orrs r5,r3,r2	; 0232CB24
	bne loc_0232CB34	; 0232CB28
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CB2C
	bx lr	; 0232CB30
loc_0232CB34:
	orrs r5,r1,r3	; 0232CB34
	bne loc_0232CBDC	; 0232CB38
	mov r1,r2	; 0232CB3C
	bl loc_0232CF4C	; 0232CB40
	cmp r4,#0x0	; 0232CB44
	movne r0,r1	; 0232CB48
	mov r1,#0x0	; 0232CB4C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CB50
	bx lr	; 0232CB54
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 0232CB68
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x03, 0x40, 0x21, 0xE0, 0xC4, 0x40, 0xA0, 0xE1, 0x84, 0x40, 0xA0, 0xE1	; 0232CB78
	.byte 0x02, 0x50, 0x93, 0xE1, 0x01, 0x00, 0x00, 0x1A, 0xF0, 0x58, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 0232CB88
	.byte 0xA0, 0x5F, 0xA0, 0xE1, 0x01, 0x50, 0x85, 0xE0, 0xA2, 0x6F, 0xA0, 0xE1, 0x03, 0x60, 0x86, 0xE0	; 0232CB98
	.byte 0x06, 0x60, 0x95, 0xE1, 0x06, 0x00, 0x00, 0x1A, 0x02, 0x10, 0xA0, 0xE1, 0x63, 0x00, 0x00, 0xEB	; 0232CBA8
	.byte 0x01, 0x40, 0x14, 0xE2, 0x01, 0x00, 0xA0, 0x11, 0xC0, 0x1F, 0xA0, 0xE1, 0xF0, 0x58, 0xBD, 0xE8	; 0232CBB8
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x00, 0x00, 0x51, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x00, 0x70, 0xE2	; 0232CBC8
	.byte 0x00, 0x10, 0xE1, 0xE2, 0x00, 0x00, 0x53, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x20, 0x72, 0xE2	; 0232CBD8
	.byte 0x00, 0x30, 0xE3, 0xE2	; 0232CBDC
loc_0232CBDC:
	orrs r5,r1,r0	; 0232CBDC
	beq loc_0232CD00	; 0232CBE0
	mov r5,#0x0	; 0232CBE4
	mov r6,#0x1	; 0232CBE8
	cmp r3,#0x0	; 0232CBEC
	bmi loc_0232CC08	; 0232CBF0
loc_0232CBF4:
	add r5,r5,#0x1	; 0232CBF4
	adds r2,r2,r2	; 0232CBF8
	adcs r3,r3,r3	; 0232CBFC
	bpl loc_0232CBF4	; 0232CC00
	add r6,r6,r5	; 0232CC04
loc_0232CC08:
	cmp r1,#0x0	; 0232CC08
	blt loc_0232CC28	; 0232CC0C
loc_0232CC10:
	cmp r6,#0x1	; 0232CC10
	beq loc_0232CC28	; 0232CC14
	sub r6,r6,#0x1	; 0232CC18
	adds r0,r0,r0	; 0232CC1C
	adcs r1,r1,r1	; 0232CC20
	bpl loc_0232CC10	; 0232CC24
loc_0232CC28:
	mov r7,#0x0	; 0232CC28
	mov r12,#0x0	; 0232CC2C
	mov r11,#0x0	; 0232CC30
	b loc_0232CC50	; 0232CC34
loc_0232CC38:
	orr r12,r12,#0x1	; 0232CC38
	subs r6,r6,#0x1	; 0232CC3C
	beq loc_0232CCA8	; 0232CC40
	adds r0,r0,r0	; 0232CC44
	adcs r1,r1,r1	; 0232CC48
	adcs r7,r7,r7	; 0232CC4C
loc_0232CC50:
	subs r0,r0,r2	; 0232CC50
	sbcs r1,r1,r3	; 0232CC54
	sbcs r7,r7,#0x0	; 0232CC58
	adds r12,r12,r12	; 0232CC5C
	adc r11,r11,r11	; 0232CC60
	cmp r7,#0x0	; 0232CC64
	bge loc_0232CC38	; 0232CC68
loc_0232CC6C:
	subs r6,r6,#0x1	; 0232CC6C
	beq loc_0232CCA0	; 0232CC70
	adds r0,r0,r0	; 0232CC74
	adcs r1,r1,r1	; 0232CC78
	adc r7,r7,r7	; 0232CC7C
	adds r0,r0,r2	; 0232CC80
	adcs r1,r1,r3	; 0232CC84
	adc r7,r7,#0x0	; 0232CC88
	adds r12,r12,r12	; 0232CC8C
	adc r11,r11,r11	; 0232CC90
	cmp r7,#0x0	; 0232CC94
	bge loc_0232CC38	; 0232CC98
	b loc_0232CC6C	; 0232CC9C
loc_0232CCA0:
	adds r0,r0,r2	; 0232CCA0
	adc r1,r1,r3	; 0232CCA4
loc_0232CCA8:
	ands r7,r4,#0x1	; 0232CCA8
	moveq r0,r12	; 0232CCAC
	moveq r1,r11	; 0232CCB0
	beq loc_0232CCE0	; 0232CCB4
	subs r7,r5,#0x20	; 0232CCB8
	movge r0,r1, lsr r7	; 0232CCBC
	bge loc_0232CD04	; 0232CCC0
	rsb r7,r5,#0x20	; 0232CCC4
	mov r0,r0, lsr r5	; 0232CCC8
	orr r0,r0,r1, lsl r7	; 0232CCCC
	mov r1,r1, lsr r5	; 0232CCD0
	b loc_0232CCE0	; 0232CCD4
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 0232CCE0
loc_0232CCE0:
	cmp r4,#0x0	; 0232CCE0
	blt loc_0232CCF0	; 0232CCE4
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CCE8
	bx lr	; 0232CCEC
loc_0232CCF0:
	rsbs r0,r0,#0x0	; 0232CCF0
	rsc r1,r1,#0x0	; 0232CCF4
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CCF8
	bx lr	; 0232CCFC
loc_0232CD00:
	mov r0,#0x0	; 0232CD00
loc_0232CD04:
	mov r1,#0x0	; 0232CD04
	cmp r4,#0x0	; 0232CD08
	blt loc_0232CCF0	; 0232CD0C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CD10
	bx lr	; 0232CD14

; ARM EABI 64-bit multiply (__aeabi_lmul); the bit pattern is identical for signed and unsigned operands. / ARM EABI 64 位乘法（__aeabi_lmul）；有符号与无符号操作数的位级结果相同。
P1_AeabiLmul:
; ===== function loc_0232CD18 =====
loc_0232CD18:
	stmdb sp!,{r4,r5,lr}	; 0232CD18
	umull r5,r4,r0,r2	; 0232CD1C
	mla r4,r0,r3,r4	; 0232CD20
	mla r4,r2,r1,r4	; 0232CD24
	mov r1,r4	; 0232CD28
	mov r0,r5	; 0232CD2C
	ldmia sp!,{r4,r5,lr}	; 0232CD30
	bx lr	; 0232CD34

; 32-bit signed division with remainder: r0 = quotient, r1 = remainder. / 32 位有符号除法及取余：r0 为商，r1 为余数。
P1_SignedDivMod:
; ===== function loc_0232CD38 =====
loc_0232CD38:
	eor r12,r0,r1	; 0232CD38
	and r12,r12,#0x80000000	; 0232CD3C
	cmp r0,#0x0	; 0232CD40
	rsblt r0,r0,#0x0	; 0232CD44
	addlt r12,r12,#0x1	; 0232CD48
	cmp r1,#0x0	; 0232CD4C
	rsblt r1,r1,#0x0	; 0232CD50
	beq loc_0232CF30	; 0232CD54
	cmp r0,r1	; 0232CD58
	movcc r1,r0	; 0232CD5C
	movcc r0,#0x0	; 0232CD60
	bcc loc_0232CF30	; 0232CD64
	mov r2,#0x1c	; 0232CD68
	mov r3,r0, lsr #0x4	; 0232CD6C
	cmp r1,r3, lsr #0xc	; 0232CD70
	suble r2,r2,#0x10	; 0232CD74
	movle r3,r3, lsr #0x10	; 0232CD78
	cmp r1,r3, lsr #0x4	; 0232CD7C
	suble r2,r2,#0x8	; 0232CD80
	movle r3,r3, lsr #0x8	; 0232CD84
	cmp r1,r3	; 0232CD88
	suble r2,r2,#0x4	; 0232CD8C
	movle r3,r3, lsr #0x4	; 0232CD90
	mov r0,r0, lsl r2	; 0232CD94
	rsb r1,r1,#0x0	; 0232CD98
	adds r0,r0,r0	; 0232CD9C
	add r2,r2,r2, lsl #0x1	; 0232CDA0
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CDA4PC:
	add pc,pc,r2, lsl #0x2	; 0232CDA4
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CDAC
loc_0232CDAC:
P1_DivisionDispatch_0232CDA4Steps:
	adcs r3,r1,r3, lsl #0x1	; 0232CDAC
	subcc r3,r3,r1	; 0232CDB0
	adcs r0,r0,r0	; 0232CDB4
	adcs r3,r1,r3, lsl #0x1	; 0232CDB8
	subcc r3,r3,r1	; 0232CDBC
	adcs r0,r0,r0	; 0232CDC0
	adcs r3,r1,r3, lsl #0x1	; 0232CDC4
	subcc r3,r3,r1	; 0232CDC8
	adcs r0,r0,r0	; 0232CDCC
	adcs r3,r1,r3, lsl #0x1	; 0232CDD0
	subcc r3,r3,r1	; 0232CDD4
	adcs r0,r0,r0	; 0232CDD8
loc_0232CDDC:
	adcs r3,r1,r3, lsl #0x1	; 0232CDDC
	subcc r3,r3,r1	; 0232CDE0
	adcs r0,r0,r0	; 0232CDE4
	adcs r3,r1,r3, lsl #0x1	; 0232CDE8
	subcc r3,r3,r1	; 0232CDEC
	adcs r0,r0,r0	; 0232CDF0
	adcs r3,r1,r3, lsl #0x1	; 0232CDF4
	subcc r3,r3,r1	; 0232CDF8
	adcs r0,r0,r0	; 0232CDFC
	adcs r3,r1,r3, lsl #0x1	; 0232CE00
	subcc r3,r3,r1	; 0232CE04
	adcs r0,r0,r0	; 0232CE08
loc_0232CE0C:
	adcs r3,r1,r3, lsl #0x1	; 0232CE0C
	subcc r3,r3,r1	; 0232CE10
	adcs r0,r0,r0	; 0232CE14
	adcs r3,r1,r3, lsl #0x1	; 0232CE18
	subcc r3,r3,r1	; 0232CE1C
	adcs r0,r0,r0	; 0232CE20
	adcs r3,r1,r3, lsl #0x1	; 0232CE24
	subcc r3,r3,r1	; 0232CE28
	adcs r0,r0,r0	; 0232CE2C
	adcs r3,r1,r3, lsl #0x1	; 0232CE30
	subcc r3,r3,r1	; 0232CE34
	adcs r0,r0,r0	; 0232CE38
	adcs r3,r1,r3, lsl #0x1	; 0232CE3C
	subcc r3,r3,r1	; 0232CE40
	adcs r0,r0,r0	; 0232CE44
	adcs r3,r1,r3, lsl #0x1	; 0232CE48
	subcc r3,r3,r1	; 0232CE4C
	adcs r0,r0,r0	; 0232CE50
	adcs r3,r1,r3, lsl #0x1	; 0232CE54
	subcc r3,r3,r1	; 0232CE58
	adcs r0,r0,r0	; 0232CE5C
	adcs r3,r1,r3, lsl #0x1	; 0232CE60
	subcc r3,r3,r1	; 0232CE64
	adcs r0,r0,r0	; 0232CE68
loc_0232CE6C:
	adcs r3,r1,r3, lsl #0x1	; 0232CE6C
	subcc r3,r3,r1	; 0232CE70
	adcs r0,r0,r0	; 0232CE74
	adcs r3,r1,r3, lsl #0x1	; 0232CE78
	subcc r3,r3,r1	; 0232CE7C
	adcs r0,r0,r0	; 0232CE80
	adcs r3,r1,r3, lsl #0x1	; 0232CE84
	subcc r3,r3,r1	; 0232CE88
	adcs r0,r0,r0	; 0232CE8C
	adcs r3,r1,r3, lsl #0x1	; 0232CE90
	subcc r3,r3,r1	; 0232CE94
	adcs r0,r0,r0	; 0232CE98
	adcs r3,r1,r3, lsl #0x1	; 0232CE9C
	subcc r3,r3,r1	; 0232CEA0
	adcs r0,r0,r0	; 0232CEA4
	adcs r3,r1,r3, lsl #0x1	; 0232CEA8
	subcc r3,r3,r1	; 0232CEAC
	adcs r0,r0,r0	; 0232CEB0
	adcs r3,r1,r3, lsl #0x1	; 0232CEB4
	subcc r3,r3,r1	; 0232CEB8
	adcs r0,r0,r0	; 0232CEBC
	adcs r3,r1,r3, lsl #0x1	; 0232CEC0
	subcc r3,r3,r1	; 0232CEC4
	adcs r0,r0,r0	; 0232CEC8
	adcs r3,r1,r3, lsl #0x1	; 0232CECC
	subcc r3,r3,r1	; 0232CED0
	adcs r0,r0,r0	; 0232CED4
	adcs r3,r1,r3, lsl #0x1	; 0232CED8
	subcc r3,r3,r1	; 0232CEDC
	adcs r0,r0,r0	; 0232CEE0
	adcs r3,r1,r3, lsl #0x1	; 0232CEE4
	subcc r3,r3,r1	; 0232CEE8
	adcs r0,r0,r0	; 0232CEEC
	adcs r3,r1,r3, lsl #0x1	; 0232CEF0
	subcc r3,r3,r1	; 0232CEF4
	adcs r0,r0,r0	; 0232CEF8
	adcs r3,r1,r3, lsl #0x1	; 0232CEFC
	subcc r3,r3,r1	; 0232CF00
	adcs r0,r0,r0	; 0232CF04
	adcs r3,r1,r3, lsl #0x1	; 0232CF08
	subcc r3,r3,r1	; 0232CF0C
	adcs r0,r0,r0	; 0232CF10
	adcs r3,r1,r3, lsl #0x1	; 0232CF14
	subcc r3,r3,r1	; 0232CF18
	adcs r0,r0,r0	; 0232CF1C
	adcs r3,r1,r3, lsl #0x1	; 0232CF20
	subcc r3,r3,r1	; 0232CF24
	adcs r0,r0,r0	; 0232CF28
P1_DivisionDispatch_0232CDA4End:
.if (P1_DivisionDispatch_0232CDA4Steps != P1_DivisionDispatch_0232CDA4PC + 8) || (P1_DivisionDispatch_0232CDA4End - P1_DivisionDispatch_0232CDA4Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232CF2C
loc_0232CF30:
	ands r3,r12,#0x80000000	; 0232CF30
	rsbne r0,r0,#0x0	; 0232CF34
	ands r3,r12,#0x1	; 0232CF38
	rsbne r1,r1,#0x0	; 0232CF3C
	bx lr	; 0232CF40

; 32-bit unsigned division with remainder; the first entry returns immediately for a zero divisor. / 32 位无符号除法及取余；除数为零时第一个入口直接返回。
P1_UnsignedDivMod:
; ===== function loc_0232CF44 =====
loc_0232CF44:
	cmp r1,#0x0	; 0232CF44
	bxeq lr	; 0232CF48

; ===== function loc_0232CF4C =====
loc_0232CF4C:
	cmp r0,r1	; 0232CF4C
	movcc r1,r0	; 0232CF50
	movcc r0,#0x0	; 0232CF54
	bxcc lr	; 0232CF58
	mov r2,#0x1c	; 0232CF5C
	mov r3,r0, lsr #0x4	; 0232CF60
	cmp r1,r3, lsr #0xc	; 0232CF64
	suble r2,r2,#0x10	; 0232CF68
	movle r3,r3, lsr #0x10	; 0232CF6C
	cmp r1,r3, lsr #0x4	; 0232CF70
	suble r2,r2,#0x8	; 0232CF74
	movle r3,r3, lsr #0x8	; 0232CF78
	cmp r1,r3	; 0232CF7C
	suble r2,r2,#0x4	; 0232CF80
	movle r3,r3, lsr #0x4	; 0232CF84
	mov r0,r0, lsl r2	; 0232CF88
	rsb r1,r1,#0x0	; 0232CF8C
	adds r0,r0,r0	; 0232CF90
	add r2,r2,r2, lsl #0x1	; 0232CF94
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CF98PC:
	add pc,pc,r2, lsl #0x2	; 0232CF98
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CFA0
loc_0232CFA0:
P1_DivisionDispatch_0232CF98Steps:
	adcs r3,r1,r3, lsl #0x1	; 0232CFA0
	subcc r3,r3,r1	; 0232CFA4
	adcs r0,r0,r0	; 0232CFA8
	adcs r3,r1,r3, lsl #0x1	; 0232CFAC
	subcc r3,r3,r1	; 0232CFB0
	adcs r0,r0,r0	; 0232CFB4
	adcs r3,r1,r3, lsl #0x1	; 0232CFB8
	subcc r3,r3,r1	; 0232CFBC
	adcs r0,r0,r0	; 0232CFC0
	adcs r3,r1,r3, lsl #0x1	; 0232CFC4
	subcc r3,r3,r1	; 0232CFC8
	adcs r0,r0,r0	; 0232CFCC
loc_0232CFD0:
	adcs r3,r1,r3, lsl #0x1	; 0232CFD0
	subcc r3,r3,r1	; 0232CFD4
	adcs r0,r0,r0	; 0232CFD8
	adcs r3,r1,r3, lsl #0x1	; 0232CFDC
	subcc r3,r3,r1	; 0232CFE0
	adcs r0,r0,r0	; 0232CFE4
	adcs r3,r1,r3, lsl #0x1	; 0232CFE8
	subcc r3,r3,r1	; 0232CFEC
	adcs r0,r0,r0	; 0232CFF0
	adcs r3,r1,r3, lsl #0x1	; 0232CFF4
	subcc r3,r3,r1	; 0232CFF8
	adcs r0,r0,r0	; 0232CFFC
loc_0232D000:
	adcs r3,r1,r3, lsl #0x1	; 0232D000
	subcc r3,r3,r1	; 0232D004
	adcs r0,r0,r0	; 0232D008
	adcs r3,r1,r3, lsl #0x1	; 0232D00C
	subcc r3,r3,r1	; 0232D010
	adcs r0,r0,r0	; 0232D014
	adcs r3,r1,r3, lsl #0x1	; 0232D018
	subcc r3,r3,r1	; 0232D01C
	adcs r0,r0,r0	; 0232D020
	adcs r3,r1,r3, lsl #0x1	; 0232D024
	subcc r3,r3,r1	; 0232D028
	adcs r0,r0,r0	; 0232D02C
	adcs r3,r1,r3, lsl #0x1	; 0232D030
	subcc r3,r3,r1	; 0232D034
	adcs r0,r0,r0	; 0232D038
	adcs r3,r1,r3, lsl #0x1	; 0232D03C
	subcc r3,r3,r1	; 0232D040
	adcs r0,r0,r0	; 0232D044
	adcs r3,r1,r3, lsl #0x1	; 0232D048
	subcc r3,r3,r1	; 0232D04C
	adcs r0,r0,r0	; 0232D050
	adcs r3,r1,r3, lsl #0x1	; 0232D054
	subcc r3,r3,r1	; 0232D058
	adcs r0,r0,r0	; 0232D05C
loc_0232D060:
	adcs r3,r1,r3, lsl #0x1	; 0232D060
	subcc r3,r3,r1	; 0232D064
	adcs r0,r0,r0	; 0232D068
	adcs r3,r1,r3, lsl #0x1	; 0232D06C
	subcc r3,r3,r1	; 0232D070
	adcs r0,r0,r0	; 0232D074
	adcs r3,r1,r3, lsl #0x1	; 0232D078
	subcc r3,r3,r1	; 0232D07C
	adcs r0,r0,r0	; 0232D080
	adcs r3,r1,r3, lsl #0x1	; 0232D084
	subcc r3,r3,r1	; 0232D088
	adcs r0,r0,r0	; 0232D08C
	adcs r3,r1,r3, lsl #0x1	; 0232D090
	subcc r3,r3,r1	; 0232D094
	adcs r0,r0,r0	; 0232D098
	adcs r3,r1,r3, lsl #0x1	; 0232D09C
	subcc r3,r3,r1	; 0232D0A0
	adcs r0,r0,r0	; 0232D0A4
	adcs r3,r1,r3, lsl #0x1	; 0232D0A8
	subcc r3,r3,r1	; 0232D0AC
	adcs r0,r0,r0	; 0232D0B0
	adcs r3,r1,r3, lsl #0x1	; 0232D0B4
	subcc r3,r3,r1	; 0232D0B8
	adcs r0,r0,r0	; 0232D0BC
	adcs r3,r1,r3, lsl #0x1	; 0232D0C0
	subcc r3,r3,r1	; 0232D0C4
	adcs r0,r0,r0	; 0232D0C8
	adcs r3,r1,r3, lsl #0x1	; 0232D0CC
	subcc r3,r3,r1	; 0232D0D0
	adcs r0,r0,r0	; 0232D0D4
	adcs r3,r1,r3, lsl #0x1	; 0232D0D8
	subcc r3,r3,r1	; 0232D0DC
	adcs r0,r0,r0	; 0232D0E0
	adcs r3,r1,r3, lsl #0x1	; 0232D0E4
	subcc r3,r3,r1	; 0232D0E8
	adcs r0,r0,r0	; 0232D0EC
	adcs r3,r1,r3, lsl #0x1	; 0232D0F0
	subcc r3,r3,r1	; 0232D0F4
	adcs r0,r0,r0	; 0232D0F8
	adcs r3,r1,r3, lsl #0x1	; 0232D0FC
	subcc r3,r3,r1	; 0232D100
	adcs r0,r0,r0	; 0232D104
	adcs r3,r1,r3, lsl #0x1	; 0232D108
	subcc r3,r3,r1	; 0232D10C
	adcs r0,r0,r0	; 0232D110
	adcs r3,r1,r3, lsl #0x1	; 0232D114
	subcc r3,r3,r1	; 0232D118
	adcs r0,r0,r0	; 0232D11C
P1_DivisionDispatch_0232CF98End:
.if (P1_DivisionDispatch_0232CF98Steps != P1_DivisionDispatch_0232CF98PC + 8) || (P1_DivisionDispatch_0232CF98End - P1_DivisionDispatch_0232CF98Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232D120
	bx lr	; 0232D124

; ===== function loc_0232D128 =====
loc_0232D128:
	stmdb sp!,{lr}	; 0232D128
	blx loc_0232D208	; 0232D12C
	mov r1,#0x0	; 0232D130
	str r1,[r0,#0x0]	; 0232D134
	blx loc_0232D210	; 0232D138
	mov r1,#0x0	; 0232D13C
	str r1,[r0,#0x4]	; 0232D140
	str r1,[r0,#0x8]	; 0232D144
	str r1,[r0,#0xc]	; 0232D148
	str r1,[r0,#0x10]	; 0232D14C
	str r1,[r0,#0x14]	; 0232D150
	ldmia sp!,{lr}	; 0232D154
	bx lr	; 0232D158
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x28, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232D16C
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232D17C
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 0232D18C
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 0232D19C
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x18, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232D1AC
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232D1BC
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 0232D1CC
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 0232D1D0
.thumb

; ===== function loc_0232D1D0 =====
loc_0232D1D0:
	add r3,r0,#0x0	; 0232D1D0
	cmp r0,#0x0	; 0232D1D2
	beq loc_0232D1E6	; 0232D1D4
	cmp r1,#0x0	; 0232D1D6
	beq loc_0232D1E6	; 0232D1D8
	mov r2,#0x0	; 0232D1DA
loc_0232D1DC:
	strb r2,[r3,#0x0]	; 0232D1DC
	add r3,r3,#0x1	; 0232D1DE
	sub r1,r1,#0x1	; 0232D1E0
	cmp r1,#0x0	; 0232D1E2
	bne loc_0232D1DC	; 0232D1E4
loc_0232D1E6:
	bx lr	; 0232D1E6

; ===== function loc_0232D1E8 =====
loc_0232D1E8:
	push {r4,lr}	; 0232D1E8
	ldr r4,[pool_0232D204]	; 0232D1EA
	b loc_0232D1F2	; 0232D1EC
loc_0232D1EE:
	blx r0	; 0232D1EE
	add r4,r4,#0x4	; 0232D1F0
loc_0232D1F2:
	cmp r4,#0x0	; 0232D1F2
	beq loc_0232D1FC	; 0232D1F4
	ldr r0,[r4,#0x0]	; 0232D1F6
	cmp r0,#0x0	; 0232D1F8
	bne loc_0232D1EE	; 0232D1FA
loc_0232D1FC:
	pop {r4}	; 0232D1FC
	pop {r3}	; 0232D1FE
	bx r3	; 0232D200
	.byte 0xC0, 0x46	; 0232D204
pool_0232D204:
loc_0232D204:
	.word 0x02330584	; 0232D204

; ===== function loc_0232D208 =====
loc_0232D208:
	ldr r0,[pool_0232D20C]	; 0232D208
	bx lr	; 0232D20A
pool_0232D20C:
loc_0232D20C:
	.word 0x02357110	; 0232D20C

; ===== function loc_0232D210 =====
loc_0232D210:
	ldr r0,[pool_0232D214]	; 0232D210
	bx lr	; 0232D212
pool_0232D214:
loc_0232D214:
	.word 0x02357114	; 0232D214

; ===== function loc_0232D218 =====
loc_0232D218:
	stmia r0!,{r1}	; 0232D218
	mov r1,#0x0	; 0232D21A
	str r2,[r0,#0x8]	; 0232D21C
	mov r2,#0x0	; 0232D21E
	stmia r0!,{r1,r2}	; 0232D220
	bx lr	; 0232D222

; ===== function loc_0232D224 =====
loc_0232D224:
	str r2,[r0,#0x0]	; 0232D224
	str r1,[r0,#0x4]	; 0232D226
	neg r1,r1	; 0232D228
	str r1,[r0,#0x8]	; 0232D22A
	str r2,[r0,#0xc]	; 0232D22C
	bx lr	; 0232D22E

; ===== function loc_0232D230 =====
loc_0232D230:
	push {r4,r5,r6,r7,lr}	; 0232D230
	sub sp,#0x54	; 0232D232
	add r6,r0,#0x0	; 0232D234
	add r5,r1,#0x0	; 0232D236
	add r7,r2,#0x0	; 0232D238
	cmp r7,r5	; 0232D23A
	bne loc_0232D242	; 0232D23C
	add r4,sp,#0x40	; 0232D23E
	b loc_0232D244	; 0232D240
loc_0232D242:
	add r4,r7,#0x0	; 0232D242
loc_0232D244:
	ldr r0,[r6,#0x0]	; 0232D244
	str r0,[sp,#0x10]	; 0232D246
	ldr r0,[r6,#0x4]	; 0232D248
	str r0,[sp,#0x14]	; 0232D24A
	asr r0,r0,#0x1f	; 0232D24C
	str r0,[sp,#0x18]	; 0232D24E
	ldr r0,[sp,#0x10]	; 0232D250
	asr r0,r0,#0x1f	; 0232D252
	str r0,[sp,#0x1c]	; 0232D254
	ldr r0,[sp,#0x10]	; 0232D256
	ldr r1,[sp,#0x1c]	; 0232D258
	ldr r2,[r5,#0x0]	; 0232D25A
	asr r3,r2,#0x1f	; 0232D25C
	blx P1_AeabiLmul	; 0232D25E
	str r0,[sp,#0x20]	; 0232D262
	str r1,[sp,#0xc]	; 0232D264
	ldr r0,[sp,#0x14]	; 0232D266
	ldr r1,[sp,#0x18]	; 0232D268
	ldr r2,[r5,#0x8]	; 0232D26A
	asr r3,r2,#0x1f	; 0232D26C
	blx P1_AeabiLmul	; 0232D26E
	ldr r2,[sp,#0x20]	; 0232D272
	add r0,r2,r0	; 0232D274
	ldr r2,[sp,#0xc]	; 0232D276
	adc r2,r1	; 0232D278
	str r2,[sp,#0xc]	; 0232D27A
	lsl r1,r2,#0x14	; 0232D27C
	lsr r0,r0,#0xc	; 0232D27E
	orr r0,r1	; 0232D280
	str r0,[r4,#0x0]	; 0232D282
	ldr r0,[sp,#0x10]	; 0232D284
	ldr r1,[sp,#0x1c]	; 0232D286
	ldr r2,[r5,#0x4]	; 0232D288
	asr r3,r2,#0x1f	; 0232D28A
	blx P1_AeabiLmul	; 0232D28C
	str r0,[sp,#0x24]	; 0232D290
	str r1,[sp,#0x4]	; 0232D292
	ldr r0,[sp,#0x14]	; 0232D294
	ldr r1,[sp,#0x18]	; 0232D296
	ldr r2,[r5,#0xc]	; 0232D298
	asr r3,r2,#0x1f	; 0232D29A
	blx P1_AeabiLmul	; 0232D29C
	ldr r2,[sp,#0x24]	; 0232D2A0
	add r0,r2,r0	; 0232D2A2
	ldr r2,[sp,#0x4]	; 0232D2A4
	adc r2,r1	; 0232D2A6
	str r2,[sp,#0x4]	; 0232D2A8
	lsl r1,r2,#0x14	; 0232D2AA
	lsr r0,r0,#0xc	; 0232D2AC
	orr r0,r1	; 0232D2AE
	str r0,[r4,#0x4]	; 0232D2B0
	ldr r0,[r6,#0xc]	; 0232D2B2
	str r0,[sp,#0x28]	; 0232D2B4
	asr r0,r0,#0x1f	; 0232D2B6
	str r0,[sp,#0x2c]	; 0232D2B8
	ldr r0,[r6,#0x8]	; 0232D2BA
	str r0,[sp,#0x30]	; 0232D2BC
	asr r0,r0,#0x1f	; 0232D2BE
	str r0,[sp,#0x34]	; 0232D2C0
	ldr r0,[sp,#0x30]	; 0232D2C2
	ldr r1,[sp,#0x34]	; 0232D2C4
	ldr r2,[r5,#0x0]	; 0232D2C6
	asr r3,r2,#0x1f	; 0232D2C8
	blx P1_AeabiLmul	; 0232D2CA
	str r0,[sp,#0x38]	; 0232D2CE
	add r6,r1,#0x0	; 0232D2D0
	ldr r0,[sp,#0x28]	; 0232D2D2
	ldr r1,[sp,#0x2c]	; 0232D2D4
	ldr r2,[r5,#0x8]	; 0232D2D6
	asr r3,r2,#0x1f	; 0232D2D8
	blx P1_AeabiLmul	; 0232D2DA
	ldr r2,[sp,#0x38]	; 0232D2DE
	add r2,r2,r0	; 0232D2E0
	adc r6,r1	; 0232D2E2
	lsl r0,r6,#0x14	; 0232D2E4
	lsr r1,r2,#0xc	; 0232D2E6
	orr r1,r0	; 0232D2E8
	str r1,[r4,#0x8]	; 0232D2EA
	ldr r0,[sp,#0x30]	; 0232D2EC
	ldr r1,[sp,#0x34]	; 0232D2EE
	ldr r2,[r5,#0x4]	; 0232D2F0
	asr r3,r2,#0x1f	; 0232D2F2
	blx P1_AeabiLmul	; 0232D2F4
	str r0,[sp,#0x3c]	; 0232D2F8
	add r6,r1,#0x0	; 0232D2FA
	ldr r0,[sp,#0x28]	; 0232D2FC
	ldr r1,[sp,#0x2c]	; 0232D2FE
	ldr r2,[r5,#0xc]	; 0232D300
	asr r3,r2,#0x1f	; 0232D302
	blx P1_AeabiLmul	; 0232D304
	ldr r2,[sp,#0x3c]	; 0232D308
	add r2,r2,r0	; 0232D30A
	adc r6,r1	; 0232D30C
	lsl r0,r6,#0x14	; 0232D30E
	lsr r1,r2,#0xc	; 0232D310
	orr r1,r0	; 0232D312
	str r1,[r4,#0xc]	; 0232D314
	add r2,sp,#0x40	; 0232D316
	cmp r4,r2	; 0232D318
	bne loc_0232D324	; 0232D31A
	ldmia r2!,{r0,r1}	; 0232D31C
	stmia r7!,{r0,r1}	; 0232D31E
	ldmia r2!,{r0,r1}	; 0232D320
	stmia r7!,{r0,r1}	; 0232D322
loc_0232D324:
	add sp,#0x54	; 0232D324
	pop {r4,r5,r6,r7}	; 0232D326
	pop {r3}	; 0232D328
	bx r3	; 0232D32A

; ===== function loc_0232D32C =====
loc_0232D32C:
	push {r4}	; 0232D32C
	sub sp,#0x4	; 0232D32E
	mov r4,#0x0	; 0232D330
	ldr r3,[pool_0232D354]	; 0232D332
	strh r4,[r3,#0x0]	; 0232D334
	ldr r2,[pool_0232D358]	; 0232D336
	str r0,[r2,#0x0]	; 0232D338
	ldr r0,[pool_0232D35C]	; 0232D33A
	str r1,[r0,#0x0]	; 0232D33C
	str r4,[r0,#0x4]	; 0232D33E
	ldr r0,[pool_0232D360]	; 0232D340
loc_0232D342:
	ldrh r1,[r3,#0x0]	; 0232D342
	and r1,r0	; 0232D344
	cmp r1,#0x0	; 0232D346
	bne loc_0232D342	; 0232D348
	ldr r0,[pool_0232D364]	; 0232D34A
	ldr r0,[r0,#0x0]	; 0232D34C
	add sp,#0x4	; 0232D34E
	pop {r4}	; 0232D350
	bx lr	; 0232D352
pool_0232D354:
loc_0232D354:
	.word REG_DIVCNT	; 0232D354
pool_0232D358:
loc_0232D358:
	.word REG_DIV_NUMER	; 0232D358
pool_0232D35C:
loc_0232D35C:
	.word REG_DIV_DENOM	; 0232D35C
pool_0232D360:
loc_0232D360:
	.word 0x00008000	; 0232D360
pool_0232D364:
loc_0232D364:
	.word REG_DIV_RESULT	; 0232D364

; ===== function loc_0232D368 =====
loc_0232D368:
	mov r2,#0x1	; 0232D368
	ldr r1,[pool_0232D380]	; 0232D36A
	strh r2,[r1,#0x0]	; 0232D36C
	mov r3,#0x0	; 0232D36E
	ldr r2,[pool_0232D384]	; 0232D370
	ldr r1,[pool_0232D388]	; 0232D372
	str r3,[r1,#0x0]	; 0232D374
	str r2,[r1,#0x4]	; 0232D376
	ldr r1,[pool_0232D38C]	; 0232D378
	str r0,[r1,#0x0]	; 0232D37A
	str r3,[r1,#0x4]	; 0232D37C
	bx lr	; 0232D37E
pool_0232D380:
loc_0232D380:
	.word REG_DIVCNT	; 0232D380
pool_0232D384:
loc_0232D384:
	.word 0x00001000	; 0232D384
pool_0232D388:
loc_0232D388:
	.word REG_DIV_NUMER	; 0232D388
pool_0232D38C:
loc_0232D38C:
	.word REG_DIV_DENOM	; 0232D38C

; ===== function loc_0232D390 =====
loc_0232D390:
	ldr r1,[pool_0232D3B4]	; 0232D390
	ldr r0,[pool_0232D3B8]	; 0232D392
loc_0232D394:
	ldrh r2,[r1,#0x0]	; 0232D394
	and r2,r0	; 0232D396
	cmp r2,#0x0	; 0232D398
	bne loc_0232D394	; 0232D39A
	ldr r0,[pool_0232D3BC]	; 0232D39C
	ldr r2,[r0,#0x0]	; 0232D39E
	ldr r3,[r0,#0x4]	; 0232D3A0
	mov r1,#0x0	; 0232D3A2
	ldr r0,[pool_0232D3C0]	; 0232D3A4
	add r0,r2,r0	; 0232D3A6
	adc r3,r1	; 0232D3A8
	lsl r1,r3,#0xc	; 0232D3AA
	lsr r0,r0,#0x14	; 0232D3AC
	orr r0,r1	; 0232D3AE
	bx lr	; 0232D3B0
	.byte 0xC0, 0x46	; 0232D3B4
pool_0232D3B4:
loc_0232D3B4:
	.word REG_DIVCNT	; 0232D3B4
pool_0232D3B8:
loc_0232D3B8:
	.word 0x00008000	; 0232D3B8
pool_0232D3BC:
loc_0232D3BC:
	.word REG_DIV_RESULT	; 0232D3BC
pool_0232D3C0:
loc_0232D3C0:
	.word 0x00080000	; 0232D3C0

; ===== function loc_0232D3C4 =====
loc_0232D3C4:
	push {lr}	; 0232D3C4
	sub sp,#0x4	; 0232D3C6
	bl loc_0232D368	; 0232D3C8
	bl loc_0232D390	; 0232D3CC
	add sp,#0x4	; 0232D3D0
	pop {r3}	; 0232D3D2
	bx r3	; 0232D3D4
	.byte 0x00, 0x00	; 0232D3D8
.arm

; ===== function loc_0232D3D8 =====
loc_0232D3D8:
	smull r2,r1,r0,r1	; 0232D3D8
	mov r0,#0x800	; 0232D3DC
	adds r0,r2,r0	; 0232D3E0
	adc r1,r1,#0x0	; 0232D3E4
	mov r0,r0, lsr #0xc	; 0232D3E8
	orr r0,r0,r1, lsl #0x14	; 0232D3EC
	bx lr	; 0232D3F0
.thumb

; ===== function loc_0232D3F4 =====
loc_0232D3F4:
	cmp r1,#0x0	; 0232D3F4
	bne loc_0232D3FE	; 0232D3F6
	mov r1,#0x0	; 0232D3F8
	strh r1,[r0,#0x0]	; 0232D3FA
	bx lr	; 0232D3FC
loc_0232D3FE:
	cmp r1,#0x0	; 0232D3FE
	ble loc_0232D40A	; 0232D400
	ldr r2,[pool_0232D414]	; 0232D402
	orr r1,r2	; 0232D404
	strh r1,[r0,#0x0]	; 0232D406
	bx lr	; 0232D408
loc_0232D40A:
	neg r2,r1	; 0232D40A
	ldr r1,[pool_0232D418]	; 0232D40C
	orr r2,r1	; 0232D40E
	strh r2,[r0,#0x0]	; 0232D410
	bx lr	; 0232D412
pool_0232D414:
loc_0232D414:
	.word 0x00004000	; 0232D414
pool_0232D418:
loc_0232D418:
	.word 0x00008000	; 0232D418

; ===== function loc_0232D41C =====
loc_0232D41C:
	ldr r2,[pool_0232D42C]	; 0232D41C
	ldr r3,[r2,#0x0]	; 0232D41E
	mov r1,#0x7	; 0232D420
	bic r3,r1	; 0232D422
	orr r3,r0	; 0232D424
	str r3,[r2,#0x0]	; 0232D426
	bx lr	; 0232D428
	.byte 0xC0, 0x46	; 0232D42C
pool_0232D42C:
loc_0232D42C:
	.word REG_DISPCNT_B	; 0232D42C

; ===== function loc_0232D430 =====
loc_0232D430:
	push {r4}	; 0232D430
	sub sp,#0x4	; 0232D432
	ldr r3,[pool_0232D46C]	; 0232D434
	ldr r3,[r3,#0x0]	; 0232D436
	ldr r4,[pool_0232D470]	; 0232D438
	strh r0,[r4,#0x0]	; 0232D43A
	ldr r4,[pool_0232D474]	; 0232D43C
	ldrh r4,[r4,#0x0]	; 0232D43E
	cmp r4,#0x0	; 0232D440
	bne loc_0232D446	; 0232D442
	mov r0,#0x0	; 0232D444
loc_0232D446:
	lsl r4,r2,#0x3	; 0232D446
	ldr r2,[pool_0232D478]	; 0232D448
	and r3,r2	; 0232D44A
	lsl r0,r0,#0x10	; 0232D44C
	orr r3,r0	; 0232D44E
	orr r1,r3	; 0232D450
	orr r4,r1	; 0232D452
	ldr r0,[pool_0232D46C]	; 0232D454
	str r4,[r0,#0x0]	; 0232D456
	ldr r0,[pool_0232D470]	; 0232D458
	ldrh r0,[r0,#0x0]	; 0232D45A
	cmp r0,#0x0	; 0232D45C
	bne loc_0232D466	; 0232D45E
	mov r1,#0x0	; 0232D460
	ldr r0,[pool_0232D474]	; 0232D462
	strh r1,[r0,#0x0]	; 0232D464
loc_0232D466:
	add sp,#0x4	; 0232D466
	pop {r4}	; 0232D468
	bx lr	; 0232D46A
pool_0232D46C:
loc_0232D46C:
	.word REG_DISPCNT_A	; 0232D46C
pool_0232D470:
loc_0232D470:
	.word P1_BssStart + 0x266AC	; 0232D470
pool_0232D474:
loc_0232D474:
	.word P1_Data_02330A5C	; 0232D474
pool_0232D478:
loc_0232D478:
	.word 0xFFF0FFF0	; 0232D478

; ===== function loc_0232D47C =====
loc_0232D47C:
	mov r1,#0x1	; 0232D47C
	ldr r0,[pool_0232D4A8]	; 0232D47E
	strh r1,[r0,#0x0]	; 0232D480
	ldr r0,[pool_0232D4AC]	; 0232D482
	ldrh r3,[r0,#0x0]	; 0232D484
	cmp r3,#0x0	; 0232D486
	beq loc_0232D49A	; 0232D488
	ldr r1,[pool_0232D4B0]	; 0232D48A
	ldr r2,[r1,#0x0]	; 0232D48C
	ldr r0,[pool_0232D4B4]	; 0232D48E
	and r2,r0	; 0232D490
	lsl r0,r3,#0x10	; 0232D492
	orr r2,r0	; 0232D494
	str r2,[r1,#0x0]	; 0232D496
	bx lr	; 0232D498
loc_0232D49A:
	ldr r1,[pool_0232D4B0]	; 0232D49A
	ldr r2,[r1,#0x0]	; 0232D49C
	ldr r0,[pool_0232D4B8]	; 0232D49E
	orr r2,r0	; 0232D4A0
	str r2,[r1,#0x0]	; 0232D4A2
	bx lr	; 0232D4A4
	.byte 0xC0, 0x46	; 0232D4A8
pool_0232D4A8:
loc_0232D4A8:
	.word P1_Data_02330A5C	; 0232D4A8
pool_0232D4AC:
loc_0232D4AC:
	.word P1_BssStart + 0x266AC	; 0232D4AC
pool_0232D4B0:
loc_0232D4B0:
	.word REG_DISPCNT_A	; 0232D4B0
pool_0232D4B4:
loc_0232D4B4:
	.word 0xFFFCFFFF	; 0232D4B4
pool_0232D4B8:
loc_0232D4B8:
	.word 0x00010000	; 0232D4B8

; ===== function loc_0232D4BC =====
loc_0232D4BC:
	ldr r1,[pool_0232D4DC]	; 0232D4BC
	ldr r0,[r1,#0x0]	; 0232D4BE
	mov r3,#0x0	; 0232D4C0
	ldr r2,[pool_0232D4E0]	; 0232D4C2
	strh r3,[r2,#0x0]	; 0232D4C4
	ldr r2,[pool_0232D4E4]	; 0232D4C6
	add r3,r0,#0x0	; 0232D4C8
	and r3,r2	; 0232D4CA
	lsr r3,r3,#0x10	; 0232D4CC
	ldr r2,[pool_0232D4E8]	; 0232D4CE
	strh r3,[r2,#0x0]	; 0232D4D0
	ldr r2,[pool_0232D4EC]	; 0232D4D2
	and r0,r2	; 0232D4D4
	str r0,[r1,#0x0]	; 0232D4D6
	bx lr	; 0232D4D8
	.byte 0xC0, 0x46	; 0232D4DC
pool_0232D4DC:
loc_0232D4DC:
	.word REG_DISPCNT_A	; 0232D4DC
pool_0232D4E0:
loc_0232D4E0:
	.word P1_Data_02330A5C	; 0232D4E0
pool_0232D4E4:
loc_0232D4E4:
	.word 0x00030000	; 0232D4E4
pool_0232D4E8:
loc_0232D4E8:
	.word P1_BssStart + 0x266AC	; 0232D4E8
pool_0232D4EC:
loc_0232D4EC:
	.word 0xFFFCFFFF	; 0232D4EC

; ===== function loc_0232D4F0 =====
loc_0232D4F0:
	ldr r2,[pool_0232D510]	; 0232D4F0
	ldrh r3,[r2,#0x0]	; 0232D4F2
	mov r1,#0x8	; 0232D4F4
	and r3,r1	; 0232D4F6
	cmp r0,#0x0	; 0232D4F8
	beq loc_0232D504	; 0232D4FA
	ldrh r0,[r2,#0x0]	; 0232D4FC
	orr r0,r1	; 0232D4FE
	strh r0,[r2,#0x0]	; 0232D500
	b loc_0232D50A	; 0232D502
loc_0232D504:
	ldrh r0,[r2,#0x0]	; 0232D504
	bic r0,r1	; 0232D506
	strh r0,[r2,#0x0]	; 0232D508
loc_0232D50A:
	add r0,r3,#0x0	; 0232D50A
	bx lr	; 0232D50C
	.byte 0xC0, 0x46	; 0232D510
pool_0232D510:
loc_0232D510:
	.word REG_DISPSTAT	; 0232D510

; ===== function loc_0232D514 =====
loc_0232D514:
	push {lr}	; 0232D514
	sub sp,#0xc	; 0232D516
	ldr r0,[pool_0232D58C]	; 0232D518
	ldrh r2,[r0,#0x0]	; 0232D51A
	ldr r1,[pool_0232D590]	; 0232D51C
	orr r2,r1	; 0232D51E
	strh r2,[r0,#0x0]	; 0232D520
	ldrh r2,[r0,#0x0]	; 0232D522
	ldr r1,[pool_0232D594]	; 0232D524
	and r2,r1	; 0232D526
	ldr r1,[pool_0232D598]	; 0232D528
	orr r2,r1	; 0232D52A
	strh r2,[r0,#0x0]	; 0232D52C
	ldrh r2,[r0,#0x0]	; 0232D52E
	mov r1,#0x1	; 0232D530
	orr r2,r1	; 0232D532
	strh r2,[r0,#0x0]	; 0232D534
	bl loc_0232D5D4	; 0232D536
	mov r1,#0x0	; 0232D53A
	ldr r0,[pool_0232D59C]	; 0232D53C
	strh r1,[r0,#0x0]	; 0232D53E
	ldr r0,[pool_0232D5A0]	; 0232D540
	str r1,[r0,#0x0]	; 0232D542
	str r1,[sp,#0x0]	; 0232D544
	ldr r0,[sp,#0x0]	; 0232D546
	ldr r1,[pool_0232D5A4]	; 0232D548
	mov r2,#0x60	; 0232D54A
	blx loc_0232DE4C	; 0232D54C
	mov r1,#0x0	; 0232D550
	ldr r0,[pool_0232D5A8]	; 0232D552
	strh r1,[r0,#0x0]	; 0232D554
	str r1,[sp,#0x4]	; 0232D556
	ldr r0,[sp,#0x4]	; 0232D558
	ldr r1,[pool_0232D5AC]	; 0232D55A
	mov r2,#0x70	; 0232D55C
	blx loc_0232DE4C	; 0232D55E
	ldr r0,[pool_0232D5B0]	; 0232D562
	ldr r1,[pool_0232D5B4]	; 0232D564
	strh r0,[r1,#0x0]	; 0232D566
	ldr r1,[pool_0232D5B8]	; 0232D568
	strh r0,[r1,#0x0]	; 0232D56A
	ldr r1,[pool_0232D5BC]	; 0232D56C
	strh r0,[r1,#0x0]	; 0232D56E
	ldr r1,[pool_0232D5C0]	; 0232D570
	strh r0,[r1,#0x0]	; 0232D572
	ldr r1,[pool_0232D5C4]	; 0232D574
	strh r0,[r1,#0x0]	; 0232D576
	ldr r1,[pool_0232D5C8]	; 0232D578
	strh r0,[r1,#0x0]	; 0232D57A
	ldr r1,[pool_0232D5CC]	; 0232D57C
	strh r0,[r1,#0x0]	; 0232D57E
	ldr r1,[pool_0232D5D0]	; 0232D580
	strh r0,[r1,#0x0]	; 0232D582
	add sp,#0xc	; 0232D584
	pop {r3}	; 0232D586
	bx r3	; 0232D588
	.byte 0xC0, 0x46	; 0232D58C
pool_0232D58C:
loc_0232D58C:
	.word REG_POWERCNT	; 0232D58C
pool_0232D590:
loc_0232D590:
	.word 0x00008000	; 0232D590
pool_0232D594:
loc_0232D594:
	.word 0xFFFFFDF1	; 0232D594
pool_0232D598:
loc_0232D598:
	.word 0x0000020E	; 0232D598
pool_0232D59C:
loc_0232D59C:
	.word REG_DISPSTAT	; 0232D59C
pool_0232D5A0:
loc_0232D5A0:
	.word REG_DISPCNT_A	; 0232D5A0
pool_0232D5A4:
loc_0232D5A4:
	.word REG_BG0CNT	; 0232D5A4
pool_0232D5A8:
loc_0232D5A8:
	.word REG_MASTER_BRIGHT	; 0232D5A8
pool_0232D5AC:
loc_0232D5AC:
	.word REG_DISPCNT_B	; 0232D5AC
pool_0232D5B0:
loc_0232D5B0:
	.word 0x00000100	; 0232D5B0
pool_0232D5B4:
loc_0232D5B4:
	.word REG_BG2PA	; 0232D5B4
pool_0232D5B8:
loc_0232D5B8:
	.word REG_BG2PD	; 0232D5B8
pool_0232D5BC:
loc_0232D5BC:
	.word REG_BG3PA	; 0232D5BC
pool_0232D5C0:
loc_0232D5C0:
	.word REG_BG3PD	; 0232D5C0
pool_0232D5C4:
loc_0232D5C4:
	.word REG_BG2PA_SUB	; 0232D5C4
pool_0232D5C8:
loc_0232D5C8:
	.word REG_BG2PD_SUB	; 0232D5C8
pool_0232D5CC:
loc_0232D5CC:
	.word REG_BG3PA_SUB	; 0232D5CC
pool_0232D5D0:
loc_0232D5D0:
	.word REG_BG3PD_SUB	; 0232D5D0

; ===== function loc_0232D5D4 =====
loc_0232D5D4:
	mov r1,#0x0	; 0232D5D4
	ldr r0,[pool_0232D608]	; 0232D5D6
	strh r1,[r0,#0x0]	; 0232D5D8
	strh r1,[r0,#0x2]	; 0232D5DA
	strh r1,[r0,#0x4]	; 0232D5DC
	strh r1,[r0,#0x6]	; 0232D5DE
	strh r1,[r0,#0x8]	; 0232D5E0
	strh r1,[r0,#0xa]	; 0232D5E2
	strh r1,[r0,#0xc]	; 0232D5E4
	strh r1,[r0,#0xe]	; 0232D5E6
	strh r1,[r0,#0x10]	; 0232D5E8
	strh r1,[r0,#0x12]	; 0232D5EA
	strh r1,[r0,#0x14]	; 0232D5EC
	strh r1,[r0,#0x16]	; 0232D5EE
	strh r1,[r0,#0x18]	; 0232D5F0
	ldr r0,[pool_0232D60C]	; 0232D5F2
	str r1,[r0,#0x0]	; 0232D5F4
	ldr r0,[pool_0232D610]	; 0232D5F6
	strb r1,[r0,#0x0]	; 0232D5F8
	ldr r0,[pool_0232D614]	; 0232D5FA
	strb r1,[r0,#0x0]	; 0232D5FC
	ldr r0,[pool_0232D618]	; 0232D5FE
	strb r1,[r0,#0x0]	; 0232D600
	ldr r0,[pool_0232D61C]	; 0232D602
	strh r1,[r0,#0x0]	; 0232D604
	bx lr	; 0232D606
pool_0232D608:
loc_0232D608:
	.word P1_BssStart + 0x266B0	; 0232D608
pool_0232D60C:
loc_0232D60C:
	.word VRAM_A_CR	; 0232D60C
pool_0232D610:
loc_0232D610:
	.word VRAM_E_CR	; 0232D610
pool_0232D614:
loc_0232D614:
	.word VRAM_F_CR	; 0232D614
pool_0232D618:
loc_0232D618:
	.word VRAM_G_CR	; 0232D618
pool_0232D61C:
loc_0232D61C:
	.word VRAM_H_CR	; 0232D61C

; ===== function loc_0232D620 =====
loc_0232D620:
	ldr r0,[pool_0232D628]	; 0232D620
	ldr r3,[pool_0232D62C]	; 0232D622
	bx r3	; 0232D624
	.byte 0xC0, 0x46	; 0232D628
pool_0232D628:
loc_0232D628:
	.word 0x02357144	; 0232D628
pool_0232D62C:
loc_0232D62C:
	.word loc_0232D680 + 1	; 0232D62C

; ===== function loc_0232D630 =====
loc_0232D630:
	ldr r0,[pool_0232D638]	; 0232D630
	ldr r3,[pool_0232D63C]	; 0232D632
	bx r3	; 0232D634
	.byte 0xC0, 0x46	; 0232D638
pool_0232D638:
loc_0232D638:
	.word 0x02357142	; 0232D638
pool_0232D63C:
loc_0232D63C:
	.word loc_0232D680 + 1	; 0232D63C

; ===== function loc_0232D640 =====
loc_0232D640:
	ldr r0,[pool_0232D648]	; 0232D640
	ldr r3,[pool_0232D64C]	; 0232D642
	bx r3	; 0232D644
	.byte 0xC0, 0x46	; 0232D648
pool_0232D648:
loc_0232D648:
	.word 0x02357130	; 0232D648
pool_0232D64C:
loc_0232D64C:
	.word loc_0232D680 + 1	; 0232D64C

; ===== function loc_0232D650 =====
loc_0232D650:
	ldr r0,[pool_0232D658]	; 0232D650
	ldr r3,[pool_0232D65C]	; 0232D652
	bx r3	; 0232D654
	.byte 0xC0, 0x46	; 0232D658
pool_0232D658:
loc_0232D658:
	.word 0x02357136	; 0232D658
pool_0232D65C:
loc_0232D65C:
	.word loc_0232D680 + 1	; 0232D65C

; ===== function loc_0232D660 =====
loc_0232D660:
	ldr r0,[pool_0232D668]	; 0232D660
	ldr r3,[pool_0232D66C]	; 0232D662
	bx r3	; 0232D664
	.byte 0xC0, 0x46	; 0232D668
pool_0232D668:
loc_0232D668:
	.word 0x02357134	; 0232D668
pool_0232D66C:
loc_0232D66C:
	.word loc_0232D680 + 1	; 0232D66C

; ===== function loc_0232D670 =====
loc_0232D670:
	ldr r0,[pool_0232D678]	; 0232D670
	ldr r3,[pool_0232D67C]	; 0232D672
	bx r3	; 0232D674
	.byte 0xC0, 0x46	; 0232D678
pool_0232D678:
loc_0232D678:
	.word 0x02357132	; 0232D678
pool_0232D67C:
loc_0232D67C:
	.word loc_0232D680 + 1	; 0232D67C
loc_0232D680:
	ldrh r1,[r0,#0x0]	; 0232D680
	mov r3,#0x0	; 0232D682
	strh r3,[r0,#0x0]	; 0232D684
	mov r0,#0x1	; 0232D686
	add r2,r1,#0x0	; 0232D688
	and r2,r0	; 0232D68A
	cmp r2,#0x0	; 0232D68C
	beq loc_0232D694	; 0232D68E
	ldr r0,[pool_0232D718]	; 0232D690
	strb r3,[r0,#0x0]	; 0232D692
loc_0232D694:
	mov r0,#0x2	; 0232D694
	add r2,r1,#0x0	; 0232D696
	and r2,r0	; 0232D698
	cmp r2,#0x0	; 0232D69A
	beq loc_0232D6A4	; 0232D69C
	mov r2,#0x0	; 0232D69E
	ldr r0,[pool_0232D71C]	; 0232D6A0
	strb r2,[r0,#0x0]	; 0232D6A2
loc_0232D6A4:
	mov r0,#0x4	; 0232D6A4
	add r2,r1,#0x0	; 0232D6A6
	and r2,r0	; 0232D6A8
	cmp r2,#0x0	; 0232D6AA
	beq loc_0232D6B4	; 0232D6AC
	mov r2,#0x0	; 0232D6AE
	ldr r0,[pool_0232D720]	; 0232D6B0
	strb r2,[r0,#0x0]	; 0232D6B2
loc_0232D6B4:
	mov r0,#0x8	; 0232D6B4
	add r2,r1,#0x0	; 0232D6B6
	and r2,r0	; 0232D6B8
	cmp r2,#0x0	; 0232D6BA
	beq loc_0232D6C4	; 0232D6BC
	mov r2,#0x0	; 0232D6BE
	ldr r0,[pool_0232D724]	; 0232D6C0
	strb r2,[r0,#0x0]	; 0232D6C2
loc_0232D6C4:
	mov r0,#0x10	; 0232D6C4
	add r2,r1,#0x0	; 0232D6C6
	and r2,r0	; 0232D6C8
	cmp r2,#0x0	; 0232D6CA
	beq loc_0232D6D4	; 0232D6CC
	mov r2,#0x0	; 0232D6CE
	ldr r0,[pool_0232D728]	; 0232D6D0
	strb r2,[r0,#0x0]	; 0232D6D2
loc_0232D6D4:
	mov r0,#0x20	; 0232D6D4
	add r2,r1,#0x0	; 0232D6D6
	and r2,r0	; 0232D6D8
	cmp r2,#0x0	; 0232D6DA
	beq loc_0232D6E4	; 0232D6DC
	mov r2,#0x0	; 0232D6DE
	ldr r0,[pool_0232D72C]	; 0232D6E0
	strb r2,[r0,#0x0]	; 0232D6E2
loc_0232D6E4:
	mov r0,#0x40	; 0232D6E4
	add r2,r1,#0x0	; 0232D6E6
	and r2,r0	; 0232D6E8
	cmp r2,#0x0	; 0232D6EA
	beq loc_0232D6F4	; 0232D6EC
	mov r2,#0x0	; 0232D6EE
	ldr r0,[pool_0232D730]	; 0232D6F0
	strb r2,[r0,#0x0]	; 0232D6F2
loc_0232D6F4:
	mov r0,#0x80	; 0232D6F4
	add r2,r1,#0x0	; 0232D6F6
	and r2,r0	; 0232D6F8
	cmp r2,#0x0	; 0232D6FA
	beq loc_0232D704	; 0232D6FC
	mov r2,#0x0	; 0232D6FE
	ldr r0,[pool_0232D734]	; 0232D700
	strb r2,[r0,#0x0]	; 0232D702
loc_0232D704:
	ldr r0,[pool_0232D738]	; 0232D704
	add r2,r1,#0x0	; 0232D706
	and r2,r0	; 0232D708
	cmp r2,#0x0	; 0232D70A
	beq loc_0232D714	; 0232D70C
	mov r2,#0x0	; 0232D70E
	ldr r0,[pool_0232D73C]	; 0232D710
	strb r2,[r0,#0x0]	; 0232D712
loc_0232D714:
	add r0,r1,#0x0	; 0232D714
	bx lr	; 0232D716
pool_0232D718:
loc_0232D718:
	.word VRAM_A_CR	; 0232D718
pool_0232D71C:
loc_0232D71C:
	.word VRAM_B_CR	; 0232D71C
pool_0232D720:
loc_0232D720:
	.word VRAM_C_CR	; 0232D720
pool_0232D724:
loc_0232D724:
	.word VRAM_D_CR	; 0232D724
pool_0232D728:
loc_0232D728:
	.word VRAM_E_CR	; 0232D728
pool_0232D72C:
loc_0232D72C:
	.word VRAM_F_CR	; 0232D72C
pool_0232D730:
loc_0232D730:
	.word VRAM_G_CR	; 0232D730
pool_0232D734:
loc_0232D734:
	.word VRAM_H_CR	; 0232D734
pool_0232D738:
loc_0232D738:
	.word 0x00000100	; 0232D738
pool_0232D73C:
loc_0232D73C:
	.word VRAM_I_CR	; 0232D73C

; ===== function loc_0232D740 =====
loc_0232D740:
	ldr r1,[pool_0232D74C]	; 0232D740
	ldrh r2,[r1,#0x0]	; 0232D742
	orr r2,r0	; 0232D744
	strh r2,[r1,#0x0]	; 0232D746
	ldr r3,[pool_0232D750]	; 0232D748
	bx r3	; 0232D74A
pool_0232D74C:
loc_0232D74C:
	.word P1_BssStart + 0x266B0	; 0232D74C
pool_0232D750:
loc_0232D750:
	.word loc_0232D754 + 1	; 0232D750

; ===== function loc_0232D754 =====
loc_0232D754:
	mov r1,#0x1	; 0232D754
	add r2,r0,#0x0	; 0232D756
	and r2,r1	; 0232D758
	cmp r2,#0x0	; 0232D75A
	beq loc_0232D764	; 0232D75C
	mov r2,#0x80	; 0232D75E
	ldr r1,[pool_0232D7E4]	; 0232D760
	strb r2,[r1,#0x0]	; 0232D762
loc_0232D764:
	mov r1,#0x2	; 0232D764
	add r2,r0,#0x0	; 0232D766
	and r2,r1	; 0232D768
	cmp r2,#0x0	; 0232D76A
	beq loc_0232D774	; 0232D76C
	mov r2,#0x80	; 0232D76E
	ldr r1,[pool_0232D7E8]	; 0232D770
	strb r2,[r1,#0x0]	; 0232D772
loc_0232D774:
	mov r1,#0x4	; 0232D774
	add r2,r0,#0x0	; 0232D776
	and r2,r1	; 0232D778
	cmp r2,#0x0	; 0232D77A
	beq loc_0232D784	; 0232D77C
	mov r2,#0x80	; 0232D77E
	ldr r1,[pool_0232D7EC]	; 0232D780
	strb r2,[r1,#0x0]	; 0232D782
loc_0232D784:
	mov r1,#0x8	; 0232D784
	add r2,r0,#0x0	; 0232D786
	and r2,r1	; 0232D788
	cmp r2,#0x0	; 0232D78A
	beq loc_0232D794	; 0232D78C
	mov r2,#0x80	; 0232D78E
	ldr r1,[pool_0232D7F0]	; 0232D790
	strb r2,[r1,#0x0]	; 0232D792
loc_0232D794:
	mov r1,#0x10	; 0232D794
	add r2,r0,#0x0	; 0232D796
	and r2,r1	; 0232D798
	cmp r2,#0x0	; 0232D79A
	beq loc_0232D7A4	; 0232D79C
	mov r2,#0x80	; 0232D79E
	ldr r1,[pool_0232D7F4]	; 0232D7A0
	strb r2,[r1,#0x0]	; 0232D7A2
loc_0232D7A4:
	mov r1,#0x20	; 0232D7A4
	add r2,r0,#0x0	; 0232D7A6
	and r2,r1	; 0232D7A8
	cmp r2,#0x0	; 0232D7AA
	beq loc_0232D7B4	; 0232D7AC
	mov r2,#0x80	; 0232D7AE
	ldr r1,[pool_0232D7F8]	; 0232D7B0
	strb r2,[r1,#0x0]	; 0232D7B2
loc_0232D7B4:
	mov r1,#0x40	; 0232D7B4
	add r2,r0,#0x0	; 0232D7B6
	and r2,r1	; 0232D7B8
	cmp r2,#0x0	; 0232D7BA
	beq loc_0232D7C4	; 0232D7BC
	mov r2,#0x80	; 0232D7BE
	ldr r1,[pool_0232D7FC]	; 0232D7C0
	strb r2,[r1,#0x0]	; 0232D7C2
loc_0232D7C4:
	mov r2,#0x80	; 0232D7C4
	add r1,r0,#0x0	; 0232D7C6
	and r1,r2	; 0232D7C8
	cmp r1,#0x0	; 0232D7CA
	beq loc_0232D7D2	; 0232D7CC
	ldr r1,[pool_0232D800]	; 0232D7CE
	strb r2,[r1,#0x0]	; 0232D7D0
loc_0232D7D2:
	ldr r1,[pool_0232D804]	; 0232D7D2
	and r0,r1	; 0232D7D4
	cmp r0,#0x0	; 0232D7D6
	beq loc_0232D7E0	; 0232D7D8
	mov r1,#0x80	; 0232D7DA
	ldr r0,[pool_0232D808]	; 0232D7DC
	strb r1,[r0,#0x0]	; 0232D7DE
loc_0232D7E0:
	bx lr	; 0232D7E0
	.byte 0xC0, 0x46	; 0232D7E4
pool_0232D7E4:
loc_0232D7E4:
	.word VRAM_A_CR	; 0232D7E4
pool_0232D7E8:
loc_0232D7E8:
	.word VRAM_B_CR	; 0232D7E8
pool_0232D7EC:
loc_0232D7EC:
	.word VRAM_C_CR	; 0232D7EC
pool_0232D7F0:
loc_0232D7F0:
	.word VRAM_D_CR	; 0232D7F0
pool_0232D7F4:
loc_0232D7F4:
	.word VRAM_E_CR	; 0232D7F4
pool_0232D7F8:
loc_0232D7F8:
	.word VRAM_F_CR	; 0232D7F8
pool_0232D7FC:
loc_0232D7FC:
	.word VRAM_G_CR	; 0232D7FC
pool_0232D800:
loc_0232D800:
	.word VRAM_H_CR	; 0232D800
pool_0232D804:
loc_0232D804:
	.word 0x00000100	; 0232D804
pool_0232D808:
loc_0232D808:
	.word VRAM_I_CR	; 0232D808

; ===== function loc_0232D80C =====
; Returns the sub-engine BG1 character-base address.
; 返回副引擎 BG1 字符基址。
.func P1_GetSubBg1CharacterBase
loc_0232D80C:
	ldr r0,[pool_0232D820]	; 0232D80C
	ldrh r1,[r0,#0x0]	; 0232D80E
	mov r0,#0x3c	; 0232D810
	and r1,r0	; 0232D812
	asr r0,r1,#0x2	; 0232D814
	lsl r1,r0,#0xe	; 0232D816
	ldr r0,[pool_0232D824]	; 0232D818
	add r0,r1,r0	; 0232D81A
	bx lr	; 0232D81C
.endfunc
	.byte 0xC0, 0x46	; 0232D820
pool_0232D820:
loc_0232D820:
	.word REG_BG1CNT_SUB	; 0232D820
pool_0232D824:
loc_0232D824:
	.word 0x06200000	; 0232D824

; ===== function loc_0232D828 =====
; Returns the main-engine BG1 character-base address.
; 返回主引擎 BG1 字符基址。
.func P1_GetMainBg1CharacterBase
loc_0232D828:
	ldr r0,[pool_0232D848]	; 0232D828
	ldrh r1,[r0,#0x0]	; 0232D82A
	mov r0,#0x3c	; 0232D82C
	and r1,r0	; 0232D82E
	asr r0,r1,#0x2	; 0232D830
	lsl r2,r0,#0xe	; 0232D832
	ldr r0,[pool_0232D84C]	; 0232D834
	ldr r1,[r0,#0x0]	; 0232D836
	ldr r0,[pool_0232D850]	; 0232D838
	and r1,r0	; 0232D83A
	lsr r0,r1,#0x18	; 0232D83C
	lsl r1,r0,#0x10	; 0232D83E
	ldr r0,[pool_0232D854]	; 0232D840
	add r0,r1,r0	; 0232D842
	add r0,r2,r0	; 0232D844
	bx lr	; 0232D846
.endfunc
pool_0232D848:
loc_0232D848:
	.word REG_BG1CNT	; 0232D848
pool_0232D84C:
loc_0232D84C:
	.word REG_DISPCNT_A	; 0232D84C
pool_0232D850:
loc_0232D850:
	.word 0x07000000	; 0232D850
pool_0232D854:
loc_0232D854:
	.word 0x06000000	; 0232D854

; ===== function loc_0232D858 =====
; Returns the sub-engine BG0 character-base address.
; 返回副引擎 BG0 字符基址。
.func P1_GetSubBg0CharacterBase
loc_0232D858:
	ldr r0,[pool_0232D86C]	; 0232D858
	ldrh r1,[r0,#0x0]	; 0232D85A
	mov r0,#0x3c	; 0232D85C
	and r1,r0	; 0232D85E
	asr r0,r1,#0x2	; 0232D860
	lsl r1,r0,#0xe	; 0232D862
	ldr r0,[pool_0232D870]	; 0232D864
	add r0,r1,r0	; 0232D866
	bx lr	; 0232D868
.endfunc
	.byte 0xC0, 0x46	; 0232D86C
pool_0232D86C:
loc_0232D86C:
	.word REG_BG0CNT_SUB	; 0232D86C
pool_0232D870:
loc_0232D870:
	.word 0x06200000	; 0232D870
; ===== function loc_0232D884 =====
; Returns the main-engine BG0 character-base address.
; 返回主引擎 BG0 字符基址。
.func P1_GetMainBg0CharacterBase
loc_0232D884:
	ldr r0,[pool_0232D8A4]	; 0232D884
	ldrh r1,[r0,#0x0]	; 0232D886
	mov r0,#0x3c	; 0232D888
	and r1,r0	; 0232D88A
	asr r0,r1,#0x2	; 0232D88C
	lsl r2,r0,#0xe	; 0232D88E
	ldr r0,[pool_0232D8A8]	; 0232D890
	ldr r1,[r0,#0x0]	; 0232D892
	ldr r0,[pool_0232D8AC]	; 0232D894
	and r1,r0	; 0232D896
	lsr r0,r1,#0x18	; 0232D898
	lsl r1,r0,#0x10	; 0232D89A
	ldr r0,[pool_0232D8B0]	; 0232D89C
	add r0,r1,r0	; 0232D89E
	add r0,r2,r0	; 0232D8A0
	bx lr	; 0232D8A2
.endfunc
pool_0232D8A4:
	.word REG_BG0CNT	; 0232D8A4
pool_0232D8A8:
	.word REG_DISPCNT_A	; 0232D8A8
pool_0232D8AC:
	.word 0x07000000	; 0232D8AC
pool_0232D8B0:
	.word 0x06000000	; 0232D8B0

; ===== function loc_0232D8A4 =====
; Returns the sub-engine BG1 tilemap base from BG1CNT.
; 由 BG1CNT 返回副引擎 BG1 tilemap 基址。
.func P1_GetSubBg1TilemapBase
loc_0232D8A4:
	ldr r0,[pool_0232D8B8]	; 0232D8A4
	ldrh r1,[r0,#0x0]	; 0232D8A6
	ldr r0,[pool_0232D8BC]	; 0232D8A8
	and r1,r0	; 0232D8AA
	asr r0,r1,#0x8	; 0232D8AC
	lsl r1,r0,#0xb	; 0232D8AE
	ldr r0,[pool_0232D8C0]	; 0232D8B0
	add r0,r1,r0	; 0232D8B2
	bx lr	; 0232D8B4
.endfunc
	.byte 0xC0, 0x46	; 0232D8B8
pool_0232D8B8:
loc_0232D8B8:
	.word REG_BG1CNT_SUB	; 0232D8B8
pool_0232D8BC:
loc_0232D8BC:
	.word 0x00001F00	; 0232D8BC
pool_0232D8C0:
loc_0232D8C0:
	.word 0x06200000	; 0232D8C0

; ===== function loc_0232D8C4 =====
; Returns the main-engine BG1 tilemap base from BG1CNT and VRAM bank mode.
; 由 BG1CNT 与 VRAM bank 模式返回主引擎 BG1 tilemap 基址。
.func P1_GetMainBg1TilemapBase
loc_0232D8C4:
	ldr r0,[pool_0232D8E4]	; 0232D8C4
	ldrh r1,[r0,#0x0]	; 0232D8C6
	ldr r0,[pool_0232D8E8]	; 0232D8C8
	and r1,r0	; 0232D8CA
	asr r0,r1,#0x8	; 0232D8CC
	lsl r2,r0,#0xb	; 0232D8CE
	ldr r0,[pool_0232D8EC]	; 0232D8D0
	ldr r1,[r0,#0x0]	; 0232D8D2
	ldr r0,[pool_0232D8F0]	; 0232D8D4
	and r1,r0	; 0232D8D6
	lsr r0,r1,#0x1b	; 0232D8D8
	lsl r1,r0,#0x10	; 0232D8DA
	ldr r0,[pool_0232D8F4]	; 0232D8DC
	add r0,r1,r0	; 0232D8DE
	add r0,r2,r0	; 0232D8E0
	bx lr	; 0232D8E2
.endfunc
pool_0232D8E4:
loc_0232D8E4:
	.word REG_BG1CNT	; 0232D8E4
pool_0232D8E8:
loc_0232D8E8:
	.word 0x00001F00	; 0232D8E8
pool_0232D8EC:
loc_0232D8EC:
	.word REG_DISPCNT_A	; 0232D8EC
pool_0232D8F0:
loc_0232D8F0:
	.word 0x38000000	; 0232D8F0
pool_0232D8F4:
loc_0232D8F4:
	.word 0x06000000	; 0232D8F4

; ===== function loc_0232D8F8 =====
; Returns the sub-engine BG0 tilemap base from BG0CNT.
; 由 BG0CNT 返回副引擎 BG0 tilemap 基址。
.func P1_GetSubBg0TilemapBase
loc_0232D8F8:
	ldr r0,[pool_0232D90C]	; 0232D8F8
	ldrh r1,[r0,#0x0]	; 0232D8FA
	ldr r0,[pool_0232D910]	; 0232D8FC
	and r1,r0	; 0232D8FE
	asr r0,r1,#0x8	; 0232D900
	lsl r1,r0,#0xb	; 0232D902
	ldr r0,[pool_0232D914]	; 0232D904
	add r0,r1,r0	; 0232D906
	bx lr	; 0232D908
.endfunc
	.byte 0xC0, 0x46	; 0232D90C
pool_0232D90C:
loc_0232D90C:
	.word REG_BG0CNT_SUB	; 0232D90C
pool_0232D910:
loc_0232D910:
	.word 0x00001F00	; 0232D910
pool_0232D914:
loc_0232D914:
	.word 0x06200000	; 0232D914

; ===== function loc_0232D918 =====
; Returns the main-engine BG0 tilemap base from BG0CNT and VRAM bank mode.
; 由 BG0CNT 与 VRAM bank 模式返回主引擎 BG0 tilemap 基址。
.func P1_GetMainBg0TilemapBase
loc_0232D918:
	ldr r0,[pool_0232D938]	; 0232D918
	ldrh r1,[r0,#0x0]	; 0232D91A
	ldr r0,[pool_0232D93C]	; 0232D91C
	and r1,r0	; 0232D91E
	asr r0,r1,#0x8	; 0232D920
	lsl r2,r0,#0xb	; 0232D922
	ldr r0,[pool_0232D940]	; 0232D924
	ldr r1,[r0,#0x0]	; 0232D926
	ldr r0,[pool_0232D944]	; 0232D928
	and r1,r0	; 0232D92A
	lsr r0,r1,#0x1b	; 0232D92C
	lsl r1,r0,#0x10	; 0232D92E
	ldr r0,[pool_0232D948]	; 0232D930
	add r0,r1,r0	; 0232D932
	add r0,r2,r0	; 0232D934
	bx lr	; 0232D936
.endfunc
pool_0232D938:
loc_0232D938:
	.word REG_BG0CNT	; 0232D938
pool_0232D93C:
loc_0232D93C:
	.word 0x00001F00	; 0232D93C
pool_0232D940:
loc_0232D940:
	.word REG_DISPCNT_A	; 0232D940
pool_0232D944:
loc_0232D944:
	.word 0x38000000	; 0232D944
pool_0232D948:
loc_0232D948:
	.word 0x06000000	; 0232D948

; ===== function loc_0232D94C =====
loc_0232D94C:
	cmp r2,#0x0	; 0232D94C
	bge loc_0232D95C	; 0232D94E
	mov r3,#0xc0	; 0232D950
	orr r1,r3	; 0232D952
	strh r1,[r0,#0x0]	; 0232D954
	neg r1,r2	; 0232D956
	strh r1,[r0,#0x4]	; 0232D958
	bx lr	; 0232D95A
loc_0232D95C:
	mov r3,#0x80	; 0232D95C
	orr r1,r3	; 0232D95E
	strh r1,[r0,#0x0]	; 0232D960
	strh r2,[r0,#0x4]	; 0232D962
	bx lr	; 0232D964
	.byte 0x00, 0x00	; 0232D968

; ===== function loc_0232D968 =====
loc_0232D968:
	push {r4}	; 0232D968
	sub sp,#0x4	; 0232D96A
	mov r4,#0x40	; 0232D96C
	orr r1,r4	; 0232D96E
	lsl r2,r2,#0x8	; 0232D970
	orr r1,r2	; 0232D972
	ldr r2,[sp,#0x8]	; 0232D974
	lsl r2,r2,#0x8	; 0232D976
	orr r3,r2	; 0232D978
	lsl r2,r3,#0x10	; 0232D97A
	orr r1,r2	; 0232D97C
	str r1,[r0,#0x0]	; 0232D97E
	add sp,#0x4	; 0232D980
	pop {r4}	; 0232D982
	bx lr	; 0232D984
	.byte 0x00, 0x00	; 0232D988

; ===== function loc_0232D988 =====
P1_Entry_0232D988:
	push {r4,r5,r6,lr}	; 0232D988
	add r5,r0,#0x0	; 0232D98A
	add r4,r1,#0x0	; 0232D98C
	add r6,r2,#0x0	; 0232D98E
	bl loc_02326BBC	; 0232D990
	add r2,r0,#0x0	; 0232D994
	ldr r0,[pool_0232D9AC]	; 0232D996
	ldr r0,[r0,#0x0]	; 0232D998
	add r1,r5,#0x0	; 0232D99A
	add r2,r2,r4	; 0232D99C
	add r3,r6,#0x0	; 0232D99E
	bl loc_0232DDD4	; 0232D9A0
	pop {r4,r5,r6}	; 0232D9A4
	pop {r3}	; 0232D9A6
	bx r3	; 0232D9A8
	.byte 0xC0, 0x46	; 0232D9AC
pool_0232D9AC:
loc_0232D9AC:
	.word P1_Data_02330A60	; 0232D9AC

; ===== function loc_0232D9B0 =====
P1_Entry_0232D9B0:
	push {r4,r5,r6,lr}	; 0232D9B0
	add r5,r0,#0x0	; 0232D9B2
	add r4,r1,#0x0	; 0232D9B4
	add r6,r2,#0x0	; 0232D9B6
	bl loc_02326BD8	; 0232D9B8
	add r2,r0,#0x0	; 0232D9BC
	ldr r0,[pool_0232D9D4]	; 0232D9BE
	ldr r0,[r0,#0x0]	; 0232D9C0
	add r1,r5,#0x0	; 0232D9C2
	add r2,r2,r4	; 0232D9C4
	add r3,r6,#0x0	; 0232D9C6
	bl loc_0232DDD4	; 0232D9C8
	pop {r4,r5,r6}	; 0232D9CC
	pop {r3}	; 0232D9CE
	bx r3	; 0232D9D0
	.byte 0xC0, 0x46	; 0232D9D4
pool_0232D9D4:
loc_0232D9D4:
	.word P1_Data_02330A60	; 0232D9D4
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xF9, 0xF7, 0x12, 0xF9, 0x02, 0x1C, 0x05, 0x48	; 0232D9E8
	.byte 0x00, 0x68, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C, 0x00, 0xF0, 0xF0, 0xF9, 0x70, 0xBC, 0x08, 0xBC	; 0232D9F8
	.byte 0x18, 0x47, 0xC0, 0x46, 0x60, 0x0A, 0x33, 0x02	; 0232DA00

; ===== function loc_0232DA00 =====
loc_0232DA00:
	push {r4,r5,r6,lr}	; 0232DA00
	add r5,r0,#0x0	; 0232DA02
	add r4,r1,#0x0	; 0232DA04
	add r6,r2,#0x0	; 0232DA06
	bl loc_02326C24	; 0232DA08
	add r2,r0,#0x0	; 0232DA0C
	ldr r0,[pool_0232DA24]	; 0232DA0E
	ldr r0,[r0,#0x0]	; 0232DA10
	add r1,r5,#0x0	; 0232DA12
	add r2,r2,r4	; 0232DA14
	add r3,r6,#0x0	; 0232DA16
	bl loc_0232DDD4	; 0232DA18
	pop {r4,r5,r6}	; 0232DA1C
	pop {r3}	; 0232DA1E
	bx r3	; 0232DA20
	.byte 0xC0, 0x46	; 0232DA24
pool_0232DA24:
loc_0232DA24:
	.word P1_Data_02330A60	; 0232DA24

; ===== function loc_0232DA28 =====
loc_0232DA28:
	push {r4,r5,r6,lr}	; 0232DA28
	add r5,r0,#0x0	; 0232DA2A
	add r4,r1,#0x0	; 0232DA2C
	add r6,r2,#0x0	; 0232DA2E
	bl P1_GetSubBg1CharacterBase	; 0232DA30
	add r2,r0,#0x0	; 0232DA34
	ldr r0,[pool_0232DA4C]	; 0232DA36
	ldr r0,[r0,#0x0]	; 0232DA38
	add r1,r5,#0x0	; 0232DA3A
	add r2,r2,r4	; 0232DA3C
	add r3,r6,#0x0	; 0232DA3E
	bl loc_0232DDD4	; 0232DA40
	pop {r4,r5,r6}	; 0232DA44
	pop {r3}	; 0232DA46
	bx r3	; 0232DA48
	.byte 0xC0, 0x46	; 0232DA4C
pool_0232DA4C:
loc_0232DA4C:
	.word P1_Data_02330A60	; 0232DA4C

; ===== function loc_0232DA50 =====
loc_0232DA50:
	push {r4,r5,r6,lr}	; 0232DA50
	add r5,r0,#0x0	; 0232DA52
	add r4,r1,#0x0	; 0232DA54
	add r6,r2,#0x0	; 0232DA56
	bl P1_GetMainBg1CharacterBase	; 0232DA58
	add r2,r0,#0x0	; 0232DA5C
	ldr r0,[pool_0232DA74]	; 0232DA5E
	ldr r0,[r0,#0x0]	; 0232DA60
	add r1,r5,#0x0	; 0232DA62
	add r2,r2,r4	; 0232DA64
	add r3,r6,#0x0	; 0232DA66
	bl loc_0232DDD4	; 0232DA68
	pop {r4,r5,r6}	; 0232DA6C
	pop {r3}	; 0232DA6E
	bx r3	; 0232DA70
	.byte 0xC0, 0x46	; 0232DA74
pool_0232DA74:
loc_0232DA74:
	.word P1_Data_02330A60	; 0232DA74

; ===== function loc_0232DA78 =====
	push {r4,r5,r6,lr}	; 0232DA78
	add r5,r0,#0x0	; 0232DA7A
	add r4,r1,#0x0	; 0232DA7C
	add r6,r2,#0x0	; 0232DA7E
	bl P1_GetSubBg0CharacterBase	; 0232DA80
	add r2,r0,#0x0	; 0232DA84
	ldr r0,[pool_0232DA9C]	; 0232DA86
	ldr r0,[r0,#0x0]	; 0232DA88
	add r1,r5,#0x0	; 0232DA8A
	add r2,r2,r4	; 0232DA8C
	add r3,r6,#0x0	; 0232DA8E
	bl loc_0232DDD4	; 0232DA90
	pop {r4,r5,r6}	; 0232DA94
	pop {r3}	; 0232DA96
	bx r3	; 0232DA98
	.byte 0xC0, 0x46	; 0232DA9C
pool_0232DA9C:
loc_0232DA9C:
	.word P1_Data_02330A60	; 0232DA9C
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xFF, 0xF7, 0xE4, 0xFE, 0x02, 0x1C, 0x05, 0x48	; 0232DAB0
	.byte 0x00, 0x68, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C, 0x00, 0xF0, 0x8C, 0xF9, 0x70, 0xBC, 0x08, 0xBC	; 0232DAC0
	.byte 0x18, 0x47, 0xC0, 0x46, 0x60, 0x0A, 0x33, 0x02	; 0232DAC8

; ===== function loc_0232DAC8 =====
loc_0232DAC8:
	push {r4,r5,r6,lr}	; 0232DAC8
	add r5,r0,#0x0	; 0232DACA
	add r4,r1,#0x0	; 0232DACC
	add r6,r2,#0x0	; 0232DACE
	bl loc_02326C54	; 0232DAD0
	add r2,r0,#0x0	; 0232DAD4
	ldr r0,[pool_0232DAEC]	; 0232DAD6
	ldr r0,[r0,#0x0]	; 0232DAD8
	add r1,r5,#0x0	; 0232DADA
	add r2,r2,r4	; 0232DADC
	add r3,r6,#0x0	; 0232DADE
	bl loc_0232DD94	; 0232DAE0
	pop {r4,r5,r6}	; 0232DAE4
	pop {r3}	; 0232DAE6
	bx r3	; 0232DAE8
	.byte 0xC0, 0x46	; 0232DAEC
pool_0232DAEC:
loc_0232DAEC:
	.word P1_Data_02330A60	; 0232DAEC

; ===== function loc_0232DAF0 =====
loc_0232DAF0:
	push {r4,r5,r6,lr}	; 0232DAF0
	add r5,r0,#0x0	; 0232DAF2
	add r4,r1,#0x0	; 0232DAF4
	add r6,r2,#0x0	; 0232DAF6
	blx P1_GetMainBg3TilemapAddress	; 0232DAF8
	add r2,r0,#0x0	; 0232DAFC
	ldr r0,[pool_0232DB14]	; 0232DAFE
	ldr r0,[r0,#0x0]	; 0232DB00
	add r1,r5,#0x0	; 0232DB02
	add r2,r2,r4	; 0232DB04
	add r3,r6,#0x0	; 0232DB06
	bl loc_0232DD94	; 0232DB08
	pop {r4,r5,r6}	; 0232DB0C
	pop {r3}	; 0232DB0E
	bx r3	; 0232DB10
	.byte 0xC0, 0x46	; 0232DB14
pool_0232DB14:
loc_0232DB14:
	.word P1_Data_02330A60	; 0232DB14

; ===== function loc_0232DB18 =====
loc_0232DB18:
	push {r4,r5,r6,lr}	; 0232DB18
	add r5,r0,#0x0	; 0232DB1A
	add r4,r1,#0x0	; 0232DB1C
	add r6,r2,#0x0	; 0232DB1E
	bl loc_02326CA8	; 0232DB20
	add r2,r0,#0x0	; 0232DB24
	ldr r0,[pool_0232DB3C]	; 0232DB26
	ldr r0,[r0,#0x0]	; 0232DB28
	add r1,r5,#0x0	; 0232DB2A
	add r2,r2,r4	; 0232DB2C
	add r3,r6,#0x0	; 0232DB2E
	bl loc_0232DD94	; 0232DB30
	pop {r4,r5,r6}	; 0232DB34
	pop {r3}	; 0232DB36
	bx r3	; 0232DB38
	.byte 0xC0, 0x46	; 0232DB3C
pool_0232DB3C:
loc_0232DB3C:
	.word P1_Data_02330A60	; 0232DB3C

; ===== function loc_0232DB40 =====
loc_0232DB40:
	push {r4,r5,r6,lr}	; 0232DB40
	add r5,r0,#0x0	; 0232DB42
	add r4,r1,#0x0	; 0232DB44
	add r6,r2,#0x0	; 0232DB46
	blx P1_GetMainBg2TilemapAddress	; 0232DB48
	add r2,r0,#0x0	; 0232DB4C
	ldr r0,[pool_0232DB64]	; 0232DB4E
	ldr r0,[r0,#0x0]	; 0232DB50
	add r1,r5,#0x0	; 0232DB52
	add r2,r2,r4	; 0232DB54
	add r3,r6,#0x0	; 0232DB56
	bl loc_0232DD94	; 0232DB58
	pop {r4,r5,r6}	; 0232DB5C
	pop {r3}	; 0232DB5E
	bx r3	; 0232DB60
	.byte 0xC0, 0x46	; 0232DB64
pool_0232DB64:
loc_0232DB64:
	.word P1_Data_02330A60	; 0232DB64

; ===== function loc_0232DB68 =====
loc_0232DB68:
	push {r4,r5,r6,lr}	; 0232DB68
	add r5,r0,#0x0	; 0232DB6A
	add r4,r1,#0x0	; 0232DB6C
	add r6,r2,#0x0	; 0232DB6E
	bl P1_GetSubBg1TilemapBase	; 0232DB70
	add r2,r0,#0x0	; 0232DB74
	ldr r0,[pool_0232DB8C]	; 0232DB76
	ldr r0,[r0,#0x0]	; 0232DB78
	add r1,r5,#0x0	; 0232DB7A
	add r2,r2,r4	; 0232DB7C
	add r3,r6,#0x0	; 0232DB7E
	bl loc_0232DD94	; 0232DB80
	pop {r4,r5,r6}	; 0232DB84
	pop {r3}	; 0232DB86
	bx r3	; 0232DB88
	.byte 0xC0, 0x46	; 0232DB8C
pool_0232DB8C:
loc_0232DB8C:
	.word P1_Data_02330A60	; 0232DB8C

; ===== function loc_0232DB90 =====
loc_0232DB90:
	push {r4,r5,r6,lr}	; 0232DB90
	add r5,r0,#0x0	; 0232DB92
	add r4,r1,#0x0	; 0232DB94
	add r6,r2,#0x0	; 0232DB96
	bl P1_GetMainBg1TilemapBase	; 0232DB98
	add r2,r0,#0x0	; 0232DB9C
	ldr r0,[pool_0232DBB4]	; 0232DB9E
	ldr r0,[r0,#0x0]	; 0232DBA0
	add r1,r5,#0x0	; 0232DBA2
	add r2,r2,r4	; 0232DBA4
	add r3,r6,#0x0	; 0232DBA6
	bl loc_0232DD94	; 0232DBA8
	pop {r4,r5,r6}	; 0232DBAC
	pop {r3}	; 0232DBAE
	bx r3	; 0232DBB0
	.byte 0xC0, 0x46	; 0232DBB4
pool_0232DBB4:
loc_0232DBB4:
	.word P1_Data_02330A60	; 0232DBB4

; ===== function loc_0232DBB8 =====
loc_0232DBB8:
	push {r4,r5,r6,lr}	; 0232DBB8
	add r5,r0,#0x0	; 0232DBBA
	add r4,r1,#0x0	; 0232DBBC
	add r6,r2,#0x0	; 0232DBBE
	bl P1_GetSubBg0TilemapBase	; 0232DBC0
	add r2,r0,#0x0	; 0232DBC4
	ldr r0,[pool_0232DBDC]	; 0232DBC6
	ldr r0,[r0,#0x0]	; 0232DBC8
	add r1,r5,#0x0	; 0232DBCA
	add r2,r2,r4	; 0232DBCC
	add r3,r6,#0x0	; 0232DBCE
	bl loc_0232DD94	; 0232DBD0
	pop {r4,r5,r6}	; 0232DBD4
	pop {r3}	; 0232DBD6
	bx r3	; 0232DBD8
	.byte 0xC0, 0x46	; 0232DBDC
pool_0232DBDC:
loc_0232DBDC:
	.word P1_Data_02330A60	; 0232DBDC

; ===== function loc_0232DBE0 =====
	push {r4,r5,r6,lr}	; 0232DBE0
	add r5,r0,#0x0	; 0232DBE2
	add r4,r1,#0x0	; 0232DBE4
	add r6,r2,#0x0	; 0232DBE6
	bl P1_GetMainBg0TilemapBase	; 0232DBE8
	add r2,r0,#0x0	; 0232DBEC
	ldr r0,[pool_0232DC04]	; 0232DBEE
	ldr r0,[r0,#0x0]	; 0232DBF0
	add r1,r5,#0x0	; 0232DBF2
	add r2,r2,r4	; 0232DBF4
	add r3,r6,#0x0	; 0232DBF6
	bl loc_0232DD94	; 0232DBF8
	pop {r4,r5,r6}	; 0232DBFC
	pop {r3}	; 0232DBFE
	bx r3	; 0232DC00
	.byte 0xC0, 0x46	; 0232DC04
pool_0232DC04:
loc_0232DC04:
	.word P1_Data_02330A60	; 0232DC04

; ===== function loc_0232DC08 =====
loc_0232DC08:
	push {r4,r5,lr}	; 0232DC08
	sub sp,#0x4	; 0232DC0A
	add r5,r0,#0x0	; 0232DC0C
	add r4,r1,#0x0	; 0232DC0E
	add r3,r2,#0x0	; 0232DC10
	ldr r0,[pool_0232DC28]	; 0232DC12
	ldr r0,[r0,#0x0]	; 0232DC14
	add r1,r5,#0x0	; 0232DC16
	ldr r2,[pool_0232DC2C]	; 0232DC18
	add r2,r4,r2	; 0232DC1A
	bl loc_0232DDD4	; 0232DC1C
	add sp,#0x4	; 0232DC20
	pop {r4,r5}	; 0232DC22
	pop {r3}	; 0232DC24
	bx r3	; 0232DC26
pool_0232DC28:
loc_0232DC28:
	.word P1_Data_02330A60	; 0232DC28
pool_0232DC2C:
loc_0232DC2C:
	.word 0x06600000	; 0232DC2C

; ===== function loc_0232DC30 =====
loc_0232DC30:
	push {r4,r5,lr}	; 0232DC30
	sub sp,#0x4	; 0232DC32
	add r5,r0,#0x0	; 0232DC34
	add r4,r1,#0x0	; 0232DC36
	add r3,r2,#0x0	; 0232DC38
	ldr r0,[pool_0232DC50]	; 0232DC3A
	ldr r0,[r0,#0x0]	; 0232DC3C
	add r1,r5,#0x0	; 0232DC3E
	ldr r2,[pool_0232DC54]	; 0232DC40
	add r2,r4,r2	; 0232DC42
	bl loc_0232DDD4	; 0232DC44
	add sp,#0x4	; 0232DC48
	pop {r4,r5}	; 0232DC4A
	pop {r3}	; 0232DC4C
	bx r3	; 0232DC4E
pool_0232DC50:
loc_0232DC50:
	.word P1_Data_02330A60	; 0232DC50
pool_0232DC54:
loc_0232DC54:
	.word 0x06400000	; 0232DC54

; ===== function loc_0232DC58 =====
loc_0232DC58:
	push {r4,r5,lr}	; 0232DC58
	sub sp,#0x4	; 0232DC5A
	add r5,r0,#0x0	; 0232DC5C
	add r4,r1,#0x0	; 0232DC5E
	add r3,r2,#0x0	; 0232DC60
	ldr r0,[pool_0232DC78]	; 0232DC62
	ldr r0,[r0,#0x0]	; 0232DC64
	add r1,r5,#0x0	; 0232DC66
	ldr r2,[pool_0232DC7C]	; 0232DC68
	add r2,r4,r2	; 0232DC6A
	bl loc_0232DDD4	; 0232DC6C
	add sp,#0x4	; 0232DC70
	pop {r4,r5}	; 0232DC72
	pop {r3}	; 0232DC74
	bx r3	; 0232DC76
pool_0232DC78:
loc_0232DC78:
	.word P1_Data_02330A60	; 0232DC78
pool_0232DC7C:
loc_0232DC7C:
	.word 0x07000400	; 0232DC7C

; ===== function loc_0232DC80 =====
loc_0232DC80:
	push {r4,r5,lr}	; 0232DC80
	sub sp,#0x4	; 0232DC82
	add r5,r0,#0x0	; 0232DC84
	add r4,r1,#0x0	; 0232DC86
	add r3,r2,#0x0	; 0232DC88
	ldr r0,[pool_0232DCA0]	; 0232DC8A
	ldr r0,[r0,#0x0]	; 0232DC8C
	add r1,r5,#0x0	; 0232DC8E
	ldr r2,[pool_0232DCA4]	; 0232DC90
	add r2,r4,r2	; 0232DC92
	bl loc_0232DDD4	; 0232DC94
	add sp,#0x4	; 0232DC98
	pop {r4,r5}	; 0232DC9A
	pop {r3}	; 0232DC9C
	bx r3	; 0232DC9E
pool_0232DCA0:
loc_0232DCA0:
	.word P1_Data_02330A60	; 0232DCA0
pool_0232DCA4:
loc_0232DCA4:
	.word 0x07000000	; 0232DCA4

; ===== function loc_0232DCA8 =====
loc_0232DCA8:
	push {r4,r5,lr}	; 0232DCA8
	sub sp,#0x4	; 0232DCAA
	add r5,r0,#0x0	; 0232DCAC
	add r4,r1,#0x0	; 0232DCAE
	add r3,r2,#0x0	; 0232DCB0
	ldr r0,[pool_0232DCC8]	; 0232DCB2
	ldr r0,[r0,#0x0]	; 0232DCB4
	add r1,r5,#0x0	; 0232DCB6
	ldr r2,[pool_0232DCCC]	; 0232DCB8
	add r2,r4,r2	; 0232DCBA
	bl loc_0232DD94	; 0232DCBC
	add sp,#0x4	; 0232DCC0
	pop {r4,r5}	; 0232DCC2
	pop {r3}	; 0232DCC4
	bx r3	; 0232DCC6
pool_0232DCC8:
loc_0232DCC8:
	.word P1_Data_02330A60	; 0232DCC8
pool_0232DCCC:
loc_0232DCCC:
	.word 0x05000600	; 0232DCCC

; ===== function loc_0232DCD0 =====
loc_0232DCD0:
	push {r4,r5,lr}	; 0232DCD0
	sub sp,#0x4	; 0232DCD2
	add r5,r0,#0x0	; 0232DCD4
	add r4,r1,#0x0	; 0232DCD6
	add r3,r2,#0x0	; 0232DCD8
	ldr r0,[pool_0232DCF0]	; 0232DCDA
	ldr r0,[r0,#0x0]	; 0232DCDC
	add r1,r5,#0x0	; 0232DCDE
	ldr r2,[pool_0232DCF4]	; 0232DCE0
	add r2,r4,r2	; 0232DCE2
	bl loc_0232DD94	; 0232DCE4
	add sp,#0x4	; 0232DCE8
	pop {r4,r5}	; 0232DCEA
	pop {r3}	; 0232DCEC
	bx r3	; 0232DCEE
pool_0232DCF0:
loc_0232DCF0:
	.word P1_Data_02330A60	; 0232DCF0
pool_0232DCF4:
loc_0232DCF4:
	.word 0x05000200	; 0232DCF4

; ===== function loc_0232DCF8 =====
loc_0232DCF8:
	push {r4,r5,lr}	; 0232DCF8
	sub sp,#0x4	; 0232DCFA
	add r5,r0,#0x0	; 0232DCFC
	add r4,r1,#0x0	; 0232DCFE
	add r3,r2,#0x0	; 0232DD00
	ldr r0,[pool_0232DD18]	; 0232DD02
	ldr r0,[r0,#0x0]	; 0232DD04
	add r1,r5,#0x0	; 0232DD06
	ldr r2,[pool_0232DD1C]	; 0232DD08
	add r2,r4,r2	; 0232DD0A
	bl loc_0232DD94	; 0232DD0C
	add sp,#0x4	; 0232DD10
	pop {r4,r5}	; 0232DD12
	pop {r3}	; 0232DD14
	bx r3	; 0232DD16
pool_0232DD18:
loc_0232DD18:
	.word P1_Data_02330A60	; 0232DD18
pool_0232DD1C:
loc_0232DD1C:
	.word 0x05000400	; 0232DD1C

; ===== function loc_0232DD20 =====
loc_0232DD20:
	push {r4,r5,lr}	; 0232DD20
	sub sp,#0x4	; 0232DD22
	add r5,r0,#0x0	; 0232DD24
	add r4,r1,#0x0	; 0232DD26
	add r3,r2,#0x0	; 0232DD28
	ldr r0,[pool_0232DD40]	; 0232DD2A
	ldr r0,[r0,#0x0]	; 0232DD2C
	add r1,r5,#0x0	; 0232DD2E
	ldr r2,[pool_0232DD44]	; 0232DD30
	add r2,r4,r2	; 0232DD32
	bl loc_0232DD94	; 0232DD34
	add sp,#0x4	; 0232DD38
	pop {r4,r5}	; 0232DD3A
	pop {r3}	; 0232DD3C
	bx r3	; 0232DD3E
pool_0232DD40:
loc_0232DD40:
	.word P1_Data_02330A60	; 0232DD40
pool_0232DD44:
loc_0232DD44:
	.word 0x05000000	; 0232DD44

; ===== function loc_0232DD48 =====
loc_0232DD48:
	ldr r1,[pool_0232DD50]	; 0232DD48
	strb r0,[r1,#0x0]	; 0232DD4A
	bx lr	; 0232DD4C
	.byte 0xC0, 0x46	; 0232DD50
pool_0232DD50:
loc_0232DD50:
	.word REG_WRAMCNT	; 0232DD50

; ===== function loc_0232DD54 =====
loc_0232DD54:
	push {r4,lr}	; 0232DD54
	add r4,r0,#0x0	; 0232DD56
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232DD58
	mov r1,#0x6	; 0232DD5C
	mul r4,r1	; 0232DD5E
	add r1,r4,#0x5	; 0232DD60
	lsl r2,r1,#0x1	; 0232DD62
	ldr r1,[pool_0232DD88]	; 0232DD64
	add r2,r2,r1	; 0232DD66
	ldrh r3,[r2,#0x0]	; 0232DD68
	ldr r1,[pool_0232DD8C]	; 0232DD6A
	and r3,r1	; 0232DD6C
	strh r3,[r2,#0x0]	; 0232DD6E
	ldrh r3,[r2,#0x0]	; 0232DD70
	ldr r1,[pool_0232DD90]	; 0232DD72
	and r3,r1	; 0232DD74
	strh r3,[r2,#0x0]	; 0232DD76
	ldrh r1,[r2,#0x0]	; 0232DD78
	ldrh r1,[r2,#0x0]	; 0232DD7A
	blx P1_Arm9RestoreIrqMask	; 0232DD7C
	pop {r4}	; 0232DD80
	pop {r3}	; 0232DD82
	bx r3	; 0232DD84
	.byte 0xC0, 0x46	; 0232DD88
pool_0232DD88:
loc_0232DD88:
	.word REG_DMA0SAD	; 0232DD88
pool_0232DD8C:
loc_0232DD8C:
	.word 0xFFFFC5FF	; 0232DD8C
pool_0232DD90:
loc_0232DD90:
	.word 0xFFFF7FFF	; 0232DD90

; ===== function loc_0232DD94 =====
loc_0232DD94:
	push {r4,r5,r6,lr}	; 0232DD94
	cmp r3,#0x0	; 0232DD96
	beq loc_0232DDC6	; 0232DD98
	mov r4,#0x3	; 0232DD9A
	add r5,r0,#0x0	; 0232DD9C
	mul r5,r4	; 0232DD9E
	add r4,r5,#0x2	; 0232DDA0
	lsl r5,r4,#0x2	; 0232DDA2
	ldr r4,[pool_0232DDCC]	; 0232DDA4
	add r4,r5,r4	; 0232DDA6
	ldr r5,[pool_0232DDD0]	; 0232DDA8
loc_0232DDAA:
	ldr r6,[r4,#0x0]	; 0232DDAA
	and r6,r5	; 0232DDAC
	cmp r6,#0x0	; 0232DDAE
	bne loc_0232DDAA	; 0232DDB0
	lsr r3,r3,#0x1	; 0232DDB2
	ldr r5,[pool_0232DDD0]	; 0232DDB4
	orr r3,r5	; 0232DDB6
	bl P1_SetDmaChannelRegisters	; 0232DDB8
	lsl r0,r5,#0	; 0232DDBC
loc_0232DDBE:
	ldr r1,[r4,#0x0]	; 0232DDBE
	and r1,r0	; 0232DDC0
	cmp r1,#0x0	; 0232DDC2
	bne loc_0232DDBE	; 0232DDC4
loc_0232DDC6:
	pop {r4,r5,r6}	; 0232DDC6
	pop {r3}	; 0232DDC8
	bx r3	; 0232DDCA
pool_0232DDCC:
loc_0232DDCC:
	.word REG_DMA0SAD	; 0232DDCC
pool_0232DDD0:
loc_0232DDD0:
	.word 0x80000000	; 0232DDD0

; ===== function loc_0232DDD4 =====
loc_0232DDD4:
	push {r4,r5,r6,lr}	; 0232DDD4
	cmp r3,#0x0	; 0232DDD6
	beq loc_0232DE06	; 0232DDD8
	mov r4,#0x3	; 0232DDDA
	add r5,r0,#0x0	; 0232DDDC
	mul r5,r4	; 0232DDDE
	add r4,r5,#0x2	; 0232DDE0
	lsl r5,r4,#0x2	; 0232DDE2
	ldr r4,[pool_0232DE0C]	; 0232DDE4
	add r4,r5,r4	; 0232DDE6
	ldr r5,[pool_0232DE10]	; 0232DDE8
loc_0232DDEA:
	ldr r6,[r4,#0x0]	; 0232DDEA
	and r6,r5	; 0232DDEC
	cmp r6,#0x0	; 0232DDEE
	bne loc_0232DDEA	; 0232DDF0
	lsr r3,r3,#0x2	; 0232DDF2
	ldr r5,[pool_0232DE14]	; 0232DDF4
	orr r3,r5	; 0232DDF6
	bl P1_SetDmaChannelRegisters	; 0232DDF8
	ldr r0,[pool_0232DE10]	; 0232DDFC
loc_0232DDFE:
	ldr r1,[r4,#0x0]	; 0232DDFE
	and r1,r0	; 0232DE00
	cmp r1,#0x0	; 0232DE02
	bne loc_0232DDFE	; 0232DE04
loc_0232DE06:
	pop {r4,r5,r6}	; 0232DE06
	pop {r3}	; 0232DE08
	bx r3	; 0232DE0A
pool_0232DE0C:
loc_0232DE0C:
	.word REG_DMA0SAD	; 0232DE0C
pool_0232DE10:
loc_0232DE10:
	.word 0x80000000	; 0232DE10
pool_0232DE14:
loc_0232DE14:
	.word 0x84000000	; 0232DE14
.arm

; ===== function loc_0232DE18 =====
loc_0232DE18:
	mov r3,#0x0	; 0232DE18
loc_0232DE1C:
	cmp r3,r2	; 0232DE1C
	strlth r0,[r1,r3]	; 0232DE20
	addlt r3,r3,#0x2	; 0232DE24
	blt loc_0232DE1C	; 0232DE28
	bx lr	; 0232DE2C

; ===== function loc_0232DE30 =====
loc_0232DE30:
	mov r12,#0x0	; 0232DE30
loc_0232DE34:
	cmp r12,r2	; 0232DE34
	ldrlth r3,[r0,r12]	; 0232DE38
	strlth r3,[r1,r12]	; 0232DE3C
	addlt r12,r12,#0x2	; 0232DE40
	blt loc_0232DE34	; 0232DE44
	bx lr	; 0232DE48

; ===== function loc_0232DE4C =====
; r0=填充值，r1=目标，r2=字节数；按 32 位字写入。
; r0=value, r1=destination, r2=byte count; fills in 32-bit words.
P1_MemFill32:
loc_0232DE4C:
	add r12,r1,r2	; 0232DE4C
loc_0232DE50:
	cmp r1,r12	; 0232DE50
	stmltia r1!,{r0}	; 0232DE54
	blt loc_0232DE50	; 0232DE58
	bx lr	; 0232DE5C

; ===== function loc_0232DE60 =====
; r0=源，r1=目标，r2=字节数；按 32 位字复制。
; r0=source, r1=destination, r2=byte count; copies 32-bit words.
P1_MemCopy32:
loc_0232DE60:
	add r12,r1,r2	; 0232DE60
loc_0232DE64:
	cmp r1,r12	; 0232DE64
	ldmltia r0!,{r2}	; 0232DE68
	stmltia r1!,{r2}	; 0232DE6C
	blt loc_0232DE64	; 0232DE70
	bx lr	; 0232DE74

; ===== function loc_0232DE78 =====
loc_0232DE78:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 0232DE78
	add r9,r1,r2	; 0232DE7C
	mov r12,r2, lsr #0x5	; 0232DE80
	add r12,r1,r12, lsl #0x5	; 0232DE84
	mov r2,r0	; 0232DE88
	mov r3,r2	; 0232DE8C
	mov r4,r2	; 0232DE90
	mov r5,r2	; 0232DE94
	mov r6,r2	; 0232DE98
	mov r7,r2	; 0232DE9C
	mov r8,r2	; 0232DEA0
loc_0232DEA4:
	cmp r1,r12	; 0232DEA4
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 0232DEA8
	blt loc_0232DEA4	; 0232DEAC
loc_0232DEB0:
	cmp r1,r9	; 0232DEB0
	stmltia r1!,{r0}	; 0232DEB4
	blt loc_0232DEB0	; 0232DEB8
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 0232DEBC
	bx lr	; 0232DEC0

; ===== function loc_0232DEC4 =====
loc_0232DEC4:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232DEC4
	add r10,r1,r2	; 0232DEC8
	mov r12,r2, lsr #0x5	; 0232DECC
	add r12,r1,r12, lsl #0x5	; 0232DED0
loc_0232DED4:
	cmp r1,r12	; 0232DED4
	ldmltia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232DED8
	stmltia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232DEDC
	blt loc_0232DED4	; 0232DEE0
loc_0232DEE4:
	cmp r1,r10	; 0232DEE4
	ldmltia r0!,{r2}	; 0232DEE8
	stmltia r1!,{r2}	; 0232DEEC
	blt loc_0232DEE4	; 0232DEF0
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232DEF4
	bx lr	; 0232DEF8

; ===== function loc_0232DEFC =====
loc_0232DEFC:
	mov r12,#0x0	; 0232DEFC
loc_0232DF00:
	cmp r12,r2	; 0232DF00
	strltb r1,[r0,r12]	; 0232DF04
	addlt r12,r12,#0x1	; 0232DF08
	blt loc_0232DF00	; 0232DF0C
	bx lr	; 0232DF10
P1_Entry_0232DF14:
	mov r12,#0x0	; 0232DF14
P1_Entry_0232DF18:
	cmp r12,r2	; 0232DF18
	ldrltb r3,[r0,r12]	; 0232DF1C
	strltb r3,[r1,r12]	; 0232DF20
	addlt r12,r12,#0x1	; 0232DF24
	blt P1_Entry_0232DF18	; 0232DF28
	bx lr	; 0232DF2C

; ===== function loc_0232DF30 =====
loc_0232DF30:
	swp r0,r0,[r1]	; 0232DF30
	bx lr	; 0232DF34
.thumb

; ===== function loc_0232DF38 =====
loc_0232DF38:
	push {lr}	; 0232DF38
	sub sp,#0x4	; 0232DF3A
	ldr r0,[pool_0232DF58]	; 0232DF3C
	ldr r1,[r0,#0x0]	; 0232DF3E
	cmp r1,#0x0	; 0232DF40
	bne loc_0232DF50	; 0232DF42
	mov r1,#0x1	; 0232DF44
	str r1,[r0,#0x0]	; 0232DF46
	bl loc_0232E56C	; 0232DF48
	bl loc_0232E690	; 0232DF4C
loc_0232DF50:
	add sp,#0x4	; 0232DF50
	pop {r3}	; 0232DF52
	bx r3	; 0232DF54
	.byte 0xC0, 0x46	; 0232DF58
pool_0232DF58:
loc_0232DF58:
	.word P1_BssStart + 0x266CC	; 0232DF58

; ===== function loc_0232DF5C =====
loc_0232DF5C:
	push {r4,r5,r6,r7,lr}	; 0232DF5C
	sub sp,#0x4	; 0232DF5E
	add r5,r0,#0x0	; 0232DF60
	add r4,r1,#0x0	; 0232DF62
	add r6,r2,#0x0	; 0232DF64
	add r7,r3,#0x0	; 0232DF66
	mov r0,#0x1	; 0232DF68
	bl loc_0232E470	; 0232DF6A
	cmp r0,#0x0	; 0232DF6E
	beq loc_0232DF82	; 0232DF70
	str r5,[r0,#0x4]	; 0232DF72
	str r4,[r0,#0x8]	; 0232DF74
	str r6,[r0,#0xc]	; 0232DF76
	str r7,[r0,#0x10]	; 0232DF78
	ldr r1,[sp,#0x18]	; 0232DF7A
	str r1,[r0,#0x14]	; 0232DF7C
	bl loc_0232E44C	; 0232DF7E
loc_0232DF82:
	add sp,#0x4	; 0232DF82
	pop {r4,r5,r6,r7}	; 0232DF84
	pop {r3}	; 0232DF86
	bx r3	; 0232DF88
	.byte 0x00, 0x00	; 0232DF8C

; ===== function loc_0232DF8C =====
loc_0232DF8C:
	push {lr}	; 0232DF8C
	sub sp,#0x4	; 0232DF8E
	add r1,r0,#0x0	; 0232DF90
	mov r2,#0x0	; 0232DF92
	str r2,[sp,#0x0]	; 0232DF94
	mov r0,#0x13	; 0232DF96
	add r3,r2,#0x0	; 0232DF98
	bl loc_0232DF5C	; 0232DF9A
	add sp,#0x4	; 0232DF9E
	pop {r3}	; 0232DFA0
	bx r3	; 0232DFA2

; ===== function loc_0232DFA4 =====
loc_0232DFA4:
	push {r4,r5,r6,lr}	; 0232DFA4
	sub sp,#0x8	; 0232DFA6
	add r6,r0,#0x0	; 0232DFA8
	add r5,r1,#0x0	; 0232DFAA
	add r4,r2,#0x0	; 0232DFAC
	str r3,[sp,#0x0]	; 0232DFAE
	mov r0,#0x4	; 0232DFB0
	ldr r1,[sp,#0x18]	; 0232DFB2
	lsl r1,r1,#0x18	; 0232DFB4
	orr r1,r6	; 0232DFB6
	add r2,r5,#0x0	; 0232DFB8
	add r3,r4,#0x0	; 0232DFBA
	bl loc_0232DF5C	; 0232DFBC
	add sp,#0x8	; 0232DFC0
	pop {r4,r5,r6}	; 0232DFC2
	pop {r3}	; 0232DFC4
	bx r3	; 0232DFC6

; ===== function loc_0232DFC8 =====
loc_0232DFC8:
	push {r4,r5,r6,lr}	; 0232DFC8
	sub sp,#0x8	; 0232DFCA
	add r6,r0,#0x0	; 0232DFCC
	add r5,r1,#0x0	; 0232DFCE
	add r4,r2,#0x0	; 0232DFD0
	str r3,[sp,#0x0]	; 0232DFD2
	mov r0,#0x3	; 0232DFD4
	add r1,r6,#0x0	; 0232DFD6
	add r2,r5,#0x0	; 0232DFD8
	add r3,r4,#0x0	; 0232DFDA
	bl loc_0232DF5C	; 0232DFDC
	add sp,#0x8	; 0232DFE0
	pop {r4,r5,r6}	; 0232DFE2
	pop {r3}	; 0232DFE4
	bx r3	; 0232DFE6

; ===== function loc_0232DFE8 =====
loc_0232DFE8:
	push {r4,r5,r6,lr}	; 0232DFE8
	sub sp,#0x8	; 0232DFEA
	add r6,r0,#0x0	; 0232DFEC
	add r5,r1,#0x0	; 0232DFEE
	add r4,r2,#0x0	; 0232DFF0
	str r3,[sp,#0x0]	; 0232DFF2
	mov r0,#0x15	; 0232DFF4
	add r1,r6,#0x0	; 0232DFF6
	add r2,r5,#0x0	; 0232DFF8
	add r3,r4,#0x0	; 0232DFFA
	bl loc_0232DF5C	; 0232DFFC
	add sp,#0x8	; 0232E000
	pop {r4,r5,r6}	; 0232E002
	pop {r3}	; 0232E004
	bx r3	; 0232E006

; ===== function loc_0232E008 =====
loc_0232E008:
	push {r4,r5,lr}	; 0232E008
	sub sp,#0x4	; 0232E00A
	add r5,r0,#0x0	; 0232E00C
	ldr r4,[sp,#0x10]	; 0232E00E
	ldr r0,[sp,#0x24]	; 0232E010
	lsl r0,r0,#0x10	; 0232E012
	lsl r3,r3,#0x1a	; 0232E014
	lsl r1,r1,#0x18	; 0232E016
	orr r3,r1	; 0232E018
	orr r0,r3	; 0232E01A
	orr r4,r0	; 0232E01C
	str r4,[sp,#0x0]	; 0232E01E
	mov r0,#0xb	; 0232E020
	ldr r1,[sp,#0x20]	; 0232E022
	lsl r1,r1,#0x10	; 0232E024
	orr r1,r5	; 0232E026
	ldr r3,[sp,#0x14]	; 0232E028
	ldr r4,[sp,#0x18]	; 0232E02A
	lsl r5,r4,#0x18	; 0232E02C
	ldr r4,[sp,#0x1c]	; 0232E02E
	lsl r4,r4,#0x16	; 0232E030
	orr r5,r4	; 0232E032
	orr r3,r5	; 0232E034
	bl loc_0232DF5C	; 0232E036
	add sp,#0x4	; 0232E03A
	pop {r4,r5}	; 0232E03C
	pop {r3}	; 0232E03E
	bx r3	; 0232E040
	.byte 0x00, 0x00	; 0232E044

; ===== function loc_0232E044 =====
loc_0232E044:
	push {r4,r5,lr}	; 0232E044
	sub sp,#0x4	; 0232E046
	add r5,r0,#0x0	; 0232E048
	add r4,r1,#0x0	; 0232E04A
	add r3,r2,#0x0	; 0232E04C
	mov r0,#0x0	; 0232E04E
	str r0,[sp,#0x0]	; 0232E050
	mov r0,#0x11	; 0232E052
	add r1,r5,#0x0	; 0232E054
	add r2,r4,#0x0	; 0232E056
	bl loc_0232DF5C	; 0232E058
	add sp,#0x4	; 0232E05C
	pop {r4,r5}	; 0232E05E
	pop {r3}	; 0232E060
	bx r3	; 0232E062

; ===== function loc_0232E064 =====
loc_0232E064:
	push {r4,lr}	; 0232E064
	sub sp,#0x8	; 0232E066
	add r4,r0,#0x0	; 0232E068
	add r2,r1,#0x0	; 0232E06A
	mov r3,#0x0	; 0232E06C
	str r3,[sp,#0x0]	; 0232E06E
	mov r0,#0x17	; 0232E070
	add r1,r4,#0x0	; 0232E072
	bl loc_0232DF5C	; 0232E074
	add sp,#0x8	; 0232E078
	pop {r4}	; 0232E07A
	pop {r3}	; 0232E07C
	bx r3	; 0232E07E

; ===== function loc_0232E080 =====
loc_0232E080:
	push {r4,lr}	; 0232E080
	sub sp,#0x8	; 0232E082
	add r4,r0,#0x0	; 0232E084
	add r2,r1,#0x0	; 0232E086
	mov r3,#0x0	; 0232E088
	str r3,[sp,#0x0]	; 0232E08A
	mov r0,#0x16	; 0232E08C
	add r1,r4,#0x0	; 0232E08E
	bl loc_0232DF5C	; 0232E090
	add sp,#0x8	; 0232E094
	pop {r4}	; 0232E096
	pop {r3}	; 0232E098
	bx r3	; 0232E09A

; ===== function loc_0232E09C =====
loc_0232E09C:
	push {r4,r5,r6,lr}	; 0232E09C
	sub sp,#0x8	; 0232E09E
	add r5,r0,#0x0	; 0232E0A0
	add r4,r1,#0x0	; 0232E0A2
	add r6,r2,#0x0	; 0232E0A4
	add r1,r3,#0x0	; 0232E0A6
	ldr r2,[sp,#0x18]	; 0232E0A8
	bl loc_0232E650	; 0232E0AA
	str r0,[sp,#0x0]	; 0232E0AE
	mov r0,#0xf	; 0232E0B0
	add r1,r5,#0x0	; 0232E0B2
	add r2,r4,#0x0	; 0232E0B4
	add r3,r6,#0x0	; 0232E0B6
	bl loc_0232DF5C	; 0232E0B8
	add sp,#0x8	; 0232E0BC
	pop {r4,r5,r6}	; 0232E0BE
	pop {r3}	; 0232E0C0
	bx r3	; 0232E0C2

; ===== function loc_0232E0C4 =====
loc_0232E0C4:
	push {r4,r5,r6,r7,lr}	; 0232E0C4
	sub sp,#0xc	; 0232E0C6
	add r6,r0,#0x0	; 0232E0C8
	str r1,[sp,#0x4]	; 0232E0CA
	mov r0,#0x0	; 0232E0CC
	str r0,[sp,#0x0]	; 0232E0CE
	mov r0,#0xe	; 0232E0D0
	add r1,r2,#0x0	; 0232E0D2
	add r2,r3,#0x0	; 0232E0D4
	ldr r3,[sp,#0x28]	; 0232E0D6
	lsl r7,r3,#0x1b	; 0232E0D8
	ldr r3,[sp,#0x24]	; 0232E0DA
	lsl r5,r3,#0x1c	; 0232E0DC
	ldr r3,[sp,#0x20]	; 0232E0DE
	lsl r4,r3,#0x1d	; 0232E0E0
	lsl r3,r6,#0x1f	; 0232E0E2
	ldr r6,[sp,#0x4]	; 0232E0E4
	lsl r6,r6,#0x1e	; 0232E0E6
	orr r3,r6	; 0232E0E8
	orr r4,r3	; 0232E0EA
	orr r5,r4	; 0232E0EC
	orr r7,r5	; 0232E0EE
	add r3,r7,#0x0	; 0232E0F0
	bl loc_0232DF5C	; 0232E0F2
	add sp,#0xc	; 0232E0F6
	pop {r4,r5,r6,r7}	; 0232E0F8
	pop {r3}	; 0232E0FA
	bx r3	; 0232E0FC
	.byte 0x00, 0x00	; 0232E100

; ===== function loc_0232E100 =====
loc_0232E100:
	push {r4,r5,r6,r7,lr}	; 0232E100
	sub sp,#0x14	; 0232E102
	str r0,[sp,#0x4]	; 0232E104
	str r1,[sp,#0x8]	; 0232E106
	add r7,r2,#0x0	; 0232E108
	str r3,[sp,#0xc]	; 0232E10A
	add r4,r7,#0x0	; 0232E10C
	mov r5,#0x0	; 0232E10E
	mov r6,#0x1	; 0232E110
	b loc_0232E126	; 0232E112
loc_0232E114:
	add r0,r4,#0x0	; 0232E114
	and r0,r6	; 0232E116
	cmp r0,#0x0	; 0232E118
	beq loc_0232E122	; 0232E11A
	add r0,r5,#0x0	; 0232E11C
	bl loc_0232E678	; 0232E11E
loc_0232E122:
	add r5,r5,#0x1	; 0232E122
	lsr r4,r4,#0x1	; 0232E124
loc_0232E126:
	cmp r5,#0x8	; 0232E126
	bge loc_0232E12E	; 0232E128
	cmp r4,#0x0	; 0232E12A
	bne loc_0232E114	; 0232E12C
loc_0232E12E:
	ldr r0,[sp,#0xc]	; 0232E12E
	str r0,[sp,#0x0]	; 0232E130
	mov r0,#0xa	; 0232E132
	ldr r1,[sp,#0x4]	; 0232E134
	ldr r2,[sp,#0x8]	; 0232E136
	add r3,r7,#0x0	; 0232E138
	bl loc_0232DF5C	; 0232E13A
	add sp,#0x14	; 0232E13E
	pop {r4,r5,r6,r7}	; 0232E140
	pop {r3}	; 0232E142
	bx r3	; 0232E144
	.byte 0x00, 0x00	; 0232E148

; ===== function loc_0232E148 =====
loc_0232E148:
	push {r4,r5,r6,lr}	; 0232E148
	sub sp,#0x8	; 0232E14A
	add r6,r0,#0x0	; 0232E14C
	add r5,r1,#0x0	; 0232E14E
	add r4,r2,#0x0	; 0232E150
	str r3,[sp,#0x0]	; 0232E152
	mov r0,#0x9	; 0232E154
	add r1,r6,#0x0	; 0232E156
	add r2,r5,#0x0	; 0232E158
	add r3,r4,#0x0	; 0232E15A
	bl loc_0232DF5C	; 0232E15C
	add sp,#0x8	; 0232E160
	pop {r4,r5,r6}	; 0232E162
	pop {r3}	; 0232E164
	bx r3	; 0232E166

; ===== function loc_0232E168 =====
loc_0232E168:
	push {lr}	; 0232E168
	sub sp,#0x4	; 0232E16A
	add r3,r2,#0x0	; 0232E16C
	mov r2,#0x1	; 0232E16E
	str r2,[sp,#0x0]	; 0232E170
	mov r2,#0x1a	; 0232E172
	bl loc_0232DFA4	; 0232E174
	add sp,#0x4	; 0232E178
	pop {r3}	; 0232E17A
	bx r3	; 0232E17C
	.byte 0x00, 0x00	; 0232E180

; ===== function loc_0232E180 =====
loc_0232E180:
	push {lr}	; 0232E180
	sub sp,#0x4	; 0232E182
	add r3,r2,#0x0	; 0232E184
	mov r2,#0x2	; 0232E186
	str r2,[sp,#0x0]	; 0232E188
	mov r2,#0xc	; 0232E18A
	bl loc_0232DFA4	; 0232E18C
	add sp,#0x4	; 0232E190
	pop {r3}	; 0232E192
	bx r3	; 0232E194
	.byte 0x00, 0x00	; 0232E198

; ===== function loc_0232E198 =====
loc_0232E198:
	push {lr}	; 0232E198
	sub sp,#0x4	; 0232E19A
	add r2,r1,#0x0	; 0232E19C
	mov r1,#0x4	; 0232E19E
	mov r3,#0x1	; 0232E1A0
	bl loc_0232DFC8	; 0232E1A2
	add sp,#0x4	; 0232E1A6
	pop {r3}	; 0232E1A8
	bx r3	; 0232E1AA

; ===== function loc_0232E1AC =====
loc_0232E1AC:
	push {lr}	; 0232E1AC
	sub sp,#0x4	; 0232E1AE
	add r2,r1,#0x0	; 0232E1B0
	mov r1,#0x6	; 0232E1B2
	mov r3,#0x2	; 0232E1B4
	bl loc_0232DFC8	; 0232E1B6
	add sp,#0x4	; 0232E1BA
	pop {r3}	; 0232E1BC
	bx r3	; 0232E1BE

; ===== function loc_0232E1C0 =====
loc_0232E1C0:
	push {lr}	; 0232E1C0
	sub sp,#0x4	; 0232E1C2
	add r1,r0,#0x0	; 0232E1C4
	mov r2,#0x0	; 0232E1C6
	str r2,[sp,#0x0]	; 0232E1C8
	mov r0,#0x1	; 0232E1CA
	add r3,r2,#0x0	; 0232E1CC
	bl loc_0232DF5C	; 0232E1CE
	add sp,#0x4	; 0232E1D2
	pop {r3}	; 0232E1D4
	bx r3	; 0232E1D6

; ===== function loc_0232E1D8 =====
loc_0232E1D8:
	push {r4,r5,r6,lr}	; 0232E1D8
	sub sp,#0x8	; 0232E1DA
	add r6,r0,#0x0	; 0232E1DC
	add r5,r1,#0x0	; 0232E1DE
	add r4,r2,#0x0	; 0232E1E0
	str r3,[sp,#0x0]	; 0232E1E2
	mov r0,#0x0	; 0232E1E4
	add r1,r6,#0x0	; 0232E1E6
	add r2,r5,#0x0	; 0232E1E8
	add r3,r4,#0x0	; 0232E1EA
	bl loc_0232DF5C	; 0232E1EC
	add sp,#0x8	; 0232E1F0
	pop {r4,r5,r6}	; 0232E1F2
	pop {r3}	; 0232E1F4
	bx r3	; 0232E1F6

; ===== function loc_0232E1F8 =====
loc_0232E1F8:
	ldr r1,[pool_0232E214]	; 0232E1F8
	ldr r0,[r1,#0x0]	; 0232E1FA
	cmp r0,#0x0	; 0232E1FC
	bne loc_0232E204	; 0232E1FE
	mov r0,#0x0	; 0232E200
	bx lr	; 0232E202
loc_0232E204:
	ldr r2,[r0,#0x0]	; 0232E204
	str r2,[r1,#0x0]	; 0232E206
	cmp r2,#0x0	; 0232E208
	bne loc_0232E212	; 0232E20A
	mov r2,#0x0	; 0232E20C
	ldr r1,[pool_0232E218]	; 0232E20E
	str r2,[r1,#0x0]	; 0232E210
loc_0232E212:
	bx lr	; 0232E212
pool_0232E214:
loc_0232E214:
	.word P1_BssStart + 0x266D0	; 0232E214
pool_0232E218:
loc_0232E218:
	.word P1_BssStart + 0x266E0	; 0232E218

; ===== function loc_0232E21C =====
loc_0232E21C:
	push {r4,r5,lr}	; 0232E21C
	sub sp,#0x4	; 0232E21E
	mov r5,#0x7	; 0232E220
	mov r4,#0x0	; 0232E222
loc_0232E224:
	add r0,r5,#0x0	; 0232E224
	add r1,r4,#0x0	; 0232E226
	add r2,r4,#0x0	; 0232E228
	bl loc_0232E8C4	; 0232E22A
	cmp r0,#0x0	; 0232E22E
	blt loc_0232E224	; 0232E230
	add sp,#0x4	; 0232E232
	pop {r4,r5}	; 0232E234
	pop {r3}	; 0232E236
	bx r3	; 0232E238
	.byte 0x00, 0x00	; 0232E23C

; ===== function loc_0232E23C =====
loc_0232E23C:
	push {r4,r5,r6,lr}	; 0232E23C
	mov r0,#0x7	; 0232E23E
	ldr r1,[pool_0232E278]	; 0232E240
	bl P1_SetPxiReceiveCallback	; 0232E242
	bl loc_0232BA44	; 0232E246
	cmp r0,#0x0	; 0232E24A
	bne loc_0232E272	; 0232E24C
	mov r0,#0x7	; 0232E24E
	mov r1,#0x1	; 0232E250
	bl loc_0232E958	; 0232E252
	cmp r0,#0x0	; 0232E256
	bne loc_0232E272	; 0232E258
	mov r5,#0x64	; 0232E25A
	mov r4,#0x7	; 0232E25C
	mov r6,#0x1	; 0232E25E
loc_0232E260:
	add r0,r5,#0x0	; 0232E260
	blx P1_Arm9BusyWaitByLoop4	; 0232E262
	add r0,r4,#0x0	; 0232E266
	add r1,r6,#0x0	; 0232E268
	bl loc_0232E958	; 0232E26A
	cmp r0,#0x0	; 0232E26E
	beq loc_0232E260	; 0232E270
loc_0232E272:
	pop {r4,r5,r6}	; 0232E272
	pop {r3}	; 0232E274
	bx r3	; 0232E276
pool_0232E278:
loc_0232E278:
	.word P1_PxiCallback_0232E27C + 1	; 0232E278

; ===== function loc_0232E27C =====
P1_PxiCallback_0232E27C:
	push {r4,r5,lr}	; 0232E27C
	sub sp,#0x4	; 0232E27E
	add r5,r1,#0x0	; 0232E280
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E282
	add r4,r0,#0x0	; 0232E286
	add r0,r5,#0x0	; 0232E288
	bl loc_0232E620	; 0232E28A
	add r0,r4,#0x0	; 0232E28E
	blx P1_Arm9RestoreIrqMask	; 0232E290
	add sp,#0x4	; 0232E294
	pop {r4,r5}	; 0232E296
	pop {r3}	; 0232E298
	bx r3	; 0232E29A

; ===== function loc_0232E29C =====
loc_0232E29C:
	push {r4,lr}	; 0232E29C
	bl loc_0232E2D0	; 0232E29E
	add r4,r0,#0x0	; 0232E2A2
	bl loc_0232E2B8	; 0232E2A4
	ldr r1,[pool_0232E2B4]	; 0232E2A8
	sub r1,r1,r4	; 0232E2AA
	sub r0,r1,r0	; 0232E2AC
	pop {r4}	; 0232E2AE
	pop {r3}	; 0232E2B0
	bx r3	; 0232E2B2
pool_0232E2B4:
loc_0232E2B4:
	.word 0x00000100	; 0232E2B4

; ===== function loc_0232E2B8 =====
loc_0232E2B8:
	ldr r0,[pool_0232E2CC]	; 0232E2B8
	ldr r1,[r0,#0x0]	; 0232E2BA
	mov r0,#0x0	; 0232E2BC
	cmp r1,#0x0	; 0232E2BE
	beq loc_0232E2CA	; 0232E2C0
loc_0232E2C2:
	add r0,r0,#0x1	; 0232E2C2
	ldr r1,[r1,#0x0]	; 0232E2C4
	cmp r1,#0x0	; 0232E2C6
	bne loc_0232E2C2	; 0232E2C8
loc_0232E2CA:
	bx lr	; 0232E2CA
pool_0232E2CC:
loc_0232E2CC:
	.word P1_BssStart + 0x266D8	; 0232E2CC

; ===== function loc_0232E2D0 =====
loc_0232E2D0:
	ldr r0,[pool_0232E2E4]	; 0232E2D0
	ldr r1,[r0,#0x0]	; 0232E2D2
	mov r0,#0x0	; 0232E2D4
	cmp r1,#0x0	; 0232E2D6
	beq loc_0232E2E2	; 0232E2D8
loc_0232E2DA:
	add r0,r0,#0x1	; 0232E2DA
	ldr r1,[r1,#0x0]	; 0232E2DC
	cmp r1,#0x0	; 0232E2DE
	bne loc_0232E2DA	; 0232E2E0
loc_0232E2E2:
	bx lr	; 0232E2E2
pool_0232E2E4:
loc_0232E2E4:
	.word P1_BssStart + 0x266D0	; 0232E2E4

; ===== function loc_0232E2E8 =====
loc_0232E2E8:
	ldr r1,[pool_0232E310]	; 0232E2E8
	ldr r1,[r1,#0x0]	; 0232E2EA
	cmp r0,r1	; 0232E2EC
	bls loc_0232E300	; 0232E2EE
	sub r1,r0,r1	; 0232E2F0
	ldr r0,[pool_0232E314]	; 0232E2F2
	cmp r1,r0	; 0232E2F4
	bcc loc_0232E2FC	; 0232E2F6
	mov r0,#0x1	; 0232E2F8
	bx lr	; 0232E2FA
loc_0232E2FC:
	mov r0,#0x0	; 0232E2FC
	bx lr	; 0232E2FE
loc_0232E300:
	sub r1,r1,r0	; 0232E300
	ldr r0,[pool_0232E314]	; 0232E302
	cmp r1,r0	; 0232E304
	bcs loc_0232E30C	; 0232E306
	mov r0,#0x1	; 0232E308
	bx lr	; 0232E30A
loc_0232E30C:
	mov r0,#0x0	; 0232E30C
	bx lr	; 0232E30E
pool_0232E310:
loc_0232E310:
	.word P1_BssStart + 0x266D4	; 0232E310
pool_0232E314:
loc_0232E314:
	.word 0x80000000	; 0232E314

; ===== function loc_0232E318 =====
loc_0232E318:
	ldr r0,[pool_0232E32C]	; 0232E318
	ldr r0,[r0,#0x0]	; 0232E31A
	cmp r0,#0x0	; 0232E31C
	bne loc_0232E326	; 0232E31E
	ldr r0,[pool_0232E330]	; 0232E320
	ldr r0,[r0,#0x0]	; 0232E322
	bx lr	; 0232E324
loc_0232E326:
	ldr r0,[pool_0232E334]	; 0232E326
	ldr r0,[r0,#0x0]	; 0232E328
	bx lr	; 0232E32A
pool_0232E32C:
loc_0232E32C:
	.word P1_BssStart + 0x266D8	; 0232E32C
pool_0232E330:
loc_0232E330:
	.word P1_BssStart + 0x266D4	; 0232E330
pool_0232E334:
loc_0232E334:
	.word P1_BssStart + 0x266F0	; 0232E334

; ===== function loc_0232E338 =====
loc_0232E338:
	push {r4,r5,lr}	; 0232E338
	sub sp,#0x4	; 0232E33A
	add r4,r0,#0x0	; 0232E33C
	bl loc_0232E2E8	; 0232E33E
	cmp r0,#0x0	; 0232E342
	bne loc_0232E37C	; 0232E344
	mov r5,#0x0	; 0232E346
loc_0232E348:
	add r0,r5,#0x0	; 0232E348
	bl loc_0232E4DC	; 0232E34A
	cmp r0,#0x0	; 0232E34E
	bne loc_0232E348	; 0232E350
	add r0,r4,#0x0	; 0232E352
	bl loc_0232E2E8	; 0232E354
	cmp r0,#0x0	; 0232E358
	bne loc_0232E37C	; 0232E35A
	bl loc_0232E21C	; 0232E35C
	add r0,r4,#0x0	; 0232E360
	bl loc_0232E2E8	; 0232E362
	cmp r0,#0x0	; 0232E366
	bne loc_0232E37C	; 0232E368
	mov r5,#0x1	; 0232E36A
loc_0232E36C:
	add r0,r5,#0x0	; 0232E36C
	bl loc_0232E4DC	; 0232E36E
	add r0,r4,#0x0	; 0232E372
	bl loc_0232E2E8	; 0232E374
	cmp r0,#0x0	; 0232E378
	beq loc_0232E36C	; 0232E37A
loc_0232E37C:
	add sp,#0x4	; 0232E37C
	pop {r4,r5}	; 0232E37E
	pop {r3}	; 0232E380
	bx r3	; 0232E382

; ===== function loc_0232E384 =====
loc_0232E384:
	push {r4,lr}	; 0232E384
	add r4,r0,#0x0	; 0232E386
	ldr r0,[pool_0232E42C]	; 0232E388
	ldr r0,[r0,#0x0]	; 0232E38A
	cmp r0,#0x0	; 0232E38C
	bne loc_0232E398	; 0232E38E
	mov r0,#0x1	; 0232E390
	pop {r4}	; 0232E392
	pop {r3}	; 0232E394
	bx r3	; 0232E396
loc_0232E398:
	ldr r0,[pool_0232E430]	; 0232E398
	ldr r0,[r0,#0x0]	; 0232E39A
	cmp r0,#0x8	; 0232E39C
	blt loc_0232E3BA	; 0232E39E
	cmp r4,#0x0	; 0232E3A0
	bne loc_0232E3AC	; 0232E3A2
	mov r0,#0x0	; 0232E3A4
	pop {r4}	; 0232E3A6
	pop {r3}	; 0232E3A8
	bx r3	; 0232E3AA
loc_0232E3AC:
	mov r0,#0x1	; 0232E3AC
	bl loc_0232E4DC	; 0232E3AE
	ldr r0,[pool_0232E430]	; 0232E3B2
	ldr r0,[r0,#0x0]	; 0232E3B4
	cmp r0,#0x8	; 0232E3B6
	bge loc_0232E3AC	; 0232E3B8
loc_0232E3BA:
	ldr r0,[pool_0232E434]	; 0232E3BA
	ldr r1,[pool_0232E438]	; 0232E3BC
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E3BE
	mov r0,#0x7	; 0232E3C2
	ldr r1,[pool_0232E42C]	; 0232E3C4
	ldr r1,[r1,#0x0]	; 0232E3C6
	mov r2,#0x0	; 0232E3C8
	bl loc_0232E8C4	; 0232E3CA
	cmp r0,#0x0	; 0232E3CE
	bge loc_0232E3EE	; 0232E3D0
	cmp r4,#0x0	; 0232E3D2
	bne loc_0232E3DE	; 0232E3D4
	mov r0,#0x0	; 0232E3D6
	pop {r4}	; 0232E3D8
	pop {r3}	; 0232E3DA
	bx r3	; 0232E3DC
loc_0232E3DE:
	mov r0,#0x7	; 0232E3DE
	ldr r1,[pool_0232E42C]	; 0232E3E0
	ldr r1,[r1,#0x0]	; 0232E3E2
	mov r2,#0x0	; 0232E3E4
	bl loc_0232E8C4	; 0232E3E6
	cmp r0,#0x0	; 0232E3EA
	blt loc_0232E3DE	; 0232E3EC
loc_0232E3EE:
	ldr r0,[pool_0232E42C]	; 0232E3EE
	ldr r4,[r0,#0x0]	; 0232E3F0
	ldr r0,[pool_0232E43C]	; 0232E3F2
	ldr r2,[r0,#0x0]	; 0232E3F4
	lsl r3,r2,#0x2	; 0232E3F6
	ldr r1,[pool_0232E440]	; 0232E3F8
	str r4,[r1,r3]	; 0232E3FA
	add r1,r2,#0x1	; 0232E3FC
	str r1,[r0,#0x0]	; 0232E3FE
	cmp r1,#0x8	; 0232E400
	ble loc_0232E408	; 0232E402
	mov r1,#0x0	; 0232E404
	str r1,[r0,#0x0]	; 0232E406
loc_0232E408:
	mov r1,#0x0	; 0232E408
	ldr r0,[pool_0232E42C]	; 0232E40A
	str r1,[r0,#0x0]	; 0232E40C
	ldr r0,[pool_0232E444]	; 0232E40E
	str r1,[r0,#0x0]	; 0232E410
	ldr r0,[pool_0232E430]	; 0232E412
	ldr r1,[r0,#0x0]	; 0232E414
	add r1,r1,#0x1	; 0232E416
	str r1,[r0,#0x0]	; 0232E418
	ldr r0,[pool_0232E448]	; 0232E41A
	ldr r1,[r0,#0x0]	; 0232E41C
	add r1,r1,#0x1	; 0232E41E
	str r1,[r0,#0x0]	; 0232E420
	mov r0,#0x1	; 0232E422
	pop {r4}	; 0232E424
	pop {r3}	; 0232E426
	bx r3	; 0232E428
	.byte 0xC0, 0x46	; 0232E42C
pool_0232E42C:
loc_0232E42C:
	.word P1_BssStart + 0x266D8	; 0232E42C
pool_0232E430:
loc_0232E430:
	.word P1_BssStart + 0x266EC	; 0232E430
pool_0232E434:
loc_0232E434:
	.word 0x02357420	; 0232E434
pool_0232E438:
loc_0232E438:
	.word 0x00001800	; 0232E438
pool_0232E43C:
loc_0232E43C:
	.word P1_BssStart + 0x266E8	; 0232E43C
pool_0232E440:
loc_0232E440:
	.word P1_BssStart + 0x266F4	; 0232E440
pool_0232E444:
loc_0232E444:
	.word P1_BssStart + 0x266DC	; 0232E444
pool_0232E448:
loc_0232E448:
	.word P1_BssStart + 0x266F0	; 0232E448

; ===== function loc_0232E44C =====
loc_0232E44C:
	ldr r2,[pool_0232E468]	; 0232E44C
	ldr r1,[r2,#0x0]	; 0232E44E
	cmp r1,#0x0	; 0232E450
	bne loc_0232E45C	; 0232E452
	ldr r1,[pool_0232E46C]	; 0232E454
	str r0,[r1,#0x0]	; 0232E456
	str r0,[r2,#0x0]	; 0232E458
	b loc_0232E460	; 0232E45A
loc_0232E45C:
	str r0,[r1,#0x0]	; 0232E45C
	str r0,[r2,#0x0]	; 0232E45E
loc_0232E460:
	mov r1,#0x0	; 0232E460
	str r1,[r0,#0x0]	; 0232E462
	bx lr	; 0232E464
	.byte 0xC0, 0x46	; 0232E468
pool_0232E468:
loc_0232E468:
	.word P1_BssStart + 0x266DC	; 0232E468
pool_0232E46C:
loc_0232E46C:
	.word P1_BssStart + 0x266D8	; 0232E46C

; ===== function loc_0232E470 =====
loc_0232E470:
	push {r4,lr}	; 0232E470
	add r4,r0,#0x0	; 0232E472
	bl loc_0232BA44	; 0232E474
	cmp r0,#0x0	; 0232E478
	beq loc_0232E484	; 0232E47A
	mov r0,#0x0	; 0232E47C
	pop {r4}	; 0232E47E
	pop {r3}	; 0232E480
	bx r3	; 0232E482
loc_0232E484:
	bl loc_0232E1F8	; 0232E484
	cmp r0,#0x0	; 0232E488
	bne loc_0232E4D4	; 0232E48A
	cmp r4,#0x0	; 0232E48C
	bne loc_0232E498	; 0232E48E
	mov r0,#0x0	; 0232E490
	pop {r4}	; 0232E492
	pop {r3}	; 0232E494
	bx r3	; 0232E496
loc_0232E498:
	bl loc_0232E29C	; 0232E498
	cmp r0,#0x0	; 0232E49C
	ble loc_0232E4BA	; 0232E49E
	mov r4,#0x0	; 0232E4A0
loc_0232E4A2:
	add r0,r4,#0x0	; 0232E4A2
	bl loc_0232E4DC	; 0232E4A4
	cmp r0,#0x0	; 0232E4A8
	bne loc_0232E4A2	; 0232E4AA
	bl loc_0232E1F8	; 0232E4AC
	cmp r0,#0x0	; 0232E4B0
	beq loc_0232E4C0	; 0232E4B2
	pop {r4}	; 0232E4B4
	pop {r3}	; 0232E4B6
	bx r3	; 0232E4B8
loc_0232E4BA:
	mov r0,#0x1	; 0232E4BA
	bl loc_0232E384	; 0232E4BC
loc_0232E4C0:
	bl loc_0232E21C	; 0232E4C0
	mov r4,#0x1	; 0232E4C4
loc_0232E4C6:
	add r0,r4,#0x0	; 0232E4C6
	bl loc_0232E4DC	; 0232E4C8
	bl loc_0232E1F8	; 0232E4CC
	cmp r0,#0x0	; 0232E4D0
	beq loc_0232E4C6	; 0232E4D2
loc_0232E4D4:
	pop {r4}	; 0232E4D4
	pop {r3}	; 0232E4D6
	bx r3	; 0232E4D8
	.byte 0x00, 0x00	; 0232E4DC

; ===== function loc_0232E4DC =====
loc_0232E4DC:
	push {lr}	; 0232E4DC
	sub sp,#0x4	; 0232E4DE
	cmp r0,#0x0	; 0232E4E0
	bne loc_0232E4F8	; 0232E4E2
	bl loc_0232E6FC	; 0232E4E4
	ldr r1,[pool_0232E554]	; 0232E4E8
	ldr r1,[r1,#0x0]	; 0232E4EA
	cmp r1,r0	; 0232E4EC
	bne loc_0232E504	; 0232E4EE
	mov r0,#0x0	; 0232E4F0
	add sp,#0x4	; 0232E4F2
	pop {r3}	; 0232E4F4
	bx r3	; 0232E4F6
loc_0232E4F8:
	bl loc_0232E6FC	; 0232E4F8
	ldr r1,[pool_0232E554]	; 0232E4FC
	ldr r1,[r1,#0x0]	; 0232E4FE
	cmp r1,r0	; 0232E500
	beq loc_0232E4F8	; 0232E502
loc_0232E504:
	ldr r1,[pool_0232E558]	; 0232E504
	ldr r2,[r1,#0x0]	; 0232E506
	lsl r3,r2,#0x2	; 0232E508
	ldr r0,[pool_0232E55C]	; 0232E50A
	ldr r0,[r0,r3]	; 0232E50C
	add r2,r2,#0x1	; 0232E50E
	str r2,[r1,#0x0]	; 0232E510
	cmp r2,#0x8	; 0232E512
	ble loc_0232E51A	; 0232E514
	mov r2,#0x0	; 0232E516
	str r2,[r1,#0x0]	; 0232E518
loc_0232E51A:
	add r2,r0,#0x0	; 0232E51A
	ldr r1,[r0,#0x0]	; 0232E51C
	cmp r1,#0x0	; 0232E51E
	beq loc_0232E52A	; 0232E520
loc_0232E522:
	ldr r2,[r2,#0x0]	; 0232E522
	ldr r1,[r2,#0x0]	; 0232E524
	cmp r1,#0x0	; 0232E526
	bne loc_0232E522	; 0232E528
loc_0232E52A:
	ldr r1,[pool_0232E560]	; 0232E52A
	ldr r1,[r1,#0x0]	; 0232E52C
	cmp r1,#0x0	; 0232E52E
	beq loc_0232E536	; 0232E530
	str r0,[r1,#0x0]	; 0232E532
	b loc_0232E53A	; 0232E534
loc_0232E536:
	ldr r1,[pool_0232E564]	; 0232E536
	str r0,[r1,#0x0]	; 0232E538
loc_0232E53A:
	ldr r1,[pool_0232E560]	; 0232E53A
	str r2,[r1,#0x0]	; 0232E53C
	ldr r1,[pool_0232E568]	; 0232E53E
	ldr r2,[r1,#0x0]	; 0232E540
	sub r2,r2,#0x1	; 0232E542
	str r2,[r1,#0x0]	; 0232E544
	ldr r1,[pool_0232E554]	; 0232E546
	ldr r2,[r1,#0x0]	; 0232E548
	add r2,r2,#0x1	; 0232E54A
	str r2,[r1,#0x0]	; 0232E54C
	add sp,#0x4	; 0232E54E
	pop {r3}	; 0232E550
	bx r3	; 0232E552
pool_0232E554:
loc_0232E554:
	.word P1_BssStart + 0x266D4	; 0232E554
pool_0232E558:
loc_0232E558:
	.word P1_BssStart + 0x266E4	; 0232E558
pool_0232E55C:
loc_0232E55C:
	.word P1_BssStart + 0x266F4	; 0232E55C
pool_0232E560:
loc_0232E560:
	.word P1_BssStart + 0x266E0	; 0232E560
pool_0232E564:
loc_0232E564:
	.word P1_BssStart + 0x266D0	; 0232E564
pool_0232E568:
loc_0232E568:
	.word P1_BssStart + 0x266EC	; 0232E568

; ===== function loc_0232E56C =====
loc_0232E56C:
	push {r4,lr}	; 0232E56C
	bl loc_0232E23C	; 0232E56E
	ldr r3,[pool_0232E5E8]	; 0232E572
	ldr r0,[pool_0232E5EC]	; 0232E574
	str r3,[r0,#0x0]	; 0232E576
	mov r4,#0x0	; 0232E578
	add r2,r3,#0x0	; 0232E57A
	mov r0,#0x18	; 0232E57C
loc_0232E57E:
	add r4,r4,#0x1	; 0232E57E
	add r1,r4,#0x0	; 0232E580
	mul r1,r0	; 0232E582
	add r1,r2,r1	; 0232E584
	str r1,[r3,#0x0]	; 0232E586
	add r3,#0x18	; 0232E588
	cmp r4,#0xff	; 0232E58A
	blt loc_0232E57E	; 0232E58C
	mov r0,#0x0	; 0232E58E
	ldr r1,[pool_0232E5F0]	; 0232E590
	str r0,[r1,#0x68]	; 0232E592
	ldr r2,[pool_0232E5F4]	; 0232E594
	ldr r1,[pool_0232E5F8]	; 0232E596
	str r2,[r1,#0x0]	; 0232E598
	ldr r1,[pool_0232E5FC]	; 0232E59A
	str r0,[r1,#0x0]	; 0232E59C
	ldr r1,[pool_0232E600]	; 0232E59E
	str r0,[r1,#0x0]	; 0232E5A0
	ldr r1,[pool_0232E604]	; 0232E5A2
	str r0,[r1,#0x0]	; 0232E5A4
	ldr r1,[pool_0232E608]	; 0232E5A6
	str r0,[r1,#0x0]	; 0232E5A8
	ldr r1,[pool_0232E60C]	; 0232E5AA
	str r0,[r1,#0x0]	; 0232E5AC
	mov r2,#0x1	; 0232E5AE
	ldr r1,[pool_0232E610]	; 0232E5B0
	str r2,[r1,#0x0]	; 0232E5B2
	ldr r1,[pool_0232E614]	; 0232E5B4
	str r0,[r1,#0x0]	; 0232E5B6
	ldr r0,[pool_0232E618]	; 0232E5B8
	ldr r1,[pool_0232E61C]	; 0232E5BA
	str r0,[r1,#0x0]	; 0232E5BC
	bl loc_0232E6AC	; 0232E5BE
	mov r0,#0x1	; 0232E5C2
	bl loc_0232E470	; 0232E5C4
	cmp r0,#0x0	; 0232E5C8
	beq loc_0232E5E0	; 0232E5CA
	mov r1,#0x19	; 0232E5CC
	str r1,[r0,#0x4]	; 0232E5CE
	ldr r1,[pool_0232E61C]	; 0232E5D0
	ldr r1,[r1,#0x0]	; 0232E5D2
	str r1,[r0,#0x8]	; 0232E5D4
	bl loc_0232E44C	; 0232E5D6
	mov r0,#0x1	; 0232E5DA
	bl loc_0232E384	; 0232E5DC
loc_0232E5E0:
	pop {r4}	; 0232E5E0
	pop {r3}	; 0232E5E2
	bx r3	; 0232E5E4
	.byte 0xC0, 0x46	; 0232E5E8
pool_0232E5E8:
loc_0232E5E8:
	.word P1_BssStart + 0x269A0	; 0232E5E8
pool_0232E5EC:
loc_0232E5EC:
	.word P1_BssStart + 0x266D0	; 0232E5EC
pool_0232E5F0:
loc_0232E5F0:
	.word P1_BssStart + 0x28120	; 0232E5F0
pool_0232E5F4:
loc_0232E5F4:
	.word 0x02358C08	; 0232E5F4
pool_0232E5F8:
loc_0232E5F8:
	.word P1_BssStart + 0x266E0	; 0232E5F8
pool_0232E5FC:
loc_0232E5FC:
	.word P1_BssStart + 0x266D8	; 0232E5FC
pool_0232E600:
loc_0232E600:
	.word P1_BssStart + 0x266DC	; 0232E600
pool_0232E604:
loc_0232E604:
	.word P1_BssStart + 0x266EC	; 0232E604
pool_0232E608:
loc_0232E608:
	.word P1_BssStart + 0x266E4	; 0232E608
pool_0232E60C:
loc_0232E60C:
	.word P1_BssStart + 0x266E8	; 0232E60C
pool_0232E610:
loc_0232E610:
	.word P1_BssStart + 0x266F0	; 0232E610
pool_0232E614:
loc_0232E614:
	.word P1_BssStart + 0x266D4	; 0232E614
pool_0232E618:
loc_0232E618:
	.word 0x023571A0	; 0232E618
pool_0232E61C:
loc_0232E61C:
	.word P1_BssStart + 0x28200	; 0232E61C

; ===== function loc_0232E620 =====
loc_0232E620:
	push {r4,lr}	; 0232E620
	ldr r4,[pool_0232E64C]	; 0232E622
	mov r2,#0xff	; 0232E624
	add r3,r0,#0x0	; 0232E626
	and r3,r2	; 0232E628
	mov r1,#0xc	; 0232E62A
	mul r3,r1	; 0232E62C
	add r3,r4,r3	; 0232E62E
	asr r1,r0,#0x8	; 0232E630
	and r1,r2	; 0232E632
	ldrb r0,[r3,#0x8]	; 0232E634
	cmp r1,r0	; 0232E636
	bne loc_0232E644	; 0232E638
	ldr r1,[r3,#0x0]	; 0232E63A
	cmp r1,#0x0	; 0232E63C
	beq loc_0232E644	; 0232E63E
	ldr r0,[r3,#0x4]	; 0232E640
	blx r1	; 0232E642
loc_0232E644:
	pop {r4}	; 0232E644
	pop {r3}	; 0232E646
	bx r3	; 0232E648
	.byte 0xC0, 0x46	; 0232E64C
pool_0232E64C:
loc_0232E64C:
	.word 0x02358C20	; 0232E64C

; ===== function loc_0232E650 =====
loc_0232E650:
	push {r4}	; 0232E650
	sub sp,#0x4	; 0232E652
	ldr r4,[pool_0232E674]	; 0232E654
	mov r3,#0xc	; 0232E656
	mul r0,r3	; 0232E658
	add r3,r4,r0	; 0232E65A
	str r1,[r4,r0]	; 0232E65C
	str r2,[r3,#0x4]	; 0232E65E
	add r1,r3,#0x0	; 0232E660
	add r1,#0x8	; 0232E662
	ldrb r0,[r1,#0x0]	; 0232E664
	add r0,r0,#0x1	; 0232E666
	strb r0,[r1,#0x0]	; 0232E668
	ldrb r0,[r3,#0x8]	; 0232E66A
	add sp,#0x4	; 0232E66C
	pop {r4}	; 0232E66E
	bx lr	; 0232E670
	.byte 0xC0, 0x46	; 0232E674
pool_0232E674:
loc_0232E674:
	.word P1_BssStart + 0x281A0	; 0232E674

; ===== function loc_0232E678 =====
loc_0232E678:
	ldr r2,[pool_0232E68C]	; 0232E678
	mov r1,#0xc	; 0232E67A
	mul r0,r1	; 0232E67C
	add r1,r2,r0	; 0232E67E
	add r1,#0x8	; 0232E680
	ldrb r0,[r1,#0x0]	; 0232E682
	add r0,r0,#0x1	; 0232E684
	strb r0,[r1,#0x0]	; 0232E686
	bx lr	; 0232E688
	.byte 0xC0, 0x46	; 0232E68C
pool_0232E68C:
loc_0232E68C:
	.word 0x02358C20	; 0232E68C

; ===== function loc_0232E690 =====
loc_0232E690:
	mov r2,#0x0	; 0232E690
	ldr r1,[pool_0232E6A8]	; 0232E692
	add r0,r2,#0x0	; 0232E694
loc_0232E696:
	str r0,[r1,#0x0]	; 0232E696
	str r0,[r1,#0x4]	; 0232E698
	strb r0,[r1,#0x8]	; 0232E69A
	add r1,#0xc	; 0232E69C
	add r2,r2,#0x1	; 0232E69E
	cmp r2,#0x8	; 0232E6A0
	blt loc_0232E696	; 0232E6A2
	bx lr	; 0232E6A4
	.byte 0xC0, 0x46	; 0232E6A8
pool_0232E6A8:
loc_0232E6A8:
	.word P1_BssStart + 0x281A0	; 0232E6A8

; ===== function loc_0232E6AC =====
loc_0232E6AC:
	push {r4,r5,r6,lr}	; 0232E6AC
	mov r6,#0x0	; 0232E6AE
	str r6,[r0,#0x4]	; 0232E6B0
	strh r6,[r0,#0x8]	; 0232E6B2
	strh r6,[r0,#0xa]	; 0232E6B4
	str r6,[r0,#0x0]	; 0232E6B6
	add r4,r0,#0x0	; 0232E6B8
	mvn r1,r6	; 0232E6BA
	add r2,r6,#0x0	; 0232E6BC
loc_0232E6BE:
	str r2,[r4,#0x40]	; 0232E6BE
	add r5,r2,#0x0	; 0232E6C0
	add r3,r4,#0x0	; 0232E6C2
loc_0232E6C4:
	strh r1,[r3,#0x20]	; 0232E6C4
	add r3,r3,#0x2	; 0232E6C6
	add r5,r5,#0x1	; 0232E6C8
	cmp r5,#0x10	; 0232E6CA
	blt loc_0232E6C4	; 0232E6CC
	add r4,#0x24	; 0232E6CE
	add r6,r6,#0x1	; 0232E6D0
	cmp r6,#0x10	; 0232E6D2
	blt loc_0232E6BE	; 0232E6D4
	mov r3,#0x0	; 0232E6D6
	add r4,r0,#0x0	; 0232E6D8
	mvn r2,r3	; 0232E6DA
	ldr r1,[pool_0232E6F4]	; 0232E6DC
loc_0232E6DE:
	strh r2,[r4,r1]	; 0232E6DE
	add r4,r4,#0x2	; 0232E6E0
	add r3,r3,#0x1	; 0232E6E2
	cmp r3,#0x10	; 0232E6E4
	blt loc_0232E6DE	; 0232E6E6
	ldr r1,[pool_0232E6F8]	; 0232E6E8
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E6EA
	pop {r4,r5,r6}	; 0232E6EE
	pop {r3}	; 0232E6F0
	bx r3	; 0232E6F2
pool_0232E6F4:
loc_0232E6F4:
	.word 0x00000260	; 0232E6F4
pool_0232E6F8:
loc_0232E6F8:
	.word 0x00000280	; 0232E6F8

; ===== function loc_0232E6FC =====
loc_0232E6FC:
	push {lr}	; 0232E6FC
	sub sp,#0x4	; 0232E6FE
	ldr r0,[pool_0232E718]	; 0232E700
	ldr r0,[r0,#0x0]	; 0232E702
	ldr r1,[pool_0232E71C]	; 0232E704
	blx P1_InvalidateDataCacheRange	; 0232E706
	ldr r0,[pool_0232E718]	; 0232E70A
	ldr r0,[r0,#0x0]	; 0232E70C
	ldr r0,[r0,#0x0]	; 0232E70E
	add sp,#0x4	; 0232E710
	pop {r3}	; 0232E712
	bx r3	; 0232E714
	.byte 0xC0, 0x46	; 0232E718
pool_0232E718:
loc_0232E718:
	.word P1_BssStart + 0x28200	; 0232E718
pool_0232E71C:
loc_0232E71C:
	.word 0x00000280	; 0232E71C

; ===== function loc_0232E720 =====
loc_0232E720:
	push {lr}	; 0232E720
	sub sp,#0x4	; 0232E722
	ldr r0,[pool_0232E73C]	; 0232E724
	ldr r0,[r0,#0x0]	; 0232E726
	ldr r1,[pool_0232E740]	; 0232E728
	blx P1_InvalidateDataCacheRange	; 0232E72A
	ldr r0,[pool_0232E73C]	; 0232E72E
	ldr r0,[r0,#0x0]	; 0232E730
	ldrh r0,[r0,#0x8]	; 0232E732
	add sp,#0x4	; 0232E734
	pop {r3}	; 0232E736
	bx r3	; 0232E738
	.byte 0xC0, 0x46	; 0232E73C
pool_0232E73C:
loc_0232E73C:
	.word P1_BssStart + 0x28200	; 0232E73C
pool_0232E740:
loc_0232E740:
	.word 0x00000280	; 0232E740

; ===== function loc_0232E744 =====
loc_0232E744:
	push {lr}	; 0232E744
	sub sp,#0x4	; 0232E746
	ldr r0,[pool_0232E760]	; 0232E748
	ldr r0,[r0,#0x0]	; 0232E74A
	ldr r1,[pool_0232E764]	; 0232E74C
	blx P1_InvalidateDataCacheRange	; 0232E74E
	ldr r0,[pool_0232E760]	; 0232E752
	ldr r0,[r0,#0x0]	; 0232E754
	ldr r0,[r0,#0x4]	; 0232E756
	add sp,#0x4	; 0232E758
	pop {r3}	; 0232E75A
	bx r3	; 0232E75C
	.byte 0xC0, 0x46	; 0232E760
pool_0232E760:
loc_0232E760:
	.word P1_BssStart + 0x28200	; 0232E760
pool_0232E764:
loc_0232E764:
	.word 0x00000280	; 0232E764

; ===== function loc_0232E768 =====
loc_0232E768:
	push {r4,r5,r6,r7,lr}	; 0232E768
	sub sp,#0x4	; 0232E76A
	add r5,r0,#0x0	; 0232E76C
	add r7,r1,#0x0	; 0232E76E
	add r4,r2,#0x0	; 0232E770
	lsl r2,r7,#0x3	; 0232E772
	add r1,r5,r2	; 0232E774
	ldr r0,[r1,#0x18]	; 0232E776
	cmp r0,#0x0	; 0232E778
	beq loc_0232E7B8	; 0232E77A
	cmp r4,r0	; 0232E77C
	beq loc_0232E7DA	; 0232E77E
	ldr r6,[r0,#0x18]	; 0232E780
	add r3,r5,#0x0	; 0232E782
	add r3,#0x18	; 0232E784
	add r3,r3,r2	; 0232E786
	cmp r3,r6	; 0232E788
	bne loc_0232E79A	; 0232E78A
	ldr r2,[r1,#0x1c]	; 0232E78C
	str r2,[r0,#0x18]	; 0232E78E
	ldr r0,[r1,#0x18]	; 0232E790
	mov r1,#0x3c	; 0232E792
	blx P1_CleanDataCacheRange	; 0232E794
	b loc_0232E7B8	; 0232E798
loc_0232E79A:
	cmp r6,#0x0	; 0232E79A
	beq loc_0232E7AA	; 0232E79C
loc_0232E79E:
	ldr r0,[r6,#0x4]	; 0232E79E
	cmp r3,r0	; 0232E7A0
	beq loc_0232E7AA	; 0232E7A2
	add r6,r0,#0x0	; 0232E7A4
	cmp r0,#0x0	; 0232E7A6
	bne loc_0232E79E	; 0232E7A8
loc_0232E7AA:
	add r0,r5,r2	; 0232E7AA
	ldr r0,[r0,#0x1c]	; 0232E7AC
	str r0,[r6,#0x4]	; 0232E7AE
	add r0,r6,#0x0	; 0232E7B0
	mov r1,#0x8	; 0232E7B2
	blx P1_CleanDataCacheRange	; 0232E7B4
loc_0232E7B8:
	ldr r0,[r4,#0x18]	; 0232E7B8
	lsl r3,r7,#0x3	; 0232E7BA
	add r2,r5,#0x0	; 0232E7BC
	add r2,#0x18	; 0232E7BE
	add r1,r2,r3	; 0232E7C0
	str r1,[r4,#0x18]	; 0232E7C2
	add r1,r5,r3	; 0232E7C4
	str r0,[r1,#0x1c]	; 0232E7C6
	str r4,[r2,r3]	; 0232E7C8
	add r0,r5,#0x0	; 0232E7CA
	mov r1,#0x3c	; 0232E7CC
	blx P1_CleanDataCacheRange	; 0232E7CE
	add r0,r4,#0x0	; 0232E7D2
	mov r1,#0x3c	; 0232E7D4
	blx P1_CleanDataCacheRange	; 0232E7D6
loc_0232E7DA:
	add sp,#0x4	; 0232E7DA
	pop {r4,r5,r6,r7}	; 0232E7DC
	pop {r3}	; 0232E7DE
	bx r3	; 0232E7E0
	.byte 0x00, 0x00	; 0232E7E4

; ===== function loc_0232E7E4 =====
loc_0232E7E4:
	ldr r3,[pool_0232E7E8]	; 0232E7E4
	bx r3	; 0232E7E6
pool_0232E7E8:
loc_0232E7E8:
	.word loc_0232E9D4 + 1	; 0232E7E8

; ===== function loc_0232E7EC =====
P1_IrqHandler_0232E7EC:
	push {r4,r5,r6,r7,lr}	; 0232E7EC
	sub sp,#0x4	; 0232E7EE
	ldr r5,[pool_0232E8A8]	; 0232E7F0
	mov r0,#0x3	; 0232E7F2
	mvn r6,r0	; 0232E7F4
	mov r7,#0x2	; 0232E7F6
	mvn r4,r7	; 0232E7F8
loc_0232E7FA:
	ldrh r1,[r5,#0x0]	; 0232E7FA
	ldr r0,[pool_0232E8AC]	; 0232E7FC
	and r1,r0	; 0232E7FE
	cmp r1,#0x0	; 0232E800
	beq loc_0232E810	; 0232E802
	ldrh r1,[r5,#0x0]	; 0232E804
	ldr r0,[pool_0232E8B0]	; 0232E806
	orr r1,r0	; 0232E808
	strh r1,[r5,#0x0]	; 0232E80A
	add r0,r4,#0x0	; 0232E80C
	b loc_0232E832	; 0232E80E
loc_0232E810:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E810
	ldrh r2,[r5,#0x0]	; 0232E814
	ldr r1,[pool_0232E8B4]	; 0232E816
	and r2,r1	; 0232E818
	cmp r2,#0x0	; 0232E81A
	beq loc_0232E826	; 0232E81C
	blx P1_Arm9RestoreIrqMask	; 0232E81E
	add r0,r6,#0x0	; 0232E822
	b loc_0232E832	; 0232E824
loc_0232E826:
	ldr r1,[pool_0232E8B8]	; 0232E826
	ldr r1,[r1,#0x0]	; 0232E828
	str r1,[sp,#0x0]	; 0232E82A
	blx P1_Arm9RestoreIrqMask	; 0232E82C
	mov r0,#0x0	; 0232E830
loc_0232E832:
	mov r1,#0x3	; 0232E832
	mvn r1,r1	; 0232E834
	cmp r0,r1	; 0232E836
	beq loc_0232E89E	; 0232E838
	mvn r1,r7	; 0232E83A
	cmp r0,r1	; 0232E83C
	beq loc_0232E7FA	; 0232E83E
	ldr r2,[sp,#0x0]	; 0232E840
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 0232E842
	lsr r0,r0,#0x1b	; 0232E844
	cmp r0,#0x0	; 0232E846
	beq loc_0232E7FA	; 0232E848
	lsl r3,r0,#0x2	; 0232E84A
	ldr r1,[pool_0232E8BC]	; 0232E84C
	ldr r3,[r1,r3]	; 0232E84E
	cmp r3,#0x0	; 0232E850
	beq loc_0232E85E	; 0232E852
	lsr r1,r2,#0x6	; 0232E854
	lsl r2,r2,#0x1a	; 0232E856
	lsr r2,r2,#0x1f	; 0232E858
	blx r3	; 0232E85A
	b loc_0232E7FA	; 0232E85C
loc_0232E85E:
	lsl r0,r2,#0x1a	; 0232E85E
	lsr r0,r0,#0x1f	; 0232E860
	cmp r0,#0x0	; 0232E862
	bne loc_0232E7FA	; 0232E864
	mov r0,#0x20	; 0232E866
	orr r2,r0	; 0232E868
	str r2,[sp,#0x0]	; 0232E86A
	ldrh r1,[r5,#0x0]	; 0232E86C
	ldr r0,[pool_0232E8AC]	; 0232E86E
	and r1,r0	; 0232E870
	cmp r1,#0x0	; 0232E872
	beq loc_0232E880	; 0232E874
	ldrh r1,[r5,#0x0]	; 0232E876
	ldr r0,[pool_0232E8B0]	; 0232E878
	orr r1,r0	; 0232E87A
	strh r1,[r5,#0x0]	; 0232E87C
	b loc_0232E7FA	; 0232E87E
loc_0232E880:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E880
	ldrh r1,[r5,#0x0]	; 0232E884
	and r1,r7	; 0232E886
	cmp r1,#0x0	; 0232E888
	beq loc_0232E892	; 0232E88A
	blx P1_Arm9RestoreIrqMask	; 0232E88C
	b loc_0232E7FA	; 0232E890
loc_0232E892:
	ldr r2,[sp,#0x0]	; 0232E892
	ldr r1,[pool_0232E8C0]	; 0232E894
	str r2,[r1,#0x0]	; 0232E896
	blx P1_Arm9RestoreIrqMask	; 0232E898
	b loc_0232E7FA	; 0232E89C
loc_0232E89E:
	add sp,#0x4	; 0232E89E
	pop {r4,r5,r6,r7}	; 0232E8A0
	pop {r3}	; 0232E8A2
	bx r3	; 0232E8A4
	.byte 0xC0, 0x46	; 0232E8A8
pool_0232E8A8:
loc_0232E8A8:
	.word REG_IPC_FIFO_CR	; 0232E8A8
pool_0232E8AC:
loc_0232E8AC:
	.word 0x00004000	; 0232E8AC
pool_0232E8B0:
loc_0232E8B0:
	.word 0x0000C000	; 0232E8B0
pool_0232E8B4:
loc_0232E8B4:
	.word 0x00000100	; 0232E8B4
pool_0232E8B8:
loc_0232E8B8:
	.word REG_IPC_FIFO_RX	; 0232E8B8
pool_0232E8BC:
loc_0232E8BC:
	.word P1_PxiReceiveCallbacks	; 0232E8BC
pool_0232E8C0:
loc_0232E8C0:
	.word REG_IPC_FIFO_TX	; 0232E8C0

; ===== function loc_0232E8C4 =====
loc_0232E8C4:
	push {r4,lr}	; 0232E8C4
	sub sp,#0x8	; 0232E8C6
	ldr r3,[sp,#0x0]	; 0232E8C8
	mov r4,#0x1f	; 0232E8CA
	bic r3,r4	; 0232E8CC
	and r0,r4	; 0232E8CE
	orr r3,r0	; 0232E8D0
	str r3,[sp,#0x0]	; 0232E8D2
	mov r0,#0x20	; 0232E8D4
	bic r3,r0	; 0232E8D6
	mov r0,#0x1	; 0232E8D8
	and r2,r0	; 0232E8DA
	lsl r0,r2,#0x5	; 0232E8DC
	orr r3,r0	; 0232E8DE
	str r3,[sp,#0x0]	; 0232E8E0
	mov r0,#0x3f	; 0232E8E2
	and r3,r0	; 0232E8E4
	ldr r0,[pool_0232E944]	; 0232E8E6
	and r1,r0	; 0232E8E8
	lsl r0,r1,#0x6	; 0232E8EA
	orr r3,r0	; 0232E8EC
	str r3,[sp,#0x0]	; 0232E8EE
	ldr r2,[pool_0232E948]	; 0232E8F0
	ldrh r1,[r2,#0x0]	; 0232E8F2
	ldr r0,[pool_0232E94C]	; 0232E8F4
	and r1,r0	; 0232E8F6
	cmp r1,#0x0	; 0232E8F8
	beq loc_0232E910	; 0232E8FA
	ldrh r1,[r2,#0x0]	; 0232E8FC
	ldr r0,[pool_0232E950]	; 0232E8FE
	orr r1,r0	; 0232E900
	strh r1,[r2,#0x0]	; 0232E902
	mov r0,#0x0	; 0232E904
	mvn r0,r0	; 0232E906
	add sp,#0x8	; 0232E908
	pop {r4}	; 0232E90A
	pop {r3}	; 0232E90C
	bx r3	; 0232E90E
loc_0232E910:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E910
	ldr r1,[pool_0232E948]	; 0232E914
	ldrh r2,[r1,#0x0]	; 0232E916
	mov r1,#0x2	; 0232E918
	and r2,r1	; 0232E91A
	cmp r2,#0x0	; 0232E91C
	beq loc_0232E930	; 0232E91E
	blx P1_Arm9RestoreIrqMask	; 0232E920
	mov r0,#0x1	; 0232E924
	mvn r0,r0	; 0232E926
	add sp,#0x8	; 0232E928
	pop {r4}	; 0232E92A
	pop {r3}	; 0232E92C
	bx r3	; 0232E92E
loc_0232E930:
	ldr r2,[sp,#0x0]	; 0232E930
	ldr r1,[pool_0232E954]	; 0232E932
	str r2,[r1,#0x0]	; 0232E934
	blx P1_Arm9RestoreIrqMask	; 0232E936
	mov r0,#0x0	; 0232E93A
	add sp,#0x8	; 0232E93C
	pop {r4}	; 0232E93E
	pop {r3}	; 0232E940
	bx r3	; 0232E942
pool_0232E944:
loc_0232E944:
	.word 0x03FFFFFF	; 0232E944
pool_0232E948:
loc_0232E948:
	.word REG_IPC_FIFO_CR	; 0232E948
pool_0232E94C:
loc_0232E94C:
	.word 0x00004000	; 0232E94C
pool_0232E950:
loc_0232E950:
	.word 0x0000C000	; 0232E950
pool_0232E954:
loc_0232E954:
	.word REG_IPC_FIFO_TX	; 0232E954

; ===== function loc_0232E958 =====
loc_0232E958:
	push {r4}	; 0232E958
	sub sp,#0x4	; 0232E95A
	mov r3,#0x1	; 0232E95C
	add r2,r3,#0x0	; 0232E95E
	lsl r2,r0	; 0232E960
	ldr r4,[pool_0232E97C]	; 0232E962
	lsl r0,r1,#0x2	; 0232E964
	add r1,r4,r0	; 0232E966
	ldr r0,[pool_0232E980]	; 0232E968
	ldr r0,[r1,r0]	; 0232E96A
	and r2,r0	; 0232E96C
	cmp r2,#0x0	; 0232E96E
	bne loc_0232E974	; 0232E970
	mov r3,#0x0	; 0232E972
loc_0232E974:
	add r0,r3,#0x0	; 0232E974
	add sp,#0x4	; 0232E976
	pop {r4}	; 0232E978
	bx lr	; 0232E97A
pool_0232E97C:
loc_0232E97C:
	.word 0x027FFC00	; 0232E97C
pool_0232E980:
loc_0232E980:
	.word 0x00000388	; 0232E980

; ===== function loc_0232E984 =====
loc_0232E984:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P1_SetPxiReceiveCallback
	push {r4,r5,lr}	; 0232E984
	sub sp,#0x4	; 0232E986
	add r5,r0,#0x0	; 0232E988
	add r4,r1,#0x0	; 0232E98A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E98C
	lsl r2,r5,#0x2	; 0232E990
	ldr r1,[pool_0232E9C8]	; 0232E992
	str r4,[r1,r2]	; 0232E994
	cmp r4,#0x0	; 0232E996
	beq loc_0232E9AC	; 0232E998
	ldr r2,[pool_0232E9CC]	; 0232E99A
	ldr r1,[pool_0232E9D0]	; 0232E99C
	add r1,r2,r1	; 0232E99E
	ldr r3,[r1,#0x0]	; 0232E9A0
	mov r2,#0x1	; 0232E9A2
	lsl r2,r5	; 0232E9A4
	orr r3,r2	; 0232E9A6
	str r3,[r1,#0x0]	; 0232E9A8
	b loc_0232E9BC	; 0232E9AA
loc_0232E9AC:
	ldr r2,[pool_0232E9CC]	; 0232E9AC
	ldr r1,[pool_0232E9D0]	; 0232E9AE
	add r1,r2,r1	; 0232E9B0
	ldr r3,[r1,#0x0]	; 0232E9B2
	mov r2,#0x1	; 0232E9B4
	lsl r2,r5	; 0232E9B6
	bic r3,r2	; 0232E9B8
	str r3,[r1,#0x0]	; 0232E9BA
loc_0232E9BC:
	blx P1_Arm9RestoreIrqMask	; 0232E9BC
	add sp,#0x4	; 0232E9C0
	pop {r4,r5}	; 0232E9C2
	pop {r3}	; 0232E9C4
	bx r3	; 0232E9C6
.endfunc
pool_0232E9C8:
loc_0232E9C8:
	.word P1_PxiReceiveCallbacks	; 0232E9C8
pool_0232E9CC:
loc_0232E9CC:
	.word FirmwareSystemWorkAddress	; 0232E9CC
pool_0232E9D0:
loc_0232E9D0:
	.word SystemWorkPxiArm9AvailableOffset	; 0232E9D0

; ===== function loc_0232E9D4 =====
loc_0232E9D4:
	push {r4,r5,r6,r7,lr}	; 0232E9D4
	sub sp,#0x4	; 0232E9D6
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E9D8
	str r0,[sp,#0x0]	; 0232E9DC
	ldr r0,[pool_0232EA5C]	; 0232E9DE
	ldrh r1,[r0,#0x0]	; 0232E9E0
	cmp r1,#0x0	; 0232E9E2
	bne loc_0232EA4C	; 0232E9E4
	mov r1,#0x1	; 0232E9E6
	strh r1,[r0,#0x0]	; 0232E9E8
	mov r2,#0x0	; 0232E9EA
	ldr r1,[pool_0232EA60]	; 0232E9EC
	ldr r0,[pool_0232EA64]	; 0232E9EE
	str r2,[r1,r0]	; 0232E9F0
	ldr r1,[pool_0232EA68]	; 0232E9F2
	add r0,r2,#0x0	; 0232E9F4
loc_0232E9F6:
	stmia r1!,{r0}	; 0232E9F6
	add r2,r2,#0x1	; 0232E9F8
	cmp r2,#PxiFifoChannelCount	; 0232E9FA
	blt loc_0232E9F6	; 0232E9FC
	ldr r0,[pool_0232EA6C]	; 0232E9FE
	ldr r1,[pool_0232EA70]	; 0232EA00
	bl loc_0232B1F0	; 0232EA02
	ldr r0,[pool_0232EA6C]	; 0232EA06
	bl loc_0232B16C	; 0232EA08
	ldr r1,[pool_0232EA74]	; 0232EA0C
	ldr r0,[pool_0232EA78]	; 0232EA0E
	strh r1,[r0,#0x0]	; 0232EA10
	mov r1,#0x0	; 0232EA12
	ldr r0,[pool_0232EA7C]	; 0232EA14
	add r6,r1,#0x0	; 0232EA16
	ldr r7,[pool_0232EA80]	; 0232EA18
	mov r4,#0xf	; 0232EA1A
loc_0232EA1C:
	ldrh r2,[r0,#0x0]	; 0232EA1C
	and r2,r4	; 0232EA1E
	lsl r3,r2,#0x8	; 0232EA20
	strh r3,[r0,#0x0]	; 0232EA22
	cmp r2,#0x0	; 0232EA24
	bne loc_0232EA2C	; 0232EA26
	cmp r1,#0x4	; 0232EA28
	bgt loc_0232EA4C	; 0232EA2A
loc_0232EA2C:
	add r3,r7,#0x0	; 0232EA2C
	ldrh r5,[r0,#0x0]	; 0232EA2E
	and r5,r4	; 0232EA30
	cmp r5,r2	; 0232EA32
	bne loc_0232EA48	; 0232EA34
loc_0232EA36:
	cmp r3,#0x0	; 0232EA36
	bgt loc_0232EA3E	; 0232EA38
	add r1,r6,#0x0	; 0232EA3A
	b loc_0232EA48	; 0232EA3C
loc_0232EA3E:
	sub r3,r3,#0x1	; 0232EA3E
	ldrh r5,[r0,#0x0]	; 0232EA40
	and r5,r4	; 0232EA42
	cmp r5,r2	; 0232EA44
	beq loc_0232EA36	; 0232EA46
loc_0232EA48:
	add r1,r1,#0x1	; 0232EA48
	b loc_0232EA1C	; 0232EA4A
loc_0232EA4C:
	ldr r0,[sp,#0x0]	; 0232EA4C
	blx P1_Arm9RestoreIrqMask	; 0232EA4E
	add sp,#0x4	; 0232EA52
	pop {r4,r5,r6,r7}	; 0232EA54
	pop {r3}	; 0232EA56
	bx r3	; 0232EA58
	.byte 0xC0, 0x46	; 0232EA5C
pool_0232EA5C:
loc_0232EA5C:
	.word P1_BssStart + 0x28204	; 0232EA5C
pool_0232EA60:
loc_0232EA60:
	.word FirmwareSystemWorkAddress	; 0232EA60
pool_0232EA64:
loc_0232EA64:
	.word SystemWorkPxiArm9AvailableOffset	; 0232EA64
pool_0232EA68:
loc_0232EA68:
	.word P1_PxiReceiveCallbacks	; 0232EA68
pool_0232EA6C:
loc_0232EA6C:
	.word 0x00040000	; 0232EA6C
pool_0232EA70:
loc_0232EA70:
	.word P1_IrqHandler_0232E7EC + 1	; 0232EA70
pool_0232EA74:
loc_0232EA74:
	.word 0x0000C408	; 0232EA74
pool_0232EA78:
loc_0232EA78:
	.word REG_IPC_FIFO_CR	; 0232EA78
pool_0232EA7C:
loc_0232EA7C:
	.word REG_IPC_SYNC	; 0232EA7C
pool_0232EA80:
loc_0232EA80:
	.word 0x000003E8	; 0232EA80

; ===== function loc_0232EA84 =====
loc_0232EA84:
; 恢复除法/开方操作数及模式。
; Restore division/square-root operands and modes.
.func P1_RestoreArithmeticContext
	ldr r3,[r0,#0x0]	; 0232EA84
	ldr r2,[r0,#0x4]	; 0232EA86
	ldr r1,[pool_0232EAB0]	; 0232EA88
	str r3,[r1,#0x0]	; 0232EA8A
	str r2,[r1,#0x4]	; 0232EA8C
	ldr r3,[r0,#0x8]	; 0232EA8E
	ldr r2,[r0,#0xc]	; 0232EA90
	ldr r1,[pool_0232EAB4]	; 0232EA92
	str r3,[r1,#0x0]	; 0232EA94
	str r2,[r1,#0x4]	; 0232EA96
	ldrh r2,[r0,#0x18]	; 0232EA98
	ldr r1,[pool_0232EAB8]	; 0232EA9A
	strh r2,[r1,#0x0]	; 0232EA9C
	ldr r3,[r0,#0x10]	; 0232EA9E
	ldr r2,[r0,#0x14]	; 0232EAA0
	ldr r1,[pool_0232EABC]	; 0232EAA2
	str r3,[r1,#0x0]	; 0232EAA4
	str r2,[r1,#0x4]	; 0232EAA6
	ldrh r1,[r0,#0x1a]	; 0232EAA8
	ldr r0,[pool_0232EAC0]	; 0232EAAA
	strh r1,[r0,#0x0]	; 0232EAAC
	bx lr	; 0232EAAE
.endfunc
pool_0232EAB0:
loc_0232EAB0:
	.word REG_DIV_NUMER	; 0232EAB0
pool_0232EAB4:
loc_0232EAB4:
	.word REG_DIV_DENOM	; 0232EAB4
pool_0232EAB8:
loc_0232EAB8:
	.word REG_DIVCNT	; 0232EAB8
pool_0232EABC:
loc_0232EABC:
	.word REG_SQRT_PARAM	; 0232EABC
pool_0232EAC0:
loc_0232EAC0:
	.word REG_SQRTCNT	; 0232EAC0

; ===== function loc_0232EAC4 =====
loc_0232EAC4:
; 保存除法/开方操作数及模式，不保存结果寄存器。
; Save division/square-root operands and modes, not the result registers.
.func P1_SaveArithmeticContext
	ldr r1,[pool_0232EAF8]	; 0232EAC4
	ldr r2,[r1,#0x0]	; 0232EAC6
	ldr r1,[r1,#0x4]	; 0232EAC8
	str r2,[r0,#0x0]	; 0232EACA
	str r1,[r0,#0x4]	; 0232EACC
	ldr r1,[pool_0232EAFC]	; 0232EACE
	ldr r2,[r1,#0x0]	; 0232EAD0
	ldr r1,[r1,#0x4]	; 0232EAD2
	str r2,[r0,#0x8]	; 0232EAD4
	str r1,[r0,#0xc]	; 0232EAD6
	ldr r1,[pool_0232EB00]	; 0232EAD8
	ldrh r2,[r1,#0x0]	; 0232EADA
	mov r1,#0x3	; 0232EADC
	and r2,r1	; 0232EADE
	strh r2,[r0,#0x18]	; 0232EAE0
	ldr r1,[pool_0232EB04]	; 0232EAE2
	ldr r2,[r1,#0x0]	; 0232EAE4
	ldr r1,[r1,#0x4]	; 0232EAE6
	str r2,[r0,#0x10]	; 0232EAE8
	str r1,[r0,#0x14]	; 0232EAEA
	ldr r1,[pool_0232EB08]	; 0232EAEC
	ldrh r2,[r1,#0x0]	; 0232EAEE
	mov r1,#0x1	; 0232EAF0
	and r2,r1	; 0232EAF2
	strh r2,[r0,#0x1a]	; 0232EAF4
	bx lr	; 0232EAF6
.endfunc
pool_0232EAF8:
loc_0232EAF8:
	.word REG_DIV_NUMER	; 0232EAF8
pool_0232EAFC:
loc_0232EAFC:
	.word REG_DIV_DENOM	; 0232EAFC
pool_0232EB00:
loc_0232EB00:
	.word REG_DIVCNT	; 0232EB00
pool_0232EB04:
loc_0232EB04:
	.word REG_SQRT_PARAM	; 0232EB04
pool_0232EB08:
loc_0232EB08:
	.word REG_SQRTCNT	; 0232EB08

; ===== function loc_0232EB0C =====
loc_0232EB0C:
	ldr r1,[pool_0232EB18]	; 0232EB0C
loc_0232EB0E:
	ldrh r2,[r1,#0x36]	; 0232EB0E
	and r2,r0	; 0232EB10
	cmp r2,#0x0	; 0232EB12
	bne loc_0232EB0E	; 0232EB14
	bx lr	; 0232EB16
pool_0232EB18:
loc_0232EB18:
	.word P1_BssStart + 0x2828C	; 0232EB18

; ===== function loc_0232EB1C =====
loc_0232EB1C:
	push {r4,r5,r6,r7,lr}	; 0232EB1C
	sub sp,#0x4	; 0232EB1E
	add r5,r0,#0x0	; 0232EB20
	add r4,r1,#0x0	; 0232EB22
	ldr r0,[pool_0232EBDC]	; 0232EB24
	ldrh r0,[r0,#0x30]	; 0232EB26
	cmp r0,#0x0	; 0232EB28
	bne loc_0232EB44	; 0232EB2A
	ldrh r0,[r4,#0x0]	; 0232EB2C
	strh r0,[r5,#0x0]	; 0232EB2E
	ldrh r0,[r4,#0x2]	; 0232EB30
	strh r0,[r5,#0x2]	; 0232EB32
	ldrh r0,[r4,#0x4]	; 0232EB34
	strh r0,[r5,#0x4]	; 0232EB36
	ldrh r0,[r4,#0x6]	; 0232EB38
	strh r0,[r5,#0x6]	; 0232EB3A
	add sp,#0x4	; 0232EB3C
	pop {r4,r5,r6,r7}	; 0232EB3E
	pop {r3}	; 0232EB40
	bx r3	; 0232EB42
loc_0232EB44:
	ldrh r0,[r4,#0x4]	; 0232EB44
	strh r0,[r5,#0x4]	; 0232EB46
	ldrh r0,[r4,#0x6]	; 0232EB48
	strh r0,[r5,#0x6]	; 0232EB4A
	ldrh r0,[r4,#0x4]	; 0232EB4C
	cmp r0,#0x0	; 0232EB4E
	bne loc_0232EB60	; 0232EB50
	mov r0,#0x0	; 0232EB52
	strh r0,[r5,#0x0]	; 0232EB54
	strh r0,[r5,#0x2]	; 0232EB56
	add sp,#0x4	; 0232EB58
	pop {r4,r5,r6,r7}	; 0232EB5A
	pop {r3}	; 0232EB5C
	bx r3	; 0232EB5E
loc_0232EB60:
	ldr r0,[pool_0232EBE0]	; 0232EB60
	ldr r0,[r0,#0x8]	; 0232EB62
	asr r1,r0,#0x1f	; 0232EB64
	ldrh r2,[r4,#0x0]	; 0232EB66
	lsl r6,r2,#0x2	; 0232EB68
	asr r3,r6,#0x1f	; 0232EB6A
	ldr r2,[pool_0232EBE0]	; 0232EB6C
	ldr r2,[r2,#0x0]	; 0232EB6E
	asr r7,r2,#0x1f	; 0232EB70
	sub r2,r6,r2	; 0232EB72
	sbc r3,r7	; 0232EB74
	blx P1_AeabiLmul	; 0232EB76
	lsl r1,r1,#0xa	; 0232EB7A
	lsr r0,r0,#0x16	; 0232EB7C
	orr r0,r1	; 0232EB7E
	strh r0,[r5,#0x0]	; 0232EB80
	mov r0,#0x0	; 0232EB82
	ldrsh r1,[r5,r0]	; 0232EB84
	cmp r1,#0x0	; 0232EB86
	bge loc_0232EB8E	; 0232EB88
	strh r0,[r5,#0x0]	; 0232EB8A
	b loc_0232EB96	; 0232EB8C
loc_0232EB8E:
	cmp r1,#0xff	; 0232EB8E
	ble loc_0232EB96	; 0232EB90
	mov r0,#0xff	; 0232EB92
	strh r0,[r5,#0x0]	; 0232EB94
loc_0232EB96:
	ldr r0,[pool_0232EBE0]	; 0232EB96
	ldr r0,[r0,#0x14]	; 0232EB98
	asr r1,r0,#0x1f	; 0232EB9A
	ldrh r2,[r4,#0x2]	; 0232EB9C
	lsl r2,r2,#0x2	; 0232EB9E
	asr r3,r2,#0x1f	; 0232EBA0
	ldr r4,[pool_0232EBE0]	; 0232EBA2
	ldr r6,[r4,#0xc]	; 0232EBA4
	asr r4,r6,#0x1f	; 0232EBA6
	sub r2,r2,r6	; 0232EBA8
	sbc r3,r4	; 0232EBAA
	blx P1_AeabiLmul	; 0232EBAC
	lsl r1,r1,#0xa	; 0232EBB0
	lsr r0,r0,#0x16	; 0232EBB2
	orr r0,r1	; 0232EBB4
	strh r0,[r5,#0x2]	; 0232EBB6
	mov r0,#0x2	; 0232EBB8
	ldrsh r0,[r5,r0]	; 0232EBBA
	cmp r0,#0x0	; 0232EBBC
	bge loc_0232EBCC	; 0232EBBE
	mov r0,#0x0	; 0232EBC0
	strh r0,[r5,#0x2]	; 0232EBC2
	add sp,#0x4	; 0232EBC4
	pop {r4,r5,r6,r7}	; 0232EBC6
	pop {r3}	; 0232EBC8
	bx r3	; 0232EBCA
loc_0232EBCC:
	cmp r0,#0xbf	; 0232EBCC
	ble loc_0232EBD4	; 0232EBCE
	mov r0,#0xbf	; 0232EBD0
	strh r0,[r5,#0x2]	; 0232EBD2
loc_0232EBD4:
	add sp,#0x4	; 0232EBD4
	pop {r4,r5,r6,r7}	; 0232EBD6
	pop {r3}	; 0232EBD8
	bx r3	; 0232EBDA
pool_0232EBDC:
loc_0232EBDC:
	.word P1_BssStart + 0x2828C	; 0232EBDC
pool_0232EBE0:
loc_0232EBE0:
	.word P1_BssStart + 0x282A4	; 0232EBE0

; ===== function loc_0232EBE4 =====
loc_0232EBE4:
	push {r4,r5,r6,r7,lr}	; 0232EBE4
	sub sp,#0x24	; 0232EBE6
	add r5,r0,#0x0	; 0232EBE8
	add r4,r1,#0x0	; 0232EBEA
	add r7,r2,#0x0	; 0232EBEC
	add r6,r3,#0x0	; 0232EBEE
	ldr r2,[pool_0232ED70]	; 0232EBF0
	cmp r4,r2	; 0232EBF2
	bcs loc_0232EC0A	; 0232EBF4
	cmp r7,r2	; 0232EBF6
	bcs loc_0232EC0A	; 0232EBF8
	add r3,sp,#0x28	; 0232EBFA
	ldrh r1,[r3,#0x14]	; 0232EBFC
	cmp r1,r2	; 0232EBFE
	bcs loc_0232EC0A	; 0232EC00
	ldrh r0,[r3,#0x18]	; 0232EC02
	str r0,[sp,#0x20]	; 0232EC04
	cmp r0,r2	; 0232EC06
	bcc loc_0232EC14	; 0232EC08
loc_0232EC0A:
	mov r0,#0x1	; 0232EC0A
	add sp,#0x24	; 0232EC0C
	pop {r4,r5,r6,r7}	; 0232EC0E
	pop {r3}	; 0232EC10
	bx r3	; 0232EC12
loc_0232EC14:
	ldr r0,[pool_0232ED74]	; 0232EC14
	cmp r6,r0	; 0232EC16
	bcs loc_0232EC30	; 0232EC18
	ldrh r0,[r3,#0x1c]	; 0232EC1A
	ldr r2,[pool_0232ED74]	; 0232EC1C
	cmp r0,r2	; 0232EC1E
	bcs loc_0232EC30	; 0232EC20
	ldrh r2,[r3,#0x10]	; 0232EC22
	str r2,[sp,#0x1c]	; 0232EC24
	cmp r2,#0xc0	; 0232EC26
	bcs loc_0232EC30	; 0232EC28
	ldrh r2,[r3,#0x20]	; 0232EC2A
	cmp r2,#0xc0	; 0232EC2C
	bcc loc_0232EC3A	; 0232EC2E
loc_0232EC30:
	mov r0,#0x1	; 0232EC30
	add sp,#0x24	; 0232EC32
	pop {r4,r5,r6,r7}	; 0232EC34
	pop {r3}	; 0232EC36
	bx r3	; 0232EC38
loc_0232EC3A:
	cmp r6,r0	; 0232EC3A
	beq loc_0232EC4E	; 0232EC3C
	ldr r0,[sp,#0x1c]	; 0232EC3E
	cmp r0,r2	; 0232EC40
	beq loc_0232EC4E	; 0232EC42
	cmp r4,r1	; 0232EC44
	beq loc_0232EC4E	; 0232EC46
	ldr r0,[sp,#0x20]	; 0232EC48
	cmp r7,r0	; 0232EC4A
	bne loc_0232EC58	; 0232EC4C
loc_0232EC4E:
	mov r0,#0x1	; 0232EC4E
	add sp,#0x24	; 0232EC50
	pop {r4,r5,r6,r7}	; 0232EC52
	pop {r3}	; 0232EC54
	bx r3	; 0232EC56
loc_0232EC58:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EC58
	str r0,[sp,#0x4]	; 0232EC5C
	mov r3,#0x0	; 0232EC5E
	ldr r0,[pool_0232ED78]	; 0232EC60
	strh r3,[r0,#0x0]	; 0232EC62
	add r1,sp,#0x28	; 0232EC64
	ldrh r1,[r1,#0x14]	; 0232EC66
	str r1,[sp,#0xc]	; 0232EC68
	sub r1,r4,r1	; 0232EC6A
	lsl r2,r1,#0x8	; 0232EC6C
	ldr r1,[pool_0232ED7C]	; 0232EC6E
	str r2,[r1,#0x0]	; 0232EC70
	add r1,sp,#0x28	; 0232EC72
	ldrh r1,[r1,#0x1c]	; 0232EC74
	str r1,[sp,#0x8]	; 0232EC76
	sub r1,r6,r1	; 0232EC78
	ldr r2,[pool_0232ED80]	; 0232EC7A
	str r1,[r2,#0x0]	; 0232EC7C
	str r3,[r2,#0x4]	; 0232EC7E
	add r1,sp,#0x28	; 0232EC80
	ldrh r1,[r1,#0x18]	; 0232EC82
	str r1,[sp,#0x18]	; 0232EC84
	sub r3,r7,r1	; 0232EC86
	add r1,sp,#0x28	; 0232EC88
	ldrh r1,[r1,#0x20]	; 0232EC8A
	str r1,[sp,#0x10]	; 0232EC8C
	add r1,sp,#0x28	; 0232EC8E
	ldrh r2,[r1,#0x10]	; 0232EC90
	str r2,[sp,#0x14]	; 0232EC92
	ldr r1,[sp,#0x10]	; 0232EC94
	sub r1,r2,r1	; 0232EC96
	str r1,[sp,#0x0]	; 0232EC98
	ldr r1,[pool_0232ED84]	; 0232EC9A
loc_0232EC9C:
	ldrh r2,[r0,#0x0]	; 0232EC9C
	and r2,r1	; 0232EC9E
	cmp r2,#0x0	; 0232ECA0
	bne loc_0232EC9C	; 0232ECA2
	ldr r1,[pool_0232ED88]	; 0232ECA4
	ldr r2,[r1,#0x0]	; 0232ECA6
	mov r1,#0x0	; 0232ECA8
	strh r1,[r0,#0x0]	; 0232ECAA
	lsl r1,r3,#0x8	; 0232ECAC
	ldr r0,[pool_0232ED7C]	; 0232ECAE
	str r1,[r0,#0x0]	; 0232ECB0
	ldr r0,[pool_0232ED80]	; 0232ECB2
	ldr r1,[sp,#0x0]	; 0232ECB4
	str r1,[r0,#0x0]	; 0232ECB6
	mov r1,#0x0	; 0232ECB8
	str r1,[r0,#0x4]	; 0232ECBA
	ldr r0,[pool_0232ED84]	; 0232ECBC
	cmp r2,r0	; 0232ECBE
	bge loc_0232ECC8	; 0232ECC0
	ldr r1,[pool_0232ED8C]	; 0232ECC2
	cmp r2,r1	; 0232ECC4
	bge loc_0232ECD8	; 0232ECC6
loc_0232ECC8:
	ldr r0,[sp,#0x4]	; 0232ECC8
	blx P1_Arm9RestoreIrqMask	; 0232ECCA
	mov r0,#0x1	; 0232ECCE
	add sp,#0x24	; 0232ECD0
	pop {r4,r5,r6,r7}	; 0232ECD2
	pop {r3}	; 0232ECD4
	bx r3	; 0232ECD6
loc_0232ECD8:
	strh r2,[r5,#0x4]	; 0232ECD8
	ldr r1,[sp,#0xc]	; 0232ECDA
	add r1,r4,r1	; 0232ECDC
	lsl r2,r1,#0x8	; 0232ECDE
	mov r1,#0x4	; 0232ECE0
	ldrsh r1,[r5,r1]	; 0232ECE2
	ldr r3,[sp,#0x8]	; 0232ECE4
	add r3,r6,r3	; 0232ECE6
	mul r1,r3	; 0232ECE8
	sub r1,r2,r1	; 0232ECEA
	lsl r1,r1,#0x9	; 0232ECEC
	asr r2,r1,#0x10	; 0232ECEE
	cmp r2,r0	; 0232ECF0
	bge loc_0232ECFA	; 0232ECF2
	ldr r1,[pool_0232ED8C]	; 0232ECF4
	cmp r2,r1	; 0232ECF6
	bge loc_0232ED0A	; 0232ECF8
loc_0232ECFA:
	ldr r0,[sp,#0x4]	; 0232ECFA
	blx P1_Arm9RestoreIrqMask	; 0232ECFC
	mov r0,#0x1	; 0232ED00
	add sp,#0x24	; 0232ED02
	pop {r4,r5,r6,r7}	; 0232ED04
	pop {r3}	; 0232ED06
	bx r3	; 0232ED08
loc_0232ED0A:
	strh r2,[r5,#0x0]	; 0232ED0A
	ldr r1,[pool_0232ED78]	; 0232ED0C
loc_0232ED0E:
	ldrh r2,[r1,#0x0]	; 0232ED0E
	and r2,r0	; 0232ED10
	cmp r2,#0x0	; 0232ED12
	bne loc_0232ED0E	; 0232ED14
	ldr r0,[pool_0232ED88]	; 0232ED16
	ldr r4,[r0,#0x0]	; 0232ED18
	ldr r0,[sp,#0x4]	; 0232ED1A
	blx P1_Arm9RestoreIrqMask	; 0232ED1C
	ldr r1,[pool_0232ED84]	; 0232ED20
	cmp r4,r1	; 0232ED22
	bge loc_0232ED2C	; 0232ED24
	ldr r0,[pool_0232ED8C]	; 0232ED26
	cmp r4,r0	; 0232ED28
	bge loc_0232ED36	; 0232ED2A
loc_0232ED2C:
	mov r0,#0x1	; 0232ED2C
	add sp,#0x24	; 0232ED2E
	pop {r4,r5,r6,r7}	; 0232ED30
	pop {r3}	; 0232ED32
	bx r3	; 0232ED34
loc_0232ED36:
	strh r4,[r5,#0x6]	; 0232ED36
	ldr r2,[sp,#0x18]	; 0232ED38
	add r2,r7,r2	; 0232ED3A
	lsl r3,r2,#0x8	; 0232ED3C
	mov r2,#0x6	; 0232ED3E
	ldrsh r2,[r5,r2]	; 0232ED40
	ldr r6,[sp,#0x14]	; 0232ED42
	ldr r4,[sp,#0x10]	; 0232ED44
	add r4,r6,r4	; 0232ED46
	mul r2,r4	; 0232ED48
	sub r2,r3,r2	; 0232ED4A
	lsl r2,r2,#0x9	; 0232ED4C
	asr r2,r2,#0x10	; 0232ED4E
	cmp r2,r1	; 0232ED50
	bge loc_0232ED58	; 0232ED52
	cmp r2,r0	; 0232ED54
	bge loc_0232ED62	; 0232ED56
loc_0232ED58:
	mov r0,#0x1	; 0232ED58
	add sp,#0x24	; 0232ED5A
	pop {r4,r5,r6,r7}	; 0232ED5C
	pop {r3}	; 0232ED5E
	bx r3	; 0232ED60
loc_0232ED62:
	strh r2,[r5,#0x2]	; 0232ED62
	mov r0,#0x0	; 0232ED64
	add sp,#0x24	; 0232ED66
	pop {r4,r5,r6,r7}	; 0232ED68
	pop {r3}	; 0232ED6A
	bx r3	; 0232ED6C
	.byte 0xC0, 0x46	; 0232ED70
pool_0232ED70:
loc_0232ED70:
	.word 0x00001000	; 0232ED70
pool_0232ED74:
loc_0232ED74:
	.word 0x00000100	; 0232ED74
pool_0232ED78:
loc_0232ED78:
	.word REG_DIVCNT	; 0232ED78
pool_0232ED7C:
loc_0232ED7C:
	.word REG_DIV_NUMER	; 0232ED7C
pool_0232ED80:
loc_0232ED80:
	.word REG_DIV_DENOM	; 0232ED80
pool_0232ED84:
loc_0232ED84:
	.word 0x00008000	; 0232ED84
pool_0232ED88:
loc_0232ED88:
	.word REG_DIV_RESULT	; 0232ED88
pool_0232ED8C:
loc_0232ED8C:
	.word 0xFFFF8000	; 0232ED8C

; ===== function loc_0232ED90 =====
loc_0232ED90:
	push {r4,lr}	; 0232ED90
	add r4,r0,#0x0	; 0232ED92
	mov r0,#0x1	; 0232ED94
	bl loc_0232EB0C	; 0232ED96
	ldr r1,[pool_0232EDC0]	; 0232ED9A
	ldrh r2,[r1,#0x34]	; 0232ED9C
	mov r0,#0x1	; 0232ED9E
	and r2,r0	; 0232EDA0
	cmp r2,#0x0	; 0232EDA2
	bne loc_0232EDB8	; 0232EDA4
	ldrh r0,[r1,#0x4]	; 0232EDA6
	strh r0,[r4,#0x0]	; 0232EDA8
	ldrh r0,[r1,#0x6]	; 0232EDAA
	strh r0,[r4,#0x2]	; 0232EDAC
	ldrh r0,[r1,#0x8]	; 0232EDAE
	strh r0,[r4,#0x4]	; 0232EDB0
	ldrh r0,[r1,#0xa]	; 0232EDB2
	strh r0,[r4,#0x6]	; 0232EDB4
	mov r0,#0x0	; 0232EDB6
loc_0232EDB8:
	pop {r4}	; 0232EDB8
	pop {r3}	; 0232EDBA
	bx r3	; 0232EDBC
	.byte 0xC0, 0x46	; 0232EDC0
pool_0232EDC0:
loc_0232EDC0:
	.word P1_BssStart + 0x2828C	; 0232EDC0

; ===== function loc_0232EDC4 =====
loc_0232EDC4:
	push {r4,lr}	; 0232EDC4
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EDC6
	add r4,r0,#0x0	; 0232EDCA
	mov r0,#0x6	; 0232EDCC
	ldr r1,[pool_0232EE24]	; 0232EDCE
	mov r2,#0x0	; 0232EDD0
	bl loc_0232E8C4	; 0232EDD2
	cmp r0,#0x0	; 0232EDD6
	blt loc_0232EDDE	; 0232EDD8
	mov r0,#0x1	; 0232EDDA
	b loc_0232EDE0	; 0232EDDC
loc_0232EDDE:
	mov r0,#0x0	; 0232EDDE
loc_0232EDE0:
	cmp r0,#0x0	; 0232EDE0
	bne loc_0232EE08	; 0232EDE2
	add r0,r4,#0x0	; 0232EDE4
	blx P1_Arm9RestoreIrqMask	; 0232EDE6
	ldr r1,[pool_0232EE28]	; 0232EDEA
	ldrh r2,[r1,#0x34]	; 0232EDEC
	mov r0,#0x1	; 0232EDEE
	orr r2,r0	; 0232EDF0
	strh r2,[r1,#0x34]	; 0232EDF2
	ldr r3,[r1,#0x0]	; 0232EDF4
	cmp r3,#0x0	; 0232EDF6
	beq loc_0232EE1E	; 0232EDF8
	mov r0,#0x0	; 0232EDFA
	mov r1,#0x4	; 0232EDFC
	add r2,r0,#0x0	; 0232EDFE
	blx r3	; 0232EE00
	pop {r4}	; 0232EE02
	pop {r3}	; 0232EE04
	bx r3	; 0232EE06
loc_0232EE08:
	ldr r1,[pool_0232EE28]	; 0232EE08
	ldrh r2,[r1,#0x36]	; 0232EE0A
	mov r0,#0x1	; 0232EE0C
	orr r2,r0	; 0232EE0E
	strh r2,[r1,#0x36]	; 0232EE10
	ldrh r2,[r1,#0x34]	; 0232EE12
	bic r2,r0	; 0232EE14
	strh r2,[r1,#0x34]	; 0232EE16
	add r0,r4,#0x0	; 0232EE18
	blx P1_Arm9RestoreIrqMask	; 0232EE1A
loc_0232EE1E:
	pop {r4}	; 0232EE1E
	pop {r3}	; 0232EE20
	bx r3	; 0232EE22
pool_0232EE24:
loc_0232EE24:
	.word 0x03000000	; 0232EE24
pool_0232EE28:
loc_0232EE28:
	.word P1_BssStart + 0x2828C	; 0232EE28

; ===== function loc_0232EE2C =====
loc_0232EE2C:
	push {r4,r5,r6,r7,lr}	; 0232EE2C
	sub sp,#0x4	; 0232EE2E
	add r4,r0,#0x0	; 0232EE30
	cmp r4,#0x0	; 0232EE32
	bne loc_0232EE44	; 0232EE34
	mov r1,#0x0	; 0232EE36
	ldr r0,[pool_0232EEC4]	; 0232EE38
	strh r1,[r0,#0x30]	; 0232EE3A
	add sp,#0x4	; 0232EE3C
	pop {r4,r5,r6,r7}	; 0232EE3E
	pop {r3}	; 0232EE40
	bx r3	; 0232EE42
loc_0232EE44:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EE44
	add r6,r0,#0x0	; 0232EE48
	mov r7,#0x4	; 0232EE4A
	ldrsh r5,[r4,r7]	; 0232EE4C
	mov r3,#0x0	; 0232EE4E
	ldr r2,[pool_0232EEC8]	; 0232EE50
	strh r3,[r2,#0x0]	; 0232EE52
	ldr r1,[pool_0232EECC]	; 0232EE54
	ldr r0,[pool_0232EED0]	; 0232EE56
	str r1,[r0,#0x0]	; 0232EE58
	ldr r0,[pool_0232EED4]	; 0232EE5A
	str r5,[r0,#0x0]	; 0232EE5C
	str r3,[r0,#0x4]	; 0232EE5E
	ldrsh r1,[r4,r3]	; 0232EE60
	ldr r0,[pool_0232EEC4]	; 0232EE62
	str r1,[r0,#0x18]	; 0232EE64
	ldrsh r1,[r4,r7]	; 0232EE66
	str r1,[r0,#0x1c]	; 0232EE68
	ldr r0,[pool_0232EED8]	; 0232EE6A
loc_0232EE6C:
	ldrh r1,[r2,#0x0]	; 0232EE6C
	and r1,r0	; 0232EE6E
	cmp r1,#0x0	; 0232EE70
	bne loc_0232EE6C	; 0232EE72
	ldr r0,[pool_0232EEDC]	; 0232EE74
	ldr r0,[r0,#0x0]	; 0232EE76
	ldr r3,[pool_0232EEC4]	; 0232EE78
	str r0,[r3,#0x20]	; 0232EE7A
	mov r7,#0x6	; 0232EE7C
	ldrsh r1,[r4,r7]	; 0232EE7E
	mov r0,#0x0	; 0232EE80
	strh r0,[r2,#0x0]	; 0232EE82
	ldr r5,[pool_0232EECC]	; 0232EE84
	ldr r2,[pool_0232EED0]	; 0232EE86
	str r5,[r2,#0x0]	; 0232EE88
	ldr r2,[pool_0232EED4]	; 0232EE8A
	str r1,[r2,#0x0]	; 0232EE8C
	str r0,[r2,#0x4]	; 0232EE8E
	mov r0,#0x2	; 0232EE90
	ldrsh r0,[r4,r0]	; 0232EE92
	str r0,[r3,#0x24]	; 0232EE94
	ldrsh r0,[r4,r7]	; 0232EE96
	str r0,[r3,#0x28]	; 0232EE98
	ldr r1,[pool_0232EEC8]	; 0232EE9A
	ldr r0,[pool_0232EED8]	; 0232EE9C
loc_0232EE9E:
	ldrh r2,[r1,#0x0]	; 0232EE9E
	and r2,r0	; 0232EEA0
	cmp r2,#0x0	; 0232EEA2
	bne loc_0232EE9E	; 0232EEA4
	ldr r0,[pool_0232EEDC]	; 0232EEA6
	ldr r1,[r0,#0x0]	; 0232EEA8
	ldr r0,[pool_0232EEC4]	; 0232EEAA
	str r1,[r0,#0x2c]	; 0232EEAC
	add r0,r6,#0x0	; 0232EEAE
	blx P1_Arm9RestoreIrqMask	; 0232EEB0
	mov r1,#0x1	; 0232EEB4
	ldr r0,[pool_0232EEC4]	; 0232EEB6
	strh r1,[r0,#0x30]	; 0232EEB8
	add sp,#0x4	; 0232EEBA
	pop {r4,r5,r6,r7}	; 0232EEBC
	pop {r3}	; 0232EEBE
	bx r3	; 0232EEC0
	.byte 0xC0, 0x46	; 0232EEC4
pool_0232EEC4:
loc_0232EEC4:
	.word P1_BssStart + 0x2828C	; 0232EEC4
pool_0232EEC8:
loc_0232EEC8:
	.word REG_DIVCNT	; 0232EEC8
pool_0232EECC:
loc_0232EECC:
	.word 0x10000000	; 0232EECC
pool_0232EED0:
loc_0232EED0:
	.word REG_DIV_NUMER	; 0232EED0
pool_0232EED4:
loc_0232EED4:
	.word REG_DIV_DENOM	; 0232EED4
pool_0232EED8:
loc_0232EED8:
	.word 0x00008000	; 0232EED8
pool_0232EEDC:
loc_0232EEDC:
	.word REG_DIV_RESULT	; 0232EEDC

; ===== function loc_0232EEE0 =====
loc_0232EEE0:
	push {r4,r5,lr}	; 0232EEE0
	sub sp,#0x4	; 0232EEE2
	ldr r0,[pool_0232EF28]	; 0232EEE4
	ldrh r1,[r0,#0x0]	; 0232EEE6
	cmp r1,#0x0	; 0232EEE8
	bne loc_0232EF1E	; 0232EEEA
	mov r1,#0x1	; 0232EEEC
	strh r1,[r0,#0x0]	; 0232EEEE
	bl loc_0232E7E4	; 0232EEF0
	mov r1,#0x0	; 0232EEF4
	ldr r0,[pool_0232EF2C]	; 0232EEF6
	strh r1,[r0,#0xc]	; 0232EEF8
	str r1,[r0,#0x0]	; 0232EEFA
	str r1,[r0,#0x10]	; 0232EEFC
	strh r1,[r0,#0x32]	; 0232EEFE
	strh r1,[r0,#0x30]	; 0232EF00
	strh r1,[r0,#0x36]	; 0232EF02
	strh r1,[r0,#0x34]	; 0232EF04
	mov r5,#0x6	; 0232EF06
	mov r4,#0x1	; 0232EF08
loc_0232EF0A:
	add r0,r5,#0x0	; 0232EF0A
	add r1,r4,#0x0	; 0232EF0C
	bl loc_0232E958	; 0232EF0E
	cmp r0,#0x0	; 0232EF12
	beq loc_0232EF0A	; 0232EF14
	mov r0,#0x6	; 0232EF16
	ldr r1,[pool_0232EF30]	; 0232EF18
	bl P1_SetPxiReceiveCallback	; 0232EF1A
loc_0232EF1E:
	add sp,#0x4	; 0232EF1E
	pop {r4,r5}	; 0232EF20
	pop {r3}	; 0232EF22
	bx r3	; 0232EF24
	.byte 0xC0, 0x46	; 0232EF28
pool_0232EF28:
loc_0232EF28:
	.word P1_BssStart + 0x28288	; 0232EF28
pool_0232EF2C:
loc_0232EF2C:
	.word P1_BssStart + 0x2828C	; 0232EF2C
pool_0232EF30:
loc_0232EF30:
	.word P1_PxiCallback_0232EF34 + 1	; 0232EF30

; ===== function loc_0232EF34 =====
P1_PxiCallback_0232EF34:
	push {r4,lr}	; 0232EF34
	sub sp,#0x8	; 0232EF36
	lsl r0,r1,#0x10	; 0232EF38
	lsr r3,r0,#0x10	; 0232EF3A
	ldr r0,[pool_0232F028]	; 0232EF3C
	add r4,r3,#0x0	; 0232EF3E
	and r4,r0	; 0232EF40
	lsl r0,r4,#0x8	; 0232EF42
	lsr r0,r0,#0x10	; 0232EF44
	cmp r2,#0x0	; 0232EF46
	beq loc_0232EF6A	; 0232EF48
	ldr r1,[pool_0232F02C]	; 0232EF4A
	ldrh r3,[r1,#0x34]	; 0232EF4C
	mov r2,#0x1	; 0232EF4E
	lsl r2,r0	; 0232EF50
	orr r3,r2	; 0232EF52
	strh r3,[r1,#0x34]	; 0232EF54
	ldr r3,[r1,#0x0]	; 0232EF56
	cmp r3,#0x0	; 0232EF58
	beq loc_0232F020	; 0232EF5A
	mov r1,#0x4	; 0232EF5C
	mov r2,#0x0	; 0232EF5E
	blx r3	; 0232EF60
	add sp,#0x8	; 0232EF62
	pop {r4}	; 0232EF64
	pop {r3}	; 0232EF66
	bx r3	; 0232EF68
loc_0232EF6A:
	ldr r2,[pool_0232F030]	; 0232EF6A
	and r1,r2	; 0232EF6C
	cmp r1,#0x0	; 0232EF6E
	beq loc_0232F020	; 0232EF70
	lsl r1,r3,#0x18	; 0232EF72
	lsr r1,r1,#0x18	; 0232EF74
	cmp r1,#0x4	; 0232EF76
	bhi loc_0232F01C	; 0232EF78
	add r1,r1,r1	; 0232EF7A
P1_SwitchIndexPC_0232EF7A:
	add r1,pc	; 0232EF7C
	ldrh r1,[r1,#(P1_SwitchTable_0232EF7A - (P1_SwitchIndexPC_0232EF7A + 4))]	; 0232EF7E
	lsl r1,r1,#0x10	; 0232EF80
	asr r1,r1,#0x10	; 0232EF82
P1_SwitchTargetPC_0232EF7A:
	add r1,pc	; 0232EF84
	bx r1	; 0232EF86
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232EF7A:
	.halfword (loc_0232EF92 + 1) - (P1_SwitchTargetPC_0232EF7A + 4)
	.halfword (loc_0232F01C + 1) - (P1_SwitchTargetPC_0232EF7A + 4)
	.halfword (loc_0232EFEE + 1) - (P1_SwitchTargetPC_0232EF7A + 4)
	.halfword (loc_0232EFF2 + 1) - (P1_SwitchTargetPC_0232EF7A + 4)
	.halfword (loc_0232EFEA + 1) - (P1_SwitchTargetPC_0232EF7A + 4)
P1_SwitchTable_0232EF7AEnd:
loc_0232EF92:
	cmp r0,#0x0	; 0232EF92
	bne loc_0232EFC8	; 0232EF94
	ldr r1,[pool_0232F034]	; 0232EF96
	ldrh r2,[r1,#0x0]	; 0232EF98
	add r1,sp,#0x0	; 0232EF9A
	strh r2,[r1,#0x0]	; 0232EF9C
	ldr r2,[pool_0232F038]	; 0232EF9E
	ldrh r2,[r2,#0x0]	; 0232EFA0
	strh r2,[r1,#0x2]	; 0232EFA2
	ldr r1,[sp,#0x0]	; 0232EFA4
	lsl r2,r1,#0x14	; 0232EFA6
	lsr r2,r2,#0x14	; 0232EFA8
	ldr r3,[pool_0232F02C]	; 0232EFAA
	strh r2,[r3,#0x4]	; 0232EFAC
	lsl r2,r1,#0x8	; 0232EFAE
	lsr r2,r2,#0x14	; 0232EFB0
	strh r2,[r3,#0x6]	; 0232EFB2
	lsl r2,r1,#0x7	; 0232EFB4
	lsr r2,r2,#0x1f	; 0232EFB6
	lsl r2,r2,#0x18	; 0232EFB8
	lsr r2,r2,#0x18	; 0232EFBA
	strh r2,[r3,#0x8]	; 0232EFBC
	lsl r1,r1,#0x5	; 0232EFBE
	lsr r1,r1,#0x1e	; 0232EFC0
	lsl r1,r1,#0x18	; 0232EFC2
	lsr r1,r1,#0x18	; 0232EFC4
	strh r1,[r3,#0xa]	; 0232EFC6
loc_0232EFC8:
	mov r1,#0x0	; 0232EFC8
	ldr r2,[pool_0232F02C]	; 0232EFCA
	strh r1,[r2,#0x32]	; 0232EFCC
	ldrh r4,[r2,#0x36]	; 0232EFCE
	mov r3,#0x1	; 0232EFD0
	lsl r3,r0	; 0232EFD2
	bic r4,r3	; 0232EFD4
	strh r4,[r2,#0x36]	; 0232EFD6
	ldr r3,[r2,#0x0]	; 0232EFD8
	cmp r3,#0x0	; 0232EFDA
	beq loc_0232F020	; 0232EFDC
	add r2,r1,#0x0	; 0232EFDE
	blx r3	; 0232EFE0
	add sp,#0x8	; 0232EFE2
	pop {r4}	; 0232EFE4
	pop {r3}	; 0232EFE6
	bx r3	; 0232EFE8
loc_0232EFEA:
	mov r1,#0x3	; 0232EFEA
	b loc_0232EFF4	; 0232EFEC
loc_0232EFEE:
	mov r1,#0x1	; 0232EFEE
	b loc_0232EFF4	; 0232EFF0
loc_0232EFF2:
	mov r1,#0x2	; 0232EFF2
loc_0232EFF4:
	mov r4,#0x1	; 0232EFF4
	lsl r4,r0	; 0232EFF6
	ldr r2,[pool_0232F02C]	; 0232EFF8
	ldrh r3,[r2,#0x34]	; 0232EFFA
	orr r3,r4	; 0232EFFC
	strh r3,[r2,#0x34]	; 0232EFFE
	ldrh r3,[r2,#0x36]	; 0232F000
	bic r3,r4	; 0232F002
	strh r3,[r2,#0x36]	; 0232F004
	ldr r3,[r2,#0x0]	; 0232F006
	cmp r3,#0x0	; 0232F008
	beq loc_0232F020	; 0232F00A
	mov r2,#0xff	; 0232F00C
	and r1,r2	; 0232F00E
	mov r2,#0x0	; 0232F010
	blx r3	; 0232F012
	add sp,#0x8	; 0232F014
	pop {r4}	; 0232F016
	pop {r3}	; 0232F018
	bx r3	; 0232F01A
loc_0232F01C:
	bl loc_0232C538	; 0232F01C
loc_0232F020:
	add sp,#0x8	; 0232F020
	pop {r4}	; 0232F022
	pop {r3}	; 0232F024
	bx r3	; 0232F026
pool_0232F028:
loc_0232F028:
	.word 0x00007F00	; 0232F028
pool_0232F02C:
loc_0232F02C:
	.word P1_BssStart + 0x2828C	; 0232F02C
pool_0232F030:
loc_0232F030:
	.word 0x01000000	; 0232F030
pool_0232F034:
loc_0232F034:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 0232F034
pool_0232F038:
loc_0232F038:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 0232F038

; ===== function loc_0232F03C =====
loc_0232F03C:
	push {r4,lr}	; 0232F03C
	cmp r0,#0x0	; 0232F03E
	beq loc_0232F082	; 0232F040
	cmp r0,#0x1	; 0232F042
	bne loc_0232F0AA	; 0232F044
	cmp r2,#0x0	; 0232F046
	bne loc_0232F060	; 0232F048
	ldr r0,[pool_0232F0B4]	; 0232F04A
	ldr r2,[r0,#0x0]	; 0232F04C
	ldr r0,[pool_0232F0B8]	; 0232F04E
	ldr r0,[r0,#0x0]	; 0232F050
	sub r0,r2,r0	; 0232F052
	cmp r0,#0x7	; 0232F054
	bhi loc_0232F060	; 0232F056
	mov r0,#0x0	; 0232F058
	pop {r4}	; 0232F05A
	pop {r3}	; 0232F05C
	bx r3	; 0232F05E
loc_0232F060:
	cmp r3,#0x0	; 0232F060
	beq loc_0232F06C	; 0232F062
	add r0,r1,#0x0	; 0232F064
	bl loc_0232F278	; 0232F066
	b loc_0232F076	; 0232F06A
loc_0232F06C:
	add r0,r1,#0x0	; 0232F06C
	mov r1,#0x0	; 0232F06E
	add r2,r1,#0x0	; 0232F070
	bl loc_0232F298	; 0232F072
loc_0232F076:
	ldr r2,[pool_0232F0BC]	; 0232F076
	ldrh r1,[r2,#0x0]	; 0232F078
	mov r0,#0x1	; 0232F07A
	orr r1,r0	; 0232F07C
	strh r1,[r2,#0x0]	; 0232F07E
	b loc_0232F0AA	; 0232F080
loc_0232F082:
	ldr r4,[pool_0232F0BC]	; 0232F082
	ldrh r2,[r4,#0x0]	; 0232F084
	mov r0,#0x1	; 0232F086
	bic r2,r0	; 0232F088
	strh r2,[r4,#0x0]	; 0232F08A
	ldr r0,[pool_0232F0B4]	; 0232F08C
	ldr r2,[r0,#0x0]	; 0232F08E
	ldr r0,[pool_0232F0B8]	; 0232F090
	str r2,[r0,#0x0]	; 0232F092
	cmp r3,#0x0	; 0232F094
	beq loc_0232F0A0	; 0232F096
	add r0,r1,#0x0	; 0232F098
	bl loc_0232F278	; 0232F09A
	b loc_0232F0AA	; 0232F09E
loc_0232F0A0:
	add r0,r1,#0x0	; 0232F0A0
	mov r1,#0x0	; 0232F0A2
	add r2,r1,#0x0	; 0232F0A4
	bl loc_0232F298	; 0232F0A6
loc_0232F0AA:
	mov r0,#0x1	; 0232F0AA
	pop {r4}	; 0232F0AC
	pop {r3}	; 0232F0AE
	bx r3	; 0232F0B0
	.byte 0xC0, 0x46	; 0232F0B4
pool_0232F0B4:
loc_0232F0B4:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232F0B4
pool_0232F0B8:
loc_0232F0B8:
	.word P1_BssStart + 0x282D0	; 0232F0B8
pool_0232F0BC:
loc_0232F0BC:
	.word REG_POWERCNT	; 0232F0BC

; ===== function loc_0232F0C0 =====
loc_0232F0C0:
	push {r4,r5,r6,r7,lr}	; 0232F0C0
	sub sp,#0xc	; 0232F0C2
	add r5,r0,#0x0	; 0232F0C4
	add r4,r1,#0x0	; 0232F0C6
	str r2,[sp,#0x0]	; 0232F0C8
	mov r6,#0x0	; 0232F0CA
	ldr r0,[pool_0232F174]	; 0232F0CC
	ldrh r7,[r0,#0x0]	; 0232F0CE
	strh r6,[r0,#0x0]	; 0232F0D0
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F0D2
	str r0,[sp,#0x4]	; 0232F0D6
	ldr r0,[pool_0232F178]	; 0232F0D8
	bl loc_0232B144	; 0232F0DA
	str r0,[sp,#0x8]	; 0232F0DE
	ldr r0,[pool_0232F17C]	; 0232F0E0
	bl loc_0232B194	; 0232F0E2
	ldr r0,[sp,#0x4]	; 0232F0E6
	blx P1_Arm9RestoreIrqMask	; 0232F0E8
	ldr r1,[pool_0232F174]	; 0232F0EC
	ldrh r0,[r1,#0x0]	; 0232F0EE
	mov r0,#0x1	; 0232F0F0
	strh r0,[r1,#0x0]	; 0232F0F2
	mov r0,#0x10	; 0232F0F4
	add r1,r5,#0x0	; 0232F0F6
	and r1,r0	; 0232F0F8
	cmp r1,#0x0	; 0232F0FA
	beq loc_0232F10A	; 0232F0FC
	bl loc_0232C620	; 0232F0FE
	cmp r0,#0x0	; 0232F102
	bne loc_0232F10A	; 0232F104
	mov r0,#0x10	; 0232F106
	bic r5,r0	; 0232F108
loc_0232F10A:
	ldr r0,[sp,#0x0]	; 0232F10A
	orr r4,r0	; 0232F10C
loc_0232F10E:
	lsl r0,r5,#0x10	; 0232F10E
	lsr r0,r0,#0x10	; 0232F110
	lsl r1,r4,#0x10	; 0232F112
	lsr r1,r1,#0x10	; 0232F114
	bl loc_0232F3A0	; 0232F116
	cmp r0,#0x0	; 0232F11A
	bne loc_0232F10E	; 0232F11C
	blx P1_Arm9WaitForInterrupt	; 0232F11E
	ldr r0,[pool_0232F180]	; 0232F122
	blx P1_Arm9BusyWaitByLoop4	; 0232F124
	mov r0,#0x8	; 0232F128
	and r5,r0	; 0232F12A
	cmp r5,#0x0	; 0232F12C
	beq loc_0232F13E	; 0232F12E
	ldr r0,[pool_0232F184]	; 0232F130
	ldr r1,[r0,#0x0]	; 0232F132
	ldr r0,[pool_0232F188]	; 0232F134
	and r1,r0	; 0232F136
	cmp r1,#0x0	; 0232F138
	beq loc_0232F13E	; 0232F13A
	mov r6,#0x1	; 0232F13C
loc_0232F13E:
	cmp r6,#0x0	; 0232F13E
	bne loc_0232F14E	; 0232F140
	mov r0,#0x1	; 0232F142
	add r1,r0,#0x0	; 0232F144
	add r2,r0,#0x0	; 0232F146
	mov r3,#0x0	; 0232F148
	bl loc_0232F03C	; 0232F14A
loc_0232F14E:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F14E
	ldr r0,[sp,#0x8]	; 0232F152
	bl loc_0232B194	; 0232F154
	ldr r0,[sp,#0x4]	; 0232F158
	blx P1_Arm9RestoreIrqMask	; 0232F15A
	ldr r1,[pool_0232F174]	; 0232F15E
	ldrh r0,[r1,#0x0]	; 0232F160
	strh r7,[r1,#0x0]	; 0232F162
	cmp r6,#0x0	; 0232F164
	beq loc_0232F16C	; 0232F166
	bl loc_0232F1D0	; 0232F168
loc_0232F16C:
	add sp,#0xc	; 0232F16C
	pop {r4,r5,r6,r7}	; 0232F16E
	pop {r3}	; 0232F170
	bx r3	; 0232F172
pool_0232F174:
loc_0232F174:
	.word REG_IME	; 0232F174
pool_0232F178:
loc_0232F178:
	.word 0x003FFFFF	; 0232F178
pool_0232F17C:
loc_0232F17C:
	.word 0x00040000	; 0232F17C
pool_0232F180:
loc_0232F180:
	.word 0x00332340	; 0232F180
pool_0232F184:
loc_0232F184:
	.word REG_IF	; 0232F184
pool_0232F188:
loc_0232F188:
	.word 0x00100000	; 0232F188

; ===== function loc_0232F18C =====
loc_0232F18C:
	push {r4,r5,r6,lr}	; 0232F18C
	add r5,r0,#0x0	; 0232F18E
	mov r4,#0x8	; 0232F190
	mov r6,#0x0	; 0232F192
loc_0232F194:
	add r0,r4,#0x0	; 0232F194
	add r1,r5,#0x0	; 0232F196
	add r2,r6,#0x0	; 0232F198
	bl loc_0232E8C4	; 0232F19A
	cmp r0,#0x0	; 0232F19E
	bne loc_0232F194	; 0232F1A0
	pop {r4,r5,r6}	; 0232F1A2
	pop {r3}	; 0232F1A4
	bx r3	; 0232F1A6

; ===== function loc_0232F1A8 =====
loc_0232F1A8:
	push {r4,lr}	; 0232F1A8
	sub sp,#0x8	; 0232F1AA
	add r4,r0,#0x0	; 0232F1AC
	mov r0,#0x1	; 0232F1AE
	add r1,sp,#0x0	; 0232F1B0
	bl loc_0232F2D4	; 0232F1B2
	cmp r0,#0x0	; 0232F1B6
	bne loc_0232F1C8	; 0232F1B8
	cmp r4,#0x0	; 0232F1BA
	beq loc_0232F1C8	; 0232F1BC
	add r1,sp,#0x0	; 0232F1BE
	ldrh r2,[r1,#0x0]	; 0232F1C0
	mov r1,#0x1	; 0232F1C2
	and r2,r1	; 0232F1C4
	str r2,[r4,#0x0]	; 0232F1C6
loc_0232F1C8:
	add sp,#0x8	; 0232F1C8
	pop {r4}	; 0232F1CA
	pop {r3}	; 0232F1CC
	bx r3	; 0232F1CE

; ===== function loc_0232F1D0 =====
loc_0232F1D0:
	push {lr}	; 0232F1D0
	sub sp,#0x4	; 0232F1D2
	ldr r0,[pool_0232F1EC]	; 0232F1D4
	add r1,sp,#0x0	; 0232F1D6
	bl loc_0232F1F0	; 0232F1D8
	cmp r0,#0x0	; 0232F1DC
	bne loc_0232F1E6	; 0232F1DE
	bl loc_0232F55C	; 0232F1E0
	ldr r0,[sp,#0x0]	; 0232F1E4
loc_0232F1E6:
	add sp,#0x4	; 0232F1E6
	pop {r3}	; 0232F1E8
	bx r3	; 0232F1EA
pool_0232F1EC:
loc_0232F1EC:
	.word 0x0232F559	; 0232F1EC

; ===== function loc_0232F1F0 =====
loc_0232F1F0:
	add r3,r0,#0x0	; 0232F1F0
	add r2,r1,#0x0	; 0232F1F2
	mov r0,#0xe	; 0232F1F4
	add r1,r3,#0x0	; 0232F1F6
	ldr r3,[pool_0232F1FC]	; 0232F1F8
	bx r3	; 0232F1FA
pool_0232F1FC:
loc_0232F1FC:
	.word loc_0232F34C + 1	; 0232F1FC

; ===== function loc_0232F200 =====
loc_0232F200:
	push {lr}	; 0232F200
	sub sp,#0x4	; 0232F202
	ldr r2,[pool_0232F21C]	; 0232F204
	add r3,sp,#0x0	; 0232F206
	bl loc_0232F220	; 0232F208
	cmp r0,#0x0	; 0232F20C
	bne loc_0232F216	; 0232F20E
	bl loc_0232F55C	; 0232F210
	ldr r0,[sp,#0x0]	; 0232F214
loc_0232F216:
	add sp,#0x4	; 0232F216
	pop {r3}	; 0232F218
	bx r3	; 0232F21A
pool_0232F21C:
loc_0232F21C:
	.word 0x0232F559	; 0232F21C

; ===== function loc_0232F220 =====
loc_0232F220:
	push {r4,lr}	; 0232F220
	mov r4,#0x0	; 0232F222
	cmp r0,#0x0	; 0232F224
	bne loc_0232F236	; 0232F226
	cmp r1,#0x1	; 0232F228
	bne loc_0232F22E	; 0232F22A
	mov r4,#0x6	; 0232F22C
loc_0232F22E:
	cmp r1,#0x0	; 0232F22E
	bne loc_0232F258	; 0232F230
	mov r4,#0x7	; 0232F232
	b loc_0232F258	; 0232F234
loc_0232F236:
	cmp r0,#0x1	; 0232F236
	bne loc_0232F248	; 0232F238
	cmp r1,#0x1	; 0232F23A
	bne loc_0232F240	; 0232F23C
	mov r4,#0x4	; 0232F23E
loc_0232F240:
	cmp r1,#0x0	; 0232F240
	bne loc_0232F258	; 0232F242
	mov r4,#0x5	; 0232F244
	b loc_0232F258	; 0232F246
loc_0232F248:
	cmp r0,#0x2	; 0232F248
	bne loc_0232F258	; 0232F24A
	cmp r1,#0x1	; 0232F24C
	bne loc_0232F252	; 0232F24E
	mov r4,#0x8	; 0232F250
loc_0232F252:
	cmp r1,#0x0	; 0232F252
	bne loc_0232F258	; 0232F254
	mov r4,#0x9	; 0232F256
loc_0232F258:
	cmp r4,#0x0	; 0232F258
	beq loc_0232F26C	; 0232F25A
	add r0,r4,#0x0	; 0232F25C
	add r1,r2,#0x0	; 0232F25E
	add r2,r3,#0x0	; 0232F260
	bl loc_0232F34C	; 0232F262
	pop {r4}	; 0232F266
	pop {r3}	; 0232F268
	bx r3	; 0232F26A
loc_0232F26C:
	ldr r0,[pool_0232F274]	; 0232F26C
	pop {r4}	; 0232F26E
	pop {r3}	; 0232F270
	bx r3	; 0232F272
pool_0232F274:
loc_0232F274:
	.word 0x0000FFFF	; 0232F274

; ===== function loc_0232F278 =====
loc_0232F278:
	push {lr}	; 0232F278
	sub sp,#0x4	; 0232F27A
	ldr r1,[pool_0232F294]	; 0232F27C
	add r2,sp,#0x0	; 0232F27E
	bl loc_0232F298	; 0232F280
	cmp r0,#0x0	; 0232F284
	bne loc_0232F28E	; 0232F286
	bl loc_0232F55C	; 0232F288
	ldr r0,[sp,#0x0]	; 0232F28C
loc_0232F28E:
	add sp,#0x4	; 0232F28E
	pop {r3}	; 0232F290
	bx r3	; 0232F292
pool_0232F294:
loc_0232F294:
	.word 0x0232F559	; 0232F294

; ===== function loc_0232F298 =====
loc_0232F298:
	push {lr}	; 0232F298
	sub sp,#0x4	; 0232F29A
	cmp r0,#0x1	; 0232F29C
	beq loc_0232F2AA	; 0232F29E
	cmp r0,#0x2	; 0232F2A0
	beq loc_0232F2B2	; 0232F2A2
	cmp r0,#0x3	; 0232F2A4
	beq loc_0232F2AE	; 0232F2A6
	b loc_0232F2B6	; 0232F2A8
loc_0232F2AA:
	mov r0,#0x1	; 0232F2AA
	b loc_0232F2B8	; 0232F2AC
loc_0232F2AE:
	mov r0,#0x2	; 0232F2AE
	b loc_0232F2B8	; 0232F2B0
loc_0232F2B2:
	mov r0,#0x3	; 0232F2B2
	b loc_0232F2B8	; 0232F2B4
loc_0232F2B6:
	mov r0,#0x0	; 0232F2B6
loc_0232F2B8:
	cmp r0,#0x0	; 0232F2B8
	beq loc_0232F2C6	; 0232F2BA
	bl loc_0232F34C	; 0232F2BC
	add sp,#0x4	; 0232F2C0
	pop {r3}	; 0232F2C2
	bx r3	; 0232F2C4
loc_0232F2C6:
	ldr r0,[pool_0232F2D0]	; 0232F2C6
	add sp,#0x4	; 0232F2C8
	pop {r3}	; 0232F2CA
	bx r3	; 0232F2CC
	.byte 0xC0, 0x46	; 0232F2D0
pool_0232F2D0:
loc_0232F2D0:
	.word 0x0000FFFF	; 0232F2D0

; ===== function loc_0232F2D4 =====
loc_0232F2D4:
	push {lr}	; 0232F2D4
	sub sp,#0x4	; 0232F2D6
	ldr r2,[pool_0232F2F0]	; 0232F2D8
	add r3,sp,#0x0	; 0232F2DA
	bl loc_0232F2F4	; 0232F2DC
	cmp r0,#0x0	; 0232F2E0
	bne loc_0232F2EA	; 0232F2E2
	bl loc_0232F55C	; 0232F2E4
	ldr r0,[sp,#0x0]	; 0232F2E8
loc_0232F2EA:
	add sp,#0x4	; 0232F2EA
	pop {r3}	; 0232F2EC
	bx r3	; 0232F2EE
pool_0232F2F0:
loc_0232F2F0:
	.word 0x0232F559	; 0232F2F0

; ===== function loc_0232F2F4 =====
loc_0232F2F4:
	push {r4,r5,r6,r7,lr}	; 0232F2F4
	sub sp,#0x4	; 0232F2F6
	add r5,r0,#0x0	; 0232F2F8
	add r4,r1,#0x0	; 0232F2FA
	add r6,r2,#0x0	; 0232F2FC
	add r7,r3,#0x0	; 0232F2FE
	bl loc_0232F56C	; 0232F300
	cmp r0,#0x0	; 0232F304
	bne loc_0232F312	; 0232F306
	mov r0,#0x1	; 0232F308
	add sp,#0x4	; 0232F30A
	pop {r4,r5,r6,r7}	; 0232F30C
	pop {r3}	; 0232F30E
	bx r3	; 0232F310
loc_0232F312:
	ldr r0,[pool_0232F33C]	; 0232F312
	str r6,[r0,#0x4]	; 0232F314
	str r7,[r0,#0x8]	; 0232F316
	lsl r2,r5,#0x3	; 0232F318
	mov r1,#0x0	; 0232F31A
	ldr r0,[pool_0232F340]	; 0232F31C
	strh r1,[r0,r2]	; 0232F31E
	ldr r0,[pool_0232F344]	; 0232F320
	str r4,[r0,r2]	; 0232F322
	mov r0,#0xff	; 0232F324
	and r5,r0	; 0232F326
	ldr r0,[pool_0232F348]	; 0232F328
	orr r5,r0	; 0232F32A
	add r0,r5,#0x0	; 0232F32C
	bl loc_0232F18C	; 0232F32E
	mov r0,#0x0	; 0232F332
	add sp,#0x4	; 0232F334
	pop {r4,r5,r6,r7}	; 0232F336
	pop {r3}	; 0232F338
	bx r3	; 0232F33A
pool_0232F33C:
loc_0232F33C:
	.word P1_BssStart + 0x282D4	; 0232F33C
pool_0232F340:
loc_0232F340:
	.word P1_BssStart + 0x282F8	; 0232F340
pool_0232F344:
loc_0232F344:
	.word P1_BssStart + 0x282FC	; 0232F344
pool_0232F348:
loc_0232F348:
	.word 0x03006500	; 0232F348

; ===== function loc_0232F34C =====
loc_0232F34C:
	push {r4,r5,r6,lr}	; 0232F34C
	add r5,r0,#0x0	; 0232F34E
	add r4,r1,#0x0	; 0232F350
	add r6,r2,#0x0	; 0232F352
	bl loc_0232F56C	; 0232F354
	cmp r0,#0x0	; 0232F358
	bne loc_0232F364	; 0232F35A
	mov r0,#0x1	; 0232F35C
	pop {r4,r5,r6}	; 0232F35E
	pop {r3}	; 0232F360
	bx r3	; 0232F362
loc_0232F364:
	ldr r0,[pool_0232F390]	; 0232F364
	str r4,[r0,#0x4]	; 0232F366
	str r6,[r0,#0x8]	; 0232F368
	lsr r0,r5,#0x10	; 0232F36A
	mov r1,#0xff	; 0232F36C
	and r0,r1	; 0232F36E
	ldr r1,[pool_0232F394]	; 0232F370
	orr r0,r1	; 0232F372
	bl loc_0232F18C	; 0232F374
	ldr r0,[pool_0232F398]	; 0232F378
	and r5,r0	; 0232F37A
	ldr r0,[pool_0232F39C]	; 0232F37C
	orr r5,r0	; 0232F37E
	add r0,r5,#0x0	; 0232F380
	bl loc_0232F18C	; 0232F382
	mov r0,#0x0	; 0232F386
	pop {r4,r5,r6}	; 0232F388
	pop {r3}	; 0232F38A
	bx r3	; 0232F38C
	.byte 0xC0, 0x46	; 0232F390
pool_0232F390:
loc_0232F390:
	.word P1_BssStart + 0x282D4	; 0232F390
pool_0232F394:
loc_0232F394:
	.word 0x02006300	; 0232F394
pool_0232F398:
loc_0232F398:
	.word 0x0000FFFF	; 0232F398
pool_0232F39C:
loc_0232F39C:
	.word 0x01010000	; 0232F39C

; ===== function loc_0232F3A0 =====
loc_0232F3A0:
	push {r4,r5,lr}	; 0232F3A0
	sub sp,#0x4	; 0232F3A2
	add r5,r0,#0x0	; 0232F3A4
	add r4,r1,#0x0	; 0232F3A6
	bl loc_0232F56C	; 0232F3A8
	cmp r0,#0x0	; 0232F3AC
	bne loc_0232F3BA	; 0232F3AE
	mov r0,#0x1	; 0232F3B0
	add sp,#0x4	; 0232F3B2
	pop {r4,r5}	; 0232F3B4
	pop {r3}	; 0232F3B6
	bx r3	; 0232F3B8
loc_0232F3BA:
	mov r1,#0x0	; 0232F3BA
	ldr r0,[pool_0232F408]	; 0232F3BC
	str r1,[r0,#0x0]	; 0232F3BE
	ldr r0,[pool_0232F40C]	; 0232F3C0
	bl loc_0232F18C	; 0232F3C2
	ldr r1,[pool_0232F408]	; 0232F3C6
loc_0232F3C8:
	ldr r0,[r1,#0x0]	; 0232F3C8
	cmp r0,#0x0	; 0232F3CA
	beq loc_0232F3C8	; 0232F3CC
	mov r0,#0x0	; 0232F3CE
	str r0,[r1,#0x0]	; 0232F3D0
	ldr r1,[pool_0232F410]	; 0232F3D2
	str r0,[r1,#0x0]	; 0232F3D4
	mov r1,#0x2	; 0232F3D6
	add r2,r0,#0x0	; 0232F3D8
	add r3,r0,#0x0	; 0232F3DA
	bl loc_0232F03C	; 0232F3DC
	mov r0,#0xff	; 0232F3E0
	and r5,r0	; 0232F3E2
	ldr r0,[pool_0232F414]	; 0232F3E4
	orr r5,r0	; 0232F3E6
	add r0,r5,#0x0	; 0232F3E8
	bl loc_0232F18C	; 0232F3EA
	ldr r0,[pool_0232F418]	; 0232F3EE
	and r4,r0	; 0232F3F0
	ldr r0,[pool_0232F41C]	; 0232F3F2
	orr r4,r0	; 0232F3F4
	add r0,r4,#0x0	; 0232F3F6
	bl loc_0232F18C	; 0232F3F8
	mov r0,#0x0	; 0232F3FC
	add sp,#0x4	; 0232F3FE
	pop {r4,r5}	; 0232F400
	pop {r3}	; 0232F402
	bx r3	; 0232F404
	.byte 0xC0, 0x46	; 0232F408
pool_0232F408:
loc_0232F408:
	.word P1_BssStart + 0x282C8	; 0232F408
pool_0232F40C:
loc_0232F40C:
	.word 0x03006000	; 0232F40C
pool_0232F410:
loc_0232F410:
	.word P1_BssStart + 0x282CC	; 0232F410
pool_0232F414:
loc_0232F414:
	.word 0x02006100	; 0232F414
pool_0232F418:
loc_0232F418:
	.word 0x0000FFFF	; 0232F418
pool_0232F41C:
loc_0232F41C:
	.word 0x01010000	; 0232F41C

; ===== function loc_0232F420 =====
P1_PxiCallback_0232F420:
	push {lr}	; 0232F420
	sub sp,#0x4	; 0232F422
	cmp r2,#0x0	; 0232F424
	beq loc_0232F434	; 0232F426
	mov r0,#0x2	; 0232F428
	bl loc_0232F530	; 0232F42A
	add sp,#0x4	; 0232F42E
	pop {r3}	; 0232F430
	bx r3	; 0232F432
loc_0232F434:
	ldr r0,[pool_0232F4A0]	; 0232F434
	add r2,r1,#0x0	; 0232F436
	and r2,r0	; 0232F438
	lsl r0,r2,#0x8	; 0232F43A
	lsr r3,r0,#0x10	; 0232F43C
	mov r2,#0xff	; 0232F43E
	and r1,r2	; 0232F440
	lsl r0,r1,#0x10	; 0232F442
	lsr r0,r0,#0x10	; 0232F444
	cmp r3,#0x70	; 0232F446
	bcc loc_0232F46C	; 0232F448
	cmp r3,#0x73	; 0232F44A
	bhi loc_0232F46C	; 0232F44C
	and r0,r2	; 0232F44E
	lsl r0,r0,#0x10	; 0232F450
	lsr r1,r0,#0x10	; 0232F452
	sub r3,#0x70	; 0232F454
	lsl r2,r3,#0x3	; 0232F456
	ldr r0,[pool_0232F4A4]	; 0232F458
	ldr r0,[r0,r2]	; 0232F45A
	cmp r0,#0x0	; 0232F45C
	beq loc_0232F462	; 0232F45E
	strh r1,[r0,#0x0]	; 0232F460
loc_0232F462:
	mov r1,#0x1	; 0232F462
	ldr r0,[pool_0232F4A8]	; 0232F464
	strh r1,[r0,r2]	; 0232F466
	mov r0,#0x0	; 0232F468
	b loc_0232F494	; 0232F46A
loc_0232F46C:
	cmp r3,#0x60	; 0232F46C
	bne loc_0232F478	; 0232F46E
	mov r2,#0x1	; 0232F470
	ldr r1,[pool_0232F4AC]	; 0232F472
	str r2,[r1,#0x0]	; 0232F474
	b loc_0232F494	; 0232F476
loc_0232F478:
	cmp r3,#0x62	; 0232F478
	bne loc_0232F484	; 0232F47A
	mov r2,#0x1	; 0232F47C
	ldr r1,[pool_0232F4B0]	; 0232F47E
	str r2,[r1,#0x0]	; 0232F480
	b loc_0232F494	; 0232F482
loc_0232F484:
	cmp r3,#0x67	; 0232F484
	bne loc_0232F494	; 0232F486
	ldr r1,[pool_0232F4B4]	; 0232F488
	ldr r1,[r1,#0xc]	; 0232F48A
	cmp r1,#0x0	; 0232F48C
	beq loc_0232F492	; 0232F48E
	str r0,[r1,#0x0]	; 0232F490
loc_0232F492:
	mov r0,#0x0	; 0232F492
loc_0232F494:
	bl loc_0232F530	; 0232F494
	add sp,#0x4	; 0232F498
	pop {r3}	; 0232F49A
	bx r3	; 0232F49C
	.byte 0xC0, 0x46	; 0232F4A0
pool_0232F4A0:
loc_0232F4A0:
	.word 0x00007F00	; 0232F4A0
pool_0232F4A4:
loc_0232F4A4:
	.word P1_BssStart + 0x282FC	; 0232F4A4
pool_0232F4A8:
loc_0232F4A8:
	.word P1_BssStart + 0x282F8	; 0232F4A8
pool_0232F4AC:
loc_0232F4AC:
	.word P1_BssStart + 0x282C8	; 0232F4AC
pool_0232F4B0:
loc_0232F4B0:
	.word P1_BssStart + 0x282CC	; 0232F4B0
pool_0232F4B4:
loc_0232F4B4:
	.word P1_BssStart + 0x282D4	; 0232F4B4

; ===== function loc_0232F4B8 =====
loc_0232F4B8:
	push {r4,r5,lr}	; 0232F4B8
	sub sp,#0x4	; 0232F4BA
	ldr r0,[pool_0232F514]	; 0232F4BC
	ldrh r1,[r0,#0x0]	; 0232F4BE
	cmp r1,#0x0	; 0232F4C0
	bne loc_0232F50A	; 0232F4C2
	mov r1,#0x1	; 0232F4C4
	strh r1,[r0,#0x0]	; 0232F4C6
	mov r1,#0x0	; 0232F4C8
	ldr r0,[pool_0232F518]	; 0232F4CA
	str r1,[r0,#0x0]	; 0232F4CC
	str r1,[r0,#0x4]	; 0232F4CE
	bl loc_0232E7E4	; 0232F4D0
	mov r5,#0x8	; 0232F4D4
	mov r4,#0x1	; 0232F4D6
loc_0232F4D8:
	add r0,r5,#0x0	; 0232F4D8
	add r1,r4,#0x0	; 0232F4DA
	bl loc_0232E958	; 0232F4DC
	cmp r0,#0x0	; 0232F4E0
	beq loc_0232F4D8	; 0232F4E2
	mov r0,#0x8	; 0232F4E4
	ldr r1,[pool_0232F51C]	; 0232F4E6
	bl P1_SetPxiReceiveCallback	; 0232F4E8
	mov r2,#0x0	; 0232F4EC
	ldr r1,[pool_0232F520]	; 0232F4EE
	add r0,r2,#0x0	; 0232F4F0
loc_0232F4F2:
	strh r0,[r1,#0x0]	; 0232F4F2
	add r1,#0x8	; 0232F4F4
	add r2,r2,#0x1	; 0232F4F6
	cmp r2,#0x4	; 0232F4F8
	blt loc_0232F4F2	; 0232F4FA
	ldr r0,[pool_0232F524]	; 0232F4FC
	bl loc_0232BB84	; 0232F4FE
	ldr r0,[pool_0232F528]	; 0232F502
	ldr r1,[r0,#0x0]	; 0232F504
	ldr r0,[pool_0232F52C]	; 0232F506
	str r1,[r0,#0x0]	; 0232F508
loc_0232F50A:
	add sp,#0x4	; 0232F50A
	pop {r4,r5}	; 0232F50C
	pop {r3}	; 0232F50E
	bx r3	; 0232F510
	.byte 0xC0, 0x46	; 0232F514
pool_0232F514:
loc_0232F514:
	.word P1_BssStart + 0x282C4	; 0232F514
pool_0232F518:
loc_0232F518:
	.word P1_BssStart + 0x282D4	; 0232F518
pool_0232F51C:
loc_0232F51C:
	.word P1_PxiCallback_0232F420 + 1	; 0232F51C
pool_0232F520:
loc_0232F520:
	.word P1_BssStart + 0x282F8	; 0232F520
pool_0232F524:
loc_0232F524:
	.word 0x02358D64	; 0232F524
pool_0232F528:
loc_0232F528:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232F528
pool_0232F52C:
loc_0232F52C:
	.word P1_BssStart + 0x282D0	; 0232F52C

; ===== function loc_0232F530 =====
loc_0232F530:
	push {r4,lr}	; 0232F530
	ldr r3,[pool_0232F554]	; 0232F532
	ldr r2,[r3,#0x4]	; 0232F534
	ldr r1,[r3,#0x8]	; 0232F536
	ldr r4,[r3,#0x0]	; 0232F538
	cmp r4,#0x0	; 0232F53A
	beq loc_0232F542	; 0232F53C
	mov r4,#0x0	; 0232F53E
	str r4,[r3,#0x0]	; 0232F540
loc_0232F542:
	cmp r2,#0x0	; 0232F542
	beq loc_0232F54E	; 0232F544
	mov r4,#0x0	; 0232F546
	ldr r3,[pool_0232F554]	; 0232F548
	str r4,[r3,#0x4]	; 0232F54A
	blx r2	; 0232F54C
loc_0232F54E:
	pop {r4}	; 0232F54E
	pop {r3}	; 0232F550
	bx r3	; 0232F552
pool_0232F554:
loc_0232F554:
	.word P1_BssStart + 0x282D4	; 0232F554
	str r0,[r1,#0x0]	; 0232F558
	bx lr	; 0232F55A

; ===== function loc_0232F55C =====
loc_0232F55C:
	ldr r1,[pool_0232F568]	; 0232F55C
loc_0232F55E:
	ldr r0,[r1,#0x0]	; 0232F55E
	cmp r0,#0x0	; 0232F560
	bne loc_0232F55E	; 0232F562
	bx lr	; 0232F564
	.byte 0xC0, 0x46	; 0232F568
pool_0232F568:
loc_0232F568:
	.word P1_BssStart + 0x282D4	; 0232F568

; ===== function loc_0232F56C =====
loc_0232F56C:
	push {lr}	; 0232F56C
	sub sp,#0x4	; 0232F56E
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F570
	ldr r1,[pool_0232F598]	; 0232F574
	ldr r2,[r1,#0x0]	; 0232F576
	cmp r2,#0x0	; 0232F578
	beq loc_0232F588	; 0232F57A
	blx P1_Arm9RestoreIrqMask	; 0232F57C
	mov r0,#0x0	; 0232F580
	add sp,#0x4	; 0232F582
	pop {r3}	; 0232F584
	bx r3	; 0232F586
loc_0232F588:
	mov r2,#0x1	; 0232F588
	str r2,[r1,#0x0]	; 0232F58A
	blx P1_Arm9RestoreIrqMask	; 0232F58C
	mov r0,#0x1	; 0232F590
	add sp,#0x4	; 0232F592
	pop {r3}	; 0232F594
	bx r3	; 0232F596
pool_0232F598:
loc_0232F598:
	.word P1_BssStart + 0x282D4	; 0232F598
.arm

; ===== function loc_0232F59C =====
loc_0232F59C:
	ldr r12,[pool_0232F5B0]	; 0232F59C
loc_0232F5A0:
	ldr r0,[r12,#0x0]	; 0232F5A0
	cmp r0,#0x1	; 0232F5A4
	beq loc_0232F5A0	; 0232F5A8
	bx lr	; 0232F5AC
pool_0232F5B0:
loc_0232F5B0:
	.word P1_BssStart + 0x2831C	; 0232F5B0
.thumb
	ldr r1,[pool_0232F5BC]	; 0232F5B4
	str r0,[r1,#0x20]	; 0232F5B6
	bx lr	; 0232F5B8
	.byte 0xC0, 0x46	; 0232F5BC
pool_0232F5BC:
loc_0232F5BC:
	.word P1_BssStart + 0x2831C	; 0232F5BC

; ===== function loc_0232F5C0 =====
loc_0232F5C0:
	push {r4,r5,lr}	; 0232F5C0
	sub sp,#0x4	; 0232F5C2
	add r5,r0,#0x0	; 0232F5C4
	add r4,r1,#0x0	; 0232F5C6
	ldr r0,[r5,#0x0]	; 0232F5C8
	cmp r0,#0xc	; 0232F5CA
	bcc loc_0232F5D8	; 0232F5CC
	ldr r1,[r4,#0x0]	; 0232F5CE
	mov r0,#0x40	; 0232F5D0
	orr r1,r0	; 0232F5D2
	str r1,[r4,#0x0]	; 0232F5D4
	b loc_0232F5E0	; 0232F5D6
loc_0232F5D8:
	ldr r1,[r4,#0x0]	; 0232F5D8
	mov r0,#0x40	; 0232F5DA
	bic r1,r0	; 0232F5DC
	str r1,[r4,#0x0]	; 0232F5DE
loc_0232F5E0:
	ldr r0,[r5,#0x0]	; 0232F5E0
	bl loc_0232F734	; 0232F5E2
	ldr r2,[r4,#0x0]	; 0232F5E6
	mov r1,#0x3f	; 0232F5E8
	bic r2,r1	; 0232F5EA
	and r0,r1	; 0232F5EC
	orr r2,r0	; 0232F5EE
	str r2,[r4,#0x0]	; 0232F5F0
	ldr r0,[r5,#0x4]	; 0232F5F2
	bl loc_0232F734	; 0232F5F4
	ldr r2,[r4,#0x0]	; 0232F5F8
	ldr r1,[pool_0232F628]	; 0232F5FA
	and r2,r1	; 0232F5FC
	mov r1,#0x7f	; 0232F5FE
	and r0,r1	; 0232F600
	lsl r0,r0,#0x8	; 0232F602
	orr r2,r0	; 0232F604
	str r2,[r4,#0x0]	; 0232F606
	ldr r0,[r5,#0x8]	; 0232F608
	bl loc_0232F734	; 0232F60A
	ldr r2,[r4,#0x0]	; 0232F60E
	ldr r1,[pool_0232F62C]	; 0232F610
	and r2,r1	; 0232F612
	mov r1,#0x7f	; 0232F614
	and r0,r1	; 0232F616
	lsl r0,r0,#0x10	; 0232F618
	orr r2,r0	; 0232F61A
	str r2,[r4,#0x0]	; 0232F61C
	add sp,#0x4	; 0232F61E
	pop {r4,r5}	; 0232F620
	pop {r3}	; 0232F622
	bx r3	; 0232F624
	.byte 0xC0, 0x46	; 0232F628
pool_0232F628:
loc_0232F628:
	.word 0xFFFF80FF	; 0232F628
pool_0232F62C:
loc_0232F62C:
	.word 0xFF80FFFF	; 0232F62C

; ===== function loc_0232F630 =====
loc_0232F630:
	push {r4,r5,lr}	; 0232F630
	sub sp,#0x4	; 0232F632
	add r5,r0,#0x0	; 0232F634
	add r4,r1,#0x0	; 0232F636
	ldr r0,[r5,#0x0]	; 0232F638
	bl loc_0232F734	; 0232F63A
	str r0,[r4,#0x0]	; 0232F63E
	ldr r0,[r5,#0x4]	; 0232F640
	bl loc_0232F734	; 0232F642
	ldr r2,[r4,#0x0]	; 0232F646
	ldr r1,[pool_0232F688]	; 0232F648
	and r2,r1	; 0232F64A
	mov r1,#0x1f	; 0232F64C
	and r0,r1	; 0232F64E
	lsl r0,r0,#0x8	; 0232F650
	orr r2,r0	; 0232F652
	str r2,[r4,#0x0]	; 0232F654
	ldr r0,[r5,#0x8]	; 0232F656
	bl loc_0232F734	; 0232F658
	ldr r2,[r4,#0x0]	; 0232F65C
	ldr r1,[pool_0232F68C]	; 0232F65E
	and r2,r1	; 0232F660
	mov r1,#0x3f	; 0232F662
	and r0,r1	; 0232F664
	lsl r0,r0,#0x10	; 0232F666
	orr r2,r0	; 0232F668
	str r2,[r4,#0x0]	; 0232F66A
	ldr r2,[r4,#0x0]	; 0232F66C
	ldr r0,[pool_0232F690]	; 0232F66E
	and r2,r0	; 0232F670
	ldr r1,[r5,#0xc]	; 0232F672
	mov r0,#0x7	; 0232F674
	and r1,r0	; 0232F676
	lsl r0,r1,#0x18	; 0232F678
	orr r2,r0	; 0232F67A
	str r2,[r4,#0x0]	; 0232F67C
	add sp,#0x4	; 0232F67E
	pop {r4,r5}	; 0232F680
	pop {r3}	; 0232F682
	bx r3	; 0232F684
	.byte 0xC0, 0x46	; 0232F688
pool_0232F688:
loc_0232F688:
	.word 0xFFFFE0FF	; 0232F688
pool_0232F68C:
loc_0232F68C:
	.word 0xFFC0FFFF	; 0232F68C
pool_0232F690:
loc_0232F690:
	.word 0xF8FFFFFF	; 0232F690

; ===== function loc_0232F694 =====
loc_0232F694:
	push {r4,lr}	; 0232F694
	sub sp,#0x8	; 0232F696
	add r4,r0,#0x0	; 0232F698
	mov r2,#0x0	; 0232F69A
	str r2,[sp,#0x0]	; 0232F69C
	mov r0,#0x7	; 0232F69E
	bic r2,r0	; 0232F6A0
	ldr r1,[r4,#0x0]	; 0232F6A2
	and r1,r0	; 0232F6A4
	orr r2,r1	; 0232F6A6
	str r2,[sp,#0x0]	; 0232F6A8
	ldr r0,[r4,#0x4]	; 0232F6AA
	cmp r0,#0xc	; 0232F6AC
	bcc loc_0232F6B6	; 0232F6AE
	ldr r0,[pool_0232F720]	; 0232F6B0
	orr r2,r0	; 0232F6B2
	str r2,[sp,#0x0]	; 0232F6B4
loc_0232F6B6:
	ldr r0,[r4,#0x4]	; 0232F6B6
	bl loc_0232F734	; 0232F6B8
	ldr r2,[sp,#0x0]	; 0232F6BC
	ldr r1,[pool_0232F724]	; 0232F6BE
	and r2,r1	; 0232F6C0
	mov r1,#0x3f	; 0232F6C2
	and r0,r1	; 0232F6C4
	lsl r0,r0,#0x8	; 0232F6C6
	orr r2,r0	; 0232F6C8
	str r2,[sp,#0x0]	; 0232F6CA
	ldr r0,[r4,#0x8]	; 0232F6CC
	bl loc_0232F734	; 0232F6CE
	ldr r1,[sp,#0x0]	; 0232F6D2
	ldr r2,[pool_0232F728]	; 0232F6D4
	and r1,r2	; 0232F6D6
	mov r2,#0x7f	; 0232F6D8
	and r0,r2	; 0232F6DA
	lsl r0,r0,#0x10	; 0232F6DC
	orr r1,r0	; 0232F6DE
	str r1,[sp,#0x0]	; 0232F6E0
	ldr r2,[r4,#0xc]	; 0232F6E2
	mov r0,#0x1	; 0232F6E4
	and r2,r0	; 0232F6E6
	cmp r2,#0x0	; 0232F6E8
	beq loc_0232F6F2	; 0232F6EA
	mov r0,#0x80	; 0232F6EC
	orr r1,r0	; 0232F6EE
	str r1,[sp,#0x0]	; 0232F6F0
loc_0232F6F2:
	ldr r1,[r4,#0xc]	; 0232F6F2
	mov r0,#0x2	; 0232F6F4
	and r1,r0	; 0232F6F6
	cmp r1,#0x0	; 0232F6F8
	beq loc_0232F704	; 0232F6FA
	ldr r1,[sp,#0x0]	; 0232F6FC
	ldr r0,[pool_0232F72C]	; 0232F6FE
	orr r1,r0	; 0232F700
	str r1,[sp,#0x0]	; 0232F702
loc_0232F704:
	ldr r1,[r4,#0xc]	; 0232F704
	mov r0,#0x4	; 0232F706
	and r1,r0	; 0232F708
	cmp r1,#0x0	; 0232F70A
	beq loc_0232F716	; 0232F70C
	ldr r1,[sp,#0x0]	; 0232F70E
	ldr r0,[pool_0232F730]	; 0232F710
	orr r1,r0	; 0232F712
	str r1,[sp,#0x0]	; 0232F714
loc_0232F716:
	ldr r0,[sp,#0x0]	; 0232F716
	add sp,#0x8	; 0232F718
	pop {r4}	; 0232F71A
	pop {r3}	; 0232F71C
	bx r3	; 0232F71E
pool_0232F720:
loc_0232F720:
	.word 0x00004000	; 0232F720
pool_0232F724:
loc_0232F724:
	.word 0xFFFFC0FF	; 0232F724
pool_0232F728:
loc_0232F728:
	.word 0xFF80FFFF	; 0232F728
pool_0232F72C:
loc_0232F72C:
	.word 0x00008000	; 0232F72C
pool_0232F730:
loc_0232F730:
	.word 0x00800000	; 0232F730

; ===== function loc_0232F734 =====
loc_0232F734:
	push {r4,r5,r6,r7,lr}	; 0232F734
	sub sp,#0x4	; 0232F736
	add r5,r0,#0x0	; 0232F738
	mov r6,#0x0	; 0232F73A
	ldr r0,[pool_0232F778]	; 0232F73C
	cmp r5,r0	; 0232F73E
	bls loc_0232F74C	; 0232F740
	add r0,r6,#0x0	; 0232F742
	add sp,#0x4	; 0232F744
	pop {r4,r5,r6,r7}	; 0232F746
	pop {r3}	; 0232F748
	bx r3	; 0232F74A
loc_0232F74C:
	add r7,r6,#0x0	; 0232F74C
	add r4,r6,#0x0	; 0232F74E
loc_0232F750:
	add r0,r5,#0x0	; 0232F750
	mov r1,#0xa	; 0232F752
	blx P1_UnsignedDivMod	; 0232F754
	lsl r1,r4	; 0232F758
	add r6,r6,r1	; 0232F75A
	add r0,r5,#0x0	; 0232F75C
	mov r1,#0xa	; 0232F75E
	blx P1_UnsignedDivMod	; 0232F760
	add r5,r0,#0x0	; 0232F764
	add r4,r4,#0x4	; 0232F766
	add r7,r7,#0x1	; 0232F768
	cmp r7,#0x8	; 0232F76A
	blt loc_0232F750	; 0232F76C
	add r0,r6,#0x0	; 0232F76E
	add sp,#0x4	; 0232F770
	pop {r4,r5,r6,r7}	; 0232F772
	pop {r3}	; 0232F774
	bx r3	; 0232F776
pool_0232F778:
loc_0232F778:
	.word 0x05F5E0FF	; 0232F778

; ===== function loc_0232F77C =====
loc_0232F77C:
	push {r4,r5,r6,r7}	; 0232F77C
	mov r4,#0x0	; 0232F77E
	add r5,r4,#0x0	; 0232F780
	add r3,r4,#0x0	; 0232F782
	mov r1,#0xf	; 0232F784
loc_0232F786:
	add r2,r0,#0x0	; 0232F786
	lsr r2,r3	; 0232F788
	and r2,r1	; 0232F78A
	cmp r2,#0xa	; 0232F78C
	bcc loc_0232F796	; 0232F78E
	mov r0,#0x0	; 0232F790
	pop {r4,r5,r6,r7}	; 0232F792
	bx lr	; 0232F794
loc_0232F796:
	add r3,r3,#0x4	; 0232F796
	add r5,r5,#0x1	; 0232F798
	cmp r5,#0x8	; 0232F79A
	blt loc_0232F786	; 0232F79C
	mov r1,#0x0	; 0232F79E
	mov r3,#0x1	; 0232F7A0
	add r2,r1,#0x0	; 0232F7A2
	mov r6,#0xa	; 0232F7A4
loc_0232F7A6:
	add r7,r0,#0x0	; 0232F7A6
	lsr r7,r2	; 0232F7A8
	mov r5,#0xf	; 0232F7AA
	and r7,r5	; 0232F7AC
	add r5,r3,#0x0	; 0232F7AE
	mul r5,r7	; 0232F7B0
	add r4,r4,r5	; 0232F7B2
	add r2,r2,#0x4	; 0232F7B4
	add r1,r1,#0x1	; 0232F7B6
	mul r3,r6	; 0232F7B8
	cmp r1,#0x8	; 0232F7BA
	blt loc_0232F7A6	; 0232F7BC
	add r0,r4,#0x0	; 0232F7BE
	pop {r4,r5,r6,r7}	; 0232F7C0
	bx lr	; 0232F7C2

; ===== function loc_0232F7C4 =====
P1_PxiCallback_0232F7C4:
	push {r4,r5,lr}	; 0232F7C4
	sub sp,#0x4	; 0232F7C6
	cmp r2,#0x0	; 0232F7C8
	beq loc_0232F800	; 0232F7CA
	ldr r0,[pool_0232FA98]	; 0232F7CC
	ldr r1,[r0,#0x18]	; 0232F7CE
	cmp r1,#0x0	; 0232F7D0
	beq loc_0232F7D8	; 0232F7D2
	mov r1,#0x0	; 0232F7D4
	str r1,[r0,#0x18]	; 0232F7D6
loc_0232F7D8:
	ldr r0,[pool_0232FA98]	; 0232F7D8
	ldr r1,[r0,#0x0]	; 0232F7DA
	cmp r1,#0x0	; 0232F7DC
	beq loc_0232F7E4	; 0232F7DE
	mov r1,#0x0	; 0232F7E0
	str r1,[r0,#0x0]	; 0232F7E2
loc_0232F7E4:
	ldr r1,[pool_0232FA98]	; 0232F7E4
	ldr r2,[r1,#0x4]	; 0232F7E6
	cmp r2,#0x0	; 0232F7E8
	bne loc_0232F7EE	; 0232F7EA
	b loc_0232FA8E	; 0232F7EC
loc_0232F7EE:
	mov r0,#0x0	; 0232F7EE
	str r0,[r1,#0x4]	; 0232F7F0
	mov r0,#0x6	; 0232F7F2
	ldr r1,[r1,#0x10]	; 0232F7F4
	blx r2	; 0232F7F6
	add sp,#0x4	; 0232F7F8
	pop {r4,r5}	; 0232F7FA
	pop {r3}	; 0232F7FC
	bx r3	; 0232F7FE
loc_0232F800:
	mov r2,#0xff	; 0232F800
	add r0,r1,#0x0	; 0232F802
	and r0,r2	; 0232F804
	ldr r3,[pool_0232FA9C]	; 0232F806
	and r1,r3	; 0232F808
	lsr r1,r1,#0x8	; 0232F80A
	lsl r1,r1,#0x18	; 0232F80C
	lsr r1,r1,#0x18	; 0232F80E
	cmp r1,#0x30	; 0232F810
	bne loc_0232F828	; 0232F812
	ldr r0,[pool_0232FA98]	; 0232F814
	ldr r0,[r0,#0x1c]	; 0232F816
	cmp r0,#0x0	; 0232F818
	bne loc_0232F81E	; 0232F81A
	b loc_0232FA8E	; 0232F81C
loc_0232F81E:
	blx r0	; 0232F81E
	add sp,#0x4	; 0232F820
	pop {r4,r5}	; 0232F822
	pop {r3}	; 0232F824
	bx r3	; 0232F826
loc_0232F828:
	cmp r0,#0x0	; 0232F828
	beq loc_0232F82E	; 0232F82A
	b loc_0232FA3A	; 0232F82C
loc_0232F82E:
	mov r4,#0x0	; 0232F82E
	ldr r0,[pool_0232FA98]	; 0232F830
	ldr r1,[r0,#0x14]	; 0232F832
	cmp r1,#0xf	; 0232F834
	bls loc_0232F83A	; 0232F836
	b loc_0232FA30	; 0232F838
loc_0232F83A:
	add r1,r1,r1	; 0232F83A
P1_SwitchIndexPC_0232F83A:
	add r1,pc	; 0232F83C
	ldrh r1,[r1,#(P1_SwitchTable_0232F83A - (P1_SwitchIndexPC_0232F83A + 4))]	; 0232F83E
	lsl r1,r1,#0x10	; 0232F840
	asr r1,r1,#0x10	; 0232F842
P1_SwitchTargetPC_0232F83A:
	add r1,pc	; 0232F844
	bx r1	; 0232F846
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232F83A:
	.halfword (loc_0232FA30 + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232FA30 + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232F868 + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232FA30 + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232FA30 + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232FA6A + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232F8CC + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232F8E4 + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232F8FC + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232F960 + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232F9CA + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232FA6A + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232FA6A + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232FA6A + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232FA6A + 1) - (P1_SwitchTargetPC_0232F83A + 4)
	.halfword (loc_0232FA6A + 1) - (P1_SwitchTargetPC_0232F83A + 4)
P1_SwitchTable_0232F83AEnd:
loc_0232F868:
	ldr r5,[r0,#0x8]	; 0232F868
	ldr r0,[pool_0232FAA0]	; 0232F86A
	ldr r0,[r0,#0x0]	; 0232F86C
	and r0,r2	; 0232F86E
	bl loc_0232F77C	; 0232F870
	str r0,[r5,#0x0]	; 0232F874
	ldr r0,[pool_0232FAA0]	; 0232F876
	ldr r0,[r0,#0x0]	; 0232F878
	lsl r0,r0,#0x13	; 0232F87A
	lsr r0,r0,#0x1b	; 0232F87C
	bl loc_0232F77C	; 0232F87E
	str r0,[r5,#0x4]	; 0232F882
	ldr r0,[pool_0232FAA0]	; 0232F884
	ldr r0,[r0,#0x0]	; 0232F886
	lsl r0,r0,#0xa	; 0232F888
	lsr r0,r0,#0x1a	; 0232F88A
	bl loc_0232F77C	; 0232F88C
	str r0,[r5,#0x8]	; 0232F890
	ldr r0,[pool_0232FAA0]	; 0232F892
	ldr r0,[r0,#0x0]	; 0232F894
	lsl r0,r0,#0x5	; 0232F896
	lsr r0,r0,#0x1d	; 0232F898
	str r0,[r5,#0xc]	; 0232F89A
	ldr r0,[pool_0232FA98]	; 0232F89C
	ldr r5,[r0,#0xc]	; 0232F89E
	ldr r0,[pool_0232FAA4]	; 0232F8A0
	ldr r0,[r0,#0x0]	; 0232F8A2
	lsl r0,r0,#0x1a	; 0232F8A4
	lsr r0,r0,#0x1a	; 0232F8A6
	bl loc_0232F77C	; 0232F8A8
	str r0,[r5,#0x0]	; 0232F8AC
	ldr r0,[pool_0232FAA4]	; 0232F8AE
	ldr r0,[r0,#0x0]	; 0232F8B0
	lsl r0,r0,#0x11	; 0232F8B2
	lsr r0,r0,#0x19	; 0232F8B4
	bl loc_0232F77C	; 0232F8B6
	str r0,[r5,#0x4]	; 0232F8BA
	ldr r0,[pool_0232FAA4]	; 0232F8BC
	ldr r0,[r0,#0x0]	; 0232F8BE
	lsl r0,r0,#0x9	; 0232F8C0
	lsr r0,r0,#0x19	; 0232F8C2
	bl loc_0232F77C	; 0232F8C4
	str r0,[r5,#0x8]	; 0232F8C8
	b loc_0232FA6A	; 0232F8CA
loc_0232F8CC:
	ldr r1,[r0,#0x8]	; 0232F8CC
	ldr r0,[pool_0232FAA8]	; 0232F8CE
	ldrh r0,[r0,#0x0]	; 0232F8D0
	lsl r0,r0,#0x1c	; 0232F8D2
	lsr r0,r0,#0x1c	; 0232F8D4
	cmp r0,#0x4	; 0232F8D6
	bne loc_0232F8E0	; 0232F8D8
	mov r0,#0x1	; 0232F8DA
	str r0,[r1,#0x0]	; 0232F8DC
	b loc_0232FA6A	; 0232F8DE
loc_0232F8E0:
	str r4,[r1,#0x0]	; 0232F8E0
	b loc_0232FA6A	; 0232F8E2
loc_0232F8E4:
	ldr r1,[r0,#0x8]	; 0232F8E4
	ldr r0,[pool_0232FAA8]	; 0232F8E6
	ldrh r0,[r0,#0x0]	; 0232F8E8
	lsl r0,r0,#0x19	; 0232F8EA
	lsr r0,r0,#0x1f	; 0232F8EC
	cmp r0,#0x0	; 0232F8EE
	beq loc_0232F8F8	; 0232F8F0
	mov r0,#0x1	; 0232F8F2
	str r0,[r1,#0x0]	; 0232F8F4
	b loc_0232FA6A	; 0232F8F6
loc_0232F8F8:
	str r4,[r1,#0x0]	; 0232F8F8
	b loc_0232FA6A	; 0232F8FA
loc_0232F8FC:
	ldr r5,[r0,#0x8]	; 0232F8FC
	ldr r1,[pool_0232FAA4]	; 0232F8FE
	ldr r0,[r1,#0x0]	; 0232F900
	lsl r0,r0,#0x1d	; 0232F902
	lsr r0,r0,#0x1d	; 0232F904
	str r0,[r5,#0x0]	; 0232F906
	ldr r0,[r1,#0x0]	; 0232F908
	lsl r0,r0,#0x12	; 0232F90A
	lsr r0,r0,#0x1a	; 0232F90C
	bl loc_0232F77C	; 0232F90E
	str r0,[r5,#0x4]	; 0232F912
	ldr r0,[pool_0232FAA4]	; 0232F914
	ldr r0,[r0,#0x0]	; 0232F916
	lsl r0,r0,#0x9	; 0232F918
	lsr r0,r0,#0x19	; 0232F91A
	bl loc_0232F77C	; 0232F91C
	str r0,[r5,#0x8]	; 0232F920
	lsl r0,r4,#0	; 0232F922
	str r0,[r5,#0xc]	; 0232F924
	ldr r0,[pool_0232FAA4]	; 0232F926
	ldr r0,[r0,#0x0]	; 0232F928
	lsl r0,r0,#0x18	; 0232F92A
	lsr r0,r0,#0x1f	; 0232F92C
	cmp r0,#0x0	; 0232F92E
	beq loc_0232F938	; 0232F930
	ldr r0,[r5,#0xc]	; 0232F932
	add r0,r0,#0x1	; 0232F934
	str r0,[r5,#0xc]	; 0232F936
loc_0232F938:
	ldr r0,[pool_0232FAA4]	; 0232F938
	ldr r0,[r0,#0x0]	; 0232F93A
	lsl r0,r0,#0x10	; 0232F93C
	lsr r0,r0,#0x1f	; 0232F93E
	cmp r0,#0x0	; 0232F940
	beq loc_0232F94A	; 0232F942
	ldr r0,[r5,#0xc]	; 0232F944
	add r0,r0,#0x2	; 0232F946
	str r0,[r5,#0xc]	; 0232F948
loc_0232F94A:
	ldr r0,[pool_0232FAA4]	; 0232F94A
	ldr r0,[r0,#0x0]	; 0232F94C
	lsl r0,r0,#0x8	; 0232F94E
	lsr r0,r0,#0x1f	; 0232F950
	cmp r0,#0x0	; 0232F952
	bne loc_0232F958	; 0232F954
	b loc_0232FA6A	; 0232F956
loc_0232F958:
	ldr r0,[r5,#0xc]	; 0232F958
	add r0,r0,#0x4	; 0232F95A
	str r0,[r5,#0xc]	; 0232F95C
	b loc_0232FA6A	; 0232F95E
loc_0232F960:
	ldr r2,[r0,#0x18]	; 0232F960
	cmp r2,#0x0	; 0232F962
	bne loc_0232F9C6	; 0232F964
	ldr r1,[r0,#0x8]	; 0232F966
	ldr r1,[r1,#0x0]	; 0232F968
	cmp r1,#0x1	; 0232F96A
	bne loc_0232F99C	; 0232F96C
	ldr r1,[pool_0232FAA8]	; 0232F96E
	ldrh r3,[r1,#0x0]	; 0232F970
	lsl r3,r3,#0x1c	; 0232F972
	lsr r3,r3,#0x1c	; 0232F974
	cmp r3,#0x4	; 0232F976
	beq loc_0232FA6A	; 0232F978
	add r2,r2,#0x1	; 0232F97A
	str r2,[r0,#0x18]	; 0232F97C
	ldrh r2,[r1,#0x0]	; 0232F97E
	mov r0,#0xf	; 0232F980
	bic r2,r0	; 0232F982
	mov r0,#0x4	; 0232F984
	orr r2,r0	; 0232F986
	strh r2,[r1,#0x0]	; 0232F988
	bl loc_0232FE34	; 0232F98A
	cmp r0,#0x0	; 0232F98E
	bne loc_0232FA6A	; 0232F990
	lsl r1,r4,#0	; 0232F992
	ldr r0,[pool_0232FA98]	; 0232F994
	str r1,[r0,#0x18]	; 0232F996
	mov r4,#0x3	; 0232F998
	b loc_0232FA6A	; 0232F99A
loc_0232F99C:
	ldr r1,[pool_0232FAA8]	; 0232F99C
	ldrh r3,[r1,#0x0]	; 0232F99E
	lsl r3,r3,#0x1c	; 0232F9A0
	lsr r3,r3,#0x1c	; 0232F9A2
	cmp r3,#0x0	; 0232F9A4
	beq loc_0232FA6A	; 0232F9A6
	add r2,r2,#0x1	; 0232F9A8
	str r2,[r0,#0x18]	; 0232F9AA
	ldrh r2,[r1,#0x0]	; 0232F9AC
	mov r0,#0xf	; 0232F9AE
	bic r2,r0	; 0232F9B0
	strh r2,[r1,#0x0]	; 0232F9B2
	bl loc_0232FE34	; 0232F9B4
	cmp r0,#0x0	; 0232F9B8
	bne loc_0232FA6A	; 0232F9BA
	lsl r1,r4,#0	; 0232F9BC
	ldr r0,[pool_0232FA98]	; 0232F9BE
	str r1,[r0,#0x18]	; 0232F9C0
	mov r4,#0x3	; 0232F9C2
	b loc_0232FA6A	; 0232F9C4
loc_0232F9C6:
	str r4,[r0,#0x18]	; 0232F9C6
	b loc_0232FA6A	; 0232F9C8
loc_0232F9CA:
	ldr r2,[r0,#0x18]	; 0232F9CA
	cmp r2,#0x0	; 0232F9CC
	bne loc_0232FA2C	; 0232F9CE
	ldr r1,[r0,#0x8]	; 0232F9D0
	ldr r1,[r1,#0x0]	; 0232F9D2
	cmp r1,#0x1	; 0232F9D4
	bne loc_0232FA02	; 0232F9D6
	ldr r1,[pool_0232FAA8]	; 0232F9D8
	ldrh r3,[r1,#0x0]	; 0232F9DA
	lsl r3,r3,#0x19	; 0232F9DC
	lsr r3,r3,#0x1f	; 0232F9DE
	cmp r3,#0x0	; 0232F9E0
	bne loc_0232FA6A	; 0232F9E2
	add r2,r2,#0x1	; 0232F9E4
	str r2,[r0,#0x18]	; 0232F9E6
	ldrh r2,[r1,#0x0]	; 0232F9E8
	mov r0,#0x40	; 0232F9EA
	orr r2,r0	; 0232F9EC
	strh r2,[r1,#0x0]	; 0232F9EE
	bl loc_0232FE34	; 0232F9F0
	cmp r0,#0x0	; 0232F9F4
	bne loc_0232FA6A	; 0232F9F6
	lsl r1,r4,#0	; 0232F9F8
	ldr r0,[pool_0232FA98]	; 0232F9FA
	str r1,[r0,#0x18]	; 0232F9FC
	mov r4,#0x3	; 0232F9FE
	b loc_0232FA6A	; 0232FA00
loc_0232FA02:
	ldr r1,[pool_0232FAA8]	; 0232FA02
	ldrh r3,[r1,#0x0]	; 0232FA04
	lsl r3,r3,#0x19	; 0232FA06
	lsr r3,r3,#0x1f	; 0232FA08
	cmp r3,#0x0	; 0232FA0A
	beq loc_0232FA6A	; 0232FA0C
	add r2,r2,#0x1	; 0232FA0E
	str r2,[r0,#0x18]	; 0232FA10
	ldrh r2,[r1,#0x0]	; 0232FA12
	mov r0,#0x40	; 0232FA14
	bic r2,r0	; 0232FA16
	strh r2,[r1,#0x0]	; 0232FA18
	bl loc_0232FE34	; 0232FA1A
	cmp r0,#0x0	; 0232FA1E
	bne loc_0232FA6A	; 0232FA20
	lsl r1,r4,#0	; 0232FA22
	ldr r0,[pool_0232FA98]	; 0232FA24
	str r1,[r0,#0x18]	; 0232FA26
	mov r4,#0x3	; 0232FA28
	b loc_0232FA6A	; 0232FA2A
loc_0232FA2C:
	str r4,[r0,#0x18]	; 0232FA2C
	b loc_0232FA6A	; 0232FA2E
loc_0232FA30:
	mov r4,#0x4	; 0232FA30
	mov r1,#0x0	; 0232FA32
	ldr r0,[pool_0232FA98]	; 0232FA34
	str r1,[r0,#0x18]	; 0232FA36
	b loc_0232FA6A	; 0232FA38
loc_0232FA3A:
	mov r2,#0x0	; 0232FA3A
	ldr r1,[pool_0232FA98]	; 0232FA3C
	str r2,[r1,#0x18]	; 0232FA3E
	cmp r0,#0x4	; 0232FA40
	bhi loc_0232FA68	; 0232FA42
	add r0,r0,r0	; 0232FA44
P1_SwitchIndexPC_0232FA44:
	add r0,pc	; 0232FA46
	ldrh r0,[r0,#(P1_SwitchTable_0232FA44 - (P1_SwitchIndexPC_0232FA44 + 4))]	; 0232FA48
	lsl r0,r0,#0x10	; 0232FA4A
	asr r0,r0,#0x10	; 0232FA4C
P1_SwitchTargetPC_0232FA44:
	add r0,pc	; 0232FA4E
	bx r0	; 0232FA50
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232FA44:
	.halfword (loc_0232FA68 + 1) - (P1_SwitchTargetPC_0232FA44 + 4)
	.halfword (loc_0232FA5C + 1) - (P1_SwitchTargetPC_0232FA44 + 4)
	.halfword (loc_0232FA60 + 1) - (P1_SwitchTargetPC_0232FA44 + 4)
	.halfword (loc_0232FA64 + 1) - (P1_SwitchTargetPC_0232FA44 + 4)
	.halfword (loc_0232FA68 + 1) - (P1_SwitchTargetPC_0232FA44 + 4)
P1_SwitchTable_0232FA44End:
loc_0232FA5C:
	mov r4,#0x4	; 0232FA5C
	b loc_0232FA6A	; 0232FA5E
loc_0232FA60:
	mov r4,#0x5	; 0232FA60
	b loc_0232FA6A	; 0232FA62
loc_0232FA64:
	mov r4,#0x1	; 0232FA64
	b loc_0232FA6A	; 0232FA66
loc_0232FA68:
	mov r4,#0x6	; 0232FA68
loc_0232FA6A:
	ldr r0,[pool_0232FA98]	; 0232FA6A
	ldr r1,[r0,#0x18]	; 0232FA6C
	cmp r1,#0x0	; 0232FA6E
	bne loc_0232FA8E	; 0232FA70
	ldr r1,[r0,#0x0]	; 0232FA72
	cmp r1,#0x0	; 0232FA74
	beq loc_0232FA7C	; 0232FA76
	mov r1,#0x0	; 0232FA78
	str r1,[r0,#0x0]	; 0232FA7A
loc_0232FA7C:
	ldr r1,[pool_0232FA98]	; 0232FA7C
	ldr r2,[r1,#0x4]	; 0232FA7E
	cmp r2,#0x0	; 0232FA80
	beq loc_0232FA8E	; 0232FA82
	mov r0,#0x0	; 0232FA84
	str r0,[r1,#0x4]	; 0232FA86
	add r0,r4,#0x0	; 0232FA88
	ldr r1,[r1,#0x10]	; 0232FA8A
	blx r2	; 0232FA8C
loc_0232FA8E:
	add sp,#0x4	; 0232FA8E
	pop {r4,r5}	; 0232FA90
	pop {r3}	; 0232FA92
	bx r3	; 0232FA94
	.byte 0xC0, 0x46	; 0232FA98
pool_0232FA98:
loc_0232FA98:
	.word P1_BssStart + 0x2831C	; 0232FA98
pool_0232FA9C:
loc_0232FA9C:
	.word 0x00007F00	; 0232FA9C
pool_0232FAA0:
loc_0232FAA0:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset	; 0232FAA0
pool_0232FAA4:
loc_0232FAA4:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FAA4
pool_0232FAA8:
loc_0232FAA8:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x2	; 0232FAA8

; ===== function loc_0232FAAC =====
loc_0232FAAC:
	push {lr}	; 0232FAAC
	sub sp,#0x4	; 0232FAAE
	ldr r2,[pool_0232FAD0]	; 0232FAB0
	mov r3,#0x0	; 0232FAB2
	bl loc_0232FAD8	; 0232FAB4
	ldr r1,[pool_0232FAD4]	; 0232FAB8
	str r0,[r1,#0x20]	; 0232FABA
	cmp r0,#0x0	; 0232FABC
	bne loc_0232FAC4	; 0232FABE
	blx loc_0232F59C	; 0232FAC0
loc_0232FAC4:
	ldr r0,[pool_0232FAD4]	; 0232FAC4
	ldr r0,[r0,#0x20]	; 0232FAC6
	add sp,#0x4	; 0232FAC8
	pop {r3}	; 0232FACA
	bx r3	; 0232FACC
	.byte 0xC0, 0x46	; 0232FAD0
pool_0232FAD0:
loc_0232FAD0:
	.word 0x0232F5B5	; 0232FAD0
pool_0232FAD4:
loc_0232FAD4:
	.word P1_BssStart + 0x2831C	; 0232FAD4

; ===== function loc_0232FAD8 =====
loc_0232FAD8:
	push {r4,r5,r6,r7,lr}	; 0232FAD8
	sub sp,#0x4	; 0232FADA
	add r5,r0,#0x0	; 0232FADC
	add r7,r1,#0x0	; 0232FADE
	add r4,r2,#0x0	; 0232FAE0
	add r6,r3,#0x0	; 0232FAE2
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FAE4
	ldr r1,[pool_0232FB50]	; 0232FAE8
	ldr r2,[r1,#0x0]	; 0232FAEA
	cmp r2,#0x0	; 0232FAEC
	beq loc_0232FAFE	; 0232FAEE
	blx P1_Arm9RestoreIrqMask	; 0232FAF0
	mov r0,#0x1	; 0232FAF4
	add sp,#0x4	; 0232FAF6
	pop {r4,r5,r6,r7}	; 0232FAF8
	pop {r3}	; 0232FAFA
	bx r3	; 0232FAFC
loc_0232FAFE:
	mov r2,#0x1	; 0232FAFE
	str r2,[r1,#0x0]	; 0232FB00
	blx P1_Arm9RestoreIrqMask	; 0232FB02
	mov r1,#0x0	; 0232FB06
	ldr r0,[pool_0232FB50]	; 0232FB08
	str r1,[r0,#0x18]	; 0232FB0A
	str r4,[r0,#0x4]	; 0232FB0C
	str r6,[r0,#0x10]	; 0232FB0E
	add r0,r7,#0x0	; 0232FB10
	bl loc_0232F694	; 0232FB12
	str r0,[sp,#0x0]	; 0232FB16
	ldr r1,[pool_0232FB54]	; 0232FB18
	str r0,[r1,#0x0]	; 0232FB1A
	cmp r5,#0x0	; 0232FB1C
	bne loc_0232FB2C	; 0232FB1E
	mov r1,#0xb	; 0232FB20
	ldr r0,[pool_0232FB50]	; 0232FB22
	str r1,[r0,#0x14]	; 0232FB24
	bl loc_0232FE58	; 0232FB26
	b loc_0232FB36	; 0232FB2A
loc_0232FB2C:
	mov r1,#0xc	; 0232FB2C
	ldr r0,[pool_0232FB50]	; 0232FB2E
	str r1,[r0,#0x14]	; 0232FB30
	bl loc_0232FE4C	; 0232FB32
loc_0232FB36:
	cmp r0,#0x0	; 0232FB36
	beq loc_0232FB44	; 0232FB38
	mov r0,#0x0	; 0232FB3A
	add sp,#0x4	; 0232FB3C
	pop {r4,r5,r6,r7}	; 0232FB3E
	pop {r3}	; 0232FB40
	bx r3	; 0232FB42
loc_0232FB44:
	mov r0,#0x3	; 0232FB44
	add sp,#0x4	; 0232FB46
	pop {r4,r5,r6,r7}	; 0232FB48
	pop {r3}	; 0232FB4A
	bx r3	; 0232FB4C
	.byte 0xC0, 0x46	; 0232FB50
pool_0232FB50:
loc_0232FB50:
	.word P1_BssStart + 0x2831C	; 0232FB50
pool_0232FB54:
loc_0232FB54:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FB54

; ===== function loc_0232FB58 =====
loc_0232FB58:
	push {lr}	; 0232FB58
	sub sp,#0x4	; 0232FB5A
	ldr r2,[pool_0232FB7C]	; 0232FB5C
	mov r3,#0x0	; 0232FB5E
	bl loc_0232FB84	; 0232FB60
	ldr r1,[pool_0232FB80]	; 0232FB64
	str r0,[r1,#0x20]	; 0232FB66
	cmp r0,#0x0	; 0232FB68
	bne loc_0232FB70	; 0232FB6A
	blx loc_0232F59C	; 0232FB6C
loc_0232FB70:
	ldr r0,[pool_0232FB80]	; 0232FB70
	ldr r0,[r0,#0x20]	; 0232FB72
	add sp,#0x4	; 0232FB74
	pop {r3}	; 0232FB76
	bx r3	; 0232FB78
	.byte 0xC0, 0x46	; 0232FB7C
pool_0232FB7C:
loc_0232FB7C:
	.word 0x0232F5B5	; 0232FB7C
pool_0232FB80:
loc_0232FB80:
	.word P1_BssStart + 0x2831C	; 0232FB80

; ===== function loc_0232FB84 =====
loc_0232FB84:
	push {r4,r5,r6,r7,lr}	; 0232FB84
	sub sp,#0x4	; 0232FB86
	add r5,r0,#0x0	; 0232FB88
	add r4,r1,#0x0	; 0232FB8A
	add r6,r2,#0x0	; 0232FB8C
	add r7,r3,#0x0	; 0232FB8E
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FB90
	ldr r1,[pool_0232FBEC]	; 0232FB94
	ldr r2,[r1,#0x0]	; 0232FB96
	cmp r2,#0x0	; 0232FB98
	beq loc_0232FBAA	; 0232FB9A
	blx P1_Arm9RestoreIrqMask	; 0232FB9C
	mov r0,#0x1	; 0232FBA0
	add sp,#0x4	; 0232FBA2
	pop {r4,r5,r6,r7}	; 0232FBA4
	pop {r3}	; 0232FBA6
	bx r3	; 0232FBA8
loc_0232FBAA:
	mov r2,#0x1	; 0232FBAA
	str r2,[r1,#0x0]	; 0232FBAC
	blx P1_Arm9RestoreIrqMask	; 0232FBAE
	cmp r5,#0x0	; 0232FBB2
	bne loc_0232FBBE	; 0232FBB4
	mov r1,#0x9	; 0232FBB6
	ldr r0,[pool_0232FBEC]	; 0232FBB8
	str r1,[r0,#0x14]	; 0232FBBA
	b loc_0232FBC4	; 0232FBBC
loc_0232FBBE:
	mov r1,#0xa	; 0232FBBE
	ldr r0,[pool_0232FBEC]	; 0232FBC0
	str r1,[r0,#0x14]	; 0232FBC2
loc_0232FBC4:
	mov r1,#0x0	; 0232FBC4
	ldr r0,[pool_0232FBEC]	; 0232FBC6
	str r1,[r0,#0x18]	; 0232FBC8
	str r4,[r0,#0x8]	; 0232FBCA
	str r6,[r0,#0x4]	; 0232FBCC
	str r7,[r0,#0x10]	; 0232FBCE
	bl loc_0232FE40	; 0232FBD0
	cmp r0,#0x0	; 0232FBD4
	beq loc_0232FBE2	; 0232FBD6
	mov r0,#0x0	; 0232FBD8
	add sp,#0x4	; 0232FBDA
	pop {r4,r5,r6,r7}	; 0232FBDC
	pop {r3}	; 0232FBDE
	bx r3	; 0232FBE0
loc_0232FBE2:
	mov r0,#0x3	; 0232FBE2
	add sp,#0x4	; 0232FBE4
	pop {r4,r5,r6,r7}	; 0232FBE6
	pop {r3}	; 0232FBE8
	bx r3	; 0232FBEA
pool_0232FBEC:
loc_0232FBEC:
	.word P1_BssStart + 0x2831C	; 0232FBEC

; ===== function loc_0232FBF0 =====
loc_0232FBF0:
	ldr r1,[pool_0232FBF8]	; 0232FBF0
	str r0,[r1,#0x1c]	; 0232FBF2
	bx lr	; 0232FBF4
	.byte 0xC0, 0x46	; 0232FBF8
pool_0232FBF8:
loc_0232FBF8:
	.word P1_BssStart + 0x2831C	; 0232FBF8

; ===== function loc_0232FBFC =====
loc_0232FBFC:
	push {lr}	; 0232FBFC
	sub sp,#0x4	; 0232FBFE
	ldr r1,[pool_0232FC20]	; 0232FC00
	mov r2,#0x0	; 0232FC02
	bl loc_0232FC28	; 0232FC04
	ldr r1,[pool_0232FC24]	; 0232FC08
	str r0,[r1,#0x20]	; 0232FC0A
	cmp r0,#0x0	; 0232FC0C
	bne loc_0232FC14	; 0232FC0E
	blx loc_0232F59C	; 0232FC10
loc_0232FC14:
	ldr r0,[pool_0232FC24]	; 0232FC14
	ldr r0,[r0,#0x20]	; 0232FC16
	add sp,#0x4	; 0232FC18
	pop {r3}	; 0232FC1A
	bx r3	; 0232FC1C
	.byte 0xC0, 0x46	; 0232FC20
pool_0232FC20:
loc_0232FC20:
	.word 0x0232F5B5	; 0232FC20
pool_0232FC24:
loc_0232FC24:
	.word P1_BssStart + 0x2831C	; 0232FC24

; ===== function loc_0232FC28 =====
loc_0232FC28:
	push {r4,r5,lr}	; 0232FC28
	sub sp,#0x4	; 0232FC2A
	add r5,r1,#0x0	; 0232FC2C
	add r4,r2,#0x0	; 0232FC2E
	ldrb r1,[r0,#0x0]	; 0232FC30
	ldr r0,[pool_0232FC84]	; 0232FC32
	strb r1,[r0,#0x0]	; 0232FC34
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FC36
	ldr r1,[pool_0232FC88]	; 0232FC3A
	ldr r2,[r1,#0x0]	; 0232FC3C
	cmp r2,#0x0	; 0232FC3E
	beq loc_0232FC50	; 0232FC40
	blx P1_Arm9RestoreIrqMask	; 0232FC42
	mov r0,#0x1	; 0232FC46
	add sp,#0x4	; 0232FC48
	pop {r4,r5}	; 0232FC4A
	pop {r3}	; 0232FC4C
	bx r3	; 0232FC4E
loc_0232FC50:
	mov r2,#0x1	; 0232FC50
	str r2,[r1,#0x0]	; 0232FC52
	blx P1_Arm9RestoreIrqMask	; 0232FC54
	mov r1,#0xf	; 0232FC58
	ldr r0,[pool_0232FC88]	; 0232FC5A
	str r1,[r0,#0x14]	; 0232FC5C
	mov r1,#0x0	; 0232FC5E
	str r1,[r0,#0x18]	; 0232FC60
	str r5,[r0,#0x4]	; 0232FC62
	str r4,[r0,#0x10]	; 0232FC64
	bl loc_0232FE28	; 0232FC66
	cmp r0,#0x0	; 0232FC6A
	beq loc_0232FC78	; 0232FC6C
	mov r0,#0x0	; 0232FC6E
	add sp,#0x4	; 0232FC70
	pop {r4,r5}	; 0232FC72
	pop {r3}	; 0232FC74
	bx r3	; 0232FC76
loc_0232FC78:
	mov r0,#0x3	; 0232FC78
	add sp,#0x4	; 0232FC7A
	pop {r4,r5}	; 0232FC7C
	pop {r3}	; 0232FC7E
	bx r3	; 0232FC80
	.byte 0xC0, 0x46	; 0232FC84
pool_0232FC84:
loc_0232FC84:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FC84
pool_0232FC88:
loc_0232FC88:
	.word P1_BssStart + 0x2831C	; 0232FC88

; ===== function loc_0232FC8C =====
P1_Entry_0232FC8C:
	push {lr}	; 0232FC8C
	sub sp,#0x4	; 0232FC8E
	ldr r2,[pool_0232FCB0]	; 0232FC90
	mov r3,#0x0	; 0232FC92
	bl loc_0232FCB8	; 0232FC94
	ldr r1,[pool_0232FCB4]	; 0232FC98
	str r0,[r1,#0x20]	; 0232FC9A
	cmp r0,#0x0	; 0232FC9C
	bne loc_0232FCA4	; 0232FC9E
	blx loc_0232F59C	; 0232FCA0
loc_0232FCA4:
	ldr r0,[pool_0232FCB4]	; 0232FCA4
	ldr r0,[r0,#0x20]	; 0232FCA6
	add sp,#0x4	; 0232FCA8
	pop {r3}	; 0232FCAA
	bx r3	; 0232FCAC
	.byte 0xC0, 0x46	; 0232FCB0
pool_0232FCB0:
loc_0232FCB0:
	.word 0x0232F5B5	; 0232FCB0
pool_0232FCB4:
loc_0232FCB4:
	.word P1_BssStart + 0x2831C	; 0232FCB4

; ===== function loc_0232FCB8 =====
loc_0232FCB8:
	push {r4,r5,r6,lr}	; 0232FCB8
	add r6,r1,#0x0	; 0232FCBA
	add r5,r2,#0x0	; 0232FCBC
	add r4,r3,#0x0	; 0232FCBE
	ldr r1,[pool_0232FD14]	; 0232FCC0
	bl loc_0232F630	; 0232FCC2
	add r0,r6,#0x0	; 0232FCC6
	ldr r1,[pool_0232FD18]	; 0232FCC8
	bl loc_0232F5C0	; 0232FCCA
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FCCE
	ldr r1,[pool_0232FD1C]	; 0232FCD2
	ldr r2,[r1,#0x0]	; 0232FCD4
	cmp r2,#0x0	; 0232FCD6
	beq loc_0232FCE6	; 0232FCD8
	blx P1_Arm9RestoreIrqMask	; 0232FCDA
	mov r0,#0x1	; 0232FCDE
	pop {r4,r5,r6}	; 0232FCE0
	pop {r3}	; 0232FCE2
	bx r3	; 0232FCE4
loc_0232FCE6:
	mov r2,#0x1	; 0232FCE6
	str r2,[r1,#0x0]	; 0232FCE8
	blx P1_Arm9RestoreIrqMask	; 0232FCEA
	mov r1,#0x5	; 0232FCEE
	ldr r0,[pool_0232FD1C]	; 0232FCF0
	str r1,[r0,#0x14]	; 0232FCF2
	mov r1,#0x0	; 0232FCF4
	str r1,[r0,#0x18]	; 0232FCF6
	str r5,[r0,#0x4]	; 0232FCF8
	str r4,[r0,#0x10]	; 0232FCFA
	bl loc_0232FE64	; 0232FCFC
	cmp r0,#0x0	; 0232FD00
	beq loc_0232FD0C	; 0232FD02
	mov r0,#0x0	; 0232FD04
	pop {r4,r5,r6}	; 0232FD06
	pop {r3}	; 0232FD08
	bx r3	; 0232FD0A
loc_0232FD0C:
	mov r0,#0x3	; 0232FD0C
	pop {r4,r5,r6}	; 0232FD0E
	pop {r3}	; 0232FD10
	bx r3	; 0232FD12
pool_0232FD14:
loc_0232FD14:
	.word 0x027FFDE8	; 0232FD14
pool_0232FD18:
loc_0232FD18:
	.word 0x027FFDEC	; 0232FD18
pool_0232FD1C:
loc_0232FD1C:
	.word P1_BssStart + 0x2831C	; 0232FD1C

; ===== function loc_0232FD20 =====
loc_0232FD20:
	push {lr}	; 0232FD20
	sub sp,#0x4	; 0232FD22
	ldr r2,[pool_0232FD44]	; 0232FD24
	mov r3,#0x0	; 0232FD26
	bl loc_0232FD4C	; 0232FD28
	ldr r1,[pool_0232FD48]	; 0232FD2C
	str r0,[r1,#0x20]	; 0232FD2E
	cmp r0,#0x0	; 0232FD30
	bne loc_0232FD38	; 0232FD32
	blx loc_0232F59C	; 0232FD34
loc_0232FD38:
	ldr r0,[pool_0232FD48]	; 0232FD38
	ldr r0,[r0,#0x20]	; 0232FD3A
	add sp,#0x4	; 0232FD3C
	pop {r3}	; 0232FD3E
	bx r3	; 0232FD40
	.byte 0xC0, 0x46	; 0232FD44
pool_0232FD44:
loc_0232FD44:
	.word 0x0232F5B5	; 0232FD44
pool_0232FD48:
loc_0232FD48:
	.word P1_BssStart + 0x2831C	; 0232FD48

; ===== function loc_0232FD4C =====
loc_0232FD4C:
	push {r4,r5,r6,r7,lr}	; 0232FD4C
	sub sp,#0x4	; 0232FD4E
	add r5,r0,#0x0	; 0232FD50
	add r4,r1,#0x0	; 0232FD52
	add r6,r2,#0x0	; 0232FD54
	add r7,r3,#0x0	; 0232FD56
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FD58
	ldr r1,[pool_0232FDA8]	; 0232FD5C
	ldr r2,[r1,#0x0]	; 0232FD5E
	cmp r2,#0x0	; 0232FD60
	beq loc_0232FD72	; 0232FD62
	blx P1_Arm9RestoreIrqMask	; 0232FD64
	mov r0,#0x1	; 0232FD68
	add sp,#0x4	; 0232FD6A
	pop {r4,r5,r6,r7}	; 0232FD6C
	pop {r3}	; 0232FD6E
	bx r3	; 0232FD70
loc_0232FD72:
	mov r2,#0x1	; 0232FD72
	str r2,[r1,#0x0]	; 0232FD74
	blx P1_Arm9RestoreIrqMask	; 0232FD76
	mov r1,#0x2	; 0232FD7A
	ldr r0,[pool_0232FDA8]	; 0232FD7C
	str r1,[r0,#0x14]	; 0232FD7E
	mov r1,#0x0	; 0232FD80
	str r1,[r0,#0x18]	; 0232FD82
	str r5,[r0,#0x8]	; 0232FD84
	str r4,[r0,#0xc]	; 0232FD86
	str r6,[r0,#0x4]	; 0232FD88
	str r7,[r0,#0x10]	; 0232FD8A
	bl loc_0232FE70	; 0232FD8C
	cmp r0,#0x0	; 0232FD90
	beq loc_0232FD9E	; 0232FD92
	mov r0,#0x0	; 0232FD94
	add sp,#0x4	; 0232FD96
	pop {r4,r5,r6,r7}	; 0232FD98
	pop {r3}	; 0232FD9A
	bx r3	; 0232FD9C
loc_0232FD9E:
	mov r0,#0x3	; 0232FD9E
	add sp,#0x4	; 0232FDA0
	pop {r4,r5,r6,r7}	; 0232FDA2
	pop {r3}	; 0232FDA4
	bx r3	; 0232FDA6
pool_0232FDA8:
loc_0232FDA8:
	.word P1_BssStart + 0x2831C	; 0232FDA8

; ===== function loc_0232FDAC =====
loc_0232FDAC:
	push {r4,r5,lr}	; 0232FDAC
	sub sp,#0x4	; 0232FDAE
	ldr r0,[pool_0232FDF0]	; 0232FDB0
	ldrh r1,[r0,#0x0]	; 0232FDB2
	cmp r1,#0x0	; 0232FDB4
	bne loc_0232FDE6	; 0232FDB6
	mov r1,#0x1	; 0232FDB8
	strh r1,[r0,#0x0]	; 0232FDBA
	mov r1,#0x0	; 0232FDBC
	ldr r0,[pool_0232FDF4]	; 0232FDBE
	str r1,[r0,#0x0]	; 0232FDC0
	str r1,[r0,#0x4]	; 0232FDC2
	str r1,[r0,#0x1c]	; 0232FDC4
	str r1,[r0,#0x8]	; 0232FDC6
	str r1,[r0,#0xc]	; 0232FDC8
	bl loc_0232E7E4	; 0232FDCA
	mov r5,#0x5	; 0232FDCE
	mov r4,#0x1	; 0232FDD0
loc_0232FDD2:
	add r0,r5,#0x0	; 0232FDD2
	add r1,r4,#0x0	; 0232FDD4
	bl loc_0232E958	; 0232FDD6
	cmp r0,#0x0	; 0232FDDA
	beq loc_0232FDD2	; 0232FDDC
	mov r0,#0x5	; 0232FDDE
	ldr r1,[pool_0232FDF8]	; 0232FDE0
	bl P1_SetPxiReceiveCallback	; 0232FDE2
loc_0232FDE6:
	add sp,#0x4	; 0232FDE6
	pop {r4,r5}	; 0232FDE8
	pop {r3}	; 0232FDEA
	bx r3	; 0232FDEC
	.byte 0xC0, 0x46	; 0232FDF0
pool_0232FDF0:
loc_0232FDF0:
	.word P1_BssStart + 0x28318	; 0232FDF0
pool_0232FDF4:
loc_0232FDF4:
	.word P1_BssStart + 0x2831C	; 0232FDF4
pool_0232FDF8:
loc_0232FDF8:
	.word P1_PxiCallback_0232F7C4 + 1	; 0232FDF8
loc_0232FDFC:
	push {lr}	; 0232FDFC
	sub sp,#0x4	; 0232FDFE
	add r1,r0,#0x0	; 0232FE00
	mov r0,#0x5	; 0232FE02
	lsl r1,r1,#0x8	; 0232FE04
	ldr r2,[pool_0232FE24]	; 0232FE06
	and r1,r2	; 0232FE08
	mov r2,#0x0	; 0232FE0A
	bl loc_0232E8C4	; 0232FE0C
	cmp r0,#0x0	; 0232FE10
	blt loc_0232FE1C	; 0232FE12
	mov r0,#0x1	; 0232FE14
	add sp,#0x4	; 0232FE16
	pop {r3}	; 0232FE18
	bx r3	; 0232FE1A
loc_0232FE1C:
	mov r0,#0x0	; 0232FE1C
	add sp,#0x4	; 0232FE1E
	pop {r3}	; 0232FE20
	bx r3	; 0232FE22
pool_0232FE24:
loc_0232FE24:
	.word 0x00007F00	; 0232FE24

; ===== function loc_0232FE28 =====
loc_0232FE28:
	mov r0,#0x28	; 0232FE28
	ldr r3,[pool_0232FE30]	; 0232FE2A
	bx r3	; 0232FE2C
	.byte 0xC0, 0x46	; 0232FE30
pool_0232FE30:
loc_0232FE30:
	.word loc_0232FDFC + 1	; 0232FE30

; ===== function loc_0232FE34 =====
loc_0232FE34:
	mov r0,#0x27	; 0232FE34
	ldr r3,[pool_0232FE3C]	; 0232FE36
	bx r3	; 0232FE38
	.byte 0xC0, 0x46	; 0232FE3C
pool_0232FE3C:
loc_0232FE3C:
	.word loc_0232FDFC + 1	; 0232FE3C

; ===== function loc_0232FE40 =====
loc_0232FE40:
	mov r0,#0x17	; 0232FE40
	ldr r3,[pool_0232FE48]	; 0232FE42
	bx r3	; 0232FE44
	.byte 0xC0, 0x46	; 0232FE48
pool_0232FE48:
loc_0232FE48:
	.word loc_0232FDFC + 1	; 0232FE48

; ===== function loc_0232FE4C =====
loc_0232FE4C:
	mov r0,#0x25	; 0232FE4C
	ldr r3,[pool_0232FE54]	; 0232FE4E
	bx r3	; 0232FE50
	.byte 0xC0, 0x46	; 0232FE54
pool_0232FE54:
loc_0232FE54:
	.word loc_0232FDFC + 1	; 0232FE54

; ===== function loc_0232FE58 =====
loc_0232FE58:
	mov r0,#0x24	; 0232FE58
	ldr r3,[pool_0232FE60]	; 0232FE5A
	bx r3	; 0232FE5C
	.byte 0xC0, 0x46	; 0232FE60
pool_0232FE60:
loc_0232FE60:
	.word loc_0232FDFC + 1	; 0232FE60

; ===== function loc_0232FE64 =====
loc_0232FE64:
	mov r0,#0x20	; 0232FE64
	ldr r3,[pool_0232FE6C]	; 0232FE66
	bx r3	; 0232FE68
	.byte 0xC0, 0x46	; 0232FE6C
pool_0232FE6C:
loc_0232FE6C:
	.word loc_0232FDFC + 1	; 0232FE6C

; ===== function loc_0232FE70 =====
loc_0232FE70:
	mov r0,#0x10	; 0232FE70
	ldr r3,[pool_0232FE78]	; 0232FE72
	bx r3	; 0232FE74
	.byte 0xC0, 0x46	; 0232FE78
pool_0232FE78:
loc_0232FE78:
	.word loc_0232FDFC + 1	; 0232FE78
	.byte 0xE9, 0xD1, 0x32, 0x02, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00, 0x0D, 0x3E, 0x36, 0x02	; 0232FE8C
	.byte 0xA9, 0x78, 0x36, 0x02, 0xC1, 0x8D, 0x35, 0x02	; 0232FE8C
P1_Data_0232FE94:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FE94
P1_Data_0232FE9C:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FE9C
P1_Data_0232FEA4:
	.byte 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 0232FEA4
	.byte 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x05, 0x00, 0x04, 0x00	; 0232FEBC
	.byte 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x05, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00	; 0232FECC
	.byte 0x05, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00	; 0232FECC
P1_Data_0232FED4:
	.byte 0x09, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00	; 0232FED4
	.byte 0x0B, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00	; 0232FEDC
P1_Data_0232FEE4:
	.byte 0x05, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00	; 0232FEE4
	.byte 0x04, 0x00, 0x00, 0x00, 0x06, 0x00, 0x07, 0x00, 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00	; 0232FEFC
	.byte 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00	; 0232FF0C
	.byte 0x00, 0x00, 0x54, 0x00, 0x06, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00	; 0232FF1C
	.byte 0x00, 0x00, 0x30, 0x00, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 0232FF2C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x34, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00	; 0232FF3C
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0232FF4C
	.byte 0x00, 0x00, 0xD0, 0xFF, 0x03, 0x00, 0x00, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FF5C
	.byte 0x00, 0x70, 0x07, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x08, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0232FF6C
	.byte 0x00, 0x80, 0x08, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x07, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 0232FF7C
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x07, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x07, 0x00	; 0232FF8C
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x0A, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x0A, 0x00	; 0232FF9C
	.byte 0x00, 0x60, 0x08, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x04, 0x00	; 0232FFAC
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x08, 0x00, 0x00, 0x10, 0x07, 0x00	; 0232FFBC
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x07, 0x00, 0x00, 0xE0, 0x04, 0x00	; 0232FFCC
	.byte 0x00, 0x90, 0x07, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x07, 0x00	; 0232FFDC
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x01, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x01, 0x00	; 0232FFEC
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x04, 0x00	; 0232FFFC
	.byte 0x00, 0x80, 0x0E, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x90, 0x0F, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0233000C
	.byte 0x00, 0x90, 0x0F, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x80, 0x0E, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 0233001C
	.byte 0x00, 0x70, 0x00, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0233002C
	.byte 0x00, 0x80, 0x01, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 0233003C
	.byte 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00	; 0233004C
P1_Data_0233004C:
	.byte 0x0A, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00	; 0233004C
	.byte 0x06, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 0233006C
	.byte 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0233006C
P1_Data_02330074:
	.byte 0x00, 0x00	; 02330074
P1_Data_02330076:
	.byte 0x95, 0x00	; 02330076
P1_Data_02330078:
	.byte 0x7F, 0x00, 0x00, 0x00	; 02330078
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x02, 0x00, 0x8A, 0x00, 0x74, 0x00, 0x0E, 0x00, 0x01, 0x00	; 0233008C
	.byte 0x00, 0x00, 0x06, 0x00, 0x02, 0x00, 0x91, 0x00, 0x7B, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x00, 0x00	; 0233009C
	.byte 0x09, 0x00, 0x02, 0x00, 0x86, 0x00, 0x70, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00	; 023300AC
	.byte 0x02, 0x00, 0x8F, 0x00, 0x79, 0x00, 0x0E, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00	; 023300BC
	.byte 0x8B, 0x00, 0x75, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x05, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8D, 0x00	; 023300CC
	.byte 0x77, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x06, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8C, 0x00, 0x76, 0x00	; 023300DC
	.byte 0x0E, 0x00, 0x01, 0x00, 0x07, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8E, 0x00, 0x78, 0x00, 0x0E, 0x00	; 023300EC
	.byte 0x01, 0x00, 0x08, 0x00, 0x06, 0x00, 0x03, 0x00, 0x92, 0x00, 0x7C, 0x00, 0x0E, 0x00, 0x02, 0x00	; 023300FC
	.byte 0x09, 0x00, 0x09, 0x00, 0x03, 0x00, 0x93, 0x00, 0x7D, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0A, 0x00	; 0233010C
	.byte 0x09, 0x00, 0x03, 0x00, 0x94, 0x00, 0x7E, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0B, 0x00, 0x09, 0x00	; 0233011C
	.byte 0x03, 0x00, 0x88, 0x00, 0x72, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x03, 0x00	; 0233012C
	.byte 0x89, 0x00, 0x73, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x0D, 0x00, 0x0C, 0x00, 0x01, 0x00, 0x90, 0x00	; 0233013C
	.byte 0x7A, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x85, 0x00, 0x6F, 0x00	; 0233014C
	.byte 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x03, 0x00, 0x87, 0x00, 0x71, 0x00, 0x0E, 0x00	; 0233015C
	.byte 0x03, 0x00, 0x10, 0x00, 0x0C, 0x00, 0x02, 0x00, 0x85, 0x00, 0x6F, 0x00, 0x0F, 0x00, 0x11, 0x00	; 0233016C
	.byte 0x00, 0x00, 0xFF, 0xFF	; 0233016C
P1_Data_02330170:
	.byte 0x00, 0x00, 0x60, 0x00	; 02330170
P1_Data_02330174:
	.byte 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00	; 02330174
P1_Data_0233017C:
	.byte 0x03, 0x00, 0x24, 0x00	; 0233017C
P1_Data_02330180:
	.byte 0x01, 0x00	; 02330180
P1_Data_02330182:
	.byte 0x01, 0x00, 0x02, 0x00, 0x2B, 0x00, 0x00, 0x00, 0x02, 0x00	; 02330182
P1_Data_0233018C:
	.byte 0x30, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00	; 0233018C
	.byte 0x38, 0x00, 0x39, 0x00, 0x00, 0x00, 0x00, 0x00	; 0233019C
P1_Data_023301A4:
	.byte 0x03, 0x03, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00	; 023301A4
	.byte 0xFF, 0x0F, 0xFF, 0x0F, 0xC7, 0x01, 0x00, 0x00, 0x31, 0x86, 0x32, 0x02, 0x2D, 0x86, 0x32, 0x02	; 023301BC
	.byte 0x29, 0x86, 0x32, 0x02, 0x00, 0x00, 0x00, 0x00, 0x25, 0x86, 0x32, 0x02, 0x24, 0xD4, 0x00, 0x00	; 023301CC
	.byte 0x0F, 0x40, 0x00, 0x00, 0x00, 0x01, 0x81, 0x82, 0x82, 0x83, 0x0F, 0x83, 0x0C, 0xC3, 0x03, 0x83	; 023301DC
	.byte 0x01, 0x83, 0x04, 0xC3, 0x08, 0x0E, 0x02, 0xC2, 0x0D, 0xC2, 0x07, 0x0B, 0x06, 0x0A, 0x05, 0x09	; 023301EC
.arm
	b loc_02330268	; 023301EC
	.byte 0x00, 0x40, 0x2D, 0xE9, 0x68, 0x30, 0x9F, 0xE5, 0x10, 0x00, 0x93, 0xE5, 0x20, 0x10, 0x93, 0xE5	; 02330200
	.byte 0x18, 0x10, 0x80, 0xE5, 0x14, 0x00, 0x93, 0xE5, 0x28, 0x10, 0x90, 0xE5, 0x01, 0x12, 0x81, 0xE3	; 02330210
	.byte 0x28, 0x10, 0x80, 0xE5, 0x44, 0x10, 0x9F, 0xE5, 0xFC, 0x10, 0x80, 0xE5, 0x28, 0x20, 0xA0, 0xE3	; 02330220
	.byte 0x3C, 0x10, 0x80, 0xE2, 0x0C, 0x00, 0x8F, 0xE2, 0x08, 0x30, 0x93, 0xE5, 0x33, 0xFF, 0x2F, 0xE1	; 02330230
	.byte 0x00, 0x40, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1, 0x00, 0x50, 0xA0, 0xE3, 0x00, 0xC0, 0x97, 0xE5	; 02330240
	.byte 0x66, 0x00, 0x5C, 0xE3, 0xEA, 0x40, 0xA0, 0x03, 0x29, 0x40, 0x4F, 0x05, 0x15, 0x5F, 0x07, 0x0E	; 02330250
	.byte 0x07, 0xC0, 0x0C, 0xE2, 0x00, 0x30, 0x9F, 0xE5, 0x02, 0x00, 0x00, 0xEA, 0x00, 0x52, 0x00, 0x02	; 02330260
	.byte 0xFE, 0xFF, 0xFF, 0xEA, 0x8C, 0x52, 0x00, 0x02	; 02330268
loc_02330268:
	stmdb sp!,{r4,r7,lr}	; 02330268
	ldr r7,[pool_023302E0]	; 0233026C
	cmp r0,#0x0	; 02330270
	bne loc_023302D0	; 02330274
	ldr r0,[r7,#0x1c]	; 02330278
	ldr r1,[pool_023302E4]	; 0233027C
	mov r2,#0x40	; 02330280
	ldr r4,[r7,#0x8]	; 02330284
	blx r4	; 02330288
	mov r1,#0x40	; 0233028C
	str r1,[sp,#-0x4]!	; 02330290
	ldr r0,[pool_023302E8]	; 02330294
	mov r1,r6	; 02330298
	mov r2,r5	; 0233029C
	ldr r3,[pool_023302E4]	; 023302A0
	ldr r4,[r7,#0xc]	; 023302A4
	blx r4	; 023302A8
	add sp,sp,#0x4	; 023302AC
	ldr r0,[pool_023302E8]	; 023302B0
	sub r1,r7,#0x28	; 023302B4
	mov r2,#0x14	; 023302B8
	ldr r4,[r7,#0x18]	; 023302BC
	blx r4	; 023302C0
	cmp r0,#0x0	; 023302C4
	ldrne r4,[r7,#0x0]	; 023302C8
	blxne r4	; 023302CC
loc_023302D0:
	ldr r4,[r7,#0x4]	; 023302D0
	blx r4	; 023302D4
	ldmia sp!,{r4,r7,lr}	; 023302D8
	bx lr	; 023302DC
pool_023302E0:
loc_023302E0:
	.word 0x0200528C	; 023302E0
pool_023302E4:
loc_023302E4:
	.word 0x02005114	; 023302E4
pool_023302E8:
loc_023302E8:
	.word 0x02005100	; 023302E8
	.byte 0x8A, 0xE8, 0xA7, 0xC0, 0xA0, 0x85, 0x06, 0x81, 0x0D, 0x5F, 0x93, 0xBB, 0x74, 0x28, 0x62, 0xAB	; 023302FC
	.byte 0x99, 0xA8, 0x19, 0x6D, 0xEB, 0x0E, 0x4A, 0xA4, 0x94, 0xFF, 0xF0, 0x94, 0x71, 0x1A, 0xE1, 0xA3	; 0233030C
	.byte 0x1D, 0x90, 0x22, 0xA0, 0x8D, 0x79, 0xE5, 0x31, 0x85, 0x27, 0xF6, 0x31, 0x5B, 0xD0, 0xC0, 0xC5	; 0233031C
	.byte 0x21, 0x8C, 0x79, 0x7C, 0x14, 0x3B, 0x14, 0xE8, 0x07, 0x98, 0x32, 0xB8, 0x79, 0x49, 0xC6, 0x09	; 0233032C
	.byte 0xEE, 0xB5, 0x64, 0x4F, 0x42, 0xFA, 0x34, 0x00, 0x6D, 0x3D, 0x58, 0xD4, 0xA0, 0x2B, 0x45, 0xB4	; 0233033C
	.byte 0x09, 0xD8, 0xF5, 0x25, 0x9C, 0x89, 0xB7, 0x0C, 0x5A, 0x5D, 0x7A, 0x19, 0xD0, 0x21, 0x6B, 0x6B	; 0233034C
	.byte 0xF9, 0xBE, 0xEB, 0x67, 0x71, 0x05, 0x5F, 0xBE, 0xA5, 0x27, 0x47, 0x3C, 0xF7, 0x8C, 0xFB, 0xD2	; 0233035C
	.byte 0x90, 0x35, 0xBB, 0x30, 0x64, 0x28, 0xBD, 0xF7, 0x8C, 0x81, 0x31, 0x98, 0xA3, 0x3E, 0x3B, 0xC7	; 0233036C
	.byte 0x9B, 0x98, 0x2C, 0x23, 0x65, 0x05, 0x37, 0xC8, 0x17, 0xD1, 0x1B, 0x22, 0xEC, 0x95, 0x01, 0x02	; 0233037C
	.byte 0xA4, 0x82, 0x05, 0x02, 0xA4, 0x8B, 0x05, 0x02, 0x08, 0xC6, 0x05, 0x02, 0x10, 0xC1, 0x05, 0x02	; 0233038C
	.byte 0xD8, 0xC2, 0x05, 0x02, 0x38, 0xC7, 0x06, 0x02, 0xEC, 0x49, 0x08, 0x02, 0xB4, 0xA3, 0xFE, 0xEB	; 0233039C
	.byte 0x84, 0x01, 0x00, 0xEA, 0xEC, 0x49, 0x00, 0x02, 0x9E, 0x11, 0x7F, 0xD6, 0x1D, 0x1A, 0xE6, 0xED	; 023303AC
	.byte 0xC5, 0xD6, 0x55, 0xC6, 0x35, 0x4E, 0x06, 0x76, 0x7B, 0x1C, 0x7C, 0x83, 0x35, 0xF2, 0x43, 0x1B	; 023303BC
	.byte 0x69, 0xFE, 0x8E, 0x59, 0xFD, 0xD5, 0x0C, 0x75, 0x59, 0x0D, 0x9C, 0x9E, 0x09, 0x95, 0xB6, 0xA7	; 023303CC
	.byte 0x92, 0xA7, 0xB9, 0x90, 0x38, 0xF7, 0x63, 0xB9, 0xF7, 0x27, 0xB5, 0xE2, 0x64, 0xF4, 0x1E, 0x67	; 023303DC
	.byte 0x30, 0x15, 0x2B, 0xD7, 0xF1, 0x9A, 0xC8, 0xAC, 0x5F, 0x7C, 0x36, 0x03, 0x94, 0x65, 0x73, 0x15	; 023303EC
	.byte 0xA3, 0xD8, 0x66, 0xED, 0x42, 0xB0, 0xD3, 0x19, 0x04, 0x54, 0x11, 0x58, 0xCC, 0x19, 0x46, 0xA8	; 023303FC
	.byte 0xE4, 0xAC, 0x6D, 0xD3, 0xD6, 0x59, 0xF2, 0x3E, 0xF8, 0x49, 0x50, 0xE9, 0x29, 0x15, 0xDC, 0xE1	; 0233040C
	.byte 0xA5, 0xDE, 0x59, 0x01, 0x17, 0xFF, 0xA3, 0x35, 0x63, 0x27, 0x56, 0xC1, 0x5D, 0x36, 0x9A, 0x18	; 0233041C
	.byte 0x89, 0xE2, 0xB3, 0x93, 0xA8, 0x8B, 0x1E, 0xE8, 0x6A, 0x0D, 0x57, 0x65, 0xD0, 0x8A, 0xFB, 0xEB	; 0233042C
	.byte 0x50, 0x1D, 0x04, 0x6D, 0x78, 0x95, 0x01, 0x02, 0x90, 0x7D, 0x05, 0x02, 0x90, 0x86, 0x05, 0x02	; 0233043C
	.byte 0xF4, 0xC0, 0x05, 0x02, 0xFC, 0xBB, 0x05, 0x02, 0xC4, 0xBD, 0x05, 0x02, 0xE4, 0xC1, 0x06, 0x02	; 0233044C
	.byte 0x48, 0x44, 0x08, 0x02, 0xF9, 0xA4, 0xFE, 0xEB, 0x84, 0x01, 0x00, 0xEA, 0xEC, 0x49, 0x00, 0x02	; 0233045C
; ASCII VIB build identifier with the embedded build date. / 含内嵌构建日期的 ASCII VIB 构建标识。
P1_VibBuildIdentifier:
	.ascii "VIB2.11May 26 2005", 0
	.byte 0x00	; 0233046F
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P1_CrtDataInitTable:
	.word P1_CopyDescriptors, P1_CopyDescriptorsEnd
	.word P1_ItcmLoadStart
	.word P1_BssStart, P3_FirmwareUiEntry
	.byte 0x2D, 0xFD, 0x5B, 0xFE, 0x97, 0xFE, 0xBB, 0xFE, 0xD4, 0xFE, 0xE7, 0xFE, 0xF7, 0xFE, 0x04, 0xFF	; 02330484
	.byte 0x10, 0xFF, 0x1A, 0xFF, 0x23, 0xFF, 0x2C, 0xFF, 0x33, 0xFF, 0x3A, 0xFF, 0x40, 0xFF, 0x46, 0xFF	; 02330494
	.byte 0x4C, 0xFF, 0x51, 0xFF, 0x56, 0xFF, 0x5B, 0xFF, 0x5F, 0xFF, 0x64, 0xFF, 0x68, 0xFF, 0x6C, 0xFF	; 023304A4
	.byte 0x6F, 0xFF, 0x73, 0xFF, 0x76, 0xFF, 0x7A, 0xFF, 0x7D, 0xFF, 0x80, 0xFF, 0x83, 0xFF, 0x86, 0xFF	; 023304B4
	.byte 0x88, 0xFF, 0x8B, 0xFF, 0x8E, 0xFF, 0x90, 0xFF, 0x92, 0xFF, 0x95, 0xFF, 0x97, 0xFF, 0x99, 0xFF	; 023304C4
	.byte 0x9C, 0xFF, 0x9E, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA4, 0xFF, 0xA6, 0xFF, 0xA8, 0xFF, 0xAA, 0xFF	; 023304D4
	.byte 0xAB, 0xFF, 0xAD, 0xFF, 0xAF, 0xFF, 0xB1, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB7, 0xFF	; 023304E4
	.byte 0xB9, 0xFF, 0xBA, 0xFF, 0xBC, 0xFF, 0xBD, 0xFF, 0xBF, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC3, 0xFF	; 023304F4
	.byte 0xC4, 0xFF, 0xC6, 0xFF, 0xC7, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF, 0xCB, 0xFF, 0xCC, 0xFF, 0xCD, 0xFF	; 02330504
	.byte 0xCF, 0xFF, 0xD0, 0xFF, 0xD1, 0xFF, 0xD2, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD7, 0xFF	; 02330514
	.byte 0xD8, 0xFF, 0xD9, 0xFF, 0xDA, 0xFF, 0xDB, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDE, 0xFF, 0xDF, 0xFF	; 02330524
	.byte 0xE0, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE3, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF, 0xE6, 0xFF, 0xE7, 0xFF	; 02330534
	.byte 0xE8, 0xFF, 0xE9, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEB, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEE, 0xFF	; 02330544
	.byte 0xEF, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF1, 0xFF, 0xF2, 0xFF, 0xF3, 0xFF, 0xF4, 0xFF, 0xF4, 0xFF	; 02330554
	.byte 0xF5, 0xFF, 0xF6, 0xFF, 0xF7, 0xFF, 0xF7, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFA, 0xFF	; 02330564
	.byte 0xFB, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF, 0xFD, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00	; 02330574
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330584
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330594
P1_Data_023305A0:
	.byte 0x00, 0x00, 0xAA, 0x01	; 023305A0
	.byte 0x50, 0x03, 0xED, 0x04, 0x82, 0x06, 0xFE, 0x07, 0x65, 0x09, 0xB1, 0x0A, 0xE3, 0x0B, 0xF0, 0x0C	; 023305A4
	.byte 0xD9, 0x0D, 0x9B, 0x0E, 0x37, 0x0F, 0xA6, 0x0F, 0xE9, 0x0F, 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F	; 023305B4
	.byte 0x39, 0x0F, 0xA1, 0x0E, 0xDC, 0x0D, 0xF4, 0x0C, 0xE8, 0x0B, 0xBA, 0x0A, 0x6A, 0x09, 0x04, 0x08	; 023305C4
	.byte 0x87, 0x06, 0xF9, 0x04, 0x56, 0x03, 0xB1, 0x01, 0x06, 0x00, 0x5C, 0xFE, 0xB0, 0xFC, 0x13, 0xFB	; 023305D4
	.byte 0x84, 0xF9, 0x07, 0xF8, 0x9B, 0xF6, 0x4F, 0xF5, 0x21, 0xF4, 0x13, 0xF3, 0x27, 0xF2, 0x65, 0xF1	; 023305E4
	.byte 0xCB, 0xF0, 0x5B, 0xF0, 0x17, 0xF0, 0x00, 0xF0, 0x16, 0xF0, 0x58, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1	; 023305F4
	.byte 0x21, 0xF2, 0x08, 0xF3, 0x18, 0xF4, 0x46, 0xF5, 0x91, 0xF6, 0xF7, 0xF7, 0x79, 0xF9, 0x07, 0xFB	; 02330604
	.byte 0xA3, 0xFC, 0x49, 0xFE	; 02330614
P1_Data_02330618:
	.byte 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F, 0x39, 0x0F, 0x9E, 0x0E, 0xDC, 0x0D	; 02330618
	.byte 0xF4, 0x0C, 0xE8, 0x0B, 0xB5, 0x0A, 0x6A, 0x09, 0x04, 0x08, 0x87, 0x06, 0xF3, 0x04, 0x56, 0x03	; 02330624
	.byte 0xB1, 0x01, 0x06, 0x00, 0x56, 0xFE, 0xB0, 0xFC, 0x13, 0xFB, 0x84, 0xF9, 0x02, 0xF8, 0x9B, 0xF6	; 02330634
	.byte 0x4F, 0xF5, 0x21, 0xF4, 0x10, 0xF3, 0x27, 0xF2, 0x65, 0xF1, 0xCB, 0xF0, 0x5A, 0xF0, 0x17, 0xF0	; 02330644
	.byte 0x00, 0xF0, 0x16, 0xF0, 0x59, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1, 0x21, 0xF2, 0x0C, 0xF3, 0x18, 0xF4	; 02330654
	.byte 0x46, 0xF5, 0x91, 0xF6, 0xFC, 0xF7, 0x79, 0xF9, 0x07, 0xFB, 0xA3, 0xFC, 0x4F, 0xFE, 0xFA, 0xFF	; 02330664
	.byte 0xA4, 0x01, 0x4A, 0x03, 0xED, 0x04, 0x7C, 0x06, 0xF9, 0x07, 0x5F, 0x09, 0xB1, 0x0A, 0xDF, 0x0B	; 02330674
	.byte 0xED, 0x0C, 0xD6, 0x0D, 0x9B, 0x0E, 0x35, 0x0F, 0xA5, 0x0F, 0xE8, 0x0F, 0x83, 0x00, 0x00, 0x00	; 02330684
	.byte 0x80, 0x00, 0x00, 0x00, 0x96, 0x00, 0x00, 0x00, 0x97, 0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0x00	; 02330694
	.byte 0x6E, 0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 023306A4
	.byte 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 023306B4
	.byte 0x0C, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 023306C4
	.byte 0x4D, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00	; 023306D4
	.byte 0x59, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00	; 023306E4
	.byte 0x59, 0x00, 0x00, 0x00	; 023306F4
P1_Data_023306F8:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x00, 0x00	; 023306F8
	.byte 0xA9, 0x00, 0x00, 0x00	; 02330704
P1_Data_02330708:
	.byte 0x58, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x6B, 0x3D, 0x02	; 02330708
	.byte 0xA0, 0x84, 0x3D, 0x02, 0xE0, 0x98, 0x3D, 0x02, 0x20, 0xAF, 0x3D, 0x02, 0x20, 0xC5, 0x3D, 0x02	; 02330714
	.byte 0x00, 0xDB, 0x3D, 0x02	; 02330724
P1_Data_02330728:
	.byte 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00	; 02330728
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04, 0x00	; 02330734
	.byte 0x06, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00	; 02330744
	.byte 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330754
	.byte 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330764
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00	; 02330774
	.byte 0x02, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330784
	.byte 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330794
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023307A4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023307B4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023307C4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023307D4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00	; 023307E4
	.byte 0x02, 0x00, 0x04, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x05, 0x00, 0x08, 0x00, 0x09, 0x00	; 023307F4
	.byte 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330804
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330814
	.byte 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0A, 0x00, 0x07, 0x00, 0x01, 0x00, 0x05, 0x00, 0x01, 0x00	; 02330824
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330834
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330844
	.byte 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00	; 02330854
	.byte 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 02330864
	.byte 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00	; 02330874
	.byte 0x4D, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 02330884
	.byte 0x4D, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 02330894
	.byte 0x4D, 0x00, 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 023308A4
	.byte 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00	; 023308B4
	.byte 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00	; 023308C4
	.byte 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00	; 023308D4
	.byte 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00	; 023308E4
	.byte 0x00, 0x00, 0x00, 0x00	; 023308F4
P1_Data_023308F8:
	.byte 0x1F, 0x00, 0x1C, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00	; 023308F8
	.byte 0x1F, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00	; 02330904
P1_Data_02330910:
	.byte 0xFF, 0x00, 0x00, 0x00	; 02330910
	.byte 0x9B, 0x47, 0x26, 0x74, 0xBC, 0x11, 0x4F, 0x6D, 0xBD, 0x11, 0xF1, 0x32, 0xD9, 0x7F, 0xE7, 0x2C	; 02330914
	.byte 0xA5, 0x5D, 0xBD, 0x11, 0x10, 0x46, 0xA4, 0x5D, 0x90, 0x4E, 0x73, 0x61, 0x84, 0x2A, 0x91, 0x4E	; 02330924
	.byte 0x6A, 0x10, 0xFE, 0x75, 0xC8, 0x29, 0x39, 0x78, 0x0E, 0x42, 0x1B, 0x5D, 0x38, 0x78, 0xA8, 0x12	; 02330934
	.byte 0x7D, 0x3F, 0xB9, 0x67, 0xF3, 0x26, 0xEF, 0x54, 0x23, 0x7C, 0xF2, 0x26, 0xC6, 0x6B, 0x37, 0x41	; 02330944
	.byte 0xAB, 0x15, 0x0D, 0x73, 0xC7, 0x6B, 0x4F, 0x3B, 0x24, 0x5F, 0xDA, 0x3D, 0x3F, 0x25, 0x49, 0x17	; 02330954
	.byte 0xDB, 0x3D, 0xE6, 0x70, 0x6C, 0x74, 0xF7, 0x30, 0x1F, 0x53, 0x38, 0x67, 0x1E, 0x53, 0x51, 0x1A	; 02330964
	.byte 0x71, 0x19, 0x7D, 0x5B, 0xD6, 0x4E, 0x70, 0x19, 0x27, 0x3F, 0xCB, 0x75, 0x62, 0x3D, 0x8C, 0x12	; 02330974
	.byte 0xB8, 0x74, 0xAD, 0x2F, 0xB9, 0x74, 0xFD, 0x64, 0x9A, 0x6C, 0x3A, 0x4F, 0x6D, 0x27, 0xEF, 0x73	; 02330984
	.byte 0xB1, 0x38, 0x3B, 0x4F, 0x1E, 0x57, 0xA3, 0x7E, 0x49, 0x62, 0x87, 0x35, 0x7C, 0x1B, 0x86, 0x35	; 02330994
	.byte 0xFB, 0x7A, 0xE4, 0x67, 0x92, 0x5C, 0xE5, 0x67, 0xCA, 0x2B, 0x8C, 0x43, 0x6F, 0x2E, 0x7F, 0x58	; 023309A4
	.byte 0xB7, 0x14, 0x6E, 0x2E, 0xB9, 0x4C, 0xA2, 0x6F, 0xF0, 0x38, 0x9E, 0x71, 0x5A, 0x47, 0x3C, 0x1F	; 023309B4
	.byte 0xD8, 0x6A, 0x5B, 0x47, 0x99, 0x51, 0x64, 0x32, 0x41, 0x7B, 0xEF, 0x49, 0x98, 0x51, 0xD7, 0x1C	; 023309C4
P1_Data_023309D4:
	.byte 0xC0, 0x01, 0x01, 0x04, 0x00, 0x00, 0x00, 0x00, 0x30, 0x31, 0x00, 0x00, 0x41, 0x53, 0x4D, 0x4A	; 023309D4
	.byte 0x00, 0x00, 0x00, 0x00, 0x41, 0x53, 0x4D, 0x45, 0x00, 0x00, 0x00, 0x00	; 023309E4
P1_Data_023309F0:
	.byte 0x08, 0x00, 0x09, 0x00	; 023309F0
	.byte 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 023309F4
P1_Data_02330A00:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P1_IrqHandlers:
	.word P1_IrqHandler_0232B118 + 1	; IRQ 0
	.word P1_IrqHandler_0232B118 + 1	; IRQ 1
	.word P1_IrqHandler_0232B118 + 1	; IRQ 2
	.word P1_IrqHandler_0232B07C + 1	; IRQ 3
	.word P1_IrqHandler_0232B070 + 1	; IRQ 4
	.word P1_IrqHandler_0232B064 + 1	; IRQ 5
	.word P1_IrqHandler_0232B058 + 1	; IRQ 6
	.word P1_IrqHandler_0232B118 + 1	; IRQ 7
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 8
	.word P1_IrqHandler_0232B0A0 + 1	; IRQ 9
	.word P1_IrqHandler_0232B094 + 1	; IRQ 10
	.word P1_IrqHandler_0232B088 + 1	; IRQ 11
	.word P1_IrqHandler_0232B118 + 1	; IRQ 12
	.word P1_IrqHandler_0232B118 + 1	; IRQ 13
	.word P1_IrqHandler_0232B118 + 1	; IRQ 14
	.word P1_IrqHandler_0232B118 + 1	; IRQ 15
	.word P1_IrqHandler_0232B118 + 1	; IRQ 16
	.word P1_IrqHandler_0232B118 + 1	; IRQ 17
	.word P1_IrqHandler_0232B118 + 1	; IRQ 18
	.word P1_IrqHandler_0232B118 + 1	; IRQ 19
	.word P1_IrqHandler_0232B118 + 1	; IRQ 20
	.word P1_IrqHandler_0232B118 + 1	; IRQ 21
P1_IrqHandlersEnd:
P1_Data_02330A58:
	.byte 0xFF, 0xFF, 0xFF, 0xFF	; 02330A58
P1_Data_02330A5C:
	.byte 0x01, 0x00, 0x00, 0x00	; 02330A5C
P1_Data_02330A60:
	.byte 0x03, 0x00, 0x00, 0x00	; 02330A60
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330A64
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330A74
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
	.word 0x08000180	; 01FF807C
pool_01FF8080:
	.word P1_ItcmRuntimeStart	; 01FF8080
P1_Runtime_01FF8084:
	push {r4,r5,r6,r7,lr}	; 01FF8084
	sub sp,#0xc	; 01FF8086
	blx loc_0232B270	; 01FF8088
	lsl r0,r0,#0x10	; 01FF808C
	lsr r0,r0,#0x10	; 01FF808E
	str r0,[sp,#0x0]	; 01FF8090
	bl loc_0232B3C8	; 01FF8092
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
	bl loc_0232B260	; 01FF810C
	ldr r0,[sp,#0x0]	; 01FF8110
	blx loc_0232B2C8	; 01FF8112
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
	.byte 0x21, 0x06, 0xC0, 0xDE, 0x70, 0x04, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330DD8
.arm
.close
