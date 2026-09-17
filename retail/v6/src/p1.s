; official_v6_p1
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
	bl loc_0232C944	; 02320078
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
	push {r4,r5,r6,lr}	; 023200A0
	sub sp,#0x10	; 023200A2
	mov r5,#0x0	; 023200A4
	add r4,r5,#0x0	; 023200A6
	ldr r0,[pool_02320234]	; 023200A8
	bl loc_02327A18	; 023200AA
	bl loc_0232BC38	; 023200AE
	bl loc_0232C0BC	; 023200B2
	bl loc_0232D504	; 023200B6
	bl loc_0232EEBC	; 023200BA
	ldr r0,[pool_02320238]	; 023200BE
	bl loc_0232D730	; 023200C0
	lsl r0,r5,#0	; 023200C4
	str r0,[sp,#0x4]	; 023200C6
	ldr r0,[sp,#0x4]	; 023200C8
	ldr r1,[pool_0232023C]	; 023200CA
	ldr r2,[pool_02320240]	; 023200CC
	blx loc_0232DE68	; 023200CE
	bl loc_0232D630	; 023200D2
	mov r0,#0xc0	; 023200D6
	str r0,[sp,#0x0]	; 023200D8
	ldr r0,[sp,#0x0]	; 023200DA
	ldr r1,[pool_02320244]	; 023200DC
	ldr r2,[pool_02320248]	; 023200DE
	blx loc_0232DE68	; 023200E0
	lsl r0,r5,#0	; 023200E4
	str r0,[sp,#0x8]	; 023200E6
	ldr r0,[sp,#0x8]	; 023200E8
	ldr r1,[pool_0232024C]	; 023200EA
	ldr r2,[pool_02320248]	; 023200EC
	blx loc_0232DE68	; 023200EE
	mov r0,#0x1	; 023200F2
	ldr r1,[pool_02320250]	; 023200F4
	bl loc_0232B1E0	; 023200F6
	mov r0,#0x1	; 023200FA
	bl loc_0232B15C	; 023200FC
	ldr r1,[pool_02320254]	; 02320100
	ldrh r0,[r1,#0x0]	; 02320102
	mov r0,#0x1	; 02320104
	strh r0,[r1,#0x0]	; 02320106
	blx P1_Arm9EnableIrqReturnPriorMask	; 02320108
	mov r0,#0x1	; 0232010C
	bl loc_0232D4E0	; 0232010E
	bl loc_0232FE04	; 02320112
	bl loc_023278E4	; 02320116
	cmp r0,#0x0	; 0232011A
	beq loc_02320120	; 0232011C
	b loc_0232022C	; 0232011E
loc_02320120:
	bl loc_02327694	; 02320120
	bl loc_023268B4	; 02320124
	bl loc_02326A10	; 02320128
	bl loc_02324C70	; 0232012C
	bl loc_02324DB8	; 02320130
	bl loc_023236FC	; 02320134
	bl P1_InitializeFirmwareUiContext	; 02320138
	bl loc_02325840	; 0232013C
	bl loc_02325760	; 02320140
	mov r6,#0x2	; 02320144
	bl P1_GetFirmwareUiContext	; 02320146
	ldr r0,[r0,#0x0]	; 0232014A
	lsl r0,r0,#0x1b	; 0232014C
	lsr r0,r0,#0x1f	; 0232014E
	cmp r0,#0x0	; 02320150
	beq loc_0232015C	; 02320152
	ldr r0,[pool_02320258]	; 02320154
	ldrh r0,[r0,#0x0]	; 02320156
	lsl r0,r0,#0x1c	; 02320158
	lsr r6,r0,#0x1f	; 0232015A
loc_0232015C:
	mov r0,#0x4	; 0232015C
	ldr r1,[pool_02320258]	; 0232015E
	ldrh r1,[r1,#0x0]	; 02320160
	lsl r1,r1,#0x1a	; 02320162
	lsr r1,r1,#0x1e	; 02320164
	lsl r1,r1,#0x10	; 02320166
	lsr r1,r1,#0x10	; 02320168
	bl loc_0232F2B0	; 0232016A
	add r0,r6,#0x0	; 0232016E
	mov r1,#0x1	; 02320170
	bl loc_0232F1DC	; 02320172
	bl P1_GetFirmwareUiContext	; 02320176
	ldr r0,[r0,#0x0]	; 0232017A
	lsl r0,r0,#0x1b	; 0232017C
	lsr r0,r0,#0x1f	; 0232017E
	cmp r0,#0x0	; 02320180
	beq loc_02320188	; 02320182
	mov r4,#0x5	; 02320184
	b loc_0232018E	; 02320186
loc_02320188:
	bl loc_02320DD8	; 02320188
	mov r5,#0x1	; 0232018C
loc_0232018E:
	bl P1_RefreshFirmwareUiRenderBuffers	; 0232018E
	bl loc_02324C44	; 02320192
	bl loc_02324A3C	; 02320196
	bl loc_02324C28	; 0232019A
	bl loc_02324A3C	; 0232019E
	bl loc_023268EC	; 023201A2
	bl loc_02327694	; 023201A6
	cmp r0,#0x0	; 023201AA
	bne loc_0232022C	; 023201AC
	cmp r5,#0x0	; 023201AE
	beq loc_023201DC	; 023201B0
	bl loc_0232027C	; 023201B2
	add r4,r0,#0x0	; 023201B6
	cmp r4,#0x0	; 023201B8
	beq loc_023201DC	; 023201BA
	cmp r4,#0x1	; 023201BC
	beq loc_023201CA	; 023201BE
	cmp r4,#0x2	; 023201C0
	beq loc_023201D0	; 023201C2
	cmp r4,#0x3	; 023201C4
	beq loc_023201D6	; 023201C6
	b loc_023201DA	; 023201C8
loc_023201CA:
	bl loc_023275E0	; 023201CA
	b loc_023201DA	; 023201CE
loc_023201D0:
	bl loc_02327600	; 023201D0
	b loc_023201DA	; 023201D4
loc_023201D6:
	bl loc_023275F0	; 023201D6
loc_023201DA:
	mov r5,#0x0	; 023201DA
loc_023201DC:
	cmp r4,#0x5	; 023201DC
	bhi loc_02320226	; 023201DE
	add r0,r4,r4	; 023201E0
P1_SwitchIndexPC_023201E0:
	add r0,pc	; 023201E2
	ldrh r0,[r0,#(P1_SwitchTable_023201E0 - (P1_SwitchIndexPC_023201E0 + 4))]	; 023201E4
	lsl r0,r0,#0x10	; 023201E6
	asr r0,r0,#0x10	; 023201E8
P1_SwitchTargetPC_023201E0:
	add r0,pc	; 023201EA
	bx r0	; 023201EC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023201E0:
	.halfword (loc_02320226 + 1) - (P1_SwitchTargetPC_023201E0 + 4)
	.halfword (loc_023201FA + 1) - (P1_SwitchTargetPC_023201E0 + 4)
	.halfword (loc_023201FA + 1) - (P1_SwitchTargetPC_023201E0 + 4)
	.halfword (loc_023201FA + 1) - (P1_SwitchTargetPC_023201E0 + 4)
	.halfword (loc_02320200 + 1) - (P1_SwitchTargetPC_023201E0 + 4)
	.halfword (loc_02320214 + 1) - (P1_SwitchTargetPC_023201E0 + 4)
P1_SwitchTable_023201E0End:
loc_023201FA:
	bl loc_02327660	; 023201FA
	b loc_02320226	; 023201FE
loc_02320200:
	bl loc_0232D4AC	; 02320200
	ldr r2,[pool_0232025C]	; 02320204
	ldr r1,[r2,#0x0]	; 02320206
	ldr r0,[pool_02320260]	; 02320208
	and r1,r0	; 0232020A
	str r1,[r2,#0x0]	; 0232020C
	bl loc_02327620	; 0232020E
	b loc_02320226	; 02320212
loc_02320214:
	bl loc_0232D4AC	; 02320214
	ldr r2,[pool_0232025C]	; 02320218
	ldr r1,[r2,#0x0]	; 0232021A
	ldr r0,[pool_02320260]	; 0232021C
	and r1,r0	; 0232021E
	str r1,[r2,#0x0]	; 02320220
	bl loc_02327610	; 02320222
loc_02320226:
	bl loc_023236F4	; 02320226
	b loc_0232018E	; 0232022A
loc_0232022C:
	add sp,#0x10	; 0232022C
	pop {r4,r5,r6}	; 0232022E
	pop {r3}	; 02320230
	bx r3	; 02320232
pool_02320234:
loc_02320234:
	.word 0x0232FEE0	; 02320234
pool_02320238:
loc_02320238:
	.word 0x000001FF	; 02320238
pool_0232023C:
loc_0232023C:
	.word 0x06800000	; 0232023C
pool_02320240:
loc_02320240:
	.word 0x000A4000	; 02320240
pool_02320244:
loc_02320244:
	.word 0x07000000	; 02320244
pool_02320248:
loc_02320248:
	.word 0x00000400	; 02320248
pool_0232024C:
loc_0232024C:
	.word 0x05000000	; 0232024C
pool_02320250:
loc_02320250:
	.word P1_IrqHandler_02320264 + 1	; 02320250
pool_02320254:
loc_02320254:
	.word REG_IME	; 02320254
pool_02320258:
loc_02320258:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02320258
pool_0232025C:
loc_0232025C:
	.word REG_DISPCNT_B	; 0232025C
pool_02320260:
loc_02320260:
	.word 0xFFFEFFFF	; 02320260
P1_IrqHandler_02320264:
	ldr r1,[pool_02320274]	; 02320264
	ldr r0,[pool_02320278]	; 02320266
	add r1,r1,r0	; 02320268
	ldr r2,[r1,#0x0]	; 0232026A
	mov r0,#0x1	; 0232026C
	orr r2,r0	; 0232026E
	str r2,[r1,#0x0]	; 02320270
	bx lr	; 02320272
pool_02320274:
loc_02320274:
	.word P1_DtcmRuntimeStart	; 02320274
pool_02320278:
loc_02320278:
	.word 0x00003FF8	; 02320278

; 根据共享状态中的启动原因选择后续 UI/启动路径。
; Selects the subsequent UI/boot path from the shared boot-state value.
P1_DispatchBootState:
loc_0232027C:
	push {r4,r5,r6,lr}	; 0232027C
	mov r4,#0x0	; 0232027E
	ldr r5,[pool_023203EC]	; 02320280
	ldr r6,[pool_023203F0]	; 02320282
	bl loc_02324118	; 02320284
	bl loc_02323F60	; 02320288
	ldr r0,[pool_023203F4]	; 0232028C
	ldr r0,[r0,#0x68]	; 0232028E
	lsl r1,r0,#0x1d	; 02320290
	lsr r1,r1,#0x1f	; 02320292
	cmp r1,#0x0	; 02320294
	beq loc_023202A4	; 02320296
	lsl r0,r0,#0x14	; 02320298
	lsr r0,r0,#0x1f	; 0232029A
	cmp r0,#0x0	; 0232029C
	bne loc_023202A4	; 0232029E
	bl loc_02322944	; 023202A0
loc_023202A4:
	bl loc_02325444	; 023202A4
	bl loc_02324F34	; 023202A8
	add r0,r5,#0x0	; 023202AC
	bl loc_02321CD4	; 023202AE
	ldr r0,[pool_023203F8]	; 023202B2
	bl loc_02326A48	; 023202B4
	ldr r0,[pool_023203FC]	; 023202B8
	ldr r0,[r0,#0x4c]	; 023202BA
	cmp r0,#0x9	; 023202BC
	bhi loc_023203A4	; 023202BE
	add r0,r0,r0	; 023202C0
P1_SwitchIndexPC_023202C0:
	add r0,pc	; 023202C2
	ldrh r0,[r0,#(P1_SwitchTable_023202C0 - (P1_SwitchIndexPC_023202C0 + 4))]	; 023202C4
	lsl r0,r0,#0x10	; 023202C6
	asr r0,r0,#0x10	; 023202C8
P1_SwitchTargetPC_023202C0:
	add r0,pc	; 023202CA
	bx r0	; 023202CC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023202C0:
	.halfword (loc_023202E2 + 1) - (P1_SwitchTargetPC_023202C0 + 4)
	.halfword (loc_02320358 + 1) - (P1_SwitchTargetPC_023202C0 + 4)
	.halfword (loc_02320362 + 1) - (P1_SwitchTargetPC_023202C0 + 4)
	.halfword (loc_0232036C + 1) - (P1_SwitchTargetPC_023202C0 + 4)
	.halfword (loc_02320374 + 1) - (P1_SwitchTargetPC_023202C0 + 4)
	.halfword (loc_0232037C + 1) - (P1_SwitchTargetPC_023202C0 + 4)
	.halfword (loc_02320384 + 1) - (P1_SwitchTargetPC_023202C0 + 4)
	.halfword (loc_0232038C + 1) - (P1_SwitchTargetPC_023202C0 + 4)
	.halfword (loc_0232039C + 1) - (P1_SwitchTargetPC_023202C0 + 4)
	.halfword (loc_02320394 + 1) - (P1_SwitchTargetPC_023202C0 + 4)
P1_SwitchTable_023202C0End:
loc_023202E2:
	ldr r0,[pool_02320400]	; 023202E2
	ldr r0,[r0,#0x2c]	; 023202E4
	cmp r0,#0xa	; 023202E6
	bhi loc_023203A4	; 023202E8
	add r0,r0,r0	; 023202EA
P1_SwitchIndexPC_023202EA:
	add r0,pc	; 023202EC
	ldrh r0,[r0,#(P1_SwitchTable_023202EA - (P1_SwitchIndexPC_023202EA + 4))]	; 023202EE
	lsl r0,r0,#0x10	; 023202F0
	asr r0,r0,#0x10	; 023202F2
P1_SwitchTargetPC_023202EA:
	add r0,pc	; 023202F4
	bx r0	; 023202F6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023202EA:
	.halfword (loc_0232030E + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_02320314 + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_0232031A + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_02320322 + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_02320328 + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_0232032E + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_02320336 + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_0232033E + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_02320346 + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_0232034C + 1) - (P1_SwitchTargetPC_023202EA + 4)
	.halfword (loc_02320352 + 1) - (P1_SwitchTargetPC_023202EA + 4)
P1_SwitchTable_023202EAEnd:
loc_0232030E:
	bl loc_02320AA8	; 0232030E
	b loc_023203A4	; 02320312
loc_02320314:
	bl loc_0232096C	; 02320314
	b loc_023203A4	; 02320318
loc_0232031A:
	bl loc_02320880	; 0232031A
	add r4,r0,#0x0	; 0232031E
	b loc_023203A4	; 02320320
loc_02320322:
	bl loc_02320818	; 02320322
	b loc_023203A4	; 02320326
loc_02320328:
	bl loc_023207CC	; 02320328
	b loc_023203A4	; 0232032C
loc_0232032E:
	add r0,r5,#0x0	; 0232032E
	bl loc_02320614	; 02320330
	b loc_023203A4	; 02320334
loc_02320336:
	bl loc_02320578	; 02320336
	add r4,r0,#0x0	; 0232033A
	b loc_023203A4	; 0232033C
loc_0232033E:
	bl loc_02320524	; 0232033E
	add r4,r0,#0x0	; 02320342
	b loc_023203A4	; 02320344
loc_02320346:
	bl loc_023204E0	; 02320346
	b loc_023203A4	; 0232034A
loc_0232034C:
	bl loc_0232043C	; 0232034C
	b loc_023203A4	; 02320350
loc_02320352:
	bl loc_02320410	; 02320352
	b loc_023203A4	; 02320356
loc_02320358:
	add r0,r5,#0x0	; 02320358
	add r1,r6,#0x0	; 0232035A
	bl loc_02325FCC	; 0232035C
	b loc_023203A4	; 02320360
loc_02320362:
	add r0,r5,#0x0	; 02320362
	add r1,r6,#0x0	; 02320364
	bl loc_02325F64	; 02320366
	b loc_023203A4	; 0232036A
loc_0232036C:
	add r0,r6,#0x0	; 0232036C
	bl loc_02325EEC	; 0232036E
	b loc_023203A4	; 02320372
loc_02320374:
	add r0,r6,#0x0	; 02320374
	bl loc_02325E64	; 02320376
	b loc_023203A4	; 0232037A
loc_0232037C:
	add r0,r6,#0x0	; 0232037C
	bl loc_02325DB8	; 0232037E
	b loc_023203A4	; 02320382
loc_02320384:
	add r0,r6,#0x0	; 02320384
	bl loc_02325C8C	; 02320386
	b loc_023203A4	; 0232038A
loc_0232038C:
	add r0,r6,#0x0	; 0232038C
	bl loc_02325C1C	; 0232038E
	b loc_023203A4	; 02320392
loc_02320394:
	add r0,r6,#0x0	; 02320394
	bl loc_02325AD8	; 02320396
	b loc_023203A4	; 0232039A
loc_0232039C:
	add r0,r5,#0x0	; 0232039C
	add r1,r6,#0x0	; 0232039E
	bl loc_02325B64	; 023203A0
loc_023203A4:
	bl loc_0232C6C8	; 023203A4
	cmp r0,#0x0	; 023203A8
	beq loc_023203CC	; 023203AA
	ldr r0,[pool_02320404]	; 023203AC
	ldr r1,[pool_02320408]	; 023203AE
	mov r2,#0x30	; 023203B0
	bl loc_02324B5C	; 023203B2
	mov r1,#0x4	; 023203B6
	ldr r0,[pool_0232040C]	; 023203B8
	strh r1,[r0,#0x22]	; 023203BA
	ldr r1,[pool_023203F4]	; 023203BC
	ldr r2,[r1,#0x68]	; 023203BE
	mov r0,#0x20	; 023203C0
	bic r2,r0	; 023203C2
	str r2,[r1,#0x68]	; 023203C4
	mov r0,#0x40	; 023203C6
	bic r2,r0	; 023203C8
	str r2,[r1,#0x68]	; 023203CA
loc_023203CC:
	ldr r0,[pool_023203F0]	; 023203CC
	bl loc_02326074	; 023203CE
	cmp r4,#0x0	; 023203D2
	beq loc_023203E0	; 023203D4
	ldr r1,[pool_023203F4]	; 023203D6
	ldr r2,[r1,#0x68]	; 023203D8
	mov r0,#0x2	; 023203DA
	bic r2,r0	; 023203DC
	str r2,[r1,#0x68]	; 023203DE
loc_023203E0:
	bl loc_02320AF8	; 023203E0
	add r0,r4,#0x0	; 023203E4
	pop {r4,r5,r6}	; 023203E6
	pop {r3}	; 023203E8
	bx r3	; 023203EA
pool_023203EC:
loc_023203EC:
	.word 0x02330BF4	; 023203EC
pool_023203F0:
loc_023203F0:
	.word 0x0233155C	; 023203F0
pool_023203F4:
loc_023203F4:
	.word P1_BssStart + 0x1300	; 023203F4
pool_023203F8:
loc_023203F8:
	.word 0x02331570	; 023203F8
pool_023203FC:
loc_023203FC:
	.word P1_BssStart + 0xA80	; 023203FC
pool_02320400:
loc_02320400:
	.word P1_BssStart + 0x100	; 02320400
pool_02320404:
loc_02320404:
	.word 0x02330B0C	; 02320404
pool_02320408:
loc_02320408:
	.word 0x023A5B6C	; 02320408
pool_0232040C:
loc_0232040C:
	.word P1_BssStart + 0x40	; 0232040C

; ===== function loc_02320410 =====
loc_02320410:
	ldr r0,[pool_02320430]	; 02320410
	ldr r1,[r0,#0x10]	; 02320412
	cmp r1,#0x0	; 02320414
	beq loc_0232041E	; 02320416
	sub r1,#0x8	; 02320418
	str r1,[r0,#0x10]	; 0232041A
	bx lr	; 0232041C
loc_0232041E:
	ldr r1,[pool_02320434]	; 0232041E
	ldr r2,[r1,#0x68]	; 02320420
	mov r0,#0x80	; 02320422
	bic r2,r0	; 02320424
	str r2,[r1,#0x68]	; 02320426
	mov r1,#0x5	; 02320428
	ldr r0,[pool_02320438]	; 0232042A
	str r1,[r0,#0x2c]	; 0232042C
	bx lr	; 0232042E
pool_02320430:
loc_02320430:
	.word P1_BssStart + 0xB00	; 02320430
pool_02320434:
loc_02320434:
	.word P1_BssStart + 0x1300	; 02320434
pool_02320438:
loc_02320438:
	.word P1_BssStart + 0x100	; 02320438

; ===== function loc_0232043C =====
loc_0232043C:
	push {lr}	; 0232043C
	sub sp,#0x4	; 0232043E
	ldr r0,[pool_023204D8]	; 02320440
	ldr r0,[r0,#0x30]	; 02320442
	cmp r0,#0xa	; 02320444
	bne loc_02320458	; 02320446
	bl loc_02325390	; 02320448
	mov r1,#0xa	; 0232044C
	ldr r0,[pool_023204D8]	; 0232044E
	str r1,[r0,#0x2c]	; 02320450
	mov r1,#0x5	; 02320452
	str r1,[r0,#0x30]	; 02320454
	b loc_023204D0	; 02320456
loc_02320458:
	ldr r0,[pool_023204DC]	; 02320458
	ldr r1,[r0,#0x50]	; 0232045A
	cmp r1,#0x2	; 0232045C
	bne loc_02320472	; 0232045E
	mov r1,#0x0	; 02320460
	str r1,[r0,#0x50]	; 02320462
	mov r1,#0x2	; 02320464
	str r1,[r0,#0x4c]	; 02320466
	mov r0,#0x3a	; 02320468
	mov r1,#0x1	; 0232046A
	bl loc_02325060	; 0232046C
	b loc_023204D0	; 02320470
loc_02320472:
	cmp r1,#0x3	; 02320472
	bne loc_0232048C	; 02320474
	bl loc_02325390	; 02320476
	mov r0,#0x1	; 0232047A
	bl loc_023229D0	; 0232047C
	mov r1,#0x0	; 02320480
	ldr r0,[pool_023204DC]	; 02320482
	str r1,[r0,#0x50]	; 02320484
	mov r1,#0x3	; 02320486
	str r1,[r0,#0x4c]	; 02320488
	b loc_023204D0	; 0232048A
loc_0232048C:
	cmp r1,#0x4	; 0232048C
	bne loc_023204A0	; 0232048E
	bl loc_02325390	; 02320490
	mov r1,#0x0	; 02320494
	ldr r0,[pool_023204DC]	; 02320496
	str r1,[r0,#0x50]	; 02320498
	mov r1,#0x4	; 0232049A
	str r1,[r0,#0x4c]	; 0232049C
	b loc_023204D0	; 0232049E
loc_023204A0:
	cmp r1,#0x9	; 023204A0
	bne loc_023204AE	; 023204A2
	mov r1,#0x0	; 023204A4
	str r1,[r0,#0x50]	; 023204A6
	mov r1,#0x9	; 023204A8
	str r1,[r0,#0x4c]	; 023204AA
	b loc_023204D0	; 023204AC
loc_023204AE:
	cmp r1,#0x6	; 023204AE
	bne loc_023204C2	; 023204B0
	bl loc_02325390	; 023204B2
	mov r1,#0x0	; 023204B6
	ldr r0,[pool_023204DC]	; 023204B8
	str r1,[r0,#0x50]	; 023204BA
	mov r1,#0x6	; 023204BC
	str r1,[r0,#0x4c]	; 023204BE
	b loc_023204D0	; 023204C0
loc_023204C2:
	cmp r1,#0x0	; 023204C2
	bne loc_023204D0	; 023204C4
	bl loc_02325390	; 023204C6
	mov r1,#0xa	; 023204CA
	ldr r0,[pool_023204D8]	; 023204CC
	str r1,[r0,#0x2c]	; 023204CE
loc_023204D0:
	add sp,#0x4	; 023204D0
	pop {r3}	; 023204D2
	bx r3	; 023204D4
	.byte 0xC0, 0x46	; 023204D8
pool_023204D8:
loc_023204D8:
	.word P1_BssStart + 0x100	; 023204D8
pool_023204DC:
loc_023204DC:
	.word P1_BssStart + 0xA80	; 023204DC

; ===== function loc_023204E0 =====
loc_023204E0:
	push {lr}	; 023204E0
	sub sp,#0x4	; 023204E2
	ldr r0,[pool_02320514]	; 023204E4
	ldr r1,[r0,#0x10]	; 023204E6
	cmp r1,#0xb0	; 023204E8
	beq loc_023204F2	; 023204EA
	add r1,#0x8	; 023204EC
	str r1,[r0,#0x10]	; 023204EE
	b loc_0232050C	; 023204F0
loc_023204F2:
	ldr r0,[pool_02320518]	; 023204F2
	bl loc_02325A60	; 023204F4
	mov r1,#0x9	; 023204F8
	ldr r0,[pool_0232051C]	; 023204FA
	str r1,[r0,#0x2c]	; 023204FC
	ldr r1,[pool_02320520]	; 023204FE
	ldr r2,[r1,#0x54]	; 02320500
	mov r0,#0x20	; 02320502
	bic r2,r0	; 02320504
	str r2,[r1,#0x54]	; 02320506
	mov r0,#0x1	; 02320508
	str r0,[r1,#0x4c]	; 0232050A
loc_0232050C:
	add sp,#0x4	; 0232050C
	pop {r3}	; 0232050E
	bx r3	; 02320510
	.byte 0xC0, 0x46	; 02320514
pool_02320514:
loc_02320514:
	.word P1_BssStart + 0xB00	; 02320514
pool_02320518:
loc_02320518:
	.word 0x0233155C	; 02320518
pool_0232051C:
loc_0232051C:
	.word P1_BssStart + 0x100	; 0232051C
pool_02320520:
loc_02320520:
	.word P1_BssStart + 0xA80	; 02320520

; ===== function loc_02320524 =====
loc_02320524:
	push {r4,r5,lr}	; 02320524
	sub sp,#0x4	; 02320526
	mov r4,#0x0	; 02320528
	ldr r0,[pool_0232056C]	; 0232052A
	ldr r1,[r0,#0x8]	; 0232052C
	add r1,r1,#0x1	; 0232052E
	str r1,[r0,#0x8]	; 02320530
	cmp r1,#0x1e	; 02320532
	bgt loc_02320552	; 02320534
	lsl r0,r1,#0x4	; 02320536
	mov r1,#0x1e	; 02320538
	blx P1_SignedDivMod	; 0232053A
	add r5,r0,#0x0	; 0232053E
	ldr r0,[pool_02320570]	; 02320540
	add r1,r5,#0x0	; 02320542
	bl loc_0232D3E4	; 02320544
	ldr r0,[pool_02320574]	; 02320548
	add r1,r5,#0x0	; 0232054A
	bl loc_0232D3E4	; 0232054C
	b loc_02320562	; 02320550
loc_02320552:
	ldr r0,[r0,#0x4]	; 02320552
	cmp r0,#0x1	; 02320554
	beq loc_02320560	; 02320556
	cmp r0,#0x4	; 02320558
	bne loc_02320562	; 0232055A
	mov r4,#0x4	; 0232055C
	b loc_02320562	; 0232055E
loc_02320560:
	mov r4,#0x5	; 02320560
loc_02320562:
	add r0,r4,#0x0	; 02320562
	add sp,#0x4	; 02320564
	pop {r4,r5}	; 02320566
	pop {r3}	; 02320568
	bx r3	; 0232056A
pool_0232056C:
loc_0232056C:
	.word P1_BssStart + 0xB00	; 0232056C
pool_02320570:
loc_02320570:
	.word REG_MASTER_BRIGHT	; 02320570
pool_02320574:
loc_02320574:
	.word REG_MASTER_BRIGHT_SUB	; 02320574

; ===== function loc_02320578 =====
loc_02320578:
	push {r4,r5,lr}	; 02320578
	sub sp,#0x4	; 0232057A
	mov r4,#0x0	; 0232057C
	ldr r2,[pool_02320604]	; 0232057E
	ldr r0,[pool_02320608]	; 02320580
	ldr r1,[r0,#0x4]	; 02320582
	mov r0,#0x3c	; 02320584
	mul r1,r0	; 02320586
	add r0,r2,r1	; 02320588
	mov r1,#0x2	; 0232058A
	ldrsh r2,[r0,r1]	; 0232058C
	mov r1,#0x77	; 0232058E
	mvn r1,r1	; 02320590
	cmp r2,r1	; 02320592
	ble loc_0232059A	; 02320594
	sub r1,r2,#0x6	; 02320596
	strh r1,[r0,#0x2]	; 02320598
loc_0232059A:
	ldr r1,[pool_02320608]	; 0232059A
	ldr r0,[r1,#0x8]	; 0232059C
	add r0,r0,#0x1	; 0232059E
	str r0,[r1,#0x8]	; 023205A0
	cmp r0,#0x1e	; 023205A2
	bgt loc_023205C2	; 023205A4
	lsl r0,r0,#0x4	; 023205A6
	mov r1,#0x1e	; 023205A8
	blx P1_SignedDivMod	; 023205AA
	add r5,r0,#0x0	; 023205AE
	str r5,[sp,#0x0]	; 023205B0
	ldr r0,[pool_0232060C]	; 023205B2
	mov r1,#0x0	; 023205B4
	mov r2,#0x2	; 023205B6
	mov r3,#0x10	; 023205B8
	sub r3,r3,r5	; 023205BA
	bl loc_0232D958	; 023205BC
	b loc_023205F6	; 023205C0
loc_023205C2:
	ldr r0,[r1,#0x4]	; 023205C2
	cmp r0,#0x4	; 023205C4
	bhi loc_023205F6	; 023205C6
	add r0,r0,r0	; 023205C8
P1_SwitchIndexPC_023205C8:
	add r0,pc	; 023205CA
	ldrh r0,[r0,#(P1_SwitchTable_023205C8 - (P1_SwitchIndexPC_023205C8 + 4))]	; 023205CC
	lsl r0,r0,#0x10	; 023205CE
	asr r0,r0,#0x10	; 023205D0
P1_SwitchTargetPC_023205C8:
	add r0,pc	; 023205D2
	bx r0	; 023205D4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023205C8:
	.halfword (loc_023205E0 + 1) - (P1_SwitchTargetPC_023205C8 + 4)
	.halfword (loc_023205EC + 1) - (P1_SwitchTargetPC_023205C8 + 4)
	.halfword (loc_023205E8 + 1) - (P1_SwitchTargetPC_023205C8 + 4)
	.halfword (loc_023205E4 + 1) - (P1_SwitchTargetPC_023205C8 + 4)
	.halfword (loc_023205EC + 1) - (P1_SwitchTargetPC_023205C8 + 4)
P1_SwitchTable_023205C8End:
loc_023205E0:
	mov r4,#0x1	; 023205E0
	b loc_023205F6	; 023205E2
loc_023205E4:
	mov r4,#0x2	; 023205E4
	b loc_023205F6	; 023205E6
loc_023205E8:
	mov r4,#0x3	; 023205E8
	b loc_023205F6	; 023205EA
loc_023205EC:
	mov r0,#0x0	; 023205EC
	str r0,[r1,#0x8]	; 023205EE
	mov r1,#0x7	; 023205F0
	ldr r0,[pool_02320610]	; 023205F2
	str r1,[r0,#0x2c]	; 023205F4
loc_023205F6:
	bl loc_02321D24	; 023205F6
	add r0,r4,#0x0	; 023205FA
	add sp,#0x4	; 023205FC
	pop {r4,r5}	; 023205FE
	pop {r3}	; 02320600
	bx r3	; 02320602
pool_02320604:
loc_02320604:
	.word P1_BssStart	; 02320604
pool_02320608:
loc_02320608:
	.word P1_BssStart + 0xB00	; 02320608
pool_0232060C:
loc_0232060C:
	.word REG_BLDCNT_SUB	; 0232060C
pool_02320610:
loc_02320610:
	.word P1_BssStart + 0x100	; 02320610

; ===== function loc_02320614 =====
loc_02320614:
	push {r4,r5,lr}	; 02320614
	sub sp,#0x4	; 02320616
	add r5,r0,#0x0	; 02320618
	ldr r0,[pool_02320794]	; 0232061A
	bl loc_02321668	; 0232061C
	ldr r0,[pool_02320798]	; 02320620
	ldr r4,[r0,#0x74]	; 02320622
	add r0,r5,#0x0	; 02320624
	mov r1,#0x5	; 02320626
	bl loc_02321CCC	; 02320628
	cmp r0,#0x0	; 0232062C
	bne loc_0232063E	; 0232062E
	mov r0,#0x1	; 02320630
	bl loc_02324108	; 02320632
	cmp r0,#0x0	; 02320636
	beq loc_0232064A	; 02320638
	cmp r4,#0x0	; 0232063A
	bne loc_0232064A	; 0232063C
loc_0232063E:
	bl loc_023207B0	; 0232063E
	mov r1,#0x0	; 02320642
	ldr r0,[pool_0232079C]	; 02320644
	str r1,[r0,#0x4]	; 02320646
	b loc_0232078C	; 02320648
loc_0232064A:
	add r0,r5,#0x0	; 0232064A
	mov r1,#0x0	; 0232064C
	bl loc_02321CCC	; 0232064E
	cmp r0,#0x0	; 02320652
	bne loc_02320664	; 02320654
	mov r0,#0x1	; 02320656
	bl loc_02324108	; 02320658
	cmp r0,#0x0	; 0232065C
	beq loc_0232067E	; 0232065E
	cmp r4,#0x3	; 02320660
	bne loc_0232067E	; 02320662
loc_02320664:
	bl loc_023207B0	; 02320664
	mov r1,#0x3	; 02320668
	ldr r0,[pool_0232079C]	; 0232066A
	str r1,[r0,#0x4]	; 0232066C
	bl loc_02321DD4	; 0232066E
	ldr r1,[pool_023207A0]	; 02320672
	ldr r2,[r1,#0x68]	; 02320674
	ldr r0,[pool_023207A4]	; 02320676
	orr r2,r0	; 02320678
	str r2,[r1,#0x68]	; 0232067A
	b loc_0232078C	; 0232067C
loc_0232067E:
	add r0,r5,#0x0	; 0232067E
	mov r1,#0x2	; 02320680
	bl loc_02321CCC	; 02320682
	cmp r0,#0x0	; 02320686
	bne loc_02320698	; 02320688
	mov r0,#0x1	; 0232068A
	bl loc_02324108	; 0232068C
	cmp r0,#0x0	; 02320690
	beq loc_023206A4	; 02320692
	cmp r4,#0x2	; 02320694
	bne loc_023206A4	; 02320696
loc_02320698:
	bl loc_023207B0	; 02320698
	mov r1,#0x2	; 0232069C
	ldr r0,[pool_0232079C]	; 0232069E
	str r1,[r0,#0x4]	; 023206A0
	b loc_0232078C	; 023206A2
loc_023206A4:
	ldr r0,[pool_023207A0]	; 023206A4
	ldr r0,[r0,#0x68]	; 023206A6
	lsl r0,r0,#0x1b	; 023206A8
	lsr r0,r0,#0x1f	; 023206AA
	cmp r0,#0x0	; 023206AC
	beq loc_023206BC	; 023206AE
	add r0,r5,#0x0	; 023206B0
	mov r1,#0x1	; 023206B2
	bl loc_02321CCC	; 023206B4
	cmp r0,#0x0	; 023206B8
	bne loc_023206CA	; 023206BA
loc_023206BC:
	mov r0,#0x1	; 023206BC
	bl loc_02324108	; 023206BE
	cmp r0,#0x0	; 023206C2
	beq loc_023206D6	; 023206C4
	cmp r4,#0x4	; 023206C6
	bne loc_023206D6	; 023206C8
loc_023206CA:
	bl loc_023207B0	; 023206CA
	mov r1,#0x4	; 023206CE
	ldr r0,[pool_0232079C]	; 023206D0
	str r1,[r0,#0x4]	; 023206D2
	b loc_0232078C	; 023206D4
loc_023206D6:
	ldr r0,[pool_023207A0]	; 023206D6
	ldr r0,[r0,#0x68]	; 023206D8
	lsl r0,r0,#0x1a	; 023206DA
	lsr r0,r0,#0x1f	; 023206DC
	cmp r0,#0x0	; 023206DE
	beq loc_023206EE	; 023206E0
	add r0,r5,#0x0	; 023206E2
	mov r1,#0x3	; 023206E4
	bl loc_02321CCC	; 023206E6
	cmp r0,#0x0	; 023206EA
	bne loc_023206FC	; 023206EC
loc_023206EE:
	mov r0,#0x1	; 023206EE
	bl loc_02324108	; 023206F0
	cmp r0,#0x0	; 023206F4
	beq loc_02320708	; 023206F6
	cmp r4,#0x1	; 023206F8
	bne loc_02320708	; 023206FA
loc_023206FC:
	bl loc_023207B0	; 023206FC
	mov r1,#0x1	; 02320700
	ldr r0,[pool_0232079C]	; 02320702
	str r1,[r0,#0x4]	; 02320704
	b loc_0232078C	; 02320706
loc_02320708:
	add r0,r5,#0x0	; 02320708
	mov r1,#0x4	; 0232070A
	bl loc_02321CC4	; 0232070C
	cmp r0,#0x0	; 02320710
	bne loc_02320722	; 02320712
	mov r0,#0x1	; 02320714
	bl loc_02324108	; 02320716
	cmp r0,#0x0	; 0232071A
	beq loc_0232073E	; 0232071C
	cmp r4,#0x5	; 0232071E
	bne loc_0232073E	; 02320720
loc_02320722:
	mov r0,#0x26	; 02320722
	bl loc_023236E0	; 02320724
	bl loc_023253A0	; 02320728
	ldr r1,[pool_023207A0]	; 0232072C
	ldr r2,[r1,#0x68]	; 0232072E
	mov r0,#0x80	; 02320730
	orr r2,r0	; 02320732
	str r2,[r1,#0x68]	; 02320734
	mov r1,#0x8	; 02320736
	ldr r0,[pool_02320798]	; 02320738
	str r1,[r0,#0x2c]	; 0232073A
	b loc_0232078C	; 0232073C
loc_0232073E:
	add r0,r5,#0x0	; 0232073E
	mov r1,#0x6	; 02320740
	bl loc_02321CC4	; 02320742
	cmp r0,#0x0	; 02320746
	bne loc_02320758	; 02320748
	mov r0,#0x1	; 0232074A
	bl loc_02324108	; 0232074C
	cmp r0,#0x0	; 02320750
	beq loc_0232078C	; 02320752
	cmp r4,#0x6	; 02320754
	bne loc_0232078C	; 02320756
loc_02320758:
	ldr r1,[pool_023207A8]	; 02320758
	ldrh r3,[r1,#0x0]	; 0232075A
	mov r2,#0x30	; 0232075C
	add r0,r3,#0x0	; 0232075E
	bic r0,r2	; 02320760
	lsl r2,r3,#0x1a	; 02320762
	lsr r2,r2,#0x1e	; 02320764
	add r2,r2,#0x1	; 02320766
	mov r3,#0x3	; 02320768
	and r2,r3	; 0232076A
	lsl r2,r2,#0x18	; 0232076C
	lsr r2,r2,#0x18	; 0232076E
	lsl r2,r2,#0x10	; 02320770
	lsr r2,r2,#0x10	; 02320772
	and r2,r3	; 02320774
	lsl r2,r2,#0x4	; 02320776
	orr r0,r2	; 02320778
	strh r0,[r1,#0x0]	; 0232077A
	bl loc_02326E28	; 0232077C
	mov r0,#0x2d	; 02320780
	bl loc_023236E0	; 02320782
	ldr r0,[pool_023207AC]	; 02320786
	bl loc_023282A8	; 02320788
loc_0232078C:
	add sp,#0x4	; 0232078C
	pop {r4,r5}	; 0232078E
	pop {r3}	; 02320790
	bx r3	; 02320792
pool_02320794:
loc_02320794:
	.word P1_BssStart	; 02320794
pool_02320798:
loc_02320798:
	.word P1_BssStart + 0x100	; 02320798
pool_0232079C:
loc_0232079C:
	.word P1_BssStart + 0xB00	; 0232079C
pool_023207A0:
loc_023207A0:
	.word P1_BssStart + 0x1300	; 023207A0
pool_023207A4:
loc_023207A4:
	.word 0x00000800	; 023207A4
pool_023207A8:
loc_023207A8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023207A8
pool_023207AC:
loc_023207AC:
	.word 0x027FFC80	; 023207AC

; ===== function loc_023207B0 =====
loc_023207B0:
	push {lr}	; 023207B0
	sub sp,#0x4	; 023207B2
	mov r0,#0x1a	; 023207B4
	bl loc_023236E0	; 023207B6
	mov r1,#0x6	; 023207BA
	ldr r0,[pool_023207C8]	; 023207BC
	str r1,[r0,#0x2c]	; 023207BE
	add sp,#0x4	; 023207C0
	pop {r3}	; 023207C2
	bx r3	; 023207C4
	.byte 0xC0, 0x46	; 023207C8
pool_023207C8:
loc_023207C8:
	.word P1_BssStart + 0x100	; 023207C8

; ===== function loc_023207CC =====
loc_023207CC:
	push {lr}	; 023207CC
	sub sp,#0x4	; 023207CE
	ldr r0,[pool_02320808]	; 023207D0
	ldr r1,[r0,#0x8]	; 023207D2
	add r1,r1,#0x1	; 023207D4
	str r1,[r0,#0x8]	; 023207D6
	cmp r1,#0xf	; 023207D8
	bgt loc_023207F2	; 023207DA
	lsl r0,r1,#0x4	; 023207DC
	mov r1,#0xf	; 023207DE
	blx P1_SignedDivMod	; 023207E0
	mov r1,#0x10	; 023207E4
	sub r1,r1,r0	; 023207E6
	lsl r1,r1,#0x8	; 023207E8
	orr r0,r1	; 023207EA
	ldr r1,[pool_0232080C]	; 023207EC
	strh r0,[r1,#0x0]	; 023207EE
	b loc_02320800	; 023207F0
loc_023207F2:
	mov r2,#0x0	; 023207F2
	ldr r1,[pool_02320810]	; 023207F4
	strh r2,[r1,#0x0]	; 023207F6
	str r2,[r0,#0x8]	; 023207F8
	mov r1,#0x5	; 023207FA
	ldr r0,[pool_02320814]	; 023207FC
	str r1,[r0,#0x2c]	; 023207FE
loc_02320800:
	add sp,#0x4	; 02320800
	pop {r3}	; 02320802
	bx r3	; 02320804
	.byte 0xC0, 0x46	; 02320808
pool_02320808:
loc_02320808:
	.word P1_BssStart + 0xB00	; 02320808
pool_0232080C:
loc_0232080C:
	.word REG_BLDALPHA_SUB	; 0232080C
pool_02320810:
loc_02320810:
	.word REG_BLDCNT_SUB	; 02320810
pool_02320814:
loc_02320814:
	.word P1_BssStart + 0x100	; 02320814

; ===== function loc_02320818 =====
loc_02320818:
	push {lr}	; 02320818
	sub sp,#0x4	; 0232081A
	ldr r0,[pool_0232086C]	; 0232081C
	ldr r1,[r0,#0x8]	; 0232081E
	add r1,r1,#0x1	; 02320820
	str r1,[r0,#0x8]	; 02320822
	cmp r1,#0xf	; 02320824
	bgt loc_0232083E	; 02320826
	lsl r0,r1,#0x4	; 02320828
	mov r1,#0xf	; 0232082A
	blx P1_SignedDivMod	; 0232082C
	mov r1,#0x10	; 02320830
	sub r1,r1,r0	; 02320832
	lsl r1,r1,#0x8	; 02320834
	orr r0,r1	; 02320836
	ldr r1,[pool_02320870]	; 02320838
	strh r0,[r1,#0x0]	; 0232083A
	b loc_02320864	; 0232083C
loc_0232083E:
	mov r0,#0x10	; 0232083E
	str r0,[sp,#0x0]	; 02320840
	ldr r0,[pool_02320874]	; 02320842
	mov r1,#0x0	; 02320844
	mov r2,#0x2	; 02320846
	add r3,r1,#0x0	; 02320848
	bl loc_0232D958	; 0232084A
	mov r1,#0x0	; 0232084E
	ldr r0,[pool_0232086C]	; 02320850
	str r1,[r0,#0x8]	; 02320852
	ldr r1,[pool_02320878]	; 02320854
	ldr r2,[r1,#0x68]	; 02320856
	mov r0,#0x2	; 02320858
	orr r2,r0	; 0232085A
	str r2,[r1,#0x68]	; 0232085C
	mov r1,#0x4	; 0232085E
	ldr r0,[pool_0232087C]	; 02320860
	str r1,[r0,#0x2c]	; 02320862
loc_02320864:
	add sp,#0x4	; 02320864
	pop {r3}	; 02320866
	bx r3	; 02320868
	.byte 0xC0, 0x46	; 0232086C
pool_0232086C:
loc_0232086C:
	.word P1_BssStart + 0xB00	; 0232086C
pool_02320870:
loc_02320870:
	.word REG_BLDALPHA_SUB	; 02320870
pool_02320874:
loc_02320874:
	.word REG_BLDCNT_SUB	; 02320874
pool_02320878:
loc_02320878:
	.word P1_BssStart + 0x1300	; 02320878
pool_0232087C:
loc_0232087C:
	.word P1_BssStart + 0x100	; 0232087C

; 以 16 级步进更新启动背光 PWM；完成时清除渐变状态位。
; Advances the boot backlight PWM in 16 steps and clears the fade flag when done.
P1_UpdateBootBacklightFade:
loc_02320880:
	push {r4,r5,lr}	; 02320880
	sub sp,#0x4	; 02320882
	mov r5,#0x0	; 02320884
	bl P1_GetFirmwareUiContext	; 02320886
	add r4,r0,#0x0	; 0232088A
	ldr r0,[pool_02320944]	; 0232088C
	bl loc_023218D0	; 0232088E
	ldr r0,[pool_02320948]	; 02320892
	ldr r1,[r0,#0x8]	; 02320894
	add r1,r1,#0x1	; 02320896
	str r1,[r0,#0x8]	; 02320898
	cmp r1,#0xf	; 0232089A
	bgt loc_023208CC	; 0232089C
	lsl r0,r1,#0x4	; 0232089E
	mov r1,#0xf	; 023208A0
	blx P1_SignedDivMod	; 023208A2
	mov r1,#0x10	; 023208A6
	sub r1,r1,r0	; 023208A8
	lsl r0,r0,#0x8	; 023208AA
	orr r1,r0	; 023208AC
	ldr r0,[pool_0232094C]	; 023208AE
	strh r1,[r0,#0x0]	; 023208B0
	ldr r0,[pool_02320948]	; 023208B2
	ldr r0,[r0,#0x8]	; 023208B4
	cmp r0,#0xf	; 023208B6
	bne loc_02320938	; 023208B8
	ldr r1,[pool_02320950]	; 023208BA
	ldr r2,[r1,#0x68]	; 023208BC
	mov r0,#0x1	; 023208BE
	bic r2,r0	; 023208C0
	str r2,[r1,#0x68]	; 023208C2
	ldr r0,[pool_02320954]	; 023208C4
	and r2,r0	; 023208C6
	str r2,[r1,#0x68]	; 023208C8
	b loc_02320938	; 023208CA
loc_023208CC:
	ldr r1,[r4,#0x0]	; 023208CC
	lsl r0,r1,#0x1a	; 023208CE
	lsr r0,r0,#0x1f	; 023208D0
	cmp r0,#0x0	; 023208D2
	bne loc_023208DE	; 023208D4
	lsl r0,r1,#0x19	; 023208D6
	lsr r0,r0,#0x1f	; 023208D8
	cmp r0,#0x0	; 023208DA
	beq loc_023208E6	; 023208DC
loc_023208DE:
	bl loc_0232368C	; 023208DE
	mov r5,#0x4	; 023208E2
	b loc_02320938	; 023208E4
loc_023208E6:
	lsl r0,r1,#0x17	; 023208E6
	lsr r0,r0,#0x1f	; 023208E8
	cmp r0,#0x0	; 023208EA
	beq loc_023208F6	; 023208EC
	bl loc_0232368C	; 023208EE
	mov r5,#0x1	; 023208F2
	b loc_02320938	; 023208F4
loc_023208F6:
	bl loc_0232368C	; 023208F6
	ldr r1,[pool_02320958]	; 023208FA
	ldr r2,[r1,#0x0]	; 023208FC
	ldr r0,[pool_0232095C]	; 023208FE
	and r2,r0	; 02320900
	ldr r0,[pool_02320960]	; 02320902
	orr r2,r0	; 02320904
	str r2,[r1,#0x0]	; 02320906
	mov r0,#0x10	; 02320908
	str r0,[sp,#0x0]	; 0232090A
	ldr r0,[pool_02320964]	; 0232090C
	mov r1,#0x2	; 0232090E
	mov r2,#0x20	; 02320910
	lsl r3,r5,#0	; 02320912
	bl loc_0232D958	; 02320914
	bl loc_02322A1C	; 02320918
	ldr r1,[pool_02320950]	; 0232091C
	ldr r2,[r1,#0x68]	; 0232091E
	mov r0,#0x8	; 02320920
	orr r2,r0	; 02320922
	str r2,[r1,#0x68]	; 02320924
	mov r0,#0x4	; 02320926
	orr r2,r0	; 02320928
	str r2,[r1,#0x68]	; 0232092A
	lsl r1,r5,#0	; 0232092C
	ldr r0,[pool_02320948]	; 0232092E
	str r1,[r0,#0x8]	; 02320930
	mov r1,#0x3	; 02320932
	ldr r0,[pool_02320968]	; 02320934
	str r1,[r0,#0x2c]	; 02320936
loc_02320938:
	add r0,r5,#0x0	; 02320938
	add sp,#0x4	; 0232093A
	pop {r4,r5}	; 0232093C
	pop {r3}	; 0232093E
	bx r3	; 02320940
	.byte 0xC0, 0x46	; 02320944
pool_02320944:
loc_02320944:
	.word 0x02330C40	; 02320944
pool_02320948:
loc_02320948:
	.word P1_BssStart + 0xB00	; 02320948
pool_0232094C:
loc_0232094C:
	.word REG_BLDALPHA_SUB	; 0232094C
pool_02320950:
loc_02320950:
	.word P1_BssStart + 0x1300	; 02320950
pool_02320954:
loc_02320954:
	.word 0xFFFFFDFF	; 02320954
pool_02320958:
loc_02320958:
	.word REG_DISPCNT_B	; 02320958
pool_0232095C:
loc_0232095C:
	.word 0xFFFFE0FF	; 0232095C
pool_02320960:
loc_02320960:
	.word 0x00001200	; 02320960
pool_02320964:
loc_02320964:
	.word REG_BLDCNT_SUB	; 02320964
pool_02320968:
loc_02320968:
	.word P1_BssStart + 0x100	; 02320968

; ===== function loc_0232096C =====
loc_0232096C:
	push {r4,r5,lr}	; 0232096C
	sub sp,#0x4	; 0232096E
	ldr r0,[pool_02320A8C]	; 02320970
	ldr r1,[r0,#0x8]	; 02320972
	add r1,r1,#0x1	; 02320974
	str r1,[r0,#0x8]	; 02320976
	ldr r0,[pool_02320A90]	; 02320978
	bl loc_023218D0	; 0232097A
	ldr r0,[pool_02320A94]	; 0232097E
	ldr r0,[r0,#0x68]	; 02320980
	lsl r0,r0,#0x17	; 02320982
	lsr r0,r0,#0x1f	; 02320984
	cmp r0,#0x0	; 02320986
	beq loc_023209F2	; 02320988
	ldr r0,[pool_02320A8C]	; 0232098A
	ldr r5,[r0,#0x8]	; 0232098C
	sub r5,#0x5a	; 0232098E
	add r0,r5,#0x0	; 02320990
	mov r1,#0x1e	; 02320992
	blx P1_SignedDivMod	; 02320994
	add r4,r1,#0x0	; 02320998
	add r0,r5,#0x0	; 0232099A
	mov r1,#0x1e	; 0232099C
	blx P1_SignedDivMod	; 0232099E
	mov r1,#0x1	; 023209A2
	and r0,r1	; 023209A4
	cmp r0,#0x0	; 023209A6
	beq loc_023209D0	; 023209A8
	mov r0,#0x1f	; 023209AA
	add r5,r4,#0x0	; 023209AC
	mul r5,r0	; 023209AE
	add r0,r5,#0x0	; 023209B0
	mov r1,#0x1e	; 023209B2
	blx P1_SignedDivMod	; 023209B4
	ldr r1,[pool_02320A94]	; 023209B8
	str r0,[r1,#0x5c]	; 023209BA
	mov r1,#0x1e	; 023209BC
	sub r2,r1,r4	; 023209BE
	mov r0,#0x14	; 023209C0
	mul r2,r0	; 023209C2
	add r0,r5,r2	; 023209C4
	blx P1_SignedDivMod	; 023209C6
	ldr r1,[pool_02320A94]	; 023209CA
	str r0,[r1,#0x60]	; 023209CC
	b loc_023209F2	; 023209CE
loc_023209D0:
	mov r1,#0x1e	; 023209D0
	sub r5,r1,r4	; 023209D2
	mov r0,#0x1f	; 023209D4
	mul r5,r0	; 023209D6
	add r0,r5,#0x0	; 023209D8
	blx P1_SignedDivMod	; 023209DA
	ldr r1,[pool_02320A94]	; 023209DE
	str r0,[r1,#0x5c]	; 023209E0
	mov r0,#0x14	; 023209E2
	mul r4,r0	; 023209E4
	add r0,r4,r5	; 023209E6
	mov r1,#0x1e	; 023209E8
	blx P1_SignedDivMod	; 023209EA
	ldr r1,[pool_02320A94]	; 023209EE
	str r0,[r1,#0x60]	; 023209F0
loc_023209F2:
	ldr r0,[pool_02320A8C]	; 023209F2
	ldr r0,[r0,#0x8]	; 023209F4
	cmp r0,#0x5a	; 023209F6
	bne loc_02320A04	; 023209F8
	ldr r1,[pool_02320A94]	; 023209FA
	ldr r2,[r1,#0x68]	; 023209FC
	ldr r0,[pool_02320A98]	; 023209FE
	orr r2,r0	; 02320A00
	str r2,[r1,#0x68]	; 02320A02
loc_02320A04:
	ldr r0,[pool_02320A8C]	; 02320A04
	ldr r0,[r0,#0x8]	; 02320A06
	cmp r0,#0x5a	; 02320A08
	ble loc_02320A82	; 02320A0A
	ldr r0,[pool_02320A9C]	; 02320A0C
	bl loc_023240F8	; 02320A0E
	cmp r0,#0x0	; 02320A12
	bne loc_02320A44	; 02320A14
	bl loc_023240DC	; 02320A16
	cmp r0,#0x0	; 02320A1A
	bne loc_02320A44	; 02320A1C
	ldr r0,[pool_02320A8C]	; 02320A1E
	ldr r1,[r0,#0x8]	; 02320A20
	ldr r0,[pool_02320AA0]	; 02320A22
	cmp r1,r0	; 02320A24
	bgt loc_02320A44	; 02320A26
	bl P1_GetFirmwareUiContext	; 02320A28
	ldr r0,[r0,#0x0]	; 02320A2C
	lsl r0,r0,#0x17	; 02320A2E
	lsr r0,r0,#0x1f	; 02320A30
	cmp r0,#0x0	; 02320A32
	bne loc_02320A44	; 02320A34
	bl P1_GetFirmwareUiContext	; 02320A36
	ldr r0,[r0,#0x0]	; 02320A3A
	lsl r0,r0,#0x19	; 02320A3C
	lsr r0,r0,#0x1f	; 02320A3E
	cmp r0,#0x0	; 02320A40
	beq loc_02320A82	; 02320A42
loc_02320A44:
	ldr r0,[pool_02320A8C]	; 02320A44
	ldr r1,[r0,#0x8]	; 02320A46
	ldr r0,[pool_02320AA0]	; 02320A48
	cmp r1,r0	; 02320A4A
	bgt loc_02320A70	; 02320A4C
	bl P1_GetFirmwareUiContext	; 02320A4E
	ldr r0,[r0,#0x0]	; 02320A52
	lsl r0,r0,#0x17	; 02320A54
	lsr r0,r0,#0x1f	; 02320A56
	cmp r0,#0x0	; 02320A58
	bne loc_02320A70	; 02320A5A
	bl P1_GetFirmwareUiContext	; 02320A5C
	ldr r0,[r0,#0x0]	; 02320A60
	lsl r0,r0,#0x19	; 02320A62
	lsr r0,r0,#0x1f	; 02320A64
	cmp r0,#0x0	; 02320A66
	bne loc_02320A70	; 02320A68
	mov r0,#0x31	; 02320A6A
	bl loc_023236E0	; 02320A6C
loc_02320A70:
	ldr r0,[pool_02320A90]	; 02320A70
	bl loc_023218AC	; 02320A72
	mov r1,#0x0	; 02320A76
	ldr r0,[pool_02320A8C]	; 02320A78
	str r1,[r0,#0x8]	; 02320A7A
	mov r1,#0x2	; 02320A7C
	ldr r0,[pool_02320AA4]	; 02320A7E
	str r1,[r0,#0x2c]	; 02320A80
loc_02320A82:
	add sp,#0x4	; 02320A82
	pop {r4,r5}	; 02320A84
	pop {r3}	; 02320A86
	bx r3	; 02320A88
	.byte 0xC0, 0x46	; 02320A8C
pool_02320A8C:
loc_02320A8C:
	.word P1_BssStart + 0xB00	; 02320A8C
pool_02320A90:
loc_02320A90:
	.word 0x02330C40	; 02320A90
pool_02320A94:
loc_02320A94:
	.word P1_BssStart + 0x1300	; 02320A94
pool_02320A98:
loc_02320A98:
	.word 0x00000100	; 02320A98
pool_02320A9C:
loc_02320A9C:
	.word 0x00000FFF	; 02320A9C
pool_02320AA0:
loc_02320AA0:
	.word 0x00000E10	; 02320AA0
pool_02320AA4:
loc_02320AA4:
	.word P1_BssStart + 0x100	; 02320AA4

; ===== function loc_02320AA8 =====
loc_02320AA8:
	push {lr}	; 02320AA8
	sub sp,#0x4	; 02320AAA
	ldr r0,[pool_02320AE8]	; 02320AAC
	ldr r1,[r0,#0x8]	; 02320AAE
	add r1,r1,#0x1	; 02320AB0
	str r1,[r0,#0x8]	; 02320AB2
	ldr r0,[pool_02320AEC]	; 02320AB4
	bl loc_023218D0	; 02320AB6
	ldr r0,[pool_02320AE8]	; 02320ABA
	ldr r1,[r0,#0x8]	; 02320ABC
	cmp r1,#0xf	; 02320ABE
	bgt loc_02320AD8	; 02320AC0
	lsl r0,r1,#0x4	; 02320AC2
	mov r1,#0xf	; 02320AC4
	blx P1_SignedDivMod	; 02320AC6
	mov r1,#0x10	; 02320ACA
	sub r1,r1,r0	; 02320ACC
	lsl r1,r1,#0x8	; 02320ACE
	orr r0,r1	; 02320AD0
	ldr r1,[pool_02320AF0]	; 02320AD2
	strh r0,[r1,#0x0]	; 02320AD4
	b loc_02320AE2	; 02320AD6
loc_02320AD8:
	mov r1,#0x0	; 02320AD8
	str r1,[r0,#0x8]	; 02320ADA
	mov r1,#0x1	; 02320ADC
	ldr r0,[pool_02320AF4]	; 02320ADE
	str r1,[r0,#0x2c]	; 02320AE0
loc_02320AE2:
	add sp,#0x4	; 02320AE2
	pop {r3}	; 02320AE4
	bx r3	; 02320AE6
pool_02320AE8:
loc_02320AE8:
	.word P1_BssStart + 0xB00	; 02320AE8
pool_02320AEC:
loc_02320AEC:
	.word 0x02330C40	; 02320AEC
pool_02320AF0:
loc_02320AF0:
	.word REG_BLDALPHA_SUB	; 02320AF0
pool_02320AF4:
loc_02320AF4:
	.word P1_BssStart + 0x100	; 02320AF4

; ===== function loc_02320AF8 =====
loc_02320AF8:
	push {r4,r5,r6,r7,lr}	; 02320AF8
	sub sp,#0x54	; 02320AFA
	bl loc_02323E38	; 02320AFC
	add r7,r0,#0x0	; 02320B00
	bl loc_023254FC	; 02320B02
	bl loc_023250B8	; 02320B06
	ldr r0,[pool_02320D90]	; 02320B0A
	ldr r0,[r0,#0x54]	; 02320B0C
	lsl r0,r0,#0x1e	; 02320B0E
	lsr r0,r0,#0x1f	; 02320B10
	cmp r0,#0x0	; 02320B12
	beq loc_02320B32	; 02320B14
	mov r0,#0x1	; 02320B16
	str r0,[sp,#0x0]	; 02320B18
	ldr r0,[pool_02320D94]	; 02320B1A
	mov r1,#0x0	; 02320B1C
	add r2,r1,#0x0	; 02320B1E
	add r3,r1,#0x0	; 02320B20
	bl loc_0232373C	; 02320B22
	add r0,r7,#0x0	; 02320B26
	ldr r1,[pool_02320D98]	; 02320B28
	ldr r2,[pool_02320D9C]	; 02320B2A
	mov r3,#0x0	; 02320B2C
	bl loc_02323C28	; 02320B2E
loc_02320B32:
	ldr r0,[pool_02320DA0]	; 02320B32
	ldr r0,[r0,#0x68]	; 02320B34
	lsl r0,r0,#0x1f	; 02320B36
	lsr r0,r0,#0x1f	; 02320B38
	cmp r0,#0x0	; 02320B3A
	beq loc_02320B4C	; 02320B3C
	add r0,r7,#0x0	; 02320B3E
	ldr r1,[pool_02320DA4]	; 02320B40
	ldr r2,[pool_02320DA8]	; 02320B42
	ldr r2,[r2,#0x14]	; 02320B44
	mov r3,#0x1	; 02320B46
	bl loc_02323B80	; 02320B48
loc_02320B4C:
	ldr r0,[pool_02320DA0]	; 02320B4C
	ldr r1,[r0,#0x68]	; 02320B4E
	lsl r0,r1,#0x16	; 02320B50
	lsr r0,r0,#0x1f	; 02320B52
	cmp r0,#0x0	; 02320B54
	beq loc_02320B62	; 02320B56
	ldr r0,[pool_02320DAC]	; 02320B58
	lsl r1,r1,#0x1b	; 02320B5A
	lsr r1,r1,#0x1f	; 02320B5C
	bl loc_023219E0	; 02320B5E
loc_02320B62:
	ldr r0,[pool_02320DA0]	; 02320B62
	ldr r0,[r0,#0x68]	; 02320B64
	lsl r0,r0,#0x1e	; 02320B66
	lsr r0,r0,#0x1f	; 02320B68
	cmp r0,#0x0	; 02320B6A
	bne loc_02320B70	; 02320B6C
	b loc_02320D88	; 02320B6E
loc_02320B70:
	mov r4,#0x0	; 02320B70
loc_02320B72:
	add r1,r4,#0x0	; 02320B72
	mov r0,#0xc	; 02320B74
	mul r1,r0	; 02320B76
	ldr r0,[pool_02320DB0]	; 02320B78
	add r5,r0,r1	; 02320B7A
	ldr r0,[r5,#0x4]	; 02320B7C
	ldr r1,[pool_02320DB4]	; 02320B7E
	blx P1_SignedDivMod	; 02320B80
	ldr r1,[pool_02320DA8]	; 02320B84
	ldr r1,[r1,#0x10]	; 02320B86
	add r6,r1,r0	; 02320B88
	cmp r6,#0xf0	; 02320B8A
	ble loc_02320B90	; 02320B8C
	mov r6,#0xf0	; 02320B8E
loc_02320B90:
	ldr r0,[r5,#0x0]	; 02320B90
	ldr r1,[pool_02320DB4]	; 02320B92
	blx P1_SignedDivMod	; 02320B94
	str r0,[sp,#0x0]	; 02320B98
	str r6,[sp,#0x4]	; 02320B9A
	mov r0,#0x1	; 02320B9C
	str r0,[sp,#0x8]	; 02320B9E
	add r0,r7,#0x0	; 02320BA0
	ldr r1,[pool_02320D98]	; 02320BA2
	ldr r2,[pool_02320DB8]	; 02320BA4
	ldr r3,[r5,#0x8]	; 02320BA6
	bl loc_02323B2C	; 02320BA8
	add r4,r4,#0x1	; 02320BAC
	cmp r4,#0x4	; 02320BAE
	blt loc_02320B72	; 02320BB0
	mov r0,#0x0	; 02320BB2
	str r0,[sp,#0x24]	; 02320BB4
	ldr r1,[pool_02320DBC]	; 02320BB6
	ldr r0,[r1,#0x4]	; 02320BB8
	str r0,[sp,#0x18]	; 02320BBA
	ldr r0,[r1,#0x8]	; 02320BBC
	str r0,[sp,#0x1c]	; 02320BBE
	ldr r0,[r1,#0x0]	; 02320BC0
	str r0,[sp,#0x20]	; 02320BC2
	ldr r0,[sp,#0x24]	; 02320BC4
	str r0,[sp,#0x28]	; 02320BC6
	str r0,[sp,#0x2c]	; 02320BC8
	str r0,[sp,#0x30]	; 02320BCA
	str r0,[sp,#0x40]	; 02320BCC
	str r0,[sp,#0x3c]	; 02320BCE
	str r0,[sp,#0x38]	; 02320BD0
	str r0,[sp,#0x34]	; 02320BD2
	str r0,[sp,#0x44]	; 02320BD4
loc_02320BD6:
	ldr r1,[sp,#0x24]	; 02320BD6
	mov r0,#0x3c	; 02320BD8
	mul r1,r0	; 02320BDA
	ldr r0,[pool_02320DC0]	; 02320BDC
	add r5,r0,r1	; 02320BDE
	mov r4,#0x1	; 02320BE0
	mov r0,#0x2	; 02320BE2
	ldrsh r1,[r5,r0]	; 02320BE4
	ldr r0,[pool_02320DA8]	; 02320BE6
	ldr r0,[r0,#0x10]	; 02320BE8
	add r6,r1,r0	; 02320BEA
	cmp r6,#0x80	; 02320BEC
	ble loc_02320BF2	; 02320BEE
	mov r6,#0x80	; 02320BF0
loc_02320BF2:
	ldr r0,[pool_02320DA8]	; 02320BF2
	ldr r1,[r0,#0x4]	; 02320BF4
	ldr r0,[sp,#0x24]	; 02320BF6
	cmp r0,r1	; 02320BF8
	bne loc_02320BFE	; 02320BFA
	ldr r4,[sp,#0x28]	; 02320BFC
loc_02320BFE:
	ldr r0,[r5,#0x8]	; 02320BFE
	cmp r0,#0x0	; 02320C00
	blt loc_02320C16	; 02320C02
	str r4,[sp,#0x0]	; 02320C04
	add r0,r5,#0x0	; 02320C06
	add r0,#0x10	; 02320C08
	ldr r1,[sp,#0x30]	; 02320C0A
	ldrsh r1,[r5,r1]	; 02320C0C
	add r2,r6,#0x0	; 02320C0E
	mov r3,#0x1	; 02320C10
	bl loc_0232373C	; 02320C12
loc_02320C16:
	ldr r0,[pool_02320DC4]	; 02320C16
	ldr r1,[r5,#0xc]	; 02320C18
	bl loc_02321CBC	; 02320C1A
	cmp r0,#0x0	; 02320C1E
	beq loc_02320C2C	; 02320C20
	cmp r0,#0x1	; 02320C22
	beq loc_02320C2C	; 02320C24
	cmp r0,#0x2	; 02320C26
	beq loc_02320C32	; 02320C28
	b loc_02320C38	; 02320C2A
loc_02320C2C:
	ldr r0,[sp,#0x18]	; 02320C2C
	str r0,[sp,#0x14]	; 02320C2E
	b loc_02320C3C	; 02320C30
loc_02320C32:
	ldr r0,[sp,#0x1c]	; 02320C32
	str r0,[sp,#0x14]	; 02320C34
	b loc_02320C3C	; 02320C36
loc_02320C38:
	ldr r0,[sp,#0x20]	; 02320C38
	str r0,[sp,#0x14]	; 02320C3A
loc_02320C3C:
	ldr r0,[sp,#0x24]	; 02320C3C
	cmp r0,#0x4	; 02320C3E
	bne loc_02320CA4	; 02320C40
	ldr r0,[pool_02320DA0]	; 02320C42
	ldr r0,[r0,#0x68]	; 02320C44
	lsl r0,r0,#0x1b	; 02320C46
	lsr r0,r0,#0x1f	; 02320C48
	cmp r0,#0x0	; 02320C4A
	beq loc_02320C80	; 02320C4C
	ldr r0,[sp,#0x34]	; 02320C4E
	ldrsh r1,[r5,r0]	; 02320C50
	add r1,#0x28	; 02320C52
	ldr r0,[pool_02320DC8]	; 02320C54
	and r1,r0	; 02320C56
	lsl r1,r1,#0x10	; 02320C58
	add r0,r6,#0x0	; 02320C5A
	add r0,#0x4f	; 02320C5C
	mov r2,#0xff	; 02320C5E
	and r0,r2	; 02320C60
	lsl r2,r4,#0xa	; 02320C62
	orr r0,r2	; 02320C64
	ldr r2,[pool_02320DCC]	; 02320C66
	orr r0,r2	; 02320C68
	orr r1,r0	; 02320C6A
	str r1,[sp,#0x48]	; 02320C6C
	ldr r1,[pool_02320DD0]	; 02320C6E
	add r0,sp,#0x48	; 02320C70
	strh r1,[r0,#0x4]	; 02320C72
	add r0,r7,#0x0	; 02320C74
	add r1,sp,#0x48	; 02320C76
	ldr r2,[sp,#0x2c]	; 02320C78
	bl loc_0232395C	; 02320C7A
	b loc_02320D12	; 02320C7E
loc_02320C80:
	mov r0,#0x4	; 02320C80
	str r0,[sp,#0x14]	; 02320C82
	ldr r0,[sp,#0x38]	; 02320C84
	ldrsh r0,[r5,r0]	; 02320C86
	str r0,[sp,#0x0]	; 02320C88
	str r6,[sp,#0x4]	; 02320C8A
	mov r0,#0x4	; 02320C8C
	str r0,[sp,#0x8]	; 02320C8E
	str r4,[sp,#0xc]	; 02320C90
	mov r0,#0x1	; 02320C92
	str r0,[sp,#0x10]	; 02320C94
	add r0,r7,#0x0	; 02320C96
	ldr r1,[pool_02320D98]	; 02320C98
	ldr r2,[pool_02320DB8]	; 02320C9A
	mov r3,#0x4	; 02320C9C
	bl loc_023239F0	; 02320C9E
	b loc_02320D12	; 02320CA2
loc_02320CA4:
	cmp r0,#0x1	; 02320CA4
	bne loc_02320CE8	; 02320CA6
	ldr r0,[pool_02320DA0]	; 02320CA8
	ldr r1,[r0,#0x68]	; 02320CAA
	lsl r0,r1,#0x1a	; 02320CAC
	lsr r0,r0,#0x1f	; 02320CAE
	cmp r0,#0x0	; 02320CB0
	bne loc_02320CC8	; 02320CB2
	mov r0,#0x4	; 02320CB4
	str r0,[sp,#0x14]	; 02320CB6
	lsl r0,r1,#0x19	; 02320CB8
	lsr r0,r0,#0x1f	; 02320CBA
	cmp r0,#0x0	; 02320CBC
	bne loc_02320CC4	; 02320CBE
	mov r1,#0x4	; 02320CC0
	b loc_02320CCA	; 02320CC2
loc_02320CC4:
	ldr r1,[sp,#0x20]	; 02320CC4
	b loc_02320CCA	; 02320CC6
loc_02320CC8:
	ldr r1,[sp,#0x20]	; 02320CC8
loc_02320CCA:
	ldr r0,[sp,#0x3c]	; 02320CCA
	ldrsh r0,[r5,r0]	; 02320CCC
	str r0,[sp,#0x0]	; 02320CCE
	str r6,[sp,#0x4]	; 02320CD0
	str r1,[sp,#0x8]	; 02320CD2
	str r4,[sp,#0xc]	; 02320CD4
	mov r0,#0x1	; 02320CD6
	str r0,[sp,#0x10]	; 02320CD8
	add r0,r7,#0x0	; 02320CDA
	ldr r1,[pool_02320D98]	; 02320CDC
	ldr r2,[pool_02320DB8]	; 02320CDE
	mov r3,#0x5	; 02320CE0
	bl loc_023239F0	; 02320CE2
	b loc_02320D12	; 02320CE6
loc_02320CE8:
	cmp r0,#0x3	; 02320CE8
	bne loc_02320D12	; 02320CEA
	ldr r0,[pool_02320DA0]	; 02320CEC
	ldr r0,[r0,#0x58]	; 02320CEE
	cmp r0,#0x0	; 02320CF0
	bne loc_02320D12	; 02320CF2
	ldr r0,[sp,#0x40]	; 02320CF4
	ldrsh r0,[r5,r0]	; 02320CF6
	str r0,[sp,#0x0]	; 02320CF8
	str r6,[sp,#0x4]	; 02320CFA
	ldr r0,[sp,#0x14]	; 02320CFC
	str r0,[sp,#0x8]	; 02320CFE
	str r4,[sp,#0xc]	; 02320D00
	mov r0,#0x1	; 02320D02
	str r0,[sp,#0x10]	; 02320D04
	add r0,r7,#0x0	; 02320D06
	ldr r1,[pool_02320D98]	; 02320D08
	ldr r2,[pool_02320DB8]	; 02320D0A
	mov r3,#0xd	; 02320D0C
	bl loc_023239F0	; 02320D0E
loc_02320D12:
	ldr r0,[sp,#0x44]	; 02320D12
	ldrsh r0,[r5,r0]	; 02320D14
	str r0,[sp,#0x0]	; 02320D16
	str r6,[sp,#0x4]	; 02320D18
	ldr r0,[sp,#0x14]	; 02320D1A
	str r0,[sp,#0x8]	; 02320D1C
	str r4,[sp,#0xc]	; 02320D1E
	mov r0,#0x1	; 02320D20
	str r0,[sp,#0x10]	; 02320D22
	add r0,r7,#0x0	; 02320D24
	ldr r1,[pool_02320D98]	; 02320D26
	ldr r2,[pool_02320DB8]	; 02320D28
	ldr r3,[r5,#0x4]	; 02320D2A
	bl loc_023239F0	; 02320D2C
	ldr r0,[sp,#0x24]	; 02320D30
	add r0,r0,#0x1	; 02320D32
	str r0,[sp,#0x24]	; 02320D34
	cmp r0,#0x5	; 02320D36
	bge loc_02320D3C	; 02320D38
	b loc_02320BD6	; 02320D3A
loc_02320D3C:
	ldr r0,[pool_02320DA8]	; 02320D3C
	ldr r4,[r0,#0x10]	; 02320D3E
	cmp r4,#0x30	; 02320D40
	blt loc_02320D46	; 02320D42
	mov r4,#0x30	; 02320D44
loc_02320D46:
	mov r0,#0x0	; 02320D46
	str r0,[sp,#0x0]	; 02320D48
	str r4,[sp,#0x4]	; 02320D4A
	mov r0,#0x1	; 02320D4C
	str r0,[sp,#0x8]	; 02320D4E
	str r0,[sp,#0xc]	; 02320D50
	str r0,[sp,#0x10]	; 02320D52
	add r0,r7,#0x0	; 02320D54
	ldr r1,[pool_02320D98]	; 02320D56
	ldr r2,[pool_02320DB8]	; 02320D58
	mov r3,#0x8	; 02320D5A
	bl loc_023239F0	; 02320D5C
	mov r0,#0x0	; 02320D60
	str r0,[sp,#0x0]	; 02320D62
	str r4,[sp,#0x4]	; 02320D64
	ldr r0,[pool_02320DA0]	; 02320D66
	ldr r0,[r0,#0x68]	; 02320D68
	lsl r0,r0,#0x18	; 02320D6A
	lsr r0,r0,#0x1f	; 02320D6C
	lsl r1,r0,#0x2	; 02320D6E
	ldr r0,[pool_02320DD4]	; 02320D70
	ldr r0,[r0,r1]	; 02320D72
	str r0,[sp,#0x8]	; 02320D74
	mov r0,#0x1	; 02320D76
	str r0,[sp,#0xc]	; 02320D78
	str r0,[sp,#0x10]	; 02320D7A
	add r0,r7,#0x0	; 02320D7C
	ldr r1,[pool_02320D98]	; 02320D7E
	ldr r2,[pool_02320DB8]	; 02320D80
	mov r3,#0x7	; 02320D82
	bl loc_023239F0	; 02320D84
loc_02320D88:
	add sp,#0x54	; 02320D88
	pop {r4,r5,r6,r7}	; 02320D8A
	pop {r3}	; 02320D8C
	bx r3	; 02320D8E
pool_02320D90:
loc_02320D90:
	.word P1_BssStart + 0xA80	; 02320D90
pool_02320D94:
loc_02320D94:
	.word 0x02331598	; 02320D94
pool_02320D98:
loc_02320D98:
	.word 0x023C11F8	; 02320D98
pool_02320D9C:
loc_02320D9C:
	.word 0x023A510C	; 02320D9C
pool_02320DA0:
loc_02320DA0:
	.word P1_BssStart + 0x1300	; 02320DA0
pool_02320DA4:
loc_02320DA4:
	.word 0x023D3B3C	; 02320DA4
pool_02320DA8:
loc_02320DA8:
	.word P1_BssStart + 0xB00	; 02320DA8
pool_02320DAC:
loc_02320DAC:
	.word 0x02330C40	; 02320DAC
pool_02320DB0:
loc_02320DB0:
	.word 0x02330C04	; 02320DB0
pool_02320DB4:
loc_02320DB4:
	.word 0x00001000	; 02320DB4
pool_02320DB8:
loc_02320DB8:
	.word 0x023A5064	; 02320DB8
pool_02320DBC:
loc_02320DBC:
	.word P1_Data_0232FEF4	; 02320DBC
pool_02320DC0:
loc_02320DC0:
	.word P1_BssStart	; 02320DC0
pool_02320DC4:
loc_02320DC4:
	.word 0x02330BF4	; 02320DC4
pool_02320DC8:
loc_02320DC8:
	.word 0x000001FF	; 02320DC8
pool_02320DCC:
loc_02320DCC:
	.word 0x80000000	; 02320DCC
pool_02320DD0:
loc_02320DD0:
	.word 0x0000E7FC	; 02320DD0
pool_02320DD4:
loc_02320DD4:
	.word P1_Data_0232FEEC	; 02320DD4

; ===== function loc_02320DD8 =====
loc_02320DD8:
	push {r4,r5,r6,r7,lr}	; 02320DD8
	sub sp,#0x124	; 02320DDA
	bl loc_02324218	; 02320DDC
	bl loc_02324118	; 02320DE0
	mov r0,#0x0	; 02320DE4
	str r0,[sp,#0x8]	; 02320DE6
	ldr r0,[sp,#0x8]	; 02320DE8
	ldr r1,[pool_023211AC]	; 02320DEA
	ldr r2,[pool_023211B0]	; 02320DEC
	blx loc_0232DE68	; 02320DEE
	ldr r0,[pool_023211B4]	; 02320DF2
	bl loc_02321D10	; 02320DF4
	mov r5,#0x0	; 02320DF8
	ldr r4,[pool_023211AC]	; 02320DFA
	ldr r6,[pool_023211B8]	; 02320DFC
	mov r7,#0x3c	; 02320DFE
loc_02320E00:
	add r0,r5,#0x0	; 02320E00
	mul r0,r7	; 02320E02
	lsl r1,r5,#0x4	; 02320E04
	add r3,r6,r1	; 02320E06
	add r2,r4,r0	; 02320E08
	ldmia r3!,{r0,r1}	; 02320E0A
	stmia r2!,{r0,r1}	; 02320E0C
	ldmia r3!,{r0,r1}	; 02320E0E
	stmia r2!,{r0,r1}	; 02320E10
	add r5,r5,#0x1	; 02320E12
	cmp r5,#0x5	; 02320E14
	blt loc_02320E00	; 02320E16
	mov r1,#0x5	; 02320E18
	ldr r0,[pool_023211BC]	; 02320E1A
	str r1,[r0,#0x30]	; 02320E1C
	mov r0,#0x0	; 02320E1E
	mvn r1,r0	; 02320E20
	ldr r0,[pool_023211C0]	; 02320E22
	str r1,[r0,#0x4]	; 02320E24
	mov r0,#0x1f	; 02320E26
	ldr r1,[pool_023211C4]	; 02320E28
	str r0,[r1,#0x5c]	; 02320E2A
	str r0,[r1,#0x60]	; 02320E2C
	ldr r0,[pool_023211C8]	; 02320E2E
	ldrh r0,[r0,#0x0]	; 02320E30
	lsl r0,r0,#0x1d	; 02320E32
	lsr r0,r0,#0x1d	; 02320E34
	str r0,[r1,#0x58]	; 02320E36
	bl loc_02324DAC	; 02320E38
	add r0,sp,#0x10	; 02320E3C
	bl loc_02326A2C	; 02320E3E
	ldr r1,[sp,#0x14]	; 02320E42
	ldr r2,[pool_023211CC]	; 02320E44
	ldrb r0,[r2,#0x0]	; 02320E46
	cmp r1,r0	; 02320E48
	bne loc_02320E58	; 02320E4A
	ldr r1,[sp,#0x18]	; 02320E4C
	ldrb r0,[r2,#0x1]	; 02320E4E
	cmp r1,r0	; 02320E50
	bne loc_02320E58	; 02320E52
	mov r3,#0x1	; 02320E54
	b loc_02320E5A	; 02320E56
loc_02320E58:
	mov r3,#0x0	; 02320E58
loc_02320E5A:
	ldr r1,[pool_023211C4]	; 02320E5A
	ldr r2,[r1,#0x68]	; 02320E5C
	ldr r0,[pool_023211D0]	; 02320E5E
	and r2,r0	; 02320E60
	mov r0,#0x1	; 02320E62
	and r3,r0	; 02320E64
	lsl r0,r3,#0xa	; 02320E66
	orr r2,r0	; 02320E68
	str r2,[r1,#0x68]	; 02320E6A
	bl loc_0232D4AC	; 02320E6C
	ldr r2,[pool_023211D4]	; 02320E70
	ldr r1,[r2,#0x0]	; 02320E72
	ldr r0,[pool_023211D8]	; 02320E74
	and r1,r0	; 02320E76
	str r1,[r2,#0x0]	; 02320E78
	mov r0,#0xc0	; 02320E7A
	str r0,[sp,#0x4]	; 02320E7C
	ldr r0,[sp,#0x4]	; 02320E7E
	ldr r1,[pool_023211DC]	; 02320E80
	ldr r2,[pool_023211E0]	; 02320E82
	blx loc_0232DE68	; 02320E84
	mov r0,#0x0	; 02320E88
	str r0,[sp,#0xc]	; 02320E8A
	ldr r0,[sp,#0xc]	; 02320E8C
	ldr r1,[pool_023211E4]	; 02320E8E
	ldr r2,[pool_023211E0]	; 02320E90
	blx loc_0232DE68	; 02320E92
	mov r0,#0x1	; 02320E96
	bl loc_02326D48	; 02320E98
	mov r0,#0x2	; 02320E9C
	bl loc_02326D1C	; 02320E9E
	mov r0,#0x1	; 02320EA2
	mov r1,#0x0	; 02320EA4
	add r2,r1,#0x0	; 02320EA6
	bl loc_0232D420	; 02320EA8
	ldr r2,[pool_023211E8]	; 02320EAC
	ldrh r1,[r2,#0x0]	; 02320EAE
	mov r0,#0x43	; 02320EB0
	and r1,r0	; 02320EB2
	mov r0,#0x8	; 02320EB4
	orr r1,r0	; 02320EB6
	strh r1,[r2,#0x0]	; 02320EB8
	ldrh r1,[r2,#0x0]	; 02320EBA
	mov r0,#0x3	; 02320EBC
	bic r1,r0	; 02320EBE
	strh r1,[r2,#0x0]	; 02320EC0
	mov r1,#0x0	; 02320EC2
	ldr r0,[pool_023211EC]	; 02320EC4
	str r1,[r0,#0x0]	; 02320EC6
	ldr r2,[pool_023211F0]	; 02320EC8
	ldr r3,[r2,#0x0]	; 02320ECA
	ldr r0,[pool_023211F4]	; 02320ECC
	and r3,r0	; 02320ECE
	ldr r0,[pool_023211F8]	; 02320ED0
	orr r3,r0	; 02320ED2
	str r3,[r2,#0x0]	; 02320ED4
	ldr r2,[pool_023211FC]	; 02320ED6
	ldr r0,[pool_02321200]	; 02320ED8
	sub r6,r2,r0	; 02320EDA
	add r2,r6,#0x0	; 02320EDC
	bl loc_0232DA40	; 02320EDE
	ldr r1,[pool_02321204]	; 02320EE2
	ldr r0,[pool_02321208]	; 02320EE4
	sub r7,r1,r0	; 02320EE6
	mov r1,#0x0	; 02320EE8
	add r2,r7,#0x0	; 02320EEA
	bl loc_0232DD10	; 02320EEC
	ldr r0,[pool_0232120C]	; 02320EF0
	mov r1,#0x0	; 02320EF2
	ldr r2,[pool_02321210]	; 02320EF4
	sub r2,r2,r0	; 02320EF6
	bl loc_0232DB80	; 02320EF8
	ldr r0,[pool_02321214]	; 02320EFC
	mov r1,#0x0	; 02320EFE
	ldr r2,[pool_02321218]	; 02320F00
	sub r2,r2,r0	; 02320F02
	bl loc_0232DCC0	; 02320F04
	ldr r0,[pool_0232121C]	; 02320F08
	mov r1,#0x0	; 02320F0A
	mov r2,#0x2	; 02320F0C
	bl loc_0232DD10	; 02320F0E
	mov r0,#0x4	; 02320F12
	bl loc_02326CF0	; 02320F14
	mov r0,#0x8	; 02320F18
	bl loc_02326CC4	; 02320F1A
	mov r0,#0x0	; 02320F1E
	bl loc_0232D40C	; 02320F20
	ldr r4,[pool_02321220]	; 02320F24
	ldrh r2,[r4,#0x0]	; 02320F26
	mov r1,#0x43	; 02320F28
	and r2,r1	; 02320F2A
	ldr r0,[pool_02321224]	; 02320F2C
	orr r2,r0	; 02320F2E
	strh r2,[r4,#0x0]	; 02320F30
	ldrh r0,[r4,#0x0]	; 02320F32
	mov r2,#0x3	; 02320F34
	bic r0,r2	; 02320F36
	strh r0,[r4,#0x0]	; 02320F38
	ldrh r0,[r4,#0x0]	; 02320F3A
	mov r3,#0x40	; 02320F3C
	bic r0,r3	; 02320F3E
	strh r0,[r4,#0x0]	; 02320F40
	ldr r4,[pool_02321228]	; 02320F42
	mov r0,#0x0	; 02320F44
	str r0,[r4,#0x0]	; 02320F46
	ldr r4,[pool_0232122C]	; 02320F48
	ldrh r5,[r4,#0x0]	; 02320F4A
	and r5,r1	; 02320F4C
	ldr r0,[pool_02321230]	; 02320F4E
	orr r5,r0	; 02320F50
	strh r5,[r4,#0x0]	; 02320F52
	ldrh r0,[r4,#0x0]	; 02320F54
	bic r0,r2	; 02320F56
	orr r0,r2	; 02320F58
	strh r0,[r4,#0x0]	; 02320F5A
	ldrh r0,[r4,#0x0]	; 02320F5C
	bic r0,r3	; 02320F5E
	strh r0,[r4,#0x0]	; 02320F60
	ldr r4,[pool_02321234]	; 02320F62
	ldr r0,[pool_02321238]	; 02320F64
	str r4,[r0,#0x0]	; 02320F66
	ldr r0,[pool_0232123C]	; 02320F68
	ldrh r4,[r0,#0x0]	; 02320F6A
	and r4,r1	; 02320F6C
	ldr r1,[pool_02321240]	; 02320F6E
	orr r4,r1	; 02320F70
	strh r4,[r0,#0x0]	; 02320F72
	ldrh r1,[r0,#0x0]	; 02320F74
	bic r1,r2	; 02320F76
	strh r1,[r0,#0x0]	; 02320F78
	ldrh r1,[r0,#0x0]	; 02320F7A
	bic r1,r3	; 02320F7C
	strh r1,[r0,#0x0]	; 02320F7E
	ldr r1,[pool_02321244]	; 02320F80
	mov r0,#0x0	; 02320F82
	str r0,[r1,#0x0]	; 02320F84
	ldr r2,[pool_023211F0]	; 02320F86
	ldr r3,[r2,#0x0]	; 02320F88
	ldr r0,[pool_02321248]	; 02320F8A
	and r3,r0	; 02320F8C
	ldr r1,[pool_0232124C]	; 02320F8E
	orr r3,r1	; 02320F90
	str r3,[r2,#0x0]	; 02320F92
	ldr r2,[pool_023211D4]	; 02320F94
	ldr r3,[r2,#0x0]	; 02320F96
	and r3,r0	; 02320F98
	orr r3,r1	; 02320F9A
	str r3,[r2,#0x0]	; 02320F9C
	ldr r0,[pool_02321200]	; 02320F9E
	mov r1,#0x0	; 02320FA0
	add r2,r6,#0x0	; 02320FA2
	bl loc_0232DA18	; 02320FA4
	mov r4,#0x0	; 02320FA8
	ldr r6,[pool_02321250]	; 02320FAA
loc_02320FAC:
	lsl r5,r4,#0x6	; 02320FAC
	lsl r0,r4,#0x7	; 02320FAE
	add r0,r6,r0	; 02320FB0
	add r1,r5,#0x0	; 02320FB2
	mov r2,#0x40	; 02320FB4
	bl loc_0232DB58	; 02320FB6
	lsl r0,r4,#0x1	; 02320FBA
	add r0,r0,#0x1	; 02320FBC
	lsl r0,r0,#0x6	; 02320FBE
	add r0,r6,r0	; 02320FC0
	ldr r1,[pool_02321254]	; 02320FC2
	add r1,r5,r1	; 02320FC4
	mov r2,#0x40	; 02320FC6
	bl loc_0232DB58	; 02320FC8
	add r4,r4,#0x1	; 02320FCC
	cmp r4,#0x20	; 02320FCE
	blt loc_02320FAC	; 02320FD0
	bl loc_02325238	; 02320FD2
	ldr r0,[pool_02321258]	; 02320FD6
	ldr r1,[pool_0232125C]	; 02320FD8
	ldr r2,[pool_02321260]	; 02320FDA
	sub r2,r2,r0	; 02320FDC
	blx loc_0232DE50	; 02320FDE
	ldr r0,[pool_02321264]	; 02320FE2
	ldr r1,[pool_02321268]	; 02320FE4
	ldr r2,[pool_0232126C]	; 02320FE6
	sub r2,r2,r0	; 02320FE8
	blx loc_0232DE50	; 02320FEA
	ldr r0,[pool_02321270]	; 02320FEE
	ldr r1,[pool_02321274]	; 02320FF0
	ldr r2,[pool_02321278]	; 02320FF2
	sub r2,r2,r0	; 02320FF4
	blx loc_0232DE50	; 02320FF6
	ldr r0,[pool_0232127C]	; 02320FFA
	ldr r1,[pool_02321280]	; 02320FFC
	ldr r2,[pool_02321284]	; 02320FFE
	sub r2,r2,r0	; 02321000
	blx loc_0232DE50	; 02321002
	bl loc_02323E38	; 02321006
	bl loc_02324010	; 0232100A
	bl loc_02323E38	; 0232100E
	ldr r1,[pool_02321288]	; 02321012
	bl loc_02323F7C	; 02321014
	bl loc_02323E38	; 02321018
	ldr r1,[pool_0232128C]	; 0232101C
	bl loc_02323F7C	; 0232101E
	bl loc_02323E40	; 02321022
	ldr r1,[pool_02321290]	; 02321026
	bl loc_02323F7C	; 02321028
	mov r0,#0x25	; 0232102C
	mov r1,#0x29	; 0232102E
	mov r2,#0x6	; 02321030
	bl loc_0232560C	; 02321032
	bl loc_02325208	; 02321036
	bl loc_02324C28	; 0232103A
	add r4,r0,#0x0	; 0232103E
	ldr r0,[pool_02321288]	; 02321040
	bl loc_023291AC	; 02321042
	add r5,r0,#0x0	; 02321046
	ldr r0,[pool_0232128C]	; 02321048
	bl loc_023291AC	; 0232104A
	add r1,r0,#0x0	; 0232104E
	add r0,r4,#0x0	; 02321050
	add r1,r5,r1	; 02321052
	bl loc_02324BE8	; 02321054
	add r0,r4,#0x0	; 02321058
	bl loc_023255C0	; 0232105A
	add r0,r4,#0x0	; 0232105E
	bl loc_023251B8	; 02321060
	mov r5,#0x0	; 02321064
	ldr r6,[pool_023211AC]	; 02321066
loc_02321068:
	add r1,r5,#0x0	; 02321068
	mov r0,#0x3c	; 0232106A
	mul r1,r0	; 0232106C
	add r1,r6,r1	; 0232106E
	ldr r3,[r1,#0x8]	; 02321070
	cmp r3,#0x0	; 02321072
	blt loc_02321080	; 02321074
	add r0,r4,#0x0	; 02321076
	add r1,#0x10	; 02321078
	ldr r2,[pool_02321294]	; 0232107A
	bl loc_02324BB4	; 0232107C
loc_02321080:
	add r5,r5,#0x1	; 02321080
	cmp r5,#0x5	; 02321082
	blt loc_02321068	; 02321084
	ldr r0,[pool_02321298]	; 02321086
	ldr r1,[r0,#0x0]	; 02321088
	mov r0,#0x2	; 0232108A
	and r1,r0	; 0232108C
	cmp r1,#0x0	; 0232108E
	beq loc_02321096	; 02321090
	mov r2,#0x1	; 02321092
	b loc_02321098	; 02321094
loc_02321096:
	mov r2,#0x0	; 02321096
loc_02321098:
	ldr r0,[pool_023211C4]	; 02321098
	ldr r1,[r0,#0x68]	; 0232109A
	mov r3,#0x10	; 0232109C
	bic r1,r3	; 0232109E
	mov r3,#0x1	; 023210A0
	and r2,r3	; 023210A2
	lsl r2,r2,#0x4	; 023210A4
	orr r1,r2	; 023210A6
	str r1,[r0,#0x68]	; 023210A8
	lsl r0,r1,#0x1b	; 023210AA
	lsr r0,r0,#0x1f	; 023210AC
	cmp r0,#0x0	; 023210AE
	beq loc_023210DE	; 023210B0
	add r0,sp,#0x20	; 023210B2
	ldr r1,[pool_0232129C]	; 023210B4
	bl P1_ClearByteRangeIfNonNull	; 023210B6
	ldr r0,[pool_023212A0]	; 023210BA
	bl loc_023270F8	; 023210BC
	ldr r0,[pool_023212A4]	; 023210C0
	ldr r1,[pool_023212A8]	; 023210C2
	ldr r2,[pool_023212AC]	; 023210C4
	bl loc_0232DBF8	; 023210C6
	add r0,sp,#0x20	; 023210CA
	bl loc_02321488	; 023210CC
	ldr r0,[pool_023211BC]	; 023210D0
	add r1,sp,#0x20	; 023210D2
	bl loc_02324B00	; 023210D4
	bl loc_023264EC	; 023210D8
	b loc_023210EE	; 023210DC
loc_023210DE:
	ldr r0,[pool_023211BC]	; 023210DE
	ldr r1,[pool_02321294]	; 023210E0
	mov r2,#0x2d	; 023210E2
	bl loc_02324B5C	; 023210E4
	mov r1,#0x4	; 023210E8
	ldr r0,[pool_023211BC]	; 023210EA
	strh r1,[r0,#0x16]	; 023210EC
loc_023210EE:
	ldr r0,[pool_02321298]	; 023210EE
	ldr r0,[r0,#0x0]	; 023210F0
	mov r2,#0x1	; 023210F2
	and r0,r2	; 023210F4
	cmp r0,#0x0	; 023210F6
	bne loc_023210FC	; 023210F8
	mov r2,#0x0	; 023210FA
loc_023210FC:
	ldr r0,[pool_023211C4]	; 023210FC
	ldr r1,[r0,#0x68]	; 023210FE
	mov r3,#0x20	; 02321100
	bic r1,r3	; 02321102
	mov r3,#0x1	; 02321104
	and r2,r3	; 02321106
	lsl r2,r2,#0x5	; 02321108
	orr r1,r2	; 0232110A
	str r1,[r0,#0x68]	; 0232110C
	lsl r0,r1,#0x1a	; 0232110E
	lsr r0,r0,#0x1f	; 02321110
	cmp r0,#0x0	; 02321112
	beq loc_02321122	; 02321114
	ldr r0,[pool_023212B0]	; 02321116
	ldr r1,[pool_02321294]	; 02321118
	mov r2,#0x2f	; 0232111A
	bl loc_02324B5C	; 0232111C
	b loc_0232115C	; 02321120
loc_02321122:
	bl loc_0232C610	; 02321122
	ldr r1,[pool_023211C4]	; 02321126
	ldr r2,[r1,#0x68]	; 02321128
	mov r3,#0x40	; 0232112A
	bic r2,r3	; 0232112C
	mov r3,#0x1	; 0232112E
	and r0,r3	; 02321130
	lsl r0,r0,#0x6	; 02321132
	orr r2,r0	; 02321134
	str r2,[r1,#0x68]	; 02321136
	lsl r0,r2,#0x19	; 02321138
	lsr r0,r0,#0x1f	; 0232113A
	cmp r0,#0x0	; 0232113C
	beq loc_0232114C	; 0232113E
	ldr r0,[pool_023212B0]	; 02321140
	ldr r1,[pool_02321294]	; 02321142
	mov r2,#0x31	; 02321144
	bl loc_02324B5C	; 02321146
	b loc_0232115C	; 0232114A
loc_0232114C:
	ldr r0,[pool_023212B0]	; 0232114C
	ldr r1,[pool_02321294]	; 0232114E
	mov r2,#0x30	; 02321150
	bl loc_02324B5C	; 02321152
	mov r1,#0x4	; 02321156
	ldr r0,[pool_023212B4]	; 02321158
	strh r1,[r0,#0x22]	; 0232115A
loc_0232115C:
	add r0,r4,#0x0	; 0232115C
	ldr r1,[pool_023212B8]	; 0232115E
	ldr r2,[pool_023212BC]	; 02321160
	mov r3,#0x61	; 02321162
	bl loc_02324BB4	; 02321164
	bl P1_GetFirmwareUiContext	; 02321168
	ldr r0,[r0,#0x0]	; 0232116C
	lsl r0,r0,#0x17	; 0232116E
	lsr r0,r0,#0x1f	; 02321170
	cmp r0,#0x0	; 02321172
	bne loc_02321178	; 02321174
	b loc_023212DC	; 02321176
loc_02321178:
	ldr r1,[pool_023211C4]	; 02321178
	ldr r2,[r1,#0x68]	; 0232117A
	ldr r0,[pool_023212AC]	; 0232117C
	orr r2,r0	; 0232117E
	str r2,[r1,#0x68]	; 02321180
	ldr r1,[pool_023211D4]	; 02321182
	ldr r2,[r1,#0x0]	; 02321184
	ldr r0,[pool_023211F4]	; 02321186
	and r2,r0	; 02321188
	ldr r0,[pool_023211F8]	; 0232118A
	orr r2,r0	; 0232118C
	str r2,[r1,#0x0]	; 0232118E
	ldr r0,[pool_023212C0]	; 02321190
	mov r1,#0x0	; 02321192
	ldr r2,[pool_023212C4]	; 02321194
	sub r2,r2,r0	; 02321196
	bl loc_0232DC98	; 02321198
	ldr r0,[pool_02321208]	; 0232119C
	mov r1,#0x0	; 0232119E
	add r2,r7,#0x0	; 023211A0
	bl loc_0232DCE8	; 023211A2
	ldr r0,[pool_023212C8]	; 023211A6
	b loc_023212CC	; 023211A8
	.byte 0xC0, 0x46	; 023211AC
pool_023211AC:
loc_023211AC:
	.word P1_BssStart	; 023211AC
pool_023211B0:
loc_023211B0:
	.word 0x0000136C	; 023211B0
pool_023211B4:
loc_023211B4:
	.word 0x02330BF4	; 023211B4
pool_023211B8:
loc_023211B8:
	.word 0x0232FF5C	; 023211B8
pool_023211BC:
loc_023211BC:
	.word P1_BssStart + 0x100	; 023211BC
pool_023211C0:
loc_023211C0:
	.word P1_BssStart + 0xB00	; 023211C0
pool_023211C4:
loc_023211C4:
	.word P1_BssStart + 0x1300	; 023211C4
pool_023211C8:
loc_023211C8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023211C8
pool_023211CC:
loc_023211CC:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 023211CC
pool_023211D0:
loc_023211D0:
	.word 0xFFFFFBFF	; 023211D0
pool_023211D4:
loc_023211D4:
	.word REG_DISPCNT_B	; 023211D4
pool_023211D8:
loc_023211D8:
	.word 0xFFFEFFFF	; 023211D8
pool_023211DC:
loc_023211DC:
	.word 0x07000400	; 023211DC
pool_023211E0:
loc_023211E0:
	.word 0x00000400	; 023211E0
pool_023211E4:
loc_023211E4:
	.word 0x05000400	; 023211E4
pool_023211E8:
loc_023211E8:
	.word REG_BG1CNT	; 023211E8
pool_023211EC:
loc_023211EC:
	.word REG_BG1HOFS	; 023211EC
pool_023211F0:
loc_023211F0:
	.word REG_DISPCNT_A	; 023211F0
pool_023211F4:
loc_023211F4:
	.word 0xFFFFE0FF	; 023211F4
pool_023211F8:
loc_023211F8:
	.word 0x00001000	; 023211F8
pool_023211FC:
loc_023211FC:
	.word 0x023B02C0	; 023211FC
pool_02321200:
loc_02321200:
	.word 0x023AE6C0	; 02321200
pool_02321204:
loc_02321204:
	.word 0x023BC040	; 02321204
pool_02321208:
loc_02321208:
	.word 0x023BBE40	; 02321208
pool_0232120C:
loc_0232120C:
	.word 0x023B7E40	; 0232120C
pool_02321210:
loc_02321210:
	.word 0x023B8640	; 02321210
pool_02321214:
loc_02321214:
	.word 0x023BCE40	; 02321214
pool_02321218:
loc_02321218:
	.word 0x023BD040	; 02321218
pool_0232121C:
loc_0232121C:
	.word 0x0233008C	; 0232121C
pool_02321220:
loc_02321220:
	.word REG_BG0CNT_SUB	; 02321220
pool_02321224:
loc_02321224:
	.word 0x00001018	; 02321224
pool_02321228:
loc_02321228:
	.word REG_BG0HOFS_SUB	; 02321228
pool_0232122C:
loc_0232122C:
	.word REG_BG1CNT_SUB	; 0232122C
pool_02321230:
loc_02321230:
	.word 0x00004110	; 02321230
pool_02321234:
loc_02321234:
	.word 0x00190011	; 02321234
pool_02321238:
loc_02321238:
	.word REG_BG1HOFS_SUB	; 02321238
pool_0232123C:
loc_0232123C:
	.word REG_BG3CNT_SUB	; 0232123C
pool_02321240:
loc_02321240:
	.word 0x00000810	; 02321240
pool_02321244:
loc_02321244:
	.word REG_BG3HOFS_SUB	; 02321244
pool_02321248:
loc_02321248:
	.word 0xFFCFFFEF	; 02321248
pool_0232124C:
loc_0232124C:
	.word 0x00200010	; 0232124C
pool_02321250:
loc_02321250:
	.word 0x023BA640	; 02321250
pool_02321254:
loc_02321254:
	.word 0x00000800	; 02321254
pool_02321258:
loc_02321258:
	.word 0x023B6E40	; 02321258
pool_0232125C:
loc_0232125C:
	.word 0x06200000	; 0232125C
pool_02321260:
loc_02321260:
	.word 0x023B7640	; 02321260
pool_02321264:
loc_02321264:
	.word 0x023B9E40	; 02321264
pool_02321268:
loc_02321268:
	.word 0x06203000	; 02321268
pool_0232126C:
loc_0232126C:
	.word 0x023BA640	; 0232126C
pool_02321270:
loc_02321270:
	.word 0x023B9640	; 02321270
pool_02321274:
loc_02321274:
	.word 0x06203800	; 02321274
pool_02321278:
loc_02321278:
	.word 0x023B9E40	; 02321278
pool_0232127C:
loc_0232127C:
	.word 0x023B7640	; 0232127C
pool_02321280:
loc_02321280:
	.word 0x06204800	; 02321280
pool_02321284:
loc_02321284:
	.word 0x023B7E40	; 02321284
pool_02321288:
loc_02321288:
	.word 0x023C11F8	; 02321288
pool_0232128C:
loc_0232128C:
	.word 0x023D3B3C	; 0232128C
pool_02321290:
loc_02321290:
	.word 0x023D3C90	; 02321290
pool_02321294:
loc_02321294:
	.word 0x023A5B6C	; 02321294
pool_02321298:
loc_02321298:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02321298
pool_0232129C:
loc_0232129C:
	.word 0x00000102	; 0232129C
pool_023212A0:
loc_023212A0:
	.word 0x023315D8	; 023212A0
pool_023212A4:
loc_023212A4:
	.word 0x023315F8	; 023212A4
pool_023212A8:
loc_023212A8:
	.word 0x0001FE00	; 023212A8
pool_023212AC:
loc_023212AC:
	.word 0x00000200	; 023212AC
pool_023212B0:
loc_023212B0:
	.word 0x02330B0C	; 023212B0
pool_023212B4:
loc_023212B4:
	.word P1_BssStart + 0x40	; 023212B4
pool_023212B8:
loc_023212B8:
	.word 0x02331598	; 023212B8
pool_023212BC:
loc_023212BC:
	.word 0x023A5C44	; 023212BC
pool_023212C0:
loc_023212C0:
	.word 0x023BC640	; 023212C0
pool_023212C4:
loc_023212C4:
	.word 0x023BC840	; 023212C4
pool_023212C8:
loc_023212C8:
	.word 0x02330090	; 023212C8
loc_023212CC:
	mov r1,#0x0	; 023212CC
	mov r2,#0x2	; 023212CE
	bl loc_0232DCE8	; 023212D0
	mov r1,#0x1	; 023212D4
	ldr r0,[pool_023213DC]	; 023212D6
	str r1,[r0,#0x2c]	; 023212D8
	b loc_02321396	; 023212DA
loc_023212DC:
	mov r0,#0x0	; 023212DC
	ldr r1,[pool_023213E0]	; 023212DE
	ldr r1,[r1,#0x58]	; 023212E0
	cmp r1,#0x5	; 023212E2
	bhi loc_0232133A	; 023212E4
	add r1,r1,r1	; 023212E6
P1_SwitchIndexPC_023212E6:
	add r1,pc	; 023212E8
	ldrh r1,[r1,#(P1_SwitchTable_023212E6 - (P1_SwitchIndexPC_023212E6 + 4))]	; 023212EA
	lsl r1,r1,#0x10	; 023212EC
	asr r1,r1,#0x10	; 023212EE
P1_SwitchTargetPC_023212E6:
	add r1,pc	; 023212F0
	bx r1	; 023212F2
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023212E6:
	.halfword (loc_02321300 + 1) - (P1_SwitchTargetPC_023212E6 + 4)
	.halfword (loc_0232130A + 1) - (P1_SwitchTargetPC_023212E6 + 4)
	.halfword (loc_02321314 + 1) - (P1_SwitchTargetPC_023212E6 + 4)
	.halfword (loc_0232131E + 1) - (P1_SwitchTargetPC_023212E6 + 4)
	.halfword (loc_02321328 + 1) - (P1_SwitchTargetPC_023212E6 + 4)
	.halfword (loc_02321332 + 1) - (P1_SwitchTargetPC_023212E6 + 4)
P1_SwitchTable_023212E6End:
loc_02321300:
	ldr r0,[pool_023213E4]	; 02321300
	ldr r2,[pool_023213E8]	; 02321302
	ldr r1,[pool_023213EC]	; 02321304
	str r2,[r1,#0x14]	; 02321306
	b loc_0232133A	; 02321308
loc_0232130A:
	ldr r0,[pool_023213F0]	; 0232130A
	ldr r2,[pool_023213F4]	; 0232130C
	ldr r1,[pool_023213EC]	; 0232130E
	str r2,[r1,#0x14]	; 02321310
	b loc_0232133A	; 02321312
loc_02321314:
	ldr r0,[pool_023213F8]	; 02321314
	ldr r2,[pool_023213FC]	; 02321316
	ldr r1,[pool_023213EC]	; 02321318
	str r2,[r1,#0x14]	; 0232131A
	b loc_0232133A	; 0232131C
loc_0232131E:
	ldr r0,[pool_02321400]	; 0232131E
	ldr r2,[pool_02321404]	; 02321320
	ldr r1,[pool_023213EC]	; 02321322
	str r2,[r1,#0x14]	; 02321324
	b loc_0232133A	; 02321326
loc_02321328:
	ldr r0,[pool_02321408]	; 02321328
	ldr r2,[pool_0232140C]	; 0232132A
	ldr r1,[pool_023213EC]	; 0232132C
	str r2,[r1,#0x14]	; 0232132E
	b loc_0232133A	; 02321330
loc_02321332:
	ldr r0,[pool_02321410]	; 02321332
	ldr r2,[pool_02321414]	; 02321334
	ldr r1,[pool_023213EC]	; 02321336
	str r2,[r1,#0x14]	; 02321338
loc_0232133A:
	mov r1,#0x1	; 0232133A
	bl loc_0232568C	; 0232133C
	ldr r1,[pool_023213E0]	; 02321340
	ldr r2,[r1,#0x68]	; 02321342
	mov r0,#0x1	; 02321344
	bic r2,r0	; 02321346
	orr r2,r0	; 02321348
	str r2,[r1,#0x68]	; 0232134A
	ldr r0,[pool_02321418]	; 0232134C
	orr r2,r0	; 0232134E
	str r2,[r1,#0x68]	; 02321350
	mov r1,#0x0	; 02321352
	ldr r0,[pool_023213DC]	; 02321354
	str r1,[r0,#0x2c]	; 02321356
	ldr r2,[pool_0232141C]	; 02321358
	ldr r0,[pool_02321420]	; 0232135A
	sub r4,r2,r0	; 0232135C
	add r2,r4,#0x0	; 0232135E
	bl loc_0232DC98	; 02321360
	ldr r0,[pool_02321420]	; 02321364
	mov r1,#0x0	; 02321366
	add r2,r4,#0x0	; 02321368
	bl loc_0232DCE8	; 0232136A
	ldr r0,[pool_02321424]	; 0232136E
	mov r1,#0x0	; 02321370
	mov r2,#0x2	; 02321372
	bl loc_0232DCE8	; 02321374
	ldr r1,[pool_02321428]	; 02321378
	ldr r2,[r1,#0x0]	; 0232137A
	ldr r0,[pool_0232142C]	; 0232137C
	and r2,r0	; 0232137E
	ldr r0,[pool_02321430]	; 02321380
	orr r2,r0	; 02321382
	str r2,[r1,#0x0]	; 02321384
	mov r0,#0x10	; 02321386
	str r0,[sp,#0x0]	; 02321388
	ldr r0,[pool_02321434]	; 0232138A
	mov r1,#0x1	; 0232138C
	mov r2,#0x20	; 0232138E
	mov r3,#0x0	; 02321390
	bl loc_0232D958	; 02321392
loc_02321396:
	ldr r0,[pool_02321438]	; 02321396
	bl loc_02321830	; 02321398
	ldr r0,[pool_0232143C]	; 0232139C
	bl loc_02321938	; 0232139E
	ldr r0,[pool_02321440]	; 023213A2
	mov r1,#0x12	; 023213A4
	mov r2,#0x8	; 023213A6
	bl loc_02326050	; 023213A8
	ldr r0,[pool_02321444]	; 023213AC
	bl P1_SetLidOpenedCallback	; 023213AE
	mov r0,#0x1	; 023213B2
	ldr r1,[pool_02321448]	; 023213B4
	bl loc_0232B1E0	; 023213B6
	mov r0,#0x1	; 023213BA
	bl loc_0232B15C	; 023213BC
	mov r0,#0x1	; 023213C0
	bl loc_0232D4E0	; 023213C2
	bl loc_0232D46C	; 023213C6
	ldr r2,[pool_02321428]	; 023213CA
	ldr r1,[r2,#0x0]	; 023213CC
	ldr r0,[pool_0232144C]	; 023213CE
	orr r1,r0	; 023213D0
	str r1,[r2,#0x0]	; 023213D2
	add sp,#0x124	; 023213D4
	pop {r4,r5,r6,r7}	; 023213D6
	pop {r3}	; 023213D8
	bx r3	; 023213DA
pool_023213DC:
loc_023213DC:
	.word P1_BssStart + 0x100	; 023213DC
pool_023213E0:
loc_023213E0:
	.word P1_BssStart + 0x1300	; 023213E0
pool_023213E4:
loc_023213E4:
	.word 0x023A6E9C	; 023213E4
pool_023213E8:
loc_023213E8:
	.word 0x023A5A6C	; 023213E8
pool_023213EC:
loc_023213EC:
	.word P1_BssStart + 0xB00	; 023213EC
pool_023213F0:
loc_023213F0:
	.word 0x023A749C	; 023213F0
pool_023213F4:
loc_023213F4:
	.word 0x023A5A8C	; 023213F4
pool_023213F8:
loc_023213F8:
	.word 0x023A659C	; 023213F8
pool_023213FC:
loc_023213FC:
	.word 0x023A5A3C	; 023213FC
pool_02321400:
loc_02321400:
	.word 0x023A6868	; 02321400
pool_02321404:
loc_02321404:
	.word 0x023A5A4C	; 02321404
pool_02321408:
loc_02321408:
	.word 0x023A6B7C	; 02321408
pool_0232140C:
loc_0232140C:
	.word 0x023A5A5C	; 0232140C
pool_02321410:
loc_02321410:
	.word 0x023A7184	; 02321410
pool_02321414:
loc_02321414:
	.word 0x023A5A7C	; 02321414
pool_02321418:
loc_02321418:
	.word 0x00000200	; 02321418
pool_0232141C:
loc_0232141C:
	.word 0x023BCE40	; 0232141C
pool_02321420:
loc_02321420:
	.word 0x023BCC40	; 02321420
pool_02321424:
loc_02321424:
	.word 0x02330094	; 02321424
pool_02321428:
loc_02321428:
	.word REG_DISPCNT_B	; 02321428
pool_0232142C:
loc_0232142C:
	.word 0xFFFFE0FF	; 0232142C
pool_02321430:
loc_02321430:
	.word 0x00001100	; 02321430
pool_02321434:
loc_02321434:
	.word REG_BLDCNT_SUB	; 02321434
pool_02321438:
loc_02321438:
	.word P1_BssStart	; 02321438
pool_0232143C:
loc_0232143C:
	.word 0x02330C40	; 0232143C
pool_02321440:
loc_02321440:
	.word 0x0233155C	; 02321440
pool_02321444:
loc_02321444:
	.word P1_UiOnLidOpened + 1	; 02321444
pool_02321448:
loc_02321448:
	.word P1_IrqHandler_02321558 + 1	; 02321448
pool_0232144C:
loc_0232144C:
	.word 0x00010000	; 0232144C

; ===== function loc_02321450 =====
loc_02321450:
	push {lr}	; 02321450
	sub sp,#0x4	; 02321452
	bl P1_GetFirmwareUiContext	; 02321454
	ldr r0,[r0,#0x0]	; 02321458
	lsl r0,r0,#0x17	; 0232145A
	lsr r0,r0,#0x1f	; 0232145C
	cmp r0,#0x0	; 0232145E
	bne loc_02321476	; 02321460
	ldr r0,[pool_02321484]	; 02321462
	ldr r0,[r0,#0x68]	; 02321464
	lsl r0,r0,#0x15	; 02321466
	lsr r0,r0,#0x1f	; 02321468
	cmp r0,#0x0	; 0232146A
	beq loc_02321476	; 0232146C
	mov r0,#0x2	; 0232146E
	bl loc_023236E0	; 02321470
	b loc_0232147C	; 02321474
loc_02321476:
	mov r0,#0x1	; 02321476
	bl loc_023236E0	; 02321478
loc_0232147C:
	add sp,#0x4	; 0232147C
	pop {r3}	; 0232147E
	bx r3	; 02321480
	.byte 0xC0, 0x46	; 02321484
pool_02321484:
loc_02321484:
	.word P1_BssStart + 0x1300	; 02321484

; ===== function loc_02321488 =====
loc_02321488:
	push {r4,r5,r6,r7,lr}	; 02321488
	sub sp,#0x4	; 0232148A
	ldr r1,[pool_023214F4]	; 0232148C
	ldr r4,[r1,#0x58]	; 0232148E
	ldr r3,[pool_023214F8]	; 02321490
	lsl r1,r4,#0x8	; 02321492
	add r2,r3,r1	; 02321494
	ldr r1,[pool_023214FC]	; 02321496
	ldrh r1,[r2,r1]	; 02321498
	cmp r1,#0x0	; 0232149A
	bne loc_023214CE	; 0232149C
	cmp r4,#0x0	; 0232149E
	bne loc_023214A6	; 023214A0
	ldr r2,[pool_02321500]	; 023214A2
	b loc_023214B0	; 023214A4
loc_023214A6:
	cmp r4,#0x1	; 023214A6
	bne loc_023214AE	; 023214A8
	ldr r2,[pool_02321504]	; 023214AA
	b loc_023214B0	; 023214AC
loc_023214AE:
	ldr r2,[pool_02321508]	; 023214AE
loc_023214B0:
	mov r5,#0x0	; 023214B0
	ldr r6,[pool_023214FC]	; 023214B2
	b loc_023214CA	; 023214B4
loc_023214B6:
	lsl r1,r5,#0x1	; 023214B6
	ldrsh r1,[r2,r1]	; 023214B8
	lsl r7,r1,#0x8	; 023214BA
	add r7,r3,r7	; 023214BC
	ldrh r7,[r7,r6]	; 023214BE
	cmp r7,#0x0	; 023214C0
	beq loc_023214C8	; 023214C2
	add r4,r1,#0x0	; 023214C4
	b loc_023214CE	; 023214C6
loc_023214C8:
	add r5,r5,#0x1	; 023214C8
loc_023214CA:
	cmp r5,#0x6	; 023214CA
	blt loc_023214B6	; 023214CC
loc_023214CE:
	mov r1,#0x0	; 023214CE
	ldr r3,[pool_0232150C]	; 023214D0
	lsl r2,r4,#0x8	; 023214D2
	add r5,r3,r2	; 023214D4
	ldr r2,[pool_02321510]	; 023214D6
loc_023214D8:
	lsl r4,r1,#0x1	; 023214D8
	add r3,r5,r4	; 023214DA
	ldrh r3,[r3,r2]	; 023214DC
	strh r3,[r0,r4]	; 023214DE
	add r1,r1,#0x1	; 023214E0
	cmp r1,#0x80	; 023214E2
	blt loc_023214D8	; 023214E4
	mov r2,#0x0	; 023214E6
	lsl r1,r1,#0x1	; 023214E8
	strh r2,[r0,r1]	; 023214EA
	add sp,#0x4	; 023214EC
	pop {r4,r5,r6,r7}	; 023214EE
	pop {r3}	; 023214F0
	bx r3	; 023214F2
pool_023214F4:
loc_023214F4:
	.word P1_BssStart + 0x1300	; 023214F4
pool_023214F8:
loc_023214F8:
	.word 0x023315F8	; 023214F8
pool_023214FC:
loc_023214FC:
	.word 0x00000220	; 023214FC
pool_02321500:
loc_02321500:
	.word 0x0232FF0C	; 02321500
pool_02321504:
loc_02321504:
	.word 0x0232FF18	; 02321504
pool_02321508:
loc_02321508:
	.word 0x0232FF00	; 02321508
pool_0232150C:
loc_0232150C:
	.word P1_BssStart	; 0232150C
pool_02321510:
loc_02321510:
	.word 0x00000D58	; 02321510

; ===== function loc_02321514 =====
; 本组件 UI 注册的开盖处理：更新局部状态及 UI 电源标志。
; This UI stage's lid-open handler updates local state and UI power flags.
.func P1_UiOnLidOpened
	push {lr}	; 02321514
	sub sp,#0x4	; 02321516
	mov r1,#0x0	; 02321518
	ldr r0,[pool_02321550]	; 0232151A
	str r1,[r0,#0x20]	; 0232151C
	bl P1_GetFirmwareUiContext	; 0232151E
	ldr r0,[r0,#0x0]	; 02321522
	lsl r0,r0,#0x16	; 02321524
	lsr r0,r0,#0x1f	; 02321526
	cmp r0,#0x0	; 02321528
	beq loc_0232154A	; 0232152A
	bl P1_GetFirmwareUiContext	; 0232152C
	ldr r0,[r0,#0x0]	; 02321530
	lsl r0,r0,#0x15	; 02321532
	lsr r0,r0,#0x1f	; 02321534
	cmp r0,#0x0	; 02321536
	bne loc_0232153E	; 02321538
	bl loc_02326E28	; 0232153A
loc_0232153E:
	bl P1_GetFirmwareUiContext	; 0232153E
	ldr r2,[r0,#0x0]	; 02321542
	ldr r1,[pool_02321554]	; 02321544
	orr r2,r1	; 02321546
	str r2,[r0,#0x0]	; 02321548
loc_0232154A:
	add sp,#0x4	; 0232154A
	pop {r3}	; 0232154C
	bx r3	; 0232154E
.endfunc
pool_02321550:
loc_02321550:
	.word P1_BssStart + 0xA80	; 02321550
pool_02321554:
loc_02321554:
	.word 0x00000400	; 02321554

; ===== function loc_02321558 =====
P1_IrqHandler_02321558:
	push {r4,lr}	; 02321558
	ldr r1,[pool_02321630]	; 0232155A
	ldr r0,[pool_02321634]	; 0232155C
	add r1,r1,r0	; 0232155E
	ldr r2,[r1,#0x0]	; 02321560
	mov r0,#0x1	; 02321562
	orr r2,r0	; 02321564
	str r2,[r1,#0x0]	; 02321566
	ldr r0,[pool_02321638]	; 02321568
	ldr r0,[r0,#0x68]	; 0232156A
	lsl r0,r0,#0x1c	; 0232156C
	lsr r0,r0,#0x1f	; 0232156E
	cmp r0,#0x0	; 02321570
	beq loc_023215CC	; 02321572
	ldr r0,[pool_0232163C]	; 02321574
	ldrb r0,[r0,#0x0]	; 02321576
	lsl r0,r0,#0x1c	; 02321578
	lsr r4,r0,#0x1c	; 0232157A
	ldr r0,[pool_02321640]	; 0232157C
	mov r1,#0x0	; 0232157E
	ldr r2,[pool_02321644]	; 02321580
	sub r2,r2,r0	; 02321582
	bl loc_0232DC98	; 02321584
	ldr r0,[pool_02321648]	; 02321588
	ldr r1,[pool_0232164C]	; 0232158A
	mov r2,#0x20	; 0232158C
	bl loc_0232DC98	; 0232158E
	ldr r0,[pool_02321650]	; 02321592
	mov r1,#0x0	; 02321594
	ldr r2,[pool_02321654]	; 02321596
	sub r2,r2,r0	; 02321598
	bl loc_0232DCE8	; 0232159A
	ldr r0,[pool_02321658]	; 0232159E
	mov r1,#0x0	; 023215A0
	mov r2,#0x2	; 023215A2
	bl loc_0232DCE8	; 023215A4
	ldr r1,[pool_0232165C]	; 023215A8
	lsl r0,r4,#0x5	; 023215AA
	add r4,r1,r0	; 023215AC
	add r0,r4,#0x0	; 023215AE
	ldr r1,[pool_02321660]	; 023215B0
	mov r2,#0x20	; 023215B2
	bl loc_0232DCE8	; 023215B4
	add r0,r4,#0x0	; 023215B8
	ldr r1,[pool_02321660]	; 023215BA
	mov r2,#0x20	; 023215BC
	bl loc_0232DC98	; 023215BE
	ldr r1,[pool_02321638]	; 023215C2
	ldr r2,[r1,#0x68]	; 023215C4
	mov r0,#0x8	; 023215C6
	bic r2,r0	; 023215C8
	str r2,[r1,#0x68]	; 023215CA
loc_023215CC:
	ldr r2,[pool_02321638]	; 023215CC
	ldr r0,[r2,#0x68]	; 023215CE
	lsl r0,r0,#0x1f	; 023215D0
	lsr r0,r0,#0x1f	; 023215D2
	cmp r0,#0x0	; 023215D4
	beq loc_0232160E	; 023215D6
	ldr r0,[r2,#0x60]	; 023215D8
	ldr r4,[r2,#0x5c]	; 023215DA
	lsl r3,r4,#0xa	; 023215DC
	lsl r1,r4,#0x5	; 023215DE
	orr r4,r1	; 023215E0
	orr r3,r4	; 023215E2
	lsl r1,r3,#0x10	; 023215E4
	lsr r1,r1,#0x10	; 023215E6
	lsl r4,r1,#0x10	; 023215E8
	lsl r3,r0,#0xa	; 023215EA
	lsl r1,r0,#0x5	; 023215EC
	orr r0,r1	; 023215EE
	orr r3,r0	; 023215F0
	lsl r0,r3,#0x10	; 023215F2
	lsr r0,r0,#0x10	; 023215F4
	orr r4,r0	; 023215F6
	str r4,[r2,#0x64]	; 023215F8
	ldr r4,[pool_02321664]	; 023215FA
	add r0,r4,#0x0	; 023215FC
	mov r1,#0x4	; 023215FE
	blx P1_CleanDataCacheRange	; 02321600
	add r0,r4,#0x0	; 02321604
	mov r1,#0xe	; 02321606
	mov r2,#0x4	; 02321608
	bl loc_0232DCE8	; 0232160A
loc_0232160E:
	ldr r0,[pool_02321638]	; 0232160E
	ldr r0,[r0,#0x68]	; 02321610
	lsl r1,r0,#0x1d	; 02321612
	lsr r1,r1,#0x1f	; 02321614
	cmp r1,#0x0	; 02321616
	beq loc_02321626	; 02321618
	lsl r0,r0,#0x14	; 0232161A
	lsr r0,r0,#0x1f	; 0232161C
	cmp r0,#0x0	; 0232161E
	bne loc_02321626	; 02321620
	bl loc_023228C4	; 02321622
loc_02321626:
	bl loc_02323E48	; 02321626
	pop {r4}	; 0232162A
	pop {r3}	; 0232162C
	bx r3	; 0232162E
pool_02321630:
loc_02321630:
	.word P1_DtcmRuntimeStart	; 02321630
pool_02321634:
loc_02321634:
	.word 0x00003FF8	; 02321634
pool_02321638:
loc_02321638:
	.word P1_BssStart + 0x1300	; 02321638
pool_0232163C:
loc_0232163C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsThemeOffset	; 0232163C
pool_02321640:
loc_02321640:
	.word 0x023BC640	; 02321640
pool_02321644:
loc_02321644:
	.word 0x023BC840	; 02321644
pool_02321648:
loc_02321648:
	.word 0x023317F8	; 02321648
pool_0232164C:
loc_0232164C:
	.word 0x000001C0	; 0232164C
pool_02321650:
loc_02321650:
	.word 0x023BBE40	; 02321650
pool_02321654:
loc_02321654:
	.word 0x023BC040	; 02321654
pool_02321658:
loc_02321658:
	.word 0x02330098	; 02321658
pool_0232165C:
loc_0232165C:
	.word 0x023BCA40	; 0232165C
pool_02321660:
loc_02321660:
	.word 0x000001E0	; 02321660
pool_02321664:
loc_02321664:
	.word 0x02331E24	; 02321664

; ===== function loc_02321668 =====
loc_02321668:
	push {r4,r5,r6,r7,lr}	; 02321668
	sub sp,#0xc	; 0232166A
	add r7,r0,#0x0	; 0232166C
	ldr r0,[pool_02321820]	; 0232166E
	add r4,r7,r0	; 02321670
	ldr r5,[r4,#0x30]	; 02321672
	mov r0,#0x40	; 02321674
	bl loc_02324108	; 02321676
	str r0,[sp,#0x8]	; 0232167A
	mov r0,#0x80	; 0232167C
	bl loc_02324108	; 0232167E
	str r0,[sp,#0x0]	; 02321682
	mov r0,#0x20	; 02321684
	bl loc_02324108	; 02321686
	add r6,r0,#0x0	; 0232168A
	mov r0,#0x10	; 0232168C
	bl loc_02324108	; 0232168E
	cmp r5,#0x6	; 02321692
	bls loc_02321698	; 02321694
	b loc_023217BE	; 02321696
loc_02321698:
	add r1,r5,r5	; 02321698
P1_SwitchIndexPC_02321698:
	add r1,pc	; 0232169A
	ldrh r1,[r1,#(P1_SwitchTable_02321698 - (P1_SwitchIndexPC_02321698 + 4))]	; 0232169C
	lsl r1,r1,#0x10	; 0232169E
	asr r1,r1,#0x10	; 023216A0
P1_SwitchTargetPC_02321698:
	add r1,pc	; 023216A2
	bx r1	; 023216A4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02321698:
	.halfword (loc_0232176E + 1) - (P1_SwitchTargetPC_02321698 + 4)
	.halfword (loc_02321736 + 1) - (P1_SwitchTargetPC_02321698 + 4)
	.halfword (loc_023216E0 + 1) - (P1_SwitchTargetPC_02321698 + 4)
	.halfword (loc_023216E0 + 1) - (P1_SwitchTargetPC_02321698 + 4)
	.halfword (loc_023216B4 + 1) - (P1_SwitchTargetPC_02321698 + 4)
	.halfword (loc_023217AC + 1) - (P1_SwitchTargetPC_02321698 + 4)
	.halfword (loc_023217B6 + 1) - (P1_SwitchTargetPC_02321698 + 4)
P1_SwitchTable_02321698End:
loc_023216B4:
	ldr r1,[sp,#0x0]	; 023216B4
	cmp r1,#0x0	; 023216B6
	beq loc_023216CC	; 023216B8
	ldr r0,[r4,#0x34]	; 023216BA
	cmp r0,#0x3	; 023216BC
	bne loc_023216C6	; 023216BE
	mov r0,#0x3	; 023216C0
	str r0,[r4,#0x30]	; 023216C2
	b loc_023217BE	; 023216C4
loc_023216C6:
	mov r0,#0x2	; 023216C6
	str r0,[r4,#0x30]	; 023216C8
	b loc_023217BE	; 023216CA
loc_023216CC:
	cmp r6,#0x0	; 023216CC
	beq loc_023216D6	; 023216CE
	mov r0,#0x3	; 023216D0
	str r0,[r4,#0x34]	; 023216D2
	b loc_023217BE	; 023216D4
loc_023216D6:
	cmp r0,#0x0	; 023216D6
	beq loc_023217BE	; 023216D8
	mov r0,#0x2	; 023216DA
	str r0,[r4,#0x34]	; 023216DC
	b loc_023217BE	; 023216DE
loc_023216E0:
	ldr r1,[sp,#0x8]	; 023216E0
	cmp r1,#0x0	; 023216E2
	beq loc_023216F8	; 023216E4
	ldr r1,[pool_02321824]	; 023216E6
	ldr r1,[r7,r1]	; 023216E8
	lsl r1,r1,#0x1b	; 023216EA
	lsr r1,r1,#0x1f	; 023216EC
	cmp r1,#0x0	; 023216EE
	beq loc_023216F8	; 023216F0
	mov r0,#0x4	; 023216F2
	str r0,[r4,#0x30]	; 023216F4
	b loc_023217BE	; 023216F6
loc_023216F8:
	ldr r1,[sp,#0x0]	; 023216F8
	cmp r1,#0x0	; 023216FA
	beq loc_02321716	; 023216FC
	ldr r0,[pool_02321824]	; 023216FE
	ldr r0,[r7,r0]	; 02321700
	lsl r0,r0,#0x1a	; 02321702
	lsr r0,r0,#0x1f	; 02321704
	cmp r0,#0x0	; 02321706
	beq loc_02321710	; 02321708
	mov r0,#0x1	; 0232170A
	str r0,[r4,#0x30]	; 0232170C
	b loc_023217BE	; 0232170E
loc_02321710:
	mov r0,#0x0	; 02321710
	str r0,[r4,#0x30]	; 02321712
	b loc_023217BE	; 02321714
loc_02321716:
	cmp r0,#0x0	; 02321716
	beq loc_02321726	; 02321718
	cmp r5,#0x3	; 0232171A
	bne loc_02321726	; 0232171C
	mov r0,#0x2	; 0232171E
	str r0,[r4,#0x30]	; 02321720
	str r0,[r4,#0x34]	; 02321722
	b loc_023217BE	; 02321724
loc_02321726:
	cmp r6,#0x0	; 02321726
	beq loc_023217BE	; 02321728
	cmp r5,#0x2	; 0232172A
	bne loc_023217BE	; 0232172C
	mov r0,#0x3	; 0232172E
	str r0,[r4,#0x30]	; 02321730
	str r0,[r4,#0x34]	; 02321732
	b loc_023217BE	; 02321734
loc_02321736:
	ldr r1,[sp,#0x8]	; 02321736
	cmp r1,#0x0	; 02321738
	beq loc_0232174E	; 0232173A
	ldr r0,[r4,#0x34]	; 0232173C
	cmp r0,#0x3	; 0232173E
	bne loc_02321748	; 02321740
	mov r0,#0x3	; 02321742
	str r0,[r4,#0x30]	; 02321744
	b loc_023217BE	; 02321746
loc_02321748:
	mov r0,#0x2	; 02321748
	str r0,[r4,#0x30]	; 0232174A
	b loc_023217BE	; 0232174C
loc_0232174E:
	ldr r1,[sp,#0x0]	; 0232174E
	cmp r1,#0x0	; 02321750
	beq loc_0232175A	; 02321752
	mov r0,#0x0	; 02321754
	str r0,[r4,#0x30]	; 02321756
	b loc_023217BE	; 02321758
loc_0232175A:
	cmp r6,#0x0	; 0232175A
	beq loc_02321764	; 0232175C
	mov r0,#0x3	; 0232175E
	str r0,[r4,#0x34]	; 02321760
	b loc_023217BE	; 02321762
loc_02321764:
	cmp r0,#0x0	; 02321764
	beq loc_023217BE	; 02321766
	mov r0,#0x2	; 02321768
	str r0,[r4,#0x34]	; 0232176A
	b loc_023217BE	; 0232176C
loc_0232176E:
	ldr r1,[sp,#0x8]	; 0232176E
	cmp r1,#0x0	; 02321770
	beq loc_02321798	; 02321772
	ldr r0,[pool_02321824]	; 02321774
	ldr r0,[r7,r0]	; 02321776
	lsl r0,r0,#0x1a	; 02321778
	lsr r0,r0,#0x1f	; 0232177A
	cmp r0,#0x0	; 0232177C
	beq loc_02321786	; 0232177E
	mov r0,#0x1	; 02321780
	str r0,[r4,#0x30]	; 02321782
	b loc_023217BE	; 02321784
loc_02321786:
	ldr r0,[r4,#0x34]	; 02321786
	cmp r0,#0x3	; 02321788
	bne loc_02321792	; 0232178A
	mov r0,#0x3	; 0232178C
	str r0,[r4,#0x30]	; 0232178E
	b loc_023217BE	; 02321790
loc_02321792:
	mov r0,#0x2	; 02321792
	str r0,[r4,#0x30]	; 02321794
	b loc_023217BE	; 02321796
loc_02321798:
	cmp r0,#0x0	; 02321798
	beq loc_023217A2	; 0232179A
	mov r0,#0x5	; 0232179C
	str r0,[r4,#0x30]	; 0232179E
	b loc_023217BE	; 023217A0
loc_023217A2:
	cmp r6,#0x0	; 023217A2
	beq loc_023217BE	; 023217A4
	mov r0,#0x6	; 023217A6
	str r0,[r4,#0x30]	; 023217A8
	b loc_023217BE	; 023217AA
loc_023217AC:
	cmp r6,#0x0	; 023217AC
	beq loc_023217BE	; 023217AE
	mov r0,#0x0	; 023217B0
	str r0,[r4,#0x30]	; 023217B2
	b loc_023217BE	; 023217B4
loc_023217B6:
	cmp r0,#0x0	; 023217B6
	beq loc_023217BE	; 023217B8
	mov r0,#0x0	; 023217BA
	str r0,[r4,#0x30]	; 023217BC
loc_023217BE:
	ldr r0,[r4,#0x30]	; 023217BE
	cmp r5,r0	; 023217C0
	beq loc_023217CA	; 023217C2
	mov r0,#0x1d	; 023217C4
	bl loc_023236E0	; 023217C6
loc_023217CA:
	mov r5,#0x0	; 023217CA
loc_023217CC:
	add r7,r5,#0x0	; 023217CC
	mov r0,#0xc	; 023217CE
	mul r7,r0	; 023217D0
	add r6,r4,r7	; 023217D2
	ldr r0,[r4,#0x30]	; 023217D4
	lsl r1,r0,#0x5	; 023217D6
	ldr r0,[pool_02321828]	; 023217D8
	add r2,r0,r1	; 023217DA
	lsl r1,r5,#0x3	; 023217DC
	add r0,r2,r1	; 023217DE
	str r0,[sp,#0x4]	; 023217E0
	ldr r0,[r4,r7]	; 023217E2
	lsl r0,r0,#0x3	; 023217E4
	ldr r1,[r2,r1]	; 023217E6
	lsl r1,r1,#0x1	; 023217E8
	add r1,r0,r1	; 023217EA
	ldr r0,[pool_0232182C]	; 023217EC
	add r0,r1,r0	; 023217EE
	mov r1,#0xa	; 023217F0
	blx P1_SignedDivMod	; 023217F2
	str r0,[r4,r7]	; 023217F6
	ldr r0,[r6,#0x4]	; 023217F8
	lsl r1,r0,#0x3	; 023217FA
	ldr r0,[sp,#0x4]	; 023217FC
	ldr r0,[r0,#0x4]	; 023217FE
	lsl r0,r0,#0x1	; 02321800
	add r1,r1,r0	; 02321802
	ldr r0,[pool_0232182C]	; 02321804
	add r0,r1,r0	; 02321806
	mov r1,#0xa	; 02321808
	blx P1_SignedDivMod	; 0232180A
	str r0,[r6,#0x4]	; 0232180E
	add r5,r5,#0x1	; 02321810
	cmp r5,#0x4	; 02321812
	blt loc_023217CC	; 02321814
	add sp,#0xc	; 02321816
	pop {r4,r5,r6,r7}	; 02321818
	pop {r3}	; 0232181A
	bx r3	; 0232181C
	.byte 0xC0, 0x46	; 02321820
pool_02321820:
loc_02321820:
	.word 0x00000144	; 02321820
pool_02321824:
loc_02321824:
	.word 0x00001368	; 02321824
pool_02321828:
loc_02321828:
	.word 0x0232FFAC	; 02321828
pool_0232182C:
loc_0232182C:
	.word 0x00000800	; 0232182C

; ===== function loc_02321830 =====
loc_02321830:
	push {r4,r5,r6,r7,lr}	; 02321830
	sub sp,#0x4	; 02321832
	ldr r1,[pool_0232189C]	; 02321834
	add r5,r0,r1	; 02321836
	ldr r0,[pool_023218A0]	; 02321838
	ldr r0,[r0,#0x68]	; 0232183A
	lsl r1,r0,#0x1b	; 0232183C
	lsr r1,r1,#0x1f	; 0232183E
	cmp r1,#0x0	; 02321840
	beq loc_0232184A	; 02321842
	mov r0,#0x4	; 02321844
	str r0,[r5,#0x30]	; 02321846
	b loc_0232185C	; 02321848
loc_0232184A:
	lsl r0,r0,#0x1a	; 0232184A
	lsr r0,r0,#0x1f	; 0232184C
	cmp r0,#0x0	; 0232184E
	beq loc_02321858	; 02321850
	mov r0,#0x1	; 02321852
	str r0,[r5,#0x30]	; 02321854
	b loc_0232185C	; 02321856
loc_02321858:
	mov r0,#0x3	; 02321858
	str r0,[r5,#0x30]	; 0232185A
loc_0232185C:
	mov r0,#0x3	; 0232185C
	str r0,[r5,#0x34]	; 0232185E
	mov r6,#0x0	; 02321860
	ldr r2,[pool_023218A4]	; 02321862
	ldr r0,[pool_023218A8]	; 02321864
loc_02321866:
	add r3,r6,#0x0	; 02321866
	mov r1,#0xc	; 02321868
	mul r3,r1	; 0232186A
	add r4,r5,r3	; 0232186C
	lsl r1,r6,#0x2	; 0232186E
	ldr r1,[r2,r1]	; 02321870
	str r1,[r4,#0x8]	; 02321872
	lsl r1,r6,#0x3	; 02321874
	ldr r7,[r5,#0x30]	; 02321876
	lsl r7,r7,#0x5	; 02321878
	add r7,r0,r7	; 0232187A
	ldr r7,[r1,r7]	; 0232187C
	str r7,[r5,r3]	; 0232187E
	ldr r3,[r5,#0x30]	; 02321880
	lsl r3,r3,#0x5	; 02321882
	add r3,r0,r3	; 02321884
	add r1,r1,r3	; 02321886
	ldr r1,[r1,#0x4]	; 02321888
	str r1,[r4,#0x4]	; 0232188A
	add r6,r6,#0x1	; 0232188C
	cmp r6,#0x4	; 0232188E
	blt loc_02321866	; 02321890
	add sp,#0x4	; 02321892
	pop {r4,r5,r6,r7}	; 02321894
	pop {r3}	; 02321896
	bx r3	; 02321898
	.byte 0xC0, 0x46	; 0232189C
pool_0232189C:
loc_0232189C:
	.word 0x00000144	; 0232189C
pool_023218A0:
loc_023218A0:
	.word P1_BssStart + 0x1300	; 023218A0
pool_023218A4:
loc_023218A4:
	.word P1_Data_0232FF24	; 023218A4
pool_023218A8:
loc_023218A8:
	.word 0x0232FFAC	; 023218A8

; ===== function loc_023218AC =====
loc_023218AC:
	push {lr}	; 023218AC
	sub sp,#0x4	; 023218AE
	mov r1,#0x1	; 023218B0
	str r1,[r0,#0x8]	; 023218B2
	mov r0,#0x0	; 023218B4
	str r0,[sp,#0x0]	; 023218B6
	ldr r0,[pool_023218CC]	; 023218B8
	mov r1,#0x10	; 023218BA
	mov r2,#0x20	; 023218BC
	add r3,r1,#0x0	; 023218BE
	bl loc_0232D958	; 023218C0
	add sp,#0x4	; 023218C4
	pop {r3}	; 023218C6
	bx r3	; 023218C8
	.byte 0xC0, 0x46	; 023218CC
pool_023218CC:
loc_023218CC:
	.word REG_BLDCNT	; 023218CC

; ===== function loc_023218D0 =====
loc_023218D0:
	push {r4,r5,r6,r7,lr}	; 023218D0
	sub sp,#0x4	; 023218D2
	add r5,r0,#0x0	; 023218D4
	mov r4,#0x0	; 023218D6
	add r6,r5,#0x0	; 023218D8
	add r6,#0xc	; 023218DA
	mov r7,#0x74	; 023218DC
loc_023218DE:
	add r0,r4,#0x0	; 023218DE
	mul r0,r7	; 023218E0
	add r0,r6,r0	; 023218E2
	ldr r1,[r5,#0x0]	; 023218E4
	bl loc_02321BA8	; 023218E6
	add r4,r4,#0x1	; 023218EA
	cmp r4,#0x14	; 023218EC
	blt loc_023218DE	; 023218EE
	ldr r0,[r5,#0x0]	; 023218F0
	cmp r0,#0x78	; 023218F2
	bge loc_023218FA	; 023218F4
	add r0,r0,#0x1	; 023218F6
	str r0,[r5,#0x0]	; 023218F8
loc_023218FA:
	ldr r0,[r5,#0x0]	; 023218FA
	cmp r0,#0x1d	; 023218FC
	bne loc_02321904	; 023218FE
	bl loc_02321450	; 02321900
loc_02321904:
	ldr r0,[r5,#0x8]	; 02321904
	cmp r0,#0x0	; 02321906
	beq loc_0232192A	; 02321908
	ldr r0,[r5,#0x4]	; 0232190A
	add r0,r0,#0x1	; 0232190C
	str r0,[r5,#0x4]	; 0232190E
	ldr r0,[r5,#0x4]	; 02321910
	cmp r0,#0xf	; 02321912
	bgt loc_0232192A	; 02321914
	lsl r0,r0,#0x4	; 02321916
	mov r1,#0xf	; 02321918
	blx P1_SignedDivMod	; 0232191A
	mov r1,#0x10	; 0232191E
	sub r1,r1,r0	; 02321920
	lsl r0,r0,#0x8	; 02321922
	orr r1,r0	; 02321924
	ldr r0,[pool_02321934]	; 02321926
	strh r1,[r0,#0x0]	; 02321928
loc_0232192A:
	add sp,#0x4	; 0232192A
	pop {r4,r5,r6,r7}	; 0232192C
	pop {r3}	; 0232192E
	bx r3	; 02321930
	.byte 0xC0, 0x46	; 02321934
pool_02321934:
loc_02321934:
	.word REG_BLDALPHA	; 02321934

; ===== function loc_02321938 =====
loc_02321938:
	push {r4,r5,r6,r7,lr}	; 02321938
	sub sp,#0x1c	; 0232193A
	str r0,[sp,#0x0]	; 0232193C
	mov r5,#0x0	; 0232193E
	str r5,[sp,#0x4]	; 02321940
	str r5,[sp,#0x10]	; 02321942
	str r5,[sp,#0x8]	; 02321944
loc_02321946:
	ldr r2,[sp,#0x0]	; 02321946
	add r2,#0xc	; 02321948
	ldr r1,[sp,#0x4]	; 0232194A
	mov r0,#0x74	; 0232194C
	mul r1,r0	; 0232194E
	add r4,r2,r1	; 02321950
	ldr r0,[pool_023219DC]	; 02321952
	ldrh r0,[r0,r5]	; 02321954
	str r0,[r4,#0x70]	; 02321956
	add r5,r5,#0x2	; 02321958
	ldr r7,[sp,#0x8]	; 0232195A
	b loc_023219B0	; 0232195C
loc_0232195E:
	add r1,r7,#0x0	; 0232195E
	str r1,[sp,#0xc]	; 02321960
	mov r0,#0x18	; 02321962
	mul r1,r0	; 02321964
	str r1,[sp,#0xc]	; 02321966
	add r6,r4,r1	; 02321968
	ldr r0,[pool_023219DC]	; 0232196A
	add r0,r0,r5	; 0232196C
	add r1,sp,#0x14	; 0232196E
	mov r2,#0x8	; 02321970
	blx loc_0232DE20	; 02321972
	add r5,#0x8	; 02321976
	add r0,sp,#0x14	; 02321978
	ldrb r1,[r0,#0x0]	; 0232197A
	ldr r0,[sp,#0xc]	; 0232197C
	str r1,[r4,r0]	; 0232197E
	add r0,sp,#0x14	; 02321980
	ldrb r0,[r0,#0x1]	; 02321982
	lsl r0,r0,#0xc	; 02321984
	asr r0,r0,#0x4	; 02321986
	str r0,[r6,#0x14]	; 02321988
	add r1,sp,#0x14	; 0232198A
	mov r0,#0x2	; 0232198C
	ldrsh r0,[r1,r0]	; 0232198E
	lsl r0,r0,#0xc	; 02321990
	str r0,[r6,#0x4]	; 02321992
	mov r0,#0x4	; 02321994
	ldrsh r0,[r1,r0]	; 02321996
	lsl r0,r0,#0xc	; 02321998
	str r0,[r6,#0x8]	; 0232199A
	lsl r0,r1,#0	; 0232199C
	ldrb r0,[r0,#0x6]	; 0232199E
	lsl r0,r0,#0xc	; 023219A0
	str r0,[r6,#0xc]	; 023219A2
	lsl r0,r1,#0	; 023219A4
	ldrb r0,[r0,#0x7]	; 023219A6
	lsl r0,r0,#0xc	; 023219A8
	asr r0,r0,#0x4	; 023219AA
	str r0,[r6,#0x10]	; 023219AC
	add r7,r7,#0x1	; 023219AE
loc_023219B0:
	ldr r0,[r4,#0x70]	; 023219B0
	cmp r7,r0	; 023219B2
	bcc loc_0232195E	; 023219B4
	ldr r0,[sp,#0x10]	; 023219B6
	str r0,[r4,#0x60]	; 023219B8
	str r0,[r4,#0x64]	; 023219BA
	str r0,[r4,#0x68]	; 023219BC
	str r0,[r4,#0x6c]	; 023219BE
	ldr r0,[sp,#0x4]	; 023219C0
	add r0,r0,#0x1	; 023219C2
	str r0,[sp,#0x4]	; 023219C4
	cmp r0,#0x14	; 023219C6
	blt loc_02321946	; 023219C8
	ldr r1,[sp,#0x10]	; 023219CA
	ldr r0,[sp,#0x0]	; 023219CC
	str r1,[r0,#0x0]	; 023219CE
	str r1,[r0,#0x4]	; 023219D0
	str r1,[r0,#0x8]	; 023219D2
	add sp,#0x1c	; 023219D4
	pop {r4,r5,r6,r7}	; 023219D6
	pop {r3}	; 023219D8
	bx r3	; 023219DA
pool_023219DC:
loc_023219DC:
	.word P5_Data_023AE518	; 023219DC

; ===== function loc_023219E0 =====
loc_023219E0:
	push {r4,r5,r6,r7,lr}	; 023219E0
	sub sp,#0x1c	; 023219E2
	str r0,[sp,#0xc]	; 023219E4
	str r1,[sp,#0x10]	; 023219E6
	mov r5,#0x0	; 023219E8
	str r5,[sp,#0x14]	; 023219EA
loc_023219EC:
	ldr r2,[sp,#0xc]	; 023219EC
	add r2,#0xc	; 023219EE
	add r1,r5,#0x0	; 023219F0
	mov r0,#0x74	; 023219F2
	mul r1,r0	; 023219F4
	add r6,r2,r1	; 023219F6
	ldr r0,[r6,#0x68]	; 023219F8
	asr r4,r0,#0xc	; 023219FA
	cmp r4,#0x0	; 023219FC
	bge loc_02321A04	; 023219FE
	ldr r4,[sp,#0x14]	; 02321A00
	b loc_02321A0A	; 02321A02
loc_02321A04:
	cmp r4,#0xf	; 02321A04
	blt loc_02321A0A	; 02321A06
	mov r4,#0xe	; 02321A08
loc_02321A0A:
	ldr r0,[r6,#0x70]	; 02321A0A
	cmp r0,#0x0	; 02321A0C
	beq loc_02321A98	; 02321A0E
	cmp r4,#0x0	; 02321A10
	beq loc_02321A98	; 02321A12
	ldr r1,[r6,#0x60]	; 02321A14
	ldr r0,[pool_02321AA8]	; 02321A16
	add r0,r1,r0	; 02321A18
	ldr r1,[pool_02321AAC]	; 02321A1A
	bl P1_Divide32By32	; 02321A1C
	str r0,[sp,#0x18]	; 02321A20
	ldr r1,[r6,#0x64]	; 02321A22
	ldr r0,[pool_02321AA8]	; 02321A24
	add r0,r1,r0	; 02321A26
	ldr r1,[pool_02321AAC]	; 02321A28
	bl P1_Divide32By32	; 02321A2A
	add r7,r0,#0x0	; 02321A2E
	cmp r5,#0xc	; 02321A30
	bge loc_02321A80	; 02321A32
	lsl r1,r5,#0x1	; 02321A34
	ldr r0,[pool_02321AB0]	; 02321A36
	ldrsh r6,[r0,r1]	; 02321A38
	cmp r6,#0xb	; 02321A3A
	bne loc_02321A68	; 02321A3C
	ldr r0,[sp,#0x10]	; 02321A3E
	cmp r0,#0x0	; 02321A40
	beq loc_02321A98	; 02321A42
	ldr r0,[sp,#0x18]	; 02321A44
	add r0,#0xe	; 02321A46
	add r1,r7,#0x7	; 02321A48
	add r2,r4,#0x0	; 02321A4A
	bl loc_02326458	; 02321A4C
	bl loc_02323E40	; 02321A50
	ldr r1,[sp,#0x18]	; 02321A54
	str r1,[sp,#0x0]	; 02321A56
	str r7,[sp,#0x4]	; 02321A58
	str r4,[sp,#0x8]	; 02321A5A
	ldr r1,[pool_02321AB4]	; 02321A5C
	ldr r2,[pool_02321AB8]	; 02321A5E
	add r3,r6,#0x0	; 02321A60
	bl loc_02323BA8	; 02321A62
	b loc_02321A98	; 02321A66
loc_02321A68:
	bl loc_02323E40	; 02321A68
	ldr r1,[sp,#0x18]	; 02321A6C
	str r1,[sp,#0x0]	; 02321A6E
	str r7,[sp,#0x4]	; 02321A70
	str r4,[sp,#0x8]	; 02321A72
	ldr r1,[pool_02321AB4]	; 02321A74
	ldr r2,[pool_02321AB8]	; 02321A76
	add r3,r6,#0x0	; 02321A78
	bl loc_02323BA8	; 02321A7A
	b loc_02321A98	; 02321A7E
loc_02321A80:
	ldr r0,[r6,#0x6c]	; 02321A80
	bl P1_ComputeFixedPointReciprocal	; 02321A82
	str r0,[sp,#0x0]	; 02321A86
	lsl r1,r5,#0x1	; 02321A88
	ldr r0,[pool_02321AB0]	; 02321A8A
	ldrsh r0,[r0,r1]	; 02321A8C
	ldr r1,[sp,#0x18]	; 02321A8E
	add r2,r7,#0x0	; 02321A90
	add r3,r4,#0x0	; 02321A92
	bl loc_02321ABC	; 02321A94
loc_02321A98:
	add r5,r5,#0x1	; 02321A98
	cmp r5,#0x14	; 02321A9A
	blt loc_023219EC	; 02321A9C
	add sp,#0x1c	; 02321A9E
	pop {r4,r5,r6,r7}	; 02321AA0
	pop {r3}	; 02321AA2
	bx r3	; 02321AA4
	.byte 0xC0, 0x46	; 02321AA8
pool_02321AA8:
loc_02321AA8:
	.word 0x00000800	; 02321AA8
pool_02321AAC:
loc_02321AAC:
	.word 0x00001000	; 02321AAC
pool_02321AB0:
loc_02321AB0:
	.word P1_Data_0232FF34	; 02321AB0
pool_02321AB4:
loc_02321AB4:
	.word 0x023D3C90	; 02321AB4
pool_02321AB8:
loc_02321AB8:
	.word 0x023A581C	; 02321AB8

; ===== function loc_02321ABC =====
loc_02321ABC:
	push {r4,r5,r6,r7,lr}	; 02321ABC
	sub sp,#0x34	; 02321ABE
	str r1,[sp,#0x0]	; 02321AC0
	str r2,[sp,#0x4]	; 02321AC2
	str r3,[sp,#0x8]	; 02321AC4
	ldr r7,[pool_02321B98]	; 02321AC6
	add r7,#0x8	; 02321AC8
	lsl r0,r0,#0x3	; 02321ACA
	str r0,[sp,#0x14]	; 02321ACC
	add r5,r7,r0	; 02321ACE
	ldr r0,[pool_02321B9C]	; 02321AD0
	ldr r1,[r5,#0x4]	; 02321AD2
	bl loc_023291B8	; 02321AD4
	add r6,r0,#0x0	; 02321AD8
	ldr r0,[pool_02321B9C]	; 02321ADA
	ldr r1,[r5,#0x4]	; 02321ADC
	bl loc_023291A0	; 02321ADE
	add r4,r0,#0x0	; 02321AE2
	ldr r0,[pool_02321B9C]	; 02321AE4
	ldr r1,[r5,#0x4]	; 02321AE6
	bl loc_023291D0	; 02321AE8
	str r0,[sp,#0xc]	; 02321AEC
	mov r1,sp	; 02321AEE
	sub r1,r1,#0x4	; 02321AF0
	ldr r0,[sp,#0x14]	; 02321AF2
	ldrh r0,[r7,r0]	; 02321AF4
	strh r0,[r1,#0x0]	; 02321AF6
	ldmia r1!,{r0}	; 02321AF8
	ldrb r1,[r4,#0x0]	; 02321AFA
	bl loc_023290D0	; 02321AFC
	ldr r1,[sp,#0x0]	; 02321B00
	add r0,r1,r0	; 02321B02
	str r0,[sp,#0x0]	; 02321B04
	mov r1,sp	; 02321B06
	sub r1,r1,#0x4	; 02321B08
	ldrh r0,[r5,#0x2]	; 02321B0A
	strh r0,[r1,#0x0]	; 02321B0C
	ldmia r1!,{r0}	; 02321B0E
	ldrb r1,[r4,#0x1]	; 02321B10
	bl loc_02329098	; 02321B12
	ldr r1,[sp,#0x4]	; 02321B16
	add r0,r1,r0	; 02321B18
	str r0,[sp,#0x4]	; 02321B1A
	ldr r0,[sp,#0x48]	; 02321B1C
	cmp r0,#0x0	; 02321B1E
	beq loc_02321B90	; 02321B20
	str r0,[sp,#0x2c]	; 02321B22
	str r0,[sp,#0x20]	; 02321B24
	mov r5,#0x0	; 02321B26
	str r5,[sp,#0x28]	; 02321B28
	str r5,[sp,#0x24]	; 02321B2A
	ldr r0,[sp,#0x8]	; 02321B2C
	lsl r0,r0,#0xc	; 02321B2E
	str r0,[sp,#0x10]	; 02321B30
	b loc_02321B8A	; 02321B32
loc_02321B34:
	ldrh r7,[r6,#0x8]	; 02321B34
	ldr r0,[r6,#0x0]	; 02321B36
	lsl r1,r0,#0x10	; 02321B38
	lsr r1,r1,#0x1e	; 02321B3A
	lsl r2,r1,#0xe	; 02321B3C
	lsr r1,r0,#0x1e	; 02321B3E
	lsl r1,r1,#0x1e	; 02321B40
	orr r2,r1	; 02321B42
	lsl r0,r0,#0x7	; 02321B44
	lsr r1,r0,#0x17	; 02321B46
	ldr r0,[sp,#0x0]	; 02321B48
	add r0,r0,r1	; 02321B4A
	ldrb r1,[r4,#0x0]	; 02321B4C
	lsr r1,r1,#0x1	; 02321B4E
	sub r1,r0,r1	; 02321B50
	ldr r0,[pool_02321BA0]	; 02321B52
	and r1,r0	; 02321B54
	lsl r1,r1,#0x10	; 02321B56
	ldrb r3,[r6,#0x0]	; 02321B58
	ldr r0,[sp,#0x4]	; 02321B5A
	add r0,r0,r3	; 02321B5C
	ldrb r3,[r4,#0x1]	; 02321B5E
	lsr r3,r3,#0x1	; 02321B60
	sub r3,r0,r3	; 02321B62
	mov r0,#0xff	; 02321B64
	and r3,r0	; 02321B66
	orr r2,r3	; 02321B68
	orr r1,r2	; 02321B6A
	ldr r0,[pool_02321BA4]	; 02321B6C
	orr r1,r0	; 02321B6E
	str r1,[sp,#0x18]	; 02321B70
	ldr r1,[sp,#0x10]	; 02321B72
	orr r1,r7	; 02321B74
	add r0,sp,#0x18	; 02321B76
	strh r1,[r0,#0x4]	; 02321B78
	bl loc_02323E40	; 02321B7A
	add r1,sp,#0x18	; 02321B7E
	add r2,sp,#0x20	; 02321B80
	bl loc_0232395C	; 02321B82
	add r5,r5,#0x1	; 02321B86
	add r6,#0xc	; 02321B88
loc_02321B8A:
	ldr r0,[sp,#0xc]	; 02321B8A
	cmp r5,r0	; 02321B8C
	blt loc_02321B34	; 02321B8E
loc_02321B90:
	add sp,#0x34	; 02321B90
	pop {r4,r5,r6,r7}	; 02321B92
	pop {r3}	; 02321B94
	bx r3	; 02321B96
pool_02321B98:
loc_02321B98:
	.word 0x023A581C	; 02321B98
pool_02321B9C:
loc_02321B9C:
	.word 0x023D3C90	; 02321B9C
pool_02321BA0:
loc_02321BA0:
	.word 0x000001FF	; 02321BA0
pool_02321BA4:
loc_02321BA4:
	.word 0x00000300	; 02321BA4

; ===== function loc_02321BA8 =====
loc_02321BA8:
	push {r4,r5,r6,r7,lr}	; 02321BA8
	sub sp,#0x14	; 02321BAA
	add r5,r0,#0x0	; 02321BAC
	str r1,[sp,#0x8]	; 02321BAE
	mov r7,#0x0	; 02321BB0
	add r6,r7,#0x0	; 02321BB2
	add r3,r7,#0x0	; 02321BB4
	ldr r2,[r5,#0x70]	; 02321BB6
	b loc_02321BCC	; 02321BB8
loc_02321BBA:
	add r4,r3,#0x0	; 02321BBA
	mov r0,#0x18	; 02321BBC
	mul r4,r0	; 02321BBE
	ldr r1,[r5,r4]	; 02321BC0
	ldr r0,[sp,#0x8]	; 02321BC2
	cmp r1,r0	; 02321BC4
	bhi loc_02321BCA	; 02321BC6
	add r7,r5,r4	; 02321BC8
loc_02321BCA:
	add r3,r3,#0x1	; 02321BCA
loc_02321BCC:
	cmp r3,r2	; 02321BCC
	bcc loc_02321BBA	; 02321BCE
	sub r3,r2,#0x1	; 02321BD0
	mov r4,#0x18	; 02321BD2
	b loc_02321BE6	; 02321BD4
loc_02321BD6:
	add r2,r3,#0x0	; 02321BD6
	mul r2,r4	; 02321BD8
	ldr r1,[r5,r2]	; 02321BDA
	ldr r0,[sp,#0x8]	; 02321BDC
	cmp r1,r0	; 02321BDE
	bls loc_02321BE4	; 02321BE0
	add r6,r5,r2	; 02321BE2
loc_02321BE4:
	sub r3,r3,#0x1	; 02321BE4
loc_02321BE6:
	cmp r3,#0x0	; 02321BE6
	bge loc_02321BD6	; 02321BE8
	cmp r7,#0x0	; 02321BEA
	bne loc_02321C00	; 02321BEC
	mov r2,#0x0	; 02321BEE
loc_02321BF0:
	lsl r0,r2,#0x2	; 02321BF0
	add r1,r5,r0	; 02321BF2
	ldr r0,[r1,#0x4]	; 02321BF4
	str r0,[r1,#0x60]	; 02321BF6
	add r2,r2,#0x1	; 02321BF8
	cmp r2,#0x4	; 02321BFA
	blt loc_02321BF0	; 02321BFC
	b loc_02321C5A	; 02321BFE
loc_02321C00:
	cmp r6,#0x0	; 02321C00
	bne loc_02321C22	; 02321C02
	mov r0,#0x0	; 02321C04
	mov r1,#0x18	; 02321C06
loc_02321C08:
	lsl r4,r0,#0x2	; 02321C08
	ldr r2,[r5,#0x70]	; 02321C0A
	mul r2,r1	; 02321C0C
	add r2,r5,r2	; 02321C0E
	add r2,r4,r2	; 02321C10
	sub r2,#0x14	; 02321C12
	ldr r3,[r2,#0x0]	; 02321C14
	add r2,r5,r4	; 02321C16
	str r3,[r2,#0x60]	; 02321C18
	add r0,r0,#0x1	; 02321C1A
	cmp r0,#0x4	; 02321C1C
	blt loc_02321C08	; 02321C1E
	b loc_02321C5A	; 02321C20
loc_02321C22:
	mov r4,#0x0	; 02321C22
	str r4,[sp,#0x10]	; 02321C24
loc_02321C26:
	cmp r4,#0x2	; 02321C26
	bne loc_02321C2E	; 02321C28
	ldr r3,[sp,#0x10]	; 02321C2A
	b loc_02321C30	; 02321C2C
loc_02321C2E:
	ldr r3,[r7,#0x14]	; 02321C2E
loc_02321C30:
	lsl r0,r4,#0x2	; 02321C30
	str r0,[sp,#0xc]	; 02321C32
	ldr r0,[r6,#0x0]	; 02321C34
	str r0,[sp,#0x0]	; 02321C36
	ldr r0,[sp,#0xc]	; 02321C38
	add r0,r6,r0	; 02321C3A
	ldr r0,[r0,#0x4]	; 02321C3C
	str r0,[sp,#0x4]	; 02321C3E
	ldr r0,[sp,#0x8]	; 02321C40
	ldr r1,[r7,#0x0]	; 02321C42
	ldr r2,[sp,#0xc]	; 02321C44
	add r2,r7,r2	; 02321C46
	ldr r2,[r2,#0x4]	; 02321C48
	bl loc_02321C64	; 02321C4A
	ldr r1,[sp,#0xc]	; 02321C4E
	add r1,r5,r1	; 02321C50
	str r0,[r1,#0x60]	; 02321C52
	add r4,r4,#0x1	; 02321C54
	cmp r4,#0x4	; 02321C56
	blt loc_02321C26	; 02321C58
loc_02321C5A:
	add sp,#0x14	; 02321C5A
	pop {r4,r5,r6,r7}	; 02321C5C
	pop {r3}	; 02321C5E
	bx r3	; 02321C60
	.byte 0x00, 0x00	; 02321C64

; ===== function loc_02321C64 =====
loc_02321C64:
	push {r4,r5,r6,r7,lr}	; 02321C64
	sub sp,#0x4	; 02321C66
	add r4,r2,#0x0	; 02321C68
	add r7,r3,#0x0	; 02321C6A
	sub r0,r0,r1	; 02321C6C
	lsl r0,r0,#0xc	; 02321C6E
	ldr r2,[sp,#0x18]	; 02321C70
	sub r1,r2,r1	; 02321C72
	blx P1_SignedDivMod	; 02321C74
	add r5,r0,#0x0	; 02321C78
	ldr r0,[pool_02321CB8]	; 02321C7A
	sub r0,r0,r5	; 02321C7C
	str r0,[sp,#0x0]	; 02321C7E
	add r1,r4,#0x0	; 02321C80
	blx loc_0232D3C8	; 02321C82
	add r6,r0,#0x0	; 02321C86
	ldr r0,[sp,#0x0]	; 02321C88
	ldr r1,[pool_02321CB8]	; 02321C8A
	add r1,r5,r1	; 02321C8C
	blx loc_0232D3C8	; 02321C8E
	add r1,r7,#0x0	; 02321C92
	blx loc_0232D3C8	; 02321C94
	ldr r1,[sp,#0x1c]	; 02321C98
	sub r1,r1,r4	; 02321C9A
	blx loc_0232D3C8	; 02321C9C
	add r4,r0,#0x0	; 02321CA0
	add r0,r5,#0x0	; 02321CA2
	ldr r1,[sp,#0x1c]	; 02321CA4
	blx loc_0232D3C8	; 02321CA6
	add r0,r4,r0	; 02321CAA
	add r0,r6,r0	; 02321CAC
	add sp,#0x4	; 02321CAE
	pop {r4,r5,r6,r7}	; 02321CB0
	pop {r3}	; 02321CB2
	bx r3	; 02321CB4
	.byte 0xC0, 0x46	; 02321CB8
pool_02321CB8:
loc_02321CB8:
	.word 0x00001000	; 02321CB8

; ===== function loc_02321CBC =====
loc_02321CBC:
	ldr r3,[pool_02321CC0]	; 02321CBC
	bx r3	; 02321CBE
pool_02321CC0:
loc_02321CC0:
	.word loc_023242F4 + 1	; 02321CC0

; ===== function loc_02321CC4 =====
loc_02321CC4:
	ldr r3,[pool_02321CC8]	; 02321CC4
	bx r3	; 02321CC6
pool_02321CC8:
loc_02321CC8:
	.word loc_02324304 + 1	; 02321CC8

; ===== function loc_02321CCC =====
loc_02321CCC:
	ldr r3,[pool_02321CD0]	; 02321CCC
	bx r3	; 02321CCE
pool_02321CD0:
loc_02321CD0:
	.word loc_02324318 + 1	; 02321CD0

; ===== function loc_02321CD4 =====
loc_02321CD4:
	push {r4,lr}	; 02321CD4
	add r4,r0,#0x0	; 02321CD6
	ldr r1,[pool_02321D0C]	; 02321CD8
	bl loc_0232432C	; 02321CDA
	mov r0,#0x0	; 02321CDE
	bl loc_023253B0	; 02321CE0
	cmp r0,#0x0	; 02321CE4
	beq loc_02321CEE	; 02321CE6
	mov r0,#0x0	; 02321CE8
	str r0,[r4,#0xc]	; 02321CEA
	b loc_02321D04	; 02321CEC
loc_02321CEE:
	mov r0,#0x1	; 02321CEE
	bl loc_023253B0	; 02321CF0
	cmp r0,#0x0	; 02321CF4
	beq loc_02321CFE	; 02321CF6
	mov r0,#0x1	; 02321CF8
	str r0,[r4,#0xc]	; 02321CFA
	b loc_02321D04	; 02321CFC
loc_02321CFE:
	mov r0,#0x0	; 02321CFE
	mvn r0,r0	; 02321D00
	str r0,[r4,#0xc]	; 02321D02
loc_02321D04:
	pop {r4}	; 02321D04
	pop {r3}	; 02321D06
	bx r3	; 02321D08
	.byte 0xC0, 0x46	; 02321D0C
pool_02321D0C:
loc_02321D0C:
	.word 0x023A4B68	; 02321D0C

; ===== function loc_02321D10 =====
loc_02321D10:
	push {r4,lr}	; 02321D10
	add r4,r0,#0x0	; 02321D12
	bl loc_023243D8	; 02321D14
	mov r0,#0x0	; 02321D18
	mvn r0,r0	; 02321D1A
	str r0,[r4,#0xc]	; 02321D1C
	pop {r4}	; 02321D1E
	pop {r3}	; 02321D20
	bx r3	; 02321D22

; ===== function loc_02321D24 =====
loc_02321D24:
	push {r4,lr}	; 02321D24
	sub sp,#0x8	; 02321D26
	ldr r0,[pool_02321DB4]	; 02321D28
	ldr r0,[r0,#0x0]	; 02321D2A
	cmp r0,#0x0	; 02321D2C
	beq loc_02321D9E	; 02321D2E
	ldr r0,[pool_02321DB8]	; 02321D30
	ldr r0,[r0,#0x0]	; 02321D32
	cmp r0,#0x0	; 02321D34
	beq loc_02321D40	; 02321D36
	ldr r0,[pool_02321DBC]	; 02321D38
	ldr r0,[r0,#0x0]	; 02321D3A
	cmp r0,#0xf	; 02321D3C
	bge loc_02321D9E	; 02321D3E
loc_02321D40:
	ldr r0,[pool_02321DBC]	; 02321D40
	ldr r1,[r0,#0x0]	; 02321D42
	add r1,r1,#0x1	; 02321D44
	str r1,[r0,#0x0]	; 02321D46
	lsl r0,r1,#0x4	; 02321D48
	mov r1,#0xf	; 02321D4A
	blx P1_SignedDivMod	; 02321D4C
	mov r3,#0x10	; 02321D50
	sub r1,r3,r0	; 02321D52
	lsl r0,r0,#0x8	; 02321D54
	orr r1,r0	; 02321D56
	ldr r0,[pool_02321DC0]	; 02321D58
	strh r1,[r0,#0x0]	; 02321D5A
	ldr r0,[pool_02321DB8]	; 02321D5C
	ldr r0,[r0,#0x0]	; 02321D5E
	cmp r0,#0x0	; 02321D60
	bne loc_02321D9E	; 02321D62
	ldr r0,[pool_02321DBC]	; 02321D64
	ldr r0,[r0,#0x0]	; 02321D66
	cmp r0,#0xf	; 02321D68
	bne loc_02321D9E	; 02321D6A
	ldr r1,[pool_02321DC4]	; 02321D6C
	ldr r4,[r1,#0x0]	; 02321D6E
	mov r0,#0x12	; 02321D70
	bic r4,r0	; 02321D72
	str r4,[r1,#0x0]	; 02321D74
	ldr r1,[pool_02321DC8]	; 02321D76
	ldr r2,[r1,#0x0]	; 02321D78
	ldr r0,[pool_02321DCC]	; 02321D7A
	and r2,r0	; 02321D7C
	lsl r0,r4,#0x8	; 02321D7E
	orr r2,r0	; 02321D80
	str r2,[r1,#0x0]	; 02321D82
	mov r0,#0x0	; 02321D84
	str r0,[sp,#0x0]	; 02321D86
	ldr r0,[pool_02321DD0]	; 02321D88
	mov r1,#0x4	; 02321D8A
	mov r2,#0x8	; 02321D8C
	bl loc_0232D958	; 02321D8E
	mov r1,#0x0	; 02321D92
	ldr r0,[pool_02321DBC]	; 02321D94
	str r1,[r0,#0x0]	; 02321D96
	mov r1,#0x1	; 02321D98
	ldr r0,[pool_02321DB8]	; 02321D9A
	str r1,[r0,#0x0]	; 02321D9C
loc_02321D9E:
	bl loc_023232F8	; 02321D9E
	bl loc_02322A40	; 02321DA2
	bl loc_02323088	; 02321DA6
	add sp,#0x8	; 02321DAA
	pop {r4}	; 02321DAC
	pop {r3}	; 02321DAE
	bx r3	; 02321DB0
	.byte 0xC0, 0x46	; 02321DB4
pool_02321DB4:
loc_02321DB4:
	.word P1_BssStart + 0x1384	; 02321DB4
pool_02321DB8:
loc_02321DB8:
	.word P1_BssStart + 0x1380	; 02321DB8
pool_02321DBC:
loc_02321DBC:
	.word P1_BssStart + 0x1378	; 02321DBC
pool_02321DC0:
loc_02321DC0:
	.word REG_BLDALPHA	; 02321DC0
pool_02321DC4:
loc_02321DC4:
	.word P1_BssStart + 0x1370	; 02321DC4
pool_02321DC8:
loc_02321DC8:
	.word REG_DISPCNT_A	; 02321DC8
pool_02321DCC:
loc_02321DCC:
	.word 0xFFFFE0FF	; 02321DCC
pool_02321DD0:
loc_02321DD0:
	.word REG_BLDCNT	; 02321DD0

; ===== function loc_02321DD4 =====
loc_02321DD4:
	push {lr}	; 02321DD4
	sub sp,#0x4	; 02321DD6
	mov r0,#0x0	; 02321DD8
	str r0,[sp,#0x0]	; 02321DDA
	ldr r0,[pool_02321DF4]	; 02321DDC
	mov r1,#0x12	; 02321DDE
	mov r2,#0x1c	; 02321DE0
	mov r3,#0x10	; 02321DE2
	bl loc_0232D958	; 02321DE4
	mov r1,#0x1	; 02321DE8
	ldr r0,[pool_02321DF8]	; 02321DEA
	str r1,[r0,#0x0]	; 02321DEC
	add sp,#0x4	; 02321DEE
	pop {r3}	; 02321DF0
	bx r3	; 02321DF2
pool_02321DF4:
loc_02321DF4:
	.word REG_BLDCNT	; 02321DF4
pool_02321DF8:
loc_02321DF8:
	.word P1_BssStart + 0x1384	; 02321DF8

; ===== function loc_02321DFC =====
loc_02321DFC:
	push {lr}	; 02321DFC
	sub sp,#0x4	; 02321DFE
	mov r1,#0x1	; 02321E00
	ldr r0,[pool_02321E34]	; 02321E02
	str r1,[r0,#0x0]	; 02321E04
	mov r1,#0x0	; 02321E06
	ldr r0,[pool_02321E38]	; 02321E08
	str r1,[r0,#0x0]	; 02321E0A
	bl loc_02321F1C	; 02321E0C
	bl loc_02323328	; 02321E10
	bl loc_023230A8	; 02321E14
	bl loc_02322C78	; 02321E18
	bl loc_023235A0	; 02321E1C
	ldr r0,[pool_02321E3C]	; 02321E20
	bl loc_02322840	; 02321E22
	mov r1,#0x0	; 02321E26
	ldr r0,[pool_02321E40]	; 02321E28
	str r1,[r0,#0x8]	; 02321E2A
	add sp,#0x4	; 02321E2C
	pop {r3}	; 02321E2E
	bx r3	; 02321E30
	.byte 0xC0, 0x46	; 02321E34
pool_02321E34:
loc_02321E34:
	.word P1_BssStart + 0x137C	; 02321E34
pool_02321E38:
loc_02321E38:
	.word P1_BssStart + 0x1374	; 02321E38
pool_02321E3C:
loc_02321E3C:
	.word 0x02331E48	; 02321E3C
pool_02321E40:
loc_02321E40:
	.word P1_BssStart + 0x1444	; 02321E40

; ===== function loc_02321E44 =====
loc_02321E44:
	push {lr}	; 02321E44
	sub sp,#0x4	; 02321E46
	ldr r1,[pool_02321E84]	; 02321E48
	ldr r2,[r1,#0x0]	; 02321E4A
	mov r0,#0xe	; 02321E4C
	mul r2,r0	; 02321E4E
	ldr r0,[pool_02321E88]	; 02321E50
	ldrh r0,[r0,r2]	; 02321E52
	cmp r0,#0x0	; 02321E54
	bne loc_02321E5C	; 02321E56
	mov r0,#0x0	; 02321E58
	b loc_02321E7E	; 02321E5A
loc_02321E5C:
	cmp r0,#0x2	; 02321E5C
	blt loc_02321E66	; 02321E5E
	mov r0,#0xf	; 02321E60
	mvn r0,r0	; 02321E62
	b loc_02321E7E	; 02321E64
loc_02321E66:
	mov r0,#0x6	; 02321E66
	ldrsh r0,[r1,r0]	; 02321E68
	lsl r0,r0,#0x6	; 02321E6A
	mov r1,#0xf	; 02321E6C
	blx P1_SignedDivMod	; 02321E6E
	sub r0,#0x30	; 02321E72
	cmp r0,#0x0	; 02321E74
	ble loc_02321E7C	; 02321E76
	neg r0,r0	; 02321E78
	b loc_02321E7E	; 02321E7A
loc_02321E7C:
	mov r0,#0x0	; 02321E7C
loc_02321E7E:
	add sp,#0x4	; 02321E7E
	pop {r3}	; 02321E80
	bx r3	; 02321E82
pool_02321E84:
loc_02321E84:
	.word P1_BssStart + 0x1444	; 02321E84
pool_02321E88:
loc_02321E88:
	.word P1_Data_023300C4	; 02321E88

; ===== function loc_02321E8C =====
P1_Entry_02321E8C:
	push {r4,lr}	; 02321E8C
	sub sp,#0x128	; 02321E8E
	add r4,r0,#0x0	; 02321E90
	cmp r4,#0x0	; 02321E92
	beq loc_02321EF4	; 02321E94
	add r0,sp,#0x0	; 02321E96
	ldr r1,[pool_02321F00]	; 02321E98
	add r1,r4,r1	; 02321E9A
	mov r2,#0x30	; 02321E9C
	bl P1_Utf16StrNCpy	; 02321E9E
	mov r1,#0x0	; 02321EA2
	add r0,sp,#0x40	; 02321EA4
	strh r1,[r0,#0x20]	; 02321EA6
	add r0,sp,#0x60	; 02321EA8
	add r0,#0x2	; 02321EAA
	ldr r1,[pool_02321F04]	; 02321EAC
	add r1,r4,r1	; 02321EAE
	mov r2,#0x60	; 02321EB0
	bl P1_Utf16StrNCpy	; 02321EB2
	mov r1,#0x0	; 02321EB6
	add r0,sp,#0x120	; 02321EB8
	add r0,#0x2	; 02321EBA
	strh r1,[r0,#0x0]	; 02321EBC
	mov r0,#0x11	; 02321EBE
	bl loc_023220F0	; 02321EC0
	ldr r0,[pool_02321F08]	; 02321EC4
	add r1,sp,#0x0	; 02321EC6
	bl loc_02324B00	; 02321EC8
	ldr r0,[pool_02321F0C]	; 02321ECC
	add r1,sp,#0x60	; 02321ECE
	add r1,#0x2	; 02321ED0
	bl loc_02324B00	; 02321ED2
	add r0,r4,#0x0	; 02321ED6
	add r0,#0x20	; 02321ED8
	ldr r1,[pool_02321F10]	; 02321EDA
	ldr r2,[pool_02321F14]	; 02321EDC
	bl loc_0232DC20	; 02321EDE
	add r0,r4,#0x0	; 02321EE2
	ldr r1,[pool_02321F18]	; 02321EE4
	mov r2,#0x20	; 02321EE6
	bl loc_0232DCC0	; 02321EE8
	add r0,r4,#0x0	; 02321EEC
	bl loc_02323510	; 02321EEE
	b loc_02321EF8	; 02321EF2
loc_02321EF4:
	bl loc_02323504	; 02321EF4
loc_02321EF8:
	add sp,#0x128	; 02321EF8
	pop {r4}	; 02321EFA
	pop {r3}	; 02321EFC
	bx r3	; 02321EFE
pool_02321F00:
loc_02321F00:
	.word 0x00000238	; 02321F00
pool_02321F04:
loc_02321F04:
	.word 0x00000298	; 02321F04
pool_02321F08:
loc_02321F08:
	.word 0x02331F3C	; 02321F08
pool_02321F0C:
loc_02321F0C:
	.word 0x02331FC0	; 02321F0C
pool_02321F10:
loc_02321F10:
	.word 0x0001EE00	; 02321F10
pool_02321F14:
loc_02321F14:
	.word 0x00000200	; 02321F14
pool_02321F18:
loc_02321F18:
	.word 0x00000140	; 02321F18

; ===== function loc_02321F1C =====
loc_02321F1C:
	push {r4,r5,r6,r7,lr}	; 02321F1C
	sub sp,#0xc	; 02321F1E
	ldr r0,[pool_02322070]	; 02321F20
	ldrb r0,[r0,#0x0]	; 02321F22
	lsl r0,r0,#0x1c	; 02321F24
	lsr r7,r0,#0x1c	; 02321F26
	mov r1,#0x1f	; 02321F28
	ldr r0,[pool_02322074]	; 02321F2A
	str r1,[r0,#0x0]	; 02321F2C
	ldr r2,[pool_02322078]	; 02321F2E
	ldr r3,[r2,#0x0]	; 02321F30
	ldr r0,[pool_0232207C]	; 02321F32
	and r3,r0	; 02321F34
	ldr r0,[pool_02322080]	; 02321F36
	orr r3,r0	; 02321F38
	str r3,[r2,#0x0]	; 02321F3A
	ldr r0,[pool_02322084]	; 02321F3C
	mov r2,#0x10	; 02321F3E
	bl loc_0232D93C	; 02321F40
	ldr r5,[pool_02322088]	; 02321F44
	ldrh r2,[r5,#0x0]	; 02321F46
	mov r0,#0x43	; 02321F48
	and r2,r0	; 02321F4A
	mov r1,#0x10	; 02321F4C
	orr r2,r1	; 02321F4E
	strh r2,[r5,#0x0]	; 02321F50
	ldr r4,[pool_0232208C]	; 02321F52
	ldrh r2,[r4,#0x0]	; 02321F54
	and r2,r0	; 02321F56
	ldr r1,[pool_02322090]	; 02321F58
	orr r2,r1	; 02321F5A
	strh r2,[r4,#0x0]	; 02321F5C
	ldr r3,[pool_02322094]	; 02321F5E
	ldrh r2,[r3,#0x0]	; 02321F60
	and r2,r0	; 02321F62
	ldr r1,[pool_02322098]	; 02321F64
	orr r2,r1	; 02321F66
	strh r2,[r3,#0x0]	; 02321F68
	ldr r1,[pool_0232209C]	; 02321F6A
	ldrh r2,[r1,#0x0]	; 02321F6C
	and r2,r0	; 02321F6E
	ldr r0,[pool_023220A0]	; 02321F70
	orr r2,r0	; 02321F72
	strh r2,[r1,#0x0]	; 02321F74
	ldrh r2,[r5,#0x0]	; 02321F76
	mov r0,#0x3	; 02321F78
	bic r2,r0	; 02321F7A
	strh r2,[r5,#0x0]	; 02321F7C
	ldrh r2,[r4,#0x0]	; 02321F7E
	bic r2,r0	; 02321F80
	strh r2,[r4,#0x0]	; 02321F82
	ldrh r2,[r3,#0x0]	; 02321F84
	bic r2,r0	; 02321F86
	orr r2,r0	; 02321F88
	strh r2,[r3,#0x0]	; 02321F8A
	ldrh r2,[r1,#0x0]	; 02321F8C
	bic r2,r0	; 02321F8E
	orr r2,r0	; 02321F90
	strh r2,[r1,#0x0]	; 02321F92
	mov r1,#0x0	; 02321F94
	ldr r0,[pool_023220A4]	; 02321F96
	str r1,[r0,#0x0]	; 02321F98
	ldr r0,[pool_023220A8]	; 02321F9A
	str r1,[r0,#0x0]	; 02321F9C
	ldr r0,[pool_023220AC]	; 02321F9E
	str r1,[r0,#0x0]	; 02321FA0
	ldr r0,[pool_023220B0]	; 02321FA2
	str r1,[r0,#0x0]	; 02321FA4
	bl P1_GetMainBg1TilemapBase	; 02321FA6
	add r5,r0,#0x0	; 02321FAA
	mov r3,#0x0	; 02321FAC
	str r3,[sp,#0x0]	; 02321FAE
loc_02321FB0:
	ldr r4,[sp,#0x0]	; 02321FB0
	lsl r2,r3,#0x5	; 02321FB2
	lsl r0,r3,#0x6	; 02321FB4
	add r1,r5,r0	; 02321FB6
loc_02321FB8:
	add r0,r4,r2	; 02321FB8
	ldr r6,[pool_023220B4]	; 02321FBA
	orr r0,r6	; 02321FBC
	lsl r6,r4,#0x1	; 02321FBE
	strh r0,[r1,r6]	; 02321FC0
	add r4,r4,#0x1	; 02321FC2
	cmp r4,#0x20	; 02321FC4
	blt loc_02321FB8	; 02321FC6
	add r3,r3,#0x1	; 02321FC8
	cmp r3,#0x18	; 02321FCA
	blt loc_02321FB0	; 02321FCC
	bl P1_GetMainBg1CharacterBase	; 02321FCE
	add r1,r0,#0x0	; 02321FD2
	mov r0,#0x0	; 02321FD4
	str r0,[sp,#0x4]	; 02321FD6
	ldr r0,[sp,#0x4]	; 02321FD8
	ldr r2,[pool_023220B8]	; 02321FDA
	blx loc_0232DE3C	; 02321FDC
	ldr r0,[pool_023220BC]	; 02321FE0
	mov r1,#0x0	; 02321FE2
	ldr r2,[pool_023220C0]	; 02321FE4
	sub r2,r2,r0	; 02321FE6
	bl loc_0232D9F0	; 02321FE8
	ldr r0,[pool_023220C4]	; 02321FEC
	mov r1,#0x0	; 02321FEE
	ldr r2,[pool_023220C8]	; 02321FF0
	sub r2,r2,r0	; 02321FF2
	bl loc_0232DD10	; 02321FF4
	mov r1,#0x0	; 02321FF8
	ldr r0,[pool_023220CC]	; 02321FFA
	strh r1,[r0,#0x0]	; 02321FFC
	mov r1,#0x2	; 02321FFE
	blx P1_CleanDataCacheRange	; 02322000
	ldr r0,[pool_023220CC]	; 02322004
	mov r1,#0x0	; 02322006
	mov r2,#0x2	; 02322008
	bl loc_0232DD10	; 0232200A
	ldr r1,[pool_023220D0]	; 0232200E
	lsl r0,r7,#0x5	; 02322010
	add r5,r1,r0	; 02322012
	add r0,r5,#0x0	; 02322014
	ldr r1,[pool_023220D4]	; 02322016
	mov r2,#0x20	; 02322018
	bl loc_0232DD10	; 0232201A
	ldr r0,[pool_023220D8]	; 0232201E
	mov r1,#0x0	; 02322020
	ldr r2,[pool_023220DC]	; 02322022
	sub r2,r2,r0	; 02322024
	bl loc_0232DB30	; 02322026
	ldr r0,[pool_023220E0]	; 0232202A
	mov r1,#0x0	; 0232202C
	ldr r2,[pool_023220E4]	; 0232202E
	sub r2,r2,r0	; 02322030
	bl loc_0232DAE0	; 02322032
	bl loc_02323E40	; 02322036
	bl loc_02324010	; 0232203A
	bl loc_02323E40	; 0232203E
	ldr r1,[pool_023220E8]	; 02322042
	bl loc_02323F7C	; 02322044
	bl loc_02324C44	; 02322048
	add r4,r0,#0x0	; 0232204C
	bl loc_02323E40	; 0232204E
	add r2,r0,#0x0	; 02322052
	add r0,r4,#0x0	; 02322054
	ldr r1,[pool_023220EC]	; 02322056
	ldr r1,[r2,r1]	; 02322058
	bl loc_02324BE8	; 0232205A
	add r0,r5,#0x0	; 0232205E
	ldr r1,[pool_023220D4]	; 02322060
	mov r2,#0x20	; 02322062
	bl loc_0232DCC0	; 02322064
	add sp,#0xc	; 02322068
	pop {r4,r5,r6,r7}	; 0232206A
	pop {r3}	; 0232206C
	bx r3	; 0232206E
pool_02322070:
loc_02322070:
	.word FirmwareUserSettingsSharedAddress + UserSettingsThemeOffset	; 02322070
pool_02322074:
loc_02322074:
	.word P1_BssStart + 0x1370	; 02322074
pool_02322078:
loc_02322078:
	.word REG_DISPCNT_A	; 02322078
pool_0232207C:
loc_0232207C:
	.word 0xFFFFE0FF	; 0232207C
pool_02322080:
loc_02322080:
	.word 0x00001F00	; 02322080
pool_02322084:
loc_02322084:
	.word REG_BLDCNT	; 02322084
pool_02322088:
loc_02322088:
	.word REG_BG0CNT	; 02322088
pool_0232208C:
loc_0232208C:
	.word REG_BG1CNT	; 0232208C
pool_02322090:
loc_02322090:
	.word 0x00000D08	; 02322090
pool_02322094:
loc_02322094:
	.word REG_BG2CNT	; 02322094
pool_02322098:
loc_02322098:
	.word 0x00000E10	; 02322098
pool_0232209C:
loc_0232209C:
	.word REG_BG3CNT	; 0232209C
pool_023220A0:
loc_023220A0:
	.word 0x00000F10	; 023220A0
pool_023220A4:
loc_023220A4:
	.word REG_BG0HOFS	; 023220A4
pool_023220A8:
loc_023220A8:
	.word REG_BG1HOFS	; 023220A8
pool_023220AC:
loc_023220AC:
	.word REG_BG2HOFS	; 023220AC
pool_023220B0:
loc_023220B0:
	.word REG_BG3HOFS	; 023220B0
pool_023220B4:
loc_023220B4:
	.word 0x00003000	; 023220B4
pool_023220B8:
loc_023220B8:
	.word 0x00008000	; 023220B8
pool_023220BC:
loc_023220BC:
	.word 0x023AE6C0	; 023220BC
pool_023220C0:
loc_023220C0:
	.word 0x023B02C0	; 023220C0
pool_023220C4:
loc_023220C4:
	.word 0x023BBE40	; 023220C4
pool_023220C8:
loc_023220C8:
	.word 0x023BC040	; 023220C8
pool_023220CC:
loc_023220CC:
	.word P1_BssStart + 0x136C	; 023220CC
pool_023220D0:
loc_023220D0:
	.word 0x023BCA40	; 023220D0
pool_023220D4:
loc_023220D4:
	.word 0x000001E0	; 023220D4
pool_023220D8:
loc_023220D8:
	.word 0x023B8640	; 023220D8
pool_023220DC:
loc_023220DC:
	.word 0x023B8E40	; 023220DC
pool_023220E0:
loc_023220E0:
	.word 0x023B6E40	; 023220E0
pool_023220E4:
loc_023220E4:
	.word 0x023B7640	; 023220E4
pool_023220E8:
loc_023220E8:
	.word 0x023C11F8	; 023220E8
pool_023220EC:
loc_023220EC:
	.word 0x0000062C	; 023220EC

; ===== function loc_023220F0 =====
loc_023220F0:
	push {r4,r5,r6,lr}	; 023220F0
	add r6,r0,#0x0	; 023220F2
	mov r0,#0xe	; 023220F4
	add r4,r6,#0x0	; 023220F6
	mul r4,r0	; 023220F8
	ldr r5,[pool_0232214C]	; 023220FA
	ldrh r3,[r5,r4]	; 023220FC
	ldr r1,[pool_02322150]	; 023220FE
	ldr r2,[r1,#0x0]	; 02322100
	mul r2,r0	; 02322102
	ldrh r0,[r5,r2]	; 02322104
	cmp r3,r0	; 02322106
	bcc loc_0232213A	; 02322108
	sub r5,r3,#0x1	; 0232210A
	mov r0,#0x2c	; 0232210C
	mul r5,r0	; 0232210E
	ldr r0,[pool_02322154]	; 02322110
	add r0,r0,r5	; 02322112
	ldr r1,[pool_02322158]	; 02322114
	ldr r2,[pool_0232215C]	; 02322116
	ldrh r2,[r2,r4]	; 02322118
	bl loc_02324B5C	; 0232211A
	ldr r0,[pool_02322160]	; 0232211E
	add r0,r0,r5	; 02322120
	ldr r1,[pool_02322158]	; 02322122
	ldr r2,[pool_02322164]	; 02322124
	ldrh r2,[r2,r4]	; 02322126
	bl loc_02324B5C	; 02322128
	ldr r0,[pool_02322150]	; 0232212C
	str r6,[r0,#0x0]	; 0232212E
	mov r1,#0x0	; 02322130
	strh r1,[r0,#0x6]	; 02322132
	mov r1,#0x1	; 02322134
	strh r1,[r0,#0x4]	; 02322136
	b loc_02322144	; 02322138
loc_0232213A:
	mov r0,#0xf	; 0232213A
	strh r0,[r1,#0x6]	; 0232213C
	mov r0,#0x0	; 0232213E
	mvn r0,r0	; 02322140
	strh r0,[r1,#0x4]	; 02322142
loc_02322144:
	pop {r4,r5,r6}	; 02322144
	pop {r3}	; 02322146
	bx r3	; 02322148
	.byte 0xC0, 0x46	; 0232214C
pool_0232214C:
loc_0232214C:
	.word P1_Data_023300C4	; 0232214C
pool_02322150:
loc_02322150:
	.word P1_BssStart + 0x1444	; 02322150
pool_02322154:
loc_02322154:
	.word 0x02331F10	; 02322154
pool_02322158:
loc_02322158:
	.word 0x023A61F4	; 02322158
pool_0232215C:
loc_0232215C:
	.word P1_Data_023300C6	; 0232215C
pool_02322160:
loc_02322160:
	.word 0x02331F94	; 02322160
pool_02322164:
loc_02322164:
	.word P1_Data_023300C8	; 02322164

; ===== function loc_02322168 =====
loc_02322168:
	push {r4,r5,r6,r7,lr}	; 02322168
	sub sp,#0x4	; 0232216A
	mov r5,#0x0	; 0232216C
	ldr r7,[pool_023221B8]	; 0232216E
	b loc_0232219E	; 02322170
loc_02322172:
	lsl r0,r5,#0x1	; 02322172
	add r0,r2,r0	; 02322174
	ldrh r1,[r0,#0x6]	; 02322176
	mov r0,#0xe	; 02322178
	mul r1,r0	; 0232217A
	add r4,r7,r1	; 0232217C
	add r6,r5,#0x0	; 0232217E
	mov r0,#0x2c	; 02322180
	mul r6,r0	; 02322182
	ldr r0,[pool_023221BC]	; 02322184
	add r0,r0,r6	; 02322186
	ldr r1,[pool_023221C0]	; 02322188
	ldrh r2,[r4,#0x2]	; 0232218A
	bl loc_02324B5C	; 0232218C
	ldr r0,[pool_023221C4]	; 02322190
	add r0,r0,r6	; 02322192
	ldr r1,[pool_023221C0]	; 02322194
	ldrh r2,[r4,#0x4]	; 02322196
	bl loc_02324B5C	; 02322198
	add r5,r5,#0x1	; 0232219C
loc_0232219E:
	ldr r0,[pool_023221C8]	; 0232219E
	ldr r1,[r0,#0x0]	; 023221A0
	mov r0,#0xe	; 023221A2
	mul r1,r0	; 023221A4
	add r2,r7,r1	; 023221A6
	ldrh r0,[r7,r1]	; 023221A8
	cmp r5,r0	; 023221AA
	blt loc_02322172	; 023221AC
	add sp,#0x4	; 023221AE
	pop {r4,r5,r6,r7}	; 023221B0
	pop {r3}	; 023221B2
	bx r3	; 023221B4
	.byte 0xC0, 0x46	; 023221B8
pool_023221B8:
loc_023221B8:
	.word 0x023300C4	; 023221B8
pool_023221BC:
loc_023221BC:
	.word 0x02331F10	; 023221BC
pool_023221C0:
loc_023221C0:
	.word 0x023A61F4	; 023221C0
pool_023221C4:
loc_023221C4:
	.word 0x02331F94	; 023221C4
pool_023221C8:
loc_023221C8:
	.word P1_BssStart + 0x1444	; 023221C8

; ===== function loc_023221CC =====
loc_023221CC:
	push {r4,r5,r6,r7,lr}	; 023221CC
	sub sp,#0x24	; 023221CE
	ldr r2,[pool_023223BC]	; 023221D0
	ldr r0,[r2,#0x8]	; 023221D2
	cmp r0,#0x0	; 023221D4
	bne loc_023221DA	; 023221D6
	b loc_023223B2	; 023221D8
loc_023221DA:
	mov r0,#0x6	; 023221DA
	ldrsh r3,[r2,r0]	; 023221DC
	mov r1,#0x4	; 023221DE
	ldrsh r1,[r2,r1]	; 023221E0
	add r3,r3,r1	; 023221E2
	strh r3,[r2,#0x6]	; 023221E4
	cmp r1,#0x1	; 023221E6
	bne loc_023221F4	; 023221E8
	ldrsh r0,[r2,r0]	; 023221EA
	cmp r0,#0xf	; 023221EC
	bne loc_023221F4	; 023221EE
	mov r0,#0x0	; 023221F0
	strh r0,[r2,#0x4]	; 023221F2
loc_023221F4:
	ldr r0,[pool_023223BC]	; 023221F4
	mov r1,#0x4	; 023221F6
	ldrsh r3,[r0,r1]	; 023221F8
	mov r2,#0x0	; 023221FA
	mvn r1,r2	; 023221FC
	cmp r3,r1	; 023221FE
	bne loc_0232222E	; 02322200
	mov r1,#0x6	; 02322202
	ldrsh r1,[r0,r1]	; 02322204
	cmp r1,#0x0	; 02322206
	bne loc_0232222E	; 02322208
	strh r2,[r0,#0x4]	; 0232220A
	ldr r1,[r0,#0x0]	; 0232220C
	mov r3,#0xe	; 0232220E
	mul r1,r3	; 02322210
	ldr r3,[pool_023223C0]	; 02322212
	ldrh r4,[r3,r1]	; 02322214
	cmp r4,#0x1	; 02322216
	bne loc_0232221E	; 02322218
	str r2,[r0,#0x0]	; 0232221A
	b loc_0232222E	; 0232221C
loc_0232221E:
	mov r2,#0xf	; 0232221E
	strh r2,[r0,#0x6]	; 02322220
	ldr r3,[pool_023223C4]	; 02322222
	sub r2,r4,#0x2	; 02322224
	lsl r2,r2,#0x1	; 02322226
	add r1,r3,r1	; 02322228
	ldrh r1,[r2,r1]	; 0232222A
	str r1,[r0,#0x0]	; 0232222C
loc_0232222E:
	bl loc_02323E40	; 0232222E
	str r0,[sp,#0xc]	; 02322232
	ldr r0,[pool_023223BC]	; 02322234
	ldr r1,[r0,#0x0]	; 02322236
	mov r0,#0xe	; 02322238
	mul r1,r0	; 0232223A
	ldr r0,[pool_023223C0]	; 0232223C
	ldrh r5,[r0,r1]	; 0232223E
	b loc_023223AC	; 02322240
loc_02322242:
	sub r7,r5,#0x1	; 02322242
	ldr r0,[pool_023223BC]	; 02322244
	ldr r1,[r0,#0x0]	; 02322246
	mov r0,#0xe	; 02322248
	mul r1,r0	; 0232224A
	ldr r0,[pool_023223C0]	; 0232224C
	ldrh r0,[r0,r1]	; 0232224E
	sub r0,r0,r5	; 02322250
	str r0,[sp,#0x10]	; 02322252
	neg r0,r0	; 02322254
	lsl r6,r0,#0x4	; 02322256
	ldr r1,[pool_023223BC]	; 02322258
	mov r0,#0x6	; 0232225A
	ldrsh r0,[r1,r0]	; 0232225C
	lsl r0,r0,#0x6	; 0232225E
	mov r1,#0xf	; 02322260
	blx P1_SignedDivMod	; 02322262
	add r1,r6,#0x0	; 02322266
	add r1,#0x40	; 02322268
	sub r0,r1,r0	; 0232226A
	lsl r0,r0,#0x10	; 0232226C
	asr r4,r0,#0x10	; 0232226E
	ldr r0,[sp,#0x10]	; 02322270
	cmp r0,#0x0	; 02322272
	ble loc_0232227E	; 02322274
	add r6,#0x10	; 02322276
	cmp r4,r6	; 02322278
	blt loc_0232227E	; 0232227A
	add r4,r6,#0x0	; 0232227C
loc_0232227E:
	bl loc_02323584	; 0232227E
	sub r4,r4,r0	; 02322282
	lsl r0,r4,#0x10	; 02322284
	asr r6,r0,#0x10	; 02322286
	add r1,r7,#0x0	; 02322288
	str r1,[sp,#0x18]	; 0232228A
	mov r0,#0x2c	; 0232228C
	mul r1,r0	; 0232228E
	str r1,[sp,#0x18]	; 02322290
	mov r0,#0x1	; 02322292
	str r0,[sp,#0x0]	; 02322294
	ldr r1,[pool_023223C8]	; 02322296
	ldr r0,[sp,#0x18]	; 02322298
	add r0,r1,r0	; 0232229A
	mov r1,#0x0	; 0232229C
	add r2,r6,#0x0	; 0232229E
	lsl r3,r1,#0	; 023222A0
	bl loc_0232373C	; 023222A2
	mov r0,#0x1	; 023222A6
	str r0,[sp,#0x0]	; 023222A8
	ldr r1,[pool_023223CC]	; 023222AA
	ldr r0,[sp,#0x18]	; 023222AC
	add r0,r1,r0	; 023222AE
	mov r1,#0x0	; 023222B0
	add r2,r6,#0x0	; 023222B2
	lsl r3,r1,#0	; 023222B4
	bl loc_0232373C	; 023222B6
	ldr r0,[pool_023223BC]	; 023222BA
	ldr r0,[r0,#0x0]	; 023222BC
	mov r1,#0xe	; 023222BE
	mul r0,r1	; 023222C0
	lsl r2,r7,#0x1	; 023222C2
	ldr r1,[pool_023223C0]	; 023222C4
	add r0,r1,r0	; 023222C6
	add r0,r2,r0	; 023222C8
	ldrh r3,[r0,#0x6]	; 023222CA
	cmp r3,#0x11	; 023222CC
	bne loc_0232235A	; 023222CE
	ldr r0,[pool_023223D0]	; 023222D0
	mov r1,#0x0	; 023222D2
	bl loc_0232925C	; 023222D4
	add r6,r0,#0x0	; 023222D8
	bl P3_Entry_02367868	; 023222DA
	cmp r0,#0x3	; 023222DE
	bhi loc_0232230E	; 023222E0
	add r0,r0,r0	; 023222E2
P1_SwitchIndexPC_023222E2:
	add r0,pc	; 023222E4
	ldrh r0,[r0,#(P1_SwitchTable_023222E2 - (P1_SwitchIndexPC_023222E2 + 4))]	; 023222E6
	lsl r0,r0,#0x10	; 023222E8
	asr r0,r0,#0x10	; 023222EA
P1_SwitchTargetPC_023222E2:
	add r0,pc	; 023222EC
	bx r0	; 023222EE
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023222E2:
	.halfword (loc_023222F8 + 1) - (P1_SwitchTargetPC_023222E2 + 4)
	.halfword (loc_023222FE + 1) - (P1_SwitchTargetPC_023222E2 + 4)
	.halfword (loc_02322304 + 1) - (P1_SwitchTargetPC_023222E2 + 4)
	.halfword (loc_0232230A + 1) - (P1_SwitchTargetPC_023222E2 + 4)
P1_SwitchTable_023222E2End:
loc_023222F8:
	mov r0,#0x13	; 023222F8
	str r0,[sp,#0x14]	; 023222FA
	b loc_0232230E	; 023222FC
loc_023222FE:
	mov r0,#0x14	; 023222FE
	str r0,[sp,#0x14]	; 02322300
	b loc_0232230E	; 02322302
loc_02322304:
	mov r0,#0x15	; 02322304
	str r0,[sp,#0x14]	; 02322306
	b loc_0232230E	; 02322308
loc_0232230A:
	mov r0,#0x16	; 0232230A
	str r0,[sp,#0x14]	; 0232230C
loc_0232230E:
	bl loc_02323E40	; 0232230E
	mov r1,#0x0	; 02322312
	str r1,[sp,#0x0]	; 02322314
	str r4,[sp,#0x4]	; 02322316
	ldr r1,[pool_023223D4]	; 02322318
	ldr r2,[pool_023223D8]	; 0232231A
	ldr r3,[sp,#0x14]	; 0232231C
	bl loc_02323BFC	; 0232231E
	mov r0,#0x0	; 02322322
	ldrsh r0,[r6,r0]	; 02322324
	lsl r0,r0,#0x14	; 02322326
	asr r1,r0,#0x14	; 02322328
	ldr r0,[pool_023223DC]	; 0232232A
	and r1,r0	; 0232232C
	lsl r0,r1,#0x10	; 0232232E
	mov r1,#0x2	; 02322330
	ldrsh r1,[r6,r1]	; 02322332
	lsl r1,r1,#0x14	; 02322334
	asr r1,r1,#0x14	; 02322336
	add r2,r1,r4	; 02322338
	mov r1,#0xff	; 0232233A
	and r2,r1	; 0232233C
	ldr r1,[pool_023223E0]	; 0232233E
	orr r2,r1	; 02322340
	orr r0,r2	; 02322342
	str r0,[sp,#0x1c]	; 02322344
	ldr r1,[pool_023223E4]	; 02322346
	add r0,sp,#0x1c	; 02322348
	strh r1,[r0,#0x4]	; 0232234A
	bl loc_02323E40	; 0232234C
	add r1,sp,#0x1c	; 02322350
	mov r2,#0x0	; 02322352
	bl loc_0232395C	; 02322354
	b loc_02322398	; 02322358
loc_0232235A:
	add r1,r3,#0x0	; 0232235A
	mov r0,#0xe	; 0232235C
	mul r1,r0	; 0232235E
	ldr r0,[pool_023223C0]	; 02322360
	add r1,r0,r1	; 02322362
	mov r0,#0xc	; 02322364
	ldrsh r0,[r1,r0]	; 02322366
	mov r1,#0x0	; 02322368
	mvn r1,r1	; 0232236A
	cmp r0,r1	; 0232236C
	bne loc_02322384	; 0232236E
	mov r0,#0x0	; 02322370
	str r0,[sp,#0x0]	; 02322372
	str r4,[sp,#0x4]	; 02322374
	ldr r0,[sp,#0xc]	; 02322376
	ldr r1,[pool_023223D4]	; 02322378
	ldr r2,[pool_023223D8]	; 0232237A
	sub r3,r3,#0x1	; 0232237C
	bl loc_02323BFC	; 0232237E
	b loc_02322398	; 02322382
loc_02322384:
	mov r1,#0x0	; 02322384
	str r1,[sp,#0x0]	; 02322386
	str r4,[sp,#0x4]	; 02322388
	str r0,[sp,#0x8]	; 0232238A
	ldr r0,[sp,#0xc]	; 0232238C
	ldr r1,[pool_023223D4]	; 0232238E
	ldr r2,[pool_023223D8]	; 02322390
	sub r3,r3,#0x1	; 02322392
	bl loc_02323BA8	; 02322394
loc_02322398:
	mov r0,#0x0	; 02322398
	str r0,[sp,#0x0]	; 0232239A
	str r4,[sp,#0x4]	; 0232239C
	ldr r0,[sp,#0xc]	; 0232239E
	ldr r1,[pool_023223D4]	; 023223A0
	ldr r2,[pool_023223D8]	; 023223A2
	mov r3,#0x10	; 023223A4
	bl loc_02323BFC	; 023223A6
	sub r5,r5,#0x1	; 023223AA
loc_023223AC:
	cmp r5,#0x0	; 023223AC
	ble loc_023223B2	; 023223AE
	b loc_02322242	; 023223B0
loc_023223B2:
	add sp,#0x24	; 023223B2
	pop {r4,r5,r6,r7}	; 023223B4
	pop {r3}	; 023223B6
	bx r3	; 023223B8
	.byte 0xC0, 0x46	; 023223BC
pool_023223BC:
loc_023223BC:
	.word P1_BssStart + 0x1444	; 023223BC
pool_023223C0:
loc_023223C0:
	.word P1_Data_023300C4	; 023223C0
pool_023223C4:
loc_023223C4:
	.word 0x023300CA	; 023223C4
pool_023223C8:
loc_023223C8:
	.word 0x02331F10	; 023223C8
pool_023223CC:
loc_023223CC:
	.word 0x02331F94	; 023223CC
pool_023223D0:
loc_023223D0:
	.word 0x023A4C48	; 023223D0
pool_023223D4:
loc_023223D4:
	.word 0x023C11F8	; 023223D4
pool_023223D8:
loc_023223D8:
	.word 0x023A52EC	; 023223D8
pool_023223DC:
loc_023223DC:
	.word 0x000001FF	; 023223DC
pool_023223E0:
loc_023223E0:
	.word 0x80000000	; 023223E0
pool_023223E4:
loc_023223E4:
	.word 0x0000A3DC	; 023223E4

; ===== function loc_023223E8 =====
P1_Entry_023223E8:
	push {r4,r5,r6,r7,lr}	; 023223E8
	sub sp,#0x4	; 023223EA
	mov r1,#0x1	; 023223EC
	ldr r0,[pool_02322430]	; 023223EE
	str r1,[r0,#0x8]	; 023223F0
	mov r5,#0x0	; 023223F2
	str r5,[r0,#0x0]	; 023223F4
	strh r5,[r0,#0x4]	; 023223F6
	strh r5,[r0,#0x6]	; 023223F8
	ldr r6,[pool_02322434]	; 023223FA
	ldr r7,[pool_02322438]	; 023223FC
loc_023223FE:
	add r4,r5,#0x0	; 023223FE
	mov r0,#0x2c	; 02322400
	mul r4,r0	; 02322402
	bl loc_02324C44	; 02322404
	add r1,r6,r4	; 02322408
	ldr r2,[pool_0232243C]	; 0232240A
	mov r3,#0x95	; 0232240C
	bl loc_02324BB4	; 0232240E
	bl loc_02324C44	; 02322412
	add r1,r7,r4	; 02322416
	ldr r2,[pool_0232243C]	; 02322418
	mov r3,#0x7f	; 0232241A
	bl loc_02324BB4	; 0232241C
	add r5,r5,#0x1	; 02322420
	cmp r5,#0x3	; 02322422
	blt loc_023223FE	; 02322424
	add sp,#0x4	; 02322426
	pop {r4,r5,r6,r7}	; 02322428
	pop {r3}	; 0232242A
	bx r3	; 0232242C
	.byte 0xC0, 0x46	; 02322430
pool_02322430:
loc_02322430:
	.word P1_BssStart + 0x1444	; 02322430
pool_02322434:
loc_02322434:
	.word 0x02331F10	; 02322434
pool_02322438:
loc_02322438:
	.word 0x02331F94	; 02322438
pool_0232243C:
loc_0232243C:
	.word 0x023A61F4	; 0232243C

; ===== function loc_02322440 =====
loc_02322440:
	ldr r0,[pool_02322490]	; 02322440
	ldr r0,[r0,#0x0]	; 02322442
	cmp r0,#0x5	; 02322444
	bhi loc_0232248A	; 02322446
	add r0,r0,r0	; 02322448
P1_SwitchIndexPC_02322448:
	add r0,pc	; 0232244A
	ldrh r0,[r0,#(P1_SwitchTable_02322448 - (P1_SwitchIndexPC_02322448 + 4))]	; 0232244C
	lsl r0,r0,#0x10	; 0232244E
	asr r0,r0,#0x10	; 02322450
P1_SwitchTargetPC_02322448:
	add r0,pc	; 02322452
	bx r0	; 02322454
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02322448:
	.halfword (loc_02322462 + 1) - (P1_SwitchTargetPC_02322448 + 4)
	.halfword (loc_02322466 + 1) - (P1_SwitchTargetPC_02322448 + 4)
	.halfword (loc_0232246E + 1) - (P1_SwitchTargetPC_02322448 + 4)
	.halfword (loc_02322476 + 1) - (P1_SwitchTargetPC_02322448 + 4)
	.halfword (loc_0232247A + 1) - (P1_SwitchTargetPC_02322448 + 4)
	.halfword (loc_02322482 + 1) - (P1_SwitchTargetPC_02322448 + 4)
P1_SwitchTable_02322448End:
loc_02322462:
	mov r0,#0x0	; 02322462
	bx lr	; 02322464
loc_02322466:
	ldr r0,[pool_02322494]	; 02322466
	ldr r0,[r0,#0x38]	; 02322468
	neg r0,r0	; 0232246A
	bx lr	; 0232246C
loc_0232246E:
	ldr r0,[pool_02322494]	; 0232246E
	ldr r0,[r0,#0x38]	; 02322470
	sub r0,#0x10	; 02322472
	bx lr	; 02322474
loc_02322476:
	mov r0,#0x0	; 02322476
	bx lr	; 02322478
loc_0232247A:
	ldr r0,[pool_02322494]	; 0232247A
	ldr r0,[r0,#0x38]	; 0232247C
	neg r0,r0	; 0232247E
	bx lr	; 02322480
loc_02322482:
	ldr r0,[pool_02322494]	; 02322482
	ldr r0,[r0,#0x38]	; 02322484
	sub r0,#0x10	; 02322486
	bx lr	; 02322488
loc_0232248A:
	mov r0,#0x0	; 0232248A
	bx lr	; 0232248C
	.byte 0xC0, 0x46	; 02322490
pool_02322490:
loc_02322490:
	.word P1_BssStart + 0x1388	; 02322490
pool_02322494:
loc_02322494:
	.word P1_BssStart + 0x1408	; 02322494

; ===== function loc_02322498 =====
loc_02322498:
	ldr r0,[pool_023224C8]	; 02322498
	ldr r0,[r0,#0x0]	; 0232249A
	cmp r0,#0x5	; 0232249C
	bhi loc_023224C2	; 0232249E
	add r0,r0,r0	; 023224A0
P1_SwitchIndexPC_023224A0:
	add r0,pc	; 023224A2
	ldrh r0,[r0,#(P1_SwitchTable_023224A0 - (P1_SwitchIndexPC_023224A0 + 4))]	; 023224A4
	lsl r0,r0,#0x10	; 023224A6
	asr r0,r0,#0x10	; 023224A8
P1_SwitchTargetPC_023224A0:
	add r0,pc	; 023224AA
	bx r0	; 023224AC
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023224A0:
	.halfword (loc_023224BE + 1) - (P1_SwitchTargetPC_023224A0 + 4)
	.halfword (loc_023224BE + 1) - (P1_SwitchTargetPC_023224A0 + 4)
	.halfword (loc_023224BA + 1) - (P1_SwitchTargetPC_023224A0 + 4)
	.halfword (loc_023224BA + 1) - (P1_SwitchTargetPC_023224A0 + 4)
	.halfword (loc_023224BA + 1) - (P1_SwitchTargetPC_023224A0 + 4)
	.halfword (loc_023224BE + 1) - (P1_SwitchTargetPC_023224A0 + 4)
P1_SwitchTable_023224A0End:
loc_023224BA:
	mov r0,#0x1	; 023224BA
	bx lr	; 023224BC
loc_023224BE:
	mov r0,#0x0	; 023224BE
	bx lr	; 023224C0
loc_023224C2:
	mov r0,#0x0	; 023224C2
	bx lr	; 023224C4
	.byte 0xC0, 0x46	; 023224C8
pool_023224C8:
loc_023224C8:
	.word P1_BssStart + 0x1388	; 023224C8

; ===== function loc_023224CC =====
loc_023224CC:
	push {lr}	; 023224CC
	sub sp,#0x4	; 023224CE
	ldr r0,[r0,#0x0]	; 023224D0
	cmp r0,#0x5	; 023224D2
	bhi loc_02322512	; 023224D4
	add r0,r0,r0	; 023224D6
P1_SwitchIndexPC_023224D6:
	add r0,pc	; 023224D8
	ldrh r0,[r0,#(P1_SwitchTable_023224D6 - (P1_SwitchIndexPC_023224D6 + 4))]	; 023224DA
	lsl r0,r0,#0x10	; 023224DC
	asr r0,r0,#0x10	; 023224DE
P1_SwitchTargetPC_023224D6:
	add r0,pc	; 023224E0
	bx r0	; 023224E2
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023224D6:
	.halfword (loc_02322500 + 1) - (P1_SwitchTargetPC_023224D6 + 4)
	.halfword (loc_02322500 + 1) - (P1_SwitchTargetPC_023224D6 + 4)
	.halfword (loc_023224F0 + 1) - (P1_SwitchTargetPC_023224D6 + 4)
	.halfword (loc_023224F0 + 1) - (P1_SwitchTargetPC_023224D6 + 4)
	.halfword (loc_023224F0 + 1) - (P1_SwitchTargetPC_023224D6 + 4)
	.halfword (loc_02322500 + 1) - (P1_SwitchTargetPC_023224D6 + 4)
P1_SwitchTable_023224D6End:
loc_023224F0:
	ldr r1,[pool_02322530]	; 023224F0
	ldr r2,[r1,#0x0]	; 023224F2
	ldr r0,[pool_02322534]	; 023224F4
	and r2,r0	; 023224F6
	ldr r0,[pool_02322538]	; 023224F8
	orr r2,r0	; 023224FA
	str r2,[r1,#0x0]	; 023224FC
	b loc_02322512	; 023224FE
loc_02322500:
	ldr r1,[pool_02322530]	; 02322500
	ldr r2,[r1,#0x0]	; 02322502
	ldr r0,[pool_02322534]	; 02322504
	and r2,r0	; 02322506
	ldr r0,[pool_0232253C]	; 02322508
	ldr r0,[r0,#0x0]	; 0232250A
	lsl r0,r0,#0x8	; 0232250C
	orr r2,r0	; 0232250E
	str r2,[r1,#0x0]	; 02322510
loc_02322512:
	ldr r0,[pool_02322540]	; 02322512
	ldr r0,[r0,#0x0]	; 02322514
	cmp r0,#0x10	; 02322516
	bne loc_02322528	; 02322518
	bl loc_02322440	; 0232251A
	add r2,r0,#0x0	; 0232251E
	ldr r0,[pool_02322544]	; 02322520
	mov r1,#0x1f	; 02322522
	bl loc_0232D93C	; 02322524
loc_02322528:
	add sp,#0x4	; 02322528
	pop {r3}	; 0232252A
	bx r3	; 0232252C
	.byte 0xC0, 0x46	; 02322530
pool_02322530:
loc_02322530:
	.word REG_DISPCNT_A	; 02322530
pool_02322534:
loc_02322534:
	.word 0xFFFFE0FF	; 02322534
pool_02322538:
loc_02322538:
	.word 0x00001000	; 02322538
pool_0232253C:
loc_0232253C:
	.word P1_BssStart + 0x1370	; 0232253C
pool_02322540:
loc_02322540:
	.word P1_BssStart + 0x1374	; 02322540
pool_02322544:
loc_02322544:
	.word REG_BLDCNT	; 02322544

; ===== function loc_02322548 =====
loc_02322548:
	push {r4,r5,r6,r7,lr}	; 02322548
	sub sp,#0x44	; 0232254A
	add r5,r0,#0x0	; 0232254C
	add r0,#0xb8	; 0232254E
	ldr r0,[r0,#0x0]	; 02322550
	cmp r0,#0x10	; 02322552
	bge loc_0232258E	; 02322554
	ldr r0,[r5,#0x0]	; 02322556
	cmp r0,#0x0	; 02322558
	beq loc_0232256E	; 0232255A
	cmp r0,#0x3	; 0232255C
	beq loc_0232256E	; 0232255E
	add r0,r5,#0x0	; 02322560
	add r0,#0xb8	; 02322562
	ldr r0,[r0,#0x0]	; 02322564
	add r1,r0,#0x1	; 02322566
	add r0,r5,#0x0	; 02322568
	add r0,#0xb8	; 0232256A
	str r1,[r0,#0x0]	; 0232256C
loc_0232256E:
	add r0,r5,#0x0	; 0232256E
	add r0,#0xb8	; 02322570
	ldr r0,[r0,#0x0]	; 02322572
	cmp r0,#0x10	; 02322574
	bne loc_0232258E	; 02322576
	mov r1,#0x0	; 02322578
	add r0,r5,#0x0	; 0232257A
	add r0,#0xb8	; 0232257C
	str r1,[r0,#0x0]	; 0232257E
	ldr r0,[r5,#0x0]	; 02322580
	add r0,r0,#0x1	; 02322582
	str r0,[r5,#0x0]	; 02322584
	ldr r0,[r5,#0x0]	; 02322586
	cmp r0,#0x6	; 02322588
	bne loc_0232258E	; 0232258A
	str r1,[r5,#0x0]	; 0232258C
loc_0232258E:
	bl loc_02322498	; 0232258E
	cmp r0,#0x0	; 02322592
	bne loc_02322598	; 02322594
	b loc_02322784	; 02322596
loc_02322598:
	add r0,sp,#0x30	; 02322598
	ldr r1,[r5,#0x4]	; 0232259A
	bl loc_0232279C	; 0232259C
	add r0,r5,#0x0	; 023225A0
	add r0,#0x8c	; 023225A2
	add r1,sp,#0x30	; 023225A4
	bl loc_02324B00	; 023225A6
	ldr r0,[r5,#0x4]	; 023225AA
	cmp r0,#0x0	; 023225AC
	bne loc_023225C2	; 023225AE
	mov r0,#0x9c	; 023225B0
	bl loc_02324D9C	; 023225B2
	add r1,r0,#0x0	; 023225B6
	add r0,r5,#0x0	; 023225B8
	add r0,#0x60	; 023225BA
	bl loc_02324B00	; 023225BC
	b loc_023225D2	; 023225C0
loc_023225C2:
	mov r0,#0x9d	; 023225C2
	bl loc_02324D9C	; 023225C4
	add r1,r0,#0x0	; 023225C8
	add r0,r5,#0x0	; 023225CA
	add r0,#0x60	; 023225CC
	bl loc_02324B00	; 023225CE
loc_023225D2:
	add r0,sp,#0x24	; 023225D2
	bl loc_02326A48	; 023225D4
	ldr r4,[sp,#0x24]	; 023225D8
	add r0,r4,#0x0	; 023225DA
	mov r1,#0xa	; 023225DC
	blx P1_UnsignedDivMod	; 023225DE
	str r0,[sp,#0x10]	; 023225E2
	add r0,r4,#0x0	; 023225E4
	mov r1,#0xa	; 023225E6
	blx P1_UnsignedDivMod	; 023225E8
	add r7,r1,#0x0	; 023225EC
	ldr r4,[sp,#0x28]	; 023225EE
	add r0,r4,#0x0	; 023225F0
	mov r1,#0xa	; 023225F2
	blx P1_UnsignedDivMod	; 023225F4
	str r0,[sp,#0x14]	; 023225F8
	add r0,r4,#0x0	; 023225FA
	mov r1,#0xa	; 023225FC
	blx P1_UnsignedDivMod	; 023225FE
	str r1,[sp,#0xc]	; 02322602
	ldr r0,[pool_0232278C]	; 02322604
	ldrb r4,[r0,#0x0]	; 02322606
	add r0,r4,#0x0	; 02322608
	mov r1,#0xa	; 0232260A
	blx P1_SignedDivMod	; 0232260C
	str r0,[sp,#0x18]	; 02322610
	add r0,r4,#0x0	; 02322612
	mov r1,#0xa	; 02322614
	blx P1_SignedDivMod	; 02322616
	str r1,[sp,#0x8]	; 0232261A
	ldr r0,[pool_0232278C]	; 0232261C
	ldrb r4,[r0,#0x1]	; 0232261E
	add r0,r4,#0x0	; 02322620
	mov r1,#0xa	; 02322622
	blx P1_SignedDivMod	; 02322624
	str r0,[sp,#0x1c]	; 02322628
	add r0,r4,#0x0	; 0232262A
	mov r1,#0xa	; 0232262C
	blx P1_SignedDivMod	; 0232262E
	add r6,r1,#0x0	; 02322632
	mov r4,#0x0	; 02322634
	str r4,[sp,#0x20]	; 02322636
loc_02322638:
	mov r0,#0x1	; 02322638
	str r0,[sp,#0x0]	; 0232263A
	add r2,r5,#0x0	; 0232263C
	add r2,#0x8	; 0232263E
	add r1,r4,#0x0	; 02322640
	mov r0,#0x2c	; 02322642
	mul r1,r0	; 02322644
	add r0,r2,r1	; 02322646
	ldr r1,[sp,#0x20]	; 02322648
	lsl r2,r1,#0	; 0232264A
	lsl r3,r1,#0	; 0232264C
	bl loc_0232373C	; 0232264E
	add r4,r4,#0x1	; 02322652
	cmp r4,#0x2	; 02322654
	blt loc_02322638	; 02322656
	mov r0,#0x1	; 02322658
	str r0,[sp,#0x0]	; 0232265A
	add r0,r5,#0x0	; 0232265C
	add r0,#0x60	; 0232265E
	mov r1,#0x0	; 02322660
	add r2,r1,#0x0	; 02322662
	add r3,r1,#0x0	; 02322664
	bl loc_0232373C	; 02322666
	mov r0,#0x1	; 0232266A
	str r0,[sp,#0x0]	; 0232266C
	add r5,#0x8c	; 0232266E
	add r0,r5,#0x0	; 02322670
	mov r1,#0x0	; 02322672
	add r2,r1,#0x0	; 02322674
	add r3,r1,#0x0	; 02322676
	bl loc_0232373C	; 02322678
	bl loc_02323E40	; 0232267C
	mov r1,#0x3e	; 02322680
	str r1,[sp,#0x0]	; 02322682
	mov r1,#0x20	; 02322684
	str r1,[sp,#0x4]	; 02322686
	ldr r1,[pool_02322790]	; 02322688
	ldr r2,[pool_02322794]	; 0232268A
	ldr r3,[sp,#0x10]	; 0232268C
	lsl r4,r3,#0x2	; 0232268E
	ldr r3,[pool_02322798]	; 02322690
	ldr r3,[r3,r4]	; 02322692
	bl loc_02323BFC	; 02322694
	bl loc_02323E40	; 02322698
	mov r1,#0x5d	; 0232269C
	str r1,[sp,#0x0]	; 0232269E
	mov r1,#0x20	; 023226A0
	str r1,[sp,#0x4]	; 023226A2
	ldr r1,[pool_02322790]	; 023226A4
	ldr r2,[pool_02322794]	; 023226A6
	lsl r4,r7,#0x2	; 023226A8
	ldr r3,[pool_02322798]	; 023226AA
	ldr r3,[r3,r4]	; 023226AC
	bl loc_02323BFC	; 023226AE
	bl loc_02323E40	; 023226B2
	mov r1,#0x74	; 023226B6
	str r1,[sp,#0x0]	; 023226B8
	mov r1,#0x20	; 023226BA
	str r1,[sp,#0x4]	; 023226BC
	ldr r1,[pool_02322790]	; 023226BE
	ldr r2,[pool_02322794]	; 023226C0
	mov r3,#0x0	; 023226C2
	bl loc_02323BFC	; 023226C4
	bl loc_02323E40	; 023226C8
	mov r1,#0x8b	; 023226CC
	str r1,[sp,#0x0]	; 023226CE
	mov r1,#0x20	; 023226D0
	str r1,[sp,#0x4]	; 023226D2
	ldr r1,[pool_02322790]	; 023226D4
	ldr r2,[pool_02322794]	; 023226D6
	ldr r3,[sp,#0x14]	; 023226D8
	lsl r4,r3,#0x2	; 023226DA
	ldr r3,[pool_02322798]	; 023226DC
	ldr r3,[r3,r4]	; 023226DE
	bl loc_02323BFC	; 023226E0
	bl loc_02323E40	; 023226E4
	mov r1,#0xaa	; 023226E8
	str r1,[sp,#0x0]	; 023226EA
	mov r1,#0x20	; 023226EC
	str r1,[sp,#0x4]	; 023226EE
	ldr r1,[pool_02322790]	; 023226F0
	ldr r2,[pool_02322794]	; 023226F2
	ldr r3,[sp,#0xc]	; 023226F4
	lsl r4,r3,#0x2	; 023226F6
	ldr r3,[pool_02322798]	; 023226F8
	ldr r3,[r3,r4]	; 023226FA
	bl loc_02323BFC	; 023226FC
	bl loc_02323E40	; 02322700
	mov r1,#0x3e	; 02322704
	str r1,[sp,#0x0]	; 02322706
	mov r1,#0x6e	; 02322708
	str r1,[sp,#0x4]	; 0232270A
	ldr r1,[pool_02322790]	; 0232270C
	ldr r2,[pool_02322794]	; 0232270E
	ldr r3,[sp,#0x18]	; 02322710
	lsl r4,r3,#0x2	; 02322712
	ldr r3,[pool_02322798]	; 02322714
	ldr r3,[r3,r4]	; 02322716
	bl loc_02323BFC	; 02322718
	bl loc_02323E40	; 0232271C
	mov r1,#0x5d	; 02322720
	str r1,[sp,#0x0]	; 02322722
	mov r1,#0x6e	; 02322724
	str r1,[sp,#0x4]	; 02322726
	ldr r1,[pool_02322790]	; 02322728
	ldr r2,[pool_02322794]	; 0232272A
	ldr r3,[sp,#0x8]	; 0232272C
	lsl r4,r3,#0x2	; 0232272E
	ldr r3,[pool_02322798]	; 02322730
	ldr r3,[r3,r4]	; 02322732
	bl loc_02323BFC	; 02322734
	bl loc_02323E40	; 02322738
	mov r1,#0x74	; 0232273C
	str r1,[sp,#0x0]	; 0232273E
	mov r1,#0x6e	; 02322740
	str r1,[sp,#0x4]	; 02322742
	ldr r1,[pool_02322790]	; 02322744
	ldr r2,[pool_02322794]	; 02322746
	mov r3,#0x0	; 02322748
	bl loc_02323BFC	; 0232274A
	bl loc_02323E40	; 0232274E
	mov r1,#0x8b	; 02322752
	str r1,[sp,#0x0]	; 02322754
	mov r1,#0x6e	; 02322756
	str r1,[sp,#0x4]	; 02322758
	ldr r1,[pool_02322790]	; 0232275A
	ldr r2,[pool_02322794]	; 0232275C
	ldr r3,[sp,#0x1c]	; 0232275E
	lsl r4,r3,#0x2	; 02322760
	ldr r3,[pool_02322798]	; 02322762
	ldr r3,[r3,r4]	; 02322764
	bl loc_02323BFC	; 02322766
	bl loc_02323E40	; 0232276A
	mov r1,#0xaa	; 0232276E
	str r1,[sp,#0x0]	; 02322770
	mov r1,#0x6e	; 02322772
	str r1,[sp,#0x4]	; 02322774
	ldr r1,[pool_02322790]	; 02322776
	ldr r2,[pool_02322794]	; 02322778
	lsl r4,r6,#0x2	; 0232277A
	ldr r3,[pool_02322798]	; 0232277C
	ldr r3,[r3,r4]	; 0232277E
	bl loc_02323BFC	; 02322780
loc_02322784:
	add sp,#0x44	; 02322784
	pop {r4,r5,r6,r7}	; 02322786
	pop {r3}	; 02322788
	bx r3	; 0232278A
pool_0232278C:
loc_0232278C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsAlarmHourOffset	; 0232278C
pool_02322790:
loc_02322790:
	.word 0x023C11F8	; 02322790
pool_02322794:
loc_02322794:
	.word 0x023A5904	; 02322794
pool_02322798:
loc_02322798:
	.word P1_Data_0233009C	; 02322798

; ===== function loc_0232279C =====
loc_0232279C:
	push {r4,r5,r6,r7,lr}	; 0232279C
	sub sp,#0xc	; 0232279E
	add r5,r0,#0x0	; 023227A0
	add r4,r1,#0x0	; 023227A2
	add r0,sp,#0x0	; 023227A4
	bl loc_02326A48	; 023227A6
	ldr r3,[sp,#0x8]	; 023227AA
	ldr r2,[sp,#0x4]	; 023227AC
	ldr r0,[sp,#0x0]	; 023227AE
	mov r1,#0x3c	; 023227B0
	mul r0,r1	; 023227B2
	add r0,r2,r0	; 023227B4
	mul r0,r1	; 023227B6
	add r0,r3,r0	; 023227B8
	ldr r2,[pool_02322834]	; 023227BA
	ldrb r3,[r2,#0x1]	; 023227BC
	ldrb r2,[r2,#0x0]	; 023227BE
	mul r2,r1	; 023227C0
	add r2,r3,r2	; 023227C2
	mul r2,r1	; 023227C4
	cmp r4,#0x0	; 023227C6
	bne loc_023227DA	; 023227C8
	cmp r0,r2	; 023227CA
	bhi loc_023227D2	; 023227CC
	sub r4,r2,r0	; 023227CE
	b loc_023227E8	; 023227D0
loc_023227D2:
	sub r1,r0,r2	; 023227D2
	ldr r0,[pool_02322838]	; 023227D4
	sub r4,r0,r1	; 023227D6
	b loc_023227E8	; 023227D8
loc_023227DA:
	cmp r2,r0	; 023227DA
	bhi loc_023227E2	; 023227DC
	sub r4,r0,r2	; 023227DE
	b loc_023227E8	; 023227E0
loc_023227E2:
	sub r1,r2,r0	; 023227E2
	ldr r0,[pool_02322838]	; 023227E4
	sub r4,r0,r1	; 023227E6
loc_023227E8:
	add r0,r4,#0x0	; 023227E8
	ldr r1,[pool_0232283C]	; 023227EA
	blx P1_UnsignedDivMod	; 023227EC
	add r6,r0,#0x0	; 023227F0
	ldr r0,[pool_0232283C]	; 023227F2
	add r1,r6,#0x0	; 023227F4
	mul r1,r0	; 023227F6
	sub r4,r4,r1	; 023227F8
	add r0,r4,#0x0	; 023227FA
	mov r1,#0x3c	; 023227FC
	blx P1_UnsignedDivMod	; 023227FE
	add r7,r0,#0x0	; 02322802
	mov r0,#0x3c	; 02322804
	add r1,r7,#0x0	; 02322806
	mul r1,r0	; 02322808
	sub r4,r4,r1	; 0232280A
	add r0,r5,#0x0	; 0232280C
	add r1,r6,#0x0	; 0232280E
	bl loc_02325A20	; 02322810
	mov r1,#0x3a	; 02322814
	strh r1,[r0,#0x0]	; 02322816
	add r0,r0,#0x2	; 02322818
	add r1,r7,#0x0	; 0232281A
	bl loc_02325A20	; 0232281C
	mov r1,#0x3a	; 02322820
	strh r1,[r0,#0x0]	; 02322822
	add r0,r0,#0x2	; 02322824
	add r1,r4,#0x0	; 02322826
	bl loc_02325A20	; 02322828
	add sp,#0xc	; 0232282C
	pop {r4,r5,r6,r7}	; 0232282E
	pop {r3}	; 02322830
	bx r3	; 02322832
pool_02322834:
loc_02322834:
	.word FirmwareUserSettingsSharedAddress + UserSettingsAlarmHourOffset	; 02322834
pool_02322838:
loc_02322838:
	.word 0x00015180	; 02322838
pool_0232283C:
loc_0232283C:
	.word 0x00000E10	; 0232283C

; ===== function loc_02322840 =====
loc_02322840:
	push {r4,r5,lr}	; 02322840
	sub sp,#0x4	; 02322842
	add r5,r0,#0x0	; 02322844
	bl loc_02324C44	; 02322846
	add r4,r0,#0x0	; 0232284A
	mov r1,#0x0	; 0232284C
	str r1,[r5,#0x0]	; 0232284E
	str r1,[r5,#0x4]	; 02322850
	add r1,r5,#0x0	; 02322852
	add r1,#0x8	; 02322854
	ldr r2,[pool_023228B4]	; 02322856
	mov r3,#0x9e	; 02322858
	bl loc_02324BB4	; 0232285A
	add r0,r5,#0x0	; 0232285E
	add r0,#0x8	; 02322860
	ldr r1,[pool_023228B4]	; 02322862
	mov r2,#0x9a	; 02322864
	bl loc_02324B5C	; 02322866
	add r0,r4,#0x0	; 0232286A
	add r1,r5,#0x0	; 0232286C
	add r1,#0x34	; 0232286E
	ldr r2,[pool_023228B4]	; 02322870
	mov r3,#0x9e	; 02322872
	bl loc_02324BB4	; 02322874
	add r0,r5,#0x0	; 02322878
	add r0,#0x34	; 0232287A
	ldr r1,[pool_023228B4]	; 0232287C
	mov r2,#0x9f	; 0232287E
	bl loc_02324B5C	; 02322880
	add r0,r4,#0x0	; 02322884
	add r1,r5,#0x0	; 02322886
	add r1,#0x60	; 02322888
	ldr r2,[pool_023228B4]	; 0232288A
	mov r3,#0x9e	; 0232288C
	bl loc_02324BB4	; 0232288E
	add r0,r4,#0x0	; 02322892
	add r1,r5,#0x0	; 02322894
	add r1,#0x8c	; 02322896
	ldr r2,[pool_023228B4]	; 02322898
	mov r3,#0x9e	; 0232289A
	bl loc_02324BB4	; 0232289C
	add r5,#0x8c	; 023228A0
	add r0,r5,#0x0	; 023228A2
	ldr r1,[pool_023228B4]	; 023228A4
	mov r2,#0x9b	; 023228A6
	bl loc_02324B5C	; 023228A8
	add sp,#0x4	; 023228AC
	pop {r4,r5}	; 023228AE
	pop {r3}	; 023228B0
	bx r3	; 023228B2
pool_023228B4:
loc_023228B4:
	.word 0x023A6538	; 023228B4

; ===== function loc_023228B8 =====
loc_023228B8:
	ldr r1,[pool_023228C0]	; 023228B8
	str r0,[r1,#0x4]	; 023228BA
	bx lr	; 023228BC
	.byte 0xC0, 0x46	; 023228C0
pool_023228C0:
loc_023228C0:
	.word P1_BssStart + 0x1388	; 023228C0

; ===== function loc_023228C4 =====
loc_023228C4:
	push {lr}	; 023228C4
	sub sp,#0x4	; 023228C6
	ldr r0,[pool_0232290C]	; 023228C8
	ldr r0,[r0,#0x0]	; 023228CA
	cmp r0,#0x0	; 023228CC
	beq loc_02322906	; 023228CE
	bl loc_02321E44	; 023228D0
	neg r0,r0	; 023228D4
	lsl r1,r0,#0x10	; 023228D6
	ldr r0,[pool_02322910]	; 023228D8
	and r1,r0	; 023228DA
	ldr r0,[pool_02322914]	; 023228DC
	str r1,[r0,#0x0]	; 023228DE
	bl loc_02321E44	; 023228E0
	neg r0,r0	; 023228E4
	lsl r1,r0,#0x10	; 023228E6
	ldr r0,[pool_02322910]	; 023228E8
	and r1,r0	; 023228EA
	ldr r0,[pool_02322918]	; 023228EC
	str r1,[r0,#0x0]	; 023228EE
	bl loc_02321E44	; 023228F0
	neg r0,r0	; 023228F4
	lsl r1,r0,#0x10	; 023228F6
	ldr r0,[pool_02322910]	; 023228F8
	and r1,r0	; 023228FA
	ldr r0,[pool_0232291C]	; 023228FC
	str r1,[r0,#0x0]	; 023228FE
	ldr r0,[pool_02322920]	; 02322900
	bl loc_023224CC	; 02322902
loc_02322906:
	add sp,#0x4	; 02322906
	pop {r3}	; 02322908
	bx r3	; 0232290A
pool_0232290C:
loc_0232290C:
	.word P1_BssStart + 0x137C	; 0232290C
pool_02322910:
loc_02322910:
	.word 0x01FF0000	; 02322910
pool_02322914:
loc_02322914:
	.word REG_BG1HOFS	; 02322914
pool_02322918:
loc_02322918:
	.word REG_BG2HOFS	; 02322918
pool_0232291C:
loc_0232291C:
	.word REG_BG3HOFS	; 0232291C
pool_02322920:
loc_02322920:
	.word 0x02331E48	; 02322920

; ===== function loc_02322924 =====
P1_Entry_02322924:
	push {lr}	; 02322924
	sub sp,#0x4	; 02322926
	ldr r0,[pool_02322940]	; 02322928
	ldr r0,[r0,#0x0]	; 0232292A
	cmp r0,#0x0	; 0232292C
	beq loc_02322938	; 0232292E
	bl loc_02323098	; 02322930
	bl loc_02322168	; 02322934
loc_02322938:
	add sp,#0x4	; 02322938
	pop {r3}	; 0232293A
	bx r3	; 0232293C
	.byte 0xC0, 0x46	; 02322940
pool_02322940:
loc_02322940:
	.word P1_BssStart + 0x137C	; 02322940

; ===== function loc_02322944 =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02322944:
loc_02322944:
	push {lr}	; 02322944
	sub sp,#0x4	; 02322946
	ldr r0,[pool_023229AC]	; 02322948
	ldr r0,[r0,#0x0]	; 0232294A
	cmp r0,#0x0	; 0232294C
	beq loc_023229A6	; 0232294E
	ldr r0,[pool_023229B0]	; 02322950
	ldr r1,[r0,#0x0]	; 02322952
	cmp r1,#0x10	; 02322954
	bge loc_02322984	; 02322956
	add r1,r1,#0x1	; 02322958
	str r1,[r0,#0x0]	; 0232295A
	lsl r0,r1,#0x4	; 0232295C
	mov r1,#0x10	; 0232295E
	blx P1_SignedDivMod	; 02322960
	add r3,r0,#0x0	; 02322964
	ldr r0,[pool_023229B4]	; 02322966
	mov r1,#0x1f	; 02322968
	mov r2,#0x10	; 0232296A
	sub r2,r2,r3	; 0232296C
	bl loc_0232D93C	; 0232296E
	ldr r0,[pool_023229B0]	; 02322972
	ldr r0,[r0,#0x0]	; 02322974
	cmp r0,#0x10	; 02322976
	bne loc_02322984	; 02322978
	mov r1,#0x0	; 0232297A
	ldr r0,[pool_023229B4]	; 0232297C
	strh r1,[r0,#0x0]	; 0232297E
	bl loc_0232331C	; 02322980
loc_02322984:
	ldr r0,[pool_023229B8]	; 02322984
	bl loc_02322548	; 02322986
	bl loc_02322498	; 0232298A
	cmp r0,#0x0	; 0232298E
	bne loc_023229A6	; 02322990
	bl loc_023232F8	; 02322992
	bl loc_023233EC	; 02322996
	bl loc_023221CC	; 0232299A
	bl loc_02323088	; 0232299E
	bl loc_02322A40	; 023229A2
loc_023229A6:
	add sp,#0x4	; 023229A6
	pop {r3}	; 023229A8
	bx r3	; 023229AA
pool_023229AC:
loc_023229AC:
	.word P1_BssStart + 0x137C	; 023229AC
pool_023229B0:
loc_023229B0:
	.word P1_BssStart + 0x1374	; 023229B0
pool_023229B4:
loc_023229B4:
	.word REG_BLDCNT	; 023229B4
pool_023229B8:
loc_023229B8:
	.word 0x02331E48	; 023229B8

; ===== function loc_023229BC =====
loc_023229BC:
	ldr r0,[pool_023229C4]	; 023229BC
	ldr r0,[r0,#0x0]	; 023229BE
	bx lr	; 023229C0
	.byte 0xC0, 0x46	; 023229C4
pool_023229C4:
loc_023229C4:
	.word P1_BssStart + 0x1444	; 023229C4

; ===== function loc_023229C8 =====
loc_023229C8:
	ldr r3,[pool_023229CC]	; 023229C8
	bx r3	; 023229CA
pool_023229CC:
loc_023229CC:
	.word loc_023220F0 + 1	; 023229CC

; ===== function loc_023229D0 =====
loc_023229D0:
	push {lr}	; 023229D0
	sub sp,#0x4	; 023229D2
	cmp r0,#0x0	; 023229D4
	beq loc_023229DC	; 023229D6
	mov r2,#0x1	; 023229D8
	b loc_023229DE	; 023229DA
loc_023229DC:
	mov r2,#0x4	; 023229DC
loc_023229DE:
	ldr r1,[pool_02322A04]	; 023229DE
	str r2,[r1,#0x0]	; 023229E0
	cmp r0,#0x0	; 023229E2
	beq loc_023229FE	; 023229E4
	mov r0,#0x0	; 023229E6
	str r0,[r1,#0x4]	; 023229E8
	ldr r0,[pool_02322A08]	; 023229EA
	ldr r1,[pool_02322A0C]	; 023229EC
	mov r2,#0x9a	; 023229EE
	bl loc_02324B5C	; 023229F0
	ldr r0,[pool_02322A10]	; 023229F4
	ldr r1,[pool_02322A0C]	; 023229F6
	mov r2,#0x9f	; 023229F8
	bl loc_02324B5C	; 023229FA
loc_023229FE:
	add sp,#0x4	; 023229FE
	pop {r3}	; 02322A00
	bx r3	; 02322A02
pool_02322A04:
loc_02322A04:
	.word P1_BssStart + 0x1388	; 02322A04
pool_02322A08:
loc_02322A08:
	.word 0x02331E50	; 02322A08
pool_02322A0C:
loc_02322A0C:
	.word 0x023A6538	; 02322A0C
pool_02322A10:
loc_02322A10:
	.word 0x02331E7C	; 02322A10
; P3 使用的 Thumb 尾调用入口。 / Thumb tail-call veneer used by P3.
.func P1_Function_02322A14
	ldr r3,[pool_02322A18]	; 02322A14
	bx r3	; 02322A16
.endfunc
pool_02322A18:
	.word P1_Entry_023223E8 + 1	; 02322A18

; ===== function loc_02322A1C =====
loc_02322A1C:
	push {lr}	; 02322A1C
	sub sp,#0x4	; 02322A1E
	ldr r0,[pool_02322A38]	; 02322A20
	mov r1,#0x0	; 02322A22
	ldr r2,[pool_02322A3C]	; 02322A24
	sub r2,r2,r0	; 02322A26
	bl loc_0232DCC0	; 02322A28
	bl loc_02321DFC	; 02322A2C
	add sp,#0x4	; 02322A30
	pop {r3}	; 02322A32
	bx r3	; 02322A34
	.byte 0xC0, 0x46	; 02322A38
pool_02322A38:
loc_02322A38:
	.word 0x023BC840	; 02322A38
pool_02322A3C:
loc_02322A3C:
	.word 0x023BCA40	; 02322A3C

; ===== function loc_02322A40 =====
loc_02322A40:
	push {r4,r5,lr}	; 02322A40
	sub sp,#0x4c	; 02322A42
	add r0,sp,#0x40	; 02322A44
	bl loc_02326A48	; 02322A46
	ldr r0,[sp,#0x44]	; 02322A4A
	cmp r0,#0x0	; 02322A4C
	bne loc_02322A60	; 02322A4E
	ldr r0,[pool_02322C3C]	; 02322A50
	ldr r0,[r0,#0x4]	; 02322A52
	cmp r0,#0x0	; 02322A54
	beq loc_02322A60	; 02322A56
	mov r0,#0x2b	; 02322A58
	bl loc_023236E0	; 02322A5A
	b loc_02322A84	; 02322A5E
loc_02322A60:
	ldr r1,[sp,#0x48]	; 02322A60
	cmp r1,#0x0	; 02322A62
	bne loc_02322A76	; 02322A64
	ldr r0,[pool_02322C3C]	; 02322A66
	ldr r0,[r0,#0x8]	; 02322A68
	cmp r0,#0x0	; 02322A6A
	beq loc_02322A76	; 02322A6C
	mov r0,#0x29	; 02322A6E
	bl loc_023236E0	; 02322A70
	b loc_02322A84	; 02322A74
loc_02322A76:
	ldr r0,[pool_02322C3C]	; 02322A76
	ldr r0,[r0,#0x8]	; 02322A78
	cmp r1,r0	; 02322A7A
	beq loc_02322A84	; 02322A7C
	mov r0,#0x2a	; 02322A7E
	bl loc_023236E0	; 02322A80
loc_02322A84:
	add r3,sp,#0x40	; 02322A84
	ldr r2,[pool_02322C3C]	; 02322A86
	ldmia r3!,{r0,r1}	; 02322A88
	stmia r2!,{r0,r1}	; 02322A8A
	ldr r0,[r3,#0x0]	; 02322A8C
	str r0,[r2,#0x0]	; 02322A8E
	ldr r0,[sp,#0x44]	; 02322A90
	mov r1,#0xc	; 02322A92
	blx P1_UnsignedDivMod	; 02322A94
	add r4,r0,#0x0	; 02322A98
	ldr r0,[sp,#0x40]	; 02322A9A
	mov r1,#0xc	; 02322A9C
	blx P1_UnsignedDivMod	; 02322A9E
	mov r0,#0x5	; 02322AA2
	mul r1,r0	; 02322AA4
	add r5,r4,r1	; 02322AA6
	bl loc_02323E40	; 02322AA8
	add r4,r0,#0x0	; 02322AAC
	bl loc_02321E44	; 02322AAE
	mov r1,#0x0	; 02322AB2
	str r1,[sp,#0x0]	; 02322AB4
	str r0,[sp,#0x4]	; 02322AB6
	add r0,r4,#0x0	; 02322AB8
	ldr r1,[pool_02322C40]	; 02322ABA
	ldr r2,[pool_02322C44]	; 02322ABC
	mov r3,#0xd	; 02322ABE
	bl loc_02323BFC	; 02322AC0
	ldr r0,[pool_02322C48]	; 02322AC4
	bl P1_ComputeFixedPointReciprocal	; 02322AC6
	add r4,r0,#0x0	; 02322ACA
	ldr r0,[pool_02322C4C]	; 02322ACC
	bl P1_ComputeFixedPointReciprocal	; 02322ACE
	add r1,r0,#0x0	; 02322AD2
	add r0,sp,#0x20	; 02322AD4
	add r2,r4,#0x0	; 02322AD6
	bl loc_0232D208	; 02322AD8
	ldr r0,[sp,#0x48]	; 02322ADC
	lsl r3,r0,#0x1	; 02322ADE
	add r0,sp,#0x10	; 02322AE0
	ldr r1,[pool_02322C50]	; 02322AE2
	ldrsh r1,[r1,r3]	; 02322AE4
	ldr r2,[pool_02322C54]	; 02322AE6
	ldrsh r2,[r2,r3]	; 02322AE8
	bl loc_0232D214	; 02322AEA
	add r0,sp,#0x20	; 02322AEE
	add r1,sp,#0x10	; 02322AF0
	add r2,sp,#0x30	; 02322AF2
	bl loc_0232D220	; 02322AF4
	bl loc_02321E44	; 02322AF8
	add r0,#0x20	; 02322AFC
	mov r1,#0xff	; 02322AFE
	and r0,r1	; 02322B00
	ldr r1,[pool_02322C58]	; 02322B02
	orr r0,r1	; 02322B04
	str r0,[sp,#0x8]	; 02322B06
	ldr r1,[pool_02322C5C]	; 02322B08
	add r0,sp,#0x8	; 02322B0A
	strh r1,[r0,#0x4]	; 02322B0C
	bl loc_02323E40	; 02322B0E
	add r1,sp,#0x8	; 02322B12
	add r2,sp,#0x30	; 02322B14
	bl loc_0232395C	; 02322B16
	ldr r0,[pool_02322C60]	; 02322B1A
	bl P1_ComputeFixedPointReciprocal	; 02322B1C
	add r4,r0,#0x0	; 02322B20
	ldr r0,[pool_02322C4C]	; 02322B22
	bl P1_ComputeFixedPointReciprocal	; 02322B24
	add r1,r0,#0x0	; 02322B28
	add r0,sp,#0x20	; 02322B2A
	add r2,r4,#0x0	; 02322B2C
	bl loc_0232D208	; 02322B2E
	ldr r0,[sp,#0x44]	; 02322B32
	lsl r3,r0,#0x1	; 02322B34
	add r0,sp,#0x10	; 02322B36
	ldr r1,[pool_02322C50]	; 02322B38
	ldrsh r1,[r1,r3]	; 02322B3A
	ldr r2,[pool_02322C54]	; 02322B3C
	ldrsh r2,[r2,r3]	; 02322B3E
	bl loc_0232D214	; 02322B40
	add r0,sp,#0x20	; 02322B44
	add r1,sp,#0x10	; 02322B46
	add r2,sp,#0x30	; 02322B48
	bl loc_0232D220	; 02322B4A
	bl loc_02321E44	; 02322B4E
	add r0,#0x20	; 02322B52
	mov r1,#0xff	; 02322B54
	and r0,r1	; 02322B56
	ldr r1,[pool_02322C58]	; 02322B58
	orr r0,r1	; 02322B5A
	str r0,[sp,#0x8]	; 02322B5C
	ldr r1,[pool_02322C64]	; 02322B5E
	add r0,sp,#0x8	; 02322B60
	strh r1,[r0,#0x4]	; 02322B62
	bl loc_02323E40	; 02322B64
	add r1,sp,#0x8	; 02322B68
	add r2,sp,#0x30	; 02322B6A
	bl loc_0232395C	; 02322B6C
	ldr r0,[pool_02322C68]	; 02322B70
	bl P1_ComputeFixedPointReciprocal	; 02322B72
	add r4,r0,#0x0	; 02322B76
	ldr r0,[pool_02322C4C]	; 02322B78
	bl P1_ComputeFixedPointReciprocal	; 02322B7A
	add r1,r0,#0x0	; 02322B7E
	add r0,sp,#0x20	; 02322B80
	add r2,r4,#0x0	; 02322B82
	bl loc_0232D208	; 02322B84
	lsl r3,r5,#0x1	; 02322B88
	add r0,sp,#0x10	; 02322B8A
	ldr r1,[pool_02322C50]	; 02322B8C
	ldrsh r1,[r1,r3]	; 02322B8E
	ldr r2,[pool_02322C54]	; 02322B90
	ldrsh r2,[r2,r3]	; 02322B92
	bl loc_0232D214	; 02322B94
	add r0,sp,#0x20	; 02322B98
	add r1,sp,#0x10	; 02322B9A
	add r2,sp,#0x30	; 02322B9C
	bl loc_0232D220	; 02322B9E
	bl loc_02321E44	; 02322BA2
	add r0,#0x20	; 02322BA6
	mov r1,#0xff	; 02322BA8
	and r0,r1	; 02322BAA
	ldr r1,[pool_02322C58]	; 02322BAC
	orr r0,r1	; 02322BAE
	str r0,[sp,#0x8]	; 02322BB0
	ldr r1,[pool_02322C64]	; 02322BB2
	add r0,sp,#0x8	; 02322BB4
	strh r1,[r0,#0x4]	; 02322BB6
	bl loc_02323E40	; 02322BB8
	add r1,sp,#0x8	; 02322BBC
	add r2,sp,#0x30	; 02322BBE
	bl loc_0232395C	; 02322BC0
	ldr r0,[pool_02322C6C]	; 02322BC4
	ldrb r0,[r0,#0x1]	; 02322BC6
	mov r1,#0xc	; 02322BC8
	blx P1_SignedDivMod	; 02322BCA
	add r4,r0,#0x0	; 02322BCE
	ldr r0,[pool_02322C6C]	; 02322BD0
	ldrb r0,[r0,#0x0]	; 02322BD2
	mov r1,#0xc	; 02322BD4
	blx P1_SignedDivMod	; 02322BD6
	mov r0,#0x5	; 02322BDA
	mul r1,r0	; 02322BDC
	add r5,r4,r1	; 02322BDE
	ldr r0,[pool_02322C70]	; 02322BE0
	bl P1_ComputeFixedPointReciprocal	; 02322BE2
	add r4,r0,#0x0	; 02322BE6
	ldr r0,[pool_02322C4C]	; 02322BE8
	bl P1_ComputeFixedPointReciprocal	; 02322BEA
	add r1,r0,#0x0	; 02322BEE
	add r0,sp,#0x20	; 02322BF0
	add r2,r4,#0x0	; 02322BF2
	bl loc_0232D208	; 02322BF4
	lsl r3,r5,#0x1	; 02322BF8
	add r0,sp,#0x10	; 02322BFA
	ldr r1,[pool_02322C50]	; 02322BFC
	ldrsh r1,[r1,r3]	; 02322BFE
	ldr r2,[pool_02322C54]	; 02322C00
	ldrsh r2,[r2,r3]	; 02322C02
	bl loc_0232D214	; 02322C04
	add r0,sp,#0x20	; 02322C08
	add r1,sp,#0x10	; 02322C0A
	add r2,sp,#0x30	; 02322C0C
	bl loc_0232D220	; 02322C0E
	bl loc_02321E44	; 02322C12
	add r0,#0x20	; 02322C16
	mov r1,#0xff	; 02322C18
	and r0,r1	; 02322C1A
	ldr r1,[pool_02322C58]	; 02322C1C
	orr r0,r1	; 02322C1E
	str r0,[sp,#0x8]	; 02322C20
	ldr r1,[pool_02322C74]	; 02322C22
	add r0,sp,#0x8	; 02322C24
	strh r1,[r0,#0x4]	; 02322C26
	bl loc_02323E40	; 02322C28
	add r1,sp,#0x8	; 02322C2C
	add r2,sp,#0x30	; 02322C2E
	bl loc_0232395C	; 02322C30
	add sp,#0x4c	; 02322C34
	pop {r4,r5}	; 02322C36
	pop {r3}	; 02322C38
	bx r3	; 02322C3A
pool_02322C3C:
loc_02322C3C:
	.word P1_BssStart + 0x1558	; 02322C3C
pool_02322C40:
loc_02322C40:
	.word 0x023C11F8	; 02322C40
pool_02322C44:
loc_02322C44:
	.word 0x023A588C	; 02322C44
pool_02322C48:
loc_02322C48:
	.word 0x00009000	; 02322C48
pool_02322C4C:
loc_02322C4C:
	.word 0x00001000	; 02322C4C
pool_02322C50:
loc_02322C50:
	.word P1_Data_023305E0	; 02322C50
pool_02322C54:
loc_02322C54:
	.word P1_Data_02330658	; 02322C54
pool_02322C58:
loc_02322C58:
	.word 0xC0000300	; 02322C58
pool_02322C5C:
loc_02322C5C:
	.word 0x0000F3F0	; 02322C5C
pool_02322C60:
loc_02322C60:
	.word 0x00008000	; 02322C60
pool_02322C64:
loc_02322C64:
	.word 0x000023F0	; 02322C64
pool_02322C68:
loc_02322C68:
	.word 0x00006000	; 02322C68
pool_02322C6C:
loc_02322C6C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsAlarmHourOffset	; 02322C6C
pool_02322C70:
loc_02322C70:
	.word 0x00004000	; 02322C70
pool_02322C74:
loc_02322C74:
	.word 0x000053E0	; 02322C74

; ===== function loc_02322C78 =====
loc_02322C78:
	push {lr}	; 02322C78
	sub sp,#0x1c	; 02322C7A
	mov r0,#0x0	; 02322C7C
	str r0,[sp,#0x0]	; 02322C7E
	str r0,[sp,#0x4]	; 02322C80
	add r0,sp,#0x8	; 02322C82
	ldr r2,[pool_02322D04]	; 02322C84
	ldr r1,[pool_02322D08]	; 02322C86
	add r1,r2,r1	; 02322C88
	mov r2,#0x40	; 02322C8A
	add r3,r2,#0x0	; 02322C8C
	bl loc_02329018	; 02322C8E
	mov r0,#0x1c	; 02322C92
	str r0,[sp,#0x0]	; 02322C94
	mov r0,#0x7	; 02322C96
	str r0,[sp,#0x4]	; 02322C98
	add r0,sp,#0x8	; 02322C9A
	mov r1,#0x1f	; 02322C9C
	mov r2,#0x20	; 02322C9E
	add r3,r1,#0x0	; 02322CA0
	bl loc_02324414	; 02322CA2
	mov r0,#0x1c	; 02322CA6
	str r0,[sp,#0x0]	; 02322CA8
	mov r0,#0x7	; 02322CAA
	str r0,[sp,#0x4]	; 02322CAC
	add r0,sp,#0x8	; 02322CAE
	mov r1,#0x20	; 02322CB0
	add r2,r1,#0x0	; 02322CB2
	add r3,r1,#0x0	; 02322CB4
	bl loc_02324414	; 02322CB6
	mov r0,#0x0	; 02322CBA
	str r0,[sp,#0x0]	; 02322CBC
	str r0,[sp,#0x4]	; 02322CBE
	add r0,sp,#0x8	; 02322CC0
	ldr r2,[pool_02322D04]	; 02322CC2
	ldr r1,[pool_02322D0C]	; 02322CC4
	add r1,r2,r1	; 02322CC6
	mov r2,#0x40	; 02322CC8
	add r3,r2,#0x0	; 02322CCA
	bl loc_02329018	; 02322CCC
	mov r0,#0x1c	; 02322CD0
	str r0,[sp,#0x0]	; 02322CD2
	mov r0,#0x8	; 02322CD4
	str r0,[sp,#0x4]	; 02322CD6
	add r0,sp,#0x8	; 02322CD8
	mov r1,#0x1f	; 02322CDA
	mov r2,#0x20	; 02322CDC
	add r3,r1,#0x0	; 02322CDE
	bl loc_02324414	; 02322CE0
	mov r0,#0x1c	; 02322CE4
	str r0,[sp,#0x0]	; 02322CE6
	mov r0,#0x8	; 02322CE8
	str r0,[sp,#0x4]	; 02322CEA
	add r0,sp,#0x8	; 02322CEC
	mov r1,#0x20	; 02322CEE
	add r2,r1,#0x0	; 02322CF0
	add r3,r1,#0x0	; 02322CF2
	bl loc_02324414	; 02322CF4
	ldr r0,[pool_02322D10]	; 02322CF8
	bl loc_02326A48	; 02322CFA
	add sp,#0x1c	; 02322CFE
	pop {r3}	; 02322D00
	bx r3	; 02322D02
pool_02322D04:
loc_02322D04:
	.word 0x06400000	; 02322D04
pool_02322D08:
loc_02322D08:
	.word 0x0001F000	; 02322D08
pool_02322D0C:
loc_02322D0C:
	.word 0x0001F800	; 02322D0C
pool_02322D10:
loc_02322D10:
	.word 0x02332018	; 02322D10
loc_02322D14:
	push {r4,r5,lr}	; 02322D14
	sub sp,#0x1c	; 02322D16
	add r5,r0,#0x0	; 02322D18
	add r0,sp,#0xc	; 02322D1A
	bl loc_02326A2C	; 02322D1C
	ldr r1,[sp,#0x14]	; 02322D20
	ldr r0,[r5,#0x0]	; 02322D22
	cmp r1,r0	; 02322D24
	bne loc_02322D38	; 02322D26
	ldr r1,[sp,#0x10]	; 02322D28
	ldr r0,[r5,#0x4]	; 02322D2A
	cmp r1,r0	; 02322D2C
	bne loc_02322D38	; 02322D2E
	ldr r1,[sp,#0xc]	; 02322D30
	ldr r0,[r5,#0x8]	; 02322D32
	cmp r1,r0	; 02322D34
	beq loc_02322D3E	; 02322D36
loc_02322D38:
	add r0,r5,#0x0	; 02322D38
	bl loc_02322E08	; 02322D3A
loc_02322D3E:
	bl loc_02323E40	; 02322D3E
	add r4,r0,#0x0	; 02322D42
	bl loc_02321E44	; 02322D44
	ldrh r1,[r5,#0xc]	; 02322D48
	str r1,[sp,#0x0]	; 02322D4A
	ldrh r1,[r5,#0xe]	; 02322D4C
	add r0,r1,r0	; 02322D4E
	str r0,[sp,#0x4]	; 02322D50
	mov r0,#0x1	; 02322D52
	str r0,[sp,#0x8]	; 02322D54
	add r0,r4,#0x0	; 02322D56
	ldr r1,[pool_02322D6C]	; 02322D58
	ldr r2,[pool_02322D70]	; 02322D5A
	mov r3,#0x0	; 02322D5C
	bl loc_02323AA8	; 02322D5E
	add sp,#0x1c	; 02322D62
	pop {r4,r5}	; 02322D64
	pop {r3}	; 02322D66
	bx r3	; 02322D68
	.byte 0xC0, 0x46	; 02322D6C
pool_02322D6C:
loc_02322D6C:
	.word 0x023C11F8	; 02322D6C
pool_02322D70:
loc_02322D70:
	.word 0x023A588C	; 02322D70

; ===== function loc_02322D74 =====
loc_02322D74:
	push {r4,r5,r6,r7,lr}	; 02322D74
	sub sp,#0x4	; 02322D76
	add r4,r0,#0x0	; 02322D78
	blx P1_GetMainBg2TilemapAddress	; 02322D7A
	add r7,r0,#0x0	; 02322D7E
	cmp r4,#0x0	; 02322D80
	beq loc_02322D88	; 02322D82
	mov r6,#0xf	; 02322D84
	b loc_02322D8A	; 02322D86
loc_02322D88:
	mov r6,#0x11	; 02322D88
loc_02322D8A:
	mov r4,#0x0	; 02322D8A
	str r4,[sp,#0x0]	; 02322D8C
loc_02322D8E:
	ldr r5,[sp,#0x0]	; 02322D8E
	add r0,r6,r4	; 02322D90
	lsl r1,r0,#0x6	; 02322D92
	ldr r0,[pool_02322DC0]	; 02322D94
	add r3,r0,r1	; 02322D96
	add r0,r4,#0x0	; 02322D98
	add r0,#0x11	; 02322D9A
	lsl r0,r0,#0x6	; 02322D9C
	add r2,r7,r0	; 02322D9E
loc_02322DA0:
	add r0,r5,#0x0	; 02322DA0
	add r0,#0xf	; 02322DA2
	lsl r1,r0,#0x1	; 02322DA4
	ldrh r0,[r3,r1]	; 02322DA6
	strh r0,[r2,r1]	; 02322DA8
	add r5,r5,#0x1	; 02322DAA
	cmp r5,#0x10	; 02322DAC
	blt loc_02322DA0	; 02322DAE
	add r4,r4,#0x1	; 02322DB0
	cmp r4,#0x4	; 02322DB2
	blt loc_02322D8E	; 02322DB4
	add sp,#0x4	; 02322DB6
	pop {r4,r5,r6,r7}	; 02322DB8
	pop {r3}	; 02322DBA
	bx r3	; 02322DBC
	.byte 0xC0, 0x46	; 02322DC0
pool_02322DC0:
loc_02322DC0:
	.word 0x023B8640	; 02322DC0

; ===== function loc_02322DC4 =====
loc_02322DC4:
	push {r4,r5,r6,r7,lr}	; 02322DC4
	sub sp,#0x4	; 02322DC6
	add r4,r0,#0x0	; 02322DC8
	add r7,r1,#0x0	; 02322DCA
	add r5,r2,#0x0	; 02322DCC
	ldr r0,[pool_02322E04]	; 02322DCE
	add r0,r4,r0	; 02322DD0
	mov r2,#0x1	; 02322DD2
	bl loc_02326AA8	; 02322DD4
	add r6,r0,#0x0	; 02322DD8
	add r0,r4,#0x0	; 02322DDA
	add r1,r7,#0x0	; 02322DDC
	mov r2,#0x0	; 02322DDE
	bl loc_02326B0C	; 02322DE0
	add r4,r0,#0x0	; 02322DE4
	add r0,r6,#0x7	; 02322DE6
	sub r0,r0,r5	; 02322DE8
	mov r1,#0x7	; 02322DEA
	blx P1_SignedDivMod	; 02322DEC
	add r0,r1,r4	; 02322DF0
	cmp r0,#0x23	; 02322DF2
	ble loc_02322DFA	; 02322DF4
	mov r0,#0x1	; 02322DF6
	b loc_02322DFC	; 02322DF8
loc_02322DFA:
	mov r0,#0x0	; 02322DFA
loc_02322DFC:
	add sp,#0x4	; 02322DFC
	pop {r4,r5,r6,r7}	; 02322DFE
	pop {r3}	; 02322E00
	bx r3	; 02322E02
pool_02322E04:
loc_02322E04:
	.word 0x000007D0	; 02322E04

; ===== function loc_02322E08 =====
loc_02322E08:
	push {r4,r5,r6,r7,lr}	; 02322E08
	sub sp,#0xb4	; 02322E0A
	add r4,r0,#0x0	; 02322E0C
	ldr r5,[pool_02323058]	; 02322E0E
	add r3,sp,#0x58	; 02322E10
	mov r2,#0x3	; 02322E12
loc_02322E14:
	ldmia r5!,{r0,r1}	; 02322E14
	stmia r3!,{r0,r1}	; 02322E16
	sub r2,r2,#0x1	; 02322E18
	cmp r2,#0x0	; 02322E1A
	bne loc_02322E14	; 02322E1C
	ldr r0,[r5,#0x0]	; 02322E1E
	str r0,[r3,#0x0]	; 02322E20
	ldr r5,[pool_0232305C]	; 02322E22
	add r3,sp,#0x74	; 02322E24
	mov r2,#0x3	; 02322E26
loc_02322E28:
	ldmia r5!,{r0,r1}	; 02322E28
	stmia r3!,{r0,r1}	; 02322E2A
	sub r2,r2,#0x1	; 02322E2C
	cmp r2,#0x0	; 02322E2E
	bne loc_02322E28	; 02322E30
	ldr r0,[r5,#0x0]	; 02322E32
	str r0,[r3,#0x0]	; 02322E34
	add r0,sp,#0x48	; 02322E36
	bl loc_02326A2C	; 02322E38
	ldr r0,[sp,#0x48]	; 02322E3C
	str r0,[r4,#0x8]	; 02322E3E
	ldr r0,[sp,#0x4c]	; 02322E40
	str r0,[r4,#0x4]	; 02322E42
	ldr r0,[sp,#0x50]	; 02322E44
	str r0,[r4,#0x0]	; 02322E46
	bl P1_GetMainBg1CharacterBase	; 02322E48
	add r1,r0,#0x0	; 02322E4C
	mov r0,#0x0	; 02322E4E
	str r0,[sp,#0x34]	; 02322E50
	ldr r0,[sp,#0x34]	; 02322E52
	ldr r2,[pool_02323060]	; 02322E54
	blx loc_0232DE68	; 02322E56
	bl P1_GetMainBg1CharacterBase	; 02322E5A
	add r5,r0,#0x0	; 02322E5E
	bl loc_02324C68	; 02322E60
	mov r1,#0x0	; 02322E64
	str r1,[sp,#0x0]	; 02322E66
	str r0,[sp,#0x4]	; 02322E68
	add r0,sp,#0x38	; 02322E6A
	add r1,r5,#0x0	; 02322E6C
	ldr r2,[pool_02323064]	; 02322E6E
	mov r3,#0xc0	; 02322E70
	bl loc_02329018	; 02322E72
	add r0,sp,#0x24	; 02322E76
	ldr r1,[sp,#0x48]	; 02322E78
	bl loc_02325A20	; 02322E7A
	add r0,sp,#0x2c	; 02322E7E
	ldr r1,[sp,#0x4c]	; 02322E80
	bl loc_02325A20	; 02322E82
	ldr r0,[pool_02323068]	; 02322E86
	ldrh r0,[r0,#0x0]	; 02322E88
	lsl r0,r0,#0x1d	; 02322E8A
	lsr r0,r0,#0x1d	; 02322E8C
	cmp r0,#0x5	; 02322E8E
	bhi loc_02322EAC	; 02322E90
	add r0,r0,r0	; 02322E92
P1_SwitchIndexPC_02322E92:
	add r0,pc	; 02322E94
	ldrh r0,[r0,#(P1_SwitchTable_02322E92 - (P1_SwitchIndexPC_02322E92 + 4))]	; 02322E96
	lsl r0,r0,#0x10	; 02322E98
	asr r0,r0,#0x10	; 02322E9A
P1_SwitchTargetPC_02322E92:
	add r0,pc	; 02322E9C
	bx r0	; 02322E9E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02322E92:
	.halfword (loc_02322EAC + 1) - (P1_SwitchTargetPC_02322E92 + 4)
	.halfword (loc_02322EC0 + 1) - (P1_SwitchTargetPC_02322E92 + 4)
	.halfword (loc_02322EC0 + 1) - (P1_SwitchTargetPC_02322E92 + 4)
	.halfword (loc_02322EB6 + 1) - (P1_SwitchTargetPC_02322E92 + 4)
	.halfword (loc_02322EC0 + 1) - (P1_SwitchTargetPC_02322E92 + 4)
	.halfword (loc_02322EC0 + 1) - (P1_SwitchTargetPC_02322E92 + 4)
P1_SwitchTable_02322E92End:
loc_02322EAC:
	add r0,sp,#0x90	; 02322EAC
	ldr r1,[pool_0232306C]	; 02322EAE
	bl P1_Utf16StrCpy	; 02322EB0
	b loc_02322EC8	; 02322EB4
loc_02322EB6:
	add r0,sp,#0x90	; 02322EB6
	ldr r1,[pool_02323070]	; 02322EB8
	bl P1_Utf16StrCpy	; 02322EBA
	b loc_02322EC8	; 02322EBE
loc_02322EC0:
	add r0,sp,#0x90	; 02322EC0
	ldr r1,[pool_02323074]	; 02322EC2
	bl P1_Utf16StrCpy	; 02322EC4
loc_02322EC8:
	add r0,sp,#0x90	; 02322EC8
	mov r1,#0x59	; 02322ECA
	bl P1_Utf16StrChr	; 02322ECC
	add r1,sp,#0x24	; 02322ED0
	mov r2,#0x2	; 02322ED2
	bl P1_Utf16StrNCpy	; 02322ED4
	add r0,sp,#0x90	; 02322ED8
	mov r1,#0x4d	; 02322EDA
	bl P1_Utf16StrChr	; 02322EDC
	add r1,sp,#0x2c	; 02322EE0
	mov r2,#0x2	; 02322EE2
	bl P1_Utf16StrNCpy	; 02322EE4
	ldr r0,[pool_02323078]	; 02322EE8
	mov r1,#0x0	; 02322EEA
	bl loc_02329188	; 02322EEC
	add r1,r0,#0x0	; 02322EF0
	add r0,sp,#0x38	; 02322EF2
	add r2,sp,#0x90	; 02322EF4
	bl loc_02329108	; 02322EF6
	mov r5,#0x0	; 02322EFA
	b loc_02322F46	; 02322EFC
loc_02322EFE:
	ldr r0,[pool_02323078]	; 02322EFE
	add r1,r5,#0x1	; 02322F00
	bl loc_02329188	; 02322F02
	add r6,r0,#0x0	; 02322F06
	bl loc_02324C58	; 02322F08
	add r7,r0,#0x0	; 02322F0C
	lsl r1,r5,#0x2	; 02322F0E
	add r0,sp,#0x58	; 02322F10
	ldr r0,[r0,r1]	; 02322F12
	bl loc_02324D9C	; 02322F14
	mov r1,#0x4	; 02322F18
	ldrsb r1,[r6,r1]	; 02322F1A
	str r1,[sp,#0x0]	; 02322F1C
	mov r1,#0x5	; 02322F1E
	ldrsb r1,[r6,r1]	; 02322F20
	str r1,[sp,#0x4]	; 02322F22
	str r0,[sp,#0x8]	; 02322F24
	ldrb r0,[r6,#0x6]	; 02322F26
	str r0,[sp,#0xc]	; 02322F28
	add r0,r7,#0x0	; 02322F2A
	add r1,sp,#0x38	; 02322F2C
	mov r7,sp	; 02322F2E
	sub r7,r7,#0x4	; 02322F30
	ldrh r2,[r6,#0x0]	; 02322F32
	strh r2,[r7,#0x0]	; 02322F34
	add r3,r7,#0x0	; 02322F36
	ldmia r3!,{r2}	; 02322F38
	ldrh r3,[r6,#0x2]	; 02322F3A
	strh r3,[r7,#0x0]	; 02322F3C
	ldmia r7!,{r3}	; 02322F3E
	bl loc_02328CB8	; 02322F40
	add r5,r5,#0x1	; 02322F44
loc_02322F46:
	cmp r5,#0x7	; 02322F46
	bcc loc_02322EFE	; 02322F48
	ldr r0,[pool_02323078]	; 02322F4A
	mov r1,#0x1	; 02322F4C
	bl loc_02329188	; 02322F4E
	ldrh r1,[r0,#0x0]	; 02322F52
	add r0,sp,#0x20	; 02322F54
	strh r1,[r0,#0x2]	; 02322F56
	ldrh r1,[r0,#0x2]	; 02322F58
	strh r1,[r0,#0x0]	; 02322F5A
	mov r5,#0x0	; 02322F5C
	ldr r1,[sp,#0x48]	; 02322F5E
	ldr r0,[pool_0232307C]	; 02322F60
	add r0,r1,r0	; 02322F62
	ldr r1,[sp,#0x4c]	; 02322F64
	mov r2,#0x1	; 02322F66
	bl loc_02326AA8	; 02322F68
	add r0,r0,#0x7	; 02322F6C
	sub r0,r0,r5	; 02322F6E
	mov r1,#0x7	; 02322F70
	blx P1_SignedDivMod	; 02322F72
	add r7,r1,#0x0	; 02322F76
	ldr r0,[r4,#0x0]	; 02322F78
	add r0,r7,r0	; 02322F7A
	sub r0,r0,#0x1	; 02322F7C
	mov r1,#0x7	; 02322F7E
	blx P1_SignedDivMod	; 02322F80
	lsl r0,r1,#0x4	; 02322F84
	strh r0,[r4,#0xc]	; 02322F86
	ldr r0,[r4,#0x0]	; 02322F88
	add r0,r7,r0	; 02322F8A
	sub r0,r0,#0x1	; 02322F8C
	mov r1,#0x7	; 02322F8E
	blx P1_SignedDivMod	; 02322F90
	lsl r0,r0,#0x4	; 02322F94
	strh r0,[r4,#0xe]	; 02322F96
	add r4,sp,#0x20	; 02322F98
	str r5,[sp,#0x14]	; 02322F9A
	str r5,[sp,#0x18]	; 02322F9C
	str r5,[sp,#0x1c]	; 02322F9E
	b loc_02323026	; 02322FA0
loc_02322FA2:
	add r0,r7,r5	; 02322FA2
	str r0,[sp,#0x10]	; 02322FA4
	mov r1,#0x7	; 02322FA6
	blx P1_SignedDivMod	; 02322FA8
	add r6,r1,#0x0	; 02322FAC
	add r0,sp,#0x90	; 02322FAE
	add r1,r5,#0x1	; 02322FB0
	lsl r1,r1,#0x10	; 02322FB2
	lsr r1,r1,#0x10	; 02322FB4
	bl loc_023259F8	; 02322FB6
	ldr r0,[sp,#0x1c]	; 02322FBA
	ldrsh r0,[r4,r0]	; 02322FBC
	ldr r1,[pool_02323080]	; 02322FBE
	and r0,r1	; 02322FC0
	lsl r1,r6,#0x4	; 02322FC2
	add r1,#0x88	; 02322FC4
	lsl r1,r1,#0x10	; 02322FC6
	asr r2,r1,#0x10	; 02322FC8
	ldr r1,[pool_02323084]	; 02322FCA
	and r2,r1	; 02322FCC
	orr r0,r2	; 02322FCE
	strh r0,[r4,#0x0]	; 02322FD0
	ldr r0,[sp,#0x10]	; 02322FD2
	mov r1,#0x7	; 02322FD4
	blx P1_SignedDivMod	; 02322FD6
	mov r1,#0x2	; 02322FDA
	ldrsh r1,[r4,r1]	; 02322FDC
	ldr r2,[pool_02323080]	; 02322FDE
	and r1,r2	; 02322FE0
	add r0,r0,#0x1	; 02322FE2
	lsl r0,r0,#0x4	; 02322FE4
	add r0,#0x37	; 02322FE6
	lsl r0,r0,#0x10	; 02322FE8
	asr r2,r0,#0x10	; 02322FEA
	ldr r0,[pool_02323084]	; 02322FEC
	and r2,r0	; 02322FEE
	orr r1,r2	; 02322FF0
	strh r1,[r4,#0x2]	; 02322FF2
	bl loc_02324C58	; 02322FF4
	mov r1,#0x1	; 02322FF8
	str r1,[sp,#0x0]	; 02322FFA
	ldr r1,[sp,#0x14]	; 02322FFC
	str r1,[sp,#0x4]	; 02322FFE
	add r1,sp,#0x90	; 02323000
	str r1,[sp,#0x8]	; 02323002
	lsl r2,r6,#0x2	; 02323004
	add r1,sp,#0x74	; 02323006
	ldr r1,[r1,r2]	; 02323008
	str r1,[sp,#0xc]	; 0232300A
	add r1,sp,#0x38	; 0232300C
	mov r6,sp	; 0232300E
	sub r6,r6,#0x4	; 02323010
	ldrh r2,[r4,#0x0]	; 02323012
	strh r2,[r6,#0x0]	; 02323014
	add r3,r6,#0x0	; 02323016
	ldmia r3!,{r2}	; 02323018
	ldrh r3,[r4,#0x2]	; 0232301A
	strh r3,[r6,#0x0]	; 0232301C
	ldmia r6!,{r3}	; 0232301E
	bl loc_02328CB8	; 02323020
	add r5,r5,#0x1	; 02323024
loc_02323026:
	ldr r0,[sp,#0x48]	; 02323026
	ldr r1,[sp,#0x4c]	; 02323028
	ldr r2,[sp,#0x18]	; 0232302A
	bl loc_02326B0C	; 0232302C
	cmp r5,r0	; 02323030
	bcc loc_02322FA2	; 02323032
	ldr r0,[sp,#0x48]	; 02323034
	ldr r1,[sp,#0x4c]	; 02323036
	mov r2,#0x0	; 02323038
	bl loc_02322DC4	; 0232303A
	cmp r0,#0x0	; 0232303E
	beq loc_0232304A	; 02323040
	mov r0,#0x1	; 02323042
	bl loc_02322D74	; 02323044
	b loc_02323050	; 02323048
loc_0232304A:
	mov r0,#0x0	; 0232304A
	bl loc_02322D74	; 0232304C
loc_02323050:
	add sp,#0xb4	; 02323050
	pop {r4,r5,r6,r7}	; 02323052
	pop {r3}	; 02323054
	bx r3	; 02323056
pool_02323058:
loc_02323058:
	.word 0x023306D0	; 02323058
pool_0232305C:
loc_0232305C:
	.word 0x023306EC	; 0232305C
pool_02323060:
loc_02323060:
	.word 0x00006000	; 02323060
pool_02323064:
loc_02323064:
	.word 0x00000100	; 02323064
pool_02323068:
loc_02323068:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02323068
pool_0232306C:
loc_0232306C:
	.word 0x02330708	; 0232306C
pool_02323070:
loc_02323070:
	.word 0x02330718	; 02323070
pool_02323074:
loc_02323074:
	.word 0x02330728	; 02323074
pool_02323078:
loc_02323078:
	.word 0x023A649C	; 02323078
pool_0232307C:
loc_0232307C:
	.word 0x000007D0	; 0232307C
pool_02323080:
loc_02323080:
	.word 0xFFFFF000	; 02323080
pool_02323084:
loc_02323084:
	.word 0x00000FFF	; 02323084

; ===== function loc_02323088 =====
loc_02323088:
	ldr r0,[pool_02323090]	; 02323088
	ldr r3,[pool_02323094]	; 0232308A
	bx r3	; 0232308C
	.byte 0xC0, 0x46	; 02323090
pool_02323090:
loc_02323090:
	.word 0x02332024	; 02323090
pool_02323094:
loc_02323094:
	.word loc_02322D14 + 1	; 02323094

; ===== function loc_02323098 =====
loc_02323098:
	ldr r0,[pool_023230A0]	; 02323098
	ldr r3,[pool_023230A4]	; 0232309A
	bx r3	; 0232309C
	.byte 0xC0, 0x46	; 023230A0
pool_023230A0:
loc_023230A0:
	.word 0x02332024	; 023230A0
pool_023230A4:
loc_023230A4:
	.word loc_02322E08 + 1	; 023230A4

; ===== function loc_023230A8 =====
loc_023230A8:
	ldr r0,[pool_023230B0]	; 023230A8
	ldr r3,[pool_023230B4]	; 023230AA
	bx r3	; 023230AC
	.byte 0xC0, 0x46	; 023230B0
pool_023230B0:
loc_023230B0:
	.word 0x02332024	; 023230B0
pool_023230B4:
loc_023230B4:
	.word loc_02322E08 + 1	; 023230B4

; ===== function loc_023230B8 =====
loc_023230B8:
	push {r4,r5,lr}	; 023230B8
	sub sp,#0x24	; 023230BA
	ldr r0,[pool_0232327C]	; 023230BC
	ldr r1,[r0,#0x8]	; 023230BE
	cmp r1,#0x0	; 023230C0
	bne loc_023230C6	; 023230C2
	b loc_02323272	; 023230C4
loc_023230C6:
	ldr r1,[r0,#0x4]	; 023230C6
	cmp r1,#0xa	; 023230C8
	bge loc_023230D0	; 023230CA
	add r1,r1,#0x1	; 023230CC
	str r1,[r0,#0x4]	; 023230CE
loc_023230D0:
	ldr r0,[pool_0232327C]	; 023230D0
	ldr r0,[r0,#0x4]	; 023230D2
	lsl r0,r0,#0x4	; 023230D4
	mov r1,#0xa	; 023230D6
	blx P1_SignedDivMod	; 023230D8
	add r4,r0,#0x0	; 023230DC
	sub r4,#0x10	; 023230DE
	add r0,sp,#0x10	; 023230E0
	bl loc_023263C0	; 023230E2
	ldr r0,[pool_02323280]	; 023230E6
	ldr r1,[r0,#0x0]	; 023230E8
	add r1,r1,#0x1	; 023230EA
	str r1,[r0,#0x0]	; 023230EC
	cmp r1,#0x1e	; 023230EE
	bge loc_023230FA	; 023230F0
	mov r1,#0x7f	; 023230F2
	add r0,sp,#0xc	; 023230F4
	strh r1,[r0,#0x8]	; 023230F6
	b loc_02323102	; 023230F8
loc_023230FA:
	cmp r1,#0x3c	; 023230FA
	bne loc_02323102	; 023230FC
	mov r1,#0x0	; 023230FE
	str r1,[r0,#0x0]	; 02323100
loc_02323102:
	ldr r0,[pool_02323284]	; 02323102
	add r1,sp,#0x10	; 02323104
	bl loc_02324B00	; 02323106
	add r0,sp,#0x10	; 0232310A
	bl loc_02326370	; 0232310C
	ldr r0,[pool_02323288]	; 02323110
	add r1,sp,#0x10	; 02323112
	bl loc_02324B00	; 02323114
	bl loc_02323E40	; 02323118
	add r5,r0,#0x0	; 0232311C
	mov r0,#0x1	; 0232311E
	str r0,[sp,#0x0]	; 02323120
	ldr r0,[pool_02323284]	; 02323122
	mov r1,#0x0	; 02323124
	add r2,r4,#0x0	; 02323126
	add r3,r1,#0x0	; 02323128
	bl loc_0232373C	; 0232312A
	mov r0,#0x1	; 0232312E
	str r0,[sp,#0x0]	; 02323130
	ldr r0,[pool_02323288]	; 02323132
	mov r1,#0x0	; 02323134
	add r2,r4,#0x0	; 02323136
	add r3,r1,#0x0	; 02323138
	bl loc_0232373C	; 0232313A
	mov r0,#0x1	; 0232313E
	str r0,[sp,#0x0]	; 02323140
	ldr r0,[pool_0232328C]	; 02323142
	mov r1,#0x0	; 02323144
	add r2,r4,#0x0	; 02323146
	add r3,r1,#0x0	; 02323148
	bl loc_0232373C	; 0232314A
	mov r0,#0x0	; 0232314E
	str r0,[sp,#0x0]	; 02323150
	str r4,[sp,#0x4]	; 02323152
	add r0,r5,#0x0	; 02323154
	ldr r1,[pool_02323290]	; 02323156
	ldr r2,[pool_02323294]	; 02323158
	mov r3,#0x6	; 0232315A
	bl loc_02323BFC	; 0232315C
	mov r0,#0x0	; 02323160
	str r0,[sp,#0x0]	; 02323162
	str r4,[sp,#0x4]	; 02323164
	add r0,r5,#0x0	; 02323166
	ldr r1,[pool_02323290]	; 02323168
	ldr r2,[pool_02323294]	; 0232316A
	mov r3,#0x7	; 0232316C
	bl loc_02323BFC	; 0232316E
	mov r0,#0x0	; 02323172
	str r0,[sp,#0x0]	; 02323174
	str r4,[sp,#0x4]	; 02323176
	add r0,r5,#0x0	; 02323178
	ldr r1,[pool_02323290]	; 0232317A
	ldr r2,[pool_02323294]	; 0232317C
	mov r3,#0x8	; 0232317E
	bl loc_02323BFC	; 02323180
	mov r0,#0x0	; 02323184
	str r0,[sp,#0x0]	; 02323186
	str r4,[sp,#0x4]	; 02323188
	add r0,r5,#0x0	; 0232318A
	ldr r1,[pool_02323290]	; 0232318C
	ldr r2,[pool_02323294]	; 0232318E
	mov r3,#0x9	; 02323190
	bl loc_02323BFC	; 02323192
	mov r0,#0x0	; 02323196
	str r0,[sp,#0x0]	; 02323198
	str r4,[sp,#0x4]	; 0232319A
	add r0,r5,#0x0	; 0232319C
	ldr r1,[pool_02323290]	; 0232319E
	ldr r2,[pool_02323294]	; 023231A0
	mov r3,#0xa	; 023231A2
	bl loc_02323BFC	; 023231A4
	bl P1_GetFirmwareUiContext	; 023231A8
	ldr r0,[r0,#0x4]	; 023231AC
	mov r1,#0x14	; 023231AE
	blx P1_UnsignedDivMod	; 023231B0
	cmp r1,#0x1	; 023231B4
	bne loc_023231DE	; 023231B6
	add r0,sp,#0xc	; 023231B8
	bl loc_0232F184	; 023231BA
	cmp r0,#0x0	; 023231BE
	bne loc_023231D8	; 023231C0
	ldr r0,[sp,#0xc]	; 023231C2
	cmp r0,#0x0	; 023231C4
	bne loc_023231D0	; 023231C6
	mov r1,#0x1	; 023231C8
	ldr r0,[pool_02323298]	; 023231CA
	str r1,[r0,#0x0]	; 023231CC
	b loc_023231DE	; 023231CE
loc_023231D0:
	mov r1,#0x0	; 023231D0
	ldr r0,[pool_02323298]	; 023231D2
	str r1,[r0,#0x0]	; 023231D4
	b loc_023231DE	; 023231D6
loc_023231D8:
	mov r1,#0x1	; 023231D8
	ldr r0,[pool_02323298]	; 023231DA
	str r1,[r0,#0x0]	; 023231DC
loc_023231DE:
	ldr r0,[pool_0232329C]	; 023231DE
	ldr r1,[r0,#0x0]	; 023231E0
	add r1,r1,#0x1	; 023231E2
	str r1,[r0,#0x0]	; 023231E4
	cmp r1,#0x3c	; 023231E6
	bne loc_023231EE	; 023231E8
	mov r1,#0x0	; 023231EA
	str r1,[r0,#0x0]	; 023231EC
loc_023231EE:
	ldr r0,[pool_02323298]	; 023231EE
	ldr r1,[r0,#0x0]	; 023231F0
	cmp r1,#0x0	; 023231F2
	bne loc_023231FE	; 023231F4
	ldr r0,[pool_0232329C]	; 023231F6
	ldr r0,[r0,#0x0]	; 023231F8
	cmp r0,#0x1e	; 023231FA
	bge loc_02323218	; 023231FC
loc_023231FE:
	cmp r1,#0x0	; 023231FE
	beq loc_02323206	; 02323200
	mov r3,#0xb	; 02323202
	b loc_02323208	; 02323204
loc_02323206:
	mov r3,#0x5	; 02323206
loc_02323208:
	mov r0,#0x0	; 02323208
	str r0,[sp,#0x0]	; 0232320A
	str r4,[sp,#0x4]	; 0232320C
	add r0,r5,#0x0	; 0232320E
	ldr r1,[pool_02323290]	; 02323210
	ldr r2,[pool_02323294]	; 02323212
	bl loc_02323BFC	; 02323214
loc_02323218:
	ldr r0,[pool_023232A0]	; 02323218
	ldrh r0,[r0,#0x0]	; 0232321A
	lsl r0,r0,#0x1c	; 0232321C
	lsr r0,r0,#0x1f	; 0232321E
	cmp r0,#0x0	; 02323220
	beq loc_02323228	; 02323222
	mov r3,#0xc	; 02323224
	b loc_0232322A	; 02323226
loc_02323228:
	mov r3,#0x2	; 02323228
loc_0232322A:
	mov r0,#0x0	; 0232322A
	str r0,[sp,#0x0]	; 0232322C
	str r4,[sp,#0x4]	; 0232322E
	add r0,r5,#0x0	; 02323230
	ldr r1,[pool_02323290]	; 02323232
	ldr r2,[pool_02323294]	; 02323234
	bl loc_02323BFC	; 02323236
	ldr r0,[pool_023232A0]	; 0232323A
	ldrh r0,[r0,#0x0]	; 0232323C
	lsl r0,r0,#0x19	; 0232323E
	lsr r0,r0,#0x1f	; 02323240
	cmp r0,#0x0	; 02323242
	beq loc_0232324A	; 02323244
	mov r3,#0x3	; 02323246
	b loc_0232324C	; 02323248
loc_0232324A:
	mov r3,#0x4	; 0232324A
loc_0232324C:
	mov r0,#0x0	; 0232324C
	str r0,[sp,#0x0]	; 0232324E
	str r4,[sp,#0x4]	; 02323250
	add r0,r5,#0x0	; 02323252
	ldr r1,[pool_02323290]	; 02323254
	ldr r2,[pool_02323294]	; 02323256
	bl loc_02323BFC	; 02323258
	mov r0,#0x0	; 0232325C
	str r0,[sp,#0x0]	; 0232325E
	str r4,[sp,#0x4]	; 02323260
	mov r0,#0xf	; 02323262
	str r0,[sp,#0x8]	; 02323264
	add r0,r5,#0x0	; 02323266
	ldr r1,[pool_02323290]	; 02323268
	ldr r2,[pool_02323294]	; 0232326A
	mov r3,#0x1	; 0232326C
	bl loc_02323BA8	; 0232326E
loc_02323272:
	add sp,#0x24	; 02323272
	pop {r4,r5}	; 02323274
	pop {r3}	; 02323276
	bx r3	; 02323278
	.byte 0xC0, 0x46	; 0232327C
pool_0232327C:
loc_0232327C:
	.word P1_BssStart + 0x15FC	; 0232327C
pool_02323280:
loc_02323280:
	.word P1_BssStart + 0x1578	; 02323280
pool_02323284:
loc_02323284:
	.word 0x0233203C	; 02323284
pool_02323288:
loc_02323288:
	.word 0x02332068	; 02323288
pool_0232328C:
loc_0232328C:
	.word 0x02332094	; 0232328C
pool_02323290:
loc_02323290:
	.word 0x023C11F8	; 02323290
pool_02323294:
loc_02323294:
	.word 0x023A588C	; 02323294
pool_02323298:
loc_02323298:
	.word P1_Data_02330738	; 02323298
pool_0232329C:
loc_0232329C:
	.word P1_BssStart + 0x1574	; 0232329C
pool_023232A0:
loc_023232A0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023232A0

; ===== function loc_023232A4 =====
loc_023232A4:
	push {lr}	; 023232A4
	sub sp,#0x4	; 023232A6
	bl loc_02324C44	; 023232A8
	ldr r1,[pool_023232E4]	; 023232AC
	ldr r2,[pool_023232E8]	; 023232AE
	mov r3,#0x81	; 023232B0
	bl loc_02324BB4	; 023232B2
	bl loc_02324C44	; 023232B6
	ldr r1,[pool_023232EC]	; 023232BA
	ldr r2,[pool_023232E8]	; 023232BC
	mov r3,#0x6c	; 023232BE
	bl loc_02324BB4	; 023232C0
	bl loc_02324C44	; 023232C4
	ldr r1,[pool_023232F0]	; 023232C8
	ldr r2,[pool_023232E8]	; 023232CA
	mov r3,#0x6d	; 023232CC
	bl loc_02324BB4	; 023232CE
	mov r1,#0x0	; 023232D2
	ldr r0,[pool_023232F4]	; 023232D4
	str r1,[r0,#0x4]	; 023232D6
	str r1,[r0,#0x8]	; 023232D8
	bl loc_02323300	; 023232DA
	add sp,#0x4	; 023232DE
	pop {r3}	; 023232E0
	bx r3	; 023232E2
pool_023232E4:
loc_023232E4:
	.word 0x02332094	; 023232E4
pool_023232E8:
loc_023232E8:
	.word 0x023A649C	; 023232E8
pool_023232EC:
loc_023232EC:
	.word 0x0233203C	; 023232EC
pool_023232F0:
loc_023232F0:
	.word 0x02332068	; 023232F0
pool_023232F4:
loc_023232F4:
	.word P1_BssStart + 0x15FC	; 023232F4

; ===== function loc_023232F8 =====
loc_023232F8:
	ldr r3,[pool_023232FC]	; 023232F8
	bx r3	; 023232FA
pool_023232FC:
loc_023232FC:
	.word loc_023230B8 + 1	; 023232FC

; ===== function loc_02323300 =====
loc_02323300:
	push {lr}	; 02323300
	sub sp,#0x4	; 02323302
	bl loc_0232642C	; 02323304
	add r1,r0,#0x0	; 02323308
	ldr r0,[pool_02323318]	; 0232330A
	bl loc_02324B00	; 0232330C
	add sp,#0x4	; 02323310
	pop {r3}	; 02323312
	bx r3	; 02323314
	.byte 0xC0, 0x46	; 02323318
pool_02323318:
loc_02323318:
	.word 0x02332094	; 02323318

; ===== function loc_0232331C =====
loc_0232331C:
	mov r1,#0x1	; 0232331C
	ldr r0,[pool_02323324]	; 0232331E
	str r1,[r0,#0x8]	; 02323320
	bx lr	; 02323322
pool_02323324:
loc_02323324:
	.word P1_BssStart + 0x15FC	; 02323324

; ===== function loc_02323328 =====
loc_02323328:
	ldr r3,[pool_0232332C]	; 02323328
	bx r3	; 0232332A
pool_0232332C:
loc_0232332C:
	.word loc_023232A4 + 1	; 0232332C

; ===== function loc_02323330 =====
loc_02323330:
	push {r4,lr}	; 02323330
	ldr r1,[pool_02323358]	; 02323332
	mov r0,#0x4	; 02323334
	ldrsh r4,[r1,r0]	; 02323336
	sub r4,#0xf	; 02323338
	bl loc_0232335C	; 0232333A
	mov r1,#0xc	; 0232333E
	mul r0,r1	; 02323340
	mul r4,r0	; 02323342
	add r0,r4,#0x0	; 02323344
	ldr r2,[pool_02323358]	; 02323346
	mov r1,#0x6	; 02323348
	ldrsh r1,[r2,r1]	; 0232334A
	sub r1,#0xf	; 0232334C
	blx P1_SignedDivMod	; 0232334E
	pop {r4}	; 02323352
	pop {r3}	; 02323354
	bx r3	; 02323356
pool_02323358:
loc_02323358:
	.word P1_BssStart + 0x1608	; 02323358

; ===== function loc_0232335C =====
loc_0232335C:
	push {lr}	; 0232335C
	sub sp,#0x4	; 0232335E
	ldr r0,[pool_02323378]	; 02323360
	ldr r0,[r0,#0x20]	; 02323362
	add r0,r0,#0x1	; 02323364
	mov r1,#0x3	; 02323366
	blx P1_SignedDivMod	; 02323368
	cmp r0,#0x0	; 0232336C
	bne loc_02323372	; 0232336E
	mov r0,#0x1	; 02323370
loc_02323372:
	add sp,#0x4	; 02323372
	pop {r3}	; 02323374
	bx r3	; 02323376
pool_02323378:
loc_02323378:
	.word P1_BssStart + 0x1888	; 02323378

; ===== function loc_0232337C =====
loc_0232337C:
	push {r4,r5,lr}	; 0232337C
	sub sp,#0x1c	; 0232337E
	add r5,r0,#0x0	; 02323380
	add r4,r1,#0x0	; 02323382
	cmp r5,#0xf	; 02323384
	bge loc_023233D4	; 02323386
	add r0,sp,#0x0	; 02323388
	add r1,r4,#0x2	; 0232338A
	ldrb r2,[r4,#0x1]	; 0232338C
	bl P1_Utf16StrNCpy	; 0232338E
	mov r2,#0x0	; 02323392
	ldrb r0,[r4,#0x1]	; 02323394
	lsl r0,r0,#0x1	; 02323396
	add r1,sp,#0x0	; 02323398
	strh r2,[r1,r0]	; 0232339A
	ldr r3,[pool_023233DC]	; 0232339C
	mov r0,#0x2c	; 0232339E
	add r2,r5,#0x0	; 023233A0
	mul r2,r0	; 023233A2
	add r0,r3,r2	; 023233A4
	add r2,r5,#0x1	; 023233A6
	bl loc_02324AD8	; 023233A8
	ldr r0,[pool_023233E0]	; 023233AC
	mov r1,#0x3	; 023233AE
	bl loc_02329188	; 023233B0
	ldrb r1,[r0,#0x6]	; 023233B4
	ldr r0,[pool_023233E4]	; 023233B6
	ldrb r2,[r4,#0x0]	; 023233B8
	lsl r2,r2,#0x1c	; 023233BA
	lsr r2,r2,#0x1c	; 023233BC
	lsl r2,r2,#0x5	; 023233BE
	add r2,r0,r2	; 023233C0
	lsl r0,r1,#0x1	; 023233C2
	add r0,r2,r0	; 023233C4
	add r1,r5,#0x1	; 023233C6
	lsl r2,r1,#0x1	; 023233C8
	ldr r1,[pool_023233E8]	; 023233CA
	add r1,r2,r1	; 023233CC
	mov r2,#0x2	; 023233CE
	bl loc_0232DCC0	; 023233D0
loc_023233D4:
	add sp,#0x1c	; 023233D4
	pop {r4,r5}	; 023233D6
	pop {r3}	; 023233D8
	bx r3	; 023233DA
pool_023233DC:
loc_023233DC:
	.word 0x023320D4	; 023233DC
pool_023233E0:
loc_023233E0:
	.word 0x023A61F4	; 023233E0
pool_023233E4:
loc_023233E4:
	.word 0x023BCA40	; 023233E4
pool_023233E8:
loc_023233E8:
	.word 0x000001C0	; 023233E8

; ===== function loc_023233EC =====
loc_023233EC:
	push {r4,r5,r6,r7,lr}	; 023233EC
	sub sp,#0x14	; 023233EE
	bl loc_0232335C	; 023233F0
	ldr r0,[pool_023234EC]	; 023233F4
	ldr r1,[r0,#0x0]	; 023233F6
	cmp r1,#0x3	; 023233F8
	bhi loc_0232346C	; 023233FA
	add r1,r1,r1	; 023233FC
P1_SwitchIndexPC_023233FC:
	add r1,pc	; 023233FE
	ldrh r1,[r1,#(P1_SwitchTable_023233FC - (P1_SwitchIndexPC_023233FC + 4))]	; 02323400
	lsl r1,r1,#0x10	; 02323402
	asr r1,r1,#0x10	; 02323404
P1_SwitchTargetPC_023233FC:
	add r1,pc	; 02323406
	bx r1	; 02323408
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023233FC:
	.halfword (loc_02323412 + 1) - (P1_SwitchTargetPC_023233FC + 4)
	.halfword (loc_02323414 + 1) - (P1_SwitchTargetPC_023233FC + 4)
	.halfword (loc_0232346C + 1) - (P1_SwitchTargetPC_023233FC + 4)
	.halfword (loc_02323446 + 1) - (P1_SwitchTargetPC_023233FC + 4)
P1_SwitchTable_023233FCEnd:
loc_02323412:
	b loc_023234E4	; 02323412
loc_02323414:
	mov r1,#0x4	; 02323414
	ldrsh r2,[r0,r1]	; 02323416
	mov r1,#0x6	; 02323418
	ldrsh r1,[r0,r1]	; 0232341A
	cmp r2,r1	; 0232341C
	bge loc_02323424	; 0232341E
	add r1,r2,#0x1	; 02323420
	strh r1,[r0,#0x4]	; 02323422
loc_02323424:
	bl loc_023229BC	; 02323424
	cmp r0,#0x11	; 02323428
	beq loc_02323432	; 0232342A
	mov r0,#0x11	; 0232342C
	bl loc_023229C8	; 0232342E
loc_02323432:
	ldr r1,[pool_023234EC]	; 02323432
	mov r0,#0x4	; 02323434
	ldrsh r2,[r1,r0]	; 02323436
	mov r0,#0x6	; 02323438
	ldrsh r0,[r1,r0]	; 0232343A
	cmp r2,r0	; 0232343C
	bne loc_0232346C	; 0232343E
	mov r0,#0x2	; 02323440
	str r0,[r1,#0x0]	; 02323442
	b loc_0232346C	; 02323444
loc_02323446:
	mov r1,#0x4	; 02323446
	ldrsh r2,[r0,r1]	; 02323448
	cmp r2,#0x0	; 0232344A
	ble loc_0232345E	; 0232344C
	sub r2,r2,#0x1	; 0232344E
	strh r2,[r0,#0x4]	; 02323450
	ldrsh r0,[r0,r1]	; 02323452
	cmp r0,#0xf	; 02323454
	bne loc_0232345E	; 02323456
	mov r0,#0xf	; 02323458
	bl loc_023229C8	; 0232345A
loc_0232345E:
	ldr r1,[pool_023234EC]	; 0232345E
	mov r0,#0x4	; 02323460
	ldrsh r0,[r1,r0]	; 02323462
	cmp r0,#0x0	; 02323464
	bne loc_0232346C	; 02323466
	mov r0,#0x0	; 02323468
	str r0,[r1,#0x0]	; 0232346A
loc_0232346C:
	mov r5,#0x0	; 0232346C
	add r4,r5,#0x0	; 0232346E
	b loc_023234BA	; 02323470
loc_02323472:
	ldr r3,[pool_023234F0]	; 02323472
	add r2,sp,#0x8	; 02323474
	ldmia r3!,{r0,r1}	; 02323476
	stmia r2!,{r0,r1}	; 02323478
	ldr r0,[r3,#0x0]	; 0232347A
	str r0,[r2,#0x0]	; 0232347C
	bl loc_02323584	; 0232347E
	add r7,r0,#0x0	; 02323482
	add r0,r5,#0x0	; 02323484
	mov r1,#0x3	; 02323486
	blx P1_SignedDivMod	; 02323488
	add r6,r1,#0x0	; 0232348C
	add r0,r5,#0x0	; 0232348E
	mov r1,#0x3	; 02323490
	blx P1_SignedDivMod	; 02323492
	add r2,r0,#0x0	; 02323496
	str r4,[sp,#0x0]	; 02323498
	add r0,r5,#0x0	; 0232349A
	mov r1,#0x2c	; 0232349C
	mul r0,r1	; 0232349E
	ldr r1,[pool_023234F4]	; 023234A0
	add r0,r1,r0	; 023234A2
	lsl r3,r6,#0x2	; 023234A4
	add r1,sp,#0x8	; 023234A6
	ldr r1,[r1,r3]	; 023234A8
	mov r3,#0xc	; 023234AA
	mul r2,r3	; 023234AC
	sub r3,r3,r7	; 023234AE
	add r2,r2,r3	; 023234B0
	add r3,r4,#0x0	; 023234B2
	bl loc_0232373C	; 023234B4
	add r5,r5,#0x1	; 023234B8
loc_023234BA:
	ldr r0,[pool_023234F8]	; 023234BA
	ldr r0,[r0,#0x20]	; 023234BC
	sub r0,r0,#0x1	; 023234BE
	cmp r5,r0	; 023234C0
	blt loc_02323472	; 023234C2
	bl loc_02323E40	; 023234C4
	add r4,r0,#0x0	; 023234C8
	bl loc_02323584	; 023234CA
	mov r1,#0x0	; 023234CE
	str r1,[sp,#0x0]	; 023234D0
	mov r1,#0xc	; 023234D2
	sub r0,r1,r0	; 023234D4
	str r0,[sp,#0x4]	; 023234D6
	add r0,r4,#0x0	; 023234D8
	ldr r1,[pool_023234FC]	; 023234DA
	ldr r2,[pool_02323500]	; 023234DC
	mov r3,#0x11	; 023234DE
	bl loc_02323BFC	; 023234E0
loc_023234E4:
	add sp,#0x14	; 023234E4
	pop {r4,r5,r6,r7}	; 023234E6
	pop {r3}	; 023234E8
	bx r3	; 023234EA
pool_023234EC:
loc_023234EC:
	.word P1_BssStart + 0x1608	; 023234EC
pool_023234F0:
loc_023234F0:
	.word 0x0233073C	; 023234F0
pool_023234F4:
loc_023234F4:
	.word 0x023320D4	; 023234F4
pool_023234F8:
loc_023234F8:
	.word P1_BssStart + 0x1888	; 023234F8
pool_023234FC:
loc_023234FC:
	.word 0x023C11F8	; 023234FC
pool_02323500:
loc_02323500:
	.word 0x023A52EC	; 02323500

; ===== function loc_02323504 =====
loc_02323504:
	mov r1,#0x3	; 02323504
	ldr r0,[pool_0232350C]	; 02323506
	str r1,[r0,#0x0]	; 02323508
	bx lr	; 0232350A
pool_0232350C:
loc_0232350C:
	.word P1_BssStart + 0x1608	; 0232350C

; ===== function loc_02323510 =====
loc_02323510:
	push {r4,r5,r6,r7,lr}	; 02323510
	sub sp,#0x4	; 02323512
	add r5,r0,#0x0	; 02323514
	ldr r0,[pool_02323570]	; 02323516
	str r5,[r0,#0x8]	; 02323518
	mov r1,#0x1	; 0232351A
	str r1,[r0,#0x0]	; 0232351C
	mov r4,#0x0	; 0232351E
	add r6,r4,#0x0	; 02323520
	ldr r7,[pool_02323574]	; 02323522
loc_02323524:
	ldrh r1,[r5,r7]	; 02323524
	mov r0,#0x2	; 02323526
	lsl r0,r4	; 02323528
	and r1,r0	; 0232352A
	cmp r1,#0x0	; 0232352C
	beq loc_02323544	; 0232352E
	add r0,r6,#0x0	; 02323530
	ldr r1,[pool_02323578]	; 02323532
	add r3,r5,r1	; 02323534
	add r2,r4,#0x0	; 02323536
	mov r1,#0x16	; 02323538
	mul r2,r1	; 0232353A
	add r1,r3,r2	; 0232353C
	bl loc_0232337C	; 0232353E
	add r6,r6,#0x1	; 02323542
loc_02323544:
	add r4,r4,#0x1	; 02323544
	cmp r4,#0xf	; 02323546
	blt loc_02323524	; 02323548
	ldr r0,[pool_0232357C]	; 0232354A
	ldrb r1,[r5,r0]	; 0232354C
	ldr r0,[pool_02323580]	; 0232354E
	str r1,[r0,#0x20]	; 02323550
	mov r1,#0x0	; 02323552
	ldr r0,[pool_02323570]	; 02323554
	strh r1,[r0,#0x4]	; 02323556
	bl loc_0232335C	; 02323558
	mov r1,#0x3	; 0232355C
	mul r0,r1	; 0232355E
	add r0,#0xf	; 02323560
	ldr r1,[pool_02323570]	; 02323562
	strh r0,[r1,#0x6]	; 02323564
	add sp,#0x4	; 02323566
	pop {r4,r5,r6,r7}	; 02323568
	pop {r3}	; 0232356A
	bx r3	; 0232356C
	.byte 0xC0, 0x46	; 02323570
pool_02323570:
loc_02323570:
	.word P1_BssStart + 0x1608	; 02323570
pool_02323574:
loc_02323574:
	.word 0x0000035A	; 02323574
pool_02323578:
loc_02323578:
	.word 0x0000035E	; 02323578
pool_0232357C:
loc_0232357C:
	.word 0x00000358	; 0232357C
pool_02323580:
loc_02323580:
	.word P1_BssStart + 0x1888	; 02323580

; ===== function loc_02323584 =====
loc_02323584:
	push {lr}	; 02323584
	sub sp,#0x4	; 02323586
	bl loc_02323330	; 02323588
	cmp r0,#0x0	; 0232358C
	bge loc_02323594	; 0232358E
	mov r0,#0x0	; 02323590
	b loc_02323598	; 02323592
loc_02323594:
	bl loc_02323330	; 02323594
loc_02323598:
	add sp,#0x4	; 02323598
	pop {r3}	; 0232359A
	bx r3	; 0232359C
	.byte 0x00, 0x00	; 023235A0

; ===== function loc_023235A0 =====
loc_023235A0:
	push {r4,r5,r6,r7,lr}	; 023235A0
	sub sp,#0x4	; 023235A2
	ldr r0,[pool_023235E0]	; 023235A4
	mov r1,#0x0	; 023235A6
	ldr r2,[pool_023235E4]	; 023235A8
	blx loc_0232DEEC	; 023235AA
	mov r5,#0x0	; 023235AE
	ldr r4,[pool_023235E8]	; 023235B0
	ldr r7,[pool_023235EC]	; 023235B2
	mov r6,#0x2c	; 023235B4
loc_023235B6:
	bl loc_02324C44	; 023235B6
	add r1,r5,#0x0	; 023235BA
	mul r1,r6	; 023235BC
	add r1,r4,r1	; 023235BE
	add r2,r7,#0x0	; 023235C0
	mov r3,#0x3	; 023235C2
	bl loc_02324B90	; 023235C4
	add r5,r5,#0x1	; 023235C8
	cmp r5,#0xf	; 023235CA
	blt loc_023235B6	; 023235CC
	mov r1,#0x0	; 023235CE
	ldr r0,[pool_023235E0]	; 023235D0
	str r1,[r0,#0x0]	; 023235D2
	mov r1,#0x1e	; 023235D4
	strh r1,[r0,#0x6]	; 023235D6
	add sp,#0x4	; 023235D8
	pop {r4,r5,r6,r7}	; 023235DA
	pop {r3}	; 023235DC
	bx r3	; 023235DE
pool_023235E0:
loc_023235E0:
	.word P1_BssStart + 0x1608	; 023235E0
pool_023235E4:
loc_023235E4:
	.word 0x000002A4	; 023235E4
pool_023235E8:
loc_023235E8:
	.word 0x023320D4	; 023235E8
pool_023235EC:
loc_023235EC:
	.word 0x023A61F4	; 023235EC

; ===== function loc_023235F0 =====
loc_023235F0:
	push {r4,r5,r6,lr}	; 023235F0
	bl loc_0232E710	; 023235F2
	add r6,r0,#0x0	; 023235F6
	mov r5,#0x0	; 023235F8
	add r4,r5,#0x0	; 023235FA
	ldr r0,[pool_02323654]	; 023235FC
	ldr r1,[r0,#0x0]	; 023235FE
	cmp r1,#0x1e	; 02323600
	bcs loc_02323608	; 02323602
	add r1,r1,#0x1	; 02323604
	str r1,[r0,#0x0]	; 02323606
loc_02323608:
	ldr r0,[pool_02323654]	; 02323608
	ldr r0,[r0,#0x0]	; 0232360A
	cmp r0,#0x1e	; 0232360C
	bcc loc_0232364E	; 0232360E
	b loc_0232361C	; 02323610
loc_02323612:
	add r0,r4,#0x0	; 02323612
	bl loc_0232A230	; 02323614
	add r4,r4,#0x1	; 02323618
	add r5,r5,r0	; 0232361A
loc_0232361C:
	cmp r5,#0x0	; 0232361C
	bne loc_02323624	; 0232361E
	cmp r4,#0x10	; 02323620
	bcc loc_02323612	; 02323622
loc_02323624:
	ldr r0,[pool_02323658]	; 02323624
	and r6,r0	; 02323626
	cmp r6,#0x0	; 02323628
	bne loc_02323648	; 0232362A
	cmp r5,#0x0	; 0232362C
	bne loc_02323648	; 0232362E
	ldr r0,[pool_02323654]	; 02323630
	ldr r1,[r0,#0x0]	; 02323632
	add r1,r1,#0x1	; 02323634
	str r1,[r0,#0x0]	; 02323636
	cmp r1,#0x28	; 02323638
	bcc loc_0232364E	; 0232363A
	bl loc_0232368C	; 0232363C
	mov r1,#0x0	; 02323640
	ldr r0,[pool_02323654]	; 02323642
	str r1,[r0,#0x0]	; 02323644
	b loc_0232364E	; 02323646
loc_02323648:
	mov r1,#0x1e	; 02323648
	ldr r0,[pool_02323654]	; 0232364A
	str r1,[r0,#0x0]	; 0232364C
loc_0232364E:
	pop {r4,r5,r6}	; 0232364E
	pop {r3}	; 02323650
	bx r3	; 02323652
pool_02323654:
loc_02323654:
	.word P1_BssStart + 0x18B0	; 02323654
pool_02323658:
loc_02323658:
	.word 0x0000FFF5	; 02323658

; ===== function loc_0232365C =====
loc_0232365C:
	push {lr}	; 0232365C
	sub sp,#0x4	; 0232365E
	ldr r0,[pool_02323674]	; 02323660
	ldr r0,[r0,#0x0]	; 02323662
	cmp r0,#0x1	; 02323664
	bne loc_0232366C	; 02323666
	bl loc_023235F0	; 02323668
loc_0232366C:
	add sp,#0x4	; 0232366C
	pop {r3}	; 0232366E
	bx r3	; 02323670
	.byte 0xC0, 0x46	; 02323674
pool_02323674:
loc_02323674:
	.word P1_BssStart + 0x18B4	; 02323674
	.byte 0x02, 0x21, 0x02, 0x48, 0x01, 0x60, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0x74, 0x23, 0x33, 0x02	; 02323688
	.byte 0x15, 0x94, 0x32, 0x02	; 0232368C

; ===== function loc_0232368C =====
loc_0232368C:
	push {lr}	; 0232368C
	sub sp,#0x4	; 0232368E
	bl loc_02329414	; 02323690
	ldr r0,[pool_023236B0]	; 02323694
	ldr r1,[pool_023236B4]	; 02323696
	mov r2,#0x1	; 02323698
	bl P1_StartDualBufferProcessor	; 0232369A
	ldr r0,[pool_023236B8]	; 0232369E
	ldr r1,[r0,#0x0]	; 023236A0
	cmp r1,#0x0	; 023236A2
	bne loc_023236AA	; 023236A4
	mov r1,#0x1	; 023236A6
	str r1,[r0,#0x0]	; 023236A8
loc_023236AA:
	add sp,#0x4	; 023236AA
	pop {r3}	; 023236AC
	bx r3	; 023236AE
pool_023236B0:
loc_023236B0:
	.word 0x02332400	; 023236B0
pool_023236B4:
loc_023236B4:
	.word 0x00001000	; 023236B4
pool_023236B8:
loc_023236B8:
	.word P1_BssStart + 0x18B4	; 023236B8

; ===== function loc_023236BC =====
loc_023236BC:
	mov r1,#0x0	; 023236BC
	ldr r3,[pool_023236C4]	; 023236BE
	bx r3	; 023236C0
	.byte 0xC0, 0x46	; 023236C4
pool_023236C4:
loc_023236C4:
	.word loc_0232A258 + 1	; 023236C4

; ===== function loc_023236C8 =====
loc_023236C8:
	add r2,r0,#0x0	; 023236C8
	add r0,r1,#0x0	; 023236CA
	mov r1,#0x0	; 023236CC
	ldr r3,[pool_023236D4]	; 023236CE
	bx r3	; 023236D0
	.byte 0xC0, 0x46	; 023236D4
pool_023236D4:
loc_023236D4:
	.word loc_0232AE5C + 1	; 023236D4
loc_023236D8:
	ldr r3,[pool_023236DC]	; 023236D8
	bx r3	; 023236DA
pool_023236DC:
loc_023236DC:
	.word loc_0232A250 + 1	; 023236DC

; ===== function loc_023236E0 =====
loc_023236E0:
	add r2,r0,#0x0	; 023236E0
	ldr r0,[pool_023236EC]	; 023236E2
	mov r1,#0x0	; 023236E4
	ldr r3,[pool_023236F0]	; 023236E6
	bx r3	; 023236E8
	.byte 0xC0, 0x46	; 023236EC
pool_023236EC:
loc_023236EC:
	.word 0x0233236C	; 023236EC
pool_023236F0:
loc_023236F0:
	.word loc_0232AE5C + 1	; 023236F0

; ===== function loc_023236F4 =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_023236F4:
loc_023236F4:
	ldr r3,[pool_023236F8]	; 023236F4
	bx r3	; 023236F6
pool_023236F8:
loc_023236F8:
	.word loc_02329D64 + 1	; 023236F8

; ===== function loc_023236FC =====
loc_023236FC:
	push {lr}	; 023236FC
	sub sp,#0x4	; 023236FE
	bl loc_02329D88	; 02323700
	ldr r0,[pool_02323728]	; 02323704
	ldr r1,[pool_0232372C]	; 02323706
	mov r2,#0x1	; 02323708
	bl P1_StartDualBufferProcessor	; 0232370A
	ldr r0,[pool_02323730]	; 0232370E
	ldr r1,[pool_02323734]	; 02323710
	bl loc_0232AAA8	; 02323712
	mov r0,#0x0	; 02323716
	bl loc_0232AEC4	; 02323718
	ldr r0,[pool_02323738]	; 0232371C
	bl loc_0232A250	; 0232371E
	add sp,#0x4	; 02323722
	pop {r3}	; 02323724
	bx r3	; 02323726
pool_02323728:
loc_02323728:
	.word 0x02332400	; 02323728
pool_0232372C:
loc_0232372C:
	.word 0x00001000	; 0232372C
pool_02323730:
loc_02323730:
	.word 0x02332378	; 02323730
pool_02323734:
loc_02323734:
	.word 0x023ABAF8	; 02323734
pool_02323738:
loc_02323738:
	.word 0x0233236C	; 02323738

; ===== function loc_0232373C =====
loc_0232373C:
	push {r4,r5,r6,r7,lr}	; 0232373C
	sub sp,#0x2c	; 0232373E
	add r5,r0,#0x0	; 02323740
	str r1,[sp,#0x0]	; 02323742
	str r2,[sp,#0x4]	; 02323744
	add r6,r3,#0x0	; 02323746
	ldr r0,[r5,#0x24]	; 02323748
	ldrh r0,[r0,#0x10]	; 0232374A
	cmp r0,#0x0	; 0232374C
	beq loc_02323758	; 0232374E
	bl loc_02323E40	; 02323750
	str r0,[sp,#0x8]	; 02323754
	b loc_0232375E	; 02323756
loc_02323758:
	bl loc_02323E38	; 02323758
	str r0,[sp,#0x8]	; 0232375C
loc_0232375E:
	ldr r0,[r5,#0x10]	; 0232375E
	bl loc_0232389C	; 02323760
	mov r1,#0x4	; 02323764
	blx P1_SignedDivMod	; 02323766
	str r0,[sp,#0xc]	; 0232376A
	mov r4,#0x0	; 0232376C
	ldr r0,[sp,#0x40]	; 0232376E
	lsl r0,r0,#0xa	; 02323770
	str r0,[sp,#0x18]	; 02323772
	lsl r0,r6,#0xa	; 02323774
	str r0,[sp,#0x1c]	; 02323776
	str r4,[sp,#0x20]	; 02323778
	b loc_023237DA	; 0232377A
loc_0232377C:
	ldrh r0,[r5,#0x16]	; 0232377C
	str r0,[sp,#0x14]	; 0232377E
	ldrh r1,[r5,#0x14]	; 02323780
	ldr r0,[sp,#0xc]	; 02323782
	mul r0,r4	; 02323784
	add r0,r1,r0	; 02323786
	str r0,[sp,#0x10]	; 02323788
	ldr r7,[r5,#0x10]	; 0232378A
	mov r0,#0xa	; 0232378C
	ldrsh r1,[r5,r0]	; 0232378E
	ldr r0,[sp,#0x4]	; 02323790
	add r6,r1,r0	; 02323792
	add r0,r7,#0x0	; 02323794
	bl loc_023237EC	; 02323796
	mov r1,#0x8	; 0232379A
	ldrsh r2,[r5,r1]	; 0232379C
	ldr r1,[sp,#0x0]	; 0232379E
	add r2,r2,r1	; 023237A0
	add r1,r4,#0x0	; 023237A2
	mul r1,r0	; 023237A4
	add r1,r2,r1	; 023237A6
	ldr r0,[pool_023237E8]	; 023237A8
	and r1,r0	; 023237AA
	lsl r1,r1,#0x10	; 023237AC
	mov r0,#0xff	; 023237AE
	and r6,r0	; 023237B0
	ldr r0,[sp,#0x18]	; 023237B2
	orr r6,r0	; 023237B4
	orr r7,r6	; 023237B6
	orr r1,r7	; 023237B8
	str r1,[sp,#0x24]	; 023237BA
	ldr r0,[sp,#0x14]	; 023237BC
	lsl r2,r0,#0xc	; 023237BE
	ldr r1,[sp,#0x10]	; 023237C0
	ldr r0,[sp,#0x1c]	; 023237C2
	orr r1,r0	; 023237C4
	str r1,[sp,#0x10]	; 023237C6
	orr r2,r1	; 023237C8
	add r0,sp,#0x24	; 023237CA
	strh r2,[r0,#0x4]	; 023237CC
	ldr r0,[sp,#0x8]	; 023237CE
	add r1,sp,#0x24	; 023237D0
	ldr r2,[sp,#0x20]	; 023237D2
	bl loc_0232395C	; 023237D4
	add r4,r4,#0x1	; 023237D8
loc_023237DA:
	ldrh r0,[r5,#0x18]	; 023237DA
	cmp r4,r0	; 023237DC
	blt loc_0232377C	; 023237DE
	add sp,#0x2c	; 023237E0
	pop {r4,r5,r6,r7}	; 023237E2
	pop {r3}	; 023237E4
	bx r3	; 023237E6
pool_023237E8:
loc_023237E8:
	.word 0x000001FF	; 023237E8

; ===== function loc_023237EC =====
loc_023237EC:
	ldr r1,[pool_02323870]	; 023237EC
	cmp r0,r1	; 023237EE
	bgt loc_02323828	; 023237F0
	cmp r0,r1	; 023237F2
	bge loc_02323864	; 023237F4
	ldr r1,[pool_02323874]	; 023237F6
	cmp r0,r1	; 023237F8
	bgt loc_02323814	; 023237FA
	cmp r0,r1	; 023237FC
	bge loc_02323860	; 023237FE
	ldr r1,[pool_02323878]	; 02323800
	cmp r0,r1	; 02323802
	bgt loc_0232380C	; 02323804
	cmp r0,r1	; 02323806
	beq loc_02323864	; 02323808
	b loc_0232386C	; 0232380A
loc_0232380C:
	ldr r1,[pool_0232387C]	; 0232380C
	cmp r0,r1	; 0232380E
	beq loc_02323864	; 02323810
	b loc_0232386C	; 02323812
loc_02323814:
	ldr r1,[pool_02323880]	; 02323814
	cmp r0,r1	; 02323816
	bgt loc_02323820	; 02323818
	cmp r0,r1	; 0232381A
	beq loc_02323868	; 0232381C
	b loc_0232386C	; 0232381E
loc_02323820:
	ldr r1,[pool_02323884]	; 02323820
	cmp r0,r1	; 02323822
	beq loc_02323868	; 02323824
	b loc_0232386C	; 02323826
loc_02323828:
	ldr r1,[pool_02323888]	; 02323828
	cmp r0,r1	; 0232382A
	bgt loc_02323844	; 0232382C
	cmp r0,r1	; 0232382E
	bge loc_0232385C	; 02323830
	cmp r0,#0x0	; 02323832
	bgt loc_0232383C	; 02323834
	cmp r0,#0x0	; 02323836
	beq loc_0232385C	; 02323838
	b loc_0232386C	; 0232383A
loc_0232383C:
	ldr r1,[pool_0232388C]	; 0232383C
	cmp r0,r1	; 0232383E
	beq loc_02323860	; 02323840
	b loc_0232386C	; 02323842
loc_02323844:
	ldr r1,[pool_02323890]	; 02323844
	cmp r0,r1	; 02323846
	bgt loc_02323856	; 02323848
	cmp r0,r1	; 0232384A
	bge loc_02323864	; 0232384C
	ldr r1,[pool_02323894]	; 0232384E
	cmp r0,r1	; 02323850
	beq loc_02323860	; 02323852
	b loc_0232386C	; 02323854
loc_02323856:
	ldr r1,[pool_02323898]	; 02323856
	cmp r0,r1	; 02323858
	bne loc_0232386C	; 0232385A
loc_0232385C:
	mov r0,#0x8	; 0232385C
	bx lr	; 0232385E
loc_02323860:
	mov r0,#0x10	; 02323860
	bx lr	; 02323862
loc_02323864:
	mov r0,#0x20	; 02323864
	bx lr	; 02323866
loc_02323868:
	mov r0,#0x40	; 02323868
	bx lr	; 0232386A
loc_0232386C:
	mov r0,#0x0	; 0232386C
	bx lr	; 0232386E
pool_02323870:
loc_02323870:
	.word 0xC0008000	; 02323870
pool_02323874:
loc_02323874:
	.word 0x80008000	; 02323874
pool_02323878:
loc_02323878:
	.word 0x80000000	; 02323878
pool_0232387C:
loc_0232387C:
	.word 0x80004000	; 0232387C
pool_02323880:
loc_02323880:
	.word 0xC0000000	; 02323880
pool_02323884:
loc_02323884:
	.word 0xC0004000	; 02323884
pool_02323888:
loc_02323888:
	.word 0x00008000	; 02323888
pool_0232388C:
loc_0232388C:
	.word 0x00004000	; 0232388C
pool_02323890:
loc_02323890:
	.word 0x40004000	; 02323890
pool_02323894:
loc_02323894:
	.word 0x40000000	; 02323894
pool_02323898:
loc_02323898:
	.word 0x40008000	; 02323898

; ===== function loc_0232389C =====
loc_0232389C:
	ldr r1,[pool_02323930]	; 0232389C
	cmp r0,r1	; 0232389E
	bgt loc_023238D8	; 023238A0
	cmp r0,r1	; 023238A2
	bge loc_02323922	; 023238A4
	ldr r1,[pool_02323934]	; 023238A6
	cmp r0,r1	; 023238A8
	bgt loc_023238C4	; 023238AA
	cmp r0,r1	; 023238AC
	bge loc_0232391A	; 023238AE
	ldr r1,[pool_02323938]	; 023238B0
	cmp r0,r1	; 023238B2
	bgt loc_023238BC	; 023238B4
	cmp r0,r1	; 023238B6
	beq loc_0232391E	; 023238B8
	b loc_0232392A	; 023238BA
loc_023238BC:
	ldr r1,[pool_0232393C]	; 023238BC
	cmp r0,r1	; 023238BE
	beq loc_0232391A	; 023238C0
	b loc_0232392A	; 023238C2
loc_023238C4:
	ldr r1,[pool_02323940]	; 023238C4
	cmp r0,r1	; 023238C6
	bgt loc_023238D0	; 023238C8
	cmp r0,r1	; 023238CA
	beq loc_02323926	; 023238CC
	b loc_0232392A	; 023238CE
loc_023238D0:
	ldr r1,[pool_02323944]	; 023238D0
	cmp r0,r1	; 023238D2
	beq loc_02323922	; 023238D4
	b loc_0232392A	; 023238D6
loc_023238D8:
	ldr r1,[pool_02323948]	; 023238D8
	cmp r0,r1	; 023238DA
	bgt loc_023238F4	; 023238DC
	cmp r0,r1	; 023238DE
	bge loc_02323912	; 023238E0
	cmp r0,#0x0	; 023238E2
	bgt loc_023238EC	; 023238E4
	cmp r0,#0x0	; 023238E6
	beq loc_0232390E	; 023238E8
	b loc_0232392A	; 023238EA
loc_023238EC:
	ldr r1,[pool_0232394C]	; 023238EC
	cmp r0,r1	; 023238EE
	beq loc_02323912	; 023238F0
	b loc_0232392A	; 023238F2
loc_023238F4:
	ldr r1,[pool_02323950]	; 023238F4
	cmp r0,r1	; 023238F6
	bgt loc_02323906	; 023238F8
	cmp r0,r1	; 023238FA
	bge loc_02323916	; 023238FC
	ldr r1,[pool_02323954]	; 023238FE
	cmp r0,r1	; 02323900
	beq loc_02323916	; 02323902
	b loc_0232392A	; 02323904
loc_02323906:
	ldr r1,[pool_02323958]	; 02323906
	cmp r0,r1	; 02323908
	beq loc_02323916	; 0232390A
	b loc_0232392A	; 0232390C
loc_0232390E:
	mov r0,#0x1	; 0232390E
	bx lr	; 02323910
loc_02323912:
	mov r0,#0x2	; 02323912
	bx lr	; 02323914
loc_02323916:
	mov r0,#0x4	; 02323916
	bx lr	; 02323918
loc_0232391A:
	mov r0,#0x8	; 0232391A
	bx lr	; 0232391C
loc_0232391E:
	mov r0,#0x10	; 0232391E
	bx lr	; 02323920
loc_02323922:
	mov r0,#0x20	; 02323922
	bx lr	; 02323924
loc_02323926:
	mov r0,#0x40	; 02323926
	bx lr	; 02323928
loc_0232392A:
	mov r0,#0x0	; 0232392A
	bx lr	; 0232392C
	.byte 0xC0, 0x46	; 02323930
pool_02323930:
loc_02323930:
	.word 0xC0008000	; 02323930
pool_02323934:
loc_02323934:
	.word 0x80008000	; 02323934
pool_02323938:
loc_02323938:
	.word 0x80000000	; 02323938
pool_0232393C:
loc_0232393C:
	.word 0x80004000	; 0232393C
pool_02323940:
loc_02323940:
	.word 0xC0000000	; 02323940
pool_02323944:
loc_02323944:
	.word 0xC0004000	; 02323944
pool_02323948:
loc_02323948:
	.word 0x00008000	; 02323948
pool_0232394C:
loc_0232394C:
	.word 0x00004000	; 0232394C
pool_02323950:
loc_02323950:
	.word 0x40004000	; 02323950
pool_02323954:
loc_02323954:
	.word 0x40000000	; 02323954
pool_02323958:
loc_02323958:
	.word 0x40008000	; 02323958

; ===== function loc_0232395C =====
loc_0232395C:
	push {r4,r5,lr}	; 0232395C
	sub sp,#0x4	; 0232395E
	add r3,r0,#0x0	; 02323960
	ldr r0,[pool_023239E0]	; 02323962
	ldr r4,[r3,r0]	; 02323964
	cmp r4,#0x7f	; 02323966
	bne loc_0232396E	; 02323968
	mov r0,#0x0	; 0232396A
	b loc_023239D8	; 0232396C
loc_0232396E:
	cmp r2,#0x0	; 0232396E
	beq loc_0232397E	; 02323970
	ldr r0,[pool_023239E4]	; 02323972
	ldr r0,[r3,r0]	; 02323974
	cmp r0,#0x1f	; 02323976
	bne loc_0232397E	; 02323978
	mov r0,#0x0	; 0232397A
	b loc_023239D8	; 0232397C
loc_0232397E:
	lsl r5,r4,#0x3	; 0232397E
	add r0,r3,r5	; 02323980
	ldr r4,[r1,#0x0]	; 02323982
	ldr r1,[r1,#0x4]	; 02323984
	str r4,[r3,r5]	; 02323986
	str r1,[r0,#0x4]	; 02323988
	cmp r2,#0x0	; 0232398A
	beq loc_02323994	; 0232398C
	ldr r0,[pool_023239E4]	; 0232398E
	ldr r0,[r3,r0]	; 02323990
	b loc_02323996	; 02323992
loc_02323994:
	mov r0,#0x0	; 02323994
loc_02323996:
	ldr r1,[pool_023239E0]	; 02323996
	ldr r1,[r3,r1]	; 02323998
	lsl r5,r1,#0x3	; 0232399A
	ldr r4,[r3,r5]	; 0232399C
	ldr r1,[pool_023239E8]	; 0232399E
	and r4,r1	; 023239A0
	mov r1,#0x1f	; 023239A2
	and r0,r1	; 023239A4
	lsl r0,r0,#0x19	; 023239A6
	orr r4,r0	; 023239A8
	str r4,[r3,r5]	; 023239AA
	cmp r2,#0x0	; 023239AC
	beq loc_023239CC	; 023239AE
	ldr r0,[pool_023239E4]	; 023239B0
	add r4,r3,r0	; 023239B2
	ldr r0,[r4,#0x0]	; 023239B4
	lsl r0,r0,#0x4	; 023239B6
	add r1,r3,r0	; 023239B8
	ldr r0,[pool_023239EC]	; 023239BA
	add r5,r1,r0	; 023239BC
	ldmia r2!,{r0,r1}	; 023239BE
	stmia r5!,{r0,r1}	; 023239C0
	ldmia r2!,{r0,r1}	; 023239C2
	stmia r5!,{r0,r1}	; 023239C4
	ldr r0,[r4,#0x0]	; 023239C6
	add r0,r0,#0x1	; 023239C8
	str r0,[r4,#0x0]	; 023239CA
loc_023239CC:
	ldr r0,[pool_023239E0]	; 023239CC
	add r0,r3,r0	; 023239CE
	ldr r1,[r0,#0x0]	; 023239D0
	add r1,r1,#0x1	; 023239D2
	str r1,[r0,#0x0]	; 023239D4
	mov r0,#0x1	; 023239D6
loc_023239D8:
	add sp,#0x4	; 023239D8
	pop {r4,r5}	; 023239DA
	pop {r3}	; 023239DC
	bx r3	; 023239DE
pool_023239E0:
loc_023239E0:
	.word 0x00000600	; 023239E0
pool_023239E4:
loc_023239E4:
	.word 0x00000604	; 023239E4
pool_023239E8:
loc_023239E8:
	.word 0xC1FFFFFF	; 023239E8
pool_023239EC:
loc_023239EC:
	.word 0x00000400	; 023239EC

; ===== function loc_023239F0 =====
loc_023239F0:
	push {r4,lr}	; 023239F0
	sub sp,#0x18	; 023239F2
	add r4,r0,#0x0	; 023239F4
	ldr r0,[sp,#0x20]	; 023239F6
	str r0,[sp,#0x0]	; 023239F8
	ldr r0,[sp,#0x24]	; 023239FA
	str r0,[sp,#0x4]	; 023239FC
	ldr r0,[sp,#0x28]	; 023239FE
	str r0,[sp,#0x8]	; 02323A00
	ldr r0,[sp,#0x2c]	; 02323A02
	str r0,[sp,#0xc]	; 02323A04
	ldr r0,[sp,#0x30]	; 02323A06
	str r0,[sp,#0x10]	; 02323A08
	add r0,r1,#0x0	; 02323A0A
	add r1,r2,#0x0	; 02323A0C
	add r2,r4,#0x0	; 02323A0E
	bl loc_02323CA8	; 02323A10
	add sp,#0x18	; 02323A14
	pop {r4}	; 02323A16
	pop {r3}	; 02323A18
	bx r3	; 02323A1A

; ===== function loc_02323A1C =====
P1_Entry_02323A1C:
	push {r4,lr}	; 02323A1C
	sub sp,#0x18	; 02323A1E
	add r4,r0,#0x0	; 02323A20
	ldr r0,[sp,#0x20]	; 02323A22
	str r0,[sp,#0x0]	; 02323A24
	ldr r0,[sp,#0x24]	; 02323A26
	str r0,[sp,#0x4]	; 02323A28
	mov r0,#0x0	; 02323A2A
	mvn r0,r0	; 02323A2C
	str r0,[sp,#0x8]	; 02323A2E
	ldr r0,[sp,#0x28]	; 02323A30
	str r0,[sp,#0xc]	; 02323A32
	ldr r0,[sp,#0x2c]	; 02323A34
	str r0,[sp,#0x10]	; 02323A36
	add r0,r1,#0x0	; 02323A38
	add r1,r2,#0x0	; 02323A3A
	add r2,r4,#0x0	; 02323A3C
	bl loc_02323CA8	; 02323A3E
	add sp,#0x18	; 02323A42
	pop {r4}	; 02323A44
	pop {r3}	; 02323A46
	bx r3	; 02323A48
	.byte 0x00, 0x00, 0x10, 0xB5, 0x86, 0xB0, 0x04, 0x1C, 0x08, 0x98, 0x00, 0x90, 0x09, 0x98, 0x01, 0x90	; 02323A5A
	.byte 0x0A, 0x98, 0x02, 0x90, 0x00, 0x20, 0xC0, 0x43, 0x03, 0x90, 0x0B, 0x98, 0x04, 0x90, 0x08, 0x1C	; 02323A6A
	.byte 0x11, 0x1C, 0x22, 0x1C, 0x00, 0xF0, 0x1B, 0xF9, 0x06, 0xB0, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 02323A7A
	.byte 0x00, 0x00, 0x30, 0xB5, 0x85, 0xB0, 0x04, 0x1C, 0x00, 0x25, 0x00, 0x95, 0x01, 0x95, 0x08, 0x98	; 02323A8A
	.byte 0x02, 0x90, 0xE8, 0x43, 0x03, 0x90, 0x09, 0x98, 0x04, 0x90, 0x08, 0x1C, 0x11, 0x1C, 0x22, 0x1C	; 02323A9A
	.byte 0x00, 0xF0, 0x05, 0xF9, 0x05, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 02323AA8

; ===== function loc_02323AA8 =====
loc_02323AA8:
	push {r4,lr}	; 02323AA8
	sub sp,#0x18	; 02323AAA
	add r4,r0,#0x0	; 02323AAC
	ldr r0,[sp,#0x20]	; 02323AAE
	str r0,[sp,#0x0]	; 02323AB0
	ldr r0,[sp,#0x24]	; 02323AB2
	str r0,[sp,#0x4]	; 02323AB4
	mov r0,#0x0	; 02323AB6
	mvn r0,r0	; 02323AB8
	str r0,[sp,#0x8]	; 02323ABA
	str r0,[sp,#0xc]	; 02323ABC
	ldr r0,[sp,#0x28]	; 02323ABE
	str r0,[sp,#0x10]	; 02323AC0
	add r0,r1,#0x0	; 02323AC2
	add r1,r2,#0x0	; 02323AC4
	add r2,r4,#0x0	; 02323AC6
	bl loc_02323CA8	; 02323AC8
	add sp,#0x18	; 02323ACC
	pop {r4}	; 02323ACE
	pop {r3}	; 02323AD0
	bx r3	; 02323AD2

; ===== function loc_02323AD4 =====
	push {r4,lr}	; 02323AD4
	sub sp,#0x18	; 02323AD6
	add r4,r0,#0x0	; 02323AD8
	mov r0,#0x0	; 02323ADA
	str r0,[sp,#0x0]	; 02323ADC
	str r0,[sp,#0x4]	; 02323ADE
	mvn r0,r0	; 02323AE0
	str r0,[sp,#0x8]	; 02323AE2
	str r0,[sp,#0xc]	; 02323AE4
	ldr r0,[sp,#0x20]	; 02323AE6
	str r0,[sp,#0x10]	; 02323AE8
	add r0,r1,#0x0	; 02323AEA
	add r1,r2,#0x0	; 02323AEC
	add r2,r4,#0x0	; 02323AEE
	bl loc_02323CA8	; 02323AF0
	add sp,#0x18	; 02323AF4
	pop {r4}	; 02323AF6
	pop {r3}	; 02323AF8
	bx r3	; 02323AFA
P1_Entry_02323AFC:
	push {r4,lr}	; 02323AFC
	sub sp,#0x18	; 02323AFE
	add r4,r0,#0x0	; 02323B00
	ldr r0,[sp,#0x20]	; 02323B02
	str r0,[sp,#0x0]	; 02323B04
	ldr r0,[sp,#0x24]	; 02323B06
	str r0,[sp,#0x4]	; 02323B08
	ldr r0,[sp,#0x28]	; 02323B0A
	str r0,[sp,#0x8]	; 02323B0C
	ldr r0,[sp,#0x2c]	; 02323B0E
	str r0,[sp,#0xc]	; 02323B10
	mov r0,#0x0	; 02323B12
	mvn r0,r0	; 02323B14
	str r0,[sp,#0x10]	; 02323B16
	add r0,r1,#0x0	; 02323B18
	add r1,r2,#0x0	; 02323B1A
	add r2,r4,#0x0	; 02323B1C
	bl loc_02323CA8	; 02323B1E
	add sp,#0x18	; 02323B22
	pop {r4}	; 02323B24
	pop {r3}	; 02323B26
	bx r3	; 02323B28
	.byte 0x00, 0x00	; 02323B2A

; ===== function loc_02323B2C =====
loc_02323B2C:
	push {r4,r5,lr}	; 02323B2C
	sub sp,#0x14	; 02323B2E
	add r4,r0,#0x0	; 02323B30
	ldr r0,[sp,#0x20]	; 02323B32
	str r0,[sp,#0x0]	; 02323B34
	ldr r0,[sp,#0x24]	; 02323B36
	str r0,[sp,#0x4]	; 02323B38
	mov r0,#0x0	; 02323B3A
	mvn r5,r0	; 02323B3C
	str r5,[sp,#0x8]	; 02323B3E
	ldr r0,[sp,#0x28]	; 02323B40
	str r0,[sp,#0xc]	; 02323B42
	str r5,[sp,#0x10]	; 02323B44
	add r0,r1,#0x0	; 02323B46
	add r1,r2,#0x0	; 02323B48
	add r2,r4,#0x0	; 02323B4A
	bl loc_02323CA8	; 02323B4C
	add sp,#0x14	; 02323B50
	pop {r4,r5}	; 02323B52
	pop {r3}	; 02323B54
	bx r3	; 02323B56

; ===== function loc_02323B58 =====
P1_Entry_02323B58:
	push {r4,r5,lr}	; 02323B58
	sub sp,#0x14	; 02323B5A
	add r4,r0,#0x0	; 02323B5C
	mov r0,#0x0	; 02323B5E
	str r0,[sp,#0x0]	; 02323B60
	str r0,[sp,#0x4]	; 02323B62
	mvn r5,r0	; 02323B64
	str r5,[sp,#0x8]	; 02323B66
	ldr r0,[sp,#0x20]	; 02323B68
	str r0,[sp,#0xc]	; 02323B6A
	str r5,[sp,#0x10]	; 02323B6C
	add r0,r1,#0x0	; 02323B6E
	add r1,r2,#0x0	; 02323B70
	add r2,r4,#0x0	; 02323B72
	bl loc_02323CA8	; 02323B74
	add sp,#0x14	; 02323B78
	pop {r4,r5}	; 02323B7A
	pop {r3}	; 02323B7C
	bx r3	; 02323B7E

; ===== function loc_02323B80 =====
loc_02323B80:
	push {r4,r5,lr}	; 02323B80
	sub sp,#0x14	; 02323B82
	add r5,r0,#0x0	; 02323B84
	mov r4,#0x0	; 02323B86
	str r4,[sp,#0x0]	; 02323B88
	mvn r0,r4	; 02323B8A
	str r0,[sp,#0x4]	; 02323B8C
	str r3,[sp,#0x8]	; 02323B8E
	str r0,[sp,#0xc]	; 02323B90
	add r0,r1,#0x0	; 02323B92
	add r1,r2,#0x0	; 02323B94
	add r2,r5,#0x0	; 02323B96
	add r3,r4,#0x0	; 02323B98
	bl loc_02323C50	; 02323B9A
	add sp,#0x14	; 02323B9E
	pop {r4,r5}	; 02323BA0
	pop {r3}	; 02323BA2
	bx r3	; 02323BA4
	.byte 0x00, 0x00	; 02323BA8

; ===== function loc_02323BA8 =====
loc_02323BA8:
	push {r4,lr}	; 02323BA8
	sub sp,#0x18	; 02323BAA
	add r4,r0,#0x0	; 02323BAC
	ldr r0,[sp,#0x20]	; 02323BAE
	str r0,[sp,#0x0]	; 02323BB0
	ldr r0,[sp,#0x24]	; 02323BB2
	str r0,[sp,#0x4]	; 02323BB4
	ldr r0,[sp,#0x28]	; 02323BB6
	str r0,[sp,#0x8]	; 02323BB8
	mov r0,#0x0	; 02323BBA
	mvn r0,r0	; 02323BBC
	str r0,[sp,#0xc]	; 02323BBE
	str r0,[sp,#0x10]	; 02323BC0
	add r0,r1,#0x0	; 02323BC2
	add r1,r2,#0x0	; 02323BC4
	add r2,r4,#0x0	; 02323BC6
	bl loc_02323CA8	; 02323BC8
	add sp,#0x18	; 02323BCC
	pop {r4}	; 02323BCE
	pop {r3}	; 02323BD0
	bx r3	; 02323BD2

; ===== function loc_02323BD4 =====
P1_Entry_02323BD4:
	push {r4,r5,lr}	; 02323BD4
	sub sp,#0x14	; 02323BD6
	add r4,r0,#0x0	; 02323BD8
	mov r5,#0x0	; 02323BDA
	str r5,[sp,#0x0]	; 02323BDC
	str r5,[sp,#0x4]	; 02323BDE
	ldr r0,[sp,#0x20]	; 02323BE0
	str r0,[sp,#0x8]	; 02323BE2
	mvn r0,r5	; 02323BE4
	str r0,[sp,#0xc]	; 02323BE6
	str r0,[sp,#0x10]	; 02323BE8
	add r0,r1,#0x0	; 02323BEA
	add r1,r2,#0x0	; 02323BEC
	add r2,r4,#0x0	; 02323BEE
	bl loc_02323CA8	; 02323BF0
	add sp,#0x14	; 02323BF4
	pop {r4,r5}	; 02323BF6
	pop {r3}	; 02323BF8
	bx r3	; 02323BFA

; ===== function loc_02323BFC =====
loc_02323BFC:
	push {r4,lr}	; 02323BFC
	sub sp,#0x18	; 02323BFE
	add r4,r0,#0x0	; 02323C00
	ldr r0,[sp,#0x20]	; 02323C02
	str r0,[sp,#0x0]	; 02323C04
	ldr r0,[sp,#0x24]	; 02323C06
	str r0,[sp,#0x4]	; 02323C08
	mov r0,#0x0	; 02323C0A
	mvn r0,r0	; 02323C0C
	str r0,[sp,#0x8]	; 02323C0E
	str r0,[sp,#0xc]	; 02323C10
	str r0,[sp,#0x10]	; 02323C12
	add r0,r1,#0x0	; 02323C14
	add r1,r2,#0x0	; 02323C16
	add r2,r4,#0x0	; 02323C18
	bl loc_02323CA8	; 02323C1A
	add sp,#0x18	; 02323C1E
	pop {r4}	; 02323C20
	pop {r3}	; 02323C22
	bx r3	; 02323C24
	.byte 0x00, 0x00	; 02323C28

; ===== function loc_02323C28 =====
loc_02323C28:
	push {r4,lr}	; 02323C28
	sub sp,#0x18	; 02323C2A
	add r4,r0,#0x0	; 02323C2C
	mov r0,#0x0	; 02323C2E
	str r0,[sp,#0x0]	; 02323C30
	str r0,[sp,#0x4]	; 02323C32
	mvn r0,r0	; 02323C34
	str r0,[sp,#0x8]	; 02323C36
	str r0,[sp,#0xc]	; 02323C38
	str r0,[sp,#0x10]	; 02323C3A
	add r0,r1,#0x0	; 02323C3C
	add r1,r2,#0x0	; 02323C3E
	add r2,r4,#0x0	; 02323C40
	bl loc_02323CA8	; 02323C42
	add sp,#0x18	; 02323C46
	pop {r4}	; 02323C48
	pop {r3}	; 02323C4A
	bx r3	; 02323C4C
	.byte 0x00, 0x00	; 02323C50

; ===== function loc_02323C50 =====
loc_02323C50:
	push {r4,r5,r6,r7,lr}	; 02323C50
	sub sp,#0x24	; 02323C52
	str r0,[sp,#0x14]	; 02323C54
	add r5,r1,#0x0	; 02323C56
	str r2,[sp,#0x18]	; 02323C58
	str r3,[sp,#0x1c]	; 02323C5A
	ldr r6,[sp,#0x38]	; 02323C5C
	ldr r7,[sp,#0x3c]	; 02323C5E
	ldr r0,[sp,#0x40]	; 02323C60
	str r0,[sp,#0x40]	; 02323C62
	ldr r0,[sp,#0x44]	; 02323C64
	str r0,[sp,#0x44]	; 02323C66
	ldrh r0,[r5,#0x6]	; 02323C68
	str r0,[sp,#0x20]	; 02323C6A
	mov r4,#0x0	; 02323C6C
	b loc_02323C96	; 02323C6E
loc_02323C70:
	ldr r0,[sp,#0x1c]	; 02323C70
	str r0,[sp,#0x0]	; 02323C72
	str r6,[sp,#0x4]	; 02323C74
	str r7,[sp,#0x8]	; 02323C76
	ldr r0,[sp,#0x40]	; 02323C78
	str r0,[sp,#0xc]	; 02323C7A
	ldr r0,[sp,#0x44]	; 02323C7C
	str r0,[sp,#0x10]	; 02323C7E
	ldr r0,[sp,#0x14]	; 02323C80
	add r1,r5,#0x0	; 02323C82
	ldr r2,[sp,#0x18]	; 02323C84
	add r3,r4,#0x0	; 02323C86
	bl loc_02323CA8	; 02323C88
	cmp r0,#0x0	; 02323C8C
	bne loc_02323C94	; 02323C8E
	mov r0,#0x0	; 02323C90
	b loc_02323C9E	; 02323C92
loc_02323C94:
	add r4,r4,#0x1	; 02323C94
loc_02323C96:
	ldr r0,[sp,#0x20]	; 02323C96
	cmp r4,r0	; 02323C98
	blt loc_02323C70	; 02323C9A
	mov r0,#0x1	; 02323C9C
loc_02323C9E:
	add sp,#0x24	; 02323C9E
	pop {r4,r5,r6,r7}	; 02323CA0
	pop {r3}	; 02323CA2
	bx r3	; 02323CA4
	.byte 0x00, 0x00	; 02323CA8

; ===== function loc_02323CA8 =====
loc_02323CA8:
	push {r4,r5,r6,r7,lr}	; 02323CA8
	sub sp,#0x1c	; 02323CAA
	str r0,[sp,#0x10]	; 02323CAC
	str r2,[sp,#0x14]	; 02323CAE
	add r4,r1,#0x0	; 02323CB0
	add r4,#0x8	; 02323CB2
	lsl r7,r3,#0x3	; 02323CB4
	add r5,r4,r7	; 02323CB6
	ldr r1,[r5,#0x4]	; 02323CB8
	bl loc_023291A0	; 02323CBA
	add r6,r0,#0x0	; 02323CBE
	mov r1,sp	; 02323CC0
	sub r1,r1,#0x4	; 02323CC2
	ldrh r0,[r4,r7]	; 02323CC4
	strh r0,[r1,#0x0]	; 02323CC6
	ldmia r1!,{r0}	; 02323CC8
	ldrb r1,[r6,#0x0]	; 02323CCA
	bl loc_023290D0	; 02323CCC
	ldr r1,[sp,#0x30]	; 02323CD0
	add r0,r1,r0	; 02323CD2
	str r0,[sp,#0x30]	; 02323CD4
	mov r1,sp	; 02323CD6
	sub r1,r1,#0x4	; 02323CD8
	ldrh r0,[r5,#0x2]	; 02323CDA
	strh r0,[r1,#0x0]	; 02323CDC
	ldmia r1!,{r0}	; 02323CDE
	ldrb r1,[r6,#0x1]	; 02323CE0
	bl loc_02329098	; 02323CE2
	ldr r1,[sp,#0x34]	; 02323CE6
	add r3,r1,r0	; 02323CE8
	str r3,[sp,#0x34]	; 02323CEA
	ldr r0,[sp,#0x38]	; 02323CEC
	str r0,[sp,#0x0]	; 02323CEE
	ldr r0,[sp,#0x3c]	; 02323CF0
	str r0,[sp,#0x4]	; 02323CF2
	ldr r0,[sp,#0x40]	; 02323CF4
	str r0,[sp,#0x8]	; 02323CF6
	ldr r0,[r5,#0x4]	; 02323CF8
	str r0,[sp,#0xc]	; 02323CFA
	ldr r0,[sp,#0x10]	; 02323CFC
	ldr r1,[sp,#0x14]	; 02323CFE
	ldr r2,[sp,#0x30]	; 02323D00
	bl loc_02323D10	; 02323D02
	add sp,#0x1c	; 02323D06
	pop {r4,r5,r6,r7}	; 02323D08
	pop {r3}	; 02323D0A
	bx r3	; 02323D0C
	.byte 0x00, 0x00	; 02323D10

; ===== function loc_02323D10 =====
loc_02323D10:
	push {r4,r5,r6,r7,lr}	; 02323D10
	sub sp,#0x14	; 02323D12
	add r5,r0,#0x0	; 02323D14
	add r4,r1,#0x0	; 02323D16
	str r2,[sp,#0x0]	; 02323D18
	str r3,[sp,#0x4]	; 02323D1A
	ldr r1,[sp,#0x28]	; 02323D1C
	str r1,[sp,#0x28]	; 02323D1E
	ldr r1,[sp,#0x2c]	; 02323D20
	str r1,[sp,#0x2c]	; 02323D22
	ldr r1,[sp,#0x30]	; 02323D24
	str r1,[sp,#0x30]	; 02323D26
	ldr r1,[sp,#0x34]	; 02323D28
	bl loc_023291D0	; 02323D2A
	str r0,[sp,#0x8]	; 02323D2E
	add r0,r5,#0x0	; 02323D30
	ldr r1,[sp,#0x34]	; 02323D32
	bl loc_023291B8	; 02323D34
	add r7,r0,#0x0	; 02323D38
	add r0,r5,#0x0	; 02323D3A
	ldr r1,[sp,#0x34]	; 02323D3C
	bl loc_023291A0	; 02323D3E
	mov r2,#0x0	; 02323D42
	str r2,[sp,#0xc]	; 02323D44
	ldr r0,[pool_02323E14]	; 02323D46
	ldr r1,[r4,r0]	; 02323D48
	b loc_02323D62	; 02323D4A
loc_02323D4C:
	lsl r0,r2,#0x3	; 02323D4C
	add r0,r4,r0	; 02323D4E
	ldr r3,[pool_02323E18]	; 02323D50
	ldr r3,[r0,r3]	; 02323D52
	cmp r3,r5	; 02323D54
	bne loc_02323D60	; 02323D56
	ldr r3,[pool_02323E1C]	; 02323D58
	ldr r0,[r0,r3]	; 02323D5A
	lsr r0,r0,#0x7	; 02323D5C
	str r0,[sp,#0xc]	; 02323D5E
loc_02323D60:
	add r2,r2,#0x1	; 02323D60
loc_02323D62:
	cmp r2,r1	; 02323D62
	blt loc_02323D4C	; 02323D64
	mov r1,#0x0	; 02323D66
	b loc_02323E02	; 02323D68
loc_02323D6A:
	ldr r0,[pool_02323E20]	; 02323D6A
	ldr r0,[r4,r0]	; 02323D6C
	lsl r0,r0,#0x3	; 02323D6E
	add r2,r4,r0	; 02323D70
	ldr r5,[r7,#0x0]	; 02323D72
	ldr r3,[r7,#0x4]	; 02323D74
	str r5,[r4,r0]	; 02323D76
	str r3,[r2,#0x4]	; 02323D78
	ldrh r6,[r2,#0x4]	; 02323D7A
	ldr r3,[pool_02323E24]	; 02323D7C
	and r6,r3	; 02323D7E
	ldrh r5,[r7,#0x8]	; 02323D80
	ldr r3,[sp,#0xc]	; 02323D82
	add r3,r5,r3	; 02323D84
	orr r6,r3	; 02323D86
	strh r6,[r2,#0x4]	; 02323D88
	ldr r5,[r4,r0]	; 02323D8A
	add r6,r5,#0x0	; 02323D8C
	ldr r3,[pool_02323E28]	; 02323D8E
	and r6,r3	; 02323D90
	lsl r3,r5,#0x7	; 02323D92
	lsr r5,r3,#0x17	; 02323D94
	ldr r3,[sp,#0x0]	; 02323D96
	add r5,r5,r3	; 02323D98
	ldr r3,[pool_02323E2C]	; 02323D9A
	and r5,r3	; 02323D9C
	lsl r3,r5,#0x10	; 02323D9E
	orr r6,r3	; 02323DA0
	str r6,[r4,r0]	; 02323DA2
	ldrb r5,[r4,r0]	; 02323DA4
	ldr r3,[sp,#0x4]	; 02323DA6
	add r3,r5,r3	; 02323DA8
	strb r3,[r4,r0]	; 02323DAA
	ldr r0,[sp,#0x28]	; 02323DAC
	cmp r0,#0x0	; 02323DAE
	blt loc_02323DC4	; 02323DB0
	ldr r0,[r2,#0x4]	; 02323DB2
	ldr r3,[pool_02323E30]	; 02323DB4
	and r0,r3	; 02323DB6
	ldr r5,[sp,#0x28]	; 02323DB8
	mov r3,#0xf	; 02323DBA
	and r5,r3	; 02323DBC
	lsl r3,r5,#0xc	; 02323DBE
	orr r0,r3	; 02323DC0
	str r0,[r2,#0x4]	; 02323DC2
loc_02323DC4:
	ldr r0,[sp,#0x2c]	; 02323DC4
	cmp r0,#0x0	; 02323DC6
	blt loc_02323DDC	; 02323DC8
	ldr r0,[r2,#0x0]	; 02323DCA
	ldr r3,[pool_02323E34]	; 02323DCC
	and r0,r3	; 02323DCE
	ldr r5,[sp,#0x2c]	; 02323DD0
	mov r3,#0x3	; 02323DD2
	and r5,r3	; 02323DD4
	lsl r3,r5,#0xa	; 02323DD6
	orr r0,r3	; 02323DD8
	str r0,[r2,#0x0]	; 02323DDA
loc_02323DDC:
	ldr r0,[sp,#0x30]	; 02323DDC
	cmp r0,#0x0	; 02323DDE
	blt loc_02323DF4	; 02323DE0
	ldr r0,[r2,#0x4]	; 02323DE2
	ldr r3,[pool_02323E34]	; 02323DE4
	and r0,r3	; 02323DE6
	ldr r5,[sp,#0x30]	; 02323DE8
	mov r3,#0x3	; 02323DEA
	and r5,r3	; 02323DEC
	lsl r3,r5,#0xa	; 02323DEE
	orr r0,r3	; 02323DF0
	str r0,[r2,#0x4]	; 02323DF2
loc_02323DF4:
	ldr r0,[pool_02323E20]	; 02323DF4
	ldr r0,[r4,r0]	; 02323DF6
	add r2,r0,#0x1	; 02323DF8
	ldr r0,[pool_02323E20]	; 02323DFA
	str r2,[r4,r0]	; 02323DFC
	add r1,r1,#0x1	; 02323DFE
	add r7,#0xc	; 02323E00
loc_02323E02:
	ldr r0,[sp,#0x8]	; 02323E02
	cmp r1,r0	; 02323E04
	blt loc_02323D6A	; 02323E06
	mov r0,#0x1	; 02323E08
	add sp,#0x14	; 02323E0A
	pop {r4,r5,r6,r7}	; 02323E0C
	pop {r3}	; 02323E0E
	bx r3	; 02323E10
	.byte 0xC0, 0x46	; 02323E14
pool_02323E14:
loc_02323E14:
	.word 0x00000628	; 02323E14
pool_02323E18:
loc_02323E18:
	.word 0x00000608	; 02323E18
pool_02323E1C:
loc_02323E1C:
	.word 0x0000060C	; 02323E1C
pool_02323E20:
loc_02323E20:
	.word 0x00000600	; 02323E20
pool_02323E24:
loc_02323E24:
	.word 0xFFFFFC00	; 02323E24
pool_02323E28:
loc_02323E28:
	.word 0xFE00FFFF	; 02323E28
pool_02323E2C:
loc_02323E2C:
	.word 0x000001FF	; 02323E2C
pool_02323E30:
loc_02323E30:
	.word 0xFFFF0FFF	; 02323E30
pool_02323E34:
loc_02323E34:
	.word 0xFFFFF3FF	; 02323E34

; ===== function loc_02323E38 =====
loc_02323E38:
	ldr r0,[pool_02323E3C]	; 02323E38
	bx lr	; 02323E3A
pool_02323E3C:
loc_02323E3C:
	.word 0x02333A30	; 02323E3C

; ===== function loc_02323E40 =====
loc_02323E40:
	ldr r0,[pool_02323E44]	; 02323E40
	bx lr	; 02323E42
pool_02323E44:
loc_02323E44:
	.word 0x02333400	; 02323E44

; ===== function loc_02323E48 =====
loc_02323E48:
	push {lr}	; 02323E48
	sub sp,#0x4	; 02323E4A
	ldr r0,[pool_02323E70]	; 02323E4C
	ldr r0,[r0,#0x60]	; 02323E4E
	cmp r0,#0x0	; 02323E50
	beq loc_02323E68	; 02323E52
	ldr r0,[pool_02323E74]	; 02323E54
	mov r1,#0x0	; 02323E56
	ldr r2,[pool_02323E78]	; 02323E58
	bl loc_0232DC70	; 02323E5A
	ldr r0,[pool_02323E7C]	; 02323E5E
	mov r1,#0x0	; 02323E60
	ldr r2,[pool_02323E78]	; 02323E62
	bl loc_0232DC48	; 02323E64
loc_02323E68:
	add sp,#0x4	; 02323E68
	pop {r3}	; 02323E6A
	bx r3	; 02323E6C
	.byte 0xC0, 0x46	; 02323E70
pool_02323E70:
loc_02323E70:
	.word P1_BssStart + 0x3540	; 02323E70
pool_02323E74:
loc_02323E74:
	.word 0x02333400	; 02323E74
pool_02323E78:
loc_02323E78:
	.word 0x00000400	; 02323E78
pool_02323E7C:
loc_02323E7C:
	.word 0x02333A30	; 02323E7C

; ===== function loc_02323E80 =====
; 更新 UI 工作缓冲区、清理其数据缓存，并在 VBlank 前提交。
; Updates UI work buffers, cleans their D-cache, then commits before VBlank.
.func P1_RefreshFirmwareUiRenderBuffers
loc_02323E80:
	push {r4,r5,r6,r7,lr}	; 02323E80
	sub sp,#0xc	; 02323E82
	mov r0,#0xc0	; 02323E84
	str r0,[sp,#0x0]	; 02323E86
	ldr r0,[pool_02323F30]	; 02323E88
	ldr r3,[r0,#0x0]	; 02323E8A
	ldr r0,[sp,#0x0]	; 02323E8C
	ldr r2,[pool_02323F34]	; 02323E8E
	lsl r1,r3,#0x3	; 02323E90
	add r1,r2,r1	; 02323E92
	mov r2,#0x80	; 02323E94
	sub r2,r2,r3	; 02323E96
	lsl r2,r2,#0x3	; 02323E98
	blx loc_0232DE68	; 02323E9A
	mov r0,#0xc0	; 02323E9E
	str r0,[sp,#0x4]	; 02323EA0
	ldr r0,[pool_02323F38]	; 02323EA2
	ldr r3,[r0,#0x30]	; 02323EA4
	ldr r0,[sp,#0x4]	; 02323EA6
	ldr r2,[pool_02323F3C]	; 02323EA8
	lsl r1,r3,#0x3	; 02323EAA
	add r1,r2,r1	; 02323EAC
	mov r2,#0x80	; 02323EAE
	sub r2,r2,r3	; 02323EB0
	lsl r2,r2,#0x3	; 02323EB2
	blx loc_0232DE68	; 02323EB4
	mov r5,#0x0	; 02323EB8
	ldr r3,[pool_02323F34]	; 02323EBA
	ldr r0,[pool_02323F3C]	; 02323EBC
	ldr r7,[pool_02323F40]	; 02323EBE
loc_02323EC0:
	lsl r1,r5,#0x4	; 02323EC0
	add r4,r3,r1	; 02323EC2
	lsl r2,r5,#0x5	; 02323EC4
	add r1,r3,r2	; 02323EC6
	ldr r6,[pool_02323F44]	; 02323EC8
	ldr r6,[r4,r6]	; 02323ECA
	asr r6,r6,#0x4	; 02323ECC
	strh r6,[r1,#0x6]	; 02323ECE
	ldr r6,[pool_02323F48]	; 02323ED0
	ldr r6,[r4,r6]	; 02323ED2
	asr r6,r6,#0x4	; 02323ED4
	strh r6,[r1,#0xe]	; 02323ED6
	ldr r6,[pool_02323F4C]	; 02323ED8
	ldr r6,[r4,r6]	; 02323EDA
	asr r6,r6,#0x4	; 02323EDC
	strh r6,[r1,#0x16]	; 02323EDE
	ldr r6,[pool_02323F50]	; 02323EE0
	ldr r6,[r4,r6]	; 02323EE2
	asr r6,r6,#0x4	; 02323EE4
	strh r6,[r1,#0x1e]	; 02323EE6
	add r1,r0,r2	; 02323EE8
	ldr r2,[pool_02323F54]	; 02323EEA
	ldr r2,[r4,r2]	; 02323EEC
	asr r2,r2,#0x4	; 02323EEE
	strh r2,[r1,#0x6]	; 02323EF0
	ldr r2,[pool_02323F58]	; 02323EF2
	ldr r2,[r4,r2]	; 02323EF4
	asr r2,r2,#0x4	; 02323EF6
	strh r2,[r1,#0xe]	; 02323EF8
	ldr r2,[pool_02323F5C]	; 02323EFA
	ldr r2,[r4,r2]	; 02323EFC
	asr r2,r2,#0x4	; 02323EFE
	strh r2,[r1,#0x16]	; 02323F00
	ldr r2,[r4,r7]	; 02323F02
	asr r2,r2,#0x4	; 02323F04
	strh r2,[r1,#0x1e]	; 02323F06
	add r5,r5,#0x1	; 02323F08
	cmp r5,#0x20	; 02323F0A
	blt loc_02323EC0	; 02323F0C
	add r0,r3,#0x0	; 02323F0E
	ldr r1,[pool_02323F44]	; 02323F10
	blx P1_CleanDataCacheRange	; 02323F12
	ldr r0,[pool_02323F3C]	; 02323F16
	ldr r1,[pool_02323F44]	; 02323F18
	blx P1_CleanDataCacheRange	; 02323F1A
	mov r1,#0x1	; 02323F1E
	ldr r0,[pool_02323F38]	; 02323F20
	str r1,[r0,#0x60]	; 02323F22
	bl P1_SwiVBlankIntrWait	; 02323F24
	add sp,#0xc	; 02323F28
	pop {r4,r5,r6,r7}	; 02323F2A
	pop {r3}	; 02323F2C
	bx r3	; 02323F2E
.endfunc
pool_02323F30:
loc_02323F30:
	.word P1_BssStart + 0x2F40	; 02323F30
pool_02323F34:
loc_02323F34:
	.word 0x02333400	; 02323F34
pool_02323F38:
loc_02323F38:
	.word P1_BssStart + 0x3540	; 02323F38
pool_02323F3C:
loc_02323F3C:
	.word 0x02333A30	; 02323F3C
pool_02323F40:
loc_02323F40:
	.word 0x00000A3C	; 02323F40
pool_02323F44:
loc_02323F44:
	.word 0x00000400	; 02323F44
pool_02323F48:
loc_02323F48:
	.word 0x00000404	; 02323F48
pool_02323F4C:
loc_02323F4C:
	.word 0x00000408	; 02323F4C
pool_02323F50:
loc_02323F50:
	.word 0x0000040C	; 02323F50
pool_02323F54:
loc_02323F54:
	.word 0x00000A30	; 02323F54
pool_02323F58:
loc_02323F58:
	.word 0x00000A34	; 02323F58
pool_02323F5C:
loc_02323F5C:
	.word 0x00000A38	; 02323F5C

; ===== function loc_02323F60 =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02323F60:
loc_02323F60:
	mov r2,#0x0	; 02323F60
	ldr r1,[pool_02323F74]	; 02323F62
	str r2,[r1,#0x30]	; 02323F64
	ldr r0,[pool_02323F78]	; 02323F66
	str r2,[r0,#0x0]	; 02323F68
	str r2,[r1,#0x34]	; 02323F6A
	str r2,[r0,#0x4]	; 02323F6C
	str r2,[r1,#0x60]	; 02323F6E
	bx lr	; 02323F70
	.byte 0xC0, 0x46	; 02323F74
pool_02323F74:
loc_02323F74:
	.word P1_BssStart + 0x3540	; 02323F74
pool_02323F78:
loc_02323F78:
	.word P1_BssStart + 0x2F40	; 02323F78

; ===== function loc_02323F7C =====
loc_02323F7C:
	push {r4,r5,r6,lr}	; 02323F7C
	add r5,r0,#0x0	; 02323F7E
	add r4,r1,#0x0	; 02323F80
	ldr r0,[pool_02323FFC]	; 02323F82
	add r1,r5,r0	; 02323F84
	ldr r0,[r1,#0x0]	; 02323F86
	lsl r0,r0,#0x3	; 02323F88
	add r2,r5,r0	; 02323F8A
	ldr r0,[pool_02324000]	; 02323F8C
	str r4,[r2,r0]	; 02323F8E
	ldr r0,[pool_02324004]	; 02323F90
	ldr r0,[r5,r0]	; 02323F92
	ldr r1,[r1,#0x0]	; 02323F94
	lsl r1,r1,#0x3	; 02323F96
	add r2,r5,r1	; 02323F98
	ldr r1,[pool_02324008]	; 02323F9A
	str r0,[r2,r1]	; 02323F9C
	ldr r0,[pool_0232400C]	; 02323F9E
	cmp r5,r0	; 02323FA0
	bne loc_02323FC0	; 02323FA2
	add r0,r4,#0x0	; 02323FA4
	bl loc_023291B0	; 02323FA6
	add r6,r0,#0x0	; 02323FAA
	add r0,r4,#0x0	; 02323FAC
	bl loc_023291AC	; 02323FAE
	add r2,r0,#0x0	; 02323FB2
	add r0,r6,#0x0	; 02323FB4
	ldr r1,[pool_02324004]	; 02323FB6
	ldr r1,[r5,r1]	; 02323FB8
	bl loc_0232DC20	; 02323FBA
	b loc_02323FDA	; 02323FBE
loc_02323FC0:
	add r0,r4,#0x0	; 02323FC0
	bl loc_023291B0	; 02323FC2
	add r6,r0,#0x0	; 02323FC6
	add r0,r4,#0x0	; 02323FC8
	bl loc_023291AC	; 02323FCA
	add r2,r0,#0x0	; 02323FCE
	add r0,r6,#0x0	; 02323FD0
	ldr r1,[pool_02324004]	; 02323FD2
	ldr r1,[r5,r1]	; 02323FD4
	bl loc_0232DBF8	; 02323FD6
loc_02323FDA:
	add r0,r4,#0x0	; 02323FDA
	bl loc_023291AC	; 02323FDC
	ldr r1,[pool_02324004]	; 02323FE0
	add r1,r5,r1	; 02323FE2
	ldr r2,[r1,#0x0]	; 02323FE4
	add r0,r2,r0	; 02323FE6
	str r0,[r1,#0x0]	; 02323FE8
	ldr r0,[pool_02323FFC]	; 02323FEA
	add r0,r5,r0	; 02323FEC
	ldr r1,[r0,#0x0]	; 02323FEE
	add r1,r1,#0x1	; 02323FF0
	str r1,[r0,#0x0]	; 02323FF2
	pop {r4,r5,r6}	; 02323FF4
	pop {r3}	; 02323FF6
	bx r3	; 02323FF8
	.byte 0xC0, 0x46	; 02323FFC
pool_02323FFC:
loc_02323FFC:
	.word 0x00000628	; 02323FFC
pool_02324000:
loc_02324000:
	.word 0x00000608	; 02324000
pool_02324004:
loc_02324004:
	.word 0x0000062C	; 02324004
pool_02324008:
loc_02324008:
	.word 0x0000060C	; 02324008
pool_0232400C:
loc_0232400C:
	.word 0x02333400	; 0232400C

; ===== function loc_02324010 =====
loc_02324010:
	push {r4,r5,lr}	; 02324010
	sub sp,#0x4	; 02324012
	mov r5,#0x0	; 02324014
	add r3,r5,#0x0	; 02324016
	ldr r1,[pool_02324044]	; 02324018
	ldr r2,[pool_02324048]	; 0232401A
loc_0232401C:
	lsl r4,r5,#0x3	; 0232401C
	add r4,r0,r4	; 0232401E
	str r3,[r4,r1]	; 02324020
	str r3,[r4,r2]	; 02324022
	add r5,r5,#0x1	; 02324024
	cmp r5,#0x4	; 02324026
	blt loc_0232401C	; 02324028
	ldr r1,[pool_0232404C]	; 0232402A
	str r3,[r0,r1]	; 0232402C
	ldr r1,[pool_02324050]	; 0232402E
	str r3,[r0,r1]	; 02324030
	ldr r1,[pool_02324054]	; 02324032
	str r3,[r0,r1]	; 02324034
	ldr r1,[pool_02324058]	; 02324036
	str r3,[r0,r1]	; 02324038
	add sp,#0x4	; 0232403A
	pop {r4,r5}	; 0232403C
	pop {r3}	; 0232403E
	bx r3	; 02324040
	.byte 0xC0, 0x46	; 02324044
pool_02324044:
loc_02324044:
	.word 0x00000608	; 02324044
pool_02324048:
loc_02324048:
	.word 0x0000060C	; 02324048
pool_0232404C:
loc_0232404C:
	.word 0x00000628	; 0232404C
pool_02324050:
loc_02324050:
	.word 0x0000062C	; 02324050
pool_02324054:
loc_02324054:
	.word 0x00000600	; 02324054
pool_02324058:
loc_02324058:
	.word 0x00000604	; 02324058
	.byte 0x00, 0x04, 0x02, 0x0C, 0x05, 0x48, 0xC1, 0x88, 0x91, 0x43, 0xC1, 0x80, 0x81, 0x88, 0x91, 0x43	; 0232405C
	.byte 0x81, 0x80, 0x01, 0x89, 0x91, 0x43, 0x01, 0x81, 0x70, 0x47, 0xC0, 0x46, 0x64, 0x40, 0x33, 0x02	; 0232406C
P1_Entry_0232407C:
	mov r1,#0x0	; 0232407C
	ldr r0,[pool_02324084]	; 0232407E
	str r1,[r0,#0x24]	; 02324080
	bx lr	; 02324082
pool_02324084:
	.word P1_BssStart + 0x35A4	; 02324084
P1_Entry_02324088:
	mov r1,#0x1	; 02324088
	ldr r0,[pool_02324090]	; 0232408A
	str r1,[r0,#0x24]	; 0232408C
	bx lr	; 0232408E
pool_02324090:
	.word P1_BssStart + 0x35A4	; 02324090
P1_Entry_02324094:
	ldr r0,[pool_0232409C]	; 02324094
	ldr r0,[r0,#0x0]	; 02324096
	bx lr	; 02324098
	.byte 0xC0, 0x46	; 0232409A
pool_0232409C:
	.word P1_BssStart + 0x35A4	; 0232409C
P1_Entry_023240A0:
	ldr r1,[pool_023240A8]	; 023240A0
	strh r0,[r1,#0xa]	; 023240A2
	bx lr	; 023240A4
	.byte 0xC0, 0x46	; 023240A6
pool_023240A8:
	.word P1_BssStart + 0x35A4	; 023240A8
P1_Entry_023240AC:
	ldr r0,[pool_023240B4]	; 023240AC
	ldr r0,[r0,#0x18]	; 023240AE
	bx lr	; 023240B0
	.byte 0xC0, 0x46	; 023240B2
pool_023240B4:
	.word P1_BssStart + 0x35A4	; 023240B4

; ===== function loc_023240B8 =====
loc_023240B8:
	ldr r0,[pool_023240C0]	; 023240B8
	ldrh r0,[r0,#0x16]	; 023240BA
	bx lr	; 023240BC
	.byte 0xC0, 0x46	; 023240C0
pool_023240C0:
loc_023240C0:
	.word P1_BssStart + 0x35A4	; 023240C0

; ===== function loc_023240C4 =====
loc_023240C4:
	ldr r0,[pool_023240CC]	; 023240C4
	ldrh r0,[r0,#0x14]	; 023240C6
	bx lr	; 023240C8
	.byte 0xC0, 0x46	; 023240CC
pool_023240CC:
loc_023240CC:
	.word P1_BssStart + 0x35A4	; 023240CC

; ===== function loc_023240D0 =====
loc_023240D0:
	ldr r0,[pool_023240D8]	; 023240D0
	ldr r0,[r0,#0x1c]	; 023240D2
	bx lr	; 023240D4
	.byte 0xC0, 0x46	; 023240D8
pool_023240D8:
loc_023240D8:
	.word P1_BssStart + 0x35A4	; 023240D8

; ===== function loc_023240DC =====
loc_023240DC:
	ldr r0,[pool_023240E4]	; 023240DC
	ldrh r0,[r0,#0x20]	; 023240DE
	bx lr	; 023240E0
	.byte 0xC0, 0x46	; 023240E4
pool_023240E4:
loc_023240E4:
	.word P1_BssStart + 0x35A4	; 023240E4
	.byte 0x02, 0x49, 0x09, 0x89, 0x01, 0x40, 0x08, 0x1C, 0x70, 0x47, 0xC0, 0x46, 0x64, 0x40, 0x33, 0x02	; 023240F8

; ===== function loc_023240F8 =====
loc_023240F8:
	ldr r1,[pool_02324104]	; 023240F8
	ldrh r1,[r1,#0x6]	; 023240FA
	and r1,r0	; 023240FC
	add r0,r1,#0x0	; 023240FE
	bx lr	; 02324100
	.byte 0xC0, 0x46	; 02324104
pool_02324104:
loc_02324104:
	.word P1_BssStart + 0x35A4	; 02324104

; ===== function loc_02324108 =====
loc_02324108:
	ldr r1,[pool_02324114]	; 02324108
	ldrh r1,[r1,#0x4]	; 0232410A
	and r1,r0	; 0232410C
	add r0,r1,#0x0	; 0232410E
	bx lr	; 02324110
	.byte 0xC0, 0x46	; 02324114
pool_02324114:
loc_02324114:
	.word P1_BssStart + 0x35A4	; 02324114

; ===== function loc_02324118 =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02324118:
loc_02324118:
	push {r4,lr}	; 02324118
	sub sp,#0x10	; 0232411A
	ldr r0,[pool_02324204]	; 0232411C
	ldrh r1,[r0,#0x0]	; 0232411E
	ldr r0,[pool_02324208]	; 02324120
	ldrh r0,[r0,#0x0]	; 02324122
	orr r1,r0	; 02324124
	ldr r0,[pool_0232420C]	; 02324126
	eor r1,r0	; 02324128
	and r1,r0	; 0232412A
	lsl r0,r1,#0x10	; 0232412C
	lsr r3,r0,#0x10	; 0232412E
	ldr r0,[pool_02324210]	; 02324130
	ldrh r1,[r0,#0x6]	; 02324132
	add r2,r3,#0x0	; 02324134
	eor r2,r1	; 02324136
	add r1,r3,#0x0	; 02324138
	and r1,r2	; 0232413A
	strh r1,[r0,#0x4]	; 0232413C
	mvn r1,r3	; 0232413E
	and r1,r2	; 02324140
	strh r1,[r0,#0x8]	; 02324142
	strh r3,[r0,#0x6]	; 02324144
	ldrh r2,[r0,#0x6]	; 02324146
	ldrh r1,[r0,#0xa]	; 02324148
	and r2,r1	; 0232414A
	cmp r2,#0x0	; 0232414C
	beq loc_02324158	; 0232414E
	ldr r1,[r0,#0x0]	; 02324150
	add r1,r1,#0x1	; 02324152
	str r1,[r0,#0x0]	; 02324154
	b loc_0232415C	; 02324156
loc_02324158:
	mov r1,#0x0	; 02324158
	str r1,[r0,#0x0]	; 0232415A
loc_0232415C:
	ldr r0,[pool_02324210]	; 0232415C
	ldr r0,[r0,#0x24]	; 0232415E
	cmp r0,#0x0	; 02324160
	beq loc_023241FA	; 02324162
	add r4,sp,#0x0	; 02324164
loc_02324166:
	bl loc_0232EDB4	; 02324166
	add r0,r4,#0x0	; 0232416A
	bl loc_0232ED80	; 0232416C
	cmp r0,#0x0	; 02324170
	bne loc_02324166	; 02324172
	add r0,sp,#0x8	; 02324174
	add r1,sp,#0x0	; 02324176
	bl loc_0232EB0C	; 02324178
	add r0,sp,#0x0	; 0232417C
	ldrh r0,[r0,#0xe]	; 0232417E
	cmp r0,#0x0	; 02324180
	beq loc_0232419E	; 02324182
	ldr r3,[pool_02324214]	; 02324184
	add r2,sp,#0x8	; 02324186
	mov r1,#0x4	; 02324188
loc_0232418A:
	ldrh r0,[r3,#0x0]	; 0232418A
	add r3,r3,#0x2	; 0232418C
	strh r0,[r2,#0x0]	; 0232418E
	add r2,r2,#0x2	; 02324190
	sub r1,r1,#0x1	; 02324192
	cmp r1,#0x0	; 02324194
	bne loc_0232418A	; 02324196
	mov r1,#0x0	; 02324198
	add r0,sp,#0x0	; 0232419A
	strh r1,[r0,#0xc]	; 0232419C
loc_0232419E:
	add r0,sp,#0x0	; 0232419E
	ldrh r0,[r0,#0xc]	; 023241A0
	ldr r1,[pool_02324210]	; 023241A2
	ldrh r2,[r1,#0x10]	; 023241A4
	cmp r0,r2	; 023241A6
	beq loc_023241BE	; 023241A8
	cmp r0,#0x0	; 023241AA
	beq loc_023241B2	; 023241AC
	mov r2,#0x1	; 023241AE
	b loc_023241B4	; 023241B0
loc_023241B2:
	mov r2,#0x3	; 023241B2
loc_023241B4:
	ldr r1,[pool_02324210]	; 023241B4
	str r2,[r1,#0x1c]	; 023241B6
	mov r2,#0x0	; 023241B8
	str r2,[r1,#0x18]	; 023241BA
	b loc_023241D2	; 023241BC
loc_023241BE:
	cmp r0,#0x0	; 023241BE
	beq loc_023241CE	; 023241C0
	mov r2,#0x2	; 023241C2
	str r2,[r1,#0x1c]	; 023241C4
	ldr r2,[r1,#0x18]	; 023241C6
	add r2,r2,#0x1	; 023241C8
	str r2,[r1,#0x18]	; 023241CA
	b loc_023241D2	; 023241CC
loc_023241CE:
	mov r2,#0x0	; 023241CE
	str r2,[r1,#0x1c]	; 023241D0
loc_023241D2:
	cmp r0,#0x0	; 023241D2
	beq loc_023241E2	; 023241D4
	add r2,sp,#0x0	; 023241D6
	ldrh r3,[r2,#0x8]	; 023241D8
	ldr r1,[pool_02324210]	; 023241DA
	strh r3,[r1,#0x14]	; 023241DC
	ldrh r2,[r2,#0xa]	; 023241DE
	strh r2,[r1,#0x16]	; 023241E0
loc_023241E2:
	ldr r1,[pool_02324210]	; 023241E2
	strh r0,[r1,#0x20]	; 023241E4
	add r3,sp,#0x8	; 023241E6
	ldr r2,[pool_02324214]	; 023241E8
	mov r1,#0x4	; 023241EA
loc_023241EC:
	ldrh r0,[r3,#0x0]	; 023241EC
	add r3,r3,#0x2	; 023241EE
	strh r0,[r2,#0x0]	; 023241F0
	add r2,r2,#0x2	; 023241F2
	sub r1,r1,#0x1	; 023241F4
	cmp r1,#0x0	; 023241F6
	bne loc_023241EC	; 023241F8
loc_023241FA:
	add sp,#0x10	; 023241FA
	pop {r4}	; 023241FC
	pop {r3}	; 023241FE
	bx r3	; 02324200
	.byte 0xC0, 0x46	; 02324204
pool_02324204:
loc_02324204:
	.word REG_KEYINPUT	; 02324204
pool_02324208:
loc_02324208:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 02324208
pool_0232420C:
loc_0232420C:
	.word 0x00002FFF	; 0232420C
pool_02324210:
loc_02324210:
	.word P1_BssStart + 0x35A4	; 02324210
pool_02324214:
loc_02324214:
	.word P1_BssStart + 0x35B0	; 02324214

; ===== function loc_02324218 =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02324218:
loc_02324218:
	push {lr}	; 02324218
	sub sp,#0x4	; 0232421A
	bl loc_02324230	; 0232421C
	mov r1,#0x1	; 02324220
	ldr r0,[pool_0232422C]	; 02324222
	str r1,[r0,#0x24]	; 02324224
	add sp,#0x4	; 02324226
	pop {r3}	; 02324228
	bx r3	; 0232422A
pool_0232422C:
loc_0232422C:
	.word P1_BssStart + 0x35A4	; 0232422C

; ===== function loc_02324230 =====
loc_02324230:
	push {lr}	; 02324230
	sub sp,#0x4	; 02324232
	mov r0,#0x0	; 02324234
	str r0,[sp,#0x0]	; 02324236
	ldr r0,[sp,#0x0]	; 02324238
	ldr r1,[pool_02324248]	; 0232423A
	mov r2,#0x28	; 0232423C
	blx loc_0232DE68	; 0232423E
	add sp,#0x4	; 02324242
	pop {r3}	; 02324244
	bx r3	; 02324246
pool_02324248:
loc_02324248:
	.word 0x02334064	; 02324248

; ===== function loc_0232424C =====
loc_0232424C:
	push {lr}	; 0232424C
	sub sp,#0x4	; 0232424E
	bl loc_023242F4	; 02324250
	cmp r0,#0x0	; 02324254
	beq loc_02324262	; 02324256
	cmp r0,#0x1	; 02324258
	beq loc_02324262	; 0232425A
	cmp r0,#0x2	; 0232425C
	beq loc_02324266	; 0232425E
	b loc_0232426A	; 02324260
loc_02324262:
	mov r0,#0x3	; 02324262
	b loc_0232426C	; 02324264
loc_02324266:
	mov r0,#0xf	; 02324266
	b loc_0232426C	; 02324268
loc_0232426A:
	mov r0,#0x2	; 0232426A
loc_0232426C:
	add sp,#0x4	; 0232426C
	pop {r3}	; 0232426E
	bx r3	; 02324270
	.byte 0x00, 0x00	; 02324272
P1_Entry_02324274:
	push {r4,r5,lr}	; 02324274
	sub sp,#0x4	; 02324276
	add r5,r0,#0x0	; 02324278
	add r4,r1,#0x0	; 0232427A
	bl loc_02324304	; 0232427C
	cmp r0,#0x0	; 02324280
	bne P1_Entry_023242A8	; 02324282
	add r0,r5,#0x0	; 02324284
	add r1,r4,#0x0	; 02324286
	bl loc_023242F4	; 02324288
	cmp r0,#0x1	; 0232428C
	bne P1_Entry_023242AC	; 0232428E
	bl P1_Entry_023240AC	; 02324290
	cmp r0,#0x1e	; 02324294
	bls P1_Entry_023242AC	; 02324296
	bl P1_Entry_023240AC	; 02324298
	sub r0,#0x1e	; 0232429C
	mov r1,#0xa	; 0232429E
	blx P1_UnsignedDivMod	; 023242A0
	cmp r1,#0x0	; 023242A4
	bne P1_Entry_023242AC	; 023242A6
P1_Entry_023242A8:
	mov r0,#0x1	; 023242A8
	b P1_Entry_023242AE	; 023242AA
P1_Entry_023242AC:
	mov r0,#0x0	; 023242AC
P1_Entry_023242AE:
	add sp,#0x4	; 023242AE
	pop {r4,r5}	; 023242B0
	pop {r3}	; 023242B2
	bx r3	; 023242B4
	.byte 0x00, 0x00	; 023242B6
P1_Entry_023242B8:
	push {r4,lr}	; 023242B8
	add r4,r0,#0x0	; 023242BA
	bl loc_02324108	; 023242BC
	cmp r0,#0x0	; 023242C0
	bne P1_Entry_023242E6	; 023242C2
	add r0,r4,#0x0	; 023242C4
	bl loc_023240F8	; 023242C6
	cmp r0,#0x0	; 023242CA
	beq P1_Entry_023242EA	; 023242CC
	bl P1_Entry_02324094	; 023242CE
	cmp r0,#0x1e	; 023242D2
	bls P1_Entry_023242EA	; 023242D4
	bl P1_Entry_02324094	; 023242D6
	sub r0,#0x1e	; 023242DA
	mov r1,#0xa	; 023242DC
	blx P1_UnsignedDivMod	; 023242DE
	cmp r1,#0x0	; 023242E2
	bne P1_Entry_023242EA	; 023242E4
P1_Entry_023242E6:
	mov r0,#0x1	; 023242E6
	b P1_Entry_023242EC	; 023242E8
P1_Entry_023242EA:
	mov r0,#0x0	; 023242EA
P1_Entry_023242EC:
	pop {r4}	; 023242EC
	pop {r3}	; 023242EE
	bx r3	; 023242F0
	.byte 0x00, 0x00	; 023242F2

; ===== function loc_023242F4 =====
loc_023242F4:
	mov r2,#0x0	; 023242F4
	mvn r3,r2	; 023242F6
	ldr r2,[r0,#0x0]	; 023242F8
	cmp r2,r1	; 023242FA
	bne loc_02324300	; 023242FC
	ldr r3,[r0,#0x8]	; 023242FE
loc_02324300:
	add r0,r3,#0x0	; 02324300
	bx lr	; 02324302

; ===== function loc_02324304 =====
loc_02324304:
	ldr r2,[r0,#0x8]	; 02324304
	cmp r2,#0x0	; 02324306
	bne loc_02324314	; 02324308
	ldr r0,[r0,#0x0]	; 0232430A
	cmp r0,r1	; 0232430C
	bne loc_02324314	; 0232430E
	mov r0,#0x1	; 02324310
	bx lr	; 02324312
loc_02324314:
	mov r0,#0x0	; 02324314
	bx lr	; 02324316

; ===== function loc_02324318 =====
loc_02324318:
	ldr r2,[r0,#0x8]	; 02324318
	cmp r2,#0x3	; 0232431A
	bne loc_02324328	; 0232431C
	ldr r0,[r0,#0x4]	; 0232431E
	cmp r0,r1	; 02324320
	bne loc_02324328	; 02324322
	mov r0,#0x1	; 02324324
	bx lr	; 02324326
loc_02324328:
	mov r0,#0x0	; 02324328
	bx lr	; 0232432A

; ===== function loc_0232432C =====
loc_0232432C:
	push {r4,r5,r6,r7,lr}	; 0232432C
	sub sp,#0x4	; 0232432E
	add r5,r0,#0x0	; 02324330
	add r4,r1,#0x0	; 02324332
	bl loc_023240C4	; 02324334
	add r6,r0,#0x0	; 02324338
	bl loc_023240B8	; 0232433A
	add r7,r0,#0x0	; 0232433E
	bl loc_023240D0	; 02324340
	cmp r0,#0x1	; 02324344
	bne loc_02324368	; 02324346
	add r0,r4,#0x0	; 02324348
	add r1,r6,#0x0	; 0232434A
	add r2,r7,#0x0	; 0232434C
	bl loc_023291E0	; 0232434E
	str r0,[r5,#0x4]	; 02324352
	ldr r0,[r5,#0x4]	; 02324354
	str r0,[r5,#0x0]	; 02324356
	ldr r1,[r5,#0x0]	; 02324358
	mov r2,#0x0	; 0232435A
	mvn r0,r2	; 0232435C
	cmp r1,r0	; 0232435E
	bne loc_02324364	; 02324360
	add r2,r0,#0x0	; 02324362
loc_02324364:
	str r2,[r5,#0x8]	; 02324364
	b loc_023243CE	; 02324366
loc_02324368:
	ldr r1,[r5,#0x0]	; 02324368
	mov r0,#0x0	; 0232436A
	mvn r0,r0	; 0232436C
	cmp r1,r0	; 0232436E
	beq loc_02324398	; 02324370
	bl loc_023240D0	; 02324372
	cmp r0,#0x2	; 02324376
	bne loc_02324398	; 02324378
	add r0,r4,#0x0	; 0232437A
	add r1,r6,#0x0	; 0232437C
	add r2,r7,#0x0	; 0232437E
	bl loc_023291E0	; 02324380
	str r0,[r5,#0x4]	; 02324384
	ldr r1,[r5,#0x0]	; 02324386
	ldr r0,[r5,#0x4]	; 02324388
	cmp r1,r0	; 0232438A
	bne loc_02324392	; 0232438C
	mov r0,#0x1	; 0232438E
	b loc_02324394	; 02324390
loc_02324392:
	mov r0,#0x2	; 02324392
loc_02324394:
	str r0,[r5,#0x8]	; 02324394
	b loc_023243CE	; 02324396
loc_02324398:
	ldr r1,[r5,#0x0]	; 02324398
	mov r0,#0x0	; 0232439A
	mvn r0,r0	; 0232439C
	cmp r1,r0	; 0232439E
	beq loc_023243C8	; 023243A0
	bl loc_023240D0	; 023243A2
	cmp r0,#0x3	; 023243A6
	bne loc_023243C8	; 023243A8
	add r0,r4,#0x0	; 023243AA
	add r1,r6,#0x0	; 023243AC
	add r2,r7,#0x0	; 023243AE
	bl loc_023291E0	; 023243B0
	str r0,[r5,#0x4]	; 023243B4
	ldr r1,[r5,#0x0]	; 023243B6
	ldr r0,[r5,#0x4]	; 023243B8
	cmp r1,r0	; 023243BA
	bne loc_023243C2	; 023243BC
	mov r0,#0x3	; 023243BE
	b loc_023243C4	; 023243C0
loc_023243C2:
	mov r0,#0x2	; 023243C2
loc_023243C4:
	str r0,[r5,#0x8]	; 023243C4
	b loc_023243CE	; 023243C6
loc_023243C8:
	add r0,r5,#0x0	; 023243C8
	bl loc_023243D8	; 023243CA
loc_023243CE:
	add sp,#0x4	; 023243CE
	pop {r4,r5,r6,r7}	; 023243D0
	pop {r3}	; 023243D2
	bx r3	; 023243D4
	.byte 0x00, 0x00	; 023243D8

; ===== function loc_023243D8 =====
loc_023243D8:
	mov r1,#0x0	; 023243D8
	mvn r1,r1	; 023243DA
	str r1,[r0,#0x0]	; 023243DC
	str r1,[r0,#0x4]	; 023243DE
	str r1,[r0,#0x8]	; 023243E0
	bx lr	; 023243E2

; ===== function loc_023243E4 =====
	push {r4,r5,r6,r7,lr}	; 023243E4
	sub sp,#0x14	; 023243E6
	add r7,r0,#0x0	; 023243E8
	str r1,[sp,#0x8]	; 023243EA
	add r5,r2,#0x0	; 023243EC
	str r3,[sp,#0xc]	; 023243EE
	ldr r4,[sp,#0x28]	; 023243F0
	ldr r6,[sp,#0x2c]	; 023243F2
	b loc_02324408	; 023243F4
loc_023243F6:
	str r5,[sp,#0x0]	; 023243F6
	str r6,[sp,#0x4]	; 023243F8
	add r0,r7,#0x0	; 023243FA
	ldr r1,[sp,#0x8]	; 023243FC
	add r2,r5,#0x0	; 023243FE
	ldr r3,[sp,#0xc]	; 02324400
	bl loc_02324414	; 02324402
	add r5,r5,#0x1	; 02324406
loc_02324408:
	cmp r5,r4	; 02324408
	blt loc_023243F6	; 0232440A
	add sp,#0x14	; 0232440C
	pop {r4,r5,r6,r7}	; 0232440E
	pop {r3}	; 02324410
	bx r3	; 02324412

; ===== function loc_02324414 =====
loc_02324414:
	push {r4,r5,r6,r7,lr}	; 02324414
	sub sp,#0x1c	; 02324416
	str r0,[sp,#0x0]	; 02324418
	add r5,r1,#0x0	; 0232441A
	add r4,r2,#0x0	; 0232441C
	add r7,r3,#0x0	; 0232441E
	ldr r6,[sp,#0x30]	; 02324420
	ldr r0,[sp,#0x34]	; 02324422
	str r0,[sp,#0x34]	; 02324424
	add r0,r5,#0x0	; 02324426
	add r1,r7,#0x0	; 02324428
	bl loc_023244C8	; 0232442A
	str r0,[sp,#0x14]	; 0232442E
	add r0,r4,#0x0	; 02324430
	add r1,r6,#0x0	; 02324432
	bl loc_023244C8	; 02324434
	ldr r1,[sp,#0x14]	; 02324438
	cmp r1,r0	; 0232443A
	ble loc_02324480	; 0232443C
	cmp r5,r7	; 0232443E
	ble loc_0232444E	; 02324440
	add r0,r5,#0x0	; 02324442
	add r5,r7,#0x0	; 02324444
	add r7,r0,#0x0	; 02324446
	add r0,r4,#0x0	; 02324448
	add r4,r6,#0x0	; 0232444A
	add r6,r0,#0x0	; 0232444C
loc_0232444E:
	sub r0,r7,r5	; 0232444E
	str r0,[sp,#0x4]	; 02324450
	sub r0,r6,r4	; 02324452
	lsl r0,r0,#0xc	; 02324454
	ldr r1,[sp,#0x4]	; 02324456
	blx P1_SignedDivMod	; 02324458
	str r0,[sp,#0xc]	; 0232445C
	mov r6,#0x0	; 0232445E
	add r7,r6,#0x0	; 02324460
	b loc_02324478	; 02324462
loc_02324464:
	ldr r0,[sp,#0x0]	; 02324464
	add r1,r5,r6	; 02324466
	asr r2,r7,#0xc	; 02324468
	add r2,r4,r2	; 0232446A
	ldr r3,[sp,#0x34]	; 0232446C
	bl loc_023244D4	; 0232446E
	add r6,r6,#0x1	; 02324472
	ldr r0,[sp,#0xc]	; 02324474
	add r7,r7,r0	; 02324476
loc_02324478:
	ldr r0,[sp,#0x4]	; 02324478
	cmp r6,r0	; 0232447A
	blt loc_02324464	; 0232447C
	b loc_023244C0	; 0232447E
loc_02324480:
	cmp r4,r6	; 02324480
	ble loc_02324490	; 02324482
	add r0,r5,#0x0	; 02324484
	add r5,r7,#0x0	; 02324486
	add r7,r0,#0x0	; 02324488
	add r0,r4,#0x0	; 0232448A
	add r4,r6,#0x0	; 0232448C
	add r6,r0,#0x0	; 0232448E
loc_02324490:
	sub r0,r6,r4	; 02324490
	str r0,[sp,#0x8]	; 02324492
	sub r0,r7,r5	; 02324494
	lsl r0,r0,#0xc	; 02324496
	ldr r1,[sp,#0x8]	; 02324498
	blx P1_SignedDivMod	; 0232449A
	str r0,[sp,#0x10]	; 0232449E
	mov r6,#0x0	; 023244A0
	add r7,r6,#0x0	; 023244A2
	b loc_023244BA	; 023244A4
loc_023244A6:
	ldr r0,[sp,#0x0]	; 023244A6
	asr r1,r7,#0xc	; 023244A8
	add r1,r5,r1	; 023244AA
	add r2,r4,r6	; 023244AC
	ldr r3,[sp,#0x34]	; 023244AE
	bl loc_023244D4	; 023244B0
	add r6,r6,#0x1	; 023244B4
	ldr r0,[sp,#0x10]	; 023244B6
	add r7,r7,r0	; 023244B8
loc_023244BA:
	ldr r0,[sp,#0x8]	; 023244BA
	cmp r6,r0	; 023244BC
	blt loc_023244A6	; 023244BE
loc_023244C0:
	add sp,#0x1c	; 023244C0
	pop {r4,r5,r6,r7}	; 023244C2
	pop {r3}	; 023244C4
	bx r3	; 023244C6

; ===== function loc_023244C8 =====
loc_023244C8:
	cmp r0,r1	; 023244C8
	ble loc_023244D0	; 023244CA
	sub r0,r0,r1	; 023244CC
	bx lr	; 023244CE
loc_023244D0:
	sub r0,r1,r0	; 023244D0
	bx lr	; 023244D2

; ===== function loc_023244D4 =====
loc_023244D4:
	push {r4,r5,r6,r7,lr}	; 023244D4
	sub sp,#0x1c	; 023244D6
	add r5,r0,#0x0	; 023244D8
	add r4,r1,#0x0	; 023244DA
	add r6,r2,#0x0	; 023244DC
	str r3,[sp,#0x0]	; 023244DE
	asr r0,r4,#0x3	; 023244E0
	str r0,[sp,#0x4]	; 023244E2
	asr r0,r6,#0x3	; 023244E4
	str r0,[sp,#0x8]	; 023244E6
	mov r1,#0x3	; 023244E8
	add r0,r4,#0x0	; 023244EA
	str r0,[sp,#0xc]	; 023244EC
	and r0,r1	; 023244EE
	str r0,[sp,#0xc]	; 023244F0
	asr r7,r4,#0x2	; 023244F2
	mov r0,#0x1	; 023244F4
	and r7,r0	; 023244F6
	mov r1,#0x7	; 023244F8
	add r0,r6,#0x0	; 023244FA
	str r0,[sp,#0x10]	; 023244FC
	and r0,r1	; 023244FE
	str r0,[sp,#0x10]	; 02324500
	ldrh r0,[r5,#0x4]	; 02324502
	str r0,[sp,#0x14]	; 02324504
	lsl r0,r0,#0x4	; 02324506
	mov r1,#0x8	; 02324508
	blx P1_SignedDivMod	; 0232450A
	ldr r1,[r5,#0x0]	; 0232450E
	ldr r2,[sp,#0x14]	; 02324510
	cmp r4,r2	; 02324512
	bgt loc_0232454E	; 02324514
	ldrh r2,[r5,#0x6]	; 02324516
	cmp r6,r2	; 02324518
	bgt loc_0232454E	; 0232451A
	ldr r2,[sp,#0x4]	; 0232451C
	lsl r3,r2,#0x4	; 0232451E
	ldr r2,[sp,#0x8]	; 02324520
	mul r0,r2	; 02324522
	add r0,r3,r0	; 02324524
	lsl r0,r0,#0x1	; 02324526
	add r4,r1,r0	; 02324528
	ldr r0,[sp,#0x10]	; 0232452A
	lsl r0,r0,#0x1	; 0232452C
	add r0,r7,r0	; 0232452E
	lsl r3,r0,#0x1	; 02324530
	ldr r0,[sp,#0xc]	; 02324532
	lsl r2,r0,#0x2	; 02324534
	ldrh r1,[r4,r3]	; 02324536
	mov r0,#0xf	; 02324538
	add r5,r0,#0x0	; 0232453A
	lsl r5,r2	; 0232453C
	bic r1,r5	; 0232453E
	ldr r5,[sp,#0x0]	; 02324540
	lsl r5,r5,#0x18	; 02324542
	lsr r5,r5,#0x18	; 02324544
	and r5,r0	; 02324546
	lsl r5,r2	; 02324548
	orr r1,r5	; 0232454A
	strh r1,[r4,r3]	; 0232454C
loc_0232454E:
	add sp,#0x1c	; 0232454E
	pop {r4,r5,r6,r7}	; 02324550
	pop {r3}	; 02324552
	bx r3	; 02324554
	.byte 0x00, 0x00	; 02324558

; ===== function loc_02324558 =====
loc_02324558:
	ldr r0,[pool_0232455C]	; 02324558
	bx lr	; 0232455A
pool_0232455C:
loc_0232455C:
	.word 0x0233408C	; 0232455C

; ===== function loc_02324560 =====
loc_02324560:
	push {lr}	; 02324560
	sub sp,#0x4	; 02324562
	cmp r0,#0x8	; 02324564
	bhi loc_023245B6	; 02324566
	add r0,r0,r0	; 02324568
P1_SwitchIndexPC_02324568:
	add r0,pc	; 0232456A
	ldrh r0,[r0,#(P1_SwitchTable_02324568 - (P1_SwitchIndexPC_02324568 + 4))]	; 0232456C
	lsl r0,r0,#0x10	; 0232456E
	asr r0,r0,#0x10	; 02324570
P1_SwitchTargetPC_02324568:
	add r0,pc	; 02324572
	bx r0	; 02324574
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02324568:
	.halfword (loc_023245B6 + 1) - (P1_SwitchTargetPC_02324568 + 4)
	.halfword (loc_02324588 + 1) - (P1_SwitchTargetPC_02324568 + 4)
	.halfword (loc_02324594 + 1) - (P1_SwitchTargetPC_02324568 + 4)
	.halfword (loc_023245B6 + 1) - (P1_SwitchTargetPC_02324568 + 4)
	.halfword (loc_023245A0 + 1) - (P1_SwitchTargetPC_02324568 + 4)
	.halfword (loc_023245B6 + 1) - (P1_SwitchTargetPC_02324568 + 4)
	.halfword (loc_023245B6 + 1) - (P1_SwitchTargetPC_02324568 + 4)
	.halfword (loc_023245B6 + 1) - (P1_SwitchTargetPC_02324568 + 4)
	.halfword (loc_023245AC + 1) - (P1_SwitchTargetPC_02324568 + 4)
P1_SwitchTable_02324568End:
loc_02324588:
	ldr r0,[pool_023245BC]	; 02324588
	mov r1,#0x0	; 0232458A
	ldr r2,[pool_023245C0]	; 0232458C
	bl loc_0232DBA8	; 0232458E
	b loc_023245B6	; 02324592
loc_02324594:
	ldr r0,[pool_023245BC]	; 02324594
	mov r1,#0x0	; 02324596
	ldr r2,[pool_023245C0]	; 02324598
	bl loc_0232DB58	; 0232459A
	b loc_023245B6	; 0232459E
loc_023245A0:
	ldr r0,[pool_023245BC]	; 023245A0
	mov r1,#0x0	; 023245A2
	ldr r2,[pool_023245C0]	; 023245A4
	bl loc_0232DB08	; 023245A6
	b loc_023245B6	; 023245AA
loc_023245AC:
	ldr r0,[pool_023245BC]	; 023245AC
	mov r1,#0x0	; 023245AE
	ldr r2,[pool_023245C0]	; 023245B0
	bl loc_0232DAB8	; 023245B2
loc_023245B6:
	add sp,#0x4	; 023245B6
	pop {r3}	; 023245B8
	bx r3	; 023245BA
pool_023245BC:
loc_023245BC:
	.word 0x0233408C	; 023245BC
pool_023245C0:
loc_023245C0:
	.word 0x00000600	; 023245C0

; ===== function loc_023245C4 =====
P1_Entry_023245C4:
	push {lr}	; 023245C4
	sub sp,#0x4	; 023245C6
	mov r0,#0x0	; 023245C8
	str r0,[sp,#0x0]	; 023245CA
	ldr r0,[sp,#0x0]	; 023245CC
	ldr r1,[pool_023245E4]	; 023245CE
	ldr r2,[pool_023245E8]	; 023245D0
	blx loc_0232DE68	; 023245D2
	ldr r0,[pool_023245E4]	; 023245D6
	ldr r1,[pool_023245E8]	; 023245D8
	blx P1_CleanDataCacheRange	; 023245DA
	add sp,#0x4	; 023245DE
	pop {r3}	; 023245E0
	bx r3	; 023245E2
pool_023245E4:
loc_023245E4:
	.word 0x0233408C	; 023245E4
pool_023245E8:
loc_023245E8:
	.word 0x00000600	; 023245E8

; ===== function loc_023245EC =====
loc_023245EC:
	push {r4,r5,r6,r7,lr}	; 023245EC
	sub sp,#0x54	; 023245EE
	add r5,r0,#0x0	; 023245F0
	add r4,r1,#0x0	; 023245F2
	add r7,r2,#0x0	; 023245F4
	str r3,[sp,#0x20]	; 023245F6
	ldr r0,[sp,#0x74]	; 023245F8
	str r0,[sp,#0x74]	; 023245FA
	ldr r1,[pool_02324738]	; 023245FC
	ldrh r2,[r1,#0x0]	; 023245FE
	add r0,sp,#0x38	; 02324600
	strh r2,[r0,#0x18]	; 02324602
	ldrh r1,[r1,#0x2]	; 02324604
	strh r1,[r0,#0x1a]	; 02324606
	ldr r0,[sp,#0x68]	; 02324608
	ldr r1,[pool_0232473C]	; 0232460A
	cmp r0,r1	; 0232460C
	bne loc_0232462A	; 0232460E
	add r0,r7,#0x0	; 02324610
	lsl r1,r3,#0	; 02324612
	bl loc_02329188	; 02324614
	ldr r0,[r0,#0x8]	; 02324618
	cmp r0,#0x0	; 0232461A
	beq loc_02324624	; 0232461C
	add r0,r7,r0	; 0232461E
	str r0,[sp,#0x28]	; 02324620
	b loc_0232463A	; 02324622
loc_02324624:
	add r0,sp,#0x50	; 02324624
	str r0,[sp,#0x28]	; 02324626
	b loc_0232463A	; 02324628
loc_0232462A:
	bl loc_02324D9C	; 0232462A
	str r0,[sp,#0x28]	; 0232462E
	ldrh r0,[r0,#0x0]	; 02324630
	cmp r0,#0x0	; 02324632
	bne loc_0232463A	; 02324634
	add r0,sp,#0x50	; 02324636
	str r0,[sp,#0x28]	; 02324638
loc_0232463A:
	ldr r0,[sp,#0x6c]	; 0232463A
	cmp r0,#0x0	; 0232463C
	beq loc_02324642	; 0232463E
	str r0,[sp,#0x28]	; 02324640
loc_02324642:
	add r0,sp,#0x48	; 02324642
	str r0,[sp,#0x0]	; 02324644
	add r0,sp,#0x4c	; 02324646
	str r0,[sp,#0x4]	; 02324648
	ldr r0,[sp,#0x28]	; 0232464A
	str r0,[sp,#0x8]	; 0232464C
	add r0,r7,#0x0	; 0232464E
	ldr r1,[sp,#0x20]	; 02324650
	add r2,sp,#0x40	; 02324652
	add r3,sp,#0x44	; 02324654
	bl loc_02324868	; 02324656
	str r5,[r4,#0x24]	; 0232465A
	str r7,[r4,#0x20]	; 0232465C
	ldr r0,[sp,#0x68]	; 0232465E
	strh r0,[r4,#0x1a]	; 02324660
	ldr r0,[sp,#0x20]	; 02324662
	strh r0,[r4,#0x1c]	; 02324664
	mov r1,#0x0	; 02324666
	add r0,r4,#0x0	; 02324668
	add r0,#0x28	; 0232466A
	strb r1,[r0,#0x0]	; 0232466C
	add r0,r7,#0x0	; 0232466E
	ldr r1,[sp,#0x20]	; 02324670
	bl loc_02329188	; 02324672
	ldrh r0,[r0,#0x6]	; 02324676
	lsl r0,r0,#0x14	; 02324678
	lsr r0,r0,#0x1c	; 0232467A
	strh r0,[r4,#0x16]	; 0232467C
	ldr r0,[sp,#0x40]	; 0232467E
	strh r0,[r4,#0x8]	; 02324680
	ldr r0,[sp,#0x44]	; 02324682
	strh r0,[r4,#0xa]	; 02324684
	ldr r0,[sp,#0x48]	; 02324686
	strb r0,[r4,#0xc]	; 02324688
	ldr r0,[sp,#0x4c]	; 0232468A
	strb r0,[r4,#0xd]	; 0232468C
	ldr r0,[sp,#0x70]	; 0232468E
	cmp r0,#0x0	; 02324690
	beq loc_023246C4	; 02324692
	add r0,r5,#0x0	; 02324694
	add r1,r4,#0x0	; 02324696
	bl loc_02329660	; 02324698
	ldrh r0,[r5,#0xe]	; 0232469C
	strh r0,[r4,#0x14]	; 0232469E
	ldr r0,[sp,#0x48]	; 023246A0
	ldr r1,[sp,#0x4c]	; 023246A2
	bl loc_023248DC	; 023246A4
	str r0,[r4,#0x10]	; 023246A8
	ldr r0,[r4,#0x10]	; 023246AA
	add r1,sp,#0x38	; 023246AC
	add r2,sp,#0x3c	; 023246AE
	bl loc_0232494C	; 023246B0
	ldr r0,[sp,#0x48]	; 023246B4
	sub r0,r0,#0x1	; 023246B6
	ldr r1,[sp,#0x38]	; 023246B8
	blx P1_SignedDivMod	; 023246BA
	add r0,r0,#0x1	; 023246BE
	strh r0,[r4,#0x18]	; 023246C0
	b loc_023246CE	; 023246C2
loc_023246C4:
	ldr r0,[r4,#0x10]	; 023246C4
	add r1,sp,#0x38	; 023246C6
	add r2,sp,#0x3c	; 023246C8
	bl loc_0232494C	; 023246CA
loc_023246CE:
	ldrh r0,[r4,#0x14]	; 023246CE
	str r0,[sp,#0x34]	; 023246D0
	mov r0,#0x0	; 023246D2
	str r0,[sp,#0x24]	; 023246D4
	str r0,[sp,#0x2c]	; 023246D6
	b loc_0232471C	; 023246D8
loc_023246DA:
	ldr r0,[sp,#0x38]	; 023246DA
	str r0,[sp,#0x30]	; 023246DC
	ldr r0,[sp,#0x2c]	; 023246DE
	str r0,[sp,#0x0]	; 023246E0
	ldr r0,[sp,#0x30]	; 023246E2
	str r0,[sp,#0x4]	; 023246E4
	ldr r0,[sp,#0x3c]	; 023246E6
	str r0,[sp,#0x8]	; 023246E8
	ldr r0,[sp,#0x34]	; 023246EA
	str r0,[sp,#0xc]	; 023246EC
	ldr r0,[sp,#0x40]	; 023246EE
	str r0,[sp,#0x10]	; 023246F0
	ldr r0,[sp,#0x44]	; 023246F2
	str r0,[sp,#0x14]	; 023246F4
	ldr r0,[sp,#0x28]	; 023246F6
	str r0,[sp,#0x18]	; 023246F8
	ldr r0,[sp,#0x74]	; 023246FA
	str r0,[sp,#0x1c]	; 023246FC
	add r0,r5,#0x0	; 023246FE
	add r1,r7,#0x0	; 02324700
	ldr r2,[sp,#0x20]	; 02324702
	ldr r6,[sp,#0x24]	; 02324704
	ldr r3,[sp,#0x30]	; 02324706
	mul r3,r6	; 02324708
	str r3,[sp,#0x30]	; 0232470A
	bl loc_02324740	; 0232470C
	ldr r1,[sp,#0x34]	; 02324710
	add r0,r1,r0	; 02324712
	str r0,[sp,#0x34]	; 02324714
	ldr r0,[sp,#0x24]	; 02324716
	add r0,r0,#0x1	; 02324718
	str r0,[sp,#0x24]	; 0232471A
loc_0232471C:
	ldrh r1,[r4,#0x18]	; 0232471C
	ldr r0,[sp,#0x24]	; 0232471E
	cmp r0,r1	; 02324720
	blt loc_023246DA	; 02324722
	ldr r0,[sp,#0x70]	; 02324724
	cmp r0,#0x0	; 02324726
	beq loc_0232472E	; 02324728
	ldr r0,[sp,#0x34]	; 0232472A
	strh r0,[r5,#0xe]	; 0232472C
loc_0232472E:
	add sp,#0x54	; 0232472E
	pop {r4,r5,r6,r7}	; 02324730
	pop {r3}	; 02324732
	bx r3	; 02324734
	.byte 0xC0, 0x46	; 02324738
pool_02324738:
loc_02324738:
	.word P1_Data_02330748	; 02324738
pool_0232473C:
loc_0232473C:
	.word 0x0000FFFF	; 0232473C

; ===== function loc_02324740 =====
loc_02324740:
	push {r4,r5,r6,r7,lr}	; 02324740
	sub sp,#0x34	; 02324742
	add r5,r0,#0x0	; 02324744
	str r1,[sp,#0x10]	; 02324746
	str r2,[sp,#0x14]	; 02324748
	str r3,[sp,#0x18]	; 0232474A
	ldr r0,[sp,#0x4c]	; 0232474C
	mov r1,#0x8	; 0232474E
	blx P1_SignedDivMod	; 02324750
	add r6,r0,#0x0	; 02324754
	ldr r0,[sp,#0x50]	; 02324756
	mov r1,#0x8	; 02324758
	blx P1_SignedDivMod	; 0232475A
	mul r6,r0	; 0232475E
	ldr r1,[sp,#0x54]	; 02324760
	ldrh r0,[r5,#0xc]	; 02324762
	sub r0,r1,r0	; 02324764
	lsl r4,r0,#0x7	; 02324766
	bl loc_02324C68	; 02324768
	add r7,r0,#0x0	; 0232476C
	ldr r0,[sp,#0x10]	; 0232476E
	ldr r1,[sp,#0x14]	; 02324770
	bl loc_02329188	; 02324772
	mov r0,#0x0	; 02324776
	str r0,[sp,#0x20]	; 02324778
	ldr r0,[sp,#0x4c]	; 0232477A
	ldr r1,[sp,#0x50]	; 0232477C
	mul r0,r1	; 0232477E
	mov r1,#0x2	; 02324780
	blx P1_SignedDivMod	; 02324782
	add r2,r0,#0x0	; 02324786
	ldr r0,[sp,#0x20]	; 02324788
	ldr r1,[r5,#0x14]	; 0232478A
	add r1,r1,r4	; 0232478C
	blx loc_0232DE68	; 0232478E
	mov r0,#0x0	; 02324792
	str r0,[sp,#0x0]	; 02324794
	str r7,[sp,#0x4]	; 02324796
	add r0,sp,#0x24	; 02324798
	ldr r1,[r5,#0x14]	; 0232479A
	add r1,r1,r4	; 0232479C
	ldr r2,[sp,#0x4c]	; 0232479E
	lsl r2,r2,#0x10	; 023247A0
	lsr r2,r2,#0x10	; 023247A2
	ldr r3,[sp,#0x50]	; 023247A4
	lsl r3,r3,#0x10	; 023247A6
	lsr r3,r3,#0x10	; 023247A8
	bl loc_02329018	; 023247AA
	ldr r0,[sp,#0x10]	; 023247AE
	ldr r1,[sp,#0x14]	; 023247B0
	bl loc_02329188	; 023247B2
	add r4,r0,#0x0	; 023247B6
	add r5,sp,#0x1c	; 023247B8
	ldrh r1,[r4,#0x0]	; 023247BA
	add r0,sp,#0x1c	; 023247BC
	strh r1,[r0,#0x0]	; 023247BE
	mov r0,#0x0	; 023247C0
	ldrsh r1,[r5,r0]	; 023247C2
	add r3,r1,#0x0	; 023247C4
	ldr r0,[pool_02324860]	; 023247C6
	and r3,r0	; 023247C8
	lsl r0,r1,#0x14	; 023247CA
	asr r2,r0,#0x14	; 023247CC
	ldr r1,[sp,#0x58]	; 023247CE
	ldr r0,[sp,#0x18]	; 023247D0
	add r0,r1,r0	; 023247D2
	sub r0,r2,r0	; 023247D4
	lsl r0,r0,#0x10	; 023247D6
	asr r1,r0,#0x10	; 023247D8
	ldr r0,[pool_02324864]	; 023247DA
	and r1,r0	; 023247DC
	orr r3,r1	; 023247DE
	strh r3,[r5,#0x0]	; 023247E0
	add r5,sp,#0x1c	; 023247E2
	add r5,#0x2	; 023247E4
	ldrh r1,[r4,#0x2]	; 023247E6
	add r0,sp,#0x1c	; 023247E8
	strh r1,[r0,#0x2]	; 023247EA
	mov r0,#0x0	; 023247EC
	ldrsh r1,[r5,r0]	; 023247EE
	add r3,r1,#0x0	; 023247F0
	ldr r0,[pool_02324860]	; 023247F2
	and r3,r0	; 023247F4
	lsl r0,r1,#0x14	; 023247F6
	asr r2,r0,#0x14	; 023247F8
	ldr r1,[sp,#0x5c]	; 023247FA
	ldr r0,[sp,#0x48]	; 023247FC
	add r0,r1,r0	; 023247FE
	sub r0,r2,r0	; 02324800
	lsl r0,r0,#0x10	; 02324802
	asr r1,r0,#0x10	; 02324804
	ldr r0,[pool_02324864]	; 02324806
	and r1,r0	; 02324808
	orr r3,r1	; 0232480A
	strh r3,[r5,#0x0]	; 0232480C
	ldr r0,[sp,#0x64]	; 0232480E
	mov r1,#0x0	; 02324810
	mvn r1,r1	; 02324812
	cmp r0,r1	; 02324814
	bne loc_0232481A	; 02324816
	ldrb r0,[r4,#0x6]	; 02324818
loc_0232481A:
	mov r1,#0x4	; 0232481A
	ldrsb r1,[r4,r1]	; 0232481C
	str r1,[sp,#0x0]	; 0232481E
	mov r1,#0x5	; 02324820
	ldrsb r1,[r4,r1]	; 02324822
	str r1,[sp,#0x4]	; 02324824
	ldr r1,[sp,#0x60]	; 02324826
	str r1,[sp,#0x8]	; 02324828
	str r0,[sp,#0xc]	; 0232482A
	ldrh r0,[r4,#0x6]	; 0232482C
	lsl r0,r0,#0x10	; 0232482E
	lsr r0,r0,#0x1c	; 02324830
	lsl r0,r0,#0x5	; 02324832
	add r0,r7,r0	; 02324834
	add r1,sp,#0x24	; 02324836
	mov r4,sp	; 02324838
	sub r4,r4,#0x4	; 0232483A
	add r5,sp,#0x1c	; 0232483C
	ldrh r2,[r5,#0x0]	; 0232483E
	strh r2,[r4,#0x0]	; 02324840
	add r3,r4,#0x0	; 02324842
	ldmia r3!,{r2}	; 02324844
	ldrh r3,[r5,#0x2]	; 02324846
	strh r3,[r4,#0x0]	; 02324848
	ldmia r4!,{r3}	; 0232484A
	bl loc_02328CB8	; 0232484C
	add r0,r6,#0x0	; 02324850
	mov r1,#0x4	; 02324852
	blx P1_SignedDivMod	; 02324854
	add sp,#0x34	; 02324858
	pop {r4,r5,r6,r7}	; 0232485A
	pop {r3}	; 0232485C
	bx r3	; 0232485E
pool_02324860:
loc_02324860:
	.word 0xFFFFF000	; 02324860
pool_02324864:
loc_02324864:
	.word 0x00000FFF	; 02324864

; ===== function loc_02324868 =====
loc_02324868:
	push {r4,r5,r6,r7,lr}	; 02324868
	sub sp,#0x4	; 0232486A
	add r7,r2,#0x0	; 0232486C
	str r3,[sp,#0x0]	; 0232486E
	ldr r5,[sp,#0x18]	; 02324870
	ldr r6,[sp,#0x1c]	; 02324872
	bl loc_02329188	; 02324874
	add r4,r0,#0x0	; 02324878
	bl loc_02324C68	; 0232487A
	ldrh r1,[r4,#0x6]	; 0232487E
	lsl r1,r1,#0x10	; 02324880
	lsr r1,r1,#0x1c	; 02324882
	lsl r1,r1,#0x5	; 02324884
	add r0,r0,r1	; 02324886
	ldr r1,[sp,#0x20]	; 02324888
	mov r2,#0x4	; 0232488A
	ldrsb r2,[r4,r2]	; 0232488C
	bl loc_02328C08	; 0232488E
	str r0,[r5,#0x0]	; 02324892
	bl loc_02324C68	; 02324894
	ldrh r1,[r4,#0x6]	; 02324898
	lsl r1,r1,#0x10	; 0232489A
	lsr r1,r1,#0x1c	; 0232489C
	lsl r1,r1,#0x5	; 0232489E
	add r0,r0,r1	; 023248A0
	ldr r1,[sp,#0x20]	; 023248A2
	mov r2,#0x5	; 023248A4
	ldrsb r2,[r4,r2]	; 023248A6
	bl loc_02328BE8	; 023248A8
	str r0,[r6,#0x0]	; 023248AC
	mov r1,sp	; 023248AE
	sub r1,r1,#0x4	; 023248B0
	ldrh r0,[r4,#0x0]	; 023248B2
	strh r0,[r1,#0x0]	; 023248B4
	ldmia r1!,{r0}	; 023248B6
	ldr r1,[r5,#0x0]	; 023248B8
	bl loc_023290D0	; 023248BA
	str r0,[r7,#0x0]	; 023248BE
	mov r1,sp	; 023248C0
	sub r1,r1,#0x4	; 023248C2
	ldrh r0,[r4,#0x2]	; 023248C4
	strh r0,[r1,#0x0]	; 023248C6
	ldmia r1!,{r0}	; 023248C8
	ldr r1,[r6,#0x0]	; 023248CA
	bl loc_02329098	; 023248CC
	ldr r1,[sp,#0x0]	; 023248D0
	str r0,[r1,#0x0]	; 023248D2
	add sp,#0x4	; 023248D4
	pop {r4,r5,r6,r7}	; 023248D6
	pop {r3}	; 023248D8
	bx r3	; 023248DA

; ===== function loc_023248DC =====
loc_023248DC:
	push {r4,r5,lr}	; 023248DC
	sub sp,#0x4	; 023248DE
	add r5,r1,#0x0	; 023248E0
	sub r0,r0,#0x1	; 023248E2
	mov r1,#0x8	; 023248E4
	blx P1_SignedDivMod	; 023248E6
	add r4,r0,#0x1	; 023248EA
	sub r0,r5,#0x1	; 023248EC
	mov r1,#0x8	; 023248EE
	blx P1_SignedDivMod	; 023248F0
	add r0,r0,#0x1	; 023248F4
	cmp r4,#0x2	; 023248F6
	bgt loc_02324906	; 023248F8
	cmp r0,#0x2	; 023248FA
	bgt loc_02324902	; 023248FC
	ldr r0,[pool_02324938]	; 023248FE
	b loc_02324930	; 02324900
loc_02324902:
	ldr r0,[pool_0232493C]	; 02324902
	b loc_02324930	; 02324904
loc_02324906:
	cmp r4,#0x4	; 02324906
	bgt loc_0232491E	; 02324908
	cmp r0,#0x2	; 0232490A
	bgt loc_02324912	; 0232490C
	ldr r0,[pool_02324940]	; 0232490E
	b loc_02324930	; 02324910
loc_02324912:
	cmp r0,#0x4	; 02324912
	bgt loc_0232491A	; 02324914
	ldr r0,[pool_0232493C]	; 02324916
	b loc_02324930	; 02324918
loc_0232491A:
	ldr r0,[pool_02324944]	; 0232491A
	b loc_02324930	; 0232491C
loc_0232491E:
	cmp r0,#0x2	; 0232491E
	bgt loc_02324926	; 02324920
	ldr r0,[pool_02324940]	; 02324922
	b loc_02324930	; 02324924
loc_02324926:
	cmp r0,#0x4	; 02324926
	bgt loc_0232492E	; 02324928
	ldr r0,[pool_02324948]	; 0232492A
	b loc_02324930	; 0232492C
loc_0232492E:
	ldr r0,[pool_02324944]	; 0232492E
loc_02324930:
	add sp,#0x4	; 02324930
	pop {r4,r5}	; 02324932
	pop {r3}	; 02324934
	bx r3	; 02324936
pool_02324938:
loc_02324938:
	.word 0x40000000	; 02324938
pool_0232493C:
loc_0232493C:
	.word 0x80000000	; 0232493C
pool_02324940:
loc_02324940:
	.word 0x80004000	; 02324940
pool_02324944:
loc_02324944:
	.word 0xC0000000	; 02324944
pool_02324948:
loc_02324948:
	.word 0xC0004000	; 02324948

; ===== function loc_0232494C =====
loc_0232494C:
	push {r4,lr}	; 0232494C
	ldr r4,[pool_02324A10]	; 0232494E
	cmp r0,r4	; 02324950
	bgt loc_0232498A	; 02324952
	cmp r0,r4	; 02324954
	bge loc_02324A02	; 02324956
	ldr r4,[pool_02324A14]	; 02324958
	cmp r0,r4	; 0232495A
	bgt loc_02324976	; 0232495C
	cmp r0,r4	; 0232495E
	bge loc_023249FC	; 02324960
	ldr r4,[pool_02324A18]	; 02324962
	cmp r0,r4	; 02324964
	bgt loc_0232496E	; 02324966
	cmp r0,r4	; 02324968
	beq loc_023249CC	; 0232496A
	b loc_02324A06	; 0232496C
loc_0232496E:
	ldr r4,[pool_02324A1C]	; 0232496E
	cmp r0,r4	; 02324970
	beq loc_023249E4	; 02324972
	b loc_02324A06	; 02324974
loc_02324976:
	ldr r4,[pool_02324A20]	; 02324976
	cmp r0,r4	; 02324978
	bgt loc_02324982	; 0232497A
	cmp r0,r4	; 0232497C
	beq loc_023249D2	; 0232497E
	b loc_02324A06	; 02324980
loc_02324982:
	ldr r4,[pool_02324A24]	; 02324982
	cmp r0,r4	; 02324984
	beq loc_023249EA	; 02324986
	b loc_02324A06	; 02324988
loc_0232498A:
	ldr r4,[pool_02324A28]	; 0232498A
	cmp r0,r4	; 0232498C
	bgt loc_023249A6	; 0232498E
	cmp r0,r4	; 02324990
	bge loc_023249F0	; 02324992
	cmp r0,#0x0	; 02324994
	bgt loc_0232499E	; 02324996
	cmp r0,#0x0	; 02324998
	beq loc_023249C0	; 0232499A
	b loc_02324A06	; 0232499C
loc_0232499E:
	ldr r4,[pool_02324A2C]	; 0232499E
	cmp r0,r4	; 023249A0
	beq loc_023249D8	; 023249A2
	b loc_02324A06	; 023249A4
loc_023249A6:
	ldr r4,[pool_02324A30]	; 023249A6
	cmp r0,r4	; 023249A8
	bgt loc_023249B8	; 023249AA
	cmp r0,r4	; 023249AC
	bge loc_023249DE	; 023249AE
	ldr r4,[pool_02324A34]	; 023249B0
	cmp r0,r4	; 023249B2
	beq loc_023249C6	; 023249B4
	b loc_02324A06	; 023249B6
loc_023249B8:
	ldr r4,[pool_02324A38]	; 023249B8
	cmp r0,r4	; 023249BA
	beq loc_023249F6	; 023249BC
	b loc_02324A06	; 023249BE
loc_023249C0:
	mov r3,#0x8	; 023249C0
	add r0,r3,#0x0	; 023249C2
	b loc_02324A06	; 023249C4
loc_023249C6:
	mov r3,#0x10	; 023249C6
	add r0,r3,#0x0	; 023249C8
	b loc_02324A06	; 023249CA
loc_023249CC:
	mov r3,#0x20	; 023249CC
	add r0,r3,#0x0	; 023249CE
	b loc_02324A06	; 023249D0
loc_023249D2:
	mov r3,#0x40	; 023249D2
	add r0,r3,#0x0	; 023249D4
	b loc_02324A06	; 023249D6
loc_023249D8:
	mov r3,#0x10	; 023249D8
	mov r0,#0x8	; 023249DA
	b loc_02324A06	; 023249DC
loc_023249DE:
	mov r3,#0x20	; 023249DE
	mov r0,#0x8	; 023249E0
	b loc_02324A06	; 023249E2
loc_023249E4:
	mov r3,#0x20	; 023249E4
	mov r0,#0x10	; 023249E6
	b loc_02324A06	; 023249E8
loc_023249EA:
	mov r3,#0x40	; 023249EA
	mov r0,#0x20	; 023249EC
	b loc_02324A06	; 023249EE
loc_023249F0:
	mov r3,#0x8	; 023249F0
	mov r0,#0x10	; 023249F2
	b loc_02324A06	; 023249F4
loc_023249F6:
	mov r3,#0x8	; 023249F6
	mov r0,#0x20	; 023249F8
	b loc_02324A06	; 023249FA
loc_023249FC:
	mov r3,#0x10	; 023249FC
	mov r0,#0x20	; 023249FE
	b loc_02324A06	; 02324A00
loc_02324A02:
	mov r3,#0x20	; 02324A02
	mov r0,#0x40	; 02324A04
loc_02324A06:
	str r3,[r1,#0x0]	; 02324A06
	str r0,[r2,#0x0]	; 02324A08
	pop {r4}	; 02324A0A
	pop {r3}	; 02324A0C
	bx r3	; 02324A0E
pool_02324A10:
loc_02324A10:
	.word 0xC0008000	; 02324A10
pool_02324A14:
loc_02324A14:
	.word 0x80008000	; 02324A14
pool_02324A18:
loc_02324A18:
	.word 0x80000000	; 02324A18
pool_02324A1C:
loc_02324A1C:
	.word 0x80004000	; 02324A1C
pool_02324A20:
loc_02324A20:
	.word 0xC0000000	; 02324A20
pool_02324A24:
loc_02324A24:
	.word 0xC0004000	; 02324A24
pool_02324A28:
loc_02324A28:
	.word 0x00008000	; 02324A28
pool_02324A2C:
loc_02324A2C:
	.word 0x00004000	; 02324A2C
pool_02324A30:
loc_02324A30:
	.word 0x40004000	; 02324A30
pool_02324A34:
loc_02324A34:
	.word 0x40000000	; 02324A34
pool_02324A38:
loc_02324A38:
	.word 0x40008000	; 02324A38

; ===== function loc_02324A3C =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02324A3C:
loc_02324A3C:
	push {r4,r5,lr}	; 02324A3C
	sub sp,#0x4	; 02324A3E
	add r5,r0,#0x0	; 02324A40
	mov r4,#0x0	; 02324A42
	b loc_02324A56	; 02324A44
loc_02324A46:
	add r0,r4,#0x0	; 02324A46
	add r0,#0x28	; 02324A48
	ldrb r0,[r0,#0x0]	; 02324A4A
	cmp r0,#0x0	; 02324A4C
	bne loc_02324A56	; 02324A4E
	add r0,r4,#0x0	; 02324A50
	bl loc_02324A6C	; 02324A52
loc_02324A56:
	add r0,r5,#0x0	; 02324A56
	add r1,r4,#0x0	; 02324A58
	bl loc_02329590	; 02324A5A
	add r4,r0,#0x0	; 02324A5E
	cmp r4,#0x0	; 02324A60
	bne loc_02324A46	; 02324A62
	add sp,#0x4	; 02324A64
	pop {r4,r5}	; 02324A66
	pop {r3}	; 02324A68
	bx r3	; 02324A6A

; ===== function loc_02324A6C =====
loc_02324A6C:
	push {r4,r5,r6,r7,lr}	; 02324A6C
	sub sp,#0xc	; 02324A6E
	add r5,r0,#0x0	; 02324A70
	ldrh r1,[r5,#0x14]	; 02324A72
	ldr r0,[r5,#0x24]	; 02324A74
	ldrh r0,[r0,#0xc]	; 02324A76
	sub r0,r1,r0	; 02324A78
	lsl r4,r0,#0x7	; 02324A7A
	lsl r6,r1,#0x7	; 02324A7C
	ldr r0,[r5,#0x10]	; 02324A7E
	add r1,sp,#0x0	; 02324A80
	add r2,sp,#0x4	; 02324A82
	bl loc_0232494C	; 02324A84
	ldrh r0,[r5,#0x18]	; 02324A88
	ldr r2,[sp,#0x0]	; 02324A8A
	ldr r1,[sp,#0x4]	; 02324A8C
	mul r2,r1	; 02324A8E
	mul r0,r2	; 02324A90
	mov r1,#0x2	; 02324A92
	blx P1_SignedDivMod	; 02324A94
	add r7,r0,#0x0	; 02324A98
	ldr r0,[r5,#0x24]	; 02324A9A
	ldr r0,[r0,#0x14]	; 02324A9C
	add r0,r0,r4	; 02324A9E
	add r1,r7,#0x0	; 02324AA0
	blx P1_CleanDataCacheRange	; 02324AA2
	ldr r1,[r5,#0x24]	; 02324AA6
	ldrh r0,[r1,#0x10]	; 02324AA8
	cmp r0,#0x0	; 02324AAA
	beq loc_02324ABC	; 02324AAC
	ldr r0,[r1,#0x14]	; 02324AAE
	add r0,r0,r4	; 02324AB0
	add r1,r6,#0x0	; 02324AB2
	add r2,r7,#0x0	; 02324AB4
	bl loc_0232DC20	; 02324AB6
	b loc_02324AC8	; 02324ABA
loc_02324ABC:
	ldr r0,[r1,#0x14]	; 02324ABC
	add r0,r0,r4	; 02324ABE
	add r1,r6,#0x0	; 02324AC0
	add r2,r7,#0x0	; 02324AC2
	bl loc_0232DBF8	; 02324AC4
loc_02324AC8:
	mov r0,#0x1	; 02324AC8
	add r5,#0x28	; 02324ACA
	strb r0,[r5,#0x0]	; 02324ACC
	add sp,#0xc	; 02324ACE
	pop {r4,r5,r6,r7}	; 02324AD0
	pop {r3}	; 02324AD2
	bx r3	; 02324AD4
	.byte 0x00, 0x00	; 02324AD8

; ===== function loc_02324AD8 =====
loc_02324AD8:
	push {lr}	; 02324AD8
	sub sp,#0x14	; 02324ADA
	add r3,r0,#0x0	; 02324ADC
	ldr r0,[pool_02324AFC]	; 02324ADE
	str r0,[sp,#0x0]	; 02324AE0
	str r1,[sp,#0x4]	; 02324AE2
	mov r0,#0x0	; 02324AE4
	str r0,[sp,#0x8]	; 02324AE6
	str r2,[sp,#0xc]	; 02324AE8
	ldr r0,[r3,#0x24]	; 02324AEA
	add r1,r3,#0x0	; 02324AEC
	ldr r2,[r3,#0x20]	; 02324AEE
	ldrh r3,[r3,#0x1c]	; 02324AF0
	bl loc_023245EC	; 02324AF2
	add sp,#0x14	; 02324AF6
	pop {r3}	; 02324AF8
	bx r3	; 02324AFA
pool_02324AFC:
loc_02324AFC:
	.word 0x0000FFFF	; 02324AFC

; ===== function loc_02324B00 =====
loc_02324B00:
	push {lr}	; 02324B00
	sub sp,#0x14	; 02324B02
	add r3,r0,#0x0	; 02324B04
	ldr r0,[pool_02324B28]	; 02324B06
	str r0,[sp,#0x0]	; 02324B08
	str r1,[sp,#0x4]	; 02324B0A
	mov r0,#0x0	; 02324B0C
	str r0,[sp,#0x8]	; 02324B0E
	mvn r0,r0	; 02324B10
	str r0,[sp,#0xc]	; 02324B12
	ldr r0,[r3,#0x24]	; 02324B14
	add r1,r3,#0x0	; 02324B16
	ldr r2,[r3,#0x20]	; 02324B18
	ldrh r3,[r3,#0x1c]	; 02324B1A
	bl loc_023245EC	; 02324B1C
	add sp,#0x14	; 02324B20
	pop {r3}	; 02324B22
	bx r3	; 02324B24
	.byte 0xC0, 0x46	; 02324B28
pool_02324B28:
loc_02324B28:
	.word 0x0000FFFF	; 02324B28

; ===== function loc_02324B2C =====
	push {r4,r5,lr}	; 02324B2C
	sub sp,#0x14	; 02324B2E
	add r5,r0,#0x0	; 02324B30
	add r4,r1,#0x0	; 02324B32
	add r3,r2,#0x0	; 02324B34
	ldr r0,[pool_02324B58]	; 02324B36
	str r0,[sp,#0x0]	; 02324B38
	mov r0,#0x0	; 02324B3A
	str r0,[sp,#0x4]	; 02324B3C
	str r0,[sp,#0x8]	; 02324B3E
	mvn r0,r0	; 02324B40
	str r0,[sp,#0xc]	; 02324B42
	ldr r0,[r5,#0x24]	; 02324B44
	add r1,r5,#0x0	; 02324B46
	add r2,r4,#0x0	; 02324B48
	bl loc_023245EC	; 02324B4A
	add sp,#0x14	; 02324B4E
	pop {r4,r5}	; 02324B50
	pop {r3}	; 02324B52
	bx r3	; 02324B54
	.byte 0xC0, 0x46	; 02324B58
pool_02324B58:
loc_02324B58:
	.word 0x0000FFFF	; 02324B58

; ===== function loc_02324B5C =====
loc_02324B5C:
	push {r4,r5,r6,lr}	; 02324B5C
	sub sp,#0x10	; 02324B5E
	add r5,r0,#0x0	; 02324B60
	add r4,r1,#0x0	; 02324B62
	add r6,r2,#0x0	; 02324B64
	add r0,r6,#0x0	; 02324B66
	bl loc_02324D90	; 02324B68
	add r3,r0,#0x0	; 02324B6C
	str r6,[sp,#0x0]	; 02324B6E
	mov r0,#0x0	; 02324B70
	str r0,[sp,#0x4]	; 02324B72
	str r0,[sp,#0x8]	; 02324B74
	mvn r0,r0	; 02324B76
	str r0,[sp,#0xc]	; 02324B78
	ldr r0,[r5,#0x24]	; 02324B7A
	add r1,r5,#0x0	; 02324B7C
	add r2,r4,#0x0	; 02324B7E
	lsl r3,r3,#0x10	; 02324B80
	lsr r3,r3,#0x10	; 02324B82
	bl loc_023245EC	; 02324B84
	add sp,#0x10	; 02324B88
	pop {r4,r5,r6}	; 02324B8A
	pop {r3}	; 02324B8C
	bx r3	; 02324B8E

; ===== function loc_02324B90 =====
loc_02324B90:
	push {r4,r5,lr}	; 02324B90
	sub sp,#0x14	; 02324B92
	ldr r4,[pool_02324BB0]	; 02324B94
	str r4,[sp,#0x0]	; 02324B96
	mov r5,#0x0	; 02324B98
	str r5,[sp,#0x4]	; 02324B9A
	mov r4,#0x1	; 02324B9C
	str r4,[sp,#0x8]	; 02324B9E
	mvn r4,r5	; 02324BA0
	str r4,[sp,#0xc]	; 02324BA2
	bl loc_023245EC	; 02324BA4
	add sp,#0x14	; 02324BA8
	pop {r4,r5}	; 02324BAA
	pop {r3}	; 02324BAC
	bx r3	; 02324BAE
pool_02324BB0:
loc_02324BB0:
	.word 0x0000FFFF	; 02324BB0

; ===== function loc_02324BB4 =====
loc_02324BB4:
	push {r4,r5,r6,r7,lr}	; 02324BB4
	sub sp,#0x14	; 02324BB6
	add r5,r0,#0x0	; 02324BB8
	add r4,r1,#0x0	; 02324BBA
	add r6,r2,#0x0	; 02324BBC
	add r7,r3,#0x0	; 02324BBE
	add r0,r7,#0x0	; 02324BC0
	bl loc_02324D90	; 02324BC2
	add r3,r0,#0x0	; 02324BC6
	str r7,[sp,#0x0]	; 02324BC8
	mov r1,#0x0	; 02324BCA
	str r1,[sp,#0x4]	; 02324BCC
	mov r0,#0x1	; 02324BCE
	str r0,[sp,#0x8]	; 02324BD0
	mvn r0,r1	; 02324BD2
	str r0,[sp,#0xc]	; 02324BD4
	add r0,r5,#0x0	; 02324BD6
	add r1,r4,#0x0	; 02324BD8
	add r2,r6,#0x0	; 02324BDA
	bl loc_023245EC	; 02324BDC
	add sp,#0x14	; 02324BE0
	pop {r4,r5,r6,r7}	; 02324BE2
	pop {r3}	; 02324BE4
	bx r3	; 02324BE6

; ===== function loc_02324BE8 =====
loc_02324BE8:
	push {r4,r5,lr}	; 02324BE8
	sub sp,#0x4	; 02324BEA
	add r5,r0,#0x0	; 02324BEC
	add r4,r1,#0x0	; 02324BEE
	mov r1,#0x0	; 02324BF0
	bl loc_023296B4	; 02324BF2
	ldr r0,[pool_02324C20]	; 02324BF6
	ldrh r0,[r0,#0x0]	; 02324BF8
	lsl r0,r0,#0x1d	; 02324BFA
	lsr r0,r0,#0x1d	; 02324BFC
	bl loc_02324DAC	; 02324BFE
	lsl r0,r4,#0x9	; 02324C02
	lsr r0,r0,#0x10	; 02324C04
	strh r0,[r5,#0xc]	; 02324C06
	strh r0,[r5,#0xe]	; 02324C08
	mov r0,#0x0	; 02324C0A
	str r0,[sp,#0x0]	; 02324C0C
	ldr r0,[sp,#0x0]	; 02324C0E
	ldr r1,[r5,#0x14]	; 02324C10
	ldr r2,[pool_02324C24]	; 02324C12
	blx loc_0232DE68	; 02324C14
	add sp,#0x4	; 02324C18
	pop {r4,r5}	; 02324C1A
	pop {r3}	; 02324C1C
	bx r3	; 02324C1E
pool_02324C20:
loc_02324C20:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02324C20
pool_02324C24:
loc_02324C24:
	.word 0x00010000	; 02324C24

; ===== function loc_02324C28 =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02324C28:
loc_02324C28:
	mov r1,#0x0	; 02324C28
	ldr r0,[pool_02324C38]	; 02324C2A
	strh r1,[r0,#0x28]	; 02324C2C
	ldr r1,[pool_02324C3C]	; 02324C2E
	str r1,[r0,#0x2c]	; 02324C30
	ldr r0,[pool_02324C40]	; 02324C32
	bx lr	; 02324C34
	.byte 0xC0, 0x46	; 02324C38
pool_02324C38:
loc_02324C38:
	.word P1_BssStart + 0x3BCC	; 02324C38
pool_02324C3C:
loc_02324C3C:
	.word 0x023446BC	; 02324C3C
pool_02324C40:
loc_02324C40:
	.word 0x023346A4	; 02324C40

; ===== function loc_02324C44 =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_02324C44:
loc_02324C44:
	mov r1,#0x1	; 02324C44
	ldr r0,[pool_02324C50]	; 02324C46
	strh r1,[r0,#0x10]	; 02324C48
	ldr r1,[pool_02324C54]	; 02324C4A
	str r1,[r0,#0x14]	; 02324C4C
	bx lr	; 02324C4E
pool_02324C50:
loc_02324C50:
	.word P1_BssStart + 0x3BCC	; 02324C50
pool_02324C54:
loc_02324C54:
	.word 0x023346BC	; 02324C54

; ===== function loc_02324C58 =====
loc_02324C58:
	ldr r0,[pool_02324C5C]	; 02324C58
	bx lr	; 02324C5A
pool_02324C5C:
loc_02324C5C:
	.word 0x023546DC	; 02324C5C
P1_Entry_02324C60:
	ldr r0,[pool_02324C64]	; 02324C60
	bx lr	; 02324C62
pool_02324C64:
	.word 0x023546BC	; 02324C64

; ===== function loc_02324C68 =====
loc_02324C68:
	ldr r0,[pool_02324C6C]	; 02324C68
	bx lr	; 02324C6A
pool_02324C6C:
loc_02324C6C:
	.word 0x023546BC	; 02324C6C

; ===== function loc_02324C70 =====
loc_02324C70:
	push {r4,r5,r6,lr}	; 02324C70
	ldr r0,[pool_02324CB8]	; 02324C72
	ldr r1,[pool_02324CBC]	; 02324C74
	ldr r2,[pool_02324CC0]	; 02324C76
	bl loc_02329028	; 02324C78
	ldr r0,[pool_02324CC4]	; 02324C7C
	ldr r1,[pool_02324CC8]	; 02324C7E
	ldr r2,[pool_02324CCC]	; 02324C80
	bl loc_02329028	; 02324C82
	ldr r0,[pool_02324CD0]	; 02324C86
	ldr r1,[pool_02324CD4]	; 02324C88
	ldr r2,[pool_02324CD8]	; 02324C8A
	bl loc_02329028	; 02324C8C
	ldr r0,[pool_02324CDC]	; 02324C90
	ldr r1,[pool_02324CE0]	; 02324C92
	ldr r2,[pool_02324CE4]	; 02324C94
	bl loc_02329028	; 02324C96
	mov r5,#0x0	; 02324C9A
	ldr r4,[pool_02324CB8]	; 02324C9C
	ldr r6,[pool_02324CE8]	; 02324C9E
	b loc_02324CAE	; 02324CA0
loc_02324CA2:
	lsl r0,r5,#0x5	; 02324CA2
	add r0,r4,r0	; 02324CA4
	ldrh r1,[r6,#0x0]	; 02324CA6
	bl loc_02328BB4	; 02324CA8
	add r5,r5,#0x1	; 02324CAC
loc_02324CAE:
	cmp r5,#0x4	; 02324CAE
	bcc loc_02324CA2	; 02324CB0
	pop {r4,r5,r6}	; 02324CB2
	pop {r3}	; 02324CB4
	bx r3	; 02324CB6
pool_02324CB8:
loc_02324CB8:
	.word 0x023546BC	; 02324CB8
pool_02324CBC:
loc_02324CBC:
	.word 0x023A814C	; 02324CBC
pool_02324CC0:
loc_02324CC0:
	.word 0x023A77C4	; 02324CC0
pool_02324CC4:
loc_02324CC4:
	.word 0x023546DC	; 02324CC4
pool_02324CC8:
loc_02324CC8:
	.word 0x023AA598	; 02324CC8
pool_02324CCC:
loc_02324CCC:
	.word 0x023A79A0	; 02324CCC
pool_02324CD0:
loc_02324CD0:
	.word 0x023546FC	; 02324CD0
pool_02324CD4:
loc_02324CD4:
	.word 0x023A803C	; 02324CD4
pool_02324CD8:
loc_02324CD8:
	.word 0x023A7778	; 02324CD8
pool_02324CDC:
loc_02324CDC:
	.word 0x0235471C	; 02324CDC
pool_02324CE0:
loc_02324CE0:
	.word 0x023A7AA8	; 02324CE0
pool_02324CE4:
loc_02324CE4:
	.word 0x023A7704	; 02324CE4
pool_02324CE8:
loc_02324CE8:
	.word 0x0233074C	; 02324CE8
loc_02324CEC:
	push {r4,r5,r6,r7,lr}	; 02324CEC
	sub sp,#0x4	; 02324CEE
	lsl r2,r1,#0x3	; 02324CF0
	ldr r1,[pool_02324D80]	; 02324CF2
	ldr r3,[r1,r2]	; 02324CF4
	ldr r1,[pool_02324D84]	; 02324CF6
	ldr r2,[r1,r2]	; 02324CF8
	ldr r1,[pool_02324D88]	; 02324CFA
	and r0,r1	; 02324CFC
	lsl r0,r0,#0x2	; 02324CFE
	ldr r0,[r2,r0]	; 02324D00
	add r1,r3,r0	; 02324D02
	ldr r0,[pool_02324D8C]	; 02324D04
	mov r3,#0x3	; 02324D06
	mov r4,#0x3f	; 02324D08
	mov r2,#0xf	; 02324D0A
	b loc_02324D6A	; 02324D0C
loc_02324D0E:
	cmp r5,#0x80	; 02324D0E
	bcs loc_02324D18	; 02324D10
	strh r5,[r0,#0x0]	; 02324D12
	add r1,r1,#0x1	; 02324D14
	b loc_02324D68	; 02324D16
loc_02324D18:
	cmp r5,#0xe0	; 02324D18
	bcc loc_02324D3C	; 02324D1A
	ldrb r6,[r1,#0x1]	; 02324D1C
	and r5,r2	; 02324D1E
	lsl r7,r5,#0x4	; 02324D20
	asr r5,r6,#0x2	; 02324D22
	and r5,r2	; 02324D24
	orr r7,r5	; 02324D26
	lsl r5,r7,#0x8	; 02324D28
	and r6,r3	; 02324D2A
	lsl r7,r6,#0x6	; 02324D2C
	ldrb r6,[r1,#0x2]	; 02324D2E
	and r6,r4	; 02324D30
	orr r7,r6	; 02324D32
	orr r5,r7	; 02324D34
	strh r5,[r0,#0x0]	; 02324D36
	add r1,r1,#0x3	; 02324D38
	b loc_02324D68	; 02324D3A
loc_02324D3C:
	add r7,r5,#0x0	; 02324D3C
	mov r6,#0xe0	; 02324D3E
	and r7,r6	; 02324D40
	cmp r7,#0xc0	; 02324D42
	bne loc_02324D68	; 02324D44
	add r7,r5,#0x0	; 02324D46
	mov r6,#0x1c	; 02324D48
	and r7,r6	; 02324D4A
	asr r6,r7,#0x2	; 02324D4C
	lsl r6,r6,#0x10	; 02324D4E
	lsr r6,r6,#0x8	; 02324D50
	and r5,r3	; 02324D52
	lsl r5,r5,#0x16	; 02324D54
	lsr r5,r5,#0x10	; 02324D56
	ldrb r7,[r1,#0x1]	; 02324D58
	and r7,r4	; 02324D5A
	lsl r7,r7,#0x10	; 02324D5C
	lsr r7,r7,#0x10	; 02324D5E
	orr r5,r7	; 02324D60
	orr r6,r5	; 02324D62
	strh r6,[r0,#0x0]	; 02324D64
	add r1,r1,#0x2	; 02324D66
loc_02324D68:
	add r0,r0,#0x2	; 02324D68
loc_02324D6A:
	ldrb r5,[r1,#0x0]	; 02324D6A
	cmp r5,#0x0	; 02324D6C
	bne loc_02324D0E	; 02324D6E
	mov r1,#0x0	; 02324D70
	strh r1,[r0,#0x0]	; 02324D72
	ldr r0,[pool_02324D8C]	; 02324D74
	add sp,#0x4	; 02324D76
	pop {r4,r5,r6,r7}	; 02324D78
	pop {r3}	; 02324D7A
	bx r3	; 02324D7C
	.byte 0xC0, 0x46	; 02324D80
pool_02324D80:
loc_02324D80:
	.word P1_BssStart + 0x23C84	; 02324D80
pool_02324D84:
loc_02324D84:
	.word P1_BssStart + 0x23C80	; 02324D84
pool_02324D88:
loc_02324D88:
	.word 0x0000FFFF	; 02324D88
pool_02324D8C:
loc_02324D8C:
	.word 0x02354770	; 02324D8C

; ===== function loc_02324D90 =====
loc_02324D90:
	lsl r1,r0,#0x1	; 02324D90
	ldr r0,[pool_02324D98]	; 02324D92
	ldrh r0,[r0,r1]	; 02324D94
	bx lr	; 02324D96
pool_02324D98:
loc_02324D98:
	.word P1_Data_02330768	; 02324D98

; ===== function loc_02324D9C =====
loc_02324D9C:
	ldr r1,[pool_02324DA4]	; 02324D9C
	ldr r1,[r1,#0x0]	; 02324D9E
	ldr r3,[pool_02324DA8]	; 02324DA0
	bx r3	; 02324DA2
pool_02324DA4:
loc_02324DA4:
	.word P1_BssStart + 0x23C7C	; 02324DA4
pool_02324DA8:
loc_02324DA8:
	.word loc_02324CEC + 1	; 02324DA8

; ===== function loc_02324DAC =====
loc_02324DAC:
	ldr r1,[pool_02324DB4]	; 02324DAC
	str r0,[r1,#0x0]	; 02324DAE
	bx lr	; 02324DB0
	.byte 0xC0, 0x46	; 02324DB4
pool_02324DB4:
loc_02324DB4:
	.word P1_BssStart + 0x23C7C	; 02324DB4

; ===== function loc_02324DB8 =====
loc_02324DB8:
	push {r4,r5,r6,lr}	; 02324DB8
	sub sp,#0x18	; 02324DBA
	ldr r4,[pool_02324DF8]	; 02324DBC
	add r3,sp,#0x0	; 02324DBE
	mov r2,#0x3	; 02324DC0
loc_02324DC2:
	ldmia r4!,{r0,r1}	; 02324DC2
	stmia r3!,{r0,r1}	; 02324DC4
	sub r2,r2,#0x1	; 02324DC6
	cmp r2,#0x0	; 02324DC8
	bne loc_02324DC2	; 02324DCA
	mov r5,#0x0	; 02324DCC
	add r4,sp,#0x0	; 02324DCE
	ldr r6,[pool_02324DFC]	; 02324DD0
loc_02324DD2:
	lsl r0,r5,#0x2	; 02324DD2
	ldr r0,[r4,r0]	; 02324DD4
	lsl r1,r5,#0x3	; 02324DD6
	add r1,r6,r1	; 02324DD8
	bl loc_02324E08	; 02324DDA
	add r5,r5,#0x1	; 02324DDE
	cmp r5,#0x6	; 02324DE0
	blt loc_02324DD2	; 02324DE2
	ldr r0,[pool_02324E00]	; 02324DE4
	ldrh r0,[r0,#0x0]	; 02324DE6
	lsl r0,r0,#0x1d	; 02324DE8
	lsr r1,r0,#0x1d	; 02324DEA
	ldr r0,[pool_02324E04]	; 02324DEC
	str r1,[r0,#0x0]	; 02324DEE
	add sp,#0x18	; 02324DF0
	pop {r4,r5,r6}	; 02324DF2
	pop {r3}	; 02324DF4
	bx r3	; 02324DF6
pool_02324DF8:
loc_02324DF8:
	.word 0x02330750	; 02324DF8
pool_02324DFC:
loc_02324DFC:
	.word 0x02354740	; 02324DFC
pool_02324E00:
loc_02324E00:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02324E00
pool_02324E04:
loc_02324E04:
	.word P1_BssStart + 0x23C7C	; 02324E04

; ===== function loc_02324E08 =====
loc_02324E08:
	push {r4,r5,r6,lr}	; 02324E08
	ldr r2,[r0,#0xc]	; 02324E0A
	add r0,#0x20	; 02324E0C
	mov r3,#0x0	; 02324E0E
	str r3,[r1,#0x0]	; 02324E10
	str r3,[r1,#0x4]	; 02324E12
	ldr r5,[pool_02324E44]	; 02324E14
	ldr r4,[pool_02324E48]	; 02324E16
	b loc_02324E3A	; 02324E18
loc_02324E1A:
	ldr r6,[r0,#0x0]	; 02324E1A
	cmp r6,r5	; 02324E1C
	beq loc_02324E26	; 02324E1E
	cmp r6,r4	; 02324E20
	beq loc_02324E2E	; 02324E22
	b loc_02324E34	; 02324E24
loc_02324E26:
	add r6,r0,#0x0	; 02324E26
	add r6,#0x10	; 02324E28
	str r6,[r1,#0x0]	; 02324E2A
	b loc_02324E34	; 02324E2C
loc_02324E2E:
	add r6,r0,#0x0	; 02324E2E
	add r6,#0x8	; 02324E30
	str r6,[r1,#0x4]	; 02324E32
loc_02324E34:
	ldr r6,[r0,#0x4]	; 02324E34
	add r0,r0,r6	; 02324E36
	add r3,r3,#0x1	; 02324E38
loc_02324E3A:
	cmp r3,r2	; 02324E3A
	blt loc_02324E1A	; 02324E3C
	pop {r4,r5,r6}	; 02324E3E
	pop {r3}	; 02324E40
	bx r3	; 02324E42
pool_02324E44:
loc_02324E44:
	.word 0x31464E49	; 02324E44
pool_02324E48:
loc_02324E48:
	.word 0x31544144	; 02324E48
	.byte 0x01, 0x48, 0xC0, 0x69, 0x70, 0x47, 0xC0, 0x46, 0x70, 0x4B, 0x35, 0x02	; 02324E4C
P1_Entry_02324E58:
	push {lr}	; 02324E58
	sub sp,#0x4	; 02324E5A
	ldr r0,[pool_02324E78]	; 02324E5C
	ldr r1,[pool_02324E7C]	; 02324E5E
	mov r2,#0x35	; 02324E60
	bl loc_02324B5C	; 02324E62
	ldr r0,[pool_02324E80]	; 02324E66
	ldr r1,[pool_02324E7C]	; 02324E68
	mov r2,#0x36	; 02324E6A
	bl loc_02324B5C	; 02324E6C
	add sp,#0x4	; 02324E70
	pop {r3}	; 02324E72
	bx r3	; 02324E74
	.byte 0xC0, 0x46	; 02324E76
pool_02324E78:
	.word 0x02354BD0	; 02324E78
pool_02324E7C:
	.word 0x023A5C04	; 02324E7C
pool_02324E80:
	.word 0x02354BFC	; 02324E80
P1_Entry_02324E84:
	push {r4,r5,r6,lr}	; 02324E84
	mov r4,#0x0	; 02324E86
	mvn r5,r4	; 02324E88
	ldr r0,[pool_02324F28]	; 02324E8A
	ldr r1,[r0,#0x18]	; 02324E8C
	cmp r1,#0x2	; 02324E8E
	bne P1_Entry_02324F1E	; 02324E90
	ldr r0,[r0,#0x1c]	; 02324E92
	cmp r0,#0x1	; 02324E94
	bne P1_Entry_02324F1E	; 02324E96
	add r6,r4,#0x0	; 02324E98
	ldr r0,[pool_02324F2C]	; 02324E9A
	ldr r1,[pool_02324F30]	; 02324E9C
	bl loc_0232432C	; 02324E9E
	ldr r0,[pool_02324F2C]	; 02324EA2
	mov r1,#0x1	; 02324EA4
	bl loc_02324318	; 02324EA6
	cmp r0,#0x0	; 02324EAA
	beq P1_Entry_02324EB6	; 02324EAC
	mov r4,#0x1	; 02324EAE
	ldr r0,[pool_02324F28]	; 02324EB0
	str r4,[r0,#0x20]	; 02324EB2
	b P1_Entry_02324ECA	; 02324EB4
P1_Entry_02324EB6:
	ldr r0,[pool_02324F2C]	; 02324EB6
	lsl r1,r4,#0	; 02324EB8
	bl loc_02324318	; 02324EBA
	cmp r0,#0x0	; 02324EBE
	beq P1_Entry_02324ECA	; 02324EC0
	lsl r1,r4,#0	; 02324EC2
	ldr r0,[pool_02324F28]	; 02324EC4
	str r1,[r0,#0x20]	; 02324EC6
	mov r6,#0x1	; 02324EC8
P1_Entry_02324ECA:
	mov r0,#0x20	; 02324ECA
	bl loc_02324108	; 02324ECC
	cmp r0,#0x0	; 02324ED0
	beq P1_Entry_02324EE2	; 02324ED2
	mov r1,#0x0	; 02324ED4
	ldr r0,[pool_02324F28]	; 02324ED6
	str r1,[r0,#0x20]	; 02324ED8
	mov r0,#0x1d	; 02324EDA
	bl loc_023236E0	; 02324EDC
	b P1_Entry_02324F1E	; 02324EE0
P1_Entry_02324EE2:
	mov r0,#0x10	; 02324EE2
	bl loc_02324108	; 02324EE4
	cmp r0,#0x0	; 02324EE8
	beq P1_Entry_02324EFA	; 02324EEA
	mov r1,#0x1	; 02324EEC
	ldr r0,[pool_02324F28]	; 02324EEE
	str r1,[r0,#0x20]	; 02324EF0
	mov r0,#0x1d	; 02324EF2
	bl loc_023236E0	; 02324EF4
	b P1_Entry_02324F1E	; 02324EF8
P1_Entry_02324EFA:
	mov r0,#0x1	; 02324EFA
	bl loc_02324108	; 02324EFC
	cmp r0,#0x0	; 02324F00
	bne P1_Entry_02324F08	; 02324F02
	cmp r4,#0x0	; 02324F04
	beq P1_Entry_02324F0E	; 02324F06
P1_Entry_02324F08:
	ldr r0,[pool_02324F28]	; 02324F08
	ldr r5,[r0,#0x20]	; 02324F0A
	b P1_Entry_02324F1E	; 02324F0C
P1_Entry_02324F0E:
	mov r0,#0x2	; 02324F0E
	bl loc_02324108	; 02324F10
	cmp r0,#0x0	; 02324F14
	bne P1_Entry_02324F1C	; 02324F16
	cmp r6,#0x0	; 02324F18
	beq P1_Entry_02324F1E	; 02324F1A
P1_Entry_02324F1C:
	mov r5,#0x0	; 02324F1C
P1_Entry_02324F1E:
	add r0,r5,#0x0	; 02324F1E
	pop {r4,r5,r6}	; 02324F20
	pop {r3}	; 02324F22
	bx r3	; 02324F24
	.byte 0xC0, 0x46	; 02324F26
pool_02324F28:
	.word P1_BssStart + 0x240B0	; 02324F28
pool_02324F2C:
	.word 0x02354B98	; 02324F2C
pool_02324F30:
	.word 0x023A4B9C	; 02324F30

; ===== function loc_02324F34 =====
loc_02324F34:
	push {lr}	; 02324F34
	sub sp,#0x4	; 02324F36
	bl loc_02325284	; 02324F38
	ldr r0,[pool_02325014]	; 02324F3C
	ldr r1,[r0,#0x14]	; 02324F3E
	cmp r1,#0x0	; 02324F40
	blt loc_0232500C	; 02324F42
	ldr r1,[r0,#0x1c]	; 02324F44
	cmp r1,#0x0	; 02324F46
	beq loc_02324F54	; 02324F48
	cmp r1,#0x1	; 02324F4A
	beq loc_02324F86	; 02324F4C
	cmp r1,#0x2	; 02324F4E
	beq loc_02324FE4	; 02324F50
	b loc_0232500C	; 02324F52
loc_02324F54:
	ldr r1,[r0,#0x10]	; 02324F54
	add r2,r1,#0x1	; 02324F56
	str r2,[r0,#0x10]	; 02324F58
	cmp r2,#0xf	; 02324F5A
	bgt loc_02324F70	; 02324F5C
	mov r1,#0xf	; 02324F5E
	sub r0,r1,r2	; 02324F60
	mov r2,#0x78	; 02324F62
	mul r0,r2	; 02324F64
	blx P1_SignedDivMod	; 02324F66
	ldr r1,[pool_02325014]	; 02324F6A
	str r0,[r1,#0x0]	; 02324F6C
	b loc_0232500C	; 02324F6E
loc_02324F70:
	ldr r0,[r0,#0x18]	; 02324F70
	cmp r0,#0x1	; 02324F72
	bne loc_02324F7A	; 02324F74
	bl loc_023252B8	; 02324F76
loc_02324F7A:
	mov r1,#0x0	; 02324F7A
	ldr r0,[pool_02325014]	; 02324F7C
	str r1,[r0,#0x10]	; 02324F7E
	mov r1,#0x1	; 02324F80
	str r1,[r0,#0x1c]	; 02324F82
	b loc_0232500C	; 02324F84
loc_02324F86:
	ldr r1,[r0,#0x18]	; 02324F86
	cmp r1,#0x0	; 02324F88
	bne loc_02324FA0	; 02324F8A
	ldr r1,[r0,#0x10]	; 02324F8C
	add r1,r1,#0x1	; 02324F8E
	str r1,[r0,#0x10]	; 02324F90
	cmp r1,#0x78	; 02324F92
	ble loc_0232500C	; 02324F94
	mov r1,#0x0	; 02324F96
	str r1,[r0,#0x10]	; 02324F98
	mov r1,#0x2	; 02324F9A
	str r1,[r0,#0x1c]	; 02324F9C
	b loc_0232500C	; 02324F9E
loc_02324FA0:
	cmp r1,#0x1	; 02324FA0
	bne loc_02324FC6	; 02324FA2
	ldr r1,[r0,#0x10]	; 02324FA4
	add r1,r1,#0x1	; 02324FA6
	str r1,[r0,#0x10]	; 02324FA8
	ldr r0,[r0,#0x24]	; 02324FAA
	cmp r0,#0x0	; 02324FAC
	beq loc_0232500C	; 02324FAE
	bl loc_023252AC	; 02324FB0
	ldr r0,[pool_02325014]	; 02324FB4
	ldr r1,[r0,#0x10]	; 02324FB6
	cmp r1,#0x1e	; 02324FB8
	ble loc_0232500C	; 02324FBA
	mov r1,#0x0	; 02324FBC
	str r1,[r0,#0x10]	; 02324FBE
	mov r1,#0x2	; 02324FC0
	str r1,[r0,#0x1c]	; 02324FC2
	b loc_0232500C	; 02324FC4
loc_02324FC6:
	cmp r1,#0x2	; 02324FC6
	bne loc_0232500C	; 02324FC8
	ldr r1,[r0,#0x10]	; 02324FCA
	add r1,r1,#0x1	; 02324FCC
	str r1,[r0,#0x10]	; 02324FCE
	cmp r1,#0x1e	; 02324FD0
	ble loc_0232500C	; 02324FD2
	ldr r1,[r0,#0x24]	; 02324FD4
	cmp r1,#0x0	; 02324FD6
	beq loc_0232500C	; 02324FD8
	mov r1,#0x0	; 02324FDA
	str r1,[r0,#0x10]	; 02324FDC
	mov r1,#0x2	; 02324FDE
	str r1,[r0,#0x1c]	; 02324FE0
	b loc_0232500C	; 02324FE2
loc_02324FE4:
	ldr r1,[r0,#0x10]	; 02324FE4
	add r2,r1,#0x1	; 02324FE6
	str r2,[r0,#0x10]	; 02324FE8
	cmp r2,#0xf	; 02324FEA
	bgt loc_02325004	; 02324FEC
	mov r1,#0xf	; 02324FEE
	sub r0,r1,r2	; 02324FF0
	mov r2,#0x78	; 02324FF2
	mul r0,r2	; 02324FF4
	blx P1_SignedDivMod	; 02324FF6
	mov r1,#0x78	; 02324FFA
	sub r1,r1,r0	; 02324FFC
	ldr r0,[pool_02325014]	; 02324FFE
	str r1,[r0,#0x0]	; 02325000
	b loc_0232500C	; 02325002
loc_02325004:
	bl loc_023252B8	; 02325004
	bl loc_02325208	; 02325008
loc_0232500C:
	add sp,#0x4	; 0232500C
	pop {r3}	; 0232500E
	bx r3	; 02325010
	.byte 0xC0, 0x46	; 02325014
pool_02325014:
loc_02325014:
	.word P1_BssStart + 0x240B0	; 02325014

; ===== function loc_02325018 =====
loc_02325018:
	ldr r0,[pool_02325028]	; 02325018
	ldr r2,[r0,#0x14]	; 0232501A
	mov r0,#0x0	; 0232501C
	mvn r1,r0	; 0232501E
	cmp r2,r1	; 02325020
	beq loc_02325026	; 02325022
	mov r0,#0x1	; 02325024
loc_02325026:
	bx lr	; 02325026
pool_02325028:
loc_02325028:
	.word P1_BssStart + 0x240B0	; 02325028

; ===== function loc_0232502C =====
loc_0232502C:
	ldr r0,[pool_02325034]	; 0232502C
	ldr r0,[r0,#0x24]	; 0232502E
	bx lr	; 02325030
	.byte 0xC0, 0x46	; 02325034
pool_02325034:
loc_02325034:
	.word P1_BssStart + 0x240B0	; 02325034

; ===== function loc_02325038 =====
loc_02325038:
	mov r1,#0x1	; 02325038
	ldr r0,[pool_02325040]	; 0232503A
	str r1,[r0,#0x24]	; 0232503C
	bx lr	; 0232503E
pool_02325040:
loc_02325040:
	.word P1_BssStart + 0x240B0	; 02325040

; ===== function loc_02325044 =====
loc_02325044:
	push {r4,lr}	; 02325044
	add r4,r2,#0x0	; 02325046
	bl loc_02325088	; 02325048
	ldr r0,[pool_0232505C]	; 0232504C
	add r1,r4,#0x0	; 0232504E
	bl loc_02324B00	; 02325050
	pop {r4}	; 02325054
	pop {r3}	; 02325056
	bx r3	; 02325058
	.byte 0xC0, 0x46	; 0232505C
pool_0232505C:
loc_0232505C:
	.word 0x02354BA4	; 0232505C

; ===== function loc_02325060 =====
loc_02325060:
	push {lr}	; 02325060
	sub sp,#0x4	; 02325062
	bl loc_02325088	; 02325064
	ldr r0,[pool_0232507C]	; 02325068
	ldr r1,[pool_02325080]	; 0232506A
	ldr r2,[pool_02325084]	; 0232506C
	ldr r2,[r2,#0x14]	; 0232506E
	bl loc_02324B5C	; 02325070
	add sp,#0x4	; 02325074
	pop {r3}	; 02325076
	bx r3	; 02325078
	.byte 0xC0, 0x46	; 0232507C
pool_0232507C:
loc_0232507C:
	.word 0x02354BA4	; 0232507C
pool_02325080:
loc_02325080:
	.word 0x023A5C04	; 02325080
pool_02325084:
loc_02325084:
	.word P1_BssStart + 0x240B0	; 02325084

; ===== function loc_02325088 =====
loc_02325088:
	push {r4,r5,lr}	; 02325088
	sub sp,#0x4	; 0232508A
	add r5,r0,#0x0	; 0232508C
	add r4,r1,#0x0	; 0232508E
	bl loc_023252AC	; 02325090
	bl loc_02325208	; 02325094
	ldr r1,[pool_023250B4]	; 02325098
	str r5,[r1,#0x14]	; 0232509A
	str r4,[r1,#0x18]	; 0232509C
	cmp r4,#0x2	; 0232509E
	bne loc_023250AC	; 023250A0
	mov r0,#0xd	; 023250A2
	mvn r0,r0	; 023250A4
	str r0,[r1,#0x4]	; 023250A6
	mov r0,#0x8	; 023250A8
	str r0,[r1,#0x8]	; 023250AA
loc_023250AC:
	add sp,#0x4	; 023250AC
	pop {r4,r5}	; 023250AE
	pop {r3}	; 023250B0
	bx r3	; 023250B2
pool_023250B4:
loc_023250B4:
	.word P1_BssStart + 0x240B0	; 023250B4

; ===== function loc_023250B8 =====
loc_023250B8:
	push {r4,lr}	; 023250B8
	sub sp,#0x10	; 023250BA
	ldr r0,[pool_0232519C]	; 023250BC
	ldr r1,[r0,#0x14]	; 023250BE
	cmp r1,#0x0	; 023250C0
	blt loc_02325194	; 023250C2
	ldr r0,[r0,#0x18]	; 023250C4
	cmp r0,#0x2	; 023250C6
	bne loc_0232514A	; 023250C8
	bl loc_02323E38	; 023250CA
	ldr r1,[pool_0232519C]	; 023250CE
	ldr r2,[r1,#0xc]	; 023250D0
	str r2,[sp,#0x0]	; 023250D2
	ldr r1,[r1,#0x0]	; 023250D4
	str r1,[sp,#0x4]	; 023250D6
	ldr r1,[pool_023251A0]	; 023250D8
	ldr r2,[pool_023251A4]	; 023250DA
	mov r3,#0x4	; 023250DC
	bl loc_02323BFC	; 023250DE
	mov r1,#0x0	; 023250E2
	str r1,[sp,#0x0]	; 023250E4
	ldr r0,[pool_023251A8]	; 023250E6
	ldr r2,[pool_0232519C]	; 023250E8
	ldr r2,[r2,#0x0]	; 023250EA
	add r3,r1,#0x0	; 023250EC
	bl loc_0232373C	; 023250EE
	mov r1,#0x0	; 023250F2
	str r1,[sp,#0x0]	; 023250F4
	ldr r0,[pool_023251AC]	; 023250F6
	ldr r2,[pool_0232519C]	; 023250F8
	ldr r2,[r2,#0x0]	; 023250FA
	add r3,r1,#0x0	; 023250FC
	bl loc_0232373C	; 023250FE
	ldr r0,[pool_023251B0]	; 02325102
	mov r1,#0x1	; 02325104
	bl loc_0232424C	; 02325106
	add r4,r0,#0x0	; 0232510A
	bl loc_02323E38	; 0232510C
	mov r1,#0x0	; 02325110
	str r1,[sp,#0x0]	; 02325112
	ldr r1,[pool_0232519C]	; 02325114
	ldr r1,[r1,#0x0]	; 02325116
	str r1,[sp,#0x4]	; 02325118
	str r4,[sp,#0x8]	; 0232511A
	ldr r1,[pool_023251A0]	; 0232511C
	ldr r2,[pool_023251A4]	; 0232511E
	mov r3,#0x2	; 02325120
	bl loc_02323BA8	; 02325122
	ldr r0,[pool_023251B0]	; 02325126
	mov r1,#0x0	; 02325128
	bl loc_0232424C	; 0232512A
	add r4,r0,#0x0	; 0232512E
	bl loc_02323E38	; 02325130
	mov r1,#0x0	; 02325134
	str r1,[sp,#0x0]	; 02325136
	ldr r1,[pool_0232519C]	; 02325138
	ldr r1,[r1,#0x0]	; 0232513A
	str r1,[sp,#0x4]	; 0232513C
	str r4,[sp,#0x8]	; 0232513E
	ldr r1,[pool_023251A0]	; 02325140
	ldr r2,[pool_023251A4]	; 02325142
	mov r3,#0x3	; 02325144
	bl loc_02323BA8	; 02325146
loc_0232514A:
	mov r1,#0x0	; 0232514A
	str r1,[sp,#0x0]	; 0232514C
	ldr r0,[pool_023251B4]	; 0232514E
	ldr r2,[pool_0232519C]	; 02325150
	ldr r3,[r2,#0x0]	; 02325152
	ldr r2,[r2,#0x4]	; 02325154
	add r2,r3,r2	; 02325156
	add r3,r1,#0x0	; 02325158
	bl loc_0232373C	; 0232515A
	bl loc_02323E38	; 0232515E
	mov r1,#0x0	; 02325162
	str r1,[sp,#0x0]	; 02325164
	ldr r1,[pool_0232519C]	; 02325166
	ldr r2,[r1,#0x0]	; 02325168
	ldr r1,[r1,#0x8]	; 0232516A
	add r1,r2,r1	; 0232516C
	str r1,[sp,#0x4]	; 0232516E
	ldr r1,[pool_023251A0]	; 02325170
	ldr r2,[pool_023251A4]	; 02325172
	mov r3,#0x1	; 02325174
	bl loc_02323BFC	; 02325176
	bl loc_02323E38	; 0232517A
	mov r3,#0x0	; 0232517E
	str r3,[sp,#0x0]	; 02325180
	ldr r1,[pool_0232519C]	; 02325182
	ldr r2,[r1,#0x0]	; 02325184
	ldr r1,[r1,#0x4]	; 02325186
	add r1,r2,r1	; 02325188
	str r1,[sp,#0x4]	; 0232518A
	ldr r1,[pool_023251A0]	; 0232518C
	ldr r2,[pool_023251A4]	; 0232518E
	bl loc_02323BFC	; 02325190
loc_02325194:
	add sp,#0x10	; 02325194
	pop {r4}	; 02325196
	pop {r3}	; 02325198
	bx r3	; 0232519A
pool_0232519C:
loc_0232519C:
	.word P1_BssStart + 0x240B0	; 0232519C
pool_023251A0:
loc_023251A0:
	.word 0x023C11F8	; 023251A0
pool_023251A4:
loc_023251A4:
	.word 0x023A50DC	; 023251A4
pool_023251A8:
loc_023251A8:
	.word 0x02354BD0	; 023251A8
pool_023251AC:
loc_023251AC:
	.word 0x02354BFC	; 023251AC
pool_023251B0:
loc_023251B0:
	.word 0x02354B98	; 023251B0
pool_023251B4:
loc_023251B4:
	.word 0x02354BA4	; 023251B4

; ===== function loc_023251B8 =====
loc_023251B8:
	push {r4,lr}	; 023251B8
	add r4,r0,#0x0	; 023251BA
	ldr r1,[pool_023251F8]	; 023251BC
	ldr r2,[pool_023251FC]	; 023251BE
	mov r3,#0x5d	; 023251C0
	bl loc_02324BB4	; 023251C2
	add r0,r4,#0x0	; 023251C6
	ldr r1,[pool_02325200]	; 023251C8
	ldr r2,[pool_023251FC]	; 023251CA
	mov r3,#0x1	; 023251CC
	bl loc_02324B90	; 023251CE
	add r0,r4,#0x0	; 023251D2
	ldr r1,[pool_02325204]	; 023251D4
	ldr r2,[pool_023251FC]	; 023251D6
	mov r3,#0x2	; 023251D8
	bl loc_02324B90	; 023251DA
	ldr r0,[pool_02325200]	; 023251DE
	ldr r1,[pool_023251FC]	; 023251E0
	mov r2,#0x35	; 023251E2
	bl loc_02324B5C	; 023251E4
	ldr r0,[pool_02325204]	; 023251E8
	ldr r1,[pool_023251FC]	; 023251EA
	mov r2,#0x36	; 023251EC
	bl loc_02324B5C	; 023251EE
	pop {r4}	; 023251F2
	pop {r3}	; 023251F4
	bx r3	; 023251F6
pool_023251F8:
loc_023251F8:
	.word 0x02354BA4	; 023251F8
pool_023251FC:
loc_023251FC:
	.word 0x023A5C04	; 023251FC
pool_02325200:
loc_02325200:
	.word 0x02354BD0	; 02325200
pool_02325204:
loc_02325204:
	.word 0x02354BFC	; 02325204

; ===== function loc_02325208 =====
loc_02325208:
	mov r1,#0x78	; 02325208
	ldr r0,[pool_0232522C]	; 0232520A
	str r1,[r0,#0x0]	; 0232520C
	mov r1,#0x0	; 0232520E
	mvn r2,r1	; 02325210
	str r2,[r0,#0x14]	; 02325212
	str r1,[r0,#0x4]	; 02325214
	str r1,[r0,#0x8]	; 02325216
	str r1,[r0,#0xc]	; 02325218
	str r1,[r0,#0x10]	; 0232521A
	str r1,[r0,#0x18]	; 0232521C
	str r1,[r0,#0x1c]	; 0232521E
	str r1,[r0,#0x20]	; 02325220
	str r1,[r0,#0x24]	; 02325222
	ldr r0,[pool_02325230]	; 02325224
	ldr r3,[pool_02325234]	; 02325226
	bx r3	; 02325228
	.byte 0xC0, 0x46	; 0232522C
pool_0232522C:
loc_0232522C:
	.word P1_BssStart + 0x240B0	; 0232522C
pool_02325230:
loc_02325230:
	.word 0x02354B98	; 02325230
pool_02325234:
loc_02325234:
	.word loc_023243D8 + 1	; 02325234

; ===== function loc_02325238 =====
loc_02325238:
	push {lr}	; 02325238
	sub sp,#0x4	; 0232523A
	ldr r1,[pool_02325274]	; 0232523C
	ldrh r2,[r1,#0x0]	; 0232523E
	mov r0,#0x43	; 02325240
	and r2,r0	; 02325242
	ldr r0,[pool_02325278]	; 02325244
	orr r2,r0	; 02325246
	strh r2,[r1,#0x0]	; 02325248
	bl loc_02324558	; 0232524A
	add r1,r0,#0x0	; 0232524E
	ldr r0,[pool_0232527C]	; 02325250
	str r0,[sp,#0x0]	; 02325252
	ldr r0,[sp,#0x0]	; 02325254
	ldr r2,[pool_02325280]	; 02325256
	blx loc_0232DE68	; 02325258
	bl loc_02324558	; 0232525C
	ldr r1,[pool_02325280]	; 02325260
	blx P1_CleanDataCacheRange	; 02325262
	mov r0,#0x8	; 02325266
	bl loc_02324560	; 02325268
	add sp,#0x4	; 0232526C
	pop {r3}	; 0232526E
	bx r3	; 02325270
	.byte 0xC0, 0x46	; 02325274
pool_02325274:
loc_02325274:
	.word REG_BG3CNT_SUB	; 02325274
pool_02325278:
loc_02325278:
	.word 0x00000810	; 02325278
pool_0232527C:
loc_0232527C:
	.word 0x005F005F	; 0232527C
pool_02325280:
loc_02325280:
	.word 0x00000600	; 02325280

; ===== function loc_02325284 =====
loc_02325284:
	ldr r0,[pool_023252A4]	; 02325284
	ldr r1,[r0,#0x20]	; 02325286
	lsl r2,r1,#0x1	; 02325288
	ldr r1,[pool_023252A8]	; 0232528A
	ldrh r2,[r1,r2]	; 0232528C
	ldr r1,[r0,#0xc]	; 0232528E
	cmp r1,r2	; 02325290
	bge loc_0232529A	; 02325292
	add r1,#0x10	; 02325294
	str r1,[r0,#0xc]	; 02325296
	bx lr	; 02325298
loc_0232529A:
	cmp r1,r2	; 0232529A
	ble loc_023252A2	; 0232529C
	sub r1,#0x10	; 0232529E
	str r1,[r0,#0xc]	; 023252A0
loc_023252A2:
	bx lr	; 023252A2
pool_023252A4:
loc_023252A4:
	.word P1_BssStart + 0x240B0	; 023252A4
pool_023252A8:
loc_023252A8:
	.word P1_Data_023301C0	; 023252A8

; ===== function loc_023252AC =====
loc_023252AC:
	mov r1,#0x0	; 023252AC
	ldr r0,[pool_023252B4]	; 023252AE
	str r1,[r0,#0x8]	; 023252B0
	bx lr	; 023252B2
pool_023252B4:
loc_023252B4:
	.word P1_BssStart + 0x24168	; 023252B4

; ===== function loc_023252B8 =====
loc_023252B8:
	mov r1,#0x1	; 023252B8
	ldr r0,[pool_023252C0]	; 023252BA
	str r1,[r0,#0x8]	; 023252BC
	bx lr	; 023252BE
pool_023252C0:
loc_023252C0:
	.word P1_BssStart + 0x24168	; 023252C0

; ===== function loc_023252C4 =====
loc_023252C4:
	ldr r1,[pool_023252DC]	; 023252C4
	ldr r2,[r1,#0x0]	; 023252C6
	mov r0,#0x1	; 023252C8
	and r2,r0	; 023252CA
	cmp r2,#0x0	; 023252CC
	bne loc_023252D6	; 023252CE
	ldr r1,[r1,#0x4]	; 023252D0
	cmp r1,#0x18	; 023252D2
	beq loc_023252D8	; 023252D4
loc_023252D6:
	mov r0,#0x0	; 023252D6
loc_023252D8:
	bx lr	; 023252D8
	.byte 0xC0, 0x46	; 023252DC
pool_023252DC:
loc_023252DC:
	.word P1_BssStart + 0x24168	; 023252DC
	.byte 0x06, 0x49, 0x0A, 0x68, 0x02, 0x20, 0x02, 0x40, 0x00, 0x2A, 0x04, 0xD0, 0x08, 0x6A, 0x00, 0x28	; 023252E0
	.byte 0x01, 0xD1, 0x01, 0x20, 0x70, 0x47, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0x28, 0x4C, 0x35, 0x02	; 023252F0
P1_Entry_02325300:
	ldr r1,[pool_0232531C]	; 02325300
	ldr r2,[r1,#0x0]	; 02325302
	ldr r0,[pool_02325320]	; 02325304
	ldr r0,[r0,#0x4]	; 02325306
	add r3,r2,#0x0	; 02325308
	and r3,r0	; 0232530A
	cmp r3,#0x0	; 0232530C
	beq P1_Entry_0232531A	; 0232530E
	mov r0,#0x4	; 02325310
	bic r2,r0	; 02325312
	str r2,[r1,#0x0]	; 02325314
	mov r0,#0x1	; 02325316
	str r0,[r1,#0x68]	; 02325318
P1_Entry_0232531A:
	bx lr	; 0232531A
pool_0232531C:
	.word P1_BssStart + 0x24168	; 0232531C
pool_02325320:
	.word P1_Data_023301C4	; 02325320
P1_Entry_02325324:
	ldr r1,[pool_02325340]	; 02325324
	ldr r2,[r1,#0x0]	; 02325326
	ldr r0,[pool_02325344]	; 02325328
	ldr r0,[r0,#0x4]	; 0232532A
	add r3,r2,#0x0	; 0232532C
	and r3,r0	; 0232532E
	cmp r3,#0x0	; 02325330
	bne P1_Entry_0232533E	; 02325332
	mov r0,#0x4	; 02325334
	orr r2,r0	; 02325336
	str r2,[r1,#0x0]	; 02325338
	mov r0,#0x1	; 0232533A
	str r0,[r1,#0x68]	; 0232533C
P1_Entry_0232533E:
	bx lr	; 0232533E
pool_02325340:
	.word P1_BssStart + 0x24168	; 02325340
pool_02325344:
	.word P1_Data_023301C4	; 02325344
P1_Entry_02325348:
	ldr r1,[pool_02325364]	; 02325348
	ldr r2,[r1,#0x0]	; 0232534A
	ldr r0,[pool_02325368]	; 0232534C
	ldr r0,[r0,#0x0]	; 0232534E
	add r3,r2,#0x0	; 02325350
	and r3,r0	; 02325352
	cmp r3,#0x0	; 02325354
	beq P1_Entry_02325362	; 02325356
	mov r0,#0x2	; 02325358
	bic r2,r0	; 0232535A
	str r2,[r1,#0x0]	; 0232535C
	mov r0,#0x1	; 0232535E
	str r0,[r1,#0x28]	; 02325360
P1_Entry_02325362:
	bx lr	; 02325362
pool_02325364:
	.word P1_BssStart + 0x24168	; 02325364
pool_02325368:
	.word P1_Data_023301C4	; 02325368
P1_Entry_0232536C:
	ldr r1,[pool_02325388]	; 0232536C
	ldr r2,[r1,#0x0]	; 0232536E
	ldr r0,[pool_0232538C]	; 02325370
	ldr r0,[r0,#0x0]	; 02325372
	add r3,r2,#0x0	; 02325374
	and r3,r0	; 02325376
	cmp r3,#0x0	; 02325378
	bne P1_Entry_02325386	; 0232537A
	mov r0,#0x2	; 0232537C
	orr r2,r0	; 0232537E
	str r2,[r1,#0x0]	; 02325380
	mov r0,#0x1	; 02325382
	str r0,[r1,#0x28]	; 02325384
P1_Entry_02325386:
	bx lr	; 02325386
pool_02325388:
	.word P1_BssStart + 0x24168	; 02325388
pool_0232538C:
	.word P1_Data_023301C4	; 0232538C

; ===== function loc_02325390 =====
loc_02325390:
	ldr r1,[pool_0232539C]	; 02325390
	ldr r2,[r1,#0x0]	; 02325392
	mov r0,#0x1	; 02325394
	bic r2,r0	; 02325396
	str r2,[r1,#0x0]	; 02325398
	bx lr	; 0232539A
pool_0232539C:
loc_0232539C:
	.word P1_BssStart + 0x24168	; 0232539C

; ===== function loc_023253A0 =====
loc_023253A0:
	ldr r1,[pool_023253AC]	; 023253A0
	ldr r2,[r1,#0x0]	; 023253A2
	mov r0,#0x1	; 023253A4
	orr r2,r0	; 023253A6
	str r2,[r1,#0x0]	; 023253A8
	bx lr	; 023253AA
pool_023253AC:
loc_023253AC:
	.word P1_BssStart + 0x24168	; 023253AC

; ===== function loc_023253B0 =====
loc_023253B0:
	push {r4,r5,r6,lr}	; 023253B0
	ldr r2,[pool_02325408]	; 023253B2
	lsl r1,r0,#0x6	; 023253B4
	add r1,r2,r1	; 023253B6
	lsl r3,r0,#0x2	; 023253B8
	ldr r2,[pool_0232540C]	; 023253BA
	ldr r4,[r2,r3]	; 023253BC
	ldr r2,[pool_02325410]	; 023253BE
	ldr r3,[r2,#0x8]	; 023253C0
	cmp r3,#0x0	; 023253C2
	beq loc_023253D8	; 023253C4
	ldr r2,[r2,#0x0]	; 023253C6
	and r2,r4	; 023253C8
	cmp r2,#0x0	; 023253CA
	beq loc_023253D8	; 023253CC
	ldr r1,[r1,#0x8]	; 023253CE
	cmp r1,#0x0	; 023253D0
	bne loc_023253D8	; 023253D2
	mov r5,#0x1	; 023253D4
	b loc_023253DA	; 023253D6
loc_023253D8:
	mov r5,#0x0	; 023253D8
loc_023253DA:
	lsl r4,r0,#0x3	; 023253DA
	ldr r0,[pool_02325414]	; 023253DC
	ldr r1,[pool_02325418]	; 023253DE
	ldrh r1,[r1,r4]	; 023253E0
	bl loc_02324318	; 023253E2
	add r6,r0,#0x0	; 023253E6
	ldr r0,[pool_0232541C]	; 023253E8
	ldrh r0,[r0,r4]	; 023253EA
	bl loc_02324108	; 023253EC
	cmp r5,#0x0	; 023253F0
	beq loc_02325400	; 023253F2
	cmp r6,#0x0	; 023253F4
	bne loc_023253FC	; 023253F6
	cmp r0,#0x0	; 023253F8
	beq loc_02325400	; 023253FA
loc_023253FC:
	mov r0,#0x1	; 023253FC
	b loc_02325402	; 023253FE
loc_02325400:
	mov r0,#0x0	; 02325400
loc_02325402:
	pop {r4,r5,r6}	; 02325402
	pop {r3}	; 02325404
	bx r3	; 02325406
pool_02325408:
loc_02325408:
	.word 0x02354C40	; 02325408
pool_0232540C:
loc_0232540C:
	.word P1_Data_023301C4	; 0232540C
pool_02325410:
loc_02325410:
	.word P1_BssStart + 0x24168	; 02325410
pool_02325414:
loc_02325414:
	.word 0x02354C34	; 02325414
pool_02325418:
loc_02325418:
	.word P1_Data_023301D0	; 02325418
pool_0232541C:
loc_0232541C:
	.word P1_Data_023301D2	; 0232541C
P1_Entry_02325420:
	lsl r2,r1,#0x6	; 02325420
	ldr r1,[pool_02325438]	; 02325422
	ldr r1,[r1,r2]	; 02325424
	cmp r0,r1	; 02325426
	beq P1_Entry_02325434	; 02325428
	ldr r1,[pool_0232543C]	; 0232542A
	str r0,[r1,r2]	; 0232542C
	mov r1,#0x1	; 0232542E
	ldr r0,[pool_02325440]	; 02325430
	str r1,[r0,r2]	; 02325432
P1_Entry_02325434:
	bx lr	; 02325434
	.byte 0xC0, 0x46	; 02325436
pool_02325438:
	.word P1_BssStart + 0x24180	; 02325438
pool_0232543C:
	.word P1_BssStart + 0x24184	; 0232543C
pool_02325440:
	.word P1_BssStart + 0x24190	; 02325440

; ===== function loc_02325444 =====
loc_02325444:
	push {r4,r5,r6,r7,lr}	; 02325444
	sub sp,#0xc	; 02325446
	ldr r1,[pool_023254E4]	; 02325448
	ldr r2,[r1,#0x0]	; 0232544A
	mov r0,#0x1	; 0232544C
	and r2,r0	; 0232544E
	cmp r2,#0x0	; 02325450
	beq loc_02325460	; 02325452
	ldr r0,[r1,#0x4]	; 02325454
	cmp r0,#0x0	; 02325456
	beq loc_0232546A	; 02325458
	sub r0,r0,#0x2	; 0232545A
	str r0,[r1,#0x4]	; 0232545C
	b loc_0232546A	; 0232545E
loc_02325460:
	ldr r0,[r1,#0x4]	; 02325460
	cmp r0,#0x18	; 02325462
	beq loc_0232546A	; 02325464
	add r0,r0,#0x2	; 02325466
	str r0,[r1,#0x4]	; 02325468
loc_0232546A:
	mov r5,#0x0	; 0232546A
	add r7,r5,#0x0	; 0232546C
	mvn r6,r5	; 0232546E
	str r5,[sp,#0x0]	; 02325470
	str r5,[sp,#0x4]	; 02325472
loc_02325474:
	lsl r1,r5,#0x6	; 02325474
	ldr r0,[pool_023254E8]	; 02325476
	add r4,r0,r1	; 02325478
	ldr r0,[r4,#0x10]	; 0232547A
	cmp r0,#0x0	; 0232547C
	beq loc_023254C4	; 0232547E
	ldr r0,[r4,#0x8]	; 02325480
	cmp r0,#0x18	; 02325482
	beq loc_0232548C	; 02325484
	add r0,r0,#0x2	; 02325486
	str r0,[r4,#0x8]	; 02325488
	b loc_023254CE	; 0232548A
loc_0232548C:
	ldr r0,[pool_023254E4]	; 0232548C
	ldr r0,[r0,#0x0]	; 0232548E
	lsl r2,r5,#0x2	; 02325490
	ldr r1,[pool_023254EC]	; 02325492
	ldr r1,[r1,r2]	; 02325494
	and r0,r1	; 02325496
	cmp r0,#0x0	; 02325498
	beq loc_023254A2	; 0232549A
	mov r0,#0x1	; 0232549C
	str r0,[r4,#0xc]	; 0232549E
	b loc_023254A4	; 023254A0
loc_023254A2:
	str r7,[r4,#0xc]	; 023254A2
loc_023254A4:
	ldr r1,[r4,#0x4]	; 023254A4
	ldr r0,[sp,#0x4]	; 023254A6
	mvn r0,r0	; 023254A8
	cmp r1,r0	; 023254AA
	beq loc_023254BE	; 023254AC
	str r1,[r4,#0x0]	; 023254AE
	add r0,r4,#0x0	; 023254B0
	add r0,#0x14	; 023254B2
	ldr r1,[pool_023254F0]	; 023254B4
	ldr r2,[r4,#0x0]	; 023254B6
	bl loc_02324B5C	; 023254B8
	str r6,[r4,#0x4]	; 023254BC
loc_023254BE:
	ldr r0,[sp,#0x0]	; 023254BE
	str r0,[r4,#0x10]	; 023254C0
	b loc_023254CE	; 023254C2
loc_023254C4:
	ldr r0,[r4,#0x8]	; 023254C4
	cmp r0,#0x0	; 023254C6
	beq loc_023254CE	; 023254C8
	sub r0,r0,#0x2	; 023254CA
	str r0,[r4,#0x8]	; 023254CC
loc_023254CE:
	add r5,r5,#0x1	; 023254CE
	cmp r5,#0x2	; 023254D0
	blt loc_02325474	; 023254D2
	ldr r0,[pool_023254F4]	; 023254D4
	ldr r1,[pool_023254F8]	; 023254D6
	bl loc_0232432C	; 023254D8
	add sp,#0xc	; 023254DC
	pop {r4,r5,r6,r7}	; 023254DE
	pop {r3}	; 023254E0
	bx r3	; 023254E2
pool_023254E4:
loc_023254E4:
	.word P1_BssStart + 0x24168	; 023254E4
pool_023254E8:
loc_023254E8:
	.word 0x02354C40	; 023254E8
pool_023254EC:
loc_023254EC:
	.word P1_Data_023301C4	; 023254EC
pool_023254F0:
loc_023254F0:
	.word 0x023A5B4C	; 023254F0
pool_023254F4:
loc_023254F4:
	.word 0x02354C34	; 023254F4
pool_023254F8:
loc_023254F8:
	.word 0x023A4B54	; 023254F8

; ===== function loc_023254FC =====
loc_023254FC:
	push {r4,r5,r6,r7,lr}	; 023254FC
	sub sp,#0x1c	; 023254FE
	bl loc_02323E38	; 02325500
	add r7,r0,#0x0	; 02325504
	mov r5,#0x0	; 02325506
	str r5,[sp,#0x10]	; 02325508
	str r5,[sp,#0x14]	; 0232550A
loc_0232550C:
	lsl r1,r5,#0x6	; 0232550C
	ldr r0,[pool_023255A8]	; 0232550E
	add r4,r0,r1	; 02325510
	ldr r0,[r4,#0xc]	; 02325512
	cmp r0,#0x0	; 02325514
	beq loc_0232556E	; 02325516
	ldr r1,[r4,#0x8]	; 02325518
	cmp r1,#0x18	; 0232551A
	beq loc_0232556E	; 0232551C
	ldr r0,[pool_023255AC]	; 0232551E
	ldr r0,[r0,#0x4]	; 02325520
	add r6,r0,r1	; 02325522
	ldr r0,[pool_023255AC]	; 02325524
	ldr r0,[r0,#0x8]	; 02325526
	cmp r0,#0x0	; 02325528
	beq loc_0232553E	; 0232552A
	ldr r0,[pool_023255B0]	; 0232552C
	lsl r2,r5,#0x3	; 0232552E
	ldr r1,[pool_023255B4]	; 02325530
	add r1,r1,r2	; 02325532
	ldrh r1,[r1,#0x4]	; 02325534
	bl loc_0232424C	; 02325536
	str r0,[sp,#0xc]	; 0232553A
	b loc_02325542	; 0232553C
loc_0232553E:
	mov r0,#0x2	; 0232553E
	str r0,[sp,#0xc]	; 02325540
loc_02325542:
	ldr r0,[sp,#0x10]	; 02325542
	str r0,[sp,#0x0]	; 02325544
	add r4,#0x14	; 02325546
	add r0,r4,#0x0	; 02325548
	ldr r1,[sp,#0x10]	; 0232554A
	add r2,r6,#0x0	; 0232554C
	lsl r3,r1,#0	; 0232554E
	bl loc_0232373C	; 02325550
	ldr r0,[sp,#0x14]	; 02325554
	str r0,[sp,#0x0]	; 02325556
	str r6,[sp,#0x4]	; 02325558
	ldr r0,[sp,#0xc]	; 0232555A
	str r0,[sp,#0x8]	; 0232555C
	add r0,r7,#0x0	; 0232555E
	ldr r1,[pool_023255B8]	; 02325560
	ldr r2,[pool_023255BC]	; 02325562
	lsl r4,r5,#0x3	; 02325564
	ldr r3,[pool_023255B4]	; 02325566
	ldrh r3,[r3,r4]	; 02325568
	bl loc_02323BA8	; 0232556A
loc_0232556E:
	add r5,r5,#0x1	; 0232556E
	cmp r5,#0x2	; 02325570
	blt loc_0232550C	; 02325572
	mov r3,#0x0	; 02325574
	str r3,[sp,#0x0]	; 02325576
	ldr r0,[pool_023255AC]	; 02325578
	ldr r0,[r0,#0x4]	; 0232557A
	neg r0,r0	; 0232557C
	str r0,[sp,#0x4]	; 0232557E
	add r0,r7,#0x0	; 02325580
	ldr r1,[pool_023255B8]	; 02325582
	ldr r2,[pool_023255BC]	; 02325584
	bl loc_02323BFC	; 02325586
	mov r0,#0x0	; 0232558A
	str r0,[sp,#0x0]	; 0232558C
	ldr r0,[pool_023255AC]	; 0232558E
	ldr r0,[r0,#0x4]	; 02325590
	str r0,[sp,#0x4]	; 02325592
	add r0,r7,#0x0	; 02325594
	ldr r1,[pool_023255B8]	; 02325596
	ldr r2,[pool_023255BC]	; 02325598
	mov r3,#0x1	; 0232559A
	bl loc_02323BFC	; 0232559C
	add sp,#0x1c	; 023255A0
	pop {r4,r5,r6,r7}	; 023255A2
	pop {r3}	; 023255A4
	bx r3	; 023255A6
pool_023255A8:
loc_023255A8:
	.word 0x02354C40	; 023255A8
pool_023255AC:
loc_023255AC:
	.word P1_BssStart + 0x24168	; 023255AC
pool_023255B0:
loc_023255B0:
	.word 0x02354C34	; 023255B0
pool_023255B4:
loc_023255B4:
	.word P1_Data_023301CC	; 023255B4
pool_023255B8:
loc_023255B8:
	.word 0x023C11F8	; 023255B8
pool_023255BC:
loc_023255BC:
	.word 0x023A503C	; 023255BC

; ===== function loc_023255C0 =====
loc_023255C0:
	push {r4,r5,r6,r7,lr}	; 023255C0
	sub sp,#0x4	; 023255C2
	str r0,[sp,#0x0]	; 023255C4
	mov r5,#0x0	; 023255C6
loc_023255C8:
	lsl r4,r5,#0x6	; 023255C8
	ldr r0,[pool_02325600]	; 023255CA
	add r7,r0,r4	; 023255CC
	ldr r0,[sp,#0x0]	; 023255CE
	add r1,r7,#0x0	; 023255D0
	add r1,#0x14	; 023255D2
	ldr r2,[pool_02325604]	; 023255D4
	lsl r6,r5,#0x3	; 023255D6
	ldr r3,[pool_02325608]	; 023255D8
	add r3,r3,r6	; 023255DA
	ldrh r3,[r3,#0x2]	; 023255DC
	bl loc_02324BB4	; 023255DE
	add r7,#0x14	; 023255E2
	add r0,r7,#0x0	; 023255E4
	ldr r1,[pool_02325604]	; 023255E6
	ldr r2,[pool_02325600]	; 023255E8
	ldr r2,[r2,r4]	; 023255EA
	bl loc_02324B5C	; 023255EC
	add r5,r5,#0x1	; 023255F0
	cmp r5,#0x2	; 023255F2
	blt loc_023255C8	; 023255F4
	add sp,#0x4	; 023255F6
	pop {r4,r5,r6,r7}	; 023255F8
	pop {r3}	; 023255FA
	bx r3	; 023255FC
	.byte 0xC0, 0x46	; 02325600
pool_02325600:
loc_02325600:
	.word P1_BssStart + 0x24180	; 02325600
pool_02325604:
loc_02325604:
	.word 0x023A5B4C	; 02325604
pool_02325608:
loc_02325608:
	.word 0x023301CC	; 02325608

; ===== function loc_0232560C =====
loc_0232560C:
	push {r4,r5,r6,r7,lr}	; 0232560C
	sub sp,#0xc	; 0232560E
	str r0,[sp,#0x4]	; 02325610
	add r7,r1,#0x0	; 02325612
	add r4,r2,#0x0	; 02325614
	mov r3,#0x0	; 02325616
	mvn r1,r3	; 02325618
	add r0,r3,#0x0	; 0232561A
loc_0232561C:
	lsl r5,r3,#0x6	; 0232561C
	ldr r2,[pool_0232567C]	; 0232561E
	add r2,r2,r5	; 02325620
	str r1,[r2,#0x4]	; 02325622
	str r0,[r2,#0x10]	; 02325624
	lsl r6,r3,#0x2	; 02325626
	ldr r5,[pool_02325680]	; 02325628
	ldr r6,[r5,r6]	; 0232562A
	add r5,r4,#0x0	; 0232562C
	str r5,[sp,#0x0]	; 0232562E
	and r5,r6	; 02325630
	str r5,[sp,#0x0]	; 02325632
	cmp r5,#0x0	; 02325634
	beq loc_02325640	; 02325636
	mov r5,#0x1	; 02325638
	str r5,[r2,#0xc]	; 0232563A
	str r0,[r2,#0x8]	; 0232563C
	b loc_02325646	; 0232563E
loc_02325640:
	str r0,[r2,#0xc]	; 02325640
	mov r5,#0x18	; 02325642
	str r5,[r2,#0x8]	; 02325644
loc_02325646:
	add r3,r3,#0x1	; 02325646
	cmp r3,#0x2	; 02325648
	blt loc_0232561C	; 0232564A
	ldr r1,[pool_02325684]	; 0232564C
	ldr r0,[sp,#0x4]	; 0232564E
	str r0,[r1,#0x18]	; 02325650
	str r7,[r1,#0x58]	; 02325652
	str r4,[r1,#0x0]	; 02325654
	mov r0,#0x1	; 02325656
	and r4,r0	; 02325658
	cmp r4,#0x0	; 0232565A
	beq loc_02325664	; 0232565C
	mov r0,#0x0	; 0232565E
	str r0,[r1,#0x4]	; 02325660
	b loc_02325668	; 02325662
loc_02325664:
	mov r0,#0x18	; 02325664
	str r0,[r1,#0x4]	; 02325666
loc_02325668:
	mov r1,#0x1	; 02325668
	ldr r0,[pool_02325684]	; 0232566A
	str r1,[r0,#0x8]	; 0232566C
	ldr r0,[pool_02325688]	; 0232566E
	bl loc_023243D8	; 02325670
	add sp,#0xc	; 02325674
	pop {r4,r5,r6,r7}	; 02325676
	pop {r3}	; 02325678
	bx r3	; 0232567A
pool_0232567C:
loc_0232567C:
	.word 0x02354C40	; 0232567C
pool_02325680:
loc_02325680:
	.word P1_Data_023301C4	; 02325680
pool_02325684:
loc_02325684:
	.word P1_BssStart + 0x24168	; 02325684
pool_02325688:
loc_02325688:
	.word 0x02354C34	; 02325688

; ===== function loc_0232568C =====
loc_0232568C:
	push {r4,r5,r6,lr}	; 0232568C
	sub sp,#0x8	; 0232568E
	add r5,r0,#0x0	; 02325690
	mov r4,#0x0	; 02325692
	add r6,r4,#0x0	; 02325694
	cmp r1,#0x8	; 02325696
	bhi loc_023256F0	; 02325698
	add r0,r1,r1	; 0232569A
P1_SwitchIndexPC_0232569A:
	add r0,pc	; 0232569C
	ldrh r0,[r0,#(P1_SwitchTable_0232569A - (P1_SwitchIndexPC_0232569A + 4))]	; 0232569E
	lsl r0,r0,#0x10	; 023256A0
	asr r0,r0,#0x10	; 023256A2
P1_SwitchTargetPC_0232569A:
	add r0,pc	; 023256A4
	bx r0	; 023256A6
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232569A:
	.halfword (loc_023256F0 + 1) - (P1_SwitchTargetPC_0232569A + 4)
	.halfword (loc_023256BA + 1) - (P1_SwitchTargetPC_0232569A + 4)
	.halfword (loc_023256C8 + 1) - (P1_SwitchTargetPC_0232569A + 4)
	.halfword (loc_023256F0 + 1) - (P1_SwitchTargetPC_0232569A + 4)
	.halfword (loc_023256D6 + 1) - (P1_SwitchTargetPC_0232569A + 4)
	.halfword (loc_023256F0 + 1) - (P1_SwitchTargetPC_0232569A + 4)
	.halfword (loc_023256F0 + 1) - (P1_SwitchTargetPC_0232569A + 4)
	.halfword (loc_023256F0 + 1) - (P1_SwitchTargetPC_0232569A + 4)
	.halfword (loc_023256E4 + 1) - (P1_SwitchTargetPC_0232569A + 4)
P1_SwitchTable_0232569AEnd:
loc_023256BA:
	bl P1_GetSubBg0TilemapBase	; 023256BA
	add r4,r0,#0x0	; 023256BE
	bl P1_GetSubBg0CharacterBase	; 023256C0
	add r6,r0,#0x0	; 023256C4
	b loc_023256F0	; 023256C6
loc_023256C8:
	bl P1_GetSubBg1TilemapBase	; 023256C8
	add r4,r0,#0x0	; 023256CC
	bl P1_GetSubBg1CharacterBase	; 023256CE
	add r6,r0,#0x0	; 023256D2
	b loc_023256F0	; 023256D4
loc_023256D6:
	bl loc_02326C70	; 023256D6
	add r4,r0,#0x0	; 023256DA
	bl loc_02326BD0	; 023256DC
	add r6,r0,#0x0	; 023256E0
	b loc_023256F0	; 023256E2
loc_023256E4:
	bl loc_02326C1C	; 023256E4
	add r4,r0,#0x0	; 023256E8
	bl loc_02326B84	; 023256EA
	add r6,r0,#0x0	; 023256EE
loc_023256F0:
	mov r2,#0x0	; 023256F0
	ldr r1,[pool_02325728]	; 023256F2
loc_023256F4:
	lsl r0,r2,#0x1	; 023256F4
	strh r2,[r4,r0]	; 023256F6
	add r0,r2,#0x1	; 023256F8
	lsl r0,r0,#0x10	; 023256FA
	lsr r2,r0,#0x10	; 023256FC
	cmp r2,r1	; 023256FE
	bcc loc_023256F4	; 02325700
	bl loc_02324C68	; 02325702
	mov r1,#0x0	; 02325706
	str r1,[sp,#0x0]	; 02325708
	str r0,[sp,#0x4]	; 0232570A
	ldr r0,[pool_0232572C]	; 0232570C
	add r1,r6,#0x0	; 0232570E
	ldr r2,[pool_02325730]	; 02325710
	mov r3,#0xc0	; 02325712
	bl loc_02329018	; 02325714
	ldr r0,[pool_0232572C]	; 02325718
	add r1,r5,#0x0	; 0232571A
	bl loc_02329150	; 0232571C
	add sp,#0x8	; 02325720
	pop {r4,r5,r6}	; 02325722
	pop {r3}	; 02325724
	bx r3	; 02325726
pool_02325728:
loc_02325728:
	.word 0x00000300	; 02325728
pool_0232572C:
loc_0232572C:
	.word 0x02354CC0	; 0232572C
pool_02325730:
loc_02325730:
	.word 0x00000100	; 02325730

; 返回固件 UI/启动共享上下文的固定地址。
; Returns the fixed firmware UI/boot shared-context address.
.func P1_GetFirmwareUiContext
loc_02325734:
	ldr r0,[pool_02325738]	; 02325734
	bx lr	; 02325736
.endfunc
pool_02325738:
loc_02325738:
	.word 0x02354CD0	; 02325738

; 初始化共享上下文的已知首批字段。
; Initializes the first known fields of the shared context.
P1_InitializeFirmwareUiContext:
loc_0232573C:
	mov r2,#0x0	; 0232573C
	ldr r1,[pool_02325754]	; 0232573E
	str r2,[r1,#0x0]	; 02325740
	str r2,[r1,#0x4]	; 02325742
	ldr r0,[pool_02325758]	; 02325744
	orr r2,r0	; 02325746
	str r2,[r1,#0x0]	; 02325748
	ldr r0,[pool_0232575C]	; 0232574A
	orr r2,r0	; 0232574C
	str r2,[r1,#0x0]	; 0232574E
	bx lr	; 02325750
	.byte 0xC0, 0x46	; 02325754
pool_02325754:
loc_02325754:
	.word P1_BssStart + 0x24210	; 02325754
pool_02325758:
loc_02325758:
	.word 0x00000200	; 02325758
pool_0232575C:
loc_0232575C:
	.word 0x00000400	; 0232575C

; ===== function loc_02325760 =====
loc_02325760:
	push {r4,r5,r6,r7,lr}	; 02325760
	sub sp,#0x4	; 02325762
	bl P1_GetFirmwareUiContext	; 02325764
	add r5,r0,#0x0	; 02325768
	ldr r0,[pool_02325828]	; 0232576A
	ldrh r1,[r0,#0x0]	; 0232576C
	ldr r0,[pool_0232582C]	; 0232576E
	ldrh r0,[r0,#0x0]	; 02325770
	orr r1,r0	; 02325772
	ldr r0,[pool_02325830]	; 02325774
	eor r1,r0	; 02325776
	and r1,r0	; 02325778
	lsl r0,r1,#0x10	; 0232577A
	lsr r1,r0,#0x10	; 0232577C
	ldr r0,[r5,#0x0]	; 0232577E
	lsl r2,r0,#0x19	; 02325780
	lsr r2,r2,#0x1f	; 02325782
	cmp r2,#0x0	; 02325784
	bne loc_0232581E	; 02325786
	lsl r2,r0,#0x17	; 02325788
	lsr r2,r2,#0x1f	; 0232578A
	cmp r2,#0x0	; 0232578C
	beq loc_023257A2	; 0232578E
	ldr r2,[pool_02325834]	; 02325790
	add r3,r1,#0x0	; 02325792
	and r3,r2	; 02325794
	cmp r3,r2	; 02325796
	bne loc_023257A2	; 02325798
	mov r1,#0x10	; 0232579A
	orr r0,r1	; 0232579C
	str r0,[r5,#0x0]	; 0232579E
	b loc_0232581E	; 023257A0
loc_023257A2:
	ldr r0,[pool_02325838]	; 023257A2
	ldrh r0,[r0,#0x0]	; 023257A4
	lsl r0,r0,#0x19	; 023257A6
	lsr r0,r0,#0x1f	; 023257A8
	cmp r0,#0x0	; 023257AA
	beq loc_0232581E	; 023257AC
	ldr r0,[pool_0232583C]	; 023257AE
	ldr r0,[r0,#0x0]	; 023257B0
	mov r2,#0x1	; 023257B2
	and r0,r2	; 023257B4
	cmp r0,#0x0	; 023257B6
	bne loc_023257BC	; 023257B8
	mov r2,#0x0	; 023257BA
loc_023257BC:
	cmp r2,#0x0	; 023257BC
	beq loc_0232581E	; 023257BE
	ldr r0,[r5,#0x0]	; 023257C0
	lsl r0,r0,#0x1c	; 023257C2
	lsr r0,r0,#0x1f	; 023257C4
	cmp r0,#0x0	; 023257C6
	bne loc_0232581E	; 023257C8
	ldr r0,[pool_0232583C]	; 023257CA
	ldr r2,[r0,#0x0]	; 023257CC
	mov r0,#0x2	; 023257CE
	and r2,r0	; 023257D0
	cmp r2,#0x0	; 023257D2
	beq loc_023257DA	; 023257D4
	mov r0,#0x1	; 023257D6
	b loc_023257DC	; 023257D8
loc_023257DA:
	mov r0,#0x0	; 023257DA
loc_023257DC:
	cmp r0,#0x0	; 023257DC
	bne loc_023257EA	; 023257DE
	ldr r1,[r5,#0x0]	; 023257E0
	mov r0,#0x10	; 023257E2
	orr r1,r0	; 023257E4
	str r1,[r5,#0x0]	; 023257E6
	b loc_0232581E	; 023257E8
loc_023257EA:
	mov r4,#0x0	; 023257EA
	ldr r7,[pool_02325828]	; 023257EC
	ldr r6,[pool_02325830]	; 023257EE
	b loc_02325816	; 023257F0
loc_023257F2:
	bl P1_SwiVBlankIntrWait	; 023257F2
	ldrh r1,[r7,#0x0]	; 023257F6
	ldr r0,[pool_0232582C]	; 023257F8
	ldrh r0,[r0,#0x0]	; 023257FA
	orr r1,r0	; 023257FC
	eor r1,r6	; 023257FE
	and r1,r6	; 02325800
	lsl r0,r1,#0x10	; 02325802
	lsr r1,r0,#0x10	; 02325804
	add r4,r4,#0x1	; 02325806
	cmp r4,#0x1e	; 02325808
	blt loc_02325816	; 0232580A
	ldr r1,[r5,#0x0]	; 0232580C
	mov r0,#0x10	; 0232580E
	orr r1,r0	; 02325810
	str r1,[r5,#0x0]	; 02325812
	b loc_0232581E	; 02325814
loc_02325816:
	mov r0,#0x2	; 02325816
	and r1,r0	; 02325818
	cmp r1,#0x0	; 0232581A
	bne loc_023257F2	; 0232581C
loc_0232581E:
	add sp,#0x4	; 0232581E
	pop {r4,r5,r6,r7}	; 02325820
	pop {r3}	; 02325822
	bx r3	; 02325824
	.byte 0xC0, 0x46	; 02325828
pool_02325828:
loc_02325828:
	.word REG_KEYINPUT	; 02325828
pool_0232582C:
loc_0232582C:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 0232582C
pool_02325830:
loc_02325830:
	.word 0x00002FFF	; 02325830
pool_02325834:
loc_02325834:
	.word 0x00000E03	; 02325834
pool_02325838:
loc_02325838:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02325838
pool_0232583C:
loc_0232583C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232583C

; ===== function loc_02325840 =====
loc_02325840:
	push {r4,r5,r6,r7,lr}	; 02325840
	sub sp,#0x4	; 02325842
	bl P1_GetFirmwareUiContext	; 02325844
	add r1,r0,#0x0	; 02325848
	ldr r0,[pool_023259D8]	; 0232584A
	ldrh r2,[r0,#0x0]	; 0232584C
	ldr r0,[pool_023259DC]	; 0232584E
	ldrh r0,[r0,#0x0]	; 02325850
	orr r2,r0	; 02325852
	ldr r0,[pool_023259E0]	; 02325854
	eor r2,r0	; 02325856
	and r2,r0	; 02325858
	lsl r0,r2,#0x10	; 0232585A
	lsr r0,r0,#0x10	; 0232585C
	ldr r3,[r1,#0x0]	; 0232585E
	mov r2,#0x4	; 02325860
	bic r3,r2	; 02325862
	ldr r4,[pool_023259E4]	; 02325864
	ldrh r2,[r4,#0x0]	; 02325866
	lsl r2,r2,#0x16	; 02325868
	lsr r5,r2,#0x1f	; 0232586A
	mov r2,#0x1	; 0232586C
	and r5,r2	; 0232586E
	lsl r5,r5,#0x2	; 02325870
	orr r3,r5	; 02325872
	str r3,[r1,#0x0]	; 02325874
	ldrh r6,[r4,#0x0]	; 02325876
	lsl r3,r6,#0x15	; 02325878
	lsr r7,r3,#0x1f	; 0232587A
	lsl r3,r6,#0x11	; 0232587C
	lsr r5,r3,#0x1f	; 0232587E
	lsl r3,r6,#0x14	; 02325880
	lsr r4,r3,#0x1f	; 02325882
	lsl r3,r6,#0x12	; 02325884
	lsr r3,r3,#0x1f	; 02325886
	lsl r6,r6,#0x10	; 02325888
	lsr r6,r6,#0x1f	; 0232588A
	and r3,r6	; 0232588C
	and r4,r3	; 0232588E
	and r5,r4	; 02325890
	and r7,r5	; 02325892
	cmp r7,#0x0	; 02325894
	beq loc_0232589A	; 02325896
	mov r2,#0x0	; 02325898
loc_0232589A:
	ldr r4,[r1,#0x0]	; 0232589A
	mov r3,#0x1	; 0232589C
	bic r4,r3	; 0232589E
	and r2,r3	; 023258A0
	orr r4,r2	; 023258A2
	str r4,[r1,#0x0]	; 023258A4
	ldr r2,[r1,#0x0]	; 023258A6
	mov r4,#0x2	; 023258A8
	bic r2,r4	; 023258AA
	ldr r4,[pool_023259E4]	; 023258AC
	ldrh r4,[r4,#0x0]	; 023258AE
	lsl r4,r4,#0x12	; 023258B0
	lsr r4,r4,#0x1f	; 023258B2
	and r4,r3	; 023258B4
	lsl r4,r4,#0x1	; 023258B6
	orr r2,r4	; 023258B8
	str r2,[r1,#0x0]	; 023258BA
	ldr r6,[r1,#0x0]	; 023258BC
	ldr r4,[pool_023259E8]	; 023258BE
	add r2,r6,#0x0	; 023258C0
	and r2,r4	; 023258C2
	lsl r4,r6,#0x1f	; 023258C4
	lsr r5,r4,#0x1f	; 023258C6
	lsl r4,r6,#0x1d	; 023258C8
	lsr r4,r4,#0x1f	; 023258CA
	orr r5,r4	; 023258CC
	and r5,r3	; 023258CE
	lsl r4,r5,#0x8	; 023258D0
	orr r2,r4	; 023258D2
	str r2,[r1,#0x0]	; 023258D4
	mov r2,#0x8	; 023258D6
	add r4,r0,#0x0	; 023258D8
	and r4,r2	; 023258DA
	cmp r4,#0x0	; 023258DC
	bne loc_023258E2	; 023258DE
	mov r3,#0x0	; 023258E0
loc_023258E2:
	ldr r5,[r1,#0x0]	; 023258E2
	mov r2,#0x8	; 023258E4
	bic r5,r2	; 023258E6
	mov r4,#0x1	; 023258E8
	and r3,r4	; 023258EA
	lsl r2,r3,#0x3	; 023258EC
	orr r5,r2	; 023258EE
	str r5,[r1,#0x0]	; 023258F0
	mov r3,#0x0	; 023258F2
	add r2,r3,#0x0	; 023258F4
	ldr r5,[pool_023259EC]	; 023258F6
	ldr r6,[r5,#0x0]	; 023258F8
	mov r5,#0x2	; 023258FA
	and r6,r5	; 023258FC
	cmp r6,#0x0	; 023258FE
	bne loc_02325904	; 02325900
	add r4,r3,#0x0	; 02325902
loc_02325904:
	cmp r4,#0x0	; 02325904
	beq loc_02325914	; 02325906
	ldr r4,[r1,#0x0]	; 02325908
	lsl r4,r4,#0x17	; 0232590A
	lsr r4,r4,#0x1f	; 0232590C
	cmp r4,#0x0	; 0232590E
	beq loc_02325914	; 02325910
	mov r2,#0x1	; 02325912
loc_02325914:
	cmp r2,#0x0	; 02325914
	beq loc_02325922	; 02325916
	ldr r2,[pool_023259F0]	; 02325918
	and r0,r2	; 0232591A
	cmp r0,r2	; 0232591C
	bne loc_02325922	; 0232591E
	mov r3,#0x1	; 02325920
loc_02325922:
	ldr r4,[r1,#0x0]	; 02325922
	mov r0,#0x40	; 02325924
	bic r4,r0	; 02325926
	mov r0,#0x1	; 02325928
	and r3,r0	; 0232592A
	lsl r2,r3,#0x6	; 0232592C
	orr r4,r2	; 0232592E
	str r4,[r1,#0x0]	; 02325930
	mov r2,#0x0	; 02325932
	ldr r3,[pool_023259EC]	; 02325934
	ldr r4,[r3,#0x0]	; 02325936
	mov r3,#0x2	; 02325938
	and r4,r3	; 0232593A
	cmp r4,#0x0	; 0232593C
	bne loc_02325942	; 0232593E
	add r0,r2,#0x0	; 02325940
loc_02325942:
	cmp r0,#0x0	; 02325942
	beq loc_02325972	; 02325944
	mov r0,#0x0	; 02325946
	ldr r3,[pool_023259EC]	; 02325948
	ldr r4,[r3,#0x0]	; 0232594A
	mov r3,#0x2	; 0232594C
	and r4,r3	; 0232594E
	cmp r4,#0x0	; 02325950
	beq loc_02325958	; 02325952
	mov r3,#0x1	; 02325954
	b loc_0232595A	; 02325956
loc_02325958:
	add r3,r0,#0x0	; 02325958
loc_0232595A:
	cmp r3,#0x0	; 0232595A
	beq loc_0232596C	; 0232595C
	ldr r3,[pool_023259F4]	; 0232595E
	ldrb r3,[r3,#0x0]	; 02325960
	lsl r3,r3,#0x1d	; 02325962
	lsr r3,r3,#0x1f	; 02325964
	cmp r3,#0x0	; 02325966
	beq loc_0232596C	; 02325968
	mov r0,#0x1	; 0232596A
loc_0232596C:
	cmp r0,#0x0	; 0232596C
	beq loc_02325972	; 0232596E
	mov r2,#0x1	; 02325970
loc_02325972:
	ldr r4,[r1,#0x0]	; 02325972
	mov r3,#0x40	; 02325974
	add r0,r4,#0x0	; 02325976
	bic r0,r3	; 02325978
	lsl r3,r4,#0x19	; 0232597A
	lsr r4,r3,#0x1f	; 0232597C
	orr r4,r2	; 0232597E
	mov r3,#0x1	; 02325980
	and r4,r3	; 02325982
	lsl r2,r4,#0x6	; 02325984
	orr r0,r2	; 02325986
	str r0,[r1,#0x0]	; 02325988
	mov r2,#0x0	; 0232598A
	add r0,r2,#0x0	; 0232598C
	ldr r4,[pool_023259E4]	; 0232598E
	ldrh r4,[r4,#0x0]	; 02325990
	lsl r4,r4,#0x19	; 02325992
	lsr r4,r4,#0x1f	; 02325994
	cmp r4,#0x0	; 02325996
	beq loc_023259AE	; 02325998
	ldr r4,[pool_023259EC]	; 0232599A
	ldr r5,[r4,#0x0]	; 0232599C
	mov r4,#0x2	; 0232599E
	and r5,r4	; 023259A0
	cmp r5,#0x0	; 023259A2
	bne loc_023259A8	; 023259A4
	add r3,r2,#0x0	; 023259A6
loc_023259A8:
	cmp r3,#0x0	; 023259A8
	beq loc_023259AE	; 023259AA
	mov r0,#0x1	; 023259AC
loc_023259AE:
	cmp r0,#0x0	; 023259AE
	beq loc_023259BE	; 023259B0
	ldr r0,[r1,#0x0]	; 023259B2
	lsl r0,r0,#0x1c	; 023259B4
	lsr r0,r0,#0x1f	; 023259B6
	cmp r0,#0x0	; 023259B8
	bne loc_023259BE	; 023259BA
	mov r2,#0x1	; 023259BC
loc_023259BE:
	ldr r3,[r1,#0x0]	; 023259BE
	mov r0,#0x20	; 023259C0
	bic r3,r0	; 023259C2
	mov r0,#0x1	; 023259C4
	and r2,r0	; 023259C6
	lsl r0,r2,#0x5	; 023259C8
	orr r3,r0	; 023259CA
	str r3,[r1,#0x0]	; 023259CC
	add sp,#0x4	; 023259CE
	pop {r4,r5,r6,r7}	; 023259D0
	pop {r3}	; 023259D2
	bx r3	; 023259D4
	.byte 0xC0, 0x46	; 023259D8
pool_023259D8:
loc_023259D8:
	.word REG_KEYINPUT	; 023259D8
pool_023259DC:
loc_023259DC:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 023259DC
pool_023259E0:
loc_023259E0:
	.word 0x00002FFF	; 023259E0
pool_023259E4:
loc_023259E4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023259E4
pool_023259E8:
loc_023259E8:
	.word 0xFFFFFEFF	; 023259E8
pool_023259EC:
loc_023259EC:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023259EC
pool_023259F0:
loc_023259F0:
	.word 0x00000D03	; 023259F0
pool_023259F4:
loc_023259F4:
	.word NdsCartHeaderRamAddress + 0x1F	; 023259F4

; ===== function loc_023259F8 =====
loc_023259F8:
	push {lr}	; 023259F8
	sub sp,#0x4	; 023259FA
	cmp r1,#0xa	; 023259FC
	bge loc_02325A10	; 023259FE
	lsl r2,r1,#0x1	; 02325A00
	ldr r1,[pool_02325A1C]	; 02325A02
	ldrh r1,[r1,r2]	; 02325A04
	strh r1,[r0,#0x0]	; 02325A06
	mov r1,#0x0	; 02325A08
	strh r1,[r0,#0x2]	; 02325A0A
	add r0,r0,#0x2	; 02325A0C
	b loc_02325A14	; 02325A0E
loc_02325A10:
	bl loc_02325A20	; 02325A10
loc_02325A14:
	add sp,#0x4	; 02325A14
	pop {r3}	; 02325A16
	bx r3	; 02325A18
	.byte 0xC0, 0x46	; 02325A1C
pool_02325A1C:
loc_02325A1C:
	.word P1_Data_023301DC	; 02325A1C

; ===== function loc_02325A20 =====
loc_02325A20:
	push {r4,r5,lr}	; 02325A20
	sub sp,#0x4	; 02325A22
	add r5,r0,#0x0	; 02325A24
	add r4,r1,#0x0	; 02325A26
	add r0,r4,#0x0	; 02325A28
	mov r1,#0xa	; 02325A2A
	blx P1_SignedDivMod	; 02325A2C
	mov r1,#0xa	; 02325A30
	blx P1_SignedDivMod	; 02325A32
	lsl r1,r1,#0x1	; 02325A36
	ldr r0,[pool_02325A5C]	; 02325A38
	ldrh r0,[r0,r1]	; 02325A3A
	strh r0,[r5,#0x0]	; 02325A3C
	add r0,r4,#0x0	; 02325A3E
	mov r1,#0xa	; 02325A40
	blx P1_SignedDivMod	; 02325A42
	lsl r1,r1,#0x1	; 02325A46
	ldr r0,[pool_02325A5C]	; 02325A48
	ldrh r0,[r0,r1]	; 02325A4A
	strh r0,[r5,#0x2]	; 02325A4C
	mov r0,#0x0	; 02325A4E
	strh r0,[r5,#0x4]	; 02325A50
	add r0,r5,#0x4	; 02325A52
	add sp,#0x4	; 02325A54
	pop {r4,r5}	; 02325A56
	pop {r3}	; 02325A58
	bx r3	; 02325A5A
pool_02325A5C:
loc_02325A5C:
	.word P1_Data_023301DC	; 02325A5C

; ===== function loc_02325A60 =====
loc_02325A60:
	push {r4,r5,r6,r7,lr}	; 02325A60
	sub sp,#0x1fc	; 02325A62
	sub sp,#0x10	; 02325A64
	add r5,r0,#0x0	; 02325A66
	mov r4,#0x0	; 02325A68
	add r0,sp,#0x8	; 02325A6A
	ldr r1,[pool_02325ACC]	; 02325A6C
	bl P1_ClearByteRangeIfNonNull	; 02325A6E
	mov r0,#0x39	; 02325A72
	bl loc_02324D9C	; 02325A74
	add r6,r0,#0x0	; 02325A78
	add r0,sp,#0x0	; 02325A7A
	ldr r1,[r5,#0x10]	; 02325A7C
	ldrb r1,[r1,#0x0]	; 02325A7E
	bl loc_02325A20	; 02325A80
	add r0,sp,#0x4	; 02325A84
	ldr r1,[r5,#0x10]	; 02325A86
	ldrb r1,[r1,#0x1]	; 02325A88
	bl loc_02325A20	; 02325A8A
	lsl r3,r4,#0	; 02325A8E
	add r0,sp,#0x8	; 02325A90
	add r7,sp,#0x0	; 02325A92
	b loc_02325AAA	; 02325A94
loc_02325A96:
	ldr r5,[pool_02325AD0]	; 02325A96
	cmp r2,r5	; 02325A98
	bne loc_02325AA6	; 02325A9A
	lsl r2,r4,#0x1	; 02325A9C
	add r4,r4,#0x1	; 02325A9E
	ldrh r2,[r7,r2]	; 02325AA0
	strh r2,[r0,r1]	; 02325AA2
	b loc_02325AA8	; 02325AA4
loc_02325AA6:
	strh r2,[r0,r1]	; 02325AA6
loc_02325AA8:
	add r3,r3,#0x1	; 02325AA8
loc_02325AAA:
	lsl r1,r3,#0x1	; 02325AAA
	ldrh r2,[r6,r1]	; 02325AAC
	cmp r2,#0x0	; 02325AAE
	beq loc_02325AB8	; 02325AB0
	ldr r5,[pool_02325AD4]	; 02325AB2
	cmp r3,r5	; 02325AB4
	blt loc_02325A96	; 02325AB6
loc_02325AB8:
	mov r0,#0x39	; 02325AB8
	mov r1,#0x1	; 02325ABA
	add r2,sp,#0x8	; 02325ABC
	bl loc_02325044	; 02325ABE
	add sp,#0x1fc	; 02325AC2
	add sp,#0x10	; 02325AC4
	pop {r4,r5,r6,r7}	; 02325AC6
	pop {r3}	; 02325AC8
	bx r3	; 02325ACA
pool_02325ACC:
loc_02325ACC:
	.word 0x00000200	; 02325ACC
pool_02325AD0:
loc_02325AD0:
	.word 0x000025CF	; 02325AD0
pool_02325AD4:
loc_02325AD4:
	.word 0x00000100	; 02325AD4

; ===== function loc_02325AD8 =====
loc_02325AD8:
	push {r4,lr}	; 02325AD8
	sub sp,#0x8	; 02325ADA
	add r4,r0,#0x0	; 02325ADC
	ldr r0,[r4,#0x0]	; 02325ADE
	cmp r0,#0x0	; 02325AE0
	bne loc_02325AFC	; 02325AE2
	mov r0,#0x0	; 02325AE4
	str r0,[sp,#0x0]	; 02325AE6
	ldr r0,[pool_02325B54]	; 02325AE8
	ldr r1,[r4,#0xc]	; 02325AEA
	ldr r2,[r4,#0x8]	; 02325AEC
	mov r3,#0x10	; 02325AEE
	bl loc_0232D958	; 02325AF0
	ldr r0,[r4,#0x0]	; 02325AF4
	add r0,r0,#0x1	; 02325AF6
	str r0,[r4,#0x0]	; 02325AF8
	b loc_02325B4C	; 02325AFA
loc_02325AFC:
	cmp r0,#0xf	; 02325AFC
	bgt loc_02325B1C	; 02325AFE
	lsl r0,r0,#0x4	; 02325B00
	mov r1,#0xf	; 02325B02
	blx P1_SignedDivMod	; 02325B04
	mov r1,#0x10	; 02325B08
	sub r1,r1,r0	; 02325B0A
	lsl r0,r0,#0x8	; 02325B0C
	orr r1,r0	; 02325B0E
	ldr r0,[pool_02325B58]	; 02325B10
	strh r1,[r0,#0x0]	; 02325B12
	ldr r0,[r4,#0x0]	; 02325B14
	add r0,r0,#0x1	; 02325B16
	str r0,[r4,#0x0]	; 02325B18
	b loc_02325B4C	; 02325B1A
loc_02325B1C:
	mov r0,#0x0	; 02325B1C
	str r0,[r4,#0x0]	; 02325B1E
	ldr r2,[r4,#0x38]	; 02325B20
	mov r1,#0x4	; 02325B22
	bic r2,r1	; 02325B24
	str r2,[r4,#0x38]	; 02325B26
	ldr r2,[r4,#0x38]	; 02325B28
	mov r1,#0x10	; 02325B2A
	orr r2,r1	; 02325B2C
	str r2,[r4,#0x38]	; 02325B2E
	ldr r2,[pool_02325B5C]	; 02325B30
	ldr r3,[r2,#0x0]	; 02325B32
	ldr r1,[pool_02325B60]	; 02325B34
	and r3,r1	; 02325B36
	ldr r1,[r4,#0x8]	; 02325B38
	lsl r1,r1,#0x8	; 02325B3A
	orr r3,r1	; 02325B3C
	str r3,[r2,#0x0]	; 02325B3E
	ldr r1,[pool_02325B54]	; 02325B40
	strh r0,[r1,#0x0]	; 02325B42
	bl loc_023253A0	; 02325B44
	mov r0,#0x0	; 02325B48
	str r0,[r4,#0x30]	; 02325B4A
loc_02325B4C:
	add sp,#0x8	; 02325B4C
	pop {r4}	; 02325B4E
	pop {r3}	; 02325B50
	bx r3	; 02325B52
pool_02325B54:
loc_02325B54:
	.word REG_BLDCNT_SUB	; 02325B54
pool_02325B58:
loc_02325B58:
	.word REG_BLDALPHA_SUB	; 02325B58
pool_02325B5C:
loc_02325B5C:
	.word REG_DISPCNT_B	; 02325B5C
pool_02325B60:
loc_02325B60:
	.word 0xFFFFE0FF	; 02325B60

; ===== function loc_02325B64 =====
loc_02325B64:
	push {r4,r5,lr}	; 02325B64
	sub sp,#0x4	; 02325B66
	add r5,r1,#0x0	; 02325B68
	mov r4,#0x0	; 02325B6A
	str r4,[sp,#0x0]	; 02325B6C
	ldr r0,[pool_02325C18]	; 02325B6E
	mov r1,#0x10	; 02325B70
	ldr r2,[r5,#0xc]	; 02325B72
	add r3,r1,#0x0	; 02325B74
	bl loc_0232D958	; 02325B76
	bl loc_02325018	; 02325B7A
	cmp r0,#0x0	; 02325B7E
	bne loc_02325B92	; 02325B80
	ldr r0,[r5,#0x38]	; 02325B82
	lsl r0,r0,#0x1a	; 02325B84
	lsr r4,r0,#0x1f	; 02325B86
	mov r0,#0x0	; 02325B88
	str r0,[r5,#0x0]	; 02325B8A
	str r0,[r5,#0x4]	; 02325B8C
	str r0,[r5,#0x30]	; 02325B8E
	b loc_02325C0E	; 02325B90
loc_02325B92:
	bl loc_0232502C	; 02325B92
	cmp r0,#0x0	; 02325B96
	bne loc_02325C0E	; 02325B98
	lsl r0,r4,#0	; 02325B9A
	bl loc_023253B0	; 02325B9C
	cmp r0,#0x0	; 02325BA0
	beq loc_02325BCA	; 02325BA2
	mov r0,#0x1b	; 02325BA4
	bl loc_023236E0	; 02325BA6
	bl loc_02325038	; 02325BAA
	lsl r0,r4,#0	; 02325BAE
	bl loc_023229D0	; 02325BB0
	ldr r1,[r5,#0x38]	; 02325BB4
	mov r0,#0x20	; 02325BB6
	orr r1,r0	; 02325BB8
	str r1,[r5,#0x38]	; 02325BBA
	mov r0,#0x9	; 02325BBC
	str r0,[r5,#0x34]	; 02325BBE
	bl loc_023265C4	; 02325BC0
	bl loc_02326934	; 02325BC4
	b loc_02325C0E	; 02325BC8
loc_02325BCA:
	mov r0,#0x1	; 02325BCA
	bl loc_023253B0	; 02325BCC
	cmp r0,#0x0	; 02325BD0
	beq loc_02325BF0	; 02325BD2
	lsl r0,r4,#0	; 02325BD4
	str r0,[r5,#0x4]	; 02325BD6
	add r0,r5,#0x0	; 02325BD8
	mov r1,#0x5	; 02325BDA
	bl loc_023261CC	; 02325BDC
	mov r0,#0x20	; 02325BE0
	bl loc_023236E0	; 02325BE2
	bl loc_02325038	; 02325BE6
	mov r0,#0x4	; 02325BEA
	str r0,[r5,#0x34]	; 02325BEC
	b loc_02325C0E	; 02325BEE
loc_02325BF0:
	add r0,r5,#0x0	; 02325BF0
	bl loc_02326210	; 02325BF2
	cmp r0,#0x0	; 02325BF6
	beq loc_02325C0E	; 02325BF8
	lsl r0,r4,#0	; 02325BFA
	str r0,[r5,#0x4]	; 02325BFC
	add r0,r5,#0x0	; 02325BFE
	mov r1,#0x5	; 02325C00
	bl loc_023261CC	; 02325C02
	bl loc_02325038	; 02325C06
	mov r0,#0x4	; 02325C0A
	str r0,[r5,#0x34]	; 02325C0C
loc_02325C0E:
	add r0,r4,#0x0	; 02325C0E
	add sp,#0x4	; 02325C10
	pop {r4,r5}	; 02325C12
	pop {r3}	; 02325C14
	bx r3	; 02325C16
pool_02325C18:
loc_02325C18:
	.word REG_BLDCNT_SUB	; 02325C18

; ===== function loc_02325C1C =====
loc_02325C1C:
	push {r4,lr}	; 02325C1C
	sub sp,#0x8	; 02325C1E
	add r4,r0,#0x0	; 02325C20
	ldr r0,[r4,#0x0]	; 02325C22
	cmp r0,#0x0	; 02325C24
	bne loc_02325C40	; 02325C26
	mov r0,#0x0	; 02325C28
	str r0,[sp,#0x0]	; 02325C2A
	ldr r0,[pool_02325C84]	; 02325C2C
	mov r1,#0x10	; 02325C2E
	ldr r2,[r4,#0xc]	; 02325C30
	add r3,r1,#0x0	; 02325C32
	bl loc_0232D958	; 02325C34
	ldr r0,[r4,#0x0]	; 02325C38
	add r0,r0,#0x1	; 02325C3A
	str r0,[r4,#0x0]	; 02325C3C
	b loc_02325C7C	; 02325C3E
loc_02325C40:
	cmp r0,#0xf	; 02325C40
	bgt loc_02325C60	; 02325C42
	lsl r0,r0,#0x4	; 02325C44
	mov r1,#0xf	; 02325C46
	blx P1_SignedDivMod	; 02325C48
	mov r1,#0x10	; 02325C4C
	sub r1,r1,r0	; 02325C4E
	lsl r0,r0,#0x8	; 02325C50
	orr r1,r0	; 02325C52
	ldr r0,[pool_02325C88]	; 02325C54
	strh r1,[r0,#0x0]	; 02325C56
	ldr r0,[r4,#0x0]	; 02325C58
	add r0,r0,#0x1	; 02325C5A
	str r0,[r4,#0x0]	; 02325C5C
	b loc_02325C7C	; 02325C5E
loc_02325C60:
	mov r0,#0x0	; 02325C60
	str r0,[r4,#0x0]	; 02325C62
	ldr r1,[r4,#0x38]	; 02325C64
	mov r0,#0x2	; 02325C66
	bic r1,r0	; 02325C68
	str r1,[r4,#0x38]	; 02325C6A
	mov r0,#0x38	; 02325C6C
	mov r1,#0x1	; 02325C6E
	bl loc_02325060	; 02325C70
	bl loc_023253A0	; 02325C74
	mov r0,#0x8	; 02325C78
	str r0,[r4,#0x30]	; 02325C7A
loc_02325C7C:
	add sp,#0x8	; 02325C7C
	pop {r4}	; 02325C7E
	pop {r3}	; 02325C80
	bx r3	; 02325C82
pool_02325C84:
loc_02325C84:
	.word REG_BLDCNT_SUB	; 02325C84
pool_02325C88:
loc_02325C88:
	.word REG_BLDALPHA_SUB	; 02325C88

; ===== function loc_02325C8C =====
loc_02325C8C:
	push {r4,r5,r6,lr}	; 02325C8C
	add r5,r0,#0x0	; 02325C8E
	ldr r1,[r5,#0x14]	; 02325C90
	ldr r3,[r5,#0x18]	; 02325C92
	mov r2,#0x3c	; 02325C94
	add r0,r1,#0x0	; 02325C96
	mul r0,r2	; 02325C98
	add r4,r3,r0	; 02325C9A
	ldr r3,[r5,#0x10]	; 02325C9C
	ldrb r0,[r3,#0x0]	; 02325C9E
	ldrb r6,[r3,#0x1]	; 02325CA0
	add r3,r0,#0x0	; 02325CA2
	mul r3,r2	; 02325CA4
	add r6,r6,r3	; 02325CA6
	cmp r1,r0	; 02325CA8
	bcs loc_02325CB0	; 02325CAA
	ldr r0,[pool_02325DAC]	; 02325CAC
	add r4,r4,r0	; 02325CAE
loc_02325CB0:
	ldr r0,[pool_02325DB0]	; 02325CB0
	bl loc_02324108	; 02325CB2
	cmp r0,#0x0	; 02325CB6
	bne loc_02325CC2	; 02325CB8
	bl loc_023240DC	; 02325CBA
	cmp r0,#0x0	; 02325CBE
	beq loc_02325CEE	; 02325CC0
loc_02325CC2:
	add r0,r5,#0x0	; 02325CC2
	mov r1,#0x1	; 02325CC4
	bl loc_023261CC	; 02325CC6
	add r0,r5,#0x0	; 02325CCA
	bl loc_02326190	; 02325CCC
	add r0,r5,#0x0	; 02325CD0
	add r0,#0x2c	; 02325CD2
	bl loc_023236BC	; 02325CD4
	bl loc_02326934	; 02325CD8
	mov r0,#0x0	; 02325CDC
	str r0,[r5,#0x0]	; 02325CDE
	str r0,[r5,#0x4]	; 02325CE0
	mov r0,#0x7	; 02325CE2
	str r0,[r5,#0x30]	; 02325CE4
	mov r0,#0x28	; 02325CE6
	bl loc_023236E0	; 02325CE8
	b loc_02325DA6	; 02325CEC
loc_02325CEE:
	add r6,#0x3c	; 02325CEE
	cmp r4,r6	; 02325CF0
	blt loc_02325D30	; 02325CF2
	mov r0,#0x0	; 02325CF4
	str r0,[r5,#0x0]	; 02325CF6
	str r0,[r5,#0x4]	; 02325CF8
	ldr r1,[r5,#0x38]	; 02325CFA
	mov r0,#0x4	; 02325CFC
	bic r1,r0	; 02325CFE
	str r1,[r5,#0x38]	; 02325D00
	mov r0,#0x5	; 02325D02
	str r0,[r5,#0x30]	; 02325D04
	add r0,r5,#0x0	; 02325D06
	add r0,#0x3c	; 02325D08
	ldr r1,[pool_02325DB4]	; 02325D0A
	mov r2,#0x5e	; 02325D0C
	bl loc_02324B5C	; 02325D0E
	mov r0,#0x0	; 02325D12
	bl loc_023228B8	; 02325D14
	add r0,r5,#0x0	; 02325D18
	add r0,#0x2c	; 02325D1A
	bl loc_023236BC	; 02325D1C
	bl loc_02326934	; 02325D20
	bl loc_023265F8	; 02325D24
	add r0,r5,#0x0	; 02325D28
	bl loc_02326624	; 02325D2A
	b loc_02325DA6	; 02325D2E
loc_02325D30:
	ldr r0,[r5,#0x38]	; 02325D30
	lsl r0,r0,#0x1c	; 02325D32
	lsr r0,r0,#0x1f	; 02325D34
	cmp r0,#0x0	; 02325D36
	beq loc_02325D68	; 02325D38
	add r0,r5,#0x0	; 02325D3A
	bl loc_02326210	; 02325D3C
	cmp r0,#0x0	; 02325D40
	beq loc_02325DA6	; 02325D42
	add r0,r5,#0x0	; 02325D44
	mov r1,#0x5	; 02325D46
	bl loc_023261CC	; 02325D48
	mov r0,#0x0	; 02325D4C
	str r0,[r5,#0x0]	; 02325D4E
	str r0,[r5,#0x4]	; 02325D50
	ldr r1,[r5,#0x38]	; 02325D52
	mov r0,#0x8	; 02325D54
	bic r1,r0	; 02325D56
	str r1,[r5,#0x38]	; 02325D58
	add r5,#0x2c	; 02325D5A
	add r0,r5,#0x0	; 02325D5C
	bl loc_023236BC	; 02325D5E
	bl loc_02326934	; 02325D62
	b loc_02325DA6	; 02325D66
loc_02325D68:
	add r0,r5,#0x0	; 02325D68
	bl loc_02326140	; 02325D6A
	add r0,r5,#0x0	; 02325D6E
	bl loc_02326210	; 02325D70
	cmp r0,#0x0	; 02325D74
	beq loc_02325DA6	; 02325D76
	add r0,r5,#0x0	; 02325D78
	mov r1,#0x1	; 02325D7A
	bl loc_023261CC	; 02325D7C
	mov r0,#0x0	; 02325D80
	str r0,[r5,#0x0]	; 02325D82
	str r0,[r5,#0x4]	; 02325D84
	ldr r1,[r5,#0x38]	; 02325D86
	mov r0,#0x8	; 02325D88
	orr r1,r0	; 02325D8A
	str r1,[r5,#0x38]	; 02325D8C
	add r0,r5,#0x0	; 02325D8E
	bl loc_02326190	; 02325D90
	mov r0,#0x27	; 02325D94
	add r5,#0x2c	; 02325D96
	add r1,r5,#0x0	; 02325D98
	bl loc_023236C8	; 02325D9A
	mov r0,#0x2	; 02325D9E
	mov r1,#0x0	; 02325DA0
	bl loc_0232694C	; 02325DA2
loc_02325DA6:
	pop {r4,r5,r6}	; 02325DA6
	pop {r3}	; 02325DA8
	bx r3	; 02325DAA
pool_02325DAC:
loc_02325DAC:
	.word 0x000005A0	; 02325DAC
pool_02325DB0:
loc_02325DB0:
	.word 0x00000CFF	; 02325DB0
pool_02325DB4:
loc_02325DB4:
	.word 0x023A5C44	; 02325DB4

; ===== function loc_02325DB8 =====
loc_02325DB8:
	push {r4,lr}	; 02325DB8
	add r4,r0,#0x0	; 02325DBA
	ldr r0,[pool_02325E5C]	; 02325DBC
	bl loc_02324108	; 02325DBE
	cmp r0,#0x0	; 02325DC2
	bne loc_02325DCE	; 02325DC4
	bl loc_023240DC	; 02325DC6
	cmp r0,#0x0	; 02325DCA
	beq loc_02325DEE	; 02325DCC
loc_02325DCE:
	add r0,r4,#0x0	; 02325DCE
	mov r1,#0x1	; 02325DD0
	bl loc_023261CC	; 02325DD2
	mov r0,#0x28	; 02325DD6
	bl loc_023236E0	; 02325DD8
	add r0,r4,#0x0	; 02325DDC
	bl loc_02326190	; 02325DDE
	mov r0,#0x7	; 02325DE2
	str r0,[r4,#0x30]	; 02325DE4
	mov r0,#0x0	; 02325DE6
	str r0,[r4,#0x0]	; 02325DE8
	str r0,[r4,#0x4]	; 02325DEA
	b loc_02325E56	; 02325DEC
loc_02325DEE:
	add r0,r4,#0x0	; 02325DEE
	bl loc_02326140	; 02325DF0
	ldr r2,[r4,#0x10]	; 02325DF4
	ldr r1,[r4,#0x14]	; 02325DF6
	ldrb r0,[r2,#0x0]	; 02325DF8
	cmp r1,r0	; 02325DFA
	bne loc_02325E56	; 02325DFC
	ldr r1,[r4,#0x18]	; 02325DFE
	ldrb r0,[r2,#0x1]	; 02325E00
	cmp r1,r0	; 02325E02
	bne loc_02325E56	; 02325E04
	add r0,r4,#0x0	; 02325E06
	mov r1,#0x1	; 02325E08
	bl loc_023261CC	; 02325E0A
	mov r0,#0x1	; 02325E0E
	bl loc_023228B8	; 02325E10
	add r0,r4,#0x0	; 02325E14
	bl loc_02326190	; 02325E16
	add r0,r4,#0x0	; 02325E1A
	add r0,#0x3c	; 02325E1C
	ldr r1,[pool_02325E60]	; 02325E1E
	mov r2,#0x5f	; 02325E20
	bl loc_02324B5C	; 02325E22
	ldr r1,[r4,#0x38]	; 02325E26
	mov r0,#0x8	; 02325E28
	orr r1,r0	; 02325E2A
	str r1,[r4,#0x38]	; 02325E2C
	ldr r1,[r4,#0x38]	; 02325E2E
	mov r0,#0x4	; 02325E30
	orr r1,r0	; 02325E32
	str r1,[r4,#0x38]	; 02325E34
	mov r0,#0x0	; 02325E36
	str r0,[r4,#0x0]	; 02325E38
	str r0,[r4,#0x4]	; 02325E3A
	mov r0,#0x6	; 02325E3C
	str r0,[r4,#0x30]	; 02325E3E
	mov r0,#0x27	; 02325E40
	add r4,#0x2c	; 02325E42
	add r1,r4,#0x0	; 02325E44
	bl loc_023236C8	; 02325E46
	mov r0,#0x2	; 02325E4A
	mov r1,#0x0	; 02325E4C
	bl loc_0232694C	; 02325E4E
	bl loc_02326684	; 02325E52
loc_02325E56:
	pop {r4}	; 02325E56
	pop {r3}	; 02325E58
	bx r3	; 02325E5A
pool_02325E5C:
loc_02325E5C:
	.word 0x00000CFF	; 02325E5C
pool_02325E60:
loc_02325E60:
	.word 0x023A5C44	; 02325E60

; ===== function loc_02325E64 =====
loc_02325E64:
	push {r4,lr}	; 02325E64
	sub sp,#0x8	; 02325E66
	add r4,r0,#0x0	; 02325E68
	bl loc_023252C4	; 02325E6A
	cmp r0,#0x0	; 02325E6E
	beq loc_02325EDA	; 02325E70
	ldr r0,[r4,#0x0]	; 02325E72
	cmp r0,#0x0	; 02325E74
	bne loc_02325E96	; 02325E76
	mov r1,#0x10	; 02325E78
	str r1,[sp,#0x0]	; 02325E7A
	ldr r0,[pool_02325EE4]	; 02325E7C
	ldr r2,[r4,#0xc]	; 02325E7E
	mov r3,#0x0	; 02325E80
	bl loc_0232D958	; 02325E82
	ldr r1,[r4,#0x38]	; 02325E86
	mov r0,#0x2	; 02325E88
	orr r1,r0	; 02325E8A
	str r1,[r4,#0x38]	; 02325E8C
	ldr r0,[r4,#0x0]	; 02325E8E
	add r0,r0,#0x1	; 02325E90
	str r0,[r4,#0x0]	; 02325E92
	b loc_02325EDA	; 02325E94
loc_02325E96:
	cmp r0,#0xf	; 02325E96
	bgt loc_02325EB6	; 02325E98
	lsl r0,r0,#0x4	; 02325E9A
	mov r1,#0xf	; 02325E9C
	blx P1_SignedDivMod	; 02325E9E
	mov r1,#0x10	; 02325EA2
	sub r1,r1,r0	; 02325EA4
	lsl r1,r1,#0x8	; 02325EA6
	orr r0,r1	; 02325EA8
	ldr r1,[pool_02325EE8]	; 02325EAA
	strh r0,[r1,#0x0]	; 02325EAC
	ldr r0,[r4,#0x0]	; 02325EAE
	add r0,r0,#0x1	; 02325EB0
	str r0,[r4,#0x0]	; 02325EB2
	b loc_02325EDA	; 02325EB4
loc_02325EB6:
	mov r0,#0x0	; 02325EB6
	str r0,[r4,#0x0]	; 02325EB8
	ldr r1,[r4,#0x38]	; 02325EBA
	lsl r0,r1,#0x1d	; 02325EBC
	lsr r0,r0,#0x1f	; 02325EBE
	cmp r0,#0x0	; 02325EC0
	beq loc_02325ED0	; 02325EC2
	mov r0,#0x8	; 02325EC4
	bic r1,r0	; 02325EC6
	str r1,[r4,#0x38]	; 02325EC8
	mov r0,#0x6	; 02325ECA
	str r0,[r4,#0x30]	; 02325ECC
	b loc_02325EDA	; 02325ECE
loc_02325ED0:
	add r0,r4,#0x0	; 02325ED0
	bl loc_02326624	; 02325ED2
	mov r0,#0x5	; 02325ED6
	str r0,[r4,#0x30]	; 02325ED8
loc_02325EDA:
	add sp,#0x8	; 02325EDA
	pop {r4}	; 02325EDC
	pop {r3}	; 02325EDE
	bx r3	; 02325EE0
	.byte 0xC0, 0x46	; 02325EE4
pool_02325EE4:
loc_02325EE4:
	.word REG_BLDCNT_SUB	; 02325EE4
pool_02325EE8:
loc_02325EE8:
	.word REG_BLDALPHA_SUB	; 02325EE8

; ===== function loc_02325EEC =====
loc_02325EEC:
	push {r4,lr}	; 02325EEC
	sub sp,#0x8	; 02325EEE
	add r4,r0,#0x0	; 02325EF0
	ldr r0,[r4,#0x0]	; 02325EF2
	cmp r0,#0x0	; 02325EF4
	bne loc_02325F24	; 02325EF6
	ldr r2,[pool_02325F54]	; 02325EF8
	ldr r3,[r2,#0x0]	; 02325EFA
	ldr r0,[pool_02325F58]	; 02325EFC
	and r3,r0	; 02325EFE
	ldr r1,[r4,#0x8]	; 02325F00
	ldr r0,[r4,#0xc]	; 02325F02
	orr r1,r0	; 02325F04
	lsl r0,r1,#0x8	; 02325F06
	orr r3,r0	; 02325F08
	str r3,[r2,#0x0]	; 02325F0A
	mov r0,#0x10	; 02325F0C
	str r0,[sp,#0x0]	; 02325F0E
	ldr r0,[pool_02325F5C]	; 02325F10
	ldr r1,[r4,#0xc]	; 02325F12
	ldr r2,[r4,#0x8]	; 02325F14
	mov r3,#0x0	; 02325F16
	bl loc_0232D958	; 02325F18
	ldr r0,[r4,#0x0]	; 02325F1C
	add r0,r0,#0x1	; 02325F1E
	str r0,[r4,#0x0]	; 02325F20
	b loc_02325F4C	; 02325F22
loc_02325F24:
	cmp r0,#0xf	; 02325F24
	bgt loc_02325F44	; 02325F26
	lsl r0,r0,#0x4	; 02325F28
	mov r1,#0xf	; 02325F2A
	blx P1_SignedDivMod	; 02325F2C
	mov r1,#0x10	; 02325F30
	sub r1,r1,r0	; 02325F32
	lsl r1,r1,#0x8	; 02325F34
	orr r0,r1	; 02325F36
	ldr r1,[pool_02325F60]	; 02325F38
	strh r0,[r1,#0x0]	; 02325F3A
	ldr r0,[r4,#0x0]	; 02325F3C
	add r0,r0,#0x1	; 02325F3E
	str r0,[r4,#0x0]	; 02325F40
	b loc_02325F4C	; 02325F42
loc_02325F44:
	mov r0,#0x0	; 02325F44
	str r0,[r4,#0x0]	; 02325F46
	mov r0,#0x4	; 02325F48
	str r0,[r4,#0x30]	; 02325F4A
loc_02325F4C:
	add sp,#0x8	; 02325F4C
	pop {r4}	; 02325F4E
	pop {r3}	; 02325F50
	bx r3	; 02325F52
pool_02325F54:
loc_02325F54:
	.word REG_DISPCNT_B	; 02325F54
pool_02325F58:
loc_02325F58:
	.word 0xFFFFE0FF	; 02325F58
pool_02325F5C:
loc_02325F5C:
	.word REG_BLDCNT_SUB	; 02325F5C
pool_02325F60:
loc_02325F60:
	.word REG_BLDALPHA_SUB	; 02325F60

; ===== function loc_02325F64 =====
loc_02325F64:
	push {r4,lr}	; 02325F64
	add r4,r1,#0x0	; 02325F66
	bl loc_02325018	; 02325F68
	cmp r0,#0x0	; 02325F6C
	bne loc_02325F7A	; 02325F6E
	mov r0,#0x0	; 02325F70
	str r0,[r4,#0x30]	; 02325F72
	mov r0,#0x3	; 02325F74
	str r0,[r4,#0x34]	; 02325F76
	b loc_02325FC6	; 02325F78
loc_02325F7A:
	bl loc_0232502C	; 02325F7A
	cmp r0,#0x0	; 02325F7E
	bne loc_02325FC6	; 02325F80
	mov r0,#0x0	; 02325F82
	bl loc_023253B0	; 02325F84
	cmp r0,#0x0	; 02325F88
	beq loc_02325FA6	; 02325F8A
	mov r0,#0x1a	; 02325F8C
	bl loc_023236E0	; 02325F8E
	ldr r1,[r4,#0x38]	; 02325F92
	mov r0,#0x1	; 02325F94
	bic r1,r0	; 02325F96
	orr r1,r0	; 02325F98
	str r1,[r4,#0x38]	; 02325F9A
	bl loc_02325038	; 02325F9C
	bl loc_0232690C	; 02325FA0
	b loc_02325FC6	; 02325FA4
loc_02325FA6:
	mov r0,#0x1	; 02325FA6
	bl loc_023253B0	; 02325FA8
	cmp r0,#0x0	; 02325FAC
	beq loc_02325FC6	; 02325FAE
	mov r0,#0x20	; 02325FB0
	bl loc_023236E0	; 02325FB2
	ldr r1,[r4,#0x38]	; 02325FB6
	mov r0,#0x1	; 02325FB8
	bic r1,r0	; 02325FBA
	str r1,[r4,#0x38]	; 02325FBC
	bl loc_02325038	; 02325FBE
	bl loc_0232691C	; 02325FC2
loc_02325FC6:
	pop {r4}	; 02325FC6
	pop {r3}	; 02325FC8
	bx r3	; 02325FCA

; ===== function loc_02325FCC =====
loc_02325FCC:
	push {r4,r5,lr}	; 02325FCC
	sub sp,#0x4	; 02325FCE
	add r5,r1,#0x0	; 02325FD0
	mov r4,#0x0	; 02325FD2
	bl loc_02325018	; 02325FD4
	cmp r0,#0x0	; 02325FD8
	bne loc_02325FF4	; 02325FDA
	ldr r0,[r5,#0x38]	; 02325FDC
	lsl r0,r0,#0x1a	; 02325FDE
	lsr r4,r0,#0x1f	; 02325FE0
	add r0,r5,#0x0	; 02325FE2
	add r0,#0x3c	; 02325FE4
	ldr r1,[pool_0232604C]	; 02325FE6
	mov r2,#0x5e	; 02325FE8
	bl loc_02324B5C	; 02325FEA
	mov r0,#0x0	; 02325FEE
	str r0,[r5,#0x30]	; 02325FF0
	b loc_02326042	; 02325FF2
loc_02325FF4:
	bl loc_0232502C	; 02325FF4
	cmp r0,#0x0	; 02325FF8
	bne loc_02326042	; 02325FFA
	lsl r0,r4,#0	; 02325FFC
	bl loc_023253B0	; 02325FFE
	cmp r0,#0x0	; 02326002
	beq loc_02326026	; 02326004
	mov r0,#0x1b	; 02326006
	bl loc_023236E0	; 02326008
	bl loc_02325038	; 0232600C
	mov r0,#0x1	; 02326010
	bl loc_0232C734	; 02326012
	cmp r0,#0x0	; 02326016
	beq loc_02326020	; 02326018
	mov r0,#0x2	; 0232601A
	str r0,[r5,#0x34]	; 0232601C
	b loc_02326042	; 0232601E
loc_02326020:
	mov r0,#0x3	; 02326020
	str r0,[r5,#0x34]	; 02326022
	b loc_02326042	; 02326024
loc_02326026:
	mov r0,#0x1	; 02326026
	bl loc_023253B0	; 02326028
	cmp r0,#0x0	; 0232602C
	beq loc_02326042	; 0232602E
	mov r0,#0x20	; 02326030
	bl loc_023236E0	; 02326032
	ldr r1,[r5,#0x38]	; 02326036
	mov r0,#0x20	; 02326038
	orr r1,r0	; 0232603A
	str r1,[r5,#0x38]	; 0232603C
	bl loc_02325038	; 0232603E
loc_02326042:
	add r0,r4,#0x0	; 02326042
	add sp,#0x4	; 02326044
	pop {r4,r5}	; 02326046
	pop {r3}	; 02326048
	bx r3	; 0232604A
pool_0232604C:
loc_0232604C:
	.word 0x023A5C44	; 0232604C

; ===== function loc_02326050 =====
loc_02326050:
	ldr r3,[pool_0232606C]	; 02326050
	str r3,[r0,#0x10]	; 02326052
	str r1,[r0,#0x8]	; 02326054
	str r2,[r0,#0xc]	; 02326056
	ldr r2,[r0,#0x38]	; 02326058
	mov r1,#0x10	; 0232605A
	orr r2,r1	; 0232605C
	str r2,[r0,#0x38]	; 0232605E
	mov r1,#0x0	; 02326060
	str r1,[r0,#0x0]	; 02326062
	str r1,[r0,#0x4]	; 02326064
	add r0,#0x2c	; 02326066
	ldr r3,[pool_02326070]	; 02326068
	bx r3	; 0232606A
pool_0232606C:
loc_0232606C:
	.word 0x027FFCD2	; 0232606C
pool_02326070:
loc_02326070:
	.word loc_023236D8 + 1	; 02326070

; ===== function loc_02326074 =====
loc_02326074:
	push {r4,r5,r6,r7,lr}	; 02326074
	sub sp,#0x1fc	; 02326076
	sub sp,#0x10	; 02326078
	add r5,r0,#0x0	; 0232607A
	ldr r1,[r5,#0x38]	; 0232607C
	lsl r0,r1,#0x1d	; 0232607E
	lsr r0,r0,#0x1f	; 02326080
	cmp r0,#0x0	; 02326082
	beq loc_02326124	; 02326084
	ldr r0,[r5,#0x1c]	; 02326086
	cmp r0,#0x0	; 02326088
	bne loc_0232611E	; 0232608A
	lsl r0,r1,#0x1b	; 0232608C
	lsr r0,r0,#0x1f	; 0232608E
	cmp r0,#0x0	; 02326090
	bne loc_02326124	; 02326092
	add r0,sp,#0x8	; 02326094
	ldr r1,[pool_02326130]	; 02326096
	bl P1_ClearByteRangeIfNonNull	; 02326098
	mov r0,#0x60	; 0232609C
	bl loc_02324D9C	; 0232609E
	add r7,r0,#0x0	; 023260A2
	mov r6,#0x0	; 023260A4
	ldr r2,[r5,#0x10]	; 023260A6
	ldrb r1,[r2,#0x0]	; 023260A8
	ldr r0,[r5,#0x14]	; 023260AA
	ldr r3,[r5,#0x18]	; 023260AC
	ldrb r2,[r2,#0x1]	; 023260AE
	sub r4,r3,r2	; 023260B0
	sub r3,r0,r1	; 023260B2
	mov r2,#0x3c	; 023260B4
	mul r3,r2	; 023260B6
	add r4,r4,r3	; 023260B8
	cmp r0,r1	; 023260BA
	bcs loc_023260C2	; 023260BC
	ldr r0,[pool_02326134]	; 023260BE
	add r4,r4,r0	; 023260C0
loc_023260C2:
	add r0,r4,#0x0	; 023260C2
	mov r1,#0x3c	; 023260C4
	blx P1_SignedDivMod	; 023260C6
	add r1,r0,#0x0	; 023260CA
	add r0,sp,#0x0	; 023260CC
	bl loc_02325A20	; 023260CE
	add r0,r4,#0x0	; 023260D2
	mov r1,#0x3c	; 023260D4
	blx P1_SignedDivMod	; 023260D6
	add r0,sp,#0x4	; 023260DA
	bl loc_02325A20	; 023260DC
	mov r2,#0x0	; 023260E0
	add r4,sp,#0x8	; 023260E2
	b loc_023260FC	; 023260E4
loc_023260E6:
	ldr r3,[pool_02326138]	; 023260E6
	cmp r1,r3	; 023260E8
	bne loc_023260F8	; 023260EA
	lsl r3,r6,#0x1	; 023260EC
	add r6,r6,#0x1	; 023260EE
	add r1,sp,#0x0	; 023260F0
	ldrh r1,[r1,r3]	; 023260F2
	strh r1,[r4,r0]	; 023260F4
	b loc_023260FA	; 023260F6
loc_023260F8:
	strh r1,[r4,r0]	; 023260F8
loc_023260FA:
	add r2,r2,#0x1	; 023260FA
loc_023260FC:
	lsl r0,r2,#0x1	; 023260FC
	ldrh r1,[r7,r0]	; 023260FE
	cmp r1,#0x0	; 02326100
	beq loc_0232610A	; 02326102
	ldr r3,[pool_0232613C]	; 02326104
	cmp r2,r3	; 02326106
	blt loc_023260E6	; 02326108
loc_0232610A:
	add r0,r5,#0x0	; 0232610A
	add r0,#0x3c	; 0232610C
	add r1,sp,#0x8	; 0232610E
	bl loc_02324B00	; 02326110
	ldr r1,[r5,#0x38]	; 02326114
	mov r0,#0x10	; 02326116
	orr r1,r0	; 02326118
	str r1,[r5,#0x38]	; 0232611A
	b loc_02326124	; 0232611C
loc_0232611E:
	mov r0,#0x10	; 0232611E
	bic r1,r0	; 02326120
	str r1,[r5,#0x38]	; 02326122
loc_02326124:
	add sp,#0x1fc	; 02326124
	add sp,#0x10	; 02326126
	pop {r4,r5,r6,r7}	; 02326128
	pop {r3}	; 0232612A
	bx r3	; 0232612C
	.byte 0xC0, 0x46	; 02326130
pool_02326130:
loc_02326130:
	.word 0x00000200	; 02326130
pool_02326134:
loc_02326134:
	.word 0x000005A0	; 02326134
pool_02326138:
loc_02326138:
	.word 0x000025CF	; 02326138
pool_0232613C:
loc_0232613C:
	.word 0x00000100	; 0232613C

; ===== function loc_02326140 =====
loc_02326140:
	push {lr}	; 02326140
	sub sp,#0x4	; 02326142
	ldr r2,[r0,#0x4]	; 02326144
	ldr r1,[pool_0232615C]	; 02326146
	cmp r2,r1	; 02326148
	ble loc_02326152	; 0232614A
	bl loc_02326160	; 0232614C
	b loc_02326156	; 02326150
loc_02326152:
	add r1,r2,#0x1	; 02326152
	str r1,[r0,#0x4]	; 02326154
loc_02326156:
	add sp,#0x4	; 02326156
	pop {r3}	; 02326158
	bx r3	; 0232615A
pool_0232615C:
loc_0232615C:
	.word 0x0000012C	; 0232615C

; ===== function loc_02326160 =====
loc_02326160:
	push {lr}	; 02326160
	sub sp,#0x4	; 02326162
	bl P1_GetFirmwareUiContext	; 02326164
	ldr r0,[r0,#0x0]	; 02326168
	lsl r0,r0,#0x15	; 0232616A
	lsr r0,r0,#0x1f	; 0232616C
	cmp r0,#0x0	; 0232616E
	beq loc_0232617A	; 02326170
	mov r0,#0x4	; 02326172
	mov r1,#0x0	; 02326174
	bl loc_0232F2B0	; 02326176
loc_0232617A:
	bl P1_GetFirmwareUiContext	; 0232617A
	ldr r2,[r0,#0x0]	; 0232617E
	ldr r1,[pool_0232618C]	; 02326180
	and r2,r1	; 02326182
	str r2,[r0,#0x0]	; 02326184
	add sp,#0x4	; 02326186
	pop {r3}	; 02326188
	bx r3	; 0232618A
pool_0232618C:
loc_0232618C:
	.word 0xFFFFFBFF	; 0232618C

; ===== function loc_02326190 =====
loc_02326190:
	push {lr}	; 02326190
	sub sp,#0x4	; 02326192
	bl P1_GetFirmwareUiContext	; 02326194
	ldr r0,[r0,#0x0]	; 02326198
	lsl r0,r0,#0x16	; 0232619A
	lsr r0,r0,#0x1f	; 0232619C
	cmp r0,#0x0	; 0232619E
	beq loc_023261B4	; 023261A0
	bl P1_GetFirmwareUiContext	; 023261A2
	ldr r0,[r0,#0x0]	; 023261A6
	lsl r0,r0,#0x15	; 023261A8
	lsr r0,r0,#0x1f	; 023261AA
	cmp r0,#0x0	; 023261AC
	bne loc_023261B4	; 023261AE
	bl loc_02326E28	; 023261B0
loc_023261B4:
	bl P1_GetFirmwareUiContext	; 023261B4
	ldr r2,[r0,#0x0]	; 023261B8
	ldr r1,[pool_023261C8]	; 023261BA
	orr r2,r1	; 023261BC
	str r2,[r0,#0x0]	; 023261BE
	add sp,#0x4	; 023261C0
	pop {r3}	; 023261C2
	bx r3	; 023261C4
	.byte 0xC0, 0x46	; 023261C8
pool_023261C8:
loc_023261C8:
	.word 0x00000400	; 023261C8

; ===== function loc_023261CC =====
loc_023261CC:
	push {r4,r5,r6,lr}	; 023261CC
	add r4,r0,#0x0	; 023261CE
	add r3,r1,#0x0	; 023261D0
	add r6,r4,#0x0	; 023261D2
	add r6,#0x14	; 023261D4
	add r5,r4,#0x0	; 023261D6
	add r5,#0x20	; 023261D8
	add r2,r5,#0x0	; 023261DA
	ldmia r6!,{r0,r1}	; 023261DC
	stmia r5!,{r0,r1}	; 023261DE
	ldr r0,[r6,#0x0]	; 023261E0
	str r0,[r5,#0x0]	; 023261E2
	ldr r0,[r4,#0x24]	; 023261E4
	add r0,r0,r3	; 023261E6
	cmp r0,#0x3c	; 023261E8
	bcc loc_02326208	; 023261EA
	ldr r0,[r4,#0x20]	; 023261EC
	cmp r0,#0x17	; 023261EE
	bne loc_023261F8	; 023261F0
	mov r0,#0x0	; 023261F2
	str r0,[r4,#0x20]	; 023261F4
	b loc_023261FE	; 023261F6
loc_023261F8:
	ldr r0,[r2,#0x0]	; 023261F8
	add r0,r0,#0x1	; 023261FA
	str r0,[r2,#0x0]	; 023261FC
loc_023261FE:
	ldr r0,[r4,#0x24]	; 023261FE
	sub r3,#0x3c	; 02326200
	add r0,r0,r3	; 02326202
	str r0,[r4,#0x24]	; 02326204
	b loc_0232620A	; 02326206
loc_02326208:
	str r0,[r4,#0x24]	; 02326208
loc_0232620A:
	pop {r4,r5,r6}	; 0232620A
	pop {r3}	; 0232620C
	bx r3	; 0232620E

; ===== function loc_02326210 =====
loc_02326210:
	ldr r2,[r0,#0x20]	; 02326210
	ldr r1,[r0,#0x14]	; 02326212
	cmp r2,r1	; 02326214
	bne loc_0232622C	; 02326216
	ldr r2,[r0,#0x24]	; 02326218
	ldr r1,[r0,#0x18]	; 0232621A
	cmp r2,r1	; 0232621C
	bne loc_0232622C	; 0232621E
	ldr r1,[r0,#0x28]	; 02326220
	ldr r0,[r0,#0x1c]	; 02326222
	cmp r1,r0	; 02326224
	bne loc_0232622C	; 02326226
	mov r0,#0x1	; 02326228
	bx lr	; 0232622A
loc_0232622C:
	mov r0,#0x0	; 0232622C
	bx lr	; 0232622E

; ===== function loc_02326230 =====
loc_02326230:
	push {lr}	; 02326230
	sub sp,#0x4	; 02326232
	ldr r1,[pool_02326278]	; 02326234
	ldrh r1,[r1,#0x0]	; 02326236
	lsl r1,r1,#0x1d	; 02326238
	lsr r1,r1,#0x1d	; 0232623A
	cmp r1,#0x5	; 0232623C
	bhi loc_0232625A	; 0232623E
	add r1,r1,r1	; 02326240
P1_SwitchIndexPC_02326240:
	add r1,pc	; 02326242
	ldrh r1,[r1,#(P1_SwitchTable_02326240 - (P1_SwitchIndexPC_02326240 + 4))]	; 02326244
	lsl r1,r1,#0x10	; 02326246
	asr r1,r1,#0x10	; 02326248
P1_SwitchTargetPC_02326240:
	add r1,pc	; 0232624A
	bx r1	; 0232624C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02326240:
	.halfword (loc_0232625A + 1) - (P1_SwitchTargetPC_02326240 + 4)
	.halfword (loc_0232625A + 1) - (P1_SwitchTargetPC_02326240 + 4)
	.halfword (loc_0232626A + 1) - (P1_SwitchTargetPC_02326240 + 4)
	.halfword (loc_02326262 + 1) - (P1_SwitchTargetPC_02326240 + 4)
	.halfword (loc_0232626A + 1) - (P1_SwitchTargetPC_02326240 + 4)
	.halfword (loc_0232626A + 1) - (P1_SwitchTargetPC_02326240 + 4)
P1_SwitchTable_02326240End:
loc_0232625A:
	ldr r1,[pool_0232627C]	; 0232625A
	bl P1_Utf16StrCpy	; 0232625C
	b loc_02326270	; 02326260
loc_02326262:
	ldr r1,[pool_02326280]	; 02326262
	bl P1_Utf16StrCpy	; 02326264
	b loc_02326270	; 02326268
loc_0232626A:
	ldr r1,[pool_02326284]	; 0232626A
	bl P1_Utf16StrCpy	; 0232626C
loc_02326270:
	add sp,#0x4	; 02326270
	pop {r3}	; 02326272
	bx r3	; 02326274
	.byte 0xC0, 0x46	; 02326278
pool_02326278:
loc_02326278:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02326278
pool_0232627C:
loc_0232627C:
	.word 0x023308B0	; 0232627C
pool_02326280:
loc_02326280:
	.word 0x023308BC	; 02326280
pool_02326284:
loc_02326284:
	.word 0x023308CC	; 02326284

; ===== function loc_02326288 =====
P1_Entry_02326288:
	push {lr}	; 02326288
	sub sp,#0x4	; 0232628A
	ldr r1,[pool_023262D8]	; 0232628C
	ldrh r1,[r1,#0x0]	; 0232628E
	lsl r1,r1,#0x1d	; 02326290
	lsr r1,r1,#0x1d	; 02326292
	cmp r1,#0x5	; 02326294
	bhi loc_023262B2	; 02326296
	add r1,r1,r1	; 02326298
P1_SwitchIndexPC_02326298:
	add r1,pc	; 0232629A
	ldrh r1,[r1,#(P1_SwitchTable_02326298 - (P1_SwitchIndexPC_02326298 + 4))]	; 0232629C
	lsl r1,r1,#0x10	; 0232629E
	asr r1,r1,#0x10	; 023262A0
P1_SwitchTargetPC_02326298:
	add r1,pc	; 023262A2
	bx r1	; 023262A4
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02326298:
	.halfword (loc_023262B2 + 1) - (P1_SwitchTargetPC_02326298 + 4)
	.halfword (loc_023262BA + 1) - (P1_SwitchTargetPC_02326298 + 4)
	.halfword (loc_023262CA + 1) - (P1_SwitchTargetPC_02326298 + 4)
	.halfword (loc_023262C2 + 1) - (P1_SwitchTargetPC_02326298 + 4)
	.halfword (loc_023262CA + 1) - (P1_SwitchTargetPC_02326298 + 4)
	.halfword (loc_023262CA + 1) - (P1_SwitchTargetPC_02326298 + 4)
P1_SwitchTable_02326298End:
loc_023262B2:
	ldr r1,[pool_023262DC]	; 023262B2
	bl P1_Utf16StrCpy	; 023262B4
	b loc_023262D0	; 023262B8
loc_023262BA:
	ldr r1,[pool_023262E0]	; 023262BA
	bl P1_Utf16StrCpy	; 023262BC
	b loc_023262D0	; 023262C0
loc_023262C2:
	ldr r1,[pool_023262E4]	; 023262C2
	bl P1_Utf16StrCpy	; 023262C4
	b loc_023262D0	; 023262C8
loc_023262CA:
	ldr r1,[pool_023262E8]	; 023262CA
	bl P1_Utf16StrCpy	; 023262CC
loc_023262D0:
	add sp,#0x4	; 023262D0
	pop {r3}	; 023262D2
	bx r3	; 023262D4
	.byte 0xC0, 0x46	; 023262D8
pool_023262D8:
loc_023262D8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023262D8
pool_023262DC:
loc_023262DC:
	.word 0x023308D8	; 023262DC
pool_023262E0:
loc_023262E0:
	.word 0x023308F0	; 023262E0
pool_023262E4:
loc_023262E4:
	.word 0x02330908	; 023262E4
pool_023262E8:
loc_023262E8:
	.word 0x02330920	; 023262E8

; ===== function loc_023262EC =====
loc_023262EC:
	push {r4,r5,r6,lr}	; 023262EC
	sub sp,#0x18	; 023262EE
	add r5,r0,#0x0	; 023262F0
	add r4,r2,#0x0	; 023262F2
	add r6,r3,#0x0	; 023262F4
	add r0,sp,#0x10	; 023262F6
	bl loc_02325A20	; 023262F8
	add r0,sp,#0x8	; 023262FC
	add r1,r4,#0x0	; 023262FE
	bl loc_02325A20	; 02326300
	add r0,sp,#0x0	; 02326304
	add r1,r6,#0x0	; 02326306
	bl loc_02325A20	; 02326308
	add r0,r5,#0x0	; 0232630C
	mov r1,#0x59	; 0232630E
	bl P1_Utf16StrChr	; 02326310
	cmp r0,#0x0	; 02326314
	beq loc_02326320	; 02326316
	add r1,sp,#0x10	; 02326318
	mov r2,#0x2	; 0232631A
	bl P1_Utf16StrNCpy	; 0232631C
loc_02326320:
	add r0,r5,#0x0	; 02326320
	mov r1,#0x4d	; 02326322
	bl P1_Utf16StrChr	; 02326324
	cmp r0,#0x0	; 02326328
	beq loc_02326334	; 0232632A
	add r1,sp,#0x8	; 0232632C
	mov r2,#0x2	; 0232632E
	bl P1_Utf16StrNCpy	; 02326330
loc_02326334:
	add r0,r5,#0x0	; 02326334
	mov r1,#0x44	; 02326336
	bl P1_Utf16StrChr	; 02326338
	cmp r0,#0x0	; 0232633C
	beq loc_02326348	; 0232633E
	add r1,sp,#0x0	; 02326340
	mov r2,#0x2	; 02326342
	bl P1_Utf16StrNCpy	; 02326344
loc_02326348:
	add sp,#0x18	; 02326348
	pop {r4,r5,r6}	; 0232634A
	pop {r3}	; 0232634C
	bx r3	; 0232634E

; ===== function loc_02326350 =====
P1_Entry_02326350:
	push {r4,lr}	; 02326350
	add r4,r0,#0x0	; 02326352
	bl loc_02326230	; 02326354
	add r0,r4,#0x0	; 02326358
	mov r1,#0x0	; 0232635A
	ldr r3,[pool_0232636C]	; 0232635C
	ldrb r2,[r3,#0x0]	; 0232635E
	ldrb r3,[r3,#0x1]	; 02326360
	bl loc_023262EC	; 02326362
	pop {r4}	; 02326366
	pop {r3}	; 02326368
	bx r3	; 0232636A
pool_0232636C:
loc_0232636C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 0232636C

; ===== function loc_02326370 =====
loc_02326370:
	push {r4,lr}	; 02326370
	sub sp,#0x10	; 02326372
	add r4,r0,#0x0	; 02326374
	add r0,sp,#0x0	; 02326376
	bl loc_02326A2C	; 02326378
	add r0,r4,#0x0	; 0232637C
	bl loc_02326230	; 0232637E
	add r0,r4,#0x0	; 02326382
	mov r1,#0x0	; 02326384
	ldr r2,[sp,#0x4]	; 02326386
	ldr r3,[sp,#0x8]	; 02326388
	bl loc_023262EC	; 0232638A
	add sp,#0x10	; 0232638E
	pop {r4}	; 02326390
	pop {r3}	; 02326392
	bx r3	; 02326394
	.byte 0x00, 0x00	; 02326396
P1_Entry_02326398:
	push {r4,lr}	; 02326398
	sub sp,#0x10	; 0232639A
	add r4,r0,#0x0	; 0232639C
	add r0,sp,#0x0	; 0232639E
	bl loc_02326A2C	; 023263A0
	add r0,r4,#0x0	; 023263A4
	bl P1_Entry_02326288	; 023263A6
	add r0,r4,#0x0	; 023263AA
	ldr r1,[sp,#0x0]	; 023263AC
	ldr r2,[sp,#0x4]	; 023263AE
	ldr r3,[sp,#0x8]	; 023263B0
	bl loc_023262EC	; 023263B2
	add sp,#0x10	; 023263B6
	pop {r4}	; 023263B8
	pop {r3}	; 023263BA
	bx r3	; 023263BC
	.byte 0x00, 0x00	; 023263BE

; ===== function loc_023263C0 =====
loc_023263C0:
	push {r4,lr}	; 023263C0
	sub sp,#0x10	; 023263C2
	add r4,r0,#0x0	; 023263C4
	add r0,sp,#0x0	; 023263C6
	bl loc_02326A48	; 023263C8
	add r0,r4,#0x0	; 023263CC
	ldr r1,[sp,#0x0]	; 023263CE
	bl loc_02325A20	; 023263D0
	mov r1,#0x3a	; 023263D4
	strh r1,[r0,#0x0]	; 023263D6
	add r0,r0,#0x2	; 023263D8
	ldr r1,[sp,#0x4]	; 023263DA
	bl loc_02325A20	; 023263DC
	add sp,#0x10	; 023263E0
	pop {r4}	; 023263E2
	pop {r3}	; 023263E4
	bx r3	; 023263E6
P1_Entry_023263E8:
	ldr r0,[pool_023263F8]	; 023263E8
	ldrb r0,[r0,#0x0]	; 023263EA
	lsl r0,r0,#0x1c	; 023263EC
	lsr r0,r0,#0x1c	; 023263EE
	cmp r0,#0x10	; 023263F0
	blt P1_Entry_023263F6	; 023263F2
	mov r0,#0x1	; 023263F4
P1_Entry_023263F6:
	bx lr	; 023263F6
pool_023263F8:
	.word FirmwareUserSettingsSharedAddress + UserSettingsThemeOffset	; 023263F8
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x08, 0x48, 0x09, 0x49, 0x02, 0x1C, 0x34, 0x32, 0x12, 0x78, 0x52, 0x00	; 023263FC
	.byte 0x07, 0xF0, 0x08, 0xED, 0x00, 0x22, 0x04, 0x48, 0x34, 0x30, 0x00, 0x78, 0x41, 0x00, 0x03, 0x48	; 0232640C
	.byte 0x42, 0x52, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x9C, 0xFC, 0x7F, 0x02, 0xF0, 0x4C, 0x35, 0x02	; 0232641C

; ===== function loc_0232642C =====
loc_0232642C:
	push {lr}	; 0232642C
	sub sp,#0x4	; 0232642E
	ldr r0,[pool_02326450]	; 02326430
	ldr r1,[pool_02326454]	; 02326432
	ldrb r2,[r0,#0x14]	; 02326434
	lsl r2,r2,#0x1	; 02326436
	blx loc_0232DE20	; 02326438
	mov r2,#0x0	; 0232643C
	ldr r0,[pool_02326450]	; 0232643E
	ldrb r0,[r0,#0x14]	; 02326440
	lsl r1,r0,#0x1	; 02326442
	ldr r0,[pool_02326454]	; 02326444
	strh r2,[r0,r1]	; 02326446
	add sp,#0x4	; 02326448
	pop {r3}	; 0232644A
	bx r3	; 0232644C
	.byte 0xC0, 0x46	; 02326450
pool_02326450:
loc_02326450:
	.word FirmwareUserSettingsSharedAddress + UserSettingsNameOffset	; 02326450
pool_02326454:
loc_02326454:
	.word P1_BssStart + 0x24218	; 02326454

; ===== function loc_02326458 =====
loc_02326458:
	push {r4,r5,r6,r7,lr}	; 02326458
	sub sp,#0x14	; 0232645A
	add r6,r0,#0x0	; 0232645C
	add r7,r1,#0x0	; 0232645E
	add r5,r2,#0x0	; 02326460
	bl loc_02323E40	; 02326462
	str r0,[sp,#0x0]	; 02326466
	mov r4,#0x0	; 02326468
	str r4,[sp,#0x4]	; 0232646A
loc_0232646C:
	lsl r1,r4,#0x3	; 0232646C
	ldr r0,[pool_023264D4]	; 0232646E
	add r1,r0,r1	; 02326470
	ldr r0,[pool_023264D8]	; 02326472
	ldr r0,[r1,r0]	; 02326474
	ldr r2,[pool_023264DC]	; 02326476
	ldr r1,[r1,r2]	; 02326478
	str r0,[sp,#0x8]	; 0232647A
	str r1,[sp,#0xc]	; 0232647C
	add r0,sp,#0x8	; 0232647E
	ldr r2,[r0,#0x0]	; 02326480
	add r0,r2,#0x0	; 02326482
	ldr r1,[pool_023264E0]	; 02326484
	and r0,r1	; 02326486
	lsl r1,r2,#0x7	; 02326488
	lsr r1,r1,#0x17	; 0232648A
	add r2,r1,r6	; 0232648C
	ldr r1,[pool_023264E4]	; 0232648E
	and r2,r1	; 02326490
	lsl r1,r2,#0x10	; 02326492
	orr r0,r1	; 02326494
	add r1,sp,#0x8	; 02326496
	str r0,[r1,#0x0]	; 02326498
	add r0,sp,#0x8	; 0232649A
	ldrb r0,[r0,#0x0]	; 0232649C
	add r1,r0,r7	; 0232649E
	add r0,sp,#0x8	; 023264A0
	strb r1,[r0,#0x0]	; 023264A2
	cmp r5,#0x0	; 023264A4
	blt loc_023264BA	; 023264A6
	ldr r0,[sp,#0xc]	; 023264A8
	ldr r1,[pool_023264E8]	; 023264AA
	and r0,r1	; 023264AC
	add r2,r5,#0x0	; 023264AE
	mov r1,#0xf	; 023264B0
	and r2,r1	; 023264B2
	lsl r1,r2,#0xc	; 023264B4
	orr r0,r1	; 023264B6
	str r0,[sp,#0xc]	; 023264B8
loc_023264BA:
	ldr r0,[sp,#0x0]	; 023264BA
	add r1,sp,#0x8	; 023264BC
	ldr r2,[sp,#0x4]	; 023264BE
	bl loc_0232395C	; 023264C0
	add r4,r4,#0x1	; 023264C4
	cmp r4,#0x1a	; 023264C6
	blt loc_0232646C	; 023264C8
	add sp,#0x14	; 023264CA
	pop {r4,r5,r6,r7}	; 023264CC
	pop {r3}	; 023264CE
	bx r3	; 023264D0
	.byte 0xC0, 0x46	; 023264D4
pool_023264D4:
loc_023264D4:
	.word 0x02354D28	; 023264D4
pool_023264D8:
loc_023264D8:
	.word 0x00000AA0	; 023264D8
pool_023264DC:
loc_023264DC:
	.word 0x00000AA4	; 023264DC
pool_023264E0:
loc_023264E0:
	.word 0xFE00FFFF	; 023264E0
pool_023264E4:
loc_023264E4:
	.word 0x000001FF	; 023264E4
pool_023264E8:
loc_023264E8:
	.word 0xFFFF0FFF	; 023264E8

; ===== function loc_023264EC =====
loc_023264EC:
	push {r4,r5,r6,r7,lr}	; 023264EC
	sub sp,#0x4	; 023264EE
	ldr r0,[pool_02326574]	; 023264F0
	ldr r1,[pool_02326578]	; 023264F2
	mov r2,#0x8	; 023264F4
	ldr r3,[pool_0232657C]	; 023264F6
	bl loc_0232863C	; 023264F8
	ldr r0,[pool_02326578]	; 023264FC
	ldr r1,[pool_02326580]	; 023264FE
	blx P1_CleanDataCacheRange	; 02326500
	mov r5,#0x0	; 02326504
	ldr r4,[pool_02326578]	; 02326506
	mov r7,#0x20	; 02326508
	ldr r6,[pool_02326584]	; 0232650A
loc_0232650C:
	lsl r0,r5,#0x5	; 0232650C
	add r0,r4,r0	; 0232650E
	lsl r1,r5,#0x7	; 02326510
	add r1,r1,r6	; 02326512
	add r2,r7,#0x0	; 02326514
	bl loc_0232DC20	; 02326516
	add r5,r5,#0x1	; 0232651A
	cmp r5,#0x1a	; 0232651C
	blt loc_0232650C	; 0232651E
	ldr r0,[pool_02326588]	; 02326520
	ldr r1,[pool_0232658C]	; 02326522
	mov r2,#0x2	; 02326524
	bl loc_0232DCC0	; 02326526
	mov r2,#0x0	; 0232652A
	str r2,[sp,#0x0]	; 0232652C
loc_0232652E:
	ldr r5,[sp,#0x0]	; 0232652E
	lsl r4,r2,#0x3	; 02326530
	mov r0,#0xff	; 02326532
	and r4,r0	; 02326534
	add r7,r2,#0x0	; 02326536
	mov r0,#0xd	; 02326538
	mul r7,r0	; 0232653A
	lsl r1,r7,#0x3	; 0232653C
	ldr r0,[pool_02326578]	; 0232653E
	add r3,r0,r1	; 02326540
loc_02326542:
	lsl r6,r5,#0x3	; 02326542
	add r1,r3,r6	; 02326544
	ldr r0,[pool_02326590]	; 02326546
	and r6,r0	; 02326548
	lsl r6,r6,#0x10	; 0232654A
	orr r6,r4	; 0232654C
	ldr r0,[pool_02326594]	; 0232654E
	str r6,[r1,r0]	; 02326550
	add r6,r5,r7	; 02326552
	ldr r0,[pool_02326580]	; 02326554
	add r0,r6,r0	; 02326556
	ldr r6,[pool_02326598]	; 02326558
	orr r0,r6	; 0232655A
	ldr r6,[pool_0232659C]	; 0232655C
	strh r0,[r1,r6]	; 0232655E
	add r5,r5,#0x1	; 02326560
	cmp r5,#0xd	; 02326562
	blt loc_02326542	; 02326564
	add r2,r2,#0x1	; 02326566
	cmp r2,#0x2	; 02326568
	blt loc_0232652E	; 0232656A
	add sp,#0x4	; 0232656C
	pop {r4,r5,r6,r7}	; 0232656E
	pop {r3}	; 02326570
	bx r3	; 02326572
pool_02326574:
loc_02326574:
	.word 0x027FFEC0	; 02326574
pool_02326578:
loc_02326578:
	.word 0x02354D28	; 02326578
pool_0232657C:
loc_0232657C:
	.word 0x023550C8	; 0232657C
pool_02326580:
loc_02326580:
	.word 0x000003A0	; 02326580
pool_02326584:
loc_02326584:
	.word 0x0001D000	; 02326584
pool_02326588:
loc_02326588:
	.word 0x023301F0	; 02326588
pool_0232658C:
loc_0232658C:
	.word 0x000001F0	; 0232658C
pool_02326590:
loc_02326590:
	.word 0x000001FF	; 02326590
pool_02326594:
loc_02326594:
	.word 0x00000AA0	; 02326594
pool_02326598:
loc_02326598:
	.word 0x0000F000	; 02326598
pool_0232659C:
loc_0232659C:
	.word 0x00000AA4	; 0232659C

; ===== function loc_023265A0 =====
loc_023265A0:
; 保存 r0 的开盖回调；空指针表示不回调。
; Save the lid-open callback in r0; null disables its notification.
.func P1_SetLidOpenedCallback
	ldr r1,[pool_023265A8]	; 023265A0
	str r0,[r1,#0x0]	; 023265A2
	bx lr	; 023265A4
.endfunc
	.byte 0xC0, 0x46	; 023265A8
pool_023265A8:
loc_023265A8:
	.word P1_LidOpenedCallbackSlot	; 023265A8
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


; ===== function loc_023265C4 =====
loc_023265C4:
	push {lr}	; 023265C4
	sub sp,#0x4	; 023265C6
	ldr r0,[pool_023265F4]	; 023265C8
	ldr r1,[r0,#0x0]	; 023265CA
	mov r0,#0x1	; 023265CC
	and r1,r0	; 023265CE
	cmp r1,#0x1	; 023265D0
	bne loc_023265EE	; 023265D2
	blx P1_Arm9DisableIrqReturnPriorMask	; 023265D4
	ldr r2,[pool_023265F4]	; 023265D8
	ldr r3,[r2,#0x0]	; 023265DA
	mov r1,#0x1	; 023265DC
	bic r3,r1	; 023265DE
	str r3,[r2,#0x0]	; 023265E0
	ldr r3,[r2,#0x0]	; 023265E2
	mov r1,#0x2	; 023265E4
	bic r3,r1	; 023265E6
	str r3,[r2,#0x0]	; 023265E8
	blx P1_Arm9RestoreIrqMask	; 023265EA
loc_023265EE:
	add sp,#0x4	; 023265EE
	pop {r3}	; 023265F0
	bx r3	; 023265F2
pool_023265F4:
loc_023265F4:
	.word P1_BssStart + 0x24DD8	; 023265F4

; ===== function loc_023265F8 =====
loc_023265F8:
	push {lr}	; 023265F8
	sub sp,#0x4	; 023265FA
	ldr r0,[pool_02326620]	; 023265FC
	ldr r1,[r0,#0x0]	; 023265FE
	mov r0,#0x1	; 02326600
	and r1,r0	; 02326602
	cmp r1,#0x1	; 02326604
	bne loc_0232661A	; 02326606
	blx P1_Arm9DisableIrqReturnPriorMask	; 02326608
	ldr r2,[pool_02326620]	; 0232660C
	ldr r3,[r2,#0x0]	; 0232660E
	mov r1,#0x2	; 02326610
	bic r3,r1	; 02326612
	str r3,[r2,#0x0]	; 02326614
	blx P1_Arm9RestoreIrqMask	; 02326616
loc_0232661A:
	add sp,#0x4	; 0232661A
	pop {r3}	; 0232661C
	bx r3	; 0232661E
pool_02326620:
loc_02326620:
	.word P1_BssStart + 0x24DD8	; 02326620

; ===== function loc_02326624 =====
loc_02326624:
	push {lr}	; 02326624
	sub sp,#0x4	; 02326626
	ldr r2,[pool_02326674]	; 02326628
	ldr r3,[r2,#0x0]	; 0232662A
	mov r1,#0x10	; 0232662C
	and r3,r1	; 0232662E
	cmp r3,#0x10	; 02326630
	beq loc_0232666C	; 02326632
	ldr r1,[r2,#0x0]	; 02326634
	mov r3,#0x1	; 02326636
	orr r1,r3	; 02326638
	str r1,[r2,#0x0]	; 0232663A
	ldr r1,[r0,#0x10]	; 0232663C
	ldrb r2,[r1,#0x0]	; 0232663E
	ldr r1,[pool_02326678]	; 02326640
	str r2,[r1,#0x4]	; 02326642
	ldr r0,[r0,#0x10]	; 02326644
	ldrb r0,[r0,#0x1]	; 02326646
	str r0,[r1,#0x8]	; 02326648
	mov r0,#0x6	; 0232664A
	str r0,[r1,#0xc]	; 0232664C
	ldr r0,[pool_0232667C]	; 0232664E
	str r3,[r0,#0x0]	; 02326650
	ldr r0,[pool_02326680]	; 02326652
	bl loc_0232FC48	; 02326654
	mov r0,#0x0	; 02326658
	ldr r1,[pool_0232667C]	; 0232665A
	bl loc_0232FBB0	; 0232665C
	mov r0,#0x0	; 02326660
	ldr r1,[pool_02326678]	; 02326662
	bl loc_0232FB04	; 02326664
	mov r0,#0x1	; 02326668
	b loc_0232666E	; 0232666A
loc_0232666C:
	mov r0,#0x0	; 0232666C
loc_0232666E:
	add sp,#0x4	; 0232666E
	pop {r3}	; 02326670
	bx r3	; 02326672
pool_02326674:
loc_02326674:
	.word P1_BssStart + 0x24DD8	; 02326674
pool_02326678:
loc_02326678:
	.word P1_BssStart + 0x24DEC	; 02326678
pool_0232667C:
loc_0232667C:
	.word P1_BssStart + 0x24DDC	; 0232667C
pool_02326680:
loc_02326680:
	.word 0x02326685	; 02326680

; ===== function loc_02326684 =====
loc_02326684:
	ldr r1,[pool_0232669C]	; 02326684
	ldr r2,[r1,#0x0]	; 02326686
	mov r0,#0x1	; 02326688
	and r2,r0	; 0232668A
	cmp r2,#0x1	; 0232668C
	bne loc_02326698	; 0232668E
	ldr r2,[r1,#0x0]	; 02326690
	mov r0,#0x2	; 02326692
	orr r2,r0	; 02326694
	str r2,[r1,#0x0]	; 02326696
loc_02326698:
	bx lr	; 02326698
	.byte 0xC0, 0x46	; 0232669C
pool_0232669C:
loc_0232669C:
	.word P1_BssStart + 0x24DD8	; 0232669C

; ===== function loc_023266A0 =====
loc_023266A0:
; 更新开合盖边沿；按现有状态执行休眠、唤醒及已注册回调。
; Track lid transitions; handle sleep, wake-up and registered callbacks according to current state.
.func P1_UpdateLidAndSleepState
	push {lr}	; 023266A0
	sub sp,#0x4	; 023266A2
	ldr r0,[pool_0232687C]	; 023266A4
	ldrh r1,[r0,#0x0]	; 023266A6
	ldr r0,[pool_02326880]	; 023266A8
	and r1,r0	; 023266AA
	asr r0,r1,#0xf	; 023266AC
	ldr r1,[pool_02326884]	; 023266AE
	ldr r2,[r1,#0x0]	; 023266B0
	ldr r1,[pool_02326888]	; 023266B2
	and r2,r1	; 023266B4
	cmp r2,r1	; 023266B6
	bne loc_023266BE	; 023266B8
	mov r3,#0x1	; 023266BA
	b loc_023266C0	; 023266BC
loc_023266BE:
	mov r3,#0x0	; 023266BE
loc_023266C0:
	mvn r2,r0	; 023266C0
	add r1,r0,#0x0	; 023266C2
	eor r1,r3	; 023266C4
	and r2,r1	; 023266C6
	cmp r2,#0x0	; 023266C8
	beq loc_023266D8	; 023266CA
	ldr r2,[pool_02326884]	; 023266CC
	ldr r3,[r2,#0x0]	; 023266CE
	ldr r1,[pool_0232688C]	; 023266D0
	orr r3,r1	; 023266D2
	str r3,[r2,#0x0]	; 023266D4
	b loc_023266E2	; 023266D6
loc_023266D8:
	ldr r2,[pool_02326884]	; 023266D8
	ldr r3,[r2,#0x0]	; 023266DA
	ldr r1,[pool_02326890]	; 023266DC
	and r3,r1	; 023266DE
	str r3,[r2,#0x0]	; 023266E0
loc_023266E2:
	cmp r0,#0x0	; 023266E2
	beq loc_023266F2	; 023266E4
	ldr r1,[pool_02326884]	; 023266E6
	ldr r2,[r1,#0x0]	; 023266E8
	ldr r0,[pool_02326888]	; 023266EA
	orr r2,r0	; 023266EC
	str r2,[r1,#0x0]	; 023266EE
	b loc_023266FC	; 023266F0
loc_023266F2:
	ldr r1,[pool_02326884]	; 023266F2
	ldr r2,[r1,#0x0]	; 023266F4
	ldr r0,[pool_02326894]	; 023266F6
	and r2,r0	; 023266F8
	str r2,[r1,#0x0]	; 023266FA
loc_023266FC:
	ldr r1,[pool_02326884]	; 023266FC
	ldr r2,[r1,#0x0]	; 023266FE
	mov r0,#0x2	; 02326700
	and r2,r0	; 02326702
	cmp r2,#0x2	; 02326704
	beq loc_02326790	; 02326706
	ldr r0,[pool_0232687C]	; 02326708
	ldrh r2,[r0,#0x0]	; 0232670A
	ldr r0,[pool_02326880]	; 0232670C
	and r2,r0	; 0232670E
	asr r0,r2,#0xf	; 02326710
	cmp r0,#0x0	; 02326712
	beq loc_02326790	; 02326714
	ldr r2,[r1,#0x0]	; 02326716
	mov r0,#0x40	; 02326718
	orr r2,r0	; 0232671A
	str r2,[r1,#0x0]	; 0232671C
	bl loc_02329D38	; 0232671E
	ldr r0,[pool_02326898]	; 02326722
	ldr r0,[r0,#0x0]	; 02326724
	cmp r0,#0x0	; 02326726
	beq loc_0232672C	; 02326728
	blx r0	; 0232672A
loc_0232672C:
	bl loc_02327C04	; 0232672C
	mov r0,#0x1	; 02326730
	add r1,r0,#0x0	; 02326732
	blx loc_0232AFC8	; 02326734
	bl loc_02326934	; 02326738
	bl loc_0232D4AC	; 0232673C
	ldr r2,[pool_0232689C]	; 02326740
	ldr r1,[r2,#0x0]	; 02326742
	ldr r0,[pool_023268A0]	; 02326744
	and r1,r0	; 02326746
	str r1,[r2,#0x0]	; 02326748
	mov r0,#0x1	; 0232674A
	add r1,r0,#0x0	; 0232674C
	blx loc_0232AFC8	; 0232674E
	ldr r0,[pool_02326884]	; 02326752
	ldr r1,[r0,#0x0]	; 02326754
	mov r0,#0x1	; 02326756
	and r1,r0	; 02326758
	cmp r1,#0x1	; 0232675A
	bne loc_02326762	; 0232675C
	mov r0,#0x2	; 0232675E
	b loc_02326764	; 02326760
loc_02326762:
	mov r0,#0x0	; 02326762
loc_02326764:
	mov r1,#0x4	; 02326764
	orr r0,r1	; 02326766
	mov r1,#0x0	; 02326768
	add r2,r1,#0x0	; 0232676A
	bl loc_0232F09C	; 0232676C
	mov r0,#0x1	; 02326770
	add r1,r0,#0x0	; 02326772
	blx loc_0232AFC8	; 02326774
	mov r0,#0x1	; 02326778
	add r1,r0,#0x0	; 0232677A
	blx loc_0232AFC8	; 0232677C
	bl loc_0232D46C	; 02326780
	ldr r2,[pool_0232689C]	; 02326784
	ldr r1,[r2,#0x0]	; 02326786
	ldr r0,[pool_023268A4]	; 02326788
	orr r1,r0	; 0232678A
	str r1,[r2,#0x0]	; 0232678C
	b loc_023267D6	; 0232678E
loc_02326790:
	bl P1_GetFirmwareUiContext	; 02326790
	ldr r0,[r0,#0x0]	; 02326794
	lsl r0,r0,#0x16	; 02326796
	lsr r0,r0,#0x1f	; 02326798
	cmp r0,#0x0	; 0232679A
	beq loc_023267D6	; 0232679C
	bl P1_GetFirmwareUiContext	; 0232679E
	ldr r0,[r0,#0x0]	; 023267A2
	lsl r0,r0,#0x15	; 023267A4
	lsr r0,r0,#0x1f	; 023267A6
	cmp r0,#0x0	; 023267A8
	beq loc_023267D6	; 023267AA
	bl P1_GetFirmwareUiContext	; 023267AC
	ldr r0,[r0,#0x0]	; 023267B0
	lsl r0,r0,#0x1b	; 023267B2
	lsr r0,r0,#0x1f	; 023267B4
	cmp r0,#0x0	; 023267B6
	bne loc_023267D6	; 023267B8
	ldr r0,[pool_0232687C]	; 023267BA
	ldrh r1,[r0,#0x0]	; 023267BC
	ldr r0,[pool_02326880]	; 023267BE
	and r1,r0	; 023267C0
	asr r0,r1,#0xf	; 023267C2
	cmp r0,#0x0	; 023267C4
	beq loc_023267D2	; 023267C6
	mov r0,#0x2	; 023267C8
	mov r1,#0x0	; 023267CA
	bl loc_0232F1DC	; 023267CC
	b loc_023267D6	; 023267D0
loc_023267D2:
	bl loc_02326E28	; 023267D2
loc_023267D6:
	ldr r0,[pool_02326884]	; 023267D6
	ldr r1,[r0,#0x0]	; 023267D8
	mov r0,#0x40	; 023267DA
	and r1,r0	; 023267DC
	cmp r1,#0x40	; 023267DE
	bne loc_0232682A	; 023267E0
	bl loc_02327C24	; 023267E2
	bl loc_02327C04	; 023267E6
	bl loc_02327C24	; 023267EA
	cmp r0,#0x0	; 023267EE
	bne loc_0232680C	; 023267F0
	ldr r0,[pool_023268A8]	; 023267F2
	ldr r0,[r0,#0x0]	; 023267F4
	mov r1,#0x1	; 023267F6
	and r0,r1	; 023267F8
	cmp r0,#0x0	; 023267FA
	bne loc_02326800	; 023267FC
	mov r1,#0x0	; 023267FE
loc_02326800:
	cmp r1,#0x0	; 02326800
	beq loc_02326810	; 02326802
	bl loc_0232C6C8	; 02326804
	cmp r0,#0x0	; 02326808
	beq loc_02326810	; 0232680A
loc_0232680C:
	bl loc_0232F1AC	; 0232680C
loc_02326810:
	ldr r0,[pool_023268AC]	; 02326810
	ldr r0,[r0,#0x0]	; 02326812
	cmp r0,#0x0	; 02326814
	beq loc_0232681A	; 02326816
	blx r0	; 02326818
loc_0232681A:
	bl loc_02329D30	; 0232681A
	ldr r1,[pool_02326884]	; 0232681E
	ldr r2,[r1,#0x0]	; 02326820
	mov r0,#0x40	; 02326822
	bic r2,r0	; 02326824
	str r2,[r1,#0x0]	; 02326826
	b loc_02326876	; 02326828
loc_0232682A:
	bl loc_02327C24	; 0232682A
	cmp r0,#0x0	; 0232682E
	bne loc_0232684C	; 02326830
	ldr r0,[pool_023268A8]	; 02326832
	ldr r0,[r0,#0x0]	; 02326834
	mov r1,#0x1	; 02326836
	and r0,r1	; 02326838
	cmp r0,#0x0	; 0232683A
	bne loc_02326840	; 0232683C
	mov r1,#0x0	; 0232683E
loc_02326840:
	cmp r1,#0x0	; 02326840
	beq loc_02326860	; 02326842
	bl loc_0232C6C8	; 02326844
	cmp r0,#0x0	; 02326848
	beq loc_02326860	; 0232684A
loc_0232684C:
	bl loc_02329D38	; 0232684C
	ldr r0,[pool_02326898]	; 02326850
	ldr r0,[r0,#0x0]	; 02326852
	cmp r0,#0x0	; 02326854
	beq loc_0232685A	; 02326856
	blx r0	; 02326858
loc_0232685A:
	bl loc_0232C528	; 0232685A
	b loc_02326876	; 0232685E
loc_02326860:
	ldr r0,[pool_02326884]	; 02326860
	ldr r1,[r0,#0x0]	; 02326862
	ldr r0,[pool_0232688C]	; 02326864
	and r1,r0	; 02326866
	cmp r1,r0	; 02326868
	bne loc_02326876	; 0232686A
	ldr r0,[pool_023268B0]	; 0232686C
	ldr r0,[r0,#0x0]	; 0232686E
	cmp r0,#0x0	; 02326870
	beq loc_02326876	; 02326872
	blx r0	; 02326874
loc_02326876:
	add sp,#0x4	; 02326876
	pop {r3}	; 02326878
	bx r3	; 0232687A
.endfunc
pool_0232687C:
loc_0232687C:
	.word FirmwareSystemWorkAddress + SystemWorkKeyXYStateOffset	; 0232687C
pool_02326880:
loc_02326880:
	.word SystemWorkLidClosedMask	; 02326880
pool_02326884:
loc_02326884:
	.word P1_LidAndSleepState	; 02326884
pool_02326888:
loc_02326888:
	.word LidStateClosedMask	; 02326888
pool_0232688C:
loc_0232688C:
	.word LidStateOpenedMask	; 0232688C
pool_02326890:
loc_02326890:
	.word (0xFFFFFFFF ^ LidStateOpenedMask)	; 02326890
pool_02326894:
loc_02326894:
	.word (0xFFFFFFFF ^ LidStateClosedMask)	; 02326894
pool_02326898:
loc_02326898:
	.word P1_BeforeSleepCallbackSlot	; 02326898
pool_0232689C:
loc_0232689C:
	.word REG_DISPCNT_B	; 0232689C
pool_023268A0:
loc_023268A0:
	.word 0xFFFEFFFF	; 023268A0
pool_023268A4:
loc_023268A4:
	.word 0x00010000	; 023268A4
pool_023268A8:
loc_023268A8:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023268A8
pool_023268AC:
loc_023268AC:
	.word P1_AfterSleepCallbackSlot	; 023268AC
pool_023268B0:
loc_023268B0:
	.word P1_LidOpenedCallbackSlot	; 023268B0

; ===== function loc_023268B4 =====
loc_023268B4:
	push {lr}	; 023268B4
	sub sp,#0x4	; 023268B6
	mov r0,#0x0	; 023268B8
	ldr r1,[pool_023268DC]	; 023268BA
	str r0,[r1,#0x0]	; 023268BC
	ldr r1,[pool_023268E0]	; 023268BE
	str r0,[r1,#0x0]	; 023268C0
	ldr r1,[pool_023268E4]	; 023268C2
	str r0,[r1,#0x0]	; 023268C4
	ldr r1,[pool_023268E8]	; 023268C6
	str r0,[r1,#0x0]	; 023268C8
	bl loc_0232FBB0	; 023268CA
	mov r0,#0x1	; 023268CE
	ldr r1,[pool_023268E8]	; 023268D0
	bl loc_0232FBB0	; 023268D2
	add sp,#0x4	; 023268D6
	pop {r3}	; 023268D8
	bx r3	; 023268DA
pool_023268DC:
loc_023268DC:
	.word P1_BssStart + 0x24DD8	; 023268DC
pool_023268E0:
loc_023268E0:
	.word P1_BssStart + 0x24DE0	; 023268E0
pool_023268E4:
loc_023268E4:
	.word P1_BssStart + 0x24DE4	; 023268E4
pool_023268E8:
loc_023268E8:
	.word P1_BssStart + 0x24DDC	; 023268E8

; ===== function loc_023268EC =====
; Cross-component P3 entry; semantic role remains under analysis.
; P3 跨组件入口；具体语义仍待分析。
P1_Function_023268EC:
loc_023268EC:
	push {lr}	; 023268EC
	sub sp,#0x4	; 023268EE
	bl P1_UpdateLidAndSleepState	; 023268F0
	bl loc_0232699C	; 023268F4
	bl loc_0232365C	; 023268F8
	bl P1_GetFirmwareUiContext	; 023268FC
	ldr r1,[r0,#0x4]	; 02326900
	add r1,r1,#0x1	; 02326902
	str r1,[r0,#0x4]	; 02326904
	add sp,#0x4	; 02326906
	pop {r3}	; 02326908
	bx r3	; 0232690A

; ===== function loc_0232690C =====
loc_0232690C:
	ldr r1,[pool_02326918]	; 0232690C
	ldr r2,[r1,#0x0]	; 0232690E
	mov r0,#0x2	; 02326910
	bic r2,r0	; 02326912
	str r2,[r1,#0x0]	; 02326914
	bx lr	; 02326916
pool_02326918:
loc_02326918:
	.word P1_BssStart + 0x24DFC	; 02326918

; ===== function loc_0232691C =====
loc_0232691C:
	ldr r1,[pool_0232692C]	; 0232691C
	ldr r2,[r1,#0x0]	; 0232691E
	mov r0,#0x2	; 02326920
	orr r2,r0	; 02326922
	str r2,[r1,#0x0]	; 02326924
	mov r0,#0x0	; 02326926
	ldr r3,[pool_02326930]	; 02326928
	bx r3	; 0232692A
pool_0232692C:
loc_0232692C:
	.word P1_BssStart + 0x24DFC	; 0232692C
pool_02326930:
loc_02326930:
	.word loc_0232949C + 1	; 02326930

; ===== function loc_02326934 =====
loc_02326934:
	ldr r1,[pool_02326944]	; 02326934
	ldr r2,[r1,#0x0]	; 02326936
	mov r0,#0x1	; 02326938
	bic r2,r0	; 0232693A
	str r2,[r1,#0x0]	; 0232693C
	mov r0,#0x0	; 0232693E
	ldr r3,[pool_02326948]	; 02326940
	bx r3	; 02326942
pool_02326944:
loc_02326944:
	.word P1_BssStart + 0x24DFC	; 02326944
pool_02326948:
loc_02326948:
	.word loc_0232949C + 1	; 02326948

; ===== function loc_0232694C =====
loc_0232694C:
	push {r4,lr}	; 0232694C
	cmp r1,#0x0	; 0232694E
	beq loc_0232695A	; 02326950
	ldr r2,[pool_02326998]	; 02326952
	ldr r2,[r2,#0x8]	; 02326954
	cmp r2,r0	; 02326956
	bne loc_02326966	; 02326958
loc_0232695A:
	ldr r2,[pool_02326998]	; 0232695A
	ldr r3,[r2,#0x0]	; 0232695C
	mov r2,#0x1	; 0232695E
	and r3,r2	; 02326960
	cmp r3,#0x1	; 02326962
	beq loc_02326974	; 02326964
loc_02326966:
	mov r2,#0x0	; 02326966
	ldr r3,[pool_02326998]	; 02326968
	str r2,[r3,#0x4]	; 0232696A
	ldr r4,[r3,#0x0]	; 0232696C
	mov r2,#0x1	; 0232696E
	orr r4,r2	; 02326970
	str r4,[r3,#0x0]	; 02326972
loc_02326974:
	cmp r1,#0x0	; 02326974
	beq loc_02326984	; 02326976
	ldr r2,[pool_02326998]	; 02326978
	ldr r3,[r2,#0x0]	; 0232697A
	mov r1,#0x4	; 0232697C
	orr r3,r1	; 0232697E
	str r3,[r2,#0x0]	; 02326980
	b loc_0232698E	; 02326982
loc_02326984:
	ldr r2,[pool_02326998]	; 02326984
	ldr r3,[r2,#0x0]	; 02326986
	mov r1,#0x4	; 02326988
	bic r3,r1	; 0232698A
	str r3,[r2,#0x0]	; 0232698C
loc_0232698E:
	ldr r1,[pool_02326998]	; 0232698E
	str r0,[r1,#0x8]	; 02326990
	pop {r4}	; 02326992
	pop {r3}	; 02326994
	bx r3	; 02326996
pool_02326998:
loc_02326998:
	.word P1_BssStart + 0x24DFC	; 02326998

; ===== function loc_0232699C =====
loc_0232699C:
	push {lr}	; 0232699C
	sub sp,#0x4	; 0232699E
	ldr r2,[pool_02326A08]	; 023269A0
	ldr r0,[r2,#0x0]	; 023269A2
	mov r1,#0x1	; 023269A4
	and r0,r1	; 023269A6
	cmp r0,#0x1	; 023269A8
	bne loc_023269FA	; 023269AA
	ldr r3,[r2,#0x0]	; 023269AC
	mov r0,#0x2	; 023269AE
	and r3,r0	; 023269B0
	cmp r3,#0x2	; 023269B2
	beq loc_023269FA	; 023269B4
	ldr r0,[r2,#0x8]	; 023269B6
	lsl r3,r0,#0x2	; 023269B8
	ldr r0,[pool_02326A0C]	; 023269BA
	ldr r3,[r0,r3]	; 023269BC
	ldr r0,[r2,#0x4]	; 023269BE
	lsr r3,r0	; 023269C0
	and r3,r1	; 023269C2
	lsl r0,r3,#0x10	; 023269C4
	lsr r0,r0,#0x10	; 023269C6
	bl loc_0232949C	; 023269C8
	ldr r0,[pool_02326A08]	; 023269CC
	ldr r1,[r0,#0x4]	; 023269CE
	add r1,r1,#0x1	; 023269D0
	str r1,[r0,#0x4]	; 023269D2
	ldr r1,[r0,#0x4]	; 023269D4
	cmp r1,#0x20	; 023269D6
	blt loc_023269EA	; 023269D8
	ldr r1,[r0,#0x0]	; 023269DA
	mov r0,#0x4	; 023269DC
	and r1,r0	; 023269DE
	cmp r1,#0x4	; 023269E0
	bne loc_023269EA	; 023269E2
	bl loc_02326934	; 023269E4
	b loc_02326A00	; 023269E8
loc_023269EA:
	ldr r0,[pool_02326A08]	; 023269EA
	ldr r0,[r0,#0x4]	; 023269EC
	mov r1,#0x20	; 023269EE
	blx P1_SignedDivMod	; 023269F0
	ldr r0,[pool_02326A08]	; 023269F4
	str r1,[r0,#0x4]	; 023269F6
	b loc_02326A00	; 023269F8
loc_023269FA:
	mov r0,#0x0	; 023269FA
	bl loc_0232949C	; 023269FC
loc_02326A00:
	add sp,#0x4	; 02326A00
	pop {r3}	; 02326A02
	bx r3	; 02326A04
	.byte 0xC0, 0x46	; 02326A08
pool_02326A08:
loc_02326A08:
	.word P1_BssStart + 0x24DFC	; 02326A08
pool_02326A0C:
loc_02326A0C:
	.word P1_Data_023301F4	; 02326A0C

; ===== function loc_02326A10 =====
loc_02326A10:
	push {lr}	; 02326A10
	sub sp,#0x4	; 02326A12
	ldr r0,[pool_02326A28]	; 02326A14
	mov r1,#0x0	; 02326A16
	mov r2,#0xc	; 02326A18
	blx loc_0232DEEC	; 02326A1A
	bl loc_023294E8	; 02326A1E
	add sp,#0x4	; 02326A22
	pop {r3}	; 02326A24
	bx r3	; 02326A26
pool_02326A28:
loc_02326A28:
	.word 0x023558BC	; 02326A28

; ===== function loc_02326A2C =====
loc_02326A2C:
	push {r4,lr}	; 02326A2C
	add r4,r0,#0x0	; 02326A2E
	bl loc_02326A64	; 02326A30
	ldr r2,[pool_02326A44]	; 02326A34
	ldmia r2!,{r0,r1}	; 02326A36
	stmia r4!,{r0,r1}	; 02326A38
	ldmia r2!,{r0,r1}	; 02326A3A
	stmia r4!,{r0,r1}	; 02326A3C
	pop {r4}	; 02326A3E
	pop {r3}	; 02326A40
	bx r3	; 02326A42
pool_02326A44:
loc_02326A44:
	.word 0x023558D4	; 02326A44

; ===== function loc_02326A48 =====
loc_02326A48:
	push {r4,lr}	; 02326A48
	add r4,r0,#0x0	; 02326A4A
	bl loc_02326A64	; 02326A4C
	ldr r2,[pool_02326A60]	; 02326A50
	ldmia r2!,{r0,r1}	; 02326A52
	stmia r4!,{r0,r1}	; 02326A54
	ldr r0,[r2,#0x0]	; 02326A56
	str r0,[r4,#0x0]	; 02326A58
	pop {r4}	; 02326A5A
	pop {r3}	; 02326A5C
	bx r3	; 02326A5E
pool_02326A60:
loc_02326A60:
	.word 0x023558C8	; 02326A60

; ===== function loc_02326A64 =====
loc_02326A64:
	push {lr}	; 02326A64
	sub sp,#0x4	; 02326A66
	bl P1_GetFirmwareUiContext	; 02326A68
	ldr r0,[r0,#0x4]	; 02326A6C
	mov r1,#0x14	; 02326A6E
	blx P1_UnsignedDivMod	; 02326A70
	cmp r1,#0x0	; 02326A74
	bne loc_02326A9A	; 02326A76
	ldr r0,[pool_02326AA0]	; 02326A78
	ldr r1,[pool_02326AA4]	; 02326A7A
	bl loc_0232FD78	; 02326A7C
	cmp r0,#0x0	; 02326A80
	beq loc_02326A9A	; 02326A82
	mov r2,#0x0	; 02326A84
	ldr r0,[pool_02326AA0]	; 02326A86
	str r2,[r0,#0x0]	; 02326A88
	mov r1,#0x1	; 02326A8A
	str r1,[r0,#0x4]	; 02326A8C
	str r1,[r0,#0x8]	; 02326A8E
	str r2,[r0,#0xc]	; 02326A90
	ldr r0,[pool_02326AA4]	; 02326A92
	str r2,[r0,#0x0]	; 02326A94
	str r2,[r0,#0x4]	; 02326A96
	str r2,[r0,#0x8]	; 02326A98
loc_02326A9A:
	add sp,#0x4	; 02326A9A
	pop {r3}	; 02326A9C
	bx r3	; 02326A9E
pool_02326AA0:
loc_02326AA0:
	.word P1_BssStart + 0x24E14	; 02326AA0
pool_02326AA4:
loc_02326AA4:
	.word P1_BssStart + 0x24E08	; 02326AA4

; ===== function loc_02326AA8 =====
loc_02326AA8:
	push {r4,r5,r6,r7,lr}	; 02326AA8
	sub sp,#0xc	; 02326AAA
	add r5,r0,#0x0	; 02326AAC
	add r4,r1,#0x0	; 02326AAE
	add r6,r2,#0x0	; 02326AB0
	sub r0,r4,#0x1	; 02326AB2
	cmp r0,#0x1	; 02326AB4
	bhi loc_02326ABC	; 02326AB6
	sub r5,r5,#0x1	; 02326AB8
	add r4,#0xc	; 02326ABA
loc_02326ABC:
	add r0,r5,#0x0	; 02326ABC
	ldr r1,[pool_02326B08]	; 02326ABE
	blx P1_SignedDivMod	; 02326AC0
	add r7,r0,#0x0	; 02326AC4
	add r0,r5,#0x0	; 02326AC6
	mov r1,#0x4	; 02326AC8
	blx P1_SignedDivMod	; 02326ACA
	str r0,[sp,#0x0]	; 02326ACE
	add r0,r5,#0x0	; 02326AD0
	mov r1,#0x64	; 02326AD2
	blx P1_SignedDivMod	; 02326AD4
	str r0,[sp,#0x4]	; 02326AD8
	mov r0,#0xd	; 02326ADA
	mul r4,r0	; 02326ADC
	add r4,#0x8	; 02326ADE
	add r0,r4,#0x0	; 02326AE0
	mov r1,#0x5	; 02326AE2
	blx P1_SignedDivMod	; 02326AE4
	ldr r1,[sp,#0x0]	; 02326AE8
	add r2,r5,r1	; 02326AEA
	ldr r1,[sp,#0x4]	; 02326AEC
	sub r1,r2,r1	; 02326AEE
	add r1,r7,r1	; 02326AF0
	add r0,r1,r0	; 02326AF2
	add r0,r6,r0	; 02326AF4
	mov r1,#0x7	; 02326AF6
	blx P1_SignedDivMod	; 02326AF8
	add r0,r1,#0x0	; 02326AFC
	add sp,#0xc	; 02326AFE
	pop {r4,r5,r6,r7}	; 02326B00
	pop {r3}	; 02326B02
	bx r3	; 02326B04
	.byte 0xC0, 0x46	; 02326B08
pool_02326B08:
loc_02326B08:
	.word 0x00000190	; 02326B08

; ===== function loc_02326B0C =====
loc_02326B0C:
	push {r4,r5,r6,lr}	; 02326B0C
	sub sp,#0x18	; 02326B0E
	add r4,r1,#0x0	; 02326B10
	ldr r6,[pool_02326B48]	; 02326B12
	add r5,sp,#0x0	; 02326B14
	mov r3,#0xc	; 02326B16
loc_02326B18:
	ldrh r1,[r6,#0x0]	; 02326B18
	add r6,r6,#0x2	; 02326B1A
	strh r1,[r5,#0x0]	; 02326B1C
	add r5,r5,#0x2	; 02326B1E
	sub r3,r3,#0x1	; 02326B20
	cmp r3,#0x0	; 02326B22
	bne loc_02326B18	; 02326B24
	cmp r2,#0x1	; 02326B26
	beq loc_02326B32	; 02326B28
	bl loc_02326B50	; 02326B2A
	cmp r0,#0x0	; 02326B2E
	beq loc_02326B38	; 02326B30
loc_02326B32:
	mov r1,#0x1d	; 02326B32
	add r0,sp,#0x0	; 02326B34
	strh r1,[r0,#0x2]	; 02326B36
loc_02326B38:
	lsl r1,r4,#0x1	; 02326B38
	ldr r0,[pool_02326B4C]	; 02326B3A
	add r0,sp	; 02326B3C
	ldrh r0,[r0,r1]	; 02326B3E
	add sp,#0x18	; 02326B40
	pop {r4,r5,r6}	; 02326B42
	pop {r3}	; 02326B44
	bx r3	; 02326B46
pool_02326B48:
loc_02326B48:
	.word P1_Data_02330938	; 02326B48
pool_02326B4C:
loc_02326B4C:
	.word 0xFFFFFFFE	; 02326B4C

; ===== function loc_02326B50 =====
loc_02326B50:
	push {r4,lr}	; 02326B50
	add r4,r0,#0x0	; 02326B52
	mov r1,#0x3	; 02326B54
	add r2,r4,#0x0	; 02326B56
	and r2,r1	; 02326B58
	cmp r2,#0x0	; 02326B5A
	bne loc_02326B68	; 02326B5C
	mov r1,#0x64	; 02326B5E
	blx P1_UnsignedDivMod	; 02326B60
	cmp r1,#0x0	; 02326B64
	bne loc_02326B74	; 02326B66
loc_02326B68:
	add r0,r4,#0x0	; 02326B68
	ldr r1,[pool_02326B80]	; 02326B6A
	blx P1_UnsignedDivMod	; 02326B6C
	cmp r1,#0x0	; 02326B70
	bne loc_02326B78	; 02326B72
loc_02326B74:
	mov r0,#0x1	; 02326B74
	b loc_02326B7A	; 02326B76
loc_02326B78:
	mov r0,#0x0	; 02326B78
loc_02326B7A:
	pop {r4}	; 02326B7A
	pop {r3}	; 02326B7C
	bx r3	; 02326B7E
pool_02326B80:
loc_02326B80:
	.word 0x00000190	; 02326B80

; ===== function loc_02326B84 =====
loc_02326B84:
	ldr r0,[pool_02326B98]	; 02326B84
	ldrh r1,[r0,#0x0]	; 02326B86
	mov r0,#0x3c	; 02326B88
	and r1,r0	; 02326B8A
	lsr r0,r1,#0x2	; 02326B8C
	lsl r1,r0,#0xe	; 02326B8E
	ldr r0,[pool_02326B9C]	; 02326B90
	add r0,r1,r0	; 02326B92
	bx lr	; 02326B94
	.byte 0xC0, 0x46	; 02326B98
pool_02326B98:
loc_02326B98:
	.word REG_BG3CNT_SUB	; 02326B98
pool_02326B9C:
loc_02326B9C:
	.word 0x06200000	; 02326B9C

; ===== function loc_02326BA0 =====
loc_02326BA0:
	ldr r0,[pool_02326BC0]	; 02326BA0
	ldrh r0,[r0,#0x0]	; 02326BA2
	ldr r1,[pool_02326BC4]	; 02326BA4
	ldr r2,[r1,#0x0]	; 02326BA6
	ldr r1,[pool_02326BC8]	; 02326BA8
	and r2,r1	; 02326BAA
	lsr r1,r2,#0x18	; 02326BAC
	lsl r2,r1,#0x10	; 02326BAE
	ldr r1,[pool_02326BCC]	; 02326BB0
	add r2,r2,r1	; 02326BB2
	mov r1,#0x3c	; 02326BB4
	and r0,r1	; 02326BB6
	lsr r0,r0,#0x2	; 02326BB8
	lsl r0,r0,#0xe	; 02326BBA
	add r0,r2,r0	; 02326BBC
	bx lr	; 02326BBE
pool_02326BC0:
loc_02326BC0:
	.word REG_BG3CNT	; 02326BC0
pool_02326BC4:
loc_02326BC4:
	.word REG_DISPCNT_A	; 02326BC4
pool_02326BC8:
loc_02326BC8:
	.word 0x07000000	; 02326BC8
pool_02326BCC:
loc_02326BCC:
	.word 0x06000000	; 02326BCC

; ===== function loc_02326BD0 =====
loc_02326BD0:
	ldr r0,[pool_02326BE4]	; 02326BD0
	ldrh r1,[r0,#0x0]	; 02326BD2
	mov r0,#0x3c	; 02326BD4
	and r1,r0	; 02326BD6
	lsr r0,r1,#0x2	; 02326BD8
	lsl r1,r0,#0xe	; 02326BDA
	ldr r0,[pool_02326BE8]	; 02326BDC
	add r0,r1,r0	; 02326BDE
	bx lr	; 02326BE0
	.byte 0xC0, 0x46	; 02326BE4
pool_02326BE4:
loc_02326BE4:
	.word REG_BG2CNT_SUB	; 02326BE4
pool_02326BE8:
loc_02326BE8:
	.word 0x06200000	; 02326BE8

; ===== function loc_02326BEC =====
loc_02326BEC:
	ldr r0,[pool_02326C0C]	; 02326BEC
	ldrh r0,[r0,#0x0]	; 02326BEE
	ldr r1,[pool_02326C10]	; 02326BF0
	ldr r2,[r1,#0x0]	; 02326BF2
	ldr r1,[pool_02326C14]	; 02326BF4
	and r2,r1	; 02326BF6
	lsr r1,r2,#0x18	; 02326BF8
	lsl r2,r1,#0x10	; 02326BFA
	ldr r1,[pool_02326C18]	; 02326BFC
	add r2,r2,r1	; 02326BFE
	mov r1,#0x3c	; 02326C00
	and r0,r1	; 02326C02
	lsr r0,r0,#0x2	; 02326C04
	lsl r0,r0,#0xe	; 02326C06
	add r0,r2,r0	; 02326C08
	bx lr	; 02326C0A
pool_02326C0C:
loc_02326C0C:
	.word REG_BG2CNT	; 02326C0C
pool_02326C10:
loc_02326C10:
	.word REG_DISPCNT_A	; 02326C10
pool_02326C14:
loc_02326C14:
	.word 0x07000000	; 02326C14
pool_02326C18:
loc_02326C18:
	.word 0x06000000	; 02326C18

; ===== function loc_02326C1C =====
loc_02326C1C:
	ldr r0,[pool_02326C30]	; 02326C1C
	ldrh r1,[r0,#0x0]	; 02326C1E
	ldr r0,[pool_02326C34]	; 02326C20
	and r1,r0	; 02326C22
	lsr r0,r1,#0x8	; 02326C24
	lsl r1,r0,#0xb	; 02326C26
	ldr r0,[pool_02326C38]	; 02326C28
	add r0,r1,r0	; 02326C2A
	bx lr	; 02326C2C
	.byte 0xC0, 0x46	; 02326C30
pool_02326C30:
loc_02326C30:
	.word REG_BG3CNT_SUB	; 02326C30
pool_02326C34:
loc_02326C34:
	.word 0x00001F00	; 02326C34
pool_02326C38:
loc_02326C38:
	.word 0x06200000	; 02326C38
.arm

; ===== function loc_02326C3C =====
; Computes the main-engine BG3 tile map address. / 计算主引擎 BG3 tile map 地址。
.func P1_GetMainBg3TilemapAddress
loc_02326C3C:
	ldr r1,[pool_02326C6C]	; 02326C3C
	mov r0,#0x4000000	; 02326C40
	ldrh r2,[r1,#0x0]	; 02326C44
	ldr r0,[r0,#0x0]	; 02326C48
	and r0,r0,#0x38000000	; 02326C4C
	mov r0,r0, lsr #0x1b	; 02326C50
	mov r1,r0, lsl #0x10	; 02326C54
	and r0,r2,#0x1f00	; 02326C58
	add r1,r1,#0x6000000	; 02326C5C
	mov r0,r0, lsr #0x8	; 02326C60
	add r0,r1,r0, lsl #0xb	; 02326C64
	bx lr	; 02326C68
.endfunc
pool_02326C6C:
loc_02326C6C:
	.word REG_BG3CNT	; 02326C6C
.thumb

; ===== function loc_02326C70 =====
loc_02326C70:
	ldr r0,[pool_02326C84]	; 02326C70
	ldrh r1,[r0,#0x0]	; 02326C72
	ldr r0,[pool_02326C88]	; 02326C74
	and r1,r0	; 02326C76
	lsr r0,r1,#0x8	; 02326C78
	lsl r1,r0,#0xb	; 02326C7A
	ldr r0,[pool_02326C8C]	; 02326C7C
	add r0,r1,r0	; 02326C7E
	bx lr	; 02326C80
	.byte 0xC0, 0x46	; 02326C84
pool_02326C84:
loc_02326C84:
	.word REG_BG2CNT_SUB	; 02326C84
pool_02326C88:
loc_02326C88:
	.word 0x00001F00	; 02326C88
pool_02326C8C:
loc_02326C8C:
	.word 0x06200000	; 02326C8C
.arm

; ===== function loc_02326C90 =====
; Computes the main-engine BG2 tile map address. / 计算主引擎 BG2 tile map 地址。
.func P1_GetMainBg2TilemapAddress
loc_02326C90:
	ldr r1,[pool_02326CC0]	; 02326C90
	mov r0,#0x4000000	; 02326C94
	ldrh r2,[r1,#0x0]	; 02326C98
	ldr r0,[r0,#0x0]	; 02326C9C
	and r0,r0,#0x38000000	; 02326CA0
	mov r0,r0, lsr #0x1b	; 02326CA4
	mov r1,r0, lsl #0x10	; 02326CA8
	and r0,r2,#0x1f00	; 02326CAC
	add r1,r1,#0x6000000	; 02326CB0
	mov r0,r0, lsr #0x8	; 02326CB4
	add r0,r1,r0, lsl #0xb	; 02326CB8
	bx lr	; 02326CBC
.endfunc
pool_02326CC0:
loc_02326CC0:
	.word REG_BG2CNT	; 02326CC0
.thumb

; ===== function loc_02326CC4 =====
loc_02326CC4:
	push {r4,lr}	; 02326CC4
	mvn r4,r0	; 02326CC6
	ldr r1,[pool_02326CE8]	; 02326CC8
	ldrh r3,[r1,#0x0]	; 02326CCA
	ldrh r2,[r1,#0x14]	; 02326CCC
	orr r3,r2	; 02326CCE
	and r4,r3	; 02326CD0
	strh r4,[r1,#0x0]	; 02326CD2
	strh r0,[r1,#0x14]	; 02326CD4
	mov r2,#0x84	; 02326CD6
	ldr r0,[pool_02326CEC]	; 02326CD8
	strb r2,[r0,#0x0]	; 02326CDA
	ldrh r0,[r1,#0x0]	; 02326CDC
	bl loc_0232D744	; 02326CDE
	pop {r4}	; 02326CE2
	pop {r3}	; 02326CE4
	bx r3	; 02326CE6
pool_02326CE8:
loc_02326CE8:
	.word P1_BssStart + 0x266B0	; 02326CE8
pool_02326CEC:
loc_02326CEC:
	.word VRAM_D_CR	; 02326CEC

; ===== function loc_02326CF0 =====
loc_02326CF0:
	push {r4,lr}	; 02326CF0
	mvn r4,r0	; 02326CF2
	ldr r1,[pool_02326D14]	; 02326CF4
	ldrh r3,[r1,#0x0]	; 02326CF6
	ldrh r2,[r1,#0x12]	; 02326CF8
	orr r3,r2	; 02326CFA
	and r4,r3	; 02326CFC
	strh r4,[r1,#0x0]	; 02326CFE
	strh r0,[r1,#0x12]	; 02326D00
	mov r2,#0x84	; 02326D02
	ldr r0,[pool_02326D18]	; 02326D04
	strb r2,[r0,#0x0]	; 02326D06
	ldrh r0,[r1,#0x0]	; 02326D08
	bl loc_0232D744	; 02326D0A
	pop {r4}	; 02326D0E
	pop {r3}	; 02326D10
	bx r3	; 02326D12
pool_02326D14:
loc_02326D14:
	.word P1_BssStart + 0x266B0	; 02326D14
pool_02326D18:
loc_02326D18:
	.word VRAM_C_CR	; 02326D18

; ===== function loc_02326D1C =====
loc_02326D1C:
	push {r4,lr}	; 02326D1C
	mvn r4,r0	; 02326D1E
	ldr r1,[pool_02326D40]	; 02326D20
	ldrh r3,[r1,#0x0]	; 02326D22
	ldrh r2,[r1,#0x4]	; 02326D24
	orr r3,r2	; 02326D26
	and r4,r3	; 02326D28
	strh r4,[r1,#0x0]	; 02326D2A
	strh r0,[r1,#0x4]	; 02326D2C
	mov r2,#0x82	; 02326D2E
	ldr r0,[pool_02326D44]	; 02326D30
	strb r2,[r0,#0x0]	; 02326D32
	ldrh r0,[r1,#0x0]	; 02326D34
	bl loc_0232D744	; 02326D36
	pop {r4}	; 02326D3A
	pop {r3}	; 02326D3C
	bx r3	; 02326D3E
pool_02326D40:
loc_02326D40:
	.word P1_BssStart + 0x266B0	; 02326D40
pool_02326D44:
loc_02326D44:
	.word VRAM_B_CR	; 02326D44

; ===== function loc_02326D48 =====
loc_02326D48:
	push {r4,lr}	; 02326D48
	mvn r4,r0	; 02326D4A
	ldr r1,[pool_02326D6C]	; 02326D4C
	ldrh r3,[r1,#0x0]	; 02326D4E
	ldrh r2,[r1,#0x2]	; 02326D50
	orr r3,r2	; 02326D52
	and r4,r3	; 02326D54
	strh r4,[r1,#0x0]	; 02326D56
	strh r0,[r1,#0x2]	; 02326D58
	mov r2,#0x81	; 02326D5A
	ldr r0,[pool_02326D70]	; 02326D5C
	strb r2,[r0,#0x0]	; 02326D5E
	ldrh r0,[r1,#0x0]	; 02326D60
	bl loc_0232D744	; 02326D62
	pop {r4}	; 02326D66
	pop {r3}	; 02326D68
	bx r3	; 02326D6A
pool_02326D6C:
loc_02326D6C:
	.word P1_BssStart + 0x266B0	; 02326D6C
pool_02326D70:
loc_02326D70:
	.word VRAM_A_CR	; 02326D70

; 解压 P3/P4 后合计 CRC16，并与固件头中的记录值比较。
; Decompresses P3/P4, accumulates CRC16, then compares the firmware-header value.
P1_ValidateP3P4Crc16:
loc_02326D74:
; 解压 P3/P4，按顺序累计两块明文的 CRC16，清理缓存后发布结果。
; Decode P3/P4, chain CRC16 over their decoded bytes, maintain the cache, then publish the result.
.func P1_DecompressAndCheckP3P4
	push {r4,r5,lr}	; 02326D74
	sub sp,#0x4	; 02326D76
	ldr r0,[pool_02326DCC]	; 02326D78
	ldr r1,[pool_02326DD0]	; 02326D7A
	blx P1_DecompressP345	; 02326D7C
	add r5,r0,#0x0	; 02326D80
	ldr r1,[pool_02326DD4]	; 02326D82
	ldr r0,[r1,#BootSharedP4DestinationOffset]	; 02326D84
	ldr r1,[r1,#BootSharedP4StagingOffset]	; 02326D86
	blx P1_DecompressP345	; 02326D88
	add r4,r0,#0x0	; 02326D8C
	ldr r0,[pool_02326DD8]	; 02326D8E
	ldr r1,[pool_02326DCC]	; 02326D90
	add r2,r5,#0x0	; 02326D92
	bl P1_SwiGetCrc16	; 02326D94
	ldr r1,[pool_02326DD4]	; 02326D98
	ldr r1,[r1,#BootSharedP4DestinationOffset]	; 02326D9A
	add r2,r4,#0x0	; 02326D9C
	bl P1_SwiGetCrc16	; 02326D9E
	add r4,r0,#0x0	; 02326DA2
	blx P1_CleanAndInvalidateEntireDataCacheByIndex	; 02326DA4
	ldr r0,[pool_02326DD4]	; 02326DA8
	ldrh r0,[r0,#BootSharedP3P4Crc16Offset]	; 02326DAA
	cmp r4,r0	; 02326DAC
	bne loc_02326DBE	; 02326DAE
	ldr r0,[pool_02326DDC]	; 02326DB0
	bl P1_OrSharedEventFlags	; 02326DB2
	add sp,#0x4	; 02326DB6
	pop {r4,r5}	; 02326DB8
	pop {r3}	; 02326DBA
	bx r3	; 02326DBC
loc_02326DBE:
	ldr r0,[pool_02326DE0]	; 02326DBE
	bl P1_OrSharedEventFlags	; 02326DC0
	add sp,#0x4	; 02326DC4
	pop {r4,r5}	; 02326DC6
	pop {r3}	; 02326DC8
	bx r3	; 02326DCA
.endfunc
pool_02326DCC:
loc_02326DCC:
	.word P3_FirmwareUiEntry	; 02326DCC
pool_02326DD0:
loc_02326DD0:
	.word FirmwareComponentStagingAddress	; 02326DD0
pool_02326DD4:
loc_02326DD4:
	.word FirmwareBootSharedAddress	; 02326DD4
pool_02326DD8:
loc_02326DD8:
	.word 0x0000FFFF	; 02326DD8
pool_02326DDC:
loc_02326DDC:
	.word 0x00000400	; 02326DDC
pool_02326DE0:
loc_02326DE0:
	.word 0x00000408	; 02326DE0

; 解压 P5、计算 CRC16，并按结果更新启动状态。
; Decompresses P5, calculates CRC16, and updates boot state from the result.
P1_ValidateP5Crc16:
loc_02326DE4:
; 解压 P5 并校验明文 CRC16；匹配时才发布资源已就绪标志。
; Decode P5 and check its decoded CRC16; publish the resource-ready flag only on a match.
.func P1_DecompressAndCheckP5
	push {r4,lr}	; 02326DE4
	ldr r0,[pool_02326E14]	; 02326DE6
	ldr r1,[pool_02326E18]	; 02326DE8
	blx P1_DecompressP345	; 02326DEA
	add r2,r0,#0x0	; 02326DEE
	ldr r0,[pool_02326E1C]	; 02326DF0
	ldr r1,[pool_02326E14]	; 02326DF2
	bl P1_SwiGetCrc16	; 02326DF4
	add r4,r0,#0x0	; 02326DF8
	blx P1_CleanAndInvalidateEntireDataCacheByIndex	; 02326DFA
	ldr r0,[pool_02326E20]	; 02326DFE
	ldrh r0,[r0,#0x0]	; 02326E00
	cmp r4,r0	; 02326E02
	bne loc_02326E0C	; 02326E04
	ldr r0,[pool_02326E24]	; 02326E06
	bl P1_OrSharedEventFlags	; 02326E08
loc_02326E0C:
	pop {r4}	; 02326E0C
	pop {r3}	; 02326E0E
	bx r3	; 02326E10
.endfunc
	.byte 0xC0, 0x46	; 02326E14
pool_02326E14:
loc_02326E14:
	.word P5_FirmwareUiResources	; 02326E14
pool_02326E18:
loc_02326E18:
	.word FirmwareComponentStagingAddress	; 02326E18
pool_02326E1C:
loc_02326E1C:
	.word 0x0000FFFF	; 02326E1C
pool_02326E20:
loc_02326E20:
	.word FirmwareBootSharedAddress + BootSharedP5Crc16Offset	; 02326E20
pool_02326E24:
loc_02326E24:
	.word 0x10000000	; 02326E24

; ===== function loc_02326E28 =====
loc_02326E28:
	push {lr}	; 02326E28
	sub sp,#0x4	; 02326E2A
	mov r0,#0x4	; 02326E2C
	ldr r1,[pool_02326E4C]	; 02326E2E
	ldrh r1,[r1,#0x0]	; 02326E30
	lsl r1,r1,#0x1a	; 02326E32
	lsr r1,r1,#0x1e	; 02326E34
	lsl r1,r1,#0x10	; 02326E36
	lsr r1,r1,#0x10	; 02326E38
	bl loc_0232F2B0	; 02326E3A
	mov r0,#0x2	; 02326E3E
	mov r1,#0x1	; 02326E40
	bl loc_0232F1DC	; 02326E42
	add sp,#0x4	; 02326E46
	pop {r3}	; 02326E48
	bx r3	; 02326E4A
pool_02326E4C:
loc_02326E4C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02326E4C

; ===== function loc_02326E50 =====
loc_02326E50:
; 发布前 0x18 字节启动信息，再补 ARM7 BIOS CRC 与 RTC 随机值。
; Publish 0x18 boot-info bytes, then update the ARM7 BIOS CRC and RTC random byte.
.func P1_PublishBootInfo
	push {lr}	; 02326E50
	sub sp,#0x4	; 02326E52
	ldr r0,[pool_02326E74]	; 02326E54
	ldr r1,[pool_02326E78]	; 02326E56
	mov r2,#0x18	; 02326E58
	blx loc_0232DEB4	; 02326E5A
	ldr r0,[pool_02326E7C]	; 02326E5E
	ldrh r1,[r0,#0x0]	; 02326E60
	ldr r0,[pool_02326E80]	; 02326E62
	strh r1,[r0,#0x0]	; 02326E64
	ldr r0,[pool_02326E84]	; 02326E66
	ldrb r1,[r0,#0x0]	; 02326E68
	ldr r0,[pool_02326E88]	; 02326E6A
	strb r1,[r0,#0x0]	; 02326E6C
	add sp,#0x4	; 02326E6E
	pop {r3}	; 02326E70
	bx r3	; 02326E72
.endfunc
pool_02326E74:
loc_02326E74:
	.word FirmwareBootInfoScratchAddress	; 02326E74
pool_02326E78:
loc_02326E78:
	.word 0x027FFC00	; 02326E78
pool_02326E7C:
loc_02326E7C:
	.word FirmwareBootInfoScratchAddress + BootScratchBios7CrcSourceOffset	; 02326E7C
pool_02326E80:
loc_02326E80:
	.word FirmwareBootInfoAddress + BootInfoBios7Crc16Offset	; 02326E80
pool_02326E84:
loc_02326E84:
	.word FirmwareBootInfoScratchAddress + BootScratchRtcSourceOffset	; 02326E84
pool_02326E88:
loc_02326E88:
	.word FirmwareBootInfoAddress + BootInfoRtcRandomOffset	; 02326E88

; ===== function loc_02326E8C =====
loc_02326E8C:
	push {r4,r5,r6,r7,lr}	; 02326E8C
	sub sp,#0x4	; 02326E8E
	ldr r5,[pool_02326F40]	; 02326E90
	mov r0,#0x6d	; 02326E92
	bl loc_0232B3B8	; 02326E94
	blx P1_Arm9DisableIrqReturnPriorMask	; 02326E98
	str r0,[sp,#0x0]	; 02326E9C
	ldr r2,[pool_02326F44]	; 02326E9E
	ldrh r1,[r2,#0x0]	; 02326EA0
	ldr r0,[pool_02326F48]	; 02326EA2
	and r1,r0	; 02326EA4
	asr r4,r1,#0xf	; 02326EA6
	ldrh r1,[r2,#0x0]	; 02326EA8
	mov r0,#0xc	; 02326EAA
	and r1,r0	; 02326EAC
	asr r6,r1,#0x2	; 02326EAE
	ldrh r1,[r2,#0x0]	; 02326EB0
	mov r3,#0x10	; 02326EB2
	and r1,r3	; 02326EB4
	asr r7,r1,#0x4	; 02326EB6
	ldrh r1,[r2,#0x0]	; 02326EB8
	bic r1,r0	; 02326EBA
	orr r1,r0	; 02326EBC
	strh r1,[r2,#0x0]	; 02326EBE
	ldrh r0,[r2,#0x0]	; 02326EC0
	bic r0,r3	; 02326EC2
	strh r0,[r2,#0x0]	; 02326EC4
	ldrh r1,[r2,#0x0]	; 02326EC6
	ldr r0,[pool_02326F4C]	; 02326EC8
	and r1,r0	; 02326ECA
	strh r1,[r2,#0x0]	; 02326ECC
	mov r0,#0x0	; 02326ECE
	ldr r1,[pool_02326F50]	; 02326ED0
	ldr r2,[pool_02326F54]	; 02326ED2
	mov r3,#0x40	; 02326ED4
	bl loc_0232DD84	; 02326ED6
	ldr r0,[pool_02326F44]	; 02326EDA
	ldrh r1,[r0,#0x0]	; 02326EDC
	ldr r2,[pool_02326F4C]	; 02326EDE
	and r1,r2	; 02326EE0
	lsl r2,r4,#0xf	; 02326EE2
	orr r1,r2	; 02326EE4
	strh r1,[r0,#0x0]	; 02326EE6
	ldrh r2,[r0,#0x0]	; 02326EE8
	mov r1,#0xc	; 02326EEA
	bic r2,r1	; 02326EEC
	lsl r1,r6,#0x2	; 02326EEE
	orr r2,r1	; 02326EF0
	strh r2,[r0,#0x0]	; 02326EF2
	ldrh r2,[r0,#0x0]	; 02326EF4
	mov r1,#0x10	; 02326EF6
	bic r2,r1	; 02326EF8
	lsl r1,r7,#0x4	; 02326EFA
	orr r2,r1	; 02326EFC
	strh r2,[r0,#0x0]	; 02326EFE
	ldr r0,[sp,#0x0]	; 02326F00
	blx P1_Arm9RestoreIrqMask	; 02326F02
	mov r0,#0x6d	; 02326F06
	bl loc_0232B250	; 02326F08
	add r0,r5,#0x0	; 02326F0C
	add r0,#0xbe	; 02326F0E
	ldrh r1,[r0,#0x0]	; 02326F10
	ldr r0,[pool_02326F58]	; 02326F12
	strh r1,[r0,#0x0]	; 02326F14
	mov r2,#0x0	; 02326F16
	ldr r0,[pool_02326F5C]	; 02326F18
loc_02326F1A:
	add r1,r5,r2	; 02326F1A
	add r1,#0xb5	; 02326F1C
	ldrb r1,[r1,#0x0]	; 02326F1E
	strb r1,[r2,r0]	; 02326F20
	add r2,r2,#0x1	; 02326F22
	cmp r2,#0x3	; 02326F24
	blt loc_02326F1A	; 02326F26
	add r0,r5,#0x0	; 02326F28
	add r0,#0xb0	; 02326F2A
	ldrh r0,[r0,#0x0]	; 02326F2C
	ldr r1,[pool_02326F58]	; 02326F2E
	strh r0,[r1,#0x6]	; 02326F30
	add r5,#0xac	; 02326F32
	ldr r0,[r5,#0x0]	; 02326F34
	str r0,[r1,#0x8]	; 02326F36
	add sp,#0x4	; 02326F38
	pop {r4,r5,r6,r7}	; 02326F3A
	pop {r3}	; 02326F3C
	bx r3	; 02326F3E
pool_02326F40:
loc_02326F40:
	.word 0x02355900	; 02326F40
pool_02326F44:
loc_02326F44:
	.word REG_EXMEMCNT_ARM9	; 02326F44
pool_02326F48:
loc_02326F48:
	.word 0x00008000	; 02326F48
pool_02326F4C:
loc_02326F4C:
	.word 0xFFFF7FFF	; 02326F4C
pool_02326F50:
loc_02326F50:
	.word 0x08000080	; 02326F50
pool_02326F54:
loc_02326F54:
	.word 0x02355980	; 02326F54
pool_02326F58:
loc_02326F58:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 02326F58
pool_02326F5C:
loc_02326F5C:
	.word 0x027FFC32	; 02326F5C

; ===== function loc_02326F60 =====
loc_02326F60:
	push {r4}	; 02326F60
	sub sp,#0x4	; 02326F62
	ldr r1,[pool_02326F98]	; 02326F64
	mov r2,#0x4e	; 02326F66
	sub r2,r2,#0x1	; 02326F68
	lsl r2,r2,#0x10	; 02326F6A
	lsr r4,r2,#0x10	; 02326F6C
loc_02326F6E:
	ldrh r3,[r1,#0x0]	; 02326F6E
	add r1,r1,#0x2	; 02326F70
	ldrh r2,[r0,#0x0]	; 02326F72
	add r0,r0,#0x2	; 02326F74
	cmp r3,r2	; 02326F76
	beq loc_02326F82	; 02326F78
	mov r0,#0x0	; 02326F7A
	add sp,#0x4	; 02326F7C
	pop {r4}	; 02326F7E
	bx lr	; 02326F80
loc_02326F82:
	add r3,r4,#0x0	; 02326F82
	sub r2,r4,#0x1	; 02326F84
	lsl r2,r2,#0x10	; 02326F86
	lsr r4,r2,#0x10	; 02326F88
	cmp r3,#0x0	; 02326F8A
	bne loc_02326F6E	; 02326F8C
	mov r0,#0x1	; 02326F8E
	add sp,#0x4	; 02326F90
	pop {r4}	; 02326F92
	bx lr	; 02326F94
	.byte 0xC0, 0x46	; 02326F98
pool_02326F98:
loc_02326F98:
	.word Bios9NintendoLogoAddress	; 02326F98

; ===== function loc_02326F9C =====
loc_02326F9C:
	ldr r0,[pool_02326FBC]	; 02326F9C
	ldrh r1,[r0,#0x0]	; 02326F9E
	ldr r0,[pool_02326FC0]	; 02326FA0
	cmp r1,r0	; 02326FA2
	bne loc_02326FB6	; 02326FA4
	ldr r0,[pool_02326FC4]	; 02326FA6
	ldrh r1,[r0,#0x0]	; 02326FA8
	ldr r0,[pool_02326FC8]	; 02326FAA
	ldrh r0,[r0,#0x0]	; 02326FAC
	cmp r1,r0	; 02326FAE
	bne loc_02326FB6	; 02326FB0
	mov r0,#0x1	; 02326FB2
	bx lr	; 02326FB4
loc_02326FB6:
	mov r0,#0x0	; 02326FB6
	bx lr	; 02326FB8
	.byte 0xC0, 0x46	; 02326FBC
pool_02326FBC:
loc_02326FBC:
	.word NdsCartHeaderRamAddress + 0x15C	; 02326FBC
pool_02326FC0:
loc_02326FC0:
	.word 0x0000CF56	; 02326FC0
pool_02326FC4:
loc_02326FC4:
	.word NdsCartHeaderRamAddress + 0x15E	; 02326FC4
pool_02326FC8:
loc_02326FC8:
	.word FirmwareBootInfoScratchAddress + BootInfoCardHeaderCrc16Offset	; 02326FC8

; ===== function loc_02326FCC =====
loc_02326FCC:
	add r1,r0,#0x0	; 02326FCC
	mov r0,#0x2	; 02326FCE
	mov r2,#0x0	; 02326FD0
	ldr r3,[pool_02326FD8]	; 02326FD2
	bx r3	; 02326FD4
	.byte 0xC0, 0x46	; 02326FD8
pool_02326FD8:
loc_02326FD8:
	.word loc_0232E8B4 + 1	; 02326FD8

; ===== function loc_02326FDC =====
loc_02326FDC:
	push {lr}	; 02326FDC
	sub sp,#0x4	; 02326FDE
	ldr r0,[pool_02326FF4]	; 02326FE0
	ldrb r1,[r0,#0x0]	; 02326FE2
	add r0,sp,#0x0	; 02326FE4
	strb r1,[r0,#0x0]	; 02326FE6
	add r0,sp,#0x0	; 02326FE8
	bl loc_0232FC54	; 02326FEA
	add sp,#0x4	; 02326FEE
	pop {r3}	; 02326FF0
	bx r3	; 02326FF2
pool_02326FF4:
loc_02326FF4:
	.word FirmwareUserSettingsSharedAddress + 0x67	; 02326FF4

; ===== function loc_02326FF8 =====
loc_02326FF8:
	push {lr}	; 02326FF8
	sub sp,#0x1c	; 02326FFA
	ldr r0,[pool_02327038]	; 02326FFC
	ldrb r0,[r0,#0x0]	; 02326FFE
	str r0,[sp,#0x0]	; 02327000
	ldr r0,[pool_0232703C]	; 02327002
	ldrh r0,[r0,#0x0]	; 02327004
	str r0,[sp,#0x4]	; 02327006
	ldr r0,[pool_02327040]	; 02327008
	ldrh r0,[r0,#0x0]	; 0232700A
	str r0,[sp,#0x8]	; 0232700C
	ldr r0,[pool_02327044]	; 0232700E
	ldrb r0,[r0,#0x0]	; 02327010
	str r0,[sp,#0xc]	; 02327012
	ldr r0,[pool_02327048]	; 02327014
	ldrb r0,[r0,#0x0]	; 02327016
	str r0,[sp,#0x10]	; 02327018
	add r0,sp,#0x14	; 0232701A
	ldr r1,[pool_0232704C]	; 0232701C
	ldrh r1,[r1,#0x0]	; 0232701E
	ldr r2,[pool_02327050]	; 02327020
	ldrh r2,[r2,#0x0]	; 02327022
	ldr r3,[pool_02327054]	; 02327024
	ldrb r3,[r3,#0x0]	; 02327026
	bl loc_0232EBD4	; 02327028
	add r0,sp,#0x14	; 0232702C
	bl loc_0232EE1C	; 0232702E
	add sp,#0x1c	; 02327032
	pop {r3}	; 02327034
	bx r3	; 02327036
pool_02327038:
loc_02327038:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelY1Offset	; 02327038
pool_0232703C:
loc_0232703C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcX2Offset	; 0232703C
pool_02327040:
loc_02327040:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcY2Offset	; 02327040
pool_02327044:
loc_02327044:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelX2Offset	; 02327044
pool_02327048:
loc_02327048:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelY2Offset	; 02327048
pool_0232704C:
loc_0232704C:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcX1Offset	; 0232704C
pool_02327050:
loc_02327050:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchAdcY1Offset	; 02327050
pool_02327054:
loc_02327054:
	.word FirmwareUserSettingsSharedAddress + UserSettingsTouchPixelX1Offset	; 02327054

; ===== function loc_02327058 =====
loc_02327058:
	push {r4,r5,lr}	; 02327058
	sub sp,#0x4	; 0232705A
	ldr r5,[pool_023270E0]	; 0232705C
	bl loc_02326F9C	; 0232705E
	cmp r0,#0x0	; 02327062
	beq loc_0232706E	; 02327064
	ldr r0,[pool_023270E4]	; 02327066
	ldr r0,[r0,#0x0]	; 02327068
	cmp r0,#0x0	; 0232706A
	bne loc_0232707C	; 0232706C
loc_0232706E:
	mov r1,#0x0	; 0232706E
	ldr r0,[pool_023270E8]	; 02327070
	str r1,[r0,#0x0]	; 02327072
	add sp,#0x4	; 02327074
	pop {r4,r5}	; 02327076
	pop {r3}	; 02327078
	bx r3	; 0232707A
loc_0232707C:
	blx loc_0232B260	; 0232707C
	add r4,r0,#0x0	; 02327080
	cmp r4,#0x0	; 02327082
	beq loc_023270B2	; 02327084
	lsl r0,r4,#0x10	; 02327086
	lsr r0,r0,#0x10	; 02327088
	bl loc_0232B34C	; 0232708A
	add r0,r5,#0x0	; 0232708E
	ldr r1,[pool_023270EC]	; 02327090
	blx P1_CleanAndInvalidateDataCacheRange	; 02327092
	ldr r0,[pool_023270E4]	; 02327096
	ldr r0,[r0,#0x0]	; 02327098
	add r1,r5,#0x0	; 0232709A
	ldr r2,[pool_023270EC]	; 0232709C
	bl loc_02327B64	; 0232709E
	lsl r0,r4,#0x10	; 023270A2
	lsr r0,r0,#0x10	; 023270A4
	bl loc_0232B258	; 023270A6
	lsl r0,r4,#0x10	; 023270AA
	lsr r0,r0,#0x10	; 023270AC
	blx loc_0232B2B8	; 023270AE
loc_023270B2:
	ldr r0,[pool_023270F0]	; 023270B2
	add r1,r5,#0x0	; 023270B4
	add r1,#0x20	; 023270B6
	ldr r2,[pool_023270F4]	; 023270B8
	bl P1_SwiGetCrc16	; 023270BA
	ldrh r1,[r5,#0x2]	; 023270BE
	cmp r1,r0	; 023270C0
	beq loc_023270D2	; 023270C2
	mov r1,#0x0	; 023270C4
	ldr r0,[pool_023270E8]	; 023270C6
	str r1,[r0,#0x0]	; 023270C8
	add sp,#0x4	; 023270CA
	pop {r4,r5}	; 023270CC
	pop {r3}	; 023270CE
	bx r3	; 023270D0
loc_023270D2:
	mov r1,#0x1	; 023270D2
	ldr r0,[pool_023270E8]	; 023270D4
	str r1,[r0,#0x0]	; 023270D6
	add sp,#0x4	; 023270D8
	pop {r4,r5}	; 023270DA
	pop {r3}	; 023270DC
	bx r3	; 023270DE
pool_023270E0:
loc_023270E0:
	.word 0x023559C0	; 023270E0
pool_023270E4:
loc_023270E4:
	.word NdsCartHeaderRamAddress + 0x68	; 023270E4
pool_023270E8:
loc_023270E8:
	.word P1_BssStart + 0x24E24	; 023270E8
pool_023270EC:
loc_023270EC:
	.word 0x00000840	; 023270EC
pool_023270F0:
loc_023270F0:
	.word 0x0000FFFF	; 023270F0
pool_023270F4:
loc_023270F4:
	.word 0x00000820	; 023270F4

; ===== function loc_023270F8 =====
loc_023270F8:
	push {lr}	; 023270F8
	sub sp,#0x4	; 023270FA
	add r1,r0,#0x0	; 023270FC
	ldr r0,[pool_02327120]	; 023270FE
	ldr r0,[r0,#0x0]	; 02327100
	cmp r0,#0x0	; 02327102
	bne loc_0232710E	; 02327104
	mov r0,#0x0	; 02327106
	add sp,#0x4	; 02327108
	pop {r3}	; 0232710A
	bx r3	; 0232710C
loc_0232710E:
	ldr r0,[pool_02327124]	; 0232710E
	ldr r2,[pool_02327128]	; 02327110
	blx loc_0232DE20	; 02327112
	mov r0,#0x1	; 02327116
	add sp,#0x4	; 02327118
	pop {r3}	; 0232711A
	bx r3	; 0232711C
	.byte 0xC0, 0x46	; 02327120
pool_02327120:
loc_02327120:
	.word P1_BssStart + 0x24E24	; 02327120
pool_02327124:
loc_02327124:
	.word 0x023559C0	; 02327124
pool_02327128:
loc_02327128:
	.word 0x00000840	; 02327128

; ===== function loc_0232712C =====
loc_0232712C:
	ldr r1,[r0,#0x0]	; 0232712C
	cmp r1,#0x17	; 0232712E
	bhi loc_0232713E	; 02327130
	ldr r1,[r0,#0x4]	; 02327132
	cmp r1,#0x3b	; 02327134
	bhi loc_0232713E	; 02327136
	ldr r0,[r0,#0x8]	; 02327138
	cmp r0,#0x3b	; 0232713A
	bls loc_02327142	; 0232713C
loc_0232713E:
	mov r0,#0x0	; 0232713E
	bx lr	; 02327140
loc_02327142:
	mov r0,#0x1	; 02327142
	bx lr	; 02327144
	.byte 0x00, 0x00	; 02327148

; ===== function loc_02327148 =====
loc_02327148:
	ldr r1,[r0,#0x0]	; 02327148
	cmp r1,#0x64	; 0232714A
	bcs loc_02327168	; 0232714C
	ldr r1,[r0,#0x4]	; 0232714E
	cmp r1,#0x1	; 02327150
	bcc loc_02327168	; 02327152
	cmp r1,#0xc	; 02327154
	bhi loc_02327168	; 02327156
	ldr r1,[r0,#0x8]	; 02327158
	cmp r1,#0x1	; 0232715A
	bcc loc_02327168	; 0232715C
	cmp r1,#0x1f	; 0232715E
	bhi loc_02327168	; 02327160
	ldr r0,[r0,#0xc]	; 02327162
	cmp r0,#0x7	; 02327164
	blt loc_0232716C	; 02327166
loc_02327168:
	mov r0,#0x0	; 02327168
	bx lr	; 0232716A
loc_0232716C:
	mov r0,#0x1	; 0232716C
	bx lr	; 0232716E

; ===== function loc_02327170 =====
loc_02327170:
	push {lr}	; 02327170
	sub sp,#0x24	; 02327172
	ldr r0,[pool_0232720C]	; 02327174
	bl P1_LoadAndSelectUserSettings	; 02327176
	ldr r1,[pool_02327210]	; 0232717A
	str r0,[r1,#0x0]	; 0232717C
	ldr r0,[r1,#0x0]	; 0232717E
	cmp r0,#0x0	; 02327180
	beq loc_023271C2	; 02327182
	mov r0,#0x0	; 02327184
	str r0,[sp,#0x0]	; 02327186
	add r0,sp,#0x0	; 02327188
	ldr r1,[pool_0232720C]	; 0232718A
	ldr r2,[pool_02327214]	; 0232718C
	bl loc_0232C7CA	; 0232718E
	mov r1,#0x5	; 02327192
	ldr r0,[pool_0232720C]	; 02327194
	strb r1,[r0,#0x0]	; 02327196
	ldr r0,[pool_02327218]	; 02327198
	ldrh r2,[r0,#0x0]	; 0232719A
	mov r1,#0x30	; 0232719C
	bic r2,r1	; 0232719E
	mov r1,#0x20	; 023271A0
	orr r2,r1	; 023271A2
	strh r2,[r0,#0x0]	; 023271A4
	ldrh r3,[r0,#0x0]	; 023271A6
	mov r1,#0x7	; 023271A8
	bic r3,r1	; 023271AA
	mov r2,#0x1	; 023271AC
	orr r3,r2	; 023271AE
	strh r3,[r0,#0x0]	; 023271B0
	ldrh r3,[r0,#0x0]	; 023271B2
	ldr r1,[pool_0232721C]	; 023271B4
	orr r3,r1	; 023271B6
	strh r3,[r0,#0x0]	; 023271B8
	ldr r0,[pool_02327220]	; 023271BA
	strb r2,[r0,#0x0]	; 023271BC
	ldr r0,[pool_02327224]	; 023271BE
	strb r2,[r0,#0x0]	; 023271C0
loc_023271C2:
	add r0,sp,#0x4	; 023271C2
	add r1,sp,#0x14	; 023271C4
	bl loc_0232FD78	; 023271C6
	add r0,sp,#0x4	; 023271CA
	bl loc_02327148	; 023271CC
	cmp r0,#0x0	; 023271D0
	beq loc_023271EA	; 023271D2
	add r0,sp,#0x14	; 023271D4
	bl loc_0232712C	; 023271D6
	cmp r0,#0x0	; 023271DA
	beq loc_023271EA	; 023271DC
	ldr r0,[pool_02327228]	; 023271DE
	ldrb r1,[r0,#0x0]	; 023271E0
	mov r0,#0x1	; 023271E2
	and r1,r0	; 023271E4
	cmp r1,#0x0	; 023271E6
	beq loc_02327206	; 023271E8
loc_023271EA:
	ldr r2,[pool_02327218]	; 023271EA
	ldrh r1,[r2,#0x0]	; 023271EC
	ldr r0,[pool_0232722C]	; 023271EE
	and r1,r0	; 023271F0
	strh r1,[r2,#0x0]	; 023271F2
	mov r1,#0x0	; 023271F4
	ldr r0,[pool_02327230]	; 023271F6
	str r1,[r0,#0x0]	; 023271F8
	str r1,[r0,#0x4]	; 023271FA
	ldr r0,[pool_02327234]	; 023271FC
	strb r1,[r0,#0x0]	; 023271FE
	ldr r0,[pool_0232720C]	; 02327200
	bl loc_023282A8	; 02327202
loc_02327206:
	add sp,#0x24	; 02327206
	pop {r3}	; 02327208
	bx r3	; 0232720A
pool_0232720C:
loc_0232720C:
	.word FirmwareUserSettingsSharedAddress	; 0232720C
pool_02327210:
loc_02327210:
	.word FirmwareBootSharedAddress + BootSharedSettingsInvalidOffset	; 02327210
pool_02327214:
loc_02327214:
	.word 0x0100001C	; 02327214
pool_02327218:
loc_02327218:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02327218
pool_0232721C:
loc_0232721C:
	.word 0x00000200	; 0232721C
pool_02327220:
loc_02327220:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 02327220
pool_02327224:
loc_02327224:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthDayOffset	; 02327224
pool_02327228:
loc_02327228:
	.word FirmwareBootInfoScratchAddress + BootScratchRtcSourceOffset	; 02327228
pool_0232722C:
loc_0232722C:
	.word 0xFFFFBFFF	; 0232722C
pool_02327230:
loc_02327230:
	.word FirmwareUserSettingsSharedAddress + UserSettingsRtcOffset	; 02327230
pool_02327234:
loc_02327234:
	.word FirmwareUserSettingsSharedAddress + 0x66	; 02327234
.arm
; 此段随后覆盖复制至 ITCM；运行入口不是 CRT 初始内容。
; This stub later replaces ITCM contents; its entry is not the CRT image.
P1_TransitionCopySource:
.func P1_TransitionLoadEntry
	ldr r0,[pool_0232727C]	; 02327238
	mov r1,#0x9	; 0232723C
	str r1,[r0,#0x0]	; 02327240
	ldr r1,[pool_02327280]	; 02327244
	b loc_02327254	; 02327248
loc_0232724C:
	mov r0,#0x400	; 0232724C
	swi 0x30000	; 02327250
loc_02327254:
	ldr r0,[r1,#0x0]	; 02327254
	cmp r0,#0xa	; 02327258
	bne loc_0232724C	; 0232725C
	ldr r1,[pool_02327284]	; 02327260
	ldrh r0,[r1,#0x0]	; 02327264
	bic r0,r0,#0x4000	; 02327268
	strh r0,[r1,#0x0]	; 0232726C
	mov r0,#0x0	; 02327270
	mcr p15,0x0,r0,c7,c0,0x4	; 02327274
	bx lr	; 02327278
.endfunc
.definelabel P1_TransitionItcmBase, 0x01FF8000
.definelabel P1_TransitionRuntimeEntry, P1_TransitionItcmBase + (P1_TransitionLoadEntry - P1_TransitionCopySource)
pool_0232727C:
loc_0232727C:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 0232727C
pool_02327280:
loc_02327280:
	.word 0x027FF884	; 02327280
pool_02327284:
loc_02327284:
	.word REG_EXMEMCNT_ARM9	; 02327284
.thumb

; ===== function loc_02327288 =====
loc_02327288:
	push {lr}	; 02327288
	sub sp,#0x4	; 0232728A
	mov r0,#0x3	; 0232728C
	bl loc_0232D730	; 0232728E
	mov r0,#0x0	; 02327292
	str r0,[sp,#0x0]	; 02327294
	ldr r0,[sp,#0x0]	; 02327296
	ldr r1,[pool_023272A8]	; 02327298
	ldr r2,[pool_023272AC]	; 0232729A
	blx loc_0232DE68	; 0232729C
	add sp,#0x4	; 023272A0
	pop {r3}	; 023272A2
	bx r3	; 023272A4
	.byte 0xC0, 0x46	; 023272A8
pool_023272A8:
loc_023272A8:
	.word 0x06800000	; 023272A8
pool_023272AC:
loc_023272AC:
	.word 0x00040000	; 023272AC

; ===== function loc_023272B0 =====
loc_023272B0:
	push {lr}	; 023272B0
	sub sp,#0x4	; 023272B2
	ldr r0,[pool_02327364]	; 023272B4
	ldrh r0,[r0,#0x0]	; 023272B6
	lsl r0,r0,#0x1c	; 023272B8
	lsr r0,r0,#0x1f	; 023272BA
	cmp r0,#0x0	; 023272BC
	beq loc_023272D2	; 023272BE
	ldr r0,[pool_02327368]	; 023272C0
	ldr r0,[r0,#0x0]	; 023272C2
	cmp r0,#0x0	; 023272C4
	bne loc_023272D2	; 023272C6
	mov r0,#0x0	; 023272C8
	add r1,r0,#0x0	; 023272CA
	bl loc_0232F1DC	; 023272CC
	b loc_023272DA	; 023272D0
loc_023272D2:
	mov r0,#0x1	; 023272D2
	mov r1,#0x0	; 023272D4
	bl loc_0232F1DC	; 023272D6
loc_023272DA:
	ldr r1,[pool_0232736C]	; 023272DA
	ldrh r0,[r1,#0x0]	; 023272DC
	mov r0,#0x0	; 023272DE
	strh r0,[r1,#0x0]	; 023272E0
	bl loc_0232B184	; 023272E2
	bl loc_0232D660	; 023272E6
	bl loc_0232D650	; 023272EA
	bl loc_0232D620	; 023272EE
	bl loc_0232D610	; 023272F2
	bl loc_0232D640	; 023272F6
	ldr r0,[pool_02327370]	; 023272FA
	bl loc_0232D730	; 023272FC
	mov r0,#0x0	; 02327300
	str r0,[sp,#0x0]	; 02327302
	ldr r0,[sp,#0x0]	; 02327304
	ldr r1,[pool_02327374]	; 02327306
	ldr r2,[pool_02327378]	; 02327308
	blx loc_0232DE68	; 0232730A
	bl loc_0232D630	; 0232730E
	bl loc_02327288	; 02327312
	bl loc_0232D46C	; 02327316
	ldr r0,[pool_0232737C]	; 0232731A
	ldrh r2,[r0,#0x0]	; 0232731C
	mov r1,#0x2	; 0232731E
	orr r2,r1	; 02327320
	strh r2,[r0,#0x0]	; 02327322
	ldrh r2,[r0,#0x0]	; 02327324
	ldr r1,[pool_02327380]	; 02327326
	and r2,r1	; 02327328
	strh r2,[r0,#0x0]	; 0232732A
	ldrh r2,[r0,#0x0]	; 0232732C
	mov r1,#0xc	; 0232732E
	bic r2,r1	; 02327330
	strh r2,[r0,#0x0]	; 02327332
	ldr r1,[pool_02327364]	; 02327334
	ldrh r1,[r1,#0x0]	; 02327336
	lsl r1,r1,#0x1c	; 02327338
	lsr r1,r1,#0x1f	; 0232733A
	cmp r1,#0x0	; 0232733C
	beq loc_02327350	; 0232733E
	ldr r1,[pool_02327368]	; 02327340
	ldr r1,[r1,#0x0]	; 02327342
	cmp r1,#0x0	; 02327344
	bne loc_02327350	; 02327346
	ldrh r2,[r0,#0x0]	; 02327348
	ldr r1,[pool_02327384]	; 0232734A
	and r2,r1	; 0232734C
	strh r2,[r0,#0x0]	; 0232734E
loc_02327350:
; CpuFastSet 的 0x100 个字复制 0x400 字节，再进入新的 ITCM 段。
; CpuFastSet copies 0x100 words (0x400 bytes), then enters the new ITCM stub.
	ldr r0,[pool_02327388]	; 02327350
	ldr r1,[pool_0232738C]	; 02327352
	ldr r2,[pool_02327390]	; 02327354
	bl loc_0232C7CA	; 02327356
	ldr r0,[pool_0232738C]	; 0232735A
	blx r0	; 0232735C
	add sp,#0x4	; 0232735E
	pop {r3}	; 02327360
	bx r3	; 02327362
pool_02327364:
loc_02327364:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02327364
pool_02327368:
loc_02327368:
	.word FirmwareBootSharedAddress + BootSharedSettingsInvalidOffset	; 02327368
pool_0232736C:
loc_0232736C:
	.word REG_IME	; 0232736C
pool_02327370:
loc_02327370:
	.word 0x000001FF	; 02327370
pool_02327374:
loc_02327374:
	.word 0x06800000	; 02327374
pool_02327378:
loc_02327378:
	.word 0x000A4000	; 02327378
pool_0232737C:
loc_0232737C:
	.word REG_POWERCNT	; 0232737C
pool_02327380:
loc_02327380:
	.word 0xFFFFFDFF	; 02327380
pool_02327384:
loc_02327384:
	.word 0xFFFF7FFF	; 02327384
pool_02327388:
loc_02327388:
	.word P1_TransitionCopySource	; 02327388
pool_0232738C:
loc_0232738C:
	.word P1_TransitionRuntimeEntry	; 0232738C
pool_02327390:
loc_02327390:
	.word 0x00000100	; 02327390

; ===== function loc_02327394 =====
loc_02327394:
	push {lr}	; 02327394
	sub sp,#0x24	; 02327396
	mov r0,#0x0	; 02327398
	bl loc_0232B184	; 0232739A
	mov r0,#0x0	; 0232739E
	mvn r0,r0	; 023273A0
	bl loc_0232B10C	; 023273A2
	ldr r0,[pool_02327448]	; 023273A6
	bl loc_0232D730	; 023273A8
	mov r0,#0x0	; 023273AC
	str r0,[sp,#0x0]	; 023273AE
	ldr r0,[sp,#0x0]	; 023273B0
	ldr r1,[pool_0232744C]	; 023273B2
	ldr r2,[pool_02327450]	; 023273B4
	blx loc_0232DE68	; 023273B6
	bl loc_0232D630	; 023273BA
	mov r0,#0x0	; 023273BE
	str r0,[sp,#0x4]	; 023273C0
	ldr r0,[sp,#0x4]	; 023273C2
	ldr r1,[pool_02327454]	; 023273C4
	ldr r2,[pool_02327458]	; 023273C6
	blx loc_0232DE68	; 023273C8
	mov r0,#0x0	; 023273CC
	str r0,[sp,#0x8]	; 023273CE
	ldr r0,[sp,#0x8]	; 023273D0
	ldr r1,[pool_0232745C]	; 023273D2
	ldr r2,[pool_02327458]	; 023273D4
	blx loc_0232DE68	; 023273D6
	mov r0,#0x0	; 023273DA
	str r0,[sp,#0xc]	; 023273DC
	ldr r0,[sp,#0xc]	; 023273DE
	ldr r1,[pool_02327460]	; 023273E0
	ldr r2,[pool_02327458]	; 023273E2
	blx loc_0232DE68	; 023273E4
	mov r0,#0x0	; 023273E8
	str r0,[sp,#0x10]	; 023273EA
	ldr r0,[sp,#0x10]	; 023273EC
	ldr r1,[pool_02327464]	; 023273EE
	ldr r2,[pool_02327458]	; 023273F0
	blx loc_0232DE68	; 023273F2
	mov r0,#0x0	; 023273F6
	str r0,[sp,#0x14]	; 023273F8
	ldr r0,[sp,#0x14]	; 023273FA
	ldr r1,[pool_02327468]	; 023273FC
	ldr r2,[pool_0232746C]	; 023273FE
	blx loc_0232DE68	; 02327400
	mov r0,#0x0	; 02327404
	str r0,[sp,#0x18]	; 02327406
	ldr r0,[sp,#0x18]	; 02327408
	ldr r1,[pool_02327470]	; 0232740A
	mov r2,#0x40	; 0232740C
	blx loc_0232DE68	; 0232740E
	mov r0,#0x0	; 02327412
	str r0,[sp,#0x1c]	; 02327414
	ldr r0,[sp,#0x1c]	; 02327416
	ldr r1,[pool_02327474]	; 02327418
	mov r2,#0x6e	; 0232741A
	blx loc_0232DE68	; 0232741C
	mov r0,#0x0	; 02327420
	ldr r1,[pool_02327470]	; 02327422
	strh r0,[r1,#0x0]	; 02327424
	ldr r1,[pool_02327478]	; 02327426
	str r0,[r1,#0x0]	; 02327428
	mov r2,#0x1	; 0232742A
	ldr r1,[pool_0232747C]	; 0232742C
	str r2,[r1,#0x0]	; 0232742E
	str r0,[r1,#0x4]	; 02327430
	ldr r2,[pool_02327480]	; 02327432
	ldr r1,[pool_02327484]	; 02327434
	strh r2,[r1,#0x0]	; 02327436
	ldr r1,[pool_02327488]	; 02327438
	str r0,[r1,#0x0]	; 0232743A
	ldr r1,[pool_0232748C]	; 0232743C
	strh r0,[r1,#0x0]	; 0232743E
	add sp,#0x24	; 02327440
	pop {r3}	; 02327442
	bx r3	; 02327444
	.byte 0xC0, 0x46	; 02327448
pool_02327448:
loc_02327448:
	.word 0x000001FF	; 02327448
pool_0232744C:
loc_0232744C:
	.word 0x06800000	; 0232744C
pool_02327450:
loc_02327450:
	.word 0x000A4000	; 02327450
pool_02327454:
loc_02327454:
	.word 0x07000000	; 02327454
pool_02327458:
loc_02327458:
	.word 0x00000400	; 02327458
pool_0232745C:
loc_0232745C:
	.word 0x05000000	; 0232745C
pool_02327460:
loc_02327460:
	.word 0x07000400	; 02327460
pool_02327464:
loc_02327464:
	.word 0x05000400	; 02327464
pool_02327468:
loc_02327468:
	.word REG_BG0CNT	; 02327468
pool_0232746C:
loc_0232746C:
	.word 0x0000012C	; 0232746C
pool_02327470:
loc_02327470:
	.word REG_DIVCNT	; 02327470
pool_02327474:
loc_02327474:
	.word REG_DISPCNT_B	; 02327474
pool_02327478:
loc_02327478:
	.word REG_DIV_NUMER	; 02327478
pool_0232747C:
loc_0232747C:
	.word REG_DIV_DENOM	; 0232747C
pool_02327480:
loc_02327480:
	.word 0x00004008	; 02327480
pool_02327484:
loc_02327484:
	.word REG_IPC_FIFO_CR	; 02327484
pool_02327488:
loc_02327488:
	.word REG_DISPCNT_A	; 02327488
pool_0232748C:
loc_0232748C:
	.word REG_DISPSTAT	; 0232748C

; ===== function loc_02327490 =====
loc_02327490:
	ldr r1,[pool_023274A4]	; 02327490
	ldr r1,[r1,#0x0]	; 02327492
	and r1,r0	; 02327494
	cmp r1,#0x0	; 02327496
	beq loc_0232749E	; 02327498
	mov r0,#0x1	; 0232749A
	bx lr	; 0232749C
loc_0232749E:
	mov r0,#0x0	; 0232749E
	bx lr	; 023274A0
	.byte 0xC0, 0x46	; 023274A4
pool_023274A4:
loc_023274A4:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023274A4

; ===== function loc_023274A8 =====
loc_023274A8:
	ldr r0,[pool_023274D8]	; 023274A8
	ldr r2,[r0,#0x0]	; 023274AA
	ldr r1,[pool_023274DC]	; 023274AC
	cmp r2,r1	; 023274AE
	bcc loc_023274D2	; 023274B0
	ldr r0,[pool_023274E0]	; 023274B2
	cmp r2,r0	; 023274B4
	bcs loc_023274D2	; 023274B6
	ldr r0,[pool_023274E4]	; 023274B8
	ldr r2,[r0,#0x0]	; 023274BA
	cmp r2,r1	; 023274BC
	bcc loc_023274C6	; 023274BE
	ldr r0,[pool_023274E8]	; 023274C0
	cmp r2,r0	; 023274C2
	bcc loc_023274D4	; 023274C4
loc_023274C6:
	ldr r0,[pool_023274EC]	; 023274C6
	cmp r2,r0	; 023274C8
	bcc loc_023274D2	; 023274CA
	ldr r0,[pool_023274F0]	; 023274CC
	cmp r2,r0	; 023274CE
	bcc loc_023274D4	; 023274D0
loc_023274D2:
	b loc_023274D2	; 023274D2
loc_023274D4:
	bx lr	; 023274D4
	.byte 0xC0, 0x46	; 023274D8
pool_023274D8:
loc_023274D8:
	.word NdsCartHeaderArm9EntryAddress	; 023274D8
pool_023274DC:
loc_023274DC:
	.word 0x02000000	; 023274DC
pool_023274E0:
loc_023274E0:
	.word 0x02280000	; 023274E0
pool_023274E4:
loc_023274E4:
	.word NdsCartHeaderArm7EntryAddress	; 023274E4
pool_023274E8:
loc_023274E8:
	.word 0x023FE000	; 023274E8
pool_023274EC:
loc_023274EC:
	.word Arm7SharedWramStart	; 023274EC
pool_023274F0:
loc_023274F0:
	.word Arm7FirmwareReservedWramStart	; 023274F0

; ===== function loc_023274F4 =====
loc_023274F4:
	push {r4,lr}	; 023274F4
	bl loc_023274A8	; 023274F6
	ldr r0,[pool_02327570]	; 023274FA
	ldr r1,[pool_02327574]	; 023274FC
	ldr r2,[pool_02327578]	; 023274FE
	sub r2,r2,r0	; 02327500
	blx loc_0232DEB4	; 02327502
	ldr r0,[pool_02327570]	; 02327506
	ldr r1,[pool_0232757C]	; 02327508
	blx P1_CleanDataCacheRange	; 0232750A
	mov r4,#0x0	; 0232750E
loc_02327510:
	add r0,r4,#0x0	; 02327510
	bl loc_0232DD44	; 02327512
	add r4,r4,#0x1	; 02327516
	cmp r4,#0x3	; 02327518
	ble loc_02327510	; 0232751A
	bl loc_02327C04	; 0232751C
	bl loc_02327394	; 02327520
	mov r0,#0x0	; 02327524
	bl loc_0232D4E0	; 02327526
	ldr r0,[pool_02327580]	; 0232752A
	ldr r1,[pool_02327584]	; 0232752C
	bl loc_0232B1E0	; 0232752E
	ldr r0,[pool_02327580]	; 02327532
	bl loc_0232B184	; 02327534
	ldr r1,[pool_02327588]	; 02327538
	ldr r0,[pool_0232758C]	; 0232753A
	strh r1,[r0,#0x0]	; 0232753C
	mov r1,#0x7	; 0232753E
	ldr r0,[pool_02327590]	; 02327540
	str r1,[r0,#0x0]	; 02327542
	mov r0,#0x1	; 02327544
	ldr r1,[pool_02327580]	; 02327546
	blx loc_0232AFC8	; 02327548
	ldr r2,[pool_0232758C]	; 0232754C
	ldrh r1,[r2,#0x0]	; 0232754E
	ldr r0,[pool_02327594]	; 02327550
	and r1,r0	; 02327552
	strh r1,[r2,#0x0]	; 02327554
	ldr r1,[pool_02327598]	; 02327556
	ldrh r0,[r1,#0x0]	; 02327558
	mov r0,#0x0	; 0232755A
	strh r0,[r1,#0x0]	; 0232755C
	bl loc_0232B184	; 0232755E
	mov r0,#0x0	; 02327562
	mvn r0,r0	; 02327564
	bl loc_0232B10C	; 02327566
	pop {r4}	; 0232756A
	pop {r3}	; 0232756C
	bx r3	; 0232756E
pool_02327570:
loc_02327570:
	.word 0x02327CE0	; 02327570
pool_02327574:
loc_02327574:
	.word 0x023FEE00	; 02327574
pool_02327578:
loc_02327578:
	.word 0x02327E48	; 02327578
pool_0232757C:
loc_0232757C:
	.word 0x00000200	; 0232757C
pool_02327580:
loc_02327580:
	.word 0x00010000	; 02327580
pool_02327584:
loc_02327584:
	.word P1_IrqHandler_0232759C + 1	; 02327584
pool_02327588:
loc_02327588:
	.word 0x00004F00	; 02327588
pool_0232758C:
loc_0232758C:
	.word REG_IPC_SYNC	; 0232758C
pool_02327590:
loc_02327590:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 02327590
pool_02327594:
loc_02327594:
	.word 0x00000F00	; 02327594
pool_02327598:
loc_02327598:
	.word REG_IME	; 02327598
P1_IrqHandler_0232759C:
	ldr r1,[pool_023275AC]	; 0232759C
	ldr r0,[pool_023275B0]	; 0232759E
	add r1,r1,r0	; 023275A0
	ldr r2,[r1,#0x0]	; 023275A2
	ldr r0,[pool_023275B4]	; 023275A4
	orr r2,r0	; 023275A6
	str r2,[r1,#0x0]	; 023275A8
	bx lr	; 023275AA
pool_023275AC:
loc_023275AC:
	.word P1_DtcmRuntimeStart	; 023275AC
pool_023275B0:
loc_023275B0:
	.word 0x00003FF8	; 023275B0
pool_023275B4:
loc_023275B4:
	.word 0x00010000	; 023275B4

; ===== function loc_023275B8 =====
loc_023275B8:
; 将参数中的事件位并入双核共享位图。
; OR the requested event bits into the shared bitmap.
.func P1_OrSharedEventFlags
	push {r4,lr}	; 023275B8
	add r4,r0,#0x0	; 023275BA
	mov r0,#0x6e	; 023275BC
	ldr r1,[pool_023275DC]	; 023275BE
	mov r2,#0x0	; 023275C0
	bl loc_0232B4AC	; 023275C2
	ldr r1,[pool_023275DC]	; 023275C6
	ldr r0,[r1,#0x8]	; 023275C8
	orr r0,r4	; 023275CA
	str r0,[r1,#0x8]	; 023275CC
	mov r0,#0x6e	; 023275CE
	mov r2,#0x0	; 023275D0
	bl loc_0232B434	; 023275D2
	pop {r4}	; 023275D6
	pop {r3}	; 023275D8
	bx r3	; 023275DA
.endfunc
pool_023275DC:
loc_023275DC:
	.word FirmwareBootSharedAddress + BootSharedEventSyncOffset	; 023275DC

; ===== function loc_023275E0 =====
loc_023275E0:
	ldr r0,[pool_023275E8]	; 023275E0
	ldr r3,[pool_023275EC]	; 023275E2
	bx r3	; 023275E4
	.byte 0xC0, 0x46	; 023275E8
pool_023275E8:
loc_023275E8:
	.word 0x80000040	; 023275E8
pool_023275EC:
loc_023275EC:
	.word P1_OrSharedEventFlags + 1	; 023275EC

; ===== function loc_023275F0 =====
loc_023275F0:
	ldr r0,[pool_023275F8]	; 023275F0
	ldr r3,[pool_023275FC]	; 023275F2
	bx r3	; 023275F4
	.byte 0xC0, 0x46	; 023275F8
pool_023275F8:
loc_023275F8:
	.word 0x80000100	; 023275F8
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
	.word 0x80000080	; 02327608
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
	.word 0x80000010	; 02327618
pool_0232761C:
loc_0232761C:
	.word P1_OrSharedEventFlags + 1	; 0232761C

; ===== function loc_02327620 =====
loc_02327620:
	push {lr}	; 02327620
	sub sp,#0x4	; 02327622
	ldr r0,[pool_02327654]	; 02327624
	bl loc_02326F60	; 02327626
	cmp r0,#0x0	; 0232762A
	beq loc_02327638	; 0232762C
	ldr r1,[pool_02327658]	; 0232762E
	mov r0,#0x0	; 02327630
	ldrsh r0,[r1,r0]	; 02327632
	cmp r0,#0x1	; 02327634
	bne loc_02327646	; 02327636
loc_02327638:
	mov r0,#0x4	; 02327638
	bl P1_OrSharedEventFlags	; 0232763A
	mov r0,#0x0	; 0232763E
	add sp,#0x4	; 02327640
	pop {r3}	; 02327642
	bx r3	; 02327644
loc_02327646:
	ldr r0,[pool_0232765C]	; 02327646
	bl P1_OrSharedEventFlags	; 02327648
	mov r0,#0x1	; 0232764C
	add sp,#0x4	; 0232764E
	pop {r3}	; 02327650
	bx r3	; 02327652
pool_02327654:
loc_02327654:
	.word 0x027FFEC0	; 02327654
pool_02327658:
loc_02327658:
	.word FirmwareBootInfoScratchAddress + BootInfoCardSecureDisableOffset	; 02327658
pool_0232765C:
loc_0232765C:
	.word 0x80000020	; 0232765C

; ===== function loc_02327660 =====
loc_02327660:
	push {lr}	; 02327660
	sub sp,#0x4	; 02327662
	ldr r0,[pool_02327688]	; 02327664
	ldr r2,[r0,#0x0]	; 02327666
	mov r0,#0x8	; 02327668
	add r1,r2,#0x0	; 0232766A
	and r1,r0	; 0232766C
	cmp r1,#0x0	; 0232766E
	bne loc_02327680	; 02327670
	ldr r0,[pool_0232768C]	; 02327672
	and r2,r0	; 02327674
	cmp r2,#0x0	; 02327676
	beq loc_02327680	; 02327678
	ldr r0,[pool_02327690]	; 0232767A
	bl P1_OrSharedEventFlags	; 0232767C
loc_02327680:
	add sp,#0x4	; 02327680
	pop {r3}	; 02327682
	bx r3	; 02327684
	.byte 0xC0, 0x46	; 02327688
pool_02327688:
loc_02327688:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327688
pool_0232768C:
loc_0232768C:
	.word 0x00000400	; 0232768C
pool_02327690:
loc_02327690:
	.word 0x08000000	; 02327690

; ===== function loc_02327694 =====
loc_02327694:
	push {r4,lr}	; 02327694
	sub sp,#0x10	; 02327696
	ldr r0,[pool_02327884]	; 02327698
	ldr r1,[r0,#0x20]	; 0232769A
	cmp r1,#0x8	; 0232769C
	bls loc_023276A2	; 0232769E
	b loc_0232787A	; 023276A0
loc_023276A2:
	add r1,r1,r1	; 023276A2
P1_SwitchIndexPC_023276A2:
	add r1,pc	; 023276A4
	ldrh r1,[r1,#(P1_SwitchTable_023276A2 - (P1_SwitchIndexPC_023276A2 + 4))]	; 023276A6
	lsl r1,r1,#0x10	; 023276A8
	asr r1,r1,#0x10	; 023276AA
P1_SwitchTargetPC_023276A2:
	add r1,pc	; 023276AC
	bx r1	; 023276AE
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023276A2:
	.halfword (loc_0232787A + 1) - (P1_SwitchTargetPC_023276A2 + 4)
	.halfword (loc_0232787A + 1) - (P1_SwitchTargetPC_023276A2 + 4)
	.halfword (loc_023276C2 + 1) - (P1_SwitchTargetPC_023276A2 + 4)
	.halfword (loc_02327716 + 1) - (P1_SwitchTargetPC_023276A2 + 4)
	.halfword (loc_02327766 + 1) - (P1_SwitchTargetPC_023276A2 + 4)
	.halfword (loc_02327780 + 1) - (P1_SwitchTargetPC_023276A2 + 4)
	.halfword (loc_02327792 + 1) - (P1_SwitchTargetPC_023276A2 + 4)
	.halfword (loc_0232787A + 1) - (P1_SwitchTargetPC_023276A2 + 4)
	.halfword (loc_023277E4 + 1) - (P1_SwitchTargetPC_023276A2 + 4)
P1_SwitchTable_023276A2End:
loc_023276C2:
	bl loc_02326FF8	; 023276C2
	bl loc_02326FDC	; 023276C6
	mov r4,#0x0	; 023276CA
	bl loc_02326F9C	; 023276CC
	cmp r0,#0x0	; 023276D0
	beq loc_023276E6	; 023276D2
	mov r0,#0x2	; 023276D4
	orr r4,r0	; 023276D6
	ldr r0,[pool_02327888]	; 023276D8
	bl loc_02326F60	; 023276DA
	cmp r0,#0x0	; 023276DE
	bne loc_023276E6	; 023276E0
	mov r0,#0x4	; 023276E2
	orr r4,r0	; 023276E4
loc_023276E6:
	bl loc_02328594	; 023276E6
	cmp r0,#0x0	; 023276EA
	beq loc_023276FC	; 023276EC
	mov r0,#0x1	; 023276EE
	orr r4,r0	; 023276F0
	ldr r2,[pool_0232788C]	; 023276F2
	ldrb r1,[r2,#0x0]	; 023276F4
	bic r1,r0	; 023276F6
	orr r1,r0	; 023276F8
	strb r1,[r2,#0x0]	; 023276FA
loc_023276FC:
	bl loc_02326E8C	; 023276FC
	bl P1_Runtime_01FF8084	; 02327700
	ldr r0,[pool_02327890]	; 02327704
	orr r4,r0	; 02327706
	add r0,r4,#0x0	; 02327708
	bl P1_OrSharedEventFlags	; 0232770A
	mov r1,#0x3	; 0232770E
	ldr r0,[pool_02327884]	; 02327710
	str r1,[r0,#0x20]	; 02327712
	b loc_0232787A	; 02327714
loc_02327716:
	ldr r3,[pool_02327894]	; 02327716
	ldr r2,[r3,#0x0]	; 02327718
	ldr r1,[pool_02327898]	; 0232771A
	and r2,r1	; 0232771C
	cmp r2,#0x0	; 0232771E
	bne loc_02327724	; 02327720
	b loc_0232787A	; 02327722
loc_02327724:
	ldr r2,[r3,#0x0]	; 02327724
	mov r1,#0x20	; 02327726
	and r2,r1	; 02327728
	cmp r2,#0x0	; 0232772A
	beq loc_0232773C	; 0232772C
	mov r0,#0x3	; 0232772E
	bl loc_02326FCC	; 02327730
	mov r1,#0x4	; 02327734
	ldr r0,[pool_02327884]	; 02327736
	str r1,[r0,#0x20]	; 02327738
	b loc_0232787A	; 0232773A
loc_0232773C:
	ldr r2,[r3,#0x0]	; 0232773C
	mov r1,#0x10	; 0232773E
	and r2,r1	; 02327740
	cmp r2,#0x0	; 02327742
	beq loc_0232774C	; 02327744
	mov r1,#0x5	; 02327746
	str r1,[r0,#0x20]	; 02327748
	b loc_0232787A	; 0232774A
loc_0232774C:
	ldr r1,[r3,#0x0]	; 0232774C
	ldr r0,[pool_0232789C]	; 0232774E
	and r1,r0	; 02327750
	cmp r1,#0x0	; 02327752
	bne loc_02327758	; 02327754
	b loc_0232787A	; 02327756
loc_02327758:
	mov r0,#0x6	; 02327758
	bl loc_02326FCC	; 0232775A
	mov r1,#0x6	; 0232775E
	ldr r0,[pool_02327884]	; 02327760
	str r1,[r0,#0x20]	; 02327762
	b loc_0232787A	; 02327764
loc_02327766:
	ldr r0,[pool_023278A0]	; 02327766
	bl loc_02327490	; 02327768
	cmp r0,#0x0	; 0232776C
	bne loc_02327772	; 0232776E
	b loc_0232787A	; 02327770
loc_02327772:
	bl loc_023274F4	; 02327772
	mov r0,#0x1	; 02327776
	add sp,#0x10	; 02327778
	pop {r4}	; 0232777A
	pop {r3}	; 0232777C
	bx r3	; 0232777E
loc_02327780:
	ldr r0,[r0,#0x24]	; 02327780
	cmp r0,#0x2	; 02327782
	bne loc_0232787A	; 02327784
	mov r0,#0x4	; 02327786
	bl loc_02326FCC	; 02327788
	bl loc_023272B0	; 0232778C
	b loc_0232787A	; 02327790
loc_02327792:
	ldr r0,[pool_02327894]	; 02327792
	ldr r1,[r0,#0x0]	; 02327794
	ldr r0,[pool_023278A4]	; 02327796
	and r1,r0	; 02327798
	cmp r1,#0x0	; 0232779A
	beq loc_0232787A	; 0232779C
	bl P1_DecompressAndCheckP3P4	; 0232779E
	ldr r0,[pool_023278A8]	; 023277A2
	bl P1_OrSharedEventFlags	; 023277A4
	mov r0,#0x0	; 023277A8
	str r0,[sp,#0x4]	; 023277AA
	ldr r0,[sp,#0x4]	; 023277AC
	ldr r1,[pool_023278AC]	; 023277AE
	ldr r2,[pool_023278B0]	; 023277B0
	blx loc_0232DE68	; 023277B2
; 按此版本的零区起点和字节数清零，SWI 参数换算为 32 位字数。
; Clear this version's zero area; convert its byte size to the SWI word count.
	ldr r2,[pool_023278B4]	; 023277B6
	cmp r2,#0x0	; 023277B8
	beq loc_023277D2	; 023277BA
	mov r0,#0x0	; 023277BC
	str r0,[sp,#0x0]	; 023277BE
	add r0,sp,#0x0	; 023277C0
	ldr r1,[pool_023278B8]	; 023277C2
	lsr r2,r2,#0x2	; 023277C4
	ldr r3,[pool_023278BC]	; 023277C6
	and r2,r3	; 023277C8
	ldr r3,[pool_023278C0]	; 023277CA
	orr r2,r3	; 023277CC
	bl loc_0232C7CA	; 023277CE
loc_023277D2:
	blx P1_CleanEntireDataCacheByIndex	; 023277D2
	mov r0,#0x7	; 023277D6
	bl loc_02326FCC	; 023277D8
	mov r1,#0x8	; 023277DC
	ldr r0,[pool_02327884]	; 023277DE
	str r1,[r0,#0x20]	; 023277E0
	b loc_0232787A	; 023277E2
loc_023277E4:
	ldr r0,[pool_02327894]	; 023277E4
	ldr r2,[r0,#0x0]	; 023277E6
	ldr r1,[pool_023278C4]	; 023277E8
	and r2,r1	; 023277EA
	cmp r2,#0x0	; 023277EC
	beq loc_0232787A	; 023277EE
	ldr r2,[r0,#0x0]	; 023277F0
	ldr r1,[pool_023278C8]	; 023277F2
	and r2,r1	; 023277F4
	cmp r2,#0x0	; 023277F6
	beq loc_0232787A	; 023277F8
	ldr r2,[r0,#0x0]	; 023277FA
	mov r1,#0x80	; 023277FC
	and r2,r1	; 023277FE
	cmp r2,#0x0	; 02327800
	beq loc_0232780E	; 02327802
	ldr r0,[pool_023278CC]	; 02327804
	ldr r0,[r0,#0x0]	; 02327806
	ldr r0,[r0,#0x0]	; 02327808
	blx r0	; 0232780A
	b loc_02327870	; 0232780C
loc_0232780E:
	ldr r2,[r0,#0x0]	; 0232780E
	ldr r1,[pool_023278D0]	; 02327810
	and r2,r1	; 02327812
	cmp r2,#0x0	; 02327814
	beq loc_0232785E	; 02327816
	ldr r1,[r0,#0x0]	; 02327818
	mov r0,#0x2	; 0232781A
	and r1,r0	; 0232781C
	cmp r1,#0x0	; 0232781E
	beq loc_02327826	; 02327820
	mov r0,#0x1	; 02327822
	b loc_02327828	; 02327824
loc_02327826:
	mov r0,#0x0	; 02327826
loc_02327828:
	cmp r0,#0x0	; 02327828
	beq loc_0232784C	; 0232782A
	ldr r0,[pool_02327884]	; 0232782C
	ldr r1,[r0,#0x0]	; 0232782E
	ldr r0,[pool_023278D4]	; 02327830
	str r1,[r0,#0x0]	; 02327832
	ldr r0,[pool_023278D8]	; 02327834
	ldr r1,[pool_023278DC]	; 02327836
	ldr r2,[pool_023278E0]	; 02327838
	blx loc_0232DEB4	; 0232783A
	mov r0,#0x0	; 0232783E
	str r0,[sp,#0x8]	; 02327840
	ldr r0,[sp,#0x8]	; 02327842
	ldr r1,[pool_023278D8]	; 02327844
	ldr r2,[pool_023278E0]	; 02327846
	blx loc_0232DE68	; 02327848
loc_0232784C:
	ldr r0,[pool_023278CC]	; 0232784C
	ldr r0,[r0,#0x0]	; 0232784E
	ldr r0,[r0,#0x4]	; 02327850
	blx r0	; 02327852
	blx P1_CleanEntireDataCacheByIndex	; 02327854
	bl loc_023274F4	; 02327858
	b loc_02327870	; 0232785C
loc_0232785E:
	ldr r1,[r0,#0x0]	; 0232785E
	mov r0,#0x40	; 02327860
	and r1,r0	; 02327862
	cmp r1,#0x0	; 02327864
	beq loc_02327870	; 02327866
	ldr r0,[pool_023278CC]	; 02327868
	ldr r0,[r0,#0x0]	; 0232786A
	ldr r0,[r0,#0x8]	; 0232786C
	blx r0	; 0232786E
loc_02327870:
	mov r0,#0x1	; 02327870
	add sp,#0x10	; 02327872
	pop {r4}	; 02327874
	pop {r3}	; 02327876
	bx r3	; 02327878
loc_0232787A:
	mov r0,#0x0	; 0232787A
	add sp,#0x10	; 0232787C
	pop {r4}	; 0232787E
	pop {r3}	; 02327880
	bx r3	; 02327882
pool_02327884:
loc_02327884:
	.word FirmwareBootSharedAddress	; 02327884
pool_02327888:
loc_02327888:
	.word 0x027FFEC0	; 02327888
pool_0232788C:
loc_0232788C:
	.word FirmwareBootInfoAddress + BootInfoGbaFlagsOffset	; 0232788C
pool_02327890:
loc_02327890:
	.word 0x20000000	; 02327890
pool_02327894:
loc_02327894:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327894
pool_02327898:
loc_02327898:
	.word 0x80000000	; 02327898
pool_0232789C:
loc_0232789C:
	.word 0x000001C0	; 0232789C
pool_023278A0:
loc_023278A0:
	.word 0x00000200	; 023278A0
pool_023278A4:
loc_023278A4:
	.word 0x00001000	; 023278A4
pool_023278A8:
loc_023278A8:
	.word 0x00000400	; 023278A8
pool_023278AC:
loc_023278AC:
	.word 0x02000000	; 023278AC
pool_023278B0:
loc_023278B0:
	.word 0x00300000	; 023278B0
pool_023278B4:
loc_023278B4:
	.word UiBootZeroBytes	; 023278B4
pool_023278B8:
loc_023278B8:
	.word UiBootZeroStart	; 023278B8
pool_023278BC:
loc_023278BC:
	.word 0x001FFFFF	; 023278BC
pool_023278C0:
loc_023278C0:
	.word 0x01000000	; 023278C0
pool_023278C4:
loc_023278C4:
	.word 0x40000000	; 023278C4
pool_023278C8:
loc_023278C8:
	.word 0x08000000	; 023278C8
pool_023278CC:
loc_023278CC:
	.word P1_BssStart + 0x24E28	; 023278CC
pool_023278D0:
loc_023278D0:
	.word 0x00000100	; 023278D0
pool_023278D4:
loc_023278D4:
	.word NdsCartHeaderArm7RamAddress	; 023278D4
pool_023278D8:
loc_023278D8:
	.word 0x027FFE00	; 023278D8
pool_023278DC:
loc_023278DC:
	.word 0x023FE940	; 023278DC
pool_023278E0:
loc_023278E0:
	.word 0x00000160	; 023278E0

; ===== function loc_023278E4 =====
loc_023278E4:
	push {r4,r5,r6,r7,lr}	; 023278E4
	sub sp,#0x4	; 023278E6
	ldr r4,[pool_02327938]	; 023278E8
	ldr r6,[pool_0232793C]	; 023278EA
	ldr r7,[pool_02327940]	; 023278EC
loc_023278EE:
	ldr r5,[r6,#0x0]	; 023278EE
	ldr r0,[pool_02327944]	; 023278F0
	bl P1_SwiWaitByLoop	; 023278F2
	add r0,r5,#0x0	; 023278F6
	and r0,r4	; 023278F8
	cmp r0,#0x0	; 023278FA
	bne loc_02327910	; 023278FC
	and r5,r7	; 023278FE
	cmp r5,#0x0	; 02327900
	beq loc_023278EE	; 02327902
	bl P1_DecompressAndCheckP5	; 02327904
	add r0,r4,#0x0	; 02327908
	bl P1_OrSharedEventFlags	; 0232790A
	b loc_023278EE	; 0232790E
loc_02327910:
	bl loc_02327170	; 02327910
	mov r1,#0x2	; 02327914
	ldr r0,[pool_02327948]	; 02327916
	str r1,[r0,#0x0]	; 02327918
	ldr r2,[pool_0232794C]	; 0232791A
	ldrh r1,[r2,#0x0]	; 0232791C
	mov r0,#0x1	; 0232791E
	orr r1,r0	; 02327920
	strh r1,[r2,#0x0]	; 02327922
	bl loc_02327CC0	; 02327924
	bl loc_02327058	; 02327928
	mov r0,#0x0	; 0232792C
	add sp,#0x4	; 0232792E
	pop {r4,r5,r6,r7}	; 02327930
	pop {r3}	; 02327932
	bx r3	; 02327934
	.byte 0xC0, 0x46	; 02327938
pool_02327938:
loc_02327938:
	.word 0x00000800	; 02327938
pool_0232793C:
loc_0232793C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 0232793C
pool_02327940:
loc_02327940:
	.word 0x00002000	; 02327940
pool_02327944:
loc_02327944:
	.word 0x00001000	; 02327944
pool_02327948:
loc_02327948:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 02327948
pool_0232794C:
loc_0232794C:
	.word REG_POSTFLG	; 0232794C

; ===== function P1_ClipMemoryRangeToBounds =====
; Rejects a (start,length) range outside the supplied bounds; trims a range that crosses the upper bound.
; 将越出给定边界的（起始地址、长度）范围置零；超过上界时截短长度。
.func P1_ClipMemoryRangeToBounds
loc_02327950:
	push {r4,r5}	; 02327950
	ldr r5,[r0,#0x0]	; 02327952
	ldr r3,[r0,#0x4]	; 02327954
	add r4,r5,r3	; 02327956
	cmp r5,r1	; 02327958
	bcc loc_02327960	; 0232795A
	cmp r5,r2	; 0232795C
	bls loc_02327968	; 0232795E
loc_02327960:
	mov r1,#0x0	; 02327960
	str r1,[r0,#0x4]	; 02327962
	pop {r4,r5}	; 02327964
	bx lr	; 02327966
loc_02327968:
	cmp r4,r2	; 02327968
	bls loc_02327972	; 0232796A
	sub r1,r4,r2	; 0232796C
	sub r1,r3,r1	; 0232796E
	str r1,[r0,#0x4]	; 02327970
loc_02327972:
	pop {r4,r5}	; 02327972
	bx lr	; 02327974
.endfunc
	.byte 0x00, 0x00	; 02327978

; ===== function P1_ConstrainNdsHeaderImageLoadRanges =====
; Constrains ARM7/ARM9 image load ranges recorded in the copied NDS card header before boot.
; 启动前约束复制到 RAM 的 NDS 卡带头内 ARM7/ARM9 映像装载范围。
.func P1_ConstrainNdsHeaderImageLoadRanges
loc_02327978:
	push {lr}	; 02327978
	sub sp,#0x4	; 0232797A
	bl loc_02326F9C	; 0232797C
	cmp r0,#0x0	; 02327980
	beq loc_023279E4	; 02327982
	ldr r0,[pool_023279EC]	; 02327984
	ldr r2,[r0,#0x0]	; 02327986
	ldr r1,[pool_023279F0]	; 02327988
	cmp r2,r1	; 0232798A
	bcc loc_023279A2	; 0232798C
	ldr r2,[pool_023279F4]	; 0232798E
	bl P1_ClipMemoryRangeToBounds	; 02327990
	ldr r2,[pool_023279EC]	; 02327994
	ldr r1,[r2,#0x0]	; 02327996
	ldr r0,[pool_023279F8]	; 02327998
	str r1,[r0,#0x0]	; 0232799A
	ldr r0,[pool_023279FC]	; 0232799C
	str r0,[r2,#0x0]	; 0232799E
	b loc_023279DA	; 023279A0
loc_023279A2:
	ldr r1,[pool_02327A00]	; 023279A2
	ldr r2,[pool_02327A04]	; 023279A4
	bl P1_ClipMemoryRangeToBounds	; 023279A6
	ldr r1,[pool_023279EC]	; 023279AA
	ldr r3,[r1,#0x0]	; 023279AC
	ldr r0,[pool_02327A08]	; 023279AE
	cmp r3,r0	; 023279B0
	bcc loc_023279CA	; 023279B2
	ldr r0,[pool_023279F8]	; 023279B4
	str r3,[r0,#0x0]	; 023279B6
	ldr r0,[pool_023279FC]	; 023279B8
	str r0,[r1,#0x0]	; 023279BA
	ldr r2,[pool_02327A0C]	; 023279BC
	ldr r1,[r2,#0x0]	; 023279BE
	ldr r0,[pool_02327A10]	; 023279C0
	cmp r1,r0	; 023279C2
	bls loc_023279DA	; 023279C4
	str r0,[r2,#0x0]	; 023279C6
	b loc_023279DA	; 023279C8
loc_023279CA:
	ldr r2,[pool_02327A0C]	; 023279CA
	ldr r1,[r2,#0x0]	; 023279CC
	add r3,r3,r1	; 023279CE
	cmp r3,r0	; 023279D0
	bls loc_023279DA	; 023279D2
	sub r0,r3,r0	; 023279D4
	sub r0,r1,r0	; 023279D6
	str r0,[r2,#0x0]	; 023279D8
loc_023279DA:
	ldr r0,[pool_02327A14]	; 023279DA
	ldr r1,[pool_02327A00]	; 023279DC
	ldr r2,[pool_023279FC]	; 023279DE
	bl P1_ClipMemoryRangeToBounds	; 023279E0
loc_023279E4:
	add sp,#0x4	; 023279E4
	pop {r3}	; 023279E6
	bx r3	; 023279E8
.endfunc
	.byte 0xC0, 0x46	; 023279EC
pool_023279EC:
loc_023279EC:
	.word NdsCartHeaderArm7RamAddress	; 023279EC
pool_023279F0:
loc_023279F0:
	.word Arm7SharedWramStart	; 023279F0
pool_023279F4:
loc_023279F4:
	.word Arm7FirmwareReservedWramStart	; 023279F4
pool_023279F8:
loc_023279F8:
	.word FirmwareBootSharedAddress	; 023279F8
pool_023279FC:
loc_023279FC:
	.word 0x022C0000	; 023279FC
pool_02327A00:
loc_02327A00:
	.word 0x02000000	; 02327A00
pool_02327A04:
loc_02327A04:
	.word 0x023FE000	; 02327A04
pool_02327A08:
loc_02327A08:
	.word 0x02300000	; 02327A08
pool_02327A0C:
loc_02327A0C:
	.word NdsCartHeaderArm7SizeAddress	; 02327A0C
pool_02327A10:
loc_02327A10:
	.word 0x00040000	; 02327A10
pool_02327A14:
loc_02327A14:
	.word NdsCartHeaderArm9RamAddress	; 02327A14

; ===== function loc_02327A18 =====
loc_02327A18:
	push {r4,lr}	; 02327A18
	sub sp,#0x8	; 02327A1A
	add r4,r0,#0x0	; 02327A1C
	ldr r2,[pool_02327A90]	; 02327A1E
	ldrh r1,[r2,#0x0]	; 02327A20
	ldr r0,[pool_02327A94]	; 02327A22
	orr r1,r0	; 02327A24
	strh r1,[r2,#0x0]	; 02327A26
	ldrh r1,[r2,#0x0]	; 02327A28
	mov r0,#0xc	; 02327A2A
	bic r1,r0	; 02327A2C
	strh r1,[r2,#0x0]	; 02327A2E
	ldrh r1,[r2,#0x0]	; 02327A30
	mov r0,#0x10	; 02327A32
	bic r1,r0	; 02327A34
	strh r1,[r2,#0x0]	; 02327A36
	mov r0,#0x3	; 02327A38
	bl loc_0232DD38	; 02327A3A
	ldr r0,[pool_02327A98]	; 02327A3E
	ldr r1,[pool_02327A9C]	; 02327A40
	blx P1_InvalidateDataCacheRange	; 02327A42
	mov r0,#0x0	; 02327A46
	str r0,[sp,#0x0]	; 02327A48
	add r0,sp,#0x0	; 02327A4A
	ldr r1,[pool_02327AA0]	; 02327A4C
	ldr r2,[pool_02327AA4]	; 02327A4E
	bl loc_0232C7CA	; 02327A50
	ldr r0,[pool_02327AA8]	; 02327A54
	str r4,[r0,#0x0]	; 02327A56
	mov r1,#0x1	; 02327A58
	ldr r0,[pool_02327AAC]	; 02327A5A
	str r1,[r0,#0x0]	; 02327A5C
	bl P1_ConstrainNdsHeaderImageLoadRanges	; 02327A5E
	bl loc_02326E50	; 02327A62
	ldr r0,[pool_02327AB0]	; 02327A66
	add r0,#0x19	; 02327A68
	mov r1,#0x0	; 02327A6A
	mov r2,#0x37	; 02327A6C
	blx loc_0232DEEC	; 02327A6E
	ldr r1,[pool_02327AB4]	; 02327A72
	mov r0,#0x0	; 02327A74
	ldrsh r0,[r1,r0]	; 02327A76
	cmp r0,#0x0	; 02327A78
	bne loc_02327A86	; 02327A7A
	ldr r2,[pool_02327AB8]	; 02327A7C
	ldr r1,[r2,#0x0]	; 02327A7E
	ldr r0,[pool_02327ABC]	; 02327A80
	orr r1,r0	; 02327A82
	str r1,[r2,#0x0]	; 02327A84
loc_02327A86:
	add sp,#0x8	; 02327A86
	pop {r4}	; 02327A88
	pop {r3}	; 02327A8A
	bx r3	; 02327A8C
	.byte 0xC0, 0x46	; 02327A90
pool_02327A90:
loc_02327A90:
	.word REG_EXMEMCNT_ARM9	; 02327A90
pool_02327A94:
loc_02327A94:
	.word 0x00008000	; 02327A94
pool_02327A98:
loc_02327A98:
	.word 0x022C0000	; 02327A98
pool_02327A9C:
loc_02327A9C:
	.word 0x00040000	; 02327A9C
pool_02327AA0:
loc_02327AA0:
	.word 0x027FF860	; 02327AA0
pool_02327AA4:
loc_02327AA4:
	.word 0x0100001D	; 02327AA4
pool_02327AA8:
loc_02327AA8:
	.word P1_BssStart + 0x24E28	; 02327AA8
pool_02327AAC:
loc_02327AAC:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 02327AAC
pool_02327AB0:
loc_02327AB0:
	.word 0x027FF800	; 02327AB0
pool_02327AB4:
loc_02327AB4:
	.word FirmwareBootInfoScratchAddress + BootInfoHasSerialDebuggerOffset	; 02327AB4
pool_02327AB8:
loc_02327AB8:
	.word NdsCartHeaderRamAddress + 0x60	; 02327AB8
pool_02327ABC:
loc_02327ABC:
	.word 0x00406000	; 02327ABC

; 向 Game Card Command Out 写入 8 字节命令。
; Writes an eight-byte command to Game Card Command Out.
.func P1_WriteGameCardCommand
loc_02327AC0:
	push {r4,r5}	; 02327AC0
	mov r2,#0x80	; 02327AC2
	ldr r1,[pool_02327AF0]	; 02327AC4
	strb r2,[r1,#0x0]	; 02327AC6
	mov r2,#0x0	; 02327AC8
	ldr r1,[pool_02327AF4]	; 02327ACA
	mov r3,#0x1	; 02327ACC
loc_02327ACE:
	sub r4,r3,r2	; 02327ACE
	lsl r4,r4,#0x2	; 02327AD0
	ldr r5,[r0,r4]	; 02327AD2
	lsr r4,r5,#0x18	; 02327AD4
	strb r4,[r1,#0x0]	; 02327AD6
	lsr r4,r5,#0x10	; 02327AD8
	strb r4,[r1,#0x1]	; 02327ADA
	lsr r4,r5,#0x8	; 02327ADC
	strb r4,[r1,#0x2]	; 02327ADE
	strb r5,[r1,#0x3]	; 02327AE0
	add r1,r1,#0x4	; 02327AE2
	add r2,r2,#0x1	; 02327AE4
	cmp r2,#0x2	; 02327AE6
	blt loc_02327ACE	; 02327AE8
	pop {r4,r5}	; 02327AEA
	bx lr	; 02327AEC
.endfunc
	.byte 0xC0, 0x46	; 02327AF0
pool_02327AF0:
loc_02327AF0:
	.word REG_AUXSPICNT + 1	; 02327AF0
pool_02327AF4:
loc_02327AF4:
	.word REG_GCCMDOUT	; 02327AF4

; 以 B7 命令从 Slot-1 读数据，轮询 ROMCTRL 并取回 GCDATAIN。
; Reads Slot-1 data with command B7, polling ROMCTRL and consuming GCDATAIN.
.func P1_ReadGameCardData
loc_02327AF8:
	push {r4,r5,r6,r7,lr}	; 02327AF8
	sub sp,#0xc	; 02327AFA
	add r5,r1,#0x0	; 02327AFC
	add r4,r2,#0x0	; 02327AFE
	lsl r1,r0,#0x18	; 02327B00
	str r1,[sp,#0x0]	; 02327B02
	lsr r1,r0,#0x8	; 02327B04
	ldr r0,[pool_02327B48]	; 02327B06
	orr r1,r0	; 02327B08
	str r1,[sp,#0x4]	; 02327B0A
	add r0,sp,#0x0	; 02327B0C
	bl P1_WriteGameCardCommand	; 02327B0E
	ldr r0,[pool_02327B4C]	; 02327B12
	ldr r1,[r0,#0x0]	; 02327B14
	ldr r0,[pool_02327B50]	; 02327B16
	orr r1,r0	; 02327B18
	ldr r0,[pool_02327B54]	; 02327B1A
	str r1,[r0,#0x0]	; 02327B1C
	add r2,r5,r4	; 02327B1E
	ldr r7,[pool_02327B58]	; 02327B20
	ldr r3,[pool_02327B5C]	; 02327B22
	ldr r4,[pool_02327B60]	; 02327B24
loc_02327B26:
	ldr r1,[r0,#0x0]	; 02327B26
	add r6,r1,#0x0	; 02327B28
	and r6,r4	; 02327B2A
	cmp r6,#0x0	; 02327B2C
	beq loc_02327B3A	; 02327B2E
	ldr r6,[r7,#0x0]	; 02327B30
	cmp r5,r2	; 02327B32
	bcs loc_02327B38	; 02327B34
	str r6,[r5,#0x0]	; 02327B36
loc_02327B38:
	add r5,r5,#0x4	; 02327B38
loc_02327B3A:
	and r1,r3	; 02327B3A
	cmp r1,#0x0	; 02327B3C
	bne loc_02327B26	; 02327B3E
	add sp,#0xc	; 02327B40
	pop {r4,r5,r6,r7}	; 02327B42
	pop {r3}	; 02327B44
	bx r3	; 02327B46
.endfunc
pool_02327B48:
loc_02327B48:
	.word 0xB7000000	; 02327B48
pool_02327B4C:
loc_02327B4C:
	.word NdsCartHeaderRamAddress + 0x60	; 02327B4C
pool_02327B50:
loc_02327B50:
	.word 0xA1000000	; 02327B50
pool_02327B54:
loc_02327B54:
	.word REG_ROMCTRL	; 02327B54
pool_02327B58:
loc_02327B58:
	.word REG_GCDATAIN	; 02327B58
pool_02327B5C:
loc_02327B5C:
	.word 0x80000000	; 02327B5C
pool_02327B60:
loc_02327B60:
	.word 0x00800000	; 02327B60

; ===== function loc_02327B64 =====
loc_02327B64:
	push {r4,r5,r6,r7,lr}	; 02327B64
	sub sp,#0x4	; 02327B66
	add r6,r0,#0x0	; 02327B68
	add r7,r1,#0x0	; 02327B6A
	add r5,r2,#0x0	; 02327B6C
	add r4,r5,#0x0	; 02327B6E
	cmp r5,#0x0	; 02327B70
	ble loc_02327B94	; 02327B72
loc_02327B74:
	ldr r0,[pool_02327B9C]	; 02327B74
	cmp r4,r0	; 02327B76
	blt loc_02327B7E	; 02327B78
	lsl r5,r0,#0	; 02327B7A
	b loc_02327B80	; 02327B7C
loc_02327B7E:
	add r5,r4,#0x0	; 02327B7E
loc_02327B80:
	add r0,r6,#0x0	; 02327B80
	add r1,r7,#0x0	; 02327B82
	add r2,r5,#0x0	; 02327B84
	bl loc_02327AF8	; 02327B86
	add r6,r6,r5	; 02327B8A
	add r7,r7,r5	; 02327B8C
	sub r4,r4,r5	; 02327B8E
	cmp r4,#0x0	; 02327B90
	bgt loc_02327B74	; 02327B92
loc_02327B94:
	add sp,#0x4	; 02327B94
	pop {r4,r5,r6,r7}	; 02327B96
	pop {r3}	; 02327B98
	bx r3	; 02327B9A
pool_02327B9C:
loc_02327B9C:
	.word 0x00000200	; 02327B9C

; ===== function loc_02327BA0 =====
loc_02327BA0:
	push {lr}	; 02327BA0
	sub sp,#0xc	; 02327BA2
	mov r0,#0x0	; 02327BA4
	str r0,[sp,#0x0]	; 02327BA6
	ldr r0,[pool_02327BC4]	; 02327BA8
	str r0,[sp,#0x4]	; 02327BAA
	add r0,sp,#0x0	; 02327BAC
	bl loc_02327AC0	; 02327BAE
	ldr r0,[pool_02327BC8]	; 02327BB2
	ldr r1,[r0,#0x4]	; 02327BB4
	ldr r0,[pool_02327BCC]	; 02327BB6
	orr r1,r0	; 02327BB8
	ldr r0,[pool_02327BD0]	; 02327BBA
	str r1,[r0,#0x0]	; 02327BBC
	add sp,#0xc	; 02327BBE
	pop {r3}	; 02327BC0
	bx r3	; 02327BC2
pool_02327BC4:
loc_02327BC4:
	.word 0xB8000000	; 02327BC4
pool_02327BC8:
loc_02327BC8:
	.word P1_BssStart + 0x25740	; 02327BC8
pool_02327BCC:
loc_02327BCC:
	.word 0xA7000000	; 02327BCC
pool_02327BD0:
loc_02327BD0:
	.word REG_ROMCTRL	; 02327BD0

; ===== function loc_02327BD4 =====
loc_02327BD4:
	ldr r0,[pool_02327BE8]	; 02327BD4
	ldr r1,[r0,#0x0]	; 02327BD6
	ldr r0,[pool_02327BEC]	; 02327BD8
	and r1,r0	; 02327BDA
	cmp r1,#0x0	; 02327BDC
	beq loc_02327BE4	; 02327BDE
	mov r0,#0x1	; 02327BE0
	bx lr	; 02327BE2
loc_02327BE4:
	mov r0,#0x0	; 02327BE4
	bx lr	; 02327BE6
pool_02327BE8:
loc_02327BE8:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327BE8
pool_02327BEC:
loc_02327BEC:
	.word 0x00000200	; 02327BEC

; ===== function loc_02327BF0 =====
loc_02327BF0:
	ldr r0,[pool_02327C00]	; 02327BF0
	ldr r0,[r0,#0x0]	; 02327BF2
	cmp r0,#0x1	; 02327BF4
	bne loc_02327BFC	; 02327BF6
	mov r0,#0x1	; 02327BF8
	bx lr	; 02327BFA
loc_02327BFC:
	mov r0,#0x0	; 02327BFC
	bx lr	; 02327BFE
pool_02327C00:
loc_02327C00:
	.word P1_BssStart + 0x25740	; 02327C00

; ===== function loc_02327C04 =====
loc_02327C04:
	push {lr}	; 02327C04
	sub sp,#0x4	; 02327C06
	bl loc_02327BF0	; 02327C08
	cmp r0,#0x0	; 02327C0C
	beq loc_02327C1C	; 02327C0E
loc_02327C10:
	bl loc_02327C24	; 02327C10
	bl loc_02327BF0	; 02327C14
	cmp r0,#0x0	; 02327C18
	bne loc_02327C10	; 02327C1A
loc_02327C1C:
	add sp,#0x4	; 02327C1C
	pop {r3}	; 02327C1E
	bx r3	; 02327C20
	.byte 0x00, 0x00	; 02327C24

; ===== function loc_02327C24 =====
loc_02327C24:
	push {lr}	; 02327C24
	sub sp,#0x4	; 02327C26
	bl loc_02327BD4	; 02327C28
	cmp r0,#0x0	; 02327C2C
	bne loc_02327C38	; 02327C2E
	mov r0,#0x0	; 02327C30
	add sp,#0x4	; 02327C32
	pop {r3}	; 02327C34
	bx r3	; 02327C36
loc_02327C38:
	ldr r0,[pool_02327CA8]	; 02327C38
	ldr r1,[r0,#0x0]	; 02327C3A
	cmp r1,#0x0	; 02327C3C
	beq loc_02327C46	; 02327C3E
	cmp r1,#0x1	; 02327C40
	beq loc_02327C5C	; 02327C42
	b loc_02327C9E	; 02327C44
loc_02327C46:
	ldrh r0,[r0,#0x8]	; 02327C46
	bl loc_0232B324	; 02327C48
	cmp r0,#0x0	; 02327C4C
	bne loc_02327C9E	; 02327C4E
	bl loc_02327BA0	; 02327C50
	mov r1,#0x1	; 02327C54
	ldr r0,[pool_02327CA8]	; 02327C56
	str r1,[r0,#0x0]	; 02327C58
	b loc_02327C9E	; 02327C5A
loc_02327C5C:
	ldr r0,[pool_02327CAC]	; 02327C5C
	ldr r1,[r0,#0x0]	; 02327C5E
	ldr r0,[pool_02327CB0]	; 02327C60
	and r1,r0	; 02327C62
	cmp r1,#0x0	; 02327C64
	beq loc_02327C9E	; 02327C66
	ldr r0,[pool_02327CB4]	; 02327C68
	ldr r1,[r0,#0x0]	; 02327C6A
	ldr r0,[pool_02327CB8]	; 02327C6C
	ldr r0,[r0,#0x0]	; 02327C6E
	cmp r1,r0	; 02327C70
	beq loc_02327C90	; 02327C72
	ldr r0,[pool_02327CBC]	; 02327C74
	ldr r1,[r0,#0x0]	; 02327C76
	mov r0,#0x2	; 02327C78
	and r1,r0	; 02327C7A
	cmp r1,#0x0	; 02327C7C
	beq loc_02327C84	; 02327C7E
	mov r0,#0x1	; 02327C80
	b loc_02327C86	; 02327C82
loc_02327C84:
	mov r0,#0x0	; 02327C84
loc_02327C86:
	cmp r0,#0x0	; 02327C86
	beq loc_02327C90	; 02327C88
	mov r1,#0x1	; 02327C8A
	ldr r0,[pool_02327CA8]	; 02327C8C
	strh r1,[r0,#0xa]	; 02327C8E
loc_02327C90:
	ldr r0,[pool_02327CA8]	; 02327C90
	ldrh r0,[r0,#0x8]	; 02327C92
	bl loc_0232B338	; 02327C94
	mov r1,#0x0	; 02327C98
	ldr r0,[pool_02327CA8]	; 02327C9A
	str r1,[r0,#0x0]	; 02327C9C
loc_02327C9E:
	ldr r0,[pool_02327CA8]	; 02327C9E
	ldrh r0,[r0,#0xa]	; 02327CA0
	add sp,#0x4	; 02327CA2
	pop {r3}	; 02327CA4
	bx r3	; 02327CA6
pool_02327CA8:
loc_02327CA8:
	.word P1_BssStart + 0x25740	; 02327CA8
pool_02327CAC:
loc_02327CAC:
	.word REG_ROMCTRL	; 02327CAC
pool_02327CB0:
loc_02327CB0:
	.word 0x00800000	; 02327CB0
pool_02327CB4:
loc_02327CB4:
	.word REG_GCDATAIN	; 02327CB4
pool_02327CB8:
loc_02327CB8:
	.word FirmwareBootInfoScratchAddress	; 02327CB8
pool_02327CBC:
loc_02327CBC:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327CBC

; ===== function loc_02327CC0 =====
loc_02327CC0:
	push {lr}	; 02327CC0
	sub sp,#0x4	; 02327CC2
	blx loc_0232B260	; 02327CC4
	ldr r1,[pool_02327CD8]	; 02327CC8
	strh r0,[r1,#0x8]	; 02327CCA
	ldr r0,[pool_02327CDC]	; 02327CCC
	ldr r0,[r0,#0x0]	; 02327CCE
	str r0,[r1,#0x4]	; 02327CD0
	add sp,#0x4	; 02327CD2
	pop {r3}	; 02327CD4
	bx r3	; 02327CD6
pool_02327CD8:
loc_02327CD8:
	.word P1_BssStart + 0x25740	; 02327CD8
pool_02327CDC:
loc_02327CDC:
	.word NdsCartHeaderRamAddress + 0x60	; 02327CDC
.arm
	mov r0,#0x0	; 02327CE0
	mcr p15,0x0,r0,c7,c6,0x0	; 02327CE4
	ldr r1,[pool_02327D60]	; 02327CE8
loc_02327CEC:
	ldrh r0,[r1,#0x0]	; 02327CEC
	and r0,r0,#0xf	; 02327CF0
	cmp r0,#0x2	; 02327CF4
	bne loc_02327CEC	; 02327CF8
	mov r0,#0x200	; 02327CFC
	strh r0,[r1,#0x0]	; 02327D00
	ldr r1,[pool_02327D60]	; 02327D04
loc_02327D08:
	ldrh r0,[r1,#0x0]	; 02327D08
	and r0,r0,#0xf	; 02327D0C
	cmp r0,#0x1	; 02327D10
	bne loc_02327D08	; 02327D14
	mov r0,#0x100	; 02327D18
	strh r0,[r1,#0x0]	; 02327D1C
	bl loc_02327D94	; 02327D20
	bl loc_02327D6C	; 02327D24
	ldr r1,[pool_02327D60]	; 02327D28
loc_02327D2C:
	ldrh r0,[r1,#0x0]	; 02327D2C
	and r0,r0,#0xf	; 02327D30
	cmp r0,#0x1	; 02327D34
	beq loc_02327D2C	; 02327D38
	mov r0,#0x0	; 02327D3C
	strh r0,[r1,#0x0]	; 02327D40
	ldr r3,[pool_02327D64]	; 02327D44
	ldr r12,[r3,#-0x1dc]	; 02327D48
	mov lr,r12	; 02327D4C
	ldr r11,[pool_02327D68]	; 02327D50
	ldmia r11,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10}	; 02327D54
	mov r11,#0x0	; 02327D58
	bx r12	; 02327D5C
pool_02327D60:
loc_02327D60:
	.word REG_IPC_SYNC	; 02327D60
pool_02327D64:
loc_02327D64:
; 基准为头部 RAM 视图 +0x200；负偏移实际读取 ARM9/ARM7 入口字段。
; Addressing anchor: the negative offset above reads the ARM9/ARM7 entry field.
	.word NdsCartHeaderRamAddress + 0x200	; 02327D64
pool_02327D68:
loc_02327D68:
	.word P1_DtcmRuntimeStart	; 02327D68

; ===== function loc_02327D6C =====
loc_02327D6C:
	ldr r0,[pool_02327D90]	; 02327D6C
	mcr p15,0x0,r0,c1,c0,0x0	; 02327D70
	mov r0,#0x0	; 02327D74
	mcr p15,0x0,r0,c6,c5,0x0	; 02327D78
	mov r0,#0x0	; 02327D7C
	mcr p15,0x0,r0,c7,c5,0x0	; 02327D80
	mcr p15,0x0,r0,c7,c6,0x0	; 02327D84
	mcr p15,0x0,r0,c7,c10,0x4	; 02327D88
	bx lr	; 02327D8C
pool_02327D90:
loc_02327D90:
	.word 0x00012078	; 02327D90

; ===== function loc_02327D94 =====
loc_02327D94:
	mov r12,lr	; 02327D94
	mov r0,#0xd3	; 02327D98
	msr cpsr_cxsf,r0	; 02327D9C
	ldr r0,[pool_02327E04]	; 02327DA0
	add r0,r0,#0x3fc0	; 02327DA4
	mov sp,r0	; 02327DA8
	mov lr,#0x0	; 02327DAC
	msr spsr_cxsf,lr	; 02327DB0
	mov r0,#0xd2	; 02327DB4
	msr cpsr_cxsf,r0	; 02327DB8
	ldr r0,[pool_02327E04]	; 02327DBC
	add r0,r0,#0x3fc0	; 02327DC0
	sub r0,r0,#0x40	; 02327DC4
	mov sp,r0	; 02327DC8
	mov lr,#0x0	; 02327DCC
	msr spsr_cxsf,lr	; 02327DD0
	ldr r1,[pool_02327E08]	; 02327DD4
	sub r1,r0,r1	; 02327DD8
	mov r0,#0xdf	; 02327DDC
	msr cpsr_cxsf,r0	; 02327DE0
	sub sp,r1,#0x4	; 02327DE4
	ldr r0,[pool_02327E0C]	; 02327DE8
	mov r1,#0x8000	; 02327DEC
	bl loc_02327E10	; 02327DF0
	ldr r0,[pool_02327E04]	; 02327DF4
	mov r1,#0x4000	; 02327DF8
	bl loc_02327E10	; 02327DFC
	bx r12	; 02327E00
pool_02327E04:
loc_02327E04:
	.word P1_DtcmRuntimeStart	; 02327E04
pool_02327E08:
loc_02327E08:
	.word 0x00001000	; 02327E08
pool_02327E0C:
loc_02327E0C:
	.word 0x01FF8000	; 02327E0C

; ===== function loc_02327E10 =====
loc_02327E10:
	add r2,r0,r1	; 02327E10
	mov r1,r1, lsr #0x5	; 02327E14
	mov r3,#0x0	; 02327E18
	mov r4,r3	; 02327E1C
	mov r5,r3	; 02327E20
	mov r6,r3	; 02327E24
	mov r7,r3	; 02327E28
	mov r8,r3	; 02327E2C
	mov r9,r3	; 02327E30
	mov r10,r3	; 02327E34
loc_02327E38:
	cmp r0,r2	; 02327E38
	stmltia r0!,{r3,r4,r5,r6,r7,r8,r9,r10}	; 02327E3C
	blt loc_02327E38	; 02327E40
	bx lr	; 02327E44
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 02327E4C
.thumb
P1_PxiCallback_02327E4C:
	push {r4}	; 02327E4C
	sub sp,#0x4	; 02327E4E
	mov r4,#0xff	; 02327E50
	and r1,r4	; 02327E52
	ldr r3,[pool_02327E70]	; 02327E54
	strh r1,[r3,#0x0]	; 02327E56
	mov r1,#0x1	; 02327E58
	ldr r0,[pool_02327E74]	; 02327E5A
	str r1,[r0,#0x0]	; 02327E5C
	cmp r2,#0x0	; 02327E5E
	beq loc_02327E64	; 02327E60
	strh r4,[r3,#0x0]	; 02327E62
loc_02327E64:
	ldr r0,[pool_02327E70]	; 02327E64
	ldrh r0,[r0,#0x0]	; 02327E66
	add sp,#0x4	; 02327E68
	pop {r4}	; 02327E6A
	bx lr	; 02327E6C
	.byte 0xC0, 0x46	; 02327E70
pool_02327E70:
loc_02327E70:
	.word P1_BssStart + 0x2574C	; 02327E70
pool_02327E74:
loc_02327E74:
	.word P1_BssStart + 0x25754	; 02327E74

; ===== function loc_02327E78 =====
loc_02327E78:
	push {r4,r5,r6,r7,lr}	; 02327E78
	sub sp,#0xb4	; 02327E7A
	add r6,r0,#0x0	; 02327E7C
	str r1,[sp,#0x0]	; 02327E7E
	str r2,[sp,#0x4]	; 02327E80
	str r3,[sp,#0x8]	; 02327E82
	mov r4,#0x0	; 02327E84
	lsl r0,r1,#0	; 02327E86
	lsr r0,r0,#0x10	; 02327E88
	str r0,[sp,#0x2c]	; 02327E8A
	mov r1,#0xff	; 02327E8C
	and r0,r1	; 02327E8E
	str r0,[sp,#0x2c]	; 02327E90
	ldr r1,[pool_02328198]	; 02327E92
	str r0,[sp,#0x1c]	; 02327E94
	orr r0,r1	; 02327E96
	str r0,[sp,#0x1c]	; 02327E98
	ldr r0,[pool_0232819C]	; 02327E9A
	ldr r1,[sp,#0x0]	; 02327E9C
	and r1,r0	; 02327E9E
	str r1,[sp,#0x0]	; 02327EA0
	ldr r1,[pool_023281A0]	; 02327EA2
	ldr r2,[sp,#0x0]	; 02327EA4
	orr r2,r1	; 02327EA6
	str r2,[sp,#0x0]	; 02327EA8
	ldr r2,[sp,#0x4]	; 02327EAA
	str r2,[sp,#0x20]	; 02327EAC
	and r2,r0	; 02327EAE
	str r2,[sp,#0x20]	; 02327EB0
	ldr r5,[pool_023281A4]	; 02327EB2
	orr r2,r5	; 02327EB4
	str r2,[sp,#0x20]	; 02327EB6
	lsl r2,r3,#0	; 02327EB8
	lsr r2,r2,#0x10	; 02327EBA
	str r2,[sp,#0x30]	; 02327EBC
	ldr r3,[pool_023281A8]	; 02327EBE
	str r2,[sp,#0x24]	; 02327EC0
	orr r2,r3	; 02327EC2
	str r2,[sp,#0x24]	; 02327EC4
	ldr r2,[sp,#0x8]	; 02327EC6
	and r2,r0	; 02327EC8
	str r2,[sp,#0x8]	; 02327ECA
	ldr r3,[pool_023281AC]	; 02327ECC
	str r2,[sp,#0x28]	; 02327ECE
	orr r2,r3	; 02327ED0
	str r2,[sp,#0x28]	; 02327ED2
	ldr r3,[pool_023281B0]	; 02327ED4
	ldr r2,[sp,#0x2c]	; 02327ED6
	orr r2,r3	; 02327ED8
	str r2,[sp,#0x2c]	; 02327EDA
	ldr r3,[sp,#0x4]	; 02327EDC
	ldr r2,[pool_023281B4]	; 02327EDE
	orr r3,r2	; 02327EE0
	str r3,[sp,#0x4]	; 02327EE2
	ldr r2,[sp,#0x30]	; 02327EE4
	orr r2,r5	; 02327EE6
	str r2,[sp,#0x30]	; 02327EE8
	ldr r3,[pool_023281B8]	; 02327EEA
	ldr r2,[sp,#0x8]	; 02327EEC
	orr r2,r3	; 02327EEE
	str r2,[sp,#0x8]	; 02327EF0
	ldr r2,[pool_023281BC]	; 02327EF2
	lsr r2,r2,#0x18	; 02327EF4
	str r2,[sp,#0x34]	; 02327EF6
	ldr r3,[pool_023281C0]	; 02327EF8
	orr r2,r3	; 02327EFA
	str r2,[sp,#0x34]	; 02327EFC
	ldr r2,[pool_023281BC]	; 02327EFE
	lsr r2,r2,#0x8	; 02327F00
	str r2,[sp,#0x38]	; 02327F02
	and r2,r0	; 02327F04
	str r2,[sp,#0x38]	; 02327F06
	orr r2,r1	; 02327F08
	str r2,[sp,#0x38]	; 02327F0A
	ldr r0,[pool_023281BC]	; 02327F0C
	lsl r0,r0,#0x8	; 02327F0E
	str r0,[sp,#0x3c]	; 02327F10
	ldr r1,[pool_023281C4]	; 02327F12
	and r0,r1	; 02327F14
	str r0,[sp,#0x3c]	; 02327F16
	ldr r1,[pool_023281C8]	; 02327F18
	orr r0,r1	; 02327F1A
	str r0,[sp,#0x3c]	; 02327F1C
	str r4,[sp,#0xb0]	; 02327F1E
	str r4,[sp,#0xac]	; 02327F20
	mov r5,#0x4	; 02327F22
	str r4,[sp,#0xa8]	; 02327F24
	str r4,[sp,#0x98]	; 02327F26
	str r4,[sp,#0xa0]	; 02327F28
	str r4,[sp,#0xa4]	; 02327F2A
	str r4,[sp,#0x9c]	; 02327F2C
	str r4,[sp,#0x94]	; 02327F2E
	str r4,[sp,#0x74]	; 02327F30
	str r4,[sp,#0x7c]	; 02327F32
	str r4,[sp,#0x84]	; 02327F34
	str r4,[sp,#0x8c]	; 02327F36
	str r4,[sp,#0x90]	; 02327F38
	str r4,[sp,#0x88]	; 02327F3A
	str r4,[sp,#0x80]	; 02327F3C
	str r4,[sp,#0x78]	; 02327F3E
	str r4,[sp,#0x70]	; 02327F40
	str r4,[sp,#0x6c]	; 02327F42
	str r4,[sp,#0x44]	; 02327F44
	str r4,[sp,#0x4c]	; 02327F46
	str r4,[sp,#0x54]	; 02327F48
	str r4,[sp,#0x5c]	; 02327F4A
	str r4,[sp,#0x64]	; 02327F4C
	str r4,[sp,#0x68]	; 02327F4E
	str r4,[sp,#0x60]	; 02327F50
	str r4,[sp,#0x58]	; 02327F52
	str r4,[sp,#0x50]	; 02327F54
	str r4,[sp,#0x48]	; 02327F56
	str r4,[sp,#0x40]	; 02327F58
	add r7,r4,#0x0	; 02327F5A
loc_02327F5C:
	cmp r4,#0x0	; 02327F5C
	beq loc_02327F62	; 02327F5E
	b loc_023280C2	; 02327F60
loc_02327F62:
	ldr r0,[pool_023281CC]	; 02327F62
	str r7,[r0,#0x0]	; 02327F64
	cmp r6,#0x6	; 02327F66
	bhi loc_02327F5C	; 02327F68
	add r0,r6,r6	; 02327F6A
P1_SwitchIndexPC_02327F6A:
	add r0,pc	; 02327F6C
	ldrh r0,[r0,#(P1_SwitchTable_02327F6A - (P1_SwitchIndexPC_02327F6A + 4))]	; 02327F6E
	lsl r0,r0,#0x10	; 02327F70
	asr r0,r0,#0x10	; 02327F72
P1_SwitchTargetPC_02327F6A:
	add r0,pc	; 02327F74
	bx r0	; 02327F76
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_02327F6A:
	.halfword (loc_02327F5C + 1) - (P1_SwitchTargetPC_02327F6A + 4)
	.halfword (loc_02327F86 + 1) - (P1_SwitchTargetPC_02327F6A + 4)
	.halfword (loc_02327FF6 + 1) - (P1_SwitchTargetPC_02327F6A + 4)
	.halfword (loc_0232800C + 1) - (P1_SwitchTargetPC_02327F6A + 4)
	.halfword (loc_02328072 + 1) - (P1_SwitchTargetPC_02327F6A + 4)
	.halfword (loc_02328072 + 1) - (P1_SwitchTargetPC_02327F6A + 4)
	.halfword (loc_023280AC + 1) - (P1_SwitchTargetPC_02327F6A + 4)
P1_SwitchTable_02327F6AEnd:
loc_02327F86:
	add r0,r5,#0x0	; 02327F86
	ldr r1,[sp,#0x1c]	; 02327F88
	add r2,r7,#0x0	; 02327F8A
	bl loc_0232E8B4	; 02327F8C
	cmp r0,#0x0	; 02327F90
	bge loc_02327F98	; 02327F92
	ldr r4,[sp,#0x40]	; 02327F94
	b loc_02327F5C	; 02327F96
loc_02327F98:
	add r0,r5,#0x0	; 02327F98
	ldr r1,[sp,#0x0]	; 02327F9A
	ldr r2,[sp,#0x44]	; 02327F9C
	bl loc_0232E8B4	; 02327F9E
	cmp r0,#0x0	; 02327FA2
	bge loc_02327FAA	; 02327FA4
	ldr r4,[sp,#0x48]	; 02327FA6
	b loc_02327F5C	; 02327FA8
loc_02327FAA:
	add r0,r5,#0x0	; 02327FAA
	ldr r1,[pool_023281B4]	; 02327FAC
	ldr r2,[sp,#0x4c]	; 02327FAE
	bl loc_0232E8B4	; 02327FB0
	cmp r0,#0x0	; 02327FB4
	bge loc_02327FBC	; 02327FB6
	ldr r4,[sp,#0x50]	; 02327FB8
	b loc_02327F5C	; 02327FBA
loc_02327FBC:
	add r0,r5,#0x0	; 02327FBC
	ldr r1,[sp,#0x20]	; 02327FBE
	ldr r2,[sp,#0x54]	; 02327FC0
	bl loc_0232E8B4	; 02327FC2
	cmp r0,#0x0	; 02327FC6
	bge loc_02327FCE	; 02327FC8
	ldr r4,[sp,#0x58]	; 02327FCA
	b loc_02327F5C	; 02327FCC
loc_02327FCE:
	add r0,r5,#0x0	; 02327FCE
	ldr r1,[sp,#0x24]	; 02327FD0
	ldr r2,[sp,#0x5c]	; 02327FD2
	bl loc_0232E8B4	; 02327FD4
	cmp r0,#0x0	; 02327FD8
	bge loc_02327FE0	; 02327FDA
	ldr r4,[sp,#0x60]	; 02327FDC
	b loc_02327F5C	; 02327FDE
loc_02327FE0:
	add r0,r5,#0x0	; 02327FE0
	ldr r1,[sp,#0x28]	; 02327FE2
	ldr r2,[sp,#0x64]	; 02327FE4
	bl loc_0232E8B4	; 02327FE6
	cmp r0,#0x0	; 02327FEA
	bge loc_02327FF2	; 02327FEC
	ldr r4,[sp,#0x68]	; 02327FEE
	b loc_02327F5C	; 02327FF0
loc_02327FF2:
	mov r4,#0x1	; 02327FF2
	b loc_02327F5C	; 02327FF4
loc_02327FF6:
	add r0,r5,#0x0	; 02327FF6
	ldr r1,[pool_023281D0]	; 02327FF8
	add r2,r7,#0x0	; 02327FFA
	bl loc_0232E8B4	; 02327FFC
	cmp r0,#0x0	; 02328000
	blt loc_02328008	; 02328002
	mov r4,#0x1	; 02328004
	b loc_02327F5C	; 02328006
loc_02328008:
	ldr r4,[sp,#0x6c]	; 02328008
	b loc_02327F5C	; 0232800A
loc_0232800C:
	add r0,r5,#0x0	; 0232800C
	ldr r1,[sp,#0x2c]	; 0232800E
	add r2,r7,#0x0	; 02328010
	bl loc_0232E8B4	; 02328012
	cmp r0,#0x0	; 02328016
	bge loc_0232801E	; 02328018
	ldr r4,[sp,#0x70]	; 0232801A
	b loc_02328068	; 0232801C
loc_0232801E:
	add r0,r5,#0x0	; 0232801E
	ldr r1,[sp,#0x0]	; 02328020
	ldr r2,[sp,#0x74]	; 02328022
	bl loc_0232E8B4	; 02328024
	cmp r0,#0x0	; 02328028
	bge loc_02328030	; 0232802A
	ldr r4,[sp,#0x78]	; 0232802C
	b loc_02328068	; 0232802E
loc_02328030:
	add r0,r5,#0x0	; 02328030
	ldr r1,[sp,#0x4]	; 02328032
	ldr r2,[sp,#0x7c]	; 02328034
	bl loc_0232E8B4	; 02328036
	cmp r0,#0x0	; 0232803A
	bge loc_02328042	; 0232803C
	ldr r4,[sp,#0x80]	; 0232803E
	b loc_02328068	; 02328040
loc_02328042:
	add r0,r5,#0x0	; 02328042
	ldr r1,[sp,#0x30]	; 02328044
	ldr r2,[sp,#0x84]	; 02328046
	bl loc_0232E8B4	; 02328048
	cmp r0,#0x0	; 0232804C
	bge loc_02328054	; 0232804E
	ldr r4,[sp,#0x88]	; 02328050
	b loc_02328068	; 02328052
loc_02328054:
	add r0,r5,#0x0	; 02328054
	ldr r1,[sp,#0x8]	; 02328056
	ldr r2,[sp,#0x8c]	; 02328058
	bl loc_0232E8B4	; 0232805A
	cmp r0,#0x0	; 0232805E
	bge loc_02328066	; 02328060
	ldr r4,[sp,#0x90]	; 02328062
	b loc_02328068	; 02328064
loc_02328066:
	mov r4,#0x1	; 02328066
loc_02328068:
	bl loc_0232BFF0	; 02328068
	str r0,[sp,#0x14]	; 0232806C
	str r1,[sp,#0x10]	; 0232806E
	b loc_02327F5C	; 02328070
loc_02328072:
	add r0,r5,#0x0	; 02328072
	ldr r1,[sp,#0x34]	; 02328074
	add r2,r7,#0x0	; 02328076
	bl loc_0232E8B4	; 02328078
	cmp r0,#0x0	; 0232807C
	bge loc_02328084	; 0232807E
	ldr r4,[sp,#0x94]	; 02328080
	b loc_02327F5C	; 02328082
loc_02328084:
	add r0,r5,#0x0	; 02328084
	ldr r1,[sp,#0x38]	; 02328086
	ldr r2,[sp,#0x98]	; 02328088
	bl loc_0232E8B4	; 0232808A
	cmp r0,#0x0	; 0232808E
	bge loc_02328096	; 02328090
	ldr r4,[sp,#0x9c]	; 02328092
	b loc_02327F5C	; 02328094
loc_02328096:
	add r0,r5,#0x0	; 02328096
	ldr r1,[sp,#0x3c]	; 02328098
	ldr r2,[sp,#0xa0]	; 0232809A
	bl loc_0232E8B4	; 0232809C
	cmp r0,#0x0	; 023280A0
	bge loc_023280A8	; 023280A2
	ldr r4,[sp,#0xa4]	; 023280A4
	b loc_02327F5C	; 023280A6
loc_023280A8:
	mov r4,#0x1	; 023280A8
	b loc_02327F5C	; 023280AA
loc_023280AC:
	add r0,r5,#0x0	; 023280AC
	ldr r1,[pool_023281D4]	; 023280AE
	add r2,r7,#0x0	; 023280B0
	bl loc_0232E8B4	; 023280B2
	cmp r0,#0x0	; 023280B6
	blt loc_023280BE	; 023280B8
	mov r4,#0x1	; 023280BA
	b loc_02327F5C	; 023280BC
loc_023280BE:
	ldr r4,[sp,#0xa8]	; 023280BE
	b loc_02327F5C	; 023280C0
loc_023280C2:
	ldr r0,[pool_023281CC]	; 023280C2
	ldr r0,[r0,#0x0]	; 023280C4
	cmp r0,#0x1	; 023280C6
	beq loc_023280CC	; 023280C8
	b loc_02327F5C	; 023280CA
loc_023280CC:
	ldr r4,[sp,#0xac]	; 023280CC
	ldr r0,[pool_023281D8]	; 023280CE
	ldrh r0,[r0,#0x0]	; 023280D0
	cmp r0,#0x0	; 023280D2
	bne loc_0232818C	; 023280D4
	cmp r6,#0x6	; 023280D6
	bls loc_023280DC	; 023280D8
	b loc_02327F5C	; 023280DA
loc_023280DC:
	add r0,r6,r6	; 023280DC
P1_SwitchIndexPC_023280DC:
	add r0,pc	; 023280DE
	ldrh r0,[r0,#(P1_SwitchTable_023280DC - (P1_SwitchIndexPC_023280DC + 4))]	; 023280E0
	lsl r0,r0,#0x10	; 023280E2
	asr r0,r0,#0x10	; 023280E4
P1_SwitchTargetPC_023280DC:
	add r0,pc	; 023280E6
	bx r0	; 023280E8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_023280DC:
	.halfword (loc_02327F5C + 1) - (P1_SwitchTargetPC_023280DC + 4)
	.halfword (loc_023280F8 + 1) - (P1_SwitchTargetPC_023280DC + 4)
	.halfword (loc_02328102 + 1) - (P1_SwitchTargetPC_023280DC + 4)
	.halfword (loc_02328106 + 1) - (P1_SwitchTargetPC_023280DC + 4)
	.halfword (loc_0232810A + 1) - (P1_SwitchTargetPC_023280DC + 4)
	.halfword (loc_0232810A + 1) - (P1_SwitchTargetPC_023280DC + 4)
	.halfword (loc_02328182 + 1) - (P1_SwitchTargetPC_023280DC + 4)
P1_SwitchTable_023280DCEnd:
loc_023280F8:
	mov r0,#0x1	; 023280F8
	add sp,#0xb4	; 023280FA
	pop {r4,r5,r6,r7}	; 023280FC
	pop {r3}	; 023280FE
	bx r3	; 02328100
loc_02328102:
	add r6,r5,#0x0	; 02328102
	b loc_02327F5C	; 02328104
loc_02328106:
	mov r6,#0x5	; 02328106
	b loc_02327F5C	; 02328108
loc_0232810A:
	ldr r0,[pool_023281BC]	; 0232810A
	mov r1,#0x1	; 0232810C
	blx P1_InvalidateDataCacheRange	; 0232810E
	cmp r6,#0x4	; 02328112
	bne loc_02328130	; 02328114
	ldr r0,[pool_023281BC]	; 02328116
	ldrb r1,[r0,#0x0]	; 02328118
	mov r0,#0x2	; 0232811A
	and r1,r0	; 0232811C
	cmp r1,#0x0	; 0232811E
	beq loc_02328126	; 02328120
	mov r6,#0x3	; 02328122
	b loc_02327F5C	; 02328124
loc_02328126:
	mov r0,#0x0	; 02328126
	add sp,#0xb4	; 02328128
	pop {r4,r5,r6,r7}	; 0232812A
	pop {r3}	; 0232812C
	bx r3	; 0232812E
loc_02328130:
	ldr r0,[pool_023281BC]	; 02328130
	ldrb r1,[r0,#0x0]	; 02328132
	add r2,r1,#0x0	; 02328134
	mov r0,#0x1	; 02328136
	and r2,r0	; 02328138
	cmp r2,#0x0	; 0232813A
	beq loc_0232818E	; 0232813C
	mov r0,#0x20	; 0232813E
	and r1,r0	; 02328140
	cmp r1,#0x0	; 02328142
	bne loc_02328176	; 02328144
	bl loc_0232BFF0	; 02328146
	add r3,r0,#0x0	; 0232814A
	add r2,r1,#0x0	; 0232814C
	ldr r0,[sp,#0x14]	; 0232814E
	sub r1,r3,r0	; 02328150
	ldr r0,[sp,#0x10]	; 02328152
	sbc r2,r0	; 02328154
	lsr r0,r1,#0x1a	; 02328156
	lsl r2,r2,#0x6	; 02328158
	orr r2,r0	; 0232815A
	lsl r0,r1,#0x6	; 0232815C
	add r1,r2,#0x0	; 0232815E
	ldr r2,[pool_023281DC]	; 02328160
	ldr r3,[sp,#0xb0]	; 02328162
	blx loc_0232CB00	; 02328164
	add r3,r0,#0x0	; 02328168
	add r2,r1,#0x0	; 0232816A
	mov r1,#0x0	; 0232816C
	ldr r0,[pool_023281E0]	; 0232816E
	sub r0,r0,r3	; 02328170
	sbc r1,r2	; 02328172
	bcs loc_0232817A	; 02328174
loc_02328176:
	mov r6,#0x6	; 02328176
	b loc_02327F5C	; 02328178
loc_0232817A:
	ldr r0,[pool_023281E4]	; 0232817A
	bl P1_SwiWaitByLoop	; 0232817C
	b loc_02327F5C	; 02328180
loc_02328182:
	lsl r0,r4,#0	; 02328182
	add sp,#0xb4	; 02328184
	pop {r4,r5,r6,r7}	; 02328186
	pop {r3}	; 02328188
	bx r3	; 0232818A
loc_0232818C:
	lsl r0,r4,#0	; 0232818C
loc_0232818E:
	add sp,#0xb4	; 0232818E
	pop {r4,r5,r6,r7}	; 02328190
	pop {r3}	; 02328192
	bx r3	; 02328194
	.byte 0xC0, 0x46	; 02328198
pool_02328198:
loc_02328198:
	.word 0x02002300	; 02328198
pool_0232819C:
loc_0232819C:
	.word 0x0000FFFF	; 0232819C
pool_023281A0:
loc_023281A0:
	.word 0x00010000	; 023281A0
pool_023281A4:
loc_023281A4:
	.word 0x00030000	; 023281A4
pool_023281A8:
loc_023281A8:
	.word 0x00040000	; 023281A8
pool_023281AC:
loc_023281AC:
	.word 0x01050000	; 023281AC
pool_023281B0:
loc_023281B0:
	.word 0x02002500	; 023281B0
pool_023281B4:
loc_023281B4:
	.word 0x00020000	; 023281B4
pool_023281B8:
loc_023281B8:
	.word 0x01040000	; 023281B8
pool_023281BC:
loc_023281BC:
	.word P1_BssStart + 0x257E0	; 023281BC
pool_023281C0:
loc_023281C0:
	.word 0x02002200	; 023281C0
pool_023281C4:
loc_023281C4:
	.word 0x0000FF00	; 023281C4
pool_023281C8:
loc_023281C8:
	.word 0x01020000	; 023281C8
pool_023281CC:
loc_023281CC:
	.word P1_BssStart + 0x25754	; 023281CC
pool_023281D0:
loc_023281D0:
	.word 0x03002000	; 023281D0
pool_023281D4:
loc_023281D4:
	.word 0x03002D00	; 023281D4
pool_023281D8:
loc_023281D8:
	.word P1_BssStart + 0x2574C	; 023281D8
pool_023281DC:
loc_023281DC:
	.word 0x000082EA	; 023281DC
pool_023281E0:
loc_023281E0:
	.word 0x00000FA0	; 023281E0
pool_023281E4:
loc_023281E4:
	.word 0x00004000	; 023281E4

; ===== function loc_023281E8 =====
loc_023281E8:
; 检查副本并按更新计数选择；返回 0 成功，1 表示两份均无效。
; Validate/select by update counter; return 0 on success, 1 if neither copy is valid.
.func P1_SelectValidUserSettingsCopy
	push {r4,r5,r6,r7,lr}	; 023281E8
	sub sp,#0x4	; 023281EA
	add r7,r0,#0x0	; 023281EC
	mov r6,#0x0	; 023281EE
	add r5,r6,#0x0	; 023281F0
loc_023281F2:
	lsl r0,r5,#0x7	; 023281F2
	add r4,r7,r0	; 023281F4
	ldr r0,[pool_023282A0]	; 023281F6
	add r1,r4,#0x0	; 023281F8
	mov r2,#0x70	; 023281FA
	bl P1_SwiGetCrc16	; 023281FC
	add r1,r4,#0x0	; 02328200
	add r1,#0x72	; 02328202
	ldrh r1,[r1,#0x0]	; 02328204
	cmp r0,r1	; 02328206
	bne loc_0232822E	; 02328208
	add r0,r4,#0x0	; 0232820A
	add r0,#0x70	; 0232820C
	ldrh r0,[r0,#0x0]	; 0232820E
	cmp r0,#0x80	; 02328210
	bcs loc_0232822E	; 02328212
	ldrb r0,[r4,#0x0]	; 02328214
	cmp r0,#0x5	; 02328216
	bne loc_0232822E	; 02328218
	add r0,r4,#0x0	; 0232821A
	bl loc_0232835C	; 0232821C
	cmp r0,#0x0	; 02328220
	beq loc_0232822E	; 02328222
	mov r0,#0x1	; 02328224
	lsl r0,r5	; 02328226
	orr r6,r0	; 02328228
	lsl r0,r6,#0x10	; 0232822A
	lsr r6,r0,#0x10	; 0232822C
loc_0232822E:
	add r0,r5,#0x1	; 0232822E
	lsl r0,r0,#0x10	; 02328230
	lsr r5,r0,#0x10	; 02328232
	cmp r5,#0x2	; 02328234
	bcc loc_023281F2	; 02328236
	cmp r6,#0x3	; 02328238
	bne loc_02328264	; 0232823A
	add r0,r7,#0x0	; 0232823C
	add r0,#0x70	; 0232823E
	ldrh r0,[r0,#0x0]	; 02328240
	add r1,r0,#0x1	; 02328242
	mov r0,#0x7f	; 02328244
	and r1,r0	; 02328246
	lsl r0,r1,#0x18	; 02328248
	lsr r1,r0,#0x18	; 0232824A
	add r7,#0xf0	; 0232824C
	ldrh r0,[r7,#0x0]	; 0232824E
	cmp r1,r0	; 02328250
	bne loc_0232825C	; 02328252
	mov r1,#0x1	; 02328254
	ldr r0,[pool_023282A4]	; 02328256
	strh r1,[r0,#0x0]	; 02328258
	b loc_02328294	; 0232825A
loc_0232825C:
	mov r1,#0x0	; 0232825C
	ldr r0,[pool_023282A4]	; 0232825E
	strh r1,[r0,#0x0]	; 02328260
	b loc_02328294	; 02328262
loc_02328264:
	cmp r6,#0x0	; 02328264
	beq loc_0232828A	; 02328266
	mov r1,#0x0	; 02328268
	ldr r0,[pool_023282A4]	; 0232826A
	strh r1,[r0,#0x0]	; 0232826C
	mov r2,#0x1	; 0232826E
loc_02328270:
	ldrh r1,[r0,#0x0]	; 02328270
	add r3,r2,#0x0	; 02328272
	lsl r3,r1	; 02328274
	add r4,r6,#0x0	; 02328276
	and r4,r3	; 02328278
	cmp r4,#0x0	; 0232827A
	bne loc_02328294	; 0232827C
	add r1,r1,#0x1	; 0232827E
	strh r1,[r0,#0x0]	; 02328280
	ldrh r1,[r0,#0x0]	; 02328282
	cmp r1,#0x2	; 02328284
	bcc loc_02328270	; 02328286
	b loc_02328294	; 02328288
loc_0232828A:
	mov r0,#0x1	; 0232828A
	add sp,#0x4	; 0232828C
	pop {r4,r5,r6,r7}	; 0232828E
	pop {r3}	; 02328290
	bx r3	; 02328292
loc_02328294:
	mov r0,#0x0	; 02328294
	add sp,#0x4	; 02328296
	pop {r4,r5,r6,r7}	; 02328298
	pop {r3}	; 0232829A
	bx r3	; 0232829C
.endfunc
	.byte 0xC0, 0x46	; 023282A0
pool_023282A0:
loc_023282A0:
	.word 0x0000FFFF	; 023282A0
pool_023282A4:
loc_023282A4:
	.word P1_Data_02330950	; 023282A4

; ===== function loc_023282A8 =====
loc_023282A8:
	push {r4,r5,r6,r7,lr}	; 023282A8
	sub sp,#0x4	; 023282AA
	add r4,r0,#0x0	; 023282AC
	ldr r0,[pool_02328344]	; 023282AE
	ldrh r0,[r0,#0x0]	; 023282B0
	cmp r0,#0xff	; 023282B2
	bne loc_023282C6	; 023282B4
	mov r0,#0x0	; 023282B6
	bl P1_LoadAndSelectUserSettings	; 023282B8
	cmp r0,#0x0	; 023282BC
	beq loc_023282C6	; 023282BE
	mov r1,#0x0	; 023282C0
	ldr r0,[pool_02328344]	; 023282C2
	strh r1,[r0,#0x0]	; 023282C4
loc_023282C6:
	mov r0,#0x5	; 023282C6
	strb r0,[r4,#0x0]	; 023282C8
	ldr r3,[pool_02328348]	; 023282CA
	mov r2,#0xe	; 023282CC
loc_023282CE:
	ldmia r4!,{r0,r1}	; 023282CE
	stmia r3!,{r0,r1}	; 023282D0
	sub r2,r2,#0x1	; 023282D2
	cmp r2,#0x0	; 023282D4
	bne loc_023282CE	; 023282D6
	ldr r0,[pool_0232834C]	; 023282D8
	ldr r1,[pool_02328348]	; 023282DA
	mov r2,#0x70	; 023282DC
	bl P1_SwiGetCrc16	; 023282DE
	ldr r1,[pool_02328348]	; 023282E2
	add r1,#0x72	; 023282E4
	strh r0,[r1,#0x0]	; 023282E6
	ldr r1,[pool_02328350]	; 023282E8
	ldrh r2,[r1,#0x0]	; 023282EA
	ldr r0,[pool_02328348]	; 023282EC
	add r0,#0x70	; 023282EE
	strh r2,[r0,#0x0]	; 023282F0
	ldrh r0,[r1,#0x0]	; 023282F2
	add r2,r0,#0x1	; 023282F4
	mov r0,#0x7f	; 023282F6
	and r2,r0	; 023282F8
	lsl r0,r2,#0x18	; 023282FA
	lsr r0,r0,#0x18	; 023282FC
	strh r0,[r1,#0x0]	; 023282FE
	ldr r0,[pool_02328348]	; 02328300
	mov r1,#0x80	; 02328302
	blx P1_CleanAndInvalidateDataCacheRange	; 02328304
	mov r0,#0x8	; 02328308
	sub r5,r0,#0x1	; 0232830A
	ldr r4,[pool_02328344]	; 0232830C
	ldr r6,[pool_02328354]	; 0232830E
	mov r7,#0x1	; 02328310
loc_02328312:
	ldrh r0,[r4,#0x0]	; 02328312
	eor r0,r7	; 02328314
	strh r0,[r4,#0x0]	; 02328316
	mov r0,#0x2	; 02328318
	ldr r1,[r6,#0x0]	; 0232831A
	ldrh r2,[r4,#0x0]	; 0232831C
	lsl r2,r2,#0x8	; 0232831E
	add r1,r1,r2	; 02328320
	mov r2,#0x80	; 02328322
	ldr r3,[pool_02328348]	; 02328324
	bl loc_02327E78	; 02328326
	cmp r0,#0x0	; 0232832A
	bne loc_0232833C	; 0232832C
	ldr r0,[pool_02328358]	; 0232832E
	bl P1_SwiWaitByLoop	; 02328330
	add r0,r5,#0x0	; 02328334
	sub r5,r5,#0x1	; 02328336
	cmp r0,#0x0	; 02328338
	bne loc_02328312	; 0232833A
loc_0232833C:
	add sp,#0x4	; 0232833C
	pop {r4,r5,r6,r7}	; 0232833E
	pop {r3}	; 02328340
	bx r3	; 02328342
pool_02328344:
loc_02328344:
	.word P1_Data_02330950	; 02328344
pool_02328348:
loc_02328348:
	.word P1_BssStart + 0x25760	; 02328348
pool_0232834C:
loc_0232834C:
	.word 0x0000FFFF	; 0232834C
pool_02328350:
loc_02328350:
	.word P1_BssStart + 0x25750	; 02328350
pool_02328354:
loc_02328354:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 02328354
pool_02328358:
loc_02328358:
	.word 0x00004000	; 02328358

; ===== function loc_0232835C =====
loc_0232835C:
	add r1,r0,#0x0	; 0232835C
	add r1,#0x64	; 0232835E
	ldrh r1,[r1,#0x0]	; 02328360
	lsl r2,r1,#0x12	; 02328362
	lsr r2,r2,#0x1f	; 02328364
	cmp r2,#0x0	; 02328366
	beq loc_02328376	; 02328368
	lsl r1,r1,#0x1d	; 0232836A
	lsr r1,r1,#0x1d	; 0232836C
	cmp r1,#0x6	; 0232836E
	bcc loc_02328376	; 02328370
	mov r0,#0x0	; 02328372
	bx lr	; 02328374
loc_02328376:
	add r1,r0,#0x0	; 02328376
	add r1,#0x64	; 02328378
	ldrh r1,[r1,#0x0]	; 0232837A
	lsl r1,r1,#0x15	; 0232837C
	lsr r1,r1,#0x1f	; 0232837E
	cmp r1,#0x0	; 02328380
	beq loc_02328394	; 02328382
	ldrb r1,[r0,#0x3]	; 02328384
	cmp r1,#0xc	; 02328386
	bhi loc_02328390	; 02328388
	ldrb r1,[r0,#0x4]	; 0232838A
	cmp r1,#0x1f	; 0232838C
	bls loc_02328394	; 0232838E
loc_02328390:
	mov r0,#0x0	; 02328390
	bx lr	; 02328392
loc_02328394:
	add r1,r0,#0x0	; 02328394
	add r1,#0x64	; 02328396
	ldrh r1,[r1,#0x0]	; 02328398
	lsl r1,r1,#0x10	; 0232839A
	lsr r1,r1,#0x1f	; 0232839C
	cmp r1,#0x0	; 0232839E
	beq loc_023283AC	; 023283A0
	ldrb r1,[r0,#0x1a]	; 023283A2
	cmp r1,#0xa	; 023283A4
	bls loc_023283AC	; 023283A6
	mov r0,#0x0	; 023283A8
	bx lr	; 023283AA
loc_023283AC:
	add r1,r0,#0x0	; 023283AC
	add r1,#0x50	; 023283AE
	ldrb r1,[r1,#0x0]	; 023283B0
	cmp r1,#0x1a	; 023283B2
	bls loc_023283BA	; 023283B4
	mov r0,#0x0	; 023283B6
	bx lr	; 023283B8
loc_023283BA:
	add r1,r0,#0x0	; 023283BA
	add r1,#0x52	; 023283BC
	ldrb r1,[r1,#0x0]	; 023283BE
	cmp r1,#0x17	; 023283C0
	bhi loc_023283CC	; 023283C2
	add r0,#0x53	; 023283C4
	ldrb r0,[r0,#0x0]	; 023283C6
	cmp r0,#0x3b	; 023283C8
	bls loc_023283D0	; 023283CA
loc_023283CC:
	mov r0,#0x0	; 023283CC
	bx lr	; 023283CE
loc_023283D0:
	mov r0,#0x1	; 023283D0
	bx lr	; 023283D2

; ===== function loc_023283D4 =====
loc_023283D4:
; 读取两份用户设置并选用有效副本；返回 1 表示无可用副本。
; Read both settings copies and select one; return 1 when neither is usable.
.func P1_LoadAndSelectUserSettings
	push {r4,r5,r6,r7,lr}	; 023283D4
	sub sp,#0xc	; 023283D6
	str r0,[sp,#0x0]	; 023283D8
	mov r0,#0x0	; 023283DA
	str r0,[sp,#0x4]	; 023283DC
	ldr r5,[pool_02328468]	; 023283DE
	mov r0,#0x4	; 023283E0
	ldr r1,[pool_0232846C]	; 023283E2
	bl P1_SetPxiReceiveCallback	; 023283E4
	mov r6,#0x1	; 023283E8
	ldr r4,[pool_02328470]	; 023283EA
	mov r7,#0x80	; 023283EC
loc_023283EE:
	add r0,r6,#0x0	; 023283EE
	ldr r1,[r4,#0x0]	; 023283F0
	add r2,r7,#0x0	; 023283F2
	add r3,r5,#0x0	; 023283F4
	bl loc_02327E78	; 023283F6
	cmp r0,#0x0	; 023283FA
	beq loc_023283EE	; 023283FC
	mov r7,#0x1	; 023283FE
	ldr r4,[pool_02328470]	; 02328400
	ldr r6,[pool_02328474]	; 02328402
loc_02328404:
	add r0,r7,#0x0	; 02328404
	ldr r1,[r4,#0x0]	; 02328406
	add r1,r1,r6	; 02328408
	mov r2,#0x80	; 0232840A
	add r3,r5,#0x0	; 0232840C
	add r3,#0x80	; 0232840E
	bl loc_02327E78	; 02328410
	cmp r0,#0x0	; 02328414
	beq loc_02328404	; 02328416
	add r0,r5,#0x0	; 02328418
	ldr r1,[pool_02328474]	; 0232841A
	blx P1_InvalidateDataCacheRange	; 0232841C
	add r0,r5,#0x0	; 02328420
	bl P1_SelectValidUserSettingsCopy	; 02328422
	cmp r0,#0x0	; 02328426
	beq loc_02328434	; 02328428
	mov r0,#0x1	; 0232842A
	str r0,[sp,#0x4]	; 0232842C
	ldr r1,[pool_02328478]	; 0232842E
	strh r0,[r1,#0x0]	; 02328430
	b loc_0232845C	; 02328432
loc_02328434:
	ldr r0,[pool_0232847C]	; 02328434
	ldrh r0,[r0,#0x0]	; 02328436
	lsl r0,r0,#0x7	; 02328438
	add r0,r5,r0	; 0232843A
	add r1,r0,#0x0	; 0232843C
	add r1,#0x70	; 0232843E
	ldrh r1,[r1,#0x0]	; 02328440
	add r2,r1,#0x1	; 02328442
	mov r1,#0x7f	; 02328444
	and r2,r1	; 02328446
	lsl r1,r2,#0x18	; 02328448
	lsr r2,r1,#0x18	; 0232844A
	ldr r1,[pool_02328478]	; 0232844C
	strh r2,[r1,#0x0]	; 0232844E
	ldr r1,[sp,#0x0]	; 02328450
	cmp r1,#0x0	; 02328452
	beq loc_0232845C	; 02328454
	mov r2,#0x38	; 02328456
	bl loc_0232C7C6	; 02328458
loc_0232845C:
	ldr r0,[sp,#0x4]	; 0232845C
	add sp,#0xc	; 0232845E
	pop {r4,r5,r6,r7}	; 02328460
	pop {r3}	; 02328462
	bx r3	; 02328464
.endfunc
	.byte 0xC0, 0x46	; 02328468
pool_02328468:
loc_02328468:
	.word 0x02356220	; 02328468
pool_0232846C:
loc_0232846C:
	.word P1_PxiCallback_02327E4C + 1	; 0232846C
pool_02328470:
loc_02328470:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 02328470
pool_02328474:
loc_02328474:
	.word 0x00000100	; 02328474
pool_02328478:
loc_02328478:
	.word P1_BssStart + 0x25750	; 02328478
pool_0232847C:
loc_0232847C:
	.word P1_Data_02330950	; 0232847C

; ===== function loc_02328480 =====
loc_02328480:
	push {r4,r5}	; 02328480
	mov r4,#0x3	; 02328482
	mov r3,#0x0	; 02328484
loc_02328486:
	ldrb r2,[r0,#0x0]	; 02328486
	ror r3,r4	; 02328488
	mov r5,#0x4	; 0232848A
loc_0232848C:
	eor r3,r2	; 0232848C
	lsl r2,r2,#0x8	; 0232848E
	sub r5,#0x1	; 02328490
	bgt loc_0232848C	; 02328492
	add r0,#0x1	; 02328494
	sub r1,#0x1	; 02328496
	bgt loc_02328486	; 02328498
	add r0,r3,#0x0	; 0232849A
	lsl r0,r0,#0x1b	; 0232849C
	lsr r0,r0,#0x1e	; 0232849E
	pop {r4,r5}	; 023284A0
	bx lr	; 023284A2

; ===== function loc_023284A4 =====
loc_023284A4:
	add r2,r0,#0x0	; 023284A4
	mov r0,#0x14	; 023284A6
	mul r1,r0	; 023284A8
	ldr r0,[pool_023284B8]	; 023284AA
	add r0,r1,r0	; 023284AC
	add r1,r2,r1	; 023284AE
	mov r2,#0xa	; 023284B0
	ldr r3,[pool_023284BC]	; 023284B2
	bx r3	; 023284B4
	.byte 0xC0, 0x46	; 023284B8
pool_023284B8:
loc_023284B8:
	.word 0x08000004	; 023284B8
pool_023284BC:
loc_023284BC:
	.word P1_SwiCpuSet + 1	; 023284BC

; ===== function loc_023284C0 =====
loc_023284C0:
	push {r4,r5,r6,r7,lr}	; 023284C0
	sub sp,#0x4	; 023284C2
	add r6,r0,#0x0	; 023284C4
	ldr r0,[pool_0232852C]	; 023284C6
	ldrb r1,[r0,#0x0]	; 023284C8
	mov r0,#0x80	; 023284CA
	and r1,r0	; 023284CC
	cmp r1,#0x0	; 023284CE
	beq loc_023284D6	; 023284D0
	ldr r0,[pool_02328530]	; 023284D2
	b loc_023284D8	; 023284D4
loc_023284D6:
	ldr r0,[pool_02328534]	; 023284D6
loc_023284D8:
	add r1,r6,#0x0	; 023284D8
	mov r2,#0xa	; 023284DA
	bl loc_0232C7C6	; 023284DC
	ldr r0,[pool_02328538]	; 023284E0
	sub r0,r0,#0x1	; 023284E2
	mov r1,#0x1b	; 023284E4
	bl loc_02328480	; 023284E6
	ldr r3,[pool_0232853C]	; 023284EA
	ldr r1,[pool_02328538]	; 023284EC
	ldrb r2,[r1,#0x0]	; 023284EE
	mov r1,#0x3	; 023284F0
	and r2,r1	; 023284F2
	mov r1,#0x30	; 023284F4
	mul r2,r1	; 023284F6
	add r2,r3,r2	; 023284F8
	mov r1,#0xc	; 023284FA
	mul r0,r1	; 023284FC
	add r5,r2,r0	; 023284FE
	mov r4,#0x0	; 02328500
	ldr r7,[pool_02328540]	; 02328502
loc_02328504:
	add r0,r6,#0x0	; 02328504
	add r1,r4,#0x0	; 02328506
	bl loc_023284A4	; 02328508
	cmp r4,#0x3	; 0232850C
	blt loc_0232851C	; 0232850E
	cmp r4,#0x9	; 02328510
	bge loc_0232851C	; 02328512
	ldrh r0,[r5,#0x0]	; 02328514
	add r5,r5,#0x2	; 02328516
	lsl r0,r0,#0x1	; 02328518
	ldrh r0,[r0,r7]	; 0232851A
loc_0232851C:
	add r4,r4,#0x1	; 0232851C
	cmp r4,#0xb	; 0232851E
	blt loc_02328504	; 02328520
	add sp,#0x4	; 02328522
	pop {r4,r5,r6,r7}	; 02328524
	pop {r3}	; 02328526
	bx r3	; 02328528
	.byte 0xC0, 0x46	; 0232852C
pool_0232852C:
loc_0232852C:
	.word Slot2BusBaseAddress + 0xB4	; 0232852C
pool_02328530:
loc_02328530:
	.word 0x09FE1FE0	; 02328530
pool_02328534:
loc_02328534:
	.word 0x09FFFFE0	; 02328534
pool_02328538:
loc_02328538:
	.word Slot2BusBaseAddress + 0x9E	; 02328538
pool_0232853C:
loc_0232853C:
	.word 0x02330954	; 0232853C
pool_02328540:
loc_02328540:
	.word 0x08000000	; 02328540

; ===== function loc_02328544 =====
loc_02328544:
	push {r4,r5,r6,r7}	; 02328544
	mov r5,#0x0	; 02328546
	ldr r3,[pool_0232858C]	; 02328548
	ldr r2,[pool_02328590]	; 0232854A
	mov r1,#0x3	; 0232854C
	add r4,r2,#0x0	; 0232854E
	eor r4,r1	; 02328550
	lsl r1,r4,#0x10	; 02328552
	lsr r1,r1,#0x10	; 02328554
	mov r6,#0x84	; 02328556
loc_02328558:
	add r4,r2,#0x0	; 02328558
	cmp r5,#0x4c	; 0232855A
	bne loc_02328566	; 0232855C
	eor r4,r6	; 0232855E
	lsl r4,r4,#0x10	; 02328560
	lsr r4,r4,#0x10	; 02328562
	b loc_0232856C	; 02328564
loc_02328566:
	cmp r5,#0x4d	; 02328566
	bne loc_0232856C	; 02328568
	add r4,r1,#0x0	; 0232856A
loc_0232856C:
	ldrh r7,[r0,#0x0]	; 0232856C
	and r4,r7	; 0232856E
	ldrh r7,[r3,#0x0]	; 02328570
	cmp r4,r7	; 02328572
	beq loc_0232857C	; 02328574
	mov r0,#0x0	; 02328576
	pop {r4,r5,r6,r7}	; 02328578
	bx lr	; 0232857A
loc_0232857C:
	add r3,r3,#0x2	; 0232857C
	add r0,r0,#0x2	; 0232857E
	add r5,r5,#0x1	; 02328580
	cmp r5,#0x4e	; 02328582
	blt loc_02328558	; 02328584
	mov r0,#0x1	; 02328586
	pop {r4,r5,r6,r7}	; 02328588
	bx lr	; 0232858A
pool_0232858C:
loc_0232858C:
	.word 0xFFFF0020	; 0232858C
pool_02328590:
loc_02328590:
	.word 0x0000FFFF	; 02328590

; ===== function loc_02328594 =====
loc_02328594:
	push {r4,lr}	; 02328594
	mov r0,#0x6d	; 02328596
	bl loc_0232B3B8	; 02328598
	ldr r0,[pool_023285B8]	; 0232859C
	bl loc_023284C0	; 0232859E
	ldr r0,[pool_023285B8]	; 023285A2
	bl loc_02328544	; 023285A4
	add r4,r0,#0x0	; 023285A8
	mov r0,#0x6d	; 023285AA
	bl loc_0232B250	; 023285AC
	add r0,r4,#0x0	; 023285B0
	pop {r4}	; 023285B2
	pop {r3}	; 023285B4
	bx r3	; 023285B6
pool_023285B8:
loc_023285B8:
	.word 0x02356320	; 023285B8

; ===== function loc_023285BC =====
loc_023285BC:
	push {r0,r1,r2,r4,lr}	; 023285BC
	ldr r0,[pool_02328600]	; 023285BE
	add r1,r2,#0x0	; 023285C0
	add r4,r1,#0x0	; 023285C2
	mov r2,#0x24	; 023285C4
	blx loc_0232DE20	; 023285C6
	ldr r0,[sp,#0x0]	; 023285CA
	mov r2,#0x24	; 023285CC
	add r1,r4,r2	; 023285CE
	mov r2,#0x9c	; 023285D0
	blx loc_0232DE20	; 023285D2
	add r0,r4,#0x0	; 023285D6
	ldr r1,[sp,#0x4]	; 023285D8
	mov r2,#0x1	; 023285DA
	lsl r2,r2,#0x8	; 023285DC
	add r2,r2,r1	; 023285DE
	ldr r3,[pool_02328604]	; 023285E0
	bl loc_0232C7E6	; 023285E2
	ldr r0,[sp,#0x4]	; 023285E6
	ldr r2,[pool_02328608]	; 023285E8
	str r2,[r0,#0x0]	; 023285EA
	add r1,r4,#0x0	; 023285EC
	bl loc_02328610	; 023285EE
	add r0,r4,#0x0	; 023285F2
	ldr r1,[sp,#0x4]	; 023285F4
	ldr r2,[pool_0232860C]	; 023285F6
	bl loc_0232C7DA	; 023285F8
	pop {r0,r1,r2,r4,pc}	; 023285FC
	.byte 0xC0, 0x46	; 02328600
pool_02328600:
loc_02328600:
	.word 0x02330218	; 02328600
pool_02328604:
loc_02328604:
	.word 0x02330204	; 02328604
pool_02328608:
loc_02328608:
	.word 0x0000D082	; 02328608
pool_0232860C:
loc_0232860C:
	.word 0x02330A14	; 0232860C

; ===== function loc_02328610 =====
.func P1_SwiDiff16UnFilter
; BIOS SWI #18: differential 16-bit decompression. / BIOS SWI #18：差分 16 位解压。
loc_02328610:
	swi 0x18	; 02328610
	bx lr	; 02328612
.endfunc

; ===== function loc_02328614 =====
loc_02328614:
	ldr r0,[r0,#0x0]	; 02328614
	bx lr	; 02328616
	ldrb r0,[r0,#0x0]	; 02328618
	bx lr	; 0232861A
	mov r0,#0x0	; 0232861C
	bx lr	; 0232861E

; ===== function loc_02328620 =====
	push {lr}	; 02328620
	sub sp,#0x4	; 02328622
	cmp r2,#0x0	; 02328624
	beq loc_02328632	; 02328626
	bl loc_02328614	; 02328628
	add sp,#0x4	; 0232862C
	pop {r3}	; 0232862E
	bx r3	; 02328630
loc_02328632:
	mov r0,#0x0	; 02328632
	add sp,#0x4	; 02328634
	pop {r3}	; 02328636
	bx r3	; 02328638
	.byte 0x00, 0x00	; 0232863C

; ===== function loc_0232863C =====
loc_0232863C:
	push {r4,r5,r6,lr}	; 0232863C
	sub sp,#0x100	; 0232863E
	add r5,r1,#0x0	; 02328640
	add r4,r3,#0x0	; 02328642
	ldr r1,[pool_02328670]	; 02328644
	ldr r3,[r1,#0x4]	; 02328646
	ldr r6,[pool_02328674]	; 02328648
	and r3,r6	; 0232864A
	sub r6,r2,#0x1	; 0232864C
	ldr r2,[pool_02328678]	; 0232864E
	and r6,r2	; 02328650
	orr r3,r6	; 02328652
	str r3,[r1,#0x4]	; 02328654
	add r1,r4,#0x0	; 02328656
	add r2,sp,#0x0	; 02328658
	bl loc_023285BC	; 0232865A
	add r0,r4,#0x0	; 0232865E
	add r1,r5,#0x0	; 02328660
	ldr r2,[pool_0232867C]	; 02328662
	blx loc_0232DEB4	; 02328664
	add sp,#0x100	; 02328668
	pop {r4,r5,r6}	; 0232866A
	pop {r3}	; 0232866C
	bx r3	; 0232866E
pool_02328670:
loc_02328670:
	.word P1_Data_02330A14	; 02328670
pool_02328674:
loc_02328674:
	.word 0x80000000	; 02328674
pool_02328678:
loc_02328678:
	.word 0x7FFFFFFF	; 02328678
pool_0232867C:
loc_0232867C:
	.word 0x00000340	; 0232867C
.arm

; ===== function loc_02328680 =====
loc_02328680:
; 解出 P3/P4/P5；r0=目标、r1=压缩流，返回输出长度。
; Decode P3/P4/P5; r0=destination, r1=stream, returns output size.
.func P1_DecompressP345
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}	; 02328680
	sub sp,sp,#0x4	; 02328684
	ldr r4,[r1,#0x4]	; 02328688
	eor r5,r4,r4, ror #0x10	; 0232868C
	bic r5,r5,#0xff0000	; 02328690
	mov r4,r4, ror #0x8	; 02328694
	eor r4,r4,r5, lsr #0x8	; 02328698
	bic r4,r4,#0xff000000	; 0232869C
	str r4,[sp,#0x0]	; 023286A0
	add r5,r0,r4	; 023286A4
	ldr r6,[pool_02328A98]	; 023286A8
	cmp r5,r6	; 023286AC
	bls loc_023286C0	; 023286B0
	mov r0,#0x0	; 023286B4
	add sp,sp,#0x4	; 023286B8
	bl loc_023289E8	; 023286BC
loc_023286C0:
	ldr r5,[r1,#0x8]	; 023286C0
	eor r6,r5,r5, ror #0x10	; 023286C4
	bic r6,r6,#0xff0000	; 023286C8
	mov r5,r5, ror #0x8	; 023286CC
	eor r5,r5,r6, lsr #0x8	; 023286D0
; 每次重新建立两路状态；共享工作区不可重入。
; Reinitialize both streams for each call; shared workspace is not reentrant.
	ldr r2,[pool_02328A9C]	; 023286D4
	add r3,r1,#0xc	; 023286D8
	str r3,[r2,#0x10]	; 023286DC
	add r3,r1,r5	; 023286E0
	str r3,[r2,#0x14]	; 023286E4
	mov r3,#0x0	; 023286E8
	str r3,[r2,#0x0]	; 023286EC
	str r3,[r2,#0x4]	; 023286F0
	mov r3,#0x200	; 023286F4
	str r3,[r2,#0x8]	; 023286F8
	mov r3,#0x800	; 023286FC
	str r3,[r2,#0xc]	; 02328700
	ldr r11,[pool_02328A9C]	; 02328704
	mov r12,#0x20	; 02328708
	bl P1_ReadP345Bits	; 0232870C
	ldr r11,[pool_02328AA0]	; 02328710
	mov r12,#0x20	; 02328714
	bl P1_ReadP345Bits	; 02328718
; 先构建 9 位字面量/长度树，子节点为 16 位表项。
; Build the 9-bit literal/length tree with 16-bit child entries.
	ldr r11,[pool_02328A9C]	; 0232871C
	ldr r2,[pool_02328AA4]	; 02328720
	mov r1,r2	; 02328724
	ldr r5,[r11,#0x8]	; 02328728
	mov r6,r5	; 0232872C
loc_02328730:
	ldr r8,[r11,#0x0]	; 02328730
	ldr r9,[r11,#0x10]	; 02328734
	ldr r10,[r11,#0x18]	; 02328738
	mov r7,r10, lsr #0x1f	; 0232873C
	cmp r8,#0x1f	; 02328740
	bne loc_02328768	; 02328744
	ldr r3,[r9],#0x4	; 02328748
	eor r10,r3,r3, ror #0x10	; 0232874C
	bic r10,r10,#0xff0000	; 02328750
	mov r3,r3, ror #0x8	; 02328754
	eor r3,r3,r10, lsr #0x8	; 02328758
	str r9,[r11,#0x10]	; 0232875C
	mov r8,#0x0	; 02328760
	b loc_02328770	; 02328764
loc_02328768:
	mov r3,r10, lsl #0x1	; 02328768
	add r8,r8,#0x1	; 0232876C
loc_02328770:
	str r3,[r11,#0x18]	; 02328770
	str r8,[r11,#0x0]	; 02328774
	cmp r7,#0x0	; 02328778
	beq loc_0232879C	; 0232877C
	orr r8,r5,#0x8000	; 02328780
	orr r9,r5,#0x4000	; 02328784
	strh r8,[r2],#0x2	; 02328788
	strh r9,[r2],#0x2	; 0232878C
	add r5,r5,#0x1	; 02328790
	add r6,r6,#0x1	; 02328794
	b loc_02328730	; 02328798
loc_0232879C:
	mov r12,#0x9	; 0232879C
	bl P1_ReadP345Bits	; 023287A0
	mov r10,#0x4000	; 023287A4
	ldr r12,[pool_02328AA8]	; 023287A8
	ldr r3,[pool_02328AAC]	; 023287AC
	sub r10,r10,#0x1	; 023287B0
loc_023287B4:
	ldrh r8,[r2,#-0x2]!	; 023287B4
	and r9,r8,r10	; 023287B8
	mov lr,r9, lsl #0x1	; 023287BC
	tst r8,#0x8000	; 023287C0
	beq loc_023287DC	; 023287C4
	strh r7,[r3,lr]	; 023287C8
	mov r7,r9	; 023287CC
	cmp r2,r1	; 023287D0
	bne loc_023287B4	; 023287D4
	b loc_023287E8	; 023287D8
loc_023287DC:
	strh r7,[r12,lr]	; 023287DC
	mov r5,r6	; 023287E0
	b loc_02328730	; 023287E4
loc_023287E8:
	str r7,[r11,#0x20]	; 023287E8
; 复用临时栈构建 11 位距离树，不覆盖前一棵树。
; Reuse the temporary stack for the 11-bit distance tree, preserving the first tree.
	ldr r11,[pool_02328AA0]	; 023287EC
	ldr r2,[pool_02328AA4]	; 023287F0
	mov r1,r2	; 023287F4
	ldr r5,[r11,#0x8]	; 023287F8
	mov r6,r5	; 023287FC
loc_02328800:
	ldr r8,[r11,#0x0]	; 02328800
	ldr r9,[r11,#0x10]	; 02328804
	ldr r10,[r11,#0x18]	; 02328808
	mov r7,r10, lsr #0x1f	; 0232880C
	cmp r8,#0x1f	; 02328810
	bne loc_02328838	; 02328814
	ldr r3,[r9],#0x4	; 02328818
	eor r10,r3,r3, ror #0x10	; 0232881C
	bic r10,r10,#0xff0000	; 02328820
	mov r3,r3, ror #0x8	; 02328824
	eor r3,r3,r10, lsr #0x8	; 02328828
	str r9,[r11,#0x10]	; 0232882C
	mov r8,#0x0	; 02328830
	b loc_02328840	; 02328834
loc_02328838:
	mov r3,r10, lsl #0x1	; 02328838
	add r8,r8,#0x1	; 0232883C
loc_02328840:
	str r3,[r11,#0x18]	; 02328840
	str r8,[r11,#0x0]	; 02328844
	cmp r7,#0x0	; 02328848
	beq loc_0232886C	; 0232884C
	orr r8,r5,#0x8000	; 02328850
	orr r9,r5,#0x4000	; 02328854
	strh r8,[r2],#0x2	; 02328858
	strh r9,[r2],#0x2	; 0232885C
	add r5,r5,#0x1	; 02328860
	add r6,r6,#0x1	; 02328864
	b loc_02328800	; 02328868
loc_0232886C:
	mov r12,#0xb	; 0232886C
	bl P1_ReadP345Bits	; 02328870
	mov r10,#0x4000	; 02328874
	ldr r12,[pool_02328AB0]	; 02328878
	ldr r3,[pool_02328AB4]	; 0232887C
	sub r10,r10,#0x1	; 02328880
loc_02328884:
	ldrh r8,[r2,#-0x2]!	; 02328884
	and r9,r8,r10	; 02328888
	mov lr,r9, lsl #0x1	; 0232888C
	tst r8,#0x8000	; 02328890
	beq loc_023288AC	; 02328894
	strh r7,[r3,lr]	; 02328898
	mov r7,r9	; 0232889C
	cmp r2,r1	; 023288A0
	bne loc_02328884	; 023288A4
	b loc_023288B8	; 023288A8
loc_023288AC:
	strh r7,[r12,lr]	; 023288AC
	mov r5,r6	; 023288B0
	b loc_02328800	; 023288B4
loc_023288B8:
	str r7,[r11,#0x20]	; 023288B8
loc_023288BC:
; 小于 0x100 的值直接输出；否则长度=值-0xFD，回距=距离值+1。
; Values below 0x100 are literals; otherwise length=value-0xFD, distance=distance value+1.
	cmp r4,#0x0	; 023288BC
	beq loc_023289E4	; 023288C0
	ldr r11,[pool_02328A9C]	; 023288C4
	ldr r1,[pool_02328AA8]	; 023288C8
	ldr r2,[pool_02328AAC]	; 023288CC
	ldr r5,[r11,#0x20]	; 023288D0
	ldr r8,[r11,#0x0]	; 023288D4
	ldr r9,[r11,#0x10]	; 023288D8
	ldr r10,[r11,#0x18]	; 023288DC
loc_023288E0:
	cmp r5,#0x200	; 023288E0
	bcc loc_0232892C	; 023288E4
	mov r7,r10, lsr #0x1f	; 023288E8
	cmp r8,#0x1f	; 023288EC
	bne loc_02328910	; 023288F0
	ldr r10,[r9],#0x4	; 023288F4
	eor r3,r10,r10, ror #0x10	; 023288F8
	bic r3,r3,#0xff0000	; 023288FC
	mov r10,r10, ror #0x8	; 02328900
	eor r10,r10,r3, lsr #0x8	; 02328904
	mov r8,#0x0	; 02328908
	b loc_02328918	; 0232890C
loc_02328910:
	mov r10,r10, lsl #0x1	; 02328910
	add r8,r8,#0x1	; 02328914
loc_02328918:
	mov r3,r5, lsl #0x1	; 02328918
	cmp r7,#0x0	; 0232891C
	ldreqh r5,[r1,r3]	; 02328920
	ldrneh r5,[r2,r3]	; 02328924
	b loc_023288E0	; 02328928
loc_0232892C:
	str r8,[r11,#0x0]	; 0232892C
	str r9,[r11,#0x10]	; 02328930
	str r10,[r11,#0x18]	; 02328934
	cmp r5,#0x100	; 02328938
	bcs loc_0232894C	; 0232893C
	strb r5,[r0],#0x1	; 02328940
	sub r4,r4,#0x1	; 02328944
	b loc_023288BC	; 02328948
loc_0232894C:
	ldr r11,[pool_02328AA0]	; 0232894C
	ldr r1,[pool_02328AB0]	; 02328950
	ldr r2,[pool_02328AB4]	; 02328954
	ldr r6,[r11,#0x20]	; 02328958
	ldr r8,[r11,#0x0]	; 0232895C
	ldr r9,[r11,#0x10]	; 02328960
	ldr r10,[r11,#0x18]	; 02328964
loc_02328968:
	cmp r6,#0x800	; 02328968
	bcc loc_023289B4	; 0232896C
	mov r7,r10, lsr #0x1f	; 02328970
	cmp r8,#0x1f	; 02328974
	bne loc_02328998	; 02328978
	ldr r10,[r9],#0x4	; 0232897C
	eor r3,r10,r10, ror #0x10	; 02328980
	bic r3,r3,#0xff0000	; 02328984
	mov r10,r10, ror #0x8	; 02328988
	eor r10,r10,r3, lsr #0x8	; 0232898C
	mov r8,#0x0	; 02328990
	b loc_023289A0	; 02328994
loc_02328998:
	mov r10,r10, lsl #0x1	; 02328998
	add r8,r8,#0x1	; 0232899C
loc_023289A0:
	mov r3,r6, lsl #0x1	; 023289A0
	cmp r7,#0x0	; 023289A4
	ldreqh r6,[r1,r3]	; 023289A8
	ldrneh r6,[r2,r3]	; 023289AC
	b loc_02328968	; 023289B0
loc_023289B4:
	str r8,[r11,#0x0]	; 023289B4
	str r9,[r11,#0x10]	; 023289B8
	str r10,[r11,#0x18]	; 023289BC
	sub r3,r0,r6	; 023289C0
	sub r5,r5,#0xfd	; 023289C4
	sub r3,r3,#0x1	; 023289C8
	sub r4,r4,r5	; 023289CC
loc_023289D0:
	ldrb r11,[r3],#0x1	; 023289D0
	subs r5,r5,#0x1	; 023289D4
	strb r11,[r0],#0x1	; 023289D8
	bne loc_023289D0	; 023289DC
	b loc_023288BC	; 023289E0
loc_023289E4:
	ldr r0,[sp],#0x4	; 023289E4

; 共用返回尾部。 / Shared return epilogue.
loc_023289E8:
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}	; 023289E8
	bx lr	; 023289EC
.endfunc

; ===== function loc_023289F0 =====
loc_023289F0:
; 从 r11 指定的位流取 r12 位到 r7，并推进游标。
; Read r12 bits into r7 from the r11 stream context; advance its cursor.
.func P1_ReadP345Bits
	ldr r8,[r11,#0x0]	; 023289F0
	ldr r9,[r11,#0x10]	; 023289F4
	ldr r10,[r11,#0x18]	; 023289F8
	mov r7,#0x20	; 023289FC
	sub r7,r7,r12	; 02328A00
	mov r7,r10, lsr r7	; 02328A04
	add r3,r8,r12	; 02328A08
	cmp r3,#0x20	; 02328A0C
	beq loc_02328A5C	; 02328A10
	bcc loc_02328A84	; 02328A14
	ldr r3,[r9],#0x4	; 02328A18
	eor r10,r3,r3, ror #0x10	; 02328A1C
	bic r10,r10,#0xff0000	; 02328A20
	mov r3,r3, ror #0x8	; 02328A24
	eor r3,r3,r10, lsr #0x8	; 02328A28
	str r9,[r11,#0x10]	; 02328A2C
	mov r10,#0x40	; 02328A30
	sub r9,r10,r12	; 02328A34
	sub r9,r9,r8	; 02328A38
	mov r9,r3, lsr r9	; 02328A3C
	orr r7,r7,r9	; 02328A40
	sub r12,r12,#0x20	; 02328A44
	add r8,r8,r12	; 02328A48
	str r8,[r11,#0x0]	; 02328A4C
	mov r12,r3, lsl r8	; 02328A50
	str r12,[r11,#0x18]	; 02328A54
	bx lr	; 02328A58
loc_02328A5C:
	ldr r3,[r9],#0x4	; 02328A5C
	eor r10,r3,r3, ror #0x10	; 02328A60
	bic r10,r10,#0xff0000	; 02328A64
	mov r3,r3, ror #0x8	; 02328A68
	eor r3,r3,r10, lsr #0x8	; 02328A6C
	str r9,[r11,#0x10]	; 02328A70
	str r3,[r11,#0x18]	; 02328A74
	mov r3,#0x0	; 02328A78
	str r3,[r11,#0x0]	; 02328A7C
	bx lr	; 02328A80
loc_02328A84:
	mov r3,r10, lsl r12	; 02328A84
	str r3,[r11,#0x18]	; 02328A88
	add r10,r8,r12	; 02328A8C
	str r10,[r11,#0x0]	; 02328A90
	bx lr	; 02328A94
.endfunc
pool_02328A98:
loc_02328A98:
	.word P345DecodeOutputLimitAddress	; 02328A98
pool_02328A9C:
loc_02328A9C:
	.word P1_P345DecodeWorkspace	; 02328A9C
pool_02328AA0:
loc_02328AA0:
	.word P1_P345DecodeWorkspace + 4	; 02328AA0
pool_02328AA4:
loc_02328AA4:
	.word P1_P345TreeStack	; 02328AA4
pool_02328AA8:
loc_02328AA8:
	.word P1_P345LengthZeroChildren	; 02328AA8
pool_02328AAC:
loc_02328AAC:
	.word P1_P345LengthOneChildren	; 02328AAC
pool_02328AB0:
loc_02328AB0:
	.word P1_P345DistanceZeroChildren	; 02328AB0
pool_02328AB4:
loc_02328AB4:
	.word P1_P345DistanceOneChildren	; 02328AB4
	.byte 0x10, 0xB5, 0x00, 0xF0, 0x3B, 0xF8, 0x04, 0x1C, 0x00, 0x2C, 0x24, 0xD0, 0x14, 0x48, 0x10, 0x30	; 02328AC8
	.byte 0x14, 0x49, 0x02, 0x22, 0x00, 0xF0, 0x54, 0xF8, 0x00, 0x28, 0x1C, 0xD1, 0x10, 0x48, 0x80, 0x7F	; 02328AD8
	.byte 0x00, 0x28, 0x18, 0xD1, 0x10, 0x4A, 0x61, 0x1E, 0xB8, 0x20, 0x41, 0x43, 0x54, 0x18, 0x0F, 0x48	; 02328AE8
	.byte 0x0F, 0x49, 0x10, 0x4A, 0x05, 0xF0, 0x0A, 0xEA, 0x20, 0x1C, 0x0F, 0x49, 0xB8, 0x22, 0x05, 0xF0	; 02328AF8
	.byte 0x06, 0xEA, 0x20, 0x1C, 0xB0, 0x30, 0x01, 0x68, 0xB4, 0x34, 0x20, 0x68, 0x01, 0x60, 0x01, 0x20	; 02328B08
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02328B18
	.byte 0x00, 0xFE, 0x7F, 0x02, 0x1C, 0x0A, 0x33, 0x02, 0x3C, 0x03, 0x33, 0x02, 0x3C, 0x02, 0x33, 0x02	; 02328B28
	.byte 0x00, 0x50, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x52, 0x00, 0x02, 0x00, 0xB5, 0x81, 0xB0	; 02328B38
	.byte 0x0C, 0x48, 0x0D, 0x49, 0x04, 0x22, 0x00, 0xF0, 0x1B, 0xF8, 0x00, 0x28, 0x03, 0xD1, 0x01, 0x20	; 02328B48
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x07, 0x48, 0x08, 0x49, 0x04, 0x22, 0x00, 0xF0, 0x10, 0xF8	; 02328B58
	.byte 0x00, 0x28, 0x03, 0xD0, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x02, 0x20, 0x01, 0xB0	; 02328B68
	.byte 0x08, 0xBC, 0x18, 0x47, 0x0C, 0xFE, 0x7F, 0x02, 0x20, 0x0A, 0x33, 0x02, 0x28, 0x0A, 0x33, 0x02	; 02328B78
	.byte 0x10, 0xB4, 0x81, 0xB0, 0x00, 0x2A, 0x03, 0xD1, 0x00, 0x20, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47	; 02328B88
	.byte 0x0C, 0x78, 0x03, 0x78, 0xA3, 0x42, 0x0C, 0xD1, 0x52, 0x1E, 0x00, 0x2A, 0x03, 0xD1, 0x00, 0x20	; 02328B98
	.byte 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x40, 0x1C, 0x49, 0x1C, 0x0C, 0x78, 0x03, 0x78, 0xA3, 0x42	; 02328BA8
	.byte 0xF2, 0xD0, 0x18, 0x1B, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x00, 0x00	; 02328BB4
.thumb

; ===== function loc_02328BB4 =====
loc_02328BB4:
	push {r4,lr}	; 02328BB4
	add r4,r0,#0x0	; 02328BB6
	bl loc_02328F60	; 02328BB8
	ldrh r1,[r4,#0x12]	; 02328BBC
	cmp r0,r1	; 02328BBE
	beq loc_02328BCC	; 02328BC0
	strh r0,[r4,#0x12]	; 02328BC2
	mov r0,#0x1	; 02328BC4
	pop {r4}	; 02328BC6
	pop {r3}	; 02328BC8
	bx r3	; 02328BCA
loc_02328BCC:
	mov r0,#0x0	; 02328BCC
	pop {r4}	; 02328BCE
	pop {r3}	; 02328BD0
	bx r3	; 02328BD2

; ===== function loc_02328BD4 =====
P1_Entry_02328BD4:
	push {r4,lr}	; 02328BD4
	add r4,r0,#0x0	; 02328BD6
	bl loc_02328F60	; 02328BD8
	ldr r1,[r4,#0xc]	; 02328BDC
	lsl r0,r0,#0x1	; 02328BDE
	ldrb r0,[r1,r0]	; 02328BE0
	pop {r4}	; 02328BE2
	pop {r3}	; 02328BE4
	bx r3	; 02328BE6

; ===== function loc_02328BE8 =====
loc_02328BE8:
	ldrh r0,[r0,#0x16]	; 02328BE8
	lsl r0,r0,#0x16	; 02328BEA
	lsr r0,r0,#0x1b	; 02328BEC
	ldrh r3,[r1,#0x0]	; 02328BEE
	cmp r3,#0x0	; 02328BF0
	beq loc_02328C04	; 02328BF2
	add r2,r2,r0	; 02328BF4
loc_02328BF6:
	cmp r3,#0xa	; 02328BF6
	bne loc_02328BFC	; 02328BF8
	add r0,r0,r2	; 02328BFA
loc_02328BFC:
	add r1,r1,#0x2	; 02328BFC
	ldrh r3,[r1,#0x0]	; 02328BFE
	cmp r3,#0x0	; 02328C00
	bne loc_02328BF6	; 02328C02
loc_02328C04:
	bx lr	; 02328C04
	.byte 0x00, 0x00	; 02328C08

; ===== function loc_02328C08 =====
loc_02328C08:
	push {r4,r5,r6,r7,lr}	; 02328C08
	sub sp,#0x4	; 02328C0A
	add r5,r0,#0x0	; 02328C0C
	add r6,r2,#0x0	; 02328C0E
	mov r4,#0x0	; 02328C10
	str r4,[sp,#0x0]	; 02328C12
	cmp r1,#0x0	; 02328C14
	beq loc_02328C32	; 02328C16
	add r7,sp,#0x0	; 02328C18
loc_02328C1A:
	add r0,r5,#0x0	; 02328C1A
	add r2,r7,#0x0	; 02328C1C
	add r3,r6,#0x0	; 02328C1E
	bl loc_02328C3C	; 02328C20
	add r1,r0,#0x0	; 02328C24
	ldr r0,[sp,#0x0]	; 02328C26
	cmp r4,r0	; 02328C28
	bge loc_02328C2E	; 02328C2A
	add r4,r0,#0x0	; 02328C2C
loc_02328C2E:
	cmp r1,#0x0	; 02328C2E
	bne loc_02328C1A	; 02328C30
loc_02328C32:
	add r0,r4,#0x0	; 02328C32
	add sp,#0x4	; 02328C34
	pop {r4,r5,r6,r7}	; 02328C36
	pop {r3}	; 02328C38
	bx r3	; 02328C3A

; ===== function loc_02328C3C =====
loc_02328C3C:
	push {r4,r5,r6,r7,lr}	; 02328C3C
	sub sp,#0x4	; 02328C3E
	add r7,r0,#0x0	; 02328C40
	add r5,r1,#0x0	; 02328C42
	str r2,[sp,#0x0]	; 02328C44
	add r6,r3,#0x0	; 02328C46
	mov r4,#0x0	; 02328C48
	ldrh r1,[r5,#0x0]	; 02328C4A
	cmp r1,#0x0	; 02328C4C
	beq loc_02328C84	; 02328C4E
loc_02328C50:
	cmp r1,#0xa	; 02328C50
	bne loc_02328C6E	; 02328C52
	ldr r0,[sp,#0x0]	; 02328C54
	cmp r0,#0x0	; 02328C56
	beq loc_02328C64	; 02328C58
	cmp r4,r6	; 02328C5A
	ble loc_02328C60	; 02328C5C
	sub r4,r4,r6	; 02328C5E
loc_02328C60:
	ldr r0,[sp,#0x0]	; 02328C60
	str r4,[r0,#0x0]	; 02328C62
loc_02328C64:
	add r0,r5,#0x2	; 02328C64
	add sp,#0x4	; 02328C66
	pop {r4,r5,r6,r7}	; 02328C68
	pop {r3}	; 02328C6A
	bx r3	; 02328C6C
loc_02328C6E:
	cmp r1,#0xd	; 02328C6E
	beq loc_02328C7C	; 02328C70
	add r0,r7,#0x0	; 02328C72
	bl loc_02328CA0	; 02328C74
	add r0,r6,r0	; 02328C78
	add r4,r4,r0	; 02328C7A
loc_02328C7C:
	add r5,r5,#0x2	; 02328C7C
	ldrh r1,[r5,#0x0]	; 02328C7E
	cmp r1,#0x0	; 02328C80
	bne loc_02328C50	; 02328C82
loc_02328C84:
	ldr r0,[sp,#0x0]	; 02328C84
	cmp r0,#0x0	; 02328C86
	beq loc_02328C94	; 02328C88
	cmp r4,r6	; 02328C8A
	ble loc_02328C90	; 02328C8C
	sub r4,r4,r6	; 02328C8E
loc_02328C90:
	ldr r0,[sp,#0x0]	; 02328C90
	str r4,[r0,#0x0]	; 02328C92
loc_02328C94:
	mov r0,#0x0	; 02328C94
	add sp,#0x4	; 02328C96
	pop {r4,r5,r6,r7}	; 02328C98
	pop {r3}	; 02328C9A
	bx r3	; 02328C9C
	.byte 0x00, 0x00	; 02328CA0

; ===== function loc_02328CA0 =====
loc_02328CA0:
	push {r4,lr}	; 02328CA0
	add r4,r0,#0x0	; 02328CA2
	bl loc_02328F60	; 02328CA4
	ldr r1,[r4,#0xc]	; 02328CA8
	lsl r0,r0,#0x1	; 02328CAA
	add r0,r1,r0	; 02328CAC
	ldrb r0,[r0,#0x1]	; 02328CAE
	pop {r4}	; 02328CB0
	pop {r3}	; 02328CB2
	bx r3	; 02328CB4
	.byte 0x00, 0x00	; 02328CB8

; ===== function loc_02328CB8 =====
loc_02328CB8:
	push {r0,r1,r2,r3}	; 02328CB8
	push {r4,r5,r6,r7,lr}	; 02328CBA
	sub sp,#0x1c	; 02328CBC
	add r5,r0,#0x0	; 02328CBE
	str r1,[sp,#0x8]	; 02328CC0
	ldr r1,[sp,#0x40]	; 02328CC2
	str r1,[sp,#0x40]	; 02328CC4
	ldr r1,[sp,#0x44]	; 02328CC6
	str r1,[sp,#0x44]	; 02328CC8
	ldr r6,[sp,#0x48]	; 02328CCA
	ldr r1,[sp,#0x4c]	; 02328CCC
	str r1,[sp,#0x4c]	; 02328CCE
	add r1,r6,#0x0	; 02328CD0
	ldr r2,[sp,#0x40]	; 02328CD2
	bl loc_02328C08	; 02328CD4
	add r4,r0,#0x0	; 02328CD8
	add r0,r5,#0x0	; 02328CDA
	add r1,r6,#0x0	; 02328CDC
	ldr r2,[sp,#0x44]	; 02328CDE
	bl loc_02328BE8	; 02328CE0
	str r0,[sp,#0x14]	; 02328CE4
	mov r1,sp	; 02328CE6
	sub r1,r1,#0x4	; 02328CE8
	add r0,sp,#0x30	; 02328CEA
	ldrh r0,[r0,#0x8]	; 02328CEC
	strh r0,[r1,#0x0]	; 02328CEE
	ldmia r1!,{r0}	; 02328CF0
	add r1,r4,#0x0	; 02328CF2
	bl loc_023290D0	; 02328CF4
	add r7,r0,#0x0	; 02328CF8
	mov r1,sp	; 02328CFA
	sub r1,r1,#0x4	; 02328CFC
	add r0,sp,#0x30	; 02328CFE
	ldrh r0,[r0,#0xc]	; 02328D00
	strh r0,[r1,#0x0]	; 02328D02
	ldmia r1!,{r0}	; 02328D04
	ldr r1,[sp,#0x14]	; 02328D06
	bl loc_02329098	; 02328D08
	str r0,[sp,#0x10]	; 02328D0C
	mov r1,sp	; 02328D0E
	sub r1,r1,#0x4	; 02328D10
	add r0,sp,#0x30	; 02328D12
	ldrh r0,[r0,#0x8]	; 02328D14
	strh r0,[r1,#0x0]	; 02328D16
	ldmia r1!,{r0}	; 02328D18
	add r1,r4,#0x0	; 02328D1A
	bl loc_02328DC8	; 02328D1C
	add r4,r7,r0	; 02328D20
	str r4,[sp,#0xc]	; 02328D22
	add r0,r5,#0x0	; 02328D24
	add r1,r6,#0x0	; 02328D26
	add r2,sp,#0x18	; 02328D28
	ldr r3,[sp,#0x40]	; 02328D2A
	bl loc_02328C3C	; 02328D2C
	mov r1,sp	; 02328D30
	sub r1,r1,#0x4	; 02328D32
	add r0,sp,#0x30	; 02328D34
	ldrh r0,[r0,#0x8]	; 02328D36
	strh r0,[r1,#0x0]	; 02328D38
	ldmia r1!,{r0}	; 02328D3A
	ldr r1,[sp,#0x18]	; 02328D3C
	bl loc_02328DC8	; 02328D3E
	sub r4,r4,r0	; 02328D42
	ldrh r1,[r6,#0x0]	; 02328D44
	cmp r1,#0x0	; 02328D46
	beq loc_02328DBC	; 02328D48
loc_02328D4A:
	cmp r1,#0xa	; 02328D4A
	bne loc_02328D82	; 02328D4C
	add r0,r5,#0x0	; 02328D4E
	add r1,r6,#0x2	; 02328D50
	add r2,sp,#0x18	; 02328D52
	ldr r3,[sp,#0x40]	; 02328D54
	bl loc_02328C3C	; 02328D56
	mov r1,sp	; 02328D5A
	sub r1,r1,#0x4	; 02328D5C
	add r0,sp,#0x30	; 02328D5E
	ldrh r0,[r0,#0x8]	; 02328D60
	strh r0,[r1,#0x0]	; 02328D62
	ldmia r1!,{r0}	; 02328D64
	ldr r1,[sp,#0x18]	; 02328D66
	bl loc_02328DC8	; 02328D68
	ldr r1,[sp,#0xc]	; 02328D6C
	sub r4,r1,r0	; 02328D6E
	ldrh r0,[r5,#0x16]	; 02328D70
	lsl r0,r0,#0x16	; 02328D72
	lsr r1,r0,#0x1b	; 02328D74
	ldr r0,[sp,#0x44]	; 02328D76
	add r1,r1,r0	; 02328D78
	ldr r0,[sp,#0x10]	; 02328D7A
	add r0,r0,r1	; 02328D7C
	str r0,[sp,#0x10]	; 02328D7E
	b loc_02328DB4	; 02328D80
loc_02328D82:
	cmp r1,#0xd	; 02328D82
	beq loc_02328DB4	; 02328D84
	add r0,r5,#0x0	; 02328D86
	bl loc_02328F60	; 02328D88
	lsl r0,r0,#0x10	; 02328D8C
	lsr r0,r0,#0x10	; 02328D8E
	lsl r7,r0,#0x1	; 02328D90
	str r0,[sp,#0x0]	; 02328D92
	ldr r0,[sp,#0x4c]	; 02328D94
	str r0,[sp,#0x4]	; 02328D96
	add r0,r5,#0x0	; 02328D98
	ldr r1,[sp,#0x8]	; 02328D9A
	ldr r2,[r5,#0xc]	; 02328D9C
	ldrb r2,[r2,r7]	; 02328D9E
	sub r2,r4,r2	; 02328DA0
	ldr r3,[sp,#0x10]	; 02328DA2
	bl loc_02328DFC	; 02328DA4
	ldr r0,[r5,#0xc]	; 02328DA8
	add r0,r0,r7	; 02328DAA
	ldrb r1,[r0,#0x1]	; 02328DAC
	ldr r0,[sp,#0x40]	; 02328DAE
	add r0,r0,r1	; 02328DB0
	add r4,r4,r0	; 02328DB2
loc_02328DB4:
	add r6,r6,#0x2	; 02328DB4
	ldrh r1,[r6,#0x0]	; 02328DB6
	cmp r1,#0x0	; 02328DB8
	bne loc_02328D4A	; 02328DBA
loc_02328DBC:
	add sp,#0x1c	; 02328DBC
	pop {r4,r5,r6,r7}	; 02328DBE
	pop {r3}	; 02328DC0
	add sp,#0x10	; 02328DC2
	bx r3	; 02328DC4
	.byte 0x00, 0x00	; 02328DC8

; ===== function loc_02328DC8 =====
loc_02328DC8:
	push {r0,r1,r2,r3}	; 02328DC8
	push {lr}	; 02328DCA
	sub sp,#0x4	; 02328DCC
	add r0,sp,#0x8	; 02328DCE
	ldrh r0,[r0,#0x0]	; 02328DD0
	lsl r0,r0,#0x10	; 02328DD2
	lsr r0,r0,#0x1e	; 02328DD4
	cmp r0,#0x1	; 02328DD6
	bne loc_02328DEA	; 02328DD8
	add r0,r1,#0x1	; 02328DDA
	mov r1,#0x2	; 02328DDC
	blx P1_SignedDivMod	; 02328DDE
	add sp,#0x4	; 02328DE2
	pop {r3}	; 02328DE4
	add sp,#0x10	; 02328DE6
	bx r3	; 02328DE8
loc_02328DEA:
	cmp r0,#0x2	; 02328DEA
	beq loc_02328DF0	; 02328DEC
	mov r1,#0x0	; 02328DEE
loc_02328DF0:
	add r0,r1,#0x0	; 02328DF0
	add sp,#0x4	; 02328DF2
	pop {r3}	; 02328DF4
	add sp,#0x10	; 02328DF6
	bx r3	; 02328DF8
	.byte 0x00, 0x00	; 02328DFC

; ===== function loc_02328DFC =====
loc_02328DFC:
	push {r4,r5,r6,r7,lr}	; 02328DFC
	sub sp,#0x2c	; 02328DFE
	str r1,[sp,#0x0]	; 02328E00
	str r2,[sp,#0x4]	; 02328E02
	str r3,[sp,#0x8]	; 02328E04
	ldr r1,[sp,#0x44]	; 02328E06
	str r1,[sp,#0x44]	; 02328E08
	mov r5,#0x0	; 02328E0A
	add r4,r5,#0x0	; 02328E0C
	ldrh r2,[r0,#0x16]	; 02328E0E
	add r1,sp,#0x24	; 02328E10
	strh r2,[r1,#0x0]	; 02328E12
	ldr r2,[r0,#0x0]	; 02328E14
	mov r3,#0x14	; 02328E16
	ldrsh r3,[r0,r3]	; 02328E18
	add r0,sp,#0x30	; 02328E1A
	ldrh r0,[r0,#0x10]	; 02328E1C
	mul r3,r0	; 02328E1E
	lsl r0,r3,#0x1	; 02328E20
	add r7,r2,r0	; 02328E22
	str r5,[sp,#0xc]	; 02328E24
	ldrh r1,[r1,#0x0]	; 02328E26
	lsl r0,r1,#0x16	; 02328E28
	lsr r0,r0,#0x1b	; 02328E2A
	str r0,[sp,#0x14]	; 02328E2C
	cmp r0,#0x0	; 02328E2E
	ble loc_02328E90	; 02328E30
	lsl r0,r1,#0x1b	; 02328E32
	lsr r0,r0,#0x1b	; 02328E34
	str r0,[sp,#0x10]	; 02328E36
	str r5,[sp,#0x20]	; 02328E38
	str r5,[sp,#0x1c]	; 02328E3A
loc_02328E3C:
	ldr r6,[sp,#0x1c]	; 02328E3C
	ldr r0,[sp,#0x10]	; 02328E3E
	cmp r0,#0x0	; 02328E40
	ble loc_02328E84	; 02328E42
	ldr r1,[sp,#0x8]	; 02328E44
	ldr r0,[sp,#0xc]	; 02328E46
	add r0,r1,r0	; 02328E48
	str r0,[sp,#0x18]	; 02328E4A
loc_02328E4C:
	cmp r4,#0x0	; 02328E4C
	bne loc_02328E52	; 02328E4E
	ldrh r5,[r7,#0x0]	; 02328E50
loc_02328E52:
	add r1,r5,#0x0	; 02328E52
	mov r0,#0x1	; 02328E54
	and r1,r0	; 02328E56
	cmp r1,#0x0	; 02328E58
	bne loc_02328E6A	; 02328E5A
	ldr r0,[sp,#0x0]	; 02328E5C
	ldr r1,[sp,#0x4]	; 02328E5E
	add r1,r1,r6	; 02328E60
	ldr r2,[sp,#0x18]	; 02328E62
	ldr r3,[sp,#0x44]	; 02328E64
	bl loc_02328ECC	; 02328E66
loc_02328E6A:
	lsl r0,r5,#0xf	; 02328E6A
	lsr r5,r0,#0x10	; 02328E6C
	add r0,r4,#0x1	; 02328E6E
	lsl r0,r0,#0x10	; 02328E70
	lsr r4,r0,#0x10	; 02328E72
	cmp r4,#0xf	; 02328E74
	bls loc_02328E7C	; 02328E76
	ldr r4,[sp,#0x20]	; 02328E78
	add r7,r7,#0x2	; 02328E7A
loc_02328E7C:
	add r6,r6,#0x1	; 02328E7C
	ldr r0,[sp,#0x10]	; 02328E7E
	cmp r6,r0	; 02328E80
	blt loc_02328E4C	; 02328E82
loc_02328E84:
	ldr r0,[sp,#0xc]	; 02328E84
	add r1,r0,#0x1	; 02328E86
	str r1,[sp,#0xc]	; 02328E88
	ldr r0,[sp,#0x14]	; 02328E8A
	cmp r1,r0	; 02328E8C
	blt loc_02328E3C	; 02328E8E
loc_02328E90:
	add sp,#0x2c	; 02328E90
	pop {r4,r5,r6,r7}	; 02328E92
	pop {r3}	; 02328E94
	bx r3	; 02328E96

; ===== function loc_02328E98 =====
P1_Entry_02328E98:
	push {r4,r5,r6,r7,lr}	; 02328E98
	sub sp,#0xc	; 02328E9A
	add r5,r0,#0x0	; 02328E9C
	add r4,r1,#0x0	; 02328E9E
	add r6,r2,#0x0	; 02328EA0
	add r7,r3,#0x0	; 02328EA2
	add r1,sp,#0x10	; 02328EA4
	ldrh r1,[r1,#0x10]	; 02328EA6
	bl loc_02328F60	; 02328EA8
	lsl r0,r0,#0x10	; 02328EAC
	lsr r0,r0,#0x10	; 02328EAE
	str r0,[sp,#0x0]	; 02328EB0
	ldr r0,[sp,#0x24]	; 02328EB2
	str r0,[sp,#0x4]	; 02328EB4
	add r0,r5,#0x0	; 02328EB6
	add r1,r4,#0x0	; 02328EB8
	add r2,r6,#0x0	; 02328EBA
	add r3,r7,#0x0	; 02328EBC
	bl loc_02328DFC	; 02328EBE
	add sp,#0xc	; 02328EC2
	pop {r4,r5,r6,r7}	; 02328EC4
	pop {r3}	; 02328EC6
	bx r3	; 02328EC8
	.byte 0x00, 0x00	; 02328ECC

; ===== function loc_02328ECC =====
loc_02328ECC:
	push {r4,lr}	; 02328ECC
	ldrh r4,[r0,#0x8]	; 02328ECE
	cmp r4,#0x0	; 02328ED0
	bne loc_02328ED8	; 02328ED2
	bl loc_02328EE0	; 02328ED4
loc_02328ED8:
	pop {r4}	; 02328ED8
	pop {r3}	; 02328EDA
	bx r3	; 02328EDC
	.byte 0x00, 0x00	; 02328EE0

; ===== function loc_02328EE0 =====
loc_02328EE0:
	push {r4,r5,r6,r7}	; 02328EE0
	sub sp,#0x18	; 02328EE2
	add r4,r0,#0x0	; 02328EE4
	add r0,r1,#0x0	; 02328EE6
	add r5,r2,#0x0	; 02328EE8
	str r3,[sp,#0x0]	; 02328EEA
	asr r3,r0,#0x3	; 02328EEC
	asr r7,r5,#0x3	; 02328EEE
	mov r2,#0x3	; 02328EF0
	str r1,[sp,#0x10]	; 02328EF2
	and r1,r2	; 02328EF4
	str r1,[sp,#0x10]	; 02328EF6
	asr r2,r0,#0x2	; 02328EF8
	mov r1,#0x1	; 02328EFA
	and r2,r1	; 02328EFC
	mov r6,#0x7	; 02328EFE
	add r1,r5,#0x0	; 02328F00
	str r1,[sp,#0x4]	; 02328F02
	and r1,r6	; 02328F04
	str r1,[sp,#0x4]	; 02328F06
	ldrh r1,[r4,#0x4]	; 02328F08
	str r1,[sp,#0x8]	; 02328F0A
	lsl r1,r1,#0x4	; 02328F0C
	asr r1,r1,#0x3	; 02328F0E
	ldr r6,[r4,#0x0]	; 02328F10
	str r6,[sp,#0xc]	; 02328F12
	cmp r0,#0x0	; 02328F14
	blt loc_02328F58	; 02328F16
	ldr r6,[sp,#0x8]	; 02328F18
	cmp r0,r6	; 02328F1A
	bge loc_02328F58	; 02328F1C
	cmp r5,#0x0	; 02328F1E
	blt loc_02328F58	; 02328F20
	ldrh r0,[r4,#0x6]	; 02328F22
	cmp r5,r0	; 02328F24
	bge loc_02328F58	; 02328F26
	lsl r0,r3,#0x4	; 02328F28
	mul r1,r7	; 02328F2A
	add r0,r0,r1	; 02328F2C
	lsl r1,r0,#0x1	; 02328F2E
	ldr r0,[sp,#0xc]	; 02328F30
	add r4,r0,r1	; 02328F32
	ldr r0,[sp,#0x4]	; 02328F34
	lsl r0,r0,#0x1	; 02328F36
	add r0,r2,r0	; 02328F38
	lsl r3,r0,#0x1	; 02328F3A
	ldr r0,[sp,#0x10]	; 02328F3C
	lsl r2,r0,#0x2	; 02328F3E
	ldrh r1,[r4,r3]	; 02328F40
	mov r0,#0xf	; 02328F42
	add r5,r0,#0x0	; 02328F44
	lsl r5,r2	; 02328F46
	bic r1,r5	; 02328F48
	ldr r5,[sp,#0x0]	; 02328F4A
	lsl r5,r5,#0x18	; 02328F4C
	lsr r5,r5,#0x18	; 02328F4E
	and r5,r0	; 02328F50
	lsl r5,r2	; 02328F52
	orr r1,r5	; 02328F54
	strh r1,[r4,r3]	; 02328F56
loc_02328F58:
	add sp,#0x18	; 02328F58
	pop {r4,r5,r6,r7}	; 02328F5A
	bx lr	; 02328F5C
	.byte 0x00, 0x00	; 02328F60

; ===== function loc_02328F60 =====
loc_02328F60:
	push {r4,r5,r6,r7,lr}	; 02328F60
	sub sp,#0x14	; 02328F62
	str r0,[sp,#0x8]	; 02328F64
	add r6,r1,#0x0	; 02328F66
	mov r5,#0x0	; 02328F68
	add r7,r5,#0x0	; 02328F6A
	ldrh r0,[r0,#0x1a]	; 02328F6C
	str r0,[sp,#0xc]	; 02328F6E
	cmp r0,#0x0	; 02328F70
	ble loc_02328FB2	; 02328F72
	ldr r0,[sp,#0x8]	; 02328F74
	ldr r2,[r0,#0x8]	; 02328F76
	add r4,r2,#0x0	; 02328F78
	add r3,r5,#0x0	; 02328F7A
loc_02328F7C:
	ldrh r0,[r4,#0x0]	; 02328F7C
	cmp r0,r6	; 02328F7E
	bhi loc_02328F9A	; 02328F80
	add r0,r2,r3	; 02328F82
	ldrh r0,[r0,#0x2]	; 02328F84
	cmp r6,r0	; 02328F86
	bhi loc_02328F9A	; 02328F88
	add r1,r5,r6	; 02328F8A
	lsl r0,r7,#0x2	; 02328F8C
	ldrh r0,[r2,r0]	; 02328F8E
	sub r0,r1,r0	; 02328F90
	add sp,#0x14	; 02328F92
	pop {r4,r5,r6,r7}	; 02328F94
	pop {r3}	; 02328F96
	bx r3	; 02328F98
loc_02328F9A:
	add r0,r2,r3	; 02328F9A
	ldrh r1,[r0,#0x2]	; 02328F9C
	ldrh r0,[r2,r3]	; 02328F9E
	sub r0,r1,r0	; 02328FA0
	add r0,r0,#0x1	; 02328FA2
	add r5,r5,r0	; 02328FA4
	add r4,r4,#0x4	; 02328FA6
	add r3,r3,#0x4	; 02328FA8
	add r7,r7,#0x1	; 02328FAA
	ldr r0,[sp,#0xc]	; 02328FAC
	cmp r7,r0	; 02328FAE
	blt loc_02328F7C	; 02328FB0
loc_02328FB2:
	lsl r0,r5,#0x10	; 02328FB2
	lsr r0,r0,#0x10	; 02328FB4
	str r0,[sp,#0x0]	; 02328FB6
	ldr r0,[sp,#0x8]	; 02328FB8
	ldrh r0,[r0,#0x12]	; 02328FBA
	str r0,[sp,#0x4]	; 02328FBC
	add r0,r6,#0x0	; 02328FBE
	mov r1,#0x0	; 02328FC0
	ldr r2,[sp,#0x8]	; 02328FC2
	ldrh r2,[r2,#0x18]	; 02328FC4
	sub r2,r2,#0x1	; 02328FC6
	ldr r3,[sp,#0x8]	; 02328FC8
	ldr r3,[r3,#0x4]	; 02328FCA
	bl loc_02328FD8	; 02328FCC
	add sp,#0x14	; 02328FD0
	pop {r4,r5,r6,r7}	; 02328FD2
	pop {r3}	; 02328FD4
	bx r3	; 02328FD6

; ===== function loc_02328FD8 =====
loc_02328FD8:
	push {r4,r5}	; 02328FD8
	cmp r1,r2	; 02328FDA
	bgt loc_02329008	; 02328FDC
loc_02328FDE:
	sub r4,r2,r1	; 02328FDE
	asr r4,r4,#0x1	; 02328FE0
	add r4,r1,r4	; 02328FE2
	lsl r5,r4,#0x1	; 02328FE4
	ldrh r5,[r3,r5]	; 02328FE6
	cmp r5,r0	; 02328FE8
	bls loc_02328FF0	; 02328FEA
	sub r2,r4,#0x1	; 02328FEC
	b loc_02329004	; 02328FEE
loc_02328FF0:
	cmp r5,r0	; 02328FF0
	bcs loc_02328FF8	; 02328FF2
	add r1,r4,#0x1	; 02328FF4
	b loc_02329004	; 02328FF6
loc_02328FF8:
	ldr r0,[pool_02329014]	; 02328FF8
	add r0,sp	; 02328FFA
	ldrh r0,[r0,#0x10]	; 02328FFC
	add r0,r0,r4	; 02328FFE
	pop {r4,r5}	; 02329000
	bx lr	; 02329002
loc_02329004:
	cmp r1,r2	; 02329004
	ble loc_02328FDE	; 02329006
loc_02329008:
	ldr r0,[pool_02329014]	; 02329008
	add r0,sp	; 0232900A
	ldrh r0,[r0,#0x14]	; 0232900C
	pop {r4,r5}	; 0232900E
	bx lr	; 02329010
	.byte 0xC0, 0x46	; 02329014
pool_02329014:
loc_02329014:
	.word 0xFFFFFFF8	; 02329014

; ===== function loc_02329018 =====
loc_02329018:
	str r1,[r0,#0x0]	; 02329018
	strh r2,[r0,#0x4]	; 0232901A
	strh r3,[r0,#0x6]	; 0232901C
	ldr r1,[sp,#0x0]	; 0232901E
	strh r1,[r0,#0x8]	; 02329020
	ldr r1,[sp,#0x4]	; 02329022
	str r1,[r0,#0xc]	; 02329024
	bx lr	; 02329026

; ===== function loc_02329028 =====
loc_02329028:
	push {r4}	; 02329028
	sub sp,#0x4	; 0232902A
	ldrh r3,[r1,#0x6]	; 0232902C
	strh r3,[r0,#0x10]	; 0232902E
	ldrh r3,[r1,#0x8]	; 02329030
	strh r3,[r0,#0x16]	; 02329032
	add r1,#0xa	; 02329034
	str r1,[r0,#0xc]	; 02329036
	ldr r3,[r0,#0xc]	; 02329038
	ldrh r1,[r0,#0x10]	; 0232903A
	lsl r1,r1,#0x1	; 0232903C
	add r1,r3,r1	; 0232903E
	str r1,[r0,#0x0]	; 02329040
	ldrh r1,[r0,#0x16]	; 02329042
	lsl r3,r1,#0x1b	; 02329044
	lsr r3,r3,#0x1b	; 02329046
	lsl r1,r1,#0x16	; 02329048
	lsr r1,r1,#0x1b	; 0232904A
	mul r3,r1	; 0232904C
	add r3,#0xf	; 0232904E
	asr r1,r3,#0x4	; 02329050
	strh r1,[r0,#0x14]	; 02329052
	mov r1,#0x0	; 02329054
	strh r1,[r0,#0x12]	; 02329056
	ldr r3,[r0,#0x1c]	; 02329058
	mov r1,#0x1	; 0232905A
	bic r3,r1	; 0232905C
	orr r3,r1	; 0232905E
	str r3,[r0,#0x1c]	; 02329060
	ldr r3,[r0,#0x1c]	; 02329062
	mov r1,#0x2	; 02329064
	orr r3,r1	; 02329066
	str r3,[r0,#0x1c]	; 02329068
	add r4,r2,#0x0	; 0232906A
	add r4,#0x8	; 0232906C
	ldr r1,[r4,#0x4]	; 0232906E
	add r1,r2,r1	; 02329070
	ldrh r1,[r1,#0x8]	; 02329072
	strh r1,[r0,#0x18]	; 02329074
	add r3,r2,#0x0	; 02329076
	add r3,#0xc	; 02329078
	ldr r1,[r4,#0x4]	; 0232907A
	add r1,r3,r1	; 0232907C
	str r1,[r0,#0x4]	; 0232907E
	ldr r1,[r2,#0x8]	; 02329080
	add r1,r2,r1	; 02329082
	ldrh r1,[r1,#0x8]	; 02329084
	strh r1,[r0,#0x1a]	; 02329086
	add r3,r2,#0x0	; 02329088
	add r3,#0xa	; 0232908A
	ldr r1,[r2,#0x8]	; 0232908C
	add r1,r3,r1	; 0232908E
	str r1,[r0,#0x8]	; 02329090
	add sp,#0x4	; 02329092
	pop {r4}	; 02329094
	bx lr	; 02329096

; ===== function loc_02329098 =====
loc_02329098:
	push {r0,r1,r2,r3}	; 02329098
	push {r4,lr}	; 0232909A
	add r2,sp,#0x8	; 0232909C
	mov r0,#0x0	; 0232909E
	ldrsh r0,[r2,r0]	; 023290A0
	lsl r0,r0,#0x14	; 023290A2
	asr r4,r0,#0x14	; 023290A4
	ldrh r0,[r2,#0x0]	; 023290A6
	lsl r0,r0,#0x12	; 023290A8
	lsr r0,r0,#0x1e	; 023290AA
	cmp r0,#0x1	; 023290AC
	beq loc_023290B6	; 023290AE
	cmp r0,#0x2	; 023290B0
	beq loc_023290C2	; 023290B2
	b loc_023290C4	; 023290B4
loc_023290B6:
	add r0,r1,#0x1	; 023290B6
	mov r1,#0x2	; 023290B8
	blx P1_SignedDivMod	; 023290BA
	sub r4,r4,r0	; 023290BE
	b loc_023290C4	; 023290C0
loc_023290C2:
	sub r4,r4,r1	; 023290C2
loc_023290C4:
	add r0,r4,#0x0	; 023290C4
	pop {r4}	; 023290C6
	pop {r3}	; 023290C8
	add sp,#0x10	; 023290CA
	bx r3	; 023290CC
	.byte 0x00, 0x00	; 023290D0

; ===== function loc_023290D0 =====
loc_023290D0:
	push {r0,r1,r2,r3}	; 023290D0
	push {r4,lr}	; 023290D2
	add r2,sp,#0x8	; 023290D4
	mov r0,#0x0	; 023290D6
	ldrsh r0,[r2,r0]	; 023290D8
	lsl r0,r0,#0x14	; 023290DA
	asr r4,r0,#0x14	; 023290DC
	ldrh r0,[r2,#0x0]	; 023290DE
	lsl r0,r0,#0x12	; 023290E0
	lsr r0,r0,#0x1e	; 023290E2
	cmp r0,#0x1	; 023290E4
	beq loc_023290EE	; 023290E6
	cmp r0,#0x2	; 023290E8
	beq loc_023290FA	; 023290EA
	b loc_023290FC	; 023290EC
loc_023290EE:
	add r0,r1,#0x1	; 023290EE
	mov r1,#0x2	; 023290F0
	blx P1_SignedDivMod	; 023290F2
	sub r4,r4,r0	; 023290F6
	b loc_023290FC	; 023290F8
loc_023290FA:
	sub r4,r4,r1	; 023290FA
loc_023290FC:
	add r0,r4,#0x0	; 023290FC
	pop {r4}	; 023290FE
	pop {r3}	; 02329100
	add sp,#0x10	; 02329102
	bx r3	; 02329104
	.byte 0x00, 0x00	; 02329108

; ===== function loc_02329108 =====
loc_02329108:
	push {r4,r5,lr}	; 02329108
	sub sp,#0x14	; 0232910A
	add r4,r0,#0x0	; 0232910C
	add r3,r1,#0x0	; 0232910E
	mov r0,#0x4	; 02329110
	ldrsb r0,[r3,r0]	; 02329112
	str r0,[sp,#0x0]	; 02329114
	mov r0,#0x5	; 02329116
	ldrsb r0,[r3,r0]	; 02329118
	str r0,[sp,#0x4]	; 0232911A
	str r2,[sp,#0x8]	; 0232911C
	ldrb r0,[r3,#0x6]	; 0232911E
	str r0,[sp,#0xc]	; 02329120
	ldr r1,[r4,#0xc]	; 02329122
	ldrh r0,[r3,#0x6]	; 02329124
	lsl r0,r0,#0x10	; 02329126
	lsr r0,r0,#0x1c	; 02329128
	lsl r0,r0,#0x5	; 0232912A
	add r0,r1,r0	; 0232912C
	add r1,r4,#0x0	; 0232912E
	mov r4,sp	; 02329130
	sub r4,r4,#0x4	; 02329132
	ldrh r2,[r3,#0x0]	; 02329134
	strh r2,[r4,#0x0]	; 02329136
	add r5,r4,#0x0	; 02329138
	ldmia r5!,{r2}	; 0232913A
	ldrh r3,[r3,#0x2]	; 0232913C
	strh r3,[r4,#0x0]	; 0232913E
	ldmia r4!,{r3}	; 02329140
	bl loc_02328CB8	; 02329142
	add sp,#0x14	; 02329146
	pop {r4,r5}	; 02329148
	pop {r3}	; 0232914A
	bx r3	; 0232914C
	.byte 0x00, 0x00	; 02329150

; ===== function loc_02329150 =====
loc_02329150:
	push {r4,r5,r6,r7,lr}	; 02329150
	sub sp,#0x4	; 02329152
	add r7,r0,#0x0	; 02329154
	str r1,[sp,#0x0]	; 02329156
	ldrh r6,[r1,#0x6]	; 02329158
	lsl r4,r1,#0	; 0232915A
	add r4,#0x8	; 0232915C
	mov r5,#0x0	; 0232915E
	cmp r6,#0x0	; 02329160
	ble loc_0232917E	; 02329162
loc_02329164:
	ldr r3,[r4,#0x8]	; 02329164
	cmp r3,#0x0	; 02329166
	beq loc_02329176	; 02329168
	add r0,r7,#0x0	; 0232916A
	add r1,r4,#0x0	; 0232916C
	ldr r2,[sp,#0x0]	; 0232916E
	add r2,r2,r3	; 02329170
	bl loc_02329108	; 02329172
loc_02329176:
	add r4,#0xc	; 02329176
	add r5,r5,#0x1	; 02329178
	cmp r5,r6	; 0232917A
	blt loc_02329164	; 0232917C
loc_0232917E:
	add sp,#0x4	; 0232917E
	pop {r4,r5,r6,r7}	; 02329180
	pop {r3}	; 02329182
	bx r3	; 02329184
	.byte 0x00, 0x00	; 02329188

; ===== function loc_02329188 =====
loc_02329188:
	ldrh r2,[r0,#0x6]	; 02329188
	add r0,#0x8	; 0232918A
	cmp r1,#0x0	; 0232918C
	blt loc_02329194	; 0232918E
	cmp r1,r2	; 02329190
	blt loc_02329198	; 02329192
loc_02329194:
	mov r0,#0x0	; 02329194
	bx lr	; 02329196
loc_02329198:
	mov r2,#0xc	; 02329198
	mul r1,r2	; 0232919A
	add r0,r0,r1	; 0232919C
	bx lr	; 0232919E

; ===== function loc_023291A0 =====
loc_023291A0:
	ldr r2,[r0,#0x8]	; 023291A0
	add r2,r0,r2	; 023291A2
	mov r0,#0x6	; 023291A4
	mul r1,r0	; 023291A6
	add r0,r2,r1	; 023291A8
	bx lr	; 023291AA

; ===== function loc_023291AC =====
loc_023291AC:
	ldr r0,[r0,#0x14]	; 023291AC
	bx lr	; 023291AE

; ===== function loc_023291B0 =====
loc_023291B0:
	ldr r1,[r0,#0x10]	; 023291B0
	add r0,r0,r1	; 023291B2
	bx lr	; 023291B4
	.byte 0x00, 0x00	; 023291B8

; ===== function loc_023291B8 =====
loc_023291B8:
	ldr r2,[r0,#0xc]	; 023291B8
	add r2,r0,r2	; 023291BA
	ldr r3,[r0,#0x8]	; 023291BC
	add r3,r0,r3	; 023291BE
	mov r0,#0x6	; 023291C0
	mul r1,r0	; 023291C2
	add r0,r3,r1	; 023291C4
	ldrh r1,[r0,#0x2]	; 023291C6
	mov r0,#0xc	; 023291C8
	mul r1,r0	; 023291CA
	add r0,r2,r1	; 023291CC
	bx lr	; 023291CE

; ===== function loc_023291D0 =====
loc_023291D0:
	ldr r2,[r0,#0x8]	; 023291D0
	add r2,r0,r2	; 023291D2
	mov r0,#0x6	; 023291D4
	mul r1,r0	; 023291D6
	add r0,r2,r1	; 023291D8
	ldrh r0,[r0,#0x4]	; 023291DA
	bx lr	; 023291DC
	.byte 0x00, 0x00	; 023291E0

; ===== function loc_023291E0 =====
loc_023291E0:
	push {r4,r5,r6,r7,lr}	; 023291E0
	sub sp,#0xc	; 023291E2
	str r0,[sp,#0x0]	; 023291E4
	add r7,r1,#0x0	; 023291E6
	str r2,[sp,#0x4]	; 023291E8
	lsl r4,r0,#0	; 023291EA
	add r4,#0x8	; 023291EC
	mov r5,#0x0	; 023291EE
	bl loc_0232928C	; 023291F0
	cmp r0,#0x0	; 023291F4
	ble loc_0232924E	; 023291F6
loc_023291F8:
	mov r1,sp	; 023291F8
	sub r1,r1,#0x4	; 023291FA
	ldrh r0,[r4,#0x0]	; 023291FC
	strh r0,[r1,#0x0]	; 023291FE
	ldmia r1!,{r0}	; 02329200
	ldrb r1,[r4,#0x4]	; 02329202
	bl loc_023290D0	; 02329204
	add r6,r0,#0x0	; 02329208
	mov r1,sp	; 0232920A
	sub r1,r1,#0x4	; 0232920C
	ldrh r0,[r4,#0x2]	; 0232920E
	strh r0,[r1,#0x0]	; 02329210
	ldmia r1!,{r0}	; 02329212
	ldrb r1,[r4,#0x5]	; 02329214
	bl loc_02329098	; 02329216
	ldrb r1,[r4,#0x4]	; 0232921A
	add r2,r6,r1	; 0232921C
	ldrb r1,[r4,#0x5]	; 0232921E
	add r1,r0,r1	; 02329220
	cmp r6,r7	; 02329222
	bgt loc_02329240	; 02329224
	cmp r7,r2	; 02329226
	bgt loc_02329240	; 02329228
	ldr r2,[sp,#0x4]	; 0232922A
	cmp r0,r2	; 0232922C
	bgt loc_02329240	; 0232922E
	lsl r0,r2,#0	; 02329230
	cmp r0,r1	; 02329232
	bgt loc_02329240	; 02329234
	add r0,r5,#0x0	; 02329236
	add sp,#0xc	; 02329238
	pop {r4,r5,r6,r7}	; 0232923A
	pop {r3}	; 0232923C
	bx r3	; 0232923E
loc_02329240:
	add r5,r5,#0x1	; 02329240
	add r4,r4,#0x6	; 02329242
	ldr r0,[sp,#0x0]	; 02329244
	bl loc_0232928C	; 02329246
	cmp r5,r0	; 0232924A
	blt loc_023291F8	; 0232924C
loc_0232924E:
	mov r0,#0x0	; 0232924E
	mvn r0,r0	; 02329250
	add sp,#0xc	; 02329252
	pop {r4,r5,r6,r7}	; 02329254
	pop {r3}	; 02329256
	bx r3	; 02329258
	.byte 0x00, 0x00	; 0232925C

; ===== function loc_0232925C =====
loc_0232925C:
	push {r4,r5,lr}	; 0232925C
	sub sp,#0x4	; 0232925E
	add r5,r1,#0x0	; 02329260
	add r4,r0,#0x0	; 02329262
	add r4,#0x8	; 02329264
	cmp r5,#0x0	; 02329266
	blt loc_02329272	; 02329268
	bl loc_0232928C	; 0232926A
	cmp r5,r0	; 0232926E
	blt loc_0232927C	; 02329270
loc_02329272:
	mov r0,#0x0	; 02329272
	add sp,#0x4	; 02329274
	pop {r4,r5}	; 02329276
	pop {r3}	; 02329278
	bx r3	; 0232927A
loc_0232927C:
	mov r0,#0x6	; 0232927C
	mul r5,r0	; 0232927E
	add r0,r4,r5	; 02329280
	add sp,#0x4	; 02329282
	pop {r4,r5}	; 02329284
	pop {r3}	; 02329286
	bx r3	; 02329288
	.byte 0x00, 0x00	; 0232928C

; ===== function loc_0232928C =====
loc_0232928C:
	ldrh r0,[r0,#0x6]	; 0232928C
	bx lr	; 0232928E

; ===== function loc_02329290 =====
loc_02329290:
	push {r4,r5,r6,r7,lr}	; 02329290
	sub sp,#0x14	; 02329292
	str r0,[sp,#0x0]	; 02329294
	str r1,[sp,#0x4]	; 02329296
	str r2,[sp,#0x8]	; 02329298
	str r3,[sp,#0xc]	; 0232929A
	lsl r0,r2,#0	; 0232929C
	lsr r6,r0,#0x1	; 0232929E
	mov r5,#0x0	; 023292A0
	add r4,sp,#0x10	; 023292A2
	ldr r1,[pool_023293D0]	; 023292A4
	ldr r7,[pool_023293D4]	; 023292A6
loc_023292A8:
	add r0,r5,r6	; 023292A8
	sub r0,r0,#0x2	; 023292AA
	lsl r3,r0,#0x1	; 023292AC
	ldr r0,[sp,#0x0]	; 023292AE
	ldrsh r2,[r0,r3]	; 023292B0
	ldr r0,[sp,#0x4]	; 023292B2
	ldrsh r0,[r0,r3]	; 023292B4
	sub r0,r2,r0	; 023292B6
	cmp r0,r1	; 023292B8
	bge loc_023292C0	; 023292BA
	add r0,r1,#0x0	; 023292BC
	b loc_023292C6	; 023292BE
loc_023292C0:
	cmp r0,r7	; 023292C0
	blt loc_023292C6	; 023292C2
	ldr r0,[pool_023293D8]	; 023292C4
loc_023292C6:
	strh r0,[r4,#0x0]	; 023292C6
	add r4,r4,#0x2	; 023292C8
	add r5,r5,#0x1	; 023292CA
	cmp r5,#0x2	; 023292CC
	blt loc_023292A8	; 023292CE
	sub r0,r6,#0x1	; 023292D0
	cmp r0,#0x2	; 023292D2
	blt loc_0232934E	; 023292D4
	lsl r3,r0,#0x1	; 023292D6
	ldr r1,[sp,#0x0]	; 023292D8
	add r2,r1,r3	; 023292DA
	ldr r1,[sp,#0x4]	; 023292DC
	add r1,r1,r3	; 023292DE
	ldr r7,[pool_023293D0]	; 023292E0
	mov r4,#0x0	; 023292E2
loc_023292E4:
	sub r3,r0,#0x2	; 023292E4
	lsl r6,r3,#0x1	; 023292E6
	ldr r3,[sp,#0x0]	; 023292E8
	ldrsh r5,[r3,r6]	; 023292EA
	ldr r3,[sp,#0x4]	; 023292EC
	ldrsh r3,[r3,r6]	; 023292EE
	sub r6,r5,r3	; 023292F0
	cmp r6,#0x0	; 023292F2
	blt loc_0232931E	; 023292F4
	ldrsh r3,[r2,r4]	; 023292F6
	add r5,r6,r3	; 023292F8
	ldr r3,[pool_023293D4]	; 023292FA
	cmp r5,r3	; 023292FC
	bge loc_02329306	; 023292FE
	lsl r3,r5,#0x10	; 02329300
	asr r3,r3,#0x10	; 02329302
	b loc_02329308	; 02329304
loc_02329306:
	ldr r3,[pool_023293D8]	; 02329306
loc_02329308:
	strh r3,[r2,#0x0]	; 02329308
	ldrsh r3,[r1,r4]	; 0232930A
	sub r3,r3,r6	; 0232930C
	cmp r3,r7	; 0232930E
	blt loc_02329318	; 02329310
	lsl r3,r3,#0x10	; 02329312
	asr r3,r3,#0x10	; 02329314
	b loc_0232931A	; 02329316
loc_02329318:
	add r3,r7,#0x0	; 02329318
loc_0232931A:
	strh r3,[r1,#0x0]	; 0232931A
	b loc_02329344	; 0232931C
loc_0232931E:
	ldrsh r3,[r2,r4]	; 0232931E
	add r3,r6,r3	; 02329320
	cmp r3,r7	; 02329322
	blt loc_0232932C	; 02329324
	lsl r3,r3,#0x10	; 02329326
	asr r3,r3,#0x10	; 02329328
	b loc_0232932E	; 0232932A
loc_0232932C:
	add r3,r7,#0x0	; 0232932C
loc_0232932E:
	strh r3,[r2,#0x0]	; 0232932E
	ldrsh r3,[r1,r4]	; 02329330
	sub r5,r3,r6	; 02329332
	ldr r3,[pool_023293D4]	; 02329334
	cmp r5,r3	; 02329336
	bge loc_02329340	; 02329338
	lsl r3,r5,#0x10	; 0232933A
	asr r3,r3,#0x10	; 0232933C
	b loc_02329342	; 0232933E
loc_02329340:
	ldr r3,[pool_023293D8]	; 02329340
loc_02329342:
	strh r3,[r1,#0x0]	; 02329342
loc_02329344:
	sub r2,r2,#0x2	; 02329344
	sub r1,r1,#0x2	; 02329346
	sub r0,r0,#0x1	; 02329348
	cmp r0,#0x2	; 0232934A
	bge loc_023292E4	; 0232934C
loc_0232934E:
	mov r1,#0x1	; 0232934E
	ldr r0,[sp,#0xc]	; 02329350
	add r4,r0,#0x4	; 02329352
	ldr r0,[sp,#0x0]	; 02329354
	add r3,r0,#0x2	; 02329356
	ldr r0,[sp,#0x4]	; 02329358
	add r2,r0,#0x2	; 0232935A
	ldr r0,[pool_023293D0]	; 0232935C
loc_0232935E:
	mov r5,#0x0	; 0232935E
	ldrsh r6,[r3,r5]	; 02329360
	ldr r5,[r4,#0xc]	; 02329362
	add r6,r6,r5	; 02329364
	cmp r6,r0	; 02329366
	bge loc_0232936E	; 02329368
	add r6,r0,#0x0	; 0232936A
	b loc_02329376	; 0232936C
loc_0232936E:
	ldr r5,[pool_023293D4]	; 0232936E
	cmp r6,r5	; 02329370
	blt loc_02329376	; 02329372
	ldr r6,[pool_023293D8]	; 02329374
loc_02329376:
	strh r6,[r3,#0x0]	; 02329376
	mov r5,#0x0	; 02329378
	ldrsh r6,[r2,r5]	; 0232937A
	ldr r5,[r4,#0xc]	; 0232937C
	sub r6,r6,r5	; 0232937E
	cmp r6,r0	; 02329380
	bge loc_02329388	; 02329382
	add r6,r0,#0x0	; 02329384
	b loc_02329390	; 02329386
loc_02329388:
	ldr r5,[pool_023293D4]	; 02329388
	cmp r6,r5	; 0232938A
	blt loc_02329390	; 0232938C
	ldr r6,[pool_023293D8]	; 0232938E
loc_02329390:
	strh r6,[r2,#0x0]	; 02329390
	sub r4,r4,#0x4	; 02329392
	sub r3,r3,#0x2	; 02329394
	sub r2,r2,#0x2	; 02329396
	sub r1,r1,#0x1	; 02329398
	cmp r1,#0x0	; 0232939A
	bge loc_0232935E	; 0232939C
	mov r3,#0x0	; 0232939E
	add r4,sp,#0x10	; 023293A0
	add r1,r3,#0x0	; 023293A2
loc_023293A4:
	ldrsh r2,[r4,r1]	; 023293A4
	ldr r0,[sp,#0xc]	; 023293A6
	str r2,[r0,#0xc]	; 023293A8
	add r4,r4,#0x2	; 023293AA
	add r0,r0,#0x4	; 023293AC
	str r0,[sp,#0xc]	; 023293AE
	add r3,r3,#0x1	; 023293B0
	cmp r3,#0x2	; 023293B2
	blt loc_023293A4	; 023293B4
	ldr r0,[sp,#0x0]	; 023293B6
	ldr r1,[sp,#0x8]	; 023293B8
	blx P1_CleanAndInvalidateDataCacheRange	; 023293BA
	ldr r0,[sp,#0x4]	; 023293BE
	ldr r1,[sp,#0x8]	; 023293C0
	blx P1_CleanAndInvalidateDataCacheRange	; 023293C2
	add sp,#0x14	; 023293C6
	pop {r4,r5,r6,r7}	; 023293C8
	pop {r3}	; 023293CA
	bx r3	; 023293CC
	.byte 0xC0, 0x46	; 023293D0
pool_023293D0:
loc_023293D0:
	.word 0xFFFF8000	; 023293D0
pool_023293D4:
loc_023293D4:
	.word 0x00008000	; 023293D4
pool_023293D8:
loc_023293D8:
	.word 0x00007FFF	; 023293D8

; ===== function loc_023293DC =====
	push {r4,r5,r6,r7,lr}	; 023293DC
; 已登记的双缓冲处理回调：先调度上下文的可选处理函数，再按模式继续处理。
; Registered two-buffer handler: call the context's optional worker, then continue by mode.
.func P1_RunDualBufferCallback
	sub sp,#0xc	; 023293DE
	add r7,r0,#0x0	; 023293E0
	str r1,[sp,#0x4]	; 023293E2
	str r2,[sp,#0x8]	; 023293E4
	ldr r4,[sp,#0x20]	; 023293E6
	ldr r6,[r4,#P1_DualBufferCallbackContextWorkerOffset]	; 023293E8
	cmp r6,#0x0	; 023293EA
	beq loc_023293F4	; 023293EC
	ldr r5,[r4,#P1_DualBufferCallbackContextArgumentOffset]	; 023293EE
	str r5,[sp,#0x0]	; 023293F0
	blx r6	; 023293F2
loc_023293F4:
	ldr r0,[r4,#P1_DualBufferCallbackContextModeOffset]	; 023293F4
	cmp r0,#0x0	; 023293F6
	beq loc_0232940A	; 023293F8
	cmp r0,#0x1	; 023293FA
	bne loc_0232940A	; 023293FC
	add r0,r7,#0x0	; 023293FE
	ldr r1,[sp,#0x4]	; 02329400
	ldr r2,[sp,#0x8]	; 02329402
	add r3,r4,#0x0	; 02329404
	bl loc_02329290	; 02329406
loc_0232940A:
	add sp,#0xc	; 0232940A
	pop {r4,r5,r6,r7}	; 0232940C
	pop {r3}	; 0232940E
	bx r3	; 02329410
	.byte 0x00, 0x00	; 02329414
.endfunc

; ===== function loc_02329414 =====
loc_02329414:
	push {lr}	; 02329414
	sub sp,#0x4	; 02329416
	ldr r0,[pool_02329430]	; 02329418
	ldr r0,[r0,#0x0]	; 0232941A
	cmp r0,#0x1	; 0232941C
	bne loc_02329426	; 0232941E
	mov r0,#0x0	; 02329420
	bl loc_0232DF7C	; 02329422
loc_02329426:
	bl P1_StopActiveDualBufferProcessor	; 02329426
	add sp,#0x4	; 0232942A
	pop {r3}	; 0232942C
	bx r3	; 0232942E
pool_02329430:
loc_02329430:
	.word P1_DualBufferCallbackContext	; 02329430

; ===== function loc_02329434 =====
loc_02329434:
	push {r4,r5,r6,lr}	; 02329434
; 清零初始工作区、记录启动模式，并建立双缓冲处理对象。
; Clear initial workspace, record the start mode, and create the two-buffer processor.
.func P1_StartDualBufferProcessor
	sub sp,#0x10	; 02329436
	add r5,r0,#0x0	; 02329438
	add r6,r1,#0x0	; 0232943A
	add r4,r2,#0x0	; 0232943C
	mov r1,#0x0	; 0232943E
	add r0,sp,#0xc	; 02329440
	strh r1,[r0,#0x0]	; 02329442
	ldrh r0,[r0,#0x0]	; 02329444
	ldr r1,[pool_0232947C]	; 02329446
	mov r2,#0xc0	; 02329448
	blx loc_0232DE08	; 0232944A
	ldr r0,[pool_02329480]	; 0232944E
	str r4,[r0,#0x0]	; 02329450
	cmp r4,#0x1	; 02329452
	bne loc_0232945C	; 02329454
	ldr r0,[pool_02329484]	; 02329456
	bl loc_0232DF7C	; 02329458
loc_0232945C:
	mov r0,#0x2	; 0232945C
	str r0,[sp,#0x0]	; 0232945E
	ldr r0,[pool_02329488]	; 02329460
	str r0,[sp,#0x4]	; 02329462
	ldr r0,[pool_02329480]	; 02329464
	str r0,[sp,#0x8]	; 02329466
	add r0,r5,#0x0	; 02329468
	add r1,r6,#0x0	; 0232946A
	mov r2,#0x0	; 0232946C
	ldr r3,[pool_0232948C]	; 0232946E
	bl P1_ConfigureDualBufferProcessor	; 02329470
	add sp,#0x10	; 02329474
	pop {r4,r5,r6}	; 02329476
	pop {r3}	; 02329478
	bx r3	; 0232947A
pool_0232947C:
.endfunc
loc_0232947C:
	.word 0x02356408	; 0232947C
pool_02329480:
loc_02329480:
	.word P1_DualBufferCallbackContext	; 02329480
pool_02329484:
loc_02329484:
	.word 0x00003000	; 02329484
pool_02329488:
loc_02329488:
	.word P1_RunDualBufferCallback + 1	; 02329488
pool_0232948C:
loc_0232948C:
	.word 0x00007D00	; 0232948C

; ===== function loc_02329490 =====
loc_02329490:
	mov r0,#0x1	; 02329490
	ldr r3,[pool_02329498]	; 02329492
	bx r3	; 02329494
	.byte 0xC0, 0x46	; 02329498
pool_02329498:
loc_02329498:
	.word loc_0232C734 + 1	; 02329498

; ===== function loc_0232949C =====
loc_0232949C:
	push {r4,r5,lr}	; 0232949C
	sub sp,#0x4	; 0232949E
	add r5,r0,#0x0	; 023294A0
	bl loc_02329490	; 023294A2
	cmp r0,#0x0	; 023294A6
	bne loc_023294B6	; 023294A8
	mov r0,#0x2	; 023294AA
	mvn r0,r0	; 023294AC
	add sp,#0x4	; 023294AE
	pop {r4,r5}	; 023294B0
	pop {r3}	; 023294B2
	bx r3	; 023294B4
loc_023294B6:
	bl loc_02329554	; 023294B6
	add r4,r0,#0x0	; 023294BA
	mov r0,#0x0	; 023294BC
	mvn r0,r0	; 023294BE
	cmp r4,r0	; 023294C0
	beq loc_023294DE	; 023294C2
	add r0,r5,#0x0	; 023294C4
	bl loc_02329510	; 023294C6
	lsl r0,r4,#0x10	; 023294CA
	lsr r0,r0,#0x10	; 023294CC
	bl loc_02329530	; 023294CE
	mov r1,#0x1	; 023294D2
	mvn r1,r1	; 023294D4
	cmp r0,r1	; 023294D6
	beq loc_023294DC	; 023294D8
	mov r1,#0x0	; 023294DA
loc_023294DC:
	add r0,r1,#0x0	; 023294DC
loc_023294DE:
	add sp,#0x4	; 023294DE
	pop {r4,r5}	; 023294E0
	pop {r3}	; 023294E2
	bx r3	; 023294E4
	.byte 0x00, 0x00	; 023294E8

; ===== function loc_023294E8 =====
loc_023294E8:
	push {lr}	; 023294E8
	sub sp,#0x4	; 023294EA
	mov r3,#0x0	; 023294EC
	ldr r2,[pool_0232950C]	; 023294EE
	add r0,r3,#0x0	; 023294F0
loc_023294F2:
	ldrsb r1,[r2,r0]	; 023294F2
	add r2,r2,#0x1	; 023294F4
	add r3,r3,#0x1	; 023294F6
	cmp r3,#0x13	; 023294F8
	bcc loc_023294F2	; 023294FA
	bl loc_0232C784	; 023294FC
	mov r0,#0x1	; 02329500
	bl loc_0232C704	; 02329502
	add sp,#0x4	; 02329506
	pop {r3}	; 02329508
	bx r3	; 0232950A
pool_0232950C:
loc_0232950C:
	.word P1_VibBuildIdentifier	; 0232950C

; ===== function loc_02329510 =====
loc_02329510:
	push {r4,lr}	; 02329510
	add r4,r0,#0x0	; 02329512
	bl loc_02329490	; 02329514
	cmp r0,#0x1	; 02329518
	bne loc_02329524	; 0232951A
	mov r0,#0x1	; 0232951C
	and r4,r0	; 0232951E
	ldr r0,[pool_0232952C]	; 02329520
	strh r4,[r0,#0x0]	; 02329522
loc_02329524:
	pop {r4}	; 02329524
	pop {r3}	; 02329526
	bx r3	; 02329528
	.byte 0xC0, 0x46	; 0232952C
pool_0232952C:
loc_0232952C:
	.word Slot2BusBaseAddress + 0x4	; 0232952C

; ===== function loc_02329530 =====
loc_02329530:
	push {r4,r5,lr}	; 02329530
	sub sp,#0x4	; 02329532
	add r5,r0,#0x0	; 02329534
	bl loc_0232B39C	; 02329536
	add r4,r0,#0x0	; 0232953A
	add r0,r5,#0x0	; 0232953C
	blx loc_0232B2B8	; 0232953E
	mov r0,#0x1	; 02329542
	mvn r0,r0	; 02329544
	cmp r4,r0	; 02329546
	beq loc_0232954C	; 02329548
	mov r0,#0x0	; 0232954A
loc_0232954C:
	add sp,#0x4	; 0232954C
	pop {r4,r5}	; 0232954E
	pop {r3}	; 02329550
	bx r3	; 02329552

; ===== function loc_02329554 =====
loc_02329554:
	push {r4,lr}	; 02329554
	blx loc_0232B260	; 02329556
	add r4,r0,#0x0	; 0232955A
	mov r0,#0x2	; 0232955C
	mvn r0,r0	; 0232955E
	cmp r4,r0	; 02329560
	bne loc_0232956E	; 02329562
	mov r0,#0x0	; 02329564
	mvn r0,r0	; 02329566
	pop {r4}	; 02329568
	pop {r3}	; 0232956A
	bx r3	; 0232956C
loc_0232956E:
	lsl r0,r4,#0x10	; 0232956E
	lsr r0,r0,#0x10	; 02329570
	bl loc_0232B3B8	; 02329572
	add r0,r4,#0x0	; 02329576
	pop {r4}	; 02329578
	pop {r3}	; 0232957A
	bx r3	; 0232957C
	.byte 0x00, 0x00	; 02329580

; ===== function loc_02329580 =====
loc_02329580:
	cmp r1,#0x0	; 02329580
	bne loc_02329588	; 02329582
	ldr r0,[r0,#0x4]	; 02329584
	bx lr	; 02329586
loc_02329588:
	ldrh r0,[r0,#0xa]	; 02329588
	ldr r0,[r1,r0]	; 0232958A
	bx lr	; 0232958C
	.byte 0x00, 0x00	; 02329590

; ===== function loc_02329590 =====
loc_02329590:
	cmp r1,#0x0	; 02329590
	bne loc_02329598	; 02329592
	ldr r0,[r0,#0x0]	; 02329594
	bx lr	; 02329596
loc_02329598:
	ldrh r0,[r0,#0xa]	; 02329598
	add r0,r1,r0	; 0232959A
	ldr r0,[r0,#0x4]	; 0232959C
	bx lr	; 0232959E

; ===== function loc_023295A0 =====
loc_023295A0:
	push {r4}	; 023295A0
	sub sp,#0x4	; 023295A2
	ldrh r4,[r0,#0xa]	; 023295A4
	add r2,r1,r4	; 023295A6
	ldr r1,[r1,r4]	; 023295A8
	cmp r1,#0x0	; 023295AA
	bne loc_023295B4	; 023295AC
	ldr r1,[r2,#0x4]	; 023295AE
	str r1,[r0,#0x0]	; 023295B0
	b loc_023295BA	; 023295B2
loc_023295B4:
	ldr r3,[r2,#0x4]	; 023295B4
	add r1,r1,r4	; 023295B6
	str r3,[r1,#0x4]	; 023295B8
loc_023295BA:
	ldr r4,[r2,#0x4]	; 023295BA
	cmp r4,#0x0	; 023295BC
	bne loc_023295C6	; 023295BE
	ldr r1,[r2,#0x0]	; 023295C0
	str r1,[r0,#0x4]	; 023295C2
	b loc_023295CC	; 023295C4
loc_023295C6:
	ldr r3,[r2,#0x0]	; 023295C6
	ldrh r1,[r0,#0xa]	; 023295C8
	str r3,[r4,r1]	; 023295CA
loc_023295CC:
	mov r1,#0x0	; 023295CC
	str r1,[r2,#0x0]	; 023295CE
	str r1,[r2,#0x4]	; 023295D0
	ldrh r1,[r0,#0x8]	; 023295D2
	sub r1,r1,#0x1	; 023295D4
	strh r1,[r0,#0x8]	; 023295D6
	add sp,#0x4	; 023295D8
	pop {r4}	; 023295DA
	bx lr	; 023295DC
	.byte 0x00, 0x00	; 023295E0

; ===== function loc_023295E0 =====
loc_023295E0:
	push {r4,r5,lr}	; 023295E0
	sub sp,#0x4	; 023295E2
	cmp r1,#0x0	; 023295E4
	bne loc_023295F6	; 023295E6
	add r1,r2,#0x0	; 023295E8
	bl loc_02329660	; 023295EA
	add sp,#0x4	; 023295EE
	pop {r4,r5}	; 023295F0
	pop {r3}	; 023295F2
	bx r3	; 023295F4
loc_023295F6:
	ldr r3,[r0,#0x0]	; 023295F6
	cmp r1,r3	; 023295F8
	bne loc_0232960A	; 023295FA
	add r1,r2,#0x0	; 023295FC
	bl loc_0232962C	; 023295FE
	add sp,#0x4	; 02329602
	pop {r4,r5}	; 02329604
	pop {r3}	; 02329606
	bx r3	; 02329608
loc_0232960A:
	ldrh r5,[r0,#0xa]	; 0232960A
	add r4,r2,r5	; 0232960C
	ldr r3,[r1,r5]	; 0232960E
	str r3,[r2,r5]	; 02329610
	str r1,[r4,#0x4]	; 02329612
	add r3,r3,r5	; 02329614
	str r2,[r3,#0x4]	; 02329616
	ldrh r3,[r0,#0xa]	; 02329618
	str r2,[r1,r3]	; 0232961A
	ldrh r1,[r0,#0x8]	; 0232961C
	add r1,r1,#0x1	; 0232961E
	strh r1,[r0,#0x8]	; 02329620
	add sp,#0x4	; 02329622
	pop {r4,r5}	; 02329624
	pop {r3}	; 02329626
	bx r3	; 02329628
	.byte 0x00, 0x00	; 0232962C

; ===== function loc_0232962C =====
loc_0232962C:
	push {r4,lr}	; 0232962C
	ldr r2,[r0,#0x0]	; 0232962E
	cmp r2,#0x0	; 02329630
	bne loc_0232963E	; 02329632
	bl loc_02329694	; 02329634
	pop {r4}	; 02329638
	pop {r3}	; 0232963A
	bx r3	; 0232963C
loc_0232963E:
	ldrh r3,[r0,#0xa]	; 0232963E
	add r4,r1,r3	; 02329640
	mov r2,#0x0	; 02329642
	str r2,[r1,r3]	; 02329644
	ldr r2,[r0,#0x0]	; 02329646
	str r2,[r4,#0x4]	; 02329648
	ldr r3,[r0,#0x0]	; 0232964A
	ldrh r2,[r0,#0xa]	; 0232964C
	str r1,[r3,r2]	; 0232964E
	str r1,[r0,#0x0]	; 02329650
	ldrh r1,[r0,#0x8]	; 02329652
	add r1,r1,#0x1	; 02329654
	strh r1,[r0,#0x8]	; 02329656
	pop {r4}	; 02329658
	pop {r3}	; 0232965A
	bx r3	; 0232965C
	.byte 0x00, 0x00	; 02329660

; ===== function loc_02329660 =====
loc_02329660:
	push {r4,lr}	; 02329660
	ldr r2,[r0,#0x0]	; 02329662
	cmp r2,#0x0	; 02329664
	bne loc_02329672	; 02329666
	bl loc_02329694	; 02329668
	pop {r4}	; 0232966C
	pop {r3}	; 0232966E
	bx r3	; 02329670
loc_02329672:
	ldrh r3,[r0,#0xa]	; 02329672
	add r4,r1,r3	; 02329674
	ldr r2,[r0,#0x4]	; 02329676
	str r2,[r1,r3]	; 02329678
	mov r2,#0x0	; 0232967A
	str r2,[r4,#0x4]	; 0232967C
	ldr r3,[r0,#0x4]	; 0232967E
	ldrh r2,[r0,#0xa]	; 02329680
	add r2,r3,r2	; 02329682
	str r1,[r2,#0x4]	; 02329684
	str r1,[r0,#0x4]	; 02329686
	ldrh r1,[r0,#0x8]	; 02329688
	add r1,r1,#0x1	; 0232968A
	strh r1,[r0,#0x8]	; 0232968C
	pop {r4}	; 0232968E
	pop {r3}	; 02329690
	bx r3	; 02329692

; ===== function loc_02329694 =====
loc_02329694:
	push {r4}	; 02329694
	sub sp,#0x4	; 02329696
	ldrh r3,[r0,#0xa]	; 02329698
	add r4,r1,r3	; 0232969A
	mov r2,#0x0	; 0232969C
	str r2,[r4,#0x4]	; 0232969E
	str r2,[r1,r3]	; 023296A0
	str r1,[r0,#0x0]	; 023296A2
	str r1,[r0,#0x4]	; 023296A4
	ldrh r1,[r0,#0x8]	; 023296A6
	add r1,r1,#0x1	; 023296A8
	strh r1,[r0,#0x8]	; 023296AA
	add sp,#0x4	; 023296AC
	pop {r4}	; 023296AE
	bx lr	; 023296B0
	.byte 0x00, 0x00	; 023296B4

; ===== function loc_023296B4 =====
loc_023296B4:
	mov r2,#0x0	; 023296B4
	str r2,[r0,#0x0]	; 023296B6
	str r2,[r0,#0x4]	; 023296B8
	strh r2,[r0,#0x8]	; 023296BA
	strh r1,[r0,#0xa]	; 023296BC
	bx lr	; 023296BE

; ===== function loc_023296C0 =====
loc_023296C0:
	push {r4,lr}	; 023296C0
	add r4,r0,#0x0	; 023296C2
	bl loc_02329738	; 023296C4
	add r1,r4,#0x0	; 023296C8
	bl loc_023295A0	; 023296CA
	pop {r4}	; 023296CE
	pop {r3}	; 023296D0
	bx r3	; 023296D2

; ===== function loc_023296D4 =====
loc_023296D4:
	push {r4,lr}	; 023296D4
	add r4,r0,#0x0	; 023296D6
	str r1,[r4,#0x0]	; 023296D8
	str r2,[r4,#0x18]	; 023296DA
	str r3,[r4,#0x1c]	; 023296DC
	mov r0,#0x0	; 023296DE
	str r0,[r4,#0x20]	; 023296E0
	ldr r1,[r4,#0x20]	; 023296E2
	mov r0,#0xff	; 023296E4
	bic r1,r0	; 023296E6
	str r1,[r4,#0x20]	; 023296E8
	ldr r2,[r4,#0x20]	; 023296EA
	ldr r1,[pool_0232972C]	; 023296EC
	add r1,sp	; 023296EE
	ldrh r1,[r1,#0x10]	; 023296F0
	and r1,r0	; 023296F2
	orr r2,r1	; 023296F4
	str r2,[r4,#0x20]	; 023296F6
	add r0,r4,#0x0	; 023296F8
	add r0,#0xc	; 023296FA
	mov r1,#0x4	; 023296FC
	bl loc_023296B4	; 023296FE
	ldr r0,[pool_02329730]	; 02329702
	ldr r0,[r0,#0x0]	; 02329704
	cmp r0,#0x0	; 02329706
	bne loc_02329718	; 02329708
	ldr r0,[pool_02329734]	; 0232970A
	mov r1,#0x4	; 0232970C
	bl loc_023296B4	; 0232970E
	mov r1,#0x1	; 02329712
	ldr r0,[pool_02329730]	; 02329714
	str r1,[r0,#0x0]	; 02329716
loc_02329718:
	add r0,r4,#0x0	; 02329718
	bl loc_02329738	; 0232971A
	add r1,r4,#0x0	; 0232971E
	bl loc_02329660	; 02329720
	pop {r4}	; 02329724
	pop {r3}	; 02329726
	bx r3	; 02329728
	.byte 0xC0, 0x46	; 0232972C
pool_0232972C:
loc_0232972C:
	.word 0xFFFFFFF8	; 0232972C
pool_02329730:
loc_02329730:
	.word P1_BssStart + 0x25A08	; 02329730
pool_02329734:
loc_02329734:
	.word 0x023564CC	; 02329734

; ===== function loc_02329738 =====
loc_02329738:
	push {r4,lr}	; 02329738
	add r1,r0,#0x0	; 0232973A
	ldr r4,[pool_02329754]	; 0232973C
	add r0,r4,#0x0	; 0232973E
	bl loc_02329758	; 02329740
	cmp r0,#0x0	; 02329744
	beq loc_0232974C	; 02329746
	add r4,r0,#0x0	; 02329748
	add r4,#0xc	; 0232974A
loc_0232974C:
	add r0,r4,#0x0	; 0232974C
	pop {r4}	; 0232974E
	pop {r3}	; 02329750
	bx r3	; 02329752
pool_02329754:
loc_02329754:
	.word 0x023564CC	; 02329754

; ===== function loc_02329758 =====
loc_02329758:
	push {r4,r5,r6,lr}	; 02329758
	add r6,r0,#0x0	; 0232975A
	add r5,r1,#0x0	; 0232975C
	mov r1,#0x0	; 0232975E
	bl loc_02329590	; 02329760
	add r4,r0,#0x0	; 02329764
	cmp r4,#0x0	; 02329766
	beq loc_0232979A	; 02329768
loc_0232976A:
	ldr r0,[r4,#0x18]	; 0232976A
	cmp r0,r5	; 0232976C
	bhi loc_0232978C	; 0232976E
	ldr r0,[r4,#0x1c]	; 02329770
	cmp r5,r0	; 02329772
	bcs loc_0232978C	; 02329774
	add r0,r4,#0x0	; 02329776
	add r0,#0xc	; 02329778
	add r1,r5,#0x0	; 0232977A
	bl loc_02329758	; 0232977C
	cmp r0,#0x0	; 02329780
	bne loc_0232979C	; 02329782
	add r0,r4,#0x0	; 02329784
	pop {r4,r5,r6}	; 02329786
	pop {r3}	; 02329788
	bx r3	; 0232978A
loc_0232978C:
	add r0,r6,#0x0	; 0232978C
	add r1,r4,#0x0	; 0232978E
	bl loc_02329590	; 02329790
	add r4,r0,#0x0	; 02329794
	cmp r4,#0x0	; 02329796
	bne loc_0232976A	; 02329798
loc_0232979A:
	mov r0,#0x0	; 0232979A
loc_0232979C:
	pop {r4,r5,r6}	; 0232979C
	pop {r3}	; 0232979E
	bx r3	; 023297A0
	.byte 0x00, 0x00	; 023297A2
P1_Entry_023297A4:
	push {r4,r5,lr}	; 023297A4
	sub sp,#0xc	; 023297A6
	add r5,r0,#0x0	; 023297A8
	add r5,#0x24	; 023297AA
	add r4,r1,#0x0	; 023297AC
	sub r4,#0x10	; 023297AE
	add r0,sp,#0x0	; 023297B0
	add r1,r4,#0x0	; 023297B2
	bl P1_Entry_02329B88	; 023297B4
	add r0,r5,#0x0	; 023297B8
	add r0,#0x8	; 023297BA
	add r1,r4,#0x0	; 023297BC
	bl P1_Entry_02329B6C	; 023297BE
	add r0,r5,#0x0	; 023297C2
	add r1,sp,#0x0	; 023297C4
	bl P1_Entry_0232982C	; 023297C6
	add sp,#0xc	; 023297CA
	pop {r4,r5}	; 023297CC
	pop {r3}	; 023297CE
	bx r3	; 023297D0
	.byte 0x00, 0x00	; 023297D2
P1_Entry_023297D4:
	push {lr}	; 023297D4
	sub sp,#0x4	; 023297D6
	cmp r1,#0x0	; 023297D8
	bne P1_Entry_023297DE	; 023297DA
	mov r1,#0x1	; 023297DC
P1_Entry_023297DE:
	add r1,r1,#0x3	; 023297DE
	mov r3,#0x3	; 023297E0
	bic r1,r3	; 023297E2
	cmp r2,#0x0	; 023297E4
	blt P1_Entry_023297F2	; 023297E6
	bl P1_Entry_02329948	; 023297E8
	add sp,#0x4	; 023297EC
	pop {r3}	; 023297EE
	bx r3	; 023297F0
P1_Entry_023297F2:
	neg r2,r2	; 023297F2
	bl P1_Entry_023298C0	; 023297F4
	add sp,#0x4	; 023297F8
	pop {r3}	; 023297FA
	bx r3	; 023297FC
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x09, 0x18, 0x03, 0x23, 0x99, 0x43, 0xC0, 0x1C, 0x98, 0x43	; 023297FE
	.byte 0x88, 0x42, 0x02, 0xD8, 0x0B, 0x1A, 0x4C, 0x2B, 0x03, 0xD2, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC	; 0232980E
	.byte 0x18, 0x47, 0x00, 0xF0, 0x5C, 0xF9, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 0232981E
P1_Entry_0232982C:
	push {r4,r5,r6,lr}	; 0232982C
	sub sp,#0x8	; 0232982E
	add r6,r0,#0x0	; 02329830
	add r5,r1,#0x0	; 02329832
	mov r4,#0x0	; 02329834
	ldr r1,[r5,#0x0]	; 02329836
	ldr r0,[r5,#0x4]	; 02329838
	str r1,[sp,#0x0]	; 0232983A
	str r0,[sp,#0x4]	; 0232983C
	ldr r1,[r6,#0x0]	; 0232983E
	cmp r1,#0x0	; 02329840
	beq P1_Entry_0232986C	; 02329842
	ldr r0,[r5,#0x0]	; 02329844
P1_Entry_02329846:
	cmp r1,r0	; 02329846
	bcs P1_Entry_0232984E	; 02329848
	add r4,r1,#0x0	; 0232984A
	b P1_Entry_02329866	; 0232984C
P1_Entry_0232984E:
	ldr r0,[r5,#0x4]	; 0232984E
	cmp r1,r0	; 02329850
	bne P1_Entry_0232986C	; 02329852
	ldr r2,[r1,#0x4]	; 02329854
	add r0,r1,#0x0	; 02329856
	add r0,#0x10	; 02329858
	add r0,r2,r0	; 0232985A
	str r0,[sp,#0x4]	; 0232985C
	add r0,r6,#0x0	; 0232985E
	bl P1_Entry_02329B6C	; 02329860
	b P1_Entry_0232986C	; 02329864
P1_Entry_02329866:
	ldr r1,[r1,#0xc]	; 02329866
	cmp r1,#0x0	; 02329868
	bne P1_Entry_02329846	; 0232986A
P1_Entry_0232986C:
	cmp r4,#0x0	; 0232986C
	beq P1_Entry_0232988A	; 0232986E
	ldr r1,[r4,#0x4]	; 02329870
	add r0,r4,#0x0	; 02329872
	add r0,#0x10	; 02329874
	add r1,r1,r0	; 02329876
	ldr r0,[r5,#0x0]	; 02329878
	cmp r1,r0	; 0232987A
	bne P1_Entry_0232988A	; 0232987C
	str r4,[sp,#0x0]	; 0232987E
	add r0,r6,#0x0	; 02329880
	add r1,r4,#0x0	; 02329882
	bl P1_Entry_02329B6C	; 02329884
	add r4,r0,#0x0	; 02329888
P1_Entry_0232988A:
	ldr r1,[sp,#0x4]	; 0232988A
	ldr r0,[sp,#0x0]	; 0232988C
	sub r0,r1,r0	; 0232988E
	cmp r0,#0x10	; 02329890
	bcs P1_Entry_0232989E	; 02329892
	mov r0,#0x0	; 02329894
	add sp,#0x8	; 02329896
	pop {r4,r5,r6}	; 02329898
	pop {r3}	; 0232989A
	bx r3	; 0232989C
P1_Entry_0232989E:
	add r0,sp,#0x0	; 0232989E
	ldr r1,[pool_023298BC]	; 023298A0
	bl loc_02329B30	; 023298A2
	add r1,r0,#0x0	; 023298A6
	add r0,r6,#0x0	; 023298A8
	add r2,r4,#0x0	; 023298AA
	bl P1_Entry_02329B4C	; 023298AC
	mov r0,#0x1	; 023298B0
	add sp,#0x8	; 023298B2
	pop {r4,r5,r6}	; 023298B4
	pop {r3}	; 023298B6
	bx r3	; 023298B8
	.byte 0xC0, 0x46	; 023298BA
pool_023298BC:
	.word 0x00004652	; 023298BC
P1_Entry_023298C0:
	push {r4,r5,r6,r7,lr}	; 023298C0
	sub sp,#0x14	; 023298C2
	add r3,r1,#0x0	; 023298C4
	str r0,[sp,#0xc]	; 023298C6
	add r0,#0x24	; 023298C8
	str r0,[sp,#0xc]	; 023298CA
	ldrh r0,[r0,#0x12]	; 023298CC
	mov r7,#0x1	; 023298CE
	and r0,r7	; 023298D0
	lsl r0,r0,#0x10	; 023298D2
	lsr r0,r0,#0x10	; 023298D4
	cmp r0,#0x0	; 023298D6
	beq P1_Entry_023298DC	; 023298D8
	mov r7,#0x0	; 023298DA
P1_Entry_023298DC:
	mov r0,#0x0	; 023298DC
	str r0,[sp,#0x4]	; 023298DE
	mvn r0,r0	; 023298E0
	ldr r1,[sp,#0x4]	; 023298E2
	str r1,[sp,#0x8]	; 023298E4
	ldr r1,[sp,#0xc]	; 023298E6
	ldr r1,[r1,#0x4]	; 023298E8
	cmp r1,#0x0	; 023298EA
	beq P1_Entry_02329920	; 023298EC
	sub r2,r2,#0x1	; 023298EE
	mvn r2,r2	; 023298F0
	str r2,[sp,#0x10]	; 023298F2
P1_Entry_023298F4:
	add r6,r1,#0x0	; 023298F4
	add r6,#0x10	; 023298F6
	ldr r5,[r1,#0x4]	; 023298F8
	add r2,r5,r6	; 023298FA
	sub r2,r2,r3	; 023298FC
	ldr r4,[sp,#0x10]	; 023298FE
	and r4,r2	; 02329900
	sub r2,r4,r6	; 02329902
	cmp r2,#0x0	; 02329904
	blt P1_Entry_0232991A	; 02329906
	cmp r0,r5	; 02329908
	bls P1_Entry_0232991A	; 0232990A
	str r1,[sp,#0x4]	; 0232990C
	add r0,r5,#0x0	; 0232990E
	str r4,[sp,#0x8]	; 02329910
	cmp r7,#0x0	; 02329912
	bne P1_Entry_02329920	; 02329914
	cmp r5,r3	; 02329916
	beq P1_Entry_02329920	; 02329918
P1_Entry_0232991A:
	ldr r1,[r1,#0x8]	; 0232991A
	cmp r1,#0x0	; 0232991C
	bne P1_Entry_023298F4	; 0232991E
P1_Entry_02329920:
	ldr r0,[sp,#0x4]	; 02329920
	cmp r0,#0x0	; 02329922
	beq P1_Entry_0232993C	; 02329924
	mov r0,#0x1	; 02329926
	str r0,[sp,#0x0]	; 02329928
	ldr r0,[sp,#0xc]	; 0232992A
	ldr r1,[sp,#0x4]	; 0232992C
	ldr r2,[sp,#0x8]	; 0232992E
	bl P1_Entry_023299D0	; 02329930
	add sp,#0x14	; 02329934
	pop {r4,r5,r6,r7}	; 02329936
	pop {r3}	; 02329938
	bx r3	; 0232993A
P1_Entry_0232993C:
	mov r0,#0x0	; 0232993C
	add sp,#0x14	; 0232993E
	pop {r4,r5,r6,r7}	; 02329940
	pop {r3}	; 02329942
	bx r3	; 02329944
	.byte 0x00, 0x00	; 02329946
P1_Entry_02329948:
	push {r4,r5,r6,r7,lr}	; 02329948
	sub sp,#0x14	; 0232994A
	add r3,r1,#0x0	; 0232994C
	str r0,[sp,#0xc]	; 0232994E
	add r0,#0x24	; 02329950
	str r0,[sp,#0xc]	; 02329952
	ldrh r0,[r0,#0x12]	; 02329954
	mov r7,#0x1	; 02329956
	and r0,r7	; 02329958
	lsl r0,r0,#0x10	; 0232995A
	lsr r0,r0,#0x10	; 0232995C
	cmp r0,#0x0	; 0232995E
	beq P1_Entry_02329964	; 02329960
	mov r7,#0x0	; 02329962
P1_Entry_02329964:
	mov r0,#0x0	; 02329964
	str r0,[sp,#0x4]	; 02329966
	mvn r0,r0	; 02329968
	ldr r1,[sp,#0x4]	; 0232996A
	str r1,[sp,#0x8]	; 0232996C
	ldr r1,[sp,#0xc]	; 0232996E
	ldr r1,[r1,#0x0]	; 02329970
	cmp r1,#0x0	; 02329972
	beq P1_Entry_023299A8	; 02329974
	sub r6,r2,#0x1	; 02329976
	mvn r2,r6	; 02329978
	str r2,[sp,#0x10]	; 0232997A
P1_Entry_0232997C:
	add r5,r1,#0x0	; 0232997C
	add r5,#0x10	; 0232997E
	add r2,r6,r5	; 02329980
	ldr r4,[sp,#0x10]	; 02329982
	and r4,r2	; 02329984
	ldr r2,[r1,#0x4]	; 02329986
	sub r5,r4,r5	; 02329988
	add r5,r3,r5	; 0232998A
	cmp r2,r5	; 0232998C
	bcc P1_Entry_023299A2	; 0232998E
	cmp r0,r2	; 02329990
	bls P1_Entry_023299A2	; 02329992
	str r1,[sp,#0x4]	; 02329994
	add r0,r2,#0x0	; 02329996
	str r4,[sp,#0x8]	; 02329998
	cmp r7,#0x0	; 0232999A
	bne P1_Entry_023299A8	; 0232999C
	cmp r2,r3	; 0232999E
	beq P1_Entry_023299A8	; 023299A0
P1_Entry_023299A2:
	ldr r1,[r1,#0xc]	; 023299A2
	cmp r1,#0x0	; 023299A4
	bne P1_Entry_0232997C	; 023299A6
P1_Entry_023299A8:
	ldr r0,[sp,#0x4]	; 023299A8
	cmp r0,#0x0	; 023299AA
	beq P1_Entry_023299C4	; 023299AC
	mov r0,#0x0	; 023299AE
	str r0,[sp,#0x0]	; 023299B0
	ldr r0,[sp,#0xc]	; 023299B2
	ldr r1,[sp,#0x4]	; 023299B4
	ldr r2,[sp,#0x8]	; 023299B6
	bl P1_Entry_023299D0	; 023299B8
	add sp,#0x14	; 023299BC
	pop {r4,r5,r6,r7}	; 023299BE
	pop {r3}	; 023299C0
	bx r3	; 023299C2
P1_Entry_023299C4:
	mov r0,#0x0	; 023299C4
	add sp,#0x14	; 023299C6
	pop {r4,r5,r6,r7}	; 023299C8
	pop {r3}	; 023299CA
	bx r3	; 023299CC
	.byte 0x00, 0x00	; 023299CE
P1_Entry_023299D0:
	push {r4,r5,r6,r7,lr}	; 023299D0
	sub sp,#0x1c	; 023299D2
	add r5,r0,#0x0	; 023299D4
	add r7,r1,#0x0	; 023299D6
	add r4,r2,#0x0	; 023299D8
	add r6,r3,#0x0	; 023299DA
	add r0,sp,#0x0	; 023299DC
	bl P1_Entry_02329B88	; 023299DE
	ldr r0,[sp,#0x4]	; 023299E2
	str r0,[sp,#0xc]	; 023299E4
	add r0,r6,r4	; 023299E6
	str r0,[sp,#0x8]	; 023299E8
	add r6,r4,#0x0	; 023299EA
	sub r6,#0x10	; 023299EC
	str r6,[sp,#0x4]	; 023299EE
	add r0,r5,#0x0	; 023299F0
	add r1,r7,#0x0	; 023299F2
	bl P1_Entry_02329B6C	; 023299F4
	add r7,r0,#0x0	; 023299F8
	ldr r1,[sp,#0x0]	; 023299FA
	ldr r0,[sp,#0x4]	; 023299FC
	sub r0,r0,r1	; 023299FE
	cmp r0,#0x10	; 02329A00
	bcs P1_Entry_02329A08	; 02329A02
	str r1,[sp,#0x4]	; 02329A04
	b P1_Entry_02329A1C	; 02329A06
P1_Entry_02329A08:
	add r0,sp,#0x0	; 02329A08
	ldr r1,[pool_02329ACC]	; 02329A0A
	bl loc_02329B30	; 02329A0C
	add r1,r0,#0x0	; 02329A10
	add r0,r5,#0x0	; 02329A12
	add r2,r7,#0x0	; 02329A14
	bl P1_Entry_02329B4C	; 02329A16
	add r7,r0,#0x0	; 02329A1A
P1_Entry_02329A1C:
	ldr r1,[sp,#0xc]	; 02329A1C
	ldr r0,[sp,#0x8]	; 02329A1E
	sub r0,r1,r0	; 02329A20
	cmp r0,#0x10	; 02329A22
	bcs P1_Entry_02329A2A	; 02329A24
	str r1,[sp,#0x8]	; 02329A26
	b P1_Entry_02329A3C	; 02329A28
P1_Entry_02329A2A:
	add r0,sp,#0x8	; 02329A2A
	ldr r1,[pool_02329ACC]	; 02329A2C
	bl loc_02329B30	; 02329A2E
	add r1,r0,#0x0	; 02329A32
	add r0,r5,#0x0	; 02329A34
	add r2,r7,#0x0	; 02329A36
	bl P1_Entry_02329B4C	; 02329A38
P1_Entry_02329A3C:
	ldr r1,[sp,#0x4]	; 02329A3C
	ldr r0,[sp,#0x8]	; 02329A3E
	sub r2,r0,r1	; 02329A40
	sub r0,r5,#0x4	; 02329A42
	ldr r3,[r0,#0x0]	; 02329A44
	mov r0,#0xff	; 02329A46
	and r3,r0	; 02329A48
	lsl r0,r3,#0x10	; 02329A4A
	lsr r3,r0,#0x10	; 02329A4C
	mov r0,#0x1	; 02329A4E
	and r3,r0	; 02329A50
	cmp r3,#0x0	; 02329A52
	beq P1_Entry_02329A60	; 02329A54
	mov r0,#0x0	; 02329A56
	str r0,[sp,#0x18]	; 02329A58
	ldr r0,[sp,#0x18]	; 02329A5A
	blx P1_MemFill32	; 02329A5C
P1_Entry_02329A60:
	str r6,[sp,#0x10]	; 02329A60
	ldr r0,[sp,#0x8]	; 02329A62
	str r0,[sp,#0x14]	; 02329A64
	add r0,sp,#0x10	; 02329A66
	ldr r1,[pool_02329AD0]	; 02329A68
	bl loc_02329B30	; 02329A6A
	add r1,r0,#0x0	; 02329A6E
	ldrh r2,[r1,#0x2]	; 02329A70
	ldr r0,[pool_02329AD4]	; 02329A72
	and r2,r0	; 02329A74
	strh r2,[r1,#0x2]	; 02329A76
	ldrh r0,[r1,#0x2]	; 02329A78
	add r2,sp,#0x20	; 02329A7A
	ldrh r3,[r2,#0x10]	; 02329A7C
	mov r2,#0x1	; 02329A7E
	and r3,r2	; 02329A80
	lsl r2,r3,#0xf	; 02329A82
	orr r0,r2	; 02329A84
	strh r0,[r1,#0x2]	; 02329A86
	ldr r0,[sp,#0x4]	; 02329A88
	sub r3,r1,r0	; 02329A8A
	ldrh r2,[r1,#0x2]	; 02329A8C
	ldr r0,[pool_02329AD8]	; 02329A8E
	and r2,r0	; 02329A90
	strh r2,[r1,#0x2]	; 02329A92
	ldrh r0,[r1,#0x2]	; 02329A94
	lsl r2,r3,#0x10	; 02329A96
	lsr r3,r2,#0x10	; 02329A98
	mov r2,#0x7f	; 02329A9A
	and r3,r2	; 02329A9C
	lsl r2,r3,#0x8	; 02329A9E
	orr r0,r2	; 02329AA0
	strh r0,[r1,#0x2]	; 02329AA2
	ldrh r3,[r5,#0x10]	; 02329AA4
	mov r0,#0xff	; 02329AA6
	and r3,r0	; 02329AA8
	ldrh r2,[r1,#0x2]	; 02329AAA
	bic r2,r0	; 02329AAC
	strh r2,[r1,#0x2]	; 02329AAE
	ldrh r0,[r1,#0x2]	; 02329AB0
	orr r0,r3	; 02329AB2
	strh r0,[r1,#0x2]	; 02329AB4
	add r0,r5,#0x0	; 02329AB6
	add r0,#0x8	; 02329AB8
	ldr r2,[r5,#0xc]	; 02329ABA
	bl P1_Entry_02329B4C	; 02329ABC
	add r0,r4,#0x0	; 02329AC0
	add sp,#0x1c	; 02329AC2
	pop {r4,r5,r6,r7}	; 02329AC4
	pop {r3}	; 02329AC6
	bx r3	; 02329AC8
	.byte 0xC0, 0x46	; 02329ACA
pool_02329ACC:
	.word 0x00004652	; 02329ACC
pool_02329AD0:
	.word 0x00005544	; 02329AD0
pool_02329AD4:
	.word 0xFFFF7FFF	; 02329AD4
pool_02329AD8:
	.word 0xFFFF80FF	; 02329AD8

; ===== function loc_02329ADC =====
	push {r4,r5,lr}	; 02329ADC
	sub sp,#0xc	; 02329ADE
	add r5,r0,#0x0	; 02329AE0
	add r3,r1,#0x0	; 02329AE2
	add r4,r5,#0x0	; 02329AE4
	add r4,#0x24	; 02329AE6
	str r2,[sp,#0x0]	; 02329AE8
	ldr r1,[pool_02329B28]	; 02329AEA
	add r2,r4,#0x0	; 02329AEC
	add r2,#0x14	; 02329AEE
	bl loc_023296D4	; 02329AF0
	mov r0,#0x0	; 02329AF4
	strh r0,[r4,#0x10]	; 02329AF6
	strh r0,[r4,#0x12]	; 02329AF8
	ldrh r1,[r4,#0x12]	; 02329AFA
	mov r0,#0x1	; 02329AFC
	bic r1,r0	; 02329AFE
	strh r1,[r4,#0x12]	; 02329B00
	ldr r0,[r5,#0x18]	; 02329B02
	str r0,[sp,#0x4]	; 02329B04
	ldr r0,[r5,#0x1c]	; 02329B06
	str r0,[sp,#0x8]	; 02329B08
	add r0,sp,#0x4	; 02329B0A
	ldr r1,[pool_02329B2C]	; 02329B0C
	bl loc_02329B30	; 02329B0E
	str r0,[r5,#0x24]	; 02329B12
	str r0,[r4,#0x4]	; 02329B14
	mov r0,#0x0	; 02329B16
	str r0,[r4,#0x8]	; 02329B18
	str r0,[r4,#0xc]	; 02329B1A
	add r0,r5,#0x0	; 02329B1C
	add sp,#0xc	; 02329B1E
	pop {r4,r5}	; 02329B20
	pop {r3}	; 02329B22
	bx r3	; 02329B24
	.byte 0xC0, 0x46	; 02329B28
pool_02329B28:
loc_02329B28:
	.word 0x45585048	; 02329B28
pool_02329B2C:
loc_02329B2C:
	.word 0x00004652	; 02329B2C

; ===== function loc_02329B30 =====
loc_02329B30:
	ldr r3,[r0,#0x0]	; 02329B30
	strh r1,[r3,#0x0]	; 02329B32
	mov r2,#0x0	; 02329B34
	strh r2,[r3,#0x2]	; 02329B36
	ldr r1,[r0,#0x4]	; 02329B38
	add r0,r3,#0x0	; 02329B3A
	add r0,#0x10	; 02329B3C
	sub r0,r1,r0	; 02329B3E
	str r0,[r3,#0x4]	; 02329B40
	str r2,[r3,#0x8]	; 02329B42
	str r2,[r3,#0xc]	; 02329B44
	add r0,r3,#0x0	; 02329B46
	bx lr	; 02329B48
	.byte 0x00, 0x00	; 02329B4A
P1_Entry_02329B4C:
	str r2,[r1,#0x8]	; 02329B4C
	cmp r2,#0x0	; 02329B4E
	beq P1_Entry_02329B58	; 02329B50
	ldr r3,[r2,#0xc]	; 02329B52
	str r1,[r2,#0xc]	; 02329B54
	b P1_Entry_02329B5C	; 02329B56
P1_Entry_02329B58:
	ldr r3,[r0,#0x0]	; 02329B58
	str r1,[r0,#0x0]	; 02329B5A
P1_Entry_02329B5C:
	str r3,[r1,#0xc]	; 02329B5C
	cmp r3,#0x0	; 02329B5E
	beq P1_Entry_02329B66	; 02329B60
	str r1,[r3,#0x8]	; 02329B62
	b P1_Entry_02329B68	; 02329B64
P1_Entry_02329B66:
	str r1,[r0,#0x4]	; 02329B66
P1_Entry_02329B68:
	add r0,r1,#0x0	; 02329B68
	bx lr	; 02329B6A
P1_Entry_02329B6C:
	ldr r2,[r1,#0x8]	; 02329B6C
	ldr r1,[r1,#0xc]	; 02329B6E
	cmp r2,#0x0	; 02329B70
	beq P1_Entry_02329B78	; 02329B72
	str r1,[r2,#0xc]	; 02329B74
	b P1_Entry_02329B7A	; 02329B76
P1_Entry_02329B78:
	str r1,[r0,#0x0]	; 02329B78
P1_Entry_02329B7A:
	cmp r1,#0x0	; 02329B7A
	beq P1_Entry_02329B82	; 02329B7C
	str r2,[r1,#0x8]	; 02329B7E
	b P1_Entry_02329B84	; 02329B80
P1_Entry_02329B82:
	str r2,[r0,#0x4]	; 02329B82
P1_Entry_02329B84:
	add r0,r2,#0x0	; 02329B84
	bx lr	; 02329B86
P1_Entry_02329B88:
	ldrh r2,[r1,#0x2]	; 02329B88
	asr r3,r2,#0x8	; 02329B8A
	mov r2,#0x7f	; 02329B8C
	and r3,r2	; 02329B8E
	lsl r2,r3,#0x10	; 02329B90
	lsr r2,r2,#0x10	; 02329B92
	sub r2,r1,r2	; 02329B94
	str r2,[r0,#0x0]	; 02329B96
	ldr r2,[r1,#0x4]	; 02329B98
	add r1,#0x10	; 02329B9A
	add r1,r2,r1	; 02329B9C
	str r1,[r0,#0x4]	; 02329B9E
	bx lr	; 02329BA0
	.byte 0x00, 0x00	; 02329BA2

; ===== function loc_02329BA4 =====
loc_02329BA4:
	push {r4,r5,lr}	; 02329BA4
	sub sp,#0x4	; 02329BA6
	add r5,r0,#0x0	; 02329BA8
	add r4,r1,#0x0	; 02329BAA
	mov r1,#0x1	; 02329BAC
	add r2,r4,#0x0	; 02329BAE
	and r2,r1	; 02329BB0
	cmp r2,#0x0	; 02329BB2
	beq loc_02329BBA	; 02329BB4
	bl loc_02329C4C	; 02329BB6
loc_02329BBA:
	mov r0,#0x2	; 02329BBA
	and r4,r0	; 02329BBC
	cmp r4,#0x0	; 02329BBE
	beq loc_02329BC8	; 02329BC0
	add r0,r5,#0x0	; 02329BC2
	bl loc_02329C30	; 02329BC4
loc_02329BC8:
	add sp,#0x4	; 02329BC8
	pop {r4,r5}	; 02329BCA
	pop {r3}	; 02329BCC
	bx r3	; 02329BCE

; ===== function loc_02329BD0 =====
loc_02329BD0:
	push {lr}	; 02329BD0
	sub sp,#0x4	; 02329BD2
	add r0,#0x24	; 02329BD4
	cmp r1,#0x0	; 02329BD6
	bne loc_02329BDC	; 02329BD8
	mov r1,#0x1	; 02329BDA
loc_02329BDC:
	add r1,r1,#0x3	; 02329BDC
	mov r3,#0x3	; 02329BDE
	bic r1,r3	; 02329BE0
	cmp r2,#0x0	; 02329BE2
	blt loc_02329BF0	; 02329BE4
	bl loc_02329CAC	; 02329BE6
	add sp,#0x4	; 02329BEA
	pop {r3}	; 02329BEC
	bx r3	; 02329BEE
loc_02329BF0:
	neg r2,r2	; 02329BF0
	bl loc_02329C5C	; 02329BF2
	add sp,#0x4	; 02329BF6
	pop {r3}	; 02329BF8
	bx r3	; 02329BFA

; ===== function loc_02329BFC =====
loc_02329BFC:
	ldr r3,[pool_02329C00]	; 02329BFC
	bx r3	; 02329BFE
pool_02329C00:
loc_02329C00:
	.word loc_023296C0 + 1	; 02329C00

; ===== function loc_02329C04 =====
loc_02329C04:
	push {lr}	; 02329C04
	sub sp,#0x4	; 02329C06
	add r1,r1,r0	; 02329C08
	mov r3,#0x3	; 02329C0A
	bic r1,r3	; 02329C0C
	add r0,r0,#0x3	; 02329C0E
	bic r0,r3	; 02329C10
	cmp r0,r1	; 02329C12
	bhi loc_02329C1C	; 02329C14
	sub r3,r1,r0	; 02329C16
	cmp r3,#0x30	; 02329C18
	bcs loc_02329C24	; 02329C1A
loc_02329C1C:
	mov r0,#0x0	; 02329C1C
	add sp,#0x4	; 02329C1E
	pop {r3}	; 02329C20
	bx r3	; 02329C22
loc_02329C24:
	bl loc_02329CFC	; 02329C24
	add sp,#0x4	; 02329C28
	pop {r3}	; 02329C2A
	bx r3	; 02329C2C
	.byte 0x00, 0x00	; 02329C30

; ===== function loc_02329C30 =====
loc_02329C30:
	add r2,r0,#0x0	; 02329C30
	add r2,#0x24	; 02329C32
	ldr r3,[r2,#0x8]	; 02329C34
	cmp r3,#0x0	; 02329C36
	beq loc_02329C44	; 02329C38
loc_02329C3A:
	ldr r1,[r0,#0x1c]	; 02329C3A
	str r1,[r3,#0x8]	; 02329C3C
	ldr r3,[r3,#0xc]	; 02329C3E
	cmp r3,#0x0	; 02329C40
	bne loc_02329C3A	; 02329C42
loc_02329C44:
	ldr r0,[r0,#0x1c]	; 02329C44
	str r0,[r2,#0x4]	; 02329C46
	bx lr	; 02329C48
	.byte 0x00, 0x00	; 02329C4C

; ===== function loc_02329C4C =====
loc_02329C4C:
	add r2,r0,#0x0	; 02329C4C
	add r2,#0x24	; 02329C4E
	ldr r1,[r0,#0x18]	; 02329C50
	str r1,[r0,#0x24]	; 02329C52
	mov r0,#0x0	; 02329C54
	str r0,[r2,#0x8]	; 02329C56
	bx lr	; 02329C58
	.byte 0x00, 0x00	; 02329C5C

; ===== function loc_02329C5C =====
loc_02329C5C:
	push {r4,r5,lr}	; 02329C5C
	sub sp,#0x4	; 02329C5E
	add r5,r0,#0x0	; 02329C60
	ldr r0,[r5,#0x4]	; 02329C62
	sub r2,r2,#0x1	; 02329C64
	mvn r4,r2	; 02329C66
	sub r1,r0,r1	; 02329C68
	and r4,r1	; 02329C6A
	ldr r1,[r5,#0x0]	; 02329C6C
	cmp r4,r1	; 02329C6E
	bcs loc_02329C7C	; 02329C70
	mov r0,#0x0	; 02329C72
	add sp,#0x4	; 02329C74
	pop {r4,r5}	; 02329C76
	pop {r3}	; 02329C78
	bx r3	; 02329C7A
loc_02329C7C:
	sub r2,r0,r4	; 02329C7C
	sub r0,r5,#0x4	; 02329C7E
	ldr r1,[r0,#0x0]	; 02329C80
	mov r0,#0xff	; 02329C82
	and r1,r0	; 02329C84
	lsl r0,r1,#0x10	; 02329C86
	lsr r1,r0,#0x10	; 02329C88
	mov r0,#0x1	; 02329C8A
	and r1,r0	; 02329C8C
	cmp r1,#0x0	; 02329C8E
	beq loc_02329C9E	; 02329C90
	mov r0,#0x0	; 02329C92
	str r0,[sp,#0x0]	; 02329C94
	ldr r0,[sp,#0x0]	; 02329C96
	add r1,r4,#0x0	; 02329C98
	blx loc_0232DE3C	; 02329C9A
loc_02329C9E:
	str r4,[r5,#0x4]	; 02329C9E
	add r0,r4,#0x0	; 02329CA0
	add sp,#0x4	; 02329CA2
	pop {r4,r5}	; 02329CA4
	pop {r3}	; 02329CA6
	bx r3	; 02329CA8
	.byte 0x00, 0x00	; 02329CAC

; ===== function loc_02329CAC =====
loc_02329CAC:
	push {r4,r5,r6,lr}	; 02329CAC
	sub sp,#0x8	; 02329CAE
	add r5,r0,#0x0	; 02329CB0
	ldr r3,[r5,#0x0]	; 02329CB2
	sub r0,r2,#0x1	; 02329CB4
	mvn r4,r0	; 02329CB6
	add r0,r0,r3	; 02329CB8
	and r4,r0	; 02329CBA
	add r6,r1,r4	; 02329CBC
	ldr r0,[r5,#0x4]	; 02329CBE
	cmp r6,r0	; 02329CC0
	bls loc_02329CCE	; 02329CC2
	mov r0,#0x0	; 02329CC4
	add sp,#0x8	; 02329CC6
	pop {r4,r5,r6}	; 02329CC8
	pop {r3}	; 02329CCA
	bx r3	; 02329CCC
loc_02329CCE:
	sub r2,r6,r3	; 02329CCE
	sub r0,r5,#0x4	; 02329CD0
	ldr r1,[r0,#0x0]	; 02329CD2
	mov r0,#0xff	; 02329CD4
	and r1,r0	; 02329CD6
	lsl r0,r1,#0x10	; 02329CD8
	lsr r1,r0,#0x10	; 02329CDA
	mov r0,#0x1	; 02329CDC
	and r1,r0	; 02329CDE
	cmp r1,#0x0	; 02329CE0
	beq loc_02329CF0	; 02329CE2
	mov r0,#0x0	; 02329CE4
	str r0,[sp,#0x0]	; 02329CE6
	ldr r0,[sp,#0x0]	; 02329CE8
	add r1,r3,#0x0	; 02329CEA
	blx loc_0232DE3C	; 02329CEC
loc_02329CF0:
	str r6,[r5,#0x0]	; 02329CF0
	add r0,r4,#0x0	; 02329CF2
	add sp,#0x8	; 02329CF4
	pop {r4,r5,r6}	; 02329CF6
	pop {r3}	; 02329CF8
	bx r3	; 02329CFA

; ===== function loc_02329CFC =====
loc_02329CFC:
	push {r4,r5,lr}	; 02329CFC
	sub sp,#0x4	; 02329CFE
	add r5,r0,#0x0	; 02329D00
	add r3,r1,#0x0	; 02329D02
	add r4,r5,#0x0	; 02329D04
	add r4,#0x24	; 02329D06
	str r2,[sp,#0x0]	; 02329D08
	ldr r1,[pool_02329D2C]	; 02329D0A
	add r2,r4,#0x0	; 02329D0C
	add r2,#0xc	; 02329D0E
	bl loc_023296D4	; 02329D10
	ldr r0,[r5,#0x18]	; 02329D14
	str r0,[r5,#0x24]	; 02329D16
	ldr r0,[r5,#0x1c]	; 02329D18
	str r0,[r4,#0x4]	; 02329D1A
	mov r0,#0x0	; 02329D1C
	str r0,[r4,#0x8]	; 02329D1E
	add r0,r5,#0x0	; 02329D20
	add sp,#0x4	; 02329D22
	pop {r4,r5}	; 02329D24
	pop {r3}	; 02329D26
	bx r3	; 02329D28
	.byte 0xC0, 0x46	; 02329D2C
pool_02329D2C:
loc_02329D2C:
	.word 0x46524D48	; 02329D2C

; ===== function loc_02329D30 =====
loc_02329D30:
	ldr r3,[pool_02329D34]	; 02329D30
	bx r3	; 02329D32
pool_02329D34:
loc_02329D34:
	.word P1_ResetDualBufferBuffers + 1	; 02329D34

; ===== function loc_02329D38 =====
loc_02329D38:
	push {r4,lr}	; 02329D38
	bl P1_ApplyDualBufferProcessorSettings	; 02329D3A
	mov r0,#0x0	; 02329D3E
	add r1,r0,#0x0	; 02329D40
	add r2,r0,#0x0	; 02329D42
	add r3,r0,#0x0	; 02329D44
	bl loc_0232E0F0	; 02329D46
	bl loc_0232E308	; 02329D4A
	add r4,r0,#0x0	; 02329D4E
	mov r0,#0x1	; 02329D50
	bl loc_0232E374	; 02329D52
	add r0,r4,#0x0	; 02329D56
	bl loc_0232E328	; 02329D58
	pop {r4}	; 02329D5C
	pop {r3}	; 02329D5E
	bx r3	; 02329D60
	.byte 0x00, 0x00	; 02329D64

; ===== function loc_02329D64 =====
loc_02329D64:
	push {r4,lr}	; 02329D64
	mov r4,#0x0	; 02329D66
loc_02329D68:
	add r0,r4,#0x0	; 02329D68
	bl loc_0232E4CC	; 02329D6A
	cmp r0,#0x0	; 02329D6E
	bne loc_02329D68	; 02329D70
	bl loc_0232A2E4	; 02329D72
	bl P1_UpdateDualBufferProcessorStatus	; 02329D76
	mov r0,#0x0	; 02329D7A
	bl loc_0232E374	; 02329D7C
	pop {r4}	; 02329D80
	pop {r3}	; 02329D82
	bx r3	; 02329D84
	.byte 0x00, 0x00	; 02329D88

; ===== function loc_02329D88 =====
loc_02329D88:
	push {lr}	; 02329D88
	sub sp,#0x4	; 02329D8A
	ldr r0,[pool_02329DB0]	; 02329D8C
	ldr r1,[r0,#0x0]	; 02329D8E
	cmp r1,#0x0	; 02329D90
	bne loc_02329DA8	; 02329D92
	mov r1,#0x1	; 02329D94
	str r1,[r0,#0x0]	; 02329D96
	bl loc_0232DF28	; 02329D98
	bl loc_02329E80	; 02329D9C
	bl P1_ClearDualBufferProcessorAndQueueState	; 02329DA0
	bl loc_0232A3D4	; 02329DA4
loc_02329DA8:
	add sp,#0x4	; 02329DA8
	pop {r3}	; 02329DAA
	bx r3	; 02329DAC
	.byte 0xC0, 0x46	; 02329DB0
pool_02329DB0:
loc_02329DB0:
	.word P1_BssStart + 0x25A18	; 02329DB0

; ===== function loc_02329DB4 =====
loc_02329DB4:
	ldr r1,[pool_02329DC4]	; 02329DB4
	ldr r3,[r1,#0x0]	; 02329DB6
	mov r2,#0x1	; 02329DB8
	lsl r2,r0	; 02329DBA
	bic r3,r2	; 02329DBC
	str r3,[r1,#0x0]	; 02329DBE
	bx lr	; 02329DC0
	.byte 0xC0, 0x46	; 02329DC4
pool_02329DC4:
loc_02329DC4:
	.word P1_BssStart + 0x25A20	; 02329DC4

; ===== function loc_02329DC8 =====
loc_02329DC8:
	mov r3,#0x1	; 02329DC8
	mov r0,#0x0	; 02329DCA
	ldr r1,[pool_02329DF0]	; 02329DCC
	ldr r2,[r1,#0x0]	; 02329DCE
loc_02329DD0:
	add r1,r2,#0x0	; 02329DD0
	and r1,r3	; 02329DD2
	cmp r1,#0x0	; 02329DD4
	bne loc_02329DE2	; 02329DD6
	ldr r1,[pool_02329DF0]	; 02329DD8
	ldr r2,[r1,#0x0]	; 02329DDA
	orr r2,r3	; 02329DDC
	str r2,[r1,#0x0]	; 02329DDE
	bx lr	; 02329DE0
loc_02329DE2:
	add r0,r0,#0x1	; 02329DE2
	lsl r3,r3,#0x1	; 02329DE4
	cmp r0,#0x8	; 02329DE6
	blt loc_02329DD0	; 02329DE8
	mov r0,#0x0	; 02329DEA
	mvn r0,r0	; 02329DEC
	bx lr	; 02329DEE
pool_02329DF0:
loc_02329DF0:
	.word P1_BssStart + 0x25A20	; 02329DF0

; ===== function loc_02329DF4 =====
loc_02329DF4:
	ldr r1,[pool_02329E00]	; 02329DF4
	ldr r2,[r1,#0x0]	; 02329DF6
	bic r2,r0	; 02329DF8
	str r2,[r1,#0x0]	; 02329DFA
	bx lr	; 02329DFC
	.byte 0xC0, 0x46	; 02329E00
pool_02329E00:
loc_02329E00:
	.word P1_BssStart + 0x25A1C	; 02329E00

; ===== function loc_02329E04 =====
loc_02329E04:
	ldr r1,[pool_02329E1C]	; 02329E04
	ldr r2,[r1,#0x0]	; 02329E06
	add r3,r0,#0x0	; 02329E08
	and r3,r2	; 02329E0A
	cmp r3,#0x0	; 02329E0C
	beq loc_02329E14	; 02329E0E
	mov r0,#0x0	; 02329E10
	bx lr	; 02329E12
loc_02329E14:
	orr r2,r0	; 02329E14
	str r2,[r1,#0x0]	; 02329E16
	mov r0,#0x1	; 02329E18
	bx lr	; 02329E1A
pool_02329E1C:
loc_02329E1C:
	.word P1_BssStart + 0x25A1C	; 02329E1C

; ===== function loc_02329E20 =====
loc_02329E20:
	push {r4,lr}	; 02329E20
	add r4,r0,#0x0	; 02329E22
	cmp r4,#0x0	; 02329E24
	beq loc_02329E36	; 02329E26
	mov r1,#0x0	; 02329E28
	bl loc_0232E054	; 02329E2A
	ldr r0,[pool_02329E3C]	; 02329E2E
	ldr r1,[r0,#0x0]	; 02329E30
	bic r1,r4	; 02329E32
	str r1,[r0,#0x0]	; 02329E34
loc_02329E36:
	pop {r4}	; 02329E36
	pop {r3}	; 02329E38
	bx r3	; 02329E3A
pool_02329E3C:
loc_02329E3C:
	.word P1_BssStart + 0x25A24	; 02329E3C

; ===== function loc_02329E40 =====
loc_02329E40:
	push {r4,lr}	; 02329E40
	add r4,r0,#0x0	; 02329E42
	cmp r4,#0x0	; 02329E44
	bne loc_02329E50	; 02329E46
	mov r0,#0x1	; 02329E48
	pop {r4}	; 02329E4A
	pop {r3}	; 02329E4C
	bx r3	; 02329E4E
loc_02329E50:
	ldr r1,[pool_02329E7C]	; 02329E50
	ldr r1,[r1,#0x0]	; 02329E52
	add r2,r4,#0x0	; 02329E54
	and r2,r1	; 02329E56
	cmp r2,#0x0	; 02329E58
	beq loc_02329E64	; 02329E5A
	mov r0,#0x0	; 02329E5C
	pop {r4}	; 02329E5E
	pop {r3}	; 02329E60
	bx r3	; 02329E62
loc_02329E64:
	mov r1,#0x0	; 02329E64
	bl loc_0232E070	; 02329E66
	ldr r0,[pool_02329E7C]	; 02329E6A
	ldr r1,[r0,#0x0]	; 02329E6C
	orr r1,r4	; 02329E6E
	str r1,[r0,#0x0]	; 02329E70
	mov r0,#0x1	; 02329E72
	pop {r4}	; 02329E74
	pop {r3}	; 02329E76
	bx r3	; 02329E78
	.byte 0xC0, 0x46	; 02329E7C
pool_02329E7C:
loc_02329E7C:
	.word P1_BssStart + 0x25A24	; 02329E7C

; ===== function loc_02329E80 =====
loc_02329E80:
	mov r1,#0x0	; 02329E80
	ldr r0,[pool_02329E90]	; 02329E82
	str r1,[r0,#0x0]	; 02329E84
	ldr r0,[pool_02329E94]	; 02329E86
	str r1,[r0,#0x0]	; 02329E88
	ldr r0,[pool_02329E98]	; 02329E8A
	str r1,[r0,#0x0]	; 02329E8C
	bx lr	; 02329E8E
pool_02329E90:
loc_02329E90:
	.word P1_BssStart + 0x25A24	; 02329E90
pool_02329E94:
loc_02329E94:
	.word P1_BssStart + 0x25A1C	; 02329E94
pool_02329E98:
loc_02329E98:
	.word P1_BssStart + 0x25A20	; 02329E98

; ===== function loc_02329E9C =====
loc_02329E9C:
	push {r4,r5,r6,lr}	; 02329E9C
	add r5,r0,#0x0	; 02329E9E
	add r6,r1,#0x0	; 02329EA0
	ldr r4,[r5,#0x4]	; 02329EA2
	cmp r4,#0x0	; 02329EA4
	beq loc_02329EB4	; 02329EA6
	add r0,r4,#0x0	; 02329EA8
	add r1,r5,#0x0	; 02329EAA
	bl loc_023295A0	; 02329EAC
	mov r0,#0x0	; 02329EB0
	str r0,[r5,#0x4]	; 02329EB2
loc_02329EB4:
	ldr r0,[pool_02329EDC]	; 02329EB4
	add r1,r5,#0x0	; 02329EB6
	bl loc_023295A0	; 02329EB8
	add r0,r5,#0x0	; 02329EBC
	add r0,#0x3d	; 02329EBE
	strb r6,[r0,#0x0]	; 02329EC0
	cmp r4,#0x0	; 02329EC2
	beq loc_02329ECE	; 02329EC4
	add r0,r4,#0x0	; 02329EC6
	add r1,r5,#0x0	; 02329EC8
	bl loc_0232A034	; 02329ECA
loc_02329ECE:
	add r0,r5,#0x0	; 02329ECE
	bl loc_02329FEC	; 02329ED0
	pop {r4,r5,r6}	; 02329ED4
	pop {r3}	; 02329ED6
	bx r3	; 02329ED8
	.byte 0xC0, 0x46	; 02329EDC
pool_02329EDC:
loc_02329EDC:
	.word 0x023564F4	; 02329EDC

; ===== function loc_02329EE0 =====
	push {r4,lr}	; 02329EE0
	add r4,r0,#0x0	; 02329EE2
	ldr r0,[r4,#0x8]	; 02329EE4
	cmp r0,#0x0	; 02329EE6
	beq loc_02329F10	; 02329EE8
	bl loc_0232AC80	; 02329EEA
	ldr r1,[r4,#0xc]	; 02329EEE
	cmp r1,#0x0	; 02329EF0
	beq loc_02329EFE	; 02329EF2
	mov r0,#0x0	; 02329EF4
	str r0,[r1,#0x8]	; 02329EF6
	pop {r4}	; 02329EF8
	pop {r3}	; 02329EFA
	bx r3	; 02329EFC
loc_02329EFE:
	ldr r2,[pool_02329F18]	; 02329EFE
	ldr r1,[r4,#0x10]	; 02329F00
	mov r0,#0x1c	; 02329F02
	mul r1,r0	; 02329F04
	add r0,r2,r1	; 02329F06
	add r0,#0xc	; 02329F08
	add r1,r4,#0x0	; 02329F0A
	bl loc_023295A0	; 02329F0C
loc_02329F10:
	pop {r4}	; 02329F10
	pop {r3}	; 02329F12
	bx r3	; 02329F14
	.byte 0xC0, 0x46	; 02329F18
pool_02329F18:
loc_02329F18:
	.word 0x02356500	; 02329F18

; ===== function loc_02329F1C =====
loc_02329F1C:
	push {r4,r5,lr}	; 02329F1C
	sub sp,#0x4	; 02329F1E
	add r5,r0,#0x0	; 02329F20
	ldr r1,[r5,#0x0]	; 02329F22
	cmp r1,#0x0	; 02329F24
	beq loc_02329F2E	; 02329F26
	mov r0,#0x0	; 02329F28
	str r0,[r1,#0x0]	; 02329F2A
	str r0,[r5,#0x0]	; 02329F2C
loc_02329F2E:
	ldr r4,[r5,#0x4]	; 02329F2E
	add r0,r4,#0x0	; 02329F30
	add r1,r5,#0x0	; 02329F32
	bl loc_023295A0	; 02329F34
	mov r0,#0x0	; 02329F38
	str r0,[r5,#0x4]	; 02329F3A
	ldr r1,[r5,#0x8]	; 02329F3C
	cmp r1,#0x0	; 02329F3E
	beq loc_02329F52	; 02329F40
	add r4,#0xc	; 02329F42
	add r0,r4,#0x0	; 02329F44
	bl loc_02329660	; 02329F46
	mov r1,#0x0	; 02329F4A
	ldr r0,[r5,#0x8]	; 02329F4C
	str r1,[r0,#0xc]	; 02329F4E
	str r1,[r5,#0x8]	; 02329F50
loc_02329F52:
	ldr r0,[pool_02329F70]	; 02329F52
	add r1,r5,#0x0	; 02329F54
	bl loc_023295A0	; 02329F56
	ldr r0,[pool_02329F74]	; 02329F5A
	add r1,r5,#0x0	; 02329F5C
	bl loc_02329660	; 02329F5E
	mov r0,#0x0	; 02329F62
	add r5,#0x2c	; 02329F64
	strb r0,[r5,#0x0]	; 02329F66
	add sp,#0x4	; 02329F68
	pop {r4,r5}	; 02329F6A
	pop {r3}	; 02329F6C
	bx r3	; 02329F6E
pool_02329F70:
loc_02329F70:
	.word 0x023564F4	; 02329F70
pool_02329F74:
loc_02329F74:
	.word 0x023564E8	; 02329F74

; ===== function loc_02329F78 =====
loc_02329F78:
	push {r4,r5,lr}	; 02329F78
	sub sp,#0x4	; 02329F7A
	add r5,r0,#0x0	; 02329F7C
	ldr r0,[pool_02329FCC]	; 02329F7E
	mov r1,#0x0	; 02329F80
	bl loc_02329590	; 02329F82
	add r4,r0,#0x0	; 02329F86
	cmp r4,#0x0	; 02329F88
	bne loc_02329FAE	; 02329F8A
	ldr r0,[pool_02329FD0]	; 02329F8C
	mov r1,#0x0	; 02329F8E
	bl loc_02329590	; 02329F90
	add r4,r0,#0x0	; 02329F94
	add r1,r4,#0x0	; 02329F96
	add r1,#0x3d	; 02329F98
	ldrb r1,[r1,#0x0]	; 02329F9A
	cmp r5,r1	; 02329F9C
	bge loc_02329FAA	; 02329F9E
	mov r0,#0x0	; 02329FA0
	add sp,#0x4	; 02329FA2
	pop {r4,r5}	; 02329FA4
	pop {r3}	; 02329FA6
	bx r3	; 02329FA8
loc_02329FAA:
	bl loc_02329FD4	; 02329FAA
loc_02329FAE:
	ldr r0,[pool_02329FCC]	; 02329FAE
	add r1,r4,#0x0	; 02329FB0
	bl loc_023295A0	; 02329FB2
	add r0,r4,#0x0	; 02329FB6
	add r0,#0x3d	; 02329FB8
	strb r5,[r0,#0x0]	; 02329FBA
	add r0,r4,#0x0	; 02329FBC
	bl loc_02329FEC	; 02329FBE
	add r0,r4,#0x0	; 02329FC2
	add sp,#0x4	; 02329FC4
	pop {r4,r5}	; 02329FC6
	pop {r3}	; 02329FC8
	bx r3	; 02329FCA
pool_02329FCC:
loc_02329FCC:
	.word 0x023564E8	; 02329FCC
pool_02329FD0:
loc_02329FD0:
	.word 0x023564F4	; 02329FD0

; ===== function loc_02329FD4 =====
loc_02329FD4:
	push {r4,lr}	; 02329FD4
	add r4,r0,#0x0	; 02329FD6
	add r0,#0x3c	; 02329FD8
	ldrb r0,[r0,#0x0]	; 02329FDA
	bl loc_0232E1B0	; 02329FDC
	add r0,r4,#0x0	; 02329FE0
	bl loc_02329F1C	; 02329FE2
	pop {r4}	; 02329FE6
	pop {r3}	; 02329FE8
	bx r3	; 02329FEA

; ===== function loc_02329FEC =====
loc_02329FEC:
	push {r4,r5,lr}	; 02329FEC
	sub sp,#0x4	; 02329FEE
	add r5,r0,#0x0	; 02329FF0
	ldr r0,[pool_0232A030]	; 02329FF2
	mov r1,#0x0	; 02329FF4
	bl loc_02329590	; 02329FF6
	add r1,r0,#0x0	; 02329FFA
	cmp r1,#0x0	; 02329FFC
	beq loc_0232A01E	; 02329FFE
	ldr r4,[pool_0232A030]	; 0232A000
loc_0232A002:
	add r0,r5,#0x0	; 0232A002
	add r0,#0x3d	; 0232A004
	ldrb r2,[r0,#0x0]	; 0232A006
	add r0,r1,#0x0	; 0232A008
	add r0,#0x3d	; 0232A00A
	ldrb r0,[r0,#0x0]	; 0232A00C
	cmp r2,r0	; 0232A00E
	bcc loc_0232A01E	; 0232A010
	add r0,r4,#0x0	; 0232A012
	bl loc_02329590	; 0232A014
	add r1,r0,#0x0	; 0232A018
	cmp r1,#0x0	; 0232A01A
	bne loc_0232A002	; 0232A01C
loc_0232A01E:
	ldr r0,[pool_0232A030]	; 0232A01E
	add r2,r5,#0x0	; 0232A020
	bl loc_023295E0	; 0232A022
	add sp,#0x4	; 0232A026
	pop {r4,r5}	; 0232A028
	pop {r3}	; 0232A02A
	bx r3	; 0232A02C
	.byte 0xC0, 0x46	; 0232A030
pool_0232A030:
loc_0232A030:
	.word 0x023564F4	; 0232A030

; ===== function loc_0232A034 =====
loc_0232A034:
	push {r4,r5,lr}	; 0232A034
	sub sp,#0x4	; 0232A036
	add r5,r0,#0x0	; 0232A038
	add r4,r1,#0x0	; 0232A03A
	mov r1,#0x0	; 0232A03C
	bl loc_02329590	; 0232A03E
	add r1,r0,#0x0	; 0232A042
	cmp r1,#0x0	; 0232A044
	beq loc_0232A064	; 0232A046
loc_0232A048:
	add r0,r4,#0x0	; 0232A048
	add r0,#0x3d	; 0232A04A
	ldrb r2,[r0,#0x0]	; 0232A04C
	add r0,r1,#0x0	; 0232A04E
	add r0,#0x3d	; 0232A050
	ldrb r0,[r0,#0x0]	; 0232A052
	cmp r2,r0	; 0232A054
	bcc loc_0232A064	; 0232A056
	add r0,r5,#0x0	; 0232A058
	bl loc_02329590	; 0232A05A
	add r1,r0,#0x0	; 0232A05E
	cmp r1,#0x0	; 0232A060
	bne loc_0232A048	; 0232A062
loc_0232A064:
	add r0,r5,#0x0	; 0232A064
	add r2,r4,#0x0	; 0232A066
	bl loc_023295E0	; 0232A068
	str r5,[r4,#0x4]	; 0232A06C
	add sp,#0x4	; 0232A06E
	pop {r4,r5}	; 0232A070
	pop {r3}	; 0232A072
	bx r3	; 0232A074
	.byte 0x00, 0x00	; 0232A078

; ===== function loc_0232A078 =====
loc_0232A078:
	push {r4,lr}	; 0232A078
	add r4,r0,#0x0	; 0232A07A
	mov r1,#0x0	; 0232A07C
	add r0,#0x2e	; 0232A07E
	strb r1,[r0,#0x0]	; 0232A080
	add r0,r4,#0x0	; 0232A082
	add r0,#0x2d	; 0232A084
	strb r1,[r0,#0x0]	; 0232A086
	strh r1,[r4,#0x34]	; 0232A088
	strh r1,[r4,#0x3e]	; 0232A08A
	mov r1,#0x7f	; 0232A08C
	add r0,r4,#0x0	; 0232A08E
	add r0,#0x40	; 0232A090
	strb r1,[r0,#0x0]	; 0232A092
	add r0,r4,#0x0	; 0232A094
	add r0,#0x41	; 0232A096
	strb r1,[r0,#0x0]	; 0232A098
	add r0,r4,#0x0	; 0232A09A
	add r0,#0x1c	; 0232A09C
	bl loc_0232AFB8	; 0232A09E
	add r4,#0x1c	; 0232A0A2
	add r0,r4,#0x0	; 0232A0A4
	ldr r1,[pool_0232A0B4]	; 0232A0A6
	mov r2,#0x1	; 0232A0A8
	bl loc_0232AF9C	; 0232A0AA
	pop {r4}	; 0232A0AE
	pop {r3}	; 0232A0B0
	bx r3	; 0232A0B2
pool_0232A0B4:
loc_0232A0B4:
	.word 0x00007F00	; 0232A0B4
loc_0232A0B8:
	push {r4,lr}	; 0232A0B8
	add r4,r0,#0x0	; 0232A0BA
	add r2,r1,#0x0	; 0232A0BC
	cmp r4,#0x0	; 0232A0BE
	beq loc_0232A0F0	; 0232A0C0
	add r1,r4,#0x0	; 0232A0C2
	add r1,#0x2c	; 0232A0C4
	ldrb r1,[r1,#0x0]	; 0232A0C6
	cmp r1,#0x0	; 0232A0C8
	beq loc_0232A0F0	; 0232A0CA
	cmp r2,#0x0	; 0232A0CC
	bne loc_0232A0DA	; 0232A0CE
	bl loc_02329FD4	; 0232A0D0
	pop {r4}	; 0232A0D4
	pop {r3}	; 0232A0D6
	bx r3	; 0232A0D8
loc_0232A0DA:
	add r0,#0x1c	; 0232A0DA
	mov r1,#0x0	; 0232A0DC
	bl loc_0232AF9C	; 0232A0DE
	add r0,r4,#0x0	; 0232A0E2
	mov r1,#0x0	; 0232A0E4
	bl loc_02329E9C	; 0232A0E6
	mov r0,#0x2	; 0232A0EA
	add r4,#0x2c	; 0232A0EC
	strb r0,[r4,#0x0]	; 0232A0EE
loc_0232A0F0:
	pop {r4}	; 0232A0F0
	pop {r3}	; 0232A0F2
	bx r3	; 0232A0F4
	.byte 0x00, 0x00	; 0232A0F8

; ===== function loc_0232A0F8 =====
loc_0232A0F8:
	push {r4,lr}	; 0232A0F8
	add r4,r0,#0x0	; 0232A0FA
	add r0,#0x3c	; 0232A0FC
	ldrb r0,[r0,#0x0]	; 0232A0FE
	bl loc_0232E1C8	; 0232A100
	add r0,r4,#0x0	; 0232A104
	bl loc_0232A078	; 0232A106
	bl loc_0232E308	; 0232A10A
	str r0,[r4,#0x30]	; 0232A10E
	mov r0,#0x1	; 0232A110
	add r4,#0x2c	; 0232A112
	strb r0,[r4,#0x0]	; 0232A114
	pop {r4}	; 0232A116
	pop {r3}	; 0232A118
	bx r3	; 0232A11A

; ===== function loc_0232A11C =====
loc_0232A11C:
	ldr r3,[pool_0232A120]	; 0232A11C
	bx r3	; 0232A11E
pool_0232A120:
loc_0232A120:
	.word loc_02329F1C + 1	; 0232A120

; ===== function loc_0232A124 =====
loc_0232A124:
	push {r4,r5,r6,lr}	; 0232A124
	add r5,r0,#0x0	; 0232A126
	add r6,r2,#0x0	; 0232A128
	ldr r3,[pool_0232A198]	; 0232A12A
	mov r2,#0x1c	; 0232A12C
	mul r1,r2	; 0232A12E
	add r4,r3,r1	; 0232A130
	ldr r1,[r5,#0x0]	; 0232A132
	cmp r1,#0x0	; 0232A134
	beq loc_0232A13C	; 0232A136
	bl loc_0232A240	; 0232A138
loc_0232A13C:
	ldrh r1,[r4,#0x8]	; 0232A13C
	ldr r0,[r4,#0x18]	; 0232A13E
	cmp r1,r0	; 0232A140
	bcc loc_0232A16E	; 0232A142
	add r0,r4,#0x0	; 0232A144
	mov r1,#0x0	; 0232A146
	bl loc_02329590	; 0232A148
	cmp r0,#0x0	; 0232A14C
	bne loc_0232A158	; 0232A14E
	mov r0,#0x0	; 0232A150
	pop {r4,r5,r6}	; 0232A152
	pop {r3}	; 0232A154
	bx r3	; 0232A156
loc_0232A158:
	add r1,r0,#0x0	; 0232A158
	add r1,#0x3d	; 0232A15A
	ldrb r1,[r1,#0x0]	; 0232A15C
	cmp r6,r1	; 0232A15E
	bge loc_0232A16A	; 0232A160
	mov r0,#0x0	; 0232A162
	pop {r4,r5,r6}	; 0232A164
	pop {r3}	; 0232A166
	bx r3	; 0232A168
loc_0232A16A:
	bl loc_02329FD4	; 0232A16A
loc_0232A16E:
	add r0,r6,#0x0	; 0232A16E
	bl loc_02329F78	; 0232A170
	add r6,r0,#0x0	; 0232A174
	cmp r6,#0x0	; 0232A176
	bne loc_0232A182	; 0232A178
	mov r0,#0x0	; 0232A17A
	pop {r4,r5,r6}	; 0232A17C
	pop {r3}	; 0232A17E
	bx r3	; 0232A180
loc_0232A182:
	add r0,r4,#0x0	; 0232A182
	add r1,r6,#0x0	; 0232A184
	bl loc_0232A034	; 0232A186
	str r5,[r6,#0x0]	; 0232A18A
	str r6,[r5,#0x0]	; 0232A18C
	add r0,r6,#0x0	; 0232A18E
	pop {r4,r5,r6}	; 0232A190
	pop {r3}	; 0232A192
	bx r3	; 0232A194
	.byte 0xC0, 0x46	; 0232A198
pool_0232A198:
loc_0232A198:
	.word 0x02356500	; 0232A198

; ===== function loc_0232A19C =====
loc_0232A19C:
	push {r4}	; 0232A19C
	sub sp,#0x4	; 0232A19E
	ldr r4,[r0,#0x0]	; 0232A1A0
	cmp r4,#0x0	; 0232A1A2
	beq loc_0232A1B2	; 0232A1A4
	mov r3,#0x2	; 0232A1A6
	strh r3,[r4,#0x34]	; 0232A1A8
	ldr r3,[r0,#0x0]	; 0232A1AA
	strh r1,[r3,#0x38]	; 0232A1AC
	ldr r0,[r0,#0x0]	; 0232A1AE
	strh r2,[r0,#0x3a]	; 0232A1B0
loc_0232A1B2:
	add sp,#0x4	; 0232A1B2
	pop {r4}	; 0232A1B4
	bx lr	; 0232A1B6

; ===== function loc_0232A1B8 =====
	push {lr}	; 0232A1B8
	sub sp,#0x4	; 0232A1BA
	ldr r0,[r0,#0x0]	; 0232A1BC
	cmp r0,#0x0	; 0232A1BE
	beq loc_0232A1CA	; 0232A1C0
	add r0,#0x3c	; 0232A1C2
	ldrb r0,[r0,#0x0]	; 0232A1C4
	bl loc_0232E158	; 0232A1C6
loc_0232A1CA:
	add sp,#0x4	; 0232A1CA
	pop {r3}	; 0232A1CC
	bx r3	; 0232A1CE

; ===== function loc_0232A1D0 =====
	push {lr}	; 0232A1D0
	sub sp,#0x4	; 0232A1D2
	ldr r0,[r0,#0x0]	; 0232A1D4
	cmp r0,#0x0	; 0232A1D6
	beq loc_0232A1E2	; 0232A1D8
	add r0,#0x3c	; 0232A1DA
	ldrb r0,[r0,#0x0]	; 0232A1DC
	bl loc_0232E170	; 0232A1DE
loc_0232A1E2:
	add sp,#0x4	; 0232A1E2
	pop {r3}	; 0232A1E4
	bx r3	; 0232A1E6

; ===== function loc_0232A1E8 =====
loc_0232A1E8:
	push {lr}	; 0232A1E8
	sub sp,#0x4	; 0232A1EA
	ldr r0,[r0,#0x0]	; 0232A1EC
	cmp r0,#0x0	; 0232A1EE
	beq loc_0232A1FA	; 0232A1F0
	add r0,#0x3c	; 0232A1F2
	ldrb r0,[r0,#0x0]	; 0232A1F4
	bl loc_0232E188	; 0232A1F6
loc_0232A1FA:
	add sp,#0x4	; 0232A1FA
	pop {r3}	; 0232A1FC
	bx r3	; 0232A1FE

; ===== function loc_0232A200 =====
	push {lr}	; 0232A200
	sub sp,#0x4	; 0232A202
	ldr r0,[r0,#0x0]	; 0232A204
	cmp r0,#0x0	; 0232A206
	beq loc_0232A21C	; 0232A208
	add r3,r0,#0x0	; 0232A20A
	add r3,#0x2c	; 0232A20C
	ldrb r3,[r3,#0x0]	; 0232A20E
	cmp r3,#0x2	; 0232A210
	beq loc_0232A21C	; 0232A212
	add r0,#0x1c	; 0232A214
	lsl r1,r1,#0x8	; 0232A216
	bl loc_0232AF9C	; 0232A218
loc_0232A21C:
	add sp,#0x4	; 0232A21C
	pop {r3}	; 0232A21E
	bx r3	; 0232A220
	.byte 0x00, 0x00	; 0232A224

; ===== function loc_0232A224 =====
loc_0232A224:
	ldr r0,[r0,#0x0]	; 0232A224
	cmp r0,#0x0	; 0232A226
	beq loc_0232A22E	; 0232A228
	add r0,#0x40	; 0232A22A
	strb r1,[r0,#0x0]	; 0232A22C
loc_0232A22E:
	bx lr	; 0232A22E

; ===== function loc_0232A230 =====
loc_0232A230:
	mov r1,#0x1c	; 0232A230
	mul r0,r1	; 0232A232
	ldr r1,[pool_0232A23C]	; 0232A234
	ldrh r0,[r1,r0]	; 0232A236
	bx lr	; 0232A238
	.byte 0xC0, 0x46	; 0232A23C
pool_0232A23C:
loc_0232A23C:
	.word P1_BssStart + 0x25A48	; 0232A23C

; ===== function loc_0232A240 =====
loc_0232A240:
	ldr r2,[r0,#0x0]	; 0232A240
	cmp r2,#0x0	; 0232A242
	beq loc_0232A24C	; 0232A244
	mov r1,#0x0	; 0232A246
	str r1,[r2,#0x0]	; 0232A248
	str r1,[r0,#0x0]	; 0232A24A
loc_0232A24C:
	bx lr	; 0232A24C
	.byte 0x00, 0x00	; 0232A250

; ===== function loc_0232A250 =====
loc_0232A250:
	mov r1,#0x0	; 0232A250
	str r1,[r0,#0x0]	; 0232A252
	bx lr	; 0232A254
	.byte 0x00, 0x00	; 0232A258
loc_0232A258:
	ldr r0,[r0,#0x0]	; 0232A258
	ldr r3,[pool_0232A260]	; 0232A25A
	bx r3	; 0232A25C
	.byte 0xC0, 0x46	; 0232A260
pool_0232A260:
loc_0232A260:
	.word loc_0232A0B8 + 1	; 0232A260

; ===== function loc_0232A264 =====
loc_0232A264:
	push {r4,r5,r6,lr}	; 0232A264
	sub sp,#0x8	; 0232A266
	add r5,r0,#0x0	; 0232A268
	add r6,r2,#0x0	; 0232A26A
	mov r3,#0x0	; 0232A26C
	str r3,[sp,#0x0]	; 0232A26E
	add r0,r1,#0x0	; 0232A270
	add r1,r6,#0x0	; 0232A272
	add r1,#0x14	; 0232A274
	ldr r2,[pool_0232A2C8]	; 0232A276
	bl loc_0232ABB8	; 0232A278
	add r4,r0,#0x0	; 0232A27C
	cmp r4,#0x0	; 0232A27E
	bne loc_0232A28C	; 0232A280
	mov r0,#0x0	; 0232A282
	add sp,#0x8	; 0232A284
	pop {r4,r5,r6}	; 0232A286
	pop {r3}	; 0232A288
	bx r3	; 0232A28A
loc_0232A28C:
	mov r0,#0x0	; 0232A28C
	str r0,[r4,#0xc]	; 0232A28E
	str r5,[r4,#0x10]	; 0232A290
	str r0,[r4,#0x8]	; 0232A292
	add r0,r4,#0x0	; 0232A294
	add r0,#0x14	; 0232A296
	add r1,r6,#0x0	; 0232A298
	bl loc_0232AC94	; 0232A29A
	cmp r0,#0x0	; 0232A29E
	bne loc_0232A2AC	; 0232A2A0
	mov r0,#0x0	; 0232A2A2
	add sp,#0x8	; 0232A2A4
	pop {r4,r5,r6}	; 0232A2A6
	pop {r3}	; 0232A2A8
	bx r3	; 0232A2AA
loc_0232A2AC:
	str r0,[r4,#0x8]	; 0232A2AC
	ldr r1,[pool_0232A2CC]	; 0232A2AE
	mov r0,#0x1c	; 0232A2B0
	mul r5,r0	; 0232A2B2
	add r0,r1,r5	; 0232A2B4
	add r0,#0xc	; 0232A2B6
	add r1,r4,#0x0	; 0232A2B8
	bl loc_02329660	; 0232A2BA
	mov r0,#0x1	; 0232A2BE
	add sp,#0x8	; 0232A2C0
	pop {r4,r5,r6}	; 0232A2C2
	pop {r3}	; 0232A2C4
	bx r3	; 0232A2C6
pool_0232A2C8:
loc_0232A2C8:
	.word 0x02329EE1	; 0232A2C8
pool_0232A2CC:
loc_0232A2CC:
	.word 0x02356500	; 0232A2CC

; ===== function loc_0232A2D0 =====
loc_0232A2D0:
	lsl r1,r1,#0x10	; 0232A2D0
	lsr r2,r1,#0x10	; 0232A2D2
	mov r1,#0x1c	; 0232A2D4
	mul r0,r1	; 0232A2D6
	ldr r1,[pool_0232A2E0]	; 0232A2D8
	str r2,[r1,r0]	; 0232A2DA
	bx lr	; 0232A2DC
	.byte 0xC0, 0x46	; 0232A2E0
pool_0232A2E0:
loc_0232A2E0:
	.word P1_BssStart + 0x25A58	; 0232A2E0

; ===== function loc_0232A2E4 =====
loc_0232A2E4:
	push {r4,r5,r6,r7,lr}	; 0232A2E4
	sub sp,#0xc	; 0232A2E6
	bl loc_0232E734	; 0232A2E8
	str r0,[sp,#0x4]	; 0232A2EC
	ldr r0,[pool_0232A3C8]	; 0232A2EE
	mov r1,#0x0	; 0232A2F0
	bl loc_02329590	; 0232A2F2
	add r5,r0,#0x0	; 0232A2F6
	cmp r5,#0x0	; 0232A2F8
	beq loc_0232A3C0	; 0232A2FA
	ldr r7,[pool_0232A3CC]	; 0232A2FC
loc_0232A2FE:
	ldr r0,[pool_0232A3C8]	; 0232A2FE
	add r1,r5,#0x0	; 0232A300
	bl loc_02329590	; 0232A302
	str r0,[sp,#0x0]	; 0232A306
	add r0,r5,#0x0	; 0232A308
	add r0,#0x2d	; 0232A30A
	ldrb r0,[r0,#0x0]	; 0232A30C
	cmp r0,#0x0	; 0232A30E
	bne loc_0232A324	; 0232A310
	ldr r0,[r5,#0x30]	; 0232A312
	bl loc_0232E2D8	; 0232A314
	cmp r0,#0x0	; 0232A318
	beq loc_0232A324	; 0232A31A
	add r1,r5,#0x0	; 0232A31C
	add r1,#0x2d	; 0232A31E
	mov r0,#0x1	; 0232A320
	strb r0,[r1,#0x0]	; 0232A322
loc_0232A324:
	add r0,r5,#0x0	; 0232A324
	add r0,#0x2d	; 0232A326
	ldrb r0,[r0,#0x0]	; 0232A328
	cmp r0,#0x0	; 0232A32A
	beq loc_0232A348	; 0232A32C
	add r0,r5,#0x0	; 0232A32E
	add r0,#0x3c	; 0232A330
	ldrb r0,[r0,#0x0]	; 0232A332
	mov r1,#0x1	; 0232A334
	lsl r1,r0	; 0232A336
	ldr r0,[sp,#0x4]	; 0232A338
	and r0,r1	; 0232A33A
	cmp r0,#0x0	; 0232A33C
	bne loc_0232A348	; 0232A33E
	add r0,r5,#0x0	; 0232A340
	bl loc_02329F1C	; 0232A342
	b loc_0232A3B8	; 0232A346
loc_0232A348:
	add r0,r5,#0x0	; 0232A348
	add r0,#0x1c	; 0232A34A
	bl loc_0232AF64	; 0232A34C
	add r0,r5,#0x0	; 0232A350
	add r0,#0x41	; 0232A352
	ldrb r0,[r0,#0x0]	; 0232A354
	lsl r0,r0,#0x1	; 0232A356
	ldrsh r4,[r7,r0]	; 0232A358
	add r0,r5,#0x0	; 0232A35A
	add r0,#0x40	; 0232A35C
	ldrb r0,[r0,#0x0]	; 0232A35E
	lsl r0,r0,#0x1	; 0232A360
	ldrsh r6,[r7,r0]	; 0232A362
	add r0,r5,#0x0	; 0232A364
	add r0,#0x1c	; 0232A366
	bl loc_0232AF74	; 0232A368
	asr r0,r0,#0x8	; 0232A36C
	lsl r0,r0,#0x1	; 0232A36E
	ldrsh r1,[r7,r0]	; 0232A370
	add r0,r6,r4	; 0232A372
	add r4,r1,r0	; 0232A374
	ldr r0,[pool_0232A3D0]	; 0232A376
	cmp r4,r0	; 0232A378
	bge loc_0232A380	; 0232A37A
	lsl r4,r0,#0	; 0232A37C
	b loc_0232A386	; 0232A37E
loc_0232A380:
	cmp r4,#0x0	; 0232A380
	ble loc_0232A386	; 0232A382
	mov r4,#0x0	; 0232A384
loc_0232A386:
	mov r0,#0x3e	; 0232A386
	ldrsh r0,[r5,r0]	; 0232A388
	cmp r4,r0	; 0232A38A
	beq loc_0232A39C	; 0232A38C
	add r0,r5,#0x0	; 0232A38E
	add r0,#0x3c	; 0232A390
	ldrb r0,[r0,#0x0]	; 0232A392
	add r1,r4,#0x0	; 0232A394
	bl loc_0232E19C	; 0232A396
	strh r4,[r5,#0x3e]	; 0232A39A
loc_0232A39C:
	add r0,r5,#0x0	; 0232A39C
	add r0,#0x2c	; 0232A39E
	ldrb r0,[r0,#0x0]	; 0232A3A0
	cmp r0,#0x2	; 0232A3A2
	bne loc_0232A3B8	; 0232A3A4
	add r0,r5,#0x0	; 0232A3A6
	add r0,#0x1c	; 0232A3A8
	bl loc_0232AF54	; 0232A3AA
	cmp r0,#0x0	; 0232A3AE
	beq loc_0232A3B8	; 0232A3B0
	add r0,r5,#0x0	; 0232A3B2
	bl loc_02329FD4	; 0232A3B4
loc_0232A3B8:
	ldr r5,[sp,#0x0]	; 0232A3B8
	lsl r0,r5,#0	; 0232A3BA
	cmp r0,#0x0	; 0232A3BC
	bne loc_0232A2FE	; 0232A3BE
loc_0232A3C0:
	add sp,#0xc	; 0232A3C0
	pop {r4,r5,r6,r7}	; 0232A3C2
	pop {r3}	; 0232A3C4
	bx r3	; 0232A3C6
pool_0232A3C8:
loc_0232A3C8:
	.word 0x023564F4	; 0232A3C8
pool_0232A3CC:
loc_0232A3CC:
	.word 0x023304D4	; 0232A3CC
pool_0232A3D0:
loc_0232A3D0:
	.word 0xFFFFFD2D	; 0232A3D0

; ===== function loc_0232A3D4 =====
loc_0232A3D4:
	push {r4,r5,r6,r7,lr}	; 0232A3D4
	sub sp,#0x4	; 0232A3D6
	ldr r0,[pool_0232A438]	; 0232A3D8
	mov r1,#0x14	; 0232A3DA
	bl loc_023296B4	; 0232A3DC
	ldr r0,[pool_0232A43C]	; 0232A3E0
	mov r1,#0x14	; 0232A3E2
	bl loc_023296B4	; 0232A3E4
	mov r5,#0x0	; 0232A3E8
	ldr r4,[pool_0232A440]	; 0232A3EA
	add r6,r5,#0x0	; 0232A3EC
	ldr r7,[pool_0232A43C]	; 0232A3EE
loc_0232A3F0:
	add r0,r4,#0x0	; 0232A3F0
	add r0,#0x2c	; 0232A3F2
	strb r6,[r0,#0x0]	; 0232A3F4
	add r0,r4,#0x0	; 0232A3F6
	add r0,#0x3c	; 0232A3F8
	strb r5,[r0,#0x0]	; 0232A3FA
	add r0,r7,#0x0	; 0232A3FC
	add r1,r4,#0x0	; 0232A3FE
	bl loc_02329660	; 0232A400
	add r4,#0x44	; 0232A404
	add r5,r5,#0x1	; 0232A406
	cmp r5,#0x10	; 0232A408
	blt loc_0232A3F0	; 0232A40A
	mov r4,#0x0	; 0232A40C
	ldr r5,[pool_0232A444]	; 0232A40E
	add r6,r4,#0x0	; 0232A410
	mov r7,#0x1	; 0232A412
loc_0232A414:
	add r0,r5,#0x0	; 0232A414
	mov r1,#0xc	; 0232A416
	bl loc_023296B4	; 0232A418
	add r0,r5,#0x0	; 0232A41C
	add r0,#0xc	; 0232A41E
	add r1,r6,#0x0	; 0232A420
	bl loc_023296B4	; 0232A422
	str r7,[r5,#0x18]	; 0232A426
	add r5,#0x1c	; 0232A428
	add r4,r4,#0x1	; 0232A42A
	cmp r4,#0x20	; 0232A42C
	blt loc_0232A414	; 0232A42E
	add sp,#0x4	; 0232A430
	pop {r4,r5,r6,r7}	; 0232A432
	pop {r3}	; 0232A434
	bx r3	; 0232A436
pool_0232A438:
loc_0232A438:
	.word 0x023564F4	; 0232A438
pool_0232A43C:
loc_0232A43C:
	.word 0x023564E8	; 0232A43C
pool_0232A440:
loc_0232A440:
	.word P1_BssStart + 0x25DC0	; 0232A440
pool_0232A444:
loc_0232A444:
	.word 0x02356500	; 0232A444

; ===== function loc_0232A448 =====
	push {r4,r5,r6,r7,lr}	; 0232A448
	sub sp,#0xc	; 0232A44A
; 调度当前双缓冲区块；正常路径将两段缓冲区、块长度、用户值和上下文传给回调。
; Dispatch the current two-buffer block; normal path passes both buffers, size, user value and context.
.func P1_DispatchDualBufferBlock
	add r5,r0,#0x0	; 0232A44C
	ldr r0,[r5,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A44E
	ldr r1,[r5,#P1_DualBufferProcessorBlockCountOffset]	; 0232A450
	blx P1_SignedDivMod	; 0232A452
	str r0,[sp,#0x4]	; 0232A456
	ldr r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A458
	ldr r4,[sp,#0x4]	; 0232A45A
	mul r4,r0	; 0232A45C
	ldr r0,[r5,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A45E
	add r6,r0,r4	; 0232A460
	ldr r0,[r5,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A462
	add r7,r0,r4	; 0232A464
	add r0,r6,#0x0	; 0232A466
	ldr r1,[sp,#0x4]	; 0232A468
	blx P1_InvalidateDataCacheRange	; 0232A46A
	add r0,r7,#0x0	; 0232A46E
	ldr r1,[sp,#0x4]	; 0232A470
	blx P1_InvalidateDataCacheRange	; 0232A472
	ldr r0,[pool_0232A4DC]	; 0232A476
	ldr r0,[r0,#0x0]	; 0232A478
	cmp r0,#0x0	; 0232A47A
	beq loc_0232A4B0	; 0232A47C
	ldr r2,[pool_0232A4E0]	; 0232A47E
	ldr r0,[pool_0232A4E4]	; 0232A480
	ldr r0,[r0,#0x0]	; 0232A482
	mov r1,#0x14	; 0232A484
	mul r0,r1	; 0232A486
	add r1,r2,r0	; 0232A488
	str r5,[r2,r0]	; 0232A48A
	ldr r0,[sp,#0x4]	; 0232A48C
	str r0,[r1,#0x4]	; 0232A48E
	str r4,[r1,#0x8]	; 0232A490
	str r6,[r1,#0xc]	; 0232A492
	str r7,[r1,#0x10]	; 0232A494
	ldr r0,[pool_0232A4E8]	; 0232A496
	mov r2,#0x0	; 0232A498
	bl loc_0232BAAC	; 0232A49A
	ldr r0,[pool_0232A4E4]	; 0232A49E
	ldr r1,[r0,#0x0]	; 0232A4A0
	add r1,r1,#0x1	; 0232A4A2
	str r1,[r0,#0x0]	; 0232A4A4
	cmp r1,#0x8	; 0232A4A6
	blt loc_0232A4C0	; 0232A4A8
	mov r1,#0x0	; 0232A4AA
	str r1,[r0,#0x0]	; 0232A4AC
	b loc_0232A4C0	; 0232A4AE
loc_0232A4B0:
	ldr r0,[r5,#P1_DualBufferProcessorCallbackContextOffset]	; 0232A4B0
	str r0,[sp,#0x0]	; 0232A4B2
	add r0,r6,#0x0	; 0232A4B4
	add r1,r7,#0x0	; 0232A4B6
	ldr r2,[sp,#0x4]	; 0232A4B8
	ldr r3,[r5,#P1_DualBufferProcessorUserValueOffset]	; 0232A4BA
	ldr r4,[r5,#P1_DualBufferProcessorCallbackOffset]	; 0232A4BC
	blx r4	; 0232A4BE
loc_0232A4C0:
	ldr r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A4C0
	add r0,r0,#0x1	; 0232A4C2
	str r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A4C4
	ldr r1,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A4C6
	ldr r0,[r5,#P1_DualBufferProcessorBlockCountOffset]	; 0232A4C8
	cmp r1,r0	; 0232A4CA
	blt loc_0232A4D2	; 0232A4CC
	mov r0,#0x0	; 0232A4CE
	str r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A4D0
loc_0232A4D2:
	add sp,#0xc	; 0232A4D2
	pop {r4,r5,r6,r7}	; 0232A4D4
	pop {r3}	; 0232A4D6
	bx r3	; 0232A4D8
	.byte 0xC0, 0x46	; 0232A4DC
pool_0232A4DC:
.endfunc
loc_0232A4DC:
	.word P1_DualBufferDeferredQueueGate	; 0232A4DC
pool_0232A4E0:
loc_0232A4E0:
	.word P1_DualBufferDeferredQueueEntries	; 0232A4E0
pool_0232A4E4:
loc_0232A4E4:
	.word P1_DualBufferDeferredQueueIndex	; 0232A4E4
pool_0232A4E8:
loc_0232A4E8:
	.word 0x02356CC8	; 0232A4E8

; ===== function loc_0232A4EC =====
loc_0232A4EC:
	push {r4,lr}	; 0232A4EC
	sub sp,#0x8	; 0232A4EE
; 将块索引归零、清零两段缓冲区并清理缓存，然后提交状态字段指定的控制请求。
; Reset block index, clear both buffers and clean cache, then submit the state-selected control request.
.func P1_ResetDualBufferBuffers
	ldr r4,[pool_0232A548]	; 0232A4F0
	ldr r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A4F2
	cmp r0,#0x0	; 0232A4F4
	beq loc_0232A53E	; 0232A4F6
	mov r0,#0x0	; 0232A4F8
	str r0,[r4,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A4FA
	str r0,[sp,#0x0]	; 0232A4FC
	ldr r0,[sp,#0x0]	; 0232A4FE
	ldr r1,[r4,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A500
	ldr r2,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A502
	blx loc_0232DE3C	; 0232A504
	mov r0,#0x0	; 0232A508
	str r0,[sp,#0x4]	; 0232A50A
	ldr r0,[sp,#0x4]	; 0232A50C
	ldr r1,[r4,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A50E
	ldr r2,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A510
	blx loc_0232DE3C	; 0232A512
	ldr r0,[r4,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A516
	ldr r1,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A518
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A51A
	ldr r0,[r4,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A51E
	ldr r1,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A520
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A522
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A526
	cmp r0,#0x0	; 0232A528
	blt loc_0232A532	; 0232A52A
	mov r2,#0x1	; 0232A52C
	lsl r2,r0	; 0232A52E
	b loc_0232A534	; 0232A530
loc_0232A532:
	mov r2,#0x0	; 0232A532
loc_0232A534:
	ldr r0,[r4,#0x20]	; 0232A534
	ldr r1,[r4,#0x24]	; 0232A536
	mov r3,#0x0	; 0232A538
	bl loc_0232E138	; 0232A53A
loc_0232A53E:
	add sp,#0x8	; 0232A53E
	pop {r4}	; 0232A540
	pop {r3}	; 0232A542
	bx r3	; 0232A544
	.byte 0xC0, 0x46	; 0232A548
pool_0232A548:
.endfunc
loc_0232A548:
	.word P1_DualBufferProcessorState	; 0232A548

; ===== function loc_0232A54C =====
loc_0232A54C:
	push {r4,lr}	; 0232A54C
	ldr r1,[pool_0232A588]	; 0232A54E
; 处理器有效时，依据其配置字段提交控制掩码并完成相关状态更新。
; When active, submit a control mask from configuration fields and complete related state updates.
.func P1_ApplyDualBufferProcessorSettings
	ldr r0,[r1,#P1_DualBufferProcessorActiveOffset]	; 0232A550
	cmp r0,#0x0	; 0232A552
	beq loc_0232A580	; 0232A554
	ldr r0,[r1,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A556
	cmp r0,#0x0	; 0232A558
	blt loc_0232A562	; 0232A55A
	mov r2,#0x1	; 0232A55C
	lsl r2,r0	; 0232A55E
	b loc_0232A564	; 0232A560
loc_0232A562:
	mov r2,#0x0	; 0232A562
loc_0232A564:
	ldr r0,[r1,#0x20]	; 0232A564
	ldr r1,[r1,#0x24]	; 0232A566
	mov r3,#0x0	; 0232A568
	bl loc_0232E0F0	; 0232A56A
	bl loc_0232E308	; 0232A56E
	add r4,r0,#0x0	; 0232A572
	mov r0,#0x1	; 0232A574
	bl loc_0232E374	; 0232A576
	add r0,r4,#0x0	; 0232A57A
	bl loc_0232E328	; 0232A57C
loc_0232A580:
	pop {r4}	; 0232A580
	pop {r3}	; 0232A582
	bx r3	; 0232A584
	.byte 0xC0, 0x46	; 0232A588
pool_0232A588:
.endfunc
loc_0232A588:
	.word P1_DualBufferProcessorState	; 0232A588

; ===== function loc_0232A58C =====
loc_0232A58C:
	push {r4,r5,r6,r7,lr}	; 0232A58C
	sub sp,#0x4	; 0232A58E
; 停止处理器关联服务，处理登记资源后清除其有效标志。
; Stop associated services, process registered resources, then clear the active flag.
.func P1_StopDualBufferProcessor
	ldr r4,[pool_0232A61C]	; 0232A590
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A592
	cmp r0,#0x0	; 0232A594
	blt loc_0232A59C	; 0232A596
	mov r5,#0x1	; 0232A598
	b loc_0232A59E	; 0232A59A
loc_0232A59C:
	mov r5,#0x0	; 0232A59C
loc_0232A59E:
	cmp r5,#0x0	; 0232A59E
	beq loc_0232A5AA	; 0232A5A0
	mov r2,#0x1	; 0232A5A2
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A5A4
	lsl r2,r0	; 0232A5A6
	b loc_0232A5AC	; 0232A5A8
loc_0232A5AA:
	mov r2,#0x0	; 0232A5AA
loc_0232A5AC:
	ldr r0,[r4,#0x20]	; 0232A5AC
	ldr r1,[r4,#0x24]	; 0232A5AE
	mov r3,#0x0	; 0232A5B0
	bl loc_0232E0F0	; 0232A5B2
	cmp r5,#0x0	; 0232A5B6
	beq loc_0232A5DE	; 0232A5B8
	bl loc_0232E308	; 0232A5BA
	add r6,r0,#0x0	; 0232A5BE
	mov r0,#0x1	; 0232A5C0
	bl loc_0232E374	; 0232A5C2
	add r0,r6,#0x0	; 0232A5C6
	bl loc_0232E328	; 0232A5C8
	ldr r6,[pool_0232A620]	; 0232A5CC
	mov r7,#0x0	; 0232A5CE
loc_0232A5D0:
	add r0,r6,#0x0	; 0232A5D0
	add r1,r7,#0x0	; 0232A5D2
	add r2,r7,#0x0	; 0232A5D4
	bl loc_0232BA38	; 0232A5D6
	cmp r0,#0x0	; 0232A5DA
	bne loc_0232A5D0	; 0232A5DC
loc_0232A5DE:
	ldr r0,[r4,#0x24]	; 0232A5DE
	cmp r0,#0x0	; 0232A5E0
	beq loc_0232A5E8	; 0232A5E2
	bl loc_02329DF4	; 0232A5E4
loc_0232A5E8:
	ldr r0,[r4,#0x1c]	; 0232A5E8
	cmp r0,#0x0	; 0232A5EA
	beq loc_0232A5F2	; 0232A5EC
	bl loc_02329E20	; 0232A5EE
loc_0232A5F2:
	cmp r5,#0x0	; 0232A5F2
	beq loc_0232A5FC	; 0232A5F4
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A5F6
	bl loc_02329DB4	; 0232A5F8
loc_0232A5FC:
	ldr r0,[r4,#P1_DualBufferProcessorModeOffset]	; 0232A5FC
	cmp r0,#0x1	; 0232A5FE
	bne loc_0232A60E	; 0232A600
	mov r0,#0x0	; 0232A602
	add r1,r0,#0x0	; 0232A604
	add r2,r0,#0x0	; 0232A606
	add r3,r0,#0x0	; 0232A608
	bl loc_0232DFD8	; 0232A60A
loc_0232A60E:
	mov r0,#0x0	; 0232A60E
	str r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A610
	add sp,#0x4	; 0232A612
	pop {r4,r5,r6,r7}	; 0232A614
	pop {r3}	; 0232A616
	bx r3	; 0232A618
	.byte 0xC0, 0x46	; 0232A61C
pool_0232A61C:
.endfunc
loc_0232A61C:
	.word P1_DualBufferProcessorState	; 0232A61C
pool_0232A620:
loc_0232A620:
	.word 0x02356CC8	; 0232A620

; ===== function loc_0232A624 =====
loc_0232A624:
	push {r4,r5,r6,r7,lr}	; 0232A624
	sub sp,#0x44	; 0232A626
; 初始化双缓冲状态，保存缓冲区、分块信息、回调及其上下文，并登记块调度函数。
; Initialize two-buffer state, store buffers/block data/callback/context, and register the block dispatcher.
.func P1_CreateDualBufferProcessor
	str r0,[sp,#0x18]	; 0232A628
	str r1,[sp,#0x1c]	; 0232A62A
	str r2,[sp,#0x20]	; 0232A62C
	str r3,[sp,#0x24]	; 0232A62E
	ldr r7,[sp,#0x64]	; 0232A630
	ldr r0,[sp,#0x6c]	; 0232A632
	str r0,[sp,#0x6c]	; 0232A634
	mov r0,#0x0	; 0232A636
	str r0,[sp,#0x30]	; 0232A638
	mvn r5,r0	; 0232A63A
	ldr r4,[pool_0232A840]	; 0232A63C
	lsl r0,r1,#0	; 0232A63E
	lsl r1,r3,#0	; 0232A640
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A642
	ldr r0,[sp,#0x20]	; 0232A646
	ldr r1,[sp,#0x24]	; 0232A648
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A64A
	ldr r0,[sp,#0x58]	; 0232A64E
	cmp r0,#0x1	; 0232A650
	bne loc_0232A658	; 0232A652
	mov r6,#0x1	; 0232A654
	b loc_0232A65A	; 0232A656
loc_0232A658:
	mov r6,#0x0	; 0232A658
loc_0232A65A:
	ldr r0,[pool_0232A844]	; 0232A65A
	ldr r1,[sp,#0x68]	; 0232A65C
	blx P1_SignedDivMod	; 0232A65E
	str r0,[sp,#0x34]	; 0232A662
	ldr r0,[sp,#0x7c]	; 0232A664
	cmp r0,#0x0	; 0232A666
	beq loc_0232A6A4	; 0232A668
	ldr r0,[sp,#0x24]	; 0232A66A
	cmp r6,#0x0	; 0232A66C
	bne loc_0232A672	; 0232A66E
	asr r0,r0,#0x1	; 0232A670
loc_0232A672:
	ldr r1,[sp,#0x34]	; 0232A672
	add r1,#0x10	; 0232A674
	str r1,[sp,#0x34]	; 0232A676
	mov r2,#0x1f	; 0232A678
	bic r1,r2	; 0232A67A
	str r1,[sp,#0x34]	; 0232A67C
	asr r1,r1,#0x5	; 0232A67E
	str r1,[sp,#0x40]	; 0232A680
	ldr r1,[sp,#0x78]	; 0232A682
	blx P1_SignedDivMod	; 0232A684
	ldr r1,[sp,#0x40]	; 0232A688
	str r1,[sp,#0x38]	; 0232A68A
	mul r1,r0	; 0232A68C
	str r1,[sp,#0x38]	; 0232A68E
	mov r0,#0x20	; 0232A690
	str r0,[sp,#0x3c]	; 0232A692
	cmp r6,#0x0	; 0232A694
	bne loc_0232A69C	; 0232A696
	asr r0,r0,#0x1	; 0232A698
	str r0,[sp,#0x3c]	; 0232A69A
loc_0232A69C:
	ldr r1,[sp,#0x3c]	; 0232A69C
	ldr r0,[sp,#0x40]	; 0232A69E
	mul r1,r0	; 0232A6A0
	str r1,[sp,#0x3c]	; 0232A6A2
loc_0232A6A4:
	cmp r6,#0x0	; 0232A6A4
	beq loc_0232A6AE	; 0232A6A6
	mov r0,#0x0	; 0232A6A8
	str r0,[sp,#0x2c]	; 0232A6AA
	b loc_0232A6B2	; 0232A6AC
loc_0232A6AE:
	mov r0,#0x1	; 0232A6AE
	str r0,[sp,#0x2c]	; 0232A6B0
loc_0232A6B2:
	cmp r6,#0x0	; 0232A6B2
	beq loc_0232A6BC	; 0232A6B4
	mov r0,#0x1	; 0232A6B6
	str r0,[sp,#0x28]	; 0232A6B8
	b loc_0232A6C0	; 0232A6BA
loc_0232A6BC:
	mov r0,#0x0	; 0232A6BC
	str r0,[sp,#0x28]	; 0232A6BE
loc_0232A6C0:
	ldr r0,[sp,#0x18]	; 0232A6C0
	cmp r0,#0x2	; 0232A6C2
	beq loc_0232A6CA	; 0232A6C4
	mov r0,#0xa	; 0232A6C6
	str r0,[sp,#0x30]	; 0232A6C8
loc_0232A6CA:
	ldr r0,[sp,#0x7c]	; 0232A6CA
	cmp r0,#0x0	; 0232A6CC
	beq loc_0232A6E4	; 0232A6CE
	bl loc_02329DC8	; 0232A6D0
	add r5,r0,#0x0	; 0232A6D4
	cmp r5,#0x0	; 0232A6D6
	bge loc_0232A6E4	; 0232A6D8
	mov r0,#0x0	; 0232A6DA
	add sp,#0x44	; 0232A6DC
	pop {r4,r5,r6,r7}	; 0232A6DE
	pop {r3}	; 0232A6E0
	bx r3	; 0232A6E2
loc_0232A6E4:
	mov r0,#0x3	; 0232A6E4
	bl loc_02329E04	; 0232A6E6
	cmp r0,#0x0	; 0232A6EA
	bne loc_0232A702	; 0232A6EC
	cmp r5,#0x0	; 0232A6EE
	blt loc_0232A6F8	; 0232A6F0
	add r0,r5,#0x0	; 0232A6F2
	bl loc_02329DB4	; 0232A6F4
loc_0232A6F8:
	mov r0,#0x0	; 0232A6F8
	add sp,#0x44	; 0232A6FA
	pop {r4,r5,r6,r7}	; 0232A6FC
	pop {r3}	; 0232A6FE
	bx r3	; 0232A700
loc_0232A702:
	mov r0,#0xa	; 0232A702
	bl loc_02329E40	; 0232A704
	cmp r0,#0x0	; 0232A708
	bne loc_0232A726	; 0232A70A
	cmp r5,#0x0	; 0232A70C
	blt loc_0232A716	; 0232A70E
	add r0,r5,#0x0	; 0232A710
	bl loc_02329DB4	; 0232A712
loc_0232A716:
	mov r0,#0x3	; 0232A716
	bl loc_02329DF4	; 0232A718
	mov r0,#0x0	; 0232A71C
	add sp,#0x44	; 0232A71E
	pop {r4,r5,r6,r7}	; 0232A720
	pop {r3}	; 0232A722
	bx r3	; 0232A724
loc_0232A726:
	cmp r7,#0x0	; 0232A726
	beq loc_0232A72E	; 0232A728
	mov r3,#0x1	; 0232A72A
	b loc_0232A730	; 0232A72C
loc_0232A72E:
	mov r3,#0x2	; 0232A72E
loc_0232A730:
	ldr r0,[sp,#0x24]	; 0232A730
	lsr r6,r0,#0x2	; 0232A732
	mov r1,#0x0	; 0232A734
	str r1,[sp,#0x0]	; 0232A736
	str r6,[sp,#0x4]	; 0232A738
	ldr r0,[sp,#0x6c]	; 0232A73A
	str r0,[sp,#0x8]	; 0232A73C
	str r1,[sp,#0xc]	; 0232A73E
	ldr r0,[sp,#0x34]	; 0232A740
	str r0,[sp,#0x10]	; 0232A742
	ldr r0,[sp,#0x70]	; 0232A744
	str r0,[sp,#0x14]	; 0232A746
	mov r0,#0x1	; 0232A748
	ldr r1,[sp,#0x2c]	; 0232A74A
	ldr r2,[sp,#0x1c]	; 0232A74C
	bl loc_0232DFF8	; 0232A74E
	str r7,[sp,#0x0]	; 0232A752
	ldr r0,[sp,#0x5c]	; 0232A754
	str r0,[sp,#0x4]	; 0232A756
	ldr r0,[sp,#0x60]	; 0232A758
	str r0,[sp,#0x8]	; 0232A75A
	mov r0,#0x0	; 0232A75C
	ldr r1,[sp,#0x28]	; 0232A75E
	ldr r2,[sp,#0x1c]	; 0232A760
	add r3,r6,#0x0	; 0232A762
	bl loc_0232E0B4	; 0232A764
	cmp r7,#0x0	; 0232A768
	beq loc_0232A770	; 0232A76A
	mov r3,#0x1	; 0232A76C
	b loc_0232A772	; 0232A76E
loc_0232A770:
	mov r3,#0x2	; 0232A770
loc_0232A772:
	mov r1,#0x0	; 0232A772
	str r1,[sp,#0x0]	; 0232A774
	str r6,[sp,#0x4]	; 0232A776
	ldr r0,[sp,#0x6c]	; 0232A778
	str r0,[sp,#0x8]	; 0232A77A
	str r1,[sp,#0xc]	; 0232A77C
	ldr r0,[sp,#0x34]	; 0232A77E
	str r0,[sp,#0x10]	; 0232A780
	ldr r0,[sp,#0x74]	; 0232A782
	str r0,[sp,#0x14]	; 0232A784
	mov r0,#0x3	; 0232A786
	ldr r1,[sp,#0x2c]	; 0232A788
	ldr r2,[sp,#0x20]	; 0232A78A
	bl loc_0232DFF8	; 0232A78C
	str r7,[sp,#0x0]	; 0232A790
	ldr r0,[sp,#0x5c]	; 0232A792
	str r0,[sp,#0x4]	; 0232A794
	ldr r0,[sp,#0x60]	; 0232A796
	str r0,[sp,#0x8]	; 0232A798
	mov r0,#0x1	; 0232A79A
	ldr r1,[sp,#0x28]	; 0232A79C
	ldr r2,[sp,#0x20]	; 0232A79E
	add r3,r6,#0x0	; 0232A7A0
	bl loc_0232E0B4	; 0232A7A2
	cmp r5,#0x0	; 0232A7A6
	blt loc_0232A7BA	; 0232A7A8
	str r4,[sp,#0x0]	; 0232A7AA
	add r0,r5,#0x0	; 0232A7AC
	ldr r2,[sp,#0x38]	; 0232A7AE
	ldr r1,[sp,#0x3c]	; 0232A7B0
	add r1,r2,r1	; 0232A7B2
	ldr r3,[pool_0232A848]	; 0232A7B4
	bl loc_0232E08C	; 0232A7B6
loc_0232A7BA:
	ldr r0,[sp,#0x18]	; 0232A7BA
	cmp r0,#0x1	; 0232A7BC
	bne loc_0232A7CC	; 0232A7BE
	mov r0,#0x3	; 0232A7C0
	add r1,r0,#0x0	; 0232A7C2
	mov r2,#0x1	; 0232A7C4
	add r3,r2,#0x0	; 0232A7C6
	bl loc_0232DFD8	; 0232A7C8
loc_0232A7CC:
	cmp r5,#0x0	; 0232A7CC
	blt loc_0232A7D6	; 0232A7CE
	mov r2,#0x1	; 0232A7D0
	lsl r2,r5	; 0232A7D2
	b loc_0232A7D8	; 0232A7D4
loc_0232A7D6:
	mov r2,#0x0	; 0232A7D6
loc_0232A7D8:
	ldr r0,[sp,#0x30]	; 0232A7D8
	mov r1,#0x3	; 0232A7DA
	mov r3,#0x0	; 0232A7DC
	bl loc_0232E138	; 0232A7DE
	mov r0,#0x1	; 0232A7E2
	str r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A7E4
	ldr r0,[sp,#0x18]	; 0232A7E6
	str r0,[r4,#P1_DualBufferProcessorModeOffset]	; 0232A7E8
	mov r0,#0xa	; 0232A7EA
	str r0,[r4,#0x1c]	; 0232A7EC
	ldr r0,[sp,#0x30]	; 0232A7EE
	str r0,[r4,#0x20]	; 0232A7F0
	mov r0,#0x3	; 0232A7F2
	str r0,[r4,#0x24]	; 0232A7F4
	str r5,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A7F6
	ldr r0,[sp,#0x58]	; 0232A7F8
	str r0,[r4,#P1_DualBufferProcessorUserValueOffset]	; 0232A7FA
	ldr r0,[sp,#0x1c]	; 0232A7FC
	str r0,[r4,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A7FE
	ldr r0,[sp,#0x20]	; 0232A800
	str r0,[r4,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A802
	ldr r0,[sp,#0x24]	; 0232A804
	str r0,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A806
	mov r0,#0x0	; 0232A808
	str r0,[r4,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A80A
	ldr r0,[sp,#0x78]	; 0232A80C
	str r0,[r4,#P1_DualBufferProcessorBlockCountOffset]	; 0232A80E
	ldr r0,[sp,#0x7c]	; 0232A810
	str r0,[r4,#P1_DualBufferProcessorCallbackOffset]	; 0232A812
	ldr r0,[sp,#0x80]	; 0232A814
	str r0,[r4,#P1_DualBufferProcessorCallbackContextOffset]	; 0232A816
	ldr r0,[sp,#0x6c]	; 0232A818
	str r0,[r4,#P1_DualBufferProcessorLastReportedValueOffset]	; 0232A81A
	add r0,r4,#0x0	; 0232A81C
	add r0,#0x38	; 0232A81E
	bl loc_0232AFB8	; 0232A820
	add r0,r4,#0x0	; 0232A824
	add r0,#0x38	; 0232A826
	ldr r1,[sp,#0x6c]	; 0232A828
	lsl r1,r1,#0x8	; 0232A82A
	mov r2,#0x1	; 0232A82C
	bl loc_0232AF9C	; 0232A82E
	mov r0,#0x0	; 0232A832
	str r0,[r4,#0x48]	; 0232A834
	mov r0,#0x1	; 0232A836
	add sp,#0x44	; 0232A838
	pop {r4,r5,r6,r7}	; 0232A83A
	pop {r3}	; 0232A83C
	bx r3	; 0232A83E
pool_0232A840:
loc_0232A840:
.endfunc
	.word P1_DualBufferProcessorState	; 0232A840
pool_0232A844:
loc_0232A844:
	.word 0x00FFB0FF	; 0232A844
pool_0232A848:
loc_0232A848:
	.word P1_DispatchDualBufferBlock + 1	; 0232A848

; ===== function loc_0232A84C =====
loc_0232A84C:
	push {lr}	; 0232A84C
	sub sp,#0x4	; 0232A84E
; 仅当处理器已有效且模式字段为 1 时调用停止路径。
; Call the stop path only when the processor is active and its mode field is 1.
.func P1_StopActiveDualBufferProcessor
	ldr r0,[pool_0232A868]	; 0232A850
	ldr r1,[r0,#P1_DualBufferProcessorActiveOffset]	; 0232A852
	cmp r1,#0x0	; 0232A854
	beq loc_0232A862	; 0232A856
	ldr r0,[r0,#P1_DualBufferProcessorModeOffset]	; 0232A858
	cmp r0,#0x1	; 0232A85A
	bne loc_0232A862	; 0232A85C
	bl P1_StopDualBufferProcessor	; 0232A85E
loc_0232A862:
	add sp,#0x4	; 0232A862
	pop {r3}	; 0232A864
	bx r3	; 0232A866
pool_0232A868:
loc_0232A868:
.endfunc
	.word P1_DualBufferProcessorState	; 0232A868

; ===== function loc_0232A86C =====
loc_0232A86C:
	push {r4,r5,r6,r7,lr}	; 0232A86C
	sub sp,#0x34	; 0232A86E
; 清零并清理首个缓冲区，然后将参数转交给双缓冲对象构造器。
; Clear and clean the first buffer, then forward parameters to the two-buffer constructor.
.func P1_ConfigureDualBufferProcessor
	add r5,r0,#0x0	; 0232A870
	add r4,r1,#0x0	; 0232A872
	add r6,r2,#0x0	; 0232A874
	add r7,r3,#0x0	; 0232A876
	bl P1_StopActiveDualBufferProcessor	; 0232A878
	ldr r0,[pool_0232A8D8]	; 0232A87C
	ldr r0,[r0,#0x0]	; 0232A87E
	cmp r0,#0x0	; 0232A880
	beq loc_0232A88E	; 0232A882
	mov r0,#0x0	; 0232A884
	add sp,#0x34	; 0232A886
	pop {r4,r5,r6,r7}	; 0232A888
	pop {r3}	; 0232A88A
	bx r3	; 0232A88C
loc_0232A88E:
	mov r0,#0x0	; 0232A88E
	str r0,[sp,#0x2c]	; 0232A890
	ldr r0,[sp,#0x2c]	; 0232A892
	add r1,r5,#0x0	; 0232A894
	add r2,r4,#0x0	; 0232A896
	blx loc_0232DE3C	; 0232A898
	add r0,r5,#0x0	; 0232A89C
	add r1,r4,#0x0	; 0232A89E
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A8A0
	lsr r3,r4,#0x1	; 0232A8A4
	str r6,[sp,#0x0]	; 0232A8A6
	mov r2,#0x0	; 0232A8A8
	str r2,[sp,#0x4]	; 0232A8AA
	str r2,[sp,#0x8]	; 0232A8AC
	mov r0,#0x1	; 0232A8AE
	str r0,[sp,#0xc]	; 0232A8B0
	str r7,[sp,#0x10]	; 0232A8B2
	mov r1,#0x7f	; 0232A8B4
	str r1,[sp,#0x14]	; 0232A8B6
	str r2,[sp,#0x18]	; 0232A8B8
	str r1,[sp,#0x1c]	; 0232A8BA
	ldr r1,[sp,#0x48]	; 0232A8BC
	str r1,[sp,#0x20]	; 0232A8BE
	ldr r1,[sp,#0x4c]	; 0232A8C0
	str r1,[sp,#0x24]	; 0232A8C2
	ldr r1,[sp,#0x50]	; 0232A8C4
	str r1,[sp,#0x28]	; 0232A8C6
	add r1,r5,#0x0	; 0232A8C8
	add r2,r5,r3	; 0232A8CA
	bl P1_CreateDualBufferProcessor	; 0232A8CC
	add sp,#0x34	; 0232A8D0
	pop {r4,r5,r6,r7}	; 0232A8D2
	pop {r3}	; 0232A8D4
	bx r3	; 0232A8D6
pool_0232A8D8:
loc_0232A8D8:
.endfunc
	.word P1_DualBufferProcessorState	; 0232A8D8

; ===== function loc_0232A8DC =====
loc_0232A8DC:
	push {r4,r5,lr}	; 0232A8DC
	sub sp,#0x4	; 0232A8DE
; 轮询处理状态；出现终止条件时停止，否则在状态值改变时向下层提交更新。
; Poll processor status; stop on termination, otherwise submit a changed state value to the lower layer.
.func P1_UpdateDualBufferProcessorStatus
	ldr r4,[pool_0232A938]	; 0232A8E0
	ldr r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A8E2
	cmp r0,#0x0	; 0232A8E4
	beq loc_0232A92E	; 0232A8E6
	ldr r0,[r4,#P1_DualBufferProcessorModeOffset]	; 0232A8E8
	cmp r0,#0x0	; 0232A8EA
	bne loc_0232A92E	; 0232A8EC
	add r5,r4,#0x0	; 0232A8EE
	add r5,#0x38	; 0232A8F0
	add r0,r5,#0x0	; 0232A8F2
	bl loc_0232AF64	; 0232A8F4
	ldr r0,[r4,#0x48]	; 0232A8F8
	cmp r0,#0x0	; 0232A8FA
	beq loc_0232A914	; 0232A8FC
	add r0,r5,#0x0	; 0232A8FE
	bl loc_0232AF54	; 0232A900
	cmp r0,#0x0	; 0232A904
	beq loc_0232A914	; 0232A906
	bl P1_StopDualBufferProcessor	; 0232A908
	add sp,#0x4	; 0232A90C
	pop {r4,r5}	; 0232A90E
	pop {r3}	; 0232A910
	bx r3	; 0232A912
loc_0232A914:
	add r0,r5,#0x0	; 0232A914
	bl loc_0232AF74	; 0232A916
	asr r5,r0,#0x8	; 0232A91A
	ldr r0,[r4,#P1_DualBufferProcessorLastReportedValueOffset]	; 0232A91C
	cmp r5,r0	; 0232A91E
	beq loc_0232A92E	; 0232A920
	ldr r0,[r4,#0x20]	; 0232A922
	add r1,r5,#0x0	; 0232A924
	mov r2,#0x0	; 0232A926
	bl loc_0232E034	; 0232A928
	str r5,[r4,#P1_DualBufferProcessorLastReportedValueOffset]	; 0232A92C
loc_0232A92E:
	add sp,#0x4	; 0232A92E
	pop {r4,r5}	; 0232A930
	pop {r3}	; 0232A932
	bx r3	; 0232A934
	.byte 0xC0, 0x46	; 0232A938
pool_0232A938:
.endfunc
loc_0232A938:
	.word P1_DualBufferProcessorState	; 0232A938

; ===== function loc_0232A93C =====
loc_0232A93C:
	mov r1,#0x0	; 0232A93C
	ldr r0,[pool_0232A948]	; 0232A93E
; 清除处理器有效标志及延后交付队列开关。
; Clear the processor active flag and deferred-delivery queue gate.
.func P1_ClearDualBufferProcessorAndQueueState
	str r1,[r0,#0x0]	; 0232A940
	ldr r0,[pool_0232A94C]	; 0232A942
	str r1,[r0,#P1_DualBufferProcessorActiveOffset]	; 0232A944
	bx lr	; 0232A946
pool_0232A948:
loc_0232A948:
.endfunc
	.word P1_DualBufferDeferredQueueGate	; 0232A948
pool_0232A94C:
loc_0232A94C:
	.word P1_DualBufferProcessorState	; 0232A94C

; ===== function loc_0232A950 =====
loc_0232A950:
	ldr r1,[pool_0232A968]	; 0232A950
	ldr r1,[r1,#0x0]	; 0232A952
	ldr r2,[r1,#0x7c]	; 0232A954
	ldr r1,[r2,#0x8]	; 0232A956
	cmp r0,r1	; 0232A958
	bcc loc_0232A960	; 0232A95A
	mov r0,#0x0	; 0232A95C
	bx lr	; 0232A95E
loc_0232A960:
	lsl r0,r0,#0x4	; 0232A960
	add r0,r2,r0	; 0232A962
	ldr r0,[r0,#0x14]	; 0232A964
	bx lr	; 0232A966
pool_0232A968:
loc_0232A968:
	.word P1_BssStart + 0x2630C	; 0232A968

; ===== function loc_0232A96C =====
loc_0232A96C:
	ldr r1,[pool_0232A9B4]	; 0232A96C
	ldr r1,[r1,#0x0]	; 0232A96E
	add r2,r1,#0x0	; 0232A970
	add r2,#0x84	; 0232A972
	ldr r3,[r2,#0x0]	; 0232A974
	ldr r2,[r3,#0x18]	; 0232A976
	cmp r2,#0x0	; 0232A978
	bne loc_0232A980	; 0232A97A
	mov r3,#0x0	; 0232A97C
	b loc_0232A982	; 0232A97E
loc_0232A980:
	add r3,r3,r2	; 0232A980
loc_0232A982:
	cmp r3,#0x0	; 0232A982
	bne loc_0232A98A	; 0232A984
	mov r0,#0x0	; 0232A986
	bx lr	; 0232A988
loc_0232A98A:
	cmp r0,#0x0	; 0232A98A
	bge loc_0232A992	; 0232A98C
	mov r0,#0x0	; 0232A98E
	bx lr	; 0232A990
loc_0232A992:
	ldr r2,[r3,#0x0]	; 0232A992
	cmp r0,r2	; 0232A994
	bcc loc_0232A99C	; 0232A996
	mov r0,#0x0	; 0232A998
	bx lr	; 0232A99A
loc_0232A99C:
	lsl r0,r0,#0x2	; 0232A99C
	add r0,r3,r0	; 0232A99E
	ldr r2,[r0,#0x4]	; 0232A9A0
	add r1,#0x84	; 0232A9A2
	ldr r0,[r1,#0x0]	; 0232A9A4
	cmp r2,#0x0	; 0232A9A6
	bne loc_0232A9AE	; 0232A9A8
	mov r0,#0x0	; 0232A9AA
	bx lr	; 0232A9AC
loc_0232A9AE:
	add r0,r0,r2	; 0232A9AE
	bx lr	; 0232A9B0
	.byte 0xC0, 0x46	; 0232A9B4
pool_0232A9B4:
loc_0232A9B4:
	.word P1_BssStart + 0x2630C	; 0232A9B4

; ===== function loc_0232A9B8 =====
loc_0232A9B8:
	ldr r1,[pool_0232AA00]	; 0232A9B8
	ldr r1,[r1,#0x0]	; 0232A9BA
	add r2,r1,#0x0	; 0232A9BC
	add r2,#0x84	; 0232A9BE
	ldr r3,[r2,#0x0]	; 0232A9C0
	ldr r2,[r3,#0x14]	; 0232A9C2
	cmp r2,#0x0	; 0232A9C4
	bne loc_0232A9CC	; 0232A9C6
	mov r3,#0x0	; 0232A9C8
	b loc_0232A9CE	; 0232A9CA
loc_0232A9CC:
	add r3,r3,r2	; 0232A9CC
loc_0232A9CE:
	cmp r3,#0x0	; 0232A9CE
	bne loc_0232A9D6	; 0232A9D0
	mov r0,#0x0	; 0232A9D2
	bx lr	; 0232A9D4
loc_0232A9D6:
	cmp r0,#0x0	; 0232A9D6
	bge loc_0232A9DE	; 0232A9D8
	mov r0,#0x0	; 0232A9DA
	bx lr	; 0232A9DC
loc_0232A9DE:
	ldr r2,[r3,#0x0]	; 0232A9DE
	cmp r0,r2	; 0232A9E0
	bcc loc_0232A9E8	; 0232A9E2
	mov r0,#0x0	; 0232A9E4
	bx lr	; 0232A9E6
loc_0232A9E8:
	lsl r0,r0,#0x2	; 0232A9E8
	add r0,r3,r0	; 0232A9EA
	ldr r2,[r0,#0x4]	; 0232A9EC
	add r1,#0x84	; 0232A9EE
	ldr r0,[r1,#0x0]	; 0232A9F0
	cmp r2,#0x0	; 0232A9F2
	bne loc_0232A9FA	; 0232A9F4
	mov r0,#0x0	; 0232A9F6
	bx lr	; 0232A9F8
loc_0232A9FA:
	add r0,r0,r2	; 0232A9FA
	bx lr	; 0232A9FC
	.byte 0xC0, 0x46	; 0232AA00
pool_0232AA00:
loc_0232AA00:
	.word P1_BssStart + 0x2630C	; 0232AA00

; ===== function loc_0232AA04 =====
loc_0232AA04:
	ldr r1,[pool_0232AA4C]	; 0232AA04
	ldr r1,[r1,#0x0]	; 0232AA06
	add r2,r1,#0x0	; 0232AA08
	add r2,#0x84	; 0232AA0A
	ldr r3,[r2,#0x0]	; 0232AA0C
	ldr r2,[r3,#0x10]	; 0232AA0E
	cmp r2,#0x0	; 0232AA10
	bne loc_0232AA18	; 0232AA12
	mov r3,#0x0	; 0232AA14
	b loc_0232AA1A	; 0232AA16
loc_0232AA18:
	add r3,r3,r2	; 0232AA18
loc_0232AA1A:
	cmp r3,#0x0	; 0232AA1A
	bne loc_0232AA22	; 0232AA1C
	mov r0,#0x0	; 0232AA1E
	bx lr	; 0232AA20
loc_0232AA22:
	cmp r0,#0x0	; 0232AA22
	bge loc_0232AA2A	; 0232AA24
	mov r0,#0x0	; 0232AA26
	bx lr	; 0232AA28
loc_0232AA2A:
	ldr r2,[r3,#0x0]	; 0232AA2A
	cmp r0,r2	; 0232AA2C
	bcc loc_0232AA34	; 0232AA2E
	mov r0,#0x0	; 0232AA30
	bx lr	; 0232AA32
loc_0232AA34:
	lsl r0,r0,#0x2	; 0232AA34
	add r0,r3,r0	; 0232AA36
	ldr r2,[r0,#0x4]	; 0232AA38
	add r1,#0x84	; 0232AA3A
	ldr r0,[r1,#0x0]	; 0232AA3C
	cmp r2,#0x0	; 0232AA3E
	bne loc_0232AA46	; 0232AA40
	mov r0,#0x0	; 0232AA42
	bx lr	; 0232AA44
loc_0232AA46:
	add r0,r0,r2	; 0232AA46
	bx lr	; 0232AA48
	.byte 0xC0, 0x46	; 0232AA4C
pool_0232AA4C:
loc_0232AA4C:
	.word P1_BssStart + 0x2630C	; 0232AA4C

; ===== function loc_0232AA50 =====
loc_0232AA50:
	ldr r1,[pool_0232AA98]	; 0232AA50
	ldr r1,[r1,#0x0]	; 0232AA52
	add r2,r1,#0x0	; 0232AA54
	add r2,#0x84	; 0232AA56
	ldr r3,[r2,#0x0]	; 0232AA58
	ldr r2,[r3,#0xc]	; 0232AA5A
	cmp r2,#0x0	; 0232AA5C
	bne loc_0232AA64	; 0232AA5E
	mov r3,#0x0	; 0232AA60
	b loc_0232AA66	; 0232AA62
loc_0232AA64:
	add r3,r3,r2	; 0232AA64
loc_0232AA66:
	cmp r3,#0x0	; 0232AA66
	bne loc_0232AA6E	; 0232AA68
	mov r0,#0x0	; 0232AA6A
	bx lr	; 0232AA6C
loc_0232AA6E:
	cmp r0,#0x0	; 0232AA6E
	bge loc_0232AA76	; 0232AA70
	mov r0,#0x0	; 0232AA72
	bx lr	; 0232AA74
loc_0232AA76:
	ldr r2,[r3,#0x0]	; 0232AA76
	cmp r0,r2	; 0232AA78
	bcc loc_0232AA80	; 0232AA7A
	mov r0,#0x0	; 0232AA7C
	bx lr	; 0232AA7E
loc_0232AA80:
	lsl r0,r0,#0x2	; 0232AA80
	add r0,r3,r0	; 0232AA82
	ldr r2,[r0,#0x4]	; 0232AA84
	add r1,#0x84	; 0232AA86
	ldr r0,[r1,#0x0]	; 0232AA88
	cmp r2,#0x0	; 0232AA8A
	bne loc_0232AA92	; 0232AA8C
	mov r0,#0x0	; 0232AA8E
	bx lr	; 0232AA90
loc_0232AA92:
	add r0,r0,r2	; 0232AA92
	bx lr	; 0232AA94
	.byte 0xC0, 0x46	; 0232AA98
pool_0232AA98:
loc_0232AA98:
	.word P1_BssStart + 0x2630C	; 0232AA98

; ===== function loc_0232AA9C =====
loc_0232AA9C:
	ldr r0,[pool_0232AAA4]	; 0232AA9C
	ldr r0,[r0,#0x0]	; 0232AA9E
	bx lr	; 0232AAA0
	.byte 0xC0, 0x46	; 0232AAA4
pool_0232AAA4:
loc_0232AAA4:
	.word P1_BssStart + 0x2630C	; 0232AAA4

; ===== function loc_0232AAA8 =====
loc_0232AAA8:
	push {r4,r5,r6,r7,lr}	; 0232AAA8
	sub sp,#0x4	; 0232AAAA
	add r5,r0,#0x0	; 0232AAAC
	add r4,r1,#0x0	; 0232AAAE
	add r0,r4,#0x0	; 0232AAB0
	add r1,r5,#0x0	; 0232AAB2
	mov r2,#0x30	; 0232AAB4
	blx loc_0232DE50	; 0232AAB6
	ldr r0,[r5,#0x18]	; 0232AABA
	cmp r0,#0x0	; 0232AABC
	bne loc_0232AAC4	; 0232AABE
	mov r1,#0x0	; 0232AAC0
	b loc_0232AAC6	; 0232AAC2
loc_0232AAC4:
	add r1,r4,r0	; 0232AAC4
loc_0232AAC6:
	add r0,r5,#0x0	; 0232AAC6
	add r0,#0x84	; 0232AAC8
	str r1,[r0,#0x0]	; 0232AACA
	ldr r0,[r5,#0x20]	; 0232AACC
	cmp r0,#0x0	; 0232AACE
	bne loc_0232AAD6	; 0232AAD0
	mov r0,#0x0	; 0232AAD2
	b loc_0232AAD8	; 0232AAD4
loc_0232AAD6:
	add r0,r4,r0	; 0232AAD6
loc_0232AAD8:
	str r0,[r5,#0x7c]	; 0232AAD8
	ldr r0,[r5,#0x10]	; 0232AADA
	cmp r0,#0x0	; 0232AADC
	bne loc_0232AAE4	; 0232AADE
	mov r1,#0x0	; 0232AAE0
	b loc_0232AAE6	; 0232AAE2
loc_0232AAE4:
	add r1,r4,r0	; 0232AAE4
loc_0232AAE6:
	add r0,r5,#0x0	; 0232AAE6
	add r0,#0x80	; 0232AAE8
	str r1,[r0,#0x0]	; 0232AAEA
	mov r0,#0x0	; 0232AAEC
	ldr r3,[r5,#0x7c]	; 0232AAEE
	ldr r1,[r3,#0x8]	; 0232AAF0
	cmp r1,#0x0	; 0232AAF2
	bls loc_0232AB18	; 0232AAF4
	add r6,r0,#0x0	; 0232AAF6
	add r2,r0,#0x0	; 0232AAF8
loc_0232AAFA:
	add r3,#0xc	; 0232AAFA
	add r7,r3,r6	; 0232AAFC
	ldr r1,[r3,r6]	; 0232AAFE
	cmp r1,#0x0	; 0232AB00
	bne loc_0232AB08	; 0232AB02
	add r1,r2,#0x0	; 0232AB04
	b loc_0232AB0A	; 0232AB06
loc_0232AB08:
	add r1,r4,r1	; 0232AB08
loc_0232AB0A:
	str r1,[r7,#0x8]	; 0232AB0A
	add r6,#0x10	; 0232AB0C
	add r0,r0,#0x1	; 0232AB0E
	ldr r3,[r5,#0x7c]	; 0232AB10
	ldr r1,[r3,#0x8]	; 0232AB12
	cmp r0,r1	; 0232AB14
	bcc loc_0232AAFA	; 0232AB16
loc_0232AB18:
	ldr r0,[pool_0232AB24]	; 0232AB18
	str r5,[r0,#0x0]	; 0232AB1A
	add sp,#0x4	; 0232AB1C
	pop {r4,r5,r6,r7}	; 0232AB1E
	pop {r3}	; 0232AB20
	bx r3	; 0232AB22
pool_0232AB24:
loc_0232AB24:
	.word P1_BssStart + 0x2630C	; 0232AB24

; ===== function loc_0232AB28 =====
loc_0232AB28:
	push {r4,lr}	; 0232AB28
	bl loc_0232E308	; 0232AB2A
	add r4,r0,#0x0	; 0232AB2E
	mov r0,#0x1	; 0232AB30
	bl loc_0232E374	; 0232AB32
	add r0,r4,#0x0	; 0232AB36
	bl loc_0232E328	; 0232AB38
	pop {r4}	; 0232AB3C
	pop {r3}	; 0232AB3E
	bx r3	; 0232AB40
	.byte 0x00, 0x00	; 0232AB44

; ===== function loc_0232AB44 =====
loc_0232AB44:
	push {r4,r5,lr}	; 0232AB44
	sub sp,#0x4	; 0232AB46
	add r5,r0,#0x0	; 0232AB48
	ldr r0,[r5,#0x0]	; 0232AB4A
	mov r1,#0x14	; 0232AB4C
	mov r2,#0x4	; 0232AB4E
	bl loc_02329BD0	; 0232AB50
	add r4,r0,#0x0	; 0232AB54
	cmp r4,#0x0	; 0232AB56
	bne loc_0232AB64	; 0232AB58
	mov r0,#0x0	; 0232AB5A
	add sp,#0x4	; 0232AB5C
	pop {r4,r5}	; 0232AB5E
	pop {r3}	; 0232AB60
	bx r3	; 0232AB62
loc_0232AB64:
	bl loc_0232ABAC	; 0232AB64
	add r0,r5,#0x4	; 0232AB68
	add r1,r4,#0x0	; 0232AB6A
	bl loc_02329660	; 0232AB6C
	mov r0,#0x1	; 0232AB70
	add sp,#0x4	; 0232AB72
	pop {r4,r5}	; 0232AB74
	pop {r3}	; 0232AB76
	bx r3	; 0232AB78
	.byte 0x00, 0x00	; 0232AB7C

; ===== function loc_0232AB7C =====
loc_0232AB7C:
	push {r4,r5,lr}	; 0232AB7C
	sub sp,#0x4	; 0232AB7E
	add r5,r0,#0x0	; 0232AB80
	add r4,r1,#0x0	; 0232AB82
	add r0,r5,#0x4	; 0232AB84
	mov r1,#0xc	; 0232AB86
	bl loc_023296B4	; 0232AB88
	str r4,[r5,#0x0]	; 0232AB8C
	add r0,r5,#0x0	; 0232AB8E
	bl loc_0232AB44	; 0232AB90
	cmp r0,#0x0	; 0232AB94
	beq loc_0232ABA2	; 0232AB96
	mov r0,#0x1	; 0232AB98
	add sp,#0x4	; 0232AB9A
	pop {r4,r5}	; 0232AB9C
	pop {r3}	; 0232AB9E
	bx r3	; 0232ABA0
loc_0232ABA2:
	mov r0,#0x0	; 0232ABA2
	add sp,#0x4	; 0232ABA4
	pop {r4,r5}	; 0232ABA6
	pop {r3}	; 0232ABA8
	bx r3	; 0232ABAA

; ===== function loc_0232ABAC =====
loc_0232ABAC:
	mov r1,#0x0	; 0232ABAC
	ldr r3,[pool_0232ABB4]	; 0232ABAE
	bx r3	; 0232ABB0
	.byte 0xC0, 0x46	; 0232ABB4
pool_0232ABB4:
loc_0232ABB4:
	.word loc_023296B4 + 1	; 0232ABB4

; ===== function loc_0232ABB8 =====
loc_0232ABB8:
	push {r4,r5,r6,r7,lr}	; 0232ABB8
	sub sp,#0x4	; 0232ABBA
	add r5,r0,#0x0	; 0232ABBC
	add r6,r1,#0x0	; 0232ABBE
	add r7,r2,#0x0	; 0232ABC0
	str r3,[sp,#0x0]	; 0232ABC2
	ldr r0,[r5,#0x0]	; 0232ABC4
	add r1,#0x1f	; 0232ABC6
	mov r2,#0x1f	; 0232ABC8
	bic r1,r2	; 0232ABCA
	add r1,#0x20	; 0232ABCC
	mov r2,#0x20	; 0232ABCE
	bl loc_02329BD0	; 0232ABD0
	add r4,r0,#0x0	; 0232ABD4
	cmp r4,#0x0	; 0232ABD6
	bne loc_0232ABE4	; 0232ABD8
	mov r0,#0x0	; 0232ABDA
	add sp,#0x4	; 0232ABDC
	pop {r4,r5,r6,r7}	; 0232ABDE
	pop {r3}	; 0232ABE0
	bx r3	; 0232ABE2
loc_0232ABE4:
	add r0,r5,#0x4	; 0232ABE4
	mov r1,#0x0	; 0232ABE6
	bl loc_02329580	; 0232ABE8
	str r6,[r4,#0x8]	; 0232ABEC
	str r7,[r4,#0xc]	; 0232ABEE
	ldr r1,[sp,#0x0]	; 0232ABF0
	str r1,[r4,#0x10]	; 0232ABF2
	ldr r1,[sp,#0x18]	; 0232ABF4
	str r1,[r4,#0x14]	; 0232ABF6
	add r1,r4,#0x0	; 0232ABF8
	bl loc_02329660	; 0232ABFA
	add r4,#0x20	; 0232ABFE
	add r0,r4,#0x0	; 0232AC00
	add sp,#0x4	; 0232AC02
	pop {r4,r5,r6,r7}	; 0232AC04
	pop {r3}	; 0232AC06
	bx r3	; 0232AC08
	.byte 0x00, 0x00	; 0232AC0C

; ===== function loc_0232AC0C =====
loc_0232AC0C:
	push {r4,r5,r6,r7,lr}	; 0232AC0C
	sub sp,#0x4	; 0232AC0E
	add r7,r0,#0x0	; 0232AC10
	add r0,r7,#0x4	; 0232AC12
	mov r1,#0x0	; 0232AC14
	bl loc_02329580	; 0232AC16
	add r5,r0,#0x0	; 0232AC1A
	cmp r5,#0x0	; 0232AC1C
	beq loc_0232AC64	; 0232AC1E
loc_0232AC20:
	add r0,r5,#0x0	; 0232AC20
	mov r1,#0x0	; 0232AC22
	bl loc_02329580	; 0232AC24
	add r4,r0,#0x0	; 0232AC28
	cmp r4,#0x0	; 0232AC2A
	beq loc_0232AC4E	; 0232AC2C
loc_0232AC2E:
	ldr r6,[r4,#0xc]	; 0232AC2E
	cmp r6,#0x0	; 0232AC30
	beq loc_0232AC40	; 0232AC32
	add r0,r4,#0x0	; 0232AC34
	add r0,#0x20	; 0232AC36
	ldr r1,[r4,#0x8]	; 0232AC38
	ldr r2,[r4,#0x10]	; 0232AC3A
	ldr r3,[r4,#0x14]	; 0232AC3C
	blx r6	; 0232AC3E
loc_0232AC40:
	add r0,r5,#0x0	; 0232AC40
	add r1,r4,#0x0	; 0232AC42
	bl loc_02329580	; 0232AC44
	add r4,r0,#0x0	; 0232AC48
	cmp r4,#0x0	; 0232AC4A
	bne loc_0232AC2E	; 0232AC4C
loc_0232AC4E:
	add r0,r7,#0x4	; 0232AC4E
	add r1,r5,#0x0	; 0232AC50
	bl loc_023295A0	; 0232AC52
	add r0,r7,#0x4	; 0232AC56
	mov r1,#0x0	; 0232AC58
	bl loc_02329580	; 0232AC5A
	add r5,r0,#0x0	; 0232AC5E
	cmp r5,#0x0	; 0232AC60
	bne loc_0232AC20	; 0232AC62
loc_0232AC64:
	ldr r0,[r7,#0x0]	; 0232AC64
	mov r1,#0x3	; 0232AC66
	bl loc_02329BA4	; 0232AC68
	bl loc_0232AB28	; 0232AC6C
	add r0,r7,#0x0	; 0232AC70
	bl loc_0232AB44	; 0232AC72
	add sp,#0x4	; 0232AC76
	pop {r4,r5,r6,r7}	; 0232AC78
	pop {r3}	; 0232AC7A
	bx r3	; 0232AC7C
	.byte 0x00, 0x00	; 0232AC80

; ===== function loc_0232AC80 =====
loc_0232AC80:
	push {r4,lr}	; 0232AC80
	add r4,r0,#0x0	; 0232AC82
	bl loc_0232AC0C	; 0232AC84
	ldr r0,[r4,#0x0]	; 0232AC88
	bl loc_02329BFC	; 0232AC8A
	pop {r4}	; 0232AC8E
	pop {r3}	; 0232AC90
	bx r3	; 0232AC92

; ===== function loc_0232AC94 =====
loc_0232AC94:
	push {r4,r5,lr}	; 0232AC94
	sub sp,#0x4	; 0232AC96
	add r1,r0,r1	; 0232AC98
	add r4,r0,#0x3	; 0232AC9A
	mov r0,#0x3	; 0232AC9C
	bic r4,r0	; 0232AC9E
	cmp r4,r1	; 0232ACA0
	bls loc_0232ACAE	; 0232ACA2
	mov r0,#0x0	; 0232ACA4
	add sp,#0x4	; 0232ACA6
	pop {r4,r5}	; 0232ACA8
	pop {r3}	; 0232ACAA
	bx r3	; 0232ACAC
loc_0232ACAE:
	sub r1,r1,r4	; 0232ACAE
	cmp r1,#0x10	; 0232ACB0
	bcs loc_0232ACBE	; 0232ACB2
	mov r0,#0x0	; 0232ACB4
	add sp,#0x4	; 0232ACB6
	pop {r4,r5}	; 0232ACB8
	pop {r3}	; 0232ACBA
	bx r3	; 0232ACBC
loc_0232ACBE:
	add r0,r4,#0x0	; 0232ACBE
	add r0,#0x10	; 0232ACC0
	sub r1,#0x10	; 0232ACC2
	mov r2,#0x0	; 0232ACC4
	bl loc_02329C04	; 0232ACC6
	add r5,r0,#0x0	; 0232ACCA
	cmp r5,#0x0	; 0232ACCC
	bne loc_0232ACDA	; 0232ACCE
	mov r0,#0x0	; 0232ACD0
	add sp,#0x4	; 0232ACD2
	pop {r4,r5}	; 0232ACD4
	pop {r3}	; 0232ACD6
	bx r3	; 0232ACD8
loc_0232ACDA:
	add r0,r4,#0x0	; 0232ACDA
	add r1,r5,#0x0	; 0232ACDC
	bl loc_0232AB7C	; 0232ACDE
	cmp r0,#0x0	; 0232ACE2
	bne loc_0232ACF6	; 0232ACE4
	add r0,r5,#0x0	; 0232ACE6
	bl loc_02329BFC	; 0232ACE8
	mov r0,#0x0	; 0232ACEC
	add sp,#0x4	; 0232ACEE
	pop {r4,r5}	; 0232ACF0
	pop {r3}	; 0232ACF2
	bx r3	; 0232ACF4
loc_0232ACF6:
	add r0,r4,#0x0	; 0232ACF6
	add sp,#0x4	; 0232ACF8
	pop {r4,r5}	; 0232ACFA
	pop {r3}	; 0232ACFC
	bx r3	; 0232ACFE

; ===== function loc_0232AD00 =====
loc_0232AD00:
	push {r4,r5,r6,r7,lr}	; 0232AD00
	sub sp,#0xc	; 0232AD02
	str r0,[sp,#0x0]	; 0232AD04
	add r5,r1,#0x0	; 0232AD06
	add r6,r3,#0x0	; 0232AD08
	ldr r7,[sp,#0x20]	; 0232AD0A
	add r0,r2,#0x0	; 0232AD0C
	bl loc_0232AA04	; 0232AD0E
	add r4,r0,#0x0	; 0232AD12
	cmp r4,#0x0	; 0232AD14
	bne loc_0232AD22	; 0232AD16
	mov r0,#0x0	; 0232AD18
	add sp,#0xc	; 0232AD1A
	pop {r4,r5,r6,r7}	; 0232AD1C
	pop {r3}	; 0232AD1E
	bx r3	; 0232AD20
loc_0232AD22:
	ldr r0,[sp,#0x0]	; 0232AD22
	add r1,r5,#0x0	; 0232AD24
	add r2,r6,#0x0	; 0232AD26
	bl loc_0232A124	; 0232AD28
	str r0,[sp,#0x4]	; 0232AD2C
	cmp r0,#0x0	; 0232AD2E
	bne loc_0232AD3C	; 0232AD30
	mov r0,#0x0	; 0232AD32
	add sp,#0xc	; 0232AD34
	pop {r4,r5,r6,r7}	; 0232AD36
	pop {r3}	; 0232AD38
	bx r3	; 0232AD3A
loc_0232AD3C:
	ldr r0,[r4,#0x0]	; 0232AD3C
	bl loc_0232A950	; 0232AD3E
	add r6,r0,#0x0	; 0232AD42
	cmp r6,#0x0	; 0232AD44
	bne loc_0232AD58	; 0232AD46
	ldr r0,[sp,#0x4]	; 0232AD48
	bl loc_0232A11C	; 0232AD4A
	mov r0,#0x0	; 0232AD4E
	add sp,#0xc	; 0232AD50
	pop {r4,r5,r6,r7}	; 0232AD52
	pop {r3}	; 0232AD54
	bx r3	; 0232AD56
loc_0232AD58:
	mov r5,#0x0	; 0232AD58
loc_0232AD5A:
	ldrh r0,[r4,#0x4]	; 0232AD5A
	ldr r1,[pool_0232ADDC]	; 0232AD5C
	cmp r0,r1	; 0232AD5E
	beq loc_0232AD9E	; 0232AD60
	bl loc_0232A9B8	; 0232AD62
	cmp r0,#0x0	; 0232AD66
	bne loc_0232AD7A	; 0232AD68
	ldr r0,[sp,#0x4]	; 0232AD6A
	bl loc_0232A11C	; 0232AD6C
	mov r0,#0x0	; 0232AD70
	add sp,#0xc	; 0232AD72
	pop {r4,r5,r6,r7}	; 0232AD74
	pop {r3}	; 0232AD76
	bx r3	; 0232AD78
loc_0232AD7A:
	ldr r0,[r0,#0x0]	; 0232AD7A
	bl loc_0232A950	; 0232AD7C
	add r2,r0,#0x0	; 0232AD80
	cmp r2,#0x0	; 0232AD82
	bne loc_0232AD96	; 0232AD84
	ldr r0,[sp,#0x4]	; 0232AD86
	bl loc_0232A11C	; 0232AD88
	mov r0,#0x0	; 0232AD8C
	add sp,#0xc	; 0232AD8E
	pop {r4,r5,r6,r7}	; 0232AD90
	pop {r3}	; 0232AD92
	bx r3	; 0232AD94
loc_0232AD96:
	add r0,r6,#0x0	; 0232AD96
	add r1,r5,#0x0	; 0232AD98
	bl loc_0232E758	; 0232AD9A
loc_0232AD9E:
	add r4,r4,#0x2	; 0232AD9E
	add r5,r5,#0x1	; 0232ADA0
	cmp r5,#0x4	; 0232ADA2
	blt loc_0232AD5A	; 0232ADA4
	ldr r0,[sp,#0x4]	; 0232ADA6
	ldr r2,[sp,#0x24]	; 0232ADA8
	ldr r1,[r2,#0x18]	; 0232ADAA
	add r1,r2,r1	; 0232ADAC
	ldr r2,[r7,#0x0]	; 0232ADAE
	add r3,r6,#0x0	; 0232ADB0
	bl loc_0232A0F8	; 0232ADB2
	ldr r0,[sp,#0x0]	; 0232ADB6
	ldrb r1,[r7,#0x6]	; 0232ADB8
	bl loc_0232A224	; 0232ADBA
	ldr r0,[sp,#0x0]	; 0232ADBE
	ldrb r1,[r7,#0x7]	; 0232ADC0
	bl loc_0232A1E8	; 0232ADC2
	ldr r0,[sp,#0x0]	; 0232ADC6
	ldr r1,[sp,#0x28]	; 0232ADC8
	ldr r2,[sp,#0x2c]	; 0232ADCA
	bl loc_0232A19C	; 0232ADCC
	mov r0,#0x1	; 0232ADD0
	add sp,#0xc	; 0232ADD2
	pop {r4,r5,r6,r7}	; 0232ADD4
	pop {r3}	; 0232ADD6
	bx r3	; 0232ADD8
	.byte 0xC0, 0x46	; 0232ADDC
pool_0232ADDC:
loc_0232ADDC:
	.word 0x0000FFFF	; 0232ADDC

; ===== function loc_0232ADE0 =====
	push {r4,r5,r6,r7,lr}	; 0232ADE0
	sub sp,#0x14	; 0232ADE2
	str r0,[sp,#0x10]	; 0232ADE4
	add r5,r1,#0x0	; 0232ADE6
	add r4,r2,#0x0	; 0232ADE8
	add r6,r3,#0x0	; 0232ADEA
	ldr r0,[sp,#0x28]	; 0232ADEC
	bl loc_0232AA50	; 0232ADEE
	cmp r0,#0x0	; 0232ADF2
	bne loc_0232AE00	; 0232ADF4
	mov r0,#0x0	; 0232ADF6
	add sp,#0x14	; 0232ADF8
	pop {r4,r5,r6,r7}	; 0232ADFA
	pop {r3}	; 0232ADFC
	bx r3	; 0232ADFE
loc_0232AE00:
	ldr r0,[r0,#0x0]	; 0232AE00
	bl loc_0232A950	; 0232AE02
	add r7,r0,#0x0	; 0232AE06
	cmp r7,#0x0	; 0232AE08
	bne loc_0232AE16	; 0232AE0A
	mov r0,#0x0	; 0232AE0C
	add sp,#0x14	; 0232AE0E
	pop {r4,r5,r6,r7}	; 0232AE10
	pop {r3}	; 0232AE12
	bx r3	; 0232AE14
loc_0232AE16:
	ldr r1,[sp,#0x2c]	; 0232AE16
	bl loc_0232AF28	; 0232AE18
	cmp r0,#0x0	; 0232AE1C
	bne loc_0232AE2A	; 0232AE1E
	mov r0,#0x0	; 0232AE20
	add sp,#0x14	; 0232AE22
	pop {r4,r5,r6,r7}	; 0232AE24
	pop {r3}	; 0232AE26
	bx r3	; 0232AE28
loc_0232AE2A:
	cmp r6,#0x0	; 0232AE2A
	bge loc_0232AE30	; 0232AE2C
	ldrb r6,[r0,#0x8]	; 0232AE2E
loc_0232AE30:
	cmp r4,#0x0	; 0232AE30
	bge loc_0232AE36	; 0232AE32
	ldrh r4,[r0,#0x4]	; 0232AE34
loc_0232AE36:
	cmp r5,#0x0	; 0232AE36
	bge loc_0232AE3C	; 0232AE38
	ldrb r5,[r0,#0x9]	; 0232AE3A
loc_0232AE3C:
	str r0,[sp,#0x0]	; 0232AE3C
	str r7,[sp,#0x4]	; 0232AE3E
	ldr r0,[sp,#0x28]	; 0232AE40
	str r0,[sp,#0x8]	; 0232AE42
	ldr r0,[sp,#0x2c]	; 0232AE44
	str r0,[sp,#0xc]	; 0232AE46
	ldr r0,[sp,#0x10]	; 0232AE48
	add r1,r5,#0x0	; 0232AE4A
	add r2,r4,#0x0	; 0232AE4C
	add r3,r6,#0x0	; 0232AE4E
	bl loc_0232AD00	; 0232AE50
	add sp,#0x14	; 0232AE54
	pop {r4,r5,r6,r7}	; 0232AE56
	pop {r3}	; 0232AE58
	bx r3	; 0232AE5A
loc_0232AE5C:
	push {r4,r5,r6,r7,lr}	; 0232AE5C
	sub sp,#0x14	; 0232AE5E
	add r7,r0,#0x0	; 0232AE60
	add r5,r1,#0x0	; 0232AE62
	add r4,r2,#0x0	; 0232AE64
	add r0,r5,#0x0	; 0232AE66
	bl loc_0232AA50	; 0232AE68
	cmp r0,#0x0	; 0232AE6C
	bne loc_0232AE7A	; 0232AE6E
	mov r0,#0x0	; 0232AE70
	add sp,#0x14	; 0232AE72
	pop {r4,r5,r6,r7}	; 0232AE74
	pop {r3}	; 0232AE76
	bx r3	; 0232AE78
loc_0232AE7A:
	ldr r0,[r0,#0x0]	; 0232AE7A
	bl loc_0232A950	; 0232AE7C
	add r6,r0,#0x0	; 0232AE80
	cmp r6,#0x0	; 0232AE82
	bne loc_0232AE90	; 0232AE84
	mov r0,#0x0	; 0232AE86
	add sp,#0x14	; 0232AE88
	pop {r4,r5,r6,r7}	; 0232AE8A
	pop {r3}	; 0232AE8C
	bx r3	; 0232AE8E
loc_0232AE90:
	add r1,r4,#0x0	; 0232AE90
	bl loc_0232AF28	; 0232AE92
	add r3,r0,#0x0	; 0232AE96
	cmp r3,#0x0	; 0232AE98
	bne loc_0232AEA6	; 0232AE9A
	mov r0,#0x0	; 0232AE9C
	add sp,#0x14	; 0232AE9E
	pop {r4,r5,r6,r7}	; 0232AEA0
	pop {r3}	; 0232AEA2
	bx r3	; 0232AEA4
loc_0232AEA6:
	str r3,[sp,#0x0]	; 0232AEA6
	str r6,[sp,#0x4]	; 0232AEA8
	str r5,[sp,#0x8]	; 0232AEAA
	str r4,[sp,#0xc]	; 0232AEAC
	add r0,r7,#0x0	; 0232AEAE
	ldrb r1,[r3,#0x9]	; 0232AEB0
	ldrh r2,[r3,#0x4]	; 0232AEB2
	ldrb r3,[r3,#0x8]	; 0232AEB4
	bl loc_0232AD00	; 0232AEB6
	add sp,#0x14	; 0232AEBA
	pop {r4,r5,r6,r7}	; 0232AEBC
	pop {r3}	; 0232AEBE
	bx r3	; 0232AEC0
	.byte 0x00, 0x00	; 0232AEC4

; ===== function loc_0232AEC4 =====
loc_0232AEC4:
	push {r4,r5,r6,r7,lr}	; 0232AEC4
	sub sp,#0x4	; 0232AEC6
	add r7,r0,#0x0	; 0232AEC8
	bl loc_0232AA9C	; 0232AECA
	mov r6,#0x0	; 0232AECE
	str r6,[sp,#0x0]	; 0232AED0
loc_0232AED2:
	add r0,r6,#0x0	; 0232AED2
	bl loc_0232A96C	; 0232AED4
	add r5,r0,#0x0	; 0232AED8
	cmp r5,#0x0	; 0232AEDA
	beq loc_0232AF18	; 0232AEDC
	add r0,r6,#0x0	; 0232AEDE
	ldrb r1,[r5,#0x0]	; 0232AEE0
	bl loc_0232A2D0	; 0232AEE2
	ldr r0,[r5,#0x4]	; 0232AEE6
	cmp r0,#0x0	; 0232AEE8
	beq loc_0232AF18	; 0232AEEA
	cmp r7,#0x0	; 0232AEEC
	beq loc_0232AF18	; 0232AEEE
	ldr r4,[sp,#0x0]	; 0232AEF0
	ldrb r0,[r5,#0x0]	; 0232AEF2
	cmp r0,#0x0	; 0232AEF4
	ble loc_0232AF18	; 0232AEF6
loc_0232AEF8:
	add r0,r6,#0x0	; 0232AEF8
	add r1,r7,#0x0	; 0232AEFA
	ldr r2,[r5,#0x4]	; 0232AEFC
	bl loc_0232A264	; 0232AEFE
	cmp r0,#0x0	; 0232AF02
	bne loc_0232AF10	; 0232AF04
	mov r0,#0x0	; 0232AF06
	add sp,#0x4	; 0232AF08
	pop {r4,r5,r6,r7}	; 0232AF0A
	pop {r3}	; 0232AF0C
	bx r3	; 0232AF0E
loc_0232AF10:
	add r4,r4,#0x1	; 0232AF10
	ldrb r0,[r5,#0x0]	; 0232AF12
	cmp r4,r0	; 0232AF14
	blt loc_0232AEF8	; 0232AF16
loc_0232AF18:
	add r6,r6,#0x1	; 0232AF18
	cmp r6,#0x20	; 0232AF1A
	blt loc_0232AED2	; 0232AF1C
	mov r0,#0x1	; 0232AF1E
	add sp,#0x4	; 0232AF20
	pop {r4,r5,r6,r7}	; 0232AF22
	pop {r3}	; 0232AF24
	bx r3	; 0232AF26

; ===== function loc_0232AF28 =====
loc_0232AF28:
	cmp r1,#0x0	; 0232AF28
	bge loc_0232AF30	; 0232AF2A
	mov r0,#0x0	; 0232AF2C
	bx lr	; 0232AF2E
loc_0232AF30:
	ldr r2,[r0,#0x1c]	; 0232AF30
	cmp r1,r2	; 0232AF32
	bcc loc_0232AF3A	; 0232AF34
	mov r0,#0x0	; 0232AF36
	bx lr	; 0232AF38
loc_0232AF3A:
	add r0,#0x20	; 0232AF3A
	mov r2,#0xc	; 0232AF3C
	mul r1,r2	; 0232AF3E
	add r3,r0,r1	; 0232AF40
	ldr r2,[r0,r1]	; 0232AF42
	mov r0,#0x0	; 0232AF44
	mvn r1,r0	; 0232AF46
	cmp r2,r1	; 0232AF48
	bne loc_0232AF4E	; 0232AF4A
	add r3,r0,#0x0	; 0232AF4C
loc_0232AF4E:
	add r0,r3,#0x0	; 0232AF4E
	bx lr	; 0232AF50
	.byte 0x00, 0x00	; 0232AF54

; ===== function loc_0232AF54 =====
loc_0232AF54:
	ldr r1,[r0,#0x8]	; 0232AF54
	ldr r0,[r0,#0xc]	; 0232AF56
	cmp r1,r0	; 0232AF58
	blt loc_0232AF60	; 0232AF5A
	mov r0,#0x1	; 0232AF5C
	bx lr	; 0232AF5E
loc_0232AF60:
	mov r0,#0x0	; 0232AF60
	bx lr	; 0232AF62

; ===== function loc_0232AF64 =====
loc_0232AF64:
	ldr r2,[r0,#0x8]	; 0232AF64
	ldr r1,[r0,#0xc]	; 0232AF66
	cmp r2,r1	; 0232AF68
	bge loc_0232AF70	; 0232AF6A
	add r1,r2,#0x1	; 0232AF6C
	str r1,[r0,#0x8]	; 0232AF6E
loc_0232AF70:
	bx lr	; 0232AF70
	.byte 0x00, 0x00	; 0232AF74

; ===== function loc_0232AF74 =====
loc_0232AF74:
	push {r4,lr}	; 0232AF74
	ldr r1,[r0,#0xc]	; 0232AF76
	ldr r2,[r0,#0x8]	; 0232AF78
	cmp r2,r1	; 0232AF7A
	blt loc_0232AF86	; 0232AF7C
	ldr r0,[r0,#0x4]	; 0232AF7E
	pop {r4}	; 0232AF80
	pop {r3}	; 0232AF82
	bx r3	; 0232AF84
loc_0232AF86:
	ldr r4,[r0,#0x0]	; 0232AF86
	ldr r0,[r0,#0x4]	; 0232AF88
	sub r0,r0,r4	; 0232AF8A
	mul r2,r0	; 0232AF8C
	add r0,r2,#0x0	; 0232AF8E
	blx P1_SignedDivMod	; 0232AF90
	add r0,r4,r0	; 0232AF94
	pop {r4}	; 0232AF96
	pop {r3}	; 0232AF98
	bx r3	; 0232AF9A

; ===== function loc_0232AF9C =====
loc_0232AF9C:
	push {r4,r5,r6,lr}	; 0232AF9C
	add r5,r0,#0x0	; 0232AF9E
	add r4,r1,#0x0	; 0232AFA0
	add r6,r2,#0x0	; 0232AFA2
	bl loc_0232AF74	; 0232AFA4
	str r0,[r5,#0x0]	; 0232AFA8
	str r4,[r5,#0x4]	; 0232AFAA
	str r6,[r5,#0xc]	; 0232AFAC
	mov r0,#0x0	; 0232AFAE
	str r0,[r5,#0x8]	; 0232AFB0
	pop {r4,r5,r6}	; 0232AFB2
	pop {r3}	; 0232AFB4
	bx r3	; 0232AFB6

; ===== function loc_0232AFB8 =====
loc_0232AFB8:
	mov r2,#0x0	; 0232AFB8
	str r2,[r0,#0x4]	; 0232AFBA
	ldr r1,[r0,#0x4]	; 0232AFBC
	str r1,[r0,#0x0]	; 0232AFBE
	str r2,[r0,#0xc]	; 0232AFC0
	ldr r1,[r0,#0xc]	; 0232AFC2
	str r1,[r0,#0x8]	; 0232AFC4
	bx lr	; 0232AFC6
.arm

; ===== function loc_0232AFC8 =====
loc_0232AFC8:
	stmdb sp!,{r4,r5,r6,lr}	; 0232AFC8
	mov r5,r0	; 0232AFCC
	mov r4,r1	; 0232AFD0
	bl P1_Arm9DisableIrqReturnPriorMask	; 0232AFD4
	cmp r5,#0x0	; 0232AFD8
	beq loc_0232AFF8	; 0232AFDC
	ldr r1,[pool_0232B03C]	; 0232AFE0
	mvn r2,r4	; 0232AFE4
	add r1,r1,#0x3000	; 0232AFE8
	ldr r3,[r1,#0xff8]	; 0232AFEC
	and r2,r3,r2	; 0232AFF0
	str r2,[r1,#0xff8]	; 0232AFF4
loc_0232AFF8:
	bl P1_Arm9RestoreIrqMask	; 0232AFF8
	ldr r1,[pool_0232B03C]	; 0232AFFC
	add r0,r1,#0x3000	; 0232B000
	ldr r0,[r0,#0xff8]	; 0232B004
	ands r0,r4,r0	; 0232B008
	ldmneia sp!,{r4,r5,r6,lr}	; 0232B00C
	bxne lr	; 0232B010
	ldr r0,[pool_0232B040]	; 0232B014
	add r6,r1,r0	; 0232B018
	ldr r5,[pool_0232B044]	; 0232B01C
loc_0232B020:
	mov r0,r5	; 0232B020
	blx loc_0232B688	; 0232B024
	ldr r0,[r6,#0x0]	; 0232B028
	ands r0,r4,r0	; 0232B02C
	beq loc_0232B020	; 0232B030
	ldmia sp!,{r4,r5,r6,lr}	; 0232B034
	bx lr	; 0232B038
pool_0232B03C:
loc_0232B03C:
	.word P1_DtcmRuntimeStart	; 0232B03C
pool_0232B040:
loc_0232B040:
	.word 0x00003FF8	; 0232B040
pool_0232B044:
loc_0232B044:
	.word P1_DtcmRuntimeStart	; 0232B044
.thumb
P1_IrqHandler_0232B048:
	mov r0,#0x7	; 0232B048
	ldr r3,[pool_0232B050]	; 0232B04A
	bx r3	; 0232B04C
	.byte 0xC0, 0x46	; 0232B050
pool_0232B050:
loc_0232B050:
	.word loc_0232B0A8 + 1	; 0232B050
P1_IrqHandler_0232B054:
	mov r0,#0x6	; 0232B054
	ldr r3,[pool_0232B05C]	; 0232B056
	bx r3	; 0232B058
	.byte 0xC0, 0x46	; 0232B05C
pool_0232B05C:
loc_0232B05C:
	.word loc_0232B0A8 + 1	; 0232B05C
P1_IrqHandler_0232B060:
	mov r0,#0x5	; 0232B060
	ldr r3,[pool_0232B068]	; 0232B062
	bx r3	; 0232B064
	.byte 0xC0, 0x46	; 0232B068
pool_0232B068:
loc_0232B068:
	.word loc_0232B0A8 + 1	; 0232B068
P1_IrqHandler_0232B06C:
	mov r0,#0x4	; 0232B06C
	ldr r3,[pool_0232B074]	; 0232B06E
	bx r3	; 0232B070
	.byte 0xC0, 0x46	; 0232B074
pool_0232B074:
loc_0232B074:
	.word loc_0232B0A8 + 1	; 0232B074
P1_IrqHandler_0232B078:
	mov r0,#0x3	; 0232B078
	ldr r3,[pool_0232B080]	; 0232B07A
	bx r3	; 0232B07C
	.byte 0xC0, 0x46	; 0232B080
pool_0232B080:
loc_0232B080:
	.word loc_0232B0A8 + 1	; 0232B080
P1_IrqHandler_0232B084:
	mov r0,#0x2	; 0232B084
	ldr r3,[pool_0232B08C]	; 0232B086
	bx r3	; 0232B088
	.byte 0xC0, 0x46	; 0232B08C
pool_0232B08C:
loc_0232B08C:
	.word loc_0232B0A8 + 1	; 0232B08C
P1_IrqHandler_0232B090:
	mov r0,#0x1	; 0232B090
	ldr r3,[pool_0232B098]	; 0232B092
	bx r3	; 0232B094
	.byte 0xC0, 0x46	; 0232B098
pool_0232B098:
loc_0232B098:
	.word loc_0232B0A8 + 1	; 0232B098
P1_IrqHandler_0232B09C:
	mov r0,#0x0	; 0232B09C
	ldr r3,[pool_0232B0A4]	; 0232B09E
	bx r3	; 0232B0A0
	.byte 0xC0, 0x46	; 0232B0A4
pool_0232B0A4:
loc_0232B0A4:
	.word loc_0232B0A8 + 1	; 0232B0A4
loc_0232B0A8:
	push {r4,r5,lr}	; 0232B0A8
	sub sp,#0x4	; 0232B0AA
	mov r5,#0x1	; 0232B0AC
	lsl r2,r0,#0x1	; 0232B0AE
	ldr r1,[pool_0232B0F0]	; 0232B0B0
	ldrh r1,[r1,r2]	; 0232B0B2
	lsl r5,r1	; 0232B0B4
	mov r1,#0xc	; 0232B0B6
	add r4,r0,#0x0	; 0232B0B8
	mul r4,r1	; 0232B0BA
	ldr r2,[pool_0232B0F4]	; 0232B0BC
	ldr r1,[r2,r4]	; 0232B0BE
	mov r0,#0x0	; 0232B0C0
	str r0,[r2,r4]	; 0232B0C2
	cmp r1,#0x0	; 0232B0C4
	beq loc_0232B0CE	; 0232B0C6
	ldr r0,[pool_0232B0F8]	; 0232B0C8
	ldr r0,[r0,r4]	; 0232B0CA
	blx r1	; 0232B0CC
loc_0232B0CE:
	ldr r1,[pool_0232B0FC]	; 0232B0CE
	ldr r0,[pool_0232B100]	; 0232B0D0
	add r0,r1,r0	; 0232B0D2
	ldr r1,[r0,#0x0]	; 0232B0D4
	orr r1,r5	; 0232B0D6
	str r1,[r0,#0x0]	; 0232B0D8
	ldr r0,[pool_0232B104]	; 0232B0DA
	ldr r0,[r0,r4]	; 0232B0DC
	cmp r0,#0x0	; 0232B0DE
	bne loc_0232B0E8	; 0232B0E0
	add r0,r5,#0x0	; 0232B0E2
	bl loc_0232B134	; 0232B0E4
loc_0232B0E8:
	add sp,#0x4	; 0232B0E8
	pop {r4,r5}	; 0232B0EA
	pop {r3}	; 0232B0EC
	bx r3	; 0232B0EE
pool_0232B0F0:
loc_0232B0F0:
	.word P1_Data_02330A30	; 0232B0F0
pool_0232B0F4:
loc_0232B0F4:
	.word P1_BssStart + 0x26310	; 0232B0F4
pool_0232B0F8:
loc_0232B0F8:
	.word P1_BssStart + 0x26318	; 0232B0F8
pool_0232B0FC:
loc_0232B0FC:
	.word P1_DtcmRuntimeStart	; 0232B0FC
pool_0232B100:
loc_0232B100:
	.word 0x00003FF8	; 0232B100
pool_0232B104:
loc_0232B104:
	.word P1_BssStart + 0x26314	; 0232B104
P1_IrqHandler_0232B108:
	bx lr	; 0232B108
	.byte 0x00, 0x00	; 0232B10C

; ===== function loc_0232B10C =====
loc_0232B10C:
	push {r4}	; 0232B10C
	sub sp,#0x4	; 0232B10E
	ldr r4,[pool_0232B12C]	; 0232B110
	ldrh r3,[r4,#0x0]	; 0232B112
	mov r1,#0x0	; 0232B114
	strh r1,[r4,#0x0]	; 0232B116
	ldr r2,[pool_0232B130]	; 0232B118
	ldr r1,[r2,#0x0]	; 0232B11A
	str r0,[r2,#0x0]	; 0232B11C
	ldrh r0,[r4,#0x0]	; 0232B11E
	strh r3,[r4,#0x0]	; 0232B120
	add r0,r1,#0x0	; 0232B122
	add sp,#0x4	; 0232B124
	pop {r4}	; 0232B126
	bx lr	; 0232B128
	.byte 0xC0, 0x46	; 0232B12C
pool_0232B12C:
loc_0232B12C:
	.word REG_IME	; 0232B12C
pool_0232B130:
loc_0232B130:
	.word REG_IF	; 0232B130

; ===== function loc_0232B134 =====
loc_0232B134:
	push {r4,r5}	; 0232B134
	ldr r5,[pool_0232B154]	; 0232B136
	ldrh r4,[r5,#0x0]	; 0232B138
	mov r1,#0x0	; 0232B13A
	strh r1,[r5,#0x0]	; 0232B13C
	ldr r3,[pool_0232B158]	; 0232B13E
	ldr r2,[r3,#0x0]	; 0232B140
	add r1,r2,#0x0	; 0232B142
	bic r1,r0	; 0232B144
	str r1,[r3,#0x0]	; 0232B146
	ldrh r0,[r5,#0x0]	; 0232B148
	strh r4,[r5,#0x0]	; 0232B14A
	add r0,r2,#0x0	; 0232B14C
	pop {r4,r5}	; 0232B14E
	bx lr	; 0232B150
	.byte 0xC0, 0x46	; 0232B154
pool_0232B154:
loc_0232B154:
	.word REG_IME	; 0232B154
pool_0232B158:
loc_0232B158:
	.word REG_IE	; 0232B158

; ===== function loc_0232B15C =====
loc_0232B15C:
	push {r4,r5}	; 0232B15C
	ldr r5,[pool_0232B17C]	; 0232B15E
	ldrh r4,[r5,#0x0]	; 0232B160
	mov r1,#0x0	; 0232B162
	strh r1,[r5,#0x0]	; 0232B164
	ldr r3,[pool_0232B180]	; 0232B166
	ldr r2,[r3,#0x0]	; 0232B168
	add r1,r2,#0x0	; 0232B16A
	orr r1,r0	; 0232B16C
	str r1,[r3,#0x0]	; 0232B16E
	ldrh r0,[r5,#0x0]	; 0232B170
	strh r4,[r5,#0x0]	; 0232B172
	add r0,r2,#0x0	; 0232B174
	pop {r4,r5}	; 0232B176
	bx lr	; 0232B178
	.byte 0xC0, 0x46	; 0232B17C
pool_0232B17C:
loc_0232B17C:
	.word REG_IME	; 0232B17C
pool_0232B180:
loc_0232B180:
	.word REG_IE	; 0232B180

; ===== function loc_0232B184 =====
loc_0232B184:
	push {r4}	; 0232B184
	sub sp,#0x4	; 0232B186
	ldr r4,[pool_0232B1A4]	; 0232B188
	ldrh r3,[r4,#0x0]	; 0232B18A
	mov r1,#0x0	; 0232B18C
	strh r1,[r4,#0x0]	; 0232B18E
	ldr r2,[pool_0232B1A8]	; 0232B190
	ldr r1,[r2,#0x0]	; 0232B192
	str r0,[r2,#0x0]	; 0232B194
	ldrh r0,[r4,#0x0]	; 0232B196
	strh r3,[r4,#0x0]	; 0232B198
	add r0,r1,#0x0	; 0232B19A
	add sp,#0x4	; 0232B19C
	pop {r4}	; 0232B19E
	bx lr	; 0232B1A0
	.byte 0xC0, 0x46	; 0232B1A4
pool_0232B1A4:
loc_0232B1A4:
	.word REG_IME	; 0232B1A4
pool_0232B1A8:
loc_0232B1A8:
	.word REG_IE	; 0232B1A8

; ===== function loc_0232B1AC =====
loc_0232B1AC:
	push {r4,lr}	; 0232B1AC
	mov r3,#0xc	; 0232B1AE
	add r4,r0,#0x0	; 0232B1B0
	mul r4,r3	; 0232B1B2
	ldr r3,[pool_0232B1D4]	; 0232B1B4
	str r1,[r3,r4]	; 0232B1B6
	ldr r1,[pool_0232B1D8]	; 0232B1B8
	str r2,[r1,r4]	; 0232B1BA
	mov r1,#0x1	; 0232B1BC
	add r0,r0,#0x3	; 0232B1BE
	lsl r1,r0	; 0232B1C0
	add r0,r1,#0x0	; 0232B1C2
	bl loc_0232B15C	; 0232B1C4
	mov r1,#0x1	; 0232B1C8
	ldr r0,[pool_0232B1DC]	; 0232B1CA
	str r1,[r0,r4]	; 0232B1CC
	pop {r4}	; 0232B1CE
	pop {r3}	; 0232B1D0
	bx r3	; 0232B1D2
pool_0232B1D4:
loc_0232B1D4:
	.word P1_BssStart + 0x26340	; 0232B1D4
pool_0232B1D8:
loc_0232B1D8:
	.word P1_BssStart + 0x26348	; 0232B1D8
pool_0232B1DC:
loc_0232B1DC:
	.word P1_BssStart + 0x26344	; 0232B1DC

; ===== function loc_0232B1E0 =====
loc_0232B1E0:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P1_SetIrqHandlers
	push {r4,r5,r6,r7}	; 0232B1E0
	mov r6,#0x0	; 0232B1E2
	ldr r5,[pool_0232B23C]	; 0232B1E4
	add r4,r6,#0x0	; 0232B1E6
	add r2,r6,#0x0	; 0232B1E8
loc_0232B1EA:
	add r7,r0,#0x0	; 0232B1EA
	mov r3,#0x1	; 0232B1EC
	and r7,r3	; 0232B1EE
	cmp r7,#0x0	; 0232B1F0
	beq loc_0232B22E	; 0232B1F2
	add r7,r4,#0x0	; 0232B1F4
	cmp r6,#0x8	; 0232B1F6
	blt loc_0232B20C	; 0232B1F8
	cmp r6,#0xb	; 0232B1FA
	bgt loc_0232B20C	; 0232B1FC
	add r3,r6,#0x0	; 0232B1FE
	sub r3,#0x8	; 0232B200
	mov r7,#0xc	; 0232B202
	mul r3,r7	; 0232B204
	ldr r7,[pool_0232B240]	; 0232B206
	add r7,r7,r3	; 0232B208
	b loc_0232B222	; 0232B20A
loc_0232B20C:
	cmp r6,#0x3	; 0232B20C
	blt loc_0232B220	; 0232B20E
	cmp r6,#0x6	; 0232B210
	bgt loc_0232B220	; 0232B212
	add r3,r6,#0x1	; 0232B214
	mov r7,#0xc	; 0232B216
	mul r3,r7	; 0232B218
	ldr r7,[pool_0232B240]	; 0232B21A
	add r7,r7,r3	; 0232B21C
	b loc_0232B222	; 0232B21E
loc_0232B220:
	str r1,[r5,#0x0]	; 0232B220
loc_0232B222:
	cmp r7,#0x0	; 0232B222
	beq loc_0232B22E	; 0232B224
	str r1,[r7,#0x0]	; 0232B226
	str r2,[r7,#0x8]	; 0232B228
	mov r3,#0x1	; 0232B22A
	str r3,[r7,#0x4]	; 0232B22C
loc_0232B22E:
	lsr r0,r0,#0x1	; 0232B22E
	add r5,r5,#0x4	; 0232B230
	add r6,r6,#0x1	; 0232B232
	cmp r6,#0x16	; 0232B234
	blt loc_0232B1EA	; 0232B236
	pop {r4,r5,r6,r7}	; 0232B238
	bx lr	; 0232B23A
.endfunc
pool_0232B23C:
loc_0232B23C:
	.word P1_IrqHandlers	; 0232B23C
pool_0232B240:
loc_0232B240:
	.word 0x02356DD0	; 0232B240

; ===== function loc_0232B244 =====
loc_0232B244:
	mov r1,#0x0	; 0232B244
	ldr r0,[pool_0232B24C]	; 0232B246
	strh r1,[r0,#0x0]	; 0232B248
	bx lr	; 0232B24A
pool_0232B24C:
loc_0232B24C:
	.word P1_DtcmRuntimeStart	; 0232B24C

; ===== function loc_0232B250 =====
loc_0232B250:
	ldr r1,[pool_0232B254]	; 0232B250
	bx r1	; 0232B252
pool_0232B254:
loc_0232B254:
	.word loc_0232B39C + 1	; 0232B254

; ===== function loc_0232B258 =====
loc_0232B258:
	ldr r1,[pool_0232B25C]	; 0232B258
	bx r1	; 0232B25A
pool_0232B25C:
loc_0232B25C:
	.word loc_0232B338 + 1	; 0232B25C
.arm

; ===== function loc_0232B260 =====
loc_0232B260:
	ldr r3,[pool_0232B2B0]	; 0232B260
	ldr r1,[r3,#0x0]	; 0232B264
	clz r2,r1	; 0232B268
	cmp r2,#0x20	; 0232B26C
	movne r0,#0x40	; 0232B270
	bne loc_0232B294	; 0232B274
	add r3,r3,#0x4	; 0232B278
	ldr r1,[r3,#0x0]	; 0232B27C
	clz r2,r1	; 0232B280
	cmp r2,#0x20	; 0232B284
	ldr r0,[pool_0232B2B4]	; 0232B288
	bxeq lr	; 0232B28C
	mov r0,#0x60	; 0232B290
loc_0232B294:
	add r0,r0,r2	; 0232B294
	mov r1,#0x80000000	; 0232B298
	mov r1,r1, lsr r2	; 0232B29C
	ldr r2,[r3,#0x0]	; 0232B2A0
	bic r2,r2,r1	; 0232B2A4
	str r2,[r3,#0x0]	; 0232B2A8
	bx lr	; 0232B2AC
pool_0232B2B0:
loc_0232B2B0:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B2B0
pool_0232B2B4:
loc_0232B2B4:
	.word 0xFFFFFFFD	; 0232B2B4

; ===== function loc_0232B2B8 =====
loc_0232B2B8:
	ldr r3,[pool_0232B2E4]	; 0232B2B8
	cmp r0,#0x60	; 0232B2BC
	addpl r3,r3,#0x4	; 0232B2C0
	subpl r0,r0,#0x60	; 0232B2C4
	submi r0,r0,#0x40	; 0232B2C8
	mov r1,#0x80000000	; 0232B2CC
	mov r1,r1, lsr r0	; 0232B2D0
	ldr r2,[r3,#0x0]	; 0232B2D4
	orr r2,r2,r1	; 0232B2D8
	str r2,[r3,#0x0]	; 0232B2DC
	bx lr	; 0232B2E0
pool_0232B2E4:
loc_0232B2E4:
	.word 0x027FFFB0	; 0232B2E4
.thumb

; ===== function loc_0232B2E8 =====
loc_0232B2E8:
	ldr r0,[pool_0232B2F0]	; 0232B2E8
	ldr r3,[pool_0232B2F4]	; 0232B2EA
	bx r3	; 0232B2EC
	.byte 0xC0, 0x46	; 0232B2F0
pool_0232B2F0:
loc_0232B2F0:
	.word 0x00001000	; 0232B2F0
pool_0232B2F4:
loc_0232B2F4:
	.word P1_Arm9BusyWaitByLoop4	; 0232B2F4

; ===== function loc_0232B2F8 =====
loc_0232B2F8:
	ldrh r0,[r0,#0x4]	; 0232B2F8
	bx lr	; 0232B2FA
	ldr r1,[pool_0232B308]	; 0232B2FC
	ldrh r2,[r1,#0x0]	; 0232B2FE
	ldr r0,[pool_0232B30C]	; 0232B300
	orr r2,r0	; 0232B302
	strh r2,[r1,#0x0]	; 0232B304
	bx lr	; 0232B306
pool_0232B308:
loc_0232B308:
	.word REG_EXMEMCNT_ARM9	; 0232B308
pool_0232B30C:
loc_0232B30C:
	.word 0x00000800	; 0232B30C
	ldr r1,[pool_0232B31C]	; 0232B310
	ldrh r2,[r1,#0x0]	; 0232B312
	ldr r0,[pool_0232B320]	; 0232B314
	and r2,r0	; 0232B316
	strh r2,[r1,#0x0]	; 0232B318
	bx lr	; 0232B31A
pool_0232B31C:
loc_0232B31C:
	.word REG_EXMEMCNT_ARM9	; 0232B31C
pool_0232B320:
loc_0232B320:
	.word 0xFFFFF7FF	; 0232B320

; ===== function loc_0232B324 =====
loc_0232B324:
	ldr r1,[pool_0232B32C]	; 0232B324
	ldr r2,[pool_0232B330]	; 0232B326
	ldr r3,[pool_0232B334]	; 0232B328
	bx r3	; 0232B32A
pool_0232B32C:
loc_0232B32C:
	.word 0x027FFFE0	; 0232B32C
pool_0232B330:
loc_0232B330:
	.word 0x0232B311	; 0232B330
pool_0232B334:
loc_0232B334:
	.word loc_0232B3D4 + 1	; 0232B334

; ===== function loc_0232B338 =====
loc_0232B338:
	ldr r1,[pool_0232B340]	; 0232B338
	ldr r2,[pool_0232B344]	; 0232B33A
	ldr r3,[pool_0232B348]	; 0232B33C
	bx r3	; 0232B33E
pool_0232B340:
loc_0232B340:
	.word 0x027FFFE0	; 0232B340
pool_0232B344:
loc_0232B344:
	.word 0x0232B2FD	; 0232B344
pool_0232B348:
loc_0232B348:
	.word loc_0232B444 + 1	; 0232B348

; ===== function loc_0232B34C =====
loc_0232B34C:
	ldr r1,[pool_0232B354]	; 0232B34C
	ldr r2,[pool_0232B358]	; 0232B34E
	ldr r3,[pool_0232B35C]	; 0232B350
	bx r3	; 0232B352
pool_0232B354:
loc_0232B354:
	.word 0x027FFFE0	; 0232B354
pool_0232B358:
loc_0232B358:
	.word 0x0232B311	; 0232B358
pool_0232B35C:
loc_0232B35C:
	.word loc_0232B4AC + 1	; 0232B35C
	ldr r1,[pool_0232B36C]	; 0232B360
	ldrh r2,[r1,#0x0]	; 0232B362
	mov r0,#0x80	; 0232B364
	orr r2,r0	; 0232B366
	strh r2,[r1,#0x0]	; 0232B368
	bx lr	; 0232B36A
pool_0232B36C:
loc_0232B36C:
	.word REG_EXMEMCNT_ARM9	; 0232B36C
	ldr r1,[pool_0232B37C]	; 0232B370
	ldrh r2,[r1,#0x0]	; 0232B372
	mov r0,#0x80	; 0232B374
	bic r2,r0	; 0232B376
	strh r2,[r1,#0x0]	; 0232B378
	bx lr	; 0232B37A
pool_0232B37C:
loc_0232B37C:
	.word REG_EXMEMCNT_ARM9	; 0232B37C

; ===== function loc_0232B380 =====
loc_0232B380:
	push {lr}	; 0232B380
	sub sp,#0x4	; 0232B382
	ldr r1,[pool_0232B394]	; 0232B384
	ldr r2,[pool_0232B398]	; 0232B386
	mov r3,#0x1	; 0232B388
	bl loc_0232B3E4	; 0232B38A
	add sp,#0x4	; 0232B38E
	pop {r3}	; 0232B390
	bx r3	; 0232B392
pool_0232B394:
loc_0232B394:
	.word 0x027FFFE8	; 0232B394
pool_0232B398:
loc_0232B398:
	.word 0x0232B371	; 0232B398

; ===== function loc_0232B39C =====
loc_0232B39C:
	push {lr}	; 0232B39C
	sub sp,#0x4	; 0232B39E
	ldr r1,[pool_0232B3B0]	; 0232B3A0
	ldr r2,[pool_0232B3B4]	; 0232B3A2
	mov r3,#0x1	; 0232B3A4
	bl loc_0232B454	; 0232B3A6
	add sp,#0x4	; 0232B3AA
	pop {r3}	; 0232B3AC
	bx r3	; 0232B3AE
pool_0232B3B0:
loc_0232B3B0:
	.word 0x027FFFE8	; 0232B3B0
pool_0232B3B4:
loc_0232B3B4:
	.word 0x0232B361	; 0232B3B4

; ===== function loc_0232B3B8 =====
loc_0232B3B8:
	push {lr}	; 0232B3B8
	sub sp,#0x4	; 0232B3BA
	ldr r1,[pool_0232B3CC]	; 0232B3BC
	ldr r2,[pool_0232B3D0]	; 0232B3BE
	mov r3,#0x1	; 0232B3C0
	bl loc_0232B4BC	; 0232B3C2
	add sp,#0x4	; 0232B3C6
	pop {r3}	; 0232B3C8
	bx r3	; 0232B3CA
pool_0232B3CC:
loc_0232B3CC:
	.word 0x027FFFE8	; 0232B3CC
pool_0232B3D0:
loc_0232B3D0:
	.word 0x0232B371	; 0232B3D0
loc_0232B3D4:
	push {lr}	; 0232B3D4
	sub sp,#0x4	; 0232B3D6
	mov r3,#0x0	; 0232B3D8
	bl loc_0232B3E4	; 0232B3DA
	add sp,#0x4	; 0232B3DE
	pop {r3}	; 0232B3E0
	bx r3	; 0232B3E2

; ===== function loc_0232B3E4 =====
loc_0232B3E4:
	push {r4,r5,r6,r7,lr}	; 0232B3E4
	sub sp,#0xc	; 0232B3E6
	add r5,r0,#0x0	; 0232B3E8
	add r6,r1,#0x0	; 0232B3EA
	add r4,r2,#0x0	; 0232B3EC
	add r7,r3,#0x0	; 0232B3EE
	cmp r7,#0x0	; 0232B3F0
	beq loc_0232B3FC	; 0232B3F2
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B3F4
	str r0,[sp,#0x0]	; 0232B3F8
	b loc_0232B402	; 0232B3FA
loc_0232B3FC:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B3FC
	str r0,[sp,#0x0]	; 0232B400
loc_0232B402:
	add r0,r5,#0x0	; 0232B402
	add r1,r6,#0x0	; 0232B404
	blx loc_0232DF20	; 0232B406
	str r0,[sp,#0x4]	; 0232B40A
	cmp r0,#0x0	; 0232B40C
	bne loc_0232B418	; 0232B40E
	cmp r4,#0x0	; 0232B410
	beq loc_0232B416	; 0232B412
	blx r4	; 0232B414
loc_0232B416:
	strh r5,[r6,#0x4]	; 0232B416
loc_0232B418:
	cmp r7,#0x0	; 0232B418
	beq loc_0232B424	; 0232B41A
	ldr r0,[sp,#0x0]	; 0232B41C
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B41E
	b loc_0232B42A	; 0232B422
loc_0232B424:
	ldr r0,[sp,#0x0]	; 0232B424
	blx P1_Arm9RestoreIrqMask	; 0232B426
loc_0232B42A:
	ldr r0,[sp,#0x4]	; 0232B42A
	add sp,#0xc	; 0232B42C
	pop {r4,r5,r6,r7}	; 0232B42E
	pop {r3}	; 0232B430
	bx r3	; 0232B432

; ===== function loc_0232B434 =====
loc_0232B434:
	push {lr}	; 0232B434
	sub sp,#0x4	; 0232B436
	mov r3,#0x0	; 0232B438
	bl loc_0232B454	; 0232B43A
	add sp,#0x4	; 0232B43E
	pop {r3}	; 0232B440
	bx r3	; 0232B442

; ===== function loc_0232B444 =====
loc_0232B444:
	push {lr}	; 0232B444
	sub sp,#0x4	; 0232B446
	mov r3,#0x0	; 0232B448
	bl loc_0232B454	; 0232B44A
	add sp,#0x4	; 0232B44E
	pop {r3}	; 0232B450
	bx r3	; 0232B452

; ===== function loc_0232B454 =====
loc_0232B454:
	push {r4,r5,r6,r7,lr}	; 0232B454
	sub sp,#0x4	; 0232B456
	add r5,r1,#0x0	; 0232B458
	add r4,r2,#0x0	; 0232B45A
	add r6,r3,#0x0	; 0232B45C
	ldrh r1,[r5,#0x4]	; 0232B45E
	cmp r0,r1	; 0232B460
	beq loc_0232B470	; 0232B462
	mov r0,#0x1	; 0232B464
	mvn r0,r0	; 0232B466
	add sp,#0x4	; 0232B468
	pop {r4,r5,r6,r7}	; 0232B46A
	pop {r3}	; 0232B46C
	bx r3	; 0232B46E
loc_0232B470:
	cmp r6,#0x0	; 0232B470
	beq loc_0232B47C	; 0232B472
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B474
	add r7,r0,#0x0	; 0232B478
	b loc_0232B482	; 0232B47A
loc_0232B47C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B47C
	add r7,r0,#0x0	; 0232B480
loc_0232B482:
	mov r0,#0x0	; 0232B482
	strh r0,[r5,#0x4]	; 0232B484
	cmp r4,#0x0	; 0232B486
	beq loc_0232B48C	; 0232B488
	blx r4	; 0232B48A
loc_0232B48C:
	mov r0,#0x0	; 0232B48C
	str r0,[r5,#0x0]	; 0232B48E
	cmp r6,#0x0	; 0232B490
	beq loc_0232B49C	; 0232B492
	add r0,r7,#0x0	; 0232B494
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B496
	b loc_0232B4A2	; 0232B49A
loc_0232B49C:
	add r0,r7,#0x0	; 0232B49C
	blx P1_Arm9RestoreIrqMask	; 0232B49E
loc_0232B4A2:
	mov r0,#0x0	; 0232B4A2
	add sp,#0x4	; 0232B4A4
	pop {r4,r5,r6,r7}	; 0232B4A6
	pop {r3}	; 0232B4A8
	bx r3	; 0232B4AA

; ===== function loc_0232B4AC =====
loc_0232B4AC:
	push {lr}	; 0232B4AC
	sub sp,#0x4	; 0232B4AE
	mov r3,#0x0	; 0232B4B0
	bl loc_0232B4BC	; 0232B4B2
	add sp,#0x4	; 0232B4B6
	pop {r3}	; 0232B4B8
	bx r3	; 0232B4BA

; ===== function loc_0232B4BC =====
loc_0232B4BC:
	push {r4,r5,r6,r7,lr}	; 0232B4BC
	sub sp,#0x4	; 0232B4BE
	add r5,r0,#0x0	; 0232B4C0
	add r4,r1,#0x0	; 0232B4C2
	add r6,r2,#0x0	; 0232B4C4
	add r7,r3,#0x0	; 0232B4C6
	bl loc_0232B3E4	; 0232B4C8
	cmp r0,#0x0	; 0232B4CC
	ble loc_0232B4E4	; 0232B4CE
loc_0232B4D0:
	bl loc_0232B2E8	; 0232B4D0
	add r0,r5,#0x0	; 0232B4D4
	add r1,r4,#0x0	; 0232B4D6
	add r2,r6,#0x0	; 0232B4D8
	add r3,r7,#0x0	; 0232B4DA
	bl loc_0232B3E4	; 0232B4DC
	cmp r0,#0x0	; 0232B4E0
	bgt loc_0232B4D0	; 0232B4E2
loc_0232B4E4:
	add sp,#0x4	; 0232B4E4
	pop {r4,r5,r6,r7}	; 0232B4E6
	pop {r3}	; 0232B4E8
	bx r3	; 0232B4EA

; ===== function loc_0232B4EC =====
loc_0232B4EC:
	push {r4,lr}	; 0232B4EC
	sub sp,#0x8	; 0232B4EE
	ldr r0,[pool_0232B564]	; 0232B4F0
	ldr r1,[r0,#0x0]	; 0232B4F2
	cmp r1,#0x0	; 0232B4F4
	bne loc_0232B55A	; 0232B4F6
	mov r1,#0x1	; 0232B4F8
	str r1,[r0,#0x0]	; 0232B4FA
	mov r2,#0x0	; 0232B4FC
	ldr r1,[pool_0232B568]	; 0232B4FE
	str r2,[r1,#0x0]	; 0232B500
	mov r0,#0x7e	; 0232B502
	bl loc_0232B4AC	; 0232B504
	ldr r4,[pool_0232B568]	; 0232B508
	ldrh r0,[r4,#0x6]	; 0232B50A
	cmp r0,#0x0	; 0232B50C
	beq loc_0232B51A	; 0232B50E
loc_0232B510:
	bl loc_0232B2E8	; 0232B510
	ldrh r0,[r4,#0x6]	; 0232B514
	cmp r0,#0x0	; 0232B516
	bne loc_0232B510	; 0232B518
loc_0232B51A:
	mov r0,#0x0	; 0232B51A
	mvn r2,r0	; 0232B51C
	ldr r1,[pool_0232B56C]	; 0232B51E
	str r2,[r1,#0x0]	; 0232B520
	ldr r2,[pool_0232B570]	; 0232B522
	ldr r1,[pool_0232B574]	; 0232B524
	str r2,[r1,#0x0]	; 0232B526
	str r0,[sp,#0x0]	; 0232B528
	ldr r0,[sp,#0x0]	; 0232B52A
	ldr r1,[pool_0232B578]	; 0232B52C
	mov r2,#0x28	; 0232B52E
	blx loc_0232DE3C	; 0232B530
	ldr r2,[pool_0232B57C]	; 0232B534
	ldrh r1,[r2,#0x0]	; 0232B536
	ldr r0,[pool_0232B580]	; 0232B538
	orr r1,r0	; 0232B53A
	strh r1,[r2,#0x0]	; 0232B53C
	ldrh r1,[r2,#0x0]	; 0232B53E
	mov r0,#0x80	; 0232B540
	orr r1,r0	; 0232B542
	strh r1,[r2,#0x0]	; 0232B544
	mov r0,#0x7e	; 0232B546
	ldr r1,[pool_0232B568]	; 0232B548
	mov r2,#0x0	; 0232B54A
	bl loc_0232B444	; 0232B54C
	mov r0,#0x7f	; 0232B550
	ldr r1,[pool_0232B568]	; 0232B552
	mov r2,#0x0	; 0232B554
	bl loc_0232B4AC	; 0232B556
loc_0232B55A:
	add sp,#0x8	; 0232B55A
	pop {r4}	; 0232B55C
	pop {r3}	; 0232B55E
	bx r3	; 0232B560
	.byte 0xC0, 0x46	; 0232B564
pool_0232B564:
loc_0232B564:
	.word P1_BssStart + 0x26370	; 0232B564
pool_0232B568:
loc_0232B568:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 0232B568
pool_0232B56C:
loc_0232B56C:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B56C
pool_0232B570:
loc_0232B570:
	.word 0xFFFF0000	; 0232B570
pool_0232B574:
loc_0232B574:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset + 0x4	; 0232B574
pool_0232B578:
loc_0232B578:
	.word 0x027FFFC0	; 0232B578
pool_0232B57C:
loc_0232B57C:
	.word REG_EXMEMCNT_ARM9	; 0232B57C
pool_0232B580:
loc_0232B580:
	.word 0x00000800	; 0232B580

; ===== function loc_0232B584 =====
P1_ThreadEntry_0232B584:
	push {lr}	; 0232B584
	sub sp,#0x4	; 0232B586
	blx P1_Arm9EnableIrqReturnPriorMask	; 0232B588
loc_0232B58C:
	blx P1_Arm9WaitForInterrupt	; 0232B58C
	b loc_0232B58C	; 0232B590
	.byte 0x00, 0x00	; 0232B594

; ===== function loc_0232B594 =====
loc_0232B594:
	push {r4,r5,lr}	; 0232B594
	sub sp,#0x4	; 0232B596
	add r5,r0,#0x0	; 0232B598
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B59A
	ldr r1,[pool_0232B5B4]	; 0232B59E
	ldr r4,[r1,#0x10]	; 0232B5A0
	str r5,[r1,#0x10]	; 0232B5A2
	blx P1_Arm9RestoreIrqMask	; 0232B5A4
	add r0,r4,#0x0	; 0232B5A8
	add sp,#0x4	; 0232B5AA
	pop {r4,r5}	; 0232B5AC
	pop {r3}	; 0232B5AE
	bx r3	; 0232B5B0
	.byte 0xC0, 0x46	; 0232B5B4
pool_0232B5B4:
loc_0232B5B4:
	.word P1_BssStart + 0x26380	; 0232B5B4

; ===== function loc_0232B5B8 =====
loc_0232B5B8:
	push {r4,r5,r6,lr}	; 0232B5B8
	ldr r6,[pool_0232B61C]	; 0232B5BA
	ldrh r0,[r6,#0x4]	; 0232B5BC
	cmp r0,#0x0	; 0232B5BE
	bne loc_0232B5CA	; 0232B5C0
	blx P1_Arm9GetProcessorMode	; 0232B5C2
	cmp r0,#0x12	; 0232B5C6
	bne loc_0232B5D4	; 0232B5C8
loc_0232B5CA:
	mov r0,#0x1	; 0232B5CA
	strh r0,[r6,#0x0]	; 0232B5CC
	pop {r4,r5,r6}	; 0232B5CE
	pop {r3}	; 0232B5D0
	bx r3	; 0232B5D2
loc_0232B5D4:
	ldr r0,[pool_0232B620]	; 0232B5D4
	ldr r0,[r0,#0x0]	; 0232B5D6
	ldr r5,[r0,#0x0]	; 0232B5D8
	bl loc_0232B628	; 0232B5DA
	add r4,r0,#0x0	; 0232B5DE
	cmp r5,r4	; 0232B5E0
	beq loc_0232B616	; 0232B5E2
	cmp r4,#0x0	; 0232B5E4
	beq loc_0232B616	; 0232B5E6
	add r0,r5,#0x0	; 0232B5E8
	blx P1_SaveThreadContext	; 0232B5EA
	cmp r0,#0x0	; 0232B5EE
	bne loc_0232B616	; 0232B5F0
	ldr r0,[pool_0232B624]	; 0232B5F2
	ldr r2,[r0,#0x0]	; 0232B5F4
	cmp r2,#0x0	; 0232B5F6
	beq loc_0232B600	; 0232B5F8
	add r0,r5,#0x0	; 0232B5FA
	add r1,r4,#0x0	; 0232B5FC
	blx r2	; 0232B5FE
loc_0232B600:
	ldr r2,[r6,#0x10]	; 0232B600
	cmp r2,#0x0	; 0232B602
	beq loc_0232B60C	; 0232B604
	add r0,r5,#0x0	; 0232B606
	add r1,r4,#0x0	; 0232B608
	blx r2	; 0232B60A
loc_0232B60C:
	ldr r0,[pool_0232B61C]	; 0232B60C
	str r4,[r0,#0x8]	; 0232B60E
	add r0,r4,#0x0	; 0232B610
	blx P1_LoadThreadContext	; 0232B612
loc_0232B616:
	pop {r4,r5,r6}	; 0232B616
	pop {r3}	; 0232B618
	bx r3	; 0232B61A
pool_0232B61C:
loc_0232B61C:
	.word P1_BssStart + 0x26380	; 0232B61C
pool_0232B620:
loc_0232B620:
	.word P1_BssStart + 0x26378	; 0232B620
pool_0232B624:
loc_0232B624:
	.word P1_BssStart + 0x26374	; 0232B624

; ===== function loc_0232B628 =====
loc_0232B628:
	ldr r0,[pool_0232B63C]	; 0232B628
	ldr r0,[r0,#0xc]	; 0232B62A
	b loc_0232B630	; 0232B62C
loc_0232B62E:
	ldr r0,[r0,#0x68]	; 0232B62E
loc_0232B630:
	cmp r0,#0x0	; 0232B630
	beq loc_0232B63A	; 0232B632
	ldr r1,[r0,#0x64]	; 0232B634
	cmp r1,#0x1	; 0232B636
	bne loc_0232B62E	; 0232B638
loc_0232B63A:
	bx lr	; 0232B63A
pool_0232B63C:
loc_0232B63C:
	.word P1_BssStart + 0x26380	; 0232B63C

; ===== function loc_0232B640 =====
loc_0232B640:
	push {r4,r5,r6,lr}	; 0232B640
	add r5,r0,#0x0	; 0232B642
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B644
	add r4,r0,#0x0	; 0232B648
	ldrh r1,[r5,#0x0]	; 0232B64A
	cmp r1,#0x0	; 0232B64C
	beq loc_0232B678	; 0232B64E
	ldr r0,[pool_0232B684]	; 0232B650
	ldr r0,[r0,#0xc]	; 0232B652
	cmp r0,#0x0	; 0232B654
	beq loc_0232B670	; 0232B656
	mov r3,#0x1	; 0232B658
loc_0232B65A:
	ldr r2,[r0,#0x6c]	; 0232B65A
	add r6,r3,#0x0	; 0232B65C
	lsl r6,r2	; 0232B65E
	add r2,r1,#0x0	; 0232B660
	and r2,r6	; 0232B662
	cmp r2,#0x0	; 0232B664
	beq loc_0232B66A	; 0232B666
	str r3,[r0,#0x64]	; 0232B668
loc_0232B66A:
	ldr r0,[r0,#0x68]	; 0232B66A
	cmp r0,#0x0	; 0232B66C
	bne loc_0232B65A	; 0232B66E
loc_0232B670:
	mov r0,#0x0	; 0232B670
	strh r0,[r5,#0x0]	; 0232B672
	bl loc_0232B5B8	; 0232B674
loc_0232B678:
	add r0,r4,#0x0	; 0232B678
	blx P1_Arm9RestoreIrqMask	; 0232B67A
	pop {r4,r5,r6}	; 0232B67E
	pop {r3}	; 0232B680
	bx r3	; 0232B682
pool_0232B684:
loc_0232B684:
	.word P1_BssStart + 0x26380	; 0232B684

; ===== function loc_0232B688 =====
loc_0232B688:
	push {r4,r5,lr}	; 0232B688
	sub sp,#0x4	; 0232B68A
	add r5,r0,#0x0	; 0232B68C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B68E
	add r4,r0,#0x0	; 0232B692
	ldr r0,[pool_0232B6C4]	; 0232B694
	ldr r0,[r0,#0x0]	; 0232B696
	ldr r1,[r0,#0x0]	; 0232B698
	cmp r5,#0x0	; 0232B69A
	beq loc_0232B6AE	; 0232B69C
	ldrh r0,[r5,#0x0]	; 0232B69E
	mov r3,#0x1	; 0232B6A0
	ldr r2,[r1,#0x6c]	; 0232B6A2
	lsl r3,r2	; 0232B6A4
	lsl r2,r3,#0x10	; 0232B6A6
	lsr r2,r2,#0x10	; 0232B6A8
	orr r0,r2	; 0232B6AA
	strh r0,[r5,#0x0]	; 0232B6AC
loc_0232B6AE:
	mov r0,#0x0	; 0232B6AE
	str r0,[r1,#0x64]	; 0232B6B0
	bl loc_0232B5B8	; 0232B6B2
	add r0,r4,#0x0	; 0232B6B6
	blx P1_Arm9RestoreIrqMask	; 0232B6B8
	add sp,#0x4	; 0232B6BC
	pop {r4,r5}	; 0232B6BE
	pop {r3}	; 0232B6C0
	bx r3	; 0232B6C2
pool_0232B6C4:
loc_0232B6C4:
	.word P1_BssStart + 0x26378	; 0232B6C4
; 线程初始 LR 指向此处；清除 ID 表项并将线程标记为终止态。
; Initial thread LR points here; clear its ID slot and mark the thread terminated.
.func P1_ExitThread
	push {r4,lr}	; 0232B6C8
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B6CA
	ldr r0,[pool_0232B700]	; 0232B6CE
	ldr r0,[r0,#0x0]	; 0232B6D0
	ldr r4,[r0,#0x0]	; 0232B6D2
	add r0,r4,#0x0	; 0232B6D4
	bl loc_0232BB48	; 0232B6D6
	add r0,r4,#0x0	; 0232B6DA
	bl loc_0232B8B0	; 0232B6DC
	mov r2,#0x0	; 0232B6E0
	ldr r0,[r4,#0x6c]	; 0232B6E2
	lsl r1,r0,#0x2	; 0232B6E4
	ldr r0,[pool_0232B704]	; 0232B6E6
	str r2,[r0,r1]	; 0232B6E8
	mov r0,#0x2	; 0232B6EA
	str r0,[r4,#0x64]	; 0232B6EC
	add r4,#0x90	; 0232B6EE
	add r0,r4,#0x0	; 0232B6F0
	bl loc_0232B640	; 0232B6F2
	bl loc_0232B5B8	; 0232B6F6
	pop {r4}	; 0232B6FA
	pop {r3}	; 0232B6FC
	bx r3	; 0232B6FE
.endfunc
pool_0232B700:
loc_0232B700:
	.word P1_BssStart + 0x26378	; 0232B700
pool_0232B704:
loc_0232B704:
	.word P1_BssStart + 0x26394	; 0232B704

; ===== function loc_0232B708 =====
loc_0232B708:
; r0=线程，r1=入口，r2=参数，r3=栈顶；栈参数为大小/优先级。
; r0=thread, r1=entry, r2=argument, r3=stack top; stack arguments: size/priority.
.func P1_CreateThread
	push {r4,r5,r6,r7,lr}	; 0232B708
	sub sp,#0xc	; 0232B70A
	add r5,r0,#0x0	; 0232B70C
	str r1,[sp,#0x0]	; 0232B70E
	add r7,r2,#0x0	; 0232B710
	add r4,r3,#0x0	; 0232B712
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B714
	str r0,[sp,#0x4]	; 0232B718
	bl loc_0232B914	; 0232B71A
	cmp r0,#0x0	; 0232B71E
	bge loc_0232B730	; 0232B720
	ldr r0,[sp,#0x4]	; 0232B722
	blx P1_Arm9RestoreIrqMask	; 0232B724
	add sp,#0xc	; 0232B728
	pop {r4,r5,r6,r7}	; 0232B72A
	pop {r3}	; 0232B72C
	bx r3	; 0232B72E
loc_0232B730:
	ldr r1,[sp,#0x24]	; 0232B730
	str r1,[r5,#0x70]	; 0232B732
	str r0,[r5,#0x6c]	; 0232B734
	mov r1,#0x0	; 0232B736
	str r1,[r5,#0x64]	; 0232B738
	lsl r1,r0,#0x2	; 0232B73A
	ldr r0,[pool_0232B7AC]	; 0232B73C
	str r5,[r0,r1]	; 0232B73E
	add r0,r5,#0x0	; 0232B740
	bl loc_0232B8DC	; 0232B742
	add r0,r5,#0x0	; 0232B746
	add r0,#0x88	; 0232B748
	str r4,[r0,#0x0]	; 0232B74A
	ldr r0,[sp,#0x20]	; 0232B74C
	sub r6,r4,r0	; 0232B74E
	add r0,r5,#0x0	; 0232B750
	add r0,#0x84	; 0232B752
	str r6,[r0,#0x0]	; 0232B754
	mov r1,#0x0	; 0232B756
	add r0,r5,#0x0	; 0232B758
	add r0,#0x8c	; 0232B75A
	str r1,[r0,#0x0]	; 0232B75C
	ldr r0,[pool_0232B7B0]	; 0232B75E
	add r1,r5,#0x0	; 0232B760
	add r1,#0x88	; 0232B762
	ldr r1,[r1,#0x0]	; 0232B764
	sub r1,r1,#0x4	; 0232B766
	str r0,[r1,#0x0]	; 0232B768
	ldr r1,[pool_0232B7B4]	; 0232B76A
	add r0,r5,#0x0	; 0232B76C
	add r0,#0x84	; 0232B76E
	ldr r0,[r0,#0x0]	; 0232B770
	str r1,[r0,#0x0]	; 0232B772
	add r0,r5,#0x0	; 0232B774
	ldr r1,[sp,#0x0]	; 0232B776
	sub r2,r4,#0x4	; 0232B778
	blx P1_InitThreadContext	; 0232B77A
	str r7,[r5,#ThreadContextR0Offset]	; 0232B77E
	ldr r0,[pool_0232B7B8]	; 0232B780
	str r0,[r5,#ThreadContextLrOffset]	; 0232B782
	mov r0,#0x0	; 0232B784
	str r0,[sp,#0x8]	; 0232B786
	ldr r0,[sp,#0x8]	; 0232B788
	add r1,r6,#0x4	; 0232B78A
	ldr r2,[sp,#0x20]	; 0232B78C
	sub r2,#0x8	; 0232B78E
	blx loc_0232DE3C	; 0232B790
	mov r0,#0x0	; 0232B794
	str r0,[r5,#0x78]	; 0232B796
	str r0,[r5,#0x7c]	; 0232B798
	add r5,#0x80	; 0232B79A
	str r0,[r5,#0x0]	; 0232B79C
	ldr r0,[sp,#0x4]	; 0232B79E
	blx P1_Arm9RestoreIrqMask	; 0232B7A0
	add sp,#0xc	; 0232B7A4
	pop {r4,r5,r6,r7}	; 0232B7A6
	pop {r3}	; 0232B7A8
	bx r3	; 0232B7AA
.endfunc
pool_0232B7AC:
loc_0232B7AC:
	.word P1_BssStart + 0x26394	; 0232B7AC
pool_0232B7B0:
loc_0232B7B0:
	.word 0xFDDB597D	; 0232B7B0
pool_0232B7B4:
loc_0232B7B4:
	.word 0x7BF9DD5B	; 0232B7B4
pool_0232B7B8:
loc_0232B7B8:
	.word P1_ExitThread + 1	; 0232B7B8

; ===== function loc_0232B7BC =====
loc_0232B7BC:
	push {lr}	; 0232B7BC
	sub sp,#0xc	; 0232B7BE
	ldr r0,[pool_0232B86C]	; 0232B7C0
	ldr r1,[r0,#0x0]	; 0232B7C2
	cmp r1,#0x0	; 0232B7C4
	bne loc_0232B864	; 0232B7C6
	mov r1,#0x1	; 0232B7C8
	str r1,[r0,#0x0]	; 0232B7CA
	mov r1,#0x0	; 0232B7CC
	ldr r0,[pool_0232B870]	; 0232B7CE
	add r2,r1,#0x0	; 0232B7D0
loc_0232B7D2:
	str r2,[r0,#0x14]	; 0232B7D2
	add r0,r0,#0x4	; 0232B7D4
	add r1,r1,#0x1	; 0232B7D6
	cmp r1,#0x10	; 0232B7D8
	blt loc_0232B7D2	; 0232B7DA
	ldr r1,[pool_0232B874]	; 0232B7DC
	ldr r0,[pool_0232B878]	; 0232B7DE
	str r1,[r0,#0x0]	; 0232B7E0
	mov r0,#0x10	; 0232B7E2
	ldr r1,[pool_0232B87C]	; 0232B7E4
	str r0,[r1,#0x70]	; 0232B7E6
	str r2,[r1,#0x6c]	; 0232B7E8
	mov r0,#0x1	; 0232B7EA
	str r0,[r1,#0x64]	; 0232B7EC
	str r2,[r1,#0x68]	; 0232B7EE
	str r2,[r1,#0x74]	; 0232B7F0
	ldr r0,[pool_0232B870]	; 0232B7F2
	str r1,[r0,#0x14]	; 0232B7F4
	str r1,[r0,#0xc]	; 0232B7F6
	str r1,[r0,#0x8]	; 0232B7F8
	ldr r2,[pool_0232B880]	; 0232B7FA
	cmp r2,#0x0	; 0232B7FC
	bne loc_0232B806	; 0232B7FE
	ldr r0,[pool_0232B884]	; 0232B800
	sub r3,r0,r2	; 0232B802
	b loc_0232B812	; 0232B804
loc_0232B806:
	ldr r1,[pool_0232B888]	; 0232B806
	ldr r0,[pool_0232B88C]	; 0232B808
	add r1,r1,r0	; 0232B80A
	ldr r0,[pool_0232B890]	; 0232B80C
	sub r0,r1,r0	; 0232B80E
	sub r3,r0,r2	; 0232B810
loc_0232B812:
	ldr r1,[pool_0232B888]	; 0232B812
	ldr r0,[pool_0232B88C]	; 0232B814
	add r1,r1,r0	; 0232B816
	ldr r0,[pool_0232B890]	; 0232B818
	sub r1,r1,r0	; 0232B81A
	ldr r2,[pool_0232B894]	; 0232B81C
	str r1,[r2,#0x8]	; 0232B81E
	str r3,[r2,#0x4]	; 0232B820
	mov r0,#0x0	; 0232B822
	str r0,[r2,#0xc]	; 0232B824
	ldr r3,[pool_0232B898]	; 0232B826
	sub r1,r1,#0x4	; 0232B828
	str r3,[r1,#0x0]	; 0232B82A
	ldr r3,[pool_0232B89C]	; 0232B82C
	ldr r1,[r2,#0x4]	; 0232B82E
	str r3,[r1,#0x0]	; 0232B830
	strh r0,[r2,#0x10]	; 0232B832
	mov r2,#0x10	; 0232B834
	ldr r1,[pool_0232B870]	; 0232B836
	strh r2,[r1,#0x2]	; 0232B838
	strh r0,[r1,#0x0]	; 0232B83A
	strh r0,[r1,#0x4]	; 0232B83C
	ldr r2,[pool_0232B8A0]	; 0232B83E
	str r1,[r2,#0x0]	; 0232B840
	bl loc_0232B594	; 0232B842
	mov r0,#0xc8	; 0232B846
	str r0,[sp,#0x0]	; 0232B848
	mov r0,#0x1f	; 0232B84A
	str r0,[sp,#0x4]	; 0232B84C
	ldr r0,[pool_0232B8A4]	; 0232B84E
	ldr r1,[pool_0232B8A8]	; 0232B850
	mov r2,#0x0	; 0232B852
	ldr r3,[pool_0232B8AC]	; 0232B854
	bl P1_CreateThread	; 0232B856
	mov r1,#0x20	; 0232B85A
	ldr r0,[pool_0232B8A4]	; 0232B85C
	str r1,[r0,#0x70]	; 0232B85E
	mov r1,#0x1	; 0232B860
	str r1,[r0,#0x64]	; 0232B862
loc_0232B864:
	add sp,#0xc	; 0232B864
	pop {r3}	; 0232B866
	bx r3	; 0232B868
	.byte 0xC0, 0x46	; 0232B86C
pool_0232B86C:
loc_0232B86C:
	.word P1_BssStart + 0x2637C	; 0232B86C
pool_0232B870:
loc_0232B870:
	.word P1_BssStart + 0x26380	; 0232B870
pool_0232B874:
loc_0232B874:
	.word 0x02356E48	; 0232B874
pool_0232B878:
loc_0232B878:
	.word P1_BssStart + 0x26378	; 0232B878
pool_0232B87C:
loc_0232B87C:
	.word P1_BssStart + 0x26468	; 0232B87C
pool_0232B880:
loc_0232B880:
	.word 0x00000000	; 0232B880
pool_0232B884:
loc_0232B884:
	.word P1_DtcmRuntimeEnd	; 0232B884
pool_0232B888:
loc_0232B888:
	.word P1_DtcmRuntimeStart	; 0232B888
pool_0232B88C:
loc_0232B88C:
	.word 0x00003FC0	; 0232B88C
pool_0232B890:
loc_0232B890:
	.word 0x00001000	; 0232B890
pool_0232B894:
loc_0232B894:
	.word P1_BssStart + 0x264E8	; 0232B894
pool_0232B898:
loc_0232B898:
	.word 0xFDDB597D	; 0232B898
pool_0232B89C:
loc_0232B89C:
	.word 0x7BF9DD5B	; 0232B89C
pool_0232B8A0:
loc_0232B8A0:
	.word FirmwareSystemWorkAddress + SystemWorkArm9ThreadInfoOffset	; 0232B8A0
pool_0232B8A4:
loc_0232B8A4:
	.word P1_BssStart + 0x263D4	; 0232B8A4
pool_0232B8A8:
loc_0232B8A8:
	.word P1_ThreadEntry_0232B584 + 1	; 0232B8A8
pool_0232B8AC:
loc_0232B8AC:
	.word 0x02357084	; 0232B8AC

; ===== function loc_0232B8B0 =====
loc_0232B8B0:
	ldr r1,[pool_0232B8D8]	; 0232B8B0
	ldr r2,[r1,#0xc]	; 0232B8B2
	mov r1,#0x0	; 0232B8B4
	b loc_0232B8BC	; 0232B8B6
loc_0232B8B8:
	add r1,r2,#0x0	; 0232B8B8
	ldr r2,[r2,#0x68]	; 0232B8BA
loc_0232B8BC:
	cmp r2,#0x0	; 0232B8BC
	beq loc_0232B8C4	; 0232B8BE
	cmp r2,r0	; 0232B8C0
	bne loc_0232B8B8	; 0232B8C2
loc_0232B8C4:
	cmp r1,#0x0	; 0232B8C4
	bne loc_0232B8D0	; 0232B8C6
	ldr r1,[r0,#0x68]	; 0232B8C8
	ldr r0,[pool_0232B8D8]	; 0232B8CA
	str r1,[r0,#0xc]	; 0232B8CC
	bx lr	; 0232B8CE
loc_0232B8D0:
	ldr r0,[r0,#0x68]	; 0232B8D0
	str r0,[r1,#0x68]	; 0232B8D2
	bx lr	; 0232B8D4
	.byte 0xC0, 0x46	; 0232B8D8
pool_0232B8D8:
loc_0232B8D8:
	.word P1_BssStart + 0x26380	; 0232B8D8

; ===== function loc_0232B8DC =====
loc_0232B8DC:
	push {r4,r5}	; 0232B8DC
	ldr r1,[pool_0232B910]	; 0232B8DE
	ldr r3,[r1,#0xc]	; 0232B8E0
	add r5,r3,#0x0	; 0232B8E2
	mov r4,#0x0	; 0232B8E4
	b loc_0232B8EC	; 0232B8E6
loc_0232B8E8:
	add r4,r5,#0x0	; 0232B8E8
	ldr r5,[r5,#0x68]	; 0232B8EA
loc_0232B8EC:
	cmp r5,#0x0	; 0232B8EC
	beq loc_0232B8F8	; 0232B8EE
	ldr r2,[r5,#0x70]	; 0232B8F0
	ldr r1,[r0,#0x70]	; 0232B8F2
	cmp r2,r1	; 0232B8F4
	bcc loc_0232B8E8	; 0232B8F6
loc_0232B8F8:
	cmp r4,#0x0	; 0232B8F8
	bne loc_0232B906	; 0232B8FA
	str r3,[r0,#0x68]	; 0232B8FC
	ldr r1,[pool_0232B910]	; 0232B8FE
	str r0,[r1,#0xc]	; 0232B900
	pop {r4,r5}	; 0232B902
	bx lr	; 0232B904
loc_0232B906:
	ldr r1,[r4,#0x68]	; 0232B906
	str r1,[r0,#0x68]	; 0232B908
	str r0,[r4,#0x68]	; 0232B90A
	pop {r4,r5}	; 0232B90C
	bx lr	; 0232B90E
pool_0232B910:
loc_0232B910:
	.word P1_BssStart + 0x26380	; 0232B910

; ===== function loc_0232B914 =====
loc_0232B914:
	mov r0,#0x0	; 0232B914
	ldr r2,[pool_0232B92C]	; 0232B916
loc_0232B918:
	ldr r1,[r2,#0x14]	; 0232B918
	cmp r1,#0x0	; 0232B91A
	beq loc_0232B92A	; 0232B91C
	add r2,r2,#0x4	; 0232B91E
	add r0,r0,#0x1	; 0232B920
	cmp r0,#0x10	; 0232B922
	blt loc_0232B918	; 0232B924
	mov r0,#0x0	; 0232B926
	mvn r0,r0	; 0232B928
loc_0232B92A:
	bx lr	; 0232B92A
pool_0232B92C:
loc_0232B92C:
	.word P1_BssStart + 0x26380	; 0232B92C
.arm

; ===== function loc_0232B930 =====
loc_0232B930:
; r0=上下文，r1=入口，r2=栈顶；保存入口+4/状态，并留出 SVC 栈。
; r0=context, r1=entry, r2=stack top; save entry+4/state and reserve the SVC stack.
.func P1_InitThreadContext
	add r1,r1,#0x4	; 0232B930
	str r1,[r0,#ThreadContextPcPlus4Offset]	; 0232B934
	str r2,[r0,#ThreadContextSvcSpOffset]	; 0232B938
	sub r2,r2,#ThreadContextSvcStackBytes	; 0232B93C
	str r2,[r0,#ThreadContextSpOffset]	; 0232B940
	ands r1,r1,#0x1	; 0232B944
	movne r1,#0x3f	; 0232B948
	moveq r1,#0x1f	; 0232B94C
	str r1,[r0,#ThreadContextCpsrOffset]	; 0232B950
	mov r1,#0x0	; 0232B954
	str r1,[r0,#ThreadContextR0Offset]	; 0232B958
	str r1,[r0,#0x8]	; 0232B95C
	str r1,[r0,#0xc]	; 0232B960
	str r1,[r0,#0x10]	; 0232B964
	str r1,[r0,#0x14]	; 0232B968
	str r1,[r0,#0x18]	; 0232B96C
	str r1,[r0,#0x1c]	; 0232B970
	str r1,[r0,#0x20]	; 0232B974
	str r1,[r0,#0x24]	; 0232B978
	str r1,[r0,#0x28]	; 0232B97C
	str r1,[r0,#0x2c]	; 0232B980
	str r1,[r0,#0x30]	; 0232B984
	str r1,[r0,#0x34]	; 0232B988
	str r1,[r0,#ThreadContextLrOffset]	; 0232B98C
	bx lr	; 0232B990
.endfunc

; ===== function loc_0232B994 =====
loc_0232B994:
; 保存寄存器及状态；首次返回 0，恢复后从同一返回点返回 1。
; Save registers/state; return 0 now and 1 from the same return point after restoration.
.func P1_SaveThreadContext
	stmdb sp!,{r0,lr}	; 0232B994
	add r0,r0,#ThreadContextArithmeticOffset	; 0232B998
	ldr r1,[pool_0232B9DC]	; 0232B99C
	blx r1	; 0232B9A0
	ldmia sp!,{r0,lr}	; 0232B9A4
	add r1,r0,#0x0	; 0232B9A8
	mrs r2,cpsr	; 0232B9AC
	str r2,[r1],#0x4	; 0232B9B0
	mov r0,#0xd3	; 0232B9B4
	msr cpsr_c,r0	; 0232B9B8
	str sp,[r1,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 0232B9BC
	msr cpsr_c,r2	; 0232B9C0
	mov r0,#0x1	; 0232B9C4
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 0232B9C8
	adr r0,P1_SaveThreadContextReturn + 4	; 0232B9CC
	str r0,[r1,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 0232B9D0
	mov r0,#0x0	; 0232B9D4
P1_SaveThreadContextReturn:
	bx lr	; 0232B9D8
.endfunc
pool_0232B9DC:
loc_0232B9DC:
	.word P1_SaveArithmeticContext + 1	; 0232B9DC

; ===== function loc_0232B9E0 =====
loc_0232B9E0:
; 以 SVC 模式恢复状态和用户寄存器，再用已存 PC+4 恢复执行。
; Restore saved state/user registers in SVC mode, then resume via the saved PC+4.
.func P1_LoadThreadContext
	stmdb sp!,{r0,lr}	; 0232B9E0
	add r0,r0,#ThreadContextArithmeticOffset	; 0232B9E4
	ldr r1,[pool_0232BA20]	; 0232B9E8
	blx r1	; 0232B9EC
	ldmia sp!,{r0,lr}	; 0232B9F0
	mrs r1,cpsr	; 0232B9F4
	bic r1,r1,#0x1f	; 0232B9F8
	orr r1,r1,#0xd3	; 0232B9FC
	msr cpsr_c,r1	; 0232BA00
	ldr r1,[r0],#0x4	; 0232BA04
	msr spsr_cxsf,r1	; 0232BA08
	ldr sp,[r0,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 0232BA0C
	ldr lr,[r0,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 0232BA10
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 0232BA14
	mov r0,r0	; 0232BA18
	subs pc,lr,#0x4	; 0232BA1C
.endfunc
pool_0232BA20:
loc_0232BA20:
	.word P1_RestoreArithmeticContext + 1	; 0232BA20
.thumb

; ===== function loc_0232BA24 =====
loc_0232BA24:
	ldr r0,[pool_0232BA2C]	; 0232BA24
	ldr r1,[pool_0232BA30]	; 0232BA26
	str r0,[r1,#0x0]	; 0232BA28
	bx lr	; 0232BA2A
pool_0232BA2C:
loc_0232BA2C:
	.word 0x82000001	; 0232BA2C
pool_0232BA30:
loc_0232BA30:
	.word P1_Data_02330A98	; 0232BA30

; ===== function loc_0232BA34 =====
loc_0232BA34:
	mov r0,#0x0	; 0232BA34
	bx lr	; 0232BA36

; ===== function loc_0232BA38 =====
loc_0232BA38:
	push {r4,r5,r6,r7,lr}	; 0232BA38
	sub sp,#0x4	; 0232BA3A
	add r5,r0,#0x0	; 0232BA3C
	add r7,r1,#0x0	; 0232BA3E
	add r4,r2,#0x0	; 0232BA40
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BA42
	str r0,[sp,#0x0]	; 0232BA46
	ldr r0,[r5,#0x10]	; 0232BA48
	cmp r0,#0x0	; 0232BA4A
	bne loc_0232BA74	; 0232BA4C
	mov r0,#0x1	; 0232BA4E
	and r4,r0	; 0232BA50
	add r6,r5,#0x2	; 0232BA52
loc_0232BA54:
	cmp r4,#0x0	; 0232BA54
	bne loc_0232BA68	; 0232BA56
	ldr r0,[sp,#0x0]	; 0232BA58
	blx P1_Arm9RestoreIrqMask	; 0232BA5A
	mov r0,#0x0	; 0232BA5E
	add sp,#0x4	; 0232BA60
	pop {r4,r5,r6,r7}	; 0232BA62
	pop {r3}	; 0232BA64
	bx r3	; 0232BA66
loc_0232BA68:
	add r0,r6,#0x0	; 0232BA68
	bl loc_0232B688	; 0232BA6A
	ldr r0,[r5,#0x10]	; 0232BA6E
	cmp r0,#0x0	; 0232BA70
	beq loc_0232BA54	; 0232BA72
loc_0232BA74:
	cmp r7,#0x0	; 0232BA74
	beq loc_0232BA82	; 0232BA76
	ldr r1,[r5,#0x4]	; 0232BA78
	ldr r0,[r5,#0xc]	; 0232BA7A
	lsl r0,r0,#0x2	; 0232BA7C
	ldr r0,[r1,r0]	; 0232BA7E
	str r0,[r7,#0x0]	; 0232BA80
loc_0232BA82:
	ldr r0,[r5,#0xc]	; 0232BA82
	add r0,r0,#0x1	; 0232BA84
	ldr r1,[r5,#0x8]	; 0232BA86
	blx P1_SignedDivMod	; 0232BA88
	str r1,[r5,#0xc]	; 0232BA8C
	ldr r0,[r5,#0x10]	; 0232BA8E
	sub r0,r0,#0x1	; 0232BA90
	str r0,[r5,#0x10]	; 0232BA92
	add r0,r5,#0x0	; 0232BA94
	bl loc_0232B640	; 0232BA96
	ldr r0,[sp,#0x0]	; 0232BA9A
	blx P1_Arm9RestoreIrqMask	; 0232BA9C
	mov r0,#0x1	; 0232BAA0
	add sp,#0x4	; 0232BAA2
	pop {r4,r5,r6,r7}	; 0232BAA4
	pop {r3}	; 0232BAA6
	bx r3	; 0232BAA8
	.byte 0x00, 0x00	; 0232BAAC

; ===== function loc_0232BAAC =====
loc_0232BAAC:
	push {r4,r5,r6,r7,lr}	; 0232BAAC
	sub sp,#0x4	; 0232BAAE
	add r5,r0,#0x0	; 0232BAB0
	add r6,r1,#0x0	; 0232BAB2
	add r4,r2,#0x0	; 0232BAB4
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BAB6
	add r7,r0,#0x0	; 0232BABA
	ldr r2,[r5,#0x10]	; 0232BABC
	ldr r1,[r5,#0x8]	; 0232BABE
	cmp r1,r2	; 0232BAC0
	bgt loc_0232BAEA	; 0232BAC2
	mov r0,#0x1	; 0232BAC4
	and r4,r0	; 0232BAC6
loc_0232BAC8:
	cmp r4,#0x0	; 0232BAC8
	bne loc_0232BADC	; 0232BACA
	add r0,r7,#0x0	; 0232BACC
	blx P1_Arm9RestoreIrqMask	; 0232BACE
	mov r0,#0x0	; 0232BAD2
	add sp,#0x4	; 0232BAD4
	pop {r4,r5,r6,r7}	; 0232BAD6
	pop {r3}	; 0232BAD8
	bx r3	; 0232BADA
loc_0232BADC:
	add r0,r5,#0x0	; 0232BADC
	bl loc_0232B688	; 0232BADE
	ldr r2,[r5,#0x10]	; 0232BAE2
	ldr r1,[r5,#0x8]	; 0232BAE4
	cmp r1,r2	; 0232BAE6
	ble loc_0232BAC8	; 0232BAE8
loc_0232BAEA:
	ldr r0,[r5,#0xc]	; 0232BAEA
	add r0,r0,r2	; 0232BAEC
	blx P1_SignedDivMod	; 0232BAEE
	ldr r2,[r5,#0x4]	; 0232BAF2
	lsl r0,r1,#0x2	; 0232BAF4
	str r6,[r2,r0]	; 0232BAF6
	ldr r0,[r5,#0x10]	; 0232BAF8
	add r0,r0,#0x1	; 0232BAFA
	str r0,[r5,#0x10]	; 0232BAFC
	add r0,r5,#0x2	; 0232BAFE
	bl loc_0232B640	; 0232BB00
	add r0,r7,#0x0	; 0232BB04
	blx P1_Arm9RestoreIrqMask	; 0232BB06
	mov r0,#0x1	; 0232BB0A
	add sp,#0x4	; 0232BB0C
	pop {r4,r5,r6,r7}	; 0232BB0E
	pop {r3}	; 0232BB10
	bx r3	; 0232BB12
P1_Entry_0232BB14:
	mov r3,#0x0	; 0232BB14
	strh r3,[r0,#0x0]	; 0232BB16
	strh r3,[r0,#0x2]	; 0232BB18
	str r1,[r0,#0x4]	; 0232BB1A
	str r2,[r0,#0x8]	; 0232BB1C
	str r3,[r0,#0xc]	; 0232BB1E
	str r3,[r0,#0x10]	; 0232BB20
	bx lr	; 0232BB22

; ===== function loc_0232BB24 =====
loc_0232BB24:
	push {r4}	; 0232BB24
	sub sp,#0x4	; 0232BB26
	ldr r4,[r0,#0x7c]	; 0232BB28
	ldr r3,[r4,#0x10]	; 0232BB2A
	cmp r3,#0x0	; 0232BB2C
	bne loc_0232BB3A	; 0232BB2E
	mov r2,#0x0	; 0232BB30
	add r1,r0,#0x0	; 0232BB32
	add r1,#0x80	; 0232BB34
	str r2,[r1,#0x0]	; 0232BB36
	b loc_0232BB3E	; 0232BB38
loc_0232BB3A:
	mov r1,#0x0	; 0232BB3A
	str r1,[r3,#0xc]	; 0232BB3C
loc_0232BB3E:
	str r3,[r0,#0x7c]	; 0232BB3E
	add r0,r4,#0x0	; 0232BB40
	add sp,#0x4	; 0232BB42
	pop {r4}	; 0232BB44
	bx lr	; 0232BB46

; ===== function loc_0232BB48 =====
loc_0232BB48:
	push {r4,r5,lr}	; 0232BB48
	sub sp,#0x4	; 0232BB4A
	add r5,r0,#0x0	; 0232BB4C
	ldr r0,[r5,#0x7c]	; 0232BB4E
	cmp r0,#0x0	; 0232BB50
	beq loc_0232BB6A	; 0232BB52
	mov r4,#0x0	; 0232BB54
loc_0232BB56:
	add r0,r5,#0x0	; 0232BB56
	bl loc_0232BB24	; 0232BB58
	str r4,[r0,#0x8]	; 0232BB5C
	str r4,[r0,#0x4]	; 0232BB5E
	bl loc_0232B640	; 0232BB60
	ldr r0,[r5,#0x7c]	; 0232BB64
	cmp r0,#0x0	; 0232BB66
	bne loc_0232BB56	; 0232BB68
loc_0232BB6A:
	add sp,#0x4	; 0232BB6A
	pop {r4,r5}	; 0232BB6C
	pop {r3}	; 0232BB6E
	bx r3	; 0232BB70
	.byte 0x00, 0x00	; 0232BB74

; ===== function loc_0232BB74 =====
loc_0232BB74:
	mov r1,#0x0	; 0232BB74
	strh r1,[r0,#0x0]	; 0232BB76
	str r1,[r0,#0x4]	; 0232BB78
	str r1,[r0,#0x8]	; 0232BB7A
	bx lr	; 0232BB7C
	.byte 0x00, 0x00	; 0232BB80
.arm

; ===== function loc_0232BB80 =====
; 以 ARM946 cache index 遍历并清理整个 D-cache。
; Cleans the entire ARM946 D-cache by cache index.
.func P1_CleanEntireDataCacheByIndex
loc_0232BB80:
	mov r1,#0x0	; 0232BB80
loc_0232BB84:
	mov r0,#0x0	; 0232BB84
loc_0232BB88:
	orr r2,r1,r0	; 0232BB88
	mcr p15,0x0,r2,c7,c10,0x2	; 0232BB8C
	add r0,r0,#0x20	; 0232BB90
	cmp r0,#0x400	; 0232BB94
	blt loc_0232BB88	; 0232BB98
	add r1,r1,#0x40000000	; 0232BB9C
	cmp r1,#0x0	; 0232BBA0
	bne loc_0232BB84	; 0232BBA4
	bx lr	; 0232BBA8

.endfunc

; ===== function loc_0232BBAC =====
; 以 ARM946 cache index 遍历，清理并失效整个 D-cache。
; Cleans and invalidates the entire ARM946 D-cache by cache index.
.func P1_CleanAndInvalidateEntireDataCacheByIndex
loc_0232BBAC:
	mov r1,#0x0	; 0232BBAC
loc_0232BBB0:
	mov r0,#0x0	; 0232BBB0
loc_0232BBB4:
	orr r2,r1,r0	; 0232BBB4
	mcr p15,0x0,r2,c7,c14,0x2	; 0232BBB8
	add r0,r0,#0x20	; 0232BBBC
	cmp r0,#0x400	; 0232BBC0
	blt loc_0232BBB4	; 0232BBC4
	add r1,r1,#0x40000000	; 0232BBC8
	cmp r1,#0x0	; 0232BBCC
	bne loc_0232BBB0	; 0232BBD0
	bx lr	; 0232BBD4

.endfunc

; ===== function loc_0232BBD8 =====
; 按 ARM946 32 字节 cache line 失效指定的 D-cache 地址范围。
; Invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_InvalidateDataCacheRange
loc_0232BBD8:
	add r1,r1,r0	; 0232BBD8
	bic r0,r0,#0x1f	; 0232BBDC
loc_0232BBE0:
	mcr p15,0x0,r0,c7,c6,0x1	; 0232BBE0
	add r0,r0,#0x20	; 0232BBE4
	cmp r0,r1	; 0232BBE8
	blt loc_0232BBE0	; 0232BBEC
	bx lr	; 0232BBF0

.endfunc

; ===== function loc_0232BBF4 =====
; 按 ARM946 32 字节 cache line 清理指定的 D-cache 地址范围。
; Cleans a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanDataCacheRange
loc_0232BBF4:
	add r1,r1,r0	; 0232BBF4
	bic r0,r0,#0x1f	; 0232BBF8
loc_0232BBFC:
	mcr p15,0x0,r0,c7,c10,0x1	; 0232BBFC
	add r0,r0,#0x20	; 0232BC00
	cmp r0,r1	; 0232BC04
	blt loc_0232BBFC	; 0232BC08
	bx lr	; 0232BC0C

.endfunc

; ===== function loc_0232BC10 =====
; 按 ARM946 32 字节 cache line 清理并失效指定的 D-cache 地址范围。
; Cleans and invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanAndInvalidateDataCacheRange
loc_0232BC10:
	add r1,r1,r0	; 0232BC10
	bic r0,r0,#0x1f	; 0232BC14
loc_0232BC18:
	mcr p15,0x0,r0,c7,c14,0x1	; 0232BC18
	add r0,r0,#0x20	; 0232BC1C
	cmp r0,r1	; 0232BC20
	blt loc_0232BC18	; 0232BC24
	bx lr	; 0232BC28
.endfunc
.arm
; 排空 ARM946 写缓冲区，确保先前存储操作完成。
; Drains the ARM946 write buffer so prior stores complete.
.func P1_DrainWriteBuffer
loc_0232BC2C:
	mov r0,#0x0	; 0232BC2C
	mcr p15,0x0,r0,c7,c10,0x4	; 0232BC30
	bx lr	; 0232BC34
.endfunc
.thumb

; ===== function loc_0232BC38 =====
loc_0232BC38:
	push {lr}	; 0232BC38
	sub sp,#0x4	; 0232BC3A
	bl loc_0232BD60	; 0232BC3C
	bl loc_0232E7D4	; 0232BC40
	bl loc_0232B4EC	; 0232BC44
	bl loc_0232BD5C	; 0232BC48
	bl loc_0232B244	; 0232BC4C
	bl P1_InitExceptionHandler	; 0232BC50
	mov r0,#0x3	; 0232BC54
	bl loc_0232DD38	; 0232BC56
	bl loc_0232C458	; 0232BC5A
	bl loc_0232B7BC	; 0232BC5E
	bl loc_0232C784	; 0232BC62
	bl loc_0232F510	; 0232BC66
	add sp,#0x4	; 0232BC6A
	pop {r3}	; 0232BC6C
	bx r3	; 0232BC6E

; ===== function loc_0232BC70 =====
loc_0232BC70:
	lsl r2,r0,#0x2	; 0232BC70
	ldr r0,[pool_0232BC78]	; 0232BC72
	str r1,[r2,r0]	; 0232BC74
	bx lr	; 0232BC76
pool_0232BC78:
loc_0232BC78:
	.word 0x027FFDA0	; 0232BC78

; ===== function loc_0232BC7C =====
loc_0232BC7C:
	lsl r2,r0,#0x2	; 0232BC7C
	ldr r0,[pool_0232BC84]	; 0232BC7E
	str r1,[r2,r0]	; 0232BC80
	bx lr	; 0232BC82
pool_0232BC84:
loc_0232BC84:
	.word 0x027FFDC4	; 0232BC84

; ===== function loc_0232BC88 =====
loc_0232BC88:
	cmp r0,#0x6	; 0232BC88
	bhi loc_0232BCC0	; 0232BC8A
	add r0,r0,r0	; 0232BC8C
P1_SwitchIndexPC_0232BC8C:
	add r0,pc	; 0232BC8E
	ldrh r0,[r0,#(P1_SwitchTable_0232BC8C - (P1_SwitchIndexPC_0232BC8C + 4))]	; 0232BC90
	lsl r0,r0,#0x10	; 0232BC92
	asr r0,r0,#0x10	; 0232BC94
P1_SwitchTargetPC_0232BC8C:
	add r0,pc	; 0232BC96
	bx r0	; 0232BC98
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232BC8C:
	.halfword (loc_0232BCA8 + 1) - (P1_SwitchTargetPC_0232BC8C + 4)
	.halfword (loc_0232BCC0 + 1) - (P1_SwitchTargetPC_0232BC8C + 4)
	.halfword (loc_0232BCAC + 1) - (P1_SwitchTargetPC_0232BC8C + 4)
	.halfword (loc_0232BCB0 + 1) - (P1_SwitchTargetPC_0232BC8C + 4)
	.halfword (loc_0232BCB4 + 1) - (P1_SwitchTargetPC_0232BC8C + 4)
	.halfword (loc_0232BCB8 + 1) - (P1_SwitchTargetPC_0232BC8C + 4)
	.halfword (loc_0232BCBC + 1) - (P1_SwitchTargetPC_0232BC8C + 4)
P1_SwitchTable_0232BC8CEnd:
loc_0232BCA8:
	ldr r0,[pool_0232BCC4]	; 0232BCA8
	bx lr	; 0232BCAA
loc_0232BCAC:
	mov r0,#0x0	; 0232BCAC
	bx lr	; 0232BCAE
loc_0232BCB0:
	ldr r0,[pool_0232BCC8]	; 0232BCB0
	bx lr	; 0232BCB2
loc_0232BCB4:
	ldr r0,[pool_0232BCCC]	; 0232BCB4
	bx lr	; 0232BCB6
loc_0232BCB8:
	ldr r0,[pool_0232BCD0]	; 0232BCB8
	bx lr	; 0232BCBA
loc_0232BCBC:
	ldr r0,[pool_0232BCD4]	; 0232BCBC
	bx lr	; 0232BCBE
loc_0232BCC0:
	mov r0,#0x0	; 0232BCC0
	bx lr	; 0232BCC2
pool_0232BCC4:
loc_0232BCC4:
	.word P1_P345DecodeWorkspaceEnd	; 0232BCC4
pool_0232BCC8:
loc_0232BCC8:
	.word 0x01FF8320	; 0232BCC8
pool_0232BCCC:
loc_0232BCCC:
	.word P1_DtcmRuntimeEnd	; 0232BCCC
pool_0232BCD0:
loc_0232BCD0:
	.word 0x027FF000	; 0232BCD0
pool_0232BCD4:
loc_0232BCD4:
	.word Arm7SharedWramStart	; 0232BCD4

; ===== function loc_0232BCD8 =====
loc_0232BCD8:
	cmp r0,#0x6	; 0232BCD8
	bhi loc_0232BD32	; 0232BCDA
	add r0,r0,r0	; 0232BCDC
P1_SwitchIndexPC_0232BCDC:
	add r0,pc	; 0232BCDE
	ldrh r0,[r0,#(P1_SwitchTable_0232BCDC - (P1_SwitchIndexPC_0232BCDC + 4))]	; 0232BCE0
	lsl r0,r0,#0x10	; 0232BCE2
	asr r0,r0,#0x10	; 0232BCE4
P1_SwitchTargetPC_0232BCDC:
	add r0,pc	; 0232BCE6
	bx r0	; 0232BCE8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232BCDC:
	.halfword (loc_0232BCF8 + 1) - (P1_SwitchTargetPC_0232BCDC + 4)
	.halfword (loc_0232BD32 + 1) - (P1_SwitchTargetPC_0232BCDC + 4)
	.halfword (loc_0232BCFC + 1) - (P1_SwitchTargetPC_0232BCDC + 4)
	.halfword (loc_0232BD00 + 1) - (P1_SwitchTargetPC_0232BCDC + 4)
	.halfword (loc_0232BD04 + 1) - (P1_SwitchTargetPC_0232BCDC + 4)
	.halfword (loc_0232BD2A + 1) - (P1_SwitchTargetPC_0232BCDC + 4)
	.halfword (loc_0232BD2E + 1) - (P1_SwitchTargetPC_0232BCDC + 4)
P1_SwitchTable_0232BCDCEnd:
loc_0232BCF8:
	ldr r0,[pool_0232BD38]	; 0232BCF8
	bx lr	; 0232BCFA
loc_0232BCFC:
	mov r0,#0x0	; 0232BCFC
	bx lr	; 0232BCFE
loc_0232BD00:
	ldr r0,[pool_0232BD3C]	; 0232BD00
	bx lr	; 0232BD02
loc_0232BD04:
	ldr r0,[pool_0232BD40]	; 0232BD04
	ldr r1,[pool_0232BD44]	; 0232BD06
	add r2,r0,r1	; 0232BD08
	ldr r1,[pool_0232BD48]	; 0232BD0A
	sub r2,r2,r1	; 0232BD0C
	ldr r1,[pool_0232BD4C]	; 0232BD0E
	cmp r1,#0x0	; 0232BD10
	bne loc_0232BD1E	; 0232BD12
	ldr r1,[pool_0232BD50]	; 0232BD14
	cmp r0,r1	; 0232BD16
	bcs loc_0232BD34	; 0232BD18
	add r0,r1,#0x0	; 0232BD1A
	bx lr	; 0232BD1C
loc_0232BD1E:
	cmp r1,#0x0	; 0232BD1E
	bge loc_0232BD26	; 0232BD20
	sub r0,r0,r1	; 0232BD22
	bx lr	; 0232BD24
loc_0232BD26:
	sub r0,r2,r1	; 0232BD26
	bx lr	; 0232BD28
loc_0232BD2A:
	ldr r0,[pool_0232BD54]	; 0232BD2A
	bx lr	; 0232BD2C
loc_0232BD2E:
	ldr r0,[pool_0232BD58]	; 0232BD2E
	bx lr	; 0232BD30
loc_0232BD32:
	mov r0,#0x0	; 0232BD32
loc_0232BD34:
	bx lr	; 0232BD34
	.byte 0xC0, 0x46	; 0232BD38
pool_0232BD38:
loc_0232BD38:
	.word 0x023C0000	; 0232BD38
pool_0232BD3C:
loc_0232BD3C:
	.word 0x02000000	; 0232BD3C
pool_0232BD40:
loc_0232BD40:
	.word P1_DtcmRuntimeStart	; 0232BD40
pool_0232BD44:
loc_0232BD44:
	.word 0x00003F80	; 0232BD44
pool_0232BD48:
loc_0232BD48:
	.word 0x00001000	; 0232BD48
pool_0232BD4C:
loc_0232BD4C:
	.word 0x00000000	; 0232BD4C
pool_0232BD50:
loc_0232BD50:
	.word P1_DtcmRuntimeEnd	; 0232BD50
pool_0232BD54:
loc_0232BD54:
	.word 0x027FF800	; 0232BD54
pool_0232BD58:
loc_0232BD58:
	.word Arm7SharedWramStart	; 0232BD58

; ===== function loc_0232BD5C =====
loc_0232BD5C:
	bx lr	; 0232BD5C
	.byte 0x00, 0x00	; 0232BD60

; ===== function loc_0232BD60 =====
loc_0232BD60:
	push {lr}	; 0232BD60
	sub sp,#0x4	; 0232BD62
	ldr r0,[pool_0232BDA4]	; 0232BD64
	ldr r1,[r0,#0x0]	; 0232BD66
	cmp r1,#0x0	; 0232BD68
	bne loc_0232BD9E	; 0232BD6A
	mov r1,#0x1	; 0232BD6C
	str r1,[r0,#0x0]	; 0232BD6E
	mov r0,#0x0	; 0232BD70
	bl loc_0232BDA8	; 0232BD72
	mov r0,#0x2	; 0232BD76
	mov r1,#0x0	; 0232BD78
	bl loc_0232BC70	; 0232BD7A
	mov r0,#0x2	; 0232BD7E
	mov r1,#0x0	; 0232BD80
	bl loc_0232BC7C	; 0232BD82
	mov r0,#0x3	; 0232BD86
	bl loc_0232BDA8	; 0232BD88
	mov r0,#0x4	; 0232BD8C
	bl loc_0232BDA8	; 0232BD8E
	mov r0,#0x5	; 0232BD92
	bl loc_0232BDA8	; 0232BD94
	mov r0,#0x6	; 0232BD98
	bl loc_0232BDA8	; 0232BD9A
loc_0232BD9E:
	add sp,#0x4	; 0232BD9E
	pop {r3}	; 0232BDA0
	bx r3	; 0232BDA2
pool_0232BDA4:
loc_0232BDA4:
	.word P1_BssStart + 0x265C4	; 0232BDA4

; ===== function loc_0232BDA8 =====
loc_0232BDA8:
	push {r4,lr}	; 0232BDA8
	add r4,r0,#0x0	; 0232BDAA
	bl loc_0232BCD8	; 0232BDAC
	add r1,r0,#0x0	; 0232BDB0
	add r0,r4,#0x0	; 0232BDB2
	bl loc_0232BC7C	; 0232BDB4
	add r0,r4,#0x0	; 0232BDB8
	bl loc_0232BC88	; 0232BDBA
	add r1,r0,#0x0	; 0232BDBE
	add r0,r4,#0x0	; 0232BDC0
	bl loc_0232BC70	; 0232BDC2
	pop {r4}	; 0232BDC6
	pop {r3}	; 0232BDC8
	bx r3	; 0232BDCA
.arm

; ===== function loc_0232BDCC =====
; Sets CP15 control-register c1 bit 0. / 置位 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9SetCp15ControlBit0
loc_0232BDCC:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BDCC
	orr r0,r0,#0x1	; 0232BDD0
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BDD4
	bx lr	; 0232BDD8
.endfunc

; ===== function loc_0232BDDC =====
; Clears CP15 control-register c1 bit 0. / 清除 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9ClearCp15ControlBit0
loc_0232BDDC:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BDDC
	bic r0,r0,#0x1	; 0232BDE0
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BDE4
	bx lr	; 0232BDE8
.endfunc
; 链接既有调试入口；保存现场后处理 abort/undef，最后停在等待循环。
; Chain the saved debug handler; process abort/undef context, then stop in a wait loop.
.func P1_ExceptionEntry
	ldr r12,[pool_0232BE58]	; 0232BDEC
	ldr r12,[r12,#0x0]	; 0232BDF0
	cmp r12,#0x0	; 0232BDF4
	movne lr,pc	; 0232BDF8
	bxne r12	; 0232BDFC
	ldr r12,[pool_0232BE5C]	; 0232BE00
	stmdb r12!,{r0,r1,r2,r3,sp,lr}	; 0232BE04
	and r0,sp,#0x1	; 0232BE08
	mov sp,r12	; 0232BE0C
	mrs r1,cpsr	; 0232BE10
	and r1,r1,#0x1f	; 0232BE14
	teq r1,#0x17	; 0232BE18
	bne loc_0232BE28	; 0232BE1C
	bl P1_ProcessException	; 0232BE20
	b loc_0232BE34	; 0232BE24
loc_0232BE28:
	teq r1,#0x1b	; 0232BE28
	bne loc_0232BE34	; 0232BE2C
	bl P1_ProcessException	; 0232BE30
loc_0232BE34:
	ldr r12,[pool_0232BE58]	; 0232BE34
	ldr r12,[r12,#0x0]	; 0232BE38
	cmp r12,#0x0	; 0232BE3C
loc_0232BE40:
	beq loc_0232BE40	; 0232BE40
loc_0232BE44:
	mov r0,r0	; 0232BE44
	b loc_0232BE44	; 0232BE48
.endfunc
	.byte 0x0F, 0x50, 0xBD, 0xE8, 0x0C, 0xD0, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1	; 0232BE58
pool_0232BE58:
loc_0232BE58:
	.word P1_PreviousExceptionHandler	; 0232BE58
pool_0232BE5C:
loc_0232BE5C:
	.word P1_ExceptionStackTop	; 0232BE5C

; ===== function loc_0232BE60 =====
loc_0232BE60:
; 先保存异常现场，再调用已注册的用户处理器。
; Save exception context, then invoke the registered user handler.
.func P1_ProcessException
	stmdb sp!,{lr}	; 0232BE60
	bl P1_SaveExceptionContext	; 0232BE64
	bl P1_CallUserExceptionHandler	; 0232BE68
	ldmia sp!,{lr}	; 0232BE6C
	bx lr	; 0232BE70
.endfunc

; ===== function loc_0232BE74 =====
loc_0232BE74:
; 收集通用寄存器、异常栈与各模式的状态，写入 BSS 上下文。
; Collect registers, exception-stack data and mode state into the BSS context.
.func P1_SaveExceptionContext
	ldr r1,[pool_0232BF00]	; 0232BE74
	mrs r2,cpsr	; 0232BE78
	str r2,[r1,#0x74]	; 0232BE7C
	str r0,[r1,#0x6c]	; 0232BE80
	ldr r0,[r12,#0x0]	; 0232BE84
	str r0,[r1,#0x4]	; 0232BE88
	ldr r0,[r12,#0x4]	; 0232BE8C
	str r0,[r1,#0x8]	; 0232BE90
	ldr r0,[r12,#0x8]	; 0232BE94
	str r0,[r1,#0xc]	; 0232BE98
	ldr r0,[r12,#0xc]	; 0232BE9C
	str r0,[r1,#0x10]	; 0232BEA0
	ldr r2,[r12,#0x10]	; 0232BEA4
	bic r2,r2,#0x1	; 0232BEA8
	add r0,r1,#0x14	; 0232BEAC
	stmia r0,{r4,r5,r6,r7,r8,r9,r10,r11}	; 0232BEB0
	str r12,[r1,#0x70]	; 0232BEB4
	ldr r0,[r2,#0x0]	; 0232BEB8
	str r0,[r1,#0x64]	; 0232BEBC
	ldr r3,[r2,#0x4]	; 0232BEC0
	str r3,[r1,#0x0]	; 0232BEC4
	ldr r0,[r2,#0x8]	; 0232BEC8
	str r0,[r1,#0x34]	; 0232BECC
	ldr r0,[r2,#0xc]	; 0232BED0
	str r0,[r1,#0x40]	; 0232BED4
	mrs r0,cpsr	; 0232BED8
	orr r3,r3,#0x80	; 0232BEDC
	bic r3,r3,#0x20	; 0232BEE0
	msr cpsr_cxsf,r3	; 0232BEE4
	str sp,[r1,#0x38]	; 0232BEE8
	str lr,[r1,#0x3c]	; 0232BEEC
	mrs r2,spsr	; 0232BEF0
	str r2,[r1,#0x7c]	; 0232BEF4
	msr cpsr_cxsf,r0	; 0232BEF8
	bx lr	; 0232BEFC
.endfunc
pool_0232BF00:
loc_0232BF00:
	.word P1_ExceptionContext	; 0232BF00

; ===== function loc_0232BF04 =====
loc_0232BF04:
; 若已注册，临时启用保护单元并以现场/参数调用用户回调。
; If registered, enable the MPU for the user callback with context and argument.
.func P1_CallUserExceptionHandler
	stmdb sp!,{lr}	; 0232BF04
	sub sp,sp,#0x4	; 0232BF08
	ldr r0,[pool_0232BF60]	; 0232BF0C
	ldr r0,[r0,#0x0]	; 0232BF10
	cmp r0,#0x0	; 0232BF14
	addeq sp,sp,#0x4	; 0232BF18
	ldmeqia sp!,{lr}	; 0232BF1C
	bxeq lr	; 0232BF20
	mov r0,sp	; 0232BF24
	ldr r1,[pool_0232BF64]	; 0232BF28
	msr cpsr_cxsf,r1	; 0232BF2C
	mov sp,r0	; 0232BF30
	bl P1_Arm9SetCp15ControlBit0	; 0232BF34
	ldr r1,[pool_0232BF68]	; 0232BF38
	ldr r0,[pool_0232BF60]	; 0232BF3C
	ldr r1,[r1,#0x0]	; 0232BF40
	ldr r2,[r0,#0x0]	; 0232BF44
	ldr r0,[pool_0232BF6C]	; 0232BF48
	blx r2	; 0232BF4C
	bl P1_Arm9ClearCp15ControlBit0	; 0232BF50
	add sp,sp,#0x4	; 0232BF54
	ldmia sp!,{lr}	; 0232BF58
	bx lr	; 0232BF5C
.endfunc
pool_0232BF60:
loc_0232BF60:
	.word P1_UserExceptionHandler	; 0232BF60
pool_0232BF64:
loc_0232BF64:
	.word 0x0000009F	; 0232BF64
pool_0232BF68:
loc_0232BF68:
	.word P1_UserExceptionArgument	; 0232BF68
pool_0232BF6C:
loc_0232BF6C:
	.word P1_ExceptionContext	; 0232BF6C
.thumb

; ===== function loc_0232BF70 =====
loc_0232BF70:
; 检查既有调试入口；需要时同时安装 BIOS 向量和 DTCM 中的入口副本。
; Check the saved debug entry; install the BIOS vector and DTCM copy when required.
.func P1_InitExceptionHandler
	push {lr}	; 0232BF70
	sub sp,#0x4	; 0232BF72
	ldr r0,[pool_0232BFBC]	; 0232BF74
	ldr r1,[r0,#0x0]	; 0232BF76
	ldr r0,[pool_0232BFC0]	; 0232BF78
	cmp r1,r0	; 0232BF7A
	bcc loc_0232BF8A	; 0232BF7C
	ldr r0,[pool_0232BFC4]	; 0232BF7E
	cmp r1,r0	; 0232BF80
	bcs loc_0232BF8A	; 0232BF82
	ldr r0,[pool_0232BFC8]	; 0232BF84
	str r1,[r0,#0x0]	; 0232BF86
	b loc_0232BF90	; 0232BF88
loc_0232BF8A:
	mov r1,#0x0	; 0232BF8A
	ldr r0,[pool_0232BFC8]	; 0232BF8C
	str r1,[r0,#0x0]	; 0232BF8E
loc_0232BF90:
	ldr r0,[pool_0232BFC8]	; 0232BF90
	ldr r0,[r0,#0x0]	; 0232BF92
	cmp r0,#0x0	; 0232BF94
	beq loc_0232BFA4	; 0232BF96
	bl loc_0232BA24	; 0232BF98
	ldr r1,[pool_0232BFCC]	; 0232BF9C
	and r0,r1	; 0232BF9E
	cmp r0,#0x0	; 0232BFA0
	bne loc_0232BFAE	; 0232BFA2
loc_0232BFA4:
	ldr r1,[pool_0232BFD0]	; 0232BFA4
	ldr r0,[pool_0232BFBC]	; 0232BFA6
	str r1,[r0,#0x0]	; 0232BFA8
	ldr r0,[pool_0232BFD4]	; 0232BFAA
	str r1,[r0,#0x5c]	; 0232BFAC
loc_0232BFAE:
	mov r1,#0x0	; 0232BFAE
	ldr r0,[pool_0232BFD8]	; 0232BFB0
	str r1,[r0,#0x0]	; 0232BFB2
	add sp,#0x4	; 0232BFB4
	pop {r3}	; 0232BFB6
	bx r3	; 0232BFB8
.endfunc
	.byte 0xC0, 0x46	; 0232BFBC
pool_0232BFBC:
loc_0232BFBC:
	.word Bios9DebugVectorAddress	; 0232BFBC
pool_0232BFC0:
loc_0232BFC0:
	.word 0x02600000	; 0232BFC0
pool_0232BFC4:
loc_0232BFC4:
	.word 0x02800000	; 0232BFC4
pool_0232BFC8:
loc_0232BFC8:
	.word P1_PreviousExceptionHandler	; 0232BFC8
pool_0232BFCC:
loc_0232BFCC:
	.word 0x40000000	; 0232BFCC
pool_0232BFD0:
loc_0232BFD0:
	.word P1_ExceptionEntry	; 0232BFD0
pool_0232BFD4:
loc_0232BFD4:
	.word P1_DtcmExceptionVector - 0x5C	; 0232BFD4
pool_0232BFD8:
loc_0232BFD8:
	.word P1_UserExceptionHandler	; 0232BFD8

; ===== function loc_0232BFDC =====
loc_0232BFDC:
	ldr r1,[pool_0232BFEC]	; 0232BFDC
	ldrh r3,[r1,#0x0]	; 0232BFDE
	mov r2,#0x1	; 0232BFE0
	lsl r2,r0	; 0232BFE2
	orr r3,r2	; 0232BFE4
	strh r3,[r1,#0x0]	; 0232BFE6
	bx lr	; 0232BFE8
	.byte 0xC0, 0x46	; 0232BFEC
pool_0232BFEC:
loc_0232BFEC:
	.word P1_BssStart + 0x26654	; 0232BFEC

; ===== function loc_0232BFF0 =====
loc_0232BFF0:
	push {r4,r5,lr}	; 0232BFF0
	sub sp,#0xc	; 0232BFF2
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BFF4
	ldr r1,[pool_0232C058]	; 0232BFF8
	ldrh r1,[r1,#0x0]	; 0232BFFA
	add r3,sp,#0x0	; 0232BFFC
	strh r1,[r3,#0x0]	; 0232BFFE
	ldr r1,[pool_0232C05C]	; 0232C000
	ldr r5,[r1,#0x0]	; 0232C002
	ldr r4,[r1,#0x4]	; 0232C004
	ldr r1,[pool_0232C060]	; 0232C006
	mov r2,#0x0	; 0232C008
	and r4,r1	; 0232C00A
	bic r5,r2	; 0232C00C
	str r5,[sp,#0x4]	; 0232C00E
	str r4,[sp,#0x8]	; 0232C010
	ldr r1,[pool_0232C064]	; 0232C012
	ldr r4,[r1,#0x0]	; 0232C014
	mov r1,#0x8	; 0232C016
	and r4,r1	; 0232C018
	cmp r4,#0x0	; 0232C01A
	beq loc_0232C036	; 0232C01C
	ldrh r3,[r3,#0x0]	; 0232C01E
	ldr r1,[pool_0232C068]	; 0232C020
	and r3,r1	; 0232C022
	cmp r3,#0x0	; 0232C024
	bne loc_0232C036	; 0232C026
	ldr r3,[sp,#0x4]	; 0232C028
	ldr r4,[sp,#0x8]	; 0232C02A
	mov r1,#0x1	; 0232C02C
	add r1,r3,r1	; 0232C02E
	adc r4,r2	; 0232C030
	str r1,[sp,#0x4]	; 0232C032
	str r4,[sp,#0x8]	; 0232C034
loc_0232C036:
	blx P1_Arm9RestoreIrqMask	; 0232C036
	ldr r2,[sp,#0x4]	; 0232C03A
	ldr r1,[sp,#0x8]	; 0232C03C
	lsr r0,r2,#0x10	; 0232C03E
	lsl r1,r1,#0x10	; 0232C040
	orr r1,r0	; 0232C042
	lsl r0,r2,#0x10	; 0232C044
	add r2,sp,#0x0	; 0232C046
	ldrh r3,[r2,#0x0]	; 0232C048
	asr r2,r3,#0x1f	; 0232C04A
	orr r1,r2	; 0232C04C
	orr r0,r3	; 0232C04E
	add sp,#0xc	; 0232C050
	pop {r4,r5}	; 0232C052
	pop {r3}	; 0232C054
	bx r3	; 0232C056
pool_0232C058:
loc_0232C058:
	.word TIMER0_DATA	; 0232C058
pool_0232C05C:
loc_0232C05C:
	.word P1_BssStart + 0x26660	; 0232C05C
pool_0232C060:
loc_0232C060:
	.word 0x0000FFFF	; 0232C060
pool_0232C064:
loc_0232C064:
	.word REG_IF	; 0232C064
pool_0232C068:
loc_0232C068:
	.word 0x00008000	; 0232C068

; ===== function loc_0232C06C =====
P1_IrqHandler_0232C06C:
	push {r4,lr}	; 0232C06C
	ldr r1,[pool_0232C0A8]	; 0232C06E
	ldr r2,[r1,#0x0]	; 0232C070
	ldr r4,[r1,#0x4]	; 0232C072
	mov r3,#0x0	; 0232C074
	mov r0,#0x1	; 0232C076
	add r0,r2,r0	; 0232C078
	adc r4,r3	; 0232C07A
	str r0,[r1,#0x0]	; 0232C07C
	str r4,[r1,#0x4]	; 0232C07E
	ldr r0,[pool_0232C0AC]	; 0232C080
	ldr r1,[r0,#0x0]	; 0232C082
	cmp r1,#0x0	; 0232C084
	beq loc_0232C096	; 0232C086
	ldr r2,[pool_0232C0B0]	; 0232C088
	strh r3,[r2,#0x0]	; 0232C08A
	ldr r1,[pool_0232C0B4]	; 0232C08C
	strh r3,[r1,#0x0]	; 0232C08E
	mov r1,#0xc1	; 0232C090
	strh r1,[r2,#0x0]	; 0232C092
	str r3,[r0,#0x0]	; 0232C094
loc_0232C096:
	mov r0,#0x0	; 0232C096
	ldr r1,[pool_0232C0B8]	; 0232C098
	add r2,r0,#0x0	; 0232C09A
	bl loc_0232B1AC	; 0232C09C
	pop {r4}	; 0232C0A0
	pop {r3}	; 0232C0A2
	bx r3	; 0232C0A4
	.byte 0xC0, 0x46	; 0232C0A8
pool_0232C0A8:
loc_0232C0A8:
	.word P1_BssStart + 0x26660	; 0232C0A8
pool_0232C0AC:
loc_0232C0AC:
	.word P1_BssStart + 0x2665C	; 0232C0AC
pool_0232C0B0:
loc_0232C0B0:
	.word TIMER0_CR	; 0232C0B0
pool_0232C0B4:
loc_0232C0B4:
	.word TIMER0_DATA	; 0232C0B4
pool_0232C0B8:
loc_0232C0B8:
	.word P1_IrqHandler_0232C06C + 1	; 0232C0B8

; ===== function loc_0232C0BC =====
loc_0232C0BC:
	push {lr}	; 0232C0BC
	sub sp,#0x4	; 0232C0BE
	ldr r0,[pool_0232C100]	; 0232C0C0
	ldrh r1,[r0,#0x0]	; 0232C0C2
	cmp r1,#0x0	; 0232C0C4
	bne loc_0232C0FA	; 0232C0C6
	mov r1,#0x1	; 0232C0C8
	strh r1,[r0,#0x0]	; 0232C0CA
	mov r0,#0x0	; 0232C0CC
	bl loc_0232BFDC	; 0232C0CE
	mov r2,#0x0	; 0232C0D2
	ldr r0,[pool_0232C104]	; 0232C0D4
	str r2,[r0,#0x0]	; 0232C0D6
	str r2,[r0,#0x4]	; 0232C0D8
	ldr r1,[pool_0232C108]	; 0232C0DA
	strh r2,[r1,#0x0]	; 0232C0DC
	ldr r0,[pool_0232C10C]	; 0232C0DE
	strh r2,[r0,#0x0]	; 0232C0E0
	mov r0,#0xc1	; 0232C0E2
	strh r0,[r1,#0x0]	; 0232C0E4
	mov r0,#0x8	; 0232C0E6
	ldr r1,[pool_0232C110]	; 0232C0E8
	bl loc_0232B1E0	; 0232C0EA
	mov r0,#0x8	; 0232C0EE
	bl loc_0232B15C	; 0232C0F0
	mov r1,#0x0	; 0232C0F4
	ldr r0,[pool_0232C114]	; 0232C0F6
	str r1,[r0,#0x0]	; 0232C0F8
loc_0232C0FA:
	add sp,#0x4	; 0232C0FA
	pop {r3}	; 0232C0FC
	bx r3	; 0232C0FE
pool_0232C100:
loc_0232C100:
	.word P1_BssStart + 0x26658	; 0232C100
pool_0232C104:
loc_0232C104:
	.word P1_BssStart + 0x26660	; 0232C104
pool_0232C108:
loc_0232C108:
	.word TIMER0_CR	; 0232C108
pool_0232C10C:
loc_0232C10C:
	.word TIMER0_DATA	; 0232C10C
pool_0232C110:
loc_0232C110:
	.word P1_IrqHandler_0232C06C + 1	; 0232C110
pool_0232C114:
loc_0232C114:
	.word P1_BssStart + 0x2665C	; 0232C114
.arm
	stmdb sp!,{lr}	; 0232C118
	blx loc_0232C17C	; 0232C11C
	ldmia sp!,{lr}	; 0232C120
	bx lr	; 0232C124
.thumb

; ===== function loc_0232C128 =====
P1_Entry_0232C128:
	push {r4,r5,r6,r7,lr}	; 0232C128
	sub sp,#0x4	; 0232C12A
	add r5,r0,#0x0	; 0232C12C
	cmp r5,#0x0	; 0232C12E
	beq loc_0232C16C	; 0232C130
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C132
	add r7,r0,#0x0	; 0232C136
	ldr r0,[pool_0232C174]	; 0232C138
	ldr r0,[r0,#0x0]	; 0232C13A
	cmp r0,#0x0	; 0232C13C
	beq loc_0232C144	; 0232C13E
	ldr r4,[r0,#0x18]	; 0232C140
	b loc_0232C146	; 0232C142
loc_0232C144:
	mov r4,#0x0	; 0232C144
loc_0232C146:
	cmp r0,#0x0	; 0232C146
	beq loc_0232C166	; 0232C148
	mov r6,#0x0	; 0232C14A
loc_0232C14C:
	ldr r1,[r0,#0x8]	; 0232C14C
	cmp r1,r5	; 0232C14E
	bne loc_0232C156	; 0232C150
	bl loc_0232C22C	; 0232C152
loc_0232C156:
	add r0,r4,#0x0	; 0232C156
	cmp r4,#0x0	; 0232C158
	beq loc_0232C160	; 0232C15A
	ldr r4,[r4,#0x18]	; 0232C15C
	b loc_0232C162	; 0232C15E
loc_0232C160:
	add r4,r6,#0x0	; 0232C160
loc_0232C162:
	cmp r0,#0x0	; 0232C162
	bne loc_0232C14C	; 0232C164
loc_0232C166:
	add r0,r7,#0x0	; 0232C166
	blx P1_Arm9RestoreIrqMask	; 0232C168
loc_0232C16C:
	add sp,#0x4	; 0232C16C
	pop {r4,r5,r6,r7}	; 0232C16E
	pop {r3}	; 0232C170
	bx r3	; 0232C172
pool_0232C174:
loc_0232C174:
	.word P1_BssStart + 0x2666C	; 0232C174
P1_Entry_0232C178:
	str r1,[r0,#0x8]	; 0232C178
	bx lr	; 0232C17A

; ===== function loc_0232C17C =====
loc_0232C17C:
	push {r4,r5,lr}	; 0232C17C
	sub sp,#0x4	; 0232C17E
	mov r1,#0x0	; 0232C180
	ldr r0,[pool_0232C21C]	; 0232C182
	strh r1,[r0,#0x0]	; 0232C184
	mov r0,#0x10	; 0232C186
	bl loc_0232B134	; 0232C188
	ldr r1,[pool_0232C220]	; 0232C18C
	ldr r0,[pool_0232C224]	; 0232C18E
	add r1,r1,r0	; 0232C190
	ldr r2,[r1,#0x0]	; 0232C192
	mov r0,#0x10	; 0232C194
	orr r2,r0	; 0232C196
	str r2,[r1,#0x0]	; 0232C198
	bl loc_0232BFF0	; 0232C19A
	ldr r2,[pool_0232C228]	; 0232C19E
	ldr r4,[r2,#0x0]	; 0232C1A0
	cmp r4,#0x0	; 0232C1A2
	beq loc_0232C212	; 0232C1A4
	ldr r5,[r4,#0xc]	; 0232C1A6
	ldr r3,[r4,#0x10]	; 0232C1A8
	sub r0,r0,r5	; 0232C1AA
	sbc r1,r3	; 0232C1AC
	bcs loc_0232C1BE	; 0232C1AE
	add r0,r4,#0x0	; 0232C1B0
	bl loc_0232C3EC	; 0232C1B2
	add sp,#0x4	; 0232C1B6
	pop {r4,r5}	; 0232C1B8
	pop {r3}	; 0232C1BA
	bx r3	; 0232C1BC
loc_0232C1BE:
	ldr r1,[r4,#0x18]	; 0232C1BE
	str r1,[r2,#0x0]	; 0232C1C0
	cmp r1,#0x0	; 0232C1C2
	bne loc_0232C1CC	; 0232C1C4
	mov r0,#0x0	; 0232C1C6
	str r0,[r2,#0x4]	; 0232C1C8
	b loc_0232C1D0	; 0232C1CA
loc_0232C1CC:
	mov r0,#0x0	; 0232C1CC
	str r0,[r1,#0x14]	; 0232C1CE
loc_0232C1D0:
	ldr r5,[r4,#0x0]	; 0232C1D0
	ldr r2,[r4,#0x1c]	; 0232C1D2
	ldr r1,[r4,#0x20]	; 0232C1D4
	mov r0,#0x0	; 0232C1D6
	eor r1,r0	; 0232C1D8
	eor r2,r0	; 0232C1DA
	orr r1,r2	; 0232C1DC
	bne loc_0232C1E4	; 0232C1DE
	mov r0,#0x0	; 0232C1E0
	str r0,[r4,#0x0]	; 0232C1E2
loc_0232C1E4:
	cmp r5,#0x0	; 0232C1E4
	beq loc_0232C1EC	; 0232C1E6
	ldr r0,[r4,#0x4]	; 0232C1E8
	blx r5	; 0232C1EA
loc_0232C1EC:
	ldr r2,[r4,#0x1c]	; 0232C1EC
	ldr r1,[r4,#0x20]	; 0232C1EE
	mov r0,#0x0	; 0232C1F0
	eor r1,r0	; 0232C1F2
	eor r2,r0	; 0232C1F4
	orr r1,r2	; 0232C1F6
	beq loc_0232C206	; 0232C1F8
	str r5,[r4,#0x0]	; 0232C1FA
	add r0,r4,#0x0	; 0232C1FC
	mov r1,#0x0	; 0232C1FE
	add r2,r1,#0x0	; 0232C200
	bl loc_0232C2DC	; 0232C202
loc_0232C206:
	ldr r0,[pool_0232C228]	; 0232C206
	ldr r0,[r0,#0x0]	; 0232C208
	cmp r0,#0x0	; 0232C20A
	beq loc_0232C212	; 0232C20C
	bl loc_0232C3EC	; 0232C20E
loc_0232C212:
	add sp,#0x4	; 0232C212
	pop {r4,r5}	; 0232C214
	pop {r3}	; 0232C216
	bx r3	; 0232C218
	.byte 0xC0, 0x46	; 0232C21C
pool_0232C21C:
loc_0232C21C:
	.word TIMER1_CR	; 0232C21C
pool_0232C220:
loc_0232C220:
	.word P1_DtcmRuntimeStart	; 0232C220
pool_0232C224:
loc_0232C224:
	.word 0x00003FF8	; 0232C224
pool_0232C228:
loc_0232C228:
	.word P1_BssStart + 0x2666C	; 0232C228

; ===== function loc_0232C22C =====
loc_0232C22C:
	push {r4,r5,lr}	; 0232C22C
	sub sp,#0x4	; 0232C22E
	add r5,r0,#0x0	; 0232C230
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C232
	add r4,r0,#0x0	; 0232C236
	ldr r1,[r5,#0x0]	; 0232C238
	cmp r1,#0x0	; 0232C23A
	bne loc_0232C24A	; 0232C23C
	blx P1_Arm9RestoreIrqMask	; 0232C23E
	add sp,#0x4	; 0232C242
	pop {r4,r5}	; 0232C244
	pop {r3}	; 0232C246
	bx r3	; 0232C248
loc_0232C24A:
	ldr r0,[r5,#0x18]	; 0232C24A
	cmp r0,#0x0	; 0232C24C
	bne loc_0232C258	; 0232C24E
	ldr r2,[r5,#0x14]	; 0232C250
	ldr r1,[pool_0232C288]	; 0232C252
	str r2,[r1,#0x4]	; 0232C254
	b loc_0232C25C	; 0232C256
loc_0232C258:
	ldr r1,[r5,#0x14]	; 0232C258
	str r1,[r0,#0x14]	; 0232C25A
loc_0232C25C:
	ldr r1,[r5,#0x14]	; 0232C25C
	cmp r1,#0x0	; 0232C25E
	beq loc_0232C266	; 0232C260
	str r0,[r1,#0x18]	; 0232C262
	b loc_0232C272	; 0232C264
loc_0232C266:
	ldr r1,[pool_0232C288]	; 0232C266
	str r0,[r1,#0x0]	; 0232C268
	cmp r0,#0x0	; 0232C26A
	beq loc_0232C272	; 0232C26C
	bl loc_0232C3EC	; 0232C26E
loc_0232C272:
	mov r0,#0x0	; 0232C272
	str r0,[r5,#0x0]	; 0232C274
	str r0,[r5,#0x1c]	; 0232C276
	str r0,[r5,#0x20]	; 0232C278
	add r0,r4,#0x0	; 0232C27A
	blx P1_Arm9RestoreIrqMask	; 0232C27C
	add sp,#0x4	; 0232C280
	pop {r4,r5}	; 0232C282
	pop {r3}	; 0232C284
	bx r3	; 0232C286
pool_0232C288:
loc_0232C288:
	.word P1_BssStart + 0x2666C	; 0232C288
P1_Entry_0232C28C:
	push {r4,r5,r6,r7,lr}	; 0232C28C
	sub sp,#0x4	; 0232C28E
	add r5,r0,#0x0	; 0232C290
	add r6,r1,#0x0	; 0232C292
	add r4,r2,#0x0	; 0232C294
	add r7,r3,#0x0	; 0232C296
	cmp r5,#0x0	; 0232C298
	beq P1_Entry_0232C2A2	; 0232C29A
	ldr r0,[r5,#0x0]	; 0232C29C
	cmp r0,#0x0	; 0232C29E
	beq P1_Entry_0232C2A6	; 0232C2A0
P1_Entry_0232C2A2:
	bl loc_0232C528	; 0232C2A2
P1_Entry_0232C2A6:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C2A6
	str r0,[sp,#0x0]	; 0232C2AA
	mov r0,#0x0	; 0232C2AC
	str r0,[r5,#0x1c]	; 0232C2AE
	str r0,[r5,#0x20]	; 0232C2B0
	str r7,[r5,#0x0]	; 0232C2B2
	ldr r0,[sp,#0x18]	; 0232C2B4
	str r0,[r5,#0x4]	; 0232C2B6
	bl loc_0232BFF0	; 0232C2B8
	add r2,r0,#0x0	; 0232C2BC
	add r0,r5,#0x0	; 0232C2BE
	add r2,r6,r2	; 0232C2C0
	adc r4,r1	; 0232C2C2
	add r1,r2,#0x0	; 0232C2C4
	add r2,r4,#0x0	; 0232C2C6
	bl loc_0232C2DC	; 0232C2C8
	ldr r0,[sp,#0x0]	; 0232C2CC
	blx P1_Arm9RestoreIrqMask	; 0232C2CE
	add sp,#0x4	; 0232C2D2
	pop {r4,r5,r6,r7}	; 0232C2D4
	pop {r3}	; 0232C2D6
	bx r3	; 0232C2D8
	.byte 0x00, 0x00	; 0232C2DA

; ===== function loc_0232C2DC =====
loc_0232C2DC:
	push {r4,r5,r6,r7,lr}	; 0232C2DC
	sub sp,#0xc	; 0232C2DE
	add r5,r0,#0x0	; 0232C2E0
	add r4,r1,#0x0	; 0232C2E2
	add r6,r2,#0x0	; 0232C2E4
	ldr r2,[r5,#0x1c]	; 0232C2E6
	ldr r1,[r5,#0x20]	; 0232C2E8
	mov r0,#0x0	; 0232C2EA
	eor r1,r0	; 0232C2EC
	eor r2,r0	; 0232C2EE
	orr r1,r2	; 0232C2F0
	beq loc_0232C336	; 0232C2F2
	bl loc_0232BFF0	; 0232C2F4
	ldr r4,[r5,#0x24]	; 0232C2F8
	ldr r6,[r5,#0x28]	; 0232C2FA
	sub r2,r4,r0	; 0232C2FC
	lsl r2,r6,#0	; 0232C2FE
	sbc r2,r1	; 0232C300
	bcs loc_0232C336	; 0232C302
	ldr r2,[r5,#0x1c]	; 0232C304
	str r2,[sp,#0x0]	; 0232C306
	ldr r2,[r5,#0x20]	; 0232C308
	str r2,[sp,#0x4]	; 0232C30A
	sub r0,r0,r4	; 0232C30C
	sbc r1,r6	; 0232C30E
	ldr r2,[sp,#0x0]	; 0232C310
	ldr r3,[sp,#0x4]	; 0232C312
	blx loc_0232CB00	; 0232C314
	str r0,[sp,#0x8]	; 0232C318
	add r7,r1,#0x0	; 0232C31A
	ldr r0,[sp,#0x0]	; 0232C31C
	ldr r1,[sp,#0x4]	; 0232C31E
	mov r3,#0x1	; 0232C320
	ldr r2,[sp,#0x8]	; 0232C322
	add r3,r2,r3	; 0232C324
	mov r2,#0x0	; 0232C326
	adc r7,r2	; 0232C328
	add r2,r3,#0x0	; 0232C32A
	add r3,r7,#0x0	; 0232C32C
	blx P1_AeabiLmul	; 0232C32E
	add r4,r4,r0	; 0232C332
	adc r6,r1	; 0232C334
loc_0232C336:
	str r4,[r5,#0xc]	; 0232C336
	str r6,[r5,#0x10]	; 0232C338
	ldr r0,[pool_0232C3B0]	; 0232C33A
	ldr r3,[r0,#0x0]	; 0232C33C
	cmp r3,#0x0	; 0232C33E
	beq loc_0232C384	; 0232C340
loc_0232C342:
	ldr r1,[r3,#0xc]	; 0232C342
	ldr r0,[r3,#0x10]	; 0232C344
	sub r2,r4,r1	; 0232C346
	lsl r1,r6,#0	; 0232C348
	sbc r1,r0	; 0232C34A
	mov r0,#0x0	; 0232C34C
	sub r2,r2,r0	; 0232C34E
	sbc r1,r0	; 0232C350
	bge loc_0232C37E	; 0232C352
	ldr r0,[r3,#0x14]	; 0232C354
	str r0,[r5,#0x14]	; 0232C356
	str r5,[r3,#0x14]	; 0232C358
	str r3,[r5,#0x18]	; 0232C35A
	ldr r0,[r5,#0x14]	; 0232C35C
	cmp r0,#0x0	; 0232C35E
	beq loc_0232C36C	; 0232C360
	str r5,[r0,#0x18]	; 0232C362
	add sp,#0xc	; 0232C364
	pop {r4,r5,r6,r7}	; 0232C366
	pop {r3}	; 0232C368
	bx r3	; 0232C36A
loc_0232C36C:
	ldr r0,[pool_0232C3B0]	; 0232C36C
	str r5,[r0,#0x0]	; 0232C36E
	add r0,r5,#0x0	; 0232C370
	bl loc_0232C3EC	; 0232C372
	add sp,#0xc	; 0232C376
	pop {r4,r5,r6,r7}	; 0232C378
	pop {r3}	; 0232C37A
	bx r3	; 0232C37C
loc_0232C37E:
	ldr r3,[r3,#0x18]	; 0232C37E
	cmp r3,#0x0	; 0232C380
	bne loc_0232C342	; 0232C382
loc_0232C384:
	mov r0,#0x0	; 0232C384
	str r0,[r5,#0x18]	; 0232C386
	ldr r0,[pool_0232C3B0]	; 0232C388
	ldr r1,[r0,#0x4]	; 0232C38A
	str r5,[r0,#0x4]	; 0232C38C
	str r1,[r5,#0x14]	; 0232C38E
	cmp r1,#0x0	; 0232C390
	beq loc_0232C39E	; 0232C392
	str r5,[r1,#0x18]	; 0232C394
	add sp,#0xc	; 0232C396
	pop {r4,r5,r6,r7}	; 0232C398
	pop {r3}	; 0232C39A
	bx r3	; 0232C39C
loc_0232C39E:
	str r5,[r0,#0x4]	; 0232C39E
	str r5,[r0,#0x0]	; 0232C3A0
	add r0,r5,#0x0	; 0232C3A2
	bl loc_0232C3EC	; 0232C3A4
	add sp,#0xc	; 0232C3A8
	pop {r4,r5,r6,r7}	; 0232C3AA
	pop {r3}	; 0232C3AC
	bx r3	; 0232C3AE
pool_0232C3B0:
loc_0232C3B0:
	.word P1_BssStart + 0x2666C	; 0232C3B0
P1_Entry_0232C3B4:
	mov r1,#0x0	; 0232C3B4
	str r1,[r0,#0x0]	; 0232C3B6
	str r1,[r0,#0x8]	; 0232C3B8
	bx lr	; 0232C3BA

; ===== function loc_0232C3BC =====
P1_Entry_0232C3BC:
	push {lr}	; 0232C3BC
	sub sp,#0x4	; 0232C3BE
	ldr r1,[pool_0232C3E4]	; 0232C3C0
	ldrh r0,[r1,#0x0]	; 0232C3C2
	cmp r0,#0x0	; 0232C3C4
	bne loc_0232C3DE	; 0232C3C6
	mov r0,#0x1	; 0232C3C8
	strh r0,[r1,#0x0]	; 0232C3CA
	bl loc_0232BFDC	; 0232C3CC
	mov r1,#0x0	; 0232C3D0
	ldr r0,[pool_0232C3E8]	; 0232C3D2
	str r1,[r0,#0x0]	; 0232C3D4
	str r1,[r0,#0x4]	; 0232C3D6
	mov r0,#0x10	; 0232C3D8
	bl loc_0232B134	; 0232C3DA
loc_0232C3DE:
	add sp,#0x4	; 0232C3DE
	pop {r3}	; 0232C3E0
	bx r3	; 0232C3E2
pool_0232C3E4:
loc_0232C3E4:
	.word P1_BssStart + 0x26668	; 0232C3E4
pool_0232C3E8:
loc_0232C3E8:
	.word P1_BssStart + 0x2666C	; 0232C3E8

; ===== function loc_0232C3EC =====
loc_0232C3EC:
	push {r4,r5,lr}	; 0232C3EC
	sub sp,#0x4	; 0232C3EE
	add r4,r0,#0x0	; 0232C3F0
	bl loc_0232BFF0	; 0232C3F2
	mov r2,#0x0	; 0232C3F6
	ldr r3,[pool_0232C444]	; 0232C3F8
	strh r2,[r3,#0x0]	; 0232C3FA
	ldr r3,[r4,#0xc]	; 0232C3FC
	ldr r4,[r4,#0x10]	; 0232C3FE
	sub r5,r3,r0	; 0232C400
	sbc r4,r1	; 0232C402
	mov r0,#0x1	; 0232C404
	ldr r1,[pool_0232C448]	; 0232C406
	bl loc_0232B1AC	; 0232C408
	mov r1,#0x0	; 0232C40C
	sub r0,r5,r1	; 0232C40E
	lsl r0,r4,#0	; 0232C410
	sbc r0,r1	; 0232C412
	bge loc_0232C41A	; 0232C414
	ldr r1,[pool_0232C44C]	; 0232C416
	b loc_0232C42C	; 0232C418
loc_0232C41A:
	ldr r0,[pool_0232C450]	; 0232C41A
	sub r0,r5,r0	; 0232C41C
	sbc r4,r1	; 0232C41E
	bge loc_0232C42A	; 0232C420
	mvn r0,r5	; 0232C422
	lsl r0,r0,#0x10	; 0232C424
	lsr r1,r0,#0x10	; 0232C426
	b loc_0232C42C	; 0232C428
loc_0232C42A:
	mov r1,#0x0	; 0232C42A
loc_0232C42C:
	ldr r0,[pool_0232C454]	; 0232C42C
	strh r1,[r0,#0x0]	; 0232C42E
	mov r1,#0xc1	; 0232C430
	ldr r0,[pool_0232C444]	; 0232C432
	strh r1,[r0,#0x0]	; 0232C434
	mov r0,#0x10	; 0232C436
	bl loc_0232B15C	; 0232C438
	add sp,#0x4	; 0232C43C
	pop {r4,r5}	; 0232C43E
	pop {r3}	; 0232C440
	bx r3	; 0232C442
pool_0232C444:
loc_0232C444:
	.word TIMER1_CR	; 0232C444
pool_0232C448:
loc_0232C448:
	.word 0x0232C118	; 0232C448
pool_0232C44C:
loc_0232C44C:
	.word 0x0000FFFE	; 0232C44C
pool_0232C450:
loc_0232C450:
	.word 0x00010000	; 0232C450
pool_0232C454:
loc_0232C454:
	.word TIMER1_DATA	; 0232C454

; ===== function loc_0232C458 =====
loc_0232C458:
	push {lr}	; 0232C458
	sub sp,#0x4	; 0232C45A
	ldr r0,[pool_0232C488]	; 0232C45C
	ldrh r1,[r0,#0x0]	; 0232C45E
	cmp r1,#0x0	; 0232C460
	bne loc_0232C480	; 0232C462
	mov r1,#0x1	; 0232C464
	strh r1,[r0,#0x0]	; 0232C466
	mov r1,#0x0	; 0232C468
	ldr r0,[pool_0232C48C]	; 0232C46A
	str r1,[r0,#0x0]	; 0232C46C
	str r1,[r0,#0x4]	; 0232C46E
	mov r0,#0x4	; 0232C470
	bl loc_0232B134	; 0232C472
	mov r1,#0x0	; 0232C476
	ldr r0,[pool_0232C490]	; 0232C478
	str r1,[r0,#0x0]	; 0232C47A
	ldr r0,[pool_0232C494]	; 0232C47C
	str r1,[r0,#0x0]	; 0232C47E
loc_0232C480:
	add sp,#0x4	; 0232C480
	pop {r3}	; 0232C482
	bx r3	; 0232C484
	.byte 0xC0, 0x46	; 0232C488
pool_0232C488:
loc_0232C488:
	.word P1_BssStart + 0x26674	; 0232C488
pool_0232C48C:
loc_0232C48C:
	.word P1_BssStart + 0x26680	; 0232C48C
pool_0232C490:
loc_0232C490:
	.word P1_BssStart + 0x2667C	; 0232C490
pool_0232C494:
loc_0232C494:
	.word P1_BssStart + 0x26678	; 0232C494
.arm

; ===== function loc_0232C498 =====
; Clears CPSR I and returns the former I mask. / 清除 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9EnableIrqReturnPriorMask
loc_0232C498:
	mrs r0,cpsr	; 0232C498
	bic r1,r0,#0x80	; 0232C49C
	msr cpsr_c,r1	; 0232C4A0
	and r0,r0,#0x80	; 0232C4A4
	bx lr	; 0232C4A8
.endfunc

; ===== function loc_0232C4AC =====
; Sets CPSR I and returns the former I mask. / 设置 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9DisableIrqReturnPriorMask
loc_0232C4AC:
	mrs r0,cpsr	; 0232C4AC
	orr r1,r0,#0x80	; 0232C4B0
	msr cpsr_c,r1	; 0232C4B4
	and r0,r0,#0x80	; 0232C4B8
	bx lr	; 0232C4BC
.endfunc

; ===== function loc_0232C4C0 =====
; Restores CPSR I from r0 and returns the prior mask. / 按 r0 恢复 CPSR I 位并返回先前掩码。
.func P1_Arm9RestoreIrqMask
loc_0232C4C0:
	mrs r1,cpsr	; 0232C4C0
	bic r2,r1,#0x80	; 0232C4C4
	orr r2,r2,r0	; 0232C4C8
	msr cpsr_c,r2	; 0232C4CC
	and r0,r1,#0x80	; 0232C4D0
	bx lr	; 0232C4D4
.endfunc

; ===== function loc_0232C4D8 =====
; Sets CPSR I/F and returns the former masks. / 设置 CPSR I/F 位并返回先前掩码。
.func P1_Arm9DisableIrqFiqReturnPriorMasks
loc_0232C4D8:
	mrs r0,cpsr	; 0232C4D8
	orr r1,r0,#0xc0	; 0232C4DC
	msr cpsr_c,r1	; 0232C4E0
	and r0,r0,#0xc0	; 0232C4E4
	bx lr	; 0232C4E8
.endfunc

; ===== function loc_0232C4EC =====
; Restores CPSR I/F from r0 and returns prior masks. / 按 r0 恢复 CPSR I/F 位并返回先前掩码。
.func P1_Arm9RestoreIrqFiqMasks
loc_0232C4EC:
	mrs r1,cpsr	; 0232C4EC
	bic r2,r1,#0xc0	; 0232C4F0
	orr r2,r2,r0	; 0232C4F4
	msr cpsr_c,r2	; 0232C4F8
	and r0,r1,#0xc0	; 0232C4FC
	bx lr	; 0232C500
.endfunc

; ===== function loc_0232C504 =====
; Returns the CPSR processor-mode bits. / 返回 CPSR 的处理器模式位。
.func P1_Arm9GetProcessorMode
loc_0232C504:
	mrs r0,cpsr	; 0232C504
	and r0,r0,#0x1f	; 0232C508
	bx lr	; 0232C50C
.endfunc

; ===== function loc_0232C510 =====
; ARM946 CP15 wait-for-interrupt helper. / ARM946 CP15 等待中断帮助例程。
.func P1_Arm9WaitForInterrupt
loc_0232C510:
	mov r0,#0x0	; 0232C510
	mcr p15,0x0,r0,c7,c0,0x4	; 0232C514
	bx lr	; 0232C518
.endfunc

; ===== function loc_0232C51C =====
; Decrements r0 by four until borrow. / 每次将 r0 减四，直至产生借位。
.func P1_Arm9BusyWaitByLoop4
loc_0232C51C:
	subs r0,r0,#0x4	; 0232C51C
	bcs loc_0232C51C	; 0232C520
	bx lr	; 0232C524
.endfunc
.thumb

; ===== function loc_0232C528 =====
loc_0232C528:
	push {lr}	; 0232C528
	sub sp,#0x4	; 0232C52A
loc_0232C52C:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C52C
	blx P1_Arm9WaitForInterrupt	; 0232C530
	b loc_0232C52C	; 0232C534
	.byte 0x00, 0x00, 0x01, 0x1C, 0x02, 0x48, 0x06, 0x22, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFC	; 0232C546
	.byte 0x7F, 0x02, 0x04, 0xDF, 0x32, 0x02	; 0232C54C

; ===== function loc_0232C54C =====
loc_0232C54C:
	push {r4,lr}	; 0232C54C
	add r4,r1,#0x0	; 0232C54E
	ldr r1,[r4,#0x0]	; 0232C550
	cmp r1,#0x0	; 0232C552
	bne loc_0232C55A	; 0232C554
	bl loc_0232B250	; 0232C556
loc_0232C55A:
	ldr r0,[r4,#0x4]	; 0232C55A
	blx P1_Arm9RestoreIrqMask	; 0232C55C
	pop {r4}	; 0232C560
	pop {r3}	; 0232C562
	bx r3	; 0232C564
	.byte 0x00, 0x00	; 0232C568

; ===== function loc_0232C568 =====
loc_0232C568:
	push {r4,r5,r6,r7,lr}	; 0232C568
	sub sp,#0x4	; 0232C56A
	add r5,r0,#0x0	; 0232C56C
	add r4,r1,#0x0	; 0232C56E
	ldr r7,[pool_0232C5AC]	; 0232C570
	mov r6,#0x40	; 0232C572
loc_0232C574:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C574
	str r0,[r4,#0x4]	; 0232C578
	add r0,r7,#0x0	; 0232C57A
	bl loc_0232B2F8	; 0232C57C
	and r0,r6	; 0232C580
	str r0,[r4,#0x0]	; 0232C582
	ldr r0,[r4,#0x0]	; 0232C584
	cmp r0,#0x0	; 0232C586
	bne loc_0232C5A2	; 0232C588
	add r0,r5,#0x0	; 0232C58A
	bl loc_0232B380	; 0232C58C
	cmp r0,#0x0	; 0232C590
	beq loc_0232C5A2	; 0232C592
	ldr r0,[r4,#0x4]	; 0232C594
	blx P1_Arm9RestoreIrqMask	; 0232C596
	mov r0,#0x1	; 0232C59A
	bl P1_SwiWaitByLoop	; 0232C59C
	b loc_0232C574	; 0232C5A0
loc_0232C5A2:
	add sp,#0x4	; 0232C5A2
	pop {r4,r5,r6,r7}	; 0232C5A4
	pop {r3}	; 0232C5A6
	bx r3	; 0232C5A8
	.byte 0xC0, 0x46	; 0232C5AC
pool_0232C5AC:
loc_0232C5AC:
	.word 0x027FFFE8	; 0232C5AC

; ===== function loc_0232C5B0 =====
loc_0232C5B0:
	push {r4}	; 0232C5B0
	sub sp,#0x4	; 0232C5B2
	ldr r4,[r0,#0x0]	; 0232C5B4
	ldr r3,[pool_0232C5D8]	; 0232C5B6
	ldrh r2,[r3,#0x0]	; 0232C5B8
	mov r1,#0xc	; 0232C5BA
	bic r2,r1	; 0232C5BC
	lsl r1,r4,#0x2	; 0232C5BE
	orr r2,r1	; 0232C5C0
	strh r2,[r3,#0x0]	; 0232C5C2
	ldr r2,[r0,#0x4]	; 0232C5C4
	ldrh r1,[r3,#0x0]	; 0232C5C6
	mov r0,#0x10	; 0232C5C8
	bic r1,r0	; 0232C5CA
	lsl r0,r2,#0x4	; 0232C5CC
	orr r1,r0	; 0232C5CE
	strh r1,[r3,#0x0]	; 0232C5D0
	add sp,#0x4	; 0232C5D2
	pop {r4}	; 0232C5D4
	bx lr	; 0232C5D6
pool_0232C5D8:
loc_0232C5D8:
	.word REG_EXMEMCNT_ARM9	; 0232C5D8

; ===== function loc_0232C5DC =====
loc_0232C5DC:
	push {r4}	; 0232C5DC
	sub sp,#0x4	; 0232C5DE
	ldr r4,[pool_0232C60C]	; 0232C5E0
	ldrh r2,[r4,#0x0]	; 0232C5E2
	mov r1,#0xc	; 0232C5E4
	and r2,r1	; 0232C5E6
	asr r2,r2,#0x2	; 0232C5E8
	str r2,[r0,#0x0]	; 0232C5EA
	ldrh r3,[r4,#0x0]	; 0232C5EC
	mov r2,#0x10	; 0232C5EE
	and r3,r2	; 0232C5F0
	asr r3,r3,#0x4	; 0232C5F2
	str r3,[r0,#0x4]	; 0232C5F4
	ldrh r0,[r4,#0x0]	; 0232C5F6
	bic r0,r1	; 0232C5F8
	orr r0,r1	; 0232C5FA
	strh r0,[r4,#0x0]	; 0232C5FC
	ldrh r0,[r4,#0x0]	; 0232C5FE
	bic r0,r2	; 0232C600
	strh r0,[r4,#0x0]	; 0232C602
	add sp,#0x4	; 0232C604
	pop {r4}	; 0232C606
	bx lr	; 0232C608
	.byte 0xC0, 0x46	; 0232C60C
pool_0232C60C:
loc_0232C60C:
	.word REG_EXMEMCNT_ARM9	; 0232C60C

; ===== function loc_0232C610 =====
loc_0232C610:
	push {r4,lr}	; 0232C610
	sub sp,#0x10	; 0232C612
	mov r4,#0x1	; 0232C614
	ldr r2,[pool_0232C6B4]	; 0232C616
	ldrh r1,[r2,#0x0]	; 0232C618
	ldr r0,[pool_0232C6B8]	; 0232C61A
	cmp r1,r0	; 0232C61C
	bne loc_0232C62A	; 0232C61E
	mov r0,#0x0	; 0232C620
	add sp,#0x10	; 0232C622
	pop {r4}	; 0232C624
	pop {r3}	; 0232C626
	bx r3	; 0232C628
loc_0232C62A:
	ldrb r0,[r2,#0x5]	; 0232C62A
	lsl r0,r0,#0x1e	; 0232C62C
	lsr r0,r0,#0x1f	; 0232C62E
	cmp r0,#0x1	; 0232C630
	bne loc_0232C63E	; 0232C632
	mov r0,#0x0	; 0232C634
	add sp,#0x10	; 0232C636
	pop {r4}	; 0232C638
	pop {r3}	; 0232C63A
	bx r3	; 0232C63C
loc_0232C63E:
	ldr r0,[pool_0232C6BC]	; 0232C63E
	ldrh r0,[r0,#0x2]	; 0232C640
	add r1,sp,#0x0	; 0232C642
	bl loc_0232C568	; 0232C644
	add r0,sp,#0x8	; 0232C648
	bl loc_0232C5DC	; 0232C64A
	ldr r2,[pool_0232C6C0]	; 0232C64E
	add r0,r2,#0x0	; 0232C650
	add r0,#0xb2	; 0232C652
	ldrb r3,[r0,#0x0]	; 0232C654
	cmp r3,#0x96	; 0232C656
	bne loc_0232C666	; 0232C658
	ldr r0,[pool_0232C6B4]	; 0232C65A
	ldrh r1,[r0,#0x0]	; 0232C65C
	add r2,#0xbe	; 0232C65E
	ldrh r0,[r2,#0x0]	; 0232C660
	cmp r1,r0	; 0232C662
	bne loc_0232C68E	; 0232C664
loc_0232C666:
	cmp r3,#0x96	; 0232C666
	beq loc_0232C676	; 0232C668
	ldr r0,[pool_0232C6B4]	; 0232C66A
	ldrh r1,[r0,#0x0]	; 0232C66C
	ldr r0,[pool_0232C6C4]	; 0232C66E
	ldrh r0,[r0,#0x0]	; 0232C670
	cmp r1,r0	; 0232C672
	bne loc_0232C68E	; 0232C674
loc_0232C676:
	ldr r2,[pool_0232C6B4]	; 0232C676
	ldr r1,[r2,#0x8]	; 0232C678
	ldr r0,[pool_0232C6C0]	; 0232C67A
	add r0,#0xac	; 0232C67C
	ldr r0,[r0,#0x0]	; 0232C67E
	cmp r1,r0	; 0232C680
	beq loc_0232C69A	; 0232C682
	ldrb r0,[r2,#0x5]	; 0232C684
	lsl r0,r0,#0x1f	; 0232C686
	lsr r0,r0,#0x1f	; 0232C688
	cmp r0,#0x0	; 0232C68A
	beq loc_0232C69A	; 0232C68C
loc_0232C68E:
	ldr r2,[pool_0232C6B4]	; 0232C68E
	ldrb r1,[r2,#0x5]	; 0232C690
	mov r0,#0x2	; 0232C692
	orr r1,r0	; 0232C694
	strb r1,[r2,#0x5]	; 0232C696
	mov r4,#0x0	; 0232C698
loc_0232C69A:
	add r0,sp,#0x8	; 0232C69A
	bl loc_0232C5B0	; 0232C69C
	ldr r0,[pool_0232C6BC]	; 0232C6A0
	ldrh r0,[r0,#0x2]	; 0232C6A2
	add r1,sp,#0x0	; 0232C6A4
	bl loc_0232C54C	; 0232C6A6
	add r0,r4,#0x0	; 0232C6AA
	add sp,#0x10	; 0232C6AC
	pop {r4}	; 0232C6AE
	pop {r3}	; 0232C6B0
	bx r3	; 0232C6B2
pool_0232C6B4:
loc_0232C6B4:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C6B4
pool_0232C6B8:
loc_0232C6B8:
	.word 0x0000FFFF	; 0232C6B8
pool_0232C6BC:
loc_0232C6BC:
	.word P1_BssStart + 0x26688	; 0232C6BC
pool_0232C6C0:
loc_0232C6C0:
	.word Slot2BusBaseAddress	; 0232C6C0
pool_0232C6C4:
loc_0232C6C4:
	.word Slot2BusBaseAddress + 0x1FFFE	; 0232C6C4

; ===== function loc_0232C6C8 =====
loc_0232C6C8:
	push {lr}	; 0232C6C8
	sub sp,#0x4	; 0232C6CA
	ldr r2,[pool_0232C6FC]	; 0232C6CC
	ldrh r1,[r2,#0x0]	; 0232C6CE
	ldr r0,[pool_0232C700]	; 0232C6D0
	cmp r1,r0	; 0232C6D2
	bne loc_0232C6DE	; 0232C6D4
	mov r0,#0x0	; 0232C6D6
	add sp,#0x4	; 0232C6D8
	pop {r3}	; 0232C6DA
	bx r3	; 0232C6DC
loc_0232C6DE:
	ldrb r0,[r2,#0x5]	; 0232C6DE
	lsl r0,r0,#0x1e	; 0232C6E0
	lsr r0,r0,#0x1f	; 0232C6E2
	cmp r0,#0x0	; 0232C6E4
	bne loc_0232C6EC	; 0232C6E6
	bl loc_0232C610	; 0232C6E8
loc_0232C6EC:
	ldr r0,[pool_0232C6FC]	; 0232C6EC
	ldrb r0,[r0,#0x5]	; 0232C6EE
	lsl r0,r0,#0x1e	; 0232C6F0
	lsr r0,r0,#0x1f	; 0232C6F2
	add sp,#0x4	; 0232C6F4
	pop {r3}	; 0232C6F6
	bx r3	; 0232C6F8
	.byte 0xC0, 0x46	; 0232C6FC
pool_0232C6FC:
loc_0232C6FC:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C6FC
pool_0232C700:
loc_0232C700:
	.word 0x0000FFFF	; 0232C700

; ===== function loc_0232C704 =====
loc_0232C704:
	push {r4}	; 0232C704
	sub sp,#0x4	; 0232C706
	mov r4,#0x0	; 0232C708
	ldr r3,[pool_0232C72C]	; 0232C70A
	ldrh r2,[r3,#0x0]	; 0232C70C
	ldr r1,[pool_0232C730]	; 0232C70E
	cmp r2,r1	; 0232C710
	beq loc_0232C724	; 0232C712
	cmp r2,#0x0	; 0232C714
	beq loc_0232C724	; 0232C716
	ldrb r1,[r3,#0x0]	; 0232C718
	mvn r1,r1	; 0232C71A
	and r1,r0	; 0232C71C
	cmp r1,#0x0	; 0232C71E
	beq loc_0232C724	; 0232C720
	mov r4,#0x1	; 0232C722
loc_0232C724:
	add r0,r4,#0x0	; 0232C724
	add sp,#0x4	; 0232C726
	pop {r4}	; 0232C728
	bx lr	; 0232C72A
pool_0232C72C:
loc_0232C72C:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C72C
pool_0232C730:
loc_0232C730:
	.word 0x0000FFFF	; 0232C730

; ===== function loc_0232C734 =====
loc_0232C734:
	push {r4,lr}	; 0232C734
	add r4,r0,#0x0	; 0232C736
	bl loc_0232C610	; 0232C738
	cmp r0,#0x0	; 0232C73C
	beq loc_0232C752	; 0232C73E
	add r0,r4,#0x0	; 0232C740
	bl loc_0232C704	; 0232C742
	cmp r0,#0x0	; 0232C746
	beq loc_0232C752	; 0232C748
	mov r0,#0x1	; 0232C74A
	pop {r4}	; 0232C74C
	pop {r3}	; 0232C74E
	bx r3	; 0232C750
loc_0232C752:
	mov r0,#0x0	; 0232C752
	pop {r4}	; 0232C754
	pop {r3}	; 0232C756
	bx r3	; 0232C758
	.byte 0x00, 0x00	; 0232C75C

; ===== function loc_0232C75C =====
loc_0232C75C:
	push {lr}	; 0232C75C
	sub sp,#0x4	; 0232C75E
	mov r0,#0x0	; 0232C760
	str r0,[sp,#0x0]	; 0232C762
	add r0,sp,#0x0	; 0232C764
	ldr r1,[pool_0232C77C]	; 0232C766
	ldr r2,[pool_0232C780]	; 0232C768
	bl loc_0232C7C6	; 0232C76A
	blx loc_0232B260	; 0232C76E
	ldr r1,[pool_0232C77C]	; 0232C772
	strh r0,[r1,#0x2]	; 0232C774
	add sp,#0x4	; 0232C776
	pop {r3}	; 0232C778
	bx r3	; 0232C77A
pool_0232C77C:
loc_0232C77C:
	.word P1_BssStart + 0x26688	; 0232C77C
pool_0232C780:
loc_0232C780:
	.word 0x05000001	; 0232C780

; ===== function loc_0232C784 =====
loc_0232C784:
	push {lr}	; 0232C784
	sub sp,#0x4	; 0232C786
	ldr r0,[pool_0232C7A0]	; 0232C788
	ldr r1,[r0,#0x0]	; 0232C78A
	cmp r1,#0x0	; 0232C78C
	bne loc_0232C798	; 0232C78E
	mov r1,#0x1	; 0232C790
	str r1,[r0,#0x0]	; 0232C792
	bl loc_0232C75C	; 0232C794
loc_0232C798:
	add sp,#0x4	; 0232C798
	pop {r3}	; 0232C79A
	bx r3	; 0232C79C
	.byte 0xC0, 0x46	; 0232C7A0
pool_0232C7A0:
loc_0232C7A0:
	.word P1_BssStart + 0x2668C	; 0232C7A0
	.byte 0x00, 0xDF, 0x70, 0x47	; 0232C7A8

.func P1_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
	swi 0x3	; 0232C7A8
	bx lr	; 0232C7AA
.endfunc
	.byte 0x00, 0x22, 0x04, 0xDF, 0x70, 0x47	; 0232C7B2

.func P1_SwiVBlankIntrWait
; BIOS SWI #05: wait for VBlank IRQ. / BIOS SWI #05：等待 VBlank 中断。
	mov r2,#0x0	; 0232C7B2
	swi 0x5	; 0232C7B4
	bx lr	; 0232C7B6
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
loc_0232C7C6:
	swi 0xb	; 0232C7C6
	bx lr	; 0232C7C8
.endfunc

.func P1_SwiCpuFastSet
; BIOS SWI #0C: CpuFastSet copy/fill. / BIOS SWI #0C：CpuFastSet 复制/填充。
loc_0232C7CA:
	swi 0xc	; 0232C7CA
	bx lr	; 0232C7CC
.endfunc
.func P1_SwiSqrt
; BIOS SWI #0D: integer square root. / BIOS SWI #0D：整数平方根。
	swi 0xd
	bx lr
.endfunc

.func P1_SwiGetCrc16
; BIOS SWI #0E: CRC-16 service. / BIOS SWI #0E：CRC-16 服务。
loc_0232C7D2:
	swi 0xe	; 0232C7D2
	bx lr	; 0232C7D4
.endfunc
.func P1_SwiIsDebugger
; BIOS SWI #0F: detect debugger state. / BIOS SWI #0F：检测调试器状态。
	swi 0x0f
	bx lr
.endfunc

.func P1_SwiBitUnPack
; BIOS SWI #10: BitUnPack decoder. / BIOS SWI #10：BitUnPack 解码器。
loc_0232C7DA:
	swi 0x10	; 0232C7DA
	bx lr	; 0232C7DC
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
loc_0232C7E6:
	swi 0x13	; 0232C7E6
	bx lr	; 0232C7E8
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
loc_0232C7F4:
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
loc_0232C868:
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
loc_0232C944:
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x10, 0xB4, 0x81, 0xB0, 0x00, 0x2A, 0x17, 0xD0, 0x04, 0x78, 0x40, 0x1C	; 0232C954
	.byte 0x0B, 0x78, 0x49, 0x1C, 0x9C, 0x42, 0x0E, 0xD0, 0x40, 0x1E, 0x02, 0x78, 0x48, 0x1E, 0x00, 0x78	; 0232C964
	.byte 0x82, 0x42, 0x04, 0xD2, 0x00, 0x20, 0xC0, 0x43, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x01, 0x20	; 0232C974
	.byte 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x52, 0x1E, 0x00, 0x2A, 0xE7, 0xD1, 0x00, 0x20, 0x01, 0xB0	; 0232C984
	.byte 0x10, 0xBC, 0x70, 0x47	; 0232C988

; Standard memset: fill r2 bytes at r0 with low byte of r1 and return original r0.
; 标准 memset：以 r1 低字节填充 r0 起始的 r2 字节，并返回原 r0。
P1_MemSet:
; ===== function loc_0232C988 =====
	push {r4,lr}	; 0232C988
	add r4,r0,#0x0	; 0232C98A
	bl P1_MemSetCore	; 0232C98C
	add r0,r4,#0x0	; 0232C990
	pop {r4}	; 0232C992
	pop {r3}	; 0232C994
	bx r3	; 0232C996

; ===== function loc_0232C998 =====
; Core byte/word fill loop; r0 advances to the end. / 核心字节/字填充循环；r0 前进至末尾。
P1_MemSetCore:
loc_0232C998:
	push {r4,r5}	; 0232C998
	lsl r1,r1,#0x18	; 0232C99A
	lsr r1,r1,#0x18	; 0232C99C
	cmp r2,#0x20	; 0232C99E
	bcc loc_0232CA06	; 0232C9A0
	neg r4,r0	; 0232C9A2
	mov r3,#0x3	; 0232C9A4
	and r4,r3	; 0232C9A6
	cmp r4,#0x0	; 0232C9A8
	beq loc_0232C9BC	; 0232C9AA
	sub r2,r2,r4	; 0232C9AC
	lsl r3,r1,#0x18	; 0232C9AE
	lsr r3,r3,#0x18	; 0232C9B0
loc_0232C9B2:
	strb r3,[r0,#0x0]	; 0232C9B2
	add r0,r0,#0x1	; 0232C9B4
	sub r4,r4,#0x1	; 0232C9B6
	cmp r4,#0x0	; 0232C9B8
	bne loc_0232C9B2	; 0232C9BA
loc_0232C9BC:
	cmp r1,#0x0	; 0232C9BC
	beq loc_0232C9CC	; 0232C9BE
	lsl r5,r1,#0x8	; 0232C9C0
	lsl r4,r1,#0x18	; 0232C9C2
	lsl r3,r1,#0x10	; 0232C9C4
	orr r4,r3	; 0232C9C6
	orr r5,r4	; 0232C9C8
	orr r1,r5	; 0232C9CA
loc_0232C9CC:
	lsr r4,r2,#0x5	; 0232C9CC
	cmp r4,#0x0	; 0232C9CE
	beq loc_0232C9EE	; 0232C9D0
loc_0232C9D2:
	str r1,[r0,#0x0]	; 0232C9D2
	str r1,[r0,#0x4]	; 0232C9D4
	str r1,[r0,#0x8]	; 0232C9D6
	str r1,[r0,#0xc]	; 0232C9D8
	str r1,[r0,#0x10]	; 0232C9DA
	str r1,[r0,#0x14]	; 0232C9DC
	str r1,[r0,#0x18]	; 0232C9DE
	add r3,r0,#0x0	; 0232C9E0
	add r3,#0x1c	; 0232C9E2
	add r0,#0x20	; 0232C9E4
	str r1,[r3,#0x0]	; 0232C9E6
	sub r4,r4,#0x1	; 0232C9E8
	cmp r4,#0x0	; 0232C9EA
	bne loc_0232C9D2	; 0232C9EC
loc_0232C9EE:
	mov r3,#0x1f	; 0232C9EE
	add r4,r2,#0x0	; 0232C9F0
	and r4,r3	; 0232C9F2
	lsr r3,r4,#0x2	; 0232C9F4
	cmp r3,#0x0	; 0232C9F6
	beq loc_0232CA02	; 0232C9F8
loc_0232C9FA:
	stmia r0!,{r1}	; 0232C9FA
	sub r3,r3,#0x1	; 0232C9FC
	cmp r3,#0x0	; 0232C9FE
	bne loc_0232C9FA	; 0232CA00
loc_0232CA02:
	mov r3,#0x3	; 0232CA02
	and r2,r3	; 0232CA04
loc_0232CA06:
	cmp r2,#0x0	; 0232CA06
	beq loc_0232CA18	; 0232CA08
	lsl r1,r1,#0x18	; 0232CA0A
	lsr r1,r1,#0x18	; 0232CA0C
loc_0232CA0E:
	strb r1,[r0,#0x0]	; 0232CA0E
	add r0,r0,#0x1	; 0232CA10
	sub r2,r2,#0x1	; 0232CA12
	cmp r2,#0x0	; 0232CA14
	bne loc_0232CA0E	; 0232CA16
loc_0232CA18:
	pop {r4,r5}	; 0232CA18
	bx lr	; 0232CA1A

; UTF-16 strchr: find a code unit, including the terminating NUL. / UTF-16 strchr：查找码元，包括结尾 NUL。
P1_Utf16StrChr:
; ===== function loc_0232CA1C =====
loc_0232CA1C:
	add r2,r0,#0x2	; 0232CA1C
	ldrh r0,[r0,#0x0]	; 0232CA1E
	cmp r0,#0x0	; 0232CA20
	beq loc_0232CA34	; 0232CA22
loc_0232CA24:
	cmp r0,r1	; 0232CA24
	bne loc_0232CA2C	; 0232CA26
	sub r0,r2,#0x2	; 0232CA28
	bx lr	; 0232CA2A
loc_0232CA2C:
	ldrh r0,[r2,#0x0]	; 0232CA2C
	add r2,r2,#0x2	; 0232CA2E
	cmp r0,#0x0	; 0232CA30
	bne loc_0232CA24	; 0232CA32
loc_0232CA34:
	cmp r1,#0x0	; 0232CA34
	beq loc_0232CA3C	; 0232CA36
	mov r0,#0x0	; 0232CA38
	bx lr	; 0232CA3A
loc_0232CA3C:
	sub r0,r2,#0x2	; 0232CA3C
	bx lr	; 0232CA3E

; UTF-16 bounded comparison. / UTF-16 定长字符串比较。
P1_Utf16StrNCmp:
; ===== function loc_0232CA40 =====
	push {r4}	; 0232CA40
	sub sp,#0x4	; 0232CA42
	cmp r2,#0x0	; 0232CA44
	beq loc_0232CA66	; 0232CA46
loc_0232CA48:
	ldrh r4,[r1,#0x0]	; 0232CA48
	add r1,r1,#0x2	; 0232CA4A
	ldrh r3,[r0,#0x0]	; 0232CA4C
	add r0,r0,#0x2	; 0232CA4E
	cmp r3,r4	; 0232CA50
	beq loc_0232CA5C	; 0232CA52
	sub r0,r3,r4	; 0232CA54
	add sp,#0x4	; 0232CA56
	pop {r4}	; 0232CA58
	bx lr	; 0232CA5A
loc_0232CA5C:
	cmp r3,#0x0	; 0232CA5C
	beq loc_0232CA66	; 0232CA5E
	sub r2,r2,#0x1	; 0232CA60
	cmp r2,#0x0	; 0232CA62
	bne loc_0232CA48	; 0232CA64
loc_0232CA66:
	mov r0,#0x0	; 0232CA66
	add sp,#0x4	; 0232CA68
	pop {r4}	; 0232CA6A
	bx lr	; 0232CA6C
	.byte 0x00, 0x00, 0x10, 0xB4, 0x81, 0xB0, 0x04, 0x1C, 0x22, 0x88, 0xA4, 0x1C, 0x00, 0x2A, 0xFB, 0xD1	; 0232CA7E
	.byte 0xA4, 0x1E, 0x23, 0x1C, 0x0A, 0x88, 0x89, 0x1C, 0x22, 0x80, 0xA4, 0x1C, 0x1A, 0x88, 0x00, 0x2A	; 0232CA8E
	.byte 0xF7, 0xD1, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x00, 0x00	; 0232CA98

; UTF-16 bounded copy with NUL padding. / UTF-16 定长复制，结尾不足时补 NUL。
P1_Utf16StrNCpy:
; ===== function loc_0232CA98 =====
loc_0232CA98:
	push {r4,r5}	; 0232CA98
	add r5,r0,#0x0	; 0232CA9A
	cmp r2,#0x0	; 0232CA9C
	beq loc_0232CACC	; 0232CA9E
loc_0232CAA0:
	add r4,r5,#0x0	; 0232CAA0
	ldrh r3,[r1,#0x0]	; 0232CAA2
	add r1,r1,#0x2	; 0232CAA4
	strh r3,[r5,#0x0]	; 0232CAA6
	add r5,r5,#0x2	; 0232CAA8
	ldrh r3,[r4,#0x0]	; 0232CAAA
	cmp r3,#0x0	; 0232CAAC
	bne loc_0232CAC6	; 0232CAAE
	sub r2,r2,#0x1	; 0232CAB0
	cmp r2,#0x0	; 0232CAB2
	beq loc_0232CACC	; 0232CAB4
	mov r1,#0x0	; 0232CAB6
loc_0232CAB8:
	strh r1,[r5,#0x0]	; 0232CAB8
	add r5,r5,#0x2	; 0232CABA
	sub r2,r2,#0x1	; 0232CABC
	cmp r2,#0x0	; 0232CABE
	bne loc_0232CAB8	; 0232CAC0
	pop {r4,r5}	; 0232CAC2
	bx lr	; 0232CAC4
loc_0232CAC6:
	sub r2,r2,#0x1	; 0232CAC6
	cmp r2,#0x0	; 0232CAC8
	bne loc_0232CAA0	; 0232CACA
loc_0232CACC:
	pop {r4,r5}	; 0232CACC
	bx lr	; 0232CACE

; UTF-16 unbounded copy through the terminating NUL. / UTF-16 复制，直至结尾 NUL。
P1_Utf16StrCpy:
; ===== function loc_0232CAD0 =====
loc_0232CAD0:
	push {r4}	; 0232CAD0
	sub sp,#0x4	; 0232CAD2
	add r4,r0,#0x0	; 0232CAD4
loc_0232CAD6:
	add r3,r4,#0x0	; 0232CAD6
	ldrh r2,[r1,#0x0]	; 0232CAD8
	add r1,r1,#0x2	; 0232CADA
	strh r2,[r4,#0x0]	; 0232CADC
	add r4,r4,#0x2	; 0232CADE
	ldrh r2,[r3,#0x0]	; 0232CAE0
	cmp r2,#0x0	; 0232CAE2
	bne loc_0232CAD6	; 0232CAE4
	add sp,#0x4	; 0232CAE6
	pop {r4}	; 0232CAE8
	bx lr	; 0232CAEA
; UTF-16 strlen: count code units before the terminating NUL. / UTF-16 strlen：统计结尾 NUL 前的码元数。
P1_Utf16StrLen:
; ===== function loc_0232CAEC =====
loc_0232CAEC:
	mov r1,#0x0	; 0232CAEC
	mvn r2,r1	; 0232CAEE
loc_0232CAF0:
	add r2,r2,#0x1	; 0232CAF0
	ldrh r1,[r0,#0x0]	; 0232CAF2
	add r0,r0,#0x2	; 0232CAF4
	cmp r1,#0x0	; 0232CAF6
	bne loc_0232CAF0	; 0232CAF8
	add r0,r2,#0x0	; 0232CAFA
	bx lr	; 0232CAFC
	.hword 0x0000	; padding / 对齐填充。
.arm

; ===== function loc_0232CB00 =====
loc_0232CB00:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CB00
	mov r4,#0x0	; 0232CB04
	b loc_0232CB14	; 0232CB08
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 0232CB14
loc_0232CB14:
	orrs r5,r3,r2	; 0232CB14
	bne loc_0232CB24	; 0232CB18
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CB1C
	bx lr	; 0232CB20
loc_0232CB24:
	orrs r5,r1,r3	; 0232CB24
	bne loc_0232CBCC	; 0232CB28
	mov r1,r2	; 0232CB2C
	bl loc_0232CF3C	; 0232CB30
	cmp r4,#0x0	; 0232CB34
	movne r0,r1	; 0232CB38
	mov r1,#0x0	; 0232CB3C
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CB40
	bx lr	; 0232CB44
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 0232CB58
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x03, 0x40, 0x21, 0xE0, 0xC4, 0x40, 0xA0, 0xE1, 0x84, 0x40, 0xA0, 0xE1	; 0232CB68
	.byte 0x02, 0x50, 0x93, 0xE1, 0x01, 0x00, 0x00, 0x1A, 0xF0, 0x58, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 0232CB78
	.byte 0xA0, 0x5F, 0xA0, 0xE1, 0x01, 0x50, 0x85, 0xE0, 0xA2, 0x6F, 0xA0, 0xE1, 0x03, 0x60, 0x86, 0xE0	; 0232CB88
	.byte 0x06, 0x60, 0x95, 0xE1, 0x06, 0x00, 0x00, 0x1A, 0x02, 0x10, 0xA0, 0xE1, 0x63, 0x00, 0x00, 0xEB	; 0232CB98
	.byte 0x01, 0x40, 0x14, 0xE2, 0x01, 0x00, 0xA0, 0x11, 0xC0, 0x1F, 0xA0, 0xE1, 0xF0, 0x58, 0xBD, 0xE8	; 0232CBA8
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x00, 0x00, 0x51, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x00, 0x70, 0xE2	; 0232CBB8
	.byte 0x00, 0x10, 0xE1, 0xE2, 0x00, 0x00, 0x53, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x20, 0x72, 0xE2	; 0232CBC8
	.byte 0x00, 0x30, 0xE3, 0xE2	; 0232CBCC
loc_0232CBCC:
	orrs r5,r1,r0	; 0232CBCC
	beq loc_0232CCF0	; 0232CBD0
	mov r5,#0x0	; 0232CBD4
	mov r6,#0x1	; 0232CBD8
	cmp r3,#0x0	; 0232CBDC
	bmi loc_0232CBF8	; 0232CBE0
loc_0232CBE4:
	add r5,r5,#0x1	; 0232CBE4
	adds r2,r2,r2	; 0232CBE8
	adcs r3,r3,r3	; 0232CBEC
	bpl loc_0232CBE4	; 0232CBF0
	add r6,r6,r5	; 0232CBF4
loc_0232CBF8:
	cmp r1,#0x0	; 0232CBF8
	blt loc_0232CC18	; 0232CBFC
loc_0232CC00:
	cmp r6,#0x1	; 0232CC00
	beq loc_0232CC18	; 0232CC04
	sub r6,r6,#0x1	; 0232CC08
	adds r0,r0,r0	; 0232CC0C
	adcs r1,r1,r1	; 0232CC10
	bpl loc_0232CC00	; 0232CC14
loc_0232CC18:
	mov r7,#0x0	; 0232CC18
	mov r12,#0x0	; 0232CC1C
	mov r11,#0x0	; 0232CC20
	b loc_0232CC40	; 0232CC24
loc_0232CC28:
	orr r12,r12,#0x1	; 0232CC28
	subs r6,r6,#0x1	; 0232CC2C
	beq loc_0232CC98	; 0232CC30
	adds r0,r0,r0	; 0232CC34
	adcs r1,r1,r1	; 0232CC38
	adcs r7,r7,r7	; 0232CC3C
loc_0232CC40:
	subs r0,r0,r2	; 0232CC40
	sbcs r1,r1,r3	; 0232CC44
	sbcs r7,r7,#0x0	; 0232CC48
	adds r12,r12,r12	; 0232CC4C
	adc r11,r11,r11	; 0232CC50
	cmp r7,#0x0	; 0232CC54
	bge loc_0232CC28	; 0232CC58
loc_0232CC5C:
	subs r6,r6,#0x1	; 0232CC5C
	beq loc_0232CC90	; 0232CC60
	adds r0,r0,r0	; 0232CC64
	adcs r1,r1,r1	; 0232CC68
	adc r7,r7,r7	; 0232CC6C
	adds r0,r0,r2	; 0232CC70
	adcs r1,r1,r3	; 0232CC74
	adc r7,r7,#0x0	; 0232CC78
	adds r12,r12,r12	; 0232CC7C
	adc r11,r11,r11	; 0232CC80
	cmp r7,#0x0	; 0232CC84
	bge loc_0232CC28	; 0232CC88
	b loc_0232CC5C	; 0232CC8C
loc_0232CC90:
	adds r0,r0,r2	; 0232CC90
	adc r1,r1,r3	; 0232CC94
loc_0232CC98:
	ands r7,r4,#0x1	; 0232CC98
	moveq r0,r12	; 0232CC9C
	moveq r1,r11	; 0232CCA0
	beq loc_0232CCD0	; 0232CCA4
	subs r7,r5,#0x20	; 0232CCA8
	movge r0,r1, lsr r7	; 0232CCAC
	bge loc_0232CCF4	; 0232CCB0
	rsb r7,r5,#0x20	; 0232CCB4
	mov r0,r0, lsr r5	; 0232CCB8
	orr r0,r0,r1, lsl r7	; 0232CCBC
	mov r1,r1, lsr r5	; 0232CCC0
	b loc_0232CCD0	; 0232CCC4
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 0232CCD0
loc_0232CCD0:
	cmp r4,#0x0	; 0232CCD0
	blt loc_0232CCE0	; 0232CCD4
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CCD8
	bx lr	; 0232CCDC
loc_0232CCE0:
	rsbs r0,r0,#0x0	; 0232CCE0
	rsc r1,r1,#0x0	; 0232CCE4
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CCE8
	bx lr	; 0232CCEC
loc_0232CCF0:
	mov r0,#0x0	; 0232CCF0
loc_0232CCF4:
	mov r1,#0x0	; 0232CCF4
	cmp r4,#0x0	; 0232CCF8
	blt loc_0232CCE0	; 0232CCFC
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CD00
	bx lr	; 0232CD04

; ARM EABI 64-bit multiply (__aeabi_lmul); the bit pattern is identical for signed and unsigned operands. / ARM EABI 64 位乘法（__aeabi_lmul）；有符号与无符号操作数的位级结果相同。
P1_AeabiLmul:
; ===== function loc_0232CD08 =====
loc_0232CD08:
	stmdb sp!,{r4,r5,lr}	; 0232CD08
	umull r5,r4,r0,r2	; 0232CD0C
	mla r4,r0,r3,r4	; 0232CD10
	mla r4,r2,r1,r4	; 0232CD14
	mov r1,r4	; 0232CD18
	mov r0,r5	; 0232CD1C
	ldmia sp!,{r4,r5,lr}	; 0232CD20
	bx lr	; 0232CD24

; 32-bit signed division with remainder: r0 = quotient, r1 = remainder. / 32 位有符号除法及取余：r0 为商，r1 为余数。
P1_SignedDivMod:
; ===== function loc_0232CD28 =====
loc_0232CD28:
	eor r12,r0,r1	; 0232CD28
	and r12,r12,#0x80000000	; 0232CD2C
	cmp r0,#0x0	; 0232CD30
	rsblt r0,r0,#0x0	; 0232CD34
	addlt r12,r12,#0x1	; 0232CD38
	cmp r1,#0x0	; 0232CD3C
	rsblt r1,r1,#0x0	; 0232CD40
	beq loc_0232CF20	; 0232CD44
	cmp r0,r1	; 0232CD48
	movcc r1,r0	; 0232CD4C
	movcc r0,#0x0	; 0232CD50
	bcc loc_0232CF20	; 0232CD54
	mov r2,#0x1c	; 0232CD58
	mov r3,r0, lsr #0x4	; 0232CD5C
	cmp r1,r3, lsr #0xc	; 0232CD60
	suble r2,r2,#0x10	; 0232CD64
	movle r3,r3, lsr #0x10	; 0232CD68
	cmp r1,r3, lsr #0x4	; 0232CD6C
	suble r2,r2,#0x8	; 0232CD70
	movle r3,r3, lsr #0x8	; 0232CD74
	cmp r1,r3	; 0232CD78
	suble r2,r2,#0x4	; 0232CD7C
	movle r3,r3, lsr #0x4	; 0232CD80
	mov r0,r0, lsl r2	; 0232CD84
	rsb r1,r1,#0x0	; 0232CD88
	adds r0,r0,r0	; 0232CD8C
	add r2,r2,r2, lsl #0x1	; 0232CD90
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CD94PC:
	add pc,pc,r2, lsl #0x2	; 0232CD94
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CD9C
loc_0232CD9C:
P1_DivisionDispatch_0232CD94Steps:
	adcs r3,r1,r3, lsl #0x1	; 0232CD9C
	subcc r3,r3,r1	; 0232CDA0
	adcs r0,r0,r0	; 0232CDA4
	adcs r3,r1,r3, lsl #0x1	; 0232CDA8
	subcc r3,r3,r1	; 0232CDAC
	adcs r0,r0,r0	; 0232CDB0
	adcs r3,r1,r3, lsl #0x1	; 0232CDB4
	subcc r3,r3,r1	; 0232CDB8
	adcs r0,r0,r0	; 0232CDBC
	adcs r3,r1,r3, lsl #0x1	; 0232CDC0
	subcc r3,r3,r1	; 0232CDC4
	adcs r0,r0,r0	; 0232CDC8
loc_0232CDCC:
	adcs r3,r1,r3, lsl #0x1	; 0232CDCC
	subcc r3,r3,r1	; 0232CDD0
	adcs r0,r0,r0	; 0232CDD4
	adcs r3,r1,r3, lsl #0x1	; 0232CDD8
	subcc r3,r3,r1	; 0232CDDC
	adcs r0,r0,r0	; 0232CDE0
	adcs r3,r1,r3, lsl #0x1	; 0232CDE4
	subcc r3,r3,r1	; 0232CDE8
	adcs r0,r0,r0	; 0232CDEC
	adcs r3,r1,r3, lsl #0x1	; 0232CDF0
	subcc r3,r3,r1	; 0232CDF4
	adcs r0,r0,r0	; 0232CDF8
loc_0232CDFC:
	adcs r3,r1,r3, lsl #0x1	; 0232CDFC
	subcc r3,r3,r1	; 0232CE00
	adcs r0,r0,r0	; 0232CE04
	adcs r3,r1,r3, lsl #0x1	; 0232CE08
	subcc r3,r3,r1	; 0232CE0C
	adcs r0,r0,r0	; 0232CE10
	adcs r3,r1,r3, lsl #0x1	; 0232CE14
	subcc r3,r3,r1	; 0232CE18
	adcs r0,r0,r0	; 0232CE1C
	adcs r3,r1,r3, lsl #0x1	; 0232CE20
	subcc r3,r3,r1	; 0232CE24
	adcs r0,r0,r0	; 0232CE28
	adcs r3,r1,r3, lsl #0x1	; 0232CE2C
	subcc r3,r3,r1	; 0232CE30
	adcs r0,r0,r0	; 0232CE34
	adcs r3,r1,r3, lsl #0x1	; 0232CE38
	subcc r3,r3,r1	; 0232CE3C
	adcs r0,r0,r0	; 0232CE40
	adcs r3,r1,r3, lsl #0x1	; 0232CE44
	subcc r3,r3,r1	; 0232CE48
	adcs r0,r0,r0	; 0232CE4C
	adcs r3,r1,r3, lsl #0x1	; 0232CE50
	subcc r3,r3,r1	; 0232CE54
	adcs r0,r0,r0	; 0232CE58
loc_0232CE5C:
	adcs r3,r1,r3, lsl #0x1	; 0232CE5C
	subcc r3,r3,r1	; 0232CE60
	adcs r0,r0,r0	; 0232CE64
	adcs r3,r1,r3, lsl #0x1	; 0232CE68
	subcc r3,r3,r1	; 0232CE6C
	adcs r0,r0,r0	; 0232CE70
	adcs r3,r1,r3, lsl #0x1	; 0232CE74
	subcc r3,r3,r1	; 0232CE78
	adcs r0,r0,r0	; 0232CE7C
	adcs r3,r1,r3, lsl #0x1	; 0232CE80
	subcc r3,r3,r1	; 0232CE84
	adcs r0,r0,r0	; 0232CE88
	adcs r3,r1,r3, lsl #0x1	; 0232CE8C
	subcc r3,r3,r1	; 0232CE90
	adcs r0,r0,r0	; 0232CE94
	adcs r3,r1,r3, lsl #0x1	; 0232CE98
	subcc r3,r3,r1	; 0232CE9C
	adcs r0,r0,r0	; 0232CEA0
	adcs r3,r1,r3, lsl #0x1	; 0232CEA4
	subcc r3,r3,r1	; 0232CEA8
	adcs r0,r0,r0	; 0232CEAC
	adcs r3,r1,r3, lsl #0x1	; 0232CEB0
	subcc r3,r3,r1	; 0232CEB4
	adcs r0,r0,r0	; 0232CEB8
	adcs r3,r1,r3, lsl #0x1	; 0232CEBC
	subcc r3,r3,r1	; 0232CEC0
	adcs r0,r0,r0	; 0232CEC4
	adcs r3,r1,r3, lsl #0x1	; 0232CEC8
	subcc r3,r3,r1	; 0232CECC
	adcs r0,r0,r0	; 0232CED0
	adcs r3,r1,r3, lsl #0x1	; 0232CED4
	subcc r3,r3,r1	; 0232CED8
	adcs r0,r0,r0	; 0232CEDC
	adcs r3,r1,r3, lsl #0x1	; 0232CEE0
	subcc r3,r3,r1	; 0232CEE4
	adcs r0,r0,r0	; 0232CEE8
	adcs r3,r1,r3, lsl #0x1	; 0232CEEC
	subcc r3,r3,r1	; 0232CEF0
	adcs r0,r0,r0	; 0232CEF4
	adcs r3,r1,r3, lsl #0x1	; 0232CEF8
	subcc r3,r3,r1	; 0232CEFC
	adcs r0,r0,r0	; 0232CF00
	adcs r3,r1,r3, lsl #0x1	; 0232CF04
	subcc r3,r3,r1	; 0232CF08
	adcs r0,r0,r0	; 0232CF0C
	adcs r3,r1,r3, lsl #0x1	; 0232CF10
	subcc r3,r3,r1	; 0232CF14
	adcs r0,r0,r0	; 0232CF18
P1_DivisionDispatch_0232CD94End:
.if (P1_DivisionDispatch_0232CD94Steps != P1_DivisionDispatch_0232CD94PC + 8) || (P1_DivisionDispatch_0232CD94End - P1_DivisionDispatch_0232CD94Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232CF1C
loc_0232CF20:
	ands r3,r12,#0x80000000	; 0232CF20
	rsbne r0,r0,#0x0	; 0232CF24
	ands r3,r12,#0x1	; 0232CF28
	rsbne r1,r1,#0x0	; 0232CF2C
	bx lr	; 0232CF30

; 32-bit unsigned division with remainder; the first entry returns immediately for a zero divisor. / 32 位无符号除法及取余；除数为零时第一个入口直接返回。
P1_UnsignedDivMod:
; ===== function loc_0232CF34 =====
loc_0232CF34:
	cmp r1,#0x0	; 0232CF34
	bxeq lr	; 0232CF38

; ===== function loc_0232CF3C =====
loc_0232CF3C:
	cmp r0,r1	; 0232CF3C
	movcc r1,r0	; 0232CF40
	movcc r0,#0x0	; 0232CF44
	bxcc lr	; 0232CF48
	mov r2,#0x1c	; 0232CF4C
	mov r3,r0, lsr #0x4	; 0232CF50
	cmp r1,r3, lsr #0xc	; 0232CF54
	suble r2,r2,#0x10	; 0232CF58
	movle r3,r3, lsr #0x10	; 0232CF5C
	cmp r1,r3, lsr #0x4	; 0232CF60
	suble r2,r2,#0x8	; 0232CF64
	movle r3,r3, lsr #0x8	; 0232CF68
	cmp r1,r3	; 0232CF6C
	suble r2,r2,#0x4	; 0232CF70
	movle r3,r3, lsr #0x4	; 0232CF74
	mov r0,r0, lsl r2	; 0232CF78
	rsb r1,r1,#0x0	; 0232CF7C
	adds r0,r0,r0	; 0232CF80
	add r2,r2,r2, lsl #0x1	; 0232CF84
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CF88PC:
	add pc,pc,r2, lsl #0x2	; 0232CF88
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CF90
loc_0232CF90:
P1_DivisionDispatch_0232CF88Steps:
	adcs r3,r1,r3, lsl #0x1	; 0232CF90
	subcc r3,r3,r1	; 0232CF94
	adcs r0,r0,r0	; 0232CF98
	adcs r3,r1,r3, lsl #0x1	; 0232CF9C
	subcc r3,r3,r1	; 0232CFA0
	adcs r0,r0,r0	; 0232CFA4
	adcs r3,r1,r3, lsl #0x1	; 0232CFA8
	subcc r3,r3,r1	; 0232CFAC
	adcs r0,r0,r0	; 0232CFB0
	adcs r3,r1,r3, lsl #0x1	; 0232CFB4
	subcc r3,r3,r1	; 0232CFB8
	adcs r0,r0,r0	; 0232CFBC
loc_0232CFC0:
	adcs r3,r1,r3, lsl #0x1	; 0232CFC0
	subcc r3,r3,r1	; 0232CFC4
	adcs r0,r0,r0	; 0232CFC8
	adcs r3,r1,r3, lsl #0x1	; 0232CFCC
	subcc r3,r3,r1	; 0232CFD0
	adcs r0,r0,r0	; 0232CFD4
	adcs r3,r1,r3, lsl #0x1	; 0232CFD8
	subcc r3,r3,r1	; 0232CFDC
	adcs r0,r0,r0	; 0232CFE0
	adcs r3,r1,r3, lsl #0x1	; 0232CFE4
	subcc r3,r3,r1	; 0232CFE8
	adcs r0,r0,r0	; 0232CFEC
loc_0232CFF0:
	adcs r3,r1,r3, lsl #0x1	; 0232CFF0
	subcc r3,r3,r1	; 0232CFF4
	adcs r0,r0,r0	; 0232CFF8
	adcs r3,r1,r3, lsl #0x1	; 0232CFFC
	subcc r3,r3,r1	; 0232D000
	adcs r0,r0,r0	; 0232D004
	adcs r3,r1,r3, lsl #0x1	; 0232D008
	subcc r3,r3,r1	; 0232D00C
	adcs r0,r0,r0	; 0232D010
	adcs r3,r1,r3, lsl #0x1	; 0232D014
	subcc r3,r3,r1	; 0232D018
	adcs r0,r0,r0	; 0232D01C
	adcs r3,r1,r3, lsl #0x1	; 0232D020
	subcc r3,r3,r1	; 0232D024
	adcs r0,r0,r0	; 0232D028
	adcs r3,r1,r3, lsl #0x1	; 0232D02C
	subcc r3,r3,r1	; 0232D030
	adcs r0,r0,r0	; 0232D034
	adcs r3,r1,r3, lsl #0x1	; 0232D038
	subcc r3,r3,r1	; 0232D03C
	adcs r0,r0,r0	; 0232D040
	adcs r3,r1,r3, lsl #0x1	; 0232D044
	subcc r3,r3,r1	; 0232D048
	adcs r0,r0,r0	; 0232D04C
loc_0232D050:
	adcs r3,r1,r3, lsl #0x1	; 0232D050
	subcc r3,r3,r1	; 0232D054
	adcs r0,r0,r0	; 0232D058
	adcs r3,r1,r3, lsl #0x1	; 0232D05C
	subcc r3,r3,r1	; 0232D060
	adcs r0,r0,r0	; 0232D064
	adcs r3,r1,r3, lsl #0x1	; 0232D068
	subcc r3,r3,r1	; 0232D06C
	adcs r0,r0,r0	; 0232D070
	adcs r3,r1,r3, lsl #0x1	; 0232D074
	subcc r3,r3,r1	; 0232D078
	adcs r0,r0,r0	; 0232D07C
	adcs r3,r1,r3, lsl #0x1	; 0232D080
	subcc r3,r3,r1	; 0232D084
	adcs r0,r0,r0	; 0232D088
	adcs r3,r1,r3, lsl #0x1	; 0232D08C
	subcc r3,r3,r1	; 0232D090
	adcs r0,r0,r0	; 0232D094
	adcs r3,r1,r3, lsl #0x1	; 0232D098
	subcc r3,r3,r1	; 0232D09C
	adcs r0,r0,r0	; 0232D0A0
	adcs r3,r1,r3, lsl #0x1	; 0232D0A4
	subcc r3,r3,r1	; 0232D0A8
	adcs r0,r0,r0	; 0232D0AC
	adcs r3,r1,r3, lsl #0x1	; 0232D0B0
	subcc r3,r3,r1	; 0232D0B4
	adcs r0,r0,r0	; 0232D0B8
	adcs r3,r1,r3, lsl #0x1	; 0232D0BC
	subcc r3,r3,r1	; 0232D0C0
	adcs r0,r0,r0	; 0232D0C4
	adcs r3,r1,r3, lsl #0x1	; 0232D0C8
	subcc r3,r3,r1	; 0232D0CC
	adcs r0,r0,r0	; 0232D0D0
	adcs r3,r1,r3, lsl #0x1	; 0232D0D4
	subcc r3,r3,r1	; 0232D0D8
	adcs r0,r0,r0	; 0232D0DC
	adcs r3,r1,r3, lsl #0x1	; 0232D0E0
	subcc r3,r3,r1	; 0232D0E4
	adcs r0,r0,r0	; 0232D0E8
	adcs r3,r1,r3, lsl #0x1	; 0232D0EC
	subcc r3,r3,r1	; 0232D0F0
	adcs r0,r0,r0	; 0232D0F4
	adcs r3,r1,r3, lsl #0x1	; 0232D0F8
	subcc r3,r3,r1	; 0232D0FC
	adcs r0,r0,r0	; 0232D100
	adcs r3,r1,r3, lsl #0x1	; 0232D104
	subcc r3,r3,r1	; 0232D108
	adcs r0,r0,r0	; 0232D10C
P1_DivisionDispatch_0232CF88End:
.if (P1_DivisionDispatch_0232CF88Steps != P1_DivisionDispatch_0232CF88PC + 8) || (P1_DivisionDispatch_0232CF88End - P1_DivisionDispatch_0232CF88Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232D110
	bx lr	; 0232D114

; ===== function loc_0232D118 =====
; 清空启动期控制块；具体字段含义仍待逐项确认。
; Clears early runtime control blocks; individual fields remain to be mapped.
P1_InitializeRuntimeState:
loc_0232D118:
	stmdb sp!,{lr}	; 0232D118
	blx P1_GetRuntimeStateSlot0	; 0232D11C
	mov r1,#0x0	; 0232D120
	str r1,[r0,#0x0]	; 0232D124
	blx P1_GetRuntimeStateSlot1	; 0232D128
	mov r1,#0x0	; 0232D12C
	str r1,[r0,#0x4]	; 0232D130
	str r1,[r0,#0x8]	; 0232D134
	str r1,[r0,#0xc]	; 0232D138
	str r1,[r0,#0x10]	; 0232D13C
	str r1,[r0,#0x14]	; 0232D140
	ldmia sp!,{lr}	; 0232D144
	bx lr	; 0232D148
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x28, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232D15C
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232D16C
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 0232D17C
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 0232D18C
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x18, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232D19C
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232D1AC
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 0232D1BC
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 0232D1C0
.thumb

; Clears a byte range only when both the pointer and length are nonzero.
; 仅当指针和长度均非零时清零指定字节范围。
.func P1_ClearByteRangeIfNonNull
	add r3,r0,#0x0	; 0232D1C0
	cmp r0,#0x0	; 0232D1C2
	beq loc_0232D1D6	; 0232D1C4
	cmp r1,#0x0	; 0232D1C6
	beq loc_0232D1D6	; 0232D1C8
	mov r2,#0x0	; 0232D1CA
loc_0232D1CC:
	strb r2,[r3,#0x0]	; 0232D1CC
	add r3,r3,#0x1	; 0232D1CE
	sub r1,r1,#0x1	; 0232D1D0
	cmp r1,#0x0	; 0232D1D2
	bne loc_0232D1CC	; 0232D1D4
loc_0232D1D6:
	bx lr	; 0232D1D6
.endfunc

; ===== function loc_0232D1D8 =====
; 依次调用以 NULL 结尾的函数指针表。
; Calls a NULL-terminated table of function pointers.
P1_CallStaticInitializers:
loc_0232D1D8:
	push {r4,lr}	; 0232D1D8
	ldr r4,[pool_0232D1F4]	; 0232D1DA
	b loc_0232D1E2	; 0232D1DC
loc_0232D1DE:
	blx r0	; 0232D1DE
	add r4,r4,#0x4	; 0232D1E0
loc_0232D1E2:
	cmp r4,#0x0	; 0232D1E2
	beq loc_0232D1EC	; 0232D1E4
	ldr r0,[r4,#0x0]	; 0232D1E6
	cmp r0,#0x0	; 0232D1E8
	bne loc_0232D1DE	; 0232D1EA
loc_0232D1EC:
	pop {r4}	; 0232D1EC
	pop {r3}	; 0232D1EE
	bx r3	; 0232D1F0
	.byte 0xC0, 0x46	; 0232D1F4
pool_0232D1F4:
loc_0232D1F4:
	.word 0x023305D4	; 0232D1F4

; Returns the first persistent runtime-state slot address.
; 返回第一个常驻运行时状态槽的地址。
.func P1_GetRuntimeStateSlot0
	ldr r0,[pool_0232D1FC]	; 0232D1F8
	bx lr	; 0232D1FA
pool_0232D1FC:
loc_0232D1FC:
	.word 0x02357150	; 0232D1FC
.endfunc

; Returns the second persistent runtime-state slot address.
; 返回第二个常驻运行时状态槽的地址。
.func P1_GetRuntimeStateSlot1
	ldr r0,[pool_0232D204]	; 0232D200
	bx lr	; 0232D202
pool_0232D204:
loc_0232D204:
	.word 0x02357154	; 0232D204
.endfunc

; ===== function loc_0232D208 =====
loc_0232D208:
	stmia r0!,{r1}	; 0232D208
	mov r1,#0x0	; 0232D20A
	str r2,[r0,#0x8]	; 0232D20C
	mov r2,#0x0	; 0232D20E
	stmia r0!,{r1,r2}	; 0232D210
	bx lr	; 0232D212

; ===== function loc_0232D214 =====
loc_0232D214:
	str r2,[r0,#0x0]	; 0232D214
	str r1,[r0,#0x4]	; 0232D216
	neg r1,r1	; 0232D218
	str r1,[r0,#0x8]	; 0232D21A
	str r2,[r0,#0xc]	; 0232D21C
	bx lr	; 0232D21E

; ===== function loc_0232D220 =====
loc_0232D220:
	push {r4,r5,r6,r7,lr}	; 0232D220
	sub sp,#0x54	; 0232D222
	add r6,r0,#0x0	; 0232D224
	add r5,r1,#0x0	; 0232D226
	add r7,r2,#0x0	; 0232D228
	cmp r7,r5	; 0232D22A
	bne loc_0232D232	; 0232D22C
	add r4,sp,#0x40	; 0232D22E
	b loc_0232D234	; 0232D230
loc_0232D232:
	add r4,r7,#0x0	; 0232D232
loc_0232D234:
	ldr r0,[r6,#0x0]	; 0232D234
	str r0,[sp,#0x10]	; 0232D236
	ldr r0,[r6,#0x4]	; 0232D238
	str r0,[sp,#0x14]	; 0232D23A
	asr r0,r0,#0x1f	; 0232D23C
	str r0,[sp,#0x18]	; 0232D23E
	ldr r0,[sp,#0x10]	; 0232D240
	asr r0,r0,#0x1f	; 0232D242
	str r0,[sp,#0x1c]	; 0232D244
	ldr r0,[sp,#0x10]	; 0232D246
	ldr r1,[sp,#0x1c]	; 0232D248
	ldr r2,[r5,#0x0]	; 0232D24A
	asr r3,r2,#0x1f	; 0232D24C
	blx P1_AeabiLmul	; 0232D24E
	str r0,[sp,#0x20]	; 0232D252
	str r1,[sp,#0xc]	; 0232D254
	ldr r0,[sp,#0x14]	; 0232D256
	ldr r1,[sp,#0x18]	; 0232D258
	ldr r2,[r5,#0x8]	; 0232D25A
	asr r3,r2,#0x1f	; 0232D25C
	blx P1_AeabiLmul	; 0232D25E
	ldr r2,[sp,#0x20]	; 0232D262
	add r0,r2,r0	; 0232D264
	ldr r2,[sp,#0xc]	; 0232D266
	adc r2,r1	; 0232D268
	str r2,[sp,#0xc]	; 0232D26A
	lsl r1,r2,#0x14	; 0232D26C
	lsr r0,r0,#0xc	; 0232D26E
	orr r0,r1	; 0232D270
	str r0,[r4,#0x0]	; 0232D272
	ldr r0,[sp,#0x10]	; 0232D274
	ldr r1,[sp,#0x1c]	; 0232D276
	ldr r2,[r5,#0x4]	; 0232D278
	asr r3,r2,#0x1f	; 0232D27A
	blx P1_AeabiLmul	; 0232D27C
	str r0,[sp,#0x24]	; 0232D280
	str r1,[sp,#0x4]	; 0232D282
	ldr r0,[sp,#0x14]	; 0232D284
	ldr r1,[sp,#0x18]	; 0232D286
	ldr r2,[r5,#0xc]	; 0232D288
	asr r3,r2,#0x1f	; 0232D28A
	blx P1_AeabiLmul	; 0232D28C
	ldr r2,[sp,#0x24]	; 0232D290
	add r0,r2,r0	; 0232D292
	ldr r2,[sp,#0x4]	; 0232D294
	adc r2,r1	; 0232D296
	str r2,[sp,#0x4]	; 0232D298
	lsl r1,r2,#0x14	; 0232D29A
	lsr r0,r0,#0xc	; 0232D29C
	orr r0,r1	; 0232D29E
	str r0,[r4,#0x4]	; 0232D2A0
	ldr r0,[r6,#0xc]	; 0232D2A2
	str r0,[sp,#0x28]	; 0232D2A4
	asr r0,r0,#0x1f	; 0232D2A6
	str r0,[sp,#0x2c]	; 0232D2A8
	ldr r0,[r6,#0x8]	; 0232D2AA
	str r0,[sp,#0x30]	; 0232D2AC
	asr r0,r0,#0x1f	; 0232D2AE
	str r0,[sp,#0x34]	; 0232D2B0
	ldr r0,[sp,#0x30]	; 0232D2B2
	ldr r1,[sp,#0x34]	; 0232D2B4
	ldr r2,[r5,#0x0]	; 0232D2B6
	asr r3,r2,#0x1f	; 0232D2B8
	blx P1_AeabiLmul	; 0232D2BA
	str r0,[sp,#0x38]	; 0232D2BE
	add r6,r1,#0x0	; 0232D2C0
	ldr r0,[sp,#0x28]	; 0232D2C2
	ldr r1,[sp,#0x2c]	; 0232D2C4
	ldr r2,[r5,#0x8]	; 0232D2C6
	asr r3,r2,#0x1f	; 0232D2C8
	blx P1_AeabiLmul	; 0232D2CA
	ldr r2,[sp,#0x38]	; 0232D2CE
	add r2,r2,r0	; 0232D2D0
	adc r6,r1	; 0232D2D2
	lsl r0,r6,#0x14	; 0232D2D4
	lsr r1,r2,#0xc	; 0232D2D6
	orr r1,r0	; 0232D2D8
	str r1,[r4,#0x8]	; 0232D2DA
	ldr r0,[sp,#0x30]	; 0232D2DC
	ldr r1,[sp,#0x34]	; 0232D2DE
	ldr r2,[r5,#0x4]	; 0232D2E0
	asr r3,r2,#0x1f	; 0232D2E2
	blx P1_AeabiLmul	; 0232D2E4
	str r0,[sp,#0x3c]	; 0232D2E8
	add r6,r1,#0x0	; 0232D2EA
	ldr r0,[sp,#0x28]	; 0232D2EC
	ldr r1,[sp,#0x2c]	; 0232D2EE
	ldr r2,[r5,#0xc]	; 0232D2F0
	asr r3,r2,#0x1f	; 0232D2F2
	blx P1_AeabiLmul	; 0232D2F4
	ldr r2,[sp,#0x3c]	; 0232D2F8
	add r2,r2,r0	; 0232D2FA
	adc r6,r1	; 0232D2FC
	lsl r0,r6,#0x14	; 0232D2FE
	lsr r1,r2,#0xc	; 0232D300
	orr r1,r0	; 0232D302
	str r1,[r4,#0xc]	; 0232D304
	add r2,sp,#0x40	; 0232D306
	cmp r4,r2	; 0232D308
	bne loc_0232D314	; 0232D30A
	ldmia r2!,{r0,r1}	; 0232D30C
	stmia r7!,{r0,r1}	; 0232D30E
	ldmia r2!,{r0,r1}	; 0232D310
	stmia r7!,{r0,r1}	; 0232D312
loc_0232D314:
	add sp,#0x54	; 0232D314
	pop {r4,r5,r6,r7}	; 0232D316
	pop {r3}	; 0232D318
	bx r3	; 0232D31A

; ARM9 硬件 32÷32；r0 ÷ r1，轮询完成后返回商。
; ARM9 hardware 32-by-32 division; r0 / r1, waits and returns quotient.
.func P1_Divide32By32
loc_0232D31C:
	push {r4}	; 0232D31C
	sub sp,#0x4	; 0232D31E
	mov r4,#0x0	; 0232D320
	ldr r3,[pool_0232D344]	; 0232D322
	strh r4,[r3,#0x0]	; 0232D324
	ldr r2,[pool_0232D348]	; 0232D326
	str r0,[r2,#0x0]	; 0232D328
	ldr r0,[pool_0232D34C]	; 0232D32A
	str r1,[r0,#0x0]	; 0232D32C
	str r4,[r0,#0x4]	; 0232D32E
	ldr r0,[pool_0232D350]	; 0232D330
loc_0232D332:
	ldrh r1,[r3,#0x0]	; 0232D332
	and r1,r0	; 0232D334
	cmp r1,#0x0	; 0232D336
	bne loc_0232D332	; 0232D338
	ldr r0,[pool_0232D354]	; 0232D33A
	ldr r0,[r0,#0x0]	; 0232D33C
	add sp,#0x4	; 0232D33E
	pop {r4}	; 0232D340
	bx lr	; 0232D342
.endfunc
pool_0232D344:
loc_0232D344:
	.word REG_DIVCNT	; 0232D344
pool_0232D348:
loc_0232D348:
	.word REG_DIV_NUMER	; 0232D348
pool_0232D34C:
loc_0232D34C:
	.word REG_DIV_DENOM	; 0232D34C
pool_0232D350:
loc_0232D350:
	.word 0x00008000	; 0232D350
pool_0232D354:
loc_0232D354:
	.word REG_DIV_RESULT	; 0232D354

; 启动硬件 64÷32 的固定小数倒数计算；由配对读取函数完成结果转换。
; Starts 64-by-32 fixed-point reciprocal division; paired reader converts result.
.func P1_StartFixedPointReciprocalDivide
loc_0232D358:
	mov r2,#0x1	; 0232D358
	ldr r1,[pool_0232D370]	; 0232D35A
	strh r2,[r1,#0x0]	; 0232D35C
	mov r3,#0x0	; 0232D35E
	ldr r2,[pool_0232D374]	; 0232D360
	ldr r1,[pool_0232D378]	; 0232D362
	str r3,[r1,#0x0]	; 0232D364
	str r2,[r1,#0x4]	; 0232D366
	ldr r1,[pool_0232D37C]	; 0232D368
	str r0,[r1,#0x0]	; 0232D36A
	str r3,[r1,#0x4]	; 0232D36C
	bx lr	; 0232D36E
.endfunc
pool_0232D370:
loc_0232D370:
	.word REG_DIVCNT	; 0232D370
pool_0232D374:
loc_0232D374:
	.word 0x00001000	; 0232D374
pool_0232D378:
loc_0232D378:
	.word REG_DIV_NUMER	; 0232D378
pool_0232D37C:
loc_0232D37C:
	.word REG_DIV_DENOM	; 0232D37C

; 等待固定小数除法完成，并把 64 位商归一化为固件使用的格式。
; Waits for fixed-point division and normalises its 64-bit quotient for firmware use.
.func P1_FinishFixedPointReciprocalDivide
loc_0232D380:
	ldr r1,[pool_0232D3A4]	; 0232D380
	ldr r0,[pool_0232D3A8]	; 0232D382
loc_0232D384:
	ldrh r2,[r1,#0x0]	; 0232D384
	and r2,r0	; 0232D386
	cmp r2,#0x0	; 0232D388
	bne loc_0232D384	; 0232D38A
	ldr r0,[pool_0232D3AC]	; 0232D38C
	ldr r2,[r0,#0x0]	; 0232D38E
	ldr r3,[r0,#0x4]	; 0232D390
	mov r1,#0x0	; 0232D392
	ldr r0,[pool_0232D3B0]	; 0232D394
	add r0,r2,r0	; 0232D396
	adc r3,r1	; 0232D398
	lsl r1,r3,#0xc	; 0232D39A
	lsr r0,r0,#0x14	; 0232D39C
	orr r0,r1	; 0232D39E
	bx lr	; 0232D3A0
.endfunc
	.byte 0xC0, 0x46	; 0232D3A4
pool_0232D3A4:
loc_0232D3A4:
	.word REG_DIVCNT	; 0232D3A4
pool_0232D3A8:
loc_0232D3A8:
	.word 0x00008000	; 0232D3A8
pool_0232D3AC:
loc_0232D3AC:
	.word REG_DIV_RESULT	; 0232D3AC
pool_0232D3B0:
loc_0232D3B0:
	.word 0x00080000	; 0232D3B0

; 固定小数倒数辅助函数：依次启动并读取 ARM9 硬件除法器。
; Fixed-point reciprocal helper: starts then reads the ARM9 hardware divider.
.func P1_ComputeFixedPointReciprocal
loc_0232D3B4:
	push {lr}	; 0232D3B4
	sub sp,#0x4	; 0232D3B6
	bl P1_StartFixedPointReciprocalDivide	; 0232D3B8
	bl P1_FinishFixedPointReciprocalDivide	; 0232D3BC
	add sp,#0x4	; 0232D3C0
	pop {r3}	; 0232D3C2
	bx r3	; 0232D3C4
.endfunc
	.byte 0x00, 0x00	; 0232D3C8
.arm

; ===== function loc_0232D3C8 =====
loc_0232D3C8:
	smull r2,r1,r0,r1	; 0232D3C8
	mov r0,#0x800	; 0232D3CC
	adds r0,r2,r0	; 0232D3D0
	adc r1,r1,#0x0	; 0232D3D4
	mov r0,r0, lsr #0xc	; 0232D3D8
	orr r0,r0,r1, lsl #0x14	; 0232D3DC
	bx lr	; 0232D3E0
.thumb

; ===== function loc_0232D3E4 =====
loc_0232D3E4:
	cmp r1,#0x0	; 0232D3E4
	bne loc_0232D3EE	; 0232D3E6
	mov r1,#0x0	; 0232D3E8
	strh r1,[r0,#0x0]	; 0232D3EA
	bx lr	; 0232D3EC
loc_0232D3EE:
	cmp r1,#0x0	; 0232D3EE
	ble loc_0232D3FA	; 0232D3F0
	ldr r2,[pool_0232D404]	; 0232D3F2
	orr r1,r2	; 0232D3F4
	strh r1,[r0,#0x0]	; 0232D3F6
	bx lr	; 0232D3F8
loc_0232D3FA:
	neg r2,r1	; 0232D3FA
	ldr r1,[pool_0232D408]	; 0232D3FC
	orr r2,r1	; 0232D3FE
	strh r2,[r0,#0x0]	; 0232D400
	bx lr	; 0232D402
pool_0232D404:
loc_0232D404:
	.word 0x00004000	; 0232D404
pool_0232D408:
loc_0232D408:
	.word 0x00008000	; 0232D408

; ===== function loc_0232D40C =====
loc_0232D40C:
	ldr r2,[pool_0232D41C]	; 0232D40C
	ldr r3,[r2,#0x0]	; 0232D40E
	mov r1,#0x7	; 0232D410
	bic r3,r1	; 0232D412
	orr r3,r0	; 0232D414
	str r3,[r2,#0x0]	; 0232D416
	bx lr	; 0232D418
	.byte 0xC0, 0x46	; 0232D41C
pool_0232D41C:
loc_0232D41C:
	.word REG_DISPCNT_B	; 0232D41C

; ===== function loc_0232D420 =====
loc_0232D420:
	push {r4}	; 0232D420
	sub sp,#0x4	; 0232D422
	ldr r3,[pool_0232D45C]	; 0232D424
	ldr r3,[r3,#0x0]	; 0232D426
	ldr r4,[pool_0232D460]	; 0232D428
	strh r0,[r4,#0x0]	; 0232D42A
	ldr r4,[pool_0232D464]	; 0232D42C
	ldrh r4,[r4,#0x0]	; 0232D42E
	cmp r4,#0x0	; 0232D430
	bne loc_0232D436	; 0232D432
	mov r0,#0x0	; 0232D434
loc_0232D436:
	lsl r4,r2,#0x3	; 0232D436
	ldr r2,[pool_0232D468]	; 0232D438
	and r3,r2	; 0232D43A
	lsl r0,r0,#0x10	; 0232D43C
	orr r3,r0	; 0232D43E
	orr r1,r3	; 0232D440
	orr r4,r1	; 0232D442
	ldr r0,[pool_0232D45C]	; 0232D444
	str r4,[r0,#0x0]	; 0232D446
	ldr r0,[pool_0232D460]	; 0232D448
	ldrh r0,[r0,#0x0]	; 0232D44A
	cmp r0,#0x0	; 0232D44C
	bne loc_0232D456	; 0232D44E
	mov r1,#0x0	; 0232D450
	ldr r0,[pool_0232D464]	; 0232D452
	strh r1,[r0,#0x0]	; 0232D454
loc_0232D456:
	add sp,#0x4	; 0232D456
	pop {r4}	; 0232D458
	bx lr	; 0232D45A
pool_0232D45C:
loc_0232D45C:
	.word REG_DISPCNT_A	; 0232D45C
pool_0232D460:
loc_0232D460:
	.word P1_BssStart + 0x266AC	; 0232D460
pool_0232D464:
loc_0232D464:
	.word P1_Data_02330A9C	; 0232D464
pool_0232D468:
loc_0232D468:
	.word 0xFFF0FFF0	; 0232D468

; ===== function loc_0232D46C =====
loc_0232D46C:
	mov r1,#0x1	; 0232D46C
	ldr r0,[pool_0232D498]	; 0232D46E
	strh r1,[r0,#0x0]	; 0232D470
	ldr r0,[pool_0232D49C]	; 0232D472
	ldrh r3,[r0,#0x0]	; 0232D474
	cmp r3,#0x0	; 0232D476
	beq loc_0232D48A	; 0232D478
	ldr r1,[pool_0232D4A0]	; 0232D47A
	ldr r2,[r1,#0x0]	; 0232D47C
	ldr r0,[pool_0232D4A4]	; 0232D47E
	and r2,r0	; 0232D480
	lsl r0,r3,#0x10	; 0232D482
	orr r2,r0	; 0232D484
	str r2,[r1,#0x0]	; 0232D486
	bx lr	; 0232D488
loc_0232D48A:
	ldr r1,[pool_0232D4A0]	; 0232D48A
	ldr r2,[r1,#0x0]	; 0232D48C
	ldr r0,[pool_0232D4A8]	; 0232D48E
	orr r2,r0	; 0232D490
	str r2,[r1,#0x0]	; 0232D492
	bx lr	; 0232D494
	.byte 0xC0, 0x46	; 0232D498
pool_0232D498:
loc_0232D498:
	.word P1_Data_02330A9C	; 0232D498
pool_0232D49C:
loc_0232D49C:
	.word P1_BssStart + 0x266AC	; 0232D49C
pool_0232D4A0:
loc_0232D4A0:
	.word REG_DISPCNT_A	; 0232D4A0
pool_0232D4A4:
loc_0232D4A4:
	.word 0xFFFCFFFF	; 0232D4A4
pool_0232D4A8:
loc_0232D4A8:
	.word 0x00010000	; 0232D4A8

; ===== function loc_0232D4AC =====
loc_0232D4AC:
	ldr r1,[pool_0232D4CC]	; 0232D4AC
	ldr r0,[r1,#0x0]	; 0232D4AE
	mov r3,#0x0	; 0232D4B0
	ldr r2,[pool_0232D4D0]	; 0232D4B2
	strh r3,[r2,#0x0]	; 0232D4B4
	ldr r2,[pool_0232D4D4]	; 0232D4B6
	add r3,r0,#0x0	; 0232D4B8
	and r3,r2	; 0232D4BA
	lsr r3,r3,#0x10	; 0232D4BC
	ldr r2,[pool_0232D4D8]	; 0232D4BE
	strh r3,[r2,#0x0]	; 0232D4C0
	ldr r2,[pool_0232D4DC]	; 0232D4C2
	and r0,r2	; 0232D4C4
	str r0,[r1,#0x0]	; 0232D4C6
	bx lr	; 0232D4C8
	.byte 0xC0, 0x46	; 0232D4CC
pool_0232D4CC:
loc_0232D4CC:
	.word REG_DISPCNT_A	; 0232D4CC
pool_0232D4D0:
loc_0232D4D0:
	.word P1_Data_02330A9C	; 0232D4D0
pool_0232D4D4:
loc_0232D4D4:
	.word 0x00030000	; 0232D4D4
pool_0232D4D8:
loc_0232D4D8:
	.word P1_BssStart + 0x266AC	; 0232D4D8
pool_0232D4DC:
loc_0232D4DC:
	.word 0xFFFCFFFF	; 0232D4DC

; ===== function loc_0232D4E0 =====
loc_0232D4E0:
	ldr r2,[pool_0232D500]	; 0232D4E0
	ldrh r3,[r2,#0x0]	; 0232D4E2
	mov r1,#0x8	; 0232D4E4
	and r3,r1	; 0232D4E6
	cmp r0,#0x0	; 0232D4E8
	beq loc_0232D4F4	; 0232D4EA
	ldrh r0,[r2,#0x0]	; 0232D4EC
	orr r0,r1	; 0232D4EE
	strh r0,[r2,#0x0]	; 0232D4F0
	b loc_0232D4FA	; 0232D4F2
loc_0232D4F4:
	ldrh r0,[r2,#0x0]	; 0232D4F4
	bic r0,r1	; 0232D4F6
	strh r0,[r2,#0x0]	; 0232D4F8
loc_0232D4FA:
	add r0,r3,#0x0	; 0232D4FA
	bx lr	; 0232D4FC
	.byte 0xC0, 0x46	; 0232D500
pool_0232D500:
loc_0232D500:
	.word REG_DISPSTAT	; 0232D500

; ===== function loc_0232D504 =====
loc_0232D504:
	push {lr}	; 0232D504
	sub sp,#0xc	; 0232D506
	ldr r0,[pool_0232D57C]	; 0232D508
	ldrh r2,[r0,#0x0]	; 0232D50A
	ldr r1,[pool_0232D580]	; 0232D50C
	orr r2,r1	; 0232D50E
	strh r2,[r0,#0x0]	; 0232D510
	ldrh r2,[r0,#0x0]	; 0232D512
	ldr r1,[pool_0232D584]	; 0232D514
	and r2,r1	; 0232D516
	ldr r1,[pool_0232D588]	; 0232D518
	orr r2,r1	; 0232D51A
	strh r2,[r0,#0x0]	; 0232D51C
	ldrh r2,[r0,#0x0]	; 0232D51E
	mov r1,#0x1	; 0232D520
	orr r2,r1	; 0232D522
	strh r2,[r0,#0x0]	; 0232D524
	bl loc_0232D5C4	; 0232D526
	mov r1,#0x0	; 0232D52A
	ldr r0,[pool_0232D58C]	; 0232D52C
	strh r1,[r0,#0x0]	; 0232D52E
	ldr r0,[pool_0232D590]	; 0232D530
	str r1,[r0,#0x0]	; 0232D532
	str r1,[sp,#0x0]	; 0232D534
	ldr r0,[sp,#0x0]	; 0232D536
	ldr r1,[pool_0232D594]	; 0232D538
	mov r2,#0x60	; 0232D53A
	blx loc_0232DE3C	; 0232D53C
	mov r1,#0x0	; 0232D540
	ldr r0,[pool_0232D598]	; 0232D542
	strh r1,[r0,#0x0]	; 0232D544
	str r1,[sp,#0x4]	; 0232D546
	ldr r0,[sp,#0x4]	; 0232D548
	ldr r1,[pool_0232D59C]	; 0232D54A
	mov r2,#0x70	; 0232D54C
	blx loc_0232DE3C	; 0232D54E
	ldr r0,[pool_0232D5A0]	; 0232D552
	ldr r1,[pool_0232D5A4]	; 0232D554
	strh r0,[r1,#0x0]	; 0232D556
	ldr r1,[pool_0232D5A8]	; 0232D558
	strh r0,[r1,#0x0]	; 0232D55A
	ldr r1,[pool_0232D5AC]	; 0232D55C
	strh r0,[r1,#0x0]	; 0232D55E
	ldr r1,[pool_0232D5B0]	; 0232D560
	strh r0,[r1,#0x0]	; 0232D562
	ldr r1,[pool_0232D5B4]	; 0232D564
	strh r0,[r1,#0x0]	; 0232D566
	ldr r1,[pool_0232D5B8]	; 0232D568
	strh r0,[r1,#0x0]	; 0232D56A
	ldr r1,[pool_0232D5BC]	; 0232D56C
	strh r0,[r1,#0x0]	; 0232D56E
	ldr r1,[pool_0232D5C0]	; 0232D570
	strh r0,[r1,#0x0]	; 0232D572
	add sp,#0xc	; 0232D574
	pop {r3}	; 0232D576
	bx r3	; 0232D578
	.byte 0xC0, 0x46	; 0232D57C
pool_0232D57C:
loc_0232D57C:
	.word REG_POWERCNT	; 0232D57C
pool_0232D580:
loc_0232D580:
	.word 0x00008000	; 0232D580
pool_0232D584:
loc_0232D584:
	.word 0xFFFFFDF1	; 0232D584
pool_0232D588:
loc_0232D588:
	.word 0x0000020E	; 0232D588
pool_0232D58C:
loc_0232D58C:
	.word REG_DISPSTAT	; 0232D58C
pool_0232D590:
loc_0232D590:
	.word REG_DISPCNT_A	; 0232D590
pool_0232D594:
loc_0232D594:
	.word REG_BG0CNT	; 0232D594
pool_0232D598:
loc_0232D598:
	.word REG_MASTER_BRIGHT	; 0232D598
pool_0232D59C:
loc_0232D59C:
	.word REG_DISPCNT_B	; 0232D59C
pool_0232D5A0:
loc_0232D5A0:
	.word 0x00000100	; 0232D5A0
pool_0232D5A4:
loc_0232D5A4:
	.word REG_BG2PA	; 0232D5A4
pool_0232D5A8:
loc_0232D5A8:
	.word REG_BG2PD	; 0232D5A8
pool_0232D5AC:
loc_0232D5AC:
	.word REG_BG3PA	; 0232D5AC
pool_0232D5B0:
loc_0232D5B0:
	.word REG_BG3PD	; 0232D5B0
pool_0232D5B4:
loc_0232D5B4:
	.word REG_BG2PA_SUB	; 0232D5B4
pool_0232D5B8:
loc_0232D5B8:
	.word REG_BG2PD_SUB	; 0232D5B8
pool_0232D5BC:
loc_0232D5BC:
	.word REG_BG3PA_SUB	; 0232D5BC
pool_0232D5C0:
loc_0232D5C0:
	.word REG_BG3PD_SUB	; 0232D5C0

; ===== function loc_0232D5C4 =====
loc_0232D5C4:
	mov r1,#0x0	; 0232D5C4
	ldr r0,[pool_0232D5F8]	; 0232D5C6
	strh r1,[r0,#0x0]	; 0232D5C8
	strh r1,[r0,#0x2]	; 0232D5CA
	strh r1,[r0,#0x4]	; 0232D5CC
	strh r1,[r0,#0x6]	; 0232D5CE
	strh r1,[r0,#0x8]	; 0232D5D0
	strh r1,[r0,#0xa]	; 0232D5D2
	strh r1,[r0,#0xc]	; 0232D5D4
	strh r1,[r0,#0xe]	; 0232D5D6
	strh r1,[r0,#0x10]	; 0232D5D8
	strh r1,[r0,#0x12]	; 0232D5DA
	strh r1,[r0,#0x14]	; 0232D5DC
	strh r1,[r0,#0x16]	; 0232D5DE
	strh r1,[r0,#0x18]	; 0232D5E0
	ldr r0,[pool_0232D5FC]	; 0232D5E2
	str r1,[r0,#0x0]	; 0232D5E4
	ldr r0,[pool_0232D600]	; 0232D5E6
	strb r1,[r0,#0x0]	; 0232D5E8
	ldr r0,[pool_0232D604]	; 0232D5EA
	strb r1,[r0,#0x0]	; 0232D5EC
	ldr r0,[pool_0232D608]	; 0232D5EE
	strb r1,[r0,#0x0]	; 0232D5F0
	ldr r0,[pool_0232D60C]	; 0232D5F2
	strh r1,[r0,#0x0]	; 0232D5F4
	bx lr	; 0232D5F6
pool_0232D5F8:
loc_0232D5F8:
	.word P1_BssStart + 0x266B0	; 0232D5F8
pool_0232D5FC:
loc_0232D5FC:
	.word VRAM_A_CR	; 0232D5FC
pool_0232D600:
loc_0232D600:
	.word VRAM_E_CR	; 0232D600
pool_0232D604:
loc_0232D604:
	.word VRAM_F_CR	; 0232D604
pool_0232D608:
loc_0232D608:
	.word VRAM_G_CR	; 0232D608
pool_0232D60C:
loc_0232D60C:
	.word VRAM_H_CR	; 0232D60C

; ===== function loc_0232D610 =====
loc_0232D610:
	ldr r0,[pool_0232D618]	; 0232D610
	ldr r3,[pool_0232D61C]	; 0232D612
	bx r3	; 0232D614
	.byte 0xC0, 0x46	; 0232D618
pool_0232D618:
loc_0232D618:
	.word 0x02357184	; 0232D618
pool_0232D61C:
loc_0232D61C:
	.word loc_0232D670 + 1	; 0232D61C

; ===== function loc_0232D620 =====
loc_0232D620:
	ldr r0,[pool_0232D628]	; 0232D620
	ldr r3,[pool_0232D62C]	; 0232D622
	bx r3	; 0232D624
	.byte 0xC0, 0x46	; 0232D628
pool_0232D628:
loc_0232D628:
	.word 0x02357182	; 0232D628
pool_0232D62C:
loc_0232D62C:
	.word loc_0232D670 + 1	; 0232D62C

; ===== function loc_0232D630 =====
loc_0232D630:
	ldr r0,[pool_0232D638]	; 0232D630
	ldr r3,[pool_0232D63C]	; 0232D632
	bx r3	; 0232D634
	.byte 0xC0, 0x46	; 0232D638
pool_0232D638:
loc_0232D638:
	.word 0x02357170	; 0232D638
pool_0232D63C:
loc_0232D63C:
	.word loc_0232D670 + 1	; 0232D63C

; ===== function loc_0232D640 =====
loc_0232D640:
	ldr r0,[pool_0232D648]	; 0232D640
	ldr r3,[pool_0232D64C]	; 0232D642
	bx r3	; 0232D644
	.byte 0xC0, 0x46	; 0232D648
pool_0232D648:
loc_0232D648:
	.word 0x02357176	; 0232D648
pool_0232D64C:
loc_0232D64C:
	.word loc_0232D670 + 1	; 0232D64C

; ===== function loc_0232D650 =====
loc_0232D650:
	ldr r0,[pool_0232D658]	; 0232D650
	ldr r3,[pool_0232D65C]	; 0232D652
	bx r3	; 0232D654
	.byte 0xC0, 0x46	; 0232D658
pool_0232D658:
loc_0232D658:
	.word 0x02357174	; 0232D658
pool_0232D65C:
loc_0232D65C:
	.word loc_0232D670 + 1	; 0232D65C

; ===== function loc_0232D660 =====
loc_0232D660:
	ldr r0,[pool_0232D668]	; 0232D660
	ldr r3,[pool_0232D66C]	; 0232D662
	bx r3	; 0232D664
	.byte 0xC0, 0x46	; 0232D668
pool_0232D668:
loc_0232D668:
	.word 0x02357172	; 0232D668
pool_0232D66C:
loc_0232D66C:
	.word loc_0232D670 + 1	; 0232D66C
loc_0232D670:
	ldrh r1,[r0,#0x0]	; 0232D670
	mov r3,#0x0	; 0232D672
	strh r3,[r0,#0x0]	; 0232D674
	mov r0,#0x1	; 0232D676
	add r2,r1,#0x0	; 0232D678
	and r2,r0	; 0232D67A
	cmp r2,#0x0	; 0232D67C
	beq loc_0232D684	; 0232D67E
	ldr r0,[pool_0232D708]	; 0232D680
	strb r3,[r0,#0x0]	; 0232D682
loc_0232D684:
	mov r0,#0x2	; 0232D684
	add r2,r1,#0x0	; 0232D686
	and r2,r0	; 0232D688
	cmp r2,#0x0	; 0232D68A
	beq loc_0232D694	; 0232D68C
	mov r2,#0x0	; 0232D68E
	ldr r0,[pool_0232D70C]	; 0232D690
	strb r2,[r0,#0x0]	; 0232D692
loc_0232D694:
	mov r0,#0x4	; 0232D694
	add r2,r1,#0x0	; 0232D696
	and r2,r0	; 0232D698
	cmp r2,#0x0	; 0232D69A
	beq loc_0232D6A4	; 0232D69C
	mov r2,#0x0	; 0232D69E
	ldr r0,[pool_0232D710]	; 0232D6A0
	strb r2,[r0,#0x0]	; 0232D6A2
loc_0232D6A4:
	mov r0,#0x8	; 0232D6A4
	add r2,r1,#0x0	; 0232D6A6
	and r2,r0	; 0232D6A8
	cmp r2,#0x0	; 0232D6AA
	beq loc_0232D6B4	; 0232D6AC
	mov r2,#0x0	; 0232D6AE
	ldr r0,[pool_0232D714]	; 0232D6B0
	strb r2,[r0,#0x0]	; 0232D6B2
loc_0232D6B4:
	mov r0,#0x10	; 0232D6B4
	add r2,r1,#0x0	; 0232D6B6
	and r2,r0	; 0232D6B8
	cmp r2,#0x0	; 0232D6BA
	beq loc_0232D6C4	; 0232D6BC
	mov r2,#0x0	; 0232D6BE
	ldr r0,[pool_0232D718]	; 0232D6C0
	strb r2,[r0,#0x0]	; 0232D6C2
loc_0232D6C4:
	mov r0,#0x20	; 0232D6C4
	add r2,r1,#0x0	; 0232D6C6
	and r2,r0	; 0232D6C8
	cmp r2,#0x0	; 0232D6CA
	beq loc_0232D6D4	; 0232D6CC
	mov r2,#0x0	; 0232D6CE
	ldr r0,[pool_0232D71C]	; 0232D6D0
	strb r2,[r0,#0x0]	; 0232D6D2
loc_0232D6D4:
	mov r0,#0x40	; 0232D6D4
	add r2,r1,#0x0	; 0232D6D6
	and r2,r0	; 0232D6D8
	cmp r2,#0x0	; 0232D6DA
	beq loc_0232D6E4	; 0232D6DC
	mov r2,#0x0	; 0232D6DE
	ldr r0,[pool_0232D720]	; 0232D6E0
	strb r2,[r0,#0x0]	; 0232D6E2
loc_0232D6E4:
	mov r0,#0x80	; 0232D6E4
	add r2,r1,#0x0	; 0232D6E6
	and r2,r0	; 0232D6E8
	cmp r2,#0x0	; 0232D6EA
	beq loc_0232D6F4	; 0232D6EC
	mov r2,#0x0	; 0232D6EE
	ldr r0,[pool_0232D724]	; 0232D6F0
	strb r2,[r0,#0x0]	; 0232D6F2
loc_0232D6F4:
	ldr r0,[pool_0232D728]	; 0232D6F4
	add r2,r1,#0x0	; 0232D6F6
	and r2,r0	; 0232D6F8
	cmp r2,#0x0	; 0232D6FA
	beq loc_0232D704	; 0232D6FC
	mov r2,#0x0	; 0232D6FE
	ldr r0,[pool_0232D72C]	; 0232D700
	strb r2,[r0,#0x0]	; 0232D702
loc_0232D704:
	add r0,r1,#0x0	; 0232D704
	bx lr	; 0232D706
pool_0232D708:
loc_0232D708:
	.word VRAM_A_CR	; 0232D708
pool_0232D70C:
loc_0232D70C:
	.word VRAM_B_CR	; 0232D70C
pool_0232D710:
loc_0232D710:
	.word VRAM_C_CR	; 0232D710
pool_0232D714:
loc_0232D714:
	.word VRAM_D_CR	; 0232D714
pool_0232D718:
loc_0232D718:
	.word VRAM_E_CR	; 0232D718
pool_0232D71C:
loc_0232D71C:
	.word VRAM_F_CR	; 0232D71C
pool_0232D720:
loc_0232D720:
	.word VRAM_G_CR	; 0232D720
pool_0232D724:
loc_0232D724:
	.word VRAM_H_CR	; 0232D724
pool_0232D728:
loc_0232D728:
	.word 0x00000100	; 0232D728
pool_0232D72C:
loc_0232D72C:
	.word VRAM_I_CR	; 0232D72C

; ===== function loc_0232D730 =====
loc_0232D730:
	ldr r1,[pool_0232D73C]	; 0232D730
	ldrh r2,[r1,#0x0]	; 0232D732
	orr r2,r0	; 0232D734
	strh r2,[r1,#0x0]	; 0232D736
	ldr r3,[pool_0232D740]	; 0232D738
	bx r3	; 0232D73A
pool_0232D73C:
loc_0232D73C:
	.word P1_BssStart + 0x266B0	; 0232D73C
pool_0232D740:
loc_0232D740:
	.word loc_0232D744 + 1	; 0232D740

; ===== function loc_0232D744 =====
loc_0232D744:
	mov r1,#0x1	; 0232D744
	add r2,r0,#0x0	; 0232D746
	and r2,r1	; 0232D748
	cmp r2,#0x0	; 0232D74A
	beq loc_0232D754	; 0232D74C
	mov r2,#0x80	; 0232D74E
	ldr r1,[pool_0232D7D4]	; 0232D750
	strb r2,[r1,#0x0]	; 0232D752
loc_0232D754:
	mov r1,#0x2	; 0232D754
	add r2,r0,#0x0	; 0232D756
	and r2,r1	; 0232D758
	cmp r2,#0x0	; 0232D75A
	beq loc_0232D764	; 0232D75C
	mov r2,#0x80	; 0232D75E
	ldr r1,[pool_0232D7D8]	; 0232D760
	strb r2,[r1,#0x0]	; 0232D762
loc_0232D764:
	mov r1,#0x4	; 0232D764
	add r2,r0,#0x0	; 0232D766
	and r2,r1	; 0232D768
	cmp r2,#0x0	; 0232D76A
	beq loc_0232D774	; 0232D76C
	mov r2,#0x80	; 0232D76E
	ldr r1,[pool_0232D7DC]	; 0232D770
	strb r2,[r1,#0x0]	; 0232D772
loc_0232D774:
	mov r1,#0x8	; 0232D774
	add r2,r0,#0x0	; 0232D776
	and r2,r1	; 0232D778
	cmp r2,#0x0	; 0232D77A
	beq loc_0232D784	; 0232D77C
	mov r2,#0x80	; 0232D77E
	ldr r1,[pool_0232D7E0]	; 0232D780
	strb r2,[r1,#0x0]	; 0232D782
loc_0232D784:
	mov r1,#0x10	; 0232D784
	add r2,r0,#0x0	; 0232D786
	and r2,r1	; 0232D788
	cmp r2,#0x0	; 0232D78A
	beq loc_0232D794	; 0232D78C
	mov r2,#0x80	; 0232D78E
	ldr r1,[pool_0232D7E4]	; 0232D790
	strb r2,[r1,#0x0]	; 0232D792
loc_0232D794:
	mov r1,#0x20	; 0232D794
	add r2,r0,#0x0	; 0232D796
	and r2,r1	; 0232D798
	cmp r2,#0x0	; 0232D79A
	beq loc_0232D7A4	; 0232D79C
	mov r2,#0x80	; 0232D79E
	ldr r1,[pool_0232D7E8]	; 0232D7A0
	strb r2,[r1,#0x0]	; 0232D7A2
loc_0232D7A4:
	mov r1,#0x40	; 0232D7A4
	add r2,r0,#0x0	; 0232D7A6
	and r2,r1	; 0232D7A8
	cmp r2,#0x0	; 0232D7AA
	beq loc_0232D7B4	; 0232D7AC
	mov r2,#0x80	; 0232D7AE
	ldr r1,[pool_0232D7EC]	; 0232D7B0
	strb r2,[r1,#0x0]	; 0232D7B2
loc_0232D7B4:
	mov r2,#0x80	; 0232D7B4
	add r1,r0,#0x0	; 0232D7B6
	and r1,r2	; 0232D7B8
	cmp r1,#0x0	; 0232D7BA
	beq loc_0232D7C2	; 0232D7BC
	ldr r1,[pool_0232D7F0]	; 0232D7BE
	strb r2,[r1,#0x0]	; 0232D7C0
loc_0232D7C2:
	ldr r1,[pool_0232D7F4]	; 0232D7C2
	and r0,r1	; 0232D7C4
	cmp r0,#0x0	; 0232D7C6
	beq loc_0232D7D0	; 0232D7C8
	mov r1,#0x80	; 0232D7CA
	ldr r0,[pool_0232D7F8]	; 0232D7CC
	strb r1,[r0,#0x0]	; 0232D7CE
loc_0232D7D0:
	bx lr	; 0232D7D0
	.byte 0xC0, 0x46	; 0232D7D4
pool_0232D7D4:
loc_0232D7D4:
	.word VRAM_A_CR	; 0232D7D4
pool_0232D7D8:
loc_0232D7D8:
	.word VRAM_B_CR	; 0232D7D8
pool_0232D7DC:
loc_0232D7DC:
	.word VRAM_C_CR	; 0232D7DC
pool_0232D7E0:
loc_0232D7E0:
	.word VRAM_D_CR	; 0232D7E0
pool_0232D7E4:
loc_0232D7E4:
	.word VRAM_E_CR	; 0232D7E4
pool_0232D7E8:
loc_0232D7E8:
	.word VRAM_F_CR	; 0232D7E8
pool_0232D7EC:
loc_0232D7EC:
	.word VRAM_G_CR	; 0232D7EC
pool_0232D7F0:
loc_0232D7F0:
	.word VRAM_H_CR	; 0232D7F0
pool_0232D7F4:
loc_0232D7F4:
	.word 0x00000100	; 0232D7F4
pool_0232D7F8:
loc_0232D7F8:
	.word VRAM_I_CR	; 0232D7F8

; ===== function loc_0232D7FC =====
; Returns the sub-engine BG1 character-base address.
; 返回副引擎 BG1 字符基址。
.func P1_GetSubBg1CharacterBase
loc_0232D7FC:
	ldr r0,[pool_0232D810]	; 0232D7FC
	ldrh r1,[r0,#0x0]	; 0232D7FE
	mov r0,#0x3c	; 0232D800
	and r1,r0	; 0232D802
	asr r0,r1,#0x2	; 0232D804
	lsl r1,r0,#0xe	; 0232D806
	ldr r0,[pool_0232D814]	; 0232D808
	add r0,r1,r0	; 0232D80A
	bx lr	; 0232D80C
.endfunc
	.byte 0xC0, 0x46	; 0232D810
pool_0232D810:
loc_0232D810:
	.word REG_BG1CNT_SUB	; 0232D810
pool_0232D814:
loc_0232D814:
	.word 0x06200000	; 0232D814

; ===== function loc_0232D818 =====
; Returns the main-engine BG1 character-base address.
; 返回主引擎 BG1 字符基址。
.func P1_GetMainBg1CharacterBase
loc_0232D818:
	ldr r0,[pool_0232D838]	; 0232D818
	ldrh r1,[r0,#0x0]	; 0232D81A
	mov r0,#0x3c	; 0232D81C
	and r1,r0	; 0232D81E
	asr r0,r1,#0x2	; 0232D820
	lsl r2,r0,#0xe	; 0232D822
	ldr r0,[pool_0232D83C]	; 0232D824
	ldr r1,[r0,#0x0]	; 0232D826
	ldr r0,[pool_0232D840]	; 0232D828
	and r1,r0	; 0232D82A
	lsr r0,r1,#0x18	; 0232D82C
	lsl r1,r0,#0x10	; 0232D82E
	ldr r0,[pool_0232D844]	; 0232D830
	add r0,r1,r0	; 0232D832
	add r0,r2,r0	; 0232D834
	bx lr	; 0232D836
.endfunc
pool_0232D838:
loc_0232D838:
	.word REG_BG1CNT	; 0232D838
pool_0232D83C:
loc_0232D83C:
	.word REG_DISPCNT_A	; 0232D83C
pool_0232D840:
loc_0232D840:
	.word 0x07000000	; 0232D840
pool_0232D844:
loc_0232D844:
	.word 0x06000000	; 0232D844

; ===== function loc_0232D848 =====
; Returns the sub-engine BG0 character-base address.
; 返回副引擎 BG0 字符基址。
.func P1_GetSubBg0CharacterBase
loc_0232D848:
	ldr r0,[pool_0232D85C]	; 0232D848
	ldrh r1,[r0,#0x0]	; 0232D84A
	mov r0,#0x3c	; 0232D84C
	and r1,r0	; 0232D84E
	asr r0,r1,#0x2	; 0232D850
	lsl r1,r0,#0xe	; 0232D852
	ldr r0,[pool_0232D860]	; 0232D854
	add r0,r1,r0	; 0232D856
	bx lr	; 0232D858
.endfunc
	.byte 0xC0, 0x46	; 0232D85C
pool_0232D85C:
loc_0232D85C:
	.word REG_BG0CNT_SUB	; 0232D85C
pool_0232D860:
loc_0232D860:
	.word 0x06200000	; 0232D860
; ===== function loc_0232D874 =====
; Returns the main-engine BG0 character-base address.
; 返回主引擎 BG0 字符基址。
.func P1_GetMainBg0CharacterBase
loc_0232D874:
	ldr r0,[pool_0232D894]	; 0232D874
	ldrh r1,[r0,#0x0]	; 0232D876
	mov r0,#0x3c	; 0232D878
	and r1,r0	; 0232D87A
	asr r0,r1,#0x2	; 0232D87C
	lsl r2,r0,#0xe	; 0232D87E
	ldr r0,[pool_0232D898]	; 0232D880
	ldr r1,[r0,#0x0]	; 0232D882
	ldr r0,[pool_0232D89C]	; 0232D884
	and r1,r0	; 0232D886
	lsr r0,r1,#0x18	; 0232D888
	lsl r1,r0,#0x10	; 0232D88A
	ldr r0,[pool_0232D8A0]	; 0232D88C
	add r0,r1,r0	; 0232D88E
	add r0,r2,r0	; 0232D890
	bx lr	; 0232D892
.endfunc
pool_0232D894:
	.word REG_BG0CNT	; 0232D894
pool_0232D898:
	.word REG_DISPCNT_A	; 0232D898
pool_0232D89C:
	.word 0x07000000	; 0232D89C
pool_0232D8A0:
	.word 0x06000000	; 0232D8A0

; ===== function loc_0232D894 =====
; Returns the sub-engine BG1 tilemap base from BG1CNT.
; 由 BG1CNT 返回副引擎 BG1 tilemap 基址。
.func P1_GetSubBg1TilemapBase
loc_0232D894:
	ldr r0,[pool_0232D8A8]	; 0232D894
	ldrh r1,[r0,#0x0]	; 0232D896
	ldr r0,[pool_0232D8AC]	; 0232D898
	and r1,r0	; 0232D89A
	asr r0,r1,#0x8	; 0232D89C
	lsl r1,r0,#0xb	; 0232D89E
	ldr r0,[pool_0232D8B0]	; 0232D8A0
	add r0,r1,r0	; 0232D8A2
	bx lr	; 0232D8A4
.endfunc
	.byte 0xC0, 0x46	; 0232D8A8
pool_0232D8A8:
loc_0232D8A8:
	.word REG_BG1CNT_SUB	; 0232D8A8
pool_0232D8AC:
loc_0232D8AC:
	.word 0x00001F00	; 0232D8AC
pool_0232D8B0:
loc_0232D8B0:
	.word 0x06200000	; 0232D8B0

; ===== function loc_0232D8B4 =====
; Returns the main-engine BG1 tilemap base from BG1CNT and VRAM bank mode.
; 由 BG1CNT 与 VRAM bank 模式返回主引擎 BG1 tilemap 基址。
.func P1_GetMainBg1TilemapBase
loc_0232D8B4:
	ldr r0,[pool_0232D8D4]	; 0232D8B4
	ldrh r1,[r0,#0x0]	; 0232D8B6
	ldr r0,[pool_0232D8D8]	; 0232D8B8
	and r1,r0	; 0232D8BA
	asr r0,r1,#0x8	; 0232D8BC
	lsl r2,r0,#0xb	; 0232D8BE
	ldr r0,[pool_0232D8DC]	; 0232D8C0
	ldr r1,[r0,#0x0]	; 0232D8C2
	ldr r0,[pool_0232D8E0]	; 0232D8C4
	and r1,r0	; 0232D8C6
	lsr r0,r1,#0x1b	; 0232D8C8
	lsl r1,r0,#0x10	; 0232D8CA
	ldr r0,[pool_0232D8E4]	; 0232D8CC
	add r0,r1,r0	; 0232D8CE
	add r0,r2,r0	; 0232D8D0
	bx lr	; 0232D8D2
.endfunc
pool_0232D8D4:
loc_0232D8D4:
	.word REG_BG1CNT	; 0232D8D4
pool_0232D8D8:
loc_0232D8D8:
	.word 0x00001F00	; 0232D8D8
pool_0232D8DC:
loc_0232D8DC:
	.word REG_DISPCNT_A	; 0232D8DC
pool_0232D8E0:
loc_0232D8E0:
	.word 0x38000000	; 0232D8E0
pool_0232D8E4:
loc_0232D8E4:
	.word 0x06000000	; 0232D8E4

; ===== function loc_0232D8E8 =====
; Returns the sub-engine BG0 tilemap base from BG0CNT.
; 由 BG0CNT 返回副引擎 BG0 tilemap 基址。
.func P1_GetSubBg0TilemapBase
loc_0232D8E8:
	ldr r0,[pool_0232D8FC]	; 0232D8E8
	ldrh r1,[r0,#0x0]	; 0232D8EA
	ldr r0,[pool_0232D900]	; 0232D8EC
	and r1,r0	; 0232D8EE
	asr r0,r1,#0x8	; 0232D8F0
	lsl r1,r0,#0xb	; 0232D8F2
	ldr r0,[pool_0232D904]	; 0232D8F4
	add r0,r1,r0	; 0232D8F6
	bx lr	; 0232D8F8
.endfunc
	.byte 0xC0, 0x46	; 0232D8FC
pool_0232D8FC:
loc_0232D8FC:
	.word REG_BG0CNT_SUB	; 0232D8FC
pool_0232D900:
loc_0232D900:
	.word 0x00001F00	; 0232D900
pool_0232D904:
loc_0232D904:
	.word 0x06200000	; 0232D904

; ===== function loc_0232D908 =====
; Returns the main-engine BG0 tilemap base from BG0CNT and VRAM bank mode.
; 由 BG0CNT 与 VRAM bank 模式返回主引擎 BG0 tilemap 基址。
.func P1_GetMainBg0TilemapBase
loc_0232D908:
	ldr r0,[pool_0232D928]	; 0232D908
	ldrh r1,[r0,#0x0]	; 0232D90A
	ldr r0,[pool_0232D92C]	; 0232D90C
	and r1,r0	; 0232D90E
	asr r0,r1,#0x8	; 0232D910
	lsl r2,r0,#0xb	; 0232D912
	ldr r0,[pool_0232D930]	; 0232D914
	ldr r1,[r0,#0x0]	; 0232D916
	ldr r0,[pool_0232D934]	; 0232D918
	and r1,r0	; 0232D91A
	lsr r0,r1,#0x1b	; 0232D91C
	lsl r1,r0,#0x10	; 0232D91E
	ldr r0,[pool_0232D938]	; 0232D920
	add r0,r1,r0	; 0232D922
	add r0,r2,r0	; 0232D924
	bx lr	; 0232D926
.endfunc
pool_0232D928:
loc_0232D928:
	.word REG_BG0CNT	; 0232D928
pool_0232D92C:
loc_0232D92C:
	.word 0x00001F00	; 0232D92C
pool_0232D930:
loc_0232D930:
	.word REG_DISPCNT_A	; 0232D930
pool_0232D934:
loc_0232D934:
	.word 0x38000000	; 0232D934
pool_0232D938:
loc_0232D938:
	.word 0x06000000	; 0232D938

; ===== function loc_0232D93C =====
loc_0232D93C:
	cmp r2,#0x0	; 0232D93C
	bge loc_0232D94C	; 0232D93E
	mov r3,#0xc0	; 0232D940
	orr r1,r3	; 0232D942
	strh r1,[r0,#0x0]	; 0232D944
	neg r1,r2	; 0232D946
	strh r1,[r0,#0x4]	; 0232D948
	bx lr	; 0232D94A
loc_0232D94C:
	mov r3,#0x80	; 0232D94C
	orr r1,r3	; 0232D94E
	strh r1,[r0,#0x0]	; 0232D950
	strh r2,[r0,#0x4]	; 0232D952
	bx lr	; 0232D954
	.byte 0x00, 0x00	; 0232D958

; ===== function loc_0232D958 =====
loc_0232D958:
	push {r4}	; 0232D958
	sub sp,#0x4	; 0232D95A
	mov r4,#0x40	; 0232D95C
	orr r1,r4	; 0232D95E
	lsl r2,r2,#0x8	; 0232D960
	orr r1,r2	; 0232D962
	ldr r2,[sp,#0x8]	; 0232D964
	lsl r2,r2,#0x8	; 0232D966
	orr r3,r2	; 0232D968
	lsl r2,r3,#0x10	; 0232D96A
	orr r1,r2	; 0232D96C
	str r1,[r0,#0x0]	; 0232D96E
	add sp,#0x4	; 0232D970
	pop {r4}	; 0232D972
	bx lr	; 0232D974
	.byte 0x00, 0x00	; 0232D978

; ===== function loc_0232D978 =====
P1_Entry_0232D978:
	push {r4,r5,r6,lr}	; 0232D978
	add r5,r0,#0x0	; 0232D97A
	add r4,r1,#0x0	; 0232D97C
	add r6,r2,#0x0	; 0232D97E
	bl loc_02326B84	; 0232D980
	add r2,r0,#0x0	; 0232D984
	ldr r0,[pool_0232D99C]	; 0232D986
	ldr r0,[r0,#0x0]	; 0232D988
	add r1,r5,#0x0	; 0232D98A
	add r2,r2,r4	; 0232D98C
	add r3,r6,#0x0	; 0232D98E
	bl loc_0232DDC4	; 0232D990
	pop {r4,r5,r6}	; 0232D994
	pop {r3}	; 0232D996
	bx r3	; 0232D998
	.byte 0xC0, 0x46	; 0232D99C
pool_0232D99C:
loc_0232D99C:
	.word P1_Data_02330AA0	; 0232D99C

; ===== function loc_0232D9A0 =====
P1_Entry_0232D9A0:
	push {r4,r5,r6,lr}	; 0232D9A0
	add r5,r0,#0x0	; 0232D9A2
	add r4,r1,#0x0	; 0232D9A4
	add r6,r2,#0x0	; 0232D9A6
	bl loc_02326BA0	; 0232D9A8
	add r2,r0,#0x0	; 0232D9AC
	ldr r0,[pool_0232D9C4]	; 0232D9AE
	ldr r0,[r0,#0x0]	; 0232D9B0
	add r1,r5,#0x0	; 0232D9B2
	add r2,r2,r4	; 0232D9B4
	add r3,r6,#0x0	; 0232D9B6
	bl loc_0232DDC4	; 0232D9B8
	pop {r4,r5,r6}	; 0232D9BC
	pop {r3}	; 0232D9BE
	bx r3	; 0232D9C0
	.byte 0xC0, 0x46	; 0232D9C4
pool_0232D9C4:
loc_0232D9C4:
	.word P1_Data_02330AA0	; 0232D9C4
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xF9, 0xF7, 0xFE, 0xF8, 0x02, 0x1C, 0x05, 0x48	; 0232D9D8
	.byte 0x00, 0x68, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C, 0x00, 0xF0, 0xF0, 0xF9, 0x70, 0xBC, 0x08, 0xBC	; 0232D9E8
	.byte 0x18, 0x47, 0xC0, 0x46, 0xA0, 0x0A, 0x33, 0x02	; 0232D9F0

; ===== function loc_0232D9F0 =====
loc_0232D9F0:
	push {r4,r5,r6,lr}	; 0232D9F0
	add r5,r0,#0x0	; 0232D9F2
	add r4,r1,#0x0	; 0232D9F4
	add r6,r2,#0x0	; 0232D9F6
	bl loc_02326BEC	; 0232D9F8
	add r2,r0,#0x0	; 0232D9FC
	ldr r0,[pool_0232DA14]	; 0232D9FE
	ldr r0,[r0,#0x0]	; 0232DA00
	add r1,r5,#0x0	; 0232DA02
	add r2,r2,r4	; 0232DA04
	add r3,r6,#0x0	; 0232DA06
	bl loc_0232DDC4	; 0232DA08
	pop {r4,r5,r6}	; 0232DA0C
	pop {r3}	; 0232DA0E
	bx r3	; 0232DA10
	.byte 0xC0, 0x46	; 0232DA14
pool_0232DA14:
loc_0232DA14:
	.word P1_Data_02330AA0	; 0232DA14

; ===== function loc_0232DA18 =====
loc_0232DA18:
	push {r4,r5,r6,lr}	; 0232DA18
	add r5,r0,#0x0	; 0232DA1A
	add r4,r1,#0x0	; 0232DA1C
	add r6,r2,#0x0	; 0232DA1E
	bl P1_GetSubBg1CharacterBase	; 0232DA20
	add r2,r0,#0x0	; 0232DA24
	ldr r0,[pool_0232DA3C]	; 0232DA26
	ldr r0,[r0,#0x0]	; 0232DA28
	add r1,r5,#0x0	; 0232DA2A
	add r2,r2,r4	; 0232DA2C
	add r3,r6,#0x0	; 0232DA2E
	bl loc_0232DDC4	; 0232DA30
	pop {r4,r5,r6}	; 0232DA34
	pop {r3}	; 0232DA36
	bx r3	; 0232DA38
	.byte 0xC0, 0x46	; 0232DA3C
pool_0232DA3C:
loc_0232DA3C:
	.word P1_Data_02330AA0	; 0232DA3C

; ===== function loc_0232DA40 =====
loc_0232DA40:
	push {r4,r5,r6,lr}	; 0232DA40
	add r5,r0,#0x0	; 0232DA42
	add r4,r1,#0x0	; 0232DA44
	add r6,r2,#0x0	; 0232DA46
	bl P1_GetMainBg1CharacterBase	; 0232DA48
	add r2,r0,#0x0	; 0232DA4C
	ldr r0,[pool_0232DA64]	; 0232DA4E
	ldr r0,[r0,#0x0]	; 0232DA50
	add r1,r5,#0x0	; 0232DA52
	add r2,r2,r4	; 0232DA54
	add r3,r6,#0x0	; 0232DA56
	bl loc_0232DDC4	; 0232DA58
	pop {r4,r5,r6}	; 0232DA5C
	pop {r3}	; 0232DA5E
	bx r3	; 0232DA60
	.byte 0xC0, 0x46	; 0232DA64
pool_0232DA64:
loc_0232DA64:
	.word P1_Data_02330AA0	; 0232DA64

; ===== function loc_0232DA68 =====
	push {r4,r5,r6,lr}	; 0232DA68
	add r5,r0,#0x0	; 0232DA6A
	add r4,r1,#0x0	; 0232DA6C
	add r6,r2,#0x0	; 0232DA6E
	bl P1_GetSubBg0CharacterBase	; 0232DA70
	add r2,r0,#0x0	; 0232DA74
	ldr r0,[pool_0232DA8C]	; 0232DA76
	ldr r0,[r0,#0x0]	; 0232DA78
	add r1,r5,#0x0	; 0232DA7A
	add r2,r2,r4	; 0232DA7C
	add r3,r6,#0x0	; 0232DA7E
	bl loc_0232DDC4	; 0232DA80
	pop {r4,r5,r6}	; 0232DA84
	pop {r3}	; 0232DA86
	bx r3	; 0232DA88
	.byte 0xC0, 0x46	; 0232DA8C
pool_0232DA8C:
loc_0232DA8C:
	.word P1_Data_02330AA0	; 0232DA8C
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xFF, 0xF7, 0xE4, 0xFE, 0x02, 0x1C, 0x05, 0x48	; 0232DAA0
	.byte 0x00, 0x68, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C, 0x00, 0xF0, 0x8C, 0xF9, 0x70, 0xBC, 0x08, 0xBC	; 0232DAB0
	.byte 0x18, 0x47, 0xC0, 0x46, 0xA0, 0x0A, 0x33, 0x02	; 0232DAB8

; ===== function loc_0232DAB8 =====
loc_0232DAB8:
	push {r4,r5,r6,lr}	; 0232DAB8
	add r5,r0,#0x0	; 0232DABA
	add r4,r1,#0x0	; 0232DABC
	add r6,r2,#0x0	; 0232DABE
	bl loc_02326C1C	; 0232DAC0
	add r2,r0,#0x0	; 0232DAC4
	ldr r0,[pool_0232DADC]	; 0232DAC6
	ldr r0,[r0,#0x0]	; 0232DAC8
	add r1,r5,#0x0	; 0232DACA
	add r2,r2,r4	; 0232DACC
	add r3,r6,#0x0	; 0232DACE
	bl loc_0232DD84	; 0232DAD0
	pop {r4,r5,r6}	; 0232DAD4
	pop {r3}	; 0232DAD6
	bx r3	; 0232DAD8
	.byte 0xC0, 0x46	; 0232DADC
pool_0232DADC:
loc_0232DADC:
	.word P1_Data_02330AA0	; 0232DADC

; ===== function loc_0232DAE0 =====
loc_0232DAE0:
	push {r4,r5,r6,lr}	; 0232DAE0
	add r5,r0,#0x0	; 0232DAE2
	add r4,r1,#0x0	; 0232DAE4
	add r6,r2,#0x0	; 0232DAE6
	blx P1_GetMainBg3TilemapAddress	; 0232DAE8
	add r2,r0,#0x0	; 0232DAEC
	ldr r0,[pool_0232DB04]	; 0232DAEE
	ldr r0,[r0,#0x0]	; 0232DAF0
	add r1,r5,#0x0	; 0232DAF2
	add r2,r2,r4	; 0232DAF4
	add r3,r6,#0x0	; 0232DAF6
	bl loc_0232DD84	; 0232DAF8
	pop {r4,r5,r6}	; 0232DAFC
	pop {r3}	; 0232DAFE
	bx r3	; 0232DB00
	.byte 0xC0, 0x46	; 0232DB04
pool_0232DB04:
loc_0232DB04:
	.word P1_Data_02330AA0	; 0232DB04

; ===== function loc_0232DB08 =====
loc_0232DB08:
	push {r4,r5,r6,lr}	; 0232DB08
	add r5,r0,#0x0	; 0232DB0A
	add r4,r1,#0x0	; 0232DB0C
	add r6,r2,#0x0	; 0232DB0E
	bl loc_02326C70	; 0232DB10
	add r2,r0,#0x0	; 0232DB14
	ldr r0,[pool_0232DB2C]	; 0232DB16
	ldr r0,[r0,#0x0]	; 0232DB18
	add r1,r5,#0x0	; 0232DB1A
	add r2,r2,r4	; 0232DB1C
	add r3,r6,#0x0	; 0232DB1E
	bl loc_0232DD84	; 0232DB20
	pop {r4,r5,r6}	; 0232DB24
	pop {r3}	; 0232DB26
	bx r3	; 0232DB28
	.byte 0xC0, 0x46	; 0232DB2C
pool_0232DB2C:
loc_0232DB2C:
	.word P1_Data_02330AA0	; 0232DB2C

; ===== function loc_0232DB30 =====
loc_0232DB30:
	push {r4,r5,r6,lr}	; 0232DB30
	add r5,r0,#0x0	; 0232DB32
	add r4,r1,#0x0	; 0232DB34
	add r6,r2,#0x0	; 0232DB36
	blx P1_GetMainBg2TilemapAddress	; 0232DB38
	add r2,r0,#0x0	; 0232DB3C
	ldr r0,[pool_0232DB54]	; 0232DB3E
	ldr r0,[r0,#0x0]	; 0232DB40
	add r1,r5,#0x0	; 0232DB42
	add r2,r2,r4	; 0232DB44
	add r3,r6,#0x0	; 0232DB46
	bl loc_0232DD84	; 0232DB48
	pop {r4,r5,r6}	; 0232DB4C
	pop {r3}	; 0232DB4E
	bx r3	; 0232DB50
	.byte 0xC0, 0x46	; 0232DB54
pool_0232DB54:
loc_0232DB54:
	.word P1_Data_02330AA0	; 0232DB54

; ===== function loc_0232DB58 =====
loc_0232DB58:
	push {r4,r5,r6,lr}	; 0232DB58
	add r5,r0,#0x0	; 0232DB5A
	add r4,r1,#0x0	; 0232DB5C
	add r6,r2,#0x0	; 0232DB5E
	bl P1_GetSubBg1TilemapBase	; 0232DB60
	add r2,r0,#0x0	; 0232DB64
	ldr r0,[pool_0232DB7C]	; 0232DB66
	ldr r0,[r0,#0x0]	; 0232DB68
	add r1,r5,#0x0	; 0232DB6A
	add r2,r2,r4	; 0232DB6C
	add r3,r6,#0x0	; 0232DB6E
	bl loc_0232DD84	; 0232DB70
	pop {r4,r5,r6}	; 0232DB74
	pop {r3}	; 0232DB76
	bx r3	; 0232DB78
	.byte 0xC0, 0x46	; 0232DB7C
pool_0232DB7C:
loc_0232DB7C:
	.word P1_Data_02330AA0	; 0232DB7C

; ===== function loc_0232DB80 =====
loc_0232DB80:
	push {r4,r5,r6,lr}	; 0232DB80
	add r5,r0,#0x0	; 0232DB82
	add r4,r1,#0x0	; 0232DB84
	add r6,r2,#0x0	; 0232DB86
	bl P1_GetMainBg1TilemapBase	; 0232DB88
	add r2,r0,#0x0	; 0232DB8C
	ldr r0,[pool_0232DBA4]	; 0232DB8E
	ldr r0,[r0,#0x0]	; 0232DB90
	add r1,r5,#0x0	; 0232DB92
	add r2,r2,r4	; 0232DB94
	add r3,r6,#0x0	; 0232DB96
	bl loc_0232DD84	; 0232DB98
	pop {r4,r5,r6}	; 0232DB9C
	pop {r3}	; 0232DB9E
	bx r3	; 0232DBA0
	.byte 0xC0, 0x46	; 0232DBA4
pool_0232DBA4:
loc_0232DBA4:
	.word P1_Data_02330AA0	; 0232DBA4

; ===== function loc_0232DBA8 =====
loc_0232DBA8:
	push {r4,r5,r6,lr}	; 0232DBA8
	add r5,r0,#0x0	; 0232DBAA
	add r4,r1,#0x0	; 0232DBAC
	add r6,r2,#0x0	; 0232DBAE
	bl P1_GetSubBg0TilemapBase	; 0232DBB0
	add r2,r0,#0x0	; 0232DBB4
	ldr r0,[pool_0232DBCC]	; 0232DBB6
	ldr r0,[r0,#0x0]	; 0232DBB8
	add r1,r5,#0x0	; 0232DBBA
	add r2,r2,r4	; 0232DBBC
	add r3,r6,#0x0	; 0232DBBE
	bl loc_0232DD84	; 0232DBC0
	pop {r4,r5,r6}	; 0232DBC4
	pop {r3}	; 0232DBC6
	bx r3	; 0232DBC8
	.byte 0xC0, 0x46	; 0232DBCC
pool_0232DBCC:
loc_0232DBCC:
	.word P1_Data_02330AA0	; 0232DBCC

; ===== function loc_0232DBD0 =====
	push {r4,r5,r6,lr}	; 0232DBD0
	add r5,r0,#0x0	; 0232DBD2
	add r4,r1,#0x0	; 0232DBD4
	add r6,r2,#0x0	; 0232DBD6
	bl P1_GetMainBg0TilemapBase	; 0232DBD8
	add r2,r0,#0x0	; 0232DBDC
	ldr r0,[pool_0232DBF4]	; 0232DBDE
	ldr r0,[r0,#0x0]	; 0232DBE0
	add r1,r5,#0x0	; 0232DBE2
	add r2,r2,r4	; 0232DBE4
	add r3,r6,#0x0	; 0232DBE6
	bl loc_0232DD84	; 0232DBE8
	pop {r4,r5,r6}	; 0232DBEC
	pop {r3}	; 0232DBEE
	bx r3	; 0232DBF0
	.byte 0xC0, 0x46	; 0232DBF4
pool_0232DBF4:
loc_0232DBF4:
	.word P1_Data_02330AA0	; 0232DBF4

; ===== function loc_0232DBF8 =====
loc_0232DBF8:
	push {r4,r5,lr}	; 0232DBF8
	sub sp,#0x4	; 0232DBFA
	add r5,r0,#0x0	; 0232DBFC
	add r4,r1,#0x0	; 0232DBFE
	add r3,r2,#0x0	; 0232DC00
	ldr r0,[pool_0232DC18]	; 0232DC02
	ldr r0,[r0,#0x0]	; 0232DC04
	add r1,r5,#0x0	; 0232DC06
	ldr r2,[pool_0232DC1C]	; 0232DC08
	add r2,r4,r2	; 0232DC0A
	bl loc_0232DDC4	; 0232DC0C
	add sp,#0x4	; 0232DC10
	pop {r4,r5}	; 0232DC12
	pop {r3}	; 0232DC14
	bx r3	; 0232DC16
pool_0232DC18:
loc_0232DC18:
	.word P1_Data_02330AA0	; 0232DC18
pool_0232DC1C:
loc_0232DC1C:
	.word 0x06600000	; 0232DC1C

; ===== function loc_0232DC20 =====
loc_0232DC20:
	push {r4,r5,lr}	; 0232DC20
	sub sp,#0x4	; 0232DC22
	add r5,r0,#0x0	; 0232DC24
	add r4,r1,#0x0	; 0232DC26
	add r3,r2,#0x0	; 0232DC28
	ldr r0,[pool_0232DC40]	; 0232DC2A
	ldr r0,[r0,#0x0]	; 0232DC2C
	add r1,r5,#0x0	; 0232DC2E
	ldr r2,[pool_0232DC44]	; 0232DC30
	add r2,r4,r2	; 0232DC32
	bl loc_0232DDC4	; 0232DC34
	add sp,#0x4	; 0232DC38
	pop {r4,r5}	; 0232DC3A
	pop {r3}	; 0232DC3C
	bx r3	; 0232DC3E
pool_0232DC40:
loc_0232DC40:
	.word P1_Data_02330AA0	; 0232DC40
pool_0232DC44:
loc_0232DC44:
	.word 0x06400000	; 0232DC44

; ===== function loc_0232DC48 =====
loc_0232DC48:
	push {r4,r5,lr}	; 0232DC48
	sub sp,#0x4	; 0232DC4A
	add r5,r0,#0x0	; 0232DC4C
	add r4,r1,#0x0	; 0232DC4E
	add r3,r2,#0x0	; 0232DC50
	ldr r0,[pool_0232DC68]	; 0232DC52
	ldr r0,[r0,#0x0]	; 0232DC54
	add r1,r5,#0x0	; 0232DC56
	ldr r2,[pool_0232DC6C]	; 0232DC58
	add r2,r4,r2	; 0232DC5A
	bl loc_0232DDC4	; 0232DC5C
	add sp,#0x4	; 0232DC60
	pop {r4,r5}	; 0232DC62
	pop {r3}	; 0232DC64
	bx r3	; 0232DC66
pool_0232DC68:
loc_0232DC68:
	.word P1_Data_02330AA0	; 0232DC68
pool_0232DC6C:
loc_0232DC6C:
	.word 0x07000400	; 0232DC6C

; ===== function loc_0232DC70 =====
loc_0232DC70:
	push {r4,r5,lr}	; 0232DC70
	sub sp,#0x4	; 0232DC72
	add r5,r0,#0x0	; 0232DC74
	add r4,r1,#0x0	; 0232DC76
	add r3,r2,#0x0	; 0232DC78
	ldr r0,[pool_0232DC90]	; 0232DC7A
	ldr r0,[r0,#0x0]	; 0232DC7C
	add r1,r5,#0x0	; 0232DC7E
	ldr r2,[pool_0232DC94]	; 0232DC80
	add r2,r4,r2	; 0232DC82
	bl loc_0232DDC4	; 0232DC84
	add sp,#0x4	; 0232DC88
	pop {r4,r5}	; 0232DC8A
	pop {r3}	; 0232DC8C
	bx r3	; 0232DC8E
pool_0232DC90:
loc_0232DC90:
	.word P1_Data_02330AA0	; 0232DC90
pool_0232DC94:
loc_0232DC94:
	.word 0x07000000	; 0232DC94

; ===== function loc_0232DC98 =====
loc_0232DC98:
	push {r4,r5,lr}	; 0232DC98
	sub sp,#0x4	; 0232DC9A
	add r5,r0,#0x0	; 0232DC9C
	add r4,r1,#0x0	; 0232DC9E
	add r3,r2,#0x0	; 0232DCA0
	ldr r0,[pool_0232DCB8]	; 0232DCA2
	ldr r0,[r0,#0x0]	; 0232DCA4
	add r1,r5,#0x0	; 0232DCA6
	ldr r2,[pool_0232DCBC]	; 0232DCA8
	add r2,r4,r2	; 0232DCAA
	bl loc_0232DD84	; 0232DCAC
	add sp,#0x4	; 0232DCB0
	pop {r4,r5}	; 0232DCB2
	pop {r3}	; 0232DCB4
	bx r3	; 0232DCB6
pool_0232DCB8:
loc_0232DCB8:
	.word P1_Data_02330AA0	; 0232DCB8
pool_0232DCBC:
loc_0232DCBC:
	.word 0x05000600	; 0232DCBC

; ===== function loc_0232DCC0 =====
loc_0232DCC0:
	push {r4,r5,lr}	; 0232DCC0
	sub sp,#0x4	; 0232DCC2
	add r5,r0,#0x0	; 0232DCC4
	add r4,r1,#0x0	; 0232DCC6
	add r3,r2,#0x0	; 0232DCC8
	ldr r0,[pool_0232DCE0]	; 0232DCCA
	ldr r0,[r0,#0x0]	; 0232DCCC
	add r1,r5,#0x0	; 0232DCCE
	ldr r2,[pool_0232DCE4]	; 0232DCD0
	add r2,r4,r2	; 0232DCD2
	bl loc_0232DD84	; 0232DCD4
	add sp,#0x4	; 0232DCD8
	pop {r4,r5}	; 0232DCDA
	pop {r3}	; 0232DCDC
	bx r3	; 0232DCDE
pool_0232DCE0:
loc_0232DCE0:
	.word P1_Data_02330AA0	; 0232DCE0
pool_0232DCE4:
loc_0232DCE4:
	.word 0x05000200	; 0232DCE4

; ===== function loc_0232DCE8 =====
loc_0232DCE8:
	push {r4,r5,lr}	; 0232DCE8
	sub sp,#0x4	; 0232DCEA
	add r5,r0,#0x0	; 0232DCEC
	add r4,r1,#0x0	; 0232DCEE
	add r3,r2,#0x0	; 0232DCF0
	ldr r0,[pool_0232DD08]	; 0232DCF2
	ldr r0,[r0,#0x0]	; 0232DCF4
	add r1,r5,#0x0	; 0232DCF6
	ldr r2,[pool_0232DD0C]	; 0232DCF8
	add r2,r4,r2	; 0232DCFA
	bl loc_0232DD84	; 0232DCFC
	add sp,#0x4	; 0232DD00
	pop {r4,r5}	; 0232DD02
	pop {r3}	; 0232DD04
	bx r3	; 0232DD06
pool_0232DD08:
loc_0232DD08:
	.word P1_Data_02330AA0	; 0232DD08
pool_0232DD0C:
loc_0232DD0C:
	.word 0x05000400	; 0232DD0C

; ===== function loc_0232DD10 =====
loc_0232DD10:
	push {r4,r5,lr}	; 0232DD10
	sub sp,#0x4	; 0232DD12
	add r5,r0,#0x0	; 0232DD14
	add r4,r1,#0x0	; 0232DD16
	add r3,r2,#0x0	; 0232DD18
	ldr r0,[pool_0232DD30]	; 0232DD1A
	ldr r0,[r0,#0x0]	; 0232DD1C
	add r1,r5,#0x0	; 0232DD1E
	ldr r2,[pool_0232DD34]	; 0232DD20
	add r2,r4,r2	; 0232DD22
	bl loc_0232DD84	; 0232DD24
	add sp,#0x4	; 0232DD28
	pop {r4,r5}	; 0232DD2A
	pop {r3}	; 0232DD2C
	bx r3	; 0232DD2E
pool_0232DD30:
loc_0232DD30:
	.word P1_Data_02330AA0	; 0232DD30
pool_0232DD34:
loc_0232DD34:
	.word 0x05000000	; 0232DD34

; ===== function loc_0232DD38 =====
loc_0232DD38:
	ldr r1,[pool_0232DD40]	; 0232DD38
	strb r0,[r1,#0x0]	; 0232DD3A
	bx lr	; 0232DD3C
	.byte 0xC0, 0x46	; 0232DD40
pool_0232DD40:
loc_0232DD40:
	.word REG_WRAMCNT	; 0232DD40

; ===== function loc_0232DD44 =====
loc_0232DD44:
	push {r4,lr}	; 0232DD44
	add r4,r0,#0x0	; 0232DD46
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232DD48
	mov r1,#0x6	; 0232DD4C
	mul r4,r1	; 0232DD4E
	add r1,r4,#0x5	; 0232DD50
	lsl r2,r1,#0x1	; 0232DD52
	ldr r1,[pool_0232DD78]	; 0232DD54
	add r2,r2,r1	; 0232DD56
	ldrh r3,[r2,#0x0]	; 0232DD58
	ldr r1,[pool_0232DD7C]	; 0232DD5A
	and r3,r1	; 0232DD5C
	strh r3,[r2,#0x0]	; 0232DD5E
	ldrh r3,[r2,#0x0]	; 0232DD60
	ldr r1,[pool_0232DD80]	; 0232DD62
	and r3,r1	; 0232DD64
	strh r3,[r2,#0x0]	; 0232DD66
	ldrh r1,[r2,#0x0]	; 0232DD68
	ldrh r1,[r2,#0x0]	; 0232DD6A
	blx P1_Arm9RestoreIrqMask	; 0232DD6C
	pop {r4}	; 0232DD70
	pop {r3}	; 0232DD72
	bx r3	; 0232DD74
	.byte 0xC0, 0x46	; 0232DD78
pool_0232DD78:
loc_0232DD78:
	.word REG_DMA0SAD	; 0232DD78
pool_0232DD7C:
loc_0232DD7C:
	.word 0xFFFFC5FF	; 0232DD7C
pool_0232DD80:
loc_0232DD80:
	.word 0xFFFF7FFF	; 0232DD80

; ===== function loc_0232DD84 =====
loc_0232DD84:
	push {r4,r5,r6,lr}	; 0232DD84
	cmp r3,#0x0	; 0232DD86
	beq loc_0232DDB6	; 0232DD88
	mov r4,#0x3	; 0232DD8A
	add r5,r0,#0x0	; 0232DD8C
	mul r5,r4	; 0232DD8E
	add r4,r5,#0x2	; 0232DD90
	lsl r5,r4,#0x2	; 0232DD92
	ldr r4,[pool_0232DDBC]	; 0232DD94
	add r4,r5,r4	; 0232DD96
	ldr r5,[pool_0232DDC0]	; 0232DD98
loc_0232DD9A:
	ldr r6,[r4,#0x0]	; 0232DD9A
	and r6,r5	; 0232DD9C
	cmp r6,#0x0	; 0232DD9E
	bne loc_0232DD9A	; 0232DDA0
	lsr r3,r3,#0x1	; 0232DDA2
	ldr r5,[pool_0232DDC0]	; 0232DDA4
	orr r3,r5	; 0232DDA6
	bl P1_SetDmaChannelRegisters	; 0232DDA8
	lsl r0,r5,#0	; 0232DDAC
loc_0232DDAE:
	ldr r1,[r4,#0x0]	; 0232DDAE
	and r1,r0	; 0232DDB0
	cmp r1,#0x0	; 0232DDB2
	bne loc_0232DDAE	; 0232DDB4
loc_0232DDB6:
	pop {r4,r5,r6}	; 0232DDB6
	pop {r3}	; 0232DDB8
	bx r3	; 0232DDBA
pool_0232DDBC:
loc_0232DDBC:
	.word REG_DMA0SAD	; 0232DDBC
pool_0232DDC0:
loc_0232DDC0:
	.word 0x80000000	; 0232DDC0

; ===== function loc_0232DDC4 =====
loc_0232DDC4:
	push {r4,r5,r6,lr}	; 0232DDC4
	cmp r3,#0x0	; 0232DDC6
	beq loc_0232DDF6	; 0232DDC8
	mov r4,#0x3	; 0232DDCA
	add r5,r0,#0x0	; 0232DDCC
	mul r5,r4	; 0232DDCE
	add r4,r5,#0x2	; 0232DDD0
	lsl r5,r4,#0x2	; 0232DDD2
	ldr r4,[pool_0232DDFC]	; 0232DDD4
	add r4,r5,r4	; 0232DDD6
	ldr r5,[pool_0232DE00]	; 0232DDD8
loc_0232DDDA:
	ldr r6,[r4,#0x0]	; 0232DDDA
	and r6,r5	; 0232DDDC
	cmp r6,#0x0	; 0232DDDE
	bne loc_0232DDDA	; 0232DDE0
	lsr r3,r3,#0x2	; 0232DDE2
	ldr r5,[pool_0232DE04]	; 0232DDE4
	orr r3,r5	; 0232DDE6
	bl P1_SetDmaChannelRegisters	; 0232DDE8
	ldr r0,[pool_0232DE00]	; 0232DDEC
loc_0232DDEE:
	ldr r1,[r4,#0x0]	; 0232DDEE
	and r1,r0	; 0232DDF0
	cmp r1,#0x0	; 0232DDF2
	bne loc_0232DDEE	; 0232DDF4
loc_0232DDF6:
	pop {r4,r5,r6}	; 0232DDF6
	pop {r3}	; 0232DDF8
	bx r3	; 0232DDFA
pool_0232DDFC:
loc_0232DDFC:
	.word REG_DMA0SAD	; 0232DDFC
pool_0232DE00:
loc_0232DE00:
	.word 0x80000000	; 0232DE00
pool_0232DE04:
loc_0232DE04:
	.word 0x84000000	; 0232DE04
.arm

; ===== function loc_0232DE08 =====
loc_0232DE08:
	mov r3,#0x0	; 0232DE08
loc_0232DE0C:
	cmp r3,r2	; 0232DE0C
	strlth r0,[r1,r3]	; 0232DE10
	addlt r3,r3,#0x2	; 0232DE14
	blt loc_0232DE0C	; 0232DE18
	bx lr	; 0232DE1C

; ===== function loc_0232DE20 =====
loc_0232DE20:
	mov r12,#0x0	; 0232DE20
loc_0232DE24:
	cmp r12,r2	; 0232DE24
	ldrlth r3,[r0,r12]	; 0232DE28
	strlth r3,[r1,r12]	; 0232DE2C
	addlt r12,r12,#0x2	; 0232DE30
	blt loc_0232DE24	; 0232DE34
	bx lr	; 0232DE38

; ===== function loc_0232DE3C =====
; r0=填充值，r1=目标，r2=字节数；按 32 位字写入。
; r0=value, r1=destination, r2=byte count; fills in 32-bit words.
.func P1_MemFill32
loc_0232DE3C:
	add r12,r1,r2	; 0232DE3C
loc_0232DE40:
	cmp r1,r12	; 0232DE40
	stmltia r1!,{r0}	; 0232DE44
	blt loc_0232DE40	; 0232DE48
	bx lr	; 0232DE4C
.endfunc

; ===== function loc_0232DE50 =====
; r0=源，r1=目标，r2=字节数；按 32 位字复制。
; r0=source, r1=destination, r2=byte count; copies 32-bit words.
.func P1_MemCopy32
loc_0232DE50:
	add r12,r1,r2	; 0232DE50
loc_0232DE54:
	cmp r1,r12	; 0232DE54
	ldmltia r0!,{r2}	; 0232DE58
	stmltia r1!,{r2}	; 0232DE5C
	blt loc_0232DE54	; 0232DE60
	bx lr	; 0232DE64
.endfunc

; ===== function loc_0232DE68 =====
loc_0232DE68:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 0232DE68
	add r9,r1,r2	; 0232DE6C
	mov r12,r2, lsr #0x5	; 0232DE70
	add r12,r1,r12, lsl #0x5	; 0232DE74
	mov r2,r0	; 0232DE78
	mov r3,r2	; 0232DE7C
	mov r4,r2	; 0232DE80
	mov r5,r2	; 0232DE84
	mov r6,r2	; 0232DE88
	mov r7,r2	; 0232DE8C
	mov r8,r2	; 0232DE90
loc_0232DE94:
	cmp r1,r12	; 0232DE94
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 0232DE98
	blt loc_0232DE94	; 0232DE9C
loc_0232DEA0:
	cmp r1,r9	; 0232DEA0
	stmltia r1!,{r0}	; 0232DEA4
	blt loc_0232DEA0	; 0232DEA8
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 0232DEAC
	bx lr	; 0232DEB0

; ===== function loc_0232DEB4 =====
loc_0232DEB4:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232DEB4
	add r10,r1,r2	; 0232DEB8
	mov r12,r2, lsr #0x5	; 0232DEBC
	add r12,r1,r12, lsl #0x5	; 0232DEC0
loc_0232DEC4:
	cmp r1,r12	; 0232DEC4
	ldmltia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232DEC8
	stmltia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232DECC
	blt loc_0232DEC4	; 0232DED0
loc_0232DED4:
	cmp r1,r10	; 0232DED4
	ldmltia r0!,{r2}	; 0232DED8
	stmltia r1!,{r2}	; 0232DEDC
	blt loc_0232DED4	; 0232DEE0
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232DEE4
	bx lr	; 0232DEE8

; ===== function loc_0232DEEC =====
loc_0232DEEC:
	mov r12,#0x0	; 0232DEEC
loc_0232DEF0:
	cmp r12,r2	; 0232DEF0
	strltb r1,[r0,r12]	; 0232DEF4
	addlt r12,r12,#0x1	; 0232DEF8
	blt loc_0232DEF0	; 0232DEFC
	bx lr	; 0232DF00
P1_Entry_0232DF04:
	mov r12,#0x0	; 0232DF04
P1_Entry_0232DF08:
	cmp r12,r2	; 0232DF08
	ldrltb r3,[r0,r12]	; 0232DF0C
	strltb r3,[r1,r12]	; 0232DF10
	addlt r12,r12,#0x1	; 0232DF14
	blt P1_Entry_0232DF08	; 0232DF18
	bx lr	; 0232DF1C

; ===== function loc_0232DF20 =====
loc_0232DF20:
	swp r0,r0,[r1]	; 0232DF20
	bx lr	; 0232DF24
.thumb

; ===== function loc_0232DF28 =====
loc_0232DF28:
	push {lr}	; 0232DF28
	sub sp,#0x4	; 0232DF2A
	ldr r0,[pool_0232DF48]	; 0232DF2C
	ldr r1,[r0,#0x0]	; 0232DF2E
	cmp r1,#0x0	; 0232DF30
	bne loc_0232DF40	; 0232DF32
	mov r1,#0x1	; 0232DF34
	str r1,[r0,#0x0]	; 0232DF36
	bl loc_0232E55C	; 0232DF38
	bl loc_0232E680	; 0232DF3C
loc_0232DF40:
	add sp,#0x4	; 0232DF40
	pop {r3}	; 0232DF42
	bx r3	; 0232DF44
	.byte 0xC0, 0x46	; 0232DF48
pool_0232DF48:
loc_0232DF48:
	.word P1_BssStart + 0x266CC	; 0232DF48

; ===== function loc_0232DF4C =====
loc_0232DF4C:
	push {r4,r5,r6,r7,lr}	; 0232DF4C
	sub sp,#0x4	; 0232DF4E
	add r5,r0,#0x0	; 0232DF50
	add r4,r1,#0x0	; 0232DF52
	add r6,r2,#0x0	; 0232DF54
	add r7,r3,#0x0	; 0232DF56
	mov r0,#0x1	; 0232DF58
; 填充请求记录的命令与四个参数，并将其追加到待处理链。
; Fill a request record with a command and four arguments, then append it to the pending chain.
.func P1_QueueRequestRecord
	bl P1_AcquireRequestRecord	; 0232DF5A
	cmp r0,#0x0	; 0232DF5E
	beq loc_0232DF72	; 0232DF60
	str r5,[r0,#P1_RequestRecordCommandOffset]	; 0232DF62
	str r4,[r0,#P1_RequestRecordArgument0Offset]	; 0232DF64
	str r6,[r0,#P1_RequestRecordArgument1Offset]	; 0232DF66
	str r7,[r0,#P1_RequestRecordArgument2Offset]	; 0232DF68
	ldr r1,[sp,#0x18]	; 0232DF6A
	str r1,[r0,#P1_RequestRecordArgument3Offset]	; 0232DF6C
	bl P1_EnqueueRequestRecord	; 0232DF6E
loc_0232DF72:
	add sp,#0x4	; 0232DF72
	pop {r4,r5,r6,r7}	; 0232DF74
	pop {r3}	; 0232DF76
	bx r3	; 0232DF78
	.byte 0x00, 0x00	; 0232DF7C

; ===== function loc_0232DF7C =====
loc_0232DF7C:
	push {lr}	; 0232DF7C
	sub sp,#0x4	; 0232DF7E
	add r1,r0,#0x0	; 0232DF80
.endfunc
	mov r2,#0x0	; 0232DF82
	str r2,[sp,#0x0]	; 0232DF84
	mov r0,#0x13	; 0232DF86
	add r3,r2,#0x0	; 0232DF88
	bl P1_QueueRequestRecord	; 0232DF8A
	add sp,#0x4	; 0232DF8E
	pop {r3}	; 0232DF90
	bx r3	; 0232DF92

; ===== function loc_0232DF94 =====
loc_0232DF94:
	push {r4,r5,r6,lr}	; 0232DF94
	sub sp,#0x8	; 0232DF96
	add r6,r0,#0x0	; 0232DF98
	add r5,r1,#0x0	; 0232DF9A
	add r4,r2,#0x0	; 0232DF9C
	str r3,[sp,#0x0]	; 0232DF9E
	mov r0,#0x4	; 0232DFA0
	ldr r1,[sp,#0x18]	; 0232DFA2
	lsl r1,r1,#0x18	; 0232DFA4
	orr r1,r6	; 0232DFA6
	add r2,r5,#0x0	; 0232DFA8
	add r3,r4,#0x0	; 0232DFAA
	bl P1_QueueRequestRecord	; 0232DFAC
	add sp,#0x8	; 0232DFB0
	pop {r4,r5,r6}	; 0232DFB2
	pop {r3}	; 0232DFB4
	bx r3	; 0232DFB6

; ===== function loc_0232DFB8 =====
loc_0232DFB8:
	push {r4,r5,r6,lr}	; 0232DFB8
	sub sp,#0x8	; 0232DFBA
	add r6,r0,#0x0	; 0232DFBC
	add r5,r1,#0x0	; 0232DFBE
	add r4,r2,#0x0	; 0232DFC0
	str r3,[sp,#0x0]	; 0232DFC2
	mov r0,#0x3	; 0232DFC4
	add r1,r6,#0x0	; 0232DFC6
	add r2,r5,#0x0	; 0232DFC8
	add r3,r4,#0x0	; 0232DFCA
	bl P1_QueueRequestRecord	; 0232DFCC
	add sp,#0x8	; 0232DFD0
	pop {r4,r5,r6}	; 0232DFD2
	pop {r3}	; 0232DFD4
	bx r3	; 0232DFD6

; ===== function loc_0232DFD8 =====
loc_0232DFD8:
	push {r4,r5,r6,lr}	; 0232DFD8
	sub sp,#0x8	; 0232DFDA
	add r6,r0,#0x0	; 0232DFDC
	add r5,r1,#0x0	; 0232DFDE
	add r4,r2,#0x0	; 0232DFE0
	str r3,[sp,#0x0]	; 0232DFE2
	mov r0,#0x15	; 0232DFE4
	add r1,r6,#0x0	; 0232DFE6
	add r2,r5,#0x0	; 0232DFE8
	add r3,r4,#0x0	; 0232DFEA
	bl P1_QueueRequestRecord	; 0232DFEC
	add sp,#0x8	; 0232DFF0
	pop {r4,r5,r6}	; 0232DFF2
	pop {r3}	; 0232DFF4
	bx r3	; 0232DFF6

; ===== function loc_0232DFF8 =====
loc_0232DFF8:
	push {r4,r5,lr}	; 0232DFF8
	sub sp,#0x4	; 0232DFFA
	add r5,r0,#0x0	; 0232DFFC
	ldr r4,[sp,#0x10]	; 0232DFFE
	ldr r0,[sp,#0x24]	; 0232E000
	lsl r0,r0,#0x10	; 0232E002
	lsl r3,r3,#0x1a	; 0232E004
	lsl r1,r1,#0x18	; 0232E006
	orr r3,r1	; 0232E008
	orr r0,r3	; 0232E00A
	orr r4,r0	; 0232E00C
	str r4,[sp,#0x0]	; 0232E00E
	mov r0,#0xb	; 0232E010
	ldr r1,[sp,#0x20]	; 0232E012
	lsl r1,r1,#0x10	; 0232E014
	orr r1,r5	; 0232E016
	ldr r3,[sp,#0x14]	; 0232E018
	ldr r4,[sp,#0x18]	; 0232E01A
	lsl r5,r4,#0x18	; 0232E01C
	ldr r4,[sp,#0x1c]	; 0232E01E
	lsl r4,r4,#0x16	; 0232E020
	orr r5,r4	; 0232E022
	orr r3,r5	; 0232E024
	bl P1_QueueRequestRecord	; 0232E026
	add sp,#0x4	; 0232E02A
	pop {r4,r5}	; 0232E02C
	pop {r3}	; 0232E02E
	bx r3	; 0232E030
	.byte 0x00, 0x00	; 0232E034

; ===== function loc_0232E034 =====
loc_0232E034:
	push {r4,r5,lr}	; 0232E034
	sub sp,#0x4	; 0232E036
	add r5,r0,#0x0	; 0232E038
	add r4,r1,#0x0	; 0232E03A
	add r3,r2,#0x0	; 0232E03C
	mov r0,#0x0	; 0232E03E
	str r0,[sp,#0x0]	; 0232E040
	mov r0,#0x11	; 0232E042
	add r1,r5,#0x0	; 0232E044
	add r2,r4,#0x0	; 0232E046
	bl P1_QueueRequestRecord	; 0232E048
	add sp,#0x4	; 0232E04C
	pop {r4,r5}	; 0232E04E
	pop {r3}	; 0232E050
	bx r3	; 0232E052

; ===== function loc_0232E054 =====
loc_0232E054:
	push {r4,lr}	; 0232E054
	sub sp,#0x8	; 0232E056
	add r4,r0,#0x0	; 0232E058
	add r2,r1,#0x0	; 0232E05A
	mov r3,#0x0	; 0232E05C
	str r3,[sp,#0x0]	; 0232E05E
	mov r0,#0x17	; 0232E060
	add r1,r4,#0x0	; 0232E062
	bl P1_QueueRequestRecord	; 0232E064
	add sp,#0x8	; 0232E068
	pop {r4}	; 0232E06A
	pop {r3}	; 0232E06C
	bx r3	; 0232E06E

; ===== function loc_0232E070 =====
loc_0232E070:
	push {r4,lr}	; 0232E070
	sub sp,#0x8	; 0232E072
	add r4,r0,#0x0	; 0232E074
	add r2,r1,#0x0	; 0232E076
	mov r3,#0x0	; 0232E078
	str r3,[sp,#0x0]	; 0232E07A
	mov r0,#0x16	; 0232E07C
	add r1,r4,#0x0	; 0232E07E
	bl P1_QueueRequestRecord	; 0232E080
	add sp,#0x8	; 0232E084
	pop {r4}	; 0232E086
	pop {r3}	; 0232E088
	bx r3	; 0232E08A

; ===== function loc_0232E08C =====
loc_0232E08C:
	push {r4,r5,r6,lr}	; 0232E08C
	sub sp,#0x8	; 0232E08E
	add r5,r0,#0x0	; 0232E090
	add r4,r1,#0x0	; 0232E092
	add r6,r2,#0x0	; 0232E094
	add r1,r3,#0x0	; 0232E096
	ldr r2,[sp,#0x18]	; 0232E098
	bl loc_0232E640	; 0232E09A
	str r0,[sp,#0x0]	; 0232E09E
	mov r0,#0xf	; 0232E0A0
	add r1,r5,#0x0	; 0232E0A2
	add r2,r4,#0x0	; 0232E0A4
	add r3,r6,#0x0	; 0232E0A6
	bl P1_QueueRequestRecord	; 0232E0A8
	add sp,#0x8	; 0232E0AC
	pop {r4,r5,r6}	; 0232E0AE
	pop {r3}	; 0232E0B0
	bx r3	; 0232E0B2

; ===== function loc_0232E0B4 =====
loc_0232E0B4:
	push {r4,r5,r6,r7,lr}	; 0232E0B4
	sub sp,#0xc	; 0232E0B6
	add r6,r0,#0x0	; 0232E0B8
	str r1,[sp,#0x4]	; 0232E0BA
	mov r0,#0x0	; 0232E0BC
	str r0,[sp,#0x0]	; 0232E0BE
	mov r0,#0xe	; 0232E0C0
	add r1,r2,#0x0	; 0232E0C2
	add r2,r3,#0x0	; 0232E0C4
	ldr r3,[sp,#0x28]	; 0232E0C6
	lsl r7,r3,#0x1b	; 0232E0C8
	ldr r3,[sp,#0x24]	; 0232E0CA
	lsl r5,r3,#0x1c	; 0232E0CC
	ldr r3,[sp,#0x20]	; 0232E0CE
	lsl r4,r3,#0x1d	; 0232E0D0
	lsl r3,r6,#0x1f	; 0232E0D2
	ldr r6,[sp,#0x4]	; 0232E0D4
	lsl r6,r6,#0x1e	; 0232E0D6
	orr r3,r6	; 0232E0D8
	orr r4,r3	; 0232E0DA
	orr r5,r4	; 0232E0DC
	orr r7,r5	; 0232E0DE
	add r3,r7,#0x0	; 0232E0E0
	bl P1_QueueRequestRecord	; 0232E0E2
	add sp,#0xc	; 0232E0E6
	pop {r4,r5,r6,r7}	; 0232E0E8
	pop {r3}	; 0232E0EA
	bx r3	; 0232E0EC
	.byte 0x00, 0x00	; 0232E0F0

; ===== function loc_0232E0F0 =====
loc_0232E0F0:
	push {r4,r5,r6,r7,lr}	; 0232E0F0
	sub sp,#0x14	; 0232E0F2
	str r0,[sp,#0x4]	; 0232E0F4
	str r1,[sp,#0x8]	; 0232E0F6
	add r7,r2,#0x0	; 0232E0F8
	str r3,[sp,#0xc]	; 0232E0FA
	add r4,r7,#0x0	; 0232E0FC
	mov r5,#0x0	; 0232E0FE
	mov r6,#0x1	; 0232E100
	b loc_0232E116	; 0232E102
loc_0232E104:
	add r0,r4,#0x0	; 0232E104
	and r0,r6	; 0232E106
	cmp r0,#0x0	; 0232E108
	beq loc_0232E112	; 0232E10A
	add r0,r5,#0x0	; 0232E10C
	bl loc_0232E668	; 0232E10E
loc_0232E112:
	add r5,r5,#0x1	; 0232E112
	lsr r4,r4,#0x1	; 0232E114
loc_0232E116:
	cmp r5,#0x8	; 0232E116
	bge loc_0232E11E	; 0232E118
	cmp r4,#0x0	; 0232E11A
	bne loc_0232E104	; 0232E11C
loc_0232E11E:
	ldr r0,[sp,#0xc]	; 0232E11E
	str r0,[sp,#0x0]	; 0232E120
	mov r0,#0xa	; 0232E122
	ldr r1,[sp,#0x4]	; 0232E124
	ldr r2,[sp,#0x8]	; 0232E126
	add r3,r7,#0x0	; 0232E128
	bl P1_QueueRequestRecord	; 0232E12A
	add sp,#0x14	; 0232E12E
	pop {r4,r5,r6,r7}	; 0232E130
	pop {r3}	; 0232E132
	bx r3	; 0232E134
	.byte 0x00, 0x00	; 0232E138

; ===== function loc_0232E138 =====
loc_0232E138:
	push {r4,r5,r6,lr}	; 0232E138
	sub sp,#0x8	; 0232E13A
	add r6,r0,#0x0	; 0232E13C
	add r5,r1,#0x0	; 0232E13E
	add r4,r2,#0x0	; 0232E140
	str r3,[sp,#0x0]	; 0232E142
	mov r0,#0x9	; 0232E144
	add r1,r6,#0x0	; 0232E146
	add r2,r5,#0x0	; 0232E148
	add r3,r4,#0x0	; 0232E14A
	bl P1_QueueRequestRecord	; 0232E14C
	add sp,#0x8	; 0232E150
	pop {r4,r5,r6}	; 0232E152
	pop {r3}	; 0232E154
	bx r3	; 0232E156

; ===== function loc_0232E158 =====
loc_0232E158:
	push {lr}	; 0232E158
	sub sp,#0x4	; 0232E15A
	add r3,r2,#0x0	; 0232E15C
	mov r2,#0x1	; 0232E15E
	str r2,[sp,#0x0]	; 0232E160
	mov r2,#0x1a	; 0232E162
	bl loc_0232DF94	; 0232E164
	add sp,#0x4	; 0232E168
	pop {r3}	; 0232E16A
	bx r3	; 0232E16C
	.byte 0x00, 0x00	; 0232E170

; ===== function loc_0232E170 =====
loc_0232E170:
	push {lr}	; 0232E170
	sub sp,#0x4	; 0232E172
	add r3,r2,#0x0	; 0232E174
	mov r2,#0x2	; 0232E176
	str r2,[sp,#0x0]	; 0232E178
	mov r2,#0xc	; 0232E17A
	bl loc_0232DF94	; 0232E17C
	add sp,#0x4	; 0232E180
	pop {r3}	; 0232E182
	bx r3	; 0232E184
	.byte 0x00, 0x00	; 0232E188

; ===== function loc_0232E188 =====
loc_0232E188:
	push {lr}	; 0232E188
	sub sp,#0x4	; 0232E18A
	add r2,r1,#0x0	; 0232E18C
	mov r1,#0x4	; 0232E18E
	mov r3,#0x1	; 0232E190
	bl loc_0232DFB8	; 0232E192
	add sp,#0x4	; 0232E196
	pop {r3}	; 0232E198
	bx r3	; 0232E19A

; ===== function loc_0232E19C =====
loc_0232E19C:
	push {lr}	; 0232E19C
	sub sp,#0x4	; 0232E19E
	add r2,r1,#0x0	; 0232E1A0
	mov r1,#0x6	; 0232E1A2
	mov r3,#0x2	; 0232E1A4
	bl loc_0232DFB8	; 0232E1A6
	add sp,#0x4	; 0232E1AA
	pop {r3}	; 0232E1AC
	bx r3	; 0232E1AE

; ===== function loc_0232E1B0 =====
loc_0232E1B0:
	push {lr}	; 0232E1B0
	sub sp,#0x4	; 0232E1B2
	add r1,r0,#0x0	; 0232E1B4
	mov r2,#0x0	; 0232E1B6
	str r2,[sp,#0x0]	; 0232E1B8
	mov r0,#0x1	; 0232E1BA
	add r3,r2,#0x0	; 0232E1BC
	bl P1_QueueRequestRecord	; 0232E1BE
	add sp,#0x4	; 0232E1C2
	pop {r3}	; 0232E1C4
	bx r3	; 0232E1C6

; ===== function loc_0232E1C8 =====
loc_0232E1C8:
	push {r4,r5,r6,lr}	; 0232E1C8
	sub sp,#0x8	; 0232E1CA
	add r6,r0,#0x0	; 0232E1CC
	add r5,r1,#0x0	; 0232E1CE
	add r4,r2,#0x0	; 0232E1D0
	str r3,[sp,#0x0]	; 0232E1D2
	mov r0,#0x0	; 0232E1D4
	add r1,r6,#0x0	; 0232E1D6
	add r2,r5,#0x0	; 0232E1D8
	add r3,r4,#0x0	; 0232E1DA
	bl P1_QueueRequestRecord	; 0232E1DC
	add sp,#0x8	; 0232E1E0
	pop {r4,r5,r6}	; 0232E1E2
	pop {r3}	; 0232E1E4
	bx r3	; 0232E1E6

; ===== function loc_0232E1E8 =====
loc_0232E1E8:
	ldr r1,[pool_0232E204]	; 0232E1E8
	ldr r0,[r1,#0x0]	; 0232E1EA
	cmp r0,#0x0	; 0232E1EC
	bne loc_0232E1F4	; 0232E1EE
	mov r0,#0x0	; 0232E1F0
	bx lr	; 0232E1F2
loc_0232E1F4:
; 从空闲请求链弹出首条记录；链耗尽时同步清空尾指针。
; Pop the first record from the free request chain; clear its tail when exhausted.
.func P1_PopFreeRequestRecord
	ldr r2,[r0,#0x0]	; 0232E1F4
	str r2,[r1,#0x0]	; 0232E1F6
	cmp r2,#0x0	; 0232E1F8
	bne loc_0232E202	; 0232E1FA
	mov r2,#0x0	; 0232E1FC
	ldr r1,[pool_0232E208]	; 0232E1FE
	str r2,[r1,#0x0]	; 0232E200
loc_0232E202:
	bx lr	; 0232E202
pool_0232E204:
loc_0232E204:
	.word P1_RequestFreeHead	; 0232E204
pool_0232E208:
loc_0232E208:
	.word P1_RequestFreeTail	; 0232E208

.endfunc
; ===== function loc_0232E20C =====
loc_0232E20C:
	push {r4,r5,lr}	; 0232E20C
	sub sp,#0x4	; 0232E20E
	mov r5,#0x7	; 0232E210
	mov r4,#0x0	; 0232E212
loc_0232E214:
	add r0,r5,#0x0	; 0232E214
	add r1,r4,#0x0	; 0232E216
	add r2,r4,#0x0	; 0232E218
	bl loc_0232E8B4	; 0232E21A
	cmp r0,#0x0	; 0232E21E
	blt loc_0232E214	; 0232E220
	add sp,#0x4	; 0232E222
	pop {r4,r5}	; 0232E224
	pop {r3}	; 0232E226
	bx r3	; 0232E228
	.byte 0x00, 0x00	; 0232E22C

; ===== function loc_0232E22C =====
loc_0232E22C:
	push {r4,r5,r6,lr}	; 0232E22C
	mov r0,#0x7	; 0232E22E
	ldr r1,[pool_0232E268]	; 0232E230
	bl P1_SetPxiReceiveCallback	; 0232E232
	bl loc_0232BA34	; 0232E236
	cmp r0,#0x0	; 0232E23A
	bne loc_0232E262	; 0232E23C
	mov r0,#0x7	; 0232E23E
	mov r1,#0x1	; 0232E240
	bl loc_0232E948	; 0232E242
	cmp r0,#0x0	; 0232E246
	bne loc_0232E262	; 0232E248
	mov r5,#0x64	; 0232E24A
	mov r4,#0x7	; 0232E24C
	mov r6,#0x1	; 0232E24E
loc_0232E250:
	add r0,r5,#0x0	; 0232E250
	blx P1_Arm9BusyWaitByLoop4	; 0232E252
	add r0,r4,#0x0	; 0232E256
	add r1,r6,#0x0	; 0232E258
	bl loc_0232E948	; 0232E25A
	cmp r0,#0x0	; 0232E25E
	beq loc_0232E250	; 0232E260
loc_0232E262:
	pop {r4,r5,r6}	; 0232E262
	pop {r3}	; 0232E264
	bx r3	; 0232E266
pool_0232E268:
loc_0232E268:
	.word P1_PxiCallback_0232E26C + 1	; 0232E268

; ===== function loc_0232E26C =====
P1_PxiCallback_0232E26C:
	push {r4,r5,lr}	; 0232E26C
	sub sp,#0x4	; 0232E26E
	add r5,r1,#0x0	; 0232E270
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E272
	add r4,r0,#0x0	; 0232E276
	add r0,r5,#0x0	; 0232E278
	bl loc_0232E610	; 0232E27A
	add r0,r4,#0x0	; 0232E27E
	blx P1_Arm9RestoreIrqMask	; 0232E280
	add sp,#0x4	; 0232E284
	pop {r4,r5}	; 0232E286
	pop {r3}	; 0232E288
	bx r3	; 0232E28A

; ===== function loc_0232E28C =====
loc_0232E28C:
	push {r4,lr}	; 0232E28C
	bl loc_0232E2C0	; 0232E28E
	add r4,r0,#0x0	; 0232E292
	bl loc_0232E2A8	; 0232E294
	ldr r1,[pool_0232E2A4]	; 0232E298
	sub r1,r1,r4	; 0232E29A
	sub r0,r1,r0	; 0232E29C
	pop {r4}	; 0232E29E
	pop {r3}	; 0232E2A0
	bx r3	; 0232E2A2
pool_0232E2A4:
loc_0232E2A4:
	.word 0x00000100	; 0232E2A4

; ===== function loc_0232E2A8 =====
loc_0232E2A8:
	ldr r0,[pool_0232E2BC]	; 0232E2A8
	ldr r1,[r0,#0x0]	; 0232E2AA
	mov r0,#0x0	; 0232E2AC
	cmp r1,#0x0	; 0232E2AE
	beq loc_0232E2BA	; 0232E2B0
loc_0232E2B2:
	add r0,r0,#0x1	; 0232E2B2
	ldr r1,[r1,#0x0]	; 0232E2B4
	cmp r1,#0x0	; 0232E2B6
	bne loc_0232E2B2	; 0232E2B8
loc_0232E2BA:
	bx lr	; 0232E2BA
pool_0232E2BC:
loc_0232E2BC:
	.word P1_RequestPendingHead	; 0232E2BC

; ===== function loc_0232E2C0 =====
loc_0232E2C0:
	ldr r0,[pool_0232E2D4]	; 0232E2C0
	ldr r1,[r0,#0x0]	; 0232E2C2
	mov r0,#0x0	; 0232E2C4
	cmp r1,#0x0	; 0232E2C6
	beq loc_0232E2D2	; 0232E2C8
loc_0232E2CA:
	add r0,r0,#0x1	; 0232E2CA
	ldr r1,[r1,#0x0]	; 0232E2CC
	cmp r1,#0x0	; 0232E2CE
	bne loc_0232E2CA	; 0232E2D0
loc_0232E2D2:
	bx lr	; 0232E2D2
pool_0232E2D4:
loc_0232E2D4:
	.word P1_RequestFreeHead	; 0232E2D4

; ===== function loc_0232E2D8 =====
loc_0232E2D8:
	ldr r1,[pool_0232E300]	; 0232E2D8
	ldr r1,[r1,#0x0]	; 0232E2DA
	cmp r0,r1	; 0232E2DC
	bls loc_0232E2F0	; 0232E2DE
	sub r1,r0,r1	; 0232E2E0
	ldr r0,[pool_0232E304]	; 0232E2E2
	cmp r1,r0	; 0232E2E4
	bcc loc_0232E2EC	; 0232E2E6
	mov r0,#0x1	; 0232E2E8
	bx lr	; 0232E2EA
loc_0232E2EC:
	mov r0,#0x0	; 0232E2EC
	bx lr	; 0232E2EE
loc_0232E2F0:
	sub r1,r1,r0	; 0232E2F0
	ldr r0,[pool_0232E304]	; 0232E2F2
	cmp r1,r0	; 0232E2F4
	bcs loc_0232E2FC	; 0232E2F6
	mov r0,#0x1	; 0232E2F8
	bx lr	; 0232E2FA
loc_0232E2FC:
	mov r0,#0x0	; 0232E2FC
	bx lr	; 0232E2FE
pool_0232E300:
loc_0232E300:
	.word P1_BssStart + 0x266D4	; 0232E300
pool_0232E304:
loc_0232E304:
	.word 0x80000000	; 0232E304

; ===== function loc_0232E308 =====
loc_0232E308:
	ldr r0,[pool_0232E31C]	; 0232E308
	ldr r0,[r0,#0x0]	; 0232E30A
	cmp r0,#0x0	; 0232E30C
	bne loc_0232E316	; 0232E30E
	ldr r0,[pool_0232E320]	; 0232E310
	ldr r0,[r0,#0x0]	; 0232E312
	bx lr	; 0232E314
loc_0232E316:
	ldr r0,[pool_0232E324]	; 0232E316
	ldr r0,[r0,#0x0]	; 0232E318
	bx lr	; 0232E31A
pool_0232E31C:
loc_0232E31C:
	.word P1_RequestPendingHead	; 0232E31C
pool_0232E320:
loc_0232E320:
	.word P1_BssStart + 0x266D4	; 0232E320
pool_0232E324:
loc_0232E324:
	.word P1_BssStart + 0x266F0	; 0232E324

; ===== function loc_0232E328 =====
loc_0232E328:
	push {r4,r5,lr}	; 0232E328
	sub sp,#0x4	; 0232E32A
	add r4,r0,#0x0	; 0232E32C
	bl loc_0232E2D8	; 0232E32E
	cmp r0,#0x0	; 0232E332
	bne loc_0232E36C	; 0232E334
	mov r5,#0x0	; 0232E336
loc_0232E338:
	add r0,r5,#0x0	; 0232E338
	bl loc_0232E4CC	; 0232E33A
	cmp r0,#0x0	; 0232E33E
	bne loc_0232E338	; 0232E340
	add r0,r4,#0x0	; 0232E342
	bl loc_0232E2D8	; 0232E344
	cmp r0,#0x0	; 0232E348
	bne loc_0232E36C	; 0232E34A
	bl loc_0232E20C	; 0232E34C
	add r0,r4,#0x0	; 0232E350
	bl loc_0232E2D8	; 0232E352
	cmp r0,#0x0	; 0232E356
	bne loc_0232E36C	; 0232E358
	mov r5,#0x1	; 0232E35A
loc_0232E35C:
	add r0,r5,#0x0	; 0232E35C
	bl loc_0232E4CC	; 0232E35E
	add r0,r4,#0x0	; 0232E362
	bl loc_0232E2D8	; 0232E364
	cmp r0,#0x0	; 0232E368
	beq loc_0232E35C	; 0232E36A
loc_0232E36C:
	add sp,#0x4	; 0232E36C
	pop {r4,r5}	; 0232E36E
	pop {r3}	; 0232E370
	bx r3	; 0232E372

; ===== function loc_0232E374 =====
loc_0232E374:
	push {r4,lr}	; 0232E374
	add r4,r0,#0x0	; 0232E376
	ldr r0,[pool_0232E41C]	; 0232E378
	ldr r0,[r0,#0x0]	; 0232E37A
	cmp r0,#0x0	; 0232E37C
	bne loc_0232E388	; 0232E37E
	mov r0,#0x1	; 0232E380
	pop {r4}	; 0232E382
	pop {r3}	; 0232E384
	bx r3	; 0232E386
loc_0232E388:
	ldr r0,[pool_0232E420]	; 0232E388
	ldr r0,[r0,#0x0]	; 0232E38A
	cmp r0,#0x8	; 0232E38C
	blt loc_0232E3AA	; 0232E38E
	cmp r4,#0x0	; 0232E390
	bne loc_0232E39C	; 0232E392
	mov r0,#0x0	; 0232E394
	pop {r4}	; 0232E396
	pop {r3}	; 0232E398
	bx r3	; 0232E39A
loc_0232E39C:
	mov r0,#0x1	; 0232E39C
	bl loc_0232E4CC	; 0232E39E
	ldr r0,[pool_0232E420]	; 0232E3A2
	ldr r0,[r0,#0x0]	; 0232E3A4
	cmp r0,#0x8	; 0232E3A6
	bge loc_0232E39C	; 0232E3A8
loc_0232E3AA:
	ldr r0,[pool_0232E424]	; 0232E3AA
	ldr r1,[pool_0232E428]	; 0232E3AC
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E3AE
	mov r0,#0x7	; 0232E3B2
	ldr r1,[pool_0232E41C]	; 0232E3B4
	ldr r1,[r1,#0x0]	; 0232E3B6
	mov r2,#0x0	; 0232E3B8
	bl loc_0232E8B4	; 0232E3BA
	cmp r0,#0x0	; 0232E3BE
	bge loc_0232E3DE	; 0232E3C0
	cmp r4,#0x0	; 0232E3C2
	bne loc_0232E3CE	; 0232E3C4
	mov r0,#0x0	; 0232E3C6
	pop {r4}	; 0232E3C8
	pop {r3}	; 0232E3CA
	bx r3	; 0232E3CC
loc_0232E3CE:
	mov r0,#0x7	; 0232E3CE
	ldr r1,[pool_0232E41C]	; 0232E3D0
	ldr r1,[r1,#0x0]	; 0232E3D2
	mov r2,#0x0	; 0232E3D4
	bl loc_0232E8B4	; 0232E3D6
	cmp r0,#0x0	; 0232E3DA
	blt loc_0232E3CE	; 0232E3DC
loc_0232E3DE:
	ldr r0,[pool_0232E41C]	; 0232E3DE
	ldr r4,[r0,#0x0]	; 0232E3E0
	ldr r0,[pool_0232E42C]	; 0232E3E2
	ldr r2,[r0,#0x0]	; 0232E3E4
	lsl r3,r2,#0x2	; 0232E3E6
	ldr r1,[pool_0232E430]	; 0232E3E8
	str r4,[r1,r3]	; 0232E3EA
	add r1,r2,#0x1	; 0232E3EC
	str r1,[r0,#0x0]	; 0232E3EE
	cmp r1,#0x8	; 0232E3F0
	ble loc_0232E3F8	; 0232E3F2
	mov r1,#0x0	; 0232E3F4
	str r1,[r0,#0x0]	; 0232E3F6
loc_0232E3F8:
	mov r1,#0x0	; 0232E3F8
	ldr r0,[pool_0232E41C]	; 0232E3FA
	str r1,[r0,#0x0]	; 0232E3FC
	ldr r0,[pool_0232E434]	; 0232E3FE
	str r1,[r0,#0x0]	; 0232E400
	ldr r0,[pool_0232E420]	; 0232E402
	ldr r1,[r0,#0x0]	; 0232E404
	add r1,r1,#0x1	; 0232E406
	str r1,[r0,#0x0]	; 0232E408
	ldr r0,[pool_0232E438]	; 0232E40A
	ldr r1,[r0,#0x0]	; 0232E40C
	add r1,r1,#0x1	; 0232E40E
	str r1,[r0,#0x0]	; 0232E410
	mov r0,#0x1	; 0232E412
	pop {r4}	; 0232E414
	pop {r3}	; 0232E416
	bx r3	; 0232E418
	.byte 0xC0, 0x46	; 0232E41C
pool_0232E41C:
loc_0232E41C:
	.word P1_RequestPendingHead	; 0232E41C
pool_0232E420:
loc_0232E420:
	.word P1_BssStart + 0x266EC	; 0232E420
pool_0232E424:
loc_0232E424:
	.word 0x02357460	; 0232E424
pool_0232E428:
loc_0232E428:
	.word 0x00001800	; 0232E428
pool_0232E42C:
loc_0232E42C:
	.word P1_BssStart + 0x266E8	; 0232E42C
pool_0232E430:
loc_0232E430:
	.word P1_BssStart + 0x266F4	; 0232E430
pool_0232E434:
loc_0232E434:
	.word P1_RequestPendingTail	; 0232E434
pool_0232E438:
loc_0232E438:
	.word P1_BssStart + 0x266F0	; 0232E438

; ===== function loc_0232E43C =====
loc_0232E43C:
	ldr r2,[pool_0232E458]	; 0232E43C
	ldr r1,[r2,#0x0]	; 0232E43E
	cmp r1,#0x0	; 0232E440
	bne loc_0232E44C	; 0232E442
	ldr r1,[pool_0232E45C]	; 0232E444
	str r0,[r1,#0x0]	; 0232E446
	str r0,[r2,#0x0]	; 0232E448
; 将请求记录追加到本地待处理单链表，并清零其 next 字段。
; Append a request record to the local pending singly linked list and clear its next field.
.func P1_EnqueueRequestRecord
	b loc_0232E450	; 0232E44A
loc_0232E44C:
	str r0,[r1,#0x0]	; 0232E44C
	str r0,[r2,#0x0]	; 0232E44E
loc_0232E450:
	mov r1,#0x0	; 0232E450
	str r1,[r0,#P1_RequestRecordNextOffset]	; 0232E452
	bx lr	; 0232E454
	.byte 0xC0, 0x46	; 0232E458
pool_0232E458:
loc_0232E458:
	.word P1_RequestPendingTail	; 0232E458
pool_0232E45C:
loc_0232E45C:
	.word P1_RequestPendingHead	; 0232E45C
.endfunc

; ===== function loc_0232E460 =====
loc_0232E460:
	push {r4,lr}	; 0232E460
	add r4,r0,#0x0	; 0232E462
	bl loc_0232BA34	; 0232E464
	cmp r0,#0x0	; 0232E468
	beq loc_0232E474	; 0232E46A
	mov r0,#0x0	; 0232E46C
	pop {r4}	; 0232E46E
; 从空闲链取出请求记录；调用方要求时等待可用记录。
; Take a request record from the free chain; wait for one when the caller requires it.
.func P1_AcquireRequestRecord
	pop {r3}	; 0232E470
	bx r3	; 0232E472
loc_0232E474:
	bl P1_PopFreeRequestRecord	; 0232E474
	cmp r0,#0x0	; 0232E478
	bne loc_0232E4C4	; 0232E47A
	cmp r4,#0x0	; 0232E47C
	bne loc_0232E488	; 0232E47E
	mov r0,#0x0	; 0232E480
	pop {r4}	; 0232E482
	pop {r3}	; 0232E484
	bx r3	; 0232E486
loc_0232E488:
	bl loc_0232E28C	; 0232E488
	cmp r0,#0x0	; 0232E48C
	ble loc_0232E4AA	; 0232E48E
	mov r4,#0x0	; 0232E490
loc_0232E492:
	add r0,r4,#0x0	; 0232E492
	bl loc_0232E4CC	; 0232E494
	cmp r0,#0x0	; 0232E498
	bne loc_0232E492	; 0232E49A
	bl P1_PopFreeRequestRecord	; 0232E49C
	cmp r0,#0x0	; 0232E4A0
	beq loc_0232E4B0	; 0232E4A2
	pop {r4}	; 0232E4A4
	pop {r3}	; 0232E4A6
	bx r3	; 0232E4A8
loc_0232E4AA:
	mov r0,#0x1	; 0232E4AA
	bl loc_0232E374	; 0232E4AC
loc_0232E4B0:
	bl loc_0232E20C	; 0232E4B0
	mov r4,#0x1	; 0232E4B4
loc_0232E4B6:
	add r0,r4,#0x0	; 0232E4B6
	bl loc_0232E4CC	; 0232E4B8
	bl P1_PopFreeRequestRecord	; 0232E4BC
	cmp r0,#0x0	; 0232E4C0
	beq loc_0232E4B6	; 0232E4C2
loc_0232E4C4:
	pop {r4}	; 0232E4C4
	pop {r3}	; 0232E4C6
	bx r3	; 0232E4C8
	.byte 0x00, 0x00	; 0232E4CC

; ===== function loc_0232E4CC =====
loc_0232E4CC:
	push {lr}	; 0232E4CC
	sub sp,#0x4	; 0232E4CE
	cmp r0,#0x0	; 0232E4D0
.endfunc
	bne loc_0232E4E8	; 0232E4D2
	bl loc_0232E6EC	; 0232E4D4
	ldr r1,[pool_0232E544]	; 0232E4D8
	ldr r1,[r1,#0x0]	; 0232E4DA
	cmp r1,r0	; 0232E4DC
	bne loc_0232E4F4	; 0232E4DE
	mov r0,#0x0	; 0232E4E0
	add sp,#0x4	; 0232E4E2
	pop {r3}	; 0232E4E4
	bx r3	; 0232E4E6
loc_0232E4E8:
	bl loc_0232E6EC	; 0232E4E8
	ldr r1,[pool_0232E544]	; 0232E4EC
	ldr r1,[r1,#0x0]	; 0232E4EE
	cmp r1,r0	; 0232E4F0
	beq loc_0232E4E8	; 0232E4F2
loc_0232E4F4:
	ldr r1,[pool_0232E548]	; 0232E4F4
	ldr r2,[r1,#0x0]	; 0232E4F6
	lsl r3,r2,#0x2	; 0232E4F8
	ldr r0,[pool_0232E54C]	; 0232E4FA
	ldr r0,[r0,r3]	; 0232E4FC
	add r2,r2,#0x1	; 0232E4FE
	str r2,[r1,#0x0]	; 0232E500
	cmp r2,#0x8	; 0232E502
	ble loc_0232E50A	; 0232E504
	mov r2,#0x0	; 0232E506
	str r2,[r1,#0x0]	; 0232E508
loc_0232E50A:
	add r2,r0,#0x0	; 0232E50A
	ldr r1,[r0,#0x0]	; 0232E50C
	cmp r1,#0x0	; 0232E50E
	beq loc_0232E51A	; 0232E510
loc_0232E512:
	ldr r2,[r2,#0x0]	; 0232E512
	ldr r1,[r2,#0x0]	; 0232E514
	cmp r1,#0x0	; 0232E516
	bne loc_0232E512	; 0232E518
loc_0232E51A:
	ldr r1,[pool_0232E550]	; 0232E51A
	ldr r1,[r1,#0x0]	; 0232E51C
	cmp r1,#0x0	; 0232E51E
	beq loc_0232E526	; 0232E520
	str r0,[r1,#0x0]	; 0232E522
	b loc_0232E52A	; 0232E524
loc_0232E526:
	ldr r1,[pool_0232E554]	; 0232E526
	str r0,[r1,#0x0]	; 0232E528
loc_0232E52A:
	ldr r1,[pool_0232E550]	; 0232E52A
	str r2,[r1,#0x0]	; 0232E52C
	ldr r1,[pool_0232E558]	; 0232E52E
	ldr r2,[r1,#0x0]	; 0232E530
	sub r2,r2,#0x1	; 0232E532
	str r2,[r1,#0x0]	; 0232E534
	ldr r1,[pool_0232E544]	; 0232E536
	ldr r2,[r1,#0x0]	; 0232E538
	add r2,r2,#0x1	; 0232E53A
	str r2,[r1,#0x0]	; 0232E53C
	add sp,#0x4	; 0232E53E
	pop {r3}	; 0232E540
	bx r3	; 0232E542
pool_0232E544:
loc_0232E544:
	.word P1_BssStart + 0x266D4	; 0232E544
pool_0232E548:
loc_0232E548:
	.word P1_BssStart + 0x266E4	; 0232E548
pool_0232E54C:
loc_0232E54C:
	.word P1_BssStart + 0x266F4	; 0232E54C
pool_0232E550:
loc_0232E550:
	.word P1_RequestFreeTail	; 0232E550
pool_0232E554:
loc_0232E554:
	.word P1_RequestFreeHead	; 0232E554
pool_0232E558:
loc_0232E558:
	.word P1_BssStart + 0x266EC	; 0232E558

; ===== function loc_0232E55C =====
loc_0232E55C:
	push {r4,lr}	; 0232E55C
	bl loc_0232E22C	; 0232E55E
	ldr r3,[pool_0232E5D8]	; 0232E562
	ldr r0,[pool_0232E5DC]	; 0232E564
	str r3,[r0,#0x0]	; 0232E566
	mov r4,#0x0	; 0232E568
	add r2,r3,#0x0	; 0232E56A
	mov r0,#0x18	; 0232E56C
loc_0232E56E:
	add r4,r4,#0x1	; 0232E56E
	add r1,r4,#0x0	; 0232E570
	mul r1,r0	; 0232E572
	add r1,r2,r1	; 0232E574
	str r1,[r3,#0x0]	; 0232E576
	add r3,#0x18	; 0232E578
	cmp r4,#0xff	; 0232E57A
	blt loc_0232E56E	; 0232E57C
	mov r0,#0x0	; 0232E57E
	ldr r1,[pool_0232E5E0]	; 0232E580
	str r0,[r1,#0x68]	; 0232E582
	ldr r2,[pool_0232E5E4]	; 0232E584
	ldr r1,[pool_0232E5E8]	; 0232E586
	str r2,[r1,#0x0]	; 0232E588
	ldr r1,[pool_0232E5EC]	; 0232E58A
	str r0,[r1,#0x0]	; 0232E58C
	ldr r1,[pool_0232E5F0]	; 0232E58E
	str r0,[r1,#0x0]	; 0232E590
	ldr r1,[pool_0232E5F4]	; 0232E592
	str r0,[r1,#0x0]	; 0232E594
	ldr r1,[pool_0232E5F8]	; 0232E596
	str r0,[r1,#0x0]	; 0232E598
	ldr r1,[pool_0232E5FC]	; 0232E59A
	str r0,[r1,#0x0]	; 0232E59C
	mov r2,#0x1	; 0232E59E
	ldr r1,[pool_0232E600]	; 0232E5A0
	str r2,[r1,#0x0]	; 0232E5A2
	ldr r1,[pool_0232E604]	; 0232E5A4
	str r0,[r1,#0x0]	; 0232E5A6
	ldr r0,[pool_0232E608]	; 0232E5A8
	ldr r1,[pool_0232E60C]	; 0232E5AA
	str r0,[r1,#0x0]	; 0232E5AC
	bl loc_0232E69C	; 0232E5AE
	mov r0,#0x1	; 0232E5B2
	bl P1_AcquireRequestRecord	; 0232E5B4
	cmp r0,#0x0	; 0232E5B8
	beq loc_0232E5D0	; 0232E5BA
	mov r1,#0x19	; 0232E5BC
	str r1,[r0,#0x4]	; 0232E5BE
	ldr r1,[pool_0232E60C]	; 0232E5C0
	ldr r1,[r1,#0x0]	; 0232E5C2
	str r1,[r0,#0x8]	; 0232E5C4
	bl P1_EnqueueRequestRecord	; 0232E5C6
	mov r0,#0x1	; 0232E5CA
	bl loc_0232E374	; 0232E5CC
loc_0232E5D0:
	pop {r4}	; 0232E5D0
	pop {r3}	; 0232E5D2
	bx r3	; 0232E5D4
	.byte 0xC0, 0x46	; 0232E5D8
pool_0232E5D8:
loc_0232E5D8:
	.word P1_BssStart + 0x269A0	; 0232E5D8
pool_0232E5DC:
loc_0232E5DC:
	.word P1_RequestFreeHead	; 0232E5DC
pool_0232E5E0:
loc_0232E5E0:
	.word P1_BssStart + 0x28120	; 0232E5E0
pool_0232E5E4:
loc_0232E5E4:
	.word 0x02358C48	; 0232E5E4
pool_0232E5E8:
loc_0232E5E8:
	.word P1_RequestFreeTail	; 0232E5E8
pool_0232E5EC:
loc_0232E5EC:
	.word P1_RequestPendingHead	; 0232E5EC
pool_0232E5F0:
loc_0232E5F0:
	.word P1_RequestPendingTail	; 0232E5F0
pool_0232E5F4:
loc_0232E5F4:
	.word P1_BssStart + 0x266EC	; 0232E5F4
pool_0232E5F8:
loc_0232E5F8:
	.word P1_BssStart + 0x266E4	; 0232E5F8
pool_0232E5FC:
loc_0232E5FC:
	.word P1_BssStart + 0x266E8	; 0232E5FC
pool_0232E600:
loc_0232E600:
	.word P1_BssStart + 0x266F0	; 0232E600
pool_0232E604:
loc_0232E604:
	.word P1_BssStart + 0x266D4	; 0232E604
pool_0232E608:
loc_0232E608:
	.word 0x023571E0	; 0232E608
pool_0232E60C:
loc_0232E60C:
	.word P1_BssStart + 0x28200	; 0232E60C

; ===== function loc_0232E610 =====
loc_0232E610:
	push {r4,lr}	; 0232E610
	ldr r4,[pool_0232E63C]	; 0232E612
	mov r2,#0xff	; 0232E614
	add r3,r0,#0x0	; 0232E616
	and r3,r2	; 0232E618
	mov r1,#0xc	; 0232E61A
	mul r3,r1	; 0232E61C
	add r3,r4,r3	; 0232E61E
	asr r1,r0,#0x8	; 0232E620
	and r1,r2	; 0232E622
	ldrb r0,[r3,#0x8]	; 0232E624
	cmp r1,r0	; 0232E626
	bne loc_0232E634	; 0232E628
	ldr r1,[r3,#0x0]	; 0232E62A
	cmp r1,#0x0	; 0232E62C
	beq loc_0232E634	; 0232E62E
	ldr r0,[r3,#0x4]	; 0232E630
	blx r1	; 0232E632
loc_0232E634:
	pop {r4}	; 0232E634
	pop {r3}	; 0232E636
	bx r3	; 0232E638
	.byte 0xC0, 0x46	; 0232E63C
pool_0232E63C:
loc_0232E63C:
	.word 0x02358C60	; 0232E63C

; ===== function loc_0232E640 =====
loc_0232E640:
	push {r4}	; 0232E640
	sub sp,#0x4	; 0232E642
	ldr r4,[pool_0232E664]	; 0232E644
	mov r3,#0xc	; 0232E646
	mul r0,r3	; 0232E648
	add r3,r4,r0	; 0232E64A
	str r1,[r4,r0]	; 0232E64C
	str r2,[r3,#0x4]	; 0232E64E
	add r1,r3,#0x0	; 0232E650
	add r1,#0x8	; 0232E652
	ldrb r0,[r1,#0x0]	; 0232E654
	add r0,r0,#0x1	; 0232E656
	strb r0,[r1,#0x0]	; 0232E658
	ldrb r0,[r3,#0x8]	; 0232E65A
	add sp,#0x4	; 0232E65C
	pop {r4}	; 0232E65E
	bx lr	; 0232E660
	.byte 0xC0, 0x46	; 0232E664
pool_0232E664:
loc_0232E664:
	.word P1_BssStart + 0x281A0	; 0232E664

; ===== function loc_0232E668 =====
loc_0232E668:
	ldr r2,[pool_0232E67C]	; 0232E668
	mov r1,#0xc	; 0232E66A
	mul r0,r1	; 0232E66C
	add r1,r2,r0	; 0232E66E
	add r1,#0x8	; 0232E670
	ldrb r0,[r1,#0x0]	; 0232E672
	add r0,r0,#0x1	; 0232E674
	strb r0,[r1,#0x0]	; 0232E676
	bx lr	; 0232E678
	.byte 0xC0, 0x46	; 0232E67C
pool_0232E67C:
loc_0232E67C:
	.word 0x02358C60	; 0232E67C

; ===== function loc_0232E680 =====
loc_0232E680:
	mov r2,#0x0	; 0232E680
	ldr r1,[pool_0232E698]	; 0232E682
	add r0,r2,#0x0	; 0232E684
loc_0232E686:
	str r0,[r1,#0x0]	; 0232E686
	str r0,[r1,#0x4]	; 0232E688
	strb r0,[r1,#0x8]	; 0232E68A
	add r1,#0xc	; 0232E68C
	add r2,r2,#0x1	; 0232E68E
	cmp r2,#0x8	; 0232E690
	blt loc_0232E686	; 0232E692
	bx lr	; 0232E694
	.byte 0xC0, 0x46	; 0232E698
pool_0232E698:
loc_0232E698:
	.word P1_BssStart + 0x281A0	; 0232E698

; ===== function loc_0232E69C =====
loc_0232E69C:
	push {r4,r5,r6,lr}	; 0232E69C
	mov r6,#0x0	; 0232E69E
	str r6,[r0,#0x4]	; 0232E6A0
	strh r6,[r0,#0x8]	; 0232E6A2
	strh r6,[r0,#0xa]	; 0232E6A4
	str r6,[r0,#0x0]	; 0232E6A6
	add r4,r0,#0x0	; 0232E6A8
	mvn r1,r6	; 0232E6AA
	add r2,r6,#0x0	; 0232E6AC
loc_0232E6AE:
	str r2,[r4,#0x40]	; 0232E6AE
	add r5,r2,#0x0	; 0232E6B0
	add r3,r4,#0x0	; 0232E6B2
loc_0232E6B4:
	strh r1,[r3,#0x20]	; 0232E6B4
	add r3,r3,#0x2	; 0232E6B6
	add r5,r5,#0x1	; 0232E6B8
	cmp r5,#0x10	; 0232E6BA
	blt loc_0232E6B4	; 0232E6BC
	add r4,#0x24	; 0232E6BE
	add r6,r6,#0x1	; 0232E6C0
	cmp r6,#0x10	; 0232E6C2
	blt loc_0232E6AE	; 0232E6C4
	mov r3,#0x0	; 0232E6C6
	add r4,r0,#0x0	; 0232E6C8
	mvn r2,r3	; 0232E6CA
	ldr r1,[pool_0232E6E4]	; 0232E6CC
loc_0232E6CE:
	strh r2,[r4,r1]	; 0232E6CE
	add r4,r4,#0x2	; 0232E6D0
	add r3,r3,#0x1	; 0232E6D2
	cmp r3,#0x10	; 0232E6D4
	blt loc_0232E6CE	; 0232E6D6
	ldr r1,[pool_0232E6E8]	; 0232E6D8
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E6DA
	pop {r4,r5,r6}	; 0232E6DE
	pop {r3}	; 0232E6E0
	bx r3	; 0232E6E2
pool_0232E6E4:
loc_0232E6E4:
	.word 0x00000260	; 0232E6E4
pool_0232E6E8:
loc_0232E6E8:
	.word 0x00000280	; 0232E6E8

; ===== function loc_0232E6EC =====
loc_0232E6EC:
	push {lr}	; 0232E6EC
	sub sp,#0x4	; 0232E6EE
	ldr r0,[pool_0232E708]	; 0232E6F0
	ldr r0,[r0,#0x0]	; 0232E6F2
	ldr r1,[pool_0232E70C]	; 0232E6F4
	blx P1_InvalidateDataCacheRange	; 0232E6F6
	ldr r0,[pool_0232E708]	; 0232E6FA
	ldr r0,[r0,#0x0]	; 0232E6FC
	ldr r0,[r0,#0x0]	; 0232E6FE
	add sp,#0x4	; 0232E700
	pop {r3}	; 0232E702
	bx r3	; 0232E704
	.byte 0xC0, 0x46	; 0232E708
pool_0232E708:
loc_0232E708:
	.word P1_BssStart + 0x28200	; 0232E708
pool_0232E70C:
loc_0232E70C:
	.word 0x00000280	; 0232E70C

; ===== function loc_0232E710 =====
loc_0232E710:
	push {lr}	; 0232E710
	sub sp,#0x4	; 0232E712
	ldr r0,[pool_0232E72C]	; 0232E714
	ldr r0,[r0,#0x0]	; 0232E716
	ldr r1,[pool_0232E730]	; 0232E718
	blx P1_InvalidateDataCacheRange	; 0232E71A
	ldr r0,[pool_0232E72C]	; 0232E71E
	ldr r0,[r0,#0x0]	; 0232E720
	ldrh r0,[r0,#0x8]	; 0232E722
	add sp,#0x4	; 0232E724
	pop {r3}	; 0232E726
	bx r3	; 0232E728
	.byte 0xC0, 0x46	; 0232E72C
pool_0232E72C:
loc_0232E72C:
	.word P1_BssStart + 0x28200	; 0232E72C
pool_0232E730:
loc_0232E730:
	.word 0x00000280	; 0232E730

; ===== function loc_0232E734 =====
loc_0232E734:
	push {lr}	; 0232E734
	sub sp,#0x4	; 0232E736
	ldr r0,[pool_0232E750]	; 0232E738
	ldr r0,[r0,#0x0]	; 0232E73A
	ldr r1,[pool_0232E754]	; 0232E73C
	blx P1_InvalidateDataCacheRange	; 0232E73E
	ldr r0,[pool_0232E750]	; 0232E742
	ldr r0,[r0,#0x0]	; 0232E744
	ldr r0,[r0,#0x4]	; 0232E746
	add sp,#0x4	; 0232E748
	pop {r3}	; 0232E74A
	bx r3	; 0232E74C
	.byte 0xC0, 0x46	; 0232E750
pool_0232E750:
loc_0232E750:
	.word P1_BssStart + 0x28200	; 0232E750
pool_0232E754:
loc_0232E754:
	.word 0x00000280	; 0232E754

; ===== function loc_0232E758 =====
loc_0232E758:
	push {r4,r5,r6,r7,lr}	; 0232E758
	sub sp,#0x4	; 0232E75A
	add r5,r0,#0x0	; 0232E75C
	add r7,r1,#0x0	; 0232E75E
	add r4,r2,#0x0	; 0232E760
	lsl r2,r7,#0x3	; 0232E762
	add r1,r5,r2	; 0232E764
	ldr r0,[r1,#0x18]	; 0232E766
	cmp r0,#0x0	; 0232E768
	beq loc_0232E7A8	; 0232E76A
	cmp r4,r0	; 0232E76C
	beq loc_0232E7CA	; 0232E76E
	ldr r6,[r0,#0x18]	; 0232E770
	add r3,r5,#0x0	; 0232E772
	add r3,#0x18	; 0232E774
	add r3,r3,r2	; 0232E776
	cmp r3,r6	; 0232E778
	bne loc_0232E78A	; 0232E77A
	ldr r2,[r1,#0x1c]	; 0232E77C
	str r2,[r0,#0x18]	; 0232E77E
	ldr r0,[r1,#0x18]	; 0232E780
	mov r1,#0x3c	; 0232E782
	blx P1_CleanDataCacheRange	; 0232E784
	b loc_0232E7A8	; 0232E788
loc_0232E78A:
	cmp r6,#0x0	; 0232E78A
	beq loc_0232E79A	; 0232E78C
loc_0232E78E:
	ldr r0,[r6,#0x4]	; 0232E78E
	cmp r3,r0	; 0232E790
	beq loc_0232E79A	; 0232E792
	add r6,r0,#0x0	; 0232E794
	cmp r0,#0x0	; 0232E796
	bne loc_0232E78E	; 0232E798
loc_0232E79A:
	add r0,r5,r2	; 0232E79A
	ldr r0,[r0,#0x1c]	; 0232E79C
	str r0,[r6,#0x4]	; 0232E79E
	add r0,r6,#0x0	; 0232E7A0
	mov r1,#0x8	; 0232E7A2
	blx P1_CleanDataCacheRange	; 0232E7A4
loc_0232E7A8:
	ldr r0,[r4,#0x18]	; 0232E7A8
	lsl r3,r7,#0x3	; 0232E7AA
	add r2,r5,#0x0	; 0232E7AC
	add r2,#0x18	; 0232E7AE
	add r1,r2,r3	; 0232E7B0
	str r1,[r4,#0x18]	; 0232E7B2
	add r1,r5,r3	; 0232E7B4
	str r0,[r1,#0x1c]	; 0232E7B6
	str r4,[r2,r3]	; 0232E7B8
	add r0,r5,#0x0	; 0232E7BA
	mov r1,#0x3c	; 0232E7BC
	blx P1_CleanDataCacheRange	; 0232E7BE
	add r0,r4,#0x0	; 0232E7C2
	mov r1,#0x3c	; 0232E7C4
	blx P1_CleanDataCacheRange	; 0232E7C6
loc_0232E7CA:
	add sp,#0x4	; 0232E7CA
	pop {r4,r5,r6,r7}	; 0232E7CC
	pop {r3}	; 0232E7CE
	bx r3	; 0232E7D0
	.byte 0x00, 0x00	; 0232E7D4

; ===== function loc_0232E7D4 =====
loc_0232E7D4:
	ldr r3,[pool_0232E7D8]	; 0232E7D4
	bx r3	; 0232E7D6
pool_0232E7D8:
loc_0232E7D8:
	.word loc_0232E9C4 + 1	; 0232E7D8

; ===== function loc_0232E7DC =====
P1_IrqHandler_0232E7DC:
	push {r4,r5,r6,r7,lr}	; 0232E7DC
	sub sp,#0x4	; 0232E7DE
	ldr r5,[pool_0232E898]	; 0232E7E0
	mov r0,#0x3	; 0232E7E2
	mvn r6,r0	; 0232E7E4
	mov r7,#0x2	; 0232E7E6
	mvn r4,r7	; 0232E7E8
loc_0232E7EA:
	ldrh r1,[r5,#0x0]	; 0232E7EA
	ldr r0,[pool_0232E89C]	; 0232E7EC
	and r1,r0	; 0232E7EE
	cmp r1,#0x0	; 0232E7F0
	beq loc_0232E800	; 0232E7F2
	ldrh r1,[r5,#0x0]	; 0232E7F4
	ldr r0,[pool_0232E8A0]	; 0232E7F6
	orr r1,r0	; 0232E7F8
	strh r1,[r5,#0x0]	; 0232E7FA
	add r0,r4,#0x0	; 0232E7FC
	b loc_0232E822	; 0232E7FE
loc_0232E800:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E800
	ldrh r2,[r5,#0x0]	; 0232E804
	ldr r1,[pool_0232E8A4]	; 0232E806
	and r2,r1	; 0232E808
	cmp r2,#0x0	; 0232E80A
	beq loc_0232E816	; 0232E80C
	blx P1_Arm9RestoreIrqMask	; 0232E80E
	add r0,r6,#0x0	; 0232E812
	b loc_0232E822	; 0232E814
loc_0232E816:
	ldr r1,[pool_0232E8A8]	; 0232E816
	ldr r1,[r1,#0x0]	; 0232E818
	str r1,[sp,#0x0]	; 0232E81A
	blx P1_Arm9RestoreIrqMask	; 0232E81C
	mov r0,#0x0	; 0232E820
loc_0232E822:
	mov r1,#0x3	; 0232E822
	mvn r1,r1	; 0232E824
	cmp r0,r1	; 0232E826
	beq loc_0232E88E	; 0232E828
	mvn r1,r7	; 0232E82A
	cmp r0,r1	; 0232E82C
	beq loc_0232E7EA	; 0232E82E
	ldr r2,[sp,#0x0]	; 0232E830
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 0232E832
	lsr r0,r0,#0x1b	; 0232E834
	cmp r0,#0x0	; 0232E836
	beq loc_0232E7EA	; 0232E838
	lsl r3,r0,#0x2	; 0232E83A
	ldr r1,[pool_0232E8AC]	; 0232E83C
	ldr r3,[r1,r3]	; 0232E83E
	cmp r3,#0x0	; 0232E840
	beq loc_0232E84E	; 0232E842
	lsr r1,r2,#0x6	; 0232E844
	lsl r2,r2,#0x1a	; 0232E846
	lsr r2,r2,#0x1f	; 0232E848
	blx r3	; 0232E84A
	b loc_0232E7EA	; 0232E84C
loc_0232E84E:
	lsl r0,r2,#0x1a	; 0232E84E
	lsr r0,r0,#0x1f	; 0232E850
	cmp r0,#0x0	; 0232E852
	bne loc_0232E7EA	; 0232E854
	mov r0,#0x20	; 0232E856
	orr r2,r0	; 0232E858
	str r2,[sp,#0x0]	; 0232E85A
	ldrh r1,[r5,#0x0]	; 0232E85C
	ldr r0,[pool_0232E89C]	; 0232E85E
	and r1,r0	; 0232E860
	cmp r1,#0x0	; 0232E862
	beq loc_0232E870	; 0232E864
	ldrh r1,[r5,#0x0]	; 0232E866
	ldr r0,[pool_0232E8A0]	; 0232E868
	orr r1,r0	; 0232E86A
	strh r1,[r5,#0x0]	; 0232E86C
	b loc_0232E7EA	; 0232E86E
loc_0232E870:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E870
	ldrh r1,[r5,#0x0]	; 0232E874
	and r1,r7	; 0232E876
	cmp r1,#0x0	; 0232E878
	beq loc_0232E882	; 0232E87A
	blx P1_Arm9RestoreIrqMask	; 0232E87C
	b loc_0232E7EA	; 0232E880
loc_0232E882:
	ldr r2,[sp,#0x0]	; 0232E882
	ldr r1,[pool_0232E8B0]	; 0232E884
	str r2,[r1,#0x0]	; 0232E886
	blx P1_Arm9RestoreIrqMask	; 0232E888
	b loc_0232E7EA	; 0232E88C
loc_0232E88E:
	add sp,#0x4	; 0232E88E
	pop {r4,r5,r6,r7}	; 0232E890
	pop {r3}	; 0232E892
	bx r3	; 0232E894
	.byte 0xC0, 0x46	; 0232E898
pool_0232E898:
loc_0232E898:
	.word REG_IPC_FIFO_CR	; 0232E898
pool_0232E89C:
loc_0232E89C:
	.word 0x00004000	; 0232E89C
pool_0232E8A0:
loc_0232E8A0:
	.word 0x0000C000	; 0232E8A0
pool_0232E8A4:
loc_0232E8A4:
	.word 0x00000100	; 0232E8A4
pool_0232E8A8:
loc_0232E8A8:
	.word REG_IPC_FIFO_RX	; 0232E8A8
pool_0232E8AC:
loc_0232E8AC:
	.word P1_PxiReceiveCallbacks	; 0232E8AC
pool_0232E8B0:
loc_0232E8B0:
	.word REG_IPC_FIFO_TX	; 0232E8B0

; ===== function loc_0232E8B4 =====
loc_0232E8B4:
	push {r4,lr}	; 0232E8B4
	sub sp,#0x8	; 0232E8B6
	ldr r3,[sp,#0x0]	; 0232E8B8
	mov r4,#0x1f	; 0232E8BA
	bic r3,r4	; 0232E8BC
	and r0,r4	; 0232E8BE
	orr r3,r0	; 0232E8C0
	str r3,[sp,#0x0]	; 0232E8C2
	mov r0,#0x20	; 0232E8C4
	bic r3,r0	; 0232E8C6
	mov r0,#0x1	; 0232E8C8
	and r2,r0	; 0232E8CA
	lsl r0,r2,#0x5	; 0232E8CC
	orr r3,r0	; 0232E8CE
	str r3,[sp,#0x0]	; 0232E8D0
	mov r0,#0x3f	; 0232E8D2
	and r3,r0	; 0232E8D4
	ldr r0,[pool_0232E934]	; 0232E8D6
	and r1,r0	; 0232E8D8
	lsl r0,r1,#0x6	; 0232E8DA
	orr r3,r0	; 0232E8DC
	str r3,[sp,#0x0]	; 0232E8DE
	ldr r2,[pool_0232E938]	; 0232E8E0
	ldrh r1,[r2,#0x0]	; 0232E8E2
	ldr r0,[pool_0232E93C]	; 0232E8E4
	and r1,r0	; 0232E8E6
	cmp r1,#0x0	; 0232E8E8
	beq loc_0232E900	; 0232E8EA
	ldrh r1,[r2,#0x0]	; 0232E8EC
	ldr r0,[pool_0232E940]	; 0232E8EE
	orr r1,r0	; 0232E8F0
	strh r1,[r2,#0x0]	; 0232E8F2
	mov r0,#0x0	; 0232E8F4
	mvn r0,r0	; 0232E8F6
	add sp,#0x8	; 0232E8F8
	pop {r4}	; 0232E8FA
	pop {r3}	; 0232E8FC
	bx r3	; 0232E8FE
loc_0232E900:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E900
	ldr r1,[pool_0232E938]	; 0232E904
	ldrh r2,[r1,#0x0]	; 0232E906
	mov r1,#0x2	; 0232E908
	and r2,r1	; 0232E90A
	cmp r2,#0x0	; 0232E90C
	beq loc_0232E920	; 0232E90E
	blx P1_Arm9RestoreIrqMask	; 0232E910
	mov r0,#0x1	; 0232E914
	mvn r0,r0	; 0232E916
	add sp,#0x8	; 0232E918
	pop {r4}	; 0232E91A
	pop {r3}	; 0232E91C
	bx r3	; 0232E91E
loc_0232E920:
	ldr r2,[sp,#0x0]	; 0232E920
	ldr r1,[pool_0232E944]	; 0232E922
	str r2,[r1,#0x0]	; 0232E924
	blx P1_Arm9RestoreIrqMask	; 0232E926
	mov r0,#0x0	; 0232E92A
	add sp,#0x8	; 0232E92C
	pop {r4}	; 0232E92E
	pop {r3}	; 0232E930
	bx r3	; 0232E932
pool_0232E934:
loc_0232E934:
	.word 0x03FFFFFF	; 0232E934
pool_0232E938:
loc_0232E938:
	.word REG_IPC_FIFO_CR	; 0232E938
pool_0232E93C:
loc_0232E93C:
	.word 0x00004000	; 0232E93C
pool_0232E940:
loc_0232E940:
	.word 0x0000C000	; 0232E940
pool_0232E944:
loc_0232E944:
	.word REG_IPC_FIFO_TX	; 0232E944

; ===== function loc_0232E948 =====
loc_0232E948:
	push {r4}	; 0232E948
	sub sp,#0x4	; 0232E94A
	mov r3,#0x1	; 0232E94C
	add r2,r3,#0x0	; 0232E94E
	lsl r2,r0	; 0232E950
	ldr r4,[pool_0232E96C]	; 0232E952
	lsl r0,r1,#0x2	; 0232E954
	add r1,r4,r0	; 0232E956
	ldr r0,[pool_0232E970]	; 0232E958
	ldr r0,[r1,r0]	; 0232E95A
	and r2,r0	; 0232E95C
	cmp r2,#0x0	; 0232E95E
	bne loc_0232E964	; 0232E960
	mov r3,#0x0	; 0232E962
loc_0232E964:
	add r0,r3,#0x0	; 0232E964
	add sp,#0x4	; 0232E966
	pop {r4}	; 0232E968
	bx lr	; 0232E96A
pool_0232E96C:
loc_0232E96C:
	.word 0x027FFC00	; 0232E96C
pool_0232E970:
loc_0232E970:
	.word 0x00000388	; 0232E970

; ===== function loc_0232E974 =====
loc_0232E974:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P1_SetPxiReceiveCallback
	push {r4,r5,lr}	; 0232E974
	sub sp,#0x4	; 0232E976
	add r5,r0,#0x0	; 0232E978
	add r4,r1,#0x0	; 0232E97A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E97C
	lsl r2,r5,#0x2	; 0232E980
	ldr r1,[pool_0232E9B8]	; 0232E982
	str r4,[r1,r2]	; 0232E984
	cmp r4,#0x0	; 0232E986
	beq loc_0232E99C	; 0232E988
	ldr r2,[pool_0232E9BC]	; 0232E98A
	ldr r1,[pool_0232E9C0]	; 0232E98C
	add r1,r2,r1	; 0232E98E
	ldr r3,[r1,#0x0]	; 0232E990
	mov r2,#0x1	; 0232E992
	lsl r2,r5	; 0232E994
	orr r3,r2	; 0232E996
	str r3,[r1,#0x0]	; 0232E998
	b loc_0232E9AC	; 0232E99A
loc_0232E99C:
	ldr r2,[pool_0232E9BC]	; 0232E99C
	ldr r1,[pool_0232E9C0]	; 0232E99E
	add r1,r2,r1	; 0232E9A0
	ldr r3,[r1,#0x0]	; 0232E9A2
	mov r2,#0x1	; 0232E9A4
	lsl r2,r5	; 0232E9A6
	bic r3,r2	; 0232E9A8
	str r3,[r1,#0x0]	; 0232E9AA
loc_0232E9AC:
	blx P1_Arm9RestoreIrqMask	; 0232E9AC
	add sp,#0x4	; 0232E9B0
	pop {r4,r5}	; 0232E9B2
	pop {r3}	; 0232E9B4
	bx r3	; 0232E9B6
.endfunc
pool_0232E9B8:
loc_0232E9B8:
	.word P1_PxiReceiveCallbacks	; 0232E9B8
pool_0232E9BC:
loc_0232E9BC:
	.word FirmwareSystemWorkAddress	; 0232E9BC
pool_0232E9C0:
loc_0232E9C0:
	.word SystemWorkPxiArm9AvailableOffset	; 0232E9C0

; ===== function loc_0232E9C4 =====
loc_0232E9C4:
	push {r4,r5,r6,r7,lr}	; 0232E9C4
	sub sp,#0x4	; 0232E9C6
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E9C8
	str r0,[sp,#0x0]	; 0232E9CC
	ldr r0,[pool_0232EA4C]	; 0232E9CE
	ldrh r1,[r0,#0x0]	; 0232E9D0
	cmp r1,#0x0	; 0232E9D2
	bne loc_0232EA3C	; 0232E9D4
	mov r1,#0x1	; 0232E9D6
	strh r1,[r0,#0x0]	; 0232E9D8
	mov r2,#0x0	; 0232E9DA
	ldr r1,[pool_0232EA50]	; 0232E9DC
	ldr r0,[pool_0232EA54]	; 0232E9DE
	str r2,[r1,r0]	; 0232E9E0
	ldr r1,[pool_0232EA58]	; 0232E9E2
	add r0,r2,#0x0	; 0232E9E4
loc_0232E9E6:
	stmia r1!,{r0}	; 0232E9E6
	add r2,r2,#0x1	; 0232E9E8
	cmp r2,#PxiFifoChannelCount	; 0232E9EA
	blt loc_0232E9E6	; 0232E9EC
	ldr r0,[pool_0232EA5C]	; 0232E9EE
	ldr r1,[pool_0232EA60]	; 0232E9F0
	bl loc_0232B1E0	; 0232E9F2
	ldr r0,[pool_0232EA5C]	; 0232E9F6
	bl loc_0232B15C	; 0232E9F8
	ldr r1,[pool_0232EA64]	; 0232E9FC
	ldr r0,[pool_0232EA68]	; 0232E9FE
	strh r1,[r0,#0x0]	; 0232EA00
	mov r1,#0x0	; 0232EA02
	ldr r0,[pool_0232EA6C]	; 0232EA04
	add r6,r1,#0x0	; 0232EA06
	ldr r7,[pool_0232EA70]	; 0232EA08
	mov r4,#0xf	; 0232EA0A
loc_0232EA0C:
	ldrh r2,[r0,#0x0]	; 0232EA0C
	and r2,r4	; 0232EA0E
	lsl r3,r2,#0x8	; 0232EA10
	strh r3,[r0,#0x0]	; 0232EA12
	cmp r2,#0x0	; 0232EA14
	bne loc_0232EA1C	; 0232EA16
	cmp r1,#0x4	; 0232EA18
	bgt loc_0232EA3C	; 0232EA1A
loc_0232EA1C:
	add r3,r7,#0x0	; 0232EA1C
	ldrh r5,[r0,#0x0]	; 0232EA1E
	and r5,r4	; 0232EA20
	cmp r5,r2	; 0232EA22
	bne loc_0232EA38	; 0232EA24
loc_0232EA26:
	cmp r3,#0x0	; 0232EA26
	bgt loc_0232EA2E	; 0232EA28
	add r1,r6,#0x0	; 0232EA2A
	b loc_0232EA38	; 0232EA2C
loc_0232EA2E:
	sub r3,r3,#0x1	; 0232EA2E
	ldrh r5,[r0,#0x0]	; 0232EA30
	and r5,r4	; 0232EA32
	cmp r5,r2	; 0232EA34
	beq loc_0232EA26	; 0232EA36
loc_0232EA38:
	add r1,r1,#0x1	; 0232EA38
	b loc_0232EA0C	; 0232EA3A
loc_0232EA3C:
	ldr r0,[sp,#0x0]	; 0232EA3C
	blx P1_Arm9RestoreIrqMask	; 0232EA3E
	add sp,#0x4	; 0232EA42
	pop {r4,r5,r6,r7}	; 0232EA44
	pop {r3}	; 0232EA46
	bx r3	; 0232EA48
	.byte 0xC0, 0x46	; 0232EA4C
pool_0232EA4C:
loc_0232EA4C:
	.word P1_BssStart + 0x28204	; 0232EA4C
pool_0232EA50:
loc_0232EA50:
	.word FirmwareSystemWorkAddress	; 0232EA50
pool_0232EA54:
loc_0232EA54:
	.word SystemWorkPxiArm9AvailableOffset	; 0232EA54
pool_0232EA58:
loc_0232EA58:
	.word P1_PxiReceiveCallbacks	; 0232EA58
pool_0232EA5C:
loc_0232EA5C:
	.word 0x00040000	; 0232EA5C
pool_0232EA60:
loc_0232EA60:
	.word P1_IrqHandler_0232E7DC + 1	; 0232EA60
pool_0232EA64:
loc_0232EA64:
	.word 0x0000C408	; 0232EA64
pool_0232EA68:
loc_0232EA68:
	.word REG_IPC_FIFO_CR	; 0232EA68
pool_0232EA6C:
loc_0232EA6C:
	.word REG_IPC_SYNC	; 0232EA6C
pool_0232EA70:
loc_0232EA70:
	.word 0x000003E8	; 0232EA70

; ===== function loc_0232EA74 =====
loc_0232EA74:
; 恢复除法/开方操作数及模式。
; Restore division/square-root operands and modes.
.func P1_RestoreArithmeticContext
	ldr r3,[r0,#0x0]	; 0232EA74
	ldr r2,[r0,#0x4]	; 0232EA76
	ldr r1,[pool_0232EAA0]	; 0232EA78
	str r3,[r1,#0x0]	; 0232EA7A
	str r2,[r1,#0x4]	; 0232EA7C
	ldr r3,[r0,#0x8]	; 0232EA7E
	ldr r2,[r0,#0xc]	; 0232EA80
	ldr r1,[pool_0232EAA4]	; 0232EA82
	str r3,[r1,#0x0]	; 0232EA84
	str r2,[r1,#0x4]	; 0232EA86
	ldrh r2,[r0,#0x18]	; 0232EA88
	ldr r1,[pool_0232EAA8]	; 0232EA8A
	strh r2,[r1,#0x0]	; 0232EA8C
	ldr r3,[r0,#0x10]	; 0232EA8E
	ldr r2,[r0,#0x14]	; 0232EA90
	ldr r1,[pool_0232EAAC]	; 0232EA92
	str r3,[r1,#0x0]	; 0232EA94
	str r2,[r1,#0x4]	; 0232EA96
	ldrh r1,[r0,#0x1a]	; 0232EA98
	ldr r0,[pool_0232EAB0]	; 0232EA9A
	strh r1,[r0,#0x0]	; 0232EA9C
	bx lr	; 0232EA9E
.endfunc
pool_0232EAA0:
loc_0232EAA0:
	.word REG_DIV_NUMER	; 0232EAA0
pool_0232EAA4:
loc_0232EAA4:
	.word REG_DIV_DENOM	; 0232EAA4
pool_0232EAA8:
loc_0232EAA8:
	.word REG_DIVCNT	; 0232EAA8
pool_0232EAAC:
loc_0232EAAC:
	.word REG_SQRT_PARAM	; 0232EAAC
pool_0232EAB0:
loc_0232EAB0:
	.word REG_SQRTCNT	; 0232EAB0

; ===== function loc_0232EAB4 =====
loc_0232EAB4:
; 保存除法/开方操作数及模式，不保存结果寄存器。
; Save division/square-root operands and modes, not the result registers.
.func P1_SaveArithmeticContext
	ldr r1,[pool_0232EAE8]	; 0232EAB4
	ldr r2,[r1,#0x0]	; 0232EAB6
	ldr r1,[r1,#0x4]	; 0232EAB8
	str r2,[r0,#0x0]	; 0232EABA
	str r1,[r0,#0x4]	; 0232EABC
	ldr r1,[pool_0232EAEC]	; 0232EABE
	ldr r2,[r1,#0x0]	; 0232EAC0
	ldr r1,[r1,#0x4]	; 0232EAC2
	str r2,[r0,#0x8]	; 0232EAC4
	str r1,[r0,#0xc]	; 0232EAC6
	ldr r1,[pool_0232EAF0]	; 0232EAC8
	ldrh r2,[r1,#0x0]	; 0232EACA
	mov r1,#0x3	; 0232EACC
	and r2,r1	; 0232EACE
	strh r2,[r0,#0x18]	; 0232EAD0
	ldr r1,[pool_0232EAF4]	; 0232EAD2
	ldr r2,[r1,#0x0]	; 0232EAD4
	ldr r1,[r1,#0x4]	; 0232EAD6
	str r2,[r0,#0x10]	; 0232EAD8
	str r1,[r0,#0x14]	; 0232EADA
	ldr r1,[pool_0232EAF8]	; 0232EADC
	ldrh r2,[r1,#0x0]	; 0232EADE
	mov r1,#0x1	; 0232EAE0
	and r2,r1	; 0232EAE2
	strh r2,[r0,#0x1a]	; 0232EAE4
	bx lr	; 0232EAE6
.endfunc
pool_0232EAE8:
loc_0232EAE8:
	.word REG_DIV_NUMER	; 0232EAE8
pool_0232EAEC:
loc_0232EAEC:
	.word REG_DIV_DENOM	; 0232EAEC
pool_0232EAF0:
loc_0232EAF0:
	.word REG_DIVCNT	; 0232EAF0
pool_0232EAF4:
loc_0232EAF4:
	.word REG_SQRT_PARAM	; 0232EAF4
pool_0232EAF8:
loc_0232EAF8:
	.word REG_SQRTCNT	; 0232EAF8

; ===== function loc_0232EAFC =====
loc_0232EAFC:
	ldr r1,[pool_0232EB08]	; 0232EAFC
loc_0232EAFE:
	ldrh r2,[r1,#0x36]	; 0232EAFE
	and r2,r0	; 0232EB00
	cmp r2,#0x0	; 0232EB02
	bne loc_0232EAFE	; 0232EB04
	bx lr	; 0232EB06
pool_0232EB08:
loc_0232EB08:
	.word P1_BssStart + 0x2828C	; 0232EB08

; ===== function loc_0232EB0C =====
loc_0232EB0C:
	push {r4,r5,r6,r7,lr}	; 0232EB0C
	sub sp,#0x4	; 0232EB0E
	add r5,r0,#0x0	; 0232EB10
	add r4,r1,#0x0	; 0232EB12
	ldr r0,[pool_0232EBCC]	; 0232EB14
	ldrh r0,[r0,#0x30]	; 0232EB16
	cmp r0,#0x0	; 0232EB18
	bne loc_0232EB34	; 0232EB1A
	ldrh r0,[r4,#0x0]	; 0232EB1C
	strh r0,[r5,#0x0]	; 0232EB1E
	ldrh r0,[r4,#0x2]	; 0232EB20
	strh r0,[r5,#0x2]	; 0232EB22
	ldrh r0,[r4,#0x4]	; 0232EB24
	strh r0,[r5,#0x4]	; 0232EB26
	ldrh r0,[r4,#0x6]	; 0232EB28
	strh r0,[r5,#0x6]	; 0232EB2A
	add sp,#0x4	; 0232EB2C
	pop {r4,r5,r6,r7}	; 0232EB2E
	pop {r3}	; 0232EB30
	bx r3	; 0232EB32
loc_0232EB34:
	ldrh r0,[r4,#0x4]	; 0232EB34
	strh r0,[r5,#0x4]	; 0232EB36
	ldrh r0,[r4,#0x6]	; 0232EB38
	strh r0,[r5,#0x6]	; 0232EB3A
	ldrh r0,[r4,#0x4]	; 0232EB3C
	cmp r0,#0x0	; 0232EB3E
	bne loc_0232EB50	; 0232EB40
	mov r0,#0x0	; 0232EB42
	strh r0,[r5,#0x0]	; 0232EB44
	strh r0,[r5,#0x2]	; 0232EB46
	add sp,#0x4	; 0232EB48
	pop {r4,r5,r6,r7}	; 0232EB4A
	pop {r3}	; 0232EB4C
	bx r3	; 0232EB4E
loc_0232EB50:
	ldr r0,[pool_0232EBD0]	; 0232EB50
	ldr r0,[r0,#0x8]	; 0232EB52
	asr r1,r0,#0x1f	; 0232EB54
	ldrh r2,[r4,#0x0]	; 0232EB56
	lsl r6,r2,#0x2	; 0232EB58
	asr r3,r6,#0x1f	; 0232EB5A
	ldr r2,[pool_0232EBD0]	; 0232EB5C
	ldr r2,[r2,#0x0]	; 0232EB5E
	asr r7,r2,#0x1f	; 0232EB60
	sub r2,r6,r2	; 0232EB62
	sbc r3,r7	; 0232EB64
	blx P1_AeabiLmul	; 0232EB66
	lsl r1,r1,#0xa	; 0232EB6A
	lsr r0,r0,#0x16	; 0232EB6C
	orr r0,r1	; 0232EB6E
	strh r0,[r5,#0x0]	; 0232EB70
	mov r0,#0x0	; 0232EB72
	ldrsh r1,[r5,r0]	; 0232EB74
	cmp r1,#0x0	; 0232EB76
	bge loc_0232EB7E	; 0232EB78
	strh r0,[r5,#0x0]	; 0232EB7A
	b loc_0232EB86	; 0232EB7C
loc_0232EB7E:
	cmp r1,#0xff	; 0232EB7E
	ble loc_0232EB86	; 0232EB80
	mov r0,#0xff	; 0232EB82
	strh r0,[r5,#0x0]	; 0232EB84
loc_0232EB86:
	ldr r0,[pool_0232EBD0]	; 0232EB86
	ldr r0,[r0,#0x14]	; 0232EB88
	asr r1,r0,#0x1f	; 0232EB8A
	ldrh r2,[r4,#0x2]	; 0232EB8C
	lsl r2,r2,#0x2	; 0232EB8E
	asr r3,r2,#0x1f	; 0232EB90
	ldr r4,[pool_0232EBD0]	; 0232EB92
	ldr r6,[r4,#0xc]	; 0232EB94
	asr r4,r6,#0x1f	; 0232EB96
	sub r2,r2,r6	; 0232EB98
	sbc r3,r4	; 0232EB9A
	blx P1_AeabiLmul	; 0232EB9C
	lsl r1,r1,#0xa	; 0232EBA0
	lsr r0,r0,#0x16	; 0232EBA2
	orr r0,r1	; 0232EBA4
	strh r0,[r5,#0x2]	; 0232EBA6
	mov r0,#0x2	; 0232EBA8
	ldrsh r0,[r5,r0]	; 0232EBAA
	cmp r0,#0x0	; 0232EBAC
	bge loc_0232EBBC	; 0232EBAE
	mov r0,#0x0	; 0232EBB0
	strh r0,[r5,#0x2]	; 0232EBB2
	add sp,#0x4	; 0232EBB4
	pop {r4,r5,r6,r7}	; 0232EBB6
	pop {r3}	; 0232EBB8
	bx r3	; 0232EBBA
loc_0232EBBC:
	cmp r0,#0xbf	; 0232EBBC
	ble loc_0232EBC4	; 0232EBBE
	mov r0,#0xbf	; 0232EBC0
	strh r0,[r5,#0x2]	; 0232EBC2
loc_0232EBC4:
	add sp,#0x4	; 0232EBC4
	pop {r4,r5,r6,r7}	; 0232EBC6
	pop {r3}	; 0232EBC8
	bx r3	; 0232EBCA
pool_0232EBCC:
loc_0232EBCC:
	.word P1_BssStart + 0x2828C	; 0232EBCC
pool_0232EBD0:
loc_0232EBD0:
	.word P1_BssStart + 0x282A4	; 0232EBD0

; ===== function loc_0232EBD4 =====
loc_0232EBD4:
	push {r4,r5,r6,r7,lr}	; 0232EBD4
	sub sp,#0x24	; 0232EBD6
	add r5,r0,#0x0	; 0232EBD8
	add r4,r1,#0x0	; 0232EBDA
	add r7,r2,#0x0	; 0232EBDC
	add r6,r3,#0x0	; 0232EBDE
	ldr r2,[pool_0232ED60]	; 0232EBE0
	cmp r4,r2	; 0232EBE2
	bcs loc_0232EBFA	; 0232EBE4
	cmp r7,r2	; 0232EBE6
	bcs loc_0232EBFA	; 0232EBE8
	add r3,sp,#0x28	; 0232EBEA
	ldrh r1,[r3,#0x14]	; 0232EBEC
	cmp r1,r2	; 0232EBEE
	bcs loc_0232EBFA	; 0232EBF0
	ldrh r0,[r3,#0x18]	; 0232EBF2
	str r0,[sp,#0x20]	; 0232EBF4
	cmp r0,r2	; 0232EBF6
	bcc loc_0232EC04	; 0232EBF8
loc_0232EBFA:
	mov r0,#0x1	; 0232EBFA
	add sp,#0x24	; 0232EBFC
	pop {r4,r5,r6,r7}	; 0232EBFE
	pop {r3}	; 0232EC00
	bx r3	; 0232EC02
loc_0232EC04:
	ldr r0,[pool_0232ED64]	; 0232EC04
	cmp r6,r0	; 0232EC06
	bcs loc_0232EC20	; 0232EC08
	ldrh r0,[r3,#0x1c]	; 0232EC0A
	ldr r2,[pool_0232ED64]	; 0232EC0C
	cmp r0,r2	; 0232EC0E
	bcs loc_0232EC20	; 0232EC10
	ldrh r2,[r3,#0x10]	; 0232EC12
	str r2,[sp,#0x1c]	; 0232EC14
	cmp r2,#0xc0	; 0232EC16
	bcs loc_0232EC20	; 0232EC18
	ldrh r2,[r3,#0x20]	; 0232EC1A
	cmp r2,#0xc0	; 0232EC1C
	bcc loc_0232EC2A	; 0232EC1E
loc_0232EC20:
	mov r0,#0x1	; 0232EC20
	add sp,#0x24	; 0232EC22
	pop {r4,r5,r6,r7}	; 0232EC24
	pop {r3}	; 0232EC26
	bx r3	; 0232EC28
loc_0232EC2A:
	cmp r6,r0	; 0232EC2A
	beq loc_0232EC3E	; 0232EC2C
	ldr r0,[sp,#0x1c]	; 0232EC2E
	cmp r0,r2	; 0232EC30
	beq loc_0232EC3E	; 0232EC32
	cmp r4,r1	; 0232EC34
	beq loc_0232EC3E	; 0232EC36
	ldr r0,[sp,#0x20]	; 0232EC38
	cmp r7,r0	; 0232EC3A
	bne loc_0232EC48	; 0232EC3C
loc_0232EC3E:
	mov r0,#0x1	; 0232EC3E
	add sp,#0x24	; 0232EC40
	pop {r4,r5,r6,r7}	; 0232EC42
	pop {r3}	; 0232EC44
	bx r3	; 0232EC46
loc_0232EC48:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EC48
	str r0,[sp,#0x4]	; 0232EC4C
	mov r3,#0x0	; 0232EC4E
	ldr r0,[pool_0232ED68]	; 0232EC50
	strh r3,[r0,#0x0]	; 0232EC52
	add r1,sp,#0x28	; 0232EC54
	ldrh r1,[r1,#0x14]	; 0232EC56
	str r1,[sp,#0xc]	; 0232EC58
	sub r1,r4,r1	; 0232EC5A
	lsl r2,r1,#0x8	; 0232EC5C
	ldr r1,[pool_0232ED6C]	; 0232EC5E
	str r2,[r1,#0x0]	; 0232EC60
	add r1,sp,#0x28	; 0232EC62
	ldrh r1,[r1,#0x1c]	; 0232EC64
	str r1,[sp,#0x8]	; 0232EC66
	sub r1,r6,r1	; 0232EC68
	ldr r2,[pool_0232ED70]	; 0232EC6A
	str r1,[r2,#0x0]	; 0232EC6C
	str r3,[r2,#0x4]	; 0232EC6E
	add r1,sp,#0x28	; 0232EC70
	ldrh r1,[r1,#0x18]	; 0232EC72
	str r1,[sp,#0x18]	; 0232EC74
	sub r3,r7,r1	; 0232EC76
	add r1,sp,#0x28	; 0232EC78
	ldrh r1,[r1,#0x20]	; 0232EC7A
	str r1,[sp,#0x10]	; 0232EC7C
	add r1,sp,#0x28	; 0232EC7E
	ldrh r2,[r1,#0x10]	; 0232EC80
	str r2,[sp,#0x14]	; 0232EC82
	ldr r1,[sp,#0x10]	; 0232EC84
	sub r1,r2,r1	; 0232EC86
	str r1,[sp,#0x0]	; 0232EC88
	ldr r1,[pool_0232ED74]	; 0232EC8A
loc_0232EC8C:
	ldrh r2,[r0,#0x0]	; 0232EC8C
	and r2,r1	; 0232EC8E
	cmp r2,#0x0	; 0232EC90
	bne loc_0232EC8C	; 0232EC92
	ldr r1,[pool_0232ED78]	; 0232EC94
	ldr r2,[r1,#0x0]	; 0232EC96
	mov r1,#0x0	; 0232EC98
	strh r1,[r0,#0x0]	; 0232EC9A
	lsl r1,r3,#0x8	; 0232EC9C
	ldr r0,[pool_0232ED6C]	; 0232EC9E
	str r1,[r0,#0x0]	; 0232ECA0
	ldr r0,[pool_0232ED70]	; 0232ECA2
	ldr r1,[sp,#0x0]	; 0232ECA4
	str r1,[r0,#0x0]	; 0232ECA6
	mov r1,#0x0	; 0232ECA8
	str r1,[r0,#0x4]	; 0232ECAA
	ldr r0,[pool_0232ED74]	; 0232ECAC
	cmp r2,r0	; 0232ECAE
	bge loc_0232ECB8	; 0232ECB0
	ldr r1,[pool_0232ED7C]	; 0232ECB2
	cmp r2,r1	; 0232ECB4
	bge loc_0232ECC8	; 0232ECB6
loc_0232ECB8:
	ldr r0,[sp,#0x4]	; 0232ECB8
	blx P1_Arm9RestoreIrqMask	; 0232ECBA
	mov r0,#0x1	; 0232ECBE
	add sp,#0x24	; 0232ECC0
	pop {r4,r5,r6,r7}	; 0232ECC2
	pop {r3}	; 0232ECC4
	bx r3	; 0232ECC6
loc_0232ECC8:
	strh r2,[r5,#0x4]	; 0232ECC8
	ldr r1,[sp,#0xc]	; 0232ECCA
	add r1,r4,r1	; 0232ECCC
	lsl r2,r1,#0x8	; 0232ECCE
	mov r1,#0x4	; 0232ECD0
	ldrsh r1,[r5,r1]	; 0232ECD2
	ldr r3,[sp,#0x8]	; 0232ECD4
	add r3,r6,r3	; 0232ECD6
	mul r1,r3	; 0232ECD8
	sub r1,r2,r1	; 0232ECDA
	lsl r1,r1,#0x9	; 0232ECDC
	asr r2,r1,#0x10	; 0232ECDE
	cmp r2,r0	; 0232ECE0
	bge loc_0232ECEA	; 0232ECE2
	ldr r1,[pool_0232ED7C]	; 0232ECE4
	cmp r2,r1	; 0232ECE6
	bge loc_0232ECFA	; 0232ECE8
loc_0232ECEA:
	ldr r0,[sp,#0x4]	; 0232ECEA
	blx P1_Arm9RestoreIrqMask	; 0232ECEC
	mov r0,#0x1	; 0232ECF0
	add sp,#0x24	; 0232ECF2
	pop {r4,r5,r6,r7}	; 0232ECF4
	pop {r3}	; 0232ECF6
	bx r3	; 0232ECF8
loc_0232ECFA:
	strh r2,[r5,#0x0]	; 0232ECFA
	ldr r1,[pool_0232ED68]	; 0232ECFC
loc_0232ECFE:
	ldrh r2,[r1,#0x0]	; 0232ECFE
	and r2,r0	; 0232ED00
	cmp r2,#0x0	; 0232ED02
	bne loc_0232ECFE	; 0232ED04
	ldr r0,[pool_0232ED78]	; 0232ED06
	ldr r4,[r0,#0x0]	; 0232ED08
	ldr r0,[sp,#0x4]	; 0232ED0A
	blx P1_Arm9RestoreIrqMask	; 0232ED0C
	ldr r1,[pool_0232ED74]	; 0232ED10
	cmp r4,r1	; 0232ED12
	bge loc_0232ED1C	; 0232ED14
	ldr r0,[pool_0232ED7C]	; 0232ED16
	cmp r4,r0	; 0232ED18
	bge loc_0232ED26	; 0232ED1A
loc_0232ED1C:
	mov r0,#0x1	; 0232ED1C
	add sp,#0x24	; 0232ED1E
	pop {r4,r5,r6,r7}	; 0232ED20
	pop {r3}	; 0232ED22
	bx r3	; 0232ED24
loc_0232ED26:
	strh r4,[r5,#0x6]	; 0232ED26
	ldr r2,[sp,#0x18]	; 0232ED28
	add r2,r7,r2	; 0232ED2A
	lsl r3,r2,#0x8	; 0232ED2C
	mov r2,#0x6	; 0232ED2E
	ldrsh r2,[r5,r2]	; 0232ED30
	ldr r6,[sp,#0x14]	; 0232ED32
	ldr r4,[sp,#0x10]	; 0232ED34
	add r4,r6,r4	; 0232ED36
	mul r2,r4	; 0232ED38
	sub r2,r3,r2	; 0232ED3A
	lsl r2,r2,#0x9	; 0232ED3C
	asr r2,r2,#0x10	; 0232ED3E
	cmp r2,r1	; 0232ED40
	bge loc_0232ED48	; 0232ED42
	cmp r2,r0	; 0232ED44
	bge loc_0232ED52	; 0232ED46
loc_0232ED48:
	mov r0,#0x1	; 0232ED48
	add sp,#0x24	; 0232ED4A
	pop {r4,r5,r6,r7}	; 0232ED4C
	pop {r3}	; 0232ED4E
	bx r3	; 0232ED50
loc_0232ED52:
	strh r2,[r5,#0x2]	; 0232ED52
	mov r0,#0x0	; 0232ED54
	add sp,#0x24	; 0232ED56
	pop {r4,r5,r6,r7}	; 0232ED58
	pop {r3}	; 0232ED5A
	bx r3	; 0232ED5C
	.byte 0xC0, 0x46	; 0232ED60
pool_0232ED60:
loc_0232ED60:
	.word 0x00001000	; 0232ED60
pool_0232ED64:
loc_0232ED64:
	.word 0x00000100	; 0232ED64
pool_0232ED68:
loc_0232ED68:
	.word REG_DIVCNT	; 0232ED68
pool_0232ED6C:
loc_0232ED6C:
	.word REG_DIV_NUMER	; 0232ED6C
pool_0232ED70:
loc_0232ED70:
	.word REG_DIV_DENOM	; 0232ED70
pool_0232ED74:
loc_0232ED74:
	.word 0x00008000	; 0232ED74
pool_0232ED78:
loc_0232ED78:
	.word REG_DIV_RESULT	; 0232ED78
pool_0232ED7C:
loc_0232ED7C:
	.word 0xFFFF8000	; 0232ED7C

; ===== function loc_0232ED80 =====
loc_0232ED80:
	push {r4,lr}	; 0232ED80
	add r4,r0,#0x0	; 0232ED82
	mov r0,#0x1	; 0232ED84
	bl loc_0232EAFC	; 0232ED86
	ldr r1,[pool_0232EDB0]	; 0232ED8A
	ldrh r2,[r1,#0x34]	; 0232ED8C
	mov r0,#0x1	; 0232ED8E
	and r2,r0	; 0232ED90
	cmp r2,#0x0	; 0232ED92
	bne loc_0232EDA8	; 0232ED94
	ldrh r0,[r1,#0x4]	; 0232ED96
	strh r0,[r4,#0x0]	; 0232ED98
	ldrh r0,[r1,#0x6]	; 0232ED9A
	strh r0,[r4,#0x2]	; 0232ED9C
	ldrh r0,[r1,#0x8]	; 0232ED9E
	strh r0,[r4,#0x4]	; 0232EDA0
	ldrh r0,[r1,#0xa]	; 0232EDA2
	strh r0,[r4,#0x6]	; 0232EDA4
	mov r0,#0x0	; 0232EDA6
loc_0232EDA8:
	pop {r4}	; 0232EDA8
	pop {r3}	; 0232EDAA
	bx r3	; 0232EDAC
	.byte 0xC0, 0x46	; 0232EDB0
pool_0232EDB0:
loc_0232EDB0:
	.word P1_BssStart + 0x2828C	; 0232EDB0

; ===== function loc_0232EDB4 =====
loc_0232EDB4:
	push {r4,lr}	; 0232EDB4
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EDB6
	add r4,r0,#0x0	; 0232EDBA
	mov r0,#0x6	; 0232EDBC
	ldr r1,[pool_0232EE14]	; 0232EDBE
	mov r2,#0x0	; 0232EDC0
	bl loc_0232E8B4	; 0232EDC2
	cmp r0,#0x0	; 0232EDC6
	blt loc_0232EDCE	; 0232EDC8
	mov r0,#0x1	; 0232EDCA
	b loc_0232EDD0	; 0232EDCC
loc_0232EDCE:
	mov r0,#0x0	; 0232EDCE
loc_0232EDD0:
	cmp r0,#0x0	; 0232EDD0
	bne loc_0232EDF8	; 0232EDD2
	add r0,r4,#0x0	; 0232EDD4
	blx P1_Arm9RestoreIrqMask	; 0232EDD6
	ldr r1,[pool_0232EE18]	; 0232EDDA
	ldrh r2,[r1,#0x34]	; 0232EDDC
	mov r0,#0x1	; 0232EDDE
	orr r2,r0	; 0232EDE0
	strh r2,[r1,#0x34]	; 0232EDE2
	ldr r3,[r1,#0x0]	; 0232EDE4
	cmp r3,#0x0	; 0232EDE6
	beq loc_0232EE0E	; 0232EDE8
	mov r0,#0x0	; 0232EDEA
	mov r1,#0x4	; 0232EDEC
	add r2,r0,#0x0	; 0232EDEE
	blx r3	; 0232EDF0
	pop {r4}	; 0232EDF2
	pop {r3}	; 0232EDF4
	bx r3	; 0232EDF6
loc_0232EDF8:
	ldr r1,[pool_0232EE18]	; 0232EDF8
	ldrh r2,[r1,#0x36]	; 0232EDFA
	mov r0,#0x1	; 0232EDFC
	orr r2,r0	; 0232EDFE
	strh r2,[r1,#0x36]	; 0232EE00
	ldrh r2,[r1,#0x34]	; 0232EE02
	bic r2,r0	; 0232EE04
	strh r2,[r1,#0x34]	; 0232EE06
	add r0,r4,#0x0	; 0232EE08
	blx P1_Arm9RestoreIrqMask	; 0232EE0A
loc_0232EE0E:
	pop {r4}	; 0232EE0E
	pop {r3}	; 0232EE10
	bx r3	; 0232EE12
pool_0232EE14:
loc_0232EE14:
	.word P1_DtcmRuntimeStart	; 0232EE14
pool_0232EE18:
loc_0232EE18:
	.word P1_BssStart + 0x2828C	; 0232EE18

; ===== function loc_0232EE1C =====
loc_0232EE1C:
	push {r4,r5,r6,r7,lr}	; 0232EE1C
	sub sp,#0x4	; 0232EE1E
	add r4,r0,#0x0	; 0232EE20
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EE22
	add r6,r0,#0x0	; 0232EE26
	mov r7,#0x4	; 0232EE28
	ldrsh r5,[r4,r7]	; 0232EE2A
	mov r3,#0x0	; 0232EE2C
	ldr r2,[pool_0232EEA0]	; 0232EE2E
	strh r3,[r2,#0x0]	; 0232EE30
	ldr r1,[pool_0232EEA4]	; 0232EE32
	ldr r0,[pool_0232EEA8]	; 0232EE34
	str r1,[r0,#0x0]	; 0232EE36
	ldr r0,[pool_0232EEAC]	; 0232EE38
	str r5,[r0,#0x0]	; 0232EE3A
	str r3,[r0,#0x4]	; 0232EE3C
	ldrsh r1,[r4,r3]	; 0232EE3E
	ldr r0,[pool_0232EEB0]	; 0232EE40
	str r1,[r0,#0x18]	; 0232EE42
	ldrsh r1,[r4,r7]	; 0232EE44
	str r1,[r0,#0x1c]	; 0232EE46
	ldr r0,[pool_0232EEB4]	; 0232EE48
loc_0232EE4A:
	ldrh r1,[r2,#0x0]	; 0232EE4A
	and r1,r0	; 0232EE4C
	cmp r1,#0x0	; 0232EE4E
	bne loc_0232EE4A	; 0232EE50
	ldr r0,[pool_0232EEB8]	; 0232EE52
	ldr r0,[r0,#0x0]	; 0232EE54
	ldr r3,[pool_0232EEB0]	; 0232EE56
	str r0,[r3,#0x20]	; 0232EE58
	mov r7,#0x6	; 0232EE5A
	ldrsh r1,[r4,r7]	; 0232EE5C
	mov r0,#0x0	; 0232EE5E
	strh r0,[r2,#0x0]	; 0232EE60
	ldr r5,[pool_0232EEA4]	; 0232EE62
	ldr r2,[pool_0232EEA8]	; 0232EE64
	str r5,[r2,#0x0]	; 0232EE66
	ldr r2,[pool_0232EEAC]	; 0232EE68
	str r1,[r2,#0x0]	; 0232EE6A
	str r0,[r2,#0x4]	; 0232EE6C
	mov r0,#0x2	; 0232EE6E
	ldrsh r0,[r4,r0]	; 0232EE70
	str r0,[r3,#0x24]	; 0232EE72
	ldrsh r0,[r4,r7]	; 0232EE74
	str r0,[r3,#0x28]	; 0232EE76
	ldr r1,[pool_0232EEA0]	; 0232EE78
	ldr r0,[pool_0232EEB4]	; 0232EE7A
loc_0232EE7C:
	ldrh r2,[r1,#0x0]	; 0232EE7C
	and r2,r0	; 0232EE7E
	cmp r2,#0x0	; 0232EE80
	bne loc_0232EE7C	; 0232EE82
	ldr r0,[pool_0232EEB8]	; 0232EE84
	ldr r1,[r0,#0x0]	; 0232EE86
	ldr r0,[pool_0232EEB0]	; 0232EE88
	str r1,[r0,#0x2c]	; 0232EE8A
	add r0,r6,#0x0	; 0232EE8C
	blx P1_Arm9RestoreIrqMask	; 0232EE8E
	mov r1,#0x1	; 0232EE92
	ldr r0,[pool_0232EEB0]	; 0232EE94
	strh r1,[r0,#0x30]	; 0232EE96
	add sp,#0x4	; 0232EE98
	pop {r4,r5,r6,r7}	; 0232EE9A
	pop {r3}	; 0232EE9C
	bx r3	; 0232EE9E
pool_0232EEA0:
loc_0232EEA0:
	.word REG_DIVCNT	; 0232EEA0
pool_0232EEA4:
loc_0232EEA4:
	.word 0x10000000	; 0232EEA4
pool_0232EEA8:
loc_0232EEA8:
	.word REG_DIV_NUMER	; 0232EEA8
pool_0232EEAC:
loc_0232EEAC:
	.word REG_DIV_DENOM	; 0232EEAC
pool_0232EEB0:
loc_0232EEB0:
	.word P1_BssStart + 0x2828C	; 0232EEB0
pool_0232EEB4:
loc_0232EEB4:
	.word 0x00008000	; 0232EEB4
pool_0232EEB8:
loc_0232EEB8:
	.word REG_DIV_RESULT	; 0232EEB8

; ===== function loc_0232EEBC =====
loc_0232EEBC:
	push {r4,r5,lr}	; 0232EEBC
	sub sp,#0x4	; 0232EEBE
	ldr r0,[pool_0232EF04]	; 0232EEC0
	ldrh r1,[r0,#0x0]	; 0232EEC2
	cmp r1,#0x0	; 0232EEC4
	bne loc_0232EEFA	; 0232EEC6
	mov r1,#0x1	; 0232EEC8
	strh r1,[r0,#0x0]	; 0232EECA
	bl loc_0232E7D4	; 0232EECC
	mov r1,#0x0	; 0232EED0
	ldr r0,[pool_0232EF08]	; 0232EED2
	strh r1,[r0,#0xc]	; 0232EED4
	str r1,[r0,#0x0]	; 0232EED6
	str r1,[r0,#0x10]	; 0232EED8
	strh r1,[r0,#0x32]	; 0232EEDA
	strh r1,[r0,#0x30]	; 0232EEDC
	strh r1,[r0,#0x36]	; 0232EEDE
	strh r1,[r0,#0x34]	; 0232EEE0
	mov r5,#0x6	; 0232EEE2
	mov r4,#0x1	; 0232EEE4
loc_0232EEE6:
	add r0,r5,#0x0	; 0232EEE6
	add r1,r4,#0x0	; 0232EEE8
	bl loc_0232E948	; 0232EEEA
	cmp r0,#0x0	; 0232EEEE
	beq loc_0232EEE6	; 0232EEF0
	mov r0,#0x6	; 0232EEF2
	ldr r1,[pool_0232EF0C]	; 0232EEF4
	bl P1_SetPxiReceiveCallback	; 0232EEF6
loc_0232EEFA:
	add sp,#0x4	; 0232EEFA
	pop {r4,r5}	; 0232EEFC
	pop {r3}	; 0232EEFE
	bx r3	; 0232EF00
	.byte 0xC0, 0x46	; 0232EF04
pool_0232EF04:
loc_0232EF04:
	.word P1_BssStart + 0x28288	; 0232EF04
pool_0232EF08:
loc_0232EF08:
	.word P1_BssStart + 0x2828C	; 0232EF08
pool_0232EF0C:
loc_0232EF0C:
	.word P1_PxiCallback_0232EF10 + 1	; 0232EF0C

; ===== function loc_0232EF10 =====
P1_PxiCallback_0232EF10:
	push {r4,lr}	; 0232EF10
	sub sp,#0x8	; 0232EF12
	lsl r0,r1,#0x10	; 0232EF14
	lsr r3,r0,#0x10	; 0232EF16
	ldr r0,[pool_0232F004]	; 0232EF18
	add r4,r3,#0x0	; 0232EF1A
	and r4,r0	; 0232EF1C
	lsl r0,r4,#0x8	; 0232EF1E
	lsr r0,r0,#0x10	; 0232EF20
	cmp r2,#0x0	; 0232EF22
	beq loc_0232EF46	; 0232EF24
	ldr r1,[pool_0232F008]	; 0232EF26
	ldrh r3,[r1,#0x34]	; 0232EF28
	mov r2,#0x1	; 0232EF2A
	lsl r2,r0	; 0232EF2C
	orr r3,r2	; 0232EF2E
	strh r3,[r1,#0x34]	; 0232EF30
	ldr r3,[r1,#0x0]	; 0232EF32
	cmp r3,#0x0	; 0232EF34
	beq loc_0232EFFC	; 0232EF36
	mov r1,#0x4	; 0232EF38
	mov r2,#0x0	; 0232EF3A
	blx r3	; 0232EF3C
	add sp,#0x8	; 0232EF3E
	pop {r4}	; 0232EF40
	pop {r3}	; 0232EF42
	bx r3	; 0232EF44
loc_0232EF46:
	ldr r2,[pool_0232F00C]	; 0232EF46
	and r1,r2	; 0232EF48
	cmp r1,#0x0	; 0232EF4A
	beq loc_0232EFFC	; 0232EF4C
	lsl r1,r3,#0x18	; 0232EF4E
	lsr r1,r1,#0x18	; 0232EF50
	cmp r1,#0x4	; 0232EF52
	bhi loc_0232EFF8	; 0232EF54
	add r1,r1,r1	; 0232EF56
P1_SwitchIndexPC_0232EF56:
	add r1,pc	; 0232EF58
	ldrh r1,[r1,#(P1_SwitchTable_0232EF56 - (P1_SwitchIndexPC_0232EF56 + 4))]	; 0232EF5A
	lsl r1,r1,#0x10	; 0232EF5C
	asr r1,r1,#0x10	; 0232EF5E
P1_SwitchTargetPC_0232EF56:
	add r1,pc	; 0232EF60
	bx r1	; 0232EF62
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232EF56:
	.halfword (loc_0232EF6E + 1) - (P1_SwitchTargetPC_0232EF56 + 4)
	.halfword (loc_0232EFF8 + 1) - (P1_SwitchTargetPC_0232EF56 + 4)
	.halfword (loc_0232EFCA + 1) - (P1_SwitchTargetPC_0232EF56 + 4)
	.halfword (loc_0232EFCE + 1) - (P1_SwitchTargetPC_0232EF56 + 4)
	.halfword (loc_0232EFC6 + 1) - (P1_SwitchTargetPC_0232EF56 + 4)
P1_SwitchTable_0232EF56End:
loc_0232EF6E:
	cmp r0,#0x0	; 0232EF6E
	bne loc_0232EFA4	; 0232EF70
	ldr r1,[pool_0232F010]	; 0232EF72
	ldrh r2,[r1,#0x0]	; 0232EF74
	add r1,sp,#0x0	; 0232EF76
	strh r2,[r1,#0x0]	; 0232EF78
	ldr r2,[pool_0232F014]	; 0232EF7A
	ldrh r2,[r2,#0x0]	; 0232EF7C
	strh r2,[r1,#0x2]	; 0232EF7E
	ldr r1,[sp,#0x0]	; 0232EF80
	lsl r2,r1,#0x14	; 0232EF82
	lsr r2,r2,#0x14	; 0232EF84
	ldr r3,[pool_0232F008]	; 0232EF86
	strh r2,[r3,#0x4]	; 0232EF88
	lsl r2,r1,#0x8	; 0232EF8A
	lsr r2,r2,#0x14	; 0232EF8C
	strh r2,[r3,#0x6]	; 0232EF8E
	lsl r2,r1,#0x7	; 0232EF90
	lsr r2,r2,#0x1f	; 0232EF92
	lsl r2,r2,#0x18	; 0232EF94
	lsr r2,r2,#0x18	; 0232EF96
	strh r2,[r3,#0x8]	; 0232EF98
	lsl r1,r1,#0x5	; 0232EF9A
	lsr r1,r1,#0x1e	; 0232EF9C
	lsl r1,r1,#0x18	; 0232EF9E
	lsr r1,r1,#0x18	; 0232EFA0
	strh r1,[r3,#0xa]	; 0232EFA2
loc_0232EFA4:
	mov r1,#0x0	; 0232EFA4
	ldr r2,[pool_0232F008]	; 0232EFA6
	strh r1,[r2,#0x32]	; 0232EFA8
	ldrh r4,[r2,#0x36]	; 0232EFAA
	mov r3,#0x1	; 0232EFAC
	lsl r3,r0	; 0232EFAE
	bic r4,r3	; 0232EFB0
	strh r4,[r2,#0x36]	; 0232EFB2
	ldr r3,[r2,#0x0]	; 0232EFB4
	cmp r3,#0x0	; 0232EFB6
	beq loc_0232EFFC	; 0232EFB8
	add r2,r1,#0x0	; 0232EFBA
	blx r3	; 0232EFBC
	add sp,#0x8	; 0232EFBE
	pop {r4}	; 0232EFC0
	pop {r3}	; 0232EFC2
	bx r3	; 0232EFC4
loc_0232EFC6:
	mov r1,#0x3	; 0232EFC6
	b loc_0232EFD0	; 0232EFC8
loc_0232EFCA:
	mov r1,#0x1	; 0232EFCA
	b loc_0232EFD0	; 0232EFCC
loc_0232EFCE:
	mov r1,#0x2	; 0232EFCE
loc_0232EFD0:
	mov r4,#0x1	; 0232EFD0
	lsl r4,r0	; 0232EFD2
	ldr r2,[pool_0232F008]	; 0232EFD4
	ldrh r3,[r2,#0x34]	; 0232EFD6
	orr r3,r4	; 0232EFD8
	strh r3,[r2,#0x34]	; 0232EFDA
	ldrh r3,[r2,#0x36]	; 0232EFDC
	bic r3,r4	; 0232EFDE
	strh r3,[r2,#0x36]	; 0232EFE0
	ldr r3,[r2,#0x0]	; 0232EFE2
	cmp r3,#0x0	; 0232EFE4
	beq loc_0232EFFC	; 0232EFE6
	mov r2,#0xff	; 0232EFE8
	and r1,r2	; 0232EFEA
	mov r2,#0x0	; 0232EFEC
	blx r3	; 0232EFEE
	add sp,#0x8	; 0232EFF0
	pop {r4}	; 0232EFF2
	pop {r3}	; 0232EFF4
	bx r3	; 0232EFF6
loc_0232EFF8:
	bl loc_0232C528	; 0232EFF8
loc_0232EFFC:
	add sp,#0x8	; 0232EFFC
	pop {r4}	; 0232EFFE
	pop {r3}	; 0232F000
	bx r3	; 0232F002
pool_0232F004:
loc_0232F004:
	.word 0x00007F00	; 0232F004
pool_0232F008:
loc_0232F008:
	.word P1_BssStart + 0x2828C	; 0232F008
pool_0232F00C:
loc_0232F00C:
	.word 0x01000000	; 0232F00C
pool_0232F010:
loc_0232F010:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 0232F010
pool_0232F014:
loc_0232F014:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 0232F014

; ===== function loc_0232F018 =====
loc_0232F018:
	push {r4,lr}	; 0232F018
	cmp r0,#0x0	; 0232F01A
	beq loc_0232F05E	; 0232F01C
	cmp r0,#0x1	; 0232F01E
	bne loc_0232F086	; 0232F020
	cmp r2,#0x0	; 0232F022
	bne loc_0232F03C	; 0232F024
	ldr r0,[pool_0232F090]	; 0232F026
	ldr r2,[r0,#0x0]	; 0232F028
	ldr r0,[pool_0232F094]	; 0232F02A
	ldr r0,[r0,#0x0]	; 0232F02C
	sub r0,r2,r0	; 0232F02E
	cmp r0,#0x7	; 0232F030
	bhi loc_0232F03C	; 0232F032
	mov r0,#0x0	; 0232F034
	pop {r4}	; 0232F036
	pop {r3}	; 0232F038
	bx r3	; 0232F03A
loc_0232F03C:
	cmp r3,#0x0	; 0232F03C
	beq loc_0232F048	; 0232F03E
	add r0,r1,#0x0	; 0232F040
	bl loc_0232F254	; 0232F042
	b loc_0232F052	; 0232F046
loc_0232F048:
	add r0,r1,#0x0	; 0232F048
	mov r1,#0x0	; 0232F04A
	add r2,r1,#0x0	; 0232F04C
	bl loc_0232F274	; 0232F04E
loc_0232F052:
	ldr r2,[pool_0232F098]	; 0232F052
	ldrh r1,[r2,#0x0]	; 0232F054
	mov r0,#0x1	; 0232F056
	orr r1,r0	; 0232F058
	strh r1,[r2,#0x0]	; 0232F05A
	b loc_0232F086	; 0232F05C
loc_0232F05E:
	ldr r4,[pool_0232F098]	; 0232F05E
	ldrh r2,[r4,#0x0]	; 0232F060
	mov r0,#0x1	; 0232F062
	bic r2,r0	; 0232F064
	strh r2,[r4,#0x0]	; 0232F066
	ldr r0,[pool_0232F090]	; 0232F068
	ldr r2,[r0,#0x0]	; 0232F06A
	ldr r0,[pool_0232F094]	; 0232F06C
	str r2,[r0,#0x0]	; 0232F06E
	cmp r3,#0x0	; 0232F070
	beq loc_0232F07C	; 0232F072
	add r0,r1,#0x0	; 0232F074
	bl loc_0232F254	; 0232F076
	b loc_0232F086	; 0232F07A
loc_0232F07C:
	add r0,r1,#0x0	; 0232F07C
	mov r1,#0x0	; 0232F07E
	add r2,r1,#0x0	; 0232F080
	bl loc_0232F274	; 0232F082
loc_0232F086:
	mov r0,#0x1	; 0232F086
	pop {r4}	; 0232F088
	pop {r3}	; 0232F08A
	bx r3	; 0232F08C
	.byte 0xC0, 0x46	; 0232F090
pool_0232F090:
loc_0232F090:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232F090
pool_0232F094:
loc_0232F094:
	.word P1_BssStart + 0x282D0	; 0232F094
pool_0232F098:
loc_0232F098:
	.word REG_POWERCNT	; 0232F098

; ===== function loc_0232F09C =====
loc_0232F09C:
	push {r4,r5,r6,r7,lr}	; 0232F09C
	sub sp,#0xc	; 0232F09E
	add r5,r0,#0x0	; 0232F0A0
	add r4,r1,#0x0	; 0232F0A2
	str r2,[sp,#0x0]	; 0232F0A4
	mov r6,#0x0	; 0232F0A6
	ldr r0,[pool_0232F150]	; 0232F0A8
	ldrh r7,[r0,#0x0]	; 0232F0AA
	strh r6,[r0,#0x0]	; 0232F0AC
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F0AE
	str r0,[sp,#0x4]	; 0232F0B2
	ldr r0,[pool_0232F154]	; 0232F0B4
	bl loc_0232B134	; 0232F0B6
	str r0,[sp,#0x8]	; 0232F0BA
	ldr r0,[pool_0232F158]	; 0232F0BC
	bl loc_0232B184	; 0232F0BE
	ldr r0,[sp,#0x4]	; 0232F0C2
	blx P1_Arm9RestoreIrqMask	; 0232F0C4
	ldr r1,[pool_0232F150]	; 0232F0C8
	ldrh r0,[r1,#0x0]	; 0232F0CA
	mov r0,#0x1	; 0232F0CC
	strh r0,[r1,#0x0]	; 0232F0CE
	mov r0,#0x10	; 0232F0D0
	add r1,r5,#0x0	; 0232F0D2
	and r1,r0	; 0232F0D4
	cmp r1,#0x0	; 0232F0D6
	beq loc_0232F0E6	; 0232F0D8
	bl loc_0232C610	; 0232F0DA
	cmp r0,#0x0	; 0232F0DE
	bne loc_0232F0E6	; 0232F0E0
	mov r0,#0x10	; 0232F0E2
	bic r5,r0	; 0232F0E4
loc_0232F0E6:
	ldr r0,[sp,#0x0]	; 0232F0E6
	orr r4,r0	; 0232F0E8
loc_0232F0EA:
	lsl r0,r5,#0x10	; 0232F0EA
	lsr r0,r0,#0x10	; 0232F0EC
	lsl r1,r4,#0x10	; 0232F0EE
	lsr r1,r1,#0x10	; 0232F0F0
	bl loc_0232F3F8	; 0232F0F2
	cmp r0,#0x0	; 0232F0F6
	bne loc_0232F0EA	; 0232F0F8
	blx P1_Arm9WaitForInterrupt	; 0232F0FA
	ldr r0,[pool_0232F15C]	; 0232F0FE
	blx P1_Arm9BusyWaitByLoop4	; 0232F100
	mov r0,#0x8	; 0232F104
	and r5,r0	; 0232F106
	cmp r5,#0x0	; 0232F108
	beq loc_0232F11A	; 0232F10A
	ldr r0,[pool_0232F160]	; 0232F10C
	ldr r1,[r0,#0x0]	; 0232F10E
	ldr r0,[pool_0232F164]	; 0232F110
	and r1,r0	; 0232F112
	cmp r1,#0x0	; 0232F114
	beq loc_0232F11A	; 0232F116
	mov r6,#0x1	; 0232F118
loc_0232F11A:
	cmp r6,#0x0	; 0232F11A
	bne loc_0232F12A	; 0232F11C
	mov r0,#0x1	; 0232F11E
	add r1,r0,#0x0	; 0232F120
	add r2,r0,#0x0	; 0232F122
	mov r3,#0x0	; 0232F124
	bl loc_0232F018	; 0232F126
loc_0232F12A:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F12A
	ldr r0,[sp,#0x8]	; 0232F12E
	bl loc_0232B184	; 0232F130
	ldr r0,[sp,#0x4]	; 0232F134
	blx P1_Arm9RestoreIrqMask	; 0232F136
	ldr r1,[pool_0232F150]	; 0232F13A
	ldrh r0,[r1,#0x0]	; 0232F13C
	strh r7,[r1,#0x0]	; 0232F13E
	cmp r6,#0x0	; 0232F140
	beq loc_0232F148	; 0232F142
	bl loc_0232F1AC	; 0232F144
loc_0232F148:
	add sp,#0xc	; 0232F148
	pop {r4,r5,r6,r7}	; 0232F14A
	pop {r3}	; 0232F14C
	bx r3	; 0232F14E
pool_0232F150:
loc_0232F150:
	.word REG_IME	; 0232F150
pool_0232F154:
loc_0232F154:
	.word 0x003FFFFF	; 0232F154
pool_0232F158:
loc_0232F158:
	.word 0x00040000	; 0232F158
pool_0232F15C:
loc_0232F15C:
	.word 0x00332340	; 0232F15C
pool_0232F160:
loc_0232F160:
	.word REG_IF	; 0232F160
pool_0232F164:
loc_0232F164:
	.word 0x00100000	; 0232F164

; ===== function loc_0232F168 =====
loc_0232F168:
	push {r4,r5,r6,lr}	; 0232F168
	add r5,r0,#0x0	; 0232F16A
	mov r4,#0x8	; 0232F16C
	mov r6,#0x0	; 0232F16E
loc_0232F170:
	add r0,r4,#0x0	; 0232F170
	add r1,r5,#0x0	; 0232F172
	add r2,r6,#0x0	; 0232F174
	bl loc_0232E8B4	; 0232F176
	cmp r0,#0x0	; 0232F17A
	bne loc_0232F170	; 0232F17C
	pop {r4,r5,r6}	; 0232F17E
	pop {r3}	; 0232F180
	bx r3	; 0232F182

; ===== function loc_0232F184 =====
loc_0232F184:
	push {r4,lr}	; 0232F184
	sub sp,#0x8	; 0232F186
	add r4,r0,#0x0	; 0232F188
	mov r0,#0x1	; 0232F18A
	add r1,sp,#0x0	; 0232F18C
	bl loc_0232F32C	; 0232F18E
	cmp r0,#0x0	; 0232F192
	bne loc_0232F1A4	; 0232F194
	cmp r4,#0x0	; 0232F196
	beq loc_0232F1A4	; 0232F198
	add r1,sp,#0x0	; 0232F19A
	ldrh r2,[r1,#0x0]	; 0232F19C
	mov r1,#0x1	; 0232F19E
	and r2,r1	; 0232F1A0
	str r2,[r4,#0x0]	; 0232F1A2
loc_0232F1A4:
	add sp,#0x8	; 0232F1A4
	pop {r4}	; 0232F1A6
	pop {r3}	; 0232F1A8
	bx r3	; 0232F1AA

; ===== function loc_0232F1AC =====
loc_0232F1AC:
	push {lr}	; 0232F1AC
	sub sp,#0x4	; 0232F1AE
	ldr r0,[pool_0232F1C8]	; 0232F1B0
	add r1,sp,#0x0	; 0232F1B2
	bl loc_0232F1CC	; 0232F1B4
	cmp r0,#0x0	; 0232F1B8
	bne loc_0232F1C2	; 0232F1BA
	bl loc_0232F5B4	; 0232F1BC
	ldr r0,[sp,#0x0]	; 0232F1C0
loc_0232F1C2:
	add sp,#0x4	; 0232F1C2
	pop {r3}	; 0232F1C4
	bx r3	; 0232F1C6
pool_0232F1C8:
loc_0232F1C8:
	.word 0x0232F5B1	; 0232F1C8

; ===== function loc_0232F1CC =====
loc_0232F1CC:
	add r3,r0,#0x0	; 0232F1CC
	add r2,r1,#0x0	; 0232F1CE
	mov r0,#0xe	; 0232F1D0
	add r1,r3,#0x0	; 0232F1D2
	ldr r3,[pool_0232F1D8]	; 0232F1D4
	bx r3	; 0232F1D6
pool_0232F1D8:
loc_0232F1D8:
	.word loc_0232F3A4 + 1	; 0232F1D8

; ===== function loc_0232F1DC =====
loc_0232F1DC:
	push {lr}	; 0232F1DC
	sub sp,#0x4	; 0232F1DE
	ldr r2,[pool_0232F1F8]	; 0232F1E0
	add r3,sp,#0x0	; 0232F1E2
	bl loc_0232F1FC	; 0232F1E4
	cmp r0,#0x0	; 0232F1E8
	bne loc_0232F1F2	; 0232F1EA
	bl loc_0232F5B4	; 0232F1EC
	ldr r0,[sp,#0x0]	; 0232F1F0
loc_0232F1F2:
	add sp,#0x4	; 0232F1F2
	pop {r3}	; 0232F1F4
	bx r3	; 0232F1F6
pool_0232F1F8:
loc_0232F1F8:
	.word 0x0232F5B1	; 0232F1F8

; ===== function loc_0232F1FC =====
loc_0232F1FC:
	push {r4,lr}	; 0232F1FC
	mov r4,#0x0	; 0232F1FE
	cmp r0,#0x0	; 0232F200
	bne loc_0232F212	; 0232F202
	cmp r1,#0x1	; 0232F204
	bne loc_0232F20A	; 0232F206
	mov r4,#0x6	; 0232F208
loc_0232F20A:
	cmp r1,#0x0	; 0232F20A
	bne loc_0232F234	; 0232F20C
	mov r4,#0x7	; 0232F20E
	b loc_0232F234	; 0232F210
loc_0232F212:
	cmp r0,#0x1	; 0232F212
	bne loc_0232F224	; 0232F214
	cmp r1,#0x1	; 0232F216
	bne loc_0232F21C	; 0232F218
	mov r4,#0x4	; 0232F21A
loc_0232F21C:
	cmp r1,#0x0	; 0232F21C
	bne loc_0232F234	; 0232F21E
	mov r4,#0x5	; 0232F220
	b loc_0232F234	; 0232F222
loc_0232F224:
	cmp r0,#0x2	; 0232F224
	bne loc_0232F234	; 0232F226
	cmp r1,#0x1	; 0232F228
	bne loc_0232F22E	; 0232F22A
	mov r4,#0x8	; 0232F22C
loc_0232F22E:
	cmp r1,#0x0	; 0232F22E
	bne loc_0232F234	; 0232F230
	mov r4,#0x9	; 0232F232
loc_0232F234:
	cmp r4,#0x0	; 0232F234
	beq loc_0232F248	; 0232F236
	add r0,r4,#0x0	; 0232F238
	add r1,r2,#0x0	; 0232F23A
	add r2,r3,#0x0	; 0232F23C
	bl loc_0232F3A4	; 0232F23E
	pop {r4}	; 0232F242
	pop {r3}	; 0232F244
	bx r3	; 0232F246
loc_0232F248:
	ldr r0,[pool_0232F250]	; 0232F248
	pop {r4}	; 0232F24A
	pop {r3}	; 0232F24C
	bx r3	; 0232F24E
pool_0232F250:
loc_0232F250:
	.word 0x0000FFFF	; 0232F250

; ===== function loc_0232F254 =====
loc_0232F254:
	push {lr}	; 0232F254
	sub sp,#0x4	; 0232F256
	ldr r1,[pool_0232F270]	; 0232F258
	add r2,sp,#0x0	; 0232F25A
	bl loc_0232F274	; 0232F25C
	cmp r0,#0x0	; 0232F260
	bne loc_0232F26A	; 0232F262
	bl loc_0232F5B4	; 0232F264
	ldr r0,[sp,#0x0]	; 0232F268
loc_0232F26A:
	add sp,#0x4	; 0232F26A
	pop {r3}	; 0232F26C
	bx r3	; 0232F26E
pool_0232F270:
loc_0232F270:
	.word 0x0232F5B1	; 0232F270

; ===== function loc_0232F274 =====
loc_0232F274:
	push {lr}	; 0232F274
	sub sp,#0x4	; 0232F276
	cmp r0,#0x1	; 0232F278
	beq loc_0232F286	; 0232F27A
	cmp r0,#0x2	; 0232F27C
	beq loc_0232F28E	; 0232F27E
	cmp r0,#0x3	; 0232F280
	beq loc_0232F28A	; 0232F282
	b loc_0232F292	; 0232F284
loc_0232F286:
	mov r0,#0x1	; 0232F286
	b loc_0232F294	; 0232F288
loc_0232F28A:
	mov r0,#0x2	; 0232F28A
	b loc_0232F294	; 0232F28C
loc_0232F28E:
	mov r0,#0x3	; 0232F28E
	b loc_0232F294	; 0232F290
loc_0232F292:
	mov r0,#0x0	; 0232F292
loc_0232F294:
	cmp r0,#0x0	; 0232F294
	beq loc_0232F2A2	; 0232F296
	bl loc_0232F3A4	; 0232F298
	add sp,#0x4	; 0232F29C
	pop {r3}	; 0232F29E
	bx r3	; 0232F2A0
loc_0232F2A2:
	ldr r0,[pool_0232F2AC]	; 0232F2A2
	add sp,#0x4	; 0232F2A4
	pop {r3}	; 0232F2A6
	bx r3	; 0232F2A8
	.byte 0xC0, 0x46	; 0232F2AC
pool_0232F2AC:
loc_0232F2AC:
	.word 0x0000FFFF	; 0232F2AC

; ===== function loc_0232F2B0 =====
loc_0232F2B0:
	push {lr}	; 0232F2B0
	sub sp,#0x4	; 0232F2B2
	ldr r2,[pool_0232F2CC]	; 0232F2B4
	add r3,sp,#0x0	; 0232F2B6
	bl loc_0232F2D0	; 0232F2B8
	cmp r0,#0x0	; 0232F2BC
	bne loc_0232F2C6	; 0232F2BE
	bl loc_0232F5B4	; 0232F2C0
	ldr r0,[sp,#0x0]	; 0232F2C4
loc_0232F2C6:
	add sp,#0x4	; 0232F2C6
	pop {r3}	; 0232F2C8
	bx r3	; 0232F2CA
pool_0232F2CC:
loc_0232F2CC:
	.word 0x0232F5B1	; 0232F2CC

; ===== function loc_0232F2D0 =====
loc_0232F2D0:
	push {r4,r5,r6,r7,lr}	; 0232F2D0
	sub sp,#0x4	; 0232F2D2
	add r5,r0,#0x0	; 0232F2D4
	add r4,r1,#0x0	; 0232F2D6
	add r6,r2,#0x0	; 0232F2D8
	add r7,r3,#0x0	; 0232F2DA
	bl loc_0232F5C4	; 0232F2DC
	cmp r0,#0x0	; 0232F2E0
	bne loc_0232F2EE	; 0232F2E2
	mov r0,#0x1	; 0232F2E4
	add sp,#0x4	; 0232F2E6
	pop {r4,r5,r6,r7}	; 0232F2E8
	pop {r3}	; 0232F2EA
	bx r3	; 0232F2EC
loc_0232F2EE:
	ldr r0,[pool_0232F31C]	; 0232F2EE
	str r6,[r0,#0x4]	; 0232F2F0
	str r7,[r0,#0x8]	; 0232F2F2
	mov r0,#0xff	; 0232F2F4
	and r5,r0	; 0232F2F6
	ldr r0,[pool_0232F320]	; 0232F2F8
	orr r5,r0	; 0232F2FA
	add r0,r5,#0x0	; 0232F2FC
	bl loc_0232F168	; 0232F2FE
	ldr r0,[pool_0232F324]	; 0232F302
	and r4,r0	; 0232F304
	ldr r0,[pool_0232F328]	; 0232F306
	orr r4,r0	; 0232F308
	add r0,r4,#0x0	; 0232F30A
	bl loc_0232F168	; 0232F30C
	mov r0,#0x0	; 0232F310
	add sp,#0x4	; 0232F312
	pop {r4,r5,r6,r7}	; 0232F314
	pop {r3}	; 0232F316
	bx r3	; 0232F318
	.byte 0xC0, 0x46	; 0232F31C
pool_0232F31C:
loc_0232F31C:
	.word P1_BssStart + 0x282D4	; 0232F31C
pool_0232F320:
loc_0232F320:
	.word 0x02006400	; 0232F320
pool_0232F324:
loc_0232F324:
	.word 0x0000FFFF	; 0232F324
pool_0232F328:
loc_0232F328:
	.word 0x01010000	; 0232F328

; ===== function loc_0232F32C =====
loc_0232F32C:
	push {lr}	; 0232F32C
	sub sp,#0x4	; 0232F32E
	ldr r2,[pool_0232F348]	; 0232F330
	add r3,sp,#0x0	; 0232F332
	bl loc_0232F34C	; 0232F334
	cmp r0,#0x0	; 0232F338
	bne loc_0232F342	; 0232F33A
	bl loc_0232F5B4	; 0232F33C
	ldr r0,[sp,#0x0]	; 0232F340
loc_0232F342:
	add sp,#0x4	; 0232F342
	pop {r3}	; 0232F344
	bx r3	; 0232F346
pool_0232F348:
loc_0232F348:
	.word 0x0232F5B1	; 0232F348

; ===== function loc_0232F34C =====
loc_0232F34C:
	push {r4,r5,r6,r7,lr}	; 0232F34C
	sub sp,#0x4	; 0232F34E
	add r5,r0,#0x0	; 0232F350
	add r4,r1,#0x0	; 0232F352
	add r6,r2,#0x0	; 0232F354
	add r7,r3,#0x0	; 0232F356
	bl loc_0232F5C4	; 0232F358
	cmp r0,#0x0	; 0232F35C
	bne loc_0232F36A	; 0232F35E
	mov r0,#0x1	; 0232F360
	add sp,#0x4	; 0232F362
	pop {r4,r5,r6,r7}	; 0232F364
	pop {r3}	; 0232F366
	bx r3	; 0232F368
loc_0232F36A:
	ldr r0,[pool_0232F394]	; 0232F36A
	str r6,[r0,#0x4]	; 0232F36C
	str r7,[r0,#0x8]	; 0232F36E
	lsl r2,r5,#0x3	; 0232F370
	mov r1,#0x0	; 0232F372
	ldr r0,[pool_0232F398]	; 0232F374
	strh r1,[r0,r2]	; 0232F376
	ldr r0,[pool_0232F39C]	; 0232F378
	str r4,[r0,r2]	; 0232F37A
	mov r0,#0xff	; 0232F37C
	and r5,r0	; 0232F37E
	ldr r0,[pool_0232F3A0]	; 0232F380
	orr r5,r0	; 0232F382
	add r0,r5,#0x0	; 0232F384
	bl loc_0232F168	; 0232F386
	mov r0,#0x0	; 0232F38A
	add sp,#0x4	; 0232F38C
	pop {r4,r5,r6,r7}	; 0232F38E
	pop {r3}	; 0232F390
	bx r3	; 0232F392
pool_0232F394:
loc_0232F394:
	.word P1_BssStart + 0x282D4	; 0232F394
pool_0232F398:
loc_0232F398:
	.word P1_BssStart + 0x282F8	; 0232F398
pool_0232F39C:
loc_0232F39C:
	.word P1_BssStart + 0x282FC	; 0232F39C
pool_0232F3A0:
loc_0232F3A0:
	.word 0x03006500	; 0232F3A0

; ===== function loc_0232F3A4 =====
loc_0232F3A4:
	push {r4,r5,r6,lr}	; 0232F3A4
	add r5,r0,#0x0	; 0232F3A6
	add r4,r1,#0x0	; 0232F3A8
	add r6,r2,#0x0	; 0232F3AA
	bl loc_0232F5C4	; 0232F3AC
	cmp r0,#0x0	; 0232F3B0
	bne loc_0232F3BC	; 0232F3B2
	mov r0,#0x1	; 0232F3B4
	pop {r4,r5,r6}	; 0232F3B6
	pop {r3}	; 0232F3B8
	bx r3	; 0232F3BA
loc_0232F3BC:
	ldr r0,[pool_0232F3E8]	; 0232F3BC
	str r4,[r0,#0x4]	; 0232F3BE
	str r6,[r0,#0x8]	; 0232F3C0
	lsr r0,r5,#0x10	; 0232F3C2
	mov r1,#0xff	; 0232F3C4
	and r0,r1	; 0232F3C6
	ldr r1,[pool_0232F3EC]	; 0232F3C8
	orr r0,r1	; 0232F3CA
	bl loc_0232F168	; 0232F3CC
	ldr r0,[pool_0232F3F0]	; 0232F3D0
	and r5,r0	; 0232F3D2
	ldr r0,[pool_0232F3F4]	; 0232F3D4
	orr r5,r0	; 0232F3D6
	add r0,r5,#0x0	; 0232F3D8
	bl loc_0232F168	; 0232F3DA
	mov r0,#0x0	; 0232F3DE
	pop {r4,r5,r6}	; 0232F3E0
	pop {r3}	; 0232F3E2
	bx r3	; 0232F3E4
	.byte 0xC0, 0x46	; 0232F3E8
pool_0232F3E8:
loc_0232F3E8:
	.word P1_BssStart + 0x282D4	; 0232F3E8
pool_0232F3EC:
loc_0232F3EC:
	.word 0x02006300	; 0232F3EC
pool_0232F3F0:
loc_0232F3F0:
	.word 0x0000FFFF	; 0232F3F0
pool_0232F3F4:
loc_0232F3F4:
	.word 0x01010000	; 0232F3F4

; ===== function loc_0232F3F8 =====
loc_0232F3F8:
	push {r4,r5,lr}	; 0232F3F8
	sub sp,#0x4	; 0232F3FA
	add r5,r0,#0x0	; 0232F3FC
	add r4,r1,#0x0	; 0232F3FE
	bl loc_0232F5C4	; 0232F400
	cmp r0,#0x0	; 0232F404
	bne loc_0232F412	; 0232F406
	mov r0,#0x1	; 0232F408
	add sp,#0x4	; 0232F40A
	pop {r4,r5}	; 0232F40C
	pop {r3}	; 0232F40E
	bx r3	; 0232F410
loc_0232F412:
	mov r1,#0x0	; 0232F412
	ldr r0,[pool_0232F460]	; 0232F414
	str r1,[r0,#0x0]	; 0232F416
	ldr r0,[pool_0232F464]	; 0232F418
	bl loc_0232F168	; 0232F41A
	ldr r1,[pool_0232F460]	; 0232F41E
loc_0232F420:
	ldr r0,[r1,#0x0]	; 0232F420
	cmp r0,#0x0	; 0232F422
	beq loc_0232F420	; 0232F424
	mov r0,#0x0	; 0232F426
	str r0,[r1,#0x0]	; 0232F428
	ldr r1,[pool_0232F468]	; 0232F42A
	str r0,[r1,#0x0]	; 0232F42C
	mov r1,#0x2	; 0232F42E
	add r2,r0,#0x0	; 0232F430
	add r3,r0,#0x0	; 0232F432
	bl loc_0232F018	; 0232F434
	mov r0,#0xff	; 0232F438
	and r5,r0	; 0232F43A
	ldr r0,[pool_0232F46C]	; 0232F43C
	orr r5,r0	; 0232F43E
	add r0,r5,#0x0	; 0232F440
	bl loc_0232F168	; 0232F442
	ldr r0,[pool_0232F470]	; 0232F446
	and r4,r0	; 0232F448
	ldr r0,[pool_0232F474]	; 0232F44A
	orr r4,r0	; 0232F44C
	add r0,r4,#0x0	; 0232F44E
	bl loc_0232F168	; 0232F450
	mov r0,#0x0	; 0232F454
	add sp,#0x4	; 0232F456
	pop {r4,r5}	; 0232F458
	pop {r3}	; 0232F45A
	bx r3	; 0232F45C
	.byte 0xC0, 0x46	; 0232F460
pool_0232F460:
loc_0232F460:
	.word P1_BssStart + 0x282C8	; 0232F460
pool_0232F464:
loc_0232F464:
	.word 0x03006000	; 0232F464
pool_0232F468:
loc_0232F468:
	.word P1_BssStart + 0x282CC	; 0232F468
pool_0232F46C:
loc_0232F46C:
	.word 0x02006100	; 0232F46C
pool_0232F470:
loc_0232F470:
	.word 0x0000FFFF	; 0232F470
pool_0232F474:
loc_0232F474:
	.word 0x01010000	; 0232F474

; ===== function loc_0232F478 =====
P1_PxiCallback_0232F478:
	push {lr}	; 0232F478
	sub sp,#0x4	; 0232F47A
	cmp r2,#0x0	; 0232F47C
	beq loc_0232F48C	; 0232F47E
	mov r0,#0x2	; 0232F480
	bl loc_0232F588	; 0232F482
	add sp,#0x4	; 0232F486
	pop {r3}	; 0232F488
	bx r3	; 0232F48A
loc_0232F48C:
	ldr r0,[pool_0232F4F8]	; 0232F48C
	add r2,r1,#0x0	; 0232F48E
	and r2,r0	; 0232F490
	lsl r0,r2,#0x8	; 0232F492
	lsr r3,r0,#0x10	; 0232F494
	mov r2,#0xff	; 0232F496
	and r1,r2	; 0232F498
	lsl r0,r1,#0x10	; 0232F49A
	lsr r0,r0,#0x10	; 0232F49C
	cmp r3,#0x70	; 0232F49E
	bcc loc_0232F4C4	; 0232F4A0
	cmp r3,#0x73	; 0232F4A2
	bhi loc_0232F4C4	; 0232F4A4
	and r0,r2	; 0232F4A6
	lsl r0,r0,#0x10	; 0232F4A8
	lsr r1,r0,#0x10	; 0232F4AA
	sub r3,#0x70	; 0232F4AC
	lsl r2,r3,#0x3	; 0232F4AE
	ldr r0,[pool_0232F4FC]	; 0232F4B0
	ldr r0,[r0,r2]	; 0232F4B2
	cmp r0,#0x0	; 0232F4B4
	beq loc_0232F4BA	; 0232F4B6
	strh r1,[r0,#0x0]	; 0232F4B8
loc_0232F4BA:
	mov r1,#0x1	; 0232F4BA
	ldr r0,[pool_0232F500]	; 0232F4BC
	strh r1,[r0,r2]	; 0232F4BE
	mov r0,#0x0	; 0232F4C0
	b loc_0232F4EC	; 0232F4C2
loc_0232F4C4:
	cmp r3,#0x60	; 0232F4C4
	bne loc_0232F4D0	; 0232F4C6
	mov r2,#0x1	; 0232F4C8
	ldr r1,[pool_0232F504]	; 0232F4CA
	str r2,[r1,#0x0]	; 0232F4CC
	b loc_0232F4EC	; 0232F4CE
loc_0232F4D0:
	cmp r3,#0x62	; 0232F4D0
	bne loc_0232F4DC	; 0232F4D2
	mov r2,#0x1	; 0232F4D4
	ldr r1,[pool_0232F508]	; 0232F4D6
	str r2,[r1,#0x0]	; 0232F4D8
	b loc_0232F4EC	; 0232F4DA
loc_0232F4DC:
	cmp r3,#0x67	; 0232F4DC
	bne loc_0232F4EC	; 0232F4DE
	ldr r1,[pool_0232F50C]	; 0232F4E0
	ldr r1,[r1,#0xc]	; 0232F4E2
	cmp r1,#0x0	; 0232F4E4
	beq loc_0232F4EA	; 0232F4E6
	str r0,[r1,#0x0]	; 0232F4E8
loc_0232F4EA:
	mov r0,#0x0	; 0232F4EA
loc_0232F4EC:
	bl loc_0232F588	; 0232F4EC
	add sp,#0x4	; 0232F4F0
	pop {r3}	; 0232F4F2
	bx r3	; 0232F4F4
	.byte 0xC0, 0x46	; 0232F4F8
pool_0232F4F8:
loc_0232F4F8:
	.word 0x00007F00	; 0232F4F8
pool_0232F4FC:
loc_0232F4FC:
	.word P1_BssStart + 0x282FC	; 0232F4FC
pool_0232F500:
loc_0232F500:
	.word P1_BssStart + 0x282F8	; 0232F500
pool_0232F504:
loc_0232F504:
	.word P1_BssStart + 0x282C8	; 0232F504
pool_0232F508:
loc_0232F508:
	.word P1_BssStart + 0x282CC	; 0232F508
pool_0232F50C:
loc_0232F50C:
	.word P1_BssStart + 0x282D4	; 0232F50C

; ===== function loc_0232F510 =====
loc_0232F510:
	push {r4,r5,lr}	; 0232F510
	sub sp,#0x4	; 0232F512
	ldr r0,[pool_0232F56C]	; 0232F514
	ldrh r1,[r0,#0x0]	; 0232F516
	cmp r1,#0x0	; 0232F518
	bne loc_0232F562	; 0232F51A
	mov r1,#0x1	; 0232F51C
	strh r1,[r0,#0x0]	; 0232F51E
	mov r1,#0x0	; 0232F520
	ldr r0,[pool_0232F570]	; 0232F522
	str r1,[r0,#0x0]	; 0232F524
	str r1,[r0,#0x4]	; 0232F526
	bl loc_0232E7D4	; 0232F528
	mov r5,#0x8	; 0232F52C
	mov r4,#0x1	; 0232F52E
loc_0232F530:
	add r0,r5,#0x0	; 0232F530
	add r1,r4,#0x0	; 0232F532
	bl loc_0232E948	; 0232F534
	cmp r0,#0x0	; 0232F538
	beq loc_0232F530	; 0232F53A
	mov r0,#0x8	; 0232F53C
	ldr r1,[pool_0232F574]	; 0232F53E
	bl P1_SetPxiReceiveCallback	; 0232F540
	mov r2,#0x0	; 0232F544
	ldr r1,[pool_0232F578]	; 0232F546
	add r0,r2,#0x0	; 0232F548
loc_0232F54A:
	strh r0,[r1,#0x0]	; 0232F54A
	add r1,#0x8	; 0232F54C
	add r2,r2,#0x1	; 0232F54E
	cmp r2,#0x4	; 0232F550
	blt loc_0232F54A	; 0232F552
	ldr r0,[pool_0232F57C]	; 0232F554
	bl loc_0232BB74	; 0232F556
	ldr r0,[pool_0232F580]	; 0232F55A
	ldr r1,[r0,#0x0]	; 0232F55C
	ldr r0,[pool_0232F584]	; 0232F55E
	str r1,[r0,#0x0]	; 0232F560
loc_0232F562:
	add sp,#0x4	; 0232F562
	pop {r4,r5}	; 0232F564
	pop {r3}	; 0232F566
	bx r3	; 0232F568
	.byte 0xC0, 0x46	; 0232F56C
pool_0232F56C:
loc_0232F56C:
	.word P1_BssStart + 0x282C4	; 0232F56C
pool_0232F570:
loc_0232F570:
	.word P1_BssStart + 0x282D4	; 0232F570
pool_0232F574:
loc_0232F574:
	.word P1_PxiCallback_0232F478 + 1	; 0232F574
pool_0232F578:
loc_0232F578:
	.word P1_BssStart + 0x282F8	; 0232F578
pool_0232F57C:
loc_0232F57C:
	.word 0x02358DA4	; 0232F57C
pool_0232F580:
loc_0232F580:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232F580
pool_0232F584:
loc_0232F584:
	.word P1_BssStart + 0x282D0	; 0232F584

; ===== function loc_0232F588 =====
loc_0232F588:
	push {r4,lr}	; 0232F588
	ldr r3,[pool_0232F5AC]	; 0232F58A
	ldr r2,[r3,#0x4]	; 0232F58C
	ldr r1,[r3,#0x8]	; 0232F58E
	ldr r4,[r3,#0x0]	; 0232F590
	cmp r4,#0x0	; 0232F592
	beq loc_0232F59A	; 0232F594
	mov r4,#0x0	; 0232F596
	str r4,[r3,#0x0]	; 0232F598
loc_0232F59A:
	cmp r2,#0x0	; 0232F59A
	beq loc_0232F5A6	; 0232F59C
	mov r4,#0x0	; 0232F59E
	ldr r3,[pool_0232F5AC]	; 0232F5A0
	str r4,[r3,#0x4]	; 0232F5A2
	blx r2	; 0232F5A4
loc_0232F5A6:
	pop {r4}	; 0232F5A6
	pop {r3}	; 0232F5A8
	bx r3	; 0232F5AA
pool_0232F5AC:
loc_0232F5AC:
	.word P1_BssStart + 0x282D4	; 0232F5AC
	str r0,[r1,#0x0]	; 0232F5B0
	bx lr	; 0232F5B2

; ===== function loc_0232F5B4 =====
loc_0232F5B4:
	ldr r1,[pool_0232F5C0]	; 0232F5B4
loc_0232F5B6:
	ldr r0,[r1,#0x0]	; 0232F5B6
	cmp r0,#0x0	; 0232F5B8
	bne loc_0232F5B6	; 0232F5BA
	bx lr	; 0232F5BC
	.byte 0xC0, 0x46	; 0232F5C0
pool_0232F5C0:
loc_0232F5C0:
	.word P1_BssStart + 0x282D4	; 0232F5C0

; ===== function loc_0232F5C4 =====
loc_0232F5C4:
	push {lr}	; 0232F5C4
	sub sp,#0x4	; 0232F5C6
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F5C8
	ldr r1,[pool_0232F5F0]	; 0232F5CC
	ldr r2,[r1,#0x0]	; 0232F5CE
	cmp r2,#0x0	; 0232F5D0
	beq loc_0232F5E0	; 0232F5D2
	blx P1_Arm9RestoreIrqMask	; 0232F5D4
	mov r0,#0x0	; 0232F5D8
	add sp,#0x4	; 0232F5DA
	pop {r3}	; 0232F5DC
	bx r3	; 0232F5DE
loc_0232F5E0:
	mov r2,#0x1	; 0232F5E0
	str r2,[r1,#0x0]	; 0232F5E2
	blx P1_Arm9RestoreIrqMask	; 0232F5E4
	mov r0,#0x1	; 0232F5E8
	add sp,#0x4	; 0232F5EA
	pop {r3}	; 0232F5EC
	bx r3	; 0232F5EE
pool_0232F5F0:
loc_0232F5F0:
	.word P1_BssStart + 0x282D4	; 0232F5F0
.arm

; ===== function loc_0232F5F4 =====
loc_0232F5F4:
	ldr r12,[pool_0232F608]	; 0232F5F4
loc_0232F5F8:
	ldr r0,[r12,#0x0]	; 0232F5F8
	cmp r0,#0x1	; 0232F5FC
	beq loc_0232F5F8	; 0232F600
	bx lr	; 0232F604
pool_0232F608:
loc_0232F608:
	.word P1_BssStart + 0x2831C	; 0232F608
.thumb
	ldr r1,[pool_0232F614]	; 0232F60C
	str r0,[r1,#0x20]	; 0232F60E
	bx lr	; 0232F610
	.byte 0xC0, 0x46	; 0232F614
pool_0232F614:
loc_0232F614:
	.word P1_BssStart + 0x2831C	; 0232F614

; ===== function loc_0232F618 =====
loc_0232F618:
	push {r4,r5,lr}	; 0232F618
	sub sp,#0x4	; 0232F61A
	add r5,r0,#0x0	; 0232F61C
	add r4,r1,#0x0	; 0232F61E
	ldr r0,[r5,#0x0]	; 0232F620
	cmp r0,#0xc	; 0232F622
	bcc loc_0232F630	; 0232F624
	ldr r1,[r4,#0x0]	; 0232F626
	mov r0,#0x40	; 0232F628
	orr r1,r0	; 0232F62A
	str r1,[r4,#0x0]	; 0232F62C
	b loc_0232F638	; 0232F62E
loc_0232F630:
	ldr r1,[r4,#0x0]	; 0232F630
	mov r0,#0x40	; 0232F632
	bic r1,r0	; 0232F634
	str r1,[r4,#0x0]	; 0232F636
loc_0232F638:
	ldr r0,[r5,#0x0]	; 0232F638
	bl loc_0232F78C	; 0232F63A
	ldr r2,[r4,#0x0]	; 0232F63E
	mov r1,#0x3f	; 0232F640
	bic r2,r1	; 0232F642
	and r0,r1	; 0232F644
	orr r2,r0	; 0232F646
	str r2,[r4,#0x0]	; 0232F648
	ldr r0,[r5,#0x4]	; 0232F64A
	bl loc_0232F78C	; 0232F64C
	ldr r2,[r4,#0x0]	; 0232F650
	ldr r1,[pool_0232F680]	; 0232F652
	and r2,r1	; 0232F654
	mov r1,#0x7f	; 0232F656
	and r0,r1	; 0232F658
	lsl r0,r0,#0x8	; 0232F65A
	orr r2,r0	; 0232F65C
	str r2,[r4,#0x0]	; 0232F65E
	ldr r0,[r5,#0x8]	; 0232F660
	bl loc_0232F78C	; 0232F662
	ldr r2,[r4,#0x0]	; 0232F666
	ldr r1,[pool_0232F684]	; 0232F668
	and r2,r1	; 0232F66A
	mov r1,#0x7f	; 0232F66C
	and r0,r1	; 0232F66E
	lsl r0,r0,#0x10	; 0232F670
	orr r2,r0	; 0232F672
	str r2,[r4,#0x0]	; 0232F674
	add sp,#0x4	; 0232F676
	pop {r4,r5}	; 0232F678
	pop {r3}	; 0232F67A
	bx r3	; 0232F67C
	.byte 0xC0, 0x46	; 0232F680
pool_0232F680:
loc_0232F680:
	.word 0xFFFF80FF	; 0232F680
pool_0232F684:
loc_0232F684:
	.word 0xFF80FFFF	; 0232F684

; ===== function loc_0232F688 =====
loc_0232F688:
	push {r4,r5,lr}	; 0232F688
	sub sp,#0x4	; 0232F68A
	add r5,r0,#0x0	; 0232F68C
	add r4,r1,#0x0	; 0232F68E
	ldr r0,[r5,#0x0]	; 0232F690
	bl loc_0232F78C	; 0232F692
	str r0,[r4,#0x0]	; 0232F696
	ldr r0,[r5,#0x4]	; 0232F698
	bl loc_0232F78C	; 0232F69A
	ldr r2,[r4,#0x0]	; 0232F69E
	ldr r1,[pool_0232F6E0]	; 0232F6A0
	and r2,r1	; 0232F6A2
	mov r1,#0x1f	; 0232F6A4
	and r0,r1	; 0232F6A6
	lsl r0,r0,#0x8	; 0232F6A8
	orr r2,r0	; 0232F6AA
	str r2,[r4,#0x0]	; 0232F6AC
	ldr r0,[r5,#0x8]	; 0232F6AE
	bl loc_0232F78C	; 0232F6B0
	ldr r2,[r4,#0x0]	; 0232F6B4
	ldr r1,[pool_0232F6E4]	; 0232F6B6
	and r2,r1	; 0232F6B8
	mov r1,#0x3f	; 0232F6BA
	and r0,r1	; 0232F6BC
	lsl r0,r0,#0x10	; 0232F6BE
	orr r2,r0	; 0232F6C0
	str r2,[r4,#0x0]	; 0232F6C2
	ldr r2,[r4,#0x0]	; 0232F6C4
	ldr r0,[pool_0232F6E8]	; 0232F6C6
	and r2,r0	; 0232F6C8
	ldr r1,[r5,#0xc]	; 0232F6CA
	mov r0,#0x7	; 0232F6CC
	and r1,r0	; 0232F6CE
	lsl r0,r1,#0x18	; 0232F6D0
	orr r2,r0	; 0232F6D2
	str r2,[r4,#0x0]	; 0232F6D4
	add sp,#0x4	; 0232F6D6
	pop {r4,r5}	; 0232F6D8
	pop {r3}	; 0232F6DA
	bx r3	; 0232F6DC
	.byte 0xC0, 0x46	; 0232F6E0
pool_0232F6E0:
loc_0232F6E0:
	.word 0xFFFFE0FF	; 0232F6E0
pool_0232F6E4:
loc_0232F6E4:
	.word 0xFFC0FFFF	; 0232F6E4
pool_0232F6E8:
loc_0232F6E8:
	.word 0xF8FFFFFF	; 0232F6E8

; ===== function loc_0232F6EC =====
loc_0232F6EC:
	push {r4,lr}	; 0232F6EC
	sub sp,#0x8	; 0232F6EE
	add r4,r0,#0x0	; 0232F6F0
	mov r2,#0x0	; 0232F6F2
	str r2,[sp,#0x0]	; 0232F6F4
	mov r0,#0x7	; 0232F6F6
	bic r2,r0	; 0232F6F8
	ldr r1,[r4,#0x0]	; 0232F6FA
	and r1,r0	; 0232F6FC
	orr r2,r1	; 0232F6FE
	str r2,[sp,#0x0]	; 0232F700
	ldr r0,[r4,#0x4]	; 0232F702
	cmp r0,#0xc	; 0232F704
	bcc loc_0232F70E	; 0232F706
	ldr r0,[pool_0232F778]	; 0232F708
	orr r2,r0	; 0232F70A
	str r2,[sp,#0x0]	; 0232F70C
loc_0232F70E:
	ldr r0,[r4,#0x4]	; 0232F70E
	bl loc_0232F78C	; 0232F710
	ldr r2,[sp,#0x0]	; 0232F714
	ldr r1,[pool_0232F77C]	; 0232F716
	and r2,r1	; 0232F718
	mov r1,#0x3f	; 0232F71A
	and r0,r1	; 0232F71C
	lsl r0,r0,#0x8	; 0232F71E
	orr r2,r0	; 0232F720
	str r2,[sp,#0x0]	; 0232F722
	ldr r0,[r4,#0x8]	; 0232F724
	bl loc_0232F78C	; 0232F726
	ldr r1,[sp,#0x0]	; 0232F72A
	ldr r2,[pool_0232F780]	; 0232F72C
	and r1,r2	; 0232F72E
	mov r2,#0x7f	; 0232F730
	and r0,r2	; 0232F732
	lsl r0,r0,#0x10	; 0232F734
	orr r1,r0	; 0232F736
	str r1,[sp,#0x0]	; 0232F738
	ldr r2,[r4,#0xc]	; 0232F73A
	mov r0,#0x1	; 0232F73C
	and r2,r0	; 0232F73E
	cmp r2,#0x0	; 0232F740
	beq loc_0232F74A	; 0232F742
	mov r0,#0x80	; 0232F744
	orr r1,r0	; 0232F746
	str r1,[sp,#0x0]	; 0232F748
loc_0232F74A:
	ldr r1,[r4,#0xc]	; 0232F74A
	mov r0,#0x2	; 0232F74C
	and r1,r0	; 0232F74E
	cmp r1,#0x0	; 0232F750
	beq loc_0232F75C	; 0232F752
	ldr r1,[sp,#0x0]	; 0232F754
	ldr r0,[pool_0232F784]	; 0232F756
	orr r1,r0	; 0232F758
	str r1,[sp,#0x0]	; 0232F75A
loc_0232F75C:
	ldr r1,[r4,#0xc]	; 0232F75C
	mov r0,#0x4	; 0232F75E
	and r1,r0	; 0232F760
	cmp r1,#0x0	; 0232F762
	beq loc_0232F76E	; 0232F764
	ldr r1,[sp,#0x0]	; 0232F766
	ldr r0,[pool_0232F788]	; 0232F768
	orr r1,r0	; 0232F76A
	str r1,[sp,#0x0]	; 0232F76C
loc_0232F76E:
	ldr r0,[sp,#0x0]	; 0232F76E
	add sp,#0x8	; 0232F770
	pop {r4}	; 0232F772
	pop {r3}	; 0232F774
	bx r3	; 0232F776
pool_0232F778:
loc_0232F778:
	.word 0x00004000	; 0232F778
pool_0232F77C:
loc_0232F77C:
	.word 0xFFFFC0FF	; 0232F77C
pool_0232F780:
loc_0232F780:
	.word 0xFF80FFFF	; 0232F780
pool_0232F784:
loc_0232F784:
	.word 0x00008000	; 0232F784
pool_0232F788:
loc_0232F788:
	.word 0x00800000	; 0232F788

; ===== function loc_0232F78C =====
loc_0232F78C:
	push {r4,r5,r6,r7,lr}	; 0232F78C
	sub sp,#0x4	; 0232F78E
	add r5,r0,#0x0	; 0232F790
	mov r6,#0x0	; 0232F792
	ldr r0,[pool_0232F7D0]	; 0232F794
	cmp r5,r0	; 0232F796
	bls loc_0232F7A4	; 0232F798
	add r0,r6,#0x0	; 0232F79A
	add sp,#0x4	; 0232F79C
	pop {r4,r5,r6,r7}	; 0232F79E
	pop {r3}	; 0232F7A0
	bx r3	; 0232F7A2
loc_0232F7A4:
	add r7,r6,#0x0	; 0232F7A4
	add r4,r6,#0x0	; 0232F7A6
loc_0232F7A8:
	add r0,r5,#0x0	; 0232F7A8
	mov r1,#0xa	; 0232F7AA
	blx P1_UnsignedDivMod	; 0232F7AC
	lsl r1,r4	; 0232F7B0
	add r6,r6,r1	; 0232F7B2
	add r0,r5,#0x0	; 0232F7B4
	mov r1,#0xa	; 0232F7B6
	blx P1_UnsignedDivMod	; 0232F7B8
	add r5,r0,#0x0	; 0232F7BC
	add r4,r4,#0x4	; 0232F7BE
	add r7,r7,#0x1	; 0232F7C0
	cmp r7,#0x8	; 0232F7C2
	blt loc_0232F7A8	; 0232F7C4
	add r0,r6,#0x0	; 0232F7C6
	add sp,#0x4	; 0232F7C8
	pop {r4,r5,r6,r7}	; 0232F7CA
	pop {r3}	; 0232F7CC
	bx r3	; 0232F7CE
pool_0232F7D0:
loc_0232F7D0:
	.word 0x05F5E0FF	; 0232F7D0

; ===== function loc_0232F7D4 =====
loc_0232F7D4:
	push {r4,r5,r6,r7}	; 0232F7D4
	mov r4,#0x0	; 0232F7D6
	add r5,r4,#0x0	; 0232F7D8
	add r3,r4,#0x0	; 0232F7DA
	mov r1,#0xf	; 0232F7DC
loc_0232F7DE:
	add r2,r0,#0x0	; 0232F7DE
	lsr r2,r3	; 0232F7E0
	and r2,r1	; 0232F7E2
	cmp r2,#0xa	; 0232F7E4
	bcc loc_0232F7EE	; 0232F7E6
	mov r0,#0x0	; 0232F7E8
	pop {r4,r5,r6,r7}	; 0232F7EA
	bx lr	; 0232F7EC
loc_0232F7EE:
	add r3,r3,#0x4	; 0232F7EE
	add r5,r5,#0x1	; 0232F7F0
	cmp r5,#0x8	; 0232F7F2
	blt loc_0232F7DE	; 0232F7F4
	mov r1,#0x0	; 0232F7F6
	mov r3,#0x1	; 0232F7F8
	add r2,r1,#0x0	; 0232F7FA
	mov r6,#0xa	; 0232F7FC
loc_0232F7FE:
	add r7,r0,#0x0	; 0232F7FE
	lsr r7,r2	; 0232F800
	mov r5,#0xf	; 0232F802
	and r7,r5	; 0232F804
	add r5,r3,#0x0	; 0232F806
	mul r5,r7	; 0232F808
	add r4,r4,r5	; 0232F80A
	add r2,r2,#0x4	; 0232F80C
	add r1,r1,#0x1	; 0232F80E
	mul r3,r6	; 0232F810
	cmp r1,#0x8	; 0232F812
	blt loc_0232F7FE	; 0232F814
	add r0,r4,#0x0	; 0232F816
	pop {r4,r5,r6,r7}	; 0232F818
	bx lr	; 0232F81A

; ===== function loc_0232F81C =====
P1_PxiCallback_0232F81C:
	push {r4,r5,lr}	; 0232F81C
	sub sp,#0x4	; 0232F81E
	cmp r2,#0x0	; 0232F820
	beq loc_0232F858	; 0232F822
	ldr r0,[pool_0232FAF0]	; 0232F824
	ldr r1,[r0,#0x18]	; 0232F826
	cmp r1,#0x0	; 0232F828
	beq loc_0232F830	; 0232F82A
	mov r1,#0x0	; 0232F82C
	str r1,[r0,#0x18]	; 0232F82E
loc_0232F830:
	ldr r0,[pool_0232FAF0]	; 0232F830
	ldr r1,[r0,#0x0]	; 0232F832
	cmp r1,#0x0	; 0232F834
	beq loc_0232F83C	; 0232F836
	mov r1,#0x0	; 0232F838
	str r1,[r0,#0x0]	; 0232F83A
loc_0232F83C:
	ldr r1,[pool_0232FAF0]	; 0232F83C
	ldr r2,[r1,#0x4]	; 0232F83E
	cmp r2,#0x0	; 0232F840
	bne loc_0232F846	; 0232F842
	b loc_0232FAE6	; 0232F844
loc_0232F846:
	mov r0,#0x0	; 0232F846
	str r0,[r1,#0x4]	; 0232F848
	mov r0,#0x6	; 0232F84A
	ldr r1,[r1,#0x10]	; 0232F84C
	blx r2	; 0232F84E
	add sp,#0x4	; 0232F850
	pop {r4,r5}	; 0232F852
	pop {r3}	; 0232F854
	bx r3	; 0232F856
loc_0232F858:
	mov r2,#0xff	; 0232F858
	add r0,r1,#0x0	; 0232F85A
	and r0,r2	; 0232F85C
	ldr r3,[pool_0232FAF4]	; 0232F85E
	and r1,r3	; 0232F860
	lsr r1,r1,#0x8	; 0232F862
	lsl r1,r1,#0x18	; 0232F864
	lsr r1,r1,#0x18	; 0232F866
	cmp r1,#0x30	; 0232F868
	bne loc_0232F880	; 0232F86A
	ldr r0,[pool_0232FAF0]	; 0232F86C
	ldr r0,[r0,#0x1c]	; 0232F86E
	cmp r0,#0x0	; 0232F870
	bne loc_0232F876	; 0232F872
	b loc_0232FAE6	; 0232F874
loc_0232F876:
	blx r0	; 0232F876
	add sp,#0x4	; 0232F878
	pop {r4,r5}	; 0232F87A
	pop {r3}	; 0232F87C
	bx r3	; 0232F87E
loc_0232F880:
	cmp r0,#0x0	; 0232F880
	beq loc_0232F886	; 0232F882
	b loc_0232FA92	; 0232F884
loc_0232F886:
	mov r4,#0x0	; 0232F886
	ldr r0,[pool_0232FAF0]	; 0232F888
	ldr r1,[r0,#0x14]	; 0232F88A
	cmp r1,#0xf	; 0232F88C
	bls loc_0232F892	; 0232F88E
	b loc_0232FA88	; 0232F890
loc_0232F892:
	add r1,r1,r1	; 0232F892
P1_SwitchIndexPC_0232F892:
	add r1,pc	; 0232F894
	ldrh r1,[r1,#(P1_SwitchTable_0232F892 - (P1_SwitchIndexPC_0232F892 + 4))]	; 0232F896
	lsl r1,r1,#0x10	; 0232F898
	asr r1,r1,#0x10	; 0232F89A
P1_SwitchTargetPC_0232F892:
	add r1,pc	; 0232F89C
	bx r1	; 0232F89E
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232F892:
	.halfword (loc_0232FA88 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FA88 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232F8C0 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FA88 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FA88 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FAC2 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232F924 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232F93C + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232F954 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232F9B8 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FA22 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FAC2 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FAC2 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FAC2 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FAC2 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
	.halfword (loc_0232FAC2 + 1) - (P1_SwitchTargetPC_0232F892 + 4)
P1_SwitchTable_0232F892End:
loc_0232F8C0:
	ldr r5,[r0,#0x8]	; 0232F8C0
	ldr r0,[pool_0232FAF8]	; 0232F8C2
	ldr r0,[r0,#0x0]	; 0232F8C4
	and r0,r2	; 0232F8C6
	bl loc_0232F7D4	; 0232F8C8
	str r0,[r5,#0x0]	; 0232F8CC
	ldr r0,[pool_0232FAF8]	; 0232F8CE
	ldr r0,[r0,#0x0]	; 0232F8D0
	lsl r0,r0,#0x13	; 0232F8D2
	lsr r0,r0,#0x1b	; 0232F8D4
	bl loc_0232F7D4	; 0232F8D6
	str r0,[r5,#0x4]	; 0232F8DA
	ldr r0,[pool_0232FAF8]	; 0232F8DC
	ldr r0,[r0,#0x0]	; 0232F8DE
	lsl r0,r0,#0xa	; 0232F8E0
	lsr r0,r0,#0x1a	; 0232F8E2
	bl loc_0232F7D4	; 0232F8E4
	str r0,[r5,#0x8]	; 0232F8E8
	ldr r0,[pool_0232FAF8]	; 0232F8EA
	ldr r0,[r0,#0x0]	; 0232F8EC
	lsl r0,r0,#0x5	; 0232F8EE
	lsr r0,r0,#0x1d	; 0232F8F0
	str r0,[r5,#0xc]	; 0232F8F2
	ldr r0,[pool_0232FAF0]	; 0232F8F4
	ldr r5,[r0,#0xc]	; 0232F8F6
	ldr r0,[pool_0232FAFC]	; 0232F8F8
	ldr r0,[r0,#0x0]	; 0232F8FA
	lsl r0,r0,#0x1a	; 0232F8FC
	lsr r0,r0,#0x1a	; 0232F8FE
	bl loc_0232F7D4	; 0232F900
	str r0,[r5,#0x0]	; 0232F904
	ldr r0,[pool_0232FAFC]	; 0232F906
	ldr r0,[r0,#0x0]	; 0232F908
	lsl r0,r0,#0x11	; 0232F90A
	lsr r0,r0,#0x19	; 0232F90C
	bl loc_0232F7D4	; 0232F90E
	str r0,[r5,#0x4]	; 0232F912
	ldr r0,[pool_0232FAFC]	; 0232F914
	ldr r0,[r0,#0x0]	; 0232F916
	lsl r0,r0,#0x9	; 0232F918
	lsr r0,r0,#0x19	; 0232F91A
	bl loc_0232F7D4	; 0232F91C
	str r0,[r5,#0x8]	; 0232F920
	b loc_0232FAC2	; 0232F922
loc_0232F924:
	ldr r1,[r0,#0x8]	; 0232F924
	ldr r0,[pool_0232FB00]	; 0232F926
	ldrh r0,[r0,#0x0]	; 0232F928
	lsl r0,r0,#0x1c	; 0232F92A
	lsr r0,r0,#0x1c	; 0232F92C
	cmp r0,#0x4	; 0232F92E
	bne loc_0232F938	; 0232F930
	mov r0,#0x1	; 0232F932
	str r0,[r1,#0x0]	; 0232F934
	b loc_0232FAC2	; 0232F936
loc_0232F938:
	str r4,[r1,#0x0]	; 0232F938
	b loc_0232FAC2	; 0232F93A
loc_0232F93C:
	ldr r1,[r0,#0x8]	; 0232F93C
	ldr r0,[pool_0232FB00]	; 0232F93E
	ldrh r0,[r0,#0x0]	; 0232F940
	lsl r0,r0,#0x19	; 0232F942
	lsr r0,r0,#0x1f	; 0232F944
	cmp r0,#0x0	; 0232F946
	beq loc_0232F950	; 0232F948
	mov r0,#0x1	; 0232F94A
	str r0,[r1,#0x0]	; 0232F94C
	b loc_0232FAC2	; 0232F94E
loc_0232F950:
	str r4,[r1,#0x0]	; 0232F950
	b loc_0232FAC2	; 0232F952
loc_0232F954:
	ldr r5,[r0,#0x8]	; 0232F954
	ldr r1,[pool_0232FAFC]	; 0232F956
	ldr r0,[r1,#0x0]	; 0232F958
	lsl r0,r0,#0x1d	; 0232F95A
	lsr r0,r0,#0x1d	; 0232F95C
	str r0,[r5,#0x0]	; 0232F95E
	ldr r0,[r1,#0x0]	; 0232F960
	lsl r0,r0,#0x12	; 0232F962
	lsr r0,r0,#0x1a	; 0232F964
	bl loc_0232F7D4	; 0232F966
	str r0,[r5,#0x4]	; 0232F96A
	ldr r0,[pool_0232FAFC]	; 0232F96C
	ldr r0,[r0,#0x0]	; 0232F96E
	lsl r0,r0,#0x9	; 0232F970
	lsr r0,r0,#0x19	; 0232F972
	bl loc_0232F7D4	; 0232F974
	str r0,[r5,#0x8]	; 0232F978
	lsl r0,r4,#0	; 0232F97A
	str r0,[r5,#0xc]	; 0232F97C
	ldr r0,[pool_0232FAFC]	; 0232F97E
	ldr r0,[r0,#0x0]	; 0232F980
	lsl r0,r0,#0x18	; 0232F982
	lsr r0,r0,#0x1f	; 0232F984
	cmp r0,#0x0	; 0232F986
	beq loc_0232F990	; 0232F988
	ldr r0,[r5,#0xc]	; 0232F98A
	add r0,r0,#0x1	; 0232F98C
	str r0,[r5,#0xc]	; 0232F98E
loc_0232F990:
	ldr r0,[pool_0232FAFC]	; 0232F990
	ldr r0,[r0,#0x0]	; 0232F992
	lsl r0,r0,#0x10	; 0232F994
	lsr r0,r0,#0x1f	; 0232F996
	cmp r0,#0x0	; 0232F998
	beq loc_0232F9A2	; 0232F99A
	ldr r0,[r5,#0xc]	; 0232F99C
	add r0,r0,#0x2	; 0232F99E
	str r0,[r5,#0xc]	; 0232F9A0
loc_0232F9A2:
	ldr r0,[pool_0232FAFC]	; 0232F9A2
	ldr r0,[r0,#0x0]	; 0232F9A4
	lsl r0,r0,#0x8	; 0232F9A6
	lsr r0,r0,#0x1f	; 0232F9A8
	cmp r0,#0x0	; 0232F9AA
	bne loc_0232F9B0	; 0232F9AC
	b loc_0232FAC2	; 0232F9AE
loc_0232F9B0:
	ldr r0,[r5,#0xc]	; 0232F9B0
	add r0,r0,#0x4	; 0232F9B2
	str r0,[r5,#0xc]	; 0232F9B4
	b loc_0232FAC2	; 0232F9B6
loc_0232F9B8:
	ldr r2,[r0,#0x18]	; 0232F9B8
	cmp r2,#0x0	; 0232F9BA
	bne loc_0232FA1E	; 0232F9BC
	ldr r1,[r0,#0x8]	; 0232F9BE
	ldr r1,[r1,#0x0]	; 0232F9C0
	cmp r1,#0x1	; 0232F9C2
	bne loc_0232F9F4	; 0232F9C4
	ldr r1,[pool_0232FB00]	; 0232F9C6
	ldrh r3,[r1,#0x0]	; 0232F9C8
	lsl r3,r3,#0x1c	; 0232F9CA
	lsr r3,r3,#0x1c	; 0232F9CC
	cmp r3,#0x4	; 0232F9CE
	beq loc_0232FAC2	; 0232F9D0
	add r2,r2,#0x1	; 0232F9D2
	str r2,[r0,#0x18]	; 0232F9D4
	ldrh r2,[r1,#0x0]	; 0232F9D6
	mov r0,#0xf	; 0232F9D8
	bic r2,r0	; 0232F9DA
	mov r0,#0x4	; 0232F9DC
	orr r2,r0	; 0232F9DE
	strh r2,[r1,#0x0]	; 0232F9E0
	bl loc_0232FE8C	; 0232F9E2
	cmp r0,#0x0	; 0232F9E6
	bne loc_0232FAC2	; 0232F9E8
	lsl r1,r4,#0	; 0232F9EA
	ldr r0,[pool_0232FAF0]	; 0232F9EC
	str r1,[r0,#0x18]	; 0232F9EE
	mov r4,#0x3	; 0232F9F0
	b loc_0232FAC2	; 0232F9F2
loc_0232F9F4:
	ldr r1,[pool_0232FB00]	; 0232F9F4
	ldrh r3,[r1,#0x0]	; 0232F9F6
	lsl r3,r3,#0x1c	; 0232F9F8
	lsr r3,r3,#0x1c	; 0232F9FA
	cmp r3,#0x0	; 0232F9FC
	beq loc_0232FAC2	; 0232F9FE
	add r2,r2,#0x1	; 0232FA00
	str r2,[r0,#0x18]	; 0232FA02
	ldrh r2,[r1,#0x0]	; 0232FA04
	mov r0,#0xf	; 0232FA06
	bic r2,r0	; 0232FA08
	strh r2,[r1,#0x0]	; 0232FA0A
	bl loc_0232FE8C	; 0232FA0C
	cmp r0,#0x0	; 0232FA10
	bne loc_0232FAC2	; 0232FA12
	lsl r1,r4,#0	; 0232FA14
	ldr r0,[pool_0232FAF0]	; 0232FA16
	str r1,[r0,#0x18]	; 0232FA18
	mov r4,#0x3	; 0232FA1A
	b loc_0232FAC2	; 0232FA1C
loc_0232FA1E:
	str r4,[r0,#0x18]	; 0232FA1E
	b loc_0232FAC2	; 0232FA20
loc_0232FA22:
	ldr r2,[r0,#0x18]	; 0232FA22
	cmp r2,#0x0	; 0232FA24
	bne loc_0232FA84	; 0232FA26
	ldr r1,[r0,#0x8]	; 0232FA28
	ldr r1,[r1,#0x0]	; 0232FA2A
	cmp r1,#0x1	; 0232FA2C
	bne loc_0232FA5A	; 0232FA2E
	ldr r1,[pool_0232FB00]	; 0232FA30
	ldrh r3,[r1,#0x0]	; 0232FA32
	lsl r3,r3,#0x19	; 0232FA34
	lsr r3,r3,#0x1f	; 0232FA36
	cmp r3,#0x0	; 0232FA38
	bne loc_0232FAC2	; 0232FA3A
	add r2,r2,#0x1	; 0232FA3C
	str r2,[r0,#0x18]	; 0232FA3E
	ldrh r2,[r1,#0x0]	; 0232FA40
	mov r0,#0x40	; 0232FA42
	orr r2,r0	; 0232FA44
	strh r2,[r1,#0x0]	; 0232FA46
	bl loc_0232FE8C	; 0232FA48
	cmp r0,#0x0	; 0232FA4C
	bne loc_0232FAC2	; 0232FA4E
	lsl r1,r4,#0	; 0232FA50
	ldr r0,[pool_0232FAF0]	; 0232FA52
	str r1,[r0,#0x18]	; 0232FA54
	mov r4,#0x3	; 0232FA56
	b loc_0232FAC2	; 0232FA58
loc_0232FA5A:
	ldr r1,[pool_0232FB00]	; 0232FA5A
	ldrh r3,[r1,#0x0]	; 0232FA5C
	lsl r3,r3,#0x19	; 0232FA5E
	lsr r3,r3,#0x1f	; 0232FA60
	cmp r3,#0x0	; 0232FA62
	beq loc_0232FAC2	; 0232FA64
	add r2,r2,#0x1	; 0232FA66
	str r2,[r0,#0x18]	; 0232FA68
	ldrh r2,[r1,#0x0]	; 0232FA6A
	mov r0,#0x40	; 0232FA6C
	bic r2,r0	; 0232FA6E
	strh r2,[r1,#0x0]	; 0232FA70
	bl loc_0232FE8C	; 0232FA72
	cmp r0,#0x0	; 0232FA76
	bne loc_0232FAC2	; 0232FA78
	lsl r1,r4,#0	; 0232FA7A
	ldr r0,[pool_0232FAF0]	; 0232FA7C
	str r1,[r0,#0x18]	; 0232FA7E
	mov r4,#0x3	; 0232FA80
	b loc_0232FAC2	; 0232FA82
loc_0232FA84:
	str r4,[r0,#0x18]	; 0232FA84
	b loc_0232FAC2	; 0232FA86
loc_0232FA88:
	mov r4,#0x4	; 0232FA88
	mov r1,#0x0	; 0232FA8A
	ldr r0,[pool_0232FAF0]	; 0232FA8C
	str r1,[r0,#0x18]	; 0232FA8E
	b loc_0232FAC2	; 0232FA90
loc_0232FA92:
	mov r2,#0x0	; 0232FA92
	ldr r1,[pool_0232FAF0]	; 0232FA94
	str r2,[r1,#0x18]	; 0232FA96
	cmp r0,#0x4	; 0232FA98
	bhi loc_0232FAC0	; 0232FA9A
	add r0,r0,r0	; 0232FA9C
P1_SwitchIndexPC_0232FA9C:
	add r0,pc	; 0232FA9E
	ldrh r0,[r0,#(P1_SwitchTable_0232FA9C - (P1_SwitchIndexPC_0232FA9C + 4))]	; 0232FAA0
	lsl r0,r0,#0x10	; 0232FAA2
	asr r0,r0,#0x10	; 0232FAA4
P1_SwitchTargetPC_0232FA9C:
	add r0,pc	; 0232FAA6
	bx r0	; 0232FAA8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232FA9C:
	.halfword (loc_0232FAC0 + 1) - (P1_SwitchTargetPC_0232FA9C + 4)
	.halfword (loc_0232FAB4 + 1) - (P1_SwitchTargetPC_0232FA9C + 4)
	.halfword (loc_0232FAB8 + 1) - (P1_SwitchTargetPC_0232FA9C + 4)
	.halfword (loc_0232FABC + 1) - (P1_SwitchTargetPC_0232FA9C + 4)
	.halfword (loc_0232FAC0 + 1) - (P1_SwitchTargetPC_0232FA9C + 4)
P1_SwitchTable_0232FA9CEnd:
loc_0232FAB4:
	mov r4,#0x4	; 0232FAB4
	b loc_0232FAC2	; 0232FAB6
loc_0232FAB8:
	mov r4,#0x5	; 0232FAB8
	b loc_0232FAC2	; 0232FABA
loc_0232FABC:
	mov r4,#0x1	; 0232FABC
	b loc_0232FAC2	; 0232FABE
loc_0232FAC0:
	mov r4,#0x6	; 0232FAC0
loc_0232FAC2:
	ldr r0,[pool_0232FAF0]	; 0232FAC2
	ldr r1,[r0,#0x18]	; 0232FAC4
	cmp r1,#0x0	; 0232FAC6
	bne loc_0232FAE6	; 0232FAC8
	ldr r1,[r0,#0x0]	; 0232FACA
	cmp r1,#0x0	; 0232FACC
	beq loc_0232FAD4	; 0232FACE
	mov r1,#0x0	; 0232FAD0
	str r1,[r0,#0x0]	; 0232FAD2
loc_0232FAD4:
	ldr r1,[pool_0232FAF0]	; 0232FAD4
	ldr r2,[r1,#0x4]	; 0232FAD6
	cmp r2,#0x0	; 0232FAD8
	beq loc_0232FAE6	; 0232FADA
	mov r0,#0x0	; 0232FADC
	str r0,[r1,#0x4]	; 0232FADE
	add r0,r4,#0x0	; 0232FAE0
	ldr r1,[r1,#0x10]	; 0232FAE2
	blx r2	; 0232FAE4
loc_0232FAE6:
	add sp,#0x4	; 0232FAE6
	pop {r4,r5}	; 0232FAE8
	pop {r3}	; 0232FAEA
	bx r3	; 0232FAEC
	.byte 0xC0, 0x46	; 0232FAF0
pool_0232FAF0:
loc_0232FAF0:
	.word P1_BssStart + 0x2831C	; 0232FAF0
pool_0232FAF4:
loc_0232FAF4:
	.word 0x00007F00	; 0232FAF4
pool_0232FAF8:
loc_0232FAF8:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset	; 0232FAF8
pool_0232FAFC:
loc_0232FAFC:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FAFC
pool_0232FB00:
loc_0232FB00:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x2	; 0232FB00

; ===== function loc_0232FB04 =====
loc_0232FB04:
	push {lr}	; 0232FB04
	sub sp,#0x4	; 0232FB06
	ldr r2,[pool_0232FB28]	; 0232FB08
	mov r3,#0x0	; 0232FB0A
	bl loc_0232FB30	; 0232FB0C
	ldr r1,[pool_0232FB2C]	; 0232FB10
	str r0,[r1,#0x20]	; 0232FB12
	cmp r0,#0x0	; 0232FB14
	bne loc_0232FB1C	; 0232FB16
	blx loc_0232F5F4	; 0232FB18
loc_0232FB1C:
	ldr r0,[pool_0232FB2C]	; 0232FB1C
	ldr r0,[r0,#0x20]	; 0232FB1E
	add sp,#0x4	; 0232FB20
	pop {r3}	; 0232FB22
	bx r3	; 0232FB24
	.byte 0xC0, 0x46	; 0232FB28
pool_0232FB28:
loc_0232FB28:
	.word 0x0232F60D	; 0232FB28
pool_0232FB2C:
loc_0232FB2C:
	.word P1_BssStart + 0x2831C	; 0232FB2C

; ===== function loc_0232FB30 =====
loc_0232FB30:
	push {r4,r5,r6,r7,lr}	; 0232FB30
	sub sp,#0x4	; 0232FB32
	add r5,r0,#0x0	; 0232FB34
	add r7,r1,#0x0	; 0232FB36
	add r4,r2,#0x0	; 0232FB38
	add r6,r3,#0x0	; 0232FB3A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FB3C
	ldr r1,[pool_0232FBA8]	; 0232FB40
	ldr r2,[r1,#0x0]	; 0232FB42
	cmp r2,#0x0	; 0232FB44
	beq loc_0232FB56	; 0232FB46
	blx P1_Arm9RestoreIrqMask	; 0232FB48
	mov r0,#0x1	; 0232FB4C
	add sp,#0x4	; 0232FB4E
	pop {r4,r5,r6,r7}	; 0232FB50
	pop {r3}	; 0232FB52
	bx r3	; 0232FB54
loc_0232FB56:
	mov r2,#0x1	; 0232FB56
	str r2,[r1,#0x0]	; 0232FB58
	blx P1_Arm9RestoreIrqMask	; 0232FB5A
	mov r1,#0x0	; 0232FB5E
	ldr r0,[pool_0232FBA8]	; 0232FB60
	str r1,[r0,#0x18]	; 0232FB62
	str r4,[r0,#0x4]	; 0232FB64
	str r6,[r0,#0x10]	; 0232FB66
	add r0,r7,#0x0	; 0232FB68
	bl loc_0232F6EC	; 0232FB6A
	str r0,[sp,#0x0]	; 0232FB6E
	ldr r1,[pool_0232FBAC]	; 0232FB70
	str r0,[r1,#0x0]	; 0232FB72
	cmp r5,#0x0	; 0232FB74
	bne loc_0232FB84	; 0232FB76
	mov r1,#0xb	; 0232FB78
	ldr r0,[pool_0232FBA8]	; 0232FB7A
	str r1,[r0,#0x14]	; 0232FB7C
	bl loc_0232FEB0	; 0232FB7E
	b loc_0232FB8E	; 0232FB82
loc_0232FB84:
	mov r1,#0xc	; 0232FB84
	ldr r0,[pool_0232FBA8]	; 0232FB86
	str r1,[r0,#0x14]	; 0232FB88
	bl loc_0232FEA4	; 0232FB8A
loc_0232FB8E:
	cmp r0,#0x0	; 0232FB8E
	beq loc_0232FB9C	; 0232FB90
	mov r0,#0x0	; 0232FB92
	add sp,#0x4	; 0232FB94
	pop {r4,r5,r6,r7}	; 0232FB96
	pop {r3}	; 0232FB98
	bx r3	; 0232FB9A
loc_0232FB9C:
	mov r0,#0x3	; 0232FB9C
	add sp,#0x4	; 0232FB9E
	pop {r4,r5,r6,r7}	; 0232FBA0
	pop {r3}	; 0232FBA2
	bx r3	; 0232FBA4
	.byte 0xC0, 0x46	; 0232FBA8
pool_0232FBA8:
loc_0232FBA8:
	.word P1_BssStart + 0x2831C	; 0232FBA8
pool_0232FBAC:
loc_0232FBAC:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FBAC

; ===== function loc_0232FBB0 =====
loc_0232FBB0:
	push {lr}	; 0232FBB0
	sub sp,#0x4	; 0232FBB2
	ldr r2,[pool_0232FBD4]	; 0232FBB4
	mov r3,#0x0	; 0232FBB6
	bl loc_0232FBDC	; 0232FBB8
	ldr r1,[pool_0232FBD8]	; 0232FBBC
	str r0,[r1,#0x20]	; 0232FBBE
	cmp r0,#0x0	; 0232FBC0
	bne loc_0232FBC8	; 0232FBC2
	blx loc_0232F5F4	; 0232FBC4
loc_0232FBC8:
	ldr r0,[pool_0232FBD8]	; 0232FBC8
	ldr r0,[r0,#0x20]	; 0232FBCA
	add sp,#0x4	; 0232FBCC
	pop {r3}	; 0232FBCE
	bx r3	; 0232FBD0
	.byte 0xC0, 0x46	; 0232FBD4
pool_0232FBD4:
loc_0232FBD4:
	.word 0x0232F60D	; 0232FBD4
pool_0232FBD8:
loc_0232FBD8:
	.word P1_BssStart + 0x2831C	; 0232FBD8

; ===== function loc_0232FBDC =====
loc_0232FBDC:
	push {r4,r5,r6,r7,lr}	; 0232FBDC
	sub sp,#0x4	; 0232FBDE
	add r5,r0,#0x0	; 0232FBE0
	add r4,r1,#0x0	; 0232FBE2
	add r6,r2,#0x0	; 0232FBE4
	add r7,r3,#0x0	; 0232FBE6
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FBE8
	ldr r1,[pool_0232FC44]	; 0232FBEC
	ldr r2,[r1,#0x0]	; 0232FBEE
	cmp r2,#0x0	; 0232FBF0
	beq loc_0232FC02	; 0232FBF2
	blx P1_Arm9RestoreIrqMask	; 0232FBF4
	mov r0,#0x1	; 0232FBF8
	add sp,#0x4	; 0232FBFA
	pop {r4,r5,r6,r7}	; 0232FBFC
	pop {r3}	; 0232FBFE
	bx r3	; 0232FC00
loc_0232FC02:
	mov r2,#0x1	; 0232FC02
	str r2,[r1,#0x0]	; 0232FC04
	blx P1_Arm9RestoreIrqMask	; 0232FC06
	cmp r5,#0x0	; 0232FC0A
	bne loc_0232FC16	; 0232FC0C
	mov r1,#0x9	; 0232FC0E
	ldr r0,[pool_0232FC44]	; 0232FC10
	str r1,[r0,#0x14]	; 0232FC12
	b loc_0232FC1C	; 0232FC14
loc_0232FC16:
	mov r1,#0xa	; 0232FC16
	ldr r0,[pool_0232FC44]	; 0232FC18
	str r1,[r0,#0x14]	; 0232FC1A
loc_0232FC1C:
	mov r1,#0x0	; 0232FC1C
	ldr r0,[pool_0232FC44]	; 0232FC1E
	str r1,[r0,#0x18]	; 0232FC20
	str r4,[r0,#0x8]	; 0232FC22
	str r6,[r0,#0x4]	; 0232FC24
	str r7,[r0,#0x10]	; 0232FC26
	bl loc_0232FE98	; 0232FC28
	cmp r0,#0x0	; 0232FC2C
	beq loc_0232FC3A	; 0232FC2E
	mov r0,#0x0	; 0232FC30
	add sp,#0x4	; 0232FC32
	pop {r4,r5,r6,r7}	; 0232FC34
	pop {r3}	; 0232FC36
	bx r3	; 0232FC38
loc_0232FC3A:
	mov r0,#0x3	; 0232FC3A
	add sp,#0x4	; 0232FC3C
	pop {r4,r5,r6,r7}	; 0232FC3E
	pop {r3}	; 0232FC40
	bx r3	; 0232FC42
pool_0232FC44:
loc_0232FC44:
	.word P1_BssStart + 0x2831C	; 0232FC44

; ===== function loc_0232FC48 =====
loc_0232FC48:
	ldr r1,[pool_0232FC50]	; 0232FC48
	str r0,[r1,#0x1c]	; 0232FC4A
	bx lr	; 0232FC4C
	.byte 0xC0, 0x46	; 0232FC50
pool_0232FC50:
loc_0232FC50:
	.word P1_BssStart + 0x2831C	; 0232FC50

; ===== function loc_0232FC54 =====
loc_0232FC54:
	push {lr}	; 0232FC54
	sub sp,#0x4	; 0232FC56
	ldr r1,[pool_0232FC78]	; 0232FC58
	mov r2,#0x0	; 0232FC5A
	bl loc_0232FC80	; 0232FC5C
	ldr r1,[pool_0232FC7C]	; 0232FC60
	str r0,[r1,#0x20]	; 0232FC62
	cmp r0,#0x0	; 0232FC64
	bne loc_0232FC6C	; 0232FC66
	blx loc_0232F5F4	; 0232FC68
loc_0232FC6C:
	ldr r0,[pool_0232FC7C]	; 0232FC6C
	ldr r0,[r0,#0x20]	; 0232FC6E
	add sp,#0x4	; 0232FC70
	pop {r3}	; 0232FC72
	bx r3	; 0232FC74
	.byte 0xC0, 0x46	; 0232FC78
pool_0232FC78:
loc_0232FC78:
	.word 0x0232F60D	; 0232FC78
pool_0232FC7C:
loc_0232FC7C:
	.word P1_BssStart + 0x2831C	; 0232FC7C

; ===== function loc_0232FC80 =====
loc_0232FC80:
	push {r4,r5,lr}	; 0232FC80
	sub sp,#0x4	; 0232FC82
	add r5,r1,#0x0	; 0232FC84
	add r4,r2,#0x0	; 0232FC86
	ldrb r1,[r0,#0x0]	; 0232FC88
	ldr r0,[pool_0232FCDC]	; 0232FC8A
	strb r1,[r0,#0x0]	; 0232FC8C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FC8E
	ldr r1,[pool_0232FCE0]	; 0232FC92
	ldr r2,[r1,#0x0]	; 0232FC94
	cmp r2,#0x0	; 0232FC96
	beq loc_0232FCA8	; 0232FC98
	blx P1_Arm9RestoreIrqMask	; 0232FC9A
	mov r0,#0x1	; 0232FC9E
	add sp,#0x4	; 0232FCA0
	pop {r4,r5}	; 0232FCA2
	pop {r3}	; 0232FCA4
	bx r3	; 0232FCA6
loc_0232FCA8:
	mov r2,#0x1	; 0232FCA8
	str r2,[r1,#0x0]	; 0232FCAA
	blx P1_Arm9RestoreIrqMask	; 0232FCAC
	mov r1,#0xf	; 0232FCB0
	ldr r0,[pool_0232FCE0]	; 0232FCB2
	str r1,[r0,#0x14]	; 0232FCB4
	mov r1,#0x0	; 0232FCB6
	str r1,[r0,#0x18]	; 0232FCB8
	str r5,[r0,#0x4]	; 0232FCBA
	str r4,[r0,#0x10]	; 0232FCBC
	bl loc_0232FE80	; 0232FCBE
	cmp r0,#0x0	; 0232FCC2
	beq loc_0232FCD0	; 0232FCC4
	mov r0,#0x0	; 0232FCC6
	add sp,#0x4	; 0232FCC8
	pop {r4,r5}	; 0232FCCA
	pop {r3}	; 0232FCCC
	bx r3	; 0232FCCE
loc_0232FCD0:
	mov r0,#0x3	; 0232FCD0
	add sp,#0x4	; 0232FCD2
	pop {r4,r5}	; 0232FCD4
	pop {r3}	; 0232FCD6
	bx r3	; 0232FCD8
	.byte 0xC0, 0x46	; 0232FCDC
pool_0232FCDC:
loc_0232FCDC:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FCDC
pool_0232FCE0:
loc_0232FCE0:
	.word P1_BssStart + 0x2831C	; 0232FCE0

; ===== function loc_0232FCE4 =====
P1_Entry_0232FCE4:
	push {lr}	; 0232FCE4
	sub sp,#0x4	; 0232FCE6
	ldr r2,[pool_0232FD08]	; 0232FCE8
	mov r3,#0x0	; 0232FCEA
	bl loc_0232FD10	; 0232FCEC
	ldr r1,[pool_0232FD0C]	; 0232FCF0
	str r0,[r1,#0x20]	; 0232FCF2
	cmp r0,#0x0	; 0232FCF4
	bne loc_0232FCFC	; 0232FCF6
	blx loc_0232F5F4	; 0232FCF8
loc_0232FCFC:
	ldr r0,[pool_0232FD0C]	; 0232FCFC
	ldr r0,[r0,#0x20]	; 0232FCFE
	add sp,#0x4	; 0232FD00
	pop {r3}	; 0232FD02
	bx r3	; 0232FD04
	.byte 0xC0, 0x46	; 0232FD08
pool_0232FD08:
loc_0232FD08:
	.word 0x0232F60D	; 0232FD08
pool_0232FD0C:
loc_0232FD0C:
	.word P1_BssStart + 0x2831C	; 0232FD0C

; ===== function loc_0232FD10 =====
loc_0232FD10:
	push {r4,r5,r6,lr}	; 0232FD10
	add r6,r1,#0x0	; 0232FD12
	add r5,r2,#0x0	; 0232FD14
	add r4,r3,#0x0	; 0232FD16
	ldr r1,[pool_0232FD6C]	; 0232FD18
	bl loc_0232F688	; 0232FD1A
	add r0,r6,#0x0	; 0232FD1E
	ldr r1,[pool_0232FD70]	; 0232FD20
	bl loc_0232F618	; 0232FD22
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FD26
	ldr r1,[pool_0232FD74]	; 0232FD2A
	ldr r2,[r1,#0x0]	; 0232FD2C
	cmp r2,#0x0	; 0232FD2E
	beq loc_0232FD3E	; 0232FD30
	blx P1_Arm9RestoreIrqMask	; 0232FD32
	mov r0,#0x1	; 0232FD36
	pop {r4,r5,r6}	; 0232FD38
	pop {r3}	; 0232FD3A
	bx r3	; 0232FD3C
loc_0232FD3E:
	mov r2,#0x1	; 0232FD3E
	str r2,[r1,#0x0]	; 0232FD40
	blx P1_Arm9RestoreIrqMask	; 0232FD42
	mov r1,#0x5	; 0232FD46
	ldr r0,[pool_0232FD74]	; 0232FD48
	str r1,[r0,#0x14]	; 0232FD4A
	mov r1,#0x0	; 0232FD4C
	str r1,[r0,#0x18]	; 0232FD4E
	str r5,[r0,#0x4]	; 0232FD50
	str r4,[r0,#0x10]	; 0232FD52
	bl loc_0232FEBC	; 0232FD54
	cmp r0,#0x0	; 0232FD58
	beq loc_0232FD64	; 0232FD5A
	mov r0,#0x0	; 0232FD5C
	pop {r4,r5,r6}	; 0232FD5E
	pop {r3}	; 0232FD60
	bx r3	; 0232FD62
loc_0232FD64:
	mov r0,#0x3	; 0232FD64
	pop {r4,r5,r6}	; 0232FD66
	pop {r3}	; 0232FD68
	bx r3	; 0232FD6A
pool_0232FD6C:
loc_0232FD6C:
	.word 0x027FFDE8	; 0232FD6C
pool_0232FD70:
loc_0232FD70:
	.word 0x027FFDEC	; 0232FD70
pool_0232FD74:
loc_0232FD74:
	.word P1_BssStart + 0x2831C	; 0232FD74

; ===== function loc_0232FD78 =====
loc_0232FD78:
	push {lr}	; 0232FD78
	sub sp,#0x4	; 0232FD7A
	ldr r2,[pool_0232FD9C]	; 0232FD7C
	mov r3,#0x0	; 0232FD7E
	bl loc_0232FDA4	; 0232FD80
	ldr r1,[pool_0232FDA0]	; 0232FD84
	str r0,[r1,#0x20]	; 0232FD86
	cmp r0,#0x0	; 0232FD88
	bne loc_0232FD90	; 0232FD8A
	blx loc_0232F5F4	; 0232FD8C
loc_0232FD90:
	ldr r0,[pool_0232FDA0]	; 0232FD90
	ldr r0,[r0,#0x20]	; 0232FD92
	add sp,#0x4	; 0232FD94
	pop {r3}	; 0232FD96
	bx r3	; 0232FD98
	.byte 0xC0, 0x46	; 0232FD9C
pool_0232FD9C:
loc_0232FD9C:
	.word 0x0232F60D	; 0232FD9C
pool_0232FDA0:
loc_0232FDA0:
	.word P1_BssStart + 0x2831C	; 0232FDA0

; ===== function loc_0232FDA4 =====
loc_0232FDA4:
	push {r4,r5,r6,r7,lr}	; 0232FDA4
	sub sp,#0x4	; 0232FDA6
	add r5,r0,#0x0	; 0232FDA8
	add r4,r1,#0x0	; 0232FDAA
	add r6,r2,#0x0	; 0232FDAC
	add r7,r3,#0x0	; 0232FDAE
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FDB0
	ldr r1,[pool_0232FE00]	; 0232FDB4
	ldr r2,[r1,#0x0]	; 0232FDB6
	cmp r2,#0x0	; 0232FDB8
	beq loc_0232FDCA	; 0232FDBA
	blx P1_Arm9RestoreIrqMask	; 0232FDBC
	mov r0,#0x1	; 0232FDC0
	add sp,#0x4	; 0232FDC2
	pop {r4,r5,r6,r7}	; 0232FDC4
	pop {r3}	; 0232FDC6
	bx r3	; 0232FDC8
loc_0232FDCA:
	mov r2,#0x1	; 0232FDCA
	str r2,[r1,#0x0]	; 0232FDCC
	blx P1_Arm9RestoreIrqMask	; 0232FDCE
	mov r1,#0x2	; 0232FDD2
	ldr r0,[pool_0232FE00]	; 0232FDD4
	str r1,[r0,#0x14]	; 0232FDD6
	mov r1,#0x0	; 0232FDD8
	str r1,[r0,#0x18]	; 0232FDDA
	str r5,[r0,#0x8]	; 0232FDDC
	str r4,[r0,#0xc]	; 0232FDDE
	str r6,[r0,#0x4]	; 0232FDE0
	str r7,[r0,#0x10]	; 0232FDE2
	bl loc_0232FEC8	; 0232FDE4
	cmp r0,#0x0	; 0232FDE8
	beq loc_0232FDF6	; 0232FDEA
	mov r0,#0x0	; 0232FDEC
	add sp,#0x4	; 0232FDEE
	pop {r4,r5,r6,r7}	; 0232FDF0
	pop {r3}	; 0232FDF2
	bx r3	; 0232FDF4
loc_0232FDF6:
	mov r0,#0x3	; 0232FDF6
	add sp,#0x4	; 0232FDF8
	pop {r4,r5,r6,r7}	; 0232FDFA
	pop {r3}	; 0232FDFC
	bx r3	; 0232FDFE
pool_0232FE00:
loc_0232FE00:
	.word P1_BssStart + 0x2831C	; 0232FE00

; ===== function loc_0232FE04 =====
loc_0232FE04:
	push {r4,r5,lr}	; 0232FE04
	sub sp,#0x4	; 0232FE06
	ldr r0,[pool_0232FE48]	; 0232FE08
	ldrh r1,[r0,#0x0]	; 0232FE0A
	cmp r1,#0x0	; 0232FE0C
	bne loc_0232FE3E	; 0232FE0E
	mov r1,#0x1	; 0232FE10
	strh r1,[r0,#0x0]	; 0232FE12
	mov r1,#0x0	; 0232FE14
	ldr r0,[pool_0232FE4C]	; 0232FE16
	str r1,[r0,#0x0]	; 0232FE18
	str r1,[r0,#0x4]	; 0232FE1A
	str r1,[r0,#0x1c]	; 0232FE1C
	str r1,[r0,#0x8]	; 0232FE1E
	str r1,[r0,#0xc]	; 0232FE20
	bl loc_0232E7D4	; 0232FE22
	mov r5,#0x5	; 0232FE26
	mov r4,#0x1	; 0232FE28
loc_0232FE2A:
	add r0,r5,#0x0	; 0232FE2A
	add r1,r4,#0x0	; 0232FE2C
	bl loc_0232E948	; 0232FE2E
	cmp r0,#0x0	; 0232FE32
	beq loc_0232FE2A	; 0232FE34
	mov r0,#0x5	; 0232FE36
	ldr r1,[pool_0232FE50]	; 0232FE38
	bl P1_SetPxiReceiveCallback	; 0232FE3A
loc_0232FE3E:
	add sp,#0x4	; 0232FE3E
	pop {r4,r5}	; 0232FE40
	pop {r3}	; 0232FE42
	bx r3	; 0232FE44
	.byte 0xC0, 0x46	; 0232FE48
pool_0232FE48:
loc_0232FE48:
	.word P1_BssStart + 0x28318	; 0232FE48
pool_0232FE4C:
loc_0232FE4C:
	.word P1_BssStart + 0x2831C	; 0232FE4C
pool_0232FE50:
loc_0232FE50:
	.word P1_PxiCallback_0232F81C + 1	; 0232FE50
loc_0232FE54:
	push {lr}	; 0232FE54
	sub sp,#0x4	; 0232FE56
	add r1,r0,#0x0	; 0232FE58
	mov r0,#0x5	; 0232FE5A
	lsl r1,r1,#0x8	; 0232FE5C
	ldr r2,[pool_0232FE7C]	; 0232FE5E
	and r1,r2	; 0232FE60
	mov r2,#0x0	; 0232FE62
	bl loc_0232E8B4	; 0232FE64
	cmp r0,#0x0	; 0232FE68
	blt loc_0232FE74	; 0232FE6A
	mov r0,#0x1	; 0232FE6C
	add sp,#0x4	; 0232FE6E
	pop {r3}	; 0232FE70
	bx r3	; 0232FE72
loc_0232FE74:
	mov r0,#0x0	; 0232FE74
	add sp,#0x4	; 0232FE76
	pop {r3}	; 0232FE78
	bx r3	; 0232FE7A
pool_0232FE7C:
loc_0232FE7C:
	.word 0x00007F00	; 0232FE7C

; ===== function loc_0232FE80 =====
loc_0232FE80:
	mov r0,#0x28	; 0232FE80
	ldr r3,[pool_0232FE88]	; 0232FE82
	bx r3	; 0232FE84
	.byte 0xC0, 0x46	; 0232FE88
pool_0232FE88:
loc_0232FE88:
	.word loc_0232FE54 + 1	; 0232FE88

; ===== function loc_0232FE8C =====
loc_0232FE8C:
	mov r0,#0x27	; 0232FE8C
	ldr r3,[pool_0232FE94]	; 0232FE8E
	bx r3	; 0232FE90
	.byte 0xC0, 0x46	; 0232FE94
pool_0232FE94:
loc_0232FE94:
	.word loc_0232FE54 + 1	; 0232FE94

; ===== function loc_0232FE98 =====
loc_0232FE98:
	mov r0,#0x17	; 0232FE98
	ldr r3,[pool_0232FEA0]	; 0232FE9A
	bx r3	; 0232FE9C
	.byte 0xC0, 0x46	; 0232FEA0
pool_0232FEA0:
loc_0232FEA0:
	.word loc_0232FE54 + 1	; 0232FEA0

; ===== function loc_0232FEA4 =====
loc_0232FEA4:
	mov r0,#0x25	; 0232FEA4
	ldr r3,[pool_0232FEAC]	; 0232FEA6
	bx r3	; 0232FEA8
	.byte 0xC0, 0x46	; 0232FEAC
pool_0232FEAC:
loc_0232FEAC:
	.word loc_0232FE54 + 1	; 0232FEAC

; ===== function loc_0232FEB0 =====
loc_0232FEB0:
	mov r0,#0x24	; 0232FEB0
	ldr r3,[pool_0232FEB8]	; 0232FEB2
	bx r3	; 0232FEB4
	.byte 0xC0, 0x46	; 0232FEB8
pool_0232FEB8:
loc_0232FEB8:
	.word loc_0232FE54 + 1	; 0232FEB8

; ===== function loc_0232FEBC =====
loc_0232FEBC:
	mov r0,#0x20	; 0232FEBC
	ldr r3,[pool_0232FEC4]	; 0232FEBE
	bx r3	; 0232FEC0
	.byte 0xC0, 0x46	; 0232FEC4
pool_0232FEC4:
loc_0232FEC4:
	.word loc_0232FE54 + 1	; 0232FEC4

; ===== function loc_0232FEC8 =====
loc_0232FEC8:
	mov r0,#0x10	; 0232FEC8
	ldr r3,[pool_0232FED0]	; 0232FECA
	bx r3	; 0232FECC
	.byte 0xC0, 0x46	; 0232FED0
pool_0232FED0:
loc_0232FED0:
	.word loc_0232FE54 + 1	; 0232FED0
	.byte 0xD9, 0xD1, 0x32, 0x02, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00, 0x49, 0x3E, 0x36, 0x02	; 0232FEE4
	.byte 0xE5, 0x78, 0x36, 0x02, 0x01, 0x8E, 0x35, 0x02	; 0232FEE4
P1_Data_0232FEEC:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FEEC
P1_Data_0232FEF4:
	.byte 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00	; 0232FEF4
	.byte 0x02, 0x00, 0x05, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00, 0x02, 0x00	; 0232FF14
	.byte 0x05, 0x00, 0x04, 0x00, 0x01, 0x00, 0x02, 0x00, 0x05, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00	; 0232FF24
P1_Data_0232FF24:
	.byte 0x09, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00	; 0232FF24
P1_Data_0232FF34:
	.byte 0x05, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x06, 0x00, 0x07, 0x00	; 0232FF34
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00	; 0232FF54
	.byte 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x54, 0x00, 0x06, 0x00, 0x00, 0x00	; 0232FF64
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x02, 0x00, 0x00, 0x00	; 0232FF74
	.byte 0x32, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0232FF84
	.byte 0x34, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FF94
	.byte 0x2C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD0, 0xFF, 0x03, 0x00, 0x00, 0x00	; 0232FFA4
	.byte 0x2E, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x70, 0x07, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0232FFB4
	.byte 0x00, 0x80, 0x08, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x08, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 0232FFC4
	.byte 0x00, 0x70, 0x07, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x07, 0x00	; 0232FFD4
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x07, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x0A, 0x00	; 0232FFE4
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x0A, 0x00, 0x00, 0x60, 0x08, 0x00, 0x00, 0xE0, 0x04, 0x00	; 0232FFF4
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x07, 0x00	; 02330004
	.byte 0x00, 0x60, 0x08, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x04, 0x00	; 02330014
	.byte 0x00, 0x90, 0x07, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x07, 0x00, 0x00, 0x10, 0x07, 0x00	; 02330024
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x01, 0x00	; 02330034
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x01, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x04, 0x00	; 02330044
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x80, 0x0E, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 02330054
	.byte 0x00, 0x90, 0x0F, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x90, 0x0F, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 02330064
	.byte 0x00, 0x80, 0x0E, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 02330074
	.byte 0x00, 0x80, 0x01, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 02330084
	.byte 0x00, 0x70, 0x00, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00	; 02330094
	.byte 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00	; 02330094
P1_Data_0233009C:
	.byte 0x0A, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00	; 0233009C
	.byte 0x08, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00	; 023300B4
	.byte 0x04, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 023300C4
P1_Data_023300C4:
	.byte 0x00, 0x00	; 023300C4
P1_Data_023300C6:
	.byte 0x95, 0x00	; 023300C6
P1_Data_023300C8:
	.byte 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x02, 0x00	; 023300C8
	.byte 0x8A, 0x00, 0x74, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x00, 0x00, 0x06, 0x00, 0x02, 0x00, 0x91, 0x00	; 023300E4
	.byte 0x7B, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x00, 0x00, 0x09, 0x00, 0x02, 0x00, 0x86, 0x00, 0x70, 0x00	; 023300F4
	.byte 0x0E, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x02, 0x00, 0x8F, 0x00, 0x79, 0x00, 0x0E, 0x00	; 02330104
	.byte 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x8B, 0x00, 0x75, 0x00, 0x0E, 0x00, 0x01, 0x00	; 02330114
	.byte 0x05, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8D, 0x00, 0x77, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x06, 0x00	; 02330124
	.byte 0x06, 0x00, 0x03, 0x00, 0x8C, 0x00, 0x76, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x07, 0x00, 0x06, 0x00	; 02330134
	.byte 0x03, 0x00, 0x8E, 0x00, 0x78, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x08, 0x00, 0x06, 0x00, 0x03, 0x00	; 02330144
	.byte 0x92, 0x00, 0x7C, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x09, 0x00, 0x09, 0x00, 0x03, 0x00, 0x93, 0x00	; 02330154
	.byte 0x7D, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0A, 0x00, 0x09, 0x00, 0x03, 0x00, 0x94, 0x00, 0x7E, 0x00	; 02330164
	.byte 0x0E, 0x00, 0x02, 0x00, 0x0B, 0x00, 0x09, 0x00, 0x03, 0x00, 0x88, 0x00, 0x72, 0x00, 0x0E, 0x00	; 02330174
	.byte 0x03, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x03, 0x00, 0x89, 0x00, 0x73, 0x00, 0x0E, 0x00, 0x03, 0x00	; 02330184
	.byte 0x0D, 0x00, 0x0C, 0x00, 0x01, 0x00, 0x90, 0x00, 0x7A, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330194
	.byte 0x02, 0x00, 0x01, 0x00, 0x85, 0x00, 0x6F, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF	; 023301A4
	.byte 0x03, 0x00, 0x87, 0x00, 0x71, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x10, 0x00, 0x0C, 0x00, 0x02, 0x00	; 023301B4
	.byte 0x85, 0x00, 0x6F, 0x00, 0x0F, 0x00, 0x11, 0x00, 0x00, 0x00, 0xFF, 0xFF	; 023301B4
P1_Data_023301C0:
	.byte 0x00, 0x00, 0x60, 0x00	; 023301C0
P1_Data_023301C4:
	.byte 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00	; 023301C4
P1_Data_023301CC:
	.byte 0x03, 0x00, 0x24, 0x00	; 023301CC
P1_Data_023301D0:
	.byte 0x01, 0x00	; 023301D0
P1_Data_023301D2:
	.byte 0x01, 0x00	; 023301D2
	.byte 0x02, 0x00, 0x2B, 0x00, 0x00, 0x00, 0x02, 0x00	; 023301D4
P1_Data_023301DC:
	.byte 0x30, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00	; 023301DC
	.byte 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00, 0x38, 0x00, 0x39, 0x00, 0x00, 0x00, 0x00, 0x00	; 023301F4
P1_Data_023301F4:
	.byte 0x03, 0x03, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0xFF, 0x0F, 0xFF, 0x0F, 0xC7, 0x01, 0x00, 0x00	; 023301F4
	.byte 0x21, 0x86, 0x32, 0x02, 0x1D, 0x86, 0x32, 0x02, 0x19, 0x86, 0x32, 0x02, 0x00, 0x00, 0x00, 0x00	; 02330214
	.byte 0x15, 0x86, 0x32, 0x02, 0x24, 0xD4, 0x00, 0x00, 0x0F, 0x40, 0x00, 0x00, 0x00, 0x01, 0x81, 0x82	; 02330224
	.byte 0x82, 0x83, 0x0F, 0x83, 0x0C, 0xC3, 0x03, 0x83, 0x01, 0x83, 0x04, 0xC3, 0x08, 0x0E, 0x02, 0xC2	; 02330234
	.byte 0x0D, 0xC2, 0x07, 0x0B, 0x06, 0x0A, 0x05, 0x09	; 0233023C
.arm
	b loc_023302B8	; 0233023C
	.byte 0x00, 0x40, 0x2D, 0xE9, 0x68, 0x30, 0x9F, 0xE5, 0x10, 0x00, 0x93, 0xE5, 0x20, 0x10, 0x93, 0xE5	; 02330250
	.byte 0x18, 0x10, 0x80, 0xE5, 0x14, 0x00, 0x93, 0xE5, 0x28, 0x10, 0x90, 0xE5, 0x01, 0x12, 0x81, 0xE3	; 02330260
	.byte 0x28, 0x10, 0x80, 0xE5, 0x44, 0x10, 0x9F, 0xE5, 0xFC, 0x10, 0x80, 0xE5, 0x28, 0x20, 0xA0, 0xE3	; 02330270
	.byte 0x3C, 0x10, 0x80, 0xE2, 0x0C, 0x00, 0x8F, 0xE2, 0x08, 0x30, 0x93, 0xE5, 0x33, 0xFF, 0x2F, 0xE1	; 02330280
	.byte 0x00, 0x40, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1, 0x00, 0x50, 0xA0, 0xE3, 0x00, 0xC0, 0x97, 0xE5	; 02330290
	.byte 0x66, 0x00, 0x5C, 0xE3, 0xEA, 0x40, 0xA0, 0x03, 0x29, 0x40, 0x4F, 0x05, 0x15, 0x5F, 0x07, 0x0E	; 023302A0
	.byte 0x07, 0xC0, 0x0C, 0xE2, 0x00, 0x30, 0x9F, 0xE5, 0x02, 0x00, 0x00, 0xEA, 0x00, 0x52, 0x00, 0x02	; 023302B0
	.byte 0xFE, 0xFF, 0xFF, 0xEA, 0x8C, 0x52, 0x00, 0x02	; 023302B8
loc_023302B8:
	stmdb sp!,{r4,r7,lr}	; 023302B8
	ldr r7,[pool_02330330]	; 023302BC
	cmp r0,#0x0	; 023302C0
	bne loc_02330320	; 023302C4
	ldr r0,[r7,#0x1c]	; 023302C8
	ldr r1,[pool_02330334]	; 023302CC
	mov r2,#0x40	; 023302D0
	ldr r4,[r7,#0x8]	; 023302D4
	blx r4	; 023302D8
	mov r1,#0x40	; 023302DC
	str r1,[sp,#-0x4]!	; 023302E0
	ldr r0,[pool_02330338]	; 023302E4
	mov r1,r6	; 023302E8
	mov r2,r5	; 023302EC
	ldr r3,[pool_02330334]	; 023302F0
	ldr r4,[r7,#0xc]	; 023302F4
	blx r4	; 023302F8
	add sp,sp,#0x4	; 023302FC
	ldr r0,[pool_02330338]	; 02330300
	sub r1,r7,#0x28	; 02330304
	mov r2,#0x14	; 02330308
	ldr r4,[r7,#0x18]	; 0233030C
	blx r4	; 02330310
	cmp r0,#0x0	; 02330314
	ldrne r4,[r7,#0x0]	; 02330318
	blxne r4	; 0233031C
loc_02330320:
	ldr r4,[r7,#0x4]	; 02330320
	blx r4	; 02330324
	ldmia sp!,{r4,r7,lr}	; 02330328
	bx lr	; 0233032C
pool_02330330:
loc_02330330:
	.word 0x0200528C	; 02330330
pool_02330334:
loc_02330334:
	.word 0x02005114	; 02330334
pool_02330338:
loc_02330338:
	.word 0x02005100	; 02330338
	.byte 0x8A, 0xE8, 0xA7, 0xC0, 0xA0, 0x85, 0x06, 0x81, 0x0D, 0x5F, 0x93, 0xBB, 0x74, 0x28, 0x62, 0xAB	; 0233034C
	.byte 0x99, 0xA8, 0x19, 0x6D, 0xEB, 0x0E, 0x4A, 0xA4, 0x94, 0xFF, 0xF0, 0x94, 0x71, 0x1A, 0xE1, 0xA3	; 0233035C
	.byte 0x1D, 0x90, 0x22, 0xA0, 0x8D, 0x79, 0xE5, 0x31, 0x85, 0x27, 0xF6, 0x31, 0x5B, 0xD0, 0xC0, 0xC5	; 0233036C
	.byte 0x21, 0x8C, 0x79, 0x7C, 0x14, 0x3B, 0x14, 0xE8, 0x07, 0x98, 0x32, 0xB8, 0x79, 0x49, 0xC6, 0x09	; 0233037C
	.byte 0xEE, 0xB5, 0x64, 0x4F, 0x42, 0xFA, 0x34, 0x00, 0x6D, 0x3D, 0x58, 0xD4, 0xA0, 0x2B, 0x45, 0xB4	; 0233038C
	.byte 0x09, 0xD8, 0xF5, 0x25, 0x9C, 0x89, 0xB7, 0x0C, 0x5A, 0x5D, 0x7A, 0x19, 0xD0, 0x21, 0x6B, 0x6B	; 0233039C
	.byte 0xF9, 0xBE, 0xEB, 0x67, 0x71, 0x05, 0x5F, 0xBE, 0xA5, 0x27, 0x47, 0x3C, 0xF7, 0x8C, 0xFB, 0xD2	; 023303AC
	.byte 0x90, 0x35, 0xBB, 0x30, 0x64, 0x28, 0xBD, 0xF7, 0x8C, 0x81, 0x31, 0x98, 0xA3, 0x3E, 0x3B, 0xC7	; 023303BC
	.byte 0x9B, 0x98, 0x2C, 0x23, 0x65, 0x05, 0x37, 0xC8, 0x17, 0xD1, 0x1B, 0x22, 0xEC, 0x95, 0x01, 0x02	; 023303CC
	.byte 0xA4, 0x82, 0x05, 0x02, 0xA4, 0x8B, 0x05, 0x02, 0x08, 0xC6, 0x05, 0x02, 0x10, 0xC1, 0x05, 0x02	; 023303DC
	.byte 0xD8, 0xC2, 0x05, 0x02, 0x38, 0xC7, 0x06, 0x02, 0xEC, 0x49, 0x08, 0x02, 0xB4, 0xA3, 0xFE, 0xEB	; 023303EC
	.byte 0x84, 0x01, 0x00, 0xEA, 0xEC, 0x49, 0x00, 0x02, 0x9E, 0x11, 0x7F, 0xD6, 0x1D, 0x1A, 0xE6, 0xED	; 023303FC
	.byte 0xC5, 0xD6, 0x55, 0xC6, 0x35, 0x4E, 0x06, 0x76, 0x7B, 0x1C, 0x7C, 0x83, 0x35, 0xF2, 0x43, 0x1B	; 0233040C
	.byte 0x69, 0xFE, 0x8E, 0x59, 0xFD, 0xD5, 0x0C, 0x75, 0x59, 0x0D, 0x9C, 0x9E, 0x09, 0x95, 0xB6, 0xA7	; 0233041C
	.byte 0x92, 0xA7, 0xB9, 0x90, 0x38, 0xF7, 0x63, 0xB9, 0xF7, 0x27, 0xB5, 0xE2, 0x64, 0xF4, 0x1E, 0x67	; 0233042C
	.byte 0x30, 0x15, 0x2B, 0xD7, 0xF1, 0x9A, 0xC8, 0xAC, 0x5F, 0x7C, 0x36, 0x03, 0x94, 0x65, 0x73, 0x15	; 0233043C
	.byte 0xA3, 0xD8, 0x66, 0xED, 0x42, 0xB0, 0xD3, 0x19, 0x04, 0x54, 0x11, 0x58, 0xCC, 0x19, 0x46, 0xA8	; 0233044C
	.byte 0xE4, 0xAC, 0x6D, 0xD3, 0xD6, 0x59, 0xF2, 0x3E, 0xF8, 0x49, 0x50, 0xE9, 0x29, 0x15, 0xDC, 0xE1	; 0233045C
	.byte 0xA5, 0xDE, 0x59, 0x01, 0x17, 0xFF, 0xA3, 0x35, 0x63, 0x27, 0x56, 0xC1, 0x5D, 0x36, 0x9A, 0x18	; 0233046C
	.byte 0x89, 0xE2, 0xB3, 0x93, 0xA8, 0x8B, 0x1E, 0xE8, 0x6A, 0x0D, 0x57, 0x65, 0xD0, 0x8A, 0xFB, 0xEB	; 0233047C
	.byte 0x50, 0x1D, 0x04, 0x6D, 0x78, 0x95, 0x01, 0x02, 0x90, 0x7D, 0x05, 0x02, 0x90, 0x86, 0x05, 0x02	; 0233048C
	.byte 0xF4, 0xC0, 0x05, 0x02, 0xFC, 0xBB, 0x05, 0x02, 0xC4, 0xBD, 0x05, 0x02, 0xE4, 0xC1, 0x06, 0x02	; 0233049C
	.byte 0x48, 0x44, 0x08, 0x02, 0xF9, 0xA4, 0xFE, 0xEB, 0x84, 0x01, 0x00, 0xEA, 0xEC, 0x49, 0x00, 0x02	; 023304AC
; ASCII VIB build identifier with the embedded build date. / 含内嵌构建日期的 ASCII VIB 构建标识。
P1_VibBuildIdentifier:
	.ascii "VIB2.11May 26 2005", 0
	.byte 0x00	; 023304BF
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P1_CrtDataInitTable:
	.word P1_CopyDescriptors, P1_CopyDescriptorsEnd
	.word P1_ItcmLoadStart
	.word P1_BssStart, P3_FirmwareUiEntry
	.byte 0x2D, 0xFD, 0x5B, 0xFE, 0x97, 0xFE, 0xBB, 0xFE, 0xD4, 0xFE, 0xE7, 0xFE, 0xF7, 0xFE, 0x04, 0xFF	; 023304D4
	.byte 0x10, 0xFF, 0x1A, 0xFF, 0x23, 0xFF, 0x2C, 0xFF, 0x33, 0xFF, 0x3A, 0xFF, 0x40, 0xFF, 0x46, 0xFF	; 023304E4
	.byte 0x4C, 0xFF, 0x51, 0xFF, 0x56, 0xFF, 0x5B, 0xFF, 0x5F, 0xFF, 0x64, 0xFF, 0x68, 0xFF, 0x6C, 0xFF	; 023304F4
	.byte 0x6F, 0xFF, 0x73, 0xFF, 0x76, 0xFF, 0x7A, 0xFF, 0x7D, 0xFF, 0x80, 0xFF, 0x83, 0xFF, 0x86, 0xFF	; 02330504
	.byte 0x88, 0xFF, 0x8B, 0xFF, 0x8E, 0xFF, 0x90, 0xFF, 0x92, 0xFF, 0x95, 0xFF, 0x97, 0xFF, 0x99, 0xFF	; 02330514
	.byte 0x9C, 0xFF, 0x9E, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA4, 0xFF, 0xA6, 0xFF, 0xA8, 0xFF, 0xAA, 0xFF	; 02330524
	.byte 0xAB, 0xFF, 0xAD, 0xFF, 0xAF, 0xFF, 0xB1, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB7, 0xFF	; 02330534
	.byte 0xB9, 0xFF, 0xBA, 0xFF, 0xBC, 0xFF, 0xBD, 0xFF, 0xBF, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC3, 0xFF	; 02330544
	.byte 0xC4, 0xFF, 0xC6, 0xFF, 0xC7, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF, 0xCB, 0xFF, 0xCC, 0xFF, 0xCD, 0xFF	; 02330554
	.byte 0xCF, 0xFF, 0xD0, 0xFF, 0xD1, 0xFF, 0xD2, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD7, 0xFF	; 02330564
	.byte 0xD8, 0xFF, 0xD9, 0xFF, 0xDA, 0xFF, 0xDB, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDE, 0xFF, 0xDF, 0xFF	; 02330574
	.byte 0xE0, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE3, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF, 0xE6, 0xFF, 0xE7, 0xFF	; 02330584
	.byte 0xE8, 0xFF, 0xE9, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEB, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEE, 0xFF	; 02330594
	.byte 0xEF, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF1, 0xFF, 0xF2, 0xFF, 0xF3, 0xFF, 0xF4, 0xFF, 0xF4, 0xFF	; 023305A4
	.byte 0xF5, 0xFF, 0xF6, 0xFF, 0xF7, 0xFF, 0xF7, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFA, 0xFF	; 023305B4
	.byte 0xFB, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF, 0xFD, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00	; 023305C4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023305D4
P1_Data_023305E0:
	.byte 0x00, 0x00, 0xAA, 0x01	; 023305E0
	.byte 0x50, 0x03, 0xED, 0x04, 0x82, 0x06, 0xFE, 0x07, 0x65, 0x09, 0xB1, 0x0A, 0xE3, 0x0B, 0xF0, 0x0C	; 023305E4
	.byte 0xD9, 0x0D, 0x9B, 0x0E, 0x37, 0x0F, 0xA6, 0x0F, 0xE9, 0x0F, 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F	; 023305F4
	.byte 0x39, 0x0F, 0xA1, 0x0E, 0xDC, 0x0D, 0xF4, 0x0C, 0xE8, 0x0B, 0xBA, 0x0A, 0x6A, 0x09, 0x04, 0x08	; 02330604
	.byte 0x87, 0x06, 0xF9, 0x04, 0x56, 0x03, 0xB1, 0x01, 0x06, 0x00, 0x5C, 0xFE, 0xB0, 0xFC, 0x13, 0xFB	; 02330614
	.byte 0x84, 0xF9, 0x07, 0xF8, 0x9B, 0xF6, 0x4F, 0xF5, 0x21, 0xF4, 0x13, 0xF3, 0x27, 0xF2, 0x65, 0xF1	; 02330624
	.byte 0xCB, 0xF0, 0x5B, 0xF0, 0x17, 0xF0, 0x00, 0xF0, 0x16, 0xF0, 0x58, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1	; 02330634
	.byte 0x21, 0xF2, 0x08, 0xF3, 0x18, 0xF4, 0x46, 0xF5, 0x91, 0xF6, 0xF7, 0xF7, 0x79, 0xF9, 0x07, 0xFB	; 02330644
	.byte 0xA3, 0xFC, 0x49, 0xFE	; 02330654
P1_Data_02330658:
	.byte 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F, 0x39, 0x0F, 0x9E, 0x0E, 0xDC, 0x0D	; 02330658
	.byte 0xF4, 0x0C, 0xE8, 0x0B, 0xB5, 0x0A, 0x6A, 0x09, 0x04, 0x08, 0x87, 0x06, 0xF3, 0x04, 0x56, 0x03	; 02330664
	.byte 0xB1, 0x01, 0x06, 0x00, 0x56, 0xFE, 0xB0, 0xFC, 0x13, 0xFB, 0x84, 0xF9, 0x02, 0xF8, 0x9B, 0xF6	; 02330674
	.byte 0x4F, 0xF5, 0x21, 0xF4, 0x10, 0xF3, 0x27, 0xF2, 0x65, 0xF1, 0xCB, 0xF0, 0x5A, 0xF0, 0x17, 0xF0	; 02330684
	.byte 0x00, 0xF0, 0x16, 0xF0, 0x59, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1, 0x21, 0xF2, 0x0C, 0xF3, 0x18, 0xF4	; 02330694
	.byte 0x46, 0xF5, 0x91, 0xF6, 0xFC, 0xF7, 0x79, 0xF9, 0x07, 0xFB, 0xA3, 0xFC, 0x4F, 0xFE, 0xFA, 0xFF	; 023306A4
	.byte 0xA4, 0x01, 0x4A, 0x03, 0xED, 0x04, 0x7C, 0x06, 0xF9, 0x07, 0x5F, 0x09, 0xB1, 0x0A, 0xDF, 0x0B	; 023306B4
	.byte 0xED, 0x0C, 0xD6, 0x0D, 0x9B, 0x0E, 0x35, 0x0F, 0xA5, 0x0F, 0xE8, 0x0F, 0x83, 0x00, 0x00, 0x00	; 023306C4
	.byte 0x80, 0x00, 0x00, 0x00, 0x96, 0x00, 0x00, 0x00, 0x97, 0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0x00	; 023306D4
	.byte 0x6E, 0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 023306E4
	.byte 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 023306F4
	.byte 0x0C, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 02330704
	.byte 0x4D, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00	; 02330714
	.byte 0x59, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00	; 02330724
	.byte 0x59, 0x00, 0x00, 0x00	; 02330734
P1_Data_02330738:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x00, 0x00	; 02330738
	.byte 0xA9, 0x00, 0x00, 0x00	; 02330744
P1_Data_02330748:
	.byte 0x58, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x80, 0x6B, 0x3D, 0x02	; 02330748
	.byte 0x20, 0x85, 0x3D, 0x02, 0x60, 0x99, 0x3D, 0x02, 0xA0, 0xAF, 0x3D, 0x02, 0xA0, 0xC5, 0x3D, 0x02	; 02330754
	.byte 0x80, 0xDB, 0x3D, 0x02	; 02330764
P1_Data_02330768:
	.byte 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00	; 02330768
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04, 0x00	; 02330774
	.byte 0x06, 0x00, 0x08, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00	; 02330784
	.byte 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330794
	.byte 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 023307A4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00	; 023307B4
	.byte 0x02, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00	; 023307C4
	.byte 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023307D4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023307E4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023307F4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330804
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330814
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00	; 02330824
	.byte 0x02, 0x00, 0x04, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x05, 0x00, 0x08, 0x00, 0x09, 0x00	; 02330834
	.byte 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330844
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330854
	.byte 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x0A, 0x00, 0x07, 0x00, 0x01, 0x00, 0x05, 0x00, 0x01, 0x00	; 02330864
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330874
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 02330884
	.byte 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00	; 02330894
	.byte 0x02, 0x00, 0x01, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 023308A4
	.byte 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00	; 023308B4
	.byte 0x4D, 0x00, 0x2E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 023308C4
	.byte 0x4D, 0x00, 0x00, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 023308D4
	.byte 0x4D, 0x00, 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00	; 023308E4
	.byte 0x2F, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00	; 023308F4
	.byte 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00	; 02330904
	.byte 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00	; 02330914
	.byte 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00	; 02330924
	.byte 0x00, 0x00, 0x00, 0x00	; 02330934
P1_Data_02330938:
	.byte 0x1F, 0x00, 0x1C, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00	; 02330938
	.byte 0x1F, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00	; 02330944
P1_Data_02330950:
	.byte 0xFF, 0x00, 0x00, 0x00	; 02330950
	.byte 0x9B, 0x47, 0x26, 0x74, 0xBC, 0x11, 0x4F, 0x6D, 0xBD, 0x11, 0xF1, 0x32, 0xD9, 0x7F, 0xE7, 0x2C	; 02330954
	.byte 0xA5, 0x5D, 0xBD, 0x11, 0x10, 0x46, 0xA4, 0x5D, 0x90, 0x4E, 0x73, 0x61, 0x84, 0x2A, 0x91, 0x4E	; 02330964
	.byte 0x6A, 0x10, 0xFE, 0x75, 0xC8, 0x29, 0x39, 0x78, 0x0E, 0x42, 0x1B, 0x5D, 0x38, 0x78, 0xA8, 0x12	; 02330974
	.byte 0x7D, 0x3F, 0xB9, 0x67, 0xF3, 0x26, 0xEF, 0x54, 0x23, 0x7C, 0xF2, 0x26, 0xC6, 0x6B, 0x37, 0x41	; 02330984
	.byte 0xAB, 0x15, 0x0D, 0x73, 0xC7, 0x6B, 0x4F, 0x3B, 0x24, 0x5F, 0xDA, 0x3D, 0x3F, 0x25, 0x49, 0x17	; 02330994
	.byte 0xDB, 0x3D, 0xE6, 0x70, 0x6C, 0x74, 0xF7, 0x30, 0x1F, 0x53, 0x38, 0x67, 0x1E, 0x53, 0x51, 0x1A	; 023309A4
	.byte 0x71, 0x19, 0x7D, 0x5B, 0xD6, 0x4E, 0x70, 0x19, 0x27, 0x3F, 0xCB, 0x75, 0x62, 0x3D, 0x8C, 0x12	; 023309B4
	.byte 0xB8, 0x74, 0xAD, 0x2F, 0xB9, 0x74, 0xFD, 0x64, 0x9A, 0x6C, 0x3A, 0x4F, 0x6D, 0x27, 0xEF, 0x73	; 023309C4
	.byte 0xB1, 0x38, 0x3B, 0x4F, 0x1E, 0x57, 0xA3, 0x7E, 0x49, 0x62, 0x87, 0x35, 0x7C, 0x1B, 0x86, 0x35	; 023309D4
	.byte 0xFB, 0x7A, 0xE4, 0x67, 0x92, 0x5C, 0xE5, 0x67, 0xCA, 0x2B, 0x8C, 0x43, 0x6F, 0x2E, 0x7F, 0x58	; 023309E4
	.byte 0xB7, 0x14, 0x6E, 0x2E, 0xB9, 0x4C, 0xA2, 0x6F, 0xF0, 0x38, 0x9E, 0x71, 0x5A, 0x47, 0x3C, 0x1F	; 023309F4
	.byte 0xD8, 0x6A, 0x5B, 0x47, 0x99, 0x51, 0x64, 0x32, 0x41, 0x7B, 0xEF, 0x49, 0x98, 0x51, 0xD7, 0x1C	; 02330A04
P1_Data_02330A14:
	.byte 0xC0, 0x01, 0x01, 0x04, 0x00, 0x00, 0x00, 0x00, 0x30, 0x31, 0x00, 0x00, 0x41, 0x53, 0x4D, 0x4A	; 02330A14
	.byte 0x00, 0x00, 0x00, 0x00, 0x41, 0x53, 0x4D, 0x45, 0x00, 0x00, 0x00, 0x00	; 02330A24
P1_Data_02330A30:
	.byte 0x08, 0x00, 0x09, 0x00	; 02330A30
	.byte 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00	; 02330A34
P1_Data_02330A40:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P1_IrqHandlers:
	.word P1_IrqHandler_0232B108 + 1	; IRQ 0
	.word P1_IrqHandler_0232B108 + 1	; IRQ 1
	.word P1_IrqHandler_0232B108 + 1	; IRQ 2
	.word P1_IrqHandler_0232B06C + 1	; IRQ 3
	.word P1_IrqHandler_0232B060 + 1	; IRQ 4
	.word P1_IrqHandler_0232B054 + 1	; IRQ 5
	.word P1_IrqHandler_0232B048 + 1	; IRQ 6
	.word P1_IrqHandler_0232B108 + 1	; IRQ 7
	.word P1_IrqHandler_0232B09C + 1	; IRQ 8
	.word P1_IrqHandler_0232B090 + 1	; IRQ 9
	.word P1_IrqHandler_0232B084 + 1	; IRQ 10
	.word P1_IrqHandler_0232B078 + 1	; IRQ 11
	.word P1_IrqHandler_0232B108 + 1	; IRQ 12
	.word P1_IrqHandler_0232B108 + 1	; IRQ 13
	.word P1_IrqHandler_0232B108 + 1	; IRQ 14
	.word P1_IrqHandler_0232B108 + 1	; IRQ 15
	.word P1_IrqHandler_0232B108 + 1	; IRQ 16
	.word P1_IrqHandler_0232B108 + 1	; IRQ 17
	.word P1_IrqHandler_0232B108 + 1	; IRQ 18
	.word P1_IrqHandler_0232B108 + 1	; IRQ 19
	.word P1_IrqHandler_0232B108 + 1	; IRQ 20
	.word P1_IrqHandler_0232B108 + 1	; IRQ 21
P1_IrqHandlersEnd:
P1_Data_02330A98:
	.byte 0xFF, 0xFF, 0xFF, 0xFF	; 02330A98
P1_Data_02330A9C:
	.byte 0x01, 0x00, 0x00, 0x00	; 02330A9C
P1_Data_02330AA0:
	.byte 0x03, 0x00, 0x00, 0x00	; 02330AA0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330AA4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330AB4
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
	blx loc_0232B260	; 01FF8088
	lsl r0,r0,#0x10	; 01FF808C
	lsr r0,r0,#0x10	; 01FF808E
	str r0,[sp,#0x0]	; 01FF8090
	bl loc_0232B3B8	; 01FF8092
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
	bl loc_0232B250	; 01FF810C
	ldr r0,[sp,#0x0]	; 01FF8110
	blx loc_0232B2B8	; 01FF8112
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
	.byte 0x21, 0x06, 0xC0, 0xDE, 0xC0, 0x04, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330E18
.arm
.close

; 请求记录的空闲链与待处理链的头、尾指针，位于 CRT 清零的 BSS。
; Free and pending request-list head/tail pointers in CRT-cleared BSS.
.definelabel P1_RequestPendingTail, P1_BssStart + 0x266DC
.definelabel P1_RequestPendingHead, P1_BssStart + 0x266D8
.definelabel P1_RequestFreeHead, P1_BssStart + 0x266D0
.definelabel P1_RequestFreeTail, P1_BssStart + 0x266E0

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
