; official_v3_p1
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
	bl P1_InitializeRuntimeState	; 02320074
	bl loc_0232C898	; 02320078
	blx P1_CallStaticInitializers	; 0232007C
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
; 固件主循环：初始化显示、输入和共享状态后分派启动状态。
; Firmware main loop: initializes display, input and shared state, then dispatches boot states.
P1_FirmwareMainLoop:
loc_023200A0:
	push {r4,r5,lr}	; 023200A0
	sub sp,#0xc	; 023200A2
	mov r5,#0x0	; 023200A4
	add r4,r5,#0x0	; 023200A6
	ldr r0,[pool_02320210]	; 023200A8
	bl loc_0232796C	; 023200AA
	bl loc_0232BB8C	; 023200AE
	bl loc_0232C010	; 023200B2
	bl loc_0232D458	; 023200B6
	bl loc_0232EE24	; 023200BA
	ldr r1,[pool_02320214]	; 023200BE
	ldrh r2,[r1,#0x0]	; 023200C0
	ldr r0,[pool_02320218]	; 023200C2
	and r2,r0	; 023200C4
	ldr r0,[pool_0232021C]	; 023200C6
	orr r2,r0	; 023200C8
	strh r2,[r1,#0x0]	; 023200CA
	ldr r0,[pool_02320220]	; 023200CC
	bl loc_0232D684	; 023200CE
	lsl r0,r5,#0	; 023200D2
	str r0,[sp,#0x4]	; 023200D4
	ldr r0,[sp,#0x4]	; 023200D6
	ldr r1,[pool_02320224]	; 023200D8
	ldr r2,[pool_02320228]	; 023200DA
	blx loc_0232DDBC	; 023200DC
	bl loc_0232D584	; 023200E0
	mov r0,#0xc0	; 023200E4
	str r0,[sp,#0x0]	; 023200E6
	ldr r0,[sp,#0x0]	; 023200E8
	ldr r1,[pool_0232022C]	; 023200EA
	ldr r2,[pool_02320230]	; 023200EC
	blx loc_0232DDBC	; 023200EE
	lsl r0,r5,#0	; 023200F2
	str r0,[sp,#0x8]	; 023200F4
	ldr r0,[sp,#0x8]	; 023200F6
	ldr r1,[pool_02320234]	; 023200F8
	ldr r2,[pool_02320230]	; 023200FA
	blx loc_0232DDBC	; 023200FC
	mov r0,#0x1	; 02320100
	ldr r1,[pool_02320238]	; 02320102
	bl loc_0232B134	; 02320104
	mov r0,#0x1	; 02320108
	bl loc_0232B0B0	; 0232010A
	ldr r1,[pool_0232023C]	; 0232010E
	ldrh r0,[r1,#0x0]	; 02320110
	mov r0,#0x1	; 02320112
	strh r0,[r1,#0x0]	; 02320114
	blx P1_Arm9EnableIrqReturnPriorMask	; 02320116
	mov r0,#0x1	; 0232011A
	bl loc_0232D434	; 0232011C
	bl loc_0232FCEC	; 02320120
	bl loc_0232783C	; 02320124
	cmp r0,#0x0	; 02320128
	bne loc_02320206	; 0232012A
	bl loc_023275E8	; 0232012C
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
	bl loc_023275E8	; 02320180
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
	bl loc_02327534	; 023201A4
	b loc_023201B4	; 023201A8
loc_023201AA:
	bl loc_02327554	; 023201AA
	b loc_023201B4	; 023201AE
loc_023201B0:
	bl loc_02327544	; 023201B0
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
	bl loc_023275B4	; 023201D4
	b loc_02320200	; 023201D8
loc_023201DA:
	bl loc_0232D400	; 023201DA
	ldr r2,[pool_02320240]	; 023201DE
	ldr r1,[r2,#0x0]	; 023201E0
	ldr r0,[pool_02320244]	; 023201E2
	and r1,r0	; 023201E4
	str r1,[r2,#0x0]	; 023201E6
	bl loc_02327574	; 023201E8
	b loc_02320200	; 023201EC
loc_023201EE:
	bl loc_0232D400	; 023201EE
	ldr r2,[pool_02320240]	; 023201F2
	ldr r1,[r2,#0x0]	; 023201F4
	ldr r0,[pool_02320244]	; 023201F6
	and r1,r0	; 023201F8
	str r1,[r2,#0x0]	; 023201FA
	bl loc_02327564	; 023201FC
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
	.word 0x0232FDC8	; 02320210
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

; 根据共享状态中的启动原因选择后续 UI/启动路径。
; Selects the subsequent UI/boot path from the shared boot-state value.
P1_DispatchBootState:
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
	bl loc_0232C61C	; 02320388
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
	.word 0x02330AF4	; 023203D0
pool_023203D4:
loc_023203D4:
	.word 0x0233145C	; 023203D4
pool_023203D8:
loc_023203D8:
	.word P1_BssStart + 0x1300	; 023203D8
pool_023203DC:
loc_023203DC:
	.word 0x02331470	; 023203DC
pool_023203E0:
loc_023203E0:
	.word P1_BssStart + 0xA80	; 023203E0
pool_023203E4:
loc_023203E4:
	.word P1_BssStart + 0x100	; 023203E4
pool_023203E8:
loc_023203E8:
	.word 0x02330A0C	; 023203E8
pool_023203EC:
loc_023203EC:
	.word 0x023A5A4C	; 023203EC
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
	.word 0x0233145C	; 023204FC
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
	bl loc_0232D338	; 02320528
	ldr r0,[pool_02320558]	; 0232052C
	add r1,r5,#0x0	; 0232052E
	bl loc_0232D338	; 02320530
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
	bl loc_0232D8AC	; 023205A0
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
	.word 0x023309C0	; 023205E8
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
	bl loc_0232F140	; 0232077E
	b loc_02320792	; 02320782
loc_02320784:
	mov r0,#0x2e	; 02320784
	bl loc_02323724	; 02320786
	mov r0,#0x2	; 0232078A
	mov r1,#0x0	; 0232078C
	bl loc_0232F140	; 0232078E
loc_02320792:
	add sp,#0x4	; 02320792
	pop {r4,r5}	; 02320794
	pop {r3}	; 02320796
	bx r3	; 02320798
	.byte 0xC0, 0x46	; 0232079C
pool_0232079C:
loc_0232079C:
	.word 0x023309C0	; 0232079C
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
	bl loc_0232D8AC	; 0232084E
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

; 以 16 级步进更新启动背光 PWM；完成时清除渐变状态位。
; Advances the boot backlight PWM in 16 steps and clears the fade flag when done.
P1_UpdateBootBacklightFade:
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
	bl loc_0232D8AC	; 02320918
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
	.word 0x02330B40	; 02320948
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
	.word 0x02330B40	; 02320A94
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
	.word 0x02330B40	; 02320AF0
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
	.word 0x02331498	; 02320DA8
pool_02320DAC:
loc_02320DAC:
	.word 0x023C10D8	; 02320DAC
pool_02320DB0:
loc_02320DB0:
	.word 0x023A4FEC	; 02320DB0
pool_02320DB4:
loc_02320DB4:
	.word P1_BssStart + 0x1300	; 02320DB4
pool_02320DB8:
loc_02320DB8:
	.word 0x023D3A1C	; 02320DB8
pool_02320DBC:
loc_02320DBC:
	.word P1_BssStart + 0xB00	; 02320DBC
pool_02320DC0:
loc_02320DC0:
	.word 0x02330B40	; 02320DC0
pool_02320DC4:
loc_02320DC4:
	.word 0x02330B04	; 02320DC4
pool_02320DC8:
loc_02320DC8:
	.word 0x00001000	; 02320DC8
pool_02320DCC:
loc_02320DCC:
	.word 0x023A4F44	; 02320DCC
pool_02320DD0:
loc_02320DD0:
	.word P1_Data_0232FDE4	; 02320DD0
pool_02320DD4:
loc_02320DD4:
	.word 0x023309C0	; 02320DD4
pool_02320DD8:
loc_02320DD8:
	.word 0x02330AF4	; 02320DD8
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
	.word P1_Data_0232FDDC	; 02320DE8
pool_02320DEC:
loc_02320DEC:
	.word P1_Data_0232FDD4	; 02320DEC

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
	blx loc_0232DDBC	; 02320E06
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
	bl loc_0232D400	; 02320E84
	ldr r2,[pool_023211EC]	; 02320E88
	ldr r1,[r2,#0x0]	; 02320E8A
	ldr r0,[pool_023211F0]	; 02320E8C
	and r1,r0	; 02320E8E
	str r1,[r2,#0x0]	; 02320E90
	ldr r0,[pool_023211F4]	; 02320E92
	bl loc_0232D684	; 02320E94
	mov r0,#0x0	; 02320E98
	str r0,[sp,#0xc]	; 02320E9A
	ldr r0,[sp,#0xc]	; 02320E9C
	ldr r1,[pool_023211F8]	; 02320E9E
	ldr r2,[pool_023211FC]	; 02320EA0
	blx loc_0232DDBC	; 02320EA2
	bl loc_0232D584	; 02320EA6
	mov r0,#0xc0	; 02320EAA
	str r0,[sp,#0x4]	; 02320EAC
	ldr r0,[sp,#0x4]	; 02320EAE
	ldr r1,[pool_02321200]	; 02320EB0
	ldr r2,[pool_02321204]	; 02320EB2
	blx loc_0232DDBC	; 02320EB4
	mov r0,#0x0	; 02320EB8
	str r0,[sp,#0x10]	; 02320EBA
	ldr r0,[sp,#0x10]	; 02320EBC
	ldr r1,[pool_02321208]	; 02320EBE
	ldr r2,[pool_02321204]	; 02320EC0
	blx loc_0232DDBC	; 02320EC2
	mov r0,#0x1	; 02320EC6
	bl loc_02326D80	; 02320EC8
	mov r0,#0x2	; 02320ECC
	bl loc_02326D54	; 02320ECE
	mov r0,#0x1	; 02320ED2
	mov r1,#0x0	; 02320ED4
	add r2,r1,#0x0	; 02320ED6
	bl loc_0232D374	; 02320ED8
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
	bl loc_0232D994	; 02320F0E
	ldr r1,[pool_02321228]	; 02320F12
	ldr r0,[pool_0232122C]	; 02320F14
	sub r7,r1,r0	; 02320F16
	mov r1,#0x0	; 02320F18
	add r2,r7,#0x0	; 02320F1A
	bl loc_0232DC64	; 02320F1C
	ldr r0,[pool_02321230]	; 02320F20
	mov r1,#0x0	; 02320F22
	ldr r2,[pool_02321234]	; 02320F24
	sub r2,r2,r0	; 02320F26
	bl loc_0232DAD4	; 02320F28
	ldr r0,[pool_02321238]	; 02320F2C
	mov r1,#0x0	; 02320F2E
	ldr r2,[pool_0232123C]	; 02320F30
	sub r2,r2,r0	; 02320F32
	bl loc_0232DC14	; 02320F34
	ldr r0,[pool_02321240]	; 02320F38
	mov r1,#0x0	; 02320F3A
	mov r2,#0x2	; 02320F3C
	bl loc_0232DC64	; 02320F3E
	mov r0,#0x4	; 02320F42
	bl loc_02326D28	; 02320F44
	mov r0,#0x8	; 02320F48
	bl loc_02326CFC	; 02320F4A
	mov r0,#0x0	; 02320F4E
	bl loc_0232D360	; 02320F50
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
	bl loc_0232D96C	; 02320FD4
	mov r4,#0x0	; 02320FD8
	ldr r6,[pool_02321274]	; 02320FDA
loc_02320FDC:
	lsl r5,r4,#0x6	; 02320FDC
	lsl r0,r4,#0x7	; 02320FDE
	add r0,r6,r0	; 02320FE0
	add r1,r5,#0x0	; 02320FE2
	mov r2,#0x40	; 02320FE4
	bl loc_0232DAAC	; 02320FE6
	lsl r0,r4,#0x1	; 02320FEA
	add r0,r0,#0x1	; 02320FEC
	lsl r0,r0,#0x6	; 02320FEE
	add r0,r6,r0	; 02320FF0
	ldr r1,[pool_02321278]	; 02320FF2
	add r1,r5,r1	; 02320FF4
	mov r2,#0x40	; 02320FF6
	bl loc_0232DAAC	; 02320FF8
	add r4,r4,#0x1	; 02320FFC
	cmp r4,#0x20	; 02320FFE
	blt loc_02320FDC	; 02321000
	bl loc_0232527C	; 02321002
	ldr r0,[pool_0232127C]	; 02321006
	ldr r1,[pool_02321280]	; 02321008
	ldr r2,[pool_02321284]	; 0232100A
	sub r2,r2,r0	; 0232100C
	blx loc_0232DDA4	; 0232100E
	ldr r0,[pool_02321288]	; 02321012
	ldr r1,[pool_0232128C]	; 02321014
	ldr r2,[pool_02321290]	; 02321016
	sub r2,r2,r0	; 02321018
	blx loc_0232DDA4	; 0232101A
	ldr r0,[pool_02321294]	; 0232101E
	ldr r1,[pool_02321298]	; 02321020
	ldr r2,[pool_0232129C]	; 02321022
	sub r2,r2,r0	; 02321024
	blx loc_0232DDA4	; 02321026
	ldr r0,[pool_023212A0]	; 0232102A
	ldr r1,[pool_023212A4]	; 0232102C
	ldr r2,[pool_023212A8]	; 0232102E
	sub r2,r2,r0	; 02321030
	blx loc_0232DDA4	; 02321032
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
	bl loc_02329100	; 02321072
	add r5,r0,#0x0	; 02321076
	ldr r0,[pool_023212B0]	; 02321078
	bl loc_02329100	; 0232107A
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
	bl loc_0232D114	; 023210E6
	ldr r0,[pool_023212C4]	; 023210EA
	bl loc_02327108	; 023210EC
	ldr r0,[pool_023212C8]	; 023210F0
	ldr r1,[pool_023212CC]	; 023210F2
	ldr r2,[pool_023212D0]	; 023210F4
	bl loc_0232DB4C	; 023210F6
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
	bl loc_0232C564	; 02321152
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
	.word 0x023309C0	; 023211C4
pool_023211C8:
loc_023211C8:
	.word 0x0000136C	; 023211C8
pool_023211CC:
loc_023211CC:
	.word 0x02330AF4	; 023211CC
pool_023211D0:
loc_023211D0:
	.word 0x0232FE4C	; 023211D0
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
	.word 0x023B01A0	; 02321220
pool_02321224:
loc_02321224:
	.word 0x023AE5A0	; 02321224
pool_02321228:
loc_02321228:
	.word 0x023BBF20	; 02321228
pool_0232122C:
loc_0232122C:
	.word 0x023BBD20	; 0232122C
pool_02321230:
loc_02321230:
	.word 0x023B7D20	; 02321230
pool_02321234:
loc_02321234:
	.word 0x023B8520	; 02321234
pool_02321238:
loc_02321238:
	.word 0x023BCD20	; 02321238
pool_0232123C:
loc_0232123C:
	.word 0x023BCF20	; 0232123C
pool_02321240:
loc_02321240:
	.word 0x0232FF7C	; 02321240
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
	.word 0x023BA520	; 02321274
pool_02321278:
loc_02321278:
	.word 0x00000800	; 02321278
pool_0232127C:
loc_0232127C:
	.word 0x023B6D20	; 0232127C
pool_02321280:
loc_02321280:
	.word 0x06200000	; 02321280
pool_02321284:
loc_02321284:
	.word 0x023B7520	; 02321284
pool_02321288:
loc_02321288:
	.word 0x023B9D20	; 02321288
pool_0232128C:
loc_0232128C:
	.word 0x06203000	; 0232128C
pool_02321290:
loc_02321290:
	.word 0x023BA520	; 02321290
pool_02321294:
loc_02321294:
	.word 0x023B9520	; 02321294
pool_02321298:
loc_02321298:
	.word 0x06203800	; 02321298
pool_0232129C:
loc_0232129C:
	.word 0x023B9D20	; 0232129C
pool_023212A0:
loc_023212A0:
	.word 0x023B7520	; 023212A0
pool_023212A4:
loc_023212A4:
	.word 0x06204800	; 023212A4
pool_023212A8:
loc_023212A8:
	.word 0x023B7D20	; 023212A8
pool_023212AC:
loc_023212AC:
	.word 0x023C10D8	; 023212AC
pool_023212B0:
loc_023212B0:
	.word 0x023D3A1C	; 023212B0
pool_023212B4:
loc_023212B4:
	.word 0x023D3B70	; 023212B4
pool_023212B8:
loc_023212B8:
	.word 0x023A5A4C	; 023212B8
pool_023212BC:
loc_023212BC:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023212BC
pool_023212C0:
loc_023212C0:
	.word 0x00000102	; 023212C0
pool_023212C4:
loc_023212C4:
	.word 0x023314D8	; 023212C4
pool_023212C8:
loc_023212C8:
	.word 0x023314F8	; 023212C8
pool_023212CC:
loc_023212CC:
	.word 0x0001FE00	; 023212CC
pool_023212D0:
loc_023212D0:
	.word 0x00000200	; 023212D0
pool_023212D4:
loc_023212D4:
	.word 0x02330A0C	; 023212D4
pool_023212D8:
loc_023212D8:
	.word P1_BssStart + 0x40	; 023212D8
pool_023212DC:
loc_023212DC:
	.word 0x02331498	; 023212DC
pool_023212E0:
loc_023212E0:
	.word 0x023A5B24	; 023212E0
pool_023212E4:
loc_023212E4:
	.word 0x023BC520	; 023212E4
loc_023212E8:
	mov r1,#0x0	; 023212E8
	ldr r2,[pool_02321410]	; 023212EA
	sub r2,r2,r0	; 023212EC
	bl loc_0232DBEC	; 023212EE
	ldr r0,[pool_02321414]	; 023212F2
	mov r1,#0x0	; 023212F4
	add r2,r7,#0x0	; 023212F6
	bl loc_0232DC3C	; 023212F8
	ldr r0,[pool_02321418]	; 023212FC
	mov r1,#0x0	; 023212FE
	mov r2,#0x2	; 02321300
	bl loc_0232DC3C	; 02321302
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
	bl loc_0232DBEC	; 02321392
	ldr r0,[pool_02321460]	; 02321396
	mov r1,#0x0	; 02321398
	add r2,r4,#0x0	; 0232139A
	bl loc_0232DC3C	; 0232139C
	ldr r0,[pool_02321464]	; 023213A0
	mov r1,#0x0	; 023213A2
	mov r2,#0x2	; 023213A4
	bl loc_0232DC3C	; 023213A6
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
	bl loc_0232D8AC	; 023213C4
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
	bl loc_0232B134	; 023213E8
	mov r0,#0x1	; 023213EC
	bl loc_0232B0B0	; 023213EE
	mov r0,#0x1	; 023213F2
	bl loc_0232D434	; 023213F4
	bl loc_0232D3C0	; 023213F8
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
	.word 0x023BC720	; 02321410
pool_02321414:
loc_02321414:
	.word 0x023BBD20	; 02321414
pool_02321418:
loc_02321418:
	.word 0x0232FF80	; 02321418
pool_0232141C:
loc_0232141C:
	.word P1_BssStart + 0x100	; 0232141C
pool_02321420:
loc_02321420:
	.word P1_BssStart + 0x1300	; 02321420
pool_02321424:
loc_02321424:
	.word 0x023A6D7C	; 02321424
pool_02321428:
loc_02321428:
	.word 0x023A594C	; 02321428
pool_0232142C:
loc_0232142C:
	.word P1_BssStart + 0xB00	; 0232142C
pool_02321430:
loc_02321430:
	.word 0x023A737C	; 02321430
pool_02321434:
loc_02321434:
	.word 0x023A596C	; 02321434
pool_02321438:
loc_02321438:
	.word 0x023A647C	; 02321438
pool_0232143C:
loc_0232143C:
	.word 0x023A591C	; 0232143C
pool_02321440:
loc_02321440:
	.word 0x023A6748	; 02321440
pool_02321444:
loc_02321444:
	.word 0x023A592C	; 02321444
pool_02321448:
loc_02321448:
	.word 0x023A6A5C	; 02321448
pool_0232144C:
loc_0232144C:
	.word 0x023A593C	; 0232144C
pool_02321450:
loc_02321450:
	.word 0x023A7064	; 02321450
pool_02321454:
loc_02321454:
	.word 0x023A595C	; 02321454
pool_02321458:
loc_02321458:
	.word 0x00000200	; 02321458
pool_0232145C:
loc_0232145C:
	.word 0x023BCD20	; 0232145C
pool_02321460:
loc_02321460:
	.word 0x023BCB20	; 02321460
pool_02321464:
loc_02321464:
	.word 0x0232FF84	; 02321464
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
	.word 0x023309C0	; 02321478
pool_0232147C:
loc_0232147C:
	.word 0x02330B40	; 0232147C
pool_02321480:
loc_02321480:
	.word 0x0233145C	; 02321480
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
	.word 0x023314F8	; 02321538
pool_0232153C:
loc_0232153C:
	.word 0x00000220	; 0232153C
pool_02321540:
loc_02321540:
	.word 0x0232FDF0	; 02321540
pool_02321544:
loc_02321544:
	.word 0x0232FE08	; 02321544
pool_02321548:
loc_02321548:
	.word 0x0232FDFC	; 02321548
pool_0232154C:
loc_0232154C:
	.word 0x023309C0	; 0232154C
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
	bl loc_0232F140	; 0232157E
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
	bl loc_0232DBEC	; 023215C8
	ldr r0,[pool_0232168C]	; 023215CC
	ldr r1,[pool_02321690]	; 023215CE
	mov r2,#0x20	; 023215D0
	bl loc_0232DBEC	; 023215D2
	ldr r0,[pool_02321694]	; 023215D6
	mov r1,#0x0	; 023215D8
	ldr r2,[pool_02321698]	; 023215DA
	sub r2,r2,r0	; 023215DC
	bl loc_0232DC3C	; 023215DE
	ldr r0,[pool_0232169C]	; 023215E2
	mov r1,#0x0	; 023215E4
	mov r2,#0x2	; 023215E6
	bl loc_0232DC3C	; 023215E8
	ldr r1,[pool_023216A0]	; 023215EC
	lsl r0,r4,#0x5	; 023215EE
	add r4,r1,r0	; 023215F0
	add r0,r4,#0x0	; 023215F2
	ldr r1,[pool_023216A4]	; 023215F4
	mov r2,#0x20	; 023215F6
	bl loc_0232DC3C	; 023215F8
	add r0,r4,#0x0	; 023215FC
	ldr r1,[pool_023216A4]	; 023215FE
	mov r2,#0x20	; 02321600
	bl loc_0232DBEC	; 02321602
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
	bl loc_0232DC3C	; 0232164E
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
	.word 0x023BC520	; 02321684
pool_02321688:
loc_02321688:
	.word 0x023BC720	; 02321688
pool_0232168C:
loc_0232168C:
	.word 0x023316F8	; 0232168C
pool_02321690:
loc_02321690:
	.word 0x000001C0	; 02321690
pool_02321694:
loc_02321694:
	.word 0x023BBD20	; 02321694
pool_02321698:
loc_02321698:
	.word 0x023BBF20	; 02321698
pool_0232169C:
loc_0232169C:
	.word 0x0232FF88	; 0232169C
pool_023216A0:
loc_023216A0:
	.word 0x023BC920	; 023216A0
pool_023216A4:
loc_023216A4:
	.word 0x000001E0	; 023216A4
pool_023216A8:
loc_023216A8:
	.word 0x02331D24	; 023216A8

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
	.word 0x0232FE9C	; 0232186C
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
	.word P1_Data_0232FE14	; 023218E8
pool_023218EC:
loc_023218EC:
	.word 0x0232FE9C	; 023218EC

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
	bl loc_0232D8AC	; 02321904
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
	blx loc_0232DD74	; 023219B6
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
	.word P5_Data_023AE3F8	; 02321A20

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
	bl P1_Divide32By32	; 02321A60
	str r0,[sp,#0x18]	; 02321A64
	ldr r1,[r6,#0x64]	; 02321A66
	ldr r0,[pool_02321AEC]	; 02321A68
	add r0,r1,r0	; 02321A6A
	ldr r1,[pool_02321AF0]	; 02321A6C
	bl P1_Divide32By32	; 02321A6E
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
	bl P1_ComputeFixedPointReciprocal	; 02321AC6
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
	.word P1_Data_0232FE24	; 02321AF4
pool_02321AF8:
loc_02321AF8:
	.word 0x023D3B70	; 02321AF8
pool_02321AFC:
loc_02321AFC:
	.word 0x023A56FC	; 02321AFC

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
	bl loc_0232910C	; 02321B18
	add r6,r0,#0x0	; 02321B1C
	ldr r0,[pool_02321BE0]	; 02321B1E
	ldr r1,[r5,#0x4]	; 02321B20
	bl loc_023290F4	; 02321B22
	add r4,r0,#0x0	; 02321B26
	ldr r0,[pool_02321BE0]	; 02321B28
	ldr r1,[r5,#0x4]	; 02321B2A
	bl loc_02329124	; 02321B2C
	str r0,[sp,#0xc]	; 02321B30
	mov r1,sp	; 02321B32
	sub r1,r1,#0x4	; 02321B34
	ldr r0,[sp,#0x14]	; 02321B36
	ldrh r0,[r7,r0]	; 02321B38
	strh r0,[r1,#0x0]	; 02321B3A
	ldmia r1!,{r0}	; 02321B3C
	ldrb r1,[r4,#0x0]	; 02321B3E
	bl loc_02329024	; 02321B40
	ldr r1,[sp,#0x0]	; 02321B44
	add r0,r1,r0	; 02321B46
	str r0,[sp,#0x0]	; 02321B48
	mov r1,sp	; 02321B4A
	sub r1,r1,#0x4	; 02321B4C
	ldrh r0,[r5,#0x2]	; 02321B4E
	strh r0,[r1,#0x0]	; 02321B50
	ldmia r1!,{r0}	; 02321B52
	ldrb r1,[r4,#0x1]	; 02321B54
	bl loc_02328FEC	; 02321B56
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
	.word 0x023A56FC	; 02321BDC
pool_02321BE0:
loc_02321BE0:
	.word 0x023D3B70	; 02321BE0
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
	blx loc_0232D31C	; 02321CC6
	add r6,r0,#0x0	; 02321CCA
	ldr r0,[sp,#0x0]	; 02321CCC
	ldr r1,[pool_02321CFC]	; 02321CCE
	add r1,r5,r1	; 02321CD0
	blx loc_0232D31C	; 02321CD2
	add r1,r7,#0x0	; 02321CD6
	blx loc_0232D31C	; 02321CD8
	ldr r1,[sp,#0x1c]	; 02321CDC
	sub r1,r1,r4	; 02321CDE
	blx loc_0232D31C	; 02321CE0
	add r4,r0,#0x0	; 02321CE4
	add r0,r5,#0x0	; 02321CE6
	ldr r1,[sp,#0x1c]	; 02321CE8
	blx loc_0232D31C	; 02321CEA
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
	.word 0x023A4A48	; 02321D50

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
	bl loc_0232D8AC	; 02321DD2
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
	bl loc_0232D8AC	; 02321E28
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
	.word 0x02331D48	; 02321E80
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
	.word P1_Data_0232FFB4	; 02321ECC

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
	bl loc_0232DB74	; 02321F22
	add r0,r4,#0x0	; 02321F26
	ldr r1,[pool_02321F5C]	; 02321F28
	mov r2,#0x20	; 02321F2A
	bl loc_0232DC14	; 02321F2C
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
	.word 0x02331E3C	; 02321F4C
pool_02321F50:
loc_02321F50:
	.word 0x02331EC0	; 02321F50
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
	bl loc_0232D890	; 02321F84
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
	blx loc_0232DD90	; 02322020
	ldr r0,[pool_02322100]	; 02322024
	mov r1,#0x0	; 02322026
	ldr r2,[pool_02322104]	; 02322028
	sub r2,r2,r0	; 0232202A
	bl loc_0232D944	; 0232202C
	ldr r0,[pool_02322108]	; 02322030
	mov r1,#0x0	; 02322032
	ldr r2,[pool_0232210C]	; 02322034
	sub r2,r2,r0	; 02322036
	bl loc_0232DC64	; 02322038
	mov r1,#0x0	; 0232203C
	ldr r0,[pool_02322110]	; 0232203E
	strh r1,[r0,#0x0]	; 02322040
	mov r1,#0x2	; 02322042
	blx P1_CleanDataCacheRange	; 02322044
	ldr r0,[pool_02322110]	; 02322048
	mov r1,#0x0	; 0232204A
	mov r2,#0x2	; 0232204C
	bl loc_0232DC64	; 0232204E
	ldr r1,[pool_02322114]	; 02322052
	lsl r0,r7,#0x5	; 02322054
	add r5,r1,r0	; 02322056
	add r0,r5,#0x0	; 02322058
	ldr r1,[pool_02322118]	; 0232205A
	mov r2,#0x20	; 0232205C
	bl loc_0232DC64	; 0232205E
	ldr r0,[pool_0232211C]	; 02322062
	mov r1,#0x0	; 02322064
	ldr r2,[pool_02322120]	; 02322066
	sub r2,r2,r0	; 02322068
	bl loc_0232DA84	; 0232206A
	ldr r0,[pool_02322124]	; 0232206E
	mov r1,#0x0	; 02322070
	ldr r2,[pool_02322128]	; 02322072
	sub r2,r2,r0	; 02322074
	bl loc_0232DA34	; 02322076
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
	bl loc_0232DC14	; 023220A8
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
	.word 0x023AE5A0	; 02322100
pool_02322104:
loc_02322104:
	.word 0x023B01A0	; 02322104
pool_02322108:
loc_02322108:
	.word 0x023BBD20	; 02322108
pool_0232210C:
loc_0232210C:
	.word 0x023BBF20	; 0232210C
pool_02322110:
loc_02322110:
	.word P1_BssStart + 0x136C	; 02322110
pool_02322114:
loc_02322114:
	.word 0x023BC920	; 02322114
pool_02322118:
loc_02322118:
	.word 0x000001E0	; 02322118
pool_0232211C:
loc_0232211C:
	.word 0x023B8520	; 0232211C
pool_02322120:
loc_02322120:
	.word 0x023B8D20	; 02322120
pool_02322124:
loc_02322124:
	.word 0x023B6D20	; 02322124
pool_02322128:
loc_02322128:
	.word 0x023B7520	; 02322128
pool_0232212C:
loc_0232212C:
	.word 0x023C10D8	; 0232212C
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
	.word P1_Data_0232FFB4	; 02322190
pool_02322194:
loc_02322194:
	.word P1_BssStart + 0x1444	; 02322194
pool_02322198:
loc_02322198:
	.word 0x02331E10	; 02322198
pool_0232219C:
loc_0232219C:
	.word 0x023A60D4	; 0232219C
pool_023221A0:
loc_023221A0:
	.word P1_Data_0232FFB6	; 023221A0
pool_023221A4:
loc_023221A4:
	.word 0x02331E94	; 023221A4
pool_023221A8:
loc_023221A8:
	.word P1_Data_0232FFB8	; 023221A8

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
	.word 0x0232FFB4	; 023221FC
pool_02322200:
loc_02322200:
	.word 0x02331E10	; 02322200
pool_02322204:
loc_02322204:
	.word 0x023A60D4	; 02322204
pool_02322208:
loc_02322208:
	.word 0x02331E94	; 02322208
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
	bl loc_023291B0	; 02322318
	add r6,r0,#0x0	; 0232231C
	bl P3_Entry_0236776C	; 0232231E
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
	.word P1_Data_0232FFB4	; 02322404
pool_02322408:
loc_02322408:
	.word 0x0232FFBA	; 02322408
pool_0232240C:
loc_0232240C:
	.word 0x02331E10	; 0232240C
pool_02322410:
loc_02322410:
	.word 0x02331E94	; 02322410
pool_02322414:
loc_02322414:
	.word 0x023A4B28	; 02322414
pool_02322418:
loc_02322418:
	.word 0x023C10D8	; 02322418
pool_0232241C:
loc_0232241C:
	.word 0x023A51CC	; 0232241C
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
	.word 0x02331E10	; 02322478
pool_0232247C:
loc_0232247C:
	.word 0x02331E94	; 0232247C
pool_02322480:
loc_02322480:
	.word 0x023A60D4	; 02322480

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
	bl loc_0232D890	; 02322568
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
	.word 0x023C10D8	; 023227D4
pool_023227D8:
loc_023227D8:
	.word 0x023A57E4	; 023227D8
pool_023227DC:
loc_023227DC:
	.word P1_Data_0232FF8C	; 023227DC

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
	.word 0x023A6418	; 023228F8

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
	.word 0x02331D48	; 02322964

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
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02322988:
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
	bl loc_0232D890	; 023229B2
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
	.word 0x02331D48	; 023229FC

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
	.word 0x02331D50	; 02322A4C
pool_02322A50:
loc_02322A50:
	.word 0x023A6418	; 02322A50
pool_02322A54:
loc_02322A54:
	.word 0x02331D7C	; 02322A54
; P3 使用的 Thumb 尾调用入口。 / Thumb tail-call veneer used by P3.
.func P1_Function_02322A58
	ldr r3,[pool_02322A5C]	; 02322A58
	bx r3	; 02322A5A
.endfunc
pool_02322A5C:
	.word P1_Entry_0232242C + 1	; 02322A5C ; Thumb

; ===== function loc_02322A60 =====
loc_02322A60:
	push {lr}	; 02322A60
	sub sp,#0x4	; 02322A62
	ldr r0,[pool_02322A7C]	; 02322A64
	mov r1,#0x0	; 02322A66
	ldr r2,[pool_02322A80]	; 02322A68
	sub r2,r2,r0	; 02322A6A
	bl loc_0232DC14	; 02322A6C
	bl loc_02321E40	; 02322A70
	add sp,#0x4	; 02322A74
	pop {r3}	; 02322A76
	bx r3	; 02322A78
	.byte 0xC0, 0x46	; 02322A7C
pool_02322A7C:
loc_02322A7C:
	.word 0x023BC720	; 02322A7C
pool_02322A80:
loc_02322A80:
	.word 0x023BC920	; 02322A80

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
	bl P1_ComputeFixedPointReciprocal	; 02322B0A
	add r4,r0,#0x0	; 02322B0E
	ldr r0,[pool_02322C90]	; 02322B10
	bl P1_ComputeFixedPointReciprocal	; 02322B12
	add r1,r0,#0x0	; 02322B16
	add r0,sp,#0x20	; 02322B18
	add r2,r4,#0x0	; 02322B1A
	bl loc_0232D15C	; 02322B1C
	ldr r0,[sp,#0x48]	; 02322B20
	lsl r3,r0,#0x1	; 02322B22
	add r0,sp,#0x10	; 02322B24
	ldr r1,[pool_02322C94]	; 02322B26
	ldrsh r1,[r1,r3]	; 02322B28
	ldr r2,[pool_02322C98]	; 02322B2A
	ldrsh r2,[r2,r3]	; 02322B2C
	bl loc_0232D168	; 02322B2E
	add r0,sp,#0x20	; 02322B32
	add r1,sp,#0x10	; 02322B34
	add r2,sp,#0x30	; 02322B36
	bl loc_0232D174	; 02322B38
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
	bl P1_ComputeFixedPointReciprocal	; 02322B60
	add r4,r0,#0x0	; 02322B64
	ldr r0,[pool_02322C90]	; 02322B66
	bl P1_ComputeFixedPointReciprocal	; 02322B68
	add r1,r0,#0x0	; 02322B6C
	add r0,sp,#0x20	; 02322B6E
	add r2,r4,#0x0	; 02322B70
	bl loc_0232D15C	; 02322B72
	ldr r0,[sp,#0x44]	; 02322B76
	lsl r3,r0,#0x1	; 02322B78
	add r0,sp,#0x10	; 02322B7A
	ldr r1,[pool_02322C94]	; 02322B7C
	ldrsh r1,[r1,r3]	; 02322B7E
	ldr r2,[pool_02322C98]	; 02322B80
	ldrsh r2,[r2,r3]	; 02322B82
	bl loc_0232D168	; 02322B84
	add r0,sp,#0x20	; 02322B88
	add r1,sp,#0x10	; 02322B8A
	add r2,sp,#0x30	; 02322B8C
	bl loc_0232D174	; 02322B8E
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
	bl P1_ComputeFixedPointReciprocal	; 02322BB6
	add r4,r0,#0x0	; 02322BBA
	ldr r0,[pool_02322C90]	; 02322BBC
	bl P1_ComputeFixedPointReciprocal	; 02322BBE
	add r1,r0,#0x0	; 02322BC2
	add r0,sp,#0x20	; 02322BC4
	add r2,r4,#0x0	; 02322BC6
	bl loc_0232D15C	; 02322BC8
	lsl r3,r5,#0x1	; 02322BCC
	add r0,sp,#0x10	; 02322BCE
	ldr r1,[pool_02322C94]	; 02322BD0
	ldrsh r1,[r1,r3]	; 02322BD2
	ldr r2,[pool_02322C98]	; 02322BD4
	ldrsh r2,[r2,r3]	; 02322BD6
	bl loc_0232D168	; 02322BD8
	add r0,sp,#0x20	; 02322BDC
	add r1,sp,#0x10	; 02322BDE
	add r2,sp,#0x30	; 02322BE0
	bl loc_0232D174	; 02322BE2
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
	bl P1_ComputeFixedPointReciprocal	; 02322C26
	add r4,r0,#0x0	; 02322C2A
	ldr r0,[pool_02322C90]	; 02322C2C
	bl P1_ComputeFixedPointReciprocal	; 02322C2E
	add r1,r0,#0x0	; 02322C32
	add r0,sp,#0x20	; 02322C34
	add r2,r4,#0x0	; 02322C36
	bl loc_0232D15C	; 02322C38
	lsl r3,r5,#0x1	; 02322C3C
	add r0,sp,#0x10	; 02322C3E
	ldr r1,[pool_02322C94]	; 02322C40
	ldrsh r1,[r1,r3]	; 02322C42
	ldr r2,[pool_02322C98]	; 02322C44
	ldrsh r2,[r2,r3]	; 02322C46
	bl loc_0232D168	; 02322C48
	add r0,sp,#0x20	; 02322C4C
	add r1,sp,#0x10	; 02322C4E
	add r2,sp,#0x30	; 02322C50
	bl loc_0232D174	; 02322C52
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
	.word 0x023C10D8	; 02322C84
pool_02322C88:
loc_02322C88:
	.word 0x023A576C	; 02322C88
pool_02322C8C:
loc_02322C8C:
	.word 0x00009000	; 02322C8C
pool_02322C90:
loc_02322C90:
	.word 0x00001000	; 02322C90
pool_02322C94:
loc_02322C94:
	.word P1_Data_023304E0	; 02322C94
pool_02322C98:
loc_02322C98:
	.word P1_Data_02330558	; 02322C98
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
	bl loc_02328F6C	; 02322CD2
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
	bl loc_02328F6C	; 02322D10
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
	.word 0x02331F18	; 02322D54
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
	.word 0x023C10D8	; 02322DB0
pool_02322DB4:
loc_02322DB4:
	.word 0x023A576C	; 02322DB4

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
	.word 0x023B8520	; 02322E04

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
	blx loc_0232DDBC	; 02322E9A
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
	bl loc_02328F6C	; 02322EB6
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
	bl loc_023290DC	; 02322F30
	add r1,r0,#0x0	; 02322F34
	add r0,sp,#0x38	; 02322F36
	add r2,sp,#0x90	; 02322F38
	bl loc_0232905C	; 02322F3A
	mov r5,#0x0	; 02322F3E
	b loc_02322F8A	; 02322F40
loc_02322F42:
	ldr r0,[pool_023230BC]	; 02322F42
	add r1,r5,#0x1	; 02322F44
	bl loc_023290DC	; 02322F46
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
	bl loc_02328C0C	; 02322F84
	add r5,r5,#0x1	; 02322F88
loc_02322F8A:
	cmp r5,#0x7	; 02322F8A
	bcc loc_02322F42	; 02322F8C
	ldr r0,[pool_023230BC]	; 02322F8E
	mov r1,#0x1	; 02322F90
	bl loc_023290DC	; 02322F92
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
	bl loc_02328C0C	; 02323064
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
	.word 0x023305D0	; 0232309C
pool_023230A0:
loc_023230A0:
	.word 0x023305EC	; 023230A0
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
	.word 0x02330608	; 023230B0
pool_023230B4:
loc_023230B4:
	.word 0x02330618	; 023230B4
pool_023230B8:
loc_023230B8:
	.word 0x02330628	; 023230B8
pool_023230BC:
loc_023230BC:
	.word 0x023A637C	; 023230BC
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
	.word 0x02331F24	; 023230D4
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
	.word 0x02331F24	; 023230E4
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
	.word 0x02331F24	; 023230F4
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
	bl loc_0232F0EC	; 023231FE
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
	.word 0x02331F3C	; 023232C8
pool_023232CC:
loc_023232CC:
	.word 0x02331F68	; 023232CC
pool_023232D0:
loc_023232D0:
	.word 0x02331F94	; 023232D0
pool_023232D4:
loc_023232D4:
	.word 0x023C10D8	; 023232D4
pool_023232D8:
loc_023232D8:
	.word 0x023A576C	; 023232D8
pool_023232DC:
loc_023232DC:
	.word P1_Data_02330638	; 023232DC
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
	.word 0x02331F94	; 02323328
pool_0232332C:
loc_0232332C:
	.word 0x023A637C	; 0232332C
pool_02323330:
loc_02323330:
	.word 0x02331F3C	; 02323330
pool_02323334:
loc_02323334:
	.word 0x02331F68	; 02323334
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
	.word 0x02331F94	; 0232335C

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
	bl loc_023290DC	; 023233F4
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
	bl loc_0232DC14	; 02323414
loc_02323418:
	add sp,#0x1c	; 02323418
	pop {r4,r5}	; 0232341A
	pop {r3}	; 0232341C
	bx r3	; 0232341E
pool_02323420:
loc_02323420:
	.word 0x02331FD4	; 02323420
pool_02323424:
loc_02323424:
	.word 0x023A60D4	; 02323424
pool_02323428:
loc_02323428:
	.word 0x023BC920	; 02323428
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
	.word 0x0233063C	; 02323534
pool_02323538:
loc_02323538:
	.word 0x02331FD4	; 02323538
pool_0232353C:
loc_0232353C:
	.word P1_BssStart + 0x1888	; 0232353C
pool_02323540:
loc_02323540:
	.word 0x023C10D8	; 02323540
pool_02323544:
loc_02323544:
	.word 0x023A51CC	; 02323544

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
	blx loc_0232DE40	; 023235EE
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
	.word 0x02331FD4	; 0232362C
pool_02323630:
loc_02323630:
	.word 0x023A60D4	; 02323630

; ===== function loc_02323634 =====
loc_02323634:
	push {r4,r5,r6,lr}	; 02323634
	bl loc_0232E664	; 02323636
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
	bl loc_0232A184	; 02323658
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
	.byte 0x02, 0x21, 0x02, 0x48, 0x01, 0x60, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0x74, 0x22, 0x33, 0x02	; 023236CC
	.byte 0x69, 0x93, 0x32, 0x02	; 023236D0

; ===== function loc_023236D0 =====
loc_023236D0:
	push {lr}	; 023236D0
	sub sp,#0x4	; 023236D2
	bl loc_02329368	; 023236D4
	ldr r0,[pool_023236F4]	; 023236D8
	ldr r1,[pool_023236F8]	; 023236DA
	mov r2,#0x1	; 023236DC
	bl loc_02329388	; 023236DE
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
	.word 0x02332300	; 023236F4
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
	.word loc_0232A1AC + 1	; 02323708

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
	.word loc_0232ADB0 + 1	; 02323718
loc_0232371C:
	ldr r3,[pool_02323720]	; 0232371C
	bx r3	; 0232371E
pool_02323720:
loc_02323720:
	.word loc_0232A1A4 + 1	; 02323720

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
	.word 0x0233226C	; 02323730
pool_02323734:
loc_02323734:
	.word loc_0232ADB0 + 1	; 02323734

; ===== function loc_02323738 =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02323738:
loc_02323738:
	ldr r3,[pool_0232373C]	; 02323738
	bx r3	; 0232373A
pool_0232373C:
loc_0232373C:
	.word loc_02329CB8 + 1	; 0232373C

; ===== function loc_02323740 =====
loc_02323740:
	push {lr}	; 02323740
	sub sp,#0x4	; 02323742
	bl loc_02329CDC	; 02323744
	ldr r0,[pool_0232376C]	; 02323748
	ldr r1,[pool_02323770]	; 0232374A
	mov r2,#0x1	; 0232374C
	bl loc_02329388	; 0232374E
	ldr r0,[pool_02323774]	; 02323752
	ldr r1,[pool_02323778]	; 02323754
	bl loc_0232A9FC	; 02323756
	mov r0,#0x0	; 0232375A
	bl loc_0232AE18	; 0232375C
	ldr r0,[pool_0232377C]	; 02323760
	bl loc_0232A1A4	; 02323762
	add sp,#0x4	; 02323766
	pop {r3}	; 02323768
	bx r3	; 0232376A
pool_0232376C:
loc_0232376C:
	.word 0x02332300	; 0232376C
pool_02323770:
loc_02323770:
	.word 0x00001000	; 02323770
pool_02323774:
loc_02323774:
	.word 0x02332278	; 02323774
pool_02323778:
loc_02323778:
	.word 0x023AB9D8	; 02323778
pool_0232377C:
loc_0232377C:
	.word 0x0233226C	; 0232377C

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
	bl loc_023290F4	; 02323CFE
	add r6,r0,#0x0	; 02323D02
	mov r1,sp	; 02323D04
	sub r1,r1,#0x4	; 02323D06
	ldrh r0,[r4,r7]	; 02323D08
	strh r0,[r1,#0x0]	; 02323D0A
	ldmia r1!,{r0}	; 02323D0C
	ldrb r1,[r6,#0x0]	; 02323D0E
	bl loc_02329024	; 02323D10
	ldr r1,[sp,#0x30]	; 02323D14
	add r0,r1,r0	; 02323D16
	str r0,[sp,#0x30]	; 02323D18
	mov r1,sp	; 02323D1A
	sub r1,r1,#0x4	; 02323D1C
	ldrh r0,[r5,#0x2]	; 02323D1E
	strh r0,[r1,#0x0]	; 02323D20
	ldmia r1!,{r0}	; 02323D22
	ldrb r1,[r6,#0x1]	; 02323D24
	bl loc_02328FEC	; 02323D26
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
	bl loc_02329124	; 02323D6E
	str r0,[sp,#0x8]	; 02323D72
	add r0,r5,#0x0	; 02323D74
	ldr r1,[sp,#0x34]	; 02323D76
	bl loc_0232910C	; 02323D78
	add r7,r0,#0x0	; 02323D7C
	add r0,r5,#0x0	; 02323D7E
	ldr r1,[sp,#0x34]	; 02323D80
	bl loc_023290F4	; 02323D82
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
	.word 0x02333930	; 02323E80

; ===== function loc_02323E84 =====
loc_02323E84:
	ldr r0,[pool_02323E88]	; 02323E84
	bx lr	; 02323E86
pool_02323E88:
loc_02323E88:
	.word 0x02333300	; 02323E88

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
	bl loc_0232DBC4	; 02323E9E
	ldr r0,[pool_02323EC0]	; 02323EA2
	mov r1,#0x0	; 02323EA4
	ldr r2,[pool_02323EBC]	; 02323EA6
	bl loc_0232DB9C	; 02323EA8
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
	.word 0x02333300	; 02323EB8
pool_02323EBC:
loc_02323EBC:
	.word 0x00000400	; 02323EBC
pool_02323EC0:
loc_02323EC0:
	.word 0x02333930	; 02323EC0

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
	blx loc_0232DDBC	; 02323EDE
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
	blx loc_0232DDBC	; 02323EF8
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
	bl P1_SwiVBlankIntrWait	; 02323F68
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
	.word 0x02333300	; 02323F78
pool_02323F7C:
loc_02323F7C:
	.word P1_BssStart + 0x3540	; 02323F7C
pool_02323F80:
loc_02323F80:
	.word 0x02333930	; 02323F80
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
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02323FA4:
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
	bl loc_02329104	; 02323FEA
	add r6,r0,#0x0	; 02323FEE
	add r0,r4,#0x0	; 02323FF0
	bl loc_02329100	; 02323FF2
	add r2,r0,#0x0	; 02323FF6
	add r0,r6,#0x0	; 02323FF8
	ldr r1,[pool_02324048]	; 02323FFA
	ldr r1,[r5,r1]	; 02323FFC
	bl loc_0232DB74	; 02323FFE
	b loc_0232401E	; 02324002
loc_02324004:
	add r0,r4,#0x0	; 02324004
	bl loc_02329104	; 02324006
	add r6,r0,#0x0	; 0232400A
	add r0,r4,#0x0	; 0232400C
	bl loc_02329100	; 0232400E
	add r2,r0,#0x0	; 02324012
	add r0,r6,#0x0	; 02324014
	ldr r1,[pool_02324048]	; 02324016
	ldr r1,[r5,r1]	; 02324018
	bl loc_0232DB4C	; 0232401A
loc_0232401E:
	add r0,r4,#0x0	; 0232401E
	bl loc_02329100	; 02324020
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
	.word 0x02333300	; 02324050

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
	.byte 0x81, 0x80, 0x01, 0x89, 0x91, 0x43, 0x01, 0x81, 0x70, 0x47, 0xC0, 0x46, 0x64, 0x3F, 0x33, 0x02	; 023240B0
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
	.byte 0x02, 0x49, 0x09, 0x89, 0x01, 0x40, 0x08, 0x1C, 0x70, 0x47, 0xC0, 0x46, 0x64, 0x3F, 0x33, 0x02	; 0232413C

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
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_0232415C:
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
	bl loc_0232ED08	; 023241AA
	add r0,r4,#0x0	; 023241AE
	bl loc_0232ECD4	; 023241B0
	cmp r0,#0x0	; 023241B4
	bne loc_023241AA	; 023241B6
	add r0,sp,#0x8	; 023241B8
	add r1,sp,#0x0	; 023241BA
	bl loc_0232EA60	; 023241BC
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
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_0232425C:
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
	blx loc_0232DDBC	; 02324282
	add sp,#0x4	; 02324286
	pop {r3}	; 02324288
	bx r3	; 0232428A
pool_0232428C:
loc_0232428C:
	.word 0x02333F64	; 0232428C

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
	bl loc_02329134	; 02324392
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
	bl loc_02329134	; 023243C4
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
	bl loc_02329134	; 023243F4
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
	.word 0x02333F8C	; 023245A0

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
	bl loc_0232DAFC	; 023245D2
	b loc_023245FA	; 023245D6
loc_023245D8:
	ldr r0,[pool_02324600]	; 023245D8
	mov r1,#0x0	; 023245DA
	ldr r2,[pool_02324604]	; 023245DC
	bl loc_0232DAAC	; 023245DE
	b loc_023245FA	; 023245E2
loc_023245E4:
	ldr r0,[pool_02324600]	; 023245E4
	mov r1,#0x0	; 023245E6
	ldr r2,[pool_02324604]	; 023245E8
	bl loc_0232DA5C	; 023245EA
	b loc_023245FA	; 023245EE
loc_023245F0:
	ldr r0,[pool_02324600]	; 023245F0
	mov r1,#0x0	; 023245F2
	ldr r2,[pool_02324604]	; 023245F4
	bl loc_0232DA0C	; 023245F6
loc_023245FA:
	add sp,#0x4	; 023245FA
	pop {r3}	; 023245FC
	bx r3	; 023245FE
pool_02324600:
loc_02324600:
	.word 0x02333F8C	; 02324600
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
	blx loc_0232DDBC	; 02324616
	ldr r0,[pool_02324628]	; 0232461A
	ldr r1,[pool_0232462C]	; 0232461C
	blx P1_CleanDataCacheRange	; 0232461E
	add sp,#0x4	; 02324622
	pop {r3}	; 02324624
	bx r3	; 02324626
pool_02324628:
loc_02324628:
	.word 0x02333F8C	; 02324628
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
	bl loc_023290DC	; 02324658
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
	bl loc_023290DC	; 023246B6
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
	bl loc_023295B4	; 023246DC
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
	.word P1_Data_02330648	; 0232477C
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
	bl loc_023290DC	; 023247B6
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
	blx loc_0232DDBC	; 023247D2
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
	bl loc_02328F6C	; 023247EE
	ldr r0,[sp,#0x10]	; 023247F2
	ldr r1,[sp,#0x14]	; 023247F4
	bl loc_023290DC	; 023247F6
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
	bl loc_02328C0C	; 02324890
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
	bl loc_023290DC	; 023248B8
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
	bl loc_02328B5C	; 023248D2
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
	bl loc_02328B3C	; 023248EC
	str r0,[r6,#0x0]	; 023248F0
	mov r1,sp	; 023248F2
	sub r1,r1,#0x4	; 023248F4
	ldrh r0,[r4,#0x0]	; 023248F6
	strh r0,[r1,#0x0]	; 023248F8
	ldmia r1!,{r0}	; 023248FA
	ldr r1,[r5,#0x0]	; 023248FC
	bl loc_02329024	; 023248FE
	str r0,[r7,#0x0]	; 02324902
	mov r1,sp	; 02324904
	sub r1,r1,#0x4	; 02324906
	ldrh r0,[r4,#0x2]	; 02324908
	strh r0,[r1,#0x0]	; 0232490A
	ldmia r1!,{r0}	; 0232490C
	ldr r1,[r6,#0x0]	; 0232490E
	bl loc_02328FEC	; 02324910
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
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02324A80:
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
	bl loc_023294E4	; 02324A9E
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
	bl loc_0232DB74	; 02324AFA
	b loc_02324B0C	; 02324AFE
loc_02324B00:
	ldr r0,[r1,#0x14]	; 02324B00
	add r0,r0,r4	; 02324B02
	add r1,r6,#0x0	; 02324B04
	add r2,r7,#0x0	; 02324B06
	bl loc_0232DB4C	; 02324B08
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
	bl loc_02329608	; 02324C36
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
	blx loc_0232DDBC	; 02324C58
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
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02324C6C:
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
	.word 0x023445BC	; 02324C80
pool_02324C84:
loc_02324C84:
	.word 0x023345A4	; 02324C84

; ===== function loc_02324C88 =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02324C88:
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
	.word 0x023345BC	; 02324C98

; ===== function loc_02324C9C =====
loc_02324C9C:
	ldr r0,[pool_02324CA0]	; 02324C9C
	bx lr	; 02324C9E
pool_02324CA0:
loc_02324CA0:
	.word 0x023545DC	; 02324CA0
P1_Entry_02324CA4:
	ldr r0,[pool_02324CA8]	; 02324CA4
	bx lr	; 02324CA6
pool_02324CA8:
	.word 0x023545BC	; 02324CA8

; ===== function loc_02324CAC =====
loc_02324CAC:
	ldr r0,[pool_02324CB0]	; 02324CAC
	bx lr	; 02324CAE
pool_02324CB0:
loc_02324CB0:
	.word 0x023545BC	; 02324CB0

; ===== function loc_02324CB4 =====
loc_02324CB4:
	push {r4,r5,r6,lr}	; 02324CB4
	ldr r0,[pool_02324CFC]	; 02324CB6
	ldr r1,[pool_02324D00]	; 02324CB8
	ldr r2,[pool_02324D04]	; 02324CBA
	bl loc_02328F7C	; 02324CBC
	ldr r0,[pool_02324D08]	; 02324CC0
	ldr r1,[pool_02324D0C]	; 02324CC2
	ldr r2,[pool_02324D10]	; 02324CC4
	bl loc_02328F7C	; 02324CC6
	ldr r0,[pool_02324D14]	; 02324CCA
	ldr r1,[pool_02324D18]	; 02324CCC
	ldr r2,[pool_02324D1C]	; 02324CCE
	bl loc_02328F7C	; 02324CD0
	ldr r0,[pool_02324D20]	; 02324CD4
	ldr r1,[pool_02324D24]	; 02324CD6
	ldr r2,[pool_02324D28]	; 02324CD8
	bl loc_02328F7C	; 02324CDA
	mov r5,#0x0	; 02324CDE
	ldr r4,[pool_02324CFC]	; 02324CE0
	ldr r6,[pool_02324D2C]	; 02324CE2
	b loc_02324CF2	; 02324CE4
loc_02324CE6:
	lsl r0,r5,#0x5	; 02324CE6
	add r0,r4,r0	; 02324CE8
	ldrh r1,[r6,#0x0]	; 02324CEA
	bl loc_02328B08	; 02324CEC
	add r5,r5,#0x1	; 02324CF0
loc_02324CF2:
	cmp r5,#0x4	; 02324CF2
	bcc loc_02324CE6	; 02324CF4
	pop {r4,r5,r6}	; 02324CF6
	pop {r3}	; 02324CF8
	bx r3	; 02324CFA
pool_02324CFC:
loc_02324CFC:
	.word 0x023545BC	; 02324CFC
pool_02324D00:
loc_02324D00:
	.word 0x023A802C	; 02324D00
pool_02324D04:
loc_02324D04:
	.word 0x023A76A4	; 02324D04
pool_02324D08:
loc_02324D08:
	.word 0x023545DC	; 02324D08
pool_02324D0C:
loc_02324D0C:
	.word 0x023AA478	; 02324D0C
pool_02324D10:
loc_02324D10:
	.word 0x023A7880	; 02324D10
pool_02324D14:
loc_02324D14:
	.word 0x023545FC	; 02324D14
pool_02324D18:
loc_02324D18:
	.word 0x023A7F1C	; 02324D18
pool_02324D1C:
loc_02324D1C:
	.word 0x023A7658	; 02324D1C
pool_02324D20:
loc_02324D20:
	.word 0x0235461C	; 02324D20
pool_02324D24:
loc_02324D24:
	.word 0x023A7988	; 02324D24
pool_02324D28:
loc_02324D28:
	.word 0x023A75E4	; 02324D28
pool_02324D2C:
loc_02324D2C:
	.word 0x0233064C	; 02324D2C
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
	.word 0x02354670	; 02324DD0

; ===== function loc_02324DD4 =====
loc_02324DD4:
	lsl r1,r0,#0x1	; 02324DD4
	ldr r0,[pool_02324DDC]	; 02324DD6
	ldrh r0,[r0,r1]	; 02324DD8
	bx lr	; 02324DDA
pool_02324DDC:
loc_02324DDC:
	.word P1_Data_02330668	; 02324DDC

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
	.word 0x02330650	; 02324E3C
pool_02324E40:
loc_02324E40:
	.word 0x02354640	; 02324E40
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
	.byte 0x01, 0x48, 0xC0, 0x69, 0x70, 0x47, 0xC0, 0x46, 0x70, 0x4A, 0x35, 0x02	; 02324E90
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
	.word 0x02354AD0	; 02324EBC
pool_02324EC0:
	.word 0x023A5AE4	; 02324EC0
pool_02324EC4:
	.word 0x02354AFC	; 02324EC4
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
	.word 0x02354A98	; 02324F70
pool_02324F74:
	.word 0x023A4A7C	; 02324F74

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
	.word 0x02354AA4	; 023250A0

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
	.word 0x02354AA4	; 023250C0
pool_023250C4:
loc_023250C4:
	.word 0x023A5AE4	; 023250C4
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
	.word 0x023C10D8	; 023251E4
pool_023251E8:
loc_023251E8:
	.word 0x023A4FBC	; 023251E8
pool_023251EC:
loc_023251EC:
	.word 0x02354AD0	; 023251EC
pool_023251F0:
loc_023251F0:
	.word 0x02354AFC	; 023251F0
pool_023251F4:
loc_023251F4:
	.word 0x02354A98	; 023251F4
pool_023251F8:
loc_023251F8:
	.word 0x02354AA4	; 023251F8

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
	.word 0x02354AA4	; 0232523C
pool_02325240:
loc_02325240:
	.word 0x023A5AE4	; 02325240
pool_02325244:
loc_02325244:
	.word 0x02354AD0	; 02325244
pool_02325248:
loc_02325248:
	.word 0x02354AFC	; 02325248

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
	.word 0x02354A98	; 02325274
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
	blx loc_0232DDBC	; 0232529C
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
	.word P1_Data_023300B0	; 023252EC

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
	.byte 0x01, 0xD1, 0x01, 0x20, 0x70, 0x47, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0x28, 0x4B, 0x35, 0x02	; 02325334
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
	.word P1_Data_023300B4	; 02325364
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
	.word P1_Data_023300B4	; 02325388
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
	.word P1_Data_023300B4	; 023253AC
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
	.word P1_Data_023300B4	; 023253D0

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
	.word 0x02354B40	; 0232544C
pool_02325450:
loc_02325450:
	.word P1_Data_023300B4	; 02325450
pool_02325454:
loc_02325454:
	.word P1_BssStart + 0x24168	; 02325454
pool_02325458:
loc_02325458:
	.word 0x02354B34	; 02325458
pool_0232545C:
loc_0232545C:
	.word P1_Data_023300C0	; 0232545C
pool_02325460:
loc_02325460:
	.word P1_Data_023300C2	; 02325460
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
	.word 0x02354B40	; 0232552C
pool_02325530:
loc_02325530:
	.word P1_Data_023300B4	; 02325530
pool_02325534:
loc_02325534:
	.word 0x023A5A2C	; 02325534
pool_02325538:
loc_02325538:
	.word 0x02354B34	; 02325538
pool_0232553C:
loc_0232553C:
	.word 0x023A4A34	; 0232553C

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
	.word 0x02354B40	; 023255EC
pool_023255F0:
loc_023255F0:
	.word P1_BssStart + 0x24168	; 023255F0
pool_023255F4:
loc_023255F4:
	.word 0x02354B34	; 023255F4
pool_023255F8:
loc_023255F8:
	.word P1_Data_023300BC	; 023255F8
pool_023255FC:
loc_023255FC:
	.word 0x023C10D8	; 023255FC
pool_02325600:
loc_02325600:
	.word 0x023A4F1C	; 02325600

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
	.word 0x023A5A2C	; 02325648
pool_0232564C:
loc_0232564C:
	.word 0x023300BC	; 0232564C

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
	.word 0x02354B40	; 023256C0
pool_023256C4:
loc_023256C4:
	.word P1_Data_023300B4	; 023256C4
pool_023256C8:
loc_023256C8:
	.word P1_BssStart + 0x24168	; 023256C8
pool_023256CC:
loc_023256CC:
	.word 0x02354B34	; 023256CC

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
	bl loc_02328F6C	; 02325758
	ldr r0,[pool_02325770]	; 0232575C
	add r1,r5,#0x0	; 0232575E
	bl loc_023290A4	; 02325760
	add sp,#0x8	; 02325764
	pop {r4,r5,r6}	; 02325766
	pop {r3}	; 02325768
	bx r3	; 0232576A
pool_0232576C:
loc_0232576C:
	.word 0x00000300	; 0232576C
pool_02325770:
loc_02325770:
	.word 0x02354BC0	; 02325770
pool_02325774:
loc_02325774:
	.word 0x00000100	; 02325774

; ===== function loc_02325778 =====
; 返回固件 UI/启动共享上下文的固定地址。
; Returns the fixed firmware UI/boot shared-context address.
.func P1_GetFirmwareUiContext
loc_02325778:
	ldr r0,[pool_0232577C]	; 02325778
	bx lr	; 0232577A
.endfunc
pool_0232577C:
loc_0232577C:
	.word 0x02354BD0	; 0232577C

; ===== function loc_02325780 =====
; 初始化共享上下文的已知首批字段。
; Initializes the first known fields of the shared context.
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
	bl P1_SwiVBlankIntrWait	; 02325836
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
	.word P1_Data_023300CC	; 02325A60

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
	.word P1_Data_023300CC	; 02325AA0

; ===== function loc_02325AA4 =====
loc_02325AA4:
	push {r4,r5,r6,r7,lr}	; 02325AA4
	sub sp,#0x1fc	; 02325AA6
	sub sp,#0x10	; 02325AA8
	add r5,r0,#0x0	; 02325AAA
	mov r4,#0x0	; 02325AAC
	add r0,sp,#0x8	; 02325AAE
	ldr r1,[pool_02325B10]	; 02325AB0
	bl loc_0232D114	; 02325AB2
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
	bl loc_0232D8AC	; 02325B34
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
	bl loc_0232D8AC	; 02325BBA
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
	bl loc_0232D8AC	; 02325C78
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
	.word 0x023A5B24	; 02325DF8

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
	.word 0x023A5B24	; 02325EA4

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
	bl loc_0232D8AC	; 02325EC6
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
	bl loc_0232D8AC	; 02325F5C
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
	bl loc_0232C688	; 02326056
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
	.word 0x023A5B24	; 02326090

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
	bl loc_0232D114	; 023260DC
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
	bl loc_0232F140	; 023261BA
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
	bl loc_0232F140	; 023261F8
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
	.word 0x023307B0	; 023262C4
pool_023262C8:
loc_023262C8:
	.word 0x023307BC	; 023262C8
pool_023262CC:
loc_023262CC:
	.word 0x023307CC	; 023262CC

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
	.word 0x023307D8	; 02326324
pool_02326328:
loc_02326328:
	.word 0x023307F0	; 02326328
pool_0232632C:
loc_0232632C:
	.word 0x02330808	; 0232632C
pool_02326330:
loc_02326330:
	.word 0x02330820	; 02326330

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
	.byte 0x07, 0xF0, 0x8E, 0xEC, 0x00, 0x22, 0x04, 0x48, 0x34, 0x30, 0x00, 0x78, 0x41, 0x00, 0x03, 0x48	; 02326454
	.byte 0x42, 0x52, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x9C, 0xFC, 0x7F, 0x02, 0xF0, 0x4B, 0x35, 0x02	; 02326464

; ===== function loc_02326474 =====
loc_02326474:
	push {lr}	; 02326474
	sub sp,#0x4	; 02326476
	ldr r0,[pool_02326498]	; 02326478
	ldr r1,[pool_0232649C]	; 0232647A
	ldrb r2,[r0,#0x14]	; 0232647C
	lsl r2,r2,#0x1	; 0232647E
	blx loc_0232DD74	; 02326480
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
	.word 0x02354C28	; 0232651C
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
	bl loc_02328590	; 02326540
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
	bl loc_0232DB74	; 0232655E
	add r5,r5,#0x1	; 02326562
	cmp r5,#0x1a	; 02326564
	blt loc_02326554	; 02326566
	ldr r0,[pool_023265D0]	; 02326568
	ldr r1,[pool_023265D4]	; 0232656A
	mov r2,#0x2	; 0232656C
	bl loc_0232DC14	; 0232656E
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
	.word 0x02354C28	; 023265C0
pool_023265C4:
loc_023265C4:
	.word 0x02354FC8	; 023265C4
pool_023265C8:
loc_023265C8:
	.word 0x000003A0	; 023265C8
pool_023265CC:
loc_023265CC:
	.word 0x0001D000	; 023265CC
pool_023265D0:
loc_023265D0:
	.word 0x023300E0	; 023265D0
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
	.byte 0x01, 0x49, 0x08, 0x60, 0x70, 0x47, 0xC0, 0x46, 0xA4, 0x57, 0x35, 0x02, 0x01, 0x49, 0x08, 0x60	; 02326604
	.byte 0x70, 0x47, 0xC0, 0x46, 0xA0, 0x57, 0x35, 0x02	; 0232660C

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
	bl loc_0232FB30	; 0232669C
	mov r0,#0x0	; 023266A0
	ldr r1,[pool_023266C4]	; 023266A2
	bl loc_0232FA98	; 023266A4
	mov r0,#0x0	; 023266A8
	ldr r1,[pool_023266C0]	; 023266AA
	bl loc_0232F9EC	; 023266AC
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
	bl loc_02329C8C	; 02326766
	ldr r0,[pool_023268D0]	; 0232676A
	ldr r0,[r0,#0x0]	; 0232676C
	cmp r0,#0x0	; 0232676E
	beq loc_02326774	; 02326770
	blx r0	; 02326772
loc_02326774:
	bl loc_02327B58	; 02326774
	mov r0,#0x1	; 02326778
	add r1,r0,#0x0	; 0232677A
	blx loc_0232AF1C	; 0232677C
	bl loc_0232696C	; 02326780
	bl loc_0232D400	; 02326784
	ldr r2,[pool_023268D4]	; 02326788
	ldr r1,[r2,#0x0]	; 0232678A
	ldr r0,[pool_023268D8]	; 0232678C
	and r1,r0	; 0232678E
	str r1,[r2,#0x0]	; 02326790
	mov r0,#0x1	; 02326792
	add r1,r0,#0x0	; 02326794
	blx loc_0232AF1C	; 02326796
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
	bl loc_0232F004	; 023267B4
	mov r0,#0x1	; 023267B8
	add r1,r0,#0x0	; 023267BA
	blx loc_0232AF1C	; 023267BC
	mov r0,#0x1	; 023267C0
	add r1,r0,#0x0	; 023267C2
	blx loc_0232AF1C	; 023267C4
	bl loc_0232D3C0	; 023267C8
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
	bl loc_0232F140	; 0232680A
loc_0232680E:
	ldr r0,[pool_023268BC]	; 0232680E
	ldr r1,[r0,#0x0]	; 02326810
	mov r0,#0x40	; 02326812
	and r1,r0	; 02326814
	cmp r1,#0x40	; 02326816
	bne loc_02326862	; 02326818
	bl loc_02327B78	; 0232681A
	bl loc_02327B58	; 0232681E
	bl loc_02327B78	; 02326822
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
	bl loc_0232C61C	; 0232683C
	cmp r0,#0x0	; 02326840
	beq loc_02326848	; 02326842
loc_02326844:
	bl loc_0232F110	; 02326844
loc_02326848:
	ldr r0,[pool_023268E4]	; 02326848
	ldr r0,[r0,#0x0]	; 0232684A
	cmp r0,#0x0	; 0232684C
	beq loc_02326852	; 0232684E
	blx r0	; 02326850
loc_02326852:
	bl loc_02329C84	; 02326852
	ldr r1,[pool_023268BC]	; 02326856
	ldr r2,[r1,#0x0]	; 02326858
	mov r0,#0x40	; 0232685A
	bic r2,r0	; 0232685C
	str r2,[r1,#0x0]	; 0232685E
	b loc_023268AE	; 02326860
loc_02326862:
	bl loc_02327B78	; 02326862
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
	bl loc_0232C61C	; 0232687C
	cmp r0,#0x0	; 02326880
	beq loc_02326898	; 02326882
loc_02326884:
	bl loc_02329C8C	; 02326884
	ldr r0,[pool_023268D0]	; 02326888
	ldr r0,[r0,#0x0]	; 0232688A
	cmp r0,#0x0	; 0232688C
	beq loc_02326892	; 0232688E
	blx r0	; 02326890
loc_02326892:
	bl loc_0232C47C	; 02326892
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
	bl loc_0232FA98	; 02326902
	mov r0,#0x1	; 02326906
	ldr r1,[pool_02326920]	; 02326908
	bl loc_0232FA98	; 0232690A
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
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02326924:
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
	.word loc_023293F0 + 1	; 02326968

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
	.word loc_023293F0 + 1	; 02326980

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
	bl loc_023293F0	; 02326A00
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
	bl loc_023293F0	; 02326A34
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
	.word P1_Data_023300E4	; 02326A44

; ===== function loc_02326A48 =====
loc_02326A48:
	push {lr}	; 02326A48
	sub sp,#0x4	; 02326A4A
	ldr r0,[pool_02326A60]	; 02326A4C
	mov r1,#0x0	; 02326A4E
	mov r2,#0xc	; 02326A50
	blx loc_0232DE40	; 02326A52
	bl loc_0232943C	; 02326A56
	add sp,#0x4	; 02326A5A
	pop {r3}	; 02326A5C
	bx r3	; 02326A5E
pool_02326A60:
loc_02326A60:
	.word 0x023557BC	; 02326A60

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
	.word 0x023557D4	; 02326A7C

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
	.word 0x023557C8	; 02326A98

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
	bl loc_0232FC60	; 02326AB4
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
	.word P1_Data_02330838	; 02326B80
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
	bl loc_0232D698	; 02326D16
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
	bl loc_0232D698	; 02326D42
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
	bl loc_0232D698	; 02326D6E
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
	bl loc_0232D698	; 02326D9A
	pop {r4}	; 02326D9E
	pop {r3}	; 02326DA0
	bx r3	; 02326DA2
pool_02326DA4:
loc_02326DA4:
	.word P1_BssStart + 0x266B0	; 02326DA4
pool_02326DA8:
loc_02326DA8:
	.word VRAM_A_CR	; 02326DA8

; 解压 P3/P4 后合计 CRC16，并与固件头中的记录值比较。
; Decompresses P3/P4, accumulates CRC16, then compares the firmware-header value.
P1_ValidateP3P4Crc16:
loc_02326DAC:
	push {r4,r5,lr}	; 02326DAC
	sub sp,#0x4	; 02326DAE
	ldr r0,[pool_02326E04]	; 02326DB0
	ldr r1,[pool_02326E08]	; 02326DB2
	blx loc_023285D4	; 02326DB4
	add r5,r0,#0x0	; 02326DB8
	ldr r1,[pool_02326E0C]	; 02326DBA
	ldr r0,[r1,#0xc]	; 02326DBC
	ldr r1,[r1,#0x10]	; 02326DBE
	blx loc_023285D4	; 02326DC0
	add r4,r0,#0x0	; 02326DC4
	ldr r0,[pool_02326E10]	; 02326DC6
	ldr r1,[pool_02326E04]	; 02326DC8
	add r2,r5,#0x0	; 02326DCA
	bl loc_0232C726	; 02326DCC
	ldr r1,[pool_02326E0C]	; 02326DD0
	ldr r1,[r1,#0xc]	; 02326DD2
	add r2,r4,#0x0	; 02326DD4
	bl loc_0232C726	; 02326DD6
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
	.word 0x02358D00	; 02326E04
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

; 解压 P5、计算 CRC16，并按结果更新启动状态。
; Decompresses P5, calculates CRC16, and updates boot state from the result.
P1_ValidateP5Crc16:
loc_02326E1C:
	push {r4,lr}	; 02326E1C
	ldr r0,[pool_02326E4C]	; 02326E1E
	ldr r1,[pool_02326E50]	; 02326E20
	blx loc_023285D4	; 02326E22
	add r2,r0,#0x0	; 02326E26
	ldr r0,[pool_02326E54]	; 02326E28
	ldr r1,[pool_02326E4C]	; 02326E2A
	bl loc_0232C726	; 02326E2C
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
	.word 0x023A4960	; 02326E4C
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
	blx loc_0232DE08	; 02326E6A
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
	bl loc_0232B30C	; 02326EA4
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
	bl loc_0232DCD8	; 02326EE6
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
	bl loc_0232B1A4	; 02326F18
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
	.word 0x02355800	; 02326F50
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
	.word 0x02355880	; 02326F64
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
	.word loc_0232E808 + 1	; 02326FE8

; ===== function loc_02326FEC =====
loc_02326FEC:
	push {lr}	; 02326FEC
	sub sp,#0x4	; 02326FEE
	ldr r0,[pool_02327004]	; 02326FF0
	ldrb r1,[r0,#0x0]	; 02326FF2
	add r0,sp,#0x0	; 02326FF4
	strb r1,[r0,#0x0]	; 02326FF6
	add r0,sp,#0x0	; 02326FF8
	bl loc_0232FB3C	; 02326FFA
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
	bl loc_0232EB28	; 02327038
	add r0,sp,#0x14	; 0232703C
	bl loc_0232ED70	; 0232703E
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
	blx loc_0232B1B4	; 0232708C
	add r4,r0,#0x0	; 02327090
	cmp r4,#0x0	; 02327092
	beq loc_023270C2	; 02327094
	lsl r0,r4,#0x10	; 02327096
	lsr r0,r0,#0x10	; 02327098
	bl loc_0232B2A0	; 0232709A
	add r0,r5,#0x0	; 0232709E
	ldr r1,[pool_023270FC]	; 023270A0
	blx P1_CleanAndInvalidateDataCacheRange	; 023270A2
	ldr r0,[pool_023270F4]	; 023270A6
	ldr r0,[r0,#0x0]	; 023270A8
	add r1,r5,#0x0	; 023270AA
	ldr r2,[pool_023270FC]	; 023270AC
	bl loc_02327AB8	; 023270AE
	lsl r0,r4,#0x10	; 023270B2
	lsr r0,r0,#0x10	; 023270B4
	bl loc_0232B1AC	; 023270B6
	lsl r0,r4,#0x10	; 023270BA
	lsr r0,r0,#0x10	; 023270BC
	blx loc_0232B20C	; 023270BE
loc_023270C2:
	ldr r0,[pool_02327100]	; 023270C2
	add r1,r5,#0x0	; 023270C4
	add r1,#0x20	; 023270C6
	ldr r2,[pool_02327104]	; 023270C8
	bl loc_0232C726	; 023270CA
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
	.word 0x023558C0	; 023270F0
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
	blx loc_0232DD74	; 02327122
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
	.word 0x023558C0	; 02327134
pool_02327138:
loc_02327138:
	.word 0x00000840	; 02327138

; ===== function loc_0232713C =====
loc_0232713C:
	push {lr}	; 0232713C
	sub sp,#0x4	; 0232713E
	ldr r0,[pool_023271B0]	; 02327140
	bl loc_02328328	; 02327142
	ldr r1,[pool_023271B4]	; 02327146
	str r0,[r1,#0x0]	; 02327148
	ldr r0,[r1,#0x0]	; 0232714A
	cmp r0,#0x0	; 0232714C
	beq loc_02327182	; 0232714E
	mov r0,#0x0	; 02327150
	str r0,[sp,#0x0]	; 02327152
	add r0,sp,#0x0	; 02327154
	ldr r1,[pool_023271B0]	; 02327156
	ldr r2,[pool_023271B8]	; 02327158
	bl loc_0232C71E	; 0232715A
	ldr r0,[pool_023271BC]	; 0232715E
	ldrh r2,[r0,#0x0]	; 02327160
	ldr r1,[pool_023271C0]	; 02327162
	orr r2,r1	; 02327164
	strh r2,[r0,#0x0]	; 02327166
	mov r2,#0x5	; 02327168
	ldr r1,[pool_023271B0]	; 0232716A
	strb r2,[r1,#0x0]	; 0232716C
	ldrh r2,[r0,#0x0]	; 0232716E
	mov r1,#0x7	; 02327170
	bic r2,r1	; 02327172
	mov r1,#0x1	; 02327174
	orr r2,r1	; 02327176
	strh r2,[r0,#0x0]	; 02327178
	ldr r0,[pool_023271C4]	; 0232717A
	strb r1,[r0,#0x0]	; 0232717C
	ldr r0,[pool_023271C8]	; 0232717E
	strb r1,[r0,#0x0]	; 02327180
loc_02327182:
	ldr r0,[pool_023271CC]	; 02327182
	ldrb r1,[r0,#0x0]	; 02327184
	mov r0,#0x1	; 02327186
	and r1,r0	; 02327188
	cmp r1,#0x0	; 0232718A
	beq loc_023271AA	; 0232718C
	ldr r2,[pool_023271BC]	; 0232718E
	ldrh r1,[r2,#0x0]	; 02327190
	ldr r0,[pool_023271D0]	; 02327192
	and r1,r0	; 02327194
	strh r1,[r2,#0x0]	; 02327196
	mov r1,#0x0	; 02327198
	ldr r0,[pool_023271D4]	; 0232719A
	str r1,[r0,#0x0]	; 0232719C
	str r1,[r0,#0x4]	; 0232719E
	ldr r0,[pool_023271D8]	; 023271A0
	strb r1,[r0,#0x0]	; 023271A2
	ldr r0,[pool_023271B0]	; 023271A4
	bl loc_023281FC	; 023271A6
loc_023271AA:
	add sp,#0x4	; 023271AA
	pop {r3}	; 023271AC
	bx r3	; 023271AE
pool_023271B0:
loc_023271B0:
	.word FirmwareUserSettingsSharedAddress	; 023271B0
pool_023271B4:
loc_023271B4:
	.word 0x027FF864	; 023271B4
pool_023271B8:
loc_023271B8:
	.word 0x0100001C	; 023271B8
pool_023271BC:
loc_023271BC:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023271BC
pool_023271C0:
loc_023271C0:
	.word 0x00000200	; 023271C0
pool_023271C4:
loc_023271C4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 023271C4
pool_023271C8:
loc_023271C8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthDayOffset	; 023271C8
pool_023271CC:
loc_023271CC:
	.word 0x027FF818	; 023271CC
pool_023271D0:
loc_023271D0:
	.word 0xFFFFBFFF	; 023271D0
pool_023271D4:
loc_023271D4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsRtcOffset	; 023271D4
pool_023271D8:
loc_023271D8:
	.word FirmwareUserSettingsSharedAddress + 0x66	; 023271D8
.arm
; 此段随后覆盖复制至 ITCM；运行入口不是 CRT 初始内容。
; This stub later replaces ITCM contents; its entry is not the CRT image.
P1_TransitionCopySource:
.func P1_TransitionLoadEntry
	ldr r0,[pool_02327220]	; 023271DC
	mov r1,#0x9	; 023271E0
	str r1,[r0,#0x0]	; 023271E4
	ldr r1,[pool_02327224]	; 023271E8
	b loc_023271F8	; 023271EC
loc_023271F0:
	mov r0,#0x400	; 023271F0
	swi 0x30000	; 023271F4
loc_023271F8:
	ldr r0,[r1,#0x0]	; 023271F8
	cmp r0,#0xa	; 023271FC
	bne loc_023271F0	; 02327200
	ldr r1,[pool_02327228]	; 02327204
	ldrh r0,[r1,#0x0]	; 02327208
	bic r0,r0,#0x4000	; 0232720C
	strh r0,[r1,#0x0]	; 02327210
	mov r0,#0x0	; 02327214
	mcr p15,0x0,r0,c7,c0,0x4	; 02327218
	bx lr	; 0232721C
.endfunc
.definelabel P1_TransitionItcmBase, 0x01FF8000
.definelabel P1_TransitionRuntimeEntry, P1_TransitionItcmBase + (P1_TransitionLoadEntry - P1_TransitionCopySource)
pool_02327220:
loc_02327220:
	.word 0x027FF880	; 02327220
pool_02327224:
loc_02327224:
	.word 0x027FF884	; 02327224
pool_02327228:
loc_02327228:
	.word REG_EXMEMCNT_ARM9	; 02327228
.thumb

; ===== function loc_0232722C =====
loc_0232722C:
	push {lr}	; 0232722C
	sub sp,#0x4	; 0232722E
	mov r0,#0x3	; 02327230
	bl loc_0232D684	; 02327232
	mov r0,#0x0	; 02327236
	str r0,[sp,#0x0]	; 02327238
	ldr r0,[sp,#0x0]	; 0232723A
	ldr r1,[pool_0232724C]	; 0232723C
	ldr r2,[pool_02327250]	; 0232723E
	blx loc_0232DDBC	; 02327240
	add sp,#0x4	; 02327244
	pop {r3}	; 02327246
	bx r3	; 02327248
	.byte 0xC0, 0x46	; 0232724C
pool_0232724C:
loc_0232724C:
	.word 0x06800000	; 0232724C
pool_02327250:
loc_02327250:
	.word 0x00040000	; 02327250

; ===== function loc_02327254 =====
loc_02327254:
	push {lr}	; 02327254
	sub sp,#0x4	; 02327256
	ldr r0,[pool_02327308]	; 02327258
	ldrh r0,[r0,#0x0]	; 0232725A
	lsl r0,r0,#0x1c	; 0232725C
	lsr r0,r0,#0x1f	; 0232725E
	cmp r0,#0x0	; 02327260
	beq loc_02327276	; 02327262
	ldr r0,[pool_0232730C]	; 02327264
	ldr r0,[r0,#0x0]	; 02327266
	cmp r0,#0x0	; 02327268
	bne loc_02327276	; 0232726A
	mov r0,#0x0	; 0232726C
	add r1,r0,#0x0	; 0232726E
	bl loc_0232F140	; 02327270
	b loc_0232727E	; 02327274
loc_02327276:
	mov r0,#0x1	; 02327276
	mov r1,#0x0	; 02327278
	bl loc_0232F140	; 0232727A
loc_0232727E:
	ldr r1,[pool_02327310]	; 0232727E
	ldrh r0,[r1,#0x0]	; 02327280
	mov r0,#0x0	; 02327282
	strh r0,[r1,#0x0]	; 02327284
	bl loc_0232B0D8	; 02327286
	bl loc_0232D5B4	; 0232728A
	bl loc_0232D5A4	; 0232728E
	bl loc_0232D574	; 02327292
	bl loc_0232D564	; 02327296
	bl loc_0232D594	; 0232729A
	ldr r0,[pool_02327314]	; 0232729E
	bl loc_0232D684	; 023272A0
	mov r0,#0x0	; 023272A4
	str r0,[sp,#0x0]	; 023272A6
	ldr r0,[sp,#0x0]	; 023272A8
	ldr r1,[pool_02327318]	; 023272AA
	ldr r2,[pool_0232731C]	; 023272AC
	blx loc_0232DDBC	; 023272AE
	bl loc_0232D584	; 023272B2
	bl loc_0232722C	; 023272B6
	bl loc_0232D3C0	; 023272BA
	ldr r0,[pool_02327320]	; 023272BE
	ldrh r2,[r0,#0x0]	; 023272C0
	mov r1,#0x2	; 023272C2
	orr r2,r1	; 023272C4
	strh r2,[r0,#0x0]	; 023272C6
	ldrh r2,[r0,#0x0]	; 023272C8
	ldr r1,[pool_02327324]	; 023272CA
	and r2,r1	; 023272CC
	strh r2,[r0,#0x0]	; 023272CE
	ldrh r2,[r0,#0x0]	; 023272D0
	mov r1,#0xc	; 023272D2
	bic r2,r1	; 023272D4
	strh r2,[r0,#0x0]	; 023272D6
	ldr r1,[pool_02327308]	; 023272D8
	ldrh r1,[r1,#0x0]	; 023272DA
	lsl r1,r1,#0x1c	; 023272DC
	lsr r1,r1,#0x1f	; 023272DE
	cmp r1,#0x0	; 023272E0
	beq loc_023272F4	; 023272E2
	ldr r1,[pool_0232730C]	; 023272E4
	ldr r1,[r1,#0x0]	; 023272E6
	cmp r1,#0x0	; 023272E8
	bne loc_023272F4	; 023272EA
	ldrh r2,[r0,#0x0]	; 023272EC
	ldr r1,[pool_02327328]	; 023272EE
	and r2,r1	; 023272F0
	strh r2,[r0,#0x0]	; 023272F2
loc_023272F4:
; CpuFastSet 的 0x100 个字复制 0x400 字节，再进入新的 ITCM 段。
; CpuFastSet copies 0x100 words (0x400 bytes), then enters the new ITCM stub.
	ldr r0,[pool_0232732C]	; 023272F4
	ldr r1,[pool_02327330]	; 023272F6
	ldr r2,[pool_02327334]	; 023272F8
	bl loc_0232C71E	; 023272FA
	ldr r0,[pool_02327330]	; 023272FE
	blx r0	; 02327300
	add sp,#0x4	; 02327302
	pop {r3}	; 02327304
	bx r3	; 02327306
pool_02327308:
loc_02327308:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02327308
pool_0232730C:
loc_0232730C:
	.word 0x027FF864	; 0232730C
pool_02327310:
loc_02327310:
	.word REG_IME	; 02327310
pool_02327314:
loc_02327314:
	.word 0x000001FF	; 02327314
pool_02327318:
loc_02327318:
	.word 0x06800000	; 02327318
pool_0232731C:
loc_0232731C:
	.word 0x000A4000	; 0232731C
pool_02327320:
loc_02327320:
	.word REG_POWERCNT	; 02327320
pool_02327324:
loc_02327324:
	.word 0xFFFFFDFF	; 02327324
pool_02327328:
loc_02327328:
	.word 0xFFFF7FFF	; 02327328
pool_0232732C:
loc_0232732C:
	.word P1_TransitionCopySource	; 0232732C
pool_02327330:
loc_02327330:
	.word P1_TransitionRuntimeEntry	; 02327330
pool_02327334:
loc_02327334:
	.word 0x00000100	; 02327334

; ===== function loc_02327338 =====
loc_02327338:
	push {lr}	; 02327338
	sub sp,#0x24	; 0232733A
	mov r0,#0x0	; 0232733C
	bl loc_0232B0D8	; 0232733E
	mov r0,#0x0	; 02327342
	mvn r0,r0	; 02327344
	bl loc_0232B060	; 02327346
	ldr r0,[pool_023273EC]	; 0232734A
	bl loc_0232D684	; 0232734C
	mov r0,#0x0	; 02327350
	str r0,[sp,#0x0]	; 02327352
	ldr r0,[sp,#0x0]	; 02327354
	ldr r1,[pool_023273F0]	; 02327356
	ldr r2,[pool_023273F4]	; 02327358
	blx loc_0232DDBC	; 0232735A
	bl loc_0232D584	; 0232735E
	mov r0,#0x0	; 02327362
	str r0,[sp,#0x4]	; 02327364
	ldr r0,[sp,#0x4]	; 02327366
	ldr r1,[pool_023273F8]	; 02327368
	ldr r2,[pool_023273FC]	; 0232736A
	blx loc_0232DDBC	; 0232736C
	mov r0,#0x0	; 02327370
	str r0,[sp,#0x8]	; 02327372
	ldr r0,[sp,#0x8]	; 02327374
	ldr r1,[pool_02327400]	; 02327376
	ldr r2,[pool_023273FC]	; 02327378
	blx loc_0232DDBC	; 0232737A
	mov r0,#0x0	; 0232737E
	str r0,[sp,#0xc]	; 02327380
	ldr r0,[sp,#0xc]	; 02327382
	ldr r1,[pool_02327404]	; 02327384
	ldr r2,[pool_023273FC]	; 02327386
	blx loc_0232DDBC	; 02327388
	mov r0,#0x0	; 0232738C
	str r0,[sp,#0x10]	; 0232738E
	ldr r0,[sp,#0x10]	; 02327390
	ldr r1,[pool_02327408]	; 02327392
	ldr r2,[pool_023273FC]	; 02327394
	blx loc_0232DDBC	; 02327396
	mov r0,#0x0	; 0232739A
	str r0,[sp,#0x14]	; 0232739C
	ldr r0,[sp,#0x14]	; 0232739E
	ldr r1,[pool_0232740C]	; 023273A0
	ldr r2,[pool_02327410]	; 023273A2
	blx loc_0232DDBC	; 023273A4
	mov r0,#0x0	; 023273A8
	str r0,[sp,#0x18]	; 023273AA
	ldr r0,[sp,#0x18]	; 023273AC
	ldr r1,[pool_02327414]	; 023273AE
	mov r2,#0x40	; 023273B0
	blx loc_0232DDBC	; 023273B2
	mov r0,#0x0	; 023273B6
	str r0,[sp,#0x1c]	; 023273B8
	ldr r0,[sp,#0x1c]	; 023273BA
	ldr r1,[pool_02327418]	; 023273BC
	mov r2,#0x6e	; 023273BE
	blx loc_0232DDBC	; 023273C0
	mov r0,#0x0	; 023273C4
	ldr r1,[pool_02327414]	; 023273C6
	strh r0,[r1,#0x0]	; 023273C8
	ldr r1,[pool_0232741C]	; 023273CA
	str r0,[r1,#0x0]	; 023273CC
	mov r2,#0x1	; 023273CE
	ldr r1,[pool_02327420]	; 023273D0
	str r2,[r1,#0x0]	; 023273D2
	str r0,[r1,#0x4]	; 023273D4
	ldr r2,[pool_02327424]	; 023273D6
	ldr r1,[pool_02327428]	; 023273D8
	strh r2,[r1,#0x0]	; 023273DA
	ldr r1,[pool_0232742C]	; 023273DC
	str r0,[r1,#0x0]	; 023273DE
	ldr r1,[pool_02327430]	; 023273E0
	strh r0,[r1,#0x0]	; 023273E2
	add sp,#0x24	; 023273E4
	pop {r3}	; 023273E6
	bx r3	; 023273E8
	.byte 0xC0, 0x46	; 023273EC
pool_023273EC:
loc_023273EC:
	.word 0x000001FF	; 023273EC
pool_023273F0:
loc_023273F0:
	.word 0x06800000	; 023273F0
pool_023273F4:
loc_023273F4:
	.word 0x000A4000	; 023273F4
pool_023273F8:
loc_023273F8:
	.word 0x07000000	; 023273F8
pool_023273FC:
loc_023273FC:
	.word 0x00000400	; 023273FC
pool_02327400:
loc_02327400:
	.word 0x05000000	; 02327400
pool_02327404:
loc_02327404:
	.word 0x07000400	; 02327404
pool_02327408:
loc_02327408:
	.word 0x05000400	; 02327408
pool_0232740C:
loc_0232740C:
	.word REG_BG0CNT	; 0232740C
pool_02327410:
loc_02327410:
	.word 0x0000012C	; 02327410
pool_02327414:
loc_02327414:
	.word REG_DIVCNT	; 02327414
pool_02327418:
loc_02327418:
	.word REG_DISPCNT_B	; 02327418
pool_0232741C:
loc_0232741C:
	.word REG_DIV_NUMER	; 0232741C
pool_02327420:
loc_02327420:
	.word REG_DIV_DENOM	; 02327420
pool_02327424:
loc_02327424:
	.word 0x00004008	; 02327424
pool_02327428:
loc_02327428:
	.word REG_IPC_FIFO_CR	; 02327428
pool_0232742C:
loc_0232742C:
	.word REG_DISPCNT_A	; 0232742C
pool_02327430:
loc_02327430:
	.word REG_DISPSTAT	; 02327430

; ===== function loc_02327434 =====
loc_02327434:
	ldr r1,[pool_02327448]	; 02327434
	ldr r1,[r1,#0x0]	; 02327436
	and r1,r0	; 02327438
	cmp r1,#0x0	; 0232743A
	beq loc_02327442	; 0232743C
	mov r0,#0x1	; 0232743E
	bx lr	; 02327440
loc_02327442:
	mov r0,#0x0	; 02327442
	bx lr	; 02327444
	.byte 0xC0, 0x46	; 02327448
pool_02327448:
loc_02327448:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327448

; ===== function loc_0232744C =====
loc_0232744C:
	push {r4,lr}	; 0232744C
	ldr r0,[pool_023274C4]	; 0232744E
	ldr r1,[pool_023274C8]	; 02327450
	ldr r2,[pool_023274CC]	; 02327452
	sub r2,r2,r0	; 02327454
	blx loc_0232DE08	; 02327456
	ldr r0,[pool_023274C4]	; 0232745A
	ldr r1,[pool_023274D0]	; 0232745C
	blx P1_CleanDataCacheRange	; 0232745E
	mov r4,#0x0	; 02327462
loc_02327464:
	add r0,r4,#0x0	; 02327464
	bl loc_0232DC98	; 02327466
	add r4,r4,#0x1	; 0232746A
	cmp r4,#0x3	; 0232746C
	ble loc_02327464	; 0232746E
	bl loc_02327B58	; 02327470
	bl loc_02327338	; 02327474
	mov r0,#0x0	; 02327478
	bl loc_0232D434	; 0232747A
	ldr r0,[pool_023274D4]	; 0232747E
	ldr r1,[pool_023274D8]	; 02327480
	bl loc_0232B134	; 02327482
	ldr r0,[pool_023274D4]	; 02327486
	bl loc_0232B0D8	; 02327488
	ldr r1,[pool_023274DC]	; 0232748C
	ldr r0,[pool_023274E0]	; 0232748E
	strh r1,[r0,#0x0]	; 02327490
	mov r1,#0x7	; 02327492
	ldr r0,[pool_023274E4]	; 02327494
	str r1,[r0,#0x0]	; 02327496
	mov r0,#0x1	; 02327498
	ldr r1,[pool_023274D4]	; 0232749A
	blx loc_0232AF1C	; 0232749C
	ldr r2,[pool_023274E0]	; 023274A0
	ldrh r1,[r2,#0x0]	; 023274A2
	ldr r0,[pool_023274E8]	; 023274A4
	and r1,r0	; 023274A6
	strh r1,[r2,#0x0]	; 023274A8
	ldr r1,[pool_023274EC]	; 023274AA
	ldrh r0,[r1,#0x0]	; 023274AC
	mov r0,#0x0	; 023274AE
	strh r0,[r1,#0x0]	; 023274B0
	bl loc_0232B0D8	; 023274B2
	mov r0,#0x0	; 023274B6
	mvn r0,r0	; 023274B8
	bl loc_0232B060	; 023274BA
	pop {r4}	; 023274BE
	pop {r3}	; 023274C0
	bx r3	; 023274C2
pool_023274C4:
loc_023274C4:
	.word 0x02327C34	; 023274C4
pool_023274C8:
loc_023274C8:
	.word 0x023FEE00	; 023274C8
pool_023274CC:
loc_023274CC:
	.word 0x02327D9C	; 023274CC
pool_023274D0:
loc_023274D0:
	.word 0x00000200	; 023274D0
pool_023274D4:
loc_023274D4:
	.word 0x00010000	; 023274D4
pool_023274D8:
loc_023274D8:
	.word P1_IrqHandler_023274F0 + 1	; 023274D8
pool_023274DC:
loc_023274DC:
	.word 0x00004F00	; 023274DC
pool_023274E0:
loc_023274E0:
	.word REG_IPC_SYNC	; 023274E0
pool_023274E4:
loc_023274E4:
	.word 0x027FF880	; 023274E4
pool_023274E8:
loc_023274E8:
	.word 0x00000F00	; 023274E8
pool_023274EC:
loc_023274EC:
	.word REG_IME	; 023274EC
P1_IrqHandler_023274F0:
	ldr r1,[pool_02327500]	; 023274F0
	ldr r0,[pool_02327504]	; 023274F2
	add r1,r1,r0	; 023274F4
	ldr r2,[r1,#0x0]	; 023274F6
	ldr r0,[pool_02327508]	; 023274F8
	orr r2,r0	; 023274FA
	str r2,[r1,#0x0]	; 023274FC
	bx lr	; 023274FE
pool_02327500:
loc_02327500:
	.word 0x03000000	; 02327500
pool_02327504:
loc_02327504:
	.word 0x00003FF8	; 02327504
pool_02327508:
loc_02327508:
	.word 0x00010000	; 02327508

; ===== function loc_0232750C =====
loc_0232750C:
; 将参数中的事件位并入双核共享位图。
; OR the requested event bits into the shared bitmap.
.func P1_OrSharedEventFlags
	push {r4,lr}	; 0232750C
	add r4,r0,#0x0	; 0232750E
	mov r0,#0x6e	; 02327510
	ldr r1,[pool_02327530]	; 02327512
	mov r2,#0x0	; 02327514
	bl loc_0232B400	; 02327516
	ldr r1,[pool_02327530]	; 0232751A
	ldr r0,[r1,#0x8]	; 0232751C
	orr r0,r4	; 0232751E
	str r0,[r1,#0x8]	; 02327520
	mov r0,#0x6e	; 02327522
	mov r2,#0x0	; 02327524
	bl loc_0232B388	; 02327526
	pop {r4}	; 0232752A
	pop {r3}	; 0232752C
	bx r3	; 0232752E
.endfunc
pool_02327530:
loc_02327530:
	.word FirmwareBootSharedAddress + BootSharedEventSyncOffset	; 02327530

; ===== function loc_02327534 =====
loc_02327534:
	ldr r0,[pool_0232753C]	; 02327534
	ldr r3,[pool_02327540]	; 02327536
	bx r3	; 02327538
	.byte 0xC0, 0x46	; 0232753C
pool_0232753C:
loc_0232753C:
	.word 0x80000040	; 0232753C
pool_02327540:
loc_02327540:
	.word P1_OrSharedEventFlags + 1	; 02327540

; ===== function loc_02327544 =====
loc_02327544:
	ldr r0,[pool_0232754C]	; 02327544
	ldr r3,[pool_02327550]	; 02327546
	bx r3	; 02327548
	.byte 0xC0, 0x46	; 0232754C
pool_0232754C:
loc_0232754C:
	.word 0x80000100	; 0232754C
pool_02327550:
loc_02327550:
	.word P1_OrSharedEventFlags + 1	; 02327550

; ===== function loc_02327554 =====
loc_02327554:
	ldr r0,[pool_0232755C]	; 02327554
	ldr r3,[pool_02327560]	; 02327556
	bx r3	; 02327558
	.byte 0xC0, 0x46	; 0232755C
pool_0232755C:
loc_0232755C:
	.word 0x80000080	; 0232755C
pool_02327560:
loc_02327560:
	.word P1_OrSharedEventFlags + 1	; 02327560

; ===== function loc_02327564 =====
loc_02327564:
	ldr r0,[pool_0232756C]	; 02327564
	ldr r3,[pool_02327570]	; 02327566
	bx r3	; 02327568
	.byte 0xC0, 0x46	; 0232756C
pool_0232756C:
loc_0232756C:
	.word 0x80000010	; 0232756C
pool_02327570:
loc_02327570:
	.word P1_OrSharedEventFlags + 1	; 02327570

; ===== function loc_02327574 =====
loc_02327574:
	push {lr}	; 02327574
	sub sp,#0x4	; 02327576
	ldr r0,[pool_023275A8]	; 02327578
	bl loc_02326F70	; 0232757A
	cmp r0,#0x0	; 0232757E
	beq loc_0232758C	; 02327580
	ldr r1,[pool_023275AC]	; 02327582
	mov r0,#0x0	; 02327584
	ldrsh r0,[r1,r0]	; 02327586
	cmp r0,#0x1	; 02327588
	bne loc_0232759A	; 0232758A
loc_0232758C:
	mov r0,#0x4	; 0232758C
	bl P1_OrSharedEventFlags	; 0232758E
	mov r0,#0x0	; 02327592
	add sp,#0x4	; 02327594
	pop {r3}	; 02327596
	bx r3	; 02327598
loc_0232759A:
	ldr r0,[pool_023275B0]	; 0232759A
	bl P1_OrSharedEventFlags	; 0232759C
	mov r0,#0x1	; 023275A0
	add sp,#0x4	; 023275A2
	pop {r3}	; 023275A4
	bx r3	; 023275A6
pool_023275A8:
loc_023275A8:
	.word 0x027FFEC0	; 023275A8
pool_023275AC:
loc_023275AC:
	.word 0x027FF812	; 023275AC
pool_023275B0:
loc_023275B0:
	.word 0x80000020	; 023275B0

; ===== function loc_023275B4 =====
loc_023275B4:
	push {lr}	; 023275B4
	sub sp,#0x4	; 023275B6
	ldr r0,[pool_023275DC]	; 023275B8
	ldr r2,[r0,#0x0]	; 023275BA
	mov r0,#0x8	; 023275BC
	add r1,r2,#0x0	; 023275BE
	and r1,r0	; 023275C0
	cmp r1,#0x0	; 023275C2
	bne loc_023275D4	; 023275C4
	ldr r0,[pool_023275E0]	; 023275C6
	and r2,r0	; 023275C8
	cmp r2,#0x0	; 023275CA
	beq loc_023275D4	; 023275CC
	ldr r0,[pool_023275E4]	; 023275CE
	bl P1_OrSharedEventFlags	; 023275D0
loc_023275D4:
	add sp,#0x4	; 023275D4
	pop {r3}	; 023275D6
	bx r3	; 023275D8
	.byte 0xC0, 0x46	; 023275DC
pool_023275DC:
loc_023275DC:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023275DC
pool_023275E0:
loc_023275E0:
	.word 0x00000400	; 023275E0
pool_023275E4:
loc_023275E4:
	.word 0x08000000	; 023275E4

; ===== function loc_023275E8 =====
loc_023275E8:
	push {r4,lr}	; 023275E8
	sub sp,#0x10	; 023275EA
	ldr r0,[pool_023277DC]	; 023275EC
	ldr r1,[r0,#0x20]	; 023275EE
	cmp r1,#0x8	; 023275F0
	bls loc_023275F6	; 023275F2
	b loc_023277D2	; 023275F4
loc_023275F6:
	add r1,r1,r1	; 023275F6
P1_SwitchIndexPC_023275F6:
	add r1,pc	; 023275F8
	ldrh r1,[r1,#(P1_SwitchTable_023275F6 - (P1_SwitchIndexPC_023275F6 + 4))]	; 023275FA
	lsl r1,r1,#0x10	; 023275FC
	asr r1,r1,#0x10	; 023275FE
P1_SwitchTargetPC_023275F6:
	add r1,pc	; 02327600
	bx r1	; 02327602
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023275F6:
	.halfword (loc_023277D2 + 1) - (P1_SwitchTargetPC_023275F6 + 4)
	.halfword (loc_023277D2 + 1) - (P1_SwitchTargetPC_023275F6 + 4)
	.halfword (loc_02327616 + 1) - (P1_SwitchTargetPC_023275F6 + 4)
	.halfword (loc_0232766E + 1) - (P1_SwitchTargetPC_023275F6 + 4)
	.halfword (loc_023276BE + 1) - (P1_SwitchTargetPC_023275F6 + 4)
	.halfword (loc_023276D8 + 1) - (P1_SwitchTargetPC_023275F6 + 4)
	.halfword (loc_023276EA + 1) - (P1_SwitchTargetPC_023275F6 + 4)
	.halfword (loc_023277D2 + 1) - (P1_SwitchTargetPC_023275F6 + 4)
	.halfword (loc_0232773C + 1) - (P1_SwitchTargetPC_023275F6 + 4)
P1_SwitchTable_023275F6End:
loc_02327616:
	bl loc_0232713C	; 02327616
	bl loc_02327008	; 0232761A
	bl loc_02326FEC	; 0232761E
	mov r4,#0x0	; 02327622
	bl loc_02326FAC	; 02327624
	cmp r0,#0x0	; 02327628
	beq loc_0232763E	; 0232762A
	mov r0,#0x2	; 0232762C
	orr r4,r0	; 0232762E
	ldr r0,[pool_023277E0]	; 02327630
	bl loc_02326F70	; 02327632
	cmp r0,#0x0	; 02327636
	bne loc_0232763E	; 02327638
	mov r0,#0x4	; 0232763A
	orr r4,r0	; 0232763C
loc_0232763E:
	bl loc_023284E8	; 0232763E
	cmp r0,#0x0	; 02327642
	beq loc_02327654	; 02327644
	mov r0,#0x1	; 02327646
	orr r4,r0	; 02327648
	ldr r2,[pool_023277E4]	; 0232764A
	ldrb r1,[r2,#0x0]	; 0232764C
	bic r1,r0	; 0232764E
	orr r1,r0	; 02327650
	strb r1,[r2,#0x0]	; 02327652
loc_02327654:
	bl loc_02326E9C	; 02327654
	bl P1_Runtime_01FF8084	; 02327658
	ldr r0,[pool_023277E8]	; 0232765C
	orr r4,r0	; 0232765E
	add r0,r4,#0x0	; 02327660
	bl P1_OrSharedEventFlags	; 02327662
	mov r1,#0x3	; 02327666
	ldr r0,[pool_023277DC]	; 02327668
	str r1,[r0,#0x20]	; 0232766A
	b loc_023277D2	; 0232766C
loc_0232766E:
	ldr r3,[pool_023277EC]	; 0232766E
	ldr r2,[r3,#0x0]	; 02327670
	ldr r1,[pool_023277F0]	; 02327672
	and r2,r1	; 02327674
	cmp r2,#0x0	; 02327676
	bne loc_0232767C	; 02327678
	b loc_023277D2	; 0232767A
loc_0232767C:
	ldr r2,[r3,#0x0]	; 0232767C
	mov r1,#0x20	; 0232767E
	and r2,r1	; 02327680
	cmp r2,#0x0	; 02327682
	beq loc_02327694	; 02327684
	mov r0,#0x3	; 02327686
	bl loc_02326FDC	; 02327688
	mov r1,#0x4	; 0232768C
	ldr r0,[pool_023277DC]	; 0232768E
	str r1,[r0,#0x20]	; 02327690
	b loc_023277D2	; 02327692
loc_02327694:
	ldr r2,[r3,#0x0]	; 02327694
	mov r1,#0x10	; 02327696
	and r2,r1	; 02327698
	cmp r2,#0x0	; 0232769A
	beq loc_023276A4	; 0232769C
	mov r1,#0x5	; 0232769E
	str r1,[r0,#0x20]	; 023276A0
	b loc_023277D2	; 023276A2
loc_023276A4:
	ldr r1,[r3,#0x0]	; 023276A4
	ldr r0,[pool_023277F4]	; 023276A6
	and r1,r0	; 023276A8
	cmp r1,#0x0	; 023276AA
	bne loc_023276B0	; 023276AC
	b loc_023277D2	; 023276AE
loc_023276B0:
	mov r0,#0x6	; 023276B0
	bl loc_02326FDC	; 023276B2
	mov r1,#0x6	; 023276B6
	ldr r0,[pool_023277DC]	; 023276B8
	str r1,[r0,#0x20]	; 023276BA
	b loc_023277D2	; 023276BC
loc_023276BE:
	ldr r0,[pool_023277F8]	; 023276BE
	bl loc_02327434	; 023276C0
	cmp r0,#0x0	; 023276C4
	bne loc_023276CA	; 023276C6
	b loc_023277D2	; 023276C8
loc_023276CA:
	bl loc_0232744C	; 023276CA
	mov r0,#0x1	; 023276CE
	add sp,#0x10	; 023276D0
	pop {r4}	; 023276D2
	pop {r3}	; 023276D4
	bx r3	; 023276D6
loc_023276D8:
	ldr r0,[r0,#0x24]	; 023276D8
	cmp r0,#0x2	; 023276DA
	bne loc_023277D2	; 023276DC
	mov r0,#0x4	; 023276DE
	bl loc_02326FDC	; 023276E0
	bl loc_02327254	; 023276E4
	b loc_023277D2	; 023276E8
loc_023276EA:
	ldr r0,[pool_023277EC]	; 023276EA
	ldr r1,[r0,#0x0]	; 023276EC
	ldr r0,[pool_023277FC]	; 023276EE
	and r1,r0	; 023276F0
	cmp r1,#0x0	; 023276F2
	beq loc_023277D2	; 023276F4
	bl loc_02326DAC	; 023276F6
	ldr r0,[pool_02327800]	; 023276FA
	bl P1_OrSharedEventFlags	; 023276FC
	mov r0,#0x0	; 02327700
	str r0,[sp,#0x4]	; 02327702
	ldr r0,[sp,#0x4]	; 02327704
	ldr r1,[pool_02327804]	; 02327706
	ldr r2,[pool_02327808]	; 02327708
	blx loc_0232DDBC	; 0232770A
; 按此版本的零区起点和字节数清零，SWI 参数换算为 32 位字数。
; Clear this version's zero area; convert its byte size to the SWI word count.
	ldr r2,[pool_0232780C]	; 0232770E
	cmp r2,#0x0	; 02327710
	beq loc_0232772A	; 02327712
	mov r0,#0x0	; 02327714
	str r0,[sp,#0x0]	; 02327716
	add r0,sp,#0x0	; 02327718
	ldr r1,[pool_02327810]	; 0232771A
	lsr r2,r2,#0x2	; 0232771C
	ldr r3,[pool_02327814]	; 0232771E
	and r2,r3	; 02327720
	ldr r3,[pool_02327818]	; 02327722
	orr r2,r3	; 02327724
	bl loc_0232C71E	; 02327726
loc_0232772A:
	blx P1_CleanEntireDataCacheByIndex	; 0232772A
	mov r0,#0x7	; 0232772E
	bl loc_02326FDC	; 02327730
	mov r1,#0x8	; 02327734
	ldr r0,[pool_023277DC]	; 02327736
	str r1,[r0,#0x20]	; 02327738
	b loc_023277D2	; 0232773A
loc_0232773C:
	ldr r0,[pool_023277EC]	; 0232773C
	ldr r2,[r0,#0x0]	; 0232773E
	ldr r1,[pool_0232781C]	; 02327740
	and r2,r1	; 02327742
	cmp r2,#0x0	; 02327744
	beq loc_023277D2	; 02327746
	ldr r2,[r0,#0x0]	; 02327748
	ldr r1,[pool_02327820]	; 0232774A
	and r2,r1	; 0232774C
	cmp r2,#0x0	; 0232774E
	beq loc_023277D2	; 02327750
	ldr r2,[r0,#0x0]	; 02327752
	mov r1,#0x80	; 02327754
	and r2,r1	; 02327756
	cmp r2,#0x0	; 02327758
	beq loc_02327766	; 0232775A
	ldr r0,[pool_02327824]	; 0232775C
	ldr r0,[r0,#0x0]	; 0232775E
	ldr r0,[r0,#0x0]	; 02327760
	blx r0	; 02327762
	b loc_023277C8	; 02327764
loc_02327766:
	ldr r2,[r0,#0x0]	; 02327766
	ldr r1,[pool_02327828]	; 02327768
	and r2,r1	; 0232776A
	cmp r2,#0x0	; 0232776C
	beq loc_023277B6	; 0232776E
	ldr r1,[r0,#0x0]	; 02327770
	mov r0,#0x2	; 02327772
	and r1,r0	; 02327774
	cmp r1,#0x0	; 02327776
	beq loc_0232777E	; 02327778
	mov r0,#0x1	; 0232777A
	b loc_02327780	; 0232777C
loc_0232777E:
	mov r0,#0x0	; 0232777E
loc_02327780:
	cmp r0,#0x0	; 02327780
	beq loc_023277A4	; 02327782
	ldr r0,[pool_023277DC]	; 02327784
	ldr r1,[r0,#0x0]	; 02327786
	ldr r0,[pool_0232782C]	; 02327788
	str r1,[r0,#0x0]	; 0232778A
	ldr r0,[pool_02327830]	; 0232778C
	ldr r1,[pool_02327834]	; 0232778E
	ldr r2,[pool_02327838]	; 02327790
	blx loc_0232DE08	; 02327792
	mov r0,#0x0	; 02327796
	str r0,[sp,#0x8]	; 02327798
	ldr r0,[sp,#0x8]	; 0232779A
	ldr r1,[pool_02327830]	; 0232779C
	ldr r2,[pool_02327838]	; 0232779E
	blx loc_0232DDBC	; 023277A0
loc_023277A4:
	ldr r0,[pool_02327824]	; 023277A4
	ldr r0,[r0,#0x0]	; 023277A6
	ldr r0,[r0,#0x4]	; 023277A8
	blx r0	; 023277AA
	blx P1_CleanEntireDataCacheByIndex	; 023277AC
	bl loc_0232744C	; 023277B0
	b loc_023277C8	; 023277B4
loc_023277B6:
	ldr r1,[r0,#0x0]	; 023277B6
	mov r0,#0x40	; 023277B8
	and r1,r0	; 023277BA
	cmp r1,#0x0	; 023277BC
	beq loc_023277C8	; 023277BE
	ldr r0,[pool_02327824]	; 023277C0
	ldr r0,[r0,#0x0]	; 023277C2
	ldr r0,[r0,#0x8]	; 023277C4
	blx r0	; 023277C6
loc_023277C8:
	mov r0,#0x1	; 023277C8
	add sp,#0x10	; 023277CA
	pop {r4}	; 023277CC
	pop {r3}	; 023277CE
	bx r3	; 023277D0
loc_023277D2:
	mov r0,#0x0	; 023277D2
	add sp,#0x10	; 023277D4
	pop {r4}	; 023277D6
	pop {r3}	; 023277D8
	bx r3	; 023277DA
pool_023277DC:
loc_023277DC:
	.word 0x027FF860	; 023277DC
pool_023277E0:
loc_023277E0:
	.word 0x027FFEC0	; 023277E0
pool_023277E4:
loc_023277E4:
	.word FirmwareBootInfoAddress + BootInfoGbaFlagsOffset	; 023277E4
pool_023277E8:
loc_023277E8:
	.word 0x20000000	; 023277E8
pool_023277EC:
loc_023277EC:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023277EC
pool_023277F0:
loc_023277F0:
	.word 0x80000000	; 023277F0
pool_023277F4:
loc_023277F4:
	.word 0x000001C0	; 023277F4
pool_023277F8:
loc_023277F8:
	.word 0x00000200	; 023277F8
pool_023277FC:
loc_023277FC:
	.word 0x00001000	; 023277FC
pool_02327800:
loc_02327800:
	.word 0x00000400	; 02327800
pool_02327804:
loc_02327804:
	.word 0x02000000	; 02327804
pool_02327808:
loc_02327808:
	.word 0x00300000	; 02327808
pool_0232780C:
loc_0232780C:
	.word UiBootZeroBytes	; 0232780C
pool_02327810:
loc_02327810:
	.word UiBootZeroStart	; 02327810
pool_02327814:
loc_02327814:
	.word 0x001FFFFF	; 02327814
pool_02327818:
loc_02327818:
	.word 0x01000000	; 02327818
pool_0232781C:
loc_0232781C:
	.word 0x40000000	; 0232781C
pool_02327820:
loc_02327820:
	.word 0x08000000	; 02327820
pool_02327824:
loc_02327824:
	.word P1_BssStart + 0x24E28	; 02327824
pool_02327828:
loc_02327828:
	.word 0x00000100	; 02327828
pool_0232782C:
loc_0232782C:
	.word NdsCartHeaderArm7RamAddress	; 0232782C
pool_02327830:
loc_02327830:
	.word 0x027FFE00	; 02327830
pool_02327834:
loc_02327834:
	.word 0x023FE940	; 02327834
pool_02327838:
loc_02327838:
	.word 0x00000160	; 02327838

; ===== function loc_0232783C =====
loc_0232783C:
	push {r4,r5,r6,r7,lr}	; 0232783C
	sub sp,#0x4	; 0232783E
	ldr r4,[pool_0232788C]	; 02327840
	ldr r6,[pool_02327890]	; 02327842
	ldr r7,[pool_02327894]	; 02327844
loc_02327846:
	ldr r5,[r6,#0x0]	; 02327846
	ldr r0,[pool_02327898]	; 02327848
	bl P1_SwiWaitByLoop	; 0232784A
	add r0,r5,#0x0	; 0232784E
	and r0,r4	; 02327850
	cmp r0,#0x0	; 02327852
	bne loc_02327868	; 02327854
	and r5,r7	; 02327856
	cmp r5,#0x0	; 02327858
	beq loc_02327846	; 0232785A
	bl loc_02326E1C	; 0232785C
	add r0,r4,#0x0	; 02327860
	bl P1_OrSharedEventFlags	; 02327862
	b loc_02327846	; 02327866
loc_02327868:
	mov r1,#0x2	; 02327868
	ldr r0,[pool_0232789C]	; 0232786A
	str r1,[r0,#0x0]	; 0232786C
	ldr r2,[pool_023278A0]	; 0232786E
	ldrh r1,[r2,#0x0]	; 02327870
	mov r0,#0x1	; 02327872
	orr r1,r0	; 02327874
	strh r1,[r2,#0x0]	; 02327876
	bl loc_02327C14	; 02327878
	bl loc_02327068	; 0232787C
	mov r0,#0x0	; 02327880
	add sp,#0x4	; 02327882
	pop {r4,r5,r6,r7}	; 02327884
	pop {r3}	; 02327886
	bx r3	; 02327888
	.byte 0xC0, 0x46	; 0232788C
pool_0232788C:
loc_0232788C:
	.word 0x00000800	; 0232788C
pool_02327890:
loc_02327890:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327890
pool_02327894:
loc_02327894:
	.word 0x00002000	; 02327894
pool_02327898:
loc_02327898:
	.word 0x00001000	; 02327898
pool_0232789C:
loc_0232789C:
	.word 0x027FF880	; 0232789C
pool_023278A0:
loc_023278A0:
	.word REG_POSTFLG	; 023278A0

; ===== function P1_ClipMemoryRangeToBounds =====
; Rejects a (start,length) range outside the supplied bounds; trims a range that crosses the upper bound.
; 将越出给定边界的（起始地址、长度）范围置零；超过上界时截短长度。
.func P1_ClipMemoryRangeToBounds
loc_023278A4:
	push {r4,r5}	; 023278A4
	ldr r5,[r0,#0x0]	; 023278A6
	ldr r3,[r0,#0x4]	; 023278A8
	add r4,r5,r3	; 023278AA
	cmp r5,r1	; 023278AC
	bcc loc_023278B4	; 023278AE
	cmp r5,r2	; 023278B0
	bls loc_023278BC	; 023278B2
loc_023278B4:
	mov r1,#0x0	; 023278B4
	str r1,[r0,#0x4]	; 023278B6
	pop {r4,r5}	; 023278B8
	bx lr	; 023278BA
loc_023278BC:
	cmp r4,r2	; 023278BC
	bls loc_023278C6	; 023278BE
	sub r1,r4,r2	; 023278C0
	sub r1,r3,r1	; 023278C2
	str r1,[r0,#0x4]	; 023278C4
loc_023278C6:
	pop {r4,r5}	; 023278C6
	bx lr	; 023278C8
.endfunc
	.byte 0x00, 0x00	; 023278CC

; ===== function P1_ConstrainNdsHeaderImageLoadRanges =====
; Constrains ARM7/ARM9 image load ranges recorded in the copied NDS card header before boot.
; 启动前约束复制到 RAM 的 NDS 卡带头内 ARM7/ARM9 映像装载范围。
.func P1_ConstrainNdsHeaderImageLoadRanges
loc_023278CC:
	push {lr}	; 023278CC
	sub sp,#0x4	; 023278CE
	bl loc_02326FAC	; 023278D0
	cmp r0,#0x0	; 023278D4
	beq loc_02327938	; 023278D6
	ldr r0,[pool_02327940]	; 023278D8
	ldr r2,[r0,#0x0]	; 023278DA
	ldr r1,[pool_02327944]	; 023278DC
	cmp r2,r1	; 023278DE
	bcc loc_023278F6	; 023278E0
	ldr r2,[pool_02327948]	; 023278E2
	bl P1_ClipMemoryRangeToBounds	; 023278E4
	ldr r2,[pool_02327940]	; 023278E8
	ldr r1,[r2,#0x0]	; 023278EA
	ldr r0,[pool_0232794C]	; 023278EC
	str r1,[r0,#0x0]	; 023278EE
	ldr r0,[pool_02327950]	; 023278F0
	str r0,[r2,#0x0]	; 023278F2
	b loc_0232792E	; 023278F4
loc_023278F6:
	ldr r1,[pool_02327954]	; 023278F6
	ldr r2,[pool_02327958]	; 023278F8
	bl P1_ClipMemoryRangeToBounds	; 023278FA
	ldr r1,[pool_02327940]	; 023278FE
	ldr r3,[r1,#0x0]	; 02327900
	ldr r0,[pool_0232795C]	; 02327902
	cmp r3,r0	; 02327904
	bcc loc_0232791E	; 02327906
	ldr r0,[pool_0232794C]	; 02327908
	str r3,[r0,#0x0]	; 0232790A
	ldr r0,[pool_02327950]	; 0232790C
	str r0,[r1,#0x0]	; 0232790E
	ldr r2,[pool_02327960]	; 02327910
	ldr r1,[r2,#0x0]	; 02327912
	ldr r0,[pool_02327964]	; 02327914
	cmp r1,r0	; 02327916
	bls loc_0232792E	; 02327918
	str r0,[r2,#0x0]	; 0232791A
	b loc_0232792E	; 0232791C
loc_0232791E:
	ldr r2,[pool_02327960]	; 0232791E
	ldr r1,[r2,#0x0]	; 02327920
	add r3,r3,r1	; 02327922
	cmp r3,r0	; 02327924
	bls loc_0232792E	; 02327926
	sub r0,r3,r0	; 02327928
	sub r0,r1,r0	; 0232792A
	str r0,[r2,#0x0]	; 0232792C
loc_0232792E:
	ldr r0,[pool_02327968]	; 0232792E
	ldr r1,[pool_02327954]	; 02327930
	ldr r2,[pool_02327950]	; 02327932
	bl P1_ClipMemoryRangeToBounds	; 02327934
loc_02327938:
	add sp,#0x4	; 02327938
	pop {r3}	; 0232793A
	bx r3	; 0232793C
.endfunc
	.byte 0xC0, 0x46	; 02327940
pool_02327940:
loc_02327940:
	.word NdsCartHeaderArm7RamAddress	; 02327940
pool_02327944:
loc_02327944:
	.word 0x037F8000	; 02327944
pool_02327948:
loc_02327948:
	.word 0x0380F000	; 02327948
pool_0232794C:
loc_0232794C:
	.word 0x027FF860	; 0232794C
pool_02327950:
loc_02327950:
	.word 0x022C0000	; 02327950
pool_02327954:
loc_02327954:
	.word 0x02000000	; 02327954
pool_02327958:
loc_02327958:
	.word 0x023FE000	; 02327958
pool_0232795C:
loc_0232795C:
	.word 0x02300000	; 0232795C
pool_02327960:
loc_02327960:
	.word NdsCartHeaderArm7SizeAddress	; 02327960
pool_02327964:
loc_02327964:
	.word 0x00040000	; 02327964
pool_02327968:
loc_02327968:
	.word NdsCartHeaderArm9RamAddress	; 02327968

; ===== function loc_0232796C =====
loc_0232796C:
	push {r4,lr}	; 0232796C
	sub sp,#0x8	; 0232796E
	add r4,r0,#0x0	; 02327970
	ldr r2,[pool_023279E4]	; 02327972
	ldrh r1,[r2,#0x0]	; 02327974
	ldr r0,[pool_023279E8]	; 02327976
	orr r1,r0	; 02327978
	strh r1,[r2,#0x0]	; 0232797A
	ldrh r1,[r2,#0x0]	; 0232797C
	mov r0,#0xc	; 0232797E
	bic r1,r0	; 02327980
	strh r1,[r2,#0x0]	; 02327982
	ldrh r1,[r2,#0x0]	; 02327984
	mov r0,#0x10	; 02327986
	bic r1,r0	; 02327988
	strh r1,[r2,#0x0]	; 0232798A
	mov r0,#0x3	; 0232798C
	bl loc_0232DC8C	; 0232798E
	ldr r0,[pool_023279EC]	; 02327992
	ldr r1,[pool_023279F0]	; 02327994
	blx P1_InvalidateDataCacheRange	; 02327996
	mov r0,#0x0	; 0232799A
	str r0,[sp,#0x0]	; 0232799C
	add r0,sp,#0x0	; 0232799E
	ldr r1,[pool_023279F4]	; 023279A0
	ldr r2,[pool_023279F8]	; 023279A2
	bl loc_0232C71E	; 023279A4
	ldr r0,[pool_023279FC]	; 023279A8
	str r4,[r0,#0x0]	; 023279AA
	mov r1,#0x1	; 023279AC
	ldr r0,[pool_02327A00]	; 023279AE
	str r1,[r0,#0x0]	; 023279B0
	bl P1_ConstrainNdsHeaderImageLoadRanges	; 023279B2
	bl loc_02326E60	; 023279B6
	ldr r0,[pool_02327A04]	; 023279BA
	add r0,#0x19	; 023279BC
	mov r1,#0x0	; 023279BE
	mov r2,#0x37	; 023279C0
	blx loc_0232DE40	; 023279C2
	ldr r1,[pool_02327A08]	; 023279C6
	mov r0,#0x0	; 023279C8
	ldrsh r0,[r1,r0]	; 023279CA
	cmp r0,#0x0	; 023279CC
	bne loc_023279DA	; 023279CE
	ldr r2,[pool_02327A0C]	; 023279D0
	ldr r1,[r2,#0x0]	; 023279D2
	ldr r0,[pool_02327A10]	; 023279D4
	orr r1,r0	; 023279D6
	str r1,[r2,#0x0]	; 023279D8
loc_023279DA:
	add sp,#0x8	; 023279DA
	pop {r4}	; 023279DC
	pop {r3}	; 023279DE
	bx r3	; 023279E0
	.byte 0xC0, 0x46	; 023279E4
pool_023279E4:
loc_023279E4:
	.word REG_EXMEMCNT_ARM9	; 023279E4
pool_023279E8:
loc_023279E8:
	.word 0x00008000	; 023279E8
pool_023279EC:
loc_023279EC:
	.word 0x022C0000	; 023279EC
pool_023279F0:
loc_023279F0:
	.word 0x00040000	; 023279F0
pool_023279F4:
loc_023279F4:
	.word 0x027FF860	; 023279F4
pool_023279F8:
loc_023279F8:
	.word 0x0100001B	; 023279F8
pool_023279FC:
loc_023279FC:
	.word P1_BssStart + 0x24E28	; 023279FC
pool_02327A00:
loc_02327A00:
	.word 0x027FF880	; 02327A00
pool_02327A04:
loc_02327A04:
	.word 0x027FF800	; 02327A04
pool_02327A08:
loc_02327A08:
	.word 0x027FF814	; 02327A08
pool_02327A0C:
loc_02327A0C:
	.word NdsCartHeaderRamAddress + 0x60	; 02327A0C
pool_02327A10:
loc_02327A10:
	.word 0x00406000	; 02327A10

; 向 Game Card Command Out 写入 8 字节命令。
; Writes an eight-byte command to Game Card Command Out.
.func P1_WriteGameCardCommand
loc_02327A14:
	push {r4,r5}	; 02327A14
	mov r2,#0x80	; 02327A16
	ldr r1,[pool_02327A44]	; 02327A18
	strb r2,[r1,#0x0]	; 02327A1A
	mov r2,#0x0	; 02327A1C
	ldr r1,[pool_02327A48]	; 02327A1E
	mov r3,#0x1	; 02327A20
loc_02327A22:
	sub r4,r3,r2	; 02327A22
	lsl r4,r4,#0x2	; 02327A24
	ldr r5,[r0,r4]	; 02327A26
	lsr r4,r5,#0x18	; 02327A28
	strb r4,[r1,#0x0]	; 02327A2A
	lsr r4,r5,#0x10	; 02327A2C
	strb r4,[r1,#0x1]	; 02327A2E
	lsr r4,r5,#0x8	; 02327A30
	strb r4,[r1,#0x2]	; 02327A32
	strb r5,[r1,#0x3]	; 02327A34
	add r1,r1,#0x4	; 02327A36
	add r2,r2,#0x1	; 02327A38
	cmp r2,#0x2	; 02327A3A
	blt loc_02327A22	; 02327A3C
	pop {r4,r5}	; 02327A3E
	bx lr	; 02327A40
.endfunc
	.byte 0xC0, 0x46	; 02327A44
pool_02327A44:
loc_02327A44:
	.word REG_AUXSPICNT + 1	; 02327A44
pool_02327A48:
loc_02327A48:
	.word REG_GCCMDOUT	; 02327A48

; 以 B7 命令从 Slot-1 读数据，轮询 ROMCTRL 并取回 GCDATAIN。
; Reads Slot-1 data with command B7, polling ROMCTRL and consuming GCDATAIN.
.func P1_ReadGameCardData
loc_02327A4C:
	push {r4,r5,r6,r7,lr}	; 02327A4C
	sub sp,#0xc	; 02327A4E
	add r5,r1,#0x0	; 02327A50
	add r4,r2,#0x0	; 02327A52
	lsl r1,r0,#0x18	; 02327A54
	str r1,[sp,#0x0]	; 02327A56
	lsr r1,r0,#0x8	; 02327A58
	ldr r0,[pool_02327A9C]	; 02327A5A
	orr r1,r0	; 02327A5C
	str r1,[sp,#0x4]	; 02327A5E
	add r0,sp,#0x0	; 02327A60
	bl P1_WriteGameCardCommand	; 02327A62
	ldr r0,[pool_02327AA0]	; 02327A66
	ldr r1,[r0,#0x0]	; 02327A68
	ldr r0,[pool_02327AA4]	; 02327A6A
	orr r1,r0	; 02327A6C
	ldr r0,[pool_02327AA8]	; 02327A6E
	str r1,[r0,#0x0]	; 02327A70
	add r2,r5,r4	; 02327A72
	ldr r7,[pool_02327AAC]	; 02327A74
	ldr r3,[pool_02327AB0]	; 02327A76
	ldr r4,[pool_02327AB4]	; 02327A78
loc_02327A7A:
	ldr r1,[r0,#0x0]	; 02327A7A
	add r6,r1,#0x0	; 02327A7C
	and r6,r4	; 02327A7E
	cmp r6,#0x0	; 02327A80
	beq loc_02327A8E	; 02327A82
	ldr r6,[r7,#0x0]	; 02327A84
	cmp r5,r2	; 02327A86
	bcs loc_02327A8C	; 02327A88
	str r6,[r5,#0x0]	; 02327A8A
loc_02327A8C:
	add r5,r5,#0x4	; 02327A8C
loc_02327A8E:
	and r1,r3	; 02327A8E
	cmp r1,#0x0	; 02327A90
	bne loc_02327A7A	; 02327A92
	add sp,#0xc	; 02327A94
	pop {r4,r5,r6,r7}	; 02327A96
	pop {r3}	; 02327A98
	bx r3	; 02327A9A
.endfunc
pool_02327A9C:
loc_02327A9C:
	.word 0xB7000000	; 02327A9C
pool_02327AA0:
loc_02327AA0:
	.word NdsCartHeaderRamAddress + 0x60	; 02327AA0
pool_02327AA4:
loc_02327AA4:
	.word 0xA1000000	; 02327AA4
pool_02327AA8:
loc_02327AA8:
	.word REG_ROMCTRL	; 02327AA8
pool_02327AAC:
loc_02327AAC:
	.word REG_GCDATAIN	; 02327AAC
pool_02327AB0:
loc_02327AB0:
	.word 0x80000000	; 02327AB0
pool_02327AB4:
loc_02327AB4:
	.word 0x00800000	; 02327AB4

; ===== function loc_02327AB8 =====
loc_02327AB8:
	push {r4,r5,r6,r7,lr}	; 02327AB8
	sub sp,#0x4	; 02327ABA
	add r6,r0,#0x0	; 02327ABC
	add r7,r1,#0x0	; 02327ABE
	add r5,r2,#0x0	; 02327AC0
	add r4,r5,#0x0	; 02327AC2
	cmp r5,#0x0	; 02327AC4
	ble loc_02327AE8	; 02327AC6
loc_02327AC8:
	ldr r0,[pool_02327AF0]	; 02327AC8
	cmp r4,r0	; 02327ACA
	blt loc_02327AD2	; 02327ACC
	lsl r5,r0,#0	; 02327ACE
	b loc_02327AD4	; 02327AD0
loc_02327AD2:
	add r5,r4,#0x0	; 02327AD2
loc_02327AD4:
	add r0,r6,#0x0	; 02327AD4
	add r1,r7,#0x0	; 02327AD6
	add r2,r5,#0x0	; 02327AD8
	bl loc_02327A4C	; 02327ADA
	add r6,r6,r5	; 02327ADE
	add r7,r7,r5	; 02327AE0
	sub r4,r4,r5	; 02327AE2
	cmp r4,#0x0	; 02327AE4
	bgt loc_02327AC8	; 02327AE6
loc_02327AE8:
	add sp,#0x4	; 02327AE8
	pop {r4,r5,r6,r7}	; 02327AEA
	pop {r3}	; 02327AEC
	bx r3	; 02327AEE
pool_02327AF0:
loc_02327AF0:
	.word 0x00000200	; 02327AF0

; ===== function loc_02327AF4 =====
loc_02327AF4:
	push {lr}	; 02327AF4
	sub sp,#0xc	; 02327AF6
	mov r0,#0x0	; 02327AF8
	str r0,[sp,#0x0]	; 02327AFA
	ldr r0,[pool_02327B18]	; 02327AFC
	str r0,[sp,#0x4]	; 02327AFE
	add r0,sp,#0x0	; 02327B00
	bl loc_02327A14	; 02327B02
	ldr r0,[pool_02327B1C]	; 02327B06
	ldr r1,[r0,#0x4]	; 02327B08
	ldr r0,[pool_02327B20]	; 02327B0A
	orr r1,r0	; 02327B0C
	ldr r0,[pool_02327B24]	; 02327B0E
	str r1,[r0,#0x0]	; 02327B10
	add sp,#0xc	; 02327B12
	pop {r3}	; 02327B14
	bx r3	; 02327B16
pool_02327B18:
loc_02327B18:
	.word 0xB8000000	; 02327B18
pool_02327B1C:
loc_02327B1C:
	.word P1_BssStart + 0x25740	; 02327B1C
pool_02327B20:
loc_02327B20:
	.word 0xA7000000	; 02327B20
pool_02327B24:
loc_02327B24:
	.word REG_ROMCTRL	; 02327B24

; ===== function loc_02327B28 =====
loc_02327B28:
	ldr r0,[pool_02327B3C]	; 02327B28
	ldr r1,[r0,#0x0]	; 02327B2A
	ldr r0,[pool_02327B40]	; 02327B2C
	and r1,r0	; 02327B2E
	cmp r1,#0x0	; 02327B30
	beq loc_02327B38	; 02327B32
	mov r0,#0x1	; 02327B34
	bx lr	; 02327B36
loc_02327B38:
	mov r0,#0x0	; 02327B38
	bx lr	; 02327B3A
pool_02327B3C:
loc_02327B3C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327B3C
pool_02327B40:
loc_02327B40:
	.word 0x00000200	; 02327B40

; ===== function loc_02327B44 =====
loc_02327B44:
	ldr r0,[pool_02327B54]	; 02327B44
	ldr r0,[r0,#0x0]	; 02327B46
	cmp r0,#0x1	; 02327B48
	bne loc_02327B50	; 02327B4A
	mov r0,#0x1	; 02327B4C
	bx lr	; 02327B4E
loc_02327B50:
	mov r0,#0x0	; 02327B50
	bx lr	; 02327B52
pool_02327B54:
loc_02327B54:
	.word P1_BssStart + 0x25740	; 02327B54

; ===== function loc_02327B58 =====
loc_02327B58:
	push {lr}	; 02327B58
	sub sp,#0x4	; 02327B5A
	bl loc_02327B44	; 02327B5C
	cmp r0,#0x0	; 02327B60
	beq loc_02327B70	; 02327B62
loc_02327B64:
	bl loc_02327B78	; 02327B64
	bl loc_02327B44	; 02327B68
	cmp r0,#0x0	; 02327B6C
	bne loc_02327B64	; 02327B6E
loc_02327B70:
	add sp,#0x4	; 02327B70
	pop {r3}	; 02327B72
	bx r3	; 02327B74
	.byte 0x00, 0x00	; 02327B78

; ===== function loc_02327B78 =====
loc_02327B78:
	push {lr}	; 02327B78
	sub sp,#0x4	; 02327B7A
	bl loc_02327B28	; 02327B7C
	cmp r0,#0x0	; 02327B80
	bne loc_02327B8C	; 02327B82
	mov r0,#0x0	; 02327B84
	add sp,#0x4	; 02327B86
	pop {r3}	; 02327B88
	bx r3	; 02327B8A
loc_02327B8C:
	ldr r0,[pool_02327BFC]	; 02327B8C
	ldr r1,[r0,#0x0]	; 02327B8E
	cmp r1,#0x0	; 02327B90
	beq loc_02327B9A	; 02327B92
	cmp r1,#0x1	; 02327B94
	beq loc_02327BB0	; 02327B96
	b loc_02327BF2	; 02327B98
loc_02327B9A:
	ldrh r0,[r0,#0x8]	; 02327B9A
	bl loc_0232B278	; 02327B9C
	cmp r0,#0x0	; 02327BA0
	bne loc_02327BF2	; 02327BA2
	bl loc_02327AF4	; 02327BA4
	mov r1,#0x1	; 02327BA8
	ldr r0,[pool_02327BFC]	; 02327BAA
	str r1,[r0,#0x0]	; 02327BAC
	b loc_02327BF2	; 02327BAE
loc_02327BB0:
	ldr r0,[pool_02327C00]	; 02327BB0
	ldr r1,[r0,#0x0]	; 02327BB2
	ldr r0,[pool_02327C04]	; 02327BB4
	and r1,r0	; 02327BB6
	cmp r1,#0x0	; 02327BB8
	beq loc_02327BF2	; 02327BBA
	ldr r0,[pool_02327C08]	; 02327BBC
	ldr r1,[r0,#0x0]	; 02327BBE
	ldr r0,[pool_02327C0C]	; 02327BC0
	ldr r0,[r0,#0x0]	; 02327BC2
	cmp r1,r0	; 02327BC4
	beq loc_02327BE4	; 02327BC6
	ldr r0,[pool_02327C10]	; 02327BC8
	ldr r1,[r0,#0x0]	; 02327BCA
	mov r0,#0x2	; 02327BCC
	and r1,r0	; 02327BCE
	cmp r1,#0x0	; 02327BD0
	beq loc_02327BD8	; 02327BD2
	mov r0,#0x1	; 02327BD4
	b loc_02327BDA	; 02327BD6
loc_02327BD8:
	mov r0,#0x0	; 02327BD8
loc_02327BDA:
	cmp r0,#0x0	; 02327BDA
	beq loc_02327BE4	; 02327BDC
	mov r1,#0x1	; 02327BDE
	ldr r0,[pool_02327BFC]	; 02327BE0
	strh r1,[r0,#0xa]	; 02327BE2
loc_02327BE4:
	ldr r0,[pool_02327BFC]	; 02327BE4
	ldrh r0,[r0,#0x8]	; 02327BE6
	bl loc_0232B28C	; 02327BE8
	mov r1,#0x0	; 02327BEC
	ldr r0,[pool_02327BFC]	; 02327BEE
	str r1,[r0,#0x0]	; 02327BF0
loc_02327BF2:
	ldr r0,[pool_02327BFC]	; 02327BF2
	ldrh r0,[r0,#0xa]	; 02327BF4
	add sp,#0x4	; 02327BF6
	pop {r3}	; 02327BF8
	bx r3	; 02327BFA
pool_02327BFC:
loc_02327BFC:
	.word P1_BssStart + 0x25740	; 02327BFC
pool_02327C00:
loc_02327C00:
	.word REG_ROMCTRL	; 02327C00
pool_02327C04:
loc_02327C04:
	.word 0x00800000	; 02327C04
pool_02327C08:
loc_02327C08:
	.word REG_GCDATAIN	; 02327C08
pool_02327C0C:
loc_02327C0C:
	.word 0x027FF800	; 02327C0C
pool_02327C10:
loc_02327C10:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327C10

; ===== function loc_02327C14 =====
loc_02327C14:
	push {lr}	; 02327C14
	sub sp,#0x4	; 02327C16
	blx loc_0232B1B4	; 02327C18
	ldr r1,[pool_02327C2C]	; 02327C1C
	strh r0,[r1,#0x8]	; 02327C1E
	ldr r0,[pool_02327C30]	; 02327C20
	ldr r0,[r0,#0x0]	; 02327C22
	str r0,[r1,#0x4]	; 02327C24
	add sp,#0x4	; 02327C26
	pop {r3}	; 02327C28
	bx r3	; 02327C2A
pool_02327C2C:
loc_02327C2C:
	.word P1_BssStart + 0x25740	; 02327C2C
pool_02327C30:
loc_02327C30:
	.word NdsCartHeaderRamAddress + 0x60	; 02327C30
.arm
	mov r0,#0x0	; 02327C34
	mcr p15,0x0,r0,c7,c6,0x0	; 02327C38
	ldr r1,[pool_02327CB4]	; 02327C3C
loc_02327C40:
	ldrh r0,[r1,#0x0]	; 02327C40
	and r0,r0,#0xf	; 02327C44
	cmp r0,#0x2	; 02327C48
	bne loc_02327C40	; 02327C4C
	mov r0,#0x200	; 02327C50
	strh r0,[r1,#0x0]	; 02327C54
	ldr r1,[pool_02327CB4]	; 02327C58
loc_02327C5C:
	ldrh r0,[r1,#0x0]	; 02327C5C
	and r0,r0,#0xf	; 02327C60
	cmp r0,#0x1	; 02327C64
	bne loc_02327C5C	; 02327C68
	mov r0,#0x100	; 02327C6C
	strh r0,[r1,#0x0]	; 02327C70
	bl loc_02327CE8	; 02327C74
	bl loc_02327CC0	; 02327C78
	ldr r1,[pool_02327CB4]	; 02327C7C
loc_02327C80:
	ldrh r0,[r1,#0x0]	; 02327C80
	and r0,r0,#0xf	; 02327C84
	cmp r0,#0x1	; 02327C88
	beq loc_02327C80	; 02327C8C
	mov r0,#0x0	; 02327C90
	strh r0,[r1,#0x0]	; 02327C94
	ldr r3,[pool_02327CB8]	; 02327C98
	ldr r12,[r3,#-0x1dc]	; 02327C9C
	mov lr,r12	; 02327CA0
	ldr r11,[pool_02327CBC]	; 02327CA4
	ldmia r11,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10}	; 02327CA8
	mov r11,#0x0	; 02327CAC
	bx r12	; 02327CB0
pool_02327CB4:
loc_02327CB4:
	.word REG_IPC_SYNC	; 02327CB4
pool_02327CB8:
loc_02327CB8:
; 基准为头部 RAM 视图 +0x200；负偏移实际读取 ARM9/ARM7 入口字段。
; Addressing anchor: the negative offset above reads the ARM9/ARM7 entry field.
	.word NdsCartHeaderRamAddress + 0x200	; 02327CB8
pool_02327CBC:
loc_02327CBC:
	.word 0x03000000	; 02327CBC

; ===== function loc_02327CC0 =====
loc_02327CC0:
	ldr r0,[pool_02327CE4]	; 02327CC0
	mcr p15,0x0,r0,c1,c0,0x0	; 02327CC4
	mov r0,#0x0	; 02327CC8
	mcr p15,0x0,r0,c6,c5,0x0	; 02327CCC
	mov r0,#0x0	; 02327CD0
	mcr p15,0x0,r0,c7,c5,0x0	; 02327CD4
	mcr p15,0x0,r0,c7,c6,0x0	; 02327CD8
	mcr p15,0x0,r0,c7,c10,0x4	; 02327CDC
	bx lr	; 02327CE0
pool_02327CE4:
loc_02327CE4:
	.word 0x00012078	; 02327CE4

; ===== function loc_02327CE8 =====
loc_02327CE8:
	mov r12,lr	; 02327CE8
	mov r0,#0xd3	; 02327CEC
	msr cpsr_cxsf,r0	; 02327CF0
	ldr r0,[pool_02327D58]	; 02327CF4
	add r0,r0,#0x3fc0	; 02327CF8
	mov sp,r0	; 02327CFC
	mov lr,#0x0	; 02327D00
	msr spsr_cxsf,lr	; 02327D04
	mov r0,#0xd2	; 02327D08
	msr cpsr_cxsf,r0	; 02327D0C
	ldr r0,[pool_02327D58]	; 02327D10
	add r0,r0,#0x3fc0	; 02327D14
	sub r0,r0,#0x40	; 02327D18
	mov sp,r0	; 02327D1C
	mov lr,#0x0	; 02327D20
	msr spsr_cxsf,lr	; 02327D24
	ldr r1,[pool_02327D5C]	; 02327D28
	sub r1,r0,r1	; 02327D2C
	mov r0,#0xdf	; 02327D30
	msr cpsr_cxsf,r0	; 02327D34
	sub sp,r1,#0x4	; 02327D38
	ldr r0,[pool_02327D60]	; 02327D3C
	mov r1,#0x8000	; 02327D40
	bl loc_02327D64	; 02327D44
	ldr r0,[pool_02327D58]	; 02327D48
	mov r1,#0x4000	; 02327D4C
	bl loc_02327D64	; 02327D50
	bx r12	; 02327D54
pool_02327D58:
loc_02327D58:
	.word 0x03000000	; 02327D58
pool_02327D5C:
loc_02327D5C:
	.word 0x00001000	; 02327D5C
pool_02327D60:
loc_02327D60:
	.word 0x01FF8000	; 02327D60

; ===== function loc_02327D64 =====
loc_02327D64:
	add r2,r0,r1	; 02327D64
	mov r1,r1, lsr #0x5	; 02327D68
	mov r3,#0x0	; 02327D6C
	mov r4,r3	; 02327D70
	mov r5,r3	; 02327D74
	mov r6,r3	; 02327D78
	mov r7,r3	; 02327D7C
	mov r8,r3	; 02327D80
	mov r9,r3	; 02327D84
	mov r10,r3	; 02327D88
loc_02327D8C:
	cmp r0,r2	; 02327D8C
	stmltia r0!,{r3,r4,r5,r6,r7,r8,r9,r10}	; 02327D90
	blt loc_02327D8C	; 02327D94
	bx lr	; 02327D98
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 02327DA0
.thumb
P1_PxiCallback_02327DA0:
	push {r4}	; 02327DA0
	sub sp,#0x4	; 02327DA2
	mov r4,#0xff	; 02327DA4
	and r1,r4	; 02327DA6
	ldr r3,[pool_02327DC4]	; 02327DA8
	strh r1,[r3,#0x0]	; 02327DAA
	mov r1,#0x1	; 02327DAC
	ldr r0,[pool_02327DC8]	; 02327DAE
	str r1,[r0,#0x0]	; 02327DB0
	cmp r2,#0x0	; 02327DB2
	beq loc_02327DB8	; 02327DB4
	strh r4,[r3,#0x0]	; 02327DB6
loc_02327DB8:
	ldr r0,[pool_02327DC4]	; 02327DB8
	ldrh r0,[r0,#0x0]	; 02327DBA
	add sp,#0x4	; 02327DBC
	pop {r4}	; 02327DBE
	bx lr	; 02327DC0
	.byte 0xC0, 0x46	; 02327DC4
pool_02327DC4:
loc_02327DC4:
	.word P1_BssStart + 0x2574C	; 02327DC4
pool_02327DC8:
loc_02327DC8:
	.word P1_BssStart + 0x25754	; 02327DC8

; ===== function loc_02327DCC =====
loc_02327DCC:
	push {r4,r5,r6,r7,lr}	; 02327DCC
	sub sp,#0xb4	; 02327DCE
	add r6,r0,#0x0	; 02327DD0
	str r1,[sp,#0x0]	; 02327DD2
	str r2,[sp,#0x4]	; 02327DD4
	str r3,[sp,#0x8]	; 02327DD6
	mov r4,#0x0	; 02327DD8
	lsl r0,r1,#0	; 02327DDA
	lsr r0,r0,#0x10	; 02327DDC
	str r0,[sp,#0x2c]	; 02327DDE
	mov r1,#0xff	; 02327DE0
	and r0,r1	; 02327DE2
	str r0,[sp,#0x2c]	; 02327DE4
	ldr r1,[pool_023280EC]	; 02327DE6
	str r0,[sp,#0x1c]	; 02327DE8
	orr r0,r1	; 02327DEA
	str r0,[sp,#0x1c]	; 02327DEC
	ldr r0,[pool_023280F0]	; 02327DEE
	ldr r1,[sp,#0x0]	; 02327DF0
	and r1,r0	; 02327DF2
	str r1,[sp,#0x0]	; 02327DF4
	ldr r1,[pool_023280F4]	; 02327DF6
	ldr r2,[sp,#0x0]	; 02327DF8
	orr r2,r1	; 02327DFA
	str r2,[sp,#0x0]	; 02327DFC
	ldr r2,[sp,#0x4]	; 02327DFE
	str r2,[sp,#0x20]	; 02327E00
	and r2,r0	; 02327E02
	str r2,[sp,#0x20]	; 02327E04
	ldr r5,[pool_023280F8]	; 02327E06
	orr r2,r5	; 02327E08
	str r2,[sp,#0x20]	; 02327E0A
	lsl r2,r3,#0	; 02327E0C
	lsr r2,r2,#0x10	; 02327E0E
	str r2,[sp,#0x30]	; 02327E10
	ldr r3,[pool_023280FC]	; 02327E12
	str r2,[sp,#0x24]	; 02327E14
	orr r2,r3	; 02327E16
	str r2,[sp,#0x24]	; 02327E18
	ldr r2,[sp,#0x8]	; 02327E1A
	and r2,r0	; 02327E1C
	str r2,[sp,#0x8]	; 02327E1E
	ldr r3,[pool_02328100]	; 02327E20
	str r2,[sp,#0x28]	; 02327E22
	orr r2,r3	; 02327E24
	str r2,[sp,#0x28]	; 02327E26
	ldr r3,[pool_02328104]	; 02327E28
	ldr r2,[sp,#0x2c]	; 02327E2A
	orr r2,r3	; 02327E2C
	str r2,[sp,#0x2c]	; 02327E2E
	ldr r3,[sp,#0x4]	; 02327E30
	ldr r2,[pool_02328108]	; 02327E32
	orr r3,r2	; 02327E34
	str r3,[sp,#0x4]	; 02327E36
	ldr r2,[sp,#0x30]	; 02327E38
	orr r2,r5	; 02327E3A
	str r2,[sp,#0x30]	; 02327E3C
	ldr r3,[pool_0232810C]	; 02327E3E
	ldr r2,[sp,#0x8]	; 02327E40
	orr r2,r3	; 02327E42
	str r2,[sp,#0x8]	; 02327E44
	ldr r2,[pool_02328110]	; 02327E46
	lsr r2,r2,#0x18	; 02327E48
	str r2,[sp,#0x34]	; 02327E4A
	ldr r3,[pool_02328114]	; 02327E4C
	orr r2,r3	; 02327E4E
	str r2,[sp,#0x34]	; 02327E50
	ldr r2,[pool_02328110]	; 02327E52
	lsr r2,r2,#0x8	; 02327E54
	str r2,[sp,#0x38]	; 02327E56
	and r2,r0	; 02327E58
	str r2,[sp,#0x38]	; 02327E5A
	orr r2,r1	; 02327E5C
	str r2,[sp,#0x38]	; 02327E5E
	ldr r0,[pool_02328110]	; 02327E60
	lsl r0,r0,#0x8	; 02327E62
	str r0,[sp,#0x3c]	; 02327E64
	ldr r1,[pool_02328118]	; 02327E66
	and r0,r1	; 02327E68
	str r0,[sp,#0x3c]	; 02327E6A
	ldr r1,[pool_0232811C]	; 02327E6C
	orr r0,r1	; 02327E6E
	str r0,[sp,#0x3c]	; 02327E70
	str r4,[sp,#0xb0]	; 02327E72
	str r4,[sp,#0xac]	; 02327E74
	mov r5,#0x4	; 02327E76
	str r4,[sp,#0xa8]	; 02327E78
	str r4,[sp,#0x98]	; 02327E7A
	str r4,[sp,#0xa0]	; 02327E7C
	str r4,[sp,#0xa4]	; 02327E7E
	str r4,[sp,#0x9c]	; 02327E80
	str r4,[sp,#0x94]	; 02327E82
	str r4,[sp,#0x74]	; 02327E84
	str r4,[sp,#0x7c]	; 02327E86
	str r4,[sp,#0x84]	; 02327E88
	str r4,[sp,#0x8c]	; 02327E8A
	str r4,[sp,#0x90]	; 02327E8C
	str r4,[sp,#0x88]	; 02327E8E
	str r4,[sp,#0x80]	; 02327E90
	str r4,[sp,#0x78]	; 02327E92
	str r4,[sp,#0x70]	; 02327E94
	str r4,[sp,#0x6c]	; 02327E96
	str r4,[sp,#0x44]	; 02327E98
	str r4,[sp,#0x4c]	; 02327E9A
	str r4,[sp,#0x54]	; 02327E9C
	str r4,[sp,#0x5c]	; 02327E9E
	str r4,[sp,#0x64]	; 02327EA0
	str r4,[sp,#0x68]	; 02327EA2
	str r4,[sp,#0x60]	; 02327EA4
	str r4,[sp,#0x58]	; 02327EA6
	str r4,[sp,#0x50]	; 02327EA8
	str r4,[sp,#0x48]	; 02327EAA
	str r4,[sp,#0x40]	; 02327EAC
	add r7,r4,#0x0	; 02327EAE
loc_02327EB0:
	cmp r4,#0x0	; 02327EB0
	beq loc_02327EB6	; 02327EB2
	b loc_02328016	; 02327EB4
loc_02327EB6:
	ldr r0,[pool_02328120]	; 02327EB6
	str r7,[r0,#0x0]	; 02327EB8
	cmp r6,#0x6	; 02327EBA
	bhi loc_02327EB0	; 02327EBC
	add r0,r6,r6	; 02327EBE
P1_SwitchIndexPC_02327EBE:
	add r0,pc	; 02327EC0
	ldrh r0,[r0,#(P1_SwitchTable_02327EBE - (P1_SwitchIndexPC_02327EBE + 4))]	; 02327EC2
	lsl r0,r0,#0x10	; 02327EC4
	asr r0,r0,#0x10	; 02327EC6
P1_SwitchTargetPC_02327EBE:
	add r0,pc	; 02327EC8
	bx r0	; 02327ECA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02327EBE:
	.halfword (loc_02327EB0 + 1) - (P1_SwitchTargetPC_02327EBE + 4)
	.halfword (loc_02327EDA + 1) - (P1_SwitchTargetPC_02327EBE + 4)
	.halfword (loc_02327F4A + 1) - (P1_SwitchTargetPC_02327EBE + 4)
	.halfword (loc_02327F60 + 1) - (P1_SwitchTargetPC_02327EBE + 4)
	.halfword (loc_02327FC6 + 1) - (P1_SwitchTargetPC_02327EBE + 4)
	.halfword (loc_02327FC6 + 1) - (P1_SwitchTargetPC_02327EBE + 4)
	.halfword (loc_02328000 + 1) - (P1_SwitchTargetPC_02327EBE + 4)
P1_SwitchTable_02327EBEEnd:
loc_02327EDA:
	add r0,r5,#0x0	; 02327EDA
	ldr r1,[sp,#0x1c]	; 02327EDC
	add r2,r7,#0x0	; 02327EDE
	bl loc_0232E808	; 02327EE0
	cmp r0,#0x0	; 02327EE4
	bge loc_02327EEC	; 02327EE6
	ldr r4,[sp,#0x40]	; 02327EE8
	b loc_02327EB0	; 02327EEA
loc_02327EEC:
	add r0,r5,#0x0	; 02327EEC
	ldr r1,[sp,#0x0]	; 02327EEE
	ldr r2,[sp,#0x44]	; 02327EF0
	bl loc_0232E808	; 02327EF2
	cmp r0,#0x0	; 02327EF6
	bge loc_02327EFE	; 02327EF8
	ldr r4,[sp,#0x48]	; 02327EFA
	b loc_02327EB0	; 02327EFC
loc_02327EFE:
	add r0,r5,#0x0	; 02327EFE
	ldr r1,[pool_02328108]	; 02327F00
	ldr r2,[sp,#0x4c]	; 02327F02
	bl loc_0232E808	; 02327F04
	cmp r0,#0x0	; 02327F08
	bge loc_02327F10	; 02327F0A
	ldr r4,[sp,#0x50]	; 02327F0C
	b loc_02327EB0	; 02327F0E
loc_02327F10:
	add r0,r5,#0x0	; 02327F10
	ldr r1,[sp,#0x20]	; 02327F12
	ldr r2,[sp,#0x54]	; 02327F14
	bl loc_0232E808	; 02327F16
	cmp r0,#0x0	; 02327F1A
	bge loc_02327F22	; 02327F1C
	ldr r4,[sp,#0x58]	; 02327F1E
	b loc_02327EB0	; 02327F20
loc_02327F22:
	add r0,r5,#0x0	; 02327F22
	ldr r1,[sp,#0x24]	; 02327F24
	ldr r2,[sp,#0x5c]	; 02327F26
	bl loc_0232E808	; 02327F28
	cmp r0,#0x0	; 02327F2C
	bge loc_02327F34	; 02327F2E
	ldr r4,[sp,#0x60]	; 02327F30
	b loc_02327EB0	; 02327F32
loc_02327F34:
	add r0,r5,#0x0	; 02327F34
	ldr r1,[sp,#0x28]	; 02327F36
	ldr r2,[sp,#0x64]	; 02327F38
	bl loc_0232E808	; 02327F3A
	cmp r0,#0x0	; 02327F3E
	bge loc_02327F46	; 02327F40
	ldr r4,[sp,#0x68]	; 02327F42
	b loc_02327EB0	; 02327F44
loc_02327F46:
	mov r4,#0x1	; 02327F46
	b loc_02327EB0	; 02327F48
loc_02327F4A:
	add r0,r5,#0x0	; 02327F4A
	ldr r1,[pool_02328124]	; 02327F4C
	add r2,r7,#0x0	; 02327F4E
	bl loc_0232E808	; 02327F50
	cmp r0,#0x0	; 02327F54
	blt loc_02327F5C	; 02327F56
	mov r4,#0x1	; 02327F58
	b loc_02327EB0	; 02327F5A
loc_02327F5C:
	ldr r4,[sp,#0x6c]	; 02327F5C
	b loc_02327EB0	; 02327F5E
loc_02327F60:
	add r0,r5,#0x0	; 02327F60
	ldr r1,[sp,#0x2c]	; 02327F62
	add r2,r7,#0x0	; 02327F64
	bl loc_0232E808	; 02327F66
	cmp r0,#0x0	; 02327F6A
	bge loc_02327F72	; 02327F6C
	ldr r4,[sp,#0x70]	; 02327F6E
	b loc_02327FBC	; 02327F70
loc_02327F72:
	add r0,r5,#0x0	; 02327F72
	ldr r1,[sp,#0x0]	; 02327F74
	ldr r2,[sp,#0x74]	; 02327F76
	bl loc_0232E808	; 02327F78
	cmp r0,#0x0	; 02327F7C
	bge loc_02327F84	; 02327F7E
	ldr r4,[sp,#0x78]	; 02327F80
	b loc_02327FBC	; 02327F82
loc_02327F84:
	add r0,r5,#0x0	; 02327F84
	ldr r1,[sp,#0x4]	; 02327F86
	ldr r2,[sp,#0x7c]	; 02327F88
	bl loc_0232E808	; 02327F8A
	cmp r0,#0x0	; 02327F8E
	bge loc_02327F96	; 02327F90
	ldr r4,[sp,#0x80]	; 02327F92
	b loc_02327FBC	; 02327F94
loc_02327F96:
	add r0,r5,#0x0	; 02327F96
	ldr r1,[sp,#0x30]	; 02327F98
	ldr r2,[sp,#0x84]	; 02327F9A
	bl loc_0232E808	; 02327F9C
	cmp r0,#0x0	; 02327FA0
	bge loc_02327FA8	; 02327FA2
	ldr r4,[sp,#0x88]	; 02327FA4
	b loc_02327FBC	; 02327FA6
loc_02327FA8:
	add r0,r5,#0x0	; 02327FA8
	ldr r1,[sp,#0x8]	; 02327FAA
	ldr r2,[sp,#0x8c]	; 02327FAC
	bl loc_0232E808	; 02327FAE
	cmp r0,#0x0	; 02327FB2
	bge loc_02327FBA	; 02327FB4
	ldr r4,[sp,#0x90]	; 02327FB6
	b loc_02327FBC	; 02327FB8
loc_02327FBA:
	mov r4,#0x1	; 02327FBA
loc_02327FBC:
	bl loc_0232BF44	; 02327FBC
	str r0,[sp,#0x14]	; 02327FC0
	str r1,[sp,#0x10]	; 02327FC2
	b loc_02327EB0	; 02327FC4
loc_02327FC6:
	add r0,r5,#0x0	; 02327FC6
	ldr r1,[sp,#0x34]	; 02327FC8
	add r2,r7,#0x0	; 02327FCA
	bl loc_0232E808	; 02327FCC
	cmp r0,#0x0	; 02327FD0
	bge loc_02327FD8	; 02327FD2
	ldr r4,[sp,#0x94]	; 02327FD4
	b loc_02327EB0	; 02327FD6
loc_02327FD8:
	add r0,r5,#0x0	; 02327FD8
	ldr r1,[sp,#0x38]	; 02327FDA
	ldr r2,[sp,#0x98]	; 02327FDC
	bl loc_0232E808	; 02327FDE
	cmp r0,#0x0	; 02327FE2
	bge loc_02327FEA	; 02327FE4
	ldr r4,[sp,#0x9c]	; 02327FE6
	b loc_02327EB0	; 02327FE8
loc_02327FEA:
	add r0,r5,#0x0	; 02327FEA
	ldr r1,[sp,#0x3c]	; 02327FEC
	ldr r2,[sp,#0xa0]	; 02327FEE
	bl loc_0232E808	; 02327FF0
	cmp r0,#0x0	; 02327FF4
	bge loc_02327FFC	; 02327FF6
	ldr r4,[sp,#0xa4]	; 02327FF8
	b loc_02327EB0	; 02327FFA
loc_02327FFC:
	mov r4,#0x1	; 02327FFC
	b loc_02327EB0	; 02327FFE
loc_02328000:
	add r0,r5,#0x0	; 02328000
	ldr r1,[pool_02328128]	; 02328002
	add r2,r7,#0x0	; 02328004
	bl loc_0232E808	; 02328006
	cmp r0,#0x0	; 0232800A
	blt loc_02328012	; 0232800C
	mov r4,#0x1	; 0232800E
	b loc_02327EB0	; 02328010
loc_02328012:
	ldr r4,[sp,#0xa8]	; 02328012
	b loc_02327EB0	; 02328014
loc_02328016:
	ldr r0,[pool_02328120]	; 02328016
	ldr r0,[r0,#0x0]	; 02328018
	cmp r0,#0x1	; 0232801A
	beq loc_02328020	; 0232801C
	b loc_02327EB0	; 0232801E
loc_02328020:
	ldr r4,[sp,#0xac]	; 02328020
	ldr r0,[pool_0232812C]	; 02328022
	ldrh r0,[r0,#0x0]	; 02328024
	cmp r0,#0x0	; 02328026
	bne loc_023280E0	; 02328028
	cmp r6,#0x6	; 0232802A
	bls loc_02328030	; 0232802C
	b loc_02327EB0	; 0232802E
loc_02328030:
	add r0,r6,r6	; 02328030
P1_SwitchIndexPC_02328030:
	add r0,pc	; 02328032
	ldrh r0,[r0,#(P1_SwitchTable_02328030 - (P1_SwitchIndexPC_02328030 + 4))]	; 02328034
	lsl r0,r0,#0x10	; 02328036
	asr r0,r0,#0x10	; 02328038
P1_SwitchTargetPC_02328030:
	add r0,pc	; 0232803A
	bx r0	; 0232803C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02328030:
	.halfword (loc_02327EB0 + 1) - (P1_SwitchTargetPC_02328030 + 4)
	.halfword (loc_0232804C + 1) - (P1_SwitchTargetPC_02328030 + 4)
	.halfword (loc_02328056 + 1) - (P1_SwitchTargetPC_02328030 + 4)
	.halfword (loc_0232805A + 1) - (P1_SwitchTargetPC_02328030 + 4)
	.halfword (loc_0232805E + 1) - (P1_SwitchTargetPC_02328030 + 4)
	.halfword (loc_0232805E + 1) - (P1_SwitchTargetPC_02328030 + 4)
	.halfword (loc_023280D6 + 1) - (P1_SwitchTargetPC_02328030 + 4)
P1_SwitchTable_02328030End:
loc_0232804C:
	mov r0,#0x1	; 0232804C
	add sp,#0xb4	; 0232804E
	pop {r4,r5,r6,r7}	; 02328050
	pop {r3}	; 02328052
	bx r3	; 02328054
loc_02328056:
	add r6,r5,#0x0	; 02328056
	b loc_02327EB0	; 02328058
loc_0232805A:
	mov r6,#0x5	; 0232805A
	b loc_02327EB0	; 0232805C
loc_0232805E:
	ldr r0,[pool_02328110]	; 0232805E
	mov r1,#0x1	; 02328060
	blx P1_InvalidateDataCacheRange	; 02328062
	cmp r6,#0x4	; 02328066
	bne loc_02328084	; 02328068
	ldr r0,[pool_02328110]	; 0232806A
	ldrb r1,[r0,#0x0]	; 0232806C
	mov r0,#0x2	; 0232806E
	and r1,r0	; 02328070
	cmp r1,#0x0	; 02328072
	beq loc_0232807A	; 02328074
	mov r6,#0x3	; 02328076
	b loc_02327EB0	; 02328078
loc_0232807A:
	mov r0,#0x0	; 0232807A
	add sp,#0xb4	; 0232807C
	pop {r4,r5,r6,r7}	; 0232807E
	pop {r3}	; 02328080
	bx r3	; 02328082
loc_02328084:
	ldr r0,[pool_02328110]	; 02328084
	ldrb r1,[r0,#0x0]	; 02328086
	add r2,r1,#0x0	; 02328088
	mov r0,#0x1	; 0232808A
	and r2,r0	; 0232808C
	cmp r2,#0x0	; 0232808E
	beq loc_023280E2	; 02328090
	mov r0,#0x20	; 02328092
	and r1,r0	; 02328094
	cmp r1,#0x0	; 02328096
	bne loc_023280CA	; 02328098
	bl loc_0232BF44	; 0232809A
	add r3,r0,#0x0	; 0232809E
	add r2,r1,#0x0	; 023280A0
	ldr r0,[sp,#0x14]	; 023280A2
	sub r1,r3,r0	; 023280A4
	ldr r0,[sp,#0x10]	; 023280A6
	sbc r2,r0	; 023280A8
	lsr r0,r1,#0x1a	; 023280AA
	lsl r2,r2,#0x6	; 023280AC
	orr r2,r0	; 023280AE
	lsl r0,r1,#0x6	; 023280B0
	add r1,r2,#0x0	; 023280B2
	ldr r2,[pool_02328130]	; 023280B4
	ldr r3,[sp,#0xb0]	; 023280B6
	blx loc_0232CA54	; 023280B8
	add r3,r0,#0x0	; 023280BC
	add r2,r1,#0x0	; 023280BE
	mov r1,#0x0	; 023280C0
	ldr r0,[pool_02328134]	; 023280C2
	sub r0,r0,r3	; 023280C4
	sbc r1,r2	; 023280C6
	bcs loc_023280CE	; 023280C8
loc_023280CA:
	mov r6,#0x6	; 023280CA
	b loc_02327EB0	; 023280CC
loc_023280CE:
	ldr r0,[pool_02328138]	; 023280CE
	bl P1_SwiWaitByLoop	; 023280D0
	b loc_02327EB0	; 023280D4
loc_023280D6:
	lsl r0,r4,#0	; 023280D6
	add sp,#0xb4	; 023280D8
	pop {r4,r5,r6,r7}	; 023280DA
	pop {r3}	; 023280DC
	bx r3	; 023280DE
loc_023280E0:
	lsl r0,r4,#0	; 023280E0
loc_023280E2:
	add sp,#0xb4	; 023280E2
	pop {r4,r5,r6,r7}	; 023280E4
	pop {r3}	; 023280E6
	bx r3	; 023280E8
	.byte 0xC0, 0x46	; 023280EC
pool_023280EC:
loc_023280EC:
	.word 0x02002300	; 023280EC
pool_023280F0:
loc_023280F0:
	.word 0x0000FFFF	; 023280F0
pool_023280F4:
loc_023280F4:
	.word 0x00010000	; 023280F4
pool_023280F8:
loc_023280F8:
	.word 0x00030000	; 023280F8
pool_023280FC:
loc_023280FC:
	.word 0x00040000	; 023280FC
pool_02328100:
loc_02328100:
	.word 0x01050000	; 02328100
pool_02328104:
loc_02328104:
	.word 0x02002500	; 02328104
pool_02328108:
loc_02328108:
	.word 0x00020000	; 02328108
pool_0232810C:
loc_0232810C:
	.word 0x01040000	; 0232810C
pool_02328110:
loc_02328110:
	.word P1_BssStart + 0x257E0	; 02328110
pool_02328114:
loc_02328114:
	.word 0x02002200	; 02328114
pool_02328118:
loc_02328118:
	.word 0x0000FF00	; 02328118
pool_0232811C:
loc_0232811C:
	.word 0x01020000	; 0232811C
pool_02328120:
loc_02328120:
	.word P1_BssStart + 0x25754	; 02328120
pool_02328124:
loc_02328124:
	.word 0x03002000	; 02328124
pool_02328128:
loc_02328128:
	.word 0x03002D00	; 02328128
pool_0232812C:
loc_0232812C:
	.word P1_BssStart + 0x2574C	; 0232812C
pool_02328130:
loc_02328130:
	.word 0x000082EA	; 02328130
pool_02328134:
loc_02328134:
	.word 0x00000FA0	; 02328134
pool_02328138:
loc_02328138:
	.word 0x00004000	; 02328138

; ===== function loc_0232813C =====
loc_0232813C:
	push {r4,r5,r6,r7,lr}	; 0232813C
	sub sp,#0x4	; 0232813E
	add r7,r0,#0x0	; 02328140
	mov r6,#0x0	; 02328142
	add r5,r6,#0x0	; 02328144
loc_02328146:
	lsl r0,r5,#0x7	; 02328146
	add r4,r7,r0	; 02328148
	ldr r0,[pool_023281F4]	; 0232814A
	add r1,r4,#0x0	; 0232814C
	mov r2,#0x70	; 0232814E
	bl loc_0232C726	; 02328150
	add r1,r4,#0x0	; 02328154
	add r1,#0x72	; 02328156
	ldrh r1,[r1,#0x0]	; 02328158
	cmp r0,r1	; 0232815A
	bne loc_02328182	; 0232815C
	add r0,r4,#0x0	; 0232815E
	add r0,#0x70	; 02328160
	ldrh r0,[r0,#0x0]	; 02328162
	cmp r0,#0x80	; 02328164
	bcs loc_02328182	; 02328166
	ldrb r0,[r4,#0x0]	; 02328168
	cmp r0,#0x5	; 0232816A
	bne loc_02328182	; 0232816C
	add r0,r4,#0x0	; 0232816E
	bl loc_023282B0	; 02328170
	cmp r0,#0x0	; 02328174
	beq loc_02328182	; 02328176
	mov r0,#0x1	; 02328178
	lsl r0,r5	; 0232817A
	orr r6,r0	; 0232817C
	lsl r0,r6,#0x10	; 0232817E
	lsr r6,r0,#0x10	; 02328180
loc_02328182:
	add r0,r5,#0x1	; 02328182
	lsl r0,r0,#0x10	; 02328184
	lsr r5,r0,#0x10	; 02328186
	cmp r5,#0x2	; 02328188
	bcc loc_02328146	; 0232818A
	cmp r6,#0x3	; 0232818C
	bne loc_023281B8	; 0232818E
	add r0,r7,#0x0	; 02328190
	add r0,#0x70	; 02328192
	ldrh r0,[r0,#0x0]	; 02328194
	add r1,r0,#0x1	; 02328196
	mov r0,#0x7f	; 02328198
	and r1,r0	; 0232819A
	lsl r0,r1,#0x18	; 0232819C
	lsr r1,r0,#0x18	; 0232819E
	add r7,#0xf0	; 023281A0
	ldrh r0,[r7,#0x0]	; 023281A2
	cmp r1,r0	; 023281A4
	bne loc_023281B0	; 023281A6
	mov r1,#0x1	; 023281A8
	ldr r0,[pool_023281F8]	; 023281AA
	strh r1,[r0,#0x0]	; 023281AC
	b loc_023281E8	; 023281AE
loc_023281B0:
	mov r1,#0x0	; 023281B0
	ldr r0,[pool_023281F8]	; 023281B2
	strh r1,[r0,#0x0]	; 023281B4
	b loc_023281E8	; 023281B6
loc_023281B8:
	cmp r6,#0x0	; 023281B8
	beq loc_023281DE	; 023281BA
	mov r1,#0x0	; 023281BC
	ldr r0,[pool_023281F8]	; 023281BE
	strh r1,[r0,#0x0]	; 023281C0
	mov r2,#0x1	; 023281C2
loc_023281C4:
	ldrh r1,[r0,#0x0]	; 023281C4
	add r3,r2,#0x0	; 023281C6
	lsl r3,r1	; 023281C8
	add r4,r6,#0x0	; 023281CA
	and r4,r3	; 023281CC
	cmp r4,#0x0	; 023281CE
	bne loc_023281E8	; 023281D0
	add r1,r1,#0x1	; 023281D2
	strh r1,[r0,#0x0]	; 023281D4
	ldrh r1,[r0,#0x0]	; 023281D6
	cmp r1,#0x2	; 023281D8
	bcc loc_023281C4	; 023281DA
	b loc_023281E8	; 023281DC
loc_023281DE:
	mov r0,#0x1	; 023281DE
	add sp,#0x4	; 023281E0
	pop {r4,r5,r6,r7}	; 023281E2
	pop {r3}	; 023281E4
	bx r3	; 023281E6
loc_023281E8:
	mov r0,#0x0	; 023281E8
	add sp,#0x4	; 023281EA
	pop {r4,r5,r6,r7}	; 023281EC
	pop {r3}	; 023281EE
	bx r3	; 023281F0
	.byte 0xC0, 0x46	; 023281F4
pool_023281F4:
loc_023281F4:
	.word 0x0000FFFF	; 023281F4
pool_023281F8:
loc_023281F8:
	.word P1_Data_02330850	; 023281F8

; ===== function loc_023281FC =====
loc_023281FC:
	push {r4,r5,r6,r7,lr}	; 023281FC
	sub sp,#0x4	; 023281FE
	add r4,r0,#0x0	; 02328200
	ldr r0,[pool_02328298]	; 02328202
	ldrh r0,[r0,#0x0]	; 02328204
	cmp r0,#0xff	; 02328206
	bne loc_0232821A	; 02328208
	mov r0,#0x0	; 0232820A
	bl loc_02328328	; 0232820C
	cmp r0,#0x0	; 02328210
	beq loc_0232821A	; 02328212
	mov r1,#0x0	; 02328214
	ldr r0,[pool_02328298]	; 02328216
	strh r1,[r0,#0x0]	; 02328218
loc_0232821A:
	mov r0,#0x5	; 0232821A
	strb r0,[r4,#0x0]	; 0232821C
	ldr r3,[pool_0232829C]	; 0232821E
	mov r2,#0xe	; 02328220
loc_02328222:
	ldmia r4!,{r0,r1}	; 02328222
	stmia r3!,{r0,r1}	; 02328224
	sub r2,r2,#0x1	; 02328226
	cmp r2,#0x0	; 02328228
	bne loc_02328222	; 0232822A
	ldr r0,[pool_023282A0]	; 0232822C
	ldr r1,[pool_0232829C]	; 0232822E
	mov r2,#0x70	; 02328230
	bl loc_0232C726	; 02328232
	ldr r1,[pool_0232829C]	; 02328236
	add r1,#0x72	; 02328238
	strh r0,[r1,#0x0]	; 0232823A
	ldr r1,[pool_023282A4]	; 0232823C
	ldrh r2,[r1,#0x0]	; 0232823E
	ldr r0,[pool_0232829C]	; 02328240
	add r0,#0x70	; 02328242
	strh r2,[r0,#0x0]	; 02328244
	ldrh r0,[r1,#0x0]	; 02328246
	add r2,r0,#0x1	; 02328248
	mov r0,#0x7f	; 0232824A
	and r2,r0	; 0232824C
	lsl r0,r2,#0x18	; 0232824E
	lsr r0,r0,#0x18	; 02328250
	strh r0,[r1,#0x0]	; 02328252
	ldr r0,[pool_0232829C]	; 02328254
	mov r1,#0x80	; 02328256
	blx P1_CleanAndInvalidateDataCacheRange	; 02328258
	mov r0,#0x8	; 0232825C
	sub r5,r0,#0x1	; 0232825E
	ldr r4,[pool_02328298]	; 02328260
	ldr r6,[pool_023282A8]	; 02328262
	mov r7,#0x1	; 02328264
loc_02328266:
	ldrh r0,[r4,#0x0]	; 02328266
	eor r0,r7	; 02328268
	strh r0,[r4,#0x0]	; 0232826A
	mov r0,#0x2	; 0232826C
	ldr r1,[r6,#0x0]	; 0232826E
	ldrh r2,[r4,#0x0]	; 02328270
	lsl r2,r2,#0x8	; 02328272
	add r1,r1,r2	; 02328274
	mov r2,#0x80	; 02328276
	ldr r3,[pool_0232829C]	; 02328278
	bl loc_02327DCC	; 0232827A
	cmp r0,#0x0	; 0232827E
	bne loc_02328290	; 02328280
	ldr r0,[pool_023282AC]	; 02328282
	bl P1_SwiWaitByLoop	; 02328284
	add r0,r5,#0x0	; 02328288
	sub r5,r5,#0x1	; 0232828A
	cmp r0,#0x0	; 0232828C
	bne loc_02328266	; 0232828E
loc_02328290:
	add sp,#0x4	; 02328290
	pop {r4,r5,r6,r7}	; 02328292
	pop {r3}	; 02328294
	bx r3	; 02328296
pool_02328298:
loc_02328298:
	.word P1_Data_02330850	; 02328298
pool_0232829C:
loc_0232829C:
	.word P1_BssStart + 0x25760	; 0232829C
pool_023282A0:
loc_023282A0:
	.word 0x0000FFFF	; 023282A0
pool_023282A4:
loc_023282A4:
	.word P1_BssStart + 0x25750	; 023282A4
pool_023282A8:
loc_023282A8:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 023282A8
pool_023282AC:
loc_023282AC:
	.word 0x00004000	; 023282AC

; ===== function loc_023282B0 =====
loc_023282B0:
	add r1,r0,#0x0	; 023282B0
	add r1,#0x64	; 023282B2
	ldrh r1,[r1,#0x0]	; 023282B4
	lsl r2,r1,#0x12	; 023282B6
	lsr r2,r2,#0x1f	; 023282B8
	cmp r2,#0x0	; 023282BA
	beq loc_023282CA	; 023282BC
	lsl r1,r1,#0x1d	; 023282BE
	lsr r1,r1,#0x1d	; 023282C0
	cmp r1,#0x6	; 023282C2
	bcc loc_023282CA	; 023282C4
	mov r0,#0x0	; 023282C6
	bx lr	; 023282C8
loc_023282CA:
	add r1,r0,#0x0	; 023282CA
	add r1,#0x64	; 023282CC
	ldrh r1,[r1,#0x0]	; 023282CE
	lsl r1,r1,#0x15	; 023282D0
	lsr r1,r1,#0x1f	; 023282D2
	cmp r1,#0x0	; 023282D4
	beq loc_023282E8	; 023282D6
	ldrb r1,[r0,#0x3]	; 023282D8
	cmp r1,#0xc	; 023282DA
	bhi loc_023282E4	; 023282DC
	ldrb r1,[r0,#0x4]	; 023282DE
	cmp r1,#0x1f	; 023282E0
	bls loc_023282E8	; 023282E2
loc_023282E4:
	mov r0,#0x0	; 023282E4
	bx lr	; 023282E6
loc_023282E8:
	add r1,r0,#0x0	; 023282E8
	add r1,#0x64	; 023282EA
	ldrh r1,[r1,#0x0]	; 023282EC
	lsl r1,r1,#0x10	; 023282EE
	lsr r1,r1,#0x1f	; 023282F0
	cmp r1,#0x0	; 023282F2
	beq loc_02328300	; 023282F4
	ldrb r1,[r0,#0x1a]	; 023282F6
	cmp r1,#0xa	; 023282F8
	bls loc_02328300	; 023282FA
	mov r0,#0x0	; 023282FC
	bx lr	; 023282FE
loc_02328300:
	add r1,r0,#0x0	; 02328300
	add r1,#0x50	; 02328302
	ldrb r1,[r1,#0x0]	; 02328304
	cmp r1,#0x1a	; 02328306
	bls loc_0232830E	; 02328308
	mov r0,#0x0	; 0232830A
	bx lr	; 0232830C
loc_0232830E:
	add r1,r0,#0x0	; 0232830E
	add r1,#0x52	; 02328310
	ldrb r1,[r1,#0x0]	; 02328312
	cmp r1,#0x17	; 02328314
	bhi loc_02328320	; 02328316
	add r0,#0x53	; 02328318
	ldrb r0,[r0,#0x0]	; 0232831A
	cmp r0,#0x3b	; 0232831C
	bls loc_02328324	; 0232831E
loc_02328320:
	mov r0,#0x0	; 02328320
	bx lr	; 02328322
loc_02328324:
	mov r0,#0x1	; 02328324
	bx lr	; 02328326

; ===== function loc_02328328 =====
loc_02328328:
	push {r4,r5,r6,r7,lr}	; 02328328
	sub sp,#0xc	; 0232832A
	str r0,[sp,#0x0]	; 0232832C
	mov r0,#0x0	; 0232832E
	str r0,[sp,#0x4]	; 02328330
	ldr r5,[pool_023283BC]	; 02328332
	mov r0,#0x4	; 02328334
	ldr r1,[pool_023283C0]	; 02328336
	bl P1_SetPxiReceiveCallback	; 02328338
	mov r6,#0x1	; 0232833C
	ldr r4,[pool_023283C4]	; 0232833E
	mov r7,#0x80	; 02328340
loc_02328342:
	add r0,r6,#0x0	; 02328342
	ldr r1,[r4,#0x0]	; 02328344
	add r2,r7,#0x0	; 02328346
	add r3,r5,#0x0	; 02328348
	bl loc_02327DCC	; 0232834A
	cmp r0,#0x0	; 0232834E
	beq loc_02328342	; 02328350
	mov r7,#0x1	; 02328352
	ldr r4,[pool_023283C4]	; 02328354
	ldr r6,[pool_023283C8]	; 02328356
loc_02328358:
	add r0,r7,#0x0	; 02328358
	ldr r1,[r4,#0x0]	; 0232835A
	add r1,r1,r6	; 0232835C
	mov r2,#0x80	; 0232835E
	add r3,r5,#0x0	; 02328360
	add r3,#0x80	; 02328362
	bl loc_02327DCC	; 02328364
	cmp r0,#0x0	; 02328368
	beq loc_02328358	; 0232836A
	add r0,r5,#0x0	; 0232836C
	ldr r1,[pool_023283C8]	; 0232836E
	blx P1_InvalidateDataCacheRange	; 02328370
	add r0,r5,#0x0	; 02328374
	bl loc_0232813C	; 02328376
	cmp r0,#0x0	; 0232837A
	beq loc_02328388	; 0232837C
	mov r0,#0x1	; 0232837E
	str r0,[sp,#0x4]	; 02328380
	ldr r1,[pool_023283CC]	; 02328382
	strh r0,[r1,#0x0]	; 02328384
	b loc_023283B0	; 02328386
loc_02328388:
	ldr r0,[pool_023283D0]	; 02328388
	ldrh r0,[r0,#0x0]	; 0232838A
	lsl r0,r0,#0x7	; 0232838C
	add r0,r5,r0	; 0232838E
	add r1,r0,#0x0	; 02328390
	add r1,#0x70	; 02328392
	ldrh r1,[r1,#0x0]	; 02328394
	add r2,r1,#0x1	; 02328396
	mov r1,#0x7f	; 02328398
	and r2,r1	; 0232839A
	lsl r1,r2,#0x18	; 0232839C
	lsr r2,r1,#0x18	; 0232839E
	ldr r1,[pool_023283CC]	; 023283A0
	strh r2,[r1,#0x0]	; 023283A2
	ldr r1,[sp,#0x0]	; 023283A4
	cmp r1,#0x0	; 023283A6
	beq loc_023283B0	; 023283A8
	mov r2,#0x38	; 023283AA
	bl loc_0232C71A	; 023283AC
loc_023283B0:
	ldr r0,[sp,#0x4]	; 023283B0
	add sp,#0xc	; 023283B2
	pop {r4,r5,r6,r7}	; 023283B4
	pop {r3}	; 023283B6
	bx r3	; 023283B8
	.byte 0xC0, 0x46	; 023283BC
pool_023283BC:
loc_023283BC:
	.word 0x02356120	; 023283BC
pool_023283C0:
loc_023283C0:
	.word P1_PxiCallback_02327DA0 + 1	; 023283C0
pool_023283C4:
loc_023283C4:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 023283C4
pool_023283C8:
loc_023283C8:
	.word 0x00000100	; 023283C8
pool_023283CC:
loc_023283CC:
	.word P1_BssStart + 0x25750	; 023283CC
pool_023283D0:
loc_023283D0:
	.word P1_Data_02330850	; 023283D0

; ===== function loc_023283D4 =====
loc_023283D4:
	push {r4,r5}	; 023283D4
	mov r4,#0x3	; 023283D6
	mov r3,#0x0	; 023283D8
loc_023283DA:
	ldrb r2,[r0,#0x0]	; 023283DA
	ror r3,r4	; 023283DC
	mov r5,#0x4	; 023283DE
loc_023283E0:
	eor r3,r2	; 023283E0
	lsl r2,r2,#0x8	; 023283E2
	sub r5,#0x1	; 023283E4
	bgt loc_023283E0	; 023283E6
	add r0,#0x1	; 023283E8
	sub r1,#0x1	; 023283EA
	bgt loc_023283DA	; 023283EC
	add r0,r3,#0x0	; 023283EE
	lsl r0,r0,#0x1b	; 023283F0
	lsr r0,r0,#0x1e	; 023283F2
	pop {r4,r5}	; 023283F4
	bx lr	; 023283F6

; ===== function loc_023283F8 =====
loc_023283F8:
	add r2,r0,#0x0	; 023283F8
	mov r0,#0x14	; 023283FA
	mul r1,r0	; 023283FC
	ldr r0,[pool_0232840C]	; 023283FE
	add r0,r1,r0	; 02328400
	add r1,r2,r1	; 02328402
	mov r2,#0xa	; 02328404
	ldr r3,[pool_02328410]	; 02328406
	bx r3	; 02328408
	.byte 0xC0, 0x46	; 0232840C
pool_0232840C:
loc_0232840C:
	.word 0x08000004	; 0232840C
pool_02328410:
loc_02328410:
	.word P1_SwiCpuSet + 1	; 02328410

; ===== function loc_02328414 =====
loc_02328414:
	push {r4,r5,r6,r7,lr}	; 02328414
	sub sp,#0x4	; 02328416
	add r6,r0,#0x0	; 02328418
	ldr r0,[pool_02328480]	; 0232841A
	ldrb r1,[r0,#0x0]	; 0232841C
	mov r0,#0x80	; 0232841E
	and r1,r0	; 02328420
	cmp r1,#0x0	; 02328422
	beq loc_0232842A	; 02328424
	ldr r0,[pool_02328484]	; 02328426
	b loc_0232842C	; 02328428
loc_0232842A:
	ldr r0,[pool_02328488]	; 0232842A
loc_0232842C:
	add r1,r6,#0x0	; 0232842C
	mov r2,#0xa	; 0232842E
	bl loc_0232C71A	; 02328430
	ldr r0,[pool_0232848C]	; 02328434
	sub r0,r0,#0x1	; 02328436
	mov r1,#0x1b	; 02328438
	bl loc_023283D4	; 0232843A
	ldr r3,[pool_02328490]	; 0232843E
	ldr r1,[pool_0232848C]	; 02328440
	ldrb r2,[r1,#0x0]	; 02328442
	mov r1,#0x3	; 02328444
	and r2,r1	; 02328446
	mov r1,#0x30	; 02328448
	mul r2,r1	; 0232844A
	add r2,r3,r2	; 0232844C
	mov r1,#0xc	; 0232844E
	mul r0,r1	; 02328450
	add r5,r2,r0	; 02328452
	mov r4,#0x0	; 02328454
	ldr r7,[pool_02328494]	; 02328456
loc_02328458:
	add r0,r6,#0x0	; 02328458
	add r1,r4,#0x0	; 0232845A
	bl loc_023283F8	; 0232845C
	cmp r4,#0x3	; 02328460
	blt loc_02328470	; 02328462
	cmp r4,#0x9	; 02328464
	bge loc_02328470	; 02328466
	ldrh r0,[r5,#0x0]	; 02328468
	add r5,r5,#0x2	; 0232846A
	lsl r0,r0,#0x1	; 0232846C
	ldrh r0,[r0,r7]	; 0232846E
loc_02328470:
	add r4,r4,#0x1	; 02328470
	cmp r4,#0xb	; 02328472
	blt loc_02328458	; 02328474
	add sp,#0x4	; 02328476
	pop {r4,r5,r6,r7}	; 02328478
	pop {r3}	; 0232847A
	bx r3	; 0232847C
	.byte 0xC0, 0x46	; 02328480
pool_02328480:
loc_02328480:
	.word 0x080000B4	; 02328480
pool_02328484:
loc_02328484:
	.word 0x09FE1FE0	; 02328484
pool_02328488:
loc_02328488:
	.word 0x09FFFFE0	; 02328488
pool_0232848C:
loc_0232848C:
	.word 0x0800009E	; 0232848C
pool_02328490:
loc_02328490:
	.word 0x02330854	; 02328490
pool_02328494:
loc_02328494:
	.word 0x08000000	; 02328494

; ===== function loc_02328498 =====
loc_02328498:
	push {r4,r5,r6,r7}	; 02328498
	mov r5,#0x0	; 0232849A
	ldr r3,[pool_023284E0]	; 0232849C
	ldr r2,[pool_023284E4]	; 0232849E
	mov r1,#0x3	; 023284A0
	add r4,r2,#0x0	; 023284A2
	eor r4,r1	; 023284A4
	lsl r1,r4,#0x10	; 023284A6
	lsr r1,r1,#0x10	; 023284A8
	mov r6,#0x84	; 023284AA
loc_023284AC:
	add r4,r2,#0x0	; 023284AC
	cmp r5,#0x4c	; 023284AE
	bne loc_023284BA	; 023284B0
	eor r4,r6	; 023284B2
	lsl r4,r4,#0x10	; 023284B4
	lsr r4,r4,#0x10	; 023284B6
	b loc_023284C0	; 023284B8
loc_023284BA:
	cmp r5,#0x4d	; 023284BA
	bne loc_023284C0	; 023284BC
	add r4,r1,#0x0	; 023284BE
loc_023284C0:
	ldrh r7,[r0,#0x0]	; 023284C0
	and r4,r7	; 023284C2
	ldrh r7,[r3,#0x0]	; 023284C4
	cmp r4,r7	; 023284C6
	beq loc_023284D0	; 023284C8
	mov r0,#0x0	; 023284CA
	pop {r4,r5,r6,r7}	; 023284CC
	bx lr	; 023284CE
loc_023284D0:
	add r3,r3,#0x2	; 023284D0
	add r0,r0,#0x2	; 023284D2
	add r5,r5,#0x1	; 023284D4
	cmp r5,#0x4e	; 023284D6
	blt loc_023284AC	; 023284D8
	mov r0,#0x1	; 023284DA
	pop {r4,r5,r6,r7}	; 023284DC
	bx lr	; 023284DE
pool_023284E0:
loc_023284E0:
	.word 0xFFFF0020	; 023284E0
pool_023284E4:
loc_023284E4:
	.word 0x0000FFFF	; 023284E4

; ===== function loc_023284E8 =====
loc_023284E8:
	push {r4,lr}	; 023284E8
	mov r0,#0x6d	; 023284EA
	bl loc_0232B30C	; 023284EC
	ldr r0,[pool_0232850C]	; 023284F0
	bl loc_02328414	; 023284F2
	ldr r0,[pool_0232850C]	; 023284F6
	bl loc_02328498	; 023284F8
	add r4,r0,#0x0	; 023284FC
	mov r0,#0x6d	; 023284FE
	bl loc_0232B1A4	; 02328500
	add r0,r4,#0x0	; 02328504
	pop {r4}	; 02328506
	pop {r3}	; 02328508
	bx r3	; 0232850A
pool_0232850C:
loc_0232850C:
	.word 0x02356220	; 0232850C

; ===== function loc_02328510 =====
loc_02328510:
	push {r0,r1,r2,r4,lr}	; 02328510
	ldr r0,[pool_02328554]	; 02328512
	add r1,r2,#0x0	; 02328514
	add r4,r1,#0x0	; 02328516
	mov r2,#0x24	; 02328518
	blx loc_0232DD74	; 0232851A
	ldr r0,[sp,#0x0]	; 0232851E
	mov r2,#0x24	; 02328520
	add r1,r4,r2	; 02328522
	mov r2,#0x9c	; 02328524
	blx loc_0232DD74	; 02328526
	add r0,r4,#0x0	; 0232852A
	ldr r1,[sp,#0x4]	; 0232852C
	mov r2,#0x1	; 0232852E
	lsl r2,r2,#0x8	; 02328530
	add r2,r2,r1	; 02328532
	ldr r3,[pool_02328558]	; 02328534
	bl loc_0232C73A	; 02328536
	ldr r0,[sp,#0x4]	; 0232853A
	ldr r2,[pool_0232855C]	; 0232853C
	str r2,[r0,#0x0]	; 0232853E
	add r1,r4,#0x0	; 02328540
	bl loc_02328564	; 02328542
	add r0,r4,#0x0	; 02328546
	ldr r1,[sp,#0x4]	; 02328548
	ldr r2,[pool_02328560]	; 0232854A
	bl loc_0232C72E	; 0232854C
	pop {r0,r1,r2,r4,pc}	; 02328550
	.byte 0xC0, 0x46	; 02328554
pool_02328554:
loc_02328554:
	.word 0x02330108	; 02328554
pool_02328558:
loc_02328558:
	.word 0x023300F4	; 02328558
pool_0232855C:
loc_0232855C:
	.word 0x0000D082	; 0232855C
pool_02328560:
loc_02328560:
	.word 0x02330914	; 02328560

; ===== function loc_02328564 =====
.func P1_SwiDiff16UnFilter
; BIOS SWI #18: differential 16-bit decompression. / BIOS SWI #18：差分 16 位解压。
loc_02328564:
	swi 0x18	; 02328564
	bx lr	; 02328566
.endfunc

; ===== function loc_02328568 =====
loc_02328568:
	ldr r0,[r0,#0x0]	; 02328568
	bx lr	; 0232856A
	ldrb r0,[r0,#0x0]	; 0232856C
	bx lr	; 0232856E
	mov r0,#0x0	; 02328570
	bx lr	; 02328572

; ===== function loc_02328574 =====
	push {lr}	; 02328574
	sub sp,#0x4	; 02328576
	cmp r2,#0x0	; 02328578
	beq loc_02328586	; 0232857A
	bl loc_02328568	; 0232857C
	add sp,#0x4	; 02328580
	pop {r3}	; 02328582
	bx r3	; 02328584
loc_02328586:
	mov r0,#0x0	; 02328586
	add sp,#0x4	; 02328588
	pop {r3}	; 0232858A
	bx r3	; 0232858C
	.byte 0x00, 0x00	; 02328590

; ===== function loc_02328590 =====
loc_02328590:
	push {r4,r5,r6,lr}	; 02328590
	sub sp,#0x100	; 02328592
	add r5,r1,#0x0	; 02328594
	add r4,r3,#0x0	; 02328596
	ldr r1,[pool_023285C4]	; 02328598
	ldr r3,[r1,#0x4]	; 0232859A
	ldr r6,[pool_023285C8]	; 0232859C
	and r3,r6	; 0232859E
	sub r6,r2,#0x1	; 023285A0
	ldr r2,[pool_023285CC]	; 023285A2
	and r6,r2	; 023285A4
	orr r3,r6	; 023285A6
	str r3,[r1,#0x4]	; 023285A8
	add r1,r4,#0x0	; 023285AA
	add r2,sp,#0x0	; 023285AC
	bl loc_02328510	; 023285AE
	add r0,r4,#0x0	; 023285B2
	add r1,r5,#0x0	; 023285B4
	ldr r2,[pool_023285D0]	; 023285B6
	blx loc_0232DE08	; 023285B8
	add sp,#0x100	; 023285BC
	pop {r4,r5,r6}	; 023285BE
	pop {r3}	; 023285C0
	bx r3	; 023285C2
pool_023285C4:
loc_023285C4:
	.word P1_Data_02330914	; 023285C4
pool_023285C8:
loc_023285C8:
	.word 0x80000000	; 023285C8
pool_023285CC:
loc_023285CC:
	.word 0x7FFFFFFF	; 023285CC
pool_023285D0:
loc_023285D0:
	.word 0x00000340	; 023285D0
.arm

; ===== function loc_023285D4 =====
loc_023285D4:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}	; 023285D4
	sub sp,sp,#0x4	; 023285D8
	ldr r4,[r1,#0x4]	; 023285DC
	eor r5,r4,r4, ror #0x10	; 023285E0
	bic r5,r5,#0xff0000	; 023285E4
	mov r4,r4, ror #0x8	; 023285E8
	eor r4,r4,r5, lsr #0x8	; 023285EC
	bic r4,r4,#0xff000000	; 023285F0
	str r4,[sp,#0x0]	; 023285F4
	add r5,r0,r4	; 023285F8
	ldr r6,[pool_023289EC]	; 023285FC
	cmp r5,r6	; 02328600
	bls loc_02328614	; 02328604
	mov r0,#0x0	; 02328608
	add sp,sp,#0x4	; 0232860C
	bl loc_0232893C	; 02328610
loc_02328614:
	ldr r5,[r1,#0x8]	; 02328614
	eor r6,r5,r5, ror #0x10	; 02328618
	bic r6,r6,#0xff0000	; 0232861C
	mov r5,r5, ror #0x8	; 02328620
	eor r5,r5,r6, lsr #0x8	; 02328624
	ldr r2,[pool_023289F0]	; 02328628
	add r3,r1,#0xc	; 0232862C
	str r3,[r2,#0x10]	; 02328630
	add r3,r1,r5	; 02328634
	str r3,[r2,#0x14]	; 02328638
	mov r3,#0x0	; 0232863C
	str r3,[r2,#0x0]	; 02328640
	str r3,[r2,#0x4]	; 02328644
	mov r3,#0x200	; 02328648
	str r3,[r2,#0x8]	; 0232864C
	mov r3,#0x800	; 02328650
	str r3,[r2,#0xc]	; 02328654
	ldr r11,[pool_023289F0]	; 02328658
	mov r12,#0x20	; 0232865C
	bl loc_02328944	; 02328660
	ldr r11,[pool_023289F4]	; 02328664
	mov r12,#0x20	; 02328668
	bl loc_02328944	; 0232866C
	ldr r11,[pool_023289F0]	; 02328670
	ldr r2,[pool_023289F8]	; 02328674
	mov r1,r2	; 02328678
	ldr r5,[r11,#0x8]	; 0232867C
	mov r6,r5	; 02328680
loc_02328684:
	ldr r8,[r11,#0x0]	; 02328684
	ldr r9,[r11,#0x10]	; 02328688
	ldr r10,[r11,#0x18]	; 0232868C
	mov r7,r10, lsr #0x1f	; 02328690
	cmp r8,#0x1f	; 02328694
	bne loc_023286BC	; 02328698
	ldr r3,[r9],#0x4	; 0232869C
	eor r10,r3,r3, ror #0x10	; 023286A0
	bic r10,r10,#0xff0000	; 023286A4
	mov r3,r3, ror #0x8	; 023286A8
	eor r3,r3,r10, lsr #0x8	; 023286AC
	str r9,[r11,#0x10]	; 023286B0
	mov r8,#0x0	; 023286B4
	b loc_023286C4	; 023286B8
loc_023286BC:
	mov r3,r10, lsl #0x1	; 023286BC
	add r8,r8,#0x1	; 023286C0
loc_023286C4:
	str r3,[r11,#0x18]	; 023286C4
	str r8,[r11,#0x0]	; 023286C8
	cmp r7,#0x0	; 023286CC
	beq loc_023286F0	; 023286D0
	orr r8,r5,#0x8000	; 023286D4
	orr r9,r5,#0x4000	; 023286D8
	strh r8,[r2],#0x2	; 023286DC
	strh r9,[r2],#0x2	; 023286E0
	add r5,r5,#0x1	; 023286E4
	add r6,r6,#0x1	; 023286E8
	b loc_02328684	; 023286EC
loc_023286F0:
	mov r12,#0x9	; 023286F0
	bl loc_02328944	; 023286F4
	mov r10,#0x4000	; 023286F8
	ldr r12,[pool_023289FC]	; 023286FC
	ldr r3,[pool_02328A00]	; 02328700
	sub r10,r10,#0x1	; 02328704
loc_02328708:
	ldrh r8,[r2,#-0x2]!	; 02328708
	and r9,r8,r10	; 0232870C
	mov lr,r9, lsl #0x1	; 02328710
	tst r8,#0x8000	; 02328714
	beq loc_02328730	; 02328718
	strh r7,[r3,lr]	; 0232871C
	mov r7,r9	; 02328720
	cmp r2,r1	; 02328724
	bne loc_02328708	; 02328728
	b loc_0232873C	; 0232872C
loc_02328730:
	strh r7,[r12,lr]	; 02328730
	mov r5,r6	; 02328734
	b loc_02328684	; 02328738
loc_0232873C:
	str r7,[r11,#0x20]	; 0232873C
	ldr r11,[pool_023289F4]	; 02328740
	ldr r2,[pool_023289F8]	; 02328744
	mov r1,r2	; 02328748
	ldr r5,[r11,#0x8]	; 0232874C
	mov r6,r5	; 02328750
loc_02328754:
	ldr r8,[r11,#0x0]	; 02328754
	ldr r9,[r11,#0x10]	; 02328758
	ldr r10,[r11,#0x18]	; 0232875C
	mov r7,r10, lsr #0x1f	; 02328760
	cmp r8,#0x1f	; 02328764
	bne loc_0232878C	; 02328768
	ldr r3,[r9],#0x4	; 0232876C
	eor r10,r3,r3, ror #0x10	; 02328770
	bic r10,r10,#0xff0000	; 02328774
	mov r3,r3, ror #0x8	; 02328778
	eor r3,r3,r10, lsr #0x8	; 0232877C
	str r9,[r11,#0x10]	; 02328780
	mov r8,#0x0	; 02328784
	b loc_02328794	; 02328788
loc_0232878C:
	mov r3,r10, lsl #0x1	; 0232878C
	add r8,r8,#0x1	; 02328790
loc_02328794:
	str r3,[r11,#0x18]	; 02328794
	str r8,[r11,#0x0]	; 02328798
	cmp r7,#0x0	; 0232879C
	beq loc_023287C0	; 023287A0
	orr r8,r5,#0x8000	; 023287A4
	orr r9,r5,#0x4000	; 023287A8
	strh r8,[r2],#0x2	; 023287AC
	strh r9,[r2],#0x2	; 023287B0
	add r5,r5,#0x1	; 023287B4
	add r6,r6,#0x1	; 023287B8
	b loc_02328754	; 023287BC
loc_023287C0:
	mov r12,#0xb	; 023287C0
	bl loc_02328944	; 023287C4
	mov r10,#0x4000	; 023287C8
	ldr r12,[pool_02328A04]	; 023287CC
	ldr r3,[pool_02328A08]	; 023287D0
	sub r10,r10,#0x1	; 023287D4
loc_023287D8:
	ldrh r8,[r2,#-0x2]!	; 023287D8
	and r9,r8,r10	; 023287DC
	mov lr,r9, lsl #0x1	; 023287E0
	tst r8,#0x8000	; 023287E4
	beq loc_02328800	; 023287E8
	strh r7,[r3,lr]	; 023287EC
	mov r7,r9	; 023287F0
	cmp r2,r1	; 023287F4
	bne loc_023287D8	; 023287F8
	b loc_0232880C	; 023287FC
loc_02328800:
	strh r7,[r12,lr]	; 02328800
	mov r5,r6	; 02328804
	b loc_02328754	; 02328808
loc_0232880C:
	str r7,[r11,#0x20]	; 0232880C
loc_02328810:
	cmp r4,#0x0	; 02328810
	beq loc_02328938	; 02328814
	ldr r11,[pool_023289F0]	; 02328818
	ldr r1,[pool_023289FC]	; 0232881C
	ldr r2,[pool_02328A00]	; 02328820
	ldr r5,[r11,#0x20]	; 02328824
	ldr r8,[r11,#0x0]	; 02328828
	ldr r9,[r11,#0x10]	; 0232882C
	ldr r10,[r11,#0x18]	; 02328830
loc_02328834:
	cmp r5,#0x200	; 02328834
	bcc loc_02328880	; 02328838
	mov r7,r10, lsr #0x1f	; 0232883C
	cmp r8,#0x1f	; 02328840
	bne loc_02328864	; 02328844
	ldr r10,[r9],#0x4	; 02328848
	eor r3,r10,r10, ror #0x10	; 0232884C
	bic r3,r3,#0xff0000	; 02328850
	mov r10,r10, ror #0x8	; 02328854
	eor r10,r10,r3, lsr #0x8	; 02328858
	mov r8,#0x0	; 0232885C
	b loc_0232886C	; 02328860
loc_02328864:
	mov r10,r10, lsl #0x1	; 02328864
	add r8,r8,#0x1	; 02328868
loc_0232886C:
	mov r3,r5, lsl #0x1	; 0232886C
	cmp r7,#0x0	; 02328870
	ldreqh r5,[r1,r3]	; 02328874
	ldrneh r5,[r2,r3]	; 02328878
	b loc_02328834	; 0232887C
loc_02328880:
	str r8,[r11,#0x0]	; 02328880
	str r9,[r11,#0x10]	; 02328884
	str r10,[r11,#0x18]	; 02328888
	cmp r5,#0x100	; 0232888C
	bcs loc_023288A0	; 02328890
	strb r5,[r0],#0x1	; 02328894
	sub r4,r4,#0x1	; 02328898
	b loc_02328810	; 0232889C
loc_023288A0:
	ldr r11,[pool_023289F4]	; 023288A0
	ldr r1,[pool_02328A04]	; 023288A4
	ldr r2,[pool_02328A08]	; 023288A8
	ldr r6,[r11,#0x20]	; 023288AC
	ldr r8,[r11,#0x0]	; 023288B0
	ldr r9,[r11,#0x10]	; 023288B4
	ldr r10,[r11,#0x18]	; 023288B8
loc_023288BC:
	cmp r6,#0x800	; 023288BC
	bcc loc_02328908	; 023288C0
	mov r7,r10, lsr #0x1f	; 023288C4
	cmp r8,#0x1f	; 023288C8
	bne loc_023288EC	; 023288CC
	ldr r10,[r9],#0x4	; 023288D0
	eor r3,r10,r10, ror #0x10	; 023288D4
	bic r3,r3,#0xff0000	; 023288D8
	mov r10,r10, ror #0x8	; 023288DC
	eor r10,r10,r3, lsr #0x8	; 023288E0
	mov r8,#0x0	; 023288E4
	b loc_023288F4	; 023288E8
loc_023288EC:
	mov r10,r10, lsl #0x1	; 023288EC
	add r8,r8,#0x1	; 023288F0
loc_023288F4:
	mov r3,r6, lsl #0x1	; 023288F4
	cmp r7,#0x0	; 023288F8
	ldreqh r6,[r1,r3]	; 023288FC
	ldrneh r6,[r2,r3]	; 02328900
	b loc_023288BC	; 02328904
loc_02328908:
	str r8,[r11,#0x0]	; 02328908
	str r9,[r11,#0x10]	; 0232890C
	str r10,[r11,#0x18]	; 02328910
	sub r3,r0,r6	; 02328914
	sub r5,r5,#0xfd	; 02328918
	sub r3,r3,#0x1	; 0232891C
	sub r4,r4,r5	; 02328920
loc_02328924:
	ldrb r11,[r3],#0x1	; 02328924
	subs r5,r5,#0x1	; 02328928
	strb r11,[r0],#0x1	; 0232892C
	bne loc_02328924	; 02328930
	b loc_02328810	; 02328934
loc_02328938:
	ldr r0,[sp],#0x4	; 02328938

; ===== function loc_0232893C =====
loc_0232893C:
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}	; 0232893C
	bx lr	; 02328940

; ===== function loc_02328944 =====
loc_02328944:
	ldr r8,[r11,#0x0]	; 02328944
	ldr r9,[r11,#0x10]	; 02328948
	ldr r10,[r11,#0x18]	; 0232894C
	mov r7,#0x20	; 02328950
	sub r7,r7,r12	; 02328954
	mov r7,r10, lsr r7	; 02328958
	add r3,r8,r12	; 0232895C
	cmp r3,#0x20	; 02328960
	beq loc_023289B0	; 02328964
	bcc loc_023289D8	; 02328968
	ldr r3,[r9],#0x4	; 0232896C
	eor r10,r3,r3, ror #0x10	; 02328970
	bic r10,r10,#0xff0000	; 02328974
	mov r3,r3, ror #0x8	; 02328978
	eor r3,r3,r10, lsr #0x8	; 0232897C
	str r9,[r11,#0x10]	; 02328980
	mov r10,#0x40	; 02328984
	sub r9,r10,r12	; 02328988
	sub r9,r9,r8	; 0232898C
	mov r9,r3, lsr r9	; 02328990
	orr r7,r7,r9	; 02328994
	sub r12,r12,#0x20	; 02328998
	add r8,r8,r12	; 0232899C
	str r8,[r11,#0x0]	; 023289A0
	mov r12,r3, lsl r8	; 023289A4
	str r12,[r11,#0x18]	; 023289A8
	bx lr	; 023289AC
loc_023289B0:
	ldr r3,[r9],#0x4	; 023289B0
	eor r10,r3,r3, ror #0x10	; 023289B4
	bic r10,r10,#0xff0000	; 023289B8
	mov r3,r3, ror #0x8	; 023289BC
	eor r3,r3,r10, lsr #0x8	; 023289C0
	str r9,[r11,#0x10]	; 023289C4
	str r3,[r11,#0x18]	; 023289C8
	mov r3,#0x0	; 023289CC
	str r3,[r11,#0x0]	; 023289D0
	bx lr	; 023289D4
loc_023289D8:
	mov r3,r10, lsl r12	; 023289D8
	str r3,[r11,#0x18]	; 023289DC
	add r10,r8,r12	; 023289E0
	str r10,[r11,#0x0]	; 023289E4
	bx lr	; 023289E8
pool_023289EC:
loc_023289EC:
	.word 0x023FE000	; 023289EC
pool_023289F0:
loc_023289F0:
	.word 0x023DF120	; 023289F0
pool_023289F4:
loc_023289F4:
	.word 0x023DF124	; 023289F4
pool_023289F8:
loc_023289F8:
	.word 0x023DF160	; 023289F8
pool_023289FC:
loc_023289FC:
	.word 0x023E0360	; 023289FC
pool_02328A00:
loc_02328A00:
	.word 0x023DF360	; 02328A00
pool_02328A04:
loc_02328A04:
	.word 0x023E1360	; 02328A04
pool_02328A08:
loc_02328A08:
	.word 0x023E5360	; 02328A08
	.byte 0x10, 0xB5, 0x00, 0xF0, 0x3B, 0xF8, 0x04, 0x1C, 0x00, 0x2C, 0x24, 0xD0, 0x14, 0x48, 0x10, 0x30	; 02328A1C
	.byte 0x14, 0x49, 0x02, 0x22, 0x00, 0xF0, 0x54, 0xF8, 0x00, 0x28, 0x1C, 0xD1, 0x10, 0x48, 0x80, 0x7F	; 02328A2C
	.byte 0x00, 0x28, 0x18, 0xD1, 0x10, 0x4A, 0x61, 0x1E, 0xB8, 0x20, 0x41, 0x43, 0x54, 0x18, 0x0F, 0x48	; 02328A3C
	.byte 0x0F, 0x49, 0x10, 0x4A, 0x05, 0xF0, 0x0A, 0xEA, 0x20, 0x1C, 0x0F, 0x49, 0xB8, 0x22, 0x05, 0xF0	; 02328A4C
	.byte 0x06, 0xEA, 0x20, 0x1C, 0xB0, 0x30, 0x01, 0x68, 0xB4, 0x34, 0x20, 0x68, 0x01, 0x60, 0x01, 0x20	; 02328A5C
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02328A6C
	.byte 0x00, 0xFE, 0x7F, 0x02, 0x1C, 0x09, 0x33, 0x02, 0x2C, 0x02, 0x33, 0x02, 0x2C, 0x01, 0x33, 0x02	; 02328A7C
	.byte 0x00, 0x50, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x52, 0x00, 0x02, 0x00, 0xB5, 0x81, 0xB0	; 02328A8C
	.byte 0x0C, 0x48, 0x0D, 0x49, 0x04, 0x22, 0x00, 0xF0, 0x1B, 0xF8, 0x00, 0x28, 0x03, 0xD1, 0x01, 0x20	; 02328A9C
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x07, 0x48, 0x08, 0x49, 0x04, 0x22, 0x00, 0xF0, 0x10, 0xF8	; 02328AAC
	.byte 0x00, 0x28, 0x03, 0xD0, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x02, 0x20, 0x01, 0xB0	; 02328ABC
	.byte 0x08, 0xBC, 0x18, 0x47, 0x0C, 0xFE, 0x7F, 0x02, 0x20, 0x09, 0x33, 0x02, 0x28, 0x09, 0x33, 0x02	; 02328ACC
	.byte 0x10, 0xB4, 0x81, 0xB0, 0x00, 0x2A, 0x03, 0xD1, 0x00, 0x20, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47	; 02328ADC
	.byte 0x0C, 0x78, 0x03, 0x78, 0xA3, 0x42, 0x0C, 0xD1, 0x52, 0x1E, 0x00, 0x2A, 0x03, 0xD1, 0x00, 0x20	; 02328AEC
	.byte 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x40, 0x1C, 0x49, 0x1C, 0x0C, 0x78, 0x03, 0x78, 0xA3, 0x42	; 02328AFC
	.byte 0xF2, 0xD0, 0x18, 0x1B, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x00, 0x00	; 02328B08
.thumb

; ===== function loc_02328B08 =====
loc_02328B08:
	push {r4,lr}	; 02328B08
	add r4,r0,#0x0	; 02328B0A
	bl loc_02328EB4	; 02328B0C
	ldrh r1,[r4,#0x12]	; 02328B10
	cmp r0,r1	; 02328B12
	beq loc_02328B20	; 02328B14
	strh r0,[r4,#0x12]	; 02328B16
	mov r0,#0x1	; 02328B18
	pop {r4}	; 02328B1A
	pop {r3}	; 02328B1C
	bx r3	; 02328B1E
loc_02328B20:
	mov r0,#0x0	; 02328B20
	pop {r4}	; 02328B22
	pop {r3}	; 02328B24
	bx r3	; 02328B26

; ===== function loc_02328B28 =====
P1_Entry_02328B28:
	push {r4,lr}	; 02328B28
	add r4,r0,#0x0	; 02328B2A
	bl loc_02328EB4	; 02328B2C
	ldr r1,[r4,#0xc]	; 02328B30
	lsl r0,r0,#0x1	; 02328B32
	ldrb r0,[r1,r0]	; 02328B34
	pop {r4}	; 02328B36
	pop {r3}	; 02328B38
	bx r3	; 02328B3A

; ===== function loc_02328B3C =====
loc_02328B3C:
	ldrh r0,[r0,#0x16]	; 02328B3C
	lsl r0,r0,#0x16	; 02328B3E
	lsr r0,r0,#0x1b	; 02328B40
	ldrh r3,[r1,#0x0]	; 02328B42
	cmp r3,#0x0	; 02328B44
	beq loc_02328B58	; 02328B46
	add r2,r2,r0	; 02328B48
loc_02328B4A:
	cmp r3,#0xa	; 02328B4A
	bne loc_02328B50	; 02328B4C
	add r0,r0,r2	; 02328B4E
loc_02328B50:
	add r1,r1,#0x2	; 02328B50
	ldrh r3,[r1,#0x0]	; 02328B52
	cmp r3,#0x0	; 02328B54
	bne loc_02328B4A	; 02328B56
loc_02328B58:
	bx lr	; 02328B58
	.byte 0x00, 0x00	; 02328B5C

; ===== function loc_02328B5C =====
loc_02328B5C:
	push {r4,r5,r6,r7,lr}	; 02328B5C
	sub sp,#0x4	; 02328B5E
	add r5,r0,#0x0	; 02328B60
	add r6,r2,#0x0	; 02328B62
	mov r4,#0x0	; 02328B64
	str r4,[sp,#0x0]	; 02328B66
	cmp r1,#0x0	; 02328B68
	beq loc_02328B86	; 02328B6A
	add r7,sp,#0x0	; 02328B6C
loc_02328B6E:
	add r0,r5,#0x0	; 02328B6E
	add r2,r7,#0x0	; 02328B70
	add r3,r6,#0x0	; 02328B72
	bl loc_02328B90	; 02328B74
	add r1,r0,#0x0	; 02328B78
	ldr r0,[sp,#0x0]	; 02328B7A
	cmp r4,r0	; 02328B7C
	bge loc_02328B82	; 02328B7E
	add r4,r0,#0x0	; 02328B80
loc_02328B82:
	cmp r1,#0x0	; 02328B82
	bne loc_02328B6E	; 02328B84
loc_02328B86:
	add r0,r4,#0x0	; 02328B86
	add sp,#0x4	; 02328B88
	pop {r4,r5,r6,r7}	; 02328B8A
	pop {r3}	; 02328B8C
	bx r3	; 02328B8E

; ===== function loc_02328B90 =====
loc_02328B90:
	push {r4,r5,r6,r7,lr}	; 02328B90
	sub sp,#0x4	; 02328B92
	add r7,r0,#0x0	; 02328B94
	add r5,r1,#0x0	; 02328B96
	str r2,[sp,#0x0]	; 02328B98
	add r6,r3,#0x0	; 02328B9A
	mov r4,#0x0	; 02328B9C
	ldrh r1,[r5,#0x0]	; 02328B9E
	cmp r1,#0x0	; 02328BA0
	beq loc_02328BD8	; 02328BA2
loc_02328BA4:
	cmp r1,#0xa	; 02328BA4
	bne loc_02328BC2	; 02328BA6
	ldr r0,[sp,#0x0]	; 02328BA8
	cmp r0,#0x0	; 02328BAA
	beq loc_02328BB8	; 02328BAC
	cmp r4,r6	; 02328BAE
	ble loc_02328BB4	; 02328BB0
	sub r4,r4,r6	; 02328BB2
loc_02328BB4:
	ldr r0,[sp,#0x0]	; 02328BB4
	str r4,[r0,#0x0]	; 02328BB6
loc_02328BB8:
	add r0,r5,#0x2	; 02328BB8
	add sp,#0x4	; 02328BBA
	pop {r4,r5,r6,r7}	; 02328BBC
	pop {r3}	; 02328BBE
	bx r3	; 02328BC0
loc_02328BC2:
	cmp r1,#0xd	; 02328BC2
	beq loc_02328BD0	; 02328BC4
	add r0,r7,#0x0	; 02328BC6
	bl loc_02328BF4	; 02328BC8
	add r0,r6,r0	; 02328BCC
	add r4,r4,r0	; 02328BCE
loc_02328BD0:
	add r5,r5,#0x2	; 02328BD0
	ldrh r1,[r5,#0x0]	; 02328BD2
	cmp r1,#0x0	; 02328BD4
	bne loc_02328BA4	; 02328BD6
loc_02328BD8:
	ldr r0,[sp,#0x0]	; 02328BD8
	cmp r0,#0x0	; 02328BDA
	beq loc_02328BE8	; 02328BDC
	cmp r4,r6	; 02328BDE
	ble loc_02328BE4	; 02328BE0
	sub r4,r4,r6	; 02328BE2
loc_02328BE4:
	ldr r0,[sp,#0x0]	; 02328BE4
	str r4,[r0,#0x0]	; 02328BE6
loc_02328BE8:
	mov r0,#0x0	; 02328BE8
	add sp,#0x4	; 02328BEA
	pop {r4,r5,r6,r7}	; 02328BEC
	pop {r3}	; 02328BEE
	bx r3	; 02328BF0
	.byte 0x00, 0x00	; 02328BF4

; ===== function loc_02328BF4 =====
loc_02328BF4:
	push {r4,lr}	; 02328BF4
	add r4,r0,#0x0	; 02328BF6
	bl loc_02328EB4	; 02328BF8
	ldr r1,[r4,#0xc]	; 02328BFC
	lsl r0,r0,#0x1	; 02328BFE
	add r0,r1,r0	; 02328C00
	ldrb r0,[r0,#0x1]	; 02328C02
	pop {r4}	; 02328C04
	pop {r3}	; 02328C06
	bx r3	; 02328C08
	.byte 0x00, 0x00	; 02328C0C

; ===== function loc_02328C0C =====
loc_02328C0C:
	push {r0,r1,r2,r3}	; 02328C0C
	push {r4,r5,r6,r7,lr}	; 02328C0E
	sub sp,#0x1c	; 02328C10
	add r5,r0,#0x0	; 02328C12
	str r1,[sp,#0x8]	; 02328C14
	ldr r1,[sp,#0x40]	; 02328C16
	str r1,[sp,#0x40]	; 02328C18
	ldr r1,[sp,#0x44]	; 02328C1A
	str r1,[sp,#0x44]	; 02328C1C
	ldr r6,[sp,#0x48]	; 02328C1E
	ldr r1,[sp,#0x4c]	; 02328C20
	str r1,[sp,#0x4c]	; 02328C22
	add r1,r6,#0x0	; 02328C24
	ldr r2,[sp,#0x40]	; 02328C26
	bl loc_02328B5C	; 02328C28
	add r4,r0,#0x0	; 02328C2C
	add r0,r5,#0x0	; 02328C2E
	add r1,r6,#0x0	; 02328C30
	ldr r2,[sp,#0x44]	; 02328C32
	bl loc_02328B3C	; 02328C34
	str r0,[sp,#0x14]	; 02328C38
	mov r1,sp	; 02328C3A
	sub r1,r1,#0x4	; 02328C3C
	add r0,sp,#0x30	; 02328C3E
	ldrh r0,[r0,#0x8]	; 02328C40
	strh r0,[r1,#0x0]	; 02328C42
	ldmia r1!,{r0}	; 02328C44
	add r1,r4,#0x0	; 02328C46
	bl loc_02329024	; 02328C48
	add r7,r0,#0x0	; 02328C4C
	mov r1,sp	; 02328C4E
	sub r1,r1,#0x4	; 02328C50
	add r0,sp,#0x30	; 02328C52
	ldrh r0,[r0,#0xc]	; 02328C54
	strh r0,[r1,#0x0]	; 02328C56
	ldmia r1!,{r0}	; 02328C58
	ldr r1,[sp,#0x14]	; 02328C5A
	bl loc_02328FEC	; 02328C5C
	str r0,[sp,#0x10]	; 02328C60
	mov r1,sp	; 02328C62
	sub r1,r1,#0x4	; 02328C64
	add r0,sp,#0x30	; 02328C66
	ldrh r0,[r0,#0x8]	; 02328C68
	strh r0,[r1,#0x0]	; 02328C6A
	ldmia r1!,{r0}	; 02328C6C
	add r1,r4,#0x0	; 02328C6E
	bl loc_02328D1C	; 02328C70
	add r4,r7,r0	; 02328C74
	str r4,[sp,#0xc]	; 02328C76
	add r0,r5,#0x0	; 02328C78
	add r1,r6,#0x0	; 02328C7A
	add r2,sp,#0x18	; 02328C7C
	ldr r3,[sp,#0x40]	; 02328C7E
	bl loc_02328B90	; 02328C80
	mov r1,sp	; 02328C84
	sub r1,r1,#0x4	; 02328C86
	add r0,sp,#0x30	; 02328C88
	ldrh r0,[r0,#0x8]	; 02328C8A
	strh r0,[r1,#0x0]	; 02328C8C
	ldmia r1!,{r0}	; 02328C8E
	ldr r1,[sp,#0x18]	; 02328C90
	bl loc_02328D1C	; 02328C92
	sub r4,r4,r0	; 02328C96
	ldrh r1,[r6,#0x0]	; 02328C98
	cmp r1,#0x0	; 02328C9A
	beq loc_02328D10	; 02328C9C
loc_02328C9E:
	cmp r1,#0xa	; 02328C9E
	bne loc_02328CD6	; 02328CA0
	add r0,r5,#0x0	; 02328CA2
	add r1,r6,#0x2	; 02328CA4
	add r2,sp,#0x18	; 02328CA6
	ldr r3,[sp,#0x40]	; 02328CA8
	bl loc_02328B90	; 02328CAA
	mov r1,sp	; 02328CAE
	sub r1,r1,#0x4	; 02328CB0
	add r0,sp,#0x30	; 02328CB2
	ldrh r0,[r0,#0x8]	; 02328CB4
	strh r0,[r1,#0x0]	; 02328CB6
	ldmia r1!,{r0}	; 02328CB8
	ldr r1,[sp,#0x18]	; 02328CBA
	bl loc_02328D1C	; 02328CBC
	ldr r1,[sp,#0xc]	; 02328CC0
	sub r4,r1,r0	; 02328CC2
	ldrh r0,[r5,#0x16]	; 02328CC4
	lsl r0,r0,#0x16	; 02328CC6
	lsr r1,r0,#0x1b	; 02328CC8
	ldr r0,[sp,#0x44]	; 02328CCA
	add r1,r1,r0	; 02328CCC
	ldr r0,[sp,#0x10]	; 02328CCE
	add r0,r0,r1	; 02328CD0
	str r0,[sp,#0x10]	; 02328CD2
	b loc_02328D08	; 02328CD4
loc_02328CD6:
	cmp r1,#0xd	; 02328CD6
	beq loc_02328D08	; 02328CD8
	add r0,r5,#0x0	; 02328CDA
	bl loc_02328EB4	; 02328CDC
	lsl r0,r0,#0x10	; 02328CE0
	lsr r0,r0,#0x10	; 02328CE2
	lsl r7,r0,#0x1	; 02328CE4
	str r0,[sp,#0x0]	; 02328CE6
	ldr r0,[sp,#0x4c]	; 02328CE8
	str r0,[sp,#0x4]	; 02328CEA
	add r0,r5,#0x0	; 02328CEC
	ldr r1,[sp,#0x8]	; 02328CEE
	ldr r2,[r5,#0xc]	; 02328CF0
	ldrb r2,[r2,r7]	; 02328CF2
	sub r2,r4,r2	; 02328CF4
	ldr r3,[sp,#0x10]	; 02328CF6
	bl loc_02328D50	; 02328CF8
	ldr r0,[r5,#0xc]	; 02328CFC
	add r0,r0,r7	; 02328CFE
	ldrb r1,[r0,#0x1]	; 02328D00
	ldr r0,[sp,#0x40]	; 02328D02
	add r0,r0,r1	; 02328D04
	add r4,r4,r0	; 02328D06
loc_02328D08:
	add r6,r6,#0x2	; 02328D08
	ldrh r1,[r6,#0x0]	; 02328D0A
	cmp r1,#0x0	; 02328D0C
	bne loc_02328C9E	; 02328D0E
loc_02328D10:
	add sp,#0x1c	; 02328D10
	pop {r4,r5,r6,r7}	; 02328D12
	pop {r3}	; 02328D14
	add sp,#0x10	; 02328D16
	bx r3	; 02328D18
	.byte 0x00, 0x00	; 02328D1C

; ===== function loc_02328D1C =====
loc_02328D1C:
	push {r0,r1,r2,r3}	; 02328D1C
	push {lr}	; 02328D1E
	sub sp,#0x4	; 02328D20
	add r0,sp,#0x8	; 02328D22
	ldrh r0,[r0,#0x0]	; 02328D24
	lsl r0,r0,#0x10	; 02328D26
	lsr r0,r0,#0x1e	; 02328D28
	cmp r0,#0x1	; 02328D2A
	bne loc_02328D3E	; 02328D2C
	add r0,r1,#0x1	; 02328D2E
	mov r1,#0x2	; 02328D30
	blx P1_SignedDivMod	; 02328D32
	add sp,#0x4	; 02328D36
	pop {r3}	; 02328D38
	add sp,#0x10	; 02328D3A
	bx r3	; 02328D3C
loc_02328D3E:
	cmp r0,#0x2	; 02328D3E
	beq loc_02328D44	; 02328D40
	mov r1,#0x0	; 02328D42
loc_02328D44:
	add r0,r1,#0x0	; 02328D44
	add sp,#0x4	; 02328D46
	pop {r3}	; 02328D48
	add sp,#0x10	; 02328D4A
	bx r3	; 02328D4C
	.byte 0x00, 0x00	; 02328D50

; ===== function loc_02328D50 =====
loc_02328D50:
	push {r4,r5,r6,r7,lr}	; 02328D50
	sub sp,#0x2c	; 02328D52
	str r1,[sp,#0x0]	; 02328D54
	str r2,[sp,#0x4]	; 02328D56
	str r3,[sp,#0x8]	; 02328D58
	ldr r1,[sp,#0x44]	; 02328D5A
	str r1,[sp,#0x44]	; 02328D5C
	mov r5,#0x0	; 02328D5E
	add r4,r5,#0x0	; 02328D60
	ldrh r2,[r0,#0x16]	; 02328D62
	add r1,sp,#0x24	; 02328D64
	strh r2,[r1,#0x0]	; 02328D66
	ldr r2,[r0,#0x0]	; 02328D68
	mov r3,#0x14	; 02328D6A
	ldrsh r3,[r0,r3]	; 02328D6C
	add r0,sp,#0x30	; 02328D6E
	ldrh r0,[r0,#0x10]	; 02328D70
	mul r3,r0	; 02328D72
	lsl r0,r3,#0x1	; 02328D74
	add r7,r2,r0	; 02328D76
	str r5,[sp,#0xc]	; 02328D78
	ldrh r1,[r1,#0x0]	; 02328D7A
	lsl r0,r1,#0x16	; 02328D7C
	lsr r0,r0,#0x1b	; 02328D7E
	str r0,[sp,#0x14]	; 02328D80
	cmp r0,#0x0	; 02328D82
	ble loc_02328DE4	; 02328D84
	lsl r0,r1,#0x1b	; 02328D86
	lsr r0,r0,#0x1b	; 02328D88
	str r0,[sp,#0x10]	; 02328D8A
	str r5,[sp,#0x20]	; 02328D8C
	str r5,[sp,#0x1c]	; 02328D8E
loc_02328D90:
	ldr r6,[sp,#0x1c]	; 02328D90
	ldr r0,[sp,#0x10]	; 02328D92
	cmp r0,#0x0	; 02328D94
	ble loc_02328DD8	; 02328D96
	ldr r1,[sp,#0x8]	; 02328D98
	ldr r0,[sp,#0xc]	; 02328D9A
	add r0,r1,r0	; 02328D9C
	str r0,[sp,#0x18]	; 02328D9E
loc_02328DA0:
	cmp r4,#0x0	; 02328DA0
	bne loc_02328DA6	; 02328DA2
	ldrh r5,[r7,#0x0]	; 02328DA4
loc_02328DA6:
	add r1,r5,#0x0	; 02328DA6
	mov r0,#0x1	; 02328DA8
	and r1,r0	; 02328DAA
	cmp r1,#0x0	; 02328DAC
	bne loc_02328DBE	; 02328DAE
	ldr r0,[sp,#0x0]	; 02328DB0
	ldr r1,[sp,#0x4]	; 02328DB2
	add r1,r1,r6	; 02328DB4
	ldr r2,[sp,#0x18]	; 02328DB6
	ldr r3,[sp,#0x44]	; 02328DB8
	bl loc_02328E20	; 02328DBA
loc_02328DBE:
	lsl r0,r5,#0xf	; 02328DBE
	lsr r5,r0,#0x10	; 02328DC0
	add r0,r4,#0x1	; 02328DC2
	lsl r0,r0,#0x10	; 02328DC4
	lsr r4,r0,#0x10	; 02328DC6
	cmp r4,#0xf	; 02328DC8
	bls loc_02328DD0	; 02328DCA
	ldr r4,[sp,#0x20]	; 02328DCC
	add r7,r7,#0x2	; 02328DCE
loc_02328DD0:
	add r6,r6,#0x1	; 02328DD0
	ldr r0,[sp,#0x10]	; 02328DD2
	cmp r6,r0	; 02328DD4
	blt loc_02328DA0	; 02328DD6
loc_02328DD8:
	ldr r0,[sp,#0xc]	; 02328DD8
	add r1,r0,#0x1	; 02328DDA
	str r1,[sp,#0xc]	; 02328DDC
	ldr r0,[sp,#0x14]	; 02328DDE
	cmp r1,r0	; 02328DE0
	blt loc_02328D90	; 02328DE2
loc_02328DE4:
	add sp,#0x2c	; 02328DE4
	pop {r4,r5,r6,r7}	; 02328DE6
	pop {r3}	; 02328DE8
	bx r3	; 02328DEA

; ===== function loc_02328DEC =====
P1_Entry_02328DEC:
	push {r4,r5,r6,r7,lr}	; 02328DEC
	sub sp,#0xc	; 02328DEE
	add r5,r0,#0x0	; 02328DF0
	add r4,r1,#0x0	; 02328DF2
	add r6,r2,#0x0	; 02328DF4
	add r7,r3,#0x0	; 02328DF6
	add r1,sp,#0x10	; 02328DF8
	ldrh r1,[r1,#0x10]	; 02328DFA
	bl loc_02328EB4	; 02328DFC
	lsl r0,r0,#0x10	; 02328E00
	lsr r0,r0,#0x10	; 02328E02
	str r0,[sp,#0x0]	; 02328E04
	ldr r0,[sp,#0x24]	; 02328E06
	str r0,[sp,#0x4]	; 02328E08
	add r0,r5,#0x0	; 02328E0A
	add r1,r4,#0x0	; 02328E0C
	add r2,r6,#0x0	; 02328E0E
	add r3,r7,#0x0	; 02328E10
	bl loc_02328D50	; 02328E12
	add sp,#0xc	; 02328E16
	pop {r4,r5,r6,r7}	; 02328E18
	pop {r3}	; 02328E1A
	bx r3	; 02328E1C
	.byte 0x00, 0x00	; 02328E20

; ===== function loc_02328E20 =====
loc_02328E20:
	push {r4,lr}	; 02328E20
	ldrh r4,[r0,#0x8]	; 02328E22
	cmp r4,#0x0	; 02328E24
	bne loc_02328E2C	; 02328E26
	bl loc_02328E34	; 02328E28
loc_02328E2C:
	pop {r4}	; 02328E2C
	pop {r3}	; 02328E2E
	bx r3	; 02328E30
	.byte 0x00, 0x00	; 02328E34

; ===== function loc_02328E34 =====
loc_02328E34:
	push {r4,r5,r6,r7}	; 02328E34
	sub sp,#0x18	; 02328E36
	add r4,r0,#0x0	; 02328E38
	add r0,r1,#0x0	; 02328E3A
	add r5,r2,#0x0	; 02328E3C
	str r3,[sp,#0x0]	; 02328E3E
	asr r3,r0,#0x3	; 02328E40
	asr r7,r5,#0x3	; 02328E42
	mov r2,#0x3	; 02328E44
	str r1,[sp,#0x10]	; 02328E46
	and r1,r2	; 02328E48
	str r1,[sp,#0x10]	; 02328E4A
	asr r2,r0,#0x2	; 02328E4C
	mov r1,#0x1	; 02328E4E
	and r2,r1	; 02328E50
	mov r6,#0x7	; 02328E52
	add r1,r5,#0x0	; 02328E54
	str r1,[sp,#0x4]	; 02328E56
	and r1,r6	; 02328E58
	str r1,[sp,#0x4]	; 02328E5A
	ldrh r1,[r4,#0x4]	; 02328E5C
	str r1,[sp,#0x8]	; 02328E5E
	lsl r1,r1,#0x4	; 02328E60
	asr r1,r1,#0x3	; 02328E62
	ldr r6,[r4,#0x0]	; 02328E64
	str r6,[sp,#0xc]	; 02328E66
	cmp r0,#0x0	; 02328E68
	blt loc_02328EAC	; 02328E6A
	ldr r6,[sp,#0x8]	; 02328E6C
	cmp r0,r6	; 02328E6E
	bge loc_02328EAC	; 02328E70
	cmp r5,#0x0	; 02328E72
	blt loc_02328EAC	; 02328E74
	ldrh r0,[r4,#0x6]	; 02328E76
	cmp r5,r0	; 02328E78
	bge loc_02328EAC	; 02328E7A
	lsl r0,r3,#0x4	; 02328E7C
	mul r1,r7	; 02328E7E
	add r0,r0,r1	; 02328E80
	lsl r1,r0,#0x1	; 02328E82
	ldr r0,[sp,#0xc]	; 02328E84
	add r4,r0,r1	; 02328E86
	ldr r0,[sp,#0x4]	; 02328E88
	lsl r0,r0,#0x1	; 02328E8A
	add r0,r2,r0	; 02328E8C
	lsl r3,r0,#0x1	; 02328E8E
	ldr r0,[sp,#0x10]	; 02328E90
	lsl r2,r0,#0x2	; 02328E92
	ldrh r1,[r4,r3]	; 02328E94
	mov r0,#0xf	; 02328E96
	add r5,r0,#0x0	; 02328E98
	lsl r5,r2	; 02328E9A
	bic r1,r5	; 02328E9C
	ldr r5,[sp,#0x0]	; 02328E9E
	lsl r5,r5,#0x18	; 02328EA0
	lsr r5,r5,#0x18	; 02328EA2
	and r5,r0	; 02328EA4
	lsl r5,r2	; 02328EA6
	orr r1,r5	; 02328EA8
	strh r1,[r4,r3]	; 02328EAA
loc_02328EAC:
	add sp,#0x18	; 02328EAC
	pop {r4,r5,r6,r7}	; 02328EAE
	bx lr	; 02328EB0
	.byte 0x00, 0x00	; 02328EB4

; ===== function loc_02328EB4 =====
loc_02328EB4:
	push {r4,r5,r6,r7,lr}	; 02328EB4
	sub sp,#0x14	; 02328EB6
	str r0,[sp,#0x8]	; 02328EB8
	add r6,r1,#0x0	; 02328EBA
	mov r5,#0x0	; 02328EBC
	add r7,r5,#0x0	; 02328EBE
	ldrh r0,[r0,#0x1a]	; 02328EC0
	str r0,[sp,#0xc]	; 02328EC2
	cmp r0,#0x0	; 02328EC4
	ble loc_02328F06	; 02328EC6
	ldr r0,[sp,#0x8]	; 02328EC8
	ldr r2,[r0,#0x8]	; 02328ECA
	add r4,r2,#0x0	; 02328ECC
	add r3,r5,#0x0	; 02328ECE
loc_02328ED0:
	ldrh r0,[r4,#0x0]	; 02328ED0
	cmp r0,r6	; 02328ED2
	bhi loc_02328EEE	; 02328ED4
	add r0,r2,r3	; 02328ED6
	ldrh r0,[r0,#0x2]	; 02328ED8
	cmp r6,r0	; 02328EDA
	bhi loc_02328EEE	; 02328EDC
	add r1,r5,r6	; 02328EDE
	lsl r0,r7,#0x2	; 02328EE0
	ldrh r0,[r2,r0]	; 02328EE2
	sub r0,r1,r0	; 02328EE4
	add sp,#0x14	; 02328EE6
	pop {r4,r5,r6,r7}	; 02328EE8
	pop {r3}	; 02328EEA
	bx r3	; 02328EEC
loc_02328EEE:
	add r0,r2,r3	; 02328EEE
	ldrh r1,[r0,#0x2]	; 02328EF0
	ldrh r0,[r2,r3]	; 02328EF2
	sub r0,r1,r0	; 02328EF4
	add r0,r0,#0x1	; 02328EF6
	add r5,r5,r0	; 02328EF8
	add r4,r4,#0x4	; 02328EFA
	add r3,r3,#0x4	; 02328EFC
	add r7,r7,#0x1	; 02328EFE
	ldr r0,[sp,#0xc]	; 02328F00
	cmp r7,r0	; 02328F02
	blt loc_02328ED0	; 02328F04
loc_02328F06:
	lsl r0,r5,#0x10	; 02328F06
	lsr r0,r0,#0x10	; 02328F08
	str r0,[sp,#0x0]	; 02328F0A
	ldr r0,[sp,#0x8]	; 02328F0C
	ldrh r0,[r0,#0x12]	; 02328F0E
	str r0,[sp,#0x4]	; 02328F10
	add r0,r6,#0x0	; 02328F12
	mov r1,#0x0	; 02328F14
	ldr r2,[sp,#0x8]	; 02328F16
	ldrh r2,[r2,#0x18]	; 02328F18
	sub r2,r2,#0x1	; 02328F1A
	ldr r3,[sp,#0x8]	; 02328F1C
	ldr r3,[r3,#0x4]	; 02328F1E
	bl loc_02328F2C	; 02328F20
	add sp,#0x14	; 02328F24
	pop {r4,r5,r6,r7}	; 02328F26
	pop {r3}	; 02328F28
	bx r3	; 02328F2A

; ===== function loc_02328F2C =====
loc_02328F2C:
	push {r4,r5}	; 02328F2C
	cmp r1,r2	; 02328F2E
	bgt loc_02328F5C	; 02328F30
loc_02328F32:
	sub r4,r2,r1	; 02328F32
	asr r4,r4,#0x1	; 02328F34
	add r4,r1,r4	; 02328F36
	lsl r5,r4,#0x1	; 02328F38
	ldrh r5,[r3,r5]	; 02328F3A
	cmp r5,r0	; 02328F3C
	bls loc_02328F44	; 02328F3E
	sub r2,r4,#0x1	; 02328F40
	b loc_02328F58	; 02328F42
loc_02328F44:
	cmp r5,r0	; 02328F44
	bcs loc_02328F4C	; 02328F46
	add r1,r4,#0x1	; 02328F48
	b loc_02328F58	; 02328F4A
loc_02328F4C:
	ldr r0,[pool_02328F68]	; 02328F4C
	add r0,sp	; 02328F4E
	ldrh r0,[r0,#0x10]	; 02328F50
	add r0,r0,r4	; 02328F52
	pop {r4,r5}	; 02328F54
	bx lr	; 02328F56
loc_02328F58:
	cmp r1,r2	; 02328F58
	ble loc_02328F32	; 02328F5A
loc_02328F5C:
	ldr r0,[pool_02328F68]	; 02328F5C
	add r0,sp	; 02328F5E
	ldrh r0,[r0,#0x14]	; 02328F60
	pop {r4,r5}	; 02328F62
	bx lr	; 02328F64
	.byte 0xC0, 0x46	; 02328F68
pool_02328F68:
loc_02328F68:
	.word 0xFFFFFFF8	; 02328F68

; ===== function loc_02328F6C =====
loc_02328F6C:
	str r1,[r0,#0x0]	; 02328F6C
	strh r2,[r0,#0x4]	; 02328F6E
	strh r3,[r0,#0x6]	; 02328F70
	ldr r1,[sp,#0x0]	; 02328F72
	strh r1,[r0,#0x8]	; 02328F74
	ldr r1,[sp,#0x4]	; 02328F76
	str r1,[r0,#0xc]	; 02328F78
	bx lr	; 02328F7A

; ===== function loc_02328F7C =====
loc_02328F7C:
	push {r4}	; 02328F7C
	sub sp,#0x4	; 02328F7E
	ldrh r3,[r1,#0x6]	; 02328F80
	strh r3,[r0,#0x10]	; 02328F82
	ldrh r3,[r1,#0x8]	; 02328F84
	strh r3,[r0,#0x16]	; 02328F86
	add r1,#0xa	; 02328F88
	str r1,[r0,#0xc]	; 02328F8A
	ldr r3,[r0,#0xc]	; 02328F8C
	ldrh r1,[r0,#0x10]	; 02328F8E
	lsl r1,r1,#0x1	; 02328F90
	add r1,r3,r1	; 02328F92
	str r1,[r0,#0x0]	; 02328F94
	ldrh r1,[r0,#0x16]	; 02328F96
	lsl r3,r1,#0x1b	; 02328F98
	lsr r3,r3,#0x1b	; 02328F9A
	lsl r1,r1,#0x16	; 02328F9C
	lsr r1,r1,#0x1b	; 02328F9E
	mul r3,r1	; 02328FA0
	add r3,#0xf	; 02328FA2
	asr r1,r3,#0x4	; 02328FA4
	strh r1,[r0,#0x14]	; 02328FA6
	mov r1,#0x0	; 02328FA8
	strh r1,[r0,#0x12]	; 02328FAA
	ldr r3,[r0,#0x1c]	; 02328FAC
	mov r1,#0x1	; 02328FAE
	bic r3,r1	; 02328FB0
	orr r3,r1	; 02328FB2
	str r3,[r0,#0x1c]	; 02328FB4
	ldr r3,[r0,#0x1c]	; 02328FB6
	mov r1,#0x2	; 02328FB8
	orr r3,r1	; 02328FBA
	str r3,[r0,#0x1c]	; 02328FBC
	add r4,r2,#0x0	; 02328FBE
	add r4,#0x8	; 02328FC0
	ldr r1,[r4,#0x4]	; 02328FC2
	add r1,r2,r1	; 02328FC4
	ldrh r1,[r1,#0x8]	; 02328FC6
	strh r1,[r0,#0x18]	; 02328FC8
	add r3,r2,#0x0	; 02328FCA
	add r3,#0xc	; 02328FCC
	ldr r1,[r4,#0x4]	; 02328FCE
	add r1,r3,r1	; 02328FD0
	str r1,[r0,#0x4]	; 02328FD2
	ldr r1,[r2,#0x8]	; 02328FD4
	add r1,r2,r1	; 02328FD6
	ldrh r1,[r1,#0x8]	; 02328FD8
	strh r1,[r0,#0x1a]	; 02328FDA
	add r3,r2,#0x0	; 02328FDC
	add r3,#0xa	; 02328FDE
	ldr r1,[r2,#0x8]	; 02328FE0
	add r1,r3,r1	; 02328FE2
	str r1,[r0,#0x8]	; 02328FE4
	add sp,#0x4	; 02328FE6
	pop {r4}	; 02328FE8
	bx lr	; 02328FEA

; ===== function loc_02328FEC =====
loc_02328FEC:
	push {r0,r1,r2,r3}	; 02328FEC
	push {r4,lr}	; 02328FEE
	add r2,sp,#0x8	; 02328FF0
	mov r0,#0x0	; 02328FF2
	ldrsh r0,[r2,r0]	; 02328FF4
	lsl r0,r0,#0x14	; 02328FF6
	asr r4,r0,#0x14	; 02328FF8
	ldrh r0,[r2,#0x0]	; 02328FFA
	lsl r0,r0,#0x12	; 02328FFC
	lsr r0,r0,#0x1e	; 02328FFE
	cmp r0,#0x1	; 02329000
	beq loc_0232900A	; 02329002
	cmp r0,#0x2	; 02329004
	beq loc_02329016	; 02329006
	b loc_02329018	; 02329008
loc_0232900A:
	add r0,r1,#0x1	; 0232900A
	mov r1,#0x2	; 0232900C
	blx P1_SignedDivMod	; 0232900E
	sub r4,r4,r0	; 02329012
	b loc_02329018	; 02329014
loc_02329016:
	sub r4,r4,r1	; 02329016
loc_02329018:
	add r0,r4,#0x0	; 02329018
	pop {r4}	; 0232901A
	pop {r3}	; 0232901C
	add sp,#0x10	; 0232901E
	bx r3	; 02329020
	.byte 0x00, 0x00	; 02329024

; ===== function loc_02329024 =====
loc_02329024:
	push {r0,r1,r2,r3}	; 02329024
	push {r4,lr}	; 02329026
	add r2,sp,#0x8	; 02329028
	mov r0,#0x0	; 0232902A
	ldrsh r0,[r2,r0]	; 0232902C
	lsl r0,r0,#0x14	; 0232902E
	asr r4,r0,#0x14	; 02329030
	ldrh r0,[r2,#0x0]	; 02329032
	lsl r0,r0,#0x12	; 02329034
	lsr r0,r0,#0x1e	; 02329036
	cmp r0,#0x1	; 02329038
	beq loc_02329042	; 0232903A
	cmp r0,#0x2	; 0232903C
	beq loc_0232904E	; 0232903E
	b loc_02329050	; 02329040
loc_02329042:
	add r0,r1,#0x1	; 02329042
	mov r1,#0x2	; 02329044
	blx P1_SignedDivMod	; 02329046
	sub r4,r4,r0	; 0232904A
	b loc_02329050	; 0232904C
loc_0232904E:
	sub r4,r4,r1	; 0232904E
loc_02329050:
	add r0,r4,#0x0	; 02329050
	pop {r4}	; 02329052
	pop {r3}	; 02329054
	add sp,#0x10	; 02329056
	bx r3	; 02329058
	.byte 0x00, 0x00	; 0232905C

; ===== function loc_0232905C =====
loc_0232905C:
	push {r4,r5,lr}	; 0232905C
	sub sp,#0x14	; 0232905E
	add r4,r0,#0x0	; 02329060
	add r3,r1,#0x0	; 02329062
	mov r0,#0x4	; 02329064
	ldrsb r0,[r3,r0]	; 02329066
	str r0,[sp,#0x0]	; 02329068
	mov r0,#0x5	; 0232906A
	ldrsb r0,[r3,r0]	; 0232906C
	str r0,[sp,#0x4]	; 0232906E
	str r2,[sp,#0x8]	; 02329070
	ldrb r0,[r3,#0x6]	; 02329072
	str r0,[sp,#0xc]	; 02329074
	ldr r1,[r4,#0xc]	; 02329076
	ldrh r0,[r3,#0x6]	; 02329078
	lsl r0,r0,#0x10	; 0232907A
	lsr r0,r0,#0x1c	; 0232907C
	lsl r0,r0,#0x5	; 0232907E
	add r0,r1,r0	; 02329080
	add r1,r4,#0x0	; 02329082
	mov r4,sp	; 02329084
	sub r4,r4,#0x4	; 02329086
	ldrh r2,[r3,#0x0]	; 02329088
	strh r2,[r4,#0x0]	; 0232908A
	add r5,r4,#0x0	; 0232908C
	ldmia r5!,{r2}	; 0232908E
	ldrh r3,[r3,#0x2]	; 02329090
	strh r3,[r4,#0x0]	; 02329092
	ldmia r4!,{r3}	; 02329094
	bl loc_02328C0C	; 02329096
	add sp,#0x14	; 0232909A
	pop {r4,r5}	; 0232909C
	pop {r3}	; 0232909E
	bx r3	; 023290A0
	.byte 0x00, 0x00	; 023290A4

; ===== function loc_023290A4 =====
loc_023290A4:
	push {r4,r5,r6,r7,lr}	; 023290A4
	sub sp,#0x4	; 023290A6
	add r7,r0,#0x0	; 023290A8
	str r1,[sp,#0x0]	; 023290AA
	ldrh r6,[r1,#0x6]	; 023290AC
	lsl r4,r1,#0	; 023290AE
	add r4,#0x8	; 023290B0
	mov r5,#0x0	; 023290B2
	cmp r6,#0x0	; 023290B4
	ble loc_023290D2	; 023290B6
loc_023290B8:
	ldr r3,[r4,#0x8]	; 023290B8
	cmp r3,#0x0	; 023290BA
	beq loc_023290CA	; 023290BC
	add r0,r7,#0x0	; 023290BE
	add r1,r4,#0x0	; 023290C0
	ldr r2,[sp,#0x0]	; 023290C2
	add r2,r2,r3	; 023290C4
	bl loc_0232905C	; 023290C6
loc_023290CA:
	add r4,#0xc	; 023290CA
	add r5,r5,#0x1	; 023290CC
	cmp r5,r6	; 023290CE
	blt loc_023290B8	; 023290D0
loc_023290D2:
	add sp,#0x4	; 023290D2
	pop {r4,r5,r6,r7}	; 023290D4
	pop {r3}	; 023290D6
	bx r3	; 023290D8
	.byte 0x00, 0x00	; 023290DC

; ===== function loc_023290DC =====
loc_023290DC:
	ldrh r2,[r0,#0x6]	; 023290DC
	add r0,#0x8	; 023290DE
	cmp r1,#0x0	; 023290E0
	blt loc_023290E8	; 023290E2
	cmp r1,r2	; 023290E4
	blt loc_023290EC	; 023290E6
loc_023290E8:
	mov r0,#0x0	; 023290E8
	bx lr	; 023290EA
loc_023290EC:
	mov r2,#0xc	; 023290EC
	mul r1,r2	; 023290EE
	add r0,r0,r1	; 023290F0
	bx lr	; 023290F2

; ===== function loc_023290F4 =====
loc_023290F4:
	ldr r2,[r0,#0x8]	; 023290F4
	add r2,r0,r2	; 023290F6
	mov r0,#0x6	; 023290F8
	mul r1,r0	; 023290FA
	add r0,r2,r1	; 023290FC
	bx lr	; 023290FE

; ===== function loc_02329100 =====
loc_02329100:
	ldr r0,[r0,#0x14]	; 02329100
	bx lr	; 02329102

; ===== function loc_02329104 =====
loc_02329104:
	ldr r1,[r0,#0x10]	; 02329104
	add r0,r0,r1	; 02329106
	bx lr	; 02329108
	.byte 0x00, 0x00	; 0232910C

; ===== function loc_0232910C =====
loc_0232910C:
	ldr r2,[r0,#0xc]	; 0232910C
	add r2,r0,r2	; 0232910E
	ldr r3,[r0,#0x8]	; 02329110
	add r3,r0,r3	; 02329112
	mov r0,#0x6	; 02329114
	mul r1,r0	; 02329116
	add r0,r3,r1	; 02329118
	ldrh r1,[r0,#0x2]	; 0232911A
	mov r0,#0xc	; 0232911C
	mul r1,r0	; 0232911E
	add r0,r2,r1	; 02329120
	bx lr	; 02329122

; ===== function loc_02329124 =====
loc_02329124:
	ldr r2,[r0,#0x8]	; 02329124
	add r2,r0,r2	; 02329126
	mov r0,#0x6	; 02329128
	mul r1,r0	; 0232912A
	add r0,r2,r1	; 0232912C
	ldrh r0,[r0,#0x4]	; 0232912E
	bx lr	; 02329130
	.byte 0x00, 0x00	; 02329134

; ===== function loc_02329134 =====
loc_02329134:
	push {r4,r5,r6,r7,lr}	; 02329134
	sub sp,#0xc	; 02329136
	str r0,[sp,#0x0]	; 02329138
	add r7,r1,#0x0	; 0232913A
	str r2,[sp,#0x4]	; 0232913C
	lsl r4,r0,#0	; 0232913E
	add r4,#0x8	; 02329140
	mov r5,#0x0	; 02329142
	bl loc_023291E0	; 02329144
	cmp r0,#0x0	; 02329148
	ble loc_023291A2	; 0232914A
loc_0232914C:
	mov r1,sp	; 0232914C
	sub r1,r1,#0x4	; 0232914E
	ldrh r0,[r4,#0x0]	; 02329150
	strh r0,[r1,#0x0]	; 02329152
	ldmia r1!,{r0}	; 02329154
	ldrb r1,[r4,#0x4]	; 02329156
	bl loc_02329024	; 02329158
	add r6,r0,#0x0	; 0232915C
	mov r1,sp	; 0232915E
	sub r1,r1,#0x4	; 02329160
	ldrh r0,[r4,#0x2]	; 02329162
	strh r0,[r1,#0x0]	; 02329164
	ldmia r1!,{r0}	; 02329166
	ldrb r1,[r4,#0x5]	; 02329168
	bl loc_02328FEC	; 0232916A
	ldrb r1,[r4,#0x4]	; 0232916E
	add r2,r6,r1	; 02329170
	ldrb r1,[r4,#0x5]	; 02329172
	add r1,r0,r1	; 02329174
	cmp r6,r7	; 02329176
	bgt loc_02329194	; 02329178
	cmp r7,r2	; 0232917A
	bgt loc_02329194	; 0232917C
	ldr r2,[sp,#0x4]	; 0232917E
	cmp r0,r2	; 02329180
	bgt loc_02329194	; 02329182
	lsl r0,r2,#0	; 02329184
	cmp r0,r1	; 02329186
	bgt loc_02329194	; 02329188
	add r0,r5,#0x0	; 0232918A
	add sp,#0xc	; 0232918C
	pop {r4,r5,r6,r7}	; 0232918E
	pop {r3}	; 02329190
	bx r3	; 02329192
loc_02329194:
	add r5,r5,#0x1	; 02329194
	add r4,r4,#0x6	; 02329196
	ldr r0,[sp,#0x0]	; 02329198
	bl loc_023291E0	; 0232919A
	cmp r5,r0	; 0232919E
	blt loc_0232914C	; 023291A0
loc_023291A2:
	mov r0,#0x0	; 023291A2
	mvn r0,r0	; 023291A4
	add sp,#0xc	; 023291A6
	pop {r4,r5,r6,r7}	; 023291A8
	pop {r3}	; 023291AA
	bx r3	; 023291AC
	.byte 0x00, 0x00	; 023291B0

; ===== function loc_023291B0 =====
loc_023291B0:
	push {r4,r5,lr}	; 023291B0
	sub sp,#0x4	; 023291B2
	add r5,r1,#0x0	; 023291B4
	add r4,r0,#0x0	; 023291B6
	add r4,#0x8	; 023291B8
	cmp r5,#0x0	; 023291BA
	blt loc_023291C6	; 023291BC
	bl loc_023291E0	; 023291BE
	cmp r5,r0	; 023291C2
	blt loc_023291D0	; 023291C4
loc_023291C6:
	mov r0,#0x0	; 023291C6
	add sp,#0x4	; 023291C8
	pop {r4,r5}	; 023291CA
	pop {r3}	; 023291CC
	bx r3	; 023291CE
loc_023291D0:
	mov r0,#0x6	; 023291D0
	mul r5,r0	; 023291D2
	add r0,r4,r5	; 023291D4
	add sp,#0x4	; 023291D6
	pop {r4,r5}	; 023291D8
	pop {r3}	; 023291DA
	bx r3	; 023291DC
	.byte 0x00, 0x00	; 023291E0

; ===== function loc_023291E0 =====
loc_023291E0:
	ldrh r0,[r0,#0x6]	; 023291E0
	bx lr	; 023291E2

; ===== function loc_023291E4 =====
loc_023291E4:
	push {r4,r5,r6,r7,lr}	; 023291E4
	sub sp,#0x14	; 023291E6
	str r0,[sp,#0x0]	; 023291E8
	str r1,[sp,#0x4]	; 023291EA
	str r2,[sp,#0x8]	; 023291EC
	str r3,[sp,#0xc]	; 023291EE
	lsl r0,r2,#0	; 023291F0
	lsr r6,r0,#0x1	; 023291F2
	mov r5,#0x0	; 023291F4
	add r4,sp,#0x10	; 023291F6
	ldr r1,[pool_02329324]	; 023291F8
	ldr r7,[pool_02329328]	; 023291FA
loc_023291FC:
	add r0,r5,r6	; 023291FC
	sub r0,r0,#0x2	; 023291FE
	lsl r3,r0,#0x1	; 02329200
	ldr r0,[sp,#0x0]	; 02329202
	ldrsh r2,[r0,r3]	; 02329204
	ldr r0,[sp,#0x4]	; 02329206
	ldrsh r0,[r0,r3]	; 02329208
	sub r0,r2,r0	; 0232920A
	cmp r0,r1	; 0232920C
	bge loc_02329214	; 0232920E
	add r0,r1,#0x0	; 02329210
	b loc_0232921A	; 02329212
loc_02329214:
	cmp r0,r7	; 02329214
	blt loc_0232921A	; 02329216
	ldr r0,[pool_0232932C]	; 02329218
loc_0232921A:
	strh r0,[r4,#0x0]	; 0232921A
	add r4,r4,#0x2	; 0232921C
	add r5,r5,#0x1	; 0232921E
	cmp r5,#0x2	; 02329220
	blt loc_023291FC	; 02329222
	sub r0,r6,#0x1	; 02329224
	cmp r0,#0x2	; 02329226
	blt loc_023292A2	; 02329228
	lsl r3,r0,#0x1	; 0232922A
	ldr r1,[sp,#0x0]	; 0232922C
	add r2,r1,r3	; 0232922E
	ldr r1,[sp,#0x4]	; 02329230
	add r1,r1,r3	; 02329232
	ldr r7,[pool_02329324]	; 02329234
	mov r4,#0x0	; 02329236
loc_02329238:
	sub r3,r0,#0x2	; 02329238
	lsl r6,r3,#0x1	; 0232923A
	ldr r3,[sp,#0x0]	; 0232923C
	ldrsh r5,[r3,r6]	; 0232923E
	ldr r3,[sp,#0x4]	; 02329240
	ldrsh r3,[r3,r6]	; 02329242
	sub r6,r5,r3	; 02329244
	cmp r6,#0x0	; 02329246
	blt loc_02329272	; 02329248
	ldrsh r3,[r2,r4]	; 0232924A
	add r5,r6,r3	; 0232924C
	ldr r3,[pool_02329328]	; 0232924E
	cmp r5,r3	; 02329250
	bge loc_0232925A	; 02329252
	lsl r3,r5,#0x10	; 02329254
	asr r3,r3,#0x10	; 02329256
	b loc_0232925C	; 02329258
loc_0232925A:
	ldr r3,[pool_0232932C]	; 0232925A
loc_0232925C:
	strh r3,[r2,#0x0]	; 0232925C
	ldrsh r3,[r1,r4]	; 0232925E
	sub r3,r3,r6	; 02329260
	cmp r3,r7	; 02329262
	blt loc_0232926C	; 02329264
	lsl r3,r3,#0x10	; 02329266
	asr r3,r3,#0x10	; 02329268
	b loc_0232926E	; 0232926A
loc_0232926C:
	add r3,r7,#0x0	; 0232926C
loc_0232926E:
	strh r3,[r1,#0x0]	; 0232926E
	b loc_02329298	; 02329270
loc_02329272:
	ldrsh r3,[r2,r4]	; 02329272
	add r3,r6,r3	; 02329274
	cmp r3,r7	; 02329276
	blt loc_02329280	; 02329278
	lsl r3,r3,#0x10	; 0232927A
	asr r3,r3,#0x10	; 0232927C
	b loc_02329282	; 0232927E
loc_02329280:
	add r3,r7,#0x0	; 02329280
loc_02329282:
	strh r3,[r2,#0x0]	; 02329282
	ldrsh r3,[r1,r4]	; 02329284
	sub r5,r3,r6	; 02329286
	ldr r3,[pool_02329328]	; 02329288
	cmp r5,r3	; 0232928A
	bge loc_02329294	; 0232928C
	lsl r3,r5,#0x10	; 0232928E
	asr r3,r3,#0x10	; 02329290
	b loc_02329296	; 02329292
loc_02329294:
	ldr r3,[pool_0232932C]	; 02329294
loc_02329296:
	strh r3,[r1,#0x0]	; 02329296
loc_02329298:
	sub r2,r2,#0x2	; 02329298
	sub r1,r1,#0x2	; 0232929A
	sub r0,r0,#0x1	; 0232929C
	cmp r0,#0x2	; 0232929E
	bge loc_02329238	; 023292A0
loc_023292A2:
	mov r1,#0x1	; 023292A2
	ldr r0,[sp,#0xc]	; 023292A4
	add r4,r0,#0x4	; 023292A6
	ldr r0,[sp,#0x0]	; 023292A8
	add r3,r0,#0x2	; 023292AA
	ldr r0,[sp,#0x4]	; 023292AC
	add r2,r0,#0x2	; 023292AE
	ldr r0,[pool_02329324]	; 023292B0
loc_023292B2:
	mov r5,#0x0	; 023292B2
	ldrsh r6,[r3,r5]	; 023292B4
	ldr r5,[r4,#0xc]	; 023292B6
	add r6,r6,r5	; 023292B8
	cmp r6,r0	; 023292BA
	bge loc_023292C2	; 023292BC
	add r6,r0,#0x0	; 023292BE
	b loc_023292CA	; 023292C0
loc_023292C2:
	ldr r5,[pool_02329328]	; 023292C2
	cmp r6,r5	; 023292C4
	blt loc_023292CA	; 023292C6
	ldr r6,[pool_0232932C]	; 023292C8
loc_023292CA:
	strh r6,[r3,#0x0]	; 023292CA
	mov r5,#0x0	; 023292CC
	ldrsh r6,[r2,r5]	; 023292CE
	ldr r5,[r4,#0xc]	; 023292D0
	sub r6,r6,r5	; 023292D2
	cmp r6,r0	; 023292D4
	bge loc_023292DC	; 023292D6
	add r6,r0,#0x0	; 023292D8
	b loc_023292E4	; 023292DA
loc_023292DC:
	ldr r5,[pool_02329328]	; 023292DC
	cmp r6,r5	; 023292DE
	blt loc_023292E4	; 023292E0
	ldr r6,[pool_0232932C]	; 023292E2
loc_023292E4:
	strh r6,[r2,#0x0]	; 023292E4
	sub r4,r4,#0x4	; 023292E6
	sub r3,r3,#0x2	; 023292E8
	sub r2,r2,#0x2	; 023292EA
	sub r1,r1,#0x1	; 023292EC
	cmp r1,#0x0	; 023292EE
	bge loc_023292B2	; 023292F0
	mov r3,#0x0	; 023292F2
	add r4,sp,#0x10	; 023292F4
	add r1,r3,#0x0	; 023292F6
loc_023292F8:
	ldrsh r2,[r4,r1]	; 023292F8
	ldr r0,[sp,#0xc]	; 023292FA
	str r2,[r0,#0xc]	; 023292FC
	add r4,r4,#0x2	; 023292FE
	add r0,r0,#0x4	; 02329300
	str r0,[sp,#0xc]	; 02329302
	add r3,r3,#0x1	; 02329304
	cmp r3,#0x2	; 02329306
	blt loc_023292F8	; 02329308
	ldr r0,[sp,#0x0]	; 0232930A
	ldr r1,[sp,#0x8]	; 0232930C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232930E
	ldr r0,[sp,#0x4]	; 02329312
	ldr r1,[sp,#0x8]	; 02329314
	blx P1_CleanAndInvalidateDataCacheRange	; 02329316
	add sp,#0x14	; 0232931A
	pop {r4,r5,r6,r7}	; 0232931C
	pop {r3}	; 0232931E
	bx r3	; 02329320
	.byte 0xC0, 0x46	; 02329324
pool_02329324:
loc_02329324:
	.word 0xFFFF8000	; 02329324
pool_02329328:
loc_02329328:
	.word 0x00008000	; 02329328
pool_0232932C:
loc_0232932C:
	.word 0x00007FFF	; 0232932C

; ===== function loc_02329330 =====
	push {r4,r5,r6,r7,lr}	; 02329330
	sub sp,#0xc	; 02329332
	add r7,r0,#0x0	; 02329334
	str r1,[sp,#0x4]	; 02329336
	str r2,[sp,#0x8]	; 02329338
	ldr r4,[sp,#0x20]	; 0232933A
	ldr r6,[r4,#0x4]	; 0232933C
	cmp r6,#0x0	; 0232933E
	beq loc_02329348	; 02329340
	ldr r5,[r4,#0x8]	; 02329342
	str r5,[sp,#0x0]	; 02329344
	blx r6	; 02329346
loc_02329348:
	ldr r0,[r4,#0x0]	; 02329348
	cmp r0,#0x0	; 0232934A
	beq loc_0232935E	; 0232934C
	cmp r0,#0x1	; 0232934E
	bne loc_0232935E	; 02329350
	add r0,r7,#0x0	; 02329352
	ldr r1,[sp,#0x4]	; 02329354
	ldr r2,[sp,#0x8]	; 02329356
	add r3,r4,#0x0	; 02329358
	bl loc_023291E4	; 0232935A
loc_0232935E:
	add sp,#0xc	; 0232935E
	pop {r4,r5,r6,r7}	; 02329360
	pop {r3}	; 02329362
	bx r3	; 02329364
	.byte 0x00, 0x00	; 02329368

; ===== function loc_02329368 =====
loc_02329368:
	push {lr}	; 02329368
	sub sp,#0x4	; 0232936A
	ldr r0,[pool_02329384]	; 0232936C
	ldr r0,[r0,#0x0]	; 0232936E
	cmp r0,#0x1	; 02329370
	bne loc_0232937A	; 02329372
	mov r0,#0x0	; 02329374
	bl loc_0232DED0	; 02329376
loc_0232937A:
	bl loc_0232A7A0	; 0232937A
	add sp,#0x4	; 0232937E
	pop {r3}	; 02329380
	bx r3	; 02329382
pool_02329384:
loc_02329384:
	.word P1_BssStart + 0x2593C	; 02329384

; ===== function loc_02329388 =====
loc_02329388:
	push {r4,r5,r6,lr}	; 02329388
	sub sp,#0x10	; 0232938A
	add r5,r0,#0x0	; 0232938C
	add r6,r1,#0x0	; 0232938E
	add r4,r2,#0x0	; 02329390
	mov r1,#0x0	; 02329392
	add r0,sp,#0xc	; 02329394
	strh r1,[r0,#0x0]	; 02329396
	ldrh r0,[r0,#0x0]	; 02329398
	ldr r1,[pool_023293D0]	; 0232939A
	mov r2,#0xc0	; 0232939C
	blx loc_0232DD5C	; 0232939E
	ldr r0,[pool_023293D4]	; 023293A2
	str r4,[r0,#0x0]	; 023293A4
	cmp r4,#0x1	; 023293A6
	bne loc_023293B0	; 023293A8
	ldr r0,[pool_023293D8]	; 023293AA
	bl loc_0232DED0	; 023293AC
loc_023293B0:
	mov r0,#0x2	; 023293B0
	str r0,[sp,#0x0]	; 023293B2
	ldr r0,[pool_023293DC]	; 023293B4
	str r0,[sp,#0x4]	; 023293B6
	ldr r0,[pool_023293D4]	; 023293B8
	str r0,[sp,#0x8]	; 023293BA
	add r0,r5,#0x0	; 023293BC
	add r1,r6,#0x0	; 023293BE
	mov r2,#0x0	; 023293C0
	ldr r3,[pool_023293E0]	; 023293C2
	bl loc_0232A7C0	; 023293C4
	add sp,#0x10	; 023293C8
	pop {r4,r5,r6}	; 023293CA
	pop {r3}	; 023293CC
	bx r3	; 023293CE
pool_023293D0:
loc_023293D0:
	.word 0x02356308	; 023293D0
pool_023293D4:
loc_023293D4:
	.word P1_BssStart + 0x2593C	; 023293D4
pool_023293D8:
loc_023293D8:
	.word 0x00003000	; 023293D8
pool_023293DC:
loc_023293DC:
	.word 0x02329331	; 023293DC
pool_023293E0:
loc_023293E0:
	.word 0x00007D00	; 023293E0

; ===== function loc_023293E4 =====
loc_023293E4:
	mov r0,#0x1	; 023293E4
	ldr r3,[pool_023293EC]	; 023293E6
	bx r3	; 023293E8
	.byte 0xC0, 0x46	; 023293EC
pool_023293EC:
loc_023293EC:
	.word loc_0232C688 + 1	; 023293EC

; ===== function loc_023293F0 =====
loc_023293F0:
	push {r4,r5,lr}	; 023293F0
	sub sp,#0x4	; 023293F2
	add r5,r0,#0x0	; 023293F4
	bl loc_023293E4	; 023293F6
	cmp r0,#0x0	; 023293FA
	bne loc_0232940A	; 023293FC
	mov r0,#0x2	; 023293FE
	mvn r0,r0	; 02329400
	add sp,#0x4	; 02329402
	pop {r4,r5}	; 02329404
	pop {r3}	; 02329406
	bx r3	; 02329408
loc_0232940A:
	bl loc_023294A8	; 0232940A
	add r4,r0,#0x0	; 0232940E
	mov r0,#0x0	; 02329410
	mvn r0,r0	; 02329412
	cmp r4,r0	; 02329414
	beq loc_02329432	; 02329416
	add r0,r5,#0x0	; 02329418
	bl loc_02329464	; 0232941A
	lsl r0,r4,#0x10	; 0232941E
	lsr r0,r0,#0x10	; 02329420
	bl loc_02329484	; 02329422
	mov r1,#0x1	; 02329426
	mvn r1,r1	; 02329428
	cmp r0,r1	; 0232942A
	beq loc_02329430	; 0232942C
	mov r1,#0x0	; 0232942E
loc_02329430:
	add r0,r1,#0x0	; 02329430
loc_02329432:
	add sp,#0x4	; 02329432
	pop {r4,r5}	; 02329434
	pop {r3}	; 02329436
	bx r3	; 02329438
	.byte 0x00, 0x00	; 0232943C

; ===== function loc_0232943C =====
loc_0232943C:
	push {lr}	; 0232943C
	sub sp,#0x4	; 0232943E
	mov r3,#0x0	; 02329440
	ldr r2,[pool_02329460]	; 02329442
	add r0,r3,#0x0	; 02329444
loc_02329446:
	ldrsb r1,[r2,r0]	; 02329446
	add r2,r2,#0x1	; 02329448
	add r3,r3,#0x1	; 0232944A
	cmp r3,#0x13	; 0232944C
	bcc loc_02329446	; 0232944E
	bl loc_0232C6D8	; 02329450
	mov r0,#0x1	; 02329454
	bl loc_0232C658	; 02329456
	add sp,#0x4	; 0232945A
	pop {r3}	; 0232945C
	bx r3	; 0232945E
pool_02329460:
loc_02329460:
	.word P1_VibBuildIdentifier	; 02329460

; ===== function loc_02329464 =====
loc_02329464:
	push {r4,lr}	; 02329464
	add r4,r0,#0x0	; 02329466
	bl loc_023293E4	; 02329468
	cmp r0,#0x1	; 0232946C
	bne loc_02329478	; 0232946E
	mov r0,#0x1	; 02329470
	and r4,r0	; 02329472
	ldr r0,[pool_02329480]	; 02329474
	strh r4,[r0,#0x0]	; 02329476
loc_02329478:
	pop {r4}	; 02329478
	pop {r3}	; 0232947A
	bx r3	; 0232947C
	.byte 0xC0, 0x46	; 02329480
pool_02329480:
loc_02329480:
	.word 0x08000004	; 02329480

; ===== function loc_02329484 =====
loc_02329484:
	push {r4,r5,lr}	; 02329484
	sub sp,#0x4	; 02329486
	add r5,r0,#0x0	; 02329488
	bl loc_0232B2F0	; 0232948A
	add r4,r0,#0x0	; 0232948E
	add r0,r5,#0x0	; 02329490
	blx loc_0232B20C	; 02329492
	mov r0,#0x1	; 02329496
	mvn r0,r0	; 02329498
	cmp r4,r0	; 0232949A
	beq loc_023294A0	; 0232949C
	mov r0,#0x0	; 0232949E
loc_023294A0:
	add sp,#0x4	; 023294A0
	pop {r4,r5}	; 023294A2
	pop {r3}	; 023294A4
	bx r3	; 023294A6

; ===== function loc_023294A8 =====
loc_023294A8:
	push {r4,lr}	; 023294A8
	blx loc_0232B1B4	; 023294AA
	add r4,r0,#0x0	; 023294AE
	mov r0,#0x2	; 023294B0
	mvn r0,r0	; 023294B2
	cmp r4,r0	; 023294B4
	bne loc_023294C2	; 023294B6
	mov r0,#0x0	; 023294B8
	mvn r0,r0	; 023294BA
	pop {r4}	; 023294BC
	pop {r3}	; 023294BE
	bx r3	; 023294C0
loc_023294C2:
	lsl r0,r4,#0x10	; 023294C2
	lsr r0,r0,#0x10	; 023294C4
	bl loc_0232B30C	; 023294C6
	add r0,r4,#0x0	; 023294CA
	pop {r4}	; 023294CC
	pop {r3}	; 023294CE
	bx r3	; 023294D0
	.byte 0x00, 0x00	; 023294D4

; ===== function loc_023294D4 =====
loc_023294D4:
	cmp r1,#0x0	; 023294D4
	bne loc_023294DC	; 023294D6
	ldr r0,[r0,#0x4]	; 023294D8
	bx lr	; 023294DA
loc_023294DC:
	ldrh r0,[r0,#0xa]	; 023294DC
	ldr r0,[r1,r0]	; 023294DE
	bx lr	; 023294E0
	.byte 0x00, 0x00	; 023294E4

; ===== function loc_023294E4 =====
loc_023294E4:
	cmp r1,#0x0	; 023294E4
	bne loc_023294EC	; 023294E6
	ldr r0,[r0,#0x0]	; 023294E8
	bx lr	; 023294EA
loc_023294EC:
	ldrh r0,[r0,#0xa]	; 023294EC
	add r0,r1,r0	; 023294EE
	ldr r0,[r0,#0x4]	; 023294F0
	bx lr	; 023294F2

; ===== function loc_023294F4 =====
loc_023294F4:
	push {r4}	; 023294F4
	sub sp,#0x4	; 023294F6
	ldrh r4,[r0,#0xa]	; 023294F8
	add r2,r1,r4	; 023294FA
	ldr r1,[r1,r4]	; 023294FC
	cmp r1,#0x0	; 023294FE
	bne loc_02329508	; 02329500
	ldr r1,[r2,#0x4]	; 02329502
	str r1,[r0,#0x0]	; 02329504
	b loc_0232950E	; 02329506
loc_02329508:
	ldr r3,[r2,#0x4]	; 02329508
	add r1,r1,r4	; 0232950A
	str r3,[r1,#0x4]	; 0232950C
loc_0232950E:
	ldr r4,[r2,#0x4]	; 0232950E
	cmp r4,#0x0	; 02329510
	bne loc_0232951A	; 02329512
	ldr r1,[r2,#0x0]	; 02329514
	str r1,[r0,#0x4]	; 02329516
	b loc_02329520	; 02329518
loc_0232951A:
	ldr r3,[r2,#0x0]	; 0232951A
	ldrh r1,[r0,#0xa]	; 0232951C
	str r3,[r4,r1]	; 0232951E
loc_02329520:
	mov r1,#0x0	; 02329520
	str r1,[r2,#0x0]	; 02329522
	str r1,[r2,#0x4]	; 02329524
	ldrh r1,[r0,#0x8]	; 02329526
	sub r1,r1,#0x1	; 02329528
	strh r1,[r0,#0x8]	; 0232952A
	add sp,#0x4	; 0232952C
	pop {r4}	; 0232952E
	bx lr	; 02329530
	.byte 0x00, 0x00	; 02329534

; ===== function loc_02329534 =====
loc_02329534:
	push {r4,r5,lr}	; 02329534
	sub sp,#0x4	; 02329536
	cmp r1,#0x0	; 02329538
	bne loc_0232954A	; 0232953A
	add r1,r2,#0x0	; 0232953C
	bl loc_023295B4	; 0232953E
	add sp,#0x4	; 02329542
	pop {r4,r5}	; 02329544
	pop {r3}	; 02329546
	bx r3	; 02329548
loc_0232954A:
	ldr r3,[r0,#0x0]	; 0232954A
	cmp r1,r3	; 0232954C
	bne loc_0232955E	; 0232954E
	add r1,r2,#0x0	; 02329550
	bl loc_02329580	; 02329552
	add sp,#0x4	; 02329556
	pop {r4,r5}	; 02329558
	pop {r3}	; 0232955A
	bx r3	; 0232955C
loc_0232955E:
	ldrh r5,[r0,#0xa]	; 0232955E
	add r4,r2,r5	; 02329560
	ldr r3,[r1,r5]	; 02329562
	str r3,[r2,r5]	; 02329564
	str r1,[r4,#0x4]	; 02329566
	add r3,r3,r5	; 02329568
	str r2,[r3,#0x4]	; 0232956A
	ldrh r3,[r0,#0xa]	; 0232956C
	str r2,[r1,r3]	; 0232956E
	ldrh r1,[r0,#0x8]	; 02329570
	add r1,r1,#0x1	; 02329572
	strh r1,[r0,#0x8]	; 02329574
	add sp,#0x4	; 02329576
	pop {r4,r5}	; 02329578
	pop {r3}	; 0232957A
	bx r3	; 0232957C
	.byte 0x00, 0x00	; 02329580

; ===== function loc_02329580 =====
loc_02329580:
	push {r4,lr}	; 02329580
	ldr r2,[r0,#0x0]	; 02329582
	cmp r2,#0x0	; 02329584
	bne loc_02329592	; 02329586
	bl loc_023295E8	; 02329588
	pop {r4}	; 0232958C
	pop {r3}	; 0232958E
	bx r3	; 02329590
loc_02329592:
	ldrh r3,[r0,#0xa]	; 02329592
	add r4,r1,r3	; 02329594
	mov r2,#0x0	; 02329596
	str r2,[r1,r3]	; 02329598
	ldr r2,[r0,#0x0]	; 0232959A
	str r2,[r4,#0x4]	; 0232959C
	ldr r3,[r0,#0x0]	; 0232959E
	ldrh r2,[r0,#0xa]	; 023295A0
	str r1,[r3,r2]	; 023295A2
	str r1,[r0,#0x0]	; 023295A4
	ldrh r1,[r0,#0x8]	; 023295A6
	add r1,r1,#0x1	; 023295A8
	strh r1,[r0,#0x8]	; 023295AA
	pop {r4}	; 023295AC
	pop {r3}	; 023295AE
	bx r3	; 023295B0
	.byte 0x00, 0x00	; 023295B4

; ===== function loc_023295B4 =====
loc_023295B4:
	push {r4,lr}	; 023295B4
	ldr r2,[r0,#0x0]	; 023295B6
	cmp r2,#0x0	; 023295B8
	bne loc_023295C6	; 023295BA
	bl loc_023295E8	; 023295BC
	pop {r4}	; 023295C0
	pop {r3}	; 023295C2
	bx r3	; 023295C4
loc_023295C6:
	ldrh r3,[r0,#0xa]	; 023295C6
	add r4,r1,r3	; 023295C8
	ldr r2,[r0,#0x4]	; 023295CA
	str r2,[r1,r3]	; 023295CC
	mov r2,#0x0	; 023295CE
	str r2,[r4,#0x4]	; 023295D0
	ldr r3,[r0,#0x4]	; 023295D2
	ldrh r2,[r0,#0xa]	; 023295D4
	add r2,r3,r2	; 023295D6
	str r1,[r2,#0x4]	; 023295D8
	str r1,[r0,#0x4]	; 023295DA
	ldrh r1,[r0,#0x8]	; 023295DC
	add r1,r1,#0x1	; 023295DE
	strh r1,[r0,#0x8]	; 023295E0
	pop {r4}	; 023295E2
	pop {r3}	; 023295E4
	bx r3	; 023295E6

; ===== function loc_023295E8 =====
loc_023295E8:
	push {r4}	; 023295E8
	sub sp,#0x4	; 023295EA
	ldrh r3,[r0,#0xa]	; 023295EC
	add r4,r1,r3	; 023295EE
	mov r2,#0x0	; 023295F0
	str r2,[r4,#0x4]	; 023295F2
	str r2,[r1,r3]	; 023295F4
	str r1,[r0,#0x0]	; 023295F6
	str r1,[r0,#0x4]	; 023295F8
	ldrh r1,[r0,#0x8]	; 023295FA
	add r1,r1,#0x1	; 023295FC
	strh r1,[r0,#0x8]	; 023295FE
	add sp,#0x4	; 02329600
	pop {r4}	; 02329602
	bx lr	; 02329604
	.byte 0x00, 0x00	; 02329608

; ===== function loc_02329608 =====
loc_02329608:
	mov r2,#0x0	; 02329608
	str r2,[r0,#0x0]	; 0232960A
	str r2,[r0,#0x4]	; 0232960C
	strh r2,[r0,#0x8]	; 0232960E
	strh r1,[r0,#0xa]	; 02329610
	bx lr	; 02329612

; ===== function loc_02329614 =====
loc_02329614:
	push {r4,lr}	; 02329614
	add r4,r0,#0x0	; 02329616
	bl loc_0232968C	; 02329618
	add r1,r4,#0x0	; 0232961C
	bl loc_023294F4	; 0232961E
	pop {r4}	; 02329622
	pop {r3}	; 02329624
	bx r3	; 02329626

; ===== function loc_02329628 =====
loc_02329628:
	push {r4,lr}	; 02329628
	add r4,r0,#0x0	; 0232962A
	str r1,[r4,#0x0]	; 0232962C
	str r2,[r4,#0x18]	; 0232962E
	str r3,[r4,#0x1c]	; 02329630
	mov r0,#0x0	; 02329632
	str r0,[r4,#0x20]	; 02329634
	ldr r1,[r4,#0x20]	; 02329636
	mov r0,#0xff	; 02329638
	bic r1,r0	; 0232963A
	str r1,[r4,#0x20]	; 0232963C
	ldr r2,[r4,#0x20]	; 0232963E
	ldr r1,[pool_02329680]	; 02329640
	add r1,sp	; 02329642
	ldrh r1,[r1,#0x10]	; 02329644
	and r1,r0	; 02329646
	orr r2,r1	; 02329648
	str r2,[r4,#0x20]	; 0232964A
	add r0,r4,#0x0	; 0232964C
	add r0,#0xc	; 0232964E
	mov r1,#0x4	; 02329650
	bl loc_02329608	; 02329652
	ldr r0,[pool_02329684]	; 02329656
	ldr r0,[r0,#0x0]	; 02329658
	cmp r0,#0x0	; 0232965A
	bne loc_0232966C	; 0232965C
	ldr r0,[pool_02329688]	; 0232965E
	mov r1,#0x4	; 02329660
	bl loc_02329608	; 02329662
	mov r1,#0x1	; 02329666
	ldr r0,[pool_02329684]	; 02329668
	str r1,[r0,#0x0]	; 0232966A
loc_0232966C:
	add r0,r4,#0x0	; 0232966C
	bl loc_0232968C	; 0232966E
	add r1,r4,#0x0	; 02329672
	bl loc_023295B4	; 02329674
	pop {r4}	; 02329678
	pop {r3}	; 0232967A
	bx r3	; 0232967C
	.byte 0xC0, 0x46	; 02329680
pool_02329680:
loc_02329680:
	.word 0xFFFFFFF8	; 02329680
pool_02329684:
loc_02329684:
	.word P1_BssStart + 0x25A08	; 02329684
pool_02329688:
loc_02329688:
	.word 0x023563CC	; 02329688

; ===== function loc_0232968C =====
loc_0232968C:
	push {r4,lr}	; 0232968C
	add r1,r0,#0x0	; 0232968E
	ldr r4,[pool_023296A8]	; 02329690
	add r0,r4,#0x0	; 02329692
	bl loc_023296AC	; 02329694
	cmp r0,#0x0	; 02329698
	beq loc_023296A0	; 0232969A
	add r4,r0,#0x0	; 0232969C
	add r4,#0xc	; 0232969E
loc_023296A0:
	add r0,r4,#0x0	; 023296A0
	pop {r4}	; 023296A2
	pop {r3}	; 023296A4
	bx r3	; 023296A6
pool_023296A8:
loc_023296A8:
	.word 0x023563CC	; 023296A8

; ===== function loc_023296AC =====
loc_023296AC:
	push {r4,r5,r6,lr}	; 023296AC
	add r6,r0,#0x0	; 023296AE
	add r5,r1,#0x0	; 023296B0
	mov r1,#0x0	; 023296B2
	bl loc_023294E4	; 023296B4
	add r4,r0,#0x0	; 023296B8
	cmp r4,#0x0	; 023296BA
	beq loc_023296EE	; 023296BC
loc_023296BE:
	ldr r0,[r4,#0x18]	; 023296BE
	cmp r0,r5	; 023296C0
	bhi loc_023296E0	; 023296C2
	ldr r0,[r4,#0x1c]	; 023296C4
	cmp r5,r0	; 023296C6
	bcs loc_023296E0	; 023296C8
	add r0,r4,#0x0	; 023296CA
	add r0,#0xc	; 023296CC
	add r1,r5,#0x0	; 023296CE
	bl loc_023296AC	; 023296D0
	cmp r0,#0x0	; 023296D4
	bne loc_023296F0	; 023296D6
	add r0,r4,#0x0	; 023296D8
	pop {r4,r5,r6}	; 023296DA
	pop {r3}	; 023296DC
	bx r3	; 023296DE
loc_023296E0:
	add r0,r6,#0x0	; 023296E0
	add r1,r4,#0x0	; 023296E2
	bl loc_023294E4	; 023296E4
	add r4,r0,#0x0	; 023296E8
	cmp r4,#0x0	; 023296EA
	bne loc_023296BE	; 023296EC
loc_023296EE:
	mov r0,#0x0	; 023296EE
loc_023296F0:
	pop {r4,r5,r6}	; 023296F0
	pop {r3}	; 023296F2
	bx r3	; 023296F4
	.byte 0x00, 0x00	; 023296F6
P1_Entry_023296F8:
	push {r4,r5,lr}	; 023296F8
	sub sp,#0xc	; 023296FA
	add r5,r0,#0x0	; 023296FC
	add r5,#0x24	; 023296FE
	add r4,r1,#0x0	; 02329700
	sub r4,#0x10	; 02329702
	add r0,sp,#0x0	; 02329704
	add r1,r4,#0x0	; 02329706
	bl P1_Entry_02329ADC	; 02329708
	add r0,r5,#0x0	; 0232970C
	add r0,#0x8	; 0232970E
	add r1,r4,#0x0	; 02329710
	bl P1_Entry_02329AC0	; 02329712
	add r0,r5,#0x0	; 02329716
	add r1,sp,#0x0	; 02329718
	bl P1_Entry_02329780	; 0232971A
	add sp,#0xc	; 0232971E
	pop {r4,r5}	; 02329720
	pop {r3}	; 02329722
	bx r3	; 02329724
	.byte 0x00, 0x00	; 02329726
P1_Entry_02329728:
	push {lr}	; 02329728
	sub sp,#0x4	; 0232972A
	cmp r1,#0x0	; 0232972C
	bne P1_Entry_02329732	; 0232972E
	mov r1,#0x1	; 02329730
P1_Entry_02329732:
	add r1,r1,#0x3	; 02329732
	mov r3,#0x3	; 02329734
	bic r1,r3	; 02329736
	cmp r2,#0x0	; 02329738
	blt P1_Entry_02329746	; 0232973A
	bl P1_Entry_0232989C	; 0232973C
	add sp,#0x4	; 02329740
	pop {r3}	; 02329742
	bx r3	; 02329744
P1_Entry_02329746:
	neg r2,r2	; 02329746
	bl P1_Entry_02329814	; 02329748
	add sp,#0x4	; 0232974C
	pop {r3}	; 0232974E
	bx r3	; 02329750
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x09, 0x18, 0x03, 0x23, 0x99, 0x43, 0xC0, 0x1C, 0x98, 0x43	; 02329752
	.byte 0x88, 0x42, 0x02, 0xD8, 0x0B, 0x1A, 0x4C, 0x2B, 0x03, 0xD2, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC	; 02329762
	.byte 0x18, 0x47, 0x00, 0xF0, 0x5C, 0xF9, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 02329772
P1_Entry_02329780:
	push {r4,r5,r6,lr}	; 02329780
	sub sp,#0x8	; 02329782
	add r6,r0,#0x0	; 02329784
	add r5,r1,#0x0	; 02329786
	mov r4,#0x0	; 02329788
	ldr r1,[r5,#0x0]	; 0232978A
	ldr r0,[r5,#0x4]	; 0232978C
	str r1,[sp,#0x0]	; 0232978E
	str r0,[sp,#0x4]	; 02329790
	ldr r1,[r6,#0x0]	; 02329792
	cmp r1,#0x0	; 02329794
	beq P1_Entry_023297C0	; 02329796
	ldr r0,[r5,#0x0]	; 02329798
P1_Entry_0232979A:
	cmp r1,r0	; 0232979A
	bcs P1_Entry_023297A2	; 0232979C
	add r4,r1,#0x0	; 0232979E
	b P1_Entry_023297BA	; 023297A0
P1_Entry_023297A2:
	ldr r0,[r5,#0x4]	; 023297A2
	cmp r1,r0	; 023297A4
	bne P1_Entry_023297C0	; 023297A6
	ldr r2,[r1,#0x4]	; 023297A8
	add r0,r1,#0x0	; 023297AA
	add r0,#0x10	; 023297AC
	add r0,r2,r0	; 023297AE
	str r0,[sp,#0x4]	; 023297B0
	add r0,r6,#0x0	; 023297B2
	bl P1_Entry_02329AC0	; 023297B4
	b P1_Entry_023297C0	; 023297B8
P1_Entry_023297BA:
	ldr r1,[r1,#0xc]	; 023297BA
	cmp r1,#0x0	; 023297BC
	bne P1_Entry_0232979A	; 023297BE
P1_Entry_023297C0:
	cmp r4,#0x0	; 023297C0
	beq P1_Entry_023297DE	; 023297C2
	ldr r1,[r4,#0x4]	; 023297C4
	add r0,r4,#0x0	; 023297C6
	add r0,#0x10	; 023297C8
	add r1,r1,r0	; 023297CA
	ldr r0,[r5,#0x0]	; 023297CC
	cmp r1,r0	; 023297CE
	bne P1_Entry_023297DE	; 023297D0
	str r4,[sp,#0x0]	; 023297D2
	add r0,r6,#0x0	; 023297D4
	add r1,r4,#0x0	; 023297D6
	bl P1_Entry_02329AC0	; 023297D8
	add r4,r0,#0x0	; 023297DC
P1_Entry_023297DE:
	ldr r1,[sp,#0x4]	; 023297DE
	ldr r0,[sp,#0x0]	; 023297E0
	sub r0,r1,r0	; 023297E2
	cmp r0,#0x10	; 023297E4
	bcs P1_Entry_023297F2	; 023297E6
	mov r0,#0x0	; 023297E8
	add sp,#0x8	; 023297EA
	pop {r4,r5,r6}	; 023297EC
	pop {r3}	; 023297EE
	bx r3	; 023297F0
P1_Entry_023297F2:
	add r0,sp,#0x0	; 023297F2
	ldr r1,[pool_02329810]	; 023297F4
	bl loc_02329A84	; 023297F6
	add r1,r0,#0x0	; 023297FA
	add r0,r6,#0x0	; 023297FC
	add r2,r4,#0x0	; 023297FE
	bl P1_Entry_02329AA0	; 02329800
	mov r0,#0x1	; 02329804
	add sp,#0x8	; 02329806
	pop {r4,r5,r6}	; 02329808
	pop {r3}	; 0232980A
	bx r3	; 0232980C
	.byte 0xC0, 0x46	; 0232980E
pool_02329810:
	.word 0x00004652	; 02329810
P1_Entry_02329814:
	push {r4,r5,r6,r7,lr}	; 02329814
	sub sp,#0x14	; 02329816
	add r3,r1,#0x0	; 02329818
	str r0,[sp,#0xc]	; 0232981A
	add r0,#0x24	; 0232981C
	str r0,[sp,#0xc]	; 0232981E
	ldrh r0,[r0,#0x12]	; 02329820
	mov r7,#0x1	; 02329822
	and r0,r7	; 02329824
	lsl r0,r0,#0x10	; 02329826
	lsr r0,r0,#0x10	; 02329828
	cmp r0,#0x0	; 0232982A
	beq P1_Entry_02329830	; 0232982C
	mov r7,#0x0	; 0232982E
P1_Entry_02329830:
	mov r0,#0x0	; 02329830
	str r0,[sp,#0x4]	; 02329832
	mvn r0,r0	; 02329834
	ldr r1,[sp,#0x4]	; 02329836
	str r1,[sp,#0x8]	; 02329838
	ldr r1,[sp,#0xc]	; 0232983A
	ldr r1,[r1,#0x4]	; 0232983C
	cmp r1,#0x0	; 0232983E
	beq P1_Entry_02329874	; 02329840
	sub r2,r2,#0x1	; 02329842
	mvn r2,r2	; 02329844
	str r2,[sp,#0x10]	; 02329846
P1_Entry_02329848:
	add r6,r1,#0x0	; 02329848
	add r6,#0x10	; 0232984A
	ldr r5,[r1,#0x4]	; 0232984C
	add r2,r5,r6	; 0232984E
	sub r2,r2,r3	; 02329850
	ldr r4,[sp,#0x10]	; 02329852
	and r4,r2	; 02329854
	sub r2,r4,r6	; 02329856
	cmp r2,#0x0	; 02329858
	blt P1_Entry_0232986E	; 0232985A
	cmp r0,r5	; 0232985C
	bls P1_Entry_0232986E	; 0232985E
	str r1,[sp,#0x4]	; 02329860
	add r0,r5,#0x0	; 02329862
	str r4,[sp,#0x8]	; 02329864
	cmp r7,#0x0	; 02329866
	bne P1_Entry_02329874	; 02329868
	cmp r5,r3	; 0232986A
	beq P1_Entry_02329874	; 0232986C
P1_Entry_0232986E:
	ldr r1,[r1,#0x8]	; 0232986E
	cmp r1,#0x0	; 02329870
	bne P1_Entry_02329848	; 02329872
P1_Entry_02329874:
	ldr r0,[sp,#0x4]	; 02329874
	cmp r0,#0x0	; 02329876
	beq P1_Entry_02329890	; 02329878
	mov r0,#0x1	; 0232987A
	str r0,[sp,#0x0]	; 0232987C
	ldr r0,[sp,#0xc]	; 0232987E
	ldr r1,[sp,#0x4]	; 02329880
	ldr r2,[sp,#0x8]	; 02329882
	bl P1_Entry_02329924	; 02329884
	add sp,#0x14	; 02329888
	pop {r4,r5,r6,r7}	; 0232988A
	pop {r3}	; 0232988C
	bx r3	; 0232988E
P1_Entry_02329890:
	mov r0,#0x0	; 02329890
	add sp,#0x14	; 02329892
	pop {r4,r5,r6,r7}	; 02329894
	pop {r3}	; 02329896
	bx r3	; 02329898
	.byte 0x00, 0x00	; 0232989A
P1_Entry_0232989C:
	push {r4,r5,r6,r7,lr}	; 0232989C
	sub sp,#0x14	; 0232989E
	add r3,r1,#0x0	; 023298A0
	str r0,[sp,#0xc]	; 023298A2
	add r0,#0x24	; 023298A4
	str r0,[sp,#0xc]	; 023298A6
	ldrh r0,[r0,#0x12]	; 023298A8
	mov r7,#0x1	; 023298AA
	and r0,r7	; 023298AC
	lsl r0,r0,#0x10	; 023298AE
	lsr r0,r0,#0x10	; 023298B0
	cmp r0,#0x0	; 023298B2
	beq P1_Entry_023298B8	; 023298B4
	mov r7,#0x0	; 023298B6
P1_Entry_023298B8:
	mov r0,#0x0	; 023298B8
	str r0,[sp,#0x4]	; 023298BA
	mvn r0,r0	; 023298BC
	ldr r1,[sp,#0x4]	; 023298BE
	str r1,[sp,#0x8]	; 023298C0
	ldr r1,[sp,#0xc]	; 023298C2
	ldr r1,[r1,#0x0]	; 023298C4
	cmp r1,#0x0	; 023298C6
	beq P1_Entry_023298FC	; 023298C8
	sub r6,r2,#0x1	; 023298CA
	mvn r2,r6	; 023298CC
	str r2,[sp,#0x10]	; 023298CE
P1_Entry_023298D0:
	add r5,r1,#0x0	; 023298D0
	add r5,#0x10	; 023298D2
	add r2,r6,r5	; 023298D4
	ldr r4,[sp,#0x10]	; 023298D6
	and r4,r2	; 023298D8
	ldr r2,[r1,#0x4]	; 023298DA
	sub r5,r4,r5	; 023298DC
	add r5,r3,r5	; 023298DE
	cmp r2,r5	; 023298E0
	bcc P1_Entry_023298F6	; 023298E2
	cmp r0,r2	; 023298E4
	bls P1_Entry_023298F6	; 023298E6
	str r1,[sp,#0x4]	; 023298E8
	add r0,r2,#0x0	; 023298EA
	str r4,[sp,#0x8]	; 023298EC
	cmp r7,#0x0	; 023298EE
	bne P1_Entry_023298FC	; 023298F0
	cmp r2,r3	; 023298F2
	beq P1_Entry_023298FC	; 023298F4
P1_Entry_023298F6:
	ldr r1,[r1,#0xc]	; 023298F6
	cmp r1,#0x0	; 023298F8
	bne P1_Entry_023298D0	; 023298FA
P1_Entry_023298FC:
	ldr r0,[sp,#0x4]	; 023298FC
	cmp r0,#0x0	; 023298FE
	beq P1_Entry_02329918	; 02329900
	mov r0,#0x0	; 02329902
	str r0,[sp,#0x0]	; 02329904
	ldr r0,[sp,#0xc]	; 02329906
	ldr r1,[sp,#0x4]	; 02329908
	ldr r2,[sp,#0x8]	; 0232990A
	bl P1_Entry_02329924	; 0232990C
	add sp,#0x14	; 02329910
	pop {r4,r5,r6,r7}	; 02329912
	pop {r3}	; 02329914
	bx r3	; 02329916
P1_Entry_02329918:
	mov r0,#0x0	; 02329918
	add sp,#0x14	; 0232991A
	pop {r4,r5,r6,r7}	; 0232991C
	pop {r3}	; 0232991E
	bx r3	; 02329920
	.byte 0x00, 0x00	; 02329922
P1_Entry_02329924:
	push {r4,r5,r6,r7,lr}	; 02329924
	sub sp,#0x1c	; 02329926
	add r5,r0,#0x0	; 02329928
	add r7,r1,#0x0	; 0232992A
	add r4,r2,#0x0	; 0232992C
	add r6,r3,#0x0	; 0232992E
	add r0,sp,#0x0	; 02329930
	bl P1_Entry_02329ADC	; 02329932
	ldr r0,[sp,#0x4]	; 02329936
	str r0,[sp,#0xc]	; 02329938
	add r0,r6,r4	; 0232993A
	str r0,[sp,#0x8]	; 0232993C
	add r6,r4,#0x0	; 0232993E
	sub r6,#0x10	; 02329940
	str r6,[sp,#0x4]	; 02329942
	add r0,r5,#0x0	; 02329944
	add r1,r7,#0x0	; 02329946
	bl P1_Entry_02329AC0	; 02329948
	add r7,r0,#0x0	; 0232994C
	ldr r1,[sp,#0x0]	; 0232994E
	ldr r0,[sp,#0x4]	; 02329950
	sub r0,r0,r1	; 02329952
	cmp r0,#0x10	; 02329954
	bcs P1_Entry_0232995C	; 02329956
	str r1,[sp,#0x4]	; 02329958
	b P1_Entry_02329970	; 0232995A
P1_Entry_0232995C:
	add r0,sp,#0x0	; 0232995C
	ldr r1,[pool_02329A20]	; 0232995E
	bl loc_02329A84	; 02329960
	add r1,r0,#0x0	; 02329964
	add r0,r5,#0x0	; 02329966
	add r2,r7,#0x0	; 02329968
	bl P1_Entry_02329AA0	; 0232996A
	add r7,r0,#0x0	; 0232996E
P1_Entry_02329970:
	ldr r1,[sp,#0xc]	; 02329970
	ldr r0,[sp,#0x8]	; 02329972
	sub r0,r1,r0	; 02329974
	cmp r0,#0x10	; 02329976
	bcs P1_Entry_0232997E	; 02329978
	str r1,[sp,#0x8]	; 0232997A
	b P1_Entry_02329990	; 0232997C
P1_Entry_0232997E:
	add r0,sp,#0x8	; 0232997E
	ldr r1,[pool_02329A20]	; 02329980
	bl loc_02329A84	; 02329982
	add r1,r0,#0x0	; 02329986
	add r0,r5,#0x0	; 02329988
	add r2,r7,#0x0	; 0232998A
	bl P1_Entry_02329AA0	; 0232998C
P1_Entry_02329990:
	ldr r1,[sp,#0x4]	; 02329990
	ldr r0,[sp,#0x8]	; 02329992
	sub r2,r0,r1	; 02329994
	sub r0,r5,#0x4	; 02329996
	ldr r3,[r0,#0x0]	; 02329998
	mov r0,#0xff	; 0232999A
	and r3,r0	; 0232999C
	lsl r0,r3,#0x10	; 0232999E
	lsr r3,r0,#0x10	; 023299A0
	mov r0,#0x1	; 023299A2
	and r3,r0	; 023299A4
	cmp r3,#0x0	; 023299A6
	beq P1_Entry_023299B4	; 023299A8
	mov r0,#0x0	; 023299AA
	str r0,[sp,#0x18]	; 023299AC
	ldr r0,[sp,#0x18]	; 023299AE
	blx P1_MemFill32	; 023299B0
P1_Entry_023299B4:
	str r6,[sp,#0x10]	; 023299B4
	ldr r0,[sp,#0x8]	; 023299B6
	str r0,[sp,#0x14]	; 023299B8
	add r0,sp,#0x10	; 023299BA
	ldr r1,[pool_02329A24]	; 023299BC
	bl loc_02329A84	; 023299BE
	add r1,r0,#0x0	; 023299C2
	ldrh r2,[r1,#0x2]	; 023299C4
	ldr r0,[pool_02329A28]	; 023299C6
	and r2,r0	; 023299C8
	strh r2,[r1,#0x2]	; 023299CA
	ldrh r0,[r1,#0x2]	; 023299CC
	add r2,sp,#0x20	; 023299CE
	ldrh r3,[r2,#0x10]	; 023299D0
	mov r2,#0x1	; 023299D2
	and r3,r2	; 023299D4
	lsl r2,r3,#0xf	; 023299D6
	orr r0,r2	; 023299D8
	strh r0,[r1,#0x2]	; 023299DA
	ldr r0,[sp,#0x4]	; 023299DC
	sub r3,r1,r0	; 023299DE
	ldrh r2,[r1,#0x2]	; 023299E0
	ldr r0,[pool_02329A2C]	; 023299E2
	and r2,r0	; 023299E4
	strh r2,[r1,#0x2]	; 023299E6
	ldrh r0,[r1,#0x2]	; 023299E8
	lsl r2,r3,#0x10	; 023299EA
	lsr r3,r2,#0x10	; 023299EC
	mov r2,#0x7f	; 023299EE
	and r3,r2	; 023299F0
	lsl r2,r3,#0x8	; 023299F2
	orr r0,r2	; 023299F4
	strh r0,[r1,#0x2]	; 023299F6
	ldrh r3,[r5,#0x10]	; 023299F8
	mov r0,#0xff	; 023299FA
	and r3,r0	; 023299FC
	ldrh r2,[r1,#0x2]	; 023299FE
	bic r2,r0	; 02329A00
	strh r2,[r1,#0x2]	; 02329A02
	ldrh r0,[r1,#0x2]	; 02329A04
	orr r0,r3	; 02329A06
	strh r0,[r1,#0x2]	; 02329A08
	add r0,r5,#0x0	; 02329A0A
	add r0,#0x8	; 02329A0C
	ldr r2,[r5,#0xc]	; 02329A0E
	bl P1_Entry_02329AA0	; 02329A10
	add r0,r4,#0x0	; 02329A14
	add sp,#0x1c	; 02329A16
	pop {r4,r5,r6,r7}	; 02329A18
	pop {r3}	; 02329A1A
	bx r3	; 02329A1C
	.byte 0xC0, 0x46	; 02329A1E
pool_02329A20:
	.word 0x00004652	; 02329A20
pool_02329A24:
	.word 0x00005544	; 02329A24
pool_02329A28:
	.word 0xFFFF7FFF	; 02329A28
pool_02329A2C:
	.word 0xFFFF80FF	; 02329A2C

; ===== function loc_02329A30 =====
	push {r4,r5,lr}	; 02329A30
	sub sp,#0xc	; 02329A32
	add r5,r0,#0x0	; 02329A34
	add r3,r1,#0x0	; 02329A36
	add r4,r5,#0x0	; 02329A38
	add r4,#0x24	; 02329A3A
	str r2,[sp,#0x0]	; 02329A3C
	ldr r1,[pool_02329A7C]	; 02329A3E
	add r2,r4,#0x0	; 02329A40
	add r2,#0x14	; 02329A42
	bl loc_02329628	; 02329A44
	mov r0,#0x0	; 02329A48
	strh r0,[r4,#0x10]	; 02329A4A
	strh r0,[r4,#0x12]	; 02329A4C
	ldrh r1,[r4,#0x12]	; 02329A4E
	mov r0,#0x1	; 02329A50
	bic r1,r0	; 02329A52
	strh r1,[r4,#0x12]	; 02329A54
	ldr r0,[r5,#0x18]	; 02329A56
	str r0,[sp,#0x4]	; 02329A58
	ldr r0,[r5,#0x1c]	; 02329A5A
	str r0,[sp,#0x8]	; 02329A5C
	add r0,sp,#0x4	; 02329A5E
	ldr r1,[pool_02329A80]	; 02329A60
	bl loc_02329A84	; 02329A62
	str r0,[r5,#0x24]	; 02329A66
	str r0,[r4,#0x4]	; 02329A68
	mov r0,#0x0	; 02329A6A
	str r0,[r4,#0x8]	; 02329A6C
	str r0,[r4,#0xc]	; 02329A6E
	add r0,r5,#0x0	; 02329A70
	add sp,#0xc	; 02329A72
	pop {r4,r5}	; 02329A74
	pop {r3}	; 02329A76
	bx r3	; 02329A78
	.byte 0xC0, 0x46	; 02329A7C
pool_02329A7C:
loc_02329A7C:
	.word 0x45585048	; 02329A7C
pool_02329A80:
loc_02329A80:
	.word 0x00004652	; 02329A80

; ===== function loc_02329A84 =====
loc_02329A84:
	ldr r3,[r0,#0x0]	; 02329A84
	strh r1,[r3,#0x0]	; 02329A86
	mov r2,#0x0	; 02329A88
	strh r2,[r3,#0x2]	; 02329A8A
	ldr r1,[r0,#0x4]	; 02329A8C
	add r0,r3,#0x0	; 02329A8E
	add r0,#0x10	; 02329A90
	sub r0,r1,r0	; 02329A92
	str r0,[r3,#0x4]	; 02329A94
	str r2,[r3,#0x8]	; 02329A96
	str r2,[r3,#0xc]	; 02329A98
	add r0,r3,#0x0	; 02329A9A
	bx lr	; 02329A9C
	.byte 0x00, 0x00	; 02329A9E
P1_Entry_02329AA0:
	str r2,[r1,#0x8]	; 02329AA0
	cmp r2,#0x0	; 02329AA2
	beq P1_Entry_02329AAC	; 02329AA4
	ldr r3,[r2,#0xc]	; 02329AA6
	str r1,[r2,#0xc]	; 02329AA8
	b P1_Entry_02329AB0	; 02329AAA
P1_Entry_02329AAC:
	ldr r3,[r0,#0x0]	; 02329AAC
	str r1,[r0,#0x0]	; 02329AAE
P1_Entry_02329AB0:
	str r3,[r1,#0xc]	; 02329AB0
	cmp r3,#0x0	; 02329AB2
	beq P1_Entry_02329ABA	; 02329AB4
	str r1,[r3,#0x8]	; 02329AB6
	b P1_Entry_02329ABC	; 02329AB8
P1_Entry_02329ABA:
	str r1,[r0,#0x4]	; 02329ABA
P1_Entry_02329ABC:
	add r0,r1,#0x0	; 02329ABC
	bx lr	; 02329ABE
P1_Entry_02329AC0:
	ldr r2,[r1,#0x8]	; 02329AC0
	ldr r1,[r1,#0xc]	; 02329AC2
	cmp r2,#0x0	; 02329AC4
	beq P1_Entry_02329ACC	; 02329AC6
	str r1,[r2,#0xc]	; 02329AC8
	b P1_Entry_02329ACE	; 02329ACA
P1_Entry_02329ACC:
	str r1,[r0,#0x0]	; 02329ACC
P1_Entry_02329ACE:
	cmp r1,#0x0	; 02329ACE
	beq P1_Entry_02329AD6	; 02329AD0
	str r2,[r1,#0x8]	; 02329AD2
	b P1_Entry_02329AD8	; 02329AD4
P1_Entry_02329AD6:
	str r2,[r0,#0x4]	; 02329AD6
P1_Entry_02329AD8:
	add r0,r2,#0x0	; 02329AD8
	bx lr	; 02329ADA
P1_Entry_02329ADC:
	ldrh r2,[r1,#0x2]	; 02329ADC
	asr r3,r2,#0x8	; 02329ADE
	mov r2,#0x7f	; 02329AE0
	and r3,r2	; 02329AE2
	lsl r2,r3,#0x10	; 02329AE4
	lsr r2,r2,#0x10	; 02329AE6
	sub r2,r1,r2	; 02329AE8
	str r2,[r0,#0x0]	; 02329AEA
	ldr r2,[r1,#0x4]	; 02329AEC
	add r1,#0x10	; 02329AEE
	add r1,r2,r1	; 02329AF0
	str r1,[r0,#0x4]	; 02329AF2
	bx lr	; 02329AF4
	.byte 0x00, 0x00	; 02329AF6

; ===== function loc_02329AF8 =====
loc_02329AF8:
	push {r4,r5,lr}	; 02329AF8
	sub sp,#0x4	; 02329AFA
	add r5,r0,#0x0	; 02329AFC
	add r4,r1,#0x0	; 02329AFE
	mov r1,#0x1	; 02329B00
	add r2,r4,#0x0	; 02329B02
	and r2,r1	; 02329B04
	cmp r2,#0x0	; 02329B06
	beq loc_02329B0E	; 02329B08
	bl loc_02329BA0	; 02329B0A
loc_02329B0E:
	mov r0,#0x2	; 02329B0E
	and r4,r0	; 02329B10
	cmp r4,#0x0	; 02329B12
	beq loc_02329B1C	; 02329B14
	add r0,r5,#0x0	; 02329B16
	bl loc_02329B84	; 02329B18
loc_02329B1C:
	add sp,#0x4	; 02329B1C
	pop {r4,r5}	; 02329B1E
	pop {r3}	; 02329B20
	bx r3	; 02329B22

; ===== function loc_02329B24 =====
loc_02329B24:
	push {lr}	; 02329B24
	sub sp,#0x4	; 02329B26
	add r0,#0x24	; 02329B28
	cmp r1,#0x0	; 02329B2A
	bne loc_02329B30	; 02329B2C
	mov r1,#0x1	; 02329B2E
loc_02329B30:
	add r1,r1,#0x3	; 02329B30
	mov r3,#0x3	; 02329B32
	bic r1,r3	; 02329B34
	cmp r2,#0x0	; 02329B36
	blt loc_02329B44	; 02329B38
	bl loc_02329C00	; 02329B3A
	add sp,#0x4	; 02329B3E
	pop {r3}	; 02329B40
	bx r3	; 02329B42
loc_02329B44:
	neg r2,r2	; 02329B44
	bl loc_02329BB0	; 02329B46
	add sp,#0x4	; 02329B4A
	pop {r3}	; 02329B4C
	bx r3	; 02329B4E

; ===== function loc_02329B50 =====
loc_02329B50:
	ldr r3,[pool_02329B54]	; 02329B50
	bx r3	; 02329B52
pool_02329B54:
loc_02329B54:
	.word loc_02329614 + 1	; 02329B54

; ===== function loc_02329B58 =====
loc_02329B58:
	push {lr}	; 02329B58
	sub sp,#0x4	; 02329B5A
	add r1,r1,r0	; 02329B5C
	mov r3,#0x3	; 02329B5E
	bic r1,r3	; 02329B60
	add r0,r0,#0x3	; 02329B62
	bic r0,r3	; 02329B64
	cmp r0,r1	; 02329B66
	bhi loc_02329B70	; 02329B68
	sub r3,r1,r0	; 02329B6A
	cmp r3,#0x30	; 02329B6C
	bcs loc_02329B78	; 02329B6E
loc_02329B70:
	mov r0,#0x0	; 02329B70
	add sp,#0x4	; 02329B72
	pop {r3}	; 02329B74
	bx r3	; 02329B76
loc_02329B78:
	bl loc_02329C50	; 02329B78
	add sp,#0x4	; 02329B7C
	pop {r3}	; 02329B7E
	bx r3	; 02329B80
	.byte 0x00, 0x00	; 02329B84

; ===== function loc_02329B84 =====
loc_02329B84:
	add r2,r0,#0x0	; 02329B84
	add r2,#0x24	; 02329B86
	ldr r3,[r2,#0x8]	; 02329B88
	cmp r3,#0x0	; 02329B8A
	beq loc_02329B98	; 02329B8C
loc_02329B8E:
	ldr r1,[r0,#0x1c]	; 02329B8E
	str r1,[r3,#0x8]	; 02329B90
	ldr r3,[r3,#0xc]	; 02329B92
	cmp r3,#0x0	; 02329B94
	bne loc_02329B8E	; 02329B96
loc_02329B98:
	ldr r0,[r0,#0x1c]	; 02329B98
	str r0,[r2,#0x4]	; 02329B9A
	bx lr	; 02329B9C
	.byte 0x00, 0x00	; 02329BA0

; ===== function loc_02329BA0 =====
loc_02329BA0:
	add r2,r0,#0x0	; 02329BA0
	add r2,#0x24	; 02329BA2
	ldr r1,[r0,#0x18]	; 02329BA4
	str r1,[r0,#0x24]	; 02329BA6
	mov r0,#0x0	; 02329BA8
	str r0,[r2,#0x8]	; 02329BAA
	bx lr	; 02329BAC
	.byte 0x00, 0x00	; 02329BB0

; ===== function loc_02329BB0 =====
loc_02329BB0:
	push {r4,r5,lr}	; 02329BB0
	sub sp,#0x4	; 02329BB2
	add r5,r0,#0x0	; 02329BB4
	ldr r0,[r5,#0x4]	; 02329BB6
	sub r2,r2,#0x1	; 02329BB8
	mvn r4,r2	; 02329BBA
	sub r1,r0,r1	; 02329BBC
	and r4,r1	; 02329BBE
	ldr r1,[r5,#0x0]	; 02329BC0
	cmp r4,r1	; 02329BC2
	bcs loc_02329BD0	; 02329BC4
	mov r0,#0x0	; 02329BC6
	add sp,#0x4	; 02329BC8
	pop {r4,r5}	; 02329BCA
	pop {r3}	; 02329BCC
	bx r3	; 02329BCE
loc_02329BD0:
	sub r2,r0,r4	; 02329BD0
	sub r0,r5,#0x4	; 02329BD2
	ldr r1,[r0,#0x0]	; 02329BD4
	mov r0,#0xff	; 02329BD6
	and r1,r0	; 02329BD8
	lsl r0,r1,#0x10	; 02329BDA
	lsr r1,r0,#0x10	; 02329BDC
	mov r0,#0x1	; 02329BDE
	and r1,r0	; 02329BE0
	cmp r1,#0x0	; 02329BE2
	beq loc_02329BF2	; 02329BE4
	mov r0,#0x0	; 02329BE6
	str r0,[sp,#0x0]	; 02329BE8
	ldr r0,[sp,#0x0]	; 02329BEA
	add r1,r4,#0x0	; 02329BEC
	blx loc_0232DD90	; 02329BEE
loc_02329BF2:
	str r4,[r5,#0x4]	; 02329BF2
	add r0,r4,#0x0	; 02329BF4
	add sp,#0x4	; 02329BF6
	pop {r4,r5}	; 02329BF8
	pop {r3}	; 02329BFA
	bx r3	; 02329BFC
	.byte 0x00, 0x00	; 02329C00

; ===== function loc_02329C00 =====
loc_02329C00:
	push {r4,r5,r6,lr}	; 02329C00
	sub sp,#0x8	; 02329C02
	add r5,r0,#0x0	; 02329C04
	ldr r3,[r5,#0x0]	; 02329C06
	sub r0,r2,#0x1	; 02329C08
	mvn r4,r0	; 02329C0A
	add r0,r0,r3	; 02329C0C
	and r4,r0	; 02329C0E
	add r6,r1,r4	; 02329C10
	ldr r0,[r5,#0x4]	; 02329C12
	cmp r6,r0	; 02329C14
	bls loc_02329C22	; 02329C16
	mov r0,#0x0	; 02329C18
	add sp,#0x8	; 02329C1A
	pop {r4,r5,r6}	; 02329C1C
	pop {r3}	; 02329C1E
	bx r3	; 02329C20
loc_02329C22:
	sub r2,r6,r3	; 02329C22
	sub r0,r5,#0x4	; 02329C24
	ldr r1,[r0,#0x0]	; 02329C26
	mov r0,#0xff	; 02329C28
	and r1,r0	; 02329C2A
	lsl r0,r1,#0x10	; 02329C2C
	lsr r1,r0,#0x10	; 02329C2E
	mov r0,#0x1	; 02329C30
	and r1,r0	; 02329C32
	cmp r1,#0x0	; 02329C34
	beq loc_02329C44	; 02329C36
	mov r0,#0x0	; 02329C38
	str r0,[sp,#0x0]	; 02329C3A
	ldr r0,[sp,#0x0]	; 02329C3C
	add r1,r3,#0x0	; 02329C3E
	blx loc_0232DD90	; 02329C40
loc_02329C44:
	str r6,[r5,#0x0]	; 02329C44
	add r0,r4,#0x0	; 02329C46
	add sp,#0x8	; 02329C48
	pop {r4,r5,r6}	; 02329C4A
	pop {r3}	; 02329C4C
	bx r3	; 02329C4E

; ===== function loc_02329C50 =====
loc_02329C50:
	push {r4,r5,lr}	; 02329C50
	sub sp,#0x4	; 02329C52
	add r5,r0,#0x0	; 02329C54
	add r3,r1,#0x0	; 02329C56
	add r4,r5,#0x0	; 02329C58
	add r4,#0x24	; 02329C5A
	str r2,[sp,#0x0]	; 02329C5C
	ldr r1,[pool_02329C80]	; 02329C5E
	add r2,r4,#0x0	; 02329C60
	add r2,#0xc	; 02329C62
	bl loc_02329628	; 02329C64
	ldr r0,[r5,#0x18]	; 02329C68
	str r0,[r5,#0x24]	; 02329C6A
	ldr r0,[r5,#0x1c]	; 02329C6C
	str r0,[r4,#0x4]	; 02329C6E
	mov r0,#0x0	; 02329C70
	str r0,[r4,#0x8]	; 02329C72
	add r0,r5,#0x0	; 02329C74
	add sp,#0x4	; 02329C76
	pop {r4,r5}	; 02329C78
	pop {r3}	; 02329C7A
	bx r3	; 02329C7C
	.byte 0xC0, 0x46	; 02329C80
pool_02329C80:
loc_02329C80:
	.word 0x46524D48	; 02329C80

; ===== function loc_02329C84 =====
loc_02329C84:
	ldr r3,[pool_02329C88]	; 02329C84
	bx r3	; 02329C86
pool_02329C88:
loc_02329C88:
	.word loc_0232A440 + 1	; 02329C88

; ===== function loc_02329C8C =====
loc_02329C8C:
	push {r4,lr}	; 02329C8C
	bl loc_0232A4A0	; 02329C8E
	mov r0,#0x0	; 02329C92
	add r1,r0,#0x0	; 02329C94
	add r2,r0,#0x0	; 02329C96
	add r3,r0,#0x0	; 02329C98
	bl loc_0232E044	; 02329C9A
	bl loc_0232E25C	; 02329C9E
	add r4,r0,#0x0	; 02329CA2
	mov r0,#0x1	; 02329CA4
	bl loc_0232E2C8	; 02329CA6
	add r0,r4,#0x0	; 02329CAA
	bl loc_0232E27C	; 02329CAC
	pop {r4}	; 02329CB0
	pop {r3}	; 02329CB2
	bx r3	; 02329CB4
	.byte 0x00, 0x00	; 02329CB8

; ===== function loc_02329CB8 =====
loc_02329CB8:
	push {r4,lr}	; 02329CB8
	mov r4,#0x0	; 02329CBA
loc_02329CBC:
	add r0,r4,#0x0	; 02329CBC
	bl loc_0232E420	; 02329CBE
	cmp r0,#0x0	; 02329CC2
	bne loc_02329CBC	; 02329CC4
	bl loc_0232A238	; 02329CC6
	bl loc_0232A830	; 02329CCA
	mov r0,#0x0	; 02329CCE
	bl loc_0232E2C8	; 02329CD0
	pop {r4}	; 02329CD4
	pop {r3}	; 02329CD6
	bx r3	; 02329CD8
	.byte 0x00, 0x00	; 02329CDC

; ===== function loc_02329CDC =====
loc_02329CDC:
	push {lr}	; 02329CDC
	sub sp,#0x4	; 02329CDE
	ldr r0,[pool_02329D04]	; 02329CE0
	ldr r1,[r0,#0x0]	; 02329CE2
	cmp r1,#0x0	; 02329CE4
	bne loc_02329CFC	; 02329CE6
	mov r1,#0x1	; 02329CE8
	str r1,[r0,#0x0]	; 02329CEA
	bl loc_0232DE7C	; 02329CEC
	bl loc_02329DD4	; 02329CF0
	bl loc_0232A890	; 02329CF4
	bl loc_0232A328	; 02329CF8
loc_02329CFC:
	add sp,#0x4	; 02329CFC
	pop {r3}	; 02329CFE
	bx r3	; 02329D00
	.byte 0xC0, 0x46	; 02329D04
pool_02329D04:
loc_02329D04:
	.word P1_BssStart + 0x25A18	; 02329D04

; ===== function loc_02329D08 =====
loc_02329D08:
	ldr r1,[pool_02329D18]	; 02329D08
	ldr r3,[r1,#0x0]	; 02329D0A
	mov r2,#0x1	; 02329D0C
	lsl r2,r0	; 02329D0E
	bic r3,r2	; 02329D10
	str r3,[r1,#0x0]	; 02329D12
	bx lr	; 02329D14
	.byte 0xC0, 0x46	; 02329D18
pool_02329D18:
loc_02329D18:
	.word P1_BssStart + 0x25A20	; 02329D18

; ===== function loc_02329D1C =====
loc_02329D1C:
	mov r3,#0x1	; 02329D1C
	mov r0,#0x0	; 02329D1E
	ldr r1,[pool_02329D44]	; 02329D20
	ldr r2,[r1,#0x0]	; 02329D22
loc_02329D24:
	add r1,r2,#0x0	; 02329D24
	and r1,r3	; 02329D26
	cmp r1,#0x0	; 02329D28
	bne loc_02329D36	; 02329D2A
	ldr r1,[pool_02329D44]	; 02329D2C
	ldr r2,[r1,#0x0]	; 02329D2E
	orr r2,r3	; 02329D30
	str r2,[r1,#0x0]	; 02329D32
	bx lr	; 02329D34
loc_02329D36:
	add r0,r0,#0x1	; 02329D36
	lsl r3,r3,#0x1	; 02329D38
	cmp r0,#0x8	; 02329D3A
	blt loc_02329D24	; 02329D3C
	mov r0,#0x0	; 02329D3E
	mvn r0,r0	; 02329D40
	bx lr	; 02329D42
pool_02329D44:
loc_02329D44:
	.word P1_BssStart + 0x25A20	; 02329D44

; ===== function loc_02329D48 =====
loc_02329D48:
	ldr r1,[pool_02329D54]	; 02329D48
	ldr r2,[r1,#0x0]	; 02329D4A
	bic r2,r0	; 02329D4C
	str r2,[r1,#0x0]	; 02329D4E
	bx lr	; 02329D50
	.byte 0xC0, 0x46	; 02329D54
pool_02329D54:
loc_02329D54:
	.word P1_BssStart + 0x25A1C	; 02329D54

; ===== function loc_02329D58 =====
loc_02329D58:
	ldr r1,[pool_02329D70]	; 02329D58
	ldr r2,[r1,#0x0]	; 02329D5A
	add r3,r0,#0x0	; 02329D5C
	and r3,r2	; 02329D5E
	cmp r3,#0x0	; 02329D60
	beq loc_02329D68	; 02329D62
	mov r0,#0x0	; 02329D64
	bx lr	; 02329D66
loc_02329D68:
	orr r2,r0	; 02329D68
	str r2,[r1,#0x0]	; 02329D6A
	mov r0,#0x1	; 02329D6C
	bx lr	; 02329D6E
pool_02329D70:
loc_02329D70:
	.word P1_BssStart + 0x25A1C	; 02329D70

; ===== function loc_02329D74 =====
loc_02329D74:
	push {r4,lr}	; 02329D74
	add r4,r0,#0x0	; 02329D76
	cmp r4,#0x0	; 02329D78
	beq loc_02329D8A	; 02329D7A
	mov r1,#0x0	; 02329D7C
	bl loc_0232DFA8	; 02329D7E
	ldr r0,[pool_02329D90]	; 02329D82
	ldr r1,[r0,#0x0]	; 02329D84
	bic r1,r4	; 02329D86
	str r1,[r0,#0x0]	; 02329D88
loc_02329D8A:
	pop {r4}	; 02329D8A
	pop {r3}	; 02329D8C
	bx r3	; 02329D8E
pool_02329D90:
loc_02329D90:
	.word P1_BssStart + 0x25A24	; 02329D90

; ===== function loc_02329D94 =====
loc_02329D94:
	push {r4,lr}	; 02329D94
	add r4,r0,#0x0	; 02329D96
	cmp r4,#0x0	; 02329D98
	bne loc_02329DA4	; 02329D9A
	mov r0,#0x1	; 02329D9C
	pop {r4}	; 02329D9E
	pop {r3}	; 02329DA0
	bx r3	; 02329DA2
loc_02329DA4:
	ldr r1,[pool_02329DD0]	; 02329DA4
	ldr r1,[r1,#0x0]	; 02329DA6
	add r2,r4,#0x0	; 02329DA8
	and r2,r1	; 02329DAA
	cmp r2,#0x0	; 02329DAC
	beq loc_02329DB8	; 02329DAE
	mov r0,#0x0	; 02329DB0
	pop {r4}	; 02329DB2
	pop {r3}	; 02329DB4
	bx r3	; 02329DB6
loc_02329DB8:
	mov r1,#0x0	; 02329DB8
	bl loc_0232DFC4	; 02329DBA
	ldr r0,[pool_02329DD0]	; 02329DBE
	ldr r1,[r0,#0x0]	; 02329DC0
	orr r1,r4	; 02329DC2
	str r1,[r0,#0x0]	; 02329DC4
	mov r0,#0x1	; 02329DC6
	pop {r4}	; 02329DC8
	pop {r3}	; 02329DCA
	bx r3	; 02329DCC
	.byte 0xC0, 0x46	; 02329DD0
pool_02329DD0:
loc_02329DD0:
	.word P1_BssStart + 0x25A24	; 02329DD0

; ===== function loc_02329DD4 =====
loc_02329DD4:
	mov r1,#0x0	; 02329DD4
	ldr r0,[pool_02329DE4]	; 02329DD6
	str r1,[r0,#0x0]	; 02329DD8
	ldr r0,[pool_02329DE8]	; 02329DDA
	str r1,[r0,#0x0]	; 02329DDC
	ldr r0,[pool_02329DEC]	; 02329DDE
	str r1,[r0,#0x0]	; 02329DE0
	bx lr	; 02329DE2
pool_02329DE4:
loc_02329DE4:
	.word P1_BssStart + 0x25A24	; 02329DE4
pool_02329DE8:
loc_02329DE8:
	.word P1_BssStart + 0x25A1C	; 02329DE8
pool_02329DEC:
loc_02329DEC:
	.word P1_BssStart + 0x25A20	; 02329DEC

; ===== function loc_02329DF0 =====
loc_02329DF0:
	push {r4,r5,r6,lr}	; 02329DF0
	add r5,r0,#0x0	; 02329DF2
	add r6,r1,#0x0	; 02329DF4
	ldr r4,[r5,#0x4]	; 02329DF6
	cmp r4,#0x0	; 02329DF8
	beq loc_02329E08	; 02329DFA
	add r0,r4,#0x0	; 02329DFC
	add r1,r5,#0x0	; 02329DFE
	bl loc_023294F4	; 02329E00
	mov r0,#0x0	; 02329E04
	str r0,[r5,#0x4]	; 02329E06
loc_02329E08:
	ldr r0,[pool_02329E30]	; 02329E08
	add r1,r5,#0x0	; 02329E0A
	bl loc_023294F4	; 02329E0C
	add r0,r5,#0x0	; 02329E10
	add r0,#0x3d	; 02329E12
	strb r6,[r0,#0x0]	; 02329E14
	cmp r4,#0x0	; 02329E16
	beq loc_02329E22	; 02329E18
	add r0,r4,#0x0	; 02329E1A
	add r1,r5,#0x0	; 02329E1C
	bl loc_02329F88	; 02329E1E
loc_02329E22:
	add r0,r5,#0x0	; 02329E22
	bl loc_02329F40	; 02329E24
	pop {r4,r5,r6}	; 02329E28
	pop {r3}	; 02329E2A
	bx r3	; 02329E2C
	.byte 0xC0, 0x46	; 02329E30
pool_02329E30:
loc_02329E30:
	.word 0x023563F4	; 02329E30

; ===== function loc_02329E34 =====
	push {r4,lr}	; 02329E34
	add r4,r0,#0x0	; 02329E36
	ldr r0,[r4,#0x8]	; 02329E38
	cmp r0,#0x0	; 02329E3A
	beq loc_02329E64	; 02329E3C
	bl loc_0232ABD4	; 02329E3E
	ldr r1,[r4,#0xc]	; 02329E42
	cmp r1,#0x0	; 02329E44
	beq loc_02329E52	; 02329E46
	mov r0,#0x0	; 02329E48
	str r0,[r1,#0x8]	; 02329E4A
	pop {r4}	; 02329E4C
	pop {r3}	; 02329E4E
	bx r3	; 02329E50
loc_02329E52:
	ldr r2,[pool_02329E6C]	; 02329E52
	ldr r1,[r4,#0x10]	; 02329E54
	mov r0,#0x1c	; 02329E56
	mul r1,r0	; 02329E58
	add r0,r2,r1	; 02329E5A
	add r0,#0xc	; 02329E5C
	add r1,r4,#0x0	; 02329E5E
	bl loc_023294F4	; 02329E60
loc_02329E64:
	pop {r4}	; 02329E64
	pop {r3}	; 02329E66
	bx r3	; 02329E68
	.byte 0xC0, 0x46	; 02329E6C
pool_02329E6C:
loc_02329E6C:
	.word 0x02356400	; 02329E6C

; ===== function loc_02329E70 =====
loc_02329E70:
	push {r4,r5,lr}	; 02329E70
	sub sp,#0x4	; 02329E72
	add r5,r0,#0x0	; 02329E74
	ldr r1,[r5,#0x0]	; 02329E76
	cmp r1,#0x0	; 02329E78
	beq loc_02329E82	; 02329E7A
	mov r0,#0x0	; 02329E7C
	str r0,[r1,#0x0]	; 02329E7E
	str r0,[r5,#0x0]	; 02329E80
loc_02329E82:
	ldr r4,[r5,#0x4]	; 02329E82
	add r0,r4,#0x0	; 02329E84
	add r1,r5,#0x0	; 02329E86
	bl loc_023294F4	; 02329E88
	mov r0,#0x0	; 02329E8C
	str r0,[r5,#0x4]	; 02329E8E
	ldr r1,[r5,#0x8]	; 02329E90
	cmp r1,#0x0	; 02329E92
	beq loc_02329EA6	; 02329E94
	add r4,#0xc	; 02329E96
	add r0,r4,#0x0	; 02329E98
	bl loc_023295B4	; 02329E9A
	mov r1,#0x0	; 02329E9E
	ldr r0,[r5,#0x8]	; 02329EA0
	str r1,[r0,#0xc]	; 02329EA2
	str r1,[r5,#0x8]	; 02329EA4
loc_02329EA6:
	ldr r0,[pool_02329EC4]	; 02329EA6
	add r1,r5,#0x0	; 02329EA8
	bl loc_023294F4	; 02329EAA
	ldr r0,[pool_02329EC8]	; 02329EAE
	add r1,r5,#0x0	; 02329EB0
	bl loc_023295B4	; 02329EB2
	mov r0,#0x0	; 02329EB6
	add r5,#0x2c	; 02329EB8
	strb r0,[r5,#0x0]	; 02329EBA
	add sp,#0x4	; 02329EBC
	pop {r4,r5}	; 02329EBE
	pop {r3}	; 02329EC0
	bx r3	; 02329EC2
pool_02329EC4:
loc_02329EC4:
	.word 0x023563F4	; 02329EC4
pool_02329EC8:
loc_02329EC8:
	.word 0x023563E8	; 02329EC8

; ===== function loc_02329ECC =====
loc_02329ECC:
	push {r4,r5,lr}	; 02329ECC
	sub sp,#0x4	; 02329ECE
	add r5,r0,#0x0	; 02329ED0
	ldr r0,[pool_02329F20]	; 02329ED2
	mov r1,#0x0	; 02329ED4
	bl loc_023294E4	; 02329ED6
	add r4,r0,#0x0	; 02329EDA
	cmp r4,#0x0	; 02329EDC
	bne loc_02329F02	; 02329EDE
	ldr r0,[pool_02329F24]	; 02329EE0
	mov r1,#0x0	; 02329EE2
	bl loc_023294E4	; 02329EE4
	add r4,r0,#0x0	; 02329EE8
	add r1,r4,#0x0	; 02329EEA
	add r1,#0x3d	; 02329EEC
	ldrb r1,[r1,#0x0]	; 02329EEE
	cmp r5,r1	; 02329EF0
	bge loc_02329EFE	; 02329EF2
	mov r0,#0x0	; 02329EF4
	add sp,#0x4	; 02329EF6
	pop {r4,r5}	; 02329EF8
	pop {r3}	; 02329EFA
	bx r3	; 02329EFC
loc_02329EFE:
	bl loc_02329F28	; 02329EFE
loc_02329F02:
	ldr r0,[pool_02329F20]	; 02329F02
	add r1,r4,#0x0	; 02329F04
	bl loc_023294F4	; 02329F06
	add r0,r4,#0x0	; 02329F0A
	add r0,#0x3d	; 02329F0C
	strb r5,[r0,#0x0]	; 02329F0E
	add r0,r4,#0x0	; 02329F10
	bl loc_02329F40	; 02329F12
	add r0,r4,#0x0	; 02329F16
	add sp,#0x4	; 02329F18
	pop {r4,r5}	; 02329F1A
	pop {r3}	; 02329F1C
	bx r3	; 02329F1E
pool_02329F20:
loc_02329F20:
	.word 0x023563E8	; 02329F20
pool_02329F24:
loc_02329F24:
	.word 0x023563F4	; 02329F24

; ===== function loc_02329F28 =====
loc_02329F28:
	push {r4,lr}	; 02329F28
	add r4,r0,#0x0	; 02329F2A
	add r0,#0x3c	; 02329F2C
	ldrb r0,[r0,#0x0]	; 02329F2E
	bl loc_0232E104	; 02329F30
	add r0,r4,#0x0	; 02329F34
	bl loc_02329E70	; 02329F36
	pop {r4}	; 02329F3A
	pop {r3}	; 02329F3C
	bx r3	; 02329F3E

; ===== function loc_02329F40 =====
loc_02329F40:
	push {r4,r5,lr}	; 02329F40
	sub sp,#0x4	; 02329F42
	add r5,r0,#0x0	; 02329F44
	ldr r0,[pool_02329F84]	; 02329F46
	mov r1,#0x0	; 02329F48
	bl loc_023294E4	; 02329F4A
	add r1,r0,#0x0	; 02329F4E
	cmp r1,#0x0	; 02329F50
	beq loc_02329F72	; 02329F52
	ldr r4,[pool_02329F84]	; 02329F54
loc_02329F56:
	add r0,r5,#0x0	; 02329F56
	add r0,#0x3d	; 02329F58
	ldrb r2,[r0,#0x0]	; 02329F5A
	add r0,r1,#0x0	; 02329F5C
	add r0,#0x3d	; 02329F5E
	ldrb r0,[r0,#0x0]	; 02329F60
	cmp r2,r0	; 02329F62
	bcc loc_02329F72	; 02329F64
	add r0,r4,#0x0	; 02329F66
	bl loc_023294E4	; 02329F68
	add r1,r0,#0x0	; 02329F6C
	cmp r1,#0x0	; 02329F6E
	bne loc_02329F56	; 02329F70
loc_02329F72:
	ldr r0,[pool_02329F84]	; 02329F72
	add r2,r5,#0x0	; 02329F74
	bl loc_02329534	; 02329F76
	add sp,#0x4	; 02329F7A
	pop {r4,r5}	; 02329F7C
	pop {r3}	; 02329F7E
	bx r3	; 02329F80
	.byte 0xC0, 0x46	; 02329F84
pool_02329F84:
loc_02329F84:
	.word 0x023563F4	; 02329F84

; ===== function loc_02329F88 =====
loc_02329F88:
	push {r4,r5,lr}	; 02329F88
	sub sp,#0x4	; 02329F8A
	add r5,r0,#0x0	; 02329F8C
	add r4,r1,#0x0	; 02329F8E
	mov r1,#0x0	; 02329F90
	bl loc_023294E4	; 02329F92
	add r1,r0,#0x0	; 02329F96
	cmp r1,#0x0	; 02329F98
	beq loc_02329FB8	; 02329F9A
loc_02329F9C:
	add r0,r4,#0x0	; 02329F9C
	add r0,#0x3d	; 02329F9E
	ldrb r2,[r0,#0x0]	; 02329FA0
	add r0,r1,#0x0	; 02329FA2
	add r0,#0x3d	; 02329FA4
	ldrb r0,[r0,#0x0]	; 02329FA6
	cmp r2,r0	; 02329FA8
	bcc loc_02329FB8	; 02329FAA
	add r0,r5,#0x0	; 02329FAC
	bl loc_023294E4	; 02329FAE
	add r1,r0,#0x0	; 02329FB2
	cmp r1,#0x0	; 02329FB4
	bne loc_02329F9C	; 02329FB6
loc_02329FB8:
	add r0,r5,#0x0	; 02329FB8
	add r2,r4,#0x0	; 02329FBA
	bl loc_02329534	; 02329FBC
	str r5,[r4,#0x4]	; 02329FC0
	add sp,#0x4	; 02329FC2
	pop {r4,r5}	; 02329FC4
	pop {r3}	; 02329FC6
	bx r3	; 02329FC8
	.byte 0x00, 0x00	; 02329FCC

; ===== function loc_02329FCC =====
loc_02329FCC:
	push {r4,lr}	; 02329FCC
	add r4,r0,#0x0	; 02329FCE
	mov r1,#0x0	; 02329FD0
	add r0,#0x2e	; 02329FD2
	strb r1,[r0,#0x0]	; 02329FD4
	add r0,r4,#0x0	; 02329FD6
	add r0,#0x2d	; 02329FD8
	strb r1,[r0,#0x0]	; 02329FDA
	strh r1,[r4,#0x34]	; 02329FDC
	strh r1,[r4,#0x3e]	; 02329FDE
	mov r1,#0x7f	; 02329FE0
	add r0,r4,#0x0	; 02329FE2
	add r0,#0x40	; 02329FE4
	strb r1,[r0,#0x0]	; 02329FE6
	add r0,r4,#0x0	; 02329FE8
	add r0,#0x41	; 02329FEA
	strb r1,[r0,#0x0]	; 02329FEC
	add r0,r4,#0x0	; 02329FEE
	add r0,#0x1c	; 02329FF0
	bl loc_0232AF0C	; 02329FF2
	add r4,#0x1c	; 02329FF6
	add r0,r4,#0x0	; 02329FF8
	ldr r1,[pool_0232A008]	; 02329FFA
	mov r2,#0x1	; 02329FFC
	bl loc_0232AEF0	; 02329FFE
	pop {r4}	; 0232A002
	pop {r3}	; 0232A004
	bx r3	; 0232A006
pool_0232A008:
loc_0232A008:
	.word 0x00007F00	; 0232A008
loc_0232A00C:
	push {r4,lr}	; 0232A00C
	add r4,r0,#0x0	; 0232A00E
	add r2,r1,#0x0	; 0232A010
	cmp r4,#0x0	; 0232A012
	beq loc_0232A044	; 0232A014
	add r1,r4,#0x0	; 0232A016
	add r1,#0x2c	; 0232A018
	ldrb r1,[r1,#0x0]	; 0232A01A
	cmp r1,#0x0	; 0232A01C
	beq loc_0232A044	; 0232A01E
	cmp r2,#0x0	; 0232A020
	bne loc_0232A02E	; 0232A022
	bl loc_02329F28	; 0232A024
	pop {r4}	; 0232A028
	pop {r3}	; 0232A02A
	bx r3	; 0232A02C
loc_0232A02E:
	add r0,#0x1c	; 0232A02E
	mov r1,#0x0	; 0232A030
	bl loc_0232AEF0	; 0232A032
	add r0,r4,#0x0	; 0232A036
	mov r1,#0x0	; 0232A038
	bl loc_02329DF0	; 0232A03A
	mov r0,#0x2	; 0232A03E
	add r4,#0x2c	; 0232A040
	strb r0,[r4,#0x0]	; 0232A042
loc_0232A044:
	pop {r4}	; 0232A044
	pop {r3}	; 0232A046
	bx r3	; 0232A048
	.byte 0x00, 0x00	; 0232A04C

; ===== function loc_0232A04C =====
loc_0232A04C:
	push {r4,lr}	; 0232A04C
	add r4,r0,#0x0	; 0232A04E
	add r0,#0x3c	; 0232A050
	ldrb r0,[r0,#0x0]	; 0232A052
	bl loc_0232E11C	; 0232A054
	add r0,r4,#0x0	; 0232A058
	bl loc_02329FCC	; 0232A05A
	bl loc_0232E25C	; 0232A05E
	str r0,[r4,#0x30]	; 0232A062
	mov r0,#0x1	; 0232A064
	add r4,#0x2c	; 0232A066
	strb r0,[r4,#0x0]	; 0232A068
	pop {r4}	; 0232A06A
	pop {r3}	; 0232A06C
	bx r3	; 0232A06E

; ===== function loc_0232A070 =====
loc_0232A070:
	ldr r3,[pool_0232A074]	; 0232A070
	bx r3	; 0232A072
pool_0232A074:
loc_0232A074:
	.word loc_02329E70 + 1	; 0232A074

; ===== function loc_0232A078 =====
loc_0232A078:
	push {r4,r5,r6,lr}	; 0232A078
	add r5,r0,#0x0	; 0232A07A
	add r6,r2,#0x0	; 0232A07C
	ldr r3,[pool_0232A0EC]	; 0232A07E
	mov r2,#0x1c	; 0232A080
	mul r1,r2	; 0232A082
	add r4,r3,r1	; 0232A084
	ldr r1,[r5,#0x0]	; 0232A086
	cmp r1,#0x0	; 0232A088
	beq loc_0232A090	; 0232A08A
	bl loc_0232A194	; 0232A08C
loc_0232A090:
	ldrh r1,[r4,#0x8]	; 0232A090
	ldr r0,[r4,#0x18]	; 0232A092
	cmp r1,r0	; 0232A094
	bcc loc_0232A0C2	; 0232A096
	add r0,r4,#0x0	; 0232A098
	mov r1,#0x0	; 0232A09A
	bl loc_023294E4	; 0232A09C
	cmp r0,#0x0	; 0232A0A0
	bne loc_0232A0AC	; 0232A0A2
	mov r0,#0x0	; 0232A0A4
	pop {r4,r5,r6}	; 0232A0A6
	pop {r3}	; 0232A0A8
	bx r3	; 0232A0AA
loc_0232A0AC:
	add r1,r0,#0x0	; 0232A0AC
	add r1,#0x3d	; 0232A0AE
	ldrb r1,[r1,#0x0]	; 0232A0B0
	cmp r6,r1	; 0232A0B2
	bge loc_0232A0BE	; 0232A0B4
	mov r0,#0x0	; 0232A0B6
	pop {r4,r5,r6}	; 0232A0B8
	pop {r3}	; 0232A0BA
	bx r3	; 0232A0BC
loc_0232A0BE:
	bl loc_02329F28	; 0232A0BE
loc_0232A0C2:
	add r0,r6,#0x0	; 0232A0C2
	bl loc_02329ECC	; 0232A0C4
	add r6,r0,#0x0	; 0232A0C8
	cmp r6,#0x0	; 0232A0CA
	bne loc_0232A0D6	; 0232A0CC
	mov r0,#0x0	; 0232A0CE
	pop {r4,r5,r6}	; 0232A0D0
	pop {r3}	; 0232A0D2
	bx r3	; 0232A0D4
loc_0232A0D6:
	add r0,r4,#0x0	; 0232A0D6
	add r1,r6,#0x0	; 0232A0D8
	bl loc_02329F88	; 0232A0DA
	str r5,[r6,#0x0]	; 0232A0DE
	str r6,[r5,#0x0]	; 0232A0E0
	add r0,r6,#0x0	; 0232A0E2
	pop {r4,r5,r6}	; 0232A0E4
	pop {r3}	; 0232A0E6
	bx r3	; 0232A0E8
	.byte 0xC0, 0x46	; 0232A0EC
pool_0232A0EC:
loc_0232A0EC:
	.word 0x02356400	; 0232A0EC

; ===== function loc_0232A0F0 =====
loc_0232A0F0:
	push {r4}	; 0232A0F0
	sub sp,#0x4	; 0232A0F2
	ldr r4,[r0,#0x0]	; 0232A0F4
	cmp r4,#0x0	; 0232A0F6
	beq loc_0232A106	; 0232A0F8
	mov r3,#0x2	; 0232A0FA
	strh r3,[r4,#0x34]	; 0232A0FC
	ldr r3,[r0,#0x0]	; 0232A0FE
	strh r1,[r3,#0x38]	; 0232A100
	ldr r0,[r0,#0x0]	; 0232A102
	strh r2,[r0,#0x3a]	; 0232A104
loc_0232A106:
	add sp,#0x4	; 0232A106
	pop {r4}	; 0232A108
	bx lr	; 0232A10A

; ===== function loc_0232A10C =====
	push {lr}	; 0232A10C
	sub sp,#0x4	; 0232A10E
	ldr r0,[r0,#0x0]	; 0232A110
	cmp r0,#0x0	; 0232A112
	beq loc_0232A11E	; 0232A114
	add r0,#0x3c	; 0232A116
	ldrb r0,[r0,#0x0]	; 0232A118
	bl loc_0232E0AC	; 0232A11A
loc_0232A11E:
	add sp,#0x4	; 0232A11E
	pop {r3}	; 0232A120
	bx r3	; 0232A122

; ===== function loc_0232A124 =====
	push {lr}	; 0232A124
	sub sp,#0x4	; 0232A126
	ldr r0,[r0,#0x0]	; 0232A128
	cmp r0,#0x0	; 0232A12A
	beq loc_0232A136	; 0232A12C
	add r0,#0x3c	; 0232A12E
	ldrb r0,[r0,#0x0]	; 0232A130
	bl loc_0232E0C4	; 0232A132
loc_0232A136:
	add sp,#0x4	; 0232A136
	pop {r3}	; 0232A138
	bx r3	; 0232A13A

; ===== function loc_0232A13C =====
loc_0232A13C:
	push {lr}	; 0232A13C
	sub sp,#0x4	; 0232A13E
	ldr r0,[r0,#0x0]	; 0232A140
	cmp r0,#0x0	; 0232A142
	beq loc_0232A14E	; 0232A144
	add r0,#0x3c	; 0232A146
	ldrb r0,[r0,#0x0]	; 0232A148
	bl loc_0232E0DC	; 0232A14A
loc_0232A14E:
	add sp,#0x4	; 0232A14E
	pop {r3}	; 0232A150
	bx r3	; 0232A152

; ===== function loc_0232A154 =====
	push {lr}	; 0232A154
	sub sp,#0x4	; 0232A156
	ldr r0,[r0,#0x0]	; 0232A158
	cmp r0,#0x0	; 0232A15A
	beq loc_0232A170	; 0232A15C
	add r3,r0,#0x0	; 0232A15E
	add r3,#0x2c	; 0232A160
	ldrb r3,[r3,#0x0]	; 0232A162
	cmp r3,#0x2	; 0232A164
	beq loc_0232A170	; 0232A166
	add r0,#0x1c	; 0232A168
	lsl r1,r1,#0x8	; 0232A16A
	bl loc_0232AEF0	; 0232A16C
loc_0232A170:
	add sp,#0x4	; 0232A170
	pop {r3}	; 0232A172
	bx r3	; 0232A174
	.byte 0x00, 0x00	; 0232A178

; ===== function loc_0232A178 =====
loc_0232A178:
	ldr r0,[r0,#0x0]	; 0232A178
	cmp r0,#0x0	; 0232A17A
	beq loc_0232A182	; 0232A17C
	add r0,#0x40	; 0232A17E
	strb r1,[r0,#0x0]	; 0232A180
loc_0232A182:
	bx lr	; 0232A182

; ===== function loc_0232A184 =====
loc_0232A184:
	mov r1,#0x1c	; 0232A184
	mul r0,r1	; 0232A186
	ldr r1,[pool_0232A190]	; 0232A188
	ldrh r0,[r1,r0]	; 0232A18A
	bx lr	; 0232A18C
	.byte 0xC0, 0x46	; 0232A190
pool_0232A190:
loc_0232A190:
	.word P1_BssStart + 0x25A48	; 0232A190

; ===== function loc_0232A194 =====
loc_0232A194:
	ldr r2,[r0,#0x0]	; 0232A194
	cmp r2,#0x0	; 0232A196
	beq loc_0232A1A0	; 0232A198
	mov r1,#0x0	; 0232A19A
	str r1,[r2,#0x0]	; 0232A19C
	str r1,[r0,#0x0]	; 0232A19E
loc_0232A1A0:
	bx lr	; 0232A1A0
	.byte 0x00, 0x00	; 0232A1A4

; ===== function loc_0232A1A4 =====
loc_0232A1A4:
	mov r1,#0x0	; 0232A1A4
	str r1,[r0,#0x0]	; 0232A1A6
	bx lr	; 0232A1A8
	.byte 0x00, 0x00	; 0232A1AC
loc_0232A1AC:
	ldr r0,[r0,#0x0]	; 0232A1AC
	ldr r3,[pool_0232A1B4]	; 0232A1AE
	bx r3	; 0232A1B0
	.byte 0xC0, 0x46	; 0232A1B4
pool_0232A1B4:
loc_0232A1B4:
	.word loc_0232A00C + 1	; 0232A1B4

; ===== function loc_0232A1B8 =====
loc_0232A1B8:
	push {r4,r5,r6,lr}	; 0232A1B8
	sub sp,#0x8	; 0232A1BA
	add r5,r0,#0x0	; 0232A1BC
	add r6,r2,#0x0	; 0232A1BE
	mov r3,#0x0	; 0232A1C0
	str r3,[sp,#0x0]	; 0232A1C2
	add r0,r1,#0x0	; 0232A1C4
	add r1,r6,#0x0	; 0232A1C6
	add r1,#0x14	; 0232A1C8
	ldr r2,[pool_0232A21C]	; 0232A1CA
	bl loc_0232AB0C	; 0232A1CC
	add r4,r0,#0x0	; 0232A1D0
	cmp r4,#0x0	; 0232A1D2
	bne loc_0232A1E0	; 0232A1D4
	mov r0,#0x0	; 0232A1D6
	add sp,#0x8	; 0232A1D8
	pop {r4,r5,r6}	; 0232A1DA
	pop {r3}	; 0232A1DC
	bx r3	; 0232A1DE
loc_0232A1E0:
	mov r0,#0x0	; 0232A1E0
	str r0,[r4,#0xc]	; 0232A1E2
	str r5,[r4,#0x10]	; 0232A1E4
	str r0,[r4,#0x8]	; 0232A1E6
	add r0,r4,#0x0	; 0232A1E8
	add r0,#0x14	; 0232A1EA
	add r1,r6,#0x0	; 0232A1EC
	bl loc_0232ABE8	; 0232A1EE
	cmp r0,#0x0	; 0232A1F2
	bne loc_0232A200	; 0232A1F4
	mov r0,#0x0	; 0232A1F6
	add sp,#0x8	; 0232A1F8
	pop {r4,r5,r6}	; 0232A1FA
	pop {r3}	; 0232A1FC
	bx r3	; 0232A1FE
loc_0232A200:
	str r0,[r4,#0x8]	; 0232A200
	ldr r1,[pool_0232A220]	; 0232A202
	mov r0,#0x1c	; 0232A204
	mul r5,r0	; 0232A206
	add r0,r1,r5	; 0232A208
	add r0,#0xc	; 0232A20A
	add r1,r4,#0x0	; 0232A20C
	bl loc_023295B4	; 0232A20E
	mov r0,#0x1	; 0232A212
	add sp,#0x8	; 0232A214
	pop {r4,r5,r6}	; 0232A216
	pop {r3}	; 0232A218
	bx r3	; 0232A21A
pool_0232A21C:
loc_0232A21C:
	.word 0x02329E35	; 0232A21C
pool_0232A220:
loc_0232A220:
	.word 0x02356400	; 0232A220

; ===== function loc_0232A224 =====
loc_0232A224:
	lsl r1,r1,#0x10	; 0232A224
	lsr r2,r1,#0x10	; 0232A226
	mov r1,#0x1c	; 0232A228
	mul r0,r1	; 0232A22A
	ldr r1,[pool_0232A234]	; 0232A22C
	str r2,[r1,r0]	; 0232A22E
	bx lr	; 0232A230
	.byte 0xC0, 0x46	; 0232A234
pool_0232A234:
loc_0232A234:
	.word P1_BssStart + 0x25A58	; 0232A234

; ===== function loc_0232A238 =====
loc_0232A238:
	push {r4,r5,r6,r7,lr}	; 0232A238
	sub sp,#0xc	; 0232A23A
	bl loc_0232E688	; 0232A23C
	str r0,[sp,#0x4]	; 0232A240
	ldr r0,[pool_0232A31C]	; 0232A242
	mov r1,#0x0	; 0232A244
	bl loc_023294E4	; 0232A246
	add r5,r0,#0x0	; 0232A24A
	cmp r5,#0x0	; 0232A24C
	beq loc_0232A314	; 0232A24E
	ldr r7,[pool_0232A320]	; 0232A250
loc_0232A252:
	ldr r0,[pool_0232A31C]	; 0232A252
	add r1,r5,#0x0	; 0232A254
	bl loc_023294E4	; 0232A256
	str r0,[sp,#0x0]	; 0232A25A
	add r0,r5,#0x0	; 0232A25C
	add r0,#0x2d	; 0232A25E
	ldrb r0,[r0,#0x0]	; 0232A260
	cmp r0,#0x0	; 0232A262
	bne loc_0232A278	; 0232A264
	ldr r0,[r5,#0x30]	; 0232A266
	bl loc_0232E22C	; 0232A268
	cmp r0,#0x0	; 0232A26C
	beq loc_0232A278	; 0232A26E
	add r1,r5,#0x0	; 0232A270
	add r1,#0x2d	; 0232A272
	mov r0,#0x1	; 0232A274
	strb r0,[r1,#0x0]	; 0232A276
loc_0232A278:
	add r0,r5,#0x0	; 0232A278
	add r0,#0x2d	; 0232A27A
	ldrb r0,[r0,#0x0]	; 0232A27C
	cmp r0,#0x0	; 0232A27E
	beq loc_0232A29C	; 0232A280
	add r0,r5,#0x0	; 0232A282
	add r0,#0x3c	; 0232A284
	ldrb r0,[r0,#0x0]	; 0232A286
	mov r1,#0x1	; 0232A288
	lsl r1,r0	; 0232A28A
	ldr r0,[sp,#0x4]	; 0232A28C
	and r0,r1	; 0232A28E
	cmp r0,#0x0	; 0232A290
	bne loc_0232A29C	; 0232A292
	add r0,r5,#0x0	; 0232A294
	bl loc_02329E70	; 0232A296
	b loc_0232A30C	; 0232A29A
loc_0232A29C:
	add r0,r5,#0x0	; 0232A29C
	add r0,#0x1c	; 0232A29E
	bl loc_0232AEB8	; 0232A2A0
	add r0,r5,#0x0	; 0232A2A4
	add r0,#0x41	; 0232A2A6
	ldrb r0,[r0,#0x0]	; 0232A2A8
	lsl r0,r0,#0x1	; 0232A2AA
	ldrsh r4,[r7,r0]	; 0232A2AC
	add r0,r5,#0x0	; 0232A2AE
	add r0,#0x40	; 0232A2B0
	ldrb r0,[r0,#0x0]	; 0232A2B2
	lsl r0,r0,#0x1	; 0232A2B4
	ldrsh r6,[r7,r0]	; 0232A2B6
	add r0,r5,#0x0	; 0232A2B8
	add r0,#0x1c	; 0232A2BA
	bl loc_0232AEC8	; 0232A2BC
	asr r0,r0,#0x8	; 0232A2C0
	lsl r0,r0,#0x1	; 0232A2C2
	ldrsh r1,[r7,r0]	; 0232A2C4
	add r0,r6,r4	; 0232A2C6
	add r4,r1,r0	; 0232A2C8
	ldr r0,[pool_0232A324]	; 0232A2CA
	cmp r4,r0	; 0232A2CC
	bge loc_0232A2D4	; 0232A2CE
	lsl r4,r0,#0	; 0232A2D0
	b loc_0232A2DA	; 0232A2D2
loc_0232A2D4:
	cmp r4,#0x0	; 0232A2D4
	ble loc_0232A2DA	; 0232A2D6
	mov r4,#0x0	; 0232A2D8
loc_0232A2DA:
	mov r0,#0x3e	; 0232A2DA
	ldrsh r0,[r5,r0]	; 0232A2DC
	cmp r4,r0	; 0232A2DE
	beq loc_0232A2F0	; 0232A2E0
	add r0,r5,#0x0	; 0232A2E2
	add r0,#0x3c	; 0232A2E4
	ldrb r0,[r0,#0x0]	; 0232A2E6
	add r1,r4,#0x0	; 0232A2E8
	bl loc_0232E0F0	; 0232A2EA
	strh r4,[r5,#0x3e]	; 0232A2EE
loc_0232A2F0:
	add r0,r5,#0x0	; 0232A2F0
	add r0,#0x2c	; 0232A2F2
	ldrb r0,[r0,#0x0]	; 0232A2F4
	cmp r0,#0x2	; 0232A2F6
	bne loc_0232A30C	; 0232A2F8
	add r0,r5,#0x0	; 0232A2FA
	add r0,#0x1c	; 0232A2FC
	bl loc_0232AEA8	; 0232A2FE
	cmp r0,#0x0	; 0232A302
	beq loc_0232A30C	; 0232A304
	add r0,r5,#0x0	; 0232A306
	bl loc_02329F28	; 0232A308
loc_0232A30C:
	ldr r5,[sp,#0x0]	; 0232A30C
	lsl r0,r5,#0	; 0232A30E
	cmp r0,#0x0	; 0232A310
	bne loc_0232A252	; 0232A312
loc_0232A314:
	add sp,#0xc	; 0232A314
	pop {r4,r5,r6,r7}	; 0232A316
	pop {r3}	; 0232A318
	bx r3	; 0232A31A
pool_0232A31C:
loc_0232A31C:
	.word 0x023563F4	; 0232A31C
pool_0232A320:
loc_0232A320:
	.word 0x023303C4	; 0232A320
pool_0232A324:
loc_0232A324:
	.word 0xFFFFFD2D	; 0232A324

; ===== function loc_0232A328 =====
loc_0232A328:
	push {r4,r5,r6,r7,lr}	; 0232A328
	sub sp,#0x4	; 0232A32A
	ldr r0,[pool_0232A38C]	; 0232A32C
	mov r1,#0x14	; 0232A32E
	bl loc_02329608	; 0232A330
	ldr r0,[pool_0232A390]	; 0232A334
	mov r1,#0x14	; 0232A336
	bl loc_02329608	; 0232A338
	mov r5,#0x0	; 0232A33C
	ldr r4,[pool_0232A394]	; 0232A33E
	add r6,r5,#0x0	; 0232A340
	ldr r7,[pool_0232A390]	; 0232A342
loc_0232A344:
	add r0,r4,#0x0	; 0232A344
	add r0,#0x2c	; 0232A346
	strb r6,[r0,#0x0]	; 0232A348
	add r0,r4,#0x0	; 0232A34A
	add r0,#0x3c	; 0232A34C
	strb r5,[r0,#0x0]	; 0232A34E
	add r0,r7,#0x0	; 0232A350
	add r1,r4,#0x0	; 0232A352
	bl loc_023295B4	; 0232A354
	add r4,#0x44	; 0232A358
	add r5,r5,#0x1	; 0232A35A
	cmp r5,#0x10	; 0232A35C
	blt loc_0232A344	; 0232A35E
	mov r4,#0x0	; 0232A360
	ldr r5,[pool_0232A398]	; 0232A362
	add r6,r4,#0x0	; 0232A364
	mov r7,#0x1	; 0232A366
loc_0232A368:
	add r0,r5,#0x0	; 0232A368
	mov r1,#0xc	; 0232A36A
	bl loc_02329608	; 0232A36C
	add r0,r5,#0x0	; 0232A370
	add r0,#0xc	; 0232A372
	add r1,r6,#0x0	; 0232A374
	bl loc_02329608	; 0232A376
	str r7,[r5,#0x18]	; 0232A37A
	add r5,#0x1c	; 0232A37C
	add r4,r4,#0x1	; 0232A37E
	cmp r4,#0x20	; 0232A380
	blt loc_0232A368	; 0232A382
	add sp,#0x4	; 0232A384
	pop {r4,r5,r6,r7}	; 0232A386
	pop {r3}	; 0232A388
	bx r3	; 0232A38A
pool_0232A38C:
loc_0232A38C:
	.word 0x023563F4	; 0232A38C
pool_0232A390:
loc_0232A390:
	.word 0x023563E8	; 0232A390
pool_0232A394:
loc_0232A394:
	.word P1_BssStart + 0x25DC0	; 0232A394
pool_0232A398:
loc_0232A398:
	.word 0x02356400	; 0232A398

; ===== function loc_0232A39C =====
	push {r4,r5,r6,r7,lr}	; 0232A39C
	sub sp,#0xc	; 0232A39E
	add r5,r0,#0x0	; 0232A3A0
	ldr r0,[r5,#0x14]	; 0232A3A2
	ldr r1,[r5,#0x2c]	; 0232A3A4
	blx P1_SignedDivMod	; 0232A3A6
	str r0,[sp,#0x4]	; 0232A3AA
	ldr r0,[r5,#0x18]	; 0232A3AC
	ldr r4,[sp,#0x4]	; 0232A3AE
	mul r4,r0	; 0232A3B0
	ldr r0,[r5,#0xc]	; 0232A3B2
	add r6,r0,r4	; 0232A3B4
	ldr r0,[r5,#0x10]	; 0232A3B6
	add r7,r0,r4	; 0232A3B8
	add r0,r6,#0x0	; 0232A3BA
	ldr r1,[sp,#0x4]	; 0232A3BC
	blx P1_InvalidateDataCacheRange	; 0232A3BE
	add r0,r7,#0x0	; 0232A3C2
	ldr r1,[sp,#0x4]	; 0232A3C4
	blx P1_InvalidateDataCacheRange	; 0232A3C6
	ldr r0,[pool_0232A430]	; 0232A3CA
	ldr r0,[r0,#0x0]	; 0232A3CC
	cmp r0,#0x0	; 0232A3CE
	beq loc_0232A404	; 0232A3D0
	ldr r2,[pool_0232A434]	; 0232A3D2
	ldr r0,[pool_0232A438]	; 0232A3D4
	ldr r0,[r0,#0x0]	; 0232A3D6
	mov r1,#0x14	; 0232A3D8
	mul r0,r1	; 0232A3DA
	add r1,r2,r0	; 0232A3DC
	str r5,[r2,r0]	; 0232A3DE
	ldr r0,[sp,#0x4]	; 0232A3E0
	str r0,[r1,#0x4]	; 0232A3E2
	str r4,[r1,#0x8]	; 0232A3E4
	str r6,[r1,#0xc]	; 0232A3E6
	str r7,[r1,#0x10]	; 0232A3E8
	ldr r0,[pool_0232A43C]	; 0232A3EA
	mov r2,#0x0	; 0232A3EC
	bl loc_0232BA00	; 0232A3EE
	ldr r0,[pool_0232A438]	; 0232A3F2
	ldr r1,[r0,#0x0]	; 0232A3F4
	add r1,r1,#0x1	; 0232A3F6
	str r1,[r0,#0x0]	; 0232A3F8
	cmp r1,#0x8	; 0232A3FA
	blt loc_0232A414	; 0232A3FC
	mov r1,#0x0	; 0232A3FE
	str r1,[r0,#0x0]	; 0232A400
	b loc_0232A414	; 0232A402
loc_0232A404:
	ldr r0,[r5,#0x34]	; 0232A404
	str r0,[sp,#0x0]	; 0232A406
	add r0,r6,#0x0	; 0232A408
	add r1,r7,#0x0	; 0232A40A
	ldr r2,[sp,#0x4]	; 0232A40C
	ldr r3,[r5,#0x8]	; 0232A40E
	ldr r4,[r5,#0x30]	; 0232A410
	blx r4	; 0232A412
loc_0232A414:
	ldr r0,[r5,#0x18]	; 0232A414
	add r0,r0,#0x1	; 0232A416
	str r0,[r5,#0x18]	; 0232A418
	ldr r1,[r5,#0x18]	; 0232A41A
	ldr r0,[r5,#0x2c]	; 0232A41C
	cmp r1,r0	; 0232A41E
	blt loc_0232A426	; 0232A420
	mov r0,#0x0	; 0232A422
	str r0,[r5,#0x18]	; 0232A424
loc_0232A426:
	add sp,#0xc	; 0232A426
	pop {r4,r5,r6,r7}	; 0232A428
	pop {r3}	; 0232A42A
	bx r3	; 0232A42C
	.byte 0xC0, 0x46	; 0232A430
pool_0232A430:
loc_0232A430:
	.word P1_BssStart + 0x26204	; 0232A430
pool_0232A434:
loc_0232A434:
	.word P1_BssStart + 0x2626C	; 0232A434
pool_0232A438:
loc_0232A438:
	.word P1_BssStart + 0x26200	; 0232A438
pool_0232A43C:
loc_0232A43C:
	.word 0x02356BC8	; 0232A43C

; ===== function loc_0232A440 =====
loc_0232A440:
	push {r4,lr}	; 0232A440
	sub sp,#0x8	; 0232A442
	ldr r4,[pool_0232A49C]	; 0232A444
	ldr r0,[r4,#0x0]	; 0232A446
	cmp r0,#0x0	; 0232A448
	beq loc_0232A492	; 0232A44A
	mov r0,#0x0	; 0232A44C
	str r0,[r4,#0x18]	; 0232A44E
	str r0,[sp,#0x0]	; 0232A450
	ldr r0,[sp,#0x0]	; 0232A452
	ldr r1,[r4,#0xc]	; 0232A454
	ldr r2,[r4,#0x14]	; 0232A456
	blx loc_0232DD90	; 0232A458
	mov r0,#0x0	; 0232A45C
	str r0,[sp,#0x4]	; 0232A45E
	ldr r0,[sp,#0x4]	; 0232A460
	ldr r1,[r4,#0x10]	; 0232A462
	ldr r2,[r4,#0x14]	; 0232A464
	blx loc_0232DD90	; 0232A466
	ldr r0,[r4,#0xc]	; 0232A46A
	ldr r1,[r4,#0x14]	; 0232A46C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A46E
	ldr r0,[r4,#0x10]	; 0232A472
	ldr r1,[r4,#0x14]	; 0232A474
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A476
	ldr r0,[r4,#0x28]	; 0232A47A
	cmp r0,#0x0	; 0232A47C
	blt loc_0232A486	; 0232A47E
	mov r2,#0x1	; 0232A480
	lsl r2,r0	; 0232A482
	b loc_0232A488	; 0232A484
loc_0232A486:
	mov r2,#0x0	; 0232A486
loc_0232A488:
	ldr r0,[r4,#0x20]	; 0232A488
	ldr r1,[r4,#0x24]	; 0232A48A
	mov r3,#0x0	; 0232A48C
	bl loc_0232E08C	; 0232A48E
loc_0232A492:
	add sp,#0x8	; 0232A492
	pop {r4}	; 0232A494
	pop {r3}	; 0232A496
	bx r3	; 0232A498
	.byte 0xC0, 0x46	; 0232A49C
pool_0232A49C:
loc_0232A49C:
	.word P1_BssStart + 0x2621C	; 0232A49C

; ===== function loc_0232A4A0 =====
loc_0232A4A0:
	push {r4,lr}	; 0232A4A0
	ldr r1,[pool_0232A4DC]	; 0232A4A2
	ldr r0,[r1,#0x0]	; 0232A4A4
	cmp r0,#0x0	; 0232A4A6
	beq loc_0232A4D4	; 0232A4A8
	ldr r0,[r1,#0x28]	; 0232A4AA
	cmp r0,#0x0	; 0232A4AC
	blt loc_0232A4B6	; 0232A4AE
	mov r2,#0x1	; 0232A4B0
	lsl r2,r0	; 0232A4B2
	b loc_0232A4B8	; 0232A4B4
loc_0232A4B6:
	mov r2,#0x0	; 0232A4B6
loc_0232A4B8:
	ldr r0,[r1,#0x20]	; 0232A4B8
	ldr r1,[r1,#0x24]	; 0232A4BA
	mov r3,#0x0	; 0232A4BC
	bl loc_0232E044	; 0232A4BE
	bl loc_0232E25C	; 0232A4C2
	add r4,r0,#0x0	; 0232A4C6
	mov r0,#0x1	; 0232A4C8
	bl loc_0232E2C8	; 0232A4CA
	add r0,r4,#0x0	; 0232A4CE
	bl loc_0232E27C	; 0232A4D0
loc_0232A4D4:
	pop {r4}	; 0232A4D4
	pop {r3}	; 0232A4D6
	bx r3	; 0232A4D8
	.byte 0xC0, 0x46	; 0232A4DC
pool_0232A4DC:
loc_0232A4DC:
	.word P1_BssStart + 0x2621C	; 0232A4DC

; ===== function loc_0232A4E0 =====
loc_0232A4E0:
	push {r4,r5,r6,r7,lr}	; 0232A4E0
	sub sp,#0x4	; 0232A4E2
	ldr r4,[pool_0232A570]	; 0232A4E4
	ldr r0,[r4,#0x28]	; 0232A4E6
	cmp r0,#0x0	; 0232A4E8
	blt loc_0232A4F0	; 0232A4EA
	mov r5,#0x1	; 0232A4EC
	b loc_0232A4F2	; 0232A4EE
loc_0232A4F0:
	mov r5,#0x0	; 0232A4F0
loc_0232A4F2:
	cmp r5,#0x0	; 0232A4F2
	beq loc_0232A4FE	; 0232A4F4
	mov r2,#0x1	; 0232A4F6
	ldr r0,[r4,#0x28]	; 0232A4F8
	lsl r2,r0	; 0232A4FA
	b loc_0232A500	; 0232A4FC
loc_0232A4FE:
	mov r2,#0x0	; 0232A4FE
loc_0232A500:
	ldr r0,[r4,#0x20]	; 0232A500
	ldr r1,[r4,#0x24]	; 0232A502
	mov r3,#0x0	; 0232A504
	bl loc_0232E044	; 0232A506
	cmp r5,#0x0	; 0232A50A
	beq loc_0232A532	; 0232A50C
	bl loc_0232E25C	; 0232A50E
	add r6,r0,#0x0	; 0232A512
	mov r0,#0x1	; 0232A514
	bl loc_0232E2C8	; 0232A516
	add r0,r6,#0x0	; 0232A51A
	bl loc_0232E27C	; 0232A51C
	ldr r6,[pool_0232A574]	; 0232A520
	mov r7,#0x0	; 0232A522
loc_0232A524:
	add r0,r6,#0x0	; 0232A524
	add r1,r7,#0x0	; 0232A526
	add r2,r7,#0x0	; 0232A528
	bl loc_0232B98C	; 0232A52A
	cmp r0,#0x0	; 0232A52E
	bne loc_0232A524	; 0232A530
loc_0232A532:
	ldr r0,[r4,#0x24]	; 0232A532
	cmp r0,#0x0	; 0232A534
	beq loc_0232A53C	; 0232A536
	bl loc_02329D48	; 0232A538
loc_0232A53C:
	ldr r0,[r4,#0x1c]	; 0232A53C
	cmp r0,#0x0	; 0232A53E
	beq loc_0232A546	; 0232A540
	bl loc_02329D74	; 0232A542
loc_0232A546:
	cmp r5,#0x0	; 0232A546
	beq loc_0232A550	; 0232A548
	ldr r0,[r4,#0x28]	; 0232A54A
	bl loc_02329D08	; 0232A54C
loc_0232A550:
	ldr r0,[r4,#0x4]	; 0232A550
	cmp r0,#0x1	; 0232A552
	bne loc_0232A562	; 0232A554
	mov r0,#0x0	; 0232A556
	add r1,r0,#0x0	; 0232A558
	add r2,r0,#0x0	; 0232A55A
	add r3,r0,#0x0	; 0232A55C
	bl loc_0232DF2C	; 0232A55E
loc_0232A562:
	mov r0,#0x0	; 0232A562
	str r0,[r4,#0x0]	; 0232A564
	add sp,#0x4	; 0232A566
	pop {r4,r5,r6,r7}	; 0232A568
	pop {r3}	; 0232A56A
	bx r3	; 0232A56C
	.byte 0xC0, 0x46	; 0232A570
pool_0232A570:
loc_0232A570:
	.word P1_BssStart + 0x2621C	; 0232A570
pool_0232A574:
loc_0232A574:
	.word 0x02356BC8	; 0232A574

; ===== function loc_0232A578 =====
loc_0232A578:
	push {r4,r5,r6,r7,lr}	; 0232A578
	sub sp,#0x44	; 0232A57A
	str r0,[sp,#0x18]	; 0232A57C
	str r1,[sp,#0x1c]	; 0232A57E
	str r2,[sp,#0x20]	; 0232A580
	str r3,[sp,#0x24]	; 0232A582
	ldr r7,[sp,#0x64]	; 0232A584
	ldr r0,[sp,#0x6c]	; 0232A586
	str r0,[sp,#0x6c]	; 0232A588
	mov r0,#0x0	; 0232A58A
	str r0,[sp,#0x30]	; 0232A58C
	mvn r5,r0	; 0232A58E
	ldr r4,[pool_0232A794]	; 0232A590
	lsl r0,r1,#0	; 0232A592
	lsl r1,r3,#0	; 0232A594
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A596
	ldr r0,[sp,#0x20]	; 0232A59A
	ldr r1,[sp,#0x24]	; 0232A59C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A59E
	ldr r0,[sp,#0x58]	; 0232A5A2
	cmp r0,#0x1	; 0232A5A4
	bne loc_0232A5AC	; 0232A5A6
	mov r6,#0x1	; 0232A5A8
	b loc_0232A5AE	; 0232A5AA
loc_0232A5AC:
	mov r6,#0x0	; 0232A5AC
loc_0232A5AE:
	ldr r0,[pool_0232A798]	; 0232A5AE
	ldr r1,[sp,#0x68]	; 0232A5B0
	blx P1_SignedDivMod	; 0232A5B2
	str r0,[sp,#0x34]	; 0232A5B6
	ldr r0,[sp,#0x7c]	; 0232A5B8
	cmp r0,#0x0	; 0232A5BA
	beq loc_0232A5F8	; 0232A5BC
	ldr r0,[sp,#0x24]	; 0232A5BE
	cmp r6,#0x0	; 0232A5C0
	bne loc_0232A5C6	; 0232A5C2
	asr r0,r0,#0x1	; 0232A5C4
loc_0232A5C6:
	ldr r1,[sp,#0x34]	; 0232A5C6
	add r1,#0x10	; 0232A5C8
	str r1,[sp,#0x34]	; 0232A5CA
	mov r2,#0x1f	; 0232A5CC
	bic r1,r2	; 0232A5CE
	str r1,[sp,#0x34]	; 0232A5D0
	asr r1,r1,#0x5	; 0232A5D2
	str r1,[sp,#0x40]	; 0232A5D4
	ldr r1,[sp,#0x78]	; 0232A5D6
	blx P1_SignedDivMod	; 0232A5D8
	ldr r1,[sp,#0x40]	; 0232A5DC
	str r1,[sp,#0x38]	; 0232A5DE
	mul r1,r0	; 0232A5E0
	str r1,[sp,#0x38]	; 0232A5E2
	mov r0,#0x20	; 0232A5E4
	str r0,[sp,#0x3c]	; 0232A5E6
	cmp r6,#0x0	; 0232A5E8
	bne loc_0232A5F0	; 0232A5EA
	asr r0,r0,#0x1	; 0232A5EC
	str r0,[sp,#0x3c]	; 0232A5EE
loc_0232A5F0:
	ldr r1,[sp,#0x3c]	; 0232A5F0
	ldr r0,[sp,#0x40]	; 0232A5F2
	mul r1,r0	; 0232A5F4
	str r1,[sp,#0x3c]	; 0232A5F6
loc_0232A5F8:
	cmp r6,#0x0	; 0232A5F8
	beq loc_0232A602	; 0232A5FA
	mov r0,#0x0	; 0232A5FC
	str r0,[sp,#0x2c]	; 0232A5FE
	b loc_0232A606	; 0232A600
loc_0232A602:
	mov r0,#0x1	; 0232A602
	str r0,[sp,#0x2c]	; 0232A604
loc_0232A606:
	cmp r6,#0x0	; 0232A606
	beq loc_0232A610	; 0232A608
	mov r0,#0x1	; 0232A60A
	str r0,[sp,#0x28]	; 0232A60C
	b loc_0232A614	; 0232A60E
loc_0232A610:
	mov r0,#0x0	; 0232A610
	str r0,[sp,#0x28]	; 0232A612
loc_0232A614:
	ldr r0,[sp,#0x18]	; 0232A614
	cmp r0,#0x2	; 0232A616
	beq loc_0232A61E	; 0232A618
	mov r0,#0xa	; 0232A61A
	str r0,[sp,#0x30]	; 0232A61C
loc_0232A61E:
	ldr r0,[sp,#0x7c]	; 0232A61E
	cmp r0,#0x0	; 0232A620
	beq loc_0232A638	; 0232A622
	bl loc_02329D1C	; 0232A624
	add r5,r0,#0x0	; 0232A628
	cmp r5,#0x0	; 0232A62A
	bge loc_0232A638	; 0232A62C
	mov r0,#0x0	; 0232A62E
	add sp,#0x44	; 0232A630
	pop {r4,r5,r6,r7}	; 0232A632
	pop {r3}	; 0232A634
	bx r3	; 0232A636
loc_0232A638:
	mov r0,#0x3	; 0232A638
	bl loc_02329D58	; 0232A63A
	cmp r0,#0x0	; 0232A63E
	bne loc_0232A656	; 0232A640
	cmp r5,#0x0	; 0232A642
	blt loc_0232A64C	; 0232A644
	add r0,r5,#0x0	; 0232A646
	bl loc_02329D08	; 0232A648
loc_0232A64C:
	mov r0,#0x0	; 0232A64C
	add sp,#0x44	; 0232A64E
	pop {r4,r5,r6,r7}	; 0232A650
	pop {r3}	; 0232A652
	bx r3	; 0232A654
loc_0232A656:
	mov r0,#0xa	; 0232A656
	bl loc_02329D94	; 0232A658
	cmp r0,#0x0	; 0232A65C
	bne loc_0232A67A	; 0232A65E
	cmp r5,#0x0	; 0232A660
	blt loc_0232A66A	; 0232A662
	add r0,r5,#0x0	; 0232A664
	bl loc_02329D08	; 0232A666
loc_0232A66A:
	mov r0,#0x3	; 0232A66A
	bl loc_02329D48	; 0232A66C
	mov r0,#0x0	; 0232A670
	add sp,#0x44	; 0232A672
	pop {r4,r5,r6,r7}	; 0232A674
	pop {r3}	; 0232A676
	bx r3	; 0232A678
loc_0232A67A:
	cmp r7,#0x0	; 0232A67A
	beq loc_0232A682	; 0232A67C
	mov r3,#0x1	; 0232A67E
	b loc_0232A684	; 0232A680
loc_0232A682:
	mov r3,#0x2	; 0232A682
loc_0232A684:
	ldr r0,[sp,#0x24]	; 0232A684
	lsr r6,r0,#0x2	; 0232A686
	mov r1,#0x0	; 0232A688
	str r1,[sp,#0x0]	; 0232A68A
	str r6,[sp,#0x4]	; 0232A68C
	ldr r0,[sp,#0x6c]	; 0232A68E
	str r0,[sp,#0x8]	; 0232A690
	str r1,[sp,#0xc]	; 0232A692
	ldr r0,[sp,#0x34]	; 0232A694
	str r0,[sp,#0x10]	; 0232A696
	ldr r0,[sp,#0x70]	; 0232A698
	str r0,[sp,#0x14]	; 0232A69A
	mov r0,#0x1	; 0232A69C
	ldr r1,[sp,#0x2c]	; 0232A69E
	ldr r2,[sp,#0x1c]	; 0232A6A0
	bl loc_0232DF4C	; 0232A6A2
	str r7,[sp,#0x0]	; 0232A6A6
	ldr r0,[sp,#0x5c]	; 0232A6A8
	str r0,[sp,#0x4]	; 0232A6AA
	ldr r0,[sp,#0x60]	; 0232A6AC
	str r0,[sp,#0x8]	; 0232A6AE
	mov r0,#0x0	; 0232A6B0
	ldr r1,[sp,#0x28]	; 0232A6B2
	ldr r2,[sp,#0x1c]	; 0232A6B4
	add r3,r6,#0x0	; 0232A6B6
	bl loc_0232E008	; 0232A6B8
	cmp r7,#0x0	; 0232A6BC
	beq loc_0232A6C4	; 0232A6BE
	mov r3,#0x1	; 0232A6C0
	b loc_0232A6C6	; 0232A6C2
loc_0232A6C4:
	mov r3,#0x2	; 0232A6C4
loc_0232A6C6:
	mov r1,#0x0	; 0232A6C6
	str r1,[sp,#0x0]	; 0232A6C8
	str r6,[sp,#0x4]	; 0232A6CA
	ldr r0,[sp,#0x6c]	; 0232A6CC
	str r0,[sp,#0x8]	; 0232A6CE
	str r1,[sp,#0xc]	; 0232A6D0
	ldr r0,[sp,#0x34]	; 0232A6D2
	str r0,[sp,#0x10]	; 0232A6D4
	ldr r0,[sp,#0x74]	; 0232A6D6
	str r0,[sp,#0x14]	; 0232A6D8
	mov r0,#0x3	; 0232A6DA
	ldr r1,[sp,#0x2c]	; 0232A6DC
	ldr r2,[sp,#0x20]	; 0232A6DE
	bl loc_0232DF4C	; 0232A6E0
	str r7,[sp,#0x0]	; 0232A6E4
	ldr r0,[sp,#0x5c]	; 0232A6E6
	str r0,[sp,#0x4]	; 0232A6E8
	ldr r0,[sp,#0x60]	; 0232A6EA
	str r0,[sp,#0x8]	; 0232A6EC
	mov r0,#0x1	; 0232A6EE
	ldr r1,[sp,#0x28]	; 0232A6F0
	ldr r2,[sp,#0x20]	; 0232A6F2
	add r3,r6,#0x0	; 0232A6F4
	bl loc_0232E008	; 0232A6F6
	cmp r5,#0x0	; 0232A6FA
	blt loc_0232A70E	; 0232A6FC
	str r4,[sp,#0x0]	; 0232A6FE
	add r0,r5,#0x0	; 0232A700
	ldr r2,[sp,#0x38]	; 0232A702
	ldr r1,[sp,#0x3c]	; 0232A704
	add r1,r2,r1	; 0232A706
	ldr r3,[pool_0232A79C]	; 0232A708
	bl loc_0232DFE0	; 0232A70A
loc_0232A70E:
	ldr r0,[sp,#0x18]	; 0232A70E
	cmp r0,#0x1	; 0232A710
	bne loc_0232A720	; 0232A712
	mov r0,#0x3	; 0232A714
	add r1,r0,#0x0	; 0232A716
	mov r2,#0x1	; 0232A718
	add r3,r2,#0x0	; 0232A71A
	bl loc_0232DF2C	; 0232A71C
loc_0232A720:
	cmp r5,#0x0	; 0232A720
	blt loc_0232A72A	; 0232A722
	mov r2,#0x1	; 0232A724
	lsl r2,r5	; 0232A726
	b loc_0232A72C	; 0232A728
loc_0232A72A:
	mov r2,#0x0	; 0232A72A
loc_0232A72C:
	ldr r0,[sp,#0x30]	; 0232A72C
	mov r1,#0x3	; 0232A72E
	mov r3,#0x0	; 0232A730
	bl loc_0232E08C	; 0232A732
	mov r0,#0x1	; 0232A736
	str r0,[r4,#0x0]	; 0232A738
	ldr r0,[sp,#0x18]	; 0232A73A
	str r0,[r4,#0x4]	; 0232A73C
	mov r0,#0xa	; 0232A73E
	str r0,[r4,#0x1c]	; 0232A740
	ldr r0,[sp,#0x30]	; 0232A742
	str r0,[r4,#0x20]	; 0232A744
	mov r0,#0x3	; 0232A746
	str r0,[r4,#0x24]	; 0232A748
	str r5,[r4,#0x28]	; 0232A74A
	ldr r0,[sp,#0x58]	; 0232A74C
	str r0,[r4,#0x8]	; 0232A74E
	ldr r0,[sp,#0x1c]	; 0232A750
	str r0,[r4,#0xc]	; 0232A752
	ldr r0,[sp,#0x20]	; 0232A754
	str r0,[r4,#0x10]	; 0232A756
	ldr r0,[sp,#0x24]	; 0232A758
	str r0,[r4,#0x14]	; 0232A75A
	mov r0,#0x0	; 0232A75C
	str r0,[r4,#0x18]	; 0232A75E
	ldr r0,[sp,#0x78]	; 0232A760
	str r0,[r4,#0x2c]	; 0232A762
	ldr r0,[sp,#0x7c]	; 0232A764
	str r0,[r4,#0x30]	; 0232A766
	ldr r0,[sp,#0x80]	; 0232A768
	str r0,[r4,#0x34]	; 0232A76A
	ldr r0,[sp,#0x6c]	; 0232A76C
	str r0,[r4,#0x4c]	; 0232A76E
	add r0,r4,#0x0	; 0232A770
	add r0,#0x38	; 0232A772
	bl loc_0232AF0C	; 0232A774
	add r0,r4,#0x0	; 0232A778
	add r0,#0x38	; 0232A77A
	ldr r1,[sp,#0x6c]	; 0232A77C
	lsl r1,r1,#0x8	; 0232A77E
	mov r2,#0x1	; 0232A780
	bl loc_0232AEF0	; 0232A782
	mov r0,#0x0	; 0232A786
	str r0,[r4,#0x48]	; 0232A788
	mov r0,#0x1	; 0232A78A
	add sp,#0x44	; 0232A78C
	pop {r4,r5,r6,r7}	; 0232A78E
	pop {r3}	; 0232A790
	bx r3	; 0232A792
pool_0232A794:
loc_0232A794:
	.word 0x02356BDC	; 0232A794
pool_0232A798:
loc_0232A798:
	.word 0x00FFB0FF	; 0232A798
pool_0232A79C:
loc_0232A79C:
	.word 0x0232A39D	; 0232A79C

; ===== function loc_0232A7A0 =====
loc_0232A7A0:
	push {lr}	; 0232A7A0
	sub sp,#0x4	; 0232A7A2
	ldr r0,[pool_0232A7BC]	; 0232A7A4
	ldr r1,[r0,#0x0]	; 0232A7A6
	cmp r1,#0x0	; 0232A7A8
	beq loc_0232A7B6	; 0232A7AA
	ldr r0,[r0,#0x4]	; 0232A7AC
	cmp r0,#0x1	; 0232A7AE
	bne loc_0232A7B6	; 0232A7B0
	bl loc_0232A4E0	; 0232A7B2
loc_0232A7B6:
	add sp,#0x4	; 0232A7B6
	pop {r3}	; 0232A7B8
	bx r3	; 0232A7BA
pool_0232A7BC:
loc_0232A7BC:
	.word P1_BssStart + 0x2621C	; 0232A7BC

; ===== function loc_0232A7C0 =====
loc_0232A7C0:
	push {r4,r5,r6,r7,lr}	; 0232A7C0
	sub sp,#0x34	; 0232A7C2
	add r5,r0,#0x0	; 0232A7C4
	add r4,r1,#0x0	; 0232A7C6
	add r6,r2,#0x0	; 0232A7C8
	add r7,r3,#0x0	; 0232A7CA
	bl loc_0232A7A0	; 0232A7CC
	ldr r0,[pool_0232A82C]	; 0232A7D0
	ldr r0,[r0,#0x0]	; 0232A7D2
	cmp r0,#0x0	; 0232A7D4
	beq loc_0232A7E2	; 0232A7D6
	mov r0,#0x0	; 0232A7D8
	add sp,#0x34	; 0232A7DA
	pop {r4,r5,r6,r7}	; 0232A7DC
	pop {r3}	; 0232A7DE
	bx r3	; 0232A7E0
loc_0232A7E2:
	mov r0,#0x0	; 0232A7E2
	str r0,[sp,#0x2c]	; 0232A7E4
	ldr r0,[sp,#0x2c]	; 0232A7E6
	add r1,r5,#0x0	; 0232A7E8
	add r2,r4,#0x0	; 0232A7EA
	blx loc_0232DD90	; 0232A7EC
	add r0,r5,#0x0	; 0232A7F0
	add r1,r4,#0x0	; 0232A7F2
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A7F4
	lsr r3,r4,#0x1	; 0232A7F8
	str r6,[sp,#0x0]	; 0232A7FA
	mov r2,#0x0	; 0232A7FC
	str r2,[sp,#0x4]	; 0232A7FE
	str r2,[sp,#0x8]	; 0232A800
	mov r0,#0x1	; 0232A802
	str r0,[sp,#0xc]	; 0232A804
	str r7,[sp,#0x10]	; 0232A806
	mov r1,#0x7f	; 0232A808
	str r1,[sp,#0x14]	; 0232A80A
	str r2,[sp,#0x18]	; 0232A80C
	str r1,[sp,#0x1c]	; 0232A80E
	ldr r1,[sp,#0x48]	; 0232A810
	str r1,[sp,#0x20]	; 0232A812
	ldr r1,[sp,#0x4c]	; 0232A814
	str r1,[sp,#0x24]	; 0232A816
	ldr r1,[sp,#0x50]	; 0232A818
	str r1,[sp,#0x28]	; 0232A81A
	add r1,r5,#0x0	; 0232A81C
	add r2,r5,r3	; 0232A81E
	bl loc_0232A578	; 0232A820
	add sp,#0x34	; 0232A824
	pop {r4,r5,r6,r7}	; 0232A826
	pop {r3}	; 0232A828
	bx r3	; 0232A82A
pool_0232A82C:
loc_0232A82C:
	.word P1_BssStart + 0x2621C	; 0232A82C

; ===== function loc_0232A830 =====
loc_0232A830:
	push {r4,r5,lr}	; 0232A830
	sub sp,#0x4	; 0232A832
	ldr r4,[pool_0232A88C]	; 0232A834
	ldr r0,[r4,#0x0]	; 0232A836
	cmp r0,#0x0	; 0232A838
	beq loc_0232A882	; 0232A83A
	ldr r0,[r4,#0x4]	; 0232A83C
	cmp r0,#0x0	; 0232A83E
	bne loc_0232A882	; 0232A840
	add r5,r4,#0x0	; 0232A842
	add r5,#0x38	; 0232A844
	add r0,r5,#0x0	; 0232A846
	bl loc_0232AEB8	; 0232A848
	ldr r0,[r4,#0x48]	; 0232A84C
	cmp r0,#0x0	; 0232A84E
	beq loc_0232A868	; 0232A850
	add r0,r5,#0x0	; 0232A852
	bl loc_0232AEA8	; 0232A854
	cmp r0,#0x0	; 0232A858
	beq loc_0232A868	; 0232A85A
	bl loc_0232A4E0	; 0232A85C
	add sp,#0x4	; 0232A860
	pop {r4,r5}	; 0232A862
	pop {r3}	; 0232A864
	bx r3	; 0232A866
loc_0232A868:
	add r0,r5,#0x0	; 0232A868
	bl loc_0232AEC8	; 0232A86A
	asr r5,r0,#0x8	; 0232A86E
	ldr r0,[r4,#0x4c]	; 0232A870
	cmp r5,r0	; 0232A872
	beq loc_0232A882	; 0232A874
	ldr r0,[r4,#0x20]	; 0232A876
	add r1,r5,#0x0	; 0232A878
	mov r2,#0x0	; 0232A87A
	bl loc_0232DF88	; 0232A87C
	str r5,[r4,#0x4c]	; 0232A880
loc_0232A882:
	add sp,#0x4	; 0232A882
	pop {r4,r5}	; 0232A884
	pop {r3}	; 0232A886
	bx r3	; 0232A888
	.byte 0xC0, 0x46	; 0232A88C
pool_0232A88C:
loc_0232A88C:
	.word P1_BssStart + 0x2621C	; 0232A88C

; ===== function loc_0232A890 =====
loc_0232A890:
	mov r1,#0x0	; 0232A890
	ldr r0,[pool_0232A89C]	; 0232A892
	str r1,[r0,#0x0]	; 0232A894
	ldr r0,[pool_0232A8A0]	; 0232A896
	str r1,[r0,#0x0]	; 0232A898
	bx lr	; 0232A89A
pool_0232A89C:
loc_0232A89C:
	.word P1_BssStart + 0x26204	; 0232A89C
pool_0232A8A0:
loc_0232A8A0:
	.word P1_BssStart + 0x2621C	; 0232A8A0

; ===== function loc_0232A8A4 =====
loc_0232A8A4:
	ldr r1,[pool_0232A8BC]	; 0232A8A4
	ldr r1,[r1,#0x0]	; 0232A8A6
	ldr r2,[r1,#0x7c]	; 0232A8A8
	ldr r1,[r2,#0x8]	; 0232A8AA
	cmp r0,r1	; 0232A8AC
	bcc loc_0232A8B4	; 0232A8AE
	mov r0,#0x0	; 0232A8B0
	bx lr	; 0232A8B2
loc_0232A8B4:
	lsl r0,r0,#0x4	; 0232A8B4
	add r0,r2,r0	; 0232A8B6
	ldr r0,[r0,#0x14]	; 0232A8B8
	bx lr	; 0232A8BA
pool_0232A8BC:
loc_0232A8BC:
	.word P1_BssStart + 0x2630C	; 0232A8BC

; ===== function loc_0232A8C0 =====
loc_0232A8C0:
	ldr r1,[pool_0232A908]	; 0232A8C0
	ldr r1,[r1,#0x0]	; 0232A8C2
	add r2,r1,#0x0	; 0232A8C4
	add r2,#0x84	; 0232A8C6
	ldr r3,[r2,#0x0]	; 0232A8C8
	ldr r2,[r3,#0x18]	; 0232A8CA
	cmp r2,#0x0	; 0232A8CC
	bne loc_0232A8D4	; 0232A8CE
	mov r3,#0x0	; 0232A8D0
	b loc_0232A8D6	; 0232A8D2
loc_0232A8D4:
	add r3,r3,r2	; 0232A8D4
loc_0232A8D6:
	cmp r3,#0x0	; 0232A8D6
	bne loc_0232A8DE	; 0232A8D8
	mov r0,#0x0	; 0232A8DA
	bx lr	; 0232A8DC
loc_0232A8DE:
	cmp r0,#0x0	; 0232A8DE
	bge loc_0232A8E6	; 0232A8E0
	mov r0,#0x0	; 0232A8E2
	bx lr	; 0232A8E4
loc_0232A8E6:
	ldr r2,[r3,#0x0]	; 0232A8E6
	cmp r0,r2	; 0232A8E8
	bcc loc_0232A8F0	; 0232A8EA
	mov r0,#0x0	; 0232A8EC
	bx lr	; 0232A8EE
loc_0232A8F0:
	lsl r0,r0,#0x2	; 0232A8F0
	add r0,r3,r0	; 0232A8F2
	ldr r2,[r0,#0x4]	; 0232A8F4
	add r1,#0x84	; 0232A8F6
	ldr r0,[r1,#0x0]	; 0232A8F8
	cmp r2,#0x0	; 0232A8FA
	bne loc_0232A902	; 0232A8FC
	mov r0,#0x0	; 0232A8FE
	bx lr	; 0232A900
loc_0232A902:
	add r0,r0,r2	; 0232A902
	bx lr	; 0232A904
	.byte 0xC0, 0x46	; 0232A908
pool_0232A908:
loc_0232A908:
	.word P1_BssStart + 0x2630C	; 0232A908

; ===== function loc_0232A90C =====
loc_0232A90C:
	ldr r1,[pool_0232A954]	; 0232A90C
	ldr r1,[r1,#0x0]	; 0232A90E
	add r2,r1,#0x0	; 0232A910
	add r2,#0x84	; 0232A912
	ldr r3,[r2,#0x0]	; 0232A914
	ldr r2,[r3,#0x14]	; 0232A916
	cmp r2,#0x0	; 0232A918
	bne loc_0232A920	; 0232A91A
	mov r3,#0x0	; 0232A91C
	b loc_0232A922	; 0232A91E
loc_0232A920:
	add r3,r3,r2	; 0232A920
loc_0232A922:
	cmp r3,#0x0	; 0232A922
	bne loc_0232A92A	; 0232A924
	mov r0,#0x0	; 0232A926
	bx lr	; 0232A928
loc_0232A92A:
	cmp r0,#0x0	; 0232A92A
	bge loc_0232A932	; 0232A92C
	mov r0,#0x0	; 0232A92E
	bx lr	; 0232A930
loc_0232A932:
	ldr r2,[r3,#0x0]	; 0232A932
	cmp r0,r2	; 0232A934
	bcc loc_0232A93C	; 0232A936
	mov r0,#0x0	; 0232A938
	bx lr	; 0232A93A
loc_0232A93C:
	lsl r0,r0,#0x2	; 0232A93C
	add r0,r3,r0	; 0232A93E
	ldr r2,[r0,#0x4]	; 0232A940
	add r1,#0x84	; 0232A942
	ldr r0,[r1,#0x0]	; 0232A944
	cmp r2,#0x0	; 0232A946
	bne loc_0232A94E	; 0232A948
	mov r0,#0x0	; 0232A94A
	bx lr	; 0232A94C
loc_0232A94E:
	add r0,r0,r2	; 0232A94E
	bx lr	; 0232A950
	.byte 0xC0, 0x46	; 0232A954
pool_0232A954:
loc_0232A954:
	.word P1_BssStart + 0x2630C	; 0232A954

; ===== function loc_0232A958 =====
loc_0232A958:
	ldr r1,[pool_0232A9A0]	; 0232A958
	ldr r1,[r1,#0x0]	; 0232A95A
	add r2,r1,#0x0	; 0232A95C
	add r2,#0x84	; 0232A95E
	ldr r3,[r2,#0x0]	; 0232A960
	ldr r2,[r3,#0x10]	; 0232A962
	cmp r2,#0x0	; 0232A964
	bne loc_0232A96C	; 0232A966
	mov r3,#0x0	; 0232A968
	b loc_0232A96E	; 0232A96A
loc_0232A96C:
	add r3,r3,r2	; 0232A96C
loc_0232A96E:
	cmp r3,#0x0	; 0232A96E
	bne loc_0232A976	; 0232A970
	mov r0,#0x0	; 0232A972
	bx lr	; 0232A974
loc_0232A976:
	cmp r0,#0x0	; 0232A976
	bge loc_0232A97E	; 0232A978
	mov r0,#0x0	; 0232A97A
	bx lr	; 0232A97C
loc_0232A97E:
	ldr r2,[r3,#0x0]	; 0232A97E
	cmp r0,r2	; 0232A980
	bcc loc_0232A988	; 0232A982
	mov r0,#0x0	; 0232A984
	bx lr	; 0232A986
loc_0232A988:
	lsl r0,r0,#0x2	; 0232A988
	add r0,r3,r0	; 0232A98A
	ldr r2,[r0,#0x4]	; 0232A98C
	add r1,#0x84	; 0232A98E
	ldr r0,[r1,#0x0]	; 0232A990
	cmp r2,#0x0	; 0232A992
	bne loc_0232A99A	; 0232A994
	mov r0,#0x0	; 0232A996
	bx lr	; 0232A998
loc_0232A99A:
	add r0,r0,r2	; 0232A99A
	bx lr	; 0232A99C
	.byte 0xC0, 0x46	; 0232A9A0
pool_0232A9A0:
loc_0232A9A0:
	.word P1_BssStart + 0x2630C	; 0232A9A0

; ===== function loc_0232A9A4 =====
loc_0232A9A4:
	ldr r1,[pool_0232A9EC]	; 0232A9A4
	ldr r1,[r1,#0x0]	; 0232A9A6
	add r2,r1,#0x0	; 0232A9A8
	add r2,#0x84	; 0232A9AA
	ldr r3,[r2,#0x0]	; 0232A9AC
	ldr r2,[r3,#0xc]	; 0232A9AE
	cmp r2,#0x0	; 0232A9B0
	bne loc_0232A9B8	; 0232A9B2
	mov r3,#0x0	; 0232A9B4
	b loc_0232A9BA	; 0232A9B6
loc_0232A9B8:
	add r3,r3,r2	; 0232A9B8
loc_0232A9BA:
	cmp r3,#0x0	; 0232A9BA
	bne loc_0232A9C2	; 0232A9BC
	mov r0,#0x0	; 0232A9BE
	bx lr	; 0232A9C0
loc_0232A9C2:
	cmp r0,#0x0	; 0232A9C2
	bge loc_0232A9CA	; 0232A9C4
	mov r0,#0x0	; 0232A9C6
	bx lr	; 0232A9C8
loc_0232A9CA:
	ldr r2,[r3,#0x0]	; 0232A9CA
	cmp r0,r2	; 0232A9CC
	bcc loc_0232A9D4	; 0232A9CE
	mov r0,#0x0	; 0232A9D0
	bx lr	; 0232A9D2
loc_0232A9D4:
	lsl r0,r0,#0x2	; 0232A9D4
	add r0,r3,r0	; 0232A9D6
	ldr r2,[r0,#0x4]	; 0232A9D8
	add r1,#0x84	; 0232A9DA
	ldr r0,[r1,#0x0]	; 0232A9DC
	cmp r2,#0x0	; 0232A9DE
	bne loc_0232A9E6	; 0232A9E0
	mov r0,#0x0	; 0232A9E2
	bx lr	; 0232A9E4
loc_0232A9E6:
	add r0,r0,r2	; 0232A9E6
	bx lr	; 0232A9E8
	.byte 0xC0, 0x46	; 0232A9EC
pool_0232A9EC:
loc_0232A9EC:
	.word P1_BssStart + 0x2630C	; 0232A9EC

; ===== function loc_0232A9F0 =====
loc_0232A9F0:
	ldr r0,[pool_0232A9F8]	; 0232A9F0
	ldr r0,[r0,#0x0]	; 0232A9F2
	bx lr	; 0232A9F4
	.byte 0xC0, 0x46	; 0232A9F8
pool_0232A9F8:
loc_0232A9F8:
	.word P1_BssStart + 0x2630C	; 0232A9F8

; ===== function loc_0232A9FC =====
loc_0232A9FC:
	push {r4,r5,r6,r7,lr}	; 0232A9FC
	sub sp,#0x4	; 0232A9FE
	add r5,r0,#0x0	; 0232AA00
	add r4,r1,#0x0	; 0232AA02
	add r0,r4,#0x0	; 0232AA04
	add r1,r5,#0x0	; 0232AA06
	mov r2,#0x30	; 0232AA08
	blx loc_0232DDA4	; 0232AA0A
	ldr r0,[r5,#0x18]	; 0232AA0E
	cmp r0,#0x0	; 0232AA10
	bne loc_0232AA18	; 0232AA12
	mov r1,#0x0	; 0232AA14
	b loc_0232AA1A	; 0232AA16
loc_0232AA18:
	add r1,r4,r0	; 0232AA18
loc_0232AA1A:
	add r0,r5,#0x0	; 0232AA1A
	add r0,#0x84	; 0232AA1C
	str r1,[r0,#0x0]	; 0232AA1E
	ldr r0,[r5,#0x20]	; 0232AA20
	cmp r0,#0x0	; 0232AA22
	bne loc_0232AA2A	; 0232AA24
	mov r0,#0x0	; 0232AA26
	b loc_0232AA2C	; 0232AA28
loc_0232AA2A:
	add r0,r4,r0	; 0232AA2A
loc_0232AA2C:
	str r0,[r5,#0x7c]	; 0232AA2C
	ldr r0,[r5,#0x10]	; 0232AA2E
	cmp r0,#0x0	; 0232AA30
	bne loc_0232AA38	; 0232AA32
	mov r1,#0x0	; 0232AA34
	b loc_0232AA3A	; 0232AA36
loc_0232AA38:
	add r1,r4,r0	; 0232AA38
loc_0232AA3A:
	add r0,r5,#0x0	; 0232AA3A
	add r0,#0x80	; 0232AA3C
	str r1,[r0,#0x0]	; 0232AA3E
	mov r0,#0x0	; 0232AA40
	ldr r3,[r5,#0x7c]	; 0232AA42
	ldr r1,[r3,#0x8]	; 0232AA44
	cmp r1,#0x0	; 0232AA46
	bls loc_0232AA6C	; 0232AA48
	add r6,r0,#0x0	; 0232AA4A
	add r2,r0,#0x0	; 0232AA4C
loc_0232AA4E:
	add r3,#0xc	; 0232AA4E
	add r7,r3,r6	; 0232AA50
	ldr r1,[r3,r6]	; 0232AA52
	cmp r1,#0x0	; 0232AA54
	bne loc_0232AA5C	; 0232AA56
	add r1,r2,#0x0	; 0232AA58
	b loc_0232AA5E	; 0232AA5A
loc_0232AA5C:
	add r1,r4,r1	; 0232AA5C
loc_0232AA5E:
	str r1,[r7,#0x8]	; 0232AA5E
	add r6,#0x10	; 0232AA60
	add r0,r0,#0x1	; 0232AA62
	ldr r3,[r5,#0x7c]	; 0232AA64
	ldr r1,[r3,#0x8]	; 0232AA66
	cmp r0,r1	; 0232AA68
	bcc loc_0232AA4E	; 0232AA6A
loc_0232AA6C:
	ldr r0,[pool_0232AA78]	; 0232AA6C
	str r5,[r0,#0x0]	; 0232AA6E
	add sp,#0x4	; 0232AA70
	pop {r4,r5,r6,r7}	; 0232AA72
	pop {r3}	; 0232AA74
	bx r3	; 0232AA76
pool_0232AA78:
loc_0232AA78:
	.word P1_BssStart + 0x2630C	; 0232AA78

; ===== function loc_0232AA7C =====
loc_0232AA7C:
	push {r4,lr}	; 0232AA7C
	bl loc_0232E25C	; 0232AA7E
	add r4,r0,#0x0	; 0232AA82
	mov r0,#0x1	; 0232AA84
	bl loc_0232E2C8	; 0232AA86
	add r0,r4,#0x0	; 0232AA8A
	bl loc_0232E27C	; 0232AA8C
	pop {r4}	; 0232AA90
	pop {r3}	; 0232AA92
	bx r3	; 0232AA94
	.byte 0x00, 0x00	; 0232AA98

; ===== function loc_0232AA98 =====
loc_0232AA98:
	push {r4,r5,lr}	; 0232AA98
	sub sp,#0x4	; 0232AA9A
	add r5,r0,#0x0	; 0232AA9C
	ldr r0,[r5,#0x0]	; 0232AA9E
	mov r1,#0x14	; 0232AAA0
	mov r2,#0x4	; 0232AAA2
	bl loc_02329B24	; 0232AAA4
	add r4,r0,#0x0	; 0232AAA8
	cmp r4,#0x0	; 0232AAAA
	bne loc_0232AAB8	; 0232AAAC
	mov r0,#0x0	; 0232AAAE
	add sp,#0x4	; 0232AAB0
	pop {r4,r5}	; 0232AAB2
	pop {r3}	; 0232AAB4
	bx r3	; 0232AAB6
loc_0232AAB8:
	bl loc_0232AB00	; 0232AAB8
	add r0,r5,#0x4	; 0232AABC
	add r1,r4,#0x0	; 0232AABE
	bl loc_023295B4	; 0232AAC0
	mov r0,#0x1	; 0232AAC4
	add sp,#0x4	; 0232AAC6
	pop {r4,r5}	; 0232AAC8
	pop {r3}	; 0232AACA
	bx r3	; 0232AACC
	.byte 0x00, 0x00	; 0232AAD0

; ===== function loc_0232AAD0 =====
loc_0232AAD0:
	push {r4,r5,lr}	; 0232AAD0
	sub sp,#0x4	; 0232AAD2
	add r5,r0,#0x0	; 0232AAD4
	add r4,r1,#0x0	; 0232AAD6
	add r0,r5,#0x4	; 0232AAD8
	mov r1,#0xc	; 0232AADA
	bl loc_02329608	; 0232AADC
	str r4,[r5,#0x0]	; 0232AAE0
	add r0,r5,#0x0	; 0232AAE2
	bl loc_0232AA98	; 0232AAE4
	cmp r0,#0x0	; 0232AAE8
	beq loc_0232AAF6	; 0232AAEA
	mov r0,#0x1	; 0232AAEC
	add sp,#0x4	; 0232AAEE
	pop {r4,r5}	; 0232AAF0
	pop {r3}	; 0232AAF2
	bx r3	; 0232AAF4
loc_0232AAF6:
	mov r0,#0x0	; 0232AAF6
	add sp,#0x4	; 0232AAF8
	pop {r4,r5}	; 0232AAFA
	pop {r3}	; 0232AAFC
	bx r3	; 0232AAFE

; ===== function loc_0232AB00 =====
loc_0232AB00:
	mov r1,#0x0	; 0232AB00
	ldr r3,[pool_0232AB08]	; 0232AB02
	bx r3	; 0232AB04
	.byte 0xC0, 0x46	; 0232AB08
pool_0232AB08:
loc_0232AB08:
	.word loc_02329608 + 1	; 0232AB08

; ===== function loc_0232AB0C =====
loc_0232AB0C:
	push {r4,r5,r6,r7,lr}	; 0232AB0C
	sub sp,#0x4	; 0232AB0E
	add r5,r0,#0x0	; 0232AB10
	add r6,r1,#0x0	; 0232AB12
	add r7,r2,#0x0	; 0232AB14
	str r3,[sp,#0x0]	; 0232AB16
	ldr r0,[r5,#0x0]	; 0232AB18
	add r1,#0x1f	; 0232AB1A
	mov r2,#0x1f	; 0232AB1C
	bic r1,r2	; 0232AB1E
	add r1,#0x20	; 0232AB20
	mov r2,#0x20	; 0232AB22
	bl loc_02329B24	; 0232AB24
	add r4,r0,#0x0	; 0232AB28
	cmp r4,#0x0	; 0232AB2A
	bne loc_0232AB38	; 0232AB2C
	mov r0,#0x0	; 0232AB2E
	add sp,#0x4	; 0232AB30
	pop {r4,r5,r6,r7}	; 0232AB32
	pop {r3}	; 0232AB34
	bx r3	; 0232AB36
loc_0232AB38:
	add r0,r5,#0x4	; 0232AB38
	mov r1,#0x0	; 0232AB3A
	bl loc_023294D4	; 0232AB3C
	str r6,[r4,#0x8]	; 0232AB40
	str r7,[r4,#0xc]	; 0232AB42
	ldr r1,[sp,#0x0]	; 0232AB44
	str r1,[r4,#0x10]	; 0232AB46
	ldr r1,[sp,#0x18]	; 0232AB48
	str r1,[r4,#0x14]	; 0232AB4A
	add r1,r4,#0x0	; 0232AB4C
	bl loc_023295B4	; 0232AB4E
	add r4,#0x20	; 0232AB52
	add r0,r4,#0x0	; 0232AB54
	add sp,#0x4	; 0232AB56
	pop {r4,r5,r6,r7}	; 0232AB58
	pop {r3}	; 0232AB5A
	bx r3	; 0232AB5C
	.byte 0x00, 0x00	; 0232AB60

; ===== function loc_0232AB60 =====
loc_0232AB60:
	push {r4,r5,r6,r7,lr}	; 0232AB60
	sub sp,#0x4	; 0232AB62
	add r7,r0,#0x0	; 0232AB64
	add r0,r7,#0x4	; 0232AB66
	mov r1,#0x0	; 0232AB68
	bl loc_023294D4	; 0232AB6A
	add r5,r0,#0x0	; 0232AB6E
	cmp r5,#0x0	; 0232AB70
	beq loc_0232ABB8	; 0232AB72
loc_0232AB74:
	add r0,r5,#0x0	; 0232AB74
	mov r1,#0x0	; 0232AB76
	bl loc_023294D4	; 0232AB78
	add r4,r0,#0x0	; 0232AB7C
	cmp r4,#0x0	; 0232AB7E
	beq loc_0232ABA2	; 0232AB80
loc_0232AB82:
	ldr r6,[r4,#0xc]	; 0232AB82
	cmp r6,#0x0	; 0232AB84
	beq loc_0232AB94	; 0232AB86
	add r0,r4,#0x0	; 0232AB88
	add r0,#0x20	; 0232AB8A
	ldr r1,[r4,#0x8]	; 0232AB8C
	ldr r2,[r4,#0x10]	; 0232AB8E
	ldr r3,[r4,#0x14]	; 0232AB90
	blx r6	; 0232AB92
loc_0232AB94:
	add r0,r5,#0x0	; 0232AB94
	add r1,r4,#0x0	; 0232AB96
	bl loc_023294D4	; 0232AB98
	add r4,r0,#0x0	; 0232AB9C
	cmp r4,#0x0	; 0232AB9E
	bne loc_0232AB82	; 0232ABA0
loc_0232ABA2:
	add r0,r7,#0x4	; 0232ABA2
	add r1,r5,#0x0	; 0232ABA4
	bl loc_023294F4	; 0232ABA6
	add r0,r7,#0x4	; 0232ABAA
	mov r1,#0x0	; 0232ABAC
	bl loc_023294D4	; 0232ABAE
	add r5,r0,#0x0	; 0232ABB2
	cmp r5,#0x0	; 0232ABB4
	bne loc_0232AB74	; 0232ABB6
loc_0232ABB8:
	ldr r0,[r7,#0x0]	; 0232ABB8
	mov r1,#0x3	; 0232ABBA
	bl loc_02329AF8	; 0232ABBC
	bl loc_0232AA7C	; 0232ABC0
	add r0,r7,#0x0	; 0232ABC4
	bl loc_0232AA98	; 0232ABC6
	add sp,#0x4	; 0232ABCA
	pop {r4,r5,r6,r7}	; 0232ABCC
	pop {r3}	; 0232ABCE
	bx r3	; 0232ABD0
	.byte 0x00, 0x00	; 0232ABD4

; ===== function loc_0232ABD4 =====
loc_0232ABD4:
	push {r4,lr}	; 0232ABD4
	add r4,r0,#0x0	; 0232ABD6
	bl loc_0232AB60	; 0232ABD8
	ldr r0,[r4,#0x0]	; 0232ABDC
	bl loc_02329B50	; 0232ABDE
	pop {r4}	; 0232ABE2
	pop {r3}	; 0232ABE4
	bx r3	; 0232ABE6

; ===== function loc_0232ABE8 =====
loc_0232ABE8:
	push {r4,r5,lr}	; 0232ABE8
	sub sp,#0x4	; 0232ABEA
	add r1,r0,r1	; 0232ABEC
	add r4,r0,#0x3	; 0232ABEE
	mov r0,#0x3	; 0232ABF0
	bic r4,r0	; 0232ABF2
	cmp r4,r1	; 0232ABF4
	bls loc_0232AC02	; 0232ABF6
	mov r0,#0x0	; 0232ABF8
	add sp,#0x4	; 0232ABFA
	pop {r4,r5}	; 0232ABFC
	pop {r3}	; 0232ABFE
	bx r3	; 0232AC00
loc_0232AC02:
	sub r1,r1,r4	; 0232AC02
	cmp r1,#0x10	; 0232AC04
	bcs loc_0232AC12	; 0232AC06
	mov r0,#0x0	; 0232AC08
	add sp,#0x4	; 0232AC0A
	pop {r4,r5}	; 0232AC0C
	pop {r3}	; 0232AC0E
	bx r3	; 0232AC10
loc_0232AC12:
	add r0,r4,#0x0	; 0232AC12
	add r0,#0x10	; 0232AC14
	sub r1,#0x10	; 0232AC16
	mov r2,#0x0	; 0232AC18
	bl loc_02329B58	; 0232AC1A
	add r5,r0,#0x0	; 0232AC1E
	cmp r5,#0x0	; 0232AC20
	bne loc_0232AC2E	; 0232AC22
	mov r0,#0x0	; 0232AC24
	add sp,#0x4	; 0232AC26
	pop {r4,r5}	; 0232AC28
	pop {r3}	; 0232AC2A
	bx r3	; 0232AC2C
loc_0232AC2E:
	add r0,r4,#0x0	; 0232AC2E
	add r1,r5,#0x0	; 0232AC30
	bl loc_0232AAD0	; 0232AC32
	cmp r0,#0x0	; 0232AC36
	bne loc_0232AC4A	; 0232AC38
	add r0,r5,#0x0	; 0232AC3A
	bl loc_02329B50	; 0232AC3C
	mov r0,#0x0	; 0232AC40
	add sp,#0x4	; 0232AC42
	pop {r4,r5}	; 0232AC44
	pop {r3}	; 0232AC46
	bx r3	; 0232AC48
loc_0232AC4A:
	add r0,r4,#0x0	; 0232AC4A
	add sp,#0x4	; 0232AC4C
	pop {r4,r5}	; 0232AC4E
	pop {r3}	; 0232AC50
	bx r3	; 0232AC52

; ===== function loc_0232AC54 =====
loc_0232AC54:
	push {r4,r5,r6,r7,lr}	; 0232AC54
	sub sp,#0xc	; 0232AC56
	str r0,[sp,#0x0]	; 0232AC58
	add r5,r1,#0x0	; 0232AC5A
	add r6,r3,#0x0	; 0232AC5C
	ldr r7,[sp,#0x20]	; 0232AC5E
	add r0,r2,#0x0	; 0232AC60
	bl loc_0232A958	; 0232AC62
	add r4,r0,#0x0	; 0232AC66
	cmp r4,#0x0	; 0232AC68
	bne loc_0232AC76	; 0232AC6A
	mov r0,#0x0	; 0232AC6C
	add sp,#0xc	; 0232AC6E
	pop {r4,r5,r6,r7}	; 0232AC70
	pop {r3}	; 0232AC72
	bx r3	; 0232AC74
loc_0232AC76:
	ldr r0,[sp,#0x0]	; 0232AC76
	add r1,r5,#0x0	; 0232AC78
	add r2,r6,#0x0	; 0232AC7A
	bl loc_0232A078	; 0232AC7C
	str r0,[sp,#0x4]	; 0232AC80
	cmp r0,#0x0	; 0232AC82
	bne loc_0232AC90	; 0232AC84
	mov r0,#0x0	; 0232AC86
	add sp,#0xc	; 0232AC88
	pop {r4,r5,r6,r7}	; 0232AC8A
	pop {r3}	; 0232AC8C
	bx r3	; 0232AC8E
loc_0232AC90:
	ldr r0,[r4,#0x0]	; 0232AC90
	bl loc_0232A8A4	; 0232AC92
	add r6,r0,#0x0	; 0232AC96
	cmp r6,#0x0	; 0232AC98
	bne loc_0232ACAC	; 0232AC9A
	ldr r0,[sp,#0x4]	; 0232AC9C
	bl loc_0232A070	; 0232AC9E
	mov r0,#0x0	; 0232ACA2
	add sp,#0xc	; 0232ACA4
	pop {r4,r5,r6,r7}	; 0232ACA6
	pop {r3}	; 0232ACA8
	bx r3	; 0232ACAA
loc_0232ACAC:
	mov r5,#0x0	; 0232ACAC
loc_0232ACAE:
	ldrh r0,[r4,#0x4]	; 0232ACAE
	ldr r1,[pool_0232AD30]	; 0232ACB0
	cmp r0,r1	; 0232ACB2
	beq loc_0232ACF2	; 0232ACB4
	bl loc_0232A90C	; 0232ACB6
	cmp r0,#0x0	; 0232ACBA
	bne loc_0232ACCE	; 0232ACBC
	ldr r0,[sp,#0x4]	; 0232ACBE
	bl loc_0232A070	; 0232ACC0
	mov r0,#0x0	; 0232ACC4
	add sp,#0xc	; 0232ACC6
	pop {r4,r5,r6,r7}	; 0232ACC8
	pop {r3}	; 0232ACCA
	bx r3	; 0232ACCC
loc_0232ACCE:
	ldr r0,[r0,#0x0]	; 0232ACCE
	bl loc_0232A8A4	; 0232ACD0
	add r2,r0,#0x0	; 0232ACD4
	cmp r2,#0x0	; 0232ACD6
	bne loc_0232ACEA	; 0232ACD8
	ldr r0,[sp,#0x4]	; 0232ACDA
	bl loc_0232A070	; 0232ACDC
	mov r0,#0x0	; 0232ACE0
	add sp,#0xc	; 0232ACE2
	pop {r4,r5,r6,r7}	; 0232ACE4
	pop {r3}	; 0232ACE6
	bx r3	; 0232ACE8
loc_0232ACEA:
	add r0,r6,#0x0	; 0232ACEA
	add r1,r5,#0x0	; 0232ACEC
	bl loc_0232E6AC	; 0232ACEE
loc_0232ACF2:
	add r4,r4,#0x2	; 0232ACF2
	add r5,r5,#0x1	; 0232ACF4
	cmp r5,#0x4	; 0232ACF6
	blt loc_0232ACAE	; 0232ACF8
	ldr r0,[sp,#0x4]	; 0232ACFA
	ldr r2,[sp,#0x24]	; 0232ACFC
	ldr r1,[r2,#0x18]	; 0232ACFE
	add r1,r2,r1	; 0232AD00
	ldr r2,[r7,#0x0]	; 0232AD02
	add r3,r6,#0x0	; 0232AD04
	bl loc_0232A04C	; 0232AD06
	ldr r0,[sp,#0x0]	; 0232AD0A
	ldrb r1,[r7,#0x6]	; 0232AD0C
	bl loc_0232A178	; 0232AD0E
	ldr r0,[sp,#0x0]	; 0232AD12
	ldrb r1,[r7,#0x7]	; 0232AD14
	bl loc_0232A13C	; 0232AD16
	ldr r0,[sp,#0x0]	; 0232AD1A
	ldr r1,[sp,#0x28]	; 0232AD1C
	ldr r2,[sp,#0x2c]	; 0232AD1E
	bl loc_0232A0F0	; 0232AD20
	mov r0,#0x1	; 0232AD24
	add sp,#0xc	; 0232AD26
	pop {r4,r5,r6,r7}	; 0232AD28
	pop {r3}	; 0232AD2A
	bx r3	; 0232AD2C
	.byte 0xC0, 0x46	; 0232AD30
pool_0232AD30:
loc_0232AD30:
	.word 0x0000FFFF	; 0232AD30

; ===== function loc_0232AD34 =====
	push {r4,r5,r6,r7,lr}	; 0232AD34
	sub sp,#0x14	; 0232AD36
	str r0,[sp,#0x10]	; 0232AD38
	add r5,r1,#0x0	; 0232AD3A
	add r4,r2,#0x0	; 0232AD3C
	add r6,r3,#0x0	; 0232AD3E
	ldr r0,[sp,#0x28]	; 0232AD40
	bl loc_0232A9A4	; 0232AD42
	cmp r0,#0x0	; 0232AD46
	bne loc_0232AD54	; 0232AD48
	mov r0,#0x0	; 0232AD4A
	add sp,#0x14	; 0232AD4C
	pop {r4,r5,r6,r7}	; 0232AD4E
	pop {r3}	; 0232AD50
	bx r3	; 0232AD52
loc_0232AD54:
	ldr r0,[r0,#0x0]	; 0232AD54
	bl loc_0232A8A4	; 0232AD56
	add r7,r0,#0x0	; 0232AD5A
	cmp r7,#0x0	; 0232AD5C
	bne loc_0232AD6A	; 0232AD5E
	mov r0,#0x0	; 0232AD60
	add sp,#0x14	; 0232AD62
	pop {r4,r5,r6,r7}	; 0232AD64
	pop {r3}	; 0232AD66
	bx r3	; 0232AD68
loc_0232AD6A:
	ldr r1,[sp,#0x2c]	; 0232AD6A
	bl loc_0232AE7C	; 0232AD6C
	cmp r0,#0x0	; 0232AD70
	bne loc_0232AD7E	; 0232AD72
	mov r0,#0x0	; 0232AD74
	add sp,#0x14	; 0232AD76
	pop {r4,r5,r6,r7}	; 0232AD78
	pop {r3}	; 0232AD7A
	bx r3	; 0232AD7C
loc_0232AD7E:
	cmp r6,#0x0	; 0232AD7E
	bge loc_0232AD84	; 0232AD80
	ldrb r6,[r0,#0x8]	; 0232AD82
loc_0232AD84:
	cmp r4,#0x0	; 0232AD84
	bge loc_0232AD8A	; 0232AD86
	ldrh r4,[r0,#0x4]	; 0232AD88
loc_0232AD8A:
	cmp r5,#0x0	; 0232AD8A
	bge loc_0232AD90	; 0232AD8C
	ldrb r5,[r0,#0x9]	; 0232AD8E
loc_0232AD90:
	str r0,[sp,#0x0]	; 0232AD90
	str r7,[sp,#0x4]	; 0232AD92
	ldr r0,[sp,#0x28]	; 0232AD94
	str r0,[sp,#0x8]	; 0232AD96
	ldr r0,[sp,#0x2c]	; 0232AD98
	str r0,[sp,#0xc]	; 0232AD9A
	ldr r0,[sp,#0x10]	; 0232AD9C
	add r1,r5,#0x0	; 0232AD9E
	add r2,r4,#0x0	; 0232ADA0
	add r3,r6,#0x0	; 0232ADA2
	bl loc_0232AC54	; 0232ADA4
	add sp,#0x14	; 0232ADA8
	pop {r4,r5,r6,r7}	; 0232ADAA
	pop {r3}	; 0232ADAC
	bx r3	; 0232ADAE
loc_0232ADB0:
	push {r4,r5,r6,r7,lr}	; 0232ADB0
	sub sp,#0x14	; 0232ADB2
	add r7,r0,#0x0	; 0232ADB4
	add r5,r1,#0x0	; 0232ADB6
	add r4,r2,#0x0	; 0232ADB8
	add r0,r5,#0x0	; 0232ADBA
	bl loc_0232A9A4	; 0232ADBC
	cmp r0,#0x0	; 0232ADC0
	bne loc_0232ADCE	; 0232ADC2
	mov r0,#0x0	; 0232ADC4
	add sp,#0x14	; 0232ADC6
	pop {r4,r5,r6,r7}	; 0232ADC8
	pop {r3}	; 0232ADCA
	bx r3	; 0232ADCC
loc_0232ADCE:
	ldr r0,[r0,#0x0]	; 0232ADCE
	bl loc_0232A8A4	; 0232ADD0
	add r6,r0,#0x0	; 0232ADD4
	cmp r6,#0x0	; 0232ADD6
	bne loc_0232ADE4	; 0232ADD8
	mov r0,#0x0	; 0232ADDA
	add sp,#0x14	; 0232ADDC
	pop {r4,r5,r6,r7}	; 0232ADDE
	pop {r3}	; 0232ADE0
	bx r3	; 0232ADE2
loc_0232ADE4:
	add r1,r4,#0x0	; 0232ADE4
	bl loc_0232AE7C	; 0232ADE6
	add r3,r0,#0x0	; 0232ADEA
	cmp r3,#0x0	; 0232ADEC
	bne loc_0232ADFA	; 0232ADEE
	mov r0,#0x0	; 0232ADF0
	add sp,#0x14	; 0232ADF2
	pop {r4,r5,r6,r7}	; 0232ADF4
	pop {r3}	; 0232ADF6
	bx r3	; 0232ADF8
loc_0232ADFA:
	str r3,[sp,#0x0]	; 0232ADFA
	str r6,[sp,#0x4]	; 0232ADFC
	str r5,[sp,#0x8]	; 0232ADFE
	str r4,[sp,#0xc]	; 0232AE00
	add r0,r7,#0x0	; 0232AE02
	ldrb r1,[r3,#0x9]	; 0232AE04
	ldrh r2,[r3,#0x4]	; 0232AE06
	ldrb r3,[r3,#0x8]	; 0232AE08
	bl loc_0232AC54	; 0232AE0A
	add sp,#0x14	; 0232AE0E
	pop {r4,r5,r6,r7}	; 0232AE10
	pop {r3}	; 0232AE12
	bx r3	; 0232AE14
	.byte 0x00, 0x00	; 0232AE18

; ===== function loc_0232AE18 =====
loc_0232AE18:
	push {r4,r5,r6,r7,lr}	; 0232AE18
	sub sp,#0x4	; 0232AE1A
	add r7,r0,#0x0	; 0232AE1C
	bl loc_0232A9F0	; 0232AE1E
	mov r6,#0x0	; 0232AE22
	str r6,[sp,#0x0]	; 0232AE24
loc_0232AE26:
	add r0,r6,#0x0	; 0232AE26
	bl loc_0232A8C0	; 0232AE28
	add r5,r0,#0x0	; 0232AE2C
	cmp r5,#0x0	; 0232AE2E
	beq loc_0232AE6C	; 0232AE30
	add r0,r6,#0x0	; 0232AE32
	ldrb r1,[r5,#0x0]	; 0232AE34
	bl loc_0232A224	; 0232AE36
	ldr r0,[r5,#0x4]	; 0232AE3A
	cmp r0,#0x0	; 0232AE3C
	beq loc_0232AE6C	; 0232AE3E
	cmp r7,#0x0	; 0232AE40
	beq loc_0232AE6C	; 0232AE42
	ldr r4,[sp,#0x0]	; 0232AE44
	ldrb r0,[r5,#0x0]	; 0232AE46
	cmp r0,#0x0	; 0232AE48
	ble loc_0232AE6C	; 0232AE4A
loc_0232AE4C:
	add r0,r6,#0x0	; 0232AE4C
	add r1,r7,#0x0	; 0232AE4E
	ldr r2,[r5,#0x4]	; 0232AE50
	bl loc_0232A1B8	; 0232AE52
	cmp r0,#0x0	; 0232AE56
	bne loc_0232AE64	; 0232AE58
	mov r0,#0x0	; 0232AE5A
	add sp,#0x4	; 0232AE5C
	pop {r4,r5,r6,r7}	; 0232AE5E
	pop {r3}	; 0232AE60
	bx r3	; 0232AE62
loc_0232AE64:
	add r4,r4,#0x1	; 0232AE64
	ldrb r0,[r5,#0x0]	; 0232AE66
	cmp r4,r0	; 0232AE68
	blt loc_0232AE4C	; 0232AE6A
loc_0232AE6C:
	add r6,r6,#0x1	; 0232AE6C
	cmp r6,#0x20	; 0232AE6E
	blt loc_0232AE26	; 0232AE70
	mov r0,#0x1	; 0232AE72
	add sp,#0x4	; 0232AE74
	pop {r4,r5,r6,r7}	; 0232AE76
	pop {r3}	; 0232AE78
	bx r3	; 0232AE7A

; ===== function loc_0232AE7C =====
loc_0232AE7C:
	cmp r1,#0x0	; 0232AE7C
	bge loc_0232AE84	; 0232AE7E
	mov r0,#0x0	; 0232AE80
	bx lr	; 0232AE82
loc_0232AE84:
	ldr r2,[r0,#0x1c]	; 0232AE84
	cmp r1,r2	; 0232AE86
	bcc loc_0232AE8E	; 0232AE88
	mov r0,#0x0	; 0232AE8A
	bx lr	; 0232AE8C
loc_0232AE8E:
	add r0,#0x20	; 0232AE8E
	mov r2,#0xc	; 0232AE90
	mul r1,r2	; 0232AE92
	add r3,r0,r1	; 0232AE94
	ldr r2,[r0,r1]	; 0232AE96
	mov r0,#0x0	; 0232AE98
	mvn r1,r0	; 0232AE9A
	cmp r2,r1	; 0232AE9C
	bne loc_0232AEA2	; 0232AE9E
	add r3,r0,#0x0	; 0232AEA0
loc_0232AEA2:
	add r0,r3,#0x0	; 0232AEA2
	bx lr	; 0232AEA4
	.byte 0x00, 0x00	; 0232AEA8

; ===== function loc_0232AEA8 =====
loc_0232AEA8:
	ldr r1,[r0,#0x8]	; 0232AEA8
	ldr r0,[r0,#0xc]	; 0232AEAA
	cmp r1,r0	; 0232AEAC
	blt loc_0232AEB4	; 0232AEAE
	mov r0,#0x1	; 0232AEB0
	bx lr	; 0232AEB2
loc_0232AEB4:
	mov r0,#0x0	; 0232AEB4
	bx lr	; 0232AEB6

; ===== function loc_0232AEB8 =====
loc_0232AEB8:
	ldr r2,[r0,#0x8]	; 0232AEB8
	ldr r1,[r0,#0xc]	; 0232AEBA
	cmp r2,r1	; 0232AEBC
	bge loc_0232AEC4	; 0232AEBE
	add r1,r2,#0x1	; 0232AEC0
	str r1,[r0,#0x8]	; 0232AEC2
loc_0232AEC4:
	bx lr	; 0232AEC4
	.byte 0x00, 0x00	; 0232AEC8

; ===== function loc_0232AEC8 =====
loc_0232AEC8:
	push {r4,lr}	; 0232AEC8
	ldr r1,[r0,#0xc]	; 0232AECA
	ldr r2,[r0,#0x8]	; 0232AECC
	cmp r2,r1	; 0232AECE
	blt loc_0232AEDA	; 0232AED0
	ldr r0,[r0,#0x4]	; 0232AED2
	pop {r4}	; 0232AED4
	pop {r3}	; 0232AED6
	bx r3	; 0232AED8
loc_0232AEDA:
	ldr r4,[r0,#0x0]	; 0232AEDA
	ldr r0,[r0,#0x4]	; 0232AEDC
	sub r0,r0,r4	; 0232AEDE
	mul r2,r0	; 0232AEE0
	add r0,r2,#0x0	; 0232AEE2
	blx P1_SignedDivMod	; 0232AEE4
	add r0,r4,r0	; 0232AEE8
	pop {r4}	; 0232AEEA
	pop {r3}	; 0232AEEC
	bx r3	; 0232AEEE

; ===== function loc_0232AEF0 =====
loc_0232AEF0:
	push {r4,r5,r6,lr}	; 0232AEF0
	add r5,r0,#0x0	; 0232AEF2
	add r4,r1,#0x0	; 0232AEF4
	add r6,r2,#0x0	; 0232AEF6
	bl loc_0232AEC8	; 0232AEF8
	str r0,[r5,#0x0]	; 0232AEFC
	str r4,[r5,#0x4]	; 0232AEFE
	str r6,[r5,#0xc]	; 0232AF00
	mov r0,#0x0	; 0232AF02
	str r0,[r5,#0x8]	; 0232AF04
	pop {r4,r5,r6}	; 0232AF06
	pop {r3}	; 0232AF08
	bx r3	; 0232AF0A

; ===== function loc_0232AF0C =====
loc_0232AF0C:
	mov r2,#0x0	; 0232AF0C
	str r2,[r0,#0x4]	; 0232AF0E
	ldr r1,[r0,#0x4]	; 0232AF10
	str r1,[r0,#0x0]	; 0232AF12
	str r2,[r0,#0xc]	; 0232AF14
	ldr r1,[r0,#0xc]	; 0232AF16
	str r1,[r0,#0x8]	; 0232AF18
	bx lr	; 0232AF1A
.arm

; ===== function loc_0232AF1C =====
loc_0232AF1C:
	stmdb sp!,{r4,r5,r6,lr}	; 0232AF1C
	mov r5,r0	; 0232AF20
	mov r4,r1	; 0232AF24
	bl P1_Arm9DisableIrqReturnPriorMask	; 0232AF28
	cmp r5,#0x0	; 0232AF2C
	beq loc_0232AF4C	; 0232AF30
	ldr r1,[pool_0232AF90]	; 0232AF34
	mvn r2,r4	; 0232AF38
	add r1,r1,#0x3000	; 0232AF3C
	ldr r3,[r1,#0xff8]	; 0232AF40
	and r2,r3,r2	; 0232AF44
	str r2,[r1,#0xff8]	; 0232AF48
loc_0232AF4C:
	bl P1_Arm9RestoreIrqMask	; 0232AF4C
	ldr r1,[pool_0232AF90]	; 0232AF50
	add r0,r1,#0x3000	; 0232AF54
	ldr r0,[r0,#0xff8]	; 0232AF58
	ands r0,r4,r0	; 0232AF5C
	ldmneia sp!,{r4,r5,r6,lr}	; 0232AF60
	bxne lr	; 0232AF64
	ldr r0,[pool_0232AF94]	; 0232AF68
	add r6,r1,r0	; 0232AF6C
	ldr r5,[pool_0232AF98]	; 0232AF70
loc_0232AF74:
	mov r0,r5	; 0232AF74
	blx loc_0232B5DC	; 0232AF78
	ldr r0,[r6,#0x0]	; 0232AF7C
	ands r0,r4,r0	; 0232AF80
	beq loc_0232AF74	; 0232AF84
	ldmia sp!,{r4,r5,r6,lr}	; 0232AF88
	bx lr	; 0232AF8C
pool_0232AF90:
loc_0232AF90:
	.word P1_DtcmRuntimeStart	; 0232AF90
pool_0232AF94:
loc_0232AF94:
	.word 0x00003FF8	; 0232AF94
pool_0232AF98:
loc_0232AF98:
	.word 0x03000000	; 0232AF98
.thumb
P1_IrqHandler_0232AF9C:
	mov r0,#0x7	; 0232AF9C
	ldr r3,[pool_0232AFA4]	; 0232AF9E
	bx r3	; 0232AFA0
	.byte 0xC0, 0x46	; 0232AFA4
pool_0232AFA4:
loc_0232AFA4:
	.word loc_0232AFFC + 1	; 0232AFA4
P1_IrqHandler_0232AFA8:
	mov r0,#0x6	; 0232AFA8
	ldr r3,[pool_0232AFB0]	; 0232AFAA
	bx r3	; 0232AFAC
	.byte 0xC0, 0x46	; 0232AFB0
pool_0232AFB0:
loc_0232AFB0:
	.word loc_0232AFFC + 1	; 0232AFB0
P1_IrqHandler_0232AFB4:
	mov r0,#0x5	; 0232AFB4
	ldr r3,[pool_0232AFBC]	; 0232AFB6
	bx r3	; 0232AFB8
	.byte 0xC0, 0x46	; 0232AFBC
pool_0232AFBC:
loc_0232AFBC:
	.word loc_0232AFFC + 1	; 0232AFBC
P1_IrqHandler_0232AFC0:
	mov r0,#0x4	; 0232AFC0
	ldr r3,[pool_0232AFC8]	; 0232AFC2
	bx r3	; 0232AFC4
	.byte 0xC0, 0x46	; 0232AFC8
pool_0232AFC8:
loc_0232AFC8:
	.word loc_0232AFFC + 1	; 0232AFC8
P1_IrqHandler_0232AFCC:
	mov r0,#0x3	; 0232AFCC
	ldr r3,[pool_0232AFD4]	; 0232AFCE
	bx r3	; 0232AFD0
	.byte 0xC0, 0x46	; 0232AFD4
pool_0232AFD4:
loc_0232AFD4:
	.word loc_0232AFFC + 1	; 0232AFD4
P1_IrqHandler_0232AFD8:
	mov r0,#0x2	; 0232AFD8
	ldr r3,[pool_0232AFE0]	; 0232AFDA
	bx r3	; 0232AFDC
	.byte 0xC0, 0x46	; 0232AFE0
pool_0232AFE0:
loc_0232AFE0:
	.word loc_0232AFFC + 1	; 0232AFE0
P1_IrqHandler_0232AFE4:
	mov r0,#0x1	; 0232AFE4
	ldr r3,[pool_0232AFEC]	; 0232AFE6
	bx r3	; 0232AFE8
	.byte 0xC0, 0x46	; 0232AFEC
pool_0232AFEC:
loc_0232AFEC:
	.word loc_0232AFFC + 1	; 0232AFEC
P1_IrqHandler_0232AFF0:
	mov r0,#0x0	; 0232AFF0
	ldr r3,[pool_0232AFF8]	; 0232AFF2
	bx r3	; 0232AFF4
	.byte 0xC0, 0x46	; 0232AFF8
pool_0232AFF8:
loc_0232AFF8:
	.word loc_0232AFFC + 1	; 0232AFF8
loc_0232AFFC:
	push {r4,r5,lr}	; 0232AFFC
	sub sp,#0x4	; 0232AFFE
	mov r5,#0x1	; 0232B000
	lsl r2,r0,#0x1	; 0232B002
	ldr r1,[pool_0232B044]	; 0232B004
	ldrh r1,[r1,r2]	; 0232B006
	lsl r5,r1	; 0232B008
	mov r1,#0xc	; 0232B00A
	add r4,r0,#0x0	; 0232B00C
	mul r4,r1	; 0232B00E
	ldr r2,[pool_0232B048]	; 0232B010
	ldr r1,[r2,r4]	; 0232B012
	mov r0,#0x0	; 0232B014
	str r0,[r2,r4]	; 0232B016
	cmp r1,#0x0	; 0232B018
	beq loc_0232B022	; 0232B01A
	ldr r0,[pool_0232B04C]	; 0232B01C
	ldr r0,[r0,r4]	; 0232B01E
	blx r1	; 0232B020
loc_0232B022:
	ldr r1,[pool_0232B050]	; 0232B022
	ldr r0,[pool_0232B054]	; 0232B024
	add r0,r1,r0	; 0232B026
	ldr r1,[r0,#0x0]	; 0232B028
	orr r1,r5	; 0232B02A
	str r1,[r0,#0x0]	; 0232B02C
	ldr r0,[pool_0232B058]	; 0232B02E
	ldr r0,[r0,r4]	; 0232B030
	cmp r0,#0x0	; 0232B032
	bne loc_0232B03C	; 0232B034
	add r0,r5,#0x0	; 0232B036
	bl loc_0232B088	; 0232B038
loc_0232B03C:
	add sp,#0x4	; 0232B03C
	pop {r4,r5}	; 0232B03E
	pop {r3}	; 0232B040
	bx r3	; 0232B042
pool_0232B044:
loc_0232B044:
	.word P1_Data_02330930	; 0232B044
pool_0232B048:
loc_0232B048:
	.word P1_BssStart + 0x26310	; 0232B048
pool_0232B04C:
loc_0232B04C:
	.word P1_BssStart + 0x26318	; 0232B04C
pool_0232B050:
loc_0232B050:
	.word 0x03000000	; 0232B050
pool_0232B054:
loc_0232B054:
	.word 0x00003FF8	; 0232B054
pool_0232B058:
loc_0232B058:
	.word P1_BssStart + 0x26314	; 0232B058
P1_IrqHandler_0232B05C:
	bx lr	; 0232B05C
	.byte 0x00, 0x00	; 0232B060

; ===== function loc_0232B060 =====
loc_0232B060:
	push {r4}	; 0232B060
	sub sp,#0x4	; 0232B062
	ldr r4,[pool_0232B080]	; 0232B064
	ldrh r3,[r4,#0x0]	; 0232B066
	mov r1,#0x0	; 0232B068
	strh r1,[r4,#0x0]	; 0232B06A
	ldr r2,[pool_0232B084]	; 0232B06C
	ldr r1,[r2,#0x0]	; 0232B06E
	str r0,[r2,#0x0]	; 0232B070
	ldrh r0,[r4,#0x0]	; 0232B072
	strh r3,[r4,#0x0]	; 0232B074
	add r0,r1,#0x0	; 0232B076
	add sp,#0x4	; 0232B078
	pop {r4}	; 0232B07A
	bx lr	; 0232B07C
	.byte 0xC0, 0x46	; 0232B080
pool_0232B080:
loc_0232B080:
	.word REG_IME	; 0232B080
pool_0232B084:
loc_0232B084:
	.word REG_IF	; 0232B084

; ===== function loc_0232B088 =====
loc_0232B088:
	push {r4,r5}	; 0232B088
	ldr r5,[pool_0232B0A8]	; 0232B08A
	ldrh r4,[r5,#0x0]	; 0232B08C
	mov r1,#0x0	; 0232B08E
	strh r1,[r5,#0x0]	; 0232B090
	ldr r3,[pool_0232B0AC]	; 0232B092
	ldr r2,[r3,#0x0]	; 0232B094
	add r1,r2,#0x0	; 0232B096
	bic r1,r0	; 0232B098
	str r1,[r3,#0x0]	; 0232B09A
	ldrh r0,[r5,#0x0]	; 0232B09C
	strh r4,[r5,#0x0]	; 0232B09E
	add r0,r2,#0x0	; 0232B0A0
	pop {r4,r5}	; 0232B0A2
	bx lr	; 0232B0A4
	.byte 0xC0, 0x46	; 0232B0A8
pool_0232B0A8:
loc_0232B0A8:
	.word REG_IME	; 0232B0A8
pool_0232B0AC:
loc_0232B0AC:
	.word REG_IE	; 0232B0AC

; ===== function loc_0232B0B0 =====
loc_0232B0B0:
	push {r4,r5}	; 0232B0B0
	ldr r5,[pool_0232B0D0]	; 0232B0B2
	ldrh r4,[r5,#0x0]	; 0232B0B4
	mov r1,#0x0	; 0232B0B6
	strh r1,[r5,#0x0]	; 0232B0B8
	ldr r3,[pool_0232B0D4]	; 0232B0BA
	ldr r2,[r3,#0x0]	; 0232B0BC
	add r1,r2,#0x0	; 0232B0BE
	orr r1,r0	; 0232B0C0
	str r1,[r3,#0x0]	; 0232B0C2
	ldrh r0,[r5,#0x0]	; 0232B0C4
	strh r4,[r5,#0x0]	; 0232B0C6
	add r0,r2,#0x0	; 0232B0C8
	pop {r4,r5}	; 0232B0CA
	bx lr	; 0232B0CC
	.byte 0xC0, 0x46	; 0232B0D0
pool_0232B0D0:
loc_0232B0D0:
	.word REG_IME	; 0232B0D0
pool_0232B0D4:
loc_0232B0D4:
	.word REG_IE	; 0232B0D4

; ===== function loc_0232B0D8 =====
loc_0232B0D8:
	push {r4}	; 0232B0D8
	sub sp,#0x4	; 0232B0DA
	ldr r4,[pool_0232B0F8]	; 0232B0DC
	ldrh r3,[r4,#0x0]	; 0232B0DE
	mov r1,#0x0	; 0232B0E0
	strh r1,[r4,#0x0]	; 0232B0E2
	ldr r2,[pool_0232B0FC]	; 0232B0E4
	ldr r1,[r2,#0x0]	; 0232B0E6
	str r0,[r2,#0x0]	; 0232B0E8
	ldrh r0,[r4,#0x0]	; 0232B0EA
	strh r3,[r4,#0x0]	; 0232B0EC
	add r0,r1,#0x0	; 0232B0EE
	add sp,#0x4	; 0232B0F0
	pop {r4}	; 0232B0F2
	bx lr	; 0232B0F4
	.byte 0xC0, 0x46	; 0232B0F8
pool_0232B0F8:
loc_0232B0F8:
	.word REG_IME	; 0232B0F8
pool_0232B0FC:
loc_0232B0FC:
	.word REG_IE	; 0232B0FC

; ===== function loc_0232B100 =====
loc_0232B100:
	push {r4,lr}	; 0232B100
	mov r3,#0xc	; 0232B102
	add r4,r0,#0x0	; 0232B104
	mul r4,r3	; 0232B106
	ldr r3,[pool_0232B128]	; 0232B108
	str r1,[r3,r4]	; 0232B10A
	ldr r1,[pool_0232B12C]	; 0232B10C
	str r2,[r1,r4]	; 0232B10E
	mov r1,#0x1	; 0232B110
	add r0,r0,#0x3	; 0232B112
	lsl r1,r0	; 0232B114
	add r0,r1,#0x0	; 0232B116
	bl loc_0232B0B0	; 0232B118
	mov r1,#0x1	; 0232B11C
	ldr r0,[pool_0232B130]	; 0232B11E
	str r1,[r0,r4]	; 0232B120
	pop {r4}	; 0232B122
	pop {r3}	; 0232B124
	bx r3	; 0232B126
pool_0232B128:
loc_0232B128:
	.word P1_BssStart + 0x26340	; 0232B128
pool_0232B12C:
loc_0232B12C:
	.word P1_BssStart + 0x26348	; 0232B12C
pool_0232B130:
loc_0232B130:
	.word P1_BssStart + 0x26344	; 0232B130

; ===== function loc_0232B134 =====
loc_0232B134:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P1_SetIrqHandlers
	push {r4,r5,r6,r7}	; 0232B134
	mov r6,#0x0	; 0232B136
	ldr r5,[pool_0232B190]	; 0232B138
	add r4,r6,#0x0	; 0232B13A
	add r2,r6,#0x0	; 0232B13C
loc_0232B13E:
	add r7,r0,#0x0	; 0232B13E
	mov r3,#0x1	; 0232B140
	and r7,r3	; 0232B142
	cmp r7,#0x0	; 0232B144
	beq loc_0232B182	; 0232B146
	add r7,r4,#0x0	; 0232B148
	cmp r6,#0x8	; 0232B14A
	blt loc_0232B160	; 0232B14C
	cmp r6,#0xb	; 0232B14E
	bgt loc_0232B160	; 0232B150
	add r3,r6,#0x0	; 0232B152
	sub r3,#0x8	; 0232B154
	mov r7,#0xc	; 0232B156
	mul r3,r7	; 0232B158
	ldr r7,[pool_0232B194]	; 0232B15A
	add r7,r7,r3	; 0232B15C
	b loc_0232B176	; 0232B15E
loc_0232B160:
	cmp r6,#0x3	; 0232B160
	blt loc_0232B174	; 0232B162
	cmp r6,#0x6	; 0232B164
	bgt loc_0232B174	; 0232B166
	add r3,r6,#0x1	; 0232B168
	mov r7,#0xc	; 0232B16A
	mul r3,r7	; 0232B16C
	ldr r7,[pool_0232B194]	; 0232B16E
	add r7,r7,r3	; 0232B170
	b loc_0232B176	; 0232B172
loc_0232B174:
	str r1,[r5,#0x0]	; 0232B174
loc_0232B176:
	cmp r7,#0x0	; 0232B176
	beq loc_0232B182	; 0232B178
	str r1,[r7,#0x0]	; 0232B17A
	str r2,[r7,#0x8]	; 0232B17C
	mov r3,#0x1	; 0232B17E
	str r3,[r7,#0x4]	; 0232B180
loc_0232B182:
	lsr r0,r0,#0x1	; 0232B182
	add r5,r5,#0x4	; 0232B184
	add r6,r6,#0x1	; 0232B186
	cmp r6,#0x16	; 0232B188
	blt loc_0232B13E	; 0232B18A
	pop {r4,r5,r6,r7}	; 0232B18C
	bx lr	; 0232B18E
.endfunc
pool_0232B190:
loc_0232B190:
	.word P1_IrqHandlers	; 0232B190
pool_0232B194:
loc_0232B194:
	.word 0x02356CD0	; 0232B194

; ===== function loc_0232B198 =====
loc_0232B198:
	mov r1,#0x0	; 0232B198
	ldr r0,[pool_0232B1A0]	; 0232B19A
	strh r1,[r0,#0x0]	; 0232B19C
	bx lr	; 0232B19E
pool_0232B1A0:
loc_0232B1A0:
	.word P1_DtcmRuntimeStart	; 0232B1A0

; ===== function loc_0232B1A4 =====
loc_0232B1A4:
	ldr r1,[pool_0232B1A8]	; 0232B1A4
	bx r1	; 0232B1A6
pool_0232B1A8:
loc_0232B1A8:
	.word loc_0232B2F0 + 1	; 0232B1A8

; ===== function loc_0232B1AC =====
loc_0232B1AC:
	ldr r1,[pool_0232B1B0]	; 0232B1AC
	bx r1	; 0232B1AE
pool_0232B1B0:
loc_0232B1B0:
	.word loc_0232B28C + 1	; 0232B1B0
.arm

; ===== function loc_0232B1B4 =====
loc_0232B1B4:
	ldr r3,[pool_0232B204]	; 0232B1B4
	ldr r1,[r3,#0x0]	; 0232B1B8
	clz r2,r1	; 0232B1BC
	cmp r2,#0x20	; 0232B1C0
	movne r0,#0x40	; 0232B1C4
	bne loc_0232B1E8	; 0232B1C8
	add r3,r3,#0x4	; 0232B1CC
	ldr r1,[r3,#0x0]	; 0232B1D0
	clz r2,r1	; 0232B1D4
	cmp r2,#0x20	; 0232B1D8
	ldr r0,[pool_0232B208]	; 0232B1DC
	bxeq lr	; 0232B1E0
	mov r0,#0x60	; 0232B1E4
loc_0232B1E8:
	add r0,r0,r2	; 0232B1E8
	mov r1,#0x80000000	; 0232B1EC
	mov r1,r1, lsr r2	; 0232B1F0
	ldr r2,[r3,#0x0]	; 0232B1F4
	bic r2,r2,r1	; 0232B1F8
	str r2,[r3,#0x0]	; 0232B1FC
	bx lr	; 0232B200
pool_0232B204:
loc_0232B204:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B204
pool_0232B208:
loc_0232B208:
	.word 0xFFFFFFFD	; 0232B208

; ===== function loc_0232B20C =====
loc_0232B20C:
	ldr r3,[pool_0232B238]	; 0232B20C
	cmp r0,#0x60	; 0232B210
	addpl r3,r3,#0x4	; 0232B214
	subpl r0,r0,#0x60	; 0232B218
	submi r0,r0,#0x40	; 0232B21C
	mov r1,#0x80000000	; 0232B220
	mov r1,r1, lsr r0	; 0232B224
	ldr r2,[r3,#0x0]	; 0232B228
	orr r2,r2,r1	; 0232B22C
	str r2,[r3,#0x0]	; 0232B230
	bx lr	; 0232B234
pool_0232B238:
loc_0232B238:
	.word 0x027FFFB0	; 0232B238
.thumb

; ===== function loc_0232B23C =====
loc_0232B23C:
	ldr r0,[pool_0232B244]	; 0232B23C
	ldr r3,[pool_0232B248]	; 0232B23E
	bx r3	; 0232B240
	.byte 0xC0, 0x46	; 0232B244
pool_0232B244:
loc_0232B244:
	.word 0x00001000	; 0232B244
pool_0232B248:
loc_0232B248:
	.word P1_Arm9BusyWaitByLoop4	; 0232B248

; ===== function loc_0232B24C =====
loc_0232B24C:
	ldrh r0,[r0,#0x4]	; 0232B24C
	bx lr	; 0232B24E
	ldr r1,[pool_0232B25C]	; 0232B250
	ldrh r2,[r1,#0x0]	; 0232B252
	ldr r0,[pool_0232B260]	; 0232B254
	orr r2,r0	; 0232B256
	strh r2,[r1,#0x0]	; 0232B258
	bx lr	; 0232B25A
pool_0232B25C:
loc_0232B25C:
	.word REG_EXMEMCNT_ARM9	; 0232B25C
pool_0232B260:
loc_0232B260:
	.word 0x00000800	; 0232B260
	ldr r1,[pool_0232B270]	; 0232B264
	ldrh r2,[r1,#0x0]	; 0232B266
	ldr r0,[pool_0232B274]	; 0232B268
	and r2,r0	; 0232B26A
	strh r2,[r1,#0x0]	; 0232B26C
	bx lr	; 0232B26E
pool_0232B270:
loc_0232B270:
	.word REG_EXMEMCNT_ARM9	; 0232B270
pool_0232B274:
loc_0232B274:
	.word 0xFFFFF7FF	; 0232B274

; ===== function loc_0232B278 =====
loc_0232B278:
	ldr r1,[pool_0232B280]	; 0232B278
	ldr r2,[pool_0232B284]	; 0232B27A
	ldr r3,[pool_0232B288]	; 0232B27C
	bx r3	; 0232B27E
pool_0232B280:
loc_0232B280:
	.word 0x027FFFE0	; 0232B280
pool_0232B284:
loc_0232B284:
	.word 0x0232B265	; 0232B284
pool_0232B288:
loc_0232B288:
	.word loc_0232B328 + 1	; 0232B288

; ===== function loc_0232B28C =====
loc_0232B28C:
	ldr r1,[pool_0232B294]	; 0232B28C
	ldr r2,[pool_0232B298]	; 0232B28E
	ldr r3,[pool_0232B29C]	; 0232B290
	bx r3	; 0232B292
pool_0232B294:
loc_0232B294:
	.word 0x027FFFE0	; 0232B294
pool_0232B298:
loc_0232B298:
	.word 0x0232B251	; 0232B298
pool_0232B29C:
loc_0232B29C:
	.word loc_0232B398 + 1	; 0232B29C

; ===== function loc_0232B2A0 =====
loc_0232B2A0:
	ldr r1,[pool_0232B2A8]	; 0232B2A0
	ldr r2,[pool_0232B2AC]	; 0232B2A2
	ldr r3,[pool_0232B2B0]	; 0232B2A4
	bx r3	; 0232B2A6
pool_0232B2A8:
loc_0232B2A8:
	.word 0x027FFFE0	; 0232B2A8
pool_0232B2AC:
loc_0232B2AC:
	.word 0x0232B265	; 0232B2AC
pool_0232B2B0:
loc_0232B2B0:
	.word loc_0232B400 + 1	; 0232B2B0
	ldr r1,[pool_0232B2C0]	; 0232B2B4
	ldrh r2,[r1,#0x0]	; 0232B2B6
	mov r0,#0x80	; 0232B2B8
	orr r2,r0	; 0232B2BA
	strh r2,[r1,#0x0]	; 0232B2BC
	bx lr	; 0232B2BE
pool_0232B2C0:
loc_0232B2C0:
	.word REG_EXMEMCNT_ARM9	; 0232B2C0
	ldr r1,[pool_0232B2D0]	; 0232B2C4
	ldrh r2,[r1,#0x0]	; 0232B2C6
	mov r0,#0x80	; 0232B2C8
	bic r2,r0	; 0232B2CA
	strh r2,[r1,#0x0]	; 0232B2CC
	bx lr	; 0232B2CE
pool_0232B2D0:
loc_0232B2D0:
	.word REG_EXMEMCNT_ARM9	; 0232B2D0

; ===== function loc_0232B2D4 =====
loc_0232B2D4:
	push {lr}	; 0232B2D4
	sub sp,#0x4	; 0232B2D6
	ldr r1,[pool_0232B2E8]	; 0232B2D8
	ldr r2,[pool_0232B2EC]	; 0232B2DA
	mov r3,#0x1	; 0232B2DC
	bl loc_0232B338	; 0232B2DE
	add sp,#0x4	; 0232B2E2
	pop {r3}	; 0232B2E4
	bx r3	; 0232B2E6
pool_0232B2E8:
loc_0232B2E8:
	.word 0x027FFFE8	; 0232B2E8
pool_0232B2EC:
loc_0232B2EC:
	.word 0x0232B2C5	; 0232B2EC

; ===== function loc_0232B2F0 =====
loc_0232B2F0:
	push {lr}	; 0232B2F0
	sub sp,#0x4	; 0232B2F2
	ldr r1,[pool_0232B304]	; 0232B2F4
	ldr r2,[pool_0232B308]	; 0232B2F6
	mov r3,#0x1	; 0232B2F8
	bl loc_0232B3A8	; 0232B2FA
	add sp,#0x4	; 0232B2FE
	pop {r3}	; 0232B300
	bx r3	; 0232B302
pool_0232B304:
loc_0232B304:
	.word 0x027FFFE8	; 0232B304
pool_0232B308:
loc_0232B308:
	.word 0x0232B2B5	; 0232B308

; ===== function loc_0232B30C =====
loc_0232B30C:
	push {lr}	; 0232B30C
	sub sp,#0x4	; 0232B30E
	ldr r1,[pool_0232B320]	; 0232B310
	ldr r2,[pool_0232B324]	; 0232B312
	mov r3,#0x1	; 0232B314
	bl loc_0232B410	; 0232B316
	add sp,#0x4	; 0232B31A
	pop {r3}	; 0232B31C
	bx r3	; 0232B31E
pool_0232B320:
loc_0232B320:
	.word 0x027FFFE8	; 0232B320
pool_0232B324:
loc_0232B324:
	.word 0x0232B2C5	; 0232B324
loc_0232B328:
	push {lr}	; 0232B328
	sub sp,#0x4	; 0232B32A
	mov r3,#0x0	; 0232B32C
	bl loc_0232B338	; 0232B32E
	add sp,#0x4	; 0232B332
	pop {r3}	; 0232B334
	bx r3	; 0232B336

; ===== function loc_0232B338 =====
loc_0232B338:
	push {r4,r5,r6,r7,lr}	; 0232B338
	sub sp,#0xc	; 0232B33A
	add r5,r0,#0x0	; 0232B33C
	add r6,r1,#0x0	; 0232B33E
	add r4,r2,#0x0	; 0232B340
	add r7,r3,#0x0	; 0232B342
	cmp r7,#0x0	; 0232B344
	beq loc_0232B350	; 0232B346
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B348
	str r0,[sp,#0x0]	; 0232B34C
	b loc_0232B356	; 0232B34E
loc_0232B350:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B350
	str r0,[sp,#0x0]	; 0232B354
loc_0232B356:
	add r0,r5,#0x0	; 0232B356
	add r1,r6,#0x0	; 0232B358
	blx loc_0232DE74	; 0232B35A
	str r0,[sp,#0x4]	; 0232B35E
	cmp r0,#0x0	; 0232B360
	bne loc_0232B36C	; 0232B362
	cmp r4,#0x0	; 0232B364
	beq loc_0232B36A	; 0232B366
	blx r4	; 0232B368
loc_0232B36A:
	strh r5,[r6,#0x4]	; 0232B36A
loc_0232B36C:
	cmp r7,#0x0	; 0232B36C
	beq loc_0232B378	; 0232B36E
	ldr r0,[sp,#0x0]	; 0232B370
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B372
	b loc_0232B37E	; 0232B376
loc_0232B378:
	ldr r0,[sp,#0x0]	; 0232B378
	blx P1_Arm9RestoreIrqMask	; 0232B37A
loc_0232B37E:
	ldr r0,[sp,#0x4]	; 0232B37E
	add sp,#0xc	; 0232B380
	pop {r4,r5,r6,r7}	; 0232B382
	pop {r3}	; 0232B384
	bx r3	; 0232B386

; ===== function loc_0232B388 =====
loc_0232B388:
	push {lr}	; 0232B388
	sub sp,#0x4	; 0232B38A
	mov r3,#0x0	; 0232B38C
	bl loc_0232B3A8	; 0232B38E
	add sp,#0x4	; 0232B392
	pop {r3}	; 0232B394
	bx r3	; 0232B396

; ===== function loc_0232B398 =====
loc_0232B398:
	push {lr}	; 0232B398
	sub sp,#0x4	; 0232B39A
	mov r3,#0x0	; 0232B39C
	bl loc_0232B3A8	; 0232B39E
	add sp,#0x4	; 0232B3A2
	pop {r3}	; 0232B3A4
	bx r3	; 0232B3A6

; ===== function loc_0232B3A8 =====
loc_0232B3A8:
	push {r4,r5,r6,r7,lr}	; 0232B3A8
	sub sp,#0x4	; 0232B3AA
	add r5,r1,#0x0	; 0232B3AC
	add r4,r2,#0x0	; 0232B3AE
	add r6,r3,#0x0	; 0232B3B0
	ldrh r1,[r5,#0x4]	; 0232B3B2
	cmp r0,r1	; 0232B3B4
	beq loc_0232B3C4	; 0232B3B6
	mov r0,#0x1	; 0232B3B8
	mvn r0,r0	; 0232B3BA
	add sp,#0x4	; 0232B3BC
	pop {r4,r5,r6,r7}	; 0232B3BE
	pop {r3}	; 0232B3C0
	bx r3	; 0232B3C2
loc_0232B3C4:
	cmp r6,#0x0	; 0232B3C4
	beq loc_0232B3D0	; 0232B3C6
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B3C8
	add r7,r0,#0x0	; 0232B3CC
	b loc_0232B3D6	; 0232B3CE
loc_0232B3D0:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B3D0
	add r7,r0,#0x0	; 0232B3D4
loc_0232B3D6:
	mov r0,#0x0	; 0232B3D6
	strh r0,[r5,#0x4]	; 0232B3D8
	cmp r4,#0x0	; 0232B3DA
	beq loc_0232B3E0	; 0232B3DC
	blx r4	; 0232B3DE
loc_0232B3E0:
	mov r0,#0x0	; 0232B3E0
	str r0,[r5,#0x0]	; 0232B3E2
	cmp r6,#0x0	; 0232B3E4
	beq loc_0232B3F0	; 0232B3E6
	add r0,r7,#0x0	; 0232B3E8
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B3EA
	b loc_0232B3F6	; 0232B3EE
loc_0232B3F0:
	add r0,r7,#0x0	; 0232B3F0
	blx P1_Arm9RestoreIrqMask	; 0232B3F2
loc_0232B3F6:
	mov r0,#0x0	; 0232B3F6
	add sp,#0x4	; 0232B3F8
	pop {r4,r5,r6,r7}	; 0232B3FA
	pop {r3}	; 0232B3FC
	bx r3	; 0232B3FE

; ===== function loc_0232B400 =====
loc_0232B400:
	push {lr}	; 0232B400
	sub sp,#0x4	; 0232B402
	mov r3,#0x0	; 0232B404
	bl loc_0232B410	; 0232B406
	add sp,#0x4	; 0232B40A
	pop {r3}	; 0232B40C
	bx r3	; 0232B40E

; ===== function loc_0232B410 =====
loc_0232B410:
	push {r4,r5,r6,r7,lr}	; 0232B410
	sub sp,#0x4	; 0232B412
	add r5,r0,#0x0	; 0232B414
	add r4,r1,#0x0	; 0232B416
	add r6,r2,#0x0	; 0232B418
	add r7,r3,#0x0	; 0232B41A
	bl loc_0232B338	; 0232B41C
	cmp r0,#0x0	; 0232B420
	ble loc_0232B438	; 0232B422
loc_0232B424:
	bl loc_0232B23C	; 0232B424
	add r0,r5,#0x0	; 0232B428
	add r1,r4,#0x0	; 0232B42A
	add r2,r6,#0x0	; 0232B42C
	add r3,r7,#0x0	; 0232B42E
	bl loc_0232B338	; 0232B430
	cmp r0,#0x0	; 0232B434
	bgt loc_0232B424	; 0232B436
loc_0232B438:
	add sp,#0x4	; 0232B438
	pop {r4,r5,r6,r7}	; 0232B43A
	pop {r3}	; 0232B43C
	bx r3	; 0232B43E

; ===== function loc_0232B440 =====
loc_0232B440:
	push {r4,lr}	; 0232B440
	sub sp,#0x8	; 0232B442
	ldr r0,[pool_0232B4B8]	; 0232B444
	ldr r1,[r0,#0x0]	; 0232B446
	cmp r1,#0x0	; 0232B448
	bne loc_0232B4AE	; 0232B44A
	mov r1,#0x1	; 0232B44C
	str r1,[r0,#0x0]	; 0232B44E
	mov r2,#0x0	; 0232B450
	ldr r1,[pool_0232B4BC]	; 0232B452
	str r2,[r1,#0x0]	; 0232B454
	mov r0,#0x7e	; 0232B456
	bl loc_0232B400	; 0232B458
	ldr r4,[pool_0232B4BC]	; 0232B45C
	ldrh r0,[r4,#0x6]	; 0232B45E
	cmp r0,#0x0	; 0232B460
	beq loc_0232B46E	; 0232B462
loc_0232B464:
	bl loc_0232B23C	; 0232B464
	ldrh r0,[r4,#0x6]	; 0232B468
	cmp r0,#0x0	; 0232B46A
	bne loc_0232B464	; 0232B46C
loc_0232B46E:
	mov r0,#0x0	; 0232B46E
	mvn r2,r0	; 0232B470
	ldr r1,[pool_0232B4C0]	; 0232B472
	str r2,[r1,#0x0]	; 0232B474
	ldr r2,[pool_0232B4C4]	; 0232B476
	ldr r1,[pool_0232B4C8]	; 0232B478
	str r2,[r1,#0x0]	; 0232B47A
	str r0,[sp,#0x0]	; 0232B47C
	ldr r0,[sp,#0x0]	; 0232B47E
	ldr r1,[pool_0232B4CC]	; 0232B480
	mov r2,#0x28	; 0232B482
	blx loc_0232DD90	; 0232B484
	ldr r2,[pool_0232B4D0]	; 0232B488
	ldrh r1,[r2,#0x0]	; 0232B48A
	ldr r0,[pool_0232B4D4]	; 0232B48C
	orr r1,r0	; 0232B48E
	strh r1,[r2,#0x0]	; 0232B490
	ldrh r1,[r2,#0x0]	; 0232B492
	mov r0,#0x80	; 0232B494
	orr r1,r0	; 0232B496
	strh r1,[r2,#0x0]	; 0232B498
	mov r0,#0x7e	; 0232B49A
	ldr r1,[pool_0232B4BC]	; 0232B49C
	mov r2,#0x0	; 0232B49E
	bl loc_0232B398	; 0232B4A0
	mov r0,#0x7f	; 0232B4A4
	ldr r1,[pool_0232B4BC]	; 0232B4A6
	mov r2,#0x0	; 0232B4A8
	bl loc_0232B400	; 0232B4AA
loc_0232B4AE:
	add sp,#0x8	; 0232B4AE
	pop {r4}	; 0232B4B0
	pop {r3}	; 0232B4B2
	bx r3	; 0232B4B4
	.byte 0xC0, 0x46	; 0232B4B8
pool_0232B4B8:
loc_0232B4B8:
	.word P1_BssStart + 0x26370	; 0232B4B8
pool_0232B4BC:
loc_0232B4BC:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 0232B4BC
pool_0232B4C0:
loc_0232B4C0:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B4C0
pool_0232B4C4:
loc_0232B4C4:
	.word 0xFFFF0000	; 0232B4C4
pool_0232B4C8:
loc_0232B4C8:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset + 0x4	; 0232B4C8
pool_0232B4CC:
loc_0232B4CC:
	.word 0x027FFFC0	; 0232B4CC
pool_0232B4D0:
loc_0232B4D0:
	.word REG_EXMEMCNT_ARM9	; 0232B4D0
pool_0232B4D4:
loc_0232B4D4:
	.word 0x00000800	; 0232B4D4

; ===== function loc_0232B4D8 =====
	push {lr}	; 0232B4D8
	sub sp,#0x4	; 0232B4DA
	blx P1_Arm9EnableIrqReturnPriorMask	; 0232B4DC
loc_0232B4E0:
	blx P1_Arm9WaitForInterrupt	; 0232B4E0
	b loc_0232B4E0	; 0232B4E4
	.byte 0x00, 0x00	; 0232B4E8

; ===== function loc_0232B4E8 =====
loc_0232B4E8:
	push {r4,r5,lr}	; 0232B4E8
	sub sp,#0x4	; 0232B4EA
	add r5,r0,#0x0	; 0232B4EC
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B4EE
	ldr r1,[pool_0232B508]	; 0232B4F2
	ldr r4,[r1,#0x10]	; 0232B4F4
	str r5,[r1,#0x10]	; 0232B4F6
	blx P1_Arm9RestoreIrqMask	; 0232B4F8
	add r0,r4,#0x0	; 0232B4FC
	add sp,#0x4	; 0232B4FE
	pop {r4,r5}	; 0232B500
	pop {r3}	; 0232B502
	bx r3	; 0232B504
	.byte 0xC0, 0x46	; 0232B508
pool_0232B508:
loc_0232B508:
	.word P1_BssStart + 0x26380	; 0232B508

; ===== function loc_0232B50C =====
loc_0232B50C:
	push {r4,r5,r6,lr}	; 0232B50C
	ldr r6,[pool_0232B570]	; 0232B50E
	ldrh r0,[r6,#0x4]	; 0232B510
	cmp r0,#0x0	; 0232B512
	bne loc_0232B51E	; 0232B514
	blx P1_Arm9GetProcessorMode	; 0232B516
	cmp r0,#0x12	; 0232B51A
	bne loc_0232B528	; 0232B51C
loc_0232B51E:
	mov r0,#0x1	; 0232B51E
	strh r0,[r6,#0x0]	; 0232B520
	pop {r4,r5,r6}	; 0232B522
	pop {r3}	; 0232B524
	bx r3	; 0232B526
loc_0232B528:
	ldr r0,[pool_0232B574]	; 0232B528
	ldr r0,[r0,#0x0]	; 0232B52A
	ldr r5,[r0,#0x0]	; 0232B52C
	bl loc_0232B57C	; 0232B52E
	add r4,r0,#0x0	; 0232B532
	cmp r5,r4	; 0232B534
	beq loc_0232B56A	; 0232B536
	cmp r4,#0x0	; 0232B538
	beq loc_0232B56A	; 0232B53A
	add r0,r5,#0x0	; 0232B53C
	blx loc_0232B8E8	; 0232B53E
	cmp r0,#0x0	; 0232B542
	bne loc_0232B56A	; 0232B544
	ldr r0,[pool_0232B578]	; 0232B546
	ldr r2,[r0,#0x0]	; 0232B548
	cmp r2,#0x0	; 0232B54A
	beq loc_0232B554	; 0232B54C
	add r0,r5,#0x0	; 0232B54E
	add r1,r4,#0x0	; 0232B550
	blx r2	; 0232B552
loc_0232B554:
	ldr r2,[r6,#0x10]	; 0232B554
	cmp r2,#0x0	; 0232B556
	beq loc_0232B560	; 0232B558
	add r0,r5,#0x0	; 0232B55A
	add r1,r4,#0x0	; 0232B55C
	blx r2	; 0232B55E
loc_0232B560:
	ldr r0,[pool_0232B570]	; 0232B560
	str r4,[r0,#0x8]	; 0232B562
	add r0,r4,#0x0	; 0232B564
	blx loc_0232B934	; 0232B566
loc_0232B56A:
	pop {r4,r5,r6}	; 0232B56A
	pop {r3}	; 0232B56C
	bx r3	; 0232B56E
pool_0232B570:
loc_0232B570:
	.word P1_BssStart + 0x26380	; 0232B570
pool_0232B574:
loc_0232B574:
	.word P1_BssStart + 0x26378	; 0232B574
pool_0232B578:
loc_0232B578:
	.word P1_BssStart + 0x26374	; 0232B578

; ===== function loc_0232B57C =====
loc_0232B57C:
	ldr r0,[pool_0232B590]	; 0232B57C
	ldr r0,[r0,#0xc]	; 0232B57E
	b loc_0232B584	; 0232B580
loc_0232B582:
	ldr r0,[r0,#0x68]	; 0232B582
loc_0232B584:
	cmp r0,#0x0	; 0232B584
	beq loc_0232B58E	; 0232B586
	ldr r1,[r0,#0x64]	; 0232B588
	cmp r1,#0x1	; 0232B58A
	bne loc_0232B582	; 0232B58C
loc_0232B58E:
	bx lr	; 0232B58E
pool_0232B590:
loc_0232B590:
	.word P1_BssStart + 0x26380	; 0232B590

; ===== function loc_0232B594 =====
loc_0232B594:
	push {r4,r5,r6,lr}	; 0232B594
	add r5,r0,#0x0	; 0232B596
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B598
	add r4,r0,#0x0	; 0232B59C
	ldrh r1,[r5,#0x0]	; 0232B59E
	cmp r1,#0x0	; 0232B5A0
	beq loc_0232B5CC	; 0232B5A2
	ldr r0,[pool_0232B5D8]	; 0232B5A4
	ldr r0,[r0,#0xc]	; 0232B5A6
	cmp r0,#0x0	; 0232B5A8
	beq loc_0232B5C4	; 0232B5AA
	mov r3,#0x1	; 0232B5AC
loc_0232B5AE:
	ldr r2,[r0,#0x6c]	; 0232B5AE
	add r6,r3,#0x0	; 0232B5B0
	lsl r6,r2	; 0232B5B2
	add r2,r1,#0x0	; 0232B5B4
	and r2,r6	; 0232B5B6
	cmp r2,#0x0	; 0232B5B8
	beq loc_0232B5BE	; 0232B5BA
	str r3,[r0,#0x64]	; 0232B5BC
loc_0232B5BE:
	ldr r0,[r0,#0x68]	; 0232B5BE
	cmp r0,#0x0	; 0232B5C0
	bne loc_0232B5AE	; 0232B5C2
loc_0232B5C4:
	mov r0,#0x0	; 0232B5C4
	strh r0,[r5,#0x0]	; 0232B5C6
	bl loc_0232B50C	; 0232B5C8
loc_0232B5CC:
	add r0,r4,#0x0	; 0232B5CC
	blx P1_Arm9RestoreIrqMask	; 0232B5CE
	pop {r4,r5,r6}	; 0232B5D2
	pop {r3}	; 0232B5D4
	bx r3	; 0232B5D6
pool_0232B5D8:
loc_0232B5D8:
	.word P1_BssStart + 0x26380	; 0232B5D8

; ===== function loc_0232B5DC =====
loc_0232B5DC:
	push {r4,r5,lr}	; 0232B5DC
	sub sp,#0x4	; 0232B5DE
	add r5,r0,#0x0	; 0232B5E0
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B5E2
	add r4,r0,#0x0	; 0232B5E6
	ldr r0,[pool_0232B618]	; 0232B5E8
	ldr r0,[r0,#0x0]	; 0232B5EA
	ldr r1,[r0,#0x0]	; 0232B5EC
	cmp r5,#0x0	; 0232B5EE
	beq loc_0232B602	; 0232B5F0
	ldrh r0,[r5,#0x0]	; 0232B5F2
	mov r3,#0x1	; 0232B5F4
	ldr r2,[r1,#0x6c]	; 0232B5F6
	lsl r3,r2	; 0232B5F8
	lsl r2,r3,#0x10	; 0232B5FA
	lsr r2,r2,#0x10	; 0232B5FC
	orr r0,r2	; 0232B5FE
	strh r0,[r5,#0x0]	; 0232B600
loc_0232B602:
	mov r0,#0x0	; 0232B602
	str r0,[r1,#0x64]	; 0232B604
	bl loc_0232B50C	; 0232B606
	add r0,r4,#0x0	; 0232B60A
	blx P1_Arm9RestoreIrqMask	; 0232B60C
	add sp,#0x4	; 0232B610
	pop {r4,r5}	; 0232B612
	pop {r3}	; 0232B614
	bx r3	; 0232B616
pool_0232B618:
loc_0232B618:
	.word P1_BssStart + 0x26378	; 0232B618
	push {r4,lr}	; 0232B61C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B61E
	ldr r0,[pool_0232B654]	; 0232B622
	ldr r0,[r0,#0x0]	; 0232B624
	ldr r4,[r0,#0x0]	; 0232B626
	add r0,r4,#0x0	; 0232B628
	bl loc_0232BA9C	; 0232B62A
	add r0,r4,#0x0	; 0232B62E
	bl loc_0232B804	; 0232B630
	mov r2,#0x0	; 0232B634
	ldr r0,[r4,#0x6c]	; 0232B636
	lsl r1,r0,#0x2	; 0232B638
	ldr r0,[pool_0232B658]	; 0232B63A
	str r2,[r0,r1]	; 0232B63C
	mov r0,#0x2	; 0232B63E
	str r0,[r4,#0x64]	; 0232B640
	add r4,#0x90	; 0232B642
	add r0,r4,#0x0	; 0232B644
	bl loc_0232B594	; 0232B646
	bl loc_0232B50C	; 0232B64A
	pop {r4}	; 0232B64E
	pop {r3}	; 0232B650
	bx r3	; 0232B652
pool_0232B654:
loc_0232B654:
	.word P1_BssStart + 0x26378	; 0232B654
pool_0232B658:
loc_0232B658:
	.word P1_BssStart + 0x26394	; 0232B658

; ===== function loc_0232B65C =====
loc_0232B65C:
	push {r4,r5,r6,r7,lr}	; 0232B65C
	sub sp,#0xc	; 0232B65E
	add r5,r0,#0x0	; 0232B660
	str r1,[sp,#0x0]	; 0232B662
	add r7,r2,#0x0	; 0232B664
	add r4,r3,#0x0	; 0232B666
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B668
	str r0,[sp,#0x4]	; 0232B66C
	bl loc_0232B868	; 0232B66E
	cmp r0,#0x0	; 0232B672
	bge loc_0232B684	; 0232B674
	ldr r0,[sp,#0x4]	; 0232B676
	blx P1_Arm9RestoreIrqMask	; 0232B678
	add sp,#0xc	; 0232B67C
	pop {r4,r5,r6,r7}	; 0232B67E
	pop {r3}	; 0232B680
	bx r3	; 0232B682
loc_0232B684:
	ldr r1,[sp,#0x24]	; 0232B684
	str r1,[r5,#0x70]	; 0232B686
	str r0,[r5,#0x6c]	; 0232B688
	mov r1,#0x0	; 0232B68A
	str r1,[r5,#0x64]	; 0232B68C
	lsl r1,r0,#0x2	; 0232B68E
	ldr r0,[pool_0232B700]	; 0232B690
	str r5,[r0,r1]	; 0232B692
	add r0,r5,#0x0	; 0232B694
	bl loc_0232B830	; 0232B696
	add r0,r5,#0x0	; 0232B69A
	add r0,#0x88	; 0232B69C
	str r4,[r0,#0x0]	; 0232B69E
	ldr r0,[sp,#0x20]	; 0232B6A0
	sub r6,r4,r0	; 0232B6A2
	add r0,r5,#0x0	; 0232B6A4
	add r0,#0x84	; 0232B6A6
	str r6,[r0,#0x0]	; 0232B6A8
	mov r1,#0x0	; 0232B6AA
	add r0,r5,#0x0	; 0232B6AC
	add r0,#0x8c	; 0232B6AE
	str r1,[r0,#0x0]	; 0232B6B0
	ldr r0,[pool_0232B704]	; 0232B6B2
	add r1,r5,#0x0	; 0232B6B4
	add r1,#0x88	; 0232B6B6
	ldr r1,[r1,#0x0]	; 0232B6B8
	sub r1,r1,#0x4	; 0232B6BA
	str r0,[r1,#0x0]	; 0232B6BC
	ldr r1,[pool_0232B708]	; 0232B6BE
	add r0,r5,#0x0	; 0232B6C0
	add r0,#0x84	; 0232B6C2
	ldr r0,[r0,#0x0]	; 0232B6C4
	str r1,[r0,#0x0]	; 0232B6C6
	add r0,r5,#0x0	; 0232B6C8
	ldr r1,[sp,#0x0]	; 0232B6CA
	sub r2,r4,#0x4	; 0232B6CC
	blx loc_0232B884	; 0232B6CE
	str r7,[r5,#0x4]	; 0232B6D2
	ldr r0,[pool_0232B70C]	; 0232B6D4
	str r0,[r5,#0x3c]	; 0232B6D6
	mov r0,#0x0	; 0232B6D8
	str r0,[sp,#0x8]	; 0232B6DA
	ldr r0,[sp,#0x8]	; 0232B6DC
	add r1,r6,#0x4	; 0232B6DE
	ldr r2,[sp,#0x20]	; 0232B6E0
	sub r2,#0x8	; 0232B6E2
	blx loc_0232DD90	; 0232B6E4
	mov r0,#0x0	; 0232B6E8
	str r0,[r5,#0x78]	; 0232B6EA
	str r0,[r5,#0x7c]	; 0232B6EC
	add r5,#0x80	; 0232B6EE
	str r0,[r5,#0x0]	; 0232B6F0
	ldr r0,[sp,#0x4]	; 0232B6F2
	blx P1_Arm9RestoreIrqMask	; 0232B6F4
	add sp,#0xc	; 0232B6F8
	pop {r4,r5,r6,r7}	; 0232B6FA
	pop {r3}	; 0232B6FC
	bx r3	; 0232B6FE
pool_0232B700:
loc_0232B700:
	.word P1_BssStart + 0x26394	; 0232B700
pool_0232B704:
loc_0232B704:
	.word 0xFDDB597D	; 0232B704
pool_0232B708:
loc_0232B708:
	.word 0x7BF9DD5B	; 0232B708
pool_0232B70C:
loc_0232B70C:
	.word 0x0232B61D	; 0232B70C

; ===== function loc_0232B710 =====
loc_0232B710:
	push {lr}	; 0232B710
	sub sp,#0xc	; 0232B712
	ldr r0,[pool_0232B7C0]	; 0232B714
	ldr r1,[r0,#0x0]	; 0232B716
	cmp r1,#0x0	; 0232B718
	bne loc_0232B7B8	; 0232B71A
	mov r1,#0x1	; 0232B71C
	str r1,[r0,#0x0]	; 0232B71E
	mov r1,#0x0	; 0232B720
	ldr r0,[pool_0232B7C4]	; 0232B722
	add r2,r1,#0x0	; 0232B724
loc_0232B726:
	str r2,[r0,#0x14]	; 0232B726
	add r0,r0,#0x4	; 0232B728
	add r1,r1,#0x1	; 0232B72A
	cmp r1,#0x10	; 0232B72C
	blt loc_0232B726	; 0232B72E
	ldr r1,[pool_0232B7C8]	; 0232B730
	ldr r0,[pool_0232B7CC]	; 0232B732
	str r1,[r0,#0x0]	; 0232B734
	mov r0,#0x10	; 0232B736
	ldr r1,[pool_0232B7D0]	; 0232B738
	str r0,[r1,#0x70]	; 0232B73A
	str r2,[r1,#0x6c]	; 0232B73C
	mov r0,#0x1	; 0232B73E
	str r0,[r1,#0x64]	; 0232B740
	str r2,[r1,#0x68]	; 0232B742
	str r2,[r1,#0x74]	; 0232B744
	ldr r0,[pool_0232B7C4]	; 0232B746
	str r1,[r0,#0x14]	; 0232B748
	str r1,[r0,#0xc]	; 0232B74A
	str r1,[r0,#0x8]	; 0232B74C
	ldr r2,[pool_0232B7D4]	; 0232B74E
	cmp r2,#0x0	; 0232B750
	bne loc_0232B75A	; 0232B752
	ldr r0,[pool_0232B7D8]	; 0232B754
	sub r3,r0,r2	; 0232B756
	b loc_0232B766	; 0232B758
loc_0232B75A:
	ldr r1,[pool_0232B7DC]	; 0232B75A
	ldr r0,[pool_0232B7E0]	; 0232B75C
	add r1,r1,r0	; 0232B75E
	ldr r0,[pool_0232B7E4]	; 0232B760
	sub r0,r1,r0	; 0232B762
	sub r3,r0,r2	; 0232B764
loc_0232B766:
	ldr r1,[pool_0232B7DC]	; 0232B766
	ldr r0,[pool_0232B7E0]	; 0232B768
	add r1,r1,r0	; 0232B76A
	ldr r0,[pool_0232B7E4]	; 0232B76C
	sub r1,r1,r0	; 0232B76E
	ldr r2,[pool_0232B7E8]	; 0232B770
	str r1,[r2,#0x8]	; 0232B772
	str r3,[r2,#0x4]	; 0232B774
	mov r0,#0x0	; 0232B776
	str r0,[r2,#0xc]	; 0232B778
	ldr r3,[pool_0232B7EC]	; 0232B77A
	sub r1,r1,#0x4	; 0232B77C
	str r3,[r1,#0x0]	; 0232B77E
	ldr r3,[pool_0232B7F0]	; 0232B780
	ldr r1,[r2,#0x4]	; 0232B782
	str r3,[r1,#0x0]	; 0232B784
	strh r0,[r2,#0x10]	; 0232B786
	mov r2,#0x10	; 0232B788
	ldr r1,[pool_0232B7C4]	; 0232B78A
	strh r2,[r1,#0x2]	; 0232B78C
	strh r0,[r1,#0x0]	; 0232B78E
	strh r0,[r1,#0x4]	; 0232B790
	ldr r2,[pool_0232B7F4]	; 0232B792
	str r1,[r2,#0x0]	; 0232B794
	bl loc_0232B4E8	; 0232B796
	mov r0,#0xc8	; 0232B79A
	str r0,[sp,#0x0]	; 0232B79C
	mov r0,#0x1f	; 0232B79E
	str r0,[sp,#0x4]	; 0232B7A0
	ldr r0,[pool_0232B7F8]	; 0232B7A2
	ldr r1,[pool_0232B7FC]	; 0232B7A4
	mov r2,#0x0	; 0232B7A6
	ldr r3,[pool_0232B800]	; 0232B7A8
	bl loc_0232B65C	; 0232B7AA
	mov r1,#0x20	; 0232B7AE
	ldr r0,[pool_0232B7F8]	; 0232B7B0
	str r1,[r0,#0x70]	; 0232B7B2
	mov r1,#0x1	; 0232B7B4
	str r1,[r0,#0x64]	; 0232B7B6
loc_0232B7B8:
	add sp,#0xc	; 0232B7B8
	pop {r3}	; 0232B7BA
	bx r3	; 0232B7BC
	.byte 0xC0, 0x46	; 0232B7C0
pool_0232B7C0:
loc_0232B7C0:
	.word P1_BssStart + 0x2637C	; 0232B7C0
pool_0232B7C4:
loc_0232B7C4:
	.word P1_BssStart + 0x26380	; 0232B7C4
pool_0232B7C8:
loc_0232B7C8:
	.word 0x02356D48	; 0232B7C8
pool_0232B7CC:
loc_0232B7CC:
	.word P1_BssStart + 0x26378	; 0232B7CC
pool_0232B7D0:
loc_0232B7D0:
	.word P1_BssStart + 0x26468	; 0232B7D0
pool_0232B7D4:
loc_0232B7D4:
	.word 0x00000000	; 0232B7D4
pool_0232B7D8:
loc_0232B7D8:
	.word 0x03000020	; 0232B7D8
pool_0232B7DC:
loc_0232B7DC:
	.word 0x03000000	; 0232B7DC
pool_0232B7E0:
loc_0232B7E0:
	.word 0x00003FC0	; 0232B7E0
pool_0232B7E4:
loc_0232B7E4:
	.word 0x00001000	; 0232B7E4
pool_0232B7E8:
loc_0232B7E8:
	.word P1_BssStart + 0x264E8	; 0232B7E8
pool_0232B7EC:
loc_0232B7EC:
	.word 0xFDDB597D	; 0232B7EC
pool_0232B7F0:
loc_0232B7F0:
	.word 0x7BF9DD5B	; 0232B7F0
pool_0232B7F4:
loc_0232B7F4:
	.word FirmwareSystemWorkAddress + SystemWorkArm9ThreadInfoOffset	; 0232B7F4
pool_0232B7F8:
loc_0232B7F8:
	.word P1_BssStart + 0x263D4	; 0232B7F8
pool_0232B7FC:
loc_0232B7FC:
	.word 0x0232B4D9	; 0232B7FC
pool_0232B800:
loc_0232B800:
	.word 0x02356F84	; 0232B800

; ===== function loc_0232B804 =====
loc_0232B804:
	ldr r1,[pool_0232B82C]	; 0232B804
	ldr r2,[r1,#0xc]	; 0232B806
	mov r1,#0x0	; 0232B808
	b loc_0232B810	; 0232B80A
loc_0232B80C:
	add r1,r2,#0x0	; 0232B80C
	ldr r2,[r2,#0x68]	; 0232B80E
loc_0232B810:
	cmp r2,#0x0	; 0232B810
	beq loc_0232B818	; 0232B812
	cmp r2,r0	; 0232B814
	bne loc_0232B80C	; 0232B816
loc_0232B818:
	cmp r1,#0x0	; 0232B818
	bne loc_0232B824	; 0232B81A
	ldr r1,[r0,#0x68]	; 0232B81C
	ldr r0,[pool_0232B82C]	; 0232B81E
	str r1,[r0,#0xc]	; 0232B820
	bx lr	; 0232B822
loc_0232B824:
	ldr r0,[r0,#0x68]	; 0232B824
	str r0,[r1,#0x68]	; 0232B826
	bx lr	; 0232B828
	.byte 0xC0, 0x46	; 0232B82C
pool_0232B82C:
loc_0232B82C:
	.word P1_BssStart + 0x26380	; 0232B82C

; ===== function loc_0232B830 =====
loc_0232B830:
	push {r4,r5}	; 0232B830
	ldr r1,[pool_0232B864]	; 0232B832
	ldr r3,[r1,#0xc]	; 0232B834
	add r5,r3,#0x0	; 0232B836
	mov r4,#0x0	; 0232B838
	b loc_0232B840	; 0232B83A
loc_0232B83C:
	add r4,r5,#0x0	; 0232B83C
	ldr r5,[r5,#0x68]	; 0232B83E
loc_0232B840:
	cmp r5,#0x0	; 0232B840
	beq loc_0232B84C	; 0232B842
	ldr r2,[r5,#0x70]	; 0232B844
	ldr r1,[r0,#0x70]	; 0232B846
	cmp r2,r1	; 0232B848
	bcc loc_0232B83C	; 0232B84A
loc_0232B84C:
	cmp r4,#0x0	; 0232B84C
	bne loc_0232B85A	; 0232B84E
	str r3,[r0,#0x68]	; 0232B850
	ldr r1,[pool_0232B864]	; 0232B852
	str r0,[r1,#0xc]	; 0232B854
	pop {r4,r5}	; 0232B856
	bx lr	; 0232B858
loc_0232B85A:
	ldr r1,[r4,#0x68]	; 0232B85A
	str r1,[r0,#0x68]	; 0232B85C
	str r0,[r4,#0x68]	; 0232B85E
	pop {r4,r5}	; 0232B860
	bx lr	; 0232B862
pool_0232B864:
loc_0232B864:
	.word P1_BssStart + 0x26380	; 0232B864

; ===== function loc_0232B868 =====
loc_0232B868:
	mov r0,#0x0	; 0232B868
	ldr r2,[pool_0232B880]	; 0232B86A
loc_0232B86C:
	ldr r1,[r2,#0x14]	; 0232B86C
	cmp r1,#0x0	; 0232B86E
	beq loc_0232B87E	; 0232B870
	add r2,r2,#0x4	; 0232B872
	add r0,r0,#0x1	; 0232B874
	cmp r0,#0x10	; 0232B876
	blt loc_0232B86C	; 0232B878
	mov r0,#0x0	; 0232B87A
	mvn r0,r0	; 0232B87C
loc_0232B87E:
	bx lr	; 0232B87E
pool_0232B880:
loc_0232B880:
	.word P1_BssStart + 0x26380	; 0232B880
.arm

; ===== function loc_0232B884 =====
loc_0232B884:
	add r1,r1,#0x4	; 0232B884
	str r1,[r0,#0x40]	; 0232B888
	str r2,[r0,#0x44]	; 0232B88C
	sub r2,r2,#0x40	; 0232B890
	str r2,[r0,#0x38]	; 0232B894
	ands r1,r1,#0x1	; 0232B898
	movne r1,#0x3f	; 0232B89C
	moveq r1,#0x1f	; 0232B8A0
	str r1,[r0,#0x0]	; 0232B8A4
	mov r1,#0x0	; 0232B8A8
	str r1,[r0,#0x4]	; 0232B8AC
	str r1,[r0,#0x8]	; 0232B8B0
	str r1,[r0,#0xc]	; 0232B8B4
	str r1,[r0,#0x10]	; 0232B8B8
	str r1,[r0,#0x14]	; 0232B8BC
	str r1,[r0,#0x18]	; 0232B8C0
	str r1,[r0,#0x1c]	; 0232B8C4
	str r1,[r0,#0x20]	; 0232B8C8
	str r1,[r0,#0x24]	; 0232B8CC
	str r1,[r0,#0x28]	; 0232B8D0
	str r1,[r0,#0x2c]	; 0232B8D4
	str r1,[r0,#0x30]	; 0232B8D8
	str r1,[r0,#0x34]	; 0232B8DC
	str r1,[r0,#0x3c]	; 0232B8E0
	bx lr	; 0232B8E4

; ===== function loc_0232B8E8 =====
loc_0232B8E8:
	stmdb sp!,{r0,lr}	; 0232B8E8
	add r0,r0,#0x48	; 0232B8EC
	ldr r1,[pool_0232B930]	; 0232B8F0
	blx r1	; 0232B8F4
	ldmia sp!,{r0,lr}	; 0232B8F8
	add r1,r0,#0x0	; 0232B8FC
	mrs r2,cpsr	; 0232B900
	str r2,[r1],#0x4	; 0232B904
	mov r0,#0xd3	; 0232B908
	msr cpsr_c,r0	; 0232B90C
	str sp,[r1,#0x40]	; 0232B910
	msr cpsr_c,r2	; 0232B914
	mov r0,#0x1	; 0232B918
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 0232B91C
	adr r0,loc_0232B930	; 0232B920
	str r0,[r1,#0x3c]	; 0232B924
	mov r0,#0x0	; 0232B928
	bx lr	; 0232B92C
pool_0232B930:
loc_0232B930:
	.word loc_0232EA08 + 1	; 0232B930

; ===== function loc_0232B934 =====
loc_0232B934:
	stmdb sp!,{r0,lr}	; 0232B934
	add r0,r0,#0x48	; 0232B938
	ldr r1,[pool_0232B974]	; 0232B93C
	blx r1	; 0232B940
	ldmia sp!,{r0,lr}	; 0232B944
	mrs r1,cpsr	; 0232B948
	bic r1,r1,#0x1f	; 0232B94C
	orr r1,r1,#0xd3	; 0232B950
	msr cpsr_c,r1	; 0232B954
	ldr r1,[r0],#0x4	; 0232B958
	msr spsr_cxsf,r1	; 0232B95C
	ldr sp,[r0,#0x40]	; 0232B960
	ldr lr,[r0,#0x3c]	; 0232B964
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 0232B968
	mov r0,r0	; 0232B96C
	subs pc,lr,#0x4	; 0232B970
pool_0232B974:
loc_0232B974:
	.word loc_0232E9C8 + 1	; 0232B974
.thumb

; ===== function loc_0232B978 =====
loc_0232B978:
	ldr r0,[pool_0232B980]	; 0232B978
	ldr r1,[pool_0232B984]	; 0232B97A
	str r0,[r1,#0x0]	; 0232B97C
	bx lr	; 0232B97E
pool_0232B980:
loc_0232B980:
	.word 0x82000001	; 0232B980
pool_0232B984:
loc_0232B984:
	.word P1_Data_02330998	; 0232B984

; ===== function loc_0232B988 =====
loc_0232B988:
	mov r0,#0x0	; 0232B988
	bx lr	; 0232B98A

; ===== function loc_0232B98C =====
loc_0232B98C:
	push {r4,r5,r6,r7,lr}	; 0232B98C
	sub sp,#0x4	; 0232B98E
	add r5,r0,#0x0	; 0232B990
	add r7,r1,#0x0	; 0232B992
	add r4,r2,#0x0	; 0232B994
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B996
	str r0,[sp,#0x0]	; 0232B99A
	ldr r0,[r5,#0x10]	; 0232B99C
	cmp r0,#0x0	; 0232B99E
	bne loc_0232B9C8	; 0232B9A0
	mov r0,#0x1	; 0232B9A2
	and r4,r0	; 0232B9A4
	add r6,r5,#0x2	; 0232B9A6
loc_0232B9A8:
	cmp r4,#0x0	; 0232B9A8
	bne loc_0232B9BC	; 0232B9AA
	ldr r0,[sp,#0x0]	; 0232B9AC
	blx P1_Arm9RestoreIrqMask	; 0232B9AE
	mov r0,#0x0	; 0232B9B2
	add sp,#0x4	; 0232B9B4
	pop {r4,r5,r6,r7}	; 0232B9B6
	pop {r3}	; 0232B9B8
	bx r3	; 0232B9BA
loc_0232B9BC:
	add r0,r6,#0x0	; 0232B9BC
	bl loc_0232B5DC	; 0232B9BE
	ldr r0,[r5,#0x10]	; 0232B9C2
	cmp r0,#0x0	; 0232B9C4
	beq loc_0232B9A8	; 0232B9C6
loc_0232B9C8:
	cmp r7,#0x0	; 0232B9C8
	beq loc_0232B9D6	; 0232B9CA
	ldr r1,[r5,#0x4]	; 0232B9CC
	ldr r0,[r5,#0xc]	; 0232B9CE
	lsl r0,r0,#0x2	; 0232B9D0
	ldr r0,[r1,r0]	; 0232B9D2
	str r0,[r7,#0x0]	; 0232B9D4
loc_0232B9D6:
	ldr r0,[r5,#0xc]	; 0232B9D6
	add r0,r0,#0x1	; 0232B9D8
	ldr r1,[r5,#0x8]	; 0232B9DA
	blx P1_SignedDivMod	; 0232B9DC
	str r1,[r5,#0xc]	; 0232B9E0
	ldr r0,[r5,#0x10]	; 0232B9E2
	sub r0,r0,#0x1	; 0232B9E4
	str r0,[r5,#0x10]	; 0232B9E6
	add r0,r5,#0x0	; 0232B9E8
	bl loc_0232B594	; 0232B9EA
	ldr r0,[sp,#0x0]	; 0232B9EE
	blx P1_Arm9RestoreIrqMask	; 0232B9F0
	mov r0,#0x1	; 0232B9F4
	add sp,#0x4	; 0232B9F6
	pop {r4,r5,r6,r7}	; 0232B9F8
	pop {r3}	; 0232B9FA
	bx r3	; 0232B9FC
	.byte 0x00, 0x00	; 0232BA00

; ===== function loc_0232BA00 =====
loc_0232BA00:
	push {r4,r5,r6,r7,lr}	; 0232BA00
	sub sp,#0x4	; 0232BA02
	add r5,r0,#0x0	; 0232BA04
	add r6,r1,#0x0	; 0232BA06
	add r4,r2,#0x0	; 0232BA08
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BA0A
	add r7,r0,#0x0	; 0232BA0E
	ldr r2,[r5,#0x10]	; 0232BA10
	ldr r1,[r5,#0x8]	; 0232BA12
	cmp r1,r2	; 0232BA14
	bgt loc_0232BA3E	; 0232BA16
	mov r0,#0x1	; 0232BA18
	and r4,r0	; 0232BA1A
loc_0232BA1C:
	cmp r4,#0x0	; 0232BA1C
	bne loc_0232BA30	; 0232BA1E
	add r0,r7,#0x0	; 0232BA20
	blx P1_Arm9RestoreIrqMask	; 0232BA22
	mov r0,#0x0	; 0232BA26
	add sp,#0x4	; 0232BA28
	pop {r4,r5,r6,r7}	; 0232BA2A
	pop {r3}	; 0232BA2C
	bx r3	; 0232BA2E
loc_0232BA30:
	add r0,r5,#0x0	; 0232BA30
	bl loc_0232B5DC	; 0232BA32
	ldr r2,[r5,#0x10]	; 0232BA36
	ldr r1,[r5,#0x8]	; 0232BA38
	cmp r1,r2	; 0232BA3A
	ble loc_0232BA1C	; 0232BA3C
loc_0232BA3E:
	ldr r0,[r5,#0xc]	; 0232BA3E
	add r0,r0,r2	; 0232BA40
	blx P1_SignedDivMod	; 0232BA42
	ldr r2,[r5,#0x4]	; 0232BA46
	lsl r0,r1,#0x2	; 0232BA48
	str r6,[r2,r0]	; 0232BA4A
	ldr r0,[r5,#0x10]	; 0232BA4C
	add r0,r0,#0x1	; 0232BA4E
	str r0,[r5,#0x10]	; 0232BA50
	add r0,r5,#0x2	; 0232BA52
	bl loc_0232B594	; 0232BA54
	add r0,r7,#0x0	; 0232BA58
	blx P1_Arm9RestoreIrqMask	; 0232BA5A
	mov r0,#0x1	; 0232BA5E
	add sp,#0x4	; 0232BA60
	pop {r4,r5,r6,r7}	; 0232BA62
	pop {r3}	; 0232BA64
	bx r3	; 0232BA66
P1_Entry_0232BA68:
	mov r3,#0x0	; 0232BA68
	strh r3,[r0,#0x0]	; 0232BA6A
	strh r3,[r0,#0x2]	; 0232BA6C
	str r1,[r0,#0x4]	; 0232BA6E
	str r2,[r0,#0x8]	; 0232BA70
	str r3,[r0,#0xc]	; 0232BA72
	str r3,[r0,#0x10]	; 0232BA74
	bx lr	; 0232BA76

; ===== function loc_0232BA78 =====
loc_0232BA78:
	push {r4}	; 0232BA78
	sub sp,#0x4	; 0232BA7A
	ldr r4,[r0,#0x7c]	; 0232BA7C
	ldr r3,[r4,#0x10]	; 0232BA7E
	cmp r3,#0x0	; 0232BA80
	bne loc_0232BA8E	; 0232BA82
	mov r2,#0x0	; 0232BA84
	add r1,r0,#0x0	; 0232BA86
	add r1,#0x80	; 0232BA88
	str r2,[r1,#0x0]	; 0232BA8A
	b loc_0232BA92	; 0232BA8C
loc_0232BA8E:
	mov r1,#0x0	; 0232BA8E
	str r1,[r3,#0xc]	; 0232BA90
loc_0232BA92:
	str r3,[r0,#0x7c]	; 0232BA92
	add r0,r4,#0x0	; 0232BA94
	add sp,#0x4	; 0232BA96
	pop {r4}	; 0232BA98
	bx lr	; 0232BA9A

; ===== function loc_0232BA9C =====
loc_0232BA9C:
	push {r4,r5,lr}	; 0232BA9C
	sub sp,#0x4	; 0232BA9E
	add r5,r0,#0x0	; 0232BAA0
	ldr r0,[r5,#0x7c]	; 0232BAA2
	cmp r0,#0x0	; 0232BAA4
	beq loc_0232BABE	; 0232BAA6
	mov r4,#0x0	; 0232BAA8
loc_0232BAAA:
	add r0,r5,#0x0	; 0232BAAA
	bl loc_0232BA78	; 0232BAAC
	str r4,[r0,#0x8]	; 0232BAB0
	str r4,[r0,#0x4]	; 0232BAB2
	bl loc_0232B594	; 0232BAB4
	ldr r0,[r5,#0x7c]	; 0232BAB8
	cmp r0,#0x0	; 0232BABA
	bne loc_0232BAAA	; 0232BABC
loc_0232BABE:
	add sp,#0x4	; 0232BABE
	pop {r4,r5}	; 0232BAC0
	pop {r3}	; 0232BAC2
	bx r3	; 0232BAC4
	.byte 0x00, 0x00	; 0232BAC8

; ===== function loc_0232BAC8 =====
loc_0232BAC8:
	mov r1,#0x0	; 0232BAC8
	strh r1,[r0,#0x0]	; 0232BACA
	str r1,[r0,#0x4]	; 0232BACC
	str r1,[r0,#0x8]	; 0232BACE
	bx lr	; 0232BAD0
	.byte 0x00, 0x00	; 0232BAD4
.arm

; ===== function loc_0232BAD4 =====
; 以 ARM946 cache index 遍历并清理整个 D-cache。
; Cleans the entire ARM946 D-cache by cache index.
.func P1_CleanEntireDataCacheByIndex
loc_0232BAD4:
	mov r1,#0x0	; 0232BAD4
loc_0232BAD8:
	mov r0,#0x0	; 0232BAD8
loc_0232BADC:
	orr r2,r1,r0	; 0232BADC
	mcr p15,0x0,r2,c7,c10,0x2	; 0232BAE0
	add r0,r0,#0x20	; 0232BAE4
	cmp r0,#0x400	; 0232BAE8
	blt loc_0232BADC	; 0232BAEC
	add r1,r1,#0x40000000	; 0232BAF0
	cmp r1,#0x0	; 0232BAF4
	bne loc_0232BAD8	; 0232BAF8
	bx lr	; 0232BAFC

.endfunc

; ===== function loc_0232BB00 =====
; 以 ARM946 cache index 遍历，清理并失效整个 D-cache。
; Cleans and invalidates the entire ARM946 D-cache by cache index.
.func P1_CleanAndInvalidateEntireDataCacheByIndex
loc_0232BB00:
	mov r1,#0x0	; 0232BB00
loc_0232BB04:
	mov r0,#0x0	; 0232BB04
loc_0232BB08:
	orr r2,r1,r0	; 0232BB08
	mcr p15,0x0,r2,c7,c14,0x2	; 0232BB0C
	add r0,r0,#0x20	; 0232BB10
	cmp r0,#0x400	; 0232BB14
	blt loc_0232BB08	; 0232BB18
	add r1,r1,#0x40000000	; 0232BB1C
	cmp r1,#0x0	; 0232BB20
	bne loc_0232BB04	; 0232BB24
	bx lr	; 0232BB28

.endfunc

; ===== function loc_0232BB2C =====
; 按 ARM946 32 字节 cache line 失效指定的 D-cache 地址范围。
; Invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_InvalidateDataCacheRange
loc_0232BB2C:
	add r1,r1,r0	; 0232BB2C
	bic r0,r0,#0x1f	; 0232BB30
loc_0232BB34:
	mcr p15,0x0,r0,c7,c6,0x1	; 0232BB34
	add r0,r0,#0x20	; 0232BB38
	cmp r0,r1	; 0232BB3C
	blt loc_0232BB34	; 0232BB40
	bx lr	; 0232BB44

.endfunc

; ===== function loc_0232BB48 =====
; 按 ARM946 32 字节 cache line 清理指定的 D-cache 地址范围。
; Cleans a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanDataCacheRange
loc_0232BB48:
	add r1,r1,r0	; 0232BB48
	bic r0,r0,#0x1f	; 0232BB4C
loc_0232BB50:
	mcr p15,0x0,r0,c7,c10,0x1	; 0232BB50
	add r0,r0,#0x20	; 0232BB54
	cmp r0,r1	; 0232BB58
	blt loc_0232BB50	; 0232BB5C
	bx lr	; 0232BB60

.endfunc

; ===== function loc_0232BB64 =====
; 按 ARM946 32 字节 cache line 清理并失效指定的 D-cache 地址范围。
; Cleans and invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanAndInvalidateDataCacheRange
loc_0232BB64:
	add r1,r1,r0	; 0232BB64
	bic r0,r0,#0x1f	; 0232BB68
loc_0232BB6C:
	mcr p15,0x0,r0,c7,c14,0x1	; 0232BB6C
	add r0,r0,#0x20	; 0232BB70
	cmp r0,r1	; 0232BB74
	blt loc_0232BB6C	; 0232BB78
	bx lr	; 0232BB7C
.endfunc
.arm
; 排空 ARM946 写缓冲区，确保先前存储操作完成。
; Drains the ARM946 write buffer so prior stores complete.
.func P1_DrainWriteBuffer
loc_0232BB80:
	mov r0,#0x0	; 0232BB80
	mcr p15,0x0,r0,c7,c10,0x4	; 0232BB84
	bx lr	; 0232BB88
.endfunc
.thumb

; ===== function loc_0232BB8C =====
loc_0232BB8C:
	push {lr}	; 0232BB8C
	sub sp,#0x4	; 0232BB8E
	bl loc_0232BCB4	; 0232BB90
	bl loc_0232E728	; 0232BB94
	bl loc_0232B440	; 0232BB98
	bl loc_0232BCB0	; 0232BB9C
	bl loc_0232B198	; 0232BBA0
	bl P1_InitExceptionHandler	; 0232BBA4
	mov r0,#0x3	; 0232BBA8
	bl loc_0232DC8C	; 0232BBAA
	bl loc_0232C3AC	; 0232BBAE
	bl loc_0232B710	; 0232BBB2
	bl loc_0232C6D8	; 0232BBB6
	bl loc_0232F3F8	; 0232BBBA
	add sp,#0x4	; 0232BBBE
	pop {r3}	; 0232BBC0
	bx r3	; 0232BBC2

; ===== function loc_0232BBC4 =====
loc_0232BBC4:
	lsl r2,r0,#0x2	; 0232BBC4
	ldr r0,[pool_0232BBCC]	; 0232BBC6
	str r1,[r2,r0]	; 0232BBC8
	bx lr	; 0232BBCA
pool_0232BBCC:
loc_0232BBCC:
	.word 0x027FFDA0	; 0232BBCC

; ===== function loc_0232BBD0 =====
loc_0232BBD0:
	lsl r2,r0,#0x2	; 0232BBD0
	ldr r0,[pool_0232BBD8]	; 0232BBD2
	str r1,[r2,r0]	; 0232BBD4
	bx lr	; 0232BBD6
pool_0232BBD8:
loc_0232BBD8:
	.word 0x027FFDC4	; 0232BBD8

; ===== function loc_0232BBDC =====
loc_0232BBDC:
	cmp r0,#0x6	; 0232BBDC
	bhi loc_0232BC14	; 0232BBDE
	add r0,r0,r0	; 0232BBE0
P1_SwitchIndexPC_0232BBE0:
	add r0,pc	; 0232BBE2
	ldrh r0,[r0,#(P1_SwitchTable_0232BBE0 - (P1_SwitchIndexPC_0232BBE0 + 4))]	; 0232BBE4
	lsl r0,r0,#0x10	; 0232BBE6
	asr r0,r0,#0x10	; 0232BBE8
P1_SwitchTargetPC_0232BBE0:
	add r0,pc	; 0232BBEA
	bx r0	; 0232BBEC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232BBE0:
	.halfword (loc_0232BBFC + 1) - (P1_SwitchTargetPC_0232BBE0 + 4)
	.halfword (loc_0232BC14 + 1) - (P1_SwitchTargetPC_0232BBE0 + 4)
	.halfword (loc_0232BC00 + 1) - (P1_SwitchTargetPC_0232BBE0 + 4)
	.halfword (loc_0232BC04 + 1) - (P1_SwitchTargetPC_0232BBE0 + 4)
	.halfword (loc_0232BC08 + 1) - (P1_SwitchTargetPC_0232BBE0 + 4)
	.halfword (loc_0232BC0C + 1) - (P1_SwitchTargetPC_0232BBE0 + 4)
	.halfword (loc_0232BC10 + 1) - (P1_SwitchTargetPC_0232BBE0 + 4)
P1_SwitchTable_0232BBE0End:
loc_0232BBFC:
	ldr r0,[pool_0232BC18]	; 0232BBFC
	bx lr	; 0232BBFE
loc_0232BC00:
	mov r0,#0x0	; 0232BC00
	bx lr	; 0232BC02
loc_0232BC04:
	ldr r0,[pool_0232BC1C]	; 0232BC04
	bx lr	; 0232BC06
loc_0232BC08:
	ldr r0,[pool_0232BC20]	; 0232BC08
	bx lr	; 0232BC0A
loc_0232BC0C:
	ldr r0,[pool_0232BC24]	; 0232BC0C
	bx lr	; 0232BC0E
loc_0232BC10:
	ldr r0,[pool_0232BC28]	; 0232BC10
	bx lr	; 0232BC12
loc_0232BC14:
	mov r0,#0x0	; 0232BC14
	bx lr	; 0232BC16
pool_0232BC18:
loc_0232BC18:
	.word 0x023E9360	; 0232BC18
pool_0232BC1C:
loc_0232BC1C:
	.word 0x01FF8320	; 0232BC1C
pool_0232BC20:
loc_0232BC20:
	.word 0x03000020	; 0232BC20
pool_0232BC24:
loc_0232BC24:
	.word 0x027FF000	; 0232BC24
pool_0232BC28:
loc_0232BC28:
	.word 0x037F8000	; 0232BC28

; ===== function loc_0232BC2C =====
loc_0232BC2C:
	cmp r0,#0x6	; 0232BC2C
	bhi loc_0232BC86	; 0232BC2E
	add r0,r0,r0	; 0232BC30
P1_SwitchIndexPC_0232BC30:
	add r0,pc	; 0232BC32
	ldrh r0,[r0,#(P1_SwitchTable_0232BC30 - (P1_SwitchIndexPC_0232BC30 + 4))]	; 0232BC34
	lsl r0,r0,#0x10	; 0232BC36
	asr r0,r0,#0x10	; 0232BC38
P1_SwitchTargetPC_0232BC30:
	add r0,pc	; 0232BC3A
	bx r0	; 0232BC3C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232BC30:
	.halfword (loc_0232BC4C + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC86 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC50 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC54 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC58 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC7E + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC82 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
P1_SwitchTable_0232BC30End:
loc_0232BC4C:
	ldr r0,[pool_0232BC8C]	; 0232BC4C
	bx lr	; 0232BC4E
loc_0232BC50:
	mov r0,#0x0	; 0232BC50
	bx lr	; 0232BC52
loc_0232BC54:
	ldr r0,[pool_0232BC90]	; 0232BC54
	bx lr	; 0232BC56
loc_0232BC58:
	ldr r0,[pool_0232BC94]	; 0232BC58
	ldr r1,[pool_0232BC98]	; 0232BC5A
	add r2,r0,r1	; 0232BC5C
	ldr r1,[pool_0232BC9C]	; 0232BC5E
	sub r2,r2,r1	; 0232BC60
	ldr r1,[pool_0232BCA0]	; 0232BC62
	cmp r1,#0x0	; 0232BC64
	bne loc_0232BC72	; 0232BC66
	ldr r1,[pool_0232BCA4]	; 0232BC68
	cmp r0,r1	; 0232BC6A
	bcs loc_0232BC88	; 0232BC6C
	add r0,r1,#0x0	; 0232BC6E
	bx lr	; 0232BC70
loc_0232BC72:
	cmp r1,#0x0	; 0232BC72
	bge loc_0232BC7A	; 0232BC74
	sub r0,r0,r1	; 0232BC76
	bx lr	; 0232BC78
loc_0232BC7A:
	sub r0,r2,r1	; 0232BC7A
	bx lr	; 0232BC7C
loc_0232BC7E:
	ldr r0,[pool_0232BCA8]	; 0232BC7E
	bx lr	; 0232BC80
loc_0232BC82:
	ldr r0,[pool_0232BCAC]	; 0232BC82
	bx lr	; 0232BC84
loc_0232BC86:
	mov r0,#0x0	; 0232BC86
loc_0232BC88:
	bx lr	; 0232BC88
	.byte 0xC0, 0x46	; 0232BC8C
pool_0232BC8C:
loc_0232BC8C:
	.word 0x023C0000	; 0232BC8C
pool_0232BC90:
loc_0232BC90:
	.word 0x02000000	; 0232BC90
pool_0232BC94:
loc_0232BC94:
	.word 0x03000000	; 0232BC94
pool_0232BC98:
loc_0232BC98:
	.word 0x00003F80	; 0232BC98
pool_0232BC9C:
loc_0232BC9C:
	.word 0x00001000	; 0232BC9C
pool_0232BCA0:
loc_0232BCA0:
	.word 0x00000000	; 0232BCA0
pool_0232BCA4:
loc_0232BCA4:
	.word 0x03000020	; 0232BCA4
pool_0232BCA8:
loc_0232BCA8:
	.word 0x027FF800	; 0232BCA8
pool_0232BCAC:
loc_0232BCAC:
	.word 0x037F8000	; 0232BCAC

; ===== function loc_0232BCB0 =====
loc_0232BCB0:
	bx lr	; 0232BCB0
	.byte 0x00, 0x00	; 0232BCB4

; ===== function loc_0232BCB4 =====
loc_0232BCB4:
	push {lr}	; 0232BCB4
	sub sp,#0x4	; 0232BCB6
	ldr r0,[pool_0232BCF8]	; 0232BCB8
	ldr r1,[r0,#0x0]	; 0232BCBA
	cmp r1,#0x0	; 0232BCBC
	bne loc_0232BCF2	; 0232BCBE
	mov r1,#0x1	; 0232BCC0
	str r1,[r0,#0x0]	; 0232BCC2
	mov r0,#0x0	; 0232BCC4
	bl loc_0232BCFC	; 0232BCC6
	mov r0,#0x2	; 0232BCCA
	mov r1,#0x0	; 0232BCCC
	bl loc_0232BBC4	; 0232BCCE
	mov r0,#0x2	; 0232BCD2
	mov r1,#0x0	; 0232BCD4
	bl loc_0232BBD0	; 0232BCD6
	mov r0,#0x3	; 0232BCDA
	bl loc_0232BCFC	; 0232BCDC
	mov r0,#0x4	; 0232BCE0
	bl loc_0232BCFC	; 0232BCE2
	mov r0,#0x5	; 0232BCE6
	bl loc_0232BCFC	; 0232BCE8
	mov r0,#0x6	; 0232BCEC
	bl loc_0232BCFC	; 0232BCEE
loc_0232BCF2:
	add sp,#0x4	; 0232BCF2
	pop {r3}	; 0232BCF4
	bx r3	; 0232BCF6
pool_0232BCF8:
loc_0232BCF8:
	.word P1_BssStart + 0x265C4	; 0232BCF8

; ===== function loc_0232BCFC =====
loc_0232BCFC:
	push {r4,lr}	; 0232BCFC
	add r4,r0,#0x0	; 0232BCFE
	bl loc_0232BC2C	; 0232BD00
	add r1,r0,#0x0	; 0232BD04
	add r0,r4,#0x0	; 0232BD06
	bl loc_0232BBD0	; 0232BD08
	add r0,r4,#0x0	; 0232BD0C
	bl loc_0232BBDC	; 0232BD0E
	add r1,r0,#0x0	; 0232BD12
	add r0,r4,#0x0	; 0232BD14
	bl loc_0232BBC4	; 0232BD16
	pop {r4}	; 0232BD1A
	pop {r3}	; 0232BD1C
	bx r3	; 0232BD1E
.arm

; ===== function loc_0232BD20 =====
; Sets CP15 control-register c1 bit 0. / 置位 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9SetCp15ControlBit0
loc_0232BD20:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BD20
	orr r0,r0,#0x1	; 0232BD24
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BD28
	bx lr	; 0232BD2C
.endfunc

; ===== function loc_0232BD30 =====
; Clears CP15 control-register c1 bit 0. / 清除 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9ClearCp15ControlBit0
loc_0232BD30:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BD30
	bic r0,r0,#0x1	; 0232BD34
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BD38
	bx lr	; 0232BD3C
.endfunc
; 链接既有调试入口；保存现场后处理 abort/undef，最后停在等待循环。
; Chain the saved debug handler; process abort/undef context, then stop in a wait loop.
.func P1_ExceptionEntry
	ldr r12,[pool_0232BDAC]	; 0232BD40
	ldr r12,[r12,#0x0]	; 0232BD44
	cmp r12,#0x0	; 0232BD48
	movne lr,pc	; 0232BD4C
	bxne r12	; 0232BD50
	ldr r12,[pool_0232BDB0]	; 0232BD54
	stmdb r12!,{r0,r1,r2,r3,sp,lr}	; 0232BD58
	and r0,sp,#0x1	; 0232BD5C
	mov sp,r12	; 0232BD60
	mrs r1,cpsr	; 0232BD64
	and r1,r1,#0x1f	; 0232BD68
	teq r1,#0x17	; 0232BD6C
	bne loc_0232BD7C	; 0232BD70
	bl P1_ProcessException	; 0232BD74
	b loc_0232BD88	; 0232BD78
loc_0232BD7C:
	teq r1,#0x1b	; 0232BD7C
	bne loc_0232BD88	; 0232BD80
	bl P1_ProcessException	; 0232BD84
loc_0232BD88:
	ldr r12,[pool_0232BDAC]	; 0232BD88
	ldr r12,[r12,#0x0]	; 0232BD8C
	cmp r12,#0x0	; 0232BD90
loc_0232BD94:
	beq loc_0232BD94	; 0232BD94
loc_0232BD98:
	mov r0,r0	; 0232BD98
	b loc_0232BD98	; 0232BD9C
.endfunc
	.byte 0x0F, 0x50, 0xBD, 0xE8, 0x0C, 0xD0, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1	; 0232BDAC
pool_0232BDAC:
loc_0232BDAC:
	.word P1_PreviousExceptionHandler	; 0232BDAC
pool_0232BDB0:
loc_0232BDB0:
	.word P1_ExceptionStackTop	; 0232BDB0

; ===== function loc_0232BDB4 =====
loc_0232BDB4:
; 先保存异常现场，再调用已注册的用户处理器。
; Save exception context, then invoke the registered user handler.
.func P1_ProcessException
	stmdb sp!,{lr}	; 0232BDB4
	bl P1_SaveExceptionContext	; 0232BDB8
	bl P1_CallUserExceptionHandler	; 0232BDBC
	ldmia sp!,{lr}	; 0232BDC0
	bx lr	; 0232BDC4
.endfunc

; ===== function loc_0232BDC8 =====
loc_0232BDC8:
; 收集通用寄存器、异常栈与各模式的状态，写入 BSS 上下文。
; Collect registers, exception-stack data and mode state into the BSS context.
.func P1_SaveExceptionContext
	ldr r1,[pool_0232BE54]	; 0232BDC8
	mrs r2,cpsr	; 0232BDCC
	str r2,[r1,#0x74]	; 0232BDD0
	str r0,[r1,#0x6c]	; 0232BDD4
	ldr r0,[r12,#0x0]	; 0232BDD8
	str r0,[r1,#0x4]	; 0232BDDC
	ldr r0,[r12,#0x4]	; 0232BDE0
	str r0,[r1,#0x8]	; 0232BDE4
	ldr r0,[r12,#0x8]	; 0232BDE8
	str r0,[r1,#0xc]	; 0232BDEC
	ldr r0,[r12,#0xc]	; 0232BDF0
	str r0,[r1,#0x10]	; 0232BDF4
	ldr r2,[r12,#0x10]	; 0232BDF8
	bic r2,r2,#0x1	; 0232BDFC
	add r0,r1,#0x14	; 0232BE00
	stmia r0,{r4,r5,r6,r7,r8,r9,r10,r11}	; 0232BE04
	str r12,[r1,#0x70]	; 0232BE08
	ldr r0,[r2,#0x0]	; 0232BE0C
	str r0,[r1,#0x64]	; 0232BE10
	ldr r3,[r2,#0x4]	; 0232BE14
	str r3,[r1,#0x0]	; 0232BE18
	ldr r0,[r2,#0x8]	; 0232BE1C
	str r0,[r1,#0x34]	; 0232BE20
	ldr r0,[r2,#0xc]	; 0232BE24
	str r0,[r1,#0x40]	; 0232BE28
	mrs r0,cpsr	; 0232BE2C
	orr r3,r3,#0x80	; 0232BE30
	bic r3,r3,#0x20	; 0232BE34
	msr cpsr_cxsf,r3	; 0232BE38
	str sp,[r1,#0x38]	; 0232BE3C
	str lr,[r1,#0x3c]	; 0232BE40
	mrs r2,spsr	; 0232BE44
	str r2,[r1,#0x7c]	; 0232BE48
	msr cpsr_cxsf,r0	; 0232BE4C
	bx lr	; 0232BE50
.endfunc
pool_0232BE54:
loc_0232BE54:
	.word P1_ExceptionContext	; 0232BE54

; ===== function loc_0232BE58 =====
loc_0232BE58:
; 若已注册，临时启用保护单元并以现场/参数调用用户回调。
; If registered, enable the MPU for the user callback with context and argument.
.func P1_CallUserExceptionHandler
	stmdb sp!,{lr}	; 0232BE58
	sub sp,sp,#0x4	; 0232BE5C
	ldr r0,[pool_0232BEB4]	; 0232BE60
	ldr r0,[r0,#0x0]	; 0232BE64
	cmp r0,#0x0	; 0232BE68
	addeq sp,sp,#0x4	; 0232BE6C
	ldmeqia sp!,{lr}	; 0232BE70
	bxeq lr	; 0232BE74
	mov r0,sp	; 0232BE78
	ldr r1,[pool_0232BEB8]	; 0232BE7C
	msr cpsr_cxsf,r1	; 0232BE80
	mov sp,r0	; 0232BE84
	bl P1_Arm9SetCp15ControlBit0	; 0232BE88
	ldr r1,[pool_0232BEBC]	; 0232BE8C
	ldr r0,[pool_0232BEB4]	; 0232BE90
	ldr r1,[r1,#0x0]	; 0232BE94
	ldr r2,[r0,#0x0]	; 0232BE98
	ldr r0,[pool_0232BEC0]	; 0232BE9C
	blx r2	; 0232BEA0
	bl P1_Arm9ClearCp15ControlBit0	; 0232BEA4
	add sp,sp,#0x4	; 0232BEA8
	ldmia sp!,{lr}	; 0232BEAC
	bx lr	; 0232BEB0
.endfunc
pool_0232BEB4:
loc_0232BEB4:
	.word P1_UserExceptionHandler	; 0232BEB4
pool_0232BEB8:
loc_0232BEB8:
	.word 0x0000009F	; 0232BEB8
pool_0232BEBC:
loc_0232BEBC:
	.word P1_UserExceptionArgument	; 0232BEBC
pool_0232BEC0:
loc_0232BEC0:
	.word P1_ExceptionContext	; 0232BEC0
.thumb

; ===== function loc_0232BEC4 =====
loc_0232BEC4:
; 检查既有调试入口；需要时同时安装 BIOS 向量和 DTCM 中的入口副本。
; Check the saved debug entry; install the BIOS vector and DTCM copy when required.
.func P1_InitExceptionHandler
	push {lr}	; 0232BEC4
	sub sp,#0x4	; 0232BEC6
	ldr r0,[pool_0232BF10]	; 0232BEC8
	ldr r1,[r0,#0x0]	; 0232BECA
	ldr r0,[pool_0232BF14]	; 0232BECC
	cmp r1,r0	; 0232BECE
	bcc loc_0232BEDE	; 0232BED0
	ldr r0,[pool_0232BF18]	; 0232BED2
	cmp r1,r0	; 0232BED4
	bcs loc_0232BEDE	; 0232BED6
	ldr r0,[pool_0232BF1C]	; 0232BED8
	str r1,[r0,#0x0]	; 0232BEDA
	b loc_0232BEE4	; 0232BEDC
loc_0232BEDE:
	mov r1,#0x0	; 0232BEDE
	ldr r0,[pool_0232BF1C]	; 0232BEE0
	str r1,[r0,#0x0]	; 0232BEE2
loc_0232BEE4:
	ldr r0,[pool_0232BF1C]	; 0232BEE4
	ldr r0,[r0,#0x0]	; 0232BEE6
	cmp r0,#0x0	; 0232BEE8
	beq loc_0232BEF8	; 0232BEEA
	bl loc_0232B978	; 0232BEEC
	ldr r1,[pool_0232BF20]	; 0232BEF0
	and r0,r1	; 0232BEF2
	cmp r0,#0x0	; 0232BEF4
	bne loc_0232BF02	; 0232BEF6
loc_0232BEF8:
	ldr r1,[pool_0232BF24]	; 0232BEF8
	ldr r0,[pool_0232BF10]	; 0232BEFA
	str r1,[r0,#0x0]	; 0232BEFC
	ldr r0,[pool_0232BF28]	; 0232BEFE
	str r1,[r0,#0x5c]	; 0232BF00
loc_0232BF02:
	mov r1,#0x0	; 0232BF02
	ldr r0,[pool_0232BF2C]	; 0232BF04
	str r1,[r0,#0x0]	; 0232BF06
	add sp,#0x4	; 0232BF08
	pop {r3}	; 0232BF0A
	bx r3	; 0232BF0C
.endfunc
	.byte 0xC0, 0x46	; 0232BF10
pool_0232BF10:
loc_0232BF10:
	.word Bios9DebugVectorAddress	; 0232BF10
pool_0232BF14:
loc_0232BF14:
	.word 0x02600000	; 0232BF14
pool_0232BF18:
loc_0232BF18:
	.word 0x02800000	; 0232BF18
pool_0232BF1C:
loc_0232BF1C:
	.word P1_PreviousExceptionHandler	; 0232BF1C
pool_0232BF20:
loc_0232BF20:
	.word 0x40000000	; 0232BF20
pool_0232BF24:
loc_0232BF24:
	.word P1_ExceptionEntry	; 0232BF24
pool_0232BF28:
loc_0232BF28:
	.word P1_DtcmExceptionVector - 0x5C	; 0232BF28
pool_0232BF2C:
loc_0232BF2C:
	.word P1_UserExceptionHandler	; 0232BF2C

; ===== function loc_0232BF30 =====
loc_0232BF30:
	ldr r1,[pool_0232BF40]	; 0232BF30
	ldrh r3,[r1,#0x0]	; 0232BF32
	mov r2,#0x1	; 0232BF34
	lsl r2,r0	; 0232BF36
	orr r3,r2	; 0232BF38
	strh r3,[r1,#0x0]	; 0232BF3A
	bx lr	; 0232BF3C
	.byte 0xC0, 0x46	; 0232BF40
pool_0232BF40:
loc_0232BF40:
	.word P1_BssStart + 0x26654	; 0232BF40

; ===== function loc_0232BF44 =====
loc_0232BF44:
	push {r4,r5,lr}	; 0232BF44
	sub sp,#0xc	; 0232BF46
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BF48
	ldr r1,[pool_0232BFAC]	; 0232BF4C
	ldrh r1,[r1,#0x0]	; 0232BF4E
	add r3,sp,#0x0	; 0232BF50
	strh r1,[r3,#0x0]	; 0232BF52
	ldr r1,[pool_0232BFB0]	; 0232BF54
	ldr r5,[r1,#0x0]	; 0232BF56
	ldr r4,[r1,#0x4]	; 0232BF58
	ldr r1,[pool_0232BFB4]	; 0232BF5A
	mov r2,#0x0	; 0232BF5C
	and r4,r1	; 0232BF5E
	bic r5,r2	; 0232BF60
	str r5,[sp,#0x4]	; 0232BF62
	str r4,[sp,#0x8]	; 0232BF64
	ldr r1,[pool_0232BFB8]	; 0232BF66
	ldr r4,[r1,#0x0]	; 0232BF68
	mov r1,#0x8	; 0232BF6A
	and r4,r1	; 0232BF6C
	cmp r4,#0x0	; 0232BF6E
	beq loc_0232BF8A	; 0232BF70
	ldrh r3,[r3,#0x0]	; 0232BF72
	ldr r1,[pool_0232BFBC]	; 0232BF74
	and r3,r1	; 0232BF76
	cmp r3,#0x0	; 0232BF78
	bne loc_0232BF8A	; 0232BF7A
	ldr r3,[sp,#0x4]	; 0232BF7C
	ldr r4,[sp,#0x8]	; 0232BF7E
	mov r1,#0x1	; 0232BF80
	add r1,r3,r1	; 0232BF82
	adc r4,r2	; 0232BF84
	str r1,[sp,#0x4]	; 0232BF86
	str r4,[sp,#0x8]	; 0232BF88
loc_0232BF8A:
	blx P1_Arm9RestoreIrqMask	; 0232BF8A
	ldr r2,[sp,#0x4]	; 0232BF8E
	ldr r1,[sp,#0x8]	; 0232BF90
	lsr r0,r2,#0x10	; 0232BF92
	lsl r1,r1,#0x10	; 0232BF94
	orr r1,r0	; 0232BF96
	lsl r0,r2,#0x10	; 0232BF98
	add r2,sp,#0x0	; 0232BF9A
	ldrh r3,[r2,#0x0]	; 0232BF9C
	asr r2,r3,#0x1f	; 0232BF9E
	orr r1,r2	; 0232BFA0
	orr r0,r3	; 0232BFA2
	add sp,#0xc	; 0232BFA4
	pop {r4,r5}	; 0232BFA6
	pop {r3}	; 0232BFA8
	bx r3	; 0232BFAA
pool_0232BFAC:
loc_0232BFAC:
	.word TIMER0_DATA	; 0232BFAC
pool_0232BFB0:
loc_0232BFB0:
	.word P1_BssStart + 0x26660	; 0232BFB0
pool_0232BFB4:
loc_0232BFB4:
	.word 0x0000FFFF	; 0232BFB4
pool_0232BFB8:
loc_0232BFB8:
	.word REG_IF	; 0232BFB8
pool_0232BFBC:
loc_0232BFBC:
	.word 0x00008000	; 0232BFBC

; ===== function loc_0232BFC0 =====
P1_IrqHandler_0232BFC0:
	push {r4,lr}	; 0232BFC0
	ldr r1,[pool_0232BFFC]	; 0232BFC2
	ldr r2,[r1,#0x0]	; 0232BFC4
	ldr r4,[r1,#0x4]	; 0232BFC6
	mov r3,#0x0	; 0232BFC8
	mov r0,#0x1	; 0232BFCA
	add r0,r2,r0	; 0232BFCC
	adc r4,r3	; 0232BFCE
	str r0,[r1,#0x0]	; 0232BFD0
	str r4,[r1,#0x4]	; 0232BFD2
	ldr r0,[pool_0232C000]	; 0232BFD4
	ldr r1,[r0,#0x0]	; 0232BFD6
	cmp r1,#0x0	; 0232BFD8
	beq loc_0232BFEA	; 0232BFDA
	ldr r2,[pool_0232C004]	; 0232BFDC
	strh r3,[r2,#0x0]	; 0232BFDE
	ldr r1,[pool_0232C008]	; 0232BFE0
	strh r3,[r1,#0x0]	; 0232BFE2
	mov r1,#0xc1	; 0232BFE4
	strh r1,[r2,#0x0]	; 0232BFE6
	str r3,[r0,#0x0]	; 0232BFE8
loc_0232BFEA:
	mov r0,#0x0	; 0232BFEA
	ldr r1,[pool_0232C00C]	; 0232BFEC
	add r2,r0,#0x0	; 0232BFEE
	bl loc_0232B100	; 0232BFF0
	pop {r4}	; 0232BFF4
	pop {r3}	; 0232BFF6
	bx r3	; 0232BFF8
	.byte 0xC0, 0x46	; 0232BFFC
pool_0232BFFC:
loc_0232BFFC:
	.word P1_BssStart + 0x26660	; 0232BFFC
pool_0232C000:
loc_0232C000:
	.word P1_BssStart + 0x2665C	; 0232C000
pool_0232C004:
loc_0232C004:
	.word TIMER0_CR	; 0232C004
pool_0232C008:
loc_0232C008:
	.word TIMER0_DATA	; 0232C008
pool_0232C00C:
loc_0232C00C:
	.word 0x0232BFC1	; 0232C00C

; ===== function loc_0232C010 =====
loc_0232C010:
	push {lr}	; 0232C010
	sub sp,#0x4	; 0232C012
	ldr r0,[pool_0232C054]	; 0232C014
	ldrh r1,[r0,#0x0]	; 0232C016
	cmp r1,#0x0	; 0232C018
	bne loc_0232C04E	; 0232C01A
	mov r1,#0x1	; 0232C01C
	strh r1,[r0,#0x0]	; 0232C01E
	mov r0,#0x0	; 0232C020
	bl loc_0232BF30	; 0232C022
	mov r2,#0x0	; 0232C026
	ldr r0,[pool_0232C058]	; 0232C028
	str r2,[r0,#0x0]	; 0232C02A
	str r2,[r0,#0x4]	; 0232C02C
	ldr r1,[pool_0232C05C]	; 0232C02E
	strh r2,[r1,#0x0]	; 0232C030
	ldr r0,[pool_0232C060]	; 0232C032
	strh r2,[r0,#0x0]	; 0232C034
	mov r0,#0xc1	; 0232C036
	strh r0,[r1,#0x0]	; 0232C038
	mov r0,#0x8	; 0232C03A
	ldr r1,[pool_0232C064]	; 0232C03C
	bl loc_0232B134	; 0232C03E
	mov r0,#0x8	; 0232C042
	bl loc_0232B0B0	; 0232C044
	mov r1,#0x0	; 0232C048
	ldr r0,[pool_0232C068]	; 0232C04A
	str r1,[r0,#0x0]	; 0232C04C
loc_0232C04E:
	add sp,#0x4	; 0232C04E
	pop {r3}	; 0232C050
	bx r3	; 0232C052
pool_0232C054:
loc_0232C054:
	.word P1_BssStart + 0x26658	; 0232C054
pool_0232C058:
loc_0232C058:
	.word P1_BssStart + 0x26660	; 0232C058
pool_0232C05C:
loc_0232C05C:
	.word TIMER0_CR	; 0232C05C
pool_0232C060:
loc_0232C060:
	.word TIMER0_DATA	; 0232C060
pool_0232C064:
loc_0232C064:
	.word P1_IrqHandler_0232BFC0 + 1	; 0232C064
pool_0232C068:
loc_0232C068:
	.word P1_BssStart + 0x2665C	; 0232C068
.arm
	stmdb sp!,{lr}	; 0232C06C
	blx loc_0232C0D0	; 0232C070
	ldmia sp!,{lr}	; 0232C074
	bx lr	; 0232C078
.thumb

; ===== function loc_0232C07C =====
P1_Entry_0232C07C:
	push {r4,r5,r6,r7,lr}	; 0232C07C
	sub sp,#0x4	; 0232C07E
	add r5,r0,#0x0	; 0232C080
	cmp r5,#0x0	; 0232C082
	beq loc_0232C0C0	; 0232C084
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C086
	add r7,r0,#0x0	; 0232C08A
	ldr r0,[pool_0232C0C8]	; 0232C08C
	ldr r0,[r0,#0x0]	; 0232C08E
	cmp r0,#0x0	; 0232C090
	beq loc_0232C098	; 0232C092
	ldr r4,[r0,#0x18]	; 0232C094
	b loc_0232C09A	; 0232C096
loc_0232C098:
	mov r4,#0x0	; 0232C098
loc_0232C09A:
	cmp r0,#0x0	; 0232C09A
	beq loc_0232C0BA	; 0232C09C
	mov r6,#0x0	; 0232C09E
loc_0232C0A0:
	ldr r1,[r0,#0x8]	; 0232C0A0
	cmp r1,r5	; 0232C0A2
	bne loc_0232C0AA	; 0232C0A4
	bl loc_0232C180	; 0232C0A6
loc_0232C0AA:
	add r0,r4,#0x0	; 0232C0AA
	cmp r4,#0x0	; 0232C0AC
	beq loc_0232C0B4	; 0232C0AE
	ldr r4,[r4,#0x18]	; 0232C0B0
	b loc_0232C0B6	; 0232C0B2
loc_0232C0B4:
	add r4,r6,#0x0	; 0232C0B4
loc_0232C0B6:
	cmp r0,#0x0	; 0232C0B6
	bne loc_0232C0A0	; 0232C0B8
loc_0232C0BA:
	add r0,r7,#0x0	; 0232C0BA
	blx P1_Arm9RestoreIrqMask	; 0232C0BC
loc_0232C0C0:
	add sp,#0x4	; 0232C0C0
	pop {r4,r5,r6,r7}	; 0232C0C2
	pop {r3}	; 0232C0C4
	bx r3	; 0232C0C6
pool_0232C0C8:
loc_0232C0C8:
	.word P1_BssStart + 0x2666C	; 0232C0C8
P1_Entry_0232C0CC:
	str r1,[r0,#0x8]	; 0232C0CC
	bx lr	; 0232C0CE

; ===== function loc_0232C0D0 =====
loc_0232C0D0:
	push {r4,r5,lr}	; 0232C0D0
	sub sp,#0x4	; 0232C0D2
	mov r1,#0x0	; 0232C0D4
	ldr r0,[pool_0232C170]	; 0232C0D6
	strh r1,[r0,#0x0]	; 0232C0D8
	mov r0,#0x10	; 0232C0DA
	bl loc_0232B088	; 0232C0DC
	ldr r1,[pool_0232C174]	; 0232C0E0
	ldr r0,[pool_0232C178]	; 0232C0E2
	add r1,r1,r0	; 0232C0E4
	ldr r2,[r1,#0x0]	; 0232C0E6
	mov r0,#0x10	; 0232C0E8
	orr r2,r0	; 0232C0EA
	str r2,[r1,#0x0]	; 0232C0EC
	bl loc_0232BF44	; 0232C0EE
	ldr r2,[pool_0232C17C]	; 0232C0F2
	ldr r4,[r2,#0x0]	; 0232C0F4
	cmp r4,#0x0	; 0232C0F6
	beq loc_0232C166	; 0232C0F8
	ldr r5,[r4,#0xc]	; 0232C0FA
	ldr r3,[r4,#0x10]	; 0232C0FC
	sub r0,r0,r5	; 0232C0FE
	sbc r1,r3	; 0232C100
	bcs loc_0232C112	; 0232C102
	add r0,r4,#0x0	; 0232C104
	bl loc_0232C340	; 0232C106
	add sp,#0x4	; 0232C10A
	pop {r4,r5}	; 0232C10C
	pop {r3}	; 0232C10E
	bx r3	; 0232C110
loc_0232C112:
	ldr r1,[r4,#0x18]	; 0232C112
	str r1,[r2,#0x0]	; 0232C114
	cmp r1,#0x0	; 0232C116
	bne loc_0232C120	; 0232C118
	mov r0,#0x0	; 0232C11A
	str r0,[r2,#0x4]	; 0232C11C
	b loc_0232C124	; 0232C11E
loc_0232C120:
	mov r0,#0x0	; 0232C120
	str r0,[r1,#0x14]	; 0232C122
loc_0232C124:
	ldr r5,[r4,#0x0]	; 0232C124
	ldr r2,[r4,#0x1c]	; 0232C126
	ldr r1,[r4,#0x20]	; 0232C128
	mov r0,#0x0	; 0232C12A
	eor r1,r0	; 0232C12C
	eor r2,r0	; 0232C12E
	orr r1,r2	; 0232C130
	bne loc_0232C138	; 0232C132
	mov r0,#0x0	; 0232C134
	str r0,[r4,#0x0]	; 0232C136
loc_0232C138:
	cmp r5,#0x0	; 0232C138
	beq loc_0232C140	; 0232C13A
	ldr r0,[r4,#0x4]	; 0232C13C
	blx r5	; 0232C13E
loc_0232C140:
	ldr r2,[r4,#0x1c]	; 0232C140
	ldr r1,[r4,#0x20]	; 0232C142
	mov r0,#0x0	; 0232C144
	eor r1,r0	; 0232C146
	eor r2,r0	; 0232C148
	orr r1,r2	; 0232C14A
	beq loc_0232C15A	; 0232C14C
	str r5,[r4,#0x0]	; 0232C14E
	add r0,r4,#0x0	; 0232C150
	mov r1,#0x0	; 0232C152
	add r2,r1,#0x0	; 0232C154
	bl loc_0232C230	; 0232C156
loc_0232C15A:
	ldr r0,[pool_0232C17C]	; 0232C15A
	ldr r0,[r0,#0x0]	; 0232C15C
	cmp r0,#0x0	; 0232C15E
	beq loc_0232C166	; 0232C160
	bl loc_0232C340	; 0232C162
loc_0232C166:
	add sp,#0x4	; 0232C166
	pop {r4,r5}	; 0232C168
	pop {r3}	; 0232C16A
	bx r3	; 0232C16C
	.byte 0xC0, 0x46	; 0232C170
pool_0232C170:
loc_0232C170:
	.word TIMER1_CR	; 0232C170
pool_0232C174:
loc_0232C174:
	.word 0x03000000	; 0232C174
pool_0232C178:
loc_0232C178:
	.word 0x00003FF8	; 0232C178
pool_0232C17C:
loc_0232C17C:
	.word P1_BssStart + 0x2666C	; 0232C17C

; ===== function loc_0232C180 =====
loc_0232C180:
	push {r4,r5,lr}	; 0232C180
	sub sp,#0x4	; 0232C182
	add r5,r0,#0x0	; 0232C184
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C186
	add r4,r0,#0x0	; 0232C18A
	ldr r1,[r5,#0x0]	; 0232C18C
	cmp r1,#0x0	; 0232C18E
	bne loc_0232C19E	; 0232C190
	blx P1_Arm9RestoreIrqMask	; 0232C192
	add sp,#0x4	; 0232C196
	pop {r4,r5}	; 0232C198
	pop {r3}	; 0232C19A
	bx r3	; 0232C19C
loc_0232C19E:
	ldr r0,[r5,#0x18]	; 0232C19E
	cmp r0,#0x0	; 0232C1A0
	bne loc_0232C1AC	; 0232C1A2
	ldr r2,[r5,#0x14]	; 0232C1A4
	ldr r1,[pool_0232C1DC]	; 0232C1A6
	str r2,[r1,#0x4]	; 0232C1A8
	b loc_0232C1B0	; 0232C1AA
loc_0232C1AC:
	ldr r1,[r5,#0x14]	; 0232C1AC
	str r1,[r0,#0x14]	; 0232C1AE
loc_0232C1B0:
	ldr r1,[r5,#0x14]	; 0232C1B0
	cmp r1,#0x0	; 0232C1B2
	beq loc_0232C1BA	; 0232C1B4
	str r0,[r1,#0x18]	; 0232C1B6
	b loc_0232C1C6	; 0232C1B8
loc_0232C1BA:
	ldr r1,[pool_0232C1DC]	; 0232C1BA
	str r0,[r1,#0x0]	; 0232C1BC
	cmp r0,#0x0	; 0232C1BE
	beq loc_0232C1C6	; 0232C1C0
	bl loc_0232C340	; 0232C1C2
loc_0232C1C6:
	mov r0,#0x0	; 0232C1C6
	str r0,[r5,#0x0]	; 0232C1C8
	str r0,[r5,#0x1c]	; 0232C1CA
	str r0,[r5,#0x20]	; 0232C1CC
	add r0,r4,#0x0	; 0232C1CE
	blx P1_Arm9RestoreIrqMask	; 0232C1D0
	add sp,#0x4	; 0232C1D4
	pop {r4,r5}	; 0232C1D6
	pop {r3}	; 0232C1D8
	bx r3	; 0232C1DA
pool_0232C1DC:
loc_0232C1DC:
	.word P1_BssStart + 0x2666C	; 0232C1DC
P1_Entry_0232C1E0:
	push {r4,r5,r6,r7,lr}	; 0232C1E0
	sub sp,#0x4	; 0232C1E2
	add r5,r0,#0x0	; 0232C1E4
	add r6,r1,#0x0	; 0232C1E6
	add r4,r2,#0x0	; 0232C1E8
	add r7,r3,#0x0	; 0232C1EA
	cmp r5,#0x0	; 0232C1EC
	beq P1_Entry_0232C1F6	; 0232C1EE
	ldr r0,[r5,#0x0]	; 0232C1F0
	cmp r0,#0x0	; 0232C1F2
	beq P1_Entry_0232C1FA	; 0232C1F4
P1_Entry_0232C1F6:
	bl loc_0232C47C	; 0232C1F6
P1_Entry_0232C1FA:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C1FA
	str r0,[sp,#0x0]	; 0232C1FE
	mov r0,#0x0	; 0232C200
	str r0,[r5,#0x1c]	; 0232C202
	str r0,[r5,#0x20]	; 0232C204
	str r7,[r5,#0x0]	; 0232C206
	ldr r0,[sp,#0x18]	; 0232C208
	str r0,[r5,#0x4]	; 0232C20A
	bl loc_0232BF44	; 0232C20C
	add r2,r0,#0x0	; 0232C210
	add r0,r5,#0x0	; 0232C212
	add r2,r6,r2	; 0232C214
	adc r4,r1	; 0232C216
	add r1,r2,#0x0	; 0232C218
	add r2,r4,#0x0	; 0232C21A
	bl loc_0232C230	; 0232C21C
	ldr r0,[sp,#0x0]	; 0232C220
	blx P1_Arm9RestoreIrqMask	; 0232C222
	add sp,#0x4	; 0232C226
	pop {r4,r5,r6,r7}	; 0232C228
	pop {r3}	; 0232C22A
	bx r3	; 0232C22C
	.byte 0x00, 0x00	; 0232C22E

; ===== function loc_0232C230 =====
loc_0232C230:
	push {r4,r5,r6,r7,lr}	; 0232C230
	sub sp,#0xc	; 0232C232
	add r5,r0,#0x0	; 0232C234
	add r4,r1,#0x0	; 0232C236
	add r6,r2,#0x0	; 0232C238
	ldr r2,[r5,#0x1c]	; 0232C23A
	ldr r1,[r5,#0x20]	; 0232C23C
	mov r0,#0x0	; 0232C23E
	eor r1,r0	; 0232C240
	eor r2,r0	; 0232C242
	orr r1,r2	; 0232C244
	beq loc_0232C28A	; 0232C246
	bl loc_0232BF44	; 0232C248
	ldr r4,[r5,#0x24]	; 0232C24C
	ldr r6,[r5,#0x28]	; 0232C24E
	sub r2,r4,r0	; 0232C250
	lsl r2,r6,#0	; 0232C252
	sbc r2,r1	; 0232C254
	bcs loc_0232C28A	; 0232C256
	ldr r2,[r5,#0x1c]	; 0232C258
	str r2,[sp,#0x0]	; 0232C25A
	ldr r2,[r5,#0x20]	; 0232C25C
	str r2,[sp,#0x4]	; 0232C25E
	sub r0,r0,r4	; 0232C260
	sbc r1,r6	; 0232C262
	ldr r2,[sp,#0x0]	; 0232C264
	ldr r3,[sp,#0x4]	; 0232C266
	blx loc_0232CA54	; 0232C268
	str r0,[sp,#0x8]	; 0232C26C
	add r7,r1,#0x0	; 0232C26E
	ldr r0,[sp,#0x0]	; 0232C270
	ldr r1,[sp,#0x4]	; 0232C272
	mov r3,#0x1	; 0232C274
	ldr r2,[sp,#0x8]	; 0232C276
	add r3,r2,r3	; 0232C278
	mov r2,#0x0	; 0232C27A
	adc r7,r2	; 0232C27C
	add r2,r3,#0x0	; 0232C27E
	add r3,r7,#0x0	; 0232C280
	blx P1_AeabiLmul	; 0232C282
	add r4,r4,r0	; 0232C286
	adc r6,r1	; 0232C288
loc_0232C28A:
	str r4,[r5,#0xc]	; 0232C28A
	str r6,[r5,#0x10]	; 0232C28C
	ldr r0,[pool_0232C304]	; 0232C28E
	ldr r3,[r0,#0x0]	; 0232C290
	cmp r3,#0x0	; 0232C292
	beq loc_0232C2D8	; 0232C294
loc_0232C296:
	ldr r1,[r3,#0xc]	; 0232C296
	ldr r0,[r3,#0x10]	; 0232C298
	sub r2,r4,r1	; 0232C29A
	lsl r1,r6,#0	; 0232C29C
	sbc r1,r0	; 0232C29E
	mov r0,#0x0	; 0232C2A0
	sub r2,r2,r0	; 0232C2A2
	sbc r1,r0	; 0232C2A4
	bge loc_0232C2D2	; 0232C2A6
	ldr r0,[r3,#0x14]	; 0232C2A8
	str r0,[r5,#0x14]	; 0232C2AA
	str r5,[r3,#0x14]	; 0232C2AC
	str r3,[r5,#0x18]	; 0232C2AE
	ldr r0,[r5,#0x14]	; 0232C2B0
	cmp r0,#0x0	; 0232C2B2
	beq loc_0232C2C0	; 0232C2B4
	str r5,[r0,#0x18]	; 0232C2B6
	add sp,#0xc	; 0232C2B8
	pop {r4,r5,r6,r7}	; 0232C2BA
	pop {r3}	; 0232C2BC
	bx r3	; 0232C2BE
loc_0232C2C0:
	ldr r0,[pool_0232C304]	; 0232C2C0
	str r5,[r0,#0x0]	; 0232C2C2
	add r0,r5,#0x0	; 0232C2C4
	bl loc_0232C340	; 0232C2C6
	add sp,#0xc	; 0232C2CA
	pop {r4,r5,r6,r7}	; 0232C2CC
	pop {r3}	; 0232C2CE
	bx r3	; 0232C2D0
loc_0232C2D2:
	ldr r3,[r3,#0x18]	; 0232C2D2
	cmp r3,#0x0	; 0232C2D4
	bne loc_0232C296	; 0232C2D6
loc_0232C2D8:
	mov r0,#0x0	; 0232C2D8
	str r0,[r5,#0x18]	; 0232C2DA
	ldr r0,[pool_0232C304]	; 0232C2DC
	ldr r1,[r0,#0x4]	; 0232C2DE
	str r5,[r0,#0x4]	; 0232C2E0
	str r1,[r5,#0x14]	; 0232C2E2
	cmp r1,#0x0	; 0232C2E4
	beq loc_0232C2F2	; 0232C2E6
	str r5,[r1,#0x18]	; 0232C2E8
	add sp,#0xc	; 0232C2EA
	pop {r4,r5,r6,r7}	; 0232C2EC
	pop {r3}	; 0232C2EE
	bx r3	; 0232C2F0
loc_0232C2F2:
	str r5,[r0,#0x4]	; 0232C2F2
	str r5,[r0,#0x0]	; 0232C2F4
	add r0,r5,#0x0	; 0232C2F6
	bl loc_0232C340	; 0232C2F8
	add sp,#0xc	; 0232C2FC
	pop {r4,r5,r6,r7}	; 0232C2FE
	pop {r3}	; 0232C300
	bx r3	; 0232C302
pool_0232C304:
loc_0232C304:
	.word P1_BssStart + 0x2666C	; 0232C304
P1_Entry_0232C308:
	mov r1,#0x0	; 0232C308
	str r1,[r0,#0x0]	; 0232C30A
	str r1,[r0,#0x8]	; 0232C30C
	bx lr	; 0232C30E

; ===== function loc_0232C310 =====
P1_Entry_0232C310:
	push {lr}	; 0232C310
	sub sp,#0x4	; 0232C312
	ldr r1,[pool_0232C338]	; 0232C314
	ldrh r0,[r1,#0x0]	; 0232C316
	cmp r0,#0x0	; 0232C318
	bne loc_0232C332	; 0232C31A
	mov r0,#0x1	; 0232C31C
	strh r0,[r1,#0x0]	; 0232C31E
	bl loc_0232BF30	; 0232C320
	mov r1,#0x0	; 0232C324
	ldr r0,[pool_0232C33C]	; 0232C326
	str r1,[r0,#0x0]	; 0232C328
	str r1,[r0,#0x4]	; 0232C32A
	mov r0,#0x10	; 0232C32C
	bl loc_0232B088	; 0232C32E
loc_0232C332:
	add sp,#0x4	; 0232C332
	pop {r3}	; 0232C334
	bx r3	; 0232C336
pool_0232C338:
loc_0232C338:
	.word P1_BssStart + 0x26668	; 0232C338
pool_0232C33C:
loc_0232C33C:
	.word P1_BssStart + 0x2666C	; 0232C33C

; ===== function loc_0232C340 =====
loc_0232C340:
	push {r4,r5,lr}	; 0232C340
	sub sp,#0x4	; 0232C342
	add r4,r0,#0x0	; 0232C344
	bl loc_0232BF44	; 0232C346
	mov r2,#0x0	; 0232C34A
	ldr r3,[pool_0232C398]	; 0232C34C
	strh r2,[r3,#0x0]	; 0232C34E
	ldr r3,[r4,#0xc]	; 0232C350
	ldr r4,[r4,#0x10]	; 0232C352
	sub r5,r3,r0	; 0232C354
	sbc r4,r1	; 0232C356
	mov r0,#0x1	; 0232C358
	ldr r1,[pool_0232C39C]	; 0232C35A
	bl loc_0232B100	; 0232C35C
	mov r1,#0x0	; 0232C360
	sub r0,r5,r1	; 0232C362
	lsl r0,r4,#0	; 0232C364
	sbc r0,r1	; 0232C366
	bge loc_0232C36E	; 0232C368
	ldr r1,[pool_0232C3A0]	; 0232C36A
	b loc_0232C380	; 0232C36C
loc_0232C36E:
	ldr r0,[pool_0232C3A4]	; 0232C36E
	sub r0,r5,r0	; 0232C370
	sbc r4,r1	; 0232C372
	bge loc_0232C37E	; 0232C374
	mvn r0,r5	; 0232C376
	lsl r0,r0,#0x10	; 0232C378
	lsr r1,r0,#0x10	; 0232C37A
	b loc_0232C380	; 0232C37C
loc_0232C37E:
	mov r1,#0x0	; 0232C37E
loc_0232C380:
	ldr r0,[pool_0232C3A8]	; 0232C380
	strh r1,[r0,#0x0]	; 0232C382
	mov r1,#0xc1	; 0232C384
	ldr r0,[pool_0232C398]	; 0232C386
	strh r1,[r0,#0x0]	; 0232C388
	mov r0,#0x10	; 0232C38A
	bl loc_0232B0B0	; 0232C38C
	add sp,#0x4	; 0232C390
	pop {r4,r5}	; 0232C392
	pop {r3}	; 0232C394
	bx r3	; 0232C396
pool_0232C398:
loc_0232C398:
	.word TIMER1_CR	; 0232C398
pool_0232C39C:
loc_0232C39C:
	.word 0x0232C06C	; 0232C39C
pool_0232C3A0:
loc_0232C3A0:
	.word 0x0000FFFE	; 0232C3A0
pool_0232C3A4:
loc_0232C3A4:
	.word 0x00010000	; 0232C3A4
pool_0232C3A8:
loc_0232C3A8:
	.word TIMER1_DATA	; 0232C3A8

; ===== function loc_0232C3AC =====
loc_0232C3AC:
	push {lr}	; 0232C3AC
	sub sp,#0x4	; 0232C3AE
	ldr r0,[pool_0232C3DC]	; 0232C3B0
	ldrh r1,[r0,#0x0]	; 0232C3B2
	cmp r1,#0x0	; 0232C3B4
	bne loc_0232C3D4	; 0232C3B6
	mov r1,#0x1	; 0232C3B8
	strh r1,[r0,#0x0]	; 0232C3BA
	mov r1,#0x0	; 0232C3BC
	ldr r0,[pool_0232C3E0]	; 0232C3BE
	str r1,[r0,#0x0]	; 0232C3C0
	str r1,[r0,#0x4]	; 0232C3C2
	mov r0,#0x4	; 0232C3C4
	bl loc_0232B088	; 0232C3C6
	mov r1,#0x0	; 0232C3CA
	ldr r0,[pool_0232C3E4]	; 0232C3CC
	str r1,[r0,#0x0]	; 0232C3CE
	ldr r0,[pool_0232C3E8]	; 0232C3D0
	str r1,[r0,#0x0]	; 0232C3D2
loc_0232C3D4:
	add sp,#0x4	; 0232C3D4
	pop {r3}	; 0232C3D6
	bx r3	; 0232C3D8
	.byte 0xC0, 0x46	; 0232C3DC
pool_0232C3DC:
loc_0232C3DC:
	.word P1_BssStart + 0x26674	; 0232C3DC
pool_0232C3E0:
loc_0232C3E0:
	.word P1_BssStart + 0x26680	; 0232C3E0
pool_0232C3E4:
loc_0232C3E4:
	.word P1_BssStart + 0x2667C	; 0232C3E4
pool_0232C3E8:
loc_0232C3E8:
	.word P1_BssStart + 0x26678	; 0232C3E8
.arm

; ===== function loc_0232C3EC =====
; Clears CPSR I and returns the former I mask. / 清除 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9EnableIrqReturnPriorMask
loc_0232C3EC:
	mrs r0,cpsr	; 0232C3EC
	bic r1,r0,#0x80	; 0232C3F0
	msr cpsr_c,r1	; 0232C3F4
	and r0,r0,#0x80	; 0232C3F8
	bx lr	; 0232C3FC
.endfunc

; ===== function loc_0232C400 =====
; Sets CPSR I and returns the former I mask. / 设置 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9DisableIrqReturnPriorMask
loc_0232C400:
	mrs r0,cpsr	; 0232C400
	orr r1,r0,#0x80	; 0232C404
	msr cpsr_c,r1	; 0232C408
	and r0,r0,#0x80	; 0232C40C
	bx lr	; 0232C410
.endfunc

; ===== function loc_0232C414 =====
; Restores CPSR I from r0 and returns the prior mask. / 按 r0 恢复 CPSR I 位并返回先前掩码。
.func P1_Arm9RestoreIrqMask
loc_0232C414:
	mrs r1,cpsr	; 0232C414
	bic r2,r1,#0x80	; 0232C418
	orr r2,r2,r0	; 0232C41C
	msr cpsr_c,r2	; 0232C420
	and r0,r1,#0x80	; 0232C424
	bx lr	; 0232C428
.endfunc

; ===== function loc_0232C42C =====
; Sets CPSR I/F and returns the former masks. / 设置 CPSR I/F 位并返回先前掩码。
.func P1_Arm9DisableIrqFiqReturnPriorMasks
loc_0232C42C:
	mrs r0,cpsr	; 0232C42C
	orr r1,r0,#0xc0	; 0232C430
	msr cpsr_c,r1	; 0232C434
	and r0,r0,#0xc0	; 0232C438
	bx lr	; 0232C43C
.endfunc

; ===== function loc_0232C440 =====
; Restores CPSR I/F from r0 and returns prior masks. / 按 r0 恢复 CPSR I/F 位并返回先前掩码。
.func P1_Arm9RestoreIrqFiqMasks
loc_0232C440:
	mrs r1,cpsr	; 0232C440
	bic r2,r1,#0xc0	; 0232C444
	orr r2,r2,r0	; 0232C448
	msr cpsr_c,r2	; 0232C44C
	and r0,r1,#0xc0	; 0232C450
	bx lr	; 0232C454
.endfunc

; ===== function loc_0232C458 =====
; Returns the CPSR processor-mode bits. / 返回 CPSR 的处理器模式位。
.func P1_Arm9GetProcessorMode
loc_0232C458:
	mrs r0,cpsr	; 0232C458
	and r0,r0,#0x1f	; 0232C45C
	bx lr	; 0232C460
.endfunc

; ===== function loc_0232C464 =====
; ARM946 CP15 wait-for-interrupt helper. / ARM946 CP15 等待中断帮助例程。
.func P1_Arm9WaitForInterrupt
loc_0232C464:
	mov r0,#0x0	; 0232C464
	mcr p15,0x0,r0,c7,c0,0x4	; 0232C468
	bx lr	; 0232C46C
.endfunc

; ===== function loc_0232C470 =====
; Decrements r0 by four until borrow. / 每次将 r0 减四，直至产生借位。
.func P1_Arm9BusyWaitByLoop4
loc_0232C470:
	subs r0,r0,#0x4	; 0232C470
	bcs loc_0232C470	; 0232C474
	bx lr	; 0232C478
.endfunc
.thumb

; ===== function loc_0232C47C =====
loc_0232C47C:
	push {lr}	; 0232C47C
	sub sp,#0x4	; 0232C47E
loc_0232C480:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C480
	blx P1_Arm9WaitForInterrupt	; 0232C484
	b loc_0232C480	; 0232C488
	.byte 0x00, 0x00, 0x01, 0x1C, 0x02, 0x48, 0x06, 0x22, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFC	; 0232C49A
	.byte 0x7F, 0x02, 0x58, 0xDE, 0x32, 0x02	; 0232C4A0

; ===== function loc_0232C4A0 =====
loc_0232C4A0:
	push {r4,lr}	; 0232C4A0
	add r4,r1,#0x0	; 0232C4A2
	ldr r1,[r4,#0x0]	; 0232C4A4
	cmp r1,#0x0	; 0232C4A6
	bne loc_0232C4AE	; 0232C4A8
	bl loc_0232B1A4	; 0232C4AA
loc_0232C4AE:
	ldr r0,[r4,#0x4]	; 0232C4AE
	blx P1_Arm9RestoreIrqMask	; 0232C4B0
	pop {r4}	; 0232C4B4
	pop {r3}	; 0232C4B6
	bx r3	; 0232C4B8
	.byte 0x00, 0x00	; 0232C4BC

; ===== function loc_0232C4BC =====
loc_0232C4BC:
	push {r4,r5,r6,r7,lr}	; 0232C4BC
	sub sp,#0x4	; 0232C4BE
	add r5,r0,#0x0	; 0232C4C0
	add r4,r1,#0x0	; 0232C4C2
	ldr r7,[pool_0232C500]	; 0232C4C4
	mov r6,#0x40	; 0232C4C6
loc_0232C4C8:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C4C8
	str r0,[r4,#0x4]	; 0232C4CC
	add r0,r7,#0x0	; 0232C4CE
	bl loc_0232B24C	; 0232C4D0
	and r0,r6	; 0232C4D4
	str r0,[r4,#0x0]	; 0232C4D6
	ldr r0,[r4,#0x0]	; 0232C4D8
	cmp r0,#0x0	; 0232C4DA
	bne loc_0232C4F6	; 0232C4DC
	add r0,r5,#0x0	; 0232C4DE
	bl loc_0232B2D4	; 0232C4E0
	cmp r0,#0x0	; 0232C4E4
	beq loc_0232C4F6	; 0232C4E6
	ldr r0,[r4,#0x4]	; 0232C4E8
	blx P1_Arm9RestoreIrqMask	; 0232C4EA
	mov r0,#0x1	; 0232C4EE
	bl P1_SwiWaitByLoop	; 0232C4F0
	b loc_0232C4C8	; 0232C4F4
loc_0232C4F6:
	add sp,#0x4	; 0232C4F6
	pop {r4,r5,r6,r7}	; 0232C4F8
	pop {r3}	; 0232C4FA
	bx r3	; 0232C4FC
	.byte 0xC0, 0x46	; 0232C500
pool_0232C500:
loc_0232C500:
	.word 0x027FFFE8	; 0232C500

; ===== function loc_0232C504 =====
loc_0232C504:
	push {r4}	; 0232C504
	sub sp,#0x4	; 0232C506
	ldr r4,[r0,#0x0]	; 0232C508
	ldr r3,[pool_0232C52C]	; 0232C50A
	ldrh r2,[r3,#0x0]	; 0232C50C
	mov r1,#0xc	; 0232C50E
	bic r2,r1	; 0232C510
	lsl r1,r4,#0x2	; 0232C512
	orr r2,r1	; 0232C514
	strh r2,[r3,#0x0]	; 0232C516
	ldr r2,[r0,#0x4]	; 0232C518
	ldrh r1,[r3,#0x0]	; 0232C51A
	mov r0,#0x10	; 0232C51C
	bic r1,r0	; 0232C51E
	lsl r0,r2,#0x4	; 0232C520
	orr r1,r0	; 0232C522
	strh r1,[r3,#0x0]	; 0232C524
	add sp,#0x4	; 0232C526
	pop {r4}	; 0232C528
	bx lr	; 0232C52A
pool_0232C52C:
loc_0232C52C:
	.word REG_EXMEMCNT_ARM9	; 0232C52C

; ===== function loc_0232C530 =====
loc_0232C530:
	push {r4}	; 0232C530
	sub sp,#0x4	; 0232C532
	ldr r4,[pool_0232C560]	; 0232C534
	ldrh r2,[r4,#0x0]	; 0232C536
	mov r1,#0xc	; 0232C538
	and r2,r1	; 0232C53A
	asr r2,r2,#0x2	; 0232C53C
	str r2,[r0,#0x0]	; 0232C53E
	ldrh r3,[r4,#0x0]	; 0232C540
	mov r2,#0x10	; 0232C542
	and r3,r2	; 0232C544
	asr r3,r3,#0x4	; 0232C546
	str r3,[r0,#0x4]	; 0232C548
	ldrh r0,[r4,#0x0]	; 0232C54A
	bic r0,r1	; 0232C54C
	orr r0,r1	; 0232C54E
	strh r0,[r4,#0x0]	; 0232C550
	ldrh r0,[r4,#0x0]	; 0232C552
	bic r0,r2	; 0232C554
	strh r0,[r4,#0x0]	; 0232C556
	add sp,#0x4	; 0232C558
	pop {r4}	; 0232C55A
	bx lr	; 0232C55C
	.byte 0xC0, 0x46	; 0232C560
pool_0232C560:
loc_0232C560:
	.word REG_EXMEMCNT_ARM9	; 0232C560

; ===== function loc_0232C564 =====
loc_0232C564:
	push {r4,lr}	; 0232C564
	sub sp,#0x10	; 0232C566
	mov r4,#0x1	; 0232C568
	ldr r2,[pool_0232C608]	; 0232C56A
	ldrh r1,[r2,#0x0]	; 0232C56C
	ldr r0,[pool_0232C60C]	; 0232C56E
	cmp r1,r0	; 0232C570
	bne loc_0232C57E	; 0232C572
	mov r0,#0x0	; 0232C574
	add sp,#0x10	; 0232C576
	pop {r4}	; 0232C578
	pop {r3}	; 0232C57A
	bx r3	; 0232C57C
loc_0232C57E:
	ldrb r0,[r2,#0x5]	; 0232C57E
	lsl r0,r0,#0x1e	; 0232C580
	lsr r0,r0,#0x1f	; 0232C582
	cmp r0,#0x1	; 0232C584
	bne loc_0232C592	; 0232C586
	mov r0,#0x0	; 0232C588
	add sp,#0x10	; 0232C58A
	pop {r4}	; 0232C58C
	pop {r3}	; 0232C58E
	bx r3	; 0232C590
loc_0232C592:
	ldr r0,[pool_0232C610]	; 0232C592
	ldrh r0,[r0,#0x2]	; 0232C594
	add r1,sp,#0x0	; 0232C596
	bl loc_0232C4BC	; 0232C598
	add r0,sp,#0x8	; 0232C59C
	bl loc_0232C530	; 0232C59E
	ldr r2,[pool_0232C614]	; 0232C5A2
	add r0,r2,#0x0	; 0232C5A4
	add r0,#0xb2	; 0232C5A6
	ldrb r3,[r0,#0x0]	; 0232C5A8
	cmp r3,#0x96	; 0232C5AA
	bne loc_0232C5BA	; 0232C5AC
	ldr r0,[pool_0232C608]	; 0232C5AE
	ldrh r1,[r0,#0x0]	; 0232C5B0
	add r2,#0xbe	; 0232C5B2
	ldrh r0,[r2,#0x0]	; 0232C5B4
	cmp r1,r0	; 0232C5B6
	bne loc_0232C5E2	; 0232C5B8
loc_0232C5BA:
	cmp r3,#0x96	; 0232C5BA
	beq loc_0232C5CA	; 0232C5BC
	ldr r0,[pool_0232C608]	; 0232C5BE
	ldrh r1,[r0,#0x0]	; 0232C5C0
	ldr r0,[pool_0232C618]	; 0232C5C2
	ldrh r0,[r0,#0x0]	; 0232C5C4
	cmp r1,r0	; 0232C5C6
	bne loc_0232C5E2	; 0232C5C8
loc_0232C5CA:
	ldr r2,[pool_0232C608]	; 0232C5CA
	ldr r1,[r2,#0x8]	; 0232C5CC
	ldr r0,[pool_0232C614]	; 0232C5CE
	add r0,#0xac	; 0232C5D0
	ldr r0,[r0,#0x0]	; 0232C5D2
	cmp r1,r0	; 0232C5D4
	beq loc_0232C5EE	; 0232C5D6
	ldrb r0,[r2,#0x5]	; 0232C5D8
	lsl r0,r0,#0x1f	; 0232C5DA
	lsr r0,r0,#0x1f	; 0232C5DC
	cmp r0,#0x0	; 0232C5DE
	beq loc_0232C5EE	; 0232C5E0
loc_0232C5E2:
	ldr r2,[pool_0232C608]	; 0232C5E2
	ldrb r1,[r2,#0x5]	; 0232C5E4
	mov r0,#0x2	; 0232C5E6
	orr r1,r0	; 0232C5E8
	strb r1,[r2,#0x5]	; 0232C5EA
	mov r4,#0x0	; 0232C5EC
loc_0232C5EE:
	add r0,sp,#0x8	; 0232C5EE
	bl loc_0232C504	; 0232C5F0
	ldr r0,[pool_0232C610]	; 0232C5F4
	ldrh r0,[r0,#0x2]	; 0232C5F6
	add r1,sp,#0x0	; 0232C5F8
	bl loc_0232C4A0	; 0232C5FA
	add r0,r4,#0x0	; 0232C5FE
	add sp,#0x10	; 0232C600
	pop {r4}	; 0232C602
	pop {r3}	; 0232C604
	bx r3	; 0232C606
pool_0232C608:
loc_0232C608:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C608
pool_0232C60C:
loc_0232C60C:
	.word 0x0000FFFF	; 0232C60C
pool_0232C610:
loc_0232C610:
	.word P1_BssStart + 0x26688	; 0232C610
pool_0232C614:
loc_0232C614:
	.word 0x08000000	; 0232C614
pool_0232C618:
loc_0232C618:
	.word 0x0801FFFE	; 0232C618

; ===== function loc_0232C61C =====
loc_0232C61C:
	push {lr}	; 0232C61C
	sub sp,#0x4	; 0232C61E
	ldr r2,[pool_0232C650]	; 0232C620
	ldrh r1,[r2,#0x0]	; 0232C622
	ldr r0,[pool_0232C654]	; 0232C624
	cmp r1,r0	; 0232C626
	bne loc_0232C632	; 0232C628
	mov r0,#0x0	; 0232C62A
	add sp,#0x4	; 0232C62C
	pop {r3}	; 0232C62E
	bx r3	; 0232C630
loc_0232C632:
	ldrb r0,[r2,#0x5]	; 0232C632
	lsl r0,r0,#0x1e	; 0232C634
	lsr r0,r0,#0x1f	; 0232C636
	cmp r0,#0x0	; 0232C638
	bne loc_0232C640	; 0232C63A
	bl loc_0232C564	; 0232C63C
loc_0232C640:
	ldr r0,[pool_0232C650]	; 0232C640
	ldrb r0,[r0,#0x5]	; 0232C642
	lsl r0,r0,#0x1e	; 0232C644
	lsr r0,r0,#0x1f	; 0232C646
	add sp,#0x4	; 0232C648
	pop {r3}	; 0232C64A
	bx r3	; 0232C64C
	.byte 0xC0, 0x46	; 0232C650
pool_0232C650:
loc_0232C650:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C650
pool_0232C654:
loc_0232C654:
	.word 0x0000FFFF	; 0232C654

; ===== function loc_0232C658 =====
loc_0232C658:
	push {r4}	; 0232C658
	sub sp,#0x4	; 0232C65A
	mov r4,#0x0	; 0232C65C
	ldr r3,[pool_0232C680]	; 0232C65E
	ldrh r2,[r3,#0x0]	; 0232C660
	ldr r1,[pool_0232C684]	; 0232C662
	cmp r2,r1	; 0232C664
	beq loc_0232C678	; 0232C666
	cmp r2,#0x0	; 0232C668
	beq loc_0232C678	; 0232C66A
	ldrb r1,[r3,#0x0]	; 0232C66C
	mvn r1,r1	; 0232C66E
	and r1,r0	; 0232C670
	cmp r1,#0x0	; 0232C672
	beq loc_0232C678	; 0232C674
	mov r4,#0x1	; 0232C676
loc_0232C678:
	add r0,r4,#0x0	; 0232C678
	add sp,#0x4	; 0232C67A
	pop {r4}	; 0232C67C
	bx lr	; 0232C67E
pool_0232C680:
loc_0232C680:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C680
pool_0232C684:
loc_0232C684:
	.word 0x0000FFFF	; 0232C684

; ===== function loc_0232C688 =====
loc_0232C688:
	push {r4,lr}	; 0232C688
	add r4,r0,#0x0	; 0232C68A
	bl loc_0232C564	; 0232C68C
	cmp r0,#0x0	; 0232C690
	beq loc_0232C6A6	; 0232C692
	add r0,r4,#0x0	; 0232C694
	bl loc_0232C658	; 0232C696
	cmp r0,#0x0	; 0232C69A
	beq loc_0232C6A6	; 0232C69C
	mov r0,#0x1	; 0232C69E
	pop {r4}	; 0232C6A0
	pop {r3}	; 0232C6A2
	bx r3	; 0232C6A4
loc_0232C6A6:
	mov r0,#0x0	; 0232C6A6
	pop {r4}	; 0232C6A8
	pop {r3}	; 0232C6AA
	bx r3	; 0232C6AC
	.byte 0x00, 0x00	; 0232C6B0

; ===== function loc_0232C6B0 =====
loc_0232C6B0:
	push {lr}	; 0232C6B0
	sub sp,#0x4	; 0232C6B2
	mov r0,#0x0	; 0232C6B4
	str r0,[sp,#0x0]	; 0232C6B6
	add r0,sp,#0x0	; 0232C6B8
	ldr r1,[pool_0232C6D0]	; 0232C6BA
	ldr r2,[pool_0232C6D4]	; 0232C6BC
	bl loc_0232C71A	; 0232C6BE
	blx loc_0232B1B4	; 0232C6C2
	ldr r1,[pool_0232C6D0]	; 0232C6C6
	strh r0,[r1,#0x2]	; 0232C6C8
	add sp,#0x4	; 0232C6CA
	pop {r3}	; 0232C6CC
	bx r3	; 0232C6CE
pool_0232C6D0:
loc_0232C6D0:
	.word P1_BssStart + 0x26688	; 0232C6D0
pool_0232C6D4:
loc_0232C6D4:
	.word 0x05000001	; 0232C6D4

; ===== function loc_0232C6D8 =====
loc_0232C6D8:
	push {lr}	; 0232C6D8
	sub sp,#0x4	; 0232C6DA
	ldr r0,[pool_0232C6F4]	; 0232C6DC
	ldr r1,[r0,#0x0]	; 0232C6DE
	cmp r1,#0x0	; 0232C6E0
	bne loc_0232C6EC	; 0232C6E2
	mov r1,#0x1	; 0232C6E4
	str r1,[r0,#0x0]	; 0232C6E6
	bl loc_0232C6B0	; 0232C6E8
loc_0232C6EC:
	add sp,#0x4	; 0232C6EC
	pop {r3}	; 0232C6EE
	bx r3	; 0232C6F0
	.byte 0xC0, 0x46	; 0232C6F4
pool_0232C6F4:
loc_0232C6F4:
	.word P1_BssStart + 0x2668C	; 0232C6F4
	.byte 0x00, 0xDF, 0x70, 0x47	; 0232C6FC

.func P1_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
	swi 0x3	; 0232C6FC
	bx lr	; 0232C6FE
.endfunc
	.byte 0x00, 0x22, 0x04, 0xDF, 0x70, 0x47	; 0232C706

.func P1_SwiVBlankIntrWait
; BIOS SWI #05: wait for VBlank IRQ. / BIOS SWI #05：等待 VBlank 中断。
	mov r2,#0x0	; 0232C706
	swi 0x5	; 0232C708
	bx lr	; 0232C70A
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

.func P1_SwiCpuSet
; BIOS SWI #0B: CpuSet copy/fill. / BIOS SWI #0B：CpuSet 复制/填充。
loc_0232C71A:
	swi 0xb	; 0232C71A
	bx lr	; 0232C71C
.endfunc

.func P1_SwiCpuFastSet
; BIOS SWI #0C: CpuFastSet copy/fill. / BIOS SWI #0C：CpuFastSet 复制/填充。
loc_0232C71E:
	swi 0xc	; 0232C71E
	bx lr	; 0232C720
.endfunc
.func P1_SwiSqrt
; BIOS SWI #0D: integer square root. / BIOS SWI #0D：整数平方根。
	swi 0xd
	bx lr
.endfunc

.func P1_SwiGetCrc16
; BIOS SWI #0E: CRC-16 service. / BIOS SWI #0E：CRC-16 服务。
loc_0232C726:
	swi 0xe	; 0232C726
	bx lr	; 0232C728
.endfunc
.func P1_SwiIsDebugger
; BIOS SWI #0F: detect debugger state. / BIOS SWI #0F：检测调试器状态。
	swi 0x0f
	bx lr
.endfunc

.func P1_SwiBitUnPack
; BIOS SWI #10: BitUnPack decoder. / BIOS SWI #10：BitUnPack 解码器。
loc_0232C72E:
	swi 0x10	; 0232C72E
	bx lr	; 0232C730
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

.func P1_SwiHuffUnComp
; BIOS SWI #13: Huffman decoder. / BIOS SWI #13：Huffman 解码器。
loc_0232C73A:
	swi 0x13	; 0232C73A
	bx lr	; 0232C73C
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
loc_0232C748:
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
loc_0232C7BC:
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
loc_0232C898:
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x10, 0xB4, 0x81, 0xB0, 0x00, 0x2A, 0x17, 0xD0, 0x04, 0x78, 0x40, 0x1C	; 0232C8A8
	.byte 0x0B, 0x78, 0x49, 0x1C, 0x9C, 0x42, 0x0E, 0xD0, 0x40, 0x1E, 0x02, 0x78, 0x48, 0x1E, 0x00, 0x78	; 0232C8B8
	.byte 0x82, 0x42, 0x04, 0xD2, 0x00, 0x20, 0xC0, 0x43, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x01, 0x20	; 0232C8C8
	.byte 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x52, 0x1E, 0x00, 0x2A, 0xE7, 0xD1, 0x00, 0x20, 0x01, 0xB0	; 0232C8D8
	.byte 0x10, 0xBC, 0x70, 0x47	; 0232C8DC

; Standard memset: fill r2 bytes at r0 with low byte of r1 and return original r0.
; 标准 memset：以 r1 低字节填充 r0 起始的 r2 字节，并返回原 r0。
P1_MemSet:
; ===== function loc_0232C8DC =====
	push {r4,lr}	; 0232C8DC
	add r4,r0,#0x0	; 0232C8DE
	bl P1_MemSetCore	; 0232C8E0
	add r0,r4,#0x0	; 0232C8E4
	pop {r4}	; 0232C8E6
	pop {r3}	; 0232C8E8
	bx r3	; 0232C8EA

; ===== function loc_0232C8EC =====
; Core byte/word fill loop; r0 advances to the end. / 核心字节/字填充循环；r0 前进至末尾。
P1_MemSetCore:
loc_0232C8EC:
	push {r4,r5}	; 0232C8EC
	lsl r1,r1,#0x18	; 0232C8EE
	lsr r1,r1,#0x18	; 0232C8F0
	cmp r2,#0x20	; 0232C8F2
	bcc loc_0232C95A	; 0232C8F4
	neg r4,r0	; 0232C8F6
	mov r3,#0x3	; 0232C8F8
	and r4,r3	; 0232C8FA
	cmp r4,#0x0	; 0232C8FC
	beq loc_0232C910	; 0232C8FE
	sub r2,r2,r4	; 0232C900
	lsl r3,r1,#0x18	; 0232C902
	lsr r3,r3,#0x18	; 0232C904
loc_0232C906:
	strb r3,[r0,#0x0]	; 0232C906
	add r0,r0,#0x1	; 0232C908
	sub r4,r4,#0x1	; 0232C90A
	cmp r4,#0x0	; 0232C90C
	bne loc_0232C906	; 0232C90E
loc_0232C910:
	cmp r1,#0x0	; 0232C910
	beq loc_0232C920	; 0232C912
	lsl r5,r1,#0x8	; 0232C914
	lsl r4,r1,#0x18	; 0232C916
	lsl r3,r1,#0x10	; 0232C918
	orr r4,r3	; 0232C91A
	orr r5,r4	; 0232C91C
	orr r1,r5	; 0232C91E
loc_0232C920:
	lsr r4,r2,#0x5	; 0232C920
	cmp r4,#0x0	; 0232C922
	beq loc_0232C942	; 0232C924
loc_0232C926:
	str r1,[r0,#0x0]	; 0232C926
	str r1,[r0,#0x4]	; 0232C928
	str r1,[r0,#0x8]	; 0232C92A
	str r1,[r0,#0xc]	; 0232C92C
	str r1,[r0,#0x10]	; 0232C92E
	str r1,[r0,#0x14]	; 0232C930
	str r1,[r0,#0x18]	; 0232C932
	add r3,r0,#0x0	; 0232C934
	add r3,#0x1c	; 0232C936
	add r0,#0x20	; 0232C938
	str r1,[r3,#0x0]	; 0232C93A
	sub r4,r4,#0x1	; 0232C93C
	cmp r4,#0x0	; 0232C93E
	bne loc_0232C926	; 0232C940
loc_0232C942:
	mov r3,#0x1f	; 0232C942
	add r4,r2,#0x0	; 0232C944
	and r4,r3	; 0232C946
	lsr r3,r4,#0x2	; 0232C948
	cmp r3,#0x0	; 0232C94A
	beq loc_0232C956	; 0232C94C
loc_0232C94E:
	stmia r0!,{r1}	; 0232C94E
	sub r3,r3,#0x1	; 0232C950
	cmp r3,#0x0	; 0232C952
	bne loc_0232C94E	; 0232C954
loc_0232C956:
	mov r3,#0x3	; 0232C956
	and r2,r3	; 0232C958
loc_0232C95A:
	cmp r2,#0x0	; 0232C95A
	beq loc_0232C96C	; 0232C95C
	lsl r1,r1,#0x18	; 0232C95E
	lsr r1,r1,#0x18	; 0232C960
loc_0232C962:
	strb r1,[r0,#0x0]	; 0232C962
	add r0,r0,#0x1	; 0232C964
	sub r2,r2,#0x1	; 0232C966
	cmp r2,#0x0	; 0232C968
	bne loc_0232C962	; 0232C96A
loc_0232C96C:
	pop {r4,r5}	; 0232C96C
	bx lr	; 0232C96E

; UTF-16 strchr: find a code unit, including the terminating NUL. / UTF-16 strchr：查找码元，包括结尾 NUL。
P1_Utf16StrChr:
; ===== function loc_0232C970 =====
loc_0232C970:
	add r2,r0,#0x2	; 0232C970
	ldrh r0,[r0,#0x0]	; 0232C972
	cmp r0,#0x0	; 0232C974
	beq loc_0232C988	; 0232C976
loc_0232C978:
	cmp r0,r1	; 0232C978
	bne loc_0232C980	; 0232C97A
	sub r0,r2,#0x2	; 0232C97C
	bx lr	; 0232C97E
loc_0232C980:
	ldrh r0,[r2,#0x0]	; 0232C980
	add r2,r2,#0x2	; 0232C982
	cmp r0,#0x0	; 0232C984
	bne loc_0232C978	; 0232C986
loc_0232C988:
	cmp r1,#0x0	; 0232C988
	beq loc_0232C990	; 0232C98A
	mov r0,#0x0	; 0232C98C
	bx lr	; 0232C98E
loc_0232C990:
	sub r0,r2,#0x2	; 0232C990
	bx lr	; 0232C992

; UTF-16 bounded comparison. / UTF-16 定长字符串比较。
P1_Utf16StrNCmp:
; ===== function loc_0232C994 =====
	push {r4}	; 0232C994
	sub sp,#0x4	; 0232C996
	cmp r2,#0x0	; 0232C998
	beq loc_0232C9BA	; 0232C99A
loc_0232C99C:
	ldrh r4,[r1,#0x0]	; 0232C99C
	add r1,r1,#0x2	; 0232C99E
	ldrh r3,[r0,#0x0]	; 0232C9A0
	add r0,r0,#0x2	; 0232C9A2
	cmp r3,r4	; 0232C9A4
	beq loc_0232C9B0	; 0232C9A6
	sub r0,r3,r4	; 0232C9A8
	add sp,#0x4	; 0232C9AA
	pop {r4}	; 0232C9AC
	bx lr	; 0232C9AE
loc_0232C9B0:
	cmp r3,#0x0	; 0232C9B0
	beq loc_0232C9BA	; 0232C9B2
	sub r2,r2,#0x1	; 0232C9B4
	cmp r2,#0x0	; 0232C9B6
	bne loc_0232C99C	; 0232C9B8
loc_0232C9BA:
	mov r0,#0x0	; 0232C9BA
	add sp,#0x4	; 0232C9BC
	pop {r4}	; 0232C9BE
	bx lr	; 0232C9C0
	.byte 0x00, 0x00, 0x10, 0xB4, 0x81, 0xB0, 0x04, 0x1C, 0x22, 0x88, 0xA4, 0x1C, 0x00, 0x2A, 0xFB, 0xD1	; 0232C9D2
	.byte 0xA4, 0x1E, 0x23, 0x1C, 0x0A, 0x88, 0x89, 0x1C, 0x22, 0x80, 0xA4, 0x1C, 0x1A, 0x88, 0x00, 0x2A	; 0232C9E2
	.byte 0xF7, 0xD1, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x00, 0x00	; 0232C9EC

; UTF-16 bounded copy with NUL padding. / UTF-16 定长复制，结尾不足时补 NUL。
P1_Utf16StrNCpy:
; ===== function loc_0232C9EC =====
loc_0232C9EC:
	push {r4,r5}	; 0232C9EC
	add r5,r0,#0x0	; 0232C9EE
	cmp r2,#0x0	; 0232C9F0
	beq loc_0232CA20	; 0232C9F2
loc_0232C9F4:
	add r4,r5,#0x0	; 0232C9F4
	ldrh r3,[r1,#0x0]	; 0232C9F6
	add r1,r1,#0x2	; 0232C9F8
	strh r3,[r5,#0x0]	; 0232C9FA
	add r5,r5,#0x2	; 0232C9FC
	ldrh r3,[r4,#0x0]	; 0232C9FE
	cmp r3,#0x0	; 0232CA00
	bne loc_0232CA1A	; 0232CA02
	sub r2,r2,#0x1	; 0232CA04
	cmp r2,#0x0	; 0232CA06
	beq loc_0232CA20	; 0232CA08
	mov r1,#0x0	; 0232CA0A
loc_0232CA0C:
	strh r1,[r5,#0x0]	; 0232CA0C
	add r5,r5,#0x2	; 0232CA0E
	sub r2,r2,#0x1	; 0232CA10
	cmp r2,#0x0	; 0232CA12
	bne loc_0232CA0C	; 0232CA14
	pop {r4,r5}	; 0232CA16
	bx lr	; 0232CA18
loc_0232CA1A:
	sub r2,r2,#0x1	; 0232CA1A
	cmp r2,#0x0	; 0232CA1C
	bne loc_0232C9F4	; 0232CA1E
loc_0232CA20:
	pop {r4,r5}	; 0232CA20
	bx lr	; 0232CA22

; UTF-16 unbounded copy through the terminating NUL. / UTF-16 复制，直至结尾 NUL。
P1_Utf16StrCpy:
; ===== function loc_0232CA24 =====
loc_0232CA24:
	push {r4}	; 0232CA24
	sub sp,#0x4	; 0232CA26
	add r4,r0,#0x0	; 0232CA28
loc_0232CA2A:
	add r3,r4,#0x0	; 0232CA2A
	ldrh r2,[r1,#0x0]	; 0232CA2C
	add r1,r1,#0x2	; 0232CA2E
	strh r2,[r4,#0x0]	; 0232CA30
	add r4,r4,#0x2	; 0232CA32
	ldrh r2,[r3,#0x0]	; 0232CA34
	cmp r2,#0x0	; 0232CA36
	bne loc_0232CA2A	; 0232CA38
	add sp,#0x4	; 0232CA3A
	pop {r4}	; 0232CA3C
	bx lr	; 0232CA3E
; UTF-16 strlen: count code units before the terminating NUL. / UTF-16 strlen：统计结尾 NUL 前的码元数。
P1_Utf16StrLen:
; ===== function loc_0232CA40 =====
loc_0232CA40:
	mov r1,#0x0	; 0232CA40
	mvn r2,r1	; 0232CA42
loc_0232CA44:
	add r2,r2,#0x1	; 0232CA44
	ldrh r1,[r0,#0x0]	; 0232CA46
	add r0,r0,#0x2	; 0232CA48
	cmp r1,#0x0	; 0232CA4A
	bne loc_0232CA44	; 0232CA4C
	add r0,r2,#0x0	; 0232CA4E
	bx lr	; 0232CA50
	.hword 0x0000	; padding / 对齐填充。
.arm

; ===== function loc_0232CA54 =====
loc_0232CA54:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CA54
	mov r4,#0x0	; 0232CA58
	b loc_0232CA68	; 0232CA5C
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 0232CA68
loc_0232CA68:
	orrs r5,r3,r2	; 0232CA68
	bne loc_0232CA78	; 0232CA6C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CA70
	bx lr	; 0232CA74
loc_0232CA78:
	orrs r5,r1,r3	; 0232CA78
	bne loc_0232CB20	; 0232CA7C
	mov r1,r2	; 0232CA80
	bl loc_0232CE90	; 0232CA84
	cmp r4,#0x0	; 0232CA88
	movne r0,r1	; 0232CA8C
	mov r1,#0x0	; 0232CA90
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CA94
	bx lr	; 0232CA98
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 0232CAAC
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x03, 0x40, 0x21, 0xE0, 0xC4, 0x40, 0xA0, 0xE1, 0x84, 0x40, 0xA0, 0xE1	; 0232CABC
	.byte 0x02, 0x50, 0x93, 0xE1, 0x01, 0x00, 0x00, 0x1A, 0xF0, 0x58, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 0232CACC
	.byte 0xA0, 0x5F, 0xA0, 0xE1, 0x01, 0x50, 0x85, 0xE0, 0xA2, 0x6F, 0xA0, 0xE1, 0x03, 0x60, 0x86, 0xE0	; 0232CADC
	.byte 0x06, 0x60, 0x95, 0xE1, 0x06, 0x00, 0x00, 0x1A, 0x02, 0x10, 0xA0, 0xE1, 0x63, 0x00, 0x00, 0xEB	; 0232CAEC
	.byte 0x01, 0x40, 0x14, 0xE2, 0x01, 0x00, 0xA0, 0x11, 0xC0, 0x1F, 0xA0, 0xE1, 0xF0, 0x58, 0xBD, 0xE8	; 0232CAFC
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x00, 0x00, 0x51, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x00, 0x70, 0xE2	; 0232CB0C
	.byte 0x00, 0x10, 0xE1, 0xE2, 0x00, 0x00, 0x53, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x20, 0x72, 0xE2	; 0232CB1C
	.byte 0x00, 0x30, 0xE3, 0xE2	; 0232CB20
loc_0232CB20:
	orrs r5,r1,r0	; 0232CB20
	beq loc_0232CC44	; 0232CB24
	mov r5,#0x0	; 0232CB28
	mov r6,#0x1	; 0232CB2C
	cmp r3,#0x0	; 0232CB30
	bmi loc_0232CB4C	; 0232CB34
loc_0232CB38:
	add r5,r5,#0x1	; 0232CB38
	adds r2,r2,r2	; 0232CB3C
	adcs r3,r3,r3	; 0232CB40
	bpl loc_0232CB38	; 0232CB44
	add r6,r6,r5	; 0232CB48
loc_0232CB4C:
	cmp r1,#0x0	; 0232CB4C
	blt loc_0232CB6C	; 0232CB50
loc_0232CB54:
	cmp r6,#0x1	; 0232CB54
	beq loc_0232CB6C	; 0232CB58
	sub r6,r6,#0x1	; 0232CB5C
	adds r0,r0,r0	; 0232CB60
	adcs r1,r1,r1	; 0232CB64
	bpl loc_0232CB54	; 0232CB68
loc_0232CB6C:
	mov r7,#0x0	; 0232CB6C
	mov r12,#0x0	; 0232CB70
	mov r11,#0x0	; 0232CB74
	b loc_0232CB94	; 0232CB78
loc_0232CB7C:
	orr r12,r12,#0x1	; 0232CB7C
	subs r6,r6,#0x1	; 0232CB80
	beq loc_0232CBEC	; 0232CB84
	adds r0,r0,r0	; 0232CB88
	adcs r1,r1,r1	; 0232CB8C
	adcs r7,r7,r7	; 0232CB90
loc_0232CB94:
	subs r0,r0,r2	; 0232CB94
	sbcs r1,r1,r3	; 0232CB98
	sbcs r7,r7,#0x0	; 0232CB9C
	adds r12,r12,r12	; 0232CBA0
	adc r11,r11,r11	; 0232CBA4
	cmp r7,#0x0	; 0232CBA8
	bge loc_0232CB7C	; 0232CBAC
loc_0232CBB0:
	subs r6,r6,#0x1	; 0232CBB0
	beq loc_0232CBE4	; 0232CBB4
	adds r0,r0,r0	; 0232CBB8
	adcs r1,r1,r1	; 0232CBBC
	adc r7,r7,r7	; 0232CBC0
	adds r0,r0,r2	; 0232CBC4
	adcs r1,r1,r3	; 0232CBC8
	adc r7,r7,#0x0	; 0232CBCC
	adds r12,r12,r12	; 0232CBD0
	adc r11,r11,r11	; 0232CBD4
	cmp r7,#0x0	; 0232CBD8
	bge loc_0232CB7C	; 0232CBDC
	b loc_0232CBB0	; 0232CBE0
loc_0232CBE4:
	adds r0,r0,r2	; 0232CBE4
	adc r1,r1,r3	; 0232CBE8
loc_0232CBEC:
	ands r7,r4,#0x1	; 0232CBEC
	moveq r0,r12	; 0232CBF0
	moveq r1,r11	; 0232CBF4
	beq loc_0232CC24	; 0232CBF8
	subs r7,r5,#0x20	; 0232CBFC
	movge r0,r1, lsr r7	; 0232CC00
	bge loc_0232CC48	; 0232CC04
	rsb r7,r5,#0x20	; 0232CC08
	mov r0,r0, lsr r5	; 0232CC0C
	orr r0,r0,r1, lsl r7	; 0232CC10
	mov r1,r1, lsr r5	; 0232CC14
	b loc_0232CC24	; 0232CC18
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 0232CC24
loc_0232CC24:
	cmp r4,#0x0	; 0232CC24
	blt loc_0232CC34	; 0232CC28
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CC2C
	bx lr	; 0232CC30
loc_0232CC34:
	rsbs r0,r0,#0x0	; 0232CC34
	rsc r1,r1,#0x0	; 0232CC38
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CC3C
	bx lr	; 0232CC40
loc_0232CC44:
	mov r0,#0x0	; 0232CC44
loc_0232CC48:
	mov r1,#0x0	; 0232CC48
	cmp r4,#0x0	; 0232CC4C
	blt loc_0232CC34	; 0232CC50
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CC54
	bx lr	; 0232CC58

; ARM EABI 64-bit multiply (__aeabi_lmul); the bit pattern is identical for signed and unsigned operands. / ARM EABI 64 位乘法（__aeabi_lmul）；有符号与无符号操作数的位级结果相同。
P1_AeabiLmul:
; ===== function loc_0232CC5C =====
loc_0232CC5C:
	stmdb sp!,{r4,r5,lr}	; 0232CC5C
	umull r5,r4,r0,r2	; 0232CC60
	mla r4,r0,r3,r4	; 0232CC64
	mla r4,r2,r1,r4	; 0232CC68
	mov r1,r4	; 0232CC6C
	mov r0,r5	; 0232CC70
	ldmia sp!,{r4,r5,lr}	; 0232CC74
	bx lr	; 0232CC78

; 32-bit signed division with remainder: r0 = quotient, r1 = remainder. / 32 位有符号除法及取余：r0 为商，r1 为余数。
P1_SignedDivMod:
; ===== function loc_0232CC7C =====
loc_0232CC7C:
	eor r12,r0,r1	; 0232CC7C
	and r12,r12,#0x80000000	; 0232CC80
	cmp r0,#0x0	; 0232CC84
	rsblt r0,r0,#0x0	; 0232CC88
	addlt r12,r12,#0x1	; 0232CC8C
	cmp r1,#0x0	; 0232CC90
	rsblt r1,r1,#0x0	; 0232CC94
	beq loc_0232CE74	; 0232CC98
	cmp r0,r1	; 0232CC9C
	movcc r1,r0	; 0232CCA0
	movcc r0,#0x0	; 0232CCA4
	bcc loc_0232CE74	; 0232CCA8
	mov r2,#0x1c	; 0232CCAC
	mov r3,r0, lsr #0x4	; 0232CCB0
	cmp r1,r3, lsr #0xc	; 0232CCB4
	suble r2,r2,#0x10	; 0232CCB8
	movle r3,r3, lsr #0x10	; 0232CCBC
	cmp r1,r3, lsr #0x4	; 0232CCC0
	suble r2,r2,#0x8	; 0232CCC4
	movle r3,r3, lsr #0x8	; 0232CCC8
	cmp r1,r3	; 0232CCCC
	suble r2,r2,#0x4	; 0232CCD0
	movle r3,r3, lsr #0x4	; 0232CCD4
	mov r0,r0, lsl r2	; 0232CCD8
	rsb r1,r1,#0x0	; 0232CCDC
	adds r0,r0,r0	; 0232CCE0
	add r2,r2,r2, lsl #0x1	; 0232CCE4
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CCE8PC:
	add pc,pc,r2, lsl #0x2	; 0232CCE8
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CCF0
loc_0232CCF0:
P1_DivisionDispatch_0232CCE8Steps:
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
loc_0232CD20:
	adcs r3,r1,r3, lsl #0x1	; 0232CD20
	subcc r3,r3,r1	; 0232CD24
	adcs r0,r0,r0	; 0232CD28
	adcs r3,r1,r3, lsl #0x1	; 0232CD2C
	subcc r3,r3,r1	; 0232CD30
	adcs r0,r0,r0	; 0232CD34
	adcs r3,r1,r3, lsl #0x1	; 0232CD38
	subcc r3,r3,r1	; 0232CD3C
	adcs r0,r0,r0	; 0232CD40
	adcs r3,r1,r3, lsl #0x1	; 0232CD44
	subcc r3,r3,r1	; 0232CD48
	adcs r0,r0,r0	; 0232CD4C
loc_0232CD50:
	adcs r3,r1,r3, lsl #0x1	; 0232CD50
	subcc r3,r3,r1	; 0232CD54
	adcs r0,r0,r0	; 0232CD58
	adcs r3,r1,r3, lsl #0x1	; 0232CD5C
	subcc r3,r3,r1	; 0232CD60
	adcs r0,r0,r0	; 0232CD64
	adcs r3,r1,r3, lsl #0x1	; 0232CD68
	subcc r3,r3,r1	; 0232CD6C
	adcs r0,r0,r0	; 0232CD70
	adcs r3,r1,r3, lsl #0x1	; 0232CD74
	subcc r3,r3,r1	; 0232CD78
	adcs r0,r0,r0	; 0232CD7C
	adcs r3,r1,r3, lsl #0x1	; 0232CD80
	subcc r3,r3,r1	; 0232CD84
	adcs r0,r0,r0	; 0232CD88
	adcs r3,r1,r3, lsl #0x1	; 0232CD8C
	subcc r3,r3,r1	; 0232CD90
	adcs r0,r0,r0	; 0232CD94
	adcs r3,r1,r3, lsl #0x1	; 0232CD98
	subcc r3,r3,r1	; 0232CD9C
	adcs r0,r0,r0	; 0232CDA0
	adcs r3,r1,r3, lsl #0x1	; 0232CDA4
	subcc r3,r3,r1	; 0232CDA8
	adcs r0,r0,r0	; 0232CDAC
loc_0232CDB0:
	adcs r3,r1,r3, lsl #0x1	; 0232CDB0
	subcc r3,r3,r1	; 0232CDB4
	adcs r0,r0,r0	; 0232CDB8
	adcs r3,r1,r3, lsl #0x1	; 0232CDBC
	subcc r3,r3,r1	; 0232CDC0
	adcs r0,r0,r0	; 0232CDC4
	adcs r3,r1,r3, lsl #0x1	; 0232CDC8
	subcc r3,r3,r1	; 0232CDCC
	adcs r0,r0,r0	; 0232CDD0
	adcs r3,r1,r3, lsl #0x1	; 0232CDD4
	subcc r3,r3,r1	; 0232CDD8
	adcs r0,r0,r0	; 0232CDDC
	adcs r3,r1,r3, lsl #0x1	; 0232CDE0
	subcc r3,r3,r1	; 0232CDE4
	adcs r0,r0,r0	; 0232CDE8
	adcs r3,r1,r3, lsl #0x1	; 0232CDEC
	subcc r3,r3,r1	; 0232CDF0
	adcs r0,r0,r0	; 0232CDF4
	adcs r3,r1,r3, lsl #0x1	; 0232CDF8
	subcc r3,r3,r1	; 0232CDFC
	adcs r0,r0,r0	; 0232CE00
	adcs r3,r1,r3, lsl #0x1	; 0232CE04
	subcc r3,r3,r1	; 0232CE08
	adcs r0,r0,r0	; 0232CE0C
	adcs r3,r1,r3, lsl #0x1	; 0232CE10
	subcc r3,r3,r1	; 0232CE14
	adcs r0,r0,r0	; 0232CE18
	adcs r3,r1,r3, lsl #0x1	; 0232CE1C
	subcc r3,r3,r1	; 0232CE20
	adcs r0,r0,r0	; 0232CE24
	adcs r3,r1,r3, lsl #0x1	; 0232CE28
	subcc r3,r3,r1	; 0232CE2C
	adcs r0,r0,r0	; 0232CE30
	adcs r3,r1,r3, lsl #0x1	; 0232CE34
	subcc r3,r3,r1	; 0232CE38
	adcs r0,r0,r0	; 0232CE3C
	adcs r3,r1,r3, lsl #0x1	; 0232CE40
	subcc r3,r3,r1	; 0232CE44
	adcs r0,r0,r0	; 0232CE48
	adcs r3,r1,r3, lsl #0x1	; 0232CE4C
	subcc r3,r3,r1	; 0232CE50
	adcs r0,r0,r0	; 0232CE54
	adcs r3,r1,r3, lsl #0x1	; 0232CE58
	subcc r3,r3,r1	; 0232CE5C
	adcs r0,r0,r0	; 0232CE60
	adcs r3,r1,r3, lsl #0x1	; 0232CE64
	subcc r3,r3,r1	; 0232CE68
	adcs r0,r0,r0	; 0232CE6C
P1_DivisionDispatch_0232CCE8End:
.if (P1_DivisionDispatch_0232CCE8Steps != P1_DivisionDispatch_0232CCE8PC + 8) || (P1_DivisionDispatch_0232CCE8End - P1_DivisionDispatch_0232CCE8Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232CE70
loc_0232CE74:
	ands r3,r12,#0x80000000	; 0232CE74
	rsbne r0,r0,#0x0	; 0232CE78
	ands r3,r12,#0x1	; 0232CE7C
	rsbne r1,r1,#0x0	; 0232CE80
	bx lr	; 0232CE84

; 32-bit unsigned division with remainder; the first entry returns immediately for a zero divisor. / 32 位无符号除法及取余；除数为零时第一个入口直接返回。
P1_UnsignedDivMod:
; ===== function loc_0232CE88 =====
loc_0232CE88:
	cmp r1,#0x0	; 0232CE88
	bxeq lr	; 0232CE8C

; ===== function loc_0232CE90 =====
loc_0232CE90:
	cmp r0,r1	; 0232CE90
	movcc r1,r0	; 0232CE94
	movcc r0,#0x0	; 0232CE98
	bxcc lr	; 0232CE9C
	mov r2,#0x1c	; 0232CEA0
	mov r3,r0, lsr #0x4	; 0232CEA4
	cmp r1,r3, lsr #0xc	; 0232CEA8
	suble r2,r2,#0x10	; 0232CEAC
	movle r3,r3, lsr #0x10	; 0232CEB0
	cmp r1,r3, lsr #0x4	; 0232CEB4
	suble r2,r2,#0x8	; 0232CEB8
	movle r3,r3, lsr #0x8	; 0232CEBC
	cmp r1,r3	; 0232CEC0
	suble r2,r2,#0x4	; 0232CEC4
	movle r3,r3, lsr #0x4	; 0232CEC8
	mov r0,r0, lsl r2	; 0232CECC
	rsb r1,r1,#0x0	; 0232CED0
	adds r0,r0,r0	; 0232CED4
	add r2,r2,r2, lsl #0x1	; 0232CED8
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CEDCPC:
	add pc,pc,r2, lsl #0x2	; 0232CEDC
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CEE4
loc_0232CEE4:
P1_DivisionDispatch_0232CEDCSteps:
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
loc_0232CF14:
	adcs r3,r1,r3, lsl #0x1	; 0232CF14
	subcc r3,r3,r1	; 0232CF18
	adcs r0,r0,r0	; 0232CF1C
	adcs r3,r1,r3, lsl #0x1	; 0232CF20
	subcc r3,r3,r1	; 0232CF24
	adcs r0,r0,r0	; 0232CF28
	adcs r3,r1,r3, lsl #0x1	; 0232CF2C
	subcc r3,r3,r1	; 0232CF30
	adcs r0,r0,r0	; 0232CF34
	adcs r3,r1,r3, lsl #0x1	; 0232CF38
	subcc r3,r3,r1	; 0232CF3C
	adcs r0,r0,r0	; 0232CF40
loc_0232CF44:
	adcs r3,r1,r3, lsl #0x1	; 0232CF44
	subcc r3,r3,r1	; 0232CF48
	adcs r0,r0,r0	; 0232CF4C
	adcs r3,r1,r3, lsl #0x1	; 0232CF50
	subcc r3,r3,r1	; 0232CF54
	adcs r0,r0,r0	; 0232CF58
	adcs r3,r1,r3, lsl #0x1	; 0232CF5C
	subcc r3,r3,r1	; 0232CF60
	adcs r0,r0,r0	; 0232CF64
	adcs r3,r1,r3, lsl #0x1	; 0232CF68
	subcc r3,r3,r1	; 0232CF6C
	adcs r0,r0,r0	; 0232CF70
	adcs r3,r1,r3, lsl #0x1	; 0232CF74
	subcc r3,r3,r1	; 0232CF78
	adcs r0,r0,r0	; 0232CF7C
	adcs r3,r1,r3, lsl #0x1	; 0232CF80
	subcc r3,r3,r1	; 0232CF84
	adcs r0,r0,r0	; 0232CF88
	adcs r3,r1,r3, lsl #0x1	; 0232CF8C
	subcc r3,r3,r1	; 0232CF90
	adcs r0,r0,r0	; 0232CF94
	adcs r3,r1,r3, lsl #0x1	; 0232CF98
	subcc r3,r3,r1	; 0232CF9C
	adcs r0,r0,r0	; 0232CFA0
loc_0232CFA4:
	adcs r3,r1,r3, lsl #0x1	; 0232CFA4
	subcc r3,r3,r1	; 0232CFA8
	adcs r0,r0,r0	; 0232CFAC
	adcs r3,r1,r3, lsl #0x1	; 0232CFB0
	subcc r3,r3,r1	; 0232CFB4
	adcs r0,r0,r0	; 0232CFB8
	adcs r3,r1,r3, lsl #0x1	; 0232CFBC
	subcc r3,r3,r1	; 0232CFC0
	adcs r0,r0,r0	; 0232CFC4
	adcs r3,r1,r3, lsl #0x1	; 0232CFC8
	subcc r3,r3,r1	; 0232CFCC
	adcs r0,r0,r0	; 0232CFD0
	adcs r3,r1,r3, lsl #0x1	; 0232CFD4
	subcc r3,r3,r1	; 0232CFD8
	adcs r0,r0,r0	; 0232CFDC
	adcs r3,r1,r3, lsl #0x1	; 0232CFE0
	subcc r3,r3,r1	; 0232CFE4
	adcs r0,r0,r0	; 0232CFE8
	adcs r3,r1,r3, lsl #0x1	; 0232CFEC
	subcc r3,r3,r1	; 0232CFF0
	adcs r0,r0,r0	; 0232CFF4
	adcs r3,r1,r3, lsl #0x1	; 0232CFF8
	subcc r3,r3,r1	; 0232CFFC
	adcs r0,r0,r0	; 0232D000
	adcs r3,r1,r3, lsl #0x1	; 0232D004
	subcc r3,r3,r1	; 0232D008
	adcs r0,r0,r0	; 0232D00C
	adcs r3,r1,r3, lsl #0x1	; 0232D010
	subcc r3,r3,r1	; 0232D014
	adcs r0,r0,r0	; 0232D018
	adcs r3,r1,r3, lsl #0x1	; 0232D01C
	subcc r3,r3,r1	; 0232D020
	adcs r0,r0,r0	; 0232D024
	adcs r3,r1,r3, lsl #0x1	; 0232D028
	subcc r3,r3,r1	; 0232D02C
	adcs r0,r0,r0	; 0232D030
	adcs r3,r1,r3, lsl #0x1	; 0232D034
	subcc r3,r3,r1	; 0232D038
	adcs r0,r0,r0	; 0232D03C
	adcs r3,r1,r3, lsl #0x1	; 0232D040
	subcc r3,r3,r1	; 0232D044
	adcs r0,r0,r0	; 0232D048
	adcs r3,r1,r3, lsl #0x1	; 0232D04C
	subcc r3,r3,r1	; 0232D050
	adcs r0,r0,r0	; 0232D054
	adcs r3,r1,r3, lsl #0x1	; 0232D058
	subcc r3,r3,r1	; 0232D05C
	adcs r0,r0,r0	; 0232D060
P1_DivisionDispatch_0232CEDCEnd:
.if (P1_DivisionDispatch_0232CEDCSteps != P1_DivisionDispatch_0232CEDCPC + 8) || (P1_DivisionDispatch_0232CEDCEnd - P1_DivisionDispatch_0232CEDCSteps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232D064
	bx lr	; 0232D068

; ===== function loc_0232D06C =====
; 清空启动期控制块；具体字段含义仍待逐项确认。
; Clears early runtime control blocks; individual fields remain to be mapped.
P1_InitializeRuntimeState:
loc_0232D06C:
	stmdb sp!,{lr}	; 0232D06C
	blx loc_0232D14C	; 0232D070
	mov r1,#0x0	; 0232D074
	str r1,[r0,#0x0]	; 0232D078
	blx loc_0232D154	; 0232D07C
	mov r1,#0x0	; 0232D080
	str r1,[r0,#0x4]	; 0232D084
	str r1,[r0,#0x8]	; 0232D088
	str r1,[r0,#0xc]	; 0232D08C
	str r1,[r0,#0x10]	; 0232D090
	str r1,[r0,#0x14]	; 0232D094
	ldmia sp!,{lr}	; 0232D098
	bx lr	; 0232D09C
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x28, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232D0B0
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232D0C0
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 0232D0D0
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 0232D0E0
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x18, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232D0F0
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232D100
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 0232D110
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 0232D114
.thumb

; ===== function loc_0232D114 =====
loc_0232D114:
	add r3,r0,#0x0	; 0232D114
	cmp r0,#0x0	; 0232D116
	beq loc_0232D12A	; 0232D118
	cmp r1,#0x0	; 0232D11A
	beq loc_0232D12A	; 0232D11C
	mov r2,#0x0	; 0232D11E
loc_0232D120:
	strb r2,[r3,#0x0]	; 0232D120
	add r3,r3,#0x1	; 0232D122
	sub r1,r1,#0x1	; 0232D124
	cmp r1,#0x0	; 0232D126
	bne loc_0232D120	; 0232D128
loc_0232D12A:
	bx lr	; 0232D12A

; ===== function loc_0232D12C =====
; 依次调用以 NULL 结尾的函数指针表。
; Calls a NULL-terminated table of function pointers.
P1_CallStaticInitializers:
loc_0232D12C:
	push {r4,lr}	; 0232D12C
	ldr r4,[pool_0232D148]	; 0232D12E
	b loc_0232D136	; 0232D130
loc_0232D132:
	blx r0	; 0232D132
	add r4,r4,#0x4	; 0232D134
loc_0232D136:
	cmp r4,#0x0	; 0232D136
	beq loc_0232D140	; 0232D138
	ldr r0,[r4,#0x0]	; 0232D13A
	cmp r0,#0x0	; 0232D13C
	bne loc_0232D132	; 0232D13E
loc_0232D140:
	pop {r4}	; 0232D140
	pop {r3}	; 0232D142
	bx r3	; 0232D144
	.byte 0xC0, 0x46	; 0232D148
pool_0232D148:
loc_0232D148:
	.word 0x023304C4	; 0232D148

; ===== function loc_0232D14C =====
loc_0232D14C:
	ldr r0,[pool_0232D150]	; 0232D14C
	bx lr	; 0232D14E
pool_0232D150:
loc_0232D150:
	.word 0x02357050	; 0232D150

; ===== function loc_0232D154 =====
loc_0232D154:
	ldr r0,[pool_0232D158]	; 0232D154
	bx lr	; 0232D156
pool_0232D158:
loc_0232D158:
	.word 0x02357054	; 0232D158

; ===== function loc_0232D15C =====
loc_0232D15C:
	stmia r0!,{r1}	; 0232D15C
	mov r1,#0x0	; 0232D15E
	str r2,[r0,#0x8]	; 0232D160
	mov r2,#0x0	; 0232D162
	stmia r0!,{r1,r2}	; 0232D164
	bx lr	; 0232D166

; ===== function loc_0232D168 =====
loc_0232D168:
	str r2,[r0,#0x0]	; 0232D168
	str r1,[r0,#0x4]	; 0232D16A
	neg r1,r1	; 0232D16C
	str r1,[r0,#0x8]	; 0232D16E
	str r2,[r0,#0xc]	; 0232D170
	bx lr	; 0232D172

; ===== function loc_0232D174 =====
loc_0232D174:
	push {r4,r5,r6,r7,lr}	; 0232D174
	sub sp,#0x54	; 0232D176
	add r6,r0,#0x0	; 0232D178
	add r5,r1,#0x0	; 0232D17A
	add r7,r2,#0x0	; 0232D17C
	cmp r7,r5	; 0232D17E
	bne loc_0232D186	; 0232D180
	add r4,sp,#0x40	; 0232D182
	b loc_0232D188	; 0232D184
loc_0232D186:
	add r4,r7,#0x0	; 0232D186
loc_0232D188:
	ldr r0,[r6,#0x0]	; 0232D188
	str r0,[sp,#0x10]	; 0232D18A
	ldr r0,[r6,#0x4]	; 0232D18C
	str r0,[sp,#0x14]	; 0232D18E
	asr r0,r0,#0x1f	; 0232D190
	str r0,[sp,#0x18]	; 0232D192
	ldr r0,[sp,#0x10]	; 0232D194
	asr r0,r0,#0x1f	; 0232D196
	str r0,[sp,#0x1c]	; 0232D198
	ldr r0,[sp,#0x10]	; 0232D19A
	ldr r1,[sp,#0x1c]	; 0232D19C
	ldr r2,[r5,#0x0]	; 0232D19E
	asr r3,r2,#0x1f	; 0232D1A0
	blx P1_AeabiLmul	; 0232D1A2
	str r0,[sp,#0x20]	; 0232D1A6
	str r1,[sp,#0xc]	; 0232D1A8
	ldr r0,[sp,#0x14]	; 0232D1AA
	ldr r1,[sp,#0x18]	; 0232D1AC
	ldr r2,[r5,#0x8]	; 0232D1AE
	asr r3,r2,#0x1f	; 0232D1B0
	blx P1_AeabiLmul	; 0232D1B2
	ldr r2,[sp,#0x20]	; 0232D1B6
	add r0,r2,r0	; 0232D1B8
	ldr r2,[sp,#0xc]	; 0232D1BA
	adc r2,r1	; 0232D1BC
	str r2,[sp,#0xc]	; 0232D1BE
	lsl r1,r2,#0x14	; 0232D1C0
	lsr r0,r0,#0xc	; 0232D1C2
	orr r0,r1	; 0232D1C4
	str r0,[r4,#0x0]	; 0232D1C6
	ldr r0,[sp,#0x10]	; 0232D1C8
	ldr r1,[sp,#0x1c]	; 0232D1CA
	ldr r2,[r5,#0x4]	; 0232D1CC
	asr r3,r2,#0x1f	; 0232D1CE
	blx P1_AeabiLmul	; 0232D1D0
	str r0,[sp,#0x24]	; 0232D1D4
	str r1,[sp,#0x4]	; 0232D1D6
	ldr r0,[sp,#0x14]	; 0232D1D8
	ldr r1,[sp,#0x18]	; 0232D1DA
	ldr r2,[r5,#0xc]	; 0232D1DC
	asr r3,r2,#0x1f	; 0232D1DE
	blx P1_AeabiLmul	; 0232D1E0
	ldr r2,[sp,#0x24]	; 0232D1E4
	add r0,r2,r0	; 0232D1E6
	ldr r2,[sp,#0x4]	; 0232D1E8
	adc r2,r1	; 0232D1EA
	str r2,[sp,#0x4]	; 0232D1EC
	lsl r1,r2,#0x14	; 0232D1EE
	lsr r0,r0,#0xc	; 0232D1F0
	orr r0,r1	; 0232D1F2
	str r0,[r4,#0x4]	; 0232D1F4
	ldr r0,[r6,#0xc]	; 0232D1F6
	str r0,[sp,#0x28]	; 0232D1F8
	asr r0,r0,#0x1f	; 0232D1FA
	str r0,[sp,#0x2c]	; 0232D1FC
	ldr r0,[r6,#0x8]	; 0232D1FE
	str r0,[sp,#0x30]	; 0232D200
	asr r0,r0,#0x1f	; 0232D202
	str r0,[sp,#0x34]	; 0232D204
	ldr r0,[sp,#0x30]	; 0232D206
	ldr r1,[sp,#0x34]	; 0232D208
	ldr r2,[r5,#0x0]	; 0232D20A
	asr r3,r2,#0x1f	; 0232D20C
	blx P1_AeabiLmul	; 0232D20E
	str r0,[sp,#0x38]	; 0232D212
	add r6,r1,#0x0	; 0232D214
	ldr r0,[sp,#0x28]	; 0232D216
	ldr r1,[sp,#0x2c]	; 0232D218
	ldr r2,[r5,#0x8]	; 0232D21A
	asr r3,r2,#0x1f	; 0232D21C
	blx P1_AeabiLmul	; 0232D21E
	ldr r2,[sp,#0x38]	; 0232D222
	add r2,r2,r0	; 0232D224
	adc r6,r1	; 0232D226
	lsl r0,r6,#0x14	; 0232D228
	lsr r1,r2,#0xc	; 0232D22A
	orr r1,r0	; 0232D22C
	str r1,[r4,#0x8]	; 0232D22E
	ldr r0,[sp,#0x30]	; 0232D230
	ldr r1,[sp,#0x34]	; 0232D232
	ldr r2,[r5,#0x4]	; 0232D234
	asr r3,r2,#0x1f	; 0232D236
	blx P1_AeabiLmul	; 0232D238
	str r0,[sp,#0x3c]	; 0232D23C
	add r6,r1,#0x0	; 0232D23E
	ldr r0,[sp,#0x28]	; 0232D240
	ldr r1,[sp,#0x2c]	; 0232D242
	ldr r2,[r5,#0xc]	; 0232D244
	asr r3,r2,#0x1f	; 0232D246
	blx P1_AeabiLmul	; 0232D248
	ldr r2,[sp,#0x3c]	; 0232D24C
	add r2,r2,r0	; 0232D24E
	adc r6,r1	; 0232D250
	lsl r0,r6,#0x14	; 0232D252
	lsr r1,r2,#0xc	; 0232D254
	orr r1,r0	; 0232D256
	str r1,[r4,#0xc]	; 0232D258
	add r2,sp,#0x40	; 0232D25A
	cmp r4,r2	; 0232D25C
	bne loc_0232D268	; 0232D25E
	ldmia r2!,{r0,r1}	; 0232D260
	stmia r7!,{r0,r1}	; 0232D262
	ldmia r2!,{r0,r1}	; 0232D264
	stmia r7!,{r0,r1}	; 0232D266
loc_0232D268:
	add sp,#0x54	; 0232D268
	pop {r4,r5,r6,r7}	; 0232D26A
	pop {r3}	; 0232D26C
	bx r3	; 0232D26E

; ARM9 硬件 32÷32；r0 ÷ r1，轮询完成后返回商。
; ARM9 hardware 32-by-32 division; r0 / r1, waits and returns quotient.
.func P1_Divide32By32
loc_0232D270:
	push {r4}	; 0232D270
	sub sp,#0x4	; 0232D272
	mov r4,#0x0	; 0232D274
	ldr r3,[pool_0232D298]	; 0232D276
	strh r4,[r3,#0x0]	; 0232D278
	ldr r2,[pool_0232D29C]	; 0232D27A
	str r0,[r2,#0x0]	; 0232D27C
	ldr r0,[pool_0232D2A0]	; 0232D27E
	str r1,[r0,#0x0]	; 0232D280
	str r4,[r0,#0x4]	; 0232D282
	ldr r0,[pool_0232D2A4]	; 0232D284
loc_0232D286:
	ldrh r1,[r3,#0x0]	; 0232D286
	and r1,r0	; 0232D288
	cmp r1,#0x0	; 0232D28A
	bne loc_0232D286	; 0232D28C
	ldr r0,[pool_0232D2A8]	; 0232D28E
	ldr r0,[r0,#0x0]	; 0232D290
	add sp,#0x4	; 0232D292
	pop {r4}	; 0232D294
	bx lr	; 0232D296
.endfunc
pool_0232D298:
loc_0232D298:
	.word REG_DIVCNT	; 0232D298
pool_0232D29C:
loc_0232D29C:
	.word REG_DIV_NUMER	; 0232D29C
pool_0232D2A0:
loc_0232D2A0:
	.word REG_DIV_DENOM	; 0232D2A0
pool_0232D2A4:
loc_0232D2A4:
	.word 0x00008000	; 0232D2A4
pool_0232D2A8:
loc_0232D2A8:
	.word REG_DIV_RESULT	; 0232D2A8

; 启动硬件 64÷32 的固定小数倒数计算；由配对读取函数完成结果转换。
; Starts 64-by-32 fixed-point reciprocal division; paired reader converts result.
.func P1_StartFixedPointReciprocalDivide
loc_0232D2AC:
	mov r2,#0x1	; 0232D2AC
	ldr r1,[pool_0232D2C4]	; 0232D2AE
	strh r2,[r1,#0x0]	; 0232D2B0
	mov r3,#0x0	; 0232D2B2
	ldr r2,[pool_0232D2C8]	; 0232D2B4
	ldr r1,[pool_0232D2CC]	; 0232D2B6
	str r3,[r1,#0x0]	; 0232D2B8
	str r2,[r1,#0x4]	; 0232D2BA
	ldr r1,[pool_0232D2D0]	; 0232D2BC
	str r0,[r1,#0x0]	; 0232D2BE
	str r3,[r1,#0x4]	; 0232D2C0
	bx lr	; 0232D2C2
.endfunc
pool_0232D2C4:
loc_0232D2C4:
	.word REG_DIVCNT	; 0232D2C4
pool_0232D2C8:
loc_0232D2C8:
	.word 0x00001000	; 0232D2C8
pool_0232D2CC:
loc_0232D2CC:
	.word REG_DIV_NUMER	; 0232D2CC
pool_0232D2D0:
loc_0232D2D0:
	.word REG_DIV_DENOM	; 0232D2D0

; 等待固定小数除法完成，并把 64 位商归一化为固件使用的格式。
; Waits for fixed-point division and normalises its 64-bit quotient for firmware use.
.func P1_FinishFixedPointReciprocalDivide
loc_0232D2D4:
	ldr r1,[pool_0232D2F8]	; 0232D2D4
	ldr r0,[pool_0232D2FC]	; 0232D2D6
loc_0232D2D8:
	ldrh r2,[r1,#0x0]	; 0232D2D8
	and r2,r0	; 0232D2DA
	cmp r2,#0x0	; 0232D2DC
	bne loc_0232D2D8	; 0232D2DE
	ldr r0,[pool_0232D300]	; 0232D2E0
	ldr r2,[r0,#0x0]	; 0232D2E2
	ldr r3,[r0,#0x4]	; 0232D2E4
	mov r1,#0x0	; 0232D2E6
	ldr r0,[pool_0232D304]	; 0232D2E8
	add r0,r2,r0	; 0232D2EA
	adc r3,r1	; 0232D2EC
	lsl r1,r3,#0xc	; 0232D2EE
	lsr r0,r0,#0x14	; 0232D2F0
	orr r0,r1	; 0232D2F2
	bx lr	; 0232D2F4
.endfunc
	.byte 0xC0, 0x46	; 0232D2F8
pool_0232D2F8:
loc_0232D2F8:
	.word REG_DIVCNT	; 0232D2F8
pool_0232D2FC:
loc_0232D2FC:
	.word 0x00008000	; 0232D2FC
pool_0232D300:
loc_0232D300:
	.word REG_DIV_RESULT	; 0232D300
pool_0232D304:
loc_0232D304:
	.word 0x00080000	; 0232D304

; 固定小数倒数辅助函数：依次启动并读取 ARM9 硬件除法器。
; Fixed-point reciprocal helper: starts then reads the ARM9 hardware divider.
.func P1_ComputeFixedPointReciprocal
loc_0232D308:
	push {lr}	; 0232D308
	sub sp,#0x4	; 0232D30A
	bl P1_StartFixedPointReciprocalDivide	; 0232D30C
	bl P1_FinishFixedPointReciprocalDivide	; 0232D310
	add sp,#0x4	; 0232D314
	pop {r3}	; 0232D316
	bx r3	; 0232D318
.endfunc
	.byte 0x00, 0x00	; 0232D31C
.arm

; ===== function loc_0232D31C =====
loc_0232D31C:
	smull r2,r1,r0,r1	; 0232D31C
	mov r0,#0x800	; 0232D320
	adds r0,r2,r0	; 0232D324
	adc r1,r1,#0x0	; 0232D328
	mov r0,r0, lsr #0xc	; 0232D32C
	orr r0,r0,r1, lsl #0x14	; 0232D330
	bx lr	; 0232D334
.thumb

; ===== function loc_0232D338 =====
loc_0232D338:
	cmp r1,#0x0	; 0232D338
	bne loc_0232D342	; 0232D33A
	mov r1,#0x0	; 0232D33C
	strh r1,[r0,#0x0]	; 0232D33E
	bx lr	; 0232D340
loc_0232D342:
	cmp r1,#0x0	; 0232D342
	ble loc_0232D34E	; 0232D344
	ldr r2,[pool_0232D358]	; 0232D346
	orr r1,r2	; 0232D348
	strh r1,[r0,#0x0]	; 0232D34A
	bx lr	; 0232D34C
loc_0232D34E:
	neg r2,r1	; 0232D34E
	ldr r1,[pool_0232D35C]	; 0232D350
	orr r2,r1	; 0232D352
	strh r2,[r0,#0x0]	; 0232D354
	bx lr	; 0232D356
pool_0232D358:
loc_0232D358:
	.word 0x00004000	; 0232D358
pool_0232D35C:
loc_0232D35C:
	.word 0x00008000	; 0232D35C

; ===== function loc_0232D360 =====
loc_0232D360:
	ldr r2,[pool_0232D370]	; 0232D360
	ldr r3,[r2,#0x0]	; 0232D362
	mov r1,#0x7	; 0232D364
	bic r3,r1	; 0232D366
	orr r3,r0	; 0232D368
	str r3,[r2,#0x0]	; 0232D36A
	bx lr	; 0232D36C
	.byte 0xC0, 0x46	; 0232D370
pool_0232D370:
loc_0232D370:
	.word REG_DISPCNT_B	; 0232D370

; ===== function loc_0232D374 =====
loc_0232D374:
	push {r4}	; 0232D374
	sub sp,#0x4	; 0232D376
	ldr r3,[pool_0232D3B0]	; 0232D378
	ldr r3,[r3,#0x0]	; 0232D37A
	ldr r4,[pool_0232D3B4]	; 0232D37C
	strh r0,[r4,#0x0]	; 0232D37E
	ldr r4,[pool_0232D3B8]	; 0232D380
	ldrh r4,[r4,#0x0]	; 0232D382
	cmp r4,#0x0	; 0232D384
	bne loc_0232D38A	; 0232D386
	mov r0,#0x0	; 0232D388
loc_0232D38A:
	lsl r4,r2,#0x3	; 0232D38A
	ldr r2,[pool_0232D3BC]	; 0232D38C
	and r3,r2	; 0232D38E
	lsl r0,r0,#0x10	; 0232D390
	orr r3,r0	; 0232D392
	orr r1,r3	; 0232D394
	orr r4,r1	; 0232D396
	ldr r0,[pool_0232D3B0]	; 0232D398
	str r4,[r0,#0x0]	; 0232D39A
	ldr r0,[pool_0232D3B4]	; 0232D39C
	ldrh r0,[r0,#0x0]	; 0232D39E
	cmp r0,#0x0	; 0232D3A0
	bne loc_0232D3AA	; 0232D3A2
	mov r1,#0x0	; 0232D3A4
	ldr r0,[pool_0232D3B8]	; 0232D3A6
	strh r1,[r0,#0x0]	; 0232D3A8
loc_0232D3AA:
	add sp,#0x4	; 0232D3AA
	pop {r4}	; 0232D3AC
	bx lr	; 0232D3AE
pool_0232D3B0:
loc_0232D3B0:
	.word REG_DISPCNT_A	; 0232D3B0
pool_0232D3B4:
loc_0232D3B4:
	.word P1_BssStart + 0x266AC	; 0232D3B4
pool_0232D3B8:
loc_0232D3B8:
	.word P1_Data_0233099C	; 0232D3B8
pool_0232D3BC:
loc_0232D3BC:
	.word 0xFFF0FFF0	; 0232D3BC

; ===== function loc_0232D3C0 =====
loc_0232D3C0:
	mov r1,#0x1	; 0232D3C0
	ldr r0,[pool_0232D3EC]	; 0232D3C2
	strh r1,[r0,#0x0]	; 0232D3C4
	ldr r0,[pool_0232D3F0]	; 0232D3C6
	ldrh r3,[r0,#0x0]	; 0232D3C8
	cmp r3,#0x0	; 0232D3CA
	beq loc_0232D3DE	; 0232D3CC
	ldr r1,[pool_0232D3F4]	; 0232D3CE
	ldr r2,[r1,#0x0]	; 0232D3D0
	ldr r0,[pool_0232D3F8]	; 0232D3D2
	and r2,r0	; 0232D3D4
	lsl r0,r3,#0x10	; 0232D3D6
	orr r2,r0	; 0232D3D8
	str r2,[r1,#0x0]	; 0232D3DA
	bx lr	; 0232D3DC
loc_0232D3DE:
	ldr r1,[pool_0232D3F4]	; 0232D3DE
	ldr r2,[r1,#0x0]	; 0232D3E0
	ldr r0,[pool_0232D3FC]	; 0232D3E2
	orr r2,r0	; 0232D3E4
	str r2,[r1,#0x0]	; 0232D3E6
	bx lr	; 0232D3E8
	.byte 0xC0, 0x46	; 0232D3EC
pool_0232D3EC:
loc_0232D3EC:
	.word P1_Data_0233099C	; 0232D3EC
pool_0232D3F0:
loc_0232D3F0:
	.word P1_BssStart + 0x266AC	; 0232D3F0
pool_0232D3F4:
loc_0232D3F4:
	.word REG_DISPCNT_A	; 0232D3F4
pool_0232D3F8:
loc_0232D3F8:
	.word 0xFFFCFFFF	; 0232D3F8
pool_0232D3FC:
loc_0232D3FC:
	.word 0x00010000	; 0232D3FC

; ===== function loc_0232D400 =====
loc_0232D400:
	ldr r1,[pool_0232D420]	; 0232D400
	ldr r0,[r1,#0x0]	; 0232D402
	mov r3,#0x0	; 0232D404
	ldr r2,[pool_0232D424]	; 0232D406
	strh r3,[r2,#0x0]	; 0232D408
	ldr r2,[pool_0232D428]	; 0232D40A
	add r3,r0,#0x0	; 0232D40C
	and r3,r2	; 0232D40E
	lsr r3,r3,#0x10	; 0232D410
	ldr r2,[pool_0232D42C]	; 0232D412
	strh r3,[r2,#0x0]	; 0232D414
	ldr r2,[pool_0232D430]	; 0232D416
	and r0,r2	; 0232D418
	str r0,[r1,#0x0]	; 0232D41A
	bx lr	; 0232D41C
	.byte 0xC0, 0x46	; 0232D420
pool_0232D420:
loc_0232D420:
	.word REG_DISPCNT_A	; 0232D420
pool_0232D424:
loc_0232D424:
	.word P1_Data_0233099C	; 0232D424
pool_0232D428:
loc_0232D428:
	.word 0x00030000	; 0232D428
pool_0232D42C:
loc_0232D42C:
	.word P1_BssStart + 0x266AC	; 0232D42C
pool_0232D430:
loc_0232D430:
	.word 0xFFFCFFFF	; 0232D430

; ===== function loc_0232D434 =====
loc_0232D434:
	ldr r2,[pool_0232D454]	; 0232D434
	ldrh r3,[r2,#0x0]	; 0232D436
	mov r1,#0x8	; 0232D438
	and r3,r1	; 0232D43A
	cmp r0,#0x0	; 0232D43C
	beq loc_0232D448	; 0232D43E
	ldrh r0,[r2,#0x0]	; 0232D440
	orr r0,r1	; 0232D442
	strh r0,[r2,#0x0]	; 0232D444
	b loc_0232D44E	; 0232D446
loc_0232D448:
	ldrh r0,[r2,#0x0]	; 0232D448
	bic r0,r1	; 0232D44A
	strh r0,[r2,#0x0]	; 0232D44C
loc_0232D44E:
	add r0,r3,#0x0	; 0232D44E
	bx lr	; 0232D450
	.byte 0xC0, 0x46	; 0232D454
pool_0232D454:
loc_0232D454:
	.word REG_DISPSTAT	; 0232D454

; ===== function loc_0232D458 =====
loc_0232D458:
	push {lr}	; 0232D458
	sub sp,#0xc	; 0232D45A
	ldr r0,[pool_0232D4D0]	; 0232D45C
	ldrh r2,[r0,#0x0]	; 0232D45E
	ldr r1,[pool_0232D4D4]	; 0232D460
	orr r2,r1	; 0232D462
	strh r2,[r0,#0x0]	; 0232D464
	ldrh r2,[r0,#0x0]	; 0232D466
	ldr r1,[pool_0232D4D8]	; 0232D468
	and r2,r1	; 0232D46A
	ldr r1,[pool_0232D4DC]	; 0232D46C
	orr r2,r1	; 0232D46E
	strh r2,[r0,#0x0]	; 0232D470
	ldrh r2,[r0,#0x0]	; 0232D472
	mov r1,#0x1	; 0232D474
	orr r2,r1	; 0232D476
	strh r2,[r0,#0x0]	; 0232D478
	bl loc_0232D518	; 0232D47A
	mov r1,#0x0	; 0232D47E
	ldr r0,[pool_0232D4E0]	; 0232D480
	strh r1,[r0,#0x0]	; 0232D482
	ldr r0,[pool_0232D4E4]	; 0232D484
	str r1,[r0,#0x0]	; 0232D486
	str r1,[sp,#0x0]	; 0232D488
	ldr r0,[sp,#0x0]	; 0232D48A
	ldr r1,[pool_0232D4E8]	; 0232D48C
	mov r2,#0x60	; 0232D48E
	blx loc_0232DD90	; 0232D490
	mov r1,#0x0	; 0232D494
	ldr r0,[pool_0232D4EC]	; 0232D496
	strh r1,[r0,#0x0]	; 0232D498
	str r1,[sp,#0x4]	; 0232D49A
	ldr r0,[sp,#0x4]	; 0232D49C
	ldr r1,[pool_0232D4F0]	; 0232D49E
	mov r2,#0x70	; 0232D4A0
	blx loc_0232DD90	; 0232D4A2
	ldr r0,[pool_0232D4F4]	; 0232D4A6
	ldr r1,[pool_0232D4F8]	; 0232D4A8
	strh r0,[r1,#0x0]	; 0232D4AA
	ldr r1,[pool_0232D4FC]	; 0232D4AC
	strh r0,[r1,#0x0]	; 0232D4AE
	ldr r1,[pool_0232D500]	; 0232D4B0
	strh r0,[r1,#0x0]	; 0232D4B2
	ldr r1,[pool_0232D504]	; 0232D4B4
	strh r0,[r1,#0x0]	; 0232D4B6
	ldr r1,[pool_0232D508]	; 0232D4B8
	strh r0,[r1,#0x0]	; 0232D4BA
	ldr r1,[pool_0232D50C]	; 0232D4BC
	strh r0,[r1,#0x0]	; 0232D4BE
	ldr r1,[pool_0232D510]	; 0232D4C0
	strh r0,[r1,#0x0]	; 0232D4C2
	ldr r1,[pool_0232D514]	; 0232D4C4
	strh r0,[r1,#0x0]	; 0232D4C6
	add sp,#0xc	; 0232D4C8
	pop {r3}	; 0232D4CA
	bx r3	; 0232D4CC
	.byte 0xC0, 0x46	; 0232D4D0
pool_0232D4D0:
loc_0232D4D0:
	.word REG_POWERCNT	; 0232D4D0
pool_0232D4D4:
loc_0232D4D4:
	.word 0x00008000	; 0232D4D4
pool_0232D4D8:
loc_0232D4D8:
	.word 0xFFFFFDF1	; 0232D4D8
pool_0232D4DC:
loc_0232D4DC:
	.word 0x0000020E	; 0232D4DC
pool_0232D4E0:
loc_0232D4E0:
	.word REG_DISPSTAT	; 0232D4E0
pool_0232D4E4:
loc_0232D4E4:
	.word REG_DISPCNT_A	; 0232D4E4
pool_0232D4E8:
loc_0232D4E8:
	.word REG_BG0CNT	; 0232D4E8
pool_0232D4EC:
loc_0232D4EC:
	.word REG_MASTER_BRIGHT	; 0232D4EC
pool_0232D4F0:
loc_0232D4F0:
	.word REG_DISPCNT_B	; 0232D4F0
pool_0232D4F4:
loc_0232D4F4:
	.word 0x00000100	; 0232D4F4
pool_0232D4F8:
loc_0232D4F8:
	.word REG_BG2PA	; 0232D4F8
pool_0232D4FC:
loc_0232D4FC:
	.word REG_BG2PD	; 0232D4FC
pool_0232D500:
loc_0232D500:
	.word REG_BG3PA	; 0232D500
pool_0232D504:
loc_0232D504:
	.word REG_BG3PD	; 0232D504
pool_0232D508:
loc_0232D508:
	.word REG_BG2PA_SUB	; 0232D508
pool_0232D50C:
loc_0232D50C:
	.word REG_BG2PD_SUB	; 0232D50C
pool_0232D510:
loc_0232D510:
	.word REG_BG3PA_SUB	; 0232D510
pool_0232D514:
loc_0232D514:
	.word REG_BG3PD_SUB	; 0232D514

; ===== function loc_0232D518 =====
loc_0232D518:
	mov r1,#0x0	; 0232D518
	ldr r0,[pool_0232D54C]	; 0232D51A
	strh r1,[r0,#0x0]	; 0232D51C
	strh r1,[r0,#0x2]	; 0232D51E
	strh r1,[r0,#0x4]	; 0232D520
	strh r1,[r0,#0x6]	; 0232D522
	strh r1,[r0,#0x8]	; 0232D524
	strh r1,[r0,#0xa]	; 0232D526
	strh r1,[r0,#0xc]	; 0232D528
	strh r1,[r0,#0xe]	; 0232D52A
	strh r1,[r0,#0x10]	; 0232D52C
	strh r1,[r0,#0x12]	; 0232D52E
	strh r1,[r0,#0x14]	; 0232D530
	strh r1,[r0,#0x16]	; 0232D532
	strh r1,[r0,#0x18]	; 0232D534
	ldr r0,[pool_0232D550]	; 0232D536
	str r1,[r0,#0x0]	; 0232D538
	ldr r0,[pool_0232D554]	; 0232D53A
	strb r1,[r0,#0x0]	; 0232D53C
	ldr r0,[pool_0232D558]	; 0232D53E
	strb r1,[r0,#0x0]	; 0232D540
	ldr r0,[pool_0232D55C]	; 0232D542
	strb r1,[r0,#0x0]	; 0232D544
	ldr r0,[pool_0232D560]	; 0232D546
	strh r1,[r0,#0x0]	; 0232D548
	bx lr	; 0232D54A
pool_0232D54C:
loc_0232D54C:
	.word P1_BssStart + 0x266B0	; 0232D54C
pool_0232D550:
loc_0232D550:
	.word VRAM_A_CR	; 0232D550
pool_0232D554:
loc_0232D554:
	.word VRAM_E_CR	; 0232D554
pool_0232D558:
loc_0232D558:
	.word VRAM_F_CR	; 0232D558
pool_0232D55C:
loc_0232D55C:
	.word VRAM_G_CR	; 0232D55C
pool_0232D560:
loc_0232D560:
	.word VRAM_H_CR	; 0232D560

; ===== function loc_0232D564 =====
loc_0232D564:
	ldr r0,[pool_0232D56C]	; 0232D564
	ldr r3,[pool_0232D570]	; 0232D566
	bx r3	; 0232D568
	.byte 0xC0, 0x46	; 0232D56C
pool_0232D56C:
loc_0232D56C:
	.word 0x02357084	; 0232D56C
pool_0232D570:
loc_0232D570:
	.word loc_0232D5C4 + 1	; 0232D570

; ===== function loc_0232D574 =====
loc_0232D574:
	ldr r0,[pool_0232D57C]	; 0232D574
	ldr r3,[pool_0232D580]	; 0232D576
	bx r3	; 0232D578
	.byte 0xC0, 0x46	; 0232D57C
pool_0232D57C:
loc_0232D57C:
	.word 0x02357082	; 0232D57C
pool_0232D580:
loc_0232D580:
	.word loc_0232D5C4 + 1	; 0232D580

; ===== function loc_0232D584 =====
loc_0232D584:
	ldr r0,[pool_0232D58C]	; 0232D584
	ldr r3,[pool_0232D590]	; 0232D586
	bx r3	; 0232D588
	.byte 0xC0, 0x46	; 0232D58C
pool_0232D58C:
loc_0232D58C:
	.word 0x02357070	; 0232D58C
pool_0232D590:
loc_0232D590:
	.word loc_0232D5C4 + 1	; 0232D590

; ===== function loc_0232D594 =====
loc_0232D594:
	ldr r0,[pool_0232D59C]	; 0232D594
	ldr r3,[pool_0232D5A0]	; 0232D596
	bx r3	; 0232D598
	.byte 0xC0, 0x46	; 0232D59C
pool_0232D59C:
loc_0232D59C:
	.word 0x02357076	; 0232D59C
pool_0232D5A0:
loc_0232D5A0:
	.word loc_0232D5C4 + 1	; 0232D5A0

; ===== function loc_0232D5A4 =====
loc_0232D5A4:
	ldr r0,[pool_0232D5AC]	; 0232D5A4
	ldr r3,[pool_0232D5B0]	; 0232D5A6
	bx r3	; 0232D5A8
	.byte 0xC0, 0x46	; 0232D5AC
pool_0232D5AC:
loc_0232D5AC:
	.word 0x02357074	; 0232D5AC
pool_0232D5B0:
loc_0232D5B0:
	.word loc_0232D5C4 + 1	; 0232D5B0

; ===== function loc_0232D5B4 =====
loc_0232D5B4:
	ldr r0,[pool_0232D5BC]	; 0232D5B4
	ldr r3,[pool_0232D5C0]	; 0232D5B6
	bx r3	; 0232D5B8
	.byte 0xC0, 0x46	; 0232D5BC
pool_0232D5BC:
loc_0232D5BC:
	.word 0x02357072	; 0232D5BC
pool_0232D5C0:
loc_0232D5C0:
	.word loc_0232D5C4 + 1	; 0232D5C0
loc_0232D5C4:
	ldrh r1,[r0,#0x0]	; 0232D5C4
	mov r3,#0x0	; 0232D5C6
	strh r3,[r0,#0x0]	; 0232D5C8
	mov r0,#0x1	; 0232D5CA
	add r2,r1,#0x0	; 0232D5CC
	and r2,r0	; 0232D5CE
	cmp r2,#0x0	; 0232D5D0
	beq loc_0232D5D8	; 0232D5D2
	ldr r0,[pool_0232D65C]	; 0232D5D4
	strb r3,[r0,#0x0]	; 0232D5D6
loc_0232D5D8:
	mov r0,#0x2	; 0232D5D8
	add r2,r1,#0x0	; 0232D5DA
	and r2,r0	; 0232D5DC
	cmp r2,#0x0	; 0232D5DE
	beq loc_0232D5E8	; 0232D5E0
	mov r2,#0x0	; 0232D5E2
	ldr r0,[pool_0232D660]	; 0232D5E4
	strb r2,[r0,#0x0]	; 0232D5E6
loc_0232D5E8:
	mov r0,#0x4	; 0232D5E8
	add r2,r1,#0x0	; 0232D5EA
	and r2,r0	; 0232D5EC
	cmp r2,#0x0	; 0232D5EE
	beq loc_0232D5F8	; 0232D5F0
	mov r2,#0x0	; 0232D5F2
	ldr r0,[pool_0232D664]	; 0232D5F4
	strb r2,[r0,#0x0]	; 0232D5F6
loc_0232D5F8:
	mov r0,#0x8	; 0232D5F8
	add r2,r1,#0x0	; 0232D5FA
	and r2,r0	; 0232D5FC
	cmp r2,#0x0	; 0232D5FE
	beq loc_0232D608	; 0232D600
	mov r2,#0x0	; 0232D602
	ldr r0,[pool_0232D668]	; 0232D604
	strb r2,[r0,#0x0]	; 0232D606
loc_0232D608:
	mov r0,#0x10	; 0232D608
	add r2,r1,#0x0	; 0232D60A
	and r2,r0	; 0232D60C
	cmp r2,#0x0	; 0232D60E
	beq loc_0232D618	; 0232D610
	mov r2,#0x0	; 0232D612
	ldr r0,[pool_0232D66C]	; 0232D614
	strb r2,[r0,#0x0]	; 0232D616
loc_0232D618:
	mov r0,#0x20	; 0232D618
	add r2,r1,#0x0	; 0232D61A
	and r2,r0	; 0232D61C
	cmp r2,#0x0	; 0232D61E
	beq loc_0232D628	; 0232D620
	mov r2,#0x0	; 0232D622
	ldr r0,[pool_0232D670]	; 0232D624
	strb r2,[r0,#0x0]	; 0232D626
loc_0232D628:
	mov r0,#0x40	; 0232D628
	add r2,r1,#0x0	; 0232D62A
	and r2,r0	; 0232D62C
	cmp r2,#0x0	; 0232D62E
	beq loc_0232D638	; 0232D630
	mov r2,#0x0	; 0232D632
	ldr r0,[pool_0232D674]	; 0232D634
	strb r2,[r0,#0x0]	; 0232D636
loc_0232D638:
	mov r0,#0x80	; 0232D638
	add r2,r1,#0x0	; 0232D63A
	and r2,r0	; 0232D63C
	cmp r2,#0x0	; 0232D63E
	beq loc_0232D648	; 0232D640
	mov r2,#0x0	; 0232D642
	ldr r0,[pool_0232D678]	; 0232D644
	strb r2,[r0,#0x0]	; 0232D646
loc_0232D648:
	ldr r0,[pool_0232D67C]	; 0232D648
	add r2,r1,#0x0	; 0232D64A
	and r2,r0	; 0232D64C
	cmp r2,#0x0	; 0232D64E
	beq loc_0232D658	; 0232D650
	mov r2,#0x0	; 0232D652
	ldr r0,[pool_0232D680]	; 0232D654
	strb r2,[r0,#0x0]	; 0232D656
loc_0232D658:
	add r0,r1,#0x0	; 0232D658
	bx lr	; 0232D65A
pool_0232D65C:
loc_0232D65C:
	.word VRAM_A_CR	; 0232D65C
pool_0232D660:
loc_0232D660:
	.word VRAM_B_CR	; 0232D660
pool_0232D664:
loc_0232D664:
	.word VRAM_C_CR	; 0232D664
pool_0232D668:
loc_0232D668:
	.word VRAM_D_CR	; 0232D668
pool_0232D66C:
loc_0232D66C:
	.word VRAM_E_CR	; 0232D66C
pool_0232D670:
loc_0232D670:
	.word VRAM_F_CR	; 0232D670
pool_0232D674:
loc_0232D674:
	.word VRAM_G_CR	; 0232D674
pool_0232D678:
loc_0232D678:
	.word VRAM_H_CR	; 0232D678
pool_0232D67C:
loc_0232D67C:
	.word 0x00000100	; 0232D67C
pool_0232D680:
loc_0232D680:
	.word VRAM_I_CR	; 0232D680

; ===== function loc_0232D684 =====
loc_0232D684:
	ldr r1,[pool_0232D690]	; 0232D684
	ldrh r2,[r1,#0x0]	; 0232D686
	orr r2,r0	; 0232D688
	strh r2,[r1,#0x0]	; 0232D68A
	ldr r3,[pool_0232D694]	; 0232D68C
	bx r3	; 0232D68E
pool_0232D690:
loc_0232D690:
	.word P1_BssStart + 0x266B0	; 0232D690
pool_0232D694:
loc_0232D694:
	.word loc_0232D698 + 1	; 0232D694

; ===== function loc_0232D698 =====
loc_0232D698:
	mov r1,#0x1	; 0232D698
	add r2,r0,#0x0	; 0232D69A
	and r2,r1	; 0232D69C
	cmp r2,#0x0	; 0232D69E
	beq loc_0232D6A8	; 0232D6A0
	mov r2,#0x80	; 0232D6A2
	ldr r1,[pool_0232D728]	; 0232D6A4
	strb r2,[r1,#0x0]	; 0232D6A6
loc_0232D6A8:
	mov r1,#0x2	; 0232D6A8
	add r2,r0,#0x0	; 0232D6AA
	and r2,r1	; 0232D6AC
	cmp r2,#0x0	; 0232D6AE
	beq loc_0232D6B8	; 0232D6B0
	mov r2,#0x80	; 0232D6B2
	ldr r1,[pool_0232D72C]	; 0232D6B4
	strb r2,[r1,#0x0]	; 0232D6B6
loc_0232D6B8:
	mov r1,#0x4	; 0232D6B8
	add r2,r0,#0x0	; 0232D6BA
	and r2,r1	; 0232D6BC
	cmp r2,#0x0	; 0232D6BE
	beq loc_0232D6C8	; 0232D6C0
	mov r2,#0x80	; 0232D6C2
	ldr r1,[pool_0232D730]	; 0232D6C4
	strb r2,[r1,#0x0]	; 0232D6C6
loc_0232D6C8:
	mov r1,#0x8	; 0232D6C8
	add r2,r0,#0x0	; 0232D6CA
	and r2,r1	; 0232D6CC
	cmp r2,#0x0	; 0232D6CE
	beq loc_0232D6D8	; 0232D6D0
	mov r2,#0x80	; 0232D6D2
	ldr r1,[pool_0232D734]	; 0232D6D4
	strb r2,[r1,#0x0]	; 0232D6D6
loc_0232D6D8:
	mov r1,#0x10	; 0232D6D8
	add r2,r0,#0x0	; 0232D6DA
	and r2,r1	; 0232D6DC
	cmp r2,#0x0	; 0232D6DE
	beq loc_0232D6E8	; 0232D6E0
	mov r2,#0x80	; 0232D6E2
	ldr r1,[pool_0232D738]	; 0232D6E4
	strb r2,[r1,#0x0]	; 0232D6E6
loc_0232D6E8:
	mov r1,#0x20	; 0232D6E8
	add r2,r0,#0x0	; 0232D6EA
	and r2,r1	; 0232D6EC
	cmp r2,#0x0	; 0232D6EE
	beq loc_0232D6F8	; 0232D6F0
	mov r2,#0x80	; 0232D6F2
	ldr r1,[pool_0232D73C]	; 0232D6F4
	strb r2,[r1,#0x0]	; 0232D6F6
loc_0232D6F8:
	mov r1,#0x40	; 0232D6F8
	add r2,r0,#0x0	; 0232D6FA
	and r2,r1	; 0232D6FC
	cmp r2,#0x0	; 0232D6FE
	beq loc_0232D708	; 0232D700
	mov r2,#0x80	; 0232D702
	ldr r1,[pool_0232D740]	; 0232D704
	strb r2,[r1,#0x0]	; 0232D706
loc_0232D708:
	mov r2,#0x80	; 0232D708
	add r1,r0,#0x0	; 0232D70A
	and r1,r2	; 0232D70C
	cmp r1,#0x0	; 0232D70E
	beq loc_0232D716	; 0232D710
	ldr r1,[pool_0232D744]	; 0232D712
	strb r2,[r1,#0x0]	; 0232D714
loc_0232D716:
	ldr r1,[pool_0232D748]	; 0232D716
	and r0,r1	; 0232D718
	cmp r0,#0x0	; 0232D71A
	beq loc_0232D724	; 0232D71C
	mov r1,#0x80	; 0232D71E
	ldr r0,[pool_0232D74C]	; 0232D720
	strb r1,[r0,#0x0]	; 0232D722
loc_0232D724:
	bx lr	; 0232D724
	.byte 0xC0, 0x46	; 0232D728
pool_0232D728:
loc_0232D728:
	.word VRAM_A_CR	; 0232D728
pool_0232D72C:
loc_0232D72C:
	.word VRAM_B_CR	; 0232D72C
pool_0232D730:
loc_0232D730:
	.word VRAM_C_CR	; 0232D730
pool_0232D734:
loc_0232D734:
	.word VRAM_D_CR	; 0232D734
pool_0232D738:
loc_0232D738:
	.word VRAM_E_CR	; 0232D738
pool_0232D73C:
loc_0232D73C:
	.word VRAM_F_CR	; 0232D73C
pool_0232D740:
loc_0232D740:
	.word VRAM_G_CR	; 0232D740
pool_0232D744:
loc_0232D744:
	.word VRAM_H_CR	; 0232D744
pool_0232D748:
loc_0232D748:
	.word 0x00000100	; 0232D748
pool_0232D74C:
loc_0232D74C:
	.word VRAM_I_CR	; 0232D74C

; ===== function loc_0232D750 =====
; Returns the sub-engine BG1 character-base address.
; 返回副引擎 BG1 字符基址。
.func P1_GetSubBg1CharacterBase
loc_0232D750:
	ldr r0,[pool_0232D764]	; 0232D750
	ldrh r1,[r0,#0x0]	; 0232D752
	mov r0,#0x3c	; 0232D754
	and r1,r0	; 0232D756
	asr r0,r1,#0x2	; 0232D758
	lsl r1,r0,#0xe	; 0232D75A
	ldr r0,[pool_0232D768]	; 0232D75C
	add r0,r1,r0	; 0232D75E
	bx lr	; 0232D760
.endfunc
	.byte 0xC0, 0x46	; 0232D764
pool_0232D764:
loc_0232D764:
	.word REG_BG1CNT_SUB	; 0232D764
pool_0232D768:
loc_0232D768:
	.word 0x06200000	; 0232D768

; ===== function loc_0232D76C =====
; Returns the main-engine BG1 character-base address.
; 返回主引擎 BG1 字符基址。
.func P1_GetMainBg1CharacterBase
loc_0232D76C:
	ldr r0,[pool_0232D78C]	; 0232D76C
	ldrh r1,[r0,#0x0]	; 0232D76E
	mov r0,#0x3c	; 0232D770
	and r1,r0	; 0232D772
	asr r0,r1,#0x2	; 0232D774
	lsl r2,r0,#0xe	; 0232D776
	ldr r0,[pool_0232D790]	; 0232D778
	ldr r1,[r0,#0x0]	; 0232D77A
	ldr r0,[pool_0232D794]	; 0232D77C
	and r1,r0	; 0232D77E
	lsr r0,r1,#0x18	; 0232D780
	lsl r1,r0,#0x10	; 0232D782
	ldr r0,[pool_0232D798]	; 0232D784
	add r0,r1,r0	; 0232D786
	add r0,r2,r0	; 0232D788
	bx lr	; 0232D78A
.endfunc
pool_0232D78C:
loc_0232D78C:
	.word REG_BG1CNT	; 0232D78C
pool_0232D790:
loc_0232D790:
	.word REG_DISPCNT_A	; 0232D790
pool_0232D794:
loc_0232D794:
	.word 0x07000000	; 0232D794
pool_0232D798:
loc_0232D798:
	.word 0x06000000	; 0232D798

; ===== function loc_0232D79C =====
; Returns the sub-engine BG0 character-base address.
; 返回副引擎 BG0 字符基址。
.func P1_GetSubBg0CharacterBase
loc_0232D79C:
	ldr r0,[pool_0232D7B0]	; 0232D79C
	ldrh r1,[r0,#0x0]	; 0232D79E
	mov r0,#0x3c	; 0232D7A0
	and r1,r0	; 0232D7A2
	asr r0,r1,#0x2	; 0232D7A4
	lsl r1,r0,#0xe	; 0232D7A6
	ldr r0,[pool_0232D7B4]	; 0232D7A8
	add r0,r1,r0	; 0232D7AA
	bx lr	; 0232D7AC
.endfunc
	.byte 0xC0, 0x46	; 0232D7B0
pool_0232D7B0:
loc_0232D7B0:
	.word REG_BG0CNT_SUB	; 0232D7B0
pool_0232D7B4:
loc_0232D7B4:
	.word 0x06200000	; 0232D7B4
; ===== function loc_0232D7C8 =====
; Returns the main-engine BG0 character-base address.
; 返回主引擎 BG0 字符基址。
.func P1_GetMainBg0CharacterBase
loc_0232D7C8:
	ldr r0,[pool_0232D7E8]	; 0232D7C8
	ldrh r1,[r0,#0x0]	; 0232D7CA
	mov r0,#0x3c	; 0232D7CC
	and r1,r0	; 0232D7CE
	asr r0,r1,#0x2	; 0232D7D0
	lsl r2,r0,#0xe	; 0232D7D2
	ldr r0,[pool_0232D7EC]	; 0232D7D4
	ldr r1,[r0,#0x0]	; 0232D7D6
	ldr r0,[pool_0232D7F0]	; 0232D7D8
	and r1,r0	; 0232D7DA
	lsr r0,r1,#0x18	; 0232D7DC
	lsl r1,r0,#0x10	; 0232D7DE
	ldr r0,[pool_0232D7F4]	; 0232D7E0
	add r0,r1,r0	; 0232D7E2
	add r0,r2,r0	; 0232D7E4
	bx lr	; 0232D7E6
.endfunc
pool_0232D7E8:
	.word REG_BG0CNT	; 0232D7E8
pool_0232D7EC:
	.word REG_DISPCNT_A	; 0232D7EC
pool_0232D7F0:
	.word 0x07000000	; 0232D7F0
pool_0232D7F4:
	.word 0x06000000	; 0232D7F4

; ===== function loc_0232D7E8 =====
; Returns the sub-engine BG1 tilemap base from BG1CNT.
; 由 BG1CNT 返回副引擎 BG1 tilemap 基址。
.func P1_GetSubBg1TilemapBase
loc_0232D7E8:
	ldr r0,[pool_0232D7FC]	; 0232D7E8
	ldrh r1,[r0,#0x0]	; 0232D7EA
	ldr r0,[pool_0232D800]	; 0232D7EC
	and r1,r0	; 0232D7EE
	asr r0,r1,#0x8	; 0232D7F0
	lsl r1,r0,#0xb	; 0232D7F2
	ldr r0,[pool_0232D804]	; 0232D7F4
	add r0,r1,r0	; 0232D7F6
	bx lr	; 0232D7F8
.endfunc
	.byte 0xC0, 0x46	; 0232D7FC
pool_0232D7FC:
loc_0232D7FC:
	.word REG_BG1CNT_SUB	; 0232D7FC
pool_0232D800:
loc_0232D800:
	.word 0x00001F00	; 0232D800
pool_0232D804:
loc_0232D804:
	.word 0x06200000	; 0232D804

; ===== function loc_0232D808 =====
; Returns the main-engine BG1 tilemap base from BG1CNT and VRAM bank mode.
; 由 BG1CNT 与 VRAM bank 模式返回主引擎 BG1 tilemap 基址。
.func P1_GetMainBg1TilemapBase
loc_0232D808:
	ldr r0,[pool_0232D828]	; 0232D808
	ldrh r1,[r0,#0x0]	; 0232D80A
	ldr r0,[pool_0232D82C]	; 0232D80C
	and r1,r0	; 0232D80E
	asr r0,r1,#0x8	; 0232D810
	lsl r2,r0,#0xb	; 0232D812
	ldr r0,[pool_0232D830]	; 0232D814
	ldr r1,[r0,#0x0]	; 0232D816
	ldr r0,[pool_0232D834]	; 0232D818
	and r1,r0	; 0232D81A
	lsr r0,r1,#0x1b	; 0232D81C
	lsl r1,r0,#0x10	; 0232D81E
	ldr r0,[pool_0232D838]	; 0232D820
	add r0,r1,r0	; 0232D822
	add r0,r2,r0	; 0232D824
	bx lr	; 0232D826
.endfunc
pool_0232D828:
loc_0232D828:
	.word REG_BG1CNT	; 0232D828
pool_0232D82C:
loc_0232D82C:
	.word 0x00001F00	; 0232D82C
pool_0232D830:
loc_0232D830:
	.word REG_DISPCNT_A	; 0232D830
pool_0232D834:
loc_0232D834:
	.word 0x38000000	; 0232D834
pool_0232D838:
loc_0232D838:
	.word 0x06000000	; 0232D838

; ===== function loc_0232D83C =====
; Returns the sub-engine BG0 tilemap base from BG0CNT.
; 由 BG0CNT 返回副引擎 BG0 tilemap 基址。
.func P1_GetSubBg0TilemapBase
loc_0232D83C:
	ldr r0,[pool_0232D850]	; 0232D83C
	ldrh r1,[r0,#0x0]	; 0232D83E
	ldr r0,[pool_0232D854]	; 0232D840
	and r1,r0	; 0232D842
	asr r0,r1,#0x8	; 0232D844
	lsl r1,r0,#0xb	; 0232D846
	ldr r0,[pool_0232D858]	; 0232D848
	add r0,r1,r0	; 0232D84A
	bx lr	; 0232D84C
.endfunc
	.byte 0xC0, 0x46	; 0232D850
pool_0232D850:
loc_0232D850:
	.word REG_BG0CNT_SUB	; 0232D850
pool_0232D854:
loc_0232D854:
	.word 0x00001F00	; 0232D854
pool_0232D858:
loc_0232D858:
	.word 0x06200000	; 0232D858

; ===== function loc_0232D85C =====
; Returns the main-engine BG0 tilemap base from BG0CNT and VRAM bank mode.
; 由 BG0CNT 与 VRAM bank 模式返回主引擎 BG0 tilemap 基址。
.func P1_GetMainBg0TilemapBase
loc_0232D85C:
	ldr r0,[pool_0232D87C]	; 0232D85C
	ldrh r1,[r0,#0x0]	; 0232D85E
	ldr r0,[pool_0232D880]	; 0232D860
	and r1,r0	; 0232D862
	asr r0,r1,#0x8	; 0232D864
	lsl r2,r0,#0xb	; 0232D866
	ldr r0,[pool_0232D884]	; 0232D868
	ldr r1,[r0,#0x0]	; 0232D86A
	ldr r0,[pool_0232D888]	; 0232D86C
	and r1,r0	; 0232D86E
	lsr r0,r1,#0x1b	; 0232D870
	lsl r1,r0,#0x10	; 0232D872
	ldr r0,[pool_0232D88C]	; 0232D874
	add r0,r1,r0	; 0232D876
	add r0,r2,r0	; 0232D878
	bx lr	; 0232D87A
.endfunc
pool_0232D87C:
loc_0232D87C:
	.word REG_BG0CNT	; 0232D87C
pool_0232D880:
loc_0232D880:
	.word 0x00001F00	; 0232D880
pool_0232D884:
loc_0232D884:
	.word REG_DISPCNT_A	; 0232D884
pool_0232D888:
loc_0232D888:
	.word 0x38000000	; 0232D888
pool_0232D88C:
loc_0232D88C:
	.word 0x06000000	; 0232D88C

; ===== function loc_0232D890 =====
loc_0232D890:
	cmp r2,#0x0	; 0232D890
	bge loc_0232D8A0	; 0232D892
	mov r3,#0xc0	; 0232D894
	orr r1,r3	; 0232D896
	strh r1,[r0,#0x0]	; 0232D898
	neg r1,r2	; 0232D89A
	strh r1,[r0,#0x4]	; 0232D89C
	bx lr	; 0232D89E
loc_0232D8A0:
	mov r3,#0x80	; 0232D8A0
	orr r1,r3	; 0232D8A2
	strh r1,[r0,#0x0]	; 0232D8A4
	strh r2,[r0,#0x4]	; 0232D8A6
	bx lr	; 0232D8A8
	.byte 0x00, 0x00	; 0232D8AC

; ===== function loc_0232D8AC =====
loc_0232D8AC:
	push {r4}	; 0232D8AC
	sub sp,#0x4	; 0232D8AE
	mov r4,#0x40	; 0232D8B0
	orr r1,r4	; 0232D8B2
	lsl r2,r2,#0x8	; 0232D8B4
	orr r1,r2	; 0232D8B6
	ldr r2,[sp,#0x8]	; 0232D8B8
	lsl r2,r2,#0x8	; 0232D8BA
	orr r3,r2	; 0232D8BC
	lsl r2,r3,#0x10	; 0232D8BE
	orr r1,r2	; 0232D8C0
	str r1,[r0,#0x0]	; 0232D8C2
	add sp,#0x4	; 0232D8C4
	pop {r4}	; 0232D8C6
	bx lr	; 0232D8C8
	.byte 0x00, 0x00	; 0232D8CC

; ===== function loc_0232D8CC =====
P1_Entry_0232D8CC:
	push {r4,r5,r6,lr}	; 0232D8CC
	add r5,r0,#0x0	; 0232D8CE
	add r4,r1,#0x0	; 0232D8D0
	add r6,r2,#0x0	; 0232D8D2
	bl loc_02326BBC	; 0232D8D4
	add r2,r0,#0x0	; 0232D8D8
	ldr r0,[pool_0232D8F0]	; 0232D8DA
	ldr r0,[r0,#0x0]	; 0232D8DC
	add r1,r5,#0x0	; 0232D8DE
	add r2,r2,r4	; 0232D8E0
	add r3,r6,#0x0	; 0232D8E2
	bl loc_0232DD18	; 0232D8E4
	pop {r4,r5,r6}	; 0232D8E8
	pop {r3}	; 0232D8EA
	bx r3	; 0232D8EC
	.byte 0xC0, 0x46	; 0232D8F0
pool_0232D8F0:
loc_0232D8F0:
	.word P1_Data_023309A0	; 0232D8F0

; ===== function loc_0232D8F4 =====
P1_Entry_0232D8F4:
	push {r4,r5,r6,lr}	; 0232D8F4
	add r5,r0,#0x0	; 0232D8F6
	add r4,r1,#0x0	; 0232D8F8
	add r6,r2,#0x0	; 0232D8FA
	bl loc_02326BD8	; 0232D8FC
	add r2,r0,#0x0	; 0232D900
	ldr r0,[pool_0232D918]	; 0232D902
	ldr r0,[r0,#0x0]	; 0232D904
	add r1,r5,#0x0	; 0232D906
	add r2,r2,r4	; 0232D908
	add r3,r6,#0x0	; 0232D90A
	bl loc_0232DD18	; 0232D90C
	pop {r4,r5,r6}	; 0232D910
	pop {r3}	; 0232D912
	bx r3	; 0232D914
	.byte 0xC0, 0x46	; 0232D918
pool_0232D918:
loc_0232D918:
	.word P1_Data_023309A0	; 0232D918
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xF9, 0xF7, 0x70, 0xF9, 0x02, 0x1C, 0x05, 0x48	; 0232D92C
	.byte 0x00, 0x68, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C, 0x00, 0xF0, 0xF0, 0xF9, 0x70, 0xBC, 0x08, 0xBC	; 0232D93C
	.byte 0x18, 0x47, 0xC0, 0x46, 0xA0, 0x09, 0x33, 0x02	; 0232D944

; ===== function loc_0232D944 =====
loc_0232D944:
	push {r4,r5,r6,lr}	; 0232D944
	add r5,r0,#0x0	; 0232D946
	add r4,r1,#0x0	; 0232D948
	add r6,r2,#0x0	; 0232D94A
	bl loc_02326C24	; 0232D94C
	add r2,r0,#0x0	; 0232D950
	ldr r0,[pool_0232D968]	; 0232D952
	ldr r0,[r0,#0x0]	; 0232D954
	add r1,r5,#0x0	; 0232D956
	add r2,r2,r4	; 0232D958
	add r3,r6,#0x0	; 0232D95A
	bl loc_0232DD18	; 0232D95C
	pop {r4,r5,r6}	; 0232D960
	pop {r3}	; 0232D962
	bx r3	; 0232D964
	.byte 0xC0, 0x46	; 0232D968
pool_0232D968:
loc_0232D968:
	.word P1_Data_023309A0	; 0232D968

; ===== function loc_0232D96C =====
loc_0232D96C:
	push {r4,r5,r6,lr}	; 0232D96C
	add r5,r0,#0x0	; 0232D96E
	add r4,r1,#0x0	; 0232D970
	add r6,r2,#0x0	; 0232D972
	bl P1_GetSubBg1CharacterBase	; 0232D974
	add r2,r0,#0x0	; 0232D978
	ldr r0,[pool_0232D990]	; 0232D97A
	ldr r0,[r0,#0x0]	; 0232D97C
	add r1,r5,#0x0	; 0232D97E
	add r2,r2,r4	; 0232D980
	add r3,r6,#0x0	; 0232D982
	bl loc_0232DD18	; 0232D984
	pop {r4,r5,r6}	; 0232D988
	pop {r3}	; 0232D98A
	bx r3	; 0232D98C
	.byte 0xC0, 0x46	; 0232D990
pool_0232D990:
loc_0232D990:
	.word P1_Data_023309A0	; 0232D990

; ===== function loc_0232D994 =====
loc_0232D994:
	push {r4,r5,r6,lr}	; 0232D994
	add r5,r0,#0x0	; 0232D996
	add r4,r1,#0x0	; 0232D998
	add r6,r2,#0x0	; 0232D99A
	bl P1_GetMainBg1CharacterBase	; 0232D99C
	add r2,r0,#0x0	; 0232D9A0
	ldr r0,[pool_0232D9B8]	; 0232D9A2
	ldr r0,[r0,#0x0]	; 0232D9A4
	add r1,r5,#0x0	; 0232D9A6
	add r2,r2,r4	; 0232D9A8
	add r3,r6,#0x0	; 0232D9AA
	bl loc_0232DD18	; 0232D9AC
	pop {r4,r5,r6}	; 0232D9B0
	pop {r3}	; 0232D9B2
	bx r3	; 0232D9B4
	.byte 0xC0, 0x46	; 0232D9B8
pool_0232D9B8:
loc_0232D9B8:
	.word P1_Data_023309A0	; 0232D9B8

; ===== function loc_0232D9BC =====
	push {r4,r5,r6,lr}	; 0232D9BC
	add r5,r0,#0x0	; 0232D9BE
	add r4,r1,#0x0	; 0232D9C0
	add r6,r2,#0x0	; 0232D9C2
	bl P1_GetSubBg0CharacterBase	; 0232D9C4
	add r2,r0,#0x0	; 0232D9C8
	ldr r0,[pool_0232D9E0]	; 0232D9CA
	ldr r0,[r0,#0x0]	; 0232D9CC
	add r1,r5,#0x0	; 0232D9CE
	add r2,r2,r4	; 0232D9D0
	add r3,r6,#0x0	; 0232D9D2
	bl loc_0232DD18	; 0232D9D4
	pop {r4,r5,r6}	; 0232D9D8
	pop {r3}	; 0232D9DA
	bx r3	; 0232D9DC
	.byte 0xC0, 0x46	; 0232D9E0
pool_0232D9E0:
loc_0232D9E0:
	.word P1_Data_023309A0	; 0232D9E0
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xFF, 0xF7, 0xE4, 0xFE, 0x02, 0x1C, 0x05, 0x48	; 0232D9F4
	.byte 0x00, 0x68, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C, 0x00, 0xF0, 0x8C, 0xF9, 0x70, 0xBC, 0x08, 0xBC	; 0232DA04
	.byte 0x18, 0x47, 0xC0, 0x46, 0xA0, 0x09, 0x33, 0x02	; 0232DA0C

; ===== function loc_0232DA0C =====
loc_0232DA0C:
	push {r4,r5,r6,lr}	; 0232DA0C
	add r5,r0,#0x0	; 0232DA0E
	add r4,r1,#0x0	; 0232DA10
	add r6,r2,#0x0	; 0232DA12
	bl loc_02326C54	; 0232DA14
	add r2,r0,#0x0	; 0232DA18
	ldr r0,[pool_0232DA30]	; 0232DA1A
	ldr r0,[r0,#0x0]	; 0232DA1C
	add r1,r5,#0x0	; 0232DA1E
	add r2,r2,r4	; 0232DA20
	add r3,r6,#0x0	; 0232DA22
	bl loc_0232DCD8	; 0232DA24
	pop {r4,r5,r6}	; 0232DA28
	pop {r3}	; 0232DA2A
	bx r3	; 0232DA2C
	.byte 0xC0, 0x46	; 0232DA30
pool_0232DA30:
loc_0232DA30:
	.word P1_Data_023309A0	; 0232DA30

; ===== function loc_0232DA34 =====
loc_0232DA34:
	push {r4,r5,r6,lr}	; 0232DA34
	add r5,r0,#0x0	; 0232DA36
	add r4,r1,#0x0	; 0232DA38
	add r6,r2,#0x0	; 0232DA3A
	blx P1_GetMainBg3TilemapAddress	; 0232DA3C
	add r2,r0,#0x0	; 0232DA40
	ldr r0,[pool_0232DA58]	; 0232DA42
	ldr r0,[r0,#0x0]	; 0232DA44
	add r1,r5,#0x0	; 0232DA46
	add r2,r2,r4	; 0232DA48
	add r3,r6,#0x0	; 0232DA4A
	bl loc_0232DCD8	; 0232DA4C
	pop {r4,r5,r6}	; 0232DA50
	pop {r3}	; 0232DA52
	bx r3	; 0232DA54
	.byte 0xC0, 0x46	; 0232DA58
pool_0232DA58:
loc_0232DA58:
	.word P1_Data_023309A0	; 0232DA58

; ===== function loc_0232DA5C =====
loc_0232DA5C:
	push {r4,r5,r6,lr}	; 0232DA5C
	add r5,r0,#0x0	; 0232DA5E
	add r4,r1,#0x0	; 0232DA60
	add r6,r2,#0x0	; 0232DA62
	bl loc_02326CA8	; 0232DA64
	add r2,r0,#0x0	; 0232DA68
	ldr r0,[pool_0232DA80]	; 0232DA6A
	ldr r0,[r0,#0x0]	; 0232DA6C
	add r1,r5,#0x0	; 0232DA6E
	add r2,r2,r4	; 0232DA70
	add r3,r6,#0x0	; 0232DA72
	bl loc_0232DCD8	; 0232DA74
	pop {r4,r5,r6}	; 0232DA78
	pop {r3}	; 0232DA7A
	bx r3	; 0232DA7C
	.byte 0xC0, 0x46	; 0232DA80
pool_0232DA80:
loc_0232DA80:
	.word P1_Data_023309A0	; 0232DA80

; ===== function loc_0232DA84 =====
loc_0232DA84:
	push {r4,r5,r6,lr}	; 0232DA84
	add r5,r0,#0x0	; 0232DA86
	add r4,r1,#0x0	; 0232DA88
	add r6,r2,#0x0	; 0232DA8A
	blx P1_GetMainBg2TilemapAddress	; 0232DA8C
	add r2,r0,#0x0	; 0232DA90
	ldr r0,[pool_0232DAA8]	; 0232DA92
	ldr r0,[r0,#0x0]	; 0232DA94
	add r1,r5,#0x0	; 0232DA96
	add r2,r2,r4	; 0232DA98
	add r3,r6,#0x0	; 0232DA9A
	bl loc_0232DCD8	; 0232DA9C
	pop {r4,r5,r6}	; 0232DAA0
	pop {r3}	; 0232DAA2
	bx r3	; 0232DAA4
	.byte 0xC0, 0x46	; 0232DAA8
pool_0232DAA8:
loc_0232DAA8:
	.word P1_Data_023309A0	; 0232DAA8

; ===== function loc_0232DAAC =====
loc_0232DAAC:
	push {r4,r5,r6,lr}	; 0232DAAC
	add r5,r0,#0x0	; 0232DAAE
	add r4,r1,#0x0	; 0232DAB0
	add r6,r2,#0x0	; 0232DAB2
	bl P1_GetSubBg1TilemapBase	; 0232DAB4
	add r2,r0,#0x0	; 0232DAB8
	ldr r0,[pool_0232DAD0]	; 0232DABA
	ldr r0,[r0,#0x0]	; 0232DABC
	add r1,r5,#0x0	; 0232DABE
	add r2,r2,r4	; 0232DAC0
	add r3,r6,#0x0	; 0232DAC2
	bl loc_0232DCD8	; 0232DAC4
	pop {r4,r5,r6}	; 0232DAC8
	pop {r3}	; 0232DACA
	bx r3	; 0232DACC
	.byte 0xC0, 0x46	; 0232DAD0
pool_0232DAD0:
loc_0232DAD0:
	.word P1_Data_023309A0	; 0232DAD0

; ===== function loc_0232DAD4 =====
loc_0232DAD4:
	push {r4,r5,r6,lr}	; 0232DAD4
	add r5,r0,#0x0	; 0232DAD6
	add r4,r1,#0x0	; 0232DAD8
	add r6,r2,#0x0	; 0232DADA
	bl P1_GetMainBg1TilemapBase	; 0232DADC
	add r2,r0,#0x0	; 0232DAE0
	ldr r0,[pool_0232DAF8]	; 0232DAE2
	ldr r0,[r0,#0x0]	; 0232DAE4
	add r1,r5,#0x0	; 0232DAE6
	add r2,r2,r4	; 0232DAE8
	add r3,r6,#0x0	; 0232DAEA
	bl loc_0232DCD8	; 0232DAEC
	pop {r4,r5,r6}	; 0232DAF0
	pop {r3}	; 0232DAF2
	bx r3	; 0232DAF4
	.byte 0xC0, 0x46	; 0232DAF8
pool_0232DAF8:
loc_0232DAF8:
	.word P1_Data_023309A0	; 0232DAF8

; ===== function loc_0232DAFC =====
loc_0232DAFC:
	push {r4,r5,r6,lr}	; 0232DAFC
	add r5,r0,#0x0	; 0232DAFE
	add r4,r1,#0x0	; 0232DB00
	add r6,r2,#0x0	; 0232DB02
	bl P1_GetSubBg0TilemapBase	; 0232DB04
	add r2,r0,#0x0	; 0232DB08
	ldr r0,[pool_0232DB20]	; 0232DB0A
	ldr r0,[r0,#0x0]	; 0232DB0C
	add r1,r5,#0x0	; 0232DB0E
	add r2,r2,r4	; 0232DB10
	add r3,r6,#0x0	; 0232DB12
	bl loc_0232DCD8	; 0232DB14
	pop {r4,r5,r6}	; 0232DB18
	pop {r3}	; 0232DB1A
	bx r3	; 0232DB1C
	.byte 0xC0, 0x46	; 0232DB20
pool_0232DB20:
loc_0232DB20:
	.word P1_Data_023309A0	; 0232DB20

; ===== function loc_0232DB24 =====
	push {r4,r5,r6,lr}	; 0232DB24
	add r5,r0,#0x0	; 0232DB26
	add r4,r1,#0x0	; 0232DB28
	add r6,r2,#0x0	; 0232DB2A
	bl P1_GetMainBg0TilemapBase	; 0232DB2C
	add r2,r0,#0x0	; 0232DB30
	ldr r0,[pool_0232DB48]	; 0232DB32
	ldr r0,[r0,#0x0]	; 0232DB34
	add r1,r5,#0x0	; 0232DB36
	add r2,r2,r4	; 0232DB38
	add r3,r6,#0x0	; 0232DB3A
	bl loc_0232DCD8	; 0232DB3C
	pop {r4,r5,r6}	; 0232DB40
	pop {r3}	; 0232DB42
	bx r3	; 0232DB44
	.byte 0xC0, 0x46	; 0232DB48
pool_0232DB48:
loc_0232DB48:
	.word P1_Data_023309A0	; 0232DB48

; ===== function loc_0232DB4C =====
loc_0232DB4C:
	push {r4,r5,lr}	; 0232DB4C
	sub sp,#0x4	; 0232DB4E
	add r5,r0,#0x0	; 0232DB50
	add r4,r1,#0x0	; 0232DB52
	add r3,r2,#0x0	; 0232DB54
	ldr r0,[pool_0232DB6C]	; 0232DB56
	ldr r0,[r0,#0x0]	; 0232DB58
	add r1,r5,#0x0	; 0232DB5A
	ldr r2,[pool_0232DB70]	; 0232DB5C
	add r2,r4,r2	; 0232DB5E
	bl loc_0232DD18	; 0232DB60
	add sp,#0x4	; 0232DB64
	pop {r4,r5}	; 0232DB66
	pop {r3}	; 0232DB68
	bx r3	; 0232DB6A
pool_0232DB6C:
loc_0232DB6C:
	.word P1_Data_023309A0	; 0232DB6C
pool_0232DB70:
loc_0232DB70:
	.word 0x06600000	; 0232DB70

; ===== function loc_0232DB74 =====
loc_0232DB74:
	push {r4,r5,lr}	; 0232DB74
	sub sp,#0x4	; 0232DB76
	add r5,r0,#0x0	; 0232DB78
	add r4,r1,#0x0	; 0232DB7A
	add r3,r2,#0x0	; 0232DB7C
	ldr r0,[pool_0232DB94]	; 0232DB7E
	ldr r0,[r0,#0x0]	; 0232DB80
	add r1,r5,#0x0	; 0232DB82
	ldr r2,[pool_0232DB98]	; 0232DB84
	add r2,r4,r2	; 0232DB86
	bl loc_0232DD18	; 0232DB88
	add sp,#0x4	; 0232DB8C
	pop {r4,r5}	; 0232DB8E
	pop {r3}	; 0232DB90
	bx r3	; 0232DB92
pool_0232DB94:
loc_0232DB94:
	.word P1_Data_023309A0	; 0232DB94
pool_0232DB98:
loc_0232DB98:
	.word 0x06400000	; 0232DB98

; ===== function loc_0232DB9C =====
loc_0232DB9C:
	push {r4,r5,lr}	; 0232DB9C
	sub sp,#0x4	; 0232DB9E
	add r5,r0,#0x0	; 0232DBA0
	add r4,r1,#0x0	; 0232DBA2
	add r3,r2,#0x0	; 0232DBA4
	ldr r0,[pool_0232DBBC]	; 0232DBA6
	ldr r0,[r0,#0x0]	; 0232DBA8
	add r1,r5,#0x0	; 0232DBAA
	ldr r2,[pool_0232DBC0]	; 0232DBAC
	add r2,r4,r2	; 0232DBAE
	bl loc_0232DD18	; 0232DBB0
	add sp,#0x4	; 0232DBB4
	pop {r4,r5}	; 0232DBB6
	pop {r3}	; 0232DBB8
	bx r3	; 0232DBBA
pool_0232DBBC:
loc_0232DBBC:
	.word P1_Data_023309A0	; 0232DBBC
pool_0232DBC0:
loc_0232DBC0:
	.word 0x07000400	; 0232DBC0

; ===== function loc_0232DBC4 =====
loc_0232DBC4:
	push {r4,r5,lr}	; 0232DBC4
	sub sp,#0x4	; 0232DBC6
	add r5,r0,#0x0	; 0232DBC8
	add r4,r1,#0x0	; 0232DBCA
	add r3,r2,#0x0	; 0232DBCC
	ldr r0,[pool_0232DBE4]	; 0232DBCE
	ldr r0,[r0,#0x0]	; 0232DBD0
	add r1,r5,#0x0	; 0232DBD2
	ldr r2,[pool_0232DBE8]	; 0232DBD4
	add r2,r4,r2	; 0232DBD6
	bl loc_0232DD18	; 0232DBD8
	add sp,#0x4	; 0232DBDC
	pop {r4,r5}	; 0232DBDE
	pop {r3}	; 0232DBE0
	bx r3	; 0232DBE2
pool_0232DBE4:
loc_0232DBE4:
	.word P1_Data_023309A0	; 0232DBE4
pool_0232DBE8:
loc_0232DBE8:
	.word 0x07000000	; 0232DBE8

; ===== function loc_0232DBEC =====
loc_0232DBEC:
	push {r4,r5,lr}	; 0232DBEC
	sub sp,#0x4	; 0232DBEE
	add r5,r0,#0x0	; 0232DBF0
	add r4,r1,#0x0	; 0232DBF2
	add r3,r2,#0x0	; 0232DBF4
	ldr r0,[pool_0232DC0C]	; 0232DBF6
	ldr r0,[r0,#0x0]	; 0232DBF8
	add r1,r5,#0x0	; 0232DBFA
	ldr r2,[pool_0232DC10]	; 0232DBFC
	add r2,r4,r2	; 0232DBFE
	bl loc_0232DCD8	; 0232DC00
	add sp,#0x4	; 0232DC04
	pop {r4,r5}	; 0232DC06
	pop {r3}	; 0232DC08
	bx r3	; 0232DC0A
pool_0232DC0C:
loc_0232DC0C:
	.word P1_Data_023309A0	; 0232DC0C
pool_0232DC10:
loc_0232DC10:
	.word 0x05000600	; 0232DC10

; ===== function loc_0232DC14 =====
loc_0232DC14:
	push {r4,r5,lr}	; 0232DC14
	sub sp,#0x4	; 0232DC16
	add r5,r0,#0x0	; 0232DC18
	add r4,r1,#0x0	; 0232DC1A
	add r3,r2,#0x0	; 0232DC1C
	ldr r0,[pool_0232DC34]	; 0232DC1E
	ldr r0,[r0,#0x0]	; 0232DC20
	add r1,r5,#0x0	; 0232DC22
	ldr r2,[pool_0232DC38]	; 0232DC24
	add r2,r4,r2	; 0232DC26
	bl loc_0232DCD8	; 0232DC28
	add sp,#0x4	; 0232DC2C
	pop {r4,r5}	; 0232DC2E
	pop {r3}	; 0232DC30
	bx r3	; 0232DC32
pool_0232DC34:
loc_0232DC34:
	.word P1_Data_023309A0	; 0232DC34
pool_0232DC38:
loc_0232DC38:
	.word 0x05000200	; 0232DC38

; ===== function loc_0232DC3C =====
loc_0232DC3C:
	push {r4,r5,lr}	; 0232DC3C
	sub sp,#0x4	; 0232DC3E
	add r5,r0,#0x0	; 0232DC40
	add r4,r1,#0x0	; 0232DC42
	add r3,r2,#0x0	; 0232DC44
	ldr r0,[pool_0232DC5C]	; 0232DC46
	ldr r0,[r0,#0x0]	; 0232DC48
	add r1,r5,#0x0	; 0232DC4A
	ldr r2,[pool_0232DC60]	; 0232DC4C
	add r2,r4,r2	; 0232DC4E
	bl loc_0232DCD8	; 0232DC50
	add sp,#0x4	; 0232DC54
	pop {r4,r5}	; 0232DC56
	pop {r3}	; 0232DC58
	bx r3	; 0232DC5A
pool_0232DC5C:
loc_0232DC5C:
	.word P1_Data_023309A0	; 0232DC5C
pool_0232DC60:
loc_0232DC60:
	.word 0x05000400	; 0232DC60

; ===== function loc_0232DC64 =====
loc_0232DC64:
	push {r4,r5,lr}	; 0232DC64
	sub sp,#0x4	; 0232DC66
	add r5,r0,#0x0	; 0232DC68
	add r4,r1,#0x0	; 0232DC6A
	add r3,r2,#0x0	; 0232DC6C
	ldr r0,[pool_0232DC84]	; 0232DC6E
	ldr r0,[r0,#0x0]	; 0232DC70
	add r1,r5,#0x0	; 0232DC72
	ldr r2,[pool_0232DC88]	; 0232DC74
	add r2,r4,r2	; 0232DC76
	bl loc_0232DCD8	; 0232DC78
	add sp,#0x4	; 0232DC7C
	pop {r4,r5}	; 0232DC7E
	pop {r3}	; 0232DC80
	bx r3	; 0232DC82
pool_0232DC84:
loc_0232DC84:
	.word P1_Data_023309A0	; 0232DC84
pool_0232DC88:
loc_0232DC88:
	.word 0x05000000	; 0232DC88

; ===== function loc_0232DC8C =====
loc_0232DC8C:
	ldr r1,[pool_0232DC94]	; 0232DC8C
	strb r0,[r1,#0x0]	; 0232DC8E
	bx lr	; 0232DC90
	.byte 0xC0, 0x46	; 0232DC94
pool_0232DC94:
loc_0232DC94:
	.word REG_WRAMCNT	; 0232DC94

; ===== function loc_0232DC98 =====
loc_0232DC98:
	push {r4,lr}	; 0232DC98
	add r4,r0,#0x0	; 0232DC9A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232DC9C
	mov r1,#0x6	; 0232DCA0
	mul r4,r1	; 0232DCA2
	add r1,r4,#0x5	; 0232DCA4
	lsl r2,r1,#0x1	; 0232DCA6
	ldr r1,[pool_0232DCCC]	; 0232DCA8
	add r2,r2,r1	; 0232DCAA
	ldrh r3,[r2,#0x0]	; 0232DCAC
	ldr r1,[pool_0232DCD0]	; 0232DCAE
	and r3,r1	; 0232DCB0
	strh r3,[r2,#0x0]	; 0232DCB2
	ldrh r3,[r2,#0x0]	; 0232DCB4
	ldr r1,[pool_0232DCD4]	; 0232DCB6
	and r3,r1	; 0232DCB8
	strh r3,[r2,#0x0]	; 0232DCBA
	ldrh r1,[r2,#0x0]	; 0232DCBC
	ldrh r1,[r2,#0x0]	; 0232DCBE
	blx P1_Arm9RestoreIrqMask	; 0232DCC0
	pop {r4}	; 0232DCC4
	pop {r3}	; 0232DCC6
	bx r3	; 0232DCC8
	.byte 0xC0, 0x46	; 0232DCCC
pool_0232DCCC:
loc_0232DCCC:
	.word REG_DMA0SAD	; 0232DCCC
pool_0232DCD0:
loc_0232DCD0:
	.word 0xFFFFC5FF	; 0232DCD0
pool_0232DCD4:
loc_0232DCD4:
	.word 0xFFFF7FFF	; 0232DCD4

; ===== function loc_0232DCD8 =====
loc_0232DCD8:
	push {r4,r5,r6,lr}	; 0232DCD8
	cmp r3,#0x0	; 0232DCDA
	beq loc_0232DD0A	; 0232DCDC
	mov r4,#0x3	; 0232DCDE
	add r5,r0,#0x0	; 0232DCE0
	mul r5,r4	; 0232DCE2
	add r4,r5,#0x2	; 0232DCE4
	lsl r5,r4,#0x2	; 0232DCE6
	ldr r4,[pool_0232DD10]	; 0232DCE8
	add r4,r5,r4	; 0232DCEA
	ldr r5,[pool_0232DD14]	; 0232DCEC
loc_0232DCEE:
	ldr r6,[r4,#0x0]	; 0232DCEE
	and r6,r5	; 0232DCF0
	cmp r6,#0x0	; 0232DCF2
	bne loc_0232DCEE	; 0232DCF4
	lsr r3,r3,#0x1	; 0232DCF6
	ldr r5,[pool_0232DD14]	; 0232DCF8
	orr r3,r5	; 0232DCFA
	bl P1_SetDmaChannelRegisters	; 0232DCFC
	lsl r0,r5,#0	; 0232DD00
loc_0232DD02:
	ldr r1,[r4,#0x0]	; 0232DD02
	and r1,r0	; 0232DD04
	cmp r1,#0x0	; 0232DD06
	bne loc_0232DD02	; 0232DD08
loc_0232DD0A:
	pop {r4,r5,r6}	; 0232DD0A
	pop {r3}	; 0232DD0C
	bx r3	; 0232DD0E
pool_0232DD10:
loc_0232DD10:
	.word REG_DMA0SAD	; 0232DD10
pool_0232DD14:
loc_0232DD14:
	.word 0x80000000	; 0232DD14

; ===== function loc_0232DD18 =====
loc_0232DD18:
	push {r4,r5,r6,lr}	; 0232DD18
	cmp r3,#0x0	; 0232DD1A
	beq loc_0232DD4A	; 0232DD1C
	mov r4,#0x3	; 0232DD1E
	add r5,r0,#0x0	; 0232DD20
	mul r5,r4	; 0232DD22
	add r4,r5,#0x2	; 0232DD24
	lsl r5,r4,#0x2	; 0232DD26
	ldr r4,[pool_0232DD50]	; 0232DD28
	add r4,r5,r4	; 0232DD2A
	ldr r5,[pool_0232DD54]	; 0232DD2C
loc_0232DD2E:
	ldr r6,[r4,#0x0]	; 0232DD2E
	and r6,r5	; 0232DD30
	cmp r6,#0x0	; 0232DD32
	bne loc_0232DD2E	; 0232DD34
	lsr r3,r3,#0x2	; 0232DD36
	ldr r5,[pool_0232DD58]	; 0232DD38
	orr r3,r5	; 0232DD3A
	bl P1_SetDmaChannelRegisters	; 0232DD3C
	ldr r0,[pool_0232DD54]	; 0232DD40
loc_0232DD42:
	ldr r1,[r4,#0x0]	; 0232DD42
	and r1,r0	; 0232DD44
	cmp r1,#0x0	; 0232DD46
	bne loc_0232DD42	; 0232DD48
loc_0232DD4A:
	pop {r4,r5,r6}	; 0232DD4A
	pop {r3}	; 0232DD4C
	bx r3	; 0232DD4E
pool_0232DD50:
loc_0232DD50:
	.word REG_DMA0SAD	; 0232DD50
pool_0232DD54:
loc_0232DD54:
	.word 0x80000000	; 0232DD54
pool_0232DD58:
loc_0232DD58:
	.word 0x84000000	; 0232DD58
.arm

; ===== function loc_0232DD5C =====
loc_0232DD5C:
	mov r3,#0x0	; 0232DD5C
loc_0232DD60:
	cmp r3,r2	; 0232DD60
	strlth r0,[r1,r3]	; 0232DD64
	addlt r3,r3,#0x2	; 0232DD68
	blt loc_0232DD60	; 0232DD6C
	bx lr	; 0232DD70

; ===== function loc_0232DD74 =====
loc_0232DD74:
	mov r12,#0x0	; 0232DD74
loc_0232DD78:
	cmp r12,r2	; 0232DD78
	ldrlth r3,[r0,r12]	; 0232DD7C
	strlth r3,[r1,r12]	; 0232DD80
	addlt r12,r12,#0x2	; 0232DD84
	blt loc_0232DD78	; 0232DD88
	bx lr	; 0232DD8C

; ===== function loc_0232DD90 =====
; r0=填充值，r1=目标，r2=字节数；按 32 位字写入。
; r0=value, r1=destination, r2=byte count; fills in 32-bit words.
.func P1_MemFill32
loc_0232DD90:
	add r12,r1,r2	; 0232DD90
loc_0232DD94:
	cmp r1,r12	; 0232DD94
	stmltia r1!,{r0}	; 0232DD98
	blt loc_0232DD94	; 0232DD9C
	bx lr	; 0232DDA0
.endfunc

; ===== function loc_0232DDA4 =====
; r0=源，r1=目标，r2=字节数；按 32 位字复制。
; r0=source, r1=destination, r2=byte count; copies 32-bit words.
.func P1_MemCopy32
loc_0232DDA4:
	add r12,r1,r2	; 0232DDA4
loc_0232DDA8:
	cmp r1,r12	; 0232DDA8
	ldmltia r0!,{r2}	; 0232DDAC
	stmltia r1!,{r2}	; 0232DDB0
	blt loc_0232DDA8	; 0232DDB4
	bx lr	; 0232DDB8
.endfunc

; ===== function loc_0232DDBC =====
loc_0232DDBC:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 0232DDBC
	add r9,r1,r2	; 0232DDC0
	mov r12,r2, lsr #0x5	; 0232DDC4
	add r12,r1,r12, lsl #0x5	; 0232DDC8
	mov r2,r0	; 0232DDCC
	mov r3,r2	; 0232DDD0
	mov r4,r2	; 0232DDD4
	mov r5,r2	; 0232DDD8
	mov r6,r2	; 0232DDDC
	mov r7,r2	; 0232DDE0
	mov r8,r2	; 0232DDE4
loc_0232DDE8:
	cmp r1,r12	; 0232DDE8
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 0232DDEC
	blt loc_0232DDE8	; 0232DDF0
loc_0232DDF4:
	cmp r1,r9	; 0232DDF4
	stmltia r1!,{r0}	; 0232DDF8
	blt loc_0232DDF4	; 0232DDFC
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 0232DE00
	bx lr	; 0232DE04

; ===== function loc_0232DE08 =====
loc_0232DE08:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232DE08
	add r10,r1,r2	; 0232DE0C
	mov r12,r2, lsr #0x5	; 0232DE10
	add r12,r1,r12, lsl #0x5	; 0232DE14
loc_0232DE18:
	cmp r1,r12	; 0232DE18
	ldmltia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232DE1C
	stmltia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232DE20
	blt loc_0232DE18	; 0232DE24
loc_0232DE28:
	cmp r1,r10	; 0232DE28
	ldmltia r0!,{r2}	; 0232DE2C
	stmltia r1!,{r2}	; 0232DE30
	blt loc_0232DE28	; 0232DE34
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232DE38
	bx lr	; 0232DE3C

; ===== function loc_0232DE40 =====
loc_0232DE40:
	mov r12,#0x0	; 0232DE40
loc_0232DE44:
	cmp r12,r2	; 0232DE44
	strltb r1,[r0,r12]	; 0232DE48
	addlt r12,r12,#0x1	; 0232DE4C
	blt loc_0232DE44	; 0232DE50
	bx lr	; 0232DE54
P1_Entry_0232DE58:
	mov r12,#0x0	; 0232DE58
P1_Entry_0232DE5C:
	cmp r12,r2	; 0232DE5C
	ldrltb r3,[r0,r12]	; 0232DE60
	strltb r3,[r1,r12]	; 0232DE64
	addlt r12,r12,#0x1	; 0232DE68
	blt P1_Entry_0232DE5C	; 0232DE6C
	bx lr	; 0232DE70

; ===== function loc_0232DE74 =====
loc_0232DE74:
	swp r0,r0,[r1]	; 0232DE74
	bx lr	; 0232DE78
.thumb

; ===== function loc_0232DE7C =====
loc_0232DE7C:
	push {lr}	; 0232DE7C
	sub sp,#0x4	; 0232DE7E
	ldr r0,[pool_0232DE9C]	; 0232DE80
	ldr r1,[r0,#0x0]	; 0232DE82
	cmp r1,#0x0	; 0232DE84
	bne loc_0232DE94	; 0232DE86
	mov r1,#0x1	; 0232DE88
	str r1,[r0,#0x0]	; 0232DE8A
	bl loc_0232E4B0	; 0232DE8C
	bl loc_0232E5D4	; 0232DE90
loc_0232DE94:
	add sp,#0x4	; 0232DE94
	pop {r3}	; 0232DE96
	bx r3	; 0232DE98
	.byte 0xC0, 0x46	; 0232DE9C
pool_0232DE9C:
loc_0232DE9C:
	.word P1_BssStart + 0x266CC	; 0232DE9C

; ===== function loc_0232DEA0 =====
loc_0232DEA0:
	push {r4,r5,r6,r7,lr}	; 0232DEA0
	sub sp,#0x4	; 0232DEA2
	add r5,r0,#0x0	; 0232DEA4
	add r4,r1,#0x0	; 0232DEA6
	add r6,r2,#0x0	; 0232DEA8
	add r7,r3,#0x0	; 0232DEAA
	mov r0,#0x1	; 0232DEAC
	bl loc_0232E3B4	; 0232DEAE
	cmp r0,#0x0	; 0232DEB2
	beq loc_0232DEC6	; 0232DEB4
	str r5,[r0,#0x4]	; 0232DEB6
	str r4,[r0,#0x8]	; 0232DEB8
	str r6,[r0,#0xc]	; 0232DEBA
	str r7,[r0,#0x10]	; 0232DEBC
	ldr r1,[sp,#0x18]	; 0232DEBE
	str r1,[r0,#0x14]	; 0232DEC0
	bl loc_0232E390	; 0232DEC2
loc_0232DEC6:
	add sp,#0x4	; 0232DEC6
	pop {r4,r5,r6,r7}	; 0232DEC8
	pop {r3}	; 0232DECA
	bx r3	; 0232DECC
	.byte 0x00, 0x00	; 0232DED0

; ===== function loc_0232DED0 =====
loc_0232DED0:
	push {lr}	; 0232DED0
	sub sp,#0x4	; 0232DED2
	add r1,r0,#0x0	; 0232DED4
	mov r2,#0x0	; 0232DED6
	str r2,[sp,#0x0]	; 0232DED8
	mov r0,#0x13	; 0232DEDA
	add r3,r2,#0x0	; 0232DEDC
	bl loc_0232DEA0	; 0232DEDE
	add sp,#0x4	; 0232DEE2
	pop {r3}	; 0232DEE4
	bx r3	; 0232DEE6

; ===== function loc_0232DEE8 =====
loc_0232DEE8:
	push {r4,r5,r6,lr}	; 0232DEE8
	sub sp,#0x8	; 0232DEEA
	add r6,r0,#0x0	; 0232DEEC
	add r5,r1,#0x0	; 0232DEEE
	add r4,r2,#0x0	; 0232DEF0
	str r3,[sp,#0x0]	; 0232DEF2
	mov r0,#0x4	; 0232DEF4
	ldr r1,[sp,#0x18]	; 0232DEF6
	lsl r1,r1,#0x18	; 0232DEF8
	orr r1,r6	; 0232DEFA
	add r2,r5,#0x0	; 0232DEFC
	add r3,r4,#0x0	; 0232DEFE
	bl loc_0232DEA0	; 0232DF00
	add sp,#0x8	; 0232DF04
	pop {r4,r5,r6}	; 0232DF06
	pop {r3}	; 0232DF08
	bx r3	; 0232DF0A

; ===== function loc_0232DF0C =====
loc_0232DF0C:
	push {r4,r5,r6,lr}	; 0232DF0C
	sub sp,#0x8	; 0232DF0E
	add r6,r0,#0x0	; 0232DF10
	add r5,r1,#0x0	; 0232DF12
	add r4,r2,#0x0	; 0232DF14
	str r3,[sp,#0x0]	; 0232DF16
	mov r0,#0x3	; 0232DF18
	add r1,r6,#0x0	; 0232DF1A
	add r2,r5,#0x0	; 0232DF1C
	add r3,r4,#0x0	; 0232DF1E
	bl loc_0232DEA0	; 0232DF20
	add sp,#0x8	; 0232DF24
	pop {r4,r5,r6}	; 0232DF26
	pop {r3}	; 0232DF28
	bx r3	; 0232DF2A

; ===== function loc_0232DF2C =====
loc_0232DF2C:
	push {r4,r5,r6,lr}	; 0232DF2C
	sub sp,#0x8	; 0232DF2E
	add r6,r0,#0x0	; 0232DF30
	add r5,r1,#0x0	; 0232DF32
	add r4,r2,#0x0	; 0232DF34
	str r3,[sp,#0x0]	; 0232DF36
	mov r0,#0x15	; 0232DF38
	add r1,r6,#0x0	; 0232DF3A
	add r2,r5,#0x0	; 0232DF3C
	add r3,r4,#0x0	; 0232DF3E
	bl loc_0232DEA0	; 0232DF40
	add sp,#0x8	; 0232DF44
	pop {r4,r5,r6}	; 0232DF46
	pop {r3}	; 0232DF48
	bx r3	; 0232DF4A

; ===== function loc_0232DF4C =====
loc_0232DF4C:
	push {r4,r5,lr}	; 0232DF4C
	sub sp,#0x4	; 0232DF4E
	add r5,r0,#0x0	; 0232DF50
	ldr r4,[sp,#0x10]	; 0232DF52
	ldr r0,[sp,#0x24]	; 0232DF54
	lsl r0,r0,#0x10	; 0232DF56
	lsl r3,r3,#0x1a	; 0232DF58
	lsl r1,r1,#0x18	; 0232DF5A
	orr r3,r1	; 0232DF5C
	orr r0,r3	; 0232DF5E
	orr r4,r0	; 0232DF60
	str r4,[sp,#0x0]	; 0232DF62
	mov r0,#0xb	; 0232DF64
	ldr r1,[sp,#0x20]	; 0232DF66
	lsl r1,r1,#0x10	; 0232DF68
	orr r1,r5	; 0232DF6A
	ldr r3,[sp,#0x14]	; 0232DF6C
	ldr r4,[sp,#0x18]	; 0232DF6E
	lsl r5,r4,#0x18	; 0232DF70
	ldr r4,[sp,#0x1c]	; 0232DF72
	lsl r4,r4,#0x16	; 0232DF74
	orr r5,r4	; 0232DF76
	orr r3,r5	; 0232DF78
	bl loc_0232DEA0	; 0232DF7A
	add sp,#0x4	; 0232DF7E
	pop {r4,r5}	; 0232DF80
	pop {r3}	; 0232DF82
	bx r3	; 0232DF84
	.byte 0x00, 0x00	; 0232DF88

; ===== function loc_0232DF88 =====
loc_0232DF88:
	push {r4,r5,lr}	; 0232DF88
	sub sp,#0x4	; 0232DF8A
	add r5,r0,#0x0	; 0232DF8C
	add r4,r1,#0x0	; 0232DF8E
	add r3,r2,#0x0	; 0232DF90
	mov r0,#0x0	; 0232DF92
	str r0,[sp,#0x0]	; 0232DF94
	mov r0,#0x11	; 0232DF96
	add r1,r5,#0x0	; 0232DF98
	add r2,r4,#0x0	; 0232DF9A
	bl loc_0232DEA0	; 0232DF9C
	add sp,#0x4	; 0232DFA0
	pop {r4,r5}	; 0232DFA2
	pop {r3}	; 0232DFA4
	bx r3	; 0232DFA6

; ===== function loc_0232DFA8 =====
loc_0232DFA8:
	push {r4,lr}	; 0232DFA8
	sub sp,#0x8	; 0232DFAA
	add r4,r0,#0x0	; 0232DFAC
	add r2,r1,#0x0	; 0232DFAE
	mov r3,#0x0	; 0232DFB0
	str r3,[sp,#0x0]	; 0232DFB2
	mov r0,#0x17	; 0232DFB4
	add r1,r4,#0x0	; 0232DFB6
	bl loc_0232DEA0	; 0232DFB8
	add sp,#0x8	; 0232DFBC
	pop {r4}	; 0232DFBE
	pop {r3}	; 0232DFC0
	bx r3	; 0232DFC2

; ===== function loc_0232DFC4 =====
loc_0232DFC4:
	push {r4,lr}	; 0232DFC4
	sub sp,#0x8	; 0232DFC6
	add r4,r0,#0x0	; 0232DFC8
	add r2,r1,#0x0	; 0232DFCA
	mov r3,#0x0	; 0232DFCC
	str r3,[sp,#0x0]	; 0232DFCE
	mov r0,#0x16	; 0232DFD0
	add r1,r4,#0x0	; 0232DFD2
	bl loc_0232DEA0	; 0232DFD4
	add sp,#0x8	; 0232DFD8
	pop {r4}	; 0232DFDA
	pop {r3}	; 0232DFDC
	bx r3	; 0232DFDE

; ===== function loc_0232DFE0 =====
loc_0232DFE0:
	push {r4,r5,r6,lr}	; 0232DFE0
	sub sp,#0x8	; 0232DFE2
	add r5,r0,#0x0	; 0232DFE4
	add r4,r1,#0x0	; 0232DFE6
	add r6,r2,#0x0	; 0232DFE8
	add r1,r3,#0x0	; 0232DFEA
	ldr r2,[sp,#0x18]	; 0232DFEC
	bl loc_0232E594	; 0232DFEE
	str r0,[sp,#0x0]	; 0232DFF2
	mov r0,#0xf	; 0232DFF4
	add r1,r5,#0x0	; 0232DFF6
	add r2,r4,#0x0	; 0232DFF8
	add r3,r6,#0x0	; 0232DFFA
	bl loc_0232DEA0	; 0232DFFC
	add sp,#0x8	; 0232E000
	pop {r4,r5,r6}	; 0232E002
	pop {r3}	; 0232E004
	bx r3	; 0232E006

; ===== function loc_0232E008 =====
loc_0232E008:
	push {r4,r5,r6,r7,lr}	; 0232E008
	sub sp,#0xc	; 0232E00A
	add r6,r0,#0x0	; 0232E00C
	str r1,[sp,#0x4]	; 0232E00E
	mov r0,#0x0	; 0232E010
	str r0,[sp,#0x0]	; 0232E012
	mov r0,#0xe	; 0232E014
	add r1,r2,#0x0	; 0232E016
	add r2,r3,#0x0	; 0232E018
	ldr r3,[sp,#0x28]	; 0232E01A
	lsl r7,r3,#0x1b	; 0232E01C
	ldr r3,[sp,#0x24]	; 0232E01E
	lsl r5,r3,#0x1c	; 0232E020
	ldr r3,[sp,#0x20]	; 0232E022
	lsl r4,r3,#0x1d	; 0232E024
	lsl r3,r6,#0x1f	; 0232E026
	ldr r6,[sp,#0x4]	; 0232E028
	lsl r6,r6,#0x1e	; 0232E02A
	orr r3,r6	; 0232E02C
	orr r4,r3	; 0232E02E
	orr r5,r4	; 0232E030
	orr r7,r5	; 0232E032
	add r3,r7,#0x0	; 0232E034
	bl loc_0232DEA0	; 0232E036
	add sp,#0xc	; 0232E03A
	pop {r4,r5,r6,r7}	; 0232E03C
	pop {r3}	; 0232E03E
	bx r3	; 0232E040
	.byte 0x00, 0x00	; 0232E044

; ===== function loc_0232E044 =====
loc_0232E044:
	push {r4,r5,r6,r7,lr}	; 0232E044
	sub sp,#0x14	; 0232E046
	str r0,[sp,#0x4]	; 0232E048
	str r1,[sp,#0x8]	; 0232E04A
	add r7,r2,#0x0	; 0232E04C
	str r3,[sp,#0xc]	; 0232E04E
	add r4,r7,#0x0	; 0232E050
	mov r5,#0x0	; 0232E052
	mov r6,#0x1	; 0232E054
	b loc_0232E06A	; 0232E056
loc_0232E058:
	add r0,r4,#0x0	; 0232E058
	and r0,r6	; 0232E05A
	cmp r0,#0x0	; 0232E05C
	beq loc_0232E066	; 0232E05E
	add r0,r5,#0x0	; 0232E060
	bl loc_0232E5BC	; 0232E062
loc_0232E066:
	add r5,r5,#0x1	; 0232E066
	lsr r4,r4,#0x1	; 0232E068
loc_0232E06A:
	cmp r5,#0x8	; 0232E06A
	bge loc_0232E072	; 0232E06C
	cmp r4,#0x0	; 0232E06E
	bne loc_0232E058	; 0232E070
loc_0232E072:
	ldr r0,[sp,#0xc]	; 0232E072
	str r0,[sp,#0x0]	; 0232E074
	mov r0,#0xa	; 0232E076
	ldr r1,[sp,#0x4]	; 0232E078
	ldr r2,[sp,#0x8]	; 0232E07A
	add r3,r7,#0x0	; 0232E07C
	bl loc_0232DEA0	; 0232E07E
	add sp,#0x14	; 0232E082
	pop {r4,r5,r6,r7}	; 0232E084
	pop {r3}	; 0232E086
	bx r3	; 0232E088
	.byte 0x00, 0x00	; 0232E08C

; ===== function loc_0232E08C =====
loc_0232E08C:
	push {r4,r5,r6,lr}	; 0232E08C
	sub sp,#0x8	; 0232E08E
	add r6,r0,#0x0	; 0232E090
	add r5,r1,#0x0	; 0232E092
	add r4,r2,#0x0	; 0232E094
	str r3,[sp,#0x0]	; 0232E096
	mov r0,#0x9	; 0232E098
	add r1,r6,#0x0	; 0232E09A
	add r2,r5,#0x0	; 0232E09C
	add r3,r4,#0x0	; 0232E09E
	bl loc_0232DEA0	; 0232E0A0
	add sp,#0x8	; 0232E0A4
	pop {r4,r5,r6}	; 0232E0A6
	pop {r3}	; 0232E0A8
	bx r3	; 0232E0AA

; ===== function loc_0232E0AC =====
loc_0232E0AC:
	push {lr}	; 0232E0AC
	sub sp,#0x4	; 0232E0AE
	add r3,r2,#0x0	; 0232E0B0
	mov r2,#0x1	; 0232E0B2
	str r2,[sp,#0x0]	; 0232E0B4
	mov r2,#0x1a	; 0232E0B6
	bl loc_0232DEE8	; 0232E0B8
	add sp,#0x4	; 0232E0BC
	pop {r3}	; 0232E0BE
	bx r3	; 0232E0C0
	.byte 0x00, 0x00	; 0232E0C4

; ===== function loc_0232E0C4 =====
loc_0232E0C4:
	push {lr}	; 0232E0C4
	sub sp,#0x4	; 0232E0C6
	add r3,r2,#0x0	; 0232E0C8
	mov r2,#0x2	; 0232E0CA
	str r2,[sp,#0x0]	; 0232E0CC
	mov r2,#0xc	; 0232E0CE
	bl loc_0232DEE8	; 0232E0D0
	add sp,#0x4	; 0232E0D4
	pop {r3}	; 0232E0D6
	bx r3	; 0232E0D8
	.byte 0x00, 0x00	; 0232E0DC

; ===== function loc_0232E0DC =====
loc_0232E0DC:
	push {lr}	; 0232E0DC
	sub sp,#0x4	; 0232E0DE
	add r2,r1,#0x0	; 0232E0E0
	mov r1,#0x4	; 0232E0E2
	mov r3,#0x1	; 0232E0E4
	bl loc_0232DF0C	; 0232E0E6
	add sp,#0x4	; 0232E0EA
	pop {r3}	; 0232E0EC
	bx r3	; 0232E0EE

; ===== function loc_0232E0F0 =====
loc_0232E0F0:
	push {lr}	; 0232E0F0
	sub sp,#0x4	; 0232E0F2
	add r2,r1,#0x0	; 0232E0F4
	mov r1,#0x6	; 0232E0F6
	mov r3,#0x2	; 0232E0F8
	bl loc_0232DF0C	; 0232E0FA
	add sp,#0x4	; 0232E0FE
	pop {r3}	; 0232E100
	bx r3	; 0232E102

; ===== function loc_0232E104 =====
loc_0232E104:
	push {lr}	; 0232E104
	sub sp,#0x4	; 0232E106
	add r1,r0,#0x0	; 0232E108
	mov r2,#0x0	; 0232E10A
	str r2,[sp,#0x0]	; 0232E10C
	mov r0,#0x1	; 0232E10E
	add r3,r2,#0x0	; 0232E110
	bl loc_0232DEA0	; 0232E112
	add sp,#0x4	; 0232E116
	pop {r3}	; 0232E118
	bx r3	; 0232E11A

; ===== function loc_0232E11C =====
loc_0232E11C:
	push {r4,r5,r6,lr}	; 0232E11C
	sub sp,#0x8	; 0232E11E
	add r6,r0,#0x0	; 0232E120
	add r5,r1,#0x0	; 0232E122
	add r4,r2,#0x0	; 0232E124
	str r3,[sp,#0x0]	; 0232E126
	mov r0,#0x0	; 0232E128
	add r1,r6,#0x0	; 0232E12A
	add r2,r5,#0x0	; 0232E12C
	add r3,r4,#0x0	; 0232E12E
	bl loc_0232DEA0	; 0232E130
	add sp,#0x8	; 0232E134
	pop {r4,r5,r6}	; 0232E136
	pop {r3}	; 0232E138
	bx r3	; 0232E13A

; ===== function loc_0232E13C =====
loc_0232E13C:
	ldr r1,[pool_0232E158]	; 0232E13C
	ldr r0,[r1,#0x0]	; 0232E13E
	cmp r0,#0x0	; 0232E140
	bne loc_0232E148	; 0232E142
	mov r0,#0x0	; 0232E144
	bx lr	; 0232E146
loc_0232E148:
	ldr r2,[r0,#0x0]	; 0232E148
	str r2,[r1,#0x0]	; 0232E14A
	cmp r2,#0x0	; 0232E14C
	bne loc_0232E156	; 0232E14E
	mov r2,#0x0	; 0232E150
	ldr r1,[pool_0232E15C]	; 0232E152
	str r2,[r1,#0x0]	; 0232E154
loc_0232E156:
	bx lr	; 0232E156
pool_0232E158:
loc_0232E158:
	.word P1_BssStart + 0x266D0	; 0232E158
pool_0232E15C:
loc_0232E15C:
	.word P1_BssStart + 0x266E0	; 0232E15C

; ===== function loc_0232E160 =====
loc_0232E160:
	push {r4,r5,lr}	; 0232E160
	sub sp,#0x4	; 0232E162
	mov r5,#0x7	; 0232E164
	mov r4,#0x0	; 0232E166
loc_0232E168:
	add r0,r5,#0x0	; 0232E168
	add r1,r4,#0x0	; 0232E16A
	add r2,r4,#0x0	; 0232E16C
	bl loc_0232E808	; 0232E16E
	cmp r0,#0x0	; 0232E172
	blt loc_0232E168	; 0232E174
	add sp,#0x4	; 0232E176
	pop {r4,r5}	; 0232E178
	pop {r3}	; 0232E17A
	bx r3	; 0232E17C
	.byte 0x00, 0x00	; 0232E180

; ===== function loc_0232E180 =====
loc_0232E180:
	push {r4,r5,r6,lr}	; 0232E180
	mov r0,#0x7	; 0232E182
	ldr r1,[pool_0232E1BC]	; 0232E184
	bl P1_SetPxiReceiveCallback	; 0232E186
	bl loc_0232B988	; 0232E18A
	cmp r0,#0x0	; 0232E18E
	bne loc_0232E1B6	; 0232E190
	mov r0,#0x7	; 0232E192
	mov r1,#0x1	; 0232E194
	bl loc_0232E89C	; 0232E196
	cmp r0,#0x0	; 0232E19A
	bne loc_0232E1B6	; 0232E19C
	mov r5,#0x64	; 0232E19E
	mov r4,#0x7	; 0232E1A0
	mov r6,#0x1	; 0232E1A2
loc_0232E1A4:
	add r0,r5,#0x0	; 0232E1A4
	blx P1_Arm9BusyWaitByLoop4	; 0232E1A6
	add r0,r4,#0x0	; 0232E1AA
	add r1,r6,#0x0	; 0232E1AC
	bl loc_0232E89C	; 0232E1AE
	cmp r0,#0x0	; 0232E1B2
	beq loc_0232E1A4	; 0232E1B4
loc_0232E1B6:
	pop {r4,r5,r6}	; 0232E1B6
	pop {r3}	; 0232E1B8
	bx r3	; 0232E1BA
pool_0232E1BC:
loc_0232E1BC:
	.word P1_PxiCallback_0232E1C0 + 1	; 0232E1BC

; ===== function loc_0232E1C0 =====
P1_PxiCallback_0232E1C0:
	push {r4,r5,lr}	; 0232E1C0
	sub sp,#0x4	; 0232E1C2
	add r5,r1,#0x0	; 0232E1C4
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E1C6
	add r4,r0,#0x0	; 0232E1CA
	add r0,r5,#0x0	; 0232E1CC
	bl loc_0232E564	; 0232E1CE
	add r0,r4,#0x0	; 0232E1D2
	blx P1_Arm9RestoreIrqMask	; 0232E1D4
	add sp,#0x4	; 0232E1D8
	pop {r4,r5}	; 0232E1DA
	pop {r3}	; 0232E1DC
	bx r3	; 0232E1DE

; ===== function loc_0232E1E0 =====
loc_0232E1E0:
	push {r4,lr}	; 0232E1E0
	bl loc_0232E214	; 0232E1E2
	add r4,r0,#0x0	; 0232E1E6
	bl loc_0232E1FC	; 0232E1E8
	ldr r1,[pool_0232E1F8]	; 0232E1EC
	sub r1,r1,r4	; 0232E1EE
	sub r0,r1,r0	; 0232E1F0
	pop {r4}	; 0232E1F2
	pop {r3}	; 0232E1F4
	bx r3	; 0232E1F6
pool_0232E1F8:
loc_0232E1F8:
	.word 0x00000100	; 0232E1F8

; ===== function loc_0232E1FC =====
loc_0232E1FC:
	ldr r0,[pool_0232E210]	; 0232E1FC
	ldr r1,[r0,#0x0]	; 0232E1FE
	mov r0,#0x0	; 0232E200
	cmp r1,#0x0	; 0232E202
	beq loc_0232E20E	; 0232E204
loc_0232E206:
	add r0,r0,#0x1	; 0232E206
	ldr r1,[r1,#0x0]	; 0232E208
	cmp r1,#0x0	; 0232E20A
	bne loc_0232E206	; 0232E20C
loc_0232E20E:
	bx lr	; 0232E20E
pool_0232E210:
loc_0232E210:
	.word P1_BssStart + 0x266D8	; 0232E210

; ===== function loc_0232E214 =====
loc_0232E214:
	ldr r0,[pool_0232E228]	; 0232E214
	ldr r1,[r0,#0x0]	; 0232E216
	mov r0,#0x0	; 0232E218
	cmp r1,#0x0	; 0232E21A
	beq loc_0232E226	; 0232E21C
loc_0232E21E:
	add r0,r0,#0x1	; 0232E21E
	ldr r1,[r1,#0x0]	; 0232E220
	cmp r1,#0x0	; 0232E222
	bne loc_0232E21E	; 0232E224
loc_0232E226:
	bx lr	; 0232E226
pool_0232E228:
loc_0232E228:
	.word P1_BssStart + 0x266D0	; 0232E228

; ===== function loc_0232E22C =====
loc_0232E22C:
	ldr r1,[pool_0232E254]	; 0232E22C
	ldr r1,[r1,#0x0]	; 0232E22E
	cmp r0,r1	; 0232E230
	bls loc_0232E244	; 0232E232
	sub r1,r0,r1	; 0232E234
	ldr r0,[pool_0232E258]	; 0232E236
	cmp r1,r0	; 0232E238
	bcc loc_0232E240	; 0232E23A
	mov r0,#0x1	; 0232E23C
	bx lr	; 0232E23E
loc_0232E240:
	mov r0,#0x0	; 0232E240
	bx lr	; 0232E242
loc_0232E244:
	sub r1,r1,r0	; 0232E244
	ldr r0,[pool_0232E258]	; 0232E246
	cmp r1,r0	; 0232E248
	bcs loc_0232E250	; 0232E24A
	mov r0,#0x1	; 0232E24C
	bx lr	; 0232E24E
loc_0232E250:
	mov r0,#0x0	; 0232E250
	bx lr	; 0232E252
pool_0232E254:
loc_0232E254:
	.word P1_BssStart + 0x266D4	; 0232E254
pool_0232E258:
loc_0232E258:
	.word 0x80000000	; 0232E258

; ===== function loc_0232E25C =====
loc_0232E25C:
	ldr r0,[pool_0232E270]	; 0232E25C
	ldr r0,[r0,#0x0]	; 0232E25E
	cmp r0,#0x0	; 0232E260
	bne loc_0232E26A	; 0232E262
	ldr r0,[pool_0232E274]	; 0232E264
	ldr r0,[r0,#0x0]	; 0232E266
	bx lr	; 0232E268
loc_0232E26A:
	ldr r0,[pool_0232E278]	; 0232E26A
	ldr r0,[r0,#0x0]	; 0232E26C
	bx lr	; 0232E26E
pool_0232E270:
loc_0232E270:
	.word P1_BssStart + 0x266D8	; 0232E270
pool_0232E274:
loc_0232E274:
	.word P1_BssStart + 0x266D4	; 0232E274
pool_0232E278:
loc_0232E278:
	.word P1_BssStart + 0x266F0	; 0232E278

; ===== function loc_0232E27C =====
loc_0232E27C:
	push {r4,r5,lr}	; 0232E27C
	sub sp,#0x4	; 0232E27E
	add r4,r0,#0x0	; 0232E280
	bl loc_0232E22C	; 0232E282
	cmp r0,#0x0	; 0232E286
	bne loc_0232E2C0	; 0232E288
	mov r5,#0x0	; 0232E28A
loc_0232E28C:
	add r0,r5,#0x0	; 0232E28C
	bl loc_0232E420	; 0232E28E
	cmp r0,#0x0	; 0232E292
	bne loc_0232E28C	; 0232E294
	add r0,r4,#0x0	; 0232E296
	bl loc_0232E22C	; 0232E298
	cmp r0,#0x0	; 0232E29C
	bne loc_0232E2C0	; 0232E29E
	bl loc_0232E160	; 0232E2A0
	add r0,r4,#0x0	; 0232E2A4
	bl loc_0232E22C	; 0232E2A6
	cmp r0,#0x0	; 0232E2AA
	bne loc_0232E2C0	; 0232E2AC
	mov r5,#0x1	; 0232E2AE
loc_0232E2B0:
	add r0,r5,#0x0	; 0232E2B0
	bl loc_0232E420	; 0232E2B2
	add r0,r4,#0x0	; 0232E2B6
	bl loc_0232E22C	; 0232E2B8
	cmp r0,#0x0	; 0232E2BC
	beq loc_0232E2B0	; 0232E2BE
loc_0232E2C0:
	add sp,#0x4	; 0232E2C0
	pop {r4,r5}	; 0232E2C2
	pop {r3}	; 0232E2C4
	bx r3	; 0232E2C6

; ===== function loc_0232E2C8 =====
loc_0232E2C8:
	push {r4,lr}	; 0232E2C8
	add r4,r0,#0x0	; 0232E2CA
	ldr r0,[pool_0232E370]	; 0232E2CC
	ldr r0,[r0,#0x0]	; 0232E2CE
	cmp r0,#0x0	; 0232E2D0
	bne loc_0232E2DC	; 0232E2D2
	mov r0,#0x1	; 0232E2D4
	pop {r4}	; 0232E2D6
	pop {r3}	; 0232E2D8
	bx r3	; 0232E2DA
loc_0232E2DC:
	ldr r0,[pool_0232E374]	; 0232E2DC
	ldr r0,[r0,#0x0]	; 0232E2DE
	cmp r0,#0x8	; 0232E2E0
	blt loc_0232E2FE	; 0232E2E2
	cmp r4,#0x0	; 0232E2E4
	bne loc_0232E2F0	; 0232E2E6
	mov r0,#0x0	; 0232E2E8
	pop {r4}	; 0232E2EA
	pop {r3}	; 0232E2EC
	bx r3	; 0232E2EE
loc_0232E2F0:
	mov r0,#0x1	; 0232E2F0
	bl loc_0232E420	; 0232E2F2
	ldr r0,[pool_0232E374]	; 0232E2F6
	ldr r0,[r0,#0x0]	; 0232E2F8
	cmp r0,#0x8	; 0232E2FA
	bge loc_0232E2F0	; 0232E2FC
loc_0232E2FE:
	ldr r0,[pool_0232E378]	; 0232E2FE
	ldr r1,[pool_0232E37C]	; 0232E300
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E302
	mov r0,#0x7	; 0232E306
	ldr r1,[pool_0232E370]	; 0232E308
	ldr r1,[r1,#0x0]	; 0232E30A
	mov r2,#0x0	; 0232E30C
	bl loc_0232E808	; 0232E30E
	cmp r0,#0x0	; 0232E312
	bge loc_0232E332	; 0232E314
	cmp r4,#0x0	; 0232E316
	bne loc_0232E322	; 0232E318
	mov r0,#0x0	; 0232E31A
	pop {r4}	; 0232E31C
	pop {r3}	; 0232E31E
	bx r3	; 0232E320
loc_0232E322:
	mov r0,#0x7	; 0232E322
	ldr r1,[pool_0232E370]	; 0232E324
	ldr r1,[r1,#0x0]	; 0232E326
	mov r2,#0x0	; 0232E328
	bl loc_0232E808	; 0232E32A
	cmp r0,#0x0	; 0232E32E
	blt loc_0232E322	; 0232E330
loc_0232E332:
	ldr r0,[pool_0232E370]	; 0232E332
	ldr r4,[r0,#0x0]	; 0232E334
	ldr r0,[pool_0232E380]	; 0232E336
	ldr r2,[r0,#0x0]	; 0232E338
	lsl r3,r2,#0x2	; 0232E33A
	ldr r1,[pool_0232E384]	; 0232E33C
	str r4,[r1,r3]	; 0232E33E
	add r1,r2,#0x1	; 0232E340
	str r1,[r0,#0x0]	; 0232E342
	cmp r1,#0x8	; 0232E344
	ble loc_0232E34C	; 0232E346
	mov r1,#0x0	; 0232E348
	str r1,[r0,#0x0]	; 0232E34A
loc_0232E34C:
	mov r1,#0x0	; 0232E34C
	ldr r0,[pool_0232E370]	; 0232E34E
	str r1,[r0,#0x0]	; 0232E350
	ldr r0,[pool_0232E388]	; 0232E352
	str r1,[r0,#0x0]	; 0232E354
	ldr r0,[pool_0232E374]	; 0232E356
	ldr r1,[r0,#0x0]	; 0232E358
	add r1,r1,#0x1	; 0232E35A
	str r1,[r0,#0x0]	; 0232E35C
	ldr r0,[pool_0232E38C]	; 0232E35E
	ldr r1,[r0,#0x0]	; 0232E360
	add r1,r1,#0x1	; 0232E362
	str r1,[r0,#0x0]	; 0232E364
	mov r0,#0x1	; 0232E366
	pop {r4}	; 0232E368
	pop {r3}	; 0232E36A
	bx r3	; 0232E36C
	.byte 0xC0, 0x46	; 0232E370
pool_0232E370:
loc_0232E370:
	.word P1_BssStart + 0x266D8	; 0232E370
pool_0232E374:
loc_0232E374:
	.word P1_BssStart + 0x266EC	; 0232E374
pool_0232E378:
loc_0232E378:
	.word 0x02357360	; 0232E378
pool_0232E37C:
loc_0232E37C:
	.word 0x00001800	; 0232E37C
pool_0232E380:
loc_0232E380:
	.word P1_BssStart + 0x266E8	; 0232E380
pool_0232E384:
loc_0232E384:
	.word P1_BssStart + 0x266F4	; 0232E384
pool_0232E388:
loc_0232E388:
	.word P1_BssStart + 0x266DC	; 0232E388
pool_0232E38C:
loc_0232E38C:
	.word P1_BssStart + 0x266F0	; 0232E38C

; ===== function loc_0232E390 =====
loc_0232E390:
	ldr r2,[pool_0232E3AC]	; 0232E390
	ldr r1,[r2,#0x0]	; 0232E392
	cmp r1,#0x0	; 0232E394
	bne loc_0232E3A0	; 0232E396
	ldr r1,[pool_0232E3B0]	; 0232E398
	str r0,[r1,#0x0]	; 0232E39A
	str r0,[r2,#0x0]	; 0232E39C
	b loc_0232E3A4	; 0232E39E
loc_0232E3A0:
	str r0,[r1,#0x0]	; 0232E3A0
	str r0,[r2,#0x0]	; 0232E3A2
loc_0232E3A4:
	mov r1,#0x0	; 0232E3A4
	str r1,[r0,#0x0]	; 0232E3A6
	bx lr	; 0232E3A8
	.byte 0xC0, 0x46	; 0232E3AC
pool_0232E3AC:
loc_0232E3AC:
	.word P1_BssStart + 0x266DC	; 0232E3AC
pool_0232E3B0:
loc_0232E3B0:
	.word P1_BssStart + 0x266D8	; 0232E3B0

; ===== function loc_0232E3B4 =====
loc_0232E3B4:
	push {r4,lr}	; 0232E3B4
	add r4,r0,#0x0	; 0232E3B6
	bl loc_0232B988	; 0232E3B8
	cmp r0,#0x0	; 0232E3BC
	beq loc_0232E3C8	; 0232E3BE
	mov r0,#0x0	; 0232E3C0
	pop {r4}	; 0232E3C2
	pop {r3}	; 0232E3C4
	bx r3	; 0232E3C6
loc_0232E3C8:
	bl loc_0232E13C	; 0232E3C8
	cmp r0,#0x0	; 0232E3CC
	bne loc_0232E418	; 0232E3CE
	cmp r4,#0x0	; 0232E3D0
	bne loc_0232E3DC	; 0232E3D2
	mov r0,#0x0	; 0232E3D4
	pop {r4}	; 0232E3D6
	pop {r3}	; 0232E3D8
	bx r3	; 0232E3DA
loc_0232E3DC:
	bl loc_0232E1E0	; 0232E3DC
	cmp r0,#0x0	; 0232E3E0
	ble loc_0232E3FE	; 0232E3E2
	mov r4,#0x0	; 0232E3E4
loc_0232E3E6:
	add r0,r4,#0x0	; 0232E3E6
	bl loc_0232E420	; 0232E3E8
	cmp r0,#0x0	; 0232E3EC
	bne loc_0232E3E6	; 0232E3EE
	bl loc_0232E13C	; 0232E3F0
	cmp r0,#0x0	; 0232E3F4
	beq loc_0232E404	; 0232E3F6
	pop {r4}	; 0232E3F8
	pop {r3}	; 0232E3FA
	bx r3	; 0232E3FC
loc_0232E3FE:
	mov r0,#0x1	; 0232E3FE
	bl loc_0232E2C8	; 0232E400
loc_0232E404:
	bl loc_0232E160	; 0232E404
	mov r4,#0x1	; 0232E408
loc_0232E40A:
	add r0,r4,#0x0	; 0232E40A
	bl loc_0232E420	; 0232E40C
	bl loc_0232E13C	; 0232E410
	cmp r0,#0x0	; 0232E414
	beq loc_0232E40A	; 0232E416
loc_0232E418:
	pop {r4}	; 0232E418
	pop {r3}	; 0232E41A
	bx r3	; 0232E41C
	.byte 0x00, 0x00	; 0232E420

; ===== function loc_0232E420 =====
loc_0232E420:
	push {lr}	; 0232E420
	sub sp,#0x4	; 0232E422
	cmp r0,#0x0	; 0232E424
	bne loc_0232E43C	; 0232E426
	bl loc_0232E640	; 0232E428
	ldr r1,[pool_0232E498]	; 0232E42C
	ldr r1,[r1,#0x0]	; 0232E42E
	cmp r1,r0	; 0232E430
	bne loc_0232E448	; 0232E432
	mov r0,#0x0	; 0232E434
	add sp,#0x4	; 0232E436
	pop {r3}	; 0232E438
	bx r3	; 0232E43A
loc_0232E43C:
	bl loc_0232E640	; 0232E43C
	ldr r1,[pool_0232E498]	; 0232E440
	ldr r1,[r1,#0x0]	; 0232E442
	cmp r1,r0	; 0232E444
	beq loc_0232E43C	; 0232E446
loc_0232E448:
	ldr r1,[pool_0232E49C]	; 0232E448
	ldr r2,[r1,#0x0]	; 0232E44A
	lsl r3,r2,#0x2	; 0232E44C
	ldr r0,[pool_0232E4A0]	; 0232E44E
	ldr r0,[r0,r3]	; 0232E450
	add r2,r2,#0x1	; 0232E452
	str r2,[r1,#0x0]	; 0232E454
	cmp r2,#0x8	; 0232E456
	ble loc_0232E45E	; 0232E458
	mov r2,#0x0	; 0232E45A
	str r2,[r1,#0x0]	; 0232E45C
loc_0232E45E:
	add r2,r0,#0x0	; 0232E45E
	ldr r1,[r0,#0x0]	; 0232E460
	cmp r1,#0x0	; 0232E462
	beq loc_0232E46E	; 0232E464
loc_0232E466:
	ldr r2,[r2,#0x0]	; 0232E466
	ldr r1,[r2,#0x0]	; 0232E468
	cmp r1,#0x0	; 0232E46A
	bne loc_0232E466	; 0232E46C
loc_0232E46E:
	ldr r1,[pool_0232E4A4]	; 0232E46E
	ldr r1,[r1,#0x0]	; 0232E470
	cmp r1,#0x0	; 0232E472
	beq loc_0232E47A	; 0232E474
	str r0,[r1,#0x0]	; 0232E476
	b loc_0232E47E	; 0232E478
loc_0232E47A:
	ldr r1,[pool_0232E4A8]	; 0232E47A
	str r0,[r1,#0x0]	; 0232E47C
loc_0232E47E:
	ldr r1,[pool_0232E4A4]	; 0232E47E
	str r2,[r1,#0x0]	; 0232E480
	ldr r1,[pool_0232E4AC]	; 0232E482
	ldr r2,[r1,#0x0]	; 0232E484
	sub r2,r2,#0x1	; 0232E486
	str r2,[r1,#0x0]	; 0232E488
	ldr r1,[pool_0232E498]	; 0232E48A
	ldr r2,[r1,#0x0]	; 0232E48C
	add r2,r2,#0x1	; 0232E48E
	str r2,[r1,#0x0]	; 0232E490
	add sp,#0x4	; 0232E492
	pop {r3}	; 0232E494
	bx r3	; 0232E496
pool_0232E498:
loc_0232E498:
	.word P1_BssStart + 0x266D4	; 0232E498
pool_0232E49C:
loc_0232E49C:
	.word P1_BssStart + 0x266E4	; 0232E49C
pool_0232E4A0:
loc_0232E4A0:
	.word P1_BssStart + 0x266F4	; 0232E4A0
pool_0232E4A4:
loc_0232E4A4:
	.word P1_BssStart + 0x266E0	; 0232E4A4
pool_0232E4A8:
loc_0232E4A8:
	.word P1_BssStart + 0x266D0	; 0232E4A8
pool_0232E4AC:
loc_0232E4AC:
	.word P1_BssStart + 0x266EC	; 0232E4AC

; ===== function loc_0232E4B0 =====
loc_0232E4B0:
	push {r4,lr}	; 0232E4B0
	bl loc_0232E180	; 0232E4B2
	ldr r3,[pool_0232E52C]	; 0232E4B6
	ldr r0,[pool_0232E530]	; 0232E4B8
	str r3,[r0,#0x0]	; 0232E4BA
	mov r4,#0x0	; 0232E4BC
	add r2,r3,#0x0	; 0232E4BE
	mov r0,#0x18	; 0232E4C0
loc_0232E4C2:
	add r4,r4,#0x1	; 0232E4C2
	add r1,r4,#0x0	; 0232E4C4
	mul r1,r0	; 0232E4C6
	add r1,r2,r1	; 0232E4C8
	str r1,[r3,#0x0]	; 0232E4CA
	add r3,#0x18	; 0232E4CC
	cmp r4,#0xff	; 0232E4CE
	blt loc_0232E4C2	; 0232E4D0
	mov r0,#0x0	; 0232E4D2
	ldr r1,[pool_0232E534]	; 0232E4D4
	str r0,[r1,#0x68]	; 0232E4D6
	ldr r2,[pool_0232E538]	; 0232E4D8
	ldr r1,[pool_0232E53C]	; 0232E4DA
	str r2,[r1,#0x0]	; 0232E4DC
	ldr r1,[pool_0232E540]	; 0232E4DE
	str r0,[r1,#0x0]	; 0232E4E0
	ldr r1,[pool_0232E544]	; 0232E4E2
	str r0,[r1,#0x0]	; 0232E4E4
	ldr r1,[pool_0232E548]	; 0232E4E6
	str r0,[r1,#0x0]	; 0232E4E8
	ldr r1,[pool_0232E54C]	; 0232E4EA
	str r0,[r1,#0x0]	; 0232E4EC
	ldr r1,[pool_0232E550]	; 0232E4EE
	str r0,[r1,#0x0]	; 0232E4F0
	mov r2,#0x1	; 0232E4F2
	ldr r1,[pool_0232E554]	; 0232E4F4
	str r2,[r1,#0x0]	; 0232E4F6
	ldr r1,[pool_0232E558]	; 0232E4F8
	str r0,[r1,#0x0]	; 0232E4FA
	ldr r0,[pool_0232E55C]	; 0232E4FC
	ldr r1,[pool_0232E560]	; 0232E4FE
	str r0,[r1,#0x0]	; 0232E500
	bl loc_0232E5F0	; 0232E502
	mov r0,#0x1	; 0232E506
	bl loc_0232E3B4	; 0232E508
	cmp r0,#0x0	; 0232E50C
	beq loc_0232E524	; 0232E50E
	mov r1,#0x19	; 0232E510
	str r1,[r0,#0x4]	; 0232E512
	ldr r1,[pool_0232E560]	; 0232E514
	ldr r1,[r1,#0x0]	; 0232E516
	str r1,[r0,#0x8]	; 0232E518
	bl loc_0232E390	; 0232E51A
	mov r0,#0x1	; 0232E51E
	bl loc_0232E2C8	; 0232E520
loc_0232E524:
	pop {r4}	; 0232E524
	pop {r3}	; 0232E526
	bx r3	; 0232E528
	.byte 0xC0, 0x46	; 0232E52C
pool_0232E52C:
loc_0232E52C:
	.word P1_BssStart + 0x269A0	; 0232E52C
pool_0232E530:
loc_0232E530:
	.word P1_BssStart + 0x266D0	; 0232E530
pool_0232E534:
loc_0232E534:
	.word P1_BssStart + 0x28120	; 0232E534
pool_0232E538:
loc_0232E538:
	.word 0x02358B48	; 0232E538
pool_0232E53C:
loc_0232E53C:
	.word P1_BssStart + 0x266E0	; 0232E53C
pool_0232E540:
loc_0232E540:
	.word P1_BssStart + 0x266D8	; 0232E540
pool_0232E544:
loc_0232E544:
	.word P1_BssStart + 0x266DC	; 0232E544
pool_0232E548:
loc_0232E548:
	.word P1_BssStart + 0x266EC	; 0232E548
pool_0232E54C:
loc_0232E54C:
	.word P1_BssStart + 0x266E4	; 0232E54C
pool_0232E550:
loc_0232E550:
	.word P1_BssStart + 0x266E8	; 0232E550
pool_0232E554:
loc_0232E554:
	.word P1_BssStart + 0x266F0	; 0232E554
pool_0232E558:
loc_0232E558:
	.word P1_BssStart + 0x266D4	; 0232E558
pool_0232E55C:
loc_0232E55C:
	.word 0x023570E0	; 0232E55C
pool_0232E560:
loc_0232E560:
	.word P1_BssStart + 0x28200	; 0232E560

; ===== function loc_0232E564 =====
loc_0232E564:
	push {r4,lr}	; 0232E564
	ldr r4,[pool_0232E590]	; 0232E566
	mov r2,#0xff	; 0232E568
	add r3,r0,#0x0	; 0232E56A
	and r3,r2	; 0232E56C
	mov r1,#0xc	; 0232E56E
	mul r3,r1	; 0232E570
	add r3,r4,r3	; 0232E572
	asr r1,r0,#0x8	; 0232E574
	and r1,r2	; 0232E576
	ldrb r0,[r3,#0x8]	; 0232E578
	cmp r1,r0	; 0232E57A
	bne loc_0232E588	; 0232E57C
	ldr r1,[r3,#0x0]	; 0232E57E
	cmp r1,#0x0	; 0232E580
	beq loc_0232E588	; 0232E582
	ldr r0,[r3,#0x4]	; 0232E584
	blx r1	; 0232E586
loc_0232E588:
	pop {r4}	; 0232E588
	pop {r3}	; 0232E58A
	bx r3	; 0232E58C
	.byte 0xC0, 0x46	; 0232E590
pool_0232E590:
loc_0232E590:
	.word 0x02358B60	; 0232E590

; ===== function loc_0232E594 =====
loc_0232E594:
	push {r4}	; 0232E594
	sub sp,#0x4	; 0232E596
	ldr r4,[pool_0232E5B8]	; 0232E598
	mov r3,#0xc	; 0232E59A
	mul r0,r3	; 0232E59C
	add r3,r4,r0	; 0232E59E
	str r1,[r4,r0]	; 0232E5A0
	str r2,[r3,#0x4]	; 0232E5A2
	add r1,r3,#0x0	; 0232E5A4
	add r1,#0x8	; 0232E5A6
	ldrb r0,[r1,#0x0]	; 0232E5A8
	add r0,r0,#0x1	; 0232E5AA
	strb r0,[r1,#0x0]	; 0232E5AC
	ldrb r0,[r3,#0x8]	; 0232E5AE
	add sp,#0x4	; 0232E5B0
	pop {r4}	; 0232E5B2
	bx lr	; 0232E5B4
	.byte 0xC0, 0x46	; 0232E5B8
pool_0232E5B8:
loc_0232E5B8:
	.word P1_BssStart + 0x281A0	; 0232E5B8

; ===== function loc_0232E5BC =====
loc_0232E5BC:
	ldr r2,[pool_0232E5D0]	; 0232E5BC
	mov r1,#0xc	; 0232E5BE
	mul r0,r1	; 0232E5C0
	add r1,r2,r0	; 0232E5C2
	add r1,#0x8	; 0232E5C4
	ldrb r0,[r1,#0x0]	; 0232E5C6
	add r0,r0,#0x1	; 0232E5C8
	strb r0,[r1,#0x0]	; 0232E5CA
	bx lr	; 0232E5CC
	.byte 0xC0, 0x46	; 0232E5D0
pool_0232E5D0:
loc_0232E5D0:
	.word 0x02358B60	; 0232E5D0

; ===== function loc_0232E5D4 =====
loc_0232E5D4:
	mov r2,#0x0	; 0232E5D4
	ldr r1,[pool_0232E5EC]	; 0232E5D6
	add r0,r2,#0x0	; 0232E5D8
loc_0232E5DA:
	str r0,[r1,#0x0]	; 0232E5DA
	str r0,[r1,#0x4]	; 0232E5DC
	strb r0,[r1,#0x8]	; 0232E5DE
	add r1,#0xc	; 0232E5E0
	add r2,r2,#0x1	; 0232E5E2
	cmp r2,#0x8	; 0232E5E4
	blt loc_0232E5DA	; 0232E5E6
	bx lr	; 0232E5E8
	.byte 0xC0, 0x46	; 0232E5EC
pool_0232E5EC:
loc_0232E5EC:
	.word P1_BssStart + 0x281A0	; 0232E5EC

; ===== function loc_0232E5F0 =====
loc_0232E5F0:
	push {r4,r5,r6,lr}	; 0232E5F0
	mov r6,#0x0	; 0232E5F2
	str r6,[r0,#0x4]	; 0232E5F4
	strh r6,[r0,#0x8]	; 0232E5F6
	strh r6,[r0,#0xa]	; 0232E5F8
	str r6,[r0,#0x0]	; 0232E5FA
	add r4,r0,#0x0	; 0232E5FC
	mvn r1,r6	; 0232E5FE
	add r2,r6,#0x0	; 0232E600
loc_0232E602:
	str r2,[r4,#0x40]	; 0232E602
	add r5,r2,#0x0	; 0232E604
	add r3,r4,#0x0	; 0232E606
loc_0232E608:
	strh r1,[r3,#0x20]	; 0232E608
	add r3,r3,#0x2	; 0232E60A
	add r5,r5,#0x1	; 0232E60C
	cmp r5,#0x10	; 0232E60E
	blt loc_0232E608	; 0232E610
	add r4,#0x24	; 0232E612
	add r6,r6,#0x1	; 0232E614
	cmp r6,#0x10	; 0232E616
	blt loc_0232E602	; 0232E618
	mov r3,#0x0	; 0232E61A
	add r4,r0,#0x0	; 0232E61C
	mvn r2,r3	; 0232E61E
	ldr r1,[pool_0232E638]	; 0232E620
loc_0232E622:
	strh r2,[r4,r1]	; 0232E622
	add r4,r4,#0x2	; 0232E624
	add r3,r3,#0x1	; 0232E626
	cmp r3,#0x10	; 0232E628
	blt loc_0232E622	; 0232E62A
	ldr r1,[pool_0232E63C]	; 0232E62C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E62E
	pop {r4,r5,r6}	; 0232E632
	pop {r3}	; 0232E634
	bx r3	; 0232E636
pool_0232E638:
loc_0232E638:
	.word 0x00000260	; 0232E638
pool_0232E63C:
loc_0232E63C:
	.word 0x00000280	; 0232E63C

; ===== function loc_0232E640 =====
loc_0232E640:
	push {lr}	; 0232E640
	sub sp,#0x4	; 0232E642
	ldr r0,[pool_0232E65C]	; 0232E644
	ldr r0,[r0,#0x0]	; 0232E646
	ldr r1,[pool_0232E660]	; 0232E648
	blx P1_InvalidateDataCacheRange	; 0232E64A
	ldr r0,[pool_0232E65C]	; 0232E64E
	ldr r0,[r0,#0x0]	; 0232E650
	ldr r0,[r0,#0x0]	; 0232E652
	add sp,#0x4	; 0232E654
	pop {r3}	; 0232E656
	bx r3	; 0232E658
	.byte 0xC0, 0x46	; 0232E65C
pool_0232E65C:
loc_0232E65C:
	.word P1_BssStart + 0x28200	; 0232E65C
pool_0232E660:
loc_0232E660:
	.word 0x00000280	; 0232E660

; ===== function loc_0232E664 =====
loc_0232E664:
	push {lr}	; 0232E664
	sub sp,#0x4	; 0232E666
	ldr r0,[pool_0232E680]	; 0232E668
	ldr r0,[r0,#0x0]	; 0232E66A
	ldr r1,[pool_0232E684]	; 0232E66C
	blx P1_InvalidateDataCacheRange	; 0232E66E
	ldr r0,[pool_0232E680]	; 0232E672
	ldr r0,[r0,#0x0]	; 0232E674
	ldrh r0,[r0,#0x8]	; 0232E676
	add sp,#0x4	; 0232E678
	pop {r3}	; 0232E67A
	bx r3	; 0232E67C
	.byte 0xC0, 0x46	; 0232E680
pool_0232E680:
loc_0232E680:
	.word P1_BssStart + 0x28200	; 0232E680
pool_0232E684:
loc_0232E684:
	.word 0x00000280	; 0232E684

; ===== function loc_0232E688 =====
loc_0232E688:
	push {lr}	; 0232E688
	sub sp,#0x4	; 0232E68A
	ldr r0,[pool_0232E6A4]	; 0232E68C
	ldr r0,[r0,#0x0]	; 0232E68E
	ldr r1,[pool_0232E6A8]	; 0232E690
	blx P1_InvalidateDataCacheRange	; 0232E692
	ldr r0,[pool_0232E6A4]	; 0232E696
	ldr r0,[r0,#0x0]	; 0232E698
	ldr r0,[r0,#0x4]	; 0232E69A
	add sp,#0x4	; 0232E69C
	pop {r3}	; 0232E69E
	bx r3	; 0232E6A0
	.byte 0xC0, 0x46	; 0232E6A4
pool_0232E6A4:
loc_0232E6A4:
	.word P1_BssStart + 0x28200	; 0232E6A4
pool_0232E6A8:
loc_0232E6A8:
	.word 0x00000280	; 0232E6A8

; ===== function loc_0232E6AC =====
loc_0232E6AC:
	push {r4,r5,r6,r7,lr}	; 0232E6AC
	sub sp,#0x4	; 0232E6AE
	add r5,r0,#0x0	; 0232E6B0
	add r7,r1,#0x0	; 0232E6B2
	add r4,r2,#0x0	; 0232E6B4
	lsl r2,r7,#0x3	; 0232E6B6
	add r1,r5,r2	; 0232E6B8
	ldr r0,[r1,#0x18]	; 0232E6BA
	cmp r0,#0x0	; 0232E6BC
	beq loc_0232E6FC	; 0232E6BE
	cmp r4,r0	; 0232E6C0
	beq loc_0232E71E	; 0232E6C2
	ldr r6,[r0,#0x18]	; 0232E6C4
	add r3,r5,#0x0	; 0232E6C6
	add r3,#0x18	; 0232E6C8
	add r3,r3,r2	; 0232E6CA
	cmp r3,r6	; 0232E6CC
	bne loc_0232E6DE	; 0232E6CE
	ldr r2,[r1,#0x1c]	; 0232E6D0
	str r2,[r0,#0x18]	; 0232E6D2
	ldr r0,[r1,#0x18]	; 0232E6D4
	mov r1,#0x3c	; 0232E6D6
	blx P1_CleanDataCacheRange	; 0232E6D8
	b loc_0232E6FC	; 0232E6DC
loc_0232E6DE:
	cmp r6,#0x0	; 0232E6DE
	beq loc_0232E6EE	; 0232E6E0
loc_0232E6E2:
	ldr r0,[r6,#0x4]	; 0232E6E2
	cmp r3,r0	; 0232E6E4
	beq loc_0232E6EE	; 0232E6E6
	add r6,r0,#0x0	; 0232E6E8
	cmp r0,#0x0	; 0232E6EA
	bne loc_0232E6E2	; 0232E6EC
loc_0232E6EE:
	add r0,r5,r2	; 0232E6EE
	ldr r0,[r0,#0x1c]	; 0232E6F0
	str r0,[r6,#0x4]	; 0232E6F2
	add r0,r6,#0x0	; 0232E6F4
	mov r1,#0x8	; 0232E6F6
	blx P1_CleanDataCacheRange	; 0232E6F8
loc_0232E6FC:
	ldr r0,[r4,#0x18]	; 0232E6FC
	lsl r3,r7,#0x3	; 0232E6FE
	add r2,r5,#0x0	; 0232E700
	add r2,#0x18	; 0232E702
	add r1,r2,r3	; 0232E704
	str r1,[r4,#0x18]	; 0232E706
	add r1,r5,r3	; 0232E708
	str r0,[r1,#0x1c]	; 0232E70A
	str r4,[r2,r3]	; 0232E70C
	add r0,r5,#0x0	; 0232E70E
	mov r1,#0x3c	; 0232E710
	blx P1_CleanDataCacheRange	; 0232E712
	add r0,r4,#0x0	; 0232E716
	mov r1,#0x3c	; 0232E718
	blx P1_CleanDataCacheRange	; 0232E71A
loc_0232E71E:
	add sp,#0x4	; 0232E71E
	pop {r4,r5,r6,r7}	; 0232E720
	pop {r3}	; 0232E722
	bx r3	; 0232E724
	.byte 0x00, 0x00	; 0232E728

; ===== function loc_0232E728 =====
loc_0232E728:
	ldr r3,[pool_0232E72C]	; 0232E728
	bx r3	; 0232E72A
pool_0232E72C:
loc_0232E72C:
	.word loc_0232E918 + 1	; 0232E72C

; ===== function loc_0232E730 =====
P1_IrqHandler_0232E730:
	push {r4,r5,r6,r7,lr}	; 0232E730
	sub sp,#0x4	; 0232E732
	ldr r5,[pool_0232E7EC]	; 0232E734
	mov r0,#0x3	; 0232E736
	mvn r6,r0	; 0232E738
	mov r7,#0x2	; 0232E73A
	mvn r4,r7	; 0232E73C
loc_0232E73E:
	ldrh r1,[r5,#0x0]	; 0232E73E
	ldr r0,[pool_0232E7F0]	; 0232E740
	and r1,r0	; 0232E742
	cmp r1,#0x0	; 0232E744
	beq loc_0232E754	; 0232E746
	ldrh r1,[r5,#0x0]	; 0232E748
	ldr r0,[pool_0232E7F4]	; 0232E74A
	orr r1,r0	; 0232E74C
	strh r1,[r5,#0x0]	; 0232E74E
	add r0,r4,#0x0	; 0232E750
	b loc_0232E776	; 0232E752
loc_0232E754:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E754
	ldrh r2,[r5,#0x0]	; 0232E758
	ldr r1,[pool_0232E7F8]	; 0232E75A
	and r2,r1	; 0232E75C
	cmp r2,#0x0	; 0232E75E
	beq loc_0232E76A	; 0232E760
	blx P1_Arm9RestoreIrqMask	; 0232E762
	add r0,r6,#0x0	; 0232E766
	b loc_0232E776	; 0232E768
loc_0232E76A:
	ldr r1,[pool_0232E7FC]	; 0232E76A
	ldr r1,[r1,#0x0]	; 0232E76C
	str r1,[sp,#0x0]	; 0232E76E
	blx P1_Arm9RestoreIrqMask	; 0232E770
	mov r0,#0x0	; 0232E774
loc_0232E776:
	mov r1,#0x3	; 0232E776
	mvn r1,r1	; 0232E778
	cmp r0,r1	; 0232E77A
	beq loc_0232E7E2	; 0232E77C
	mvn r1,r7	; 0232E77E
	cmp r0,r1	; 0232E780
	beq loc_0232E73E	; 0232E782
	ldr r2,[sp,#0x0]	; 0232E784
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 0232E786
	lsr r0,r0,#0x1b	; 0232E788
	cmp r0,#0x0	; 0232E78A
	beq loc_0232E73E	; 0232E78C
	lsl r3,r0,#0x2	; 0232E78E
	ldr r1,[pool_0232E800]	; 0232E790
	ldr r3,[r1,r3]	; 0232E792
	cmp r3,#0x0	; 0232E794
	beq loc_0232E7A2	; 0232E796
	lsr r1,r2,#0x6	; 0232E798
	lsl r2,r2,#0x1a	; 0232E79A
	lsr r2,r2,#0x1f	; 0232E79C
	blx r3	; 0232E79E
	b loc_0232E73E	; 0232E7A0
loc_0232E7A2:
	lsl r0,r2,#0x1a	; 0232E7A2
	lsr r0,r0,#0x1f	; 0232E7A4
	cmp r0,#0x0	; 0232E7A6
	bne loc_0232E73E	; 0232E7A8
	mov r0,#0x20	; 0232E7AA
	orr r2,r0	; 0232E7AC
	str r2,[sp,#0x0]	; 0232E7AE
	ldrh r1,[r5,#0x0]	; 0232E7B0
	ldr r0,[pool_0232E7F0]	; 0232E7B2
	and r1,r0	; 0232E7B4
	cmp r1,#0x0	; 0232E7B6
	beq loc_0232E7C4	; 0232E7B8
	ldrh r1,[r5,#0x0]	; 0232E7BA
	ldr r0,[pool_0232E7F4]	; 0232E7BC
	orr r1,r0	; 0232E7BE
	strh r1,[r5,#0x0]	; 0232E7C0
	b loc_0232E73E	; 0232E7C2
loc_0232E7C4:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E7C4
	ldrh r1,[r5,#0x0]	; 0232E7C8
	and r1,r7	; 0232E7CA
	cmp r1,#0x0	; 0232E7CC
	beq loc_0232E7D6	; 0232E7CE
	blx P1_Arm9RestoreIrqMask	; 0232E7D0
	b loc_0232E73E	; 0232E7D4
loc_0232E7D6:
	ldr r2,[sp,#0x0]	; 0232E7D6
	ldr r1,[pool_0232E804]	; 0232E7D8
	str r2,[r1,#0x0]	; 0232E7DA
	blx P1_Arm9RestoreIrqMask	; 0232E7DC
	b loc_0232E73E	; 0232E7E0
loc_0232E7E2:
	add sp,#0x4	; 0232E7E2
	pop {r4,r5,r6,r7}	; 0232E7E4
	pop {r3}	; 0232E7E6
	bx r3	; 0232E7E8
	.byte 0xC0, 0x46	; 0232E7EC
pool_0232E7EC:
loc_0232E7EC:
	.word REG_IPC_FIFO_CR	; 0232E7EC
pool_0232E7F0:
loc_0232E7F0:
	.word 0x00004000	; 0232E7F0
pool_0232E7F4:
loc_0232E7F4:
	.word 0x0000C000	; 0232E7F4
pool_0232E7F8:
loc_0232E7F8:
	.word 0x00000100	; 0232E7F8
pool_0232E7FC:
loc_0232E7FC:
	.word REG_IPC_FIFO_RX	; 0232E7FC
pool_0232E800:
loc_0232E800:
	.word P1_PxiReceiveCallbacks	; 0232E800
pool_0232E804:
loc_0232E804:
	.word REG_IPC_FIFO_TX	; 0232E804

; ===== function loc_0232E808 =====
loc_0232E808:
	push {r4,lr}	; 0232E808
	sub sp,#0x8	; 0232E80A
	ldr r3,[sp,#0x0]	; 0232E80C
	mov r4,#0x1f	; 0232E80E
	bic r3,r4	; 0232E810
	and r0,r4	; 0232E812
	orr r3,r0	; 0232E814
	str r3,[sp,#0x0]	; 0232E816
	mov r0,#0x20	; 0232E818
	bic r3,r0	; 0232E81A
	mov r0,#0x1	; 0232E81C
	and r2,r0	; 0232E81E
	lsl r0,r2,#0x5	; 0232E820
	orr r3,r0	; 0232E822
	str r3,[sp,#0x0]	; 0232E824
	mov r0,#0x3f	; 0232E826
	and r3,r0	; 0232E828
	ldr r0,[pool_0232E888]	; 0232E82A
	and r1,r0	; 0232E82C
	lsl r0,r1,#0x6	; 0232E82E
	orr r3,r0	; 0232E830
	str r3,[sp,#0x0]	; 0232E832
	ldr r2,[pool_0232E88C]	; 0232E834
	ldrh r1,[r2,#0x0]	; 0232E836
	ldr r0,[pool_0232E890]	; 0232E838
	and r1,r0	; 0232E83A
	cmp r1,#0x0	; 0232E83C
	beq loc_0232E854	; 0232E83E
	ldrh r1,[r2,#0x0]	; 0232E840
	ldr r0,[pool_0232E894]	; 0232E842
	orr r1,r0	; 0232E844
	strh r1,[r2,#0x0]	; 0232E846
	mov r0,#0x0	; 0232E848
	mvn r0,r0	; 0232E84A
	add sp,#0x8	; 0232E84C
	pop {r4}	; 0232E84E
	pop {r3}	; 0232E850
	bx r3	; 0232E852
loc_0232E854:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E854
	ldr r1,[pool_0232E88C]	; 0232E858
	ldrh r2,[r1,#0x0]	; 0232E85A
	mov r1,#0x2	; 0232E85C
	and r2,r1	; 0232E85E
	cmp r2,#0x0	; 0232E860
	beq loc_0232E874	; 0232E862
	blx P1_Arm9RestoreIrqMask	; 0232E864
	mov r0,#0x1	; 0232E868
	mvn r0,r0	; 0232E86A
	add sp,#0x8	; 0232E86C
	pop {r4}	; 0232E86E
	pop {r3}	; 0232E870
	bx r3	; 0232E872
loc_0232E874:
	ldr r2,[sp,#0x0]	; 0232E874
	ldr r1,[pool_0232E898]	; 0232E876
	str r2,[r1,#0x0]	; 0232E878
	blx P1_Arm9RestoreIrqMask	; 0232E87A
	mov r0,#0x0	; 0232E87E
	add sp,#0x8	; 0232E880
	pop {r4}	; 0232E882
	pop {r3}	; 0232E884
	bx r3	; 0232E886
pool_0232E888:
loc_0232E888:
	.word 0x03FFFFFF	; 0232E888
pool_0232E88C:
loc_0232E88C:
	.word REG_IPC_FIFO_CR	; 0232E88C
pool_0232E890:
loc_0232E890:
	.word 0x00004000	; 0232E890
pool_0232E894:
loc_0232E894:
	.word 0x0000C000	; 0232E894
pool_0232E898:
loc_0232E898:
	.word REG_IPC_FIFO_TX	; 0232E898

; ===== function loc_0232E89C =====
loc_0232E89C:
	push {r4}	; 0232E89C
	sub sp,#0x4	; 0232E89E
	mov r3,#0x1	; 0232E8A0
	add r2,r3,#0x0	; 0232E8A2
	lsl r2,r0	; 0232E8A4
	ldr r4,[pool_0232E8C0]	; 0232E8A6
	lsl r0,r1,#0x2	; 0232E8A8
	add r1,r4,r0	; 0232E8AA
	ldr r0,[pool_0232E8C4]	; 0232E8AC
	ldr r0,[r1,r0]	; 0232E8AE
	and r2,r0	; 0232E8B0
	cmp r2,#0x0	; 0232E8B2
	bne loc_0232E8B8	; 0232E8B4
	mov r3,#0x0	; 0232E8B6
loc_0232E8B8:
	add r0,r3,#0x0	; 0232E8B8
	add sp,#0x4	; 0232E8BA
	pop {r4}	; 0232E8BC
	bx lr	; 0232E8BE
pool_0232E8C0:
loc_0232E8C0:
	.word 0x027FFC00	; 0232E8C0
pool_0232E8C4:
loc_0232E8C4:
	.word 0x00000388	; 0232E8C4

; ===== function loc_0232E8C8 =====
loc_0232E8C8:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P1_SetPxiReceiveCallback
	push {r4,r5,lr}	; 0232E8C8
	sub sp,#0x4	; 0232E8CA
	add r5,r0,#0x0	; 0232E8CC
	add r4,r1,#0x0	; 0232E8CE
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E8D0
	lsl r2,r5,#0x2	; 0232E8D4
	ldr r1,[pool_0232E90C]	; 0232E8D6
	str r4,[r1,r2]	; 0232E8D8
	cmp r4,#0x0	; 0232E8DA
	beq loc_0232E8F0	; 0232E8DC
	ldr r2,[pool_0232E910]	; 0232E8DE
	ldr r1,[pool_0232E914]	; 0232E8E0
	add r1,r2,r1	; 0232E8E2
	ldr r3,[r1,#0x0]	; 0232E8E4
	mov r2,#0x1	; 0232E8E6
	lsl r2,r5	; 0232E8E8
	orr r3,r2	; 0232E8EA
	str r3,[r1,#0x0]	; 0232E8EC
	b loc_0232E900	; 0232E8EE
loc_0232E8F0:
	ldr r2,[pool_0232E910]	; 0232E8F0
	ldr r1,[pool_0232E914]	; 0232E8F2
	add r1,r2,r1	; 0232E8F4
	ldr r3,[r1,#0x0]	; 0232E8F6
	mov r2,#0x1	; 0232E8F8
	lsl r2,r5	; 0232E8FA
	bic r3,r2	; 0232E8FC
	str r3,[r1,#0x0]	; 0232E8FE
loc_0232E900:
	blx P1_Arm9RestoreIrqMask	; 0232E900
	add sp,#0x4	; 0232E904
	pop {r4,r5}	; 0232E906
	pop {r3}	; 0232E908
	bx r3	; 0232E90A
.endfunc
pool_0232E90C:
loc_0232E90C:
	.word P1_PxiReceiveCallbacks	; 0232E90C
pool_0232E910:
loc_0232E910:
	.word FirmwareSystemWorkAddress	; 0232E910
pool_0232E914:
loc_0232E914:
	.word SystemWorkPxiArm9AvailableOffset	; 0232E914

; ===== function loc_0232E918 =====
loc_0232E918:
	push {r4,r5,r6,r7,lr}	; 0232E918
	sub sp,#0x4	; 0232E91A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E91C
	str r0,[sp,#0x0]	; 0232E920
	ldr r0,[pool_0232E9A0]	; 0232E922
	ldrh r1,[r0,#0x0]	; 0232E924
	cmp r1,#0x0	; 0232E926
	bne loc_0232E990	; 0232E928
	mov r1,#0x1	; 0232E92A
	strh r1,[r0,#0x0]	; 0232E92C
	mov r2,#0x0	; 0232E92E
	ldr r1,[pool_0232E9A4]	; 0232E930
	ldr r0,[pool_0232E9A8]	; 0232E932
	str r2,[r1,r0]	; 0232E934
	ldr r1,[pool_0232E9AC]	; 0232E936
	add r0,r2,#0x0	; 0232E938
loc_0232E93A:
	stmia r1!,{r0}	; 0232E93A
	add r2,r2,#0x1	; 0232E93C
	cmp r2,#PxiFifoChannelCount	; 0232E93E
	blt loc_0232E93A	; 0232E940
	ldr r0,[pool_0232E9B0]	; 0232E942
	ldr r1,[pool_0232E9B4]	; 0232E944
	bl loc_0232B134	; 0232E946
	ldr r0,[pool_0232E9B0]	; 0232E94A
	bl loc_0232B0B0	; 0232E94C
	ldr r1,[pool_0232E9B8]	; 0232E950
	ldr r0,[pool_0232E9BC]	; 0232E952
	strh r1,[r0,#0x0]	; 0232E954
	mov r1,#0x0	; 0232E956
	ldr r0,[pool_0232E9C0]	; 0232E958
	add r6,r1,#0x0	; 0232E95A
	ldr r7,[pool_0232E9C4]	; 0232E95C
	mov r4,#0xf	; 0232E95E
loc_0232E960:
	ldrh r2,[r0,#0x0]	; 0232E960
	and r2,r4	; 0232E962
	lsl r3,r2,#0x8	; 0232E964
	strh r3,[r0,#0x0]	; 0232E966
	cmp r2,#0x0	; 0232E968
	bne loc_0232E970	; 0232E96A
	cmp r1,#0x4	; 0232E96C
	bgt loc_0232E990	; 0232E96E
loc_0232E970:
	add r3,r7,#0x0	; 0232E970
	ldrh r5,[r0,#0x0]	; 0232E972
	and r5,r4	; 0232E974
	cmp r5,r2	; 0232E976
	bne loc_0232E98C	; 0232E978
loc_0232E97A:
	cmp r3,#0x0	; 0232E97A
	bgt loc_0232E982	; 0232E97C
	add r1,r6,#0x0	; 0232E97E
	b loc_0232E98C	; 0232E980
loc_0232E982:
	sub r3,r3,#0x1	; 0232E982
	ldrh r5,[r0,#0x0]	; 0232E984
	and r5,r4	; 0232E986
	cmp r5,r2	; 0232E988
	beq loc_0232E97A	; 0232E98A
loc_0232E98C:
	add r1,r1,#0x1	; 0232E98C
	b loc_0232E960	; 0232E98E
loc_0232E990:
	ldr r0,[sp,#0x0]	; 0232E990
	blx P1_Arm9RestoreIrqMask	; 0232E992
	add sp,#0x4	; 0232E996
	pop {r4,r5,r6,r7}	; 0232E998
	pop {r3}	; 0232E99A
	bx r3	; 0232E99C
	.byte 0xC0, 0x46	; 0232E9A0
pool_0232E9A0:
loc_0232E9A0:
	.word P1_BssStart + 0x28204	; 0232E9A0
pool_0232E9A4:
loc_0232E9A4:
	.word FirmwareSystemWorkAddress	; 0232E9A4
pool_0232E9A8:
loc_0232E9A8:
	.word SystemWorkPxiArm9AvailableOffset	; 0232E9A8
pool_0232E9AC:
loc_0232E9AC:
	.word P1_PxiReceiveCallbacks	; 0232E9AC
pool_0232E9B0:
loc_0232E9B0:
	.word 0x00040000	; 0232E9B0
pool_0232E9B4:
loc_0232E9B4:
	.word P1_IrqHandler_0232E730 + 1	; 0232E9B4
pool_0232E9B8:
loc_0232E9B8:
	.word 0x0000C408	; 0232E9B8
pool_0232E9BC:
loc_0232E9BC:
	.word REG_IPC_FIFO_CR	; 0232E9BC
pool_0232E9C0:
loc_0232E9C0:
	.word REG_IPC_SYNC	; 0232E9C0
pool_0232E9C4:
loc_0232E9C4:
	.word 0x000003E8	; 0232E9C4

; ===== function loc_0232E9C8 =====
loc_0232E9C8:
	ldr r3,[r0,#0x0]	; 0232E9C8
	ldr r2,[r0,#0x4]	; 0232E9CA
	ldr r1,[pool_0232E9F4]	; 0232E9CC
	str r3,[r1,#0x0]	; 0232E9CE
	str r2,[r1,#0x4]	; 0232E9D0
	ldr r3,[r0,#0x8]	; 0232E9D2
	ldr r2,[r0,#0xc]	; 0232E9D4
	ldr r1,[pool_0232E9F8]	; 0232E9D6
	str r3,[r1,#0x0]	; 0232E9D8
	str r2,[r1,#0x4]	; 0232E9DA
	ldrh r2,[r0,#0x18]	; 0232E9DC
	ldr r1,[pool_0232E9FC]	; 0232E9DE
	strh r2,[r1,#0x0]	; 0232E9E0
	ldr r3,[r0,#0x10]	; 0232E9E2
	ldr r2,[r0,#0x14]	; 0232E9E4
	ldr r1,[pool_0232EA00]	; 0232E9E6
	str r3,[r1,#0x0]	; 0232E9E8
	str r2,[r1,#0x4]	; 0232E9EA
	ldrh r1,[r0,#0x1a]	; 0232E9EC
	ldr r0,[pool_0232EA04]	; 0232E9EE
	strh r1,[r0,#0x0]	; 0232E9F0
	bx lr	; 0232E9F2
pool_0232E9F4:
loc_0232E9F4:
	.word REG_DIV_NUMER	; 0232E9F4
pool_0232E9F8:
loc_0232E9F8:
	.word REG_DIV_DENOM	; 0232E9F8
pool_0232E9FC:
loc_0232E9FC:
	.word REG_DIVCNT	; 0232E9FC
pool_0232EA00:
loc_0232EA00:
	.word REG_SQRT_PARAM	; 0232EA00
pool_0232EA04:
loc_0232EA04:
	.word REG_SQRTCNT	; 0232EA04

; ===== function loc_0232EA08 =====
loc_0232EA08:
	ldr r1,[pool_0232EA3C]	; 0232EA08
	ldr r2,[r1,#0x0]	; 0232EA0A
	ldr r1,[r1,#0x4]	; 0232EA0C
	str r2,[r0,#0x0]	; 0232EA0E
	str r1,[r0,#0x4]	; 0232EA10
	ldr r1,[pool_0232EA40]	; 0232EA12
	ldr r2,[r1,#0x0]	; 0232EA14
	ldr r1,[r1,#0x4]	; 0232EA16
	str r2,[r0,#0x8]	; 0232EA18
	str r1,[r0,#0xc]	; 0232EA1A
	ldr r1,[pool_0232EA44]	; 0232EA1C
	ldrh r2,[r1,#0x0]	; 0232EA1E
	mov r1,#0x3	; 0232EA20
	and r2,r1	; 0232EA22
	strh r2,[r0,#0x18]	; 0232EA24
	ldr r1,[pool_0232EA48]	; 0232EA26
	ldr r2,[r1,#0x0]	; 0232EA28
	ldr r1,[r1,#0x4]	; 0232EA2A
	str r2,[r0,#0x10]	; 0232EA2C
	str r1,[r0,#0x14]	; 0232EA2E
	ldr r1,[pool_0232EA4C]	; 0232EA30
	ldrh r2,[r1,#0x0]	; 0232EA32
	mov r1,#0x1	; 0232EA34
	and r2,r1	; 0232EA36
	strh r2,[r0,#0x1a]	; 0232EA38
	bx lr	; 0232EA3A
pool_0232EA3C:
loc_0232EA3C:
	.word REG_DIV_NUMER	; 0232EA3C
pool_0232EA40:
loc_0232EA40:
	.word REG_DIV_DENOM	; 0232EA40
pool_0232EA44:
loc_0232EA44:
	.word REG_DIVCNT	; 0232EA44
pool_0232EA48:
loc_0232EA48:
	.word REG_SQRT_PARAM	; 0232EA48
pool_0232EA4C:
loc_0232EA4C:
	.word REG_SQRTCNT	; 0232EA4C

; ===== function loc_0232EA50 =====
loc_0232EA50:
	ldr r1,[pool_0232EA5C]	; 0232EA50
loc_0232EA52:
	ldrh r2,[r1,#0x36]	; 0232EA52
	and r2,r0	; 0232EA54
	cmp r2,#0x0	; 0232EA56
	bne loc_0232EA52	; 0232EA58
	bx lr	; 0232EA5A
pool_0232EA5C:
loc_0232EA5C:
	.word P1_BssStart + 0x2828C	; 0232EA5C

; ===== function loc_0232EA60 =====
loc_0232EA60:
	push {r4,r5,r6,r7,lr}	; 0232EA60
	sub sp,#0x4	; 0232EA62
	add r5,r0,#0x0	; 0232EA64
	add r4,r1,#0x0	; 0232EA66
	ldr r0,[pool_0232EB20]	; 0232EA68
	ldrh r0,[r0,#0x30]	; 0232EA6A
	cmp r0,#0x0	; 0232EA6C
	bne loc_0232EA88	; 0232EA6E
	ldrh r0,[r4,#0x0]	; 0232EA70
	strh r0,[r5,#0x0]	; 0232EA72
	ldrh r0,[r4,#0x2]	; 0232EA74
	strh r0,[r5,#0x2]	; 0232EA76
	ldrh r0,[r4,#0x4]	; 0232EA78
	strh r0,[r5,#0x4]	; 0232EA7A
	ldrh r0,[r4,#0x6]	; 0232EA7C
	strh r0,[r5,#0x6]	; 0232EA7E
	add sp,#0x4	; 0232EA80
	pop {r4,r5,r6,r7}	; 0232EA82
	pop {r3}	; 0232EA84
	bx r3	; 0232EA86
loc_0232EA88:
	ldrh r0,[r4,#0x4]	; 0232EA88
	strh r0,[r5,#0x4]	; 0232EA8A
	ldrh r0,[r4,#0x6]	; 0232EA8C
	strh r0,[r5,#0x6]	; 0232EA8E
	ldrh r0,[r4,#0x4]	; 0232EA90
	cmp r0,#0x0	; 0232EA92
	bne loc_0232EAA4	; 0232EA94
	mov r0,#0x0	; 0232EA96
	strh r0,[r5,#0x0]	; 0232EA98
	strh r0,[r5,#0x2]	; 0232EA9A
	add sp,#0x4	; 0232EA9C
	pop {r4,r5,r6,r7}	; 0232EA9E
	pop {r3}	; 0232EAA0
	bx r3	; 0232EAA2
loc_0232EAA4:
	ldr r0,[pool_0232EB24]	; 0232EAA4
	ldr r0,[r0,#0x8]	; 0232EAA6
	asr r1,r0,#0x1f	; 0232EAA8
	ldrh r2,[r4,#0x0]	; 0232EAAA
	lsl r6,r2,#0x2	; 0232EAAC
	asr r3,r6,#0x1f	; 0232EAAE
	ldr r2,[pool_0232EB24]	; 0232EAB0
	ldr r2,[r2,#0x0]	; 0232EAB2
	asr r7,r2,#0x1f	; 0232EAB4
	sub r2,r6,r2	; 0232EAB6
	sbc r3,r7	; 0232EAB8
	blx P1_AeabiLmul	; 0232EABA
	lsl r1,r1,#0xa	; 0232EABE
	lsr r0,r0,#0x16	; 0232EAC0
	orr r0,r1	; 0232EAC2
	strh r0,[r5,#0x0]	; 0232EAC4
	mov r0,#0x0	; 0232EAC6
	ldrsh r1,[r5,r0]	; 0232EAC8
	cmp r1,#0x0	; 0232EACA
	bge loc_0232EAD2	; 0232EACC
	strh r0,[r5,#0x0]	; 0232EACE
	b loc_0232EADA	; 0232EAD0
loc_0232EAD2:
	cmp r1,#0xff	; 0232EAD2
	ble loc_0232EADA	; 0232EAD4
	mov r0,#0xff	; 0232EAD6
	strh r0,[r5,#0x0]	; 0232EAD8
loc_0232EADA:
	ldr r0,[pool_0232EB24]	; 0232EADA
	ldr r0,[r0,#0x14]	; 0232EADC
	asr r1,r0,#0x1f	; 0232EADE
	ldrh r2,[r4,#0x2]	; 0232EAE0
	lsl r2,r2,#0x2	; 0232EAE2
	asr r3,r2,#0x1f	; 0232EAE4
	ldr r4,[pool_0232EB24]	; 0232EAE6
	ldr r6,[r4,#0xc]	; 0232EAE8
	asr r4,r6,#0x1f	; 0232EAEA
	sub r2,r2,r6	; 0232EAEC
	sbc r3,r4	; 0232EAEE
	blx P1_AeabiLmul	; 0232EAF0
	lsl r1,r1,#0xa	; 0232EAF4
	lsr r0,r0,#0x16	; 0232EAF6
	orr r0,r1	; 0232EAF8
	strh r0,[r5,#0x2]	; 0232EAFA
	mov r0,#0x2	; 0232EAFC
	ldrsh r0,[r5,r0]	; 0232EAFE
	cmp r0,#0x0	; 0232EB00
	bge loc_0232EB10	; 0232EB02
	mov r0,#0x0	; 0232EB04
	strh r0,[r5,#0x2]	; 0232EB06
	add sp,#0x4	; 0232EB08
	pop {r4,r5,r6,r7}	; 0232EB0A
	pop {r3}	; 0232EB0C
	bx r3	; 0232EB0E
loc_0232EB10:
	cmp r0,#0xbf	; 0232EB10
	ble loc_0232EB18	; 0232EB12
	mov r0,#0xbf	; 0232EB14
	strh r0,[r5,#0x2]	; 0232EB16
loc_0232EB18:
	add sp,#0x4	; 0232EB18
	pop {r4,r5,r6,r7}	; 0232EB1A
	pop {r3}	; 0232EB1C
	bx r3	; 0232EB1E
pool_0232EB20:
loc_0232EB20:
	.word P1_BssStart + 0x2828C	; 0232EB20
pool_0232EB24:
loc_0232EB24:
	.word P1_BssStart + 0x282A4	; 0232EB24

; ===== function loc_0232EB28 =====
loc_0232EB28:
	push {r4,r5,r6,r7,lr}	; 0232EB28
	sub sp,#0x24	; 0232EB2A
	add r5,r0,#0x0	; 0232EB2C
	add r4,r1,#0x0	; 0232EB2E
	add r7,r2,#0x0	; 0232EB30
	add r6,r3,#0x0	; 0232EB32
	ldr r2,[pool_0232ECB4]	; 0232EB34
	cmp r4,r2	; 0232EB36
	bcs loc_0232EB4E	; 0232EB38
	cmp r7,r2	; 0232EB3A
	bcs loc_0232EB4E	; 0232EB3C
	add r3,sp,#0x28	; 0232EB3E
	ldrh r1,[r3,#0x14]	; 0232EB40
	cmp r1,r2	; 0232EB42
	bcs loc_0232EB4E	; 0232EB44
	ldrh r0,[r3,#0x18]	; 0232EB46
	str r0,[sp,#0x20]	; 0232EB48
	cmp r0,r2	; 0232EB4A
	bcc loc_0232EB58	; 0232EB4C
loc_0232EB4E:
	mov r0,#0x1	; 0232EB4E
	add sp,#0x24	; 0232EB50
	pop {r4,r5,r6,r7}	; 0232EB52
	pop {r3}	; 0232EB54
	bx r3	; 0232EB56
loc_0232EB58:
	ldr r0,[pool_0232ECB8]	; 0232EB58
	cmp r6,r0	; 0232EB5A
	bcs loc_0232EB74	; 0232EB5C
	ldrh r0,[r3,#0x1c]	; 0232EB5E
	ldr r2,[pool_0232ECB8]	; 0232EB60
	cmp r0,r2	; 0232EB62
	bcs loc_0232EB74	; 0232EB64
	ldrh r2,[r3,#0x10]	; 0232EB66
	str r2,[sp,#0x1c]	; 0232EB68
	cmp r2,#0xc0	; 0232EB6A
	bcs loc_0232EB74	; 0232EB6C
	ldrh r2,[r3,#0x20]	; 0232EB6E
	cmp r2,#0xc0	; 0232EB70
	bcc loc_0232EB7E	; 0232EB72
loc_0232EB74:
	mov r0,#0x1	; 0232EB74
	add sp,#0x24	; 0232EB76
	pop {r4,r5,r6,r7}	; 0232EB78
	pop {r3}	; 0232EB7A
	bx r3	; 0232EB7C
loc_0232EB7E:
	cmp r6,r0	; 0232EB7E
	beq loc_0232EB92	; 0232EB80
	ldr r0,[sp,#0x1c]	; 0232EB82
	cmp r0,r2	; 0232EB84
	beq loc_0232EB92	; 0232EB86
	cmp r4,r1	; 0232EB88
	beq loc_0232EB92	; 0232EB8A
	ldr r0,[sp,#0x20]	; 0232EB8C
	cmp r7,r0	; 0232EB8E
	bne loc_0232EB9C	; 0232EB90
loc_0232EB92:
	mov r0,#0x1	; 0232EB92
	add sp,#0x24	; 0232EB94
	pop {r4,r5,r6,r7}	; 0232EB96
	pop {r3}	; 0232EB98
	bx r3	; 0232EB9A
loc_0232EB9C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EB9C
	str r0,[sp,#0x4]	; 0232EBA0
	mov r3,#0x0	; 0232EBA2
	ldr r0,[pool_0232ECBC]	; 0232EBA4
	strh r3,[r0,#0x0]	; 0232EBA6
	add r1,sp,#0x28	; 0232EBA8
	ldrh r1,[r1,#0x14]	; 0232EBAA
	str r1,[sp,#0xc]	; 0232EBAC
	sub r1,r4,r1	; 0232EBAE
	lsl r2,r1,#0x8	; 0232EBB0
	ldr r1,[pool_0232ECC0]	; 0232EBB2
	str r2,[r1,#0x0]	; 0232EBB4
	add r1,sp,#0x28	; 0232EBB6
	ldrh r1,[r1,#0x1c]	; 0232EBB8
	str r1,[sp,#0x8]	; 0232EBBA
	sub r1,r6,r1	; 0232EBBC
	ldr r2,[pool_0232ECC4]	; 0232EBBE
	str r1,[r2,#0x0]	; 0232EBC0
	str r3,[r2,#0x4]	; 0232EBC2
	add r1,sp,#0x28	; 0232EBC4
	ldrh r1,[r1,#0x18]	; 0232EBC6
	str r1,[sp,#0x18]	; 0232EBC8
	sub r3,r7,r1	; 0232EBCA
	add r1,sp,#0x28	; 0232EBCC
	ldrh r1,[r1,#0x20]	; 0232EBCE
	str r1,[sp,#0x10]	; 0232EBD0
	add r1,sp,#0x28	; 0232EBD2
	ldrh r2,[r1,#0x10]	; 0232EBD4
	str r2,[sp,#0x14]	; 0232EBD6
	ldr r1,[sp,#0x10]	; 0232EBD8
	sub r1,r2,r1	; 0232EBDA
	str r1,[sp,#0x0]	; 0232EBDC
	ldr r1,[pool_0232ECC8]	; 0232EBDE
loc_0232EBE0:
	ldrh r2,[r0,#0x0]	; 0232EBE0
	and r2,r1	; 0232EBE2
	cmp r2,#0x0	; 0232EBE4
	bne loc_0232EBE0	; 0232EBE6
	ldr r1,[pool_0232ECCC]	; 0232EBE8
	ldr r2,[r1,#0x0]	; 0232EBEA
	mov r1,#0x0	; 0232EBEC
	strh r1,[r0,#0x0]	; 0232EBEE
	lsl r1,r3,#0x8	; 0232EBF0
	ldr r0,[pool_0232ECC0]	; 0232EBF2
	str r1,[r0,#0x0]	; 0232EBF4
	ldr r0,[pool_0232ECC4]	; 0232EBF6
	ldr r1,[sp,#0x0]	; 0232EBF8
	str r1,[r0,#0x0]	; 0232EBFA
	mov r1,#0x0	; 0232EBFC
	str r1,[r0,#0x4]	; 0232EBFE
	ldr r0,[pool_0232ECC8]	; 0232EC00
	cmp r2,r0	; 0232EC02
	bge loc_0232EC0C	; 0232EC04
	ldr r1,[pool_0232ECD0]	; 0232EC06
	cmp r2,r1	; 0232EC08
	bge loc_0232EC1C	; 0232EC0A
loc_0232EC0C:
	ldr r0,[sp,#0x4]	; 0232EC0C
	blx P1_Arm9RestoreIrqMask	; 0232EC0E
	mov r0,#0x1	; 0232EC12
	add sp,#0x24	; 0232EC14
	pop {r4,r5,r6,r7}	; 0232EC16
	pop {r3}	; 0232EC18
	bx r3	; 0232EC1A
loc_0232EC1C:
	strh r2,[r5,#0x4]	; 0232EC1C
	ldr r1,[sp,#0xc]	; 0232EC1E
	add r1,r4,r1	; 0232EC20
	lsl r2,r1,#0x8	; 0232EC22
	mov r1,#0x4	; 0232EC24
	ldrsh r1,[r5,r1]	; 0232EC26
	ldr r3,[sp,#0x8]	; 0232EC28
	add r3,r6,r3	; 0232EC2A
	mul r1,r3	; 0232EC2C
	sub r1,r2,r1	; 0232EC2E
	lsl r1,r1,#0x9	; 0232EC30
	asr r2,r1,#0x10	; 0232EC32
	cmp r2,r0	; 0232EC34
	bge loc_0232EC3E	; 0232EC36
	ldr r1,[pool_0232ECD0]	; 0232EC38
	cmp r2,r1	; 0232EC3A
	bge loc_0232EC4E	; 0232EC3C
loc_0232EC3E:
	ldr r0,[sp,#0x4]	; 0232EC3E
	blx P1_Arm9RestoreIrqMask	; 0232EC40
	mov r0,#0x1	; 0232EC44
	add sp,#0x24	; 0232EC46
	pop {r4,r5,r6,r7}	; 0232EC48
	pop {r3}	; 0232EC4A
	bx r3	; 0232EC4C
loc_0232EC4E:
	strh r2,[r5,#0x0]	; 0232EC4E
	ldr r1,[pool_0232ECBC]	; 0232EC50
loc_0232EC52:
	ldrh r2,[r1,#0x0]	; 0232EC52
	and r2,r0	; 0232EC54
	cmp r2,#0x0	; 0232EC56
	bne loc_0232EC52	; 0232EC58
	ldr r0,[pool_0232ECCC]	; 0232EC5A
	ldr r4,[r0,#0x0]	; 0232EC5C
	ldr r0,[sp,#0x4]	; 0232EC5E
	blx P1_Arm9RestoreIrqMask	; 0232EC60
	ldr r1,[pool_0232ECC8]	; 0232EC64
	cmp r4,r1	; 0232EC66
	bge loc_0232EC70	; 0232EC68
	ldr r0,[pool_0232ECD0]	; 0232EC6A
	cmp r4,r0	; 0232EC6C
	bge loc_0232EC7A	; 0232EC6E
loc_0232EC70:
	mov r0,#0x1	; 0232EC70
	add sp,#0x24	; 0232EC72
	pop {r4,r5,r6,r7}	; 0232EC74
	pop {r3}	; 0232EC76
	bx r3	; 0232EC78
loc_0232EC7A:
	strh r4,[r5,#0x6]	; 0232EC7A
	ldr r2,[sp,#0x18]	; 0232EC7C
	add r2,r7,r2	; 0232EC7E
	lsl r3,r2,#0x8	; 0232EC80
	mov r2,#0x6	; 0232EC82
	ldrsh r2,[r5,r2]	; 0232EC84
	ldr r6,[sp,#0x14]	; 0232EC86
	ldr r4,[sp,#0x10]	; 0232EC88
	add r4,r6,r4	; 0232EC8A
	mul r2,r4	; 0232EC8C
	sub r2,r3,r2	; 0232EC8E
	lsl r2,r2,#0x9	; 0232EC90
	asr r2,r2,#0x10	; 0232EC92
	cmp r2,r1	; 0232EC94
	bge loc_0232EC9C	; 0232EC96
	cmp r2,r0	; 0232EC98
	bge loc_0232ECA6	; 0232EC9A
loc_0232EC9C:
	mov r0,#0x1	; 0232EC9C
	add sp,#0x24	; 0232EC9E
	pop {r4,r5,r6,r7}	; 0232ECA0
	pop {r3}	; 0232ECA2
	bx r3	; 0232ECA4
loc_0232ECA6:
	strh r2,[r5,#0x2]	; 0232ECA6
	mov r0,#0x0	; 0232ECA8
	add sp,#0x24	; 0232ECAA
	pop {r4,r5,r6,r7}	; 0232ECAC
	pop {r3}	; 0232ECAE
	bx r3	; 0232ECB0
	.byte 0xC0, 0x46	; 0232ECB4
pool_0232ECB4:
loc_0232ECB4:
	.word 0x00001000	; 0232ECB4
pool_0232ECB8:
loc_0232ECB8:
	.word 0x00000100	; 0232ECB8
pool_0232ECBC:
loc_0232ECBC:
	.word REG_DIVCNT	; 0232ECBC
pool_0232ECC0:
loc_0232ECC0:
	.word REG_DIV_NUMER	; 0232ECC0
pool_0232ECC4:
loc_0232ECC4:
	.word REG_DIV_DENOM	; 0232ECC4
pool_0232ECC8:
loc_0232ECC8:
	.word 0x00008000	; 0232ECC8
pool_0232ECCC:
loc_0232ECCC:
	.word REG_DIV_RESULT	; 0232ECCC
pool_0232ECD0:
loc_0232ECD0:
	.word 0xFFFF8000	; 0232ECD0

; ===== function loc_0232ECD4 =====
loc_0232ECD4:
	push {r4,lr}	; 0232ECD4
	add r4,r0,#0x0	; 0232ECD6
	mov r0,#0x1	; 0232ECD8
	bl loc_0232EA50	; 0232ECDA
	ldr r1,[pool_0232ED04]	; 0232ECDE
	ldrh r2,[r1,#0x34]	; 0232ECE0
	mov r0,#0x1	; 0232ECE2
	and r2,r0	; 0232ECE4
	cmp r2,#0x0	; 0232ECE6
	bne loc_0232ECFC	; 0232ECE8
	ldrh r0,[r1,#0x4]	; 0232ECEA
	strh r0,[r4,#0x0]	; 0232ECEC
	ldrh r0,[r1,#0x6]	; 0232ECEE
	strh r0,[r4,#0x2]	; 0232ECF0
	ldrh r0,[r1,#0x8]	; 0232ECF2
	strh r0,[r4,#0x4]	; 0232ECF4
	ldrh r0,[r1,#0xa]	; 0232ECF6
	strh r0,[r4,#0x6]	; 0232ECF8
	mov r0,#0x0	; 0232ECFA
loc_0232ECFC:
	pop {r4}	; 0232ECFC
	pop {r3}	; 0232ECFE
	bx r3	; 0232ED00
	.byte 0xC0, 0x46	; 0232ED04
pool_0232ED04:
loc_0232ED04:
	.word P1_BssStart + 0x2828C	; 0232ED04

; ===== function loc_0232ED08 =====
loc_0232ED08:
	push {r4,lr}	; 0232ED08
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232ED0A
	add r4,r0,#0x0	; 0232ED0E
	mov r0,#0x6	; 0232ED10
	ldr r1,[pool_0232ED68]	; 0232ED12
	mov r2,#0x0	; 0232ED14
	bl loc_0232E808	; 0232ED16
	cmp r0,#0x0	; 0232ED1A
	blt loc_0232ED22	; 0232ED1C
	mov r0,#0x1	; 0232ED1E
	b loc_0232ED24	; 0232ED20
loc_0232ED22:
	mov r0,#0x0	; 0232ED22
loc_0232ED24:
	cmp r0,#0x0	; 0232ED24
	bne loc_0232ED4C	; 0232ED26
	add r0,r4,#0x0	; 0232ED28
	blx P1_Arm9RestoreIrqMask	; 0232ED2A
	ldr r1,[pool_0232ED6C]	; 0232ED2E
	ldrh r2,[r1,#0x34]	; 0232ED30
	mov r0,#0x1	; 0232ED32
	orr r2,r0	; 0232ED34
	strh r2,[r1,#0x34]	; 0232ED36
	ldr r3,[r1,#0x0]	; 0232ED38
	cmp r3,#0x0	; 0232ED3A
	beq loc_0232ED62	; 0232ED3C
	mov r0,#0x0	; 0232ED3E
	mov r1,#0x4	; 0232ED40
	add r2,r0,#0x0	; 0232ED42
	blx r3	; 0232ED44
	pop {r4}	; 0232ED46
	pop {r3}	; 0232ED48
	bx r3	; 0232ED4A
loc_0232ED4C:
	ldr r1,[pool_0232ED6C]	; 0232ED4C
	ldrh r2,[r1,#0x36]	; 0232ED4E
	mov r0,#0x1	; 0232ED50
	orr r2,r0	; 0232ED52
	strh r2,[r1,#0x36]	; 0232ED54
	ldrh r2,[r1,#0x34]	; 0232ED56
	bic r2,r0	; 0232ED58
	strh r2,[r1,#0x34]	; 0232ED5A
	add r0,r4,#0x0	; 0232ED5C
	blx P1_Arm9RestoreIrqMask	; 0232ED5E
loc_0232ED62:
	pop {r4}	; 0232ED62
	pop {r3}	; 0232ED64
	bx r3	; 0232ED66
pool_0232ED68:
loc_0232ED68:
	.word 0x03000000	; 0232ED68
pool_0232ED6C:
loc_0232ED6C:
	.word P1_BssStart + 0x2828C	; 0232ED6C

; ===== function loc_0232ED70 =====
loc_0232ED70:
	push {r4,r5,r6,r7,lr}	; 0232ED70
	sub sp,#0x4	; 0232ED72
	add r4,r0,#0x0	; 0232ED74
	cmp r4,#0x0	; 0232ED76
	bne loc_0232ED88	; 0232ED78
	mov r1,#0x0	; 0232ED7A
	ldr r0,[pool_0232EE08]	; 0232ED7C
	strh r1,[r0,#0x30]	; 0232ED7E
	add sp,#0x4	; 0232ED80
	pop {r4,r5,r6,r7}	; 0232ED82
	pop {r3}	; 0232ED84
	bx r3	; 0232ED86
loc_0232ED88:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232ED88
	add r6,r0,#0x0	; 0232ED8C
	mov r7,#0x4	; 0232ED8E
	ldrsh r5,[r4,r7]	; 0232ED90
	mov r3,#0x0	; 0232ED92
	ldr r2,[pool_0232EE0C]	; 0232ED94
	strh r3,[r2,#0x0]	; 0232ED96
	ldr r1,[pool_0232EE10]	; 0232ED98
	ldr r0,[pool_0232EE14]	; 0232ED9A
	str r1,[r0,#0x0]	; 0232ED9C
	ldr r0,[pool_0232EE18]	; 0232ED9E
	str r5,[r0,#0x0]	; 0232EDA0
	str r3,[r0,#0x4]	; 0232EDA2
	ldrsh r1,[r4,r3]	; 0232EDA4
	ldr r0,[pool_0232EE08]	; 0232EDA6
	str r1,[r0,#0x18]	; 0232EDA8
	ldrsh r1,[r4,r7]	; 0232EDAA
	str r1,[r0,#0x1c]	; 0232EDAC
	ldr r0,[pool_0232EE1C]	; 0232EDAE
loc_0232EDB0:
	ldrh r1,[r2,#0x0]	; 0232EDB0
	and r1,r0	; 0232EDB2
	cmp r1,#0x0	; 0232EDB4
	bne loc_0232EDB0	; 0232EDB6
	ldr r0,[pool_0232EE20]	; 0232EDB8
	ldr r0,[r0,#0x0]	; 0232EDBA
	ldr r3,[pool_0232EE08]	; 0232EDBC
	str r0,[r3,#0x20]	; 0232EDBE
	mov r7,#0x6	; 0232EDC0
	ldrsh r1,[r4,r7]	; 0232EDC2
	mov r0,#0x0	; 0232EDC4
	strh r0,[r2,#0x0]	; 0232EDC6
	ldr r5,[pool_0232EE10]	; 0232EDC8
	ldr r2,[pool_0232EE14]	; 0232EDCA
	str r5,[r2,#0x0]	; 0232EDCC
	ldr r2,[pool_0232EE18]	; 0232EDCE
	str r1,[r2,#0x0]	; 0232EDD0
	str r0,[r2,#0x4]	; 0232EDD2
	mov r0,#0x2	; 0232EDD4
	ldrsh r0,[r4,r0]	; 0232EDD6
	str r0,[r3,#0x24]	; 0232EDD8
	ldrsh r0,[r4,r7]	; 0232EDDA
	str r0,[r3,#0x28]	; 0232EDDC
	ldr r1,[pool_0232EE0C]	; 0232EDDE
	ldr r0,[pool_0232EE1C]	; 0232EDE0
loc_0232EDE2:
	ldrh r2,[r1,#0x0]	; 0232EDE2
	and r2,r0	; 0232EDE4
	cmp r2,#0x0	; 0232EDE6
	bne loc_0232EDE2	; 0232EDE8
	ldr r0,[pool_0232EE20]	; 0232EDEA
	ldr r1,[r0,#0x0]	; 0232EDEC
	ldr r0,[pool_0232EE08]	; 0232EDEE
	str r1,[r0,#0x2c]	; 0232EDF0
	add r0,r6,#0x0	; 0232EDF2
	blx P1_Arm9RestoreIrqMask	; 0232EDF4
	mov r1,#0x1	; 0232EDF8
	ldr r0,[pool_0232EE08]	; 0232EDFA
	strh r1,[r0,#0x30]	; 0232EDFC
	add sp,#0x4	; 0232EDFE
	pop {r4,r5,r6,r7}	; 0232EE00
	pop {r3}	; 0232EE02
	bx r3	; 0232EE04
	.byte 0xC0, 0x46	; 0232EE08
pool_0232EE08:
loc_0232EE08:
	.word P1_BssStart + 0x2828C	; 0232EE08
pool_0232EE0C:
loc_0232EE0C:
	.word REG_DIVCNT	; 0232EE0C
pool_0232EE10:
loc_0232EE10:
	.word 0x10000000	; 0232EE10
pool_0232EE14:
loc_0232EE14:
	.word REG_DIV_NUMER	; 0232EE14
pool_0232EE18:
loc_0232EE18:
	.word REG_DIV_DENOM	; 0232EE18
pool_0232EE1C:
loc_0232EE1C:
	.word 0x00008000	; 0232EE1C
pool_0232EE20:
loc_0232EE20:
	.word REG_DIV_RESULT	; 0232EE20

; ===== function loc_0232EE24 =====
loc_0232EE24:
	push {r4,r5,lr}	; 0232EE24
	sub sp,#0x4	; 0232EE26
	ldr r0,[pool_0232EE6C]	; 0232EE28
	ldrh r1,[r0,#0x0]	; 0232EE2A
	cmp r1,#0x0	; 0232EE2C
	bne loc_0232EE62	; 0232EE2E
	mov r1,#0x1	; 0232EE30
	strh r1,[r0,#0x0]	; 0232EE32
	bl loc_0232E728	; 0232EE34
	mov r1,#0x0	; 0232EE38
	ldr r0,[pool_0232EE70]	; 0232EE3A
	strh r1,[r0,#0xc]	; 0232EE3C
	str r1,[r0,#0x0]	; 0232EE3E
	str r1,[r0,#0x10]	; 0232EE40
	strh r1,[r0,#0x32]	; 0232EE42
	strh r1,[r0,#0x30]	; 0232EE44
	strh r1,[r0,#0x36]	; 0232EE46
	strh r1,[r0,#0x34]	; 0232EE48
	mov r5,#0x6	; 0232EE4A
	mov r4,#0x1	; 0232EE4C
loc_0232EE4E:
	add r0,r5,#0x0	; 0232EE4E
	add r1,r4,#0x0	; 0232EE50
	bl loc_0232E89C	; 0232EE52
	cmp r0,#0x0	; 0232EE56
	beq loc_0232EE4E	; 0232EE58
	mov r0,#0x6	; 0232EE5A
	ldr r1,[pool_0232EE74]	; 0232EE5C
	bl P1_SetPxiReceiveCallback	; 0232EE5E
loc_0232EE62:
	add sp,#0x4	; 0232EE62
	pop {r4,r5}	; 0232EE64
	pop {r3}	; 0232EE66
	bx r3	; 0232EE68
	.byte 0xC0, 0x46	; 0232EE6C
pool_0232EE6C:
loc_0232EE6C:
	.word P1_BssStart + 0x28288	; 0232EE6C
pool_0232EE70:
loc_0232EE70:
	.word P1_BssStart + 0x2828C	; 0232EE70
pool_0232EE74:
loc_0232EE74:
	.word P1_PxiCallback_0232EE78 + 1	; 0232EE74

; ===== function loc_0232EE78 =====
P1_PxiCallback_0232EE78:
	push {r4,lr}	; 0232EE78
	sub sp,#0x8	; 0232EE7A
	lsl r0,r1,#0x10	; 0232EE7C
	lsr r3,r0,#0x10	; 0232EE7E
	ldr r0,[pool_0232EF6C]	; 0232EE80
	add r4,r3,#0x0	; 0232EE82
	and r4,r0	; 0232EE84
	lsl r0,r4,#0x8	; 0232EE86
	lsr r0,r0,#0x10	; 0232EE88
	cmp r2,#0x0	; 0232EE8A
	beq loc_0232EEAE	; 0232EE8C
	ldr r1,[pool_0232EF70]	; 0232EE8E
	ldrh r3,[r1,#0x34]	; 0232EE90
	mov r2,#0x1	; 0232EE92
	lsl r2,r0	; 0232EE94
	orr r3,r2	; 0232EE96
	strh r3,[r1,#0x34]	; 0232EE98
	ldr r3,[r1,#0x0]	; 0232EE9A
	cmp r3,#0x0	; 0232EE9C
	beq loc_0232EF64	; 0232EE9E
	mov r1,#0x4	; 0232EEA0
	mov r2,#0x0	; 0232EEA2
	blx r3	; 0232EEA4
	add sp,#0x8	; 0232EEA6
	pop {r4}	; 0232EEA8
	pop {r3}	; 0232EEAA
	bx r3	; 0232EEAC
loc_0232EEAE:
	ldr r2,[pool_0232EF74]	; 0232EEAE
	and r1,r2	; 0232EEB0
	cmp r1,#0x0	; 0232EEB2
	beq loc_0232EF64	; 0232EEB4
	lsl r1,r3,#0x18	; 0232EEB6
	lsr r1,r1,#0x18	; 0232EEB8
	cmp r1,#0x4	; 0232EEBA
	bhi loc_0232EF60	; 0232EEBC
	add r1,r1,r1	; 0232EEBE
P1_SwitchIndexPC_0232EEBE:
	add r1,pc	; 0232EEC0
	ldrh r1,[r1,#(P1_SwitchTable_0232EEBE - (P1_SwitchIndexPC_0232EEBE + 4))]	; 0232EEC2
	lsl r1,r1,#0x10	; 0232EEC4
	asr r1,r1,#0x10	; 0232EEC6
P1_SwitchTargetPC_0232EEBE:
	add r1,pc	; 0232EEC8
	bx r1	; 0232EECA
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232EEBE:
	.halfword (loc_0232EED6 + 1) - (P1_SwitchTargetPC_0232EEBE + 4)
	.halfword (loc_0232EF60 + 1) - (P1_SwitchTargetPC_0232EEBE + 4)
	.halfword (loc_0232EF32 + 1) - (P1_SwitchTargetPC_0232EEBE + 4)
	.halfword (loc_0232EF36 + 1) - (P1_SwitchTargetPC_0232EEBE + 4)
	.halfword (loc_0232EF2E + 1) - (P1_SwitchTargetPC_0232EEBE + 4)
P1_SwitchTable_0232EEBEEnd:
loc_0232EED6:
	cmp r0,#0x0	; 0232EED6
	bne loc_0232EF0C	; 0232EED8
	ldr r1,[pool_0232EF78]	; 0232EEDA
	ldrh r2,[r1,#0x0]	; 0232EEDC
	add r1,sp,#0x0	; 0232EEDE
	strh r2,[r1,#0x0]	; 0232EEE0
	ldr r2,[pool_0232EF7C]	; 0232EEE2
	ldrh r2,[r2,#0x0]	; 0232EEE4
	strh r2,[r1,#0x2]	; 0232EEE6
	ldr r1,[sp,#0x0]	; 0232EEE8
	lsl r2,r1,#0x14	; 0232EEEA
	lsr r2,r2,#0x14	; 0232EEEC
	ldr r3,[pool_0232EF70]	; 0232EEEE
	strh r2,[r3,#0x4]	; 0232EEF0
	lsl r2,r1,#0x8	; 0232EEF2
	lsr r2,r2,#0x14	; 0232EEF4
	strh r2,[r3,#0x6]	; 0232EEF6
	lsl r2,r1,#0x7	; 0232EEF8
	lsr r2,r2,#0x1f	; 0232EEFA
	lsl r2,r2,#0x18	; 0232EEFC
	lsr r2,r2,#0x18	; 0232EEFE
	strh r2,[r3,#0x8]	; 0232EF00
	lsl r1,r1,#0x5	; 0232EF02
	lsr r1,r1,#0x1e	; 0232EF04
	lsl r1,r1,#0x18	; 0232EF06
	lsr r1,r1,#0x18	; 0232EF08
	strh r1,[r3,#0xa]	; 0232EF0A
loc_0232EF0C:
	mov r1,#0x0	; 0232EF0C
	ldr r2,[pool_0232EF70]	; 0232EF0E
	strh r1,[r2,#0x32]	; 0232EF10
	ldrh r4,[r2,#0x36]	; 0232EF12
	mov r3,#0x1	; 0232EF14
	lsl r3,r0	; 0232EF16
	bic r4,r3	; 0232EF18
	strh r4,[r2,#0x36]	; 0232EF1A
	ldr r3,[r2,#0x0]	; 0232EF1C
	cmp r3,#0x0	; 0232EF1E
	beq loc_0232EF64	; 0232EF20
	add r2,r1,#0x0	; 0232EF22
	blx r3	; 0232EF24
	add sp,#0x8	; 0232EF26
	pop {r4}	; 0232EF28
	pop {r3}	; 0232EF2A
	bx r3	; 0232EF2C
loc_0232EF2E:
	mov r1,#0x3	; 0232EF2E
	b loc_0232EF38	; 0232EF30
loc_0232EF32:
	mov r1,#0x1	; 0232EF32
	b loc_0232EF38	; 0232EF34
loc_0232EF36:
	mov r1,#0x2	; 0232EF36
loc_0232EF38:
	mov r4,#0x1	; 0232EF38
	lsl r4,r0	; 0232EF3A
	ldr r2,[pool_0232EF70]	; 0232EF3C
	ldrh r3,[r2,#0x34]	; 0232EF3E
	orr r3,r4	; 0232EF40
	strh r3,[r2,#0x34]	; 0232EF42
	ldrh r3,[r2,#0x36]	; 0232EF44
	bic r3,r4	; 0232EF46
	strh r3,[r2,#0x36]	; 0232EF48
	ldr r3,[r2,#0x0]	; 0232EF4A
	cmp r3,#0x0	; 0232EF4C
	beq loc_0232EF64	; 0232EF4E
	mov r2,#0xff	; 0232EF50
	and r1,r2	; 0232EF52
	mov r2,#0x0	; 0232EF54
	blx r3	; 0232EF56
	add sp,#0x8	; 0232EF58
	pop {r4}	; 0232EF5A
	pop {r3}	; 0232EF5C
	bx r3	; 0232EF5E
loc_0232EF60:
	bl loc_0232C47C	; 0232EF60
loc_0232EF64:
	add sp,#0x8	; 0232EF64
	pop {r4}	; 0232EF66
	pop {r3}	; 0232EF68
	bx r3	; 0232EF6A
pool_0232EF6C:
loc_0232EF6C:
	.word 0x00007F00	; 0232EF6C
pool_0232EF70:
loc_0232EF70:
	.word P1_BssStart + 0x2828C	; 0232EF70
pool_0232EF74:
loc_0232EF74:
	.word 0x01000000	; 0232EF74
pool_0232EF78:
loc_0232EF78:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 0232EF78
pool_0232EF7C:
loc_0232EF7C:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 0232EF7C

; ===== function loc_0232EF80 =====
loc_0232EF80:
	push {r4,lr}	; 0232EF80
	cmp r0,#0x0	; 0232EF82
	beq loc_0232EFC6	; 0232EF84
	cmp r0,#0x1	; 0232EF86
	bne loc_0232EFEE	; 0232EF88
	cmp r2,#0x0	; 0232EF8A
	bne loc_0232EFA4	; 0232EF8C
	ldr r0,[pool_0232EFF8]	; 0232EF8E
	ldr r2,[r0,#0x0]	; 0232EF90
	ldr r0,[pool_0232EFFC]	; 0232EF92
	ldr r0,[r0,#0x0]	; 0232EF94
	sub r0,r2,r0	; 0232EF96
	cmp r0,#0x7	; 0232EF98
	bhi loc_0232EFA4	; 0232EF9A
	mov r0,#0x0	; 0232EF9C
	pop {r4}	; 0232EF9E
	pop {r3}	; 0232EFA0
	bx r3	; 0232EFA2
loc_0232EFA4:
	cmp r3,#0x0	; 0232EFA4
	beq loc_0232EFB0	; 0232EFA6
	add r0,r1,#0x0	; 0232EFA8
	bl loc_0232F1B8	; 0232EFAA
	b loc_0232EFBA	; 0232EFAE
loc_0232EFB0:
	add r0,r1,#0x0	; 0232EFB0
	mov r1,#0x0	; 0232EFB2
	add r2,r1,#0x0	; 0232EFB4
	bl loc_0232F1D8	; 0232EFB6
loc_0232EFBA:
	ldr r2,[pool_0232F000]	; 0232EFBA
	ldrh r1,[r2,#0x0]	; 0232EFBC
	mov r0,#0x1	; 0232EFBE
	orr r1,r0	; 0232EFC0
	strh r1,[r2,#0x0]	; 0232EFC2
	b loc_0232EFEE	; 0232EFC4
loc_0232EFC6:
	ldr r4,[pool_0232F000]	; 0232EFC6
	ldrh r2,[r4,#0x0]	; 0232EFC8
	mov r0,#0x1	; 0232EFCA
	bic r2,r0	; 0232EFCC
	strh r2,[r4,#0x0]	; 0232EFCE
	ldr r0,[pool_0232EFF8]	; 0232EFD0
	ldr r2,[r0,#0x0]	; 0232EFD2
	ldr r0,[pool_0232EFFC]	; 0232EFD4
	str r2,[r0,#0x0]	; 0232EFD6
	cmp r3,#0x0	; 0232EFD8
	beq loc_0232EFE4	; 0232EFDA
	add r0,r1,#0x0	; 0232EFDC
	bl loc_0232F1B8	; 0232EFDE
	b loc_0232EFEE	; 0232EFE2
loc_0232EFE4:
	add r0,r1,#0x0	; 0232EFE4
	mov r1,#0x0	; 0232EFE6
	add r2,r1,#0x0	; 0232EFE8
	bl loc_0232F1D8	; 0232EFEA
loc_0232EFEE:
	mov r0,#0x1	; 0232EFEE
	pop {r4}	; 0232EFF0
	pop {r3}	; 0232EFF2
	bx r3	; 0232EFF4
	.byte 0xC0, 0x46	; 0232EFF8
pool_0232EFF8:
loc_0232EFF8:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232EFF8
pool_0232EFFC:
loc_0232EFFC:
	.word P1_BssStart + 0x282D0	; 0232EFFC
pool_0232F000:
loc_0232F000:
	.word REG_POWERCNT	; 0232F000

; ===== function loc_0232F004 =====
loc_0232F004:
	push {r4,r5,r6,r7,lr}	; 0232F004
	sub sp,#0xc	; 0232F006
	add r5,r0,#0x0	; 0232F008
	add r4,r1,#0x0	; 0232F00A
	str r2,[sp,#0x0]	; 0232F00C
	mov r6,#0x0	; 0232F00E
	ldr r0,[pool_0232F0B8]	; 0232F010
	ldrh r7,[r0,#0x0]	; 0232F012
	strh r6,[r0,#0x0]	; 0232F014
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F016
	str r0,[sp,#0x4]	; 0232F01A
	ldr r0,[pool_0232F0BC]	; 0232F01C
	bl loc_0232B088	; 0232F01E
	str r0,[sp,#0x8]	; 0232F022
	ldr r0,[pool_0232F0C0]	; 0232F024
	bl loc_0232B0D8	; 0232F026
	ldr r0,[sp,#0x4]	; 0232F02A
	blx P1_Arm9RestoreIrqMask	; 0232F02C
	ldr r1,[pool_0232F0B8]	; 0232F030
	ldrh r0,[r1,#0x0]	; 0232F032
	mov r0,#0x1	; 0232F034
	strh r0,[r1,#0x0]	; 0232F036
	mov r0,#0x10	; 0232F038
	add r1,r5,#0x0	; 0232F03A
	and r1,r0	; 0232F03C
	cmp r1,#0x0	; 0232F03E
	beq loc_0232F04E	; 0232F040
	bl loc_0232C564	; 0232F042
	cmp r0,#0x0	; 0232F046
	bne loc_0232F04E	; 0232F048
	mov r0,#0x10	; 0232F04A
	bic r5,r0	; 0232F04C
loc_0232F04E:
	ldr r0,[sp,#0x0]	; 0232F04E
	orr r4,r0	; 0232F050
loc_0232F052:
	lsl r0,r5,#0x10	; 0232F052
	lsr r0,r0,#0x10	; 0232F054
	lsl r1,r4,#0x10	; 0232F056
	lsr r1,r1,#0x10	; 0232F058
	bl loc_0232F2E0	; 0232F05A
	cmp r0,#0x0	; 0232F05E
	bne loc_0232F052	; 0232F060
	blx P1_Arm9WaitForInterrupt	; 0232F062
	ldr r0,[pool_0232F0C4]	; 0232F066
	blx P1_Arm9BusyWaitByLoop4	; 0232F068
	mov r0,#0x8	; 0232F06C
	and r5,r0	; 0232F06E
	cmp r5,#0x0	; 0232F070
	beq loc_0232F082	; 0232F072
	ldr r0,[pool_0232F0C8]	; 0232F074
	ldr r1,[r0,#0x0]	; 0232F076
	ldr r0,[pool_0232F0CC]	; 0232F078
	and r1,r0	; 0232F07A
	cmp r1,#0x0	; 0232F07C
	beq loc_0232F082	; 0232F07E
	mov r6,#0x1	; 0232F080
loc_0232F082:
	cmp r6,#0x0	; 0232F082
	bne loc_0232F092	; 0232F084
	mov r0,#0x1	; 0232F086
	add r1,r0,#0x0	; 0232F088
	add r2,r0,#0x0	; 0232F08A
	mov r3,#0x0	; 0232F08C
	bl loc_0232EF80	; 0232F08E
loc_0232F092:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F092
	ldr r0,[sp,#0x8]	; 0232F096
	bl loc_0232B0D8	; 0232F098
	ldr r0,[sp,#0x4]	; 0232F09C
	blx P1_Arm9RestoreIrqMask	; 0232F09E
	ldr r1,[pool_0232F0B8]	; 0232F0A2
	ldrh r0,[r1,#0x0]	; 0232F0A4
	strh r7,[r1,#0x0]	; 0232F0A6
	cmp r6,#0x0	; 0232F0A8
	beq loc_0232F0B0	; 0232F0AA
	bl loc_0232F110	; 0232F0AC
loc_0232F0B0:
	add sp,#0xc	; 0232F0B0
	pop {r4,r5,r6,r7}	; 0232F0B2
	pop {r3}	; 0232F0B4
	bx r3	; 0232F0B6
pool_0232F0B8:
loc_0232F0B8:
	.word REG_IME	; 0232F0B8
pool_0232F0BC:
loc_0232F0BC:
	.word 0x003FFFFF	; 0232F0BC
pool_0232F0C0:
loc_0232F0C0:
	.word 0x00040000	; 0232F0C0
pool_0232F0C4:
loc_0232F0C4:
	.word 0x00332340	; 0232F0C4
pool_0232F0C8:
loc_0232F0C8:
	.word REG_IF	; 0232F0C8
pool_0232F0CC:
loc_0232F0CC:
	.word 0x00100000	; 0232F0CC

; ===== function loc_0232F0D0 =====
loc_0232F0D0:
	push {r4,r5,r6,lr}	; 0232F0D0
	add r5,r0,#0x0	; 0232F0D2
	mov r4,#0x8	; 0232F0D4
	mov r6,#0x0	; 0232F0D6
loc_0232F0D8:
	add r0,r4,#0x0	; 0232F0D8
	add r1,r5,#0x0	; 0232F0DA
	add r2,r6,#0x0	; 0232F0DC
	bl loc_0232E808	; 0232F0DE
	cmp r0,#0x0	; 0232F0E2
	bne loc_0232F0D8	; 0232F0E4
	pop {r4,r5,r6}	; 0232F0E6
	pop {r3}	; 0232F0E8
	bx r3	; 0232F0EA

; ===== function loc_0232F0EC =====
loc_0232F0EC:
	push {r4,lr}	; 0232F0EC
	sub sp,#0x8	; 0232F0EE
	add r4,r0,#0x0	; 0232F0F0
	mov r0,#0x1	; 0232F0F2
	add r1,sp,#0x0	; 0232F0F4
	bl loc_0232F214	; 0232F0F6
	cmp r0,#0x0	; 0232F0FA
	bne loc_0232F108	; 0232F0FC
	cmp r4,#0x0	; 0232F0FE
	beq loc_0232F108	; 0232F100
	add r1,sp,#0x0	; 0232F102
	ldrh r1,[r1,#0x0]	; 0232F104
	str r1,[r4,#0x0]	; 0232F106
loc_0232F108:
	add sp,#0x8	; 0232F108
	pop {r4}	; 0232F10A
	pop {r3}	; 0232F10C
	bx r3	; 0232F10E

; ===== function loc_0232F110 =====
loc_0232F110:
	push {lr}	; 0232F110
	sub sp,#0x4	; 0232F112
	ldr r0,[pool_0232F12C]	; 0232F114
	add r1,sp,#0x0	; 0232F116
	bl loc_0232F130	; 0232F118
	cmp r0,#0x0	; 0232F11C
	bne loc_0232F126	; 0232F11E
	bl loc_0232F49C	; 0232F120
	ldr r0,[sp,#0x0]	; 0232F124
loc_0232F126:
	add sp,#0x4	; 0232F126
	pop {r3}	; 0232F128
	bx r3	; 0232F12A
pool_0232F12C:
loc_0232F12C:
	.word 0x0232F499	; 0232F12C

; ===== function loc_0232F130 =====
loc_0232F130:
	add r3,r0,#0x0	; 0232F130
	add r2,r1,#0x0	; 0232F132
	mov r0,#0xe	; 0232F134
	add r1,r3,#0x0	; 0232F136
	ldr r3,[pool_0232F13C]	; 0232F138
	bx r3	; 0232F13A
pool_0232F13C:
loc_0232F13C:
	.word loc_0232F28C + 1	; 0232F13C

; ===== function loc_0232F140 =====
loc_0232F140:
	push {lr}	; 0232F140
	sub sp,#0x4	; 0232F142
	ldr r2,[pool_0232F15C]	; 0232F144
	add r3,sp,#0x0	; 0232F146
	bl loc_0232F160	; 0232F148
	cmp r0,#0x0	; 0232F14C
	bne loc_0232F156	; 0232F14E
	bl loc_0232F49C	; 0232F150
	ldr r0,[sp,#0x0]	; 0232F154
loc_0232F156:
	add sp,#0x4	; 0232F156
	pop {r3}	; 0232F158
	bx r3	; 0232F15A
pool_0232F15C:
loc_0232F15C:
	.word 0x0232F499	; 0232F15C

; ===== function loc_0232F160 =====
loc_0232F160:
	push {r4,lr}	; 0232F160
	mov r4,#0x0	; 0232F162
	cmp r0,#0x0	; 0232F164
	bne loc_0232F176	; 0232F166
	cmp r1,#0x1	; 0232F168
	bne loc_0232F16E	; 0232F16A
	mov r4,#0x6	; 0232F16C
loc_0232F16E:
	cmp r1,#0x0	; 0232F16E
	bne loc_0232F198	; 0232F170
	mov r4,#0x7	; 0232F172
	b loc_0232F198	; 0232F174
loc_0232F176:
	cmp r0,#0x1	; 0232F176
	bne loc_0232F188	; 0232F178
	cmp r1,#0x1	; 0232F17A
	bne loc_0232F180	; 0232F17C
	mov r4,#0x4	; 0232F17E
loc_0232F180:
	cmp r1,#0x0	; 0232F180
	bne loc_0232F198	; 0232F182
	mov r4,#0x5	; 0232F184
	b loc_0232F198	; 0232F186
loc_0232F188:
	cmp r0,#0x2	; 0232F188
	bne loc_0232F198	; 0232F18A
	cmp r1,#0x1	; 0232F18C
	bne loc_0232F192	; 0232F18E
	mov r4,#0x8	; 0232F190
loc_0232F192:
	cmp r1,#0x0	; 0232F192
	bne loc_0232F198	; 0232F194
	mov r4,#0x9	; 0232F196
loc_0232F198:
	cmp r4,#0x0	; 0232F198
	beq loc_0232F1AC	; 0232F19A
	add r0,r4,#0x0	; 0232F19C
	add r1,r2,#0x0	; 0232F19E
	add r2,r3,#0x0	; 0232F1A0
	bl loc_0232F28C	; 0232F1A2
	pop {r4}	; 0232F1A6
	pop {r3}	; 0232F1A8
	bx r3	; 0232F1AA
loc_0232F1AC:
	ldr r0,[pool_0232F1B4]	; 0232F1AC
	pop {r4}	; 0232F1AE
	pop {r3}	; 0232F1B0
	bx r3	; 0232F1B2
pool_0232F1B4:
loc_0232F1B4:
	.word 0x0000FFFF	; 0232F1B4

; ===== function loc_0232F1B8 =====
loc_0232F1B8:
	push {lr}	; 0232F1B8
	sub sp,#0x4	; 0232F1BA
	ldr r1,[pool_0232F1D4]	; 0232F1BC
	add r2,sp,#0x0	; 0232F1BE
	bl loc_0232F1D8	; 0232F1C0
	cmp r0,#0x0	; 0232F1C4
	bne loc_0232F1CE	; 0232F1C6
	bl loc_0232F49C	; 0232F1C8
	ldr r0,[sp,#0x0]	; 0232F1CC
loc_0232F1CE:
	add sp,#0x4	; 0232F1CE
	pop {r3}	; 0232F1D0
	bx r3	; 0232F1D2
pool_0232F1D4:
loc_0232F1D4:
	.word 0x0232F499	; 0232F1D4

; ===== function loc_0232F1D8 =====
loc_0232F1D8:
	push {lr}	; 0232F1D8
	sub sp,#0x4	; 0232F1DA
	cmp r0,#0x1	; 0232F1DC
	beq loc_0232F1EA	; 0232F1DE
	cmp r0,#0x2	; 0232F1E0
	beq loc_0232F1F2	; 0232F1E2
	cmp r0,#0x3	; 0232F1E4
	beq loc_0232F1EE	; 0232F1E6
	b loc_0232F1F6	; 0232F1E8
loc_0232F1EA:
	mov r0,#0x1	; 0232F1EA
	b loc_0232F1F8	; 0232F1EC
loc_0232F1EE:
	mov r0,#0x2	; 0232F1EE
	b loc_0232F1F8	; 0232F1F0
loc_0232F1F2:
	mov r0,#0x3	; 0232F1F2
	b loc_0232F1F8	; 0232F1F4
loc_0232F1F6:
	mov r0,#0x0	; 0232F1F6
loc_0232F1F8:
	cmp r0,#0x0	; 0232F1F8
	beq loc_0232F206	; 0232F1FA
	bl loc_0232F28C	; 0232F1FC
	add sp,#0x4	; 0232F200
	pop {r3}	; 0232F202
	bx r3	; 0232F204
loc_0232F206:
	ldr r0,[pool_0232F210]	; 0232F206
	add sp,#0x4	; 0232F208
	pop {r3}	; 0232F20A
	bx r3	; 0232F20C
	.byte 0xC0, 0x46	; 0232F210
pool_0232F210:
loc_0232F210:
	.word 0x0000FFFF	; 0232F210

; ===== function loc_0232F214 =====
loc_0232F214:
	push {lr}	; 0232F214
	sub sp,#0x4	; 0232F216
	ldr r2,[pool_0232F230]	; 0232F218
	add r3,sp,#0x0	; 0232F21A
	bl loc_0232F234	; 0232F21C
	cmp r0,#0x0	; 0232F220
	bne loc_0232F22A	; 0232F222
	bl loc_0232F49C	; 0232F224
	ldr r0,[sp,#0x0]	; 0232F228
loc_0232F22A:
	add sp,#0x4	; 0232F22A
	pop {r3}	; 0232F22C
	bx r3	; 0232F22E
pool_0232F230:
loc_0232F230:
	.word 0x0232F499	; 0232F230

; ===== function loc_0232F234 =====
loc_0232F234:
	push {r4,r5,r6,r7,lr}	; 0232F234
	sub sp,#0x4	; 0232F236
	add r5,r0,#0x0	; 0232F238
	add r4,r1,#0x0	; 0232F23A
	add r6,r2,#0x0	; 0232F23C
	add r7,r3,#0x0	; 0232F23E
	bl loc_0232F4AC	; 0232F240
	cmp r0,#0x0	; 0232F244
	bne loc_0232F252	; 0232F246
	mov r0,#0x1	; 0232F248
	add sp,#0x4	; 0232F24A
	pop {r4,r5,r6,r7}	; 0232F24C
	pop {r3}	; 0232F24E
	bx r3	; 0232F250
loc_0232F252:
	ldr r0,[pool_0232F27C]	; 0232F252
	str r6,[r0,#0x4]	; 0232F254
	str r7,[r0,#0x8]	; 0232F256
	lsl r2,r5,#0x3	; 0232F258
	mov r1,#0x0	; 0232F25A
	ldr r0,[pool_0232F280]	; 0232F25C
	strh r1,[r0,r2]	; 0232F25E
	ldr r0,[pool_0232F284]	; 0232F260
	str r4,[r0,r2]	; 0232F262
	mov r0,#0xff	; 0232F264
	and r5,r0	; 0232F266
	ldr r0,[pool_0232F288]	; 0232F268
	orr r5,r0	; 0232F26A
	add r0,r5,#0x0	; 0232F26C
	bl loc_0232F0D0	; 0232F26E
	mov r0,#0x0	; 0232F272
	add sp,#0x4	; 0232F274
	pop {r4,r5,r6,r7}	; 0232F276
	pop {r3}	; 0232F278
	bx r3	; 0232F27A
pool_0232F27C:
loc_0232F27C:
	.word P1_BssStart + 0x282D4	; 0232F27C
pool_0232F280:
loc_0232F280:
	.word P1_BssStart + 0x282F8	; 0232F280
pool_0232F284:
loc_0232F284:
	.word P1_BssStart + 0x282FC	; 0232F284
pool_0232F288:
loc_0232F288:
	.word 0x03006500	; 0232F288

; ===== function loc_0232F28C =====
loc_0232F28C:
	push {r4,r5,r6,lr}	; 0232F28C
	add r5,r0,#0x0	; 0232F28E
	add r4,r1,#0x0	; 0232F290
	add r6,r2,#0x0	; 0232F292
	bl loc_0232F4AC	; 0232F294
	cmp r0,#0x0	; 0232F298
	bne loc_0232F2A4	; 0232F29A
	mov r0,#0x1	; 0232F29C
	pop {r4,r5,r6}	; 0232F29E
	pop {r3}	; 0232F2A0
	bx r3	; 0232F2A2
loc_0232F2A4:
	ldr r0,[pool_0232F2D0]	; 0232F2A4
	str r4,[r0,#0x4]	; 0232F2A6
	str r6,[r0,#0x8]	; 0232F2A8
	lsr r0,r5,#0x10	; 0232F2AA
	mov r1,#0xff	; 0232F2AC
	and r0,r1	; 0232F2AE
	ldr r1,[pool_0232F2D4]	; 0232F2B0
	orr r0,r1	; 0232F2B2
	bl loc_0232F0D0	; 0232F2B4
	ldr r0,[pool_0232F2D8]	; 0232F2B8
	and r5,r0	; 0232F2BA
	ldr r0,[pool_0232F2DC]	; 0232F2BC
	orr r5,r0	; 0232F2BE
	add r0,r5,#0x0	; 0232F2C0
	bl loc_0232F0D0	; 0232F2C2
	mov r0,#0x0	; 0232F2C6
	pop {r4,r5,r6}	; 0232F2C8
	pop {r3}	; 0232F2CA
	bx r3	; 0232F2CC
	.byte 0xC0, 0x46	; 0232F2D0
pool_0232F2D0:
loc_0232F2D0:
	.word P1_BssStart + 0x282D4	; 0232F2D0
pool_0232F2D4:
loc_0232F2D4:
	.word 0x02006300	; 0232F2D4
pool_0232F2D8:
loc_0232F2D8:
	.word 0x0000FFFF	; 0232F2D8
pool_0232F2DC:
loc_0232F2DC:
	.word 0x01010000	; 0232F2DC

; ===== function loc_0232F2E0 =====
loc_0232F2E0:
	push {r4,r5,lr}	; 0232F2E0
	sub sp,#0x4	; 0232F2E2
	add r5,r0,#0x0	; 0232F2E4
	add r4,r1,#0x0	; 0232F2E6
	bl loc_0232F4AC	; 0232F2E8
	cmp r0,#0x0	; 0232F2EC
	bne loc_0232F2FA	; 0232F2EE
	mov r0,#0x1	; 0232F2F0
	add sp,#0x4	; 0232F2F2
	pop {r4,r5}	; 0232F2F4
	pop {r3}	; 0232F2F6
	bx r3	; 0232F2F8
loc_0232F2FA:
	mov r1,#0x0	; 0232F2FA
	ldr r0,[pool_0232F348]	; 0232F2FC
	str r1,[r0,#0x0]	; 0232F2FE
	ldr r0,[pool_0232F34C]	; 0232F300
	bl loc_0232F0D0	; 0232F302
	ldr r1,[pool_0232F348]	; 0232F306
loc_0232F308:
	ldr r0,[r1,#0x0]	; 0232F308
	cmp r0,#0x0	; 0232F30A
	beq loc_0232F308	; 0232F30C
	mov r0,#0x0	; 0232F30E
	str r0,[r1,#0x0]	; 0232F310
	ldr r1,[pool_0232F350]	; 0232F312
	str r0,[r1,#0x0]	; 0232F314
	mov r1,#0x2	; 0232F316
	add r2,r0,#0x0	; 0232F318
	add r3,r0,#0x0	; 0232F31A
	bl loc_0232EF80	; 0232F31C
	mov r0,#0xff	; 0232F320
	and r5,r0	; 0232F322
	ldr r0,[pool_0232F354]	; 0232F324
	orr r5,r0	; 0232F326
	add r0,r5,#0x0	; 0232F328
	bl loc_0232F0D0	; 0232F32A
	ldr r0,[pool_0232F358]	; 0232F32E
	and r4,r0	; 0232F330
	ldr r0,[pool_0232F35C]	; 0232F332
	orr r4,r0	; 0232F334
	add r0,r4,#0x0	; 0232F336
	bl loc_0232F0D0	; 0232F338
	mov r0,#0x0	; 0232F33C
	add sp,#0x4	; 0232F33E
	pop {r4,r5}	; 0232F340
	pop {r3}	; 0232F342
	bx r3	; 0232F344
	.byte 0xC0, 0x46	; 0232F348
pool_0232F348:
loc_0232F348:
	.word P1_BssStart + 0x282C8	; 0232F348
pool_0232F34C:
loc_0232F34C:
	.word 0x03006000	; 0232F34C
pool_0232F350:
loc_0232F350:
	.word P1_BssStart + 0x282CC	; 0232F350
pool_0232F354:
loc_0232F354:
	.word 0x02006100	; 0232F354
pool_0232F358:
loc_0232F358:
	.word 0x0000FFFF	; 0232F358
pool_0232F35C:
loc_0232F35C:
	.word 0x01010000	; 0232F35C

; ===== function loc_0232F360 =====
P1_PxiCallback_0232F360:
	push {lr}	; 0232F360
	sub sp,#0x4	; 0232F362
	cmp r2,#0x0	; 0232F364
	beq loc_0232F374	; 0232F366
	mov r0,#0x2	; 0232F368
	bl loc_0232F470	; 0232F36A
	add sp,#0x4	; 0232F36E
	pop {r3}	; 0232F370
	bx r3	; 0232F372
loc_0232F374:
	ldr r0,[pool_0232F3E0]	; 0232F374
	add r2,r1,#0x0	; 0232F376
	and r2,r0	; 0232F378
	lsl r0,r2,#0x8	; 0232F37A
	lsr r3,r0,#0x10	; 0232F37C
	mov r2,#0xff	; 0232F37E
	and r1,r2	; 0232F380
	lsl r0,r1,#0x10	; 0232F382
	lsr r0,r0,#0x10	; 0232F384
	cmp r3,#0x70	; 0232F386
	bcc loc_0232F3AC	; 0232F388
	cmp r3,#0x73	; 0232F38A
	bhi loc_0232F3AC	; 0232F38C
	and r0,r2	; 0232F38E
	lsl r0,r0,#0x10	; 0232F390
	lsr r1,r0,#0x10	; 0232F392
	sub r3,#0x70	; 0232F394
	lsl r2,r3,#0x3	; 0232F396
	ldr r0,[pool_0232F3E4]	; 0232F398
	ldr r0,[r0,r2]	; 0232F39A
	cmp r0,#0x0	; 0232F39C
	beq loc_0232F3A2	; 0232F39E
	strh r1,[r0,#0x0]	; 0232F3A0
loc_0232F3A2:
	mov r1,#0x1	; 0232F3A2
	ldr r0,[pool_0232F3E8]	; 0232F3A4
	strh r1,[r0,r2]	; 0232F3A6
	mov r0,#0x0	; 0232F3A8
	b loc_0232F3D4	; 0232F3AA
loc_0232F3AC:
	cmp r3,#0x60	; 0232F3AC
	bne loc_0232F3B8	; 0232F3AE
	mov r2,#0x1	; 0232F3B0
	ldr r1,[pool_0232F3EC]	; 0232F3B2
	str r2,[r1,#0x0]	; 0232F3B4
	b loc_0232F3D4	; 0232F3B6
loc_0232F3B8:
	cmp r3,#0x62	; 0232F3B8
	bne loc_0232F3C4	; 0232F3BA
	mov r2,#0x1	; 0232F3BC
	ldr r1,[pool_0232F3F0]	; 0232F3BE
	str r2,[r1,#0x0]	; 0232F3C0
	b loc_0232F3D4	; 0232F3C2
loc_0232F3C4:
	cmp r3,#0x67	; 0232F3C4
	bne loc_0232F3D4	; 0232F3C6
	ldr r1,[pool_0232F3F4]	; 0232F3C8
	ldr r1,[r1,#0xc]	; 0232F3CA
	cmp r1,#0x0	; 0232F3CC
	beq loc_0232F3D2	; 0232F3CE
	str r0,[r1,#0x0]	; 0232F3D0
loc_0232F3D2:
	mov r0,#0x0	; 0232F3D2
loc_0232F3D4:
	bl loc_0232F470	; 0232F3D4
	add sp,#0x4	; 0232F3D8
	pop {r3}	; 0232F3DA
	bx r3	; 0232F3DC
	.byte 0xC0, 0x46	; 0232F3E0
pool_0232F3E0:
loc_0232F3E0:
	.word 0x00007F00	; 0232F3E0
pool_0232F3E4:
loc_0232F3E4:
	.word P1_BssStart + 0x282FC	; 0232F3E4
pool_0232F3E8:
loc_0232F3E8:
	.word P1_BssStart + 0x282F8	; 0232F3E8
pool_0232F3EC:
loc_0232F3EC:
	.word P1_BssStart + 0x282C8	; 0232F3EC
pool_0232F3F0:
loc_0232F3F0:
	.word P1_BssStart + 0x282CC	; 0232F3F0
pool_0232F3F4:
loc_0232F3F4:
	.word P1_BssStart + 0x282D4	; 0232F3F4

; ===== function loc_0232F3F8 =====
loc_0232F3F8:
	push {r4,r5,lr}	; 0232F3F8
	sub sp,#0x4	; 0232F3FA
	ldr r0,[pool_0232F454]	; 0232F3FC
	ldrh r1,[r0,#0x0]	; 0232F3FE
	cmp r1,#0x0	; 0232F400
	bne loc_0232F44A	; 0232F402
	mov r1,#0x1	; 0232F404
	strh r1,[r0,#0x0]	; 0232F406
	mov r1,#0x0	; 0232F408
	ldr r0,[pool_0232F458]	; 0232F40A
	str r1,[r0,#0x0]	; 0232F40C
	str r1,[r0,#0x4]	; 0232F40E
	bl loc_0232E728	; 0232F410
	mov r5,#0x8	; 0232F414
	mov r4,#0x1	; 0232F416
loc_0232F418:
	add r0,r5,#0x0	; 0232F418
	add r1,r4,#0x0	; 0232F41A
	bl loc_0232E89C	; 0232F41C
	cmp r0,#0x0	; 0232F420
	beq loc_0232F418	; 0232F422
	mov r0,#0x8	; 0232F424
	ldr r1,[pool_0232F45C]	; 0232F426
	bl P1_SetPxiReceiveCallback	; 0232F428
	mov r2,#0x0	; 0232F42C
	ldr r1,[pool_0232F460]	; 0232F42E
	add r0,r2,#0x0	; 0232F430
loc_0232F432:
	strh r0,[r1,#0x0]	; 0232F432
	add r1,#0x8	; 0232F434
	add r2,r2,#0x1	; 0232F436
	cmp r2,#0x4	; 0232F438
	blt loc_0232F432	; 0232F43A
	ldr r0,[pool_0232F464]	; 0232F43C
	bl loc_0232BAC8	; 0232F43E
	ldr r0,[pool_0232F468]	; 0232F442
	ldr r1,[r0,#0x0]	; 0232F444
	ldr r0,[pool_0232F46C]	; 0232F446
	str r1,[r0,#0x0]	; 0232F448
loc_0232F44A:
	add sp,#0x4	; 0232F44A
	pop {r4,r5}	; 0232F44C
	pop {r3}	; 0232F44E
	bx r3	; 0232F450
	.byte 0xC0, 0x46	; 0232F454
pool_0232F454:
loc_0232F454:
	.word P1_BssStart + 0x282C4	; 0232F454
pool_0232F458:
loc_0232F458:
	.word P1_BssStart + 0x282D4	; 0232F458
pool_0232F45C:
loc_0232F45C:
	.word P1_PxiCallback_0232F360 + 1	; 0232F45C
pool_0232F460:
loc_0232F460:
	.word P1_BssStart + 0x282F8	; 0232F460
pool_0232F464:
loc_0232F464:
	.word 0x02358CA4	; 0232F464
pool_0232F468:
loc_0232F468:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232F468
pool_0232F46C:
loc_0232F46C:
	.word P1_BssStart + 0x282D0	; 0232F46C

; ===== function loc_0232F470 =====
loc_0232F470:
	push {r4,lr}	; 0232F470
	ldr r3,[pool_0232F494]	; 0232F472
	ldr r2,[r3,#0x4]	; 0232F474
	ldr r1,[r3,#0x8]	; 0232F476
	ldr r4,[r3,#0x0]	; 0232F478
	cmp r4,#0x0	; 0232F47A
	beq loc_0232F482	; 0232F47C
	mov r4,#0x0	; 0232F47E
	str r4,[r3,#0x0]	; 0232F480
loc_0232F482:
	cmp r2,#0x0	; 0232F482
	beq loc_0232F48E	; 0232F484
	mov r4,#0x0	; 0232F486
	ldr r3,[pool_0232F494]	; 0232F488
	str r4,[r3,#0x4]	; 0232F48A
	blx r2	; 0232F48C
loc_0232F48E:
	pop {r4}	; 0232F48E
	pop {r3}	; 0232F490
	bx r3	; 0232F492
pool_0232F494:
loc_0232F494:
	.word P1_BssStart + 0x282D4	; 0232F494
	str r0,[r1,#0x0]	; 0232F498
	bx lr	; 0232F49A

; ===== function loc_0232F49C =====
loc_0232F49C:
	ldr r1,[pool_0232F4A8]	; 0232F49C
loc_0232F49E:
	ldr r0,[r1,#0x0]	; 0232F49E
	cmp r0,#0x0	; 0232F4A0
	bne loc_0232F49E	; 0232F4A2
	bx lr	; 0232F4A4
	.byte 0xC0, 0x46	; 0232F4A8
pool_0232F4A8:
loc_0232F4A8:
	.word P1_BssStart + 0x282D4	; 0232F4A8

; ===== function loc_0232F4AC =====
loc_0232F4AC:
	push {lr}	; 0232F4AC
	sub sp,#0x4	; 0232F4AE
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F4B0
	ldr r1,[pool_0232F4D8]	; 0232F4B4
	ldr r2,[r1,#0x0]	; 0232F4B6
	cmp r2,#0x0	; 0232F4B8
	beq loc_0232F4C8	; 0232F4BA
	blx P1_Arm9RestoreIrqMask	; 0232F4BC
	mov r0,#0x0	; 0232F4C0
	add sp,#0x4	; 0232F4C2
	pop {r3}	; 0232F4C4
	bx r3	; 0232F4C6
loc_0232F4C8:
	mov r2,#0x1	; 0232F4C8
	str r2,[r1,#0x0]	; 0232F4CA
	blx P1_Arm9RestoreIrqMask	; 0232F4CC
	mov r0,#0x1	; 0232F4D0
	add sp,#0x4	; 0232F4D2
	pop {r3}	; 0232F4D4
	bx r3	; 0232F4D6
pool_0232F4D8:
loc_0232F4D8:
	.word P1_BssStart + 0x282D4	; 0232F4D8
.arm

; ===== function loc_0232F4DC =====
loc_0232F4DC:
	ldr r12,[pool_0232F4F0]	; 0232F4DC
loc_0232F4E0:
	ldr r0,[r12,#0x0]	; 0232F4E0
	cmp r0,#0x1	; 0232F4E4
	beq loc_0232F4E0	; 0232F4E8
	bx lr	; 0232F4EC
pool_0232F4F0:
loc_0232F4F0:
	.word P1_BssStart + 0x2831C	; 0232F4F0
.thumb
	ldr r1,[pool_0232F4FC]	; 0232F4F4
	str r0,[r1,#0x20]	; 0232F4F6
	bx lr	; 0232F4F8
	.byte 0xC0, 0x46	; 0232F4FC
pool_0232F4FC:
loc_0232F4FC:
	.word P1_BssStart + 0x2831C	; 0232F4FC

; ===== function loc_0232F500 =====
loc_0232F500:
	push {r4,r5,lr}	; 0232F500
	sub sp,#0x4	; 0232F502
	add r5,r0,#0x0	; 0232F504
	add r4,r1,#0x0	; 0232F506
	ldr r0,[r5,#0x0]	; 0232F508
	cmp r0,#0xc	; 0232F50A
	bcc loc_0232F518	; 0232F50C
	ldr r1,[r4,#0x0]	; 0232F50E
	mov r0,#0x40	; 0232F510
	orr r1,r0	; 0232F512
	str r1,[r4,#0x0]	; 0232F514
	b loc_0232F520	; 0232F516
loc_0232F518:
	ldr r1,[r4,#0x0]	; 0232F518
	mov r0,#0x40	; 0232F51A
	bic r1,r0	; 0232F51C
	str r1,[r4,#0x0]	; 0232F51E
loc_0232F520:
	ldr r0,[r5,#0x0]	; 0232F520
	bl loc_0232F674	; 0232F522
	ldr r2,[r4,#0x0]	; 0232F526
	mov r1,#0x3f	; 0232F528
	bic r2,r1	; 0232F52A
	and r0,r1	; 0232F52C
	orr r2,r0	; 0232F52E
	str r2,[r4,#0x0]	; 0232F530
	ldr r0,[r5,#0x4]	; 0232F532
	bl loc_0232F674	; 0232F534
	ldr r2,[r4,#0x0]	; 0232F538
	ldr r1,[pool_0232F568]	; 0232F53A
	and r2,r1	; 0232F53C
	mov r1,#0x7f	; 0232F53E
	and r0,r1	; 0232F540
	lsl r0,r0,#0x8	; 0232F542
	orr r2,r0	; 0232F544
	str r2,[r4,#0x0]	; 0232F546
	ldr r0,[r5,#0x8]	; 0232F548
	bl loc_0232F674	; 0232F54A
	ldr r2,[r4,#0x0]	; 0232F54E
	ldr r1,[pool_0232F56C]	; 0232F550
	and r2,r1	; 0232F552
	mov r1,#0x7f	; 0232F554
	and r0,r1	; 0232F556
	lsl r0,r0,#0x10	; 0232F558
	orr r2,r0	; 0232F55A
	str r2,[r4,#0x0]	; 0232F55C
	add sp,#0x4	; 0232F55E
	pop {r4,r5}	; 0232F560
	pop {r3}	; 0232F562
	bx r3	; 0232F564
	.byte 0xC0, 0x46	; 0232F568
pool_0232F568:
loc_0232F568:
	.word 0xFFFF80FF	; 0232F568
pool_0232F56C:
loc_0232F56C:
	.word 0xFF80FFFF	; 0232F56C

; ===== function loc_0232F570 =====
loc_0232F570:
	push {r4,r5,lr}	; 0232F570
	sub sp,#0x4	; 0232F572
	add r5,r0,#0x0	; 0232F574
	add r4,r1,#0x0	; 0232F576
	ldr r0,[r5,#0x0]	; 0232F578
	bl loc_0232F674	; 0232F57A
	str r0,[r4,#0x0]	; 0232F57E
	ldr r0,[r5,#0x4]	; 0232F580
	bl loc_0232F674	; 0232F582
	ldr r2,[r4,#0x0]	; 0232F586
	ldr r1,[pool_0232F5C8]	; 0232F588
	and r2,r1	; 0232F58A
	mov r1,#0x1f	; 0232F58C
	and r0,r1	; 0232F58E
	lsl r0,r0,#0x8	; 0232F590
	orr r2,r0	; 0232F592
	str r2,[r4,#0x0]	; 0232F594
	ldr r0,[r5,#0x8]	; 0232F596
	bl loc_0232F674	; 0232F598
	ldr r2,[r4,#0x0]	; 0232F59C
	ldr r1,[pool_0232F5CC]	; 0232F59E
	and r2,r1	; 0232F5A0
	mov r1,#0x3f	; 0232F5A2
	and r0,r1	; 0232F5A4
	lsl r0,r0,#0x10	; 0232F5A6
	orr r2,r0	; 0232F5A8
	str r2,[r4,#0x0]	; 0232F5AA
	ldr r2,[r4,#0x0]	; 0232F5AC
	ldr r0,[pool_0232F5D0]	; 0232F5AE
	and r2,r0	; 0232F5B0
	ldr r1,[r5,#0xc]	; 0232F5B2
	mov r0,#0x7	; 0232F5B4
	and r1,r0	; 0232F5B6
	lsl r0,r1,#0x18	; 0232F5B8
	orr r2,r0	; 0232F5BA
	str r2,[r4,#0x0]	; 0232F5BC
	add sp,#0x4	; 0232F5BE
	pop {r4,r5}	; 0232F5C0
	pop {r3}	; 0232F5C2
	bx r3	; 0232F5C4
	.byte 0xC0, 0x46	; 0232F5C8
pool_0232F5C8:
loc_0232F5C8:
	.word 0xFFFFE0FF	; 0232F5C8
pool_0232F5CC:
loc_0232F5CC:
	.word 0xFFC0FFFF	; 0232F5CC
pool_0232F5D0:
loc_0232F5D0:
	.word 0xF8FFFFFF	; 0232F5D0

; ===== function loc_0232F5D4 =====
loc_0232F5D4:
	push {r4,lr}	; 0232F5D4
	sub sp,#0x8	; 0232F5D6
	add r4,r0,#0x0	; 0232F5D8
	mov r2,#0x0	; 0232F5DA
	str r2,[sp,#0x0]	; 0232F5DC
	mov r0,#0x7	; 0232F5DE
	bic r2,r0	; 0232F5E0
	ldr r1,[r4,#0x0]	; 0232F5E2
	and r1,r0	; 0232F5E4
	orr r2,r1	; 0232F5E6
	str r2,[sp,#0x0]	; 0232F5E8
	ldr r0,[r4,#0x4]	; 0232F5EA
	cmp r0,#0xc	; 0232F5EC
	bcc loc_0232F5F6	; 0232F5EE
	ldr r0,[pool_0232F660]	; 0232F5F0
	orr r2,r0	; 0232F5F2
	str r2,[sp,#0x0]	; 0232F5F4
loc_0232F5F6:
	ldr r0,[r4,#0x4]	; 0232F5F6
	bl loc_0232F674	; 0232F5F8
	ldr r2,[sp,#0x0]	; 0232F5FC
	ldr r1,[pool_0232F664]	; 0232F5FE
	and r2,r1	; 0232F600
	mov r1,#0x3f	; 0232F602
	and r0,r1	; 0232F604
	lsl r0,r0,#0x8	; 0232F606
	orr r2,r0	; 0232F608
	str r2,[sp,#0x0]	; 0232F60A
	ldr r0,[r4,#0x8]	; 0232F60C
	bl loc_0232F674	; 0232F60E
	ldr r1,[sp,#0x0]	; 0232F612
	ldr r2,[pool_0232F668]	; 0232F614
	and r1,r2	; 0232F616
	mov r2,#0x7f	; 0232F618
	and r0,r2	; 0232F61A
	lsl r0,r0,#0x10	; 0232F61C
	orr r1,r0	; 0232F61E
	str r1,[sp,#0x0]	; 0232F620
	ldr r2,[r4,#0xc]	; 0232F622
	mov r0,#0x1	; 0232F624
	and r2,r0	; 0232F626
	cmp r2,#0x0	; 0232F628
	beq loc_0232F632	; 0232F62A
	mov r0,#0x80	; 0232F62C
	orr r1,r0	; 0232F62E
	str r1,[sp,#0x0]	; 0232F630
loc_0232F632:
	ldr r1,[r4,#0xc]	; 0232F632
	mov r0,#0x2	; 0232F634
	and r1,r0	; 0232F636
	cmp r1,#0x0	; 0232F638
	beq loc_0232F644	; 0232F63A
	ldr r1,[sp,#0x0]	; 0232F63C
	ldr r0,[pool_0232F66C]	; 0232F63E
	orr r1,r0	; 0232F640
	str r1,[sp,#0x0]	; 0232F642
loc_0232F644:
	ldr r1,[r4,#0xc]	; 0232F644
	mov r0,#0x4	; 0232F646
	and r1,r0	; 0232F648
	cmp r1,#0x0	; 0232F64A
	beq loc_0232F656	; 0232F64C
	ldr r1,[sp,#0x0]	; 0232F64E
	ldr r0,[pool_0232F670]	; 0232F650
	orr r1,r0	; 0232F652
	str r1,[sp,#0x0]	; 0232F654
loc_0232F656:
	ldr r0,[sp,#0x0]	; 0232F656
	add sp,#0x8	; 0232F658
	pop {r4}	; 0232F65A
	pop {r3}	; 0232F65C
	bx r3	; 0232F65E
pool_0232F660:
loc_0232F660:
	.word 0x00004000	; 0232F660
pool_0232F664:
loc_0232F664:
	.word 0xFFFFC0FF	; 0232F664
pool_0232F668:
loc_0232F668:
	.word 0xFF80FFFF	; 0232F668
pool_0232F66C:
loc_0232F66C:
	.word 0x00008000	; 0232F66C
pool_0232F670:
loc_0232F670:
	.word 0x00800000	; 0232F670

; ===== function loc_0232F674 =====
loc_0232F674:
	push {r4,r5,r6,r7,lr}	; 0232F674
	sub sp,#0x4	; 0232F676
	add r5,r0,#0x0	; 0232F678
	mov r6,#0x0	; 0232F67A
	ldr r0,[pool_0232F6B8]	; 0232F67C
	cmp r5,r0	; 0232F67E
	bls loc_0232F68C	; 0232F680
	add r0,r6,#0x0	; 0232F682
	add sp,#0x4	; 0232F684
	pop {r4,r5,r6,r7}	; 0232F686
	pop {r3}	; 0232F688
	bx r3	; 0232F68A
loc_0232F68C:
	add r7,r6,#0x0	; 0232F68C
	add r4,r6,#0x0	; 0232F68E
loc_0232F690:
	add r0,r5,#0x0	; 0232F690
	mov r1,#0xa	; 0232F692
	blx P1_UnsignedDivMod	; 0232F694
	lsl r1,r4	; 0232F698
	add r6,r6,r1	; 0232F69A
	add r0,r5,#0x0	; 0232F69C
	mov r1,#0xa	; 0232F69E
	blx P1_UnsignedDivMod	; 0232F6A0
	add r5,r0,#0x0	; 0232F6A4
	add r4,r4,#0x4	; 0232F6A6
	add r7,r7,#0x1	; 0232F6A8
	cmp r7,#0x8	; 0232F6AA
	blt loc_0232F690	; 0232F6AC
	add r0,r6,#0x0	; 0232F6AE
	add sp,#0x4	; 0232F6B0
	pop {r4,r5,r6,r7}	; 0232F6B2
	pop {r3}	; 0232F6B4
	bx r3	; 0232F6B6
pool_0232F6B8:
loc_0232F6B8:
	.word 0x05F5E0FF	; 0232F6B8

; ===== function loc_0232F6BC =====
loc_0232F6BC:
	push {r4,r5,r6,r7}	; 0232F6BC
	mov r4,#0x0	; 0232F6BE
	add r5,r4,#0x0	; 0232F6C0
	add r3,r4,#0x0	; 0232F6C2
	mov r1,#0xf	; 0232F6C4
loc_0232F6C6:
	add r2,r0,#0x0	; 0232F6C6
	lsr r2,r3	; 0232F6C8
	and r2,r1	; 0232F6CA
	cmp r2,#0xa	; 0232F6CC
	bcc loc_0232F6D6	; 0232F6CE
	mov r0,#0x0	; 0232F6D0
	pop {r4,r5,r6,r7}	; 0232F6D2
	bx lr	; 0232F6D4
loc_0232F6D6:
	add r3,r3,#0x4	; 0232F6D6
	add r5,r5,#0x1	; 0232F6D8
	cmp r5,#0x8	; 0232F6DA
	blt loc_0232F6C6	; 0232F6DC
	mov r1,#0x0	; 0232F6DE
	mov r3,#0x1	; 0232F6E0
	add r2,r1,#0x0	; 0232F6E2
	mov r6,#0xa	; 0232F6E4
loc_0232F6E6:
	add r7,r0,#0x0	; 0232F6E6
	lsr r7,r2	; 0232F6E8
	mov r5,#0xf	; 0232F6EA
	and r7,r5	; 0232F6EC
	add r5,r3,#0x0	; 0232F6EE
	mul r5,r7	; 0232F6F0
	add r4,r4,r5	; 0232F6F2
	add r2,r2,#0x4	; 0232F6F4
	add r1,r1,#0x1	; 0232F6F6
	mul r3,r6	; 0232F6F8
	cmp r1,#0x8	; 0232F6FA
	blt loc_0232F6E6	; 0232F6FC
	add r0,r4,#0x0	; 0232F6FE
	pop {r4,r5,r6,r7}	; 0232F700
	bx lr	; 0232F702

; ===== function loc_0232F704 =====
P1_PxiCallback_0232F704:
	push {r4,r5,lr}	; 0232F704
	sub sp,#0x4	; 0232F706
	cmp r2,#0x0	; 0232F708
	beq loc_0232F740	; 0232F70A
	ldr r0,[pool_0232F9D8]	; 0232F70C
	ldr r1,[r0,#0x18]	; 0232F70E
	cmp r1,#0x0	; 0232F710
	beq loc_0232F718	; 0232F712
	mov r1,#0x0	; 0232F714
	str r1,[r0,#0x18]	; 0232F716
loc_0232F718:
	ldr r0,[pool_0232F9D8]	; 0232F718
	ldr r1,[r0,#0x0]	; 0232F71A
	cmp r1,#0x0	; 0232F71C
	beq loc_0232F724	; 0232F71E
	mov r1,#0x0	; 0232F720
	str r1,[r0,#0x0]	; 0232F722
loc_0232F724:
	ldr r1,[pool_0232F9D8]	; 0232F724
	ldr r2,[r1,#0x4]	; 0232F726
	cmp r2,#0x0	; 0232F728
	bne loc_0232F72E	; 0232F72A
	b loc_0232F9CE	; 0232F72C
loc_0232F72E:
	mov r0,#0x0	; 0232F72E
	str r0,[r1,#0x4]	; 0232F730
	mov r0,#0x6	; 0232F732
	ldr r1,[r1,#0x10]	; 0232F734
	blx r2	; 0232F736
	add sp,#0x4	; 0232F738
	pop {r4,r5}	; 0232F73A
	pop {r3}	; 0232F73C
	bx r3	; 0232F73E
loc_0232F740:
	mov r2,#0xff	; 0232F740
	add r0,r1,#0x0	; 0232F742
	and r0,r2	; 0232F744
	ldr r3,[pool_0232F9DC]	; 0232F746
	and r1,r3	; 0232F748
	lsr r1,r1,#0x8	; 0232F74A
	lsl r1,r1,#0x18	; 0232F74C
	lsr r1,r1,#0x18	; 0232F74E
	cmp r1,#0x30	; 0232F750
	bne loc_0232F768	; 0232F752
	ldr r0,[pool_0232F9D8]	; 0232F754
	ldr r0,[r0,#0x1c]	; 0232F756
	cmp r0,#0x0	; 0232F758
	bne loc_0232F75E	; 0232F75A
	b loc_0232F9CE	; 0232F75C
loc_0232F75E:
	blx r0	; 0232F75E
	add sp,#0x4	; 0232F760
	pop {r4,r5}	; 0232F762
	pop {r3}	; 0232F764
	bx r3	; 0232F766
loc_0232F768:
	cmp r0,#0x0	; 0232F768
	beq loc_0232F76E	; 0232F76A
	b loc_0232F97A	; 0232F76C
loc_0232F76E:
	mov r4,#0x0	; 0232F76E
	ldr r0,[pool_0232F9D8]	; 0232F770
	ldr r1,[r0,#0x14]	; 0232F772
	cmp r1,#0xf	; 0232F774
	bls loc_0232F77A	; 0232F776
	b loc_0232F970	; 0232F778
loc_0232F77A:
	add r1,r1,r1	; 0232F77A
P1_SwitchIndexPC_0232F77A:
	add r1,pc	; 0232F77C
	ldrh r1,[r1,#(P1_SwitchTable_0232F77A - (P1_SwitchIndexPC_0232F77A + 4))]	; 0232F77E
	lsl r1,r1,#0x10	; 0232F780
	asr r1,r1,#0x10	; 0232F782
P1_SwitchTargetPC_0232F77A:
	add r1,pc	; 0232F784
	bx r1	; 0232F786
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232F77A:
	.halfword (loc_0232F970 + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F970 + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F7A8 + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F970 + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F970 + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F9AA + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F80C + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F824 + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F83C + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F8A0 + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F90A + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F9AA + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F9AA + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F9AA + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F9AA + 1) - (P1_SwitchTargetPC_0232F77A + 4)
	.halfword (loc_0232F9AA + 1) - (P1_SwitchTargetPC_0232F77A + 4)
P1_SwitchTable_0232F77AEnd:
loc_0232F7A8:
	ldr r5,[r0,#0x8]	; 0232F7A8
	ldr r0,[pool_0232F9E0]	; 0232F7AA
	ldr r0,[r0,#0x0]	; 0232F7AC
	and r0,r2	; 0232F7AE
	bl loc_0232F6BC	; 0232F7B0
	str r0,[r5,#0x0]	; 0232F7B4
	ldr r0,[pool_0232F9E0]	; 0232F7B6
	ldr r0,[r0,#0x0]	; 0232F7B8
	lsl r0,r0,#0x13	; 0232F7BA
	lsr r0,r0,#0x1b	; 0232F7BC
	bl loc_0232F6BC	; 0232F7BE
	str r0,[r5,#0x4]	; 0232F7C2
	ldr r0,[pool_0232F9E0]	; 0232F7C4
	ldr r0,[r0,#0x0]	; 0232F7C6
	lsl r0,r0,#0xa	; 0232F7C8
	lsr r0,r0,#0x1a	; 0232F7CA
	bl loc_0232F6BC	; 0232F7CC
	str r0,[r5,#0x8]	; 0232F7D0
	ldr r0,[pool_0232F9E0]	; 0232F7D2
	ldr r0,[r0,#0x0]	; 0232F7D4
	lsl r0,r0,#0x5	; 0232F7D6
	lsr r0,r0,#0x1d	; 0232F7D8
	str r0,[r5,#0xc]	; 0232F7DA
	ldr r0,[pool_0232F9D8]	; 0232F7DC
	ldr r5,[r0,#0xc]	; 0232F7DE
	ldr r0,[pool_0232F9E4]	; 0232F7E0
	ldr r0,[r0,#0x0]	; 0232F7E2
	lsl r0,r0,#0x1a	; 0232F7E4
	lsr r0,r0,#0x1a	; 0232F7E6
	bl loc_0232F6BC	; 0232F7E8
	str r0,[r5,#0x0]	; 0232F7EC
	ldr r0,[pool_0232F9E4]	; 0232F7EE
	ldr r0,[r0,#0x0]	; 0232F7F0
	lsl r0,r0,#0x11	; 0232F7F2
	lsr r0,r0,#0x19	; 0232F7F4
	bl loc_0232F6BC	; 0232F7F6
	str r0,[r5,#0x4]	; 0232F7FA
	ldr r0,[pool_0232F9E4]	; 0232F7FC
	ldr r0,[r0,#0x0]	; 0232F7FE
	lsl r0,r0,#0x9	; 0232F800
	lsr r0,r0,#0x19	; 0232F802
	bl loc_0232F6BC	; 0232F804
	str r0,[r5,#0x8]	; 0232F808
	b loc_0232F9AA	; 0232F80A
loc_0232F80C:
	ldr r1,[r0,#0x8]	; 0232F80C
	ldr r0,[pool_0232F9E8]	; 0232F80E
	ldrh r0,[r0,#0x0]	; 0232F810
	lsl r0,r0,#0x1c	; 0232F812
	lsr r0,r0,#0x1c	; 0232F814
	cmp r0,#0x4	; 0232F816
	bne loc_0232F820	; 0232F818
	mov r0,#0x1	; 0232F81A
	str r0,[r1,#0x0]	; 0232F81C
	b loc_0232F9AA	; 0232F81E
loc_0232F820:
	str r4,[r1,#0x0]	; 0232F820
	b loc_0232F9AA	; 0232F822
loc_0232F824:
	ldr r1,[r0,#0x8]	; 0232F824
	ldr r0,[pool_0232F9E8]	; 0232F826
	ldrh r0,[r0,#0x0]	; 0232F828
	lsl r0,r0,#0x19	; 0232F82A
	lsr r0,r0,#0x1f	; 0232F82C
	cmp r0,#0x0	; 0232F82E
	beq loc_0232F838	; 0232F830
	mov r0,#0x1	; 0232F832
	str r0,[r1,#0x0]	; 0232F834
	b loc_0232F9AA	; 0232F836
loc_0232F838:
	str r4,[r1,#0x0]	; 0232F838
	b loc_0232F9AA	; 0232F83A
loc_0232F83C:
	ldr r5,[r0,#0x8]	; 0232F83C
	ldr r1,[pool_0232F9E4]	; 0232F83E
	ldr r0,[r1,#0x0]	; 0232F840
	lsl r0,r0,#0x1d	; 0232F842
	lsr r0,r0,#0x1d	; 0232F844
	str r0,[r5,#0x0]	; 0232F846
	ldr r0,[r1,#0x0]	; 0232F848
	lsl r0,r0,#0x12	; 0232F84A
	lsr r0,r0,#0x1a	; 0232F84C
	bl loc_0232F6BC	; 0232F84E
	str r0,[r5,#0x4]	; 0232F852
	ldr r0,[pool_0232F9E4]	; 0232F854
	ldr r0,[r0,#0x0]	; 0232F856
	lsl r0,r0,#0x9	; 0232F858
	lsr r0,r0,#0x19	; 0232F85A
	bl loc_0232F6BC	; 0232F85C
	str r0,[r5,#0x8]	; 0232F860
	lsl r0,r4,#0	; 0232F862
	str r0,[r5,#0xc]	; 0232F864
	ldr r0,[pool_0232F9E4]	; 0232F866
	ldr r0,[r0,#0x0]	; 0232F868
	lsl r0,r0,#0x18	; 0232F86A
	lsr r0,r0,#0x1f	; 0232F86C
	cmp r0,#0x0	; 0232F86E
	beq loc_0232F878	; 0232F870
	ldr r0,[r5,#0xc]	; 0232F872
	add r0,r0,#0x1	; 0232F874
	str r0,[r5,#0xc]	; 0232F876
loc_0232F878:
	ldr r0,[pool_0232F9E4]	; 0232F878
	ldr r0,[r0,#0x0]	; 0232F87A
	lsl r0,r0,#0x10	; 0232F87C
	lsr r0,r0,#0x1f	; 0232F87E
	cmp r0,#0x0	; 0232F880
	beq loc_0232F88A	; 0232F882
	ldr r0,[r5,#0xc]	; 0232F884
	add r0,r0,#0x2	; 0232F886
	str r0,[r5,#0xc]	; 0232F888
loc_0232F88A:
	ldr r0,[pool_0232F9E4]	; 0232F88A
	ldr r0,[r0,#0x0]	; 0232F88C
	lsl r0,r0,#0x8	; 0232F88E
	lsr r0,r0,#0x1f	; 0232F890
	cmp r0,#0x0	; 0232F892
	bne loc_0232F898	; 0232F894
	b loc_0232F9AA	; 0232F896
loc_0232F898:
	ldr r0,[r5,#0xc]	; 0232F898
	add r0,r0,#0x4	; 0232F89A
	str r0,[r5,#0xc]	; 0232F89C
	b loc_0232F9AA	; 0232F89E
loc_0232F8A0:
	ldr r2,[r0,#0x18]	; 0232F8A0
	cmp r2,#0x0	; 0232F8A2
	bne loc_0232F906	; 0232F8A4
	ldr r1,[r0,#0x8]	; 0232F8A6
	ldr r1,[r1,#0x0]	; 0232F8A8
	cmp r1,#0x1	; 0232F8AA
	bne loc_0232F8DC	; 0232F8AC
	ldr r1,[pool_0232F9E8]	; 0232F8AE
	ldrh r3,[r1,#0x0]	; 0232F8B0
	lsl r3,r3,#0x1c	; 0232F8B2
	lsr r3,r3,#0x1c	; 0232F8B4
	cmp r3,#0x4	; 0232F8B6
	beq loc_0232F9AA	; 0232F8B8
	add r2,r2,#0x1	; 0232F8BA
	str r2,[r0,#0x18]	; 0232F8BC
	ldrh r2,[r1,#0x0]	; 0232F8BE
	mov r0,#0xf	; 0232F8C0
	bic r2,r0	; 0232F8C2
	mov r0,#0x4	; 0232F8C4
	orr r2,r0	; 0232F8C6
	strh r2,[r1,#0x0]	; 0232F8C8
	bl loc_0232FD74	; 0232F8CA
	cmp r0,#0x0	; 0232F8CE
	bne loc_0232F9AA	; 0232F8D0
	lsl r1,r4,#0	; 0232F8D2
	ldr r0,[pool_0232F9D8]	; 0232F8D4
	str r1,[r0,#0x18]	; 0232F8D6
	mov r4,#0x3	; 0232F8D8
	b loc_0232F9AA	; 0232F8DA
loc_0232F8DC:
	ldr r1,[pool_0232F9E8]	; 0232F8DC
	ldrh r3,[r1,#0x0]	; 0232F8DE
	lsl r3,r3,#0x1c	; 0232F8E0
	lsr r3,r3,#0x1c	; 0232F8E2
	cmp r3,#0x0	; 0232F8E4
	beq loc_0232F9AA	; 0232F8E6
	add r2,r2,#0x1	; 0232F8E8
	str r2,[r0,#0x18]	; 0232F8EA
	ldrh r2,[r1,#0x0]	; 0232F8EC
	mov r0,#0xf	; 0232F8EE
	bic r2,r0	; 0232F8F0
	strh r2,[r1,#0x0]	; 0232F8F2
	bl loc_0232FD74	; 0232F8F4
	cmp r0,#0x0	; 0232F8F8
	bne loc_0232F9AA	; 0232F8FA
	lsl r1,r4,#0	; 0232F8FC
	ldr r0,[pool_0232F9D8]	; 0232F8FE
	str r1,[r0,#0x18]	; 0232F900
	mov r4,#0x3	; 0232F902
	b loc_0232F9AA	; 0232F904
loc_0232F906:
	str r4,[r0,#0x18]	; 0232F906
	b loc_0232F9AA	; 0232F908
loc_0232F90A:
	ldr r2,[r0,#0x18]	; 0232F90A
	cmp r2,#0x0	; 0232F90C
	bne loc_0232F96C	; 0232F90E
	ldr r1,[r0,#0x8]	; 0232F910
	ldr r1,[r1,#0x0]	; 0232F912
	cmp r1,#0x1	; 0232F914
	bne loc_0232F942	; 0232F916
	ldr r1,[pool_0232F9E8]	; 0232F918
	ldrh r3,[r1,#0x0]	; 0232F91A
	lsl r3,r3,#0x19	; 0232F91C
	lsr r3,r3,#0x1f	; 0232F91E
	cmp r3,#0x0	; 0232F920
	bne loc_0232F9AA	; 0232F922
	add r2,r2,#0x1	; 0232F924
	str r2,[r0,#0x18]	; 0232F926
	ldrh r2,[r1,#0x0]	; 0232F928
	mov r0,#0x40	; 0232F92A
	orr r2,r0	; 0232F92C
	strh r2,[r1,#0x0]	; 0232F92E
	bl loc_0232FD74	; 0232F930
	cmp r0,#0x0	; 0232F934
	bne loc_0232F9AA	; 0232F936
	lsl r1,r4,#0	; 0232F938
	ldr r0,[pool_0232F9D8]	; 0232F93A
	str r1,[r0,#0x18]	; 0232F93C
	mov r4,#0x3	; 0232F93E
	b loc_0232F9AA	; 0232F940
loc_0232F942:
	ldr r1,[pool_0232F9E8]	; 0232F942
	ldrh r3,[r1,#0x0]	; 0232F944
	lsl r3,r3,#0x19	; 0232F946
	lsr r3,r3,#0x1f	; 0232F948
	cmp r3,#0x0	; 0232F94A
	beq loc_0232F9AA	; 0232F94C
	add r2,r2,#0x1	; 0232F94E
	str r2,[r0,#0x18]	; 0232F950
	ldrh r2,[r1,#0x0]	; 0232F952
	mov r0,#0x40	; 0232F954
	bic r2,r0	; 0232F956
	strh r2,[r1,#0x0]	; 0232F958
	bl loc_0232FD74	; 0232F95A
	cmp r0,#0x0	; 0232F95E
	bne loc_0232F9AA	; 0232F960
	lsl r1,r4,#0	; 0232F962
	ldr r0,[pool_0232F9D8]	; 0232F964
	str r1,[r0,#0x18]	; 0232F966
	mov r4,#0x3	; 0232F968
	b loc_0232F9AA	; 0232F96A
loc_0232F96C:
	str r4,[r0,#0x18]	; 0232F96C
	b loc_0232F9AA	; 0232F96E
loc_0232F970:
	mov r4,#0x4	; 0232F970
	mov r1,#0x0	; 0232F972
	ldr r0,[pool_0232F9D8]	; 0232F974
	str r1,[r0,#0x18]	; 0232F976
	b loc_0232F9AA	; 0232F978
loc_0232F97A:
	mov r2,#0x0	; 0232F97A
	ldr r1,[pool_0232F9D8]	; 0232F97C
	str r2,[r1,#0x18]	; 0232F97E
	cmp r0,#0x4	; 0232F980
	bhi loc_0232F9A8	; 0232F982
	add r0,r0,r0	; 0232F984
P1_SwitchIndexPC_0232F984:
	add r0,pc	; 0232F986
	ldrh r0,[r0,#(P1_SwitchTable_0232F984 - (P1_SwitchIndexPC_0232F984 + 4))]	; 0232F988
	lsl r0,r0,#0x10	; 0232F98A
	asr r0,r0,#0x10	; 0232F98C
P1_SwitchTargetPC_0232F984:
	add r0,pc	; 0232F98E
	bx r0	; 0232F990
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232F984:
	.halfword (loc_0232F9A8 + 1) - (P1_SwitchTargetPC_0232F984 + 4)
	.halfword (loc_0232F99C + 1) - (P1_SwitchTargetPC_0232F984 + 4)
	.halfword (loc_0232F9A0 + 1) - (P1_SwitchTargetPC_0232F984 + 4)
	.halfword (loc_0232F9A4 + 1) - (P1_SwitchTargetPC_0232F984 + 4)
	.halfword (loc_0232F9A8 + 1) - (P1_SwitchTargetPC_0232F984 + 4)
P1_SwitchTable_0232F984End:
loc_0232F99C:
	mov r4,#0x4	; 0232F99C
	b loc_0232F9AA	; 0232F99E
loc_0232F9A0:
	mov r4,#0x5	; 0232F9A0
	b loc_0232F9AA	; 0232F9A2
loc_0232F9A4:
	mov r4,#0x1	; 0232F9A4
	b loc_0232F9AA	; 0232F9A6
loc_0232F9A8:
	mov r4,#0x6	; 0232F9A8
loc_0232F9AA:
	ldr r0,[pool_0232F9D8]	; 0232F9AA
	ldr r1,[r0,#0x18]	; 0232F9AC
	cmp r1,#0x0	; 0232F9AE
	bne loc_0232F9CE	; 0232F9B0
	ldr r1,[r0,#0x0]	; 0232F9B2
	cmp r1,#0x0	; 0232F9B4
	beq loc_0232F9BC	; 0232F9B6
	mov r1,#0x0	; 0232F9B8
	str r1,[r0,#0x0]	; 0232F9BA
loc_0232F9BC:
	ldr r1,[pool_0232F9D8]	; 0232F9BC
	ldr r2,[r1,#0x4]	; 0232F9BE
	cmp r2,#0x0	; 0232F9C0
	beq loc_0232F9CE	; 0232F9C2
	mov r0,#0x0	; 0232F9C4
	str r0,[r1,#0x4]	; 0232F9C6
	add r0,r4,#0x0	; 0232F9C8
	ldr r1,[r1,#0x10]	; 0232F9CA
	blx r2	; 0232F9CC
loc_0232F9CE:
	add sp,#0x4	; 0232F9CE
	pop {r4,r5}	; 0232F9D0
	pop {r3}	; 0232F9D2
	bx r3	; 0232F9D4
	.byte 0xC0, 0x46	; 0232F9D8
pool_0232F9D8:
loc_0232F9D8:
	.word P1_BssStart + 0x2831C	; 0232F9D8
pool_0232F9DC:
loc_0232F9DC:
	.word 0x00007F00	; 0232F9DC
pool_0232F9E0:
loc_0232F9E0:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset	; 0232F9E0
pool_0232F9E4:
loc_0232F9E4:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232F9E4
pool_0232F9E8:
loc_0232F9E8:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x2	; 0232F9E8

; ===== function loc_0232F9EC =====
loc_0232F9EC:
	push {lr}	; 0232F9EC
	sub sp,#0x4	; 0232F9EE
	ldr r2,[pool_0232FA10]	; 0232F9F0
	mov r3,#0x0	; 0232F9F2
	bl loc_0232FA18	; 0232F9F4
	ldr r1,[pool_0232FA14]	; 0232F9F8
	str r0,[r1,#0x20]	; 0232F9FA
	cmp r0,#0x0	; 0232F9FC
	bne loc_0232FA04	; 0232F9FE
	blx loc_0232F4DC	; 0232FA00
loc_0232FA04:
	ldr r0,[pool_0232FA14]	; 0232FA04
	ldr r0,[r0,#0x20]	; 0232FA06
	add sp,#0x4	; 0232FA08
	pop {r3}	; 0232FA0A
	bx r3	; 0232FA0C
	.byte 0xC0, 0x46	; 0232FA10
pool_0232FA10:
loc_0232FA10:
	.word 0x0232F4F5	; 0232FA10
pool_0232FA14:
loc_0232FA14:
	.word P1_BssStart + 0x2831C	; 0232FA14

; ===== function loc_0232FA18 =====
loc_0232FA18:
	push {r4,r5,r6,r7,lr}	; 0232FA18
	sub sp,#0x4	; 0232FA1A
	add r5,r0,#0x0	; 0232FA1C
	add r7,r1,#0x0	; 0232FA1E
	add r4,r2,#0x0	; 0232FA20
	add r6,r3,#0x0	; 0232FA22
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FA24
	ldr r1,[pool_0232FA90]	; 0232FA28
	ldr r2,[r1,#0x0]	; 0232FA2A
	cmp r2,#0x0	; 0232FA2C
	beq loc_0232FA3E	; 0232FA2E
	blx P1_Arm9RestoreIrqMask	; 0232FA30
	mov r0,#0x1	; 0232FA34
	add sp,#0x4	; 0232FA36
	pop {r4,r5,r6,r7}	; 0232FA38
	pop {r3}	; 0232FA3A
	bx r3	; 0232FA3C
loc_0232FA3E:
	mov r2,#0x1	; 0232FA3E
	str r2,[r1,#0x0]	; 0232FA40
	blx P1_Arm9RestoreIrqMask	; 0232FA42
	mov r1,#0x0	; 0232FA46
	ldr r0,[pool_0232FA90]	; 0232FA48
	str r1,[r0,#0x18]	; 0232FA4A
	str r4,[r0,#0x4]	; 0232FA4C
	str r6,[r0,#0x10]	; 0232FA4E
	add r0,r7,#0x0	; 0232FA50
	bl loc_0232F5D4	; 0232FA52
	str r0,[sp,#0x0]	; 0232FA56
	ldr r1,[pool_0232FA94]	; 0232FA58
	str r0,[r1,#0x0]	; 0232FA5A
	cmp r5,#0x0	; 0232FA5C
	bne loc_0232FA6C	; 0232FA5E
	mov r1,#0xb	; 0232FA60
	ldr r0,[pool_0232FA90]	; 0232FA62
	str r1,[r0,#0x14]	; 0232FA64
	bl loc_0232FD98	; 0232FA66
	b loc_0232FA76	; 0232FA6A
loc_0232FA6C:
	mov r1,#0xc	; 0232FA6C
	ldr r0,[pool_0232FA90]	; 0232FA6E
	str r1,[r0,#0x14]	; 0232FA70
	bl loc_0232FD8C	; 0232FA72
loc_0232FA76:
	cmp r0,#0x0	; 0232FA76
	beq loc_0232FA84	; 0232FA78
	mov r0,#0x0	; 0232FA7A
	add sp,#0x4	; 0232FA7C
	pop {r4,r5,r6,r7}	; 0232FA7E
	pop {r3}	; 0232FA80
	bx r3	; 0232FA82
loc_0232FA84:
	mov r0,#0x3	; 0232FA84
	add sp,#0x4	; 0232FA86
	pop {r4,r5,r6,r7}	; 0232FA88
	pop {r3}	; 0232FA8A
	bx r3	; 0232FA8C
	.byte 0xC0, 0x46	; 0232FA90
pool_0232FA90:
loc_0232FA90:
	.word P1_BssStart + 0x2831C	; 0232FA90
pool_0232FA94:
loc_0232FA94:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FA94

; ===== function loc_0232FA98 =====
loc_0232FA98:
	push {lr}	; 0232FA98
	sub sp,#0x4	; 0232FA9A
	ldr r2,[pool_0232FABC]	; 0232FA9C
	mov r3,#0x0	; 0232FA9E
	bl loc_0232FAC4	; 0232FAA0
	ldr r1,[pool_0232FAC0]	; 0232FAA4
	str r0,[r1,#0x20]	; 0232FAA6
	cmp r0,#0x0	; 0232FAA8
	bne loc_0232FAB0	; 0232FAAA
	blx loc_0232F4DC	; 0232FAAC
loc_0232FAB0:
	ldr r0,[pool_0232FAC0]	; 0232FAB0
	ldr r0,[r0,#0x20]	; 0232FAB2
	add sp,#0x4	; 0232FAB4
	pop {r3}	; 0232FAB6
	bx r3	; 0232FAB8
	.byte 0xC0, 0x46	; 0232FABC
pool_0232FABC:
loc_0232FABC:
	.word 0x0232F4F5	; 0232FABC
pool_0232FAC0:
loc_0232FAC0:
	.word P1_BssStart + 0x2831C	; 0232FAC0

; ===== function loc_0232FAC4 =====
loc_0232FAC4:
	push {r4,r5,r6,r7,lr}	; 0232FAC4
	sub sp,#0x4	; 0232FAC6
	add r5,r0,#0x0	; 0232FAC8
	add r4,r1,#0x0	; 0232FACA
	add r6,r2,#0x0	; 0232FACC
	add r7,r3,#0x0	; 0232FACE
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FAD0
	ldr r1,[pool_0232FB2C]	; 0232FAD4
	ldr r2,[r1,#0x0]	; 0232FAD6
	cmp r2,#0x0	; 0232FAD8
	beq loc_0232FAEA	; 0232FADA
	blx P1_Arm9RestoreIrqMask	; 0232FADC
	mov r0,#0x1	; 0232FAE0
	add sp,#0x4	; 0232FAE2
	pop {r4,r5,r6,r7}	; 0232FAE4
	pop {r3}	; 0232FAE6
	bx r3	; 0232FAE8
loc_0232FAEA:
	mov r2,#0x1	; 0232FAEA
	str r2,[r1,#0x0]	; 0232FAEC
	blx P1_Arm9RestoreIrqMask	; 0232FAEE
	cmp r5,#0x0	; 0232FAF2
	bne loc_0232FAFE	; 0232FAF4
	mov r1,#0x9	; 0232FAF6
	ldr r0,[pool_0232FB2C]	; 0232FAF8
	str r1,[r0,#0x14]	; 0232FAFA
	b loc_0232FB04	; 0232FAFC
loc_0232FAFE:
	mov r1,#0xa	; 0232FAFE
	ldr r0,[pool_0232FB2C]	; 0232FB00
	str r1,[r0,#0x14]	; 0232FB02
loc_0232FB04:
	mov r1,#0x0	; 0232FB04
	ldr r0,[pool_0232FB2C]	; 0232FB06
	str r1,[r0,#0x18]	; 0232FB08
	str r4,[r0,#0x8]	; 0232FB0A
	str r6,[r0,#0x4]	; 0232FB0C
	str r7,[r0,#0x10]	; 0232FB0E
	bl loc_0232FD80	; 0232FB10
	cmp r0,#0x0	; 0232FB14
	beq loc_0232FB22	; 0232FB16
	mov r0,#0x0	; 0232FB18
	add sp,#0x4	; 0232FB1A
	pop {r4,r5,r6,r7}	; 0232FB1C
	pop {r3}	; 0232FB1E
	bx r3	; 0232FB20
loc_0232FB22:
	mov r0,#0x3	; 0232FB22
	add sp,#0x4	; 0232FB24
	pop {r4,r5,r6,r7}	; 0232FB26
	pop {r3}	; 0232FB28
	bx r3	; 0232FB2A
pool_0232FB2C:
loc_0232FB2C:
	.word P1_BssStart + 0x2831C	; 0232FB2C

; ===== function loc_0232FB30 =====
loc_0232FB30:
	ldr r1,[pool_0232FB38]	; 0232FB30
	str r0,[r1,#0x1c]	; 0232FB32
	bx lr	; 0232FB34
	.byte 0xC0, 0x46	; 0232FB38
pool_0232FB38:
loc_0232FB38:
	.word P1_BssStart + 0x2831C	; 0232FB38

; ===== function loc_0232FB3C =====
loc_0232FB3C:
	push {lr}	; 0232FB3C
	sub sp,#0x4	; 0232FB3E
	ldr r1,[pool_0232FB60]	; 0232FB40
	mov r2,#0x0	; 0232FB42
	bl loc_0232FB68	; 0232FB44
	ldr r1,[pool_0232FB64]	; 0232FB48
	str r0,[r1,#0x20]	; 0232FB4A
	cmp r0,#0x0	; 0232FB4C
	bne loc_0232FB54	; 0232FB4E
	blx loc_0232F4DC	; 0232FB50
loc_0232FB54:
	ldr r0,[pool_0232FB64]	; 0232FB54
	ldr r0,[r0,#0x20]	; 0232FB56
	add sp,#0x4	; 0232FB58
	pop {r3}	; 0232FB5A
	bx r3	; 0232FB5C
	.byte 0xC0, 0x46	; 0232FB60
pool_0232FB60:
loc_0232FB60:
	.word 0x0232F4F5	; 0232FB60
pool_0232FB64:
loc_0232FB64:
	.word P1_BssStart + 0x2831C	; 0232FB64

; ===== function loc_0232FB68 =====
loc_0232FB68:
	push {r4,r5,lr}	; 0232FB68
	sub sp,#0x4	; 0232FB6A
	add r5,r1,#0x0	; 0232FB6C
	add r4,r2,#0x0	; 0232FB6E
	ldrb r1,[r0,#0x0]	; 0232FB70
	ldr r0,[pool_0232FBC4]	; 0232FB72
	strb r1,[r0,#0x0]	; 0232FB74
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FB76
	ldr r1,[pool_0232FBC8]	; 0232FB7A
	ldr r2,[r1,#0x0]	; 0232FB7C
	cmp r2,#0x0	; 0232FB7E
	beq loc_0232FB90	; 0232FB80
	blx P1_Arm9RestoreIrqMask	; 0232FB82
	mov r0,#0x1	; 0232FB86
	add sp,#0x4	; 0232FB88
	pop {r4,r5}	; 0232FB8A
	pop {r3}	; 0232FB8C
	bx r3	; 0232FB8E
loc_0232FB90:
	mov r2,#0x1	; 0232FB90
	str r2,[r1,#0x0]	; 0232FB92
	blx P1_Arm9RestoreIrqMask	; 0232FB94
	mov r1,#0xf	; 0232FB98
	ldr r0,[pool_0232FBC8]	; 0232FB9A
	str r1,[r0,#0x14]	; 0232FB9C
	mov r1,#0x0	; 0232FB9E
	str r1,[r0,#0x18]	; 0232FBA0
	str r5,[r0,#0x4]	; 0232FBA2
	str r4,[r0,#0x10]	; 0232FBA4
	bl loc_0232FD68	; 0232FBA6
	cmp r0,#0x0	; 0232FBAA
	beq loc_0232FBB8	; 0232FBAC
	mov r0,#0x0	; 0232FBAE
	add sp,#0x4	; 0232FBB0
	pop {r4,r5}	; 0232FBB2
	pop {r3}	; 0232FBB4
	bx r3	; 0232FBB6
loc_0232FBB8:
	mov r0,#0x3	; 0232FBB8
	add sp,#0x4	; 0232FBBA
	pop {r4,r5}	; 0232FBBC
	pop {r3}	; 0232FBBE
	bx r3	; 0232FBC0
	.byte 0xC0, 0x46	; 0232FBC4
pool_0232FBC4:
loc_0232FBC4:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FBC4
pool_0232FBC8:
loc_0232FBC8:
	.word P1_BssStart + 0x2831C	; 0232FBC8

; ===== function loc_0232FBCC =====
P1_Entry_0232FBCC:
	push {lr}	; 0232FBCC
	sub sp,#0x4	; 0232FBCE
	ldr r2,[pool_0232FBF0]	; 0232FBD0
	mov r3,#0x0	; 0232FBD2
	bl loc_0232FBF8	; 0232FBD4
	ldr r1,[pool_0232FBF4]	; 0232FBD8
	str r0,[r1,#0x20]	; 0232FBDA
	cmp r0,#0x0	; 0232FBDC
	bne loc_0232FBE4	; 0232FBDE
	blx loc_0232F4DC	; 0232FBE0
loc_0232FBE4:
	ldr r0,[pool_0232FBF4]	; 0232FBE4
	ldr r0,[r0,#0x20]	; 0232FBE6
	add sp,#0x4	; 0232FBE8
	pop {r3}	; 0232FBEA
	bx r3	; 0232FBEC
	.byte 0xC0, 0x46	; 0232FBF0
pool_0232FBF0:
loc_0232FBF0:
	.word 0x0232F4F5	; 0232FBF0
pool_0232FBF4:
loc_0232FBF4:
	.word P1_BssStart + 0x2831C	; 0232FBF4

; ===== function loc_0232FBF8 =====
loc_0232FBF8:
	push {r4,r5,r6,lr}	; 0232FBF8
	add r6,r1,#0x0	; 0232FBFA
	add r5,r2,#0x0	; 0232FBFC
	add r4,r3,#0x0	; 0232FBFE
	ldr r1,[pool_0232FC54]	; 0232FC00
	bl loc_0232F570	; 0232FC02
	add r0,r6,#0x0	; 0232FC06
	ldr r1,[pool_0232FC58]	; 0232FC08
	bl loc_0232F500	; 0232FC0A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FC0E
	ldr r1,[pool_0232FC5C]	; 0232FC12
	ldr r2,[r1,#0x0]	; 0232FC14
	cmp r2,#0x0	; 0232FC16
	beq loc_0232FC26	; 0232FC18
	blx P1_Arm9RestoreIrqMask	; 0232FC1A
	mov r0,#0x1	; 0232FC1E
	pop {r4,r5,r6}	; 0232FC20
	pop {r3}	; 0232FC22
	bx r3	; 0232FC24
loc_0232FC26:
	mov r2,#0x1	; 0232FC26
	str r2,[r1,#0x0]	; 0232FC28
	blx P1_Arm9RestoreIrqMask	; 0232FC2A
	mov r1,#0x5	; 0232FC2E
	ldr r0,[pool_0232FC5C]	; 0232FC30
	str r1,[r0,#0x14]	; 0232FC32
	mov r1,#0x0	; 0232FC34
	str r1,[r0,#0x18]	; 0232FC36
	str r5,[r0,#0x4]	; 0232FC38
	str r4,[r0,#0x10]	; 0232FC3A
	bl loc_0232FDA4	; 0232FC3C
	cmp r0,#0x0	; 0232FC40
	beq loc_0232FC4C	; 0232FC42
	mov r0,#0x0	; 0232FC44
	pop {r4,r5,r6}	; 0232FC46
	pop {r3}	; 0232FC48
	bx r3	; 0232FC4A
loc_0232FC4C:
	mov r0,#0x3	; 0232FC4C
	pop {r4,r5,r6}	; 0232FC4E
	pop {r3}	; 0232FC50
	bx r3	; 0232FC52
pool_0232FC54:
loc_0232FC54:
	.word 0x027FFDE8	; 0232FC54
pool_0232FC58:
loc_0232FC58:
	.word 0x027FFDEC	; 0232FC58
pool_0232FC5C:
loc_0232FC5C:
	.word P1_BssStart + 0x2831C	; 0232FC5C

; ===== function loc_0232FC60 =====
loc_0232FC60:
	push {lr}	; 0232FC60
	sub sp,#0x4	; 0232FC62
	ldr r2,[pool_0232FC84]	; 0232FC64
	mov r3,#0x0	; 0232FC66
	bl loc_0232FC8C	; 0232FC68
	ldr r1,[pool_0232FC88]	; 0232FC6C
	str r0,[r1,#0x20]	; 0232FC6E
	cmp r0,#0x0	; 0232FC70
	bne loc_0232FC78	; 0232FC72
	blx loc_0232F4DC	; 0232FC74
loc_0232FC78:
	ldr r0,[pool_0232FC88]	; 0232FC78
	ldr r0,[r0,#0x20]	; 0232FC7A
	add sp,#0x4	; 0232FC7C
	pop {r3}	; 0232FC7E
	bx r3	; 0232FC80
	.byte 0xC0, 0x46	; 0232FC84
pool_0232FC84:
loc_0232FC84:
	.word 0x0232F4F5	; 0232FC84
pool_0232FC88:
loc_0232FC88:
	.word P1_BssStart + 0x2831C	; 0232FC88

; ===== function loc_0232FC8C =====
loc_0232FC8C:
	push {r4,r5,r6,r7,lr}	; 0232FC8C
	sub sp,#0x4	; 0232FC8E
	add r5,r0,#0x0	; 0232FC90
	add r4,r1,#0x0	; 0232FC92
	add r6,r2,#0x0	; 0232FC94
	add r7,r3,#0x0	; 0232FC96
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FC98
	ldr r1,[pool_0232FCE8]	; 0232FC9C
	ldr r2,[r1,#0x0]	; 0232FC9E
	cmp r2,#0x0	; 0232FCA0
	beq loc_0232FCB2	; 0232FCA2
	blx P1_Arm9RestoreIrqMask	; 0232FCA4
	mov r0,#0x1	; 0232FCA8
	add sp,#0x4	; 0232FCAA
	pop {r4,r5,r6,r7}	; 0232FCAC
	pop {r3}	; 0232FCAE
	bx r3	; 0232FCB0
loc_0232FCB2:
	mov r2,#0x1	; 0232FCB2
	str r2,[r1,#0x0]	; 0232FCB4
	blx P1_Arm9RestoreIrqMask	; 0232FCB6
	mov r1,#0x2	; 0232FCBA
	ldr r0,[pool_0232FCE8]	; 0232FCBC
	str r1,[r0,#0x14]	; 0232FCBE
	mov r1,#0x0	; 0232FCC0
	str r1,[r0,#0x18]	; 0232FCC2
	str r5,[r0,#0x8]	; 0232FCC4
	str r4,[r0,#0xc]	; 0232FCC6
	str r6,[r0,#0x4]	; 0232FCC8
	str r7,[r0,#0x10]	; 0232FCCA
	bl loc_0232FDB0	; 0232FCCC
	cmp r0,#0x0	; 0232FCD0
	beq loc_0232FCDE	; 0232FCD2
	mov r0,#0x0	; 0232FCD4
	add sp,#0x4	; 0232FCD6
	pop {r4,r5,r6,r7}	; 0232FCD8
	pop {r3}	; 0232FCDA
	bx r3	; 0232FCDC
loc_0232FCDE:
	mov r0,#0x3	; 0232FCDE
	add sp,#0x4	; 0232FCE0
	pop {r4,r5,r6,r7}	; 0232FCE2
	pop {r3}	; 0232FCE4
	bx r3	; 0232FCE6
pool_0232FCE8:
loc_0232FCE8:
	.word P1_BssStart + 0x2831C	; 0232FCE8

; ===== function loc_0232FCEC =====
loc_0232FCEC:
	push {r4,r5,lr}	; 0232FCEC
	sub sp,#0x4	; 0232FCEE
	ldr r0,[pool_0232FD30]	; 0232FCF0
	ldrh r1,[r0,#0x0]	; 0232FCF2
	cmp r1,#0x0	; 0232FCF4
	bne loc_0232FD26	; 0232FCF6
	mov r1,#0x1	; 0232FCF8
	strh r1,[r0,#0x0]	; 0232FCFA
	mov r1,#0x0	; 0232FCFC
	ldr r0,[pool_0232FD34]	; 0232FCFE
	str r1,[r0,#0x0]	; 0232FD00
	str r1,[r0,#0x4]	; 0232FD02
	str r1,[r0,#0x1c]	; 0232FD04
	str r1,[r0,#0x8]	; 0232FD06
	str r1,[r0,#0xc]	; 0232FD08
	bl loc_0232E728	; 0232FD0A
	mov r5,#0x5	; 0232FD0E
	mov r4,#0x1	; 0232FD10
loc_0232FD12:
	add r0,r5,#0x0	; 0232FD12
	add r1,r4,#0x0	; 0232FD14
	bl loc_0232E89C	; 0232FD16
	cmp r0,#0x0	; 0232FD1A
	beq loc_0232FD12	; 0232FD1C
	mov r0,#0x5	; 0232FD1E
	ldr r1,[pool_0232FD38]	; 0232FD20
	bl P1_SetPxiReceiveCallback	; 0232FD22
loc_0232FD26:
	add sp,#0x4	; 0232FD26
	pop {r4,r5}	; 0232FD28
	pop {r3}	; 0232FD2A
	bx r3	; 0232FD2C
	.byte 0xC0, 0x46	; 0232FD30
pool_0232FD30:
loc_0232FD30:
	.word P1_BssStart + 0x28318	; 0232FD30
pool_0232FD34:
loc_0232FD34:
	.word P1_BssStart + 0x2831C	; 0232FD34
pool_0232FD38:
loc_0232FD38:
	.word P1_PxiCallback_0232F704 + 1	; 0232FD38
loc_0232FD3C:
	push {lr}	; 0232FD3C
	sub sp,#0x4	; 0232FD3E
	add r1,r0,#0x0	; 0232FD40
	mov r0,#0x5	; 0232FD42
	lsl r1,r1,#0x8	; 0232FD44
	ldr r2,[pool_0232FD64]	; 0232FD46
	and r1,r2	; 0232FD48
	mov r2,#0x0	; 0232FD4A
	bl loc_0232E808	; 0232FD4C
	cmp r0,#0x0	; 0232FD50
	blt loc_0232FD5C	; 0232FD52
	mov r0,#0x1	; 0232FD54
	add sp,#0x4	; 0232FD56
	pop {r3}	; 0232FD58
	bx r3	; 0232FD5A
loc_0232FD5C:
	mov r0,#0x0	; 0232FD5C
	add sp,#0x4	; 0232FD5E
	pop {r3}	; 0232FD60
	bx r3	; 0232FD62
pool_0232FD64:
loc_0232FD64:
	.word 0x00007F00	; 0232FD64

; ===== function loc_0232FD68 =====
loc_0232FD68:
	mov r0,#0x28	; 0232FD68
	ldr r3,[pool_0232FD70]	; 0232FD6A
	bx r3	; 0232FD6C
	.byte 0xC0, 0x46	; 0232FD70
pool_0232FD70:
loc_0232FD70:
	.word loc_0232FD3C + 1	; 0232FD70

; ===== function loc_0232FD74 =====
loc_0232FD74:
	mov r0,#0x27	; 0232FD74
	ldr r3,[pool_0232FD7C]	; 0232FD76
	bx r3	; 0232FD78
	.byte 0xC0, 0x46	; 0232FD7C
pool_0232FD7C:
loc_0232FD7C:
	.word loc_0232FD3C + 1	; 0232FD7C

; ===== function loc_0232FD80 =====
loc_0232FD80:
	mov r0,#0x17	; 0232FD80
	ldr r3,[pool_0232FD88]	; 0232FD82
	bx r3	; 0232FD84
	.byte 0xC0, 0x46	; 0232FD88
pool_0232FD88:
loc_0232FD88:
	.word loc_0232FD3C + 1	; 0232FD88

; ===== function loc_0232FD8C =====
loc_0232FD8C:
	mov r0,#0x25	; 0232FD8C
	ldr r3,[pool_0232FD94]	; 0232FD8E
	bx r3	; 0232FD90
	.byte 0xC0, 0x46	; 0232FD94
pool_0232FD94:
loc_0232FD94:
	.word loc_0232FD3C + 1	; 0232FD94

; ===== function loc_0232FD98 =====
loc_0232FD98:
	mov r0,#0x24	; 0232FD98
	ldr r3,[pool_0232FDA0]	; 0232FD9A
	bx r3	; 0232FD9C
	.byte 0xC0, 0x46	; 0232FDA0
pool_0232FDA0:
loc_0232FDA0:
	.word loc_0232FD3C + 1	; 0232FDA0

; ===== function loc_0232FDA4 =====
loc_0232FDA4:
	mov r0,#0x20	; 0232FDA4
	ldr r3,[pool_0232FDAC]	; 0232FDA6
	bx r3	; 0232FDA8
	.byte 0xC0, 0x46	; 0232FDAC
pool_0232FDAC:
loc_0232FDAC:
	.word loc_0232FD3C + 1	; 0232FDAC

; ===== function loc_0232FDB0 =====
loc_0232FDB0:
	mov r0,#0x10	; 0232FDB0
	ldr r3,[pool_0232FDB8]	; 0232FDB2
	bx r3	; 0232FDB4
	.byte 0xC0, 0x46	; 0232FDB8
pool_0232FDB8:
loc_0232FDB8:
	.word loc_0232FD3C + 1	; 0232FDB8
	.byte 0x2D, 0xD1, 0x32, 0x02, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00, 0x4D, 0x3D, 0x36, 0x02	; 0232FDCC
	.byte 0xE9, 0x77, 0x36, 0x02, 0x01, 0x8D, 0x35, 0x02	; 0232FDCC
P1_Data_0232FDD4:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FDD4
P1_Data_0232FDDC:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FDDC
P1_Data_0232FDE4:
	.byte 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 0232FDE4
	.byte 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x05, 0x00, 0x04, 0x00	; 0232FDFC
	.byte 0x01, 0x00, 0x03, 0x00, 0x02, 0x00, 0x05, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00	; 0232FE0C
	.byte 0x05, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00	; 0232FE0C
P1_Data_0232FE14:
	.byte 0x09, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00	; 0232FE14
	.byte 0x0B, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00	; 0232FE1C
P1_Data_0232FE24:
	.byte 0x05, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00	; 0232FE24
	.byte 0x04, 0x00, 0x00, 0x00, 0x06, 0x00, 0x07, 0x00, 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00	; 0232FE3C
	.byte 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00	; 0232FE4C
	.byte 0x00, 0x00, 0x54, 0x00, 0x06, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00	; 0232FE5C
	.byte 0x00, 0x00, 0x30, 0x00, 0x02, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 0232FE6C
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x34, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00	; 0232FE7C
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x2C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0232FE8C
	.byte 0x00, 0x00, 0xD0, 0xFF, 0x03, 0x00, 0x00, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FE9C
	.byte 0x00, 0x70, 0x07, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x08, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0232FEAC
	.byte 0x00, 0x80, 0x08, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x07, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 0232FEBC
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x07, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x07, 0x00	; 0232FECC
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x0A, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x0A, 0x00	; 0232FEDC
	.byte 0x00, 0x60, 0x08, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x04, 0x00	; 0232FEEC
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x08, 0x00, 0x00, 0x10, 0x07, 0x00	; 0232FEFC
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x07, 0x00, 0x00, 0xE0, 0x04, 0x00	; 0232FF0C
	.byte 0x00, 0x90, 0x07, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x07, 0x00	; 0232FF1C
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x01, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x01, 0x00	; 0232FF2C
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x04, 0x00	; 0232FF3C
	.byte 0x00, 0x80, 0x0E, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x90, 0x0F, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0232FF4C
	.byte 0x00, 0x90, 0x0F, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x80, 0x0E, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 0232FF5C
	.byte 0x00, 0x70, 0x00, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0232FF6C
	.byte 0x00, 0x80, 0x01, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 0232FF7C
	.byte 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00	; 0232FF8C
P1_Data_0232FF8C:
	.byte 0x0A, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00	; 0232FF8C
	.byte 0x06, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00	; 0232FFAC
	.byte 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FFAC
P1_Data_0232FFB4:
	.byte 0x00, 0x00	; 0232FFB4
P1_Data_0232FFB6:
	.byte 0x95, 0x00	; 0232FFB6
P1_Data_0232FFB8:
	.byte 0x7F, 0x00, 0x00, 0x00	; 0232FFB8
	.byte 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x02, 0x00, 0x8A, 0x00, 0x74, 0x00, 0x0E, 0x00, 0x01, 0x00	; 0232FFCC
	.byte 0x00, 0x00, 0x06, 0x00, 0x02, 0x00, 0x91, 0x00, 0x7B, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x00, 0x00	; 0232FFDC
	.byte 0x09, 0x00, 0x02, 0x00, 0x86, 0x00, 0x70, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00	; 0232FFEC
	.byte 0x02, 0x00, 0x8F, 0x00, 0x79, 0x00, 0x0E, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00	; 0232FFFC
	.byte 0x8B, 0x00, 0x75, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x05, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8D, 0x00	; 0233000C
	.byte 0x77, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x06, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8C, 0x00, 0x76, 0x00	; 0233001C
	.byte 0x0E, 0x00, 0x01, 0x00, 0x07, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8E, 0x00, 0x78, 0x00, 0x0E, 0x00	; 0233002C
	.byte 0x01, 0x00, 0x08, 0x00, 0x06, 0x00, 0x03, 0x00, 0x92, 0x00, 0x7C, 0x00, 0x0E, 0x00, 0x02, 0x00	; 0233003C
	.byte 0x09, 0x00, 0x09, 0x00, 0x03, 0x00, 0x93, 0x00, 0x7D, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0A, 0x00	; 0233004C
	.byte 0x09, 0x00, 0x03, 0x00, 0x94, 0x00, 0x7E, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0B, 0x00, 0x09, 0x00	; 0233005C
	.byte 0x03, 0x00, 0x88, 0x00, 0x72, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x03, 0x00	; 0233006C
	.byte 0x89, 0x00, 0x73, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x0D, 0x00, 0x0C, 0x00, 0x01, 0x00, 0x90, 0x00	; 0233007C
	.byte 0x7A, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x85, 0x00, 0x6F, 0x00	; 0233008C
	.byte 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x03, 0x00, 0x87, 0x00, 0x71, 0x00, 0x0E, 0x00	; 0233009C
	.byte 0x03, 0x00, 0x10, 0x00, 0x0C, 0x00, 0x02, 0x00, 0x85, 0x00, 0x6F, 0x00, 0x0F, 0x00, 0x11, 0x00	; 023300AC
	.byte 0x00, 0x00, 0xFF, 0xFF	; 023300AC
P1_Data_023300B0:
	.byte 0x00, 0x00, 0x60, 0x00	; 023300B0
P1_Data_023300B4:
	.byte 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00	; 023300B4
P1_Data_023300BC:
	.byte 0x03, 0x00, 0x24, 0x00	; 023300BC
P1_Data_023300C0:
	.byte 0x01, 0x00	; 023300C0
P1_Data_023300C2:
	.byte 0x01, 0x00, 0x02, 0x00, 0x2B, 0x00, 0x00, 0x00, 0x02, 0x00	; 023300C2
P1_Data_023300CC:
	.byte 0x30, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00	; 023300CC
	.byte 0x38, 0x00, 0x39, 0x00, 0x00, 0x00, 0x00, 0x00	; 023300DC
P1_Data_023300E4:
	.byte 0x03, 0x03, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00	; 023300E4
	.byte 0xFF, 0x0F, 0xFF, 0x0F, 0xC7, 0x01, 0x00, 0x00, 0x75, 0x85, 0x32, 0x02, 0x71, 0x85, 0x32, 0x02	; 023300FC
	.byte 0x6D, 0x85, 0x32, 0x02, 0x00, 0x00, 0x00, 0x00, 0x69, 0x85, 0x32, 0x02, 0x24, 0xD4, 0x00, 0x00	; 0233010C
	.byte 0x0F, 0x40, 0x00, 0x00, 0x00, 0x01, 0x81, 0x82, 0x82, 0x83, 0x0F, 0x83, 0x0C, 0xC3, 0x03, 0x83	; 0233011C
	.byte 0x01, 0x83, 0x04, 0xC3, 0x08, 0x0E, 0x02, 0xC2, 0x0D, 0xC2, 0x07, 0x0B, 0x06, 0x0A, 0x05, 0x09	; 0233012C
.arm
	b loc_023301A8	; 0233012C
	.byte 0x00, 0x40, 0x2D, 0xE9, 0x68, 0x30, 0x9F, 0xE5, 0x10, 0x00, 0x93, 0xE5, 0x20, 0x10, 0x93, 0xE5	; 02330140
	.byte 0x18, 0x10, 0x80, 0xE5, 0x14, 0x00, 0x93, 0xE5, 0x28, 0x10, 0x90, 0xE5, 0x01, 0x12, 0x81, 0xE3	; 02330150
	.byte 0x28, 0x10, 0x80, 0xE5, 0x44, 0x10, 0x9F, 0xE5, 0xFC, 0x10, 0x80, 0xE5, 0x28, 0x20, 0xA0, 0xE3	; 02330160
	.byte 0x3C, 0x10, 0x80, 0xE2, 0x0C, 0x00, 0x8F, 0xE2, 0x08, 0x30, 0x93, 0xE5, 0x33, 0xFF, 0x2F, 0xE1	; 02330170
	.byte 0x00, 0x40, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1, 0x00, 0x50, 0xA0, 0xE3, 0x00, 0xC0, 0x97, 0xE5	; 02330180
	.byte 0x66, 0x00, 0x5C, 0xE3, 0xEA, 0x40, 0xA0, 0x03, 0x29, 0x40, 0x4F, 0x05, 0x15, 0x5F, 0x07, 0x0E	; 02330190
	.byte 0x07, 0xC0, 0x0C, 0xE2, 0x00, 0x30, 0x9F, 0xE5, 0x02, 0x00, 0x00, 0xEA, 0x00, 0x52, 0x00, 0x02	; 023301A0
	.byte 0xFE, 0xFF, 0xFF, 0xEA, 0x8C, 0x52, 0x00, 0x02	; 023301A8
loc_023301A8:
	stmdb sp!,{r4,r7,lr}	; 023301A8
	ldr r7,[pool_02330220]	; 023301AC
	cmp r0,#0x0	; 023301B0
	bne loc_02330210	; 023301B4
	ldr r0,[r7,#0x1c]	; 023301B8
	ldr r1,[pool_02330224]	; 023301BC
	mov r2,#0x40	; 023301C0
	ldr r4,[r7,#0x8]	; 023301C4
	blx r4	; 023301C8
	mov r1,#0x40	; 023301CC
	str r1,[sp,#-0x4]!	; 023301D0
	ldr r0,[pool_02330228]	; 023301D4
	mov r1,r6	; 023301D8
	mov r2,r5	; 023301DC
	ldr r3,[pool_02330224]	; 023301E0
	ldr r4,[r7,#0xc]	; 023301E4
	blx r4	; 023301E8
	add sp,sp,#0x4	; 023301EC
	ldr r0,[pool_02330228]	; 023301F0
	sub r1,r7,#0x28	; 023301F4
	mov r2,#0x14	; 023301F8
	ldr r4,[r7,#0x18]	; 023301FC
	blx r4	; 02330200
	cmp r0,#0x0	; 02330204
	ldrne r4,[r7,#0x0]	; 02330208
	blxne r4	; 0233020C
loc_02330210:
	ldr r4,[r7,#0x4]	; 02330210
	blx r4	; 02330214
	ldmia sp!,{r4,r7,lr}	; 02330218
	bx lr	; 0233021C
pool_02330220:
loc_02330220:
	.word 0x0200528C	; 02330220
pool_02330224:
loc_02330224:
	.word 0x02005114	; 02330224
pool_02330228:
loc_02330228:
	.word 0x02005100	; 02330228
	.byte 0x8A, 0xE8, 0xA7, 0xC0, 0xA0, 0x85, 0x06, 0x81, 0x0D, 0x5F, 0x93, 0xBB, 0x74, 0x28, 0x62, 0xAB	; 0233023C
	.byte 0x99, 0xA8, 0x19, 0x6D, 0xEB, 0x0E, 0x4A, 0xA4, 0x94, 0xFF, 0xF0, 0x94, 0x71, 0x1A, 0xE1, 0xA3	; 0233024C
	.byte 0x1D, 0x90, 0x22, 0xA0, 0x8D, 0x79, 0xE5, 0x31, 0x85, 0x27, 0xF6, 0x31, 0x5B, 0xD0, 0xC0, 0xC5	; 0233025C
	.byte 0x21, 0x8C, 0x79, 0x7C, 0x14, 0x3B, 0x14, 0xE8, 0x07, 0x98, 0x32, 0xB8, 0x79, 0x49, 0xC6, 0x09	; 0233026C
	.byte 0xEE, 0xB5, 0x64, 0x4F, 0x42, 0xFA, 0x34, 0x00, 0x6D, 0x3D, 0x58, 0xD4, 0xA0, 0x2B, 0x45, 0xB4	; 0233027C
	.byte 0x09, 0xD8, 0xF5, 0x25, 0x9C, 0x89, 0xB7, 0x0C, 0x5A, 0x5D, 0x7A, 0x19, 0xD0, 0x21, 0x6B, 0x6B	; 0233028C
	.byte 0xF9, 0xBE, 0xEB, 0x67, 0x71, 0x05, 0x5F, 0xBE, 0xA5, 0x27, 0x47, 0x3C, 0xF7, 0x8C, 0xFB, 0xD2	; 0233029C
	.byte 0x90, 0x35, 0xBB, 0x30, 0x64, 0x28, 0xBD, 0xF7, 0x8C, 0x81, 0x31, 0x98, 0xA3, 0x3E, 0x3B, 0xC7	; 023302AC
	.byte 0x9B, 0x98, 0x2C, 0x23, 0x65, 0x05, 0x37, 0xC8, 0x17, 0xD1, 0x1B, 0x22, 0xEC, 0x95, 0x01, 0x02	; 023302BC
	.byte 0xA4, 0x82, 0x05, 0x02, 0xA4, 0x8B, 0x05, 0x02, 0x08, 0xC6, 0x05, 0x02, 0x10, 0xC1, 0x05, 0x02	; 023302CC
	.byte 0xD8, 0xC2, 0x05, 0x02, 0x38, 0xC7, 0x06, 0x02, 0xEC, 0x49, 0x08, 0x02, 0xB4, 0xA3, 0xFE, 0xEB	; 023302DC
	.byte 0x84, 0x01, 0x00, 0xEA, 0xEC, 0x49, 0x00, 0x02, 0x9E, 0x11, 0x7F, 0xD6, 0x1D, 0x1A, 0xE6, 0xED	; 023302EC
	.byte 0xC5, 0xD6, 0x55, 0xC6, 0x35, 0x4E, 0x06, 0x76, 0x7B, 0x1C, 0x7C, 0x83, 0x35, 0xF2, 0x43, 0x1B	; 023302FC
	.byte 0x69, 0xFE, 0x8E, 0x59, 0xFD, 0xD5, 0x0C, 0x75, 0x59, 0x0D, 0x9C, 0x9E, 0x09, 0x95, 0xB6, 0xA7	; 0233030C
	.byte 0x92, 0xA7, 0xB9, 0x90, 0x38, 0xF7, 0x63, 0xB9, 0xF7, 0x27, 0xB5, 0xE2, 0x64, 0xF4, 0x1E, 0x67	; 0233031C
	.byte 0x30, 0x15, 0x2B, 0xD7, 0xF1, 0x9A, 0xC8, 0xAC, 0x5F, 0x7C, 0x36, 0x03, 0x94, 0x65, 0x73, 0x15	; 0233032C
	.byte 0xA3, 0xD8, 0x66, 0xED, 0x42, 0xB0, 0xD3, 0x19, 0x04, 0x54, 0x11, 0x58, 0xCC, 0x19, 0x46, 0xA8	; 0233033C
	.byte 0xE4, 0xAC, 0x6D, 0xD3, 0xD6, 0x59, 0xF2, 0x3E, 0xF8, 0x49, 0x50, 0xE9, 0x29, 0x15, 0xDC, 0xE1	; 0233034C
	.byte 0xA5, 0xDE, 0x59, 0x01, 0x17, 0xFF, 0xA3, 0x35, 0x63, 0x27, 0x56, 0xC1, 0x5D, 0x36, 0x9A, 0x18	; 0233035C
	.byte 0x89, 0xE2, 0xB3, 0x93, 0xA8, 0x8B, 0x1E, 0xE8, 0x6A, 0x0D, 0x57, 0x65, 0xD0, 0x8A, 0xFB, 0xEB	; 0233036C
	.byte 0x50, 0x1D, 0x04, 0x6D, 0x78, 0x95, 0x01, 0x02, 0x90, 0x7D, 0x05, 0x02, 0x90, 0x86, 0x05, 0x02	; 0233037C
	.byte 0xF4, 0xC0, 0x05, 0x02, 0xFC, 0xBB, 0x05, 0x02, 0xC4, 0xBD, 0x05, 0x02, 0xE4, 0xC1, 0x06, 0x02	; 0233038C
	.byte 0x48, 0x44, 0x08, 0x02, 0xF9, 0xA4, 0xFE, 0xEB, 0x84, 0x01, 0x00, 0xEA, 0xEC, 0x49, 0x00, 0x02	; 0233039C
; ASCII VIB build identifier with the embedded build date. / 含内嵌构建日期的 ASCII VIB 构建标识。
P1_VibBuildIdentifier:
	.ascii "VIB2.11Feb 28 2005", 0
	.byte 0x00	; 023303AF
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P1_CrtDataInitTable:
	.word P1_CopyDescriptors, P1_CopyDescriptorsEnd
	.word P1_ItcmLoadStart
	.word P1_BssStart, P3_FirmwareUiEntry
	.byte 0x2D, 0xFD, 0x5B, 0xFE, 0x97, 0xFE, 0xBB, 0xFE, 0xD4, 0xFE, 0xE7, 0xFE, 0xF7, 0xFE, 0x04, 0xFF	; 023303C4
	.byte 0x10, 0xFF, 0x1A, 0xFF, 0x23, 0xFF, 0x2C, 0xFF, 0x33, 0xFF, 0x3A, 0xFF, 0x40, 0xFF, 0x46, 0xFF	; 023303D4
	.byte 0x4C, 0xFF, 0x51, 0xFF, 0x56, 0xFF, 0x5B, 0xFF, 0x5F, 0xFF, 0x64, 0xFF, 0x68, 0xFF, 0x6C, 0xFF	; 023303E4
	.byte 0x6F, 0xFF, 0x73, 0xFF, 0x76, 0xFF, 0x7A, 0xFF, 0x7D, 0xFF, 0x80, 0xFF, 0x83, 0xFF, 0x86, 0xFF	; 023303F4
	.byte 0x88, 0xFF, 0x8B, 0xFF, 0x8E, 0xFF, 0x90, 0xFF, 0x92, 0xFF, 0x95, 0xFF, 0x97, 0xFF, 0x99, 0xFF	; 02330404
	.byte 0x9C, 0xFF, 0x9E, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA4, 0xFF, 0xA6, 0xFF, 0xA8, 0xFF, 0xAA, 0xFF	; 02330414
	.byte 0xAB, 0xFF, 0xAD, 0xFF, 0xAF, 0xFF, 0xB1, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB7, 0xFF	; 02330424
	.byte 0xB9, 0xFF, 0xBA, 0xFF, 0xBC, 0xFF, 0xBD, 0xFF, 0xBF, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC3, 0xFF	; 02330434
	.byte 0xC4, 0xFF, 0xC6, 0xFF, 0xC7, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF, 0xCB, 0xFF, 0xCC, 0xFF, 0xCD, 0xFF	; 02330444
	.byte 0xCF, 0xFF, 0xD0, 0xFF, 0xD1, 0xFF, 0xD2, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD7, 0xFF	; 02330454
	.byte 0xD8, 0xFF, 0xD9, 0xFF, 0xDA, 0xFF, 0xDB, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDE, 0xFF, 0xDF, 0xFF	; 02330464
	.byte 0xE0, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE3, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF, 0xE6, 0xFF, 0xE7, 0xFF	; 02330474
	.byte 0xE8, 0xFF, 0xE9, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEB, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEE, 0xFF	; 02330484
	.byte 0xEF, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF1, 0xFF, 0xF2, 0xFF, 0xF3, 0xFF, 0xF4, 0xFF, 0xF4, 0xFF	; 02330494
	.byte 0xF5, 0xFF, 0xF6, 0xFF, 0xF7, 0xFF, 0xF7, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFA, 0xFF	; 023304A4
	.byte 0xFB, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF, 0xFD, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00	; 023304B4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023304C4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023304D4
P1_Data_023304E0:
	.byte 0x00, 0x00, 0xAA, 0x01	; 023304E0
	.byte 0x50, 0x03, 0xED, 0x04, 0x82, 0x06, 0xFE, 0x07, 0x65, 0x09, 0xB1, 0x0A, 0xE3, 0x0B, 0xF0, 0x0C	; 023304E4
	.byte 0xD9, 0x0D, 0x9B, 0x0E, 0x37, 0x0F, 0xA6, 0x0F, 0xE9, 0x0F, 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F	; 023304F4
	.byte 0x39, 0x0F, 0xA1, 0x0E, 0xDC, 0x0D, 0xF4, 0x0C, 0xE8, 0x0B, 0xBA, 0x0A, 0x6A, 0x09, 0x04, 0x08	; 02330504
	.byte 0x87, 0x06, 0xF9, 0x04, 0x56, 0x03, 0xB1, 0x01, 0x06, 0x00, 0x5C, 0xFE, 0xB0, 0xFC, 0x13, 0xFB	; 02330514
	.byte 0x84, 0xF9, 0x07, 0xF8, 0x9B, 0xF6, 0x4F, 0xF5, 0x21, 0xF4, 0x13, 0xF3, 0x27, 0xF2, 0x65, 0xF1	; 02330524
	.byte 0xCB, 0xF0, 0x5B, 0xF0, 0x17, 0xF0, 0x00, 0xF0, 0x16, 0xF0, 0x58, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1	; 02330534
	.byte 0x21, 0xF2, 0x08, 0xF3, 0x18, 0xF4, 0x46, 0xF5, 0x91, 0xF6, 0xF7, 0xF7, 0x79, 0xF9, 0x07, 0xFB	; 02330544
	.byte 0xA3, 0xFC, 0x49, 0xFE	; 02330554
P1_Data_02330558:
	.byte 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F, 0x39, 0x0F, 0x9E, 0x0E, 0xDC, 0x0D	; 02330558
	.byte 0xF4, 0x0C, 0xE8, 0x0B, 0xB5, 0x0A, 0x6A, 0x09, 0x04, 0x08, 0x87, 0x06, 0xF3, 0x04, 0x56, 0x03	; 02330564
	.byte 0xB1, 0x01, 0x06, 0x00, 0x56, 0xFE, 0xB0, 0xFC, 0x13, 0xFB, 0x84, 0xF9, 0x02, 0xF8, 0x9B, 0xF6	; 02330574
	.byte 0x4F, 0xF5, 0x21, 0xF4, 0x10, 0xF3, 0x27, 0xF2, 0x65, 0xF1, 0xCB, 0xF0, 0x5A, 0xF0, 0x17, 0xF0	; 02330584
	.byte 0x00, 0xF0, 0x16, 0xF0, 0x59, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1, 0x21, 0xF2, 0x0C, 0xF3, 0x18, 0xF4	; 02330594
	.byte 0x46, 0xF5, 0x91, 0xF6, 0xFC, 0xF7, 0x79, 0xF9, 0x07, 0xFB, 0xA3, 0xFC, 0x4F, 0xFE, 0xFA, 0xFF	; 023305A4
	.byte 0xA4, 0x01, 0x4A, 0x03, 0xED, 0x04, 0x7C, 0x06, 0xF9, 0x07, 0x5F, 0x09, 0xB1, 0x0A, 0xDF, 0x0B	; 023305B4
	.byte 0xED, 0x0C, 0xD6, 0x0D, 0x9B, 0x0E, 0x35, 0x0F, 0xA5, 0x0F, 0xE8, 0x0F, 0x83, 0x00, 0x00, 0x00	; 023305C4
	.byte 0x80, 0x00, 0x00, 0x00, 0x96, 0x00, 0x00, 0x00, 0x97, 0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0x00	; 023305D4
	.byte 0x6E, 0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 023305E4
	.byte 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 023305F4
	.byte 0x0C, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 02330604
	.byte 0x4D, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00	; 02330614
	.byte 0x59, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00	; 02330624
	.byte 0x59, 0x00, 0x00, 0x00	; 02330634
P1_Data_02330638:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x00, 0x00	; 02330638
	.byte 0xA9, 0x00, 0x00, 0x00	; 02330644
P1_Data_02330648:
	.byte 0x58, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x60, 0x6A, 0x3D, 0x02	; 02330648
	.byte 0x00, 0x84, 0x3D, 0x02, 0x40, 0x98, 0x3D, 0x02, 0x80, 0xAE, 0x3D, 0x02, 0x80, 0xC4, 0x3D, 0x02	; 02330654
	.byte 0x60, 0xDA, 0x3D, 0x02	; 02330664
P1_Data_02330668:
	.byte 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00	; 02330668
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04, 0x00	; 02330674
	.byte 0x06, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00	; 02330684
	.byte 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330694
	.byte 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 023306A4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00	; 023306B4
	.byte 0x02, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00	; 023306C4
	.byte 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023306D4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023306E4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023306F4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330704
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330714
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330724
	.byte 0x02, 0x00, 0x04, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x05, 0x00, 0x08, 0x00, 0x09, 0x00	; 02330734
	.byte 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330744
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330754
	.byte 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0A, 0x00, 0x07, 0x00, 0x01, 0x00, 0x05, 0x00, 0x01, 0x00	; 02330764
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330774
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330784
	.byte 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00	; 02330794
	.byte 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 023307A4
	.byte 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00	; 023307B4
	.byte 0x4D, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 023307C4
	.byte 0x4D, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 023307D4
	.byte 0x4D, 0x00, 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 023307E4
	.byte 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00	; 023307F4
	.byte 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00	; 02330804
	.byte 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00	; 02330814
	.byte 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00	; 02330824
	.byte 0x00, 0x00, 0x00, 0x00	; 02330834
P1_Data_02330838:
	.byte 0x1F, 0x00, 0x1C, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00	; 02330838
	.byte 0x1F, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00	; 02330844
P1_Data_02330850:
	.byte 0xFF, 0x00, 0x00, 0x00	; 02330850
	.byte 0x9B, 0x47, 0x26, 0x74, 0xBC, 0x11, 0x4F, 0x6D, 0xBD, 0x11, 0xF1, 0x32, 0xD9, 0x7F, 0xE7, 0x2C	; 02330854
	.byte 0xA5, 0x5D, 0xBD, 0x11, 0x10, 0x46, 0xA4, 0x5D, 0x90, 0x4E, 0x73, 0x61, 0x84, 0x2A, 0x91, 0x4E	; 02330864
	.byte 0x6A, 0x10, 0xFE, 0x75, 0xC8, 0x29, 0x39, 0x78, 0x0E, 0x42, 0x1B, 0x5D, 0x38, 0x78, 0xA8, 0x12	; 02330874
	.byte 0x7D, 0x3F, 0xB9, 0x67, 0xF3, 0x26, 0xEF, 0x54, 0x23, 0x7C, 0xF2, 0x26, 0xC6, 0x6B, 0x37, 0x41	; 02330884
	.byte 0xAB, 0x15, 0x0D, 0x73, 0xC7, 0x6B, 0x4F, 0x3B, 0x24, 0x5F, 0xDA, 0x3D, 0x3F, 0x25, 0x49, 0x17	; 02330894
	.byte 0xDB, 0x3D, 0xE6, 0x70, 0x6C, 0x74, 0xF7, 0x30, 0x1F, 0x53, 0x38, 0x67, 0x1E, 0x53, 0x51, 0x1A	; 023308A4
	.byte 0x71, 0x19, 0x7D, 0x5B, 0xD6, 0x4E, 0x70, 0x19, 0x27, 0x3F, 0xCB, 0x75, 0x62, 0x3D, 0x8C, 0x12	; 023308B4
	.byte 0xB8, 0x74, 0xAD, 0x2F, 0xB9, 0x74, 0xFD, 0x64, 0x9A, 0x6C, 0x3A, 0x4F, 0x6D, 0x27, 0xEF, 0x73	; 023308C4
	.byte 0xB1, 0x38, 0x3B, 0x4F, 0x1E, 0x57, 0xA3, 0x7E, 0x49, 0x62, 0x87, 0x35, 0x7C, 0x1B, 0x86, 0x35	; 023308D4
	.byte 0xFB, 0x7A, 0xE4, 0x67, 0x92, 0x5C, 0xE5, 0x67, 0xCA, 0x2B, 0x8C, 0x43, 0x6F, 0x2E, 0x7F, 0x58	; 023308E4
	.byte 0xB7, 0x14, 0x6E, 0x2E, 0xB9, 0x4C, 0xA2, 0x6F, 0xF0, 0x38, 0x9E, 0x71, 0x5A, 0x47, 0x3C, 0x1F	; 023308F4
	.byte 0xD8, 0x6A, 0x5B, 0x47, 0x99, 0x51, 0x64, 0x32, 0x41, 0x7B, 0xEF, 0x49, 0x98, 0x51, 0xD7, 0x1C	; 02330904
P1_Data_02330914:
	.byte 0xC0, 0x01, 0x01, 0x04, 0x00, 0x00, 0x00, 0x00, 0x30, 0x31, 0x00, 0x00, 0x41, 0x53, 0x4D, 0x4A	; 02330914
	.byte 0x00, 0x00, 0x00, 0x00, 0x41, 0x53, 0x4D, 0x45, 0x00, 0x00, 0x00, 0x00	; 02330924
P1_Data_02330930:
	.byte 0x08, 0x00, 0x09, 0x00	; 02330930
	.byte 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 02330934
P1_Data_02330940:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P1_IrqHandlers:
	.word P1_IrqHandler_0232B05C + 1	; IRQ 0
	.word P1_IrqHandler_0232B05C + 1	; IRQ 1
	.word P1_IrqHandler_0232B05C + 1	; IRQ 2
	.word P1_IrqHandler_0232AFC0 + 1	; IRQ 3
	.word P1_IrqHandler_0232AFB4 + 1	; IRQ 4
	.word P1_IrqHandler_0232AFA8 + 1	; IRQ 5
	.word P1_IrqHandler_0232AF9C + 1	; IRQ 6
	.word P1_IrqHandler_0232B05C + 1	; IRQ 7
	.word P1_IrqHandler_0232AFF0 + 1	; IRQ 8
	.word P1_IrqHandler_0232AFE4 + 1	; IRQ 9
	.word P1_IrqHandler_0232AFD8 + 1	; IRQ 10
	.word P1_IrqHandler_0232AFCC + 1	; IRQ 11
	.word P1_IrqHandler_0232B05C + 1	; IRQ 12
	.word P1_IrqHandler_0232B05C + 1	; IRQ 13
	.word P1_IrqHandler_0232B05C + 1	; IRQ 14
	.word P1_IrqHandler_0232B05C + 1	; IRQ 15
	.word P1_IrqHandler_0232B05C + 1	; IRQ 16
	.word P1_IrqHandler_0232B05C + 1	; IRQ 17
	.word P1_IrqHandler_0232B05C + 1	; IRQ 18
	.word P1_IrqHandler_0232B05C + 1	; IRQ 19
	.word P1_IrqHandler_0232B05C + 1	; IRQ 20
	.word P1_IrqHandler_0232B05C + 1	; IRQ 21
P1_IrqHandlersEnd:
P1_Data_02330998:
	.byte 0xFF, 0xFF, 0xFF, 0xFF	; 02330998
P1_Data_0233099C:
	.byte 0x01, 0x00, 0x00, 0x00	; 0233099C
P1_Data_023309A0:
	.byte 0x03, 0x00, 0x00, 0x00	; 023309A0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023309A4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023309B4
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
	blx loc_0232B1B4	; 01FF8088
	lsl r0,r0,#0x10	; 01FF808C
	lsr r0,r0,#0x10	; 01FF808E
	str r0,[sp,#0x0]	; 01FF8090
	bl loc_0232B30C	; 01FF8092
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
	bl loc_0232B1A4	; 01FF810C
	ldr r0,[sp,#0x0]	; 01FF8110
	blx loc_0232B20C	; 01FF8112
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
	.word loc_0232EA08 + 1	; 01FF82D4
pool_01FF82D8:
	.word loc_0232E9C8 + 1	; 01FF82D8

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
	.byte 0x21, 0x06, 0xC0, 0xDE, 0xB0, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330D18
.arm
.close
