; official_v7_p1
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
	bl loc_0232D0BC	; 02320074
	bl loc_0232C8E8	; 02320078
	blx loc_0232D17C	; 0232007C
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
	push {r4,r5,r6,lr}	; 023200A0
	sub sp,#0x10	; 023200A2
	mov r5,#0x0	; 023200A4
	add r4,r5,#0x0	; 023200A6
	ldr r0,[pool_02320234]	; 023200A8
	bl loc_02327AB8	; 023200AA
	bl loc_0232BBDC	; 023200AE
	bl loc_0232C060	; 023200B2
	bl loc_0232D4A8	; 023200B6
	bl loc_0232EE60	; 023200BA
	ldr r0,[pool_02320238]	; 023200BE
	bl loc_0232D6D4	; 023200C0
	lsl r0,r5,#0	; 023200C4
	str r0,[sp,#0x4]	; 023200C6
	ldr r0,[sp,#0x4]	; 023200C8
	ldr r1,[pool_0232023C]	; 023200CA
	ldr r2,[pool_02320240]	; 023200CC
	blx loc_0232DE0C	; 023200CE
	bl loc_0232D5D4	; 023200D2
	mov r0,#0xc0	; 023200D6
	str r0,[sp,#0x0]	; 023200D8
	ldr r0,[sp,#0x0]	; 023200DA
	ldr r1,[pool_02320244]	; 023200DC
	ldr r2,[pool_02320248]	; 023200DE
	blx loc_0232DE0C	; 023200E0
	lsl r0,r5,#0	; 023200E4
	str r0,[sp,#0x8]	; 023200E6
	ldr r0,[sp,#0x8]	; 023200E8
	ldr r1,[pool_0232024C]	; 023200EA
	ldr r2,[pool_02320248]	; 023200EC
	blx loc_0232DE0C	; 023200EE
	mov r0,#0x1	; 023200F2
	ldr r1,[pool_02320250]	; 023200F4
	bl loc_0232B184	; 023200F6
	mov r0,#0x1	; 023200FA
	bl loc_0232B100	; 023200FC
	ldr r1,[pool_02320254]	; 02320100
	ldrh r0,[r1,#0x0]	; 02320102
	mov r0,#0x1	; 02320104
	strh r0,[r1,#0x0]	; 02320106
	blx P1_Arm9EnableIrqReturnPriorMask	; 02320108
	mov r0,#0x1	; 0232010C
	bl loc_0232D484	; 0232010E
	bl loc_0232FDA8	; 02320112
	bl loc_02327980	; 02320116
	cmp r0,#0x0	; 0232011A
	beq loc_02320120	; 0232011C
	b loc_0232022C	; 0232011E
loc_02320120:
	bl loc_02327730	; 02320120
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
	bl loc_0232F254	; 0232016A
	add r0,r6,#0x0	; 0232016E
	mov r1,#0x1	; 02320170
	bl loc_0232F180	; 02320172
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
	bl loc_02327730	; 023201A6
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
	bl loc_0232767C	; 023201CA
	b loc_023201DA	; 023201CE
loc_023201D0:
	bl loc_0232769C	; 023201D0
	b loc_023201DA	; 023201D4
loc_023201D6:
	bl loc_0232768C	; 023201D6
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
	bl loc_023276FC	; 023201FA
	b loc_02320226	; 023201FE
loc_02320200:
	bl loc_0232D450	; 02320200
	ldr r2,[pool_0232025C]	; 02320204
	ldr r1,[r2,#0x0]	; 02320206
	ldr r0,[pool_02320260]	; 02320208
	and r1,r0	; 0232020A
	str r1,[r2,#0x0]	; 0232020C
	bl loc_023276BC	; 0232020E
	b loc_02320226	; 02320212
loc_02320214:
	bl loc_0232D450	; 02320214
	ldr r2,[pool_0232025C]	; 02320218
	ldr r1,[r2,#0x0]	; 0232021A
	ldr r0,[pool_02320260]	; 0232021C
	and r1,r0	; 0232021E
	str r1,[r2,#0x0]	; 02320220
	bl loc_023276AC	; 02320222
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
	.word 0x0232FE84	; 02320234
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

; ===== function loc_0232027C =====
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
	bl loc_0232C66C	; 023203A4
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
	.word 0x02330914	; 023203EC
pool_023203F0:
loc_023203F0:
	.word 0x0233127C	; 023203F0
pool_023203F4:
loc_023203F4:
	.word P1_BssStart + 0x1300	; 023203F4
pool_023203F8:
loc_023203F8:
	.word 0x02331290	; 023203F8
pool_023203FC:
loc_023203FC:
	.word P1_BssStart + 0xA80	; 023203FC
pool_02320400:
loc_02320400:
	.word P1_BssStart + 0x100	; 02320400
pool_02320404:
loc_02320404:
	.word 0x0233082C	; 02320404
pool_02320408:
loc_02320408:
	.word 0x023A584C	; 02320408
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
	.word 0x0233127C	; 02320518
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
	bl loc_0232D388	; 02320544
	ldr r0,[pool_02320574]	; 02320548
	add r1,r5,#0x0	; 0232054A
	bl loc_0232D388	; 0232054C
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
	bl loc_0232D8FC	; 023205BC
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
	bl loc_02328348	; 02320788
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
	bl loc_0232D8FC	; 0232084A
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

; ===== function loc_02320880 =====
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
	bl loc_0232D8FC	; 02320914
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
	.word 0x02330960	; 02320944
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
	.word 0x02330960	; 02320A90
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
	.word 0x02330960	; 02320AEC
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
	.word 0x023312B8	; 02320D94
pool_02320D98:
loc_02320D98:
	.word 0x023C0ED8	; 02320D98
pool_02320D9C:
loc_02320D9C:
	.word 0x023A4DEC	; 02320D9C
pool_02320DA0:
loc_02320DA0:
	.word P1_BssStart + 0x1300	; 02320DA0
pool_02320DA4:
loc_02320DA4:
	.word 0x023D381C	; 02320DA4
pool_02320DA8:
loc_02320DA8:
	.word P1_BssStart + 0xB00	; 02320DA8
pool_02320DAC:
loc_02320DAC:
	.word 0x02330960	; 02320DAC
pool_02320DB0:
loc_02320DB0:
	.word 0x02330924	; 02320DB0
pool_02320DB4:
loc_02320DB4:
	.word 0x00001000	; 02320DB4
pool_02320DB8:
loc_02320DB8:
	.word 0x023A4D44	; 02320DB8
pool_02320DBC:
loc_02320DBC:
	.word P1_Data_0232FE98	; 02320DBC
pool_02320DC0:
loc_02320DC0:
	.word P1_BssStart	; 02320DC0
pool_02320DC4:
loc_02320DC4:
	.word 0x02330914	; 02320DC4
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
	.word P1_Data_0232FE90	; 02320DD4

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
	blx loc_0232DE0C	; 02320DEE
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
	bl loc_0232D450	; 02320E6C
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
	blx loc_0232DE0C	; 02320E84
	mov r0,#0x0	; 02320E88
	str r0,[sp,#0xc]	; 02320E8A
	ldr r0,[sp,#0xc]	; 02320E8C
	ldr r1,[pool_023211E4]	; 02320E8E
	ldr r2,[pool_023211E0]	; 02320E90
	blx loc_0232DE0C	; 02320E92
	mov r0,#0x1	; 02320E96
	bl loc_02326D48	; 02320E98
	mov r0,#0x2	; 02320E9C
	bl loc_02326D1C	; 02320E9E
	mov r0,#0x1	; 02320EA2
	mov r1,#0x0	; 02320EA4
	add r2,r1,#0x0	; 02320EA6
	bl loc_0232D3C4	; 02320EA8
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
	bl loc_0232D9E4	; 02320EDE
	ldr r1,[pool_02321204]	; 02320EE2
	ldr r0,[pool_02321208]	; 02320EE4
	sub r7,r1,r0	; 02320EE6
	mov r1,#0x0	; 02320EE8
	add r2,r7,#0x0	; 02320EEA
	bl loc_0232DCB4	; 02320EEC
	ldr r0,[pool_0232120C]	; 02320EF0
	mov r1,#0x0	; 02320EF2
	ldr r2,[pool_02321210]	; 02320EF4
	sub r2,r2,r0	; 02320EF6
	bl loc_0232DB24	; 02320EF8
	ldr r0,[pool_02321214]	; 02320EFC
	mov r1,#0x0	; 02320EFE
	ldr r2,[pool_02321218]	; 02320F00
	sub r2,r2,r0	; 02320F02
	bl loc_0232DC64	; 02320F04
	ldr r0,[pool_0232121C]	; 02320F08
	mov r1,#0x0	; 02320F0A
	mov r2,#0x2	; 02320F0C
	bl loc_0232DCB4	; 02320F0E
	mov r0,#0x4	; 02320F12
	bl loc_02326CF0	; 02320F14
	mov r0,#0x8	; 02320F18
	bl loc_02326CC4	; 02320F1A
	mov r0,#0x0	; 02320F1E
	bl loc_0232D3B0	; 02320F20
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
	bl loc_0232D9BC	; 02320FA4
	mov r4,#0x0	; 02320FA8
	ldr r6,[pool_02321250]	; 02320FAA
loc_02320FAC:
	lsl r5,r4,#0x6	; 02320FAC
	lsl r0,r4,#0x7	; 02320FAE
	add r0,r6,r0	; 02320FB0
	add r1,r5,#0x0	; 02320FB2
	mov r2,#0x40	; 02320FB4
	bl loc_0232DAFC	; 02320FB6
	lsl r0,r4,#0x1	; 02320FBA
	add r0,r0,#0x1	; 02320FBC
	lsl r0,r0,#0x6	; 02320FBE
	add r0,r6,r0	; 02320FC0
	ldr r1,[pool_02321254]	; 02320FC2
	add r1,r5,r1	; 02320FC4
	mov r2,#0x40	; 02320FC6
	bl loc_0232DAFC	; 02320FC8
	add r4,r4,#0x1	; 02320FCC
	cmp r4,#0x20	; 02320FCE
	blt loc_02320FAC	; 02320FD0
	bl loc_02325238	; 02320FD2
	ldr r0,[pool_02321258]	; 02320FD6
	ldr r1,[pool_0232125C]	; 02320FD8
	ldr r2,[pool_02321260]	; 02320FDA
	sub r2,r2,r0	; 02320FDC
	blx loc_0232DDF4	; 02320FDE
	ldr r0,[pool_02321264]	; 02320FE2
	ldr r1,[pool_02321268]	; 02320FE4
	ldr r2,[pool_0232126C]	; 02320FE6
	sub r2,r2,r0	; 02320FE8
	blx loc_0232DDF4	; 02320FEA
	ldr r0,[pool_02321270]	; 02320FEE
	ldr r1,[pool_02321274]	; 02320FF0
	ldr r2,[pool_02321278]	; 02320FF2
	sub r2,r2,r0	; 02320FF4
	blx loc_0232DDF4	; 02320FF6
	ldr r0,[pool_0232127C]	; 02320FFA
	ldr r1,[pool_02321280]	; 02320FFC
	ldr r2,[pool_02321284]	; 02320FFE
	sub r2,r2,r0	; 02321000
	blx loc_0232DDF4	; 02321002
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
	bl loc_02329150	; 02321042
	add r5,r0,#0x0	; 02321046
	ldr r0,[pool_0232128C]	; 02321048
	bl loc_02329150	; 0232104A
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
	bl loc_0232D164	; 023210B6
	ldr r0,[pool_023212A0]	; 023210BA
	bl loc_02327194	; 023210BC
	ldr r0,[pool_023212A4]	; 023210C0
	ldr r1,[pool_023212A8]	; 023210C2
	ldr r2,[pool_023212AC]	; 023210C4
	bl loc_0232DB9C	; 023210C6
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
	bl loc_0232C5B4	; 02321122
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
	bl loc_0232DC3C	; 02321198
	ldr r0,[pool_02321208]	; 0232119C
	mov r1,#0x0	; 0232119E
	add r2,r7,#0x0	; 023211A0
	bl loc_0232DC8C	; 023211A2
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
	.word 0x02330914	; 023211B4
pool_023211B8:
loc_023211B8:
	.word 0x0232FF00	; 023211B8
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
	.word 0x023AFFA0	; 023211FC
pool_02321200:
loc_02321200:
	.word 0x023AE3A0	; 02321200
pool_02321204:
loc_02321204:
	.word 0x023BBD20	; 02321204
pool_02321208:
loc_02321208:
	.word 0x023BBB20	; 02321208
pool_0232120C:
loc_0232120C:
	.word 0x023B7B20	; 0232120C
pool_02321210:
loc_02321210:
	.word 0x023B8320	; 02321210
pool_02321214:
loc_02321214:
	.word 0x023BCB20	; 02321214
pool_02321218:
loc_02321218:
	.word 0x023BCD20	; 02321218
pool_0232121C:
loc_0232121C:
	.word 0x02330030	; 0232121C
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
	.word 0x023BA320	; 02321250
pool_02321254:
loc_02321254:
	.word 0x00000800	; 02321254
pool_02321258:
loc_02321258:
	.word 0x023B6B20	; 02321258
pool_0232125C:
loc_0232125C:
	.word 0x06200000	; 0232125C
pool_02321260:
loc_02321260:
	.word P5_Data_023B7320	; 02321260
pool_02321264:
loc_02321264:
	.word 0x023B9B20	; 02321264
pool_02321268:
loc_02321268:
	.word 0x06203000	; 02321268
pool_0232126C:
loc_0232126C:
	.word 0x023BA320	; 0232126C
pool_02321270:
loc_02321270:
	.word 0x023B9320	; 02321270
pool_02321274:
loc_02321274:
	.word 0x06203800	; 02321274
pool_02321278:
loc_02321278:
	.word 0x023B9B20	; 02321278
pool_0232127C:
loc_0232127C:
	.word P5_Data_023B7320	; 0232127C
pool_02321280:
loc_02321280:
	.word 0x06204800	; 02321280
pool_02321284:
loc_02321284:
	.word 0x023B7B20	; 02321284
pool_02321288:
loc_02321288:
	.word 0x023C0ED8	; 02321288
pool_0232128C:
loc_0232128C:
	.word 0x023D381C	; 0232128C
pool_02321290:
loc_02321290:
	.word 0x023D3970	; 02321290
pool_02321294:
loc_02321294:
	.word 0x023A584C	; 02321294
pool_02321298:
loc_02321298:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02321298
pool_0232129C:
loc_0232129C:
	.word 0x00000102	; 0232129C
pool_023212A0:
loc_023212A0:
	.word 0x023312F8	; 023212A0
pool_023212A4:
loc_023212A4:
	.word 0x02331318	; 023212A4
pool_023212A8:
loc_023212A8:
	.word 0x0001FE00	; 023212A8
pool_023212AC:
loc_023212AC:
	.word 0x00000200	; 023212AC
pool_023212B0:
loc_023212B0:
	.word 0x0233082C	; 023212B0
pool_023212B4:
loc_023212B4:
	.word P1_BssStart + 0x40	; 023212B4
pool_023212B8:
loc_023212B8:
	.word 0x023312B8	; 023212B8
pool_023212BC:
loc_023212BC:
	.word 0x023A5924	; 023212BC
pool_023212C0:
loc_023212C0:
	.word 0x023BC320	; 023212C0
pool_023212C4:
loc_023212C4:
	.word 0x023BC520	; 023212C4
pool_023212C8:
loc_023212C8:
	.word 0x02330034	; 023212C8
loc_023212CC:
	mov r1,#0x0	; 023212CC
	mov r2,#0x2	; 023212CE
	bl loc_0232DC8C	; 023212D0
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
	bl loc_0232DC3C	; 02321360
	ldr r0,[pool_02321420]	; 02321364
	mov r1,#0x0	; 02321366
	add r2,r4,#0x0	; 02321368
	bl loc_0232DC8C	; 0232136A
	ldr r0,[pool_02321424]	; 0232136E
	mov r1,#0x0	; 02321370
	mov r2,#0x2	; 02321372
	bl loc_0232DC8C	; 02321374
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
	bl loc_0232D8FC	; 02321392
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
	bl loc_0232B184	; 023213B6
	mov r0,#0x1	; 023213BA
	bl loc_0232B100	; 023213BC
	mov r0,#0x1	; 023213C0
	bl loc_0232D484	; 023213C2
	bl loc_0232D410	; 023213C6
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
	.word 0x023A6B7C	; 023213E4
pool_023213E8:
loc_023213E8:
	.word 0x023A574C	; 023213E8
pool_023213EC:
loc_023213EC:
	.word P1_BssStart + 0xB00	; 023213EC
pool_023213F0:
loc_023213F0:
	.word 0x023A717C	; 023213F0
pool_023213F4:
loc_023213F4:
	.word 0x023A576C	; 023213F4
pool_023213F8:
loc_023213F8:
	.word 0x023A627C	; 023213F8
pool_023213FC:
loc_023213FC:
	.word 0x023A571C	; 023213FC
pool_02321400:
loc_02321400:
	.word 0x023A6548	; 02321400
pool_02321404:
loc_02321404:
	.word 0x023A572C	; 02321404
pool_02321408:
loc_02321408:
	.word 0x023A685C	; 02321408
pool_0232140C:
loc_0232140C:
	.word 0x023A573C	; 0232140C
pool_02321410:
loc_02321410:
	.word 0x023A6E64	; 02321410
pool_02321414:
loc_02321414:
	.word 0x023A575C	; 02321414
pool_02321418:
loc_02321418:
	.word 0x00000200	; 02321418
pool_0232141C:
loc_0232141C:
	.word 0x023BCB20	; 0232141C
pool_02321420:
loc_02321420:
	.word 0x023BC920	; 02321420
pool_02321424:
loc_02321424:
	.word 0x02330038	; 02321424
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
	.word 0x02330960	; 0232143C
pool_02321440:
loc_02321440:
	.word 0x0233127C	; 02321440
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
	.word 0x02331318	; 023214F8
pool_023214FC:
loc_023214FC:
	.word 0x00000220	; 023214FC
pool_02321500:
loc_02321500:
	.word 0x0232FEB0	; 02321500
pool_02321504:
loc_02321504:
	.word 0x0232FEBC	; 02321504
pool_02321508:
loc_02321508:
	.word 0x0232FEA4	; 02321508
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
	bl loc_0232DC3C	; 02321584
	ldr r0,[pool_02321648]	; 02321588
	ldr r1,[pool_0232164C]	; 0232158A
	mov r2,#0x20	; 0232158C
	bl loc_0232DC3C	; 0232158E
	ldr r0,[pool_02321650]	; 02321592
	mov r1,#0x0	; 02321594
	ldr r2,[pool_02321654]	; 02321596
	sub r2,r2,r0	; 02321598
	bl loc_0232DC8C	; 0232159A
	ldr r0,[pool_02321658]	; 0232159E
	mov r1,#0x0	; 023215A0
	mov r2,#0x2	; 023215A2
	bl loc_0232DC8C	; 023215A4
	ldr r1,[pool_0232165C]	; 023215A8
	lsl r0,r4,#0x5	; 023215AA
	add r4,r1,r0	; 023215AC
	add r0,r4,#0x0	; 023215AE
	ldr r1,[pool_02321660]	; 023215B0
	mov r2,#0x20	; 023215B2
	bl loc_0232DC8C	; 023215B4
	add r0,r4,#0x0	; 023215B8
	ldr r1,[pool_02321660]	; 023215BA
	mov r2,#0x20	; 023215BC
	bl loc_0232DC3C	; 023215BE
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
	bl loc_0232DC8C	; 0232160A
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
	.word 0x023BC320	; 02321640
pool_02321644:
loc_02321644:
	.word 0x023BC520	; 02321644
pool_02321648:
loc_02321648:
	.word 0x02331518	; 02321648
pool_0232164C:
loc_0232164C:
	.word 0x000001C0	; 0232164C
pool_02321650:
loc_02321650:
	.word 0x023BBB20	; 02321650
pool_02321654:
loc_02321654:
	.word 0x023BBD20	; 02321654
pool_02321658:
loc_02321658:
	.word 0x0233003C	; 02321658
pool_0232165C:
loc_0232165C:
	.word 0x023BC720	; 0232165C
pool_02321660:
loc_02321660:
	.word 0x000001E0	; 02321660
pool_02321664:
loc_02321664:
	.word 0x02331B44	; 02321664

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
	.word 0x0232FF50	; 02321828
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
	.word P1_Data_0232FEC8	; 023218A4
pool_023218A8:
loc_023218A8:
	.word 0x0232FF50	; 023218A8

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
	bl loc_0232D8FC	; 023218C0
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
	blx loc_0232DDC4	; 02321972
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
	.word P5_Data_023AE1F8	; 023219DC

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
	bl loc_0232D2C0	; 02321A1C
	str r0,[sp,#0x18]	; 02321A20
	ldr r1,[r6,#0x64]	; 02321A22
	ldr r0,[pool_02321AA8]	; 02321A24
	add r0,r1,r0	; 02321A26
	ldr r1,[pool_02321AAC]	; 02321A28
	bl loc_0232D2C0	; 02321A2A
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
	bl loc_0232D358	; 02321A82
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
	.word P1_Data_0232FED8	; 02321AB0
pool_02321AB4:
loc_02321AB4:
	.word 0x023D3970	; 02321AB4
pool_02321AB8:
loc_02321AB8:
	.word 0x023A54FC	; 02321AB8

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
	bl loc_0232915C	; 02321AD4
	add r6,r0,#0x0	; 02321AD8
	ldr r0,[pool_02321B9C]	; 02321ADA
	ldr r1,[r5,#0x4]	; 02321ADC
	bl loc_02329144	; 02321ADE
	add r4,r0,#0x0	; 02321AE2
	ldr r0,[pool_02321B9C]	; 02321AE4
	ldr r1,[r5,#0x4]	; 02321AE6
	bl loc_02329174	; 02321AE8
	str r0,[sp,#0xc]	; 02321AEC
	mov r1,sp	; 02321AEE
	sub r1,r1,#0x4	; 02321AF0
	ldr r0,[sp,#0x14]	; 02321AF2
	ldrh r0,[r7,r0]	; 02321AF4
	strh r0,[r1,#0x0]	; 02321AF6
	ldmia r1!,{r0}	; 02321AF8
	ldrb r1,[r4,#0x0]	; 02321AFA
	bl loc_02329074	; 02321AFC
	ldr r1,[sp,#0x0]	; 02321B00
	add r0,r1,r0	; 02321B02
	str r0,[sp,#0x0]	; 02321B04
	mov r1,sp	; 02321B06
	sub r1,r1,#0x4	; 02321B08
	ldrh r0,[r5,#0x2]	; 02321B0A
	strh r0,[r1,#0x0]	; 02321B0C
	ldmia r1!,{r0}	; 02321B0E
	ldrb r1,[r4,#0x1]	; 02321B10
	bl loc_0232903C	; 02321B12
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
	.word 0x023A54FC	; 02321B98
pool_02321B9C:
loc_02321B9C:
	.word 0x023D3970	; 02321B9C
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
	blx loc_0232D36C	; 02321C82
	add r6,r0,#0x0	; 02321C86
	ldr r0,[sp,#0x0]	; 02321C88
	ldr r1,[pool_02321CB8]	; 02321C8A
	add r1,r5,r1	; 02321C8C
	blx loc_0232D36C	; 02321C8E
	add r1,r7,#0x0	; 02321C92
	blx loc_0232D36C	; 02321C94
	ldr r1,[sp,#0x1c]	; 02321C98
	sub r1,r1,r4	; 02321C9A
	blx loc_0232D36C	; 02321C9C
	add r4,r0,#0x0	; 02321CA0
	add r0,r5,#0x0	; 02321CA2
	ldr r1,[sp,#0x1c]	; 02321CA4
	blx loc_0232D36C	; 02321CA6
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
	.word 0x023A4848	; 02321D0C

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
	bl loc_0232D8FC	; 02321D8E
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
	bl loc_0232D8FC	; 02321DE4
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
	.word 0x02331B68	; 02321E3C
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
	.word P1_Data_02330068	; 02321E88

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
	bl loc_0232DBC4	; 02321EDE
	add r0,r4,#0x0	; 02321EE2
	ldr r1,[pool_02321F18]	; 02321EE4
	mov r2,#0x20	; 02321EE6
	bl loc_0232DC64	; 02321EE8
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
	.word 0x02331C5C	; 02321F08
pool_02321F0C:
loc_02321F0C:
	.word 0x02331CE0	; 02321F0C
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
	bl loc_0232D8E0	; 02321F40
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
	blx loc_0232DDE0	; 02321FDC
	ldr r0,[pool_023220BC]	; 02321FE0
	mov r1,#0x0	; 02321FE2
	ldr r2,[pool_023220C0]	; 02321FE4
	sub r2,r2,r0	; 02321FE6
	bl loc_0232D994	; 02321FE8
	ldr r0,[pool_023220C4]	; 02321FEC
	mov r1,#0x0	; 02321FEE
	ldr r2,[pool_023220C8]	; 02321FF0
	sub r2,r2,r0	; 02321FF2
	bl loc_0232DCB4	; 02321FF4
	mov r1,#0x0	; 02321FF8
	ldr r0,[pool_023220CC]	; 02321FFA
	strh r1,[r0,#0x0]	; 02321FFC
	mov r1,#0x2	; 02321FFE
	blx P1_CleanDataCacheRange	; 02322000
	ldr r0,[pool_023220CC]	; 02322004
	mov r1,#0x0	; 02322006
	mov r2,#0x2	; 02322008
	bl loc_0232DCB4	; 0232200A
	ldr r1,[pool_023220D0]	; 0232200E
	lsl r0,r7,#0x5	; 02322010
	add r5,r1,r0	; 02322012
	add r0,r5,#0x0	; 02322014
	ldr r1,[pool_023220D4]	; 02322016
	mov r2,#0x20	; 02322018
	bl loc_0232DCB4	; 0232201A
	ldr r0,[pool_023220D8]	; 0232201E
	mov r1,#0x0	; 02322020
	ldr r2,[pool_023220DC]	; 02322022
	sub r2,r2,r0	; 02322024
	bl loc_0232DAD4	; 02322026
	ldr r0,[pool_023220E0]	; 0232202A
	mov r1,#0x0	; 0232202C
	ldr r2,[pool_023220E4]	; 0232202E
	sub r2,r2,r0	; 02322030
	bl loc_0232DA84	; 02322032
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
	bl loc_0232DC64	; 02322064
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
	.word 0x023AE3A0	; 023220BC
pool_023220C0:
loc_023220C0:
	.word 0x023AFFA0	; 023220C0
pool_023220C4:
loc_023220C4:
	.word 0x023BBB20	; 023220C4
pool_023220C8:
loc_023220C8:
	.word 0x023BBD20	; 023220C8
pool_023220CC:
loc_023220CC:
	.word P1_BssStart + 0x136C	; 023220CC
pool_023220D0:
loc_023220D0:
	.word 0x023BC720	; 023220D0
pool_023220D4:
loc_023220D4:
	.word 0x000001E0	; 023220D4
pool_023220D8:
loc_023220D8:
	.word 0x023B8320	; 023220D8
pool_023220DC:
loc_023220DC:
	.word 0x023B8B20	; 023220DC
pool_023220E0:
loc_023220E0:
	.word 0x023B6B20	; 023220E0
pool_023220E4:
loc_023220E4:
	.word P5_Data_023B7320	; 023220E4
pool_023220E8:
loc_023220E8:
	.word 0x023C0ED8	; 023220E8
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
	.word P1_Data_02330068	; 0232214C
pool_02322150:
loc_02322150:
	.word P1_BssStart + 0x1444	; 02322150
pool_02322154:
loc_02322154:
	.word 0x02331C30	; 02322154
pool_02322158:
loc_02322158:
	.word 0x023A5ED4	; 02322158
pool_0232215C:
loc_0232215C:
	.word P1_Data_0233006A	; 0232215C
pool_02322160:
loc_02322160:
	.word 0x02331CB4	; 02322160
pool_02322164:
loc_02322164:
	.word P1_Data_0233006C	; 02322164

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
	.word P1_Data_02330068	; 023221B8
pool_023221BC:
loc_023221BC:
	.word 0x02331C30	; 023221BC
pool_023221C0:
loc_023221C0:
	.word 0x023A5ED4	; 023221C0
pool_023221C4:
loc_023221C4:
	.word 0x02331CB4	; 023221C4
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
	bl loc_02329200	; 023222D4
	add r6,r0,#0x0	; 023222D8
	bl P3_Entry_02367588	; 023222DA
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
	.word P1_Data_02330068	; 023223C0
pool_023223C4:
loc_023223C4:
	.word 0x0233006E	; 023223C4
pool_023223C8:
loc_023223C8:
	.word 0x02331C30	; 023223C8
pool_023223CC:
loc_023223CC:
	.word 0x02331CB4	; 023223CC
pool_023223D0:
loc_023223D0:
	.word 0x023A4928	; 023223D0
pool_023223D4:
loc_023223D4:
	.word 0x023C0ED8	; 023223D4
pool_023223D8:
loc_023223D8:
	.word 0x023A4FCC	; 023223D8
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
	.word 0x02331C30	; 02322434
pool_02322438:
loc_02322438:
	.word 0x02331CB4	; 02322438
pool_0232243C:
loc_0232243C:
	.word 0x023A5ED4	; 0232243C

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
	bl loc_0232D8E0	; 02322524
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
	.word 0x023C0ED8	; 02322790
pool_02322794:
loc_02322794:
	.word 0x023A55E4	; 02322794
pool_02322798:
loc_02322798:
	.word P1_Data_02330040	; 02322798

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
	.word 0x023A6218	; 023228B4

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
	.word 0x02331B68	; 02322920

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
	bl loc_0232D8E0	; 0232296E
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
	.word 0x02331B68	; 023229B8

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
	.word 0x02331B70	; 02322A08
pool_02322A0C:
loc_02322A0C:
	.word 0x023A6218	; 02322A0C
pool_02322A10:
loc_02322A10:
	.word 0x02331B9C	; 02322A10
P1_Entry_02322A14:
	ldr r3,[pool_02322A18]	; 02322A14
	bx r3	; 02322A16
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
	bl loc_0232DC64	; 02322A28
	bl loc_02321DFC	; 02322A2C
	add sp,#0x4	; 02322A30
	pop {r3}	; 02322A32
	bx r3	; 02322A34
	.byte 0xC0, 0x46	; 02322A38
pool_02322A38:
loc_02322A38:
	.word 0x023BC520	; 02322A38
pool_02322A3C:
loc_02322A3C:
	.word 0x023BC720	; 02322A3C

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
	bl loc_0232D358	; 02322AC6
	add r4,r0,#0x0	; 02322ACA
	ldr r0,[pool_02322C4C]	; 02322ACC
	bl loc_0232D358	; 02322ACE
	add r1,r0,#0x0	; 02322AD2
	add r0,sp,#0x20	; 02322AD4
	add r2,r4,#0x0	; 02322AD6
	bl loc_0232D1AC	; 02322AD8
	ldr r0,[sp,#0x48]	; 02322ADC
	lsl r3,r0,#0x1	; 02322ADE
	add r0,sp,#0x10	; 02322AE0
	ldr r1,[pool_02322C50]	; 02322AE2
	ldrsh r1,[r1,r3]	; 02322AE4
	ldr r2,[pool_02322C54]	; 02322AE6
	ldrsh r2,[r2,r3]	; 02322AE8
	bl loc_0232D1B8	; 02322AEA
	add r0,sp,#0x20	; 02322AEE
	add r1,sp,#0x10	; 02322AF0
	add r2,sp,#0x30	; 02322AF2
	bl loc_0232D1C4	; 02322AF4
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
	bl loc_0232D358	; 02322B1C
	add r4,r0,#0x0	; 02322B20
	ldr r0,[pool_02322C4C]	; 02322B22
	bl loc_0232D358	; 02322B24
	add r1,r0,#0x0	; 02322B28
	add r0,sp,#0x20	; 02322B2A
	add r2,r4,#0x0	; 02322B2C
	bl loc_0232D1AC	; 02322B2E
	ldr r0,[sp,#0x44]	; 02322B32
	lsl r3,r0,#0x1	; 02322B34
	add r0,sp,#0x10	; 02322B36
	ldr r1,[pool_02322C50]	; 02322B38
	ldrsh r1,[r1,r3]	; 02322B3A
	ldr r2,[pool_02322C54]	; 02322B3C
	ldrsh r2,[r2,r3]	; 02322B3E
	bl loc_0232D1B8	; 02322B40
	add r0,sp,#0x20	; 02322B44
	add r1,sp,#0x10	; 02322B46
	add r2,sp,#0x30	; 02322B48
	bl loc_0232D1C4	; 02322B4A
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
	bl loc_0232D358	; 02322B72
	add r4,r0,#0x0	; 02322B76
	ldr r0,[pool_02322C4C]	; 02322B78
	bl loc_0232D358	; 02322B7A
	add r1,r0,#0x0	; 02322B7E
	add r0,sp,#0x20	; 02322B80
	add r2,r4,#0x0	; 02322B82
	bl loc_0232D1AC	; 02322B84
	lsl r3,r5,#0x1	; 02322B88
	add r0,sp,#0x10	; 02322B8A
	ldr r1,[pool_02322C50]	; 02322B8C
	ldrsh r1,[r1,r3]	; 02322B8E
	ldr r2,[pool_02322C54]	; 02322B90
	ldrsh r2,[r2,r3]	; 02322B92
	bl loc_0232D1B8	; 02322B94
	add r0,sp,#0x20	; 02322B98
	add r1,sp,#0x10	; 02322B9A
	add r2,sp,#0x30	; 02322B9C
	bl loc_0232D1C4	; 02322B9E
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
	bl loc_0232D358	; 02322BE2
	add r4,r0,#0x0	; 02322BE6
	ldr r0,[pool_02322C4C]	; 02322BE8
	bl loc_0232D358	; 02322BEA
	add r1,r0,#0x0	; 02322BEE
	add r0,sp,#0x20	; 02322BF0
	add r2,r4,#0x0	; 02322BF2
	bl loc_0232D1AC	; 02322BF4
	lsl r3,r5,#0x1	; 02322BF8
	add r0,sp,#0x10	; 02322BFA
	ldr r1,[pool_02322C50]	; 02322BFC
	ldrsh r1,[r1,r3]	; 02322BFE
	ldr r2,[pool_02322C54]	; 02322C00
	ldrsh r2,[r2,r3]	; 02322C02
	bl loc_0232D1B8	; 02322C04
	add r0,sp,#0x20	; 02322C08
	add r1,sp,#0x10	; 02322C0A
	add r2,sp,#0x30	; 02322C0C
	bl loc_0232D1C4	; 02322C0E
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
	.word 0x023C0ED8	; 02322C40
pool_02322C44:
loc_02322C44:
	.word 0x023A556C	; 02322C44
pool_02322C48:
loc_02322C48:
	.word 0x00009000	; 02322C48
pool_02322C4C:
loc_02322C4C:
	.word 0x00001000	; 02322C4C
pool_02322C50:
loc_02322C50:
	.word P1_Data_02330320	; 02322C50
pool_02322C54:
loc_02322C54:
	.word P1_Data_02330398	; 02322C54
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
	bl loc_02328FBC	; 02322C8E
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
	bl loc_02328FBC	; 02322CCC
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
	.word 0x02331D38	; 02322D10
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
	.word 0x023C0ED8	; 02322D6C
pool_02322D70:
loc_02322D70:
	.word 0x023A556C	; 02322D70

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
	.word 0x023B8320	; 02322DC0

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
	blx loc_0232DE0C	; 02322E56
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
	bl loc_02328FBC	; 02322E72
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
	bl loc_0232912C	; 02322EEC
	add r1,r0,#0x0	; 02322EF0
	add r0,sp,#0x38	; 02322EF2
	add r2,sp,#0x90	; 02322EF4
	bl loc_023290AC	; 02322EF6
	mov r5,#0x0	; 02322EFA
	b loc_02322F46	; 02322EFC
loc_02322EFE:
	ldr r0,[pool_02323078]	; 02322EFE
	add r1,r5,#0x1	; 02322F00
	bl loc_0232912C	; 02322F02
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
	bl loc_02328C5C	; 02322F40
	add r5,r5,#0x1	; 02322F44
loc_02322F46:
	cmp r5,#0x7	; 02322F46
	bcc loc_02322EFE	; 02322F48
	ldr r0,[pool_02323078]	; 02322F4A
	mov r1,#0x1	; 02322F4C
	bl loc_0232912C	; 02322F4E
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
	bl loc_02328C5C	; 02323020
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
	.word 0x02330410	; 02323058
pool_0232305C:
loc_0232305C:
	.word 0x0233042C	; 0232305C
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
	.word 0x02330448	; 0232306C
pool_02323070:
loc_02323070:
	.word 0x02330458	; 02323070
pool_02323074:
loc_02323074:
	.word 0x02330468	; 02323074
pool_02323078:
loc_02323078:
	.word 0x023A617C	; 02323078
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
	.word 0x02331D44	; 02323090
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
	.word 0x02331D44	; 023230A0
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
	.word 0x02331D44	; 023230B0
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
	bl loc_0232F128	; 023231BA
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
	.word 0x02331D5C	; 02323284
pool_02323288:
loc_02323288:
	.word 0x02331D88	; 02323288
pool_0232328C:
loc_0232328C:
	.word 0x02331DB4	; 0232328C
pool_02323290:
loc_02323290:
	.word 0x023C0ED8	; 02323290
pool_02323294:
loc_02323294:
	.word 0x023A556C	; 02323294
pool_02323298:
loc_02323298:
	.word P1_Data_02330478	; 02323298
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
	.word 0x02331DB4	; 023232E4
pool_023232E8:
loc_023232E8:
	.word 0x023A617C	; 023232E8
pool_023232EC:
loc_023232EC:
	.word 0x02331D5C	; 023232EC
pool_023232F0:
loc_023232F0:
	.word 0x02331D88	; 023232F0
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
	.word 0x02331DB4	; 02323318

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
	bl loc_0232912C	; 023233B0
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
	bl loc_0232DC64	; 023233D0
loc_023233D4:
	add sp,#0x1c	; 023233D4
	pop {r4,r5}	; 023233D6
	pop {r3}	; 023233D8
	bx r3	; 023233DA
pool_023233DC:
loc_023233DC:
	.word 0x02331DF4	; 023233DC
pool_023233E0:
loc_023233E0:
	.word 0x023A5ED4	; 023233E0
pool_023233E4:
loc_023233E4:
	.word 0x023BC720	; 023233E4
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
	.word 0x0233047C	; 023234F0
pool_023234F4:
loc_023234F4:
	.word 0x02331DF4	; 023234F4
pool_023234F8:
loc_023234F8:
	.word P1_BssStart + 0x1888	; 023234F8
pool_023234FC:
loc_023234FC:
	.word 0x023C0ED8	; 023234FC
pool_02323500:
loc_02323500:
	.word 0x023A4FCC	; 02323500

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
	blx loc_0232DE90	; 023235AA
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
	.word 0x02331DF4	; 023235E8
pool_023235EC:
loc_023235EC:
	.word 0x023A5ED4	; 023235EC

; ===== function loc_023235F0 =====
loc_023235F0:
	push {r4,r5,r6,lr}	; 023235F0
	bl loc_0232E6B4	; 023235F2
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
	bl loc_0232A1D4	; 02323614
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
	.byte 0x02, 0x21, 0x02, 0x48, 0x01, 0x60, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0x94, 0x20, 0x33, 0x02	; 02323688
	.byte 0xB9, 0x93, 0x32, 0x02	; 0232368C

; ===== function loc_0232368C =====
loc_0232368C:
	push {lr}	; 0232368C
	sub sp,#0x4	; 0232368E
	bl loc_023293B8	; 02323690
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
	.word 0x02332120	; 023236B0
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
	.word loc_0232A1FC + 1	; 023236C4

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
	.word loc_0232AE00 + 1	; 023236D4
loc_023236D8:
	ldr r3,[pool_023236DC]	; 023236D8
	bx r3	; 023236DA
pool_023236DC:
loc_023236DC:
	.word loc_0232A1F4 + 1	; 023236DC

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
	.word 0x0233208C	; 023236EC
pool_023236F0:
loc_023236F0:
	.word loc_0232AE00 + 1	; 023236F0

; ===== function loc_023236F4 =====
loc_023236F4:
	ldr r3,[pool_023236F8]	; 023236F4
	bx r3	; 023236F6
pool_023236F8:
loc_023236F8:
	.word loc_02329D08 + 1	; 023236F8

; ===== function loc_023236FC =====
loc_023236FC:
	push {lr}	; 023236FC
	sub sp,#0x4	; 023236FE
	bl loc_02329D2C	; 02323700
	ldr r0,[pool_02323728]	; 02323704
	ldr r1,[pool_0232372C]	; 02323706
	mov r2,#0x1	; 02323708
	bl P1_StartDualBufferProcessor	; 0232370A
	ldr r0,[pool_02323730]	; 0232370E
	ldr r1,[pool_02323734]	; 02323710
	bl loc_0232AA4C	; 02323712
	mov r0,#0x0	; 02323716
	bl loc_0232AE68	; 02323718
	ldr r0,[pool_02323738]	; 0232371C
	bl loc_0232A1F4	; 0232371E
	add sp,#0x4	; 02323722
	pop {r3}	; 02323724
	bx r3	; 02323726
pool_02323728:
loc_02323728:
	.word 0x02332120	; 02323728
pool_0232372C:
loc_0232372C:
	.word 0x00001000	; 0232372C
pool_02323730:
loc_02323730:
	.word 0x02332098	; 02323730
pool_02323734:
loc_02323734:
	.word 0x023AB7D8	; 02323734
pool_02323738:
loc_02323738:
	.word 0x0233208C	; 02323738

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
	bl loc_02329144	; 02323CBA
	add r6,r0,#0x0	; 02323CBE
	mov r1,sp	; 02323CC0
	sub r1,r1,#0x4	; 02323CC2
	ldrh r0,[r4,r7]	; 02323CC4
	strh r0,[r1,#0x0]	; 02323CC6
	ldmia r1!,{r0}	; 02323CC8
	ldrb r1,[r6,#0x0]	; 02323CCA
	bl loc_02329074	; 02323CCC
	ldr r1,[sp,#0x30]	; 02323CD0
	add r0,r1,r0	; 02323CD2
	str r0,[sp,#0x30]	; 02323CD4
	mov r1,sp	; 02323CD6
	sub r1,r1,#0x4	; 02323CD8
	ldrh r0,[r5,#0x2]	; 02323CDA
	strh r0,[r1,#0x0]	; 02323CDC
	ldmia r1!,{r0}	; 02323CDE
	ldrb r1,[r6,#0x1]	; 02323CE0
	bl loc_0232903C	; 02323CE2
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
	bl loc_02329174	; 02323D2A
	str r0,[sp,#0x8]	; 02323D2E
	add r0,r5,#0x0	; 02323D30
	ldr r1,[sp,#0x34]	; 02323D32
	bl loc_0232915C	; 02323D34
	add r7,r0,#0x0	; 02323D38
	add r0,r5,#0x0	; 02323D3A
	ldr r1,[sp,#0x34]	; 02323D3C
	bl loc_02329144	; 02323D3E
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
	.word 0x02333750	; 02323E3C

; ===== function loc_02323E40 =====
loc_02323E40:
	ldr r0,[pool_02323E44]	; 02323E40
	bx lr	; 02323E42
pool_02323E44:
loc_02323E44:
	.word 0x02333120	; 02323E44

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
	bl loc_0232DC14	; 02323E5A
	ldr r0,[pool_02323E7C]	; 02323E5E
	mov r1,#0x0	; 02323E60
	ldr r2,[pool_02323E78]	; 02323E62
	bl loc_0232DBEC	; 02323E64
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
	.word 0x02333120	; 02323E74
pool_02323E78:
loc_02323E78:
	.word 0x00000400	; 02323E78
pool_02323E7C:
loc_02323E7C:
	.word 0x02333750	; 02323E7C

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
	blx loc_0232DE0C	; 02323E9A
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
	blx loc_0232DE0C	; 02323EB4
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
	bl loc_0232C756	; 02323F24
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
	.word 0x02333120	; 02323F34
pool_02323F38:
loc_02323F38:
	.word P1_BssStart + 0x3540	; 02323F38
pool_02323F3C:
loc_02323F3C:
	.word 0x02333750	; 02323F3C
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
	bl loc_02329154	; 02323FA6
	add r6,r0,#0x0	; 02323FAA
	add r0,r4,#0x0	; 02323FAC
	bl loc_02329150	; 02323FAE
	add r2,r0,#0x0	; 02323FB2
	add r0,r6,#0x0	; 02323FB4
	ldr r1,[pool_02324004]	; 02323FB6
	ldr r1,[r5,r1]	; 02323FB8
	bl loc_0232DBC4	; 02323FBA
	b loc_02323FDA	; 02323FBE
loc_02323FC0:
	add r0,r4,#0x0	; 02323FC0
	bl loc_02329154	; 02323FC2
	add r6,r0,#0x0	; 02323FC6
	add r0,r4,#0x0	; 02323FC8
	bl loc_02329150	; 02323FCA
	add r2,r0,#0x0	; 02323FCE
	add r0,r6,#0x0	; 02323FD0
	ldr r1,[pool_02324004]	; 02323FD2
	ldr r1,[r5,r1]	; 02323FD4
	bl loc_0232DB9C	; 02323FD6
loc_02323FDA:
	add r0,r4,#0x0	; 02323FDA
	bl loc_02329150	; 02323FDC
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
	.word 0x02333120	; 0232400C

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
	.byte 0x81, 0x80, 0x01, 0x89, 0x91, 0x43, 0x01, 0x81, 0x70, 0x47, 0xC0, 0x46, 0x84, 0x3D, 0x33, 0x02	; 0232406C
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
	.byte 0x02, 0x49, 0x09, 0x89, 0x01, 0x40, 0x08, 0x1C, 0x70, 0x47, 0xC0, 0x46, 0x84, 0x3D, 0x33, 0x02	; 023240F8

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
	bl loc_0232ED58	; 02324166
	add r0,r4,#0x0	; 0232416A
	bl loc_0232ED24	; 0232416C
	cmp r0,#0x0	; 02324170
	bne loc_02324166	; 02324172
	add r0,sp,#0x8	; 02324174
	add r1,sp,#0x0	; 02324176
	bl loc_0232EAB0	; 02324178
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
	blx loc_0232DE0C	; 0232423E
	add sp,#0x4	; 02324242
	pop {r3}	; 02324244
	bx r3	; 02324246
pool_02324248:
loc_02324248:
	.word 0x02333D84	; 02324248

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
	bl loc_02329184	; 0232434E
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
	bl loc_02329184	; 02324380
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
	bl loc_02329184	; 023243B0
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
	.word 0x02333DAC	; 0232455C

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
	bl loc_0232DB4C	; 0232458E
	b loc_023245B6	; 02324592
loc_02324594:
	ldr r0,[pool_023245BC]	; 02324594
	mov r1,#0x0	; 02324596
	ldr r2,[pool_023245C0]	; 02324598
	bl loc_0232DAFC	; 0232459A
	b loc_023245B6	; 0232459E
loc_023245A0:
	ldr r0,[pool_023245BC]	; 023245A0
	mov r1,#0x0	; 023245A2
	ldr r2,[pool_023245C0]	; 023245A4
	bl loc_0232DAAC	; 023245A6
	b loc_023245B6	; 023245AA
loc_023245AC:
	ldr r0,[pool_023245BC]	; 023245AC
	mov r1,#0x0	; 023245AE
	ldr r2,[pool_023245C0]	; 023245B0
	bl loc_0232DA5C	; 023245B2
loc_023245B6:
	add sp,#0x4	; 023245B6
	pop {r3}	; 023245B8
	bx r3	; 023245BA
pool_023245BC:
loc_023245BC:
	.word 0x02333DAC	; 023245BC
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
	blx loc_0232DE0C	; 023245D2
	ldr r0,[pool_023245E4]	; 023245D6
	ldr r1,[pool_023245E8]	; 023245D8
	blx P1_CleanDataCacheRange	; 023245DA
	add sp,#0x4	; 023245DE
	pop {r3}	; 023245E0
	bx r3	; 023245E2
pool_023245E4:
loc_023245E4:
	.word 0x02333DAC	; 023245E4
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
	bl loc_0232912C	; 02324614
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
	bl loc_0232912C	; 02324672
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
	bl loc_02329604	; 02324698
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
	.word P1_Data_02330488	; 02324738
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
	bl loc_0232912C	; 02324772
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
	blx loc_0232DE0C	; 0232478E
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
	bl loc_02328FBC	; 023247AA
	ldr r0,[sp,#0x10]	; 023247AE
	ldr r1,[sp,#0x14]	; 023247B0
	bl loc_0232912C	; 023247B2
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
	bl loc_02328C5C	; 0232484C
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
	bl loc_0232912C	; 02324874
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
	bl loc_02328BAC	; 0232488E
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
	bl loc_02328B8C	; 023248A8
	str r0,[r6,#0x0]	; 023248AC
	mov r1,sp	; 023248AE
	sub r1,r1,#0x4	; 023248B0
	ldrh r0,[r4,#0x0]	; 023248B2
	strh r0,[r1,#0x0]	; 023248B4
	ldmia r1!,{r0}	; 023248B6
	ldr r1,[r5,#0x0]	; 023248B8
	bl loc_02329074	; 023248BA
	str r0,[r7,#0x0]	; 023248BE
	mov r1,sp	; 023248C0
	sub r1,r1,#0x4	; 023248C2
	ldrh r0,[r4,#0x2]	; 023248C4
	strh r0,[r1,#0x0]	; 023248C6
	ldmia r1!,{r0}	; 023248C8
	ldr r1,[r6,#0x0]	; 023248CA
	bl loc_0232903C	; 023248CC
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
	bl loc_02329534	; 02324A5A
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
	bl loc_0232DBC4	; 02324AB6
	b loc_02324AC8	; 02324ABA
loc_02324ABC:
	ldr r0,[r1,#0x14]	; 02324ABC
	add r0,r0,r4	; 02324ABE
	add r1,r6,#0x0	; 02324AC0
	add r2,r7,#0x0	; 02324AC2
	bl loc_0232DB9C	; 02324AC4
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
	bl loc_02329658	; 02324BF2
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
	blx loc_0232DE0C	; 02324C14
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
	.word 0x023443DC	; 02324C3C
pool_02324C40:
loc_02324C40:
	.word 0x023343C4	; 02324C40

; ===== function loc_02324C44 =====
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
	.word 0x023343DC	; 02324C54

; ===== function loc_02324C58 =====
loc_02324C58:
	ldr r0,[pool_02324C5C]	; 02324C58
	bx lr	; 02324C5A
pool_02324C5C:
loc_02324C5C:
	.word 0x023543FC	; 02324C5C
P1_Entry_02324C60:
	ldr r0,[pool_02324C64]	; 02324C60
	bx lr	; 02324C62
pool_02324C64:
	.word 0x023543DC	; 02324C64

; ===== function loc_02324C68 =====
loc_02324C68:
	ldr r0,[pool_02324C6C]	; 02324C68
	bx lr	; 02324C6A
pool_02324C6C:
loc_02324C6C:
	.word 0x023543DC	; 02324C6C

; ===== function loc_02324C70 =====
loc_02324C70:
	push {r4,r5,r6,lr}	; 02324C70
	ldr r0,[pool_02324CB8]	; 02324C72
	ldr r1,[pool_02324CBC]	; 02324C74
	ldr r2,[pool_02324CC0]	; 02324C76
	bl loc_02328FCC	; 02324C78
	ldr r0,[pool_02324CC4]	; 02324C7C
	ldr r1,[pool_02324CC8]	; 02324C7E
	ldr r2,[pool_02324CCC]	; 02324C80
	bl loc_02328FCC	; 02324C82
	ldr r0,[pool_02324CD0]	; 02324C86
	ldr r1,[pool_02324CD4]	; 02324C88
	ldr r2,[pool_02324CD8]	; 02324C8A
	bl loc_02328FCC	; 02324C8C
	ldr r0,[pool_02324CDC]	; 02324C90
	ldr r1,[pool_02324CE0]	; 02324C92
	ldr r2,[pool_02324CE4]	; 02324C94
	bl loc_02328FCC	; 02324C96
	mov r5,#0x0	; 02324C9A
	ldr r4,[pool_02324CB8]	; 02324C9C
	ldr r6,[pool_02324CE8]	; 02324C9E
	b loc_02324CAE	; 02324CA0
loc_02324CA2:
	lsl r0,r5,#0x5	; 02324CA2
	add r0,r4,r0	; 02324CA4
	ldrh r1,[r6,#0x0]	; 02324CA6
	bl loc_02328B58	; 02324CA8
	add r5,r5,#0x1	; 02324CAC
loc_02324CAE:
	cmp r5,#0x4	; 02324CAE
	bcc loc_02324CA2	; 02324CB0
	pop {r4,r5,r6}	; 02324CB2
	pop {r3}	; 02324CB4
	bx r3	; 02324CB6
pool_02324CB8:
loc_02324CB8:
	.word 0x023543DC	; 02324CB8
pool_02324CBC:
loc_02324CBC:
	.word P5_FontResource2	; 02324CBC
pool_02324CC0:
loc_02324CC0:
	.word 0x023A74A4	; 02324CC0
pool_02324CC4:
loc_02324CC4:
	.word 0x023543FC	; 02324CC4
pool_02324CC8:
loc_02324CC8:
	.word P5_FontResource3	; 02324CC8
pool_02324CCC:
loc_02324CCC:
	.word 0x023A7680	; 02324CCC
pool_02324CD0:
loc_02324CD0:
	.word 0x0235441C	; 02324CD0
pool_02324CD4:
loc_02324CD4:
	.word P5_FontResource1	; 02324CD4
pool_02324CD8:
loc_02324CD8:
	.word 0x023A7458	; 02324CD8
pool_02324CDC:
loc_02324CDC:
	.word 0x0235443C	; 02324CDC
pool_02324CE0:
loc_02324CE0:
	.word P5_FontResource0	; 02324CE0
pool_02324CE4:
loc_02324CE4:
	.word 0x023A73E4	; 02324CE4
pool_02324CE8:
loc_02324CE8:
	.word 0x0233048C	; 02324CE8
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
	.word 0x02354490	; 02324D8C

; ===== function loc_02324D90 =====
loc_02324D90:
	lsl r1,r0,#0x1	; 02324D90
	ldr r0,[pool_02324D98]	; 02324D92
	ldrh r0,[r0,r1]	; 02324D94
	bx lr	; 02324D96
pool_02324D98:
loc_02324D98:
	.word P1_Data_023304A8	; 02324D98

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
	.word 0x02330490	; 02324DF8
pool_02324DFC:
loc_02324DFC:
	.word 0x02354460	; 02324DFC
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
	.byte 0x01, 0x48, 0xC0, 0x69, 0x70, 0x47, 0xC0, 0x46, 0x90, 0x48, 0x35, 0x02	; 02324E4C
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
	.word 0x023548F0	; 02324E78
pool_02324E7C:
	.word 0x023A58E4	; 02324E7C
pool_02324E80:
	.word 0x0235491C	; 02324E80
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
	.word 0x023548B8	; 02324F2C
pool_02324F30:
	.word 0x023A487C	; 02324F30

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
	.word 0x023548C4	; 0232505C

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
	.word 0x023548C4	; 0232507C
pool_02325080:
loc_02325080:
	.word 0x023A58E4	; 02325080
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
	.word 0x023C0ED8	; 023251A0
pool_023251A4:
loc_023251A4:
	.word 0x023A4DBC	; 023251A4
pool_023251A8:
loc_023251A8:
	.word 0x023548F0	; 023251A8
pool_023251AC:
loc_023251AC:
	.word 0x0235491C	; 023251AC
pool_023251B0:
loc_023251B0:
	.word 0x023548B8	; 023251B0
pool_023251B4:
loc_023251B4:
	.word 0x023548C4	; 023251B4

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
	.word 0x023548C4	; 023251F8
pool_023251FC:
loc_023251FC:
	.word 0x023A58E4	; 023251FC
pool_02325200:
loc_02325200:
	.word 0x023548F0	; 02325200
pool_02325204:
loc_02325204:
	.word 0x0235491C	; 02325204

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
	.word 0x023548B8	; 02325230
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
	blx loc_0232DE0C	; 02325258
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
	.word P1_Data_02330164	; 023252A8

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
	.byte 0x01, 0xD1, 0x01, 0x20, 0x70, 0x47, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0x48, 0x49, 0x35, 0x02	; 023252F0
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
	.word P1_Data_02330168	; 02325320
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
	.word P1_Data_02330168	; 02325344
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
	.word P1_Data_02330168	; 02325368
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
	.word P1_Data_02330168	; 0232538C

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
	.word 0x02354960	; 02325408
pool_0232540C:
loc_0232540C:
	.word P1_Data_02330168	; 0232540C
pool_02325410:
loc_02325410:
	.word P1_BssStart + 0x24168	; 02325410
pool_02325414:
loc_02325414:
	.word 0x02354954	; 02325414
pool_02325418:
loc_02325418:
	.word P1_Data_02330174	; 02325418
pool_0232541C:
loc_0232541C:
	.word P1_Data_02330176	; 0232541C
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
	.word 0x02354960	; 023254E8
pool_023254EC:
loc_023254EC:
	.word P1_Data_02330168	; 023254EC
pool_023254F0:
loc_023254F0:
	.word 0x023A582C	; 023254F0
pool_023254F4:
loc_023254F4:
	.word 0x02354954	; 023254F4
pool_023254F8:
loc_023254F8:
	.word 0x023A4834	; 023254F8

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
	.word 0x02354960	; 023255A8
pool_023255AC:
loc_023255AC:
	.word P1_BssStart + 0x24168	; 023255AC
pool_023255B0:
loc_023255B0:
	.word 0x02354954	; 023255B0
pool_023255B4:
loc_023255B4:
	.word P1_Data_02330170	; 023255B4
pool_023255B8:
loc_023255B8:
	.word 0x023C0ED8	; 023255B8
pool_023255BC:
loc_023255BC:
	.word 0x023A4D1C	; 023255BC

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
	.word 0x023A582C	; 02325604
pool_02325608:
loc_02325608:
	.word P1_Data_02330170	; 02325608

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
	.word 0x02354960	; 0232567C
pool_02325680:
loc_02325680:
	.word P1_Data_02330168	; 02325680
pool_02325684:
loc_02325684:
	.word P1_BssStart + 0x24168	; 02325684
pool_02325688:
loc_02325688:
	.word 0x02354954	; 02325688

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
	bl loc_02328FBC	; 02325714
	ldr r0,[pool_0232572C]	; 02325718
	add r1,r5,#0x0	; 0232571A
	bl loc_023290F4	; 0232571C
	add sp,#0x8	; 02325720
	pop {r4,r5,r6}	; 02325722
	pop {r3}	; 02325724
	bx r3	; 02325726
pool_02325728:
loc_02325728:
	.word 0x00000300	; 02325728
pool_0232572C:
loc_0232572C:
	.word 0x023549E0	; 0232572C
pool_02325730:
loc_02325730:
	.word 0x00000100	; 02325730

; Returns the fixed firmware UI/boot shared-context address.
; 返回固件 UI/启动共享上下文的固定地址。
.func P1_GetFirmwareUiContext
loc_02325734:
	ldr r0,[pool_02325738]	; 02325734
	bx lr	; 02325736
.endfunc
pool_02325738:
loc_02325738:
	.word 0x023549F0	; 02325738

; Initializes the first known fields of the shared firmware UI/boot context.
; 初始化固件 UI/启动共享上下文中已确认的首批字段。
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
	bl loc_0232C756	; 023257F2
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
	.word P1_Data_02330180	; 02325A1C

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
	.word P1_Data_02330180	; 02325A5C

; ===== function loc_02325A60 =====
loc_02325A60:
	push {r4,r5,r6,r7,lr}	; 02325A60
	sub sp,#0x1fc	; 02325A62
	sub sp,#0x10	; 02325A64
	add r5,r0,#0x0	; 02325A66
	mov r4,#0x0	; 02325A68
	add r0,sp,#0x8	; 02325A6A
	ldr r1,[pool_02325ACC]	; 02325A6C
	bl loc_0232D164	; 02325A6E
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
	bl loc_0232D8FC	; 02325AF0
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
	bl loc_0232D8FC	; 02325B76
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
	bl loc_0232D8FC	; 02325C34
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
	.word 0x023A5924	; 02325DB4

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
	.word 0x023A5924	; 02325E60

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
	bl loc_0232D8FC	; 02325E82
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
	bl loc_0232D8FC	; 02325F18
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
	bl loc_0232C6D8	; 02326012
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
	.word 0x023A5924	; 0232604C

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
	bl loc_0232D164	; 02326098
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
	bl loc_0232F254	; 02326176
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
	.word 0x023305F0	; 0232627C
pool_02326280:
loc_02326280:
	.word 0x023305FC	; 02326280
pool_02326284:
loc_02326284:
	.word 0x0233060C	; 02326284

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
	.word 0x02330618	; 023262DC
pool_023262E0:
loc_023262E0:
	.word 0x02330630	; 023262E0
pool_023262E4:
loc_023262E4:
	.word 0x02330648	; 023262E4
pool_023262E8:
loc_023262E8:
	.word 0x02330660	; 023262E8

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
	.byte 0x07, 0xF0, 0xDA, 0xEC, 0x00, 0x22, 0x04, 0x48, 0x34, 0x30, 0x00, 0x78, 0x41, 0x00, 0x03, 0x48	; 0232640C
	.byte 0x42, 0x52, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x9C, 0xFC, 0x7F, 0x02, 0x10, 0x4A, 0x35, 0x02	; 0232641C

; ===== function loc_0232642C =====
loc_0232642C:
	push {lr}	; 0232642C
	sub sp,#0x4	; 0232642E
	ldr r0,[pool_02326450]	; 02326430
	ldr r1,[pool_02326454]	; 02326432
	ldrb r2,[r0,#0x14]	; 02326434
	lsl r2,r2,#0x1	; 02326436
	blx loc_0232DDC4	; 02326438
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
	.word 0x02354A48	; 023264D4
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
	bl loc_023286DC	; 023264F8
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
	bl loc_0232DBC4	; 02326516
	add r5,r5,#0x1	; 0232651A
	cmp r5,#0x1a	; 0232651C
	blt loc_0232650C	; 0232651E
	ldr r0,[pool_02326588]	; 02326520
	ldr r1,[pool_0232658C]	; 02326522
	mov r2,#0x2	; 02326524
	bl loc_0232DC64	; 02326526
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
	.word 0x02354A48	; 02326578
pool_0232657C:
loc_0232657C:
	.word 0x02354DE8	; 0232657C
pool_02326580:
loc_02326580:
	.word 0x000003A0	; 02326580
pool_02326584:
loc_02326584:
	.word 0x0001D000	; 02326584
pool_02326588:
loc_02326588:
	.word 0x02330194	; 02326588
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
	bl loc_0232FBEC	; 02326654
	mov r0,#0x0	; 02326658
	ldr r1,[pool_0232667C]	; 0232665A
	bl loc_0232FB54	; 0232665C
	mov r0,#0x0	; 02326660
	ldr r1,[pool_02326678]	; 02326662
	bl loc_0232FAA8	; 02326664
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
	bl loc_02329CDC	; 0232671E
	ldr r0,[pool_02326898]	; 02326722
	ldr r0,[r0,#0x0]	; 02326724
	cmp r0,#0x0	; 02326726
	beq loc_0232672C	; 02326728
	blx r0	; 0232672A
loc_0232672C:
	bl loc_02327CA4	; 0232672C
	mov r0,#0x1	; 02326730
	add r1,r0,#0x0	; 02326732
	blx loc_0232AF6C	; 02326734
	bl loc_02326934	; 02326738
	bl loc_0232D450	; 0232673C
	ldr r2,[pool_0232689C]	; 02326740
	ldr r1,[r2,#0x0]	; 02326742
	ldr r0,[pool_023268A0]	; 02326744
	and r1,r0	; 02326746
	str r1,[r2,#0x0]	; 02326748
	mov r0,#0x1	; 0232674A
	add r1,r0,#0x0	; 0232674C
	blx loc_0232AF6C	; 0232674E
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
	bl loc_0232F040	; 0232676C
	mov r0,#0x1	; 02326770
	add r1,r0,#0x0	; 02326772
	blx loc_0232AF6C	; 02326774
	mov r0,#0x1	; 02326778
	add r1,r0,#0x0	; 0232677A
	blx loc_0232AF6C	; 0232677C
	bl loc_0232D410	; 02326780
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
	bl loc_0232F180	; 023267CC
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
	bl loc_02327CC4	; 023267E2
	bl loc_02327CA4	; 023267E6
	bl loc_02327CC4	; 023267EA
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
	bl loc_0232C66C	; 02326804
	cmp r0,#0x0	; 02326808
	beq loc_02326810	; 0232680A
loc_0232680C:
	bl loc_0232F150	; 0232680C
loc_02326810:
	ldr r0,[pool_023268AC]	; 02326810
	ldr r0,[r0,#0x0]	; 02326812
	cmp r0,#0x0	; 02326814
	beq loc_0232681A	; 02326816
	blx r0	; 02326818
loc_0232681A:
	bl loc_02329CD4	; 0232681A
	ldr r1,[pool_02326884]	; 0232681E
	ldr r2,[r1,#0x0]	; 02326820
	mov r0,#0x40	; 02326822
	bic r2,r0	; 02326824
	str r2,[r1,#0x0]	; 02326826
	b loc_02326876	; 02326828
loc_0232682A:
	bl loc_02327CC4	; 0232682A
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
	bl loc_0232C66C	; 02326844
	cmp r0,#0x0	; 02326848
	beq loc_02326860	; 0232684A
loc_0232684C:
	bl loc_02329CDC	; 0232684C
	ldr r0,[pool_02326898]	; 02326850
	ldr r0,[r0,#0x0]	; 02326852
	cmp r0,#0x0	; 02326854
	beq loc_0232685A	; 02326856
	blx r0	; 02326858
loc_0232685A:
	bl loc_0232C4CC	; 0232685A
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
	bl loc_0232FB54	; 023268CA
	mov r0,#0x1	; 023268CE
	ldr r1,[pool_023268E8]	; 023268D0
	bl loc_0232FB54	; 023268D2
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
	.word loc_02329440 + 1	; 02326930

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
	.word loc_02329440 + 1	; 02326948

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
	bl loc_02329440	; 023269C8
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
	bl loc_02329440	; 023269FC
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
	.word P1_Data_02330198	; 02326A0C

; ===== function loc_02326A10 =====
loc_02326A10:
	push {lr}	; 02326A10
	sub sp,#0x4	; 02326A12
	ldr r0,[pool_02326A28]	; 02326A14
	mov r1,#0x0	; 02326A16
	mov r2,#0xc	; 02326A18
	blx loc_0232DE90	; 02326A1A
	bl loc_0232948C	; 02326A1E
	add sp,#0x4	; 02326A22
	pop {r3}	; 02326A24
	bx r3	; 02326A26
pool_02326A28:
loc_02326A28:
	.word 0x023555DC	; 02326A28

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
	.word 0x023555F4	; 02326A44

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
	.word 0x023555E8	; 02326A60

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
	bl loc_0232FD1C	; 02326A7C
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
	.word P1_Data_02330678	; 02326B48
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
	bl loc_0232D6E8	; 02326CDE
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
	bl loc_0232D6E8	; 02326D0A
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
	bl loc_0232D6E8	; 02326D36
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
	bl loc_0232D6E8	; 02326D62
	pop {r4}	; 02326D66
	pop {r3}	; 02326D68
	bx r3	; 02326D6A
pool_02326D6C:
loc_02326D6C:
	.word P1_BssStart + 0x266B0	; 02326D6C
pool_02326D70:
loc_02326D70:
	.word VRAM_A_CR	; 02326D70

; ===== function P1_DecompressAndCheckP3P4 =====
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

; ===== function P1_DecompressAndCheckP5 =====
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
	bl loc_0232F254	; 02326E3A
	mov r0,#0x2	; 02326E3E
	mov r1,#0x1	; 02326E40
	bl loc_0232F180	; 02326E42
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
	blx loc_0232DE58	; 02326E5A
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
	bl loc_0232B35C	; 02326E94
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
	bl loc_0232DD28	; 02326ED6
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
	bl loc_0232B1F4	; 02326F08
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
	.word 0x02355620	; 02326F40
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
	.word 0x023556A0	; 02326F54
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
	.word loc_0232E858 + 1	; 02326FD8

; ===== function loc_02326FDC =====
loc_02326FDC:
	push {lr}	; 02326FDC
	sub sp,#0x4	; 02326FDE
	ldr r0,[pool_02326FF4]	; 02326FE0
	ldrb r1,[r0,#0x0]	; 02326FE2
	add r0,sp,#0x0	; 02326FE4
	strb r1,[r0,#0x0]	; 02326FE6
	add r0,sp,#0x0	; 02326FE8
	bl loc_0232FBF8	; 02326FEA
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
	bl loc_0232EB78	; 02327028
	add r0,sp,#0x14	; 0232702C
	bl loc_0232EDC0	; 0232702E
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
; 检查 ROM 尾标记 ac，写入补丁模式 1/2；无效头路径不更新。
; Check the ac ROM trailer and publish patch mode 1/2; invalid headers leave it unchanged.
.func P1_ClassifyTrailerForRuntimePatch
	push {r4,r5,r6,r7,lr}	; 02327058
	sub sp,#0x4	; 0232705A
	ldr r7,[pool_023270D8]	; 0232705C
	ldr r0,[pool_023270DC]	; 0232705E
	ldr r5,[r0,#0x0]	; 02327060
	cmp r5,#0x0	; 02327062
	bne loc_02327068	; 02327064
	ldr r5,[pool_023270E0]	; 02327066
loc_02327068:
	ldr r0,[pool_023270E4]	; 02327068
	add r6,r5,#0x0	; 0232706A
	and r6,r0	; 0232706C
	bl loc_02326F9C	; 0232706E
	cmp r0,#0x0	; 02327072
	beq loc_023270D0	; 02327074
	blx loc_0232B204	; 02327076
	add r4,r0,#0x0	; 0232707A
	cmp r4,#0x0	; 0232707C
	beq loc_023270AA	; 0232707E
	lsl r0,r4,#0x10	; 02327080
	lsr r0,r0,#0x10	; 02327082
	bl loc_0232B2F0	; 02327084
	add r0,r7,#0x0	; 02327088
	ldr r1,[pool_023270E8]	; 0232708A
	blx P1_CleanAndInvalidateDataCacheRange	; 0232708C
	add r0,r6,#0x0	; 02327090
	add r1,r7,#0x0	; 02327092
	ldr r2,[pool_023270E8]	; 02327094
	bl loc_02327C04	; 02327096
	lsl r0,r4,#0x10	; 0232709A
	lsr r0,r0,#0x10	; 0232709C
	bl loc_0232B1FC	; 0232709E
	lsl r0,r4,#0x10	; 023270A2
	lsr r0,r0,#0x10	; 023270A4
	blx loc_0232B25C	; 023270A6
loc_023270AA:
	ldr r0,[pool_023270EC]	; 023270AA
	and r5,r0	; 023270AC
	add r1,r7,r5	; 023270AE
	ldrb r0,[r7,r5]	; 023270B0
	cmp r0,#0x61	; 023270B2
	bne loc_023270CA	; 023270B4
	ldrb r0,[r1,#0x1]	; 023270B6
	cmp r0,#0x63	; 023270B8
	bne loc_023270CA	; 023270BA
	mov r1,#0x1	; 023270BC
	ldr r0,[pool_023270F0]	; 023270BE
	strb r1,[r0,#0x0]	; 023270C0
	add sp,#0x4	; 023270C2
	pop {r4,r5,r6,r7}	; 023270C4
	pop {r3}	; 023270C6
	bx r3	; 023270C8
loc_023270CA:
	mov r1,#0x2	; 023270CA
	ldr r0,[pool_023270F0]	; 023270CC
	strb r1,[r0,#0x0]	; 023270CE
loc_023270D0:
	add sp,#0x4	; 023270D0
	pop {r4,r5,r6,r7}	; 023270D2
	pop {r3}	; 023270D4
	bx r3	; 023270D6
.endfunc
pool_023270D8:
loc_023270D8:
	.word 0x023556E0	; 023270D8
pool_023270DC:
loc_023270DC:
	.word NdsCartHeaderRamAddress + 0x80	; 023270DC
pool_023270E0:
loc_023270E0:
	.word 0x01000000	; 023270E0
pool_023270E4:
loc_023270E4:
	.word 0xFFFFFE00	; 023270E4
pool_023270E8:
loc_023270E8:
	.word 0x00000200	; 023270E8
pool_023270EC:
loc_023270EC:
	.word 0x000001FF	; 023270EC
pool_023270F0:
loc_023270F0:
	.word FirmwareBootSharedAddress + BootSharedRuntimePatchModeOffset	; 023270F0

; ===== function loc_023270F4 =====
loc_023270F4:
	push {r4,r5,lr}	; 023270F4
	sub sp,#0x4	; 023270F6
	ldr r5,[pool_0232717C]	; 023270F8
	bl loc_02326F9C	; 023270FA
	cmp r0,#0x0	; 023270FE
	beq loc_0232710A	; 02327100
	ldr r0,[pool_02327180]	; 02327102
	ldr r0,[r0,#0x0]	; 02327104
	cmp r0,#0x0	; 02327106
	bne loc_02327118	; 02327108
loc_0232710A:
	mov r1,#0x0	; 0232710A
	ldr r0,[pool_02327184]	; 0232710C
	str r1,[r0,#0x0]	; 0232710E
	add sp,#0x4	; 02327110
	pop {r4,r5}	; 02327112
	pop {r3}	; 02327114
	bx r3	; 02327116
loc_02327118:
	blx loc_0232B204	; 02327118
	add r4,r0,#0x0	; 0232711C
	cmp r4,#0x0	; 0232711E
	beq loc_0232714E	; 02327120
	lsl r0,r4,#0x10	; 02327122
	lsr r0,r0,#0x10	; 02327124
	bl loc_0232B2F0	; 02327126
	add r0,r5,#0x0	; 0232712A
	ldr r1,[pool_02327188]	; 0232712C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232712E
	ldr r0,[pool_02327180]	; 02327132
	ldr r0,[r0,#0x0]	; 02327134
	add r1,r5,#0x0	; 02327136
	ldr r2,[pool_02327188]	; 02327138
	bl loc_02327C04	; 0232713A
	lsl r0,r4,#0x10	; 0232713E
	lsr r0,r0,#0x10	; 02327140
	bl loc_0232B1FC	; 02327142
	lsl r0,r4,#0x10	; 02327146
	lsr r0,r0,#0x10	; 02327148
	blx loc_0232B25C	; 0232714A
loc_0232714E:
	ldr r0,[pool_0232718C]	; 0232714E
	add r1,r5,#0x0	; 02327150
	add r1,#0x20	; 02327152
	ldr r2,[pool_02327190]	; 02327154
	bl P1_SwiGetCrc16	; 02327156
	ldrh r1,[r5,#0x2]	; 0232715A
	cmp r1,r0	; 0232715C
	beq loc_0232716E	; 0232715E
	mov r1,#0x0	; 02327160
	ldr r0,[pool_02327184]	; 02327162
	str r1,[r0,#0x0]	; 02327164
	add sp,#0x4	; 02327166
	pop {r4,r5}	; 02327168
	pop {r3}	; 0232716A
	bx r3	; 0232716C
loc_0232716E:
	mov r1,#0x1	; 0232716E
	ldr r0,[pool_02327184]	; 02327170
	str r1,[r0,#0x0]	; 02327172
	add sp,#0x4	; 02327174
	pop {r4,r5}	; 02327176
	pop {r3}	; 02327178
	bx r3	; 0232717A
pool_0232717C:
loc_0232717C:
	.word 0x023556E0	; 0232717C
pool_02327180:
loc_02327180:
	.word NdsCartHeaderRamAddress + 0x68	; 02327180
pool_02327184:
loc_02327184:
	.word P1_BssStart + 0x24E24	; 02327184
pool_02327188:
loc_02327188:
	.word 0x00000840	; 02327188
pool_0232718C:
loc_0232718C:
	.word 0x0000FFFF	; 0232718C
pool_02327190:
loc_02327190:
	.word 0x00000820	; 02327190

; ===== function loc_02327194 =====
loc_02327194:
	push {lr}	; 02327194
	sub sp,#0x4	; 02327196
	add r1,r0,#0x0	; 02327198
	ldr r0,[pool_023271BC]	; 0232719A
	ldr r0,[r0,#0x0]	; 0232719C
	cmp r0,#0x0	; 0232719E
	bne loc_023271AA	; 023271A0
	mov r0,#0x0	; 023271A2
	add sp,#0x4	; 023271A4
	pop {r3}	; 023271A6
	bx r3	; 023271A8
loc_023271AA:
	ldr r0,[pool_023271C0]	; 023271AA
	ldr r2,[pool_023271C4]	; 023271AC
	blx loc_0232DDC4	; 023271AE
	mov r0,#0x1	; 023271B2
	add sp,#0x4	; 023271B4
	pop {r3}	; 023271B6
	bx r3	; 023271B8
	.byte 0xC0, 0x46	; 023271BC
pool_023271BC:
loc_023271BC:
	.word P1_BssStart + 0x24E24	; 023271BC
pool_023271C0:
loc_023271C0:
	.word 0x023556E0	; 023271C0
pool_023271C4:
loc_023271C4:
	.word 0x00000840	; 023271C4

; ===== function loc_023271C8 =====
loc_023271C8:
	ldr r1,[r0,#0x0]	; 023271C8
	cmp r1,#0x17	; 023271CA
	bhi loc_023271DA	; 023271CC
	ldr r1,[r0,#0x4]	; 023271CE
	cmp r1,#0x3b	; 023271D0
	bhi loc_023271DA	; 023271D2
	ldr r0,[r0,#0x8]	; 023271D4
	cmp r0,#0x3b	; 023271D6
	bls loc_023271DE	; 023271D8
loc_023271DA:
	mov r0,#0x0	; 023271DA
	bx lr	; 023271DC
loc_023271DE:
	mov r0,#0x1	; 023271DE
	bx lr	; 023271E0
	.byte 0x00, 0x00	; 023271E4

; ===== function loc_023271E4 =====
loc_023271E4:
	ldr r1,[r0,#0x0]	; 023271E4
	cmp r1,#0x64	; 023271E6
	bcs loc_02327204	; 023271E8
	ldr r1,[r0,#0x4]	; 023271EA
	cmp r1,#0x1	; 023271EC
	bcc loc_02327204	; 023271EE
	cmp r1,#0xc	; 023271F0
	bhi loc_02327204	; 023271F2
	ldr r1,[r0,#0x8]	; 023271F4
	cmp r1,#0x1	; 023271F6
	bcc loc_02327204	; 023271F8
	cmp r1,#0x1f	; 023271FA
	bhi loc_02327204	; 023271FC
	ldr r0,[r0,#0xc]	; 023271FE
	cmp r0,#0x7	; 02327200
	blt loc_02327208	; 02327202
loc_02327204:
	mov r0,#0x0	; 02327204
	bx lr	; 02327206
loc_02327208:
	mov r0,#0x1	; 02327208
	bx lr	; 0232720A

; ===== function loc_0232720C =====
loc_0232720C:
	push {lr}	; 0232720C
	sub sp,#0x24	; 0232720E
	ldr r0,[pool_023272A8]	; 02327210
	bl P1_LoadAndSelectUserSettings	; 02327212
	ldr r1,[pool_023272AC]	; 02327216
	str r0,[r1,#0x0]	; 02327218
	ldr r0,[r1,#0x0]	; 0232721A
	cmp r0,#0x0	; 0232721C
	beq loc_0232725E	; 0232721E
	mov r0,#0x0	; 02327220
	str r0,[sp,#0x0]	; 02327222
	add r0,sp,#0x0	; 02327224
	ldr r1,[pool_023272A8]	; 02327226
	ldr r2,[pool_023272B0]	; 02327228
	bl loc_0232C76E	; 0232722A
	mov r1,#0x5	; 0232722E
	ldr r0,[pool_023272A8]	; 02327230
	strb r1,[r0,#0x0]	; 02327232
	ldr r0,[pool_023272B4]	; 02327234
	ldrh r2,[r0,#0x0]	; 02327236
	mov r1,#0x30	; 02327238
	bic r2,r1	; 0232723A
	mov r1,#0x20	; 0232723C
	orr r2,r1	; 0232723E
	strh r2,[r0,#0x0]	; 02327240
	ldrh r3,[r0,#0x0]	; 02327242
	mov r1,#0x7	; 02327244
	bic r3,r1	; 02327246
	mov r2,#0x1	; 02327248
	orr r3,r2	; 0232724A
	strh r3,[r0,#0x0]	; 0232724C
	ldrh r3,[r0,#0x0]	; 0232724E
	ldr r1,[pool_023272B8]	; 02327250
	orr r3,r1	; 02327252
	strh r3,[r0,#0x0]	; 02327254
	ldr r0,[pool_023272BC]	; 02327256
	strb r2,[r0,#0x0]	; 02327258
	ldr r0,[pool_023272C0]	; 0232725A
	strb r2,[r0,#0x0]	; 0232725C
loc_0232725E:
	add r0,sp,#0x4	; 0232725E
	add r1,sp,#0x14	; 02327260
	bl loc_0232FD1C	; 02327262
	add r0,sp,#0x4	; 02327266
	bl loc_023271E4	; 02327268
	cmp r0,#0x0	; 0232726C
	beq loc_02327286	; 0232726E
	add r0,sp,#0x14	; 02327270
	bl loc_023271C8	; 02327272
	cmp r0,#0x0	; 02327276
	beq loc_02327286	; 02327278
	ldr r0,[pool_023272C4]	; 0232727A
	ldrb r1,[r0,#0x0]	; 0232727C
	mov r0,#0x1	; 0232727E
	and r1,r0	; 02327280
	cmp r1,#0x0	; 02327282
	beq loc_023272A2	; 02327284
loc_02327286:
	ldr r2,[pool_023272B4]	; 02327286
	ldrh r1,[r2,#0x0]	; 02327288
	ldr r0,[pool_023272C8]	; 0232728A
	and r1,r0	; 0232728C
	strh r1,[r2,#0x0]	; 0232728E
	mov r1,#0x0	; 02327290
	ldr r0,[pool_023272CC]	; 02327292
	str r1,[r0,#0x0]	; 02327294
	str r1,[r0,#0x4]	; 02327296
	ldr r0,[pool_023272D0]	; 02327298
	strb r1,[r0,#0x0]	; 0232729A
	ldr r0,[pool_023272A8]	; 0232729C
	bl loc_02328348	; 0232729E
loc_023272A2:
	add sp,#0x24	; 023272A2
	pop {r3}	; 023272A4
	bx r3	; 023272A6
pool_023272A8:
loc_023272A8:
	.word FirmwareUserSettingsSharedAddress	; 023272A8
pool_023272AC:
loc_023272AC:
	.word FirmwareBootSharedAddress + BootSharedSettingsInvalidOffset	; 023272AC
pool_023272B0:
loc_023272B0:
	.word 0x0100001C	; 023272B0
pool_023272B4:
loc_023272B4:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 023272B4
pool_023272B8:
loc_023272B8:
	.word 0x00000200	; 023272B8
pool_023272BC:
loc_023272BC:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthMonthOffset	; 023272BC
pool_023272C0:
loc_023272C0:
	.word FirmwareUserSettingsSharedAddress + UserSettingsBirthDayOffset	; 023272C0
pool_023272C4:
loc_023272C4:
	.word FirmwareBootInfoScratchAddress + BootScratchRtcSourceOffset	; 023272C4
pool_023272C8:
loc_023272C8:
	.word 0xFFFFBFFF	; 023272C8
pool_023272CC:
loc_023272CC:
	.word FirmwareUserSettingsSharedAddress + UserSettingsRtcOffset	; 023272CC
pool_023272D0:
loc_023272D0:
	.word FirmwareUserSettingsSharedAddress + 0x66	; 023272D0
.arm
; 此段随后覆盖复制至 ITCM；运行入口不是 CRT 初始内容。
; This stub later replaces ITCM contents; its entry is not the CRT image.
P1_TransitionCopySource:
.func P1_TransitionLoadEntry
	ldr r0,[pool_02327318]	; 023272D4
	mov r1,#0x9	; 023272D8
	str r1,[r0,#0x0]	; 023272DC
	ldr r1,[pool_0232731C]	; 023272E0
	b loc_023272F0	; 023272E4
loc_023272E8:
	mov r0,#0x400	; 023272E8
	swi 0x30000	; 023272EC
loc_023272F0:
	ldr r0,[r1,#0x0]	; 023272F0
	cmp r0,#0xa	; 023272F4
	bne loc_023272E8	; 023272F8
	ldr r1,[pool_02327320]	; 023272FC
	ldrh r0,[r1,#0x0]	; 02327300
	bic r0,r0,#0x4000	; 02327304
	strh r0,[r1,#0x0]	; 02327308
	mov r0,#0x0	; 0232730C
	mcr p15,0x0,r0,c7,c0,0x4	; 02327310
	bx lr	; 02327314
.endfunc
.definelabel P1_TransitionItcmBase, 0x01FF8000
.definelabel P1_TransitionRuntimeEntry, P1_TransitionItcmBase + (P1_TransitionLoadEntry - P1_TransitionCopySource)
pool_02327318:
loc_02327318:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 02327318
pool_0232731C:
loc_0232731C:
	.word 0x027FF884	; 0232731C
pool_02327320:
loc_02327320:
	.word REG_EXMEMCNT_ARM9	; 02327320
.thumb

; ===== function loc_02327324 =====
loc_02327324:
	push {lr}	; 02327324
	sub sp,#0x4	; 02327326
	mov r0,#0x3	; 02327328
	bl loc_0232D6D4	; 0232732A
	mov r0,#0x0	; 0232732E
	str r0,[sp,#0x0]	; 02327330
	ldr r0,[sp,#0x0]	; 02327332
	ldr r1,[pool_02327344]	; 02327334
	ldr r2,[pool_02327348]	; 02327336
	blx loc_0232DE0C	; 02327338
	add sp,#0x4	; 0232733C
	pop {r3}	; 0232733E
	bx r3	; 02327340
	.byte 0xC0, 0x46	; 02327344
pool_02327344:
loc_02327344:
	.word 0x06800000	; 02327344
pool_02327348:
loc_02327348:
	.word 0x00040000	; 02327348

; ===== function loc_0232734C =====
loc_0232734C:
	push {lr}	; 0232734C
	sub sp,#0x4	; 0232734E
	ldr r0,[pool_02327400]	; 02327350
	ldrh r0,[r0,#0x0]	; 02327352
	lsl r0,r0,#0x1c	; 02327354
	lsr r0,r0,#0x1f	; 02327356
	cmp r0,#0x0	; 02327358
	beq loc_0232736E	; 0232735A
	ldr r0,[pool_02327404]	; 0232735C
	ldr r0,[r0,#0x0]	; 0232735E
	cmp r0,#0x0	; 02327360
	bne loc_0232736E	; 02327362
	mov r0,#0x0	; 02327364
	add r1,r0,#0x0	; 02327366
	bl loc_0232F180	; 02327368
	b loc_02327376	; 0232736C
loc_0232736E:
	mov r0,#0x1	; 0232736E
	mov r1,#0x0	; 02327370
	bl loc_0232F180	; 02327372
loc_02327376:
	ldr r1,[pool_02327408]	; 02327376
	ldrh r0,[r1,#0x0]	; 02327378
	mov r0,#0x0	; 0232737A
	strh r0,[r1,#0x0]	; 0232737C
	bl loc_0232B128	; 0232737E
	bl loc_0232D604	; 02327382
	bl loc_0232D5F4	; 02327386
	bl loc_0232D5C4	; 0232738A
	bl loc_0232D5B4	; 0232738E
	bl loc_0232D5E4	; 02327392
	ldr r0,[pool_0232740C]	; 02327396
	bl loc_0232D6D4	; 02327398
	mov r0,#0x0	; 0232739C
	str r0,[sp,#0x0]	; 0232739E
	ldr r0,[sp,#0x0]	; 023273A0
	ldr r1,[pool_02327410]	; 023273A2
	ldr r2,[pool_02327414]	; 023273A4
	blx loc_0232DE0C	; 023273A6
	bl loc_0232D5D4	; 023273AA
	bl loc_02327324	; 023273AE
	bl loc_0232D410	; 023273B2
	ldr r0,[pool_02327418]	; 023273B6
	ldrh r2,[r0,#0x0]	; 023273B8
	mov r1,#0x2	; 023273BA
	orr r2,r1	; 023273BC
	strh r2,[r0,#0x0]	; 023273BE
	ldrh r2,[r0,#0x0]	; 023273C0
	ldr r1,[pool_0232741C]	; 023273C2
	and r2,r1	; 023273C4
	strh r2,[r0,#0x0]	; 023273C6
	ldrh r2,[r0,#0x0]	; 023273C8
	mov r1,#0xc	; 023273CA
	bic r2,r1	; 023273CC
	strh r2,[r0,#0x0]	; 023273CE
	ldr r1,[pool_02327400]	; 023273D0
	ldrh r1,[r1,#0x0]	; 023273D2
	lsl r1,r1,#0x1c	; 023273D4
	lsr r1,r1,#0x1f	; 023273D6
	cmp r1,#0x0	; 023273D8
	beq loc_023273EC	; 023273DA
	ldr r1,[pool_02327404]	; 023273DC
	ldr r1,[r1,#0x0]	; 023273DE
	cmp r1,#0x0	; 023273E0
	bne loc_023273EC	; 023273E2
	ldrh r2,[r0,#0x0]	; 023273E4
	ldr r1,[pool_02327420]	; 023273E6
	and r2,r1	; 023273E8
	strh r2,[r0,#0x0]	; 023273EA
loc_023273EC:
; CpuFastSet 的 0x100 个字复制 0x400 字节，再进入新的 ITCM 段。
; CpuFastSet copies 0x100 words (0x400 bytes), then enters the new ITCM stub.
	ldr r0,[pool_02327424]	; 023273EC
	ldr r1,[pool_02327428]	; 023273EE
	ldr r2,[pool_0232742C]	; 023273F0
	bl loc_0232C76E	; 023273F2
	ldr r0,[pool_02327428]	; 023273F6
	blx r0	; 023273F8
	add sp,#0x4	; 023273FA
	pop {r3}	; 023273FC
	bx r3	; 023273FE
pool_02327400:
loc_02327400:
	.word FirmwareUserSettingsSharedAddress + UserSettingsOptionsOffset	; 02327400
pool_02327404:
loc_02327404:
	.word FirmwareBootSharedAddress + BootSharedSettingsInvalidOffset	; 02327404
pool_02327408:
loc_02327408:
	.word REG_IME	; 02327408
pool_0232740C:
loc_0232740C:
	.word 0x000001FF	; 0232740C
pool_02327410:
loc_02327410:
	.word 0x06800000	; 02327410
pool_02327414:
loc_02327414:
	.word 0x000A4000	; 02327414
pool_02327418:
loc_02327418:
	.word REG_POWERCNT	; 02327418
pool_0232741C:
loc_0232741C:
	.word 0xFFFFFDFF	; 0232741C
pool_02327420:
loc_02327420:
	.word 0xFFFF7FFF	; 02327420
pool_02327424:
loc_02327424:
	.word P1_TransitionCopySource	; 02327424
pool_02327428:
loc_02327428:
	.word P1_TransitionRuntimeEntry	; 02327428
pool_0232742C:
loc_0232742C:
	.word 0x00000100	; 0232742C

; ===== function loc_02327430 =====
loc_02327430:
	push {lr}	; 02327430
	sub sp,#0x24	; 02327432
	mov r0,#0x0	; 02327434
	bl loc_0232B128	; 02327436
	mov r0,#0x0	; 0232743A
	mvn r0,r0	; 0232743C
	bl loc_0232B0B0	; 0232743E
	ldr r0,[pool_023274E4]	; 02327442
	bl loc_0232D6D4	; 02327444
	mov r0,#0x0	; 02327448
	str r0,[sp,#0x0]	; 0232744A
	ldr r0,[sp,#0x0]	; 0232744C
	ldr r1,[pool_023274E8]	; 0232744E
	ldr r2,[pool_023274EC]	; 02327450
	blx loc_0232DE0C	; 02327452
	bl loc_0232D5D4	; 02327456
	mov r0,#0x0	; 0232745A
	str r0,[sp,#0x4]	; 0232745C
	ldr r0,[sp,#0x4]	; 0232745E
	ldr r1,[pool_023274F0]	; 02327460
	ldr r2,[pool_023274F4]	; 02327462
	blx loc_0232DE0C	; 02327464
	mov r0,#0x0	; 02327468
	str r0,[sp,#0x8]	; 0232746A
	ldr r0,[sp,#0x8]	; 0232746C
	ldr r1,[pool_023274F8]	; 0232746E
	ldr r2,[pool_023274F4]	; 02327470
	blx loc_0232DE0C	; 02327472
	mov r0,#0x0	; 02327476
	str r0,[sp,#0xc]	; 02327478
	ldr r0,[sp,#0xc]	; 0232747A
	ldr r1,[pool_023274FC]	; 0232747C
	ldr r2,[pool_023274F4]	; 0232747E
	blx loc_0232DE0C	; 02327480
	mov r0,#0x0	; 02327484
	str r0,[sp,#0x10]	; 02327486
	ldr r0,[sp,#0x10]	; 02327488
	ldr r1,[pool_02327500]	; 0232748A
	ldr r2,[pool_023274F4]	; 0232748C
	blx loc_0232DE0C	; 0232748E
	mov r0,#0x0	; 02327492
	str r0,[sp,#0x14]	; 02327494
	ldr r0,[sp,#0x14]	; 02327496
	ldr r1,[pool_02327504]	; 02327498
	ldr r2,[pool_02327508]	; 0232749A
	blx loc_0232DE0C	; 0232749C
	mov r0,#0x0	; 023274A0
	str r0,[sp,#0x18]	; 023274A2
	ldr r0,[sp,#0x18]	; 023274A4
	ldr r1,[pool_0232750C]	; 023274A6
	mov r2,#0x40	; 023274A8
	blx loc_0232DE0C	; 023274AA
	mov r0,#0x0	; 023274AE
	str r0,[sp,#0x1c]	; 023274B0
	ldr r0,[sp,#0x1c]	; 023274B2
	ldr r1,[pool_02327510]	; 023274B4
	mov r2,#0x6e	; 023274B6
	blx loc_0232DE0C	; 023274B8
	mov r0,#0x0	; 023274BC
	ldr r1,[pool_0232750C]	; 023274BE
	strh r0,[r1,#0x0]	; 023274C0
	ldr r1,[pool_02327514]	; 023274C2
	str r0,[r1,#0x0]	; 023274C4
	mov r2,#0x1	; 023274C6
	ldr r1,[pool_02327518]	; 023274C8
	str r2,[r1,#0x0]	; 023274CA
	str r0,[r1,#0x4]	; 023274CC
	ldr r2,[pool_0232751C]	; 023274CE
	ldr r1,[pool_02327520]	; 023274D0
	strh r2,[r1,#0x0]	; 023274D2
	ldr r1,[pool_02327524]	; 023274D4
	str r0,[r1,#0x0]	; 023274D6
	ldr r1,[pool_02327528]	; 023274D8
	strh r0,[r1,#0x0]	; 023274DA
	add sp,#0x24	; 023274DC
	pop {r3}	; 023274DE
	bx r3	; 023274E0
	.byte 0xC0, 0x46	; 023274E4
pool_023274E4:
loc_023274E4:
	.word 0x000001FF	; 023274E4
pool_023274E8:
loc_023274E8:
	.word 0x06800000	; 023274E8
pool_023274EC:
loc_023274EC:
	.word 0x000A4000	; 023274EC
pool_023274F0:
loc_023274F0:
	.word 0x07000000	; 023274F0
pool_023274F4:
loc_023274F4:
	.word 0x00000400	; 023274F4
pool_023274F8:
loc_023274F8:
	.word 0x05000000	; 023274F8
pool_023274FC:
loc_023274FC:
	.word 0x07000400	; 023274FC
pool_02327500:
loc_02327500:
	.word 0x05000400	; 02327500
pool_02327504:
loc_02327504:
	.word REG_BG0CNT	; 02327504
pool_02327508:
loc_02327508:
	.word 0x0000012C	; 02327508
pool_0232750C:
loc_0232750C:
	.word REG_DIVCNT	; 0232750C
pool_02327510:
loc_02327510:
	.word REG_DISPCNT_B	; 02327510
pool_02327514:
loc_02327514:
	.word REG_DIV_NUMER	; 02327514
pool_02327518:
loc_02327518:
	.word REG_DIV_DENOM	; 02327518
pool_0232751C:
loc_0232751C:
	.word 0x00004008	; 0232751C
pool_02327520:
loc_02327520:
	.word REG_IPC_FIFO_CR	; 02327520
pool_02327524:
loc_02327524:
	.word REG_DISPCNT_A	; 02327524
pool_02327528:
loc_02327528:
	.word REG_DISPSTAT	; 02327528

; ===== function loc_0232752C =====
loc_0232752C:
	ldr r1,[pool_02327540]	; 0232752C
	ldr r1,[r1,#0x0]	; 0232752E
	and r1,r0	; 02327530
	cmp r1,#0x0	; 02327532
	beq loc_0232753A	; 02327534
	mov r0,#0x1	; 02327536
	bx lr	; 02327538
loc_0232753A:
	mov r0,#0x0	; 0232753A
	bx lr	; 0232753C
	.byte 0xC0, 0x46	; 02327540
pool_02327540:
loc_02327540:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327540

; ===== function loc_02327544 =====
loc_02327544:
	ldr r0,[pool_02327574]	; 02327544
	ldr r2,[r0,#0x0]	; 02327546
	ldr r1,[pool_02327578]	; 02327548
	cmp r2,r1	; 0232754A
	bcc loc_0232756E	; 0232754C
	ldr r0,[pool_0232757C]	; 0232754E
	cmp r2,r0	; 02327550
	bcs loc_0232756E	; 02327552
	ldr r0,[pool_02327580]	; 02327554
	ldr r2,[r0,#0x0]	; 02327556
	cmp r2,r1	; 02327558
	bcc loc_02327562	; 0232755A
	ldr r0,[pool_02327584]	; 0232755C
	cmp r2,r0	; 0232755E
	bcc loc_02327570	; 02327560
loc_02327562:
	ldr r0,[pool_02327588]	; 02327562
	cmp r2,r0	; 02327564
	bcc loc_0232756E	; 02327566
	ldr r0,[pool_0232758C]	; 02327568
	cmp r2,r0	; 0232756A
	bcc loc_02327570	; 0232756C
loc_0232756E:
	b loc_0232756E	; 0232756E
loc_02327570:
	bx lr	; 02327570
	.byte 0xC0, 0x46	; 02327574
pool_02327574:
loc_02327574:
	.word NdsCartHeaderArm9EntryAddress	; 02327574
pool_02327578:
loc_02327578:
	.word 0x02000000	; 02327578
pool_0232757C:
loc_0232757C:
	.word 0x02280000	; 0232757C
pool_02327580:
loc_02327580:
	.word NdsCartHeaderArm7EntryAddress	; 02327580
pool_02327584:
loc_02327584:
	.word 0x023FE000	; 02327584
pool_02327588:
loc_02327588:
	.word Arm7SharedWramStart	; 02327588
pool_0232758C:
loc_0232758C:
	.word Arm7FirmwareReservedWramStart	; 0232758C

; ===== function loc_02327590 =====
loc_02327590:
	push {r4,lr}	; 02327590
	bl loc_02327544	; 02327592
	ldr r0,[pool_0232760C]	; 02327596
	ldr r1,[pool_02327610]	; 02327598
	ldr r2,[pool_02327614]	; 0232759A
	sub r2,r2,r0	; 0232759C
	blx loc_0232DE58	; 0232759E
	ldr r0,[pool_0232760C]	; 023275A2
	ldr r1,[pool_02327618]	; 023275A4
	blx P1_CleanDataCacheRange	; 023275A6
	mov r4,#0x0	; 023275AA
loc_023275AC:
	add r0,r4,#0x0	; 023275AC
	bl loc_0232DCE8	; 023275AE
	add r4,r4,#0x1	; 023275B2
	cmp r4,#0x3	; 023275B4
	ble loc_023275AC	; 023275B6
	bl loc_02327CA4	; 023275B8
	bl loc_02327430	; 023275BC
	mov r0,#0x0	; 023275C0
	bl loc_0232D484	; 023275C2
	ldr r0,[pool_0232761C]	; 023275C6
	ldr r1,[pool_02327620]	; 023275C8
	bl loc_0232B184	; 023275CA
	ldr r0,[pool_0232761C]	; 023275CE
	bl loc_0232B128	; 023275D0
	ldr r1,[pool_02327624]	; 023275D4
	ldr r0,[pool_02327628]	; 023275D6
	strh r1,[r0,#0x0]	; 023275D8
	mov r1,#0x7	; 023275DA
	ldr r0,[pool_0232762C]	; 023275DC
	str r1,[r0,#0x0]	; 023275DE
	mov r0,#0x1	; 023275E0
	ldr r1,[pool_0232761C]	; 023275E2
	blx loc_0232AF6C	; 023275E4
	ldr r2,[pool_02327628]	; 023275E8
	ldrh r1,[r2,#0x0]	; 023275EA
	ldr r0,[pool_02327630]	; 023275EC
	and r1,r0	; 023275EE
	strh r1,[r2,#0x0]	; 023275F0
	ldr r1,[pool_02327634]	; 023275F2
	ldrh r0,[r1,#0x0]	; 023275F4
	mov r0,#0x0	; 023275F6
	strh r0,[r1,#0x0]	; 023275F8
	bl loc_0232B128	; 023275FA
	mov r0,#0x0	; 023275FE
	mvn r0,r0	; 02327600
	bl loc_0232B0B0	; 02327602
	pop {r4}	; 02327606
	pop {r3}	; 02327608
	bx r3	; 0232760A
pool_0232760C:
loc_0232760C:
	.word 0x02327D80	; 0232760C
pool_02327610:
loc_02327610:
	.word 0x023FEE00	; 02327610
pool_02327614:
loc_02327614:
	.word 0x02327EE8	; 02327614
pool_02327618:
loc_02327618:
	.word 0x00000200	; 02327618
pool_0232761C:
loc_0232761C:
	.word 0x00010000	; 0232761C
pool_02327620:
loc_02327620:
	.word P1_IrqHandler_02327638 + 1	; 02327620
pool_02327624:
loc_02327624:
	.word 0x00004F00	; 02327624
pool_02327628:
loc_02327628:
	.word REG_IPC_SYNC	; 02327628
pool_0232762C:
loc_0232762C:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 0232762C
pool_02327630:
loc_02327630:
	.word 0x00000F00	; 02327630
pool_02327634:
loc_02327634:
	.word REG_IME	; 02327634
P1_IrqHandler_02327638:
	ldr r1,[pool_02327648]	; 02327638
	ldr r0,[pool_0232764C]	; 0232763A
	add r1,r1,r0	; 0232763C
	ldr r2,[r1,#0x0]	; 0232763E
	ldr r0,[pool_02327650]	; 02327640
	orr r2,r0	; 02327642
	str r2,[r1,#0x0]	; 02327644
	bx lr	; 02327646
pool_02327648:
loc_02327648:
	.word P1_DtcmRuntimeStart	; 02327648
pool_0232764C:
loc_0232764C:
	.word 0x00003FF8	; 0232764C
pool_02327650:
loc_02327650:
	.word 0x00010000	; 02327650

; ===== function loc_02327654 =====
loc_02327654:
; 将参数中的事件位并入双核共享位图。
; OR the requested event bits into the shared bitmap.
.func P1_OrSharedEventFlags
	push {r4,lr}	; 02327654
	add r4,r0,#0x0	; 02327656
	mov r0,#0x6e	; 02327658
	ldr r1,[pool_02327678]	; 0232765A
	mov r2,#0x0	; 0232765C
	bl loc_0232B450	; 0232765E
	ldr r1,[pool_02327678]	; 02327662
	ldr r0,[r1,#0x8]	; 02327664
	orr r0,r4	; 02327666
	str r0,[r1,#0x8]	; 02327668
	mov r0,#0x6e	; 0232766A
	mov r2,#0x0	; 0232766C
	bl loc_0232B3D8	; 0232766E
	pop {r4}	; 02327672
	pop {r3}	; 02327674
	bx r3	; 02327676
.endfunc
pool_02327678:
loc_02327678:
	.word FirmwareBootSharedAddress + BootSharedEventSyncOffset	; 02327678

; ===== function loc_0232767C =====
loc_0232767C:
	ldr r0,[pool_02327684]	; 0232767C
	ldr r3,[pool_02327688]	; 0232767E
	bx r3	; 02327680
	.byte 0xC0, 0x46	; 02327684
pool_02327684:
loc_02327684:
	.word 0x80000040	; 02327684
pool_02327688:
loc_02327688:
	.word P1_OrSharedEventFlags + 1	; 02327688

; ===== function loc_0232768C =====
loc_0232768C:
	ldr r0,[pool_02327694]	; 0232768C
	ldr r3,[pool_02327698]	; 0232768E
	bx r3	; 02327690
	.byte 0xC0, 0x46	; 02327694
pool_02327694:
loc_02327694:
	.word 0x80000100	; 02327694
pool_02327698:
loc_02327698:
	.word P1_OrSharedEventFlags + 1	; 02327698

; ===== function loc_0232769C =====
loc_0232769C:
	ldr r0,[pool_023276A4]	; 0232769C
	ldr r3,[pool_023276A8]	; 0232769E
	bx r3	; 023276A0
	.byte 0xC0, 0x46	; 023276A4
pool_023276A4:
loc_023276A4:
	.word 0x80000080	; 023276A4
pool_023276A8:
loc_023276A8:
	.word P1_OrSharedEventFlags + 1	; 023276A8

; ===== function loc_023276AC =====
loc_023276AC:
	ldr r0,[pool_023276B4]	; 023276AC
	ldr r3,[pool_023276B8]	; 023276AE
	bx r3	; 023276B0
	.byte 0xC0, 0x46	; 023276B4
pool_023276B4:
loc_023276B4:
	.word 0x80000010	; 023276B4
pool_023276B8:
loc_023276B8:
	.word P1_OrSharedEventFlags + 1	; 023276B8

; ===== function loc_023276BC =====
loc_023276BC:
	push {lr}	; 023276BC
	sub sp,#0x4	; 023276BE
	ldr r0,[pool_023276F0]	; 023276C0
	bl loc_02326F60	; 023276C2
	cmp r0,#0x0	; 023276C6
	beq loc_023276D4	; 023276C8
	ldr r1,[pool_023276F4]	; 023276CA
	mov r0,#0x0	; 023276CC
	ldrsh r0,[r1,r0]	; 023276CE
	cmp r0,#0x1	; 023276D0
	bne loc_023276E2	; 023276D2
loc_023276D4:
	mov r0,#0x4	; 023276D4
	bl P1_OrSharedEventFlags	; 023276D6
	mov r0,#0x0	; 023276DA
	add sp,#0x4	; 023276DC
	pop {r3}	; 023276DE
	bx r3	; 023276E0
loc_023276E2:
	ldr r0,[pool_023276F8]	; 023276E2
	bl P1_OrSharedEventFlags	; 023276E4
	mov r0,#0x1	; 023276E8
	add sp,#0x4	; 023276EA
	pop {r3}	; 023276EC
	bx r3	; 023276EE
pool_023276F0:
loc_023276F0:
	.word 0x027FFEC0	; 023276F0
pool_023276F4:
loc_023276F4:
	.word FirmwareBootInfoScratchAddress + BootInfoCardSecureDisableOffset	; 023276F4
pool_023276F8:
loc_023276F8:
	.word 0x80000020	; 023276F8

; ===== function loc_023276FC =====
loc_023276FC:
	push {lr}	; 023276FC
	sub sp,#0x4	; 023276FE
	ldr r0,[pool_02327724]	; 02327700
	ldr r2,[r0,#0x0]	; 02327702
	mov r0,#0x8	; 02327704
	add r1,r2,#0x0	; 02327706
	and r1,r0	; 02327708
	cmp r1,#0x0	; 0232770A
	bne loc_0232771C	; 0232770C
	ldr r0,[pool_02327728]	; 0232770E
	and r2,r0	; 02327710
	cmp r2,#0x0	; 02327712
	beq loc_0232771C	; 02327714
	ldr r0,[pool_0232772C]	; 02327716
	bl P1_OrSharedEventFlags	; 02327718
loc_0232771C:
	add sp,#0x4	; 0232771C
	pop {r3}	; 0232771E
	bx r3	; 02327720
	.byte 0xC0, 0x46	; 02327724
pool_02327724:
loc_02327724:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327724
pool_02327728:
loc_02327728:
	.word 0x00000400	; 02327728
pool_0232772C:
loc_0232772C:
	.word 0x08000000	; 0232772C

; ===== function loc_02327730 =====
loc_02327730:
	push {r4,lr}	; 02327730
	sub sp,#0x10	; 02327732
	ldr r0,[pool_02327920]	; 02327734
	ldr r1,[r0,#0x20]	; 02327736
	cmp r1,#0x8	; 02327738
	bls loc_0232773E	; 0232773A
	b loc_02327916	; 0232773C
loc_0232773E:
	add r1,r1,r1	; 0232773E
P1_SwitchIndexPC_0232773E:
	add r1,pc	; 02327740
	ldrh r1,[r1,#(P1_SwitchTable_0232773E - (P1_SwitchIndexPC_0232773E + 4))]	; 02327742
	lsl r1,r1,#0x10	; 02327744
	asr r1,r1,#0x10	; 02327746
P1_SwitchTargetPC_0232773E:
	add r1,pc	; 02327748
	bx r1	; 0232774A
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232773E:
	.halfword (loc_02327916 + 1) - (P1_SwitchTargetPC_0232773E + 4)
	.halfword (loc_02327916 + 1) - (P1_SwitchTargetPC_0232773E + 4)
	.halfword (loc_0232775E + 1) - (P1_SwitchTargetPC_0232773E + 4)
	.halfword (loc_023277B2 + 1) - (P1_SwitchTargetPC_0232773E + 4)
	.halfword (loc_02327802 + 1) - (P1_SwitchTargetPC_0232773E + 4)
	.halfword (loc_0232781C + 1) - (P1_SwitchTargetPC_0232773E + 4)
	.halfword (loc_0232782E + 1) - (P1_SwitchTargetPC_0232773E + 4)
	.halfword (loc_02327916 + 1) - (P1_SwitchTargetPC_0232773E + 4)
	.halfword (loc_02327880 + 1) - (P1_SwitchTargetPC_0232773E + 4)
P1_SwitchTable_0232773EEnd:
loc_0232775E:
	bl loc_02326FF8	; 0232775E
	bl loc_02326FDC	; 02327762
	mov r4,#0x0	; 02327766
	bl loc_02326F9C	; 02327768
	cmp r0,#0x0	; 0232776C
	beq loc_02327782	; 0232776E
	mov r0,#0x2	; 02327770
	orr r4,r0	; 02327772
	ldr r0,[pool_02327924]	; 02327774
	bl loc_02326F60	; 02327776
	cmp r0,#0x0	; 0232777A
	bne loc_02327782	; 0232777C
	mov r0,#0x4	; 0232777E
	orr r4,r0	; 02327780
loc_02327782:
	bl loc_02328634	; 02327782
	cmp r0,#0x0	; 02327786
	beq loc_02327798	; 02327788
	mov r0,#0x1	; 0232778A
	orr r4,r0	; 0232778C
	ldr r2,[pool_02327928]	; 0232778E
	ldrb r1,[r2,#0x0]	; 02327790
	bic r1,r0	; 02327792
	orr r1,r0	; 02327794
	strb r1,[r2,#0x0]	; 02327796
loc_02327798:
	bl loc_02326E8C	; 02327798
	bl P1_Runtime_01FF8084	; 0232779C
	ldr r0,[pool_0232792C]	; 023277A0
	orr r4,r0	; 023277A2
	add r0,r4,#0x0	; 023277A4
	bl P1_OrSharedEventFlags	; 023277A6
	mov r1,#0x3	; 023277AA
	ldr r0,[pool_02327920]	; 023277AC
	str r1,[r0,#0x20]	; 023277AE
	b loc_02327916	; 023277B0
loc_023277B2:
	ldr r3,[pool_02327930]	; 023277B2
	ldr r2,[r3,#0x0]	; 023277B4
	ldr r1,[pool_02327934]	; 023277B6
	and r2,r1	; 023277B8
	cmp r2,#0x0	; 023277BA
	bne loc_023277C0	; 023277BC
	b loc_02327916	; 023277BE
loc_023277C0:
	ldr r2,[r3,#0x0]	; 023277C0
	mov r1,#0x20	; 023277C2
	and r2,r1	; 023277C4
	cmp r2,#0x0	; 023277C6
	beq loc_023277D8	; 023277C8
	mov r0,#0x3	; 023277CA
	bl loc_02326FCC	; 023277CC
	mov r1,#0x4	; 023277D0
	ldr r0,[pool_02327920]	; 023277D2
	str r1,[r0,#0x20]	; 023277D4
	b loc_02327916	; 023277D6
loc_023277D8:
	ldr r2,[r3,#0x0]	; 023277D8
	mov r1,#0x10	; 023277DA
	and r2,r1	; 023277DC
	cmp r2,#0x0	; 023277DE
	beq loc_023277E8	; 023277E0
	mov r1,#0x5	; 023277E2
	str r1,[r0,#0x20]	; 023277E4
	b loc_02327916	; 023277E6
loc_023277E8:
	ldr r1,[r3,#0x0]	; 023277E8
	ldr r0,[pool_02327938]	; 023277EA
	and r1,r0	; 023277EC
	cmp r1,#0x0	; 023277EE
	bne loc_023277F4	; 023277F0
	b loc_02327916	; 023277F2
loc_023277F4:
	mov r0,#0x6	; 023277F4
	bl loc_02326FCC	; 023277F6
	mov r1,#0x6	; 023277FA
	ldr r0,[pool_02327920]	; 023277FC
	str r1,[r0,#0x20]	; 023277FE
	b loc_02327916	; 02327800
loc_02327802:
	ldr r0,[pool_0232793C]	; 02327802
	bl loc_0232752C	; 02327804
	cmp r0,#0x0	; 02327808
	bne loc_0232780E	; 0232780A
	b loc_02327916	; 0232780C
loc_0232780E:
	bl loc_02327590	; 0232780E
	mov r0,#0x1	; 02327812
	add sp,#0x10	; 02327814
	pop {r4}	; 02327816
	pop {r3}	; 02327818
	bx r3	; 0232781A
loc_0232781C:
	ldr r0,[r0,#0x24]	; 0232781C
	cmp r0,#0x2	; 0232781E
	bne loc_02327916	; 02327820
	mov r0,#0x4	; 02327822
	bl loc_02326FCC	; 02327824
	bl loc_0232734C	; 02327828
	b loc_02327916	; 0232782C
loc_0232782E:
	ldr r0,[pool_02327930]	; 0232782E
	ldr r1,[r0,#0x0]	; 02327830
	ldr r0,[pool_02327940]	; 02327832
	and r1,r0	; 02327834
	cmp r1,#0x0	; 02327836
	beq loc_02327916	; 02327838
	bl P1_DecompressAndCheckP3P4	; 0232783A
	ldr r0,[pool_02327944]	; 0232783E
	bl P1_OrSharedEventFlags	; 02327840
	mov r0,#0x0	; 02327844
	str r0,[sp,#0x4]	; 02327846
	ldr r0,[sp,#0x4]	; 02327848
	ldr r1,[pool_02327948]	; 0232784A
	ldr r2,[pool_0232794C]	; 0232784C
	blx loc_0232DE0C	; 0232784E
; 按此版本的零区起点和字节数清零，SWI 参数换算为 32 位字数。
; Clear this version's zero area; convert its byte size to the SWI word count.
	ldr r2,[pool_02327950]	; 02327852
	cmp r2,#0x0	; 02327854
	beq loc_0232786E	; 02327856
	mov r0,#0x0	; 02327858
	str r0,[sp,#0x0]	; 0232785A
	add r0,sp,#0x0	; 0232785C
	ldr r1,[pool_02327954]	; 0232785E
	lsr r2,r2,#0x2	; 02327860
	ldr r3,[pool_02327958]	; 02327862
	and r2,r3	; 02327864
	ldr r3,[pool_0232795C]	; 02327866
	orr r2,r3	; 02327868
	bl loc_0232C76E	; 0232786A
loc_0232786E:
	blx P1_CleanEntireDataCacheByIndex	; 0232786E
	mov r0,#0x7	; 02327872
	bl loc_02326FCC	; 02327874
	mov r1,#0x8	; 02327878
	ldr r0,[pool_02327920]	; 0232787A
	str r1,[r0,#0x20]	; 0232787C
	b loc_02327916	; 0232787E
loc_02327880:
	ldr r0,[pool_02327930]	; 02327880
	ldr r2,[r0,#0x0]	; 02327882
	ldr r1,[pool_02327960]	; 02327884
	and r2,r1	; 02327886
	cmp r2,#0x0	; 02327888
	beq loc_02327916	; 0232788A
	ldr r2,[r0,#0x0]	; 0232788C
	ldr r1,[pool_02327964]	; 0232788E
	and r2,r1	; 02327890
	cmp r2,#0x0	; 02327892
	beq loc_02327916	; 02327894
	ldr r2,[r0,#0x0]	; 02327896
	mov r1,#0x80	; 02327898
	and r2,r1	; 0232789A
	cmp r2,#0x0	; 0232789C
	beq loc_023278AA	; 0232789E
	ldr r0,[pool_02327968]	; 023278A0
	ldr r0,[r0,#0x0]	; 023278A2
	ldr r0,[r0,#0x0]	; 023278A4
	blx r0	; 023278A6
	b loc_0232790C	; 023278A8
loc_023278AA:
	ldr r2,[r0,#0x0]	; 023278AA
	ldr r1,[pool_0232796C]	; 023278AC
	and r2,r1	; 023278AE
	cmp r2,#0x0	; 023278B0
	beq loc_023278FA	; 023278B2
	ldr r1,[r0,#0x0]	; 023278B4
	mov r0,#0x2	; 023278B6
	and r1,r0	; 023278B8
	cmp r1,#0x0	; 023278BA
	beq loc_023278C2	; 023278BC
	mov r0,#0x1	; 023278BE
	b loc_023278C4	; 023278C0
loc_023278C2:
	mov r0,#0x0	; 023278C2
loc_023278C4:
	cmp r0,#0x0	; 023278C4
	beq loc_023278E8	; 023278C6
	ldr r0,[pool_02327920]	; 023278C8
	ldr r1,[r0,#0x0]	; 023278CA
	ldr r0,[pool_02327970]	; 023278CC
	str r1,[r0,#0x0]	; 023278CE
	ldr r0,[pool_02327974]	; 023278D0
	ldr r1,[pool_02327978]	; 023278D2
	ldr r2,[pool_0232797C]	; 023278D4
	blx loc_0232DE58	; 023278D6
	mov r0,#0x0	; 023278DA
	str r0,[sp,#0x8]	; 023278DC
	ldr r0,[sp,#0x8]	; 023278DE
	ldr r1,[pool_02327974]	; 023278E0
	ldr r2,[pool_0232797C]	; 023278E2
	blx loc_0232DE0C	; 023278E4
loc_023278E8:
	ldr r0,[pool_02327968]	; 023278E8
	ldr r0,[r0,#0x0]	; 023278EA
	ldr r0,[r0,#0x4]	; 023278EC
	blx r0	; 023278EE
	blx P1_CleanEntireDataCacheByIndex	; 023278F0
	bl loc_02327590	; 023278F4
	b loc_0232790C	; 023278F8
loc_023278FA:
	ldr r1,[r0,#0x0]	; 023278FA
	mov r0,#0x40	; 023278FC
	and r1,r0	; 023278FE
	cmp r1,#0x0	; 02327900
	beq loc_0232790C	; 02327902
	ldr r0,[pool_02327968]	; 02327904
	ldr r0,[r0,#0x0]	; 02327906
	ldr r0,[r0,#0x8]	; 02327908
	blx r0	; 0232790A
loc_0232790C:
	mov r0,#0x1	; 0232790C
	add sp,#0x10	; 0232790E
	pop {r4}	; 02327910
	pop {r3}	; 02327912
	bx r3	; 02327914
loc_02327916:
	mov r0,#0x0	; 02327916
	add sp,#0x10	; 02327918
	pop {r4}	; 0232791A
	pop {r3}	; 0232791C
	bx r3	; 0232791E
pool_02327920:
loc_02327920:
	.word FirmwareBootSharedAddress	; 02327920
pool_02327924:
loc_02327924:
	.word 0x027FFEC0	; 02327924
pool_02327928:
loc_02327928:
	.word FirmwareBootInfoAddress + BootInfoGbaFlagsOffset	; 02327928
pool_0232792C:
loc_0232792C:
	.word 0x20000000	; 0232792C
pool_02327930:
loc_02327930:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327930
pool_02327934:
loc_02327934:
	.word 0x80000000	; 02327934
pool_02327938:
loc_02327938:
	.word 0x000001C0	; 02327938
pool_0232793C:
loc_0232793C:
	.word 0x00000200	; 0232793C
pool_02327940:
loc_02327940:
	.word 0x00001000	; 02327940
pool_02327944:
loc_02327944:
	.word 0x00000400	; 02327944
pool_02327948:
loc_02327948:
	.word 0x02000000	; 02327948
pool_0232794C:
loc_0232794C:
	.word 0x00300000	; 0232794C
pool_02327950:
loc_02327950:
	.word UiBootZeroBytes	; 02327950
pool_02327954:
loc_02327954:
	.word UiBootZeroStart	; 02327954
pool_02327958:
loc_02327958:
	.word 0x001FFFFF	; 02327958
pool_0232795C:
loc_0232795C:
	.word 0x01000000	; 0232795C
pool_02327960:
loc_02327960:
	.word 0x40000000	; 02327960
pool_02327964:
loc_02327964:
	.word 0x08000000	; 02327964
pool_02327968:
loc_02327968:
	.word P1_BssStart + 0x24E28	; 02327968
pool_0232796C:
loc_0232796C:
	.word 0x00000100	; 0232796C
pool_02327970:
loc_02327970:
	.word NdsCartHeaderArm7RamAddress	; 02327970
pool_02327974:
loc_02327974:
	.word 0x027FFE00	; 02327974
pool_02327978:
loc_02327978:
	.word 0x023FE940	; 02327978
pool_0232797C:
loc_0232797C:
	.word 0x00000160	; 0232797C

; ===== function loc_02327980 =====
loc_02327980:
	push {r4,r5,r6,r7,lr}	; 02327980
	sub sp,#0x4	; 02327982
	ldr r4,[pool_023279D8]	; 02327984
	ldr r6,[pool_023279DC]	; 02327986
	ldr r7,[pool_023279E0]	; 02327988
loc_0232798A:
	ldr r5,[r6,#0x0]	; 0232798A
	ldr r0,[pool_023279E4]	; 0232798C
	bl loc_0232C74C	; 0232798E
	add r0,r5,#0x0	; 02327992
	and r0,r4	; 02327994
	cmp r0,#0x0	; 02327996
	bne loc_023279AC	; 02327998
	and r5,r7	; 0232799A
	cmp r5,#0x0	; 0232799C
	beq loc_0232798A	; 0232799E
	bl P1_DecompressAndCheckP5	; 023279A0
	add r0,r4,#0x0	; 023279A4
	bl P1_OrSharedEventFlags	; 023279A6
	b loc_0232798A	; 023279AA
loc_023279AC:
	bl loc_0232720C	; 023279AC
	mov r1,#0x2	; 023279B0
	ldr r0,[pool_023279E8]	; 023279B2
	str r1,[r0,#0x0]	; 023279B4
	ldr r2,[pool_023279EC]	; 023279B6
	ldrh r1,[r2,#0x0]	; 023279B8
	mov r0,#0x1	; 023279BA
	orr r1,r0	; 023279BC
	strh r1,[r2,#0x0]	; 023279BE
	bl loc_02327D60	; 023279C0
	bl P1_ClassifyTrailerForRuntimePatch	; 023279C4
	bl loc_023270F4	; 023279C8
	mov r0,#0x0	; 023279CC
	add sp,#0x4	; 023279CE
	pop {r4,r5,r6,r7}	; 023279D0
	pop {r3}	; 023279D2
	bx r3	; 023279D4
	.byte 0xC0, 0x46	; 023279D8
pool_023279D8:
loc_023279D8:
	.word 0x00000800	; 023279D8
pool_023279DC:
loc_023279DC:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 023279DC
pool_023279E0:
loc_023279E0:
	.word 0x00002000	; 023279E0
pool_023279E4:
loc_023279E4:
	.word 0x00001000	; 023279E4
pool_023279E8:
loc_023279E8:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 023279E8
pool_023279EC:
loc_023279EC:
	.word REG_POSTFLG	; 023279EC

; ===== function P1_ClipMemoryRangeToBounds =====
; Rejects a (start,length) range outside the supplied bounds; trims a range that crosses the upper bound.
; 将越出给定边界的（起始地址、长度）范围置零；超过上界时截短长度。
.func P1_ClipMemoryRangeToBounds
loc_023279F0:
	push {r4,r5}	; 023279F0
	ldr r5,[r0,#0x0]	; 023279F2
	ldr r3,[r0,#0x4]	; 023279F4
	add r4,r5,r3	; 023279F6
	cmp r5,r1	; 023279F8
	bcc loc_02327A00	; 023279FA
	cmp r5,r2	; 023279FC
	bls loc_02327A08	; 023279FE
loc_02327A00:
	mov r1,#0x0	; 02327A00
	str r1,[r0,#0x4]	; 02327A02
	pop {r4,r5}	; 02327A04
	bx lr	; 02327A06
loc_02327A08:
	cmp r4,r2	; 02327A08
	bls loc_02327A12	; 02327A0A
	sub r1,r4,r2	; 02327A0C
	sub r1,r3,r1	; 02327A0E
	str r1,[r0,#0x4]	; 02327A10
loc_02327A12:
	pop {r4,r5}	; 02327A12
	bx lr	; 02327A14
.endfunc
	.byte 0x00, 0x00	; 02327A18

; ===== function P1_ConstrainNdsHeaderImageLoadRanges =====
; Constrains ARM7/ARM9 image load ranges recorded in the copied NDS card header before boot.
; 启动前约束复制到 RAM 的 NDS 卡带头内 ARM7/ARM9 映像装载范围。
.func P1_ConstrainNdsHeaderImageLoadRanges
loc_02327A18:
	push {lr}	; 02327A18
	sub sp,#0x4	; 02327A1A
	bl loc_02326F9C	; 02327A1C
	cmp r0,#0x0	; 02327A20
	beq loc_02327A84	; 02327A22
	ldr r0,[pool_02327A8C]	; 02327A24
	ldr r2,[r0,#0x0]	; 02327A26
	ldr r1,[pool_02327A90]	; 02327A28
	cmp r2,r1	; 02327A2A
	bcc loc_02327A42	; 02327A2C
	ldr r2,[pool_02327A94]	; 02327A2E
	bl P1_ClipMemoryRangeToBounds	; 02327A30
	ldr r2,[pool_02327A8C]	; 02327A34
	ldr r1,[r2,#0x0]	; 02327A36
	ldr r0,[pool_02327A98]	; 02327A38
	str r1,[r0,#0x0]	; 02327A3A
	ldr r0,[pool_02327A9C]	; 02327A3C
	str r0,[r2,#0x0]	; 02327A3E
	b loc_02327A7A	; 02327A40
loc_02327A42:
	ldr r1,[pool_02327AA0]	; 02327A42
	ldr r2,[pool_02327AA4]	; 02327A44
	bl P1_ClipMemoryRangeToBounds	; 02327A46
	ldr r1,[pool_02327A8C]	; 02327A4A
	ldr r3,[r1,#0x0]	; 02327A4C
	ldr r0,[pool_02327AA8]	; 02327A4E
	cmp r3,r0	; 02327A50
	bcc loc_02327A6A	; 02327A52
	ldr r0,[pool_02327A98]	; 02327A54
	str r3,[r0,#0x0]	; 02327A56
	ldr r0,[pool_02327A9C]	; 02327A58
	str r0,[r1,#0x0]	; 02327A5A
	ldr r2,[pool_02327AAC]	; 02327A5C
	ldr r1,[r2,#0x0]	; 02327A5E
	ldr r0,[pool_02327AB0]	; 02327A60
	cmp r1,r0	; 02327A62
	bls loc_02327A7A	; 02327A64
	str r0,[r2,#0x0]	; 02327A66
	b loc_02327A7A	; 02327A68
loc_02327A6A:
	ldr r2,[pool_02327AAC]	; 02327A6A
	ldr r1,[r2,#0x0]	; 02327A6C
	add r3,r3,r1	; 02327A6E
	cmp r3,r0	; 02327A70
	bls loc_02327A7A	; 02327A72
	sub r0,r3,r0	; 02327A74
	sub r0,r1,r0	; 02327A76
	str r0,[r2,#0x0]	; 02327A78
loc_02327A7A:
	ldr r0,[pool_02327AB4]	; 02327A7A
	ldr r1,[pool_02327AA0]	; 02327A7C
	ldr r2,[pool_02327A9C]	; 02327A7E
	bl P1_ClipMemoryRangeToBounds	; 02327A80
loc_02327A84:
	add sp,#0x4	; 02327A84
	pop {r3}	; 02327A86
	bx r3	; 02327A88
.endfunc
	.byte 0xC0, 0x46	; 02327A8C
pool_02327A8C:
loc_02327A8C:
	.word NdsCartHeaderArm7RamAddress	; 02327A8C
pool_02327A90:
loc_02327A90:
	.word Arm7SharedWramStart	; 02327A90
pool_02327A94:
loc_02327A94:
	.word Arm7FirmwareReservedWramStart	; 02327A94
pool_02327A98:
loc_02327A98:
	.word FirmwareBootSharedAddress	; 02327A98
pool_02327A9C:
loc_02327A9C:
	.word 0x022C0000	; 02327A9C
pool_02327AA0:
loc_02327AA0:
	.word 0x02000000	; 02327AA0
pool_02327AA4:
loc_02327AA4:
	.word 0x023FE000	; 02327AA4
pool_02327AA8:
loc_02327AA8:
	.word 0x02300000	; 02327AA8
pool_02327AAC:
loc_02327AAC:
	.word NdsCartHeaderArm7SizeAddress	; 02327AAC
pool_02327AB0:
loc_02327AB0:
	.word 0x00040000	; 02327AB0
pool_02327AB4:
loc_02327AB4:
	.word NdsCartHeaderArm9RamAddress	; 02327AB4

; ===== function loc_02327AB8 =====
loc_02327AB8:
	push {r4,lr}	; 02327AB8
	sub sp,#0x8	; 02327ABA
	add r4,r0,#0x0	; 02327ABC
	ldr r2,[pool_02327B30]	; 02327ABE
	ldrh r1,[r2,#0x0]	; 02327AC0
	ldr r0,[pool_02327B34]	; 02327AC2
	orr r1,r0	; 02327AC4
	strh r1,[r2,#0x0]	; 02327AC6
	ldrh r1,[r2,#0x0]	; 02327AC8
	mov r0,#0xc	; 02327ACA
	bic r1,r0	; 02327ACC
	strh r1,[r2,#0x0]	; 02327ACE
	ldrh r1,[r2,#0x0]	; 02327AD0
	mov r0,#0x10	; 02327AD2
	bic r1,r0	; 02327AD4
	strh r1,[r2,#0x0]	; 02327AD6
	mov r0,#0x3	; 02327AD8
	bl loc_0232DCDC	; 02327ADA
	ldr r0,[pool_02327B38]	; 02327ADE
	ldr r1,[pool_02327B3C]	; 02327AE0
	blx P1_InvalidateDataCacheRange	; 02327AE2
	mov r0,#0x0	; 02327AE6
	str r0,[sp,#0x0]	; 02327AE8
	add r0,sp,#0x0	; 02327AEA
	ldr r1,[pool_02327B40]	; 02327AEC
	ldr r2,[pool_02327B44]	; 02327AEE
	bl loc_0232C76E	; 02327AF0
	ldr r0,[pool_02327B48]	; 02327AF4
	str r4,[r0,#0x0]	; 02327AF6
	mov r1,#0x1	; 02327AF8
	ldr r0,[pool_02327B4C]	; 02327AFA
	str r1,[r0,#0x0]	; 02327AFC
	bl P1_ConstrainNdsHeaderImageLoadRanges	; 02327AFE
	bl loc_02326E50	; 02327B02
	ldr r0,[pool_02327B50]	; 02327B06
	add r0,#0x19	; 02327B08
	mov r1,#0x0	; 02327B0A
	mov r2,#0x37	; 02327B0C
	blx loc_0232DE90	; 02327B0E
	ldr r1,[pool_02327B54]	; 02327B12
	mov r0,#0x0	; 02327B14
	ldrsh r0,[r1,r0]	; 02327B16
	cmp r0,#0x0	; 02327B18
	bne loc_02327B26	; 02327B1A
	ldr r2,[pool_02327B58]	; 02327B1C
	ldr r1,[r2,#0x0]	; 02327B1E
	ldr r0,[pool_02327B5C]	; 02327B20
	orr r1,r0	; 02327B22
	str r1,[r2,#0x0]	; 02327B24
loc_02327B26:
	add sp,#0x8	; 02327B26
	pop {r4}	; 02327B28
	pop {r3}	; 02327B2A
	bx r3	; 02327B2C
	.byte 0xC0, 0x46	; 02327B30
pool_02327B30:
loc_02327B30:
	.word REG_EXMEMCNT_ARM9	; 02327B30
pool_02327B34:
loc_02327B34:
	.word 0x00008000	; 02327B34
pool_02327B38:
loc_02327B38:
	.word 0x022C0000	; 02327B38
pool_02327B3C:
loc_02327B3C:
	.word 0x00040000	; 02327B3C
pool_02327B40:
loc_02327B40:
	.word 0x027FF860	; 02327B40
pool_02327B44:
loc_02327B44:
	.word 0x0100001B	; 02327B44
pool_02327B48:
loc_02327B48:
	.word P1_BssStart + 0x24E28	; 02327B48
pool_02327B4C:
loc_02327B4C:
	.word FirmwareBootSharedAddress + BootSharedArm9StateOffset	; 02327B4C
pool_02327B50:
loc_02327B50:
	.word 0x027FF800	; 02327B50
pool_02327B54:
loc_02327B54:
	.word FirmwareBootInfoScratchAddress + BootInfoHasSerialDebuggerOffset	; 02327B54
pool_02327B58:
loc_02327B58:
	.word NdsCartHeaderRamAddress + 0x60	; 02327B58
pool_02327B5C:
loc_02327B5C:
	.word 0x00406000	; 02327B5C

; ===== function loc_02327B60 =====
loc_02327B60:
	push {r4,r5}	; 02327B60
	mov r2,#0x80	; 02327B62
	ldr r1,[pool_02327B90]	; 02327B64
	strb r2,[r1,#0x0]	; 02327B66
	mov r2,#0x0	; 02327B68
	ldr r1,[pool_02327B94]	; 02327B6A
	mov r3,#0x1	; 02327B6C
loc_02327B6E:
	sub r4,r3,r2	; 02327B6E
	lsl r4,r4,#0x2	; 02327B70
	ldr r5,[r0,r4]	; 02327B72
	lsr r4,r5,#0x18	; 02327B74
	strb r4,[r1,#0x0]	; 02327B76
	lsr r4,r5,#0x10	; 02327B78
	strb r4,[r1,#0x1]	; 02327B7A
	lsr r4,r5,#0x8	; 02327B7C
	strb r4,[r1,#0x2]	; 02327B7E
	strb r5,[r1,#0x3]	; 02327B80
	add r1,r1,#0x4	; 02327B82
	add r2,r2,#0x1	; 02327B84
	cmp r2,#0x2	; 02327B86
	blt loc_02327B6E	; 02327B88
	pop {r4,r5}	; 02327B8A
	bx lr	; 02327B8C
	.byte 0xC0, 0x46	; 02327B90
pool_02327B90:
loc_02327B90:
	.word REG_AUXSPICNT + 1	; 02327B90
pool_02327B94:
loc_02327B94:
	.word REG_GCCMDOUT	; 02327B94

; ===== function loc_02327B98 =====
loc_02327B98:
	push {r4,r5,r6,r7,lr}	; 02327B98
	sub sp,#0xc	; 02327B9A
	add r5,r1,#0x0	; 02327B9C
	add r4,r2,#0x0	; 02327B9E
	lsl r1,r0,#0x18	; 02327BA0
	str r1,[sp,#0x0]	; 02327BA2
	lsr r1,r0,#0x8	; 02327BA4
	ldr r0,[pool_02327BE8]	; 02327BA6
	orr r1,r0	; 02327BA8
	str r1,[sp,#0x4]	; 02327BAA
	add r0,sp,#0x0	; 02327BAC
	bl loc_02327B60	; 02327BAE
	ldr r0,[pool_02327BEC]	; 02327BB2
	ldr r1,[r0,#0x0]	; 02327BB4
	ldr r0,[pool_02327BF0]	; 02327BB6
	orr r1,r0	; 02327BB8
	ldr r0,[pool_02327BF4]	; 02327BBA
	str r1,[r0,#0x0]	; 02327BBC
	add r2,r5,r4	; 02327BBE
	ldr r7,[pool_02327BF8]	; 02327BC0
	ldr r3,[pool_02327BFC]	; 02327BC2
	ldr r4,[pool_02327C00]	; 02327BC4
loc_02327BC6:
	ldr r1,[r0,#0x0]	; 02327BC6
	add r6,r1,#0x0	; 02327BC8
	and r6,r4	; 02327BCA
	cmp r6,#0x0	; 02327BCC
	beq loc_02327BDA	; 02327BCE
	ldr r6,[r7,#0x0]	; 02327BD0
	cmp r5,r2	; 02327BD2
	bcs loc_02327BD8	; 02327BD4
	str r6,[r5,#0x0]	; 02327BD6
loc_02327BD8:
	add r5,r5,#0x4	; 02327BD8
loc_02327BDA:
	and r1,r3	; 02327BDA
	cmp r1,#0x0	; 02327BDC
	bne loc_02327BC6	; 02327BDE
	add sp,#0xc	; 02327BE0
	pop {r4,r5,r6,r7}	; 02327BE2
	pop {r3}	; 02327BE4
	bx r3	; 02327BE6
pool_02327BE8:
loc_02327BE8:
	.word 0xB7000000	; 02327BE8
pool_02327BEC:
loc_02327BEC:
	.word NdsCartHeaderRamAddress + 0x60	; 02327BEC
pool_02327BF0:
loc_02327BF0:
	.word 0xA1000000	; 02327BF0
pool_02327BF4:
loc_02327BF4:
	.word REG_ROMCTRL	; 02327BF4
pool_02327BF8:
loc_02327BF8:
	.word REG_GCDATAIN	; 02327BF8
pool_02327BFC:
loc_02327BFC:
	.word 0x80000000	; 02327BFC
pool_02327C00:
loc_02327C00:
	.word 0x00800000	; 02327C00

; ===== function loc_02327C04 =====
loc_02327C04:
	push {r4,r5,r6,r7,lr}	; 02327C04
	sub sp,#0x4	; 02327C06
	add r6,r0,#0x0	; 02327C08
	add r7,r1,#0x0	; 02327C0A
	add r5,r2,#0x0	; 02327C0C
	add r4,r5,#0x0	; 02327C0E
	cmp r5,#0x0	; 02327C10
	ble loc_02327C34	; 02327C12
loc_02327C14:
	ldr r0,[pool_02327C3C]	; 02327C14
	cmp r4,r0	; 02327C16
	blt loc_02327C1E	; 02327C18
	lsl r5,r0,#0	; 02327C1A
	b loc_02327C20	; 02327C1C
loc_02327C1E:
	add r5,r4,#0x0	; 02327C1E
loc_02327C20:
	add r0,r6,#0x0	; 02327C20
	add r1,r7,#0x0	; 02327C22
	add r2,r5,#0x0	; 02327C24
	bl loc_02327B98	; 02327C26
	add r6,r6,r5	; 02327C2A
	add r7,r7,r5	; 02327C2C
	sub r4,r4,r5	; 02327C2E
	cmp r4,#0x0	; 02327C30
	bgt loc_02327C14	; 02327C32
loc_02327C34:
	add sp,#0x4	; 02327C34
	pop {r4,r5,r6,r7}	; 02327C36
	pop {r3}	; 02327C38
	bx r3	; 02327C3A
pool_02327C3C:
loc_02327C3C:
	.word 0x00000200	; 02327C3C

; ===== function loc_02327C40 =====
loc_02327C40:
	push {lr}	; 02327C40
	sub sp,#0xc	; 02327C42
	mov r0,#0x0	; 02327C44
	str r0,[sp,#0x0]	; 02327C46
	ldr r0,[pool_02327C64]	; 02327C48
	str r0,[sp,#0x4]	; 02327C4A
	add r0,sp,#0x0	; 02327C4C
	bl loc_02327B60	; 02327C4E
	ldr r0,[pool_02327C68]	; 02327C52
	ldr r1,[r0,#0x4]	; 02327C54
	ldr r0,[pool_02327C6C]	; 02327C56
	orr r1,r0	; 02327C58
	ldr r0,[pool_02327C70]	; 02327C5A
	str r1,[r0,#0x0]	; 02327C5C
	add sp,#0xc	; 02327C5E
	pop {r3}	; 02327C60
	bx r3	; 02327C62
pool_02327C64:
loc_02327C64:
	.word 0xB8000000	; 02327C64
pool_02327C68:
loc_02327C68:
	.word P1_BssStart + 0x25740	; 02327C68
pool_02327C6C:
loc_02327C6C:
	.word 0xA7000000	; 02327C6C
pool_02327C70:
loc_02327C70:
	.word REG_ROMCTRL	; 02327C70

; ===== function loc_02327C74 =====
loc_02327C74:
	ldr r0,[pool_02327C88]	; 02327C74
	ldr r1,[r0,#0x0]	; 02327C76
	ldr r0,[pool_02327C8C]	; 02327C78
	and r1,r0	; 02327C7A
	cmp r1,#0x0	; 02327C7C
	beq loc_02327C84	; 02327C7E
	mov r0,#0x1	; 02327C80
	bx lr	; 02327C82
loc_02327C84:
	mov r0,#0x0	; 02327C84
	bx lr	; 02327C86
pool_02327C88:
loc_02327C88:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327C88
pool_02327C8C:
loc_02327C8C:
	.word 0x00000200	; 02327C8C

; ===== function loc_02327C90 =====
loc_02327C90:
	ldr r0,[pool_02327CA0]	; 02327C90
	ldr r0,[r0,#0x0]	; 02327C92
	cmp r0,#0x1	; 02327C94
	bne loc_02327C9C	; 02327C96
	mov r0,#0x1	; 02327C98
	bx lr	; 02327C9A
loc_02327C9C:
	mov r0,#0x0	; 02327C9C
	bx lr	; 02327C9E
pool_02327CA0:
loc_02327CA0:
	.word P1_BssStart + 0x25740	; 02327CA0

; ===== function loc_02327CA4 =====
loc_02327CA4:
	push {lr}	; 02327CA4
	sub sp,#0x4	; 02327CA6
	bl loc_02327C90	; 02327CA8
	cmp r0,#0x0	; 02327CAC
	beq loc_02327CBC	; 02327CAE
loc_02327CB0:
	bl loc_02327CC4	; 02327CB0
	bl loc_02327C90	; 02327CB4
	cmp r0,#0x0	; 02327CB8
	bne loc_02327CB0	; 02327CBA
loc_02327CBC:
	add sp,#0x4	; 02327CBC
	pop {r3}	; 02327CBE
	bx r3	; 02327CC0
	.byte 0x00, 0x00	; 02327CC4

; ===== function loc_02327CC4 =====
loc_02327CC4:
	push {lr}	; 02327CC4
	sub sp,#0x4	; 02327CC6
	bl loc_02327C74	; 02327CC8
	cmp r0,#0x0	; 02327CCC
	bne loc_02327CD8	; 02327CCE
	mov r0,#0x0	; 02327CD0
	add sp,#0x4	; 02327CD2
	pop {r3}	; 02327CD4
	bx r3	; 02327CD6
loc_02327CD8:
	ldr r0,[pool_02327D48]	; 02327CD8
	ldr r1,[r0,#0x0]	; 02327CDA
	cmp r1,#0x0	; 02327CDC
	beq loc_02327CE6	; 02327CDE
	cmp r1,#0x1	; 02327CE0
	beq loc_02327CFC	; 02327CE2
	b loc_02327D3E	; 02327CE4
loc_02327CE6:
	ldrh r0,[r0,#0x8]	; 02327CE6
	bl loc_0232B2C8	; 02327CE8
	cmp r0,#0x0	; 02327CEC
	bne loc_02327D3E	; 02327CEE
	bl loc_02327C40	; 02327CF0
	mov r1,#0x1	; 02327CF4
	ldr r0,[pool_02327D48]	; 02327CF6
	str r1,[r0,#0x0]	; 02327CF8
	b loc_02327D3E	; 02327CFA
loc_02327CFC:
	ldr r0,[pool_02327D4C]	; 02327CFC
	ldr r1,[r0,#0x0]	; 02327CFE
	ldr r0,[pool_02327D50]	; 02327D00
	and r1,r0	; 02327D02
	cmp r1,#0x0	; 02327D04
	beq loc_02327D3E	; 02327D06
	ldr r0,[pool_02327D54]	; 02327D08
	ldr r1,[r0,#0x0]	; 02327D0A
	ldr r0,[pool_02327D58]	; 02327D0C
	ldr r0,[r0,#0x0]	; 02327D0E
	cmp r1,r0	; 02327D10
	beq loc_02327D30	; 02327D12
	ldr r0,[pool_02327D5C]	; 02327D14
	ldr r1,[r0,#0x0]	; 02327D16
	mov r0,#0x2	; 02327D18
	and r1,r0	; 02327D1A
	cmp r1,#0x0	; 02327D1C
	beq loc_02327D24	; 02327D1E
	mov r0,#0x1	; 02327D20
	b loc_02327D26	; 02327D22
loc_02327D24:
	mov r0,#0x0	; 02327D24
loc_02327D26:
	cmp r0,#0x0	; 02327D26
	beq loc_02327D30	; 02327D28
	mov r1,#0x1	; 02327D2A
	ldr r0,[pool_02327D48]	; 02327D2C
	strh r1,[r0,#0xa]	; 02327D2E
loc_02327D30:
	ldr r0,[pool_02327D48]	; 02327D30
	ldrh r0,[r0,#0x8]	; 02327D32
	bl loc_0232B2DC	; 02327D34
	mov r1,#0x0	; 02327D38
	ldr r0,[pool_02327D48]	; 02327D3A
	str r1,[r0,#0x0]	; 02327D3C
loc_02327D3E:
	ldr r0,[pool_02327D48]	; 02327D3E
	ldrh r0,[r0,#0xa]	; 02327D40
	add sp,#0x4	; 02327D42
	pop {r3}	; 02327D44
	bx r3	; 02327D46
pool_02327D48:
loc_02327D48:
	.word P1_BssStart + 0x25740	; 02327D48
pool_02327D4C:
loc_02327D4C:
	.word REG_ROMCTRL	; 02327D4C
pool_02327D50:
loc_02327D50:
	.word 0x00800000	; 02327D50
pool_02327D54:
loc_02327D54:
	.word REG_GCDATAIN	; 02327D54
pool_02327D58:
loc_02327D58:
	.word FirmwareBootInfoScratchAddress	; 02327D58
pool_02327D5C:
loc_02327D5C:
	.word FirmwareBootSharedAddress + BootSharedEventFlagsOffset	; 02327D5C

; ===== function loc_02327D60 =====
loc_02327D60:
	push {lr}	; 02327D60
	sub sp,#0x4	; 02327D62
	blx loc_0232B204	; 02327D64
	ldr r1,[pool_02327D78]	; 02327D68
	strh r0,[r1,#0x8]	; 02327D6A
	ldr r0,[pool_02327D7C]	; 02327D6C
	ldr r0,[r0,#0x0]	; 02327D6E
	str r0,[r1,#0x4]	; 02327D70
	add sp,#0x4	; 02327D72
	pop {r3}	; 02327D74
	bx r3	; 02327D76
pool_02327D78:
loc_02327D78:
	.word P1_BssStart + 0x25740	; 02327D78
pool_02327D7C:
loc_02327D7C:
	.word NdsCartHeaderRamAddress + 0x60	; 02327D7C
.arm
	mov r0,#0x0	; 02327D80
	mcr p15,0x0,r0,c7,c6,0x0	; 02327D84
	ldr r1,[pool_02327E00]	; 02327D88
loc_02327D8C:
	ldrh r0,[r1,#0x0]	; 02327D8C
	and r0,r0,#0xf	; 02327D90
	cmp r0,#0x2	; 02327D94
	bne loc_02327D8C	; 02327D98
	mov r0,#0x200	; 02327D9C
	strh r0,[r1,#0x0]	; 02327DA0
	ldr r1,[pool_02327E00]	; 02327DA4
loc_02327DA8:
	ldrh r0,[r1,#0x0]	; 02327DA8
	and r0,r0,#0xf	; 02327DAC
	cmp r0,#0x1	; 02327DB0
	bne loc_02327DA8	; 02327DB4
	mov r0,#0x100	; 02327DB8
	strh r0,[r1,#0x0]	; 02327DBC
	bl loc_02327E34	; 02327DC0
	bl loc_02327E0C	; 02327DC4
	ldr r1,[pool_02327E00]	; 02327DC8
loc_02327DCC:
	ldrh r0,[r1,#0x0]	; 02327DCC
	and r0,r0,#0xf	; 02327DD0
	cmp r0,#0x1	; 02327DD4
	beq loc_02327DCC	; 02327DD8
	mov r0,#0x0	; 02327DDC
	strh r0,[r1,#0x0]	; 02327DE0
	ldr r3,[pool_02327E04]	; 02327DE4
	ldr r12,[r3,#-0x1dc]	; 02327DE8
	mov lr,r12	; 02327DEC
	ldr r11,[pool_02327E08]	; 02327DF0
	ldmia r11,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10}	; 02327DF4
	mov r11,#0x0	; 02327DF8
	bx r12	; 02327DFC
pool_02327E00:
loc_02327E00:
	.word REG_IPC_SYNC	; 02327E00
pool_02327E04:
loc_02327E04:
; 基准为头部 RAM 视图 +0x200；负偏移实际读取 ARM9/ARM7 入口字段。
; Addressing anchor: the negative offset above reads the ARM9/ARM7 entry field.
	.word NdsCartHeaderRamAddress + 0x200	; 02327E04
pool_02327E08:
loc_02327E08:
	.word P1_DtcmRuntimeStart	; 02327E08

; ===== function loc_02327E0C =====
loc_02327E0C:
	ldr r0,[pool_02327E30]	; 02327E0C
	mcr p15,0x0,r0,c1,c0,0x0	; 02327E10
	mov r0,#0x0	; 02327E14
	mcr p15,0x0,r0,c6,c5,0x0	; 02327E18
	mov r0,#0x0	; 02327E1C
	mcr p15,0x0,r0,c7,c5,0x0	; 02327E20
	mcr p15,0x0,r0,c7,c6,0x0	; 02327E24
	mcr p15,0x0,r0,c7,c10,0x4	; 02327E28
	bx lr	; 02327E2C
pool_02327E30:
loc_02327E30:
	.word 0x00012078	; 02327E30

; ===== function loc_02327E34 =====
loc_02327E34:
	mov r12,lr	; 02327E34
	mov r0,#0xd3	; 02327E38
	msr cpsr_cxsf,r0	; 02327E3C
	ldr r0,[pool_02327EA4]	; 02327E40
	add r0,r0,#0x3fc0	; 02327E44
	mov sp,r0	; 02327E48
	mov lr,#0x0	; 02327E4C
	msr spsr_cxsf,lr	; 02327E50
	mov r0,#0xd2	; 02327E54
	msr cpsr_cxsf,r0	; 02327E58
	ldr r0,[pool_02327EA4]	; 02327E5C
	add r0,r0,#0x3fc0	; 02327E60
	sub r0,r0,#0x40	; 02327E64
	mov sp,r0	; 02327E68
	mov lr,#0x0	; 02327E6C
	msr spsr_cxsf,lr	; 02327E70
	ldr r1,[pool_02327EA8]	; 02327E74
	sub r1,r0,r1	; 02327E78
	mov r0,#0xdf	; 02327E7C
	msr cpsr_cxsf,r0	; 02327E80
	sub sp,r1,#0x4	; 02327E84
	ldr r0,[pool_02327EAC]	; 02327E88
	mov r1,#0x8000	; 02327E8C
	bl loc_02327EB0	; 02327E90
	ldr r0,[pool_02327EA4]	; 02327E94
	mov r1,#0x4000	; 02327E98
	bl loc_02327EB0	; 02327E9C
	bx r12	; 02327EA0
pool_02327EA4:
loc_02327EA4:
	.word P1_DtcmRuntimeStart	; 02327EA4
pool_02327EA8:
loc_02327EA8:
	.word 0x00001000	; 02327EA8
pool_02327EAC:
loc_02327EAC:
	.word 0x01FF8000	; 02327EAC

; ===== function loc_02327EB0 =====
loc_02327EB0:
	add r2,r0,r1	; 02327EB0
	mov r1,r1, lsr #0x5	; 02327EB4
	mov r3,#0x0	; 02327EB8
	mov r4,r3	; 02327EBC
	mov r5,r3	; 02327EC0
	mov r6,r3	; 02327EC4
	mov r7,r3	; 02327EC8
	mov r8,r3	; 02327ECC
	mov r9,r3	; 02327ED0
	mov r10,r3	; 02327ED4
loc_02327ED8:
	cmp r0,r2	; 02327ED8
	stmltia r0!,{r3,r4,r5,r6,r7,r8,r9,r10}	; 02327EDC
	blt loc_02327ED8	; 02327EE0
	bx lr	; 02327EE4
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 02327EEC
.thumb
P1_PxiCallback_02327EEC:
	push {r4}	; 02327EEC
	sub sp,#0x4	; 02327EEE
	mov r4,#0xff	; 02327EF0
	and r1,r4	; 02327EF2
	ldr r3,[pool_02327F10]	; 02327EF4
	strh r1,[r3,#0x0]	; 02327EF6
	mov r1,#0x1	; 02327EF8
	ldr r0,[pool_02327F14]	; 02327EFA
	str r1,[r0,#0x0]	; 02327EFC
	cmp r2,#0x0	; 02327EFE
	beq loc_02327F04	; 02327F00
	strh r4,[r3,#0x0]	; 02327F02
loc_02327F04:
	ldr r0,[pool_02327F10]	; 02327F04
	ldrh r0,[r0,#0x0]	; 02327F06
	add sp,#0x4	; 02327F08
	pop {r4}	; 02327F0A
	bx lr	; 02327F0C
	.byte 0xC0, 0x46	; 02327F10
pool_02327F10:
loc_02327F10:
	.word P1_BssStart + 0x2574C	; 02327F10
pool_02327F14:
loc_02327F14:
	.word P1_BssStart + 0x25754	; 02327F14

; ===== function loc_02327F18 =====
loc_02327F18:
	push {r4,r5,r6,r7,lr}	; 02327F18
	sub sp,#0xb4	; 02327F1A
	add r6,r0,#0x0	; 02327F1C
	str r1,[sp,#0x0]	; 02327F1E
	str r2,[sp,#0x4]	; 02327F20
	str r3,[sp,#0x8]	; 02327F22
	mov r4,#0x0	; 02327F24
	lsl r0,r1,#0	; 02327F26
	lsr r0,r0,#0x10	; 02327F28
	str r0,[sp,#0x2c]	; 02327F2A
	mov r1,#0xff	; 02327F2C
	and r0,r1	; 02327F2E
	str r0,[sp,#0x2c]	; 02327F30
	ldr r1,[pool_02328238]	; 02327F32
	str r0,[sp,#0x1c]	; 02327F34
	orr r0,r1	; 02327F36
	str r0,[sp,#0x1c]	; 02327F38
	ldr r0,[pool_0232823C]	; 02327F3A
	ldr r1,[sp,#0x0]	; 02327F3C
	and r1,r0	; 02327F3E
	str r1,[sp,#0x0]	; 02327F40
	ldr r1,[pool_02328240]	; 02327F42
	ldr r2,[sp,#0x0]	; 02327F44
	orr r2,r1	; 02327F46
	str r2,[sp,#0x0]	; 02327F48
	ldr r2,[sp,#0x4]	; 02327F4A
	str r2,[sp,#0x20]	; 02327F4C
	and r2,r0	; 02327F4E
	str r2,[sp,#0x20]	; 02327F50
	ldr r5,[pool_02328244]	; 02327F52
	orr r2,r5	; 02327F54
	str r2,[sp,#0x20]	; 02327F56
	lsl r2,r3,#0	; 02327F58
	lsr r2,r2,#0x10	; 02327F5A
	str r2,[sp,#0x30]	; 02327F5C
	ldr r3,[pool_02328248]	; 02327F5E
	str r2,[sp,#0x24]	; 02327F60
	orr r2,r3	; 02327F62
	str r2,[sp,#0x24]	; 02327F64
	ldr r2,[sp,#0x8]	; 02327F66
	and r2,r0	; 02327F68
	str r2,[sp,#0x8]	; 02327F6A
	ldr r3,[pool_0232824C]	; 02327F6C
	str r2,[sp,#0x28]	; 02327F6E
	orr r2,r3	; 02327F70
	str r2,[sp,#0x28]	; 02327F72
	ldr r3,[pool_02328250]	; 02327F74
	ldr r2,[sp,#0x2c]	; 02327F76
	orr r2,r3	; 02327F78
	str r2,[sp,#0x2c]	; 02327F7A
	ldr r3,[sp,#0x4]	; 02327F7C
	ldr r2,[pool_02328254]	; 02327F7E
	orr r3,r2	; 02327F80
	str r3,[sp,#0x4]	; 02327F82
	ldr r2,[sp,#0x30]	; 02327F84
	orr r2,r5	; 02327F86
	str r2,[sp,#0x30]	; 02327F88
	ldr r3,[pool_02328258]	; 02327F8A
	ldr r2,[sp,#0x8]	; 02327F8C
	orr r2,r3	; 02327F8E
	str r2,[sp,#0x8]	; 02327F90
	ldr r2,[pool_0232825C]	; 02327F92
	lsr r2,r2,#0x18	; 02327F94
	str r2,[sp,#0x34]	; 02327F96
	ldr r3,[pool_02328260]	; 02327F98
	orr r2,r3	; 02327F9A
	str r2,[sp,#0x34]	; 02327F9C
	ldr r2,[pool_0232825C]	; 02327F9E
	lsr r2,r2,#0x8	; 02327FA0
	str r2,[sp,#0x38]	; 02327FA2
	and r2,r0	; 02327FA4
	str r2,[sp,#0x38]	; 02327FA6
	orr r2,r1	; 02327FA8
	str r2,[sp,#0x38]	; 02327FAA
	ldr r0,[pool_0232825C]	; 02327FAC
	lsl r0,r0,#0x8	; 02327FAE
	str r0,[sp,#0x3c]	; 02327FB0
	ldr r1,[pool_02328264]	; 02327FB2
	and r0,r1	; 02327FB4
	str r0,[sp,#0x3c]	; 02327FB6
	ldr r1,[pool_02328268]	; 02327FB8
	orr r0,r1	; 02327FBA
	str r0,[sp,#0x3c]	; 02327FBC
	str r4,[sp,#0xb0]	; 02327FBE
	str r4,[sp,#0xac]	; 02327FC0
	mov r5,#0x4	; 02327FC2
	str r4,[sp,#0xa8]	; 02327FC4
	str r4,[sp,#0x98]	; 02327FC6
	str r4,[sp,#0xa0]	; 02327FC8
	str r4,[sp,#0xa4]	; 02327FCA
	str r4,[sp,#0x9c]	; 02327FCC
	str r4,[sp,#0x94]	; 02327FCE
	str r4,[sp,#0x74]	; 02327FD0
	str r4,[sp,#0x7c]	; 02327FD2
	str r4,[sp,#0x84]	; 02327FD4
	str r4,[sp,#0x8c]	; 02327FD6
	str r4,[sp,#0x90]	; 02327FD8
	str r4,[sp,#0x88]	; 02327FDA
	str r4,[sp,#0x80]	; 02327FDC
	str r4,[sp,#0x78]	; 02327FDE
	str r4,[sp,#0x70]	; 02327FE0
	str r4,[sp,#0x6c]	; 02327FE2
	str r4,[sp,#0x44]	; 02327FE4
	str r4,[sp,#0x4c]	; 02327FE6
	str r4,[sp,#0x54]	; 02327FE8
	str r4,[sp,#0x5c]	; 02327FEA
	str r4,[sp,#0x64]	; 02327FEC
	str r4,[sp,#0x68]	; 02327FEE
	str r4,[sp,#0x60]	; 02327FF0
	str r4,[sp,#0x58]	; 02327FF2
	str r4,[sp,#0x50]	; 02327FF4
	str r4,[sp,#0x48]	; 02327FF6
	str r4,[sp,#0x40]	; 02327FF8
	add r7,r4,#0x0	; 02327FFA
loc_02327FFC:
	cmp r4,#0x0	; 02327FFC
	beq loc_02328002	; 02327FFE
	b loc_02328162	; 02328000
loc_02328002:
	ldr r0,[pool_0232826C]	; 02328002
	str r7,[r0,#0x0]	; 02328004
	cmp r6,#0x6	; 02328006
	bhi loc_02327FFC	; 02328008
	add r0,r6,r6	; 0232800A
P1_SwitchIndexPC_0232800A:
	add r0,pc	; 0232800C
	ldrh r0,[r0,#(P1_SwitchTable_0232800A - (P1_SwitchIndexPC_0232800A + 4))]	; 0232800E
	lsl r0,r0,#0x10	; 02328010
	asr r0,r0,#0x10	; 02328012
P1_SwitchTargetPC_0232800A:
	add r0,pc	; 02328014
	bx r0	; 02328016
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232800A:
	.halfword (loc_02327FFC + 1) - (P1_SwitchTargetPC_0232800A + 4)
	.halfword (loc_02328026 + 1) - (P1_SwitchTargetPC_0232800A + 4)
	.halfword (loc_02328096 + 1) - (P1_SwitchTargetPC_0232800A + 4)
	.halfword (loc_023280AC + 1) - (P1_SwitchTargetPC_0232800A + 4)
	.halfword (loc_02328112 + 1) - (P1_SwitchTargetPC_0232800A + 4)
	.halfword (loc_02328112 + 1) - (P1_SwitchTargetPC_0232800A + 4)
	.halfword (loc_0232814C + 1) - (P1_SwitchTargetPC_0232800A + 4)
P1_SwitchTable_0232800AEnd:
loc_02328026:
	add r0,r5,#0x0	; 02328026
	ldr r1,[sp,#0x1c]	; 02328028
	add r2,r7,#0x0	; 0232802A
	bl loc_0232E858	; 0232802C
	cmp r0,#0x0	; 02328030
	bge loc_02328038	; 02328032
	ldr r4,[sp,#0x40]	; 02328034
	b loc_02327FFC	; 02328036
loc_02328038:
	add r0,r5,#0x0	; 02328038
	ldr r1,[sp,#0x0]	; 0232803A
	ldr r2,[sp,#0x44]	; 0232803C
	bl loc_0232E858	; 0232803E
	cmp r0,#0x0	; 02328042
	bge loc_0232804A	; 02328044
	ldr r4,[sp,#0x48]	; 02328046
	b loc_02327FFC	; 02328048
loc_0232804A:
	add r0,r5,#0x0	; 0232804A
	ldr r1,[pool_02328254]	; 0232804C
	ldr r2,[sp,#0x4c]	; 0232804E
	bl loc_0232E858	; 02328050
	cmp r0,#0x0	; 02328054
	bge loc_0232805C	; 02328056
	ldr r4,[sp,#0x50]	; 02328058
	b loc_02327FFC	; 0232805A
loc_0232805C:
	add r0,r5,#0x0	; 0232805C
	ldr r1,[sp,#0x20]	; 0232805E
	ldr r2,[sp,#0x54]	; 02328060
	bl loc_0232E858	; 02328062
	cmp r0,#0x0	; 02328066
	bge loc_0232806E	; 02328068
	ldr r4,[sp,#0x58]	; 0232806A
	b loc_02327FFC	; 0232806C
loc_0232806E:
	add r0,r5,#0x0	; 0232806E
	ldr r1,[sp,#0x24]	; 02328070
	ldr r2,[sp,#0x5c]	; 02328072
	bl loc_0232E858	; 02328074
	cmp r0,#0x0	; 02328078
	bge loc_02328080	; 0232807A
	ldr r4,[sp,#0x60]	; 0232807C
	b loc_02327FFC	; 0232807E
loc_02328080:
	add r0,r5,#0x0	; 02328080
	ldr r1,[sp,#0x28]	; 02328082
	ldr r2,[sp,#0x64]	; 02328084
	bl loc_0232E858	; 02328086
	cmp r0,#0x0	; 0232808A
	bge loc_02328092	; 0232808C
	ldr r4,[sp,#0x68]	; 0232808E
	b loc_02327FFC	; 02328090
loc_02328092:
	mov r4,#0x1	; 02328092
	b loc_02327FFC	; 02328094
loc_02328096:
	add r0,r5,#0x0	; 02328096
	ldr r1,[pool_02328270]	; 02328098
	add r2,r7,#0x0	; 0232809A
	bl loc_0232E858	; 0232809C
	cmp r0,#0x0	; 023280A0
	blt loc_023280A8	; 023280A2
	mov r4,#0x1	; 023280A4
	b loc_02327FFC	; 023280A6
loc_023280A8:
	ldr r4,[sp,#0x6c]	; 023280A8
	b loc_02327FFC	; 023280AA
loc_023280AC:
	add r0,r5,#0x0	; 023280AC
	ldr r1,[sp,#0x2c]	; 023280AE
	add r2,r7,#0x0	; 023280B0
	bl loc_0232E858	; 023280B2
	cmp r0,#0x0	; 023280B6
	bge loc_023280BE	; 023280B8
	ldr r4,[sp,#0x70]	; 023280BA
	b loc_02328108	; 023280BC
loc_023280BE:
	add r0,r5,#0x0	; 023280BE
	ldr r1,[sp,#0x0]	; 023280C0
	ldr r2,[sp,#0x74]	; 023280C2
	bl loc_0232E858	; 023280C4
	cmp r0,#0x0	; 023280C8
	bge loc_023280D0	; 023280CA
	ldr r4,[sp,#0x78]	; 023280CC
	b loc_02328108	; 023280CE
loc_023280D0:
	add r0,r5,#0x0	; 023280D0
	ldr r1,[sp,#0x4]	; 023280D2
	ldr r2,[sp,#0x7c]	; 023280D4
	bl loc_0232E858	; 023280D6
	cmp r0,#0x0	; 023280DA
	bge loc_023280E2	; 023280DC
	ldr r4,[sp,#0x80]	; 023280DE
	b loc_02328108	; 023280E0
loc_023280E2:
	add r0,r5,#0x0	; 023280E2
	ldr r1,[sp,#0x30]	; 023280E4
	ldr r2,[sp,#0x84]	; 023280E6
	bl loc_0232E858	; 023280E8
	cmp r0,#0x0	; 023280EC
	bge loc_023280F4	; 023280EE
	ldr r4,[sp,#0x88]	; 023280F0
	b loc_02328108	; 023280F2
loc_023280F4:
	add r0,r5,#0x0	; 023280F4
	ldr r1,[sp,#0x8]	; 023280F6
	ldr r2,[sp,#0x8c]	; 023280F8
	bl loc_0232E858	; 023280FA
	cmp r0,#0x0	; 023280FE
	bge loc_02328106	; 02328100
	ldr r4,[sp,#0x90]	; 02328102
	b loc_02328108	; 02328104
loc_02328106:
	mov r4,#0x1	; 02328106
loc_02328108:
	bl loc_0232BF94	; 02328108
	str r0,[sp,#0x14]	; 0232810C
	str r1,[sp,#0x10]	; 0232810E
	b loc_02327FFC	; 02328110
loc_02328112:
	add r0,r5,#0x0	; 02328112
	ldr r1,[sp,#0x34]	; 02328114
	add r2,r7,#0x0	; 02328116
	bl loc_0232E858	; 02328118
	cmp r0,#0x0	; 0232811C
	bge loc_02328124	; 0232811E
	ldr r4,[sp,#0x94]	; 02328120
	b loc_02327FFC	; 02328122
loc_02328124:
	add r0,r5,#0x0	; 02328124
	ldr r1,[sp,#0x38]	; 02328126
	ldr r2,[sp,#0x98]	; 02328128
	bl loc_0232E858	; 0232812A
	cmp r0,#0x0	; 0232812E
	bge loc_02328136	; 02328130
	ldr r4,[sp,#0x9c]	; 02328132
	b loc_02327FFC	; 02328134
loc_02328136:
	add r0,r5,#0x0	; 02328136
	ldr r1,[sp,#0x3c]	; 02328138
	ldr r2,[sp,#0xa0]	; 0232813A
	bl loc_0232E858	; 0232813C
	cmp r0,#0x0	; 02328140
	bge loc_02328148	; 02328142
	ldr r4,[sp,#0xa4]	; 02328144
	b loc_02327FFC	; 02328146
loc_02328148:
	mov r4,#0x1	; 02328148
	b loc_02327FFC	; 0232814A
loc_0232814C:
	add r0,r5,#0x0	; 0232814C
	ldr r1,[pool_02328274]	; 0232814E
	add r2,r7,#0x0	; 02328150
	bl loc_0232E858	; 02328152
	cmp r0,#0x0	; 02328156
	blt loc_0232815E	; 02328158
	mov r4,#0x1	; 0232815A
	b loc_02327FFC	; 0232815C
loc_0232815E:
	ldr r4,[sp,#0xa8]	; 0232815E
	b loc_02327FFC	; 02328160
loc_02328162:
	ldr r0,[pool_0232826C]	; 02328162
	ldr r0,[r0,#0x0]	; 02328164
	cmp r0,#0x1	; 02328166
	beq loc_0232816C	; 02328168
	b loc_02327FFC	; 0232816A
loc_0232816C:
	ldr r4,[sp,#0xac]	; 0232816C
	ldr r0,[pool_02328278]	; 0232816E
	ldrh r0,[r0,#0x0]	; 02328170
	cmp r0,#0x0	; 02328172
	bne loc_0232822C	; 02328174
	cmp r6,#0x6	; 02328176
	bls loc_0232817C	; 02328178
	b loc_02327FFC	; 0232817A
loc_0232817C:
	add r0,r6,r6	; 0232817C
P1_SwitchIndexPC_0232817C:
	add r0,pc	; 0232817E
	ldrh r0,[r0,#(P1_SwitchTable_0232817C - (P1_SwitchIndexPC_0232817C + 4))]	; 02328180
	lsl r0,r0,#0x10	; 02328182
	asr r0,r0,#0x10	; 02328184
P1_SwitchTargetPC_0232817C:
	add r0,pc	; 02328186
	bx r0	; 02328188
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232817C:
	.halfword (loc_02327FFC + 1) - (P1_SwitchTargetPC_0232817C + 4)
	.halfword (loc_02328198 + 1) - (P1_SwitchTargetPC_0232817C + 4)
	.halfword (loc_023281A2 + 1) - (P1_SwitchTargetPC_0232817C + 4)
	.halfword (loc_023281A6 + 1) - (P1_SwitchTargetPC_0232817C + 4)
	.halfword (loc_023281AA + 1) - (P1_SwitchTargetPC_0232817C + 4)
	.halfword (loc_023281AA + 1) - (P1_SwitchTargetPC_0232817C + 4)
	.halfword (loc_02328222 + 1) - (P1_SwitchTargetPC_0232817C + 4)
P1_SwitchTable_0232817CEnd:
loc_02328198:
	mov r0,#0x1	; 02328198
	add sp,#0xb4	; 0232819A
	pop {r4,r5,r6,r7}	; 0232819C
	pop {r3}	; 0232819E
	bx r3	; 023281A0
loc_023281A2:
	add r6,r5,#0x0	; 023281A2
	b loc_02327FFC	; 023281A4
loc_023281A6:
	mov r6,#0x5	; 023281A6
	b loc_02327FFC	; 023281A8
loc_023281AA:
	ldr r0,[pool_0232825C]	; 023281AA
	mov r1,#0x1	; 023281AC
	blx P1_InvalidateDataCacheRange	; 023281AE
	cmp r6,#0x4	; 023281B2
	bne loc_023281D0	; 023281B4
	ldr r0,[pool_0232825C]	; 023281B6
	ldrb r1,[r0,#0x0]	; 023281B8
	mov r0,#0x2	; 023281BA
	and r1,r0	; 023281BC
	cmp r1,#0x0	; 023281BE
	beq loc_023281C6	; 023281C0
	mov r6,#0x3	; 023281C2
	b loc_02327FFC	; 023281C4
loc_023281C6:
	mov r0,#0x0	; 023281C6
	add sp,#0xb4	; 023281C8
	pop {r4,r5,r6,r7}	; 023281CA
	pop {r3}	; 023281CC
	bx r3	; 023281CE
loc_023281D0:
	ldr r0,[pool_0232825C]	; 023281D0
	ldrb r1,[r0,#0x0]	; 023281D2
	add r2,r1,#0x0	; 023281D4
	mov r0,#0x1	; 023281D6
	and r2,r0	; 023281D8
	cmp r2,#0x0	; 023281DA
	beq loc_0232822E	; 023281DC
	mov r0,#0x20	; 023281DE
	and r1,r0	; 023281E0
	cmp r1,#0x0	; 023281E2
	bne loc_02328216	; 023281E4
	bl loc_0232BF94	; 023281E6
	add r3,r0,#0x0	; 023281EA
	add r2,r1,#0x0	; 023281EC
	ldr r0,[sp,#0x14]	; 023281EE
	sub r1,r3,r0	; 023281F0
	ldr r0,[sp,#0x10]	; 023281F2
	sbc r2,r0	; 023281F4
	lsr r0,r1,#0x1a	; 023281F6
	lsl r2,r2,#0x6	; 023281F8
	orr r2,r0	; 023281FA
	lsl r0,r1,#0x6	; 023281FC
	add r1,r2,#0x0	; 023281FE
	ldr r2,[pool_0232827C]	; 02328200
	ldr r3,[sp,#0xb0]	; 02328202
	blx loc_0232CAA4	; 02328204
	add r3,r0,#0x0	; 02328208
	add r2,r1,#0x0	; 0232820A
	mov r1,#0x0	; 0232820C
	ldr r0,[pool_02328280]	; 0232820E
	sub r0,r0,r3	; 02328210
	sbc r1,r2	; 02328212
	bcs loc_0232821A	; 02328214
loc_02328216:
	mov r6,#0x6	; 02328216
	b loc_02327FFC	; 02328218
loc_0232821A:
	ldr r0,[pool_02328284]	; 0232821A
	bl loc_0232C74C	; 0232821C
	b loc_02327FFC	; 02328220
loc_02328222:
	lsl r0,r4,#0	; 02328222
	add sp,#0xb4	; 02328224
	pop {r4,r5,r6,r7}	; 02328226
	pop {r3}	; 02328228
	bx r3	; 0232822A
loc_0232822C:
	lsl r0,r4,#0	; 0232822C
loc_0232822E:
	add sp,#0xb4	; 0232822E
	pop {r4,r5,r6,r7}	; 02328230
	pop {r3}	; 02328232
	bx r3	; 02328234
	.byte 0xC0, 0x46	; 02328238
pool_02328238:
loc_02328238:
	.word 0x02002300	; 02328238
pool_0232823C:
loc_0232823C:
	.word 0x0000FFFF	; 0232823C
pool_02328240:
loc_02328240:
	.word 0x00010000	; 02328240
pool_02328244:
loc_02328244:
	.word 0x00030000	; 02328244
pool_02328248:
loc_02328248:
	.word 0x00040000	; 02328248
pool_0232824C:
loc_0232824C:
	.word 0x01050000	; 0232824C
pool_02328250:
loc_02328250:
	.word 0x02002500	; 02328250
pool_02328254:
loc_02328254:
	.word 0x00020000	; 02328254
pool_02328258:
loc_02328258:
	.word 0x01040000	; 02328258
pool_0232825C:
loc_0232825C:
	.word P1_BssStart + 0x257E0	; 0232825C
pool_02328260:
loc_02328260:
	.word 0x02002200	; 02328260
pool_02328264:
loc_02328264:
	.word 0x0000FF00	; 02328264
pool_02328268:
loc_02328268:
	.word 0x01020000	; 02328268
pool_0232826C:
loc_0232826C:
	.word P1_BssStart + 0x25754	; 0232826C
pool_02328270:
loc_02328270:
	.word 0x03002000	; 02328270
pool_02328274:
loc_02328274:
	.word 0x03002D00	; 02328274
pool_02328278:
loc_02328278:
	.word P1_BssStart + 0x2574C	; 02328278
pool_0232827C:
loc_0232827C:
	.word 0x000082EA	; 0232827C
pool_02328280:
loc_02328280:
	.word 0x00000FA0	; 02328280
pool_02328284:
loc_02328284:
	.word 0x00004000	; 02328284

; ===== function loc_02328288 =====
loc_02328288:
; 检查副本并按更新计数选择；返回 0 成功，1 表示两份均无效。
; Validate/select by update counter; return 0 on success, 1 if neither copy is valid.
.func P1_SelectValidUserSettingsCopy
	push {r4,r5,r6,r7,lr}	; 02328288
	sub sp,#0x4	; 0232828A
	add r7,r0,#0x0	; 0232828C
	mov r6,#0x0	; 0232828E
	add r5,r6,#0x0	; 02328290
loc_02328292:
	lsl r0,r5,#0x7	; 02328292
	add r4,r7,r0	; 02328294
	ldr r0,[pool_02328340]	; 02328296
	add r1,r4,#0x0	; 02328298
	mov r2,#0x70	; 0232829A
	bl P1_SwiGetCrc16	; 0232829C
	add r1,r4,#0x0	; 023282A0
	add r1,#0x72	; 023282A2
	ldrh r1,[r1,#0x0]	; 023282A4
	cmp r0,r1	; 023282A6
	bne loc_023282CE	; 023282A8
	add r0,r4,#0x0	; 023282AA
	add r0,#0x70	; 023282AC
	ldrh r0,[r0,#0x0]	; 023282AE
	cmp r0,#0x80	; 023282B0
	bcs loc_023282CE	; 023282B2
	ldrb r0,[r4,#0x0]	; 023282B4
	cmp r0,#0x5	; 023282B6
	bne loc_023282CE	; 023282B8
	add r0,r4,#0x0	; 023282BA
	bl loc_023283FC	; 023282BC
	cmp r0,#0x0	; 023282C0
	beq loc_023282CE	; 023282C2
	mov r0,#0x1	; 023282C4
	lsl r0,r5	; 023282C6
	orr r6,r0	; 023282C8
	lsl r0,r6,#0x10	; 023282CA
	lsr r6,r0,#0x10	; 023282CC
loc_023282CE:
	add r0,r5,#0x1	; 023282CE
	lsl r0,r0,#0x10	; 023282D0
	lsr r5,r0,#0x10	; 023282D2
	cmp r5,#0x2	; 023282D4
	bcc loc_02328292	; 023282D6
	cmp r6,#0x3	; 023282D8
	bne loc_02328304	; 023282DA
	add r0,r7,#0x0	; 023282DC
	add r0,#0x70	; 023282DE
	ldrh r0,[r0,#0x0]	; 023282E0
	add r1,r0,#0x1	; 023282E2
	mov r0,#0x7f	; 023282E4
	and r1,r0	; 023282E6
	lsl r0,r1,#0x18	; 023282E8
	lsr r1,r0,#0x18	; 023282EA
	add r7,#0xf0	; 023282EC
	ldrh r0,[r7,#0x0]	; 023282EE
	cmp r1,r0	; 023282F0
	bne loc_023282FC	; 023282F2
	mov r1,#0x1	; 023282F4
	ldr r0,[pool_02328344]	; 023282F6
	strh r1,[r0,#0x0]	; 023282F8
	b loc_02328334	; 023282FA
loc_023282FC:
	mov r1,#0x0	; 023282FC
	ldr r0,[pool_02328344]	; 023282FE
	strh r1,[r0,#0x0]	; 02328300
	b loc_02328334	; 02328302
loc_02328304:
	cmp r6,#0x0	; 02328304
	beq loc_0232832A	; 02328306
	mov r1,#0x0	; 02328308
	ldr r0,[pool_02328344]	; 0232830A
	strh r1,[r0,#0x0]	; 0232830C
	mov r2,#0x1	; 0232830E
loc_02328310:
	ldrh r1,[r0,#0x0]	; 02328310
	add r3,r2,#0x0	; 02328312
	lsl r3,r1	; 02328314
	add r4,r6,#0x0	; 02328316
	and r4,r3	; 02328318
	cmp r4,#0x0	; 0232831A
	bne loc_02328334	; 0232831C
	add r1,r1,#0x1	; 0232831E
	strh r1,[r0,#0x0]	; 02328320
	ldrh r1,[r0,#0x0]	; 02328322
	cmp r1,#0x2	; 02328324
	bcc loc_02328310	; 02328326
	b loc_02328334	; 02328328
loc_0232832A:
	mov r0,#0x1	; 0232832A
	add sp,#0x4	; 0232832C
	pop {r4,r5,r6,r7}	; 0232832E
	pop {r3}	; 02328330
	bx r3	; 02328332
loc_02328334:
	mov r0,#0x0	; 02328334
	add sp,#0x4	; 02328336
	pop {r4,r5,r6,r7}	; 02328338
	pop {r3}	; 0232833A
	bx r3	; 0232833C
.endfunc
	.byte 0xC0, 0x46	; 02328340
pool_02328340:
loc_02328340:
	.word 0x0000FFFF	; 02328340
pool_02328344:
loc_02328344:
	.word P1_Data_02330690	; 02328344

; ===== function loc_02328348 =====
loc_02328348:
	push {r4,r5,r6,r7,lr}	; 02328348
	sub sp,#0x4	; 0232834A
	add r4,r0,#0x0	; 0232834C
	ldr r0,[pool_023283E4]	; 0232834E
	ldrh r0,[r0,#0x0]	; 02328350
	cmp r0,#0xff	; 02328352
	bne loc_02328366	; 02328354
	mov r0,#0x0	; 02328356
	bl P1_LoadAndSelectUserSettings	; 02328358
	cmp r0,#0x0	; 0232835C
	beq loc_02328366	; 0232835E
	mov r1,#0x0	; 02328360
	ldr r0,[pool_023283E4]	; 02328362
	strh r1,[r0,#0x0]	; 02328364
loc_02328366:
	mov r0,#0x5	; 02328366
	strb r0,[r4,#0x0]	; 02328368
	ldr r3,[pool_023283E8]	; 0232836A
	mov r2,#0xe	; 0232836C
loc_0232836E:
	ldmia r4!,{r0,r1}	; 0232836E
	stmia r3!,{r0,r1}	; 02328370
	sub r2,r2,#0x1	; 02328372
	cmp r2,#0x0	; 02328374
	bne loc_0232836E	; 02328376
	ldr r0,[pool_023283EC]	; 02328378
	ldr r1,[pool_023283E8]	; 0232837A
	mov r2,#0x70	; 0232837C
	bl P1_SwiGetCrc16	; 0232837E
	ldr r1,[pool_023283E8]	; 02328382
	add r1,#0x72	; 02328384
	strh r0,[r1,#0x0]	; 02328386
	ldr r1,[pool_023283F0]	; 02328388
	ldrh r2,[r1,#0x0]	; 0232838A
	ldr r0,[pool_023283E8]	; 0232838C
	add r0,#0x70	; 0232838E
	strh r2,[r0,#0x0]	; 02328390
	ldrh r0,[r1,#0x0]	; 02328392
	add r2,r0,#0x1	; 02328394
	mov r0,#0x7f	; 02328396
	and r2,r0	; 02328398
	lsl r0,r2,#0x18	; 0232839A
	lsr r0,r0,#0x18	; 0232839C
	strh r0,[r1,#0x0]	; 0232839E
	ldr r0,[pool_023283E8]	; 023283A0
	mov r1,#0x80	; 023283A2
	blx P1_CleanAndInvalidateDataCacheRange	; 023283A4
	mov r0,#0x8	; 023283A8
	sub r5,r0,#0x1	; 023283AA
	ldr r4,[pool_023283E4]	; 023283AC
	ldr r6,[pool_023283F4]	; 023283AE
	mov r7,#0x1	; 023283B0
loc_023283B2:
	ldrh r0,[r4,#0x0]	; 023283B2
	eor r0,r7	; 023283B4
	strh r0,[r4,#0x0]	; 023283B6
	mov r0,#0x2	; 023283B8
	ldr r1,[r6,#0x0]	; 023283BA
	ldrh r2,[r4,#0x0]	; 023283BC
	lsl r2,r2,#0x8	; 023283BE
	add r1,r1,r2	; 023283C0
	mov r2,#0x80	; 023283C2
	ldr r3,[pool_023283E8]	; 023283C4
	bl loc_02327F18	; 023283C6
	cmp r0,#0x0	; 023283CA
	bne loc_023283DC	; 023283CC
	ldr r0,[pool_023283F8]	; 023283CE
	bl loc_0232C74C	; 023283D0
	add r0,r5,#0x0	; 023283D4
	sub r5,r5,#0x1	; 023283D6
	cmp r0,#0x0	; 023283D8
	bne loc_023283B2	; 023283DA
loc_023283DC:
	add sp,#0x4	; 023283DC
	pop {r4,r5,r6,r7}	; 023283DE
	pop {r3}	; 023283E0
	bx r3	; 023283E2
pool_023283E4:
loc_023283E4:
	.word P1_Data_02330690	; 023283E4
pool_023283E8:
loc_023283E8:
	.word P1_BssStart + 0x25760	; 023283E8
pool_023283EC:
loc_023283EC:
	.word 0x0000FFFF	; 023283EC
pool_023283F0:
loc_023283F0:
	.word P1_BssStart + 0x25750	; 023283F0
pool_023283F4:
loc_023283F4:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 023283F4
pool_023283F8:
loc_023283F8:
	.word 0x00004000	; 023283F8

; ===== function loc_023283FC =====
loc_023283FC:
	add r1,r0,#0x0	; 023283FC
	add r1,#0x64	; 023283FE
	ldrh r1,[r1,#0x0]	; 02328400
	lsl r2,r1,#0x12	; 02328402
	lsr r2,r2,#0x1f	; 02328404
	cmp r2,#0x0	; 02328406
	beq loc_02328416	; 02328408
	lsl r1,r1,#0x1d	; 0232840A
	lsr r1,r1,#0x1d	; 0232840C
	cmp r1,#0x6	; 0232840E
	bcc loc_02328416	; 02328410
	mov r0,#0x0	; 02328412
	bx lr	; 02328414
loc_02328416:
	add r1,r0,#0x0	; 02328416
	add r1,#0x64	; 02328418
	ldrh r1,[r1,#0x0]	; 0232841A
	lsl r1,r1,#0x15	; 0232841C
	lsr r1,r1,#0x1f	; 0232841E
	cmp r1,#0x0	; 02328420
	beq loc_02328434	; 02328422
	ldrb r1,[r0,#0x3]	; 02328424
	cmp r1,#0xc	; 02328426
	bhi loc_02328430	; 02328428
	ldrb r1,[r0,#0x4]	; 0232842A
	cmp r1,#0x1f	; 0232842C
	bls loc_02328434	; 0232842E
loc_02328430:
	mov r0,#0x0	; 02328430
	bx lr	; 02328432
loc_02328434:
	add r1,r0,#0x0	; 02328434
	add r1,#0x64	; 02328436
	ldrh r1,[r1,#0x0]	; 02328438
	lsl r1,r1,#0x10	; 0232843A
	lsr r1,r1,#0x1f	; 0232843C
	cmp r1,#0x0	; 0232843E
	beq loc_0232844C	; 02328440
	ldrb r1,[r0,#0x1a]	; 02328442
	cmp r1,#0xa	; 02328444
	bls loc_0232844C	; 02328446
	mov r0,#0x0	; 02328448
	bx lr	; 0232844A
loc_0232844C:
	add r1,r0,#0x0	; 0232844C
	add r1,#0x50	; 0232844E
	ldrb r1,[r1,#0x0]	; 02328450
	cmp r1,#0x1a	; 02328452
	bls loc_0232845A	; 02328454
	mov r0,#0x0	; 02328456
	bx lr	; 02328458
loc_0232845A:
	add r1,r0,#0x0	; 0232845A
	add r1,#0x52	; 0232845C
	ldrb r1,[r1,#0x0]	; 0232845E
	cmp r1,#0x17	; 02328460
	bhi loc_0232846C	; 02328462
	add r0,#0x53	; 02328464
	ldrb r0,[r0,#0x0]	; 02328466
	cmp r0,#0x3b	; 02328468
	bls loc_02328470	; 0232846A
loc_0232846C:
	mov r0,#0x0	; 0232846C
	bx lr	; 0232846E
loc_02328470:
	mov r0,#0x1	; 02328470
	bx lr	; 02328472

; ===== function loc_02328474 =====
loc_02328474:
; 读取两份用户设置并选用有效副本；返回 1 表示无可用副本。
; Read both settings copies and select one; return 1 when neither is usable.
.func P1_LoadAndSelectUserSettings
	push {r4,r5,r6,r7,lr}	; 02328474
	sub sp,#0xc	; 02328476
	str r0,[sp,#0x0]	; 02328478
	mov r0,#0x0	; 0232847A
	str r0,[sp,#0x4]	; 0232847C
	ldr r5,[pool_02328508]	; 0232847E
	mov r0,#0x4	; 02328480
	ldr r1,[pool_0232850C]	; 02328482
	bl P1_SetPxiReceiveCallback	; 02328484
	mov r6,#0x1	; 02328488
	ldr r4,[pool_02328510]	; 0232848A
	mov r7,#0x80	; 0232848C
loc_0232848E:
	add r0,r6,#0x0	; 0232848E
	ldr r1,[r4,#0x0]	; 02328490
	add r2,r7,#0x0	; 02328492
	add r3,r5,#0x0	; 02328494
	bl loc_02327F18	; 02328496
	cmp r0,#0x0	; 0232849A
	beq loc_0232848E	; 0232849C
	mov r7,#0x1	; 0232849E
	ldr r4,[pool_02328510]	; 023284A0
	ldr r6,[pool_02328514]	; 023284A2
loc_023284A4:
	add r0,r7,#0x0	; 023284A4
	ldr r1,[r4,#0x0]	; 023284A6
	add r1,r1,r6	; 023284A8
	mov r2,#0x80	; 023284AA
	add r3,r5,#0x0	; 023284AC
	add r3,#0x80	; 023284AE
	bl loc_02327F18	; 023284B0
	cmp r0,#0x0	; 023284B4
	beq loc_023284A4	; 023284B6
	add r0,r5,#0x0	; 023284B8
	ldr r1,[pool_02328514]	; 023284BA
	blx P1_InvalidateDataCacheRange	; 023284BC
	add r0,r5,#0x0	; 023284C0
	bl P1_SelectValidUserSettingsCopy	; 023284C2
	cmp r0,#0x0	; 023284C6
	beq loc_023284D4	; 023284C8
	mov r0,#0x1	; 023284CA
	str r0,[sp,#0x4]	; 023284CC
	ldr r1,[pool_02328518]	; 023284CE
	strh r0,[r1,#0x0]	; 023284D0
	b loc_023284FC	; 023284D2
loc_023284D4:
	ldr r0,[pool_0232851C]	; 023284D4
	ldrh r0,[r0,#0x0]	; 023284D6
	lsl r0,r0,#0x7	; 023284D8
	add r0,r5,r0	; 023284DA
	add r1,r0,#0x0	; 023284DC
	add r1,#0x70	; 023284DE
	ldrh r1,[r1,#0x0]	; 023284E0
	add r2,r1,#0x1	; 023284E2
	mov r1,#0x7f	; 023284E4
	and r2,r1	; 023284E6
	lsl r1,r2,#0x18	; 023284E8
	lsr r2,r1,#0x18	; 023284EA
	ldr r1,[pool_02328518]	; 023284EC
	strh r2,[r1,#0x0]	; 023284EE
	ldr r1,[sp,#0x0]	; 023284F0
	cmp r1,#0x0	; 023284F2
	beq loc_023284FC	; 023284F4
	mov r2,#0x38	; 023284F6
	bl loc_0232C76A	; 023284F8
loc_023284FC:
	ldr r0,[sp,#0x4]	; 023284FC
	add sp,#0xc	; 023284FE
	pop {r4,r5,r6,r7}	; 02328500
	pop {r3}	; 02328502
	bx r3	; 02328504
.endfunc
	.byte 0xC0, 0x46	; 02328508
pool_02328508:
loc_02328508:
	.word 0x02355F40	; 02328508
pool_0232850C:
loc_0232850C:
	.word P1_PxiCallback_02327EEC + 1	; 0232850C
pool_02328510:
loc_02328510:
	.word FirmwareBootSharedAddress + BootSharedSettingsFlashOffset	; 02328510
pool_02328514:
loc_02328514:
	.word 0x00000100	; 02328514
pool_02328518:
loc_02328518:
	.word P1_BssStart + 0x25750	; 02328518
pool_0232851C:
loc_0232851C:
	.word P1_Data_02330690	; 0232851C

; ===== function loc_02328520 =====
loc_02328520:
	push {r4,r5}	; 02328520
	mov r4,#0x3	; 02328522
	mov r3,#0x0	; 02328524
loc_02328526:
	ldrb r2,[r0,#0x0]	; 02328526
	ror r3,r4	; 02328528
	mov r5,#0x4	; 0232852A
loc_0232852C:
	eor r3,r2	; 0232852C
	lsl r2,r2,#0x8	; 0232852E
	sub r5,#0x1	; 02328530
	bgt loc_0232852C	; 02328532
	add r0,#0x1	; 02328534
	sub r1,#0x1	; 02328536
	bgt loc_02328526	; 02328538
	add r0,r3,#0x0	; 0232853A
	lsl r0,r0,#0x1b	; 0232853C
	lsr r0,r0,#0x1e	; 0232853E
	pop {r4,r5}	; 02328540
	bx lr	; 02328542

; ===== function loc_02328544 =====
loc_02328544:
	add r2,r0,#0x0	; 02328544
	mov r0,#0x14	; 02328546
	mul r1,r0	; 02328548
	ldr r0,[pool_02328558]	; 0232854A
	add r0,r1,r0	; 0232854C
	add r1,r2,r1	; 0232854E
	mov r2,#0xa	; 02328550
	ldr r3,[pool_0232855C]	; 02328552
	bx r3	; 02328554
	.byte 0xC0, 0x46	; 02328558
pool_02328558:
loc_02328558:
	.word 0x08000004	; 02328558
pool_0232855C:
loc_0232855C:
	.word P1_SwiCpuSet + 1	; 0232855C

; ===== function loc_02328560 =====
loc_02328560:
	push {r4,r5,r6,r7,lr}	; 02328560
	sub sp,#0x4	; 02328562
	add r6,r0,#0x0	; 02328564
	ldr r0,[pool_023285CC]	; 02328566
	ldrb r1,[r0,#0x0]	; 02328568
	mov r0,#0x80	; 0232856A
	and r1,r0	; 0232856C
	cmp r1,#0x0	; 0232856E
	beq loc_02328576	; 02328570
	ldr r0,[pool_023285D0]	; 02328572
	b loc_02328578	; 02328574
loc_02328576:
	ldr r0,[pool_023285D4]	; 02328576
loc_02328578:
	add r1,r6,#0x0	; 02328578
	mov r2,#0xa	; 0232857A
	bl loc_0232C76A	; 0232857C
	ldr r0,[pool_023285D8]	; 02328580
	sub r0,r0,#0x1	; 02328582
	mov r1,#0x1b	; 02328584
	bl loc_02328520	; 02328586
	ldr r3,[pool_023285DC]	; 0232858A
	ldr r1,[pool_023285D8]	; 0232858C
	ldrb r2,[r1,#0x0]	; 0232858E
	mov r1,#0x3	; 02328590
	and r2,r1	; 02328592
	mov r1,#0x30	; 02328594
	mul r2,r1	; 02328596
	add r2,r3,r2	; 02328598
	mov r1,#0xc	; 0232859A
	mul r0,r1	; 0232859C
	add r5,r2,r0	; 0232859E
	mov r4,#0x0	; 023285A0
	ldr r7,[pool_023285E0]	; 023285A2
loc_023285A4:
	add r0,r6,#0x0	; 023285A4
	add r1,r4,#0x0	; 023285A6
	bl loc_02328544	; 023285A8
	cmp r4,#0x3	; 023285AC
	blt loc_023285BC	; 023285AE
	cmp r4,#0x9	; 023285B0
	bge loc_023285BC	; 023285B2
	ldrh r0,[r5,#0x0]	; 023285B4
	add r5,r5,#0x2	; 023285B6
	lsl r0,r0,#0x1	; 023285B8
	ldrh r0,[r0,r7]	; 023285BA
loc_023285BC:
	add r4,r4,#0x1	; 023285BC
	cmp r4,#0xb	; 023285BE
	blt loc_023285A4	; 023285C0
	add sp,#0x4	; 023285C2
	pop {r4,r5,r6,r7}	; 023285C4
	pop {r3}	; 023285C6
	bx r3	; 023285C8
	.byte 0xC0, 0x46	; 023285CC
pool_023285CC:
loc_023285CC:
	.word Slot2BusBaseAddress + 0xB4	; 023285CC
pool_023285D0:
loc_023285D0:
	.word 0x09FE1FE0	; 023285D0
pool_023285D4:
loc_023285D4:
	.word 0x09FFFFE0	; 023285D4
pool_023285D8:
loc_023285D8:
	.word Slot2BusBaseAddress + 0x9E	; 023285D8
pool_023285DC:
loc_023285DC:
	.word 0x02330694	; 023285DC
pool_023285E0:
loc_023285E0:
	.word 0x08000000	; 023285E0

; ===== function loc_023285E4 =====
loc_023285E4:
	push {r4,r5,r6,r7}	; 023285E4
	mov r5,#0x0	; 023285E6
	ldr r3,[pool_0232862C]	; 023285E8
	ldr r2,[pool_02328630]	; 023285EA
	mov r1,#0x3	; 023285EC
	add r4,r2,#0x0	; 023285EE
	eor r4,r1	; 023285F0
	lsl r1,r4,#0x10	; 023285F2
	lsr r1,r1,#0x10	; 023285F4
	mov r6,#0x84	; 023285F6
loc_023285F8:
	add r4,r2,#0x0	; 023285F8
	cmp r5,#0x4c	; 023285FA
	bne loc_02328606	; 023285FC
	eor r4,r6	; 023285FE
	lsl r4,r4,#0x10	; 02328600
	lsr r4,r4,#0x10	; 02328602
	b loc_0232860C	; 02328604
loc_02328606:
	cmp r5,#0x4d	; 02328606
	bne loc_0232860C	; 02328608
	add r4,r1,#0x0	; 0232860A
loc_0232860C:
	ldrh r7,[r0,#0x0]	; 0232860C
	and r4,r7	; 0232860E
	ldrh r7,[r3,#0x0]	; 02328610
	cmp r4,r7	; 02328612
	beq loc_0232861C	; 02328614
	mov r0,#0x0	; 02328616
	pop {r4,r5,r6,r7}	; 02328618
	bx lr	; 0232861A
loc_0232861C:
	add r3,r3,#0x2	; 0232861C
	add r0,r0,#0x2	; 0232861E
	add r5,r5,#0x1	; 02328620
	cmp r5,#0x4e	; 02328622
	blt loc_023285F8	; 02328624
	mov r0,#0x1	; 02328626
	pop {r4,r5,r6,r7}	; 02328628
	bx lr	; 0232862A
pool_0232862C:
loc_0232862C:
	.word 0xFFFF0020	; 0232862C
pool_02328630:
loc_02328630:
	.word 0x0000FFFF	; 02328630

; ===== function loc_02328634 =====
loc_02328634:
	push {r4,lr}	; 02328634
	mov r0,#0x6d	; 02328636
	bl loc_0232B35C	; 02328638
	ldr r0,[pool_02328658]	; 0232863C
	bl loc_02328560	; 0232863E
	ldr r0,[pool_02328658]	; 02328642
	bl loc_023285E4	; 02328644
	add r4,r0,#0x0	; 02328648
	mov r0,#0x6d	; 0232864A
	bl loc_0232B1F4	; 0232864C
	add r0,r4,#0x0	; 02328650
	pop {r4}	; 02328652
	pop {r3}	; 02328654
	bx r3	; 02328656
pool_02328658:
loc_02328658:
	.word 0x02356040	; 02328658

; ===== function loc_0232865C =====
loc_0232865C:
	push {r0,r1,r2,r4,lr}	; 0232865C
	ldr r0,[pool_023286A0]	; 0232865E
	add r1,r2,#0x0	; 02328660
	add r4,r1,#0x0	; 02328662
	mov r2,#0x24	; 02328664
	blx loc_0232DDC4	; 02328666
	ldr r0,[sp,#0x0]	; 0232866A
	mov r2,#0x24	; 0232866C
	add r1,r4,r2	; 0232866E
	mov r2,#0x9c	; 02328670
	blx loc_0232DDC4	; 02328672
	add r0,r4,#0x0	; 02328676
	ldr r1,[sp,#0x4]	; 02328678
	mov r2,#0x1	; 0232867A
	lsl r2,r2,#0x8	; 0232867C
	add r2,r2,r1	; 0232867E
	ldr r3,[pool_023286A4]	; 02328680
	bl loc_0232C78A	; 02328682
	ldr r0,[sp,#0x4]	; 02328686
	ldr r2,[pool_023286A8]	; 02328688
	str r2,[r0,#0x0]	; 0232868A
	add r1,r4,#0x0	; 0232868C
	bl loc_023286B0	; 0232868E
	add r0,r4,#0x0	; 02328692
	ldr r1,[sp,#0x4]	; 02328694
	ldr r2,[pool_023286AC]	; 02328696
	bl loc_0232C77E	; 02328698
	pop {r0,r1,r2,r4,pc}	; 0232869C
	.byte 0xC0, 0x46	; 023286A0
pool_023286A0:
loc_023286A0:
	.word 0x023301BC	; 023286A0
pool_023286A4:
loc_023286A4:
	.word 0x023301A8	; 023286A4
pool_023286A8:
loc_023286A8:
	.word 0x0000D082	; 023286A8
pool_023286AC:
loc_023286AC:
	.word P1_Data_02330754	; 023286AC

; ===== function loc_023286B0 =====
.func P1_SwiDiff16UnFilter
; BIOS SWI #18: differential 16-bit decompression. / BIOS SWI #18：差分 16 位解压。
loc_023286B0:
	swi 0x18	; 023286B0
	bx lr	; 023286B2
.endfunc

; ===== function loc_023286B4 =====
loc_023286B4:
	ldr r0,[r0,#0x0]	; 023286B4
	bx lr	; 023286B6
	ldrb r0,[r0,#0x0]	; 023286B8
	bx lr	; 023286BA
	mov r0,#0x0	; 023286BC
	bx lr	; 023286BE

; ===== function loc_023286C0 =====
	push {lr}	; 023286C0
	sub sp,#0x4	; 023286C2
	cmp r2,#0x0	; 023286C4
	beq loc_023286D2	; 023286C6
	bl loc_023286B4	; 023286C8
	add sp,#0x4	; 023286CC
	pop {r3}	; 023286CE
	bx r3	; 023286D0
loc_023286D2:
	mov r0,#0x0	; 023286D2
	add sp,#0x4	; 023286D4
	pop {r3}	; 023286D6
	bx r3	; 023286D8
	.byte 0x00, 0x00	; 023286DC

; ===== function loc_023286DC =====
loc_023286DC:
	push {r4,r5,r6,lr}	; 023286DC
	sub sp,#0x100	; 023286DE
	add r5,r1,#0x0	; 023286E0
	add r4,r3,#0x0	; 023286E2
	ldr r1,[pool_02328710]	; 023286E4
	ldr r3,[r1,#0x4]	; 023286E6
	ldr r6,[pool_02328714]	; 023286E8
	and r3,r6	; 023286EA
	sub r6,r2,#0x1	; 023286EC
	ldr r2,[pool_02328718]	; 023286EE
	and r6,r2	; 023286F0
	orr r3,r6	; 023286F2
	str r3,[r1,#0x4]	; 023286F4
	add r1,r4,#0x0	; 023286F6
	add r2,sp,#0x0	; 023286F8
	bl loc_0232865C	; 023286FA
	add r0,r4,#0x0	; 023286FE
	add r1,r5,#0x0	; 02328700
	ldr r2,[pool_0232871C]	; 02328702
	blx loc_0232DE58	; 02328704
	add sp,#0x100	; 02328708
	pop {r4,r5,r6}	; 0232870A
	pop {r3}	; 0232870C
	bx r3	; 0232870E
pool_02328710:
loc_02328710:
	.word P1_Data_02330754	; 02328710
pool_02328714:
loc_02328714:
	.word 0x80000000	; 02328714
pool_02328718:
loc_02328718:
	.word 0x7FFFFFFF	; 02328718
pool_0232871C:
loc_0232871C:
	.word 0x00000340	; 0232871C
.arm

; ===== function loc_02328720 =====
loc_02328720:
; 解出 P3/P4/P5；r0=目标、r1=压缩流，返回输出长度。
; Decode P3/P4/P5; r0=destination, r1=stream, returns output size.
.func P1_DecompressP345
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}	; 02328720
	sub sp,sp,#0x4	; 02328724
	ldr r4,[r1,#0x4]	; 02328728
	eor r5,r4,r4, ror #0x10	; 0232872C
	bic r5,r5,#0xff0000	; 02328730
	mov r4,r4, ror #0x8	; 02328734
	eor r4,r4,r5, lsr #0x8	; 02328738
	bic r4,r4,#0xff000000	; 0232873C
	str r4,[sp,#0x0]	; 02328740
	add r5,r0,r4	; 02328744
	ldr r6,[pool_02328B38]	; 02328748
	cmp r5,r6	; 0232874C
	bls loc_02328760	; 02328750
	mov r0,#0x0	; 02328754
	add sp,sp,#0x4	; 02328758
	bl loc_02328A88	; 0232875C
loc_02328760:
	ldr r5,[r1,#0x8]	; 02328760
	eor r6,r5,r5, ror #0x10	; 02328764
	bic r6,r6,#0xff0000	; 02328768
	mov r5,r5, ror #0x8	; 0232876C
	eor r5,r5,r6, lsr #0x8	; 02328770
; 每次重新建立两路状态；共享工作区不可重入。
; Reinitialize both streams for each call; shared workspace is not reentrant.
	ldr r2,[pool_02328B3C]	; 02328774
	add r3,r1,#0xc	; 02328778
	str r3,[r2,#0x10]	; 0232877C
	add r3,r1,r5	; 02328780
	str r3,[r2,#0x14]	; 02328784
	mov r3,#0x0	; 02328788
	str r3,[r2,#0x0]	; 0232878C
	str r3,[r2,#0x4]	; 02328790
	mov r3,#0x200	; 02328794
	str r3,[r2,#0x8]	; 02328798
	mov r3,#0x800	; 0232879C
	str r3,[r2,#0xc]	; 023287A0
	ldr r11,[pool_02328B3C]	; 023287A4
	mov r12,#0x20	; 023287A8
	bl P1_ReadP345Bits	; 023287AC
	ldr r11,[pool_02328B40]	; 023287B0
	mov r12,#0x20	; 023287B4
	bl P1_ReadP345Bits	; 023287B8
; 先构建 9 位字面量/长度树，子节点为 16 位表项。
; Build the 9-bit literal/length tree with 16-bit child entries.
	ldr r11,[pool_02328B3C]	; 023287BC
	ldr r2,[pool_02328B44]	; 023287C0
	mov r1,r2	; 023287C4
	ldr r5,[r11,#0x8]	; 023287C8
	mov r6,r5	; 023287CC
loc_023287D0:
	ldr r8,[r11,#0x0]	; 023287D0
	ldr r9,[r11,#0x10]	; 023287D4
	ldr r10,[r11,#0x18]	; 023287D8
	mov r7,r10, lsr #0x1f	; 023287DC
	cmp r8,#0x1f	; 023287E0
	bne loc_02328808	; 023287E4
	ldr r3,[r9],#0x4	; 023287E8
	eor r10,r3,r3, ror #0x10	; 023287EC
	bic r10,r10,#0xff0000	; 023287F0
	mov r3,r3, ror #0x8	; 023287F4
	eor r3,r3,r10, lsr #0x8	; 023287F8
	str r9,[r11,#0x10]	; 023287FC
	mov r8,#0x0	; 02328800
	b loc_02328810	; 02328804
loc_02328808:
	mov r3,r10, lsl #0x1	; 02328808
	add r8,r8,#0x1	; 0232880C
loc_02328810:
	str r3,[r11,#0x18]	; 02328810
	str r8,[r11,#0x0]	; 02328814
	cmp r7,#0x0	; 02328818
	beq loc_0232883C	; 0232881C
	orr r8,r5,#0x8000	; 02328820
	orr r9,r5,#0x4000	; 02328824
	strh r8,[r2],#0x2	; 02328828
	strh r9,[r2],#0x2	; 0232882C
	add r5,r5,#0x1	; 02328830
	add r6,r6,#0x1	; 02328834
	b loc_023287D0	; 02328838
loc_0232883C:
	mov r12,#0x9	; 0232883C
	bl P1_ReadP345Bits	; 02328840
	mov r10,#0x4000	; 02328844
	ldr r12,[pool_02328B48]	; 02328848
	ldr r3,[pool_02328B4C]	; 0232884C
	sub r10,r10,#0x1	; 02328850
loc_02328854:
	ldrh r8,[r2,#-0x2]!	; 02328854
	and r9,r8,r10	; 02328858
	mov lr,r9, lsl #0x1	; 0232885C
	tst r8,#0x8000	; 02328860
	beq loc_0232887C	; 02328864
	strh r7,[r3,lr]	; 02328868
	mov r7,r9	; 0232886C
	cmp r2,r1	; 02328870
	bne loc_02328854	; 02328874
	b loc_02328888	; 02328878
loc_0232887C:
	strh r7,[r12,lr]	; 0232887C
	mov r5,r6	; 02328880
	b loc_023287D0	; 02328884
loc_02328888:
	str r7,[r11,#0x20]	; 02328888
; 复用临时栈构建 11 位距离树，不覆盖前一棵树。
; Reuse the temporary stack for the 11-bit distance tree, preserving the first tree.
	ldr r11,[pool_02328B40]	; 0232888C
	ldr r2,[pool_02328B44]	; 02328890
	mov r1,r2	; 02328894
	ldr r5,[r11,#0x8]	; 02328898
	mov r6,r5	; 0232889C
loc_023288A0:
	ldr r8,[r11,#0x0]	; 023288A0
	ldr r9,[r11,#0x10]	; 023288A4
	ldr r10,[r11,#0x18]	; 023288A8
	mov r7,r10, lsr #0x1f	; 023288AC
	cmp r8,#0x1f	; 023288B0
	bne loc_023288D8	; 023288B4
	ldr r3,[r9],#0x4	; 023288B8
	eor r10,r3,r3, ror #0x10	; 023288BC
	bic r10,r10,#0xff0000	; 023288C0
	mov r3,r3, ror #0x8	; 023288C4
	eor r3,r3,r10, lsr #0x8	; 023288C8
	str r9,[r11,#0x10]	; 023288CC
	mov r8,#0x0	; 023288D0
	b loc_023288E0	; 023288D4
loc_023288D8:
	mov r3,r10, lsl #0x1	; 023288D8
	add r8,r8,#0x1	; 023288DC
loc_023288E0:
	str r3,[r11,#0x18]	; 023288E0
	str r8,[r11,#0x0]	; 023288E4
	cmp r7,#0x0	; 023288E8
	beq loc_0232890C	; 023288EC
	orr r8,r5,#0x8000	; 023288F0
	orr r9,r5,#0x4000	; 023288F4
	strh r8,[r2],#0x2	; 023288F8
	strh r9,[r2],#0x2	; 023288FC
	add r5,r5,#0x1	; 02328900
	add r6,r6,#0x1	; 02328904
	b loc_023288A0	; 02328908
loc_0232890C:
	mov r12,#0xb	; 0232890C
	bl P1_ReadP345Bits	; 02328910
	mov r10,#0x4000	; 02328914
	ldr r12,[pool_02328B50]	; 02328918
	ldr r3,[pool_02328B54]	; 0232891C
	sub r10,r10,#0x1	; 02328920
loc_02328924:
	ldrh r8,[r2,#-0x2]!	; 02328924
	and r9,r8,r10	; 02328928
	mov lr,r9, lsl #0x1	; 0232892C
	tst r8,#0x8000	; 02328930
	beq loc_0232894C	; 02328934
	strh r7,[r3,lr]	; 02328938
	mov r7,r9	; 0232893C
	cmp r2,r1	; 02328940
	bne loc_02328924	; 02328944
	b loc_02328958	; 02328948
loc_0232894C:
	strh r7,[r12,lr]	; 0232894C
	mov r5,r6	; 02328950
	b loc_023288A0	; 02328954
loc_02328958:
	str r7,[r11,#0x20]	; 02328958
loc_0232895C:
; 小于 0x100 的值直接输出；否则长度=值-0xFD，回距=距离值+1。
; Values below 0x100 are literals; otherwise length=value-0xFD, distance=distance value+1.
	cmp r4,#0x0	; 0232895C
	beq loc_02328A84	; 02328960
	ldr r11,[pool_02328B3C]	; 02328964
	ldr r1,[pool_02328B48]	; 02328968
	ldr r2,[pool_02328B4C]	; 0232896C
	ldr r5,[r11,#0x20]	; 02328970
	ldr r8,[r11,#0x0]	; 02328974
	ldr r9,[r11,#0x10]	; 02328978
	ldr r10,[r11,#0x18]	; 0232897C
loc_02328980:
	cmp r5,#0x200	; 02328980
	bcc loc_023289CC	; 02328984
	mov r7,r10, lsr #0x1f	; 02328988
	cmp r8,#0x1f	; 0232898C
	bne loc_023289B0	; 02328990
	ldr r10,[r9],#0x4	; 02328994
	eor r3,r10,r10, ror #0x10	; 02328998
	bic r3,r3,#0xff0000	; 0232899C
	mov r10,r10, ror #0x8	; 023289A0
	eor r10,r10,r3, lsr #0x8	; 023289A4
	mov r8,#0x0	; 023289A8
	b loc_023289B8	; 023289AC
loc_023289B0:
	mov r10,r10, lsl #0x1	; 023289B0
	add r8,r8,#0x1	; 023289B4
loc_023289B8:
	mov r3,r5, lsl #0x1	; 023289B8
	cmp r7,#0x0	; 023289BC
	ldreqh r5,[r1,r3]	; 023289C0
	ldrneh r5,[r2,r3]	; 023289C4
	b loc_02328980	; 023289C8
loc_023289CC:
	str r8,[r11,#0x0]	; 023289CC
	str r9,[r11,#0x10]	; 023289D0
	str r10,[r11,#0x18]	; 023289D4
	cmp r5,#0x100	; 023289D8
	bcs loc_023289EC	; 023289DC
	strb r5,[r0],#0x1	; 023289E0
	sub r4,r4,#0x1	; 023289E4
	b loc_0232895C	; 023289E8
loc_023289EC:
	ldr r11,[pool_02328B40]	; 023289EC
	ldr r1,[pool_02328B50]	; 023289F0
	ldr r2,[pool_02328B54]	; 023289F4
	ldr r6,[r11,#0x20]	; 023289F8
	ldr r8,[r11,#0x0]	; 023289FC
	ldr r9,[r11,#0x10]	; 02328A00
	ldr r10,[r11,#0x18]	; 02328A04
loc_02328A08:
	cmp r6,#0x800	; 02328A08
	bcc loc_02328A54	; 02328A0C
	mov r7,r10, lsr #0x1f	; 02328A10
	cmp r8,#0x1f	; 02328A14
	bne loc_02328A38	; 02328A18
	ldr r10,[r9],#0x4	; 02328A1C
	eor r3,r10,r10, ror #0x10	; 02328A20
	bic r3,r3,#0xff0000	; 02328A24
	mov r10,r10, ror #0x8	; 02328A28
	eor r10,r10,r3, lsr #0x8	; 02328A2C
	mov r8,#0x0	; 02328A30
	b loc_02328A40	; 02328A34
loc_02328A38:
	mov r10,r10, lsl #0x1	; 02328A38
	add r8,r8,#0x1	; 02328A3C
loc_02328A40:
	mov r3,r6, lsl #0x1	; 02328A40
	cmp r7,#0x0	; 02328A44
	ldreqh r6,[r1,r3]	; 02328A48
	ldrneh r6,[r2,r3]	; 02328A4C
	b loc_02328A08	; 02328A50
loc_02328A54:
	str r8,[r11,#0x0]	; 02328A54
	str r9,[r11,#0x10]	; 02328A58
	str r10,[r11,#0x18]	; 02328A5C
	sub r3,r0,r6	; 02328A60
	sub r5,r5,#0xfd	; 02328A64
	sub r3,r3,#0x1	; 02328A68
	sub r4,r4,r5	; 02328A6C
loc_02328A70:
	ldrb r11,[r3],#0x1	; 02328A70
	subs r5,r5,#0x1	; 02328A74
	strb r11,[r0],#0x1	; 02328A78
	bne loc_02328A70	; 02328A7C
	b loc_0232895C	; 02328A80
loc_02328A84:
	ldr r0,[sp],#0x4	; 02328A84

; 共用返回尾部。 / Shared return epilogue.
loc_02328A88:
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}	; 02328A88
	bx lr	; 02328A8C
.endfunc

; ===== function loc_02328A90 =====
loc_02328A90:
; 从 r11 指定的位流取 r12 位到 r7，并推进游标。
; Read r12 bits into r7 from the r11 stream context; advance its cursor.
.func P1_ReadP345Bits
	ldr r8,[r11,#0x0]	; 02328A90
	ldr r9,[r11,#0x10]	; 02328A94
	ldr r10,[r11,#0x18]	; 02328A98
	mov r7,#0x20	; 02328A9C
	sub r7,r7,r12	; 02328AA0
	mov r7,r10, lsr r7	; 02328AA4
	add r3,r8,r12	; 02328AA8
	cmp r3,#0x20	; 02328AAC
	beq loc_02328AFC	; 02328AB0
	bcc loc_02328B24	; 02328AB4
	ldr r3,[r9],#0x4	; 02328AB8
	eor r10,r3,r3, ror #0x10	; 02328ABC
	bic r10,r10,#0xff0000	; 02328AC0
	mov r3,r3, ror #0x8	; 02328AC4
	eor r3,r3,r10, lsr #0x8	; 02328AC8
	str r9,[r11,#0x10]	; 02328ACC
	mov r10,#0x40	; 02328AD0
	sub r9,r10,r12	; 02328AD4
	sub r9,r9,r8	; 02328AD8
	mov r9,r3, lsr r9	; 02328ADC
	orr r7,r7,r9	; 02328AE0
	sub r12,r12,#0x20	; 02328AE4
	add r8,r8,r12	; 02328AE8
	str r8,[r11,#0x0]	; 02328AEC
	mov r12,r3, lsl r8	; 02328AF0
	str r12,[r11,#0x18]	; 02328AF4
	bx lr	; 02328AF8
loc_02328AFC:
	ldr r3,[r9],#0x4	; 02328AFC
	eor r10,r3,r3, ror #0x10	; 02328B00
	bic r10,r10,#0xff0000	; 02328B04
	mov r3,r3, ror #0x8	; 02328B08
	eor r3,r3,r10, lsr #0x8	; 02328B0C
	str r9,[r11,#0x10]	; 02328B10
	str r3,[r11,#0x18]	; 02328B14
	mov r3,#0x0	; 02328B18
	str r3,[r11,#0x0]	; 02328B1C
	bx lr	; 02328B20
loc_02328B24:
	mov r3,r10, lsl r12	; 02328B24
	str r3,[r11,#0x18]	; 02328B28
	add r10,r8,r12	; 02328B2C
	str r10,[r11,#0x0]	; 02328B30
	bx lr	; 02328B34
.endfunc
pool_02328B38:
loc_02328B38:
	.word P345DecodeOutputLimitAddress	; 02328B38
pool_02328B3C:
loc_02328B3C:
	.word P1_P345DecodeWorkspace	; 02328B3C
pool_02328B40:
loc_02328B40:
	.word P1_P345DecodeWorkspace + 4	; 02328B40
pool_02328B44:
loc_02328B44:
	.word P1_P345TreeStack	; 02328B44
pool_02328B48:
loc_02328B48:
	.word P1_P345LengthZeroChildren	; 02328B48
pool_02328B4C:
loc_02328B4C:
	.word P1_P345LengthOneChildren	; 02328B4C
pool_02328B50:
loc_02328B50:
	.word P1_P345DistanceZeroChildren	; 02328B50
pool_02328B54:
loc_02328B54:
	.word P1_P345DistanceOneChildren	; 02328B54
.thumb

; ===== function loc_02328B58 =====
loc_02328B58:
	push {r4,lr}	; 02328B58
	add r4,r0,#0x0	; 02328B5A
	bl loc_02328F04	; 02328B5C
	ldrh r1,[r4,#0x12]	; 02328B60
	cmp r0,r1	; 02328B62
	beq loc_02328B70	; 02328B64
	strh r0,[r4,#0x12]	; 02328B66
	mov r0,#0x1	; 02328B68
	pop {r4}	; 02328B6A
	pop {r3}	; 02328B6C
	bx r3	; 02328B6E
loc_02328B70:
	mov r0,#0x0	; 02328B70
	pop {r4}	; 02328B72
	pop {r3}	; 02328B74
	bx r3	; 02328B76

; ===== function loc_02328B78 =====
P1_Entry_02328B78:
	push {r4,lr}	; 02328B78
	add r4,r0,#0x0	; 02328B7A
	bl loc_02328F04	; 02328B7C
	ldr r1,[r4,#0xc]	; 02328B80
	lsl r0,r0,#0x1	; 02328B82
	ldrb r0,[r1,r0]	; 02328B84
	pop {r4}	; 02328B86
	pop {r3}	; 02328B88
	bx r3	; 02328B8A

; ===== function loc_02328B8C =====
loc_02328B8C:
	ldrh r0,[r0,#0x16]	; 02328B8C
	lsl r0,r0,#0x16	; 02328B8E
	lsr r0,r0,#0x1b	; 02328B90
	ldrh r3,[r1,#0x0]	; 02328B92
	cmp r3,#0x0	; 02328B94
	beq loc_02328BA8	; 02328B96
	add r2,r2,r0	; 02328B98
loc_02328B9A:
	cmp r3,#0xa	; 02328B9A
	bne loc_02328BA0	; 02328B9C
	add r0,r0,r2	; 02328B9E
loc_02328BA0:
	add r1,r1,#0x2	; 02328BA0
	ldrh r3,[r1,#0x0]	; 02328BA2
	cmp r3,#0x0	; 02328BA4
	bne loc_02328B9A	; 02328BA6
loc_02328BA8:
	bx lr	; 02328BA8
	.byte 0x00, 0x00	; 02328BAC

; ===== function loc_02328BAC =====
loc_02328BAC:
	push {r4,r5,r6,r7,lr}	; 02328BAC
	sub sp,#0x4	; 02328BAE
	add r5,r0,#0x0	; 02328BB0
	add r6,r2,#0x0	; 02328BB2
	mov r4,#0x0	; 02328BB4
	str r4,[sp,#0x0]	; 02328BB6
	cmp r1,#0x0	; 02328BB8
	beq loc_02328BD6	; 02328BBA
	add r7,sp,#0x0	; 02328BBC
loc_02328BBE:
	add r0,r5,#0x0	; 02328BBE
	add r2,r7,#0x0	; 02328BC0
	add r3,r6,#0x0	; 02328BC2
	bl loc_02328BE0	; 02328BC4
	add r1,r0,#0x0	; 02328BC8
	ldr r0,[sp,#0x0]	; 02328BCA
	cmp r4,r0	; 02328BCC
	bge loc_02328BD2	; 02328BCE
	add r4,r0,#0x0	; 02328BD0
loc_02328BD2:
	cmp r1,#0x0	; 02328BD2
	bne loc_02328BBE	; 02328BD4
loc_02328BD6:
	add r0,r4,#0x0	; 02328BD6
	add sp,#0x4	; 02328BD8
	pop {r4,r5,r6,r7}	; 02328BDA
	pop {r3}	; 02328BDC
	bx r3	; 02328BDE

; ===== function loc_02328BE0 =====
loc_02328BE0:
	push {r4,r5,r6,r7,lr}	; 02328BE0
	sub sp,#0x4	; 02328BE2
	add r7,r0,#0x0	; 02328BE4
	add r5,r1,#0x0	; 02328BE6
	str r2,[sp,#0x0]	; 02328BE8
	add r6,r3,#0x0	; 02328BEA
	mov r4,#0x0	; 02328BEC
	ldrh r1,[r5,#0x0]	; 02328BEE
	cmp r1,#0x0	; 02328BF0
	beq loc_02328C28	; 02328BF2
loc_02328BF4:
	cmp r1,#0xa	; 02328BF4
	bne loc_02328C12	; 02328BF6
	ldr r0,[sp,#0x0]	; 02328BF8
	cmp r0,#0x0	; 02328BFA
	beq loc_02328C08	; 02328BFC
	cmp r4,r6	; 02328BFE
	ble loc_02328C04	; 02328C00
	sub r4,r4,r6	; 02328C02
loc_02328C04:
	ldr r0,[sp,#0x0]	; 02328C04
	str r4,[r0,#0x0]	; 02328C06
loc_02328C08:
	add r0,r5,#0x2	; 02328C08
	add sp,#0x4	; 02328C0A
	pop {r4,r5,r6,r7}	; 02328C0C
	pop {r3}	; 02328C0E
	bx r3	; 02328C10
loc_02328C12:
	cmp r1,#0xd	; 02328C12
	beq loc_02328C20	; 02328C14
	add r0,r7,#0x0	; 02328C16
	bl loc_02328C44	; 02328C18
	add r0,r6,r0	; 02328C1C
	add r4,r4,r0	; 02328C1E
loc_02328C20:
	add r5,r5,#0x2	; 02328C20
	ldrh r1,[r5,#0x0]	; 02328C22
	cmp r1,#0x0	; 02328C24
	bne loc_02328BF4	; 02328C26
loc_02328C28:
	ldr r0,[sp,#0x0]	; 02328C28
	cmp r0,#0x0	; 02328C2A
	beq loc_02328C38	; 02328C2C
	cmp r4,r6	; 02328C2E
	ble loc_02328C34	; 02328C30
	sub r4,r4,r6	; 02328C32
loc_02328C34:
	ldr r0,[sp,#0x0]	; 02328C34
	str r4,[r0,#0x0]	; 02328C36
loc_02328C38:
	mov r0,#0x0	; 02328C38
	add sp,#0x4	; 02328C3A
	pop {r4,r5,r6,r7}	; 02328C3C
	pop {r3}	; 02328C3E
	bx r3	; 02328C40
	.byte 0x00, 0x00	; 02328C44

; ===== function loc_02328C44 =====
loc_02328C44:
	push {r4,lr}	; 02328C44
	add r4,r0,#0x0	; 02328C46
	bl loc_02328F04	; 02328C48
	ldr r1,[r4,#0xc]	; 02328C4C
	lsl r0,r0,#0x1	; 02328C4E
	add r0,r1,r0	; 02328C50
	ldrb r0,[r0,#0x1]	; 02328C52
	pop {r4}	; 02328C54
	pop {r3}	; 02328C56
	bx r3	; 02328C58
	.byte 0x00, 0x00	; 02328C5C

; ===== function loc_02328C5C =====
loc_02328C5C:
	push {r0,r1,r2,r3}	; 02328C5C
	push {r4,r5,r6,r7,lr}	; 02328C5E
	sub sp,#0x1c	; 02328C60
	add r5,r0,#0x0	; 02328C62
	str r1,[sp,#0x8]	; 02328C64
	ldr r1,[sp,#0x40]	; 02328C66
	str r1,[sp,#0x40]	; 02328C68
	ldr r1,[sp,#0x44]	; 02328C6A
	str r1,[sp,#0x44]	; 02328C6C
	ldr r6,[sp,#0x48]	; 02328C6E
	ldr r1,[sp,#0x4c]	; 02328C70
	str r1,[sp,#0x4c]	; 02328C72
	add r1,r6,#0x0	; 02328C74
	ldr r2,[sp,#0x40]	; 02328C76
	bl loc_02328BAC	; 02328C78
	add r4,r0,#0x0	; 02328C7C
	add r0,r5,#0x0	; 02328C7E
	add r1,r6,#0x0	; 02328C80
	ldr r2,[sp,#0x44]	; 02328C82
	bl loc_02328B8C	; 02328C84
	str r0,[sp,#0x14]	; 02328C88
	mov r1,sp	; 02328C8A
	sub r1,r1,#0x4	; 02328C8C
	add r0,sp,#0x30	; 02328C8E
	ldrh r0,[r0,#0x8]	; 02328C90
	strh r0,[r1,#0x0]	; 02328C92
	ldmia r1!,{r0}	; 02328C94
	add r1,r4,#0x0	; 02328C96
	bl loc_02329074	; 02328C98
	add r7,r0,#0x0	; 02328C9C
	mov r1,sp	; 02328C9E
	sub r1,r1,#0x4	; 02328CA0
	add r0,sp,#0x30	; 02328CA2
	ldrh r0,[r0,#0xc]	; 02328CA4
	strh r0,[r1,#0x0]	; 02328CA6
	ldmia r1!,{r0}	; 02328CA8
	ldr r1,[sp,#0x14]	; 02328CAA
	bl loc_0232903C	; 02328CAC
	str r0,[sp,#0x10]	; 02328CB0
	mov r1,sp	; 02328CB2
	sub r1,r1,#0x4	; 02328CB4
	add r0,sp,#0x30	; 02328CB6
	ldrh r0,[r0,#0x8]	; 02328CB8
	strh r0,[r1,#0x0]	; 02328CBA
	ldmia r1!,{r0}	; 02328CBC
	add r1,r4,#0x0	; 02328CBE
	bl loc_02328D6C	; 02328CC0
	add r4,r7,r0	; 02328CC4
	str r4,[sp,#0xc]	; 02328CC6
	add r0,r5,#0x0	; 02328CC8
	add r1,r6,#0x0	; 02328CCA
	add r2,sp,#0x18	; 02328CCC
	ldr r3,[sp,#0x40]	; 02328CCE
	bl loc_02328BE0	; 02328CD0
	mov r1,sp	; 02328CD4
	sub r1,r1,#0x4	; 02328CD6
	add r0,sp,#0x30	; 02328CD8
	ldrh r0,[r0,#0x8]	; 02328CDA
	strh r0,[r1,#0x0]	; 02328CDC
	ldmia r1!,{r0}	; 02328CDE
	ldr r1,[sp,#0x18]	; 02328CE0
	bl loc_02328D6C	; 02328CE2
	sub r4,r4,r0	; 02328CE6
	ldrh r1,[r6,#0x0]	; 02328CE8
	cmp r1,#0x0	; 02328CEA
	beq loc_02328D60	; 02328CEC
loc_02328CEE:
	cmp r1,#0xa	; 02328CEE
	bne loc_02328D26	; 02328CF0
	add r0,r5,#0x0	; 02328CF2
	add r1,r6,#0x2	; 02328CF4
	add r2,sp,#0x18	; 02328CF6
	ldr r3,[sp,#0x40]	; 02328CF8
	bl loc_02328BE0	; 02328CFA
	mov r1,sp	; 02328CFE
	sub r1,r1,#0x4	; 02328D00
	add r0,sp,#0x30	; 02328D02
	ldrh r0,[r0,#0x8]	; 02328D04
	strh r0,[r1,#0x0]	; 02328D06
	ldmia r1!,{r0}	; 02328D08
	ldr r1,[sp,#0x18]	; 02328D0A
	bl loc_02328D6C	; 02328D0C
	ldr r1,[sp,#0xc]	; 02328D10
	sub r4,r1,r0	; 02328D12
	ldrh r0,[r5,#0x16]	; 02328D14
	lsl r0,r0,#0x16	; 02328D16
	lsr r1,r0,#0x1b	; 02328D18
	ldr r0,[sp,#0x44]	; 02328D1A
	add r1,r1,r0	; 02328D1C
	ldr r0,[sp,#0x10]	; 02328D1E
	add r0,r0,r1	; 02328D20
	str r0,[sp,#0x10]	; 02328D22
	b loc_02328D58	; 02328D24
loc_02328D26:
	cmp r1,#0xd	; 02328D26
	beq loc_02328D58	; 02328D28
	add r0,r5,#0x0	; 02328D2A
	bl loc_02328F04	; 02328D2C
	lsl r0,r0,#0x10	; 02328D30
	lsr r0,r0,#0x10	; 02328D32
	lsl r7,r0,#0x1	; 02328D34
	str r0,[sp,#0x0]	; 02328D36
	ldr r0,[sp,#0x4c]	; 02328D38
	str r0,[sp,#0x4]	; 02328D3A
	add r0,r5,#0x0	; 02328D3C
	ldr r1,[sp,#0x8]	; 02328D3E
	ldr r2,[r5,#0xc]	; 02328D40
	ldrb r2,[r2,r7]	; 02328D42
	sub r2,r4,r2	; 02328D44
	ldr r3,[sp,#0x10]	; 02328D46
	bl loc_02328DA0	; 02328D48
	ldr r0,[r5,#0xc]	; 02328D4C
	add r0,r0,r7	; 02328D4E
	ldrb r1,[r0,#0x1]	; 02328D50
	ldr r0,[sp,#0x40]	; 02328D52
	add r0,r0,r1	; 02328D54
	add r4,r4,r0	; 02328D56
loc_02328D58:
	add r6,r6,#0x2	; 02328D58
	ldrh r1,[r6,#0x0]	; 02328D5A
	cmp r1,#0x0	; 02328D5C
	bne loc_02328CEE	; 02328D5E
loc_02328D60:
	add sp,#0x1c	; 02328D60
	pop {r4,r5,r6,r7}	; 02328D62
	pop {r3}	; 02328D64
	add sp,#0x10	; 02328D66
	bx r3	; 02328D68
	.byte 0x00, 0x00	; 02328D6C

; ===== function loc_02328D6C =====
loc_02328D6C:
	push {r0,r1,r2,r3}	; 02328D6C
	push {lr}	; 02328D6E
	sub sp,#0x4	; 02328D70
	add r0,sp,#0x8	; 02328D72
	ldrh r0,[r0,#0x0]	; 02328D74
	lsl r0,r0,#0x10	; 02328D76
	lsr r0,r0,#0x1e	; 02328D78
	cmp r0,#0x1	; 02328D7A
	bne loc_02328D8E	; 02328D7C
	add r0,r1,#0x1	; 02328D7E
	mov r1,#0x2	; 02328D80
	blx P1_SignedDivMod	; 02328D82
	add sp,#0x4	; 02328D86
	pop {r3}	; 02328D88
	add sp,#0x10	; 02328D8A
	bx r3	; 02328D8C
loc_02328D8E:
	cmp r0,#0x2	; 02328D8E
	beq loc_02328D94	; 02328D90
	mov r1,#0x0	; 02328D92
loc_02328D94:
	add r0,r1,#0x0	; 02328D94
	add sp,#0x4	; 02328D96
	pop {r3}	; 02328D98
	add sp,#0x10	; 02328D9A
	bx r3	; 02328D9C
	.byte 0x00, 0x00	; 02328DA0

; ===== function loc_02328DA0 =====
loc_02328DA0:
	push {r4,r5,r6,r7,lr}	; 02328DA0
	sub sp,#0x2c	; 02328DA2
	str r1,[sp,#0x0]	; 02328DA4
	str r2,[sp,#0x4]	; 02328DA6
	str r3,[sp,#0x8]	; 02328DA8
	ldr r1,[sp,#0x44]	; 02328DAA
	str r1,[sp,#0x44]	; 02328DAC
	mov r5,#0x0	; 02328DAE
	add r4,r5,#0x0	; 02328DB0
	ldrh r2,[r0,#0x16]	; 02328DB2
	add r1,sp,#0x24	; 02328DB4
	strh r2,[r1,#0x0]	; 02328DB6
	ldr r2,[r0,#0x0]	; 02328DB8
	mov r3,#0x14	; 02328DBA
	ldrsh r3,[r0,r3]	; 02328DBC
	add r0,sp,#0x30	; 02328DBE
	ldrh r0,[r0,#0x10]	; 02328DC0
	mul r3,r0	; 02328DC2
	lsl r0,r3,#0x1	; 02328DC4
	add r7,r2,r0	; 02328DC6
	str r5,[sp,#0xc]	; 02328DC8
	ldrh r1,[r1,#0x0]	; 02328DCA
	lsl r0,r1,#0x16	; 02328DCC
	lsr r0,r0,#0x1b	; 02328DCE
	str r0,[sp,#0x14]	; 02328DD0
	cmp r0,#0x0	; 02328DD2
	ble loc_02328E34	; 02328DD4
	lsl r0,r1,#0x1b	; 02328DD6
	lsr r0,r0,#0x1b	; 02328DD8
	str r0,[sp,#0x10]	; 02328DDA
	str r5,[sp,#0x20]	; 02328DDC
	str r5,[sp,#0x1c]	; 02328DDE
loc_02328DE0:
	ldr r6,[sp,#0x1c]	; 02328DE0
	ldr r0,[sp,#0x10]	; 02328DE2
	cmp r0,#0x0	; 02328DE4
	ble loc_02328E28	; 02328DE6
	ldr r1,[sp,#0x8]	; 02328DE8
	ldr r0,[sp,#0xc]	; 02328DEA
	add r0,r1,r0	; 02328DEC
	str r0,[sp,#0x18]	; 02328DEE
loc_02328DF0:
	cmp r4,#0x0	; 02328DF0
	bne loc_02328DF6	; 02328DF2
	ldrh r5,[r7,#0x0]	; 02328DF4
loc_02328DF6:
	add r1,r5,#0x0	; 02328DF6
	mov r0,#0x1	; 02328DF8
	and r1,r0	; 02328DFA
	cmp r1,#0x0	; 02328DFC
	bne loc_02328E0E	; 02328DFE
	ldr r0,[sp,#0x0]	; 02328E00
	ldr r1,[sp,#0x4]	; 02328E02
	add r1,r1,r6	; 02328E04
	ldr r2,[sp,#0x18]	; 02328E06
	ldr r3,[sp,#0x44]	; 02328E08
	bl loc_02328E70	; 02328E0A
loc_02328E0E:
	lsl r0,r5,#0xf	; 02328E0E
	lsr r5,r0,#0x10	; 02328E10
	add r0,r4,#0x1	; 02328E12
	lsl r0,r0,#0x10	; 02328E14
	lsr r4,r0,#0x10	; 02328E16
	cmp r4,#0xf	; 02328E18
	bls loc_02328E20	; 02328E1A
	ldr r4,[sp,#0x20]	; 02328E1C
	add r7,r7,#0x2	; 02328E1E
loc_02328E20:
	add r6,r6,#0x1	; 02328E20
	ldr r0,[sp,#0x10]	; 02328E22
	cmp r6,r0	; 02328E24
	blt loc_02328DF0	; 02328E26
loc_02328E28:
	ldr r0,[sp,#0xc]	; 02328E28
	add r1,r0,#0x1	; 02328E2A
	str r1,[sp,#0xc]	; 02328E2C
	ldr r0,[sp,#0x14]	; 02328E2E
	cmp r1,r0	; 02328E30
	blt loc_02328DE0	; 02328E32
loc_02328E34:
	add sp,#0x2c	; 02328E34
	pop {r4,r5,r6,r7}	; 02328E36
	pop {r3}	; 02328E38
	bx r3	; 02328E3A

; ===== function loc_02328E3C =====
P1_Entry_02328E3C:
	push {r4,r5,r6,r7,lr}	; 02328E3C
	sub sp,#0xc	; 02328E3E
	add r5,r0,#0x0	; 02328E40
	add r4,r1,#0x0	; 02328E42
	add r6,r2,#0x0	; 02328E44
	add r7,r3,#0x0	; 02328E46
	add r1,sp,#0x10	; 02328E48
	ldrh r1,[r1,#0x10]	; 02328E4A
	bl loc_02328F04	; 02328E4C
	lsl r0,r0,#0x10	; 02328E50
	lsr r0,r0,#0x10	; 02328E52
	str r0,[sp,#0x0]	; 02328E54
	ldr r0,[sp,#0x24]	; 02328E56
	str r0,[sp,#0x4]	; 02328E58
	add r0,r5,#0x0	; 02328E5A
	add r1,r4,#0x0	; 02328E5C
	add r2,r6,#0x0	; 02328E5E
	add r3,r7,#0x0	; 02328E60
	bl loc_02328DA0	; 02328E62
	add sp,#0xc	; 02328E66
	pop {r4,r5,r6,r7}	; 02328E68
	pop {r3}	; 02328E6A
	bx r3	; 02328E6C
	.byte 0x00, 0x00	; 02328E70

; ===== function loc_02328E70 =====
loc_02328E70:
	push {r4,lr}	; 02328E70
	ldrh r4,[r0,#0x8]	; 02328E72
	cmp r4,#0x0	; 02328E74
	bne loc_02328E7C	; 02328E76
	bl loc_02328E84	; 02328E78
loc_02328E7C:
	pop {r4}	; 02328E7C
	pop {r3}	; 02328E7E
	bx r3	; 02328E80
	.byte 0x00, 0x00	; 02328E84

; ===== function loc_02328E84 =====
loc_02328E84:
	push {r4,r5,r6,r7}	; 02328E84
	sub sp,#0x18	; 02328E86
	add r4,r0,#0x0	; 02328E88
	add r0,r1,#0x0	; 02328E8A
	add r5,r2,#0x0	; 02328E8C
	str r3,[sp,#0x0]	; 02328E8E
	asr r3,r0,#0x3	; 02328E90
	asr r7,r5,#0x3	; 02328E92
	mov r2,#0x3	; 02328E94
	str r1,[sp,#0x10]	; 02328E96
	and r1,r2	; 02328E98
	str r1,[sp,#0x10]	; 02328E9A
	asr r2,r0,#0x2	; 02328E9C
	mov r1,#0x1	; 02328E9E
	and r2,r1	; 02328EA0
	mov r6,#0x7	; 02328EA2
	add r1,r5,#0x0	; 02328EA4
	str r1,[sp,#0x4]	; 02328EA6
	and r1,r6	; 02328EA8
	str r1,[sp,#0x4]	; 02328EAA
	ldrh r1,[r4,#0x4]	; 02328EAC
	str r1,[sp,#0x8]	; 02328EAE
	lsl r1,r1,#0x4	; 02328EB0
	asr r1,r1,#0x3	; 02328EB2
	ldr r6,[r4,#0x0]	; 02328EB4
	str r6,[sp,#0xc]	; 02328EB6
	cmp r0,#0x0	; 02328EB8
	blt loc_02328EFC	; 02328EBA
	ldr r6,[sp,#0x8]	; 02328EBC
	cmp r0,r6	; 02328EBE
	bge loc_02328EFC	; 02328EC0
	cmp r5,#0x0	; 02328EC2
	blt loc_02328EFC	; 02328EC4
	ldrh r0,[r4,#0x6]	; 02328EC6
	cmp r5,r0	; 02328EC8
	bge loc_02328EFC	; 02328ECA
	lsl r0,r3,#0x4	; 02328ECC
	mul r1,r7	; 02328ECE
	add r0,r0,r1	; 02328ED0
	lsl r1,r0,#0x1	; 02328ED2
	ldr r0,[sp,#0xc]	; 02328ED4
	add r4,r0,r1	; 02328ED6
	ldr r0,[sp,#0x4]	; 02328ED8
	lsl r0,r0,#0x1	; 02328EDA
	add r0,r2,r0	; 02328EDC
	lsl r3,r0,#0x1	; 02328EDE
	ldr r0,[sp,#0x10]	; 02328EE0
	lsl r2,r0,#0x2	; 02328EE2
	ldrh r1,[r4,r3]	; 02328EE4
	mov r0,#0xf	; 02328EE6
	add r5,r0,#0x0	; 02328EE8
	lsl r5,r2	; 02328EEA
	bic r1,r5	; 02328EEC
	ldr r5,[sp,#0x0]	; 02328EEE
	lsl r5,r5,#0x18	; 02328EF0
	lsr r5,r5,#0x18	; 02328EF2
	and r5,r0	; 02328EF4
	lsl r5,r2	; 02328EF6
	orr r1,r5	; 02328EF8
	strh r1,[r4,r3]	; 02328EFA
loc_02328EFC:
	add sp,#0x18	; 02328EFC
	pop {r4,r5,r6,r7}	; 02328EFE
	bx lr	; 02328F00
	.byte 0x00, 0x00	; 02328F04

; ===== function loc_02328F04 =====
loc_02328F04:
	push {r4,r5,r6,r7,lr}	; 02328F04
	sub sp,#0x14	; 02328F06
	str r0,[sp,#0x8]	; 02328F08
	add r6,r1,#0x0	; 02328F0A
	mov r5,#0x0	; 02328F0C
	add r7,r5,#0x0	; 02328F0E
	ldrh r0,[r0,#0x1a]	; 02328F10
	str r0,[sp,#0xc]	; 02328F12
	cmp r0,#0x0	; 02328F14
	ble loc_02328F56	; 02328F16
	ldr r0,[sp,#0x8]	; 02328F18
	ldr r2,[r0,#0x8]	; 02328F1A
	add r4,r2,#0x0	; 02328F1C
	add r3,r5,#0x0	; 02328F1E
loc_02328F20:
	ldrh r0,[r4,#0x0]	; 02328F20
	cmp r0,r6	; 02328F22
	bhi loc_02328F3E	; 02328F24
	add r0,r2,r3	; 02328F26
	ldrh r0,[r0,#0x2]	; 02328F28
	cmp r6,r0	; 02328F2A
	bhi loc_02328F3E	; 02328F2C
	add r1,r5,r6	; 02328F2E
	lsl r0,r7,#0x2	; 02328F30
	ldrh r0,[r2,r0]	; 02328F32
	sub r0,r1,r0	; 02328F34
	add sp,#0x14	; 02328F36
	pop {r4,r5,r6,r7}	; 02328F38
	pop {r3}	; 02328F3A
	bx r3	; 02328F3C
loc_02328F3E:
	add r0,r2,r3	; 02328F3E
	ldrh r1,[r0,#0x2]	; 02328F40
	ldrh r0,[r2,r3]	; 02328F42
	sub r0,r1,r0	; 02328F44
	add r0,r0,#0x1	; 02328F46
	add r5,r5,r0	; 02328F48
	add r4,r4,#0x4	; 02328F4A
	add r3,r3,#0x4	; 02328F4C
	add r7,r7,#0x1	; 02328F4E
	ldr r0,[sp,#0xc]	; 02328F50
	cmp r7,r0	; 02328F52
	blt loc_02328F20	; 02328F54
loc_02328F56:
	lsl r0,r5,#0x10	; 02328F56
	lsr r0,r0,#0x10	; 02328F58
	str r0,[sp,#0x0]	; 02328F5A
	ldr r0,[sp,#0x8]	; 02328F5C
	ldrh r0,[r0,#0x12]	; 02328F5E
	str r0,[sp,#0x4]	; 02328F60
	add r0,r6,#0x0	; 02328F62
	mov r1,#0x0	; 02328F64
	ldr r2,[sp,#0x8]	; 02328F66
	ldrh r2,[r2,#0x18]	; 02328F68
	sub r2,r2,#0x1	; 02328F6A
	ldr r3,[sp,#0x8]	; 02328F6C
	ldr r3,[r3,#0x4]	; 02328F6E
	bl loc_02328F7C	; 02328F70
	add sp,#0x14	; 02328F74
	pop {r4,r5,r6,r7}	; 02328F76
	pop {r3}	; 02328F78
	bx r3	; 02328F7A

; ===== function loc_02328F7C =====
loc_02328F7C:
	push {r4,r5}	; 02328F7C
	cmp r1,r2	; 02328F7E
	bgt loc_02328FAC	; 02328F80
loc_02328F82:
	sub r4,r2,r1	; 02328F82
	asr r4,r4,#0x1	; 02328F84
	add r4,r1,r4	; 02328F86
	lsl r5,r4,#0x1	; 02328F88
	ldrh r5,[r3,r5]	; 02328F8A
	cmp r5,r0	; 02328F8C
	bls loc_02328F94	; 02328F8E
	sub r2,r4,#0x1	; 02328F90
	b loc_02328FA8	; 02328F92
loc_02328F94:
	cmp r5,r0	; 02328F94
	bcs loc_02328F9C	; 02328F96
	add r1,r4,#0x1	; 02328F98
	b loc_02328FA8	; 02328F9A
loc_02328F9C:
	ldr r0,[pool_02328FB8]	; 02328F9C
	add r0,sp	; 02328F9E
	ldrh r0,[r0,#0x10]	; 02328FA0
	add r0,r0,r4	; 02328FA2
	pop {r4,r5}	; 02328FA4
	bx lr	; 02328FA6
loc_02328FA8:
	cmp r1,r2	; 02328FA8
	ble loc_02328F82	; 02328FAA
loc_02328FAC:
	ldr r0,[pool_02328FB8]	; 02328FAC
	add r0,sp	; 02328FAE
	ldrh r0,[r0,#0x14]	; 02328FB0
	pop {r4,r5}	; 02328FB2
	bx lr	; 02328FB4
	.byte 0xC0, 0x46	; 02328FB8
pool_02328FB8:
loc_02328FB8:
	.word 0xFFFFFFF8	; 02328FB8

; ===== function loc_02328FBC =====
loc_02328FBC:
	str r1,[r0,#0x0]	; 02328FBC
	strh r2,[r0,#0x4]	; 02328FBE
	strh r3,[r0,#0x6]	; 02328FC0
	ldr r1,[sp,#0x0]	; 02328FC2
	strh r1,[r0,#0x8]	; 02328FC4
	ldr r1,[sp,#0x4]	; 02328FC6
	str r1,[r0,#0xc]	; 02328FC8
	bx lr	; 02328FCA

; ===== function loc_02328FCC =====
loc_02328FCC:
	push {r4}	; 02328FCC
	sub sp,#0x4	; 02328FCE
	ldrh r3,[r1,#0x6]	; 02328FD0
	strh r3,[r0,#0x10]	; 02328FD2
	ldrh r3,[r1,#0x8]	; 02328FD4
	strh r3,[r0,#0x16]	; 02328FD6
	add r1,#0xa	; 02328FD8
	str r1,[r0,#0xc]	; 02328FDA
	ldr r3,[r0,#0xc]	; 02328FDC
	ldrh r1,[r0,#0x10]	; 02328FDE
	lsl r1,r1,#0x1	; 02328FE0
	add r1,r3,r1	; 02328FE2
	str r1,[r0,#0x0]	; 02328FE4
	ldrh r1,[r0,#0x16]	; 02328FE6
	lsl r3,r1,#0x1b	; 02328FE8
	lsr r3,r3,#0x1b	; 02328FEA
	lsl r1,r1,#0x16	; 02328FEC
	lsr r1,r1,#0x1b	; 02328FEE
	mul r3,r1	; 02328FF0
	add r3,#0xf	; 02328FF2
	asr r1,r3,#0x4	; 02328FF4
	strh r1,[r0,#0x14]	; 02328FF6
	mov r1,#0x0	; 02328FF8
	strh r1,[r0,#0x12]	; 02328FFA
	ldr r3,[r0,#0x1c]	; 02328FFC
	mov r1,#0x1	; 02328FFE
	bic r3,r1	; 02329000
	orr r3,r1	; 02329002
	str r3,[r0,#0x1c]	; 02329004
	ldr r3,[r0,#0x1c]	; 02329006
	mov r1,#0x2	; 02329008
	orr r3,r1	; 0232900A
	str r3,[r0,#0x1c]	; 0232900C
	add r4,r2,#0x0	; 0232900E
	add r4,#0x8	; 02329010
	ldr r1,[r4,#0x4]	; 02329012
	add r1,r2,r1	; 02329014
	ldrh r1,[r1,#0x8]	; 02329016
	strh r1,[r0,#0x18]	; 02329018
	add r3,r2,#0x0	; 0232901A
	add r3,#0xc	; 0232901C
	ldr r1,[r4,#0x4]	; 0232901E
	add r1,r3,r1	; 02329020
	str r1,[r0,#0x4]	; 02329022
	ldr r1,[r2,#0x8]	; 02329024
	add r1,r2,r1	; 02329026
	ldrh r1,[r1,#0x8]	; 02329028
	strh r1,[r0,#0x1a]	; 0232902A
	add r3,r2,#0x0	; 0232902C
	add r3,#0xa	; 0232902E
	ldr r1,[r2,#0x8]	; 02329030
	add r1,r3,r1	; 02329032
	str r1,[r0,#0x8]	; 02329034
	add sp,#0x4	; 02329036
	pop {r4}	; 02329038
	bx lr	; 0232903A

; ===== function loc_0232903C =====
loc_0232903C:
	push {r0,r1,r2,r3}	; 0232903C
	push {r4,lr}	; 0232903E
	add r2,sp,#0x8	; 02329040
	mov r0,#0x0	; 02329042
	ldrsh r0,[r2,r0]	; 02329044
	lsl r0,r0,#0x14	; 02329046
	asr r4,r0,#0x14	; 02329048
	ldrh r0,[r2,#0x0]	; 0232904A
	lsl r0,r0,#0x12	; 0232904C
	lsr r0,r0,#0x1e	; 0232904E
	cmp r0,#0x1	; 02329050
	beq loc_0232905A	; 02329052
	cmp r0,#0x2	; 02329054
	beq loc_02329066	; 02329056
	b loc_02329068	; 02329058
loc_0232905A:
	add r0,r1,#0x1	; 0232905A
	mov r1,#0x2	; 0232905C
	blx P1_SignedDivMod	; 0232905E
	sub r4,r4,r0	; 02329062
	b loc_02329068	; 02329064
loc_02329066:
	sub r4,r4,r1	; 02329066
loc_02329068:
	add r0,r4,#0x0	; 02329068
	pop {r4}	; 0232906A
	pop {r3}	; 0232906C
	add sp,#0x10	; 0232906E
	bx r3	; 02329070
	.byte 0x00, 0x00	; 02329074

; ===== function loc_02329074 =====
loc_02329074:
	push {r0,r1,r2,r3}	; 02329074
	push {r4,lr}	; 02329076
	add r2,sp,#0x8	; 02329078
	mov r0,#0x0	; 0232907A
	ldrsh r0,[r2,r0]	; 0232907C
	lsl r0,r0,#0x14	; 0232907E
	asr r4,r0,#0x14	; 02329080
	ldrh r0,[r2,#0x0]	; 02329082
	lsl r0,r0,#0x12	; 02329084
	lsr r0,r0,#0x1e	; 02329086
	cmp r0,#0x1	; 02329088
	beq loc_02329092	; 0232908A
	cmp r0,#0x2	; 0232908C
	beq loc_0232909E	; 0232908E
	b loc_023290A0	; 02329090
loc_02329092:
	add r0,r1,#0x1	; 02329092
	mov r1,#0x2	; 02329094
	blx P1_SignedDivMod	; 02329096
	sub r4,r4,r0	; 0232909A
	b loc_023290A0	; 0232909C
loc_0232909E:
	sub r4,r4,r1	; 0232909E
loc_023290A0:
	add r0,r4,#0x0	; 023290A0
	pop {r4}	; 023290A2
	pop {r3}	; 023290A4
	add sp,#0x10	; 023290A6
	bx r3	; 023290A8
	.byte 0x00, 0x00	; 023290AC

; ===== function loc_023290AC =====
loc_023290AC:
	push {r4,r5,lr}	; 023290AC
	sub sp,#0x14	; 023290AE
	add r4,r0,#0x0	; 023290B0
	add r3,r1,#0x0	; 023290B2
	mov r0,#0x4	; 023290B4
	ldrsb r0,[r3,r0]	; 023290B6
	str r0,[sp,#0x0]	; 023290B8
	mov r0,#0x5	; 023290BA
	ldrsb r0,[r3,r0]	; 023290BC
	str r0,[sp,#0x4]	; 023290BE
	str r2,[sp,#0x8]	; 023290C0
	ldrb r0,[r3,#0x6]	; 023290C2
	str r0,[sp,#0xc]	; 023290C4
	ldr r1,[r4,#0xc]	; 023290C6
	ldrh r0,[r3,#0x6]	; 023290C8
	lsl r0,r0,#0x10	; 023290CA
	lsr r0,r0,#0x1c	; 023290CC
	lsl r0,r0,#0x5	; 023290CE
	add r0,r1,r0	; 023290D0
	add r1,r4,#0x0	; 023290D2
	mov r4,sp	; 023290D4
	sub r4,r4,#0x4	; 023290D6
	ldrh r2,[r3,#0x0]	; 023290D8
	strh r2,[r4,#0x0]	; 023290DA
	add r5,r4,#0x0	; 023290DC
	ldmia r5!,{r2}	; 023290DE
	ldrh r3,[r3,#0x2]	; 023290E0
	strh r3,[r4,#0x0]	; 023290E2
	ldmia r4!,{r3}	; 023290E4
	bl loc_02328C5C	; 023290E6
	add sp,#0x14	; 023290EA
	pop {r4,r5}	; 023290EC
	pop {r3}	; 023290EE
	bx r3	; 023290F0
	.byte 0x00, 0x00	; 023290F4

; ===== function loc_023290F4 =====
loc_023290F4:
	push {r4,r5,r6,r7,lr}	; 023290F4
	sub sp,#0x4	; 023290F6
	add r7,r0,#0x0	; 023290F8
	str r1,[sp,#0x0]	; 023290FA
	ldrh r6,[r1,#0x6]	; 023290FC
	lsl r4,r1,#0	; 023290FE
	add r4,#0x8	; 02329100
	mov r5,#0x0	; 02329102
	cmp r6,#0x0	; 02329104
	ble loc_02329122	; 02329106
loc_02329108:
	ldr r3,[r4,#0x8]	; 02329108
	cmp r3,#0x0	; 0232910A
	beq loc_0232911A	; 0232910C
	add r0,r7,#0x0	; 0232910E
	add r1,r4,#0x0	; 02329110
	ldr r2,[sp,#0x0]	; 02329112
	add r2,r2,r3	; 02329114
	bl loc_023290AC	; 02329116
loc_0232911A:
	add r4,#0xc	; 0232911A
	add r5,r5,#0x1	; 0232911C
	cmp r5,r6	; 0232911E
	blt loc_02329108	; 02329120
loc_02329122:
	add sp,#0x4	; 02329122
	pop {r4,r5,r6,r7}	; 02329124
	pop {r3}	; 02329126
	bx r3	; 02329128
	.byte 0x00, 0x00	; 0232912C

; ===== function loc_0232912C =====
loc_0232912C:
	ldrh r2,[r0,#0x6]	; 0232912C
	add r0,#0x8	; 0232912E
	cmp r1,#0x0	; 02329130
	blt loc_02329138	; 02329132
	cmp r1,r2	; 02329134
	blt loc_0232913C	; 02329136
loc_02329138:
	mov r0,#0x0	; 02329138
	bx lr	; 0232913A
loc_0232913C:
	mov r2,#0xc	; 0232913C
	mul r1,r2	; 0232913E
	add r0,r0,r1	; 02329140
	bx lr	; 02329142

; ===== function loc_02329144 =====
loc_02329144:
	ldr r2,[r0,#0x8]	; 02329144
	add r2,r0,r2	; 02329146
	mov r0,#0x6	; 02329148
	mul r1,r0	; 0232914A
	add r0,r2,r1	; 0232914C
	bx lr	; 0232914E

; ===== function loc_02329150 =====
loc_02329150:
	ldr r0,[r0,#0x14]	; 02329150
	bx lr	; 02329152

; ===== function loc_02329154 =====
loc_02329154:
	ldr r1,[r0,#0x10]	; 02329154
	add r0,r0,r1	; 02329156
	bx lr	; 02329158
	.byte 0x00, 0x00	; 0232915C

; ===== function loc_0232915C =====
loc_0232915C:
	ldr r2,[r0,#0xc]	; 0232915C
	add r2,r0,r2	; 0232915E
	ldr r3,[r0,#0x8]	; 02329160
	add r3,r0,r3	; 02329162
	mov r0,#0x6	; 02329164
	mul r1,r0	; 02329166
	add r0,r3,r1	; 02329168
	ldrh r1,[r0,#0x2]	; 0232916A
	mov r0,#0xc	; 0232916C
	mul r1,r0	; 0232916E
	add r0,r2,r1	; 02329170
	bx lr	; 02329172

; ===== function loc_02329174 =====
loc_02329174:
	ldr r2,[r0,#0x8]	; 02329174
	add r2,r0,r2	; 02329176
	mov r0,#0x6	; 02329178
	mul r1,r0	; 0232917A
	add r0,r2,r1	; 0232917C
	ldrh r0,[r0,#0x4]	; 0232917E
	bx lr	; 02329180
	.byte 0x00, 0x00	; 02329184

; ===== function loc_02329184 =====
loc_02329184:
	push {r4,r5,r6,r7,lr}	; 02329184
	sub sp,#0xc	; 02329186
	str r0,[sp,#0x0]	; 02329188
	add r7,r1,#0x0	; 0232918A
	str r2,[sp,#0x4]	; 0232918C
	lsl r4,r0,#0	; 0232918E
	add r4,#0x8	; 02329190
	mov r5,#0x0	; 02329192
	bl loc_02329230	; 02329194
	cmp r0,#0x0	; 02329198
	ble loc_023291F2	; 0232919A
loc_0232919C:
	mov r1,sp	; 0232919C
	sub r1,r1,#0x4	; 0232919E
	ldrh r0,[r4,#0x0]	; 023291A0
	strh r0,[r1,#0x0]	; 023291A2
	ldmia r1!,{r0}	; 023291A4
	ldrb r1,[r4,#0x4]	; 023291A6
	bl loc_02329074	; 023291A8
	add r6,r0,#0x0	; 023291AC
	mov r1,sp	; 023291AE
	sub r1,r1,#0x4	; 023291B0
	ldrh r0,[r4,#0x2]	; 023291B2
	strh r0,[r1,#0x0]	; 023291B4
	ldmia r1!,{r0}	; 023291B6
	ldrb r1,[r4,#0x5]	; 023291B8
	bl loc_0232903C	; 023291BA
	ldrb r1,[r4,#0x4]	; 023291BE
	add r2,r6,r1	; 023291C0
	ldrb r1,[r4,#0x5]	; 023291C2
	add r1,r0,r1	; 023291C4
	cmp r6,r7	; 023291C6
	bgt loc_023291E4	; 023291C8
	cmp r7,r2	; 023291CA
	bgt loc_023291E4	; 023291CC
	ldr r2,[sp,#0x4]	; 023291CE
	cmp r0,r2	; 023291D0
	bgt loc_023291E4	; 023291D2
	lsl r0,r2,#0	; 023291D4
	cmp r0,r1	; 023291D6
	bgt loc_023291E4	; 023291D8
	add r0,r5,#0x0	; 023291DA
	add sp,#0xc	; 023291DC
	pop {r4,r5,r6,r7}	; 023291DE
	pop {r3}	; 023291E0
	bx r3	; 023291E2
loc_023291E4:
	add r5,r5,#0x1	; 023291E4
	add r4,r4,#0x6	; 023291E6
	ldr r0,[sp,#0x0]	; 023291E8
	bl loc_02329230	; 023291EA
	cmp r5,r0	; 023291EE
	blt loc_0232919C	; 023291F0
loc_023291F2:
	mov r0,#0x0	; 023291F2
	mvn r0,r0	; 023291F4
	add sp,#0xc	; 023291F6
	pop {r4,r5,r6,r7}	; 023291F8
	pop {r3}	; 023291FA
	bx r3	; 023291FC
	.byte 0x00, 0x00	; 02329200

; ===== function loc_02329200 =====
loc_02329200:
	push {r4,r5,lr}	; 02329200
	sub sp,#0x4	; 02329202
	add r5,r1,#0x0	; 02329204
	add r4,r0,#0x0	; 02329206
	add r4,#0x8	; 02329208
	cmp r5,#0x0	; 0232920A
	blt loc_02329216	; 0232920C
	bl loc_02329230	; 0232920E
	cmp r5,r0	; 02329212
	blt loc_02329220	; 02329214
loc_02329216:
	mov r0,#0x0	; 02329216
	add sp,#0x4	; 02329218
	pop {r4,r5}	; 0232921A
	pop {r3}	; 0232921C
	bx r3	; 0232921E
loc_02329220:
	mov r0,#0x6	; 02329220
	mul r5,r0	; 02329222
	add r0,r4,r5	; 02329224
	add sp,#0x4	; 02329226
	pop {r4,r5}	; 02329228
	pop {r3}	; 0232922A
	bx r3	; 0232922C
	.byte 0x00, 0x00	; 02329230

; ===== function loc_02329230 =====
loc_02329230:
	ldrh r0,[r0,#0x6]	; 02329230
	bx lr	; 02329232

; ===== function loc_02329234 =====
loc_02329234:
	push {r4,r5,r6,r7,lr}	; 02329234
	sub sp,#0x14	; 02329236
	str r0,[sp,#0x0]	; 02329238
	str r1,[sp,#0x4]	; 0232923A
	str r2,[sp,#0x8]	; 0232923C
	str r3,[sp,#0xc]	; 0232923E
	lsl r0,r2,#0	; 02329240
	lsr r6,r0,#0x1	; 02329242
	mov r5,#0x0	; 02329244
	add r4,sp,#0x10	; 02329246
	ldr r1,[pool_02329374]	; 02329248
	ldr r7,[pool_02329378]	; 0232924A
loc_0232924C:
	add r0,r5,r6	; 0232924C
	sub r0,r0,#0x2	; 0232924E
	lsl r3,r0,#0x1	; 02329250
	ldr r0,[sp,#0x0]	; 02329252
	ldrsh r2,[r0,r3]	; 02329254
	ldr r0,[sp,#0x4]	; 02329256
	ldrsh r0,[r0,r3]	; 02329258
	sub r0,r2,r0	; 0232925A
	cmp r0,r1	; 0232925C
	bge loc_02329264	; 0232925E
	add r0,r1,#0x0	; 02329260
	b loc_0232926A	; 02329262
loc_02329264:
	cmp r0,r7	; 02329264
	blt loc_0232926A	; 02329266
	ldr r0,[pool_0232937C]	; 02329268
loc_0232926A:
	strh r0,[r4,#0x0]	; 0232926A
	add r4,r4,#0x2	; 0232926C
	add r5,r5,#0x1	; 0232926E
	cmp r5,#0x2	; 02329270
	blt loc_0232924C	; 02329272
	sub r0,r6,#0x1	; 02329274
	cmp r0,#0x2	; 02329276
	blt loc_023292F2	; 02329278
	lsl r3,r0,#0x1	; 0232927A
	ldr r1,[sp,#0x0]	; 0232927C
	add r2,r1,r3	; 0232927E
	ldr r1,[sp,#0x4]	; 02329280
	add r1,r1,r3	; 02329282
	ldr r7,[pool_02329374]	; 02329284
	mov r4,#0x0	; 02329286
loc_02329288:
	sub r3,r0,#0x2	; 02329288
	lsl r6,r3,#0x1	; 0232928A
	ldr r3,[sp,#0x0]	; 0232928C
	ldrsh r5,[r3,r6]	; 0232928E
	ldr r3,[sp,#0x4]	; 02329290
	ldrsh r3,[r3,r6]	; 02329292
	sub r6,r5,r3	; 02329294
	cmp r6,#0x0	; 02329296
	blt loc_023292C2	; 02329298
	ldrsh r3,[r2,r4]	; 0232929A
	add r5,r6,r3	; 0232929C
	ldr r3,[pool_02329378]	; 0232929E
	cmp r5,r3	; 023292A0
	bge loc_023292AA	; 023292A2
	lsl r3,r5,#0x10	; 023292A4
	asr r3,r3,#0x10	; 023292A6
	b loc_023292AC	; 023292A8
loc_023292AA:
	ldr r3,[pool_0232937C]	; 023292AA
loc_023292AC:
	strh r3,[r2,#0x0]	; 023292AC
	ldrsh r3,[r1,r4]	; 023292AE
	sub r3,r3,r6	; 023292B0
	cmp r3,r7	; 023292B2
	blt loc_023292BC	; 023292B4
	lsl r3,r3,#0x10	; 023292B6
	asr r3,r3,#0x10	; 023292B8
	b loc_023292BE	; 023292BA
loc_023292BC:
	add r3,r7,#0x0	; 023292BC
loc_023292BE:
	strh r3,[r1,#0x0]	; 023292BE
	b loc_023292E8	; 023292C0
loc_023292C2:
	ldrsh r3,[r2,r4]	; 023292C2
	add r3,r6,r3	; 023292C4
	cmp r3,r7	; 023292C6
	blt loc_023292D0	; 023292C8
	lsl r3,r3,#0x10	; 023292CA
	asr r3,r3,#0x10	; 023292CC
	b loc_023292D2	; 023292CE
loc_023292D0:
	add r3,r7,#0x0	; 023292D0
loc_023292D2:
	strh r3,[r2,#0x0]	; 023292D2
	ldrsh r3,[r1,r4]	; 023292D4
	sub r5,r3,r6	; 023292D6
	ldr r3,[pool_02329378]	; 023292D8
	cmp r5,r3	; 023292DA
	bge loc_023292E4	; 023292DC
	lsl r3,r5,#0x10	; 023292DE
	asr r3,r3,#0x10	; 023292E0
	b loc_023292E6	; 023292E2
loc_023292E4:
	ldr r3,[pool_0232937C]	; 023292E4
loc_023292E6:
	strh r3,[r1,#0x0]	; 023292E6
loc_023292E8:
	sub r2,r2,#0x2	; 023292E8
	sub r1,r1,#0x2	; 023292EA
	sub r0,r0,#0x1	; 023292EC
	cmp r0,#0x2	; 023292EE
	bge loc_02329288	; 023292F0
loc_023292F2:
	mov r1,#0x1	; 023292F2
	ldr r0,[sp,#0xc]	; 023292F4
	add r4,r0,#0x4	; 023292F6
	ldr r0,[sp,#0x0]	; 023292F8
	add r3,r0,#0x2	; 023292FA
	ldr r0,[sp,#0x4]	; 023292FC
	add r2,r0,#0x2	; 023292FE
	ldr r0,[pool_02329374]	; 02329300
loc_02329302:
	mov r5,#0x0	; 02329302
	ldrsh r6,[r3,r5]	; 02329304
	ldr r5,[r4,#0xc]	; 02329306
	add r6,r6,r5	; 02329308
	cmp r6,r0	; 0232930A
	bge loc_02329312	; 0232930C
	add r6,r0,#0x0	; 0232930E
	b loc_0232931A	; 02329310
loc_02329312:
	ldr r5,[pool_02329378]	; 02329312
	cmp r6,r5	; 02329314
	blt loc_0232931A	; 02329316
	ldr r6,[pool_0232937C]	; 02329318
loc_0232931A:
	strh r6,[r3,#0x0]	; 0232931A
	mov r5,#0x0	; 0232931C
	ldrsh r6,[r2,r5]	; 0232931E
	ldr r5,[r4,#0xc]	; 02329320
	sub r6,r6,r5	; 02329322
	cmp r6,r0	; 02329324
	bge loc_0232932C	; 02329326
	add r6,r0,#0x0	; 02329328
	b loc_02329334	; 0232932A
loc_0232932C:
	ldr r5,[pool_02329378]	; 0232932C
	cmp r6,r5	; 0232932E
	blt loc_02329334	; 02329330
	ldr r6,[pool_0232937C]	; 02329332
loc_02329334:
	strh r6,[r2,#0x0]	; 02329334
	sub r4,r4,#0x4	; 02329336
	sub r3,r3,#0x2	; 02329338
	sub r2,r2,#0x2	; 0232933A
	sub r1,r1,#0x1	; 0232933C
	cmp r1,#0x0	; 0232933E
	bge loc_02329302	; 02329340
	mov r3,#0x0	; 02329342
	add r4,sp,#0x10	; 02329344
	add r1,r3,#0x0	; 02329346
loc_02329348:
	ldrsh r2,[r4,r1]	; 02329348
	ldr r0,[sp,#0xc]	; 0232934A
	str r2,[r0,#0xc]	; 0232934C
	add r4,r4,#0x2	; 0232934E
	add r0,r0,#0x4	; 02329350
	str r0,[sp,#0xc]	; 02329352
	add r3,r3,#0x1	; 02329354
	cmp r3,#0x2	; 02329356
	blt loc_02329348	; 02329358
	ldr r0,[sp,#0x0]	; 0232935A
	ldr r1,[sp,#0x8]	; 0232935C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232935E
	ldr r0,[sp,#0x4]	; 02329362
	ldr r1,[sp,#0x8]	; 02329364
	blx P1_CleanAndInvalidateDataCacheRange	; 02329366
	add sp,#0x14	; 0232936A
	pop {r4,r5,r6,r7}	; 0232936C
	pop {r3}	; 0232936E
	bx r3	; 02329370
	.byte 0xC0, 0x46	; 02329374
pool_02329374:
loc_02329374:
	.word 0xFFFF8000	; 02329374
pool_02329378:
loc_02329378:
	.word 0x00008000	; 02329378
pool_0232937C:
loc_0232937C:
	.word 0x00007FFF	; 0232937C

; ===== function loc_02329380 =====
	push {r4,r5,r6,r7,lr}	; 02329380
; 已登记的双缓冲处理回调：先调度上下文的可选处理函数，再按模式继续处理。
; Registered two-buffer handler: call the context's optional worker, then continue by mode.
.func P1_RunDualBufferCallback
	sub sp,#0xc	; 02329382
	add r7,r0,#0x0	; 02329384
	str r1,[sp,#0x4]	; 02329386
	str r2,[sp,#0x8]	; 02329388
	ldr r4,[sp,#0x20]	; 0232938A
	ldr r6,[r4,#P1_DualBufferCallbackContextWorkerOffset]	; 0232938C
	cmp r6,#0x0	; 0232938E
	beq loc_02329398	; 02329390
	ldr r5,[r4,#P1_DualBufferCallbackContextArgumentOffset]	; 02329392
	str r5,[sp,#0x0]	; 02329394
	blx r6	; 02329396
loc_02329398:
	ldr r0,[r4,#P1_DualBufferCallbackContextModeOffset]	; 02329398
	cmp r0,#0x0	; 0232939A
	beq loc_023293AE	; 0232939C
	cmp r0,#0x1	; 0232939E
	bne loc_023293AE	; 023293A0
	add r0,r7,#0x0	; 023293A2
	ldr r1,[sp,#0x4]	; 023293A4
	ldr r2,[sp,#0x8]	; 023293A6
	add r3,r4,#0x0	; 023293A8
	bl loc_02329234	; 023293AA
loc_023293AE:
	add sp,#0xc	; 023293AE
	pop {r4,r5,r6,r7}	; 023293B0
	pop {r3}	; 023293B2
	bx r3	; 023293B4
	.byte 0x00, 0x00	; 023293B8
.endfunc

; ===== function loc_023293B8 =====
loc_023293B8:
	push {lr}	; 023293B8
	sub sp,#0x4	; 023293BA
	ldr r0,[pool_023293D4]	; 023293BC
	ldr r0,[r0,#0x0]	; 023293BE
	cmp r0,#0x1	; 023293C0
	bne loc_023293CA	; 023293C2
	mov r0,#0x0	; 023293C4
	bl loc_0232DF20	; 023293C6
loc_023293CA:
	bl P1_StopActiveDualBufferProcessor	; 023293CA
	add sp,#0x4	; 023293CE
	pop {r3}	; 023293D0
	bx r3	; 023293D2
pool_023293D4:
loc_023293D4:
	.word P1_DualBufferCallbackContext	; 023293D4

; ===== function loc_023293D8 =====
loc_023293D8:
	push {r4,r5,r6,lr}	; 023293D8
; 清零初始工作区、记录启动模式，并建立双缓冲处理对象。
; Clear initial workspace, record the start mode, and create the two-buffer processor.
.func P1_StartDualBufferProcessor
	sub sp,#0x10	; 023293DA
	add r5,r0,#0x0	; 023293DC
	add r6,r1,#0x0	; 023293DE
	add r4,r2,#0x0	; 023293E0
	mov r1,#0x0	; 023293E2
	add r0,sp,#0xc	; 023293E4
	strh r1,[r0,#0x0]	; 023293E6
	ldrh r0,[r0,#0x0]	; 023293E8
	ldr r1,[pool_02329420]	; 023293EA
	mov r2,#0xc0	; 023293EC
	blx loc_0232DDAC	; 023293EE
	ldr r0,[pool_02329424]	; 023293F2
	str r4,[r0,#0x0]	; 023293F4
	cmp r4,#0x1	; 023293F6
	bne loc_02329400	; 023293F8
	ldr r0,[pool_02329428]	; 023293FA
	bl loc_0232DF20	; 023293FC
loc_02329400:
	mov r0,#0x2	; 02329400
	str r0,[sp,#0x0]	; 02329402
	ldr r0,[pool_0232942C]	; 02329404
	str r0,[sp,#0x4]	; 02329406
	ldr r0,[pool_02329424]	; 02329408
	str r0,[sp,#0x8]	; 0232940A
	add r0,r5,#0x0	; 0232940C
	add r1,r6,#0x0	; 0232940E
	mov r2,#0x0	; 02329410
	ldr r3,[pool_02329430]	; 02329412
	bl P1_ConfigureDualBufferProcessor	; 02329414
	add sp,#0x10	; 02329418
	pop {r4,r5,r6}	; 0232941A
	pop {r3}	; 0232941C
	bx r3	; 0232941E
pool_02329420:
.endfunc
loc_02329420:
	.word 0x02356128	; 02329420
pool_02329424:
loc_02329424:
	.word P1_DualBufferCallbackContext	; 02329424
pool_02329428:
loc_02329428:
	.word 0x00003000	; 02329428
pool_0232942C:
loc_0232942C:
	.word P1_RunDualBufferCallback + 1	; 0232942C
pool_02329430:
loc_02329430:
	.word 0x00007D00	; 02329430

; ===== function loc_02329434 =====
loc_02329434:
	mov r0,#0x1	; 02329434
	ldr r3,[pool_0232943C]	; 02329436
	bx r3	; 02329438
	.byte 0xC0, 0x46	; 0232943C
pool_0232943C:
loc_0232943C:
	.word loc_0232C6D8 + 1	; 0232943C

; ===== function loc_02329440 =====
loc_02329440:
	push {r4,r5,lr}	; 02329440
	sub sp,#0x4	; 02329442
	add r5,r0,#0x0	; 02329444
	bl loc_02329434	; 02329446
	cmp r0,#0x0	; 0232944A
	bne loc_0232945A	; 0232944C
	mov r0,#0x2	; 0232944E
	mvn r0,r0	; 02329450
	add sp,#0x4	; 02329452
	pop {r4,r5}	; 02329454
	pop {r3}	; 02329456
	bx r3	; 02329458
loc_0232945A:
	bl loc_023294F8	; 0232945A
	add r4,r0,#0x0	; 0232945E
	mov r0,#0x0	; 02329460
	mvn r0,r0	; 02329462
	cmp r4,r0	; 02329464
	beq loc_02329482	; 02329466
	add r0,r5,#0x0	; 02329468
	bl loc_023294B4	; 0232946A
	lsl r0,r4,#0x10	; 0232946E
	lsr r0,r0,#0x10	; 02329470
	bl loc_023294D4	; 02329472
	mov r1,#0x1	; 02329476
	mvn r1,r1	; 02329478
	cmp r0,r1	; 0232947A
	beq loc_02329480	; 0232947C
	mov r1,#0x0	; 0232947E
loc_02329480:
	add r0,r1,#0x0	; 02329480
loc_02329482:
	add sp,#0x4	; 02329482
	pop {r4,r5}	; 02329484
	pop {r3}	; 02329486
	bx r3	; 02329488
	.byte 0x00, 0x00	; 0232948C

; ===== function loc_0232948C =====
loc_0232948C:
	push {lr}	; 0232948C
	sub sp,#0x4	; 0232948E
	mov r3,#0x0	; 02329490
	ldr r2,[pool_023294B0]	; 02329492
	add r0,r3,#0x0	; 02329494
loc_02329496:
	ldrsb r1,[r2,r0]	; 02329496
	add r2,r2,#0x1	; 02329498
	add r3,r3,#0x1	; 0232949A
	cmp r3,#0x13	; 0232949C
	bcc loc_02329496	; 0232949E
	bl loc_0232C728	; 023294A0
	mov r0,#0x1	; 023294A4
	bl loc_0232C6A8	; 023294A6
	add sp,#0x4	; 023294AA
	pop {r3}	; 023294AC
	bx r3	; 023294AE
pool_023294B0:
loc_023294B0:
	.word P1_VibBuildIdentifier	; 023294B0

; ===== function loc_023294B4 =====
loc_023294B4:
	push {r4,lr}	; 023294B4
	add r4,r0,#0x0	; 023294B6
	bl loc_02329434	; 023294B8
	cmp r0,#0x1	; 023294BC
	bne loc_023294C8	; 023294BE
	mov r0,#0x1	; 023294C0
	and r4,r0	; 023294C2
	ldr r0,[pool_023294D0]	; 023294C4
	strh r4,[r0,#0x0]	; 023294C6
loc_023294C8:
	pop {r4}	; 023294C8
	pop {r3}	; 023294CA
	bx r3	; 023294CC
	.byte 0xC0, 0x46	; 023294D0
pool_023294D0:
loc_023294D0:
	.word Slot2BusBaseAddress + 0x4	; 023294D0

; ===== function loc_023294D4 =====
loc_023294D4:
	push {r4,r5,lr}	; 023294D4
	sub sp,#0x4	; 023294D6
	add r5,r0,#0x0	; 023294D8
	bl loc_0232B340	; 023294DA
	add r4,r0,#0x0	; 023294DE
	add r0,r5,#0x0	; 023294E0
	blx loc_0232B25C	; 023294E2
	mov r0,#0x1	; 023294E6
	mvn r0,r0	; 023294E8
	cmp r4,r0	; 023294EA
	beq loc_023294F0	; 023294EC
	mov r0,#0x0	; 023294EE
loc_023294F0:
	add sp,#0x4	; 023294F0
	pop {r4,r5}	; 023294F2
	pop {r3}	; 023294F4
	bx r3	; 023294F6

; ===== function loc_023294F8 =====
loc_023294F8:
	push {r4,lr}	; 023294F8
	blx loc_0232B204	; 023294FA
	add r4,r0,#0x0	; 023294FE
	mov r0,#0x2	; 02329500
	mvn r0,r0	; 02329502
	cmp r4,r0	; 02329504
	bne loc_02329512	; 02329506
	mov r0,#0x0	; 02329508
	mvn r0,r0	; 0232950A
	pop {r4}	; 0232950C
	pop {r3}	; 0232950E
	bx r3	; 02329510
loc_02329512:
	lsl r0,r4,#0x10	; 02329512
	lsr r0,r0,#0x10	; 02329514
	bl loc_0232B35C	; 02329516
	add r0,r4,#0x0	; 0232951A
	pop {r4}	; 0232951C
	pop {r3}	; 0232951E
	bx r3	; 02329520
	.byte 0x00, 0x00	; 02329524

; ===== function loc_02329524 =====
loc_02329524:
	cmp r1,#0x0	; 02329524
	bne loc_0232952C	; 02329526
	ldr r0,[r0,#0x4]	; 02329528
	bx lr	; 0232952A
loc_0232952C:
	ldrh r0,[r0,#0xa]	; 0232952C
	ldr r0,[r1,r0]	; 0232952E
	bx lr	; 02329530
	.byte 0x00, 0x00	; 02329534

; ===== function loc_02329534 =====
loc_02329534:
	cmp r1,#0x0	; 02329534
	bne loc_0232953C	; 02329536
	ldr r0,[r0,#0x0]	; 02329538
	bx lr	; 0232953A
loc_0232953C:
	ldrh r0,[r0,#0xa]	; 0232953C
	add r0,r1,r0	; 0232953E
	ldr r0,[r0,#0x4]	; 02329540
	bx lr	; 02329542

; ===== function loc_02329544 =====
loc_02329544:
	push {r4}	; 02329544
	sub sp,#0x4	; 02329546
	ldrh r4,[r0,#0xa]	; 02329548
	add r2,r1,r4	; 0232954A
	ldr r1,[r1,r4]	; 0232954C
	cmp r1,#0x0	; 0232954E
	bne loc_02329558	; 02329550
	ldr r1,[r2,#0x4]	; 02329552
	str r1,[r0,#0x0]	; 02329554
	b loc_0232955E	; 02329556
loc_02329558:
	ldr r3,[r2,#0x4]	; 02329558
	add r1,r1,r4	; 0232955A
	str r3,[r1,#0x4]	; 0232955C
loc_0232955E:
	ldr r4,[r2,#0x4]	; 0232955E
	cmp r4,#0x0	; 02329560
	bne loc_0232956A	; 02329562
	ldr r1,[r2,#0x0]	; 02329564
	str r1,[r0,#0x4]	; 02329566
	b loc_02329570	; 02329568
loc_0232956A:
	ldr r3,[r2,#0x0]	; 0232956A
	ldrh r1,[r0,#0xa]	; 0232956C
	str r3,[r4,r1]	; 0232956E
loc_02329570:
	mov r1,#0x0	; 02329570
	str r1,[r2,#0x0]	; 02329572
	str r1,[r2,#0x4]	; 02329574
	ldrh r1,[r0,#0x8]	; 02329576
	sub r1,r1,#0x1	; 02329578
	strh r1,[r0,#0x8]	; 0232957A
	add sp,#0x4	; 0232957C
	pop {r4}	; 0232957E
	bx lr	; 02329580
	.byte 0x00, 0x00	; 02329584

; ===== function loc_02329584 =====
loc_02329584:
	push {r4,r5,lr}	; 02329584
	sub sp,#0x4	; 02329586
	cmp r1,#0x0	; 02329588
	bne loc_0232959A	; 0232958A
	add r1,r2,#0x0	; 0232958C
	bl loc_02329604	; 0232958E
	add sp,#0x4	; 02329592
	pop {r4,r5}	; 02329594
	pop {r3}	; 02329596
	bx r3	; 02329598
loc_0232959A:
	ldr r3,[r0,#0x0]	; 0232959A
	cmp r1,r3	; 0232959C
	bne loc_023295AE	; 0232959E
	add r1,r2,#0x0	; 023295A0
	bl loc_023295D0	; 023295A2
	add sp,#0x4	; 023295A6
	pop {r4,r5}	; 023295A8
	pop {r3}	; 023295AA
	bx r3	; 023295AC
loc_023295AE:
	ldrh r5,[r0,#0xa]	; 023295AE
	add r4,r2,r5	; 023295B0
	ldr r3,[r1,r5]	; 023295B2
	str r3,[r2,r5]	; 023295B4
	str r1,[r4,#0x4]	; 023295B6
	add r3,r3,r5	; 023295B8
	str r2,[r3,#0x4]	; 023295BA
	ldrh r3,[r0,#0xa]	; 023295BC
	str r2,[r1,r3]	; 023295BE
	ldrh r1,[r0,#0x8]	; 023295C0
	add r1,r1,#0x1	; 023295C2
	strh r1,[r0,#0x8]	; 023295C4
	add sp,#0x4	; 023295C6
	pop {r4,r5}	; 023295C8
	pop {r3}	; 023295CA
	bx r3	; 023295CC
	.byte 0x00, 0x00	; 023295D0

; ===== function loc_023295D0 =====
loc_023295D0:
	push {r4,lr}	; 023295D0
	ldr r2,[r0,#0x0]	; 023295D2
	cmp r2,#0x0	; 023295D4
	bne loc_023295E2	; 023295D6
	bl loc_02329638	; 023295D8
	pop {r4}	; 023295DC
	pop {r3}	; 023295DE
	bx r3	; 023295E0
loc_023295E2:
	ldrh r3,[r0,#0xa]	; 023295E2
	add r4,r1,r3	; 023295E4
	mov r2,#0x0	; 023295E6
	str r2,[r1,r3]	; 023295E8
	ldr r2,[r0,#0x0]	; 023295EA
	str r2,[r4,#0x4]	; 023295EC
	ldr r3,[r0,#0x0]	; 023295EE
	ldrh r2,[r0,#0xa]	; 023295F0
	str r1,[r3,r2]	; 023295F2
	str r1,[r0,#0x0]	; 023295F4
	ldrh r1,[r0,#0x8]	; 023295F6
	add r1,r1,#0x1	; 023295F8
	strh r1,[r0,#0x8]	; 023295FA
	pop {r4}	; 023295FC
	pop {r3}	; 023295FE
	bx r3	; 02329600
	.byte 0x00, 0x00	; 02329604

; ===== function loc_02329604 =====
loc_02329604:
	push {r4,lr}	; 02329604
	ldr r2,[r0,#0x0]	; 02329606
	cmp r2,#0x0	; 02329608
	bne loc_02329616	; 0232960A
	bl loc_02329638	; 0232960C
	pop {r4}	; 02329610
	pop {r3}	; 02329612
	bx r3	; 02329614
loc_02329616:
	ldrh r3,[r0,#0xa]	; 02329616
	add r4,r1,r3	; 02329618
	ldr r2,[r0,#0x4]	; 0232961A
	str r2,[r1,r3]	; 0232961C
	mov r2,#0x0	; 0232961E
	str r2,[r4,#0x4]	; 02329620
	ldr r3,[r0,#0x4]	; 02329622
	ldrh r2,[r0,#0xa]	; 02329624
	add r2,r3,r2	; 02329626
	str r1,[r2,#0x4]	; 02329628
	str r1,[r0,#0x4]	; 0232962A
	ldrh r1,[r0,#0x8]	; 0232962C
	add r1,r1,#0x1	; 0232962E
	strh r1,[r0,#0x8]	; 02329630
	pop {r4}	; 02329632
	pop {r3}	; 02329634
	bx r3	; 02329636

; ===== function loc_02329638 =====
loc_02329638:
	push {r4}	; 02329638
	sub sp,#0x4	; 0232963A
	ldrh r3,[r0,#0xa]	; 0232963C
	add r4,r1,r3	; 0232963E
	mov r2,#0x0	; 02329640
	str r2,[r4,#0x4]	; 02329642
	str r2,[r1,r3]	; 02329644
	str r1,[r0,#0x0]	; 02329646
	str r1,[r0,#0x4]	; 02329648
	ldrh r1,[r0,#0x8]	; 0232964A
	add r1,r1,#0x1	; 0232964C
	strh r1,[r0,#0x8]	; 0232964E
	add sp,#0x4	; 02329650
	pop {r4}	; 02329652
	bx lr	; 02329654
	.byte 0x00, 0x00	; 02329658

; ===== function loc_02329658 =====
loc_02329658:
	mov r2,#0x0	; 02329658
	str r2,[r0,#0x0]	; 0232965A
	str r2,[r0,#0x4]	; 0232965C
	strh r2,[r0,#0x8]	; 0232965E
	strh r1,[r0,#0xa]	; 02329660
	bx lr	; 02329662

; ===== function loc_02329664 =====
loc_02329664:
	push {r4,lr}	; 02329664
	add r4,r0,#0x0	; 02329666
	bl loc_023296DC	; 02329668
	add r1,r4,#0x0	; 0232966C
	bl loc_02329544	; 0232966E
	pop {r4}	; 02329672
	pop {r3}	; 02329674
	bx r3	; 02329676

; ===== function loc_02329678 =====
loc_02329678:
	push {r4,lr}	; 02329678
	add r4,r0,#0x0	; 0232967A
	str r1,[r4,#0x0]	; 0232967C
	str r2,[r4,#0x18]	; 0232967E
	str r3,[r4,#0x1c]	; 02329680
	mov r0,#0x0	; 02329682
	str r0,[r4,#0x20]	; 02329684
	ldr r1,[r4,#0x20]	; 02329686
	mov r0,#0xff	; 02329688
	bic r1,r0	; 0232968A
	str r1,[r4,#0x20]	; 0232968C
	ldr r2,[r4,#0x20]	; 0232968E
	ldr r1,[pool_023296D0]	; 02329690
	add r1,sp	; 02329692
	ldrh r1,[r1,#0x10]	; 02329694
	and r1,r0	; 02329696
	orr r2,r1	; 02329698
	str r2,[r4,#0x20]	; 0232969A
	add r0,r4,#0x0	; 0232969C
	add r0,#0xc	; 0232969E
	mov r1,#0x4	; 023296A0
	bl loc_02329658	; 023296A2
	ldr r0,[pool_023296D4]	; 023296A6
	ldr r0,[r0,#0x0]	; 023296A8
	cmp r0,#0x0	; 023296AA
	bne loc_023296BC	; 023296AC
	ldr r0,[pool_023296D8]	; 023296AE
	mov r1,#0x4	; 023296B0
	bl loc_02329658	; 023296B2
	mov r1,#0x1	; 023296B6
	ldr r0,[pool_023296D4]	; 023296B8
	str r1,[r0,#0x0]	; 023296BA
loc_023296BC:
	add r0,r4,#0x0	; 023296BC
	bl loc_023296DC	; 023296BE
	add r1,r4,#0x0	; 023296C2
	bl loc_02329604	; 023296C4
	pop {r4}	; 023296C8
	pop {r3}	; 023296CA
	bx r3	; 023296CC
	.byte 0xC0, 0x46	; 023296D0
pool_023296D0:
loc_023296D0:
	.word 0xFFFFFFF8	; 023296D0
pool_023296D4:
loc_023296D4:
	.word P1_BssStart + 0x25A08	; 023296D4
pool_023296D8:
loc_023296D8:
	.word 0x023561EC	; 023296D8

; ===== function loc_023296DC =====
loc_023296DC:
	push {r4,lr}	; 023296DC
	add r1,r0,#0x0	; 023296DE
	ldr r4,[pool_023296F8]	; 023296E0
	add r0,r4,#0x0	; 023296E2
	bl loc_023296FC	; 023296E4
	cmp r0,#0x0	; 023296E8
	beq loc_023296F0	; 023296EA
	add r4,r0,#0x0	; 023296EC
	add r4,#0xc	; 023296EE
loc_023296F0:
	add r0,r4,#0x0	; 023296F0
	pop {r4}	; 023296F2
	pop {r3}	; 023296F4
	bx r3	; 023296F6
pool_023296F8:
loc_023296F8:
	.word 0x023561EC	; 023296F8

; ===== function loc_023296FC =====
loc_023296FC:
	push {r4,r5,r6,lr}	; 023296FC
	add r6,r0,#0x0	; 023296FE
	add r5,r1,#0x0	; 02329700
	mov r1,#0x0	; 02329702
	bl loc_02329534	; 02329704
	add r4,r0,#0x0	; 02329708
	cmp r4,#0x0	; 0232970A
	beq loc_0232973E	; 0232970C
loc_0232970E:
	ldr r0,[r4,#0x18]	; 0232970E
	cmp r0,r5	; 02329710
	bhi loc_02329730	; 02329712
	ldr r0,[r4,#0x1c]	; 02329714
	cmp r5,r0	; 02329716
	bcs loc_02329730	; 02329718
	add r0,r4,#0x0	; 0232971A
	add r0,#0xc	; 0232971C
	add r1,r5,#0x0	; 0232971E
	bl loc_023296FC	; 02329720
	cmp r0,#0x0	; 02329724
	bne loc_02329740	; 02329726
	add r0,r4,#0x0	; 02329728
	pop {r4,r5,r6}	; 0232972A
	pop {r3}	; 0232972C
	bx r3	; 0232972E
loc_02329730:
	add r0,r6,#0x0	; 02329730
	add r1,r4,#0x0	; 02329732
	bl loc_02329534	; 02329734
	add r4,r0,#0x0	; 02329738
	cmp r4,#0x0	; 0232973A
	bne loc_0232970E	; 0232973C
loc_0232973E:
	mov r0,#0x0	; 0232973E
loc_02329740:
	pop {r4,r5,r6}	; 02329740
	pop {r3}	; 02329742
	bx r3	; 02329744
	.byte 0x00, 0x00	; 02329746
P1_Entry_02329748:
	push {r4,r5,lr}	; 02329748
	sub sp,#0xc	; 0232974A
	add r5,r0,#0x0	; 0232974C
	add r5,#0x24	; 0232974E
	add r4,r1,#0x0	; 02329750
	sub r4,#0x10	; 02329752
	add r0,sp,#0x0	; 02329754
	add r1,r4,#0x0	; 02329756
	bl P1_Entry_02329B2C	; 02329758
	add r0,r5,#0x0	; 0232975C
	add r0,#0x8	; 0232975E
	add r1,r4,#0x0	; 02329760
	bl P1_Entry_02329B10	; 02329762
	add r0,r5,#0x0	; 02329766
	add r1,sp,#0x0	; 02329768
	bl P1_Entry_023297D0	; 0232976A
	add sp,#0xc	; 0232976E
	pop {r4,r5}	; 02329770
	pop {r3}	; 02329772
	bx r3	; 02329774
	.byte 0x00, 0x00	; 02329776
P1_Entry_02329778:
	push {lr}	; 02329778
	sub sp,#0x4	; 0232977A
	cmp r1,#0x0	; 0232977C
	bne P1_Entry_02329782	; 0232977E
	mov r1,#0x1	; 02329780
P1_Entry_02329782:
	add r1,r1,#0x3	; 02329782
	mov r3,#0x3	; 02329784
	bic r1,r3	; 02329786
	cmp r2,#0x0	; 02329788
	blt P1_Entry_02329796	; 0232978A
	bl P1_Entry_023298EC	; 0232978C
	add sp,#0x4	; 02329790
	pop {r3}	; 02329792
	bx r3	; 02329794
P1_Entry_02329796:
	neg r2,r2	; 02329796
	bl P1_Entry_02329864	; 02329798
	add sp,#0x4	; 0232979C
	pop {r3}	; 0232979E
	bx r3	; 023297A0
	.byte 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x09, 0x18, 0x03, 0x23, 0x99, 0x43, 0xC0, 0x1C, 0x98, 0x43	; 023297A2
	.byte 0x88, 0x42, 0x02, 0xD8, 0x0B, 0x1A, 0x4C, 0x2B, 0x03, 0xD2, 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC	; 023297B2
	.byte 0x18, 0x47, 0x00, 0xF0, 0x5C, 0xF9, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0x00, 0x00	; 023297C2
P1_Entry_023297D0:
	push {r4,r5,r6,lr}	; 023297D0
	sub sp,#0x8	; 023297D2
	add r6,r0,#0x0	; 023297D4
	add r5,r1,#0x0	; 023297D6
	mov r4,#0x0	; 023297D8
	ldr r1,[r5,#0x0]	; 023297DA
	ldr r0,[r5,#0x4]	; 023297DC
	str r1,[sp,#0x0]	; 023297DE
	str r0,[sp,#0x4]	; 023297E0
	ldr r1,[r6,#0x0]	; 023297E2
	cmp r1,#0x0	; 023297E4
	beq P1_Entry_02329810	; 023297E6
	ldr r0,[r5,#0x0]	; 023297E8
P1_Entry_023297EA:
	cmp r1,r0	; 023297EA
	bcs P1_Entry_023297F2	; 023297EC
	add r4,r1,#0x0	; 023297EE
	b P1_Entry_0232980A	; 023297F0
P1_Entry_023297F2:
	ldr r0,[r5,#0x4]	; 023297F2
	cmp r1,r0	; 023297F4
	bne P1_Entry_02329810	; 023297F6
	ldr r2,[r1,#0x4]	; 023297F8
	add r0,r1,#0x0	; 023297FA
	add r0,#0x10	; 023297FC
	add r0,r2,r0	; 023297FE
	str r0,[sp,#0x4]	; 02329800
	add r0,r6,#0x0	; 02329802
	bl P1_Entry_02329B10	; 02329804
	b P1_Entry_02329810	; 02329808
P1_Entry_0232980A:
	ldr r1,[r1,#0xc]	; 0232980A
	cmp r1,#0x0	; 0232980C
	bne P1_Entry_023297EA	; 0232980E
P1_Entry_02329810:
	cmp r4,#0x0	; 02329810
	beq P1_Entry_0232982E	; 02329812
	ldr r1,[r4,#0x4]	; 02329814
	add r0,r4,#0x0	; 02329816
	add r0,#0x10	; 02329818
	add r1,r1,r0	; 0232981A
	ldr r0,[r5,#0x0]	; 0232981C
	cmp r1,r0	; 0232981E
	bne P1_Entry_0232982E	; 02329820
	str r4,[sp,#0x0]	; 02329822
	add r0,r6,#0x0	; 02329824
	add r1,r4,#0x0	; 02329826
	bl P1_Entry_02329B10	; 02329828
	add r4,r0,#0x0	; 0232982C
P1_Entry_0232982E:
	ldr r1,[sp,#0x4]	; 0232982E
	ldr r0,[sp,#0x0]	; 02329830
	sub r0,r1,r0	; 02329832
	cmp r0,#0x10	; 02329834
	bcs P1_Entry_02329842	; 02329836
	mov r0,#0x0	; 02329838
	add sp,#0x8	; 0232983A
	pop {r4,r5,r6}	; 0232983C
	pop {r3}	; 0232983E
	bx r3	; 02329840
P1_Entry_02329842:
	add r0,sp,#0x0	; 02329842
	ldr r1,[pool_02329860]	; 02329844
	bl loc_02329AD4	; 02329846
	add r1,r0,#0x0	; 0232984A
	add r0,r6,#0x0	; 0232984C
	add r2,r4,#0x0	; 0232984E
	bl P1_Entry_02329AF0	; 02329850
	mov r0,#0x1	; 02329854
	add sp,#0x8	; 02329856
	pop {r4,r5,r6}	; 02329858
	pop {r3}	; 0232985A
	bx r3	; 0232985C
	.byte 0xC0, 0x46	; 0232985E
pool_02329860:
	.word 0x00004652	; 02329860
P1_Entry_02329864:
	push {r4,r5,r6,r7,lr}	; 02329864
	sub sp,#0x14	; 02329866
	add r3,r1,#0x0	; 02329868
	str r0,[sp,#0xc]	; 0232986A
	add r0,#0x24	; 0232986C
	str r0,[sp,#0xc]	; 0232986E
	ldrh r0,[r0,#0x12]	; 02329870
	mov r7,#0x1	; 02329872
	and r0,r7	; 02329874
	lsl r0,r0,#0x10	; 02329876
	lsr r0,r0,#0x10	; 02329878
	cmp r0,#0x0	; 0232987A
	beq P1_Entry_02329880	; 0232987C
	mov r7,#0x0	; 0232987E
P1_Entry_02329880:
	mov r0,#0x0	; 02329880
	str r0,[sp,#0x4]	; 02329882
	mvn r0,r0	; 02329884
	ldr r1,[sp,#0x4]	; 02329886
	str r1,[sp,#0x8]	; 02329888
	ldr r1,[sp,#0xc]	; 0232988A
	ldr r1,[r1,#0x4]	; 0232988C
	cmp r1,#0x0	; 0232988E
	beq P1_Entry_023298C4	; 02329890
	sub r2,r2,#0x1	; 02329892
	mvn r2,r2	; 02329894
	str r2,[sp,#0x10]	; 02329896
P1_Entry_02329898:
	add r6,r1,#0x0	; 02329898
	add r6,#0x10	; 0232989A
	ldr r5,[r1,#0x4]	; 0232989C
	add r2,r5,r6	; 0232989E
	sub r2,r2,r3	; 023298A0
	ldr r4,[sp,#0x10]	; 023298A2
	and r4,r2	; 023298A4
	sub r2,r4,r6	; 023298A6
	cmp r2,#0x0	; 023298A8
	blt P1_Entry_023298BE	; 023298AA
	cmp r0,r5	; 023298AC
	bls P1_Entry_023298BE	; 023298AE
	str r1,[sp,#0x4]	; 023298B0
	add r0,r5,#0x0	; 023298B2
	str r4,[sp,#0x8]	; 023298B4
	cmp r7,#0x0	; 023298B6
	bne P1_Entry_023298C4	; 023298B8
	cmp r5,r3	; 023298BA
	beq P1_Entry_023298C4	; 023298BC
P1_Entry_023298BE:
	ldr r1,[r1,#0x8]	; 023298BE
	cmp r1,#0x0	; 023298C0
	bne P1_Entry_02329898	; 023298C2
P1_Entry_023298C4:
	ldr r0,[sp,#0x4]	; 023298C4
	cmp r0,#0x0	; 023298C6
	beq P1_Entry_023298E0	; 023298C8
	mov r0,#0x1	; 023298CA
	str r0,[sp,#0x0]	; 023298CC
	ldr r0,[sp,#0xc]	; 023298CE
	ldr r1,[sp,#0x4]	; 023298D0
	ldr r2,[sp,#0x8]	; 023298D2
	bl P1_Entry_02329974	; 023298D4
	add sp,#0x14	; 023298D8
	pop {r4,r5,r6,r7}	; 023298DA
	pop {r3}	; 023298DC
	bx r3	; 023298DE
P1_Entry_023298E0:
	mov r0,#0x0	; 023298E0
	add sp,#0x14	; 023298E2
	pop {r4,r5,r6,r7}	; 023298E4
	pop {r3}	; 023298E6
	bx r3	; 023298E8
	.byte 0x00, 0x00	; 023298EA
P1_Entry_023298EC:
	push {r4,r5,r6,r7,lr}	; 023298EC
	sub sp,#0x14	; 023298EE
	add r3,r1,#0x0	; 023298F0
	str r0,[sp,#0xc]	; 023298F2
	add r0,#0x24	; 023298F4
	str r0,[sp,#0xc]	; 023298F6
	ldrh r0,[r0,#0x12]	; 023298F8
	mov r7,#0x1	; 023298FA
	and r0,r7	; 023298FC
	lsl r0,r0,#0x10	; 023298FE
	lsr r0,r0,#0x10	; 02329900
	cmp r0,#0x0	; 02329902
	beq P1_Entry_02329908	; 02329904
	mov r7,#0x0	; 02329906
P1_Entry_02329908:
	mov r0,#0x0	; 02329908
	str r0,[sp,#0x4]	; 0232990A
	mvn r0,r0	; 0232990C
	ldr r1,[sp,#0x4]	; 0232990E
	str r1,[sp,#0x8]	; 02329910
	ldr r1,[sp,#0xc]	; 02329912
	ldr r1,[r1,#0x0]	; 02329914
	cmp r1,#0x0	; 02329916
	beq P1_Entry_0232994C	; 02329918
	sub r6,r2,#0x1	; 0232991A
	mvn r2,r6	; 0232991C
	str r2,[sp,#0x10]	; 0232991E
P1_Entry_02329920:
	add r5,r1,#0x0	; 02329920
	add r5,#0x10	; 02329922
	add r2,r6,r5	; 02329924
	ldr r4,[sp,#0x10]	; 02329926
	and r4,r2	; 02329928
	ldr r2,[r1,#0x4]	; 0232992A
	sub r5,r4,r5	; 0232992C
	add r5,r3,r5	; 0232992E
	cmp r2,r5	; 02329930
	bcc P1_Entry_02329946	; 02329932
	cmp r0,r2	; 02329934
	bls P1_Entry_02329946	; 02329936
	str r1,[sp,#0x4]	; 02329938
	add r0,r2,#0x0	; 0232993A
	str r4,[sp,#0x8]	; 0232993C
	cmp r7,#0x0	; 0232993E
	bne P1_Entry_0232994C	; 02329940
	cmp r2,r3	; 02329942
	beq P1_Entry_0232994C	; 02329944
P1_Entry_02329946:
	ldr r1,[r1,#0xc]	; 02329946
	cmp r1,#0x0	; 02329948
	bne P1_Entry_02329920	; 0232994A
P1_Entry_0232994C:
	ldr r0,[sp,#0x4]	; 0232994C
	cmp r0,#0x0	; 0232994E
	beq P1_Entry_02329968	; 02329950
	mov r0,#0x0	; 02329952
	str r0,[sp,#0x0]	; 02329954
	ldr r0,[sp,#0xc]	; 02329956
	ldr r1,[sp,#0x4]	; 02329958
	ldr r2,[sp,#0x8]	; 0232995A
	bl P1_Entry_02329974	; 0232995C
	add sp,#0x14	; 02329960
	pop {r4,r5,r6,r7}	; 02329962
	pop {r3}	; 02329964
	bx r3	; 02329966
P1_Entry_02329968:
	mov r0,#0x0	; 02329968
	add sp,#0x14	; 0232996A
	pop {r4,r5,r6,r7}	; 0232996C
	pop {r3}	; 0232996E
	bx r3	; 02329970
	.byte 0x00, 0x00	; 02329972
P1_Entry_02329974:
	push {r4,r5,r6,r7,lr}	; 02329974
	sub sp,#0x1c	; 02329976
	add r5,r0,#0x0	; 02329978
	add r7,r1,#0x0	; 0232997A
	add r4,r2,#0x0	; 0232997C
	add r6,r3,#0x0	; 0232997E
	add r0,sp,#0x0	; 02329980
	bl P1_Entry_02329B2C	; 02329982
	ldr r0,[sp,#0x4]	; 02329986
	str r0,[sp,#0xc]	; 02329988
	add r0,r6,r4	; 0232998A
	str r0,[sp,#0x8]	; 0232998C
	add r6,r4,#0x0	; 0232998E
	sub r6,#0x10	; 02329990
	str r6,[sp,#0x4]	; 02329992
	add r0,r5,#0x0	; 02329994
	add r1,r7,#0x0	; 02329996
	bl P1_Entry_02329B10	; 02329998
	add r7,r0,#0x0	; 0232999C
	ldr r1,[sp,#0x0]	; 0232999E
	ldr r0,[sp,#0x4]	; 023299A0
	sub r0,r0,r1	; 023299A2
	cmp r0,#0x10	; 023299A4
	bcs P1_Entry_023299AC	; 023299A6
	str r1,[sp,#0x4]	; 023299A8
	b P1_Entry_023299C0	; 023299AA
P1_Entry_023299AC:
	add r0,sp,#0x0	; 023299AC
	ldr r1,[pool_02329A70]	; 023299AE
	bl loc_02329AD4	; 023299B0
	add r1,r0,#0x0	; 023299B4
	add r0,r5,#0x0	; 023299B6
	add r2,r7,#0x0	; 023299B8
	bl P1_Entry_02329AF0	; 023299BA
	add r7,r0,#0x0	; 023299BE
P1_Entry_023299C0:
	ldr r1,[sp,#0xc]	; 023299C0
	ldr r0,[sp,#0x8]	; 023299C2
	sub r0,r1,r0	; 023299C4
	cmp r0,#0x10	; 023299C6
	bcs P1_Entry_023299CE	; 023299C8
	str r1,[sp,#0x8]	; 023299CA
	b P1_Entry_023299E0	; 023299CC
P1_Entry_023299CE:
	add r0,sp,#0x8	; 023299CE
	ldr r1,[pool_02329A70]	; 023299D0
	bl loc_02329AD4	; 023299D2
	add r1,r0,#0x0	; 023299D6
	add r0,r5,#0x0	; 023299D8
	add r2,r7,#0x0	; 023299DA
	bl P1_Entry_02329AF0	; 023299DC
P1_Entry_023299E0:
	ldr r1,[sp,#0x4]	; 023299E0
	ldr r0,[sp,#0x8]	; 023299E2
	sub r2,r0,r1	; 023299E4
	sub r0,r5,#0x4	; 023299E6
	ldr r3,[r0,#0x0]	; 023299E8
	mov r0,#0xff	; 023299EA
	and r3,r0	; 023299EC
	lsl r0,r3,#0x10	; 023299EE
	lsr r3,r0,#0x10	; 023299F0
	mov r0,#0x1	; 023299F2
	and r3,r0	; 023299F4
	cmp r3,#0x0	; 023299F6
	beq P1_Entry_02329A04	; 023299F8
	mov r0,#0x0	; 023299FA
	str r0,[sp,#0x18]	; 023299FC
	ldr r0,[sp,#0x18]	; 023299FE
	blx P1_MemFill32	; 02329A00
P1_Entry_02329A04:
	str r6,[sp,#0x10]	; 02329A04
	ldr r0,[sp,#0x8]	; 02329A06
	str r0,[sp,#0x14]	; 02329A08
	add r0,sp,#0x10	; 02329A0A
	ldr r1,[pool_02329A74]	; 02329A0C
	bl loc_02329AD4	; 02329A0E
	add r1,r0,#0x0	; 02329A12
	ldrh r2,[r1,#0x2]	; 02329A14
	ldr r0,[pool_02329A78]	; 02329A16
	and r2,r0	; 02329A18
	strh r2,[r1,#0x2]	; 02329A1A
	ldrh r0,[r1,#0x2]	; 02329A1C
	add r2,sp,#0x20	; 02329A1E
	ldrh r3,[r2,#0x10]	; 02329A20
	mov r2,#0x1	; 02329A22
	and r3,r2	; 02329A24
	lsl r2,r3,#0xf	; 02329A26
	orr r0,r2	; 02329A28
	strh r0,[r1,#0x2]	; 02329A2A
	ldr r0,[sp,#0x4]	; 02329A2C
	sub r3,r1,r0	; 02329A2E
	ldrh r2,[r1,#0x2]	; 02329A30
	ldr r0,[pool_02329A7C]	; 02329A32
	and r2,r0	; 02329A34
	strh r2,[r1,#0x2]	; 02329A36
	ldrh r0,[r1,#0x2]	; 02329A38
	lsl r2,r3,#0x10	; 02329A3A
	lsr r3,r2,#0x10	; 02329A3C
	mov r2,#0x7f	; 02329A3E
	and r3,r2	; 02329A40
	lsl r2,r3,#0x8	; 02329A42
	orr r0,r2	; 02329A44
	strh r0,[r1,#0x2]	; 02329A46
	ldrh r3,[r5,#0x10]	; 02329A48
	mov r0,#0xff	; 02329A4A
	and r3,r0	; 02329A4C
	ldrh r2,[r1,#0x2]	; 02329A4E
	bic r2,r0	; 02329A50
	strh r2,[r1,#0x2]	; 02329A52
	ldrh r0,[r1,#0x2]	; 02329A54
	orr r0,r3	; 02329A56
	strh r0,[r1,#0x2]	; 02329A58
	add r0,r5,#0x0	; 02329A5A
	add r0,#0x8	; 02329A5C
	ldr r2,[r5,#0xc]	; 02329A5E
	bl P1_Entry_02329AF0	; 02329A60
	add r0,r4,#0x0	; 02329A64
	add sp,#0x1c	; 02329A66
	pop {r4,r5,r6,r7}	; 02329A68
	pop {r3}	; 02329A6A
	bx r3	; 02329A6C
	.byte 0xC0, 0x46	; 02329A6E
pool_02329A70:
	.word 0x00004652	; 02329A70
pool_02329A74:
	.word 0x00005544	; 02329A74
pool_02329A78:
	.word 0xFFFF7FFF	; 02329A78
pool_02329A7C:
	.word 0xFFFF80FF	; 02329A7C

; ===== function loc_02329A80 =====
	push {r4,r5,lr}	; 02329A80
	sub sp,#0xc	; 02329A82
	add r5,r0,#0x0	; 02329A84
	add r3,r1,#0x0	; 02329A86
	add r4,r5,#0x0	; 02329A88
	add r4,#0x24	; 02329A8A
	str r2,[sp,#0x0]	; 02329A8C
	ldr r1,[pool_02329ACC]	; 02329A8E
	add r2,r4,#0x0	; 02329A90
	add r2,#0x14	; 02329A92
	bl loc_02329678	; 02329A94
	mov r0,#0x0	; 02329A98
	strh r0,[r4,#0x10]	; 02329A9A
	strh r0,[r4,#0x12]	; 02329A9C
	ldrh r1,[r4,#0x12]	; 02329A9E
	mov r0,#0x1	; 02329AA0
	bic r1,r0	; 02329AA2
	strh r1,[r4,#0x12]	; 02329AA4
	ldr r0,[r5,#0x18]	; 02329AA6
	str r0,[sp,#0x4]	; 02329AA8
	ldr r0,[r5,#0x1c]	; 02329AAA
	str r0,[sp,#0x8]	; 02329AAC
	add r0,sp,#0x4	; 02329AAE
	ldr r1,[pool_02329AD0]	; 02329AB0
	bl loc_02329AD4	; 02329AB2
	str r0,[r5,#0x24]	; 02329AB6
	str r0,[r4,#0x4]	; 02329AB8
	mov r0,#0x0	; 02329ABA
	str r0,[r4,#0x8]	; 02329ABC
	str r0,[r4,#0xc]	; 02329ABE
	add r0,r5,#0x0	; 02329AC0
	add sp,#0xc	; 02329AC2
	pop {r4,r5}	; 02329AC4
	pop {r3}	; 02329AC6
	bx r3	; 02329AC8
	.byte 0xC0, 0x46	; 02329ACC
pool_02329ACC:
loc_02329ACC:
	.word 0x45585048	; 02329ACC
pool_02329AD0:
loc_02329AD0:
	.word 0x00004652	; 02329AD0

; ===== function loc_02329AD4 =====
loc_02329AD4:
	ldr r3,[r0,#0x0]	; 02329AD4
	strh r1,[r3,#0x0]	; 02329AD6
	mov r2,#0x0	; 02329AD8
	strh r2,[r3,#0x2]	; 02329ADA
	ldr r1,[r0,#0x4]	; 02329ADC
	add r0,r3,#0x0	; 02329ADE
	add r0,#0x10	; 02329AE0
	sub r0,r1,r0	; 02329AE2
	str r0,[r3,#0x4]	; 02329AE4
	str r2,[r3,#0x8]	; 02329AE6
	str r2,[r3,#0xc]	; 02329AE8
	add r0,r3,#0x0	; 02329AEA
	bx lr	; 02329AEC
	.byte 0x00, 0x00	; 02329AEE
P1_Entry_02329AF0:
	str r2,[r1,#0x8]	; 02329AF0
	cmp r2,#0x0	; 02329AF2
	beq P1_Entry_02329AFC	; 02329AF4
	ldr r3,[r2,#0xc]	; 02329AF6
	str r1,[r2,#0xc]	; 02329AF8
	b P1_Entry_02329B00	; 02329AFA
P1_Entry_02329AFC:
	ldr r3,[r0,#0x0]	; 02329AFC
	str r1,[r0,#0x0]	; 02329AFE
P1_Entry_02329B00:
	str r3,[r1,#0xc]	; 02329B00
	cmp r3,#0x0	; 02329B02
	beq P1_Entry_02329B0A	; 02329B04
	str r1,[r3,#0x8]	; 02329B06
	b P1_Entry_02329B0C	; 02329B08
P1_Entry_02329B0A:
	str r1,[r0,#0x4]	; 02329B0A
P1_Entry_02329B0C:
	add r0,r1,#0x0	; 02329B0C
	bx lr	; 02329B0E
P1_Entry_02329B10:
	ldr r2,[r1,#0x8]	; 02329B10
	ldr r1,[r1,#0xc]	; 02329B12
	cmp r2,#0x0	; 02329B14
	beq P1_Entry_02329B1C	; 02329B16
	str r1,[r2,#0xc]	; 02329B18
	b P1_Entry_02329B1E	; 02329B1A
P1_Entry_02329B1C:
	str r1,[r0,#0x0]	; 02329B1C
P1_Entry_02329B1E:
	cmp r1,#0x0	; 02329B1E
	beq P1_Entry_02329B26	; 02329B20
	str r2,[r1,#0x8]	; 02329B22
	b P1_Entry_02329B28	; 02329B24
P1_Entry_02329B26:
	str r2,[r0,#0x4]	; 02329B26
P1_Entry_02329B28:
	add r0,r2,#0x0	; 02329B28
	bx lr	; 02329B2A
P1_Entry_02329B2C:
	ldrh r2,[r1,#0x2]	; 02329B2C
	asr r3,r2,#0x8	; 02329B2E
	mov r2,#0x7f	; 02329B30
	and r3,r2	; 02329B32
	lsl r2,r3,#0x10	; 02329B34
	lsr r2,r2,#0x10	; 02329B36
	sub r2,r1,r2	; 02329B38
	str r2,[r0,#0x0]	; 02329B3A
	ldr r2,[r1,#0x4]	; 02329B3C
	add r1,#0x10	; 02329B3E
	add r1,r2,r1	; 02329B40
	str r1,[r0,#0x4]	; 02329B42
	bx lr	; 02329B44
	.byte 0x00, 0x00	; 02329B46

; ===== function loc_02329B48 =====
loc_02329B48:
	push {r4,r5,lr}	; 02329B48
	sub sp,#0x4	; 02329B4A
	add r5,r0,#0x0	; 02329B4C
	add r4,r1,#0x0	; 02329B4E
	mov r1,#0x1	; 02329B50
	add r2,r4,#0x0	; 02329B52
	and r2,r1	; 02329B54
	cmp r2,#0x0	; 02329B56
	beq loc_02329B5E	; 02329B58
	bl loc_02329BF0	; 02329B5A
loc_02329B5E:
	mov r0,#0x2	; 02329B5E
	and r4,r0	; 02329B60
	cmp r4,#0x0	; 02329B62
	beq loc_02329B6C	; 02329B64
	add r0,r5,#0x0	; 02329B66
	bl loc_02329BD4	; 02329B68
loc_02329B6C:
	add sp,#0x4	; 02329B6C
	pop {r4,r5}	; 02329B6E
	pop {r3}	; 02329B70
	bx r3	; 02329B72

; ===== function loc_02329B74 =====
loc_02329B74:
	push {lr}	; 02329B74
	sub sp,#0x4	; 02329B76
	add r0,#0x24	; 02329B78
	cmp r1,#0x0	; 02329B7A
	bne loc_02329B80	; 02329B7C
	mov r1,#0x1	; 02329B7E
loc_02329B80:
	add r1,r1,#0x3	; 02329B80
	mov r3,#0x3	; 02329B82
	bic r1,r3	; 02329B84
	cmp r2,#0x0	; 02329B86
	blt loc_02329B94	; 02329B88
	bl loc_02329C50	; 02329B8A
	add sp,#0x4	; 02329B8E
	pop {r3}	; 02329B90
	bx r3	; 02329B92
loc_02329B94:
	neg r2,r2	; 02329B94
	bl loc_02329C00	; 02329B96
	add sp,#0x4	; 02329B9A
	pop {r3}	; 02329B9C
	bx r3	; 02329B9E

; ===== function loc_02329BA0 =====
loc_02329BA0:
	ldr r3,[pool_02329BA4]	; 02329BA0
	bx r3	; 02329BA2
pool_02329BA4:
loc_02329BA4:
	.word loc_02329664 + 1	; 02329BA4

; ===== function loc_02329BA8 =====
loc_02329BA8:
	push {lr}	; 02329BA8
	sub sp,#0x4	; 02329BAA
	add r1,r1,r0	; 02329BAC
	mov r3,#0x3	; 02329BAE
	bic r1,r3	; 02329BB0
	add r0,r0,#0x3	; 02329BB2
	bic r0,r3	; 02329BB4
	cmp r0,r1	; 02329BB6
	bhi loc_02329BC0	; 02329BB8
	sub r3,r1,r0	; 02329BBA
	cmp r3,#0x30	; 02329BBC
	bcs loc_02329BC8	; 02329BBE
loc_02329BC0:
	mov r0,#0x0	; 02329BC0
	add sp,#0x4	; 02329BC2
	pop {r3}	; 02329BC4
	bx r3	; 02329BC6
loc_02329BC8:
	bl loc_02329CA0	; 02329BC8
	add sp,#0x4	; 02329BCC
	pop {r3}	; 02329BCE
	bx r3	; 02329BD0
	.byte 0x00, 0x00	; 02329BD4

; ===== function loc_02329BD4 =====
loc_02329BD4:
	add r2,r0,#0x0	; 02329BD4
	add r2,#0x24	; 02329BD6
	ldr r3,[r2,#0x8]	; 02329BD8
	cmp r3,#0x0	; 02329BDA
	beq loc_02329BE8	; 02329BDC
loc_02329BDE:
	ldr r1,[r0,#0x1c]	; 02329BDE
	str r1,[r3,#0x8]	; 02329BE0
	ldr r3,[r3,#0xc]	; 02329BE2
	cmp r3,#0x0	; 02329BE4
	bne loc_02329BDE	; 02329BE6
loc_02329BE8:
	ldr r0,[r0,#0x1c]	; 02329BE8
	str r0,[r2,#0x4]	; 02329BEA
	bx lr	; 02329BEC
	.byte 0x00, 0x00	; 02329BF0

; ===== function loc_02329BF0 =====
loc_02329BF0:
	add r2,r0,#0x0	; 02329BF0
	add r2,#0x24	; 02329BF2
	ldr r1,[r0,#0x18]	; 02329BF4
	str r1,[r0,#0x24]	; 02329BF6
	mov r0,#0x0	; 02329BF8
	str r0,[r2,#0x8]	; 02329BFA
	bx lr	; 02329BFC
	.byte 0x00, 0x00	; 02329C00

; ===== function loc_02329C00 =====
loc_02329C00:
	push {r4,r5,lr}	; 02329C00
	sub sp,#0x4	; 02329C02
	add r5,r0,#0x0	; 02329C04
	ldr r0,[r5,#0x4]	; 02329C06
	sub r2,r2,#0x1	; 02329C08
	mvn r4,r2	; 02329C0A
	sub r1,r0,r1	; 02329C0C
	and r4,r1	; 02329C0E
	ldr r1,[r5,#0x0]	; 02329C10
	cmp r4,r1	; 02329C12
	bcs loc_02329C20	; 02329C14
	mov r0,#0x0	; 02329C16
	add sp,#0x4	; 02329C18
	pop {r4,r5}	; 02329C1A
	pop {r3}	; 02329C1C
	bx r3	; 02329C1E
loc_02329C20:
	sub r2,r0,r4	; 02329C20
	sub r0,r5,#0x4	; 02329C22
	ldr r1,[r0,#0x0]	; 02329C24
	mov r0,#0xff	; 02329C26
	and r1,r0	; 02329C28
	lsl r0,r1,#0x10	; 02329C2A
	lsr r1,r0,#0x10	; 02329C2C
	mov r0,#0x1	; 02329C2E
	and r1,r0	; 02329C30
	cmp r1,#0x0	; 02329C32
	beq loc_02329C42	; 02329C34
	mov r0,#0x0	; 02329C36
	str r0,[sp,#0x0]	; 02329C38
	ldr r0,[sp,#0x0]	; 02329C3A
	add r1,r4,#0x0	; 02329C3C
	blx loc_0232DDE0	; 02329C3E
loc_02329C42:
	str r4,[r5,#0x4]	; 02329C42
	add r0,r4,#0x0	; 02329C44
	add sp,#0x4	; 02329C46
	pop {r4,r5}	; 02329C48
	pop {r3}	; 02329C4A
	bx r3	; 02329C4C
	.byte 0x00, 0x00	; 02329C50

; ===== function loc_02329C50 =====
loc_02329C50:
	push {r4,r5,r6,lr}	; 02329C50
	sub sp,#0x8	; 02329C52
	add r5,r0,#0x0	; 02329C54
	ldr r3,[r5,#0x0]	; 02329C56
	sub r0,r2,#0x1	; 02329C58
	mvn r4,r0	; 02329C5A
	add r0,r0,r3	; 02329C5C
	and r4,r0	; 02329C5E
	add r6,r1,r4	; 02329C60
	ldr r0,[r5,#0x4]	; 02329C62
	cmp r6,r0	; 02329C64
	bls loc_02329C72	; 02329C66
	mov r0,#0x0	; 02329C68
	add sp,#0x8	; 02329C6A
	pop {r4,r5,r6}	; 02329C6C
	pop {r3}	; 02329C6E
	bx r3	; 02329C70
loc_02329C72:
	sub r2,r6,r3	; 02329C72
	sub r0,r5,#0x4	; 02329C74
	ldr r1,[r0,#0x0]	; 02329C76
	mov r0,#0xff	; 02329C78
	and r1,r0	; 02329C7A
	lsl r0,r1,#0x10	; 02329C7C
	lsr r1,r0,#0x10	; 02329C7E
	mov r0,#0x1	; 02329C80
	and r1,r0	; 02329C82
	cmp r1,#0x0	; 02329C84
	beq loc_02329C94	; 02329C86
	mov r0,#0x0	; 02329C88
	str r0,[sp,#0x0]	; 02329C8A
	ldr r0,[sp,#0x0]	; 02329C8C
	add r1,r3,#0x0	; 02329C8E
	blx loc_0232DDE0	; 02329C90
loc_02329C94:
	str r6,[r5,#0x0]	; 02329C94
	add r0,r4,#0x0	; 02329C96
	add sp,#0x8	; 02329C98
	pop {r4,r5,r6}	; 02329C9A
	pop {r3}	; 02329C9C
	bx r3	; 02329C9E

; ===== function loc_02329CA0 =====
loc_02329CA0:
	push {r4,r5,lr}	; 02329CA0
	sub sp,#0x4	; 02329CA2
	add r5,r0,#0x0	; 02329CA4
	add r3,r1,#0x0	; 02329CA6
	add r4,r5,#0x0	; 02329CA8
	add r4,#0x24	; 02329CAA
	str r2,[sp,#0x0]	; 02329CAC
	ldr r1,[pool_02329CD0]	; 02329CAE
	add r2,r4,#0x0	; 02329CB0
	add r2,#0xc	; 02329CB2
	bl loc_02329678	; 02329CB4
	ldr r0,[r5,#0x18]	; 02329CB8
	str r0,[r5,#0x24]	; 02329CBA
	ldr r0,[r5,#0x1c]	; 02329CBC
	str r0,[r4,#0x4]	; 02329CBE
	mov r0,#0x0	; 02329CC0
	str r0,[r4,#0x8]	; 02329CC2
	add r0,r5,#0x0	; 02329CC4
	add sp,#0x4	; 02329CC6
	pop {r4,r5}	; 02329CC8
	pop {r3}	; 02329CCA
	bx r3	; 02329CCC
	.byte 0xC0, 0x46	; 02329CD0
pool_02329CD0:
loc_02329CD0:
	.word 0x46524D48	; 02329CD0

; ===== function loc_02329CD4 =====
loc_02329CD4:
	ldr r3,[pool_02329CD8]	; 02329CD4
	bx r3	; 02329CD6
pool_02329CD8:
loc_02329CD8:
	.word P1_ResetDualBufferBuffers + 1	; 02329CD8

; ===== function loc_02329CDC =====
loc_02329CDC:
	push {r4,lr}	; 02329CDC
	bl P1_ApplyDualBufferProcessorSettings	; 02329CDE
	mov r0,#0x0	; 02329CE2
	add r1,r0,#0x0	; 02329CE4
	add r2,r0,#0x0	; 02329CE6
	add r3,r0,#0x0	; 02329CE8
	bl loc_0232E094	; 02329CEA
	bl loc_0232E2AC	; 02329CEE
	add r4,r0,#0x0	; 02329CF2
	mov r0,#0x1	; 02329CF4
	bl loc_0232E318	; 02329CF6
	add r0,r4,#0x0	; 02329CFA
	bl loc_0232E2CC	; 02329CFC
	pop {r4}	; 02329D00
	pop {r3}	; 02329D02
	bx r3	; 02329D04
	.byte 0x00, 0x00	; 02329D08

; ===== function loc_02329D08 =====
loc_02329D08:
	push {r4,lr}	; 02329D08
	mov r4,#0x0	; 02329D0A
loc_02329D0C:
	add r0,r4,#0x0	; 02329D0C
	bl loc_0232E470	; 02329D0E
	cmp r0,#0x0	; 02329D12
	bne loc_02329D0C	; 02329D14
	bl loc_0232A288	; 02329D16
	bl P1_UpdateDualBufferProcessorStatus	; 02329D1A
	mov r0,#0x0	; 02329D1E
	bl loc_0232E318	; 02329D20
	pop {r4}	; 02329D24
	pop {r3}	; 02329D26
	bx r3	; 02329D28
	.byte 0x00, 0x00	; 02329D2C

; ===== function loc_02329D2C =====
loc_02329D2C:
	push {lr}	; 02329D2C
	sub sp,#0x4	; 02329D2E
	ldr r0,[pool_02329D54]	; 02329D30
	ldr r1,[r0,#0x0]	; 02329D32
	cmp r1,#0x0	; 02329D34
	bne loc_02329D4C	; 02329D36
	mov r1,#0x1	; 02329D38
	str r1,[r0,#0x0]	; 02329D3A
	bl loc_0232DECC	; 02329D3C
	bl loc_02329E24	; 02329D40
	bl P1_ClearDualBufferProcessorAndQueueState	; 02329D44
	bl loc_0232A378	; 02329D48
loc_02329D4C:
	add sp,#0x4	; 02329D4C
	pop {r3}	; 02329D4E
	bx r3	; 02329D50
	.byte 0xC0, 0x46	; 02329D54
pool_02329D54:
loc_02329D54:
	.word P1_BssStart + 0x25A18	; 02329D54

; ===== function loc_02329D58 =====
loc_02329D58:
	ldr r1,[pool_02329D68]	; 02329D58
	ldr r3,[r1,#0x0]	; 02329D5A
	mov r2,#0x1	; 02329D5C
	lsl r2,r0	; 02329D5E
	bic r3,r2	; 02329D60
	str r3,[r1,#0x0]	; 02329D62
	bx lr	; 02329D64
	.byte 0xC0, 0x46	; 02329D68
pool_02329D68:
loc_02329D68:
	.word P1_BssStart + 0x25A20	; 02329D68

; ===== function loc_02329D6C =====
loc_02329D6C:
	mov r3,#0x1	; 02329D6C
	mov r0,#0x0	; 02329D6E
	ldr r1,[pool_02329D94]	; 02329D70
	ldr r2,[r1,#0x0]	; 02329D72
loc_02329D74:
	add r1,r2,#0x0	; 02329D74
	and r1,r3	; 02329D76
	cmp r1,#0x0	; 02329D78
	bne loc_02329D86	; 02329D7A
	ldr r1,[pool_02329D94]	; 02329D7C
	ldr r2,[r1,#0x0]	; 02329D7E
	orr r2,r3	; 02329D80
	str r2,[r1,#0x0]	; 02329D82
	bx lr	; 02329D84
loc_02329D86:
	add r0,r0,#0x1	; 02329D86
	lsl r3,r3,#0x1	; 02329D88
	cmp r0,#0x8	; 02329D8A
	blt loc_02329D74	; 02329D8C
	mov r0,#0x0	; 02329D8E
	mvn r0,r0	; 02329D90
	bx lr	; 02329D92
pool_02329D94:
loc_02329D94:
	.word P1_BssStart + 0x25A20	; 02329D94

; ===== function loc_02329D98 =====
loc_02329D98:
	ldr r1,[pool_02329DA4]	; 02329D98
	ldr r2,[r1,#0x0]	; 02329D9A
	bic r2,r0	; 02329D9C
	str r2,[r1,#0x0]	; 02329D9E
	bx lr	; 02329DA0
	.byte 0xC0, 0x46	; 02329DA4
pool_02329DA4:
loc_02329DA4:
	.word P1_BssStart + 0x25A1C	; 02329DA4

; ===== function loc_02329DA8 =====
loc_02329DA8:
	ldr r1,[pool_02329DC0]	; 02329DA8
	ldr r2,[r1,#0x0]	; 02329DAA
	add r3,r0,#0x0	; 02329DAC
	and r3,r2	; 02329DAE
	cmp r3,#0x0	; 02329DB0
	beq loc_02329DB8	; 02329DB2
	mov r0,#0x0	; 02329DB4
	bx lr	; 02329DB6
loc_02329DB8:
	orr r2,r0	; 02329DB8
	str r2,[r1,#0x0]	; 02329DBA
	mov r0,#0x1	; 02329DBC
	bx lr	; 02329DBE
pool_02329DC0:
loc_02329DC0:
	.word P1_BssStart + 0x25A1C	; 02329DC0

; ===== function loc_02329DC4 =====
loc_02329DC4:
	push {r4,lr}	; 02329DC4
	add r4,r0,#0x0	; 02329DC6
	cmp r4,#0x0	; 02329DC8
	beq loc_02329DDA	; 02329DCA
	mov r1,#0x0	; 02329DCC
	bl loc_0232DFF8	; 02329DCE
	ldr r0,[pool_02329DE0]	; 02329DD2
	ldr r1,[r0,#0x0]	; 02329DD4
	bic r1,r4	; 02329DD6
	str r1,[r0,#0x0]	; 02329DD8
loc_02329DDA:
	pop {r4}	; 02329DDA
	pop {r3}	; 02329DDC
	bx r3	; 02329DDE
pool_02329DE0:
loc_02329DE0:
	.word P1_BssStart + 0x25A24	; 02329DE0

; ===== function loc_02329DE4 =====
loc_02329DE4:
	push {r4,lr}	; 02329DE4
	add r4,r0,#0x0	; 02329DE6
	cmp r4,#0x0	; 02329DE8
	bne loc_02329DF4	; 02329DEA
	mov r0,#0x1	; 02329DEC
	pop {r4}	; 02329DEE
	pop {r3}	; 02329DF0
	bx r3	; 02329DF2
loc_02329DF4:
	ldr r1,[pool_02329E20]	; 02329DF4
	ldr r1,[r1,#0x0]	; 02329DF6
	add r2,r4,#0x0	; 02329DF8
	and r2,r1	; 02329DFA
	cmp r2,#0x0	; 02329DFC
	beq loc_02329E08	; 02329DFE
	mov r0,#0x0	; 02329E00
	pop {r4}	; 02329E02
	pop {r3}	; 02329E04
	bx r3	; 02329E06
loc_02329E08:
	mov r1,#0x0	; 02329E08
	bl loc_0232E014	; 02329E0A
	ldr r0,[pool_02329E20]	; 02329E0E
	ldr r1,[r0,#0x0]	; 02329E10
	orr r1,r4	; 02329E12
	str r1,[r0,#0x0]	; 02329E14
	mov r0,#0x1	; 02329E16
	pop {r4}	; 02329E18
	pop {r3}	; 02329E1A
	bx r3	; 02329E1C
	.byte 0xC0, 0x46	; 02329E20
pool_02329E20:
loc_02329E20:
	.word P1_BssStart + 0x25A24	; 02329E20

; ===== function loc_02329E24 =====
loc_02329E24:
	mov r1,#0x0	; 02329E24
	ldr r0,[pool_02329E34]	; 02329E26
	str r1,[r0,#0x0]	; 02329E28
	ldr r0,[pool_02329E38]	; 02329E2A
	str r1,[r0,#0x0]	; 02329E2C
	ldr r0,[pool_02329E3C]	; 02329E2E
	str r1,[r0,#0x0]	; 02329E30
	bx lr	; 02329E32
pool_02329E34:
loc_02329E34:
	.word P1_BssStart + 0x25A24	; 02329E34
pool_02329E38:
loc_02329E38:
	.word P1_BssStart + 0x25A1C	; 02329E38
pool_02329E3C:
loc_02329E3C:
	.word P1_BssStart + 0x25A20	; 02329E3C

; ===== function loc_02329E40 =====
loc_02329E40:
	push {r4,r5,r6,lr}	; 02329E40
	add r5,r0,#0x0	; 02329E42
	add r6,r1,#0x0	; 02329E44
	ldr r4,[r5,#0x4]	; 02329E46
	cmp r4,#0x0	; 02329E48
	beq loc_02329E58	; 02329E4A
	add r0,r4,#0x0	; 02329E4C
	add r1,r5,#0x0	; 02329E4E
	bl loc_02329544	; 02329E50
	mov r0,#0x0	; 02329E54
	str r0,[r5,#0x4]	; 02329E56
loc_02329E58:
	ldr r0,[pool_02329E80]	; 02329E58
	add r1,r5,#0x0	; 02329E5A
	bl loc_02329544	; 02329E5C
	add r0,r5,#0x0	; 02329E60
	add r0,#0x3d	; 02329E62
	strb r6,[r0,#0x0]	; 02329E64
	cmp r4,#0x0	; 02329E66
	beq loc_02329E72	; 02329E68
	add r0,r4,#0x0	; 02329E6A
	add r1,r5,#0x0	; 02329E6C
	bl loc_02329FD8	; 02329E6E
loc_02329E72:
	add r0,r5,#0x0	; 02329E72
	bl loc_02329F90	; 02329E74
	pop {r4,r5,r6}	; 02329E78
	pop {r3}	; 02329E7A
	bx r3	; 02329E7C
	.byte 0xC0, 0x46	; 02329E80
pool_02329E80:
loc_02329E80:
	.word 0x02356214	; 02329E80

; ===== function loc_02329E84 =====
	push {r4,lr}	; 02329E84
	add r4,r0,#0x0	; 02329E86
	ldr r0,[r4,#0x8]	; 02329E88
	cmp r0,#0x0	; 02329E8A
	beq loc_02329EB4	; 02329E8C
	bl loc_0232AC24	; 02329E8E
	ldr r1,[r4,#0xc]	; 02329E92
	cmp r1,#0x0	; 02329E94
	beq loc_02329EA2	; 02329E96
	mov r0,#0x0	; 02329E98
	str r0,[r1,#0x8]	; 02329E9A
	pop {r4}	; 02329E9C
	pop {r3}	; 02329E9E
	bx r3	; 02329EA0
loc_02329EA2:
	ldr r2,[pool_02329EBC]	; 02329EA2
	ldr r1,[r4,#0x10]	; 02329EA4
	mov r0,#0x1c	; 02329EA6
	mul r1,r0	; 02329EA8
	add r0,r2,r1	; 02329EAA
	add r0,#0xc	; 02329EAC
	add r1,r4,#0x0	; 02329EAE
	bl loc_02329544	; 02329EB0
loc_02329EB4:
	pop {r4}	; 02329EB4
	pop {r3}	; 02329EB6
	bx r3	; 02329EB8
	.byte 0xC0, 0x46	; 02329EBC
pool_02329EBC:
loc_02329EBC:
	.word 0x02356220	; 02329EBC

; ===== function loc_02329EC0 =====
loc_02329EC0:
	push {r4,r5,lr}	; 02329EC0
	sub sp,#0x4	; 02329EC2
	add r5,r0,#0x0	; 02329EC4
	ldr r1,[r5,#0x0]	; 02329EC6
	cmp r1,#0x0	; 02329EC8
	beq loc_02329ED2	; 02329ECA
	mov r0,#0x0	; 02329ECC
	str r0,[r1,#0x0]	; 02329ECE
	str r0,[r5,#0x0]	; 02329ED0
loc_02329ED2:
	ldr r4,[r5,#0x4]	; 02329ED2
	add r0,r4,#0x0	; 02329ED4
	add r1,r5,#0x0	; 02329ED6
	bl loc_02329544	; 02329ED8
	mov r0,#0x0	; 02329EDC
	str r0,[r5,#0x4]	; 02329EDE
	ldr r1,[r5,#0x8]	; 02329EE0
	cmp r1,#0x0	; 02329EE2
	beq loc_02329EF6	; 02329EE4
	add r4,#0xc	; 02329EE6
	add r0,r4,#0x0	; 02329EE8
	bl loc_02329604	; 02329EEA
	mov r1,#0x0	; 02329EEE
	ldr r0,[r5,#0x8]	; 02329EF0
	str r1,[r0,#0xc]	; 02329EF2
	str r1,[r5,#0x8]	; 02329EF4
loc_02329EF6:
	ldr r0,[pool_02329F14]	; 02329EF6
	add r1,r5,#0x0	; 02329EF8
	bl loc_02329544	; 02329EFA
	ldr r0,[pool_02329F18]	; 02329EFE
	add r1,r5,#0x0	; 02329F00
	bl loc_02329604	; 02329F02
	mov r0,#0x0	; 02329F06
	add r5,#0x2c	; 02329F08
	strb r0,[r5,#0x0]	; 02329F0A
	add sp,#0x4	; 02329F0C
	pop {r4,r5}	; 02329F0E
	pop {r3}	; 02329F10
	bx r3	; 02329F12
pool_02329F14:
loc_02329F14:
	.word 0x02356214	; 02329F14
pool_02329F18:
loc_02329F18:
	.word 0x02356208	; 02329F18

; ===== function loc_02329F1C =====
loc_02329F1C:
	push {r4,r5,lr}	; 02329F1C
	sub sp,#0x4	; 02329F1E
	add r5,r0,#0x0	; 02329F20
	ldr r0,[pool_02329F70]	; 02329F22
	mov r1,#0x0	; 02329F24
	bl loc_02329534	; 02329F26
	add r4,r0,#0x0	; 02329F2A
	cmp r4,#0x0	; 02329F2C
	bne loc_02329F52	; 02329F2E
	ldr r0,[pool_02329F74]	; 02329F30
	mov r1,#0x0	; 02329F32
	bl loc_02329534	; 02329F34
	add r4,r0,#0x0	; 02329F38
	add r1,r4,#0x0	; 02329F3A
	add r1,#0x3d	; 02329F3C
	ldrb r1,[r1,#0x0]	; 02329F3E
	cmp r5,r1	; 02329F40
	bge loc_02329F4E	; 02329F42
	mov r0,#0x0	; 02329F44
	add sp,#0x4	; 02329F46
	pop {r4,r5}	; 02329F48
	pop {r3}	; 02329F4A
	bx r3	; 02329F4C
loc_02329F4E:
	bl loc_02329F78	; 02329F4E
loc_02329F52:
	ldr r0,[pool_02329F70]	; 02329F52
	add r1,r4,#0x0	; 02329F54
	bl loc_02329544	; 02329F56
	add r0,r4,#0x0	; 02329F5A
	add r0,#0x3d	; 02329F5C
	strb r5,[r0,#0x0]	; 02329F5E
	add r0,r4,#0x0	; 02329F60
	bl loc_02329F90	; 02329F62
	add r0,r4,#0x0	; 02329F66
	add sp,#0x4	; 02329F68
	pop {r4,r5}	; 02329F6A
	pop {r3}	; 02329F6C
	bx r3	; 02329F6E
pool_02329F70:
loc_02329F70:
	.word 0x02356208	; 02329F70
pool_02329F74:
loc_02329F74:
	.word 0x02356214	; 02329F74

; ===== function loc_02329F78 =====
loc_02329F78:
	push {r4,lr}	; 02329F78
	add r4,r0,#0x0	; 02329F7A
	add r0,#0x3c	; 02329F7C
	ldrb r0,[r0,#0x0]	; 02329F7E
	bl loc_0232E154	; 02329F80
	add r0,r4,#0x0	; 02329F84
	bl loc_02329EC0	; 02329F86
	pop {r4}	; 02329F8A
	pop {r3}	; 02329F8C
	bx r3	; 02329F8E

; ===== function loc_02329F90 =====
loc_02329F90:
	push {r4,r5,lr}	; 02329F90
	sub sp,#0x4	; 02329F92
	add r5,r0,#0x0	; 02329F94
	ldr r0,[pool_02329FD4]	; 02329F96
	mov r1,#0x0	; 02329F98
	bl loc_02329534	; 02329F9A
	add r1,r0,#0x0	; 02329F9E
	cmp r1,#0x0	; 02329FA0
	beq loc_02329FC2	; 02329FA2
	ldr r4,[pool_02329FD4]	; 02329FA4
loc_02329FA6:
	add r0,r5,#0x0	; 02329FA6
	add r0,#0x3d	; 02329FA8
	ldrb r2,[r0,#0x0]	; 02329FAA
	add r0,r1,#0x0	; 02329FAC
	add r0,#0x3d	; 02329FAE
	ldrb r0,[r0,#0x0]	; 02329FB0
	cmp r2,r0	; 02329FB2
	bcc loc_02329FC2	; 02329FB4
	add r0,r4,#0x0	; 02329FB6
	bl loc_02329534	; 02329FB8
	add r1,r0,#0x0	; 02329FBC
	cmp r1,#0x0	; 02329FBE
	bne loc_02329FA6	; 02329FC0
loc_02329FC2:
	ldr r0,[pool_02329FD4]	; 02329FC2
	add r2,r5,#0x0	; 02329FC4
	bl loc_02329584	; 02329FC6
	add sp,#0x4	; 02329FCA
	pop {r4,r5}	; 02329FCC
	pop {r3}	; 02329FCE
	bx r3	; 02329FD0
	.byte 0xC0, 0x46	; 02329FD4
pool_02329FD4:
loc_02329FD4:
	.word 0x02356214	; 02329FD4

; ===== function loc_02329FD8 =====
loc_02329FD8:
	push {r4,r5,lr}	; 02329FD8
	sub sp,#0x4	; 02329FDA
	add r5,r0,#0x0	; 02329FDC
	add r4,r1,#0x0	; 02329FDE
	mov r1,#0x0	; 02329FE0
	bl loc_02329534	; 02329FE2
	add r1,r0,#0x0	; 02329FE6
	cmp r1,#0x0	; 02329FE8
	beq loc_0232A008	; 02329FEA
loc_02329FEC:
	add r0,r4,#0x0	; 02329FEC
	add r0,#0x3d	; 02329FEE
	ldrb r2,[r0,#0x0]	; 02329FF0
	add r0,r1,#0x0	; 02329FF2
	add r0,#0x3d	; 02329FF4
	ldrb r0,[r0,#0x0]	; 02329FF6
	cmp r2,r0	; 02329FF8
	bcc loc_0232A008	; 02329FFA
	add r0,r5,#0x0	; 02329FFC
	bl loc_02329534	; 02329FFE
	add r1,r0,#0x0	; 0232A002
	cmp r1,#0x0	; 0232A004
	bne loc_02329FEC	; 0232A006
loc_0232A008:
	add r0,r5,#0x0	; 0232A008
	add r2,r4,#0x0	; 0232A00A
	bl loc_02329584	; 0232A00C
	str r5,[r4,#0x4]	; 0232A010
	add sp,#0x4	; 0232A012
	pop {r4,r5}	; 0232A014
	pop {r3}	; 0232A016
	bx r3	; 0232A018
	.byte 0x00, 0x00	; 0232A01C

; ===== function loc_0232A01C =====
loc_0232A01C:
	push {r4,lr}	; 0232A01C
	add r4,r0,#0x0	; 0232A01E
	mov r1,#0x0	; 0232A020
	add r0,#0x2e	; 0232A022
	strb r1,[r0,#0x0]	; 0232A024
	add r0,r4,#0x0	; 0232A026
	add r0,#0x2d	; 0232A028
	strb r1,[r0,#0x0]	; 0232A02A
	strh r1,[r4,#0x34]	; 0232A02C
	strh r1,[r4,#0x3e]	; 0232A02E
	mov r1,#0x7f	; 0232A030
	add r0,r4,#0x0	; 0232A032
	add r0,#0x40	; 0232A034
	strb r1,[r0,#0x0]	; 0232A036
	add r0,r4,#0x0	; 0232A038
	add r0,#0x41	; 0232A03A
	strb r1,[r0,#0x0]	; 0232A03C
	add r0,r4,#0x0	; 0232A03E
	add r0,#0x1c	; 0232A040
	bl loc_0232AF5C	; 0232A042
	add r4,#0x1c	; 0232A046
	add r0,r4,#0x0	; 0232A048
	ldr r1,[pool_0232A058]	; 0232A04A
	mov r2,#0x1	; 0232A04C
	bl loc_0232AF40	; 0232A04E
	pop {r4}	; 0232A052
	pop {r3}	; 0232A054
	bx r3	; 0232A056
pool_0232A058:
loc_0232A058:
	.word 0x00007F00	; 0232A058
loc_0232A05C:
	push {r4,lr}	; 0232A05C
	add r4,r0,#0x0	; 0232A05E
	add r2,r1,#0x0	; 0232A060
	cmp r4,#0x0	; 0232A062
	beq loc_0232A094	; 0232A064
	add r1,r4,#0x0	; 0232A066
	add r1,#0x2c	; 0232A068
	ldrb r1,[r1,#0x0]	; 0232A06A
	cmp r1,#0x0	; 0232A06C
	beq loc_0232A094	; 0232A06E
	cmp r2,#0x0	; 0232A070
	bne loc_0232A07E	; 0232A072
	bl loc_02329F78	; 0232A074
	pop {r4}	; 0232A078
	pop {r3}	; 0232A07A
	bx r3	; 0232A07C
loc_0232A07E:
	add r0,#0x1c	; 0232A07E
	mov r1,#0x0	; 0232A080
	bl loc_0232AF40	; 0232A082
	add r0,r4,#0x0	; 0232A086
	mov r1,#0x0	; 0232A088
	bl loc_02329E40	; 0232A08A
	mov r0,#0x2	; 0232A08E
	add r4,#0x2c	; 0232A090
	strb r0,[r4,#0x0]	; 0232A092
loc_0232A094:
	pop {r4}	; 0232A094
	pop {r3}	; 0232A096
	bx r3	; 0232A098
	.byte 0x00, 0x00	; 0232A09C

; ===== function loc_0232A09C =====
loc_0232A09C:
	push {r4,lr}	; 0232A09C
	add r4,r0,#0x0	; 0232A09E
	add r0,#0x3c	; 0232A0A0
	ldrb r0,[r0,#0x0]	; 0232A0A2
	bl loc_0232E16C	; 0232A0A4
	add r0,r4,#0x0	; 0232A0A8
	bl loc_0232A01C	; 0232A0AA
	bl loc_0232E2AC	; 0232A0AE
	str r0,[r4,#0x30]	; 0232A0B2
	mov r0,#0x1	; 0232A0B4
	add r4,#0x2c	; 0232A0B6
	strb r0,[r4,#0x0]	; 0232A0B8
	pop {r4}	; 0232A0BA
	pop {r3}	; 0232A0BC
	bx r3	; 0232A0BE

; ===== function loc_0232A0C0 =====
loc_0232A0C0:
	ldr r3,[pool_0232A0C4]	; 0232A0C0
	bx r3	; 0232A0C2
pool_0232A0C4:
loc_0232A0C4:
	.word loc_02329EC0 + 1	; 0232A0C4

; ===== function loc_0232A0C8 =====
loc_0232A0C8:
	push {r4,r5,r6,lr}	; 0232A0C8
	add r5,r0,#0x0	; 0232A0CA
	add r6,r2,#0x0	; 0232A0CC
	ldr r3,[pool_0232A13C]	; 0232A0CE
	mov r2,#0x1c	; 0232A0D0
	mul r1,r2	; 0232A0D2
	add r4,r3,r1	; 0232A0D4
	ldr r1,[r5,#0x0]	; 0232A0D6
	cmp r1,#0x0	; 0232A0D8
	beq loc_0232A0E0	; 0232A0DA
	bl loc_0232A1E4	; 0232A0DC
loc_0232A0E0:
	ldrh r1,[r4,#0x8]	; 0232A0E0
	ldr r0,[r4,#0x18]	; 0232A0E2
	cmp r1,r0	; 0232A0E4
	bcc loc_0232A112	; 0232A0E6
	add r0,r4,#0x0	; 0232A0E8
	mov r1,#0x0	; 0232A0EA
	bl loc_02329534	; 0232A0EC
	cmp r0,#0x0	; 0232A0F0
	bne loc_0232A0FC	; 0232A0F2
	mov r0,#0x0	; 0232A0F4
	pop {r4,r5,r6}	; 0232A0F6
	pop {r3}	; 0232A0F8
	bx r3	; 0232A0FA
loc_0232A0FC:
	add r1,r0,#0x0	; 0232A0FC
	add r1,#0x3d	; 0232A0FE
	ldrb r1,[r1,#0x0]	; 0232A100
	cmp r6,r1	; 0232A102
	bge loc_0232A10E	; 0232A104
	mov r0,#0x0	; 0232A106
	pop {r4,r5,r6}	; 0232A108
	pop {r3}	; 0232A10A
	bx r3	; 0232A10C
loc_0232A10E:
	bl loc_02329F78	; 0232A10E
loc_0232A112:
	add r0,r6,#0x0	; 0232A112
	bl loc_02329F1C	; 0232A114
	add r6,r0,#0x0	; 0232A118
	cmp r6,#0x0	; 0232A11A
	bne loc_0232A126	; 0232A11C
	mov r0,#0x0	; 0232A11E
	pop {r4,r5,r6}	; 0232A120
	pop {r3}	; 0232A122
	bx r3	; 0232A124
loc_0232A126:
	add r0,r4,#0x0	; 0232A126
	add r1,r6,#0x0	; 0232A128
	bl loc_02329FD8	; 0232A12A
	str r5,[r6,#0x0]	; 0232A12E
	str r6,[r5,#0x0]	; 0232A130
	add r0,r6,#0x0	; 0232A132
	pop {r4,r5,r6}	; 0232A134
	pop {r3}	; 0232A136
	bx r3	; 0232A138
	.byte 0xC0, 0x46	; 0232A13C
pool_0232A13C:
loc_0232A13C:
	.word 0x02356220	; 0232A13C

; ===== function loc_0232A140 =====
loc_0232A140:
	push {r4}	; 0232A140
	sub sp,#0x4	; 0232A142
	ldr r4,[r0,#0x0]	; 0232A144
	cmp r4,#0x0	; 0232A146
	beq loc_0232A156	; 0232A148
	mov r3,#0x2	; 0232A14A
	strh r3,[r4,#0x34]	; 0232A14C
	ldr r3,[r0,#0x0]	; 0232A14E
	strh r1,[r3,#0x38]	; 0232A150
	ldr r0,[r0,#0x0]	; 0232A152
	strh r2,[r0,#0x3a]	; 0232A154
loc_0232A156:
	add sp,#0x4	; 0232A156
	pop {r4}	; 0232A158
	bx lr	; 0232A15A

; ===== function loc_0232A15C =====
	push {lr}	; 0232A15C
	sub sp,#0x4	; 0232A15E
	ldr r0,[r0,#0x0]	; 0232A160
	cmp r0,#0x0	; 0232A162
	beq loc_0232A16E	; 0232A164
	add r0,#0x3c	; 0232A166
	ldrb r0,[r0,#0x0]	; 0232A168
	bl loc_0232E0FC	; 0232A16A
loc_0232A16E:
	add sp,#0x4	; 0232A16E
	pop {r3}	; 0232A170
	bx r3	; 0232A172

; ===== function loc_0232A174 =====
	push {lr}	; 0232A174
	sub sp,#0x4	; 0232A176
	ldr r0,[r0,#0x0]	; 0232A178
	cmp r0,#0x0	; 0232A17A
	beq loc_0232A186	; 0232A17C
	add r0,#0x3c	; 0232A17E
	ldrb r0,[r0,#0x0]	; 0232A180
	bl loc_0232E114	; 0232A182
loc_0232A186:
	add sp,#0x4	; 0232A186
	pop {r3}	; 0232A188
	bx r3	; 0232A18A

; ===== function loc_0232A18C =====
loc_0232A18C:
	push {lr}	; 0232A18C
	sub sp,#0x4	; 0232A18E
	ldr r0,[r0,#0x0]	; 0232A190
	cmp r0,#0x0	; 0232A192
	beq loc_0232A19E	; 0232A194
	add r0,#0x3c	; 0232A196
	ldrb r0,[r0,#0x0]	; 0232A198
	bl loc_0232E12C	; 0232A19A
loc_0232A19E:
	add sp,#0x4	; 0232A19E
	pop {r3}	; 0232A1A0
	bx r3	; 0232A1A2

; ===== function loc_0232A1A4 =====
	push {lr}	; 0232A1A4
	sub sp,#0x4	; 0232A1A6
	ldr r0,[r0,#0x0]	; 0232A1A8
	cmp r0,#0x0	; 0232A1AA
	beq loc_0232A1C0	; 0232A1AC
	add r3,r0,#0x0	; 0232A1AE
	add r3,#0x2c	; 0232A1B0
	ldrb r3,[r3,#0x0]	; 0232A1B2
	cmp r3,#0x2	; 0232A1B4
	beq loc_0232A1C0	; 0232A1B6
	add r0,#0x1c	; 0232A1B8
	lsl r1,r1,#0x8	; 0232A1BA
	bl loc_0232AF40	; 0232A1BC
loc_0232A1C0:
	add sp,#0x4	; 0232A1C0
	pop {r3}	; 0232A1C2
	bx r3	; 0232A1C4
	.byte 0x00, 0x00	; 0232A1C8

; ===== function loc_0232A1C8 =====
loc_0232A1C8:
	ldr r0,[r0,#0x0]	; 0232A1C8
	cmp r0,#0x0	; 0232A1CA
	beq loc_0232A1D2	; 0232A1CC
	add r0,#0x40	; 0232A1CE
	strb r1,[r0,#0x0]	; 0232A1D0
loc_0232A1D2:
	bx lr	; 0232A1D2

; ===== function loc_0232A1D4 =====
loc_0232A1D4:
	mov r1,#0x1c	; 0232A1D4
	mul r0,r1	; 0232A1D6
	ldr r1,[pool_0232A1E0]	; 0232A1D8
	ldrh r0,[r1,r0]	; 0232A1DA
	bx lr	; 0232A1DC
	.byte 0xC0, 0x46	; 0232A1E0
pool_0232A1E0:
loc_0232A1E0:
	.word P1_BssStart + 0x25A48	; 0232A1E0

; ===== function loc_0232A1E4 =====
loc_0232A1E4:
	ldr r2,[r0,#0x0]	; 0232A1E4
	cmp r2,#0x0	; 0232A1E6
	beq loc_0232A1F0	; 0232A1E8
	mov r1,#0x0	; 0232A1EA
	str r1,[r2,#0x0]	; 0232A1EC
	str r1,[r0,#0x0]	; 0232A1EE
loc_0232A1F0:
	bx lr	; 0232A1F0
	.byte 0x00, 0x00	; 0232A1F4

; ===== function loc_0232A1F4 =====
loc_0232A1F4:
	mov r1,#0x0	; 0232A1F4
	str r1,[r0,#0x0]	; 0232A1F6
	bx lr	; 0232A1F8
	.byte 0x00, 0x00	; 0232A1FC
loc_0232A1FC:
	ldr r0,[r0,#0x0]	; 0232A1FC
	ldr r3,[pool_0232A204]	; 0232A1FE
	bx r3	; 0232A200
	.byte 0xC0, 0x46	; 0232A204
pool_0232A204:
loc_0232A204:
	.word loc_0232A05C + 1	; 0232A204

; ===== function loc_0232A208 =====
loc_0232A208:
	push {r4,r5,r6,lr}	; 0232A208
	sub sp,#0x8	; 0232A20A
	add r5,r0,#0x0	; 0232A20C
	add r6,r2,#0x0	; 0232A20E
	mov r3,#0x0	; 0232A210
	str r3,[sp,#0x0]	; 0232A212
	add r0,r1,#0x0	; 0232A214
	add r1,r6,#0x0	; 0232A216
	add r1,#0x14	; 0232A218
	ldr r2,[pool_0232A26C]	; 0232A21A
	bl loc_0232AB5C	; 0232A21C
	add r4,r0,#0x0	; 0232A220
	cmp r4,#0x0	; 0232A222
	bne loc_0232A230	; 0232A224
	mov r0,#0x0	; 0232A226
	add sp,#0x8	; 0232A228
	pop {r4,r5,r6}	; 0232A22A
	pop {r3}	; 0232A22C
	bx r3	; 0232A22E
loc_0232A230:
	mov r0,#0x0	; 0232A230
	str r0,[r4,#0xc]	; 0232A232
	str r5,[r4,#0x10]	; 0232A234
	str r0,[r4,#0x8]	; 0232A236
	add r0,r4,#0x0	; 0232A238
	add r0,#0x14	; 0232A23A
	add r1,r6,#0x0	; 0232A23C
	bl loc_0232AC38	; 0232A23E
	cmp r0,#0x0	; 0232A242
	bne loc_0232A250	; 0232A244
	mov r0,#0x0	; 0232A246
	add sp,#0x8	; 0232A248
	pop {r4,r5,r6}	; 0232A24A
	pop {r3}	; 0232A24C
	bx r3	; 0232A24E
loc_0232A250:
	str r0,[r4,#0x8]	; 0232A250
	ldr r1,[pool_0232A270]	; 0232A252
	mov r0,#0x1c	; 0232A254
	mul r5,r0	; 0232A256
	add r0,r1,r5	; 0232A258
	add r0,#0xc	; 0232A25A
	add r1,r4,#0x0	; 0232A25C
	bl loc_02329604	; 0232A25E
	mov r0,#0x1	; 0232A262
	add sp,#0x8	; 0232A264
	pop {r4,r5,r6}	; 0232A266
	pop {r3}	; 0232A268
	bx r3	; 0232A26A
pool_0232A26C:
loc_0232A26C:
	.word 0x02329E85	; 0232A26C
pool_0232A270:
loc_0232A270:
	.word 0x02356220	; 0232A270

; ===== function loc_0232A274 =====
loc_0232A274:
	lsl r1,r1,#0x10	; 0232A274
	lsr r2,r1,#0x10	; 0232A276
	mov r1,#0x1c	; 0232A278
	mul r0,r1	; 0232A27A
	ldr r1,[pool_0232A284]	; 0232A27C
	str r2,[r1,r0]	; 0232A27E
	bx lr	; 0232A280
	.byte 0xC0, 0x46	; 0232A284
pool_0232A284:
loc_0232A284:
	.word P1_BssStart + 0x25A58	; 0232A284

; ===== function loc_0232A288 =====
loc_0232A288:
	push {r4,r5,r6,r7,lr}	; 0232A288
	sub sp,#0xc	; 0232A28A
	bl loc_0232E6D8	; 0232A28C
	str r0,[sp,#0x4]	; 0232A290
	ldr r0,[pool_0232A36C]	; 0232A292
	mov r1,#0x0	; 0232A294
	bl loc_02329534	; 0232A296
	add r5,r0,#0x0	; 0232A29A
	cmp r5,#0x0	; 0232A29C
	beq loc_0232A364	; 0232A29E
	ldr r7,[pool_0232A370]	; 0232A2A0
loc_0232A2A2:
	ldr r0,[pool_0232A36C]	; 0232A2A2
	add r1,r5,#0x0	; 0232A2A4
	bl loc_02329534	; 0232A2A6
	str r0,[sp,#0x0]	; 0232A2AA
	add r0,r5,#0x0	; 0232A2AC
	add r0,#0x2d	; 0232A2AE
	ldrb r0,[r0,#0x0]	; 0232A2B0
	cmp r0,#0x0	; 0232A2B2
	bne loc_0232A2C8	; 0232A2B4
	ldr r0,[r5,#0x30]	; 0232A2B6
	bl loc_0232E27C	; 0232A2B8
	cmp r0,#0x0	; 0232A2BC
	beq loc_0232A2C8	; 0232A2BE
	add r1,r5,#0x0	; 0232A2C0
	add r1,#0x2d	; 0232A2C2
	mov r0,#0x1	; 0232A2C4
	strb r0,[r1,#0x0]	; 0232A2C6
loc_0232A2C8:
	add r0,r5,#0x0	; 0232A2C8
	add r0,#0x2d	; 0232A2CA
	ldrb r0,[r0,#0x0]	; 0232A2CC
	cmp r0,#0x0	; 0232A2CE
	beq loc_0232A2EC	; 0232A2D0
	add r0,r5,#0x0	; 0232A2D2
	add r0,#0x3c	; 0232A2D4
	ldrb r0,[r0,#0x0]	; 0232A2D6
	mov r1,#0x1	; 0232A2D8
	lsl r1,r0	; 0232A2DA
	ldr r0,[sp,#0x4]	; 0232A2DC
	and r0,r1	; 0232A2DE
	cmp r0,#0x0	; 0232A2E0
	bne loc_0232A2EC	; 0232A2E2
	add r0,r5,#0x0	; 0232A2E4
	bl loc_02329EC0	; 0232A2E6
	b loc_0232A35C	; 0232A2EA
loc_0232A2EC:
	add r0,r5,#0x0	; 0232A2EC
	add r0,#0x1c	; 0232A2EE
	bl loc_0232AF08	; 0232A2F0
	add r0,r5,#0x0	; 0232A2F4
	add r0,#0x41	; 0232A2F6
	ldrb r0,[r0,#0x0]	; 0232A2F8
	lsl r0,r0,#0x1	; 0232A2FA
	ldrsh r4,[r7,r0]	; 0232A2FC
	add r0,r5,#0x0	; 0232A2FE
	add r0,#0x40	; 0232A300
	ldrb r0,[r0,#0x0]	; 0232A302
	lsl r0,r0,#0x1	; 0232A304
	ldrsh r6,[r7,r0]	; 0232A306
	add r0,r5,#0x0	; 0232A308
	add r0,#0x1c	; 0232A30A
	bl loc_0232AF18	; 0232A30C
	asr r0,r0,#0x8	; 0232A310
	lsl r0,r0,#0x1	; 0232A312
	ldrsh r1,[r7,r0]	; 0232A314
	add r0,r6,r4	; 0232A316
	add r4,r1,r0	; 0232A318
	ldr r0,[pool_0232A374]	; 0232A31A
	cmp r4,r0	; 0232A31C
	bge loc_0232A324	; 0232A31E
	lsl r4,r0,#0	; 0232A320
	b loc_0232A32A	; 0232A322
loc_0232A324:
	cmp r4,#0x0	; 0232A324
	ble loc_0232A32A	; 0232A326
	mov r4,#0x0	; 0232A328
loc_0232A32A:
	mov r0,#0x3e	; 0232A32A
	ldrsh r0,[r5,r0]	; 0232A32C
	cmp r4,r0	; 0232A32E
	beq loc_0232A340	; 0232A330
	add r0,r5,#0x0	; 0232A332
	add r0,#0x3c	; 0232A334
	ldrb r0,[r0,#0x0]	; 0232A336
	add r1,r4,#0x0	; 0232A338
	bl loc_0232E140	; 0232A33A
	strh r4,[r5,#0x3e]	; 0232A33E
loc_0232A340:
	add r0,r5,#0x0	; 0232A340
	add r0,#0x2c	; 0232A342
	ldrb r0,[r0,#0x0]	; 0232A344
	cmp r0,#0x2	; 0232A346
	bne loc_0232A35C	; 0232A348
	add r0,r5,#0x0	; 0232A34A
	add r0,#0x1c	; 0232A34C
	bl loc_0232AEF8	; 0232A34E
	cmp r0,#0x0	; 0232A352
	beq loc_0232A35C	; 0232A354
	add r0,r5,#0x0	; 0232A356
	bl loc_02329F78	; 0232A358
loc_0232A35C:
	ldr r5,[sp,#0x0]	; 0232A35C
	lsl r0,r5,#0	; 0232A35E
	cmp r0,#0x0	; 0232A360
	bne loc_0232A2A2	; 0232A362
loc_0232A364:
	add sp,#0xc	; 0232A364
	pop {r4,r5,r6,r7}	; 0232A366
	pop {r3}	; 0232A368
	bx r3	; 0232A36A
pool_0232A36C:
loc_0232A36C:
	.word 0x02356214	; 0232A36C
pool_0232A370:
loc_0232A370:
	.word 0x02330208	; 0232A370
pool_0232A374:
loc_0232A374:
	.word 0xFFFFFD2D	; 0232A374

; ===== function loc_0232A378 =====
loc_0232A378:
	push {r4,r5,r6,r7,lr}	; 0232A378
	sub sp,#0x4	; 0232A37A
	ldr r0,[pool_0232A3DC]	; 0232A37C
	mov r1,#0x14	; 0232A37E
	bl loc_02329658	; 0232A380
	ldr r0,[pool_0232A3E0]	; 0232A384
	mov r1,#0x14	; 0232A386
	bl loc_02329658	; 0232A388
	mov r5,#0x0	; 0232A38C
	ldr r4,[pool_0232A3E4]	; 0232A38E
	add r6,r5,#0x0	; 0232A390
	ldr r7,[pool_0232A3E0]	; 0232A392
loc_0232A394:
	add r0,r4,#0x0	; 0232A394
	add r0,#0x2c	; 0232A396
	strb r6,[r0,#0x0]	; 0232A398
	add r0,r4,#0x0	; 0232A39A
	add r0,#0x3c	; 0232A39C
	strb r5,[r0,#0x0]	; 0232A39E
	add r0,r7,#0x0	; 0232A3A0
	add r1,r4,#0x0	; 0232A3A2
	bl loc_02329604	; 0232A3A4
	add r4,#0x44	; 0232A3A8
	add r5,r5,#0x1	; 0232A3AA
	cmp r5,#0x10	; 0232A3AC
	blt loc_0232A394	; 0232A3AE
	mov r4,#0x0	; 0232A3B0
	ldr r5,[pool_0232A3E8]	; 0232A3B2
	add r6,r4,#0x0	; 0232A3B4
	mov r7,#0x1	; 0232A3B6
loc_0232A3B8:
	add r0,r5,#0x0	; 0232A3B8
	mov r1,#0xc	; 0232A3BA
	bl loc_02329658	; 0232A3BC
	add r0,r5,#0x0	; 0232A3C0
	add r0,#0xc	; 0232A3C2
	add r1,r6,#0x0	; 0232A3C4
	bl loc_02329658	; 0232A3C6
	str r7,[r5,#0x18]	; 0232A3CA
	add r5,#0x1c	; 0232A3CC
	add r4,r4,#0x1	; 0232A3CE
	cmp r4,#0x20	; 0232A3D0
	blt loc_0232A3B8	; 0232A3D2
	add sp,#0x4	; 0232A3D4
	pop {r4,r5,r6,r7}	; 0232A3D6
	pop {r3}	; 0232A3D8
	bx r3	; 0232A3DA
pool_0232A3DC:
loc_0232A3DC:
	.word 0x02356214	; 0232A3DC
pool_0232A3E0:
loc_0232A3E0:
	.word 0x02356208	; 0232A3E0
pool_0232A3E4:
loc_0232A3E4:
	.word P1_BssStart + 0x25DC0	; 0232A3E4
pool_0232A3E8:
loc_0232A3E8:
	.word 0x02356220	; 0232A3E8

; ===== function loc_0232A3EC =====
	push {r4,r5,r6,r7,lr}	; 0232A3EC
	sub sp,#0xc	; 0232A3EE
; 调度当前双缓冲区块；正常路径将两段缓冲区、块长度、用户值和上下文传给回调。
; Dispatch the current two-buffer block; normal path passes both buffers, size, user value and context.
.func P1_DispatchDualBufferBlock
	add r5,r0,#0x0	; 0232A3F0
	ldr r0,[r5,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A3F2
	ldr r1,[r5,#P1_DualBufferProcessorBlockCountOffset]	; 0232A3F4
	blx P1_SignedDivMod	; 0232A3F6
	str r0,[sp,#0x4]	; 0232A3FA
	ldr r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A3FC
	ldr r4,[sp,#0x4]	; 0232A3FE
	mul r4,r0	; 0232A400
	ldr r0,[r5,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A402
	add r6,r0,r4	; 0232A404
	ldr r0,[r5,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A406
	add r7,r0,r4	; 0232A408
	add r0,r6,#0x0	; 0232A40A
	ldr r1,[sp,#0x4]	; 0232A40C
	blx P1_InvalidateDataCacheRange	; 0232A40E
	add r0,r7,#0x0	; 0232A412
	ldr r1,[sp,#0x4]	; 0232A414
	blx P1_InvalidateDataCacheRange	; 0232A416
	ldr r0,[pool_0232A480]	; 0232A41A
	ldr r0,[r0,#0x0]	; 0232A41C
	cmp r0,#0x0	; 0232A41E
	beq loc_0232A454	; 0232A420
	ldr r2,[pool_0232A484]	; 0232A422
	ldr r0,[pool_0232A488]	; 0232A424
	ldr r0,[r0,#0x0]	; 0232A426
	mov r1,#0x14	; 0232A428
	mul r0,r1	; 0232A42A
	add r1,r2,r0	; 0232A42C
	str r5,[r2,r0]	; 0232A42E
	ldr r0,[sp,#0x4]	; 0232A430
	str r0,[r1,#0x4]	; 0232A432
	str r4,[r1,#0x8]	; 0232A434
	str r6,[r1,#0xc]	; 0232A436
	str r7,[r1,#0x10]	; 0232A438
	ldr r0,[pool_0232A48C]	; 0232A43A
	mov r2,#0x0	; 0232A43C
	bl loc_0232BA50	; 0232A43E
	ldr r0,[pool_0232A488]	; 0232A442
	ldr r1,[r0,#0x0]	; 0232A444
	add r1,r1,#0x1	; 0232A446
	str r1,[r0,#0x0]	; 0232A448
	cmp r1,#0x8	; 0232A44A
	blt loc_0232A464	; 0232A44C
	mov r1,#0x0	; 0232A44E
	str r1,[r0,#0x0]	; 0232A450
	b loc_0232A464	; 0232A452
loc_0232A454:
	ldr r0,[r5,#P1_DualBufferProcessorCallbackContextOffset]	; 0232A454
	str r0,[sp,#0x0]	; 0232A456
	add r0,r6,#0x0	; 0232A458
	add r1,r7,#0x0	; 0232A45A
	ldr r2,[sp,#0x4]	; 0232A45C
	ldr r3,[r5,#P1_DualBufferProcessorUserValueOffset]	; 0232A45E
	ldr r4,[r5,#P1_DualBufferProcessorCallbackOffset]	; 0232A460
	blx r4	; 0232A462
loc_0232A464:
	ldr r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A464
	add r0,r0,#0x1	; 0232A466
	str r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A468
	ldr r1,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A46A
	ldr r0,[r5,#P1_DualBufferProcessorBlockCountOffset]	; 0232A46C
	cmp r1,r0	; 0232A46E
	blt loc_0232A476	; 0232A470
	mov r0,#0x0	; 0232A472
	str r0,[r5,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A474
loc_0232A476:
	add sp,#0xc	; 0232A476
	pop {r4,r5,r6,r7}	; 0232A478
	pop {r3}	; 0232A47A
	bx r3	; 0232A47C
	.byte 0xC0, 0x46	; 0232A480
pool_0232A480:
.endfunc
loc_0232A480:
	.word P1_DualBufferDeferredQueueGate	; 0232A480
pool_0232A484:
loc_0232A484:
	.word P1_DualBufferDeferredQueueEntries	; 0232A484
pool_0232A488:
loc_0232A488:
	.word P1_DualBufferDeferredQueueIndex	; 0232A488
pool_0232A48C:
loc_0232A48C:
	.word 0x023569E8	; 0232A48C

; ===== function loc_0232A490 =====
loc_0232A490:
	push {r4,lr}	; 0232A490
	sub sp,#0x8	; 0232A492
; 将块索引归零、清零两段缓冲区并清理缓存，然后提交状态字段指定的控制请求。
; Reset block index, clear both buffers and clean cache, then submit the state-selected control request.
.func P1_ResetDualBufferBuffers
	ldr r4,[pool_0232A4EC]	; 0232A494
	ldr r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A496
	cmp r0,#0x0	; 0232A498
	beq loc_0232A4E2	; 0232A49A
	mov r0,#0x0	; 0232A49C
	str r0,[r4,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A49E
	str r0,[sp,#0x0]	; 0232A4A0
	ldr r0,[sp,#0x0]	; 0232A4A2
	ldr r1,[r4,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A4A4
	ldr r2,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A4A6
	blx loc_0232DDE0	; 0232A4A8
	mov r0,#0x0	; 0232A4AC
	str r0,[sp,#0x4]	; 0232A4AE
	ldr r0,[sp,#0x4]	; 0232A4B0
	ldr r1,[r4,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A4B2
	ldr r2,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A4B4
	blx loc_0232DDE0	; 0232A4B6
	ldr r0,[r4,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A4BA
	ldr r1,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A4BC
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A4BE
	ldr r0,[r4,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A4C2
	ldr r1,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A4C4
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A4C6
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A4CA
	cmp r0,#0x0	; 0232A4CC
	blt loc_0232A4D6	; 0232A4CE
	mov r2,#0x1	; 0232A4D0
	lsl r2,r0	; 0232A4D2
	b loc_0232A4D8	; 0232A4D4
loc_0232A4D6:
	mov r2,#0x0	; 0232A4D6
loc_0232A4D8:
	ldr r0,[r4,#0x20]	; 0232A4D8
	ldr r1,[r4,#0x24]	; 0232A4DA
	mov r3,#0x0	; 0232A4DC
	bl loc_0232E0DC	; 0232A4DE
loc_0232A4E2:
	add sp,#0x8	; 0232A4E2
	pop {r4}	; 0232A4E4
	pop {r3}	; 0232A4E6
	bx r3	; 0232A4E8
	.byte 0xC0, 0x46	; 0232A4EC
pool_0232A4EC:
.endfunc
loc_0232A4EC:
	.word P1_DualBufferProcessorState	; 0232A4EC

; ===== function loc_0232A4F0 =====
loc_0232A4F0:
	push {r4,lr}	; 0232A4F0
	ldr r1,[pool_0232A52C]	; 0232A4F2
; 处理器有效时，依据其配置字段提交控制掩码并完成相关状态更新。
; When active, submit a control mask from configuration fields and complete related state updates.
.func P1_ApplyDualBufferProcessorSettings
	ldr r0,[r1,#P1_DualBufferProcessorActiveOffset]	; 0232A4F4
	cmp r0,#0x0	; 0232A4F6
	beq loc_0232A524	; 0232A4F8
	ldr r0,[r1,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A4FA
	cmp r0,#0x0	; 0232A4FC
	blt loc_0232A506	; 0232A4FE
	mov r2,#0x1	; 0232A500
	lsl r2,r0	; 0232A502
	b loc_0232A508	; 0232A504
loc_0232A506:
	mov r2,#0x0	; 0232A506
loc_0232A508:
	ldr r0,[r1,#0x20]	; 0232A508
	ldr r1,[r1,#0x24]	; 0232A50A
	mov r3,#0x0	; 0232A50C
	bl loc_0232E094	; 0232A50E
	bl loc_0232E2AC	; 0232A512
	add r4,r0,#0x0	; 0232A516
	mov r0,#0x1	; 0232A518
	bl loc_0232E318	; 0232A51A
	add r0,r4,#0x0	; 0232A51E
	bl loc_0232E2CC	; 0232A520
loc_0232A524:
	pop {r4}	; 0232A524
	pop {r3}	; 0232A526
	bx r3	; 0232A528
	.byte 0xC0, 0x46	; 0232A52C
pool_0232A52C:
.endfunc
loc_0232A52C:
	.word P1_DualBufferProcessorState	; 0232A52C

; ===== function loc_0232A530 =====
loc_0232A530:
	push {r4,r5,r6,r7,lr}	; 0232A530
	sub sp,#0x4	; 0232A532
; 停止处理器关联服务，处理登记资源后清除其有效标志。
; Stop associated services, process registered resources, then clear the active flag.
.func P1_StopDualBufferProcessor
	ldr r4,[pool_0232A5C0]	; 0232A534
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A536
	cmp r0,#0x0	; 0232A538
	blt loc_0232A540	; 0232A53A
	mov r5,#0x1	; 0232A53C
	b loc_0232A542	; 0232A53E
loc_0232A540:
	mov r5,#0x0	; 0232A540
loc_0232A542:
	cmp r5,#0x0	; 0232A542
	beq loc_0232A54E	; 0232A544
	mov r2,#0x1	; 0232A546
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A548
	lsl r2,r0	; 0232A54A
	b loc_0232A550	; 0232A54C
loc_0232A54E:
	mov r2,#0x0	; 0232A54E
loc_0232A550:
	ldr r0,[r4,#0x20]	; 0232A550
	ldr r1,[r4,#0x24]	; 0232A552
	mov r3,#0x0	; 0232A554
	bl loc_0232E094	; 0232A556
	cmp r5,#0x0	; 0232A55A
	beq loc_0232A582	; 0232A55C
	bl loc_0232E2AC	; 0232A55E
	add r6,r0,#0x0	; 0232A562
	mov r0,#0x1	; 0232A564
	bl loc_0232E318	; 0232A566
	add r0,r6,#0x0	; 0232A56A
	bl loc_0232E2CC	; 0232A56C
	ldr r6,[pool_0232A5C4]	; 0232A570
	mov r7,#0x0	; 0232A572
loc_0232A574:
	add r0,r6,#0x0	; 0232A574
	add r1,r7,#0x0	; 0232A576
	add r2,r7,#0x0	; 0232A578
	bl loc_0232B9DC	; 0232A57A
	cmp r0,#0x0	; 0232A57E
	bne loc_0232A574	; 0232A580
loc_0232A582:
	ldr r0,[r4,#0x24]	; 0232A582
	cmp r0,#0x0	; 0232A584
	beq loc_0232A58C	; 0232A586
	bl loc_02329D98	; 0232A588
loc_0232A58C:
	ldr r0,[r4,#0x1c]	; 0232A58C
	cmp r0,#0x0	; 0232A58E
	beq loc_0232A596	; 0232A590
	bl loc_02329DC4	; 0232A592
loc_0232A596:
	cmp r5,#0x0	; 0232A596
	beq loc_0232A5A0	; 0232A598
	ldr r0,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A59A
	bl loc_02329D58	; 0232A59C
loc_0232A5A0:
	ldr r0,[r4,#P1_DualBufferProcessorModeOffset]	; 0232A5A0
	cmp r0,#0x1	; 0232A5A2
	bne loc_0232A5B2	; 0232A5A4
	mov r0,#0x0	; 0232A5A6
	add r1,r0,#0x0	; 0232A5A8
	add r2,r0,#0x0	; 0232A5AA
	add r3,r0,#0x0	; 0232A5AC
	bl loc_0232DF7C	; 0232A5AE
loc_0232A5B2:
	mov r0,#0x0	; 0232A5B2
	str r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A5B4
	add sp,#0x4	; 0232A5B6
	pop {r4,r5,r6,r7}	; 0232A5B8
	pop {r3}	; 0232A5BA
	bx r3	; 0232A5BC
	.byte 0xC0, 0x46	; 0232A5C0
pool_0232A5C0:
.endfunc
loc_0232A5C0:
	.word P1_DualBufferProcessorState	; 0232A5C0
pool_0232A5C4:
loc_0232A5C4:
	.word 0x023569E8	; 0232A5C4

; ===== function loc_0232A5C8 =====
loc_0232A5C8:
	push {r4,r5,r6,r7,lr}	; 0232A5C8
	sub sp,#0x44	; 0232A5CA
; 初始化双缓冲状态，保存缓冲区、分块信息、回调及其上下文，并登记块调度函数。
; Initialize two-buffer state, store buffers/block data/callback/context, and register the block dispatcher.
.func P1_CreateDualBufferProcessor
	str r0,[sp,#0x18]	; 0232A5CC
	str r1,[sp,#0x1c]	; 0232A5CE
	str r2,[sp,#0x20]	; 0232A5D0
	str r3,[sp,#0x24]	; 0232A5D2
	ldr r7,[sp,#0x64]	; 0232A5D4
	ldr r0,[sp,#0x6c]	; 0232A5D6
	str r0,[sp,#0x6c]	; 0232A5D8
	mov r0,#0x0	; 0232A5DA
	str r0,[sp,#0x30]	; 0232A5DC
	mvn r5,r0	; 0232A5DE
	ldr r4,[pool_0232A7E4]	; 0232A5E0
	lsl r0,r1,#0	; 0232A5E2
	lsl r1,r3,#0	; 0232A5E4
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A5E6
	ldr r0,[sp,#0x20]	; 0232A5EA
	ldr r1,[sp,#0x24]	; 0232A5EC
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A5EE
	ldr r0,[sp,#0x58]	; 0232A5F2
	cmp r0,#0x1	; 0232A5F4
	bne loc_0232A5FC	; 0232A5F6
	mov r6,#0x1	; 0232A5F8
	b loc_0232A5FE	; 0232A5FA
loc_0232A5FC:
	mov r6,#0x0	; 0232A5FC
loc_0232A5FE:
	ldr r0,[pool_0232A7E8]	; 0232A5FE
	ldr r1,[sp,#0x68]	; 0232A600
	blx P1_SignedDivMod	; 0232A602
	str r0,[sp,#0x34]	; 0232A606
	ldr r0,[sp,#0x7c]	; 0232A608
	cmp r0,#0x0	; 0232A60A
	beq loc_0232A648	; 0232A60C
	ldr r0,[sp,#0x24]	; 0232A60E
	cmp r6,#0x0	; 0232A610
	bne loc_0232A616	; 0232A612
	asr r0,r0,#0x1	; 0232A614
loc_0232A616:
	ldr r1,[sp,#0x34]	; 0232A616
	add r1,#0x10	; 0232A618
	str r1,[sp,#0x34]	; 0232A61A
	mov r2,#0x1f	; 0232A61C
	bic r1,r2	; 0232A61E
	str r1,[sp,#0x34]	; 0232A620
	asr r1,r1,#0x5	; 0232A622
	str r1,[sp,#0x40]	; 0232A624
	ldr r1,[sp,#0x78]	; 0232A626
	blx P1_SignedDivMod	; 0232A628
	ldr r1,[sp,#0x40]	; 0232A62C
	str r1,[sp,#0x38]	; 0232A62E
	mul r1,r0	; 0232A630
	str r1,[sp,#0x38]	; 0232A632
	mov r0,#0x20	; 0232A634
	str r0,[sp,#0x3c]	; 0232A636
	cmp r6,#0x0	; 0232A638
	bne loc_0232A640	; 0232A63A
	asr r0,r0,#0x1	; 0232A63C
	str r0,[sp,#0x3c]	; 0232A63E
loc_0232A640:
	ldr r1,[sp,#0x3c]	; 0232A640
	ldr r0,[sp,#0x40]	; 0232A642
	mul r1,r0	; 0232A644
	str r1,[sp,#0x3c]	; 0232A646
loc_0232A648:
	cmp r6,#0x0	; 0232A648
	beq loc_0232A652	; 0232A64A
	mov r0,#0x0	; 0232A64C
	str r0,[sp,#0x2c]	; 0232A64E
	b loc_0232A656	; 0232A650
loc_0232A652:
	mov r0,#0x1	; 0232A652
	str r0,[sp,#0x2c]	; 0232A654
loc_0232A656:
	cmp r6,#0x0	; 0232A656
	beq loc_0232A660	; 0232A658
	mov r0,#0x1	; 0232A65A
	str r0,[sp,#0x28]	; 0232A65C
	b loc_0232A664	; 0232A65E
loc_0232A660:
	mov r0,#0x0	; 0232A660
	str r0,[sp,#0x28]	; 0232A662
loc_0232A664:
	ldr r0,[sp,#0x18]	; 0232A664
	cmp r0,#0x2	; 0232A666
	beq loc_0232A66E	; 0232A668
	mov r0,#0xa	; 0232A66A
	str r0,[sp,#0x30]	; 0232A66C
loc_0232A66E:
	ldr r0,[sp,#0x7c]	; 0232A66E
	cmp r0,#0x0	; 0232A670
	beq loc_0232A688	; 0232A672
	bl loc_02329D6C	; 0232A674
	add r5,r0,#0x0	; 0232A678
	cmp r5,#0x0	; 0232A67A
	bge loc_0232A688	; 0232A67C
	mov r0,#0x0	; 0232A67E
	add sp,#0x44	; 0232A680
	pop {r4,r5,r6,r7}	; 0232A682
	pop {r3}	; 0232A684
	bx r3	; 0232A686
loc_0232A688:
	mov r0,#0x3	; 0232A688
	bl loc_02329DA8	; 0232A68A
	cmp r0,#0x0	; 0232A68E
	bne loc_0232A6A6	; 0232A690
	cmp r5,#0x0	; 0232A692
	blt loc_0232A69C	; 0232A694
	add r0,r5,#0x0	; 0232A696
	bl loc_02329D58	; 0232A698
loc_0232A69C:
	mov r0,#0x0	; 0232A69C
	add sp,#0x44	; 0232A69E
	pop {r4,r5,r6,r7}	; 0232A6A0
	pop {r3}	; 0232A6A2
	bx r3	; 0232A6A4
loc_0232A6A6:
	mov r0,#0xa	; 0232A6A6
	bl loc_02329DE4	; 0232A6A8
	cmp r0,#0x0	; 0232A6AC
	bne loc_0232A6CA	; 0232A6AE
	cmp r5,#0x0	; 0232A6B0
	blt loc_0232A6BA	; 0232A6B2
	add r0,r5,#0x0	; 0232A6B4
	bl loc_02329D58	; 0232A6B6
loc_0232A6BA:
	mov r0,#0x3	; 0232A6BA
	bl loc_02329D98	; 0232A6BC
	mov r0,#0x0	; 0232A6C0
	add sp,#0x44	; 0232A6C2
	pop {r4,r5,r6,r7}	; 0232A6C4
	pop {r3}	; 0232A6C6
	bx r3	; 0232A6C8
loc_0232A6CA:
	cmp r7,#0x0	; 0232A6CA
	beq loc_0232A6D2	; 0232A6CC
	mov r3,#0x1	; 0232A6CE
	b loc_0232A6D4	; 0232A6D0
loc_0232A6D2:
	mov r3,#0x2	; 0232A6D2
loc_0232A6D4:
	ldr r0,[sp,#0x24]	; 0232A6D4
	lsr r6,r0,#0x2	; 0232A6D6
	mov r1,#0x0	; 0232A6D8
	str r1,[sp,#0x0]	; 0232A6DA
	str r6,[sp,#0x4]	; 0232A6DC
	ldr r0,[sp,#0x6c]	; 0232A6DE
	str r0,[sp,#0x8]	; 0232A6E0
	str r1,[sp,#0xc]	; 0232A6E2
	ldr r0,[sp,#0x34]	; 0232A6E4
	str r0,[sp,#0x10]	; 0232A6E6
	ldr r0,[sp,#0x70]	; 0232A6E8
	str r0,[sp,#0x14]	; 0232A6EA
	mov r0,#0x1	; 0232A6EC
	ldr r1,[sp,#0x2c]	; 0232A6EE
	ldr r2,[sp,#0x1c]	; 0232A6F0
	bl loc_0232DF9C	; 0232A6F2
	str r7,[sp,#0x0]	; 0232A6F6
	ldr r0,[sp,#0x5c]	; 0232A6F8
	str r0,[sp,#0x4]	; 0232A6FA
	ldr r0,[sp,#0x60]	; 0232A6FC
	str r0,[sp,#0x8]	; 0232A6FE
	mov r0,#0x0	; 0232A700
	ldr r1,[sp,#0x28]	; 0232A702
	ldr r2,[sp,#0x1c]	; 0232A704
	add r3,r6,#0x0	; 0232A706
	bl loc_0232E058	; 0232A708
	cmp r7,#0x0	; 0232A70C
	beq loc_0232A714	; 0232A70E
	mov r3,#0x1	; 0232A710
	b loc_0232A716	; 0232A712
loc_0232A714:
	mov r3,#0x2	; 0232A714
loc_0232A716:
	mov r1,#0x0	; 0232A716
	str r1,[sp,#0x0]	; 0232A718
	str r6,[sp,#0x4]	; 0232A71A
	ldr r0,[sp,#0x6c]	; 0232A71C
	str r0,[sp,#0x8]	; 0232A71E
	str r1,[sp,#0xc]	; 0232A720
	ldr r0,[sp,#0x34]	; 0232A722
	str r0,[sp,#0x10]	; 0232A724
	ldr r0,[sp,#0x74]	; 0232A726
	str r0,[sp,#0x14]	; 0232A728
	mov r0,#0x3	; 0232A72A
	ldr r1,[sp,#0x2c]	; 0232A72C
	ldr r2,[sp,#0x20]	; 0232A72E
	bl loc_0232DF9C	; 0232A730
	str r7,[sp,#0x0]	; 0232A734
	ldr r0,[sp,#0x5c]	; 0232A736
	str r0,[sp,#0x4]	; 0232A738
	ldr r0,[sp,#0x60]	; 0232A73A
	str r0,[sp,#0x8]	; 0232A73C
	mov r0,#0x1	; 0232A73E
	ldr r1,[sp,#0x28]	; 0232A740
	ldr r2,[sp,#0x20]	; 0232A742
	add r3,r6,#0x0	; 0232A744
	bl loc_0232E058	; 0232A746
	cmp r5,#0x0	; 0232A74A
	blt loc_0232A75E	; 0232A74C
	str r4,[sp,#0x0]	; 0232A74E
	add r0,r5,#0x0	; 0232A750
	ldr r2,[sp,#0x38]	; 0232A752
	ldr r1,[sp,#0x3c]	; 0232A754
	add r1,r2,r1	; 0232A756
	ldr r3,[pool_0232A7EC]	; 0232A758
	bl loc_0232E030	; 0232A75A
loc_0232A75E:
	ldr r0,[sp,#0x18]	; 0232A75E
	cmp r0,#0x1	; 0232A760
	bne loc_0232A770	; 0232A762
	mov r0,#0x3	; 0232A764
	add r1,r0,#0x0	; 0232A766
	mov r2,#0x1	; 0232A768
	add r3,r2,#0x0	; 0232A76A
	bl loc_0232DF7C	; 0232A76C
loc_0232A770:
	cmp r5,#0x0	; 0232A770
	blt loc_0232A77A	; 0232A772
	mov r2,#0x1	; 0232A774
	lsl r2,r5	; 0232A776
	b loc_0232A77C	; 0232A778
loc_0232A77A:
	mov r2,#0x0	; 0232A77A
loc_0232A77C:
	ldr r0,[sp,#0x30]	; 0232A77C
	mov r1,#0x3	; 0232A77E
	mov r3,#0x0	; 0232A780
	bl loc_0232E0DC	; 0232A782
	mov r0,#0x1	; 0232A786
	str r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A788
	ldr r0,[sp,#0x18]	; 0232A78A
	str r0,[r4,#P1_DualBufferProcessorModeOffset]	; 0232A78C
	mov r0,#0xa	; 0232A78E
	str r0,[r4,#0x1c]	; 0232A790
	ldr r0,[sp,#0x30]	; 0232A792
	str r0,[r4,#0x20]	; 0232A794
	mov r0,#0x3	; 0232A796
	str r0,[r4,#0x24]	; 0232A798
	str r5,[r4,#P1_DualBufferProcessorControlMaskIndexOffset]	; 0232A79A
	ldr r0,[sp,#0x58]	; 0232A79C
	str r0,[r4,#P1_DualBufferProcessorUserValueOffset]	; 0232A79E
	ldr r0,[sp,#0x1c]	; 0232A7A0
	str r0,[r4,#P1_DualBufferProcessorFirstBufferOffset]	; 0232A7A2
	ldr r0,[sp,#0x20]	; 0232A7A4
	str r0,[r4,#P1_DualBufferProcessorSecondBufferOffset]	; 0232A7A6
	ldr r0,[sp,#0x24]	; 0232A7A8
	str r0,[r4,#P1_DualBufferProcessorBlockByteCountOffset]	; 0232A7AA
	mov r0,#0x0	; 0232A7AC
	str r0,[r4,#P1_DualBufferProcessorBlockIndexOffset]	; 0232A7AE
	ldr r0,[sp,#0x78]	; 0232A7B0
	str r0,[r4,#P1_DualBufferProcessorBlockCountOffset]	; 0232A7B2
	ldr r0,[sp,#0x7c]	; 0232A7B4
	str r0,[r4,#P1_DualBufferProcessorCallbackOffset]	; 0232A7B6
	ldr r0,[sp,#0x80]	; 0232A7B8
	str r0,[r4,#P1_DualBufferProcessorCallbackContextOffset]	; 0232A7BA
	ldr r0,[sp,#0x6c]	; 0232A7BC
	str r0,[r4,#P1_DualBufferProcessorLastReportedValueOffset]	; 0232A7BE
	add r0,r4,#0x0	; 0232A7C0
	add r0,#0x38	; 0232A7C2
	bl loc_0232AF5C	; 0232A7C4
	add r0,r4,#0x0	; 0232A7C8
	add r0,#0x38	; 0232A7CA
	ldr r1,[sp,#0x6c]	; 0232A7CC
	lsl r1,r1,#0x8	; 0232A7CE
	mov r2,#0x1	; 0232A7D0
	bl loc_0232AF40	; 0232A7D2
	mov r0,#0x0	; 0232A7D6
	str r0,[r4,#0x48]	; 0232A7D8
	mov r0,#0x1	; 0232A7DA
	add sp,#0x44	; 0232A7DC
	pop {r4,r5,r6,r7}	; 0232A7DE
	pop {r3}	; 0232A7E0
	bx r3	; 0232A7E2
pool_0232A7E4:
loc_0232A7E4:
.endfunc
	.word P1_DualBufferProcessorState	; 0232A7E4
pool_0232A7E8:
loc_0232A7E8:
	.word 0x00FFB0FF	; 0232A7E8
pool_0232A7EC:
loc_0232A7EC:
	.word P1_DispatchDualBufferBlock + 1	; 0232A7EC

; ===== function loc_0232A7F0 =====
loc_0232A7F0:
	push {lr}	; 0232A7F0
	sub sp,#0x4	; 0232A7F2
; 仅当处理器已有效且模式字段为 1 时调用停止路径。
; Call the stop path only when the processor is active and its mode field is 1.
.func P1_StopActiveDualBufferProcessor
	ldr r0,[pool_0232A80C]	; 0232A7F4
	ldr r1,[r0,#P1_DualBufferProcessorActiveOffset]	; 0232A7F6
	cmp r1,#0x0	; 0232A7F8
	beq loc_0232A806	; 0232A7FA
	ldr r0,[r0,#P1_DualBufferProcessorModeOffset]	; 0232A7FC
	cmp r0,#0x1	; 0232A7FE
	bne loc_0232A806	; 0232A800
	bl P1_StopDualBufferProcessor	; 0232A802
loc_0232A806:
	add sp,#0x4	; 0232A806
	pop {r3}	; 0232A808
	bx r3	; 0232A80A
pool_0232A80C:
loc_0232A80C:
.endfunc
	.word P1_DualBufferProcessorState	; 0232A80C

; ===== function loc_0232A810 =====
loc_0232A810:
	push {r4,r5,r6,r7,lr}	; 0232A810
	sub sp,#0x34	; 0232A812
; 清零并清理首个缓冲区，然后将参数转交给双缓冲对象构造器。
; Clear and clean the first buffer, then forward parameters to the two-buffer constructor.
.func P1_ConfigureDualBufferProcessor
	add r5,r0,#0x0	; 0232A814
	add r4,r1,#0x0	; 0232A816
	add r6,r2,#0x0	; 0232A818
	add r7,r3,#0x0	; 0232A81A
	bl P1_StopActiveDualBufferProcessor	; 0232A81C
	ldr r0,[pool_0232A87C]	; 0232A820
	ldr r0,[r0,#0x0]	; 0232A822
	cmp r0,#0x0	; 0232A824
	beq loc_0232A832	; 0232A826
	mov r0,#0x0	; 0232A828
	add sp,#0x34	; 0232A82A
	pop {r4,r5,r6,r7}	; 0232A82C
	pop {r3}	; 0232A82E
	bx r3	; 0232A830
loc_0232A832:
	mov r0,#0x0	; 0232A832
	str r0,[sp,#0x2c]	; 0232A834
	ldr r0,[sp,#0x2c]	; 0232A836
	add r1,r5,#0x0	; 0232A838
	add r2,r4,#0x0	; 0232A83A
	blx loc_0232DDE0	; 0232A83C
	add r0,r5,#0x0	; 0232A840
	add r1,r4,#0x0	; 0232A842
	blx P1_CleanAndInvalidateDataCacheRange	; 0232A844
	lsr r3,r4,#0x1	; 0232A848
	str r6,[sp,#0x0]	; 0232A84A
	mov r2,#0x0	; 0232A84C
	str r2,[sp,#0x4]	; 0232A84E
	str r2,[sp,#0x8]	; 0232A850
	mov r0,#0x1	; 0232A852
	str r0,[sp,#0xc]	; 0232A854
	str r7,[sp,#0x10]	; 0232A856
	mov r1,#0x7f	; 0232A858
	str r1,[sp,#0x14]	; 0232A85A
	str r2,[sp,#0x18]	; 0232A85C
	str r1,[sp,#0x1c]	; 0232A85E
	ldr r1,[sp,#0x48]	; 0232A860
	str r1,[sp,#0x20]	; 0232A862
	ldr r1,[sp,#0x4c]	; 0232A864
	str r1,[sp,#0x24]	; 0232A866
	ldr r1,[sp,#0x50]	; 0232A868
	str r1,[sp,#0x28]	; 0232A86A
	add r1,r5,#0x0	; 0232A86C
	add r2,r5,r3	; 0232A86E
	bl P1_CreateDualBufferProcessor	; 0232A870
	add sp,#0x34	; 0232A874
	pop {r4,r5,r6,r7}	; 0232A876
	pop {r3}	; 0232A878
	bx r3	; 0232A87A
pool_0232A87C:
loc_0232A87C:
.endfunc
	.word P1_DualBufferProcessorState	; 0232A87C

; ===== function loc_0232A880 =====
loc_0232A880:
	push {r4,r5,lr}	; 0232A880
	sub sp,#0x4	; 0232A882
; 轮询处理状态；出现终止条件时停止，否则在状态值改变时向下层提交更新。
; Poll processor status; stop on termination, otherwise submit a changed state value to the lower layer.
.func P1_UpdateDualBufferProcessorStatus
	ldr r4,[pool_0232A8DC]	; 0232A884
	ldr r0,[r4,#P1_DualBufferProcessorActiveOffset]	; 0232A886
	cmp r0,#0x0	; 0232A888
	beq loc_0232A8D2	; 0232A88A
	ldr r0,[r4,#P1_DualBufferProcessorModeOffset]	; 0232A88C
	cmp r0,#0x0	; 0232A88E
	bne loc_0232A8D2	; 0232A890
	add r5,r4,#0x0	; 0232A892
	add r5,#0x38	; 0232A894
	add r0,r5,#0x0	; 0232A896
	bl loc_0232AF08	; 0232A898
	ldr r0,[r4,#0x48]	; 0232A89C
	cmp r0,#0x0	; 0232A89E
	beq loc_0232A8B8	; 0232A8A0
	add r0,r5,#0x0	; 0232A8A2
	bl loc_0232AEF8	; 0232A8A4
	cmp r0,#0x0	; 0232A8A8
	beq loc_0232A8B8	; 0232A8AA
	bl P1_StopDualBufferProcessor	; 0232A8AC
	add sp,#0x4	; 0232A8B0
	pop {r4,r5}	; 0232A8B2
	pop {r3}	; 0232A8B4
	bx r3	; 0232A8B6
loc_0232A8B8:
	add r0,r5,#0x0	; 0232A8B8
	bl loc_0232AF18	; 0232A8BA
	asr r5,r0,#0x8	; 0232A8BE
	ldr r0,[r4,#P1_DualBufferProcessorLastReportedValueOffset]	; 0232A8C0
	cmp r5,r0	; 0232A8C2
	beq loc_0232A8D2	; 0232A8C4
	ldr r0,[r4,#0x20]	; 0232A8C6
	add r1,r5,#0x0	; 0232A8C8
	mov r2,#0x0	; 0232A8CA
	bl loc_0232DFD8	; 0232A8CC
	str r5,[r4,#P1_DualBufferProcessorLastReportedValueOffset]	; 0232A8D0
loc_0232A8D2:
	add sp,#0x4	; 0232A8D2
	pop {r4,r5}	; 0232A8D4
	pop {r3}	; 0232A8D6
	bx r3	; 0232A8D8
	.byte 0xC0, 0x46	; 0232A8DC
pool_0232A8DC:
.endfunc
loc_0232A8DC:
	.word P1_DualBufferProcessorState	; 0232A8DC

; ===== function loc_0232A8E0 =====
loc_0232A8E0:
	mov r1,#0x0	; 0232A8E0
	ldr r0,[pool_0232A8EC]	; 0232A8E2
; 清除处理器有效标志及延后交付队列开关。
; Clear the processor active flag and deferred-delivery queue gate.
.func P1_ClearDualBufferProcessorAndQueueState
	str r1,[r0,#0x0]	; 0232A8E4
	ldr r0,[pool_0232A8F0]	; 0232A8E6
	str r1,[r0,#P1_DualBufferProcessorActiveOffset]	; 0232A8E8
	bx lr	; 0232A8EA
pool_0232A8EC:
loc_0232A8EC:
.endfunc
	.word P1_DualBufferDeferredQueueGate	; 0232A8EC
pool_0232A8F0:
loc_0232A8F0:
	.word P1_DualBufferProcessorState	; 0232A8F0

; ===== function loc_0232A8F4 =====
loc_0232A8F4:
	ldr r1,[pool_0232A90C]	; 0232A8F4
	ldr r1,[r1,#0x0]	; 0232A8F6
	ldr r2,[r1,#0x7c]	; 0232A8F8
	ldr r1,[r2,#0x8]	; 0232A8FA
	cmp r0,r1	; 0232A8FC
	bcc loc_0232A904	; 0232A8FE
	mov r0,#0x0	; 0232A900
	bx lr	; 0232A902
loc_0232A904:
	lsl r0,r0,#0x4	; 0232A904
	add r0,r2,r0	; 0232A906
	ldr r0,[r0,#0x14]	; 0232A908
	bx lr	; 0232A90A
pool_0232A90C:
loc_0232A90C:
	.word P1_BssStart + 0x2630C	; 0232A90C

; ===== function loc_0232A910 =====
loc_0232A910:
	ldr r1,[pool_0232A958]	; 0232A910
	ldr r1,[r1,#0x0]	; 0232A912
	add r2,r1,#0x0	; 0232A914
	add r2,#0x84	; 0232A916
	ldr r3,[r2,#0x0]	; 0232A918
	ldr r2,[r3,#0x18]	; 0232A91A
	cmp r2,#0x0	; 0232A91C
	bne loc_0232A924	; 0232A91E
	mov r3,#0x0	; 0232A920
	b loc_0232A926	; 0232A922
loc_0232A924:
	add r3,r3,r2	; 0232A924
loc_0232A926:
	cmp r3,#0x0	; 0232A926
	bne loc_0232A92E	; 0232A928
	mov r0,#0x0	; 0232A92A
	bx lr	; 0232A92C
loc_0232A92E:
	cmp r0,#0x0	; 0232A92E
	bge loc_0232A936	; 0232A930
	mov r0,#0x0	; 0232A932
	bx lr	; 0232A934
loc_0232A936:
	ldr r2,[r3,#0x0]	; 0232A936
	cmp r0,r2	; 0232A938
	bcc loc_0232A940	; 0232A93A
	mov r0,#0x0	; 0232A93C
	bx lr	; 0232A93E
loc_0232A940:
	lsl r0,r0,#0x2	; 0232A940
	add r0,r3,r0	; 0232A942
	ldr r2,[r0,#0x4]	; 0232A944
	add r1,#0x84	; 0232A946
	ldr r0,[r1,#0x0]	; 0232A948
	cmp r2,#0x0	; 0232A94A
	bne loc_0232A952	; 0232A94C
	mov r0,#0x0	; 0232A94E
	bx lr	; 0232A950
loc_0232A952:
	add r0,r0,r2	; 0232A952
	bx lr	; 0232A954
	.byte 0xC0, 0x46	; 0232A958
pool_0232A958:
loc_0232A958:
	.word P1_BssStart + 0x2630C	; 0232A958

; ===== function loc_0232A95C =====
loc_0232A95C:
	ldr r1,[pool_0232A9A4]	; 0232A95C
	ldr r1,[r1,#0x0]	; 0232A95E
	add r2,r1,#0x0	; 0232A960
	add r2,#0x84	; 0232A962
	ldr r3,[r2,#0x0]	; 0232A964
	ldr r2,[r3,#0x14]	; 0232A966
	cmp r2,#0x0	; 0232A968
	bne loc_0232A970	; 0232A96A
	mov r3,#0x0	; 0232A96C
	b loc_0232A972	; 0232A96E
loc_0232A970:
	add r3,r3,r2	; 0232A970
loc_0232A972:
	cmp r3,#0x0	; 0232A972
	bne loc_0232A97A	; 0232A974
	mov r0,#0x0	; 0232A976
	bx lr	; 0232A978
loc_0232A97A:
	cmp r0,#0x0	; 0232A97A
	bge loc_0232A982	; 0232A97C
	mov r0,#0x0	; 0232A97E
	bx lr	; 0232A980
loc_0232A982:
	ldr r2,[r3,#0x0]	; 0232A982
	cmp r0,r2	; 0232A984
	bcc loc_0232A98C	; 0232A986
	mov r0,#0x0	; 0232A988
	bx lr	; 0232A98A
loc_0232A98C:
	lsl r0,r0,#0x2	; 0232A98C
	add r0,r3,r0	; 0232A98E
	ldr r2,[r0,#0x4]	; 0232A990
	add r1,#0x84	; 0232A992
	ldr r0,[r1,#0x0]	; 0232A994
	cmp r2,#0x0	; 0232A996
	bne loc_0232A99E	; 0232A998
	mov r0,#0x0	; 0232A99A
	bx lr	; 0232A99C
loc_0232A99E:
	add r0,r0,r2	; 0232A99E
	bx lr	; 0232A9A0
	.byte 0xC0, 0x46	; 0232A9A4
pool_0232A9A4:
loc_0232A9A4:
	.word P1_BssStart + 0x2630C	; 0232A9A4

; ===== function loc_0232A9A8 =====
loc_0232A9A8:
	ldr r1,[pool_0232A9F0]	; 0232A9A8
	ldr r1,[r1,#0x0]	; 0232A9AA
	add r2,r1,#0x0	; 0232A9AC
	add r2,#0x84	; 0232A9AE
	ldr r3,[r2,#0x0]	; 0232A9B0
	ldr r2,[r3,#0x10]	; 0232A9B2
	cmp r2,#0x0	; 0232A9B4
	bne loc_0232A9BC	; 0232A9B6
	mov r3,#0x0	; 0232A9B8
	b loc_0232A9BE	; 0232A9BA
loc_0232A9BC:
	add r3,r3,r2	; 0232A9BC
loc_0232A9BE:
	cmp r3,#0x0	; 0232A9BE
	bne loc_0232A9C6	; 0232A9C0
	mov r0,#0x0	; 0232A9C2
	bx lr	; 0232A9C4
loc_0232A9C6:
	cmp r0,#0x0	; 0232A9C6
	bge loc_0232A9CE	; 0232A9C8
	mov r0,#0x0	; 0232A9CA
	bx lr	; 0232A9CC
loc_0232A9CE:
	ldr r2,[r3,#0x0]	; 0232A9CE
	cmp r0,r2	; 0232A9D0
	bcc loc_0232A9D8	; 0232A9D2
	mov r0,#0x0	; 0232A9D4
	bx lr	; 0232A9D6
loc_0232A9D8:
	lsl r0,r0,#0x2	; 0232A9D8
	add r0,r3,r0	; 0232A9DA
	ldr r2,[r0,#0x4]	; 0232A9DC
	add r1,#0x84	; 0232A9DE
	ldr r0,[r1,#0x0]	; 0232A9E0
	cmp r2,#0x0	; 0232A9E2
	bne loc_0232A9EA	; 0232A9E4
	mov r0,#0x0	; 0232A9E6
	bx lr	; 0232A9E8
loc_0232A9EA:
	add r0,r0,r2	; 0232A9EA
	bx lr	; 0232A9EC
	.byte 0xC0, 0x46	; 0232A9F0
pool_0232A9F0:
loc_0232A9F0:
	.word P1_BssStart + 0x2630C	; 0232A9F0

; ===== function loc_0232A9F4 =====
loc_0232A9F4:
	ldr r1,[pool_0232AA3C]	; 0232A9F4
	ldr r1,[r1,#0x0]	; 0232A9F6
	add r2,r1,#0x0	; 0232A9F8
	add r2,#0x84	; 0232A9FA
	ldr r3,[r2,#0x0]	; 0232A9FC
	ldr r2,[r3,#0xc]	; 0232A9FE
	cmp r2,#0x0	; 0232AA00
	bne loc_0232AA08	; 0232AA02
	mov r3,#0x0	; 0232AA04
	b loc_0232AA0A	; 0232AA06
loc_0232AA08:
	add r3,r3,r2	; 0232AA08
loc_0232AA0A:
	cmp r3,#0x0	; 0232AA0A
	bne loc_0232AA12	; 0232AA0C
	mov r0,#0x0	; 0232AA0E
	bx lr	; 0232AA10
loc_0232AA12:
	cmp r0,#0x0	; 0232AA12
	bge loc_0232AA1A	; 0232AA14
	mov r0,#0x0	; 0232AA16
	bx lr	; 0232AA18
loc_0232AA1A:
	ldr r2,[r3,#0x0]	; 0232AA1A
	cmp r0,r2	; 0232AA1C
	bcc loc_0232AA24	; 0232AA1E
	mov r0,#0x0	; 0232AA20
	bx lr	; 0232AA22
loc_0232AA24:
	lsl r0,r0,#0x2	; 0232AA24
	add r0,r3,r0	; 0232AA26
	ldr r2,[r0,#0x4]	; 0232AA28
	add r1,#0x84	; 0232AA2A
	ldr r0,[r1,#0x0]	; 0232AA2C
	cmp r2,#0x0	; 0232AA2E
	bne loc_0232AA36	; 0232AA30
	mov r0,#0x0	; 0232AA32
	bx lr	; 0232AA34
loc_0232AA36:
	add r0,r0,r2	; 0232AA36
	bx lr	; 0232AA38
	.byte 0xC0, 0x46	; 0232AA3C
pool_0232AA3C:
loc_0232AA3C:
	.word P1_BssStart + 0x2630C	; 0232AA3C

; ===== function loc_0232AA40 =====
loc_0232AA40:
	ldr r0,[pool_0232AA48]	; 0232AA40
	ldr r0,[r0,#0x0]	; 0232AA42
	bx lr	; 0232AA44
	.byte 0xC0, 0x46	; 0232AA48
pool_0232AA48:
loc_0232AA48:
	.word P1_BssStart + 0x2630C	; 0232AA48

; ===== function loc_0232AA4C =====
loc_0232AA4C:
	push {r4,r5,r6,r7,lr}	; 0232AA4C
	sub sp,#0x4	; 0232AA4E
	add r5,r0,#0x0	; 0232AA50
	add r4,r1,#0x0	; 0232AA52
	add r0,r4,#0x0	; 0232AA54
	add r1,r5,#0x0	; 0232AA56
	mov r2,#0x30	; 0232AA58
	blx loc_0232DDF4	; 0232AA5A
	ldr r0,[r5,#0x18]	; 0232AA5E
	cmp r0,#0x0	; 0232AA60
	bne loc_0232AA68	; 0232AA62
	mov r1,#0x0	; 0232AA64
	b loc_0232AA6A	; 0232AA66
loc_0232AA68:
	add r1,r4,r0	; 0232AA68
loc_0232AA6A:
	add r0,r5,#0x0	; 0232AA6A
	add r0,#0x84	; 0232AA6C
	str r1,[r0,#0x0]	; 0232AA6E
	ldr r0,[r5,#0x20]	; 0232AA70
	cmp r0,#0x0	; 0232AA72
	bne loc_0232AA7A	; 0232AA74
	mov r0,#0x0	; 0232AA76
	b loc_0232AA7C	; 0232AA78
loc_0232AA7A:
	add r0,r4,r0	; 0232AA7A
loc_0232AA7C:
	str r0,[r5,#0x7c]	; 0232AA7C
	ldr r0,[r5,#0x10]	; 0232AA7E
	cmp r0,#0x0	; 0232AA80
	bne loc_0232AA88	; 0232AA82
	mov r1,#0x0	; 0232AA84
	b loc_0232AA8A	; 0232AA86
loc_0232AA88:
	add r1,r4,r0	; 0232AA88
loc_0232AA8A:
	add r0,r5,#0x0	; 0232AA8A
	add r0,#0x80	; 0232AA8C
	str r1,[r0,#0x0]	; 0232AA8E
	mov r0,#0x0	; 0232AA90
	ldr r3,[r5,#0x7c]	; 0232AA92
	ldr r1,[r3,#0x8]	; 0232AA94
	cmp r1,#0x0	; 0232AA96
	bls loc_0232AABC	; 0232AA98
	add r6,r0,#0x0	; 0232AA9A
	add r2,r0,#0x0	; 0232AA9C
loc_0232AA9E:
	add r3,#0xc	; 0232AA9E
	add r7,r3,r6	; 0232AAA0
	ldr r1,[r3,r6]	; 0232AAA2
	cmp r1,#0x0	; 0232AAA4
	bne loc_0232AAAC	; 0232AAA6
	add r1,r2,#0x0	; 0232AAA8
	b loc_0232AAAE	; 0232AAAA
loc_0232AAAC:
	add r1,r4,r1	; 0232AAAC
loc_0232AAAE:
	str r1,[r7,#0x8]	; 0232AAAE
	add r6,#0x10	; 0232AAB0
	add r0,r0,#0x1	; 0232AAB2
	ldr r3,[r5,#0x7c]	; 0232AAB4
	ldr r1,[r3,#0x8]	; 0232AAB6
	cmp r0,r1	; 0232AAB8
	bcc loc_0232AA9E	; 0232AABA
loc_0232AABC:
	ldr r0,[pool_0232AAC8]	; 0232AABC
	str r5,[r0,#0x0]	; 0232AABE
	add sp,#0x4	; 0232AAC0
	pop {r4,r5,r6,r7}	; 0232AAC2
	pop {r3}	; 0232AAC4
	bx r3	; 0232AAC6
pool_0232AAC8:
loc_0232AAC8:
	.word P1_BssStart + 0x2630C	; 0232AAC8

; ===== function loc_0232AACC =====
loc_0232AACC:
	push {r4,lr}	; 0232AACC
	bl loc_0232E2AC	; 0232AACE
	add r4,r0,#0x0	; 0232AAD2
	mov r0,#0x1	; 0232AAD4
	bl loc_0232E318	; 0232AAD6
	add r0,r4,#0x0	; 0232AADA
	bl loc_0232E2CC	; 0232AADC
	pop {r4}	; 0232AAE0
	pop {r3}	; 0232AAE2
	bx r3	; 0232AAE4
	.byte 0x00, 0x00	; 0232AAE8

; ===== function loc_0232AAE8 =====
loc_0232AAE8:
	push {r4,r5,lr}	; 0232AAE8
	sub sp,#0x4	; 0232AAEA
	add r5,r0,#0x0	; 0232AAEC
	ldr r0,[r5,#0x0]	; 0232AAEE
	mov r1,#0x14	; 0232AAF0
	mov r2,#0x4	; 0232AAF2
	bl loc_02329B74	; 0232AAF4
	add r4,r0,#0x0	; 0232AAF8
	cmp r4,#0x0	; 0232AAFA
	bne loc_0232AB08	; 0232AAFC
	mov r0,#0x0	; 0232AAFE
	add sp,#0x4	; 0232AB00
	pop {r4,r5}	; 0232AB02
	pop {r3}	; 0232AB04
	bx r3	; 0232AB06
loc_0232AB08:
	bl loc_0232AB50	; 0232AB08
	add r0,r5,#0x4	; 0232AB0C
	add r1,r4,#0x0	; 0232AB0E
	bl loc_02329604	; 0232AB10
	mov r0,#0x1	; 0232AB14
	add sp,#0x4	; 0232AB16
	pop {r4,r5}	; 0232AB18
	pop {r3}	; 0232AB1A
	bx r3	; 0232AB1C
	.byte 0x00, 0x00	; 0232AB20

; ===== function loc_0232AB20 =====
loc_0232AB20:
	push {r4,r5,lr}	; 0232AB20
	sub sp,#0x4	; 0232AB22
	add r5,r0,#0x0	; 0232AB24
	add r4,r1,#0x0	; 0232AB26
	add r0,r5,#0x4	; 0232AB28
	mov r1,#0xc	; 0232AB2A
	bl loc_02329658	; 0232AB2C
	str r4,[r5,#0x0]	; 0232AB30
	add r0,r5,#0x0	; 0232AB32
	bl loc_0232AAE8	; 0232AB34
	cmp r0,#0x0	; 0232AB38
	beq loc_0232AB46	; 0232AB3A
	mov r0,#0x1	; 0232AB3C
	add sp,#0x4	; 0232AB3E
	pop {r4,r5}	; 0232AB40
	pop {r3}	; 0232AB42
	bx r3	; 0232AB44
loc_0232AB46:
	mov r0,#0x0	; 0232AB46
	add sp,#0x4	; 0232AB48
	pop {r4,r5}	; 0232AB4A
	pop {r3}	; 0232AB4C
	bx r3	; 0232AB4E

; ===== function loc_0232AB50 =====
loc_0232AB50:
	mov r1,#0x0	; 0232AB50
	ldr r3,[pool_0232AB58]	; 0232AB52
	bx r3	; 0232AB54
	.byte 0xC0, 0x46	; 0232AB58
pool_0232AB58:
loc_0232AB58:
	.word loc_02329658 + 1	; 0232AB58

; ===== function loc_0232AB5C =====
loc_0232AB5C:
	push {r4,r5,r6,r7,lr}	; 0232AB5C
	sub sp,#0x4	; 0232AB5E
	add r5,r0,#0x0	; 0232AB60
	add r6,r1,#0x0	; 0232AB62
	add r7,r2,#0x0	; 0232AB64
	str r3,[sp,#0x0]	; 0232AB66
	ldr r0,[r5,#0x0]	; 0232AB68
	add r1,#0x1f	; 0232AB6A
	mov r2,#0x1f	; 0232AB6C
	bic r1,r2	; 0232AB6E
	add r1,#0x20	; 0232AB70
	mov r2,#0x20	; 0232AB72
	bl loc_02329B74	; 0232AB74
	add r4,r0,#0x0	; 0232AB78
	cmp r4,#0x0	; 0232AB7A
	bne loc_0232AB88	; 0232AB7C
	mov r0,#0x0	; 0232AB7E
	add sp,#0x4	; 0232AB80
	pop {r4,r5,r6,r7}	; 0232AB82
	pop {r3}	; 0232AB84
	bx r3	; 0232AB86
loc_0232AB88:
	add r0,r5,#0x4	; 0232AB88
	mov r1,#0x0	; 0232AB8A
	bl loc_02329524	; 0232AB8C
	str r6,[r4,#0x8]	; 0232AB90
	str r7,[r4,#0xc]	; 0232AB92
	ldr r1,[sp,#0x0]	; 0232AB94
	str r1,[r4,#0x10]	; 0232AB96
	ldr r1,[sp,#0x18]	; 0232AB98
	str r1,[r4,#0x14]	; 0232AB9A
	add r1,r4,#0x0	; 0232AB9C
	bl loc_02329604	; 0232AB9E
	add r4,#0x20	; 0232ABA2
	add r0,r4,#0x0	; 0232ABA4
	add sp,#0x4	; 0232ABA6
	pop {r4,r5,r6,r7}	; 0232ABA8
	pop {r3}	; 0232ABAA
	bx r3	; 0232ABAC
	.byte 0x00, 0x00	; 0232ABB0

; ===== function loc_0232ABB0 =====
loc_0232ABB0:
	push {r4,r5,r6,r7,lr}	; 0232ABB0
	sub sp,#0x4	; 0232ABB2
	add r7,r0,#0x0	; 0232ABB4
	add r0,r7,#0x4	; 0232ABB6
	mov r1,#0x0	; 0232ABB8
	bl loc_02329524	; 0232ABBA
	add r5,r0,#0x0	; 0232ABBE
	cmp r5,#0x0	; 0232ABC0
	beq loc_0232AC08	; 0232ABC2
loc_0232ABC4:
	add r0,r5,#0x0	; 0232ABC4
	mov r1,#0x0	; 0232ABC6
	bl loc_02329524	; 0232ABC8
	add r4,r0,#0x0	; 0232ABCC
	cmp r4,#0x0	; 0232ABCE
	beq loc_0232ABF2	; 0232ABD0
loc_0232ABD2:
	ldr r6,[r4,#0xc]	; 0232ABD2
	cmp r6,#0x0	; 0232ABD4
	beq loc_0232ABE4	; 0232ABD6
	add r0,r4,#0x0	; 0232ABD8
	add r0,#0x20	; 0232ABDA
	ldr r1,[r4,#0x8]	; 0232ABDC
	ldr r2,[r4,#0x10]	; 0232ABDE
	ldr r3,[r4,#0x14]	; 0232ABE0
	blx r6	; 0232ABE2
loc_0232ABE4:
	add r0,r5,#0x0	; 0232ABE4
	add r1,r4,#0x0	; 0232ABE6
	bl loc_02329524	; 0232ABE8
	add r4,r0,#0x0	; 0232ABEC
	cmp r4,#0x0	; 0232ABEE
	bne loc_0232ABD2	; 0232ABF0
loc_0232ABF2:
	add r0,r7,#0x4	; 0232ABF2
	add r1,r5,#0x0	; 0232ABF4
	bl loc_02329544	; 0232ABF6
	add r0,r7,#0x4	; 0232ABFA
	mov r1,#0x0	; 0232ABFC
	bl loc_02329524	; 0232ABFE
	add r5,r0,#0x0	; 0232AC02
	cmp r5,#0x0	; 0232AC04
	bne loc_0232ABC4	; 0232AC06
loc_0232AC08:
	ldr r0,[r7,#0x0]	; 0232AC08
	mov r1,#0x3	; 0232AC0A
	bl loc_02329B48	; 0232AC0C
	bl loc_0232AACC	; 0232AC10
	add r0,r7,#0x0	; 0232AC14
	bl loc_0232AAE8	; 0232AC16
	add sp,#0x4	; 0232AC1A
	pop {r4,r5,r6,r7}	; 0232AC1C
	pop {r3}	; 0232AC1E
	bx r3	; 0232AC20
	.byte 0x00, 0x00	; 0232AC24

; ===== function loc_0232AC24 =====
loc_0232AC24:
	push {r4,lr}	; 0232AC24
	add r4,r0,#0x0	; 0232AC26
	bl loc_0232ABB0	; 0232AC28
	ldr r0,[r4,#0x0]	; 0232AC2C
	bl loc_02329BA0	; 0232AC2E
	pop {r4}	; 0232AC32
	pop {r3}	; 0232AC34
	bx r3	; 0232AC36

; ===== function loc_0232AC38 =====
loc_0232AC38:
	push {r4,r5,lr}	; 0232AC38
	sub sp,#0x4	; 0232AC3A
	add r1,r0,r1	; 0232AC3C
	add r4,r0,#0x3	; 0232AC3E
	mov r0,#0x3	; 0232AC40
	bic r4,r0	; 0232AC42
	cmp r4,r1	; 0232AC44
	bls loc_0232AC52	; 0232AC46
	mov r0,#0x0	; 0232AC48
	add sp,#0x4	; 0232AC4A
	pop {r4,r5}	; 0232AC4C
	pop {r3}	; 0232AC4E
	bx r3	; 0232AC50
loc_0232AC52:
	sub r1,r1,r4	; 0232AC52
	cmp r1,#0x10	; 0232AC54
	bcs loc_0232AC62	; 0232AC56
	mov r0,#0x0	; 0232AC58
	add sp,#0x4	; 0232AC5A
	pop {r4,r5}	; 0232AC5C
	pop {r3}	; 0232AC5E
	bx r3	; 0232AC60
loc_0232AC62:
	add r0,r4,#0x0	; 0232AC62
	add r0,#0x10	; 0232AC64
	sub r1,#0x10	; 0232AC66
	mov r2,#0x0	; 0232AC68
	bl loc_02329BA8	; 0232AC6A
	add r5,r0,#0x0	; 0232AC6E
	cmp r5,#0x0	; 0232AC70
	bne loc_0232AC7E	; 0232AC72
	mov r0,#0x0	; 0232AC74
	add sp,#0x4	; 0232AC76
	pop {r4,r5}	; 0232AC78
	pop {r3}	; 0232AC7A
	bx r3	; 0232AC7C
loc_0232AC7E:
	add r0,r4,#0x0	; 0232AC7E
	add r1,r5,#0x0	; 0232AC80
	bl loc_0232AB20	; 0232AC82
	cmp r0,#0x0	; 0232AC86
	bne loc_0232AC9A	; 0232AC88
	add r0,r5,#0x0	; 0232AC8A
	bl loc_02329BA0	; 0232AC8C
	mov r0,#0x0	; 0232AC90
	add sp,#0x4	; 0232AC92
	pop {r4,r5}	; 0232AC94
	pop {r3}	; 0232AC96
	bx r3	; 0232AC98
loc_0232AC9A:
	add r0,r4,#0x0	; 0232AC9A
	add sp,#0x4	; 0232AC9C
	pop {r4,r5}	; 0232AC9E
	pop {r3}	; 0232ACA0
	bx r3	; 0232ACA2

; ===== function loc_0232ACA4 =====
loc_0232ACA4:
	push {r4,r5,r6,r7,lr}	; 0232ACA4
	sub sp,#0xc	; 0232ACA6
	str r0,[sp,#0x0]	; 0232ACA8
	add r5,r1,#0x0	; 0232ACAA
	add r6,r3,#0x0	; 0232ACAC
	ldr r7,[sp,#0x20]	; 0232ACAE
	add r0,r2,#0x0	; 0232ACB0
	bl loc_0232A9A8	; 0232ACB2
	add r4,r0,#0x0	; 0232ACB6
	cmp r4,#0x0	; 0232ACB8
	bne loc_0232ACC6	; 0232ACBA
	mov r0,#0x0	; 0232ACBC
	add sp,#0xc	; 0232ACBE
	pop {r4,r5,r6,r7}	; 0232ACC0
	pop {r3}	; 0232ACC2
	bx r3	; 0232ACC4
loc_0232ACC6:
	ldr r0,[sp,#0x0]	; 0232ACC6
	add r1,r5,#0x0	; 0232ACC8
	add r2,r6,#0x0	; 0232ACCA
	bl loc_0232A0C8	; 0232ACCC
	str r0,[sp,#0x4]	; 0232ACD0
	cmp r0,#0x0	; 0232ACD2
	bne loc_0232ACE0	; 0232ACD4
	mov r0,#0x0	; 0232ACD6
	add sp,#0xc	; 0232ACD8
	pop {r4,r5,r6,r7}	; 0232ACDA
	pop {r3}	; 0232ACDC
	bx r3	; 0232ACDE
loc_0232ACE0:
	ldr r0,[r4,#0x0]	; 0232ACE0
	bl loc_0232A8F4	; 0232ACE2
	add r6,r0,#0x0	; 0232ACE6
	cmp r6,#0x0	; 0232ACE8
	bne loc_0232ACFC	; 0232ACEA
	ldr r0,[sp,#0x4]	; 0232ACEC
	bl loc_0232A0C0	; 0232ACEE
	mov r0,#0x0	; 0232ACF2
	add sp,#0xc	; 0232ACF4
	pop {r4,r5,r6,r7}	; 0232ACF6
	pop {r3}	; 0232ACF8
	bx r3	; 0232ACFA
loc_0232ACFC:
	mov r5,#0x0	; 0232ACFC
loc_0232ACFE:
	ldrh r0,[r4,#0x4]	; 0232ACFE
	ldr r1,[pool_0232AD80]	; 0232AD00
	cmp r0,r1	; 0232AD02
	beq loc_0232AD42	; 0232AD04
	bl loc_0232A95C	; 0232AD06
	cmp r0,#0x0	; 0232AD0A
	bne loc_0232AD1E	; 0232AD0C
	ldr r0,[sp,#0x4]	; 0232AD0E
	bl loc_0232A0C0	; 0232AD10
	mov r0,#0x0	; 0232AD14
	add sp,#0xc	; 0232AD16
	pop {r4,r5,r6,r7}	; 0232AD18
	pop {r3}	; 0232AD1A
	bx r3	; 0232AD1C
loc_0232AD1E:
	ldr r0,[r0,#0x0]	; 0232AD1E
	bl loc_0232A8F4	; 0232AD20
	add r2,r0,#0x0	; 0232AD24
	cmp r2,#0x0	; 0232AD26
	bne loc_0232AD3A	; 0232AD28
	ldr r0,[sp,#0x4]	; 0232AD2A
	bl loc_0232A0C0	; 0232AD2C
	mov r0,#0x0	; 0232AD30
	add sp,#0xc	; 0232AD32
	pop {r4,r5,r6,r7}	; 0232AD34
	pop {r3}	; 0232AD36
	bx r3	; 0232AD38
loc_0232AD3A:
	add r0,r6,#0x0	; 0232AD3A
	add r1,r5,#0x0	; 0232AD3C
	bl loc_0232E6FC	; 0232AD3E
loc_0232AD42:
	add r4,r4,#0x2	; 0232AD42
	add r5,r5,#0x1	; 0232AD44
	cmp r5,#0x4	; 0232AD46
	blt loc_0232ACFE	; 0232AD48
	ldr r0,[sp,#0x4]	; 0232AD4A
	ldr r2,[sp,#0x24]	; 0232AD4C
	ldr r1,[r2,#0x18]	; 0232AD4E
	add r1,r2,r1	; 0232AD50
	ldr r2,[r7,#0x0]	; 0232AD52
	add r3,r6,#0x0	; 0232AD54
	bl loc_0232A09C	; 0232AD56
	ldr r0,[sp,#0x0]	; 0232AD5A
	ldrb r1,[r7,#0x6]	; 0232AD5C
	bl loc_0232A1C8	; 0232AD5E
	ldr r0,[sp,#0x0]	; 0232AD62
	ldrb r1,[r7,#0x7]	; 0232AD64
	bl loc_0232A18C	; 0232AD66
	ldr r0,[sp,#0x0]	; 0232AD6A
	ldr r1,[sp,#0x28]	; 0232AD6C
	ldr r2,[sp,#0x2c]	; 0232AD6E
	bl loc_0232A140	; 0232AD70
	mov r0,#0x1	; 0232AD74
	add sp,#0xc	; 0232AD76
	pop {r4,r5,r6,r7}	; 0232AD78
	pop {r3}	; 0232AD7A
	bx r3	; 0232AD7C
	.byte 0xC0, 0x46	; 0232AD80
pool_0232AD80:
loc_0232AD80:
	.word 0x0000FFFF	; 0232AD80

; ===== function loc_0232AD84 =====
	push {r4,r5,r6,r7,lr}	; 0232AD84
	sub sp,#0x14	; 0232AD86
	str r0,[sp,#0x10]	; 0232AD88
	add r5,r1,#0x0	; 0232AD8A
	add r4,r2,#0x0	; 0232AD8C
	add r6,r3,#0x0	; 0232AD8E
	ldr r0,[sp,#0x28]	; 0232AD90
	bl loc_0232A9F4	; 0232AD92
	cmp r0,#0x0	; 0232AD96
	bne loc_0232ADA4	; 0232AD98
	mov r0,#0x0	; 0232AD9A
	add sp,#0x14	; 0232AD9C
	pop {r4,r5,r6,r7}	; 0232AD9E
	pop {r3}	; 0232ADA0
	bx r3	; 0232ADA2
loc_0232ADA4:
	ldr r0,[r0,#0x0]	; 0232ADA4
	bl loc_0232A8F4	; 0232ADA6
	add r7,r0,#0x0	; 0232ADAA
	cmp r7,#0x0	; 0232ADAC
	bne loc_0232ADBA	; 0232ADAE
	mov r0,#0x0	; 0232ADB0
	add sp,#0x14	; 0232ADB2
	pop {r4,r5,r6,r7}	; 0232ADB4
	pop {r3}	; 0232ADB6
	bx r3	; 0232ADB8
loc_0232ADBA:
	ldr r1,[sp,#0x2c]	; 0232ADBA
	bl loc_0232AECC	; 0232ADBC
	cmp r0,#0x0	; 0232ADC0
	bne loc_0232ADCE	; 0232ADC2
	mov r0,#0x0	; 0232ADC4
	add sp,#0x14	; 0232ADC6
	pop {r4,r5,r6,r7}	; 0232ADC8
	pop {r3}	; 0232ADCA
	bx r3	; 0232ADCC
loc_0232ADCE:
	cmp r6,#0x0	; 0232ADCE
	bge loc_0232ADD4	; 0232ADD0
	ldrb r6,[r0,#0x8]	; 0232ADD2
loc_0232ADD4:
	cmp r4,#0x0	; 0232ADD4
	bge loc_0232ADDA	; 0232ADD6
	ldrh r4,[r0,#0x4]	; 0232ADD8
loc_0232ADDA:
	cmp r5,#0x0	; 0232ADDA
	bge loc_0232ADE0	; 0232ADDC
	ldrb r5,[r0,#0x9]	; 0232ADDE
loc_0232ADE0:
	str r0,[sp,#0x0]	; 0232ADE0
	str r7,[sp,#0x4]	; 0232ADE2
	ldr r0,[sp,#0x28]	; 0232ADE4
	str r0,[sp,#0x8]	; 0232ADE6
	ldr r0,[sp,#0x2c]	; 0232ADE8
	str r0,[sp,#0xc]	; 0232ADEA
	ldr r0,[sp,#0x10]	; 0232ADEC
	add r1,r5,#0x0	; 0232ADEE
	add r2,r4,#0x0	; 0232ADF0
	add r3,r6,#0x0	; 0232ADF2
	bl loc_0232ACA4	; 0232ADF4
	add sp,#0x14	; 0232ADF8
	pop {r4,r5,r6,r7}	; 0232ADFA
	pop {r3}	; 0232ADFC
	bx r3	; 0232ADFE
loc_0232AE00:
	push {r4,r5,r6,r7,lr}	; 0232AE00
	sub sp,#0x14	; 0232AE02
	add r7,r0,#0x0	; 0232AE04
	add r5,r1,#0x0	; 0232AE06
	add r4,r2,#0x0	; 0232AE08
	add r0,r5,#0x0	; 0232AE0A
	bl loc_0232A9F4	; 0232AE0C
	cmp r0,#0x0	; 0232AE10
	bne loc_0232AE1E	; 0232AE12
	mov r0,#0x0	; 0232AE14
	add sp,#0x14	; 0232AE16
	pop {r4,r5,r6,r7}	; 0232AE18
	pop {r3}	; 0232AE1A
	bx r3	; 0232AE1C
loc_0232AE1E:
	ldr r0,[r0,#0x0]	; 0232AE1E
	bl loc_0232A8F4	; 0232AE20
	add r6,r0,#0x0	; 0232AE24
	cmp r6,#0x0	; 0232AE26
	bne loc_0232AE34	; 0232AE28
	mov r0,#0x0	; 0232AE2A
	add sp,#0x14	; 0232AE2C
	pop {r4,r5,r6,r7}	; 0232AE2E
	pop {r3}	; 0232AE30
	bx r3	; 0232AE32
loc_0232AE34:
	add r1,r4,#0x0	; 0232AE34
	bl loc_0232AECC	; 0232AE36
	add r3,r0,#0x0	; 0232AE3A
	cmp r3,#0x0	; 0232AE3C
	bne loc_0232AE4A	; 0232AE3E
	mov r0,#0x0	; 0232AE40
	add sp,#0x14	; 0232AE42
	pop {r4,r5,r6,r7}	; 0232AE44
	pop {r3}	; 0232AE46
	bx r3	; 0232AE48
loc_0232AE4A:
	str r3,[sp,#0x0]	; 0232AE4A
	str r6,[sp,#0x4]	; 0232AE4C
	str r5,[sp,#0x8]	; 0232AE4E
	str r4,[sp,#0xc]	; 0232AE50
	add r0,r7,#0x0	; 0232AE52
	ldrb r1,[r3,#0x9]	; 0232AE54
	ldrh r2,[r3,#0x4]	; 0232AE56
	ldrb r3,[r3,#0x8]	; 0232AE58
	bl loc_0232ACA4	; 0232AE5A
	add sp,#0x14	; 0232AE5E
	pop {r4,r5,r6,r7}	; 0232AE60
	pop {r3}	; 0232AE62
	bx r3	; 0232AE64
	.byte 0x00, 0x00	; 0232AE68

; ===== function loc_0232AE68 =====
loc_0232AE68:
	push {r4,r5,r6,r7,lr}	; 0232AE68
	sub sp,#0x4	; 0232AE6A
	add r7,r0,#0x0	; 0232AE6C
	bl loc_0232AA40	; 0232AE6E
	mov r6,#0x0	; 0232AE72
	str r6,[sp,#0x0]	; 0232AE74
loc_0232AE76:
	add r0,r6,#0x0	; 0232AE76
	bl loc_0232A910	; 0232AE78
	add r5,r0,#0x0	; 0232AE7C
	cmp r5,#0x0	; 0232AE7E
	beq loc_0232AEBC	; 0232AE80
	add r0,r6,#0x0	; 0232AE82
	ldrb r1,[r5,#0x0]	; 0232AE84
	bl loc_0232A274	; 0232AE86
	ldr r0,[r5,#0x4]	; 0232AE8A
	cmp r0,#0x0	; 0232AE8C
	beq loc_0232AEBC	; 0232AE8E
	cmp r7,#0x0	; 0232AE90
	beq loc_0232AEBC	; 0232AE92
	ldr r4,[sp,#0x0]	; 0232AE94
	ldrb r0,[r5,#0x0]	; 0232AE96
	cmp r0,#0x0	; 0232AE98
	ble loc_0232AEBC	; 0232AE9A
loc_0232AE9C:
	add r0,r6,#0x0	; 0232AE9C
	add r1,r7,#0x0	; 0232AE9E
	ldr r2,[r5,#0x4]	; 0232AEA0
	bl loc_0232A208	; 0232AEA2
	cmp r0,#0x0	; 0232AEA6
	bne loc_0232AEB4	; 0232AEA8
	mov r0,#0x0	; 0232AEAA
	add sp,#0x4	; 0232AEAC
	pop {r4,r5,r6,r7}	; 0232AEAE
	pop {r3}	; 0232AEB0
	bx r3	; 0232AEB2
loc_0232AEB4:
	add r4,r4,#0x1	; 0232AEB4
	ldrb r0,[r5,#0x0]	; 0232AEB6
	cmp r4,r0	; 0232AEB8
	blt loc_0232AE9C	; 0232AEBA
loc_0232AEBC:
	add r6,r6,#0x1	; 0232AEBC
	cmp r6,#0x20	; 0232AEBE
	blt loc_0232AE76	; 0232AEC0
	mov r0,#0x1	; 0232AEC2
	add sp,#0x4	; 0232AEC4
	pop {r4,r5,r6,r7}	; 0232AEC6
	pop {r3}	; 0232AEC8
	bx r3	; 0232AECA

; ===== function loc_0232AECC =====
loc_0232AECC:
	cmp r1,#0x0	; 0232AECC
	bge loc_0232AED4	; 0232AECE
	mov r0,#0x0	; 0232AED0
	bx lr	; 0232AED2
loc_0232AED4:
	ldr r2,[r0,#0x1c]	; 0232AED4
	cmp r1,r2	; 0232AED6
	bcc loc_0232AEDE	; 0232AED8
	mov r0,#0x0	; 0232AEDA
	bx lr	; 0232AEDC
loc_0232AEDE:
	add r0,#0x20	; 0232AEDE
	mov r2,#0xc	; 0232AEE0
	mul r1,r2	; 0232AEE2
	add r3,r0,r1	; 0232AEE4
	ldr r2,[r0,r1]	; 0232AEE6
	mov r0,#0x0	; 0232AEE8
	mvn r1,r0	; 0232AEEA
	cmp r2,r1	; 0232AEEC
	bne loc_0232AEF2	; 0232AEEE
	add r3,r0,#0x0	; 0232AEF0
loc_0232AEF2:
	add r0,r3,#0x0	; 0232AEF2
	bx lr	; 0232AEF4
	.byte 0x00, 0x00	; 0232AEF8

; ===== function loc_0232AEF8 =====
loc_0232AEF8:
	ldr r1,[r0,#0x8]	; 0232AEF8
	ldr r0,[r0,#0xc]	; 0232AEFA
	cmp r1,r0	; 0232AEFC
	blt loc_0232AF04	; 0232AEFE
	mov r0,#0x1	; 0232AF00
	bx lr	; 0232AF02
loc_0232AF04:
	mov r0,#0x0	; 0232AF04
	bx lr	; 0232AF06

; ===== function loc_0232AF08 =====
loc_0232AF08:
	ldr r2,[r0,#0x8]	; 0232AF08
	ldr r1,[r0,#0xc]	; 0232AF0A
	cmp r2,r1	; 0232AF0C
	bge loc_0232AF14	; 0232AF0E
	add r1,r2,#0x1	; 0232AF10
	str r1,[r0,#0x8]	; 0232AF12
loc_0232AF14:
	bx lr	; 0232AF14
	.byte 0x00, 0x00	; 0232AF18

; ===== function loc_0232AF18 =====
loc_0232AF18:
	push {r4,lr}	; 0232AF18
	ldr r1,[r0,#0xc]	; 0232AF1A
	ldr r2,[r0,#0x8]	; 0232AF1C
	cmp r2,r1	; 0232AF1E
	blt loc_0232AF2A	; 0232AF20
	ldr r0,[r0,#0x4]	; 0232AF22
	pop {r4}	; 0232AF24
	pop {r3}	; 0232AF26
	bx r3	; 0232AF28
loc_0232AF2A:
	ldr r4,[r0,#0x0]	; 0232AF2A
	ldr r0,[r0,#0x4]	; 0232AF2C
	sub r0,r0,r4	; 0232AF2E
	mul r2,r0	; 0232AF30
	add r0,r2,#0x0	; 0232AF32
	blx P1_SignedDivMod	; 0232AF34
	add r0,r4,r0	; 0232AF38
	pop {r4}	; 0232AF3A
	pop {r3}	; 0232AF3C
	bx r3	; 0232AF3E

; ===== function loc_0232AF40 =====
loc_0232AF40:
	push {r4,r5,r6,lr}	; 0232AF40
	add r5,r0,#0x0	; 0232AF42
	add r4,r1,#0x0	; 0232AF44
	add r6,r2,#0x0	; 0232AF46
	bl loc_0232AF18	; 0232AF48
	str r0,[r5,#0x0]	; 0232AF4C
	str r4,[r5,#0x4]	; 0232AF4E
	str r6,[r5,#0xc]	; 0232AF50
	mov r0,#0x0	; 0232AF52
	str r0,[r5,#0x8]	; 0232AF54
	pop {r4,r5,r6}	; 0232AF56
	pop {r3}	; 0232AF58
	bx r3	; 0232AF5A

; ===== function loc_0232AF5C =====
loc_0232AF5C:
	mov r2,#0x0	; 0232AF5C
	str r2,[r0,#0x4]	; 0232AF5E
	ldr r1,[r0,#0x4]	; 0232AF60
	str r1,[r0,#0x0]	; 0232AF62
	str r2,[r0,#0xc]	; 0232AF64
	ldr r1,[r0,#0xc]	; 0232AF66
	str r1,[r0,#0x8]	; 0232AF68
	bx lr	; 0232AF6A
.arm

; ===== function loc_0232AF6C =====
loc_0232AF6C:
	stmdb sp!,{r4,r5,r6,lr}	; 0232AF6C
	mov r5,r0	; 0232AF70
	mov r4,r1	; 0232AF74
	bl P1_Arm9DisableIrqReturnPriorMask	; 0232AF78
	cmp r5,#0x0	; 0232AF7C
	beq loc_0232AF9C	; 0232AF80
	ldr r1,[pool_0232AFE0]	; 0232AF84
	mvn r2,r4	; 0232AF88
	add r1,r1,#0x3000	; 0232AF8C
	ldr r3,[r1,#0xff8]	; 0232AF90
	and r2,r3,r2	; 0232AF94
	str r2,[r1,#0xff8]	; 0232AF98
loc_0232AF9C:
	bl P1_Arm9RestoreIrqMask	; 0232AF9C
	ldr r1,[pool_0232AFE0]	; 0232AFA0
	add r0,r1,#0x3000	; 0232AFA4
	ldr r0,[r0,#0xff8]	; 0232AFA8
	ands r0,r4,r0	; 0232AFAC
	ldmneia sp!,{r4,r5,r6,lr}	; 0232AFB0
	bxne lr	; 0232AFB4
	ldr r0,[pool_0232AFE4]	; 0232AFB8
	add r6,r1,r0	; 0232AFBC
	ldr r5,[pool_0232AFE8]	; 0232AFC0
loc_0232AFC4:
	mov r0,r5	; 0232AFC4
	blx loc_0232B62C	; 0232AFC8
	ldr r0,[r6,#0x0]	; 0232AFCC
	ands r0,r4,r0	; 0232AFD0
	beq loc_0232AFC4	; 0232AFD4
	ldmia sp!,{r4,r5,r6,lr}	; 0232AFD8
	bx lr	; 0232AFDC
pool_0232AFE0:
loc_0232AFE0:
	.word P1_DtcmRuntimeStart	; 0232AFE0
pool_0232AFE4:
loc_0232AFE4:
	.word 0x00003FF8	; 0232AFE4
pool_0232AFE8:
loc_0232AFE8:
	.word P1_DtcmRuntimeStart	; 0232AFE8
.thumb
P1_IrqHandler_0232AFEC:
	mov r0,#0x7	; 0232AFEC
	ldr r3,[pool_0232AFF4]	; 0232AFEE
	bx r3	; 0232AFF0
	.byte 0xC0, 0x46	; 0232AFF4
pool_0232AFF4:
loc_0232AFF4:
	.word loc_0232B04C + 1	; 0232AFF4
P1_IrqHandler_0232AFF8:
	mov r0,#0x6	; 0232AFF8
	ldr r3,[pool_0232B000]	; 0232AFFA
	bx r3	; 0232AFFC
	.byte 0xC0, 0x46	; 0232B000
pool_0232B000:
loc_0232B000:
	.word loc_0232B04C + 1	; 0232B000
P1_IrqHandler_0232B004:
	mov r0,#0x5	; 0232B004
	ldr r3,[pool_0232B00C]	; 0232B006
	bx r3	; 0232B008
	.byte 0xC0, 0x46	; 0232B00C
pool_0232B00C:
loc_0232B00C:
	.word loc_0232B04C + 1	; 0232B00C
P1_IrqHandler_0232B010:
	mov r0,#0x4	; 0232B010
	ldr r3,[pool_0232B018]	; 0232B012
	bx r3	; 0232B014
	.byte 0xC0, 0x46	; 0232B018
pool_0232B018:
loc_0232B018:
	.word loc_0232B04C + 1	; 0232B018
P1_IrqHandler_0232B01C:
	mov r0,#0x3	; 0232B01C
	ldr r3,[pool_0232B024]	; 0232B01E
	bx r3	; 0232B020
	.byte 0xC0, 0x46	; 0232B024
pool_0232B024:
loc_0232B024:
	.word loc_0232B04C + 1	; 0232B024
P1_IrqHandler_0232B028:
	mov r0,#0x2	; 0232B028
	ldr r3,[pool_0232B030]	; 0232B02A
	bx r3	; 0232B02C
	.byte 0xC0, 0x46	; 0232B030
pool_0232B030:
loc_0232B030:
	.word loc_0232B04C + 1	; 0232B030
P1_IrqHandler_0232B034:
	mov r0,#0x1	; 0232B034
	ldr r3,[pool_0232B03C]	; 0232B036
	bx r3	; 0232B038
	.byte 0xC0, 0x46	; 0232B03C
pool_0232B03C:
loc_0232B03C:
	.word loc_0232B04C + 1	; 0232B03C
P1_IrqHandler_0232B040:
	mov r0,#0x0	; 0232B040
	ldr r3,[pool_0232B048]	; 0232B042
	bx r3	; 0232B044
	.byte 0xC0, 0x46	; 0232B048
pool_0232B048:
loc_0232B048:
	.word loc_0232B04C + 1	; 0232B048
loc_0232B04C:
	push {r4,r5,lr}	; 0232B04C
	sub sp,#0x4	; 0232B04E
	mov r5,#0x1	; 0232B050
	lsl r2,r0,#0x1	; 0232B052
	ldr r1,[pool_0232B094]	; 0232B054
	ldrh r1,[r1,r2]	; 0232B056
	lsl r5,r1	; 0232B058
	mov r1,#0xc	; 0232B05A
	add r4,r0,#0x0	; 0232B05C
	mul r4,r1	; 0232B05E
	ldr r2,[pool_0232B098]	; 0232B060
	ldr r1,[r2,r4]	; 0232B062
	mov r0,#0x0	; 0232B064
	str r0,[r2,r4]	; 0232B066
	cmp r1,#0x0	; 0232B068
	beq loc_0232B072	; 0232B06A
	ldr r0,[pool_0232B09C]	; 0232B06C
	ldr r0,[r0,r4]	; 0232B06E
	blx r1	; 0232B070
loc_0232B072:
	ldr r1,[pool_0232B0A0]	; 0232B072
	ldr r0,[pool_0232B0A4]	; 0232B074
	add r0,r1,r0	; 0232B076
	ldr r1,[r0,#0x0]	; 0232B078
	orr r1,r5	; 0232B07A
	str r1,[r0,#0x0]	; 0232B07C
	ldr r0,[pool_0232B0A8]	; 0232B07E
	ldr r0,[r0,r4]	; 0232B080
	cmp r0,#0x0	; 0232B082
	bne loc_0232B08C	; 0232B084
	add r0,r5,#0x0	; 0232B086
	bl loc_0232B0D8	; 0232B088
loc_0232B08C:
	add sp,#0x4	; 0232B08C
	pop {r4,r5}	; 0232B08E
	pop {r3}	; 0232B090
	bx r3	; 0232B092
pool_0232B094:
loc_0232B094:
	.word P1_Data_0233075C	; 0232B094
pool_0232B098:
loc_0232B098:
	.word P1_BssStart + 0x26310	; 0232B098
pool_0232B09C:
loc_0232B09C:
	.word P1_BssStart + 0x26318	; 0232B09C
pool_0232B0A0:
loc_0232B0A0:
	.word P1_DtcmRuntimeStart	; 0232B0A0
pool_0232B0A4:
loc_0232B0A4:
	.word 0x00003FF8	; 0232B0A4
pool_0232B0A8:
loc_0232B0A8:
	.word P1_BssStart + 0x26314	; 0232B0A8
P1_IrqHandler_0232B0AC:
	bx lr	; 0232B0AC
	.byte 0x00, 0x00	; 0232B0B0

; ===== function loc_0232B0B0 =====
loc_0232B0B0:
	push {r4}	; 0232B0B0
	sub sp,#0x4	; 0232B0B2
	ldr r4,[pool_0232B0D0]	; 0232B0B4
	ldrh r3,[r4,#0x0]	; 0232B0B6
	mov r1,#0x0	; 0232B0B8
	strh r1,[r4,#0x0]	; 0232B0BA
	ldr r2,[pool_0232B0D4]	; 0232B0BC
	ldr r1,[r2,#0x0]	; 0232B0BE
	str r0,[r2,#0x0]	; 0232B0C0
	ldrh r0,[r4,#0x0]	; 0232B0C2
	strh r3,[r4,#0x0]	; 0232B0C4
	add r0,r1,#0x0	; 0232B0C6
	add sp,#0x4	; 0232B0C8
	pop {r4}	; 0232B0CA
	bx lr	; 0232B0CC
	.byte 0xC0, 0x46	; 0232B0D0
pool_0232B0D0:
loc_0232B0D0:
	.word REG_IME	; 0232B0D0
pool_0232B0D4:
loc_0232B0D4:
	.word REG_IF	; 0232B0D4

; ===== function loc_0232B0D8 =====
loc_0232B0D8:
	push {r4,r5}	; 0232B0D8
	ldr r5,[pool_0232B0F8]	; 0232B0DA
	ldrh r4,[r5,#0x0]	; 0232B0DC
	mov r1,#0x0	; 0232B0DE
	strh r1,[r5,#0x0]	; 0232B0E0
	ldr r3,[pool_0232B0FC]	; 0232B0E2
	ldr r2,[r3,#0x0]	; 0232B0E4
	add r1,r2,#0x0	; 0232B0E6
	bic r1,r0	; 0232B0E8
	str r1,[r3,#0x0]	; 0232B0EA
	ldrh r0,[r5,#0x0]	; 0232B0EC
	strh r4,[r5,#0x0]	; 0232B0EE
	add r0,r2,#0x0	; 0232B0F0
	pop {r4,r5}	; 0232B0F2
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
	push {r4,r5}	; 0232B100
	ldr r5,[pool_0232B120]	; 0232B102
	ldrh r4,[r5,#0x0]	; 0232B104
	mov r1,#0x0	; 0232B106
	strh r1,[r5,#0x0]	; 0232B108
	ldr r3,[pool_0232B124]	; 0232B10A
	ldr r2,[r3,#0x0]	; 0232B10C
	add r1,r2,#0x0	; 0232B10E
	orr r1,r0	; 0232B110
	str r1,[r3,#0x0]	; 0232B112
	ldrh r0,[r5,#0x0]	; 0232B114
	strh r4,[r5,#0x0]	; 0232B116
	add r0,r2,#0x0	; 0232B118
	pop {r4,r5}	; 0232B11A
	bx lr	; 0232B11C
	.byte 0xC0, 0x46	; 0232B120
pool_0232B120:
loc_0232B120:
	.word REG_IME	; 0232B120
pool_0232B124:
loc_0232B124:
	.word REG_IE	; 0232B124

; ===== function loc_0232B128 =====
loc_0232B128:
	push {r4}	; 0232B128
	sub sp,#0x4	; 0232B12A
	ldr r4,[pool_0232B148]	; 0232B12C
	ldrh r3,[r4,#0x0]	; 0232B12E
	mov r1,#0x0	; 0232B130
	strh r1,[r4,#0x0]	; 0232B132
	ldr r2,[pool_0232B14C]	; 0232B134
	ldr r1,[r2,#0x0]	; 0232B136
	str r0,[r2,#0x0]	; 0232B138
	ldrh r0,[r4,#0x0]	; 0232B13A
	strh r3,[r4,#0x0]	; 0232B13C
	add r0,r1,#0x0	; 0232B13E
	add sp,#0x4	; 0232B140
	pop {r4}	; 0232B142
	bx lr	; 0232B144
	.byte 0xC0, 0x46	; 0232B148
pool_0232B148:
loc_0232B148:
	.word REG_IME	; 0232B148
pool_0232B14C:
loc_0232B14C:
	.word REG_IE	; 0232B14C

; ===== function loc_0232B150 =====
loc_0232B150:
	push {r4,lr}	; 0232B150
	mov r3,#0xc	; 0232B152
	add r4,r0,#0x0	; 0232B154
	mul r4,r3	; 0232B156
	ldr r3,[pool_0232B178]	; 0232B158
	str r1,[r3,r4]	; 0232B15A
	ldr r1,[pool_0232B17C]	; 0232B15C
	str r2,[r1,r4]	; 0232B15E
	mov r1,#0x1	; 0232B160
	add r0,r0,#0x3	; 0232B162
	lsl r1,r0	; 0232B164
	add r0,r1,#0x0	; 0232B166
	bl loc_0232B100	; 0232B168
	mov r1,#0x1	; 0232B16C
	ldr r0,[pool_0232B180]	; 0232B16E
	str r1,[r0,r4]	; 0232B170
	pop {r4}	; 0232B172
	pop {r3}	; 0232B174
	bx r3	; 0232B176
pool_0232B178:
loc_0232B178:
	.word P1_BssStart + 0x26340	; 0232B178
pool_0232B17C:
loc_0232B17C:
	.word P1_BssStart + 0x26348	; 0232B17C
pool_0232B180:
loc_0232B180:
	.word P1_BssStart + 0x26344	; 0232B180

; ===== function loc_0232B184 =====
loc_0232B184:
; 按 r0 的 IRQ 位掩码安装 r1 回调；DMA/定时器等使用专用回调槽。
; Installs the r1 handler for IRQ bits in r0; DMA/timers use dedicated callback slots.
.func P1_SetIrqHandlers
	push {r4,r5,r6,r7}	; 0232B184
	mov r6,#0x0	; 0232B186
	ldr r5,[pool_0232B1E0]	; 0232B188
	add r4,r6,#0x0	; 0232B18A
	add r2,r6,#0x0	; 0232B18C
loc_0232B18E:
	add r7,r0,#0x0	; 0232B18E
	mov r3,#0x1	; 0232B190
	and r7,r3	; 0232B192
	cmp r7,#0x0	; 0232B194
	beq loc_0232B1D2	; 0232B196
	add r7,r4,#0x0	; 0232B198
	cmp r6,#0x8	; 0232B19A
	blt loc_0232B1B0	; 0232B19C
	cmp r6,#0xb	; 0232B19E
	bgt loc_0232B1B0	; 0232B1A0
	add r3,r6,#0x0	; 0232B1A2
	sub r3,#0x8	; 0232B1A4
	mov r7,#0xc	; 0232B1A6
	mul r3,r7	; 0232B1A8
	ldr r7,[pool_0232B1E4]	; 0232B1AA
	add r7,r7,r3	; 0232B1AC
	b loc_0232B1C6	; 0232B1AE
loc_0232B1B0:
	cmp r6,#0x3	; 0232B1B0
	blt loc_0232B1C4	; 0232B1B2
	cmp r6,#0x6	; 0232B1B4
	bgt loc_0232B1C4	; 0232B1B6
	add r3,r6,#0x1	; 0232B1B8
	mov r7,#0xc	; 0232B1BA
	mul r3,r7	; 0232B1BC
	ldr r7,[pool_0232B1E4]	; 0232B1BE
	add r7,r7,r3	; 0232B1C0
	b loc_0232B1C6	; 0232B1C2
loc_0232B1C4:
	str r1,[r5,#0x0]	; 0232B1C4
loc_0232B1C6:
	cmp r7,#0x0	; 0232B1C6
	beq loc_0232B1D2	; 0232B1C8
	str r1,[r7,#0x0]	; 0232B1CA
	str r2,[r7,#0x8]	; 0232B1CC
	mov r3,#0x1	; 0232B1CE
	str r3,[r7,#0x4]	; 0232B1D0
loc_0232B1D2:
	lsr r0,r0,#0x1	; 0232B1D2
	add r5,r5,#0x4	; 0232B1D4
	add r6,r6,#0x1	; 0232B1D6
	cmp r6,#0x16	; 0232B1D8
	blt loc_0232B18E	; 0232B1DA
	pop {r4,r5,r6,r7}	; 0232B1DC
	bx lr	; 0232B1DE
.endfunc
pool_0232B1E0:
loc_0232B1E0:
	.word P1_IrqHandlers	; 0232B1E0
pool_0232B1E4:
loc_0232B1E4:
	.word 0x02356AF0	; 0232B1E4

; ===== function loc_0232B1E8 =====
loc_0232B1E8:
	mov r1,#0x0	; 0232B1E8
	ldr r0,[pool_0232B1F0]	; 0232B1EA
	strh r1,[r0,#0x0]	; 0232B1EC
	bx lr	; 0232B1EE
pool_0232B1F0:
loc_0232B1F0:
	.word P1_DtcmRuntimeStart	; 0232B1F0

; ===== function loc_0232B1F4 =====
loc_0232B1F4:
	ldr r1,[pool_0232B1F8]	; 0232B1F4
	bx r1	; 0232B1F6
pool_0232B1F8:
loc_0232B1F8:
	.word loc_0232B340 + 1	; 0232B1F8

; ===== function loc_0232B1FC =====
loc_0232B1FC:
	ldr r1,[pool_0232B200]	; 0232B1FC
	bx r1	; 0232B1FE
pool_0232B200:
loc_0232B200:
	.word loc_0232B2DC + 1	; 0232B200
.arm

; ===== function loc_0232B204 =====
loc_0232B204:
	ldr r3,[pool_0232B254]	; 0232B204
	ldr r1,[r3,#0x0]	; 0232B208
	clz r2,r1	; 0232B20C
	cmp r2,#0x20	; 0232B210
	movne r0,#0x40	; 0232B214
	bne loc_0232B238	; 0232B218
	add r3,r3,#0x4	; 0232B21C
	ldr r1,[r3,#0x0]	; 0232B220
	clz r2,r1	; 0232B224
	cmp r2,#0x20	; 0232B228
	ldr r0,[pool_0232B258]	; 0232B22C
	bxeq lr	; 0232B230
	mov r0,#0x60	; 0232B234
loc_0232B238:
	add r0,r0,r2	; 0232B238
	mov r1,#0x80000000	; 0232B23C
	mov r1,r1, lsr r2	; 0232B240
	ldr r2,[r3,#0x0]	; 0232B244
	bic r2,r2,r1	; 0232B248
	str r2,[r3,#0x0]	; 0232B24C
	bx lr	; 0232B250
pool_0232B254:
loc_0232B254:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B254
pool_0232B258:
loc_0232B258:
	.word 0xFFFFFFFD	; 0232B258

; ===== function loc_0232B25C =====
loc_0232B25C:
	ldr r3,[pool_0232B288]	; 0232B25C
	cmp r0,#0x60	; 0232B260
	addpl r3,r3,#0x4	; 0232B264
	subpl r0,r0,#0x60	; 0232B268
	submi r0,r0,#0x40	; 0232B26C
	mov r1,#0x80000000	; 0232B270
	mov r1,r1, lsr r0	; 0232B274
	ldr r2,[r3,#0x0]	; 0232B278
	orr r2,r2,r1	; 0232B27C
	str r2,[r3,#0x0]	; 0232B280
	bx lr	; 0232B284
pool_0232B288:
loc_0232B288:
	.word 0x027FFFB0	; 0232B288
.thumb

; ===== function loc_0232B28C =====
loc_0232B28C:
	ldr r0,[pool_0232B294]	; 0232B28C
	ldr r3,[pool_0232B298]	; 0232B28E
	bx r3	; 0232B290
	.byte 0xC0, 0x46	; 0232B294
pool_0232B294:
loc_0232B294:
	.word 0x00001000	; 0232B294
pool_0232B298:
loc_0232B298:
	.word P1_Arm9BusyWaitByLoop4	; 0232B298

; ===== function loc_0232B29C =====
loc_0232B29C:
	ldrh r0,[r0,#0x4]	; 0232B29C
	bx lr	; 0232B29E
	ldr r1,[pool_0232B2AC]	; 0232B2A0
	ldrh r2,[r1,#0x0]	; 0232B2A2
	ldr r0,[pool_0232B2B0]	; 0232B2A4
	orr r2,r0	; 0232B2A6
	strh r2,[r1,#0x0]	; 0232B2A8
	bx lr	; 0232B2AA
pool_0232B2AC:
loc_0232B2AC:
	.word REG_EXMEMCNT_ARM9	; 0232B2AC
pool_0232B2B0:
loc_0232B2B0:
	.word 0x00000800	; 0232B2B0
	ldr r1,[pool_0232B2C0]	; 0232B2B4
	ldrh r2,[r1,#0x0]	; 0232B2B6
	ldr r0,[pool_0232B2C4]	; 0232B2B8
	and r2,r0	; 0232B2BA
	strh r2,[r1,#0x0]	; 0232B2BC
	bx lr	; 0232B2BE
pool_0232B2C0:
loc_0232B2C0:
	.word REG_EXMEMCNT_ARM9	; 0232B2C0
pool_0232B2C4:
loc_0232B2C4:
	.word 0xFFFFF7FF	; 0232B2C4

; ===== function loc_0232B2C8 =====
loc_0232B2C8:
	ldr r1,[pool_0232B2D0]	; 0232B2C8
	ldr r2,[pool_0232B2D4]	; 0232B2CA
	ldr r3,[pool_0232B2D8]	; 0232B2CC
	bx r3	; 0232B2CE
pool_0232B2D0:
loc_0232B2D0:
	.word 0x027FFFE0	; 0232B2D0
pool_0232B2D4:
loc_0232B2D4:
	.word 0x0232B2B5	; 0232B2D4
pool_0232B2D8:
loc_0232B2D8:
	.word loc_0232B378 + 1	; 0232B2D8

; ===== function loc_0232B2DC =====
loc_0232B2DC:
	ldr r1,[pool_0232B2E4]	; 0232B2DC
	ldr r2,[pool_0232B2E8]	; 0232B2DE
	ldr r3,[pool_0232B2EC]	; 0232B2E0
	bx r3	; 0232B2E2
pool_0232B2E4:
loc_0232B2E4:
	.word 0x027FFFE0	; 0232B2E4
pool_0232B2E8:
loc_0232B2E8:
	.word 0x0232B2A1	; 0232B2E8
pool_0232B2EC:
loc_0232B2EC:
	.word loc_0232B3E8 + 1	; 0232B2EC

; ===== function loc_0232B2F0 =====
loc_0232B2F0:
	ldr r1,[pool_0232B2F8]	; 0232B2F0
	ldr r2,[pool_0232B2FC]	; 0232B2F2
	ldr r3,[pool_0232B300]	; 0232B2F4
	bx r3	; 0232B2F6
pool_0232B2F8:
loc_0232B2F8:
	.word 0x027FFFE0	; 0232B2F8
pool_0232B2FC:
loc_0232B2FC:
	.word 0x0232B2B5	; 0232B2FC
pool_0232B300:
loc_0232B300:
	.word loc_0232B450 + 1	; 0232B300
	ldr r1,[pool_0232B310]	; 0232B304
	ldrh r2,[r1,#0x0]	; 0232B306
	mov r0,#0x80	; 0232B308
	orr r2,r0	; 0232B30A
	strh r2,[r1,#0x0]	; 0232B30C
	bx lr	; 0232B30E
pool_0232B310:
loc_0232B310:
	.word REG_EXMEMCNT_ARM9	; 0232B310
	ldr r1,[pool_0232B320]	; 0232B314
	ldrh r2,[r1,#0x0]	; 0232B316
	mov r0,#0x80	; 0232B318
	bic r2,r0	; 0232B31A
	strh r2,[r1,#0x0]	; 0232B31C
	bx lr	; 0232B31E
pool_0232B320:
loc_0232B320:
	.word REG_EXMEMCNT_ARM9	; 0232B320

; ===== function loc_0232B324 =====
loc_0232B324:
	push {lr}	; 0232B324
	sub sp,#0x4	; 0232B326
	ldr r1,[pool_0232B338]	; 0232B328
	ldr r2,[pool_0232B33C]	; 0232B32A
	mov r3,#0x1	; 0232B32C
	bl loc_0232B388	; 0232B32E
	add sp,#0x4	; 0232B332
	pop {r3}	; 0232B334
	bx r3	; 0232B336
pool_0232B338:
loc_0232B338:
	.word 0x027FFFE8	; 0232B338
pool_0232B33C:
loc_0232B33C:
	.word 0x0232B315	; 0232B33C

; ===== function loc_0232B340 =====
loc_0232B340:
	push {lr}	; 0232B340
	sub sp,#0x4	; 0232B342
	ldr r1,[pool_0232B354]	; 0232B344
	ldr r2,[pool_0232B358]	; 0232B346
	mov r3,#0x1	; 0232B348
	bl loc_0232B3F8	; 0232B34A
	add sp,#0x4	; 0232B34E
	pop {r3}	; 0232B350
	bx r3	; 0232B352
pool_0232B354:
loc_0232B354:
	.word 0x027FFFE8	; 0232B354
pool_0232B358:
loc_0232B358:
	.word 0x0232B305	; 0232B358

; ===== function loc_0232B35C =====
loc_0232B35C:
	push {lr}	; 0232B35C
	sub sp,#0x4	; 0232B35E
	ldr r1,[pool_0232B370]	; 0232B360
	ldr r2,[pool_0232B374]	; 0232B362
	mov r3,#0x1	; 0232B364
	bl loc_0232B460	; 0232B366
	add sp,#0x4	; 0232B36A
	pop {r3}	; 0232B36C
	bx r3	; 0232B36E
pool_0232B370:
loc_0232B370:
	.word 0x027FFFE8	; 0232B370
pool_0232B374:
loc_0232B374:
	.word 0x0232B315	; 0232B374
loc_0232B378:
	push {lr}	; 0232B378
	sub sp,#0x4	; 0232B37A
	mov r3,#0x0	; 0232B37C
	bl loc_0232B388	; 0232B37E
	add sp,#0x4	; 0232B382
	pop {r3}	; 0232B384
	bx r3	; 0232B386

; ===== function loc_0232B388 =====
loc_0232B388:
	push {r4,r5,r6,r7,lr}	; 0232B388
	sub sp,#0xc	; 0232B38A
	add r5,r0,#0x0	; 0232B38C
	add r6,r1,#0x0	; 0232B38E
	add r4,r2,#0x0	; 0232B390
	add r7,r3,#0x0	; 0232B392
	cmp r7,#0x0	; 0232B394
	beq loc_0232B3A0	; 0232B396
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B398
	str r0,[sp,#0x0]	; 0232B39C
	b loc_0232B3A6	; 0232B39E
loc_0232B3A0:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B3A0
	str r0,[sp,#0x0]	; 0232B3A4
loc_0232B3A6:
	add r0,r5,#0x0	; 0232B3A6
	add r1,r6,#0x0	; 0232B3A8
	blx loc_0232DEC4	; 0232B3AA
	str r0,[sp,#0x4]	; 0232B3AE
	cmp r0,#0x0	; 0232B3B0
	bne loc_0232B3BC	; 0232B3B2
	cmp r4,#0x0	; 0232B3B4
	beq loc_0232B3BA	; 0232B3B6
	blx r4	; 0232B3B8
loc_0232B3BA:
	strh r5,[r6,#0x4]	; 0232B3BA
loc_0232B3BC:
	cmp r7,#0x0	; 0232B3BC
	beq loc_0232B3C8	; 0232B3BE
	ldr r0,[sp,#0x0]	; 0232B3C0
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B3C2
	b loc_0232B3CE	; 0232B3C6
loc_0232B3C8:
	ldr r0,[sp,#0x0]	; 0232B3C8
	blx P1_Arm9RestoreIrqMask	; 0232B3CA
loc_0232B3CE:
	ldr r0,[sp,#0x4]	; 0232B3CE
	add sp,#0xc	; 0232B3D0
	pop {r4,r5,r6,r7}	; 0232B3D2
	pop {r3}	; 0232B3D4
	bx r3	; 0232B3D6

; ===== function loc_0232B3D8 =====
loc_0232B3D8:
	push {lr}	; 0232B3D8
	sub sp,#0x4	; 0232B3DA
	mov r3,#0x0	; 0232B3DC
	bl loc_0232B3F8	; 0232B3DE
	add sp,#0x4	; 0232B3E2
	pop {r3}	; 0232B3E4
	bx r3	; 0232B3E6

; ===== function loc_0232B3E8 =====
loc_0232B3E8:
	push {lr}	; 0232B3E8
	sub sp,#0x4	; 0232B3EA
	mov r3,#0x0	; 0232B3EC
	bl loc_0232B3F8	; 0232B3EE
	add sp,#0x4	; 0232B3F2
	pop {r3}	; 0232B3F4
	bx r3	; 0232B3F6

; ===== function loc_0232B3F8 =====
loc_0232B3F8:
	push {r4,r5,r6,r7,lr}	; 0232B3F8
	sub sp,#0x4	; 0232B3FA
	add r5,r1,#0x0	; 0232B3FC
	add r4,r2,#0x0	; 0232B3FE
	add r6,r3,#0x0	; 0232B400
	ldrh r1,[r5,#0x4]	; 0232B402
	cmp r0,r1	; 0232B404
	beq loc_0232B414	; 0232B406
	mov r0,#0x1	; 0232B408
	mvn r0,r0	; 0232B40A
	add sp,#0x4	; 0232B40C
	pop {r4,r5,r6,r7}	; 0232B40E
	pop {r3}	; 0232B410
	bx r3	; 0232B412
loc_0232B414:
	cmp r6,#0x0	; 0232B414
	beq loc_0232B420	; 0232B416
	blx P1_Arm9DisableIrqFiqReturnPriorMasks	; 0232B418
	add r7,r0,#0x0	; 0232B41C
	b loc_0232B426	; 0232B41E
loc_0232B420:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B420
	add r7,r0,#0x0	; 0232B424
loc_0232B426:
	mov r0,#0x0	; 0232B426
	strh r0,[r5,#0x4]	; 0232B428
	cmp r4,#0x0	; 0232B42A
	beq loc_0232B430	; 0232B42C
	blx r4	; 0232B42E
loc_0232B430:
	mov r0,#0x0	; 0232B430
	str r0,[r5,#0x0]	; 0232B432
	cmp r6,#0x0	; 0232B434
	beq loc_0232B440	; 0232B436
	add r0,r7,#0x0	; 0232B438
	blx P1_Arm9RestoreIrqFiqMasks	; 0232B43A
	b loc_0232B446	; 0232B43E
loc_0232B440:
	add r0,r7,#0x0	; 0232B440
	blx P1_Arm9RestoreIrqMask	; 0232B442
loc_0232B446:
	mov r0,#0x0	; 0232B446
	add sp,#0x4	; 0232B448
	pop {r4,r5,r6,r7}	; 0232B44A
	pop {r3}	; 0232B44C
	bx r3	; 0232B44E

; ===== function loc_0232B450 =====
loc_0232B450:
	push {lr}	; 0232B450
	sub sp,#0x4	; 0232B452
	mov r3,#0x0	; 0232B454
	bl loc_0232B460	; 0232B456
	add sp,#0x4	; 0232B45A
	pop {r3}	; 0232B45C
	bx r3	; 0232B45E

; ===== function loc_0232B460 =====
loc_0232B460:
	push {r4,r5,r6,r7,lr}	; 0232B460
	sub sp,#0x4	; 0232B462
	add r5,r0,#0x0	; 0232B464
	add r4,r1,#0x0	; 0232B466
	add r6,r2,#0x0	; 0232B468
	add r7,r3,#0x0	; 0232B46A
	bl loc_0232B388	; 0232B46C
	cmp r0,#0x0	; 0232B470
	ble loc_0232B488	; 0232B472
loc_0232B474:
	bl loc_0232B28C	; 0232B474
	add r0,r5,#0x0	; 0232B478
	add r1,r4,#0x0	; 0232B47A
	add r2,r6,#0x0	; 0232B47C
	add r3,r7,#0x0	; 0232B47E
	bl loc_0232B388	; 0232B480
	cmp r0,#0x0	; 0232B484
	bgt loc_0232B474	; 0232B486
loc_0232B488:
	add sp,#0x4	; 0232B488
	pop {r4,r5,r6,r7}	; 0232B48A
	pop {r3}	; 0232B48C
	bx r3	; 0232B48E

; ===== function loc_0232B490 =====
loc_0232B490:
	push {r4,lr}	; 0232B490
	sub sp,#0x8	; 0232B492
	ldr r0,[pool_0232B508]	; 0232B494
	ldr r1,[r0,#0x0]	; 0232B496
	cmp r1,#0x0	; 0232B498
	bne loc_0232B4FE	; 0232B49A
	mov r1,#0x1	; 0232B49C
	str r1,[r0,#0x0]	; 0232B49E
	mov r2,#0x0	; 0232B4A0
	ldr r1,[pool_0232B50C]	; 0232B4A2
	str r2,[r1,#0x0]	; 0232B4A4
	mov r0,#0x7e	; 0232B4A6
	bl loc_0232B450	; 0232B4A8
	ldr r4,[pool_0232B50C]	; 0232B4AC
	ldrh r0,[r4,#0x6]	; 0232B4AE
	cmp r0,#0x0	; 0232B4B0
	beq loc_0232B4BE	; 0232B4B2
loc_0232B4B4:
	bl loc_0232B28C	; 0232B4B4
	ldrh r0,[r4,#0x6]	; 0232B4B8
	cmp r0,#0x0	; 0232B4BA
	bne loc_0232B4B4	; 0232B4BC
loc_0232B4BE:
	mov r0,#0x0	; 0232B4BE
	mvn r2,r0	; 0232B4C0
	ldr r1,[pool_0232B510]	; 0232B4C2
	str r2,[r1,#0x0]	; 0232B4C4
	ldr r2,[pool_0232B514]	; 0232B4C6
	ldr r1,[pool_0232B518]	; 0232B4C8
	str r2,[r1,#0x0]	; 0232B4CA
	str r0,[sp,#0x0]	; 0232B4CC
	ldr r0,[sp,#0x0]	; 0232B4CE
	ldr r1,[pool_0232B51C]	; 0232B4D0
	mov r2,#0x28	; 0232B4D2
	blx loc_0232DDE0	; 0232B4D4
	ldr r2,[pool_0232B520]	; 0232B4D8
	ldrh r1,[r2,#0x0]	; 0232B4DA
	ldr r0,[pool_0232B524]	; 0232B4DC
	orr r1,r0	; 0232B4DE
	strh r1,[r2,#0x0]	; 0232B4E0
	ldrh r1,[r2,#0x0]	; 0232B4E2
	mov r0,#0x80	; 0232B4E4
	orr r1,r0	; 0232B4E6
	strh r1,[r2,#0x0]	; 0232B4E8
	mov r0,#0x7e	; 0232B4EA
	ldr r1,[pool_0232B50C]	; 0232B4EC
	mov r2,#0x0	; 0232B4EE
	bl loc_0232B3E8	; 0232B4F0
	mov r0,#0x7f	; 0232B4F4
	ldr r1,[pool_0232B50C]	; 0232B4F6
	mov r2,#0x0	; 0232B4F8
	bl loc_0232B450	; 0232B4FA
loc_0232B4FE:
	add sp,#0x8	; 0232B4FE
	pop {r4}	; 0232B500
	pop {r3}	; 0232B502
	bx r3	; 0232B504
	.byte 0xC0, 0x46	; 0232B508
pool_0232B508:
loc_0232B508:
	.word P1_BssStart + 0x26370	; 0232B508
pool_0232B50C:
loc_0232B50C:
	.word FirmwareSystemWorkAddress + SystemWorkInitLockOffset	; 0232B50C
pool_0232B510:
loc_0232B510:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset	; 0232B510
pool_0232B514:
loc_0232B514:
	.word 0xFFFF0000	; 0232B514
pool_0232B518:
loc_0232B518:
	.word FirmwareSystemWorkAddress + SystemWorkArm9LockIdsOffset + 0x4	; 0232B518
pool_0232B51C:
loc_0232B51C:
	.word 0x027FFFC0	; 0232B51C
pool_0232B520:
loc_0232B520:
	.word REG_EXMEMCNT_ARM9	; 0232B520
pool_0232B524:
loc_0232B524:
	.word 0x00000800	; 0232B524

; ===== function loc_0232B528 =====
P1_ThreadEntry_0232B528:
	push {lr}	; 0232B528
	sub sp,#0x4	; 0232B52A
	blx P1_Arm9EnableIrqReturnPriorMask	; 0232B52C
loc_0232B530:
	blx P1_Arm9WaitForInterrupt	; 0232B530
	b loc_0232B530	; 0232B534
	.byte 0x00, 0x00	; 0232B538

; ===== function loc_0232B538 =====
loc_0232B538:
	push {r4,r5,lr}	; 0232B538
	sub sp,#0x4	; 0232B53A
	add r5,r0,#0x0	; 0232B53C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B53E
	ldr r1,[pool_0232B558]	; 0232B542
	ldr r4,[r1,#0x10]	; 0232B544
	str r5,[r1,#0x10]	; 0232B546
	blx P1_Arm9RestoreIrqMask	; 0232B548
	add r0,r4,#0x0	; 0232B54C
	add sp,#0x4	; 0232B54E
	pop {r4,r5}	; 0232B550
	pop {r3}	; 0232B552
	bx r3	; 0232B554
	.byte 0xC0, 0x46	; 0232B558
pool_0232B558:
loc_0232B558:
	.word P1_BssStart + 0x26380	; 0232B558

; ===== function loc_0232B55C =====
loc_0232B55C:
	push {r4,r5,r6,lr}	; 0232B55C
	ldr r6,[pool_0232B5C0]	; 0232B55E
	ldrh r0,[r6,#0x4]	; 0232B560
	cmp r0,#0x0	; 0232B562
	bne loc_0232B56E	; 0232B564
	blx P1_Arm9GetProcessorMode	; 0232B566
	cmp r0,#0x12	; 0232B56A
	bne loc_0232B578	; 0232B56C
loc_0232B56E:
	mov r0,#0x1	; 0232B56E
	strh r0,[r6,#0x0]	; 0232B570
	pop {r4,r5,r6}	; 0232B572
	pop {r3}	; 0232B574
	bx r3	; 0232B576
loc_0232B578:
	ldr r0,[pool_0232B5C4]	; 0232B578
	ldr r0,[r0,#0x0]	; 0232B57A
	ldr r5,[r0,#0x0]	; 0232B57C
	bl loc_0232B5CC	; 0232B57E
	add r4,r0,#0x0	; 0232B582
	cmp r5,r4	; 0232B584
	beq loc_0232B5BA	; 0232B586
	cmp r4,#0x0	; 0232B588
	beq loc_0232B5BA	; 0232B58A
	add r0,r5,#0x0	; 0232B58C
	blx P1_SaveThreadContext	; 0232B58E
	cmp r0,#0x0	; 0232B592
	bne loc_0232B5BA	; 0232B594
	ldr r0,[pool_0232B5C8]	; 0232B596
	ldr r2,[r0,#0x0]	; 0232B598
	cmp r2,#0x0	; 0232B59A
	beq loc_0232B5A4	; 0232B59C
	add r0,r5,#0x0	; 0232B59E
	add r1,r4,#0x0	; 0232B5A0
	blx r2	; 0232B5A2
loc_0232B5A4:
	ldr r2,[r6,#0x10]	; 0232B5A4
	cmp r2,#0x0	; 0232B5A6
	beq loc_0232B5B0	; 0232B5A8
	add r0,r5,#0x0	; 0232B5AA
	add r1,r4,#0x0	; 0232B5AC
	blx r2	; 0232B5AE
loc_0232B5B0:
	ldr r0,[pool_0232B5C0]	; 0232B5B0
	str r4,[r0,#0x8]	; 0232B5B2
	add r0,r4,#0x0	; 0232B5B4
	blx P1_LoadThreadContext	; 0232B5B6
loc_0232B5BA:
	pop {r4,r5,r6}	; 0232B5BA
	pop {r3}	; 0232B5BC
	bx r3	; 0232B5BE
pool_0232B5C0:
loc_0232B5C0:
	.word P1_BssStart + 0x26380	; 0232B5C0
pool_0232B5C4:
loc_0232B5C4:
	.word P1_BssStart + 0x26378	; 0232B5C4
pool_0232B5C8:
loc_0232B5C8:
	.word P1_BssStart + 0x26374	; 0232B5C8

; ===== function loc_0232B5CC =====
loc_0232B5CC:
	ldr r0,[pool_0232B5E0]	; 0232B5CC
	ldr r0,[r0,#0xc]	; 0232B5CE
	b loc_0232B5D4	; 0232B5D0
loc_0232B5D2:
	ldr r0,[r0,#0x68]	; 0232B5D2
loc_0232B5D4:
	cmp r0,#0x0	; 0232B5D4
	beq loc_0232B5DE	; 0232B5D6
	ldr r1,[r0,#0x64]	; 0232B5D8
	cmp r1,#0x1	; 0232B5DA
	bne loc_0232B5D2	; 0232B5DC
loc_0232B5DE:
	bx lr	; 0232B5DE
pool_0232B5E0:
loc_0232B5E0:
	.word P1_BssStart + 0x26380	; 0232B5E0

; ===== function loc_0232B5E4 =====
loc_0232B5E4:
	push {r4,r5,r6,lr}	; 0232B5E4
	add r5,r0,#0x0	; 0232B5E6
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B5E8
	add r4,r0,#0x0	; 0232B5EC
	ldrh r1,[r5,#0x0]	; 0232B5EE
	cmp r1,#0x0	; 0232B5F0
	beq loc_0232B61C	; 0232B5F2
	ldr r0,[pool_0232B628]	; 0232B5F4
	ldr r0,[r0,#0xc]	; 0232B5F6
	cmp r0,#0x0	; 0232B5F8
	beq loc_0232B614	; 0232B5FA
	mov r3,#0x1	; 0232B5FC
loc_0232B5FE:
	ldr r2,[r0,#0x6c]	; 0232B5FE
	add r6,r3,#0x0	; 0232B600
	lsl r6,r2	; 0232B602
	add r2,r1,#0x0	; 0232B604
	and r2,r6	; 0232B606
	cmp r2,#0x0	; 0232B608
	beq loc_0232B60E	; 0232B60A
	str r3,[r0,#0x64]	; 0232B60C
loc_0232B60E:
	ldr r0,[r0,#0x68]	; 0232B60E
	cmp r0,#0x0	; 0232B610
	bne loc_0232B5FE	; 0232B612
loc_0232B614:
	mov r0,#0x0	; 0232B614
	strh r0,[r5,#0x0]	; 0232B616
	bl loc_0232B55C	; 0232B618
loc_0232B61C:
	add r0,r4,#0x0	; 0232B61C
	blx P1_Arm9RestoreIrqMask	; 0232B61E
	pop {r4,r5,r6}	; 0232B622
	pop {r3}	; 0232B624
	bx r3	; 0232B626
pool_0232B628:
loc_0232B628:
	.word P1_BssStart + 0x26380	; 0232B628

; ===== function loc_0232B62C =====
loc_0232B62C:
	push {r4,r5,lr}	; 0232B62C
	sub sp,#0x4	; 0232B62E
	add r5,r0,#0x0	; 0232B630
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B632
	add r4,r0,#0x0	; 0232B636
	ldr r0,[pool_0232B668]	; 0232B638
	ldr r0,[r0,#0x0]	; 0232B63A
	ldr r1,[r0,#0x0]	; 0232B63C
	cmp r5,#0x0	; 0232B63E
	beq loc_0232B652	; 0232B640
	ldrh r0,[r5,#0x0]	; 0232B642
	mov r3,#0x1	; 0232B644
	ldr r2,[r1,#0x6c]	; 0232B646
	lsl r3,r2	; 0232B648
	lsl r2,r3,#0x10	; 0232B64A
	lsr r2,r2,#0x10	; 0232B64C
	orr r0,r2	; 0232B64E
	strh r0,[r5,#0x0]	; 0232B650
loc_0232B652:
	mov r0,#0x0	; 0232B652
	str r0,[r1,#0x64]	; 0232B654
	bl loc_0232B55C	; 0232B656
	add r0,r4,#0x0	; 0232B65A
	blx P1_Arm9RestoreIrqMask	; 0232B65C
	add sp,#0x4	; 0232B660
	pop {r4,r5}	; 0232B662
	pop {r3}	; 0232B664
	bx r3	; 0232B666
pool_0232B668:
loc_0232B668:
	.word P1_BssStart + 0x26378	; 0232B668
; 线程初始 LR 指向此处；清除 ID 表项并将线程标记为终止态。
; Initial thread LR points here; clear its ID slot and mark the thread terminated.
.func P1_ExitThread
	push {r4,lr}	; 0232B66C
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B66E
	ldr r0,[pool_0232B6A4]	; 0232B672
	ldr r0,[r0,#0x0]	; 0232B674
	ldr r4,[r0,#0x0]	; 0232B676
	add r0,r4,#0x0	; 0232B678
	bl loc_0232BAEC	; 0232B67A
	add r0,r4,#0x0	; 0232B67E
	bl loc_0232B854	; 0232B680
	mov r2,#0x0	; 0232B684
	ldr r0,[r4,#0x6c]	; 0232B686
	lsl r1,r0,#0x2	; 0232B688
	ldr r0,[pool_0232B6A8]	; 0232B68A
	str r2,[r0,r1]	; 0232B68C
	mov r0,#0x2	; 0232B68E
	str r0,[r4,#0x64]	; 0232B690
	add r4,#0x90	; 0232B692
	add r0,r4,#0x0	; 0232B694
	bl loc_0232B5E4	; 0232B696
	bl loc_0232B55C	; 0232B69A
	pop {r4}	; 0232B69E
	pop {r3}	; 0232B6A0
	bx r3	; 0232B6A2
.endfunc
pool_0232B6A4:
loc_0232B6A4:
	.word P1_BssStart + 0x26378	; 0232B6A4
pool_0232B6A8:
loc_0232B6A8:
	.word P1_BssStart + 0x26394	; 0232B6A8

; ===== function loc_0232B6AC =====
loc_0232B6AC:
; r0=线程，r1=入口，r2=参数，r3=栈顶；栈参数为大小/优先级。
; r0=thread, r1=entry, r2=argument, r3=stack top; stack arguments: size/priority.
.func P1_CreateThread
	push {r4,r5,r6,r7,lr}	; 0232B6AC
	sub sp,#0xc	; 0232B6AE
	add r5,r0,#0x0	; 0232B6B0
	str r1,[sp,#0x0]	; 0232B6B2
	add r7,r2,#0x0	; 0232B6B4
	add r4,r3,#0x0	; 0232B6B6
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B6B8
	str r0,[sp,#0x4]	; 0232B6BC
	bl loc_0232B8B8	; 0232B6BE
	cmp r0,#0x0	; 0232B6C2
	bge loc_0232B6D4	; 0232B6C4
	ldr r0,[sp,#0x4]	; 0232B6C6
	blx P1_Arm9RestoreIrqMask	; 0232B6C8
	add sp,#0xc	; 0232B6CC
	pop {r4,r5,r6,r7}	; 0232B6CE
	pop {r3}	; 0232B6D0
	bx r3	; 0232B6D2
loc_0232B6D4:
	ldr r1,[sp,#0x24]	; 0232B6D4
	str r1,[r5,#0x70]	; 0232B6D6
	str r0,[r5,#0x6c]	; 0232B6D8
	mov r1,#0x0	; 0232B6DA
	str r1,[r5,#0x64]	; 0232B6DC
	lsl r1,r0,#0x2	; 0232B6DE
	ldr r0,[pool_0232B750]	; 0232B6E0
	str r5,[r0,r1]	; 0232B6E2
	add r0,r5,#0x0	; 0232B6E4
	bl loc_0232B880	; 0232B6E6
	add r0,r5,#0x0	; 0232B6EA
	add r0,#0x88	; 0232B6EC
	str r4,[r0,#0x0]	; 0232B6EE
	ldr r0,[sp,#0x20]	; 0232B6F0
	sub r6,r4,r0	; 0232B6F2
	add r0,r5,#0x0	; 0232B6F4
	add r0,#0x84	; 0232B6F6
	str r6,[r0,#0x0]	; 0232B6F8
	mov r1,#0x0	; 0232B6FA
	add r0,r5,#0x0	; 0232B6FC
	add r0,#0x8c	; 0232B6FE
	str r1,[r0,#0x0]	; 0232B700
	ldr r0,[pool_0232B754]	; 0232B702
	add r1,r5,#0x0	; 0232B704
	add r1,#0x88	; 0232B706
	ldr r1,[r1,#0x0]	; 0232B708
	sub r1,r1,#0x4	; 0232B70A
	str r0,[r1,#0x0]	; 0232B70C
	ldr r1,[pool_0232B758]	; 0232B70E
	add r0,r5,#0x0	; 0232B710
	add r0,#0x84	; 0232B712
	ldr r0,[r0,#0x0]	; 0232B714
	str r1,[r0,#0x0]	; 0232B716
	add r0,r5,#0x0	; 0232B718
	ldr r1,[sp,#0x0]	; 0232B71A
	sub r2,r4,#0x4	; 0232B71C
	blx P1_InitThreadContext	; 0232B71E
	str r7,[r5,#ThreadContextR0Offset]	; 0232B722
	ldr r0,[pool_0232B75C]	; 0232B724
	str r0,[r5,#ThreadContextLrOffset]	; 0232B726
	mov r0,#0x0	; 0232B728
	str r0,[sp,#0x8]	; 0232B72A
	ldr r0,[sp,#0x8]	; 0232B72C
	add r1,r6,#0x4	; 0232B72E
	ldr r2,[sp,#0x20]	; 0232B730
	sub r2,#0x8	; 0232B732
	blx loc_0232DDE0	; 0232B734
	mov r0,#0x0	; 0232B738
	str r0,[r5,#0x78]	; 0232B73A
	str r0,[r5,#0x7c]	; 0232B73C
	add r5,#0x80	; 0232B73E
	str r0,[r5,#0x0]	; 0232B740
	ldr r0,[sp,#0x4]	; 0232B742
	blx P1_Arm9RestoreIrqMask	; 0232B744
	add sp,#0xc	; 0232B748
	pop {r4,r5,r6,r7}	; 0232B74A
	pop {r3}	; 0232B74C
	bx r3	; 0232B74E
.endfunc
pool_0232B750:
loc_0232B750:
	.word P1_BssStart + 0x26394	; 0232B750
pool_0232B754:
loc_0232B754:
	.word 0xFDDB597D	; 0232B754
pool_0232B758:
loc_0232B758:
	.word 0x7BF9DD5B	; 0232B758
pool_0232B75C:
loc_0232B75C:
	.word P1_ExitThread + 1	; 0232B75C

; ===== function loc_0232B760 =====
loc_0232B760:
	push {lr}	; 0232B760
	sub sp,#0xc	; 0232B762
	ldr r0,[pool_0232B810]	; 0232B764
	ldr r1,[r0,#0x0]	; 0232B766
	cmp r1,#0x0	; 0232B768
	bne loc_0232B808	; 0232B76A
	mov r1,#0x1	; 0232B76C
	str r1,[r0,#0x0]	; 0232B76E
	mov r1,#0x0	; 0232B770
	ldr r0,[pool_0232B814]	; 0232B772
	add r2,r1,#0x0	; 0232B774
loc_0232B776:
	str r2,[r0,#0x14]	; 0232B776
	add r0,r0,#0x4	; 0232B778
	add r1,r1,#0x1	; 0232B77A
	cmp r1,#0x10	; 0232B77C
	blt loc_0232B776	; 0232B77E
	ldr r1,[pool_0232B818]	; 0232B780
	ldr r0,[pool_0232B81C]	; 0232B782
	str r1,[r0,#0x0]	; 0232B784
	mov r0,#0x10	; 0232B786
	ldr r1,[pool_0232B820]	; 0232B788
	str r0,[r1,#0x70]	; 0232B78A
	str r2,[r1,#0x6c]	; 0232B78C
	mov r0,#0x1	; 0232B78E
	str r0,[r1,#0x64]	; 0232B790
	str r2,[r1,#0x68]	; 0232B792
	str r2,[r1,#0x74]	; 0232B794
	ldr r0,[pool_0232B814]	; 0232B796
	str r1,[r0,#0x14]	; 0232B798
	str r1,[r0,#0xc]	; 0232B79A
	str r1,[r0,#0x8]	; 0232B79C
	ldr r2,[pool_0232B824]	; 0232B79E
	cmp r2,#0x0	; 0232B7A0
	bne loc_0232B7AA	; 0232B7A2
	ldr r0,[pool_0232B828]	; 0232B7A4
	sub r3,r0,r2	; 0232B7A6
	b loc_0232B7B6	; 0232B7A8
loc_0232B7AA:
	ldr r1,[pool_0232B82C]	; 0232B7AA
	ldr r0,[pool_0232B830]	; 0232B7AC
	add r1,r1,r0	; 0232B7AE
	ldr r0,[pool_0232B834]	; 0232B7B0
	sub r0,r1,r0	; 0232B7B2
	sub r3,r0,r2	; 0232B7B4
loc_0232B7B6:
	ldr r1,[pool_0232B82C]	; 0232B7B6
	ldr r0,[pool_0232B830]	; 0232B7B8
	add r1,r1,r0	; 0232B7BA
	ldr r0,[pool_0232B834]	; 0232B7BC
	sub r1,r1,r0	; 0232B7BE
	ldr r2,[pool_0232B838]	; 0232B7C0
	str r1,[r2,#0x8]	; 0232B7C2
	str r3,[r2,#0x4]	; 0232B7C4
	mov r0,#0x0	; 0232B7C6
	str r0,[r2,#0xc]	; 0232B7C8
	ldr r3,[pool_0232B83C]	; 0232B7CA
	sub r1,r1,#0x4	; 0232B7CC
	str r3,[r1,#0x0]	; 0232B7CE
	ldr r3,[pool_0232B840]	; 0232B7D0
	ldr r1,[r2,#0x4]	; 0232B7D2
	str r3,[r1,#0x0]	; 0232B7D4
	strh r0,[r2,#0x10]	; 0232B7D6
	mov r2,#0x10	; 0232B7D8
	ldr r1,[pool_0232B814]	; 0232B7DA
	strh r2,[r1,#0x2]	; 0232B7DC
	strh r0,[r1,#0x0]	; 0232B7DE
	strh r0,[r1,#0x4]	; 0232B7E0
	ldr r2,[pool_0232B844]	; 0232B7E2
	str r1,[r2,#0x0]	; 0232B7E4
	bl loc_0232B538	; 0232B7E6
	mov r0,#0xc8	; 0232B7EA
	str r0,[sp,#0x0]	; 0232B7EC
	mov r0,#0x1f	; 0232B7EE
	str r0,[sp,#0x4]	; 0232B7F0
	ldr r0,[pool_0232B848]	; 0232B7F2
	ldr r1,[pool_0232B84C]	; 0232B7F4
	mov r2,#0x0	; 0232B7F6
	ldr r3,[pool_0232B850]	; 0232B7F8
	bl P1_CreateThread	; 0232B7FA
	mov r1,#0x20	; 0232B7FE
	ldr r0,[pool_0232B848]	; 0232B800
	str r1,[r0,#0x70]	; 0232B802
	mov r1,#0x1	; 0232B804
	str r1,[r0,#0x64]	; 0232B806
loc_0232B808:
	add sp,#0xc	; 0232B808
	pop {r3}	; 0232B80A
	bx r3	; 0232B80C
	.byte 0xC0, 0x46	; 0232B810
pool_0232B810:
loc_0232B810:
	.word P1_BssStart + 0x2637C	; 0232B810
pool_0232B814:
loc_0232B814:
	.word P1_BssStart + 0x26380	; 0232B814
pool_0232B818:
loc_0232B818:
	.word 0x02356B68	; 0232B818
pool_0232B81C:
loc_0232B81C:
	.word P1_BssStart + 0x26378	; 0232B81C
pool_0232B820:
loc_0232B820:
	.word P1_BssStart + 0x26468	; 0232B820
pool_0232B824:
loc_0232B824:
	.word 0x00000000	; 0232B824
pool_0232B828:
loc_0232B828:
	.word P1_DtcmRuntimeEnd	; 0232B828
pool_0232B82C:
loc_0232B82C:
	.word P1_DtcmRuntimeStart	; 0232B82C
pool_0232B830:
loc_0232B830:
	.word 0x00003FC0	; 0232B830
pool_0232B834:
loc_0232B834:
	.word 0x00001000	; 0232B834
pool_0232B838:
loc_0232B838:
	.word P1_BssStart + 0x264E8	; 0232B838
pool_0232B83C:
loc_0232B83C:
	.word 0xFDDB597D	; 0232B83C
pool_0232B840:
loc_0232B840:
	.word 0x7BF9DD5B	; 0232B840
pool_0232B844:
loc_0232B844:
	.word FirmwareSystemWorkAddress + SystemWorkArm9ThreadInfoOffset	; 0232B844
pool_0232B848:
loc_0232B848:
	.word P1_BssStart + 0x263D4	; 0232B848
pool_0232B84C:
loc_0232B84C:
	.word P1_ThreadEntry_0232B528 + 1	; 0232B84C
pool_0232B850:
loc_0232B850:
	.word 0x02356DA4	; 0232B850

; ===== function loc_0232B854 =====
loc_0232B854:
	ldr r1,[pool_0232B87C]	; 0232B854
	ldr r2,[r1,#0xc]	; 0232B856
	mov r1,#0x0	; 0232B858
	b loc_0232B860	; 0232B85A
loc_0232B85C:
	add r1,r2,#0x0	; 0232B85C
	ldr r2,[r2,#0x68]	; 0232B85E
loc_0232B860:
	cmp r2,#0x0	; 0232B860
	beq loc_0232B868	; 0232B862
	cmp r2,r0	; 0232B864
	bne loc_0232B85C	; 0232B866
loc_0232B868:
	cmp r1,#0x0	; 0232B868
	bne loc_0232B874	; 0232B86A
	ldr r1,[r0,#0x68]	; 0232B86C
	ldr r0,[pool_0232B87C]	; 0232B86E
	str r1,[r0,#0xc]	; 0232B870
	bx lr	; 0232B872
loc_0232B874:
	ldr r0,[r0,#0x68]	; 0232B874
	str r0,[r1,#0x68]	; 0232B876
	bx lr	; 0232B878
	.byte 0xC0, 0x46	; 0232B87C
pool_0232B87C:
loc_0232B87C:
	.word P1_BssStart + 0x26380	; 0232B87C

; ===== function loc_0232B880 =====
loc_0232B880:
	push {r4,r5}	; 0232B880
	ldr r1,[pool_0232B8B4]	; 0232B882
	ldr r3,[r1,#0xc]	; 0232B884
	add r5,r3,#0x0	; 0232B886
	mov r4,#0x0	; 0232B888
	b loc_0232B890	; 0232B88A
loc_0232B88C:
	add r4,r5,#0x0	; 0232B88C
	ldr r5,[r5,#0x68]	; 0232B88E
loc_0232B890:
	cmp r5,#0x0	; 0232B890
	beq loc_0232B89C	; 0232B892
	ldr r2,[r5,#0x70]	; 0232B894
	ldr r1,[r0,#0x70]	; 0232B896
	cmp r2,r1	; 0232B898
	bcc loc_0232B88C	; 0232B89A
loc_0232B89C:
	cmp r4,#0x0	; 0232B89C
	bne loc_0232B8AA	; 0232B89E
	str r3,[r0,#0x68]	; 0232B8A0
	ldr r1,[pool_0232B8B4]	; 0232B8A2
	str r0,[r1,#0xc]	; 0232B8A4
	pop {r4,r5}	; 0232B8A6
	bx lr	; 0232B8A8
loc_0232B8AA:
	ldr r1,[r4,#0x68]	; 0232B8AA
	str r1,[r0,#0x68]	; 0232B8AC
	str r0,[r4,#0x68]	; 0232B8AE
	pop {r4,r5}	; 0232B8B0
	bx lr	; 0232B8B2
pool_0232B8B4:
loc_0232B8B4:
	.word P1_BssStart + 0x26380	; 0232B8B4

; ===== function loc_0232B8B8 =====
loc_0232B8B8:
	mov r0,#0x0	; 0232B8B8
	ldr r2,[pool_0232B8D0]	; 0232B8BA
loc_0232B8BC:
	ldr r1,[r2,#0x14]	; 0232B8BC
	cmp r1,#0x0	; 0232B8BE
	beq loc_0232B8CE	; 0232B8C0
	add r2,r2,#0x4	; 0232B8C2
	add r0,r0,#0x1	; 0232B8C4
	cmp r0,#0x10	; 0232B8C6
	blt loc_0232B8BC	; 0232B8C8
	mov r0,#0x0	; 0232B8CA
	mvn r0,r0	; 0232B8CC
loc_0232B8CE:
	bx lr	; 0232B8CE
pool_0232B8D0:
loc_0232B8D0:
	.word P1_BssStart + 0x26380	; 0232B8D0
.arm

; ===== function loc_0232B8D4 =====
loc_0232B8D4:
; r0=上下文，r1=入口，r2=栈顶；保存入口+4/状态，并留出 SVC 栈。
; r0=context, r1=entry, r2=stack top; save entry+4/state and reserve the SVC stack.
.func P1_InitThreadContext
	add r1,r1,#0x4	; 0232B8D4
	str r1,[r0,#ThreadContextPcPlus4Offset]	; 0232B8D8
	str r2,[r0,#ThreadContextSvcSpOffset]	; 0232B8DC
	sub r2,r2,#ThreadContextSvcStackBytes	; 0232B8E0
	str r2,[r0,#ThreadContextSpOffset]	; 0232B8E4
	ands r1,r1,#0x1	; 0232B8E8
	movne r1,#0x3f	; 0232B8EC
	moveq r1,#0x1f	; 0232B8F0
	str r1,[r0,#ThreadContextCpsrOffset]	; 0232B8F4
	mov r1,#0x0	; 0232B8F8
	str r1,[r0,#ThreadContextR0Offset]	; 0232B8FC
	str r1,[r0,#0x8]	; 0232B900
	str r1,[r0,#0xc]	; 0232B904
	str r1,[r0,#0x10]	; 0232B908
	str r1,[r0,#0x14]	; 0232B90C
	str r1,[r0,#0x18]	; 0232B910
	str r1,[r0,#0x1c]	; 0232B914
	str r1,[r0,#0x20]	; 0232B918
	str r1,[r0,#0x24]	; 0232B91C
	str r1,[r0,#0x28]	; 0232B920
	str r1,[r0,#0x2c]	; 0232B924
	str r1,[r0,#0x30]	; 0232B928
	str r1,[r0,#0x34]	; 0232B92C
	str r1,[r0,#ThreadContextLrOffset]	; 0232B930
	bx lr	; 0232B934
.endfunc

; ===== function loc_0232B938 =====
loc_0232B938:
; 保存寄存器及状态；首次返回 0，恢复后从同一返回点返回 1。
; Save registers/state; return 0 now and 1 from the same return point after restoration.
.func P1_SaveThreadContext
	stmdb sp!,{r0,lr}	; 0232B938
	add r0,r0,#ThreadContextArithmeticOffset	; 0232B93C
	ldr r1,[pool_0232B980]	; 0232B940
	blx r1	; 0232B944
	ldmia sp!,{r0,lr}	; 0232B948
	add r1,r0,#0x0	; 0232B94C
	mrs r2,cpsr	; 0232B950
	str r2,[r1],#0x4	; 0232B954
	mov r0,#0xd3	; 0232B958
	msr cpsr_c,r0	; 0232B95C
	str sp,[r1,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 0232B960
	msr cpsr_c,r2	; 0232B964
	mov r0,#0x1	; 0232B968
	stmia r1,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}	; 0232B96C
	adr r0,P1_SaveThreadContextReturn + 4	; 0232B970
	str r0,[r1,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 0232B974
	mov r0,#0x0	; 0232B978
P1_SaveThreadContextReturn:
	bx lr	; 0232B97C
.endfunc
pool_0232B980:
loc_0232B980:
	.word P1_SaveArithmeticContext + 1	; 0232B980

; ===== function loc_0232B984 =====
loc_0232B984:
; 以 SVC 模式恢复状态和用户寄存器，再用已存 PC+4 恢复执行。
; Restore saved state/user registers in SVC mode, then resume via the saved PC+4.
.func P1_LoadThreadContext
	stmdb sp!,{r0,lr}	; 0232B984
	add r0,r0,#ThreadContextArithmeticOffset	; 0232B988
	ldr r1,[pool_0232B9C4]	; 0232B98C
	blx r1	; 0232B990
	ldmia sp!,{r0,lr}	; 0232B994
	mrs r1,cpsr	; 0232B998
	bic r1,r1,#0x1f	; 0232B99C
	orr r1,r1,#0xd3	; 0232B9A0
	msr cpsr_c,r1	; 0232B9A4
	ldr r1,[r0],#0x4	; 0232B9A8
	msr spsr_cxsf,r1	; 0232B9AC
	ldr sp,[r0,#(ThreadContextSvcSpOffset - ThreadContextR0Offset)]	; 0232B9B0
	ldr lr,[r0,#(ThreadContextPcPlus4Offset - ThreadContextR0Offset)]	; 0232B9B4
	ldmia r0,{r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,sp,lr}^	; 0232B9B8
	mov r0,r0	; 0232B9BC
	subs pc,lr,#0x4	; 0232B9C0
.endfunc
pool_0232B9C4:
loc_0232B9C4:
	.word P1_RestoreArithmeticContext + 1	; 0232B9C4
.thumb

; ===== function loc_0232B9C8 =====
loc_0232B9C8:
	ldr r0,[pool_0232B9D0]	; 0232B9C8
	ldr r1,[pool_0232B9D4]	; 0232B9CA
	str r0,[r1,#0x0]	; 0232B9CC
	bx lr	; 0232B9CE
pool_0232B9D0:
loc_0232B9D0:
	.word 0x82000001	; 0232B9D0
pool_0232B9D4:
loc_0232B9D4:
	.word P1_Data_023307C4	; 0232B9D4

; ===== function loc_0232B9D8 =====
loc_0232B9D8:
	mov r0,#0x0	; 0232B9D8
	bx lr	; 0232B9DA

; ===== function loc_0232B9DC =====
loc_0232B9DC:
	push {r4,r5,r6,r7,lr}	; 0232B9DC
	sub sp,#0x4	; 0232B9DE
	add r5,r0,#0x0	; 0232B9E0
	add r7,r1,#0x0	; 0232B9E2
	add r4,r2,#0x0	; 0232B9E4
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232B9E6
	str r0,[sp,#0x0]	; 0232B9EA
	ldr r0,[r5,#0x10]	; 0232B9EC
	cmp r0,#0x0	; 0232B9EE
	bne loc_0232BA18	; 0232B9F0
	mov r0,#0x1	; 0232B9F2
	and r4,r0	; 0232B9F4
	add r6,r5,#0x2	; 0232B9F6
loc_0232B9F8:
	cmp r4,#0x0	; 0232B9F8
	bne loc_0232BA0C	; 0232B9FA
	ldr r0,[sp,#0x0]	; 0232B9FC
	blx P1_Arm9RestoreIrqMask	; 0232B9FE
	mov r0,#0x0	; 0232BA02
	add sp,#0x4	; 0232BA04
	pop {r4,r5,r6,r7}	; 0232BA06
	pop {r3}	; 0232BA08
	bx r3	; 0232BA0A
loc_0232BA0C:
	add r0,r6,#0x0	; 0232BA0C
	bl loc_0232B62C	; 0232BA0E
	ldr r0,[r5,#0x10]	; 0232BA12
	cmp r0,#0x0	; 0232BA14
	beq loc_0232B9F8	; 0232BA16
loc_0232BA18:
	cmp r7,#0x0	; 0232BA18
	beq loc_0232BA26	; 0232BA1A
	ldr r1,[r5,#0x4]	; 0232BA1C
	ldr r0,[r5,#0xc]	; 0232BA1E
	lsl r0,r0,#0x2	; 0232BA20
	ldr r0,[r1,r0]	; 0232BA22
	str r0,[r7,#0x0]	; 0232BA24
loc_0232BA26:
	ldr r0,[r5,#0xc]	; 0232BA26
	add r0,r0,#0x1	; 0232BA28
	ldr r1,[r5,#0x8]	; 0232BA2A
	blx P1_SignedDivMod	; 0232BA2C
	str r1,[r5,#0xc]	; 0232BA30
	ldr r0,[r5,#0x10]	; 0232BA32
	sub r0,r0,#0x1	; 0232BA34
	str r0,[r5,#0x10]	; 0232BA36
	add r0,r5,#0x0	; 0232BA38
	bl loc_0232B5E4	; 0232BA3A
	ldr r0,[sp,#0x0]	; 0232BA3E
	blx P1_Arm9RestoreIrqMask	; 0232BA40
	mov r0,#0x1	; 0232BA44
	add sp,#0x4	; 0232BA46
	pop {r4,r5,r6,r7}	; 0232BA48
	pop {r3}	; 0232BA4A
	bx r3	; 0232BA4C
	.byte 0x00, 0x00	; 0232BA50

; ===== function loc_0232BA50 =====
loc_0232BA50:
	push {r4,r5,r6,r7,lr}	; 0232BA50
	sub sp,#0x4	; 0232BA52
	add r5,r0,#0x0	; 0232BA54
	add r6,r1,#0x0	; 0232BA56
	add r4,r2,#0x0	; 0232BA58
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BA5A
	add r7,r0,#0x0	; 0232BA5E
	ldr r2,[r5,#0x10]	; 0232BA60
	ldr r1,[r5,#0x8]	; 0232BA62
	cmp r1,r2	; 0232BA64
	bgt loc_0232BA8E	; 0232BA66
	mov r0,#0x1	; 0232BA68
	and r4,r0	; 0232BA6A
loc_0232BA6C:
	cmp r4,#0x0	; 0232BA6C
	bne loc_0232BA80	; 0232BA6E
	add r0,r7,#0x0	; 0232BA70
	blx P1_Arm9RestoreIrqMask	; 0232BA72
	mov r0,#0x0	; 0232BA76
	add sp,#0x4	; 0232BA78
	pop {r4,r5,r6,r7}	; 0232BA7A
	pop {r3}	; 0232BA7C
	bx r3	; 0232BA7E
loc_0232BA80:
	add r0,r5,#0x0	; 0232BA80
	bl loc_0232B62C	; 0232BA82
	ldr r2,[r5,#0x10]	; 0232BA86
	ldr r1,[r5,#0x8]	; 0232BA88
	cmp r1,r2	; 0232BA8A
	ble loc_0232BA6C	; 0232BA8C
loc_0232BA8E:
	ldr r0,[r5,#0xc]	; 0232BA8E
	add r0,r0,r2	; 0232BA90
	blx P1_SignedDivMod	; 0232BA92
	ldr r2,[r5,#0x4]	; 0232BA96
	lsl r0,r1,#0x2	; 0232BA98
	str r6,[r2,r0]	; 0232BA9A
	ldr r0,[r5,#0x10]	; 0232BA9C
	add r0,r0,#0x1	; 0232BA9E
	str r0,[r5,#0x10]	; 0232BAA0
	add r0,r5,#0x2	; 0232BAA2
	bl loc_0232B5E4	; 0232BAA4
	add r0,r7,#0x0	; 0232BAA8
	blx P1_Arm9RestoreIrqMask	; 0232BAAA
	mov r0,#0x1	; 0232BAAE
	add sp,#0x4	; 0232BAB0
	pop {r4,r5,r6,r7}	; 0232BAB2
	pop {r3}	; 0232BAB4
	bx r3	; 0232BAB6
P1_Entry_0232BAB8:
	mov r3,#0x0	; 0232BAB8
	strh r3,[r0,#0x0]	; 0232BABA
	strh r3,[r0,#0x2]	; 0232BABC
	str r1,[r0,#0x4]	; 0232BABE
	str r2,[r0,#0x8]	; 0232BAC0
	str r3,[r0,#0xc]	; 0232BAC2
	str r3,[r0,#0x10]	; 0232BAC4
	bx lr	; 0232BAC6

; ===== function loc_0232BAC8 =====
loc_0232BAC8:
	push {r4}	; 0232BAC8
	sub sp,#0x4	; 0232BACA
	ldr r4,[r0,#0x7c]	; 0232BACC
	ldr r3,[r4,#0x10]	; 0232BACE
	cmp r3,#0x0	; 0232BAD0
	bne loc_0232BADE	; 0232BAD2
	mov r2,#0x0	; 0232BAD4
	add r1,r0,#0x0	; 0232BAD6
	add r1,#0x80	; 0232BAD8
	str r2,[r1,#0x0]	; 0232BADA
	b loc_0232BAE2	; 0232BADC
loc_0232BADE:
	mov r1,#0x0	; 0232BADE
	str r1,[r3,#0xc]	; 0232BAE0
loc_0232BAE2:
	str r3,[r0,#0x7c]	; 0232BAE2
	add r0,r4,#0x0	; 0232BAE4
	add sp,#0x4	; 0232BAE6
	pop {r4}	; 0232BAE8
	bx lr	; 0232BAEA

; ===== function loc_0232BAEC =====
loc_0232BAEC:
	push {r4,r5,lr}	; 0232BAEC
	sub sp,#0x4	; 0232BAEE
	add r5,r0,#0x0	; 0232BAF0
	ldr r0,[r5,#0x7c]	; 0232BAF2
	cmp r0,#0x0	; 0232BAF4
	beq loc_0232BB0E	; 0232BAF6
	mov r4,#0x0	; 0232BAF8
loc_0232BAFA:
	add r0,r5,#0x0	; 0232BAFA
	bl loc_0232BAC8	; 0232BAFC
	str r4,[r0,#0x8]	; 0232BB00
	str r4,[r0,#0x4]	; 0232BB02
	bl loc_0232B5E4	; 0232BB04
	ldr r0,[r5,#0x7c]	; 0232BB08
	cmp r0,#0x0	; 0232BB0A
	bne loc_0232BAFA	; 0232BB0C
loc_0232BB0E:
	add sp,#0x4	; 0232BB0E
	pop {r4,r5}	; 0232BB10
	pop {r3}	; 0232BB12
	bx r3	; 0232BB14
	.byte 0x00, 0x00	; 0232BB18

; ===== function loc_0232BB18 =====
loc_0232BB18:
	mov r1,#0x0	; 0232BB18
	strh r1,[r0,#0x0]	; 0232BB1A
	str r1,[r0,#0x4]	; 0232BB1C
	str r1,[r0,#0x8]	; 0232BB1E
	bx lr	; 0232BB20
	.byte 0x00, 0x00	; 0232BB24
.arm

; ===== function loc_0232BB24 =====
; 以 ARM946 cache index 遍历并清理整个 D-cache。
; Cleans the entire ARM946 D-cache by cache index.
.func P1_CleanEntireDataCacheByIndex
loc_0232BB24:
	mov r1,#0x0	; 0232BB24
loc_0232BB28:
	mov r0,#0x0	; 0232BB28
loc_0232BB2C:
	orr r2,r1,r0	; 0232BB2C
	mcr p15,0x0,r2,c7,c10,0x2	; 0232BB30
	add r0,r0,#0x20	; 0232BB34
	cmp r0,#0x400	; 0232BB38
	blt loc_0232BB2C	; 0232BB3C
	add r1,r1,#0x40000000	; 0232BB40
	cmp r1,#0x0	; 0232BB44
	bne loc_0232BB28	; 0232BB48
	bx lr	; 0232BB4C

.endfunc

; ===== function loc_0232BB50 =====
; 以 ARM946 cache index 遍历，清理并失效整个 D-cache。
; Cleans and invalidates the entire ARM946 D-cache by cache index.
.func P1_CleanAndInvalidateEntireDataCacheByIndex
loc_0232BB50:
	mov r1,#0x0	; 0232BB50
loc_0232BB54:
	mov r0,#0x0	; 0232BB54
loc_0232BB58:
	orr r2,r1,r0	; 0232BB58
	mcr p15,0x0,r2,c7,c14,0x2	; 0232BB5C
	add r0,r0,#0x20	; 0232BB60
	cmp r0,#0x400	; 0232BB64
	blt loc_0232BB58	; 0232BB68
	add r1,r1,#0x40000000	; 0232BB6C
	cmp r1,#0x0	; 0232BB70
	bne loc_0232BB54	; 0232BB74
	bx lr	; 0232BB78

.endfunc

; ===== function loc_0232BB7C =====
; 按 ARM946 32 字节 cache line 失效指定的 D-cache 地址范围。
; Invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_InvalidateDataCacheRange
loc_0232BB7C:
	add r1,r1,r0	; 0232BB7C
	bic r0,r0,#0x1f	; 0232BB80
loc_0232BB84:
	mcr p15,0x0,r0,c7,c6,0x1	; 0232BB84
	add r0,r0,#0x20	; 0232BB88
	cmp r0,r1	; 0232BB8C
	blt loc_0232BB84	; 0232BB90
	bx lr	; 0232BB94

.endfunc

; ===== function loc_0232BB98 =====
; 按 ARM946 32 字节 cache line 清理指定的 D-cache 地址范围。
; Cleans a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanDataCacheRange
loc_0232BB98:
	add r1,r1,r0	; 0232BB98
	bic r0,r0,#0x1f	; 0232BB9C
loc_0232BBA0:
	mcr p15,0x0,r0,c7,c10,0x1	; 0232BBA0
	add r0,r0,#0x20	; 0232BBA4
	cmp r0,r1	; 0232BBA8
	blt loc_0232BBA0	; 0232BBAC
	bx lr	; 0232BBB0

.endfunc

; ===== function loc_0232BBB4 =====
; 按 ARM946 32 字节 cache line 清理并失效指定的 D-cache 地址范围。
; Cleans and invalidates a D-cache range in ARM946 32-byte cache-line units.
.func P1_CleanAndInvalidateDataCacheRange
loc_0232BBB4:
	add r1,r1,r0	; 0232BBB4
	bic r0,r0,#0x1f	; 0232BBB8
loc_0232BBBC:
	mcr p15,0x0,r0,c7,c14,0x1	; 0232BBBC
	add r0,r0,#0x20	; 0232BBC0
	cmp r0,r1	; 0232BBC4
	blt loc_0232BBBC	; 0232BBC8
	bx lr	; 0232BBCC
.endfunc
.arm
; 排空 ARM946 写缓冲区，确保先前存储操作完成。
; Drains the ARM946 write buffer so prior stores complete.
.func P1_DrainWriteBuffer
loc_0232BBD0:
	mov r0,#0x0	; 0232BBD0
	mcr p15,0x0,r0,c7,c10,0x4	; 0232BBD4
	bx lr	; 0232BBD8
.endfunc
.thumb

; ===== function loc_0232BBDC =====
loc_0232BBDC:
	push {lr}	; 0232BBDC
	sub sp,#0x4	; 0232BBDE
	bl loc_0232BD04	; 0232BBE0
	bl loc_0232E778	; 0232BBE4
	bl loc_0232B490	; 0232BBE8
	bl loc_0232BD00	; 0232BBEC
	bl loc_0232B1E8	; 0232BBF0
	bl P1_InitExceptionHandler	; 0232BBF4
	mov r0,#0x3	; 0232BBF8
	bl loc_0232DCDC	; 0232BBFA
	bl loc_0232C3FC	; 0232BBFE
	bl loc_0232B760	; 0232BC02
	bl loc_0232C728	; 0232BC06
	bl loc_0232F4B4	; 0232BC0A
	add sp,#0x4	; 0232BC0E
	pop {r3}	; 0232BC10
	bx r3	; 0232BC12

; ===== function loc_0232BC14 =====
loc_0232BC14:
	lsl r2,r0,#0x2	; 0232BC14
	ldr r0,[pool_0232BC1C]	; 0232BC16
	str r1,[r2,r0]	; 0232BC18
	bx lr	; 0232BC1A
pool_0232BC1C:
loc_0232BC1C:
	.word 0x027FFDA0	; 0232BC1C

; ===== function loc_0232BC20 =====
loc_0232BC20:
	lsl r2,r0,#0x2	; 0232BC20
	ldr r0,[pool_0232BC28]	; 0232BC22
	str r1,[r2,r0]	; 0232BC24
	bx lr	; 0232BC26
pool_0232BC28:
loc_0232BC28:
	.word 0x027FFDC4	; 0232BC28

; ===== function loc_0232BC2C =====
loc_0232BC2C:
	cmp r0,#0x6	; 0232BC2C
	bhi loc_0232BC64	; 0232BC2E
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
	.halfword (loc_0232BC64 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC50 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC54 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC58 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC5C + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
	.halfword (loc_0232BC60 + 1) - (P1_SwitchTargetPC_0232BC30 + 4)
P1_SwitchTable_0232BC30End:
loc_0232BC4C:
	ldr r0,[pool_0232BC68]	; 0232BC4C
	bx lr	; 0232BC4E
loc_0232BC50:
	mov r0,#0x0	; 0232BC50
	bx lr	; 0232BC52
loc_0232BC54:
	ldr r0,[pool_0232BC6C]	; 0232BC54
	bx lr	; 0232BC56
loc_0232BC58:
	ldr r0,[pool_0232BC70]	; 0232BC58
	bx lr	; 0232BC5A
loc_0232BC5C:
	ldr r0,[pool_0232BC74]	; 0232BC5C
	bx lr	; 0232BC5E
loc_0232BC60:
	ldr r0,[pool_0232BC78]	; 0232BC60
	bx lr	; 0232BC62
loc_0232BC64:
	mov r0,#0x0	; 0232BC64
	bx lr	; 0232BC66
pool_0232BC68:
loc_0232BC68:
	.word P1_P345DecodeWorkspaceEnd	; 0232BC68
pool_0232BC6C:
loc_0232BC6C:
	.word 0x01FF8320	; 0232BC6C
pool_0232BC70:
loc_0232BC70:
	.word P1_DtcmRuntimeEnd	; 0232BC70
pool_0232BC74:
loc_0232BC74:
	.word 0x027FF000	; 0232BC74
pool_0232BC78:
loc_0232BC78:
	.word Arm7SharedWramStart	; 0232BC78

; ===== function loc_0232BC7C =====
loc_0232BC7C:
	cmp r0,#0x6	; 0232BC7C
	bhi loc_0232BCD6	; 0232BC7E
	add r0,r0,r0	; 0232BC80
P1_SwitchIndexPC_0232BC80:
	add r0,pc	; 0232BC82
	ldrh r0,[r0,#(P1_SwitchTable_0232BC80 - (P1_SwitchIndexPC_0232BC80 + 4))]	; 0232BC84
	lsl r0,r0,#0x10	; 0232BC86
	asr r0,r0,#0x10	; 0232BC88
P1_SwitchTargetPC_0232BC80:
	add r0,pc	; 0232BC8A
	bx r0	; 0232BC8C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232BC80:
	.halfword (loc_0232BC9C + 1) - (P1_SwitchTargetPC_0232BC80 + 4)
	.halfword (loc_0232BCD6 + 1) - (P1_SwitchTargetPC_0232BC80 + 4)
	.halfword (loc_0232BCA0 + 1) - (P1_SwitchTargetPC_0232BC80 + 4)
	.halfword (loc_0232BCA4 + 1) - (P1_SwitchTargetPC_0232BC80 + 4)
	.halfword (loc_0232BCA8 + 1) - (P1_SwitchTargetPC_0232BC80 + 4)
	.halfword (loc_0232BCCE + 1) - (P1_SwitchTargetPC_0232BC80 + 4)
	.halfword (loc_0232BCD2 + 1) - (P1_SwitchTargetPC_0232BC80 + 4)
P1_SwitchTable_0232BC80End:
loc_0232BC9C:
	ldr r0,[pool_0232BCDC]	; 0232BC9C
	bx lr	; 0232BC9E
loc_0232BCA0:
	mov r0,#0x0	; 0232BCA0
	bx lr	; 0232BCA2
loc_0232BCA4:
	ldr r0,[pool_0232BCE0]	; 0232BCA4
	bx lr	; 0232BCA6
loc_0232BCA8:
	ldr r0,[pool_0232BCE4]	; 0232BCA8
	ldr r1,[pool_0232BCE8]	; 0232BCAA
	add r2,r0,r1	; 0232BCAC
	ldr r1,[pool_0232BCEC]	; 0232BCAE
	sub r2,r2,r1	; 0232BCB0
	ldr r1,[pool_0232BCF0]	; 0232BCB2
	cmp r1,#0x0	; 0232BCB4
	bne loc_0232BCC2	; 0232BCB6
	ldr r1,[pool_0232BCF4]	; 0232BCB8
	cmp r0,r1	; 0232BCBA
	bcs loc_0232BCD8	; 0232BCBC
	add r0,r1,#0x0	; 0232BCBE
	bx lr	; 0232BCC0
loc_0232BCC2:
	cmp r1,#0x0	; 0232BCC2
	bge loc_0232BCCA	; 0232BCC4
	sub r0,r0,r1	; 0232BCC6
	bx lr	; 0232BCC8
loc_0232BCCA:
	sub r0,r2,r1	; 0232BCCA
	bx lr	; 0232BCCC
loc_0232BCCE:
	ldr r0,[pool_0232BCF8]	; 0232BCCE
	bx lr	; 0232BCD0
loc_0232BCD2:
	ldr r0,[pool_0232BCFC]	; 0232BCD2
	bx lr	; 0232BCD4
loc_0232BCD6:
	mov r0,#0x0	; 0232BCD6
loc_0232BCD8:
	bx lr	; 0232BCD8
	.byte 0xC0, 0x46	; 0232BCDC
pool_0232BCDC:
loc_0232BCDC:
	.word 0x023C0000	; 0232BCDC
pool_0232BCE0:
loc_0232BCE0:
	.word 0x02000000	; 0232BCE0
pool_0232BCE4:
loc_0232BCE4:
	.word P1_DtcmRuntimeStart	; 0232BCE4
pool_0232BCE8:
loc_0232BCE8:
	.word 0x00003F80	; 0232BCE8
pool_0232BCEC:
loc_0232BCEC:
	.word 0x00001000	; 0232BCEC
pool_0232BCF0:
loc_0232BCF0:
	.word 0x00000000	; 0232BCF0
pool_0232BCF4:
loc_0232BCF4:
	.word P1_DtcmRuntimeEnd	; 0232BCF4
pool_0232BCF8:
loc_0232BCF8:
	.word 0x027FF800	; 0232BCF8
pool_0232BCFC:
loc_0232BCFC:
	.word Arm7SharedWramStart	; 0232BCFC

; ===== function loc_0232BD00 =====
loc_0232BD00:
	bx lr	; 0232BD00
	.byte 0x00, 0x00	; 0232BD04

; ===== function loc_0232BD04 =====
loc_0232BD04:
	push {lr}	; 0232BD04
	sub sp,#0x4	; 0232BD06
	ldr r0,[pool_0232BD48]	; 0232BD08
	ldr r1,[r0,#0x0]	; 0232BD0A
	cmp r1,#0x0	; 0232BD0C
	bne loc_0232BD42	; 0232BD0E
	mov r1,#0x1	; 0232BD10
	str r1,[r0,#0x0]	; 0232BD12
	mov r0,#0x0	; 0232BD14
	bl loc_0232BD4C	; 0232BD16
	mov r0,#0x2	; 0232BD1A
	mov r1,#0x0	; 0232BD1C
	bl loc_0232BC14	; 0232BD1E
	mov r0,#0x2	; 0232BD22
	mov r1,#0x0	; 0232BD24
	bl loc_0232BC20	; 0232BD26
	mov r0,#0x3	; 0232BD2A
	bl loc_0232BD4C	; 0232BD2C
	mov r0,#0x4	; 0232BD30
	bl loc_0232BD4C	; 0232BD32
	mov r0,#0x5	; 0232BD36
	bl loc_0232BD4C	; 0232BD38
	mov r0,#0x6	; 0232BD3C
	bl loc_0232BD4C	; 0232BD3E
loc_0232BD42:
	add sp,#0x4	; 0232BD42
	pop {r3}	; 0232BD44
	bx r3	; 0232BD46
pool_0232BD48:
loc_0232BD48:
	.word P1_BssStart + 0x265C4	; 0232BD48

; ===== function loc_0232BD4C =====
loc_0232BD4C:
	push {r4,lr}	; 0232BD4C
	add r4,r0,#0x0	; 0232BD4E
	bl loc_0232BC7C	; 0232BD50
	add r1,r0,#0x0	; 0232BD54
	add r0,r4,#0x0	; 0232BD56
	bl loc_0232BC20	; 0232BD58
	add r0,r4,#0x0	; 0232BD5C
	bl loc_0232BC2C	; 0232BD5E
	add r1,r0,#0x0	; 0232BD62
	add r0,r4,#0x0	; 0232BD64
	bl loc_0232BC14	; 0232BD66
	pop {r4}	; 0232BD6A
	pop {r3}	; 0232BD6C
	bx r3	; 0232BD6E
.arm

; ===== function loc_0232BD70 =====
; Sets CP15 control-register c1 bit 0. / 置位 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9SetCp15ControlBit0
loc_0232BD70:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BD70
	orr r0,r0,#0x1	; 0232BD74
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BD78
	bx lr	; 0232BD7C
.endfunc

; ===== function loc_0232BD80 =====
; Clears CP15 control-register c1 bit 0. / 清除 CP15 控制寄存器 c1 的 bit 0。
.func P1_Arm9ClearCp15ControlBit0
loc_0232BD80:
	mrc p15,0x0,r0,c1,c0,0x0	; 0232BD80
	bic r0,r0,#0x1	; 0232BD84
	mcr p15,0x0,r0,c1,c0,0x0	; 0232BD88
	bx lr	; 0232BD8C
.endfunc
; 链接既有调试入口；保存现场后处理 abort/undef，最后停在等待循环。
; Chain the saved debug handler; process abort/undef context, then stop in a wait loop.
.func P1_ExceptionEntry
	ldr r12,[pool_0232BDFC]	; 0232BD90
	ldr r12,[r12,#0x0]	; 0232BD94
	cmp r12,#0x0	; 0232BD98
	movne lr,pc	; 0232BD9C
	bxne r12	; 0232BDA0
	ldr r12,[pool_0232BE00]	; 0232BDA4
	stmdb r12!,{r0,r1,r2,r3,sp,lr}	; 0232BDA8
	and r0,sp,#0x1	; 0232BDAC
	mov sp,r12	; 0232BDB0
	mrs r1,cpsr	; 0232BDB4
	and r1,r1,#0x1f	; 0232BDB8
	teq r1,#0x17	; 0232BDBC
	bne loc_0232BDCC	; 0232BDC0
	bl P1_ProcessException	; 0232BDC4
	b loc_0232BDD8	; 0232BDC8
loc_0232BDCC:
	teq r1,#0x1b	; 0232BDCC
	bne loc_0232BDD8	; 0232BDD0
	bl P1_ProcessException	; 0232BDD4
loc_0232BDD8:
	ldr r12,[pool_0232BDFC]	; 0232BDD8
	ldr r12,[r12,#0x0]	; 0232BDDC
	cmp r12,#0x0	; 0232BDE0
loc_0232BDE4:
	beq loc_0232BDE4	; 0232BDE4
loc_0232BDE8:
	mov r0,r0	; 0232BDE8
	b loc_0232BDE8	; 0232BDEC
.endfunc
	.byte 0x0F, 0x50, 0xBD, 0xE8, 0x0C, 0xD0, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1	; 0232BDFC
pool_0232BDFC:
loc_0232BDFC:
	.word P1_PreviousExceptionHandler	; 0232BDFC
pool_0232BE00:
loc_0232BE00:
	.word P1_ExceptionStackTop	; 0232BE00

; ===== function loc_0232BE04 =====
loc_0232BE04:
; 先保存异常现场，再调用已注册的用户处理器。
; Save exception context, then invoke the registered user handler.
.func P1_ProcessException
	stmdb sp!,{lr}	; 0232BE04
	bl P1_SaveExceptionContext	; 0232BE08
	bl P1_CallUserExceptionHandler	; 0232BE0C
	ldmia sp!,{lr}	; 0232BE10
	bx lr	; 0232BE14
.endfunc

; ===== function loc_0232BE18 =====
loc_0232BE18:
; 收集通用寄存器、异常栈与各模式的状态，写入 BSS 上下文。
; Collect registers, exception-stack data and mode state into the BSS context.
.func P1_SaveExceptionContext
	ldr r1,[pool_0232BEA4]	; 0232BE18
	mrs r2,cpsr	; 0232BE1C
	str r2,[r1,#0x74]	; 0232BE20
	str r0,[r1,#0x6c]	; 0232BE24
	ldr r0,[r12,#0x0]	; 0232BE28
	str r0,[r1,#0x4]	; 0232BE2C
	ldr r0,[r12,#0x4]	; 0232BE30
	str r0,[r1,#0x8]	; 0232BE34
	ldr r0,[r12,#0x8]	; 0232BE38
	str r0,[r1,#0xc]	; 0232BE3C
	ldr r0,[r12,#0xc]	; 0232BE40
	str r0,[r1,#0x10]	; 0232BE44
	ldr r2,[r12,#0x10]	; 0232BE48
	bic r2,r2,#0x1	; 0232BE4C
	add r0,r1,#0x14	; 0232BE50
	stmia r0,{r4,r5,r6,r7,r8,r9,r10,r11}	; 0232BE54
	str r12,[r1,#0x70]	; 0232BE58
	ldr r0,[r2,#0x0]	; 0232BE5C
	str r0,[r1,#0x64]	; 0232BE60
	ldr r3,[r2,#0x4]	; 0232BE64
	str r3,[r1,#0x0]	; 0232BE68
	ldr r0,[r2,#0x8]	; 0232BE6C
	str r0,[r1,#0x34]	; 0232BE70
	ldr r0,[r2,#0xc]	; 0232BE74
	str r0,[r1,#0x40]	; 0232BE78
	mrs r0,cpsr	; 0232BE7C
	orr r3,r3,#0x80	; 0232BE80
	bic r3,r3,#0x20	; 0232BE84
	msr cpsr_cxsf,r3	; 0232BE88
	str sp,[r1,#0x38]	; 0232BE8C
	str lr,[r1,#0x3c]	; 0232BE90
	mrs r2,spsr	; 0232BE94
	str r2,[r1,#0x7c]	; 0232BE98
	msr cpsr_cxsf,r0	; 0232BE9C
	bx lr	; 0232BEA0
.endfunc
pool_0232BEA4:
loc_0232BEA4:
	.word P1_ExceptionContext	; 0232BEA4

; ===== function loc_0232BEA8 =====
loc_0232BEA8:
; 若已注册，临时启用保护单元并以现场/参数调用用户回调。
; If registered, enable the MPU for the user callback with context and argument.
.func P1_CallUserExceptionHandler
	stmdb sp!,{lr}	; 0232BEA8
	sub sp,sp,#0x4	; 0232BEAC
	ldr r0,[pool_0232BF04]	; 0232BEB0
	ldr r0,[r0,#0x0]	; 0232BEB4
	cmp r0,#0x0	; 0232BEB8
	addeq sp,sp,#0x4	; 0232BEBC
	ldmeqia sp!,{lr}	; 0232BEC0
	bxeq lr	; 0232BEC4
	mov r0,sp	; 0232BEC8
	ldr r1,[pool_0232BF08]	; 0232BECC
	msr cpsr_cxsf,r1	; 0232BED0
	mov sp,r0	; 0232BED4
	bl P1_Arm9SetCp15ControlBit0	; 0232BED8
	ldr r1,[pool_0232BF0C]	; 0232BEDC
	ldr r0,[pool_0232BF04]	; 0232BEE0
	ldr r1,[r1,#0x0]	; 0232BEE4
	ldr r2,[r0,#0x0]	; 0232BEE8
	ldr r0,[pool_0232BF10]	; 0232BEEC
	blx r2	; 0232BEF0
	bl P1_Arm9ClearCp15ControlBit0	; 0232BEF4
	add sp,sp,#0x4	; 0232BEF8
	ldmia sp!,{lr}	; 0232BEFC
	bx lr	; 0232BF00
.endfunc
pool_0232BF04:
loc_0232BF04:
	.word P1_UserExceptionHandler	; 0232BF04
pool_0232BF08:
loc_0232BF08:
	.word 0x0000009F	; 0232BF08
pool_0232BF0C:
loc_0232BF0C:
	.word P1_UserExceptionArgument	; 0232BF0C
pool_0232BF10:
loc_0232BF10:
	.word P1_ExceptionContext	; 0232BF10
.thumb

; ===== function loc_0232BF14 =====
loc_0232BF14:
; 检查既有调试入口；需要时同时安装 BIOS 向量和 DTCM 中的入口副本。
; Check the saved debug entry; install the BIOS vector and DTCM copy when required.
.func P1_InitExceptionHandler
	push {lr}	; 0232BF14
	sub sp,#0x4	; 0232BF16
	ldr r0,[pool_0232BF60]	; 0232BF18
	ldr r1,[r0,#0x0]	; 0232BF1A
	ldr r0,[pool_0232BF64]	; 0232BF1C
	cmp r1,r0	; 0232BF1E
	bcc loc_0232BF2E	; 0232BF20
	ldr r0,[pool_0232BF68]	; 0232BF22
	cmp r1,r0	; 0232BF24
	bcs loc_0232BF2E	; 0232BF26
	ldr r0,[pool_0232BF6C]	; 0232BF28
	str r1,[r0,#0x0]	; 0232BF2A
	b loc_0232BF34	; 0232BF2C
loc_0232BF2E:
	mov r1,#0x0	; 0232BF2E
	ldr r0,[pool_0232BF6C]	; 0232BF30
	str r1,[r0,#0x0]	; 0232BF32
loc_0232BF34:
	ldr r0,[pool_0232BF6C]	; 0232BF34
	ldr r0,[r0,#0x0]	; 0232BF36
	cmp r0,#0x0	; 0232BF38
	beq loc_0232BF48	; 0232BF3A
	bl loc_0232B9C8	; 0232BF3C
	ldr r1,[pool_0232BF70]	; 0232BF40
	and r0,r1	; 0232BF42
	cmp r0,#0x0	; 0232BF44
	bne loc_0232BF52	; 0232BF46
loc_0232BF48:
	ldr r1,[pool_0232BF74]	; 0232BF48
	ldr r0,[pool_0232BF60]	; 0232BF4A
	str r1,[r0,#0x0]	; 0232BF4C
	ldr r0,[pool_0232BF78]	; 0232BF4E
	str r1,[r0,#0x5c]	; 0232BF50
loc_0232BF52:
	mov r1,#0x0	; 0232BF52
	ldr r0,[pool_0232BF7C]	; 0232BF54
	str r1,[r0,#0x0]	; 0232BF56
	add sp,#0x4	; 0232BF58
	pop {r3}	; 0232BF5A
	bx r3	; 0232BF5C
.endfunc
	.byte 0xC0, 0x46	; 0232BF60
pool_0232BF60:
loc_0232BF60:
	.word Bios9DebugVectorAddress	; 0232BF60
pool_0232BF64:
loc_0232BF64:
	.word 0x02600000	; 0232BF64
pool_0232BF68:
loc_0232BF68:
	.word 0x02800000	; 0232BF68
pool_0232BF6C:
loc_0232BF6C:
	.word P1_PreviousExceptionHandler	; 0232BF6C
pool_0232BF70:
loc_0232BF70:
	.word 0x40000000	; 0232BF70
pool_0232BF74:
loc_0232BF74:
	.word P1_ExceptionEntry	; 0232BF74
pool_0232BF78:
loc_0232BF78:
	.word P1_DtcmExceptionVector - 0x5C	; 0232BF78
pool_0232BF7C:
loc_0232BF7C:
	.word P1_UserExceptionHandler	; 0232BF7C

; ===== function loc_0232BF80 =====
loc_0232BF80:
	ldr r1,[pool_0232BF90]	; 0232BF80
	ldrh r3,[r1,#0x0]	; 0232BF82
	mov r2,#0x1	; 0232BF84
	lsl r2,r0	; 0232BF86
	orr r3,r2	; 0232BF88
	strh r3,[r1,#0x0]	; 0232BF8A
	bx lr	; 0232BF8C
	.byte 0xC0, 0x46	; 0232BF90
pool_0232BF90:
loc_0232BF90:
	.word P1_BssStart + 0x26654	; 0232BF90

; ===== function loc_0232BF94 =====
loc_0232BF94:
	push {r4,r5,lr}	; 0232BF94
	sub sp,#0xc	; 0232BF96
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232BF98
	ldr r1,[pool_0232BFFC]	; 0232BF9C
	ldrh r1,[r1,#0x0]	; 0232BF9E
	add r3,sp,#0x0	; 0232BFA0
	strh r1,[r3,#0x0]	; 0232BFA2
	ldr r1,[pool_0232C000]	; 0232BFA4
	ldr r5,[r1,#0x0]	; 0232BFA6
	ldr r4,[r1,#0x4]	; 0232BFA8
	ldr r1,[pool_0232C004]	; 0232BFAA
	mov r2,#0x0	; 0232BFAC
	and r4,r1	; 0232BFAE
	bic r5,r2	; 0232BFB0
	str r5,[sp,#0x4]	; 0232BFB2
	str r4,[sp,#0x8]	; 0232BFB4
	ldr r1,[pool_0232C008]	; 0232BFB6
	ldr r4,[r1,#0x0]	; 0232BFB8
	mov r1,#0x8	; 0232BFBA
	and r4,r1	; 0232BFBC
	cmp r4,#0x0	; 0232BFBE
	beq loc_0232BFDA	; 0232BFC0
	ldrh r3,[r3,#0x0]	; 0232BFC2
	ldr r1,[pool_0232C00C]	; 0232BFC4
	and r3,r1	; 0232BFC6
	cmp r3,#0x0	; 0232BFC8
	bne loc_0232BFDA	; 0232BFCA
	ldr r3,[sp,#0x4]	; 0232BFCC
	ldr r4,[sp,#0x8]	; 0232BFCE
	mov r1,#0x1	; 0232BFD0
	add r1,r3,r1	; 0232BFD2
	adc r4,r2	; 0232BFD4
	str r1,[sp,#0x4]	; 0232BFD6
	str r4,[sp,#0x8]	; 0232BFD8
loc_0232BFDA:
	blx P1_Arm9RestoreIrqMask	; 0232BFDA
	ldr r2,[sp,#0x4]	; 0232BFDE
	ldr r1,[sp,#0x8]	; 0232BFE0
	lsr r0,r2,#0x10	; 0232BFE2
	lsl r1,r1,#0x10	; 0232BFE4
	orr r1,r0	; 0232BFE6
	lsl r0,r2,#0x10	; 0232BFE8
	add r2,sp,#0x0	; 0232BFEA
	ldrh r3,[r2,#0x0]	; 0232BFEC
	asr r2,r3,#0x1f	; 0232BFEE
	orr r1,r2	; 0232BFF0
	orr r0,r3	; 0232BFF2
	add sp,#0xc	; 0232BFF4
	pop {r4,r5}	; 0232BFF6
	pop {r3}	; 0232BFF8
	bx r3	; 0232BFFA
pool_0232BFFC:
loc_0232BFFC:
	.word TIMER0_DATA	; 0232BFFC
pool_0232C000:
loc_0232C000:
	.word P1_BssStart + 0x26660	; 0232C000
pool_0232C004:
loc_0232C004:
	.word 0x0000FFFF	; 0232C004
pool_0232C008:
loc_0232C008:
	.word REG_IF	; 0232C008
pool_0232C00C:
loc_0232C00C:
	.word 0x00008000	; 0232C00C

; ===== function loc_0232C010 =====
P1_IrqHandler_0232C010:
	push {r4,lr}	; 0232C010
	ldr r1,[pool_0232C04C]	; 0232C012
	ldr r2,[r1,#0x0]	; 0232C014
	ldr r4,[r1,#0x4]	; 0232C016
	mov r3,#0x0	; 0232C018
	mov r0,#0x1	; 0232C01A
	add r0,r2,r0	; 0232C01C
	adc r4,r3	; 0232C01E
	str r0,[r1,#0x0]	; 0232C020
	str r4,[r1,#0x4]	; 0232C022
	ldr r0,[pool_0232C050]	; 0232C024
	ldr r1,[r0,#0x0]	; 0232C026
	cmp r1,#0x0	; 0232C028
	beq loc_0232C03A	; 0232C02A
	ldr r2,[pool_0232C054]	; 0232C02C
	strh r3,[r2,#0x0]	; 0232C02E
	ldr r1,[pool_0232C058]	; 0232C030
	strh r3,[r1,#0x0]	; 0232C032
	mov r1,#0xc1	; 0232C034
	strh r1,[r2,#0x0]	; 0232C036
	str r3,[r0,#0x0]	; 0232C038
loc_0232C03A:
	mov r0,#0x0	; 0232C03A
	ldr r1,[pool_0232C05C]	; 0232C03C
	add r2,r0,#0x0	; 0232C03E
	bl loc_0232B150	; 0232C040
	pop {r4}	; 0232C044
	pop {r3}	; 0232C046
	bx r3	; 0232C048
	.byte 0xC0, 0x46	; 0232C04C
pool_0232C04C:
loc_0232C04C:
	.word P1_BssStart + 0x26660	; 0232C04C
pool_0232C050:
loc_0232C050:
	.word P1_BssStart + 0x2665C	; 0232C050
pool_0232C054:
loc_0232C054:
	.word TIMER0_CR	; 0232C054
pool_0232C058:
loc_0232C058:
	.word TIMER0_DATA	; 0232C058
pool_0232C05C:
loc_0232C05C:
	.word P1_IrqHandler_0232C010 + 1	; 0232C05C

; ===== function loc_0232C060 =====
loc_0232C060:
	push {lr}	; 0232C060
	sub sp,#0x4	; 0232C062
	ldr r0,[pool_0232C0A4]	; 0232C064
	ldrh r1,[r0,#0x0]	; 0232C066
	cmp r1,#0x0	; 0232C068
	bne loc_0232C09E	; 0232C06A
	mov r1,#0x1	; 0232C06C
	strh r1,[r0,#0x0]	; 0232C06E
	mov r0,#0x0	; 0232C070
	bl loc_0232BF80	; 0232C072
	mov r2,#0x0	; 0232C076
	ldr r0,[pool_0232C0A8]	; 0232C078
	str r2,[r0,#0x0]	; 0232C07A
	str r2,[r0,#0x4]	; 0232C07C
	ldr r1,[pool_0232C0AC]	; 0232C07E
	strh r2,[r1,#0x0]	; 0232C080
	ldr r0,[pool_0232C0B0]	; 0232C082
	strh r2,[r0,#0x0]	; 0232C084
	mov r0,#0xc1	; 0232C086
	strh r0,[r1,#0x0]	; 0232C088
	mov r0,#0x8	; 0232C08A
	ldr r1,[pool_0232C0B4]	; 0232C08C
	bl loc_0232B184	; 0232C08E
	mov r0,#0x8	; 0232C092
	bl loc_0232B100	; 0232C094
	mov r1,#0x0	; 0232C098
	ldr r0,[pool_0232C0B8]	; 0232C09A
	str r1,[r0,#0x0]	; 0232C09C
loc_0232C09E:
	add sp,#0x4	; 0232C09E
	pop {r3}	; 0232C0A0
	bx r3	; 0232C0A2
pool_0232C0A4:
loc_0232C0A4:
	.word P1_BssStart + 0x26658	; 0232C0A4
pool_0232C0A8:
loc_0232C0A8:
	.word P1_BssStart + 0x26660	; 0232C0A8
pool_0232C0AC:
loc_0232C0AC:
	.word TIMER0_CR	; 0232C0AC
pool_0232C0B0:
loc_0232C0B0:
	.word TIMER0_DATA	; 0232C0B0
pool_0232C0B4:
loc_0232C0B4:
	.word P1_IrqHandler_0232C010 + 1	; 0232C0B4
pool_0232C0B8:
loc_0232C0B8:
	.word P1_BssStart + 0x2665C	; 0232C0B8
.arm
	stmdb sp!,{lr}	; 0232C0BC
	blx loc_0232C120	; 0232C0C0
	ldmia sp!,{lr}	; 0232C0C4
	bx lr	; 0232C0C8
.thumb

; ===== function loc_0232C0CC =====
P1_Entry_0232C0CC:
	push {r4,r5,r6,r7,lr}	; 0232C0CC
	sub sp,#0x4	; 0232C0CE
	add r5,r0,#0x0	; 0232C0D0
	cmp r5,#0x0	; 0232C0D2
	beq loc_0232C110	; 0232C0D4
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C0D6
	add r7,r0,#0x0	; 0232C0DA
	ldr r0,[pool_0232C118]	; 0232C0DC
	ldr r0,[r0,#0x0]	; 0232C0DE
	cmp r0,#0x0	; 0232C0E0
	beq loc_0232C0E8	; 0232C0E2
	ldr r4,[r0,#0x18]	; 0232C0E4
	b loc_0232C0EA	; 0232C0E6
loc_0232C0E8:
	mov r4,#0x0	; 0232C0E8
loc_0232C0EA:
	cmp r0,#0x0	; 0232C0EA
	beq loc_0232C10A	; 0232C0EC
	mov r6,#0x0	; 0232C0EE
loc_0232C0F0:
	ldr r1,[r0,#0x8]	; 0232C0F0
	cmp r1,r5	; 0232C0F2
	bne loc_0232C0FA	; 0232C0F4
	bl loc_0232C1D0	; 0232C0F6
loc_0232C0FA:
	add r0,r4,#0x0	; 0232C0FA
	cmp r4,#0x0	; 0232C0FC
	beq loc_0232C104	; 0232C0FE
	ldr r4,[r4,#0x18]	; 0232C100
	b loc_0232C106	; 0232C102
loc_0232C104:
	add r4,r6,#0x0	; 0232C104
loc_0232C106:
	cmp r0,#0x0	; 0232C106
	bne loc_0232C0F0	; 0232C108
loc_0232C10A:
	add r0,r7,#0x0	; 0232C10A
	blx P1_Arm9RestoreIrqMask	; 0232C10C
loc_0232C110:
	add sp,#0x4	; 0232C110
	pop {r4,r5,r6,r7}	; 0232C112
	pop {r3}	; 0232C114
	bx r3	; 0232C116
pool_0232C118:
loc_0232C118:
	.word P1_BssStart + 0x2666C	; 0232C118
P1_Entry_0232C11C:
	str r1,[r0,#0x8]	; 0232C11C
	bx lr	; 0232C11E

; ===== function loc_0232C120 =====
loc_0232C120:
	push {r4,r5,lr}	; 0232C120
	sub sp,#0x4	; 0232C122
	mov r1,#0x0	; 0232C124
	ldr r0,[pool_0232C1C0]	; 0232C126
	strh r1,[r0,#0x0]	; 0232C128
	mov r0,#0x10	; 0232C12A
	bl loc_0232B0D8	; 0232C12C
	ldr r1,[pool_0232C1C4]	; 0232C130
	ldr r0,[pool_0232C1C8]	; 0232C132
	add r1,r1,r0	; 0232C134
	ldr r2,[r1,#0x0]	; 0232C136
	mov r0,#0x10	; 0232C138
	orr r2,r0	; 0232C13A
	str r2,[r1,#0x0]	; 0232C13C
	bl loc_0232BF94	; 0232C13E
	ldr r2,[pool_0232C1CC]	; 0232C142
	ldr r4,[r2,#0x0]	; 0232C144
	cmp r4,#0x0	; 0232C146
	beq loc_0232C1B6	; 0232C148
	ldr r5,[r4,#0xc]	; 0232C14A
	ldr r3,[r4,#0x10]	; 0232C14C
	sub r0,r0,r5	; 0232C14E
	sbc r1,r3	; 0232C150
	bcs loc_0232C162	; 0232C152
	add r0,r4,#0x0	; 0232C154
	bl loc_0232C390	; 0232C156
	add sp,#0x4	; 0232C15A
	pop {r4,r5}	; 0232C15C
	pop {r3}	; 0232C15E
	bx r3	; 0232C160
loc_0232C162:
	ldr r1,[r4,#0x18]	; 0232C162
	str r1,[r2,#0x0]	; 0232C164
	cmp r1,#0x0	; 0232C166
	bne loc_0232C170	; 0232C168
	mov r0,#0x0	; 0232C16A
	str r0,[r2,#0x4]	; 0232C16C
	b loc_0232C174	; 0232C16E
loc_0232C170:
	mov r0,#0x0	; 0232C170
	str r0,[r1,#0x14]	; 0232C172
loc_0232C174:
	ldr r5,[r4,#0x0]	; 0232C174
	ldr r2,[r4,#0x1c]	; 0232C176
	ldr r1,[r4,#0x20]	; 0232C178
	mov r0,#0x0	; 0232C17A
	eor r1,r0	; 0232C17C
	eor r2,r0	; 0232C17E
	orr r1,r2	; 0232C180
	bne loc_0232C188	; 0232C182
	mov r0,#0x0	; 0232C184
	str r0,[r4,#0x0]	; 0232C186
loc_0232C188:
	cmp r5,#0x0	; 0232C188
	beq loc_0232C190	; 0232C18A
	ldr r0,[r4,#0x4]	; 0232C18C
	blx r5	; 0232C18E
loc_0232C190:
	ldr r2,[r4,#0x1c]	; 0232C190
	ldr r1,[r4,#0x20]	; 0232C192
	mov r0,#0x0	; 0232C194
	eor r1,r0	; 0232C196
	eor r2,r0	; 0232C198
	orr r1,r2	; 0232C19A
	beq loc_0232C1AA	; 0232C19C
	str r5,[r4,#0x0]	; 0232C19E
	add r0,r4,#0x0	; 0232C1A0
	mov r1,#0x0	; 0232C1A2
	add r2,r1,#0x0	; 0232C1A4
	bl loc_0232C280	; 0232C1A6
loc_0232C1AA:
	ldr r0,[pool_0232C1CC]	; 0232C1AA
	ldr r0,[r0,#0x0]	; 0232C1AC
	cmp r0,#0x0	; 0232C1AE
	beq loc_0232C1B6	; 0232C1B0
	bl loc_0232C390	; 0232C1B2
loc_0232C1B6:
	add sp,#0x4	; 0232C1B6
	pop {r4,r5}	; 0232C1B8
	pop {r3}	; 0232C1BA
	bx r3	; 0232C1BC
	.byte 0xC0, 0x46	; 0232C1C0
pool_0232C1C0:
loc_0232C1C0:
	.word TIMER1_CR	; 0232C1C0
pool_0232C1C4:
loc_0232C1C4:
	.word P1_DtcmRuntimeStart	; 0232C1C4
pool_0232C1C8:
loc_0232C1C8:
	.word 0x00003FF8	; 0232C1C8
pool_0232C1CC:
loc_0232C1CC:
	.word P1_BssStart + 0x2666C	; 0232C1CC

; ===== function loc_0232C1D0 =====
loc_0232C1D0:
	push {r4,r5,lr}	; 0232C1D0
	sub sp,#0x4	; 0232C1D2
	add r5,r0,#0x0	; 0232C1D4
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C1D6
	add r4,r0,#0x0	; 0232C1DA
	ldr r1,[r5,#0x0]	; 0232C1DC
	cmp r1,#0x0	; 0232C1DE
	bne loc_0232C1EE	; 0232C1E0
	blx P1_Arm9RestoreIrqMask	; 0232C1E2
	add sp,#0x4	; 0232C1E6
	pop {r4,r5}	; 0232C1E8
	pop {r3}	; 0232C1EA
	bx r3	; 0232C1EC
loc_0232C1EE:
	ldr r0,[r5,#0x18]	; 0232C1EE
	cmp r0,#0x0	; 0232C1F0
	bne loc_0232C1FC	; 0232C1F2
	ldr r2,[r5,#0x14]	; 0232C1F4
	ldr r1,[pool_0232C22C]	; 0232C1F6
	str r2,[r1,#0x4]	; 0232C1F8
	b loc_0232C200	; 0232C1FA
loc_0232C1FC:
	ldr r1,[r5,#0x14]	; 0232C1FC
	str r1,[r0,#0x14]	; 0232C1FE
loc_0232C200:
	ldr r1,[r5,#0x14]	; 0232C200
	cmp r1,#0x0	; 0232C202
	beq loc_0232C20A	; 0232C204
	str r0,[r1,#0x18]	; 0232C206
	b loc_0232C216	; 0232C208
loc_0232C20A:
	ldr r1,[pool_0232C22C]	; 0232C20A
	str r0,[r1,#0x0]	; 0232C20C
	cmp r0,#0x0	; 0232C20E
	beq loc_0232C216	; 0232C210
	bl loc_0232C390	; 0232C212
loc_0232C216:
	mov r0,#0x0	; 0232C216
	str r0,[r5,#0x0]	; 0232C218
	str r0,[r5,#0x1c]	; 0232C21A
	str r0,[r5,#0x20]	; 0232C21C
	add r0,r4,#0x0	; 0232C21E
	blx P1_Arm9RestoreIrqMask	; 0232C220
	add sp,#0x4	; 0232C224
	pop {r4,r5}	; 0232C226
	pop {r3}	; 0232C228
	bx r3	; 0232C22A
pool_0232C22C:
loc_0232C22C:
	.word P1_BssStart + 0x2666C	; 0232C22C
P1_Entry_0232C230:
	push {r4,r5,r6,r7,lr}	; 0232C230
	sub sp,#0x4	; 0232C232
	add r5,r0,#0x0	; 0232C234
	add r6,r1,#0x0	; 0232C236
	add r4,r2,#0x0	; 0232C238
	add r7,r3,#0x0	; 0232C23A
	cmp r5,#0x0	; 0232C23C
	beq P1_Entry_0232C246	; 0232C23E
	ldr r0,[r5,#0x0]	; 0232C240
	cmp r0,#0x0	; 0232C242
	beq P1_Entry_0232C24A	; 0232C244
P1_Entry_0232C246:
	bl loc_0232C4CC	; 0232C246
P1_Entry_0232C24A:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C24A
	str r0,[sp,#0x0]	; 0232C24E
	mov r0,#0x0	; 0232C250
	str r0,[r5,#0x1c]	; 0232C252
	str r0,[r5,#0x20]	; 0232C254
	str r7,[r5,#0x0]	; 0232C256
	ldr r0,[sp,#0x18]	; 0232C258
	str r0,[r5,#0x4]	; 0232C25A
	bl loc_0232BF94	; 0232C25C
	add r2,r0,#0x0	; 0232C260
	add r0,r5,#0x0	; 0232C262
	add r2,r6,r2	; 0232C264
	adc r4,r1	; 0232C266
	add r1,r2,#0x0	; 0232C268
	add r2,r4,#0x0	; 0232C26A
	bl loc_0232C280	; 0232C26C
	ldr r0,[sp,#0x0]	; 0232C270
	blx P1_Arm9RestoreIrqMask	; 0232C272
	add sp,#0x4	; 0232C276
	pop {r4,r5,r6,r7}	; 0232C278
	pop {r3}	; 0232C27A
	bx r3	; 0232C27C
	.byte 0x00, 0x00	; 0232C27E

; ===== function loc_0232C280 =====
loc_0232C280:
	push {r4,r5,r6,r7,lr}	; 0232C280
	sub sp,#0xc	; 0232C282
	add r5,r0,#0x0	; 0232C284
	add r4,r1,#0x0	; 0232C286
	add r6,r2,#0x0	; 0232C288
	ldr r2,[r5,#0x1c]	; 0232C28A
	ldr r1,[r5,#0x20]	; 0232C28C
	mov r0,#0x0	; 0232C28E
	eor r1,r0	; 0232C290
	eor r2,r0	; 0232C292
	orr r1,r2	; 0232C294
	beq loc_0232C2DA	; 0232C296
	bl loc_0232BF94	; 0232C298
	ldr r4,[r5,#0x24]	; 0232C29C
	ldr r6,[r5,#0x28]	; 0232C29E
	sub r2,r4,r0	; 0232C2A0
	lsl r2,r6,#0	; 0232C2A2
	sbc r2,r1	; 0232C2A4
	bcs loc_0232C2DA	; 0232C2A6
	ldr r2,[r5,#0x1c]	; 0232C2A8
	str r2,[sp,#0x0]	; 0232C2AA
	ldr r2,[r5,#0x20]	; 0232C2AC
	str r2,[sp,#0x4]	; 0232C2AE
	sub r0,r0,r4	; 0232C2B0
	sbc r1,r6	; 0232C2B2
	ldr r2,[sp,#0x0]	; 0232C2B4
	ldr r3,[sp,#0x4]	; 0232C2B6
	blx loc_0232CAA4	; 0232C2B8
	str r0,[sp,#0x8]	; 0232C2BC
	add r7,r1,#0x0	; 0232C2BE
	ldr r0,[sp,#0x0]	; 0232C2C0
	ldr r1,[sp,#0x4]	; 0232C2C2
	mov r3,#0x1	; 0232C2C4
	ldr r2,[sp,#0x8]	; 0232C2C6
	add r3,r2,r3	; 0232C2C8
	mov r2,#0x0	; 0232C2CA
	adc r7,r2	; 0232C2CC
	add r2,r3,#0x0	; 0232C2CE
	add r3,r7,#0x0	; 0232C2D0
	blx P1_AeabiLmul	; 0232C2D2
	add r4,r4,r0	; 0232C2D6
	adc r6,r1	; 0232C2D8
loc_0232C2DA:
	str r4,[r5,#0xc]	; 0232C2DA
	str r6,[r5,#0x10]	; 0232C2DC
	ldr r0,[pool_0232C354]	; 0232C2DE
	ldr r3,[r0,#0x0]	; 0232C2E0
	cmp r3,#0x0	; 0232C2E2
	beq loc_0232C328	; 0232C2E4
loc_0232C2E6:
	ldr r1,[r3,#0xc]	; 0232C2E6
	ldr r0,[r3,#0x10]	; 0232C2E8
	sub r2,r4,r1	; 0232C2EA
	lsl r1,r6,#0	; 0232C2EC
	sbc r1,r0	; 0232C2EE
	mov r0,#0x0	; 0232C2F0
	sub r2,r2,r0	; 0232C2F2
	sbc r1,r0	; 0232C2F4
	bge loc_0232C322	; 0232C2F6
	ldr r0,[r3,#0x14]	; 0232C2F8
	str r0,[r5,#0x14]	; 0232C2FA
	str r5,[r3,#0x14]	; 0232C2FC
	str r3,[r5,#0x18]	; 0232C2FE
	ldr r0,[r5,#0x14]	; 0232C300
	cmp r0,#0x0	; 0232C302
	beq loc_0232C310	; 0232C304
	str r5,[r0,#0x18]	; 0232C306
	add sp,#0xc	; 0232C308
	pop {r4,r5,r6,r7}	; 0232C30A
	pop {r3}	; 0232C30C
	bx r3	; 0232C30E
loc_0232C310:
	ldr r0,[pool_0232C354]	; 0232C310
	str r5,[r0,#0x0]	; 0232C312
	add r0,r5,#0x0	; 0232C314
	bl loc_0232C390	; 0232C316
	add sp,#0xc	; 0232C31A
	pop {r4,r5,r6,r7}	; 0232C31C
	pop {r3}	; 0232C31E
	bx r3	; 0232C320
loc_0232C322:
	ldr r3,[r3,#0x18]	; 0232C322
	cmp r3,#0x0	; 0232C324
	bne loc_0232C2E6	; 0232C326
loc_0232C328:
	mov r0,#0x0	; 0232C328
	str r0,[r5,#0x18]	; 0232C32A
	ldr r0,[pool_0232C354]	; 0232C32C
	ldr r1,[r0,#0x4]	; 0232C32E
	str r5,[r0,#0x4]	; 0232C330
	str r1,[r5,#0x14]	; 0232C332
	cmp r1,#0x0	; 0232C334
	beq loc_0232C342	; 0232C336
	str r5,[r1,#0x18]	; 0232C338
	add sp,#0xc	; 0232C33A
	pop {r4,r5,r6,r7}	; 0232C33C
	pop {r3}	; 0232C33E
	bx r3	; 0232C340
loc_0232C342:
	str r5,[r0,#0x4]	; 0232C342
	str r5,[r0,#0x0]	; 0232C344
	add r0,r5,#0x0	; 0232C346
	bl loc_0232C390	; 0232C348
	add sp,#0xc	; 0232C34C
	pop {r4,r5,r6,r7}	; 0232C34E
	pop {r3}	; 0232C350
	bx r3	; 0232C352
pool_0232C354:
loc_0232C354:
	.word P1_BssStart + 0x2666C	; 0232C354
P1_Entry_0232C358:
	mov r1,#0x0	; 0232C358
	str r1,[r0,#0x0]	; 0232C35A
	str r1,[r0,#0x8]	; 0232C35C
	bx lr	; 0232C35E

; ===== function loc_0232C360 =====
P1_Entry_0232C360:
	push {lr}	; 0232C360
	sub sp,#0x4	; 0232C362
	ldr r1,[pool_0232C388]	; 0232C364
	ldrh r0,[r1,#0x0]	; 0232C366
	cmp r0,#0x0	; 0232C368
	bne loc_0232C382	; 0232C36A
	mov r0,#0x1	; 0232C36C
	strh r0,[r1,#0x0]	; 0232C36E
	bl loc_0232BF80	; 0232C370
	mov r1,#0x0	; 0232C374
	ldr r0,[pool_0232C38C]	; 0232C376
	str r1,[r0,#0x0]	; 0232C378
	str r1,[r0,#0x4]	; 0232C37A
	mov r0,#0x10	; 0232C37C
	bl loc_0232B0D8	; 0232C37E
loc_0232C382:
	add sp,#0x4	; 0232C382
	pop {r3}	; 0232C384
	bx r3	; 0232C386
pool_0232C388:
loc_0232C388:
	.word P1_BssStart + 0x26668	; 0232C388
pool_0232C38C:
loc_0232C38C:
	.word P1_BssStart + 0x2666C	; 0232C38C

; ===== function loc_0232C390 =====
loc_0232C390:
	push {r4,r5,lr}	; 0232C390
	sub sp,#0x4	; 0232C392
	add r4,r0,#0x0	; 0232C394
	bl loc_0232BF94	; 0232C396
	mov r2,#0x0	; 0232C39A
	ldr r3,[pool_0232C3E8]	; 0232C39C
	strh r2,[r3,#0x0]	; 0232C39E
	ldr r3,[r4,#0xc]	; 0232C3A0
	ldr r4,[r4,#0x10]	; 0232C3A2
	sub r5,r3,r0	; 0232C3A4
	sbc r4,r1	; 0232C3A6
	mov r0,#0x1	; 0232C3A8
	ldr r1,[pool_0232C3EC]	; 0232C3AA
	bl loc_0232B150	; 0232C3AC
	mov r1,#0x0	; 0232C3B0
	sub r0,r5,r1	; 0232C3B2
	lsl r0,r4,#0	; 0232C3B4
	sbc r0,r1	; 0232C3B6
	bge loc_0232C3BE	; 0232C3B8
	ldr r1,[pool_0232C3F0]	; 0232C3BA
	b loc_0232C3D0	; 0232C3BC
loc_0232C3BE:
	ldr r0,[pool_0232C3F4]	; 0232C3BE
	sub r0,r5,r0	; 0232C3C0
	sbc r4,r1	; 0232C3C2
	bge loc_0232C3CE	; 0232C3C4
	mvn r0,r5	; 0232C3C6
	lsl r0,r0,#0x10	; 0232C3C8
	lsr r1,r0,#0x10	; 0232C3CA
	b loc_0232C3D0	; 0232C3CC
loc_0232C3CE:
	mov r1,#0x0	; 0232C3CE
loc_0232C3D0:
	ldr r0,[pool_0232C3F8]	; 0232C3D0
	strh r1,[r0,#0x0]	; 0232C3D2
	mov r1,#0xc1	; 0232C3D4
	ldr r0,[pool_0232C3E8]	; 0232C3D6
	strh r1,[r0,#0x0]	; 0232C3D8
	mov r0,#0x10	; 0232C3DA
	bl loc_0232B100	; 0232C3DC
	add sp,#0x4	; 0232C3E0
	pop {r4,r5}	; 0232C3E2
	pop {r3}	; 0232C3E4
	bx r3	; 0232C3E6
pool_0232C3E8:
loc_0232C3E8:
	.word TIMER1_CR	; 0232C3E8
pool_0232C3EC:
loc_0232C3EC:
	.word 0x0232C0BC	; 0232C3EC
pool_0232C3F0:
loc_0232C3F0:
	.word 0x0000FFFE	; 0232C3F0
pool_0232C3F4:
loc_0232C3F4:
	.word 0x00010000	; 0232C3F4
pool_0232C3F8:
loc_0232C3F8:
	.word TIMER1_DATA	; 0232C3F8

; ===== function loc_0232C3FC =====
loc_0232C3FC:
	push {lr}	; 0232C3FC
	sub sp,#0x4	; 0232C3FE
	ldr r0,[pool_0232C42C]	; 0232C400
	ldrh r1,[r0,#0x0]	; 0232C402
	cmp r1,#0x0	; 0232C404
	bne loc_0232C424	; 0232C406
	mov r1,#0x1	; 0232C408
	strh r1,[r0,#0x0]	; 0232C40A
	mov r1,#0x0	; 0232C40C
	ldr r0,[pool_0232C430]	; 0232C40E
	str r1,[r0,#0x0]	; 0232C410
	str r1,[r0,#0x4]	; 0232C412
	mov r0,#0x4	; 0232C414
	bl loc_0232B0D8	; 0232C416
	mov r1,#0x0	; 0232C41A
	ldr r0,[pool_0232C434]	; 0232C41C
	str r1,[r0,#0x0]	; 0232C41E
	ldr r0,[pool_0232C438]	; 0232C420
	str r1,[r0,#0x0]	; 0232C422
loc_0232C424:
	add sp,#0x4	; 0232C424
	pop {r3}	; 0232C426
	bx r3	; 0232C428
	.byte 0xC0, 0x46	; 0232C42C
pool_0232C42C:
loc_0232C42C:
	.word P1_BssStart + 0x26674	; 0232C42C
pool_0232C430:
loc_0232C430:
	.word P1_BssStart + 0x26680	; 0232C430
pool_0232C434:
loc_0232C434:
	.word P1_BssStart + 0x2667C	; 0232C434
pool_0232C438:
loc_0232C438:
	.word P1_BssStart + 0x26678	; 0232C438
.arm

; ===== function loc_0232C43C =====
; Clears CPSR I and returns the former I mask. / 清除 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9EnableIrqReturnPriorMask
loc_0232C43C:
	mrs r0,cpsr	; 0232C43C
	bic r1,r0,#0x80	; 0232C440
	msr cpsr_c,r1	; 0232C444
	and r0,r0,#0x80	; 0232C448
	bx lr	; 0232C44C
.endfunc

; ===== function loc_0232C450 =====
; Sets CPSR I and returns the former I mask. / 设置 CPSR I 位并返回先前 I 掩码。
.func P1_Arm9DisableIrqReturnPriorMask
loc_0232C450:
	mrs r0,cpsr	; 0232C450
	orr r1,r0,#0x80	; 0232C454
	msr cpsr_c,r1	; 0232C458
	and r0,r0,#0x80	; 0232C45C
	bx lr	; 0232C460
.endfunc

; ===== function loc_0232C464 =====
; Restores CPSR I from r0 and returns the prior mask. / 按 r0 恢复 CPSR I 位并返回先前掩码。
.func P1_Arm9RestoreIrqMask
loc_0232C464:
	mrs r1,cpsr	; 0232C464
	bic r2,r1,#0x80	; 0232C468
	orr r2,r2,r0	; 0232C46C
	msr cpsr_c,r2	; 0232C470
	and r0,r1,#0x80	; 0232C474
	bx lr	; 0232C478
.endfunc

; ===== function loc_0232C47C =====
; Sets CPSR I/F and returns the former masks. / 设置 CPSR I/F 位并返回先前掩码。
.func P1_Arm9DisableIrqFiqReturnPriorMasks
loc_0232C47C:
	mrs r0,cpsr	; 0232C47C
	orr r1,r0,#0xc0	; 0232C480
	msr cpsr_c,r1	; 0232C484
	and r0,r0,#0xc0	; 0232C488
	bx lr	; 0232C48C
.endfunc

; ===== function loc_0232C490 =====
; Restores CPSR I/F from r0 and returns prior masks. / 按 r0 恢复 CPSR I/F 位并返回先前掩码。
.func P1_Arm9RestoreIrqFiqMasks
loc_0232C490:
	mrs r1,cpsr	; 0232C490
	bic r2,r1,#0xc0	; 0232C494
	orr r2,r2,r0	; 0232C498
	msr cpsr_c,r2	; 0232C49C
	and r0,r1,#0xc0	; 0232C4A0
	bx lr	; 0232C4A4
.endfunc

; ===== function loc_0232C4A8 =====
; Returns the CPSR processor-mode bits. / 返回 CPSR 的处理器模式位。
.func P1_Arm9GetProcessorMode
loc_0232C4A8:
	mrs r0,cpsr	; 0232C4A8
	and r0,r0,#0x1f	; 0232C4AC
	bx lr	; 0232C4B0
.endfunc

; ===== function loc_0232C4B4 =====
; ARM946 CP15 wait-for-interrupt helper. / ARM946 CP15 等待中断帮助例程。
.func P1_Arm9WaitForInterrupt
loc_0232C4B4:
	mov r0,#0x0	; 0232C4B4
	mcr p15,0x0,r0,c7,c0,0x4	; 0232C4B8
	bx lr	; 0232C4BC
.endfunc

; ===== function loc_0232C4C0 =====
; Decrements r0 by four until borrow. / 每次将 r0 减四，直至产生借位。
.func P1_Arm9BusyWaitByLoop4
loc_0232C4C0:
	subs r0,r0,#0x4	; 0232C4C0
	bcs loc_0232C4C0	; 0232C4C4
	bx lr	; 0232C4C8
.endfunc
.thumb

; ===== function loc_0232C4CC =====
loc_0232C4CC:
	push {lr}	; 0232C4CC
	sub sp,#0x4	; 0232C4CE
loc_0232C4D0:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C4D0
	blx P1_Arm9WaitForInterrupt	; 0232C4D4
	b loc_0232C4D0	; 0232C4D8
	.byte 0x00, 0x00, 0x01, 0x1C, 0x02, 0x48, 0x06, 0x22, 0x02, 0x4B, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFC	; 0232C4EA
	.byte 0x7F, 0x02, 0xA8, 0xDE, 0x32, 0x02	; 0232C4F0

; ===== function loc_0232C4F0 =====
loc_0232C4F0:
	push {r4,lr}	; 0232C4F0
	add r4,r1,#0x0	; 0232C4F2
	ldr r1,[r4,#0x0]	; 0232C4F4
	cmp r1,#0x0	; 0232C4F6
	bne loc_0232C4FE	; 0232C4F8
	bl loc_0232B1F4	; 0232C4FA
loc_0232C4FE:
	ldr r0,[r4,#0x4]	; 0232C4FE
	blx P1_Arm9RestoreIrqMask	; 0232C500
	pop {r4}	; 0232C504
	pop {r3}	; 0232C506
	bx r3	; 0232C508
	.byte 0x00, 0x00	; 0232C50C

; ===== function loc_0232C50C =====
loc_0232C50C:
	push {r4,r5,r6,r7,lr}	; 0232C50C
	sub sp,#0x4	; 0232C50E
	add r5,r0,#0x0	; 0232C510
	add r4,r1,#0x0	; 0232C512
	ldr r7,[pool_0232C550]	; 0232C514
	mov r6,#0x40	; 0232C516
loc_0232C518:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232C518
	str r0,[r4,#0x4]	; 0232C51C
	add r0,r7,#0x0	; 0232C51E
	bl loc_0232B29C	; 0232C520
	and r0,r6	; 0232C524
	str r0,[r4,#0x0]	; 0232C526
	ldr r0,[r4,#0x0]	; 0232C528
	cmp r0,#0x0	; 0232C52A
	bne loc_0232C546	; 0232C52C
	add r0,r5,#0x0	; 0232C52E
	bl loc_0232B324	; 0232C530
	cmp r0,#0x0	; 0232C534
	beq loc_0232C546	; 0232C536
	ldr r0,[r4,#0x4]	; 0232C538
	blx P1_Arm9RestoreIrqMask	; 0232C53A
	mov r0,#0x1	; 0232C53E
	bl loc_0232C74C	; 0232C540
	b loc_0232C518	; 0232C544
loc_0232C546:
	add sp,#0x4	; 0232C546
	pop {r4,r5,r6,r7}	; 0232C548
	pop {r3}	; 0232C54A
	bx r3	; 0232C54C
	.byte 0xC0, 0x46	; 0232C550
pool_0232C550:
loc_0232C550:
	.word 0x027FFFE8	; 0232C550

; ===== function loc_0232C554 =====
loc_0232C554:
	push {r4}	; 0232C554
	sub sp,#0x4	; 0232C556
	ldr r4,[r0,#0x0]	; 0232C558
	ldr r3,[pool_0232C57C]	; 0232C55A
	ldrh r2,[r3,#0x0]	; 0232C55C
	mov r1,#0xc	; 0232C55E
	bic r2,r1	; 0232C560
	lsl r1,r4,#0x2	; 0232C562
	orr r2,r1	; 0232C564
	strh r2,[r3,#0x0]	; 0232C566
	ldr r2,[r0,#0x4]	; 0232C568
	ldrh r1,[r3,#0x0]	; 0232C56A
	mov r0,#0x10	; 0232C56C
	bic r1,r0	; 0232C56E
	lsl r0,r2,#0x4	; 0232C570
	orr r1,r0	; 0232C572
	strh r1,[r3,#0x0]	; 0232C574
	add sp,#0x4	; 0232C576
	pop {r4}	; 0232C578
	bx lr	; 0232C57A
pool_0232C57C:
loc_0232C57C:
	.word REG_EXMEMCNT_ARM9	; 0232C57C

; ===== function loc_0232C580 =====
loc_0232C580:
	push {r4}	; 0232C580
	sub sp,#0x4	; 0232C582
	ldr r4,[pool_0232C5B0]	; 0232C584
	ldrh r2,[r4,#0x0]	; 0232C586
	mov r1,#0xc	; 0232C588
	and r2,r1	; 0232C58A
	asr r2,r2,#0x2	; 0232C58C
	str r2,[r0,#0x0]	; 0232C58E
	ldrh r3,[r4,#0x0]	; 0232C590
	mov r2,#0x10	; 0232C592
	and r3,r2	; 0232C594
	asr r3,r3,#0x4	; 0232C596
	str r3,[r0,#0x4]	; 0232C598
	ldrh r0,[r4,#0x0]	; 0232C59A
	bic r0,r1	; 0232C59C
	orr r0,r1	; 0232C59E
	strh r0,[r4,#0x0]	; 0232C5A0
	ldrh r0,[r4,#0x0]	; 0232C5A2
	bic r0,r2	; 0232C5A4
	strh r0,[r4,#0x0]	; 0232C5A6
	add sp,#0x4	; 0232C5A8
	pop {r4}	; 0232C5AA
	bx lr	; 0232C5AC
	.byte 0xC0, 0x46	; 0232C5B0
pool_0232C5B0:
loc_0232C5B0:
	.word REG_EXMEMCNT_ARM9	; 0232C5B0

; ===== function loc_0232C5B4 =====
loc_0232C5B4:
	push {r4,lr}	; 0232C5B4
	sub sp,#0x10	; 0232C5B6
	mov r4,#0x1	; 0232C5B8
	ldr r2,[pool_0232C658]	; 0232C5BA
	ldrh r1,[r2,#0x0]	; 0232C5BC
	ldr r0,[pool_0232C65C]	; 0232C5BE
	cmp r1,r0	; 0232C5C0
	bne loc_0232C5CE	; 0232C5C2
	mov r0,#0x0	; 0232C5C4
	add sp,#0x10	; 0232C5C6
	pop {r4}	; 0232C5C8
	pop {r3}	; 0232C5CA
	bx r3	; 0232C5CC
loc_0232C5CE:
	ldrb r0,[r2,#0x5]	; 0232C5CE
	lsl r0,r0,#0x1e	; 0232C5D0
	lsr r0,r0,#0x1f	; 0232C5D2
	cmp r0,#0x1	; 0232C5D4
	bne loc_0232C5E2	; 0232C5D6
	mov r0,#0x0	; 0232C5D8
	add sp,#0x10	; 0232C5DA
	pop {r4}	; 0232C5DC
	pop {r3}	; 0232C5DE
	bx r3	; 0232C5E0
loc_0232C5E2:
	ldr r0,[pool_0232C660]	; 0232C5E2
	ldrh r0,[r0,#0x2]	; 0232C5E4
	add r1,sp,#0x0	; 0232C5E6
	bl loc_0232C50C	; 0232C5E8
	add r0,sp,#0x8	; 0232C5EC
	bl loc_0232C580	; 0232C5EE
	ldr r2,[pool_0232C664]	; 0232C5F2
	add r0,r2,#0x0	; 0232C5F4
	add r0,#0xb2	; 0232C5F6
	ldrb r3,[r0,#0x0]	; 0232C5F8
	cmp r3,#0x96	; 0232C5FA
	bne loc_0232C60A	; 0232C5FC
	ldr r0,[pool_0232C658]	; 0232C5FE
	ldrh r1,[r0,#0x0]	; 0232C600
	add r2,#0xbe	; 0232C602
	ldrh r0,[r2,#0x0]	; 0232C604
	cmp r1,r0	; 0232C606
	bne loc_0232C632	; 0232C608
loc_0232C60A:
	cmp r3,#0x96	; 0232C60A
	beq loc_0232C61A	; 0232C60C
	ldr r0,[pool_0232C658]	; 0232C60E
	ldrh r1,[r0,#0x0]	; 0232C610
	ldr r0,[pool_0232C668]	; 0232C612
	ldrh r0,[r0,#0x0]	; 0232C614
	cmp r1,r0	; 0232C616
	bne loc_0232C632	; 0232C618
loc_0232C61A:
	ldr r2,[pool_0232C658]	; 0232C61A
	ldr r1,[r2,#0x8]	; 0232C61C
	ldr r0,[pool_0232C664]	; 0232C61E
	add r0,#0xac	; 0232C620
	ldr r0,[r0,#0x0]	; 0232C622
	cmp r1,r0	; 0232C624
	beq loc_0232C63E	; 0232C626
	ldrb r0,[r2,#0x5]	; 0232C628
	lsl r0,r0,#0x1f	; 0232C62A
	lsr r0,r0,#0x1f	; 0232C62C
	cmp r0,#0x0	; 0232C62E
	beq loc_0232C63E	; 0232C630
loc_0232C632:
	ldr r2,[pool_0232C658]	; 0232C632
	ldrb r1,[r2,#0x5]	; 0232C634
	mov r0,#0x2	; 0232C636
	orr r1,r0	; 0232C638
	strb r1,[r2,#0x5]	; 0232C63A
	mov r4,#0x0	; 0232C63C
loc_0232C63E:
	add r0,sp,#0x8	; 0232C63E
	bl loc_0232C554	; 0232C640
	ldr r0,[pool_0232C660]	; 0232C644
	ldrh r0,[r0,#0x2]	; 0232C646
	add r1,sp,#0x0	; 0232C648
	bl loc_0232C4F0	; 0232C64A
	add r0,r4,#0x0	; 0232C64E
	add sp,#0x10	; 0232C650
	pop {r4}	; 0232C652
	pop {r3}	; 0232C654
	bx r3	; 0232C656
pool_0232C658:
loc_0232C658:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C658
pool_0232C65C:
loc_0232C65C:
	.word 0x0000FFFF	; 0232C65C
pool_0232C660:
loc_0232C660:
	.word P1_BssStart + 0x26688	; 0232C660
pool_0232C664:
loc_0232C664:
	.word Slot2BusBaseAddress	; 0232C664
pool_0232C668:
loc_0232C668:
	.word Slot2BusBaseAddress + 0x1FFFE	; 0232C668

; ===== function loc_0232C66C =====
loc_0232C66C:
	push {lr}	; 0232C66C
	sub sp,#0x4	; 0232C66E
	ldr r2,[pool_0232C6A0]	; 0232C670
	ldrh r1,[r2,#0x0]	; 0232C672
	ldr r0,[pool_0232C6A4]	; 0232C674
	cmp r1,r0	; 0232C676
	bne loc_0232C682	; 0232C678
	mov r0,#0x0	; 0232C67A
	add sp,#0x4	; 0232C67C
	pop {r3}	; 0232C67E
	bx r3	; 0232C680
loc_0232C682:
	ldrb r0,[r2,#0x5]	; 0232C682
	lsl r0,r0,#0x1e	; 0232C684
	lsr r0,r0,#0x1f	; 0232C686
	cmp r0,#0x0	; 0232C688
	bne loc_0232C690	; 0232C68A
	bl loc_0232C5B4	; 0232C68C
loc_0232C690:
	ldr r0,[pool_0232C6A0]	; 0232C690
	ldrb r0,[r0,#0x5]	; 0232C692
	lsl r0,r0,#0x1e	; 0232C694
	lsr r0,r0,#0x1f	; 0232C696
	add sp,#0x4	; 0232C698
	pop {r3}	; 0232C69A
	bx r3	; 0232C69C
	.byte 0xC0, 0x46	; 0232C6A0
pool_0232C6A0:
loc_0232C6A0:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C6A0
pool_0232C6A4:
loc_0232C6A4:
	.word 0x0000FFFF	; 0232C6A4

; ===== function loc_0232C6A8 =====
loc_0232C6A8:
	push {r4}	; 0232C6A8
	sub sp,#0x4	; 0232C6AA
	mov r4,#0x0	; 0232C6AC
	ldr r3,[pool_0232C6D0]	; 0232C6AE
	ldrh r2,[r3,#0x0]	; 0232C6B0
	ldr r1,[pool_0232C6D4]	; 0232C6B2
	cmp r2,r1	; 0232C6B4
	beq loc_0232C6C8	; 0232C6B6
	cmp r2,#0x0	; 0232C6B8
	beq loc_0232C6C8	; 0232C6BA
	ldrb r1,[r3,#0x0]	; 0232C6BC
	mvn r1,r1	; 0232C6BE
	and r1,r0	; 0232C6C0
	cmp r1,#0x0	; 0232C6C2
	beq loc_0232C6C8	; 0232C6C4
	mov r4,#0x1	; 0232C6C6
loc_0232C6C8:
	add r0,r4,#0x0	; 0232C6C8
	add sp,#0x4	; 0232C6CA
	pop {r4}	; 0232C6CC
	bx lr	; 0232C6CE
pool_0232C6D0:
loc_0232C6D0:
	.word FirmwareBootInfoAddress + BootInfoGbaIdOffset	; 0232C6D0
pool_0232C6D4:
loc_0232C6D4:
	.word 0x0000FFFF	; 0232C6D4

; ===== function loc_0232C6D8 =====
loc_0232C6D8:
	push {r4,lr}	; 0232C6D8
	add r4,r0,#0x0	; 0232C6DA
	bl loc_0232C5B4	; 0232C6DC
	cmp r0,#0x0	; 0232C6E0
	beq loc_0232C6F6	; 0232C6E2
	add r0,r4,#0x0	; 0232C6E4
	bl loc_0232C6A8	; 0232C6E6
	cmp r0,#0x0	; 0232C6EA
	beq loc_0232C6F6	; 0232C6EC
	mov r0,#0x1	; 0232C6EE
	pop {r4}	; 0232C6F0
	pop {r3}	; 0232C6F2
	bx r3	; 0232C6F4
loc_0232C6F6:
	mov r0,#0x0	; 0232C6F6
	pop {r4}	; 0232C6F8
	pop {r3}	; 0232C6FA
	bx r3	; 0232C6FC
	.byte 0x00, 0x00	; 0232C700

; ===== function loc_0232C700 =====
loc_0232C700:
	push {lr}	; 0232C700
	sub sp,#0x4	; 0232C702
	mov r0,#0x0	; 0232C704
	str r0,[sp,#0x0]	; 0232C706
	add r0,sp,#0x0	; 0232C708
	ldr r1,[pool_0232C720]	; 0232C70A
	ldr r2,[pool_0232C724]	; 0232C70C
	bl loc_0232C76A	; 0232C70E
	blx loc_0232B204	; 0232C712
	ldr r1,[pool_0232C720]	; 0232C716
	strh r0,[r1,#0x2]	; 0232C718
	add sp,#0x4	; 0232C71A
	pop {r3}	; 0232C71C
	bx r3	; 0232C71E
pool_0232C720:
loc_0232C720:
	.word P1_BssStart + 0x26688	; 0232C720
pool_0232C724:
loc_0232C724:
	.word 0x05000001	; 0232C724

; ===== function loc_0232C728 =====
loc_0232C728:
	push {lr}	; 0232C728
	sub sp,#0x4	; 0232C72A
	ldr r0,[pool_0232C744]	; 0232C72C
	ldr r1,[r0,#0x0]	; 0232C72E
	cmp r1,#0x0	; 0232C730
	bne loc_0232C73C	; 0232C732
	mov r1,#0x1	; 0232C734
	str r1,[r0,#0x0]	; 0232C736
	bl loc_0232C700	; 0232C738
loc_0232C73C:
	add sp,#0x4	; 0232C73C
	pop {r3}	; 0232C73E
	bx r3	; 0232C740
	.byte 0xC0, 0x46	; 0232C744
pool_0232C744:
loc_0232C744:
	.word P1_BssStart + 0x2668C	; 0232C744
	.byte 0x00, 0xDF, 0x70, 0x47	; 0232C74C

; ===== function loc_0232C74C =====
.func P1_SwiWaitByLoop
; BIOS SWI #03: busy-loop delay. / BIOS SWI #03：忙等待延时。
loc_0232C74C:
	swi 0x3	; 0232C74C
	bx lr	; 0232C74E
.endfunc
	.byte 0x00, 0x22, 0x04, 0xDF, 0x70, 0x47	; 0232C756

; ===== function loc_0232C756 =====
.func P1_SwiVBlankIntrWait
; BIOS SWI #05: wait for VBlank IRQ. / BIOS SWI #05：等待 VBlank 中断。
loc_0232C756:
	mov r2,#0x0	; 0232C756
	swi 0x5	; 0232C758
	bx lr	; 0232C75A
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

; ===== function loc_0232C76A =====
.func P1_SwiCpuSet
; BIOS SWI #0B: CpuSet copy/fill. / BIOS SWI #0B：CpuSet 复制/填充。
loc_0232C76A:
	swi 0xb	; 0232C76A
	bx lr	; 0232C76C
.endfunc

; ===== function loc_0232C76E =====
.func P1_SwiCpuFastSet
; BIOS SWI #0C: CpuFastSet copy/fill. / BIOS SWI #0C：CpuFastSet 复制/填充。
loc_0232C76E:
	swi 0xc	; 0232C76E
	bx lr	; 0232C770
.endfunc
.func P1_SwiSqrt
; BIOS SWI #0D: integer square root. / BIOS SWI #0D：整数平方根。
	swi 0xd
	bx lr
.endfunc

; ===== function P1_SwiGetCrc16 =====
.func P1_SwiGetCrc16
; BIOS SWI #0E: CRC-16 service. / BIOS SWI #0E：CRC-16 服务。
loc_0232C776:
	swi 0xe	; 0232C776
	bx lr	; 0232C778
.endfunc
.func P1_SwiIsDebugger
; BIOS SWI #0F: detect debugger state. / BIOS SWI #0F：检测调试器状态。
	swi 0x0f
	bx lr
.endfunc

; ===== function loc_0232C77E =====
.func P1_SwiBitUnPack
; BIOS SWI #10: BitUnPack decoder. / BIOS SWI #10：BitUnPack 解码器。
loc_0232C77E:
	swi 0x10	; 0232C77E
	bx lr	; 0232C780
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

; ===== function loc_0232C78A =====
.func P1_SwiHuffUnComp
; BIOS SWI #13: Huffman decoder. / BIOS SWI #13：Huffman 解码器。
loc_0232C78A:
	swi 0x13	; 0232C78A
	bx lr	; 0232C78C
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
loc_0232C798:
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
loc_0232C80C:
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
loc_0232C8E8:
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x10, 0xB4, 0x81, 0xB0, 0x00, 0x2A, 0x17, 0xD0, 0x04, 0x78, 0x40, 0x1C	; 0232C8F8
	.byte 0x0B, 0x78, 0x49, 0x1C, 0x9C, 0x42, 0x0E, 0xD0, 0x40, 0x1E, 0x02, 0x78, 0x48, 0x1E, 0x00, 0x78	; 0232C908
	.byte 0x82, 0x42, 0x04, 0xD2, 0x00, 0x20, 0xC0, 0x43, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x01, 0x20	; 0232C918
	.byte 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x52, 0x1E, 0x00, 0x2A, 0xE7, 0xD1, 0x00, 0x20, 0x01, 0xB0	; 0232C928
	.byte 0x10, 0xBC, 0x70, 0x47	; 0232C92C

; Standard memset: fill r2 bytes at r0 with low byte of r1 and return original r0.
; 标准 memset：以 r1 低字节填充 r0 起始的 r2 字节，并返回原 r0。
P1_MemSet:
; ===== function loc_0232C92C =====
	push {r4,lr}	; 0232C92C
	add r4,r0,#0x0	; 0232C92E
	bl P1_MemSetCore	; 0232C930
	add r0,r4,#0x0	; 0232C934
	pop {r4}	; 0232C936
	pop {r3}	; 0232C938
	bx r3	; 0232C93A

; ===== function loc_0232C93C =====
; Core byte/word fill loop; r0 advances to the end. / 核心字节/字填充循环；r0 前进至末尾。
P1_MemSetCore:
loc_0232C93C:
	push {r4,r5}	; 0232C93C
	lsl r1,r1,#0x18	; 0232C93E
	lsr r1,r1,#0x18	; 0232C940
	cmp r2,#0x20	; 0232C942
	bcc loc_0232C9AA	; 0232C944
	neg r4,r0	; 0232C946
	mov r3,#0x3	; 0232C948
	and r4,r3	; 0232C94A
	cmp r4,#0x0	; 0232C94C
	beq loc_0232C960	; 0232C94E
	sub r2,r2,r4	; 0232C950
	lsl r3,r1,#0x18	; 0232C952
	lsr r3,r3,#0x18	; 0232C954
loc_0232C956:
	strb r3,[r0,#0x0]	; 0232C956
	add r0,r0,#0x1	; 0232C958
	sub r4,r4,#0x1	; 0232C95A
	cmp r4,#0x0	; 0232C95C
	bne loc_0232C956	; 0232C95E
loc_0232C960:
	cmp r1,#0x0	; 0232C960
	beq loc_0232C970	; 0232C962
	lsl r5,r1,#0x8	; 0232C964
	lsl r4,r1,#0x18	; 0232C966
	lsl r3,r1,#0x10	; 0232C968
	orr r4,r3	; 0232C96A
	orr r5,r4	; 0232C96C
	orr r1,r5	; 0232C96E
loc_0232C970:
	lsr r4,r2,#0x5	; 0232C970
	cmp r4,#0x0	; 0232C972
	beq loc_0232C992	; 0232C974
loc_0232C976:
	str r1,[r0,#0x0]	; 0232C976
	str r1,[r0,#0x4]	; 0232C978
	str r1,[r0,#0x8]	; 0232C97A
	str r1,[r0,#0xc]	; 0232C97C
	str r1,[r0,#0x10]	; 0232C97E
	str r1,[r0,#0x14]	; 0232C980
	str r1,[r0,#0x18]	; 0232C982
	add r3,r0,#0x0	; 0232C984
	add r3,#0x1c	; 0232C986
	add r0,#0x20	; 0232C988
	str r1,[r3,#0x0]	; 0232C98A
	sub r4,r4,#0x1	; 0232C98C
	cmp r4,#0x0	; 0232C98E
	bne loc_0232C976	; 0232C990
loc_0232C992:
	mov r3,#0x1f	; 0232C992
	add r4,r2,#0x0	; 0232C994
	and r4,r3	; 0232C996
	lsr r3,r4,#0x2	; 0232C998
	cmp r3,#0x0	; 0232C99A
	beq loc_0232C9A6	; 0232C99C
loc_0232C99E:
	stmia r0!,{r1}	; 0232C99E
	sub r3,r3,#0x1	; 0232C9A0
	cmp r3,#0x0	; 0232C9A2
	bne loc_0232C99E	; 0232C9A4
loc_0232C9A6:
	mov r3,#0x3	; 0232C9A6
	and r2,r3	; 0232C9A8
loc_0232C9AA:
	cmp r2,#0x0	; 0232C9AA
	beq loc_0232C9BC	; 0232C9AC
	lsl r1,r1,#0x18	; 0232C9AE
	lsr r1,r1,#0x18	; 0232C9B0
loc_0232C9B2:
	strb r1,[r0,#0x0]	; 0232C9B2
	add r0,r0,#0x1	; 0232C9B4
	sub r2,r2,#0x1	; 0232C9B6
	cmp r2,#0x0	; 0232C9B8
	bne loc_0232C9B2	; 0232C9BA
loc_0232C9BC:
	pop {r4,r5}	; 0232C9BC
	bx lr	; 0232C9BE

; UTF-16 strchr: find a code unit, including the terminating NUL. / UTF-16 strchr：查找码元，包括结尾 NUL。
P1_Utf16StrChr:
; ===== function loc_0232C9C0 =====
loc_0232C9C0:
	add r2,r0,#0x2	; 0232C9C0
	ldrh r0,[r0,#0x0]	; 0232C9C2
	cmp r0,#0x0	; 0232C9C4
	beq loc_0232C9D8	; 0232C9C6
loc_0232C9C8:
	cmp r0,r1	; 0232C9C8
	bne loc_0232C9D0	; 0232C9CA
	sub r0,r2,#0x2	; 0232C9CC
	bx lr	; 0232C9CE
loc_0232C9D0:
	ldrh r0,[r2,#0x0]	; 0232C9D0
	add r2,r2,#0x2	; 0232C9D2
	cmp r0,#0x0	; 0232C9D4
	bne loc_0232C9C8	; 0232C9D6
loc_0232C9D8:
	cmp r1,#0x0	; 0232C9D8
	beq loc_0232C9E0	; 0232C9DA
	mov r0,#0x0	; 0232C9DC
	bx lr	; 0232C9DE
loc_0232C9E0:
	sub r0,r2,#0x2	; 0232C9E0
	bx lr	; 0232C9E2

; UTF-16 bounded comparison. / UTF-16 定长字符串比较。
P1_Utf16StrNCmp:
; ===== function loc_0232C9E4 =====
	push {r4}	; 0232C9E4
	sub sp,#0x4	; 0232C9E6
	cmp r2,#0x0	; 0232C9E8
	beq loc_0232CA0A	; 0232C9EA
loc_0232C9EC:
	ldrh r4,[r1,#0x0]	; 0232C9EC
	add r1,r1,#0x2	; 0232C9EE
	ldrh r3,[r0,#0x0]	; 0232C9F0
	add r0,r0,#0x2	; 0232C9F2
	cmp r3,r4	; 0232C9F4
	beq loc_0232CA00	; 0232C9F6
	sub r0,r3,r4	; 0232C9F8
	add sp,#0x4	; 0232C9FA
	pop {r4}	; 0232C9FC
	bx lr	; 0232C9FE
loc_0232CA00:
	cmp r3,#0x0	; 0232CA00
	beq loc_0232CA0A	; 0232CA02
	sub r2,r2,#0x1	; 0232CA04
	cmp r2,#0x0	; 0232CA06
	bne loc_0232C9EC	; 0232CA08
loc_0232CA0A:
	mov r0,#0x0	; 0232CA0A
	add sp,#0x4	; 0232CA0C
	pop {r4}	; 0232CA0E
	bx lr	; 0232CA10
	.byte 0x00, 0x00, 0x10, 0xB4, 0x81, 0xB0, 0x04, 0x1C, 0x22, 0x88, 0xA4, 0x1C, 0x00, 0x2A, 0xFB, 0xD1	; 0232CA22
	.byte 0xA4, 0x1E, 0x23, 0x1C, 0x0A, 0x88, 0x89, 0x1C, 0x22, 0x80, 0xA4, 0x1C, 0x1A, 0x88, 0x00, 0x2A	; 0232CA32
	.byte 0xF7, 0xD1, 0x01, 0xB0, 0x10, 0xBC, 0x70, 0x47, 0x00, 0x00	; 0232CA3C

; UTF-16 bounded copy with NUL padding. / UTF-16 定长复制，结尾不足时补 NUL。
P1_Utf16StrNCpy:
; ===== function loc_0232CA3C =====
loc_0232CA3C:
	push {r4,r5}	; 0232CA3C
	add r5,r0,#0x0	; 0232CA3E
	cmp r2,#0x0	; 0232CA40
	beq loc_0232CA70	; 0232CA42
loc_0232CA44:
	add r4,r5,#0x0	; 0232CA44
	ldrh r3,[r1,#0x0]	; 0232CA46
	add r1,r1,#0x2	; 0232CA48
	strh r3,[r5,#0x0]	; 0232CA4A
	add r5,r5,#0x2	; 0232CA4C
	ldrh r3,[r4,#0x0]	; 0232CA4E
	cmp r3,#0x0	; 0232CA50
	bne loc_0232CA6A	; 0232CA52
	sub r2,r2,#0x1	; 0232CA54
	cmp r2,#0x0	; 0232CA56
	beq loc_0232CA70	; 0232CA58
	mov r1,#0x0	; 0232CA5A
loc_0232CA5C:
	strh r1,[r5,#0x0]	; 0232CA5C
	add r5,r5,#0x2	; 0232CA5E
	sub r2,r2,#0x1	; 0232CA60
	cmp r2,#0x0	; 0232CA62
	bne loc_0232CA5C	; 0232CA64
	pop {r4,r5}	; 0232CA66
	bx lr	; 0232CA68
loc_0232CA6A:
	sub r2,r2,#0x1	; 0232CA6A
	cmp r2,#0x0	; 0232CA6C
	bne loc_0232CA44	; 0232CA6E
loc_0232CA70:
	pop {r4,r5}	; 0232CA70
	bx lr	; 0232CA72

; UTF-16 unbounded copy through the terminating NUL. / UTF-16 复制，直至结尾 NUL。
P1_Utf16StrCpy:
; ===== function loc_0232CA74 =====
loc_0232CA74:
	push {r4}	; 0232CA74
	sub sp,#0x4	; 0232CA76
	add r4,r0,#0x0	; 0232CA78
loc_0232CA7A:
	add r3,r4,#0x0	; 0232CA7A
	ldrh r2,[r1,#0x0]	; 0232CA7C
	add r1,r1,#0x2	; 0232CA7E
	strh r2,[r4,#0x0]	; 0232CA80
	add r4,r4,#0x2	; 0232CA82
	ldrh r2,[r3,#0x0]	; 0232CA84
	cmp r2,#0x0	; 0232CA86
	bne loc_0232CA7A	; 0232CA88
	add sp,#0x4	; 0232CA8A
	pop {r4}	; 0232CA8C
	bx lr	; 0232CA8E
; UTF-16 strlen: count code units before the terminating NUL. / UTF-16 strlen：统计结尾 NUL 前的码元数。
P1_Utf16StrLen:
; ===== function loc_0232CA90 =====
loc_0232CA90:
	mov r1,#0x0	; 0232CA90
	mvn r2,r1	; 0232CA92
loc_0232CA94:
	add r2,r2,#0x1	; 0232CA94
	ldrh r1,[r0,#0x0]	; 0232CA96
	add r0,r0,#0x2	; 0232CA98
	cmp r1,#0x0	; 0232CA9A
	bne loc_0232CA94	; 0232CA9C
	add r0,r2,#0x0	; 0232CA9E
	bx lr	; 0232CAA0
	.hword 0x0000	; padding / 对齐填充。
.arm

; ===== function loc_0232CAA4 =====
loc_0232CAA4:
	stmdb sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CAA4
	mov r4,#0x0	; 0232CAA8
	b loc_0232CAB8	; 0232CAAC
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE3	; 0232CAB8
loc_0232CAB8:
	orrs r5,r3,r2	; 0232CAB8
	bne loc_0232CAC8	; 0232CABC
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CAC0
	bx lr	; 0232CAC4
loc_0232CAC8:
	orrs r5,r1,r3	; 0232CAC8
	bne loc_0232CB70	; 0232CACC
	mov r1,r2	; 0232CAD0
	bl loc_0232CEE0	; 0232CAD4
	cmp r4,#0x0	; 0232CAD8
	movne r0,r1	; 0232CADC
	mov r1,#0x0	; 0232CAE0
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CAE4
	bx lr	; 0232CAE8
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x01, 0x40, 0xA0, 0xE1, 0x01, 0x40, 0x84, 0xE3, 0x03, 0x00, 0x00, 0xEA	; 0232CAFC
	.byte 0xF0, 0x58, 0x2D, 0xE9, 0x03, 0x40, 0x21, 0xE0, 0xC4, 0x40, 0xA0, 0xE1, 0x84, 0x40, 0xA0, 0xE1	; 0232CB0C
	.byte 0x02, 0x50, 0x93, 0xE1, 0x01, 0x00, 0x00, 0x1A, 0xF0, 0x58, 0xBD, 0xE8, 0x1E, 0xFF, 0x2F, 0xE1	; 0232CB1C
	.byte 0xA0, 0x5F, 0xA0, 0xE1, 0x01, 0x50, 0x85, 0xE0, 0xA2, 0x6F, 0xA0, 0xE1, 0x03, 0x60, 0x86, 0xE0	; 0232CB2C
	.byte 0x06, 0x60, 0x95, 0xE1, 0x06, 0x00, 0x00, 0x1A, 0x02, 0x10, 0xA0, 0xE1, 0x63, 0x00, 0x00, 0xEB	; 0232CB3C
	.byte 0x01, 0x40, 0x14, 0xE2, 0x01, 0x00, 0xA0, 0x11, 0xC0, 0x1F, 0xA0, 0xE1, 0xF0, 0x58, 0xBD, 0xE8	; 0232CB4C
	.byte 0x1E, 0xFF, 0x2F, 0xE1, 0x00, 0x00, 0x51, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x00, 0x70, 0xE2	; 0232CB5C
	.byte 0x00, 0x10, 0xE1, 0xE2, 0x00, 0x00, 0x53, 0xE3, 0x01, 0x00, 0x00, 0xAA, 0x00, 0x20, 0x72, 0xE2	; 0232CB6C
	.byte 0x00, 0x30, 0xE3, 0xE2	; 0232CB70
loc_0232CB70:
	orrs r5,r1,r0	; 0232CB70
	beq loc_0232CC94	; 0232CB74
	mov r5,#0x0	; 0232CB78
	mov r6,#0x1	; 0232CB7C
	cmp r3,#0x0	; 0232CB80
	bmi loc_0232CB9C	; 0232CB84
loc_0232CB88:
	add r5,r5,#0x1	; 0232CB88
	adds r2,r2,r2	; 0232CB8C
	adcs r3,r3,r3	; 0232CB90
	bpl loc_0232CB88	; 0232CB94
	add r6,r6,r5	; 0232CB98
loc_0232CB9C:
	cmp r1,#0x0	; 0232CB9C
	blt loc_0232CBBC	; 0232CBA0
loc_0232CBA4:
	cmp r6,#0x1	; 0232CBA4
	beq loc_0232CBBC	; 0232CBA8
	sub r6,r6,#0x1	; 0232CBAC
	adds r0,r0,r0	; 0232CBB0
	adcs r1,r1,r1	; 0232CBB4
	bpl loc_0232CBA4	; 0232CBB8
loc_0232CBBC:
	mov r7,#0x0	; 0232CBBC
	mov r12,#0x0	; 0232CBC0
	mov r11,#0x0	; 0232CBC4
	b loc_0232CBE4	; 0232CBC8
loc_0232CBCC:
	orr r12,r12,#0x1	; 0232CBCC
	subs r6,r6,#0x1	; 0232CBD0
	beq loc_0232CC3C	; 0232CBD4
	adds r0,r0,r0	; 0232CBD8
	adcs r1,r1,r1	; 0232CBDC
	adcs r7,r7,r7	; 0232CBE0
loc_0232CBE4:
	subs r0,r0,r2	; 0232CBE4
	sbcs r1,r1,r3	; 0232CBE8
	sbcs r7,r7,#0x0	; 0232CBEC
	adds r12,r12,r12	; 0232CBF0
	adc r11,r11,r11	; 0232CBF4
	cmp r7,#0x0	; 0232CBF8
	bge loc_0232CBCC	; 0232CBFC
loc_0232CC00:
	subs r6,r6,#0x1	; 0232CC00
	beq loc_0232CC34	; 0232CC04
	adds r0,r0,r0	; 0232CC08
	adcs r1,r1,r1	; 0232CC0C
	adc r7,r7,r7	; 0232CC10
	adds r0,r0,r2	; 0232CC14
	adcs r1,r1,r3	; 0232CC18
	adc r7,r7,#0x0	; 0232CC1C
	adds r12,r12,r12	; 0232CC20
	adc r11,r11,r11	; 0232CC24
	cmp r7,#0x0	; 0232CC28
	bge loc_0232CBCC	; 0232CC2C
	b loc_0232CC00	; 0232CC30
loc_0232CC34:
	adds r0,r0,r2	; 0232CC34
	adc r1,r1,r3	; 0232CC38
loc_0232CC3C:
	ands r7,r4,#0x1	; 0232CC3C
	moveq r0,r12	; 0232CC40
	moveq r1,r11	; 0232CC44
	beq loc_0232CC74	; 0232CC48
	subs r7,r5,#0x20	; 0232CC4C
	movge r0,r1, lsr r7	; 0232CC50
	bge loc_0232CC98	; 0232CC54
	rsb r7,r5,#0x20	; 0232CC58
	mov r0,r0, lsr r5	; 0232CC5C
	orr r0,r0,r1, lsl r7	; 0232CC60
	mov r1,r1, lsr r5	; 0232CC64
	b loc_0232CC74	; 0232CC68
	.byte 0x31, 0x07, 0xA0, 0xE1, 0x00, 0x10, 0xA0, 0xE3	; 0232CC74
loc_0232CC74:
	cmp r4,#0x0	; 0232CC74
	blt loc_0232CC84	; 0232CC78
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CC7C
	bx lr	; 0232CC80
loc_0232CC84:
	rsbs r0,r0,#0x0	; 0232CC84
	rsc r1,r1,#0x0	; 0232CC88
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CC8C
	bx lr	; 0232CC90
loc_0232CC94:
	mov r0,#0x0	; 0232CC94
loc_0232CC98:
	mov r1,#0x0	; 0232CC98
	cmp r4,#0x0	; 0232CC9C
	blt loc_0232CC84	; 0232CCA0
	ldmia sp!,{r4,r5,r6,r7,r11,r12,lr}	; 0232CCA4
	bx lr	; 0232CCA8

; ARM EABI 64-bit multiply (__aeabi_lmul); the bit pattern is identical for signed and unsigned operands. / ARM EABI 64 位乘法（__aeabi_lmul）；有符号与无符号操作数的位级结果相同。
P1_AeabiLmul:
; ===== function loc_0232CCAC =====
loc_0232CCAC:
	stmdb sp!,{r4,r5,lr}	; 0232CCAC
	umull r5,r4,r0,r2	; 0232CCB0
	mla r4,r0,r3,r4	; 0232CCB4
	mla r4,r2,r1,r4	; 0232CCB8
	mov r1,r4	; 0232CCBC
	mov r0,r5	; 0232CCC0
	ldmia sp!,{r4,r5,lr}	; 0232CCC4
	bx lr	; 0232CCC8

; 32-bit signed division with remainder: r0 = quotient, r1 = remainder. / 32 位有符号除法及取余：r0 为商，r1 为余数。
P1_SignedDivMod:
; ===== function loc_0232CCCC =====
loc_0232CCCC:
	eor r12,r0,r1	; 0232CCCC
	and r12,r12,#0x80000000	; 0232CCD0
	cmp r0,#0x0	; 0232CCD4
	rsblt r0,r0,#0x0	; 0232CCD8
	addlt r12,r12,#0x1	; 0232CCDC
	cmp r1,#0x0	; 0232CCE0
	rsblt r1,r1,#0x0	; 0232CCE4
	beq loc_0232CEC4	; 0232CCE8
	cmp r0,r1	; 0232CCEC
	movcc r1,r0	; 0232CCF0
	movcc r0,#0x0	; 0232CCF4
	bcc loc_0232CEC4	; 0232CCF8
	mov r2,#0x1c	; 0232CCFC
	mov r3,r0, lsr #0x4	; 0232CD00
	cmp r1,r3, lsr #0xc	; 0232CD04
	suble r2,r2,#0x10	; 0232CD08
	movle r3,r3, lsr #0x10	; 0232CD0C
	cmp r1,r3, lsr #0x4	; 0232CD10
	suble r2,r2,#0x8	; 0232CD14
	movle r3,r3, lsr #0x8	; 0232CD18
	cmp r1,r3	; 0232CD1C
	suble r2,r2,#0x4	; 0232CD20
	movle r3,r3, lsr #0x4	; 0232CD24
	mov r0,r0, lsl r2	; 0232CD28
	rsb r1,r1,#0x0	; 0232CD2C
	adds r0,r0,r0	; 0232CD30
	add r2,r2,r2, lsl #0x1	; 0232CD34
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CD38PC:
	add pc,pc,r2, lsl #0x2	; 0232CD38
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CD40
loc_0232CD40:
P1_DivisionDispatch_0232CD38Steps:
	adcs r3,r1,r3, lsl #0x1	; 0232CD40
	subcc r3,r3,r1	; 0232CD44
	adcs r0,r0,r0	; 0232CD48
	adcs r3,r1,r3, lsl #0x1	; 0232CD4C
	subcc r3,r3,r1	; 0232CD50
	adcs r0,r0,r0	; 0232CD54
	adcs r3,r1,r3, lsl #0x1	; 0232CD58
	subcc r3,r3,r1	; 0232CD5C
	adcs r0,r0,r0	; 0232CD60
	adcs r3,r1,r3, lsl #0x1	; 0232CD64
	subcc r3,r3,r1	; 0232CD68
	adcs r0,r0,r0	; 0232CD6C
loc_0232CD70:
	adcs r3,r1,r3, lsl #0x1	; 0232CD70
	subcc r3,r3,r1	; 0232CD74
	adcs r0,r0,r0	; 0232CD78
	adcs r3,r1,r3, lsl #0x1	; 0232CD7C
	subcc r3,r3,r1	; 0232CD80
	adcs r0,r0,r0	; 0232CD84
	adcs r3,r1,r3, lsl #0x1	; 0232CD88
	subcc r3,r3,r1	; 0232CD8C
	adcs r0,r0,r0	; 0232CD90
	adcs r3,r1,r3, lsl #0x1	; 0232CD94
	subcc r3,r3,r1	; 0232CD98
	adcs r0,r0,r0	; 0232CD9C
loc_0232CDA0:
	adcs r3,r1,r3, lsl #0x1	; 0232CDA0
	subcc r3,r3,r1	; 0232CDA4
	adcs r0,r0,r0	; 0232CDA8
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
	adcs r3,r1,r3, lsl #0x1	; 0232CDDC
	subcc r3,r3,r1	; 0232CDE0
	adcs r0,r0,r0	; 0232CDE4
	adcs r3,r1,r3, lsl #0x1	; 0232CDE8
	subcc r3,r3,r1	; 0232CDEC
	adcs r0,r0,r0	; 0232CDF0
	adcs r3,r1,r3, lsl #0x1	; 0232CDF4
	subcc r3,r3,r1	; 0232CDF8
	adcs r0,r0,r0	; 0232CDFC
loc_0232CE00:
	adcs r3,r1,r3, lsl #0x1	; 0232CE00
	subcc r3,r3,r1	; 0232CE04
	adcs r0,r0,r0	; 0232CE08
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
P1_DivisionDispatch_0232CD38End:
.if (P1_DivisionDispatch_0232CD38Steps != P1_DivisionDispatch_0232CD38PC + 8) || (P1_DivisionDispatch_0232CD38End - P1_DivisionDispatch_0232CD38Steps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232CEC0
loc_0232CEC4:
	ands r3,r12,#0x80000000	; 0232CEC4
	rsbne r0,r0,#0x0	; 0232CEC8
	ands r3,r12,#0x1	; 0232CECC
	rsbne r1,r1,#0x0	; 0232CED0
	bx lr	; 0232CED4

; 32-bit unsigned division with remainder; the first entry returns immediately for a zero divisor. / 32 位无符号除法及取余；除数为零时第一个入口直接返回。
P1_UnsignedDivMod:
; ===== function loc_0232CED8 =====
loc_0232CED8:
	cmp r1,#0x0	; 0232CED8
	bxeq lr	; 0232CEDC

; ===== function loc_0232CEE0 =====
loc_0232CEE0:
	cmp r0,r1	; 0232CEE0
	movcc r1,r0	; 0232CEE4
	movcc r0,#0x0	; 0232CEE8
	bxcc lr	; 0232CEEC
	mov r2,#0x1c	; 0232CEF0
	mov r3,r0, lsr #0x4	; 0232CEF4
	cmp r1,r3, lsr #0xc	; 0232CEF8
	suble r2,r2,#0x10	; 0232CEFC
	movle r3,r3, lsr #0x10	; 0232CF00
	cmp r1,r3, lsr #0x4	; 0232CF04
	suble r2,r2,#0x8	; 0232CF08
	movle r3,r3, lsr #0x8	; 0232CF0C
	cmp r1,r3	; 0232CF10
	suble r2,r2,#0x4	; 0232CF14
	movle r3,r3, lsr #0x4	; 0232CF18
	mov r0,r0, lsl r2	; 0232CF1C
	rsb r1,r1,#0x0	; 0232CF20
	adds r0,r0,r0	; 0232CF24
	add r2,r2,r2, lsl #0x1	; 0232CF28
; 按已跳过的位数进入除法展开步骤；每步 3 条 ARM 指令。
; Enter the unrolled division at the skipped-bit index; 3 ARM instructions per step.
P1_DivisionDispatch_0232CF2CPC:
	add pc,pc,r2, lsl #0x2	; 0232CF2C
	.byte 0x00, 0x00, 0xA0, 0xE1	; 0232CF34
loc_0232CF34:
P1_DivisionDispatch_0232CF2CSteps:
	adcs r3,r1,r3, lsl #0x1	; 0232CF34
	subcc r3,r3,r1	; 0232CF38
	adcs r0,r0,r0	; 0232CF3C
	adcs r3,r1,r3, lsl #0x1	; 0232CF40
	subcc r3,r3,r1	; 0232CF44
	adcs r0,r0,r0	; 0232CF48
	adcs r3,r1,r3, lsl #0x1	; 0232CF4C
	subcc r3,r3,r1	; 0232CF50
	adcs r0,r0,r0	; 0232CF54
	adcs r3,r1,r3, lsl #0x1	; 0232CF58
	subcc r3,r3,r1	; 0232CF5C
	adcs r0,r0,r0	; 0232CF60
loc_0232CF64:
	adcs r3,r1,r3, lsl #0x1	; 0232CF64
	subcc r3,r3,r1	; 0232CF68
	adcs r0,r0,r0	; 0232CF6C
	adcs r3,r1,r3, lsl #0x1	; 0232CF70
	subcc r3,r3,r1	; 0232CF74
	adcs r0,r0,r0	; 0232CF78
	adcs r3,r1,r3, lsl #0x1	; 0232CF7C
	subcc r3,r3,r1	; 0232CF80
	adcs r0,r0,r0	; 0232CF84
	adcs r3,r1,r3, lsl #0x1	; 0232CF88
	subcc r3,r3,r1	; 0232CF8C
	adcs r0,r0,r0	; 0232CF90
loc_0232CF94:
	adcs r3,r1,r3, lsl #0x1	; 0232CF94
	subcc r3,r3,r1	; 0232CF98
	adcs r0,r0,r0	; 0232CF9C
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
	adcs r3,r1,r3, lsl #0x1	; 0232CFD0
	subcc r3,r3,r1	; 0232CFD4
	adcs r0,r0,r0	; 0232CFD8
	adcs r3,r1,r3, lsl #0x1	; 0232CFDC
	subcc r3,r3,r1	; 0232CFE0
	adcs r0,r0,r0	; 0232CFE4
	adcs r3,r1,r3, lsl #0x1	; 0232CFE8
	subcc r3,r3,r1	; 0232CFEC
	adcs r0,r0,r0	; 0232CFF0
loc_0232CFF4:
	adcs r3,r1,r3, lsl #0x1	; 0232CFF4
	subcc r3,r3,r1	; 0232CFF8
	adcs r0,r0,r0	; 0232CFFC
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
P1_DivisionDispatch_0232CF2CEnd:
.if (P1_DivisionDispatch_0232CF2CSteps != P1_DivisionDispatch_0232CF2CPC + 8) || (P1_DivisionDispatch_0232CF2CEnd - P1_DivisionDispatch_0232CF2CSteps != 32 * 12)
    .error "ARM division dispatch layout changed"
.endif
	mov r1,r3	; 0232D0B4
	bx lr	; 0232D0B8

; ===== function loc_0232D0BC =====
loc_0232D0BC:
	stmdb sp!,{lr}	; 0232D0BC
	blx loc_0232D19C	; 0232D0C0
	mov r1,#0x0	; 0232D0C4
	str r1,[r0,#0x0]	; 0232D0C8
	blx loc_0232D1A4	; 0232D0CC
	mov r1,#0x0	; 0232D0D0
	str r1,[r0,#0x4]	; 0232D0D4
	str r1,[r0,#0x8]	; 0232D0D8
	str r1,[r0,#0xc]	; 0232D0DC
	str r1,[r0,#0x10]	; 0232D0E0
	str r1,[r0,#0x14]	; 0232D0E4
	ldmia sp!,{lr}	; 0232D0E8
	bx lr	; 0232D0EC
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x28, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232D100
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232D110
	.byte 0x02, 0x00, 0xA0, 0xE1, 0x1E, 0xFF, 0x2F, 0xE1, 0x1F, 0x20, 0x00, 0xE2, 0x1F, 0x38, 0x00, 0xE2	; 0232D120
	.byte 0x23, 0x04, 0x82, 0xE1, 0x1F, 0x20, 0x01, 0xE2, 0x1F, 0x38, 0x01, 0xE2, 0x23, 0x14, 0x82, 0xE1	; 0232D130
	.byte 0x07, 0x50, 0x2D, 0xE9, 0x18, 0x00, 0x00, 0xFA, 0x00, 0x30, 0xA0, 0xE1, 0x07, 0x50, 0xBD, 0xE8	; 0232D140
	.byte 0x00, 0x20, 0x93, 0xE5, 0x00, 0xC0, 0xC2, 0xE1, 0x01, 0xC0, 0x2C, 0xE0, 0x00, 0xC0, 0x83, 0xE5	; 0232D150
	.byte 0x1F, 0x00, 0x02, 0xE2, 0x1F, 0x2C, 0x02, 0xE2, 0x02, 0x04, 0x80, 0xE1, 0x01, 0x01, 0x80, 0xE3	; 0232D160
	.byte 0x1E, 0xFF, 0x2F, 0xE1	; 0232D164
.thumb

; ===== function loc_0232D164 =====
loc_0232D164:
	add r3,r0,#0x0	; 0232D164
	cmp r0,#0x0	; 0232D166
	beq loc_0232D17A	; 0232D168
	cmp r1,#0x0	; 0232D16A
	beq loc_0232D17A	; 0232D16C
	mov r2,#0x0	; 0232D16E
loc_0232D170:
	strb r2,[r3,#0x0]	; 0232D170
	add r3,r3,#0x1	; 0232D172
	sub r1,r1,#0x1	; 0232D174
	cmp r1,#0x0	; 0232D176
	bne loc_0232D170	; 0232D178
loc_0232D17A:
	bx lr	; 0232D17A

; ===== function loc_0232D17C =====
loc_0232D17C:
	push {r4,lr}	; 0232D17C
	ldr r4,[pool_0232D198]	; 0232D17E
	b loc_0232D186	; 0232D180
loc_0232D182:
	blx r0	; 0232D182
	add r4,r4,#0x4	; 0232D184
loc_0232D186:
	cmp r4,#0x0	; 0232D186
	beq loc_0232D190	; 0232D188
	ldr r0,[r4,#0x0]	; 0232D18A
	cmp r0,#0x0	; 0232D18C
	bne loc_0232D182	; 0232D18E
loc_0232D190:
	pop {r4}	; 0232D190
	pop {r3}	; 0232D192
	bx r3	; 0232D194
	.byte 0xC0, 0x46	; 0232D198
pool_0232D198:
loc_0232D198:
	.word 0x02330308	; 0232D198

; ===== function loc_0232D19C =====
loc_0232D19C:
	ldr r0,[pool_0232D1A0]	; 0232D19C
	bx lr	; 0232D19E
pool_0232D1A0:
loc_0232D1A0:
	.word 0x02356E70	; 0232D1A0

; ===== function loc_0232D1A4 =====
loc_0232D1A4:
	ldr r0,[pool_0232D1A8]	; 0232D1A4
	bx lr	; 0232D1A6
pool_0232D1A8:
loc_0232D1A8:
	.word 0x02356E74	; 0232D1A8

; ===== function loc_0232D1AC =====
loc_0232D1AC:
	stmia r0!,{r1}	; 0232D1AC
	mov r1,#0x0	; 0232D1AE
	str r2,[r0,#0x8]	; 0232D1B0
	mov r2,#0x0	; 0232D1B2
	stmia r0!,{r1,r2}	; 0232D1B4
	bx lr	; 0232D1B6

; ===== function loc_0232D1B8 =====
loc_0232D1B8:
	str r2,[r0,#0x0]	; 0232D1B8
	str r1,[r0,#0x4]	; 0232D1BA
	neg r1,r1	; 0232D1BC
	str r1,[r0,#0x8]	; 0232D1BE
	str r2,[r0,#0xc]	; 0232D1C0
	bx lr	; 0232D1C2

; ===== function loc_0232D1C4 =====
loc_0232D1C4:
	push {r4,r5,r6,r7,lr}	; 0232D1C4
	sub sp,#0x54	; 0232D1C6
	add r6,r0,#0x0	; 0232D1C8
	add r5,r1,#0x0	; 0232D1CA
	add r7,r2,#0x0	; 0232D1CC
	cmp r7,r5	; 0232D1CE
	bne loc_0232D1D6	; 0232D1D0
	add r4,sp,#0x40	; 0232D1D2
	b loc_0232D1D8	; 0232D1D4
loc_0232D1D6:
	add r4,r7,#0x0	; 0232D1D6
loc_0232D1D8:
	ldr r0,[r6,#0x0]	; 0232D1D8
	str r0,[sp,#0x10]	; 0232D1DA
	ldr r0,[r6,#0x4]	; 0232D1DC
	str r0,[sp,#0x14]	; 0232D1DE
	asr r0,r0,#0x1f	; 0232D1E0
	str r0,[sp,#0x18]	; 0232D1E2
	ldr r0,[sp,#0x10]	; 0232D1E4
	asr r0,r0,#0x1f	; 0232D1E6
	str r0,[sp,#0x1c]	; 0232D1E8
	ldr r0,[sp,#0x10]	; 0232D1EA
	ldr r1,[sp,#0x1c]	; 0232D1EC
	ldr r2,[r5,#0x0]	; 0232D1EE
	asr r3,r2,#0x1f	; 0232D1F0
	blx P1_AeabiLmul	; 0232D1F2
	str r0,[sp,#0x20]	; 0232D1F6
	str r1,[sp,#0xc]	; 0232D1F8
	ldr r0,[sp,#0x14]	; 0232D1FA
	ldr r1,[sp,#0x18]	; 0232D1FC
	ldr r2,[r5,#0x8]	; 0232D1FE
	asr r3,r2,#0x1f	; 0232D200
	blx P1_AeabiLmul	; 0232D202
	ldr r2,[sp,#0x20]	; 0232D206
	add r0,r2,r0	; 0232D208
	ldr r2,[sp,#0xc]	; 0232D20A
	adc r2,r1	; 0232D20C
	str r2,[sp,#0xc]	; 0232D20E
	lsl r1,r2,#0x14	; 0232D210
	lsr r0,r0,#0xc	; 0232D212
	orr r0,r1	; 0232D214
	str r0,[r4,#0x0]	; 0232D216
	ldr r0,[sp,#0x10]	; 0232D218
	ldr r1,[sp,#0x1c]	; 0232D21A
	ldr r2,[r5,#0x4]	; 0232D21C
	asr r3,r2,#0x1f	; 0232D21E
	blx P1_AeabiLmul	; 0232D220
	str r0,[sp,#0x24]	; 0232D224
	str r1,[sp,#0x4]	; 0232D226
	ldr r0,[sp,#0x14]	; 0232D228
	ldr r1,[sp,#0x18]	; 0232D22A
	ldr r2,[r5,#0xc]	; 0232D22C
	asr r3,r2,#0x1f	; 0232D22E
	blx P1_AeabiLmul	; 0232D230
	ldr r2,[sp,#0x24]	; 0232D234
	add r0,r2,r0	; 0232D236
	ldr r2,[sp,#0x4]	; 0232D238
	adc r2,r1	; 0232D23A
	str r2,[sp,#0x4]	; 0232D23C
	lsl r1,r2,#0x14	; 0232D23E
	lsr r0,r0,#0xc	; 0232D240
	orr r0,r1	; 0232D242
	str r0,[r4,#0x4]	; 0232D244
	ldr r0,[r6,#0xc]	; 0232D246
	str r0,[sp,#0x28]	; 0232D248
	asr r0,r0,#0x1f	; 0232D24A
	str r0,[sp,#0x2c]	; 0232D24C
	ldr r0,[r6,#0x8]	; 0232D24E
	str r0,[sp,#0x30]	; 0232D250
	asr r0,r0,#0x1f	; 0232D252
	str r0,[sp,#0x34]	; 0232D254
	ldr r0,[sp,#0x30]	; 0232D256
	ldr r1,[sp,#0x34]	; 0232D258
	ldr r2,[r5,#0x0]	; 0232D25A
	asr r3,r2,#0x1f	; 0232D25C
	blx P1_AeabiLmul	; 0232D25E
	str r0,[sp,#0x38]	; 0232D262
	add r6,r1,#0x0	; 0232D264
	ldr r0,[sp,#0x28]	; 0232D266
	ldr r1,[sp,#0x2c]	; 0232D268
	ldr r2,[r5,#0x8]	; 0232D26A
	asr r3,r2,#0x1f	; 0232D26C
	blx P1_AeabiLmul	; 0232D26E
	ldr r2,[sp,#0x38]	; 0232D272
	add r2,r2,r0	; 0232D274
	adc r6,r1	; 0232D276
	lsl r0,r6,#0x14	; 0232D278
	lsr r1,r2,#0xc	; 0232D27A
	orr r1,r0	; 0232D27C
	str r1,[r4,#0x8]	; 0232D27E
	ldr r0,[sp,#0x30]	; 0232D280
	ldr r1,[sp,#0x34]	; 0232D282
	ldr r2,[r5,#0x4]	; 0232D284
	asr r3,r2,#0x1f	; 0232D286
	blx P1_AeabiLmul	; 0232D288
	str r0,[sp,#0x3c]	; 0232D28C
	add r6,r1,#0x0	; 0232D28E
	ldr r0,[sp,#0x28]	; 0232D290
	ldr r1,[sp,#0x2c]	; 0232D292
	ldr r2,[r5,#0xc]	; 0232D294
	asr r3,r2,#0x1f	; 0232D296
	blx P1_AeabiLmul	; 0232D298
	ldr r2,[sp,#0x3c]	; 0232D29C
	add r2,r2,r0	; 0232D29E
	adc r6,r1	; 0232D2A0
	lsl r0,r6,#0x14	; 0232D2A2
	lsr r1,r2,#0xc	; 0232D2A4
	orr r1,r0	; 0232D2A6
	str r1,[r4,#0xc]	; 0232D2A8
	add r2,sp,#0x40	; 0232D2AA
	cmp r4,r2	; 0232D2AC
	bne loc_0232D2B8	; 0232D2AE
	ldmia r2!,{r0,r1}	; 0232D2B0
	stmia r7!,{r0,r1}	; 0232D2B2
	ldmia r2!,{r0,r1}	; 0232D2B4
	stmia r7!,{r0,r1}	; 0232D2B6
loc_0232D2B8:
	add sp,#0x54	; 0232D2B8
	pop {r4,r5,r6,r7}	; 0232D2BA
	pop {r3}	; 0232D2BC
	bx r3	; 0232D2BE

; ===== function loc_0232D2C0 =====
loc_0232D2C0:
	push {r4}	; 0232D2C0
	sub sp,#0x4	; 0232D2C2
	mov r4,#0x0	; 0232D2C4
	ldr r3,[pool_0232D2E8]	; 0232D2C6
	strh r4,[r3,#0x0]	; 0232D2C8
	ldr r2,[pool_0232D2EC]	; 0232D2CA
	str r0,[r2,#0x0]	; 0232D2CC
	ldr r0,[pool_0232D2F0]	; 0232D2CE
	str r1,[r0,#0x0]	; 0232D2D0
	str r4,[r0,#0x4]	; 0232D2D2
	ldr r0,[pool_0232D2F4]	; 0232D2D4
loc_0232D2D6:
	ldrh r1,[r3,#0x0]	; 0232D2D6
	and r1,r0	; 0232D2D8
	cmp r1,#0x0	; 0232D2DA
	bne loc_0232D2D6	; 0232D2DC
	ldr r0,[pool_0232D2F8]	; 0232D2DE
	ldr r0,[r0,#0x0]	; 0232D2E0
	add sp,#0x4	; 0232D2E2
	pop {r4}	; 0232D2E4
	bx lr	; 0232D2E6
pool_0232D2E8:
loc_0232D2E8:
	.word REG_DIVCNT	; 0232D2E8
pool_0232D2EC:
loc_0232D2EC:
	.word REG_DIV_NUMER	; 0232D2EC
pool_0232D2F0:
loc_0232D2F0:
	.word REG_DIV_DENOM	; 0232D2F0
pool_0232D2F4:
loc_0232D2F4:
	.word 0x00008000	; 0232D2F4
pool_0232D2F8:
loc_0232D2F8:
	.word REG_DIV_RESULT	; 0232D2F8

; ===== function loc_0232D2FC =====
loc_0232D2FC:
	mov r2,#0x1	; 0232D2FC
	ldr r1,[pool_0232D314]	; 0232D2FE
	strh r2,[r1,#0x0]	; 0232D300
	mov r3,#0x0	; 0232D302
	ldr r2,[pool_0232D318]	; 0232D304
	ldr r1,[pool_0232D31C]	; 0232D306
	str r3,[r1,#0x0]	; 0232D308
	str r2,[r1,#0x4]	; 0232D30A
	ldr r1,[pool_0232D320]	; 0232D30C
	str r0,[r1,#0x0]	; 0232D30E
	str r3,[r1,#0x4]	; 0232D310
	bx lr	; 0232D312
pool_0232D314:
loc_0232D314:
	.word REG_DIVCNT	; 0232D314
pool_0232D318:
loc_0232D318:
	.word 0x00001000	; 0232D318
pool_0232D31C:
loc_0232D31C:
	.word REG_DIV_NUMER	; 0232D31C
pool_0232D320:
loc_0232D320:
	.word REG_DIV_DENOM	; 0232D320

; ===== function loc_0232D324 =====
loc_0232D324:
	ldr r1,[pool_0232D348]	; 0232D324
	ldr r0,[pool_0232D34C]	; 0232D326
loc_0232D328:
	ldrh r2,[r1,#0x0]	; 0232D328
	and r2,r0	; 0232D32A
	cmp r2,#0x0	; 0232D32C
	bne loc_0232D328	; 0232D32E
	ldr r0,[pool_0232D350]	; 0232D330
	ldr r2,[r0,#0x0]	; 0232D332
	ldr r3,[r0,#0x4]	; 0232D334
	mov r1,#0x0	; 0232D336
	ldr r0,[pool_0232D354]	; 0232D338
	add r0,r2,r0	; 0232D33A
	adc r3,r1	; 0232D33C
	lsl r1,r3,#0xc	; 0232D33E
	lsr r0,r0,#0x14	; 0232D340
	orr r0,r1	; 0232D342
	bx lr	; 0232D344
	.byte 0xC0, 0x46	; 0232D348
pool_0232D348:
loc_0232D348:
	.word REG_DIVCNT	; 0232D348
pool_0232D34C:
loc_0232D34C:
	.word 0x00008000	; 0232D34C
pool_0232D350:
loc_0232D350:
	.word REG_DIV_RESULT	; 0232D350
pool_0232D354:
loc_0232D354:
	.word 0x00080000	; 0232D354

; ===== function loc_0232D358 =====
loc_0232D358:
	push {lr}	; 0232D358
	sub sp,#0x4	; 0232D35A
	bl loc_0232D2FC	; 0232D35C
	bl loc_0232D324	; 0232D360
	add sp,#0x4	; 0232D364
	pop {r3}	; 0232D366
	bx r3	; 0232D368
	.byte 0x00, 0x00	; 0232D36C
.arm

; ===== function loc_0232D36C =====
loc_0232D36C:
	smull r2,r1,r0,r1	; 0232D36C
	mov r0,#0x800	; 0232D370
	adds r0,r2,r0	; 0232D374
	adc r1,r1,#0x0	; 0232D378
	mov r0,r0, lsr #0xc	; 0232D37C
	orr r0,r0,r1, lsl #0x14	; 0232D380
	bx lr	; 0232D384
.thumb

; ===== function loc_0232D388 =====
loc_0232D388:
	cmp r1,#0x0	; 0232D388
	bne loc_0232D392	; 0232D38A
	mov r1,#0x0	; 0232D38C
	strh r1,[r0,#0x0]	; 0232D38E
	bx lr	; 0232D390
loc_0232D392:
	cmp r1,#0x0	; 0232D392
	ble loc_0232D39E	; 0232D394
	ldr r2,[pool_0232D3A8]	; 0232D396
	orr r1,r2	; 0232D398
	strh r1,[r0,#0x0]	; 0232D39A
	bx lr	; 0232D39C
loc_0232D39E:
	neg r2,r1	; 0232D39E
	ldr r1,[pool_0232D3AC]	; 0232D3A0
	orr r2,r1	; 0232D3A2
	strh r2,[r0,#0x0]	; 0232D3A4
	bx lr	; 0232D3A6
pool_0232D3A8:
loc_0232D3A8:
	.word 0x00004000	; 0232D3A8
pool_0232D3AC:
loc_0232D3AC:
	.word 0x00008000	; 0232D3AC

; ===== function loc_0232D3B0 =====
loc_0232D3B0:
	ldr r2,[pool_0232D3C0]	; 0232D3B0
	ldr r3,[r2,#0x0]	; 0232D3B2
	mov r1,#0x7	; 0232D3B4
	bic r3,r1	; 0232D3B6
	orr r3,r0	; 0232D3B8
	str r3,[r2,#0x0]	; 0232D3BA
	bx lr	; 0232D3BC
	.byte 0xC0, 0x46	; 0232D3C0
pool_0232D3C0:
loc_0232D3C0:
	.word REG_DISPCNT_B	; 0232D3C0

; ===== function loc_0232D3C4 =====
loc_0232D3C4:
	push {r4}	; 0232D3C4
	sub sp,#0x4	; 0232D3C6
	ldr r3,[pool_0232D400]	; 0232D3C8
	ldr r3,[r3,#0x0]	; 0232D3CA
	ldr r4,[pool_0232D404]	; 0232D3CC
	strh r0,[r4,#0x0]	; 0232D3CE
	ldr r4,[pool_0232D408]	; 0232D3D0
	ldrh r4,[r4,#0x0]	; 0232D3D2
	cmp r4,#0x0	; 0232D3D4
	bne loc_0232D3DA	; 0232D3D6
	mov r0,#0x0	; 0232D3D8
loc_0232D3DA:
	lsl r4,r2,#0x3	; 0232D3DA
	ldr r2,[pool_0232D40C]	; 0232D3DC
	and r3,r2	; 0232D3DE
	lsl r0,r0,#0x10	; 0232D3E0
	orr r3,r0	; 0232D3E2
	orr r1,r3	; 0232D3E4
	orr r4,r1	; 0232D3E6
	ldr r0,[pool_0232D400]	; 0232D3E8
	str r4,[r0,#0x0]	; 0232D3EA
	ldr r0,[pool_0232D404]	; 0232D3EC
	ldrh r0,[r0,#0x0]	; 0232D3EE
	cmp r0,#0x0	; 0232D3F0
	bne loc_0232D3FA	; 0232D3F2
	mov r1,#0x0	; 0232D3F4
	ldr r0,[pool_0232D408]	; 0232D3F6
	strh r1,[r0,#0x0]	; 0232D3F8
loc_0232D3FA:
	add sp,#0x4	; 0232D3FA
	pop {r4}	; 0232D3FC
	bx lr	; 0232D3FE
pool_0232D400:
loc_0232D400:
	.word REG_DISPCNT_A	; 0232D400
pool_0232D404:
loc_0232D404:
	.word P1_BssStart + 0x266AC	; 0232D404
pool_0232D408:
loc_0232D408:
	.word P1_Data_023307C8	; 0232D408
pool_0232D40C:
loc_0232D40C:
	.word 0xFFF0FFF0	; 0232D40C

; ===== function loc_0232D410 =====
loc_0232D410:
	mov r1,#0x1	; 0232D410
	ldr r0,[pool_0232D43C]	; 0232D412
	strh r1,[r0,#0x0]	; 0232D414
	ldr r0,[pool_0232D440]	; 0232D416
	ldrh r3,[r0,#0x0]	; 0232D418
	cmp r3,#0x0	; 0232D41A
	beq loc_0232D42E	; 0232D41C
	ldr r1,[pool_0232D444]	; 0232D41E
	ldr r2,[r1,#0x0]	; 0232D420
	ldr r0,[pool_0232D448]	; 0232D422
	and r2,r0	; 0232D424
	lsl r0,r3,#0x10	; 0232D426
	orr r2,r0	; 0232D428
	str r2,[r1,#0x0]	; 0232D42A
	bx lr	; 0232D42C
loc_0232D42E:
	ldr r1,[pool_0232D444]	; 0232D42E
	ldr r2,[r1,#0x0]	; 0232D430
	ldr r0,[pool_0232D44C]	; 0232D432
	orr r2,r0	; 0232D434
	str r2,[r1,#0x0]	; 0232D436
	bx lr	; 0232D438
	.byte 0xC0, 0x46	; 0232D43C
pool_0232D43C:
loc_0232D43C:
	.word P1_Data_023307C8	; 0232D43C
pool_0232D440:
loc_0232D440:
	.word P1_BssStart + 0x266AC	; 0232D440
pool_0232D444:
loc_0232D444:
	.word REG_DISPCNT_A	; 0232D444
pool_0232D448:
loc_0232D448:
	.word 0xFFFCFFFF	; 0232D448
pool_0232D44C:
loc_0232D44C:
	.word 0x00010000	; 0232D44C

; ===== function loc_0232D450 =====
loc_0232D450:
	ldr r1,[pool_0232D470]	; 0232D450
	ldr r0,[r1,#0x0]	; 0232D452
	mov r3,#0x0	; 0232D454
	ldr r2,[pool_0232D474]	; 0232D456
	strh r3,[r2,#0x0]	; 0232D458
	ldr r2,[pool_0232D478]	; 0232D45A
	add r3,r0,#0x0	; 0232D45C
	and r3,r2	; 0232D45E
	lsr r3,r3,#0x10	; 0232D460
	ldr r2,[pool_0232D47C]	; 0232D462
	strh r3,[r2,#0x0]	; 0232D464
	ldr r2,[pool_0232D480]	; 0232D466
	and r0,r2	; 0232D468
	str r0,[r1,#0x0]	; 0232D46A
	bx lr	; 0232D46C
	.byte 0xC0, 0x46	; 0232D470
pool_0232D470:
loc_0232D470:
	.word REG_DISPCNT_A	; 0232D470
pool_0232D474:
loc_0232D474:
	.word P1_Data_023307C8	; 0232D474
pool_0232D478:
loc_0232D478:
	.word 0x00030000	; 0232D478
pool_0232D47C:
loc_0232D47C:
	.word P1_BssStart + 0x266AC	; 0232D47C
pool_0232D480:
loc_0232D480:
	.word 0xFFFCFFFF	; 0232D480

; ===== function loc_0232D484 =====
loc_0232D484:
	ldr r2,[pool_0232D4A4]	; 0232D484
	ldrh r3,[r2,#0x0]	; 0232D486
	mov r1,#0x8	; 0232D488
	and r3,r1	; 0232D48A
	cmp r0,#0x0	; 0232D48C
	beq loc_0232D498	; 0232D48E
	ldrh r0,[r2,#0x0]	; 0232D490
	orr r0,r1	; 0232D492
	strh r0,[r2,#0x0]	; 0232D494
	b loc_0232D49E	; 0232D496
loc_0232D498:
	ldrh r0,[r2,#0x0]	; 0232D498
	bic r0,r1	; 0232D49A
	strh r0,[r2,#0x0]	; 0232D49C
loc_0232D49E:
	add r0,r3,#0x0	; 0232D49E
	bx lr	; 0232D4A0
	.byte 0xC0, 0x46	; 0232D4A4
pool_0232D4A4:
loc_0232D4A4:
	.word REG_DISPSTAT	; 0232D4A4

; ===== function loc_0232D4A8 =====
loc_0232D4A8:
	push {lr}	; 0232D4A8
	sub sp,#0xc	; 0232D4AA
	ldr r0,[pool_0232D520]	; 0232D4AC
	ldrh r2,[r0,#0x0]	; 0232D4AE
	ldr r1,[pool_0232D524]	; 0232D4B0
	orr r2,r1	; 0232D4B2
	strh r2,[r0,#0x0]	; 0232D4B4
	ldrh r2,[r0,#0x0]	; 0232D4B6
	ldr r1,[pool_0232D528]	; 0232D4B8
	and r2,r1	; 0232D4BA
	ldr r1,[pool_0232D52C]	; 0232D4BC
	orr r2,r1	; 0232D4BE
	strh r2,[r0,#0x0]	; 0232D4C0
	ldrh r2,[r0,#0x0]	; 0232D4C2
	mov r1,#0x1	; 0232D4C4
	orr r2,r1	; 0232D4C6
	strh r2,[r0,#0x0]	; 0232D4C8
	bl loc_0232D568	; 0232D4CA
	mov r1,#0x0	; 0232D4CE
	ldr r0,[pool_0232D530]	; 0232D4D0
	strh r1,[r0,#0x0]	; 0232D4D2
	ldr r0,[pool_0232D534]	; 0232D4D4
	str r1,[r0,#0x0]	; 0232D4D6
	str r1,[sp,#0x0]	; 0232D4D8
	ldr r0,[sp,#0x0]	; 0232D4DA
	ldr r1,[pool_0232D538]	; 0232D4DC
	mov r2,#0x60	; 0232D4DE
	blx loc_0232DDE0	; 0232D4E0
	mov r1,#0x0	; 0232D4E4
	ldr r0,[pool_0232D53C]	; 0232D4E6
	strh r1,[r0,#0x0]	; 0232D4E8
	str r1,[sp,#0x4]	; 0232D4EA
	ldr r0,[sp,#0x4]	; 0232D4EC
	ldr r1,[pool_0232D540]	; 0232D4EE
	mov r2,#0x70	; 0232D4F0
	blx loc_0232DDE0	; 0232D4F2
	ldr r0,[pool_0232D544]	; 0232D4F6
	ldr r1,[pool_0232D548]	; 0232D4F8
	strh r0,[r1,#0x0]	; 0232D4FA
	ldr r1,[pool_0232D54C]	; 0232D4FC
	strh r0,[r1,#0x0]	; 0232D4FE
	ldr r1,[pool_0232D550]	; 0232D500
	strh r0,[r1,#0x0]	; 0232D502
	ldr r1,[pool_0232D554]	; 0232D504
	strh r0,[r1,#0x0]	; 0232D506
	ldr r1,[pool_0232D558]	; 0232D508
	strh r0,[r1,#0x0]	; 0232D50A
	ldr r1,[pool_0232D55C]	; 0232D50C
	strh r0,[r1,#0x0]	; 0232D50E
	ldr r1,[pool_0232D560]	; 0232D510
	strh r0,[r1,#0x0]	; 0232D512
	ldr r1,[pool_0232D564]	; 0232D514
	strh r0,[r1,#0x0]	; 0232D516
	add sp,#0xc	; 0232D518
	pop {r3}	; 0232D51A
	bx r3	; 0232D51C
	.byte 0xC0, 0x46	; 0232D520
pool_0232D520:
loc_0232D520:
	.word REG_POWERCNT	; 0232D520
pool_0232D524:
loc_0232D524:
	.word 0x00008000	; 0232D524
pool_0232D528:
loc_0232D528:
	.word 0xFFFFFDF1	; 0232D528
pool_0232D52C:
loc_0232D52C:
	.word 0x0000020E	; 0232D52C
pool_0232D530:
loc_0232D530:
	.word REG_DISPSTAT	; 0232D530
pool_0232D534:
loc_0232D534:
	.word REG_DISPCNT_A	; 0232D534
pool_0232D538:
loc_0232D538:
	.word REG_BG0CNT	; 0232D538
pool_0232D53C:
loc_0232D53C:
	.word REG_MASTER_BRIGHT	; 0232D53C
pool_0232D540:
loc_0232D540:
	.word REG_DISPCNT_B	; 0232D540
pool_0232D544:
loc_0232D544:
	.word 0x00000100	; 0232D544
pool_0232D548:
loc_0232D548:
	.word REG_BG2PA	; 0232D548
pool_0232D54C:
loc_0232D54C:
	.word REG_BG2PD	; 0232D54C
pool_0232D550:
loc_0232D550:
	.word REG_BG3PA	; 0232D550
pool_0232D554:
loc_0232D554:
	.word REG_BG3PD	; 0232D554
pool_0232D558:
loc_0232D558:
	.word REG_BG2PA_SUB	; 0232D558
pool_0232D55C:
loc_0232D55C:
	.word REG_BG2PD_SUB	; 0232D55C
pool_0232D560:
loc_0232D560:
	.word REG_BG3PA_SUB	; 0232D560
pool_0232D564:
loc_0232D564:
	.word REG_BG3PD_SUB	; 0232D564

; ===== function loc_0232D568 =====
loc_0232D568:
	mov r1,#0x0	; 0232D568
	ldr r0,[pool_0232D59C]	; 0232D56A
	strh r1,[r0,#0x0]	; 0232D56C
	strh r1,[r0,#0x2]	; 0232D56E
	strh r1,[r0,#0x4]	; 0232D570
	strh r1,[r0,#0x6]	; 0232D572
	strh r1,[r0,#0x8]	; 0232D574
	strh r1,[r0,#0xa]	; 0232D576
	strh r1,[r0,#0xc]	; 0232D578
	strh r1,[r0,#0xe]	; 0232D57A
	strh r1,[r0,#0x10]	; 0232D57C
	strh r1,[r0,#0x12]	; 0232D57E
	strh r1,[r0,#0x14]	; 0232D580
	strh r1,[r0,#0x16]	; 0232D582
	strh r1,[r0,#0x18]	; 0232D584
	ldr r0,[pool_0232D5A0]	; 0232D586
	str r1,[r0,#0x0]	; 0232D588
	ldr r0,[pool_0232D5A4]	; 0232D58A
	strb r1,[r0,#0x0]	; 0232D58C
	ldr r0,[pool_0232D5A8]	; 0232D58E
	strb r1,[r0,#0x0]	; 0232D590
	ldr r0,[pool_0232D5AC]	; 0232D592
	strb r1,[r0,#0x0]	; 0232D594
	ldr r0,[pool_0232D5B0]	; 0232D596
	strh r1,[r0,#0x0]	; 0232D598
	bx lr	; 0232D59A
pool_0232D59C:
loc_0232D59C:
	.word P1_BssStart + 0x266B0	; 0232D59C
pool_0232D5A0:
loc_0232D5A0:
	.word VRAM_A_CR	; 0232D5A0
pool_0232D5A4:
loc_0232D5A4:
	.word VRAM_E_CR	; 0232D5A4
pool_0232D5A8:
loc_0232D5A8:
	.word VRAM_F_CR	; 0232D5A8
pool_0232D5AC:
loc_0232D5AC:
	.word VRAM_G_CR	; 0232D5AC
pool_0232D5B0:
loc_0232D5B0:
	.word VRAM_H_CR	; 0232D5B0

; ===== function loc_0232D5B4 =====
loc_0232D5B4:
	ldr r0,[pool_0232D5BC]	; 0232D5B4
	ldr r3,[pool_0232D5C0]	; 0232D5B6
	bx r3	; 0232D5B8
	.byte 0xC0, 0x46	; 0232D5BC
pool_0232D5BC:
loc_0232D5BC:
	.word 0x02356EA4	; 0232D5BC
pool_0232D5C0:
loc_0232D5C0:
	.word loc_0232D614 + 1	; 0232D5C0

; ===== function loc_0232D5C4 =====
loc_0232D5C4:
	ldr r0,[pool_0232D5CC]	; 0232D5C4
	ldr r3,[pool_0232D5D0]	; 0232D5C6
	bx r3	; 0232D5C8
	.byte 0xC0, 0x46	; 0232D5CC
pool_0232D5CC:
loc_0232D5CC:
	.word 0x02356EA2	; 0232D5CC
pool_0232D5D0:
loc_0232D5D0:
	.word loc_0232D614 + 1	; 0232D5D0

; ===== function loc_0232D5D4 =====
loc_0232D5D4:
	ldr r0,[pool_0232D5DC]	; 0232D5D4
	ldr r3,[pool_0232D5E0]	; 0232D5D6
	bx r3	; 0232D5D8
	.byte 0xC0, 0x46	; 0232D5DC
pool_0232D5DC:
loc_0232D5DC:
	.word 0x02356E90	; 0232D5DC
pool_0232D5E0:
loc_0232D5E0:
	.word loc_0232D614 + 1	; 0232D5E0

; ===== function loc_0232D5E4 =====
loc_0232D5E4:
	ldr r0,[pool_0232D5EC]	; 0232D5E4
	ldr r3,[pool_0232D5F0]	; 0232D5E6
	bx r3	; 0232D5E8
	.byte 0xC0, 0x46	; 0232D5EC
pool_0232D5EC:
loc_0232D5EC:
	.word 0x02356E96	; 0232D5EC
pool_0232D5F0:
loc_0232D5F0:
	.word loc_0232D614 + 1	; 0232D5F0

; ===== function loc_0232D5F4 =====
loc_0232D5F4:
	ldr r0,[pool_0232D5FC]	; 0232D5F4
	ldr r3,[pool_0232D600]	; 0232D5F6
	bx r3	; 0232D5F8
	.byte 0xC0, 0x46	; 0232D5FC
pool_0232D5FC:
loc_0232D5FC:
	.word 0x02356E94	; 0232D5FC
pool_0232D600:
loc_0232D600:
	.word loc_0232D614 + 1	; 0232D600

; ===== function loc_0232D604 =====
loc_0232D604:
	ldr r0,[pool_0232D60C]	; 0232D604
	ldr r3,[pool_0232D610]	; 0232D606
	bx r3	; 0232D608
	.byte 0xC0, 0x46	; 0232D60C
pool_0232D60C:
loc_0232D60C:
	.word 0x02356E92	; 0232D60C
pool_0232D610:
loc_0232D610:
	.word loc_0232D614 + 1	; 0232D610
loc_0232D614:
	ldrh r1,[r0,#0x0]	; 0232D614
	mov r3,#0x0	; 0232D616
	strh r3,[r0,#0x0]	; 0232D618
	mov r0,#0x1	; 0232D61A
	add r2,r1,#0x0	; 0232D61C
	and r2,r0	; 0232D61E
	cmp r2,#0x0	; 0232D620
	beq loc_0232D628	; 0232D622
	ldr r0,[pool_0232D6AC]	; 0232D624
	strb r3,[r0,#0x0]	; 0232D626
loc_0232D628:
	mov r0,#0x2	; 0232D628
	add r2,r1,#0x0	; 0232D62A
	and r2,r0	; 0232D62C
	cmp r2,#0x0	; 0232D62E
	beq loc_0232D638	; 0232D630
	mov r2,#0x0	; 0232D632
	ldr r0,[pool_0232D6B0]	; 0232D634
	strb r2,[r0,#0x0]	; 0232D636
loc_0232D638:
	mov r0,#0x4	; 0232D638
	add r2,r1,#0x0	; 0232D63A
	and r2,r0	; 0232D63C
	cmp r2,#0x0	; 0232D63E
	beq loc_0232D648	; 0232D640
	mov r2,#0x0	; 0232D642
	ldr r0,[pool_0232D6B4]	; 0232D644
	strb r2,[r0,#0x0]	; 0232D646
loc_0232D648:
	mov r0,#0x8	; 0232D648
	add r2,r1,#0x0	; 0232D64A
	and r2,r0	; 0232D64C
	cmp r2,#0x0	; 0232D64E
	beq loc_0232D658	; 0232D650
	mov r2,#0x0	; 0232D652
	ldr r0,[pool_0232D6B8]	; 0232D654
	strb r2,[r0,#0x0]	; 0232D656
loc_0232D658:
	mov r0,#0x10	; 0232D658
	add r2,r1,#0x0	; 0232D65A
	and r2,r0	; 0232D65C
	cmp r2,#0x0	; 0232D65E
	beq loc_0232D668	; 0232D660
	mov r2,#0x0	; 0232D662
	ldr r0,[pool_0232D6BC]	; 0232D664
	strb r2,[r0,#0x0]	; 0232D666
loc_0232D668:
	mov r0,#0x20	; 0232D668
	add r2,r1,#0x0	; 0232D66A
	and r2,r0	; 0232D66C
	cmp r2,#0x0	; 0232D66E
	beq loc_0232D678	; 0232D670
	mov r2,#0x0	; 0232D672
	ldr r0,[pool_0232D6C0]	; 0232D674
	strb r2,[r0,#0x0]	; 0232D676
loc_0232D678:
	mov r0,#0x40	; 0232D678
	add r2,r1,#0x0	; 0232D67A
	and r2,r0	; 0232D67C
	cmp r2,#0x0	; 0232D67E
	beq loc_0232D688	; 0232D680
	mov r2,#0x0	; 0232D682
	ldr r0,[pool_0232D6C4]	; 0232D684
	strb r2,[r0,#0x0]	; 0232D686
loc_0232D688:
	mov r0,#0x80	; 0232D688
	add r2,r1,#0x0	; 0232D68A
	and r2,r0	; 0232D68C
	cmp r2,#0x0	; 0232D68E
	beq loc_0232D698	; 0232D690
	mov r2,#0x0	; 0232D692
	ldr r0,[pool_0232D6C8]	; 0232D694
	strb r2,[r0,#0x0]	; 0232D696
loc_0232D698:
	ldr r0,[pool_0232D6CC]	; 0232D698
	add r2,r1,#0x0	; 0232D69A
	and r2,r0	; 0232D69C
	cmp r2,#0x0	; 0232D69E
	beq loc_0232D6A8	; 0232D6A0
	mov r2,#0x0	; 0232D6A2
	ldr r0,[pool_0232D6D0]	; 0232D6A4
	strb r2,[r0,#0x0]	; 0232D6A6
loc_0232D6A8:
	add r0,r1,#0x0	; 0232D6A8
	bx lr	; 0232D6AA
pool_0232D6AC:
loc_0232D6AC:
	.word VRAM_A_CR	; 0232D6AC
pool_0232D6B0:
loc_0232D6B0:
	.word VRAM_B_CR	; 0232D6B0
pool_0232D6B4:
loc_0232D6B4:
	.word VRAM_C_CR	; 0232D6B4
pool_0232D6B8:
loc_0232D6B8:
	.word VRAM_D_CR	; 0232D6B8
pool_0232D6BC:
loc_0232D6BC:
	.word VRAM_E_CR	; 0232D6BC
pool_0232D6C0:
loc_0232D6C0:
	.word VRAM_F_CR	; 0232D6C0
pool_0232D6C4:
loc_0232D6C4:
	.word VRAM_G_CR	; 0232D6C4
pool_0232D6C8:
loc_0232D6C8:
	.word VRAM_H_CR	; 0232D6C8
pool_0232D6CC:
loc_0232D6CC:
	.word 0x00000100	; 0232D6CC
pool_0232D6D0:
loc_0232D6D0:
	.word VRAM_I_CR	; 0232D6D0

; ===== function loc_0232D6D4 =====
loc_0232D6D4:
	ldr r1,[pool_0232D6E0]	; 0232D6D4
	ldrh r2,[r1,#0x0]	; 0232D6D6
	orr r2,r0	; 0232D6D8
	strh r2,[r1,#0x0]	; 0232D6DA
	ldr r3,[pool_0232D6E4]	; 0232D6DC
	bx r3	; 0232D6DE
pool_0232D6E0:
loc_0232D6E0:
	.word P1_BssStart + 0x266B0	; 0232D6E0
pool_0232D6E4:
loc_0232D6E4:
	.word loc_0232D6E8 + 1	; 0232D6E4

; ===== function loc_0232D6E8 =====
loc_0232D6E8:
	mov r1,#0x1	; 0232D6E8
	add r2,r0,#0x0	; 0232D6EA
	and r2,r1	; 0232D6EC
	cmp r2,#0x0	; 0232D6EE
	beq loc_0232D6F8	; 0232D6F0
	mov r2,#0x80	; 0232D6F2
	ldr r1,[pool_0232D778]	; 0232D6F4
	strb r2,[r1,#0x0]	; 0232D6F6
loc_0232D6F8:
	mov r1,#0x2	; 0232D6F8
	add r2,r0,#0x0	; 0232D6FA
	and r2,r1	; 0232D6FC
	cmp r2,#0x0	; 0232D6FE
	beq loc_0232D708	; 0232D700
	mov r2,#0x80	; 0232D702
	ldr r1,[pool_0232D77C]	; 0232D704
	strb r2,[r1,#0x0]	; 0232D706
loc_0232D708:
	mov r1,#0x4	; 0232D708
	add r2,r0,#0x0	; 0232D70A
	and r2,r1	; 0232D70C
	cmp r2,#0x0	; 0232D70E
	beq loc_0232D718	; 0232D710
	mov r2,#0x80	; 0232D712
	ldr r1,[pool_0232D780]	; 0232D714
	strb r2,[r1,#0x0]	; 0232D716
loc_0232D718:
	mov r1,#0x8	; 0232D718
	add r2,r0,#0x0	; 0232D71A
	and r2,r1	; 0232D71C
	cmp r2,#0x0	; 0232D71E
	beq loc_0232D728	; 0232D720
	mov r2,#0x80	; 0232D722
	ldr r1,[pool_0232D784]	; 0232D724
	strb r2,[r1,#0x0]	; 0232D726
loc_0232D728:
	mov r1,#0x10	; 0232D728
	add r2,r0,#0x0	; 0232D72A
	and r2,r1	; 0232D72C
	cmp r2,#0x0	; 0232D72E
	beq loc_0232D738	; 0232D730
	mov r2,#0x80	; 0232D732
	ldr r1,[pool_0232D788]	; 0232D734
	strb r2,[r1,#0x0]	; 0232D736
loc_0232D738:
	mov r1,#0x20	; 0232D738
	add r2,r0,#0x0	; 0232D73A
	and r2,r1	; 0232D73C
	cmp r2,#0x0	; 0232D73E
	beq loc_0232D748	; 0232D740
	mov r2,#0x80	; 0232D742
	ldr r1,[pool_0232D78C]	; 0232D744
	strb r2,[r1,#0x0]	; 0232D746
loc_0232D748:
	mov r1,#0x40	; 0232D748
	add r2,r0,#0x0	; 0232D74A
	and r2,r1	; 0232D74C
	cmp r2,#0x0	; 0232D74E
	beq loc_0232D758	; 0232D750
	mov r2,#0x80	; 0232D752
	ldr r1,[pool_0232D790]	; 0232D754
	strb r2,[r1,#0x0]	; 0232D756
loc_0232D758:
	mov r2,#0x80	; 0232D758
	add r1,r0,#0x0	; 0232D75A
	and r1,r2	; 0232D75C
	cmp r1,#0x0	; 0232D75E
	beq loc_0232D766	; 0232D760
	ldr r1,[pool_0232D794]	; 0232D762
	strb r2,[r1,#0x0]	; 0232D764
loc_0232D766:
	ldr r1,[pool_0232D798]	; 0232D766
	and r0,r1	; 0232D768
	cmp r0,#0x0	; 0232D76A
	beq loc_0232D774	; 0232D76C
	mov r1,#0x80	; 0232D76E
	ldr r0,[pool_0232D79C]	; 0232D770
	strb r1,[r0,#0x0]	; 0232D772
loc_0232D774:
	bx lr	; 0232D774
	.byte 0xC0, 0x46	; 0232D778
pool_0232D778:
loc_0232D778:
	.word VRAM_A_CR	; 0232D778
pool_0232D77C:
loc_0232D77C:
	.word VRAM_B_CR	; 0232D77C
pool_0232D780:
loc_0232D780:
	.word VRAM_C_CR	; 0232D780
pool_0232D784:
loc_0232D784:
	.word VRAM_D_CR	; 0232D784
pool_0232D788:
loc_0232D788:
	.word VRAM_E_CR	; 0232D788
pool_0232D78C:
loc_0232D78C:
	.word VRAM_F_CR	; 0232D78C
pool_0232D790:
loc_0232D790:
	.word VRAM_G_CR	; 0232D790
pool_0232D794:
loc_0232D794:
	.word VRAM_H_CR	; 0232D794
pool_0232D798:
loc_0232D798:
	.word 0x00000100	; 0232D798
pool_0232D79C:
loc_0232D79C:
	.word VRAM_I_CR	; 0232D79C

; ===== function loc_0232D7A0 =====
; Returns the sub-engine BG1 character-base address.
; 返回副引擎 BG1 字符基址。
.func P1_GetSubBg1CharacterBase
loc_0232D7A0:
	ldr r0,[pool_0232D7B4]	; 0232D7A0
	ldrh r1,[r0,#0x0]	; 0232D7A2
	mov r0,#0x3c	; 0232D7A4
	and r1,r0	; 0232D7A6
	asr r0,r1,#0x2	; 0232D7A8
	lsl r1,r0,#0xe	; 0232D7AA
	ldr r0,[pool_0232D7B8]	; 0232D7AC
	add r0,r1,r0	; 0232D7AE
	bx lr	; 0232D7B0
.endfunc
	.byte 0xC0, 0x46	; 0232D7B4
pool_0232D7B4:
loc_0232D7B4:
	.word REG_BG1CNT_SUB	; 0232D7B4
pool_0232D7B8:
loc_0232D7B8:
	.word 0x06200000	; 0232D7B8

; ===== function loc_0232D7BC =====
; Returns the main-engine BG1 character-base address.
; 返回主引擎 BG1 字符基址。
.func P1_GetMainBg1CharacterBase
loc_0232D7BC:
	ldr r0,[pool_0232D7DC]	; 0232D7BC
	ldrh r1,[r0,#0x0]	; 0232D7BE
	mov r0,#0x3c	; 0232D7C0
	and r1,r0	; 0232D7C2
	asr r0,r1,#0x2	; 0232D7C4
	lsl r2,r0,#0xe	; 0232D7C6
	ldr r0,[pool_0232D7E0]	; 0232D7C8
	ldr r1,[r0,#0x0]	; 0232D7CA
	ldr r0,[pool_0232D7E4]	; 0232D7CC
	and r1,r0	; 0232D7CE
	lsr r0,r1,#0x18	; 0232D7D0
	lsl r1,r0,#0x10	; 0232D7D2
	ldr r0,[pool_0232D7E8]	; 0232D7D4
	add r0,r1,r0	; 0232D7D6
	add r0,r2,r0	; 0232D7D8
	bx lr	; 0232D7DA
.endfunc
pool_0232D7DC:
loc_0232D7DC:
	.word REG_BG1CNT	; 0232D7DC
pool_0232D7E0:
loc_0232D7E0:
	.word REG_DISPCNT_A	; 0232D7E0
pool_0232D7E4:
loc_0232D7E4:
	.word 0x07000000	; 0232D7E4
pool_0232D7E8:
loc_0232D7E8:
	.word 0x06000000	; 0232D7E8

; ===== function loc_0232D7EC =====
; Returns the sub-engine BG0 character-base address.
; 返回副引擎 BG0 字符基址。
.func P1_GetSubBg0CharacterBase
loc_0232D7EC:
	ldr r0,[pool_0232D800]	; 0232D7EC
	ldrh r1,[r0,#0x0]	; 0232D7EE
	mov r0,#0x3c	; 0232D7F0
	and r1,r0	; 0232D7F2
	asr r0,r1,#0x2	; 0232D7F4
	lsl r1,r0,#0xe	; 0232D7F6
	ldr r0,[pool_0232D804]	; 0232D7F8
	add r0,r1,r0	; 0232D7FA
	bx lr	; 0232D7FC
.endfunc
	.byte 0xC0, 0x46	; 0232D800
pool_0232D800:
loc_0232D800:
	.word REG_BG0CNT_SUB	; 0232D800
pool_0232D804:
loc_0232D804:
	.word 0x06200000	; 0232D804
; ===== function loc_0232D818 =====
; Returns the main-engine BG0 character-base address.
; 返回主引擎 BG0 字符基址。
.func P1_GetMainBg0CharacterBase
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
	.word REG_BG0CNT	; 0232D838
pool_0232D83C:
	.word REG_DISPCNT_A	; 0232D83C
pool_0232D840:
	.word 0x07000000	; 0232D840
pool_0232D844:
	.word 0x06000000	; 0232D844

; ===== function loc_0232D838 =====
; Returns the sub-engine BG1 tilemap base from BG1CNT.
; 由 BG1CNT 返回副引擎 BG1 tilemap 基址。
.func P1_GetSubBg1TilemapBase
loc_0232D838:
	ldr r0,[pool_0232D84C]	; 0232D838
	ldrh r1,[r0,#0x0]	; 0232D83A
	ldr r0,[pool_0232D850]	; 0232D83C
	and r1,r0	; 0232D83E
	asr r0,r1,#0x8	; 0232D840
	lsl r1,r0,#0xb	; 0232D842
	ldr r0,[pool_0232D854]	; 0232D844
	add r0,r1,r0	; 0232D846
	bx lr	; 0232D848
.endfunc
	.byte 0xC0, 0x46	; 0232D84C
pool_0232D84C:
loc_0232D84C:
	.word REG_BG1CNT_SUB	; 0232D84C
pool_0232D850:
loc_0232D850:
	.word 0x00001F00	; 0232D850
pool_0232D854:
loc_0232D854:
	.word 0x06200000	; 0232D854

; ===== function loc_0232D858 =====
; Returns the main-engine BG1 tilemap base from BG1CNT and VRAM bank mode.
; 由 BG1CNT 与 VRAM bank 模式返回主引擎 BG1 tilemap 基址。
.func P1_GetMainBg1TilemapBase
loc_0232D858:
	ldr r0,[pool_0232D878]	; 0232D858
	ldrh r1,[r0,#0x0]	; 0232D85A
	ldr r0,[pool_0232D87C]	; 0232D85C
	and r1,r0	; 0232D85E
	asr r0,r1,#0x8	; 0232D860
	lsl r2,r0,#0xb	; 0232D862
	ldr r0,[pool_0232D880]	; 0232D864
	ldr r1,[r0,#0x0]	; 0232D866
	ldr r0,[pool_0232D884]	; 0232D868
	and r1,r0	; 0232D86A
	lsr r0,r1,#0x1b	; 0232D86C
	lsl r1,r0,#0x10	; 0232D86E
	ldr r0,[pool_0232D888]	; 0232D870
	add r0,r1,r0	; 0232D872
	add r0,r2,r0	; 0232D874
	bx lr	; 0232D876
.endfunc
pool_0232D878:
loc_0232D878:
	.word REG_BG1CNT	; 0232D878
pool_0232D87C:
loc_0232D87C:
	.word 0x00001F00	; 0232D87C
pool_0232D880:
loc_0232D880:
	.word REG_DISPCNT_A	; 0232D880
pool_0232D884:
loc_0232D884:
	.word 0x38000000	; 0232D884
pool_0232D888:
loc_0232D888:
	.word 0x06000000	; 0232D888

; ===== function loc_0232D88C =====
; Returns the sub-engine BG0 tilemap base from BG0CNT.
; 由 BG0CNT 返回副引擎 BG0 tilemap 基址。
.func P1_GetSubBg0TilemapBase
loc_0232D88C:
	ldr r0,[pool_0232D8A0]	; 0232D88C
	ldrh r1,[r0,#0x0]	; 0232D88E
	ldr r0,[pool_0232D8A4]	; 0232D890
	and r1,r0	; 0232D892
	asr r0,r1,#0x8	; 0232D894
	lsl r1,r0,#0xb	; 0232D896
	ldr r0,[pool_0232D8A8]	; 0232D898
	add r0,r1,r0	; 0232D89A
	bx lr	; 0232D89C
.endfunc
	.byte 0xC0, 0x46	; 0232D8A0
pool_0232D8A0:
loc_0232D8A0:
	.word REG_BG0CNT_SUB	; 0232D8A0
pool_0232D8A4:
loc_0232D8A4:
	.word 0x00001F00	; 0232D8A4
pool_0232D8A8:
loc_0232D8A8:
	.word 0x06200000	; 0232D8A8

; ===== function loc_0232D8AC =====
; Returns the main-engine BG0 tilemap base from BG0CNT and VRAM bank mode.
; 由 BG0CNT 与 VRAM bank 模式返回主引擎 BG0 tilemap 基址。
.func P1_GetMainBg0TilemapBase
loc_0232D8AC:
	ldr r0,[pool_0232D8CC]	; 0232D8AC
	ldrh r1,[r0,#0x0]	; 0232D8AE
	ldr r0,[pool_0232D8D0]	; 0232D8B0
	and r1,r0	; 0232D8B2
	asr r0,r1,#0x8	; 0232D8B4
	lsl r2,r0,#0xb	; 0232D8B6
	ldr r0,[pool_0232D8D4]	; 0232D8B8
	ldr r1,[r0,#0x0]	; 0232D8BA
	ldr r0,[pool_0232D8D8]	; 0232D8BC
	and r1,r0	; 0232D8BE
	lsr r0,r1,#0x1b	; 0232D8C0
	lsl r1,r0,#0x10	; 0232D8C2
	ldr r0,[pool_0232D8DC]	; 0232D8C4
	add r0,r1,r0	; 0232D8C6
	add r0,r2,r0	; 0232D8C8
	bx lr	; 0232D8CA
.endfunc
pool_0232D8CC:
loc_0232D8CC:
	.word REG_BG0CNT	; 0232D8CC
pool_0232D8D0:
loc_0232D8D0:
	.word 0x00001F00	; 0232D8D0
pool_0232D8D4:
loc_0232D8D4:
	.word REG_DISPCNT_A	; 0232D8D4
pool_0232D8D8:
loc_0232D8D8:
	.word 0x38000000	; 0232D8D8
pool_0232D8DC:
loc_0232D8DC:
	.word 0x06000000	; 0232D8DC

; ===== function loc_0232D8E0 =====
loc_0232D8E0:
	cmp r2,#0x0	; 0232D8E0
	bge loc_0232D8F0	; 0232D8E2
	mov r3,#0xc0	; 0232D8E4
	orr r1,r3	; 0232D8E6
	strh r1,[r0,#0x0]	; 0232D8E8
	neg r1,r2	; 0232D8EA
	strh r1,[r0,#0x4]	; 0232D8EC
	bx lr	; 0232D8EE
loc_0232D8F0:
	mov r3,#0x80	; 0232D8F0
	orr r1,r3	; 0232D8F2
	strh r1,[r0,#0x0]	; 0232D8F4
	strh r2,[r0,#0x4]	; 0232D8F6
	bx lr	; 0232D8F8
	.byte 0x00, 0x00	; 0232D8FC

; ===== function loc_0232D8FC =====
loc_0232D8FC:
	push {r4}	; 0232D8FC
	sub sp,#0x4	; 0232D8FE
	mov r4,#0x40	; 0232D900
	orr r1,r4	; 0232D902
	lsl r2,r2,#0x8	; 0232D904
	orr r1,r2	; 0232D906
	ldr r2,[sp,#0x8]	; 0232D908
	lsl r2,r2,#0x8	; 0232D90A
	orr r3,r2	; 0232D90C
	lsl r2,r3,#0x10	; 0232D90E
	orr r1,r2	; 0232D910
	str r1,[r0,#0x0]	; 0232D912
	add sp,#0x4	; 0232D914
	pop {r4}	; 0232D916
	bx lr	; 0232D918
	.byte 0x00, 0x00	; 0232D91C

; ===== function loc_0232D91C =====
P1_Entry_0232D91C:
	push {r4,r5,r6,lr}	; 0232D91C
	add r5,r0,#0x0	; 0232D91E
	add r4,r1,#0x0	; 0232D920
	add r6,r2,#0x0	; 0232D922
	bl loc_02326B84	; 0232D924
	add r2,r0,#0x0	; 0232D928
	ldr r0,[pool_0232D940]	; 0232D92A
	ldr r0,[r0,#0x0]	; 0232D92C
	add r1,r5,#0x0	; 0232D92E
	add r2,r2,r4	; 0232D930
	add r3,r6,#0x0	; 0232D932
	bl loc_0232DD68	; 0232D934
	pop {r4,r5,r6}	; 0232D938
	pop {r3}	; 0232D93A
	bx r3	; 0232D93C
	.byte 0xC0, 0x46	; 0232D940
pool_0232D940:
loc_0232D940:
	.word P1_Data_023307CC	; 0232D940

; ===== function loc_0232D944 =====
P1_Entry_0232D944:
	push {r4,r5,r6,lr}	; 0232D944
	add r5,r0,#0x0	; 0232D946
	add r4,r1,#0x0	; 0232D948
	add r6,r2,#0x0	; 0232D94A
	bl loc_02326BA0	; 0232D94C
	add r2,r0,#0x0	; 0232D950
	ldr r0,[pool_0232D968]	; 0232D952
	ldr r0,[r0,#0x0]	; 0232D954
	add r1,r5,#0x0	; 0232D956
	add r2,r2,r4	; 0232D958
	add r3,r6,#0x0	; 0232D95A
	bl loc_0232DD68	; 0232D95C
	pop {r4,r5,r6}	; 0232D960
	pop {r3}	; 0232D962
	bx r3	; 0232D964
	.byte 0xC0, 0x46	; 0232D968
pool_0232D968:
loc_0232D968:
	.word P1_Data_023307CC	; 0232D968
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xF9, 0xF7, 0x2C, 0xF9, 0x02, 0x1C, 0x05, 0x48	; 0232D97C
	.byte 0x00, 0x68, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C, 0x00, 0xF0, 0xF0, 0xF9, 0x70, 0xBC, 0x08, 0xBC	; 0232D98C
	.byte 0x18, 0x47, 0xC0, 0x46, 0xCC, 0x07, 0x33, 0x02	; 0232D994

; ===== function loc_0232D994 =====
loc_0232D994:
	push {r4,r5,r6,lr}	; 0232D994
	add r5,r0,#0x0	; 0232D996
	add r4,r1,#0x0	; 0232D998
	add r6,r2,#0x0	; 0232D99A
	bl loc_02326BEC	; 0232D99C
	add r2,r0,#0x0	; 0232D9A0
	ldr r0,[pool_0232D9B8]	; 0232D9A2
	ldr r0,[r0,#0x0]	; 0232D9A4
	add r1,r5,#0x0	; 0232D9A6
	add r2,r2,r4	; 0232D9A8
	add r3,r6,#0x0	; 0232D9AA
	bl loc_0232DD68	; 0232D9AC
	pop {r4,r5,r6}	; 0232D9B0
	pop {r3}	; 0232D9B2
	bx r3	; 0232D9B4
	.byte 0xC0, 0x46	; 0232D9B8
pool_0232D9B8:
loc_0232D9B8:
	.word P1_Data_023307CC	; 0232D9B8

; ===== function loc_0232D9BC =====
loc_0232D9BC:
	push {r4,r5,r6,lr}	; 0232D9BC
	add r5,r0,#0x0	; 0232D9BE
	add r4,r1,#0x0	; 0232D9C0
	add r6,r2,#0x0	; 0232D9C2
	bl P1_GetSubBg1CharacterBase	; 0232D9C4
	add r2,r0,#0x0	; 0232D9C8
	ldr r0,[pool_0232D9E0]	; 0232D9CA
	ldr r0,[r0,#0x0]	; 0232D9CC
	add r1,r5,#0x0	; 0232D9CE
	add r2,r2,r4	; 0232D9D0
	add r3,r6,#0x0	; 0232D9D2
	bl loc_0232DD68	; 0232D9D4
	pop {r4,r5,r6}	; 0232D9D8
	pop {r3}	; 0232D9DA
	bx r3	; 0232D9DC
	.byte 0xC0, 0x46	; 0232D9E0
pool_0232D9E0:
loc_0232D9E0:
	.word P1_Data_023307CC	; 0232D9E0

; ===== function loc_0232D9E4 =====
loc_0232D9E4:
	push {r4,r5,r6,lr}	; 0232D9E4
	add r5,r0,#0x0	; 0232D9E6
	add r4,r1,#0x0	; 0232D9E8
	add r6,r2,#0x0	; 0232D9EA
	bl P1_GetMainBg1CharacterBase	; 0232D9EC
	add r2,r0,#0x0	; 0232D9F0
	ldr r0,[pool_0232DA08]	; 0232D9F2
	ldr r0,[r0,#0x0]	; 0232D9F4
	add r1,r5,#0x0	; 0232D9F6
	add r2,r2,r4	; 0232D9F8
	add r3,r6,#0x0	; 0232D9FA
	bl loc_0232DD68	; 0232D9FC
	pop {r4,r5,r6}	; 0232DA00
	pop {r3}	; 0232DA02
	bx r3	; 0232DA04
	.byte 0xC0, 0x46	; 0232DA08
pool_0232DA08:
loc_0232DA08:
	.word P1_Data_023307CC	; 0232DA08

; ===== function loc_0232DA0C =====
	push {r4,r5,r6,lr}	; 0232DA0C
	add r5,r0,#0x0	; 0232DA0E
	add r4,r1,#0x0	; 0232DA10
	add r6,r2,#0x0	; 0232DA12
	bl P1_GetSubBg0CharacterBase	; 0232DA14
	add r2,r0,#0x0	; 0232DA18
	ldr r0,[pool_0232DA30]	; 0232DA1A
	ldr r0,[r0,#0x0]	; 0232DA1C
	add r1,r5,#0x0	; 0232DA1E
	add r2,r2,r4	; 0232DA20
	add r3,r6,#0x0	; 0232DA22
	bl loc_0232DD68	; 0232DA24
	pop {r4,r5,r6}	; 0232DA28
	pop {r3}	; 0232DA2A
	bx r3	; 0232DA2C
	.byte 0xC0, 0x46	; 0232DA30
pool_0232DA30:
loc_0232DA30:
	.word P1_Data_023307CC	; 0232DA30
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0xFF, 0xF7, 0xE4, 0xFE, 0x02, 0x1C, 0x05, 0x48	; 0232DA44
	.byte 0x00, 0x68, 0x29, 0x1C, 0x12, 0x19, 0x33, 0x1C, 0x00, 0xF0, 0x8C, 0xF9, 0x70, 0xBC, 0x08, 0xBC	; 0232DA54
	.byte 0x18, 0x47, 0xC0, 0x46, 0xCC, 0x07, 0x33, 0x02	; 0232DA5C

; ===== function loc_0232DA5C =====
loc_0232DA5C:
	push {r4,r5,r6,lr}	; 0232DA5C
	add r5,r0,#0x0	; 0232DA5E
	add r4,r1,#0x0	; 0232DA60
	add r6,r2,#0x0	; 0232DA62
	bl loc_02326C1C	; 0232DA64
	add r2,r0,#0x0	; 0232DA68
	ldr r0,[pool_0232DA80]	; 0232DA6A
	ldr r0,[r0,#0x0]	; 0232DA6C
	add r1,r5,#0x0	; 0232DA6E
	add r2,r2,r4	; 0232DA70
	add r3,r6,#0x0	; 0232DA72
	bl loc_0232DD28	; 0232DA74
	pop {r4,r5,r6}	; 0232DA78
	pop {r3}	; 0232DA7A
	bx r3	; 0232DA7C
	.byte 0xC0, 0x46	; 0232DA80
pool_0232DA80:
loc_0232DA80:
	.word P1_Data_023307CC	; 0232DA80

; ===== function loc_0232DA84 =====
loc_0232DA84:
	push {r4,r5,r6,lr}	; 0232DA84
	add r5,r0,#0x0	; 0232DA86
	add r4,r1,#0x0	; 0232DA88
	add r6,r2,#0x0	; 0232DA8A
	blx P1_GetMainBg3TilemapAddress	; 0232DA8C
	add r2,r0,#0x0	; 0232DA90
	ldr r0,[pool_0232DAA8]	; 0232DA92
	ldr r0,[r0,#0x0]	; 0232DA94
	add r1,r5,#0x0	; 0232DA96
	add r2,r2,r4	; 0232DA98
	add r3,r6,#0x0	; 0232DA9A
	bl loc_0232DD28	; 0232DA9C
	pop {r4,r5,r6}	; 0232DAA0
	pop {r3}	; 0232DAA2
	bx r3	; 0232DAA4
	.byte 0xC0, 0x46	; 0232DAA8
pool_0232DAA8:
loc_0232DAA8:
	.word P1_Data_023307CC	; 0232DAA8

; ===== function loc_0232DAAC =====
loc_0232DAAC:
	push {r4,r5,r6,lr}	; 0232DAAC
	add r5,r0,#0x0	; 0232DAAE
	add r4,r1,#0x0	; 0232DAB0
	add r6,r2,#0x0	; 0232DAB2
	bl loc_02326C70	; 0232DAB4
	add r2,r0,#0x0	; 0232DAB8
	ldr r0,[pool_0232DAD0]	; 0232DABA
	ldr r0,[r0,#0x0]	; 0232DABC
	add r1,r5,#0x0	; 0232DABE
	add r2,r2,r4	; 0232DAC0
	add r3,r6,#0x0	; 0232DAC2
	bl loc_0232DD28	; 0232DAC4
	pop {r4,r5,r6}	; 0232DAC8
	pop {r3}	; 0232DACA
	bx r3	; 0232DACC
	.byte 0xC0, 0x46	; 0232DAD0
pool_0232DAD0:
loc_0232DAD0:
	.word P1_Data_023307CC	; 0232DAD0

; ===== function loc_0232DAD4 =====
loc_0232DAD4:
	push {r4,r5,r6,lr}	; 0232DAD4
	add r5,r0,#0x0	; 0232DAD6
	add r4,r1,#0x0	; 0232DAD8
	add r6,r2,#0x0	; 0232DADA
	blx P1_GetMainBg2TilemapAddress	; 0232DADC
	add r2,r0,#0x0	; 0232DAE0
	ldr r0,[pool_0232DAF8]	; 0232DAE2
	ldr r0,[r0,#0x0]	; 0232DAE4
	add r1,r5,#0x0	; 0232DAE6
	add r2,r2,r4	; 0232DAE8
	add r3,r6,#0x0	; 0232DAEA
	bl loc_0232DD28	; 0232DAEC
	pop {r4,r5,r6}	; 0232DAF0
	pop {r3}	; 0232DAF2
	bx r3	; 0232DAF4
	.byte 0xC0, 0x46	; 0232DAF8
pool_0232DAF8:
loc_0232DAF8:
	.word P1_Data_023307CC	; 0232DAF8

; ===== function loc_0232DAFC =====
loc_0232DAFC:
	push {r4,r5,r6,lr}	; 0232DAFC
	add r5,r0,#0x0	; 0232DAFE
	add r4,r1,#0x0	; 0232DB00
	add r6,r2,#0x0	; 0232DB02
	bl P1_GetSubBg1TilemapBase	; 0232DB04
	add r2,r0,#0x0	; 0232DB08
	ldr r0,[pool_0232DB20]	; 0232DB0A
	ldr r0,[r0,#0x0]	; 0232DB0C
	add r1,r5,#0x0	; 0232DB0E
	add r2,r2,r4	; 0232DB10
	add r3,r6,#0x0	; 0232DB12
	bl loc_0232DD28	; 0232DB14
	pop {r4,r5,r6}	; 0232DB18
	pop {r3}	; 0232DB1A
	bx r3	; 0232DB1C
	.byte 0xC0, 0x46	; 0232DB20
pool_0232DB20:
loc_0232DB20:
	.word P1_Data_023307CC	; 0232DB20

; ===== function loc_0232DB24 =====
loc_0232DB24:
	push {r4,r5,r6,lr}	; 0232DB24
	add r5,r0,#0x0	; 0232DB26
	add r4,r1,#0x0	; 0232DB28
	add r6,r2,#0x0	; 0232DB2A
	bl P1_GetMainBg1TilemapBase	; 0232DB2C
	add r2,r0,#0x0	; 0232DB30
	ldr r0,[pool_0232DB48]	; 0232DB32
	ldr r0,[r0,#0x0]	; 0232DB34
	add r1,r5,#0x0	; 0232DB36
	add r2,r2,r4	; 0232DB38
	add r3,r6,#0x0	; 0232DB3A
	bl loc_0232DD28	; 0232DB3C
	pop {r4,r5,r6}	; 0232DB40
	pop {r3}	; 0232DB42
	bx r3	; 0232DB44
	.byte 0xC0, 0x46	; 0232DB48
pool_0232DB48:
loc_0232DB48:
	.word P1_Data_023307CC	; 0232DB48

; ===== function loc_0232DB4C =====
loc_0232DB4C:
	push {r4,r5,r6,lr}	; 0232DB4C
	add r5,r0,#0x0	; 0232DB4E
	add r4,r1,#0x0	; 0232DB50
	add r6,r2,#0x0	; 0232DB52
	bl P1_GetSubBg0TilemapBase	; 0232DB54
	add r2,r0,#0x0	; 0232DB58
	ldr r0,[pool_0232DB70]	; 0232DB5A
	ldr r0,[r0,#0x0]	; 0232DB5C
	add r1,r5,#0x0	; 0232DB5E
	add r2,r2,r4	; 0232DB60
	add r3,r6,#0x0	; 0232DB62
	bl loc_0232DD28	; 0232DB64
	pop {r4,r5,r6}	; 0232DB68
	pop {r3}	; 0232DB6A
	bx r3	; 0232DB6C
	.byte 0xC0, 0x46	; 0232DB70
pool_0232DB70:
loc_0232DB70:
	.word P1_Data_023307CC	; 0232DB70

; ===== function loc_0232DB74 =====
	push {r4,r5,r6,lr}	; 0232DB74
	add r5,r0,#0x0	; 0232DB76
	add r4,r1,#0x0	; 0232DB78
	add r6,r2,#0x0	; 0232DB7A
	bl P1_GetMainBg0TilemapBase	; 0232DB7C
	add r2,r0,#0x0	; 0232DB80
	ldr r0,[pool_0232DB98]	; 0232DB82
	ldr r0,[r0,#0x0]	; 0232DB84
	add r1,r5,#0x0	; 0232DB86
	add r2,r2,r4	; 0232DB88
	add r3,r6,#0x0	; 0232DB8A
	bl loc_0232DD28	; 0232DB8C
	pop {r4,r5,r6}	; 0232DB90
	pop {r3}	; 0232DB92
	bx r3	; 0232DB94
	.byte 0xC0, 0x46	; 0232DB98
pool_0232DB98:
loc_0232DB98:
	.word P1_Data_023307CC	; 0232DB98

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
	bl loc_0232DD68	; 0232DBB0
	add sp,#0x4	; 0232DBB4
	pop {r4,r5}	; 0232DBB6
	pop {r3}	; 0232DBB8
	bx r3	; 0232DBBA
pool_0232DBBC:
loc_0232DBBC:
	.word P1_Data_023307CC	; 0232DBBC
pool_0232DBC0:
loc_0232DBC0:
	.word 0x06600000	; 0232DBC0

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
	bl loc_0232DD68	; 0232DBD8
	add sp,#0x4	; 0232DBDC
	pop {r4,r5}	; 0232DBDE
	pop {r3}	; 0232DBE0
	bx r3	; 0232DBE2
pool_0232DBE4:
loc_0232DBE4:
	.word P1_Data_023307CC	; 0232DBE4
pool_0232DBE8:
loc_0232DBE8:
	.word 0x06400000	; 0232DBE8

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
	bl loc_0232DD68	; 0232DC00
	add sp,#0x4	; 0232DC04
	pop {r4,r5}	; 0232DC06
	pop {r3}	; 0232DC08
	bx r3	; 0232DC0A
pool_0232DC0C:
loc_0232DC0C:
	.word P1_Data_023307CC	; 0232DC0C
pool_0232DC10:
loc_0232DC10:
	.word 0x07000400	; 0232DC10

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
	bl loc_0232DD68	; 0232DC28
	add sp,#0x4	; 0232DC2C
	pop {r4,r5}	; 0232DC2E
	pop {r3}	; 0232DC30
	bx r3	; 0232DC32
pool_0232DC34:
loc_0232DC34:
	.word P1_Data_023307CC	; 0232DC34
pool_0232DC38:
loc_0232DC38:
	.word 0x07000000	; 0232DC38

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
	bl loc_0232DD28	; 0232DC50
	add sp,#0x4	; 0232DC54
	pop {r4,r5}	; 0232DC56
	pop {r3}	; 0232DC58
	bx r3	; 0232DC5A
pool_0232DC5C:
loc_0232DC5C:
	.word P1_Data_023307CC	; 0232DC5C
pool_0232DC60:
loc_0232DC60:
	.word 0x05000600	; 0232DC60

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
	bl loc_0232DD28	; 0232DC78
	add sp,#0x4	; 0232DC7C
	pop {r4,r5}	; 0232DC7E
	pop {r3}	; 0232DC80
	bx r3	; 0232DC82
pool_0232DC84:
loc_0232DC84:
	.word P1_Data_023307CC	; 0232DC84
pool_0232DC88:
loc_0232DC88:
	.word 0x05000200	; 0232DC88

; ===== function loc_0232DC8C =====
loc_0232DC8C:
	push {r4,r5,lr}	; 0232DC8C
	sub sp,#0x4	; 0232DC8E
	add r5,r0,#0x0	; 0232DC90
	add r4,r1,#0x0	; 0232DC92
	add r3,r2,#0x0	; 0232DC94
	ldr r0,[pool_0232DCAC]	; 0232DC96
	ldr r0,[r0,#0x0]	; 0232DC98
	add r1,r5,#0x0	; 0232DC9A
	ldr r2,[pool_0232DCB0]	; 0232DC9C
	add r2,r4,r2	; 0232DC9E
	bl loc_0232DD28	; 0232DCA0
	add sp,#0x4	; 0232DCA4
	pop {r4,r5}	; 0232DCA6
	pop {r3}	; 0232DCA8
	bx r3	; 0232DCAA
pool_0232DCAC:
loc_0232DCAC:
	.word P1_Data_023307CC	; 0232DCAC
pool_0232DCB0:
loc_0232DCB0:
	.word 0x05000400	; 0232DCB0

; ===== function loc_0232DCB4 =====
loc_0232DCB4:
	push {r4,r5,lr}	; 0232DCB4
	sub sp,#0x4	; 0232DCB6
	add r5,r0,#0x0	; 0232DCB8
	add r4,r1,#0x0	; 0232DCBA
	add r3,r2,#0x0	; 0232DCBC
	ldr r0,[pool_0232DCD4]	; 0232DCBE
	ldr r0,[r0,#0x0]	; 0232DCC0
	add r1,r5,#0x0	; 0232DCC2
	ldr r2,[pool_0232DCD8]	; 0232DCC4
	add r2,r4,r2	; 0232DCC6
	bl loc_0232DD28	; 0232DCC8
	add sp,#0x4	; 0232DCCC
	pop {r4,r5}	; 0232DCCE
	pop {r3}	; 0232DCD0
	bx r3	; 0232DCD2
pool_0232DCD4:
loc_0232DCD4:
	.word P1_Data_023307CC	; 0232DCD4
pool_0232DCD8:
loc_0232DCD8:
	.word 0x05000000	; 0232DCD8

; ===== function loc_0232DCDC =====
loc_0232DCDC:
	ldr r1,[pool_0232DCE4]	; 0232DCDC
	strb r0,[r1,#0x0]	; 0232DCDE
	bx lr	; 0232DCE0
	.byte 0xC0, 0x46	; 0232DCE4
pool_0232DCE4:
loc_0232DCE4:
	.word REG_WRAMCNT	; 0232DCE4

; ===== function loc_0232DCE8 =====
loc_0232DCE8:
	push {r4,lr}	; 0232DCE8
	add r4,r0,#0x0	; 0232DCEA
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232DCEC
	mov r1,#0x6	; 0232DCF0
	mul r4,r1	; 0232DCF2
	add r1,r4,#0x5	; 0232DCF4
	lsl r2,r1,#0x1	; 0232DCF6
	ldr r1,[pool_0232DD1C]	; 0232DCF8
	add r2,r2,r1	; 0232DCFA
	ldrh r3,[r2,#0x0]	; 0232DCFC
	ldr r1,[pool_0232DD20]	; 0232DCFE
	and r3,r1	; 0232DD00
	strh r3,[r2,#0x0]	; 0232DD02
	ldrh r3,[r2,#0x0]	; 0232DD04
	ldr r1,[pool_0232DD24]	; 0232DD06
	and r3,r1	; 0232DD08
	strh r3,[r2,#0x0]	; 0232DD0A
	ldrh r1,[r2,#0x0]	; 0232DD0C
	ldrh r1,[r2,#0x0]	; 0232DD0E
	blx P1_Arm9RestoreIrqMask	; 0232DD10
	pop {r4}	; 0232DD14
	pop {r3}	; 0232DD16
	bx r3	; 0232DD18
	.byte 0xC0, 0x46	; 0232DD1C
pool_0232DD1C:
loc_0232DD1C:
	.word REG_DMA0SAD	; 0232DD1C
pool_0232DD20:
loc_0232DD20:
	.word 0xFFFFC5FF	; 0232DD20
pool_0232DD24:
loc_0232DD24:
	.word 0xFFFF7FFF	; 0232DD24

; ===== function loc_0232DD28 =====
loc_0232DD28:
	push {r4,r5,r6,lr}	; 0232DD28
	cmp r3,#0x0	; 0232DD2A
	beq loc_0232DD5A	; 0232DD2C
	mov r4,#0x3	; 0232DD2E
	add r5,r0,#0x0	; 0232DD30
	mul r5,r4	; 0232DD32
	add r4,r5,#0x2	; 0232DD34
	lsl r5,r4,#0x2	; 0232DD36
	ldr r4,[pool_0232DD60]	; 0232DD38
	add r4,r5,r4	; 0232DD3A
	ldr r5,[pool_0232DD64]	; 0232DD3C
loc_0232DD3E:
	ldr r6,[r4,#0x0]	; 0232DD3E
	and r6,r5	; 0232DD40
	cmp r6,#0x0	; 0232DD42
	bne loc_0232DD3E	; 0232DD44
	lsr r3,r3,#0x1	; 0232DD46
	ldr r5,[pool_0232DD64]	; 0232DD48
	orr r3,r5	; 0232DD4A
	bl P1_SetDmaChannelRegisters	; 0232DD4C
	lsl r0,r5,#0	; 0232DD50
loc_0232DD52:
	ldr r1,[r4,#0x0]	; 0232DD52
	and r1,r0	; 0232DD54
	cmp r1,#0x0	; 0232DD56
	bne loc_0232DD52	; 0232DD58
loc_0232DD5A:
	pop {r4,r5,r6}	; 0232DD5A
	pop {r3}	; 0232DD5C
	bx r3	; 0232DD5E
pool_0232DD60:
loc_0232DD60:
	.word REG_DMA0SAD	; 0232DD60
pool_0232DD64:
loc_0232DD64:
	.word 0x80000000	; 0232DD64

; ===== function loc_0232DD68 =====
loc_0232DD68:
	push {r4,r5,r6,lr}	; 0232DD68
	cmp r3,#0x0	; 0232DD6A
	beq loc_0232DD9A	; 0232DD6C
	mov r4,#0x3	; 0232DD6E
	add r5,r0,#0x0	; 0232DD70
	mul r5,r4	; 0232DD72
	add r4,r5,#0x2	; 0232DD74
	lsl r5,r4,#0x2	; 0232DD76
	ldr r4,[pool_0232DDA0]	; 0232DD78
	add r4,r5,r4	; 0232DD7A
	ldr r5,[pool_0232DDA4]	; 0232DD7C
loc_0232DD7E:
	ldr r6,[r4,#0x0]	; 0232DD7E
	and r6,r5	; 0232DD80
	cmp r6,#0x0	; 0232DD82
	bne loc_0232DD7E	; 0232DD84
	lsr r3,r3,#0x2	; 0232DD86
	ldr r5,[pool_0232DDA8]	; 0232DD88
	orr r3,r5	; 0232DD8A
	bl P1_SetDmaChannelRegisters	; 0232DD8C
	ldr r0,[pool_0232DDA4]	; 0232DD90
loc_0232DD92:
	ldr r1,[r4,#0x0]	; 0232DD92
	and r1,r0	; 0232DD94
	cmp r1,#0x0	; 0232DD96
	bne loc_0232DD92	; 0232DD98
loc_0232DD9A:
	pop {r4,r5,r6}	; 0232DD9A
	pop {r3}	; 0232DD9C
	bx r3	; 0232DD9E
pool_0232DDA0:
loc_0232DDA0:
	.word REG_DMA0SAD	; 0232DDA0
pool_0232DDA4:
loc_0232DDA4:
	.word 0x80000000	; 0232DDA4
pool_0232DDA8:
loc_0232DDA8:
	.word 0x84000000	; 0232DDA8
.arm

; ===== function loc_0232DDAC =====
loc_0232DDAC:
	mov r3,#0x0	; 0232DDAC
loc_0232DDB0:
	cmp r3,r2	; 0232DDB0
	strlth r0,[r1,r3]	; 0232DDB4
	addlt r3,r3,#0x2	; 0232DDB8
	blt loc_0232DDB0	; 0232DDBC
	bx lr	; 0232DDC0

; ===== function loc_0232DDC4 =====
loc_0232DDC4:
	mov r12,#0x0	; 0232DDC4
loc_0232DDC8:
	cmp r12,r2	; 0232DDC8
	ldrlth r3,[r0,r12]	; 0232DDCC
	strlth r3,[r1,r12]	; 0232DDD0
	addlt r12,r12,#0x2	; 0232DDD4
	blt loc_0232DDC8	; 0232DDD8
	bx lr	; 0232DDDC

; ===== function loc_0232DDE0 =====
; r0=填充值，r1=目标，r2=字节数；按 32 位字写入。
; r0=value, r1=destination, r2=byte count; fills in 32-bit words.
P1_MemFill32:
loc_0232DDE0:
	add r12,r1,r2	; 0232DDE0
loc_0232DDE4:
	cmp r1,r12	; 0232DDE4
	stmltia r1!,{r0}	; 0232DDE8
	blt loc_0232DDE4	; 0232DDEC
	bx lr	; 0232DDF0

; ===== function loc_0232DDF4 =====
; r0=源，r1=目标，r2=字节数；按 32 位字复制。
; r0=source, r1=destination, r2=byte count; copies 32-bit words.
P1_MemCopy32:
loc_0232DDF4:
	add r12,r1,r2	; 0232DDF4
loc_0232DDF8:
	cmp r1,r12	; 0232DDF8
	ldmltia r0!,{r2}	; 0232DDFC
	stmltia r1!,{r2}	; 0232DE00
	blt loc_0232DDF8	; 0232DE04
	bx lr	; 0232DE08

; ===== function loc_0232DE0C =====
loc_0232DE0C:
	stmdb sp!,{r4,r5,r6,r7,r8,r9}	; 0232DE0C
	add r9,r1,r2	; 0232DE10
	mov r12,r2, lsr #0x5	; 0232DE14
	add r12,r1,r12, lsl #0x5	; 0232DE18
	mov r2,r0	; 0232DE1C
	mov r3,r2	; 0232DE20
	mov r4,r2	; 0232DE24
	mov r5,r2	; 0232DE28
	mov r6,r2	; 0232DE2C
	mov r7,r2	; 0232DE30
	mov r8,r2	; 0232DE34
loc_0232DE38:
	cmp r1,r12	; 0232DE38
	stmltia r1!,{r0,r2,r3,r4,r5,r6,r7,r8}	; 0232DE3C
	blt loc_0232DE38	; 0232DE40
loc_0232DE44:
	cmp r1,r9	; 0232DE44
	stmltia r1!,{r0}	; 0232DE48
	blt loc_0232DE44	; 0232DE4C
	ldmia sp!,{r4,r5,r6,r7,r8,r9}	; 0232DE50
	bx lr	; 0232DE54

; ===== function loc_0232DE58 =====
loc_0232DE58:
	stmdb sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232DE58
	add r10,r1,r2	; 0232DE5C
	mov r12,r2, lsr #0x5	; 0232DE60
	add r12,r1,r12, lsl #0x5	; 0232DE64
loc_0232DE68:
	cmp r1,r12	; 0232DE68
	ldmltia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232DE6C
	stmltia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}	; 0232DE70
	blt loc_0232DE68	; 0232DE74
loc_0232DE78:
	cmp r1,r10	; 0232DE78
	ldmltia r0!,{r2}	; 0232DE7C
	stmltia r1!,{r2}	; 0232DE80
	blt loc_0232DE78	; 0232DE84
	ldmia sp!,{r4,r5,r6,r7,r8,r9,r10}	; 0232DE88
	bx lr	; 0232DE8C

; ===== function loc_0232DE90 =====
loc_0232DE90:
	mov r12,#0x0	; 0232DE90
loc_0232DE94:
	cmp r12,r2	; 0232DE94
	strltb r1,[r0,r12]	; 0232DE98
	addlt r12,r12,#0x1	; 0232DE9C
	blt loc_0232DE94	; 0232DEA0
	bx lr	; 0232DEA4
P1_Entry_0232DEA8:
	mov r12,#0x0	; 0232DEA8
P1_Entry_0232DEAC:
	cmp r12,r2	; 0232DEAC
	ldrltb r3,[r0,r12]	; 0232DEB0
	strltb r3,[r1,r12]	; 0232DEB4
	addlt r12,r12,#0x1	; 0232DEB8
	blt P1_Entry_0232DEAC	; 0232DEBC
	bx lr	; 0232DEC0

; ===== function loc_0232DEC4 =====
loc_0232DEC4:
	swp r0,r0,[r1]	; 0232DEC4
	bx lr	; 0232DEC8
.thumb

; ===== function loc_0232DECC =====
loc_0232DECC:
	push {lr}	; 0232DECC
	sub sp,#0x4	; 0232DECE
	ldr r0,[pool_0232DEEC]	; 0232DED0
	ldr r1,[r0,#0x0]	; 0232DED2
	cmp r1,#0x0	; 0232DED4
	bne loc_0232DEE4	; 0232DED6
	mov r1,#0x1	; 0232DED8
	str r1,[r0,#0x0]	; 0232DEDA
	bl loc_0232E500	; 0232DEDC
	bl loc_0232E624	; 0232DEE0
loc_0232DEE4:
	add sp,#0x4	; 0232DEE4
	pop {r3}	; 0232DEE6
	bx r3	; 0232DEE8
	.byte 0xC0, 0x46	; 0232DEEC
pool_0232DEEC:
loc_0232DEEC:
	.word P1_BssStart + 0x266CC	; 0232DEEC

; ===== function loc_0232DEF0 =====
loc_0232DEF0:
	push {r4,r5,r6,r7,lr}	; 0232DEF0
	sub sp,#0x4	; 0232DEF2
	add r5,r0,#0x0	; 0232DEF4
	add r4,r1,#0x0	; 0232DEF6
	add r6,r2,#0x0	; 0232DEF8
	add r7,r3,#0x0	; 0232DEFA
	mov r0,#0x1	; 0232DEFC
; 填充请求记录的命令与四个参数，并将其追加到待处理链。
; Fill a request record with a command and four arguments, then append it to the pending chain.
.func P1_QueueRequestRecord
	bl P1_AcquireRequestRecord	; 0232DEFE
	cmp r0,#0x0	; 0232DF02
	beq loc_0232DF16	; 0232DF04
	str r5,[r0,#P1_RequestRecordCommandOffset]	; 0232DF06
	str r4,[r0,#P1_RequestRecordArgument0Offset]	; 0232DF08
	str r6,[r0,#P1_RequestRecordArgument1Offset]	; 0232DF0A
	str r7,[r0,#P1_RequestRecordArgument2Offset]	; 0232DF0C
	ldr r1,[sp,#0x18]	; 0232DF0E
	str r1,[r0,#P1_RequestRecordArgument3Offset]	; 0232DF10
	bl P1_EnqueueRequestRecord	; 0232DF12
loc_0232DF16:
	add sp,#0x4	; 0232DF16
	pop {r4,r5,r6,r7}	; 0232DF18
	pop {r3}	; 0232DF1A
	bx r3	; 0232DF1C
	.byte 0x00, 0x00	; 0232DF20

; ===== function loc_0232DF20 =====
loc_0232DF20:
	push {lr}	; 0232DF20
	sub sp,#0x4	; 0232DF22
	add r1,r0,#0x0	; 0232DF24
.endfunc
	mov r2,#0x0	; 0232DF26
	str r2,[sp,#0x0]	; 0232DF28
	mov r0,#0x13	; 0232DF2A
	add r3,r2,#0x0	; 0232DF2C
	bl P1_QueueRequestRecord	; 0232DF2E
	add sp,#0x4	; 0232DF32
	pop {r3}	; 0232DF34
	bx r3	; 0232DF36

; ===== function loc_0232DF38 =====
loc_0232DF38:
	push {r4,r5,r6,lr}	; 0232DF38
	sub sp,#0x8	; 0232DF3A
	add r6,r0,#0x0	; 0232DF3C
	add r5,r1,#0x0	; 0232DF3E
	add r4,r2,#0x0	; 0232DF40
	str r3,[sp,#0x0]	; 0232DF42
	mov r0,#0x4	; 0232DF44
	ldr r1,[sp,#0x18]	; 0232DF46
	lsl r1,r1,#0x18	; 0232DF48
	orr r1,r6	; 0232DF4A
	add r2,r5,#0x0	; 0232DF4C
	add r3,r4,#0x0	; 0232DF4E
	bl P1_QueueRequestRecord	; 0232DF50
	add sp,#0x8	; 0232DF54
	pop {r4,r5,r6}	; 0232DF56
	pop {r3}	; 0232DF58
	bx r3	; 0232DF5A

; ===== function loc_0232DF5C =====
loc_0232DF5C:
	push {r4,r5,r6,lr}	; 0232DF5C
	sub sp,#0x8	; 0232DF5E
	add r6,r0,#0x0	; 0232DF60
	add r5,r1,#0x0	; 0232DF62
	add r4,r2,#0x0	; 0232DF64
	str r3,[sp,#0x0]	; 0232DF66
	mov r0,#0x3	; 0232DF68
	add r1,r6,#0x0	; 0232DF6A
	add r2,r5,#0x0	; 0232DF6C
	add r3,r4,#0x0	; 0232DF6E
	bl P1_QueueRequestRecord	; 0232DF70
	add sp,#0x8	; 0232DF74
	pop {r4,r5,r6}	; 0232DF76
	pop {r3}	; 0232DF78
	bx r3	; 0232DF7A

; ===== function loc_0232DF7C =====
loc_0232DF7C:
	push {r4,r5,r6,lr}	; 0232DF7C
	sub sp,#0x8	; 0232DF7E
	add r6,r0,#0x0	; 0232DF80
	add r5,r1,#0x0	; 0232DF82
	add r4,r2,#0x0	; 0232DF84
	str r3,[sp,#0x0]	; 0232DF86
	mov r0,#0x15	; 0232DF88
	add r1,r6,#0x0	; 0232DF8A
	add r2,r5,#0x0	; 0232DF8C
	add r3,r4,#0x0	; 0232DF8E
	bl P1_QueueRequestRecord	; 0232DF90
	add sp,#0x8	; 0232DF94
	pop {r4,r5,r6}	; 0232DF96
	pop {r3}	; 0232DF98
	bx r3	; 0232DF9A

; ===== function loc_0232DF9C =====
loc_0232DF9C:
	push {r4,r5,lr}	; 0232DF9C
	sub sp,#0x4	; 0232DF9E
	add r5,r0,#0x0	; 0232DFA0
	ldr r4,[sp,#0x10]	; 0232DFA2
	ldr r0,[sp,#0x24]	; 0232DFA4
	lsl r0,r0,#0x10	; 0232DFA6
	lsl r3,r3,#0x1a	; 0232DFA8
	lsl r1,r1,#0x18	; 0232DFAA
	orr r3,r1	; 0232DFAC
	orr r0,r3	; 0232DFAE
	orr r4,r0	; 0232DFB0
	str r4,[sp,#0x0]	; 0232DFB2
	mov r0,#0xb	; 0232DFB4
	ldr r1,[sp,#0x20]	; 0232DFB6
	lsl r1,r1,#0x10	; 0232DFB8
	orr r1,r5	; 0232DFBA
	ldr r3,[sp,#0x14]	; 0232DFBC
	ldr r4,[sp,#0x18]	; 0232DFBE
	lsl r5,r4,#0x18	; 0232DFC0
	ldr r4,[sp,#0x1c]	; 0232DFC2
	lsl r4,r4,#0x16	; 0232DFC4
	orr r5,r4	; 0232DFC6
	orr r3,r5	; 0232DFC8
	bl P1_QueueRequestRecord	; 0232DFCA
	add sp,#0x4	; 0232DFCE
	pop {r4,r5}	; 0232DFD0
	pop {r3}	; 0232DFD2
	bx r3	; 0232DFD4
	.byte 0x00, 0x00	; 0232DFD8

; ===== function loc_0232DFD8 =====
loc_0232DFD8:
	push {r4,r5,lr}	; 0232DFD8
	sub sp,#0x4	; 0232DFDA
	add r5,r0,#0x0	; 0232DFDC
	add r4,r1,#0x0	; 0232DFDE
	add r3,r2,#0x0	; 0232DFE0
	mov r0,#0x0	; 0232DFE2
	str r0,[sp,#0x0]	; 0232DFE4
	mov r0,#0x11	; 0232DFE6
	add r1,r5,#0x0	; 0232DFE8
	add r2,r4,#0x0	; 0232DFEA
	bl P1_QueueRequestRecord	; 0232DFEC
	add sp,#0x4	; 0232DFF0
	pop {r4,r5}	; 0232DFF2
	pop {r3}	; 0232DFF4
	bx r3	; 0232DFF6

; ===== function loc_0232DFF8 =====
loc_0232DFF8:
	push {r4,lr}	; 0232DFF8
	sub sp,#0x8	; 0232DFFA
	add r4,r0,#0x0	; 0232DFFC
	add r2,r1,#0x0	; 0232DFFE
	mov r3,#0x0	; 0232E000
	str r3,[sp,#0x0]	; 0232E002
	mov r0,#0x17	; 0232E004
	add r1,r4,#0x0	; 0232E006
	bl P1_QueueRequestRecord	; 0232E008
	add sp,#0x8	; 0232E00C
	pop {r4}	; 0232E00E
	pop {r3}	; 0232E010
	bx r3	; 0232E012

; ===== function loc_0232E014 =====
loc_0232E014:
	push {r4,lr}	; 0232E014
	sub sp,#0x8	; 0232E016
	add r4,r0,#0x0	; 0232E018
	add r2,r1,#0x0	; 0232E01A
	mov r3,#0x0	; 0232E01C
	str r3,[sp,#0x0]	; 0232E01E
	mov r0,#0x16	; 0232E020
	add r1,r4,#0x0	; 0232E022
	bl P1_QueueRequestRecord	; 0232E024
	add sp,#0x8	; 0232E028
	pop {r4}	; 0232E02A
	pop {r3}	; 0232E02C
	bx r3	; 0232E02E

; ===== function loc_0232E030 =====
loc_0232E030:
	push {r4,r5,r6,lr}	; 0232E030
	sub sp,#0x8	; 0232E032
	add r5,r0,#0x0	; 0232E034
	add r4,r1,#0x0	; 0232E036
	add r6,r2,#0x0	; 0232E038
	add r1,r3,#0x0	; 0232E03A
	ldr r2,[sp,#0x18]	; 0232E03C
	bl loc_0232E5E4	; 0232E03E
	str r0,[sp,#0x0]	; 0232E042
	mov r0,#0xf	; 0232E044
	add r1,r5,#0x0	; 0232E046
	add r2,r4,#0x0	; 0232E048
	add r3,r6,#0x0	; 0232E04A
	bl P1_QueueRequestRecord	; 0232E04C
	add sp,#0x8	; 0232E050
	pop {r4,r5,r6}	; 0232E052
	pop {r3}	; 0232E054
	bx r3	; 0232E056

; ===== function loc_0232E058 =====
loc_0232E058:
	push {r4,r5,r6,r7,lr}	; 0232E058
	sub sp,#0xc	; 0232E05A
	add r6,r0,#0x0	; 0232E05C
	str r1,[sp,#0x4]	; 0232E05E
	mov r0,#0x0	; 0232E060
	str r0,[sp,#0x0]	; 0232E062
	mov r0,#0xe	; 0232E064
	add r1,r2,#0x0	; 0232E066
	add r2,r3,#0x0	; 0232E068
	ldr r3,[sp,#0x28]	; 0232E06A
	lsl r7,r3,#0x1b	; 0232E06C
	ldr r3,[sp,#0x24]	; 0232E06E
	lsl r5,r3,#0x1c	; 0232E070
	ldr r3,[sp,#0x20]	; 0232E072
	lsl r4,r3,#0x1d	; 0232E074
	lsl r3,r6,#0x1f	; 0232E076
	ldr r6,[sp,#0x4]	; 0232E078
	lsl r6,r6,#0x1e	; 0232E07A
	orr r3,r6	; 0232E07C
	orr r4,r3	; 0232E07E
	orr r5,r4	; 0232E080
	orr r7,r5	; 0232E082
	add r3,r7,#0x0	; 0232E084
	bl P1_QueueRequestRecord	; 0232E086
	add sp,#0xc	; 0232E08A
	pop {r4,r5,r6,r7}	; 0232E08C
	pop {r3}	; 0232E08E
	bx r3	; 0232E090
	.byte 0x00, 0x00	; 0232E094

; ===== function loc_0232E094 =====
loc_0232E094:
	push {r4,r5,r6,r7,lr}	; 0232E094
	sub sp,#0x14	; 0232E096
	str r0,[sp,#0x4]	; 0232E098
	str r1,[sp,#0x8]	; 0232E09A
	add r7,r2,#0x0	; 0232E09C
	str r3,[sp,#0xc]	; 0232E09E
	add r4,r7,#0x0	; 0232E0A0
	mov r5,#0x0	; 0232E0A2
	mov r6,#0x1	; 0232E0A4
	b loc_0232E0BA	; 0232E0A6
loc_0232E0A8:
	add r0,r4,#0x0	; 0232E0A8
	and r0,r6	; 0232E0AA
	cmp r0,#0x0	; 0232E0AC
	beq loc_0232E0B6	; 0232E0AE
	add r0,r5,#0x0	; 0232E0B0
	bl loc_0232E60C	; 0232E0B2
loc_0232E0B6:
	add r5,r5,#0x1	; 0232E0B6
	lsr r4,r4,#0x1	; 0232E0B8
loc_0232E0BA:
	cmp r5,#0x8	; 0232E0BA
	bge loc_0232E0C2	; 0232E0BC
	cmp r4,#0x0	; 0232E0BE
	bne loc_0232E0A8	; 0232E0C0
loc_0232E0C2:
	ldr r0,[sp,#0xc]	; 0232E0C2
	str r0,[sp,#0x0]	; 0232E0C4
	mov r0,#0xa	; 0232E0C6
	ldr r1,[sp,#0x4]	; 0232E0C8
	ldr r2,[sp,#0x8]	; 0232E0CA
	add r3,r7,#0x0	; 0232E0CC
	bl P1_QueueRequestRecord	; 0232E0CE
	add sp,#0x14	; 0232E0D2
	pop {r4,r5,r6,r7}	; 0232E0D4
	pop {r3}	; 0232E0D6
	bx r3	; 0232E0D8
	.byte 0x00, 0x00	; 0232E0DC

; ===== function loc_0232E0DC =====
loc_0232E0DC:
	push {r4,r5,r6,lr}	; 0232E0DC
	sub sp,#0x8	; 0232E0DE
	add r6,r0,#0x0	; 0232E0E0
	add r5,r1,#0x0	; 0232E0E2
	add r4,r2,#0x0	; 0232E0E4
	str r3,[sp,#0x0]	; 0232E0E6
	mov r0,#0x9	; 0232E0E8
	add r1,r6,#0x0	; 0232E0EA
	add r2,r5,#0x0	; 0232E0EC
	add r3,r4,#0x0	; 0232E0EE
	bl P1_QueueRequestRecord	; 0232E0F0
	add sp,#0x8	; 0232E0F4
	pop {r4,r5,r6}	; 0232E0F6
	pop {r3}	; 0232E0F8
	bx r3	; 0232E0FA

; ===== function loc_0232E0FC =====
loc_0232E0FC:
	push {lr}	; 0232E0FC
	sub sp,#0x4	; 0232E0FE
	add r3,r2,#0x0	; 0232E100
	mov r2,#0x1	; 0232E102
	str r2,[sp,#0x0]	; 0232E104
	mov r2,#0x1a	; 0232E106
	bl loc_0232DF38	; 0232E108
	add sp,#0x4	; 0232E10C
	pop {r3}	; 0232E10E
	bx r3	; 0232E110
	.byte 0x00, 0x00	; 0232E114

; ===== function loc_0232E114 =====
loc_0232E114:
	push {lr}	; 0232E114
	sub sp,#0x4	; 0232E116
	add r3,r2,#0x0	; 0232E118
	mov r2,#0x2	; 0232E11A
	str r2,[sp,#0x0]	; 0232E11C
	mov r2,#0xc	; 0232E11E
	bl loc_0232DF38	; 0232E120
	add sp,#0x4	; 0232E124
	pop {r3}	; 0232E126
	bx r3	; 0232E128
	.byte 0x00, 0x00	; 0232E12C

; ===== function loc_0232E12C =====
loc_0232E12C:
	push {lr}	; 0232E12C
	sub sp,#0x4	; 0232E12E
	add r2,r1,#0x0	; 0232E130
	mov r1,#0x4	; 0232E132
	mov r3,#0x1	; 0232E134
	bl loc_0232DF5C	; 0232E136
	add sp,#0x4	; 0232E13A
	pop {r3}	; 0232E13C
	bx r3	; 0232E13E

; ===== function loc_0232E140 =====
loc_0232E140:
	push {lr}	; 0232E140
	sub sp,#0x4	; 0232E142
	add r2,r1,#0x0	; 0232E144
	mov r1,#0x6	; 0232E146
	mov r3,#0x2	; 0232E148
	bl loc_0232DF5C	; 0232E14A
	add sp,#0x4	; 0232E14E
	pop {r3}	; 0232E150
	bx r3	; 0232E152

; ===== function loc_0232E154 =====
loc_0232E154:
	push {lr}	; 0232E154
	sub sp,#0x4	; 0232E156
	add r1,r0,#0x0	; 0232E158
	mov r2,#0x0	; 0232E15A
	str r2,[sp,#0x0]	; 0232E15C
	mov r0,#0x1	; 0232E15E
	add r3,r2,#0x0	; 0232E160
	bl P1_QueueRequestRecord	; 0232E162
	add sp,#0x4	; 0232E166
	pop {r3}	; 0232E168
	bx r3	; 0232E16A

; ===== function loc_0232E16C =====
loc_0232E16C:
	push {r4,r5,r6,lr}	; 0232E16C
	sub sp,#0x8	; 0232E16E
	add r6,r0,#0x0	; 0232E170
	add r5,r1,#0x0	; 0232E172
	add r4,r2,#0x0	; 0232E174
	str r3,[sp,#0x0]	; 0232E176
	mov r0,#0x0	; 0232E178
	add r1,r6,#0x0	; 0232E17A
	add r2,r5,#0x0	; 0232E17C
	add r3,r4,#0x0	; 0232E17E
	bl P1_QueueRequestRecord	; 0232E180
	add sp,#0x8	; 0232E184
	pop {r4,r5,r6}	; 0232E186
	pop {r3}	; 0232E188
	bx r3	; 0232E18A

; ===== function loc_0232E18C =====
loc_0232E18C:
	ldr r1,[pool_0232E1A8]	; 0232E18C
	ldr r0,[r1,#0x0]	; 0232E18E
	cmp r0,#0x0	; 0232E190
	bne loc_0232E198	; 0232E192
	mov r0,#0x0	; 0232E194
	bx lr	; 0232E196
loc_0232E198:
; 从空闲请求链弹出首条记录；链耗尽时同步清空尾指针。
; Pop the first record from the free request chain; clear its tail when exhausted.
.func P1_PopFreeRequestRecord
	ldr r2,[r0,#0x0]	; 0232E198
	str r2,[r1,#0x0]	; 0232E19A
	cmp r2,#0x0	; 0232E19C
	bne loc_0232E1A6	; 0232E19E
	mov r2,#0x0	; 0232E1A0
	ldr r1,[pool_0232E1AC]	; 0232E1A2
	str r2,[r1,#0x0]	; 0232E1A4
loc_0232E1A6:
	bx lr	; 0232E1A6
pool_0232E1A8:
loc_0232E1A8:
	.word P1_RequestFreeHead	; 0232E1A8
pool_0232E1AC:
loc_0232E1AC:
	.word P1_RequestFreeTail	; 0232E1AC

.endfunc
; ===== function loc_0232E1B0 =====
loc_0232E1B0:
	push {r4,r5,lr}	; 0232E1B0
	sub sp,#0x4	; 0232E1B2
	mov r5,#0x7	; 0232E1B4
	mov r4,#0x0	; 0232E1B6
loc_0232E1B8:
	add r0,r5,#0x0	; 0232E1B8
	add r1,r4,#0x0	; 0232E1BA
	add r2,r4,#0x0	; 0232E1BC
	bl loc_0232E858	; 0232E1BE
	cmp r0,#0x0	; 0232E1C2
	blt loc_0232E1B8	; 0232E1C4
	add sp,#0x4	; 0232E1C6
	pop {r4,r5}	; 0232E1C8
	pop {r3}	; 0232E1CA
	bx r3	; 0232E1CC
	.byte 0x00, 0x00	; 0232E1D0

; ===== function loc_0232E1D0 =====
loc_0232E1D0:
	push {r4,r5,r6,lr}	; 0232E1D0
	mov r0,#0x7	; 0232E1D2
	ldr r1,[pool_0232E20C]	; 0232E1D4
	bl P1_SetPxiReceiveCallback	; 0232E1D6
	bl loc_0232B9D8	; 0232E1DA
	cmp r0,#0x0	; 0232E1DE
	bne loc_0232E206	; 0232E1E0
	mov r0,#0x7	; 0232E1E2
	mov r1,#0x1	; 0232E1E4
	bl loc_0232E8EC	; 0232E1E6
	cmp r0,#0x0	; 0232E1EA
	bne loc_0232E206	; 0232E1EC
	mov r5,#0x64	; 0232E1EE
	mov r4,#0x7	; 0232E1F0
	mov r6,#0x1	; 0232E1F2
loc_0232E1F4:
	add r0,r5,#0x0	; 0232E1F4
	blx P1_Arm9BusyWaitByLoop4	; 0232E1F6
	add r0,r4,#0x0	; 0232E1FA
	add r1,r6,#0x0	; 0232E1FC
	bl loc_0232E8EC	; 0232E1FE
	cmp r0,#0x0	; 0232E202
	beq loc_0232E1F4	; 0232E204
loc_0232E206:
	pop {r4,r5,r6}	; 0232E206
	pop {r3}	; 0232E208
	bx r3	; 0232E20A
pool_0232E20C:
loc_0232E20C:
	.word P1_PxiCallback_0232E210 + 1	; 0232E20C

; ===== function loc_0232E210 =====
P1_PxiCallback_0232E210:
	push {r4,r5,lr}	; 0232E210
	sub sp,#0x4	; 0232E212
	add r5,r1,#0x0	; 0232E214
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E216
	add r4,r0,#0x0	; 0232E21A
	add r0,r5,#0x0	; 0232E21C
	bl loc_0232E5B4	; 0232E21E
	add r0,r4,#0x0	; 0232E222
	blx P1_Arm9RestoreIrqMask	; 0232E224
	add sp,#0x4	; 0232E228
	pop {r4,r5}	; 0232E22A
	pop {r3}	; 0232E22C
	bx r3	; 0232E22E

; ===== function loc_0232E230 =====
loc_0232E230:
	push {r4,lr}	; 0232E230
	bl loc_0232E264	; 0232E232
	add r4,r0,#0x0	; 0232E236
	bl loc_0232E24C	; 0232E238
	ldr r1,[pool_0232E248]	; 0232E23C
	sub r1,r1,r4	; 0232E23E
	sub r0,r1,r0	; 0232E240
	pop {r4}	; 0232E242
	pop {r3}	; 0232E244
	bx r3	; 0232E246
pool_0232E248:
loc_0232E248:
	.word 0x00000100	; 0232E248

; ===== function loc_0232E24C =====
loc_0232E24C:
	ldr r0,[pool_0232E260]	; 0232E24C
	ldr r1,[r0,#0x0]	; 0232E24E
	mov r0,#0x0	; 0232E250
	cmp r1,#0x0	; 0232E252
	beq loc_0232E25E	; 0232E254
loc_0232E256:
	add r0,r0,#0x1	; 0232E256
	ldr r1,[r1,#0x0]	; 0232E258
	cmp r1,#0x0	; 0232E25A
	bne loc_0232E256	; 0232E25C
loc_0232E25E:
	bx lr	; 0232E25E
pool_0232E260:
loc_0232E260:
	.word P1_RequestPendingHead	; 0232E260

; ===== function loc_0232E264 =====
loc_0232E264:
	ldr r0,[pool_0232E278]	; 0232E264
	ldr r1,[r0,#0x0]	; 0232E266
	mov r0,#0x0	; 0232E268
	cmp r1,#0x0	; 0232E26A
	beq loc_0232E276	; 0232E26C
loc_0232E26E:
	add r0,r0,#0x1	; 0232E26E
	ldr r1,[r1,#0x0]	; 0232E270
	cmp r1,#0x0	; 0232E272
	bne loc_0232E26E	; 0232E274
loc_0232E276:
	bx lr	; 0232E276
pool_0232E278:
loc_0232E278:
	.word P1_RequestFreeHead	; 0232E278

; ===== function loc_0232E27C =====
loc_0232E27C:
	ldr r1,[pool_0232E2A4]	; 0232E27C
	ldr r1,[r1,#0x0]	; 0232E27E
	cmp r0,r1	; 0232E280
	bls loc_0232E294	; 0232E282
	sub r1,r0,r1	; 0232E284
	ldr r0,[pool_0232E2A8]	; 0232E286
	cmp r1,r0	; 0232E288
	bcc loc_0232E290	; 0232E28A
	mov r0,#0x1	; 0232E28C
	bx lr	; 0232E28E
loc_0232E290:
	mov r0,#0x0	; 0232E290
	bx lr	; 0232E292
loc_0232E294:
	sub r1,r1,r0	; 0232E294
	ldr r0,[pool_0232E2A8]	; 0232E296
	cmp r1,r0	; 0232E298
	bcs loc_0232E2A0	; 0232E29A
	mov r0,#0x1	; 0232E29C
	bx lr	; 0232E29E
loc_0232E2A0:
	mov r0,#0x0	; 0232E2A0
	bx lr	; 0232E2A2
pool_0232E2A4:
loc_0232E2A4:
	.word P1_BssStart + 0x266D4	; 0232E2A4
pool_0232E2A8:
loc_0232E2A8:
	.word 0x80000000	; 0232E2A8

; ===== function loc_0232E2AC =====
loc_0232E2AC:
	ldr r0,[pool_0232E2C0]	; 0232E2AC
	ldr r0,[r0,#0x0]	; 0232E2AE
	cmp r0,#0x0	; 0232E2B0
	bne loc_0232E2BA	; 0232E2B2
	ldr r0,[pool_0232E2C4]	; 0232E2B4
	ldr r0,[r0,#0x0]	; 0232E2B6
	bx lr	; 0232E2B8
loc_0232E2BA:
	ldr r0,[pool_0232E2C8]	; 0232E2BA
	ldr r0,[r0,#0x0]	; 0232E2BC
	bx lr	; 0232E2BE
pool_0232E2C0:
loc_0232E2C0:
	.word P1_RequestPendingHead	; 0232E2C0
pool_0232E2C4:
loc_0232E2C4:
	.word P1_BssStart + 0x266D4	; 0232E2C4
pool_0232E2C8:
loc_0232E2C8:
	.word P1_BssStart + 0x266F0	; 0232E2C8

; ===== function loc_0232E2CC =====
loc_0232E2CC:
	push {r4,r5,lr}	; 0232E2CC
	sub sp,#0x4	; 0232E2CE
	add r4,r0,#0x0	; 0232E2D0
	bl loc_0232E27C	; 0232E2D2
	cmp r0,#0x0	; 0232E2D6
	bne loc_0232E310	; 0232E2D8
	mov r5,#0x0	; 0232E2DA
loc_0232E2DC:
	add r0,r5,#0x0	; 0232E2DC
	bl loc_0232E470	; 0232E2DE
	cmp r0,#0x0	; 0232E2E2
	bne loc_0232E2DC	; 0232E2E4
	add r0,r4,#0x0	; 0232E2E6
	bl loc_0232E27C	; 0232E2E8
	cmp r0,#0x0	; 0232E2EC
	bne loc_0232E310	; 0232E2EE
	bl loc_0232E1B0	; 0232E2F0
	add r0,r4,#0x0	; 0232E2F4
	bl loc_0232E27C	; 0232E2F6
	cmp r0,#0x0	; 0232E2FA
	bne loc_0232E310	; 0232E2FC
	mov r5,#0x1	; 0232E2FE
loc_0232E300:
	add r0,r5,#0x0	; 0232E300
	bl loc_0232E470	; 0232E302
	add r0,r4,#0x0	; 0232E306
	bl loc_0232E27C	; 0232E308
	cmp r0,#0x0	; 0232E30C
	beq loc_0232E300	; 0232E30E
loc_0232E310:
	add sp,#0x4	; 0232E310
	pop {r4,r5}	; 0232E312
	pop {r3}	; 0232E314
	bx r3	; 0232E316

; ===== function loc_0232E318 =====
loc_0232E318:
	push {r4,lr}	; 0232E318
	add r4,r0,#0x0	; 0232E31A
	ldr r0,[pool_0232E3C0]	; 0232E31C
	ldr r0,[r0,#0x0]	; 0232E31E
	cmp r0,#0x0	; 0232E320
	bne loc_0232E32C	; 0232E322
	mov r0,#0x1	; 0232E324
	pop {r4}	; 0232E326
	pop {r3}	; 0232E328
	bx r3	; 0232E32A
loc_0232E32C:
	ldr r0,[pool_0232E3C4]	; 0232E32C
	ldr r0,[r0,#0x0]	; 0232E32E
	cmp r0,#0x8	; 0232E330
	blt loc_0232E34E	; 0232E332
	cmp r4,#0x0	; 0232E334
	bne loc_0232E340	; 0232E336
	mov r0,#0x0	; 0232E338
	pop {r4}	; 0232E33A
	pop {r3}	; 0232E33C
	bx r3	; 0232E33E
loc_0232E340:
	mov r0,#0x1	; 0232E340
	bl loc_0232E470	; 0232E342
	ldr r0,[pool_0232E3C4]	; 0232E346
	ldr r0,[r0,#0x0]	; 0232E348
	cmp r0,#0x8	; 0232E34A
	bge loc_0232E340	; 0232E34C
loc_0232E34E:
	ldr r0,[pool_0232E3C8]	; 0232E34E
	ldr r1,[pool_0232E3CC]	; 0232E350
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E352
	mov r0,#0x7	; 0232E356
	ldr r1,[pool_0232E3C0]	; 0232E358
	ldr r1,[r1,#0x0]	; 0232E35A
	mov r2,#0x0	; 0232E35C
	bl loc_0232E858	; 0232E35E
	cmp r0,#0x0	; 0232E362
	bge loc_0232E382	; 0232E364
	cmp r4,#0x0	; 0232E366
	bne loc_0232E372	; 0232E368
	mov r0,#0x0	; 0232E36A
	pop {r4}	; 0232E36C
	pop {r3}	; 0232E36E
	bx r3	; 0232E370
loc_0232E372:
	mov r0,#0x7	; 0232E372
	ldr r1,[pool_0232E3C0]	; 0232E374
	ldr r1,[r1,#0x0]	; 0232E376
	mov r2,#0x0	; 0232E378
	bl loc_0232E858	; 0232E37A
	cmp r0,#0x0	; 0232E37E
	blt loc_0232E372	; 0232E380
loc_0232E382:
	ldr r0,[pool_0232E3C0]	; 0232E382
	ldr r4,[r0,#0x0]	; 0232E384
	ldr r0,[pool_0232E3D0]	; 0232E386
	ldr r2,[r0,#0x0]	; 0232E388
	lsl r3,r2,#0x2	; 0232E38A
	ldr r1,[pool_0232E3D4]	; 0232E38C
	str r4,[r1,r3]	; 0232E38E
	add r1,r2,#0x1	; 0232E390
	str r1,[r0,#0x0]	; 0232E392
	cmp r1,#0x8	; 0232E394
	ble loc_0232E39C	; 0232E396
	mov r1,#0x0	; 0232E398
	str r1,[r0,#0x0]	; 0232E39A
loc_0232E39C:
	mov r1,#0x0	; 0232E39C
	ldr r0,[pool_0232E3C0]	; 0232E39E
	str r1,[r0,#0x0]	; 0232E3A0
	ldr r0,[pool_0232E3D8]	; 0232E3A2
	str r1,[r0,#0x0]	; 0232E3A4
	ldr r0,[pool_0232E3C4]	; 0232E3A6
	ldr r1,[r0,#0x0]	; 0232E3A8
	add r1,r1,#0x1	; 0232E3AA
	str r1,[r0,#0x0]	; 0232E3AC
	ldr r0,[pool_0232E3DC]	; 0232E3AE
	ldr r1,[r0,#0x0]	; 0232E3B0
	add r1,r1,#0x1	; 0232E3B2
	str r1,[r0,#0x0]	; 0232E3B4
	mov r0,#0x1	; 0232E3B6
	pop {r4}	; 0232E3B8
	pop {r3}	; 0232E3BA
	bx r3	; 0232E3BC
	.byte 0xC0, 0x46	; 0232E3C0
pool_0232E3C0:
loc_0232E3C0:
	.word P1_RequestPendingHead	; 0232E3C0
pool_0232E3C4:
loc_0232E3C4:
	.word P1_BssStart + 0x266EC	; 0232E3C4
pool_0232E3C8:
loc_0232E3C8:
	.word 0x02357180	; 0232E3C8
pool_0232E3CC:
loc_0232E3CC:
	.word 0x00001800	; 0232E3CC
pool_0232E3D0:
loc_0232E3D0:
	.word P1_BssStart + 0x266E8	; 0232E3D0
pool_0232E3D4:
loc_0232E3D4:
	.word P1_BssStart + 0x266F4	; 0232E3D4
pool_0232E3D8:
loc_0232E3D8:
	.word P1_RequestPendingTail	; 0232E3D8
pool_0232E3DC:
loc_0232E3DC:
	.word P1_BssStart + 0x266F0	; 0232E3DC

; ===== function loc_0232E3E0 =====
loc_0232E3E0:
	ldr r2,[pool_0232E3FC]	; 0232E3E0
	ldr r1,[r2,#0x0]	; 0232E3E2
	cmp r1,#0x0	; 0232E3E4
	bne loc_0232E3F0	; 0232E3E6
	ldr r1,[pool_0232E400]	; 0232E3E8
	str r0,[r1,#0x0]	; 0232E3EA
	str r0,[r2,#0x0]	; 0232E3EC
; 将请求记录追加到本地待处理单链表，并清零其 next 字段。
; Append a request record to the local pending singly linked list and clear its next field.
.func P1_EnqueueRequestRecord
	b loc_0232E3F4	; 0232E3EE
loc_0232E3F0:
	str r0,[r1,#0x0]	; 0232E3F0
	str r0,[r2,#0x0]	; 0232E3F2
loc_0232E3F4:
	mov r1,#0x0	; 0232E3F4
	str r1,[r0,#P1_RequestRecordNextOffset]	; 0232E3F6
	bx lr	; 0232E3F8
	.byte 0xC0, 0x46	; 0232E3FC
pool_0232E3FC:
loc_0232E3FC:
	.word P1_RequestPendingTail	; 0232E3FC
pool_0232E400:
loc_0232E400:
	.word P1_RequestPendingHead	; 0232E400
.endfunc

; ===== function loc_0232E404 =====
loc_0232E404:
	push {r4,lr}	; 0232E404
	add r4,r0,#0x0	; 0232E406
	bl loc_0232B9D8	; 0232E408
	cmp r0,#0x0	; 0232E40C
	beq loc_0232E418	; 0232E40E
	mov r0,#0x0	; 0232E410
	pop {r4}	; 0232E412
; 从空闲链取出请求记录；调用方要求时等待可用记录。
; Take a request record from the free chain; wait for one when the caller requires it.
.func P1_AcquireRequestRecord
	pop {r3}	; 0232E414
	bx r3	; 0232E416
loc_0232E418:
	bl P1_PopFreeRequestRecord	; 0232E418
	cmp r0,#0x0	; 0232E41C
	bne loc_0232E468	; 0232E41E
	cmp r4,#0x0	; 0232E420
	bne loc_0232E42C	; 0232E422
	mov r0,#0x0	; 0232E424
	pop {r4}	; 0232E426
	pop {r3}	; 0232E428
	bx r3	; 0232E42A
loc_0232E42C:
	bl loc_0232E230	; 0232E42C
	cmp r0,#0x0	; 0232E430
	ble loc_0232E44E	; 0232E432
	mov r4,#0x0	; 0232E434
loc_0232E436:
	add r0,r4,#0x0	; 0232E436
	bl loc_0232E470	; 0232E438
	cmp r0,#0x0	; 0232E43C
	bne loc_0232E436	; 0232E43E
	bl P1_PopFreeRequestRecord	; 0232E440
	cmp r0,#0x0	; 0232E444
	beq loc_0232E454	; 0232E446
	pop {r4}	; 0232E448
	pop {r3}	; 0232E44A
	bx r3	; 0232E44C
loc_0232E44E:
	mov r0,#0x1	; 0232E44E
	bl loc_0232E318	; 0232E450
loc_0232E454:
	bl loc_0232E1B0	; 0232E454
	mov r4,#0x1	; 0232E458
loc_0232E45A:
	add r0,r4,#0x0	; 0232E45A
	bl loc_0232E470	; 0232E45C
	bl P1_PopFreeRequestRecord	; 0232E460
	cmp r0,#0x0	; 0232E464
	beq loc_0232E45A	; 0232E466
loc_0232E468:
	pop {r4}	; 0232E468
	pop {r3}	; 0232E46A
	bx r3	; 0232E46C
	.byte 0x00, 0x00	; 0232E470

; ===== function loc_0232E470 =====
loc_0232E470:
	push {lr}	; 0232E470
	sub sp,#0x4	; 0232E472
	cmp r0,#0x0	; 0232E474
.endfunc
	bne loc_0232E48C	; 0232E476
	bl loc_0232E690	; 0232E478
	ldr r1,[pool_0232E4E8]	; 0232E47C
	ldr r1,[r1,#0x0]	; 0232E47E
	cmp r1,r0	; 0232E480
	bne loc_0232E498	; 0232E482
	mov r0,#0x0	; 0232E484
	add sp,#0x4	; 0232E486
	pop {r3}	; 0232E488
	bx r3	; 0232E48A
loc_0232E48C:
	bl loc_0232E690	; 0232E48C
	ldr r1,[pool_0232E4E8]	; 0232E490
	ldr r1,[r1,#0x0]	; 0232E492
	cmp r1,r0	; 0232E494
	beq loc_0232E48C	; 0232E496
loc_0232E498:
	ldr r1,[pool_0232E4EC]	; 0232E498
	ldr r2,[r1,#0x0]	; 0232E49A
	lsl r3,r2,#0x2	; 0232E49C
	ldr r0,[pool_0232E4F0]	; 0232E49E
	ldr r0,[r0,r3]	; 0232E4A0
	add r2,r2,#0x1	; 0232E4A2
	str r2,[r1,#0x0]	; 0232E4A4
	cmp r2,#0x8	; 0232E4A6
	ble loc_0232E4AE	; 0232E4A8
	mov r2,#0x0	; 0232E4AA
	str r2,[r1,#0x0]	; 0232E4AC
loc_0232E4AE:
	add r2,r0,#0x0	; 0232E4AE
	ldr r1,[r0,#0x0]	; 0232E4B0
	cmp r1,#0x0	; 0232E4B2
	beq loc_0232E4BE	; 0232E4B4
loc_0232E4B6:
	ldr r2,[r2,#0x0]	; 0232E4B6
	ldr r1,[r2,#0x0]	; 0232E4B8
	cmp r1,#0x0	; 0232E4BA
	bne loc_0232E4B6	; 0232E4BC
loc_0232E4BE:
	ldr r1,[pool_0232E4F4]	; 0232E4BE
	ldr r1,[r1,#0x0]	; 0232E4C0
	cmp r1,#0x0	; 0232E4C2
	beq loc_0232E4CA	; 0232E4C4
	str r0,[r1,#0x0]	; 0232E4C6
	b loc_0232E4CE	; 0232E4C8
loc_0232E4CA:
	ldr r1,[pool_0232E4F8]	; 0232E4CA
	str r0,[r1,#0x0]	; 0232E4CC
loc_0232E4CE:
	ldr r1,[pool_0232E4F4]	; 0232E4CE
	str r2,[r1,#0x0]	; 0232E4D0
	ldr r1,[pool_0232E4FC]	; 0232E4D2
	ldr r2,[r1,#0x0]	; 0232E4D4
	sub r2,r2,#0x1	; 0232E4D6
	str r2,[r1,#0x0]	; 0232E4D8
	ldr r1,[pool_0232E4E8]	; 0232E4DA
	ldr r2,[r1,#0x0]	; 0232E4DC
	add r2,r2,#0x1	; 0232E4DE
	str r2,[r1,#0x0]	; 0232E4E0
	add sp,#0x4	; 0232E4E2
	pop {r3}	; 0232E4E4
	bx r3	; 0232E4E6
pool_0232E4E8:
loc_0232E4E8:
	.word P1_BssStart + 0x266D4	; 0232E4E8
pool_0232E4EC:
loc_0232E4EC:
	.word P1_BssStart + 0x266E4	; 0232E4EC
pool_0232E4F0:
loc_0232E4F0:
	.word P1_BssStart + 0x266F4	; 0232E4F0
pool_0232E4F4:
loc_0232E4F4:
	.word P1_RequestFreeTail	; 0232E4F4
pool_0232E4F8:
loc_0232E4F8:
	.word P1_RequestFreeHead	; 0232E4F8
pool_0232E4FC:
loc_0232E4FC:
	.word P1_BssStart + 0x266EC	; 0232E4FC

; ===== function loc_0232E500 =====
loc_0232E500:
	push {r4,lr}	; 0232E500
	bl loc_0232E1D0	; 0232E502
	ldr r3,[pool_0232E57C]	; 0232E506
	ldr r0,[pool_0232E580]	; 0232E508
	str r3,[r0,#0x0]	; 0232E50A
	mov r4,#0x0	; 0232E50C
	add r2,r3,#0x0	; 0232E50E
	mov r0,#0x18	; 0232E510
loc_0232E512:
	add r4,r4,#0x1	; 0232E512
	add r1,r4,#0x0	; 0232E514
	mul r1,r0	; 0232E516
	add r1,r2,r1	; 0232E518
	str r1,[r3,#0x0]	; 0232E51A
	add r3,#0x18	; 0232E51C
	cmp r4,#0xff	; 0232E51E
	blt loc_0232E512	; 0232E520
	mov r0,#0x0	; 0232E522
	ldr r1,[pool_0232E584]	; 0232E524
	str r0,[r1,#0x68]	; 0232E526
	ldr r2,[pool_0232E588]	; 0232E528
	ldr r1,[pool_0232E58C]	; 0232E52A
	str r2,[r1,#0x0]	; 0232E52C
	ldr r1,[pool_0232E590]	; 0232E52E
	str r0,[r1,#0x0]	; 0232E530
	ldr r1,[pool_0232E594]	; 0232E532
	str r0,[r1,#0x0]	; 0232E534
	ldr r1,[pool_0232E598]	; 0232E536
	str r0,[r1,#0x0]	; 0232E538
	ldr r1,[pool_0232E59C]	; 0232E53A
	str r0,[r1,#0x0]	; 0232E53C
	ldr r1,[pool_0232E5A0]	; 0232E53E
	str r0,[r1,#0x0]	; 0232E540
	mov r2,#0x1	; 0232E542
	ldr r1,[pool_0232E5A4]	; 0232E544
	str r2,[r1,#0x0]	; 0232E546
	ldr r1,[pool_0232E5A8]	; 0232E548
	str r0,[r1,#0x0]	; 0232E54A
	ldr r0,[pool_0232E5AC]	; 0232E54C
	ldr r1,[pool_0232E5B0]	; 0232E54E
	str r0,[r1,#0x0]	; 0232E550
	bl loc_0232E640	; 0232E552
	mov r0,#0x1	; 0232E556
	bl P1_AcquireRequestRecord	; 0232E558
	cmp r0,#0x0	; 0232E55C
	beq loc_0232E574	; 0232E55E
	mov r1,#0x19	; 0232E560
	str r1,[r0,#0x4]	; 0232E562
	ldr r1,[pool_0232E5B0]	; 0232E564
	ldr r1,[r1,#0x0]	; 0232E566
	str r1,[r0,#0x8]	; 0232E568
	bl P1_EnqueueRequestRecord	; 0232E56A
	mov r0,#0x1	; 0232E56E
	bl loc_0232E318	; 0232E570
loc_0232E574:
	pop {r4}	; 0232E574
	pop {r3}	; 0232E576
	bx r3	; 0232E578
	.byte 0xC0, 0x46	; 0232E57C
pool_0232E57C:
loc_0232E57C:
	.word P1_BssStart + 0x269A0	; 0232E57C
pool_0232E580:
loc_0232E580:
	.word P1_RequestFreeHead	; 0232E580
pool_0232E584:
loc_0232E584:
	.word P1_BssStart + 0x28120	; 0232E584
pool_0232E588:
loc_0232E588:
	.word 0x02358968	; 0232E588
pool_0232E58C:
loc_0232E58C:
	.word P1_RequestFreeTail	; 0232E58C
pool_0232E590:
loc_0232E590:
	.word P1_RequestPendingHead	; 0232E590
pool_0232E594:
loc_0232E594:
	.word P1_RequestPendingTail	; 0232E594
pool_0232E598:
loc_0232E598:
	.word P1_BssStart + 0x266EC	; 0232E598
pool_0232E59C:
loc_0232E59C:
	.word P1_BssStart + 0x266E4	; 0232E59C
pool_0232E5A0:
loc_0232E5A0:
	.word P1_BssStart + 0x266E8	; 0232E5A0
pool_0232E5A4:
loc_0232E5A4:
	.word P1_BssStart + 0x266F0	; 0232E5A4
pool_0232E5A8:
loc_0232E5A8:
	.word P1_BssStart + 0x266D4	; 0232E5A8
pool_0232E5AC:
loc_0232E5AC:
	.word 0x02356F00	; 0232E5AC
pool_0232E5B0:
loc_0232E5B0:
	.word P1_BssStart + 0x28200	; 0232E5B0

; ===== function loc_0232E5B4 =====
loc_0232E5B4:
	push {r4,lr}	; 0232E5B4
	ldr r4,[pool_0232E5E0]	; 0232E5B6
	mov r2,#0xff	; 0232E5B8
	add r3,r0,#0x0	; 0232E5BA
	and r3,r2	; 0232E5BC
	mov r1,#0xc	; 0232E5BE
	mul r3,r1	; 0232E5C0
	add r3,r4,r3	; 0232E5C2
	asr r1,r0,#0x8	; 0232E5C4
	and r1,r2	; 0232E5C6
	ldrb r0,[r3,#0x8]	; 0232E5C8
	cmp r1,r0	; 0232E5CA
	bne loc_0232E5D8	; 0232E5CC
	ldr r1,[r3,#0x0]	; 0232E5CE
	cmp r1,#0x0	; 0232E5D0
	beq loc_0232E5D8	; 0232E5D2
	ldr r0,[r3,#0x4]	; 0232E5D4
	blx r1	; 0232E5D6
loc_0232E5D8:
	pop {r4}	; 0232E5D8
	pop {r3}	; 0232E5DA
	bx r3	; 0232E5DC
	.byte 0xC0, 0x46	; 0232E5E0
pool_0232E5E0:
loc_0232E5E0:
	.word 0x02358980	; 0232E5E0

; ===== function loc_0232E5E4 =====
loc_0232E5E4:
	push {r4}	; 0232E5E4
	sub sp,#0x4	; 0232E5E6
	ldr r4,[pool_0232E608]	; 0232E5E8
	mov r3,#0xc	; 0232E5EA
	mul r0,r3	; 0232E5EC
	add r3,r4,r0	; 0232E5EE
	str r1,[r4,r0]	; 0232E5F0
	str r2,[r3,#0x4]	; 0232E5F2
	add r1,r3,#0x0	; 0232E5F4
	add r1,#0x8	; 0232E5F6
	ldrb r0,[r1,#0x0]	; 0232E5F8
	add r0,r0,#0x1	; 0232E5FA
	strb r0,[r1,#0x0]	; 0232E5FC
	ldrb r0,[r3,#0x8]	; 0232E5FE
	add sp,#0x4	; 0232E600
	pop {r4}	; 0232E602
	bx lr	; 0232E604
	.byte 0xC0, 0x46	; 0232E608
pool_0232E608:
loc_0232E608:
	.word P1_BssStart + 0x281A0	; 0232E608

; ===== function loc_0232E60C =====
loc_0232E60C:
	ldr r2,[pool_0232E620]	; 0232E60C
	mov r1,#0xc	; 0232E60E
	mul r0,r1	; 0232E610
	add r1,r2,r0	; 0232E612
	add r1,#0x8	; 0232E614
	ldrb r0,[r1,#0x0]	; 0232E616
	add r0,r0,#0x1	; 0232E618
	strb r0,[r1,#0x0]	; 0232E61A
	bx lr	; 0232E61C
	.byte 0xC0, 0x46	; 0232E620
pool_0232E620:
loc_0232E620:
	.word 0x02358980	; 0232E620

; ===== function loc_0232E624 =====
loc_0232E624:
	mov r2,#0x0	; 0232E624
	ldr r1,[pool_0232E63C]	; 0232E626
	add r0,r2,#0x0	; 0232E628
loc_0232E62A:
	str r0,[r1,#0x0]	; 0232E62A
	str r0,[r1,#0x4]	; 0232E62C
	strb r0,[r1,#0x8]	; 0232E62E
	add r1,#0xc	; 0232E630
	add r2,r2,#0x1	; 0232E632
	cmp r2,#0x8	; 0232E634
	blt loc_0232E62A	; 0232E636
	bx lr	; 0232E638
	.byte 0xC0, 0x46	; 0232E63C
pool_0232E63C:
loc_0232E63C:
	.word P1_BssStart + 0x281A0	; 0232E63C

; ===== function loc_0232E640 =====
loc_0232E640:
	push {r4,r5,r6,lr}	; 0232E640
	mov r6,#0x0	; 0232E642
	str r6,[r0,#0x4]	; 0232E644
	strh r6,[r0,#0x8]	; 0232E646
	strh r6,[r0,#0xa]	; 0232E648
	str r6,[r0,#0x0]	; 0232E64A
	add r4,r0,#0x0	; 0232E64C
	mvn r1,r6	; 0232E64E
	add r2,r6,#0x0	; 0232E650
loc_0232E652:
	str r2,[r4,#0x40]	; 0232E652
	add r5,r2,#0x0	; 0232E654
	add r3,r4,#0x0	; 0232E656
loc_0232E658:
	strh r1,[r3,#0x20]	; 0232E658
	add r3,r3,#0x2	; 0232E65A
	add r5,r5,#0x1	; 0232E65C
	cmp r5,#0x10	; 0232E65E
	blt loc_0232E658	; 0232E660
	add r4,#0x24	; 0232E662
	add r6,r6,#0x1	; 0232E664
	cmp r6,#0x10	; 0232E666
	blt loc_0232E652	; 0232E668
	mov r3,#0x0	; 0232E66A
	add r4,r0,#0x0	; 0232E66C
	mvn r2,r3	; 0232E66E
	ldr r1,[pool_0232E688]	; 0232E670
loc_0232E672:
	strh r2,[r4,r1]	; 0232E672
	add r4,r4,#0x2	; 0232E674
	add r3,r3,#0x1	; 0232E676
	cmp r3,#0x10	; 0232E678
	blt loc_0232E672	; 0232E67A
	ldr r1,[pool_0232E68C]	; 0232E67C
	blx P1_CleanAndInvalidateDataCacheRange	; 0232E67E
	pop {r4,r5,r6}	; 0232E682
	pop {r3}	; 0232E684
	bx r3	; 0232E686
pool_0232E688:
loc_0232E688:
	.word 0x00000260	; 0232E688
pool_0232E68C:
loc_0232E68C:
	.word 0x00000280	; 0232E68C

; ===== function loc_0232E690 =====
loc_0232E690:
	push {lr}	; 0232E690
	sub sp,#0x4	; 0232E692
	ldr r0,[pool_0232E6AC]	; 0232E694
	ldr r0,[r0,#0x0]	; 0232E696
	ldr r1,[pool_0232E6B0]	; 0232E698
	blx P1_InvalidateDataCacheRange	; 0232E69A
	ldr r0,[pool_0232E6AC]	; 0232E69E
	ldr r0,[r0,#0x0]	; 0232E6A0
	ldr r0,[r0,#0x0]	; 0232E6A2
	add sp,#0x4	; 0232E6A4
	pop {r3}	; 0232E6A6
	bx r3	; 0232E6A8
	.byte 0xC0, 0x46	; 0232E6AC
pool_0232E6AC:
loc_0232E6AC:
	.word P1_BssStart + 0x28200	; 0232E6AC
pool_0232E6B0:
loc_0232E6B0:
	.word 0x00000280	; 0232E6B0

; ===== function loc_0232E6B4 =====
loc_0232E6B4:
	push {lr}	; 0232E6B4
	sub sp,#0x4	; 0232E6B6
	ldr r0,[pool_0232E6D0]	; 0232E6B8
	ldr r0,[r0,#0x0]	; 0232E6BA
	ldr r1,[pool_0232E6D4]	; 0232E6BC
	blx P1_InvalidateDataCacheRange	; 0232E6BE
	ldr r0,[pool_0232E6D0]	; 0232E6C2
	ldr r0,[r0,#0x0]	; 0232E6C4
	ldrh r0,[r0,#0x8]	; 0232E6C6
	add sp,#0x4	; 0232E6C8
	pop {r3}	; 0232E6CA
	bx r3	; 0232E6CC
	.byte 0xC0, 0x46	; 0232E6D0
pool_0232E6D0:
loc_0232E6D0:
	.word P1_BssStart + 0x28200	; 0232E6D0
pool_0232E6D4:
loc_0232E6D4:
	.word 0x00000280	; 0232E6D4

; ===== function loc_0232E6D8 =====
loc_0232E6D8:
	push {lr}	; 0232E6D8
	sub sp,#0x4	; 0232E6DA
	ldr r0,[pool_0232E6F4]	; 0232E6DC
	ldr r0,[r0,#0x0]	; 0232E6DE
	ldr r1,[pool_0232E6F8]	; 0232E6E0
	blx P1_InvalidateDataCacheRange	; 0232E6E2
	ldr r0,[pool_0232E6F4]	; 0232E6E6
	ldr r0,[r0,#0x0]	; 0232E6E8
	ldr r0,[r0,#0x4]	; 0232E6EA
	add sp,#0x4	; 0232E6EC
	pop {r3}	; 0232E6EE
	bx r3	; 0232E6F0
	.byte 0xC0, 0x46	; 0232E6F4
pool_0232E6F4:
loc_0232E6F4:
	.word P1_BssStart + 0x28200	; 0232E6F4
pool_0232E6F8:
loc_0232E6F8:
	.word 0x00000280	; 0232E6F8

; ===== function loc_0232E6FC =====
loc_0232E6FC:
	push {r4,r5,r6,r7,lr}	; 0232E6FC
	sub sp,#0x4	; 0232E6FE
	add r5,r0,#0x0	; 0232E700
	add r7,r1,#0x0	; 0232E702
	add r4,r2,#0x0	; 0232E704
	lsl r2,r7,#0x3	; 0232E706
	add r1,r5,r2	; 0232E708
	ldr r0,[r1,#0x18]	; 0232E70A
	cmp r0,#0x0	; 0232E70C
	beq loc_0232E74C	; 0232E70E
	cmp r4,r0	; 0232E710
	beq loc_0232E76E	; 0232E712
	ldr r6,[r0,#0x18]	; 0232E714
	add r3,r5,#0x0	; 0232E716
	add r3,#0x18	; 0232E718
	add r3,r3,r2	; 0232E71A
	cmp r3,r6	; 0232E71C
	bne loc_0232E72E	; 0232E71E
	ldr r2,[r1,#0x1c]	; 0232E720
	str r2,[r0,#0x18]	; 0232E722
	ldr r0,[r1,#0x18]	; 0232E724
	mov r1,#0x3c	; 0232E726
	blx P1_CleanDataCacheRange	; 0232E728
	b loc_0232E74C	; 0232E72C
loc_0232E72E:
	cmp r6,#0x0	; 0232E72E
	beq loc_0232E73E	; 0232E730
loc_0232E732:
	ldr r0,[r6,#0x4]	; 0232E732
	cmp r3,r0	; 0232E734
	beq loc_0232E73E	; 0232E736
	add r6,r0,#0x0	; 0232E738
	cmp r0,#0x0	; 0232E73A
	bne loc_0232E732	; 0232E73C
loc_0232E73E:
	add r0,r5,r2	; 0232E73E
	ldr r0,[r0,#0x1c]	; 0232E740
	str r0,[r6,#0x4]	; 0232E742
	add r0,r6,#0x0	; 0232E744
	mov r1,#0x8	; 0232E746
	blx P1_CleanDataCacheRange	; 0232E748
loc_0232E74C:
	ldr r0,[r4,#0x18]	; 0232E74C
	lsl r3,r7,#0x3	; 0232E74E
	add r2,r5,#0x0	; 0232E750
	add r2,#0x18	; 0232E752
	add r1,r2,r3	; 0232E754
	str r1,[r4,#0x18]	; 0232E756
	add r1,r5,r3	; 0232E758
	str r0,[r1,#0x1c]	; 0232E75A
	str r4,[r2,r3]	; 0232E75C
	add r0,r5,#0x0	; 0232E75E
	mov r1,#0x3c	; 0232E760
	blx P1_CleanDataCacheRange	; 0232E762
	add r0,r4,#0x0	; 0232E766
	mov r1,#0x3c	; 0232E768
	blx P1_CleanDataCacheRange	; 0232E76A
loc_0232E76E:
	add sp,#0x4	; 0232E76E
	pop {r4,r5,r6,r7}	; 0232E770
	pop {r3}	; 0232E772
	bx r3	; 0232E774
	.byte 0x00, 0x00	; 0232E778

; ===== function loc_0232E778 =====
loc_0232E778:
	ldr r3,[pool_0232E77C]	; 0232E778
	bx r3	; 0232E77A
pool_0232E77C:
loc_0232E77C:
	.word loc_0232E968 + 1	; 0232E77C

; ===== function loc_0232E780 =====
P1_IrqHandler_0232E780:
	push {r4,r5,r6,r7,lr}	; 0232E780
	sub sp,#0x4	; 0232E782
	ldr r5,[pool_0232E83C]	; 0232E784
	mov r0,#0x3	; 0232E786
	mvn r6,r0	; 0232E788
	mov r7,#0x2	; 0232E78A
	mvn r4,r7	; 0232E78C
loc_0232E78E:
	ldrh r1,[r5,#0x0]	; 0232E78E
	ldr r0,[pool_0232E840]	; 0232E790
	and r1,r0	; 0232E792
	cmp r1,#0x0	; 0232E794
	beq loc_0232E7A4	; 0232E796
	ldrh r1,[r5,#0x0]	; 0232E798
	ldr r0,[pool_0232E844]	; 0232E79A
	orr r1,r0	; 0232E79C
	strh r1,[r5,#0x0]	; 0232E79E
	add r0,r4,#0x0	; 0232E7A0
	b loc_0232E7C6	; 0232E7A2
loc_0232E7A4:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E7A4
	ldrh r2,[r5,#0x0]	; 0232E7A8
	ldr r1,[pool_0232E848]	; 0232E7AA
	and r2,r1	; 0232E7AC
	cmp r2,#0x0	; 0232E7AE
	beq loc_0232E7BA	; 0232E7B0
	blx P1_Arm9RestoreIrqMask	; 0232E7B2
	add r0,r6,#0x0	; 0232E7B6
	b loc_0232E7C6	; 0232E7B8
loc_0232E7BA:
	ldr r1,[pool_0232E84C]	; 0232E7BA
	ldr r1,[r1,#0x0]	; 0232E7BC
	str r1,[sp,#0x0]	; 0232E7BE
	blx P1_Arm9RestoreIrqMask	; 0232E7C0
	mov r0,#0x0	; 0232E7C4
loc_0232E7C6:
	mov r1,#0x3	; 0232E7C6
	mvn r1,r1	; 0232E7C8
	cmp r0,r1	; 0232E7CA
	beq loc_0232E832	; 0232E7CC
	mvn r1,r7	; 0232E7CE
	cmp r0,r1	; 0232E7D0
	beq loc_0232E78E	; 0232E7D2
	ldr r2,[sp,#0x0]	; 0232E7D4
; 拆出通道/26 位数据/错误位，再以这三个参数调用对应回调。
; Decode channel, 26-bit data and error bit, then call that channel's callback.
	lsl r0,r2,#0x1b	; 0232E7D6
	lsr r0,r0,#0x1b	; 0232E7D8
	cmp r0,#0x0	; 0232E7DA
	beq loc_0232E78E	; 0232E7DC
	lsl r3,r0,#0x2	; 0232E7DE
	ldr r1,[pool_0232E850]	; 0232E7E0
	ldr r3,[r1,r3]	; 0232E7E2
	cmp r3,#0x0	; 0232E7E4
	beq loc_0232E7F2	; 0232E7E6
	lsr r1,r2,#0x6	; 0232E7E8
	lsl r2,r2,#0x1a	; 0232E7EA
	lsr r2,r2,#0x1f	; 0232E7EC
	blx r3	; 0232E7EE
	b loc_0232E78E	; 0232E7F0
loc_0232E7F2:
	lsl r0,r2,#0x1a	; 0232E7F2
	lsr r0,r0,#0x1f	; 0232E7F4
	cmp r0,#0x0	; 0232E7F6
	bne loc_0232E78E	; 0232E7F8
	mov r0,#0x20	; 0232E7FA
	orr r2,r0	; 0232E7FC
	str r2,[sp,#0x0]	; 0232E7FE
	ldrh r1,[r5,#0x0]	; 0232E800
	ldr r0,[pool_0232E840]	; 0232E802
	and r1,r0	; 0232E804
	cmp r1,#0x0	; 0232E806
	beq loc_0232E814	; 0232E808
	ldrh r1,[r5,#0x0]	; 0232E80A
	ldr r0,[pool_0232E844]	; 0232E80C
	orr r1,r0	; 0232E80E
	strh r1,[r5,#0x0]	; 0232E810
	b loc_0232E78E	; 0232E812
loc_0232E814:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E814
	ldrh r1,[r5,#0x0]	; 0232E818
	and r1,r7	; 0232E81A
	cmp r1,#0x0	; 0232E81C
	beq loc_0232E826	; 0232E81E
	blx P1_Arm9RestoreIrqMask	; 0232E820
	b loc_0232E78E	; 0232E824
loc_0232E826:
	ldr r2,[sp,#0x0]	; 0232E826
	ldr r1,[pool_0232E854]	; 0232E828
	str r2,[r1,#0x0]	; 0232E82A
	blx P1_Arm9RestoreIrqMask	; 0232E82C
	b loc_0232E78E	; 0232E830
loc_0232E832:
	add sp,#0x4	; 0232E832
	pop {r4,r5,r6,r7}	; 0232E834
	pop {r3}	; 0232E836
	bx r3	; 0232E838
	.byte 0xC0, 0x46	; 0232E83C
pool_0232E83C:
loc_0232E83C:
	.word REG_IPC_FIFO_CR	; 0232E83C
pool_0232E840:
loc_0232E840:
	.word 0x00004000	; 0232E840
pool_0232E844:
loc_0232E844:
	.word 0x0000C000	; 0232E844
pool_0232E848:
loc_0232E848:
	.word 0x00000100	; 0232E848
pool_0232E84C:
loc_0232E84C:
	.word REG_IPC_FIFO_RX	; 0232E84C
pool_0232E850:
loc_0232E850:
	.word P1_PxiReceiveCallbacks	; 0232E850
pool_0232E854:
loc_0232E854:
	.word REG_IPC_FIFO_TX	; 0232E854

; ===== function loc_0232E858 =====
loc_0232E858:
	push {r4,lr}	; 0232E858
	sub sp,#0x8	; 0232E85A
	ldr r3,[sp,#0x0]	; 0232E85C
	mov r4,#0x1f	; 0232E85E
	bic r3,r4	; 0232E860
	and r0,r4	; 0232E862
	orr r3,r0	; 0232E864
	str r3,[sp,#0x0]	; 0232E866
	mov r0,#0x20	; 0232E868
	bic r3,r0	; 0232E86A
	mov r0,#0x1	; 0232E86C
	and r2,r0	; 0232E86E
	lsl r0,r2,#0x5	; 0232E870
	orr r3,r0	; 0232E872
	str r3,[sp,#0x0]	; 0232E874
	mov r0,#0x3f	; 0232E876
	and r3,r0	; 0232E878
	ldr r0,[pool_0232E8D8]	; 0232E87A
	and r1,r0	; 0232E87C
	lsl r0,r1,#0x6	; 0232E87E
	orr r3,r0	; 0232E880
	str r3,[sp,#0x0]	; 0232E882
	ldr r2,[pool_0232E8DC]	; 0232E884
	ldrh r1,[r2,#0x0]	; 0232E886
	ldr r0,[pool_0232E8E0]	; 0232E888
	and r1,r0	; 0232E88A
	cmp r1,#0x0	; 0232E88C
	beq loc_0232E8A4	; 0232E88E
	ldrh r1,[r2,#0x0]	; 0232E890
	ldr r0,[pool_0232E8E4]	; 0232E892
	orr r1,r0	; 0232E894
	strh r1,[r2,#0x0]	; 0232E896
	mov r0,#0x0	; 0232E898
	mvn r0,r0	; 0232E89A
	add sp,#0x8	; 0232E89C
	pop {r4}	; 0232E89E
	pop {r3}	; 0232E8A0
	bx r3	; 0232E8A2
loc_0232E8A4:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E8A4
	ldr r1,[pool_0232E8DC]	; 0232E8A8
	ldrh r2,[r1,#0x0]	; 0232E8AA
	mov r1,#0x2	; 0232E8AC
	and r2,r1	; 0232E8AE
	cmp r2,#0x0	; 0232E8B0
	beq loc_0232E8C4	; 0232E8B2
	blx P1_Arm9RestoreIrqMask	; 0232E8B4
	mov r0,#0x1	; 0232E8B8
	mvn r0,r0	; 0232E8BA
	add sp,#0x8	; 0232E8BC
	pop {r4}	; 0232E8BE
	pop {r3}	; 0232E8C0
	bx r3	; 0232E8C2
loc_0232E8C4:
	ldr r2,[sp,#0x0]	; 0232E8C4
	ldr r1,[pool_0232E8E8]	; 0232E8C6
	str r2,[r1,#0x0]	; 0232E8C8
	blx P1_Arm9RestoreIrqMask	; 0232E8CA
	mov r0,#0x0	; 0232E8CE
	add sp,#0x8	; 0232E8D0
	pop {r4}	; 0232E8D2
	pop {r3}	; 0232E8D4
	bx r3	; 0232E8D6
pool_0232E8D8:
loc_0232E8D8:
	.word 0x03FFFFFF	; 0232E8D8
pool_0232E8DC:
loc_0232E8DC:
	.word REG_IPC_FIFO_CR	; 0232E8DC
pool_0232E8E0:
loc_0232E8E0:
	.word 0x00004000	; 0232E8E0
pool_0232E8E4:
loc_0232E8E4:
	.word 0x0000C000	; 0232E8E4
pool_0232E8E8:
loc_0232E8E8:
	.word REG_IPC_FIFO_TX	; 0232E8E8

; ===== function loc_0232E8EC =====
loc_0232E8EC:
	push {r4}	; 0232E8EC
	sub sp,#0x4	; 0232E8EE
	mov r3,#0x1	; 0232E8F0
	add r2,r3,#0x0	; 0232E8F2
	lsl r2,r0	; 0232E8F4
	ldr r4,[pool_0232E910]	; 0232E8F6
	lsl r0,r1,#0x2	; 0232E8F8
	add r1,r4,r0	; 0232E8FA
	ldr r0,[pool_0232E914]	; 0232E8FC
	ldr r0,[r1,r0]	; 0232E8FE
	and r2,r0	; 0232E900
	cmp r2,#0x0	; 0232E902
	bne loc_0232E908	; 0232E904
	mov r3,#0x0	; 0232E906
loc_0232E908:
	add r0,r3,#0x0	; 0232E908
	add sp,#0x4	; 0232E90A
	pop {r4}	; 0232E90C
	bx lr	; 0232E90E
pool_0232E910:
loc_0232E910:
	.word 0x027FFC00	; 0232E910
pool_0232E914:
loc_0232E914:
	.word 0x00000388	; 0232E914

; ===== function loc_0232E918 =====
loc_0232E918:
; r0=通道，r1=回调（0 注销）；关中断更新本 CPU 的表及共享可用位。
; r0=channel, r1=callback (0 removes it); mask IRQs while updating table/availability.
.func P1_SetPxiReceiveCallback
	push {r4,r5,lr}	; 0232E918
	sub sp,#0x4	; 0232E91A
	add r5,r0,#0x0	; 0232E91C
	add r4,r1,#0x0	; 0232E91E
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E920
	lsl r2,r5,#0x2	; 0232E924
	ldr r1,[pool_0232E95C]	; 0232E926
	str r4,[r1,r2]	; 0232E928
	cmp r4,#0x0	; 0232E92A
	beq loc_0232E940	; 0232E92C
	ldr r2,[pool_0232E960]	; 0232E92E
	ldr r1,[pool_0232E964]	; 0232E930
	add r1,r2,r1	; 0232E932
	ldr r3,[r1,#0x0]	; 0232E934
	mov r2,#0x1	; 0232E936
	lsl r2,r5	; 0232E938
	orr r3,r2	; 0232E93A
	str r3,[r1,#0x0]	; 0232E93C
	b loc_0232E950	; 0232E93E
loc_0232E940:
	ldr r2,[pool_0232E960]	; 0232E940
	ldr r1,[pool_0232E964]	; 0232E942
	add r1,r2,r1	; 0232E944
	ldr r3,[r1,#0x0]	; 0232E946
	mov r2,#0x1	; 0232E948
	lsl r2,r5	; 0232E94A
	bic r3,r2	; 0232E94C
	str r3,[r1,#0x0]	; 0232E94E
loc_0232E950:
	blx P1_Arm9RestoreIrqMask	; 0232E950
	add sp,#0x4	; 0232E954
	pop {r4,r5}	; 0232E956
	pop {r3}	; 0232E958
	bx r3	; 0232E95A
.endfunc
pool_0232E95C:
loc_0232E95C:
	.word P1_PxiReceiveCallbacks	; 0232E95C
pool_0232E960:
loc_0232E960:
	.word FirmwareSystemWorkAddress	; 0232E960
pool_0232E964:
loc_0232E964:
	.word SystemWorkPxiArm9AvailableOffset	; 0232E964

; ===== function loc_0232E968 =====
loc_0232E968:
	push {r4,r5,r6,r7,lr}	; 0232E968
	sub sp,#0x4	; 0232E96A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232E96C
	str r0,[sp,#0x0]	; 0232E970
	ldr r0,[pool_0232E9F0]	; 0232E972
	ldrh r1,[r0,#0x0]	; 0232E974
	cmp r1,#0x0	; 0232E976
	bne loc_0232E9E0	; 0232E978
	mov r1,#0x1	; 0232E97A
	strh r1,[r0,#0x0]	; 0232E97C
	mov r2,#0x0	; 0232E97E
	ldr r1,[pool_0232E9F4]	; 0232E980
	ldr r0,[pool_0232E9F8]	; 0232E982
	str r2,[r1,r0]	; 0232E984
	ldr r1,[pool_0232E9FC]	; 0232E986
	add r0,r2,#0x0	; 0232E988
loc_0232E98A:
	stmia r1!,{r0}	; 0232E98A
	add r2,r2,#0x1	; 0232E98C
	cmp r2,#PxiFifoChannelCount	; 0232E98E
	blt loc_0232E98A	; 0232E990
	ldr r0,[pool_0232EA00]	; 0232E992
	ldr r1,[pool_0232EA04]	; 0232E994
	bl loc_0232B184	; 0232E996
	ldr r0,[pool_0232EA00]	; 0232E99A
	bl loc_0232B100	; 0232E99C
	ldr r1,[pool_0232EA08]	; 0232E9A0
	ldr r0,[pool_0232EA0C]	; 0232E9A2
	strh r1,[r0,#0x0]	; 0232E9A4
	mov r1,#0x0	; 0232E9A6
	ldr r0,[pool_0232EA10]	; 0232E9A8
	add r6,r1,#0x0	; 0232E9AA
	ldr r7,[pool_0232EA14]	; 0232E9AC
	mov r4,#0xf	; 0232E9AE
loc_0232E9B0:
	ldrh r2,[r0,#0x0]	; 0232E9B0
	and r2,r4	; 0232E9B2
	lsl r3,r2,#0x8	; 0232E9B4
	strh r3,[r0,#0x0]	; 0232E9B6
	cmp r2,#0x0	; 0232E9B8
	bne loc_0232E9C0	; 0232E9BA
	cmp r1,#0x4	; 0232E9BC
	bgt loc_0232E9E0	; 0232E9BE
loc_0232E9C0:
	add r3,r7,#0x0	; 0232E9C0
	ldrh r5,[r0,#0x0]	; 0232E9C2
	and r5,r4	; 0232E9C4
	cmp r5,r2	; 0232E9C6
	bne loc_0232E9DC	; 0232E9C8
loc_0232E9CA:
	cmp r3,#0x0	; 0232E9CA
	bgt loc_0232E9D2	; 0232E9CC
	add r1,r6,#0x0	; 0232E9CE
	b loc_0232E9DC	; 0232E9D0
loc_0232E9D2:
	sub r3,r3,#0x1	; 0232E9D2
	ldrh r5,[r0,#0x0]	; 0232E9D4
	and r5,r4	; 0232E9D6
	cmp r5,r2	; 0232E9D8
	beq loc_0232E9CA	; 0232E9DA
loc_0232E9DC:
	add r1,r1,#0x1	; 0232E9DC
	b loc_0232E9B0	; 0232E9DE
loc_0232E9E0:
	ldr r0,[sp,#0x0]	; 0232E9E0
	blx P1_Arm9RestoreIrqMask	; 0232E9E2
	add sp,#0x4	; 0232E9E6
	pop {r4,r5,r6,r7}	; 0232E9E8
	pop {r3}	; 0232E9EA
	bx r3	; 0232E9EC
	.byte 0xC0, 0x46	; 0232E9F0
pool_0232E9F0:
loc_0232E9F0:
	.word P1_BssStart + 0x28204	; 0232E9F0
pool_0232E9F4:
loc_0232E9F4:
	.word FirmwareSystemWorkAddress	; 0232E9F4
pool_0232E9F8:
loc_0232E9F8:
	.word SystemWorkPxiArm9AvailableOffset	; 0232E9F8
pool_0232E9FC:
loc_0232E9FC:
	.word P1_PxiReceiveCallbacks	; 0232E9FC
pool_0232EA00:
loc_0232EA00:
	.word 0x00040000	; 0232EA00
pool_0232EA04:
loc_0232EA04:
	.word P1_IrqHandler_0232E780 + 1	; 0232EA04
pool_0232EA08:
loc_0232EA08:
	.word 0x0000C408	; 0232EA08
pool_0232EA0C:
loc_0232EA0C:
	.word REG_IPC_FIFO_CR	; 0232EA0C
pool_0232EA10:
loc_0232EA10:
	.word REG_IPC_SYNC	; 0232EA10
pool_0232EA14:
loc_0232EA14:
	.word 0x000003E8	; 0232EA14

; ===== function loc_0232EA18 =====
loc_0232EA18:
; 恢复除法/开方操作数及模式。
; Restore division/square-root operands and modes.
.func P1_RestoreArithmeticContext
	ldr r3,[r0,#0x0]	; 0232EA18
	ldr r2,[r0,#0x4]	; 0232EA1A
	ldr r1,[pool_0232EA44]	; 0232EA1C
	str r3,[r1,#0x0]	; 0232EA1E
	str r2,[r1,#0x4]	; 0232EA20
	ldr r3,[r0,#0x8]	; 0232EA22
	ldr r2,[r0,#0xc]	; 0232EA24
	ldr r1,[pool_0232EA48]	; 0232EA26
	str r3,[r1,#0x0]	; 0232EA28
	str r2,[r1,#0x4]	; 0232EA2A
	ldrh r2,[r0,#0x18]	; 0232EA2C
	ldr r1,[pool_0232EA4C]	; 0232EA2E
	strh r2,[r1,#0x0]	; 0232EA30
	ldr r3,[r0,#0x10]	; 0232EA32
	ldr r2,[r0,#0x14]	; 0232EA34
	ldr r1,[pool_0232EA50]	; 0232EA36
	str r3,[r1,#0x0]	; 0232EA38
	str r2,[r1,#0x4]	; 0232EA3A
	ldrh r1,[r0,#0x1a]	; 0232EA3C
	ldr r0,[pool_0232EA54]	; 0232EA3E
	strh r1,[r0,#0x0]	; 0232EA40
	bx lr	; 0232EA42
.endfunc
pool_0232EA44:
loc_0232EA44:
	.word REG_DIV_NUMER	; 0232EA44
pool_0232EA48:
loc_0232EA48:
	.word REG_DIV_DENOM	; 0232EA48
pool_0232EA4C:
loc_0232EA4C:
	.word REG_DIVCNT	; 0232EA4C
pool_0232EA50:
loc_0232EA50:
	.word REG_SQRT_PARAM	; 0232EA50
pool_0232EA54:
loc_0232EA54:
	.word REG_SQRTCNT	; 0232EA54

; ===== function loc_0232EA58 =====
loc_0232EA58:
; 保存除法/开方操作数及模式，不保存结果寄存器。
; Save division/square-root operands and modes, not the result registers.
.func P1_SaveArithmeticContext
	ldr r1,[pool_0232EA8C]	; 0232EA58
	ldr r2,[r1,#0x0]	; 0232EA5A
	ldr r1,[r1,#0x4]	; 0232EA5C
	str r2,[r0,#0x0]	; 0232EA5E
	str r1,[r0,#0x4]	; 0232EA60
	ldr r1,[pool_0232EA90]	; 0232EA62
	ldr r2,[r1,#0x0]	; 0232EA64
	ldr r1,[r1,#0x4]	; 0232EA66
	str r2,[r0,#0x8]	; 0232EA68
	str r1,[r0,#0xc]	; 0232EA6A
	ldr r1,[pool_0232EA94]	; 0232EA6C
	ldrh r2,[r1,#0x0]	; 0232EA6E
	mov r1,#0x3	; 0232EA70
	and r2,r1	; 0232EA72
	strh r2,[r0,#0x18]	; 0232EA74
	ldr r1,[pool_0232EA98]	; 0232EA76
	ldr r2,[r1,#0x0]	; 0232EA78
	ldr r1,[r1,#0x4]	; 0232EA7A
	str r2,[r0,#0x10]	; 0232EA7C
	str r1,[r0,#0x14]	; 0232EA7E
	ldr r1,[pool_0232EA9C]	; 0232EA80
	ldrh r2,[r1,#0x0]	; 0232EA82
	mov r1,#0x1	; 0232EA84
	and r2,r1	; 0232EA86
	strh r2,[r0,#0x1a]	; 0232EA88
	bx lr	; 0232EA8A
.endfunc
pool_0232EA8C:
loc_0232EA8C:
	.word REG_DIV_NUMER	; 0232EA8C
pool_0232EA90:
loc_0232EA90:
	.word REG_DIV_DENOM	; 0232EA90
pool_0232EA94:
loc_0232EA94:
	.word REG_DIVCNT	; 0232EA94
pool_0232EA98:
loc_0232EA98:
	.word REG_SQRT_PARAM	; 0232EA98
pool_0232EA9C:
loc_0232EA9C:
	.word REG_SQRTCNT	; 0232EA9C

; ===== function loc_0232EAA0 =====
loc_0232EAA0:
	ldr r1,[pool_0232EAAC]	; 0232EAA0
loc_0232EAA2:
	ldrh r2,[r1,#0x36]	; 0232EAA2
	and r2,r0	; 0232EAA4
	cmp r2,#0x0	; 0232EAA6
	bne loc_0232EAA2	; 0232EAA8
	bx lr	; 0232EAAA
pool_0232EAAC:
loc_0232EAAC:
	.word P1_BssStart + 0x2828C	; 0232EAAC

; ===== function loc_0232EAB0 =====
loc_0232EAB0:
	push {r4,r5,r6,r7,lr}	; 0232EAB0
	sub sp,#0x4	; 0232EAB2
	add r5,r0,#0x0	; 0232EAB4
	add r4,r1,#0x0	; 0232EAB6
	ldr r0,[pool_0232EB70]	; 0232EAB8
	ldrh r0,[r0,#0x30]	; 0232EABA
	cmp r0,#0x0	; 0232EABC
	bne loc_0232EAD8	; 0232EABE
	ldrh r0,[r4,#0x0]	; 0232EAC0
	strh r0,[r5,#0x0]	; 0232EAC2
	ldrh r0,[r4,#0x2]	; 0232EAC4
	strh r0,[r5,#0x2]	; 0232EAC6
	ldrh r0,[r4,#0x4]	; 0232EAC8
	strh r0,[r5,#0x4]	; 0232EACA
	ldrh r0,[r4,#0x6]	; 0232EACC
	strh r0,[r5,#0x6]	; 0232EACE
	add sp,#0x4	; 0232EAD0
	pop {r4,r5,r6,r7}	; 0232EAD2
	pop {r3}	; 0232EAD4
	bx r3	; 0232EAD6
loc_0232EAD8:
	ldrh r0,[r4,#0x4]	; 0232EAD8
	strh r0,[r5,#0x4]	; 0232EADA
	ldrh r0,[r4,#0x6]	; 0232EADC
	strh r0,[r5,#0x6]	; 0232EADE
	ldrh r0,[r4,#0x4]	; 0232EAE0
	cmp r0,#0x0	; 0232EAE2
	bne loc_0232EAF4	; 0232EAE4
	mov r0,#0x0	; 0232EAE6
	strh r0,[r5,#0x0]	; 0232EAE8
	strh r0,[r5,#0x2]	; 0232EAEA
	add sp,#0x4	; 0232EAEC
	pop {r4,r5,r6,r7}	; 0232EAEE
	pop {r3}	; 0232EAF0
	bx r3	; 0232EAF2
loc_0232EAF4:
	ldr r0,[pool_0232EB74]	; 0232EAF4
	ldr r0,[r0,#0x8]	; 0232EAF6
	asr r1,r0,#0x1f	; 0232EAF8
	ldrh r2,[r4,#0x0]	; 0232EAFA
	lsl r6,r2,#0x2	; 0232EAFC
	asr r3,r6,#0x1f	; 0232EAFE
	ldr r2,[pool_0232EB74]	; 0232EB00
	ldr r2,[r2,#0x0]	; 0232EB02
	asr r7,r2,#0x1f	; 0232EB04
	sub r2,r6,r2	; 0232EB06
	sbc r3,r7	; 0232EB08
	blx P1_AeabiLmul	; 0232EB0A
	lsl r1,r1,#0xa	; 0232EB0E
	lsr r0,r0,#0x16	; 0232EB10
	orr r0,r1	; 0232EB12
	strh r0,[r5,#0x0]	; 0232EB14
	mov r0,#0x0	; 0232EB16
	ldrsh r1,[r5,r0]	; 0232EB18
	cmp r1,#0x0	; 0232EB1A
	bge loc_0232EB22	; 0232EB1C
	strh r0,[r5,#0x0]	; 0232EB1E
	b loc_0232EB2A	; 0232EB20
loc_0232EB22:
	cmp r1,#0xff	; 0232EB22
	ble loc_0232EB2A	; 0232EB24
	mov r0,#0xff	; 0232EB26
	strh r0,[r5,#0x0]	; 0232EB28
loc_0232EB2A:
	ldr r0,[pool_0232EB74]	; 0232EB2A
	ldr r0,[r0,#0x14]	; 0232EB2C
	asr r1,r0,#0x1f	; 0232EB2E
	ldrh r2,[r4,#0x2]	; 0232EB30
	lsl r2,r2,#0x2	; 0232EB32
	asr r3,r2,#0x1f	; 0232EB34
	ldr r4,[pool_0232EB74]	; 0232EB36
	ldr r6,[r4,#0xc]	; 0232EB38
	asr r4,r6,#0x1f	; 0232EB3A
	sub r2,r2,r6	; 0232EB3C
	sbc r3,r4	; 0232EB3E
	blx P1_AeabiLmul	; 0232EB40
	lsl r1,r1,#0xa	; 0232EB44
	lsr r0,r0,#0x16	; 0232EB46
	orr r0,r1	; 0232EB48
	strh r0,[r5,#0x2]	; 0232EB4A
	mov r0,#0x2	; 0232EB4C
	ldrsh r0,[r5,r0]	; 0232EB4E
	cmp r0,#0x0	; 0232EB50
	bge loc_0232EB60	; 0232EB52
	mov r0,#0x0	; 0232EB54
	strh r0,[r5,#0x2]	; 0232EB56
	add sp,#0x4	; 0232EB58
	pop {r4,r5,r6,r7}	; 0232EB5A
	pop {r3}	; 0232EB5C
	bx r3	; 0232EB5E
loc_0232EB60:
	cmp r0,#0xbf	; 0232EB60
	ble loc_0232EB68	; 0232EB62
	mov r0,#0xbf	; 0232EB64
	strh r0,[r5,#0x2]	; 0232EB66
loc_0232EB68:
	add sp,#0x4	; 0232EB68
	pop {r4,r5,r6,r7}	; 0232EB6A
	pop {r3}	; 0232EB6C
	bx r3	; 0232EB6E
pool_0232EB70:
loc_0232EB70:
	.word P1_BssStart + 0x2828C	; 0232EB70
pool_0232EB74:
loc_0232EB74:
	.word P1_BssStart + 0x282A4	; 0232EB74

; ===== function loc_0232EB78 =====
loc_0232EB78:
	push {r4,r5,r6,r7,lr}	; 0232EB78
	sub sp,#0x24	; 0232EB7A
	add r5,r0,#0x0	; 0232EB7C
	add r4,r1,#0x0	; 0232EB7E
	add r7,r2,#0x0	; 0232EB80
	add r6,r3,#0x0	; 0232EB82
	ldr r2,[pool_0232ED04]	; 0232EB84
	cmp r4,r2	; 0232EB86
	bcs loc_0232EB9E	; 0232EB88
	cmp r7,r2	; 0232EB8A
	bcs loc_0232EB9E	; 0232EB8C
	add r3,sp,#0x28	; 0232EB8E
	ldrh r1,[r3,#0x14]	; 0232EB90
	cmp r1,r2	; 0232EB92
	bcs loc_0232EB9E	; 0232EB94
	ldrh r0,[r3,#0x18]	; 0232EB96
	str r0,[sp,#0x20]	; 0232EB98
	cmp r0,r2	; 0232EB9A
	bcc loc_0232EBA8	; 0232EB9C
loc_0232EB9E:
	mov r0,#0x1	; 0232EB9E
	add sp,#0x24	; 0232EBA0
	pop {r4,r5,r6,r7}	; 0232EBA2
	pop {r3}	; 0232EBA4
	bx r3	; 0232EBA6
loc_0232EBA8:
	ldr r0,[pool_0232ED08]	; 0232EBA8
	cmp r6,r0	; 0232EBAA
	bcs loc_0232EBC4	; 0232EBAC
	ldrh r0,[r3,#0x1c]	; 0232EBAE
	ldr r2,[pool_0232ED08]	; 0232EBB0
	cmp r0,r2	; 0232EBB2
	bcs loc_0232EBC4	; 0232EBB4
	ldrh r2,[r3,#0x10]	; 0232EBB6
	str r2,[sp,#0x1c]	; 0232EBB8
	cmp r2,#0xc0	; 0232EBBA
	bcs loc_0232EBC4	; 0232EBBC
	ldrh r2,[r3,#0x20]	; 0232EBBE
	cmp r2,#0xc0	; 0232EBC0
	bcc loc_0232EBCE	; 0232EBC2
loc_0232EBC4:
	mov r0,#0x1	; 0232EBC4
	add sp,#0x24	; 0232EBC6
	pop {r4,r5,r6,r7}	; 0232EBC8
	pop {r3}	; 0232EBCA
	bx r3	; 0232EBCC
loc_0232EBCE:
	cmp r6,r0	; 0232EBCE
	beq loc_0232EBE2	; 0232EBD0
	ldr r0,[sp,#0x1c]	; 0232EBD2
	cmp r0,r2	; 0232EBD4
	beq loc_0232EBE2	; 0232EBD6
	cmp r4,r1	; 0232EBD8
	beq loc_0232EBE2	; 0232EBDA
	ldr r0,[sp,#0x20]	; 0232EBDC
	cmp r7,r0	; 0232EBDE
	bne loc_0232EBEC	; 0232EBE0
loc_0232EBE2:
	mov r0,#0x1	; 0232EBE2
	add sp,#0x24	; 0232EBE4
	pop {r4,r5,r6,r7}	; 0232EBE6
	pop {r3}	; 0232EBE8
	bx r3	; 0232EBEA
loc_0232EBEC:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EBEC
	str r0,[sp,#0x4]	; 0232EBF0
	mov r3,#0x0	; 0232EBF2
	ldr r0,[pool_0232ED0C]	; 0232EBF4
	strh r3,[r0,#0x0]	; 0232EBF6
	add r1,sp,#0x28	; 0232EBF8
	ldrh r1,[r1,#0x14]	; 0232EBFA
	str r1,[sp,#0xc]	; 0232EBFC
	sub r1,r4,r1	; 0232EBFE
	lsl r2,r1,#0x8	; 0232EC00
	ldr r1,[pool_0232ED10]	; 0232EC02
	str r2,[r1,#0x0]	; 0232EC04
	add r1,sp,#0x28	; 0232EC06
	ldrh r1,[r1,#0x1c]	; 0232EC08
	str r1,[sp,#0x8]	; 0232EC0A
	sub r1,r6,r1	; 0232EC0C
	ldr r2,[pool_0232ED14]	; 0232EC0E
	str r1,[r2,#0x0]	; 0232EC10
	str r3,[r2,#0x4]	; 0232EC12
	add r1,sp,#0x28	; 0232EC14
	ldrh r1,[r1,#0x18]	; 0232EC16
	str r1,[sp,#0x18]	; 0232EC18
	sub r3,r7,r1	; 0232EC1A
	add r1,sp,#0x28	; 0232EC1C
	ldrh r1,[r1,#0x20]	; 0232EC1E
	str r1,[sp,#0x10]	; 0232EC20
	add r1,sp,#0x28	; 0232EC22
	ldrh r2,[r1,#0x10]	; 0232EC24
	str r2,[sp,#0x14]	; 0232EC26
	ldr r1,[sp,#0x10]	; 0232EC28
	sub r1,r2,r1	; 0232EC2A
	str r1,[sp,#0x0]	; 0232EC2C
	ldr r1,[pool_0232ED18]	; 0232EC2E
loc_0232EC30:
	ldrh r2,[r0,#0x0]	; 0232EC30
	and r2,r1	; 0232EC32
	cmp r2,#0x0	; 0232EC34
	bne loc_0232EC30	; 0232EC36
	ldr r1,[pool_0232ED1C]	; 0232EC38
	ldr r2,[r1,#0x0]	; 0232EC3A
	mov r1,#0x0	; 0232EC3C
	strh r1,[r0,#0x0]	; 0232EC3E
	lsl r1,r3,#0x8	; 0232EC40
	ldr r0,[pool_0232ED10]	; 0232EC42
	str r1,[r0,#0x0]	; 0232EC44
	ldr r0,[pool_0232ED14]	; 0232EC46
	ldr r1,[sp,#0x0]	; 0232EC48
	str r1,[r0,#0x0]	; 0232EC4A
	mov r1,#0x0	; 0232EC4C
	str r1,[r0,#0x4]	; 0232EC4E
	ldr r0,[pool_0232ED18]	; 0232EC50
	cmp r2,r0	; 0232EC52
	bge loc_0232EC5C	; 0232EC54
	ldr r1,[pool_0232ED20]	; 0232EC56
	cmp r2,r1	; 0232EC58
	bge loc_0232EC6C	; 0232EC5A
loc_0232EC5C:
	ldr r0,[sp,#0x4]	; 0232EC5C
	blx P1_Arm9RestoreIrqMask	; 0232EC5E
	mov r0,#0x1	; 0232EC62
	add sp,#0x24	; 0232EC64
	pop {r4,r5,r6,r7}	; 0232EC66
	pop {r3}	; 0232EC68
	bx r3	; 0232EC6A
loc_0232EC6C:
	strh r2,[r5,#0x4]	; 0232EC6C
	ldr r1,[sp,#0xc]	; 0232EC6E
	add r1,r4,r1	; 0232EC70
	lsl r2,r1,#0x8	; 0232EC72
	mov r1,#0x4	; 0232EC74
	ldrsh r1,[r5,r1]	; 0232EC76
	ldr r3,[sp,#0x8]	; 0232EC78
	add r3,r6,r3	; 0232EC7A
	mul r1,r3	; 0232EC7C
	sub r1,r2,r1	; 0232EC7E
	lsl r1,r1,#0x9	; 0232EC80
	asr r2,r1,#0x10	; 0232EC82
	cmp r2,r0	; 0232EC84
	bge loc_0232EC8E	; 0232EC86
	ldr r1,[pool_0232ED20]	; 0232EC88
	cmp r2,r1	; 0232EC8A
	bge loc_0232EC9E	; 0232EC8C
loc_0232EC8E:
	ldr r0,[sp,#0x4]	; 0232EC8E
	blx P1_Arm9RestoreIrqMask	; 0232EC90
	mov r0,#0x1	; 0232EC94
	add sp,#0x24	; 0232EC96
	pop {r4,r5,r6,r7}	; 0232EC98
	pop {r3}	; 0232EC9A
	bx r3	; 0232EC9C
loc_0232EC9E:
	strh r2,[r5,#0x0]	; 0232EC9E
	ldr r1,[pool_0232ED0C]	; 0232ECA0
loc_0232ECA2:
	ldrh r2,[r1,#0x0]	; 0232ECA2
	and r2,r0	; 0232ECA4
	cmp r2,#0x0	; 0232ECA6
	bne loc_0232ECA2	; 0232ECA8
	ldr r0,[pool_0232ED1C]	; 0232ECAA
	ldr r4,[r0,#0x0]	; 0232ECAC
	ldr r0,[sp,#0x4]	; 0232ECAE
	blx P1_Arm9RestoreIrqMask	; 0232ECB0
	ldr r1,[pool_0232ED18]	; 0232ECB4
	cmp r4,r1	; 0232ECB6
	bge loc_0232ECC0	; 0232ECB8
	ldr r0,[pool_0232ED20]	; 0232ECBA
	cmp r4,r0	; 0232ECBC
	bge loc_0232ECCA	; 0232ECBE
loc_0232ECC0:
	mov r0,#0x1	; 0232ECC0
	add sp,#0x24	; 0232ECC2
	pop {r4,r5,r6,r7}	; 0232ECC4
	pop {r3}	; 0232ECC6
	bx r3	; 0232ECC8
loc_0232ECCA:
	strh r4,[r5,#0x6]	; 0232ECCA
	ldr r2,[sp,#0x18]	; 0232ECCC
	add r2,r7,r2	; 0232ECCE
	lsl r3,r2,#0x8	; 0232ECD0
	mov r2,#0x6	; 0232ECD2
	ldrsh r2,[r5,r2]	; 0232ECD4
	ldr r6,[sp,#0x14]	; 0232ECD6
	ldr r4,[sp,#0x10]	; 0232ECD8
	add r4,r6,r4	; 0232ECDA
	mul r2,r4	; 0232ECDC
	sub r2,r3,r2	; 0232ECDE
	lsl r2,r2,#0x9	; 0232ECE0
	asr r2,r2,#0x10	; 0232ECE2
	cmp r2,r1	; 0232ECE4
	bge loc_0232ECEC	; 0232ECE6
	cmp r2,r0	; 0232ECE8
	bge loc_0232ECF6	; 0232ECEA
loc_0232ECEC:
	mov r0,#0x1	; 0232ECEC
	add sp,#0x24	; 0232ECEE
	pop {r4,r5,r6,r7}	; 0232ECF0
	pop {r3}	; 0232ECF2
	bx r3	; 0232ECF4
loc_0232ECF6:
	strh r2,[r5,#0x2]	; 0232ECF6
	mov r0,#0x0	; 0232ECF8
	add sp,#0x24	; 0232ECFA
	pop {r4,r5,r6,r7}	; 0232ECFC
	pop {r3}	; 0232ECFE
	bx r3	; 0232ED00
	.byte 0xC0, 0x46	; 0232ED04
pool_0232ED04:
loc_0232ED04:
	.word 0x00001000	; 0232ED04
pool_0232ED08:
loc_0232ED08:
	.word 0x00000100	; 0232ED08
pool_0232ED0C:
loc_0232ED0C:
	.word REG_DIVCNT	; 0232ED0C
pool_0232ED10:
loc_0232ED10:
	.word REG_DIV_NUMER	; 0232ED10
pool_0232ED14:
loc_0232ED14:
	.word REG_DIV_DENOM	; 0232ED14
pool_0232ED18:
loc_0232ED18:
	.word 0x00008000	; 0232ED18
pool_0232ED1C:
loc_0232ED1C:
	.word REG_DIV_RESULT	; 0232ED1C
pool_0232ED20:
loc_0232ED20:
	.word 0xFFFF8000	; 0232ED20

; ===== function loc_0232ED24 =====
loc_0232ED24:
	push {r4,lr}	; 0232ED24
	add r4,r0,#0x0	; 0232ED26
	mov r0,#0x1	; 0232ED28
	bl loc_0232EAA0	; 0232ED2A
	ldr r1,[pool_0232ED54]	; 0232ED2E
	ldrh r2,[r1,#0x34]	; 0232ED30
	mov r0,#0x1	; 0232ED32
	and r2,r0	; 0232ED34
	cmp r2,#0x0	; 0232ED36
	bne loc_0232ED4C	; 0232ED38
	ldrh r0,[r1,#0x4]	; 0232ED3A
	strh r0,[r4,#0x0]	; 0232ED3C
	ldrh r0,[r1,#0x6]	; 0232ED3E
	strh r0,[r4,#0x2]	; 0232ED40
	ldrh r0,[r1,#0x8]	; 0232ED42
	strh r0,[r4,#0x4]	; 0232ED44
	ldrh r0,[r1,#0xa]	; 0232ED46
	strh r0,[r4,#0x6]	; 0232ED48
	mov r0,#0x0	; 0232ED4A
loc_0232ED4C:
	pop {r4}	; 0232ED4C
	pop {r3}	; 0232ED4E
	bx r3	; 0232ED50
	.byte 0xC0, 0x46	; 0232ED54
pool_0232ED54:
loc_0232ED54:
	.word P1_BssStart + 0x2828C	; 0232ED54

; ===== function loc_0232ED58 =====
loc_0232ED58:
	push {r4,lr}	; 0232ED58
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232ED5A
	add r4,r0,#0x0	; 0232ED5E
	mov r0,#0x6	; 0232ED60
	ldr r1,[pool_0232EDB8]	; 0232ED62
	mov r2,#0x0	; 0232ED64
	bl loc_0232E858	; 0232ED66
	cmp r0,#0x0	; 0232ED6A
	blt loc_0232ED72	; 0232ED6C
	mov r0,#0x1	; 0232ED6E
	b loc_0232ED74	; 0232ED70
loc_0232ED72:
	mov r0,#0x0	; 0232ED72
loc_0232ED74:
	cmp r0,#0x0	; 0232ED74
	bne loc_0232ED9C	; 0232ED76
	add r0,r4,#0x0	; 0232ED78
	blx P1_Arm9RestoreIrqMask	; 0232ED7A
	ldr r1,[pool_0232EDBC]	; 0232ED7E
	ldrh r2,[r1,#0x34]	; 0232ED80
	mov r0,#0x1	; 0232ED82
	orr r2,r0	; 0232ED84
	strh r2,[r1,#0x34]	; 0232ED86
	ldr r3,[r1,#0x0]	; 0232ED88
	cmp r3,#0x0	; 0232ED8A
	beq loc_0232EDB2	; 0232ED8C
	mov r0,#0x0	; 0232ED8E
	mov r1,#0x4	; 0232ED90
	add r2,r0,#0x0	; 0232ED92
	blx r3	; 0232ED94
	pop {r4}	; 0232ED96
	pop {r3}	; 0232ED98
	bx r3	; 0232ED9A
loc_0232ED9C:
	ldr r1,[pool_0232EDBC]	; 0232ED9C
	ldrh r2,[r1,#0x36]	; 0232ED9E
	mov r0,#0x1	; 0232EDA0
	orr r2,r0	; 0232EDA2
	strh r2,[r1,#0x36]	; 0232EDA4
	ldrh r2,[r1,#0x34]	; 0232EDA6
	bic r2,r0	; 0232EDA8
	strh r2,[r1,#0x34]	; 0232EDAA
	add r0,r4,#0x0	; 0232EDAC
	blx P1_Arm9RestoreIrqMask	; 0232EDAE
loc_0232EDB2:
	pop {r4}	; 0232EDB2
	pop {r3}	; 0232EDB4
	bx r3	; 0232EDB6
pool_0232EDB8:
loc_0232EDB8:
	.word P1_DtcmRuntimeStart	; 0232EDB8
pool_0232EDBC:
loc_0232EDBC:
	.word P1_BssStart + 0x2828C	; 0232EDBC

; ===== function loc_0232EDC0 =====
loc_0232EDC0:
	push {r4,r5,r6,r7,lr}	; 0232EDC0
	sub sp,#0x4	; 0232EDC2
	add r4,r0,#0x0	; 0232EDC4
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232EDC6
	add r6,r0,#0x0	; 0232EDCA
	mov r7,#0x4	; 0232EDCC
	ldrsh r5,[r4,r7]	; 0232EDCE
	mov r3,#0x0	; 0232EDD0
	ldr r2,[pool_0232EE44]	; 0232EDD2
	strh r3,[r2,#0x0]	; 0232EDD4
	ldr r1,[pool_0232EE48]	; 0232EDD6
	ldr r0,[pool_0232EE4C]	; 0232EDD8
	str r1,[r0,#0x0]	; 0232EDDA
	ldr r0,[pool_0232EE50]	; 0232EDDC
	str r5,[r0,#0x0]	; 0232EDDE
	str r3,[r0,#0x4]	; 0232EDE0
	ldrsh r1,[r4,r3]	; 0232EDE2
	ldr r0,[pool_0232EE54]	; 0232EDE4
	str r1,[r0,#0x18]	; 0232EDE6
	ldrsh r1,[r4,r7]	; 0232EDE8
	str r1,[r0,#0x1c]	; 0232EDEA
	ldr r0,[pool_0232EE58]	; 0232EDEC
loc_0232EDEE:
	ldrh r1,[r2,#0x0]	; 0232EDEE
	and r1,r0	; 0232EDF0
	cmp r1,#0x0	; 0232EDF2
	bne loc_0232EDEE	; 0232EDF4
	ldr r0,[pool_0232EE5C]	; 0232EDF6
	ldr r0,[r0,#0x0]	; 0232EDF8
	ldr r3,[pool_0232EE54]	; 0232EDFA
	str r0,[r3,#0x20]	; 0232EDFC
	mov r7,#0x6	; 0232EDFE
	ldrsh r1,[r4,r7]	; 0232EE00
	mov r0,#0x0	; 0232EE02
	strh r0,[r2,#0x0]	; 0232EE04
	ldr r5,[pool_0232EE48]	; 0232EE06
	ldr r2,[pool_0232EE4C]	; 0232EE08
	str r5,[r2,#0x0]	; 0232EE0A
	ldr r2,[pool_0232EE50]	; 0232EE0C
	str r1,[r2,#0x0]	; 0232EE0E
	str r0,[r2,#0x4]	; 0232EE10
	mov r0,#0x2	; 0232EE12
	ldrsh r0,[r4,r0]	; 0232EE14
	str r0,[r3,#0x24]	; 0232EE16
	ldrsh r0,[r4,r7]	; 0232EE18
	str r0,[r3,#0x28]	; 0232EE1A
	ldr r1,[pool_0232EE44]	; 0232EE1C
	ldr r0,[pool_0232EE58]	; 0232EE1E
loc_0232EE20:
	ldrh r2,[r1,#0x0]	; 0232EE20
	and r2,r0	; 0232EE22
	cmp r2,#0x0	; 0232EE24
	bne loc_0232EE20	; 0232EE26
	ldr r0,[pool_0232EE5C]	; 0232EE28
	ldr r1,[r0,#0x0]	; 0232EE2A
	ldr r0,[pool_0232EE54]	; 0232EE2C
	str r1,[r0,#0x2c]	; 0232EE2E
	add r0,r6,#0x0	; 0232EE30
	blx P1_Arm9RestoreIrqMask	; 0232EE32
	mov r1,#0x1	; 0232EE36
	ldr r0,[pool_0232EE54]	; 0232EE38
	strh r1,[r0,#0x30]	; 0232EE3A
	add sp,#0x4	; 0232EE3C
	pop {r4,r5,r6,r7}	; 0232EE3E
	pop {r3}	; 0232EE40
	bx r3	; 0232EE42
pool_0232EE44:
loc_0232EE44:
	.word REG_DIVCNT	; 0232EE44
pool_0232EE48:
loc_0232EE48:
	.word 0x10000000	; 0232EE48
pool_0232EE4C:
loc_0232EE4C:
	.word REG_DIV_NUMER	; 0232EE4C
pool_0232EE50:
loc_0232EE50:
	.word REG_DIV_DENOM	; 0232EE50
pool_0232EE54:
loc_0232EE54:
	.word P1_BssStart + 0x2828C	; 0232EE54
pool_0232EE58:
loc_0232EE58:
	.word 0x00008000	; 0232EE58
pool_0232EE5C:
loc_0232EE5C:
	.word REG_DIV_RESULT	; 0232EE5C

; ===== function loc_0232EE60 =====
loc_0232EE60:
	push {r4,r5,lr}	; 0232EE60
	sub sp,#0x4	; 0232EE62
	ldr r0,[pool_0232EEA8]	; 0232EE64
	ldrh r1,[r0,#0x0]	; 0232EE66
	cmp r1,#0x0	; 0232EE68
	bne loc_0232EE9E	; 0232EE6A
	mov r1,#0x1	; 0232EE6C
	strh r1,[r0,#0x0]	; 0232EE6E
	bl loc_0232E778	; 0232EE70
	mov r1,#0x0	; 0232EE74
	ldr r0,[pool_0232EEAC]	; 0232EE76
	strh r1,[r0,#0xc]	; 0232EE78
	str r1,[r0,#0x0]	; 0232EE7A
	str r1,[r0,#0x10]	; 0232EE7C
	strh r1,[r0,#0x32]	; 0232EE7E
	strh r1,[r0,#0x30]	; 0232EE80
	strh r1,[r0,#0x36]	; 0232EE82
	strh r1,[r0,#0x34]	; 0232EE84
	mov r5,#0x6	; 0232EE86
	mov r4,#0x1	; 0232EE88
loc_0232EE8A:
	add r0,r5,#0x0	; 0232EE8A
	add r1,r4,#0x0	; 0232EE8C
	bl loc_0232E8EC	; 0232EE8E
	cmp r0,#0x0	; 0232EE92
	beq loc_0232EE8A	; 0232EE94
	mov r0,#0x6	; 0232EE96
	ldr r1,[pool_0232EEB0]	; 0232EE98
	bl P1_SetPxiReceiveCallback	; 0232EE9A
loc_0232EE9E:
	add sp,#0x4	; 0232EE9E
	pop {r4,r5}	; 0232EEA0
	pop {r3}	; 0232EEA2
	bx r3	; 0232EEA4
	.byte 0xC0, 0x46	; 0232EEA8
pool_0232EEA8:
loc_0232EEA8:
	.word P1_BssStart + 0x28288	; 0232EEA8
pool_0232EEAC:
loc_0232EEAC:
	.word P1_BssStart + 0x2828C	; 0232EEAC
pool_0232EEB0:
loc_0232EEB0:
	.word P1_PxiCallback_0232EEB4 + 1	; 0232EEB0

; ===== function loc_0232EEB4 =====
P1_PxiCallback_0232EEB4:
	push {r4,lr}	; 0232EEB4
	sub sp,#0x8	; 0232EEB6
	lsl r0,r1,#0x10	; 0232EEB8
	lsr r3,r0,#0x10	; 0232EEBA
	ldr r0,[pool_0232EFA8]	; 0232EEBC
	add r4,r3,#0x0	; 0232EEBE
	and r4,r0	; 0232EEC0
	lsl r0,r4,#0x8	; 0232EEC2
	lsr r0,r0,#0x10	; 0232EEC4
	cmp r2,#0x0	; 0232EEC6
	beq loc_0232EEEA	; 0232EEC8
	ldr r1,[pool_0232EFAC]	; 0232EECA
	ldrh r3,[r1,#0x34]	; 0232EECC
	mov r2,#0x1	; 0232EECE
	lsl r2,r0	; 0232EED0
	orr r3,r2	; 0232EED2
	strh r3,[r1,#0x34]	; 0232EED4
	ldr r3,[r1,#0x0]	; 0232EED6
	cmp r3,#0x0	; 0232EED8
	beq loc_0232EFA0	; 0232EEDA
	mov r1,#0x4	; 0232EEDC
	mov r2,#0x0	; 0232EEDE
	blx r3	; 0232EEE0
	add sp,#0x8	; 0232EEE2
	pop {r4}	; 0232EEE4
	pop {r3}	; 0232EEE6
	bx r3	; 0232EEE8
loc_0232EEEA:
	ldr r2,[pool_0232EFB0]	; 0232EEEA
	and r1,r2	; 0232EEEC
	cmp r1,#0x0	; 0232EEEE
	beq loc_0232EFA0	; 0232EEF0
	lsl r1,r3,#0x18	; 0232EEF2
	lsr r1,r1,#0x18	; 0232EEF4
	cmp r1,#0x4	; 0232EEF6
	bhi loc_0232EF9C	; 0232EEF8
	add r1,r1,r1	; 0232EEFA
P1_SwitchIndexPC_0232EEFA:
	add r1,pc	; 0232EEFC
	ldrh r1,[r1,#(P1_SwitchTable_0232EEFA - (P1_SwitchIndexPC_0232EEFA + 4))]	; 0232EEFE
	lsl r1,r1,#0x10	; 0232EF00
	asr r1,r1,#0x10	; 0232EF02
P1_SwitchTargetPC_0232EEFA:
	add r1,pc	; 0232EF04
	bx r1	; 0232EF06
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232EEFA:
	.halfword (loc_0232EF12 + 1) - (P1_SwitchTargetPC_0232EEFA + 4)
	.halfword (loc_0232EF9C + 1) - (P1_SwitchTargetPC_0232EEFA + 4)
	.halfword (loc_0232EF6E + 1) - (P1_SwitchTargetPC_0232EEFA + 4)
	.halfword (loc_0232EF72 + 1) - (P1_SwitchTargetPC_0232EEFA + 4)
	.halfword (loc_0232EF6A + 1) - (P1_SwitchTargetPC_0232EEFA + 4)
P1_SwitchTable_0232EEFAEnd:
loc_0232EF12:
	cmp r0,#0x0	; 0232EF12
	bne loc_0232EF48	; 0232EF14
	ldr r1,[pool_0232EFB4]	; 0232EF16
	ldrh r2,[r1,#0x0]	; 0232EF18
	add r1,sp,#0x0	; 0232EF1A
	strh r2,[r1,#0x0]	; 0232EF1C
	ldr r2,[pool_0232EFB8]	; 0232EF1E
	ldrh r2,[r2,#0x0]	; 0232EF20
	strh r2,[r1,#0x2]	; 0232EF22
	ldr r1,[sp,#0x0]	; 0232EF24
	lsl r2,r1,#0x14	; 0232EF26
	lsr r2,r2,#0x14	; 0232EF28
	ldr r3,[pool_0232EFAC]	; 0232EF2A
	strh r2,[r3,#0x4]	; 0232EF2C
	lsl r2,r1,#0x8	; 0232EF2E
	lsr r2,r2,#0x14	; 0232EF30
	strh r2,[r3,#0x6]	; 0232EF32
	lsl r2,r1,#0x7	; 0232EF34
	lsr r2,r2,#0x1f	; 0232EF36
	lsl r2,r2,#0x18	; 0232EF38
	lsr r2,r2,#0x18	; 0232EF3A
	strh r2,[r3,#0x8]	; 0232EF3C
	lsl r1,r1,#0x5	; 0232EF3E
	lsr r1,r1,#0x1e	; 0232EF40
	lsl r1,r1,#0x18	; 0232EF42
	lsr r1,r1,#0x18	; 0232EF44
	strh r1,[r3,#0xa]	; 0232EF46
loc_0232EF48:
	mov r1,#0x0	; 0232EF48
	ldr r2,[pool_0232EFAC]	; 0232EF4A
	strh r1,[r2,#0x32]	; 0232EF4C
	ldrh r4,[r2,#0x36]	; 0232EF4E
	mov r3,#0x1	; 0232EF50
	lsl r3,r0	; 0232EF52
	bic r4,r3	; 0232EF54
	strh r4,[r2,#0x36]	; 0232EF56
	ldr r3,[r2,#0x0]	; 0232EF58
	cmp r3,#0x0	; 0232EF5A
	beq loc_0232EFA0	; 0232EF5C
	add r2,r1,#0x0	; 0232EF5E
	blx r3	; 0232EF60
	add sp,#0x8	; 0232EF62
	pop {r4}	; 0232EF64
	pop {r3}	; 0232EF66
	bx r3	; 0232EF68
loc_0232EF6A:
	mov r1,#0x3	; 0232EF6A
	b loc_0232EF74	; 0232EF6C
loc_0232EF6E:
	mov r1,#0x1	; 0232EF6E
	b loc_0232EF74	; 0232EF70
loc_0232EF72:
	mov r1,#0x2	; 0232EF72
loc_0232EF74:
	mov r4,#0x1	; 0232EF74
	lsl r4,r0	; 0232EF76
	ldr r2,[pool_0232EFAC]	; 0232EF78
	ldrh r3,[r2,#0x34]	; 0232EF7A
	orr r3,r4	; 0232EF7C
	strh r3,[r2,#0x34]	; 0232EF7E
	ldrh r3,[r2,#0x36]	; 0232EF80
	bic r3,r4	; 0232EF82
	strh r3,[r2,#0x36]	; 0232EF84
	ldr r3,[r2,#0x0]	; 0232EF86
	cmp r3,#0x0	; 0232EF88
	beq loc_0232EFA0	; 0232EF8A
	mov r2,#0xff	; 0232EF8C
	and r1,r2	; 0232EF8E
	mov r2,#0x0	; 0232EF90
	blx r3	; 0232EF92
	add sp,#0x8	; 0232EF94
	pop {r4}	; 0232EF96
	pop {r3}	; 0232EF98
	bx r3	; 0232EF9A
loc_0232EF9C:
	bl loc_0232C4CC	; 0232EF9C
loc_0232EFA0:
	add sp,#0x8	; 0232EFA0
	pop {r4}	; 0232EFA2
	pop {r3}	; 0232EFA4
	bx r3	; 0232EFA6
pool_0232EFA8:
loc_0232EFA8:
	.word 0x00007F00	; 0232EFA8
pool_0232EFAC:
loc_0232EFAC:
	.word P1_BssStart + 0x2828C	; 0232EFAC
pool_0232EFB0:
loc_0232EFB0:
	.word 0x01000000	; 0232EFB0
pool_0232EFB4:
loc_0232EFB4:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset	; 0232EFB4
pool_0232EFB8:
loc_0232EFB8:
	.word FirmwareSystemWorkAddress + SystemWorkTouchPanelOffset + 0x2	; 0232EFB8

; ===== function loc_0232EFBC =====
loc_0232EFBC:
	push {r4,lr}	; 0232EFBC
	cmp r0,#0x0	; 0232EFBE
	beq loc_0232F002	; 0232EFC0
	cmp r0,#0x1	; 0232EFC2
	bne loc_0232F02A	; 0232EFC4
	cmp r2,#0x0	; 0232EFC6
	bne loc_0232EFE0	; 0232EFC8
	ldr r0,[pool_0232F034]	; 0232EFCA
	ldr r2,[r0,#0x0]	; 0232EFCC
	ldr r0,[pool_0232F038]	; 0232EFCE
	ldr r0,[r0,#0x0]	; 0232EFD0
	sub r0,r2,r0	; 0232EFD2
	cmp r0,#0x7	; 0232EFD4
	bhi loc_0232EFE0	; 0232EFD6
	mov r0,#0x0	; 0232EFD8
	pop {r4}	; 0232EFDA
	pop {r3}	; 0232EFDC
	bx r3	; 0232EFDE
loc_0232EFE0:
	cmp r3,#0x0	; 0232EFE0
	beq loc_0232EFEC	; 0232EFE2
	add r0,r1,#0x0	; 0232EFE4
	bl loc_0232F1F8	; 0232EFE6
	b loc_0232EFF6	; 0232EFEA
loc_0232EFEC:
	add r0,r1,#0x0	; 0232EFEC
	mov r1,#0x0	; 0232EFEE
	add r2,r1,#0x0	; 0232EFF0
	bl loc_0232F218	; 0232EFF2
loc_0232EFF6:
	ldr r2,[pool_0232F03C]	; 0232EFF6
	ldrh r1,[r2,#0x0]	; 0232EFF8
	mov r0,#0x1	; 0232EFFA
	orr r1,r0	; 0232EFFC
	strh r1,[r2,#0x0]	; 0232EFFE
	b loc_0232F02A	; 0232F000
loc_0232F002:
	ldr r4,[pool_0232F03C]	; 0232F002
	ldrh r2,[r4,#0x0]	; 0232F004
	mov r0,#0x1	; 0232F006
	bic r2,r0	; 0232F008
	strh r2,[r4,#0x0]	; 0232F00A
	ldr r0,[pool_0232F034]	; 0232F00C
	ldr r2,[r0,#0x0]	; 0232F00E
	ldr r0,[pool_0232F038]	; 0232F010
	str r2,[r0,#0x0]	; 0232F012
	cmp r3,#0x0	; 0232F014
	beq loc_0232F020	; 0232F016
	add r0,r1,#0x0	; 0232F018
	bl loc_0232F1F8	; 0232F01A
	b loc_0232F02A	; 0232F01E
loc_0232F020:
	add r0,r1,#0x0	; 0232F020
	mov r1,#0x0	; 0232F022
	add r2,r1,#0x0	; 0232F024
	bl loc_0232F218	; 0232F026
loc_0232F02A:
	mov r0,#0x1	; 0232F02A
	pop {r4}	; 0232F02C
	pop {r3}	; 0232F02E
	bx r3	; 0232F030
	.byte 0xC0, 0x46	; 0232F034
pool_0232F034:
loc_0232F034:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232F034
pool_0232F038:
loc_0232F038:
	.word P1_BssStart + 0x282D0	; 0232F038
pool_0232F03C:
loc_0232F03C:
	.word REG_POWERCNT	; 0232F03C

; ===== function loc_0232F040 =====
loc_0232F040:
	push {r4,r5,r6,r7,lr}	; 0232F040
	sub sp,#0xc	; 0232F042
	add r5,r0,#0x0	; 0232F044
	add r4,r1,#0x0	; 0232F046
	str r2,[sp,#0x0]	; 0232F048
	mov r6,#0x0	; 0232F04A
	ldr r0,[pool_0232F0F4]	; 0232F04C
	ldrh r7,[r0,#0x0]	; 0232F04E
	strh r6,[r0,#0x0]	; 0232F050
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F052
	str r0,[sp,#0x4]	; 0232F056
	ldr r0,[pool_0232F0F8]	; 0232F058
	bl loc_0232B0D8	; 0232F05A
	str r0,[sp,#0x8]	; 0232F05E
	ldr r0,[pool_0232F0FC]	; 0232F060
	bl loc_0232B128	; 0232F062
	ldr r0,[sp,#0x4]	; 0232F066
	blx P1_Arm9RestoreIrqMask	; 0232F068
	ldr r1,[pool_0232F0F4]	; 0232F06C
	ldrh r0,[r1,#0x0]	; 0232F06E
	mov r0,#0x1	; 0232F070
	strh r0,[r1,#0x0]	; 0232F072
	mov r0,#0x10	; 0232F074
	add r1,r5,#0x0	; 0232F076
	and r1,r0	; 0232F078
	cmp r1,#0x0	; 0232F07A
	beq loc_0232F08A	; 0232F07C
	bl loc_0232C5B4	; 0232F07E
	cmp r0,#0x0	; 0232F082
	bne loc_0232F08A	; 0232F084
	mov r0,#0x10	; 0232F086
	bic r5,r0	; 0232F088
loc_0232F08A:
	ldr r0,[sp,#0x0]	; 0232F08A
	orr r4,r0	; 0232F08C
loc_0232F08E:
	lsl r0,r5,#0x10	; 0232F08E
	lsr r0,r0,#0x10	; 0232F090
	lsl r1,r4,#0x10	; 0232F092
	lsr r1,r1,#0x10	; 0232F094
	bl loc_0232F39C	; 0232F096
	cmp r0,#0x0	; 0232F09A
	bne loc_0232F08E	; 0232F09C
	blx P1_Arm9WaitForInterrupt	; 0232F09E
	ldr r0,[pool_0232F100]	; 0232F0A2
	blx P1_Arm9BusyWaitByLoop4	; 0232F0A4
	mov r0,#0x8	; 0232F0A8
	and r5,r0	; 0232F0AA
	cmp r5,#0x0	; 0232F0AC
	beq loc_0232F0BE	; 0232F0AE
	ldr r0,[pool_0232F104]	; 0232F0B0
	ldr r1,[r0,#0x0]	; 0232F0B2
	ldr r0,[pool_0232F108]	; 0232F0B4
	and r1,r0	; 0232F0B6
	cmp r1,#0x0	; 0232F0B8
	beq loc_0232F0BE	; 0232F0BA
	mov r6,#0x1	; 0232F0BC
loc_0232F0BE:
	cmp r6,#0x0	; 0232F0BE
	bne loc_0232F0CE	; 0232F0C0
	mov r0,#0x1	; 0232F0C2
	add r1,r0,#0x0	; 0232F0C4
	add r2,r0,#0x0	; 0232F0C6
	mov r3,#0x0	; 0232F0C8
	bl loc_0232EFBC	; 0232F0CA
loc_0232F0CE:
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F0CE
	ldr r0,[sp,#0x8]	; 0232F0D2
	bl loc_0232B128	; 0232F0D4
	ldr r0,[sp,#0x4]	; 0232F0D8
	blx P1_Arm9RestoreIrqMask	; 0232F0DA
	ldr r1,[pool_0232F0F4]	; 0232F0DE
	ldrh r0,[r1,#0x0]	; 0232F0E0
	strh r7,[r1,#0x0]	; 0232F0E2
	cmp r6,#0x0	; 0232F0E4
	beq loc_0232F0EC	; 0232F0E6
	bl loc_0232F150	; 0232F0E8
loc_0232F0EC:
	add sp,#0xc	; 0232F0EC
	pop {r4,r5,r6,r7}	; 0232F0EE
	pop {r3}	; 0232F0F0
	bx r3	; 0232F0F2
pool_0232F0F4:
loc_0232F0F4:
	.word REG_IME	; 0232F0F4
pool_0232F0F8:
loc_0232F0F8:
	.word 0x003FFFFF	; 0232F0F8
pool_0232F0FC:
loc_0232F0FC:
	.word 0x00040000	; 0232F0FC
pool_0232F100:
loc_0232F100:
	.word 0x00332340	; 0232F100
pool_0232F104:
loc_0232F104:
	.word REG_IF	; 0232F104
pool_0232F108:
loc_0232F108:
	.word 0x00100000	; 0232F108

; ===== function loc_0232F10C =====
loc_0232F10C:
	push {r4,r5,r6,lr}	; 0232F10C
	add r5,r0,#0x0	; 0232F10E
	mov r4,#0x8	; 0232F110
	mov r6,#0x0	; 0232F112
loc_0232F114:
	add r0,r4,#0x0	; 0232F114
	add r1,r5,#0x0	; 0232F116
	add r2,r6,#0x0	; 0232F118
	bl loc_0232E858	; 0232F11A
	cmp r0,#0x0	; 0232F11E
	bne loc_0232F114	; 0232F120
	pop {r4,r5,r6}	; 0232F122
	pop {r3}	; 0232F124
	bx r3	; 0232F126

; ===== function loc_0232F128 =====
loc_0232F128:
	push {r4,lr}	; 0232F128
	sub sp,#0x8	; 0232F12A
	add r4,r0,#0x0	; 0232F12C
	mov r0,#0x1	; 0232F12E
	add r1,sp,#0x0	; 0232F130
	bl loc_0232F2D0	; 0232F132
	cmp r0,#0x0	; 0232F136
	bne loc_0232F148	; 0232F138
	cmp r4,#0x0	; 0232F13A
	beq loc_0232F148	; 0232F13C
	add r1,sp,#0x0	; 0232F13E
	ldrh r2,[r1,#0x0]	; 0232F140
	mov r1,#0x1	; 0232F142
	and r2,r1	; 0232F144
	str r2,[r4,#0x0]	; 0232F146
loc_0232F148:
	add sp,#0x8	; 0232F148
	pop {r4}	; 0232F14A
	pop {r3}	; 0232F14C
	bx r3	; 0232F14E

; ===== function loc_0232F150 =====
loc_0232F150:
	push {lr}	; 0232F150
	sub sp,#0x4	; 0232F152
	ldr r0,[pool_0232F16C]	; 0232F154
	add r1,sp,#0x0	; 0232F156
	bl loc_0232F170	; 0232F158
	cmp r0,#0x0	; 0232F15C
	bne loc_0232F166	; 0232F15E
	bl loc_0232F558	; 0232F160
	ldr r0,[sp,#0x0]	; 0232F164
loc_0232F166:
	add sp,#0x4	; 0232F166
	pop {r3}	; 0232F168
	bx r3	; 0232F16A
pool_0232F16C:
loc_0232F16C:
	.word 0x0232F555	; 0232F16C

; ===== function loc_0232F170 =====
loc_0232F170:
	add r3,r0,#0x0	; 0232F170
	add r2,r1,#0x0	; 0232F172
	mov r0,#0xe	; 0232F174
	add r1,r3,#0x0	; 0232F176
	ldr r3,[pool_0232F17C]	; 0232F178
	bx r3	; 0232F17A
pool_0232F17C:
loc_0232F17C:
	.word loc_0232F348 + 1	; 0232F17C

; ===== function loc_0232F180 =====
loc_0232F180:
	push {lr}	; 0232F180
	sub sp,#0x4	; 0232F182
	ldr r2,[pool_0232F19C]	; 0232F184
	add r3,sp,#0x0	; 0232F186
	bl loc_0232F1A0	; 0232F188
	cmp r0,#0x0	; 0232F18C
	bne loc_0232F196	; 0232F18E
	bl loc_0232F558	; 0232F190
	ldr r0,[sp,#0x0]	; 0232F194
loc_0232F196:
	add sp,#0x4	; 0232F196
	pop {r3}	; 0232F198
	bx r3	; 0232F19A
pool_0232F19C:
loc_0232F19C:
	.word 0x0232F555	; 0232F19C

; ===== function loc_0232F1A0 =====
loc_0232F1A0:
	push {r4,lr}	; 0232F1A0
	mov r4,#0x0	; 0232F1A2
	cmp r0,#0x0	; 0232F1A4
	bne loc_0232F1B6	; 0232F1A6
	cmp r1,#0x1	; 0232F1A8
	bne loc_0232F1AE	; 0232F1AA
	mov r4,#0x6	; 0232F1AC
loc_0232F1AE:
	cmp r1,#0x0	; 0232F1AE
	bne loc_0232F1D8	; 0232F1B0
	mov r4,#0x7	; 0232F1B2
	b loc_0232F1D8	; 0232F1B4
loc_0232F1B6:
	cmp r0,#0x1	; 0232F1B6
	bne loc_0232F1C8	; 0232F1B8
	cmp r1,#0x1	; 0232F1BA
	bne loc_0232F1C0	; 0232F1BC
	mov r4,#0x4	; 0232F1BE
loc_0232F1C0:
	cmp r1,#0x0	; 0232F1C0
	bne loc_0232F1D8	; 0232F1C2
	mov r4,#0x5	; 0232F1C4
	b loc_0232F1D8	; 0232F1C6
loc_0232F1C8:
	cmp r0,#0x2	; 0232F1C8
	bne loc_0232F1D8	; 0232F1CA
	cmp r1,#0x1	; 0232F1CC
	bne loc_0232F1D2	; 0232F1CE
	mov r4,#0x8	; 0232F1D0
loc_0232F1D2:
	cmp r1,#0x0	; 0232F1D2
	bne loc_0232F1D8	; 0232F1D4
	mov r4,#0x9	; 0232F1D6
loc_0232F1D8:
	cmp r4,#0x0	; 0232F1D8
	beq loc_0232F1EC	; 0232F1DA
	add r0,r4,#0x0	; 0232F1DC
	add r1,r2,#0x0	; 0232F1DE
	add r2,r3,#0x0	; 0232F1E0
	bl loc_0232F348	; 0232F1E2
	pop {r4}	; 0232F1E6
	pop {r3}	; 0232F1E8
	bx r3	; 0232F1EA
loc_0232F1EC:
	ldr r0,[pool_0232F1F4]	; 0232F1EC
	pop {r4}	; 0232F1EE
	pop {r3}	; 0232F1F0
	bx r3	; 0232F1F2
pool_0232F1F4:
loc_0232F1F4:
	.word 0x0000FFFF	; 0232F1F4

; ===== function loc_0232F1F8 =====
loc_0232F1F8:
	push {lr}	; 0232F1F8
	sub sp,#0x4	; 0232F1FA
	ldr r1,[pool_0232F214]	; 0232F1FC
	add r2,sp,#0x0	; 0232F1FE
	bl loc_0232F218	; 0232F200
	cmp r0,#0x0	; 0232F204
	bne loc_0232F20E	; 0232F206
	bl loc_0232F558	; 0232F208
	ldr r0,[sp,#0x0]	; 0232F20C
loc_0232F20E:
	add sp,#0x4	; 0232F20E
	pop {r3}	; 0232F210
	bx r3	; 0232F212
pool_0232F214:
loc_0232F214:
	.word 0x0232F555	; 0232F214

; ===== function loc_0232F218 =====
loc_0232F218:
	push {lr}	; 0232F218
	sub sp,#0x4	; 0232F21A
	cmp r0,#0x1	; 0232F21C
	beq loc_0232F22A	; 0232F21E
	cmp r0,#0x2	; 0232F220
	beq loc_0232F232	; 0232F222
	cmp r0,#0x3	; 0232F224
	beq loc_0232F22E	; 0232F226
	b loc_0232F236	; 0232F228
loc_0232F22A:
	mov r0,#0x1	; 0232F22A
	b loc_0232F238	; 0232F22C
loc_0232F22E:
	mov r0,#0x2	; 0232F22E
	b loc_0232F238	; 0232F230
loc_0232F232:
	mov r0,#0x3	; 0232F232
	b loc_0232F238	; 0232F234
loc_0232F236:
	mov r0,#0x0	; 0232F236
loc_0232F238:
	cmp r0,#0x0	; 0232F238
	beq loc_0232F246	; 0232F23A
	bl loc_0232F348	; 0232F23C
	add sp,#0x4	; 0232F240
	pop {r3}	; 0232F242
	bx r3	; 0232F244
loc_0232F246:
	ldr r0,[pool_0232F250]	; 0232F246
	add sp,#0x4	; 0232F248
	pop {r3}	; 0232F24A
	bx r3	; 0232F24C
	.byte 0xC0, 0x46	; 0232F250
pool_0232F250:
loc_0232F250:
	.word 0x0000FFFF	; 0232F250

; ===== function loc_0232F254 =====
loc_0232F254:
	push {lr}	; 0232F254
	sub sp,#0x4	; 0232F256
	ldr r2,[pool_0232F270]	; 0232F258
	add r3,sp,#0x0	; 0232F25A
	bl loc_0232F274	; 0232F25C
	cmp r0,#0x0	; 0232F260
	bne loc_0232F26A	; 0232F262
	bl loc_0232F558	; 0232F264
	ldr r0,[sp,#0x0]	; 0232F268
loc_0232F26A:
	add sp,#0x4	; 0232F26A
	pop {r3}	; 0232F26C
	bx r3	; 0232F26E
pool_0232F270:
loc_0232F270:
	.word 0x0232F555	; 0232F270

; ===== function loc_0232F274 =====
loc_0232F274:
	push {r4,r5,r6,r7,lr}	; 0232F274
	sub sp,#0x4	; 0232F276
	add r5,r0,#0x0	; 0232F278
	add r4,r1,#0x0	; 0232F27A
	add r6,r2,#0x0	; 0232F27C
	add r7,r3,#0x0	; 0232F27E
	bl loc_0232F568	; 0232F280
	cmp r0,#0x0	; 0232F284
	bne loc_0232F292	; 0232F286
	mov r0,#0x1	; 0232F288
	add sp,#0x4	; 0232F28A
	pop {r4,r5,r6,r7}	; 0232F28C
	pop {r3}	; 0232F28E
	bx r3	; 0232F290
loc_0232F292:
	ldr r0,[pool_0232F2C0]	; 0232F292
	str r6,[r0,#0x4]	; 0232F294
	str r7,[r0,#0x8]	; 0232F296
	mov r0,#0xff	; 0232F298
	and r5,r0	; 0232F29A
	ldr r0,[pool_0232F2C4]	; 0232F29C
	orr r5,r0	; 0232F29E
	add r0,r5,#0x0	; 0232F2A0
	bl loc_0232F10C	; 0232F2A2
	ldr r0,[pool_0232F2C8]	; 0232F2A6
	and r4,r0	; 0232F2A8
	ldr r0,[pool_0232F2CC]	; 0232F2AA
	orr r4,r0	; 0232F2AC
	add r0,r4,#0x0	; 0232F2AE
	bl loc_0232F10C	; 0232F2B0
	mov r0,#0x0	; 0232F2B4
	add sp,#0x4	; 0232F2B6
	pop {r4,r5,r6,r7}	; 0232F2B8
	pop {r3}	; 0232F2BA
	bx r3	; 0232F2BC
	.byte 0xC0, 0x46	; 0232F2C0
pool_0232F2C0:
loc_0232F2C0:
	.word P1_BssStart + 0x282D4	; 0232F2C0
pool_0232F2C4:
loc_0232F2C4:
	.word 0x02006400	; 0232F2C4
pool_0232F2C8:
loc_0232F2C8:
	.word 0x0000FFFF	; 0232F2C8
pool_0232F2CC:
loc_0232F2CC:
	.word 0x01010000	; 0232F2CC

; ===== function loc_0232F2D0 =====
loc_0232F2D0:
	push {lr}	; 0232F2D0
	sub sp,#0x4	; 0232F2D2
	ldr r2,[pool_0232F2EC]	; 0232F2D4
	add r3,sp,#0x0	; 0232F2D6
	bl loc_0232F2F0	; 0232F2D8
	cmp r0,#0x0	; 0232F2DC
	bne loc_0232F2E6	; 0232F2DE
	bl loc_0232F558	; 0232F2E0
	ldr r0,[sp,#0x0]	; 0232F2E4
loc_0232F2E6:
	add sp,#0x4	; 0232F2E6
	pop {r3}	; 0232F2E8
	bx r3	; 0232F2EA
pool_0232F2EC:
loc_0232F2EC:
	.word 0x0232F555	; 0232F2EC

; ===== function loc_0232F2F0 =====
loc_0232F2F0:
	push {r4,r5,r6,r7,lr}	; 0232F2F0
	sub sp,#0x4	; 0232F2F2
	add r5,r0,#0x0	; 0232F2F4
	add r4,r1,#0x0	; 0232F2F6
	add r6,r2,#0x0	; 0232F2F8
	add r7,r3,#0x0	; 0232F2FA
	bl loc_0232F568	; 0232F2FC
	cmp r0,#0x0	; 0232F300
	bne loc_0232F30E	; 0232F302
	mov r0,#0x1	; 0232F304
	add sp,#0x4	; 0232F306
	pop {r4,r5,r6,r7}	; 0232F308
	pop {r3}	; 0232F30A
	bx r3	; 0232F30C
loc_0232F30E:
	ldr r0,[pool_0232F338]	; 0232F30E
	str r6,[r0,#0x4]	; 0232F310
	str r7,[r0,#0x8]	; 0232F312
	lsl r2,r5,#0x3	; 0232F314
	mov r1,#0x0	; 0232F316
	ldr r0,[pool_0232F33C]	; 0232F318
	strh r1,[r0,r2]	; 0232F31A
	ldr r0,[pool_0232F340]	; 0232F31C
	str r4,[r0,r2]	; 0232F31E
	mov r0,#0xff	; 0232F320
	and r5,r0	; 0232F322
	ldr r0,[pool_0232F344]	; 0232F324
	orr r5,r0	; 0232F326
	add r0,r5,#0x0	; 0232F328
	bl loc_0232F10C	; 0232F32A
	mov r0,#0x0	; 0232F32E
	add sp,#0x4	; 0232F330
	pop {r4,r5,r6,r7}	; 0232F332
	pop {r3}	; 0232F334
	bx r3	; 0232F336
pool_0232F338:
loc_0232F338:
	.word P1_BssStart + 0x282D4	; 0232F338
pool_0232F33C:
loc_0232F33C:
	.word P1_BssStart + 0x282F8	; 0232F33C
pool_0232F340:
loc_0232F340:
	.word P1_BssStart + 0x282FC	; 0232F340
pool_0232F344:
loc_0232F344:
	.word 0x03006500	; 0232F344

; ===== function loc_0232F348 =====
loc_0232F348:
	push {r4,r5,r6,lr}	; 0232F348
	add r5,r0,#0x0	; 0232F34A
	add r4,r1,#0x0	; 0232F34C
	add r6,r2,#0x0	; 0232F34E
	bl loc_0232F568	; 0232F350
	cmp r0,#0x0	; 0232F354
	bne loc_0232F360	; 0232F356
	mov r0,#0x1	; 0232F358
	pop {r4,r5,r6}	; 0232F35A
	pop {r3}	; 0232F35C
	bx r3	; 0232F35E
loc_0232F360:
	ldr r0,[pool_0232F38C]	; 0232F360
	str r4,[r0,#0x4]	; 0232F362
	str r6,[r0,#0x8]	; 0232F364
	lsr r0,r5,#0x10	; 0232F366
	mov r1,#0xff	; 0232F368
	and r0,r1	; 0232F36A
	ldr r1,[pool_0232F390]	; 0232F36C
	orr r0,r1	; 0232F36E
	bl loc_0232F10C	; 0232F370
	ldr r0,[pool_0232F394]	; 0232F374
	and r5,r0	; 0232F376
	ldr r0,[pool_0232F398]	; 0232F378
	orr r5,r0	; 0232F37A
	add r0,r5,#0x0	; 0232F37C
	bl loc_0232F10C	; 0232F37E
	mov r0,#0x0	; 0232F382
	pop {r4,r5,r6}	; 0232F384
	pop {r3}	; 0232F386
	bx r3	; 0232F388
	.byte 0xC0, 0x46	; 0232F38C
pool_0232F38C:
loc_0232F38C:
	.word P1_BssStart + 0x282D4	; 0232F38C
pool_0232F390:
loc_0232F390:
	.word 0x02006300	; 0232F390
pool_0232F394:
loc_0232F394:
	.word 0x0000FFFF	; 0232F394
pool_0232F398:
loc_0232F398:
	.word 0x01010000	; 0232F398

; ===== function loc_0232F39C =====
loc_0232F39C:
	push {r4,r5,lr}	; 0232F39C
	sub sp,#0x4	; 0232F39E
	add r5,r0,#0x0	; 0232F3A0
	add r4,r1,#0x0	; 0232F3A2
	bl loc_0232F568	; 0232F3A4
	cmp r0,#0x0	; 0232F3A8
	bne loc_0232F3B6	; 0232F3AA
	mov r0,#0x1	; 0232F3AC
	add sp,#0x4	; 0232F3AE
	pop {r4,r5}	; 0232F3B0
	pop {r3}	; 0232F3B2
	bx r3	; 0232F3B4
loc_0232F3B6:
	mov r1,#0x0	; 0232F3B6
	ldr r0,[pool_0232F404]	; 0232F3B8
	str r1,[r0,#0x0]	; 0232F3BA
	ldr r0,[pool_0232F408]	; 0232F3BC
	bl loc_0232F10C	; 0232F3BE
	ldr r1,[pool_0232F404]	; 0232F3C2
loc_0232F3C4:
	ldr r0,[r1,#0x0]	; 0232F3C4
	cmp r0,#0x0	; 0232F3C6
	beq loc_0232F3C4	; 0232F3C8
	mov r0,#0x0	; 0232F3CA
	str r0,[r1,#0x0]	; 0232F3CC
	ldr r1,[pool_0232F40C]	; 0232F3CE
	str r0,[r1,#0x0]	; 0232F3D0
	mov r1,#0x2	; 0232F3D2
	add r2,r0,#0x0	; 0232F3D4
	add r3,r0,#0x0	; 0232F3D6
	bl loc_0232EFBC	; 0232F3D8
	mov r0,#0xff	; 0232F3DC
	and r5,r0	; 0232F3DE
	ldr r0,[pool_0232F410]	; 0232F3E0
	orr r5,r0	; 0232F3E2
	add r0,r5,#0x0	; 0232F3E4
	bl loc_0232F10C	; 0232F3E6
	ldr r0,[pool_0232F414]	; 0232F3EA
	and r4,r0	; 0232F3EC
	ldr r0,[pool_0232F418]	; 0232F3EE
	orr r4,r0	; 0232F3F0
	add r0,r4,#0x0	; 0232F3F2
	bl loc_0232F10C	; 0232F3F4
	mov r0,#0x0	; 0232F3F8
	add sp,#0x4	; 0232F3FA
	pop {r4,r5}	; 0232F3FC
	pop {r3}	; 0232F3FE
	bx r3	; 0232F400
	.byte 0xC0, 0x46	; 0232F404
pool_0232F404:
loc_0232F404:
	.word P1_BssStart + 0x282C8	; 0232F404
pool_0232F408:
loc_0232F408:
	.word 0x03006000	; 0232F408
pool_0232F40C:
loc_0232F40C:
	.word P1_BssStart + 0x282CC	; 0232F40C
pool_0232F410:
loc_0232F410:
	.word 0x02006100	; 0232F410
pool_0232F414:
loc_0232F414:
	.word 0x0000FFFF	; 0232F414
pool_0232F418:
loc_0232F418:
	.word 0x01010000	; 0232F418

; ===== function loc_0232F41C =====
P1_PxiCallback_0232F41C:
	push {lr}	; 0232F41C
	sub sp,#0x4	; 0232F41E
	cmp r2,#0x0	; 0232F420
	beq loc_0232F430	; 0232F422
	mov r0,#0x2	; 0232F424
	bl loc_0232F52C	; 0232F426
	add sp,#0x4	; 0232F42A
	pop {r3}	; 0232F42C
	bx r3	; 0232F42E
loc_0232F430:
	ldr r0,[pool_0232F49C]	; 0232F430
	add r2,r1,#0x0	; 0232F432
	and r2,r0	; 0232F434
	lsl r0,r2,#0x8	; 0232F436
	lsr r3,r0,#0x10	; 0232F438
	mov r2,#0xff	; 0232F43A
	and r1,r2	; 0232F43C
	lsl r0,r1,#0x10	; 0232F43E
	lsr r0,r0,#0x10	; 0232F440
	cmp r3,#0x70	; 0232F442
	bcc loc_0232F468	; 0232F444
	cmp r3,#0x73	; 0232F446
	bhi loc_0232F468	; 0232F448
	and r0,r2	; 0232F44A
	lsl r0,r0,#0x10	; 0232F44C
	lsr r1,r0,#0x10	; 0232F44E
	sub r3,#0x70	; 0232F450
	lsl r2,r3,#0x3	; 0232F452
	ldr r0,[pool_0232F4A0]	; 0232F454
	ldr r0,[r0,r2]	; 0232F456
	cmp r0,#0x0	; 0232F458
	beq loc_0232F45E	; 0232F45A
	strh r1,[r0,#0x0]	; 0232F45C
loc_0232F45E:
	mov r1,#0x1	; 0232F45E
	ldr r0,[pool_0232F4A4]	; 0232F460
	strh r1,[r0,r2]	; 0232F462
	mov r0,#0x0	; 0232F464
	b loc_0232F490	; 0232F466
loc_0232F468:
	cmp r3,#0x60	; 0232F468
	bne loc_0232F474	; 0232F46A
	mov r2,#0x1	; 0232F46C
	ldr r1,[pool_0232F4A8]	; 0232F46E
	str r2,[r1,#0x0]	; 0232F470
	b loc_0232F490	; 0232F472
loc_0232F474:
	cmp r3,#0x62	; 0232F474
	bne loc_0232F480	; 0232F476
	mov r2,#0x1	; 0232F478
	ldr r1,[pool_0232F4AC]	; 0232F47A
	str r2,[r1,#0x0]	; 0232F47C
	b loc_0232F490	; 0232F47E
loc_0232F480:
	cmp r3,#0x67	; 0232F480
	bne loc_0232F490	; 0232F482
	ldr r1,[pool_0232F4B0]	; 0232F484
	ldr r1,[r1,#0xc]	; 0232F486
	cmp r1,#0x0	; 0232F488
	beq loc_0232F48E	; 0232F48A
	str r0,[r1,#0x0]	; 0232F48C
loc_0232F48E:
	mov r0,#0x0	; 0232F48E
loc_0232F490:
	bl loc_0232F52C	; 0232F490
	add sp,#0x4	; 0232F494
	pop {r3}	; 0232F496
	bx r3	; 0232F498
	.byte 0xC0, 0x46	; 0232F49C
pool_0232F49C:
loc_0232F49C:
	.word 0x00007F00	; 0232F49C
pool_0232F4A0:
loc_0232F4A0:
	.word P1_BssStart + 0x282FC	; 0232F4A0
pool_0232F4A4:
loc_0232F4A4:
	.word P1_BssStart + 0x282F8	; 0232F4A4
pool_0232F4A8:
loc_0232F4A8:
	.word P1_BssStart + 0x282C8	; 0232F4A8
pool_0232F4AC:
loc_0232F4AC:
	.word P1_BssStart + 0x282CC	; 0232F4AC
pool_0232F4B0:
loc_0232F4B0:
	.word P1_BssStart + 0x282D4	; 0232F4B0

; ===== function loc_0232F4B4 =====
loc_0232F4B4:
	push {r4,r5,lr}	; 0232F4B4
	sub sp,#0x4	; 0232F4B6
	ldr r0,[pool_0232F510]	; 0232F4B8
	ldrh r1,[r0,#0x0]	; 0232F4BA
	cmp r1,#0x0	; 0232F4BC
	bne loc_0232F506	; 0232F4BE
	mov r1,#0x1	; 0232F4C0
	strh r1,[r0,#0x0]	; 0232F4C2
	mov r1,#0x0	; 0232F4C4
	ldr r0,[pool_0232F514]	; 0232F4C6
	str r1,[r0,#0x0]	; 0232F4C8
	str r1,[r0,#0x4]	; 0232F4CA
	bl loc_0232E778	; 0232F4CC
	mov r5,#0x8	; 0232F4D0
	mov r4,#0x1	; 0232F4D2
loc_0232F4D4:
	add r0,r5,#0x0	; 0232F4D4
	add r1,r4,#0x0	; 0232F4D6
	bl loc_0232E8EC	; 0232F4D8
	cmp r0,#0x0	; 0232F4DC
	beq loc_0232F4D4	; 0232F4DE
	mov r0,#0x8	; 0232F4E0
	ldr r1,[pool_0232F518]	; 0232F4E2
	bl P1_SetPxiReceiveCallback	; 0232F4E4
	mov r2,#0x0	; 0232F4E8
	ldr r1,[pool_0232F51C]	; 0232F4EA
	add r0,r2,#0x0	; 0232F4EC
loc_0232F4EE:
	strh r0,[r1,#0x0]	; 0232F4EE
	add r1,#0x8	; 0232F4F0
	add r2,r2,#0x1	; 0232F4F2
	cmp r2,#0x4	; 0232F4F4
	blt loc_0232F4EE	; 0232F4F6
	ldr r0,[pool_0232F520]	; 0232F4F8
	bl loc_0232BB18	; 0232F4FA
	ldr r0,[pool_0232F524]	; 0232F4FE
	ldr r1,[r0,#0x0]	; 0232F500
	ldr r0,[pool_0232F528]	; 0232F502
	str r1,[r0,#0x0]	; 0232F504
loc_0232F506:
	add sp,#0x4	; 0232F506
	pop {r4,r5}	; 0232F508
	pop {r3}	; 0232F50A
	bx r3	; 0232F50C
	.byte 0xC0, 0x46	; 0232F510
pool_0232F510:
loc_0232F510:
	.word P1_BssStart + 0x282C4	; 0232F510
pool_0232F514:
loc_0232F514:
	.word P1_BssStart + 0x282D4	; 0232F514
pool_0232F518:
loc_0232F518:
	.word P1_PxiCallback_0232F41C + 1	; 0232F518
pool_0232F51C:
loc_0232F51C:
	.word P1_BssStart + 0x282F8	; 0232F51C
pool_0232F520:
loc_0232F520:
	.word 0x02358AC4	; 0232F520
pool_0232F524:
loc_0232F524:
	.word FirmwareBootInfoAddress + BootInfoVBlankCountOffset	; 0232F524
pool_0232F528:
loc_0232F528:
	.word P1_BssStart + 0x282D0	; 0232F528

; ===== function loc_0232F52C =====
loc_0232F52C:
	push {r4,lr}	; 0232F52C
	ldr r3,[pool_0232F550]	; 0232F52E
	ldr r2,[r3,#0x4]	; 0232F530
	ldr r1,[r3,#0x8]	; 0232F532
	ldr r4,[r3,#0x0]	; 0232F534
	cmp r4,#0x0	; 0232F536
	beq loc_0232F53E	; 0232F538
	mov r4,#0x0	; 0232F53A
	str r4,[r3,#0x0]	; 0232F53C
loc_0232F53E:
	cmp r2,#0x0	; 0232F53E
	beq loc_0232F54A	; 0232F540
	mov r4,#0x0	; 0232F542
	ldr r3,[pool_0232F550]	; 0232F544
	str r4,[r3,#0x4]	; 0232F546
	blx r2	; 0232F548
loc_0232F54A:
	pop {r4}	; 0232F54A
	pop {r3}	; 0232F54C
	bx r3	; 0232F54E
pool_0232F550:
loc_0232F550:
	.word P1_BssStart + 0x282D4	; 0232F550
	str r0,[r1,#0x0]	; 0232F554
	bx lr	; 0232F556

; ===== function loc_0232F558 =====
loc_0232F558:
	ldr r1,[pool_0232F564]	; 0232F558
loc_0232F55A:
	ldr r0,[r1,#0x0]	; 0232F55A
	cmp r0,#0x0	; 0232F55C
	bne loc_0232F55A	; 0232F55E
	bx lr	; 0232F560
	.byte 0xC0, 0x46	; 0232F564
pool_0232F564:
loc_0232F564:
	.word P1_BssStart + 0x282D4	; 0232F564

; ===== function loc_0232F568 =====
loc_0232F568:
	push {lr}	; 0232F568
	sub sp,#0x4	; 0232F56A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232F56C
	ldr r1,[pool_0232F594]	; 0232F570
	ldr r2,[r1,#0x0]	; 0232F572
	cmp r2,#0x0	; 0232F574
	beq loc_0232F584	; 0232F576
	blx P1_Arm9RestoreIrqMask	; 0232F578
	mov r0,#0x0	; 0232F57C
	add sp,#0x4	; 0232F57E
	pop {r3}	; 0232F580
	bx r3	; 0232F582
loc_0232F584:
	mov r2,#0x1	; 0232F584
	str r2,[r1,#0x0]	; 0232F586
	blx P1_Arm9RestoreIrqMask	; 0232F588
	mov r0,#0x1	; 0232F58C
	add sp,#0x4	; 0232F58E
	pop {r3}	; 0232F590
	bx r3	; 0232F592
pool_0232F594:
loc_0232F594:
	.word P1_BssStart + 0x282D4	; 0232F594
.arm

; ===== function loc_0232F598 =====
loc_0232F598:
	ldr r12,[pool_0232F5AC]	; 0232F598
loc_0232F59C:
	ldr r0,[r12,#0x0]	; 0232F59C
	cmp r0,#0x1	; 0232F5A0
	beq loc_0232F59C	; 0232F5A4
	bx lr	; 0232F5A8
pool_0232F5AC:
loc_0232F5AC:
	.word P1_BssStart + 0x2831C	; 0232F5AC
.thumb
	ldr r1,[pool_0232F5B8]	; 0232F5B0
	str r0,[r1,#0x20]	; 0232F5B2
	bx lr	; 0232F5B4
	.byte 0xC0, 0x46	; 0232F5B8
pool_0232F5B8:
loc_0232F5B8:
	.word P1_BssStart + 0x2831C	; 0232F5B8

; ===== function loc_0232F5BC =====
loc_0232F5BC:
	push {r4,r5,lr}	; 0232F5BC
	sub sp,#0x4	; 0232F5BE
	add r5,r0,#0x0	; 0232F5C0
	add r4,r1,#0x0	; 0232F5C2
	ldr r0,[r5,#0x0]	; 0232F5C4
	cmp r0,#0xc	; 0232F5C6
	bcc loc_0232F5D4	; 0232F5C8
	ldr r1,[r4,#0x0]	; 0232F5CA
	mov r0,#0x40	; 0232F5CC
	orr r1,r0	; 0232F5CE
	str r1,[r4,#0x0]	; 0232F5D0
	b loc_0232F5DC	; 0232F5D2
loc_0232F5D4:
	ldr r1,[r4,#0x0]	; 0232F5D4
	mov r0,#0x40	; 0232F5D6
	bic r1,r0	; 0232F5D8
	str r1,[r4,#0x0]	; 0232F5DA
loc_0232F5DC:
	ldr r0,[r5,#0x0]	; 0232F5DC
	bl loc_0232F730	; 0232F5DE
	ldr r2,[r4,#0x0]	; 0232F5E2
	mov r1,#0x3f	; 0232F5E4
	bic r2,r1	; 0232F5E6
	and r0,r1	; 0232F5E8
	orr r2,r0	; 0232F5EA
	str r2,[r4,#0x0]	; 0232F5EC
	ldr r0,[r5,#0x4]	; 0232F5EE
	bl loc_0232F730	; 0232F5F0
	ldr r2,[r4,#0x0]	; 0232F5F4
	ldr r1,[pool_0232F624]	; 0232F5F6
	and r2,r1	; 0232F5F8
	mov r1,#0x7f	; 0232F5FA
	and r0,r1	; 0232F5FC
	lsl r0,r0,#0x8	; 0232F5FE
	orr r2,r0	; 0232F600
	str r2,[r4,#0x0]	; 0232F602
	ldr r0,[r5,#0x8]	; 0232F604
	bl loc_0232F730	; 0232F606
	ldr r2,[r4,#0x0]	; 0232F60A
	ldr r1,[pool_0232F628]	; 0232F60C
	and r2,r1	; 0232F60E
	mov r1,#0x7f	; 0232F610
	and r0,r1	; 0232F612
	lsl r0,r0,#0x10	; 0232F614
	orr r2,r0	; 0232F616
	str r2,[r4,#0x0]	; 0232F618
	add sp,#0x4	; 0232F61A
	pop {r4,r5}	; 0232F61C
	pop {r3}	; 0232F61E
	bx r3	; 0232F620
	.byte 0xC0, 0x46	; 0232F624
pool_0232F624:
loc_0232F624:
	.word 0xFFFF80FF	; 0232F624
pool_0232F628:
loc_0232F628:
	.word 0xFF80FFFF	; 0232F628

; ===== function loc_0232F62C =====
loc_0232F62C:
	push {r4,r5,lr}	; 0232F62C
	sub sp,#0x4	; 0232F62E
	add r5,r0,#0x0	; 0232F630
	add r4,r1,#0x0	; 0232F632
	ldr r0,[r5,#0x0]	; 0232F634
	bl loc_0232F730	; 0232F636
	str r0,[r4,#0x0]	; 0232F63A
	ldr r0,[r5,#0x4]	; 0232F63C
	bl loc_0232F730	; 0232F63E
	ldr r2,[r4,#0x0]	; 0232F642
	ldr r1,[pool_0232F684]	; 0232F644
	and r2,r1	; 0232F646
	mov r1,#0x1f	; 0232F648
	and r0,r1	; 0232F64A
	lsl r0,r0,#0x8	; 0232F64C
	orr r2,r0	; 0232F64E
	str r2,[r4,#0x0]	; 0232F650
	ldr r0,[r5,#0x8]	; 0232F652
	bl loc_0232F730	; 0232F654
	ldr r2,[r4,#0x0]	; 0232F658
	ldr r1,[pool_0232F688]	; 0232F65A
	and r2,r1	; 0232F65C
	mov r1,#0x3f	; 0232F65E
	and r0,r1	; 0232F660
	lsl r0,r0,#0x10	; 0232F662
	orr r2,r0	; 0232F664
	str r2,[r4,#0x0]	; 0232F666
	ldr r2,[r4,#0x0]	; 0232F668
	ldr r0,[pool_0232F68C]	; 0232F66A
	and r2,r0	; 0232F66C
	ldr r1,[r5,#0xc]	; 0232F66E
	mov r0,#0x7	; 0232F670
	and r1,r0	; 0232F672
	lsl r0,r1,#0x18	; 0232F674
	orr r2,r0	; 0232F676
	str r2,[r4,#0x0]	; 0232F678
	add sp,#0x4	; 0232F67A
	pop {r4,r5}	; 0232F67C
	pop {r3}	; 0232F67E
	bx r3	; 0232F680
	.byte 0xC0, 0x46	; 0232F684
pool_0232F684:
loc_0232F684:
	.word 0xFFFFE0FF	; 0232F684
pool_0232F688:
loc_0232F688:
	.word 0xFFC0FFFF	; 0232F688
pool_0232F68C:
loc_0232F68C:
	.word 0xF8FFFFFF	; 0232F68C

; ===== function loc_0232F690 =====
loc_0232F690:
	push {r4,lr}	; 0232F690
	sub sp,#0x8	; 0232F692
	add r4,r0,#0x0	; 0232F694
	mov r2,#0x0	; 0232F696
	str r2,[sp,#0x0]	; 0232F698
	mov r0,#0x7	; 0232F69A
	bic r2,r0	; 0232F69C
	ldr r1,[r4,#0x0]	; 0232F69E
	and r1,r0	; 0232F6A0
	orr r2,r1	; 0232F6A2
	str r2,[sp,#0x0]	; 0232F6A4
	ldr r0,[r4,#0x4]	; 0232F6A6
	cmp r0,#0xc	; 0232F6A8
	bcc loc_0232F6B2	; 0232F6AA
	ldr r0,[pool_0232F71C]	; 0232F6AC
	orr r2,r0	; 0232F6AE
	str r2,[sp,#0x0]	; 0232F6B0
loc_0232F6B2:
	ldr r0,[r4,#0x4]	; 0232F6B2
	bl loc_0232F730	; 0232F6B4
	ldr r2,[sp,#0x0]	; 0232F6B8
	ldr r1,[pool_0232F720]	; 0232F6BA
	and r2,r1	; 0232F6BC
	mov r1,#0x3f	; 0232F6BE
	and r0,r1	; 0232F6C0
	lsl r0,r0,#0x8	; 0232F6C2
	orr r2,r0	; 0232F6C4
	str r2,[sp,#0x0]	; 0232F6C6
	ldr r0,[r4,#0x8]	; 0232F6C8
	bl loc_0232F730	; 0232F6CA
	ldr r1,[sp,#0x0]	; 0232F6CE
	ldr r2,[pool_0232F724]	; 0232F6D0
	and r1,r2	; 0232F6D2
	mov r2,#0x7f	; 0232F6D4
	and r0,r2	; 0232F6D6
	lsl r0,r0,#0x10	; 0232F6D8
	orr r1,r0	; 0232F6DA
	str r1,[sp,#0x0]	; 0232F6DC
	ldr r2,[r4,#0xc]	; 0232F6DE
	mov r0,#0x1	; 0232F6E0
	and r2,r0	; 0232F6E2
	cmp r2,#0x0	; 0232F6E4
	beq loc_0232F6EE	; 0232F6E6
	mov r0,#0x80	; 0232F6E8
	orr r1,r0	; 0232F6EA
	str r1,[sp,#0x0]	; 0232F6EC
loc_0232F6EE:
	ldr r1,[r4,#0xc]	; 0232F6EE
	mov r0,#0x2	; 0232F6F0
	and r1,r0	; 0232F6F2
	cmp r1,#0x0	; 0232F6F4
	beq loc_0232F700	; 0232F6F6
	ldr r1,[sp,#0x0]	; 0232F6F8
	ldr r0,[pool_0232F728]	; 0232F6FA
	orr r1,r0	; 0232F6FC
	str r1,[sp,#0x0]	; 0232F6FE
loc_0232F700:
	ldr r1,[r4,#0xc]	; 0232F700
	mov r0,#0x4	; 0232F702
	and r1,r0	; 0232F704
	cmp r1,#0x0	; 0232F706
	beq loc_0232F712	; 0232F708
	ldr r1,[sp,#0x0]	; 0232F70A
	ldr r0,[pool_0232F72C]	; 0232F70C
	orr r1,r0	; 0232F70E
	str r1,[sp,#0x0]	; 0232F710
loc_0232F712:
	ldr r0,[sp,#0x0]	; 0232F712
	add sp,#0x8	; 0232F714
	pop {r4}	; 0232F716
	pop {r3}	; 0232F718
	bx r3	; 0232F71A
pool_0232F71C:
loc_0232F71C:
	.word 0x00004000	; 0232F71C
pool_0232F720:
loc_0232F720:
	.word 0xFFFFC0FF	; 0232F720
pool_0232F724:
loc_0232F724:
	.word 0xFF80FFFF	; 0232F724
pool_0232F728:
loc_0232F728:
	.word 0x00008000	; 0232F728
pool_0232F72C:
loc_0232F72C:
	.word 0x00800000	; 0232F72C

; ===== function loc_0232F730 =====
loc_0232F730:
	push {r4,r5,r6,r7,lr}	; 0232F730
	sub sp,#0x4	; 0232F732
	add r5,r0,#0x0	; 0232F734
	mov r6,#0x0	; 0232F736
	ldr r0,[pool_0232F774]	; 0232F738
	cmp r5,r0	; 0232F73A
	bls loc_0232F748	; 0232F73C
	add r0,r6,#0x0	; 0232F73E
	add sp,#0x4	; 0232F740
	pop {r4,r5,r6,r7}	; 0232F742
	pop {r3}	; 0232F744
	bx r3	; 0232F746
loc_0232F748:
	add r7,r6,#0x0	; 0232F748
	add r4,r6,#0x0	; 0232F74A
loc_0232F74C:
	add r0,r5,#0x0	; 0232F74C
	mov r1,#0xa	; 0232F74E
	blx P1_UnsignedDivMod	; 0232F750
	lsl r1,r4	; 0232F754
	add r6,r6,r1	; 0232F756
	add r0,r5,#0x0	; 0232F758
	mov r1,#0xa	; 0232F75A
	blx P1_UnsignedDivMod	; 0232F75C
	add r5,r0,#0x0	; 0232F760
	add r4,r4,#0x4	; 0232F762
	add r7,r7,#0x1	; 0232F764
	cmp r7,#0x8	; 0232F766
	blt loc_0232F74C	; 0232F768
	add r0,r6,#0x0	; 0232F76A
	add sp,#0x4	; 0232F76C
	pop {r4,r5,r6,r7}	; 0232F76E
	pop {r3}	; 0232F770
	bx r3	; 0232F772
pool_0232F774:
loc_0232F774:
	.word 0x05F5E0FF	; 0232F774

; ===== function loc_0232F778 =====
loc_0232F778:
	push {r4,r5,r6,r7}	; 0232F778
	mov r4,#0x0	; 0232F77A
	add r5,r4,#0x0	; 0232F77C
	add r3,r4,#0x0	; 0232F77E
	mov r1,#0xf	; 0232F780
loc_0232F782:
	add r2,r0,#0x0	; 0232F782
	lsr r2,r3	; 0232F784
	and r2,r1	; 0232F786
	cmp r2,#0xa	; 0232F788
	bcc loc_0232F792	; 0232F78A
	mov r0,#0x0	; 0232F78C
	pop {r4,r5,r6,r7}	; 0232F78E
	bx lr	; 0232F790
loc_0232F792:
	add r3,r3,#0x4	; 0232F792
	add r5,r5,#0x1	; 0232F794
	cmp r5,#0x8	; 0232F796
	blt loc_0232F782	; 0232F798
	mov r1,#0x0	; 0232F79A
	mov r3,#0x1	; 0232F79C
	add r2,r1,#0x0	; 0232F79E
	mov r6,#0xa	; 0232F7A0
loc_0232F7A2:
	add r7,r0,#0x0	; 0232F7A2
	lsr r7,r2	; 0232F7A4
	mov r5,#0xf	; 0232F7A6
	and r7,r5	; 0232F7A8
	add r5,r3,#0x0	; 0232F7AA
	mul r5,r7	; 0232F7AC
	add r4,r4,r5	; 0232F7AE
	add r2,r2,#0x4	; 0232F7B0
	add r1,r1,#0x1	; 0232F7B2
	mul r3,r6	; 0232F7B4
	cmp r1,#0x8	; 0232F7B6
	blt loc_0232F7A2	; 0232F7B8
	add r0,r4,#0x0	; 0232F7BA
	pop {r4,r5,r6,r7}	; 0232F7BC
	bx lr	; 0232F7BE

; ===== function loc_0232F7C0 =====
P1_PxiCallback_0232F7C0:
	push {r4,r5,lr}	; 0232F7C0
	sub sp,#0x4	; 0232F7C2
	cmp r2,#0x0	; 0232F7C4
	beq loc_0232F7FC	; 0232F7C6
	ldr r0,[pool_0232FA94]	; 0232F7C8
	ldr r1,[r0,#0x18]	; 0232F7CA
	cmp r1,#0x0	; 0232F7CC
	beq loc_0232F7D4	; 0232F7CE
	mov r1,#0x0	; 0232F7D0
	str r1,[r0,#0x18]	; 0232F7D2
loc_0232F7D4:
	ldr r0,[pool_0232FA94]	; 0232F7D4
	ldr r1,[r0,#0x0]	; 0232F7D6
	cmp r1,#0x0	; 0232F7D8
	beq loc_0232F7E0	; 0232F7DA
	mov r1,#0x0	; 0232F7DC
	str r1,[r0,#0x0]	; 0232F7DE
loc_0232F7E0:
	ldr r1,[pool_0232FA94]	; 0232F7E0
	ldr r2,[r1,#0x4]	; 0232F7E2
	cmp r2,#0x0	; 0232F7E4
	bne loc_0232F7EA	; 0232F7E6
	b loc_0232FA8A	; 0232F7E8
loc_0232F7EA:
	mov r0,#0x0	; 0232F7EA
	str r0,[r1,#0x4]	; 0232F7EC
	mov r0,#0x6	; 0232F7EE
	ldr r1,[r1,#0x10]	; 0232F7F0
	blx r2	; 0232F7F2
	add sp,#0x4	; 0232F7F4
	pop {r4,r5}	; 0232F7F6
	pop {r3}	; 0232F7F8
	bx r3	; 0232F7FA
loc_0232F7FC:
	mov r2,#0xff	; 0232F7FC
	add r0,r1,#0x0	; 0232F7FE
	and r0,r2	; 0232F800
	ldr r3,[pool_0232FA98]	; 0232F802
	and r1,r3	; 0232F804
	lsr r1,r1,#0x8	; 0232F806
	lsl r1,r1,#0x18	; 0232F808
	lsr r1,r1,#0x18	; 0232F80A
	cmp r1,#0x30	; 0232F80C
	bne loc_0232F824	; 0232F80E
	ldr r0,[pool_0232FA94]	; 0232F810
	ldr r0,[r0,#0x1c]	; 0232F812
	cmp r0,#0x0	; 0232F814
	bne loc_0232F81A	; 0232F816
	b loc_0232FA8A	; 0232F818
loc_0232F81A:
	blx r0	; 0232F81A
	add sp,#0x4	; 0232F81C
	pop {r4,r5}	; 0232F81E
	pop {r3}	; 0232F820
	bx r3	; 0232F822
loc_0232F824:
	cmp r0,#0x0	; 0232F824
	beq loc_0232F82A	; 0232F826
	b loc_0232FA36	; 0232F828
loc_0232F82A:
	mov r4,#0x0	; 0232F82A
	ldr r0,[pool_0232FA94]	; 0232F82C
	ldr r1,[r0,#0x14]	; 0232F82E
	cmp r1,#0xf	; 0232F830
	bls loc_0232F836	; 0232F832
	b loc_0232FA2C	; 0232F834
loc_0232F836:
	add r1,r1,r1	; 0232F836
P1_SwitchIndexPC_0232F836:
	add r1,pc	; 0232F838
	ldrh r1,[r1,#(P1_SwitchTable_0232F836 - (P1_SwitchIndexPC_0232F836 + 4))]	; 0232F83A
	lsl r1,r1,#0x10	; 0232F83C
	asr r1,r1,#0x10	; 0232F83E
P1_SwitchTargetPC_0232F836:
	add r1,pc	; 0232F840
	bx r1	; 0232F842
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232F836:
	.halfword (loc_0232FA2C + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232FA2C + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232F864 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232FA2C + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232FA2C + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232FA66 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232F8C8 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232F8E0 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232F8F8 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232F95C + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232F9C6 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232FA66 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232FA66 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232FA66 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232FA66 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
	.halfword (loc_0232FA66 + 1) - (P1_SwitchTargetPC_0232F836 + 4)
P1_SwitchTable_0232F836End:
loc_0232F864:
	ldr r5,[r0,#0x8]	; 0232F864
	ldr r0,[pool_0232FA9C]	; 0232F866
	ldr r0,[r0,#0x0]	; 0232F868
	and r0,r2	; 0232F86A
	bl loc_0232F778	; 0232F86C
	str r0,[r5,#0x0]	; 0232F870
	ldr r0,[pool_0232FA9C]	; 0232F872
	ldr r0,[r0,#0x0]	; 0232F874
	lsl r0,r0,#0x13	; 0232F876
	lsr r0,r0,#0x1b	; 0232F878
	bl loc_0232F778	; 0232F87A
	str r0,[r5,#0x4]	; 0232F87E
	ldr r0,[pool_0232FA9C]	; 0232F880
	ldr r0,[r0,#0x0]	; 0232F882
	lsl r0,r0,#0xa	; 0232F884
	lsr r0,r0,#0x1a	; 0232F886
	bl loc_0232F778	; 0232F888
	str r0,[r5,#0x8]	; 0232F88C
	ldr r0,[pool_0232FA9C]	; 0232F88E
	ldr r0,[r0,#0x0]	; 0232F890
	lsl r0,r0,#0x5	; 0232F892
	lsr r0,r0,#0x1d	; 0232F894
	str r0,[r5,#0xc]	; 0232F896
	ldr r0,[pool_0232FA94]	; 0232F898
	ldr r5,[r0,#0xc]	; 0232F89A
	ldr r0,[pool_0232FAA0]	; 0232F89C
	ldr r0,[r0,#0x0]	; 0232F89E
	lsl r0,r0,#0x1a	; 0232F8A0
	lsr r0,r0,#0x1a	; 0232F8A2
	bl loc_0232F778	; 0232F8A4
	str r0,[r5,#0x0]	; 0232F8A8
	ldr r0,[pool_0232FAA0]	; 0232F8AA
	ldr r0,[r0,#0x0]	; 0232F8AC
	lsl r0,r0,#0x11	; 0232F8AE
	lsr r0,r0,#0x19	; 0232F8B0
	bl loc_0232F778	; 0232F8B2
	str r0,[r5,#0x4]	; 0232F8B6
	ldr r0,[pool_0232FAA0]	; 0232F8B8
	ldr r0,[r0,#0x0]	; 0232F8BA
	lsl r0,r0,#0x9	; 0232F8BC
	lsr r0,r0,#0x19	; 0232F8BE
	bl loc_0232F778	; 0232F8C0
	str r0,[r5,#0x8]	; 0232F8C4
	b loc_0232FA66	; 0232F8C6
loc_0232F8C8:
	ldr r1,[r0,#0x8]	; 0232F8C8
	ldr r0,[pool_0232FAA4]	; 0232F8CA
	ldrh r0,[r0,#0x0]	; 0232F8CC
	lsl r0,r0,#0x1c	; 0232F8CE
	lsr r0,r0,#0x1c	; 0232F8D0
	cmp r0,#0x4	; 0232F8D2
	bne loc_0232F8DC	; 0232F8D4
	mov r0,#0x1	; 0232F8D6
	str r0,[r1,#0x0]	; 0232F8D8
	b loc_0232FA66	; 0232F8DA
loc_0232F8DC:
	str r4,[r1,#0x0]	; 0232F8DC
	b loc_0232FA66	; 0232F8DE
loc_0232F8E0:
	ldr r1,[r0,#0x8]	; 0232F8E0
	ldr r0,[pool_0232FAA4]	; 0232F8E2
	ldrh r0,[r0,#0x0]	; 0232F8E4
	lsl r0,r0,#0x19	; 0232F8E6
	lsr r0,r0,#0x1f	; 0232F8E8
	cmp r0,#0x0	; 0232F8EA
	beq loc_0232F8F4	; 0232F8EC
	mov r0,#0x1	; 0232F8EE
	str r0,[r1,#0x0]	; 0232F8F0
	b loc_0232FA66	; 0232F8F2
loc_0232F8F4:
	str r4,[r1,#0x0]	; 0232F8F4
	b loc_0232FA66	; 0232F8F6
loc_0232F8F8:
	ldr r5,[r0,#0x8]	; 0232F8F8
	ldr r1,[pool_0232FAA0]	; 0232F8FA
	ldr r0,[r1,#0x0]	; 0232F8FC
	lsl r0,r0,#0x1d	; 0232F8FE
	lsr r0,r0,#0x1d	; 0232F900
	str r0,[r5,#0x0]	; 0232F902
	ldr r0,[r1,#0x0]	; 0232F904
	lsl r0,r0,#0x12	; 0232F906
	lsr r0,r0,#0x1a	; 0232F908
	bl loc_0232F778	; 0232F90A
	str r0,[r5,#0x4]	; 0232F90E
	ldr r0,[pool_0232FAA0]	; 0232F910
	ldr r0,[r0,#0x0]	; 0232F912
	lsl r0,r0,#0x9	; 0232F914
	lsr r0,r0,#0x19	; 0232F916
	bl loc_0232F778	; 0232F918
	str r0,[r5,#0x8]	; 0232F91C
	lsl r0,r4,#0	; 0232F91E
	str r0,[r5,#0xc]	; 0232F920
	ldr r0,[pool_0232FAA0]	; 0232F922
	ldr r0,[r0,#0x0]	; 0232F924
	lsl r0,r0,#0x18	; 0232F926
	lsr r0,r0,#0x1f	; 0232F928
	cmp r0,#0x0	; 0232F92A
	beq loc_0232F934	; 0232F92C
	ldr r0,[r5,#0xc]	; 0232F92E
	add r0,r0,#0x1	; 0232F930
	str r0,[r5,#0xc]	; 0232F932
loc_0232F934:
	ldr r0,[pool_0232FAA0]	; 0232F934
	ldr r0,[r0,#0x0]	; 0232F936
	lsl r0,r0,#0x10	; 0232F938
	lsr r0,r0,#0x1f	; 0232F93A
	cmp r0,#0x0	; 0232F93C
	beq loc_0232F946	; 0232F93E
	ldr r0,[r5,#0xc]	; 0232F940
	add r0,r0,#0x2	; 0232F942
	str r0,[r5,#0xc]	; 0232F944
loc_0232F946:
	ldr r0,[pool_0232FAA0]	; 0232F946
	ldr r0,[r0,#0x0]	; 0232F948
	lsl r0,r0,#0x8	; 0232F94A
	lsr r0,r0,#0x1f	; 0232F94C
	cmp r0,#0x0	; 0232F94E
	bne loc_0232F954	; 0232F950
	b loc_0232FA66	; 0232F952
loc_0232F954:
	ldr r0,[r5,#0xc]	; 0232F954
	add r0,r0,#0x4	; 0232F956
	str r0,[r5,#0xc]	; 0232F958
	b loc_0232FA66	; 0232F95A
loc_0232F95C:
	ldr r2,[r0,#0x18]	; 0232F95C
	cmp r2,#0x0	; 0232F95E
	bne loc_0232F9C2	; 0232F960
	ldr r1,[r0,#0x8]	; 0232F962
	ldr r1,[r1,#0x0]	; 0232F964
	cmp r1,#0x1	; 0232F966
	bne loc_0232F998	; 0232F968
	ldr r1,[pool_0232FAA4]	; 0232F96A
	ldrh r3,[r1,#0x0]	; 0232F96C
	lsl r3,r3,#0x1c	; 0232F96E
	lsr r3,r3,#0x1c	; 0232F970
	cmp r3,#0x4	; 0232F972
	beq loc_0232FA66	; 0232F974
	add r2,r2,#0x1	; 0232F976
	str r2,[r0,#0x18]	; 0232F978
	ldrh r2,[r1,#0x0]	; 0232F97A
	mov r0,#0xf	; 0232F97C
	bic r2,r0	; 0232F97E
	mov r0,#0x4	; 0232F980
	orr r2,r0	; 0232F982
	strh r2,[r1,#0x0]	; 0232F984
	bl loc_0232FE30	; 0232F986
	cmp r0,#0x0	; 0232F98A
	bne loc_0232FA66	; 0232F98C
	lsl r1,r4,#0	; 0232F98E
	ldr r0,[pool_0232FA94]	; 0232F990
	str r1,[r0,#0x18]	; 0232F992
	mov r4,#0x3	; 0232F994
	b loc_0232FA66	; 0232F996
loc_0232F998:
	ldr r1,[pool_0232FAA4]	; 0232F998
	ldrh r3,[r1,#0x0]	; 0232F99A
	lsl r3,r3,#0x1c	; 0232F99C
	lsr r3,r3,#0x1c	; 0232F99E
	cmp r3,#0x0	; 0232F9A0
	beq loc_0232FA66	; 0232F9A2
	add r2,r2,#0x1	; 0232F9A4
	str r2,[r0,#0x18]	; 0232F9A6
	ldrh r2,[r1,#0x0]	; 0232F9A8
	mov r0,#0xf	; 0232F9AA
	bic r2,r0	; 0232F9AC
	strh r2,[r1,#0x0]	; 0232F9AE
	bl loc_0232FE30	; 0232F9B0
	cmp r0,#0x0	; 0232F9B4
	bne loc_0232FA66	; 0232F9B6
	lsl r1,r4,#0	; 0232F9B8
	ldr r0,[pool_0232FA94]	; 0232F9BA
	str r1,[r0,#0x18]	; 0232F9BC
	mov r4,#0x3	; 0232F9BE
	b loc_0232FA66	; 0232F9C0
loc_0232F9C2:
	str r4,[r0,#0x18]	; 0232F9C2
	b loc_0232FA66	; 0232F9C4
loc_0232F9C6:
	ldr r2,[r0,#0x18]	; 0232F9C6
	cmp r2,#0x0	; 0232F9C8
	bne loc_0232FA28	; 0232F9CA
	ldr r1,[r0,#0x8]	; 0232F9CC
	ldr r1,[r1,#0x0]	; 0232F9CE
	cmp r1,#0x1	; 0232F9D0
	bne loc_0232F9FE	; 0232F9D2
	ldr r1,[pool_0232FAA4]	; 0232F9D4
	ldrh r3,[r1,#0x0]	; 0232F9D6
	lsl r3,r3,#0x19	; 0232F9D8
	lsr r3,r3,#0x1f	; 0232F9DA
	cmp r3,#0x0	; 0232F9DC
	bne loc_0232FA66	; 0232F9DE
	add r2,r2,#0x1	; 0232F9E0
	str r2,[r0,#0x18]	; 0232F9E2
	ldrh r2,[r1,#0x0]	; 0232F9E4
	mov r0,#0x40	; 0232F9E6
	orr r2,r0	; 0232F9E8
	strh r2,[r1,#0x0]	; 0232F9EA
	bl loc_0232FE30	; 0232F9EC
	cmp r0,#0x0	; 0232F9F0
	bne loc_0232FA66	; 0232F9F2
	lsl r1,r4,#0	; 0232F9F4
	ldr r0,[pool_0232FA94]	; 0232F9F6
	str r1,[r0,#0x18]	; 0232F9F8
	mov r4,#0x3	; 0232F9FA
	b loc_0232FA66	; 0232F9FC
loc_0232F9FE:
	ldr r1,[pool_0232FAA4]	; 0232F9FE
	ldrh r3,[r1,#0x0]	; 0232FA00
	lsl r3,r3,#0x19	; 0232FA02
	lsr r3,r3,#0x1f	; 0232FA04
	cmp r3,#0x0	; 0232FA06
	beq loc_0232FA66	; 0232FA08
	add r2,r2,#0x1	; 0232FA0A
	str r2,[r0,#0x18]	; 0232FA0C
	ldrh r2,[r1,#0x0]	; 0232FA0E
	mov r0,#0x40	; 0232FA10
	bic r2,r0	; 0232FA12
	strh r2,[r1,#0x0]	; 0232FA14
	bl loc_0232FE30	; 0232FA16
	cmp r0,#0x0	; 0232FA1A
	bne loc_0232FA66	; 0232FA1C
	lsl r1,r4,#0	; 0232FA1E
	ldr r0,[pool_0232FA94]	; 0232FA20
	str r1,[r0,#0x18]	; 0232FA22
	mov r4,#0x3	; 0232FA24
	b loc_0232FA66	; 0232FA26
loc_0232FA28:
	str r4,[r0,#0x18]	; 0232FA28
	b loc_0232FA66	; 0232FA2A
loc_0232FA2C:
	mov r4,#0x4	; 0232FA2C
	mov r1,#0x0	; 0232FA2E
	ldr r0,[pool_0232FA94]	; 0232FA30
	str r1,[r0,#0x18]	; 0232FA32
	b loc_0232FA66	; 0232FA34
loc_0232FA36:
	mov r2,#0x0	; 0232FA36
	ldr r1,[pool_0232FA94]	; 0232FA38
	str r2,[r1,#0x18]	; 0232FA3A
	cmp r0,#0x4	; 0232FA3C
	bhi loc_0232FA64	; 0232FA3E
	add r0,r0,r0	; 0232FA40
P1_SwitchIndexPC_0232FA40:
	add r0,pc	; 0232FA42
	ldrh r0,[r0,#(P1_SwitchTable_0232FA40 - (P1_SwitchIndexPC_0232FA40 + 4))]	; 0232FA44
	lsl r0,r0,#0x10	; 0232FA46
	asr r0,r0,#0x10	; 0232FA48
P1_SwitchTargetPC_0232FA40:
	add r0,pc	; 0232FA4A
	bx r0	; 0232FA4C
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P1_SwitchTable_0232FA40:
	.halfword (loc_0232FA64 + 1) - (P1_SwitchTargetPC_0232FA40 + 4)
	.halfword (loc_0232FA58 + 1) - (P1_SwitchTargetPC_0232FA40 + 4)
	.halfword (loc_0232FA5C + 1) - (P1_SwitchTargetPC_0232FA40 + 4)
	.halfword (loc_0232FA60 + 1) - (P1_SwitchTargetPC_0232FA40 + 4)
	.halfword (loc_0232FA64 + 1) - (P1_SwitchTargetPC_0232FA40 + 4)
P1_SwitchTable_0232FA40End:
loc_0232FA58:
	mov r4,#0x4	; 0232FA58
	b loc_0232FA66	; 0232FA5A
loc_0232FA5C:
	mov r4,#0x5	; 0232FA5C
	b loc_0232FA66	; 0232FA5E
loc_0232FA60:
	mov r4,#0x1	; 0232FA60
	b loc_0232FA66	; 0232FA62
loc_0232FA64:
	mov r4,#0x6	; 0232FA64
loc_0232FA66:
	ldr r0,[pool_0232FA94]	; 0232FA66
	ldr r1,[r0,#0x18]	; 0232FA68
	cmp r1,#0x0	; 0232FA6A
	bne loc_0232FA8A	; 0232FA6C
	ldr r1,[r0,#0x0]	; 0232FA6E
	cmp r1,#0x0	; 0232FA70
	beq loc_0232FA78	; 0232FA72
	mov r1,#0x0	; 0232FA74
	str r1,[r0,#0x0]	; 0232FA76
loc_0232FA78:
	ldr r1,[pool_0232FA94]	; 0232FA78
	ldr r2,[r1,#0x4]	; 0232FA7A
	cmp r2,#0x0	; 0232FA7C
	beq loc_0232FA8A	; 0232FA7E
	mov r0,#0x0	; 0232FA80
	str r0,[r1,#0x4]	; 0232FA82
	add r0,r4,#0x0	; 0232FA84
	ldr r1,[r1,#0x10]	; 0232FA86
	blx r2	; 0232FA88
loc_0232FA8A:
	add sp,#0x4	; 0232FA8A
	pop {r4,r5}	; 0232FA8C
	pop {r3}	; 0232FA8E
	bx r3	; 0232FA90
	.byte 0xC0, 0x46	; 0232FA94
pool_0232FA94:
loc_0232FA94:
	.word P1_BssStart + 0x2831C	; 0232FA94
pool_0232FA98:
loc_0232FA98:
	.word 0x00007F00	; 0232FA98
pool_0232FA9C:
loc_0232FA9C:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset	; 0232FA9C
pool_0232FAA0:
loc_0232FAA0:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FAA0
pool_0232FAA4:
loc_0232FAA4:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x2	; 0232FAA4

; ===== function loc_0232FAA8 =====
loc_0232FAA8:
	push {lr}	; 0232FAA8
	sub sp,#0x4	; 0232FAAA
	ldr r2,[pool_0232FACC]	; 0232FAAC
	mov r3,#0x0	; 0232FAAE
	bl loc_0232FAD4	; 0232FAB0
	ldr r1,[pool_0232FAD0]	; 0232FAB4
	str r0,[r1,#0x20]	; 0232FAB6
	cmp r0,#0x0	; 0232FAB8
	bne loc_0232FAC0	; 0232FABA
	blx loc_0232F598	; 0232FABC
loc_0232FAC0:
	ldr r0,[pool_0232FAD0]	; 0232FAC0
	ldr r0,[r0,#0x20]	; 0232FAC2
	add sp,#0x4	; 0232FAC4
	pop {r3}	; 0232FAC6
	bx r3	; 0232FAC8
	.byte 0xC0, 0x46	; 0232FACC
pool_0232FACC:
loc_0232FACC:
	.word 0x0232F5B1	; 0232FACC
pool_0232FAD0:
loc_0232FAD0:
	.word P1_BssStart + 0x2831C	; 0232FAD0

; ===== function loc_0232FAD4 =====
loc_0232FAD4:
	push {r4,r5,r6,r7,lr}	; 0232FAD4
	sub sp,#0x4	; 0232FAD6
	add r5,r0,#0x0	; 0232FAD8
	add r7,r1,#0x0	; 0232FADA
	add r4,r2,#0x0	; 0232FADC
	add r6,r3,#0x0	; 0232FADE
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FAE0
	ldr r1,[pool_0232FB4C]	; 0232FAE4
	ldr r2,[r1,#0x0]	; 0232FAE6
	cmp r2,#0x0	; 0232FAE8
	beq loc_0232FAFA	; 0232FAEA
	blx P1_Arm9RestoreIrqMask	; 0232FAEC
	mov r0,#0x1	; 0232FAF0
	add sp,#0x4	; 0232FAF2
	pop {r4,r5,r6,r7}	; 0232FAF4
	pop {r3}	; 0232FAF6
	bx r3	; 0232FAF8
loc_0232FAFA:
	mov r2,#0x1	; 0232FAFA
	str r2,[r1,#0x0]	; 0232FAFC
	blx P1_Arm9RestoreIrqMask	; 0232FAFE
	mov r1,#0x0	; 0232FB02
	ldr r0,[pool_0232FB4C]	; 0232FB04
	str r1,[r0,#0x18]	; 0232FB06
	str r4,[r0,#0x4]	; 0232FB08
	str r6,[r0,#0x10]	; 0232FB0A
	add r0,r7,#0x0	; 0232FB0C
	bl loc_0232F690	; 0232FB0E
	str r0,[sp,#0x0]	; 0232FB12
	ldr r1,[pool_0232FB50]	; 0232FB14
	str r0,[r1,#0x0]	; 0232FB16
	cmp r5,#0x0	; 0232FB18
	bne loc_0232FB28	; 0232FB1A
	mov r1,#0xb	; 0232FB1C
	ldr r0,[pool_0232FB4C]	; 0232FB1E
	str r1,[r0,#0x14]	; 0232FB20
	bl loc_0232FE54	; 0232FB22
	b loc_0232FB32	; 0232FB26
loc_0232FB28:
	mov r1,#0xc	; 0232FB28
	ldr r0,[pool_0232FB4C]	; 0232FB2A
	str r1,[r0,#0x14]	; 0232FB2C
	bl loc_0232FE48	; 0232FB2E
loc_0232FB32:
	cmp r0,#0x0	; 0232FB32
	beq loc_0232FB40	; 0232FB34
	mov r0,#0x0	; 0232FB36
	add sp,#0x4	; 0232FB38
	pop {r4,r5,r6,r7}	; 0232FB3A
	pop {r3}	; 0232FB3C
	bx r3	; 0232FB3E
loc_0232FB40:
	mov r0,#0x3	; 0232FB40
	add sp,#0x4	; 0232FB42
	pop {r4,r5,r6,r7}	; 0232FB44
	pop {r3}	; 0232FB46
	bx r3	; 0232FB48
	.byte 0xC0, 0x46	; 0232FB4C
pool_0232FB4C:
loc_0232FB4C:
	.word P1_BssStart + 0x2831C	; 0232FB4C
pool_0232FB50:
loc_0232FB50:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FB50

; ===== function loc_0232FB54 =====
loc_0232FB54:
	push {lr}	; 0232FB54
	sub sp,#0x4	; 0232FB56
	ldr r2,[pool_0232FB78]	; 0232FB58
	mov r3,#0x0	; 0232FB5A
	bl loc_0232FB80	; 0232FB5C
	ldr r1,[pool_0232FB7C]	; 0232FB60
	str r0,[r1,#0x20]	; 0232FB62
	cmp r0,#0x0	; 0232FB64
	bne loc_0232FB6C	; 0232FB66
	blx loc_0232F598	; 0232FB68
loc_0232FB6C:
	ldr r0,[pool_0232FB7C]	; 0232FB6C
	ldr r0,[r0,#0x20]	; 0232FB6E
	add sp,#0x4	; 0232FB70
	pop {r3}	; 0232FB72
	bx r3	; 0232FB74
	.byte 0xC0, 0x46	; 0232FB78
pool_0232FB78:
loc_0232FB78:
	.word 0x0232F5B1	; 0232FB78
pool_0232FB7C:
loc_0232FB7C:
	.word P1_BssStart + 0x2831C	; 0232FB7C

; ===== function loc_0232FB80 =====
loc_0232FB80:
	push {r4,r5,r6,r7,lr}	; 0232FB80
	sub sp,#0x4	; 0232FB82
	add r5,r0,#0x0	; 0232FB84
	add r4,r1,#0x0	; 0232FB86
	add r6,r2,#0x0	; 0232FB88
	add r7,r3,#0x0	; 0232FB8A
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FB8C
	ldr r1,[pool_0232FBE8]	; 0232FB90
	ldr r2,[r1,#0x0]	; 0232FB92
	cmp r2,#0x0	; 0232FB94
	beq loc_0232FBA6	; 0232FB96
	blx P1_Arm9RestoreIrqMask	; 0232FB98
	mov r0,#0x1	; 0232FB9C
	add sp,#0x4	; 0232FB9E
	pop {r4,r5,r6,r7}	; 0232FBA0
	pop {r3}	; 0232FBA2
	bx r3	; 0232FBA4
loc_0232FBA6:
	mov r2,#0x1	; 0232FBA6
	str r2,[r1,#0x0]	; 0232FBA8
	blx P1_Arm9RestoreIrqMask	; 0232FBAA
	cmp r5,#0x0	; 0232FBAE
	bne loc_0232FBBA	; 0232FBB0
	mov r1,#0x9	; 0232FBB2
	ldr r0,[pool_0232FBE8]	; 0232FBB4
	str r1,[r0,#0x14]	; 0232FBB6
	b loc_0232FBC0	; 0232FBB8
loc_0232FBBA:
	mov r1,#0xa	; 0232FBBA
	ldr r0,[pool_0232FBE8]	; 0232FBBC
	str r1,[r0,#0x14]	; 0232FBBE
loc_0232FBC0:
	mov r1,#0x0	; 0232FBC0
	ldr r0,[pool_0232FBE8]	; 0232FBC2
	str r1,[r0,#0x18]	; 0232FBC4
	str r4,[r0,#0x8]	; 0232FBC6
	str r6,[r0,#0x4]	; 0232FBC8
	str r7,[r0,#0x10]	; 0232FBCA
	bl loc_0232FE3C	; 0232FBCC
	cmp r0,#0x0	; 0232FBD0
	beq loc_0232FBDE	; 0232FBD2
	mov r0,#0x0	; 0232FBD4
	add sp,#0x4	; 0232FBD6
	pop {r4,r5,r6,r7}	; 0232FBD8
	pop {r3}	; 0232FBDA
	bx r3	; 0232FBDC
loc_0232FBDE:
	mov r0,#0x3	; 0232FBDE
	add sp,#0x4	; 0232FBE0
	pop {r4,r5,r6,r7}	; 0232FBE2
	pop {r3}	; 0232FBE4
	bx r3	; 0232FBE6
pool_0232FBE8:
loc_0232FBE8:
	.word P1_BssStart + 0x2831C	; 0232FBE8

; ===== function loc_0232FBEC =====
loc_0232FBEC:
	ldr r1,[pool_0232FBF4]	; 0232FBEC
	str r0,[r1,#0x1c]	; 0232FBEE
	bx lr	; 0232FBF0
	.byte 0xC0, 0x46	; 0232FBF4
pool_0232FBF4:
loc_0232FBF4:
	.word P1_BssStart + 0x2831C	; 0232FBF4

; ===== function loc_0232FBF8 =====
loc_0232FBF8:
	push {lr}	; 0232FBF8
	sub sp,#0x4	; 0232FBFA
	ldr r1,[pool_0232FC1C]	; 0232FBFC
	mov r2,#0x0	; 0232FBFE
	bl loc_0232FC24	; 0232FC00
	ldr r1,[pool_0232FC20]	; 0232FC04
	str r0,[r1,#0x20]	; 0232FC06
	cmp r0,#0x0	; 0232FC08
	bne loc_0232FC10	; 0232FC0A
	blx loc_0232F598	; 0232FC0C
loc_0232FC10:
	ldr r0,[pool_0232FC20]	; 0232FC10
	ldr r0,[r0,#0x20]	; 0232FC12
	add sp,#0x4	; 0232FC14
	pop {r3}	; 0232FC16
	bx r3	; 0232FC18
	.byte 0xC0, 0x46	; 0232FC1C
pool_0232FC1C:
loc_0232FC1C:
	.word 0x0232F5B1	; 0232FC1C
pool_0232FC20:
loc_0232FC20:
	.word P1_BssStart + 0x2831C	; 0232FC20

; ===== function loc_0232FC24 =====
loc_0232FC24:
	push {r4,r5,lr}	; 0232FC24
	sub sp,#0x4	; 0232FC26
	add r5,r1,#0x0	; 0232FC28
	add r4,r2,#0x0	; 0232FC2A
	ldrb r1,[r0,#0x0]	; 0232FC2C
	ldr r0,[pool_0232FC80]	; 0232FC2E
	strb r1,[r0,#0x0]	; 0232FC30
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FC32
	ldr r1,[pool_0232FC84]	; 0232FC36
	ldr r2,[r1,#0x0]	; 0232FC38
	cmp r2,#0x0	; 0232FC3A
	beq loc_0232FC4C	; 0232FC3C
	blx P1_Arm9RestoreIrqMask	; 0232FC3E
	mov r0,#0x1	; 0232FC42
	add sp,#0x4	; 0232FC44
	pop {r4,r5}	; 0232FC46
	pop {r3}	; 0232FC48
	bx r3	; 0232FC4A
loc_0232FC4C:
	mov r2,#0x1	; 0232FC4C
	str r2,[r1,#0x0]	; 0232FC4E
	blx P1_Arm9RestoreIrqMask	; 0232FC50
	mov r1,#0xf	; 0232FC54
	ldr r0,[pool_0232FC84]	; 0232FC56
	str r1,[r0,#0x14]	; 0232FC58
	mov r1,#0x0	; 0232FC5A
	str r1,[r0,#0x18]	; 0232FC5C
	str r5,[r0,#0x4]	; 0232FC5E
	str r4,[r0,#0x10]	; 0232FC60
	bl loc_0232FE24	; 0232FC62
	cmp r0,#0x0	; 0232FC66
	beq loc_0232FC74	; 0232FC68
	mov r0,#0x0	; 0232FC6A
	add sp,#0x4	; 0232FC6C
	pop {r4,r5}	; 0232FC6E
	pop {r3}	; 0232FC70
	bx r3	; 0232FC72
loc_0232FC74:
	mov r0,#0x3	; 0232FC74
	add sp,#0x4	; 0232FC76
	pop {r4,r5}	; 0232FC78
	pop {r3}	; 0232FC7A
	bx r3	; 0232FC7C
	.byte 0xC0, 0x46	; 0232FC80
pool_0232FC80:
loc_0232FC80:
	.word FirmwareSystemWorkAddress + SystemWorkRtcOffset + 0x4	; 0232FC80
pool_0232FC84:
loc_0232FC84:
	.word P1_BssStart + 0x2831C	; 0232FC84

; ===== function loc_0232FC88 =====
P1_Entry_0232FC88:
	push {lr}	; 0232FC88
	sub sp,#0x4	; 0232FC8A
	ldr r2,[pool_0232FCAC]	; 0232FC8C
	mov r3,#0x0	; 0232FC8E
	bl loc_0232FCB4	; 0232FC90
	ldr r1,[pool_0232FCB0]	; 0232FC94
	str r0,[r1,#0x20]	; 0232FC96
	cmp r0,#0x0	; 0232FC98
	bne loc_0232FCA0	; 0232FC9A
	blx loc_0232F598	; 0232FC9C
loc_0232FCA0:
	ldr r0,[pool_0232FCB0]	; 0232FCA0
	ldr r0,[r0,#0x20]	; 0232FCA2
	add sp,#0x4	; 0232FCA4
	pop {r3}	; 0232FCA6
	bx r3	; 0232FCA8
	.byte 0xC0, 0x46	; 0232FCAC
pool_0232FCAC:
loc_0232FCAC:
	.word 0x0232F5B1	; 0232FCAC
pool_0232FCB0:
loc_0232FCB0:
	.word P1_BssStart + 0x2831C	; 0232FCB0

; ===== function loc_0232FCB4 =====
loc_0232FCB4:
	push {r4,r5,r6,lr}	; 0232FCB4
	add r6,r1,#0x0	; 0232FCB6
	add r5,r2,#0x0	; 0232FCB8
	add r4,r3,#0x0	; 0232FCBA
	ldr r1,[pool_0232FD10]	; 0232FCBC
	bl loc_0232F62C	; 0232FCBE
	add r0,r6,#0x0	; 0232FCC2
	ldr r1,[pool_0232FD14]	; 0232FCC4
	bl loc_0232F5BC	; 0232FCC6
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FCCA
	ldr r1,[pool_0232FD18]	; 0232FCCE
	ldr r2,[r1,#0x0]	; 0232FCD0
	cmp r2,#0x0	; 0232FCD2
	beq loc_0232FCE2	; 0232FCD4
	blx P1_Arm9RestoreIrqMask	; 0232FCD6
	mov r0,#0x1	; 0232FCDA
	pop {r4,r5,r6}	; 0232FCDC
	pop {r3}	; 0232FCDE
	bx r3	; 0232FCE0
loc_0232FCE2:
	mov r2,#0x1	; 0232FCE2
	str r2,[r1,#0x0]	; 0232FCE4
	blx P1_Arm9RestoreIrqMask	; 0232FCE6
	mov r1,#0x5	; 0232FCEA
	ldr r0,[pool_0232FD18]	; 0232FCEC
	str r1,[r0,#0x14]	; 0232FCEE
	mov r1,#0x0	; 0232FCF0
	str r1,[r0,#0x18]	; 0232FCF2
	str r5,[r0,#0x4]	; 0232FCF4
	str r4,[r0,#0x10]	; 0232FCF6
	bl loc_0232FE60	; 0232FCF8
	cmp r0,#0x0	; 0232FCFC
	beq loc_0232FD08	; 0232FCFE
	mov r0,#0x0	; 0232FD00
	pop {r4,r5,r6}	; 0232FD02
	pop {r3}	; 0232FD04
	bx r3	; 0232FD06
loc_0232FD08:
	mov r0,#0x3	; 0232FD08
	pop {r4,r5,r6}	; 0232FD0A
	pop {r3}	; 0232FD0C
	bx r3	; 0232FD0E
pool_0232FD10:
loc_0232FD10:
	.word 0x027FFDE8	; 0232FD10
pool_0232FD14:
loc_0232FD14:
	.word 0x027FFDEC	; 0232FD14
pool_0232FD18:
loc_0232FD18:
	.word P1_BssStart + 0x2831C	; 0232FD18

; ===== function loc_0232FD1C =====
loc_0232FD1C:
	push {lr}	; 0232FD1C
	sub sp,#0x4	; 0232FD1E
	ldr r2,[pool_0232FD40]	; 0232FD20
	mov r3,#0x0	; 0232FD22
	bl loc_0232FD48	; 0232FD24
	ldr r1,[pool_0232FD44]	; 0232FD28
	str r0,[r1,#0x20]	; 0232FD2A
	cmp r0,#0x0	; 0232FD2C
	bne loc_0232FD34	; 0232FD2E
	blx loc_0232F598	; 0232FD30
loc_0232FD34:
	ldr r0,[pool_0232FD44]	; 0232FD34
	ldr r0,[r0,#0x20]	; 0232FD36
	add sp,#0x4	; 0232FD38
	pop {r3}	; 0232FD3A
	bx r3	; 0232FD3C
	.byte 0xC0, 0x46	; 0232FD40
pool_0232FD40:
loc_0232FD40:
	.word 0x0232F5B1	; 0232FD40
pool_0232FD44:
loc_0232FD44:
	.word P1_BssStart + 0x2831C	; 0232FD44

; ===== function loc_0232FD48 =====
loc_0232FD48:
	push {r4,r5,r6,r7,lr}	; 0232FD48
	sub sp,#0x4	; 0232FD4A
	add r5,r0,#0x0	; 0232FD4C
	add r4,r1,#0x0	; 0232FD4E
	add r6,r2,#0x0	; 0232FD50
	add r7,r3,#0x0	; 0232FD52
	blx P1_Arm9DisableIrqReturnPriorMask	; 0232FD54
	ldr r1,[pool_0232FDA4]	; 0232FD58
	ldr r2,[r1,#0x0]	; 0232FD5A
	cmp r2,#0x0	; 0232FD5C
	beq loc_0232FD6E	; 0232FD5E
	blx P1_Arm9RestoreIrqMask	; 0232FD60
	mov r0,#0x1	; 0232FD64
	add sp,#0x4	; 0232FD66
	pop {r4,r5,r6,r7}	; 0232FD68
	pop {r3}	; 0232FD6A
	bx r3	; 0232FD6C
loc_0232FD6E:
	mov r2,#0x1	; 0232FD6E
	str r2,[r1,#0x0]	; 0232FD70
	blx P1_Arm9RestoreIrqMask	; 0232FD72
	mov r1,#0x2	; 0232FD76
	ldr r0,[pool_0232FDA4]	; 0232FD78
	str r1,[r0,#0x14]	; 0232FD7A
	mov r1,#0x0	; 0232FD7C
	str r1,[r0,#0x18]	; 0232FD7E
	str r5,[r0,#0x8]	; 0232FD80
	str r4,[r0,#0xc]	; 0232FD82
	str r6,[r0,#0x4]	; 0232FD84
	str r7,[r0,#0x10]	; 0232FD86
	bl loc_0232FE6C	; 0232FD88
	cmp r0,#0x0	; 0232FD8C
	beq loc_0232FD9A	; 0232FD8E
	mov r0,#0x0	; 0232FD90
	add sp,#0x4	; 0232FD92
	pop {r4,r5,r6,r7}	; 0232FD94
	pop {r3}	; 0232FD96
	bx r3	; 0232FD98
loc_0232FD9A:
	mov r0,#0x3	; 0232FD9A
	add sp,#0x4	; 0232FD9C
	pop {r4,r5,r6,r7}	; 0232FD9E
	pop {r3}	; 0232FDA0
	bx r3	; 0232FDA2
pool_0232FDA4:
loc_0232FDA4:
	.word P1_BssStart + 0x2831C	; 0232FDA4

; ===== function loc_0232FDA8 =====
loc_0232FDA8:
	push {r4,r5,lr}	; 0232FDA8
	sub sp,#0x4	; 0232FDAA
	ldr r0,[pool_0232FDEC]	; 0232FDAC
	ldrh r1,[r0,#0x0]	; 0232FDAE
	cmp r1,#0x0	; 0232FDB0
	bne loc_0232FDE2	; 0232FDB2
	mov r1,#0x1	; 0232FDB4
	strh r1,[r0,#0x0]	; 0232FDB6
	mov r1,#0x0	; 0232FDB8
	ldr r0,[pool_0232FDF0]	; 0232FDBA
	str r1,[r0,#0x0]	; 0232FDBC
	str r1,[r0,#0x4]	; 0232FDBE
	str r1,[r0,#0x1c]	; 0232FDC0
	str r1,[r0,#0x8]	; 0232FDC2
	str r1,[r0,#0xc]	; 0232FDC4
	bl loc_0232E778	; 0232FDC6
	mov r5,#0x5	; 0232FDCA
	mov r4,#0x1	; 0232FDCC
loc_0232FDCE:
	add r0,r5,#0x0	; 0232FDCE
	add r1,r4,#0x0	; 0232FDD0
	bl loc_0232E8EC	; 0232FDD2
	cmp r0,#0x0	; 0232FDD6
	beq loc_0232FDCE	; 0232FDD8
	mov r0,#0x5	; 0232FDDA
	ldr r1,[pool_0232FDF4]	; 0232FDDC
	bl P1_SetPxiReceiveCallback	; 0232FDDE
loc_0232FDE2:
	add sp,#0x4	; 0232FDE2
	pop {r4,r5}	; 0232FDE4
	pop {r3}	; 0232FDE6
	bx r3	; 0232FDE8
	.byte 0xC0, 0x46	; 0232FDEC
pool_0232FDEC:
loc_0232FDEC:
	.word P1_BssStart + 0x28318	; 0232FDEC
pool_0232FDF0:
loc_0232FDF0:
	.word P1_BssStart + 0x2831C	; 0232FDF0
pool_0232FDF4:
loc_0232FDF4:
	.word P1_PxiCallback_0232F7C0 + 1	; 0232FDF4
loc_0232FDF8:
	push {lr}	; 0232FDF8
	sub sp,#0x4	; 0232FDFA
	add r1,r0,#0x0	; 0232FDFC
	mov r0,#0x5	; 0232FDFE
	lsl r1,r1,#0x8	; 0232FE00
	ldr r2,[pool_0232FE20]	; 0232FE02
	and r1,r2	; 0232FE04
	mov r2,#0x0	; 0232FE06
	bl loc_0232E858	; 0232FE08
	cmp r0,#0x0	; 0232FE0C
	blt loc_0232FE18	; 0232FE0E
	mov r0,#0x1	; 0232FE10
	add sp,#0x4	; 0232FE12
	pop {r3}	; 0232FE14
	bx r3	; 0232FE16
loc_0232FE18:
	mov r0,#0x0	; 0232FE18
	add sp,#0x4	; 0232FE1A
	pop {r3}	; 0232FE1C
	bx r3	; 0232FE1E
pool_0232FE20:
loc_0232FE20:
	.word 0x00007F00	; 0232FE20

; ===== function loc_0232FE24 =====
loc_0232FE24:
	mov r0,#0x28	; 0232FE24
	ldr r3,[pool_0232FE2C]	; 0232FE26
	bx r3	; 0232FE28
	.byte 0xC0, 0x46	; 0232FE2C
pool_0232FE2C:
loc_0232FE2C:
	.word loc_0232FDF8 + 1	; 0232FE2C

; ===== function loc_0232FE30 =====
loc_0232FE30:
	mov r0,#0x27	; 0232FE30
	ldr r3,[pool_0232FE38]	; 0232FE32
	bx r3	; 0232FE34
	.byte 0xC0, 0x46	; 0232FE38
pool_0232FE38:
loc_0232FE38:
	.word loc_0232FDF8 + 1	; 0232FE38

; ===== function loc_0232FE3C =====
loc_0232FE3C:
	mov r0,#0x17	; 0232FE3C
	ldr r3,[pool_0232FE44]	; 0232FE3E
	bx r3	; 0232FE40
	.byte 0xC0, 0x46	; 0232FE44
pool_0232FE44:
loc_0232FE44:
	.word loc_0232FDF8 + 1	; 0232FE44

; ===== function loc_0232FE48 =====
loc_0232FE48:
	mov r0,#0x25	; 0232FE48
	ldr r3,[pool_0232FE50]	; 0232FE4A
	bx r3	; 0232FE4C
	.byte 0xC0, 0x46	; 0232FE50
pool_0232FE50:
loc_0232FE50:
	.word loc_0232FDF8 + 1	; 0232FE50

; ===== function loc_0232FE54 =====
loc_0232FE54:
	mov r0,#0x24	; 0232FE54
	ldr r3,[pool_0232FE5C]	; 0232FE56
	bx r3	; 0232FE58
	.byte 0xC0, 0x46	; 0232FE5C
pool_0232FE5C:
loc_0232FE5C:
	.word loc_0232FDF8 + 1	; 0232FE5C

; ===== function loc_0232FE60 =====
loc_0232FE60:
	mov r0,#0x20	; 0232FE60
	ldr r3,[pool_0232FE68]	; 0232FE62
	bx r3	; 0232FE64
	.byte 0xC0, 0x46	; 0232FE68
pool_0232FE68:
loc_0232FE68:
	.word loc_0232FDF8 + 1	; 0232FE68

; ===== function loc_0232FE6C =====
loc_0232FE6C:
	mov r0,#0x10	; 0232FE6C
	ldr r3,[pool_0232FE74]	; 0232FE6E
	bx r3	; 0232FE70
	.byte 0xC0, 0x46	; 0232FE74
pool_0232FE74:
loc_0232FE74:
	.word loc_0232FDF8 + 1	; 0232FE74
	.byte 0x7D, 0xD1, 0x32, 0x02, 0x21, 0x00, 0x00, 0x00, 0x80, 0x01, 0x10, 0x00, 0x69, 0x3B, 0x36, 0x02	; 0232FE88
	.byte 0x05, 0x76, 0x36, 0x02, 0x21, 0x8B, 0x35, 0x02	; 0232FE88
P1_Data_0232FE90:
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FE90
P1_Data_0232FE98:
	.byte 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00	; 0232FE98
	.byte 0x02, 0x00, 0x05, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x03, 0x00, 0x02, 0x00	; 0232FEB8
	.byte 0x05, 0x00, 0x04, 0x00, 0x01, 0x00, 0x02, 0x00, 0x05, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00	; 0232FEC8
P1_Data_0232FEC8:
	.byte 0x09, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00	; 0232FEC8
P1_Data_0232FED8:
	.byte 0x05, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x06, 0x00, 0x07, 0x00	; 0232FED8
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00	; 0232FEF8
	.byte 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x54, 0x00, 0x06, 0x00, 0x00, 0x00	; 0232FF08
	.byte 0xFF, 0xFF, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x02, 0x00, 0x00, 0x00	; 0232FF18
	.byte 0x32, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0232FF28
	.byte 0x34, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 0232FF38
	.byte 0x2C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xD0, 0xFF, 0x03, 0x00, 0x00, 0x00	; 0232FF48
	.byte 0x2E, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x70, 0x07, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0232FF58
	.byte 0x00, 0x80, 0x08, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x08, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 0232FF68
	.byte 0x00, 0x70, 0x07, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x07, 0x00	; 0232FF78
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x07, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x0A, 0x00	; 0232FF88
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x0A, 0x00, 0x00, 0x60, 0x08, 0x00, 0x00, 0xE0, 0x04, 0x00	; 0232FF98
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x07, 0x00	; 0232FFA8
	.byte 0x00, 0x60, 0x08, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x04, 0x00	; 0232FFB8
	.byte 0x00, 0x90, 0x07, 0x00, 0x00, 0xE0, 0x04, 0x00, 0x00, 0x90, 0x07, 0x00, 0x00, 0x10, 0x07, 0x00	; 0232FFC8
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x07, 0x00, 0x00, 0x60, 0x02, 0x00, 0x00, 0xE0, 0x01, 0x00	; 0232FFD8
	.byte 0x00, 0x90, 0x0D, 0x00, 0x00, 0xE0, 0x01, 0x00, 0x00, 0x90, 0x0D, 0x00, 0x00, 0x10, 0x04, 0x00	; 0232FFE8
	.byte 0x00, 0x60, 0x02, 0x00, 0x00, 0x10, 0x04, 0x00, 0x00, 0x80, 0x0E, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 0232FFF8
	.byte 0x00, 0x90, 0x0F, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x90, 0x0F, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 02330008
	.byte 0x00, 0x80, 0x0E, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0xE0, 0x0A, 0x00	; 02330018
	.byte 0x00, 0x80, 0x01, 0x00, 0x00, 0xE0, 0x0A, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0xA0, 0x0B, 0x00	; 02330028
	.byte 0x00, 0x70, 0x00, 0x00, 0x00, 0xA0, 0x0B, 0x00, 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00	; 02330038
	.byte 0xFF, 0x7F, 0x00, 0x00, 0xFF, 0x7F, 0x00, 0x00	; 02330038
P1_Data_02330040:
	.byte 0x0A, 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00	; 02330040
	.byte 0x08, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00	; 02330058
	.byte 0x04, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00	; 02330068
P1_Data_02330068:
	.byte 0x00, 0x00	; 02330068
P1_Data_0233006A:
	.byte 0x95, 0x00	; 0233006A
P1_Data_0233006C:
	.byte 0x7F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x02, 0x00	; 0233006C
	.byte 0x8A, 0x00, 0x74, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x00, 0x00, 0x06, 0x00, 0x02, 0x00, 0x91, 0x00	; 02330088
	.byte 0x7B, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x00, 0x00, 0x09, 0x00, 0x02, 0x00, 0x86, 0x00, 0x70, 0x00	; 02330098
	.byte 0x0E, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x02, 0x00, 0x8F, 0x00, 0x79, 0x00, 0x0E, 0x00	; 023300A8
	.byte 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x8B, 0x00, 0x75, 0x00, 0x0E, 0x00, 0x01, 0x00	; 023300B8
	.byte 0x05, 0x00, 0x06, 0x00, 0x03, 0x00, 0x8D, 0x00, 0x77, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x06, 0x00	; 023300C8
	.byte 0x06, 0x00, 0x03, 0x00, 0x8C, 0x00, 0x76, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x07, 0x00, 0x06, 0x00	; 023300D8
	.byte 0x03, 0x00, 0x8E, 0x00, 0x78, 0x00, 0x0E, 0x00, 0x01, 0x00, 0x08, 0x00, 0x06, 0x00, 0x03, 0x00	; 023300E8
	.byte 0x92, 0x00, 0x7C, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x09, 0x00, 0x09, 0x00, 0x03, 0x00, 0x93, 0x00	; 023300F8
	.byte 0x7D, 0x00, 0x0E, 0x00, 0x02, 0x00, 0x0A, 0x00, 0x09, 0x00, 0x03, 0x00, 0x94, 0x00, 0x7E, 0x00	; 02330108
	.byte 0x0E, 0x00, 0x02, 0x00, 0x0B, 0x00, 0x09, 0x00, 0x03, 0x00, 0x88, 0x00, 0x72, 0x00, 0x0E, 0x00	; 02330118
	.byte 0x03, 0x00, 0x0C, 0x00, 0x0C, 0x00, 0x03, 0x00, 0x89, 0x00, 0x73, 0x00, 0x0E, 0x00, 0x03, 0x00	; 02330128
	.byte 0x0D, 0x00, 0x0C, 0x00, 0x01, 0x00, 0x90, 0x00, 0x7A, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330138
	.byte 0x02, 0x00, 0x01, 0x00, 0x85, 0x00, 0x6F, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF	; 02330148
	.byte 0x03, 0x00, 0x87, 0x00, 0x71, 0x00, 0x0E, 0x00, 0x03, 0x00, 0x10, 0x00, 0x0C, 0x00, 0x02, 0x00	; 02330158
	.byte 0x85, 0x00, 0x6F, 0x00, 0x0F, 0x00, 0x11, 0x00, 0x00, 0x00, 0xFF, 0xFF	; 02330158
P1_Data_02330164:
	.byte 0x00, 0x00, 0x60, 0x00	; 02330164
P1_Data_02330168:
	.byte 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00	; 02330168
P1_Data_02330170:
	.byte 0x03, 0x00, 0x24, 0x00	; 02330170
P1_Data_02330174:
	.byte 0x01, 0x00	; 02330174
P1_Data_02330176:
	.byte 0x01, 0x00	; 02330176
	.byte 0x02, 0x00, 0x2B, 0x00, 0x00, 0x00, 0x02, 0x00	; 02330178
P1_Data_02330180:
	.byte 0x30, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00	; 02330180
	.byte 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00, 0x38, 0x00, 0x39, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330198
P1_Data_02330198:
	.byte 0x03, 0x03, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0xFF, 0x0F, 0xFF, 0x0F, 0xC7, 0x01, 0x00, 0x00	; 02330198
	.byte 0xC1, 0x86, 0x32, 0x02, 0xBD, 0x86, 0x32, 0x02, 0xB9, 0x86, 0x32, 0x02, 0x00, 0x00, 0x00, 0x00	; 023301B8
	.byte 0xB5, 0x86, 0x32, 0x02, 0x24, 0xD4, 0x00, 0x00, 0x0F, 0x40, 0x00, 0x00, 0x00, 0x01, 0x81, 0x82	; 023301C8
	.byte 0x82, 0x83, 0x0F, 0x83, 0x0C, 0xC3, 0x03, 0x83, 0x01, 0x83, 0x04, 0xC3, 0x08, 0x0E, 0x02, 0xC2	; 023301D8
	.byte 0x0D, 0xC2, 0x07, 0x0B, 0x06, 0x0A, 0x05, 0x09
; ASCII VIB build identifier with the embedded build date. / 含内嵌构建日期的 ASCII VIB 构建标识。
P1_VibBuildIdentifier:
	.ascii "VIB2.11May 26 2005", 0
	.byte 0x00	; 023301F3
; CRT：复制描述符范围、初始化数据源、主 BSS 范围。
; CRT: copy-descriptor bounds, initialized-data source, main BSS bounds.
P1_CrtDataInitTable:
	.word P1_CopyDescriptors, P1_CopyDescriptorsEnd
	.word P1_ItcmLoadStart
	.word P1_BssStart, P3_FirmwareUiEntry
	.byte 0x2D, 0xFD, 0x5B, 0xFE, 0x97, 0xFE, 0xBB, 0xFE, 0xD4, 0xFE, 0xE7, 0xFE, 0xF7, 0xFE, 0x04, 0xFF	; 02330208
	.byte 0x10, 0xFF, 0x1A, 0xFF, 0x23, 0xFF, 0x2C, 0xFF, 0x33, 0xFF, 0x3A, 0xFF, 0x40, 0xFF, 0x46, 0xFF	; 02330218
	.byte 0x4C, 0xFF, 0x51, 0xFF, 0x56, 0xFF, 0x5B, 0xFF, 0x5F, 0xFF, 0x64, 0xFF, 0x68, 0xFF, 0x6C, 0xFF	; 02330228
	.byte 0x6F, 0xFF, 0x73, 0xFF, 0x76, 0xFF, 0x7A, 0xFF, 0x7D, 0xFF, 0x80, 0xFF, 0x83, 0xFF, 0x86, 0xFF	; 02330238
	.byte 0x88, 0xFF, 0x8B, 0xFF, 0x8E, 0xFF, 0x90, 0xFF, 0x92, 0xFF, 0x95, 0xFF, 0x97, 0xFF, 0x99, 0xFF	; 02330248
	.byte 0x9C, 0xFF, 0x9E, 0xFF, 0xA0, 0xFF, 0xA2, 0xFF, 0xA4, 0xFF, 0xA6, 0xFF, 0xA8, 0xFF, 0xAA, 0xFF	; 02330258
	.byte 0xAB, 0xFF, 0xAD, 0xFF, 0xAF, 0xFF, 0xB1, 0xFF, 0xB2, 0xFF, 0xB4, 0xFF, 0xB6, 0xFF, 0xB7, 0xFF	; 02330268
	.byte 0xB9, 0xFF, 0xBA, 0xFF, 0xBC, 0xFF, 0xBD, 0xFF, 0xBF, 0xFF, 0xC0, 0xFF, 0xC2, 0xFF, 0xC3, 0xFF	; 02330278
	.byte 0xC4, 0xFF, 0xC6, 0xFF, 0xC7, 0xFF, 0xC8, 0xFF, 0xCA, 0xFF, 0xCB, 0xFF, 0xCC, 0xFF, 0xCD, 0xFF	; 02330288
	.byte 0xCF, 0xFF, 0xD0, 0xFF, 0xD1, 0xFF, 0xD2, 0xFF, 0xD3, 0xFF, 0xD5, 0xFF, 0xD6, 0xFF, 0xD7, 0xFF	; 02330298
	.byte 0xD8, 0xFF, 0xD9, 0xFF, 0xDA, 0xFF, 0xDB, 0xFF, 0xDC, 0xFF, 0xDD, 0xFF, 0xDE, 0xFF, 0xDF, 0xFF	; 023302A8
	.byte 0xE0, 0xFF, 0xE1, 0xFF, 0xE2, 0xFF, 0xE3, 0xFF, 0xE4, 0xFF, 0xE5, 0xFF, 0xE6, 0xFF, 0xE7, 0xFF	; 023302B8
	.byte 0xE8, 0xFF, 0xE9, 0xFF, 0xE9, 0xFF, 0xEA, 0xFF, 0xEB, 0xFF, 0xEC, 0xFF, 0xED, 0xFF, 0xEE, 0xFF	; 023302C8
	.byte 0xEF, 0xFF, 0xEF, 0xFF, 0xF0, 0xFF, 0xF1, 0xFF, 0xF2, 0xFF, 0xF3, 0xFF, 0xF4, 0xFF, 0xF4, 0xFF	; 023302D8
	.byte 0xF5, 0xFF, 0xF6, 0xFF, 0xF7, 0xFF, 0xF7, 0xFF, 0xF8, 0xFF, 0xF9, 0xFF, 0xFA, 0xFF, 0xFA, 0xFF	; 023302E8
	.byte 0xFB, 0xFF, 0xFC, 0xFF, 0xFD, 0xFF, 0xFD, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00	; 023302F8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330308
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330318
P1_Data_02330320:
	.byte 0x00, 0x00, 0xAA, 0x01, 0x50, 0x03, 0xED, 0x04	; 02330320
	.byte 0x82, 0x06, 0xFE, 0x07, 0x65, 0x09, 0xB1, 0x0A, 0xE3, 0x0B, 0xF0, 0x0C, 0xD9, 0x0D, 0x9B, 0x0E	; 02330328
	.byte 0x37, 0x0F, 0xA6, 0x0F, 0xE9, 0x0F, 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F, 0x39, 0x0F, 0xA1, 0x0E	; 02330338
	.byte 0xDC, 0x0D, 0xF4, 0x0C, 0xE8, 0x0B, 0xBA, 0x0A, 0x6A, 0x09, 0x04, 0x08, 0x87, 0x06, 0xF9, 0x04	; 02330348
	.byte 0x56, 0x03, 0xB1, 0x01, 0x06, 0x00, 0x5C, 0xFE, 0xB0, 0xFC, 0x13, 0xFB, 0x84, 0xF9, 0x07, 0xF8	; 02330358
	.byte 0x9B, 0xF6, 0x4F, 0xF5, 0x21, 0xF4, 0x13, 0xF3, 0x27, 0xF2, 0x65, 0xF1, 0xCB, 0xF0, 0x5B, 0xF0	; 02330368
	.byte 0x17, 0xF0, 0x00, 0xF0, 0x16, 0xF0, 0x58, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1, 0x21, 0xF2, 0x08, 0xF3	; 02330378
	.byte 0x18, 0xF4, 0x46, 0xF5, 0x91, 0xF6, 0xF7, 0xF7, 0x79, 0xF9, 0x07, 0xFB, 0xA3, 0xFC, 0x49, 0xFE	; 02330388
P1_Data_02330398:
	.byte 0x00, 0x10, 0xEA, 0x0F, 0xA7, 0x0F, 0x39, 0x0F, 0x9E, 0x0E, 0xDC, 0x0D, 0xF4, 0x0C, 0xE8, 0x0B	; 02330398
	.byte 0xB5, 0x0A, 0x6A, 0x09, 0x04, 0x08, 0x87, 0x06, 0xF3, 0x04, 0x56, 0x03, 0xB1, 0x01, 0x06, 0x00	; 023303A8
	.byte 0x56, 0xFE, 0xB0, 0xFC, 0x13, 0xFB, 0x84, 0xF9, 0x02, 0xF8, 0x9B, 0xF6, 0x4F, 0xF5, 0x21, 0xF4	; 023303B8
	.byte 0x10, 0xF3, 0x27, 0xF2, 0x65, 0xF1, 0xCB, 0xF0, 0x5A, 0xF0, 0x17, 0xF0, 0x00, 0xF0, 0x16, 0xF0	; 023303C8
	.byte 0x59, 0xF0, 0xC7, 0xF0, 0x5F, 0xF1, 0x21, 0xF2, 0x0C, 0xF3, 0x18, 0xF4, 0x46, 0xF5, 0x91, 0xF6	; 023303D8
	.byte 0xFC, 0xF7, 0x79, 0xF9, 0x07, 0xFB, 0xA3, 0xFC, 0x4F, 0xFE, 0xFA, 0xFF, 0xA4, 0x01, 0x4A, 0x03	; 023303E8
	.byte 0xED, 0x04, 0x7C, 0x06, 0xF9, 0x07, 0x5F, 0x09, 0xB1, 0x0A, 0xDF, 0x0B, 0xED, 0x0C, 0xD6, 0x0D	; 023303F8
	.byte 0x9B, 0x0E, 0x35, 0x0F, 0xA5, 0x0F, 0xE8, 0x0F, 0x83, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00	; 02330408
	.byte 0x96, 0x00, 0x00, 0x00, 0x97, 0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0x00, 0x6E, 0x00, 0x00, 0x00	; 02330418
	.byte 0x82, 0x00, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00	; 02330428
	.byte 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x00, 0x0C, 0x00, 0x00, 0x00	; 02330438
	.byte 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x00, 0x00	; 02330448
	.byte 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00	; 02330458
	.byte 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00	; 02330468
P1_Data_02330478:
	.byte 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x00, 0x00, 0xA9, 0x00, 0x00, 0x00	; 02330478
P1_Data_02330488:
	.byte 0x58, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x60, 0x68, 0x3D, 0x02, 0x00, 0x82, 0x3D, 0x02	; 02330488
	.byte 0x40, 0x96, 0x3D, 0x02, 0x80, 0xAC, 0x3D, 0x02, 0x80, 0xC2, 0x3D, 0x02, 0x60, 0xD8, 0x3D, 0x02	; 02330498
P1_Data_023304A8:
	.byte 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00	; 023304A8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04, 0x00, 0x06, 0x00, 0x08, 0x00	; 023304B8
	.byte 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00	; 023304C8
	.byte 0x00, 0x00, 0x02, 0x00, 0x01, 0x00, 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x01, 0x00	; 023304D8
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 023304E8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00	; 023304F8
	.byte 0x03, 0x00, 0x03, 0x00, 0x03, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00	; 02330508
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330518
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330528
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330538
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330548
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330558
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x04, 0x00	; 02330568
	.byte 0x03, 0x00, 0x00, 0x00, 0x01, 0x00, 0x05, 0x00, 0x08, 0x00, 0x09, 0x00, 0x06, 0x00, 0x00, 0x00	; 02330578
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330588
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330598
	.byte 0x02, 0x00, 0x0A, 0x00, 0x07, 0x00, 0x01, 0x00, 0x05, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 023305A8
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00	; 023305B8
	.byte 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x03, 0x00, 0x04, 0x00	; 023305C8
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01, 0x00	; 023305D8
	.byte 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x44, 0x00	; 023305E8
	.byte 0x44, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00	; 023305F8
	.byte 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x00, 0x00	; 02330608
	.byte 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x2F, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00	; 02330618
	.byte 0x44, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2F, 0x00, 0x44, 0x00	; 02330628
	.byte 0x44, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330638
	.byte 0x44, 0x00, 0x44, 0x00, 0x2E, 0x00, 0x4D, 0x00, 0x4D, 0x00, 0x2E, 0x00, 0x32, 0x00, 0x30, 0x00	; 02330648
	.byte 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x44, 0x00, 0x2F, 0x00, 0x4D, 0x00	; 02330658
	.byte 0x4D, 0x00, 0x2F, 0x00, 0x32, 0x00, 0x30, 0x00, 0x59, 0x00, 0x59, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330668
P1_Data_02330678:
	.byte 0x1F, 0x00, 0x1C, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x1F, 0x00	; 02330678
	.byte 0x1E, 0x00, 0x1F, 0x00, 0x1E, 0x00, 0x1F, 0x00	; 02330688
P1_Data_02330690:
	.byte 0xFF, 0x00, 0x00, 0x00, 0x9B, 0x47, 0x26, 0x74	; 02330690
	.byte 0xBC, 0x11, 0x4F, 0x6D, 0xBD, 0x11, 0xF1, 0x32, 0xD9, 0x7F, 0xE7, 0x2C, 0xA5, 0x5D, 0xBD, 0x11	; 02330698
	.byte 0x10, 0x46, 0xA4, 0x5D, 0x90, 0x4E, 0x73, 0x61, 0x84, 0x2A, 0x91, 0x4E, 0x6A, 0x10, 0xFE, 0x75	; 023306A8
	.byte 0xC8, 0x29, 0x39, 0x78, 0x0E, 0x42, 0x1B, 0x5D, 0x38, 0x78, 0xA8, 0x12, 0x7D, 0x3F, 0xB9, 0x67	; 023306B8
	.byte 0xF3, 0x26, 0xEF, 0x54, 0x23, 0x7C, 0xF2, 0x26, 0xC6, 0x6B, 0x37, 0x41, 0xAB, 0x15, 0x0D, 0x73	; 023306C8
	.byte 0xC7, 0x6B, 0x4F, 0x3B, 0x24, 0x5F, 0xDA, 0x3D, 0x3F, 0x25, 0x49, 0x17, 0xDB, 0x3D, 0xE6, 0x70	; 023306D8
	.byte 0x6C, 0x74, 0xF7, 0x30, 0x1F, 0x53, 0x38, 0x67, 0x1E, 0x53, 0x51, 0x1A, 0x71, 0x19, 0x7D, 0x5B	; 023306E8
	.byte 0xD6, 0x4E, 0x70, 0x19, 0x27, 0x3F, 0xCB, 0x75, 0x62, 0x3D, 0x8C, 0x12, 0xB8, 0x74, 0xAD, 0x2F	; 023306F8
	.byte 0xB9, 0x74, 0xFD, 0x64, 0x9A, 0x6C, 0x3A, 0x4F, 0x6D, 0x27, 0xEF, 0x73, 0xB1, 0x38, 0x3B, 0x4F	; 02330708
	.byte 0x1E, 0x57, 0xA3, 0x7E, 0x49, 0x62, 0x87, 0x35, 0x7C, 0x1B, 0x86, 0x35, 0xFB, 0x7A, 0xE4, 0x67	; 02330718
	.byte 0x92, 0x5C, 0xE5, 0x67, 0xCA, 0x2B, 0x8C, 0x43, 0x6F, 0x2E, 0x7F, 0x58, 0xB7, 0x14, 0x6E, 0x2E	; 02330728
	.byte 0xB9, 0x4C, 0xA2, 0x6F, 0xF0, 0x38, 0x9E, 0x71, 0x5A, 0x47, 0x3C, 0x1F, 0xD8, 0x6A, 0x5B, 0x47	; 02330738
	.byte 0x99, 0x51, 0x64, 0x32, 0x41, 0x7B, 0xEF, 0x49, 0x98, 0x51, 0xD7, 0x1C	; 02330748
P1_Data_02330754:
	.byte 0xC0, 0x01, 0x01, 0x04	; 02330754
	.byte 0x00, 0x00, 0x00, 0x00	; 02330758
P1_Data_0233075C:
	.byte 0x08, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x03, 0x00, 0x04, 0x00	; 0233075C
	.byte 0x05, 0x00, 0x06, 0x00	; 02330768
P1_Data_0233076C:
; 按中断位编号索引的处理入口；保留每项 ARM/Thumb 状态位。
; Handler entries indexed by IRQ bit, preserving each ARM/Thumb state bit.
P1_IrqHandlers:
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 0
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 1
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 2
	.word P1_IrqHandler_0232B010 + 1	; IRQ 3
	.word P1_IrqHandler_0232B004 + 1	; IRQ 4
	.word P1_IrqHandler_0232AFF8 + 1	; IRQ 5
	.word P1_IrqHandler_0232AFEC + 1	; IRQ 6
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 7
	.word P1_IrqHandler_0232B040 + 1	; IRQ 8
	.word P1_IrqHandler_0232B034 + 1	; IRQ 9
	.word P1_IrqHandler_0232B028 + 1	; IRQ 10
	.word P1_IrqHandler_0232B01C + 1	; IRQ 11
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 12
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 13
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 14
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 15
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 16
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 17
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 18
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 19
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 20
	.word P1_IrqHandler_0232B0AC + 1	; IRQ 21
P1_IrqHandlersEnd:
P1_Data_023307C4:
	.byte 0xFF, 0xFF, 0xFF, 0xFF	; 023307C4
P1_Data_023307C8:
	.byte 0x01, 0x00, 0x00, 0x00	; 023307C8
P1_Data_023307CC:
	.byte 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023307CC
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 023307D8
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
	blx loc_0232B204	; 01FF8088
	lsl r0,r0,#0x10	; 01FF808C
	lsr r0,r0,#0x10	; 01FF808E
	str r0,[sp,#0x0]	; 01FF8090
	bl loc_0232B35C	; 01FF8092
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
	bl loc_0232B1F4	; 01FF810C
	ldr r0,[sp,#0x0]	; 01FF8110
	blx loc_0232B25C	; 01FF8112
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
	.byte 0x21, 0x06, 0xC0, 0xDE, 0xF4, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00	; 02330B38
.thumb
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
