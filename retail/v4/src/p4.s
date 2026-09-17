; official_v4_p4
; Readable armips reconstruction exported from Ghidra.
; Recognised code is assembly; data is retained only where Ghidra has no instruction.
.nds
.create "build/p4.bin", 0x02300200
.arm

; P4 的公共服务入口，转接到固定系统服务向量；各子服务 ABI 待逐项恢复。
; Public P4 service entry, forwarding to fixed system-service vectors; sub-service ABI remains to map.
.func P4_FirmwareServiceEntry
loc_02300200:
	stmdb sp!,{r4,lr}	; 02300200
	mov r0,#0x8	; 02300204
	bl P4_ForwardSystemServiceA	; 02300208
	mov r4,r0	; 0230020C
	mov r0,#0x8	; 02300210
	bl P4_ForwardSystemServiceB	; 02300214
	mov r1,r0	; 02300218
	mov r0,#0x8	; 0230021C
	mov r2,r4	; 02300220
	mov r3,#0x1	; 02300224
	bl P4_ForwardSystemServiceC	; 02300228
	mov r1,r0	; 0230022C
	mov r0,#0x8	; 02300230
	bl P4_ForwardSystemServiceD	; 02300234
	mov r0,#0x8	; 02300238
	bl P4_ForwardSystemServiceE	; 0230023C
	mov r4,r0	; 02300240
	mov r0,#0x8	; 02300244
	bl P4_ForwardSystemServiceF	; 02300248
	mov r1,r0	; 0230024C
	mov r0,#0x8	; 02300250
	mov r2,r4	; 02300254
	bl P4_ForwardSystemServiceG	; 02300258
	movs r4,r0	; 0230025C
	bpl loc_02300268	; 02300260
	bl P4_ForwardSystemServiceH	; 02300264
loc_02300268:
	mov r0,#0x8	; 02300268
	mov r1,r4	; 0230026C
	bl P4_ForwardSystemServiceI	; 02300270
	mov r0,r4	; 02300274
	ldmia sp!,{r4,lr}	; 02300278
	bx lr	; 0230027C
.endfunc

; ===== function loc_02300280 =====
; System-service vector forwarding stubs; target ABI is not yet recovered.
; 系统服务向量转发桩；目标 ABI 尚未恢复。
P4_ForwardSystemServiceA:
loc_02300280:
	ldr r12,[pool_02300288]	; 02300280
	bx r12	; 02300284
pool_02300288:
loc_02300288:
	.word P2_Entry_037FE55C + 1	; 02300288

; ===== function loc_0230028C =====
P4_ForwardSystemServiceB:
loc_0230028C:
	ldr r12,[pool_02300294]	; 0230028C
	bx r12	; 02300290
pool_02300294:
loc_02300294:
	.word P2_Entry_037FE550 + 1	; 02300294

; ===== function loc_02300298 =====
P4_ForwardSystemServiceC:
loc_02300298:
	ldr r12,[pool_023002A0]	; 02300298
	bx r12	; 0230029C
pool_023002A0:
loc_023002A0:
	.word P2_Entry_037FE62C + 1	; 023002A0

; ===== function loc_023002A4 =====
P4_ForwardSystemServiceD:
loc_023002A4:
	ldr r12,[pool_023002AC]	; 023002A4
	bx r12	; 023002A8
pool_023002AC:
loc_023002AC:
	.word loc_037FE4B0 + 1	; 023002AC

; ===== function loc_023002B0 =====
P4_ForwardSystemServiceE:
loc_023002B0:
	ldr r12,[pool_023002B8]	; 023002B0
	bx r12	; 023002B4
pool_023002B8:
loc_023002B8:
	.word P2_Entry_037FE55C + 1	; 023002B8

; ===== function loc_023002BC =====
P4_ForwardSystemServiceF:
loc_023002BC:
	ldr r12,[pool_023002C4]	; 023002BC
	bx r12	; 023002C0
pool_023002C4:
loc_023002C4:
	.word P2_Entry_037FE550 + 1	; 023002C4

; ===== function loc_023002C8 =====
P4_ForwardSystemServiceG:
loc_023002C8:
	ldr r12,[pool_023002D0]	; 023002C8
	bx r12	; 023002CC
pool_023002D0:
loc_023002D0:
	.word P2_Entry_037FE5B8 + 1	; 023002D0

; ===== function loc_023002D4 =====
P4_ForwardSystemServiceH:
loc_023002D4:
	ldr r12,[pool_023002DC]	; 023002D4
	bx r12	; 023002D8
pool_023002DC:
loc_023002DC:
	.word loc_037FF1D4 + 1	; 023002DC

; ===== function loc_023002E0 =====
P4_ForwardSystemServiceI:
loc_023002E0:
	ldr r12,[pool_023002E8]	; 023002E0
	bx r12	; 023002E4
pool_023002E8:
loc_023002E8:
	.word P2_Entry_037FE6A8 + 1	; 023002E8

; ===== function P4_InitializeRuntimeContext =====
; Clears P4 runtime storage, prepares its context, then activates the service.
; 清空 P4 运行时存储，准备上下文后启用该服务。
.func P4_InitializeRuntimeContext
loc_023002EC:
	stmdb sp!,{lr}	; 023002EC
	sub sp,sp,#0x44	; 023002F0
; 按此版本的零区起点和字节数清零，SWI 参数换算为 32 位字数。
; Clear this version's zero area; convert its byte size to the SWI word count.
	ldr r3,[pool_023003A8]	; 023002F4
	cmp r3,#0x0	; 023002F8
	beq loc_02300320	; 023002FC
	mov r0,#0x0	; 02300300
	str r0,[sp,#0x0]	; 02300304
	add r0,sp,#0x0	; 02300308
	ldr r1,[pool_023003AC]	; 0230030C
	ldr r2,[pool_023003B0]	; 02300310
	and r2,r2,r3, lsr #0x2	; 02300314
	orr r2,r2,#0x1000000	; 02300318
	bl P4_ForwardP2CpuFastSet	; 0230031C
loc_02300320:
	ldr r0,[pool_023003B4]	; 02300320
	str r0,[sp,#0x4]	; 02300324
	ldr r0,[pool_023003B8]	; 02300328
	str r0,[sp,#0x8]	; 0230032C
	mov r0,#0x600	; 02300330
	str r0,[sp,#0xc]	; 02300334
	mov r0,#0xa	; 02300338
	str r0,[sp,#0x10]	; 0230033C
	mov r0,#0x0	; 02300340
	str r0,[sp,#0x24]	; 02300344
	mov r0,#0x8	; 02300348
	str r0,[sp,#0x28]	; 0230034C
	bl loc_02300200	; 02300350
	str r0,[sp,#0x2c]	; 02300354
	ldr r0,[pool_023003BC]	; 02300358
	str r0,[sp,#0x30]	; 0230035C
	mov r0,#0x1c0	; 02300360
	str r0,[sp,#0x34]	; 02300364
	mov r0,#0x3	; 02300368
	str r0,[sp,#0x38]	; 0230036C
	mov r0,#0x40	; 02300370
	str r0,[sp,#0x20]	; 02300374
	mov r0,#0x9	; 02300378
	str r0,[sp,#0x3c]	; 0230037C
	mov r0,#0xb	; 02300380
	str r0,[sp,#0x40]	; 02300384
	add r0,sp,#0x4	; 02300388
	add r1,sp,#0x38	; 0230038C
	bl P4_ForwardServiceBackendInitializer	; 02300390
	mov r0,#0x40000000	; 02300394
	bl P4_ForwardP2OrSharedEventFlags	; 02300398
	add sp,sp,#0x44	; 0230039C
	ldmia sp!,{lr}	; 023003A0
	bx lr	; 023003A4
.endfunc
pool_023003A8:
loc_023003A8:
	.word P4_BssBytes	; 023003A8
pool_023003AC:
loc_023003AC:
	.word P4_BssStart	; 023003AC
pool_023003B0:
loc_023003B0:
	.word 0x001FFFFF	; 023003B0
pool_023003B4:
loc_023003B4:
	.word 0x0230E300	; 023003B4
pool_023003B8:
loc_023003B8:
	.word 0x0230E300	; 023003B8
pool_023003BC:
loc_023003BC:
	.word 0x0230DB40	; 023003BC

; Cross-component veneer for ARM7 BIOS CpuFastSet (Thumb target). / 面向 ARM7 BIOS CpuFastSet 的跨组件跳板（Thumb 目标）。
P4_ForwardP2CpuFastSet:
; ===== function loc_023003C0 =====
loc_023003C0:
	ldr r12,[pool_023003C8]	; 023003C0
	bx r12	; 023003C4
pool_023003C8:
loc_023003C8:
	.word P2_SwiCpuFastSet + 1	; 0x03804919

; ===== function loc_023003CC =====
; Forwards the prepared configuration to the P4 service backend initializer.
; 将准备好的配置转发给 P4 服务后端初始化器。
P4_ForwardServiceBackendInitializer:
loc_023003CC:
	ldr r12,[pool_023003D4]	; 023003CC
	bx r12	; 023003D0
pool_023003D4:
loc_023003D4:
	.word P4_InitializeServiceBackend + 1	; 023003D4

; ===== function loc_023003D8 =====
; Cross-component veneer for P2 shared-event notification.
; 面向 P2 共享事件通知的跨组件跳板。
P4_ForwardP2OrSharedEventFlags:
loc_023003D8:
	ldr r12,[pool_023003E0]	; 023003D8
	bx r12	; 023003DC
pool_023003E0:
loc_023003E0:
	.word P2_OrSharedEventFlags + 1	; 023003E0
.thumb

; Builds a four-halfword command record, then submits its acquired slot.
; 构造四个半字的命令记录，并提交取得的槽位。
.func P4_SendFourHalfwordCommand
	push {r4,r5,r6,lr}	; 023003E4
	add r5,r0,#0x0	; 023003E6
	add r4,r1,#0x0	; 023003E8
	add r6,r2,#0x0	; 023003EA
	bl P4_AcquireCommandSlot	; 023003EC
	strh r5,[r0,#0x0]	; 023003F0
	mov r1,#0x1	; 023003F2
	strh r1,[r0,#0x2]	; 023003F4
	strh r4,[r0,#0x4]	; 023003F6
	strh r6,[r0,#0x6]	; 023003F8
	bl P4_SubmitCommandSlot	; 023003FA
	pop {r4,r5,r6}	; 023003FE
	pop {r3}	; 02300400
	bx r3	; 02300402
.endfunc

; Acquires a writable command slot from the external service.
; 从外部服务取得可写的命令槽位。
.func P4_AcquireCommandSlot
	bx pc	; 02300404
	.byte 0xC0, 0x46	; 02300408
.arm

; ===== function loc_02300408 =====
loc_02300408:
	ldr r12,[pool_02300410]	; 02300408
	bx r12	; 0230040C
.endfunc
pool_02300410:
loc_02300410:
	.word P2_Runtime_037F80F0 + 1	; 02300410
.thumb

; Submits the current command slot to the external service.
; 将当前命令槽位提交给外部服务。
.func P4_SubmitCommandSlot
	bx pc	; 02300414
	.byte 0xC0, 0x46	; 02300418
.arm

; ===== function loc_02300418 =====
loc_02300418:
	ldr r12,[pool_02300420]	; 02300418
	bx r12	; 0230041C
.endfunc
pool_02300420:
loc_02300420:
	.word P2_Runtime_037F816C + 1	; 02300420
.thumb

; Maps an unsigned value to bands 0--3 at thresholds 8, 14 and 20.
; 将无符号值按 8、14、20 三个阈值映射到 0--3 档。
.func P4_QuantizeValueByThresholds8_14_20
loc_02300424:
	cmp r0,#0x8	; 02300424
	bcs loc_0230042C	; 02300426
	mov r0,#0x0	; 02300428
	bx lr	; 0230042A
loc_0230042C:
	cmp r0,#0xe	; 0230042C
	bcs loc_02300434	; 0230042E
	mov r0,#0x1	; 02300430
	bx lr	; 02300432
loc_02300434:
	cmp r0,#0x14	; 02300434
	bcs loc_0230043C	; 02300436
	mov r0,#0x2	; 02300438
	bx lr	; 0230043A
loc_0230043C:
	mov r0,#0x3	; 0230043C
	bx lr	; 0230043E
.endfunc

; ===== function P4_Classify16ByteWindowAverage =====
; Averages a fixed 16-byte window, then maps the average into one of four threshold bands.
; 对固定 16 字节窗口求平均值，再映射到四个阈值档位之一。
.func P4_Classify16ByteWindowAverage
loc_02300440:
	push {r4,lr}	; 02300440
	mov r3,#0x0	; 02300442
	add r4,r3,#0x0	; 02300444
	ldr r2,[pool_02300464]	; 02300446
	ldr r0,[pool_02300468]	; 02300448
loc_0230044A:
	add r1,r2,r4	; 0230044A
	ldrb r1,[r1,r0]	; 0230044C
	add r3,r3,r1	; 0230044E
	add r4,r4,#0x1	; 02300450
	cmp r4,#0x10	; 02300452
	blt loc_0230044A	; 02300454
	lsr r0,r3,#0x4	; 02300456
	bl P4_QuantizeValueByThresholds8_14_20	; 02300458
	pop {r4}	; 0230045C
	pop {r3}	; 0230045E
	bx r3	; 02300460
.endfunc
	.byte 0xC0, 0x46	; 02300464
pool_02300464:
loc_02300464:
	.word 0x0230EA00	; 02300464
pool_02300468:
loc_02300468:
	.word 0x0000151C	; 02300468

; ===== function P4_Clear16ByteInputWindow =====
; Clears the 16-byte input window and resets its write index.
; 清零 16 字节输入窗口，并重置其写入索引。
.func P4_Clear16ByteInputWindow
loc_0230046C:
	push {r4,lr}	; 0230046C
	mov r4,#0x0	; 0230046E
	ldr r3,[pool_0230048C]	; 02300470
	ldr r1,[pool_02300490]	; 02300472
loc_02300474:
	add r2,r3,r4	; 02300474
	strb r0,[r2,r1]	; 02300476
	add r4,r4,#0x1	; 02300478
	cmp r4,#0x10	; 0230047A
	blt loc_02300474	; 0230047C
	mov r1,#0x0	; 0230047E
	ldr r0,[pool_02300494]	; 02300480
	str r1,[r0,#0x2c]	; 02300482
	pop {r4}	; 02300484
	pop {r3}	; 02300486
	bx r3	; 02300488
.endfunc
	.byte 0xC0, 0x46	; 0230048C
pool_0230048C:
loc_0230048C:
	.word 0x0230EA00	; 0230048C
pool_02300490:
loc_02300490:
	.word 0x0000151C	; 02300490
pool_02300494:
loc_02300494:
	.word P4_BssStart + 0x23C0	; 02300494

; ===== function P4_PushByteToInputWindow =====
; Stores one byte at the current input-window index and advances it modulo 16.
; 将一个字节写入当前输入窗口索引，并按 16 取模推进索引。
.func P4_PushByteToInputWindow
loc_02300498:
	ldr r1,[pool_023004AC]	; 02300498
	ldr r3,[r1,#0x2c]	; 0230049A
	ldr r2,[pool_023004B0]	; 0230049C
	strb r0,[r2,r3]	; 0230049E
	ldr r0,[r1,#0x2c]	; 023004A0
	add r2,r0,#0x1	; 023004A2
	mov r0,#0xf	; 023004A4
	and r2,r0	; 023004A6
	str r2,[r1,#0x2c]	; 023004A8
	bx lr	; 023004AA
.endfunc
pool_023004AC:
loc_023004AC:
	.word P4_BssStart + 0x23C0	; 023004AC
pool_023004B0:
loc_023004B0:
	.word P4_BssStart + 0x23DC	; 023004B0

; Decodes one tagged packed byte: bit 1 selects one of two extraction forms.
; 解码一个带标记的压缩字节：位 1 选择两种提取形式之一。
.func P4_DecodeTaggedPackedByte
loc_023004B4:
	mov r1,#0x2	; 023004B4
	add r2,r0,#0x0	; 023004B6
	and r2,r1	; 023004B8
	cmp r2,#0x0	; 023004BA
	beq loc_023004C4	; 023004BC
	lsl r0,r0,#0x16	; 023004BE
	lsr r0,r0,#0x18	; 023004C0
	bx lr	; 023004C2
loc_023004C4:
	asr r0,r0,#0x2	; 023004C4
	add r0,#0x19	; 023004C6
	lsl r0,r0,#0x18	; 023004C8
	lsr r0,r0,#0x18	; 023004CA
	bx lr	; 023004CC
.endfunc
	.byte 0x00, 0x00	; 023004D0

; ===== function loc_023004D0 =====
loc_023004D0:
	push {r4,r5,r6,r7,lr}	; 023004D0
	sub sp,#0xc	; 023004D2
	ldr r1,[pool_02300594]	; 023004D4
	and r0,r1	; 023004D6
	lsl r0,r0,#0x10	; 023004D8
	lsr r0,r0,#0x10	; 023004DA
	str r0,[sp,#0x0]	; 023004DC
	cmp r0,#0x0	; 023004DE
	bne loc_023004E6	; 023004E0
	mov r0,#0x0	; 023004E2
	b loc_0230058C	; 023004E4
loc_023004E6:
	mov r4,#0x0	; 023004E6
	mov r0,#0x1	; 023004E8
	b loc_023004FA	; 023004EA
loc_023004EC:
	add r1,r0,#0x0	; 023004EC
	lsl r1,r4	; 023004EE
	ldr r2,[sp,#0x0]	; 023004F0
	and r2,r1	; 023004F2
	cmp r2,#0x0	; 023004F4
	bne loc_023004FE	; 023004F6
	add r4,r4,#0x1	; 023004F8
loc_023004FA:
	cmp r4,#0x10	; 023004FA
	blt loc_023004EC	; 023004FC
loc_023004FE:
	mov r5,#0xf	; 023004FE
	mov r0,#0x1	; 02300500
	b loc_02300512	; 02300502
loc_02300504:
	add r1,r0,#0x0	; 02300504
	lsl r1,r5	; 02300506
	ldr r2,[sp,#0x0]	; 02300508
	and r2,r1	; 0230050A
	cmp r2,#0x0	; 0230050C
	bne loc_02300516	; 0230050E
	sub r5,r5,#0x1	; 02300510
loc_02300512:
	cmp r5,#0x0	; 02300512
	bne loc_02300504	; 02300514
loc_02300516:
	sub r0,r5,r4	; 02300516
	str r0,[sp,#0x4]	; 02300518
	cmp r0,#0x5	; 0230051A
	bge loc_02300528	; 0230051C
	mov r0,#0x1	; 0230051E
	lsl r0,r4	; 02300520
	lsl r0,r0,#0x10	; 02300522
	lsr r0,r0,#0x10	; 02300524
	b loc_0230058C	; 02300526
loc_02300528:
	add r0,r5,r4	; 02300528
	mov r1,#0x2	; 0230052A
	bl loc_02300598	; 0230052C
	add r6,r0,#0x0	; 02300530
	mov r7,#0x0	; 02300532
	b loc_02300556	; 02300534
loc_02300536:
	add r0,r7,#0x0	; 02300536
	mov r1,#0x2	; 02300538
	bl loc_023005A4	; 0230053A
	lsl r0,r1,#0x1	; 0230053E
	sub r0,r0,#0x1	; 02300540
	add r1,r7,#0x0	; 02300542
	mul r1,r0	; 02300544
	add r6,r6,r1	; 02300546
	mov r0,#0x1	; 02300548
	lsl r0,r6	; 0230054A
	ldr r1,[sp,#0x0]	; 0230054C
	and r1,r0	; 0230054E
	cmp r1,#0x0	; 02300550
	bne loc_0230055C	; 02300552
	add r7,r7,#0x1	; 02300554
loc_02300556:
	ldr r0,[sp,#0x4]	; 02300556
	cmp r7,r0	; 02300558
	blt loc_02300536	; 0230055A
loc_0230055C:
	sub r0,r5,r6	; 0230055C
	cmp r0,#0x5	; 0230055E
	blt loc_02300568	; 02300560
	sub r0,r6,r4	; 02300562
	cmp r0,#0x5	; 02300564
	bge loc_02300578	; 02300566
loc_02300568:
	mov r0,#0x1	; 02300568
	add r1,r0,#0x0	; 0230056A
	lsl r1,r4	; 0230056C
	lsl r0,r5	; 0230056E
	orr r1,r0	; 02300570
	lsl r0,r1,#0x10	; 02300572
	lsr r0,r0,#0x10	; 02300574
	b loc_0230058C	; 02300576
loc_02300578:
	mov r1,#0x1	; 02300578
	add r2,r1,#0x0	; 0230057A
	lsl r2,r4	; 0230057C
	add r0,r1,#0x0	; 0230057E
	lsl r0,r5	; 02300580
	lsl r1,r6	; 02300582
	orr r0,r1	; 02300584
	orr r2,r0	; 02300586
	lsl r0,r2,#0x10	; 02300588
	lsr r0,r0,#0x10	; 0230058A
loc_0230058C:
	add sp,#0xc	; 0230058C
	pop {r4,r5,r6,r7}	; 0230058E
	pop {r3}	; 02300590
	bx r3	; 02300592
pool_02300594:
loc_02300594:
	.word 0x00001FFF	; 02300594

; ===== function loc_02300598 =====
loc_02300598:
	bx pc	; 02300598
	.byte 0xC0, 0x46	; 0230059C
.arm

; ===== function loc_0230059C =====
loc_0230059C:
	ldr pc,[pool_023005A0]	; 0230059C
pool_023005A0:
loc_023005A0:
	.word P2_SignedDivMod	; 0x03804BA4
.thumb

; ===== function loc_023005A4 =====
loc_023005A4:
	bx pc	; 023005A4
	.byte 0xC0, 0x46	; 023005A8
.arm

; ===== function loc_023005A8 =====
loc_023005A8:
	ldr pc,[pool_023005AC]	; 023005A8
pool_023005AC:
loc_023005AC:
	.word P2_SignedDivMod	; 0x03804BA4
.thumb

; ===== function loc_023005B0 =====
loc_023005B0:
	push {r4,r5,r6,lr}	; 023005B0
	sub sp,#0x8	; 023005B2
	add r6,r0,#0x0	; 023005B4
	add r5,r1,#0x0	; 023005B6
	bl P4_GetRuntimeState	; 023005B8
	ldr r1,[pool_023006C4]	; 023005BC
	ldr r4,[r0,r1]	; 023005BE
	add r0,r5,#0x0	; 023005C0
	add r0,#0x10	; 023005C2
	ldr r1,[r4,#0x0]	; 023005C4
	add r1,#0xe0	; 023005C6
	bl loc_02300800	; 023005C8
	mov r0,#0x7	; 023005CC
	strh r0,[r5,#0x16]	; 023005CE
	ldr r1,[r4,#0x0]	; 023005D0
	ldr r0,[pool_023006C8]	; 023005D2
	ldrh r0,[r1,r0]	; 023005D4
	strh r0,[r5,#0x18]	; 023005D6
	ldr r1,[r4,#0x0]	; 023005D8
	ldr r0,[pool_023006CC]	; 023005DA
	ldrh r0,[r1,r0]	; 023005DC
	strh r0,[r5,#0x1e]	; 023005DE
	ldr r0,[r4,#0x0]	; 023005E0
	add r0,#0xe6	; 023005E2
	ldrh r0,[r0,#0x0]	; 023005E4
	strh r0,[r5,#0x1c]	; 023005E6
	ldr r1,[r4,#0x0]	; 023005E8
	ldr r0,[pool_023006D0]	; 023005EA
	ldr r0,[r1,r0]	; 023005EC
	cmp r0,#0x0	; 023005EE
	bne loc_02300612	; 023005F0
	mov r1,#0x0	; 023005F2
	strh r1,[r5,#0x20]	; 023005F4
	strh r1,[r5,#0x22]	; 023005F6
	add r0,sp,#0x0	; 023005F8
	strh r1,[r0,#0x0]	; 023005FA
	ldrh r0,[r0,#0x0]	; 023005FC
	add r1,r5,#0x0	; 023005FE
	add r1,#0x24	; 02300600
	mov r2,#0x50	; 02300602
	bl loc_023006EC	; 02300604
	mov r1,#0x0	; 02300608
	add r0,r5,#0x0	; 0230060A
	add r0,#0x9e	; 0230060C
	strh r1,[r0,#0x0]	; 0230060E
	b loc_0230063E	; 02300610
loc_02300612:
	bl P4_GetRuntimeState	; 02300612
	ldr r1,[pool_023006D4]	; 02300616
	ldr r0,[r0,r1]	; 02300618
	ldr r2,[r4,#0x0]	; 0230061A
	ldr r1,[pool_023006D8]	; 0230061C
	ldrh r1,[r2,r1]	; 0230061E
	strh r1,[r5,#0x20]	; 02300620
	mov r1,#0x0	; 02300622
	strh r1,[r5,#0x22]	; 02300624
	ldr r2,[r4,#0x0]	; 02300626
	ldr r1,[pool_023006DC]	; 02300628
	add r1,r2,r1	; 0230062A
	add r2,r5,#0x0	; 0230062C
	add r2,#0x24	; 0230062E
	mov r3,#0x50	; 02300630
	bl loc_023006F8	; 02300632
	mov r1,#0x1	; 02300636
	add r0,r5,#0x0	; 02300638
	add r0,#0x9e	; 0230063A
	strh r1,[r0,#0x0]	; 0230063C
loc_0230063E:
	mov r1,#0x1	; 0230063E
	add r0,r5,#0x0	; 02300640
	add r0,#0x74	; 02300642
	strh r1,[r0,#0x0]	; 02300644
	add r0,r5,#0x0	; 02300646
	add r0,#0x76	; 02300648
	strh r1,[r0,#0x0]	; 0230064A
	ldr r0,[r4,#0x0]	; 0230064C
	add r0,#0xe6	; 0230064E
	ldrh r0,[r0,#0x0]	; 02300650
	cmp r0,#0x1	; 02300652
	bne loc_02300660	; 02300654
	mov r1,#0x0	; 02300656
	add r0,r5,#0x0	; 02300658
	add r0,#0x78	; 0230065A
	strh r1,[r0,#0x0]	; 0230065C
	b loc_02300668	; 0230065E
loc_02300660:
	mov r1,#0x10	; 02300660
	add r0,r5,#0x0	; 02300662
	add r0,#0x78	; 02300664
	strh r1,[r0,#0x0]	; 02300666
loc_02300668:
	mov r1,#0xa	; 02300668
	add r0,r5,#0x0	; 0230066A
	add r0,#0x7a	; 0230066C
	strh r1,[r0,#0x0]	; 0230066E
	mov r1,#0x0	; 02300670
	add r0,sp,#0x0	; 02300672
	strh r1,[r0,#0x2]	; 02300674
	ldrh r0,[r0,#0x2]	; 02300676
	add r1,r5,#0x0	; 02300678
	add r1,#0x7c	; 0230067A
	mov r2,#0x8	; 0230067C
	bl loc_02300708	; 0230067E
	ldr r1,[pool_023006E0]	; 02300682
	add r0,sp,#0x0	; 02300684
	strh r1,[r0,#0x4]	; 02300686
	ldrh r0,[r0,#0x4]	; 02300688
	add r1,r5,#0x0	; 0230068A
	add r1,#0x84	; 0230068C
	mov r2,#0x18	; 0230068E
	bl loc_02300714	; 02300690
	ldr r1,[r4,#0x0]	; 02300694
	ldr r0,[pool_023006E4]	; 02300696
	ldrh r1,[r1,r0]	; 02300698
	add r0,r5,#0x0	; 0230069A
	add r0,#0x9c	; 0230069C
	strh r1,[r0,#0x0]	; 0230069E
	add r0,r5,#0x0	; 023006A0
	bl loc_02301AAC	; 023006A2
	ldrh r2,[r0,#0x4]	; 023006A6
	cmp r2,#0x0	; 023006A8
	beq loc_023006B8	; 023006AA
	add r0,r6,#0x0	; 023006AC
	ldr r1,[pool_023006E8]	; 023006AE
	bl P4_SendFourHalfwordCommand	; 023006B0
	mov r0,#0x0	; 023006B4
	b loc_023006BA	; 023006B6
loc_023006B8:
	mov r0,#0x1	; 023006B8
loc_023006BA:
	add sp,#0x8	; 023006BA
	pop {r4,r5,r6}	; 023006BC
	pop {r3}	; 023006BE
	bx r3	; 023006C0
	.byte 0xC0, 0x46	; 023006C4
pool_023006C4:
loc_023006C4:
	.word 0x00001518	; 023006C4
pool_023006C8:
loc_023006C8:
	.word 0x000001F4	; 023006C8
pool_023006CC:
loc_023006CC:
	.word 0x000001EC	; 023006CC
pool_023006D0:
loc_023006D0:
	.word 0x00000198	; 023006D0
pool_023006D4:
loc_023006D4:
	.word 0x0000150C	; 023006D4
pool_023006D8:
loc_023006D8:
	.word 0x00000196	; 023006D8
pool_023006DC:
loc_023006DC:
	.word 0x0000019C	; 023006DC
pool_023006E0:
loc_023006E0:
	.word 0x0000FFFF	; 023006E0
pool_023006E4:
loc_023006E4:
	.word 0x000001EE	; 023006E4
pool_023006E8:
loc_023006E8:
	.word 0x00000200	; 023006E8

; ===== function loc_023006EC =====
loc_023006EC:
	bx pc	; 023006EC
	.byte 0xC0, 0x46	; 023006F0
.arm

; ===== function loc_023006F0 =====
loc_023006F0:
	ldr pc,[pool_023006F4]	; 023006F0
pool_023006F4:
loc_023006F4:
	.word loc_037FF31C	; 023006F4
.thumb

; ===== function loc_023006F8 =====
loc_023006F8:
	bx pc	; 023006F8
	.byte 0xC0, 0x46	; 023006FC
.arm

; ===== function loc_023006FC =====
loc_023006FC:
	ldr r12,[pool_02300704]	; 023006FC
	bx r12	; 02300700
pool_02300704:
loc_02300704:
	.word P2_Entry_037FF244 + 1	; 02300704
.thumb

; ===== function loc_02300708 =====
loc_02300708:
	bx pc	; 02300708
	.byte 0xC0, 0x46	; 0230070C
.arm

; ===== function loc_0230070C =====
loc_0230070C:
	ldr pc,[pool_02300710]	; 0230070C
pool_02300710:
loc_02300710:
	.word loc_037FF31C	; 02300710
.thumb

; ===== function loc_02300714 =====
loc_02300714:
	bx pc	; 02300714
	.byte 0xC0, 0x46	; 02300718
.arm

; ===== function loc_02300718 =====
loc_02300718:
	ldr pc,[pool_0230071C]	; 02300718
pool_0230071C:
loc_0230071C:
	.word loc_037FF31C	; 0230071C
.thumb

; Builds a compact record by copying selected source fields and packed flags.
; 复制选定的源字段和压缩标志，构造紧凑记录。
.func P4_BuildCompactRecordFromSource
loc_02300720:
	push {r4,r5,lr}	; 02300720
	sub sp,#0x4	; 02300722
	add r2,r0,#0x0	; 02300724
	ldrh r0,[r1,#0x6]	; 02300726
	strh r0,[r2,#0x4]	; 02300728
	ldrh r0,[r1,#0x8]	; 0230072A
	strh r0,[r2,#0x6]	; 0230072C
	ldrh r0,[r1,#0xa]	; 0230072E
	strh r0,[r2,#0x8]	; 02300730
	ldrh r0,[r1,#0x10]	; 02300732
	cmp r0,#0x0	; 02300734
	beq loc_0230073C	; 02300736
	mov r3,#0x2	; 02300738
	b loc_0230073E	; 0230073A
loc_0230073C:
	mov r3,#0x0	; 0230073C
loc_0230073E:
	ldrh r0,[r1,#0xc]	; 0230073E
	cmp r0,#0x0	; 02300740
	beq loc_02300748	; 02300742
	mov r4,#0x1	; 02300744
	b loc_0230074A	; 02300746
loc_02300748:
	mov r4,#0x0	; 02300748
loc_0230074A:
	ldrh r0,[r1,#0x12]	; 0230074A
	cmp r0,#0x0	; 0230074C
	beq loc_02300754	; 0230074E
	mov r5,#0x4	; 02300750
	b loc_02300756	; 02300752
loc_02300754:
	mov r5,#0x0	; 02300754
loc_02300756:
	ldrh r0,[r1,#0x14]	; 02300756
	cmp r0,#0x0	; 02300758
	beq loc_02300760	; 0230075A
	mov r0,#0x8	; 0230075C
	b loc_02300762	; 0230075E
loc_02300760:
	mov r0,#0x0	; 02300760
loc_02300762:
	orr r4,r3	; 02300762
	orr r5,r4	; 02300764
	orr r0,r5	; 02300766
	strb r0,[r2,#0xb]	; 02300768
	ldrh r0,[r1,#0x4]	; 0230076A
	strb r0,[r2,#0xa]	; 0230076C
	mov r4,#0x1	; 0230076E
	strh r4,[r2,#0x0]	; 02300770
	ldrh r0,[r1,#0x32]	; 02300772
	strh r0,[r2,#0xc]	; 02300774
	ldrh r0,[r1,#0x34]	; 02300776
	strh r0,[r2,#0xe]	; 02300778
	ldrb r3,[r2,#0xa]	; 0230077A
	cmp r3,#0x0	; 0230077C
	beq loc_02300790	; 0230077E
	ldr r0,[pool_02300798]	; 02300780
	ldr r0,[r0,#0xc]	; 02300782
	ldr r1,[r1,#0x0]	; 02300784
	add r2,#0x10	; 02300786
	add r3,r3,#0x1	; 02300788
	bic r3,r4	; 0230078A
	bl loc_023006F8	; 0230078C
loc_02300790:
	add sp,#0x4	; 02300790
	pop {r4,r5}	; 02300792
	pop {r3}	; 02300794
	bx r3	; 02300796
.endfunc
pool_02300798:
loc_02300798:
	.word P4_BssStart + 0x23C0	; 02300798

; Compares three caller halfwords with byte-swapped runtime-record halfwords.
; 将调用方的三个半字与运行时记录中的字节交换半字逐一比较。
.func P4_MatchesThreeByteSwappedRuntimeHalfwords
loc_0230079C:
	push {r4,r5,lr}	; 0230079C
	sub sp,#0x4	; 0230079E
	ldr r1,[pool_023007FC]	; 023007A0
	ldr r1,[r1,#0x18]	; 023007A2
	ldr r1,[r1,#0x0]	; 023007A4
	add r2,r1,#0x0	; 023007A6
	add r2,#0xe0	; 023007A8
	ldrh r2,[r2,#0x0]	; 023007AA
	ldrh r5,[r0,#0x0]	; 023007AC
	asr r4,r2,#0x8	; 023007AE
	mov r3,#0xff	; 023007B0
	and r2,r3	; 023007B2
	lsl r2,r2,#0x8	; 023007B4
	orr r4,r2	; 023007B6
	lsl r2,r4,#0x10	; 023007B8
	lsr r2,r2,#0x10	; 023007BA
	cmp r5,r2	; 023007BC
	bne loc_023007F2	; 023007BE
	add r2,r1,#0x0	; 023007C0
	add r2,#0xe2	; 023007C2
	ldrh r2,[r2,#0x0]	; 023007C4
	ldrh r5,[r0,#0x2]	; 023007C6
	asr r4,r2,#0x8	; 023007C8
	and r2,r3	; 023007CA
	lsl r2,r2,#0x8	; 023007CC
	orr r4,r2	; 023007CE
	lsl r2,r4,#0x10	; 023007D0
	lsr r2,r2,#0x10	; 023007D2
	cmp r5,r2	; 023007D4
	bne loc_023007F2	; 023007D6
	add r1,#0xe4	; 023007D8
	ldrh r4,[r1,#0x0]	; 023007DA
	ldrh r2,[r0,#0x4]	; 023007DC
	asr r1,r4,#0x8	; 023007DE
	and r4,r3	; 023007E0
	lsl r0,r4,#0x8	; 023007E2
	orr r1,r0	; 023007E4
	lsl r0,r1,#0x10	; 023007E6
	lsr r0,r0,#0x10	; 023007E8
	cmp r2,r0	; 023007EA
	bne loc_023007F2	; 023007EC
	mov r0,#0x1	; 023007EE
	b loc_023007F4	; 023007F0
loc_023007F2:
	mov r0,#0x0	; 023007F2
loc_023007F4:
	add sp,#0x4	; 023007F4
	pop {r4,r5}	; 023007F6
	pop {r3}	; 023007F8
	bx r3	; 023007FA
.endfunc
pool_023007FC:
loc_023007FC:
	.word P4_BssStart + 0x23C0	; 023007FC

; ===== function loc_02300800 =====
; Byte-swaps exactly three halfwords from source to destination.
; 将源中的恰好三个半字逐个交换字节序后写入目标。
.func P4_ByteSwapThreeHalfwords
loc_02300800:
	push {r4,r5,lr}	; 02300800
	sub sp,#0x4	; 02300802
	mov r5,#0x0	; 02300804
	mov r2,#0xff	; 02300806
loc_02300808:
	ldrh r3,[r1,#0x0]	; 02300808
	asr r4,r3,#0x8	; 0230080A
	and r3,r2	; 0230080C
	lsl r3,r3,#0x8	; 0230080E
	orr r4,r3	; 02300810
	strh r4,[r0,#0x0]	; 02300812
	add r0,r0,#0x2	; 02300814
	add r1,r1,#0x2	; 02300816
	add r5,r5,#0x1	; 02300818
	cmp r5,#0x3	; 0230081A
	blt loc_02300808	; 0230081C
	add sp,#0x4	; 0230081E
	pop {r4,r5}	; 02300820
	pop {r3}	; 02300822
	bx r3	; 02300824
.endfunc
	.byte 0x00, 0x00	; 02300828
P4_PxiCallback_02300828:
	push {r4,lr}	; 02300828
	add r4,r1,#0x0	; 0230082A
	cmp r2,#0x0	; 0230082C
	bne loc_0230085A	; 0230082E
	ldr r0,[pool_02300860]	; 02300830
	mov r2,#0x0	; 02300832
	bl loc_02300868	; 02300834
	cmp r0,#0x0	; 02300838
	bne loc_0230085A	; 0230083A
	ldr r0,[pool_02300864]	; 0230083C
	ldr r0,[r0,#0x18]	; 0230083E
	cmp r0,#0x0	; 02300840
	beq loc_0230085A	; 02300842
	bl P4_AcquireCommandSlot	; 02300844
	ldrh r1,[r4,#0x0]	; 02300848
	strh r1,[r0,#0x0]	; 0230084A
	mov r1,#0x8	; 0230084C
	strh r1,[r0,#0x2]	; 0230084E
	mov r1,#0x0	; 02300850
	strh r1,[r0,#0x4]	; 02300852
	strh r1,[r0,#0x6]	; 02300854
	bl P4_SubmitCommandSlot	; 02300856
loc_0230085A:
	pop {r4}	; 0230085A
	pop {r3}	; 0230085C
	bx r3	; 0230085E
pool_02300860:
loc_02300860:
	.word 0x0230EA64	; 02300860
pool_02300864:
loc_02300864:
	.word P4_BssStart + 0x23C0	; 02300864

; ===== function loc_02300868 =====
loc_02300868:
	bx pc	; 02300868
	.byte 0xC0, 0x46	; 0230086C
.arm

; ===== function loc_0230086C =====
loc_0230086C:
	ldr r12,[pool_02300874]	; 0230086C
	bx r12	; 02300870
pool_02300874:
loc_02300874:
	.word loc_037FE300 + 1	; 02300874
.thumb

; ===== function loc_02300878 =====
loc_02300878:
	push {lr}	; 02300878
	sub sp,#0x4	; 0230087A
	add r1,r0,#0x0	; 0230087C
	ldr r0,[pool_023008C0]	; 0230087E
	mov r2,#0x1	; 02300880
	bl loc_02300868	; 02300882
	ldr r0,[pool_023008C4]	; 02300886
	add r1,sp,#0x0	; 02300888
	mov r2,#0x1	; 0230088A
	bl loc_023008C8	; 0230088C
	ldr r1,[sp,#0x0]	; 02300890
	ldrh r0,[r1,#0xe]	; 02300892
	lsl r0,r0,#0x1	; 02300894
	add r0,r1,r0	; 02300896
	ldrh r0,[r0,#0x14]	; 02300898
	cmp r0,#0xe	; 0230089A
	bne loc_023008B6	; 0230089C
	bl P4_AcquireCommandSlot	; 0230089E
	mov r1,#0x80	; 023008A2
	strh r1,[r0,#0x0]	; 023008A4
	mov r1,#0x13	; 023008A6
	strh r1,[r0,#0x2]	; 023008A8
	bl P4_SubmitCommandSlot	; 023008AA
	bl loc_023008D8	; 023008AE
	bl loc_023008E8	; 023008B2
loc_023008B6:
	ldr r0,[sp,#0x0]	; 023008B6
	add sp,#0x4	; 023008B8
	pop {r3}	; 023008BA
	bx r3	; 023008BC
	.byte 0xC0, 0x46	; 023008C0
pool_023008C0:
loc_023008C0:
	.word 0x0230EA00	; 023008C0
pool_023008C4:
loc_023008C4:
	.word 0x0230EA40	; 023008C4

; ===== function loc_023008C8 =====
loc_023008C8:
	bx pc	; 023008C8
	.byte 0xC0, 0x46	; 023008CC
.arm

; ===== function loc_023008CC =====
loc_023008CC:
	ldr r12,[pool_023008D4]	; 023008CC
	bx r12	; 023008D0
pool_023008D4:
loc_023008D4:
	.word loc_037FE288 + 1	; 023008D4
.thumb

; ===== function loc_023008D8 =====
loc_023008D8:
	bx pc	; 023008D8
	.byte 0xC0, 0x46	; 023008DC
.arm

; ===== function loc_023008DC =====
loc_023008DC:
	ldr r12,[pool_023008E4]	; 023008DC
	bx r12	; 023008E0
pool_023008E4:
loc_023008E4:
	.word P2_Entry_037FF478 + 1	; 023008E4
.thumb

; ===== function loc_023008E8 =====
loc_023008E8:
	bx pc	; 023008E8
	.byte 0xC0, 0x46	; 023008EC
.arm

; ===== function loc_023008EC =====
loc_023008EC:
	ldr r12,[pool_023008F4]	; 023008EC
	bx r12	; 023008F0
pool_023008F4:
loc_023008F4:
	.word loc_037FF1D4 + 1	; 023008F4
.thumb

; Returns the base address of P4's persistent runtime state.
; 返回 P4 常驻运行时状态的基址。
.func P4_GetRuntimeState
	ldr r0,[pool_023008FC]	; 023008F8
	bx lr	; 023008FA
pool_023008FC:
loc_023008FC:
	.word 0x0230EA00	; 023008FC
.endfunc

; ===== function loc_02300900 =====
; Initializes the service backend from the prepared runtime configuration.
; 根据准备好的运行时配置初始化服务后端。
P4_InitializeServiceBackend:
loc_02300900:
	push {r4,r5,lr}	; 02300900
	sub sp,#0xc	; 02300902
	add r5,r0,#0x0	; 02300904
	add r4,r1,#0x0	; 02300906
	ldr r1,[r4,#0x0]	; 02300908
	ldr r0,[pool_023009B8]	; 0230090A
	str r1,[r0,#0xc]	; 0230090C
	ldr r1,[r5,#0x24]	; 0230090E
	str r1,[r0,#0x10]	; 02300910
	ldr r1,[r5,#0x28]	; 02300912
	str r1,[r0,#0x14]	; 02300914
	mov r1,#0x0	; 02300916
	str r1,[r0,#0x18]	; 02300918
	ldr r0,[pool_023009BC]	; 0230091A
	ldr r1,[pool_023009C0]	; 0230091C
	mov r2,#0x2	; 0230091E
	bl loc_02300A04	; 02300920
	ldr r0,[pool_023009C4]	; 02300924
	ldr r1,[pool_023009C8]	; 02300926
	mov r2,#0x4	; 02300928
	bl loc_02300A04	; 0230092A
	ldr r0,[pool_023009CC]	; 0230092E
	ldr r1,[pool_023009D0]	; 02300930
	mov r2,#0x4	; 02300932
	bl loc_02300A04	; 02300934
	ldr r0,[pool_023009D4]	; 02300938
	ldr r1,[pool_023009D8]	; 0230093A
	mov r2,#0x20	; 0230093C
	bl loc_02300A04	; 0230093E
	ldr r0,[pool_023009BC]	; 02300942
	str r0,[r5,#0x10]	; 02300944
	ldr r0,[pool_023009C4]	; 02300946
	str r0,[r5,#0x14]	; 02300948
	ldr r0,[pool_023009DC]	; 0230094A
	bl loc_02300A14	; 0230094C
	ldr r0,[pool_023009E0]	; 02300950
	str r0,[sp,#0x0]	; 02300952
	ldr r0,[r4,#0x4]	; 02300954
	str r0,[sp,#0x4]	; 02300956
	ldr r0,[pool_023009E4]	; 02300958
	ldr r1,[pool_023009E8]	; 0230095A
	mov r2,#0x0	; 0230095C
	ldr r3,[pool_023009DC]	; 0230095E
	bl loc_02300A24	; 02300960
	ldr r0,[pool_023009E4]	; 02300964
	bl loc_02300A34	; 02300966
	ldr r0,[pool_023009EC]	; 0230096A
	str r0,[sp,#0x0]	; 0230096C
	ldr r0,[r4,#0x8]	; 0230096E
	str r0,[sp,#0x4]	; 02300970
	ldr r0,[pool_023009F0]	; 02300972
	ldr r1,[pool_023009F4]	; 02300974
	mov r2,#0x0	; 02300976
	ldr r3,[pool_023009F8]	; 02300978
	bl loc_02300A24	; 0230097A
	ldr r0,[pool_023009F0]	; 0230097E
	bl loc_02300A34	; 02300980
	mov r4,#0x0	; 02300984
	add r3,r4,#0x0	; 02300986
	ldr r2,[pool_023009BC]	; 02300988
	ldr r0,[pool_023009FC]	; 0230098A
loc_0230098C:
	add r1,r2,r4	; 0230098C
	strb r3,[r1,r0]	; 0230098E
	add r4,r4,#0x1	; 02300990
	cmp r4,#0x10	; 02300992
	blt loc_0230098C	; 02300994
	ldr r0,[pool_023009B8]	; 02300996
	str r3,[r0,#0x2c]	; 02300998
	bl loc_02300A44	; 0230099A
	mov r0,#0xa	; 0230099E
	ldr r1,[pool_02300A00]	; 023009A0
	bl loc_02300A54	; 023009A2
	mov r0,#0x2	; 023009A6
	str r0,[r5,#0x18]	; 023009A8
	add r0,r5,#0x0	; 023009AA
	bl loc_023049A4	; 023009AC
	add sp,#0xc	; 023009B0
	pop {r4,r5}	; 023009B2
	pop {r3}	; 023009B4
	bx r3	; 023009B6
pool_023009B8:
loc_023009B8:
	.word P4_BssStart + 0x23C0	; 023009B8
pool_023009BC:
loc_023009BC:
	.word 0x0230EA00	; 023009BC
pool_023009C0:
loc_023009C0:
	.word 0x0230EA14	; 023009C0
pool_023009C4:
loc_023009C4:
	.word 0x0230EA1C	; 023009C4
pool_023009C8:
loc_023009C8:
	.word 0x0230EA30	; 023009C8
pool_023009CC:
loc_023009CC:
	.word 0x0230EA40	; 023009CC
pool_023009D0:
loc_023009D0:
	.word 0x0230EA54	; 023009D0
pool_023009D4:
loc_023009D4:
	.word 0x0230EA64	; 023009D4
pool_023009D8:
loc_023009D8:
	.word 0x0230EA78	; 023009D8
pool_023009DC:
loc_023009DC:
	.word 0x0230FEF8	; 023009DC
pool_023009E0:
loc_023009E0:
	.word 0x00000400	; 023009E0
pool_023009E4:
loc_023009E4:
	.word 0x037F8078	; 023009E4
pool_023009E8:
loc_023009E8:
	.word 0x02301795	; 023009E8
pool_023009EC:
loc_023009EC:
	.word 0x00001000	; 023009EC
pool_023009F0:
loc_023009F0:
	.word 0x037F8000	; 023009F0
pool_023009F4:
loc_023009F4:
	.word 0x023017F9	; 023009F4
pool_023009F8:
loc_023009F8:
	.word 0x0230FAF8	; 023009F8
pool_023009FC:
loc_023009FC:
	.word 0x0000151C	; 023009FC
pool_02300A00:
loc_02300A00:
	.word P4_PxiCallback_02300828 + 1	; 02300A00

; ===== function loc_02300A04 =====
loc_02300A04:
	bx pc	; 02300A04
	.byte 0xC0, 0x46	; 02300A08
.arm

; ===== function loc_02300A08 =====
loc_02300A08:
	ldr r12,[pool_02300A10]	; 02300A08
	bx r12	; 02300A0C
pool_02300A10:
loc_02300A10:
	.word loc_037FE35C + 1	; 02300A10
.thumb

; ===== function loc_02300A14 =====
loc_02300A14:
	bx pc	; 02300A14
	.byte 0xC0, 0x46	; 02300A18
.arm

; ===== function loc_02300A18 =====
loc_02300A18:
	ldr r12,[pool_02300A20]	; 02300A18
	bx r12	; 02300A1C
pool_02300A20:
loc_02300A20:
	.word P2_Entry_037FE478 + 1	; 02300A20
.thumb

; ===== function loc_02300A24 =====
loc_02300A24:
	bx pc	; 02300A24
	.byte 0xC0, 0x46	; 02300A28
.arm

; ===== function loc_02300A28 =====
loc_02300A28:
	ldr r12,[pool_02300A30]	; 02300A28
	bx r12	; 02300A2C
pool_02300A30:
loc_02300A30:
	.word loc_037FDFCC + 1	; 02300A30
.thumb

; ===== function loc_02300A34 =====
loc_02300A34:
	bx pc	; 02300A34
	.byte 0xC0, 0x46	; 02300A38
.arm

; ===== function loc_02300A38 =====
loc_02300A38:
	ldr r12,[pool_02300A40]	; 02300A38
	bx r12	; 02300A3C
pool_02300A40:
loc_02300A40:
	.word loc_037FDEE0 + 1	; 02300A40
.thumb

; ===== function loc_02300A44 =====
loc_02300A44:
	bx pc	; 02300A44
	.byte 0xC0, 0x46	; 02300A48
.arm

; ===== function loc_02300A48 =====
loc_02300A48:
	ldr r12,[pool_02300A50]	; 02300A48
	bx r12	; 02300A4C
pool_02300A50:
loc_02300A50:
	.word loc_03801E50 + 1	; 02300A50
.thumb

; ===== function loc_02300A54 =====
loc_02300A54:
	bx pc	; 02300A54
	.byte 0xC0, 0x46	; 02300A58
.arm

; ===== function loc_02300A58 =====
loc_02300A58:
	ldr r12,[pool_02300A60]	; 02300A58
	bx r12	; 02300A5C
pool_02300A60:
loc_02300A60:
	.word P2_SetPxiReceiveCallback + 1	; 02300A60
.thumb

; ===== function loc_02300A64 =====
loc_02300A64:
	push {lr}	; 02300A64
	sub sp,#0x4	; 02300A66
	bl P4_AcquireCommandSlot	; 02300A68
	mov r1,#0x80	; 02300A6C
	strh r1,[r0,#0x0]	; 02300A6E
	mov r1,#0x0	; 02300A70
	strh r1,[r0,#0x2]	; 02300A72
	mov r1,#0x13	; 02300A74
	strh r1,[r0,#0x4]	; 02300A76
	bl P4_SubmitCommandSlot	; 02300A78
	add sp,#0x4	; 02300A7C
	pop {r3}	; 02300A7E
	bx r3	; 02300A80
	.byte 0x00, 0x00	; 02300A84

; ===== function loc_02300A84 =====
loc_02300A84:
	push {r4,r5,r6,r7,lr}	; 02300A84
	sub sp,#0x14	; 02300A86
	add r4,r0,#0x0	; 02300A88
	bl P4_GetRuntimeState	; 02300A8A
	ldr r1,[pool_02300B74]	; 02300A8E
	ldr r0,[r0,r1]	; 02300A90
	ldr r5,[r0,#0x0]	; 02300A92
	ldrh r0,[r5,#0x0]	; 02300A94
	cmp r0,#0x7	; 02300A96
	beq loc_02300A9E	; 02300A98
	cmp r0,#0x9	; 02300A9A
	bne loc_02300B44	; 02300A9C
loc_02300A9E:
	add r0,sp,#0x8	; 02300A9E
	add r1,r4,#0x0	; 02300AA0
	add r1,#0x10	; 02300AA2
	bl loc_02300800	; 02300AA4
	mov r6,#0x0	; 02300AA8
	add r1,r6,#0x0	; 02300AAA
	add r2,sp,#0x8	; 02300AAC
	ldrh r7,[r2,#0x0]	; 02300AAE
	ldrh r0,[r2,#0x2]	; 02300AB0
	str r0,[sp,#0x4]	; 02300AB2
	ldrh r0,[r2,#0x4]	; 02300AB4
	str r0,[sp,#0x0]	; 02300AB6
	b loc_02300B10	; 02300AB8
loc_02300ABA:
	add r2,r1,#0x0	; 02300ABA
	mov r0,#0x6	; 02300ABC
	mul r2,r0	; 02300ABE
	add r0,r5,r2	; 02300AC0
	ldr r2,[pool_02300B78]	; 02300AC2
	ldrh r2,[r0,r2]	; 02300AC4
	cmp r7,r2	; 02300AC6
	bne loc_02300B0E	; 02300AC8
	ldr r2,[pool_02300B7C]	; 02300ACA
	ldrh r3,[r0,r2]	; 02300ACC
	ldr r2,[sp,#0x4]	; 02300ACE
	cmp r2,r3	; 02300AD0
	bne loc_02300B0E	; 02300AD2
	ldr r2,[pool_02300B80]	; 02300AD4
	ldrh r3,[r0,r2]	; 02300AD6
	ldr r2,[sp,#0x0]	; 02300AD8
	cmp r2,r3	; 02300ADA
	bne loc_02300B0E	; 02300ADC
	add r1,r1,#0x1	; 02300ADE
	lsl r1,r1,#0x10	; 02300AE0
	lsr r6,r1,#0x10	; 02300AE2
	mov r1,#0x1	; 02300AE4
	lsl r1,r6	; 02300AE6
	ldr r2,[pool_02300B84]	; 02300AE8
	add r2,r5,r2	; 02300AEA
	ldrh r3,[r2,#0x0]	; 02300AEC
	bic r3,r1	; 02300AEE
	strh r3,[r2,#0x0]	; 02300AF0
	add r2,r5,#0x0	; 02300AF2
	add r2,#0x8a	; 02300AF4
	ldrh r2,[r2,#0x0]	; 02300AF6
	bic r2,r1	; 02300AF8
	add r5,#0x8a	; 02300AFA
	strh r2,[r5,#0x0]	; 02300AFC
	mov r2,#0x0	; 02300AFE
	ldr r1,[pool_02300B78]	; 02300B00
	strh r2,[r0,r1]	; 02300B02
	ldr r1,[pool_02300B7C]	; 02300B04
	strh r2,[r0,r1]	; 02300B06
	ldr r1,[pool_02300B80]	; 02300B08
	strh r2,[r0,r1]	; 02300B0A
	b loc_02300B14	; 02300B0C
loc_02300B0E:
	add r1,r1,#0x1	; 02300B0E
loc_02300B10:
	cmp r1,#0xf	; 02300B10
	blt loc_02300ABA	; 02300B12
loc_02300B14:
	cmp r6,#0x0	; 02300B14
	beq loc_02300B6A	; 02300B16
	bl P4_AcquireCommandSlot	; 02300B18
	add r5,r0,#0x0	; 02300B1C
	mov r0,#0x8	; 02300B1E
	strh r0,[r5,#0x0]	; 02300B20
	mov r0,#0x0	; 02300B22
	strh r0,[r5,#0x2]	; 02300B24
	mov r0,#0x9	; 02300B26
	strh r0,[r5,#0x8]	; 02300B28
	ldrh r0,[r4,#0x16]	; 02300B2A
	strh r0,[r5,#0x12]	; 02300B2C
	strh r6,[r5,#0x10]	; 02300B2E
	add r0,r5,#0x0	; 02300B30
	add r0,#0xa	; 02300B32
	add r4,#0x10	; 02300B34
	add r1,r4,#0x0	; 02300B36
	bl loc_02300800	; 02300B38
	add r0,r5,#0x0	; 02300B3C
	bl P4_SubmitCommandSlot	; 02300B3E
	b loc_02300B6A	; 02300B42
loc_02300B44:
	bl P4_AcquireCommandSlot	; 02300B44
	mov r1,#0xc	; 02300B48
	strh r1,[r0,#0x0]	; 02300B4A
	mov r1,#0x0	; 02300B4C
	strh r1,[r0,#0x2]	; 02300B4E
	mov r2,#0x9	; 02300B50
	strh r2,[r0,#0x8]	; 02300B52
	ldrh r2,[r4,#0x16]	; 02300B54
	strh r2,[r0,#0xc]	; 02300B56
	ldr r2,[pool_02300B88]	; 02300B58
	ldrh r2,[r5,r2]	; 02300B5A
	strh r2,[r0,#0xa]	; 02300B5C
	ldr r2,[pool_02300B8C]	; 02300B5E
	strh r1,[r5,r2]	; 02300B60
	ldr r2,[pool_02300B90]	; 02300B62
	strh r1,[r5,r2]	; 02300B64
	bl P4_SubmitCommandSlot	; 02300B66
loc_02300B6A:
	add sp,#0x14	; 02300B6A
	pop {r4,r5,r6,r7}	; 02300B6C
	pop {r3}	; 02300B6E
	bx r3	; 02300B70
	.byte 0xC0, 0x46	; 02300B74
pool_02300B74:
loc_02300B74:
	.word 0x00001518	; 02300B74
pool_02300B78:
loc_02300B78:
	.word 0x00000128	; 02300B78
pool_02300B7C:
loc_02300B7C:
	.word 0x0000012A	; 02300B7C
pool_02300B80:
loc_02300B80:
	.word 0x0000012C	; 02300B80
pool_02300B84:
loc_02300B84:
	.word 0x00000182	; 02300B84
pool_02300B88:
loc_02300B88:
	.word 0x00000188	; 02300B88
pool_02300B8C:
loc_02300B8C:
	.word 0x00000192	; 02300B8C
pool_02300B90:
loc_02300B90:
	.word 0x00000194	; 02300B90

; ===== function loc_02300B94 =====
loc_02300B94:
	push {r4,r5,r6,lr}	; 02300B94
	sub sp,#0x8	; 02300B96
	add r6,r0,#0x0	; 02300B98
	bl P4_GetRuntimeState	; 02300B9A
	ldr r1,[pool_02300C6C]	; 02300B9E
	ldr r0,[r0,r1]	; 02300BA0
	ldr r4,[r0,#0x0]	; 02300BA2
	ldrh r5,[r6,#0x16]	; 02300BA4
	cmp r5,#0x0	; 02300BA6
	beq loc_02300C62	; 02300BA8
	cmp r5,#0x10	; 02300BAA
	bcs loc_02300C62	; 02300BAC
	add r0,r4,#0x0	; 02300BAE
	add r0,#0xf4	; 02300BB0
	ldrh r0,[r0,#0x0]	; 02300BB2
	cmp r0,#0x0	; 02300BB4
	bne loc_02300BF6	; 02300BB6
	mov r1,#0x22	; 02300BB8
	ldr r0,[pool_02300C70]	; 02300BBA
	str r1,[r0,#0x0]	; 02300BBC
	add r6,#0x10	; 02300BBE
	add r0,r6,#0x0	; 02300BC0
	ldr r1,[pool_02300C74]	; 02300BC2
	mov r2,#0x6	; 02300BC4
	bl loc_02300C84	; 02300BC6
	bl P4_GetRuntimeState	; 02300BCA
	add r0,#0x64	; 02300BCE
	ldr r1,[pool_02300C70]	; 02300BD0
	mov r2,#0x0	; 02300BD2
	bl loc_02300868	; 02300BD4
	cmp r0,#0x0	; 02300BD8
	bne loc_02300C62	; 02300BDA
	bl P4_AcquireCommandSlot	; 02300BDC
	mov r1,#0x80	; 02300BE0
	strh r1,[r0,#0x0]	; 02300BE2
	mov r1,#0x8	; 02300BE4
	strh r1,[r0,#0x2]	; 02300BE6
	mov r1,#0x16	; 02300BE8
	strh r1,[r0,#0x4]	; 02300BEA
	mov r1,#0x22	; 02300BEC
	strh r1,[r0,#0x6]	; 02300BEE
	bl P4_SubmitCommandSlot	; 02300BF0
	b loc_02300C62	; 02300BF4
loc_02300BF6:
	ldr r0,[pool_02300C78]	; 02300BF6
	add r2,r4,r0	; 02300BF8
	sub r1,r5,#0x1	; 02300BFA
	mov r0,#0x6	; 02300BFC
	mul r1,r0	; 02300BFE
	add r0,r2,r1	; 02300C00
	add r1,r6,#0x0	; 02300C02
	add r1,#0x10	; 02300C04
	bl loc_02300800	; 02300C06
	ldr r0,[pool_02300C7C]	; 02300C0A
	add r0,r4,r0	; 02300C0C
	ldrh r3,[r0,#0x0]	; 02300C0E
	mov r1,#0x1	; 02300C10
	add r2,r1,#0x0	; 02300C12
	lsl r2,r5	; 02300C14
	orr r3,r2	; 02300C16
	strh r3,[r0,#0x0]	; 02300C18
	add r0,sp,#0x0	; 02300C1A
	strh r1,[r0,#0x0]	; 02300C1C
	ldrh r0,[r0,#0x0]	; 02300C1E
	ldr r1,[pool_02300C80]	; 02300C20
	add r2,r4,r1	; 02300C22
	lsl r1,r5,#0x4	; 02300C24
	add r1,r2,r1	; 02300C26
	mov r2,#0x10	; 02300C28
	bl loc_02300C90	; 02300C2A
	bl P4_AcquireCommandSlot	; 02300C2E
	add r4,r0,#0x0	; 02300C32
	mov r0,#0x8	; 02300C34
	strh r0,[r4,#0x0]	; 02300C36
	mov r0,#0x0	; 02300C38
	strh r0,[r4,#0x2]	; 02300C3A
	mov r0,#0x7	; 02300C3C
	strh r0,[r4,#0x8]	; 02300C3E
	add r0,r4,#0x0	; 02300C40
	add r0,#0xa	; 02300C42
	add r1,r6,#0x0	; 02300C44
	add r1,#0x10	; 02300C46
	bl loc_02300800	; 02300C48
	strh r5,[r4,#0x10]	; 02300C4C
	add r6,#0x22	; 02300C4E
	add r0,r6,#0x0	; 02300C50
	add r1,r4,#0x0	; 02300C52
	add r1,#0x14	; 02300C54
	mov r2,#0x18	; 02300C56
	bl loc_02300C9C	; 02300C58
	add r0,r4,#0x0	; 02300C5C
	bl P4_SubmitCommandSlot	; 02300C5E
loc_02300C62:
	add sp,#0x8	; 02300C62
	pop {r4,r5,r6}	; 02300C64
	pop {r3}	; 02300C66
	bx r3	; 02300C68
	.byte 0xC0, 0x46	; 02300C6C
pool_02300C6C:
loc_02300C6C:
	.word 0x00001518	; 02300C6C
pool_02300C70:
loc_02300C70:
	.word P4_BssStart + 0x2414	; 02300C70
pool_02300C74:
loc_02300C74:
	.word 0x0230FF58	; 02300C74
pool_02300C78:
loc_02300C78:
	.word 0x00000128	; 02300C78
pool_02300C7C:
loc_02300C7C:
	.word 0x00000182	; 02300C7C
pool_02300C80:
loc_02300C80:
	.word 0x000001F8	; 02300C80

; ===== function loc_02300C84 =====
loc_02300C84:
	bx pc	; 02300C84
	.byte 0xC0, 0x46	; 02300C88
.arm

; ===== function loc_02300C88 =====
loc_02300C88:
	ldr pc,[pool_02300C8C]	; 02300C88
pool_02300C8C:
loc_02300C8C:
	.word P2_Entry_037FF334	; 02300C8C
.thumb

; ===== function loc_02300C90 =====
loc_02300C90:
	bx pc	; 02300C90
	.byte 0xC0, 0x46	; 02300C94
.arm

; ===== function loc_02300C94 =====
loc_02300C94:
	ldr pc,[pool_02300C98]	; 02300C94
pool_02300C98:
loc_02300C98:
	.word loc_037FF31C	; 02300C98
.thumb

; ===== function loc_02300C9C =====
loc_02300C9C:
	bx pc	; 02300C9C
	.byte 0xC0, 0x46	; 02300CA0
.arm

; ===== function loc_02300CA0 =====
loc_02300CA0:
	ldr pc,[pool_02300CA4]	; 02300CA0
pool_02300CA4:
loc_02300CA4:
	.word P2_Entry_037FF3E0	; 02300CA4
.thumb

; ===== function loc_02300CA8 =====
loc_02300CA8:
	push {lr}	; 02300CA8
	sub sp,#0x4	; 02300CAA
	bl P4_AcquireCommandSlot	; 02300CAC
	mov r1,#0x80	; 02300CB0
	strh r1,[r0,#0x0]	; 02300CB2
	mov r1,#0x0	; 02300CB4
	strh r1,[r0,#0x2]	; 02300CB6
	mov r1,#0x12	; 02300CB8
	strh r1,[r0,#0x4]	; 02300CBA
	bl P4_SubmitCommandSlot	; 02300CBC
	add sp,#0x4	; 02300CC0
	pop {r3}	; 02300CC2
	bx r3	; 02300CC4
	.byte 0x00, 0x00	; 02300CC8

; ===== function loc_02300CC8 =====
loc_02300CC8:
	push {lr}	; 02300CC8
	sub sp,#0x4	; 02300CCA
	bl P4_AcquireCommandSlot	; 02300CCC
	mov r1,#0x80	; 02300CD0
	strh r1,[r0,#0x0]	; 02300CD2
	mov r1,#0x0	; 02300CD4
	strh r1,[r0,#0x2]	; 02300CD6
	mov r1,#0x11	; 02300CD8
	strh r1,[r0,#0x4]	; 02300CDA
	bl P4_SubmitCommandSlot	; 02300CDC
	add sp,#0x4	; 02300CE0
	pop {r3}	; 02300CE2
	bx r3	; 02300CE4
	.byte 0x00, 0x00	; 02300CE8

; ===== function loc_02300CE8 =====
loc_02300CE8:
	push {lr}	; 02300CE8
	sub sp,#0x4	; 02300CEA
	bl P4_GetRuntimeState	; 02300CEC
	ldr r1,[pool_02300D58]	; 02300CF0
	ldr r2,[r0,r1]	; 02300CF2
	ldr r0,[r2,#0x0]	; 02300CF4
	add r0,#0xde	; 02300CF6
	ldrh r0,[r0,#0x0]	; 02300CF8
	cmp r0,#0x1	; 02300CFA
	beq loc_02300D50	; 02300CFC
	mov r1,#0x24	; 02300CFE
	ldr r0,[pool_02300D5C]	; 02300D00
	str r1,[r0,#0x0]	; 02300D02
	ldr r0,[r2,#0x0]	; 02300D04
	ldrh r0,[r0,#0x0]	; 02300D06
	cmp r0,#0x9	; 02300D08
	beq loc_02300D10	; 02300D0A
	cmp r0,#0x7	; 02300D0C
	bne loc_02300D18	; 02300D0E
loc_02300D10:
	ldr r1,[pool_02300D60]	; 02300D10
	ldr r0,[pool_02300D5C]	; 02300D12
	str r1,[r0,#0x4]	; 02300D14
	b loc_02300D26	; 02300D16
loc_02300D18:
	cmp r0,#0xa	; 02300D18
	beq loc_02300D20	; 02300D1A
	cmp r0,#0x8	; 02300D1C
	bne loc_02300D26	; 02300D1E
loc_02300D20:
	mov r1,#0x1	; 02300D20
	ldr r0,[pool_02300D5C]	; 02300D22
	str r1,[r0,#0x4]	; 02300D24
loc_02300D26:
	bl P4_GetRuntimeState	; 02300D26
	add r0,#0x64	; 02300D2A
	ldr r1,[pool_02300D5C]	; 02300D2C
	mov r2,#0x0	; 02300D2E
	bl loc_02300868	; 02300D30
	cmp r0,#0x0	; 02300D34
	bne loc_02300D50	; 02300D36
	bl P4_AcquireCommandSlot	; 02300D38
	mov r1,#0x80	; 02300D3C
	strh r1,[r0,#0x0]	; 02300D3E
	mov r1,#0x8	; 02300D40
	strh r1,[r0,#0x2]	; 02300D42
	mov r1,#0x16	; 02300D44
	strh r1,[r0,#0x4]	; 02300D46
	mov r1,#0x24	; 02300D48
	strh r1,[r0,#0x6]	; 02300D4A
	bl P4_SubmitCommandSlot	; 02300D4C
loc_02300D50:
	add sp,#0x4	; 02300D50
	pop {r3}	; 02300D52
	bx r3	; 02300D54
	.byte 0xC0, 0x46	; 02300D58
pool_02300D58:
loc_02300D58:
	.word 0x00001518	; 02300D58
pool_02300D5C:
loc_02300D5C:
	.word P4_BssStart + 0x240C	; 02300D5C
pool_02300D60:
loc_02300D60:
	.word 0x00007FFE	; 02300D60

; ===== function loc_02300D64 =====
loc_02300D64:
	push {r4,r5,r6,lr}	; 02300D64
	add r4,r0,#0x0	; 02300D66
	bl P4_GetRuntimeState	; 02300D68
	ldr r1,[pool_02300E04]	; 02300D6C
	ldr r0,[r0,r1]	; 02300D6E
	ldr r5,[r0,#0x0]	; 02300D70
	bl P4_GetRuntimeState	; 02300D72
	ldrb r0,[r4,#0x1f]	; 02300D76
	bl loc_023004B4	; 02300D78
	bl P4_PushByteToInputWindow	; 02300D7C
	bl P4_Classify16ByteWindowAverage	; 02300D80
	add r1,r5,#0x0	; 02300D84
	add r1,#0xbc	; 02300D86
	strh r0,[r1,#0x0]	; 02300D88
	add r4,#0x10	; 02300D8A
	add r0,r4,#0x0	; 02300D8C
	add r0,#0x1e	; 02300D8E
	bl loc_0230079C	; 02300D90
	cmp r0,#0x1	; 02300D94
	beq loc_02300DFC	; 02300D96
	add r0,r5,#0x0	; 02300D98
	add r0,#0xae	; 02300D9A
	ldrh r1,[r0,#0x0]	; 02300D9C
	mov r0,#0x1	; 02300D9E
	eor r1,r0	; 02300DA0
	add r0,r5,#0x0	; 02300DA2
	add r0,#0xae	; 02300DA4
	strh r1,[r0,#0x0]	; 02300DA6
	add r0,r5,#0x0	; 02300DA8
	add r0,#0xae	; 02300DAA
	ldrh r0,[r0,#0x0]	; 02300DAC
	lsl r0,r0,#0x2	; 02300DAE
	add r0,r5,r0	; 02300DB0
	add r0,#0xb0	; 02300DB2
	ldr r5,[r0,#0x0]	; 02300DB4
	bl P4_GetRuntimeState	; 02300DB6
	ldr r1,[pool_02300E08]	; 02300DBA
	ldr r0,[r0,r1]	; 02300DBC
	add r1,r4,#0x0	; 02300DBE
	add r2,r5,#0x0	; 02300DC0
	ldrh r3,[r4,#0x6]	; 02300DC2
	add r3,#0x2d	; 02300DC4
	mov r6,#0x1	; 02300DC6
	bic r3,r6	; 02300DC8
	bl loc_023006F8	; 02300DCA
	add r0,r5,#0x0	; 02300DCE
	add r0,#0x18	; 02300DD0
	add r1,r4,#0x0	; 02300DD2
	add r1,#0x18	; 02300DD4
	bl loc_02300800	; 02300DD6
	add r0,r5,#0x0	; 02300DDA
	add r0,#0x1e	; 02300DDC
	add r4,#0x1e	; 02300DDE
	add r1,r4,#0x0	; 02300DE0
	bl loc_02300800	; 02300DE2
	bl P4_AcquireCommandSlot	; 02300DE6
	mov r1,#0x11	; 02300DEA
	strh r1,[r0,#0x0]	; 02300DEC
	mov r1,#0x0	; 02300DEE
	strh r1,[r0,#0x2]	; 02300DF0
	mov r1,#0xf	; 02300DF2
	strh r1,[r0,#0x4]	; 02300DF4
	str r5,[r0,#0x8]	; 02300DF6
	bl P4_SubmitCommandSlot	; 02300DF8
loc_02300DFC:
	pop {r4,r5,r6}	; 02300DFC
	pop {r3}	; 02300DFE
	bx r3	; 02300E00
	.byte 0xC0, 0x46	; 02300E04
pool_02300E04:
loc_02300E04:
	.word 0x00001518	; 02300E04
pool_02300E08:
loc_02300E08:
	.word 0x0000150C	; 02300E08

; ===== function loc_02300E0C =====
loc_02300E0C:
	push {r4,r5,r6,r7,lr}	; 02300E0C
	sub sp,#0xc	; 02300E0E
	add r5,r0,#0x0	; 02300E10
	add r6,r5,#0x0	; 02300E12
	add r6,#0x10	; 02300E14
	bl P4_GetRuntimeState	; 02300E16
	ldr r1,[pool_02300FCC]	; 02300E1A
	ldr r0,[r0,r1]	; 02300E1C
	ldr r4,[r0,#0x0]	; 02300E1E
	mov r0,#0x0	; 02300E20
	str r0,[sp,#0x0]	; 02300E22
	ldr r0,[r4,#0x10]	; 02300E24
	cmp r0,#0x0	; 02300E26
	bne loc_02300E2C	; 02300E28
	b loc_02300FC2	; 02300E2A
loc_02300E2C:
	ldrh r0,[r5,#0xe]	; 02300E2C
	cmp r0,#0x0	; 02300E2E
	bne loc_02300E60	; 02300E30
	mov r7,#0x1	; 02300E32
	ldr r1,[pool_02300FD0]	; 02300E34
	ldrh r3,[r1,#0x0]	; 02300E36
	ldr r2,[pool_02300FD4]	; 02300E38
	ldrh r0,[r2,#0x0]	; 02300E3A
	ldrh r1,[r1,#0x0]	; 02300E3C
	cmp r3,r1	; 02300E3E
	bls loc_02300E44	; 02300E40
	ldrh r0,[r2,#0x0]	; 02300E42
loc_02300E44:
	lsl r2,r0,#0xc	; 02300E44
	asr r0,r1,#0x4	; 02300E46
	orr r2,r0	; 02300E48
	lsl r0,r2,#0x10	; 02300E4A
	lsr r1,r0,#0x10	; 02300E4C
	add r0,r4,#0x0	; 02300E4E
	add r0,#0x5a	; 02300E50
	ldrh r0,[r0,#0x0]	; 02300E52
	sub r0,r1,r0	; 02300E54
	lsl r0,r0,#0x10	; 02300E56
	asr r0,r0,#0x10	; 02300E58
	cmp r0,#0x0	; 02300E5A
	bgt loc_02300E62	; 02300E5C
	b loc_02300FC2	; 02300E5E
loc_02300E60:
	ldr r7,[sp,#0x0]	; 02300E60
loc_02300E62:
	bl loc_02300FE0	; 02300E62
	add r5,r0,#0x0	; 02300E66
	add r1,r4,#0x0	; 02300E68
	add r1,#0x88	; 02300E6A
	ldrh r1,[r1,#0x0]	; 02300E6C
	cmp r1,#0x0	; 02300E6E
	bne loc_02300E78	; 02300E70
	bl loc_02300FEC	; 02300E72
	b loc_02300FC2	; 02300E76
loc_02300E78:
	mov r1,#0x0	; 02300E78
	add r0,r4,#0x0	; 02300E7A
	add r0,#0x88	; 02300E7C
	strh r1,[r0,#0x0]	; 02300E7E
	add r0,r4,#0x0	; 02300E80
	add r0,#0x94	; 02300E82
	ldrh r0,[r0,#0x0]	; 02300E84
	str r0,[sp,#0x4]	; 02300E86
	add r0,r4,#0x0	; 02300E88
	add r0,#0x5c	; 02300E8A
	bl loc_02300FF8	; 02300E8C
	add r0,r5,#0x0	; 02300E90
	bl loc_02301008	; 02300E92
	mov r3,#0x1	; 02300E96
	add r0,r4,#0x0	; 02300E98
	add r0,#0x90	; 02300E9A
	ldrh r2,[r0,#0x0]	; 02300E9C
	cmp r2,#0x0	; 02300E9E
	beq loc_02300EB8	; 02300EA0
	cmp r7,#0x0	; 02300EA2
	bne loc_02300EB6	; 02300EA4
	ldrh r1,[r6,#0x2e]	; 02300EA6
	ldr r0,[pool_02300FD8]	; 02300EA8
	ldrh r0,[r4,r0]	; 02300EAA
	add r5,r3,#0x0	; 02300EAC
	lsl r5,r0	; 02300EAE
	and r1,r5	; 02300EB0
	cmp r1,#0x0	; 02300EB2
	bne loc_02300EB8	; 02300EB4
loc_02300EB6:
	mov r3,#0x0	; 02300EB6
loc_02300EB8:
	cmp r2,#0x0	; 02300EB8
	beq loc_02300EC4	; 02300EBA
	mov r1,#0x0	; 02300EBC
	add r0,r4,#0x0	; 02300EBE
	add r0,#0x90	; 02300EC0
	strh r1,[r0,#0x0]	; 02300EC2
loc_02300EC4:
	add r0,r4,#0x0	; 02300EC4
	add r0,#0x92	; 02300EC6
	ldrh r0,[r0,#0x0]	; 02300EC8
	cmp r0,#0x0	; 02300ECA
	beq loc_02300EE8	; 02300ECC
	mov r1,#0x0	; 02300ECE
	add r0,r4,#0x0	; 02300ED0
	add r0,#0x92	; 02300ED2
	strh r1,[r0,#0x0]	; 02300ED4
	cmp r3,#0x0	; 02300ED6
	beq loc_02300EDC	; 02300ED8
	mov r1,#0x1	; 02300EDA
loc_02300EDC:
	add r0,r7,#0x0	; 02300EDC
	lsl r1,r1,#0x10	; 02300EDE
	lsr r1,r1,#0x10	; 02300EE0
	bl loc_02303B38	; 02300EE2
	str r0,[sp,#0x0]	; 02300EE6
loc_02300EE8:
	bl P4_AcquireCommandSlot	; 02300EE8
	add r5,r0,#0x0	; 02300EEC
	mov r0,#0xe	; 02300EEE
	strh r0,[r5,#0x0]	; 02300EF0
	ldr r0,[sp,#0x4]	; 02300EF2
	cmp r0,#0x0	; 02300EF4
	bne loc_02300EFE	; 02300EF6
	mov r0,#0xd	; 02300EF8
	strh r0,[r5,#0x2]	; 02300EFA
	b loc_02300F22	; 02300EFC
loc_02300EFE:
	cmp r7,#0x0	; 02300EFE
	beq loc_02300F08	; 02300F00
	mov r0,#0x9	; 02300F02
	strh r0,[r5,#0x2]	; 02300F04
	b loc_02300F22	; 02300F06
loc_02300F08:
	ldrh r1,[r6,#0x2e]	; 02300F08
	mov r0,#0x1	; 02300F0A
	ldr r2,[pool_02300FD8]	; 02300F0C
	ldrh r2,[r4,r2]	; 02300F0E
	lsl r0,r2	; 02300F10
	and r1,r0	; 02300F12
	cmp r1,#0x0	; 02300F14
	beq loc_02300F1E	; 02300F16
	mov r0,#0xf	; 02300F18
	strh r0,[r5,#0x2]	; 02300F1A
	b loc_02300F22	; 02300F1C
loc_02300F1E:
	mov r0,#0x0	; 02300F1E
	strh r0,[r5,#0x2]	; 02300F20
loc_02300F22:
	mov r0,#0xd	; 02300F22
	strh r0,[r5,#0x4]	; 02300F24
	mov r0,#0x0	; 02300F26
	str r0,[r5,#0x8]	; 02300F28
	cmp r7,#0x0	; 02300F2A
	bne loc_02300F5A	; 02300F2C
	ldrh r0,[r6,#0xc]	; 02300F2E
	strh r0,[r5,#0xc]	; 02300F30
	ldrh r0,[r6,#0xe]	; 02300F32
	strh r0,[r5,#0xe]	; 02300F34
	add r0,r5,#0x0	; 02300F36
	add r0,#0x10	; 02300F38
	add r1,r6,#0x0	; 02300F3A
	add r1,#0x18	; 02300F3C
	bl loc_02300800	; 02300F3E
	add r0,r5,#0x0	; 02300F42
	add r0,#0x16	; 02300F44
	add r1,r6,#0x0	; 02300F46
	add r1,#0x1e	; 02300F48
	bl loc_02300800	; 02300F4A
	ldrh r0,[r6,#0x2a]	; 02300F4E
	strh r0,[r5,#0x1c]	; 02300F50
	ldrh r0,[r6,#0x2c]	; 02300F52
	strh r0,[r5,#0x1e]	; 02300F54
	ldrh r0,[r6,#0x2e]	; 02300F56
	strh r0,[r5,#0x20]	; 02300F58
loc_02300F5A:
	add r0,r5,#0x0	; 02300F5A
	bl P4_SubmitCommandSlot	; 02300F5C
	ldr r0,[sp,#0x4]	; 02300F60
	cmp r0,#0x0	; 02300F62
	beq loc_02300FC2	; 02300F64
	ldr r0,[sp,#0x0]	; 02300F66
	cmp r0,#0x1	; 02300F68
	beq loc_02300F72	; 02300F6A
	ldrh r0,[r4,#0x38]	; 02300F6C
	cmp r0,#0x0	; 02300F6E
	bne loc_02300FB6	; 02300F70
loc_02300F72:
	bl P4_GetRuntimeState	; 02300F72
	add r5,r0,#0x0	; 02300F76
	mov r0,#0x26	; 02300F78
	ldr r1,[pool_02300FDC]	; 02300F7A
	str r0,[r1,#0x0]	; 02300F7C
	mov r2,#0x0	; 02300F7E
	strh r2,[r4,#0x38]	; 02300F80
	strh r2,[r4,#0x3a]	; 02300F82
	add r4,#0x8c	; 02300F84
	strh r2,[r4,#0x0]	; 02300F86
	add r0,r5,#0x0	; 02300F88
	add r0,#0x64	; 02300F8A
	bl loc_02300868	; 02300F8C
	cmp r0,#0x0	; 02300F90
	bne loc_02300FC2	; 02300F92
	ldr r0,[pool_02300FCC]	; 02300F94
	ldr r0,[r5,r0]	; 02300F96
	cmp r0,#0x0	; 02300F98
	beq loc_02300FC2	; 02300F9A
	bl P4_AcquireCommandSlot	; 02300F9C
	mov r1,#0x80	; 02300FA0
	strh r1,[r0,#0x0]	; 02300FA2
	mov r1,#0x8	; 02300FA4
	strh r1,[r0,#0x2]	; 02300FA6
	mov r1,#0x16	; 02300FA8
	strh r1,[r0,#0x4]	; 02300FAA
	mov r1,#0x26	; 02300FAC
	strh r1,[r0,#0x6]	; 02300FAE
	bl P4_SubmitCommandSlot	; 02300FB0
	b loc_02300FC2	; 02300FB4
loc_02300FB6:
	mov r1,#0x0	; 02300FB6
	strh r1,[r4,#0x38]	; 02300FB8
	mov r0,#0x1	; 02300FBA
	strh r0,[r4,#0x3a]	; 02300FBC
	add r4,#0x8c	; 02300FBE
	strh r1,[r4,#0x0]	; 02300FC0
loc_02300FC2:
	add sp,#0xc	; 02300FC2
	pop {r4,r5,r6,r7}	; 02300FC4
	pop {r3}	; 02300FC6
	bx r3	; 02300FC8
	.byte 0xC0, 0x46	; 02300FCC
pool_02300FCC:
loc_02300FCC:
	.word 0x00001518	; 02300FCC
pool_02300FD0:
loc_02300FD0:
	.word REG_WIFI_US_COUNT0	; 02300FD0
pool_02300FD4:
loc_02300FD4:
	.word REG_WIFI_US_COUNT1	; 02300FD4
pool_02300FD8:
loc_02300FD8:
	.word 0x00000188	; 02300FD8
pool_02300FDC:
loc_02300FDC:
	.word P4_BssStart + 0x23F0	; 02300FDC

; ===== function loc_02300FE0 =====
loc_02300FE0:
	bx pc	; 02300FE0
	.byte 0xC0, 0x46	; 02300FE4
.arm

; ===== function loc_02300FE4 =====
loc_02300FE4:
	ldr pc,[pool_02300FE8]	; 02300FE4
pool_02300FE8:
loc_02300FE8:
	.word loc_037FF104	; 02300FE8
.thumb

; ===== function loc_02300FEC =====
loc_02300FEC:
	bx pc	; 02300FEC
	.byte 0xC0, 0x46	; 02300FF0
.arm

; ===== function loc_02300FF0 =====
loc_02300FF0:
	ldr pc,[pool_02300FF4]	; 02300FF0
pool_02300FF4:
loc_02300FF4:
	.word loc_037FF118	; 02300FF4
.thumb

; ===== function loc_02300FF8 =====
loc_02300FF8:
	bx pc	; 02300FF8
	.byte 0xC0, 0x46	; 02300FFC
.arm

; ===== function loc_02300FFC =====
loc_02300FFC:
	ldr r12,[pool_02301004]	; 02300FFC
	bx r12	; 02301000
pool_02301004:
loc_02301004:
	.word loc_037FEA5C + 1	; 02301004
.thumb

; ===== function loc_02301008 =====
loc_02301008:
	bx pc	; 02301008
	.byte 0xC0, 0x46	; 0230100C
.arm

; ===== function loc_0230100C =====
loc_0230100C:
	ldr pc,[pool_02301010]	; 0230100C
pool_02301010:
loc_02301010:
	.word loc_037FF118	; 02301010
.thumb
	push {r4,lr}	; 02301014
	bl P4_GetRuntimeState	; 02301016
	add r4,r0,#0x0	; 0230101A
	ldr r0,[pool_02301064]	; 0230101C
	ldr r0,[r4,r0]	; 0230101E
	ldr r1,[pool_02301068]	; 02301020
	ldr r1,[r4,r1]	; 02301022
	mov r2,#0x40	; 02301024
	bl loc_02301074	; 02301026
	add r1,r0,#0x0	; 0230102A
	ldr r0,[pool_0230106C]	; 0230102C
	strh r0,[r1,#0xc]	; 0230102E
	mov r2,#0x0	; 02301030
	strh r2,[r1,#0xe]	; 02301032
	add r0,r4,#0x0	; 02301034
	add r0,#0x1c	; 02301036
	bl loc_02300868	; 02301038
	cmp r0,#0x0	; 0230103C
	bne loc_0230105E	; 0230103E
	ldr r0,[pool_02301070]	; 02301040
	ldr r0,[r4,r0]	; 02301042
	cmp r0,#0x0	; 02301044
	beq loc_0230105E	; 02301046
	bl P4_AcquireCommandSlot	; 02301048
	mov r2,#0x80	; 0230104C
	strh r2,[r0,#0x0]	; 0230104E
	mov r1,#0x8	; 02301050
	strh r1,[r0,#0x2]	; 02301052
	mov r1,#0x16	; 02301054
	strh r1,[r0,#0x4]	; 02301056
	strh r2,[r0,#0x6]	; 02301058
	bl P4_SubmitCommandSlot	; 0230105A
loc_0230105E:
	pop {r4}	; 0230105E
	pop {r3}	; 02301060
	bx r3	; 02301062
pool_02301064:
loc_02301064:
	.word 0x00001510	; 02301064
pool_02301068:
loc_02301068:
	.word 0x00001514	; 02301068
pool_0230106C:
loc_0230106C:
	.word 0x00000185	; 0230106C
pool_02301070:
loc_02301070:
	.word 0x00001518	; 02301070

; ===== function loc_02301074 =====
loc_02301074:
	bx pc	; 02301074
	.byte 0xC0, 0x46	; 02301078
.arm

; ===== function loc_02301078 =====
loc_02301078:
	ldr r12,[pool_02301080]	; 02301078
	bx r12	; 0230107C
pool_02301080:
loc_02301080:
	.word loc_037FE71C + 1	; 02301080
.thumb

; ===== function loc_02301084 =====
loc_02301084:
	push {r4,r5,r6,r7,lr}	; 02301084
	sub sp,#0x14	; 02301086
	add r7,r0,#0x0	; 02301088
	bl P4_GetRuntimeState	; 0230108A
	ldr r1,[pool_0230128C]	; 0230108E
	ldr r0,[r0,r1]	; 02301090
	ldr r5,[r0,#0x0]	; 02301092
	ldrb r0,[r7,#0x1f]	; 02301094
	bl loc_023004B4	; 02301096
	bl P4_PushByteToInputWindow	; 0230109A
	bl P4_Classify16ByteWindowAverage	; 0230109E
	add r1,r5,#0x0	; 023010A2
	add r1,#0xbc	; 023010A4
	strh r0,[r1,#0x0]	; 023010A6
	ldr r0,[r5,#0x10]	; 023010A8
	cmp r0,#0x0	; 023010AA
	bne loc_023010B0	; 023010AC
	b loc_02301282	; 023010AE
loc_023010B0:
	ldrh r0,[r5,#0x3a]	; 023010B0
	cmp r0,#0x1	; 023010B2
	bne loc_023010BA	; 023010B4
	mov r0,#0x0	; 023010B6
	strh r0,[r5,#0x3a]	; 023010B8
loc_023010BA:
	add r0,r5,#0x0	; 023010BA
	add r0,#0x92	; 023010BC
	ldrh r0,[r0,#0x0]	; 023010BE
	str r0,[sp,#0xc]	; 023010C0
	add r0,r5,#0x0	; 023010C2
	add r0,#0x46	; 023010C4
	ldrh r1,[r0,#0x0]	; 023010C6
	mov r0,#0x1	; 023010C8
	eor r1,r0	; 023010CA
	add r0,r5,#0x0	; 023010CC
	add r0,#0x46	; 023010CE
	strh r1,[r0,#0x0]	; 023010D0
	add r0,r5,#0x0	; 023010D2
	add r0,#0x46	; 023010D4
	ldrh r0,[r0,#0x0]	; 023010D6
	lsl r0,r0,#0x2	; 023010D8
	add r0,r5,r0	; 023010DA
	ldr r4,[r0,#0x4c]	; 023010DC
	bl P4_GetRuntimeState	; 023010DE
	ldr r1,[pool_02301290]	; 023010E2
	ldr r0,[r0,r1]	; 023010E4
	add r1,r7,#0x0	; 023010E6
	add r1,#0x10	; 023010E8
	add r2,r4,#0x0	; 023010EA
	add r3,r5,#0x0	; 023010EC
	add r3,#0x4a	; 023010EE
	ldrh r3,[r3,#0x0]	; 023010F0
	bl loc_023006F8	; 023010F2
	bl loc_023012B0	; 023010F6
	str r0,[sp,#0x4]	; 023010FA
	mov r0,#0x0	; 023010FC
	str r0,[sp,#0x8]	; 023010FE
	add r0,r5,#0x0	; 02301100
	add r0,#0x88	; 02301102
	ldrh r0,[r0,#0x0]	; 02301104
	cmp r0,#0x1	; 02301106
	bne loc_02301116	; 02301108
	mov r0,#0x1	; 0230110A
	str r0,[sp,#0x8]	; 0230110C
	add r0,r5,#0x0	; 0230110E
	add r0,#0x5c	; 02301110
	bl loc_02300FF8	; 02301112
loc_02301116:
	mov r6,#0x1	; 02301116
	add r0,r5,#0x0	; 02301118
	add r0,#0x88	; 0230111A
	strh r6,[r0,#0x0]	; 0230111C
	ldrh r1,[r4,#0xa]	; 0230111E
	add r0,r5,#0x0	; 02301120
	add r0,#0x5a	; 02301122
	strh r1,[r0,#0x0]	; 02301124
	ldrh r0,[r4,#0x2e]	; 02301126
	ldr r1,[pool_02301294]	; 02301128
	ldrh r1,[r5,r1]	; 0230112A
	add r2,r6,#0x0	; 0230112C
	lsl r2,r1	; 0230112E
	and r0,r2	; 02301130
	cmp r0,#0x0	; 02301132
	bne loc_02301138	; 02301134
	mov r6,#0x0	; 02301136
loc_02301138:
	add r0,r5,#0x0	; 02301138
	add r0,#0x94	; 0230113A
	strh r6,[r0,#0x0]	; 0230113C
	ldrh r1,[r4,#0xa]	; 0230113E
	ldrh r0,[r4,#0xc]	; 02301140
	sub r0,r1,r0	; 02301142
	lsl r0,r0,#0x10	; 02301144
	lsr r0,r0,#0x10	; 02301146
	add r0,#0x60	; 02301148
	lsl r0,r0,#0x4	; 0230114A
	ldr r1,[pool_02301298]	; 0230114C
	mul r0,r1	; 0230114E
	mov r1,#0x40	; 02301150
	bl loc_023012BC	; 02301152
	ldr r1,[pool_0230129C]	; 02301156
	bl loc_023012C8	; 02301158
	add r1,r0,#0x0	; 0230115C
	mov r0,#0x0	; 0230115E
	str r0,[sp,#0x0]	; 02301160
	add r0,r5,#0x0	; 02301162
	add r0,#0x5c	; 02301164
	asr r2,r1,#0x1f	; 02301166
	ldr r3,[pool_023012A0]	; 02301168
	bl loc_023012D4	; 0230116A
	ldrh r0,[r7,#0x18]	; 0230116E
	ldr r1,[pool_023012A4]	; 02301170
	add r2,r0,#0x0	; 02301172
	and r2,r1	; 02301174
	cmp r2,r1	; 02301176
	bne loc_0230117E	; 02301178
	mov r1,#0x1	; 0230117A
	b loc_02301180	; 0230117C
loc_0230117E:
	mov r1,#0x0	; 0230117E
loc_02301180:
	ldr r2,[pool_023012A8]	; 02301180
	and r0,r2	; 02301182
	cmp r0,r2	; 02301184
	bne loc_0230118C	; 02301186
	mov r2,#0x1	; 02301188
	b loc_0230118E	; 0230118A
loc_0230118C:
	mov r2,#0x0	; 0230118C
loc_0230118E:
	cmp r1,#0x0	; 0230118E
	beq loc_0230119A	; 02301190
	mov r3,#0x0	; 02301192
	add r0,r5,#0x0	; 02301194
	add r0,#0x8e	; 02301196
	strh r3,[r0,#0x0]	; 02301198
loc_0230119A:
	cmp r1,#0x0	; 0230119A
	beq loc_023011A2	; 0230119C
	mov r1,#0x1	; 0230119E
	b loc_023011A4	; 023011A0
loc_023011A2:
	mov r1,#0x0	; 023011A2
loc_023011A4:
	add r0,r5,#0x0	; 023011A4
	add r0,#0x92	; 023011A6
	strh r1,[r0,#0x0]	; 023011A8
	cmp r2,#0x0	; 023011AA
	beq loc_023011B2	; 023011AC
	mov r1,#0x1	; 023011AE
	b loc_023011B4	; 023011B0
loc_023011B2:
	mov r1,#0x0	; 023011B2
loc_023011B4:
	add r0,r5,#0x0	; 023011B4
	add r0,#0x90	; 023011B6
	strh r1,[r0,#0x0]	; 023011B8
	ldr r0,[sp,#0x4]	; 023011BA
	bl loc_023012E4	; 023011BC
	ldr r0,[sp,#0x8]	; 023011C0
	cmp r0,#0x0	; 023011C2
	beq loc_023011EC	; 023011C4
	ldr r0,[sp,#0xc]	; 023011C6
	cmp r0,#0x1	; 023011C8
	bne loc_023011D4	; 023011CA
	ldr r0,[sp,#0x8]	; 023011CC
	mov r1,#0x0	; 023011CE
	bl loc_02303B38	; 023011D0
loc_023011D4:
	bl P4_AcquireCommandSlot	; 023011D4
	mov r1,#0xe	; 023011D8
	strh r1,[r0,#0x0]	; 023011DA
	mov r1,#0x9	; 023011DC
	strh r1,[r0,#0x2]	; 023011DE
	mov r1,#0xd	; 023011E0
	strh r1,[r0,#0x4]	; 023011E2
	mov r1,#0x0	; 023011E4
	str r1,[r0,#0x8]	; 023011E6
	bl P4_SubmitCommandSlot	; 023011E8
loc_023011EC:
	add r0,r4,#0x0	; 023011EC
	add r0,#0x18	; 023011EE
	add r1,r7,#0x0	; 023011F0
	add r1,#0x28	; 023011F2
	bl loc_02300800	; 023011F4
	add r0,r4,#0x0	; 023011F8
	add r0,#0x18	; 023011FA
	add r7,#0x2e	; 023011FC
	add r1,r7,#0x0	; 023011FE
	bl loc_02300800	; 02301200
	ldrh r0,[r4,#0x6]	; 02301204
	cmp r0,#0x2	; 02301206
	bcc loc_0230125A	; 02301208
	sub r0,r0,#0x2	; 0230120A
	strh r0,[r4,#0x6]	; 0230120C
	ldrh r1,[r4,#0x30]	; 0230120E
	ldr r0,[pool_023012AC]	; 02301210
	and r1,r0	; 02301212
	cmp r1,#0x0	; 02301214
	beq loc_0230121C	; 02301216
	mov r0,#0x1	; 02301218
	b loc_0230121E	; 0230121A
loc_0230121C:
	mov r0,#0x0	; 0230121C
loc_0230121E:
	strh r0,[r5,#0x38]	; 0230121E
	bl P4_AcquireCommandSlot	; 02301220
	mov r1,#0xe	; 02301224
	strh r1,[r0,#0x0]	; 02301226
	cmp r6,#0x0	; 02301228
	beq loc_02301232	; 0230122A
	mov r1,#0x0	; 0230122C
	strh r1,[r0,#0x2]	; 0230122E
	b loc_02301236	; 02301230
loc_02301232:
	mov r1,#0xd	; 02301232
	strh r1,[r0,#0x2]	; 02301234
loc_02301236:
	mov r1,#0xc	; 02301236
	strh r1,[r0,#0x4]	; 02301238
	str r4,[r0,#0x8]	; 0230123A
	bl P4_SubmitCommandSlot	; 0230123C
	ldrh r3,[r4,#0x6]	; 02301240
	cmp r3,#0x0	; 02301242
	beq loc_02301282	; 02301244
	str r4,[sp,#0x0]	; 02301246
	mov r0,#0x0	; 02301248
	ldrh r1,[r4,#0x30]	; 0230124A
	add r4,#0x32	; 0230124C
	add r2,r4,#0x0	; 0230124E
	bl loc_02303998	; 02301250
	bl loc_023012F0	; 02301254
	b loc_02301282	; 02301258
loc_0230125A:
	mov r0,#0x0	; 0230125A
	strh r0,[r4,#0x6]	; 0230125C
	strh r0,[r5,#0x38]	; 0230125E
	bl P4_AcquireCommandSlot	; 02301260
	mov r1,#0xe	; 02301264
	strh r1,[r0,#0x0]	; 02301266
	cmp r6,#0x0	; 02301268
	beq loc_02301270	; 0230126A
	strh r1,[r0,#0x2]	; 0230126C
	b loc_02301274	; 0230126E
loc_02301270:
	mov r1,#0xd	; 02301270
	strh r1,[r0,#0x2]	; 02301272
loc_02301274:
	mov r1,#0xc	; 02301274
	strh r1,[r0,#0x4]	; 02301276
	str r4,[r0,#0x8]	; 02301278
	bl P4_SubmitCommandSlot	; 0230127A
	bl loc_023012F0	; 0230127E
loc_02301282:
	add sp,#0x14	; 02301282
	pop {r4,r5,r6,r7}	; 02301284
	pop {r3}	; 02301286
	bx r3	; 02301288
	.byte 0xC0, 0x46	; 0230128C
pool_0230128C:
loc_0230128C:
	.word 0x00001518	; 0230128C
pool_02301290:
loc_02301290:
	.word 0x0000150C	; 02301290
pool_02301294:
loc_02301294:
	.word 0x00000188	; 02301294
pool_02301298:
loc_02301298:
	.word 0x000082EA	; 02301298
pool_0230129C:
loc_0230129C:
	.word 0x000003E8	; 0230129C
pool_023012A0:
loc_023012A0:
	.word 0x02301015	; 023012A0
pool_023012A4:
loc_023012A4:
	.word 0x00002800	; 023012A4
pool_023012A8:
loc_023012A8:
	.word 0x00006000	; 023012A8
pool_023012AC:
loc_023012AC:
	.word 0x00008000	; 023012AC

; ===== function loc_023012B0 =====
loc_023012B0:
	bx pc	; 023012B0
	.byte 0xC0, 0x46	; 023012B4
.arm

; ===== function loc_023012B4 =====
loc_023012B4:
	ldr pc,[pool_023012B8]	; 023012B4
pool_023012B8:
loc_023012B8:
	.word loc_037FF104	; 023012B8
.thumb

; ===== function loc_023012BC =====
loc_023012BC:
	bx pc	; 023012BC
	.byte 0xC0, 0x46	; 023012C0
.arm

; ===== function loc_023012C0 =====
loc_023012C0:
	ldr pc,[pool_023012C4]	; 023012C0
pool_023012C4:
loc_023012C4:
	.word P2_SignedDivMod	; 023012C4
.thumb

; ===== function loc_023012C8 =====
loc_023012C8:
	bx pc	; 023012C8
	.byte 0xC0, 0x46	; 023012CC
.arm

; ===== function loc_023012CC =====
loc_023012CC:
	ldr pc,[pool_023012D0]	; 023012CC
pool_023012D0:
loc_023012D0:
	.word P2_SignedDivMod	; 023012D0
.thumb

; ===== function loc_023012D4 =====
loc_023012D4:
	bx pc	; 023012D4
	.byte 0xC0, 0x46	; 023012D8
.arm

; ===== function loc_023012D8 =====
loc_023012D8:
	ldr r12,[pool_023012E0]	; 023012D8
	bx r12	; 023012DC
pool_023012E0:
loc_023012E0:
	.word loc_037FEB08 + 1	; 023012E0
.thumb

; ===== function loc_023012E4 =====
loc_023012E4:
	bx pc	; 023012E4
	.byte 0xC0, 0x46	; 023012E8
.arm

; ===== function loc_023012E8 =====
loc_023012E8:
	ldr pc,[pool_023012EC]	; 023012E8
pool_023012EC:
loc_023012EC:
	.word loc_037FF118	; 023012EC
.thumb

; ===== function loc_023012F0 =====
loc_023012F0:
	bx pc	; 023012F0
	.byte 0xC0, 0x46	; 023012F4
.arm

; ===== function loc_023012F4 =====
loc_023012F4:
	ldr r12,[pool_023012FC]	; 023012F4
	bx r12	; 023012F8
pool_023012FC:
loc_023012FC:
	.word P2_Runtime_037F8134 + 1	; 023012FC
.thumb

; ===== function loc_02301300 =====
loc_02301300:
	push {r4,r5,r6,r7,lr}	; 02301300
	sub sp,#0x4	; 02301302
	add r5,r0,#0x0	; 02301304
	add r4,r1,#0x0	; 02301306
	bl P4_GetRuntimeState	; 02301308
	mov r6,#0xff	; 0230130C
	cmp r4,#0x0	; 0230130E
	beq loc_02301316	; 02301310
	mov r6,#0x4	; 02301312
	b loc_0230133E	; 02301314
loc_02301316:
	ldrh r0,[r5,#0x14]	; 02301316
	cmp r0,#0x1	; 02301318
	bcc loc_02301346	; 0230131A
	mov r4,#0x0	; 0230131C
	add r7,r5,#0x0	; 0230131E
	add r7,#0x1a	; 02301320
	b loc_02301338	; 02301322
loc_02301324:
	ldrh r0,[r5,#0x16]	; 02301324
	mul r0,r4	; 02301326
	add r0,r7,r0	; 02301328
	ldrb r0,[r0,#0x3]	; 0230132A
	bl loc_023004B4	; 0230132C
	cmp r0,r6	; 02301330
	bcs loc_02301336	; 02301332
	add r6,r0,#0x0	; 02301334
loc_02301336:
	add r4,r4,#0x1	; 02301336
loc_02301338:
	ldrh r0,[r5,#0x14]	; 02301338
	cmp r4,r0	; 0230133A
	blt loc_02301324	; 0230133C
loc_0230133E:
	lsl r0,r6,#0x18	; 0230133E
	lsr r0,r0,#0x18	; 02301340
	bl P4_PushByteToInputWindow	; 02301342
loc_02301346:
	add sp,#0x4	; 02301346
	pop {r4,r5,r6,r7}	; 02301348
	pop {r3}	; 0230134A
	bx r3	; 0230134C
	.byte 0x00, 0x00	; 02301350

; ===== function loc_02301350 =====
loc_02301350:
	push {r4,r5,r6,r7,lr}	; 02301350
	sub sp,#0xc	; 02301352
	add r7,r0,#0x0	; 02301354
	bl P4_GetRuntimeState	; 02301356
	ldr r1,[pool_02301500]	; 0230135A
	ldr r0,[r0,r1]	; 0230135C
	ldr r5,[r0,#0x0]	; 0230135E
	mov r0,#0x0	; 02301360
	str r0,[sp,#0x8]	; 02301362
	ldr r0,[r5,#0x10]	; 02301364
	cmp r0,#0x0	; 02301366
	bne loc_0230136C	; 02301368
	b loc_023014F8	; 0230136A
loc_0230136C:
	ldrh r0,[r7,#0x12]	; 0230136C
	cmp r0,#0x0	; 0230136E
	beq loc_023013AC	; 02301370
	mov r1,#0x27	; 02301372
	ldr r0,[pool_02301504]	; 02301374
	str r1,[r0,#0x0]	; 02301376
	add r5,#0x42	; 02301378
	ldrh r1,[r5,#0x0]	; 0230137A
	str r1,[r0,#0x4]	; 0230137C
	bl P4_GetRuntimeState	; 0230137E
	add r0,#0x64	; 02301382
	ldr r1,[pool_02301504]	; 02301384
	mov r2,#0x0	; 02301386
	bl loc_02300868	; 02301388
	cmp r0,#0x0	; 0230138C
	beq loc_02301392	; 0230138E
	b loc_023014F8	; 02301390
loc_02301392:
	bl P4_AcquireCommandSlot	; 02301392
	mov r1,#0x80	; 02301396
	strh r1,[r0,#0x0]	; 02301398
	mov r1,#0x8	; 0230139A
	strh r1,[r0,#0x2]	; 0230139C
	mov r1,#0x16	; 0230139E
	strh r1,[r0,#0x4]	; 023013A0
	mov r1,#0x27	; 023013A2
	strh r1,[r0,#0x6]	; 023013A4
	bl P4_SubmitCommandSlot	; 023013A6
	b loc_023014F8	; 023013AA
loc_023013AC:
	add r0,r5,#0x0	; 023013AC
	add r0,#0x46	; 023013AE
	ldrh r0,[r0,#0x0]	; 023013B0
	lsl r0,r0,#0x2	; 023013B2
	add r0,r5,r0	; 023013B4
	ldr r4,[r0,#0x4c]	; 023013B6
	bl P4_GetRuntimeState	; 023013B8
	ldr r1,[pool_02301508]	; 023013BC
	ldr r0,[r0,r1]	; 023013BE
	add r1,r7,#0x0	; 023013C0
	add r1,#0x10	; 023013C2
	add r2,r4,#0x0	; 023013C4
	add r3,r5,#0x0	; 023013C6
	add r3,#0x4a	; 023013C8
	ldrh r3,[r3,#0x0]	; 023013CA
	bl loc_023006F8	; 023013CC
	add r0,r7,#0x0	; 023013D0
	ldrh r1,[r4,#0x0]	; 023013D2
	add r2,r5,#0x0	; 023013D4
	add r2,#0x96	; 023013D6
	ldrh r2,[r2,#0x0]	; 023013D8
	bl loc_02301300	; 023013DA
	bl P4_Classify16ByteWindowAverage	; 023013DE
	add r1,r5,#0x0	; 023013E2
	add r1,#0xbc	; 023013E4
	strh r0,[r1,#0x0]	; 023013E6
	add r6,r4,#0x0	; 023013E8
	add r6,#0xa	; 023013EA
	mov r0,#0x0	; 023013EC
	str r0,[sp,#0x4]	; 023013EE
	b loc_02301438	; 023013F0
loc_023013F2:
	ldrh r1,[r6,#0x0]	; 023013F2
	cmp r1,#0x2	; 023013F4
	bcc loc_0230142A	; 023013F6
	ldr r0,[pool_0230150C]	; 023013F8
	cmp r1,r0	; 023013FA
	beq loc_0230142A	; 023013FC
	sub r0,r1,#0x2	; 023013FE
	strh r0,[r6,#0x0]	; 02301400
	add r0,r5,#0x0	; 02301402
	add r0,#0x8a	; 02301404
	ldrh r0,[r0,#0x0]	; 02301406
	ldrh r1,[r6,#0x4]	; 02301408
	mov r2,#0x1	; 0230140A
	lsl r2,r1	; 0230140C
	orr r0,r2	; 0230140E
	add r1,r5,#0x0	; 02301410
	add r1,#0x8a	; 02301412
	strh r0,[r1,#0x0]	; 02301414
	ldrh r3,[r6,#0x0]	; 02301416
	cmp r3,#0x0	; 02301418
	beq loc_0230142A	; 0230141A
	str r4,[sp,#0x0]	; 0230141C
	ldrh r0,[r6,#0x4]	; 0230141E
	ldrh r1,[r6,#0x8]	; 02301420
	add r2,r6,#0x0	; 02301422
	add r2,#0xa	; 02301424
	bl loc_02303998	; 02301426
loc_0230142A:
	ldr r0,[sp,#0x4]	; 0230142A
	add r0,r0,#0x1	; 0230142C
	lsl r0,r0,#0x10	; 0230142E
	lsr r0,r0,#0x10	; 02301430
	str r0,[sp,#0x4]	; 02301432
	ldrh r0,[r4,#0x6]	; 02301434
	add r6,r6,r0	; 02301436
loc_02301438:
	ldrh r1,[r4,#0x4]	; 02301438
	ldr r0,[sp,#0x4]	; 0230143A
	cmp r0,r1	; 0230143C
	bcc loc_023013F2	; 0230143E
	mov r0,#0x0	; 02301440
	ldrh r1,[r4,#0x0]	; 02301442
	bl loc_02303B38	; 02301444
	ldrh r0,[r4,#0x0]	; 02301448
	cmp r0,#0x0	; 0230144A
	beq loc_02301462	; 0230144C
	add r0,r5,#0x0	; 0230144E
	add r0,#0x9a	; 02301450
	ldrh r0,[r0,#0x0]	; 02301452
	cmp r0,#0x0	; 02301454
	bne loc_02301462	; 02301456
	ldrh r0,[r5,#0x3c]	; 02301458
	cmp r0,#0x0	; 0230145A
	beq loc_02301462	; 0230145C
	mov r0,#0x1	; 0230145E
	str r0,[sp,#0x8]	; 02301460
loc_02301462:
	bl P4_AcquireCommandSlot	; 02301462
	mov r1,#0xe	; 02301466
	strh r1,[r0,#0x0]	; 02301468
	mov r1,#0x0	; 0230146A
	strh r1,[r0,#0x2]	; 0230146C
	mov r1,#0xb	; 0230146E
	strh r1,[r0,#0x4]	; 02301470
	str r4,[r0,#0x8]	; 02301472
	bl P4_SubmitCommandSlot	; 02301474
	bl loc_023012F0	; 02301478
	add r0,r5,#0x0	; 0230147C
	add r0,#0x46	; 0230147E
	ldrh r1,[r0,#0x0]	; 02301480
	mov r0,#0x1	; 02301482
	eor r1,r0	; 02301484
	add r0,r5,#0x0	; 02301486
	add r0,#0x46	; 02301488
	strh r1,[r0,#0x0]	; 0230148A
	bl loc_02301514	; 0230148C
	ldr r1,[sp,#0x8]	; 02301490
	cmp r1,#0x0	; 02301492
	bne loc_0230149C	; 02301494
	ldrh r1,[r5,#0x3e]	; 02301496
	sub r1,r1,#0x1	; 02301498
	strh r1,[r5,#0x3e]	; 0230149A
loc_0230149C:
	ldrh r1,[r5,#0x3e]	; 0230149C
	cmp r1,#0x0	; 0230149E
	beq loc_023014A6	; 023014A0
	mov r4,#0x1	; 023014A2
	b loc_023014A8	; 023014A4
loc_023014A6:
	mov r4,#0x0	; 023014A6
loc_023014A8:
	bl loc_02301520	; 023014A8
	cmp r4,#0x0	; 023014AC
	beq loc_023014F8	; 023014AE
	ldr r0,[sp,#0x8]	; 023014B0
	cmp r0,#0x1	; 023014B2
	bne loc_023014BA	; 023014B4
	ldrh r5,[r7,#0x10]	; 023014B6
	b loc_023014BC	; 023014B8
loc_023014BA:
	ldr r5,[pool_0230150C]	; 023014BA
loc_023014BC:
	bl P4_GetRuntimeState	; 023014BC
	add r4,r0,#0x0	; 023014C0
	mov r0,#0x25	; 023014C2
	ldr r1,[pool_02301510]	; 023014C4
	str r0,[r1,#0x0]	; 023014C6
	str r5,[r1,#0x4]	; 023014C8
	add r0,r4,#0x0	; 023014CA
	add r0,#0x64	; 023014CC
	mov r2,#0x0	; 023014CE
	bl loc_02300868	; 023014D0
	cmp r0,#0x0	; 023014D4
	bne loc_023014F8	; 023014D6
	ldr r0,[pool_02301500]	; 023014D8
	ldr r0,[r4,r0]	; 023014DA
	cmp r0,#0x0	; 023014DC
	beq loc_023014F8	; 023014DE
	bl P4_AcquireCommandSlot	; 023014E0
	mov r1,#0x80	; 023014E4
	strh r1,[r0,#0x0]	; 023014E6
	mov r1,#0x8	; 023014E8
	strh r1,[r0,#0x2]	; 023014EA
	mov r1,#0x16	; 023014EC
	strh r1,[r0,#0x4]	; 023014EE
	mov r1,#0x25	; 023014F0
	strh r1,[r0,#0x6]	; 023014F2
	bl P4_SubmitCommandSlot	; 023014F4
loc_023014F8:
	add sp,#0xc	; 023014F8
	pop {r4,r5,r6,r7}	; 023014FA
	pop {r3}	; 023014FC
	bx r3	; 023014FE
pool_02301500:
loc_02301500:
	.word 0x00001518	; 02301500
pool_02301504:
loc_02301504:
	.word P4_BssStart + 0x2404	; 02301504
pool_02301508:
loc_02301508:
	.word 0x0000150C	; 02301508
pool_0230150C:
loc_0230150C:
	.word 0x0000FFFF	; 0230150C
pool_02301510:
loc_02301510:
	.word P4_BssStart + 0x23FC	; 02301510

; ===== function loc_02301514 =====
loc_02301514:
	bx pc	; 02301514
	.byte 0xC0, 0x46	; 02301518
.arm

; ===== function loc_02301518 =====
loc_02301518:
	ldr pc,[pool_0230151C]	; 02301518
pool_0230151C:
loc_0230151C:
	.word loc_037FF104	; 0230151C
.thumb

; ===== function loc_02301520 =====
loc_02301520:
	bx pc	; 02301520
	.byte 0xC0, 0x46	; 02301524
.arm

; ===== function loc_02301524 =====
loc_02301524:
	ldr pc,[pool_02301528]	; 02301524
pool_02301528:
loc_02301528:
	.word loc_037FF118	; 02301528
.thumb

; ===== function loc_0230152C =====
loc_0230152C:
	push {lr}	; 0230152C
	sub sp,#0x4	; 0230152E
	bl P4_AcquireCommandSlot	; 02301530
	mov r1,#0xc	; 02301534
	strh r1,[r0,#0x0]	; 02301536
	mov r1,#0x0	; 02301538
	strh r1,[r0,#0x2]	; 0230153A
	mov r1,#0x8	; 0230153C
	strh r1,[r0,#0x8]	; 0230153E
	bl P4_SubmitCommandSlot	; 02301540
	add sp,#0x4	; 02301544
	pop {r3}	; 02301546
	bx r3	; 02301548
	.byte 0x00, 0x00	; 0230154C

; ===== function loc_0230154C =====
loc_0230154C:
	push {r4,r5,r6,r7,lr}	; 0230154C
	sub sp,#0x4	; 0230154E
	add r7,r0,#0x0	; 02301550
	bl P4_GetRuntimeState	; 02301552
	str r0,[sp,#0x0]	; 02301556
	ldr r1,[pool_023015F8]	; 02301558
	ldr r6,[r0,r1]	; 0230155A
	add r5,r7,#0x0	; 0230155C
	add r5,#0x3c	; 0230155E
	ldr r1,[r6,#0x0]	; 02301560
	ldrh r0,[r1,#0x0]	; 02301562
	cmp r0,#0x8	; 02301564
	beq loc_0230156C	; 02301566
	cmp r0,#0xa	; 02301568
	bne loc_023015EE	; 0230156A
loc_0230156C:
	add r1,#0xba	; 0230156C
	ldrh r1,[r1,#0x0]	; 0230156E
	ldrh r0,[r5,#0x8]	; 02301570
	cmp r1,r0	; 02301572
	beq loc_023015AC	; 02301574
	mov r1,#0x24	; 02301576
	ldr r0,[pool_023015FC]	; 02301578
	str r1,[r0,#0x0]	; 0230157A
	mov r1,#0x1	; 0230157C
	str r1,[r0,#0x4]	; 0230157E
	bl P4_GetRuntimeState	; 02301580
	add r0,#0x64	; 02301584
	ldr r1,[pool_023015FC]	; 02301586
	mov r2,#0x0	; 02301588
	bl loc_02300868	; 0230158A
	cmp r0,#0x0	; 0230158E
	bne loc_023015EE	; 02301590
	bl P4_AcquireCommandSlot	; 02301592
	mov r1,#0x80	; 02301596
	strh r1,[r0,#0x0]	; 02301598
	mov r1,#0x8	; 0230159A
	strh r1,[r0,#0x2]	; 0230159C
	mov r1,#0x16	; 0230159E
	strh r1,[r0,#0x4]	; 023015A0
	mov r1,#0x24	; 023015A2
	strh r1,[r0,#0x6]	; 023015A4
	bl P4_SubmitCommandSlot	; 023015A6
	b loc_023015EE	; 023015AA
loc_023015AC:
	bl P4_AcquireCommandSlot	; 023015AC
	add r4,r0,#0x0	; 023015B0
	mov r0,#0x80	; 023015B2
	strh r0,[r4,#0x0]	; 023015B4
	mov r0,#0x0	; 023015B6
	strh r0,[r4,#0x2]	; 023015B8
	mov r0,#0x10	; 023015BA
	strh r0,[r4,#0x4]	; 023015BC
	ldrh r0,[r5,#0x8]	; 023015BE
	strh r0,[r4,#0x6]	; 023015C0
	ldr r0,[r6,#0x0]	; 023015C2
	ldrh r0,[r0,#0x0]	; 023015C4
	strh r0,[r4,#0x8]	; 023015C6
	ldrh r0,[r7,#0x16]	; 023015C8
	strh r0,[r4,#0xa]	; 023015CA
	ldrh r3,[r4,#0xa]	; 023015CC
	cmp r3,#0x80	; 023015CE
	bhi loc_023015E8	; 023015D0
	ldr r1,[pool_02301600]	; 023015D2
	ldr r0,[sp,#0x0]	; 023015D4
	ldr r0,[r0,r1]	; 023015D6
	add r1,r5,#0x0	; 023015D8
	add r2,r4,#0x0	; 023015DA
	add r2,#0xc	; 023015DC
	add r3,r3,#0x1	; 023015DE
	mov r5,#0x1	; 023015E0
	bic r3,r5	; 023015E2
	bl loc_023006F8	; 023015E4
loc_023015E8:
	add r0,r4,#0x0	; 023015E8
	bl P4_SubmitCommandSlot	; 023015EA
loc_023015EE:
	add sp,#0x4	; 023015EE
	pop {r4,r5,r6,r7}	; 023015F0
	pop {r3}	; 023015F2
	bx r3	; 023015F4
	.byte 0xC0, 0x46	; 023015F8
pool_023015F8:
loc_023015F8:
	.word 0x00001518	; 023015F8
pool_023015FC:
loc_023015FC:
	.word P4_BssStart + 0x23F4	; 023015FC
pool_02301600:
loc_02301600:
	.word 0x0000150C	; 02301600

; ===== function loc_02301604 =====
loc_02301604:
	push {lr}	; 02301604
	sub sp,#0x4	; 02301606
	bl P4_AcquireCommandSlot	; 02301608
	mov r1,#0x8	; 0230160C
	strh r1,[r0,#0x0]	; 0230160E
	mov r1,#0x0	; 02301610
	strh r1,[r0,#0x2]	; 02301612
	mov r1,#0x2	; 02301614
	strh r1,[r0,#0x8]	; 02301616
	bl P4_SubmitCommandSlot	; 02301618
	add sp,#0x4	; 0230161C
	pop {r3}	; 0230161E
	bx r3	; 02301620
	.byte 0x00, 0x00	; 02301624

; ===== function loc_02301624 =====
loc_02301624:
	bx lr	; 02301624
	.byte 0x00, 0x00	; 02301628

; ===== function loc_02301628 =====
loc_02301628:
	push {r4,r5,r6,lr}	; 02301628
	add r5,r0,#0x0	; 0230162A
	bl P4_GetRuntimeState	; 0230162C
	add r4,r0,#0x0	; 02301630
	bl loc_0230165C	; 02301632
	add r6,r0,#0x0	; 02301636
	ldr r0,[pool_02301654]	; 02301638
	ldr r0,[r4,r0]	; 0230163A
	ldr r1,[pool_02301658]	; 0230163C
	ldr r1,[r4,r1]	; 0230163E
	add r2,r5,#0x0	; 02301640
	bl loc_02301668	; 02301642
	add r0,r6,#0x0	; 02301646
	bl loc_02301678	; 02301648
	pop {r4,r5,r6}	; 0230164C
	pop {r3}	; 0230164E
	bx r3	; 02301650
	.byte 0xC0, 0x46	; 02301654
pool_02301654:
loc_02301654:
	.word 0x00001510	; 02301654
pool_02301658:
loc_02301658:
	.word 0x00001514	; 02301658

; ===== function loc_0230165C =====
loc_0230165C:
	bx pc	; 0230165C
	.byte 0xC0, 0x46	; 02301660
.arm

; ===== function loc_02301660 =====
loc_02301660:
	ldr pc,[pool_02301664]	; 02301660
pool_02301664:
loc_02301664:
	.word loc_037FF104	; 02301664
.thumb

; ===== function loc_02301668 =====
loc_02301668:
	bx pc	; 02301668
	.byte 0xC0, 0x46	; 0230166C
.arm

; ===== function loc_0230166C =====
loc_0230166C:
	ldr r12,[pool_02301674]	; 0230166C
	bx r12	; 02301670
pool_02301674:
loc_02301674:
	.word P2_Entry_037FE6D0 + 1	; 02301674
.thumb

; ===== function loc_02301678 =====
loc_02301678:
	bx pc	; 02301678
	.byte 0xC0, 0x46	; 0230167C
.arm

; ===== function loc_0230167C =====
loc_0230167C:
	ldr pc,[pool_02301680]	; 0230167C
pool_02301680:
loc_02301680:
	.word loc_037FF118	; 02301680
.thumb

; ===== function loc_02301684 =====
loc_02301684:
	push {r4,lr}	; 02301684
	add r4,r0,#0x0	; 02301686
	bl P4_GetRuntimeState	; 02301688
	ldr r1,[pool_0230177C]	; 0230168C
	ldr r0,[r0,r1]	; 0230168E
	cmp r0,#0x0	; 02301690
	beq loc_02301774	; 02301692
	bl P4_GetRuntimeState	; 02301694
	ldr r1,[pool_0230177C]	; 02301698
	ldr r0,[r0,r1]	; 0230169A
	ldr r0,[r0,#0x0]	; 0230169C
	ldrh r0,[r0,#0x0]	; 0230169E
	cmp r0,#0x1	; 023016A0
	beq loc_02301774	; 023016A2
	ldrh r0,[r4,#0xc]	; 023016A4
	ldr r1,[pool_02301780]	; 023016A6
	cmp r0,r1	; 023016A8
	bgt loc_023016E6	; 023016AA
	cmp r0,r1	; 023016AC
	bge loc_02301748	; 023016AE
	cmp r0,#0x8d	; 023016B0
	bgt loc_023016DE	; 023016B2
	add r1,r0,#0x0	; 023016B4
	sub r1,#0x84	; 023016B6
	cmp r1,#0x0	; 023016B8
	blt loc_02301768	; 023016BA
	add r1,r1,r1	; 023016BC
P4_SwitchIndexPC_023016BC:
	add r1,pc	; 023016BE
	ldrh r1,[r1,#(P4_SwitchTable_023016BC - (P4_SwitchIndexPC_023016BC + 4))]	; 023016C0
	lsl r1,r1,#0x10	; 023016C2
	asr r1,r1,#0x10	; 023016C4
P4_SwitchTargetPC_023016BC:
	add r1,pc	; 023016C6
	bx r1	; 023016C8
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_023016BC:
	.halfword (loc_02301700 + 1) - (P4_SwitchTargetPC_023016BC + 4)
	.halfword (loc_02301708 + 1) - (P4_SwitchTargetPC_023016BC + 4)
	.halfword (loc_02301710 + 1) - (P4_SwitchTargetPC_023016BC + 4)
	.halfword (loc_02301718 + 1) - (P4_SwitchTargetPC_023016BC + 4)
	.halfword (loc_02301720 + 1) - (P4_SwitchTargetPC_023016BC + 4)
	.halfword (loc_02301768 + 1) - (P4_SwitchTargetPC_023016BC + 4)
	.halfword (loc_02301768 + 1) - (P4_SwitchTargetPC_023016BC + 4)
	.halfword (loc_02301728 + 1) - (P4_SwitchTargetPC_023016BC + 4)
	.halfword (loc_02301730 + 1) - (P4_SwitchTargetPC_023016BC + 4)
	.halfword (loc_02301738 + 1) - (P4_SwitchTargetPC_023016BC + 4)
P4_SwitchTable_023016BCEnd:
loc_023016DE:
	ldr r1,[pool_02301784]	; 023016DE
	cmp r0,r1	; 023016E0
	beq loc_02301740	; 023016E2
	b loc_02301768	; 023016E4
loc_023016E6:
	ldr r1,[pool_02301788]	; 023016E6
	cmp r0,r1	; 023016E8
	bgt loc_023016F8	; 023016EA
	cmp r0,r1	; 023016EC
	bge loc_02301758	; 023016EE
	ldr r1,[pool_0230178C]	; 023016F0
	cmp r0,r1	; 023016F2
	beq loc_02301750	; 023016F4
	b loc_02301768	; 023016F6
loc_023016F8:
	ldr r1,[pool_02301790]	; 023016F8
	cmp r0,r1	; 023016FA
	beq loc_02301760	; 023016FC
	b loc_02301768	; 023016FE
loc_02301700:
	add r0,r4,#0x0	; 02301700
	bl loc_02300A64	; 02301702
	b loc_0230176E	; 02301706
loc_02301708:
	add r0,r4,#0x0	; 02301708
	bl loc_02300A84	; 0230170A
	b loc_0230176E	; 0230170E
loc_02301710:
	add r0,r4,#0x0	; 02301710
	bl loc_02300B94	; 02301712
	b loc_0230176E	; 02301716
loc_02301718:
	add r0,r4,#0x0	; 02301718
	bl loc_02300CA8	; 0230171A
	b loc_0230176E	; 0230171E
loc_02301720:
	add r0,r4,#0x0	; 02301720
	bl loc_02300CC8	; 02301722
	b loc_0230176E	; 02301726
loc_02301728:
	add r0,r4,#0x0	; 02301728
	bl loc_0230152C	; 0230172A
	b loc_0230176E	; 0230172E
loc_02301730:
	add r0,r4,#0x0	; 02301730
	bl loc_02301604	; 02301732
	b loc_0230176E	; 02301736
loc_02301738:
	add r0,r4,#0x0	; 02301738
	bl loc_0230154C	; 0230173A
	b loc_0230176E	; 0230173E
loc_02301740:
	add r0,r4,#0x0	; 02301740
	bl loc_02300D64	; 02301742
	b loc_0230176E	; 02301746
loc_02301748:
	add r0,r4,#0x0	; 02301748
	bl loc_02301084	; 0230174A
	b loc_0230176E	; 0230174E
loc_02301750:
	add r0,r4,#0x0	; 02301750
	bl loc_02301350	; 02301752
	b loc_0230176E	; 02301756
loc_02301758:
	add r0,r4,#0x0	; 02301758
	bl loc_02300E0C	; 0230175A
	b loc_0230176E	; 0230175E
loc_02301760:
	add r0,r4,#0x0	; 02301760
	bl loc_02300CE8	; 02301762
	b loc_0230176E	; 02301766
loc_02301768:
	add r0,r4,#0x0	; 02301768
	bl loc_02301624	; 0230176A
loc_0230176E:
	add r0,r4,#0x0	; 0230176E
	bl loc_02301628	; 02301770
loc_02301774:
	pop {r4}	; 02301774
	pop {r3}	; 02301776
	bx r3	; 02301778
	.byte 0xC0, 0x46	; 0230177C
pool_0230177C:
loc_0230177C:
	.word 0x00001518	; 0230177C
pool_02301780:
loc_02301780:
	.word 0x00000182	; 02301780
pool_02301784:
loc_02301784:
	.word 0x00000180	; 02301784
pool_02301788:
loc_02301788:
	.word 0x00000185	; 02301788
pool_0230178C:
loc_0230178C:
	.word 0x00000184	; 0230178C
pool_02301790:
loc_02301790:
	.word 0x00000186	; 02301790

; ===== function loc_02301794 =====
	push {r4,r5,r6,r7,lr}	; 02301794
	sub sp,#0x4	; 02301796
	bl P4_GetRuntimeState	; 02301798
	add r4,r0,#0x0	; 0230179C
	add r4,#0x40	; 0230179E
	add r5,r0,#0x0	; 023017A0
	add r5,#0x1c	; 023017A2
	mov r7,#0xff	; 023017A4
	ldr r6,[pool_023017EC]	; 023017A6
loc_023017A8:
	add r0,r5,#0x0	; 023017A8
	add r1,sp,#0x0	; 023017AA
	mov r2,#0x1	; 023017AC
	bl loc_023008C8	; 023017AE
	ldr r2,[sp,#0x0]	; 023017B2
	ldrh r0,[r2,#0xc]	; 023017B4
	add r1,r0,#0x0	; 023017B6
	and r1,r7	; 023017B8
	lsl r1,r1,#0x10	; 023017BA
	lsr r3,r1,#0x10	; 023017BC
	and r0,r6	; 023017BE
	lsl r0,r0,#0x10	; 023017C0
	lsr r1,r0,#0x10	; 023017C2
	cmp r1,#0x0	; 023017C4
	beq loc_023017CE	; 023017C6
	ldr r0,[pool_023017F0]	; 023017C8
	cmp r1,r0	; 023017CA
	bne loc_023017DE	; 023017CC
loc_023017CE:
	mov r0,#0x80	; 023017CE
	and r3,r0	; 023017D0
	cmp r3,#0x0	; 023017D2
	beq loc_023017DE	; 023017D4
	add r0,r2,#0x0	; 023017D6
	bl loc_02301684	; 023017D8
	b loc_023017A8	; 023017DC
loc_023017DE:
	add r0,r4,#0x0	; 023017DE
	add r1,r2,#0x0	; 023017E0
	mov r2,#0x1	; 023017E2
	bl loc_02300868	; 023017E4
	b loc_023017A8	; 023017E8
	.byte 0xC0, 0x46	; 023017EC
pool_023017EC:
loc_023017EC:
	.word 0x0000FF00	; 023017EC
pool_023017F0:
loc_023017F0:
	.word 0x00000100	; 023017F0
	bx lr	; 023017F4
	.byte 0x00, 0x00	; 023017F8

; ===== function loc_023017F8 =====
	push {r4,r5,r6,r7,lr}	; 023017F8
	sub sp,#0x4	; 023017FA
	bl P4_GetRuntimeState	; 023017FC
	add r5,r0,#0x0	; 02301800
	mov r6,#0x1	; 02301802
	ldr r7,[pool_0230183C]	; 02301804
	ldr r4,[pool_02301840]	; 02301806
loc_02301808:
	add r0,r5,#0x0	; 02301808
	add r0,#0x64	; 0230180A
	add r1,sp,#0x0	; 0230180C
	add r2,r6,#0x0	; 0230180E
	bl loc_023008C8	; 02301810
	ldr r0,[sp,#0x0]	; 02301814
	ldrh r1,[r0,#0x0]	; 02301816
	cmp r1,#0x28	; 02301818
	bcs loc_02301808	; 0230181A
	ldr r0,[r5,r4]	; 0230181C
	ldr r0,[r0,#0x0]	; 0230181E
	str r6,[r0,#0x4]	; 02301820
	ldr r0,[r5,r4]	; 02301822
	ldr r0,[r0,#0x0]	; 02301824
	strh r1,[r0,#0x2]	; 02301826
	ldr r0,[sp,#0x0]	; 02301828
	lsl r1,r1,#0x2	; 0230182A
	ldr r1,[r7,r1]	; 0230182C
	bl loc_02301844	; 0230182E
	ldr r0,[r5,r4]	; 02301832
	ldr r1,[r0,#0x0]	; 02301834
	mov r0,#0x0	; 02301836
	str r0,[r1,#0x4]	; 02301838
	b loc_02301808	; 0230183A
pool_0230183C:
loc_0230183C:
	.word 0x0230D504	; 0230183C
pool_02301840:
loc_02301840:
	.word 0x00001518	; 02301840

; ===== function loc_02301844 =====
loc_02301844:
	bx pc	; 02301844
	.byte 0xC0, 0x46	; 02301848
.arm

; ===== function loc_02301848 =====
loc_02301848:
	ldr r12,[pool_02301850]	; 02301848
	bx r12	; 0230184C
pool_02301850:
loc_02301850:
	.word loc_03805088 + 1	; 02301850
.thumb
loc_02301854:
	push {r4,lr}	; 02301854
	mov r3,#0x0	; 02301856
	strh r3,[r0,#0x0]	; 02301858
	strh r3,[r0,#0x2]	; 0230185A
	strh r3,[r0,#0x4]	; 0230185C
	strh r3,[r0,#0x6]	; 0230185E
	strh r3,[r0,#0x8]	; 02301860
	strh r3,[r0,#0xa]	; 02301862
	strh r1,[r0,#0xc]	; 02301864
	strh r3,[r0,#0xe]	; 02301866
	ldrh r1,[r0,#0xe]	; 02301868
	lsl r1,r1,#0x1	; 0230186A
	add r3,r0,r1	; 0230186C
	add r4,r3,#0x0	; 0230186E
	add r4,#0x10	; 02301870
	ldrh r1,[r0,#0xc]	; 02301872
	strh r1,[r3,#0x10]	; 02301874
	strh r2,[r4,#0x2]	; 02301876
	bl loc_02300878	; 02301878
	add r0,r4,#0x0	; 0230187C
	pop {r4}	; 0230187E
	pop {r3}	; 02301880
	bx r3	; 02301882

; ===== function loc_02301884 =====
loc_02301884:
	push {r4,lr}	; 02301884
	mov r4,#0x0	; 02301886
	strh r4,[r0,#0x0]	; 02301888
	strh r4,[r0,#0x2]	; 0230188A
	strh r4,[r0,#0x4]	; 0230188C
	strh r4,[r0,#0x6]	; 0230188E
	strh r4,[r0,#0x8]	; 02301890
	strh r4,[r0,#0xa]	; 02301892
	ldr r4,[pool_023018C8]	; 02301894
	strh r4,[r0,#0xc]	; 02301896
	mov r4,#0x4	; 02301898
	strh r4,[r0,#0xe]	; 0230189A
	strh r1,[r0,#0x10]	; 0230189C
	strh r2,[r0,#0x12]	; 0230189E
	strh r3,[r0,#0x14]	; 023018A0
	ldr r1,[pool_023018CC]	; 023018A2
	add r1,sp	; 023018A4
	ldrh r1,[r1,#0x10]	; 023018A6
	strh r1,[r0,#0x16]	; 023018A8
	ldrh r1,[r0,#0xe]	; 023018AA
	lsl r1,r1,#0x1	; 023018AC
	add r2,r0,r1	; 023018AE
	add r4,r2,#0x0	; 023018B0
	add r4,#0x10	; 023018B2
	ldrh r1,[r0,#0xc]	; 023018B4
	strh r1,[r2,#0x10]	; 023018B6
	mov r1,#0x1	; 023018B8
	strh r1,[r4,#0x2]	; 023018BA
	bl loc_02300878	; 023018BC
	add r0,r4,#0x0	; 023018C0
	pop {r4}	; 023018C2
	pop {r3}	; 023018C4
	bx r3	; 023018C6
pool_023018C8:
loc_023018C8:
	.word 0x00000309	; 023018C8
pool_023018CC:
loc_023018CC:
	.word 0xFFFFFFF8	; 023018CC

; ===== function loc_023018D0 =====
loc_023018D0:
	ldr r1,[pool_023018D8]	; 023018D0
	mov r2,#0x2	; 023018D2
	ldr r3,[pool_023018DC]	; 023018D4
	bx r3	; 023018D6
pool_023018D8:
loc_023018D8:
	.word 0x00000308	; 023018D8
pool_023018DC:
loc_023018DC:
	.word loc_02301854 + 1	; 023018DC

; ===== function loc_023018E0 =====
loc_023018E0:
	ldr r1,[pool_023018E8]	; 023018E0
	mov r2,#0x5c	; 023018E2
	ldr r3,[pool_023018EC]	; 023018E4
	bx r3	; 023018E6
pool_023018E8:
loc_023018E8:
	.word 0x00000307	; 023018E8
pool_023018EC:
loc_023018EC:
	.word loc_02301854 + 1	; 023018EC

; ===== function loc_023018F0 =====
loc_023018F0:
	ldr r1,[pool_023018F8]	; 023018F0
	mov r2,#0x9	; 023018F2
	ldr r3,[pool_023018FC]	; 023018F4
	bx r3	; 023018F6
pool_023018F8:
loc_023018F8:
	.word 0x00000306	; 023018F8
pool_023018FC:
loc_023018FC:
	.word loc_02301854 + 1	; 023018FC

; ===== function loc_02301900 =====
loc_02301900:
	ldr r1,[pool_02301908]	; 02301900
	mov r2,#0x1	; 02301902
	ldr r3,[pool_0230190C]	; 02301904
	bx r3	; 02301906
pool_02301908:
loc_02301908:
	.word 0x00000305	; 02301908
pool_0230190C:
loc_0230190C:
	.word loc_02301854 + 1	; 0230190C

; ===== function loc_02301910 =====
loc_02301910:
	ldr r1,[pool_02301918]	; 02301910
	mov r2,#0x1	; 02301912
	ldr r3,[pool_0230191C]	; 02301914
	bx r3	; 02301916
pool_02301918:
loc_02301918:
	.word 0x00000304	; 02301918
pool_0230191C:
loc_0230191C:
	.word loc_02301854 + 1	; 0230191C

; ===== function loc_02301920 =====
loc_02301920:
	ldr r1,[pool_02301928]	; 02301920
	mov r2,#0x1	; 02301922
	ldr r3,[pool_0230192C]	; 02301924
	bx r3	; 02301926
pool_02301928:
loc_02301928:
	.word 0x00000303	; 02301928
pool_0230192C:
loc_0230192C:
	.word loc_02301854 + 1	; 0230192C

; ===== function loc_02301930 =====
loc_02301930:
	ldr r1,[pool_02301938]	; 02301930
	mov r2,#0x1	; 02301932
	ldr r3,[pool_0230193C]	; 02301934
	bx r3	; 02301936
pool_02301938:
loc_02301938:
	.word 0x00000302	; 02301938
pool_0230193C:
loc_0230193C:
	.word loc_02301854 + 1	; 0230193C

; ===== function loc_02301940 =====
loc_02301940:
	ldr r1,[pool_02301948]	; 02301940
	mov r2,#0x1	; 02301942
	ldr r3,[pool_0230194C]	; 02301944
	bx r3	; 02301946
pool_02301948:
loc_02301948:
	.word 0x00000301	; 02301948
pool_0230194C:
loc_0230194C:
	.word loc_02301854 + 1	; 0230194C

; ===== function loc_02301950 =====
loc_02301950:
	ldr r1,[pool_02301958]	; 02301950
	mov r2,#0x2	; 02301952
	ldr r3,[pool_0230195C]	; 02301954
	bx r3	; 02301956
pool_02301958:
loc_02301958:
	.word 0x00000284	; 02301958
pool_0230195C:
loc_0230195C:
	.word loc_02301854 + 1	; 0230195C

; ===== function loc_02301960 =====
loc_02301960:
	ldr r1,[pool_02301968]	; 02301960
	mov r2,#0x3	; 02301962
	ldr r3,[pool_0230196C]	; 02301964
	bx r3	; 02301966
pool_02301968:
loc_02301968:
	.word 0x00000283	; 02301968
pool_0230196C:
loc_0230196C:
	.word loc_02301854 + 1	; 0230196C

; ===== function loc_02301970 =====
loc_02301970:
	ldr r1,[pool_02301978]	; 02301970
	mov r2,#0x4	; 02301972
	ldr r3,[pool_0230197C]	; 02301974
	bx r3	; 02301976
pool_02301978:
loc_02301978:
	.word 0x00000281	; 02301978
pool_0230197C:
loc_0230197C:
	.word loc_02301854 + 1	; 0230197C

; ===== function loc_02301980 =====
loc_02301980:
	push {r4,r5,r6,lr}	; 02301980
	add r5,r0,#0x0	; 02301982
	add r4,r1,#0x0	; 02301984
	add r6,r2,#0x0	; 02301986
	bl P4_GetRuntimeState	; 02301988
	mov r0,#0x0	; 0230198C
	strh r0,[r5,#0x0]	; 0230198E
	strh r0,[r5,#0x2]	; 02301990
	strh r0,[r5,#0x4]	; 02301992
	strh r0,[r5,#0x6]	; 02301994
	strh r0,[r5,#0x8]	; 02301996
	strh r0,[r5,#0xa]	; 02301998
	ldr r0,[pool_023019D8]	; 0230199A
	strh r0,[r5,#0xc]	; 0230199C
	add r0,r4,#0x1	; 0230199E
	mov r1,#0x2	; 023019A0
	bl loc_023019DC	; 023019A2
	add r0,r0,#0x1	; 023019A6
	strh r0,[r5,#0xe]	; 023019A8
	strh r4,[r5,#0x10]	; 023019AA
	add r0,r6,#0x0	; 023019AC
	add r1,r5,#0x0	; 023019AE
	add r1,#0x12	; 023019B0
	add r2,r4,#0x0	; 023019B2
	bl loc_023019E8	; 023019B4
	ldrh r0,[r5,#0xe]	; 023019B8
	lsl r0,r0,#0x1	; 023019BA
	add r1,r5,r0	; 023019BC
	add r4,r1,#0x0	; 023019BE
	add r4,#0x10	; 023019C0
	ldrh r0,[r5,#0xc]	; 023019C2
	strh r0,[r1,#0x10]	; 023019C4
	mov r0,#0x1	; 023019C6
	strh r0,[r4,#0x2]	; 023019C8
	add r0,r5,#0x0	; 023019CA
	bl loc_02300878	; 023019CC
	add r0,r4,#0x0	; 023019D0
	pop {r4,r5,r6}	; 023019D2
	pop {r3}	; 023019D4
	bx r3	; 023019D6
pool_023019D8:
loc_023019D8:
	.word 0x00000245	; 023019D8

; ===== function loc_023019DC =====
loc_023019DC:
	bx pc	; 023019DC
	.byte 0xC0, 0x46	; 023019E0
.arm

; ===== function loc_023019E0 =====
loc_023019E0:
	ldr pc,[pool_023019E4]	; 023019E0
pool_023019E4:
loc_023019E4:
	.word P2_SignedDivMod	; 023019E4
.thumb

; ===== function loc_023019E8 =====
loc_023019E8:
	bx pc	; 023019E8
	.byte 0xC0, 0x46	; 023019EC
.arm

; ===== function loc_023019EC =====
loc_023019EC:
	ldr pc,[pool_023019F0]	; 023019EC
pool_023019F0:
loc_023019F0:
	.word P2_Entry_037FF334	; 023019F0
.thumb

; ===== function loc_023019F4 =====
loc_023019F4:
	push {r4,lr}	; 023019F4
	mov r2,#0x0	; 023019F6
	strh r2,[r0,#0x0]	; 023019F8
	strh r2,[r0,#0x2]	; 023019FA
	strh r2,[r0,#0x4]	; 023019FC
	strh r2,[r0,#0x6]	; 023019FE
	strh r2,[r0,#0x8]	; 02301A00
	strh r2,[r0,#0xa]	; 02301A02
	ldr r2,[pool_02301A2C]	; 02301A04
	strh r2,[r0,#0xc]	; 02301A06
	mov r2,#0x1	; 02301A08
	strh r2,[r0,#0xe]	; 02301A0A
	strh r1,[r0,#0x10]	; 02301A0C
	ldrh r1,[r0,#0xe]	; 02301A0E
	lsl r1,r1,#0x1	; 02301A10
	add r3,r0,r1	; 02301A12
	add r4,r3,#0x0	; 02301A14
	add r4,#0x10	; 02301A16
	ldrh r1,[r0,#0xc]	; 02301A18
	strh r1,[r3,#0x10]	; 02301A1A
	strh r2,[r4,#0x2]	; 02301A1C
	bl loc_02300878	; 02301A1E
	add r0,r4,#0x0	; 02301A22
	pop {r4}	; 02301A24
	pop {r3}	; 02301A26
	bx r3	; 02301A28
	.byte 0xC0, 0x46	; 02301A2C
pool_02301A2C:
loc_02301A2C:
	.word 0x00000215	; 02301A2C

; ===== function loc_02301A30 =====
loc_02301A30:
	push {r4,lr}	; 02301A30
	mov r2,#0x0	; 02301A32
	strh r2,[r0,#0x0]	; 02301A34
	strh r2,[r0,#0x2]	; 02301A36
	strh r2,[r0,#0x4]	; 02301A38
	strh r2,[r0,#0x6]	; 02301A3A
	strh r2,[r0,#0x8]	; 02301A3C
	strh r2,[r0,#0xa]	; 02301A3E
	ldr r2,[pool_02301A68]	; 02301A40
	strh r2,[r0,#0xc]	; 02301A42
	mov r2,#0x1	; 02301A44
	strh r2,[r0,#0xe]	; 02301A46
	strh r1,[r0,#0x10]	; 02301A48
	ldrh r1,[r0,#0xe]	; 02301A4A
	lsl r1,r1,#0x1	; 02301A4C
	add r3,r0,r1	; 02301A4E
	add r4,r3,#0x0	; 02301A50
	add r4,#0x10	; 02301A52
	ldrh r1,[r0,#0xc]	; 02301A54
	strh r1,[r3,#0x10]	; 02301A56
	strh r2,[r4,#0x2]	; 02301A58
	bl loc_02300878	; 02301A5A
	add r0,r4,#0x0	; 02301A5E
	pop {r4}	; 02301A60
	pop {r3}	; 02301A62
	bx r3	; 02301A64
	.byte 0xC0, 0x46	; 02301A68
pool_02301A68:
loc_02301A68:
	.word 0x00000212	; 02301A68

; ===== function loc_02301A6C =====
loc_02301A6C:
	push {r4,lr}	; 02301A6C
	mov r4,#0x0	; 02301A6E
	strh r4,[r0,#0x0]	; 02301A70
	strh r4,[r0,#0x2]	; 02301A72
	strh r4,[r0,#0x4]	; 02301A74
	strh r4,[r0,#0x6]	; 02301A76
	strh r4,[r0,#0x8]	; 02301A78
	strh r4,[r0,#0xa]	; 02301A7A
	ldr r4,[pool_02301AA8]	; 02301A7C
	strh r4,[r0,#0xc]	; 02301A7E
	mov r4,#0x3	; 02301A80
	strh r4,[r0,#0xe]	; 02301A82
	strh r1,[r0,#0x10]	; 02301A84
	strh r2,[r0,#0x12]	; 02301A86
	strh r3,[r0,#0x14]	; 02301A88
	ldrh r1,[r0,#0xe]	; 02301A8A
	lsl r1,r1,#0x1	; 02301A8C
	add r2,r0,r1	; 02301A8E
	add r4,r2,#0x0	; 02301A90
	add r4,#0x10	; 02301A92
	ldrh r1,[r0,#0xc]	; 02301A94
	strh r1,[r2,#0x10]	; 02301A96
	mov r1,#0x1	; 02301A98
	strh r1,[r4,#0x2]	; 02301A9A
	bl loc_02300878	; 02301A9C
	add r0,r4,#0x0	; 02301AA0
	pop {r4}	; 02301AA2
	pop {r3}	; 02301AA4
	bx r3	; 02301AA6
pool_02301AA8:
loc_02301AA8:
	.word 0x00000211	; 02301AA8

; ===== function loc_02301AAC =====
loc_02301AAC:
	push {r4,lr}	; 02301AAC
	mov r1,#0x0	; 02301AAE
	strh r1,[r0,#0x0]	; 02301AB0
	strh r1,[r0,#0x2]	; 02301AB2
	strh r1,[r0,#0x4]	; 02301AB4
	strh r1,[r0,#0x6]	; 02301AB6
	strh r1,[r0,#0x8]	; 02301AB8
	strh r1,[r0,#0xa]	; 02301ABA
	ldr r1,[pool_02301AE4]	; 02301ABC
	strh r1,[r0,#0xc]	; 02301ABE
	mov r1,#0x48	; 02301AC0
	strh r1,[r0,#0xe]	; 02301AC2
	ldrh r1,[r0,#0xe]	; 02301AC4
	lsl r1,r1,#0x1	; 02301AC6
	add r2,r0,r1	; 02301AC8
	add r4,r2,#0x0	; 02301ACA
	add r4,#0x10	; 02301ACC
	ldrh r1,[r0,#0xc]	; 02301ACE
	strh r1,[r2,#0x10]	; 02301AD0
	mov r1,#0x1	; 02301AD2
	strh r1,[r4,#0x2]	; 02301AD4
	bl loc_02300878	; 02301AD6
	add r0,r4,#0x0	; 02301ADA
	pop {r4}	; 02301ADC
	pop {r3}	; 02301ADE
	bx r3	; 02301AE0
	.byte 0xC0, 0x46	; 02301AE4
pool_02301AE4:
loc_02301AE4:
	.word 0x00000200	; 02301AE4

; ===== function loc_02301AE8 =====
loc_02301AE8:
	push {r4,lr}	; 02301AE8
	mov r4,#0x0	; 02301AEA
	strh r4,[r0,#0x0]	; 02301AEC
	strh r4,[r0,#0x2]	; 02301AEE
	strh r4,[r0,#0x4]	; 02301AF0
	strh r4,[r0,#0x6]	; 02301AF2
	strh r4,[r0,#0x8]	; 02301AF4
	strh r4,[r0,#0xa]	; 02301AF6
	ldr r4,[pool_02301B40]	; 02301AF8
	strh r4,[r0,#0xc]	; 02301AFA
	mov r4,#0xa	; 02301AFC
	strh r4,[r0,#0xe]	; 02301AFE
	strh r1,[r0,#0x10]	; 02301B00
	strh r2,[r0,#0x12]	; 02301B02
	strh r3,[r0,#0x14]	; 02301B04
	ldr r1,[pool_02301B44]	; 02301B06
	add r1,sp	; 02301B08
	ldrh r2,[r1,#0x10]	; 02301B0A
	strh r2,[r0,#0x16]	; 02301B0C
	ldrh r2,[r1,#0x14]	; 02301B0E
	strh r2,[r0,#0x18]	; 02301B10
	ldrh r2,[r1,#0x18]	; 02301B12
	strh r2,[r0,#0x1a]	; 02301B14
	ldrh r2,[r1,#0x1c]	; 02301B16
	strh r2,[r0,#0x1c]	; 02301B18
	ldrh r1,[r1,#0x20]	; 02301B1A
	strh r1,[r0,#0x1e]	; 02301B1C
	ldr r1,[sp,#0x1c]	; 02301B1E
	str r1,[r0,#0x20]	; 02301B20
	ldrh r1,[r0,#0xe]	; 02301B22
	lsl r1,r1,#0x1	; 02301B24
	add r2,r0,r1	; 02301B26
	add r4,r2,#0x0	; 02301B28
	add r4,#0x10	; 02301B2A
	ldrh r1,[r0,#0xc]	; 02301B2C
	strh r1,[r2,#0x10]	; 02301B2E
	mov r1,#0x1	; 02301B30
	strh r1,[r4,#0x2]	; 02301B32
	bl loc_02300878	; 02301B34
	add r0,r4,#0x0	; 02301B38
	pop {r4}	; 02301B3A
	pop {r3}	; 02301B3C
	bx r3	; 02301B3E
pool_02301B40:
loc_02301B40:
	.word 0x00000102	; 02301B40
pool_02301B44:
loc_02301B44:
	.word 0xFFFFFFF8	; 02301B44

; ===== function loc_02301B48 =====
loc_02301B48:
	push {r4,lr}	; 02301B48
	mov r4,#0x0	; 02301B4A
	strh r4,[r0,#0x0]	; 02301B4C
	strh r4,[r0,#0x2]	; 02301B4E
	strh r4,[r0,#0x4]	; 02301B50
	strh r4,[r0,#0x6]	; 02301B52
	strh r4,[r0,#0x8]	; 02301B54
	strh r4,[r0,#0xa]	; 02301B56
	ldr r4,[pool_02301B84]	; 02301B58
	strh r4,[r0,#0xc]	; 02301B5A
	mov r4,#0x4	; 02301B5C
	strh r4,[r0,#0xe]	; 02301B5E
	strh r1,[r0,#0x10]	; 02301B60
	strh r2,[r0,#0x12]	; 02301B62
	str r3,[r0,#0x14]	; 02301B64
	ldrh r1,[r0,#0xe]	; 02301B66
	lsl r1,r1,#0x1	; 02301B68
	add r2,r0,r1	; 02301B6A
	add r4,r2,#0x0	; 02301B6C
	add r4,#0x10	; 02301B6E
	ldrh r1,[r0,#0xc]	; 02301B70
	strh r1,[r2,#0x10]	; 02301B72
	mov r1,#0x1	; 02301B74
	strh r1,[r4,#0x2]	; 02301B76
	bl loc_02300878	; 02301B78
	add r0,r4,#0x0	; 02301B7C
	pop {r4}	; 02301B7E
	pop {r3}	; 02301B80
	bx r3	; 02301B82
pool_02301B84:
loc_02301B84:
	.word 0x00000101	; 02301B84

; ===== function loc_02301B88 =====
loc_02301B88:
	push {r4,r5,lr}	; 02301B88
	sub sp,#0x4	; 02301B8A
	add r5,r0,#0x0	; 02301B8C
	mov r4,#0x0	; 02301B8E
	strh r4,[r5,#0x0]	; 02301B90
	strh r4,[r5,#0x2]	; 02301B92
	strh r4,[r5,#0x4]	; 02301B94
	strh r4,[r5,#0x6]	; 02301B96
	strh r4,[r5,#0x8]	; 02301B98
	strh r4,[r5,#0xa]	; 02301B9A
	mov r0,#0xa	; 02301B9C
	strh r0,[r5,#0xc]	; 02301B9E
	mov r0,#0xc	; 02301BA0
	strh r0,[r5,#0xe]	; 02301BA2
	strh r4,[r5,#0x10]	; 02301BA4
	strh r1,[r5,#0x12]	; 02301BA6
	strh r2,[r5,#0x14]	; 02301BA8
	strh r3,[r5,#0x16]	; 02301BAA
	ldr r0,[sp,#0x10]	; 02301BAC
	add r1,r5,#0x0	; 02301BAE
	add r1,#0x18	; 02301BB0
	mov r2,#0x10	; 02301BB2
	bl loc_02301BDC	; 02301BB4
	ldrh r0,[r5,#0xe]	; 02301BB8
	lsl r0,r0,#0x1	; 02301BBA
	add r1,r5,r0	; 02301BBC
	add r4,r1,#0x0	; 02301BBE
	add r4,#0x10	; 02301BC0
	ldrh r0,[r5,#0xc]	; 02301BC2
	strh r0,[r1,#0x10]	; 02301BC4
	mov r0,#0x12	; 02301BC6
	strh r0,[r4,#0x2]	; 02301BC8
	add r0,r5,#0x0	; 02301BCA
	bl loc_02300878	; 02301BCC
	add r0,r4,#0x0	; 02301BD0
	add sp,#0x4	; 02301BD2
	pop {r4,r5}	; 02301BD4
	pop {r3}	; 02301BD6
	bx r3	; 02301BD8
	.byte 0xC0, 0x46	; 02301BDC

; ===== function loc_02301BDC =====
loc_02301BDC:
	bx pc	; 02301BDC
	.byte 0xC0, 0x46	; 02301BE0
.arm

; ===== function loc_02301BE0 =====
loc_02301BE0:
	ldr pc,[pool_02301BE4]	; 02301BE0
pool_02301BE4:
loc_02301BE4:
	.word P2_Entry_037FF334	; 02301BE4
.thumb

; ===== function loc_02301BE8 =====
loc_02301BE8:
	push {r4,r5,r6,r7,lr}	; 02301BE8
	sub sp,#0x4	; 02301BEA
	add r5,r0,#0x0	; 02301BEC
	add r4,r1,#0x0	; 02301BEE
	add r7,r2,#0x0	; 02301BF0
	add r6,r3,#0x0	; 02301BF2
	mov r0,#0x0	; 02301BF4
	strh r0,[r5,#0x0]	; 02301BF6
	strh r0,[r5,#0x2]	; 02301BF8
	strh r0,[r5,#0x4]	; 02301BFA
	strh r0,[r5,#0x6]	; 02301BFC
	strh r0,[r5,#0x8]	; 02301BFE
	strh r0,[r5,#0xa]	; 02301C00
	mov r0,#0x9	; 02301C02
	strh r0,[r5,#0xc]	; 02301C04
	add r0,sp,#0x8	; 02301C06
	ldrh r0,[r0,#0x20]	; 02301C08
	add r0,r0,#0x1	; 02301C0A
	mov r1,#0x2	; 02301C0C
	bl loc_02301C68	; 02301C0E
	add r0,#0x17	; 02301C12
	strh r0,[r5,#0xe]	; 02301C14
	strh r4,[r5,#0x10]	; 02301C16
	add r0,r7,#0x0	; 02301C18
	add r1,r5,#0x0	; 02301C1A
	add r1,#0x12	; 02301C1C
	mov r2,#0x20	; 02301C1E
	bl loc_02301C74	; 02301C20
	strh r6,[r5,#0x32]	; 02301C24
	add r0,sp,#0x8	; 02301C26
	ldrh r1,[r0,#0x10]	; 02301C28
	strh r1,[r5,#0x34]	; 02301C2A
	ldrh r1,[r0,#0x14]	; 02301C2C
	strh r1,[r5,#0x36]	; 02301C2E
	ldrh r1,[r0,#0x18]	; 02301C30
	strh r1,[r5,#0x38]	; 02301C32
	ldrh r1,[r0,#0x1c]	; 02301C34
	strh r1,[r5,#0x3a]	; 02301C36
	ldrh r2,[r0,#0x20]	; 02301C38
	strh r2,[r5,#0x3c]	; 02301C3A
	ldr r0,[sp,#0x2c]	; 02301C3C
	add r1,r5,#0x0	; 02301C3E
	add r1,#0x3e	; 02301C40
	bl loc_02301C80	; 02301C42
	ldrh r0,[r5,#0xe]	; 02301C46
	lsl r0,r0,#0x1	; 02301C48
	add r1,r5,r0	; 02301C4A
	add r4,r1,#0x0	; 02301C4C
	add r4,#0x10	; 02301C4E
	ldrh r0,[r5,#0xc]	; 02301C50
	strh r0,[r1,#0x10]	; 02301C52
	mov r0,#0x1	; 02301C54
	strh r0,[r4,#0x2]	; 02301C56
	add r0,r5,#0x0	; 02301C58
	bl loc_02300878	; 02301C5A
	add r0,r4,#0x0	; 02301C5E
	add sp,#0x4	; 02301C60
	pop {r4,r5,r6,r7}	; 02301C62
	pop {r3}	; 02301C64
	bx r3	; 02301C66

; ===== function loc_02301C68 =====
loc_02301C68:
	bx pc	; 02301C68
	.byte 0xC0, 0x46	; 02301C6C
.arm

; ===== function loc_02301C6C =====
loc_02301C6C:
	ldr pc,[pool_02301C70]	; 02301C6C
pool_02301C70:
loc_02301C70:
	.word P2_SignedDivMod	; 02301C70
.thumb

; ===== function loc_02301C74 =====
loc_02301C74:
	bx pc	; 02301C74
	.byte 0xC0, 0x46	; 02301C78
.arm

; ===== function loc_02301C78 =====
loc_02301C78:
	ldr pc,[pool_02301C7C]	; 02301C78
pool_02301C7C:
loc_02301C7C:
	.word P2_Entry_037FF334	; 02301C7C
.thumb

; ===== function loc_02301C80 =====
loc_02301C80:
	bx pc	; 02301C80
	.byte 0xC0, 0x46	; 02301C84
.arm

; ===== function loc_02301C84 =====
loc_02301C84:
	ldr pc,[pool_02301C88]	; 02301C84
pool_02301C88:
loc_02301C88:
	.word P2_Entry_037FF334	; 02301C88
.thumb

; ===== function loc_02301C8C =====
loc_02301C8C:
	push {r4,r5,r6,lr}	; 02301C8C
	add r5,r0,#0x0	; 02301C8E
	add r4,r2,#0x0	; 02301C90
	add r6,r3,#0x0	; 02301C92
	mov r0,#0x0	; 02301C94
	strh r0,[r5,#0x0]	; 02301C96
	strh r0,[r5,#0x2]	; 02301C98
	strh r0,[r5,#0x4]	; 02301C9A
	strh r0,[r5,#0x6]	; 02301C9C
	strh r0,[r5,#0x8]	; 02301C9E
	strh r0,[r5,#0xa]	; 02301CA0
	mov r2,#0x6	; 02301CA2
	strh r2,[r5,#0xc]	; 02301CA4
	mov r0,#0x5	; 02301CA6
	strh r0,[r5,#0xe]	; 02301CA8
	add r0,r1,#0x0	; 02301CAA
	add r1,r5,#0x0	; 02301CAC
	add r1,#0x10	; 02301CAE
	bl loc_02301CD8	; 02301CB0
	strh r4,[r5,#0x16]	; 02301CB4
	strh r6,[r5,#0x18]	; 02301CB6
	ldrh r0,[r5,#0xe]	; 02301CB8
	lsl r0,r0,#0x1	; 02301CBA
	add r1,r5,r0	; 02301CBC
	add r4,r1,#0x0	; 02301CBE
	add r4,#0x10	; 02301CC0
	ldrh r0,[r5,#0xc]	; 02301CC2
	strh r0,[r1,#0x10]	; 02301CC4
	mov r0,#0x3	; 02301CC6
	strh r0,[r4,#0x2]	; 02301CC8
	add r0,r5,#0x0	; 02301CCA
	bl loc_02300878	; 02301CCC
	add r0,r4,#0x0	; 02301CD0
	pop {r4,r5,r6}	; 02301CD2
	pop {r3}	; 02301CD4
	bx r3	; 02301CD6

; ===== function loc_02301CD8 =====
loc_02301CD8:
	bx pc	; 02301CD8
	.byte 0xC0, 0x46	; 02301CDC
.arm

; ===== function loc_02301CDC =====
loc_02301CDC:
	ldr pc,[pool_02301CE0]	; 02301CDC
pool_02301CE0:
loc_02301CE0:
	.word P2_Entry_037FF334	; 02301CE0
.thumb

; ===== function loc_02301CE4 =====
loc_02301CE4:
	push {r4,r5,lr}	; 02301CE4
	sub sp,#0x4	; 02301CE6
	add r4,r0,#0x0	; 02301CE8
	add r5,r2,#0x0	; 02301CEA
	mov r0,#0x0	; 02301CEC
	strh r0,[r4,#0x0]	; 02301CEE
	strh r0,[r4,#0x2]	; 02301CF0
	strh r0,[r4,#0x4]	; 02301CF2
	strh r0,[r4,#0x6]	; 02301CF4
	strh r0,[r4,#0x8]	; 02301CF6
	strh r0,[r4,#0xa]	; 02301CF8
	mov r0,#0x5	; 02301CFA
	strh r0,[r4,#0xc]	; 02301CFC
	mov r0,#0x4	; 02301CFE
	strh r0,[r4,#0xe]	; 02301D00
	add r0,r1,#0x0	; 02301D02
	add r1,r4,#0x0	; 02301D04
	add r1,#0x10	; 02301D06
	mov r2,#0x6	; 02301D08
	bl loc_02301D34	; 02301D0A
	strh r5,[r4,#0x16]	; 02301D0E
	ldrh r0,[r4,#0xe]	; 02301D10
	lsl r0,r0,#0x1	; 02301D12
	add r1,r4,r0	; 02301D14
	add r5,r1,#0x0	; 02301D16
	add r5,#0x10	; 02301D18
	ldrh r0,[r4,#0xc]	; 02301D1A
	strh r0,[r1,#0x10]	; 02301D1C
	mov r0,#0x4	; 02301D1E
	strh r0,[r5,#0x2]	; 02301D20
	add r0,r4,#0x0	; 02301D22
	bl loc_02300878	; 02301D24
	add r0,r5,#0x0	; 02301D28
	add sp,#0x4	; 02301D2A
	pop {r4,r5}	; 02301D2C
	pop {r3}	; 02301D2E
	bx r3	; 02301D30
	.byte 0xC0, 0x46	; 02301D34

; ===== function loc_02301D34 =====
loc_02301D34:
	bx pc	; 02301D34
	.byte 0xC0, 0x46	; 02301D38
.arm

; ===== function loc_02301D38 =====
loc_02301D38:
	ldr pc,[pool_02301D3C]	; 02301D38
pool_02301D3C:
loc_02301D3C:
	.word P2_Entry_037FF334	; 02301D3C
.thumb

; ===== function loc_02301D40 =====
loc_02301D40:
	push {r4,r5,r6,lr}	; 02301D40
	add r5,r0,#0x0	; 02301D42
	add r4,r2,#0x0	; 02301D44
	add r6,r3,#0x0	; 02301D46
	mov r0,#0x0	; 02301D48
	strh r0,[r5,#0x0]	; 02301D4A
	strh r0,[r5,#0x2]	; 02301D4C
	strh r0,[r5,#0x4]	; 02301D4E
	strh r0,[r5,#0x6]	; 02301D50
	strh r0,[r5,#0x8]	; 02301D52
	strh r0,[r5,#0xa]	; 02301D54
	mov r0,#0x4	; 02301D56
	strh r0,[r5,#0xc]	; 02301D58
	mov r0,#0x5	; 02301D5A
	strh r0,[r5,#0xe]	; 02301D5C
	add r0,r1,#0x0	; 02301D5E
	add r1,r5,#0x0	; 02301D60
	add r1,#0x10	; 02301D62
	mov r2,#0x6	; 02301D64
	bl loc_02301D90	; 02301D66
	strh r4,[r5,#0x16]	; 02301D6A
	strh r6,[r5,#0x18]	; 02301D6C
	ldrh r0,[r5,#0xe]	; 02301D6E
	lsl r0,r0,#0x1	; 02301D70
	add r1,r5,r0	; 02301D72
	add r4,r1,#0x0	; 02301D74
	add r4,#0x10	; 02301D76
	ldrh r0,[r5,#0xc]	; 02301D78
	strh r0,[r1,#0x10]	; 02301D7A
	mov r0,#0x6	; 02301D7C
	strh r0,[r4,#0x2]	; 02301D7E
	add r0,r5,#0x0	; 02301D80
	bl loc_02300878	; 02301D82
	add r0,r4,#0x0	; 02301D86
	pop {r4,r5,r6}	; 02301D88
	pop {r3}	; 02301D8A
	bx r3	; 02301D8C
	.byte 0xC0, 0x46	; 02301D90

; ===== function loc_02301D90 =====
loc_02301D90:
	bx pc	; 02301D90
	.byte 0xC0, 0x46	; 02301D94
.arm

; ===== function loc_02301D94 =====
loc_02301D94:
	ldr pc,[pool_02301D98]	; 02301D94
pool_02301D98:
loc_02301D98:
	.word P2_Entry_037FF334	; 02301D98
.thumb

; ===== function loc_02301D9C =====
loc_02301D9C:
	push {r4,r5,lr}	; 02301D9C
	sub sp,#0x4	; 02301D9E
	add r5,r0,#0x0	; 02301DA0
	mov r3,#0x0	; 02301DA2
	strh r3,[r5,#0x0]	; 02301DA4
	strh r3,[r5,#0x2]	; 02301DA6
	strh r3,[r5,#0x4]	; 02301DA8
	strh r3,[r5,#0x6]	; 02301DAA
	strh r3,[r5,#0x8]	; 02301DAC
	strh r3,[r5,#0xa]	; 02301DAE
	mov r0,#0x3	; 02301DB0
	strh r0,[r5,#0xc]	; 02301DB2
	mov r0,#0x22	; 02301DB4
	strh r0,[r5,#0xe]	; 02301DB6
	strh r1,[r5,#0x10]	; 02301DB8
	strh r3,[r5,#0x12]	; 02301DBA
	add r0,r2,#0x0	; 02301DBC
	add r1,r5,#0x0	; 02301DBE
	add r1,#0x14	; 02301DC0
	mov r2,#0x44	; 02301DC2
	bl loc_02301DEC	; 02301DC4
	ldrh r0,[r5,#0xe]	; 02301DC8
	lsl r0,r0,#0x1	; 02301DCA
	add r1,r5,r0	; 02301DCC
	add r4,r1,#0x0	; 02301DCE
	add r4,#0x10	; 02301DD0
	ldrh r0,[r5,#0xc]	; 02301DD2
	strh r0,[r1,#0x10]	; 02301DD4
	mov r0,#0x5	; 02301DD6
	strh r0,[r4,#0x2]	; 02301DD8
	add r0,r5,#0x0	; 02301DDA
	bl loc_02300878	; 02301DDC
	add r0,r4,#0x0	; 02301DE0
	add sp,#0x4	; 02301DE2
	pop {r4,r5}	; 02301DE4
	pop {r3}	; 02301DE6
	bx r3	; 02301DE8
	.byte 0xC0, 0x46	; 02301DEC

; ===== function loc_02301DEC =====
loc_02301DEC:
	bx pc	; 02301DEC
	.byte 0xC0, 0x46	; 02301DF0
.arm

; ===== function loc_02301DF0 =====
loc_02301DF0:
	ldr pc,[pool_02301DF4]	; 02301DF0
pool_02301DF4:
loc_02301DF4:
	.word P2_Entry_037FF334	; 02301DF4
.thumb

; ===== function loc_02301DF8 =====
loc_02301DF8:
	push {r4,r5,r6,lr}	; 02301DF8
	add r4,r0,#0x0	; 02301DFA
	add r6,r1,#0x0	; 02301DFC
	add r5,r3,#0x0	; 02301DFE
	mov r0,#0x0	; 02301E00
	strh r0,[r4,#0x0]	; 02301E02
	strh r0,[r4,#0x2]	; 02301E04
	strh r0,[r4,#0x4]	; 02301E06
	strh r0,[r4,#0x6]	; 02301E08
	strh r0,[r4,#0x8]	; 02301E0A
	strh r0,[r4,#0xa]	; 02301E0C
	mov r0,#0x2	; 02301E0E
	strh r0,[r4,#0xc]	; 02301E10
	mov r0,#0x1f	; 02301E12
	strh r0,[r4,#0xe]	; 02301E14
	add r0,r2,#0x0	; 02301E16
	add r1,r4,#0x0	; 02301E18
	add r1,#0x10	; 02301E1A
	mov r2,#0x6	; 02301E1C
	bl loc_02301E78	; 02301E1E
	strh r5,[r4,#0x16]	; 02301E22
	ldr r0,[sp,#0x10]	; 02301E24
	add r1,r4,#0x0	; 02301E26
	add r1,#0x18	; 02301E28
	mov r2,#0x20	; 02301E2A
	bl loc_02301E84	; 02301E2C
	add r0,sp,#0x0	; 02301E30
	ldrh r0,[r0,#0x14]	; 02301E32
	strh r0,[r4,#0x38]	; 02301E34
	ldr r0,[sp,#0x18]	; 02301E36
	add r1,r4,#0x0	; 02301E38
	add r1,#0x3a	; 02301E3A
	mov r2,#0x10	; 02301E3C
	bl loc_02301E90	; 02301E3E
	add r0,sp,#0x0	; 02301E42
	ldrh r1,[r0,#0x1c]	; 02301E44
	add r0,r4,#0x0	; 02301E46
	add r0,#0x4a	; 02301E48
	strh r1,[r0,#0x0]	; 02301E4A
	mov r1,#0x0	; 02301E4C
	add r0,r4,#0x0	; 02301E4E
	add r0,#0x4c	; 02301E50
	strh r1,[r0,#0x0]	; 02301E52
	ldrh r0,[r4,#0xe]	; 02301E54
	lsl r0,r0,#0x1	; 02301E56
	add r1,r4,r0	; 02301E58
	add r5,r1,#0x0	; 02301E5A
	add r5,#0x10	; 02301E5C
	ldrh r0,[r4,#0xc]	; 02301E5E
	strh r0,[r1,#0x10]	; 02301E60
	lsr r0,r6,#0x1	; 02301E62
	sub r0,#0x2c	; 02301E64
	strh r0,[r5,#0x2]	; 02301E66
	add r0,r4,#0x0	; 02301E68
	bl loc_02300878	; 02301E6A
	add r0,r5,#0x0	; 02301E6E
	pop {r4,r5,r6}	; 02301E70
	pop {r3}	; 02301E72
	bx r3	; 02301E74
	.byte 0xC0, 0x46	; 02301E78

; ===== function loc_02301E78 =====
loc_02301E78:
	bx pc	; 02301E78
	.byte 0xC0, 0x46	; 02301E7C
.arm

; ===== function loc_02301E7C =====
loc_02301E7C:
	ldr pc,[pool_02301E80]	; 02301E7C
pool_02301E80:
loc_02301E80:
	.word P2_Entry_037FF334	; 02301E80
.thumb

; ===== function loc_02301E84 =====
loc_02301E84:
	bx pc	; 02301E84
	.byte 0xC0, 0x46	; 02301E88
.arm

; ===== function loc_02301E88 =====
loc_02301E88:
	ldr pc,[pool_02301E8C]	; 02301E88
pool_02301E8C:
loc_02301E8C:
	.word P2_Entry_037FF334	; 02301E8C
.thumb

; ===== function loc_02301E90 =====
loc_02301E90:
	bx pc	; 02301E90
	.byte 0xC0, 0x46	; 02301E94
.arm

; ===== function loc_02301E94 =====
loc_02301E94:
	ldr pc,[pool_02301E98]	; 02301E94
pool_02301E98:
loc_02301E98:
	.word P2_Entry_037FF334	; 02301E98
.thumb

; ===== function loc_02301E9C =====
loc_02301E9C:
	push {r4,r5,lr}	; 02301E9C
	sub sp,#0x4	; 02301E9E
	mov r4,#0x0	; 02301EA0
	strh r4,[r0,#0x0]	; 02301EA2
	strh r4,[r0,#0x2]	; 02301EA4
	strh r4,[r0,#0x4]	; 02301EA6
	strh r4,[r0,#0x6]	; 02301EA8
	strh r4,[r0,#0x8]	; 02301EAA
	strh r4,[r0,#0xa]	; 02301EAC
	mov r4,#0x1	; 02301EAE
	strh r4,[r0,#0xc]	; 02301EB0
	mov r5,#0x3	; 02301EB2
	strh r5,[r0,#0xe]	; 02301EB4
	strh r1,[r0,#0x10]	; 02301EB6
	strh r2,[r0,#0x12]	; 02301EB8
	strh r3,[r0,#0x14]	; 02301EBA
	ldrh r1,[r0,#0xe]	; 02301EBC
	lsl r1,r1,#0x1	; 02301EBE
	add r2,r0,r1	; 02301EC0
	add r5,r2,#0x0	; 02301EC2
	add r5,#0x10	; 02301EC4
	ldrh r1,[r0,#0xc]	; 02301EC6
	strh r1,[r2,#0x10]	; 02301EC8
	strh r4,[r5,#0x2]	; 02301ECA
	bl loc_02300878	; 02301ECC
	add r0,r5,#0x0	; 02301ED0
	add sp,#0x4	; 02301ED2
	pop {r4,r5}	; 02301ED4
	pop {r3}	; 02301ED6
	bx r3	; 02301ED8
	.byte 0x00, 0x00	; 02301EDC

; ===== function loc_02301EDC =====
loc_02301EDC:
	push {r4,lr}	; 02301EDC
	mov r2,#0x0	; 02301EDE
	strh r2,[r0,#0x0]	; 02301EE0
	strh r2,[r0,#0x2]	; 02301EE2
	strh r2,[r0,#0x4]	; 02301EE4
	strh r2,[r0,#0x6]	; 02301EE6
	strh r2,[r0,#0x8]	; 02301EE8
	strh r2,[r0,#0xa]	; 02301EEA
	strh r2,[r0,#0xc]	; 02301EEC
	mov r2,#0x1	; 02301EEE
	strh r2,[r0,#0xe]	; 02301EF0
	strh r1,[r0,#0x10]	; 02301EF2
	ldrh r1,[r0,#0xe]	; 02301EF4
	lsl r1,r1,#0x1	; 02301EF6
	add r3,r0,r1	; 02301EF8
	add r4,r3,#0x0	; 02301EFA
	add r4,#0x10	; 02301EFC
	ldrh r1,[r0,#0xc]	; 02301EFE
	strh r1,[r3,#0x10]	; 02301F00
	strh r2,[r4,#0x2]	; 02301F02
	bl loc_02300878	; 02301F04
	add r0,r4,#0x0	; 02301F08
	pop {r4}	; 02301F0A
	pop {r3}	; 02301F0C
	bx r3	; 02301F0E

; ===== function loc_02301F10 =====
	push {r4,r5,lr}	; 02301F10
	sub sp,#0x4	; 02301F12
	add r5,r0,#0x0	; 02301F14
	bl P4_GetRuntimeState	; 02301F16
	ldr r2,[r5,#0x4]	; 02301F1A
	ldr r1,[pool_02301F84]	; 02301F1C
	add r0,r0,r1	; 02301F1E
	str r2,[r0,#0x0]	; 02301F20
	ldr r4,[r0,#0x0]	; 02301F22
	ldr r0,[r5,#0x8]	; 02301F24
	str r0,[r4,#0x0]	; 02301F26
	ldr r0,[r5,#0xc]	; 02301F28
	str r0,[r4,#0x8]	; 02301F2A
	bl loc_02304598	; 02301F2C
	mov r0,#0xf	; 02301F30
	bl loc_02301F88	; 02301F32
	mov r1,#0x1	; 02301F36
	ldr r0,[r4,#0x0]	; 02301F38
	strh r1,[r0,#0x0]	; 02301F3A
	add r0,sp,#0x0	; 02301F3C
	add r1,sp,#0x0	; 02301F3E
	add r1,#0x2	; 02301F40
	bl loc_023046F4	; 02301F42
	cmp r0,#0x0	; 02301F46
	bne loc_02301F66	; 02301F48
	bl P4_AcquireCommandSlot	; 02301F4A
	mov r1,#0x0	; 02301F4E
	strh r1,[r0,#0x0]	; 02301F50
	mov r1,#0x1	; 02301F52
	strh r1,[r0,#0x2]	; 02301F54
	add r1,sp,#0x0	; 02301F56
	ldrh r2,[r1,#0x0]	; 02301F58
	strh r2,[r0,#0x4]	; 02301F5A
	ldrh r1,[r1,#0x2]	; 02301F5C
	strh r1,[r0,#0x6]	; 02301F5E
	bl P4_SubmitCommandSlot	; 02301F60
	b loc_02301F7A	; 02301F64
loc_02301F66:
	mov r1,#0x2	; 02301F66
	ldr r0,[r4,#0x0]	; 02301F68
	strh r1,[r0,#0x0]	; 02301F6A
	bl P4_AcquireCommandSlot	; 02301F6C
	mov r1,#0x0	; 02301F70
	strh r1,[r0,#0x0]	; 02301F72
	strh r1,[r0,#0x2]	; 02301F74
	bl P4_SubmitCommandSlot	; 02301F76
loc_02301F7A:
	add sp,#0x4	; 02301F7A
	pop {r4,r5}	; 02301F7C
	pop {r3}	; 02301F7E
	bx r3	; 02301F80
	.byte 0xC0, 0x46	; 02301F84
pool_02301F84:
loc_02301F84:
	.word 0x00001518	; 02301F84

; ===== function loc_02301F88 =====
loc_02301F88:
	bx pc	; 02301F88
	.byte 0xC0, 0x46	; 02301F8C
.arm

; ===== function loc_02301F8C =====
loc_02301F8C:
	ldr r12,[pool_02301F94]	; 02301F8C
	bx r12	; 02301F90
pool_02301F94:
loc_02301F94:
	.word loc_038047BC + 1	; 02301F94
.thumb

; ===== function loc_02301F98 =====
loc_02301F98:
	push {r4,r5,lr}	; 02301F98
	sub sp,#0x4	; 02301F9A
	add r5,r0,#0x0	; 02301F9C
	add r4,r1,#0x0	; 02301F9E
	bl P4_AcquireCommandSlot	; 02301FA0
	mov r1,#0x1	; 02301FA4
	strh r1,[r0,#0x0]	; 02301FA6
	strh r1,[r0,#0x2]	; 02301FA8
	strh r5,[r0,#0x4]	; 02301FAA
	strh r4,[r0,#0x6]	; 02301FAC
	bl P4_SubmitCommandSlot	; 02301FAE
	add sp,#0x4	; 02301FB2
	pop {r4,r5}	; 02301FB4
	pop {r3}	; 02301FB6
	bx r3	; 02301FB8
	.byte 0x00, 0x00	; 02301FBC
	push {r4,r5,r6,r7,lr}	; 02301FBC
	sub sp,#0x1fc	; 02301FBE
	sub sp,#0x10	; 02301FC0
	bl P4_GetRuntimeState	; 02301FC2
	ldr r1,[pool_023020BC]	; 02301FC6
	ldr r5,[r0,r1]	; 02301FC8
	add r7,sp,#0xc	; 02301FCA
	mov r1,#0x0	; 02301FCC
	ldr r0,[r5,#0x0]	; 02301FCE
	str r1,[r0,#0x10]	; 02301FD0
	ldr r0,[r5,#0x0]	; 02301FD2
	str r1,[r0,#0x18]	; 02301FD4
	ldr r0,[r5,#0x0]	; 02301FD6
	str r1,[r0,#0x14]	; 02301FD8
	add r0,r7,#0x0	; 02301FDA
	bl loc_023018D0	; 02301FDC
	ldrh r1,[r0,#0x4]	; 02301FE0
	cmp r1,#0x0	; 02301FE2
	beq loc_02301FEE	; 02301FE4
	ldr r0,[pool_023020C0]	; 02301FE6
	bl loc_02301F98	; 02301FE8
	b loc_023020B0	; 02301FEC
loc_02301FEE:
	ldrh r4,[r0,#0x6]	; 02301FEE
	add r0,r7,#0x0	; 02301FF0
	bl loc_02301950	; 02301FF2
	ldrh r1,[r0,#0x4]	; 02301FF6
	cmp r1,#0x0	; 02301FF8
	beq loc_02302004	; 02301FFA
	ldr r0,[pool_023020C0]	; 02301FFC
	bl loc_02301F98	; 02301FFE
	b loc_023020B0	; 02302002
loc_02302004:
	ldrh r6,[r0,#0x6]	; 02302004
	cmp r4,#0x20	; 02302006
	bgt loc_0230201E	; 02302008
	cmp r4,#0x20	; 0230200A
	bge loc_0230204E	; 0230200C
	cmp r4,#0x0	; 0230200E
	bgt loc_02302018	; 02302010
	cmp r4,#0x0	; 02302012
	beq loc_02302064	; 02302014
	b loc_0230209A	; 02302016
loc_02302018:
	cmp r4,#0x10	; 02302018
	beq loc_02302078	; 0230201A
	b loc_0230209A	; 0230201C
loc_0230201E:
	cmp r4,#0x30	; 0230201E
	bgt loc_02302028	; 02302020
	cmp r4,#0x30	; 02302022
	beq loc_0230202C	; 02302024
	b loc_0230209A	; 02302026
loc_02302028:
	cmp r4,#0x40	; 02302028
	bne loc_0230209A	; 0230202A
loc_0230202C:
	ldr r0,[pool_023020C4]	; 0230202C
	add r0,r6,r0	; 0230202E
	lsl r0,r0,#0x10	; 02302030
	lsr r0,r0,#0x10	; 02302032
	cmp r0,#0x1	; 02302034
	bhi loc_0230204E	; 02302036
	add r0,sp,#0x4	; 02302038
	ldr r2,[r5,#0x0]	; 0230203A
	ldr r1,[pool_023020C8]	; 0230203C
	add r1,r2,r1	; 0230203E
	bl loc_02300800	; 02302040
	add r0,r7,#0x0	; 02302044
	add r1,sp,#0x4	; 02302046
	mov r2,#0x3	; 02302048
	bl loc_02301CE4	; 0230204A
loc_0230204E:
	add r0,r7,#0x0	; 0230204E
	mov r1,#0x1	; 02302050
	bl loc_02301EDC	; 02302052
	ldrh r1,[r0,#0x4]	; 02302056
	cmp r1,#0x0	; 02302058
	beq loc_02302064	; 0230205A
	mov r0,#0x0	; 0230205C
	bl loc_02301F98	; 0230205E
	b loc_023020B0	; 02302062
loc_02302064:
	add r0,r7,#0x0	; 02302064
	bl loc_02301930	; 02302066
	ldrh r1,[r0,#0x4]	; 0230206A
	cmp r1,#0x0	; 0230206C
	beq loc_02302078	; 0230206E
	ldr r0,[pool_023020CC]	; 02302070
	bl loc_02301F98	; 02302072
	b loc_023020B0	; 02302076
loc_02302078:
	cmp r6,#0x0	; 02302078
	bne loc_0230209A	; 0230207A
	mov r0,#0x1	; 0230207C
	str r0,[sp,#0x0]	; 0230207E
	add r0,r7,#0x0	; 02302080
	mov r1,#0x0	; 02302082
	add r2,r1,#0x0	; 02302084
	mov r3,#0x14	; 02302086
	bl loc_02301884	; 02302088
	ldrh r1,[r0,#0x4]	; 0230208C
	cmp r1,#0x0	; 0230208E
	beq loc_0230209A	; 02302090
	ldr r0,[pool_023020D0]	; 02302092
	bl loc_02301F98	; 02302094
	b loc_023020B0	; 02302098
loc_0230209A:
	mov r1,#0x2	; 0230209A
	ldr r0,[r5,#0x0]	; 0230209C
	strh r1,[r0,#0x0]	; 0230209E
	bl P4_AcquireCommandSlot	; 023020A0
	mov r1,#0x1	; 023020A4
	strh r1,[r0,#0x0]	; 023020A6
	mov r1,#0x0	; 023020A8
	strh r1,[r0,#0x2]	; 023020AA
	bl P4_SubmitCommandSlot	; 023020AC
loc_023020B0:
	add sp,#0x1fc	; 023020B0
	add sp,#0x10	; 023020B2
	pop {r4,r5,r6,r7}	; 023020B4
	pop {r3}	; 023020B6
	bx r3	; 023020B8
	.byte 0xC0, 0x46	; 023020BC
pool_023020BC:
loc_023020BC:
	.word 0x00001518	; 023020BC
pool_023020C0:
loc_023020C0:
	.word 0x00000308	; 023020C0
pool_023020C4:
loc_023020C4:
	.word 0x0000FFFE	; 023020C4
pool_023020C8:
loc_023020C8:
	.word 0x0000018A	; 023020C8
pool_023020CC:
loc_023020CC:
	.word 0x00000302	; 023020CC
pool_023020D0:
loc_023020D0:
	.word 0x00000309	; 023020D0

; ===== function loc_023020D4 =====
loc_023020D4:
	push {r4,r5,lr}	; 023020D4
	sub sp,#0x4	; 023020D6
	add r5,r0,#0x0	; 023020D8
	add r4,r1,#0x0	; 023020DA
	bl P4_AcquireCommandSlot	; 023020DC
	mov r1,#0x2	; 023020E0
	strh r1,[r0,#0x0]	; 023020E2
	mov r1,#0x1	; 023020E4
	strh r1,[r0,#0x2]	; 023020E6
	strh r5,[r0,#0x4]	; 023020E8
	strh r4,[r0,#0x6]	; 023020EA
	bl P4_SubmitCommandSlot	; 023020EC
	add sp,#0x4	; 023020F0
	pop {r4,r5}	; 023020F2
	pop {r3}	; 023020F4
	bx r3	; 023020F6

; ===== function loc_023020F8 =====
	push {r4,lr}	; 023020F8
	sub sp,#0x1fc	; 023020FA
	sub sp,#0x4	; 023020FC
	bl P4_GetRuntimeState	; 023020FE
	ldr r1,[pool_02302160]	; 02302102
	ldr r4,[r0,r1]	; 02302104
	ldr r0,[r4,#0x0]	; 02302106
	ldrh r0,[r0,#0x0]	; 02302108
	cmp r0,#0x2	; 0230210A
	beq loc_02302120	; 0230210C
	bl P4_AcquireCommandSlot	; 0230210E
	mov r1,#0x2	; 02302112
	strh r1,[r0,#0x0]	; 02302114
	mov r1,#0x3	; 02302116
	strh r1,[r0,#0x2]	; 02302118
	bl P4_SubmitCommandSlot	; 0230211A
	b loc_02302154	; 0230211E
loc_02302120:
	add r0,sp,#0x0	; 02302120
	bl loc_02301940	; 02302122
	ldrh r1,[r0,#0x4]	; 02302126
	cmp r1,#0x0	; 02302128
	beq loc_02302134	; 0230212A
	ldr r0,[pool_02302164]	; 0230212C
	bl loc_023020D4	; 0230212E
	b loc_02302154	; 02302132
loc_02302134:
	mov r0,#0x1	; 02302134
	ldr r1,[r4,#0x0]	; 02302136
	strh r0,[r1,#0x0]	; 02302138
	bl loc_02301F88	; 0230213A
	mov r1,#0x0	; 0230213E
	ldr r0,[r4,#0x0]	; 02302140
	strh r1,[r0,#0x0]	; 02302142
	bl P4_AcquireCommandSlot	; 02302144
	mov r1,#0x2	; 02302148
	strh r1,[r0,#0x0]	; 0230214A
	mov r1,#0x0	; 0230214C
	strh r1,[r0,#0x2]	; 0230214E
	bl P4_SubmitCommandSlot	; 02302150
loc_02302154:
	add sp,#0x1fc	; 02302154
	add sp,#0x4	; 02302156
	pop {r4}	; 02302158
	pop {r3}	; 0230215A
	bx r3	; 0230215C
	.byte 0xC0, 0x46	; 02302160
pool_02302160:
loc_02302160:
	.word 0x00001518	; 02302160
pool_02302164:
loc_02302164:
	.word 0x00000301	; 02302164

; ===== function loc_02302168 =====
loc_02302168:
	push {r4,r5,lr}	; 02302168
	sub sp,#0x4	; 0230216A
	add r5,r0,#0x0	; 0230216C
	add r4,r1,#0x0	; 0230216E
	bl P4_AcquireCommandSlot	; 02302170
	mov r1,#0x7	; 02302174
	strh r1,[r0,#0x0]	; 02302176
	mov r1,#0x1	; 02302178
	strh r1,[r0,#0x2]	; 0230217A
	strh r5,[r0,#0x4]	; 0230217C
	strh r4,[r0,#0x6]	; 0230217E
	bl P4_SubmitCommandSlot	; 02302180
	add sp,#0x4	; 02302184
	pop {r4,r5}	; 02302186
	pop {r3}	; 02302188
	bx r3	; 0230218A

; ===== function loc_0230218C =====
	push {r4,r5,lr}	; 0230218C
	sub sp,#0x1fc	; 0230218E
	sub sp,#0x8	; 02302190
	add r5,r0,#0x0	; 02302192
	bl P4_GetRuntimeState	; 02302194
	ldr r1,[pool_02302208]	; 02302198
	ldr r4,[r0,r1]	; 0230219A
	bl P4_GetRuntimeState	; 0230219C
	ldr r1,[pool_0230220C]	; 023021A0
	ldr r0,[r0,r1]	; 023021A2
	ldr r1,[r5,#0x4]	; 023021A4
	ldr r2,[r4,#0x0]	; 023021A6
	add r2,#0xe8	; 023021A8
	mov r3,#0x40	; 023021AA
	bl loc_023006F8	; 023021AC
	ldr r2,[r4,#0x0]	; 023021B0
	mov r1,#0x1	; 023021B2
	ldr r0,[pool_02302210]	; 023021B4
	ldrh r0,[r2,r0]	; 023021B6
	lsl r1,r0	; 023021B8
	ldr r0,[pool_02302214]	; 023021BA
	ldrh r0,[r2,r0]	; 023021BC
	and r1,r0	; 023021BE
	cmp r1,#0x0	; 023021C0
	bne loc_023021D6	; 023021C2
	bl P4_AcquireCommandSlot	; 023021C4
	mov r1,#0x7	; 023021C8
	strh r1,[r0,#0x0]	; 023021CA
	mov r1,#0x6	; 023021CC
	strh r1,[r0,#0x2]	; 023021CE
	bl P4_SubmitCommandSlot	; 023021D0
	b loc_023021FE	; 023021D4
loc_023021D6:
	add r0,sp,#0x0	; 023021D6
	add r2,#0xf6	; 023021D8
	ldrh r1,[r2,#0x0]	; 023021DA
	bl loc_02301A30	; 023021DC
	ldrh r1,[r0,#0x4]	; 023021E0
	cmp r1,#0x0	; 023021E2
	beq loc_023021EE	; 023021E4
	ldr r0,[pool_02302218]	; 023021E6
	bl loc_02302168	; 023021E8
	b loc_023021FE	; 023021EC
loc_023021EE:
	bl P4_AcquireCommandSlot	; 023021EE
	mov r1,#0x7	; 023021F2
	strh r1,[r0,#0x0]	; 023021F4
	mov r1,#0x0	; 023021F6
	strh r1,[r0,#0x2]	; 023021F8
	bl P4_SubmitCommandSlot	; 023021FA
loc_023021FE:
	add sp,#0x1fc	; 023021FE
	add sp,#0x8	; 02302200
	pop {r4,r5}	; 02302202
	pop {r3}	; 02302204
	bx r3	; 02302206
pool_02302208:
loc_02302208:
	.word 0x00001518	; 02302208
pool_0230220C:
loc_0230220C:
	.word 0x0000150C	; 0230220C
pool_02302210:
loc_02302210:
	.word 0x00000118	; 02302210
pool_02302214:
loc_02302214:
	.word 0x000001F4	; 02302214
pool_02302218:
loc_02302218:
	.word 0x00000212	; 02302218

; ===== function loc_0230221C =====
loc_0230221C:
	push {r4,r5,lr}	; 0230221C
	sub sp,#0x4	; 0230221E
	add r5,r0,#0x0	; 02302220
	add r4,r1,#0x0	; 02302222
	bl P4_AcquireCommandSlot	; 02302224
	mov r1,#0x8	; 02302228
	strh r1,[r0,#0x0]	; 0230222A
	mov r1,#0x1	; 0230222C
	strh r1,[r0,#0x2]	; 0230222E
	mov r1,#0x0	; 02302230
	strh r1,[r0,#0x8]	; 02302232
	strh r5,[r0,#0x4]	; 02302234
	strh r4,[r0,#0x6]	; 02302236
	bl P4_SubmitCommandSlot	; 02302238
	add sp,#0x4	; 0230223C
	pop {r4,r5}	; 0230223E
	pop {r3}	; 02302240
	bx r3	; 02302242

; ===== function loc_02302244 =====
	push {r4,r5,r6,lr}	; 02302244
	sub sp,#0x1fc	; 02302246
	sub sp,#0xc4	; 02302248
	add r6,sp,#0x3c	; 0230224A
	bl P4_GetRuntimeState	; 0230224C
	ldr r1,[pool_02302370]	; 02302250
	ldr r5,[r0,r1]	; 02302252
	mov r1,#0x1	; 02302254
	ldr r0,[r5,#0x0]	; 02302256
	add r0,#0xe6	; 02302258
	strh r1,[r0,#0x0]	; 0230225A
	mov r0,#0x0	; 0230225C
	ldr r2,[r5,#0x0]	; 0230225E
	ldr r1,[pool_02302374]	; 02302260
	strh r0,[r2,r1]	; 02302262
	ldr r2,[r5,#0x0]	; 02302264
	ldr r1,[pool_02302378]	; 02302266
	strh r0,[r2,r1]	; 02302268
	ldr r1,[r5,#0x0]	; 0230226A
	add r1,#0x8a	; 0230226C
	strh r0,[r1,#0x0]	; 0230226E
	mov r0,#0x8	; 02302270
	add r1,r6,#0x0	; 02302272
	bl loc_023005B0	; 02302274
	cmp r0,#0x0	; 02302278
	beq loc_02302366	; 0230227A
	add r0,r6,#0x0	; 0230227C
	bl loc_02301920	; 0230227E
	ldrh r1,[r0,#0x4]	; 02302282
	cmp r1,#0x0	; 02302284
	beq loc_02302290	; 02302286
	ldr r0,[pool_0230237C]	; 02302288
	bl loc_0230221C	; 0230228A
	b loc_02302366	; 0230228E
loc_02302290:
	add r0,r6,#0x0	; 02302290
	mov r1,#0x1	; 02302292
	mov r2,#0x0	; 02302294
	add r3,r1,#0x0	; 02302296
	bl loc_02301E9C	; 02302298
	ldrh r1,[r0,#0x4]	; 0230229C
	cmp r1,#0x0	; 0230229E
	beq loc_023022AA	; 023022A0
	mov r0,#0x1	; 023022A2
	bl loc_0230221C	; 023022A4
	b loc_02302366	; 023022A8
loc_023022AA:
	ldr r4,[r5,#0x0]	; 023022AA
	add r4,#0xe8	; 023022AC
	mov r1,#0x0	; 023022AE
	add r0,sp,#0x18	; 023022B0
	strh r1,[r0,#0x0]	; 023022B2
	ldrh r0,[r0,#0x0]	; 023022B4
	add r1,sp,#0x23c	; 023022B6
	mov r2,#0x80	; 023022B8
	bl loc_02302388	; 023022BA
	add r0,sp,#0x23c	; 023022BE
	add r1,r4,#0x0	; 023022C0
	bl loc_02300720	; 023022C2
	mov r1,#0x0	; 023022C6
	add r0,sp,#0x18	; 023022C8
	strh r1,[r0,#0x2]	; 023022CA
	ldrh r0,[r0,#0x2]	; 023022CC
	add r1,sp,#0x1c	; 023022CE
	mov r2,#0x20	; 023022D0
	bl loc_02302394	; 023022D2
	ldrh r1,[r4,#0x6]	; 023022D6
	add r0,sp,#0x18	; 023022D8
	strh r1,[r0,#0x4]	; 023022DA
	ldrh r1,[r4,#0x8]	; 023022DC
	strh r1,[r0,#0x6]	; 023022DE
	ldrh r1,[r4,#0xa]	; 023022E0
	strh r1,[r0,#0x8]	; 023022E2
	mov r1,#0x0	; 023022E4
	strh r1,[r0,#0xa]	; 023022E6
	mov r0,#0x2	; 023022E8
	str r0,[sp,#0x0]	; 023022EA
	ldrh r0,[r4,#0x30]	; 023022EC
	str r0,[sp,#0x4]	; 023022EE
	mov r0,#0x3	; 023022F0
	str r0,[sp,#0x8]	; 023022F2
	str r0,[sp,#0xc]	; 023022F4
	ldrh r0,[r4,#0x4]	; 023022F6
	add r0,#0x10	; 023022F8
	lsl r0,r0,#0x10	; 023022FA
	lsr r0,r0,#0x10	; 023022FC
	str r0,[sp,#0x10]	; 023022FE
	add r0,sp,#0x23c	; 02302300
	str r0,[sp,#0x14]	; 02302302
	add r0,r6,#0x0	; 02302304
	mov r1,#0x20	; 02302306
	add r2,sp,#0x1c	; 02302308
	ldrh r3,[r4,#0x16]	; 0230230A
	bl loc_02301BE8	; 0230230C
	ldrh r1,[r0,#0x4]	; 02302310
	cmp r1,#0x0	; 02302312
	beq loc_0230231E	; 02302314
	mov r0,#0x9	; 02302316
	bl loc_0230221C	; 02302318
	b loc_02302366	; 0230231C
loc_0230231E:
	ldrh r0,[r4,#0x12]	; 0230231E
	cmp r0,#0x0	; 02302320
	beq loc_02302328	; 02302322
	mov r1,#0x2a	; 02302324
	b loc_0230232A	; 02302326
loc_02302328:
	mov r1,#0x0	; 02302328
loc_0230232A:
	ldrh r0,[r4,#0x32]	; 0230232A
	add r0,r0,#0x4	; 0230232C
	add r2,r0,r1	; 0230232E
	ldr r1,[r5,#0x0]	; 02302330
	ldr r0,[pool_02302380]	; 02302332
	strh r2,[r1,r0]	; 02302334
	ldrh r0,[r4,#0x12]	; 02302336
	cmp r0,#0x0	; 02302338
	beq loc_02302340	; 0230233A
	mov r1,#0x6	; 0230233C
	b loc_02302342	; 0230233E
loc_02302340:
	mov r1,#0x0	; 02302340
loc_02302342:
	ldrh r0,[r4,#0x34]	; 02302342
	add r0,r0,#0x2	; 02302344
	add r2,r0,r1	; 02302346
	ldr r1,[r5,#0x0]	; 02302348
	ldr r0,[pool_02302384]	; 0230234A
	strh r2,[r1,r0]	; 0230234C
	bl P4_AcquireCommandSlot	; 0230234E
	mov r2,#0x7	; 02302352
	ldr r1,[r5,#0x0]	; 02302354
	strh r2,[r1,#0x0]	; 02302356
	mov r1,#0x8	; 02302358
	strh r1,[r0,#0x0]	; 0230235A
	mov r1,#0x0	; 0230235C
	strh r1,[r0,#0x2]	; 0230235E
	strh r1,[r0,#0x8]	; 02302360
	bl P4_SubmitCommandSlot	; 02302362
loc_02302366:
	add sp,#0x1fc	; 02302366
	add sp,#0xc4	; 02302368
	pop {r4,r5,r6}	; 0230236A
	pop {r3}	; 0230236C
	bx r3	; 0230236E
pool_02302370:
loc_02302370:
	.word 0x00001518	; 02302370
pool_02302374:
loc_02302374:
	.word 0x00000188	; 02302374
pool_02302378:
loc_02302378:
	.word 0x00000182	; 02302378
pool_0230237C:
loc_0230237C:
	.word 0x00000303	; 0230237C
pool_02302380:
loc_02302380:
	.word 0x00000192	; 02302380
pool_02302384:
loc_02302384:
	.word 0x00000194	; 02302384

; ===== function loc_02302388 =====
loc_02302388:
	bx pc	; 02302388
	.byte 0xC0, 0x46	; 0230238C
.arm

; ===== function loc_0230238C =====
loc_0230238C:
	ldr pc,[pool_02302390]	; 0230238C
pool_02302390:
loc_02302390:
	.word loc_037FF31C	; 02302390
.thumb

; ===== function loc_02302394 =====
loc_02302394:
	bx pc	; 02302394
	.byte 0xC0, 0x46	; 02302398
.arm

; ===== function loc_02302398 =====
loc_02302398:
	ldr pc,[pool_0230239C]	; 02302398
pool_0230239C:
loc_0230239C:
	.word loc_037FF31C	; 0230239C
.thumb

; ===== function loc_023023A0 =====
loc_023023A0:
	push {r4,r5,lr}	; 023023A0
	sub sp,#0x4	; 023023A2
	add r5,r0,#0x0	; 023023A4
	add r4,r1,#0x0	; 023023A6
	bl P4_AcquireCommandSlot	; 023023A8
	mov r1,#0x9	; 023023AC
	strh r1,[r0,#0x0]	; 023023AE
	mov r1,#0x1	; 023023B0
	strh r1,[r0,#0x2]	; 023023B2
	strh r5,[r0,#0x4]	; 023023B4
	strh r4,[r0,#0x6]	; 023023B6
	bl P4_SubmitCommandSlot	; 023023B8
	add sp,#0x4	; 023023BC
	pop {r4,r5}	; 023023BE
	pop {r3}	; 023023C0
	bx r3	; 023023C2

; ===== function loc_023023C4 =====
	push {r4,r5,r6,r7,lr}	; 023023C4
	sub sp,#0x1fc	; 023023C6
	sub sp,#0x10	; 023023C8
	bl P4_GetRuntimeState	; 023023CA
	ldr r1,[pool_02302478]	; 023023CE
	ldr r5,[r0,r1]	; 023023D0
	mov r4,#0x1	; 023023D2
	str r4,[sp,#0x0]	; 023023D4
	ldr r7,[pool_0230247C]	; 023023D6
loc_023023D8:
	ldr r1,[r5,#0x0]	; 023023D8
	ldr r6,[sp,#0x0]	; 023023DA
	lsl r6,r4	; 023023DC
	ldrh r0,[r1,r7]	; 023023DE
	and r0,r6	; 023023E0
	cmp r0,#0x0	; 023023E2
	beq loc_02302418	; 023023E4
	add r0,sp,#0x4	; 023023E6
	ldr r2,[pool_02302480]	; 023023E8
	add r3,r1,r2	; 023023EA
	sub r2,r4,#0x1	; 023023EC
	mov r1,#0x6	; 023023EE
	mul r2,r1	; 023023F0
	add r1,r3,r2	; 023023F2
	bl loc_02300800	; 023023F4
	add r0,sp,#0xc	; 023023F8
	add r1,sp,#0x4	; 023023FA
	mov r2,#0x3	; 023023FC
	bl loc_02301CE4	; 023023FE
	ldr r1,[r5,#0x0]	; 02302402
	ldrh r0,[r1,r7]	; 02302404
	bic r0,r6	; 02302406
	strh r0,[r1,r7]	; 02302408
	ldr r1,[r5,#0x0]	; 0230240A
	add r0,r1,#0x0	; 0230240C
	add r0,#0x8a	; 0230240E
	ldrh r0,[r0,#0x0]	; 02302410
	bic r0,r6	; 02302412
	add r1,#0x8a	; 02302414
	strh r0,[r1,#0x0]	; 02302416
loc_02302418:
	add r4,r4,#0x1	; 02302418
	cmp r4,#0x10	; 0230241A
	blt loc_023023D8	; 0230241C
	add r0,sp,#0xc	; 0230241E
	mov r1,#0x1	; 02302420
	bl loc_02301EDC	; 02302422
	ldrh r1,[r0,#0x4]	; 02302426
	cmp r1,#0x0	; 02302428
	beq loc_02302434	; 0230242A
	mov r0,#0x0	; 0230242C
	bl loc_023023A0	; 0230242E
	b loc_0230246C	; 02302432
loc_02302434:
	add r0,sp,#0xc	; 02302434
	bl loc_02301930	; 02302436
	ldrh r1,[r0,#0x4]	; 0230243A
	cmp r1,#0x0	; 0230243C
	beq loc_02302448	; 0230243E
	ldr r0,[pool_02302484]	; 02302440
	bl loc_023023A0	; 02302442
	b loc_0230246C	; 02302446
loc_02302448:
	mov r1,#0x2	; 02302448
	ldr r0,[r5,#0x0]	; 0230244A
	strh r1,[r0,#0x0]	; 0230244C
	mov r2,#0x0	; 0230244E
	ldr r1,[r5,#0x0]	; 02302450
	ldr r0,[pool_02302488]	; 02302452
	strh r2,[r1,r0]	; 02302454
	ldr r1,[r5,#0x0]	; 02302456
	ldr r0,[pool_0230248C]	; 02302458
	strh r2,[r1,r0]	; 0230245A
	bl P4_AcquireCommandSlot	; 0230245C
	mov r1,#0x9	; 02302460
	strh r1,[r0,#0x0]	; 02302462
	mov r1,#0x0	; 02302464
	strh r1,[r0,#0x2]	; 02302466
	bl P4_SubmitCommandSlot	; 02302468
loc_0230246C:
	add sp,#0x1fc	; 0230246C
	add sp,#0x10	; 0230246E
	pop {r4,r5,r6,r7}	; 02302470
	pop {r3}	; 02302472
	bx r3	; 02302474
	.byte 0xC0, 0x46	; 02302478
pool_02302478:
loc_02302478:
	.word 0x00001518	; 02302478
pool_0230247C:
loc_0230247C:
	.word 0x00000182	; 0230247C
pool_02302480:
loc_02302480:
	.word 0x00000128	; 02302480
pool_02302484:
loc_02302484:
	.word 0x00000302	; 02302484
pool_02302488:
loc_02302488:
	.word 0x00000192	; 02302488
pool_0230248C:
loc_0230248C:
	.word 0x00000194	; 0230248C

; ===== function loc_02302490 =====
loc_02302490:
	push {r4,r5,lr}	; 02302490
	sub sp,#0x4	; 02302492
	add r5,r0,#0x0	; 02302494
	add r4,r1,#0x0	; 02302496
	bl P4_AcquireCommandSlot	; 02302498
	mov r1,#0xa	; 0230249C
	strh r1,[r0,#0x0]	; 0230249E
	mov r1,#0x1	; 023024A0
	strh r1,[r0,#0x2]	; 023024A2
	strh r5,[r0,#0x4]	; 023024A4
	strh r4,[r0,#0x6]	; 023024A6
	bl P4_SubmitCommandSlot	; 023024A8
	add sp,#0x4	; 023024AC
	pop {r4,r5}	; 023024AE
	pop {r3}	; 023024B0
	bx r3	; 023024B2

; ===== function loc_023024B4 =====
	push {r4,r5,r6,r7,lr}	; 023024B4
	sub sp,#0x1fc	; 023024B6
	sub sp,#0x50	; 023024B8
	add r4,r0,#0x0	; 023024BA
	bl P4_GetRuntimeState	; 023024BC
	str r0,[sp,#0x10]	; 023024C0
	ldr r1,[pool_023026C0]	; 023024C2
	ldr r6,[r0,r1]	; 023024C4
	ldr r2,[r4,#0x4]	; 023024C6
	ldr r1,[r6,#0x0]	; 023024C8
	ldr r0,[pool_023026C4]	; 023024CA
	str r2,[r1,r0]	; 023024CC
	ldrh r7,[r4,#0x2]	; 023024CE
	ldr r1,[r6,#0x0]	; 023024D0
	ldr r0,[pool_023026C8]	; 023024D2
	strh r7,[r1,r0]	; 023024D4
	ldrh r5,[r4,#0x8]	; 023024D6
	ldrh r1,[r4,#0xa]	; 023024D8
	add r0,sp,#0x14	; 023024DA
	strh r1,[r0,#0x2]	; 023024DC
	ldrh r1,[r4,#0xc]	; 023024DE
	strh r1,[r0,#0x4]	; 023024E0
	ldrh r1,[r4,#0xe]	; 023024E2
	strh r1,[r0,#0x6]	; 023024E4
	cmp r7,#0x0	; 023024E6
	bne loc_023024FA	; 023024E8
	bl P4_AcquireCommandSlot	; 023024EA
	mov r1,#0xa	; 023024EE
	strh r1,[r0,#0x0]	; 023024F0
	mov r1,#0x6	; 023024F2
	strh r1,[r0,#0x2]	; 023024F4
	bl P4_SubmitCommandSlot	; 023024F6
loc_023024FA:
	ldr r0,[r6,#0x0]	; 023024FA
	mov r2,#0x1	; 023024FC
	lsl r2,r7	; 023024FE
	ldr r1,[pool_023026CC]	; 02302500
	ldrh r1,[r0,r1]	; 02302502
	and r2,r1	; 02302504
	cmp r2,#0x0	; 02302506
	bne loc_0230251C	; 02302508
	bl P4_AcquireCommandSlot	; 0230250A
	mov r1,#0xa	; 0230250E
	strh r1,[r0,#0x0]	; 02302510
	mov r1,#0x6	; 02302512
	strh r1,[r0,#0x2]	; 02302514
	bl P4_SubmitCommandSlot	; 02302516
	b loc_023026B6	; 0230251A
loc_0230251C:
	mov r1,#0x2	; 0230251C
	add r0,#0xe6	; 0230251E
	strh r1,[r0,#0x0]	; 02302520
	add r0,sp,#0x4c	; 02302522
	bl loc_023018D0	; 02302524
	ldrh r1,[r0,#0x4]	; 02302528
	cmp r1,#0x0	; 0230252A
	beq loc_02302536	; 0230252C
	ldr r0,[pool_023026D0]	; 0230252E
	bl loc_02302490	; 02302530
	b loc_023026B6	; 02302534
loc_02302536:
	ldrh r0,[r0,#0x6]	; 02302536
	cmp r0,#0x10	; 02302538
	bne loc_0230257E	; 0230253A
	mov r0,#0xa	; 0230253C
	add r1,sp,#0x4c	; 0230253E
	bl loc_023005B0	; 02302540
	cmp r0,#0x0	; 02302544
	bne loc_0230254A	; 02302546
	b loc_023026B6	; 02302548
loc_0230254A:
	add r0,sp,#0x4c	; 0230254A
	bl loc_02301920	; 0230254C
	ldrh r1,[r0,#0x4]	; 02302550
	cmp r1,#0x0	; 02302552
	beq loc_0230255E	; 02302554
	ldr r0,[pool_023026D4]	; 02302556
	bl loc_02302490	; 02302558
	b loc_023026B6	; 0230255C
loc_0230255E:
	mov r1,#0x3	; 0230255E
	ldr r0,[r6,#0x0]	; 02302560
	strh r1,[r0,#0x0]	; 02302562
	add r0,sp,#0x4c	; 02302564
	mov r1,#0x1	; 02302566
	mov r2,#0x0	; 02302568
	add r3,r1,#0x0	; 0230256A
	bl loc_02301E9C	; 0230256C
	ldrh r1,[r0,#0x4]	; 02302570
	cmp r1,#0x0	; 02302572
	beq loc_0230257E	; 02302574
	mov r0,#0x1	; 02302576
	bl loc_02302490	; 02302578
	b loc_023026B6	; 0230257C
loc_0230257E:
	mov r1,#0x5	; 0230257E
	ldr r0,[r6,#0x0]	; 02302580
	strh r1,[r0,#0x0]	; 02302582
	ldr r1,[pool_023026D8]	; 02302584
	add r0,sp,#0x14	; 02302586
	strh r1,[r0,#0x0]	; 02302588
	ldrh r0,[r0,#0x0]	; 0230258A
	add r1,sp,#0x1c	; 0230258C
	mov r2,#0x20	; 0230258E
	bl loc_023026E4	; 02302590
	add r0,sp,#0x3c	; 02302594
	strb r7,[r0,#0x0]	; 02302596
	add r0,sp,#0x3c	; 02302598
	add r0,#0x1	; 0230259A
	mov r1,#0x0	; 0230259C
	mov r2,#0xf	; 0230259E
	bl loc_023026F0	; 023025A0
	add r0,sp,#0x1c	; 023025A4
	str r0,[sp,#0x0]	; 023025A6
	mov r0,#0x1	; 023025A8
	str r0,[sp,#0x4]	; 023025AA
	add r0,sp,#0x3c	; 023025AC
	str r0,[sp,#0x8]	; 023025AE
	str r5,[sp,#0xc]	; 023025B0
	add r0,sp,#0x4c	; 023025B2
	ldr r1,[pool_023026DC]	; 023025B4
	add r2,sp,#0x14	; 023025B6
	add r2,#0x2	; 023025B8
	mov r3,#0x0	; 023025BA
	bl loc_02301DF8	; 023025BC
	add r4,r0,#0x0	; 023025C0
	ldrh r1,[r4,#0x4]	; 023025C2
	cmp r1,#0x0	; 023025C4
	beq loc_023025D0	; 023025C6
	mov r0,#0x2	; 023025C8
	bl loc_02302490	; 023025CA
	b loc_023026B6	; 023025CE
loc_023025D0:
	bl P4_AcquireCommandSlot	; 023025D0
	add r5,r0,#0x0	; 023025D4
	ldrh r0,[r4,#0x8]	; 023025D6
	cmp r0,#0x0	; 023025D8
	bne loc_023025EE	; 023025DA
	mov r0,#0xa	; 023025DC
	strh r0,[r5,#0x0]	; 023025DE
	mov r1,#0x0	; 023025E0
	strh r1,[r5,#0x2]	; 023025E2
	mov r0,#0x4	; 023025E4
	strh r0,[r5,#0x8]	; 023025E6
	strh r7,[r5,#0x10]	; 023025E8
	strh r1,[r5,#0x12]	; 023025EA
	b loc_023026B0	; 023025EC
loc_023025EE:
	ldr r1,[pool_023026E0]	; 023025EE
	ldr r0,[sp,#0x10]	; 023025F0
	ldr r0,[r0,r1]	; 023025F2
	ldr r2,[r6,#0x0]	; 023025F4
	ldr r1,[pool_023026C4]	; 023025F6
	ldr r1,[r2,r1]	; 023025F8
	add r1,#0x40	; 023025FA
	mov r2,#0x0	; 023025FC
	mov r3,#0x80	; 023025FE
	bl loc_023026FC	; 02302600
	ldr r1,[pool_023026E0]	; 02302604
	ldr r0,[sp,#0x10]	; 02302606
	ldr r0,[r0,r1]	; 02302608
	add r1,r4,#0x0	; 0230260A
	add r1,#0xa	; 0230260C
	ldr r3,[r6,#0x0]	; 0230260E
	ldr r2,[pool_023026C4]	; 02302610
	ldr r2,[r3,r2]	; 02302612
	ldrh r3,[r4,#0xa]	; 02302614
	lsl r3,r3,#0x1	; 02302616
	bl loc_023006F8	; 02302618
	mov r0,#0xa	; 0230261C
	strh r0,[r5,#0x0]	; 0230261E
	mov r0,#0x0	; 02302620
	strh r0,[r5,#0x2]	; 02302622
	mov r0,#0x5	; 02302624
	strh r0,[r5,#0x8]	; 02302626
	add r0,r4,#0x0	; 02302628
	add r0,#0x40	; 0230262A
	ldrh r0,[r0,#0x0]	; 0230262C
	strh r0,[r5,#0x10]	; 0230262E
	ldrh r0,[r4,#0xc]	; 02302630
	lsl r0,r0,#0x18	; 02302632
	lsr r0,r0,#0x18	; 02302634
	bl loc_023004B4	; 02302636
	bl P4_QuantizeValueByThresholds8_14_20	; 0230263A
	strh r0,[r5,#0x12]	; 0230263E
	ldrh r0,[r4,#0x14]	; 02302640
	strh r0,[r5,#0x14]	; 02302642
	add r0,r5,#0x0	; 02302644
	add r0,#0xa	; 02302646
	add r1,r4,#0x0	; 02302648
	add r1,#0xe	; 0230264A
	bl loc_02300800	; 0230264C
	ldr r1,[pool_023026E0]	; 02302650
	ldr r0,[sp,#0x10]	; 02302652
	ldr r0,[r0,r1]	; 02302654
	add r1,r4,#0x0	; 02302656
	add r1,#0x16	; 02302658
	add r2,r5,#0x0	; 0230265A
	add r2,#0x16	; 0230265C
	mov r3,#0x20	; 0230265E
	bl loc_023006F8	; 02302660
	add r0,r4,#0x0	; 02302664
	add r0,#0x46	; 02302666
	ldrh r0,[r0,#0x0]	; 02302668
	strh r0,[r5,#0x36]	; 0230266A
	ldrh r0,[r5,#0x36]	; 0230266C
	cmp r0,#0x80	; 0230266E
	bls loc_02302684	; 02302670
	mov r0,#0xa	; 02302672
	strh r0,[r5,#0x0]	; 02302674
	mov r1,#0x0	; 02302676
	strh r1,[r5,#0x2]	; 02302678
	mov r0,#0x4	; 0230267A
	strh r0,[r5,#0x8]	; 0230267C
	strh r7,[r5,#0x10]	; 0230267E
	strh r1,[r5,#0x12]	; 02302680
	b loc_023026B0	; 02302682
loc_02302684:
	ldr r1,[pool_023026E0]	; 02302684
	ldr r0,[sp,#0x10]	; 02302686
	ldr r0,[r0,r1]	; 02302688
	add r1,r5,#0x0	; 0230268A
	add r1,#0x38	; 0230268C
	mov r2,#0x0	; 0230268E
	mov r3,#0x80	; 02302690
	bl loc_023026FC	; 02302692
	ldr r1,[pool_023026E0]	; 02302696
	ldr r0,[sp,#0x10]	; 02302698
	ldr r0,[r0,r1]	; 0230269A
	add r4,#0x4a	; 0230269C
	add r1,r4,#0x0	; 0230269E
	add r2,r5,#0x0	; 023026A0
	add r2,#0x38	; 023026A2
	ldrh r3,[r5,#0x36]	; 023026A4
	add r3,r3,#0x1	; 023026A6
	mov r4,#0x1	; 023026A8
	bic r3,r4	; 023026AA
	bl loc_023006F8	; 023026AC
loc_023026B0:
	add r0,r5,#0x0	; 023026B0
	bl P4_SubmitCommandSlot	; 023026B2
loc_023026B6:
	add sp,#0x1fc	; 023026B6
	add sp,#0x50	; 023026B8
	pop {r4,r5,r6,r7}	; 023026BA
	pop {r3}	; 023026BC
	bx r3	; 023026BE
pool_023026C0:
loc_023026C0:
	.word 0x00001518	; 023026C0
pool_023026C4:
loc_023026C4:
	.word 0x00000184	; 023026C4
pool_023026C8:
loc_023026C8:
	.word 0x00000190	; 023026C8
pool_023026CC:
loc_023026CC:
	.word 0x000001F4	; 023026CC
pool_023026D0:
loc_023026D0:
	.word 0x00000308	; 023026D0
pool_023026D4:
loc_023026D4:
	.word 0x00000303	; 023026D4
pool_023026D8:
loc_023026D8:
	.word 0x0000FFFF	; 023026D8
pool_023026DC:
loc_023026DC:
	.word 0x0000011C	; 023026DC
pool_023026E0:
loc_023026E0:
	.word 0x0000150C	; 023026E0

; ===== function loc_023026E4 =====
loc_023026E4:
	bx pc	; 023026E4
	.byte 0xC0, 0x46	; 023026E8
.arm

; ===== function loc_023026E8 =====
loc_023026E8:
	ldr pc,[pool_023026EC]	; 023026E8
pool_023026EC:
loc_023026EC:
	.word loc_037FF31C	; 023026EC
.thumb

; ===== function loc_023026F0 =====
loc_023026F0:
	bx pc	; 023026F0
	.byte 0xC0, 0x46	; 023026F4
.arm

; ===== function loc_023026F4 =====
loc_023026F4:
	ldr pc,[pool_023026F8]	; 023026F4
pool_023026F8:
loc_023026F8:
	.word loc_037FF3C8	; 023026F8
.thumb

; ===== function loc_023026FC =====
loc_023026FC:
	bx pc	; 023026FC
	.byte 0xC0, 0x46	; 02302700
.arm

; ===== function loc_02302700 =====
loc_02302700:
	ldr r12,[pool_02302708]	; 02302700
	bx r12	; 02302704
pool_02302708:
loc_02302708:
	.word P2_Entry_037FF2A8 + 1	; 02302708
.thumb

; ===== function loc_0230270C =====
loc_0230270C:
	push {r4,r5,lr}	; 0230270C
	sub sp,#0x4	; 0230270E
	add r5,r0,#0x0	; 02302710
	add r4,r1,#0x0	; 02302712
	bl P4_AcquireCommandSlot	; 02302714
	mov r1,#0xb	; 02302718
	strh r1,[r0,#0x0]	; 0230271A
	mov r1,#0x1	; 0230271C
	strh r1,[r0,#0x2]	; 0230271E
	strh r5,[r0,#0x4]	; 02302720
	strh r4,[r0,#0x6]	; 02302722
	bl P4_SubmitCommandSlot	; 02302724
	add sp,#0x4	; 02302728
	pop {r4,r5}	; 0230272A
	pop {r3}	; 0230272C
	bx r3	; 0230272E

; ===== function loc_02302730 =====
	push {r4,r5,lr}	; 02302730
	sub sp,#0x1fc	; 02302732
	sub sp,#0x8	; 02302734
	add r5,sp,#0x0	; 02302736
	bl P4_GetRuntimeState	; 02302738
	ldr r1,[pool_02302790]	; 0230273C
	ldr r4,[r0,r1]	; 0230273E
	ldr r0,[r4,#0x0]	; 02302740
	ldrh r0,[r0,#0x0]	; 02302742
	cmp r0,#0x5	; 02302744
	beq loc_0230275A	; 02302746
	bl P4_AcquireCommandSlot	; 02302748
	mov r1,#0xb	; 0230274C
	strh r1,[r0,#0x0]	; 0230274E
	mov r1,#0x3	; 02302750
	strh r1,[r0,#0x2]	; 02302752
	bl P4_SubmitCommandSlot	; 02302754
	b loc_02302784	; 02302758
loc_0230275A:
	add r0,r5,#0x0	; 0230275A
	bl loc_02301930	; 0230275C
	ldrh r1,[r0,#0x4]	; 02302760
	cmp r1,#0x0	; 02302762
	beq loc_0230276E	; 02302764
	ldr r0,[pool_02302794]	; 02302766
	bl loc_0230270C	; 02302768
	b loc_02302784	; 0230276C
loc_0230276E:
	mov r1,#0x2	; 0230276E
	ldr r0,[r4,#0x0]	; 02302770
	strh r1,[r0,#0x0]	; 02302772
	bl P4_AcquireCommandSlot	; 02302774
	mov r1,#0xb	; 02302778
	strh r1,[r0,#0x0]	; 0230277A
	mov r1,#0x0	; 0230277C
	strh r1,[r0,#0x2]	; 0230277E
	bl P4_SubmitCommandSlot	; 02302780
loc_02302784:
	add sp,#0x1fc	; 02302784
	add sp,#0x8	; 02302786
	pop {r4,r5}	; 02302788
	pop {r3}	; 0230278A
	bx r3	; 0230278C
	.byte 0xC0, 0x46	; 02302790
pool_02302790:
loc_02302790:
	.word 0x00001518	; 02302790
pool_02302794:
loc_02302794:
	.word 0x00000302	; 02302794

; ===== function loc_02302798 =====
loc_02302798:
	push {r4,r5,lr}	; 02302798
	sub sp,#0x4	; 0230279A
	add r5,r0,#0x0	; 0230279C
	add r4,r1,#0x0	; 0230279E
	bl P4_AcquireCommandSlot	; 023027A0
	mov r1,#0xc	; 023027A4
	strh r1,[r0,#0x0]	; 023027A6
	mov r1,#0x1	; 023027A8
	strh r1,[r0,#0x2]	; 023027AA
	strh r5,[r0,#0x4]	; 023027AC
	strh r4,[r0,#0x6]	; 023027AE
	bl P4_SubmitCommandSlot	; 023027B0
	add sp,#0x4	; 023027B4
	pop {r4,r5}	; 023027B6
	pop {r3}	; 023027B8
	bx r3	; 023027BA

; ===== function loc_023027BC =====
	push {r4,r5,r6,r7,lr}	; 023027BC
	sub sp,#0x1fc	; 023027BE
	sub sp,#0x58	; 023027C0
	add r5,r0,#0x0	; 023027C2
	add r7,sp,#0x10	; 023027C4
	bl P4_GetRuntimeState	; 023027C6
	add r6,r0,#0x0	; 023027CA
	ldr r0,[pool_02302AB8]	; 023027CC
	ldr r4,[r6,r0]	; 023027CE
	ldr r0,[pool_02302ABC]	; 023027D0
	ldr r0,[r6,r0]	; 023027D2
	ldr r1,[r5,#0x4]	; 023027D4
	add r2,r4,#0x0	; 023027D6
	add r2,#0x10	; 023027D8
	mov r3,#0xc0	; 023027DA
	bl loc_023006F8	; 023027DC
	add r0,r4,#0x0	; 023027E0
	add r0,#0x4c	; 023027E2
	ldrh r0,[r0,#0x0]	; 023027E4
	cmp r0,#0x10	; 023027E6
	bcc loc_0230280E	; 023027E8
	add r0,r4,#0x0	; 023027EA
	add r0,#0x5b	; 023027EC
	ldrb r1,[r0,#0x0]	; 023027EE
	mov r0,#0x1	; 023027F0
	and r1,r0	; 023027F2
	cmp r1,#0x0	; 023027F4
	bne loc_0230280E	; 023027F6
	bl P4_AcquireCommandSlot	; 023027F8
	mov r1,#0xc	; 023027FC
	strh r1,[r0,#0x0]	; 023027FE
	mov r1,#0xb	; 02302800
	strh r1,[r0,#0x2]	; 02302802
	mov r1,#0x6	; 02302804
	strh r1,[r0,#0x8]	; 02302806
	bl P4_SubmitCommandSlot	; 02302808
	b loc_02302AAE	; 0230280C
loc_0230280E:
	mov r0,#0x1	; 0230280E
	add r1,r4,#0x0	; 02302810
	add r1,#0x46	; 02302812
	ldrh r1,[r1,#0x0]	; 02302814
	lsl r0,r1	; 02302816
	ldr r2,[r4,#0x0]	; 02302818
	ldr r1,[pool_02302AC0]	; 0230281A
	ldrh r1,[r2,r1]	; 0230281C
	and r0,r1	; 0230281E
	cmp r0,#0x0	; 02302820
	bne loc_02302838	; 02302822
	bl P4_AcquireCommandSlot	; 02302824
	mov r1,#0xc	; 02302828
	strh r1,[r0,#0x0]	; 0230282A
	mov r1,#0x6	; 0230282C
	strh r1,[r0,#0x2]	; 0230282E
	strh r1,[r0,#0x8]	; 02302830
	bl P4_SubmitCommandSlot	; 02302832
	b loc_02302AAE	; 02302836
loc_02302838:
	bl P4_AcquireCommandSlot	; 02302838
	mov r1,#0xc	; 0230283C
	strh r1,[r0,#0x0]	; 0230283E
	mov r1,#0x0	; 02302840
	strh r1,[r0,#0x2]	; 02302842
	mov r1,#0x6	; 02302844
	strh r1,[r0,#0x8]	; 02302846
	bl P4_SubmitCommandSlot	; 02302848
	ldr r1,[r4,#0x0]	; 0230284C
	ldr r0,[pool_02302AC4]	; 0230284E
	add r0,r1,r0	; 02302850
	ldrh r1,[r0,#0x0]	; 02302852
	cmp r1,#0x1	; 02302854
	bne loc_0230286C	; 02302856
	ldrh r2,[r4,#0x3e]	; 02302858
	mov r1,#0x1	; 0230285A
	and r2,r1	; 0230285C
	cmp r2,#0x0	; 0230285E
	beq loc_02302866	; 02302860
	strh r1,[r0,#0x0]	; 02302862
	b loc_0230287E	; 02302864
loc_02302866:
	mov r1,#0x2	; 02302866
	strh r1,[r0,#0x0]	; 02302868
	b loc_0230287E	; 0230286A
loc_0230286C:
	ldrh r2,[r4,#0x3e]	; 0230286C
	mov r1,#0x2	; 0230286E
	and r2,r1	; 02302870
	cmp r2,#0x0	; 02302872
	beq loc_0230287A	; 02302874
	strh r1,[r0,#0x0]	; 02302876
	b loc_0230287E	; 02302878
loc_0230287A:
	mov r1,#0x1	; 0230287A
	strh r1,[r0,#0x0]	; 0230287C
loc_0230287E:
	ldrh r1,[r4,#0x3c]	; 0230287E
	mov r0,#0x20	; 02302880
	and r1,r0	; 02302882
	cmp r1,#0x0	; 02302884
	beq loc_02302892	; 02302886
	mov r2,#0x1	; 02302888
	ldr r1,[r4,#0x0]	; 0230288A
	ldr r0,[pool_02302AC8]	; 0230288C
	strh r2,[r1,r0]	; 0230288E
	b loc_0230289A	; 02302890
loc_02302892:
	mov r2,#0x0	; 02302892
	ldr r1,[r4,#0x0]	; 02302894
	ldr r0,[pool_02302AC8]	; 02302896
	strh r2,[r1,r0]	; 02302898
loc_0230289A:
	ldrh r1,[r4,#0x3c]	; 0230289A
	mov r0,#0x10	; 0230289C
	and r1,r0	; 0230289E
	cmp r1,#0x0	; 023028A0
	beq loc_023028AE	; 023028A2
	mov r2,#0x1	; 023028A4
	ldr r1,[r4,#0x0]	; 023028A6
	ldr r0,[pool_02302ACC]	; 023028A8
	str r2,[r1,r0]	; 023028AA
	b loc_023028B6	; 023028AC
loc_023028AE:
	mov r2,#0x0	; 023028AE
	ldr r1,[r4,#0x0]	; 023028B0
	ldr r0,[pool_02302ACC]	; 023028B2
	str r2,[r1,r0]	; 023028B4
loc_023028B6:
	add r0,r4,#0x0	; 023028B6
	add r0,#0x4c	; 023028B8
	ldrh r0,[r0,#0x0]	; 023028BA
	cmp r0,#0x0	; 023028BC
	bne loc_023028CA	; 023028BE
	mov r1,#0x3	; 023028C0
	ldr r0,[r4,#0x0]	; 023028C2
	add r0,#0xe6	; 023028C4
	strh r1,[r0,#0x0]	; 023028C6
	b loc_023028D2	; 023028C8
loc_023028CA:
	mov r1,#0x2	; 023028CA
	ldr r0,[r4,#0x0]	; 023028CC
	add r0,#0xe6	; 023028CE
	strh r1,[r0,#0x0]	; 023028D0
loc_023028D2:
	mov r0,#0xc	; 023028D2
	add r1,r7,#0x0	; 023028D4
	bl loc_023005B0	; 023028D6
	cmp r0,#0x0	; 023028DA
	bne loc_023028E0	; 023028DC
	b loc_02302AAE	; 023028DE
loc_023028E0:
	add r0,r7,#0x0	; 023028E0
	bl loc_02301920	; 023028E2
	ldrh r1,[r0,#0x4]	; 023028E6
	cmp r1,#0x0	; 023028E8
	beq loc_023028F4	; 023028EA
	ldr r0,[pool_02302AD0]	; 023028EC
	bl loc_02302798	; 023028EE
	b loc_02302AAE	; 023028F2
loc_023028F4:
	ldr r0,[pool_02302ABC]	; 023028F4
	ldr r0,[r6,r0]	; 023028F6
	add r1,r4,#0x0	; 023028F8
	add r1,#0x10	; 023028FA
	add r2,sp,#0x210	; 023028FC
	mov r3,#0x40	; 023028FE
	bl loc_023006F8	; 02302900
	ldr r0,[r4,#0x0]	; 02302904
	add r0,#0xe6	; 02302906
	ldrh r0,[r0,#0x0]	; 02302908
	cmp r0,#0x2	; 0230290A
	bne loc_0230293C	; 0230290C
	mov r0,#0x20	; 0230290E
	add r1,sp,#0x210	; 02302910
	strh r0,[r1,#0xa]	; 02302912
	add r0,r4,#0x0	; 02302914
	add r0,#0x54	; 02302916
	ldrh r0,[r0,#0x0]	; 02302918
	strh r0,[r1,#0xc]	; 0230291A
	add r0,r4,#0x0	; 0230291C
	add r0,#0x56	; 0230291E
	ldrh r0,[r0,#0x0]	; 02302920
	strh r0,[r1,#0xe]	; 02302922
	add r0,r4,#0x0	; 02302924
	add r0,#0x58	; 02302926
	ldrh r0,[r0,#0x0]	; 02302928
	strh r0,[r1,#0x10]	; 0230292A
	mov r0,#0x0	; 0230292C
	strh r0,[r1,#0x12]	; 0230292E
	add r5,#0x8	; 02302930
	add r0,r5,#0x0	; 02302932
	add r1,sp,#0x224	; 02302934
	mov r2,#0x18	; 02302936
	bl loc_02302AEC	; 02302938
loc_0230293C:
	add r0,r7,#0x0	; 0230293C
	ldr r1,[pool_02302AD4]	; 0230293E
	add r2,sp,#0x210	; 02302940
	bl loc_02301D9C	; 02302942
	add r2,r0,#0x0	; 02302946
	ldrh r1,[r2,#0x4]	; 02302948
	cmp r1,#0x0	; 0230294A
	bne loc_02302954	; 0230294C
	ldrh r0,[r2,#0x6]	; 0230294E
	cmp r0,#0x0	; 02302950
	beq loc_0230295C	; 02302952
loc_02302954:
	mov r0,#0x3	; 02302954
	bl loc_02302798	; 02302956
	b loc_02302AAE	; 0230295A
loc_0230295C:
	ldr r1,[r4,#0x0]	; 0230295C
	ldr r0,[pool_02302AD8]	; 0230295E
	add r0,r1,r0	; 02302960
	add r2,#0x8	; 02302962
	add r1,r2,#0x0	; 02302964
	bl loc_02300800	; 02302966
	add r0,r4,#0x0	; 0230296A
	add r0,#0x5b	; 0230296C
	ldrb r1,[r0,#0x0]	; 0230296E
	mov r0,#0x4	; 02302970
	and r1,r0	; 02302972
	cmp r1,#0x0	; 02302974
	beq loc_0230297C	; 02302976
	mov r1,#0x6	; 02302978
	b loc_0230297E	; 0230297A
loc_0230297C:
	mov r1,#0x0	; 0230297C
loc_0230297E:
	add r0,r4,#0x0	; 0230297E
	add r0,#0x5e	; 02302980
	ldrh r0,[r0,#0x0]	; 02302982
	add r0,r0,#0x2	; 02302984
	add r2,r0,r1	; 02302986
	ldr r1,[r4,#0x0]	; 02302988
	ldr r0,[pool_02302ADC]	; 0230298A
	strh r2,[r1,r0]	; 0230298C
	add r0,r4,#0x0	; 0230298E
	add r0,#0x5b	; 02302990
	ldrb r1,[r0,#0x0]	; 02302992
	mov r0,#0x4	; 02302994
	and r1,r0	; 02302996
	cmp r1,#0x0	; 02302998
	beq loc_023029A0	; 0230299A
	mov r1,#0x2a	; 0230299C
	b loc_023029A2	; 0230299E
loc_023029A0:
	mov r1,#0x0	; 023029A0
loc_023029A2:
	add r0,r4,#0x0	; 023029A2
	add r0,#0x5c	; 023029A4
	ldrh r0,[r0,#0x0]	; 023029A6
	add r0,r0,#0x4	; 023029A8
	add r2,r0,r1	; 023029AA
	ldr r1,[r4,#0x0]	; 023029AC
	ldr r0,[pool_02302AE0]	; 023029AE
	strh r2,[r1,r0]	; 023029B0
	add r0,sp,#0x0	; 023029B2
	add r0,#0x2	; 023029B4
	ldr r2,[r4,#0x0]	; 023029B6
	ldr r1,[pool_02302AD8]	; 023029B8
	add r1,r2,r1	; 023029BA
	bl loc_02300800	; 023029BC
	add r0,r7,#0x0	; 023029C0
	add r1,sp,#0x0	; 023029C2
	add r1,#0x2	; 023029C4
	mov r2,#0x0	; 023029C6
	ldr r3,[pool_02302AD4]	; 023029C8
	bl loc_02301D40	; 023029CA
	ldrh r1,[r0,#0x4]	; 023029CE
	cmp r1,#0xc	; 023029D0
	bne loc_023029EA	; 023029D2
	ldrh r2,[r0,#0x6]	; 023029D4
	cmp r2,#0x13	; 023029D6
	bne loc_023029EA	; 023029D8
	bl P4_AcquireCommandSlot	; 023029DA
	mov r1,#0xc	; 023029DE
	strh r1,[r0,#0x0]	; 023029E0
	strh r1,[r0,#0x2]	; 023029E2
	bl P4_SubmitCommandSlot	; 023029E4
	b loc_02302AAE	; 023029E8
loc_023029EA:
	cmp r1,#0x0	; 023029EA
	bne loc_023029F4	; 023029EC
	ldrh r0,[r0,#0x6]	; 023029EE
	cmp r0,#0x0	; 023029F0
	beq loc_023029FC	; 023029F2
loc_023029F4:
	mov r0,#0x4	; 023029F4
	bl loc_02302798	; 023029F6
	b loc_02302AAE	; 023029FA
loc_023029FC:
	add r0,sp,#0x8	; 023029FC
	ldr r2,[r4,#0x0]	; 023029FE
	ldr r1,[pool_02302AD8]	; 02302A00
	add r1,r2,r1	; 02302A02
	bl loc_02300800	; 02302A04
	add r0,r7,#0x0	; 02302A08
	add r1,sp,#0x8	; 02302A0A
	mov r2,#0x1	; 02302A0C
	ldr r3,[pool_02302AD4]	; 02302A0E
	bl loc_02301C8C	; 02302A10
	ldrh r1,[r0,#0x4]	; 02302A14
	cmp r1,#0xc	; 02302A16
	bne loc_02302A32	; 02302A18
	ldrh r2,[r0,#0x6]	; 02302A1A
	cmp r2,#0x13	; 02302A1C
	bne loc_02302A32	; 02302A1E
	bl P4_AcquireCommandSlot	; 02302A20
	mov r1,#0xc	; 02302A24
	strh r1,[r0,#0x0]	; 02302A26
	mov r1,#0xb	; 02302A28
	strh r1,[r0,#0x2]	; 02302A2A
	bl P4_SubmitCommandSlot	; 02302A2C
	b loc_02302AAE	; 02302A30
loc_02302A32:
	cmp r1,#0x0	; 02302A32
	bne loc_02302A3C	; 02302A34
	ldrh r2,[r0,#0x6]	; 02302A36
	cmp r2,#0x0	; 02302A38
	beq loc_02302A44	; 02302A3A
loc_02302A3C:
	mov r0,#0x6	; 02302A3C
	bl loc_02302798	; 02302A3E
	b loc_02302AAE	; 02302A42
loc_02302A44:
	ldrh r2,[r0,#0x8]	; 02302A44
	ldr r1,[r4,#0x0]	; 02302A46
	ldr r0,[pool_02302AE4]	; 02302A48
	strh r2,[r1,r0]	; 02302A4A
	add r0,r4,#0x0	; 02302A4C
	add r0,#0x58	; 02302A4E
	ldrh r1,[r0,#0x0]	; 02302A50
	ldr r0,[r4,#0x0]	; 02302A52
	add r0,#0xba	; 02302A54
	strh r1,[r0,#0x0]	; 02302A56
	mov r1,#0x1	; 02302A58
	add r0,sp,#0x0	; 02302A5A
	strh r1,[r0,#0x0]	; 02302A5C
	ldrh r0,[r0,#0x0]	; 02302A5E
	ldr r2,[r4,#0x0]	; 02302A60
	ldr r1,[pool_02302AE8]	; 02302A62
	add r1,r2,r1	; 02302A64
	mov r2,#0x20	; 02302A66
	bl loc_02302AF8	; 02302A68
	bl loc_02304410	; 02302A6C
	ldrh r0,[r4,#0x12]	; 02302A70
	lsl r0,r0,#0x18	; 02302A72
	lsr r0,r0,#0x18	; 02302A74
	bl loc_023004B4	; 02302A76
	add r5,r0,#0x0	; 02302A7A
	bl P4_QuantizeValueByThresholds8_14_20	; 02302A7C
	ldr r1,[r4,#0x0]	; 02302A80
	add r1,#0xbc	; 02302A82
	strh r0,[r1,#0x0]	; 02302A84
	add r0,r5,#0x0	; 02302A86
	bl P4_Clear16ByteInputWindow	; 02302A88
	mov r1,#0x8	; 02302A8C
	ldr r0,[r4,#0x0]	; 02302A8E
	strh r1,[r0,#0x0]	; 02302A90
	bl P4_AcquireCommandSlot	; 02302A92
	mov r1,#0xc	; 02302A96
	strh r1,[r0,#0x0]	; 02302A98
	mov r1,#0x0	; 02302A9A
	strh r1,[r0,#0x2]	; 02302A9C
	mov r1,#0x7	; 02302A9E
	strh r1,[r0,#0x8]	; 02302AA0
	ldr r2,[r4,#0x0]	; 02302AA2
	ldr r1,[pool_02302AE4]	; 02302AA4
	ldrh r1,[r2,r1]	; 02302AA6
	strh r1,[r0,#0xa]	; 02302AA8
	bl P4_SubmitCommandSlot	; 02302AAA
loc_02302AAE:
	add sp,#0x1fc	; 02302AAE
	add sp,#0x58	; 02302AB0
	pop {r4,r5,r6,r7}	; 02302AB2
	pop {r3}	; 02302AB4
	bx r3	; 02302AB6
pool_02302AB8:
loc_02302AB8:
	.word 0x00001518	; 02302AB8
pool_02302ABC:
loc_02302ABC:
	.word 0x0000150C	; 02302ABC
pool_02302AC0:
loc_02302AC0:
	.word 0x000001F4	; 02302AC0
pool_02302AC4:
loc_02302AC4:
	.word 0x000001EC	; 02302AC4
pool_02302AC8:
loc_02302AC8:
	.word 0x000001EE	; 02302AC8
pool_02302ACC:
loc_02302ACC:
	.word 0x00000198	; 02302ACC
pool_02302AD0:
loc_02302AD0:
	.word 0x00000303	; 02302AD0
pool_02302AD4:
loc_02302AD4:
	.word 0x000007D0	; 02302AD4
pool_02302AD8:
loc_02302AD8:
	.word 0x0000018A	; 02302AD8
pool_02302ADC:
loc_02302ADC:
	.word 0x00000192	; 02302ADC
pool_02302AE0:
loc_02302AE0:
	.word 0x00000194	; 02302AE0
pool_02302AE4:
loc_02302AE4:
	.word 0x00000188	; 02302AE4
pool_02302AE8:
loc_02302AE8:
	.word 0x000001F8	; 02302AE8

; ===== function loc_02302AEC =====
loc_02302AEC:
	bx pc	; 02302AEC
	.byte 0xC0, 0x46	; 02302AF0
.arm

; ===== function loc_02302AF0 =====
loc_02302AF0:
	ldr pc,[pool_02302AF4]	; 02302AF0
pool_02302AF4:
loc_02302AF4:
	.word P2_Entry_037FF3E0	; 02302AF4
.thumb

; ===== function loc_02302AF8 =====
loc_02302AF8:
	bx pc	; 02302AF8
	.byte 0xC0, 0x46	; 02302AFC
.arm

; ===== function loc_02302AFC =====
loc_02302AFC:
	ldr pc,[pool_02302B00]	; 02302AFC
pool_02302B00:
loc_02302B00:
	.word loc_037FF31C	; 02302B00
.thumb

; ===== function loc_02302B04 =====
loc_02302B04:
	push {r4,r5,lr}	; 02302B04
	sub sp,#0x4	; 02302B06
	add r5,r0,#0x0	; 02302B08
	add r4,r1,#0x0	; 02302B0A
	bl P4_AcquireCommandSlot	; 02302B0C
	mov r1,#0xd	; 02302B10
	strh r1,[r0,#0x0]	; 02302B12
	mov r1,#0x1	; 02302B14
	strh r1,[r0,#0x2]	; 02302B16
	strh r5,[r0,#0x4]	; 02302B18
	strh r4,[r0,#0x6]	; 02302B1A
	bl P4_SubmitCommandSlot	; 02302B1C
	add sp,#0x4	; 02302B20
	pop {r4,r5}	; 02302B22
	pop {r3}	; 02302B24
	bx r3	; 02302B26

; ===== function loc_02302B28 =====
loc_02302B28:
	push {r4,r5,r6,r7,lr}	; 02302B28
	sub sp,#0x1fc	; 02302B2A
	sub sp,#0x20	; 02302B2C
	add r4,r0,#0x0	; 02302B2E
	add r7,r1,#0x0	; 02302B30
	bl P4_GetRuntimeState	; 02302B32
	ldr r1,[pool_02302CE4]	; 02302B36
	ldr r5,[r0,r1]	; 02302B38
	ldr r0,[r4,#0x4]	; 02302B3A
	lsl r0,r0,#0x10	; 02302B3C
	lsr r0,r0,#0x10	; 02302B3E
	str r0,[sp,#0x0]	; 02302B40
	ldr r2,[r5,#0x0]	; 02302B42
	ldrh r0,[r2,#0x0]	; 02302B44
	cmp r0,#0x9	; 02302B46
	beq loc_02302B6C	; 02302B48
	cmp r0,#0x7	; 02302B4A
	beq loc_02302B6C	; 02302B4C
	cmp r0,#0xa	; 02302B4E
	beq loc_02302B56	; 02302B50
	cmp r0,#0x8	; 02302B52
	bne loc_02302B68	; 02302B54
loc_02302B56:
	cmp r0,#0xa	; 02302B56
	bne loc_02302B6C	; 02302B58
	mov r1,#0x0	; 02302B5A
	str r1,[r2,#0x10]	; 02302B5C
	ldr r0,[r5,#0x0]	; 02302B5E
	str r1,[r0,#0x18]	; 02302B60
	ldr r0,[r5,#0x0]	; 02302B62
	str r1,[r0,#0x24]	; 02302B64
	b loc_02302B6C	; 02302B66
loc_02302B68:
	mov r0,#0x0	; 02302B68
	b loc_02302CDA	; 02302B6A
loc_02302B6C:
	ldr r2,[r5,#0x0]	; 02302B6C
	ldrh r0,[r2,#0x0]	; 02302B6E
	cmp r0,#0xa	; 02302B70
	beq loc_02302B78	; 02302B72
	cmp r0,#0x8	; 02302B74
	bne loc_02302C16	; 02302B76
loc_02302B78:
	add r0,sp,#0xc	; 02302B78
	ldr r1,[pool_02302CE8]	; 02302B7A
	add r1,r2,r1	; 02302B7C
	bl loc_02300800	; 02302B7E
	add r0,sp,#0x18	; 02302B82
	add r1,sp,#0xc	; 02302B84
	mov r2,#0x3	; 02302B86
	bl loc_02301CE4	; 02302B88
	ldrh r1,[r0,#0x4]	; 02302B8C
	cmp r1,#0x0	; 02302B8E
	beq loc_02302B9C	; 02302B90
	mov r0,#0x5	; 02302B92
	bl loc_02302B04	; 02302B94
	mov r0,#0x0	; 02302B98
	b loc_02302CDA	; 02302B9A
loc_02302B9C:
	add r0,sp,#0x18	; 02302B9C
	mov r1,#0x1	; 02302B9E
	bl loc_02301EDC	; 02302BA0
	ldrh r1,[r0,#0x4]	; 02302BA4
	cmp r1,#0x0	; 02302BA6
	beq loc_02302BB4	; 02302BA8
	mov r0,#0x0	; 02302BAA
	bl loc_02302B04	; 02302BAC
	mov r0,#0x0	; 02302BB0
	b loc_02302CDA	; 02302BB2
loc_02302BB4:
	mov r1,#0x3	; 02302BB4
	ldr r0,[r5,#0x0]	; 02302BB6
	strh r1,[r0,#0x0]	; 02302BB8
	add r0,sp,#0x18	; 02302BBA
	bl loc_02301930	; 02302BBC
	ldrh r1,[r0,#0x4]	; 02302BC0
	cmp r1,#0x0	; 02302BC2
	beq loc_02302BD0	; 02302BC4
	ldr r0,[pool_02302CEC]	; 02302BC6
	bl loc_02302B04	; 02302BC8
	mov r0,#0x0	; 02302BCC
	b loc_02302CDA	; 02302BCE
loc_02302BD0:
	mov r1,#0x2	; 02302BD0
	ldr r0,[r5,#0x0]	; 02302BD2
	strh r1,[r0,#0x0]	; 02302BD4
	mov r1,#0x0	; 02302BD6
	ldr r0,[r5,#0x0]	; 02302BD8
	str r1,[r0,#0x10]	; 02302BDA
	ldr r0,[r5,#0x0]	; 02302BDC
	str r1,[r0,#0x18]	; 02302BDE
	ldr r0,[r5,#0x0]	; 02302BE0
	str r1,[r0,#0x14]	; 02302BE2
	cmp r7,#0x1	; 02302BE4
	bne loc_02302CD8	; 02302BE6
	bl P4_AcquireCommandSlot	; 02302BE8
	mov r1,#0xc	; 02302BEC
	strh r1,[r0,#0x0]	; 02302BEE
	mov r1,#0x0	; 02302BF0
	strh r1,[r0,#0x2]	; 02302BF2
	mov r2,#0x9	; 02302BF4
	strh r2,[r0,#0x8]	; 02302BF6
	mov r2,#0x24	; 02302BF8
	strh r2,[r0,#0xc]	; 02302BFA
	ldr r3,[r5,#0x0]	; 02302BFC
	ldr r2,[pool_02302CF0]	; 02302BFE
	ldrh r2,[r3,r2]	; 02302C00
	strh r2,[r0,#0xa]	; 02302C02
	ldr r3,[r5,#0x0]	; 02302C04
	ldr r2,[pool_02302CF4]	; 02302C06
	strh r1,[r3,r2]	; 02302C08
	ldr r3,[r5,#0x0]	; 02302C0A
	ldr r2,[pool_02302CF8]	; 02302C0C
	strh r1,[r3,r2]	; 02302C0E
	bl P4_SubmitCommandSlot	; 02302C10
	b loc_02302CD8	; 02302C14
loc_02302C16:
	mov r4,#0x1	; 02302C16
	str r4,[sp,#0x8]	; 02302C18
	b loc_02302CD4	; 02302C1A
loc_02302C1C:
	ldr r1,[r5,#0x0]	; 02302C1C
	ldr r6,[sp,#0x8]	; 02302C1E
	lsl r6,r4	; 02302C20
	ldr r0,[pool_02302CFC]	; 02302C22
	ldrh r2,[r1,r0]	; 02302C24
	ldr r0,[sp,#0x0]	; 02302C26
	and r2,r0	; 02302C28
	add r0,r6,#0x0	; 02302C2A
	and r0,r2	; 02302C2C
	cmp r0,#0x0	; 02302C2E
	beq loc_02302CD2	; 02302C30
	lsl r0,r4,#0x10	; 02302C32
	lsr r0,r0,#0x10	; 02302C34
	str r0,[sp,#0x4]	; 02302C36
	add r0,sp,#0x10	; 02302C38
	add r0,#0x2	; 02302C3A
	ldr r2,[pool_02302D00]	; 02302C3C
	add r2,r1,r2	; 02302C3E
	sub r3,r4,#0x1	; 02302C40
	mov r1,#0x6	; 02302C42
	mul r3,r1	; 02302C44
	add r1,r2,r3	; 02302C46
	bl loc_02300800	; 02302C48
	add r0,sp,#0x18	; 02302C4C
	add r1,sp,#0x10	; 02302C4E
	add r1,#0x2	; 02302C50
	mov r2,#0x3	; 02302C52
	bl loc_02301CE4	; 02302C54
	ldrh r1,[r0,#0x4]	; 02302C58
	cmp r1,#0x0	; 02302C5A
	beq loc_02302C68	; 02302C5C
	mov r0,#0x5	; 02302C5E
	bl loc_02302B04	; 02302C60
	mov r0,#0x0	; 02302C64
	b loc_02302CDA	; 02302C66
loc_02302C68:
	ldr r0,[r5,#0x0]	; 02302C68
	ldr r1,[pool_02302CFC]	; 02302C6A
	ldrh r2,[r0,r1]	; 02302C6C
	bic r2,r6	; 02302C6E
	strh r2,[r0,r1]	; 02302C70
	ldr r1,[r5,#0x0]	; 02302C72
	add r0,r1,#0x0	; 02302C74
	add r0,#0x8a	; 02302C76
	ldrh r0,[r0,#0x0]	; 02302C78
	bic r0,r6	; 02302C7A
	add r1,#0x8a	; 02302C7C
	strh r0,[r1,#0x0]	; 02302C7E
	add r0,r4,#0x0	; 02302C80
	mov r1,#0x6	; 02302C82
	mul r0,r1	; 02302C84
	ldr r1,[r5,#0x0]	; 02302C86
	add r3,r1,r0	; 02302C88
	mov r2,#0x0	; 02302C8A
	ldr r1,[pool_02302D04]	; 02302C8C
	strh r2,[r3,r1]	; 02302C8E
	ldr r1,[r5,#0x0]	; 02302C90
	add r3,r1,r0	; 02302C92
	ldr r1,[pool_02302D08]	; 02302C94
	strh r2,[r3,r1]	; 02302C96
	ldr r1,[r5,#0x0]	; 02302C98
	add r2,r1,r0	; 02302C9A
	mov r1,#0x0	; 02302C9C
	ldr r0,[pool_02302D0C]	; 02302C9E
	strh r1,[r2,r0]	; 02302CA0
	cmp r7,#0x1	; 02302CA2
	bne loc_02302CD2	; 02302CA4
	bl P4_AcquireCommandSlot	; 02302CA6
	add r6,r0,#0x0	; 02302CAA
	mov r0,#0x8	; 02302CAC
	strh r0,[r6,#0x0]	; 02302CAE
	mov r0,#0x0	; 02302CB0
	strh r0,[r6,#0x2]	; 02302CB2
	mov r0,#0x9	; 02302CB4
	strh r0,[r6,#0x8]	; 02302CB6
	mov r0,#0x24	; 02302CB8
	strh r0,[r6,#0x12]	; 02302CBA
	ldr r0,[sp,#0x4]	; 02302CBC
	strh r0,[r6,#0x10]	; 02302CBE
	add r0,r6,#0x0	; 02302CC0
	add r0,#0xa	; 02302CC2
	add r1,sp,#0x10	; 02302CC4
	add r1,#0x2	; 02302CC6
	bl loc_02300800	; 02302CC8
	add r0,r6,#0x0	; 02302CCC
	bl P4_SubmitCommandSlot	; 02302CCE
loc_02302CD2:
	add r4,r4,#0x1	; 02302CD2
loc_02302CD4:
	cmp r4,#0x10	; 02302CD4
	blt loc_02302C1C	; 02302CD6
loc_02302CD8:
	mov r0,#0x1	; 02302CD8
loc_02302CDA:
	add sp,#0x1fc	; 02302CDA
	add sp,#0x20	; 02302CDC
	pop {r4,r5,r6,r7}	; 02302CDE
	pop {r3}	; 02302CE0
	bx r3	; 02302CE2
pool_02302CE4:
loc_02302CE4:
	.word 0x00001518	; 02302CE4
pool_02302CE8:
loc_02302CE8:
	.word 0x0000018A	; 02302CE8
pool_02302CEC:
loc_02302CEC:
	.word 0x00000302	; 02302CEC
pool_02302CF0:
loc_02302CF0:
	.word 0x00000188	; 02302CF0
pool_02302CF4:
loc_02302CF4:
	.word 0x00000192	; 02302CF4
pool_02302CF8:
loc_02302CF8:
	.word 0x00000194	; 02302CF8
pool_02302CFC:
loc_02302CFC:
	.word 0x00000182	; 02302CFC
pool_02302D00:
loc_02302D00:
	.word 0x00000128	; 02302D00
pool_02302D04:
loc_02302D04:
	.word 0x00000122	; 02302D04
pool_02302D08:
loc_02302D08:
	.word 0x00000124	; 02302D08
pool_02302D0C:
loc_02302D0C:
	.word 0x00000126	; 02302D0C

; ===== function loc_02302D10 =====
	push {lr}	; 02302D10
	sub sp,#0x4	; 02302D12
	mov r1,#0x0	; 02302D14
	bl loc_02302B28	; 02302D16
	cmp r0,#0x1	; 02302D1A
	bne loc_02302D30	; 02302D1C
	bl P4_AcquireCommandSlot	; 02302D1E
	mov r1,#0xd	; 02302D22
	strh r1,[r0,#0x0]	; 02302D24
	mov r1,#0x0	; 02302D26
	strh r1,[r0,#0x2]	; 02302D28
	bl P4_SubmitCommandSlot	; 02302D2A
	b loc_02302D40	; 02302D2E
loc_02302D30:
	bl P4_AcquireCommandSlot	; 02302D30
	mov r1,#0xd	; 02302D34
	strh r1,[r0,#0x0]	; 02302D36
	mov r1,#0x1	; 02302D38
	strh r1,[r0,#0x2]	; 02302D3A
	bl P4_SubmitCommandSlot	; 02302D3C
loc_02302D40:
	add sp,#0x4	; 02302D40
	pop {r3}	; 02302D42
	bx r3	; 02302D44
	.byte 0x00, 0x00	; 02302D48
	push {r4,r5,r6,lr}	; 02302D48
	add r5,r0,#0x0	; 02302D4A
	bl P4_GetRuntimeState	; 02302D4C
	ldr r1,[pool_02302E70]	; 02302D50
	ldr r0,[r0,r1]	; 02302D52
	ldr r4,[r0,#0x0]	; 02302D54
	ldr r2,[r5,#0x4]	; 02302D56
	ldr r0,[r5,#0x8]	; 02302D58
	lsl r0,r0,#0x10	; 02302D5A
	lsr r1,r0,#0x10	; 02302D5C
	mov r0,#0x0	; 02302D5E
	str r0,[r4,#0x10]	; 02302D60
	str r0,[r4,#0xc]	; 02302D62
	add r3,r4,#0x0	; 02302D64
	add r3,#0x88	; 02302D66
	strh r0,[r3,#0x0]	; 02302D68
	strh r0,[r4,#0x38]	; 02302D6A
	mov r3,#0x1	; 02302D6C
	strh r3,[r4,#0x3a]	; 02302D6E
	add r3,r4,#0x0	; 02302D70
	add r3,#0x8c	; 02302D72
	strh r0,[r3,#0x0]	; 02302D74
	add r3,r4,#0x0	; 02302D76
	add r3,#0x9e	; 02302D78
	strh r0,[r3,#0x0]	; 02302D7A
	mov r6,#0x3c	; 02302D7C
	add r3,r4,#0x0	; 02302D7E
	add r3,#0xa0	; 02302D80
	strh r6,[r3,#0x0]	; 02302D82
	ldr r3,[pool_02302E74]	; 02302D84
	str r0,[r4,r3]	; 02302D86
	add r3,r4,#0x0	; 02302D88
	add r3,#0x8e	; 02302D8A
	strh r0,[r3,#0x0]	; 02302D8C
	add r3,r4,#0x0	; 02302D8E
	add r3,#0x90	; 02302D90
	strh r0,[r3,#0x0]	; 02302D92
	add r3,r4,#0x0	; 02302D94
	add r3,#0x92	; 02302D96
	strh r0,[r3,#0x0]	; 02302D98
	add r3,r4,#0x0	; 02302D9A
	add r3,#0x94	; 02302D9C
	strh r0,[r3,#0x0]	; 02302D9E
	str r2,[r4,#0x4c]	; 02302DA0
	add r3,r4,#0x0	; 02302DA2
	add r3,#0x4a	; 02302DA4
	strh r1,[r3,#0x0]	; 02302DA6
	add r1,r2,r1	; 02302DA8
	str r1,[r4,#0x50]	; 02302DAA
	add r1,r4,#0x0	; 02302DAC
	add r1,#0x46	; 02302DAE
	strh r0,[r1,#0x0]	; 02302DB0
	ldr r0,[r5,#0xc]	; 02302DB2
	str r0,[r4,#0x54]	; 02302DB4
	ldr r1,[r5,#0x10]	; 02302DB6
	add r0,r4,#0x0	; 02302DB8
	add r0,#0x58	; 02302DBA
	strh r1,[r0,#0x0]	; 02302DBC
	ldr r0,[r5,#0x14]	; 02302DBE
	strh r0,[r4,#0x3c]	; 02302DC0
	ldrh r0,[r4,#0x3c]	; 02302DC2
	cmp r0,#0x0	; 02302DC4
	bne loc_02302DCC	; 02302DC6
	mov r0,#0x10	; 02302DC8
	strh r0,[r4,#0x3c]	; 02302DCA
loc_02302DCC:
	ldr r1,[r5,#0x18]	; 02302DCC
	add r0,r4,#0x0	; 02302DCE
	add r0,#0x9c	; 02302DD0
	strh r1,[r0,#0x0]	; 02302DD2
	ldr r0,[r5,#0x1c]	; 02302DD4
	cmp r0,#0x0	; 02302DD6
	beq loc_02302DDE	; 02302DD8
	mov r1,#0x1	; 02302DDA
	b loc_02302DE0	; 02302DDC
loc_02302DDE:
	mov r1,#0x0	; 02302DDE
loc_02302DE0:
	add r0,r4,#0x0	; 02302DE0
	add r0,#0x96	; 02302DE2
	strh r1,[r0,#0x0]	; 02302DE4
	ldr r0,[r5,#0x20]	; 02302DE6
	cmp r0,#0x0	; 02302DE8
	beq loc_02302DF0	; 02302DEA
	mov r1,#0x1	; 02302DEC
	b loc_02302DF2	; 02302DEE
loc_02302DF0:
	mov r1,#0x0	; 02302DF0
loc_02302DF2:
	add r0,r4,#0x0	; 02302DF2
	add r0,#0x98	; 02302DF4
	strh r1,[r0,#0x0]	; 02302DF6
	ldr r0,[r5,#0x24]	; 02302DF8
	cmp r0,#0x0	; 02302DFA
	beq loc_02302E02	; 02302DFC
	mov r1,#0x1	; 02302DFE
	b loc_02302E04	; 02302E00
loc_02302E02:
	mov r1,#0x0	; 02302E02
loc_02302E04:
	add r0,r4,#0x0	; 02302E04
	add r0,#0x9a	; 02302E06
	strh r1,[r0,#0x0]	; 02302E08
	mov r1,#0x0	; 02302E0A
	strh r1,[r4,#0x3e]	; 02302E0C
	add r0,r4,#0x0	; 02302E0E
	add r0,#0x42	; 02302E10
	strh r1,[r0,#0x0]	; 02302E12
	add r0,r4,#0x0	; 02302E14
	add r0,#0x44	; 02302E16
	strh r1,[r0,#0x0]	; 02302E18
	ldr r0,[r5,#0x28]	; 02302E1A
	cmp r0,#0x0	; 02302E1C
	beq loc_02302E22	; 02302E1E
	mov r1,#0x1	; 02302E20
loc_02302E22:
	add r0,r4,#0x0	; 02302E22
	add r0,#0xde	; 02302E24
	strh r1,[r0,#0x0]	; 02302E26
	bl loc_02304410	; 02302E28
	bl loc_02303718	; 02302E2C
	ldrh r0,[r4,#0x0]	; 02302E30
	cmp r0,#0x8	; 02302E32
	bne loc_02302E3C	; 02302E34
	mov r0,#0xa	; 02302E36
	strh r0,[r4,#0x0]	; 02302E38
	b loc_02302E44	; 02302E3A
loc_02302E3C:
	cmp r0,#0x7	; 02302E3C
	bne loc_02302E44	; 02302E3E
	mov r0,#0x9	; 02302E40
	strh r0,[r4,#0x0]	; 02302E42
loc_02302E44:
	bl loc_02302E78	; 02302E44
	add r5,r0,#0x0	; 02302E48
	mov r0,#0x1	; 02302E4A
	str r0,[r4,#0x10]	; 02302E4C
	bl P4_AcquireCommandSlot	; 02302E4E
	mov r1,#0xe	; 02302E52
	strh r1,[r0,#0x0]	; 02302E54
	mov r1,#0x0	; 02302E56
	strh r1,[r0,#0x2]	; 02302E58
	mov r1,#0xa	; 02302E5A
	strh r1,[r0,#0x4]	; 02302E5C
	bl P4_SubmitCommandSlot	; 02302E5E
	add r0,r5,#0x0	; 02302E62
	bl loc_02302E84	; 02302E64
	pop {r4,r5,r6}	; 02302E68
	pop {r3}	; 02302E6A
	bx r3	; 02302E6C
	.byte 0xC0, 0x46	; 02302E70
pool_02302E70:
loc_02302E70:
	.word 0x00001518	; 02302E70
pool_02302E74:
loc_02302E74:
	.word 0x00000930	; 02302E74

; ===== function loc_02302E78 =====
loc_02302E78:
	bx pc	; 02302E78
	.byte 0xC0, 0x46	; 02302E7C
.arm

; ===== function loc_02302E7C =====
loc_02302E7C:
	ldr pc,[pool_02302E80]	; 02302E7C
pool_02302E80:
loc_02302E80:
	.word loc_037FF104	; 02302E80
.thumb

; ===== function loc_02302E84 =====
loc_02302E84:
	bx pc	; 02302E84
	.byte 0xC0, 0x46	; 02302E88
.arm

; ===== function loc_02302E88 =====
loc_02302E88:
	ldr pc,[pool_02302E8C]	; 02302E88
pool_02302E8C:
loc_02302E8C:
	.word loc_037FF118	; 02302E8C
.thumb

; ===== function loc_02302E90 =====
	push {r4,r5,r6,r7,lr}	; 02302E90
	sub sp,#0x1c	; 02302E92
	add r4,r0,#0x0	; 02302E94
	bl P4_GetRuntimeState	; 02302E96
	ldr r1,[r4,#0x4]	; 02302E9A
	str r1,[sp,#0xc]	; 02302E9C
	ldr r1,[r4,#0x8]	; 02302E9E
	lsl r1,r1,#0x10	; 02302EA0
	lsr r5,r1,#0x10	; 02302EA2
	ldr r1,[r4,#0xc]	; 02302EA4
	lsl r1,r1,#0x10	; 02302EA6
	lsr r6,r1,#0x10	; 02302EA8
	ldr r1,[r4,#0x10]	; 02302EAA
	lsl r1,r1,#0x10	; 02302EAC
	lsr r1,r1,#0x10	; 02302EAE
	str r1,[sp,#0x10]	; 02302EB0
	ldr r1,[r4,#0x14]	; 02302EB2
	lsl r1,r1,#0x10	; 02302EB4
	lsr r1,r1,#0x10	; 02302EB6
	ldr r7,[r4,#0x18]	; 02302EB8
	ldr r4,[r4,#0x1c]	; 02302EBA
	ldr r2,[pool_02302F14]	; 02302EBC
	ldr r0,[r0,r2]	; 02302EBE
	ldr r2,[r0,#0x0]	; 02302EC0
	ldr r0,[pool_02302F18]	; 02302EC2
	ldrh r0,[r2,r0]	; 02302EC4
	cmp r0,#0x0	; 02302EC6
	beq loc_02302ECC	; 02302EC8
	mov r6,#0x1	; 02302ECA
loc_02302ECC:
	str r5,[sp,#0x0]	; 02302ECC
	str r7,[sp,#0x4]	; 02302ECE
	str r4,[sp,#0x8]	; 02302ED0
	add r0,r1,#0x0	; 02302ED2
	ldr r1,[sp,#0x10]	; 02302ED4
	add r2,r6,#0x0	; 02302ED6
	ldr r3,[sp,#0xc]	; 02302ED8
	bl loc_02303D94	; 02302EDA
	str r0,[sp,#0x14]	; 02302EDE
	cmp r0,#0x2	; 02302EE0
	beq loc_02302F0C	; 02302EE2
	bl P4_AcquireCommandSlot	; 02302EE4
	mov r1,#0x81	; 02302EE8
	strh r1,[r0,#0x0]	; 02302EEA
	ldr r1,[sp,#0x14]	; 02302EEC
	strh r1,[r0,#0x2]	; 02302EEE
	mov r1,#0x14	; 02302EF0
	strh r1,[r0,#0x8]	; 02302EF2
	ldr r1,[sp,#0x10]	; 02302EF4
	strh r1,[r0,#0xa]	; 02302EF6
	strh r6,[r0,#0xc]	; 02302EF8
	strh r5,[r0,#0xe]	; 02302EFA
	ldr r1,[sp,#0xc]	; 02302EFC
	str r1,[r0,#0x10]	; 02302EFE
	str r7,[r0,#0x14]	; 02302F00
	str r4,[r0,#0x18]	; 02302F02
	ldr r1,[pool_02302F1C]	; 02302F04
	strh r1,[r0,#0x1c]	; 02302F06
	bl P4_SubmitCommandSlot	; 02302F08
loc_02302F0C:
	add sp,#0x1c	; 02302F0C
	pop {r4,r5,r6,r7}	; 02302F0E
	pop {r3}	; 02302F10
	bx r3	; 02302F12
pool_02302F14:
loc_02302F14:
	.word 0x00001518	; 02302F14
pool_02302F18:
loc_02302F18:
	.word 0x00000188	; 02302F18
pool_02302F1C:
loc_02302F1C:
	.word 0x0000FFFF	; 02302F1C

; ===== function loc_02302F20 =====
	push {lr}	; 02302F20
	sub sp,#0x4	; 02302F22
	bl P4_GetRuntimeState	; 02302F24
	ldr r1,[pool_02302F5C]	; 02302F28
	ldr r0,[r0,r1]	; 02302F2A
	ldr r1,[r0,#0x0]	; 02302F2C
	mov r0,#0x0	; 02302F2E
	str r0,[r1,#0x10]	; 02302F30
	ldrh r0,[r1,#0x0]	; 02302F32
	cmp r0,#0xa	; 02302F34
	bne loc_02302F3E	; 02302F36
	mov r0,#0x8	; 02302F38
	strh r0,[r1,#0x0]	; 02302F3A
	b loc_02302F46	; 02302F3C
loc_02302F3E:
	cmp r0,#0x9	; 02302F3E
	bne loc_02302F46	; 02302F40
	mov r0,#0x7	; 02302F42
	strh r0,[r1,#0x0]	; 02302F44
loc_02302F46:
	bl P4_AcquireCommandSlot	; 02302F46
	mov r1,#0x10	; 02302F4A
	strh r1,[r0,#0x0]	; 02302F4C
	mov r1,#0x0	; 02302F4E
	strh r1,[r0,#0x2]	; 02302F50
	bl P4_SubmitCommandSlot	; 02302F52
	add sp,#0x4	; 02302F56
	pop {r3}	; 02302F58
	bx r3	; 02302F5A
pool_02302F5C:
loc_02302F5C:
	.word 0x00001518	; 02302F5C

; ===== function loc_02302F60 =====
	push {r4,r5,lr}	; 02302F60
	sub sp,#0x1fc	; 02302F62
	sub sp,#0x88	; 02302F64
	add r5,r0,#0x0	; 02302F66
	bl P4_GetRuntimeState	; 02302F68
	ldr r1,[pool_02303044]	; 02302F6C
	ldr r0,[r0,r1]	; 02302F6E
	ldr r4,[r0,#0x0]	; 02302F70
	ldr r1,[r5,#0x4]	; 02302F72
	add r0,r4,#0x0	; 02302F74
	add r0,#0xe8	; 02302F76
	str r1,[r0,#0x0]	; 02302F78
	ldr r1,[r5,#0x8]	; 02302F7A
	add r0,r4,#0x0	; 02302F7C
	add r0,#0xec	; 02302F7E
	strh r1,[r0,#0x0]	; 02302F80
	ldr r1,[r5,#0xc]	; 02302F82
	add r0,r4,#0x0	; 02302F84
	add r0,#0xee	; 02302F86
	strh r1,[r0,#0x0]	; 02302F88
	ldr r1,[r5,#0x10]	; 02302F8A
	add r0,r4,#0x0	; 02302F8C
	add r0,#0xf0	; 02302F8E
	strh r1,[r0,#0x0]	; 02302F90
	ldr r1,[r5,#0x14]	; 02302F92
	add r0,r4,#0x0	; 02302F94
	add r0,#0xf2	; 02302F96
	strh r1,[r0,#0x0]	; 02302F98
	ldr r0,[r5,#0x18]	; 02302F9A
	lsl r0,r0,#0x18	; 02302F9C
	lsr r0,r0,#0x18	; 02302F9E
	mov r2,#0x1	; 02302FA0
	add r1,r0,#0x0	; 02302FA2
	and r1,r2	; 02302FA4
	cmp r1,#0x0	; 02302FA6
	bne loc_02302FAC	; 02302FA8
	mov r2,#0x0	; 02302FAA
loc_02302FAC:
	add r1,r4,#0x0	; 02302FAC
	add r1,#0xf4	; 02302FAE
	strh r2,[r1,#0x0]	; 02302FB0
	mov r1,#0x2	; 02302FB2
	add r2,r0,#0x0	; 02302FB4
	and r2,r1	; 02302FB6
	cmp r2,#0x0	; 02302FB8
	beq loc_02302FC0	; 02302FBA
	mov r2,#0x1	; 02302FBC
	b loc_02302FC2	; 02302FBE
loc_02302FC0:
	mov r2,#0x0	; 02302FC0
loc_02302FC2:
	add r1,r4,#0x0	; 02302FC2
	add r1,#0xf8	; 02302FC4
	strh r2,[r1,#0x0]	; 02302FC6
	mov r1,#0x4	; 02302FC8
	add r2,r0,#0x0	; 02302FCA
	and r2,r1	; 02302FCC
	cmp r2,#0x0	; 02302FCE
	beq loc_02302FD6	; 02302FD0
	mov r2,#0x1	; 02302FD2
	b loc_02302FD8	; 02302FD4
loc_02302FD6:
	mov r2,#0x0	; 02302FD6
loc_02302FD8:
	add r1,r4,#0x0	; 02302FD8
	add r1,#0xfa	; 02302FDA
	strh r2,[r1,#0x0]	; 02302FDC
	mov r1,#0x8	; 02302FDE
	and r0,r1	; 02302FE0
	cmp r0,#0x0	; 02302FE2
	beq loc_02302FEA	; 02302FE4
	mov r1,#0x1	; 02302FE6
	b loc_02302FEC	; 02302FE8
loc_02302FEA:
	mov r1,#0x0	; 02302FEA
loc_02302FEC:
	add r0,r4,#0x0	; 02302FEC
	add r0,#0xfc	; 02302FEE
	strh r1,[r0,#0x0]	; 02302FF0
	add r0,sp,#0x200	; 02302FF2
	add r1,r4,#0x0	; 02302FF4
	add r1,#0xe8	; 02302FF6
	bl loc_02300720	; 02302FF8
	add r0,sp,#0x0	; 02302FFC
	add r4,#0xec	; 02302FFE
	ldrh r1,[r4,#0x0]	; 02303000
	add r1,#0x10	; 02303002
	lsl r1,r1,#0x10	; 02303004
	lsr r1,r1,#0x10	; 02303006
	add r2,sp,#0x200	; 02303008
	bl loc_02301980	; 0230300A
	add r4,r0,#0x0	; 0230300E
	bl P4_AcquireCommandSlot	; 02303010
	mov r1,#0x18	; 02303014
	strh r1,[r0,#0x0]	; 02303016
	ldrh r1,[r4,#0x4]	; 02303018
	cmp r1,#0x0	; 0230301A
	bne loc_02303022	; 0230301C
	mov r1,#0x0	; 0230301E
	b loc_02303024	; 02303020
loc_02303022:
	mov r1,#0x1	; 02303022
loc_02303024:
	strh r1,[r0,#0x2]	; 02303024
	ldrh r1,[r4,#0x4]	; 02303026
	cmp r1,#0x0	; 02303028
	beq loc_02303034	; 0230302A
	ldr r1,[pool_02303048]	; 0230302C
	strh r1,[r0,#0x4]	; 0230302E
	ldrh r1,[r4,#0x4]	; 02303030
	strh r1,[r0,#0x6]	; 02303032
loc_02303034:
	bl P4_SubmitCommandSlot	; 02303034
	add sp,#0x1fc	; 02303038
	add sp,#0x88	; 0230303A
	pop {r4,r5}	; 0230303C
	pop {r3}	; 0230303E
	bx r3	; 02303040
	.byte 0xC0, 0x46	; 02303044
pool_02303044:
loc_02303044:
	.word 0x00001518	; 02303044
pool_02303048:
loc_02303048:
	.word 0x00000245	; 02303048

; ===== function loc_0230304C =====
loc_0230304C:
	push {r4,r5,lr}	; 0230304C
	sub sp,#0x4	; 0230304E
	add r5,r0,#0x0	; 02303050
	add r4,r1,#0x0	; 02303052
	bl P4_AcquireCommandSlot	; 02303054
	mov r1,#0x19	; 02303058
	strh r1,[r0,#0x0]	; 0230305A
	mov r1,#0x1	; 0230305C
	strh r1,[r0,#0x2]	; 0230305E
	strh r5,[r0,#0x4]	; 02303060
	strh r4,[r0,#0x6]	; 02303062
	bl P4_SubmitCommandSlot	; 02303064
	add sp,#0x4	; 02303068
	pop {r4,r5}	; 0230306A
	pop {r3}	; 0230306C
	bx r3	; 0230306E

; ===== function loc_02303070 =====
	push {r4,lr}	; 02303070
	sub sp,#0x1fc	; 02303072
	sub sp,#0x4	; 02303074
	add r4,r0,#0x0	; 02303076
	bl P4_GetRuntimeState	; 02303078
	add r0,sp,#0x0	; 0230307C
	ldr r1,[r4,#0x4]	; 0230307E
	lsl r1,r1,#0x10	; 02303080
	lsr r1,r1,#0x10	; 02303082
	bl loc_023019F4	; 02303084
	ldrh r1,[r0,#0x4]	; 02303088
	cmp r1,#0x0	; 0230308A
	beq loc_02303096	; 0230308C
	ldr r0,[pool_023030B0]	; 0230308E
	bl loc_0230304C	; 02303090
	b loc_023030A6	; 02303094
loc_02303096:
	bl P4_AcquireCommandSlot	; 02303096
	mov r1,#0x19	; 0230309A
	strh r1,[r0,#0x0]	; 0230309C
	mov r1,#0x0	; 0230309E
	strh r1,[r0,#0x2]	; 023030A0
	bl P4_SubmitCommandSlot	; 023030A2
loc_023030A6:
	add sp,#0x1fc	; 023030A6
	add sp,#0x4	; 023030A8
	pop {r4}	; 023030AA
	pop {r3}	; 023030AC
	bx r3	; 023030AE
pool_023030B0:
loc_023030B0:
	.word 0x00000215	; 023030B0

; ===== function loc_023030B4 =====
loc_023030B4:
	push {r4,r5,lr}	; 023030B4
	sub sp,#0x4	; 023030B6
	add r5,r0,#0x0	; 023030B8
	add r4,r1,#0x0	; 023030BA
	bl P4_AcquireCommandSlot	; 023030BC
	mov r1,#0x7	; 023030C0
	strh r1,[r0,#0x0]	; 023030C2
	mov r1,#0x1	; 023030C4
	strh r1,[r0,#0x2]	; 023030C6
	strh r5,[r0,#0x4]	; 023030C8
	strh r4,[r0,#0x6]	; 023030CA
	bl P4_SubmitCommandSlot	; 023030CC
	add sp,#0x4	; 023030D0
	pop {r4,r5}	; 023030D2
	pop {r3}	; 023030D4
	bx r3	; 023030D6

; ===== function loc_023030D8 =====
	push {r4,lr}	; 023030D8
	sub sp,#0x1fc	; 023030DA
	sub sp,#0x4	; 023030DC
	add r4,r0,#0x0	; 023030DE
	bl P4_GetRuntimeState	; 023030E0
	add r0,sp,#0x0	; 023030E4
	ldr r1,[r4,#0x4]	; 023030E6
	lsl r1,r1,#0x10	; 023030E8
	lsr r1,r1,#0x10	; 023030EA
	ldr r2,[r4,#0x8]	; 023030EC
	lsl r2,r2,#0x10	; 023030EE
	lsr r2,r2,#0x10	; 023030F0
	ldr r3,[r4,#0xc]	; 023030F2
	lsl r3,r3,#0x10	; 023030F4
	lsr r3,r3,#0x10	; 023030F6
	bl loc_02301A6C	; 023030F8
	ldrh r1,[r0,#0x4]	; 023030FC
	cmp r1,#0x0	; 023030FE
	beq loc_0230310A	; 02303100
	ldr r0,[pool_02303124]	; 02303102
	bl loc_023030B4	; 02303104
	b loc_0230311A	; 02303108
loc_0230310A:
	bl P4_AcquireCommandSlot	; 0230310A
	mov r1,#0x1d	; 0230310E
	strh r1,[r0,#0x0]	; 02303110
	mov r1,#0x0	; 02303112
	strh r1,[r0,#0x2]	; 02303114
	bl P4_SubmitCommandSlot	; 02303116
loc_0230311A:
	add sp,#0x1fc	; 0230311A
	add sp,#0x4	; 0230311C
	pop {r4}	; 0230311E
	pop {r3}	; 02303120
	bx r3	; 02303122
pool_02303124:
loc_02303124:
	.word 0x00000211	; 02303124

; ===== function loc_02303128 =====
loc_02303128:
	push {r4,r5,lr}	; 02303128
	sub sp,#0x4	; 0230312A
	add r5,r0,#0x0	; 0230312C
	add r4,r1,#0x0	; 0230312E
	bl P4_AcquireCommandSlot	; 02303130
	mov r1,#0x1e	; 02303134
	strh r1,[r0,#0x0]	; 02303136
	mov r1,#0x1	; 02303138
	strh r1,[r0,#0x2]	; 0230313A
	strh r5,[r0,#0x4]	; 0230313C
	strh r4,[r0,#0x6]	; 0230313E
	bl P4_SubmitCommandSlot	; 02303140
	add sp,#0x4	; 02303144
	pop {r4,r5}	; 02303146
	pop {r3}	; 02303148
	bx r3	; 0230314A

; ===== function loc_0230314C =====
	push {r4,r5,r6,r7,lr}	; 0230314C
	sub sp,#0x1fc	; 0230314E
	sub sp,#0x20	; 02303150
	add r5,r0,#0x0	; 02303152
	bl P4_GetRuntimeState	; 02303154
	ldr r1,[pool_0230323C]	; 02303158
	ldr r4,[r0,r1]	; 0230315A
	add r0,sp,#0x18	; 0230315C
	bl loc_023018D0	; 0230315E
	ldrh r1,[r0,#0x4]	; 02303162
	cmp r1,#0x0	; 02303164
	beq loc_02303170	; 02303166
	ldr r0,[pool_02303240]	; 02303168
	bl loc_02303128	; 0230316A
	b loc_02303232	; 0230316E
loc_02303170:
	ldrh r2,[r0,#0x6]	; 02303170
	mov r1,#0x2	; 02303172
	ldr r0,[r4,#0x0]	; 02303174
	add r0,#0xe6	; 02303176
	strh r1,[r0,#0x0]	; 02303178
	cmp r2,#0x10	; 0230317A
	bne loc_023031BE	; 0230317C
	mov r0,#0xa	; 0230317E
	add r1,sp,#0x18	; 02303180
	bl loc_023005B0	; 02303182
	cmp r0,#0x0	; 02303186
	beq loc_02303232	; 02303188
	add r0,sp,#0x18	; 0230318A
	bl loc_02301920	; 0230318C
	ldrh r1,[r0,#0x4]	; 02303190
	cmp r1,#0x0	; 02303192
	beq loc_0230319E	; 02303194
	ldr r0,[pool_02303244]	; 02303196
	bl loc_02303128	; 02303198
	b loc_02303232	; 0230319C
loc_0230319E:
	mov r1,#0x3	; 0230319E
	ldr r0,[r4,#0x0]	; 023031A0
	strh r1,[r0,#0x0]	; 023031A2
	add r0,sp,#0x18	; 023031A4
	mov r1,#0x1	; 023031A6
	mov r2,#0x0	; 023031A8
	add r3,r1,#0x0	; 023031AA
	bl loc_02301E9C	; 023031AC
	ldrh r1,[r0,#0x4]	; 023031B0
	cmp r1,#0x0	; 023031B2
	beq loc_023031BE	; 023031B4
	mov r0,#0x1	; 023031B6
	bl loc_02303128	; 023031B8
	b loc_02303232	; 023031BC
loc_023031BE:
	ldrh r7,[r5,#0x2]	; 023031BE
	ldrh r0,[r5,#0x4]	; 023031C0
	str r0,[sp,#0x4]	; 023031C2
	ldrh r6,[r5,#0x6]	; 023031C4
	ldrh r5,[r5,#0x8]	; 023031C6
	add r0,sp,#0x8	; 023031C8
	mov r1,#0x0	; 023031CA
	mov r2,#0x10	; 023031CC
	bl loc_0230324C	; 023031CE
	add r0,sp,#0x8	; 023031D2
	strb r6,[r0,#0x0]	; 023031D4
	add r0,sp,#0x8	; 023031D6
	str r0,[sp,#0x0]	; 023031D8
	add r0,sp,#0x18	; 023031DA
	add r1,r7,#0x0	; 023031DC
	ldr r2,[sp,#0x4]	; 023031DE
	add r3,r5,#0x0	; 023031E0
	bl loc_02301B88	; 023031E2
	ldrh r1,[r0,#0x4]	; 023031E6
	cmp r1,#0x0	; 023031E8
	beq loc_023031F4	; 023031EA
	mov r0,#0xa	; 023031EC
	bl loc_02303128	; 023031EE
	b loc_02303232	; 023031F2
loc_023031F4:
	ldrh r2,[r0,#0x8]	; 023031F4
	mov r0,#0xff	; 023031F6
	add r1,r2,#0x0	; 023031F8
	and r1,r0	; 023031FA
	lsl r0,r1,#0x10	; 023031FC
	lsr r5,r0,#0x10	; 023031FE
	lsl r0,r2,#0x8	; 02303200
	lsr r6,r0,#0x10	; 02303202
	add r0,sp,#0x18	; 02303204
	bl loc_02301930	; 02303206
	ldrh r1,[r0,#0x4]	; 0230320A
	cmp r1,#0x0	; 0230320C
	beq loc_02303218	; 0230320E
	ldr r0,[pool_02303248]	; 02303210
	bl loc_02303128	; 02303212
	b loc_02303232	; 02303216
loc_02303218:
	mov r1,#0x2	; 02303218
	ldr r0,[r4,#0x0]	; 0230321A
	strh r1,[r0,#0x0]	; 0230321C
	bl P4_AcquireCommandSlot	; 0230321E
	mov r1,#0x1e	; 02303222
	strh r1,[r0,#0x0]	; 02303224
	mov r1,#0x0	; 02303226
	strh r1,[r0,#0x2]	; 02303228
	strh r5,[r0,#0x8]	; 0230322A
	strh r6,[r0,#0xa]	; 0230322C
	bl P4_SubmitCommandSlot	; 0230322E
loc_02303232:
	add sp,#0x1fc	; 02303232
	add sp,#0x20	; 02303234
	pop {r4,r5,r6,r7}	; 02303236
	pop {r3}	; 02303238
	bx r3	; 0230323A
pool_0230323C:
loc_0230323C:
	.word 0x00001518	; 0230323C
pool_02303240:
loc_02303240:
	.word 0x00000308	; 02303240
pool_02303244:
loc_02303244:
	.word 0x00000303	; 02303244
pool_02303248:
loc_02303248:
	.word 0x00000302	; 02303248

; ===== function loc_0230324C =====
loc_0230324C:
	bx pc	; 0230324C
	.byte 0xC0, 0x46	; 02303250
.arm

; ===== function loc_02303250 =====
loc_02303250:
	ldr pc,[pool_02303254]	; 02303250
pool_02303254:
loc_02303254:
	.word loc_037FF3C8	; 02303254
.thumb

; ===== function loc_02303258 =====
loc_02303258:
	push {r4,r5,lr}	; 02303258
	sub sp,#0x4	; 0230325A
	add r5,r0,#0x0	; 0230325C
	add r4,r1,#0x0	; 0230325E
	bl P4_AcquireCommandSlot	; 02303260
	mov r1,#0x1f	; 02303264
	strh r1,[r0,#0x0]	; 02303266
	mov r1,#0x1	; 02303268
	strh r1,[r0,#0x2]	; 0230326A
	strh r5,[r0,#0x4]	; 0230326C
	strh r4,[r0,#0x6]	; 0230326E
	bl P4_SubmitCommandSlot	; 02303270
	add sp,#0x4	; 02303274
	pop {r4,r5}	; 02303276
	pop {r3}	; 02303278
	bx r3	; 0230327A

; ===== function loc_0230327C =====
	push {lr}	; 0230327C
	sub sp,#0x1fc	; 0230327E
	sub sp,#0x8	; 02303280
	bl P4_GetRuntimeState	; 02303282
	add r0,sp,#0x0	; 02303286
	bl loc_02301900	; 02303288
	ldrh r1,[r0,#0x4]	; 0230328C
	cmp r1,#0x0	; 0230328E
	beq loc_0230329A	; 02303290
	ldr r0,[pool_023032B4]	; 02303292
	bl loc_02303258	; 02303294
	b loc_023032AA	; 02303298
loc_0230329A:
	bl P4_AcquireCommandSlot	; 0230329A
	mov r1,#0x1f	; 0230329E
	strh r1,[r0,#0x0]	; 023032A0
	mov r1,#0x0	; 023032A2
	strh r1,[r0,#0x2]	; 023032A4
	bl P4_SubmitCommandSlot	; 023032A6
loc_023032AA:
	add sp,#0x1fc	; 023032AA
	add sp,#0x8	; 023032AC
	pop {r3}	; 023032AE
	bx r3	; 023032B0
	.byte 0xC0, 0x46	; 023032B4
pool_023032B4:
loc_023032B4:
	.word 0x00000305	; 023032B4

; ===== function loc_023032B8 =====
loc_023032B8:
	push {r4,r5,lr}	; 023032B8
	sub sp,#0x4	; 023032BA
	add r5,r0,#0x0	; 023032BC
	add r4,r1,#0x0	; 023032BE
	bl P4_AcquireCommandSlot	; 023032C0
	mov r1,#0x20	; 023032C4
	strh r1,[r0,#0x0]	; 023032C6
	mov r1,#0x1	; 023032C8
	strh r1,[r0,#0x2]	; 023032CA
	strh r5,[r0,#0x4]	; 023032CC
	strh r4,[r0,#0x6]	; 023032CE
	bl P4_SubmitCommandSlot	; 023032D0
	add sp,#0x4	; 023032D4
	pop {r4,r5}	; 023032D6
	pop {r3}	; 023032D8
	bx r3	; 023032DA

; ===== function loc_023032DC =====
	push {r4,r5,lr}	; 023032DC
	sub sp,#0x1fc	; 023032DE
	sub sp,#0x8	; 023032E0
	bl P4_GetRuntimeState	; 023032E2
	add r0,sp,#0x0	; 023032E6
	bl loc_023018E0	; 023032E8
	add r5,r0,#0x0	; 023032EC
	ldrh r1,[r5,#0x4]	; 023032EE
	cmp r1,#0x0	; 023032F0
	beq loc_023032FC	; 023032F2
	ldr r0,[pool_02303328]	; 023032F4
	bl loc_023032B8	; 023032F6
	b loc_0230331E	; 023032FA
loc_023032FC:
	bl P4_AcquireCommandSlot	; 023032FC
	add r4,r0,#0x0	; 02303300
	mov r0,#0x20	; 02303302
	strh r0,[r4,#0x0]	; 02303304
	mov r0,#0x0	; 02303306
	strh r0,[r4,#0x2]	; 02303308
	add r5,#0x8	; 0230330A
	add r0,r5,#0x0	; 0230330C
	add r1,r4,#0x0	; 0230330E
	add r1,#0x8	; 02303310
	mov r2,#0xb4	; 02303312
	bl loc_0230332C	; 02303314
	add r0,r4,#0x0	; 02303318
	bl P4_SubmitCommandSlot	; 0230331A
loc_0230331E:
	add sp,#0x1fc	; 0230331E
	add sp,#0x8	; 02303320
	pop {r4,r5}	; 02303322
	pop {r3}	; 02303324
	bx r3	; 02303326
pool_02303328:
loc_02303328:
	.word 0x00000307	; 02303328

; ===== function loc_0230332C =====
loc_0230332C:
	bx pc	; 0230332C
	.byte 0xC0, 0x46	; 02303330
.arm

; ===== function loc_02303330 =====
loc_02303330:
	ldr pc,[pool_02303334]	; 02303330
pool_02303334:
loc_02303334:
	.word P2_Entry_037FF334	; 02303334
.thumb

; ===== function loc_02303338 =====
loc_02303338:
	bx lr	; 02303338
	.byte 0x00, 0x00	; 0230333C

; ===== function loc_0230333C =====
loc_0230333C:
	push {lr}	; 0230333C
	sub sp,#0x4	; 0230333E
	bl P4_GetRuntimeState	; 02303340
	mov r2,#0x1c	; 02303344
	ldr r1,[pool_02303358]	; 02303346
	str r2,[r1,#0x0]	; 02303348
	add r0,#0x64	; 0230334A
	mov r2,#0x0	; 0230334C
	bl loc_02300868	; 0230334E
	add sp,#0x4	; 02303352
	pop {r3}	; 02303354
	bx r3	; 02303356
pool_02303358:
loc_02303358:
	.word P4_BssStart + 0x2420	; 02303358

; ===== function loc_0230335C =====
loc_0230335C:
	push {lr}	; 0230335C
	sub sp,#0x4	; 0230335E
	bl P4_GetRuntimeState	; 02303360
	ldr r1,[pool_02303388]	; 02303364
	ldr r0,[r0,r1]	; 02303366
	ldr r1,[r0,#0x0]	; 02303368
	ldr r1,[r1,#0x10]	; 0230336A
	cmp r1,#0x1	; 0230336C
	bne loc_02303382	; 0230336E
	mov r1,#0xd3	; 02303370
	str r1,[sp,#0x0]	; 02303372
	add r0,#0xd0	; 02303374
	mov r2,#0xa	; 02303376
	ldr r3,[pool_0230338C]	; 02303378
	bl loc_02303390	; 0230337A
	bl loc_0230333C	; 0230337E
loc_02303382:
	add sp,#0x4	; 02303382
	pop {r3}	; 02303384
	bx r3	; 02303386
pool_02303388:
loc_02303388:
	.word 0x00001518	; 02303388
pool_0230338C:
loc_0230338C:
	.word 0x023036BD	; 0230338C

; ===== function loc_02303390 =====
loc_02303390:
	bx pc	; 02303390
	.byte 0xC0, 0x46	; 02303394
.arm

; ===== function loc_02303394 =====
loc_02303394:
	ldr r12,[pool_0230339C]	; 02303394
	bx r12	; 02303398
pool_0230339C:
loc_0230339C:
	.word P2_Entry_037FEF9C + 1	; 0230339C
.thumb

; ===== function loc_023033A0 =====
loc_023033A0:
	push {r4,lr}	; 023033A0
	sub sp,#0x8	; 023033A2
	bl P4_GetRuntimeState	; 023033A4
	ldr r1,[pool_023033F8]	; 023033A8
	ldr r4,[r0,r1]	; 023033AA
	ldr r1,[r4,#0x0]	; 023033AC
	add r0,r1,#0x0	; 023033AE
	add r0,#0xdc	; 023033B0
	ldrh r0,[r0,#0x0]	; 023033B2
	cmp r0,#0x3c	; 023033B4
	bcc loc_023033CE	; 023033B6
	ldr r1,[pool_023033FC]	; 023033B8
	ldrh r0,[r1,#0x0]	; 023033BA
	cmp r0,#0xd3	; 023033BC
	bne loc_023033C4	; 023033BE
	mov r0,#0xd3	; 023033C0
	strh r0,[r1,#0x0]	; 023033C2
loc_023033C4:
	mov r1,#0x0	; 023033C4
	ldr r0,[r4,#0x0]	; 023033C6
	add r0,#0xdc	; 023033C8
	strh r1,[r0,#0x0]	; 023033CA
	b loc_023033DA	; 023033CC
loc_023033CE:
	add r0,r1,#0x0	; 023033CE
	add r0,#0xdc	; 023033D0
	ldrh r0,[r0,#0x0]	; 023033D2
	add r0,r0,#0x1	; 023033D4
	add r1,#0xdc	; 023033D6
	strh r0,[r1,#0x0]	; 023033D8
loc_023033DA:
	bl loc_0230367C	; 023033DA
	ldr r1,[pool_02303400]	; 023033DE
	str r1,[sp,#0x0]	; 023033E0
	add r4,#0xd0	; 023033E2
	add r0,r4,#0x0	; 023033E4
	mov r2,#0xa	; 023033E6
	ldr r3,[pool_02303404]	; 023033E8
	bl loc_02303390	; 023033EA
	add sp,#0x8	; 023033EE
	pop {r4}	; 023033F0
	pop {r3}	; 023033F2
	bx r3	; 023033F4
	.byte 0xC0, 0x46	; 023033F8
pool_023033F8:
loc_023033F8:
	.word 0x00001518	; 023033F8
pool_023033FC:
loc_023033FC:
	.word REG_VCOUNT	; 023033FC
pool_02303400:
loc_02303400:
	.word 0x00000104	; 02303400
pool_02303404:
loc_02303404:
	.word 0x023036BD	; 02303404

; ===== function loc_02303408 =====
loc_02303408:
	push {lr}	; 02303408
	sub sp,#0x4	; 0230340A
	bl P4_GetRuntimeState	; 0230340C
	ldr r1,[pool_02303434]	; 02303410
	ldr r0,[r0,r1]	; 02303412
	ldr r1,[r0,#0x0]	; 02303414
	ldr r1,[r1,#0x10]	; 02303416
	cmp r1,#0x1	; 02303418
	bne loc_0230342E	; 0230341A
	mov r1,#0xc8	; 0230341C
	str r1,[sp,#0x0]	; 0230341E
	add r0,#0xd0	; 02303420
	mov r2,#0xa	; 02303422
	ldr r3,[pool_02303438]	; 02303424
	bl loc_02303390	; 02303426
	bl loc_0230333C	; 0230342A
loc_0230342E:
	add sp,#0x4	; 0230342E
	pop {r3}	; 02303430
	bx r3	; 02303432
pool_02303434:
loc_02303434:
	.word 0x00001518	; 02303434
pool_02303438:
loc_02303438:
	.word 0x023036BD	; 02303438

; ===== function loc_0230343C =====
loc_0230343C:
	push {r4,lr}	; 0230343C
	sub sp,#0x8	; 0230343E
	bl P4_GetRuntimeState	; 02303440
	ldr r1,[pool_02303478]	; 02303444
	ldr r4,[r0,r1]	; 02303446
	ldr r2,[r4,#0x0]	; 02303448
	add r0,r2,#0x0	; 0230344A
	add r0,#0xd8	; 0230344C
	ldr r1,[r0,#0x0]	; 0230344E
	ldr r0,[pool_0230347C]	; 02303450
	cmp r1,r0	; 02303452
	bls loc_0230345A	; 02303454
	mov r0,#0x0	; 02303456
	str r0,[r2,#0x24]	; 02303458
loc_0230345A:
	bl loc_023034FC	; 0230345A
	mov r1,#0xf0	; 0230345E
	str r1,[sp,#0x0]	; 02303460
	add r4,#0xd0	; 02303462
	add r0,r4,#0x0	; 02303464
	mov r2,#0xa	; 02303466
	ldr r3,[pool_02303480]	; 02303468
	bl loc_02303390	; 0230346A
	add sp,#0x8	; 0230346E
	pop {r4}	; 02303470
	pop {r3}	; 02303472
	bx r3	; 02303474
	.byte 0xC0, 0x46	; 02303478
pool_02303478:
loc_02303478:
	.word 0x00001518	; 02303478
pool_0230347C:
loc_0230347C:
	.word 0x00000190	; 0230347C
pool_02303480:
loc_02303480:
	.word 0x023036BD	; 02303480

; ===== function loc_02303484 =====
loc_02303484:
	push {r4,lr}	; 02303484
	sub sp,#0x8	; 02303486
	bl P4_GetRuntimeState	; 02303488
	ldr r1,[pool_023034F0]	; 0230348C
	ldr r4,[r0,r1]	; 0230348E
	ldr r0,[pool_023034F4]	; 02303490
	ldrh r1,[r0,#0x0]	; 02303492
	ldr r0,[r4,#0x0]	; 02303494
	add r0,#0xd0	; 02303496
	str r1,[r0,#0x0]	; 02303498
	ldr r2,[r4,#0x0]	; 0230349A
	add r0,r2,#0x0	; 0230349C
	add r0,#0xd0	; 0230349E
	ldr r1,[r0,#0x0]	; 023034A0
	add r0,r2,#0x0	; 023034A2
	add r0,#0xd4	; 023034A4
	ldr r0,[r0,#0x0]	; 023034A6
	cmp r0,r1	; 023034A8
	beq loc_023034B4	; 023034AA
	add r2,#0xd4	; 023034AC
	str r1,[r2,#0x0]	; 023034AE
	bl loc_023035B8	; 023034B0
loc_023034B4:
	ldr r1,[r4,#0x0]	; 023034B4
	add r0,r1,#0x0	; 023034B6
	add r0,#0xd8	; 023034B8
	ldr r0,[r0,#0x0]	; 023034BA
	cmp r0,#0x8c	; 023034BC
	bls loc_023034D2	; 023034BE
	mov r1,#0xd2	; 023034C0
	str r1,[sp,#0x0]	; 023034C2
	add r4,#0xd0	; 023034C4
	add r0,r4,#0x0	; 023034C6
	mov r2,#0xa	; 023034C8
	ldr r3,[pool_023034F8]	; 023034CA
	bl loc_02303390	; 023034CC
	b loc_023034E6	; 023034D0
loc_023034D2:
	mov r0,#0x1	; 023034D2
	str r0,[r1,#0x24]	; 023034D4
	mov r1,#0xf0	; 023034D6
	str r1,[sp,#0x0]	; 023034D8
	add r4,#0xd0	; 023034DA
	add r0,r4,#0x0	; 023034DC
	mov r2,#0xa	; 023034DE
	ldr r3,[pool_023034F8]	; 023034E0
	bl loc_02303390	; 023034E2
loc_023034E6:
	add sp,#0x8	; 023034E6
	pop {r4}	; 023034E8
	pop {r3}	; 023034EA
	bx r3	; 023034EC
	.byte 0xC0, 0x46	; 023034F0
pool_023034F0:
loc_023034F0:
	.word 0x00001518	; 023034F0
pool_023034F4:
loc_023034F4:
	.word FirmwareWlAdjustedTimeSlot	; 023034F4
pool_023034F8:
loc_023034F8:
	.word 0x023036BD	; 023034F8

; ===== function loc_023034FC =====
loc_023034FC:
	push {lr}	; 023034FC
	sub sp,#0x4	; 023034FE
	bl P4_GetRuntimeState	; 02303500
	ldr r1,[pool_0230359C]	; 02303504
	ldr r1,[r0,r1]	; 02303506
	ldr r0,[r1,#0x0]	; 02303508
	add r0,#0xd8	; 0230350A
	ldr r0,[r0,#0x0]	; 0230350C
	cmp r0,#0x8c	; 0230350E
	bls loc_0230352E	; 02303510
	ldr r2,[pool_023035A0]	; 02303512
	cmp r0,r2	; 02303514
	bhi loc_0230352E	; 02303516
	mov r2,#0xd2	; 02303518
	ldr r0,[pool_023035A4]	; 0230351A
	strh r2,[r0,#0x0]	; 0230351C
	ldr r1,[r1,#0x0]	; 0230351E
	add r0,r1,#0x0	; 02303520
	add r0,#0xd8	; 02303522
	ldr r0,[r0,#0x0]	; 02303524
	sub r0,#0x41	; 02303526
	add r1,#0xd8	; 02303528
	str r0,[r1,#0x0]	; 0230352A
	b loc_02303594	; 0230352C
loc_0230352E:
	ldr r2,[pool_023035A0]	; 0230352E
	cmp r0,r2	; 02303530
	bls loc_02303550	; 02303532
	ldr r2,[pool_023035A8]	; 02303534
	cmp r0,r2	; 02303536
	bhi loc_02303550	; 02303538
	mov r2,#0xd1	; 0230353A
	ldr r0,[pool_023035A4]	; 0230353C
	strh r2,[r0,#0x0]	; 0230353E
	ldr r1,[r1,#0x0]	; 02303540
	add r0,r1,#0x0	; 02303542
	add r0,#0xd8	; 02303544
	ldr r0,[r0,#0x0]	; 02303546
	sub r0,#0x82	; 02303548
	add r1,#0xd8	; 0230354A
	str r0,[r1,#0x0]	; 0230354C
	b loc_02303594	; 0230354E
loc_02303550:
	ldr r2,[pool_023035A8]	; 02303550
	cmp r0,r2	; 02303552
	bls loc_02303572	; 02303554
	ldr r2,[pool_023035AC]	; 02303556
	cmp r0,r2	; 02303558
	bhi loc_02303572	; 0230355A
	mov r2,#0xd0	; 0230355C
	ldr r0,[pool_023035A4]	; 0230355E
	strh r2,[r0,#0x0]	; 02303560
	ldr r1,[r1,#0x0]	; 02303562
	add r0,r1,#0x0	; 02303564
	add r0,#0xd8	; 02303566
	ldr r0,[r0,#0x0]	; 02303568
	sub r0,#0xc3	; 0230356A
	add r1,#0xd8	; 0230356C
	str r0,[r1,#0x0]	; 0230356E
	b loc_02303594	; 02303570
loc_02303572:
	ldr r2,[pool_023035AC]	; 02303572
	cmp r0,r2	; 02303574
	bls loc_02303594	; 02303576
	ldr r2,[pool_023035B0]	; 02303578
	cmp r0,r2	; 0230357A
	bhi loc_02303594	; 0230357C
	mov r2,#0xca	; 0230357E
	ldr r0,[pool_023035A4]	; 02303580
	strh r2,[r0,#0x0]	; 02303582
	ldr r2,[r1,#0x0]	; 02303584
	add r0,r2,#0x0	; 02303586
	add r0,#0xd8	; 02303588
	ldr r1,[r0,#0x0]	; 0230358A
	ldr r0,[pool_023035B4]	; 0230358C
	sub r0,r1,r0	; 0230358E
	add r2,#0xd8	; 02303590
	str r0,[r2,#0x0]	; 02303592
loc_02303594:
	add sp,#0x4	; 02303594
	pop {r3}	; 02303596
	bx r3	; 02303598
	.byte 0xC0, 0x46	; 0230359C
pool_0230359C:
loc_0230359C:
	.word 0x00001518	; 0230359C
pool_023035A0:
loc_023035A0:
	.word 0x0000012C	; 023035A0
pool_023035A4:
loc_023035A4:
	.word REG_VCOUNT	; 023035A4
pool_023035A8:
loc_023035A8:
	.word 0x000001F4	; 023035A8
pool_023035AC:
loc_023035AC:
	.word 0x000003E8	; 023035AC
pool_023035B0:
loc_023035B0:
	.word 0x000041A0	; 023035B0
pool_023035B4:
loc_023035B4:
	.word 0x00000249	; 023035B4

; ===== function loc_023035B8 =====
loc_023035B8:
	push {r4,r5,lr}	; 023035B8
	sub sp,#0x4	; 023035BA
	bl P4_GetRuntimeState	; 023035BC
	ldr r1,[pool_0230365C]	; 023035C0
	ldr r2,[r0,r1]	; 023035C2
	ldr r1,[r2,#0x0]	; 023035C4
	add r0,r1,#0x0	; 023035C6
	add r0,#0xd0	; 023035C8
	ldr r0,[r0,#0x0]	; 023035CA
	lsl r0,r0,#0x6	; 023035CC
	add r1,#0xd0	; 023035CE
	str r0,[r1,#0x0]	; 023035D0
	ldr r3,[pool_02303660]	; 023035D2
	ldrh r1,[r3,#0x0]	; 023035D4
	ldr r0,[pool_02303664]	; 023035D6
	ldrh r4,[r0,#0x0]	; 023035D8
	ldrh r3,[r3,#0x0]	; 023035DA
	cmp r1,r3	; 023035DC
	bls loc_023035E2	; 023035DE
	ldrh r4,[r0,#0x0]	; 023035E0
loc_023035E2:
	lsl r4,r4,#0x10	; 023035E2
	orr r4,r3	; 023035E4
	ldr r0,[pool_02303668]	; 023035E6
	ldrh r1,[r0,#0x0]	; 023035E8
	ldr r3,[pool_0230366C]	; 023035EA
	and r4,r3	; 023035EC
	lsl r4,r4,#0x1	; 023035EE
	ldr r0,[pool_02303670]	; 023035F0
	sub r1,r0,r1	; 023035F2
	mov r0,#0x7f	; 023035F4
	mul r1,r0	; 023035F6
	add r0,r4,r1	; 023035F8
	lsr r1,r0,#0x1	; 023035FA
	and r1,r3	; 023035FC
	ldr r3,[r2,#0x0]	; 023035FE
	add r0,r3,#0x0	; 02303600
	add r0,#0xd0	; 02303602
	ldr r0,[r0,#0x0]	; 02303604
	cmp r0,r1	; 02303606
	bls loc_02303612	; 02303608
	mov r0,#0x0	; 0230360A
	add r3,#0xd8	; 0230360C
	str r0,[r3,#0x0]	; 0230360E
	b loc_02303652	; 02303610
loc_02303612:
	mov r3,#0x1	; 02303612
	ldr r5,[pool_02303674]	; 02303614
	b loc_0230364E	; 02303616
loc_02303618:
	ldr r0,[r2,#0x0]	; 02303618
	add r4,r0,#0x0	; 0230361A
	add r4,#0xd0	; 0230361C
	ldr r4,[r4,#0x0]	; 0230361E
	cmp r4,r1	; 02303620
	bls loc_02303640	; 02303622
	sub r1,r4,r1	; 02303624
	add r0,#0xd8	; 02303626
	str r1,[r0,#0x0]	; 02303628
	ldr r2,[r2,#0x0]	; 0230362A
	add r0,r2,#0x0	; 0230362C
	add r0,#0xd8	; 0230362E
	ldr r1,[r0,#0x0]	; 02303630
	ldr r0,[pool_02303678]	; 02303632
	cmp r1,r0	; 02303634
	bls loc_02303652	; 02303636
	mov r0,#0x0	; 02303638
	add r2,#0xd8	; 0230363A
	str r0,[r2,#0x0]	; 0230363C
	b loc_02303652	; 0230363E
loc_02303640:
	add r4,r0,#0x0	; 02303640
	add r4,#0xd0	; 02303642
	ldr r4,[r4,#0x0]	; 02303644
	add r4,r4,r5	; 02303646
	add r0,#0xd0	; 02303648
	str r4,[r0,#0x0]	; 0230364A
	add r3,r3,#0x1	; 0230364C
loc_0230364E:
	cmp r3,#0x1e	; 0230364E
	blt loc_02303618	; 02303650
loc_02303652:
	add sp,#0x4	; 02303652
	pop {r4,r5}	; 02303654
	pop {r3}	; 02303656
	bx r3	; 02303658
	.byte 0xC0, 0x46	; 0230365C
pool_0230365C:
loc_0230365C:
	.word 0x00001518	; 0230365C
pool_02303660:
loc_02303660:
	.word REG_WIFI_US_COUNT0	; 02303660
pool_02303664:
loc_02303664:
	.word REG_WIFI_US_COUNT1	; 02303664
pool_02303668:
loc_02303668:
	.word REG_VCOUNT	; 02303668
pool_0230366C:
loc_0230366C:
	.word 0x003FFFC0	; 0230366C
pool_02303670:
loc_02303670:
	.word 0x00000107	; 02303670
pool_02303674:
loc_02303674:
	.word 0x0000414B	; 02303674
pool_02303678:
loc_02303678:
	.word 0x00004000	; 02303678

; ===== function loc_0230367C =====
loc_0230367C:
; 对 Wi-Fi 微秒计数作 VCOUNT 校正，截为 16 位后写入共享槽。
; Adjust the Wi-Fi microsecond count using VCOUNT, storing its low 16-bit result.
.func P4_UpdateScanlineAdjustedWifiTime
	push {r4,lr}	; 0230367C
	ldr r0,[pool_023036AC]	; 0230367E
	ldrh r0,[r0,#0x0]	; 02303680
	ldr r3,[pool_023036B0]	; 02303682
	ldrh r2,[r3,#0x0]	; 02303684
	ldr r1,[pool_023036B4]	; 02303686
	ldrh r4,[r1,#0x0]	; 02303688
	ldrh r3,[r3,#0x0]	; 0230368A
	cmp r2,r3	; 0230368C
	bls loc_02303692	; 0230368E
	ldrh r4,[r1,#0x0]	; 02303690
loc_02303692:
	lsl r1,r4,#0x10	; 02303692
	orr r1,r3	; 02303694
	lsl r2,r1,#0x1	; 02303696
	mov r1,#0x7f	; 02303698
	mul r0,r1	; 0230369A
	sub r0,r2,r0	; 0230369C
	lsr r1,r0,#0x7	; 0230369E
	ldr r0,[pool_023036B8]	; 023036A0
	strh r1,[r0,#0x0]	; 023036A2
	pop {r4}	; 023036A4
	pop {r3}	; 023036A6
	bx r3	; 023036A8
.endfunc
	.byte 0xC0, 0x46	; 023036AC
pool_023036AC:
loc_023036AC:
	.word REG_VCOUNT	; 023036AC
pool_023036B0:
loc_023036B0:
	.word REG_WIFI_US_COUNT0	; 023036B0
pool_023036B4:
loc_023036B4:
	.word REG_WIFI_US_COUNT1	; 023036B4
pool_023036B8:
loc_023036B8:
	.word FirmwareWlAdjustedTimeSlot	; 023036B8

; ===== function loc_023036BC =====
	push {lr}	; 023036BC
	sub sp,#0x4	; 023036BE
	cmp r0,#0xd3	; 023036C0
	bhi loc_023036D8	; 023036C2
	cmp r0,#0xd2	; 023036C4
	bcc loc_023036D2	; 023036C6
	cmp r0,#0xd2	; 023036C8
	beq loc_023036F4	; 023036CA
	cmp r0,#0xd3	; 023036CC
	beq loc_02303700	; 023036CE
	b loc_0230370E	; 023036D0
loc_023036D2:
	cmp r0,#0xc8	; 023036D2
	beq loc_023036EA	; 023036D4
	b loc_0230370E	; 023036D6
loc_023036D8:
	cmp r0,#0xf0	; 023036D8
	bhi loc_023036E2	; 023036DA
	cmp r0,#0xf0	; 023036DC
	beq loc_023036FA	; 023036DE
	b loc_0230370E	; 023036E0
loc_023036E2:
	ldr r1,[pool_02303714]	; 023036E2
	cmp r0,r1	; 023036E4
	beq loc_0230370A	; 023036E6
	b loc_0230370E	; 023036E8
loc_023036EA:
	bl loc_02303338	; 023036EA
	bl loc_02303484	; 023036EE
	b loc_0230370E	; 023036F2
loc_023036F4:
	bl loc_0230343C	; 023036F4
	b loc_0230370E	; 023036F8
loc_023036FA:
	bl loc_02303408	; 023036FA
	b loc_0230370E	; 023036FE
loc_02303700:
	bl loc_02303338	; 02303700
	bl loc_023033A0	; 02303704
	b loc_0230370E	; 02303708
loc_0230370A:
	bl loc_0230335C	; 0230370A
loc_0230370E:
	add sp,#0x4	; 0230370E
	pop {r3}	; 02303710
	bx r3	; 02303712
pool_02303714:
loc_02303714:
	.word 0x00000104	; 02303714

; ===== function loc_02303718 =====
loc_02303718:
	push {r4,lr}	; 02303718
	sub sp,#0x8	; 0230371A
	bl P4_GetRuntimeState	; 0230371C
	ldr r1,[pool_0230376C]	; 02303720
	ldr r4,[r0,r1]	; 02303722
	ldr r1,[r4,#0x0]	; 02303724
	add r0,r1,#0x0	; 02303726
	add r0,#0xe6	; 02303728
	ldrh r0,[r0,#0x0]	; 0230372A
	cmp r0,#0x1	; 0230372C
	bne loc_02303742	; 0230372E
	mov r1,#0xd3	; 02303730
	str r1,[sp,#0x0]	; 02303732
	add r4,#0xd0	; 02303734
	add r0,r4,#0x0	; 02303736
	mov r2,#0xa	; 02303738
	ldr r3,[pool_02303770]	; 0230373A
	bl loc_02303390	; 0230373C
	b loc_02303762	; 02303740
loc_02303742:
	cmp r0,#0x2	; 02303742
	bne loc_02303762	; 02303744
	mov r0,#0x0	; 02303746
	str r0,[r1,#0x24]	; 02303748
	mov r1,#0xc8	; 0230374A
	str r1,[sp,#0x0]	; 0230374C
	add r0,r4,#0x0	; 0230374E
	add r0,#0xd0	; 02303750
	mov r2,#0xa	; 02303752
	ldr r3,[pool_02303770]	; 02303754
	bl loc_02303390	; 02303756
	mov r1,#0x0	; 0230375A
	ldr r0,[r4,#0x0]	; 0230375C
	add r0,#0xd8	; 0230375E
	str r1,[r0,#0x0]	; 02303760
loc_02303762:
	add sp,#0x8	; 02303762
	pop {r4}	; 02303764
	pop {r3}	; 02303766
	bx r3	; 02303768
	.byte 0xC0, 0x46	; 0230376C
pool_0230376C:
loc_0230376C:
	.word 0x00001518	; 0230376C
pool_02303770:
loc_02303770:
	.word 0x023036BD	; 02303770

; ===== function loc_02303774 =====
loc_02303774:
	push {lr}	; 02303774
	sub sp,#0x4	; 02303776
	bl P4_GetRuntimeState	; 02303778
	ldr r1,[pool_0230378C]	; 0230377C
	ldr r0,[r0,r1]	; 0230377E
	add r0,#0xd0	; 02303780
	bl loc_02303790	; 02303782
	add sp,#0x4	; 02303786
	pop {r3}	; 02303788
	bx r3	; 0230378A
pool_0230378C:
loc_0230378C:
	.word 0x00001518	; 0230378C

; ===== function loc_02303790 =====
loc_02303790:
	bx pc	; 02303790
	.byte 0xC0, 0x46	; 02303794
.arm

; ===== function loc_02303794 =====
loc_02303794:
	ldr r12,[pool_0230379C]	; 02303794
	bx r12	; 02303798
pool_0230379C:
loc_0230379C:
	.word loc_037FEFFC + 1	; 0230379C
.thumb

; ===== function loc_023037A0 =====
	push {r4,lr}	; 023037A0
	add r4,r0,#0x0	; 023037A2
	bl P4_GetRuntimeState	; 023037A4
	ldr r1,[pool_023037C4]	; 023037A8
	ldr r0,[r0,r1]	; 023037AA
	ldr r0,[r0,#0x0]	; 023037AC
	ldrh r0,[r0,#0x0]	; 023037AE
	cmp r0,#0x9	; 023037B0
	bne loc_023037BE	; 023037B2
	ldr r0,[r4,#0x4]	; 023037B4
	lsl r0,r0,#0x10	; 023037B6
	lsr r0,r0,#0x10	; 023037B8
	bl loc_0230422C	; 023037BA
loc_023037BE:
	pop {r4}	; 023037BE
	pop {r3}	; 023037C0
	bx r3	; 023037C2
pool_023037C4:
loc_023037C4:
	.word 0x00001518	; 023037C4

; ===== function loc_023037C8 =====
	push {lr}	; 023037C8
	sub sp,#0x4	; 023037CA
	bl P4_GetRuntimeState	; 023037CC
	ldr r1,[pool_023037E8]	; 023037D0
	ldr r0,[r0,r1]	; 023037D2
	ldr r0,[r0,#0x0]	; 023037D4
	ldrh r0,[r0,#0x0]	; 023037D6
	cmp r0,#0xa	; 023037D8
	bne loc_023037E0	; 023037DA
	bl loc_023043A0	; 023037DC
loc_023037E0:
	add sp,#0x4	; 023037E0
	pop {r3}	; 023037E2
	bx r3	; 023037E4
	.byte 0xC0, 0x46	; 023037E8
pool_023037E8:
loc_023037E8:
	.word 0x00001518	; 023037E8

; ===== function loc_023037EC =====
	push {r4,lr}	; 023037EC
	add r4,r0,#0x0	; 023037EE
	bl P4_GetRuntimeState	; 023037F0
	ldr r1,[pool_02303810]	; 023037F4
	ldr r0,[r0,r1]	; 023037F6
	ldr r0,[r0,#0x0]	; 023037F8
	ldrh r0,[r0,#0x0]	; 023037FA
	cmp r0,#0x9	; 023037FC
	bne loc_0230380A	; 023037FE
	ldr r0,[r4,#0x4]	; 02303800
	lsl r0,r0,#0x10	; 02303802
	lsr r0,r0,#0x10	; 02303804
	bl loc_02304274	; 02303806
loc_0230380A:
	pop {r4}	; 0230380A
	pop {r3}	; 0230380C
	bx r3	; 0230380E
pool_02303810:
loc_02303810:
	.word 0x00001518	; 02303810

; ===== function loc_02303814 =====
	push {r4,r5,lr}	; 02303814
	sub sp,#0x4	; 02303816
	bl P4_GetRuntimeState	; 02303818
	ldr r1,[pool_023038D4]	; 0230381C
	ldr r0,[r0,r1]	; 0230381E
	ldr r5,[r0,#0x0]	; 02303820
	mov r1,#0x1	; 02303822
	add r0,r5,#0x0	; 02303824
	add r0,#0x8c	; 02303826
	strh r1,[r0,#0x0]	; 02303828
	ldrh r0,[r5,#0x0]	; 0230382A
	cmp r0,#0x9	; 0230382C
	bne loc_023038A2	; 0230382E
	bl loc_023038E4	; 02303830
	ldrh r1,[r5,#0x3e]	; 02303834
	cmp r1,#0x0	; 02303836
	bne loc_0230383E	; 02303838
	mov r1,#0x1	; 0230383A
	b loc_02303840	; 0230383C
loc_0230383E:
	mov r1,#0x0	; 0230383E
loc_02303840:
	ldrh r3,[r5,#0x3e]	; 02303840
	ldrh r2,[r5,#0x3c]	; 02303842
	add r2,r3,r2	; 02303844
	strh r2,[r5,#0x3e]	; 02303846
	ldrh r3,[r5,#0x3e]	; 02303848
	ldr r2,[pool_023038D8]	; 0230384A
	cmp r3,r2	; 0230384C
	bls loc_02303852	; 0230384E
	strh r2,[r5,#0x3e]	; 02303850
loc_02303852:
	cmp r1,#0x0	; 02303852
	beq loc_02303860	; 02303854
	ldrh r1,[r5,#0x3e]	; 02303856
	cmp r1,#0x0	; 02303858
	beq loc_02303860	; 0230385A
	mov r4,#0x1	; 0230385C
	b loc_02303862	; 0230385E
loc_02303860:
	mov r4,#0x0	; 02303860
loc_02303862:
	bl loc_023038F0	; 02303862
	cmp r4,#0x0	; 02303866
	beq loc_02303870	; 02303868
	ldr r0,[pool_023038DC]	; 0230386A
	bl loc_02304274	; 0230386C
loc_02303870:
	add r0,r5,#0x0	; 02303870
	add r0,#0x96	; 02303872
	ldrh r0,[r0,#0x0]	; 02303874
	cmp r0,#0x1	; 02303876
	bne loc_023038CC	; 02303878
	add r0,r5,#0x0	; 0230387A
	add r0,#0xa0	; 0230387C
	ldrh r0,[r0,#0x0]	; 0230387E
	sub r1,r0,#0x1	; 02303880
	add r0,r5,#0x0	; 02303882
	add r0,#0xa0	; 02303884
	strh r1,[r0,#0x0]	; 02303886
	add r0,r5,#0x0	; 02303888
	add r0,#0xa0	; 0230388A
	ldrh r0,[r0,#0x0]	; 0230388C
	cmp r0,#0x0	; 0230388E
	bne loc_023038CC	; 02303890
	mov r1,#0x1	; 02303892
	add r0,r5,#0x0	; 02303894
	add r0,#0x9e	; 02303896
	strh r1,[r0,#0x0]	; 02303898
	mov r0,#0x3c	; 0230389A
	add r5,#0xa0	; 0230389C
	strh r0,[r5,#0x0]	; 0230389E
	b loc_023038CC	; 023038A0
loc_023038A2:
	cmp r0,#0xa	; 023038A2
	bne loc_023038CC	; 023038A4
	mov r4,#0x0	; 023038A6
	bl loc_023038FC	; 023038A8
	ldrh r1,[r5,#0x3a]	; 023038AC
	cmp r1,#0x1	; 023038AE
	bne loc_023038C0	; 023038B0
	ldr r1,[pool_023038E0]	; 023038B2
	ldr r1,[r5,r1]	; 023038B4
	cmp r1,#0x1	; 023038B6
	beq loc_023038C0	; 023038B8
	mov r4,#0x1	; 023038BA
	mov r1,#0x0	; 023038BC
	strh r1,[r5,#0x3a]	; 023038BE
loc_023038C0:
	bl loc_02303908	; 023038C0
	cmp r4,#0x1	; 023038C4
	bne loc_023038CC	; 023038C6
	bl loc_023043A0	; 023038C8
loc_023038CC:
	add sp,#0x4	; 023038CC
	pop {r4,r5}	; 023038CE
	pop {r3}	; 023038D0
	bx r3	; 023038D2
pool_023038D4:
loc_023038D4:
	.word 0x00001518	; 023038D4
pool_023038D8:
loc_023038D8:
	.word 0x00000100	; 023038D8
pool_023038DC:
loc_023038DC:
	.word 0x0000FFFF	; 023038DC
pool_023038E0:
loc_023038E0:
	.word 0x00000930	; 023038E0

; ===== function loc_023038E4 =====
loc_023038E4:
	bx pc	; 023038E4
	.byte 0xC0, 0x46	; 023038E8
.arm

; ===== function loc_023038E8 =====
loc_023038E8:
	ldr pc,[pool_023038EC]	; 023038E8
pool_023038EC:
loc_023038EC:
	.word loc_037FF104	; 023038EC
.thumb

; ===== function loc_023038F0 =====
loc_023038F0:
	bx pc	; 023038F0
	.byte 0xC0, 0x46	; 023038F4
.arm

; ===== function loc_023038F4 =====
loc_023038F4:
	ldr pc,[pool_023038F8]	; 023038F4
pool_023038F8:
loc_023038F8:
	.word loc_037FF118	; 023038F8
.thumb

; ===== function loc_023038FC =====
loc_023038FC:
	bx pc	; 023038FC
	.byte 0xC0, 0x46	; 02303900
.arm

; ===== function loc_02303900 =====
loc_02303900:
	ldr pc,[pool_02303904]	; 02303900
pool_02303904:
loc_02303904:
	.word loc_037FF104	; 02303904
.thumb

; ===== function loc_02303908 =====
loc_02303908:
	bx pc	; 02303908
	.byte 0xC0, 0x46	; 0230390C
.arm

; ===== function loc_0230390C =====
loc_0230390C:
	ldr pc,[pool_02303910]	; 0230390C
pool_02303910:
loc_02303910:
	.word loc_037FF118	; 02303910
.thumb

; ===== function loc_02303914 =====
loc_02303914:
	push {r4,r5,r6,r7,lr}	; 02303914
	sub sp,#0x4	; 02303916
	add r7,r0,#0x0	; 02303918
	add r0,r1,#0x0	; 0230391A
	add r6,r2,#0x0	; 0230391C
	mov r5,#0x0	; 0230391E
	add r4,r5,#0x0	; 02303920
	mov r1,#0x1	; 02303922
loc_02303924:
	add r2,r1,#0x0	; 02303924
	lsl r2,r4	; 02303926
	add r3,r6,#0x0	; 02303928
	and r3,r2	; 0230392A
	cmp r3,#0x0	; 0230392C
	beq loc_02303936	; 0230392E
	add r2,r5,#0x1	; 02303930
	lsl r2,r2,#0x10	; 02303932
	lsr r5,r2,#0x10	; 02303934
loc_02303936:
	add r4,r4,#0x1	; 02303936
	cmp r4,#0x10	; 02303938
	blt loc_02303924	; 0230393A
	add r7,#0x22	; 0230393C
	lsl r2,r7,#0x2	; 0230393E
	add r2,#0x60	; 02303940
	mul r0,r5	; 02303942
	ldr r1,[pool_0230397C]	; 02303944
	add r0,r0,r1	; 02303946
	add r4,r2,r0	; 02303948
	ldr r0,[pool_02303980]	; 0230394A
	ldrh r1,[r0,#0x0]	; 0230394C
	ldr r0,[pool_02303984]	; 0230394E
	sub r0,r0,r1	; 02303950
	cmp r0,#0x0	; 02303952
	bge loc_0230395A	; 02303954
	ldr r1,[pool_02303988]	; 02303956
	add r0,r0,r1	; 02303958
loc_0230395A:
	mov r1,#0x7f	; 0230395A
	mul r0,r1	; 0230395C
	mov r1,#0x14	; 0230395E
	bl loc_0230398C	; 02303960
	mov r1,#0xa	; 02303964
	add r2,r0,#0x0	; 02303966
	mul r2,r1	; 02303968
	cmp r2,r4	; 0230396A
	bcs loc_02303970	; 0230396C
	mov r0,#0x0	; 0230396E
loc_02303970:
	lsl r0,r0,#0x10	; 02303970
	lsr r0,r0,#0x10	; 02303972
	add sp,#0x4	; 02303974
	pop {r4,r5,r6,r7}	; 02303976
	pop {r3}	; 02303978
	bx r3	; 0230397A
pool_0230397C:
loc_0230397C:
	.word 0x00000388	; 0230397C
pool_02303980:
loc_02303980:
	.word REG_VCOUNT	; 02303980
pool_02303984:
loc_02303984:
	.word 0x00000102	; 02303984
pool_02303988:
loc_02303988:
	.word 0x00000107	; 02303988

; ===== function loc_0230398C =====
loc_0230398C:
	bx pc	; 0230398C
	.byte 0xC0, 0x46	; 02303990
.arm

; ===== function loc_02303990 =====
loc_02303990:
	ldr pc,[pool_02303994]	; 02303990
pool_02303994:
loc_02303994:
	.word P2_SignedDivMod	; 02303994
.thumb

; ===== function loc_02303998 =====
loc_02303998:
	push {r0,r1,r2,r3}	; 02303998
	push {r4,r5,r6,r7,lr}	; 0230399A
	sub sp,#0x34	; 0230399C
	str r0,[sp,#0x0]	; 0230399E
	str r2,[sp,#0x4]	; 023039A0
	add r6,r3,#0x0	; 023039A2
	ldr r0,[sp,#0x58]	; 023039A4
	str r0,[sp,#0x58]	; 023039A6
	bl P4_GetRuntimeState	; 023039A8
	ldr r1,[pool_02303B18]	; 023039AC
	ldr r0,[r0,r1]	; 023039AE
	ldr r0,[r0,#0x0]	; 023039B0
	str r0,[sp,#0x8]	; 023039B2
	cmp r6,#0x0	; 023039B4
	bne loc_023039BA	; 023039B6
	b loc_02303B0C	; 023039B8
loc_023039BA:
	ldr r1,[pool_02303B1C]	; 023039BA
	ldrh r0,[r0,r1]	; 023039BC
	cmp r6,r0	; 023039BE
	bls loc_023039C4	; 023039C0
	b loc_02303B0C	; 023039C2
loc_023039C4:
	ldr r1,[sp,#0x8]	; 023039C4
	ldr r0,[pool_02303B20]	; 023039C6
	ldrh r1,[r1,r0]	; 023039C8
	ldr r0,[sp,#0x0]	; 023039CA
	cmp r0,r1	; 023039CC
	bne loc_023039D2	; 023039CE
	b loc_02303B0C	; 023039D0
loc_023039D2:
	cmp r0,#0x10	; 023039D2
	bcc loc_023039D8	; 023039D4
	b loc_02303B0C	; 023039D6
loc_023039D8:
	mov r0,#0x1	; 023039D8
	str r0,[sp,#0xc]	; 023039DA
	add r1,r6,#0x0	; 023039DC
	and r1,r0	; 023039DE
	cmp r1,#0x0	; 023039E0
	beq loc_023039E6	; 023039E2
	b loc_02303B0C	; 023039E4
loc_023039E6:
	cmp r6,#0x0	; 023039E6
	bgt loc_023039EC	; 023039E8
	b loc_02303B0C	; 023039EA
loc_023039EC:
	ldr r1,[pool_02303B24]	; 023039EC
	ldr r0,[sp,#0x8]	; 023039EE
	add r1,r0,r1	; 023039F0
	ldr r0,[sp,#0x0]	; 023039F2
	lsl r0,r0,#0x4	; 023039F4
	add r0,r1,r0	; 023039F6
	str r0,[sp,#0x14]	; 023039F8
	ldr r0,[sp,#0xc]	; 023039FA
	str r0,[sp,#0x18]	; 023039FC
	str r0,[sp,#0x1c]	; 023039FE
	str r0,[sp,#0x24]	; 02303A00
	str r0,[sp,#0x28]	; 02303A02
loc_02303A04:
	ldr r4,[pool_02303B28]	; 02303A04
	ldr r0,[sp,#0xc]	; 02303A06
	cmp r0,#0x1	; 02303A08
	bne loc_02303A14	; 02303A0A
	mov r0,#0x0	; 02303A0C
	str r0,[sp,#0xc]	; 02303A0E
	add r1,sp,#0x4c	; 02303A10
	b loc_02303A1E	; 02303A12
loc_02303A14:
	ldr r1,[sp,#0x4]	; 02303A14
	lsl r0,r1,#0	; 02303A16
	add r0,r0,#0x2	; 02303A18
	str r0,[sp,#0x4]	; 02303A1A
	sub r6,r6,#0x2	; 02303A1C
loc_02303A1E:
	ldrh r1,[r1,#0x0]	; 02303A1E
	add r2,r1,#0x0	; 02303A20
	mov r0,#0xff	; 02303A22
	and r2,r0	; 02303A24
	lsl r5,r2,#0x1	; 02303A26
	add r2,r1,#0x0	; 02303A28
	ldr r0,[pool_02303B2C]	; 02303A2A
	and r2,r0	; 02303A2C
	cmp r2,#0x0	; 02303A2E
	beq loc_02303A38	; 02303A30
	ldr r0,[sp,#0x18]	; 02303A32
	str r0,[sp,#0x2c]	; 02303A34
	b loc_02303A3C	; 02303A36
loc_02303A38:
	mov r0,#0x0	; 02303A38
	str r0,[sp,#0x2c]	; 02303A3A
loc_02303A3C:
	add r2,r1,#0x0	; 02303A3C
	ldr r0,[pool_02303B30]	; 02303A3E
	and r2,r0	; 02303A40
	cmp r2,#0x0	; 02303A42
	beq loc_02303A4A	; 02303A44
	ldr r2,[sp,#0x1c]	; 02303A46
	b loc_02303A4C	; 02303A48
loc_02303A4A:
	mov r2,#0x0	; 02303A4A
loc_02303A4C:
	ldr r0,[sp,#0x2c]	; 02303A4C
	cmp r0,#0x0	; 02303A4E
	beq loc_02303A56	; 02303A50
	mov r3,#0x2	; 02303A52
	b loc_02303A58	; 02303A54
loc_02303A56:
	mov r3,#0x0	; 02303A56
loc_02303A58:
	cmp r2,#0x0	; 02303A58
	beq loc_02303A60	; 02303A5A
	mov r0,#0x2	; 02303A5C
	b loc_02303A62	; 02303A5E
loc_02303A60:
	mov r0,#0x0	; 02303A60
loc_02303A62:
	add r0,r5,r0	; 02303A62
	add r0,r0,r3	; 02303A64
	sub r6,r6,r0	; 02303A66
	cmp r6,#0x0	; 02303A68
	blt loc_02303B0C	; 02303A6A
	ldr r3,[pool_02303B34]	; 02303A6C
	and r1,r3	; 02303A6E
	lsl r1,r1,#0x8	; 02303A70
	lsr r1,r1,#0x10	; 02303A72
	str r1,[sp,#0x30]	; 02303A74
	ldr r1,[sp,#0x4]	; 02303A76
	str r1,[sp,#0x10]	; 02303A78
	add r3,r1,r5	; 02303A7A
	add r0,r1,r0	; 02303A7C
	str r0,[sp,#0x4]	; 02303A7E
	cmp r2,#0x1	; 02303A80
	bne loc_02303ABA	; 02303A82
	ldr r1,[sp,#0x30]	; 02303A84
	mov r0,#0x7	; 02303A86
	and r1,r0	; 02303A88
	lsl r1,r1,#0x1	; 02303A8A
	ldr r0,[sp,#0x14]	; 02303A8C
	add r2,r0,r1	; 02303A8E
	ldrh r7,[r0,r1]	; 02303A90
	ldrh r4,[r3,#0x0]	; 02303A92
	add r3,r3,#0x2	; 02303A94
	add r1,r7,#0x0	; 02303A96
	str r1,[sp,#0x20]	; 02303A98
	ldr r0,[sp,#0x28]	; 02303A9A
	and r1,r0	; 02303A9C
	str r1,[sp,#0x20]	; 02303A9E
	cmp r1,#0x0	; 02303AA0
	beq loc_02303AAA	; 02303AA2
	lsl r0,r4,#0x1	; 02303AA4
	strh r0,[r2,#0x0]	; 02303AA6
	b loc_02303ABA	; 02303AA8
loc_02303AAA:
	lsl r0,r4,#0x11	; 02303AAA
	lsr r4,r0,#0x10	; 02303AAC
	sub r0,r7,r4	; 02303AAE
	lsl r0,r0,#0x10	; 02303AB0
	lsr r0,r0,#0x10	; 02303AB2
	cmp r0,#0x80	; 02303AB4
	bcc loc_02303B06	; 02303AB6
	strh r4,[r2,#0x0]	; 02303AB8
loc_02303ABA:
	ldr r0,[sp,#0x2c]	; 02303ABA
	cmp r0,#0x1	; 02303ABC
	bne loc_02303AD2	; 02303ABE
	ldrh r0,[r3,#0x0]	; 02303AC0
	ldr r2,[sp,#0x8]	; 02303AC2
	ldr r1,[pool_02303B20]	; 02303AC4
	ldrh r1,[r2,r1]	; 02303AC6
	ldr r2,[sp,#0x24]	; 02303AC8
	lsl r2,r1	; 02303ACA
	and r0,r2	; 02303ACC
	cmp r0,#0x0	; 02303ACE
	beq loc_02303B06	; 02303AD0
loc_02303AD2:
	cmp r5,#0x0	; 02303AD2
	ble loc_02303B06	; 02303AD4
	bl P4_AcquireCommandSlot	; 02303AD6
	mov r1,#0x82	; 02303ADA
	strh r1,[r0,#0x0]	; 02303ADC
	mov r1,#0x0	; 02303ADE
	strh r1,[r0,#0x2]	; 02303AE0
	mov r1,#0x15	; 02303AE2
	strh r1,[r0,#0x4]	; 02303AE4
	ldr r1,[sp,#0x30]	; 02303AE6
	strh r1,[r0,#0x6]	; 02303AE8
	ldr r1,[sp,#0x58]	; 02303AEA
	str r1,[r0,#0x8]	; 02303AEC
	ldr r1,[sp,#0x10]	; 02303AEE
	str r1,[r0,#0xc]	; 02303AF0
	strh r5,[r0,#0x10]	; 02303AF2
	ldr r1,[sp,#0x0]	; 02303AF4
	strh r1,[r0,#0x12]	; 02303AF6
	ldr r2,[sp,#0x8]	; 02303AF8
	ldr r1,[pool_02303B20]	; 02303AFA
	ldrh r1,[r2,r1]	; 02303AFC
	strh r1,[r0,#0x20]	; 02303AFE
	strh r4,[r0,#0x1a]	; 02303B00
	bl P4_SubmitCommandSlot	; 02303B02
loc_02303B06:
	cmp r6,#0x0	; 02303B06
	ble loc_02303B0C	; 02303B08
	b loc_02303A04	; 02303B0A
loc_02303B0C:
	add sp,#0x34	; 02303B0C
	pop {r4,r5,r6,r7}	; 02303B0E
	pop {r3}	; 02303B10
	add sp,#0x10	; 02303B12
	bx r3	; 02303B14
	.byte 0xC0, 0x46	; 02303B18
pool_02303B18:
loc_02303B18:
	.word 0x00001518	; 02303B18
pool_02303B1C:
loc_02303B1C:
	.word 0x00000194	; 02303B1C
pool_02303B20:
loc_02303B20:
	.word 0x00000188	; 02303B20
pool_02303B24:
loc_02303B24:
	.word 0x000001F8	; 02303B24
pool_02303B28:
loc_02303B28:
	.word 0x0000FFFF	; 02303B28
pool_02303B2C:
loc_02303B2C:
	.word 0x00001000	; 02303B2C
pool_02303B30:
loc_02303B30:
	.word 0x00000800	; 02303B30
pool_02303B34:
loc_02303B34:
	.word 0x00000F00	; 02303B34

; ===== function loc_02303B38 =====
loc_02303B38:
	push {r4,r5,r6,r7,lr}	; 02303B38
	sub sp,#0x34	; 02303B3A
	str r0,[sp,#0x0]	; 02303B3C
	str r1,[sp,#0x4]	; 02303B3E
	bl P4_GetRuntimeState	; 02303B40
	ldr r1,[pool_02303D4C]	; 02303B44
	ldr r0,[r0,r1]	; 02303B46
	ldr r0,[r0,#0x0]	; 02303B48
	str r0,[sp,#0x8]	; 02303B4A
	ldr r1,[pool_02303D50]	; 02303B4C
	add r0,r0,r1	; 02303B4E
	str r0,[sp,#0xc]	; 02303B50
	mov r0,#0x0	; 02303B52
	str r0,[sp,#0x14]	; 02303B54
	ldr r0,[sp,#0x8]	; 02303B56
	ldrh r0,[r0,#0x0]	; 02303B58
	cmp r0,#0x9	; 02303B5A
	bne loc_02303B62	; 02303B5C
	mov r4,#0x1	; 02303B5E
	b loc_02303B74	; 02303B60
loc_02303B62:
	cmp r0,#0xa	; 02303B62
	bne loc_02303B6A	; 02303B64
	ldr r4,[sp,#0x14]	; 02303B66
	b loc_02303B74	; 02303B68
loc_02303B6A:
	ldr r0,[sp,#0x14]	; 02303B6A
	add sp,#0x34	; 02303B6C
	pop {r4,r5,r6,r7}	; 02303B6E
	pop {r3}	; 02303B70
	bx r3	; 02303B72
loc_02303B74:
	ldr r1,[pool_02303D54]	; 02303B74
	ldr r0,[sp,#0x8]	; 02303B76
	add r0,r0,r1	; 02303B78
	bl loc_02303D74	; 02303B7A
	ldr r1,[pool_02303D58]	; 02303B7E
	ldr r0,[sp,#0x8]	; 02303B80
	ldr r0,[r0,r1]	; 02303B82
	cmp r0,#0x0	; 02303B84
	bne loc_02303B9C	; 02303B86
	ldr r1,[pool_02303D54]	; 02303B88
	ldr r0,[sp,#0x8]	; 02303B8A
	add r0,r0,r1	; 02303B8C
	bl loc_02303D84	; 02303B8E
	mov r0,#0x0	; 02303B92
	add sp,#0x34	; 02303B94
	pop {r4,r5,r6,r7}	; 02303B96
	pop {r3}	; 02303B98
	bx r3	; 02303B9A
loc_02303B9C:
	cmp r4,#0x1	; 02303B9C
	bne loc_02303BA8	; 02303B9E
	ldr r0,[sp,#0x8]	; 02303BA0
	add r0,#0x8a	; 02303BA2
	ldrh r2,[r0,#0x0]	; 02303BA4
	b loc_02303BAA	; 02303BA6
loc_02303BA8:
	mov r2,#0x1	; 02303BA8
loc_02303BAA:
	mov r0,#0x0	; 02303BAA
	str r0,[sp,#0x10]	; 02303BAC
	ldr r1,[pool_02303D5C]	; 02303BAE
	ldr r0,[sp,#0x8]	; 02303BB0
	add r6,r0,r1	; 02303BB2
	str r0,[sp,#0x20]	; 02303BB4
	lsl r0,r2,#0x10	; 02303BB6
	lsr r0,r0,#0x10	; 02303BB8
	str r0,[sp,#0x24]	; 02303BBA
	ldr r1,[sp,#0x4]	; 02303BBC
	str r1,[sp,#0x28]	; 02303BBE
	and r1,r0	; 02303BC0
	str r1,[sp,#0x28]	; 02303BC2
	ldr r7,[pool_02303D60]	; 02303BC4
	ldr r0,[sp,#0x10]	; 02303BC6
	str r0,[sp,#0x30]	; 02303BC8
	str r0,[sp,#0x2c]	; 02303BCA
loc_02303BCC:
	str r7,[sp,#0x18]	; 02303BCC
	str r7,[sp,#0x1c]	; 02303BCE
	ldrh r5,[r6,#0x0]	; 02303BD0
	cmp r5,r7	; 02303BD2
	bne loc_02303BD8	; 02303BD4
	b loc_02303CF0	; 02303BD6
loc_02303BD8:
	add r1,r5,#0x0	; 02303BD8
	mov r0,#0x18	; 02303BDA
	mul r1,r0	; 02303BDC
	ldr r0,[sp,#0xc]	; 02303BDE
	add r4,r0,r1	; 02303BE0
	ldrh r0,[r4,#0x4]	; 02303BE2
	add r2,r0,#0x0	; 02303BE4
	ldr r1,[sp,#0x24]	; 02303BE6
	and r2,r1	; 02303BE8
	cmp r2,#0x0	; 02303BEA
	beq loc_02303C50	; 02303BEC
	ldr r1,[sp,#0x0]	; 02303BEE
	cmp r1,#0x0	; 02303BF0
	bne loc_02303BFC	; 02303BF2
	ldr r1,[sp,#0x4]	; 02303BF4
	and r1,r0	; 02303BF6
	cmp r1,#0x0	; 02303BF8
	beq loc_02303C50	; 02303BFA
loc_02303BFC:
	ldrh r1,[r4,#0x2]	; 02303BFC
	mov r0,#0x8	; 02303BFE
	and r1,r0	; 02303C00
	cmp r1,#0x0	; 02303C02
	bne loc_02303C0C	; 02303C04
	ldrh r0,[r4,#0xa]	; 02303C06
	cmp r0,#0x0	; 02303C08
	beq loc_02303C50	; 02303C0A
loc_02303C0C:
	mov r0,#0x1	; 02303C0C
	str r0,[sp,#0x14]	; 02303C0E
	ldrh r0,[r4,#0xa]	; 02303C10
	cmp r0,#0x0	; 02303C12
	beq loc_02303C1A	; 02303C14
	sub r0,r0,#0x1	; 02303C16
	strh r0,[r4,#0xa]	; 02303C18
loc_02303C1A:
	ldr r0,[sp,#0x0]	; 02303C1A
	cmp r0,#0x0	; 02303C1C
	bne loc_02303C28	; 02303C1E
	ldrh r1,[r4,#0x4]	; 02303C20
	ldr r0,[sp,#0x4]	; 02303C22
	and r1,r0	; 02303C24
	strh r1,[r4,#0x4]	; 02303C26
loc_02303C28:
	ldrh r0,[r4,#0x0]	; 02303C28
	cmp r0,r7	; 02303C2A
	bne loc_02303C30	; 02303C2C
	strh r7,[r6,#0x2]	; 02303C2E
loc_02303C30:
	ldrh r0,[r4,#0x0]	; 02303C30
	strh r0,[r6,#0x0]	; 02303C32
	strh r7,[r4,#0x0]	; 02303C34
	ldr r0,[sp,#0x18]	; 02303C36
	cmp r0,r7	; 02303C38
	bne loc_02303C40	; 02303C3A
	str r5,[sp,#0x1c]	; 02303C3C
	b loc_02303C4C	; 02303C3E
loc_02303C40:
	lsl r1,r0,#0	; 02303C40
	mov r0,#0x18	; 02303C42
	mul r1,r0	; 02303C44
	str r1,[sp,#0x18]	; 02303C46
	ldr r0,[sp,#0xc]	; 02303C48
	strh r5,[r0,r1]	; 02303C4A
loc_02303C4C:
	str r5,[sp,#0x18]	; 02303C4C
	b loc_02303CE8	; 02303C4E
loc_02303C50:
	bl P4_AcquireCommandSlot	; 02303C50
	add r2,r0,#0x0	; 02303C54
	mov r0,#0x81	; 02303C56
	strh r0,[r2,#0x0]	; 02303C58
	ldrh r1,[r4,#0x4]	; 02303C5A
	add r3,r1,#0x0	; 02303C5C
	ldr r0,[sp,#0x24]	; 02303C5E
	and r3,r0	; 02303C60
	cmp r3,#0x0	; 02303C62
	bne loc_02303C6E	; 02303C64
	ldr r0,[sp,#0x2c]	; 02303C66
	strh r0,[r2,#0x2]	; 02303C68
	strh r0,[r4,#0x4]	; 02303C6A
	b loc_02303C94	; 02303C6C
loc_02303C6E:
	ldr r0,[sp,#0x0]	; 02303C6E
	cmp r0,#0x0	; 02303C70
	bne loc_02303C7C	; 02303C72
	ldr r0,[sp,#0x4]	; 02303C74
	and r0,r1	; 02303C76
	cmp r0,#0x0	; 02303C78
	beq loc_02303C90	; 02303C7A
loc_02303C7C:
	ldr r0,[sp,#0x0]	; 02303C7C
	cmp r0,#0x0	; 02303C7E
	bne loc_02303C8A	; 02303C80
	ldrh r1,[r4,#0x4]	; 02303C82
	ldr r0,[sp,#0x28]	; 02303C84
	and r1,r0	; 02303C86
	strh r1,[r4,#0x4]	; 02303C88
loc_02303C8A:
	mov r0,#0xf	; 02303C8A
	strh r0,[r2,#0x2]	; 02303C8C
	b loc_02303C94	; 02303C8E
loc_02303C90:
	ldr r0,[sp,#0x30]	; 02303C90
	strh r0,[r2,#0x2]	; 02303C92
loc_02303C94:
	mov r0,#0x14	; 02303C94
	strh r0,[r2,#0x8]	; 02303C96
	ldrh r0,[r4,#0x2]	; 02303C98
	strh r0,[r2,#0xa]	; 02303C9A
	ldrh r0,[r4,#0x4]	; 02303C9C
	strh r0,[r2,#0xc]	; 02303C9E
	ldrh r0,[r4,#0x6]	; 02303CA0
	strh r0,[r2,#0xe]	; 02303CA2
	ldr r0,[r4,#0xc]	; 02303CA4
	str r0,[r2,#0x10]	; 02303CA6
	ldr r0,[r4,#0x10]	; 02303CA8
	str r0,[r2,#0x14]	; 02303CAA
	ldr r0,[r4,#0x14]	; 02303CAC
	str r0,[r2,#0x18]	; 02303CAE
	ldrh r0,[r4,#0x8]	; 02303CB0
	strh r0,[r2,#0x1c]	; 02303CB2
	add r0,r2,#0x0	; 02303CB4
	bl P4_SubmitCommandSlot	; 02303CB6
	ldrh r0,[r4,#0x0]	; 02303CBA
	cmp r0,r7	; 02303CBC
	bne loc_02303CC2	; 02303CBE
	strh r7,[r6,#0x2]	; 02303CC0
loc_02303CC2:
	ldrh r0,[r4,#0x0]	; 02303CC2
	strh r0,[r6,#0x0]	; 02303CC4
	strh r7,[r4,#0x0]	; 02303CC6
	ldr r1,[sp,#0x8]	; 02303CC8
	ldr r0,[pool_02303D64]	; 02303CCA
	ldrh r1,[r1,r0]	; 02303CCC
	cmp r1,r7	; 02303CCE
	bne loc_02303CDA	; 02303CD0
	ldr r1,[sp,#0x8]	; 02303CD2
	ldr r0,[pool_02303D68]	; 02303CD4
	strh r5,[r1,r0]	; 02303CD6
	b loc_02303CE2	; 02303CD8
loc_02303CDA:
	mov r0,#0x18	; 02303CDA
	mul r1,r0	; 02303CDC
	ldr r0,[sp,#0xc]	; 02303CDE
	strh r5,[r0,r1]	; 02303CE0
loc_02303CE2:
	ldr r1,[sp,#0x8]	; 02303CE2
	ldr r0,[pool_02303D64]	; 02303CE4
	strh r5,[r1,r0]	; 02303CE6
loc_02303CE8:
	ldrh r5,[r6,#0x0]	; 02303CE8
	cmp r5,r7	; 02303CEA
	beq loc_02303CF0	; 02303CEC
	b loc_02303BD8	; 02303CEE
loc_02303CF0:
	ldr r0,[sp,#0x18]	; 02303CF0
	cmp r0,r7	; 02303CF2
	beq loc_02303D1E	; 02303CF4
	ldr r1,[sp,#0x20]	; 02303CF6
	ldr r0,[pool_02303D6C]	; 02303CF8
	ldrh r2,[r1,r0]	; 02303CFA
	ldr r1,[sp,#0x18]	; 02303CFC
	mov r0,#0x18	; 02303CFE
	mul r1,r0	; 02303D00
	ldr r0,[sp,#0xc]	; 02303D02
	strh r2,[r0,r1]	; 02303D04
	ldr r1,[sp,#0x20]	; 02303D06
	ldr r0,[pool_02303D70]	; 02303D08
	ldrh r0,[r1,r0]	; 02303D0A
	cmp r0,r7	; 02303D0C
	bne loc_02303D16	; 02303D0E
	ldr r2,[sp,#0x18]	; 02303D10
	ldr r0,[pool_02303D70]	; 02303D12
	strh r2,[r1,r0]	; 02303D14
loc_02303D16:
	ldr r2,[sp,#0x1c]	; 02303D16
	ldr r1,[sp,#0x20]	; 02303D18
	ldr r0,[pool_02303D6C]	; 02303D1A
	strh r2,[r1,r0]	; 02303D1C
loc_02303D1E:
	add r6,r6,#0x4	; 02303D1E
	ldr r0,[sp,#0x20]	; 02303D20
	add r0,r0,#0x4	; 02303D22
	str r0,[sp,#0x20]	; 02303D24
	ldr r0,[sp,#0x10]	; 02303D26
	add r0,r0,#0x1	; 02303D28
	str r0,[sp,#0x10]	; 02303D2A
	cmp r0,#0x4	; 02303D2C
	bge loc_02303D32	; 02303D2E
	b loc_02303BCC	; 02303D30
loc_02303D32:
	mov r2,#0x0	; 02303D32
	ldr r1,[pool_02303D58]	; 02303D34
	ldr r0,[sp,#0x8]	; 02303D36
	str r2,[r0,r1]	; 02303D38
	ldr r1,[pool_02303D54]	; 02303D3A
	add r0,r0,r1	; 02303D3C
	bl loc_02303D84	; 02303D3E
	ldr r0,[sp,#0x14]	; 02303D42
	add sp,#0x34	; 02303D44
	pop {r4,r5,r6,r7}	; 02303D46
	pop {r3}	; 02303D48
	bx r3	; 02303D4A
pool_02303D4C:
loc_02303D4C:
	.word 0x00001518	; 02303D4C
pool_02303D50:
loc_02303D50:
	.word 0x000002F8	; 02303D50
pool_02303D54:
loc_02303D54:
	.word 0x0000091C	; 02303D54
pool_02303D58:
loc_02303D58:
	.word 0x00000930	; 02303D58
pool_02303D5C:
loc_02303D5C:
	.word 0x000008FC	; 02303D5C
pool_02303D60:
loc_02303D60:
	.word 0x0000FFFF	; 02303D60
pool_02303D64:
loc_02303D64:
	.word 0x000008FA	; 02303D64
pool_02303D68:
loc_02303D68:
	.word 0x000008F8	; 02303D68
pool_02303D6C:
loc_02303D6C:
	.word 0x0000090C	; 02303D6C
pool_02303D70:
loc_02303D70:
	.word 0x0000090E	; 02303D70

; ===== function loc_02303D74 =====
loc_02303D74:
	bx pc	; 02303D74
	.byte 0xC0, 0x46	; 02303D78
.arm

; ===== function loc_02303D78 =====
loc_02303D78:
	ldr r12,[pool_02303D80]	; 02303D78
	bx r12	; 02303D7C
pool_02303D80:
loc_02303D80:
	.word P2_Entry_037FE424 + 1	; 02303D80
.thumb

; ===== function loc_02303D84 =====
loc_02303D84:
	bx pc	; 02303D84
	.byte 0xC0, 0x46	; 02303D88
.arm

; ===== function loc_02303D88 =====
loc_02303D88:
	ldr r12,[pool_02303D90]	; 02303D88
	bx r12	; 02303D8C
pool_02303D90:
loc_02303D90:
	.word P2_Entry_037FE3E0 + 1	; 02303D90
.thumb

; ===== function loc_02303D94 =====
loc_02303D94:
	push {r4,r5,r6,r7,lr}	; 02303D94
	sub sp,#0xc	; 02303D96
	add r4,r0,#0x0	; 02303D98
	add r7,r1,#0x0	; 02303D9A
	str r2,[sp,#0x0]	; 02303D9C
	str r3,[sp,#0x4]	; 02303D9E
	bl P4_GetRuntimeState	; 02303DA0
	ldr r1,[pool_02303E7C]	; 02303DA4
	ldr r0,[r0,r1]	; 02303DA6
	ldr r5,[r0,#0x0]	; 02303DA8
	ldr r0,[pool_02303E80]	; 02303DAA
	add r6,r5,r0	; 02303DAC
	ldr r0,[pool_02303E84]	; 02303DAE
	add r1,r5,r0	; 02303DB0
	lsl r0,r4,#0x2	; 02303DB2
	add r4,r1,r0	; 02303DB4
	add r0,sp,#0x10	; 02303DB6
	ldrh r0,[r0,#0x10]	; 02303DB8
	cmp r0,#0x0	; 02303DBA
	bne loc_02303DC8	; 02303DBC
	mov r0,#0x6	; 02303DBE
	add sp,#0xc	; 02303DC0
	pop {r4,r5,r6,r7}	; 02303DC2
	pop {r3}	; 02303DC4
	bx r3	; 02303DC6
loc_02303DC8:
	mov r0,#0x8	; 02303DC8
	add r1,r7,#0x0	; 02303DCA
	and r1,r0	; 02303DCC
	cmp r1,#0x0	; 02303DCE
	beq loc_02303DD6	; 02303DD0
	mov r1,#0x2	; 02303DD2
	b loc_02303DD8	; 02303DD4
loc_02303DD6:
	mov r1,#0x0	; 02303DD6
loc_02303DD8:
	add r0,sp,#0x10	; 02303DD8
	ldrh r0,[r0,#0x10]	; 02303DDA
	add r1,r0,r1	; 02303DDC
	ldr r0,[pool_02303E88]	; 02303DDE
	ldrh r0,[r5,r0]	; 02303DE0
	cmp r1,r0	; 02303DE2
	ble loc_02303DF0	; 02303DE4
	mov r0,#0x6	; 02303DE6
	add sp,#0xc	; 02303DE8
	pop {r4,r5,r6,r7}	; 02303DEA
	pop {r3}	; 02303DEC
	bx r3	; 02303DEE
loc_02303DF0:
	ldr r0,[pool_02303E8C]	; 02303DF0
	add r0,r5,r0	; 02303DF2
	bl loc_02303D74	; 02303DF4
	ldr r0,[pool_02303E90]	; 02303DF8
	add r2,r5,r0	; 02303DFA
	ldrh r0,[r2,#0x0]	; 02303DFC
	ldr r1,[pool_02303E94]	; 02303DFE
	cmp r0,r1	; 02303E00
	bne loc_02303E16	; 02303E02
	ldr r0,[pool_02303E8C]	; 02303E04
	add r0,r5,r0	; 02303E06
	bl loc_02303D84	; 02303E08
	mov r0,#0xa	; 02303E0C
	add sp,#0xc	; 02303E0E
	pop {r4,r5,r6,r7}	; 02303E10
	pop {r3}	; 02303E12
	bx r3	; 02303E14
loc_02303E16:
	mov r1,#0x18	; 02303E16
	add r3,r0,#0x0	; 02303E18
	mul r3,r1	; 02303E1A
	add r1,r6,r3	; 02303E1C
	ldrh r3,[r6,r3]	; 02303E1E
	strh r3,[r2,#0x0]	; 02303E20
	ldr r2,[pool_02303E98]	; 02303E22
	add r3,r5,r2	; 02303E24
	ldrh r2,[r3,#0x0]	; 02303E26
	cmp r2,r0	; 02303E28
	bne loc_02303E30	; 02303E2A
	ldr r2,[pool_02303E94]	; 02303E2C
	strh r2,[r3,#0x0]	; 02303E2E
loc_02303E30:
	strh r7,[r1,#0x2]	; 02303E30
	ldr r2,[sp,#0x0]	; 02303E32
	strh r2,[r1,#0x4]	; 02303E34
	ldr r2,[sp,#0x4]	; 02303E36
	str r2,[r1,#0xc]	; 02303E38
	add r2,sp,#0x10	; 02303E3A
	ldrh r2,[r2,#0x10]	; 02303E3C
	strh r2,[r1,#0x6]	; 02303E3E
	ldr r2,[sp,#0x24]	; 02303E40
	str r2,[r1,#0x10]	; 02303E42
	ldr r2,[sp,#0x28]	; 02303E44
	str r2,[r1,#0x14]	; 02303E46
	ldr r2,[pool_02303E94]	; 02303E48
	strh r2,[r1,#0x0]	; 02303E4A
	strh r2,[r1,#0x8]	; 02303E4C
	add r3,r5,#0x0	; 02303E4E
	add r3,#0x9c	; 02303E50
	ldrh r3,[r3,#0x0]	; 02303E52
	strh r3,[r1,#0xa]	; 02303E54
	ldrh r3,[r4,#0x2]	; 02303E56
	cmp r3,r2	; 02303E58
	bne loc_02303E60	; 02303E5A
	strh r0,[r4,#0x0]	; 02303E5C
	b loc_02303E66	; 02303E5E
loc_02303E60:
	mov r1,#0x18	; 02303E60
	mul r3,r1	; 02303E62
	strh r0,[r6,r3]	; 02303E64
loc_02303E66:
	strh r0,[r4,#0x2]	; 02303E66
	ldr r0,[pool_02303E8C]	; 02303E68
	add r0,r5,r0	; 02303E6A
	bl loc_02303D84	; 02303E6C
	mov r0,#0x2	; 02303E70
	add sp,#0xc	; 02303E72
	pop {r4,r5,r6,r7}	; 02303E74
	pop {r3}	; 02303E76
	bx r3	; 02303E78
	.byte 0xC0, 0x46	; 02303E7C
pool_02303E7C:
loc_02303E7C:
	.word 0x00001518	; 02303E7C
pool_02303E80:
loc_02303E80:
	.word 0x000002F8	; 02303E80
pool_02303E84:
loc_02303E84:
	.word 0x0000090C	; 02303E84
pool_02303E88:
loc_02303E88:
	.word 0x00000192	; 02303E88
pool_02303E8C:
loc_02303E8C:
	.word 0x0000091C	; 02303E8C
pool_02303E90:
loc_02303E90:
	.word 0x000008F8	; 02303E90
pool_02303E94:
loc_02303E94:
	.word 0x0000FFFF	; 02303E94
pool_02303E98:
loc_02303E98:
	.word 0x000008FA	; 02303E98

; ===== function loc_02303E9C =====
loc_02303E9C:
	push {r4,r5,r6,r7,lr}	; 02303E9C
	sub sp,#0x6c	; 02303E9E
	add r4,r0,#0x0	; 02303EA0
	add r7,r1,#0x0	; 02303EA2
	str r2,[sp,#0x0]	; 02303EA4
	add r6,r3,#0x0	; 02303EA6
	ldr r0,[sp,#0x80]	; 02303EA8
	str r0,[sp,#0x80]	; 02303EAA
	ldr r0,[sp,#0x84]	; 02303EAC
	str r0,[sp,#0x84]	; 02303EAE
	bl P4_GetRuntimeState	; 02303EB0
	str r0,[sp,#0xc]	; 02303EB4
	ldr r1,[pool_023041F8]	; 02303EB6
	ldr r0,[r0,r1]	; 02303EB8
	ldr r0,[r0,#0x0]	; 02303EBA
	str r0,[sp,#0x10]	; 02303EBC
	ldrh r0,[r0,#0x0]	; 02303EBE
	cmp r0,#0x9	; 02303EC0
	bne loc_02303ECA	; 02303EC2
	mov r0,#0x1	; 02303EC4
	str r0,[sp,#0x20]	; 02303EC6
	b loc_02303EDE	; 02303EC8
loc_02303ECA:
	cmp r0,#0xa	; 02303ECA
	bne loc_02303ED4	; 02303ECC
	mov r0,#0x0	; 02303ECE
	str r0,[sp,#0x20]	; 02303ED0
	b loc_02303EDE	; 02303ED2
loc_02303ED4:
	mov r0,#0x1	; 02303ED4
	add sp,#0x6c	; 02303ED6
	pop {r4,r5,r6,r7}	; 02303ED8
	pop {r3}	; 02303EDA
	bx r3	; 02303EDC
loc_02303EDE:
	mov r1,#0x0	; 02303EDE
	str r1,[sp,#0x24]	; 02303EE0
	ldr r0,[sp,#0x0]	; 02303EE2
	strh r1,[r0,#0x0]	; 02303EE4
	ldr r0,[sp,#0x80]	; 02303EE6
	strh r1,[r0,#0x0]	; 02303EE8
	ldr r0,[sp,#0x84]	; 02303EEA
	strh r1,[r0,#0x0]	; 02303EEC
	lsl r0,r1,#0	; 02303EEE
	str r0,[sp,#0x28]	; 02303EF0
	ldr r0,[sp,#0x20]	; 02303EF2
	cmp r0,#0x1	; 02303EF4
	bne loc_02303F00	; 02303EF6
	ldr r0,[sp,#0x10]	; 02303EF8
	add r0,#0x8a	; 02303EFA
	ldrh r0,[r0,#0x0]	; 02303EFC
	b loc_02303F02	; 02303EFE
loc_02303F00:
	mov r0,#0x1	; 02303F00
loc_02303F02:
	lsl r0,r0,#0x10	; 02303F02
	lsr r0,r0,#0x10	; 02303F04
	str r0,[sp,#0x18]	; 02303F06
	cmp r7,#0x0	; 02303F08
	bge loc_02303F16	; 02303F0A
	mov r0,#0x1	; 02303F0C
	add sp,#0x6c	; 02303F0E
	pop {r4,r5,r6,r7}	; 02303F10
	pop {r3}	; 02303F12
	bx r3	; 02303F14
loc_02303F16:
	mov r0,#0x0	; 02303F16
	str r0,[sp,#0x14]	; 02303F18
	mov r0,#0x1	; 02303F1A
	str r0,[sp,#0x1c]	; 02303F1C
	ldr r1,[pool_023041FC]	; 02303F1E
	ldr r0,[sp,#0x10]	; 02303F20
	add r0,r0,r1	; 02303F22
	bl loc_02303D74	; 02303F24
	ldr r1,[pool_02304200]	; 02303F28
	ldr r0,[sp,#0x10]	; 02303F2A
	add r1,r0,r1	; 02303F2C
	ldr r0,[r1,#0x0]	; 02303F2E
	cmp r0,#0x1	; 02303F30
	bne loc_02303F48	; 02303F32
	ldr r1,[pool_023041FC]	; 02303F34
	ldr r0,[sp,#0x10]	; 02303F36
	add r0,r0,r1	; 02303F38
	bl loc_02303D84	; 02303F3A
	mov r0,#0x1	; 02303F3E
	add sp,#0x6c	; 02303F40
	pop {r4,r5,r6,r7}	; 02303F42
	pop {r3}	; 02303F44
	bx r3	; 02303F46
loc_02303F48:
	mov r0,#0x1	; 02303F48
	str r0,[r1,#0x0]	; 02303F4A
	ldr r1,[pool_02304204]	; 02303F4C
	ldr r0,[sp,#0x10]	; 02303F4E
	add r0,r0,r1	; 02303F50
	str r0,[sp,#0x2c]	; 02303F52
	mov r0,#0x0	; 02303F54
	str r0,[sp,#0x30]	; 02303F56
	ldr r0,[sp,#0x18]	; 02303F58
	and r0,r4	; 02303F5A
	mvn r0,r0	; 02303F5C
	str r0,[sp,#0x48]	; 02303F5E
	ldr r0,[sp,#0x30]	; 02303F60
	str r0,[sp,#0x50]	; 02303F62
	str r0,[sp,#0x54]	; 02303F64
	str r0,[sp,#0x58]	; 02303F66
	str r0,[sp,#0x5c]	; 02303F68
	str r0,[sp,#0x60]	; 02303F6A
	str r0,[sp,#0x64]	; 02303F6C
	str r0,[sp,#0x68]	; 02303F6E
	b loc_023041CC	; 02303F70
loc_02303F72:
	ldr r0,[sp,#0x30]	; 02303F72
	lsl r1,r0,#0x2	; 02303F74
	ldr r2,[sp,#0x10]	; 02303F76
	ldr r0,[pool_02304208]	; 02303F78
	add r0,r2,r0	; 02303F7A
	add r2,r0,r1	; 02303F7C
	str r2,[sp,#0x34]	; 02303F7E
	ldr r3,[sp,#0x10]	; 02303F80
	ldr r2,[pool_0230420C]	; 02303F82
	add r2,r3,r2	; 02303F84
	add r2,r2,r1	; 02303F86
	str r2,[sp,#0x38]	; 02303F88
	ldr r2,[sp,#0x34]	; 02303F8A
	str r2,[sp,#0x3c]	; 02303F8C
	ldr r2,[pool_02304210]	; 02303F8E
	str r2,[sp,#0x40]	; 02303F90
	ldrh r5,[r0,r1]	; 02303F92
	b loc_023041B6	; 02303F94
loc_02303F96:
	add r1,r5,#0x0	; 02303F96
	mov r0,#0x18	; 02303F98
	mul r1,r0	; 02303F9A
	ldr r0,[sp,#0x2c]	; 02303F9C
	add r4,r0,r1	; 02303F9E
	ldrh r1,[r4,#0x2]	; 02303FA0
	mov r0,#0x1	; 02303FA2
	lsl r0,r1	; 02303FA4
	lsl r0,r0,#0x10	; 02303FA6
	lsr r0,r0,#0x10	; 02303FA8
	str r0,[sp,#0x4c]	; 02303FAA
	ldr r2,[sp,#0x14]	; 02303FAC
	and r2,r0	; 02303FAE
	lsl r0,r2,#0x10	; 02303FB0
	lsr r0,r0,#0x10	; 02303FB2
	cmp r0,#0x0	; 02303FB4
	beq loc_02303FBA	; 02303FB6
	b loc_02304188	; 02303FB8
loc_02303FBA:
	ldr r2,[sp,#0x14]	; 02303FBA
	ldr r0,[sp,#0x4c]	; 02303FBC
	orr r2,r0	; 02303FBE
	str r2,[sp,#0x14]	; 02303FC0
	ldrh r0,[r4,#0x4]	; 02303FC2
	add r3,r0,#0x0	; 02303FC4
	ldr r2,[sp,#0x18]	; 02303FC6
	and r3,r2	; 02303FC8
	lsl r2,r3,#0x10	; 02303FCA
	lsr r2,r2,#0x10	; 02303FCC
	str r2,[sp,#0x44]	; 02303FCE
	ldr r2,[sp,#0x20]	; 02303FD0
	cmp r2,#0x0	; 02303FD2
	beq loc_02303FE6	; 02303FD4
	ldr r3,[sp,#0x44]	; 02303FD6
	ldr r2,[sp,#0x48]	; 02303FD8
	and r3,r2	; 02303FDA
	mov r2,#0x1	; 02303FDC
	bic r3,r2	; 02303FDE
	cmp r3,#0x0	; 02303FE0
	beq loc_02303FE6	; 02303FE2
	b loc_02304188	; 02303FE4
loc_02303FE6:
	mov r2,#0x8	; 02303FE6
	and r1,r2	; 02303FE8
	cmp r1,#0x0	; 02303FEA
	beq loc_02303FF4	; 02303FEC
	mov r1,#0x1	; 02303FEE
	str r1,[sp,#0x8]	; 02303FF0
	b loc_02303FF8	; 02303FF2
loc_02303FF4:
	ldr r1,[sp,#0x50]	; 02303FF4
	str r1,[sp,#0x8]	; 02303FF6
loc_02303FF8:
	ldr r1,[sp,#0x20]	; 02303FF8
	cmp r1,#0x0	; 02303FFA
	beq loc_0230400E	; 02303FFC
	mov r1,#0x1	; 02303FFE
	orr r0,r1	; 02304000
	ldr r1,[pool_02304210]	; 02304002
	cmp r0,r1	; 02304004
	beq loc_0230400E	; 02304006
	mov r0,#0x1	; 02304008
	str r0,[sp,#0x4]	; 0230400A
	b loc_02304012	; 0230400C
loc_0230400E:
	ldr r0,[sp,#0x54]	; 0230400E
	str r0,[sp,#0x4]	; 02304010
loc_02304012:
	ldrh r1,[r4,#0x6]	; 02304012
	add r2,r1,#0x0	; 02304014
	mov r0,#0x1	; 02304016
	and r2,r0	; 02304018
	cmp r2,#0x1	; 0230401A
	bne loc_02304022	; 0230401C
	add r0,r1,#0x1	; 0230401E
	strh r0,[r4,#0x6]	; 02304020
loc_02304022:
	ldr r0,[sp,#0x8]	; 02304022
	cmp r0,#0x0	; 02304024
	beq loc_0230402C	; 02304026
	mov r3,#0x2	; 02304028
	b loc_0230402E	; 0230402A
loc_0230402C:
	ldr r3,[sp,#0x58]	; 0230402C
loc_0230402E:
	ldr r0,[sp,#0x1c]	; 0230402E
	cmp r0,#0x0	; 02304030
	beq loc_02304038	; 02304032
	ldr r1,[sp,#0x5c]	; 02304034
	b loc_0230403A	; 02304036
loc_02304038:
	mov r1,#0x2	; 02304038
loc_0230403A:
	ldr r0,[sp,#0x4]	; 0230403A
	cmp r0,#0x0	; 0230403C
	beq loc_02304044	; 0230403E
	mov r2,#0x2	; 02304040
	b loc_02304046	; 02304042
loc_02304044:
	ldr r2,[sp,#0x60]	; 02304044
loc_02304046:
	ldrh r0,[r4,#0x6]	; 02304046
	add r0,r0,r1	; 02304048
	add r0,r0,r3	; 0230404A
	add r0,r2,r0	; 0230404C
	cmp r0,r7	; 0230404E
	ble loc_02304054	; 02304050
	b loc_02304188	; 02304052
loc_02304054:
	ldr r0,[sp,#0x1c]	; 02304054
	cmp r0,#0x0	; 02304056
	bne loc_0230406E	; 02304058
	str r6,[sp,#0x0]	; 0230405A
	ldr r0,[sp,#0x64]	; 0230405C
	strh r0,[r6,#0x0]	; 0230405E
	add r6,r6,#0x2	; 02304060
	ldr r0,[sp,#0x28]	; 02304062
	add r0,r0,#0x2	; 02304064
	lsl r0,r0,#0x10	; 02304066
	lsr r0,r0,#0x10	; 02304068
	str r0,[sp,#0x28]	; 0230406A
	sub r7,r7,#0x2	; 0230406C
loc_0230406E:
	ldr r0,[sp,#0x0]	; 0230406E
	ldrh r2,[r0,#0x0]	; 02304070
	ldrh r0,[r4,#0x2]	; 02304072
	lsl r1,r0,#0x8	; 02304074
	ldr r0,[pool_02304214]	; 02304076
	and r1,r0	; 02304078
	ldrh r0,[r4,#0x6]	; 0230407A
	lsr r3,r0,#0x1	; 0230407C
	mov r0,#0xff	; 0230407E
	and r3,r0	; 02304080
	orr r1,r3	; 02304082
	orr r2,r1	; 02304084
	ldr r0,[sp,#0x0]	; 02304086
	strh r2,[r0,#0x0]	; 02304088
	ldr r1,[sp,#0xc]	; 0230408A
	ldr r0,[pool_02304218]	; 0230408C
	ldr r0,[r1,r0]	; 0230408E
	ldr r1,[r4,#0xc]	; 02304090
	add r2,r6,#0x0	; 02304092
	ldrh r3,[r4,#0x6]	; 02304094
	bl loc_023006F8	; 02304096
	ldrh r0,[r4,#0x6]	; 0230409A
	add r2,r0,#0x0	; 0230409C
	mov r1,#0x1	; 0230409E
	bic r2,r1	; 023040A0
	add r6,r6,r2	; 023040A2
	ldr r1,[sp,#0x28]	; 023040A4
	add r1,r1,r0	; 023040A6
	lsl r1,r1,#0x10	; 023040A8
	lsr r1,r1,#0x10	; 023040AA
	str r1,[sp,#0x28]	; 023040AC
	sub r7,r7,r0	; 023040AE
	ldr r0,[sp,#0x8]	; 023040B0
	cmp r0,#0x1	; 023040B2
	bne loc_02304104	; 023040B4
	ldrh r2,[r4,#0x8]	; 023040B6
	add r1,r2,#0x0	; 023040B8
	mov r0,#0x1	; 023040BA
	and r1,r0	; 023040BC
	cmp r1,#0x0	; 023040BE
	beq loc_023040EA	; 023040C0
	ldr r1,[sp,#0x10]	; 023040C2
	ldr r0,[pool_0230421C]	; 023040C4
	ldrh r0,[r1,r0]	; 023040C6
	lsl r1,r0,#0x4	; 023040C8
	ldr r0,[sp,#0x10]	; 023040CA
	add r0,r0,r1	; 023040CC
	ldrh r2,[r4,#0x2]	; 023040CE
	mov r1,#0x7	; 023040D0
	and r2,r1	; 023040D2
	lsl r1,r2,#0x1	; 023040D4
	add r3,r0,r1	; 023040D6
	ldr r0,[pool_02304220]	; 023040D8
	ldrh r2,[r3,r0]	; 023040DA
	lsl r0,r2,#0	; 023040DC
	add r1,r0,#0x1	; 023040DE
	ldr r0,[pool_02304220]	; 023040E0
	strh r1,[r3,r0]	; 023040E2
	lsl r0,r2,#0x1	; 023040E4
	strh r0,[r4,#0x8]	; 023040E6
	b loc_023040F4	; 023040E8
loc_023040EA:
	asr r1,r2,#0x1	; 023040EA
	ldr r0,[pool_02304224]	; 023040EC
	and r1,r0	; 023040EE
	lsl r0,r1,#0x10	; 023040F0
	lsr r2,r0,#0x10	; 023040F2
loc_023040F4:
	strh r2,[r6,#0x0]	; 023040F4
	add r6,r6,#0x2	; 023040F6
	ldr r0,[sp,#0x28]	; 023040F8
	add r0,r0,#0x2	; 023040FA
	lsl r0,r0,#0x10	; 023040FC
	lsr r0,r0,#0x10	; 023040FE
	str r0,[sp,#0x28]	; 02304100
	sub r7,r7,#0x2	; 02304102
loc_02304104:
	ldr r0,[sp,#0x4]	; 02304104
	cmp r0,#0x1	; 02304106
	bne loc_02304128	; 02304108
	ldr r0,[sp,#0x0]	; 0230410A
	ldrh r1,[r0,#0x0]	; 0230410C
	ldr r0,[pool_02304228]	; 0230410E
	orr r1,r0	; 02304110
	ldr r0,[sp,#0x0]	; 02304112
	strh r1,[r0,#0x0]	; 02304114
	ldr r0,[sp,#0x44]	; 02304116
	strh r0,[r6,#0x0]	; 02304118
	add r6,r6,#0x2	; 0230411A
	ldr r0,[sp,#0x28]	; 0230411C
	add r0,r0,#0x2	; 0230411E
	lsl r0,r0,#0x10	; 02304120
	lsr r0,r0,#0x10	; 02304122
	str r0,[sp,#0x28]	; 02304124
	sub r7,r7,#0x2	; 02304126
loc_02304128:
	ldr r0,[sp,#0x1c]	; 02304128
	cmp r0,#0x1	; 0230412A
	bne loc_02304132	; 0230412C
	ldr r0,[sp,#0x68]	; 0230412E
	str r0,[sp,#0x1c]	; 02304130
loc_02304132:
	ldr r0,[sp,#0x34]	; 02304132
	ldrh r0,[r0,#0x2]	; 02304134
	cmp r0,r5	; 02304136
	bne loc_02304140	; 02304138
	ldr r1,[sp,#0x40]	; 0230413A
	ldr r0,[sp,#0x34]	; 0230413C
	strh r1,[r0,#0x2]	; 0230413E
loc_02304140:
	ldrh r1,[r4,#0x0]	; 02304140
	ldr r0,[sp,#0x3c]	; 02304142
	strh r1,[r0,#0x0]	; 02304144
	ldr r0,[pool_02304210]	; 02304146
	strh r0,[r4,#0x0]	; 02304148
	ldr r0,[sp,#0x38]	; 0230414A
	ldrh r0,[r0,#0x2]	; 0230414C
	ldr r1,[pool_02304210]	; 0230414E
	cmp r0,r1	; 02304150
	bne loc_0230415A	; 02304152
	ldr r0,[sp,#0x38]	; 02304154
	strh r5,[r0,#0x0]	; 02304156
	b loc_02304162	; 02304158
loc_0230415A:
	mov r1,#0x18	; 0230415A
	mul r0,r1	; 0230415C
	ldr r1,[sp,#0x2c]	; 0230415E
	strh r5,[r1,r0]	; 02304160
loc_02304162:
	ldr r0,[sp,#0x38]	; 02304162
	strh r5,[r0,#0x2]	; 02304164
	ldr r1,[sp,#0x14]	; 02304166
	ldr r0,[sp,#0x4c]	; 02304168
	bic r1,r0	; 0230416A
	str r1,[sp,#0x14]	; 0230416C
	lsl r0,r1,#0x10	; 0230416E
	lsr r0,r0,#0x10	; 02304170
	str r0,[sp,#0x14]	; 02304172
	ldrh r1,[r4,#0x4]	; 02304174
	ldr r0,[sp,#0x24]	; 02304176
	orr r0,r1	; 02304178
	str r0,[sp,#0x24]	; 0230417A
	ldr r5,[sp,#0x40]	; 0230417C
	ldr r0,[sp,#0x10]	; 0230417E
	add r0,#0x98	; 02304180
	ldrh r0,[r0,#0x0]	; 02304182
	cmp r0,#0x1	; 02304184
	beq loc_023041D8	; 02304186
loc_02304188:
	ldr r0,[pool_02304210]	; 02304188
	cmp r5,r0	; 0230418A
	beq loc_0230419C	; 0230418C
	add r1,r5,#0x0	; 0230418E
	mov r0,#0x18	; 02304190
	mul r1,r0	; 02304192
	ldr r0,[sp,#0x2c]	; 02304194
	add r0,r0,r1	; 02304196
	str r0,[sp,#0x3c]	; 02304198
	b loc_023041A0	; 0230419A
loc_0230419C:
	ldr r0,[sp,#0x34]	; 0230419C
	str r0,[sp,#0x3c]	; 0230419E
loc_023041A0:
	str r5,[sp,#0x40]	; 023041A0
	ldr r0,[pool_02304210]	; 023041A2
	cmp r5,r0	; 023041A4
	beq loc_023041B2	; 023041A6
	mov r0,#0x18	; 023041A8
	mul r5,r0	; 023041AA
	ldr r0,[sp,#0x2c]	; 023041AC
	ldrh r5,[r0,r5]	; 023041AE
	b loc_023041B6	; 023041B0
loc_023041B2:
	ldr r0,[sp,#0x34]	; 023041B2
	ldrh r5,[r0,#0x0]	; 023041B4
loc_023041B6:
	ldr r0,[pool_02304210]	; 023041B6
	cmp r5,r0	; 023041B8
	beq loc_023041C2	; 023041BA
	cmp r7,#0x2	; 023041BC
	ble loc_023041C2	; 023041BE
	b loc_02303F96	; 023041C0
loc_023041C2:
	ldr r0,[sp,#0x30]	; 023041C2
	add r0,r0,#0x1	; 023041C4
	lsl r0,r0,#0x10	; 023041C6
	lsr r0,r0,#0x10	; 023041C8
	str r0,[sp,#0x30]	; 023041CA
loc_023041CC:
	ldr r0,[sp,#0x30]	; 023041CC
	cmp r0,#0x4	; 023041CE
	bcs loc_023041D8	; 023041D0
	cmp r7,#0x2	; 023041D2
	ble loc_023041D8	; 023041D4
	b loc_02303F72	; 023041D6
loc_023041D8:
	ldr r1,[sp,#0x24]	; 023041D8
	ldr r0,[sp,#0x80]	; 023041DA
	strh r1,[r0,#0x0]	; 023041DC
	ldr r1,[sp,#0x28]	; 023041DE
	ldr r0,[sp,#0x84]	; 023041E0
	strh r1,[r0,#0x0]	; 023041E2
	ldr r1,[pool_023041FC]	; 023041E4
	ldr r0,[sp,#0x10]	; 023041E6
	add r0,r0,r1	; 023041E8
	bl loc_02303D84	; 023041EA
	mov r0,#0x0	; 023041EE
	add sp,#0x6c	; 023041F0
	pop {r4,r5,r6,r7}	; 023041F2
	pop {r3}	; 023041F4
	bx r3	; 023041F6
pool_023041F8:
loc_023041F8:
	.word 0x00001518	; 023041F8
pool_023041FC:
loc_023041FC:
	.word 0x0000091C	; 023041FC
pool_02304200:
loc_02304200:
	.word 0x00000930	; 02304200
pool_02304204:
loc_02304204:
	.word 0x000002F8	; 02304204
pool_02304208:
loc_02304208:
	.word 0x0000090C	; 02304208
pool_0230420C:
loc_0230420C:
	.word 0x000008FC	; 0230420C
pool_02304210:
loc_02304210:
	.word 0x0000FFFF	; 02304210
pool_02304214:
loc_02304214:
	.word 0x00000F00	; 02304214
pool_02304218:
loc_02304218:
	.word 0x0000150C	; 02304218
pool_0230421C:
loc_0230421C:
	.word 0x00000188	; 0230421C
pool_02304220:
loc_02304220:
	.word 0x000001F8	; 02304220
pool_02304224:
loc_02304224:
	.word 0x00007FFF	; 02304224
pool_02304228:
loc_02304228:
	.word 0x00001000	; 02304228

; ===== function loc_0230422C =====
loc_0230422C:
	push {r4,lr}	; 0230422C
	sub sp,#0x1fc	; 0230422E
	sub sp,#0x1c	; 02304230
	add r4,r0,#0x0	; 02304232
	bl P4_GetRuntimeState	; 02304234
	str r4,[sp,#0x0]	; 02304238
	mov r2,#0x0	; 0230423A
	str r2,[sp,#0x4]	; 0230423C
	ldr r1,[pool_02304268]	; 0230423E
	ldrh r1,[r1,#0x0]	; 02304240
	str r1,[sp,#0x8]	; 02304242
	str r2,[sp,#0xc]	; 02304244
	ldr r1,[pool_0230426C]	; 02304246
	ldr r0,[r0,r1]	; 02304248
	ldr r0,[r0,#0x0]	; 0230424A
	add r0,#0x44	; 0230424C
	ldrh r0,[r0,#0x0]	; 0230424E
	str r0,[sp,#0x10]	; 02304250
	str r2,[sp,#0x14]	; 02304252
	add r0,sp,#0x18	; 02304254
	ldr r1,[pool_02304270]	; 02304256
	add r3,r2,#0x0	; 02304258
	bl loc_02301AE8	; 0230425A
	add sp,#0x1fc	; 0230425E
	add sp,#0x1c	; 02304260
	pop {r4}	; 02304262
	pop {r3}	; 02304264
	bx r3	; 02304266
pool_02304268:
loc_02304268:
	.word REG_WIFI_US_COUNT0	; 02304268
pool_0230426C:
loc_0230426C:
	.word 0x00001518	; 0230426C
pool_02304270:
loc_02304270:
	.word 0x00008004	; 02304270

; ===== function loc_02304274 =====
loc_02304274:
	push {r4,r5,r6,r7,lr}	; 02304274
	sub sp,#0x1fc	; 02304276
	sub sp,#0x30	; 02304278
	add r5,r0,#0x0	; 0230427A
	bl P4_GetRuntimeState	; 0230427C
	ldr r1,[pool_02304380]	; 02304280
	ldr r0,[r0,r1]	; 02304282
	ldr r4,[r0,#0x0]	; 02304284
	mov r6,#0x0	; 02304286
	ldr r7,[r4,#0x54]	; 02304288
	ldr r0,[pool_02304384]	; 0230428A
	ldrh r1,[r4,r0]	; 0230428C
	add r0,r4,#0x0	; 0230428E
	add r0,#0x8c	; 02304290
	ldrh r0,[r0,#0x0]	; 02304292
	cmp r0,#0x1	; 02304294
	bne loc_023042A0	; 02304296
	ldr r5,[pool_02304388]	; 02304298
	add r0,r4,#0x0	; 0230429A
	add r0,#0x8c	; 0230429C
	strh r6,[r0,#0x0]	; 0230429E
loc_023042A0:
	add r0,r4,#0x0	; 023042A0
	add r0,#0x9e	; 023042A2
	ldrh r0,[r0,#0x0]	; 023042A4
	cmp r0,#0x1	; 023042A6
	bne loc_023042B6	; 023042A8
	ldr r5,[pool_02304388]	; 023042AA
	mov r6,#0x1	; 023042AC
	mov r1,#0x0	; 023042AE
	add r0,r4,#0x0	; 023042B0
	add r0,#0x9e	; 023042B2
	strh r1,[r0,#0x0]	; 023042B4
loc_023042B6:
	add r0,sp,#0x24	; 023042B6
	str r0,[sp,#0x0]	; 023042B8
	add r0,sp,#0x24	; 023042BA
	add r0,#0x2	; 023042BC
	str r0,[sp,#0x4]	; 023042BE
	add r0,r5,#0x0	; 023042C0
	add r2,sp,#0x28	; 023042C2
	add r3,r7,#0x0	; 023042C4
	bl loc_02303E9C	; 023042C6
	cmp r0,#0x1	; 023042CA
	beq loc_02304376	; 023042CC
	ldr r0,[pool_0230438C]	; 023042CE
	ldrh r0,[r4,r0]	; 023042D0
	add r0,r0,#0x2	; 023042D2
	lsl r0,r0,#0x10	; 023042D4
	lsr r0,r0,#0x10	; 023042D6
	str r0,[sp,#0x1c]	; 023042D8
	ldr r0,[pool_02304390]	; 023042DA
	ldrh r0,[r0,#0x0]	; 023042DC
	str r0,[sp,#0x20]	; 023042DE
	ldrh r0,[r4,#0x3e]	; 023042E0
	cmp r0,#0x1	; 023042E2
	bne loc_02304302	; 023042E4
	mov r0,#0x0	; 023042E6
	str r0,[sp,#0x18]	; 023042E8
	add r0,sp,#0x24	; 023042EA
	ldrh r0,[r0,#0x2]	; 023042EC
	ldr r1,[sp,#0x1c]	; 023042EE
	add r2,r5,#0x0	; 023042F0
	bl loc_02303914	; 023042F2
	add r3,sp,#0x24	; 023042F6
	ldrh r2,[r3,#0x4]	; 023042F8
	ldr r1,[pool_02304394]	; 023042FA
	orr r2,r1	; 023042FC
	strh r2,[r3,#0x4]	; 023042FE
	b loc_02304306	; 02304300
loc_02304302:
	mov r0,#0x0	; 02304302
	str r0,[sp,#0x18]	; 02304304
loc_02304306:
	add r1,r4,#0x0	; 02304306
	add r1,#0x96	; 02304308
	ldrh r1,[r1,#0x0]	; 0230430A
	cmp r1,#0x1	; 0230430C
	bne loc_0230433E	; 0230430E
	cmp r6,#0x0	; 02304310
	bne loc_02304324	; 02304312
	add r1,sp,#0x24	; 02304314
	ldrh r2,[r1,#0x0]	; 02304316
	ldr r1,[pool_02304398]	; 02304318
	ldrh r1,[r4,r1]	; 0230431A
	and r2,r1	; 0230431C
	lsl r1,r2,#0x10	; 0230431E
	lsr r5,r1,#0x10	; 02304320
	b loc_02304348	; 02304322
loc_02304324:
	ldr r0,[pool_02304398]	; 02304324
	ldrh r5,[r4,r0]	; 02304326
	mov r0,#0x0	; 02304328
	str r0,[sp,#0x1c]	; 0230432A
	ldrh r1,[r4,#0x3e]	; 0230432C
	add r1,r1,#0x1	; 0230432E
	strh r1,[r4,#0x3e]	; 02304330
	add r2,sp,#0x24	; 02304332
	ldrh r3,[r2,#0x4]	; 02304334
	ldr r1,[pool_0230439C]	; 02304336
	and r3,r1	; 02304338
	strh r3,[r2,#0x4]	; 0230433A
	b loc_02304348	; 0230433C
loc_0230433E:
	ldr r1,[pool_02304398]	; 0230433E
	ldrh r1,[r4,r1]	; 02304340
	and r5,r1	; 02304342
	lsl r1,r5,#0x10	; 02304344
	lsr r5,r1,#0x10	; 02304346
loc_02304348:
	str r5,[sp,#0x0]	; 02304348
	str r0,[sp,#0x4]	; 0230434A
	ldr r0,[sp,#0x20]	; 0230434C
	str r0,[sp,#0x8]	; 0230434E
	add r0,sp,#0x24	; 02304350
	ldrh r1,[r0,#0x2]	; 02304352
	str r1,[sp,#0xc]	; 02304354
	ldrh r0,[r0,#0x4]	; 02304356
	str r0,[sp,#0x10]	; 02304358
	str r7,[sp,#0x14]	; 0230435A
	add r0,sp,#0x2c	; 0230435C
	mov r1,#0x0	; 0230435E
	ldr r2,[sp,#0x18]	; 02304360
	ldr r3,[sp,#0x1c]	; 02304362
	bl loc_02301AE8	; 02304364
	add r0,r4,#0x0	; 02304368
	add r0,#0x42	; 0230436A
	strh r5,[r0,#0x0]	; 0230436C
	add r0,sp,#0x24	; 0230436E
	ldrh r0,[r0,#0x4]	; 02304370
	add r4,#0x44	; 02304372
	strh r0,[r4,#0x0]	; 02304374
loc_02304376:
	add sp,#0x1fc	; 02304376
	add sp,#0x30	; 02304378
	pop {r4,r5,r6,r7}	; 0230437A
	pop {r3}	; 0230437C
	bx r3	; 0230437E
pool_02304380:
loc_02304380:
	.word 0x00001518	; 02304380
pool_02304384:
loc_02304384:
	.word 0x00000192	; 02304384
pool_02304388:
loc_02304388:
	.word 0x0000FFFF	; 02304388
pool_0230438C:
loc_0230438C:
	.word 0x00000194	; 0230438C
pool_02304390:
loc_02304390:
	.word REG_WIFI_US_COUNT0	; 02304390
pool_02304394:
loc_02304394:
	.word 0x00008000	; 02304394
pool_02304398:
loc_02304398:
	.word 0x00000182	; 02304398
pool_0230439C:
loc_0230439C:
	.word 0xFFFF7FFF	; 0230439C

; ===== function loc_023043A0 =====
loc_023043A0:
	push {r4,r5,lr}	; 023043A0
	sub sp,#0x1fc	; 023043A2
	sub sp,#0x18	; 023043A4
	bl P4_GetRuntimeState	; 023043A6
	ldr r1,[pool_02304404]	; 023043AA
	ldr r0,[r0,r1]	; 023043AC
	ldr r5,[r0,#0x0]	; 023043AE
	ldr r4,[r5,#0x54]	; 023043B0
	add r0,sp,#0x8	; 023043B2
	str r0,[sp,#0x0]	; 023043B4
	add r0,sp,#0x8	; 023043B6
	add r0,#0x2	; 023043B8
	str r0,[sp,#0x4]	; 023043BA
	mov r0,#0x1	; 023043BC
	ldr r1,[pool_02304408]	; 023043BE
	ldrh r1,[r5,r1]	; 023043C0
	add r2,sp,#0xc	; 023043C2
	add r3,r4,#0x0	; 023043C4
	bl loc_02303E9C	; 023043C6
	cmp r0,#0x0	; 023043CA
	bne loc_023043F8	; 023043CC
	ldr r0,[r5,#0x24]	; 023043CE
	cmp r0,#0x1	; 023043D0
	bne loc_023043DE	; 023043D2
	add r1,sp,#0x8	; 023043D4
	ldrh r2,[r1,#0x4]	; 023043D6
	ldr r0,[pool_0230440C]	; 023043D8
	orr r2,r0	; 023043DA
	strh r2,[r1,#0x4]	; 023043DC
loc_023043DE:
	add r0,sp,#0x10	; 023043DE
	add r2,sp,#0x8	; 023043E0
	ldrh r1,[r2,#0x2]	; 023043E2
	ldrh r2,[r2,#0x4]	; 023043E4
	add r3,r4,#0x0	; 023043E6
	bl loc_02301B48	; 023043E8
	ldrh r0,[r0,#0x4]	; 023043EC
	cmp r0,#0x0	; 023043EE
	bne loc_023043F8	; 023043F0
	mov r0,#0x1	; 023043F2
	add r5,#0x8e	; 023043F4
	strh r0,[r5,#0x0]	; 023043F6
loc_023043F8:
	add sp,#0x1fc	; 023043F8
	add sp,#0x18	; 023043FA
	pop {r4,r5}	; 023043FC
	pop {r3}	; 023043FE
	bx r3	; 02304400
	.byte 0xC0, 0x46	; 02304404
pool_02304404:
loc_02304404:
	.word 0x00001518	; 02304404
pool_02304408:
loc_02304408:
	.word 0x00000192	; 02304408
pool_0230440C:
loc_0230440C:
	.word 0x00008000	; 0230440C

; ===== function loc_02304410 =====
loc_02304410:
	push {r4,r5,r6,r7,lr}	; 02304410
	sub sp,#0x4	; 02304412
	bl P4_GetRuntimeState	; 02304414
	ldr r1,[pool_02304498]	; 02304418
	ldr r0,[r0,r1]	; 0230441A
	ldr r4,[r0,#0x0]	; 0230441C
	ldr r0,[pool_0230449C]	; 0230441E
	add r0,r4,r0	; 02304420
	bl loc_02303D74	; 02304422
	mov r1,#0x0	; 02304426
	add r0,sp,#0x0	; 02304428
	strh r1,[r0,#0x0]	; 0230442A
	ldrh r0,[r0,#0x0]	; 0230442C
	ldr r1,[pool_023044A0]	; 0230442E
	add r1,r4,r1	; 02304430
	ldr r2,[pool_023044A4]	; 02304432
	bl loc_023044C4	; 02304434
	mov r5,#0x0	; 02304438
	mov r1,#0x18	; 0230443A
	ldr r3,[pool_023044A0]	; 0230443C
loc_0230443E:
	add r0,r5,#0x1	; 0230443E
	lsl r0,r0,#0x10	; 02304440
	lsr r2,r0,#0x10	; 02304442
	mul r5,r1	; 02304444
	add r0,r4,r5	; 02304446
	strh r2,[r0,r3]	; 02304448
	add r5,r2,#0x0	; 0230444A
	cmp r2,#0x3f	; 0230444C
	bcc loc_0230443E	; 0230444E
	ldr r0,[pool_023044A8]	; 02304450
	mov r1,#0x18	; 02304452
	add r3,r2,#0x0	; 02304454
	mul r3,r1	; 02304456
	add r3,r4,r3	; 02304458
	ldr r1,[pool_023044A0]	; 0230445A
	strh r0,[r3,r1]	; 0230445C
	mov r1,#0x0	; 0230445E
	ldr r3,[pool_023044AC]	; 02304460
	strh r1,[r4,r3]	; 02304462
	ldr r3,[pool_023044B0]	; 02304464
	strh r2,[r4,r3]	; 02304466
	ldr r7,[pool_023044B4]	; 02304468
	ldr r2,[pool_023044B8]	; 0230446A
	ldr r3,[pool_023044BC]	; 0230446C
	ldr r5,[pool_023044C0]	; 0230446E
loc_02304470:
	lsl r6,r1,#0x2	; 02304470
	add r6,r4,r6	; 02304472
	strh r0,[r6,r7]	; 02304474
	strh r0,[r6,r2]	; 02304476
	strh r0,[r6,r3]	; 02304478
	strh r0,[r6,r5]	; 0230447A
	add r1,r1,#0x1	; 0230447C
	lsl r1,r1,#0x10	; 0230447E
	lsr r1,r1,#0x10	; 02304480
	cmp r1,#0x4	; 02304482
	bcc loc_02304470	; 02304484
	ldr r0,[pool_0230449C]	; 02304486
	add r0,r4,r0	; 02304488
	bl loc_02303D84	; 0230448A
	add sp,#0x4	; 0230448E
	pop {r4,r5,r6,r7}	; 02304490
	pop {r3}	; 02304492
	bx r3	; 02304494
	.byte 0xC0, 0x46	; 02304498
pool_02304498:
loc_02304498:
	.word 0x00001518	; 02304498
pool_0230449C:
loc_0230449C:
	.word 0x0000091C	; 0230449C
pool_023044A0:
loc_023044A0:
	.word 0x000002F8	; 023044A0
pool_023044A4:
loc_023044A4:
	.word 0x00000600	; 023044A4
pool_023044A8:
loc_023044A8:
	.word 0x0000FFFF	; 023044A8
pool_023044AC:
loc_023044AC:
	.word 0x000008F8	; 023044AC
pool_023044B0:
loc_023044B0:
	.word 0x000008FA	; 023044B0
pool_023044B4:
loc_023044B4:
	.word 0x0000090C	; 023044B4
pool_023044B8:
loc_023044B8:
	.word 0x0000090E	; 023044B8
pool_023044BC:
loc_023044BC:
	.word 0x000008FC	; 023044BC
pool_023044C0:
loc_023044C0:
	.word 0x000008FE	; 023044C0

; ===== function loc_023044C4 =====
loc_023044C4:
	bx pc	; 023044C4
	.byte 0xC0, 0x46	; 023044C8
.arm

; ===== function loc_023044C8 =====
loc_023044C8:
	ldr pc,[pool_023044CC]	; 023044C8
pool_023044CC:
loc_023044CC:
	.word loc_037FF31C	; 023044CC
.thumb

; ===== function loc_023044D0 =====
	push {r4,r5,lr}	; 023044D0
	sub sp,#0x1fc	; 023044D2
	sub sp,#0x88	; 023044D4
	add r5,r0,#0x0	; 023044D6
	bl P4_GetRuntimeState	; 023044D8
	ldr r1,[pool_02304538]	; 023044DC
	ldr r0,[r0,r1]	; 023044DE
	ldr r4,[r0,#0x0]	; 023044E0
	ldr r1,[r5,#0x4]	; 023044E2
	add r0,r4,#0x0	; 023044E4
	add r0,#0xf4	; 023044E6
	strh r1,[r0,#0x0]	; 023044E8
	add r0,sp,#0x200	; 023044EA
	add r1,r4,#0x0	; 023044EC
	add r1,#0xe8	; 023044EE
	bl loc_02300720	; 023044F0
	add r0,sp,#0x0	; 023044F4
	add r4,#0xec	; 023044F6
	ldrh r1,[r4,#0x0]	; 023044F8
	add r1,#0x10	; 023044FA
	lsl r1,r1,#0x10	; 023044FC
	lsr r1,r1,#0x10	; 023044FE
	add r2,sp,#0x200	; 02304500
	bl loc_02301980	; 02304502
	add r4,r0,#0x0	; 02304506
	bl P4_AcquireCommandSlot	; 02304508
	mov r1,#0x21	; 0230450C
	strh r1,[r0,#0x0]	; 0230450E
	ldrh r1,[r4,#0x4]	; 02304510
	cmp r1,#0x0	; 02304512
	bne loc_0230451C	; 02304514
	mov r1,#0x0	; 02304516
	strh r1,[r0,#0x2]	; 02304518
	b loc_02304528	; 0230451A
loc_0230451C:
	mov r1,#0x1	; 0230451C
	strh r1,[r0,#0x2]	; 0230451E
	ldr r1,[pool_0230453C]	; 02304520
	strh r1,[r0,#0x4]	; 02304522
	ldrh r1,[r4,#0x4]	; 02304524
	strh r1,[r0,#0x6]	; 02304526
loc_02304528:
	bl P4_SubmitCommandSlot	; 02304528
	add sp,#0x1fc	; 0230452C
	add sp,#0x88	; 0230452E
	pop {r4,r5}	; 02304530
	pop {r3}	; 02304532
	bx r3	; 02304534
	.byte 0xC0, 0x46	; 02304538
pool_02304538:
loc_02304538:
	.word 0x00001518	; 02304538
pool_0230453C:
loc_0230453C:
	.word 0x00000245	; 0230453C

; ===== function loc_02304540 =====
	push {r4,lr}	; 02304540
	sub sp,#0x1fc	; 02304542
	sub sp,#0xc	; 02304544
	add r0,r0,#0x4	; 02304546
	add r1,sp,#0x0	; 02304548
	mov r2,#0x6	; 0230454A
	bl loc_0230458C	; 0230454C
	add r0,sp,#0x8	; 02304550
	add r1,sp,#0x0	; 02304552
	mov r2,#0x13	; 02304554
	bl loc_02301CE4	; 02304556
	add r4,r0,#0x0	; 0230455A
	bl P4_AcquireCommandSlot	; 0230455C
	mov r1,#0x22	; 02304560
	strh r1,[r0,#0x0]	; 02304562
	ldrh r1,[r4,#0x4]	; 02304564
	cmp r1,#0x0	; 02304566
	bne loc_02304570	; 02304568
	mov r1,#0x0	; 0230456A
	strh r1,[r0,#0x2]	; 0230456C
	b loc_0230457C	; 0230456E
loc_02304570:
	mov r1,#0x1	; 02304570
	strh r1,[r0,#0x2]	; 02304572
	mov r1,#0x5	; 02304574
	strh r1,[r0,#0x4]	; 02304576
	ldrh r1,[r4,#0x4]	; 02304578
	strh r1,[r0,#0x6]	; 0230457A
loc_0230457C:
	bl P4_SubmitCommandSlot	; 0230457C
	add sp,#0x1fc	; 02304580
	add sp,#0xc	; 02304582
	pop {r4}	; 02304584
	pop {r3}	; 02304586
	bx r3	; 02304588
	.byte 0xC0, 0x46	; 0230458C

; ===== function loc_0230458C =====
loc_0230458C:
	bx pc	; 0230458C
	.byte 0xC0, 0x46	; 02304590
.arm

; ===== function loc_02304590 =====
loc_02304590:
	ldr pc,[pool_02304594]	; 02304590
pool_02304594:
loc_02304594:
	.word P2_Entry_037FF334	; 02304594
.thumb

; ===== function loc_02304598 =====
loc_02304598:
	push {r4,lr}	; 02304598
	sub sp,#0x8	; 0230459A
	bl P4_GetRuntimeState	; 0230459C
	ldr r1,[pool_02304604]	; 023045A0
	ldr r4,[r0,r1]	; 023045A2
	mov r0,#0x0	; 023045A4
	ldr r1,[r4,#0x0]	; 023045A6
	str r0,[r1,#0x10]	; 023045A8
	ldr r1,[r4,#0x0]	; 023045AA
	str r0,[r1,#0x18]	; 023045AC
	ldr r1,[r4,#0x0]	; 023045AE
	str r0,[r1,#0x14]	; 023045B0
	ldr r1,[r4,#0x0]	; 023045B2
	add r1,#0x96	; 023045B4
	strh r0,[r1,#0x0]	; 023045B6
	ldr r1,[r4,#0x0]	; 023045B8
	add r1,#0x98	; 023045BA
	strh r0,[r1,#0x0]	; 023045BC
	ldr r1,[r4,#0x0]	; 023045BE
	add r1,#0x9a	; 023045C0
	strh r0,[r1,#0x0]	; 023045C2
	ldr r2,[r4,#0x0]	; 023045C4
	ldr r1,[pool_02304608]	; 023045C6
	strh r0,[r2,r1]	; 023045C8
	ldr r2,[r4,#0x0]	; 023045CA
	ldr r1,[pool_0230460C]	; 023045CC
	strh r0,[r2,r1]	; 023045CE
	mov r1,#0x1	; 023045D0
	add r0,sp,#0x0	; 023045D2
	strh r1,[r0,#0x0]	; 023045D4
	ldrh r0,[r0,#0x0]	; 023045D6
	ldr r2,[r4,#0x0]	; 023045D8
	ldr r1,[pool_02304610]	; 023045DA
	add r1,r2,r1	; 023045DC
	ldr r2,[pool_02304614]	; 023045DE
	bl loc_0230461C	; 023045E0
	ldr r0,[r4,#0x0]	; 023045E4
	add r0,#0x5c	; 023045E6
	bl loc_02304628	; 023045E8
	ldr r1,[r4,#0x0]	; 023045EC
	ldr r0,[pool_02304618]	; 023045EE
	add r0,r1,r0	; 023045F0
	bl loc_02300A14	; 023045F2
	bl loc_02303774	; 023045F6
	add sp,#0x8	; 023045FA
	pop {r4}	; 023045FC
	pop {r3}	; 023045FE
	bx r3	; 02304600
	.byte 0xC0, 0x46	; 02304604
pool_02304604:
loc_02304604:
	.word 0x00001518	; 02304604
pool_02304608:
loc_02304608:
	.word 0x00000192	; 02304608
pool_0230460C:
loc_0230460C:
	.word 0x00000194	; 0230460C
pool_02304610:
loc_02304610:
	.word 0x000001F8	; 02304610
pool_02304614:
loc_02304614:
	.word 0x00000200	; 02304614
pool_02304618:
loc_02304618:
	.word 0x0000091C	; 02304618

; ===== function loc_0230461C =====
loc_0230461C:
	bx pc	; 0230461C
	.byte 0xC0, 0x46	; 02304620
.arm

; ===== function loc_02304620 =====
loc_02304620:
	ldr pc,[pool_02304624]	; 02304620
pool_02304624:
loc_02304624:
	.word loc_037FF31C	; 02304624
.thumb

; ===== function loc_02304628 =====
loc_02304628:
	bx pc	; 02304628
	.byte 0xC0, 0x46	; 0230462C
.arm

; ===== function loc_0230462C =====
loc_0230462C:
	ldr r12,[pool_02304634]	; 0230462C
	bx r12	; 02304630
pool_02304634:
loc_02304634:
	.word loc_037FEC34 + 1	; 02304634
.thumb

; ===== function loc_02304638 =====
	push {r4,r5,lr}	; 02304638
	sub sp,#0x4	; 0230463A
	add r5,r0,#0x0	; 0230463C
	bl P4_GetRuntimeState	; 0230463E
	ldr r2,[r5,#0x4]	; 02304642
	ldr r1,[pool_0230467C]	; 02304644
	add r0,r0,r1	; 02304646
	str r2,[r0,#0x0]	; 02304648
	ldr r4,[r0,#0x0]	; 0230464A
	ldr r0,[r5,#0x8]	; 0230464C
	str r0,[r4,#0x0]	; 0230464E
	ldr r0,[r5,#0xc]	; 02304650
	str r0,[r4,#0x8]	; 02304652
	bl loc_02304598	; 02304654
	mov r0,#0xf	; 02304658
	bl loc_02301F88	; 0230465A
	mov r1,#0x1	; 0230465E
	ldr r0,[r4,#0x0]	; 02304660
	strh r1,[r0,#0x0]	; 02304662
	bl P4_AcquireCommandSlot	; 02304664
	mov r1,#0x3	; 02304668
	strh r1,[r0,#0x0]	; 0230466A
	mov r1,#0x0	; 0230466C
	strh r1,[r0,#0x2]	; 0230466E
	bl P4_SubmitCommandSlot	; 02304670
	add sp,#0x4	; 02304674
	pop {r4,r5}	; 02304676
	pop {r3}	; 02304678
	bx r3	; 0230467A
pool_0230467C:
loc_0230467C:
	.word 0x00001518	; 0230467C
	push {r4,lr}	; 02304680
	bl P4_GetRuntimeState	; 02304682
	ldr r1,[pool_023046C8]	; 02304686
	ldr r4,[r0,r1]	; 02304688
	ldr r0,[r4,#0x0]	; 0230468A
	ldrh r0,[r0,#0x0]	; 0230468C
	cmp r0,#0x1	; 0230468E
	beq loc_023046A4	; 02304690
	bl P4_AcquireCommandSlot	; 02304692
	mov r1,#0x4	; 02304696
	strh r1,[r0,#0x0]	; 02304698
	mov r1,#0x3	; 0230469A
	strh r1,[r0,#0x2]	; 0230469C
	bl P4_SubmitCommandSlot	; 0230469E
	b loc_023046C0	; 023046A2
loc_023046A4:
	mov r0,#0x1	; 023046A4
	bl loc_02301F88	; 023046A6
	mov r1,#0x0	; 023046AA
	ldr r0,[r4,#0x0]	; 023046AC
	strh r1,[r0,#0x0]	; 023046AE
	bl P4_AcquireCommandSlot	; 023046B0
	mov r1,#0x4	; 023046B4
	strh r1,[r0,#0x0]	; 023046B6
	mov r1,#0x0	; 023046B8
	strh r1,[r0,#0x2]	; 023046BA
	bl P4_SubmitCommandSlot	; 023046BC
loc_023046C0:
	pop {r4}	; 023046C0
	pop {r3}	; 023046C2
	bx r3	; 023046C4
	.byte 0xC0, 0x46	; 023046C8
pool_023046C8:
loc_023046C8:
	.word 0x00001518	; 023046C8

; ===== function loc_023046CC =====
loc_023046CC:
	mov r1,#0xc8	; 023046CC
	ldr r0,[pool_023046E0]	; 023046CE
	strh r1,[r0,#0x0]	; 023046D0
	ldr r1,[pool_023046E4]	; 023046D2
	ldr r0,[pool_023046E8]	; 023046D4
	strh r1,[r0,#0x0]	; 023046D6
	ldr r1,[pool_023046EC]	; 023046D8
	ldr r0,[pool_023046F0]	; 023046DA
	strh r1,[r0,#0x0]	; 023046DC
	bx lr	; 023046DE
pool_023046E0:
loc_023046E0:
	.word REG_WIFI_CONFIG_124	; 023046E0
pool_023046E4:
loc_023046E4:
	.word 0x000007D0	; 023046E4
pool_023046E8:
loc_023046E8:
	.word REG_WIFI_CONFIG_128	; 023046E8
pool_023046EC:
loc_023046EC:
	.word 0x00000202	; 023046EC
pool_023046F0:
loc_023046F0:
	.word REG_WIFI_CONFIG_150	; 023046F0

; ===== function loc_023046F4 =====
loc_023046F4:
	push {r4,r5,r6,r7,lr}	; 023046F4
	sub sp,#0x1fc	; 023046F6
	sub sp,#0x8	; 023046F8
	add r5,r0,#0x0	; 023046FA
	add r6,r1,#0x0	; 023046FC
	bl P4_GetRuntimeState	; 023046FE
	ldr r1,[pool_0230480C]	; 02304702
	ldr r4,[r0,r1]	; 02304704
	add r0,sp,#0x0	; 02304706
	bl loc_02301910	; 02304708
	ldrh r1,[r0,#0x4]	; 0230470C
	cmp r1,#0x0	; 0230470E
	beq loc_0230471E	; 02304710
	ldr r1,[pool_02304810]	; 02304712
	strh r1,[r5,#0x0]	; 02304714
	ldrh r0,[r0,#0x4]	; 02304716
	strh r0,[r6,#0x0]	; 02304718
	mov r0,#0x0	; 0230471A
	b loc_02304802	; 0230471C
loc_0230471E:
	add r0,sp,#0x0	; 0230471E
	bl loc_02301930	; 02304720
	ldrh r1,[r0,#0x4]	; 02304724
	cmp r1,#0x0	; 02304726
	beq loc_02304736	; 02304728
	ldr r1,[pool_02304814]	; 0230472A
	strh r1,[r5,#0x0]	; 0230472C
	ldrh r0,[r0,#0x4]	; 0230472E
	strh r0,[r6,#0x0]	; 02304730
	mov r0,#0x0	; 02304732
	b loc_02304802	; 02304734
loc_02304736:
	bl loc_023046CC	; 02304736
	add r0,sp,#0x0	; 0230473A
	bl loc_02301960	; 0230473C
	ldrh r1,[r0,#0x4]	; 02304740
	cmp r1,#0x0	; 02304742
	beq loc_02304752	; 02304744
	ldr r1,[pool_02304818]	; 02304746
	strh r1,[r5,#0x0]	; 02304748
	ldrh r0,[r0,#0x4]	; 0230474A
	strh r0,[r6,#0x0]	; 0230474C
	mov r0,#0x0	; 0230474E
	b loc_02304802	; 02304750
loc_02304752:
	ldrh r2,[r0,#0x6]	; 02304752
	ldr r1,[r4,#0x0]	; 02304754
	ldr r0,[pool_0230481C]	; 02304756
	strh r2,[r1,r0]	; 02304758
	lsl r0,r2,#0xf	; 0230475A
	lsr r0,r0,#0x10	; 0230475C
	bl loc_023004D0	; 0230475E
	ldr r2,[r4,#0x0]	; 02304762
	ldr r1,[pool_02304820]	; 02304764
	strh r0,[r2,r1]	; 02304766
	add r0,sp,#0x0	; 02304768
	ldr r1,[pool_02304824]	; 0230476A
	mov r2,#0x28	; 0230476C
	mov r3,#0x5	; 0230476E
	bl loc_02301A6C	; 02304770
	mov r2,#0x2	; 02304774
	ldr r1,[r4,#0x0]	; 02304776
	ldr r0,[pool_02304828]	; 02304778
	strh r2,[r1,r0]	; 0230477A
	mov r2,#0x1	; 0230477C
	ldr r1,[r4,#0x0]	; 0230477E
	ldr r0,[pool_0230482C]	; 02304780
	strh r2,[r1,r0]	; 02304782
	add r0,sp,#0x0	; 02304784
	bl loc_023018F0	; 02304786
	add r7,r0,#0x0	; 0230478A
	ldrh r0,[r7,#0x4]	; 0230478C
	cmp r0,#0x0	; 0230478E
	beq loc_0230479E	; 02304790
	ldr r0,[pool_02304830]	; 02304792
	strh r0,[r5,#0x0]	; 02304794
	ldrh r0,[r7,#0x4]	; 02304796
	strh r0,[r6,#0x0]	; 02304798
	mov r0,#0x0	; 0230479A
	b loc_02304802	; 0230479C
loc_0230479E:
	add r0,r7,#0x6	; 0230479E
	ldr r1,[r4,#0x0]	; 023047A0
	add r1,#0x28	; 023047A2
	mov r2,#0x8	; 023047A4
	bl loc_0230483C	; 023047A6
	ldrh r1,[r7,#0xe]	; 023047AA
	ldr r0,[r4,#0x0]	; 023047AC
	strh r1,[r0,#0x30]	; 023047AE
	ldrh r1,[r7,#0x10]	; 023047B0
	ldr r0,[r4,#0x0]	; 023047B2
	strh r1,[r0,#0x34]	; 023047B4
	ldrh r1,[r7,#0x12]	; 023047B6
	ldr r0,[r4,#0x0]	; 023047B8
	strh r1,[r0,#0x36]	; 023047BA
	ldrh r1,[r7,#0x14]	; 023047BC
	ldr r0,[r4,#0x0]	; 023047BE
	strh r1,[r0,#0x32]	; 023047C0
	add r0,sp,#0x0	; 023047C2
	bl loc_02301970	; 023047C4
	add r1,r0,#0x0	; 023047C8
	ldrh r0,[r1,#0x4]	; 023047CA
	cmp r0,#0x0	; 023047CC
	beq loc_023047DC	; 023047CE
	ldr r0,[pool_02304834]	; 023047D0
	strh r0,[r5,#0x0]	; 023047D2
	ldrh r0,[r1,#0x4]	; 023047D4
	strh r0,[r6,#0x0]	; 023047D6
	mov r0,#0x0	; 023047D8
	b loc_02304802	; 023047DA
loc_023047DC:
	ldr r0,[r4,#0x0]	; 023047DC
	add r0,#0xe0	; 023047DE
	add r1,r1,#0x6	; 023047E0
	bl loc_02300800	; 023047E2
	add r0,sp,#0x0	; 023047E6
	mov r1,#0x1	; 023047E8
	bl loc_023019F4	; 023047EA
	ldrh r1,[r0,#0x4]	; 023047EE
	cmp r1,#0x0	; 023047F0
	beq loc_02304800	; 023047F2
	ldr r1,[pool_02304838]	; 023047F4
	strh r1,[r5,#0x0]	; 023047F6
	ldrh r0,[r0,#0x4]	; 023047F8
	strh r0,[r6,#0x0]	; 023047FA
	mov r0,#0x0	; 023047FC
	b loc_02304802	; 023047FE
loc_02304800:
	mov r0,#0x1	; 02304800
loc_02304802:
	add sp,#0x1fc	; 02304802
	add sp,#0x8	; 02304804
	pop {r4,r5,r6,r7}	; 02304806
	pop {r3}	; 02304808
	bx r3	; 0230480A
pool_0230480C:
loc_0230480C:
	.word 0x00001518	; 0230480C
pool_02304810:
loc_02304810:
	.word 0x00000304	; 02304810
pool_02304814:
loc_02304814:
	.word 0x00000302	; 02304814
pool_02304818:
loc_02304818:
	.word 0x00000283	; 02304818
pool_0230481C:
loc_0230481C:
	.word 0x000001F4	; 0230481C
pool_02304820:
loc_02304820:
	.word 0x000001F6	; 02304820
pool_02304824:
loc_02304824:
	.word 0x0000FFFF	; 02304824
pool_02304828:
loc_02304828:
	.word 0x000001EC	; 02304828
pool_0230482C:
loc_0230482C:
	.word 0x000001EE	; 0230482C
pool_02304830:
loc_02304830:
	.word 0x00000306	; 02304830
pool_02304834:
loc_02304834:
	.word 0x00000281	; 02304834
pool_02304838:
loc_02304838:
	.word 0x00000215	; 02304838

; ===== function loc_0230483C =====
loc_0230483C:
	bx pc	; 0230483C
	.byte 0xC0, 0x46	; 02304840
.arm

; ===== function loc_02304840 =====
loc_02304840:
	ldr pc,[pool_02304844]	; 02304840
pool_02304844:
loc_02304844:
	.word P2_Entry_037FF334	; 02304844
.thumb

; ===== function loc_02304848 =====
	push {r4,lr}	; 02304848
	sub sp,#0x8	; 0230484A
	bl P4_GetRuntimeState	; 0230484C
	ldr r1,[pool_023048B8]	; 02304850
	ldr r4,[r0,r1]	; 02304852
	ldr r0,[r4,#0x0]	; 02304854
	ldrh r0,[r0,#0x0]	; 02304856
	cmp r0,#0x1	; 02304858
	beq loc_0230486E	; 0230485A
	bl P4_AcquireCommandSlot	; 0230485C
	mov r1,#0x5	; 02304860
	strh r1,[r0,#0x0]	; 02304862
	mov r1,#0x3	; 02304864
	strh r1,[r0,#0x2]	; 02304866
	bl P4_SubmitCommandSlot	; 02304868
	b loc_023048AE	; 0230486C
loc_0230486E:
	add r0,sp,#0x0	; 0230486E
	add r1,sp,#0x0	; 02304870
	add r1,#0x2	; 02304872
	bl loc_023046F4	; 02304874
	cmp r0,#0x0	; 02304878
	bne loc_02304898	; 0230487A
	bl P4_AcquireCommandSlot	; 0230487C
	mov r1,#0x5	; 02304880
	strh r1,[r0,#0x0]	; 02304882
	mov r1,#0x1	; 02304884
	strh r1,[r0,#0x2]	; 02304886
	add r1,sp,#0x0	; 02304888
	ldrh r2,[r1,#0x0]	; 0230488A
	strh r2,[r0,#0x4]	; 0230488C
	ldrh r1,[r1,#0x2]	; 0230488E
	strh r1,[r0,#0x6]	; 02304890
	bl P4_SubmitCommandSlot	; 02304892
	b loc_023048AE	; 02304896
loc_02304898:
	mov r1,#0x2	; 02304898
	ldr r0,[r4,#0x0]	; 0230489A
	strh r1,[r0,#0x0]	; 0230489C
	bl P4_AcquireCommandSlot	; 0230489E
	mov r1,#0x5	; 023048A2
	strh r1,[r0,#0x0]	; 023048A4
	mov r1,#0x0	; 023048A6
	strh r1,[r0,#0x2]	; 023048A8
	bl P4_SubmitCommandSlot	; 023048AA
loc_023048AE:
	add sp,#0x8	; 023048AE
	pop {r4}	; 023048B0
	pop {r3}	; 023048B2
	bx r3	; 023048B4
	.byte 0xC0, 0x46	; 023048B8
pool_023048B8:
loc_023048B8:
	.word 0x00001518	; 023048B8

; ===== function loc_023048BC =====
	push {r4,r5,lr}	; 023048BC
	sub sp,#0x1fc	; 023048BE
	sub sp,#0x8	; 023048C0
	bl P4_GetRuntimeState	; 023048C2
	ldr r1,[pool_0230492C]	; 023048C6
	ldr r5,[r0,r1]	; 023048C8
	ldr r0,[r5,#0x0]	; 023048CA
	ldrh r0,[r0,#0x0]	; 023048CC
	cmp r0,#0x2	; 023048CE
	beq loc_023048E4	; 023048D0
	bl P4_AcquireCommandSlot	; 023048D2
	mov r1,#0x6	; 023048D6
	strh r1,[r0,#0x0]	; 023048D8
	mov r1,#0x3	; 023048DA
	strh r1,[r0,#0x2]	; 023048DC
	bl P4_SubmitCommandSlot	; 023048DE
	b loc_02304922	; 023048E2
loc_023048E4:
	add r0,sp,#0x0	; 023048E4
	bl loc_02301940	; 023048E6
	add r4,r0,#0x0	; 023048EA
	ldrh r0,[r4,#0x4]	; 023048EC
	cmp r0,#0x0	; 023048EE
	beq loc_0230490C	; 023048F0
	bl P4_AcquireCommandSlot	; 023048F2
	mov r1,#0x6	; 023048F6
	strh r1,[r0,#0x0]	; 023048F8
	mov r1,#0x1	; 023048FA
	strh r1,[r0,#0x2]	; 023048FC
	ldr r1,[pool_02304930]	; 023048FE
	strh r1,[r0,#0x4]	; 02304900
	ldrh r1,[r4,#0x4]	; 02304902
	strh r1,[r0,#0x6]	; 02304904
	bl P4_SubmitCommandSlot	; 02304906
	b loc_02304922	; 0230490A
loc_0230490C:
	mov r1,#0x1	; 0230490C
	ldr r0,[r5,#0x0]	; 0230490E
	strh r1,[r0,#0x0]	; 02304910
	bl P4_AcquireCommandSlot	; 02304912
	mov r1,#0x6	; 02304916
	strh r1,[r0,#0x0]	; 02304918
	mov r1,#0x0	; 0230491A
	strh r1,[r0,#0x2]	; 0230491C
	bl P4_SubmitCommandSlot	; 0230491E
loc_02304922:
	add sp,#0x1fc	; 02304922
	add sp,#0x8	; 02304924
	pop {r4,r5}	; 02304926
	pop {r3}	; 02304928
	bx r3	; 0230492A
pool_0230492C:
loc_0230492C:
	.word 0x00001518	; 0230492C
pool_02304930:
loc_02304930:
	.word 0x00000301	; 02304930

; ===== function loc_02304934 =====
	push {r4,r5,lr}	; 02304934
	sub sp,#0x4	; 02304936
	add r4,r0,#0x0	; 02304938
	bl P4_GetRuntimeState	; 0230493A
	ldr r1,[pool_0230497C]	; 0230493E
	ldr r0,[r0,r1]	; 02304940
	ldr r5,[r0,#0x0]	; 02304942
	ldr r0,[r4,#0x4]	; 02304944
	lsl r0,r0,#0x10	; 02304946
	lsr r4,r0,#0x10	; 02304948
	cmp r4,#0x0	; 0230494A
	bne loc_02304950	; 0230494C
	mov r4,#0x10	; 0230494E
loc_02304950:
	bl loc_02304980	; 02304950
	strh r4,[r5,#0x3c]	; 02304954
	ldrh r1,[r5,#0x3e]	; 02304956
	cmp r1,r4	; 02304958
	bls loc_0230495E	; 0230495A
	strh r4,[r5,#0x3e]	; 0230495C
loc_0230495E:
	bl loc_0230498C	; 0230495E
	bl P4_AcquireCommandSlot	; 02304962
	mov r1,#0x23	; 02304966
	strh r1,[r0,#0x0]	; 02304968
	mov r1,#0x0	; 0230496A
	strh r1,[r0,#0x2]	; 0230496C
	bl P4_SubmitCommandSlot	; 0230496E
	add sp,#0x4	; 02304972
	pop {r4,r5}	; 02304974
	pop {r3}	; 02304976
	bx r3	; 02304978
	.byte 0xC0, 0x46	; 0230497C
pool_0230497C:
loc_0230497C:
	.word 0x00001518	; 0230497C

; ===== function loc_02304980 =====
loc_02304980:
	bx pc	; 02304980
	.byte 0xC0, 0x46	; 02304984
.arm

; ===== function loc_02304984 =====
loc_02304984:
	ldr pc,[pool_02304988]	; 02304984
pool_02304988:
loc_02304988:
	.word loc_037FF104	; 02304988
.thumb

; ===== function loc_0230498C =====
loc_0230498C:
	bx pc	; 0230498C
	.byte 0xC0, 0x46	; 02304990
.arm

; ===== function loc_02304990 =====
loc_02304990:
	ldr pc,[pool_02304994]	; 02304990
pool_02304994:
loc_02304994:
	.word loc_037FF118	; 02304994
.thumb
	mov r1,#0x1	; 02304998
	ldr r3,[pool_023049A0]	; 0230499A
	bx r3	; 0230499C
	.byte 0xC0, 0x46	; 023049A0
pool_023049A0:
loc_023049A0:
	.word loc_02302B28 + 1	; 023049A0

; ===== function loc_023049A4 =====
loc_023049A4:
; 保存参数中的无线工作区指针，初始化状态并开启 Wi-Fi 总线。
; Stores the supplied wireless work pointer, initializes state and enables the Wi-Fi bus.
.func P4_InitializeWirelessWork
	push {r4,r5,lr}	; 023049A4
	sub sp,#0x14	; 023049A6
	add r4,r0,#0x0	; 023049A8
	ldr r1,[r4,#0x0]	; 023049AA
	ldr r0,[pool_02304AE0]	; 023049AC
	str r1,[r0,#0x0]	; 023049AE
	mov r0,#0x0	; 023049B0
	str r0,[sp,#0xc]	; 023049B2
	ldr r0,[sp,#0xc]	; 023049B4
	ldr r2,[pool_02304AE4]	; 023049B6
	bl loc_02304B18	; 023049B8
	bl loc_02304B24	; 023049BC
	ldr r1,[pool_02304AE0]	; 023049C0
	ldr r3,[r1,#0x0]	; 023049C2
	ldr r2,[pool_02304AE8]	; 023049C4
	str r0,[r3,r2]	; 023049C6
	ldr r3,[r4,#0x18]	; 023049C8
	ldr r2,[r1,#0x0]	; 023049CA
	ldr r0,[pool_02304AEC]	; 023049CC
	str r3,[r2,r0]	; 023049CE
	ldr r0,[r4,#0x1c]	; 023049D0
	lsr r3,r0,#0x1	; 023049D2
	ldr r2,[r1,#0x0]	; 023049D4
	ldr r0,[pool_02304AF0]	; 023049D6
	str r3,[r2,r0]	; 023049D8
	ldr r1,[r1,#0x0]	; 023049DA
	add r1,r1,r0	; 023049DC
	ldr r0,[r1,#0x0]	; 023049DE
	cmp r0,#0x0	; 023049E0
	bne loc_023049EA	; 023049E2
	mov r0,#0x0	; 023049E4
	mvn r0,r0	; 023049E6
	str r0,[r1,#0x0]	; 023049E8
loc_023049EA:
	add r0,r4,#0x0	; 023049EA
	add r0,#0x20	; 023049EC
	bl loc_02304CA4	; 023049EE
	bl loc_0230D2E4	; 023049F2
	ldr r2,[pool_02304AF4]	; 023049F6
	ldrh r0,[r2,#0x0]	; 023049F8
	mov r1,#0x2	; 023049FA
	orr r0,r1	; 023049FC
	strh r0,[r2,#0x0]	; 023049FE
	mov r2,#0x30	; 02304A00
	ldr r0,[pool_02304AF8]	; 02304A02
	strh r2,[r0,#0x0]	; 02304A04
	mov r5,#0x3	; 02304A06
	ldr r3,[pool_02304AE0]	; 02304A08
	ldr r2,[r3,#0x0]	; 02304A0A
	ldr r0,[pool_02304AFC]	; 02304A0C
	str r5,[r2,r0]	; 02304A0E
	mov r0,#0x3c	; 02304A10
	ldr r3,[r3,#0x0]	; 02304A12
	ldr r2,[pool_02304B00]	; 02304A14
	add r2,r3,r2	; 02304A16
	bl loc_0230D400	; 02304A18
	mov r0,#0x3e	; 02304A1C
	mov r1,#0x2	; 02304A1E
	ldr r2,[pool_02304AE0]	; 02304A20
	ldr r3,[r2,#0x0]	; 02304A22
	ldr r2,[pool_02304B04]	; 02304A24
	add r2,r3,r2	; 02304A26
	bl loc_0230D400	; 02304A28
	ldr r2,[r4,#0x10]	; 02304A2C
	ldr r3,[pool_02304AE0]	; 02304A2E
	ldr r1,[r3,#0x0]	; 02304A30
	ldr r0,[pool_02304B08]	; 02304A32
	str r2,[r1,r0]	; 02304A34
	ldr r2,[r4,#0x14]	; 02304A36
	ldr r1,[r3,#0x0]	; 02304A38
	ldr r0,[pool_02304B0C]	; 02304A3A
	str r2,[r1,r0]	; 02304A3C
	ldr r0,[r4,#0x30]	; 02304A3E
	mov r1,#0x1c	; 02304A40
	bl loc_02304B30	; 02304A42
	add r1,r0,#0x0	; 02304A46
	ldr r0,[r4,#0x2c]	; 02304A48
	bl loc_02306984	; 02304A4A
	bl loc_02304B88	; 02304A4E
	bl loc_02307824	; 02304A52
	bl loc_02307894	; 02304A56
	bl loc_02306F50	; 02304A5A
	bl loc_02305518	; 02304A5E
	add r0,sp,#0x8	; 02304A62
	bl loc_0230D490	; 02304A64
	cmp r0,#0x0	; 02304A68
	beq loc_02304A7E	; 02304A6A
	ldr r0,[pool_02304AE0]	; 02304A6C
	ldr r1,[r0,#0x0]	; 02304A6E
	ldr r0,[pool_02304B10]	; 02304A70
	add r1,r1,r0	; 02304A72
	ldrh r2,[r1,#0x0]	; 02304A74
	mov r0,#0x80	; 02304A76
	orr r2,r0	; 02304A78
	strh r2,[r1,#0x0]	; 02304A7A
	b loc_02304AAA	; 02304A7C
loc_02304A7E:
	bl loc_023056CC	; 02304A7E
	bl loc_02306CB4	; 02304A82
	bl loc_02305DC8	; 02304A86
	bl loc_023056A4	; 02304A8A
	bl loc_0230556C	; 02304A8E
	bl loc_02306C3C	; 02304A92
	bl loc_02306BE8	; 02304A96
	bl loc_02306A14	; 02304A9A
	bl loc_02305664	; 02304A9E
	bl loc_02306164	; 02304AA2
	bl loc_02305E30	; 02304AA6
loc_02304AAA:
	ldr r0,[r4,#0x8]	; 02304AAA
	str r0,[sp,#0x0]	; 02304AAC
	ldr r0,[r4,#0xc]	; 02304AAE
	str r0,[sp,#0x4]	; 02304AB0
	ldr r0,[pool_02304AE0]	; 02304AB2
	ldr r0,[r0,#0x0]	; 02304AB4
	add r0,#0x18	; 02304AB6
	ldr r1,[pool_02304B14]	; 02304AB8
	mov r2,#0x0	; 02304ABA
	ldr r3,[r4,#0x4]	; 02304ABC
	bl loc_02300A24	; 02304ABE
	ldr r0,[pool_02304AE0]	; 02304AC2
	ldr r0,[r0,#0x0]	; 02304AC4
	add r0,#0x18	; 02304AC6
	bl loc_02300A34	; 02304AC8
	bl loc_02306D90	; 02304ACC
	ldr r0,[pool_02304AE0]	; 02304AD0
	ldr r1,[r0,#0x0]	; 02304AD2
	ldr r0,[pool_02304B10]	; 02304AD4
	ldrh r0,[r1,r0]	; 02304AD6
	add sp,#0x14	; 02304AD8
	pop {r4,r5}	; 02304ADA
	pop {r3}	; 02304ADC
	bx r3	; 02304ADE
.endfunc
pool_02304AE0:
loc_02304AE0:
	.word FirmwareWlWorkPointerSlot	; 02304AE0
pool_02304AE4:
loc_02304AE4:
	.word 0x0000063C	; 02304AE4
pool_02304AE8:
loc_02304AE8:
	.word 0x000002E8	; 02304AE8
pool_02304AEC:
loc_02304AEC:
	.word 0x000002E0	; 02304AEC
pool_02304AF0:
loc_02304AF0:
	.word 0x000002E4	; 02304AF0
pool_02304AF4:
loc_02304AF4:
	.word REG_POWERCNT_ARM7	; 02304AF4
pool_02304AF8:
loc_02304AF8:
	.word REG_WIFIWAITCNT_ARM7	; 02304AF8
pool_02304AFC:
loc_02304AFC:
	.word 0x00000634	; 02304AFC
pool_02304B00:
loc_02304B00:
	.word 0x0000063A	; 02304B00
pool_02304B04:
loc_02304B04:
	.word 0x00000638	; 02304B04
pool_02304B08:
loc_02304B08:
	.word 0x000002DC	; 02304B08
pool_02304B0C:
loc_02304B0C:
	.word 0x000002D8	; 02304B0C
pool_02304B10:
loc_02304B10:
	.word 0x00000312	; 02304B10
pool_02304B14:
loc_02304B14:
	.word 0x037FB34D	; 02304B14

; ===== function loc_02304B18 =====
loc_02304B18:
	bx pc	; 02304B18
	.byte 0xC0, 0x46	; 02304B1C
.arm

; ===== function loc_02304B1C =====
loc_02304B1C:
	ldr pc,[pool_02304B20]	; 02304B1C
pool_02304B20:
loc_02304B20:
	.word P2_Entry_037FF37C	; 02304B20
.thumb

; ===== function loc_02304B24 =====
loc_02304B24:
	bx pc	; 02304B24
	.byte 0xC0, 0x46	; 02304B28
.arm

; ===== function loc_02304B28 =====
loc_02304B28:
	ldr pc,[pool_02304B2C]	; 02304B28
pool_02304B2C:
loc_02304B2C:
	.word loc_037FDBA8	; 02304B2C
.thumb

; ===== function loc_02304B30 =====
loc_02304B30:
	bx pc	; 02304B30
	.byte 0xC0, 0x46	; 02304B34
.arm

; ===== function loc_02304B34 =====
loc_02304B34:
	ldr pc,[pool_02304B38]	; 02304B34
pool_02304B38:
loc_02304B38:
	.word loc_03804DB0	; 02304B38
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x00, 0xF0, 0x0A, 0xFC, 0x01, 0xF0, 0x74, 0xF9, 0x00, 0xF0, 0xAC, 0xFD	; 02304B4C
	.byte 0x00, 0xF0, 0x7E, 0xF8, 0x00, 0xF0, 0x1A, 0xF8, 0x09, 0x48, 0x02, 0x68, 0x09, 0x48, 0x10, 0x58	; 02304B5C
	.byte 0x09, 0x49, 0x51, 0x5A, 0x01, 0xF0, 0x10, 0xFF, 0x02, 0xF0, 0x5E, 0xFE, 0x02, 0xF0, 0x94, 0xFE	; 02304B6C
	.byte 0x02, 0xF0, 0xF0, 0xF9, 0x01, 0xF0, 0xF8, 0xFA, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02304B7C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xF0, 0x02, 0x00, 0x00, 0xF4, 0x02, 0x00, 0x00	; 02304B88
.thumb

; ===== function loc_02304B88 =====
loc_02304B88:
	push {r4,r5,r6,lr}	; 02304B88
	ldr r0,[pool_02304BDC]	; 02304B8A
	ldr r5,[r0,#0x0]	; 02304B8C
	mov r3,#0x0	; 02304B8E
	strh r3,[r5,#0x10]	; 02304B90
	strh r3,[r5,#0x12]	; 02304B92
	ldr r1,[pool_02304BE0]	; 02304B94
loc_02304B96:
	lsl r2,r3,#0x1	; 02304B96
	add r0,r5,r2	; 02304B98
	strh r1,[r0,#0x8]	; 02304B9A
	ldrh r0,[r0,#0x8]	; 02304B9C
	strh r0,[r5,r2]	; 02304B9E
	add r3,r3,#0x1	; 02304BA0
	cmp r3,#0x4	; 02304BA2
	bcc loc_02304B96	; 02304BA4
	mov r4,#0x0	; 02304BA6
	ldr r2,[pool_02304BE0]	; 02304BA8
	add r1,r4,#0x0	; 02304BAA
	ldr r0,[pool_02304BE4]	; 02304BAC
loc_02304BAE:
	lsl r3,r4,#0x3	; 02304BAE
	add r3,r5,r3	; 02304BB0
	add r6,r3,#0x0	; 02304BB2
	add r6,#0x90	; 02304BB4
	strh r2,[r6,#0x0]	; 02304BB6
	add r6,r3,#0x0	; 02304BB8
	add r6,#0x92	; 02304BBA
	strh r1,[r6,#0x0]	; 02304BBC
	lsl r6,r4,#0x2	; 02304BBE
	ldr r6,[r0,r6]	; 02304BC0
	add r3,#0x94	; 02304BC2
	str r6,[r3,#0x0]	; 02304BC4
	add r4,r4,#0x1	; 02304BC6
	cmp r4,#0x18	; 02304BC8
	bcc loc_02304BAE	; 02304BCA
	mov r0,#0x3	; 02304BCC
	mov r1,#0xc	; 02304BCE
	bl loc_02304BE8	; 02304BD0
	pop {r4,r5,r6}	; 02304BD4
	pop {r3}	; 02304BD6
	bx r3	; 02304BD8
	.byte 0xC0, 0x46	; 02304BDC
pool_02304BDC:
loc_02304BDC:
	.word FirmwareWlWorkPointerSlot	; 02304BDC
pool_02304BE0:
loc_02304BE0:
	.word 0x0000FFFF	; 02304BE0
pool_02304BE4:
loc_02304BE4:
	.word P4_Data_0230D5A4	; 02304BE4

; ===== function loc_02304BE8 =====
loc_02304BE8:
	bx pc	; 02304BE8
	.byte 0xC0, 0x46	; 02304BEC
.arm

; ===== function loc_02304BEC =====
loc_02304BEC:
	ldr r12,[pool_02304BF4]	; 02304BEC
	bx r12	; 02304BF0
pool_02304BF4:
loc_02304BF4:
	.word loc_037FB3C4 + 1	; 02304BF4
P4_Entry_02304BF8:
.thumb
	push {r4,r5,r6,r7,lr}	; 02304BF8
	sub sp,#0x4	; 02304BFA
	add r6,r0,#0x0	; 02304BFC
	ldr r5,[r6,#0x0]	; 02304BFE
	ldrh r0,[r6,#0x8]	; 02304C00
	cmp r0,#0x0	; 02304C02
	beq P4_Entry_02304C22	; 02304C04
	mov r0,#0x0	; 02304C06
	mvn r4,r0	; 02304C08
	b P4_Entry_02304C1E	; 02304C0A
P4_Entry_02304C0C:
	add r0,r5,#0x0	; 02304C0C
	bl loc_02304C2C	; 02304C0E
	add r7,r0,#0x0	; 02304C12
	add r0,r6,#0x0	; 02304C14
	add r1,r5,#0x0	; 02304C16
	bl loc_02304C3C	; 02304C18
	add r5,r7,#0x0	; 02304C1C
P4_Entry_02304C1E:
	cmp r5,r4	; 02304C1E
	bne P4_Entry_02304C0C	; 02304C20
P4_Entry_02304C22:
	add sp,#0x4	; 02304C22
	pop {r4,r5,r6,r7}	; 02304C24
	pop {r3}	; 02304C26
	bx r3	; 02304C28
	.byte 0xC0, 0x46	; 02304C2A
.arm
.thumb

; ===== function loc_02304C2C =====
loc_02304C2C:
	bx pc	; 02304C2C
	.byte 0xC0, 0x46	; 02304C30
.arm

; ===== function loc_02304C30 =====
loc_02304C30:
	ldr r12,[pool_02304C38]	; 02304C30
	bx r12	; 02304C34
pool_02304C38:
loc_02304C38:
	.word P2_Entry_037FB754 + 1	; 02304C38
.thumb

; ===== function loc_02304C3C =====
loc_02304C3C:
	bx pc	; 02304C3C
	.byte 0xC0, 0x46	; 02304C40
.arm

; ===== function loc_02304C40 =====
loc_02304C40:
	ldr r12,[pool_02304C48]	; 02304C40
	bx r12	; 02304C44
pool_02304C48:
loc_02304C48:
	.word P2_Entry_037FB648 + 1	; 02304C48
.thumb
P4_Entry_02304C4C:
	push {r4,lr}	; 02304C4C
	ldr r0,[pool_02304C9C]	; 02304C4E
	ldr r1,[r0,#0x0]	; 02304C50
	ldr r0,[pool_02304CA0]	; 02304C52
	add r4,r1,r0	; 02304C54
	add r0,r4,#0x0	; 02304C56
	add r0,#0x18	; 02304C58
	bl P4_Entry_02304BF8	; 02304C5A
	add r0,r4,#0x0	; 02304C5E
	add r0,#0x24	; 02304C60
	bl P4_Entry_02304BF8	; 02304C62
	add r0,r4,#0x0	; 02304C66
	add r0,#0x30	; 02304C68
	bl P4_Entry_02304BF8	; 02304C6A
	add r0,r4,#0x0	; 02304C6E
	add r0,#0x3c	; 02304C70
	bl P4_Entry_02304BF8	; 02304C72
	add r0,r4,#0x0	; 02304C76
	add r0,#0x48	; 02304C78
	bl P4_Entry_02304BF8	; 02304C7A
	add r0,r4,#0x0	; 02304C7E
	add r0,#0x54	; 02304C80
	bl P4_Entry_02304BF8	; 02304C82
	add r0,r4,#0x0	; 02304C86
	add r0,#0x60	; 02304C88
	bl P4_Entry_02304BF8	; 02304C8A
	add r4,#0x6c	; 02304C8E
	add r0,r4,#0x0	; 02304C90
	bl P4_Entry_02304BF8	; 02304C92
	pop {r4}	; 02304C96
	pop {r3}	; 02304C98
	bx r3	; 02304C9A
pool_02304C9C:
	.word FirmwareWlWorkPointerSlot	; 02304C9C
pool_02304CA0:
	.word 0x00000150	; 02304CA0
.arm
.thumb

; ===== function loc_02304CA4 =====
loc_02304CA4:
	push {r4,r5,lr}	; 02304CA4
	sub sp,#0x4	; 02304CA6
	ldr r1,[pool_02304D54]	; 02304CA8
	ldr r2,[r1,#0x0]	; 02304CAA
	ldr r1,[pool_02304D58]	; 02304CAC
	add r5,r2,r1	; 02304CAE
	ldr r1,[pool_02304D5C]	; 02304CB0
	add r4,r2,r1	; 02304CB2
	ldr r1,[r0,#0x0]	; 02304CB4
	str r1,[r5,#0x0]	; 02304CB6
	ldr r1,[r0,#0x4]	; 02304CB8
	str r1,[r5,#0x4]	; 02304CBA
	ldr r0,[r0,#0x8]	; 02304CBC
	str r0,[r5,#0x8]	; 02304CBE
	add r0,r5,#0x0	; 02304CC0
	add r0,#0xc	; 02304CC2
	mov r1,#0x2	; 02304CC4
	bl loc_02304D70	; 02304CC6
	add r0,r5,#0x0	; 02304CCA
	add r0,#0x18	; 02304CCC
	mov r1,#0x3	; 02304CCE
	bl loc_02304D70	; 02304CD0
	add r0,r5,#0x0	; 02304CD4
	add r0,#0x24	; 02304CD6
	mov r1,#0x4	; 02304CD8
	bl loc_02304D70	; 02304CDA
	add r0,r5,#0x0	; 02304CDE
	add r0,#0x30	; 02304CE0
	mov r1,#0x5	; 02304CE2
	bl loc_02304D70	; 02304CE4
	add r0,r5,#0x0	; 02304CE8
	add r0,#0x3c	; 02304CEA
	mov r1,#0x6	; 02304CEC
	bl loc_02304D70	; 02304CEE
	add r0,r5,#0x0	; 02304CF2
	add r0,#0x48	; 02304CF4
	mov r1,#0x7	; 02304CF6
	bl loc_02304D70	; 02304CF8
	add r0,r5,#0x0	; 02304CFC
	add r0,#0x54	; 02304CFE
	mov r1,#0x8	; 02304D00
	bl loc_02304D70	; 02304D02
	add r0,r5,#0x0	; 02304D06
	add r0,#0x60	; 02304D08
	mov r1,#0x9	; 02304D0A
	bl loc_02304D70	; 02304D0C
	add r0,r5,#0x0	; 02304D10
	add r0,#0x6c	; 02304D12
	mov r1,#0xa	; 02304D14
	bl loc_02304D70	; 02304D16
	add r0,r5,#0x0	; 02304D1A
	add r0,#0x78	; 02304D1C
	mov r1,#0xb	; 02304D1E
	bl loc_02304D70	; 02304D20
	add r0,r5,#0x0	; 02304D24
	add r0,#0x84	; 02304D26
	mov r1,#0xc	; 02304D28
	bl loc_02304D70	; 02304D2A
	add r5,#0xc	; 02304D2E
	add r0,r5,#0x0	; 02304D30
	mov r1,#0x81	; 02304D32
	bl loc_02304D60	; 02304D34
	add r0,#0xc	; 02304D38
	add r1,r4,#0x0	; 02304D3A
	add r1,#0x9c	; 02304D3C
	str r0,[r1,#0x0]	; 02304D3E
	mov r1,#0x0	; 02304D40
	add r0,r4,#0x0	; 02304D42
	add r0,#0xa0	; 02304D44
	strh r1,[r0,#0x0]	; 02304D46
	add r4,#0xa4	; 02304D48
	strh r1,[r4,#0x0]	; 02304D4A
	add sp,#0x4	; 02304D4C
	pop {r4,r5}	; 02304D4E
	pop {r3}	; 02304D50
	bx r3	; 02304D52
pool_02304D54:
loc_02304D54:
	.word FirmwareWlWorkPointerSlot	; 02304D54
pool_02304D58:
loc_02304D58:
	.word 0x00000150	; 02304D58
pool_02304D5C:
loc_02304D5C:
	.word 0x00000318	; 02304D5C

; ===== function loc_02304D60 =====
loc_02304D60:
	bx pc	; 02304D60
	.byte 0xC0, 0x46	; 02304D64
.arm

; ===== function loc_02304D64 =====
loc_02304D64:
	ldr r12,[pool_02304D6C]	; 02304D64
	bx r12	; 02304D68
pool_02304D6C:
loc_02304D6C:
	.word P2_Entry_037FB5DC + 1	; 02304D6C
.thumb

; ===== function loc_02304D70 =====
loc_02304D70:
	mov r2,#0x0	; 02304D70
	mvn r3,r2	; 02304D72
	str r3,[r0,#0x0]	; 02304D74
	str r3,[r0,#0x4]	; 02304D76
	strh r2,[r0,#0x8]	; 02304D78
	strh r1,[r0,#0xa]	; 02304D7A
	bx lr	; 02304D7C
	.byte 0x00, 0x00	; 02304D80
	push {r4,lr}	; 02304D80
	ldr r0,[pool_02304DBC]	; 02304D82
	ldr r1,[r0,#0x0]	; 02304D84
	ldr r0,[pool_02304DC0]	; 02304D86
	add r4,r1,r0	; 02304D88
	bl loc_02306D64	; 02304D8A
	add r0,r4,#0x0	; 02304D8E
	add r0,#0xc	; 02304D90
	ldr r1,[pool_02304DBC]	; 02304D92
	ldr r2,[r1,#0x0]	; 02304D94
	ldr r1,[pool_02304DC4]	; 02304D96
	ldr r1,[r2,r1]	; 02304D98
	sub r1,#0xc	; 02304D9A
	bl loc_02304C3C	; 02304D9C
	add r4,#0xc	; 02304DA0
	add r0,r4,#0x0	; 02304DA2
	ldr r1,[pool_02304DBC]	; 02304DA4
	ldr r2,[r1,#0x0]	; 02304DA6
	ldr r1,[pool_02304DC8]	; 02304DA8
	ldr r1,[r2,r1]	; 02304DAA
	sub r1,#0xc	; 02304DAC
	bl loc_02304C3C	; 02304DAE
	bl loc_02304DCC	; 02304DB2
	pop {r4}	; 02304DB6
	pop {r3}	; 02304DB8
	bx r3	; 02304DBA
pool_02304DBC:
loc_02304DBC:
	.word FirmwareWlWorkPointerSlot	; 02304DBC
pool_02304DC0:
loc_02304DC0:
	.word 0x00000150	; 02304DC0
pool_02304DC4:
loc_02304DC4:
	.word 0x000002EC	; 02304DC4
pool_02304DC8:
loc_02304DC8:
	.word 0x000003B4	; 02304DC8

; ===== function loc_02304DCC =====
loc_02304DCC:
	bx pc	; 02304DCC
	.byte 0xC0, 0x46	; 02304DD0
.arm

; ===== function loc_02304DD0 =====
loc_02304DD0:
	ldr r12,[pool_02304DD8]	; 02304DD0
	bx r12	; 02304DD4
pool_02304DD8:
loc_02304DD8:
	.word P2_Entry_037FDF8C + 1	; 02304DD8
.thumb

; ===== function loc_02304DDC =====
	push {lr}	; 02304DDC
	sub sp,#0x4	; 02304DDE
	ldr r3,[pool_02304E3C]	; 02304DE0
	ldr r1,[r3,#0x0]	; 02304DE2
	ldr r0,[pool_02304E40]	; 02304DE4
	add r1,r1,r0	; 02304DE6
	ldrh r2,[r1,#0x0]	; 02304DE8
	ldr r0,[pool_02304E44]	; 02304DEA
	orr r2,r0	; 02304DEC
	strh r2,[r1,#0x0]	; 02304DEE
	ldr r1,[r3,#0x0]	; 02304DF0
	ldr r0,[pool_02304E48]	; 02304DF2
	ldrh r0,[r1,r0]	; 02304DF4
	cmp r0,#0x0	; 02304DF6
	beq loc_02304E22	; 02304DF8
	bl loc_02304E58	; 02304DFA
	ldr r3,[pool_02304E3C]	; 02304DFE
	ldr r1,[r3,#0x0]	; 02304E00
	ldr r0,[pool_02304E4C]	; 02304E02
	add r0,r1,r0	; 02304E04
	ldrh r1,[r0,#0x0]	; 02304E06
	cmp r1,#0x0	; 02304E08
	beq loc_02304E1E	; 02304E0A
	mov r1,#0x0	; 02304E0C
	strh r1,[r0,#0x0]	; 02304E0E
	mov r2,#0x6	; 02304E10
	ldr r1,[r3,#0x0]	; 02304E12
	ldr r0,[pool_02304E50]	; 02304E14
	ldr r0,[r1,r0]	; 02304E16
	strh r2,[r0,#0x4]	; 02304E18
	bl loc_02307CB0	; 02304E1A
loc_02304E1E:
	bl loc_02305E30	; 02304E1E
loc_02304E22:
	mov r0,#0x3	; 02304E22
	bl loc_02304E68	; 02304E24
	ldr r1,[pool_02304E54]	; 02304E28
	cmp r0,r1	; 02304E2A
	bne loc_02304E22	; 02304E2C
	mov r0,#0x3	; 02304E2E
	mov r1,#0x17	; 02304E30
	bl loc_02304BE8	; 02304E32
	add sp,#0x4	; 02304E36
	pop {r3}	; 02304E38
	bx r3	; 02304E3A
pool_02304E3C:
loc_02304E3C:
	.word FirmwareWlWorkPointerSlot	; 02304E3C
pool_02304E40:
loc_02304E40:
	.word 0x00000312	; 02304E40
pool_02304E44:
loc_02304E44:
	.word 0x00008000	; 02304E44
pool_02304E48:
loc_02304E48:
	.word 0x00000320	; 02304E48
pool_02304E4C:
loc_02304E4C:
	.word 0x000003D8	; 02304E4C
pool_02304E50:
loc_02304E50:
	.word 0x000003F4	; 02304E50
pool_02304E54:
loc_02304E54:
	.word 0x0000FFFF	; 02304E54

; ===== function loc_02304E58 =====
loc_02304E58:
	bx pc	; 02304E58
	.byte 0xC0, 0x46	; 02304E5C
.arm

; ===== function loc_02304E5C =====
loc_02304E5C:
	ldr r12,[pool_02304E64]	; 02304E5C
	bx r12	; 02304E60
pool_02304E64:
loc_02304E64:
	.word loc_037FBDA0 + 1	; 02304E64
.thumb

; ===== function loc_02304E68 =====
loc_02304E68:
	bx pc	; 02304E68
	.byte 0xC0, 0x46	; 02304E6C
.arm

; ===== function loc_02304E6C =====
loc_02304E6C:
	ldr r12,[pool_02304E74]	; 02304E6C
	bx r12	; 02304E70
pool_02304E74:
loc_02304E74:
	.word loc_037FB450 + 1	; 02304E74
.thumb

; ===== function loc_02304E78 =====
	push {r4,r5,lr}	; 02304E78
	sub sp,#0x4	; 02304E7A
	ldr r0,[pool_02304ED4]	; 02304E7C
	ldr r1,[r0,#0x0]	; 02304E7E
	ldr r0,[pool_02304ED8]	; 02304E80
	add r5,r1,r0	; 02304E82
	add r0,r5,#0x0	; 02304E84
	add r0,#0xb0	; 02304E86
	ldrh r0,[r0,#0x0]	; 02304E88
	cmp r0,#0x0	; 02304E8A
	beq loc_02304ECC	; 02304E8C
	ldr r0,[pool_02304EDC]	; 02304E8E
	add r0,r1,r0	; 02304E90
	mov r1,#0x12	; 02304E92
	bl loc_02304D60	; 02304E94
	add r4,r0,#0x0	; 02304E98
	cmp r4,#0x0	; 02304E9A
	beq loc_02304ECC	; 02304E9C
	ldr r0,[pool_02304EE0]	; 02304E9E
	strh r0,[r4,#0xc]	; 02304EA0
	mov r0,#0x1	; 02304EA2
	strh r0,[r4,#0xe]	; 02304EA4
	ldr r0,[pool_02304EE4]	; 02304EA6
	bl loc_02304EE8	; 02304EA8
	add r1,r5,#0x0	; 02304EAC
	add r1,#0xb0	; 02304EAE
	ldrh r1,[r1,#0x0]	; 02304EB0
	strh r1,[r4,#0x10]	; 02304EB2
	mov r1,#0x0	; 02304EB4
	add r5,#0xb0	; 02304EB6
	strh r1,[r5,#0x0]	; 02304EB8
	bl loc_02304EF8	; 02304EBA
	ldr r0,[pool_02304ED4]	; 02304EBE
	ldr r1,[r0,#0x0]	; 02304EC0
	ldr r0,[pool_02304EDC]	; 02304EC2
	add r0,r1,r0	; 02304EC4
	add r1,r4,#0x0	; 02304EC6
	bl loc_02304F08	; 02304EC8
loc_02304ECC:
	add sp,#0x4	; 02304ECC
	pop {r4,r5}	; 02304ECE
	pop {r3}	; 02304ED0
	bx r3	; 02304ED2
pool_02304ED4:
loc_02304ED4:
	.word FirmwareWlWorkPointerSlot	; 02304ED4
pool_02304ED8:
loc_02304ED8:
	.word 0x00000318	; 02304ED8
pool_02304EDC:
loc_02304EDC:
	.word 0x0000015C	; 02304EDC
pool_02304EE0:
loc_02304EE0:
	.word 0x00000186	; 02304EE0
pool_02304EE4:
loc_02304EE4:
	.word 0x01000000	; 02304EE4

; ===== function loc_02304EE8 =====
loc_02304EE8:
	bx pc	; 02304EE8
	.byte 0xC0, 0x46	; 02304EEC
.arm

; ===== function loc_02304EEC =====
loc_02304EEC:
	ldr r12,[pool_02304EF4]	; 02304EEC
	bx r12	; 02304EF0
pool_02304EF4:
loc_02304EF4:
	.word loc_037FDA64 + 1	; 02304EF4
.thumb

; ===== function loc_02304EF8 =====
loc_02304EF8:
	bx pc	; 02304EF8
	.byte 0xC0, 0x46	; 02304EFC
.arm

; ===== function loc_02304EFC =====
loc_02304EFC:
	ldr r12,[pool_02304F04]	; 02304EFC
	bx r12	; 02304F00
pool_02304F04:
loc_02304F04:
	.word loc_037FDA90 + 1	; 02304F04
.thumb

; ===== function loc_02304F08 =====
loc_02304F08:
	bx pc	; 02304F08
	.byte 0xC0, 0x46	; 02304F0C
.arm

; ===== function loc_02304F0C =====
loc_02304F0C:
	ldr r12,[pool_02304F14]	; 02304F0C
	bx r12	; 02304F10
pool_02304F14:
loc_02304F14:
	.word loc_037FB960 + 1	; 02304F14
.thumb

; ===== function loc_02304F18 =====
loc_02304F18:
	push {r4,lr}	; 02304F18
	add r4,r0,#0x0	; 02304F1A
	ldr r0,[pool_02304F44]	; 02304F1C
	bl loc_02304EE8	; 02304F1E
	ldr r1,[pool_02304F48]	; 02304F22
	ldr r2,[r1,#0x0]	; 02304F24
	ldr r1,[pool_02304F4C]	; 02304F26
	add r1,r2,r1	; 02304F28
	ldrh r2,[r1,#0x0]	; 02304F2A
	orr r2,r4	; 02304F2C
	strh r2,[r1,#0x0]	; 02304F2E
	bl loc_02304EF8	; 02304F30
	mov r0,#0x2	; 02304F34
	mov r1,#0x15	; 02304F36
	bl loc_02304BE8	; 02304F38
	pop {r4}	; 02304F3C
	pop {r3}	; 02304F3E
	bx r3	; 02304F40
	.byte 0xC0, 0x46	; 02304F44
pool_02304F44:
loc_02304F44:
	.word 0x01000000	; 02304F44
pool_02304F48:
loc_02304F48:
	.word FirmwareWlWorkPointerSlot	; 02304F48
pool_02304F4C:
loc_02304F4C:
	.word 0x000003C8	; 02304F4C
P4_Entry_02304F50:
	push {r4,r5,lr}	; 02304F50
	sub sp,#0x4	; 02304F52
	ldr r0,[pool_02305008]	; 02304F54
	ldr r1,[r0,#0x0]	; 02304F56
	ldr r0,[pool_0230500C]	; 02304F58
	add r5,r1,r0	; 02304F5A
	ldr r0,[pool_02305010]	; 02304F5C
	add r4,r1,r0	; 02304F5E
	ldr r0,[pool_02305014]	; 02304F60
	ldrh r0,[r1,r0]	; 02304F62
	cmp r0,#0x1	; 02304F64
	beq P4_Entry_02304F70	; 02304F66
	cmp r0,#0x2	; 02304F68
	beq P4_Entry_02304F9A	; 02304F6A
	cmp r0,#0x3	; 02304F6C
	b P4_Entry_02304FCE	; 02304F6E
P4_Entry_02304F70:
	add r0,r4,#0x0	; 02304F70
	add r0,#0x78	; 02304F72
	bl P4_Entry_02305078	; 02304F74
	cmp r0,#0x0	; 02304F78
	beq P4_Entry_02304F84	; 02304F7A
	bl P4_Entry_02305050	; 02304F7C
	bl P4_Entry_0230A0A8	; 02304F80
P4_Entry_02304F84:
	add r0,r4,#0x0	; 02304F84
	add r0,#0x28	; 02304F86
	bl P4_Entry_02305078	; 02304F88
	cmp r0,#0x0	; 02304F8C
	beq P4_Entry_02304FCE	; 02304F8E
	add r0,r4,#0x0	; 02304F90
	add r0,#0x28	; 02304F92
	bl P4_Entry_0230501C	; 02304F94
	b P4_Entry_02304FCE	; 02304F98
P4_Entry_02304F9A:
	add r0,r4,#0x0	; 02304F9A
	add r0,#0x64	; 02304F9C
	bl P4_Entry_02305078	; 02304F9E
	add r0,r4,#0x0	; 02304FA2
	add r0,#0x28	; 02304FA4
	bl P4_Entry_02305078	; 02304FA6
	cmp r0,#0x0	; 02304FAA
	beq P4_Entry_02304FCE	; 02304FAC
	ldrh r0,[r4,#0x28]	; 02304FAE
	cmp r0,#0x0	; 02304FB0
	beq P4_Entry_02304FB8	; 02304FB2
	bl P4_Entry_02305050	; 02304FB4
P4_Entry_02304FB8:
	add r0,r5,#0x0	; 02304FB8
	add r0,#0x6a	; 02304FBA
	ldrh r0,[r0,#0x0]	; 02304FBC
	bl loc_02309AD4	; 02304FBE
	add r0,r5,#0x0	; 02304FC2
	add r0,#0xb8	; 02304FC4
	ldrh r0,[r0,#0x0]	; 02304FC6
	add r0,r0,#0x1	; 02304FC8
	add r5,#0xb8	; 02304FCA
	strh r0,[r5,#0x0]	; 02304FCC
P4_Entry_02304FCE:
	add r0,r4,#0x0	; 02304FCE
	add r0,#0x14	; 02304FD0
	bl P4_Entry_02305078	; 02304FD2
	cmp r0,#0x0	; 02304FD6
	beq P4_Entry_02304FE2	; 02304FD8
	add r0,r4,#0x0	; 02304FDA
	add r0,#0x14	; 02304FDC
	bl P4_Entry_0230501C	; 02304FDE
P4_Entry_02304FE2:
	add r0,r4,#0x0	; 02304FE2
	bl P4_Entry_02305078	; 02304FE4
	cmp r0,#0x0	; 02304FE8
	beq P4_Entry_02304FF2	; 02304FEA
	add r0,r4,#0x0	; 02304FEC
	bl P4_Entry_0230501C	; 02304FEE
P4_Entry_02304FF2:
	ldr r1,[pool_02305018]	; 02304FF2
	ldrh r0,[r1,#0x0]	; 02304FF4
	cmp r0,#0x0	; 02304FF6
	bne P4_Entry_02304FFE	; 02304FF8
	mov r0,#0x1	; 02304FFA
	strh r0,[r1,#0x0]	; 02304FFC
P4_Entry_02304FFE:
	add sp,#0x4	; 02304FFE
	pop {r4,r5}	; 02305000
	pop {r3}	; 02305002
	bx r3	; 02305004
	.byte 0xC0, 0x46	; 02305006
pool_02305008:
	.word FirmwareWlWorkPointerSlot	; 02305008
pool_0230500C:
	.word 0x00000318	; 0230500C
pool_02305010:
	.word 0x00000400	; 02305010
pool_02305014:
	.word 0x00000324	; 02305014
pool_02305018:
	.word REG_WIFI_MODE_RST	; 02305018
P4_Entry_0230501C:
	push {r4,lr}	; 0230501C
	add r4,r0,#0x0	; 0230501E
	ldrh r0,[r4,#0x0]	; 02305020
	cmp r0,#0x0	; 02305022
	beq P4_Entry_02305042	; 02305024
	bl P4_Entry_02305050	; 02305026
	ldr r0,[r4,#0x8]	; 0230502A
	ldr r1,[r4,#0xc]	; 0230502C
	sub r1,#0x10	; 0230502E
	bl loc_0230AD88	; 02305030
	ldr r0,[pool_02305048]	; 02305034
	ldr r1,[r0,#0x0]	; 02305036
	ldr r0,[pool_0230504C]	; 02305038
	add r0,r1,r0	; 0230503A
	ldrh r1,[r0,#0x0]	; 0230503C
	add r1,r1,#0x1	; 0230503E
	strh r1,[r0,#0x0]	; 02305040
P4_Entry_02305042:
	pop {r4}	; 02305042
	pop {r3}	; 02305044
	bx r3	; 02305046
pool_02305048:
	.word FirmwareWlWorkPointerSlot	; 02305048
pool_0230504C:
	.word 0x000003D0	; 0230504C
P4_Entry_02305050:
	mov r1,#0x0	; 02305050
	ldr r0,[pool_02305070]	; 02305052
	strh r1,[r0,#0x0]	; 02305054
	mov r2,#0x10	; 02305056
	ldr r1,[pool_02305074]	; 02305058
	b P4_Entry_02305068	; 0230505A
P4_Entry_0230505C:
	ldrh r0,[r1,#0x0]	; 0230505C
	cmp r0,#0x0	; 0230505E
	beq P4_Entry_0230506C	; 02305060
	cmp r0,#0x9	; 02305062
	beq P4_Entry_0230506C	; 02305064
	sub r2,r2,#0x1	; 02305066
P4_Entry_02305068:
	cmp r2,#0x0	; 02305068
	bne P4_Entry_0230505C	; 0230506A
P4_Entry_0230506C:
	bx lr	; 0230506C
	.byte 0xC0, 0x46	; 0230506E
pool_02305070:
	.word REG_WIFI_MODE_RST	; 02305070
pool_02305074:
	.word 0x04808214	; 02305074
P4_Entry_02305078:
	push {r4,lr}	; 02305078
	ldr r4,[r0,#0x8]	; 0230507A
	sub r2,r4,#0x4	; 0230507C
	ldrh r3,[r2,#0x0]	; 0230507E
	ldr r1,[pool_023050C0]	; 02305080
	cmp r3,r1	; 02305082
	bne P4_Entry_0230508E	; 02305084
	ldrh r3,[r2,#0x2]	; 02305086
	ldr r1,[pool_023050C4]	; 02305088
	cmp r3,r1	; 0230508A
	beq P4_Entry_023050B6	; 0230508C
P4_Entry_0230508E:
	mov r1,#0x1	; 0230508E
	strh r1,[r4,#0xa]	; 02305090
	ldr r4,[pool_023050C0]	; 02305092
	strh r4,[r2,#0x0]	; 02305094
	ldr r3,[pool_023050C4]	; 02305096
	strh r3,[r2,#0x2]	; 02305098
	ldr r0,[r0,#0x8]	; 0230509A
	add r2,r0,#0x0	; 0230509C
	add r2,#0xc	; 0230509E
	strh r4,[r0,#0xc]	; 023050A0
	strh r3,[r2,#0x2]	; 023050A2
	ldr r0,[pool_023050C8]	; 023050A4
	ldr r2,[r0,#0x0]	; 023050A6
	ldr r0,[pool_023050CC]	; 023050A8
	add r0,r2,r0	; 023050AA
	ldrh r2,[r0,#0x0]	; 023050AC
	add r2,r2,#0x1	; 023050AE
	strh r2,[r0,#0x0]	; 023050B0
	add r0,r1,#0x0	; 023050B2
	b P4_Entry_023050B8	; 023050B4
P4_Entry_023050B6:
	mov r0,#0x0	; 023050B6
P4_Entry_023050B8:
	pop {r4}	; 023050B8
	pop {r3}	; 023050BA
	bx r3	; 023050BC
	.byte 0xC0, 0x46	; 023050BE
pool_023050C0:
	.word 0x0000B6B8	; 023050C0
pool_023050C4:
	.word 0x00001D46	; 023050C4
pool_023050C8:
	.word FirmwareWlWorkPointerSlot	; 023050C8
pool_023050CC:
	.word 0x000003CE	; 023050CC

; ===== function loc_023050D0 =====
loc_023050D0:
	push {r4,r5,lr}	; 023050D0
	sub sp,#0x4	; 023050D2
	mov r2,#0xf	; 023050D4
	add r3,r1,#0x0	; 023050D6
	and r3,r2	; 023050D8
	lsl r3,r3,#0x1	; 023050DA
	ldr r4,[pool_02305120]	; 023050DC
	ldrh r3,[r4,r3]	; 023050DE
	asr r1,r1,#0x4	; 023050E0
	ldr r5,[pool_02305124]	; 023050E2
	and r1,r5	; 023050E4
	lsl r1,r1,#0x10	; 023050E6
	lsr r1,r1,#0x10	; 023050E8
	eor r1,r3	; 023050EA
	add r3,r0,#0x0	; 023050EC
	and r3,r2	; 023050EE
	lsl r3,r3,#0x1	; 023050F0
	ldrh r3,[r4,r3]	; 023050F2
	eor r1,r3	; 023050F4
	lsl r1,r1,#0x10	; 023050F6
	lsr r3,r1,#0x10	; 023050F8
	asr r1,r3,#0x4	; 023050FA
	and r1,r5	; 023050FC
	lsl r1,r1,#0x10	; 023050FE
	lsr r1,r1,#0x10	; 02305100
	and r3,r2	; 02305102
	lsl r3,r3,#0x1	; 02305104
	ldrh r3,[r4,r3]	; 02305106
	eor r1,r3	; 02305108
	asr r0,r0,#0x4	; 0230510A
	and r0,r2	; 0230510C
	lsl r0,r0,#0x1	; 0230510E
	ldrh r0,[r4,r0]	; 02305110
	eor r1,r0	; 02305112
	lsl r0,r1,#0x10	; 02305114
	lsr r0,r0,#0x10	; 02305116
	add sp,#0x4	; 02305118
	pop {r4,r5}	; 0230511A
	pop {r3}	; 0230511C
	bx r3	; 0230511E
pool_02305120:
loc_02305120:
	.word P4_Data_0230D668	; 02305120
pool_02305124:
loc_02305124:
	.word 0x00000FFF	; 02305124

; ===== function loc_02305128 =====
loc_02305128:
	ldr r0,[pool_02305140]	; 02305128
	ldr r1,[r0,#0x0]	; 0230512A
	ldr r0,[pool_02305144]	; 0230512C
	add r3,r1,r0	; 0230512E
	ldrh r2,[r3,#0x2]	; 02305130
	ldrh r1,[r3,#0x4]	; 02305132
	ldrh r0,[r3,#0x0]	; 02305134
	mul r1,r0	; 02305136
	add r0,r2,r1	; 02305138
	strh r0,[r3,#0x4]	; 0230513A
	ldrh r0,[r3,#0x4]	; 0230513C
	bx lr	; 0230513E
pool_02305140:
loc_02305140:
	.word FirmwareWlWorkPointerSlot	; 02305140
pool_02305144:
loc_02305144:
	.word 0x000005C4	; 02305144

; ===== function loc_02305148 =====
loc_02305148:
	ldr r1,[pool_02305154]	; 02305148
	ldr r2,[r1,#0x0]	; 0230514A
	ldr r1,[pool_02305158]	; 0230514C
	strh r0,[r2,r1]	; 0230514E
	bx lr	; 02305150
	.byte 0xC0, 0x46	; 02305154
pool_02305154:
loc_02305154:
	.word FirmwareWlWorkPointerSlot	; 02305154
pool_02305158:
loc_02305158:
	.word 0x000005C8	; 02305158

; ===== function loc_0230515C =====
loc_0230515C:
	ldr r2,[pool_02305174]	; 0230515C
	ldr r3,[r2,#0x0]	; 0230515E
	ldr r2,[pool_02305178]	; 02305160
	add r3,r3,r2	; 02305162
	ldr r2,[pool_0230517C]	; 02305164
	and r0,r2	; 02305166
	add r0,r0,#0x5	; 02305168
	strh r0,[r3,#0x0]	; 0230516A
	mov r0,#0x1	; 0230516C
	orr r1,r0	; 0230516E
	strh r1,[r3,#0x2]	; 02305170
	bx lr	; 02305172
pool_02305174:
loc_02305174:
	.word FirmwareWlWorkPointerSlot	; 02305174
pool_02305178:
loc_02305178:
	.word 0x000005C4	; 02305178
pool_0230517C:
loc_0230517C:
	.word 0x0000FFF8	; 0230517C

; ===== function loc_02305180 =====
loc_02305180:
	mov r1,#0x1	; 02305180
	add r2,r0,#0x0	; 02305182
	and r2,r1	; 02305184
	cmp r2,#0x0	; 02305186
	beq loc_02305196	; 02305188
	sub r0,r0,#0x1	; 0230518A
	ldrh r0,[r0,#0x0]	; 0230518C
	asr r0,r0,#0x8	; 0230518E
	lsl r0,r0,#0x18	; 02305190
	lsr r0,r0,#0x18	; 02305192
	b loc_0230519C	; 02305194
loc_02305196:
	ldrh r0,[r0,#0x0]	; 02305196
	lsl r0,r0,#0x18	; 02305198
	lsr r0,r0,#0x18	; 0230519A
loc_0230519C:
	lsl r0,r0,#0x18	; 0230519C
	lsr r0,r0,#0x18	; 0230519E
	bx lr	; 023051A0
	.byte 0x00, 0x00	; 023051A4

; ===== function loc_023051A4 =====
loc_023051A4:
	mov r2,#0x1	; 023051A4
	add r3,r0,#0x0	; 023051A6
	and r3,r2	; 023051A8
	cmp r3,#0x0	; 023051AA
	beq loc_023051BE	; 023051AC
	sub r2,r0,#0x1	; 023051AE
	ldrh r3,[r2,#0x0]	; 023051B0
	mov r0,#0xff	; 023051B2
	and r3,r0	; 023051B4
	lsl r0,r1,#0x8	; 023051B6
	orr r3,r0	; 023051B8
	strh r3,[r2,#0x0]	; 023051BA
	bx lr	; 023051BC
loc_023051BE:
	ldrh r3,[r0,#0x0]	; 023051BE
	ldr r2,[pool_023051D0]	; 023051C0
	and r3,r2	; 023051C2
	mov r2,#0xff	; 023051C4
	and r1,r2	; 023051C6
	orr r3,r1	; 023051C8
	strh r3,[r0,#0x0]	; 023051CA
	bx lr	; 023051CC
	.byte 0xC0, 0x46	; 023051D0
pool_023051D0:
loc_023051D0:
	.word 0x0000FF00	; 023051D0

; ===== function loc_023051D4 =====
loc_023051D4:
	push {r4,r5,r6,lr}	; 023051D4
	add r5,r0,#0x0	; 023051D6
	add r6,r2,#0x0	; 023051D8
	add r4,r3,#0x0	; 023051DA
	mov r2,#0x12	; 023051DC
	bl loc_02305230	; 023051DE
	cmp r4,#0x0	; 023051E2
	beq loc_023051F4	; 023051E4
	add r5,#0x28	; 023051E6
	add r0,r5,#0x0	; 023051E8
	add r1,r6,#0x0	; 023051EA
	add r2,r4,#0x1	; 023051EC
	lsr r2,r2,#0x1	; 023051EE
	bl loc_02305230	; 023051F0
loc_023051F4:
	pop {r4,r5,r6}	; 023051F4
	pop {r3}	; 023051F6
	bx r3	; 023051F8
	.byte 0x00, 0x00	; 023051FC

; ===== function loc_023051FC =====
loc_023051FC:
	push {r4,r5,r6,lr}	; 023051FC
	add r5,r0,#0x0	; 023051FE
	add r6,r2,#0x0	; 02305200
	add r4,r3,#0x0	; 02305202
	mov r2,#0x12	; 02305204
	bl loc_02305230	; 02305206
	cmp r4,#0x0	; 0230520A
	beq loc_0230521C	; 0230520C
	add r5,#0x24	; 0230520E
	add r0,r5,#0x0	; 02305210
	add r1,r6,#0x0	; 02305212
	add r2,r4,#0x1	; 02305214
	lsr r2,r2,#0x1	; 02305216
	bl loc_02305230	; 02305218
loc_0230521C:
	pop {r4,r5,r6}	; 0230521C
	pop {r3}	; 0230521E
	bx r3	; 02305220
	.byte 0x00, 0x00	; 02305224

; ===== function loc_02305224 =====
loc_02305224:
	add r2,r2,#0x1	; 02305224
	lsr r2,r2,#0x1	; 02305226
	ldr r3,[pool_0230522C]	; 02305228
	bx r3	; 0230522A
pool_0230522C:
loc_0230522C:
	.word loc_02305230 + 1	; 0230522C

; ===== function loc_02305230 =====
loc_02305230:
	push {r4,r5,r6,r7,lr}	; 02305230
	sub sp,#0x4	; 02305232
	add r5,r0,#0x0	; 02305234
	add r4,r1,#0x0	; 02305236
	add r7,r2,#0x0	; 02305238
	ldr r0,[pool_02305294]	; 0230523A
	ldr r1,[r0,#0x0]	; 0230523C
	ldr r0,[pool_02305298]	; 0230523E
	ldr r1,[r1,r0]	; 02305240
	mov r0,#0xc	; 02305242
	mul r1,r0	; 02305244
	ldr r0,[pool_0230529C]	; 02305246
	add r6,r1,r0	; 02305248
	ldr r0,[pool_023052A0]	; 0230524A
	bl loc_02304EE8	; 0230524C
	str r0,[sp,#0x0]	; 02305250
	mov r2,#0x0	; 02305252
	b loc_02305280	; 02305254
loc_02305256:
	sub r3,r7,r2	; 02305256
	ldr r0,[pool_02305294]	; 02305258
	ldr r1,[r0,#0x0]	; 0230525A
	ldr r0,[pool_023052A4]	; 0230525C
	ldr r0,[r1,r0]	; 0230525E
	cmp r3,r0	; 02305260
	bls loc_02305266	; 02305262
	add r3,r0,#0x0	; 02305264
loc_02305266:
	ldr r0,[pool_023052A8]	; 02305266
	strh r5,[r0,#0x0]	; 02305268
	str r4,[r6,#0x0]	; 0230526A
	ldr r0,[pool_023052AC]	; 0230526C
	str r0,[r6,#0x4]	; 0230526E
	add r1,r3,#0x0	; 02305270
	ldr r0,[pool_023052B0]	; 02305272
	orr r1,r0	; 02305274
	str r1,[r6,#0x8]	; 02305276
	lsl r0,r3,#0x1	; 02305278
	add r4,r4,r0	; 0230527A
	add r5,r5,r0	; 0230527C
	add r2,r2,r3	; 0230527E
loc_02305280:
	cmp r2,r7	; 02305280
	bcc loc_02305256	; 02305282
	ldr r0,[sp,#0x0]	; 02305284
	bl loc_02304EF8	; 02305286
	add sp,#0x4	; 0230528A
	pop {r4,r5,r6,r7}	; 0230528C
	pop {r3}	; 0230528E
	bx r3	; 02305290
	.byte 0xC0, 0x46	; 02305294
pool_02305294:
loc_02305294:
	.word FirmwareWlWorkPointerSlot	; 02305294
pool_02305298:
loc_02305298:
	.word 0x000002E0	; 02305298
pool_0230529C:
loc_0230529C:
	.word 0x040000B0	; 0230529C
pool_023052A0:
loc_023052A0:
	.word 0x01000000	; 023052A0
pool_023052A4:
loc_023052A4:
	.word 0x000002E4	; 023052A4
pool_023052A8:
loc_023052A8:
	.word REG_WIFI_TXBUF_WR_ADDR	; 023052A8
pool_023052AC:
loc_023052AC:
	.word 0x04808070	; 023052AC
pool_023052B0:
loc_023052B0:
	.word 0x80400000	; 023052B0

; ===== function loc_023052B4 =====
loc_023052B4:
	push {r4,r5,r6,r7,lr}	; 023052B4
	sub sp,#0xc	; 023052B6
	add r7,r0,#0x0	; 023052B8
	add r5,r1,#0x0	; 023052BA
	add r0,r2,#0x1	; 023052BC
	lsr r0,r0,#0x1	; 023052BE
	str r0,[sp,#0x0]	; 023052C0
	ldr r0,[pool_02305330]	; 023052C2
	ldr r1,[r0,#0x0]	; 023052C4
	ldr r0,[pool_02305334]	; 023052C6
	ldr r1,[r1,r0]	; 023052C8
	mov r0,#0xc	; 023052CA
	mul r1,r0	; 023052CC
	ldr r0,[pool_02305338]	; 023052CE
	add r0,r1,r0	; 023052D0
	str r0,[sp,#0x4]	; 023052D2
	mov r6,#0x0	; 023052D4
	b loc_02305322	; 023052D6
loc_023052D8:
	ldr r0,[sp,#0x0]	; 023052D8
	sub r4,r0,r6	; 023052DA
	ldr r0,[pool_02305330]	; 023052DC
	ldr r1,[r0,#0x0]	; 023052DE
	ldr r0,[pool_0230533C]	; 023052E0
	ldr r0,[r1,r0]	; 023052E2
	cmp r4,r0	; 023052E4
	bls loc_023052EA	; 023052E6
	add r4,r0,#0x0	; 023052E8
loc_023052EA:
	ldr r0,[pool_02305340]	; 023052EA
	bl loc_02304EE8	; 023052EC
	ldr r1,[pool_02305344]	; 023052F0
	strh r5,[r1,#0x0]	; 023052F2
	ldr r2,[pool_02305348]	; 023052F4
	ldr r1,[sp,#0x4]	; 023052F6
	str r2,[r1,#0x0]	; 023052F8
	str r7,[r1,#0x4]	; 023052FA
	add r1,r4,#0x0	; 023052FC
	ldr r2,[pool_0230534C]	; 023052FE
	orr r1,r2	; 02305300
	ldr r2,[sp,#0x4]	; 02305302
	str r1,[r2,#0x8]	; 02305304
	bl loc_02304EF8	; 02305306
	lsl r0,r4,#0x1	; 0230530A
	add r7,r7,r0	; 0230530C
	add r5,r5,r0	; 0230530E
	ldr r0,[pool_02305350]	; 02305310
	cmp r5,r0	; 02305312
	bcc loc_02305320	; 02305314
	ldr r0,[pool_02305330]	; 02305316
	ldr r1,[r0,#0x0]	; 02305318
	ldr r0,[pool_02305354]	; 0230531A
	ldrh r0,[r1,r0]	; 0230531C
	sub r5,r5,r0	; 0230531E
loc_02305320:
	add r6,r6,r4	; 02305320
loc_02305322:
	ldr r0,[sp,#0x0]	; 02305322
	cmp r6,r0	; 02305324
	bcc loc_023052D8	; 02305326
	add sp,#0xc	; 02305328
	pop {r4,r5,r6,r7}	; 0230532A
	pop {r3}	; 0230532C
	bx r3	; 0230532E
pool_02305330:
loc_02305330:
	.word FirmwareWlWorkPointerSlot	; 02305330
pool_02305334:
loc_02305334:
	.word 0x000002E0	; 02305334
pool_02305338:
loc_02305338:
	.word 0x040000B0	; 02305338
pool_0230533C:
loc_0230533C:
	.word 0x000002E4	; 0230533C
pool_02305340:
loc_02305340:
	.word 0x01000000	; 02305340
pool_02305344:
loc_02305344:
	.word REG_WIFI_RXBUF_RD_ADDR	; 02305344
pool_02305348:
loc_02305348:
	.word 0x04808060	; 02305348
pool_0230534C:
loc_0230534C:
	.word 0x81000000	; 0230534C
pool_02305350:
loc_02305350:
	.word 0x04805F60	; 02305350
pool_02305354:
loc_02305354:
	.word 0x000003B2	; 02305354

; ===== function loc_02305358 =====
loc_02305358:
	ldr r0,[pool_02305364]	; 02305358
	ldr r1,[r0,#0x0]	; 0230535A
	ldr r0,[pool_02305368]	; 0230535C
	add r0,r1,r0	; 0230535E
	ldr r3,[pool_0230536C]	; 02305360
	bx r3	; 02305362
pool_02305364:
loc_02305364:
	.word FirmwareWlWorkPointerSlot	; 02305364
pool_02305368:
loc_02305368:
	.word 0x00000608	; 02305368
pool_0230536C:
loc_0230536C:
	.word loc_037FEA5C + 1	; 0230536C
P4_Entry_02305370:
	push {r4,r5,lr}	; 02305370
	sub sp,#0x4	; 02305372
	add r5,r0,#0x0	; 02305374
	add r4,r1,#0x0	; 02305376
	ldr r0,[pool_023053AC]	; 02305378
	ldr r1,[r0,#0x0]	; 0230537A
	ldr r0,[pool_023053B0]	; 0230537C
	add r0,r1,r0	; 0230537E
	bl loc_02300FF8	; 02305380
	ldr r0,[pool_023053B4]	; 02305384
	mul r5,r0	; 02305386
	lsr r0,r5,#0x6	; 02305388
	ldr r1,[pool_023053B8]	; 0230538A
	bl P4_Entry_023053BC	; 0230538C
	add r1,r0,#0x0	; 02305390
	mov r2,#0x0	; 02305392
	str r2,[sp,#0x0]	; 02305394
	ldr r0,[pool_023053AC]	; 02305396
	ldr r3,[r0,#0x0]	; 02305398
	ldr r0,[pool_023053B0]	; 0230539A
	add r0,r3,r0	; 0230539C
	add r3,r4,#0x0	; 0230539E
	bl loc_023012D4	; 023053A0
	add sp,#0x4	; 023053A4
	pop {r4,r5}	; 023053A6
	pop {r3}	; 023053A8
	bx r3	; 023053AA
pool_023053AC:
	.word FirmwareWlWorkPointerSlot	; 023053AC
pool_023053B0:
	.word 0x00000608	; 023053B0
pool_023053B4:
	.word 0x000082EA	; 023053B4
pool_023053B8:
	.word 0x000003E8	; 023053B8
P4_Entry_023053BC:
	bx pc	; 023053BC
	.byte 0xC0, 0x46	; 023053BE
.arm
	ldr pc,[pool_023053C4]	; 023053C0
pool_023053C4:
	.word loc_03804DB0	; 023053C4
.thumb

; ===== function loc_023053C8 =====
loc_023053C8:
	push {r4,r5,lr}	; 023053C8
	sub sp,#0x4	; 023053CA
	add r5,r0,#0x0	; 023053CC
	add r4,r1,#0x0	; 023053CE
	ldr r0,[pool_023053FC]	; 023053D0
	ldr r1,[r0,#0x0]	; 023053D2
	ldr r0,[pool_02305400]	; 023053D4
	add r0,r1,r0	; 023053D6
	bl loc_02300FF8	; 023053D8
	mov r2,#0x0	; 023053DC
	str r2,[sp,#0x0]	; 023053DE
	ldr r0,[pool_023053FC]	; 023053E0
	ldr r1,[r0,#0x0]	; 023053E2
	ldr r0,[pool_02305400]	; 023053E4
	add r0,r1,r0	; 023053E6
	ldr r1,[pool_02305404]	; 023053E8
	mul r5,r1	; 023053EA
	lsr r1,r5,#0x6	; 023053EC
	add r3,r4,#0x0	; 023053EE
	bl loc_023012D4	; 023053F0
	add sp,#0x4	; 023053F4
	pop {r4,r5}	; 023053F6
	pop {r3}	; 023053F8
	bx r3	; 023053FA
pool_023053FC:
loc_023053FC:
	.word FirmwareWlWorkPointerSlot	; 023053FC
pool_02305400:
loc_02305400:
	.word 0x00000608	; 02305400
pool_02305404:
loc_02305404:
	.word 0x000082EA	; 02305404
	.byte 0x10, 0xB5, 0x13, 0x48, 0x04, 0x68, 0x13, 0x48, 0x20, 0x18, 0x01, 0x68, 0x49, 0x1C, 0x01, 0x60	; 02305408
	.byte 0x01, 0x20, 0x0A, 0x21, 0xFF, 0xF7, 0xE4, 0xFB, 0x02, 0x20, 0x12, 0x21, 0xFF, 0xF7, 0xE0, 0xFB	; 02305418
	.byte 0x01, 0x20, 0x11, 0x21, 0xFF, 0xF7, 0xDC, 0xFB, 0x0B, 0x48, 0x20, 0x5A, 0x00, 0x28, 0x03, 0xD0	; 02305428
	.byte 0x02, 0x20, 0x13, 0x21, 0xFF, 0xF7, 0xD4, 0xFB, 0x08, 0x48, 0x20, 0x5A, 0x00, 0x28, 0x03, 0xD0	; 02305438
	.byte 0x02, 0x20, 0x15, 0x21, 0xFF, 0xF7, 0xCC, 0xFB, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02305448
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xC0, 0x03, 0x00, 0x00, 0xD0, 0x01, 0x00, 0x00, 0xC8, 0x03, 0x00, 0x00	; 02305458
P4_Entry_02305468:
	ldr r0,[pool_02305474]	; 02305468
	ldr r1,[r0,#0x0]	; 0230546A
	ldr r0,[pool_02305478]	; 0230546C
	add r0,r1,r0	; 0230546E
	ldr r3,[pool_0230547C]	; 02305470
	bx r3	; 02305472
pool_02305474:
	.word FirmwareWlWorkPointerSlot	; 02305474
pool_02305478:
	.word 0x000005DC	; 02305478
pool_0230547C:
	.word loc_037FEA5C + 1	; 0230547C
P4_Entry_02305480:
	push {r4,r5,r6,r7,lr}	; 02305480
	sub sp,#0xc	; 02305482
	add r5,r0,#0x0	; 02305484
	add r4,r1,#0x0	; 02305486
	ldr r0,[pool_023054C4]	; 02305488
	ldr r1,[r0,#0x0]	; 0230548A
	ldr r0,[pool_023054C8]	; 0230548C
	add r0,r1,r0	; 0230548E
	bl loc_02300FF8	; 02305490
	ldr r0,[pool_023054CC]	; 02305494
	mul r5,r0	; 02305496
	lsr r5,r5,#0x6	; 02305498
	bl P4_Entry_023054D0	; 0230549A
	mov r7,#0x0	; 0230549E
	add r6,r5,r0	; 023054A0
	lsl r2,r7,#0	; 023054A2
	adc r2,r1	; 023054A4
	str r4,[sp,#0x4]	; 023054A6
	str r7,[sp,#0x8]	; 023054A8
	add r3,r5,#0x0	; 023054AA
	str r7,[sp,#0x0]	; 023054AC
	ldr r0,[pool_023054C4]	; 023054AE
	ldr r1,[r0,#0x0]	; 023054B0
	ldr r0,[pool_023054C8]	; 023054B2
	add r0,r1,r0	; 023054B4
	add r1,r6,#0x0	; 023054B6
	bl P4_Entry_023054E0	; 023054B8
	add sp,#0xc	; 023054BC
	pop {r4,r5,r6,r7}	; 023054BE
	pop {r3}	; 023054C0
	bx r3	; 023054C2
pool_023054C4:
	.word FirmwareWlWorkPointerSlot	; 023054C4
pool_023054C8:
	.word 0x000005DC	; 023054C8
pool_023054CC:
	.word 0x000082EA	; 023054CC
P4_Entry_023054D0:
	bx pc	; 023054D0
	.byte 0xC0, 0x46	; 023054D2
.arm
	ldr r12,[pool_023054DC]	; 023054D4
	bx r12	; 023054D8
pool_023054DC:
	.word loc_037FE868 + 1	; 023054DC
P4_Entry_023054E0:
.thumb
	bx pc	; 023054E0
	.byte 0xC0, 0x46	; 023054E2
.arm
	ldr r12,[pool_023054EC]	; 023054E4
	bx r12	; 023054E8
pool_023054EC:
	.word loc_037FEAB8 + 1	; 023054EC
.thumb
loc_023054F0:
	ldr r1,[pool_023054F8]	; 023054F0
	ldr r3,[pool_023054FC]	; 023054F2
	bx r3	; 023054F4
	.byte 0xC0, 0x46	; 023054F8
pool_023054F8:
loc_023054F8:
	.word 0x02305511	; 023054F8
pool_023054FC:
loc_023054FC:
	.word loc_023077AC + 1	; 023054FC

; ===== function loc_02305500 =====
loc_02305500:
	ldr r1,[pool_02305508]	; 02305500
	mul r0,r1	; 02305502
	ldr r3,[pool_0230550C]	; 02305504
	bx r3	; 02305506
pool_02305508:
loc_02305508:
	.word 0x000003E8	; 02305508
pool_0230550C:
loc_0230550C:
	.word loc_023054F0 + 1	; 0230550C
	mov r1,#0x0	; 02305510
	str r1,[r0,#0x0]	; 02305512
	bx lr	; 02305514
	.byte 0x00, 0x00	; 02305518

; ===== function loc_02305518 =====
loc_02305518:
	push {r4,lr}	; 02305518
	ldr r0,[pool_0230554C]	; 0230551A
	ldr r4,[r0,#0x0]	; 0230551C
	bl loc_0230555C	; 0230551E
	cmp r0,#0x0	; 02305522
	beq loc_02305538	; 02305524
	ldr r0,[pool_02305550]	; 02305526
	add r0,r4,r0	; 02305528
	bl loc_02304628	; 0230552A
	ldr r0,[pool_02305554]	; 0230552E
	add r0,r4,r0	; 02305530
	bl loc_02304628	; 02305532
	b loc_02305544	; 02305536
loc_02305538:
	ldr r0,[pool_02305558]	; 02305538
	add r1,r4,r0	; 0230553A
	ldrh r2,[r1,#0x0]	; 0230553C
	mov r0,#0x40	; 0230553E
	orr r2,r0	; 02305540
	strh r2,[r1,#0x0]	; 02305542
loc_02305544:
	pop {r4}	; 02305544
	pop {r3}	; 02305546
	bx r3	; 02305548
	.byte 0xC0, 0x46	; 0230554C
pool_0230554C:
loc_0230554C:
	.word FirmwareWlWorkPointerSlot	; 0230554C
pool_02305550:
loc_02305550:
	.word 0x000005DC	; 02305550
pool_02305554:
loc_02305554:
	.word 0x00000608	; 02305554
pool_02305558:
loc_02305558:
	.word 0x00000312	; 02305558

; ===== function loc_0230555C =====
loc_0230555C:
	bx pc	; 0230555C
	.byte 0xC0, 0x46	; 02305560
.arm

; ===== function loc_02305560 =====
loc_02305560:
	ldr r12,[pool_02305568]	; 02305560
	bx r12	; 02305564
pool_02305568:
loc_02305568:
	.word loc_037FEC3C + 1	; 02305568
.thumb

; ===== function loc_0230556C =====
loc_0230556C:
	push {r4,r5,r6,r7,lr}	; 0230556C
	sub sp,#0xc	; 0230556E
	ldr r0,[pool_0230563C]	; 02305570
	ldr r1,[r0,#0x0]	; 02305572
	ldr r0,[pool_02305640]	; 02305574
	add r4,r1,r0	; 02305576
	mov r5,#0x0	; 02305578
	str r5,[sp,#0x4]	; 0230557A
	ldr r7,[pool_02305644]	; 0230557C
loc_0230557E:
	lsl r6,r5,#0x1	; 0230557E
	add r0,r6,#0x0	; 02305580
	add r0,#0x44	; 02305582
	mov r1,#0x2	; 02305584
	add r2,sp,#0x4	; 02305586
	bl loc_0230D400	; 02305588
	ldr r2,[sp,#0x4]	; 0230558C
	ldrh r1,[r7,r6]	; 0230558E
	ldr r0,[pool_02305648]	; 02305590
	strh r2,[r1,r0]	; 02305592
	add r5,r5,#0x1	; 02305594
	cmp r5,#0x10	; 02305596
	bcc loc_0230557E	; 02305598
	ldrh r0,[r4,#0x2]	; 0230559A
	lsr r0,r0,#0x7	; 0230559C
	lsl r2,r0,#0x8	; 0230559E
	str r2,[sp,#0x0]	; 023055A0
	ldrh r1,[r4,#0x2]	; 023055A2
	mov r0,#0x7f	; 023055A4
	and r1,r0	; 023055A6
	orr r2,r1	; 023055A8
	str r2,[sp,#0x0]	; 023055AA
	ldr r1,[pool_0230564C]	; 023055AC
	strh r2,[r1,#0x0]	; 023055AE
	mov r5,#0xce	; 023055B0
	ldrh r1,[r4,#0x2]	; 023055B2
	and r1,r0	; 023055B4
	add r0,r1,#0x7	; 023055B6
	mov r1,#0x8	; 023055B8
	bl loc_02305658	; 023055BA
	add r7,r0,#0x0	; 023055BE
	ldrh r6,[r4,#0x4]	; 023055C0
	ldrh r0,[r4,#0x0]	; 023055C2
	cmp r0,#0x3	; 023055C4
	bne loc_02305602	; 023055C6
	add r0,r6,#0x0	; 023055C8
	add r0,#0xce	; 023055CA
	mov r1,#0x1	; 023055CC
	add r4,#0x8	; 023055CE
	add r2,r4,#0x0	; 023055D0
	bl loc_0230D400	; 023055D2
	mov r4,#0x0	; 023055D6
	add r7,r4,#0x0	; 023055D8
	b loc_023055FC	; 023055DA
loc_023055DC:
	str r7,[sp,#0x0]	; 023055DC
	add r0,r5,#0x0	; 023055DE
	mov r1,#0x1	; 023055E0
	add r2,sp,#0x0	; 023055E2
	bl loc_0230D400	; 023055E4
	ldr r0,[sp,#0x0]	; 023055E8
	lsl r2,r4,#0x8	; 023055EA
	ldr r1,[pool_02305650]	; 023055EC
	add r1,r2,r1	; 023055EE
	orr r0,r1	; 023055F0
	str r0,[sp,#0x0]	; 023055F2
	bl loc_0230576C	; 023055F4
	add r4,r4,#0x1	; 023055F8
	add r5,r5,#0x1	; 023055FA
loc_023055FC:
	cmp r4,r6	; 023055FC
	bcc loc_023055DC	; 023055FE
	b loc_02305634	; 02305600
loc_02305602:
	mov r0,#0x0	; 02305602
	str r0,[sp,#0x0]	; 02305604
	b loc_02305630	; 02305606
loc_02305608:
	add r0,r5,#0x0	; 02305608
	add r1,r7,#0x0	; 0230560A
	add r2,sp,#0x0	; 0230560C
	bl loc_0230D400	; 0230560E
	ldr r0,[sp,#0x0]	; 02305612
	bl loc_0230576C	; 02305614
	ldrh r0,[r4,#0x0]	; 02305618
	cmp r0,#0x2	; 0230561A
	bne loc_0230562C	; 0230561C
	ldr r1,[sp,#0x0]	; 0230561E
	lsr r0,r1,#0x12	; 02305620
	cmp r0,#0x9	; 02305622
	bne loc_0230562C	; 02305624
	ldr r0,[pool_02305654]	; 02305626
	and r1,r0	; 02305628
	str r1,[r4,#0xc]	; 0230562A
loc_0230562C:
	sub r6,r6,#0x1	; 0230562C
	add r5,r5,r7	; 0230562E
loc_02305630:
	cmp r6,#0x0	; 02305630
	bne loc_02305608	; 02305632
loc_02305634:
	add sp,#0xc	; 02305634
	pop {r4,r5,r6,r7}	; 02305636
	pop {r3}	; 02305638
	bx r3	; 0230563A
pool_0230563C:
loc_0230563C:
	.word FirmwareWlWorkPointerSlot	; 0230563C
pool_02305640:
loc_02305640:
	.word 0x000005CC	; 02305640
pool_02305644:
loc_02305644:
	.word 0x0230D688	; 02305644
pool_02305648:
loc_02305648:
	.word 0x04808000	; 02305648
pool_0230564C:
loc_0230564C:
	.word REG_WIFI_RF_CNT	; 0230564C
pool_02305650:
loc_02305650:
	.word 0x00050000	; 02305650
pool_02305654:
loc_02305654:
	.word 0xFFFF83FF	; 02305654

; ===== function loc_02305658 =====
loc_02305658:
	bx pc	; 02305658
	.byte 0xC0, 0x46	; 0230565C
.arm

; ===== function loc_0230565C =====
loc_0230565C:
	ldr pc,[pool_02305660]	; 0230565C
pool_02305660:
loc_02305660:
	.word P2_SignedDivMod	; 02305660
.thumb

; ===== function loc_02305664 =====
loc_02305664:
	push {r4,r5,r6,r7,lr}	; 02305664
	sub sp,#0x4	; 02305666
	ldr r1,[pool_0230569C]	; 02305668
	ldr r0,[pool_023056A0]	; 0230566A
	strh r1,[r0,#0x0]	; 0230566C
	mov r4,#0x64	; 0230566E
	mov r5,#0x0	; 02305670
	str r5,[sp,#0x0]	; 02305672
	mov r6,#0x1	; 02305674
	add r7,sp,#0x0	; 02305676
loc_02305678:
	add r0,r4,#0x0	; 02305678
	add r1,r6,#0x0	; 0230567A
	add r2,r7,#0x0	; 0230567C
	bl loc_0230D400	; 0230567E
	add r0,r5,#0x0	; 02305682
	ldr r1,[sp,#0x0]	; 02305684
	bl loc_02305788	; 02305686
	add r4,r4,#0x1	; 0230568A
	add r5,r5,#0x1	; 0230568C
	cmp r5,#0x69	; 0230568E
	bcc loc_02305678	; 02305690
	add sp,#0x4	; 02305692
	pop {r4,r5,r6,r7}	; 02305694
	pop {r3}	; 02305696
	bx r3	; 02305698
	.byte 0xC0, 0x46	; 0230569C
pool_0230569C:
loc_0230569C:
	.word 0x00000100	; 0230569C
pool_023056A0:
loc_023056A0:
	.word REG_WIFI_BB_MODE	; 023056A0

; ===== function loc_023056A4 =====
loc_023056A4:
	push {r4,lr}	; 023056A4
	mov r4,#0x0	; 023056A6
	ldr r3,[pool_023056C4]	; 023056A8
	ldr r0,[pool_023056C8]	; 023056AA
loc_023056AC:
	lsl r1,r4,#0x2	; 023056AC
	add r2,r3,r1	; 023056AE
	ldrh r2,[r2,#0x2]	; 023056B0
	ldrh r1,[r3,r1]	; 023056B2
	strh r2,[r1,r0]	; 023056B4
	add r4,r4,#0x1	; 023056B6
	cmp r4,#0x19	; 023056B8
	bcc loc_023056AC	; 023056BA
	pop {r4}	; 023056BC
	pop {r3}	; 023056BE
	bx r3	; 023056C0
	.byte 0xC0, 0x46	; 023056C4
pool_023056C4:
loc_023056C4:
	.word P4_Data_0230D6F8	; 023056C4
pool_023056C8:
loc_023056C8:
	.word 0x04808000	; 023056C8

; ===== function loc_023056CC =====
loc_023056CC:
	push {r4,lr}	; 023056CC
	sub sp,#0x8	; 023056CE
	ldr r0,[pool_02305718]	; 023056D0
	ldr r1,[r0,#0x0]	; 023056D2
	ldr r0,[pool_0230571C]	; 023056D4
	add r4,r1,r0	; 023056D6
	mov r1,#0x0	; 023056D8
	add r0,sp,#0x0	; 023056DA
	strh r1,[r0,#0x0]	; 023056DC
	ldrh r0,[r0,#0x0]	; 023056DE
	add r1,r4,#0x0	; 023056E0
	mov r2,#0x10	; 023056E2
	bl loc_02305720	; 023056E4
	mov r0,#0x40	; 023056E8
	mov r1,#0x1	; 023056EA
	add r2,r4,#0x0	; 023056EC
	bl loc_0230D400	; 023056EE
	mov r0,#0x41	; 023056F2
	mov r1,#0x1	; 023056F4
	add r2,r4,#0x2	; 023056F6
	bl loc_0230D400	; 023056F8
	mov r0,#0x42	; 023056FC
	mov r1,#0x1	; 023056FE
	add r2,r4,#0x4	; 02305700
	bl loc_0230D400	; 02305702
	mov r0,#0x43	; 02305706
	mov r1,#0x1	; 02305708
	add r2,r4,#0x6	; 0230570A
	bl loc_0230D400	; 0230570C
	add sp,#0x8	; 02305710
	pop {r4}	; 02305712
	pop {r3}	; 02305714
	bx r3	; 02305716
pool_02305718:
loc_02305718:
	.word FirmwareWlWorkPointerSlot	; 02305718
pool_0230571C:
loc_0230571C:
	.word 0x000005CC	; 0230571C

; ===== function loc_02305720 =====
loc_02305720:
	bx pc	; 02305720
	.byte 0xC0, 0x46	; 02305724
.arm

; ===== function loc_02305724 =====
loc_02305724:
	ldr pc,[pool_02305728]	; 02305724
pool_02305728:
loc_02305728:
	.word loc_037FF31C	; 02305728
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x64, 0x25, 0x00, 0x26, 0x00, 0x96, 0x34, 0x1C, 0x80, 0x27, 0x28, 0x1C	; 0230573C
	.byte 0x01, 0x21, 0x00, 0xAA, 0x07, 0xF0, 0x5E, 0xFE, 0x01, 0x2C, 0x02, 0xD1, 0x00, 0x98, 0x38, 0x40	; 0230574C
	.byte 0x00, 0x90, 0x00, 0x98, 0x00, 0x06, 0x00, 0x0E, 0x31, 0x1C, 0xFF, 0xF7, 0xBB, 0xFC, 0x06, 0x1C	; 0230575C
	.byte 0x6D, 0x1C, 0x64, 0x1C, 0x69, 0x2C, 0xEA, 0xD3, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230576C
.thumb

; ===== function loc_0230576C =====
loc_0230576C:
	ldr r1,[pool_0230577C]	; 0230576C
	strh r0,[r1,#0x0]	; 0230576E
	lsr r1,r0,#0x10	; 02305770
	ldr r0,[pool_02305780]	; 02305772
	strh r1,[r0,#0x0]	; 02305774
	ldr r3,[pool_02305784]	; 02305776
	bx r3	; 02305778
	.byte 0xC0, 0x46	; 0230577C
pool_0230577C:
loc_0230577C:
	.word REG_WIFI_RF_DATA1	; 0230577C
pool_02305780:
loc_02305780:
	.word REG_WIFI_RF_DATA2	; 02305780
pool_02305784:
loc_02305784:
	.word loc_02307728 + 1	; 02305784

; ===== function loc_02305788 =====
loc_02305788:
	push {lr}	; 02305788
	sub sp,#0x4	; 0230578A
	ldr r2,[pool_023057B0]	; 0230578C
	strh r1,[r2,#0x0]	; 0230578E
	ldr r1,[pool_023057B4]	; 02305790
	orr r0,r1	; 02305792
	ldr r1,[pool_023057B8]	; 02305794
	strh r0,[r1,#0x0]	; 02305796
	bl loc_02307758	; 02305798
	cmp r0,#0x0	; 0230579C
	beq loc_023057A6	; 0230579E
	mov r0,#0x0	; 023057A0
	mvn r0,r0	; 023057A2
	b loc_023057A8	; 023057A4
loc_023057A6:
	mov r0,#0x0	; 023057A6
loc_023057A8:
	add sp,#0x4	; 023057A8
	pop {r3}	; 023057AA
	bx r3	; 023057AC
	.byte 0xC0, 0x46	; 023057B0
pool_023057B0:
loc_023057B0:
	.word REG_WIFI_BB_WRITE	; 023057B0
pool_023057B4:
loc_023057B4:
	.word 0x00005000	; 023057B4
pool_023057B8:
loc_023057B8:
	.word REG_WIFI_BB_CNT	; 023057B8

; ===== function loc_023057BC =====
loc_023057BC:
	push {lr}	; 023057BC
	sub sp,#0x4	; 023057BE
	ldr r1,[pool_023057D8]	; 023057C0
	orr r0,r1	; 023057C2
	ldr r1,[pool_023057DC]	; 023057C4
	strh r0,[r1,#0x0]	; 023057C6
	bl loc_02307758	; 023057C8
	ldr r0,[pool_023057E0]	; 023057CC
	ldrh r0,[r0,#0x0]	; 023057CE
	add sp,#0x4	; 023057D0
	pop {r3}	; 023057D2
	bx r3	; 023057D4
	.byte 0xC0, 0x46	; 023057D8
pool_023057D8:
loc_023057D8:
	.word 0x00006000	; 023057D8
pool_023057DC:
loc_023057DC:
	.word REG_WIFI_BB_CNT	; 023057DC
pool_023057E0:
loc_023057E0:
	.word REG_WIFI_BB_READ	; 023057E0

; ===== function loc_023057E4 =====
loc_023057E4:
	ldr r0,[pool_02305810]	; 023057E4
	ldr r1,[r0,#0x0]	; 023057E6
	ldr r0,[pool_02305814]	; 023057E8
	ldrh r0,[r1,r0]	; 023057EA
	cmp r0,#0x0	; 023057EC
	beq loc_023057F6	; 023057EE
	cmp r0,#0x1	; 023057F0
	beq loc_02305806	; 023057F2
	b loc_0230580A	; 023057F4
loc_023057F6:
	ldr r0,[pool_02305818]	; 023057F6
	ldrh r1,[r1,r0]	; 023057F8
	mov r0,#0x1	; 023057FA
	and r1,r0	; 023057FC
	cmp r1,#0x0	; 023057FE
	beq loc_0230580A	; 02305800
	mov r0,#0xa	; 02305802
	bx lr	; 02305804
loc_02305806:
	mov r0,#0xa	; 02305806
	bx lr	; 02305808
loc_0230580A:
	mov r0,#0x14	; 0230580A
	bx lr	; 0230580C
	.byte 0xC0, 0x46	; 02305810
pool_02305810:
loc_02305810:
	.word FirmwareWlWorkPointerSlot	; 02305810
pool_02305814:
loc_02305814:
	.word 0x00000304	; 02305814
pool_02305818:
loc_02305818:
	.word 0x00000378	; 02305818

; ===== function loc_0230581C =====
loc_0230581C:
	push {r4,r5,r6,r7,lr}	; 0230581C
	sub sp,#0x4	; 0230581E
	add r6,r0,#0x0	; 02305820
	add r5,r1,#0x0	; 02305822
	mov r0,#0x0	; 02305824
	strh r0,[r5,#0x0]	; 02305826
	strh r0,[r5,#0x2]	; 02305828
	add r0,r6,#0x1	; 0230582A
	bl loc_02305180	; 0230582C
	add r7,r0,#0x0	; 02305830
	mov r4,#0x0	; 02305832
	b loc_02305888	; 02305834
loc_02305836:
	add r0,r6,#0x2	; 02305836
	add r0,r0,r4	; 02305838
	bl loc_02305180	; 0230583A
	add r2,r0,#0x0	; 0230583E
	mov r1,#0x7f	; 02305840
	and r2,r1	; 02305842
	sub r1,r2,#0x1	; 02305844
	cmp r1,#0x78	; 02305846
	bcs loc_0230586E	; 02305848
	lsl r2,r1,#0x1	; 0230584A
	ldr r1,[pool_02305894]	; 0230584C
	ldrh r2,[r1,r2]	; 0230584E
	cmp r2,#0xff	; 02305850
	beq loc_0230586E	; 02305852
	mov r1,#0x1	; 02305854
	lsl r1,r2	; 02305856
	ldrh r2,[r5,#0x2]	; 02305858
	orr r2,r1	; 0230585A
	strh r2,[r5,#0x2]	; 0230585C
	mov r2,#0x80	; 0230585E
	and r0,r2	; 02305860
	cmp r0,#0x0	; 02305862
	beq loc_02305886	; 02305864
	ldrh r0,[r5,#0x0]	; 02305866
	orr r0,r1	; 02305868
	strh r0,[r5,#0x0]	; 0230586A
	b loc_02305886	; 0230586C
loc_0230586E:
	ldrh r2,[r5,#0x2]	; 0230586E
	ldr r1,[pool_02305898]	; 02305870
	orr r2,r1	; 02305872
	strh r2,[r5,#0x2]	; 02305874
	mov r1,#0x80	; 02305876
	and r0,r1	; 02305878
	cmp r0,#0x0	; 0230587A
	beq loc_02305886	; 0230587C
	ldrh r1,[r5,#0x0]	; 0230587E
	ldr r0,[pool_02305898]	; 02305880
	orr r1,r0	; 02305882
	strh r1,[r5,#0x0]	; 02305884
loc_02305886:
	add r4,r4,#0x1	; 02305886
loc_02305888:
	cmp r4,r7	; 02305888
	bcc loc_02305836	; 0230588A
	add sp,#0x4	; 0230588C
	pop {r4,r5,r6,r7}	; 0230588E
	pop {r3}	; 02305890
	bx r3	; 02305892
pool_02305894:
loc_02305894:
	.word P4_Data_0230D75C	; 02305894
pool_02305898:
loc_02305898:
	.word 0x00008000	; 02305898

; ===== function loc_0230589C =====
loc_0230589C:
	mov r2,#0x1	; 0230589C
	lsl r2,r0	; 0230589E
	ldr r0,[pool_023058B0]	; 023058A0
	ldr r1,[r0,#0x0]	; 023058A2
	ldr r0,[pool_023058B4]	; 023058A4
	ldrh r0,[r1,r0]	; 023058A6
	and r2,r0	; 023058A8
	add r0,r2,#0x0	; 023058AA
	bx lr	; 023058AC
	.byte 0xC0, 0x46	; 023058B0
pool_023058B0:
loc_023058B0:
	.word FirmwareWlWorkPointerSlot	; 023058B0
pool_023058B4:
loc_023058B4:
	.word 0x00000300	; 023058B4

; ===== function loc_023058B8 =====
loc_023058B8:
	ldrh r3,[r0,#0x4]	; 023058B8
	ldrh r2,[r1,#0x4]	; 023058BA
	cmp r3,r2	; 023058BC
	bne loc_023058D4	; 023058BE
	ldrh r3,[r0,#0x2]	; 023058C0
	ldrh r2,[r1,#0x2]	; 023058C2
	cmp r3,r2	; 023058C4
	bne loc_023058D4	; 023058C6
	ldrh r2,[r0,#0x0]	; 023058C8
	ldrh r0,[r1,#0x0]	; 023058CA
	cmp r2,r0	; 023058CC
	bne loc_023058D4	; 023058CE
	mov r0,#0x1	; 023058D0
	bx lr	; 023058D2
loc_023058D4:
	mov r0,#0x0	; 023058D4
	bx lr	; 023058D6

; ===== function loc_023058D8 =====
loc_023058D8:
	push {r4,r5,r6,r7,lr}	; 023058D8
	sub sp,#0xc	; 023058DA
	add r5,r0,#0x0	; 023058DC
	str r1,[sp,#0x0]	; 023058DE
	ldr r0,[pool_02305950]	; 023058E0
	ldr r1,[r0,#0x0]	; 023058E2
	ldr r0,[pool_02305954]	; 023058E4
	add r4,r1,r0	; 023058E6
	cmp r5,#0x20	; 023058E8
	bls loc_023058F0	; 023058EA
	mov r0,#0x0	; 023058EC
	b loc_02305948	; 023058EE
loc_023058F0:
	ldrh r0,[r4,#0x1e]	; 023058F0
	cmp r0,#0x0	; 023058F2
	bne loc_023058FA	; 023058F4
	mov r0,#0x1	; 023058F6
	b loc_02305948	; 023058F8
loc_023058FA:
	cmp r5,r0	; 023058FA
	beq loc_02305902	; 023058FC
	mov r0,#0x0	; 023058FE
	b loc_02305948	; 02305900
loc_02305902:
	add r7,r4,#0x0	; 02305902
	add r7,#0x20	; 02305904
	add r4,#0x40	; 02305906
	mov r6,#0x0	; 02305908
	b loc_02305942	; 0230590A
loc_0230590C:
	add r0,r4,#0x0	; 0230590C
	bl loc_02305180	; 0230590E
	str r0,[sp,#0x4]	; 02305912
	add r4,r4,#0x1	; 02305914
	ldr r0,[sp,#0x0]	; 02305916
	bl loc_02305180	; 02305918
	str r0,[sp,#0x8]	; 0230591C
	ldr r0,[sp,#0x0]	; 0230591E
	add r0,r0,#0x1	; 02305920
	str r0,[sp,#0x0]	; 02305922
	add r0,r7,#0x0	; 02305924
	bl loc_02305180	; 02305926
	add r7,r7,#0x1	; 0230592A
	ldr r2,[sp,#0x8]	; 0230592C
	ldr r1,[sp,#0x4]	; 0230592E
	orr r2,r1	; 02305930
	str r2,[sp,#0x8]	; 02305932
	orr r0,r1	; 02305934
	lsl r1,r2,#0	; 02305936
	cmp r1,r0	; 02305938
	beq loc_02305940	; 0230593A
	mov r0,#0x0	; 0230593C
	b loc_02305948	; 0230593E
loc_02305940:
	add r6,r6,#0x1	; 02305940
loc_02305942:
	cmp r6,r5	; 02305942
	bcc loc_0230590C	; 02305944
	mov r0,#0x1	; 02305946
loc_02305948:
	add sp,#0xc	; 02305948
	pop {r4,r5,r6,r7}	; 0230594A
	pop {r3}	; 0230594C
	bx r3	; 0230594E
pool_02305950:
loc_02305950:
	.word FirmwareWlWorkPointerSlot	; 02305950
pool_02305954:
loc_02305954:
	.word 0x00000318	; 02305954

; ===== function loc_02305958 =====
P4_Entry_02305958:
	push {r4,r5,lr}	; 02305958
	sub sp,#0x4	; 0230595A
	ldr r0,[pool_02305AF0]	; 0230595C
	ldr r1,[r0,#0x0]	; 0230595E
	ldr r0,[pool_02305AF4]	; 02305960
	add r1,r1,r0	; 02305962
	ldr r0,[pool_02305AF8]	; 02305964
	ldrh r4,[r0,#0x0]	; 02305966
	ldr r3,[r1,#0x50]	; 02305968
	mov r2,#0xff	; 0230596A
	and r4,r2	; 0230596C
	add r3,r3,r4	; 0230596E
	str r3,[r1,#0x50]	; 02305970
	ldrh r5,[r0,#0x2]	; 02305972
	ldr r4,[r1,#0x4c]	; 02305974
	asr r3,r5,#0x8	; 02305976
	add r3,r4,r3	; 02305978
	str r3,[r1,#0x4c]	; 0230597A
	ldr r3,[r1,#0x5c]	; 0230597C
	and r5,r2	; 0230597E
	add r3,r3,r5	; 02305980
	str r3,[r1,#0x5c]	; 02305982
	ldrh r5,[r0,#0x4]	; 02305984
	ldr r4,[r1,#0x58]	; 02305986
	asr r3,r5,#0x8	; 02305988
	add r3,r4,r3	; 0230598A
	str r3,[r1,#0x58]	; 0230598C
	ldr r3,[r1,#0x54]	; 0230598E
	and r5,r2	; 02305990
	add r3,r3,r5	; 02305992
	str r3,[r1,#0x54]	; 02305994
	ldrh r5,[r0,#0x6]	; 02305996
	ldr r4,[r1,#0x60]	; 02305998
	asr r3,r5,#0x8	; 0230599A
	add r3,r4,r3	; 0230599C
	str r3,[r1,#0x60]	; 0230599E
	ldr r3,[r1,#0x38]	; 023059A0
	and r5,r2	; 023059A2
	add r3,r3,r5	; 023059A4
	str r3,[r1,#0x38]	; 023059A6
	ldrh r4,[r0,#0x8]	; 023059A8
	ldr r3,[r1,#0x48]	; 023059AA
	and r4,r2	; 023059AC
	add r3,r3,r4	; 023059AE
	str r3,[r1,#0x48]	; 023059B0
	ldrh r4,[r0,#0xa]	; 023059B2
	ldr r3,[r1,#0x20]	; 023059B4
	and r4,r2	; 023059B6
	add r3,r3,r4	; 023059B8
	str r3,[r1,#0x20]	; 023059BA
	ldrh r5,[r0,#0xc]	; 023059BC
	ldr r4,[r1,#0x30]	; 023059BE
	asr r3,r5,#0x8	; 023059C0
	add r3,r4,r3	; 023059C2
	str r3,[r1,#0x30]	; 023059C4
	ldr r3,[r1,#0x44]	; 023059C6
	and r5,r2	; 023059C8
	add r3,r3,r5	; 023059CA
	str r3,[r1,#0x44]	; 023059CC
	ldrh r5,[r0,#0xe]	; 023059CE
	ldr r4,[r1,#0x3c]	; 023059D0
	add r3,r5,#0x0	; 023059D2
	and r3,r2	; 023059D4
	add r3,r4,r3	; 023059D6
	str r3,[r1,#0x3c]	; 023059D8
	ldr r4,[r1,#0x40]	; 023059DA
	asr r3,r5,#0x8	; 023059DC
	add r3,r4,r3	; 023059DE
	str r3,[r1,#0x40]	; 023059E0
	ldrh r4,[r0,#0x10]	; 023059E2
	ldr r3,[r1,#0xc]	; 023059E4
	and r4,r2	; 023059E6
	add r3,r3,r4	; 023059E8
	str r3,[r1,#0xc]	; 023059EA
	ldrh r3,[r0,#0x20]	; 023059EC
	ldr r4,[r1,#0x78]	; 023059EE
	asr r3,r3,#0x8	; 023059F0
	add r3,r4,r3	; 023059F2
	str r3,[r1,#0x78]	; 023059F4
	ldrh r3,[r0,#0x22]	; 023059F6
	ldr r5,[r1,#0x7c]	; 023059F8
	add r4,r3,#0x0	; 023059FA
	and r4,r2	; 023059FC
	add r4,r5,r4	; 023059FE
	str r4,[r1,#0x7c]	; 02305A00
	add r4,r1,#0x0	; 02305A02
	add r4,#0x80	; 02305A04
	ldr r4,[r4,#0x0]	; 02305A06
	asr r3,r3,#0x8	; 02305A08
	add r4,r4,r3	; 02305A0A
	add r3,r1,#0x0	; 02305A0C
	add r3,#0x80	; 02305A0E
	str r4,[r3,#0x0]	; 02305A10
	ldrh r3,[r0,#0x24]	; 02305A12
	add r4,r1,#0x0	; 02305A14
	add r4,#0x84	; 02305A16
	ldr r5,[r4,#0x0]	; 02305A18
	add r4,r3,#0x0	; 02305A1A
	and r4,r2	; 02305A1C
	add r5,r5,r4	; 02305A1E
	add r4,r1,#0x0	; 02305A20
	add r4,#0x84	; 02305A22
	str r5,[r4,#0x0]	; 02305A24
	add r4,r1,#0x0	; 02305A26
	add r4,#0x88	; 02305A28
	ldr r4,[r4,#0x0]	; 02305A2A
	asr r3,r3,#0x8	; 02305A2C
	add r4,r4,r3	; 02305A2E
	add r3,r1,#0x0	; 02305A30
	add r3,#0x88	; 02305A32
	str r4,[r3,#0x0]	; 02305A34
	ldrh r3,[r0,#0x26]	; 02305A36
	add r4,r1,#0x0	; 02305A38
	add r4,#0x8c	; 02305A3A
	ldr r5,[r4,#0x0]	; 02305A3C
	add r4,r3,#0x0	; 02305A3E
	and r4,r2	; 02305A40
	add r5,r5,r4	; 02305A42
	add r4,r1,#0x0	; 02305A44
	add r4,#0x8c	; 02305A46
	str r5,[r4,#0x0]	; 02305A48
	add r4,r1,#0x0	; 02305A4A
	add r4,#0x90	; 02305A4C
	ldr r4,[r4,#0x0]	; 02305A4E
	asr r3,r3,#0x8	; 02305A50
	add r4,r4,r3	; 02305A52
	add r3,r1,#0x0	; 02305A54
	add r3,#0x90	; 02305A56
	str r4,[r3,#0x0]	; 02305A58
	ldrh r3,[r0,#0x28]	; 02305A5A
	add r4,r1,#0x0	; 02305A5C
	add r4,#0x94	; 02305A5E
	ldr r5,[r4,#0x0]	; 02305A60
	add r4,r3,#0x0	; 02305A62
	and r4,r2	; 02305A64
	add r5,r5,r4	; 02305A66
	add r4,r1,#0x0	; 02305A68
	add r4,#0x94	; 02305A6A
	str r5,[r4,#0x0]	; 02305A6C
	add r4,r1,#0x0	; 02305A6E
	add r4,#0x98	; 02305A70
	ldr r4,[r4,#0x0]	; 02305A72
	asr r3,r3,#0x8	; 02305A74
	add r4,r4,r3	; 02305A76
	add r3,r1,#0x0	; 02305A78
	add r3,#0x98	; 02305A7A
	str r4,[r3,#0x0]	; 02305A7C
	ldrh r3,[r0,#0x2a]	; 02305A7E
	add r4,r1,#0x0	; 02305A80
	add r4,#0x9c	; 02305A82
	ldr r5,[r4,#0x0]	; 02305A84
	add r4,r3,#0x0	; 02305A86
	and r4,r2	; 02305A88
	add r5,r5,r4	; 02305A8A
	add r4,r1,#0x0	; 02305A8C
	add r4,#0x9c	; 02305A8E
	str r5,[r4,#0x0]	; 02305A90
	add r4,r1,#0x0	; 02305A92
	add r4,#0xa0	; 02305A94
	ldr r4,[r4,#0x0]	; 02305A96
	asr r3,r3,#0x8	; 02305A98
	add r4,r4,r3	; 02305A9A
	add r3,r1,#0x0	; 02305A9C
	add r3,#0xa0	; 02305A9E
	str r4,[r3,#0x0]	; 02305AA0
	ldrh r3,[r0,#0x2c]	; 02305AA2
	add r4,r1,#0x0	; 02305AA4
	add r4,#0xa4	; 02305AA6
	ldr r5,[r4,#0x0]	; 02305AA8
	add r4,r3,#0x0	; 02305AAA
	and r4,r2	; 02305AAC
	add r5,r5,r4	; 02305AAE
	add r4,r1,#0x0	; 02305AB0
	add r4,#0xa4	; 02305AB2
	str r5,[r4,#0x0]	; 02305AB4
	add r4,r1,#0x0	; 02305AB6
	add r4,#0xa8	; 02305AB8
	ldr r4,[r4,#0x0]	; 02305ABA
	asr r3,r3,#0x8	; 02305ABC
	add r4,r4,r3	; 02305ABE
	add r3,r1,#0x0	; 02305AC0
	add r3,#0xa8	; 02305AC2
	str r4,[r3,#0x0]	; 02305AC4
	ldrh r0,[r0,#0x2e]	; 02305AC6
	add r3,r1,#0x0	; 02305AC8
	add r3,#0xac	; 02305ACA
	ldr r4,[r3,#0x0]	; 02305ACC
	add r3,r0,#0x0	; 02305ACE
	and r3,r2	; 02305AD0
	add r3,r4,r3	; 02305AD2
	add r2,r1,#0x0	; 02305AD4
	add r2,#0xac	; 02305AD6
	str r3,[r2,#0x0]	; 02305AD8
	add r2,r1,#0x0	; 02305ADA
	add r2,#0xb0	; 02305ADC
	ldr r2,[r2,#0x0]	; 02305ADE
	asr r0,r0,#0x8	; 02305AE0
	add r0,r2,r0	; 02305AE2
	add r1,#0xb0	; 02305AE4
	str r0,[r1,#0x0]	; 02305AE6
	add sp,#0x4	; 02305AE8
	pop {r4,r5}	; 02305AEA
	pop {r3}	; 02305AEC
	bx r3	; 02305AEE
pool_02305AF0:
loc_02305AF0:
	.word FirmwareWlWorkPointerSlot	; 02305AF0
pool_02305AF4:
loc_02305AF4:
	.word 0x00000510	; 02305AF4
pool_02305AF8:
loc_02305AF8:
	.word REG_WIFI_RXSTAT	; 02305AF8
	.byte 0x00, 0xB5, 0x81, 0xB0, 0xFF, 0xF7, 0x2A, 0xFF, 0x00, 0x20, 0x00, 0x90, 0x00, 0x98, 0x05, 0x49	; 02305B0C
	.byte 0x0A, 0x68, 0x05, 0x49, 0x51, 0x18, 0xB4, 0x22, 0x00, 0xF0, 0x08, 0xF8, 0x01, 0xB0, 0x08, 0xBC	; 02305B1C
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x05, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 02305B2C
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x50, 0xF3, 0x7F, 0x03	; 02305B34

; ===== function loc_02305B34 =====
loc_02305B34:
	push {r4,lr}	; 02305B34
	ldrh r4,[r1,#0x0]	; 02305B36
	strh r4,[r0,#0x0]	; 02305B38
	ldrh r4,[r1,#0x2]	; 02305B3A
	strh r4,[r0,#0x2]	; 02305B3C
	ldrh r1,[r1,#0x4]	; 02305B3E
	strh r1,[r0,#0x4]	; 02305B40
	ldrh r1,[r2,#0x0]	; 02305B42
	strh r1,[r0,#0x6]	; 02305B44
	ldrh r1,[r2,#0x2]	; 02305B46
	strh r1,[r0,#0x8]	; 02305B48
	ldrh r1,[r2,#0x4]	; 02305B4A
	strh r1,[r0,#0xa]	; 02305B4C
	ldrh r1,[r3,#0x0]	; 02305B4E
	strh r1,[r0,#0xc]	; 02305B50
	ldrh r1,[r3,#0x2]	; 02305B52
	strh r1,[r0,#0xe]	; 02305B54
	ldrh r1,[r3,#0x4]	; 02305B56
	strh r1,[r0,#0x10]	; 02305B58
	pop {r4}	; 02305B5A
	pop {r3}	; 02305B5C
	bx r3	; 02305B5E
loc_02305B60:
	ldrh r3,[r1,#0x0]	; 02305B60
	strh r3,[r0,#0x0]	; 02305B62
	ldrh r3,[r1,#0x2]	; 02305B64
	strh r3,[r0,#0x2]	; 02305B66
	ldrh r1,[r1,#0x4]	; 02305B68
	strh r1,[r0,#0x4]	; 02305B6A
	ldrh r1,[r2,#0x0]	; 02305B6C
	strh r1,[r0,#0x6]	; 02305B6E
	ldrh r1,[r2,#0x2]	; 02305B70
	strh r1,[r0,#0x8]	; 02305B72
	ldrh r1,[r2,#0x4]	; 02305B74
	strh r1,[r0,#0xa]	; 02305B76
	bx lr	; 02305B78
	.byte 0x00, 0x00	; 02305B7C

; ===== function loc_02305B7C =====
loc_02305B7C:
	ldrh r2,[r1,#0x0]	; 02305B7C
	strh r2,[r0,#0x0]	; 02305B7E
	ldrh r2,[r1,#0x2]	; 02305B80
	strh r2,[r0,#0x2]	; 02305B82
	ldrh r1,[r1,#0x4]	; 02305B84
	strh r1,[r0,#0x4]	; 02305B86
	bx lr	; 02305B88
	.byte 0x00, 0x00	; 02305B8C

; ===== function loc_02305B8C =====
loc_02305B8C:
	push {r4,lr}	; 02305B8C
	ldr r3,[pool_02305BD8]	; 02305B8E
	ldr r1,[r3,#0x0]	; 02305B90
	ldr r0,[pool_02305BDC]	; 02305B92
	add r4,r1,r0	; 02305B94
	mov r2,#0x0	; 02305B96
	add r0,r4,#0x0	; 02305B98
	add r0,#0x6a	; 02305B9A
	strh r2,[r0,#0x0]	; 02305B9C
	ldr r1,[r3,#0x0]	; 02305B9E
	ldr r0,[pool_02305BE0]	; 02305BA0
	strh r2,[r1,r0]	; 02305BA2
	bl loc_02307788	; 02305BA4
	mov r1,#0x0	; 02305BA8
	ldr r0,[pool_02305BE4]	; 02305BAA
	strh r1,[r0,#0x0]	; 02305BAC
	ldr r0,[pool_02305BE8]	; 02305BAE
	strh r1,[r0,#0x0]	; 02305BB0
	add r0,r4,#0x0	; 02305BB2
	add r0,#0x88	; 02305BB4
	ldrh r0,[r0,#0x0]	; 02305BB6
	cmp r0,#0x0	; 02305BB8
	beq loc_02305BD2	; 02305BBA
	bl loc_0230A5F4	; 02305BBC
	add r0,r4,#0x0	; 02305BC0
	add r0,#0x88	; 02305BC2
	ldrh r0,[r0,#0x0]	; 02305BC4
	mov r1,#0x20	; 02305BC6
	bl loc_0230745C	; 02305BC8
	mov r0,#0x0	; 02305BCC
	add r4,#0x88	; 02305BCE
	strh r0,[r4,#0x0]	; 02305BD0
loc_02305BD2:
	pop {r4}	; 02305BD2
	pop {r3}	; 02305BD4
	bx r3	; 02305BD6
pool_02305BD8:
loc_02305BD8:
	.word FirmwareWlWorkPointerSlot	; 02305BD8
pool_02305BDC:
loc_02305BDC:
	.word 0x00000318	; 02305BDC
pool_02305BE0:
loc_02305BE0:
	.word 0x000004A2	; 02305BE0
pool_02305BE4:
loc_02305BE4:
	.word REG_WIFI_AID_LOW	; 02305BE4
pool_02305BE8:
loc_02305BE8:
	.word REG_WIFI_AID_FULL	; 02305BE8

; ===== function loc_02305BEC =====
loc_02305BEC:
	push {r4,lr}	; 02305BEC
	ldr r4,[pool_02305C10]	; 02305BEE
	ldr r2,[r4,#0x0]	; 02305BF0
	ldr r1,[pool_02305C14]	; 02305BF2
	strh r0,[r2,r1]	; 02305BF4
	mov r3,#0x1	; 02305BF6
	lsl r3,r0	; 02305BF8
	ldr r2,[r4,#0x0]	; 02305BFA
	ldr r1,[pool_02305C18]	; 02305BFC
	strh r3,[r2,r1]	; 02305BFE
	ldr r1,[pool_02305C1C]	; 02305C00
	strh r0,[r1,#0x0]	; 02305C02
	ldr r1,[pool_02305C20]	; 02305C04
	strh r0,[r1,#0x0]	; 02305C06
	pop {r4}	; 02305C08
	pop {r3}	; 02305C0A
	bx r3	; 02305C0C
	.byte 0xC0, 0x46	; 02305C10
pool_02305C10:
loc_02305C10:
	.word FirmwareWlWorkPointerSlot	; 02305C10
pool_02305C14:
loc_02305C14:
	.word 0x00000382	; 02305C14
pool_02305C18:
loc_02305C18:
	.word 0x000004A2	; 02305C18
pool_02305C1C:
loc_02305C1C:
	.word REG_WIFI_AID_FULL	; 02305C1C
pool_02305C20:
loc_02305C20:
	.word REG_WIFI_AID_LOW	; 02305C20
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x00, 0x91, 0x1D, 0x48, 0x01, 0x68, 0x1D, 0x48, 0x0C, 0x18	; 02305C34
	.byte 0x80, 0x2D, 0x01, 0xD9, 0x04, 0x20, 0x2F, 0xE0, 0x00, 0x2D, 0x26, 0xD0, 0x20, 0x1C, 0xA2, 0x30	; 02305C44
	.byte 0x01, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x18, 0xD0, 0x20, 0x1C, 0x9C, 0x30, 0x06, 0x68	; 02305C54
	.byte 0x30, 0x1C, 0xFF, 0x21, 0xFF, 0xF7, 0xA4, 0xFA, 0x76, 0x1C, 0x00, 0x27, 0x0B, 0xE0, 0x00, 0x98	; 02305C64
	.byte 0xFF, 0xF7, 0x8C, 0xFA, 0x01, 0x1C, 0x30, 0x1C, 0xFF, 0xF7, 0x9A, 0xFA, 0x76, 0x1C, 0x00, 0x98	; 02305C74
	.byte 0x40, 0x1C, 0x00, 0x90, 0x7F, 0x1C, 0xAF, 0x42, 0xF1, 0xD3, 0x06, 0xE0, 0x00, 0x98, 0x21, 0x1C	; 02305C84
	.byte 0x9C, 0x31, 0x09, 0x68, 0x6A, 0x1C, 0x00, 0xF0, 0x0F, 0xF8, 0x20, 0x1C, 0xA0, 0x30, 0x05, 0x80	; 02305C94
	.byte 0x01, 0x20, 0xA4, 0x34, 0x20, 0x80, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 02305CA4
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 02305CB4
	.byte 0x34, 0xF3, 0x7F, 0x03, 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0B, 0x48, 0x02, 0x68, 0x0B, 0x48	; 02305CC4
	.byte 0x14, 0x18, 0x80, 0x2D, 0x01, 0xD9, 0x04, 0x20, 0x09, 0xE0, 0x08, 0x1C, 0x21, 0x1C, 0x9C, 0x31	; 02305CD4
	.byte 0x09, 0x68, 0x6A, 0x1C, 0x00, 0xF0, 0x0C, 0xF8, 0xA0, 0x34, 0x25, 0x80, 0x00, 0x20, 0x01, 0xB0	; 02305CE4
	.byte 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00	; 02305CF4
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x34, 0xF3, 0x7F, 0x03	; 02305D00

; ===== function loc_02305D00 =====
loc_02305D00:
	mov r2,#0x0	; 02305D00
	ldr r0,[pool_02305D18]	; 02305D02
	ldr r1,[r0,#0x0]	; 02305D04
	ldr r0,[pool_02305D1C]	; 02305D06
	strh r2,[r1,r0]	; 02305D08
	ldr r2,[pool_02305D20]	; 02305D0A
	ldrh r1,[r2,#0x0]	; 02305D0C
	mov r0,#0x2	; 02305D0E
	orr r1,r0	; 02305D10
	strh r1,[r2,#0x0]	; 02305D12
	bx lr	; 02305D14
	.byte 0xC0, 0x46	; 02305D18
pool_02305D18:
loc_02305D18:
	.word FirmwareWlWorkPointerSlot	; 02305D18
pool_02305D1C:
loc_02305D1C:
	.word 0x000003BE	; 02305D1C
pool_02305D20:
loc_02305D20:
	.word REG_WIFI_POWER_TX	; 02305D20

; ===== function loc_02305D24 =====
loc_02305D24:
	mov r3,#0x1	; 02305D24
	ldr r2,[pool_02305D4C]	; 02305D26
	ldr r1,[r2,#0x0]	; 02305D28
	ldr r0,[pool_02305D50]	; 02305D2A
	strh r3,[r1,r0]	; 02305D2C
	ldr r1,[r2,#0x0]	; 02305D2E
	ldr r0,[pool_02305D54]	; 02305D30
	ldrh r0,[r1,r0]	; 02305D32
	cmp r0,#0x0	; 02305D34
	bne loc_02305D48	; 02305D36
	ldr r2,[pool_02305D58]	; 02305D38
	ldrh r1,[r2,#0x0]	; 02305D3A
	mov r0,#0x2	; 02305D3C
	bic r1,r0	; 02305D3E
	strh r1,[r2,#0x0]	; 02305D40
	mov r1,#0x0	; 02305D42
	ldr r0,[pool_02305D5C]	; 02305D44
	strh r1,[r0,#0x0]	; 02305D46
loc_02305D48:
	bx lr	; 02305D48
	.byte 0xC0, 0x46	; 02305D4C
pool_02305D4C:
loc_02305D4C:
	.word FirmwareWlWorkPointerSlot	; 02305D4C
pool_02305D50:
loc_02305D50:
	.word 0x000003BE	; 02305D50
pool_02305D54:
loc_02305D54:
	.word 0x0000043C	; 02305D54
pool_02305D58:
loc_02305D58:
	.word REG_WIFI_POWER_TX	; 02305D58
pool_02305D5C:
loc_02305D5C:
	.word REG_WIFI_UNKNOWN_048	; 02305D5C

; ===== function loc_02305D60 =====
loc_02305D60:
	push {r4,r5,r6,lr}	; 02305D60
	add r5,r0,#0x0	; 02305D62
	ldr r0,[pool_02305DA8]	; 02305D64
	ldr r1,[r0,#0x0]	; 02305D66
	ldr r0,[pool_02305DAC]	; 02305D68
	add r4,r1,r0	; 02305D6A
	ldr r0,[pool_02305DB0]	; 02305D6C
	add r6,r1,r0	; 02305D6E
	ldr r0,[pool_02305DB4]	; 02305D70
	cmp r5,r0	; 02305D72
	bne loc_02305D80	; 02305D74
	mov r1,#0xff	; 02305D76
	strh r1,[r6,#0x1c]	; 02305D78
	add r4,#0x8c	; 02305D7A
	strh r0,[r4,#0x0]	; 02305D7C
	b loc_02305DA0	; 02305D7E
loc_02305D80:
	add r0,r4,#0x0	; 02305D80
	add r0,#0x6e	; 02305D82
	ldrh r1,[r0,#0x0]	; 02305D84
	add r0,r5,#0x0	; 02305D86
	mul r0,r1	; 02305D88
	mov r1,#0x64	; 02305D8A
	bl loc_02305DBC	; 02305D8C
	ldr r1,[pool_02305DB8]	; 02305D90
	cmp r0,r1	; 02305D92
	bls loc_02305D9A	; 02305D94
	mov r0,#0x5	; 02305D96
	b loc_02305DA2	; 02305D98
loc_02305D9A:
	strh r5,[r6,#0x1c]	; 02305D9A
	add r4,#0x8c	; 02305D9C
	strh r0,[r4,#0x0]	; 02305D9E
loc_02305DA0:
	mov r0,#0x0	; 02305DA0
loc_02305DA2:
	pop {r4,r5,r6}	; 02305DA2
	pop {r3}	; 02305DA4
	bx r3	; 02305DA6
pool_02305DA8:
loc_02305DA8:
	.word FirmwareWlWorkPointerSlot	; 02305DA8
pool_02305DAC:
loc_02305DAC:
	.word 0x00000318	; 02305DAC
pool_02305DB0:
loc_02305DB0:
	.word 0x000002F0	; 02305DB0
pool_02305DB4:
loc_02305DB4:
	.word 0x0000FFFF	; 02305DB4
pool_02305DB8:
loc_02305DB8:
	.word 0x00010000	; 02305DB8

; ===== function loc_02305DBC =====
loc_02305DBC:
	bx pc	; 02305DBC
	.byte 0xC0, 0x46	; 02305DC0
.arm

; ===== function loc_02305DC0 =====
loc_02305DC0:
	ldr pc,[pool_02305DC4]	; 02305DC0
pool_02305DC4:
loc_02305DC4:
	.word loc_03804DB0	; 02305DC4
.thumb

; ===== function loc_02305DC8 =====
loc_02305DC8:
	push {r4,lr}	; 02305DC8
	mov r1,#0x0	; 02305DCA
	ldr r0,[pool_02305E20]	; 02305DCC
	strh r1,[r0,#0x0]	; 02305DCE
	mov r0,#0x8	; 02305DD0
	bl loc_02305500	; 02305DD2
	mov r1,#0x0	; 02305DD6
	ldr r0,[pool_02305E24]	; 02305DD8
	strh r1,[r0,#0x0]	; 02305DDA
	ldr r0,[pool_02305E28]	; 02305DDC
	ldr r1,[r0,#0x0]	; 02305DDE
	ldr r0,[pool_02305E2C]	; 02305DE0
	ldrh r0,[r1,r0]	; 02305DE2
	cmp r0,#0x2	; 02305DE4
	beq loc_02305DEE	; 02305DE6
	cmp r0,#0x3	; 02305DE8
	beq loc_02305E16	; 02305DEA
	b loc_02305E1A	; 02305DEC
loc_02305DEE:
	mov r0,#0x1	; 02305DEE
	bl loc_023057BC	; 02305DF0
	add r4,r0,#0x0	; 02305DF4
	mov r0,#0x1	; 02305DF6
	mov r2,#0x7f	; 02305DF8
	add r1,r4,#0x0	; 02305DFA
	and r1,r2	; 02305DFC
	bl loc_02305788	; 02305DFE
	mov r0,#0x1	; 02305E02
	add r1,r4,#0x0	; 02305E04
	bl loc_02305788	; 02305E06
	mov r0,#0x28	; 02305E0A
	bl loc_02305500	; 02305E0C
	bl loc_0230556C	; 02305E10
	b loc_02305E1A	; 02305E14
loc_02305E16:
	bl loc_0230556C	; 02305E16
loc_02305E1A:
	pop {r4}	; 02305E1A
	pop {r3}	; 02305E1C
	bx r3	; 02305E1E
pool_02305E20:
loc_02305E20:
	.word REG_WIFI_POWER_US	; 02305E20
pool_02305E24:
loc_02305E24:
	.word REG_WIFI_BB_POWER	; 02305E24
pool_02305E28:
loc_02305E28:
	.word FirmwareWlWorkPointerSlot	; 02305E28
pool_02305E2C:
loc_02305E2C:
	.word 0x000005CC	; 02305E2C

; ===== function loc_02305E30 =====
loc_02305E30:
	push {lr}	; 02305E30
	sub sp,#0x4	; 02305E32
	ldr r0,[pool_02305E6C]	; 02305E34
	ldr r1,[r0,#0x0]	; 02305E36
	ldr r0,[pool_02305E70]	; 02305E38
	ldrh r0,[r1,r0]	; 02305E3A
	cmp r0,#0x2	; 02305E3C
	bne loc_02305E46	; 02305E3E
	ldr r0,[pool_02305E74]	; 02305E40
	bl loc_0230576C	; 02305E42
loc_02305E46:
	mov r0,#0x1e	; 02305E46
	bl loc_023057BC	; 02305E48
	mov r2,#0x3f	; 02305E4C
	add r1,r0,#0x0	; 02305E4E
	orr r1,r2	; 02305E50
	mov r0,#0x1e	; 02305E52
	bl loc_02305788	; 02305E54
	ldr r1,[pool_02305E78]	; 02305E58
	ldr r0,[pool_02305E7C]	; 02305E5A
	strh r1,[r0,#0x0]	; 02305E5C
	mov r1,#0x1	; 02305E5E
	ldr r0,[pool_02305E80]	; 02305E60
	strh r1,[r0,#0x0]	; 02305E62
	add sp,#0x4	; 02305E64
	pop {r3}	; 02305E66
	bx r3	; 02305E68
	.byte 0xC0, 0x46	; 02305E6C
pool_02305E6C:
loc_02305E6C:
	.word FirmwareWlWorkPointerSlot	; 02305E6C
pool_02305E70:
loc_02305E70:
	.word 0x000005CC	; 02305E70
pool_02305E74:
loc_02305E74:
	.word 0x0000C008	; 02305E74
pool_02305E78:
loc_02305E78:
	.word 0x0000800D	; 02305E78
pool_02305E7C:
loc_02305E7C:
	.word REG_WIFI_BB_POWER	; 02305E7C
pool_02305E80:
loc_02305E80:
	.word REG_WIFI_POWER_US	; 02305E80

; ===== function loc_02305E84 =====
loc_02305E84:
	ldr r1,[pool_02305E8C]	; 02305E84
	strh r0,[r1,#0x0]	; 02305E86
	mov r0,#0x0	; 02305E88
	bx lr	; 02305E8A
pool_02305E8C:
loc_02305E8C:
	.word REG_WIFI_POWERFORCE	; 02305E8C

; ===== function loc_02305E90 =====
loc_02305E90:
	lsr r3,r0,#0x1	; 02305E90
	ldr r1,[pool_02305EA4]	; 02305E92
	ldr r2,[r1,#0x0]	; 02305E94
	ldr r1,[pool_02305EA8]	; 02305E96
	strh r3,[r2,r1]	; 02305E98
	ldr r1,[pool_02305EAC]	; 02305E9A
	strh r0,[r1,#0x0]	; 02305E9C
	mov r0,#0x0	; 02305E9E
	bx lr	; 02305EA0
	.byte 0xC0, 0x46	; 02305EA4
pool_02305EA4:
loc_02305EA4:
	.word FirmwareWlWorkPointerSlot	; 02305EA4
pool_02305EA8:
loc_02305EA8:
	.word 0x00000328	; 02305EA8
pool_02305EAC:
loc_02305EAC:
	.word REG_WIFI_POWERSTATE	; 02305EAC

; ===== function loc_02305EB0 =====
loc_02305EB0:
	push {lr}	; 02305EB0
	sub sp,#0x4	; 02305EB2
	ldr r1,[pool_02305EF0]	; 02305EB4
	ldr r3,[r1,#0x0]	; 02305EB6
	ldr r1,[pool_02305EF4]	; 02305EB8
	add r1,r3,r1	; 02305EBA
	ldr r2,[pool_02305EF8]	; 02305EBC
	strh r0,[r3,r2]	; 02305EBE
	cmp r0,#0x0	; 02305EC0
	beq loc_02305ED6	; 02305EC2
	ldrh r0,[r1,#0x12]	; 02305EC4
	cmp r0,#0x1	; 02305EC6
	beq loc_02305ED6	; 02305EC8
	ldr r2,[pool_02305EFC]	; 02305ECA
	ldrh r1,[r2,#0x0]	; 02305ECC
	mov r0,#0x40	; 02305ECE
	orr r1,r0	; 02305ED0
	strh r1,[r2,#0x0]	; 02305ED2
	b loc_02305EE8	; 02305ED4
loc_02305ED6:
	ldr r3,[pool_02305EFC]	; 02305ED6
	ldrh r2,[r3,#0x0]	; 02305ED8
	mov r0,#0x40	; 02305EDA
	bic r2,r0	; 02305EDC
	strh r2,[r3,#0x0]	; 02305EDE
	ldrh r0,[r1,#0x20]	; 02305EE0
	mov r1,#0x0	; 02305EE2
	bl loc_02306624	; 02305EE4
loc_02305EE8:
	mov r0,#0x0	; 02305EE8
	add sp,#0x4	; 02305EEA
	pop {r3}	; 02305EEC
	bx r3	; 02305EEE
pool_02305EF0:
loc_02305EF0:
	.word FirmwareWlWorkPointerSlot	; 02305EF0
pool_02305EF4:
loc_02305EF4:
	.word 0x000002F0	; 02305EF4
pool_02305EF8:
loc_02305EF8:
	.word 0x00000326	; 02305EF8
pool_02305EFC:
loc_02305EFC:
	.word REG_WIFI_MODE_WEP	; 02305EFC

; ===== function loc_02305F00 =====
loc_02305F00:
	push {lr}	; 02305F00
	sub sp,#0x4	; 02305F02
	ldr r0,[pool_02305F48]	; 02305F04
	str r0,[sp,#0x0]	; 02305F06
	mov r0,#0x58	; 02305F08
	mov r1,#0x2	; 02305F0A
	add r2,sp,#0x0	; 02305F0C
	bl loc_0230D400	; 02305F0E
	ldr r1,[sp,#0x0]	; 02305F12
	ldr r0,[pool_02305F4C]	; 02305F14
	add r0,r1,r0	; 02305F16
	str r0,[sp,#0x0]	; 02305F18
	bl loc_023057E4	; 02305F1A
	cmp r0,#0x14	; 02305F1E
	bne loc_02305F3C	; 02305F20
	ldr r1,[sp,#0x0]	; 02305F22
	ldr r0,[pool_02305F50]	; 02305F24
	sub r2,r1,r0	; 02305F26
	str r2,[sp,#0x0]	; 02305F28
	ldr r0,[pool_02305F54]	; 02305F2A
	ldrh r1,[r0,#0x0]	; 02305F2C
	mov r0,#0x2	; 02305F2E
	and r1,r0	; 02305F30
	cmp r1,#0x0	; 02305F32
	beq loc_02305F3C	; 02305F34
	ldr r0,[pool_02305F58]	; 02305F36
	sub r0,r2,r0	; 02305F38
	str r0,[sp,#0x0]	; 02305F3A
loc_02305F3C:
	ldr r1,[sp,#0x0]	; 02305F3C
	ldr r0,[pool_02305F5C]	; 02305F3E
	strh r1,[r0,#0x0]	; 02305F40
	add sp,#0x4	; 02305F42
	pop {r3}	; 02305F44
	bx r3	; 02305F46
pool_02305F48:
loc_02305F48:
	.word 0x0000E2E2	; 02305F48
pool_02305F4C:
loc_02305F4C:
	.word 0x00000202	; 02305F4C
pool_02305F50:
loc_02305F50:
	.word 0x00006161	; 02305F50
pool_02305F54:
loc_02305F54:
	.word REG_WIFI_PREAMBLE	; 02305F54
pool_02305F58:
loc_02305F58:
	.word 0x00006060	; 02305F58
pool_02305F5C:
loc_02305F5C:
	.word REG_WIFI_CONFIG_140	; 02305F5C

; ===== function loc_02305F60 =====
loc_02305F60:
	push {lr}	; 02305F60
	sub sp,#0x4	; 02305F62
	ldr r1,[pool_02305F84]	; 02305F64
	ldr r2,[r1,#0x0]	; 02305F66
	ldr r1,[pool_02305F88]	; 02305F68
	add r2,r2,r1	; 02305F6A
	ldrh r1,[r0,#0x0]	; 02305F6C
	strh r1,[r2,#0x0]	; 02305F6E
	ldrh r1,[r0,#0x2]	; 02305F70
	ldrh r0,[r0,#0x0]	; 02305F72
	orr r1,r0	; 02305F74
	strh r1,[r2,#0x2]	; 02305F76
	bl loc_02305F00	; 02305F78
	mov r0,#0x0	; 02305F7C
	add sp,#0x4	; 02305F7E
	pop {r3}	; 02305F80
	bx r3	; 02305F82
pool_02305F84:
loc_02305F84:
	.word FirmwareWlWorkPointerSlot	; 02305F84
pool_02305F88:
loc_02305F88:
	.word 0x00000378	; 02305F88

; ===== function loc_02305F8C =====
loc_02305F8C:
	push {r4,r5,r6,r7,lr}	; 02305F8C
	sub sp,#0x14	; 02305F8E
	add r6,r0,#0x0	; 02305F90
	cmp r1,#0x0	; 02305F92
	beq loc_02305F9A	; 02305F94
	ldr r5,[pool_02306108]	; 02305F96
	b loc_02305F9C	; 02305F98
loc_02305F9A:
	ldr r5,[pool_0230610C]	; 02305F9A
loc_02305F9C:
	add r0,r6,#0x0	; 02305F9C
	bl loc_0230589C	; 02305F9E
	cmp r0,#0x0	; 02305FA2
	bne loc_02305FAA	; 02305FA4
	mov r0,#0x5	; 02305FA6
	b loc_023060FE	; 02305FA8
loc_02305FAA:
	ldr r1,[pool_02306110]	; 02305FAA
	ldrh r0,[r1,#0x0]	; 02305FAC
	str r0,[sp,#0x0]	; 02305FAE
	ldr r0,[pool_02306114]	; 02305FB0
	strh r0,[r1,#0x0]	; 02305FB2
	ldr r2,[pool_02306118]	; 02305FB4
	ldr r1,[pool_0230611C]	; 02305FB6
loc_02305FB8:
	ldrh r0,[r2,#0x0]	; 02305FB8
	asr r3,r0,#0x8	; 02305FBA
	ldrh r0,[r1,#0x0]	; 02305FBC
	cmp r3,#0x2	; 02305FBE
	bne loc_02305FB8	; 02305FC0
	cmp r0,#0x0	; 02305FC2
	beq loc_02305FCA	; 02305FC4
	cmp r0,#0x9	; 02305FC6
	bne loc_02305FB8	; 02305FC8
loc_02305FCA:
	ldr r0,[pool_02306120]	; 02305FCA
	ldr r1,[r0,#0x0]	; 02305FCC
	ldr r0,[pool_02306124]	; 02305FCE
	strh r6,[r1,r0]	; 02305FD0
	ldr r0,[pool_02306120]	; 02305FD2
	ldr r1,[r0,#0x0]	; 02305FD4
	ldr r0,[pool_02306128]	; 02305FD6
	ldrh r0,[r1,r0]	; 02305FD8
	cmp r0,#0x2	; 02305FDA
	beq loc_02305FE8	; 02305FDC
	cmp r0,#0x3	; 02305FDE
	beq loc_02306072	; 02305FE0
	cmp r0,#0x5	; 02305FE2
	beq loc_02305FE8	; 02305FE4
	b loc_023060F0	; 02305FE6
loc_02305FE8:
	mov r0,#0x0	; 02305FE8
	str r0,[sp,#0xc]	; 02305FEA
	sub r4,r6,#0x1	; 02305FEC
	mov r0,#0x6	; 02305FEE
	add r6,r4,#0x0	; 02305FF0
	mul r6,r0	; 02305FF2
	add r0,r6,#0x0	; 02305FF4
	add r0,#0xf2	; 02305FF6
	mov r1,#0x3	; 02305FF8
	add r2,sp,#0xc	; 02305FFA
	bl loc_02306154	; 02305FFC
	ldr r0,[sp,#0xc]	; 02306000
	bl loc_0230576C	; 02306002
	add r6,#0xf5	; 02306006
	add r0,r6,#0x0	; 02306008
	mov r1,#0x3	; 0230600A
	add r2,sp,#0xc	; 0230600C
	bl loc_02306154	; 0230600E
	ldr r0,[sp,#0xc]	; 02306012
	bl loc_0230576C	; 02306014
	mov r0,#0x0	; 02306018
	str r0,[sp,#0xc]	; 0230601A
	ldr r0,[pool_02306120]	; 0230601C
	ldr r1,[r0,#0x0]	; 0230601E
	ldr r0,[pool_0230612C]	; 02306020
	ldr r2,[r1,r0]	; 02306022
	ldr r0,[pool_02306130]	; 02306024
	add r1,r2,#0x0	; 02306026
	and r1,r0	; 02306028
	cmp r1,#0x0	; 0230602A
	beq loc_0230605C	; 0230602C
	ldr r0,[pool_02306134]	; 0230602E
	and r2,r0	; 02306030
	cmp r2,#0x0	; 02306032
	bne loc_023060F0	; 02306034
	ldr r0,[pool_02306138]	; 02306036
	add r0,r4,r0	; 02306038
	mov r1,#0x1	; 0230603A
	add r2,sp,#0xc	; 0230603C
	bl loc_02306154	; 0230603E
	ldr r0,[pool_02306120]	; 02306042
	ldr r1,[r0,#0x0]	; 02306044
	ldr r0,[pool_0230612C]	; 02306046
	ldr r0,[r1,r0]	; 02306048
	ldr r2,[sp,#0xc]	; 0230604A
	mov r1,#0x1f	; 0230604C
	and r2,r1	; 0230604E
	lsl r1,r2,#0xa	; 02306050
	orr r0,r1	; 02306052
	str r0,[sp,#0xc]	; 02306054
	bl loc_0230576C	; 02306056
	b loc_023060F0	; 0230605A
loc_0230605C:
	ldr r0,[pool_0230613C]	; 0230605C
	add r0,r4,r0	; 0230605E
	mov r1,#0x1	; 02306060
	add r2,sp,#0xc	; 02306062
	bl loc_02306154	; 02306064
	mov r0,#0x1e	; 02306068
	ldr r1,[sp,#0xc]	; 0230606A
	bl loc_02305788	; 0230606C
	b loc_023060F0	; 02306070
loc_02306072:
	ldr r0,[pool_02306140]	; 02306072
	ldrh r4,[r1,r0]	; 02306074
	add r4,#0xcf	; 02306076
	mov r7,#0x0	; 02306078
	str r7,[sp,#0x4]	; 0230607A
	b loc_023060A4	; 0230607C
loc_0230607E:
	ldr r0,[sp,#0x4]	; 0230607E
	str r0,[sp,#0xc]	; 02306080
	str r0,[sp,#0x10]	; 02306082
	add r0,r4,#0x0	; 02306084
	mov r1,#0x1	; 02306086
	add r2,sp,#0x10	; 02306088
	bl loc_02306154	; 0230608A
	add r0,r4,r6	; 0230608E
	mov r1,#0x1	; 02306090
	add r2,sp,#0xc	; 02306092
	bl loc_02306154	; 02306094
	ldr r0,[sp,#0x10]	; 02306098
	ldr r1,[sp,#0xc]	; 0230609A
	bl loc_02305788	; 0230609C
	add r4,#0xf	; 023060A0
	add r7,r7,#0x1	; 023060A2
loc_023060A4:
	ldr r0,[pool_02306120]	; 023060A4
	ldr r1,[r0,#0x0]	; 023060A6
	ldr r0,[pool_02306144]	; 023060A8
	ldrh r0,[r1,r0]	; 023060AA
	cmp r7,r0	; 023060AC
	bcc loc_0230607E	; 023060AE
	mov r7,#0x0	; 023060B0
	str r7,[sp,#0x8]	; 023060B2
	b loc_023060E4	; 023060B4
loc_023060B6:
	ldr r0,[sp,#0x8]	; 023060B6
	str r0,[sp,#0xc]	; 023060B8
	add r0,r4,#0x0	; 023060BA
	mov r1,#0x1	; 023060BC
	add r2,sp,#0xc	; 023060BE
	bl loc_02306154	; 023060C0
	ldr r0,[sp,#0xc]	; 023060C4
	lsl r0,r0,#0x8	; 023060C6
	str r0,[sp,#0xc]	; 023060C8
	add r0,r4,r6	; 023060CA
	mov r1,#0x1	; 023060CC
	add r2,sp,#0xc	; 023060CE
	bl loc_02306154	; 023060D0
	ldr r0,[sp,#0xc]	; 023060D4
	ldr r1,[pool_02306148]	; 023060D6
	orr r0,r1	; 023060D8
	str r0,[sp,#0xc]	; 023060DA
	bl loc_0230576C	; 023060DC
	add r4,#0xf	; 023060E0
	add r7,r7,#0x1	; 023060E2
loc_023060E4:
	ldr r0,[pool_02306120]	; 023060E4
	ldr r1,[r0,#0x0]	; 023060E6
	ldr r0,[pool_0230614C]	; 023060E8
	ldrh r0,[r1,r0]	; 023060EA
	cmp r7,r0	; 023060EC
	bcc loc_023060B6	; 023060EE
loc_023060F0:
	ldr r1,[pool_02306110]	; 023060F0
	ldr r0,[sp,#0x0]	; 023060F2
	strh r0,[r1,#0x0]	; 023060F4
	mov r1,#0x3	; 023060F6
	ldr r0,[pool_02306150]	; 023060F8
	strh r1,[r0,#0x0]	; 023060FA
	mov r0,#0x0	; 023060FC
loc_023060FE:
	add sp,#0x14	; 023060FE
	pop {r4,r5,r6,r7}	; 02306100
	pop {r3}	; 02306102
	bx r3	; 02306104
	.byte 0xC0, 0x46	; 02306108
pool_02306108:
loc_02306108:
	.word 0x0230D3C5	; 02306108
pool_0230610C:
loc_0230610C:
	.word 0x0230D401	; 0230610C
pool_02306110:
loc_02306110:
	.word REG_WIFI_POWERFORCE	; 02306110
pool_02306114:
loc_02306114:
	.word 0x00008001	; 02306114
pool_02306118:
loc_02306118:
	.word REG_WIFI_POWERSTATE	; 02306118
pool_0230611C:
loc_0230611C:
	.word REG_WIFI_RF_STATUS	; 0230611C
pool_02306120:
loc_02306120:
	.word FirmwareWlWorkPointerSlot	; 02306120
pool_02306124:
loc_02306124:
	.word 0x00000392	; 02306124
pool_02306128:
loc_02306128:
	.word 0x000005CC	; 02306128
pool_0230612C:
loc_0230612C:
	.word 0x000005D8	; 0230612C
pool_02306130:
loc_02306130:
	.word 0x00010000	; 02306130
pool_02306134:
loc_02306134:
	.word 0x00008000	; 02306134
pool_02306138:
loc_02306138:
	.word 0x00000154	; 02306138
pool_0230613C:
loc_0230613C:
	.word 0x00000146	; 0230613C
pool_02306140:
loc_02306140:
	.word 0x000005D0	; 02306140
pool_02306144:
loc_02306144:
	.word 0x000005D4	; 02306144
pool_02306148:
loc_02306148:
	.word 0x00050000	; 02306148
pool_0230614C:
loc_0230614C:
	.word 0x000005D2	; 0230614C
pool_02306150:
loc_02306150:
	.word REG_WIFI_UNKNOWN_048	; 02306150

; ===== function loc_02306154 =====
loc_02306154:
	bx pc	; 02306154
	.byte 0xC0, 0x46	; 02306158
.arm

; ===== function loc_02306158 =====
loc_02306158:
	ldr r12,[pool_02306160]	; 02306158
	bx r12	; 0230615C
pool_02306160:
loc_02306160:
	.word loc_03805098 + 1	; 02306160
.thumb

; ===== function loc_02306164 =====
loc_02306164:
	push {lr}	; 02306164
	sub sp,#0xc	; 02306166
	mov r0,#0x36	; 02306168
	mov r1,#0x6	; 0230616A
	add r2,sp,#0x0	; 0230616C
	add r2,#0x2	; 0230616E
	bl loc_0230D400	; 02306170
	mov r0,#0x3c	; 02306174
	mov r1,#0x2	; 02306176
	add r2,sp,#0x0	; 02306178
	bl loc_0230D400	; 0230617A
	add r0,sp,#0x0	; 0230617E
	add r0,#0x2	; 02306180
	bl loc_02306934	; 02306182
	mov r0,#0x7	; 02306186
	bl loc_02306910	; 02306188
	add r0,sp,#0x0	; 0230618C
	ldrh r1,[r0,#0x0]	; 0230618E
	ldr r0,[pool_02306234]	; 02306190
	and r1,r0	; 02306192
	lsl r0,r1,#0x10	; 02306194
	lsr r0,r0,#0x10	; 02306196
	bl loc_023068D8	; 02306198
	mov r0,#0x2	; 0230619C
	bl loc_02306874	; 0230619E
	mov r0,#0x0	; 023061A2
	bl loc_0230684C	; 023061A4
	mov r0,#0x0	; 023061A8
	bl loc_023067A0	; 023061AA
	mov r0,#0x0	; 023061AE
	bl loc_02306784	; 023061B0
	ldr r0,[pool_02306238]	; 023061B4
	bl loc_02306738	; 023061B6
	ldr r0,[pool_0230623C]	; 023061BA
	bl loc_02306288	; 023061BC
	mov r0,#0x0	; 023061C0
	bl loc_02306710	; 023061C2
	mov r0,#0x0	; 023061C6
	bl loc_023066E4	; 023061C8
	mov r0,#0x10	; 023061CC
	bl loc_023066B4	; 023061CE
	ldr r0,[pool_02306240]	; 023061D2
	mov r1,#0x0	; 023061D4
	bl loc_02306624	; 023061D6
	ldr r0,[pool_02306244]	; 023061DA
	bl loc_02306600	; 023061DC
	mov r0,#0x1	; 023061E0
	bl loc_02306554	; 023061E2
	mov r0,#0x0	; 023061E6
	bl loc_02306538	; 023061E8
	ldr r0,[pool_02306248]	; 023061EC
	bl loc_02305F60	; 023061EE
	mov r0,#0x0	; 023061F2
	mov r1,#0x1f	; 023061F4
	bl loc_02306508	; 023061F6
	mov r0,#0x5	; 023061FA
	bl loc_02305D60	; 023061FC
	mov r0,#0x0	; 02306200
	add r1,r0,#0x0	; 02306202
	bl loc_0230641C	; 02306204
	mov r0,#0x0	; 02306208
	bl loc_023064B8	; 0230620A
	mov r0,#0x0	; 0230620E
	bl loc_023063EC	; 02306210
	ldr r2,[pool_0230624C]	; 02306214
	ldrh r1,[r2,#0x0]	; 02306216
	ldrh r0,[r2,#0x0]	; 02306218
	lsl r0,r0,#0x8	; 0230621A
	add r0,r1,r0	; 0230621C
	ldrh r1,[r2,#0x0]	; 0230621E
	bl loc_0230515C	; 02306220
	mov r2,#0x1	; 02306224
	ldr r0,[pool_02306250]	; 02306226
	ldr r1,[r0,#0x0]	; 02306228
	ldr r0,[pool_02306254]	; 0230622A
	strh r2,[r1,r0]	; 0230622C
	add sp,#0xc	; 0230622E
	pop {r3}	; 02306230
	bx r3	; 02306232
pool_02306234:
loc_02306234:
	.word 0x00007FFE	; 02306234
pool_02306238:
loc_02306238:
	.word 0x0230D6A8	; 02306238
pool_0230623C:
loc_0230623C:
	.word 0x000001F4	; 0230623C
pool_02306240:
loc_02306240:
	.word 0x0000FFFF	; 02306240
pool_02306244:
loc_02306244:
	.word 0x0230D648	; 02306244
pool_02306248:
loc_02306248:
	.word 0x0230D604	; 02306248
pool_0230624C:
loc_0230624C:
	.word REG_WIFI_RANDOM	; 0230624C
pool_02306250:
loc_02306250:
	.word FirmwareWlWorkPointerSlot	; 02306250
pool_02306254:
loc_02306254:
	.word 0x0000032C	; 02306254

; ===== function loc_02306258 =====
loc_02306258:
	cmp r0,#0x1	; 02306258
	bcc loc_02306260	; 0230625A
	cmp r0,#0xff	; 0230625C
	bls loc_02306264	; 0230625E
loc_02306260:
	mov r0,#0x5	; 02306260
	bx lr	; 02306262
loc_02306264:
	ldr r1,[pool_02306278]	; 02306264
	ldr r2,[r1,#0x0]	; 02306266
	ldr r1,[pool_0230627C]	; 02306268
	strh r0,[r2,r1]	; 0230626A
	ldr r1,[pool_02306280]	; 0230626C
	strh r0,[r1,#0x0]	; 0230626E
	mov r0,#0x0	; 02306270
	ldr r1,[pool_02306284]	; 02306272
	strh r0,[r1,#0x0]	; 02306274
	bx lr	; 02306276
pool_02306278:
loc_02306278:
	.word FirmwareWlWorkPointerSlot	; 02306278
pool_0230627C:
loc_0230627C:
	.word 0x0000038C	; 0230627C
pool_02306280:
loc_02306280:
	.word REG_WIFI_LISTENINT	; 02306280
pool_02306284:
loc_02306284:
	.word REG_WIFI_LISTENCOUNT	; 02306284

; ===== function loc_02306288 =====
loc_02306288:
	push {lr}	; 02306288
	sub sp,#0x4	; 0230628A
	cmp r0,#0xa	; 0230628C
	bcc loc_02306296	; 0230628E
	ldr r1,[pool_023062B8]	; 02306290
	cmp r0,r1	; 02306292
	bls loc_0230629A	; 02306294
loc_02306296:
	mov r0,#0x5	; 02306296
	b loc_023062B2	; 02306298
loc_0230629A:
	ldr r3,[pool_023062BC]	; 0230629A
	ldr r2,[r3,#0x0]	; 0230629C
	ldr r1,[pool_023062C0]	; 0230629E
	strh r0,[r2,r1]	; 023062A0
	ldr r1,[pool_023062C4]	; 023062A2
	strh r0,[r1,#0x0]	; 023062A4
	ldr r1,[r3,#0x0]	; 023062A6
	ldr r0,[pool_023062C8]	; 023062A8
	ldrh r0,[r1,r0]	; 023062AA
	bl loc_02305D60	; 023062AC
	mov r0,#0x0	; 023062B0
loc_023062B2:
	add sp,#0x4	; 023062B2
	pop {r3}	; 023062B4
	bx r3	; 023062B6
pool_023062B8:
loc_023062B8:
	.word 0x000003E8	; 023062B8
pool_023062BC:
loc_023062BC:
	.word FirmwareWlWorkPointerSlot	; 023062BC
pool_023062C0:
loc_023062C0:
	.word 0x00000386	; 023062C0
pool_023062C4:
loc_023062C4:
	.word REG_WIFI_BEACONINT	; 023062C4
pool_023062C8:
loc_023062C8:
	.word 0x0000030C	; 023062C8
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x06, 0x1C, 0x0F, 0x1C, 0x2A, 0x48, 0x00, 0x68, 0x2A, 0x49, 0x44, 0x18	; 023062DC
	.byte 0x00, 0x21, 0x00, 0x91, 0x20, 0x2E, 0x01, 0xD9, 0x05, 0x20, 0x47, 0xE0, 0x21, 0x89, 0x40, 0x29	; 023062EC
	.byte 0x0F, 0xD1, 0x26, 0x49, 0x40, 0x5A, 0x01, 0x28, 0x0B, 0xD1, 0xE0, 0x8B, 0xB0, 0x42, 0x01, 0xD0	; 023062FC
	.byte 0x06, 0x20, 0x3B, 0xE0, 0x20, 0x1C, 0x92, 0x30, 0x00, 0x88, 0x00, 0x28, 0x01, 0xD0, 0x01, 0x20	; 0230630C
	.byte 0x00, 0x90, 0x00, 0x25, 0x0A, 0xE0, 0x38, 0x1C, 0xFE, 0xF7, 0x34, 0xFF, 0x01, 0x1C, 0x20, 0x1C	; 0230631C
	.byte 0x20, 0x30, 0x40, 0x19, 0xFE, 0xF7, 0x40, 0xFF, 0x7F, 0x1C, 0x6D, 0x1C, 0xB5, 0x42, 0xF2, 0xD3	; 0230632C
	.byte 0x00, 0x27, 0x06, 0xE0, 0x20, 0x1C, 0x20, 0x30, 0x40, 0x19, 0x39, 0x1C, 0xFE, 0xF7, 0x34, 0xFF	; 0230633C
	.byte 0x6D, 0x1C, 0x20, 0x2D, 0xF6, 0xD3, 0xE6, 0x83, 0x00, 0x98, 0x00, 0x28, 0x15, 0xD0, 0x0D, 0x48	; 0230634C
	.byte 0x01, 0x68, 0x0F, 0x48, 0x09, 0x58, 0x26, 0x31, 0x20, 0x1C, 0x92, 0x30, 0x00, 0x88, 0x0F, 0x18	; 0230635C
	.byte 0x00, 0x25, 0x20, 0x34, 0x07, 0xE0, 0x60, 0x19, 0xFE, 0xF7, 0x0C, 0xFF, 0x01, 0x1C, 0x78, 0x19	; 0230636C
	.byte 0xFE, 0xF7, 0x1A, 0xFF, 0x6D, 0x1C, 0xB5, 0x42, 0xF5, 0xD3, 0x00, 0x20, 0x01, 0xB0, 0xF0, 0xBC	; 0230637C
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0x02, 0x03, 0x00, 0x00	; 0230638C
	.byte 0x80, 0x04, 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C, 0x0F, 0x48, 0x01, 0x68, 0x0F, 0x48, 0x08, 0x18	; 0230639C
	.byte 0x21, 0x1C, 0xFF, 0xF7, 0xED, 0xFB, 0x0E, 0x48, 0x21, 0x1C, 0xFF, 0xF7, 0xE9, 0xFB, 0x21, 0x88	; 023063AC
	.byte 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x05, 0xD0, 0x0A, 0x4A, 0x11, 0x88, 0x0A, 0x48, 0x01, 0x40	; 023063BC
	.byte 0x11, 0x80, 0x04, 0xE0, 0x07, 0x4A, 0x11, 0x88, 0x08, 0x48, 0x01, 0x43, 0x11, 0x80, 0x00, 0x20	; 023063CC
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x7C, 0x03, 0x00, 0x00	; 023063DC
	.byte 0x20, 0x80, 0x80, 0x04, 0xD0, 0x80, 0x80, 0x04, 0xFF, 0xFB, 0xFF, 0xFF, 0x00, 0x04, 0x00, 0x00	; 023063EC

; ===== function loc_023063EC =====
loc_023063EC:
	cmp r0,#0x1	; 023063EC
	bls loc_023063F4	; 023063EE
	mov r0,#0x5	; 023063F0
	bx lr	; 023063F2
loc_023063F4:
	ldr r1,[pool_02306414]	; 023063F4
	ldr r2,[r1,#0x0]	; 023063F6
	ldr r1,[pool_02306418]	; 023063F8
	add r2,r2,r1	; 023063FA
	ldrh r3,[r2,#0x0]	; 023063FC
	mov r1,#0x40	; 023063FE
	bic r3,r1	; 02306400
	lsl r0,r0,#0x10	; 02306402
	lsr r1,r0,#0x10	; 02306404
	mov r0,#0x1	; 02306406
	and r1,r0	; 02306408
	lsl r0,r1,#0x6	; 0230640A
	orr r3,r0	; 0230640C
	strh r3,[r2,#0x0]	; 0230640E
	mov r0,#0x0	; 02306410
	bx lr	; 02306412
pool_02306414:
loc_02306414:
	.word FirmwareWlWorkPointerSlot	; 02306414
pool_02306418:
loc_02306418:
	.word 0x0000030E	; 02306418

; ===== function loc_0230641C =====
loc_0230641C:
	push {r4,r5,lr}	; 0230641C
	sub sp,#0x4	; 0230641E
	cmp r0,#0x1	; 02306420
	bhi loc_02306428	; 02306422
	cmp r1,#0x1	; 02306424
	bls loc_0230642C	; 02306426
loc_02306428:
	mov r0,#0x5	; 02306428
	b loc_023064A0	; 0230642A
loc_0230642C:
	cmp r0,#0x0	; 0230642C
	beq loc_02306436	; 0230642E
	cmp r0,#0x1	; 02306430
	beq loc_02306454	; 02306432
	b loc_02306470	; 02306434
loc_02306436:
	ldr r2,[pool_023064A8]	; 02306436
	ldr r3,[r2,#0x0]	; 02306438
	ldr r2,[pool_023064AC]	; 0230643A
	add r4,r3,r2	; 0230643C
	ldrh r2,[r4,#0x0]	; 0230643E
	mov r3,#0x20	; 02306440
	bic r2,r3	; 02306442
	lsl r1,r1,#0x10	; 02306444
	lsr r3,r1,#0x10	; 02306446
	mov r1,#0x1	; 02306448
	and r3,r1	; 0230644A
	lsl r1,r3,#0x5	; 0230644C
	orr r2,r1	; 0230644E
	strh r2,[r4,#0x0]	; 02306450
	b loc_02306470	; 02306452
loc_02306454:
	ldr r1,[pool_023064A8]	; 02306454
	ldr r2,[r1,#0x0]	; 02306456
	ldr r1,[pool_023064B0]	; 02306458
	ldrh r1,[r2,r1]	; 0230645A
	cmp r1,#0x1	; 0230645C
	beq loc_02306464	; 0230645E
	mov r0,#0xb	; 02306460
	b loc_023064A0	; 02306462
loc_02306464:
	ldr r1,[pool_023064AC]	; 02306464
	add r2,r2,r1	; 02306466
	ldrh r3,[r2,#0x0]	; 02306468
	mov r1,#0x20	; 0230646A
	bic r3,r1	; 0230646C
	strh r3,[r2,#0x0]	; 0230646E
loc_02306470:
	ldr r2,[pool_023064A8]	; 02306470
	ldr r1,[r2,#0x0]	; 02306472
	ldr r5,[pool_023064AC]	; 02306474
	add r4,r1,r5	; 02306476
	ldrh r1,[r4,#0x0]	; 02306478
	mov r3,#0x10	; 0230647A
	bic r1,r3	; 0230647C
	lsl r0,r0,#0x10	; 0230647E
	lsr r3,r0,#0x10	; 02306480
	mov r0,#0x1	; 02306482
	and r3,r0	; 02306484
	lsl r0,r3,#0x4	; 02306486
	orr r1,r0	; 02306488
	strh r1,[r4,#0x0]	; 0230648A
	ldr r0,[r2,#0x0]	; 0230648C
	ldrh r0,[r0,r5]	; 0230648E
	lsl r1,r0,#0x1a	; 02306490
	lsr r1,r1,#0x1f	; 02306492
	lsl r0,r0,#0x1c	; 02306494
	lsr r0,r0,#0x1f	; 02306496
	eor r1,r0	; 02306498
	ldr r0,[pool_023064B4]	; 0230649A
	strh r1,[r0,#0x0]	; 0230649C
	mov r0,#0x0	; 0230649E
loc_023064A0:
	add sp,#0x4	; 023064A0
	pop {r4,r5}	; 023064A2
	pop {r3}	; 023064A4
	bx r3	; 023064A6
pool_023064A8:
loc_023064A8:
	.word FirmwareWlWorkPointerSlot	; 023064A8
pool_023064AC:
loc_023064AC:
	.word 0x0000030E	; 023064AC
pool_023064B0:
loc_023064B0:
	.word 0x00000302	; 023064B0
pool_023064B4:
loc_023064B4:
	.word REG_WIFI_UNKNOWN_290	; 023064B4

; ===== function loc_023064B8 =====
loc_023064B8:
	push {r4,r5,lr}	; 023064B8
	sub sp,#0x4	; 023064BA
	cmp r0,#0x1	; 023064BC
	bls loc_023064C4	; 023064BE
	mov r0,#0x5	; 023064C0
	b loc_023064F4	; 023064C2
loc_023064C4:
	ldr r2,[pool_023064FC]	; 023064C4
	ldr r1,[r2,#0x0]	; 023064C6
	ldr r5,[pool_02306500]	; 023064C8
	add r4,r1,r5	; 023064CA
	ldrh r1,[r4,#0x0]	; 023064CC
	mov r3,#0x8	; 023064CE
	bic r1,r3	; 023064D0
	lsl r0,r0,#0x10	; 023064D2
	lsr r3,r0,#0x10	; 023064D4
	mov r0,#0x1	; 023064D6
	and r3,r0	; 023064D8
	lsl r0,r3,#0x3	; 023064DA
	orr r1,r0	; 023064DC
	strh r1,[r4,#0x0]	; 023064DE
	ldr r0,[r2,#0x0]	; 023064E0
	ldrh r0,[r0,r5]	; 023064E2
	lsl r1,r0,#0x1a	; 023064E4
	lsr r1,r1,#0x1f	; 023064E6
	lsl r0,r0,#0x1c	; 023064E8
	lsr r0,r0,#0x1f	; 023064EA
	eor r1,r0	; 023064EC
	ldr r0,[pool_02306504]	; 023064EE
	strh r1,[r0,#0x0]	; 023064F0
	mov r0,#0x0	; 023064F2
loc_023064F4:
	add sp,#0x4	; 023064F4
	pop {r4,r5}	; 023064F6
	pop {r3}	; 023064F8
	bx r3	; 023064FA
pool_023064FC:
loc_023064FC:
	.word FirmwareWlWorkPointerSlot	; 023064FC
pool_02306500:
loc_02306500:
	.word 0x0000030E	; 02306500
pool_02306504:
loc_02306504:
	.word REG_WIFI_UNKNOWN_290	; 02306504

; ===== function loc_02306508 =====
loc_02306508:
	push {r4,lr}	; 02306508
	add r2,r0,#0x0	; 0230650A
	add r4,r1,#0x0	; 0230650C
	cmp r2,#0x3	; 0230650E
	bls loc_02306516	; 02306510
	mov r0,#0x5	; 02306512
	b loc_02306530	; 02306514
loc_02306516:
	cmp r4,#0x3f	; 02306516
	bls loc_0230651E	; 02306518
	mov r0,#0x5	; 0230651A
	b loc_02306530	; 0230651C
loc_0230651E:
	mov r0,#0x13	; 0230651E
	add r1,r2,#0x0	; 02306520
	bl loc_02305788	; 02306522
	mov r0,#0x35	; 02306526
	add r1,r4,#0x0	; 02306528
	bl loc_02305788	; 0230652A
	mov r0,#0x0	; 0230652E
loc_02306530:
	pop {r4}	; 02306530
	pop {r3}	; 02306532
	bx r3	; 02306534
	.byte 0x00, 0x00	; 02306538

; ===== function loc_02306538 =====
loc_02306538:
	cmp r0,#0x1	; 02306538
	bls loc_02306540	; 0230653A
	mov r0,#0x5	; 0230653C
	bx lr	; 0230653E
loc_02306540:
	ldr r1,[pool_0230654C]	; 02306540
	ldr r2,[r1,#0x0]	; 02306542
	ldr r1,[pool_02306550]	; 02306544
	strh r0,[r2,r1]	; 02306546
	mov r0,#0x0	; 02306548
	bx lr	; 0230654A
pool_0230654C:
loc_0230654C:
	.word FirmwareWlWorkPointerSlot	; 0230654C
pool_02306550:
loc_02306550:
	.word 0x00000306	; 02306550

; ===== function loc_02306554 =====
loc_02306554:
	push {r4,r5,lr}	; 02306554
	sub sp,#0x4	; 02306556
	ldr r1,[pool_023065E8]	; 02306558
	ldr r3,[r1,#0x0]	; 0230655A
	ldr r1,[pool_023065EC]	; 0230655C
	add r2,r3,r1	; 0230655E
	cmp r0,#0x1	; 02306560
	bls loc_02306568	; 02306562
	mov r0,#0x5	; 02306564
	b loc_023065E0	; 02306566
loc_02306568:
	ldr r1,[pool_023065F0]	; 02306568
	add r4,r3,r1	; 0230656A
	ldrh r1,[r4,#0x0]	; 0230656C
	mov r3,#0x4	; 0230656E
	bic r1,r3	; 02306570
	mov r3,#0x1	; 02306572
	add r5,r0,#0x0	; 02306574
	and r5,r3	; 02306576
	lsl r3,r5,#0x2	; 02306578
	orr r1,r3	; 0230657A
	strh r1,[r4,#0x0]	; 0230657C
	cmp r0,#0x0	; 0230657E
	bne loc_02306594	; 02306580
	add r1,r2,#0x0	; 02306582
	add r1,#0x7c	; 02306584
	ldrh r3,[r1,#0x0]	; 02306586
	mov r1,#0x20	; 02306588
	bic r3,r1	; 0230658A
	add r1,r2,#0x0	; 0230658C
	add r1,#0x7c	; 0230658E
	strh r3,[r1,#0x0]	; 02306590
	b loc_023065A4	; 02306592
loc_02306594:
	add r1,r2,#0x0	; 02306594
	add r1,#0x7c	; 02306596
	ldrh r3,[r1,#0x0]	; 02306598
	mov r1,#0x20	; 0230659A
	orr r3,r1	; 0230659C
	add r1,r2,#0x0	; 0230659E
	add r1,#0x7c	; 023065A0
	strh r3,[r1,#0x0]	; 023065A2
loc_023065A4:
	ldrh r1,[r2,#0x8]	; 023065A4
	cmp r1,#0x40	; 023065A6
	bne loc_023065C0	; 023065A8
	ldr r1,[pool_023065E8]	; 023065AA
	ldr r3,[r1,#0x0]	; 023065AC
	ldr r1,[pool_023065F4]	; 023065AE
	ldrh r1,[r3,r1]	; 023065B0
	cmp r1,#0x1	; 023065B2
	bne loc_023065C0	; 023065B4
	add r2,#0x7c	; 023065B6
	ldrh r2,[r2,#0x0]	; 023065B8
	ldr r1,[pool_023065F8]	; 023065BA
	ldr r1,[r3,r1]	; 023065BC
	strh r2,[r1,#0x2e]	; 023065BE
loc_023065C0:
	cmp r0,#0x0	; 023065C0
	bne loc_023065D0	; 023065C2
	ldr r2,[pool_023065FC]	; 023065C4
	ldrh r1,[r2,#0x0]	; 023065C6
	mov r0,#0x6	; 023065C8
	bic r1,r0	; 023065CA
	strh r1,[r2,#0x0]	; 023065CC
	b loc_023065DA	; 023065CE
loc_023065D0:
	ldr r2,[pool_023065FC]	; 023065D0
	ldrh r1,[r2,#0x0]	; 023065D2
	mov r0,#0x6	; 023065D4
	orr r1,r0	; 023065D6
	strh r1,[r2,#0x0]	; 023065D8
loc_023065DA:
	bl loc_02305F00	; 023065DA
	mov r0,#0x0	; 023065DE
loc_023065E0:
	add sp,#0x4	; 023065E0
	pop {r4,r5}	; 023065E2
	pop {r3}	; 023065E4
	bx r3	; 023065E6
pool_023065E8:
loc_023065E8:
	.word FirmwareWlWorkPointerSlot	; 023065E8
pool_023065EC:
loc_023065EC:
	.word 0x00000318	; 023065EC
pool_023065F0:
loc_023065F0:
	.word 0x0000030E	; 023065F0
pool_023065F4:
loc_023065F4:
	.word 0x00000302	; 023065F4
pool_023065F8:
loc_023065F8:
	.word 0x00000480	; 023065F8
pool_023065FC:
loc_023065FC:
	.word REG_WIFI_PREAMBLE	; 023065FC

; ===== function loc_02306600 =====
loc_02306600:
	ldr r1,[pool_0230661C]	; 02306600
	ldr r2,[r1,#0x0]	; 02306602
	ldr r1,[pool_02306620]	; 02306604
	add r2,r2,r1	; 02306606
	mov r3,#0x0	; 02306608
loc_0230660A:
	ldrh r1,[r0,#0x0]	; 0230660A
	add r0,r0,#0x2	; 0230660C
	strh r1,[r2,#0x0]	; 0230660E
	add r2,r2,#0x2	; 02306610
	add r3,r3,#0x1	; 02306612
	cmp r3,#0x10	; 02306614
	bcc loc_0230660A	; 02306616
	mov r0,#0x0	; 02306618
	bx lr	; 0230661A
pool_0230661C:
loc_0230661C:
	.word FirmwareWlWorkPointerSlot	; 0230661C
pool_02306620:
loc_02306620:
	.word 0x00000358	; 02306620

; ===== function loc_02306624 =====
loc_02306624:
	push {r4,r5,lr}	; 02306624
	sub sp,#0x4	; 02306626
	add r5,r0,#0x0	; 02306628
	cmp r5,#0xa	; 0230662A
	bcs loc_02306632	; 0230662C
	mov r0,#0x5	; 0230662E
	b loc_0230668E	; 02306630
loc_02306632:
	ldr r0,[pool_02306698]	; 02306632
	ldr r2,[r0,#0x0]	; 02306634
	ldr r0,[pool_0230669C]	; 02306636
	strh r5,[r2,r0]	; 02306638
	cmp r1,#0x0	; 0230663A
	beq loc_02306642	; 0230663C
	ldr r0,[pool_023066A0]	; 0230663E
	strh r5,[r0,#0x0]	; 02306640
loc_02306642:
	ldr r0,[pool_02306698]	; 02306642
	ldr r0,[r0,#0x0]	; 02306644
	ldr r1,[pool_023066A4]	; 02306646
	ldrh r1,[r0,r1]	; 02306648
	cmp r1,#0x0	; 0230664A
	beq loc_0230668C	; 0230664C
	ldr r1,[pool_023066A8]	; 0230664E
	ldr r2,[r0,r1]	; 02306650
	add r2,#0x24	; 02306652
	ldr r1,[pool_023066AC]	; 02306654
	ldrh r1,[r0,r1]	; 02306656
	add r1,r2,r1	; 02306658
	add r4,r1,#0x6	; 0230665A
	ldr r1,[pool_023066B0]	; 0230665C
	ldrh r0,[r0,r1]	; 0230665E
	cmp r0,#0x1	; 02306660
	bne loc_0230667C	; 02306662
	add r0,r4,#0x0	; 02306664
	lsl r1,r5,#0x18	; 02306666
	lsr r1,r1,#0x18	; 02306668
	bl loc_023051A4	; 0230666A
	add r0,r4,#0x1	; 0230666E
	asr r1,r5,#0x8	; 02306670
	lsl r1,r1,#0x18	; 02306672
	lsr r1,r1,#0x18	; 02306674
	bl loc_023051A4	; 02306676
	b loc_0230668C	; 0230667A
loc_0230667C:
	add r0,r4,#0x0	; 0230667C
	mov r1,#0xff	; 0230667E
	bl loc_023051A4	; 02306680
	add r0,r4,#0x1	; 02306684
	mov r1,#0xff	; 02306686
	bl loc_023051A4	; 02306688
loc_0230668C:
	mov r0,#0x0	; 0230668C
loc_0230668E:
	add sp,#0x4	; 0230668E
	pop {r4,r5}	; 02306690
	pop {r3}	; 02306692
	bx r3	; 02306694
	.byte 0xC0, 0x46	; 02306698
pool_02306698:
loc_02306698:
	.word FirmwareWlWorkPointerSlot	; 02306698
pool_0230669C:
loc_0230669C:
	.word 0x00000310	; 0230669C
pool_023066A0:
loc_023066A0:
	.word REG_WIFI_POST_BEACON	; 023066A0
pool_023066A4:
loc_023066A4:
	.word 0x00000478	; 023066A4
pool_023066A8:
loc_023066A8:
	.word 0x00000480	; 023066A8
pool_023066AC:
loc_023066AC:
	.word 0x000003AE	; 023066AC
pool_023066B0:
loc_023066B0:
	.word 0x00000326	; 023066B0

; ===== function loc_023066B4 =====
loc_023066B4:
	push {r4,lr}	; 023066B4
	cmp r0,#0xff	; 023066B6
	bls loc_023066BE	; 023066B8
	mov r0,#0x5	; 023066BA
	b loc_023066D0	; 023066BC
loc_023066BE:
	mov r4,#0x0	; 023066BE
	ldr r3,[pool_023066D8]	; 023066C0
	ldr r2,[r3,#0x0]	; 023066C2
	ldr r1,[pool_023066DC]	; 023066C4
	strh r4,[r2,r1]	; 023066C6
	ldr r2,[r3,#0x0]	; 023066C8
	ldr r1,[pool_023066E0]	; 023066CA
	strh r0,[r2,r1]	; 023066CC
	add r0,r4,#0x0	; 023066CE
loc_023066D0:
	pop {r4}	; 023066D0
	pop {r3}	; 023066D2
	bx r3	; 023066D4
	.byte 0xC0, 0x46	; 023066D8
pool_023066D8:
loc_023066D8:
	.word FirmwareWlWorkPointerSlot	; 023066D8
pool_023066DC:
loc_023066DC:
	.word 0x00000398	; 023066DC
pool_023066E0:
loc_023066E0:
	.word 0x00000396	; 023066E0

; ===== function loc_023066E4 =====
loc_023066E4:
	cmp r0,#0x1	; 023066E4
	bls loc_023066EC	; 023066E6
	mov r0,#0x5	; 023066E8
	bx lr	; 023066EA
loc_023066EC:
	ldr r1,[pool_02306708]	; 023066EC
	ldr r2,[r1,#0x0]	; 023066EE
	ldr r1,[pool_0230670C]	; 023066F0
	add r2,r2,r1	; 023066F2
	ldrh r3,[r2,#0x0]	; 023066F4
	mov r1,#0x2	; 023066F6
	bic r3,r1	; 023066F8
	mov r1,#0x1	; 023066FA
	and r0,r1	; 023066FC
	lsl r0,r0,#0x1	; 023066FE
	orr r3,r0	; 02306700
	strh r3,[r2,#0x0]	; 02306702
	mov r0,#0x0	; 02306704
	bx lr	; 02306706
pool_02306708:
loc_02306708:
	.word FirmwareWlWorkPointerSlot	; 02306708
pool_0230670C:
loc_0230670C:
	.word 0x0000030E	; 0230670C

; ===== function loc_02306710 =====
loc_02306710:
	cmp r0,#0x1	; 02306710
	bls loc_02306718	; 02306712
	mov r0,#0x5	; 02306714
	bx lr	; 02306716
loc_02306718:
	ldr r1,[pool_02306730]	; 02306718
	ldr r2,[r1,#0x0]	; 0230671A
	ldr r1,[pool_02306734]	; 0230671C
	add r2,r2,r1	; 0230671E
	ldrh r3,[r2,#0x0]	; 02306720
	mov r1,#0x1	; 02306722
	bic r3,r1	; 02306724
	and r0,r1	; 02306726
	orr r3,r0	; 02306728
	strh r3,[r2,#0x0]	; 0230672A
	mov r0,#0x0	; 0230672C
	bx lr	; 0230672E
pool_02306730:
loc_02306730:
	.word FirmwareWlWorkPointerSlot	; 02306730
pool_02306734:
loc_02306734:
	.word 0x0000030E	; 02306734

; ===== function loc_02306738 =====
loc_02306738:
	push {r4,lr}	; 02306738
	add r4,r0,#0x0	; 0230673A
	ldr r0,[pool_02306774]	; 0230673C
	add r1,r4,#0x0	; 0230673E
	mov r2,#0x14	; 02306740
	bl loc_02305224	; 02306742
	ldr r0,[pool_02306778]	; 02306746
	add r1,r4,#0x0	; 02306748
	add r1,#0x14	; 0230674A
	mov r2,#0x14	; 0230674C
	bl loc_02305224	; 0230674E
	ldr r0,[pool_0230677C]	; 02306752
	add r1,r4,#0x0	; 02306754
	add r1,#0x28	; 02306756
	mov r2,#0x14	; 02306758
	bl loc_02305224	; 0230675A
	ldr r0,[pool_02306780]	; 0230675E
	add r4,#0x3c	; 02306760
	add r1,r4,#0x0	; 02306762
	mov r2,#0x14	; 02306764
	bl loc_02305224	; 02306766
	mov r0,#0x0	; 0230676A
	pop {r4}	; 0230676C
	pop {r3}	; 0230676E
	bx r3	; 02306770
	.byte 0xC0, 0x46	; 02306774
pool_02306774:
loc_02306774:
	.word 0x04805F80	; 02306774
pool_02306778:
loc_02306778:
	.word 0x04805FA0	; 02306778
pool_0230677C:
loc_0230677C:
	.word 0x04805FC0	; 0230677C
pool_02306780:
loc_02306780:
	.word 0x04805FE0	; 02306780

; ===== function loc_02306784 =====
loc_02306784:
	cmp r0,#0x3	; 02306784
	bls loc_0230678C	; 02306786
	mov r0,#0x5	; 02306788
	bx lr	; 0230678A
loc_0230678C:
	ldr r1,[pool_02306798]	; 0230678C
	ldr r2,[r1,#0x0]	; 0230678E
	ldr r1,[pool_0230679C]	; 02306790
	strh r0,[r2,r1]	; 02306792
	mov r0,#0x0	; 02306794
	bx lr	; 02306796
pool_02306798:
loc_02306798:
	.word FirmwareWlWorkPointerSlot	; 02306798
pool_0230679C:
loc_0230679C:
	.word 0x0000030A	; 0230679C

; ===== function loc_023067A0 =====
loc_023067A0:
	ldr r1,[pool_0230682C]	; 023067A0
	ldr r3,[r1,#0x0]	; 023067A2
	ldr r1,[pool_02306830]	; 023067A4
	add r1,r3,r1	; 023067A6
	cmp r0,#0x3	; 023067A8
	bls loc_023067B0	; 023067AA
	mov r0,#0x5	; 023067AC
	bx lr	; 023067AE
loc_023067B0:
	ldr r2,[pool_02306834]	; 023067B0
	strh r0,[r3,r2]	; 023067B2
	cmp r0,#0x0	; 023067B4
	bne loc_023067DA	; 023067B6
	add r2,r1,#0x0	; 023067B8
	add r2,#0x7c	; 023067BA
	ldrh r3,[r2,#0x0]	; 023067BC
	mov r2,#0x10	; 023067BE
	bic r3,r2	; 023067C0
	add r2,r1,#0x0	; 023067C2
	add r2,#0x7c	; 023067C4
	strh r3,[r2,#0x0]	; 023067C6
	add r2,r1,#0x0	; 023067C8
	add r2,#0x8a	; 023067CA
	ldrh r3,[r2,#0x0]	; 023067CC
	ldr r2,[pool_02306838]	; 023067CE
	and r3,r2	; 023067D0
	add r2,r1,#0x0	; 023067D2
	add r2,#0x8a	; 023067D4
	strh r3,[r2,#0x0]	; 023067D6
	b loc_023067FA	; 023067D8
loc_023067DA:
	add r2,r1,#0x0	; 023067DA
	add r2,#0x7c	; 023067DC
	ldrh r3,[r2,#0x0]	; 023067DE
	mov r2,#0x10	; 023067E0
	orr r3,r2	; 023067E2
	add r2,r1,#0x0	; 023067E4
	add r2,#0x7c	; 023067E6
	strh r3,[r2,#0x0]	; 023067E8
	add r2,r1,#0x0	; 023067EA
	add r2,#0x8a	; 023067EC
	ldrh r3,[r2,#0x0]	; 023067EE
	ldr r2,[pool_0230683C]	; 023067F0
	orr r3,r2	; 023067F2
	add r2,r1,#0x0	; 023067F4
	add r2,#0x8a	; 023067F6
	strh r3,[r2,#0x0]	; 023067F8
loc_023067FA:
	ldrh r2,[r1,#0x8]	; 023067FA
	cmp r2,#0x40	; 023067FC
	bne loc_02306812	; 023067FE
	cmp r0,#0x1	; 02306800
	bne loc_02306812	; 02306802
	add r1,#0x7c	; 02306804
	ldrh r3,[r1,#0x0]	; 02306806
	ldr r1,[pool_0230682C]	; 02306808
	ldr r2,[r1,#0x0]	; 0230680A
	ldr r1,[pool_02306840]	; 0230680C
	ldr r1,[r2,r1]	; 0230680E
	strh r3,[r1,#0x2e]	; 02306810
loc_02306812:
	cmp r0,#0x0	; 02306812
	bne loc_02306818	; 02306814
	mov r0,#0x1	; 02306816
loc_02306818:
	ldr r2,[pool_02306844]	; 02306818
	ldrh r3,[r2,#0x0]	; 0230681A
	ldr r1,[pool_02306848]	; 0230681C
	and r3,r1	; 0230681E
	lsl r0,r0,#0x3	; 02306820
	orr r3,r0	; 02306822
	strh r3,[r2,#0x0]	; 02306824
	mov r0,#0x0	; 02306826
	bx lr	; 02306828
	.byte 0xC0, 0x46	; 0230682C
pool_0230682C:
loc_0230682C:
	.word FirmwareWlWorkPointerSlot	; 0230682C
pool_02306830:
loc_02306830:
	.word 0x00000318	; 02306830
pool_02306834:
loc_02306834:
	.word 0x00000308	; 02306834
pool_02306838:
loc_02306838:
	.word 0xFFFFBFFF	; 02306838
pool_0230683C:
loc_0230683C:
	.word 0x00004000	; 0230683C
pool_02306840:
loc_02306840:
	.word 0x00000480	; 02306840
pool_02306844:
loc_02306844:
	.word REG_WIFI_MODE_WEP	; 02306844
pool_02306848:
loc_02306848:
	.word 0x0000FFC7	; 02306848

; ===== function loc_0230684C =====
loc_0230684C:
	push {lr}	; 0230684C
	sub sp,#0x4	; 0230684E
	cmp r0,#0x2	; 02306850
	bhi loc_02306864	; 02306852
	ldr r1,[pool_0230686C]	; 02306854
	ldr r2,[r1,#0x0]	; 02306856
	ldr r1,[pool_02306870]	; 02306858
	strh r0,[r2,r1]	; 0230685A
	bl loc_02305F00	; 0230685C
	mov r0,#0x0	; 02306860
	b loc_02306866	; 02306862
loc_02306864:
	mov r0,#0x5	; 02306864
loc_02306866:
	add sp,#0x4	; 02306866
	pop {r3}	; 02306868
	bx r3	; 0230686A
pool_0230686C:
loc_0230686C:
	.word FirmwareWlWorkPointerSlot	; 0230686C
pool_02306870:
loc_02306870:
	.word 0x00000304	; 02306870

; ===== function loc_02306874 =====
loc_02306874:
	push {r4,lr}	; 02306874
	cmp r0,#0x3	; 02306876
	bls loc_0230687E	; 02306878
	mov r0,#0x5	; 0230687A
	b loc_023068B4	; 0230687C
loc_0230687E:
	ldr r1,[pool_023068BC]	; 0230687E
	ldr r3,[r1,#0x0]	; 02306880
	ldr r2,[pool_023068C0]	; 02306882
	strh r0,[r3,r2]	; 02306884
	ldr r3,[r1,#0x0]	; 02306886
	ldr r2,[pool_023068C4]	; 02306888
	strh r0,[r3,r2]	; 0230688A
	ldr r3,[pool_023068C8]	; 0230688C
	ldrh r4,[r3,#0x0]	; 0230688E
	ldr r2,[pool_023068CC]	; 02306890
	and r4,r2	; 02306892
	orr r4,r0	; 02306894
	strh r4,[r3,#0x0]	; 02306896
	ldr r1,[r1,#0x0]	; 02306898
	ldr r0,[pool_023068D0]	; 0230689A
	ldrh r0,[r1,r0]	; 0230689C
	bl loc_02305EB0	; 0230689E
	ldr r0,[pool_023068BC]	; 023068A2
	ldr r1,[r0,#0x0]	; 023068A4
	ldr r0,[pool_023068D4]	; 023068A6
	add r1,r1,r0	; 023068A8
	ldr r2,[r1,#0x0]	; 023068AA
	mov r0,#0x8	; 023068AC
	orr r2,r0	; 023068AE
	str r2,[r1,#0x0]	; 023068B0
	mov r0,#0x0	; 023068B2
loc_023068B4:
	pop {r4}	; 023068B4
	pop {r3}	; 023068B6
	bx r3	; 023068B8
	.byte 0xC0, 0x46	; 023068BC
pool_023068BC:
loc_023068BC:
	.word FirmwareWlWorkPointerSlot	; 023068BC
pool_023068C0:
loc_023068C0:
	.word 0x00000302	; 023068C0
pool_023068C4:
loc_023068C4:
	.word 0x00000324	; 023068C4
pool_023068C8:
loc_023068C8:
	.word REG_WIFI_MODE_WEP	; 023068C8
pool_023068CC:
loc_023068CC:
	.word 0x0000FFF8	; 023068CC
pool_023068D0:
loc_023068D0:
	.word 0x00000326	; 023068D0
pool_023068D4:
loc_023068D4:
	.word 0x00000314	; 023068D4

; ===== function loc_023068D8 =====
loc_023068D8:
	ldr r1,[pool_02306900]	; 023068D8
	add r2,r0,#0x0	; 023068DA
	and r2,r1	; 023068DC
	cmp r2,#0x0	; 023068DE
	bne loc_023068E6	; 023068E0
	mov r0,#0x5	; 023068E2
	bx lr	; 023068E4
loc_023068E6:
	ldr r3,[pool_02306904]	; 023068E6
	ldr r2,[r3,#0x0]	; 023068E8
	ldr r1,[pool_02306908]	; 023068EA
	strh r0,[r2,r1]	; 023068EC
	ldr r1,[r3,#0x0]	; 023068EE
	ldr r0,[pool_0230690C]	; 023068F0
	add r1,r1,r0	; 023068F2
	ldr r2,[r1,#0x0]	; 023068F4
	mov r0,#0x4	; 023068F6
	orr r2,r0	; 023068F8
	str r2,[r1,#0x0]	; 023068FA
	mov r0,#0x0	; 023068FC
	bx lr	; 023068FE
pool_02306900:
loc_02306900:
	.word 0x00007FFE	; 02306900
pool_02306904:
loc_02306904:
	.word FirmwareWlWorkPointerSlot	; 02306904
pool_02306908:
loc_02306908:
	.word 0x00000300	; 02306908
pool_0230690C:
loc_0230690C:
	.word 0x00000314	; 0230690C

; ===== function loc_02306910 =====
loc_02306910:
	cmp r0,#0xff	; 02306910
	bls loc_02306918	; 02306912
	mov r0,#0x5	; 02306914
	bx lr	; 02306916
loc_02306918:
	ldr r1,[pool_02306928]	; 02306918
	ldr r2,[r1,#0x0]	; 0230691A
	ldr r1,[pool_0230692C]	; 0230691C
	strh r0,[r2,r1]	; 0230691E
	ldr r1,[pool_02306930]	; 02306920
	strh r0,[r1,#0x0]	; 02306922
	mov r0,#0x0	; 02306924
	bx lr	; 02306926
pool_02306928:
loc_02306928:
	.word FirmwareWlWorkPointerSlot	; 02306928
pool_0230692C:
loc_0230692C:
	.word 0x000002FE	; 0230692C
pool_02306930:
loc_02306930:
	.word REG_WIFI_TX_RETRYLIMIT	; 02306930

; ===== function loc_02306934 =====
loc_02306934:
	push {r4,lr}	; 02306934
	add r4,r0,#0x0	; 02306936
	ldrh r1,[r4,#0x0]	; 02306938
	mov r0,#0x1	; 0230693A
	and r1,r0	; 0230693C
	cmp r1,#0x0	; 0230693E
	beq loc_02306946	; 02306940
	mov r0,#0x5	; 02306942
	b loc_0230696E	; 02306944
loc_02306946:
	ldr r0,[pool_02306974]	; 02306946
	ldr r1,[r0,#0x0]	; 02306948
	ldr r0,[pool_02306978]	; 0230694A
	add r0,r1,r0	; 0230694C
	add r1,r4,#0x0	; 0230694E
	bl loc_02305B7C	; 02306950
	ldr r0,[pool_0230697C]	; 02306954
	add r1,r4,#0x0	; 02306956
	bl loc_02305B7C	; 02306958
	ldr r0,[pool_02306974]	; 0230695C
	ldr r1,[r0,#0x0]	; 0230695E
	ldr r0,[pool_02306980]	; 02306960
	add r1,r1,r0	; 02306962
	ldr r2,[r1,#0x0]	; 02306964
	mov r0,#0x2	; 02306966
	orr r2,r0	; 02306968
	str r2,[r1,#0x0]	; 0230696A
	mov r0,#0x0	; 0230696C
loc_0230696E:
	pop {r4}	; 0230696E
	pop {r3}	; 02306970
	bx r3	; 02306972
pool_02306974:
loc_02306974:
	.word FirmwareWlWorkPointerSlot	; 02306974
pool_02306978:
loc_02306978:
	.word 0x000002F8	; 02306978
pool_0230697C:
loc_0230697C:
	.word 0x04808018	; 0230697C
pool_02306980:
loc_02306980:
	.word 0x00000314	; 02306980

; ===== function loc_02306984 =====
loc_02306984:
	push {r4,r5,r6,lr}	; 02306984
	sub sp,#0x8	; 02306986
	add r5,r0,#0x0	; 02306988
	add r6,r1,#0x0	; 0230698A
	ldr r0,[pool_023069E4]	; 0230698C
	ldr r1,[r0,#0x0]	; 0230698E
	ldr r0,[pool_023069E8]	; 02306990
	ldr r4,[r1,r0]	; 02306992
	mov r2,#0x0	; 02306994
	add r0,sp,#0x0	; 02306996
	strh r2,[r0,#0x0]	; 02306998
	ldrh r0,[r0,#0x0]	; 0230699A
	ldr r2,[pool_023069EC]	; 0230699C
	add r1,r1,r2	; 0230699E
	mov r2,#0x28	; 023069A0
	bl loc_023069FC	; 023069A2
	mov r1,#0x0	; 023069A6
	add r0,sp,#0x0	; 023069A8
	strh r1,[r0,#0x2]	; 023069AA
	ldrh r0,[r0,#0x2]	; 023069AC
	ldr r1,[pool_023069E4]	; 023069AE
	ldr r2,[r1,#0x0]	; 023069B0
	ldr r1,[pool_023069F0]	; 023069B2
	add r1,r2,r1	; 023069B4
	mov r2,#0xc0	; 023069B6
	bl loc_02306A08	; 023069B8
	ldr r0,[pool_023069E4]	; 023069BC
	ldr r2,[r0,#0x0]	; 023069BE
	ldr r1,[pool_023069EC]	; 023069C0
	str r5,[r2,r1]	; 023069C2
	lsl r1,r6,#0x10	; 023069C4
	lsr r3,r1,#0x10	; 023069C6
	ldr r2,[r0,#0x0]	; 023069C8
	ldr r1,[pool_023069F4]	; 023069CA
	strh r3,[r2,r1]	; 023069CC
	ldr r2,[r0,#0x0]	; 023069CE
	ldr r1,[pool_023069F8]	; 023069D0
	strh r3,[r2,r1]	; 023069D2
	ldr r1,[r0,#0x0]	; 023069D4
	ldr r0,[pool_023069E8]	; 023069D6
	str r4,[r1,r0]	; 023069D8
	add sp,#0x8	; 023069DA
	pop {r4,r5,r6}	; 023069DC
	pop {r3}	; 023069DE
	bx r3	; 023069E0
	.byte 0xC0, 0x46	; 023069E4
pool_023069E4:
loc_023069E4:
	.word FirmwareWlWorkPointerSlot	; 023069E4
pool_023069E8:
loc_023069E8:
	.word 0x000003B4	; 023069E8
pool_023069EC:
loc_023069EC:
	.word 0x000002F0	; 023069EC
pool_023069F0:
loc_023069F0:
	.word 0x00000318	; 023069F0
pool_023069F4:
loc_023069F4:
	.word 0x000002F4	; 023069F4
pool_023069F8:
loc_023069F8:
	.word 0x000002F6	; 023069F8

; ===== function loc_023069FC =====
loc_023069FC:
	bx pc	; 023069FC
	.byte 0xC0, 0x46	; 02306A00
.arm

; ===== function loc_02306A00 =====
loc_02306A00:
	ldr pc,[pool_02306A04]	; 02306A00
pool_02306A04:
loc_02306A04:
	.word loc_037FF31C	; 02306A04
.thumb

; ===== function loc_02306A08 =====
loc_02306A08:
	bx pc	; 02306A08
	.byte 0xC0, 0x46	; 02306A0C
.arm

; ===== function loc_02306A0C =====
loc_02306A0C:
	ldr pc,[pool_02306A10]	; 02306A0C
pool_02306A10:
loc_02306A10:
	.word loc_037FF31C	; 02306A10
.thumb

; ===== function loc_02306A14 =====
loc_02306A14:
	push {r4,r5,r6,r7,lr}	; 02306A14
	sub sp,#0x4	; 02306A16
	mov r7,#0x0	; 02306A18
	ldr r0,[pool_02306A9C]	; 02306A1A
	ldr r1,[r0,#0x0]	; 02306A1C
	ldr r0,[pool_02306AA0]	; 02306A1E
	ldrh r0,[r1,r0]	; 02306A20
	cmp r0,#0x5	; 02306A22
	bne loc_02306A2C	; 02306A24
	ldr r0,[pool_02306AA4]	; 02306A26
	str r0,[sp,#0x0]	; 02306A28
	b loc_02306A30	; 02306A2A
loc_02306A2C:
	ldr r0,[pool_02306AA8]	; 02306A2C
	str r0,[sp,#0x0]	; 02306A2E
loc_02306A30:
	mov r4,#0xff	; 02306A30
	mov r5,#0x0	; 02306A32
loc_02306A34:
	add r0,r5,#0x0	; 02306A34
	add r1,r4,#0x0	; 02306A36
	bl loc_02305788	; 02306A38
	add r5,r5,#0x1	; 02306A3C
	sub r0,r4,#0x1	; 02306A3E
	lsl r0,r0,#0x10	; 02306A40
	lsr r4,r0,#0x10	; 02306A42
	cmp r5,#0x69	; 02306A44
	bcc loc_02306A34	; 02306A46
	mov r5,#0xff	; 02306A48
	mov r4,#0x0	; 02306A4A
	add r6,r4,#0x0	; 02306A4C
	b loc_02306A7C	; 02306A4E
loc_02306A50:
	lsl r1,r6,#0x1	; 02306A50
	ldr r0,[sp,#0x0]	; 02306A52
	ldrh r0,[r0,r1]	; 02306A54
	cmp r4,r0	; 02306A56
	bne loc_02306A5E	; 02306A58
	add r6,r6,#0x1	; 02306A5A
	b loc_02306A74	; 02306A5C
loc_02306A5E:
	add r0,r4,#0x0	; 02306A5E
	bl loc_023057BC	; 02306A60
	lsl r0,r0,#0x10	; 02306A64
	lsr r0,r0,#0x10	; 02306A66
	cmp r0,r5	; 02306A68
	beq loc_02306A74	; 02306A6A
	add r0,r7,#0x0	; 02306A6C
	add r7,r7,#0x1	; 02306A6E
	cmp r0,#0x20	; 02306A70
	bhi loc_02306A80	; 02306A72
loc_02306A74:
	add r4,r4,#0x1	; 02306A74
	sub r0,r5,#0x1	; 02306A76
	lsl r0,r0,#0x10	; 02306A78
	lsr r5,r0,#0x10	; 02306A7A
loc_02306A7C:
	cmp r4,#0x69	; 02306A7C
	bcc loc_02306A50	; 02306A7E
loc_02306A80:
	cmp r7,#0x0	; 02306A80
	beq loc_02306A94	; 02306A82
	ldr r0,[pool_02306A9C]	; 02306A84
	ldr r1,[r0,#0x0]	; 02306A86
	ldr r0,[pool_02306AAC]	; 02306A88
	add r1,r1,r0	; 02306A8A
	ldrh r2,[r1,#0x0]	; 02306A8C
	mov r0,#0x8	; 02306A8E
	orr r2,r0	; 02306A90
	strh r2,[r1,#0x0]	; 02306A92
loc_02306A94:
	add sp,#0x4	; 02306A94
	pop {r4,r5,r6,r7}	; 02306A96
	pop {r3}	; 02306A98
	bx r3	; 02306A9A
pool_02306A9C:
loc_02306A9C:
	.word FirmwareWlWorkPointerSlot	; 02306A9C
pool_02306AA0:
loc_02306AA0:
	.word 0x000005CC	; 02306AA0
pool_02306AA4:
loc_02306AA4:
	.word 0x0230D860	; 02306AA4
pool_02306AA8:
loc_02306AA8:
	.word 0x0230D894	; 02306AA8
pool_02306AAC:
loc_02306AAC:
	.word 0x00000312	; 02306AAC

; ===== function loc_02306AB0 =====
loc_02306AB0:
	push {r4,r5,r6,r7,lr}	; 02306AB0
	sub sp,#0xc	; 02306AB2
	str r0,[sp,#0x0]	; 02306AB4
	add r5,r1,#0x0	; 02306AB6
	mov r7,#0x0	; 02306AB8
	ldr r0,[pool_02306BBC]	; 02306ABA
	cmp r5,r0	; 02306ABC
	bcc loc_02306AC2	; 02306ABE
	add r5,r0,#0x0	; 02306AC0
loc_02306AC2:
	ldr r1,[pool_02306BC0]	; 02306AC2
	ldr r0,[pool_02306BC4]	; 02306AC4
	strh r1,[r0,#0x0]	; 02306AC6
	ldr r1,[pool_02306BC8]	; 02306AC8
	ldr r0,[pool_02306BCC]	; 02306ACA
	strh r1,[r0,#0x0]	; 02306ACC
	ldr r1,[pool_02306BD0]	; 02306ACE
	ldr r0,[pool_02306BD4]	; 02306AD0
	strh r1,[r0,#0x0]	; 02306AD2
	ldr r0,[sp,#0x0]	; 02306AD4
	mov r2,#0x0	; 02306AD6
	add r1,r2,#0x0	; 02306AD8
	b loc_02306AEA	; 02306ADA
loc_02306ADC:
	add r3,r2,#0x0	; 02306ADC
	sub r2,r2,#0x1	; 02306ADE
	lsl r2,r2,#0x10	; 02306AE0
	lsr r2,r2,#0x10	; 02306AE2
	strh r3,[r0,#0x0]	; 02306AE4
	add r0,r0,#0x2	; 02306AE6
	add r1,r1,#0x2	; 02306AE8
loc_02306AEA:
	cmp r1,r5	; 02306AEA
	bcc loc_02306ADC	; 02306AEC
	add r6,r5,#0x0	; 02306AEE
	ldr r4,[pool_02306BD8]	; 02306AF0
	b loc_02306B2E	; 02306AF2
loc_02306AF4:
	add r1,r4,r5	; 02306AF4
	ldr r0,[pool_02306BDC]	; 02306AF6
	cmp r1,r0	; 02306AF8
	bls loc_02306AFE	; 02306AFA
	sub r6,r0,r4	; 02306AFC
loc_02306AFE:
	add r0,r4,#0x0	; 02306AFE
	ldr r1,[sp,#0x0]	; 02306B00
	add r2,r6,#0x0	; 02306B02
	bl loc_02305224	; 02306B04
	add r3,r4,#0x0	; 02306B08
	mov r2,#0x0	; 02306B0A
	lsl r1,r2,#0	; 02306B0C
	b loc_02306B28	; 02306B0E
loc_02306B10:
	ldrh r0,[r3,#0x0]	; 02306B10
	cmp r2,r0	; 02306B12
	beq loc_02306B1E	; 02306B14
	add r0,r7,#0x0	; 02306B16
	add r7,r7,#0x1	; 02306B18
	cmp r0,#0x20	; 02306B1A
	bhi loc_02306B9E	; 02306B1C
loc_02306B1E:
	add r1,r1,#0x2	; 02306B1E
	add r3,r3,#0x2	; 02306B20
	sub r0,r2,#0x1	; 02306B22
	lsl r0,r0,#0x10	; 02306B24
	lsr r2,r0,#0x10	; 02306B26
loc_02306B28:
	cmp r1,r6	; 02306B28
	bcc loc_02306B10	; 02306B2A
	add r4,r4,r6	; 02306B2C
loc_02306B2E:
	ldr r0,[pool_02306BDC]	; 02306B2E
	cmp r4,r0	; 02306B30
	bcc loc_02306AF4	; 02306B32
	ldr r1,[pool_02306BD8]	; 02306B34
	mov r3,#0x0	; 02306B36
	add r0,r3,#0x0	; 02306B38
	ldr r4,[pool_02306BBC]	; 02306B3A
loc_02306B3C:
	add r2,r3,#0x0	; 02306B3C
	sub r3,r3,#0x1	; 02306B3E
	lsl r3,r3,#0x10	; 02306B40
	lsr r3,r3,#0x10	; 02306B42
	strh r2,[r1,#0x0]	; 02306B44
	add r1,r1,#0x2	; 02306B46
	add r0,r0,#0x2	; 02306B48
	cmp r0,r4	; 02306B4A
	bcc loc_02306B3C	; 02306B4C
	add r6,r5,#0x0	; 02306B4E
	mov r0,#0x0	; 02306B50
	str r0,[sp,#0x4]	; 02306B52
	ldr r4,[pool_02306BD8]	; 02306B54
	str r0,[sp,#0x8]	; 02306B56
	b loc_02306B98	; 02306B58
loc_02306B5A:
	add r1,r4,r5	; 02306B5A
	ldr r0,[pool_02306BDC]	; 02306B5C
	cmp r1,r0	; 02306B5E
	bls loc_02306B64	; 02306B60
	sub r6,r0,r4	; 02306B62
loc_02306B64:
	ldr r0,[sp,#0x0]	; 02306B64
	add r1,r4,#0x0	; 02306B66
	add r2,r6,#0x0	; 02306B68
	bl loc_023052B4	; 02306B6A
	ldr r2,[sp,#0x0]	; 02306B6E
	ldr r3,[sp,#0x8]	; 02306B70
	b loc_02306B92	; 02306B72
loc_02306B74:
	ldrh r1,[r2,#0x0]	; 02306B74
	ldr r0,[sp,#0x4]	; 02306B76
	cmp r1,r0	; 02306B78
	beq loc_02306B84	; 02306B7A
	add r0,r7,#0x0	; 02306B7C
	add r7,r7,#0x1	; 02306B7E
	cmp r0,#0x20	; 02306B80
	bhi loc_02306B9E	; 02306B82
loc_02306B84:
	add r3,r3,#0x2	; 02306B84
	ldr r0,[sp,#0x4]	; 02306B86
	sub r0,r0,#0x1	; 02306B88
	lsl r0,r0,#0x10	; 02306B8A
	lsr r0,r0,#0x10	; 02306B8C
	str r0,[sp,#0x4]	; 02306B8E
	add r2,r2,#0x2	; 02306B90
loc_02306B92:
	cmp r3,r6	; 02306B92
	bcc loc_02306B74	; 02306B94
	add r4,r4,r6	; 02306B96
loc_02306B98:
	ldr r0,[pool_02306BDC]	; 02306B98
	cmp r4,r0	; 02306B9A
	bcc loc_02306B5A	; 02306B9C
loc_02306B9E:
	cmp r7,#0x0	; 02306B9E
	beq loc_02306BB2	; 02306BA0
	ldr r0,[pool_02306BE0]	; 02306BA2
	ldr r1,[r0,#0x0]	; 02306BA4
	ldr r0,[pool_02306BE4]	; 02306BA6
	add r1,r1,r0	; 02306BA8
	ldrh r2,[r1,#0x0]	; 02306BAA
	mov r0,#0x4	; 02306BAC
	orr r2,r0	; 02306BAE
	strh r2,[r1,#0x0]	; 02306BB0
loc_02306BB2:
	add r0,r7,#0x0	; 02306BB2
	add sp,#0xc	; 02306BB4
	pop {r4,r5,r6,r7}	; 02306BB6
	pop {r3}	; 02306BB8
	bx r3	; 02306BBA
pool_02306BBC:
loc_02306BBC:
	.word 0x00002000	; 02306BBC
pool_02306BC0:
loc_02306BC0:
	.word 0x00004000	; 02306BC0
pool_02306BC4:
loc_02306BC4:
	.word REG_WIFI_RXBUF_BEGIN	; 02306BC4
pool_02306BC8:
loc_02306BC8:
	.word 0x00006000	; 02306BC8
pool_02306BCC:
loc_02306BCC:
	.word REG_WIFI_RXBUF_END	; 02306BCC
pool_02306BD0:
loc_02306BD0:
	.word 0x00005000	; 02306BD0
pool_02306BD4:
loc_02306BD4:
	.word REG_WIFI_RXBUF_GAP	; 02306BD4
pool_02306BD8:
loc_02306BD8:
	.word WifiRamBase	; 02306BD8
pool_02306BDC:
loc_02306BDC:
	.word 0x04806000	; 02306BDC
pool_02306BE0:
loc_02306BE0:
	.word FirmwareWlWorkPointerSlot	; 02306BE0
pool_02306BE4:
loc_02306BE4:
	.word 0x00000312	; 02306BE4

; ===== function loc_02306BE8 =====
loc_02306BE8:
	push {r4,lr}	; 02306BE8
	ldr r0,[pool_02306C30]	; 02306BEA
	ldr r1,[r0,#0x0]	; 02306BEC
	ldr r0,[pool_02306C34]	; 02306BEE
	add r0,r1,r0	; 02306BF0
	ldr r1,[pool_02306C38]	; 02306BF2
	bl loc_02304D60	; 02306BF4
	add r4,r0,#0x0	; 02306BF8
	cmp r4,#0x0	; 02306BFA
	beq loc_02306C28	; 02306BFC
	add r0,#0x10	; 02306BFE
	mov r1,#0xf6	; 02306C00
	bl loc_02306AB0	; 02306C02
	cmp r0,#0x0	; 02306C06
	beq loc_02306C1A	; 02306C08
	ldr r0,[pool_02306C30]	; 02306C0A
	ldr r1,[r0,#0x0]	; 02306C0C
	ldr r0,[pool_02306C34]	; 02306C0E
	add r0,r1,r0	; 02306C10
	add r1,r4,#0x0	; 02306C12
	bl loc_02304C3C	; 02306C14
	b loc_02306C28	; 02306C18
loc_02306C1A:
	ldr r0,[pool_02306C30]	; 02306C1A
	ldr r1,[r0,#0x0]	; 02306C1C
	ldr r0,[pool_02306C34]	; 02306C1E
	add r0,r1,r0	; 02306C20
	add r1,r4,#0x0	; 02306C22
	bl loc_02304C3C	; 02306C24
loc_02306C28:
	pop {r4}	; 02306C28
	pop {r3}	; 02306C2A
	bx r3	; 02306C2C
	.byte 0xC0, 0x46	; 02306C30
pool_02306C30:
loc_02306C30:
	.word FirmwareWlWorkPointerSlot	; 02306C30
pool_02306C34:
loc_02306C34:
	.word 0x0000015C	; 02306C34
pool_02306C38:
loc_02306C38:
	.word 0x00000106	; 02306C38

; ===== function loc_02306C3C =====
loc_02306C3C:
	push {r4,r5,lr}	; 02306C3C
	sub sp,#0x4	; 02306C3E
	mov r0,#0x0	; 02306C40
	ldr r4,[pool_02306CA0]	; 02306C42
	ldr r1,[pool_02306CA4]	; 02306C44
	add r5,r0,#0x0	; 02306C46
	ldr r2,[pool_02306CA8]	; 02306C48
loc_02306C4A:
	add r3,r1,#0x0	; 02306C4A
	sub r1,r1,#0x1	; 02306C4C
	lsl r1,r1,#0x10	; 02306C4E
	lsr r1,r1,#0x10	; 02306C50
	strh r3,[r4,#0x0]	; 02306C52
	add r4,r4,#0x2	; 02306C54
	add r5,r5,#0x2	; 02306C56
	cmp r5,r2	; 02306C58
	bcc loc_02306C4A	; 02306C5A
	ldr r5,[pool_02306CA0]	; 02306C5C
	ldr r4,[pool_02306CA4]	; 02306C5E
	mov r3,#0x0	; 02306C60
	ldr r1,[pool_02306CA8]	; 02306C62
	b loc_02306C7E	; 02306C64
loc_02306C66:
	ldrh r2,[r5,#0x0]	; 02306C66
	cmp r2,r4	; 02306C68
	beq loc_02306C74	; 02306C6A
	add r2,r0,#0x0	; 02306C6C
	add r0,r0,#0x1	; 02306C6E
	cmp r2,#0x20	; 02306C70
	bhi loc_02306C82	; 02306C72
loc_02306C74:
	add r3,r3,#0x2	; 02306C74
	add r5,r5,#0x2	; 02306C76
	sub r2,r4,#0x1	; 02306C78
	lsl r2,r2,#0x10	; 02306C7A
	lsr r4,r2,#0x10	; 02306C7C
loc_02306C7E:
	cmp r3,r1	; 02306C7E
	bcc loc_02306C66	; 02306C80
loc_02306C82:
	cmp r0,#0x0	; 02306C82
	beq loc_02306C96	; 02306C84
	ldr r0,[pool_02306CAC]	; 02306C86
	ldr r1,[r0,#0x0]	; 02306C88
	ldr r0,[pool_02306CB0]	; 02306C8A
	add r1,r1,r0	; 02306C8C
	ldrh r2,[r1,#0x0]	; 02306C8E
	mov r0,#0x2	; 02306C90
	orr r2,r0	; 02306C92
	strh r2,[r1,#0x0]	; 02306C94
loc_02306C96:
	add sp,#0x4	; 02306C96
	pop {r4,r5}	; 02306C98
	pop {r3}	; 02306C9A
	bx r3	; 02306C9C
	.byte 0xC0, 0x46	; 02306CA0
pool_02306CA0:
loc_02306CA0:
	.word WifiRamBase	; 02306CA0
pool_02306CA4:
loc_02306CA4:
	.word 0x0000FFFF	; 02306CA4
pool_02306CA8:
loc_02306CA8:
	.word 0x00002000	; 02306CA8
pool_02306CAC:
loc_02306CAC:
	.word FirmwareWlWorkPointerSlot	; 02306CAC
pool_02306CB0:
loc_02306CB0:
	.word 0x00000312	; 02306CB0

; ===== function loc_02306CB4 =====
loc_02306CB4:
	push {r4,r5,r6,r7,lr}	; 02306CB4
	sub sp,#0x4	; 02306CB6
	mov r5,#0x0	; 02306CB8
	add r2,r5,#0x0	; 02306CBA
	ldr r3,[pool_02306D50]	; 02306CBC
	ldr r1,[pool_02306D54]	; 02306CBE
	add r6,r3,#0x0	; 02306CC0
loc_02306CC2:
	lsl r7,r2,#0x2	; 02306CC2
	add r0,r1,r7	; 02306CC4
	ldrh r4,[r0,#0x2]	; 02306CC6
	add r0,r3,#0x0	; 02306CC8
	and r0,r4	; 02306CCA
	ldrh r7,[r1,r7]	; 02306CCC
	ldr r4,[pool_02306D58]	; 02306CCE
	strh r0,[r7,r4]	; 02306CD0
	add r0,r3,r6	; 02306CD2
	lsl r0,r0,#0x10	; 02306CD4
	lsr r3,r0,#0x10	; 02306CD6
	add r2,r2,#0x1	; 02306CD8
	cmp r2,#0x5	; 02306CDA
	bcc loc_02306CC2	; 02306CDC
	mov r4,#0x0	; 02306CDE
	ldr r3,[pool_02306D50]	; 02306CE0
	ldr r1,[pool_02306D54]	; 02306CE2
	add r6,r3,#0x0	; 02306CE4
	b loc_02306D0C	; 02306CE6
loc_02306CE8:
	lsl r0,r4,#0x2	; 02306CE8
	add r2,r1,r0	; 02306CEA
	ldrh r7,[r1,r0]	; 02306CEC
	ldr r0,[pool_02306D58]	; 02306CEE
	ldrh r0,[r7,r0]	; 02306CF0
	ldrh r2,[r2,#0x2]	; 02306CF2
	add r7,r3,#0x0	; 02306CF4
	and r7,r2	; 02306CF6
	cmp r0,r7	; 02306CF8
	beq loc_02306D04	; 02306CFA
	add r0,r5,#0x0	; 02306CFC
	add r5,r5,#0x1	; 02306CFE
	cmp r0,#0x20	; 02306D00
	bhi loc_02306D34	; 02306D02
loc_02306D04:
	add r0,r3,r6	; 02306D04
	lsl r0,r0,#0x10	; 02306D06
	lsr r3,r0,#0x10	; 02306D08
	add r4,r4,#0x1	; 02306D0A
loc_02306D0C:
	cmp r4,#0x5	; 02306D0C
	bcc loc_02306CE8	; 02306D0E
	mov r4,#0x0	; 02306D10
	ldr r3,[pool_02306D54]	; 02306D12
	add r2,r4,#0x0	; 02306D14
	ldr r0,[pool_02306D58]	; 02306D16
	b loc_02306D30	; 02306D18
loc_02306D1A:
	lsl r1,r4,#0x2	; 02306D1A
	ldrh r1,[r3,r1]	; 02306D1C
	strh r2,[r1,r0]	; 02306D1E
	ldrh r1,[r1,r0]	; 02306D20
	cmp r1,#0x0	; 02306D22
	beq loc_02306D2E	; 02306D24
	add r1,r5,#0x0	; 02306D26
	add r5,r5,#0x1	; 02306D28
	cmp r1,#0x20	; 02306D2A
	bhi loc_02306D34	; 02306D2C
loc_02306D2E:
	add r4,r4,#0x1	; 02306D2E
loc_02306D30:
	cmp r4,#0x5	; 02306D30
	bcc loc_02306D1A	; 02306D32
loc_02306D34:
	cmp r5,#0x0	; 02306D34
	beq loc_02306D48	; 02306D36
	ldr r0,[pool_02306D5C]	; 02306D38
	ldr r1,[r0,#0x0]	; 02306D3A
	ldr r0,[pool_02306D60]	; 02306D3C
	add r1,r1,r0	; 02306D3E
	ldrh r2,[r1,#0x0]	; 02306D40
	mov r0,#0x1	; 02306D42
	orr r2,r0	; 02306D44
	strh r2,[r1,#0x0]	; 02306D46
loc_02306D48:
	add sp,#0x4	; 02306D48
	pop {r4,r5,r6,r7}	; 02306D4A
	pop {r3}	; 02306D4C
	bx r3	; 02306D4E
pool_02306D50:
loc_02306D50:
	.word 0x00001234	; 02306D50
pool_02306D54:
loc_02306D54:
	.word P4_Data_0230D84C	; 02306D54
pool_02306D58:
loc_02306D58:
	.word 0x04808000	; 02306D58
pool_02306D5C:
loc_02306D5C:
	.word FirmwareWlWorkPointerSlot	; 02306D5C
pool_02306D60:
loc_02306D60:
	.word 0x00000312	; 02306D60

; ===== function loc_02306D64 =====
loc_02306D64:
	push {lr}	; 02306D64
	sub sp,#0x4	; 02306D66
	ldr r0,[pool_02306D7C]	; 02306D68
	bl loc_02304EE8	; 02306D6A
	ldr r0,[pool_02306D7C]	; 02306D6E
	mov r1,#0x0	; 02306D70
	bl loc_02306D80	; 02306D72
	add sp,#0x4	; 02306D76
	pop {r3}	; 02306D78
	bx r3	; 02306D7A
pool_02306D7C:
loc_02306D7C:
	.word 0x01000000	; 02306D7C

; ===== function loc_02306D80 =====
loc_02306D80:
	bx pc	; 02306D80
	.byte 0xC0, 0x46	; 02306D84
.arm

; ===== function loc_02306D84 =====
loc_02306D84:
	ldr r12,[pool_02306D8C]	; 02306D84
	bx r12	; 02306D88
pool_02306D8C:
loc_02306D8C:
	.word loc_037FDB14 + 1	; 02306D8C
.thumb

; ===== function loc_02306D90 =====
loc_02306D90:
	push {lr}	; 02306D90
	sub sp,#0x4	; 02306D92
	ldr r0,[pool_02306DA8]	; 02306D94
	ldr r1,[pool_02306DAC]	; 02306D96
	bl loc_02306D80	; 02306D98
	ldr r0,[pool_02306DA8]	; 02306D9C
	bl loc_02304EF8	; 02306D9E
	add sp,#0x4	; 02306DA2
	pop {r3}	; 02306DA4
	bx r3	; 02306DA6
pool_02306DA8:
loc_02306DA8:
	.word 0x01000000	; 02306DA8
pool_02306DAC:
loc_02306DAC:
	.word P2_IrqHandler_037FBF30 + 1	; 02306DAC
P4_Entry_02306DB0:
	push {lr}	; 02306DB0
	sub sp,#0x4	; 02306DB2
	ldrh r1,[r0,#0x0]	; 02306DB4
	cmp r1,#0x0	; 02306DB6
	beq P4_Entry_02306DE0	; 02306DB8
	ldr r3,[r0,#0x8]	; 02306DBA
	ldrh r2,[r3,#0x0]	; 02306DBC
	mov r1,#0x1	; 02306DBE
	and r2,r1	; 02306DC0
	cmp r2,#0x0	; 02306DC2
	beq P4_Entry_02306DE0	; 02306DC4
	ldr r1,[pool_02306DE8]	; 02306DC6
	and r3,r1	; 02306DC8
	lsr r2,r3,#0x1	; 02306DCA
	ldr r1,[pool_02306DEC]	; 02306DCC
	orr r2,r1	; 02306DCE
	ldr r1,[pool_02306DF0]	; 02306DD0
	ldrh r1,[r1,#0x0]	; 02306DD2
	cmp r2,r1	; 02306DD4
	beq P4_Entry_02306DE0	; 02306DD6
	bl P4_Entry_0230A860	; 02306DD8
	mov r0,#0x1	; 02306DDC
	b P4_Entry_02306DE2	; 02306DDE
P4_Entry_02306DE0:
	mov r0,#0x0	; 02306DE0
P4_Entry_02306DE2:
	add sp,#0x4	; 02306DE2
	pop {r3}	; 02306DE4
	bx r3	; 02306DE6
pool_02306DE8:
	.word 0x00003FFF	; 02306DE8
pool_02306DEC:
	.word 0x00008000	; 02306DEC
pool_02306DF0:
	.word REG_WIFI_TXBUF_REPLY2	; 02306DF0
P4_Entry_02306DF4:
	push {r4,r5,r6,lr}	; 02306DF4
	ldr r0,[pool_02306E28]	; 02306DF6
	ldr r1,[r0,#0x0]	; 02306DF8
	ldr r0,[pool_02306E2C]	; 02306DFA
	add r0,r1,r0	; 02306DFC
	add r1,r0,#0x0	; 02306DFE
	add r1,#0xa6	; 02306E00
	ldrh r1,[r1,#0x0]	; 02306E02
	ldr r2,[pool_02306E30]	; 02306E04
	cmp r1,r2	; 02306E06
	beq P4_Entry_02306E20	; 02306E08
	ldr r6,[pool_02306E34]	; 02306E0A
	ldrh r5,[r6,#0x0]	; 02306E0C
	strh r1,[r6,#0x0]	; 02306E0E
	ldr r4,[pool_02306E38]	; 02306E10
	ldrh r3,[r4,#0x0]	; 02306E12
	mov r1,#0x80	; 02306E14
	orr r3,r1	; 02306E16
	strh r3,[r4,#0x0]	; 02306E18
	strh r5,[r6,#0x0]	; 02306E1A
	add r0,#0xa6	; 02306E1C
	strh r2,[r0,#0x0]	; 02306E1E
P4_Entry_02306E20:
	pop {r4,r5,r6}	; 02306E20
	pop {r3}	; 02306E22
	bx r3	; 02306E24
	.byte 0xC0, 0x46	; 02306E26
pool_02306E28:
	.word FirmwareWlWorkPointerSlot	; 02306E28
pool_02306E2C:
	.word 0x00000400	; 02306E2C
pool_02306E30:
	.word 0x0000FFFF	; 02306E30
pool_02306E34:
	.word REG_WIFI_TXBUF_REPLY1	; 02306E34
pool_02306E38:
	.word REG_WIFI_RXCNT	; 02306E38
P4_Entry_02306E3C:
	ldr r1,[pool_02306E44]	; 02306E3C
	ldr r0,[pool_02306E48]	; 02306E3E
	strh r1,[r0,#0x0]	; 02306E40
	bx lr	; 02306E42
pool_02306E44:
	.word 0x00000800	; 02306E44
pool_02306E48:
	.word REG_WIFI_IF	; 02306E48

; ===== function loc_02306E4C =====
loc_02306E4C:
	push {r4,r5,r6,lr}	; 02306E4C
	sub sp,#0x8	; 02306E4E
	add r5,r0,#0x0	; 02306E50
	add r6,r1,#0x0	; 02306E52
	ldr r0,[pool_02306EC0]	; 02306E54
	ldr r0,[r0,#0x0]	; 02306E56
	ldr r1,[pool_02306EC4]	; 02306E58
	ldr r3,[r0,r1]	; 02306E5A
	mov r1,#0x1c	; 02306E5C
	add r2,r5,#0x0	; 02306E5E
	mul r2,r1	; 02306E60
	add r4,r3,r2	; 02306E62
	ldrh r1,[r3,r2]	; 02306E64
	cmp r1,#0x0	; 02306E66
	bne loc_02306E74	; 02306E68
	ldr r1,[pool_02306EC8]	; 02306E6A
	add r0,r0,r1	; 02306E6C
	ldrh r1,[r0,#0x0]	; 02306E6E
	add r1,r1,#0x1	; 02306E70
	strh r1,[r0,#0x0]	; 02306E72
loc_02306E74:
	mov r1,#0x0	; 02306E74
	add r0,sp,#0x0	; 02306E76
	strh r1,[r0,#0x0]	; 02306E78
	ldrh r0,[r0,#0x0]	; 02306E7A
	add r1,r4,#0x0	; 02306E7C
	mov r2,#0x1a	; 02306E7E
	bl loc_02306ED4	; 02306E80
	lsl r0,r5,#0x10	; 02306E84
	lsr r0,r0,#0x10	; 02306E86
	mov r1,#0x0	; 02306E88
	bl loc_02307404	; 02306E8A
	add r0,r5,#0x0	; 02306E8E
	bl loc_023073BC	; 02306E90
	add r0,r4,#0x4	; 02306E94
	add r1,r6,#0x0	; 02306E96
	bl loc_02305B7C	; 02306E98
	ldr r0,[pool_02306ECC]	; 02306E9C
	strh r0,[r4,#0x14]	; 02306E9E
	ldr r0,[pool_02306EC0]	; 02306EA0
	ldr r1,[r0,#0x0]	; 02306EA2
	ldr r0,[pool_02306ED0]	; 02306EA4
	ldrh r0,[r1,r0]	; 02306EA6
	strh r0,[r4,#0x10]	; 02306EA8
	ldrh r0,[r4,#0x1a]	; 02306EAA
	strh r0,[r4,#0x18]	; 02306EAC
	lsl r0,r5,#0x10	; 02306EAE
	lsr r0,r0,#0x10	; 02306EB0
	mov r1,#0x20	; 02306EB2
	bl loc_0230745C	; 02306EB4
	add sp,#0x8	; 02306EB8
	pop {r4,r5,r6}	; 02306EBA
	pop {r3}	; 02306EBC
	bx r3	; 02306EBE
pool_02306EC0:
loc_02306EC0:
	.word FirmwareWlWorkPointerSlot	; 02306EC0
pool_02306EC4:
loc_02306EC4:
	.word 0x000002F0	; 02306EC4
pool_02306EC8:
loc_02306EC8:
	.word 0x00000504	; 02306EC8
pool_02306ECC:
loc_02306ECC:
	.word 0x0000FFFF	; 02306ECC
pool_02306ED0:
loc_02306ED0:
	.word 0x0000037A	; 02306ED0

; ===== function loc_02306ED4 =====
loc_02306ED4:
	bx pc	; 02306ED4
	.byte 0xC0, 0x46	; 02306ED8
.arm

; ===== function loc_02306ED8 =====
loc_02306ED8:
	ldr pc,[pool_02306EDC]	; 02306ED8
pool_02306EDC:
loc_02306EDC:
	.word loc_037FF31C	; 02306EDC
.thumb
P4_Entry_02306EE0:
	push {r4,r5,r6,r7,lr}	; 02306EE0
	sub sp,#0x4	; 02306EE2
	ldr r0,[pool_02306F30]	; 02306EE4
	ldr r1,[r0,#0x0]	; 02306EE6
	ldr r0,[pool_02306F34]	; 02306EE8
	ldr r6,[r1,r0]	; 02306EEA
	ldr r0,[pool_02306F38]	; 02306EEC
	add r5,r1,r0	; 02306EEE
	ldr r0,[pool_02306F3C]	; 02306EF0
	ldrh r7,[r1,r0]	; 02306EF2
	mov r4,#0x1	; 02306EF4
	b P4_Entry_02306F10	; 02306EF6
P4_Entry_02306EF8:
	mov r1,#0x0	; 02306EF8
	add r0,sp,#0x0	; 02306EFA
	strh r1,[r0,#0x0]	; 02306EFC
	ldrh r0,[r0,#0x0]	; 02306EFE
	add r2,r4,#0x0	; 02306F00
	mov r1,#0x1c	; 02306F02
	mul r2,r1	; 02306F04
	add r1,r6,r2	; 02306F06
	mov r2,#0x1a	; 02306F08
	bl P4_Entry_02306F44	; 02306F0A
	add r4,r4,#0x1	; 02306F0E
P4_Entry_02306F10:
	cmp r4,r7	; 02306F10
	bcc P4_Entry_02306EF8	; 02306F12
	mov r2,#0x1	; 02306F14
	strh r2,[r5,#0x0]	; 02306F16
	mov r1,#0x0	; 02306F18
	strh r1,[r5,#0x2]	; 02306F1A
	strh r2,[r5,#0x4]	; 02306F1C
	ldr r0,[pool_02306F40]	; 02306F1E
	strh r0,[r5,#0x6]	; 02306F20
	strh r1,[r5,#0x8]	; 02306F22
	strh r2,[r5,#0xa]	; 02306F24
	add sp,#0x4	; 02306F26
	pop {r4,r5,r6,r7}	; 02306F28
	pop {r3}	; 02306F2A
	bx r3	; 02306F2C
	.byte 0xC0, 0x46	; 02306F2E
pool_02306F30:
	.word FirmwareWlWorkPointerSlot	; 02306F30
pool_02306F34:
	.word 0x000002F0	; 02306F34
pool_02306F38:
	.word 0x00000504	; 02306F38
pool_02306F3C:
	.word 0x000002F6	; 02306F3C
pool_02306F40:
	.word 0x0000FFFE	; 02306F40
P4_Entry_02306F44:
	bx pc	; 02306F44
	.byte 0xC0, 0x46	; 02306F46
.arm
	ldr pc,[pool_02306F4C]	; 02306F48
pool_02306F4C:
	.word loc_037FF31C	; 02306F4C
.thumb

; ===== function loc_02306F50 =====
loc_02306F50:
	push {r4,r5,lr}	; 02306F50
	sub sp,#0x4	; 02306F52
	ldr r0,[pool_02306FBC]	; 02306F54
	ldr r1,[r0,#0x0]	; 02306F56
	ldr r0,[pool_02306FC0]	; 02306F58
	ldr r5,[r1,r0]	; 02306F5A
	ldr r0,[pool_02306FC4]	; 02306F5C
	ldrh r4,[r1,r0]	; 02306F5E
	mov r1,#0x0	; 02306F60
	add r0,sp,#0x0	; 02306F62
	strh r1,[r0,#0x0]	; 02306F64
	ldrh r0,[r0,#0x0]	; 02306F66
	add r1,r5,#0x0	; 02306F68
	mov r3,#0x1c	; 02306F6A
	add r2,r4,#0x0	; 02306F6C
	mul r2,r3	; 02306F6E
	bl loc_02306FD4	; 02306F70
	mov r1,#0x0	; 02306F74
	add r0,sp,#0x0	; 02306F76
	strh r1,[r0,#0x2]	; 02306F78
	ldrh r0,[r0,#0x2]	; 02306F7A
	ldr r1,[pool_02306FBC]	; 02306F7C
	ldr r2,[r1,#0x0]	; 02306F7E
	ldr r1,[pool_02306FC8]	; 02306F80
	add r1,r2,r1	; 02306F82
	mov r2,#0xc	; 02306F84
	bl loc_02306FE0	; 02306F86
	ldr r2,[pool_02306FCC]	; 02306F8A
	strh r2,[r5,#0x1a]	; 02306F8C
	mov r3,#0x1	; 02306F8E
	mov r0,#0x1c	; 02306F90
	b loc_02306F9E	; 02306F92
loc_02306F94:
	add r1,r3,#0x0	; 02306F94
	mul r1,r0	; 02306F96
	add r1,r5,r1	; 02306F98
	strh r2,[r1,#0x1a]	; 02306F9A
	add r3,r3,#0x1	; 02306F9C
loc_02306F9E:
	cmp r3,r4	; 02306F9E
	bcc loc_02306F94	; 02306FA0
	mov r0,#0x0	; 02306FA2
	ldr r1,[pool_02306FD0]	; 02306FA4
	bl loc_02306E4C	; 02306FA6
	mov r0,#0x0	; 02306FAA
	mov r1,#0x40	; 02306FAC
	bl loc_0230745C	; 02306FAE
	add sp,#0x4	; 02306FB2
	pop {r4,r5}	; 02306FB4
	pop {r3}	; 02306FB6
	bx r3	; 02306FB8
	.byte 0xC0, 0x46	; 02306FBC
pool_02306FBC:
loc_02306FBC:
	.word FirmwareWlWorkPointerSlot	; 02306FBC
pool_02306FC0:
loc_02306FC0:
	.word 0x000002F0	; 02306FC0
pool_02306FC4:
loc_02306FC4:
	.word 0x000002F6	; 02306FC4
pool_02306FC8:
loc_02306FC8:
	.word 0x00000504	; 02306FC8
pool_02306FCC:
loc_02306FCC:
	.word 0x0000FFFF	; 02306FCC
pool_02306FD0:
loc_02306FD0:
	.word 0x0230D608	; 02306FD0

; ===== function loc_02306FD4 =====
loc_02306FD4:
	bx pc	; 02306FD4
	.byte 0xC0, 0x46	; 02306FD8
.arm

; ===== function loc_02306FD8 =====
loc_02306FD8:
	ldr pc,[pool_02306FDC]	; 02306FD8
pool_02306FDC:
loc_02306FDC:
	.word loc_037FF31C	; 02306FDC
.thumb

; ===== function loc_02306FE0 =====
loc_02306FE0:
	bx pc	; 02306FE0
	.byte 0xC0, 0x46	; 02306FE4
.arm

; ===== function loc_02306FE4 =====
loc_02306FE4:
	ldr pc,[pool_02306FE8]	; 02306FE4
pool_02306FE8:
loc_02306FE8:
	.word loc_037FF31C	; 02306FE8
.thumb

; ===== function loc_02306FEC =====
	push {r4,r5,r6,r7,lr}	; 02306FEC
	sub sp,#0x14	; 02306FEE
	ldr r0,[pool_0230709C]	; 02306FF0
	ldr r5,[r0,#0x0]	; 02306FF2
	ldr r0,[pool_023070A0]	; 02306FF4
	ldr r4,[r5,r0]	; 02306FF6
	add r4,#0x1c	; 02306FF8
	ldr r0,[pool_023070A4]	; 02306FFA
	ldrh r0,[r5,r0]	; 02306FFC
	str r0,[sp,#0x0]	; 02306FFE
	mov r7,#0x0	; 02307000
	mov r6,#0x1	; 02307002
	str r6,[sp,#0x8]	; 02307004
	str r6,[sp,#0x4]	; 02307006
	str r7,[sp,#0xc]	; 02307008
	b loc_0230708A	; 0230700A
loc_0230700C:
	ldrh r0,[r4,#0x0]	; 0230700C
	cmp r0,#0x0	; 0230700E
	beq loc_02307086	; 02307010
	ldrh r1,[r4,#0x18]	; 02307012
	cmp r1,#0x0	; 02307014
	beq loc_0230707E	; 02307016
	ldr r0,[pool_023070A8]	; 02307018
	cmp r1,r0	; 0230701A
	beq loc_0230707E	; 0230701C
	sub r0,r1,#0x1	; 0230701E
	strh r0,[r4,#0x18]	; 02307020
	ldrh r0,[r4,#0x18]	; 02307022
	cmp r0,#0x0	; 02307024
	bne loc_0230707E	; 02307026
	ldrh r0,[r4,#0x0]	; 02307028
	cmp r0,#0x20	; 0230702A
	bcc loc_02307070	; 0230702C
	add r0,r6,#0x0	; 0230702E
	bl loc_0230A5F4	; 02307030
	ldr r0,[pool_023070AC]	; 02307034
	ldrh r0,[r5,r0]	; 02307036
	cmp r0,#0x1	; 02307038
	bne loc_0230704C	; 0230703A
	ldrh r0,[r4,#0x0]	; 0230703C
	cmp r0,#0x20	; 0230703E
	bls loc_02307066	; 02307040
	add r0,r4,#0x4	; 02307042
	ldr r1,[sp,#0x4]	; 02307044
	bl loc_02307C00	; 02307046
	b loc_02307066	; 0230704A
loc_0230704C:
	ldr r0,[pool_023070B0]	; 0230704C
	ldrh r0,[r5,r0]	; 0230704E
	cmp r6,r0	; 02307050
	bne loc_02307066	; 02307052
	mov r0,#0x20	; 02307054
	bl loc_023070B8	; 02307056
	bl loc_02305B8C	; 0230705A
	add r0,r4,#0x4	; 0230705E
	ldr r1,[sp,#0x8]	; 02307060
	bl loc_02307C00	; 02307062
loc_02307066:
	lsl r0,r6,#0x10	; 02307066
	lsr r0,r0,#0x10	; 02307068
	mov r1,#0x20	; 0230706A
	bl loc_0230745C	; 0230706C
loc_02307070:
	ldr r0,[sp,#0xc]	; 02307070
	strh r0,[r4,#0x0]	; 02307072
	ldr r0,[pool_023070A4]	; 02307074
	ldrh r0,[r5,r0]	; 02307076
	sub r1,r0,#0x1	; 02307078
	ldr r0,[pool_023070A4]	; 0230707A
	strh r1,[r5,r0]	; 0230707C
loc_0230707E:
	add r7,r7,#0x1	; 0230707E
	ldr r0,[sp,#0x0]	; 02307080
	cmp r7,r0	; 02307082
	bcs loc_02307092	; 02307084
loc_02307086:
	add r6,r6,#0x1	; 02307086
	add r4,#0x1c	; 02307088
loc_0230708A:
	ldr r0,[pool_023070B4]	; 0230708A
	ldrh r0,[r5,r0]	; 0230708C
	cmp r6,r0	; 0230708E
	bcc loc_0230700C	; 02307090
loc_02307092:
	add sp,#0x14	; 02307092
	pop {r4,r5,r6,r7}	; 02307094
	pop {r3}	; 02307096
	bx r3	; 02307098
	.byte 0xC0, 0x46	; 0230709C
pool_0230709C:
loc_0230709C:
	.word FirmwareWlWorkPointerSlot	; 0230709C
pool_023070A0:
loc_023070A0:
	.word 0x000002F0	; 023070A0
pool_023070A4:
loc_023070A4:
	.word 0x00000504	; 023070A4
pool_023070A8:
loc_023070A8:
	.word 0x0000FFFF	; 023070A8
pool_023070AC:
loc_023070AC:
	.word 0x00000324	; 023070AC
pool_023070B0:
loc_023070B0:
	.word 0x000003A0	; 023070B0
pool_023070B4:
loc_023070B4:
	.word 0x000002F6	; 023070B4

; ===== function loc_023070B8 =====
loc_023070B8:
	bx pc	; 023070B8
	.byte 0xC0, 0x46	; 023070BC
.arm

; ===== function loc_023070BC =====
loc_023070BC:
	ldr r12,[pool_023070C4]	; 023070BC
	bx r12	; 023070C0
pool_023070C4:
loc_023070C4:
	.word loc_037FBE78 + 1	; 023070C4
.thumb

; ===== function loc_023070C8 =====
loc_023070C8:
	push {r4,r5,r6,lr}	; 023070C8
	add r4,r0,#0x0	; 023070CA
	bl loc_0230728C	; 023070CC
	cmp r0,#0x40	; 023070D0
	bne loc_02307134	; 023070D2
	ldr r0,[pool_0230713C]	; 023070D4
	ldr r1,[r0,#0x0]	; 023070D6
	ldr r0,[pool_02307140]	; 023070D8
	ldrh r1,[r1,r0]	; 023070DA
	ldr r0,[pool_02307144]	; 023070DC
	add r5,r1,r0	; 023070DE
	ldr r0,[pool_02307148]	; 023070E0
	bl loc_02304EE8	; 023070E2
	add r6,r0,#0x0	; 023070E6
	cmp r4,#0x0	; 023070E8
	bne loc_02307104	; 023070EA
	add r0,r5,#0x4	; 023070EC
	bl loc_02305180	; 023070EE
	mov r1,#0xfe	; 023070F2
	add r2,r0,#0x0	; 023070F4
	and r2,r1	; 023070F6
	add r0,r5,#0x4	; 023070F8
	lsl r1,r2,#0x18	; 023070FA
	lsr r1,r1,#0x18	; 023070FC
	bl loc_023051A4	; 023070FE
	b loc_0230712E	; 02307102
loc_02307104:
	add r0,r4,#0x0	; 02307104
	bl loc_023071F4	; 02307106
	add r4,r0,#0x0	; 0230710A
	add r1,r5,#0x5	; 0230710C
	lsr r0,r4,#0x3	; 0230710E
	add r5,r1,r0	; 02307110
	add r0,r5,#0x0	; 02307112
	bl loc_02305180	; 02307114
	mov r2,#0x1	; 02307118
	mov r1,#0x7	; 0230711A
	and r4,r1	; 0230711C
	lsl r2,r4	; 0230711E
	mvn r1,r2	; 02307120
	and r1,r0	; 02307122
	add r0,r5,#0x0	; 02307124
	lsl r1,r1,#0x18	; 02307126
	lsr r1,r1,#0x18	; 02307128
	bl loc_023051A4	; 0230712A
loc_0230712E:
	add r0,r6,#0x0	; 0230712E
	bl loc_02304EF8	; 02307130
loc_02307134:
	pop {r4,r5,r6}	; 02307134
	pop {r3}	; 02307136
	bx r3	; 02307138
	.byte 0xC0, 0x46	; 0230713C
pool_0230713C:
loc_0230713C:
	.word FirmwareWlWorkPointerSlot	; 0230713C
pool_02307140:
loc_02307140:
	.word 0x000003AC	; 02307140
pool_02307144:
loc_02307144:
	.word 0x0480425C	; 02307144
pool_02307148:
loc_02307148:
	.word 0x01000000	; 02307148

; ===== function loc_0230714C =====
loc_0230714C:
	push {r4,r5,r6,lr}	; 0230714C
	add r4,r0,#0x0	; 0230714E
	bl loc_0230728C	; 02307150
	cmp r0,#0x40	; 02307154
	bne loc_023071B6	; 02307156
	ldr r0,[pool_023071BC]	; 02307158
	ldr r1,[r0,#0x0]	; 0230715A
	ldr r0,[pool_023071C0]	; 0230715C
	ldrh r1,[r1,r0]	; 0230715E
	ldr r0,[pool_023071C4]	; 02307160
	add r5,r1,r0	; 02307162
	ldr r0,[pool_023071C8]	; 02307164
	bl loc_02304EE8	; 02307166
	add r6,r0,#0x0	; 0230716A
	cmp r4,#0x0	; 0230716C
	bne loc_02307188	; 0230716E
	add r0,r5,#0x4	; 02307170
	bl loc_02305180	; 02307172
	mov r1,#0x1	; 02307176
	add r2,r0,#0x0	; 02307178
	orr r2,r1	; 0230717A
	add r0,r5,#0x4	; 0230717C
	lsl r1,r2,#0x18	; 0230717E
	lsr r1,r1,#0x18	; 02307180
	bl loc_023051A4	; 02307182
	b loc_023071B0	; 02307186
loc_02307188:
	add r0,r4,#0x0	; 02307188
	bl loc_023071F4	; 0230718A
	add r4,r0,#0x0	; 0230718E
	add r1,r5,#0x5	; 02307190
	lsr r0,r4,#0x3	; 02307192
	add r5,r1,r0	; 02307194
	add r0,r5,#0x0	; 02307196
	bl loc_02305180	; 02307198
	mov r2,#0x1	; 0230719C
	mov r1,#0x7	; 0230719E
	and r4,r1	; 023071A0
	lsl r2,r4	; 023071A2
	orr r2,r0	; 023071A4
	add r0,r5,#0x0	; 023071A6
	lsl r1,r2,#0x18	; 023071A8
	lsr r1,r1,#0x18	; 023071AA
	bl loc_023051A4	; 023071AC
loc_023071B0:
	add r0,r6,#0x0	; 023071B0
	bl loc_02304EF8	; 023071B2
loc_023071B6:
	pop {r4,r5,r6}	; 023071B6
	pop {r3}	; 023071B8
	bx r3	; 023071BA
pool_023071BC:
loc_023071BC:
	.word FirmwareWlWorkPointerSlot	; 023071BC
pool_023071C0:
loc_023071C0:
	.word 0x000003AC	; 023071C0
pool_023071C4:
loc_023071C4:
	.word 0x0480425C	; 023071C4
pool_023071C8:
loc_023071C8:
	.word 0x01000000	; 023071C8

; ===== function loc_023071CC =====
loc_023071CC:
	ldr r1,[pool_023071DC]	; 023071CC
	ldr r2,[r1,#0x0]	; 023071CE
	ldr r1,[pool_023071E0]	; 023071D0
	ldr r2,[r2,r1]	; 023071D2
	mov r1,#0x1c	; 023071D4
	mul r0,r1	; 023071D6
	add r0,r2,r0	; 023071D8
	bx lr	; 023071DA
pool_023071DC:
loc_023071DC:
	.word FirmwareWlWorkPointerSlot	; 023071DC
pool_023071E0:
loc_023071E0:
	.word 0x000002F0	; 023071E0

; ===== function loc_023071E4 =====
loc_023071E4:
	push {lr}	; 023071E4
	sub sp,#0x4	; 023071E6
	bl loc_023071CC	; 023071E8
	ldrh r0,[r0,#0x16]	; 023071EC
	add sp,#0x4	; 023071EE
	pop {r3}	; 023071F0
	bx r3	; 023071F2

; ===== function loc_023071F4 =====
loc_023071F4:
	push {lr}	; 023071F4
	sub sp,#0x4	; 023071F6
	bl loc_023071CC	; 023071F8
	ldrh r0,[r0,#0x2]	; 023071FC
	add sp,#0x4	; 023071FE
	pop {r3}	; 02307200
	bx r3	; 02307202

; ===== function loc_02307204 =====
	push {lr}	; 02307204
	sub sp,#0x4	; 02307206
	bl loc_023071CC	; 02307208
	ldrh r1,[r0,#0x10]	; 0230720C
	mov r0,#0x2	; 0230720E
	and r1,r0	; 02307210
	cmp r1,#0x0	; 02307212
	beq loc_0230721A	; 02307214
	mov r0,#0x14	; 02307216
	b loc_0230721C	; 02307218
loc_0230721A:
	mov r0,#0xa	; 0230721A
loc_0230721C:
	add sp,#0x4	; 0230721C
	pop {r3}	; 0230721E
	bx r3	; 02307220
	.byte 0x00, 0x00	; 02307224

; ===== function loc_02307224 =====
loc_02307224:
	push {lr}	; 02307224
	sub sp,#0x4	; 02307226
	bl loc_023071CC	; 02307228
	ldrh r0,[r0,#0x14]	; 0230722C
	add sp,#0x4	; 0230722E
	pop {r3}	; 02307230
	bx r3	; 02307232

; ===== function loc_02307234 =====
loc_02307234:
	push {lr}	; 02307234
	sub sp,#0x4	; 02307236
	bl loc_023071CC	; 02307238
	ldrh r0,[r0,#0xe]	; 0230723C
	add sp,#0x4	; 0230723E
	pop {r3}	; 02307240
	bx r3	; 02307242

; ===== function loc_02307244 =====
loc_02307244:
	push {lr}	; 02307244
	sub sp,#0x4	; 02307246
	bl loc_023071CC	; 02307248
	add r0,r0,#0x4	; 0230724C
	add sp,#0x4	; 0230724E
	pop {r3}	; 02307250
	bx r3	; 02307252

; ===== function loc_02307254 =====
loc_02307254:
	ldr r1,[pool_02307268]	; 02307254
	ldr r2,[r1,#0x0]	; 02307256
	ldr r1,[pool_0230726C]	; 02307258
	ldrh r1,[r2,r1]	; 0230725A
	asr r1,r0	; 0230725C
	mov r0,#0x1	; 0230725E
	and r1,r0	; 02307260
	add r0,r1,#0x0	; 02307262
	bx lr	; 02307264
	.byte 0xC0, 0x46	; 02307268
pool_02307268:
loc_02307268:
	.word FirmwareWlWorkPointerSlot	; 02307268
pool_0230726C:
loc_0230726C:
	.word 0x00000506	; 0230726C

; ===== function loc_02307270 =====
loc_02307270:
	ldr r1,[pool_02307284]	; 02307270
	ldr r2,[r1,#0x0]	; 02307272
	ldr r1,[pool_02307288]	; 02307274
	ldrh r1,[r2,r1]	; 02307276
	asr r1,r0	; 02307278
	mov r0,#0x1	; 0230727A
	and r1,r0	; 0230727C
	add r0,r1,#0x0	; 0230727E
	bx lr	; 02307280
	.byte 0xC0, 0x46	; 02307284
pool_02307284:
loc_02307284:
	.word FirmwareWlWorkPointerSlot	; 02307284
pool_02307288:
loc_02307288:
	.word 0x00000508	; 02307288

; ===== function loc_0230728C =====
loc_0230728C:
	push {lr}	; 0230728C
	sub sp,#0x4	; 0230728E
	bl loc_023071CC	; 02307290
	ldrh r0,[r0,#0x0]	; 02307294
	add sp,#0x4	; 02307296
	pop {r3}	; 02307298
	bx r3	; 0230729A

; ===== function loc_0230729C =====
loc_0230729C:
	push {r4,r5,r6,lr}	; 0230729C
	add r5,r0,#0x0	; 0230729E
	ldr r1,[pool_023072E4]	; 023072A0
	ldr r4,[r1,#0x0]	; 023072A2
	bl loc_023070C8	; 023072A4
	add r0,r5,#0x0	; 023072A8
	bl loc_023071F4	; 023072AA
	add r6,r0,#0x0	; 023072AE
	add r0,r5,#0x0	; 023072B0
	bl loc_023071CC	; 023072B2
	mov r1,#0x0	; 023072B6
	strh r1,[r0,#0x2]	; 023072B8
	ldr r0,[pool_023072E8]	; 023072BA
	add r0,r4,r0	; 023072BC
	ldrh r2,[r0,#0x0]	; 023072BE
	mov r1,#0x1	; 023072C0
	lsl r1,r6	; 023072C2
	bic r2,r1	; 023072C4
	strh r2,[r0,#0x0]	; 023072C6
	ldr r0,[pool_023072EC]	; 023072C8
	add r0,r4,r0	; 023072CA
	ldrh r1,[r0,#0x0]	; 023072CC
	sub r1,r1,#0x1	; 023072CE
	strh r1,[r0,#0x0]	; 023072D0
	ldrh r0,[r0,#0x0]	; 023072D2
	cmp r0,#0x0	; 023072D4
	bne loc_023072DC	; 023072D6
	bl loc_02305D24	; 023072D8
loc_023072DC:
	pop {r4,r5,r6}	; 023072DC
	pop {r3}	; 023072DE
	bx r3	; 023072E0
	.byte 0xC0, 0x46	; 023072E4
pool_023072E4:
loc_023072E4:
	.word FirmwareWlWorkPointerSlot	; 023072E4
pool_023072E8:
loc_023072E8:
	.word 0x0000050E	; 023072E8
pool_023072EC:
loc_023072EC:
	.word 0x0000050C	; 023072EC

; ===== function loc_023072F0 =====
loc_023072F0:
	push {r4,r5,r6,r7,lr}	; 023072F0
	sub sp,#0x4	; 023072F2
	add r7,r0,#0x0	; 023072F4
	ldr r0,[pool_02307354]	; 023072F6
	ldr r1,[r0,#0x0]	; 023072F8
	ldr r0,[pool_02307358]	; 023072FA
	add r5,r1,r0	; 023072FC
	ldr r0,[pool_0230735C]	; 023072FE
	bl loc_02304EE8	; 02307300
	add r6,r0,#0x0	; 02307304
	mov r4,#0x1	; 02307306
	mov r2,#0x2	; 02307308
	b loc_02307340	; 0230730A
loc_0230730C:
	ldrh r0,[r5,#0xa]	; 0230730C
	add r1,r0,#0x0	; 0230730E
	and r1,r2	; 02307310
	cmp r1,#0x0	; 02307312
	bne loc_0230733C	; 02307314
	orr r0,r2	; 02307316
	strh r0,[r5,#0xa]	; 02307318
	ldrh r0,[r5,#0x8]	; 0230731A
	add r0,r0,#0x1	; 0230731C
	strh r0,[r5,#0x8]	; 0230731E
	ldrh r0,[r5,#0x8]	; 02307320
	cmp r0,#0x1	; 02307322
	bne loc_0230732A	; 02307324
	bl loc_02305D00	; 02307326
loc_0230732A:
	add r0,r7,#0x0	; 0230732A
	bl loc_023071CC	; 0230732C
	strh r4,[r0,#0x2]	; 02307330
	add r0,r6,#0x0	; 02307332
	bl loc_02304EF8	; 02307334
	add r0,r4,#0x0	; 02307338
	b loc_0230734C	; 0230733A
loc_0230733C:
	add r4,r4,#0x1	; 0230733C
	lsl r2,r2,#0x1	; 0230733E
loc_02307340:
	cmp r4,#0x10	; 02307340
	bcc loc_0230730C	; 02307342
	add r0,r6,#0x0	; 02307344
	bl loc_02304EF8	; 02307346
	mov r0,#0x0	; 0230734A
loc_0230734C:
	add sp,#0x4	; 0230734C
	pop {r4,r5,r6,r7}	; 0230734E
	pop {r3}	; 02307350
	bx r3	; 02307352
pool_02307354:
loc_02307354:
	.word FirmwareWlWorkPointerSlot	; 02307354
pool_02307358:
loc_02307358:
	.word 0x00000504	; 02307358
pool_0230735C:
loc_0230735C:
	.word 0x01000000	; 0230735C

; ===== function loc_02307360 =====
loc_02307360:
	mov r1,#0x1c	; 02307360
	mul r0,r1	; 02307362
	ldr r1,[pool_02307374]	; 02307364
	ldr r2,[r1,#0x0]	; 02307366
	ldr r1,[pool_02307378]	; 02307368
	ldr r1,[r2,r1]	; 0230736A
	add r1,r1,r0	; 0230736C
	ldrh r0,[r1,#0x1a]	; 0230736E
	strh r0,[r1,#0x18]	; 02307370
	bx lr	; 02307372
pool_02307374:
loc_02307374:
	.word FirmwareWlWorkPointerSlot	; 02307374
pool_02307378:
loc_02307378:
	.word 0x000002F0	; 02307378

; ===== function loc_0230737C =====
loc_0230737C:
	push {r4,lr}	; 0230737C
	add r4,r1,#0x0	; 0230737E
	bl loc_023071CC	; 02307380
	strh r4,[r0,#0xe]	; 02307384
	pop {r4}	; 02307386
	pop {r3}	; 02307388
	bx r3	; 0230738A

; ===== function loc_0230738C =====
loc_0230738C:
	push {r4,lr}	; 0230738C
	add r4,r1,#0x0	; 0230738E
	bl loc_023071CC	; 02307390
	strh r4,[r0,#0x14]	; 02307394
	pop {r4}	; 02307396
	pop {r3}	; 02307398
	bx r3	; 0230739A

; ===== function loc_0230739C =====
loc_0230739C:
	push {r4,lr}	; 0230739C
	add r4,r1,#0x0	; 0230739E
	bl loc_023071CC	; 023073A0
	strh r4,[r0,#0x10]	; 023073A4
	pop {r4}	; 023073A6
	pop {r3}	; 023073A8
	bx r3	; 023073AA

; ===== function loc_023073AC =====
loc_023073AC:
	push {r4,lr}	; 023073AC
	add r4,r1,#0x0	; 023073AE
	bl loc_023071CC	; 023073B0
	strh r4,[r0,#0xc]	; 023073B4
	pop {r4}	; 023073B6
	pop {r3}	; 023073B8
	bx r3	; 023073BA

; ===== function loc_023073BC =====
loc_023073BC:
	ldr r1,[pool_023073D0]	; 023073BC
	ldr r2,[r1,#0x0]	; 023073BE
	ldr r1,[pool_023073D4]	; 023073C0
	add r1,r2,r1	; 023073C2
	ldrh r3,[r1,#0x0]	; 023073C4
	mov r2,#0x1	; 023073C6
	lsl r2,r0	; 023073C8
	orr r3,r2	; 023073CA
	strh r3,[r1,#0x0]	; 023073CC
	bx lr	; 023073CE
pool_023073D0:
loc_023073D0:
	.word FirmwareWlWorkPointerSlot	; 023073D0
pool_023073D4:
loc_023073D4:
	.word 0x00000508	; 023073D4

; ===== function loc_023073D8 =====
loc_023073D8:
	push {r4,lr}	; 023073D8
	add r4,r0,#0x0	; 023073DA
	bl loc_0230728C	; 023073DC
	cmp r0,#0x40	; 023073E0
	bne loc_023073F6	; 023073E2
	ldr r0,[pool_023073FC]	; 023073E4
	ldr r1,[r0,#0x0]	; 023073E6
	ldr r0,[pool_02307400]	; 023073E8
	add r0,r1,r0	; 023073EA
	ldrh r2,[r0,#0x0]	; 023073EC
	mov r1,#0x1	; 023073EE
	lsl r1,r4	; 023073F0
	bic r2,r1	; 023073F2
	strh r2,[r0,#0x0]	; 023073F4
loc_023073F6:
	pop {r4}	; 023073F6
	pop {r3}	; 023073F8
	bx r3	; 023073FA
pool_023073FC:
loc_023073FC:
	.word FirmwareWlWorkPointerSlot	; 023073FC
pool_02307400:
loc_02307400:
	.word 0x00000508	; 02307400

; ===== function loc_02307404 =====
loc_02307404:
	push {r4,lr}	; 02307404
	ldr r2,[pool_0230743C]	; 02307406
	ldr r3,[r2,#0x0]	; 02307408
	ldr r2,[pool_02307440]	; 0230740A
	add r4,r3,r2	; 0230740C
	ldrh r3,[r4,#0x2]	; 0230740E
	mov r2,#0x1	; 02307410
	lsl r2,r0	; 02307412
	bic r3,r2	; 02307414
	lsl r1,r0	; 02307416
	orr r3,r1	; 02307418
	strh r3,[r4,#0x2]	; 0230741A
	ldrh r1,[r4,#0x2]	; 0230741C
	ldrh r0,[r4,#0x6]	; 0230741E
	bic r1,r0	; 02307420
	cmp r1,#0x0	; 02307422
	beq loc_0230742E	; 02307424
	mov r1,#0x8	; 02307426
	ldr r0,[pool_02307444]	; 02307428
	strh r1,[r0,#0x0]	; 0230742A
	b loc_02307434	; 0230742C
loc_0230742E:
	mov r1,#0x8	; 0230742E
	ldr r0,[pool_02307448]	; 02307430
	strh r1,[r0,#0x0]	; 02307432
loc_02307434:
	pop {r4}	; 02307434
	pop {r3}	; 02307436
	bx r3	; 02307438
	.byte 0xC0, 0x46	; 0230743C
pool_0230743C:
loc_0230743C:
	.word FirmwareWlWorkPointerSlot	; 0230743C
pool_02307440:
loc_02307440:
	.word 0x00000504	; 02307440
pool_02307444:
loc_02307444:
	.word REG_WIFI_TXREQ_RESET	; 02307444
pool_02307448:
loc_02307448:
	.word REG_WIFI_TXREQ_SET	; 02307448

; ===== function loc_0230744C =====
loc_0230744C:
	push {r4,lr}	; 0230744C
	add r4,r1,#0x0	; 0230744E
	bl loc_023071CC	; 02307450
	strh r4,[r0,#0xa]	; 02307454
	pop {r4}	; 02307456
	pop {r3}	; 02307458
	bx r3	; 0230745A

; ===== function loc_0230745C =====
loc_0230745C:
	push {r4,r5,r6,lr}	; 0230745C
	add r5,r0,#0x0	; 0230745E
	add r4,r1,#0x0	; 02307460
	ldr r0,[pool_023074D8]	; 02307462
	bl loc_02304EE8	; 02307464
	add r6,r0,#0x0	; 02307468
	cmp r4,#0x40	; 0230746A
	bcs loc_023074A2	; 0230746C
	add r0,r5,#0x0	; 0230746E
	bl loc_023073BC	; 02307470
	ldr r0,[pool_023074DC]	; 02307474
	ldr r2,[r0,#0x0]	; 02307476
	ldr r1,[pool_023074E0]	; 02307478
	add r1,r2,r1	; 0230747A
	ldrh r3,[r1,#0x0]	; 0230747C
	mov r2,#0x1	; 0230747E
	lsl r2,r5	; 02307480
	orr r3,r2	; 02307482
	strh r3,[r1,#0x0]	; 02307484
	ldr r1,[r0,#0x0]	; 02307486
	ldr r0,[pool_023074E4]	; 02307488
	ldrh r0,[r1,r0]	; 0230748A
	cmp r0,#0x1	; 0230748C
	bne loc_023074C4	; 0230748E
	add r0,r5,#0x0	; 02307490
	bl loc_0230728C	; 02307492
	cmp r0,#0x40	; 02307496
	bne loc_023074C4	; 02307498
	add r0,r5,#0x0	; 0230749A
	bl loc_0230729C	; 0230749C
	b loc_023074C4	; 023074A0
loc_023074A2:
	ldr r0,[pool_023074DC]	; 023074A2
	ldr r1,[r0,#0x0]	; 023074A4
	ldr r0,[pool_023074E0]	; 023074A6
	add r0,r1,r0	; 023074A8
	ldrh r2,[r0,#0x0]	; 023074AA
	mov r1,#0x1	; 023074AC
	lsl r1,r5	; 023074AE
	bic r2,r1	; 023074B0
	strh r2,[r0,#0x0]	; 023074B2
	add r0,r5,#0x0	; 023074B4
	bl loc_02307254	; 023074B6
	cmp r0,#0x0	; 023074BA
	beq loc_023074C4	; 023074BC
	add r0,r5,#0x0	; 023074BE
	bl loc_023073D8	; 023074C0
loc_023074C4:
	add r0,r5,#0x0	; 023074C4
	bl loc_023071CC	; 023074C6
	strh r4,[r0,#0x0]	; 023074CA
	add r0,r6,#0x0	; 023074CC
	bl loc_02304EF8	; 023074CE
	pop {r4,r5,r6}	; 023074D2
	pop {r3}	; 023074D4
	bx r3	; 023074D6
pool_023074D8:
loc_023074D8:
	.word 0x01000000	; 023074D8
pool_023074DC:
loc_023074DC:
	.word FirmwareWlWorkPointerSlot	; 023074DC
pool_023074E0:
loc_023074E0:
	.word 0x0000050A	; 023074E0
pool_023074E4:
loc_023074E4:
	.word 0x00000324	; 023074E4

; ===== function loc_023074E8 =====
loc_023074E8:
	push {r4,r5,r6,lr}	; 023074E8
	ldrh r6,[r0,#0x2]	; 023074EA
	add r0,r6,#0x0	; 023074EC
	bl loc_023071CC	; 023074EE
	add r5,r0,#0x0	; 023074F2
	ldr r0,[pool_02307528]	; 023074F4
	bl loc_02304EE8	; 023074F6
	add r4,r0,#0x0	; 023074FA
	ldr r0,[pool_0230752C]	; 023074FC
	ldr r1,[r0,#0x0]	; 023074FE
	ldr r0,[pool_02307530]	; 02307500
	ldrh r0,[r1,r0]	; 02307502
	cmp r0,#0x1	; 02307504
	bne loc_02307514	; 02307506
	ldrh r0,[r5,#0x16]	; 02307508
	cmp r0,#0x1	; 0230750A
	bne loc_02307514	; 0230750C
	add r0,r6,#0x0	; 0230750E
	bl loc_023070C8	; 02307510
loc_02307514:
	ldrh r0,[r5,#0x16]	; 02307514
	sub r0,r0,#0x1	; 02307516
	strh r0,[r5,#0x16]	; 02307518
	add r0,r4,#0x0	; 0230751A
	bl loc_02304EF8	; 0230751C
	pop {r4,r5,r6}	; 02307520
	pop {r3}	; 02307522
	bx r3	; 02307524
	.byte 0xC0, 0x46	; 02307528
pool_02307528:
loc_02307528:
	.word 0x01000000	; 02307528
pool_0230752C:
loc_0230752C:
	.word FirmwareWlWorkPointerSlot	; 0230752C
pool_02307530:
loc_02307530:
	.word 0x00000324	; 02307530

; ===== function loc_02307534 =====
loc_02307534:
	push {r4,r5,r6,lr}	; 02307534
	ldrh r6,[r0,#0x2]	; 02307536
	add r0,r6,#0x0	; 02307538
	bl loc_023071CC	; 0230753A
	add r5,r0,#0x0	; 0230753E
	ldr r0,[pool_02307578]	; 02307540
	bl loc_02304EE8	; 02307542
	add r4,r0,#0x0	; 02307546
	ldr r0,[pool_0230757C]	; 02307548
	ldr r1,[r0,#0x0]	; 0230754A
	ldr r0,[pool_02307580]	; 0230754C
	ldrh r0,[r1,r0]	; 0230754E
	cmp r0,#0x1	; 02307550
	bne loc_02307560	; 02307552
	ldrh r0,[r5,#0x16]	; 02307554
	cmp r0,#0x0	; 02307556
	bne loc_02307560	; 02307558
	add r0,r6,#0x0	; 0230755A
	bl loc_0230714C	; 0230755C
loc_02307560:
	ldrh r0,[r5,#0x16]	; 02307560
	add r0,r0,#0x1	; 02307562
	strh r0,[r5,#0x16]	; 02307564
	add r0,r4,#0x0	; 02307566
	bl loc_02304EF8	; 02307568
	ldrh r0,[r5,#0x1a]	; 0230756C
	strh r0,[r5,#0x18]	; 0230756E
	pop {r4,r5,r6}	; 02307570
	pop {r3}	; 02307572
	bx r3	; 02307574
	.byte 0xC0, 0x46	; 02307578
pool_02307578:
loc_02307578:
	.word 0x01000000	; 02307578
pool_0230757C:
loc_0230757C:
	.word FirmwareWlWorkPointerSlot	; 0230757C
pool_02307580:
loc_02307580:
	.word 0x00000324	; 02307580
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x0C, 0x48, 0x01, 0x68, 0x0C, 0x48, 0x0C, 0x18	; 02307594
	.byte 0x0C, 0x48, 0xFD, 0xF7, 0xA7, 0xFC, 0x07, 0x1C, 0x20, 0x89, 0x00, 0x28, 0x02, 0xD1, 0x00, 0x20	; 023075A4
	.byte 0xFF, 0xF7, 0xD2, 0xFD, 0x28, 0x1C, 0x21, 0x1C, 0x32, 0x1C, 0x00, 0xF0, 0x0D, 0xF8, 0x38, 0x1C	; 023075B4
	.byte 0xFD, 0xF7, 0xA0, 0xFC, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 023075C4
	.byte 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01	; 023075CC

; ===== function loc_023075CC =====
loc_023075CC:
	bx pc	; 023075CC
	.byte 0xC0, 0x46	; 023075D0
.arm

; ===== function loc_023075D0 =====
loc_023075D0:
	ldr r12,[pool_023075D8]	; 023075D0
	bx r12	; 023075D4
pool_023075D8:
loc_023075D8:
	.word loc_037FB6A0 + 1	; 023075D8
.thumb

; ===== function loc_023075DC =====
loc_023075DC:
	push {r4,r5,r6,r7,lr}	; 023075DC
	sub sp,#0xc	; 023075DE
	str r0,[sp,#0x0]	; 023075E0
	ldr r0,[pool_023076A0]	; 023075E2
	ldr r0,[r0,#0x0]	; 023075E4
	ldr r1,[pool_023076A4]	; 023075E6
	add r6,r0,r1	; 023075E8
	ldr r1,[sp,#0x0]	; 023075EA
	ldrh r1,[r1,#0x0]	; 023075EC
	mov r4,#0x1	; 023075EE
	and r1,r4	; 023075F0
	cmp r1,#0x0	; 023075F2
	beq loc_023075FA	; 023075F4
	mov r0,#0x0	; 023075F6
	b loc_02307698	; 023075F8
loc_023075FA:
	ldr r1,[pool_023076A8]	; 023075FA
	ldrh r1,[r0,r1]	; 023075FC
	cmp r1,#0x1	; 023075FE
	bls loc_0230764E	; 02307600
	ldr r5,[r6,#0x0]	; 02307602
	add r5,#0x1c	; 02307604
	mov r7,#0x0	; 02307606
	str r7,[sp,#0x4]	; 02307608
	b loc_02307642	; 0230760A
loc_0230760C:
	ldrh r1,[r5,#0x0]	; 0230760C
	cmp r1,#0x0	; 0230760E
	beq loc_02307638	; 02307610
	add r0,r5,#0x4	; 02307612
	ldr r1,[sp,#0x0]	; 02307614
	bl loc_023058B8	; 02307616
	cmp r0,#0x0	; 0230761A
	beq loc_02307622	; 0230761C
	add r0,r4,#0x0	; 0230761E
	b loc_02307698	; 02307620
loc_02307622:
	ldr r0,[sp,#0x4]	; 02307622
	add r0,r0,#0x1	; 02307624
	str r0,[sp,#0x4]	; 02307626
	ldr r0,[pool_023076A0]	; 02307628
	ldr r0,[r0,#0x0]	; 0230762A
	ldr r1,[pool_023076A8]	; 0230762C
	ldrh r2,[r0,r1]	; 0230762E
	ldr r1,[sp,#0x4]	; 02307630
	cmp r1,r2	; 02307632
	bcc loc_0230763E	; 02307634
	b loc_02307648	; 02307636
loc_02307638:
	cmp r7,#0x0	; 02307638
	bne loc_0230763E	; 0230763A
	add r7,r4,#0x0	; 0230763C
loc_0230763E:
	add r4,r4,#0x1	; 0230763E
	add r5,#0x1c	; 02307640
loc_02307642:
	ldrh r1,[r6,#0x6]	; 02307642
	cmp r4,r1	; 02307644
	bcc loc_0230760C	; 02307646
loc_02307648:
	cmp r7,#0x0	; 02307648
	beq loc_0230764E	; 0230764A
	add r4,r7,#0x0	; 0230764C
loc_0230764E:
	ldr r1,[pool_023076AC]	; 0230764E
	ldrh r0,[r0,r1]	; 02307650
	cmp r4,r0	; 02307652
	bcc loc_0230768E	; 02307654
	ldr r2,[r6,#0x0]	; 02307656
	ldr r5,[pool_023076B0]	; 02307658
	mov r1,#0x1	; 0230765A
	mov r4,#0x0	; 0230765C
	ldrh r3,[r6,#0x6]	; 0230765E
	mov r7,#0x1c	; 02307660
	b loc_02307682	; 02307662
loc_02307664:
	add r6,r1,#0x0	; 02307664
	mul r6,r7	; 02307666
	add r0,r2,r6	; 02307668
	ldrh r6,[r2,r6]	; 0230766A
	cmp r6,#0x30	; 0230766C
	bcs loc_02307680	; 0230766E
	ldrh r6,[r0,#0x16]	; 02307670
	cmp r6,#0x0	; 02307672
	bne loc_02307680	; 02307674
	ldrh r0,[r0,#0x18]	; 02307676
	cmp r5,r0	; 02307678
	bls loc_02307680	; 0230767A
	add r5,r0,#0x0	; 0230767C
	add r4,r1,#0x0	; 0230767E
loc_02307680:
	add r1,r1,#0x1	; 02307680
loc_02307682:
	cmp r1,r3	; 02307682
	bcc loc_02307664	; 02307684
	cmp r4,#0x0	; 02307686
	bne loc_0230768E	; 02307688
	mov r0,#0xff	; 0230768A
	b loc_02307698	; 0230768C
loc_0230768E:
	add r0,r4,#0x0	; 0230768E
	ldr r1,[sp,#0x0]	; 02307690
	bl loc_02306E4C	; 02307692
	add r0,r4,#0x0	; 02307696
loc_02307698:
	add sp,#0xc	; 02307698
	pop {r4,r5,r6,r7}	; 0230769A
	pop {r3}	; 0230769C
	bx r3	; 0230769E
pool_023076A0:
loc_023076A0:
	.word FirmwareWlWorkPointerSlot	; 023076A0
pool_023076A4:
loc_023076A4:
	.word 0x000002F0	; 023076A4
pool_023076A8:
loc_023076A8:
	.word 0x00000504	; 023076A8
pool_023076AC:
loc_023076AC:
	.word 0x000002F6	; 023076AC
pool_023076B0:
loc_023076B0:
	.word 0x00010000	; 023076B0

; ===== function loc_023076B4 =====
loc_023076B4:
	push {r4,r5,r6,r7,lr}	; 023076B4
	sub sp,#0x4	; 023076B6
	add r7,r0,#0x0	; 023076B8
	ldrh r0,[r7,#0x0]	; 023076BA
	mov r4,#0x1	; 023076BC
	and r0,r4	; 023076BE
	cmp r0,#0x0	; 023076C0
	beq loc_023076C8	; 023076C2
	mov r0,#0x0	; 023076C4
	b loc_02307710	; 023076C6
loc_023076C8:
	ldr r0,[pool_02307718]	; 023076C8
	ldr r0,[r0,#0x0]	; 023076CA
	ldr r1,[pool_0230771C]	; 023076CC
	ldrh r1,[r0,r1]	; 023076CE
	cmp r1,#0x1	; 023076D0
	bls loc_0230770E	; 023076D2
	ldr r1,[pool_02307720]	; 023076D4
	ldr r5,[r0,r1]	; 023076D6
	add r5,#0x1c	; 023076D8
	mov r6,#0x0	; 023076DA
	b loc_02307706	; 023076DC
loc_023076DE:
	ldrh r1,[r5,#0x0]	; 023076DE
	cmp r1,#0x0	; 023076E0
	beq loc_02307702	; 023076E2
	add r0,r5,#0x4	; 023076E4
	add r1,r7,#0x0	; 023076E6
	bl loc_023058B8	; 023076E8
	cmp r0,#0x0	; 023076EC
	beq loc_023076F4	; 023076EE
	add r0,r4,#0x0	; 023076F0
	b loc_02307710	; 023076F2
loc_023076F4:
	add r6,r6,#0x1	; 023076F4
	ldr r0,[pool_02307718]	; 023076F6
	ldr r0,[r0,#0x0]	; 023076F8
	ldr r1,[pool_0230771C]	; 023076FA
	ldrh r1,[r0,r1]	; 023076FC
	cmp r6,r1	; 023076FE
	bcs loc_0230770E	; 02307700
loc_02307702:
	add r4,r4,#0x1	; 02307702
	add r5,#0x1c	; 02307704
loc_02307706:
	ldr r1,[pool_02307724]	; 02307706
	ldrh r1,[r0,r1]	; 02307708
	cmp r4,r1	; 0230770A
	bcc loc_023076DE	; 0230770C
loc_0230770E:
	mov r0,#0xff	; 0230770E
loc_02307710:
	add sp,#0x4	; 02307710
	pop {r4,r5,r6,r7}	; 02307712
	pop {r3}	; 02307714
	bx r3	; 02307716
pool_02307718:
loc_02307718:
	.word FirmwareWlWorkPointerSlot	; 02307718
pool_0230771C:
loc_0230771C:
	.word 0x00000504	; 0230771C
pool_02307720:
loc_02307720:
	.word 0x000002F0	; 02307720
pool_02307724:
loc_02307724:
	.word 0x000002F6	; 02307724
loc_02307728:
	push {r4,lr}	; 02307728
	mov r4,#0x0	; 0230772A
	ldr r2,[pool_02307750]	; 0230772C
	mov r1,#0x1	; 0230772E
	ldr r0,[pool_02307754]	; 02307730
	b loc_02307742	; 02307732
loc_02307734:
	ldrh r3,[r2,#0x0]	; 02307734
	and r3,r1	; 02307736
	cmp r3,#0x0	; 02307738
	bne loc_02307740	; 0230773A
	mov r0,#0x0	; 0230773C
	b loc_02307748	; 0230773E
loc_02307740:
	add r4,r4,#0x1	; 02307740
loc_02307742:
	cmp r4,r0	; 02307742
	bcc loc_02307734	; 02307744
	mov r0,#0x1	; 02307746
loc_02307748:
	pop {r4}	; 02307748
	pop {r3}	; 0230774A
	bx r3	; 0230774C
	.byte 0xC0, 0x46	; 02307750
pool_02307750:
loc_02307750:
	.word 0x04808180	; 02307750
pool_02307754:
loc_02307754:
	.word 0x00002800	; 02307754

; ===== function loc_02307758 =====
loc_02307758:
	push {r4,lr}	; 02307758
	mov r4,#0x0	; 0230775A
	ldr r2,[pool_02307780]	; 0230775C
	mov r1,#0x1	; 0230775E
	ldr r0,[pool_02307784]	; 02307760
	b loc_02307772	; 02307762
loc_02307764:
	ldrh r3,[r2,#0x0]	; 02307764
	and r3,r1	; 02307766
	cmp r3,#0x0	; 02307768
	bne loc_02307770	; 0230776A
	mov r0,#0x0	; 0230776C
	b loc_02307778	; 0230776E
loc_02307770:
	add r4,r4,#0x1	; 02307770
loc_02307772:
	cmp r4,r0	; 02307772
	bcc loc_02307764	; 02307774
	mov r0,#0x1	; 02307776
loc_02307778:
	pop {r4}	; 02307778
	pop {r3}	; 0230777A
	bx r3	; 0230777C
	.byte 0xC0, 0x46	; 02307780
pool_02307780:
loc_02307780:
	.word 0x0480815E	; 02307780
pool_02307784:
loc_02307784:
	.word 0x00002800	; 02307784

; ===== function loc_02307788 =====
loc_02307788:
	ldr r2,[pool_023077A4]	; 02307788
	ldr r3,[pool_023077A8]	; 0230778A
	mov r0,#0x1	; 0230778C
loc_0230778E:
	ldrh r1,[r3,#0x0]	; 0230778E
	and r1,r0	; 02307790
	cmp r1,#0x0	; 02307792
	bne loc_0230778E	; 02307794
	ldrh r1,[r2,#0x0]	; 02307796
	cmp r1,#0x6	; 02307798
	beq loc_0230778E	; 0230779A
	ldrh r1,[r2,#0x0]	; 0230779C
	cmp r1,#0x5	; 0230779E
	beq loc_0230778E	; 023077A0
	bx lr	; 023077A2
pool_023077A4:
loc_023077A4:
	.word 0x04808214	; 023077A4
pool_023077A8:
loc_023077A8:
	.word REG_WIFI_RF_PINS	; 023077A8
loc_023077AC:
	push {r4,lr}	; 023077AC
	sub sp,#0x8	; 023077AE
	add r4,r1,#0x0	; 023077B0
	mov r1,#0x1	; 023077B2
	str r1,[sp,#0x4]	; 023077B4
	ldr r1,[pool_023077E8]	; 023077B6
	mul r0,r1	; 023077B8
	lsr r0,r0,#0x6	; 023077BA
	ldr r1,[pool_023077EC]	; 023077BC
	bl loc_023077F8	; 023077BE
	add r1,r0,#0x0	; 023077C2
	add r0,sp,#0x4	; 023077C4
	str r0,[sp,#0x0]	; 023077C6
	ldr r0,[pool_023077F0]	; 023077C8
	ldr r2,[r0,#0x0]	; 023077CA
	ldr r0,[pool_023077F4]	; 023077CC
	add r0,r2,r0	; 023077CE
	mov r2,#0x0	; 023077D0
	add r3,r4,#0x0	; 023077D2
	bl loc_023012D4	; 023077D4
loc_023077D8:
	ldr r0,[sp,#0x4]	; 023077D8
	cmp r0,#0x0	; 023077DA
	bne loc_023077D8	; 023077DC
	add sp,#0x8	; 023077DE
	pop {r4}	; 023077E0
	pop {r3}	; 023077E2
	bx r3	; 023077E4
	.byte 0xC0, 0x46	; 023077E8
pool_023077E8:
loc_023077E8:
	.word 0x000082EA	; 023077E8
pool_023077EC:
loc_023077EC:
	.word 0x000003E8	; 023077EC
pool_023077F0:
loc_023077F0:
	.word FirmwareWlWorkPointerSlot	; 023077F0
pool_023077F4:
loc_023077F4:
	.word 0x00000608	; 023077F4

; ===== function loc_023077F8 =====
loc_023077F8:
	bx pc	; 023077F8
	.byte 0xC0, 0x46	; 023077FC
.arm

; ===== function loc_023077FC =====
loc_023077FC:
	ldr pc,[pool_02307800]	; 023077FC
pool_02307800:
loc_02307800:
	.word loc_03804DB0	; 02307800
.thumb
P4_Entry_02307804:
	ldr r3,[pool_0230781C]	; 02307804
	ldr r1,[pool_02307820]	; 02307806
	mov r0,#0x80	; 02307808
	b P4_Entry_02307816	; 0230780A
P4_Entry_0230780C:
	ldrh r2,[r1,#0x0]	; 0230780C
	and r2,r0	; 0230780E
	cmp r2,#0x0	; 02307810
	bne P4_Entry_0230781A	; 02307812
	sub r3,r3,#0x1	; 02307814
P4_Entry_02307816:
	cmp r3,#0x0	; 02307816
	bne P4_Entry_0230780C	; 02307818
P4_Entry_0230781A:
	bx lr	; 0230781A
pool_0230781C:
	.word 0x00000FA0	; 0230781C
pool_02307820:
	.word 0x0480819C	; 02307820
.arm
.thumb

; ===== function loc_02307824 =====
loc_02307824:
	mov r2,#0x0	; 02307824
	ldr r0,[pool_02307830]	; 02307826
	ldr r1,[r0,#0x0]	; 02307828
	ldr r0,[pool_02307834]	; 0230782A
	strh r2,[r1,r0]	; 0230782C
	bx lr	; 0230782E
pool_02307830:
loc_02307830:
	.word FirmwareWlWorkPointerSlot	; 02307830
pool_02307834:
loc_02307834:
	.word 0x000003FC	; 02307834

; ===== function loc_02307838 =====
	push {r4,r5,r6,r7,lr}	; 02307838
	sub sp,#0x4	; 0230783A
	ldr r4,[pool_02307874]	; 0230783C
	ldr r1,[r4,#0x0]	; 0230783E
	ldr r6,[pool_02307878]	; 02307840
	ldr r5,[r1,r6]	; 02307842
	mov r7,#0x0	; 02307844
	b loc_02307866	; 02307846
loc_02307848:
	ldr r0,[pool_0230787C]	; 02307848
	ldr r0,[r1,r0]	; 0230784A
	add r1,r5,#0x0	; 0230784C
	add r2,r7,#0x0	; 0230784E
	bl loc_02300868	; 02307850
	cmp r0,#0x0	; 02307854
	beq loc_0230786C	; 02307856
	ldr r0,[r4,#0x0]	; 02307858
	add r0,r0,r6	; 0230785A
	add r1,r5,#0x0	; 0230785C
	bl loc_02307880	; 0230785E
	ldr r1,[r4,#0x0]	; 02307862
	ldr r5,[r1,r6]	; 02307864
loc_02307866:
	mvn r0,r7	; 02307866
	cmp r5,r0	; 02307868
	bne loc_02307848	; 0230786A
loc_0230786C:
	add sp,#0x4	; 0230786C
	pop {r4,r5,r6,r7}	; 0230786E
	pop {r3}	; 02307870
	bx r3	; 02307872
pool_02307874:
loc_02307874:
	.word FirmwareWlWorkPointerSlot	; 02307874
pool_02307878:
loc_02307878:
	.word 0x000001C8	; 02307878
pool_0230787C:
loc_0230787C:
	.word 0x000002D8	; 0230787C

; ===== function loc_02307880 =====
loc_02307880:
	bx pc	; 02307880
	.byte 0xC0, 0x46	; 02307884
.arm

; ===== function loc_02307884 =====
loc_02307884:
	ldr r12,[pool_0230788C]	; 02307884
	bx r12	; 02307888
pool_0230788C:
loc_0230788C:
	.word loc_037FB550 + 1	; 0230788C
	.byte 0x03, 0x20, 0x70, 0x47	; 02307894
.thumb

; ===== function loc_02307894 =====
loc_02307894:
	push {lr}	; 02307894
	sub sp,#0x4	; 02307896
	mov r1,#0x0	; 02307898
	add r0,sp,#0x0	; 0230789A
	strh r1,[r0,#0x0]	; 0230789C
	ldrh r0,[r0,#0x0]	; 0230789E
	ldr r1,[pool_023078B4]	; 023078A0
	ldr r2,[r1,#0x0]	; 023078A2
	ldr r1,[pool_023078B8]	; 023078A4
	add r1,r2,r1	; 023078A6
	mov r2,#0x20	; 023078A8
	bl loc_023078BC	; 023078AA
	add sp,#0x4	; 023078AE
	pop {r3}	; 023078B0
	bx r3	; 023078B2
pool_023078B4:
loc_023078B4:
	.word FirmwareWlWorkPointerSlot	; 023078B4
pool_023078B8:
loc_023078B8:
	.word 0x000003D8	; 023078B8

; ===== function loc_023078BC =====
loc_023078BC:
	bx pc	; 023078BC
	.byte 0xC0, 0x46	; 023078C0
.arm

; ===== function loc_023078C0 =====
loc_023078C0:
	ldr pc,[pool_023078C4]	; 023078C0
pool_023078C4:
loc_023078C4:
	.word loc_037FF31C	; 023078C4
.thumb

; ===== function loc_023078C8 =====
loc_023078C8:
	push {r4,r5,r6,r7,lr}	; 023078C8
	sub sp,#0x4	; 023078CA
	add r6,r0,#0x0	; 023078CC
	ldr r0,[pool_023079A0]	; 023078CE
	ldr r2,[r0,#0x0]	; 023078D0
	ldr r0,[pool_023079A4]	; 023078D2
	add r5,r2,r0	; 023078D4
	ldr r0,[pool_023079A8]	; 023078D6
	add r0,r2,r0	; 023078D8
	ldr r1,[pool_023079AC]	; 023078DA
	ldrh r1,[r2,r1]	; 023078DC
	add r1,#0x3e	; 023078DE
	bl loc_02304D60	; 023078E0
	add r4,r0,#0x0	; 023078E4
	cmp r4,#0x0	; 023078E6
	bne loc_023078F4	; 023078E8
	mov r0,#0x1	; 023078EA
	bl loc_02304F18	; 023078EC
	mov r0,#0x0	; 023078F0
	b loc_02307996	; 023078F2
loc_023078F4:
	mov r0,#0x8d	; 023078F4
	strh r0,[r4,#0xc]	; 023078F6
	add r0,r5,#0x0	; 023078F8
	add r0,#0xa0	; 023078FA
	ldrh r0,[r0,#0x0]	; 023078FC
	add r0,r0,#0x1	; 023078FE
	mov r1,#0x2	; 02307900
	bl loc_023079B0	; 02307902
	add r0,#0x16	; 02307906
	strh r0,[r4,#0xe]	; 02307908
	add r0,r4,#0x0	; 0230790A
	add r0,#0x1f	; 0230790C
	ldrh r1,[r6,#0x12]	; 0230790E
	lsl r1,r1,#0x18	; 02307910
	lsr r1,r1,#0x18	; 02307912
	bl loc_023051A4	; 02307914
	add r0,r4,#0x0	; 02307918
	add r0,#0x1e	; 0230791A
	ldrh r1,[r6,#0xe]	; 0230791C
	lsl r1,r1,#0x18	; 0230791E
	lsr r1,r1,#0x18	; 02307920
	bl loc_023051A4	; 02307922
	add r0,r4,#0x0	; 02307926
	add r0,#0x2e	; 02307928
	add r6,#0x1e	; 0230792A
	add r1,r6,#0x0	; 0230792C
	bl loc_02305B7C	; 0230792E
	add r0,r5,#0x0	; 02307932
	add r0,#0xa0	; 02307934
	ldrh r0,[r0,#0x0]	; 02307936
	strh r0,[r4,#0x16]	; 02307938
	ldrh r2,[r4,#0x16]	; 0230793A
	cmp r2,#0x0	; 0230793C
	beq loc_02307986	; 0230793E
	add r0,r5,#0x0	; 02307940
	add r0,#0xa2	; 02307942
	ldrh r1,[r0,#0x0]	; 02307944
	mov r0,#0x1	; 02307946
	and r1,r0	; 02307948
	cmp r1,#0x0	; 0230794A
	beq loc_02307978	; 0230794C
	add r5,#0x9c	; 0230794E
	ldr r0,[r5,#0x0]	; 02307950
	add r6,r0,#0x1	; 02307952
	add r7,r4,#0x0	; 02307954
	add r7,#0x3c	; 02307956
	mov r5,#0x0	; 02307958
	b loc_02307970	; 0230795A
loc_0230795C:
	add r0,r6,#0x0	; 0230795C
	bl loc_02305180	; 0230795E
	add r1,r0,#0x0	; 02307962
	add r0,r7,#0x0	; 02307964
	bl loc_023051A4	; 02307966
	add r6,r6,#0x1	; 0230796A
	add r7,r7,#0x1	; 0230796C
	add r5,r5,#0x1	; 0230796E
loc_02307970:
	ldrh r0,[r4,#0x16]	; 02307970
	cmp r5,r0	; 02307972
	bcc loc_0230795C	; 02307974
	b loc_02307986	; 02307976
loc_02307978:
	add r5,#0x9c	; 02307978
	ldr r0,[r5,#0x0]	; 0230797A
	add r1,r4,#0x0	; 0230797C
	add r1,#0x3c	; 0230797E
	add r2,r2,#0x1	; 02307980
	bl loc_023079BC	; 02307982
loc_02307986:
	ldr r0,[pool_023079A0]	; 02307986
	ldr r1,[r0,#0x0]	; 02307988
	ldr r0,[pool_023079A8]	; 0230798A
	add r0,r1,r0	; 0230798C
	add r1,r4,#0x0	; 0230798E
	bl loc_02304F08	; 02307990
	mov r0,#0x1	; 02307994
loc_02307996:
	add sp,#0x4	; 02307996
	pop {r4,r5,r6,r7}	; 02307998
	pop {r3}	; 0230799A
	bx r3	; 0230799C
	.byte 0xC0, 0x46	; 023079A0
pool_023079A0:
loc_023079A0:
	.word FirmwareWlWorkPointerSlot	; 023079A0
pool_023079A4:
loc_023079A4:
	.word 0x00000318	; 023079A4
pool_023079A8:
loc_023079A8:
	.word 0x0000015C	; 023079A8
pool_023079AC:
loc_023079AC:
	.word 0x000003B8	; 023079AC

; ===== function loc_023079B0 =====
loc_023079B0:
	bx pc	; 023079B0
	.byte 0xC0, 0x46	; 023079B4
.arm

; ===== function loc_023079B4 =====
loc_023079B4:
	ldr pc,[pool_023079B8]	; 023079B4
pool_023079B8:
loc_023079B8:
	.word P2_SignedDivMod	; 023079B8
.thumb

; ===== function loc_023079BC =====
loc_023079BC:
	bx pc	; 023079BC
	.byte 0xC0, 0x46	; 023079C0
.arm

; ===== function loc_023079C0 =====
loc_023079C0:
	ldr pc,[pool_023079C4]	; 023079C0
pool_023079C4:
loc_023079C4:
	.word P2_Entry_037FF334	; 023079C4
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x0E, 0x48, 0x01, 0x68, 0x0E, 0x48, 0x08, 0x18, 0x10, 0x21, 0xFD, 0xF7	; 023079D8
	.byte 0xC3, 0xF9, 0x01, 0x1C, 0x00, 0x29, 0x04, 0xD1, 0x01, 0x20, 0xFD, 0xF7, 0x99, 0xFA, 0x00, 0x20	; 023079E8
	.byte 0x0A, 0xE0, 0x8C, 0x20, 0x88, 0x81, 0x00, 0x20, 0xC8, 0x81, 0x05, 0x48, 0x02, 0x68, 0x05, 0x48	; 023079F8
	.byte 0x10, 0x18, 0xFD, 0xF7, 0x85, 0xFA, 0x01, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02307A08
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x5C, 0x01, 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x12, 0x48	; 02307A18
	.byte 0x01, 0x68, 0x12, 0x48, 0x08, 0x18, 0x16, 0x21, 0xFD, 0xF7, 0x9E, 0xF9, 0x04, 0x1C, 0x00, 0x2C	; 02307A28
	.byte 0x04, 0xD1, 0x01, 0x20, 0xFD, 0xF7, 0x74, 0xFA, 0x00, 0x20, 0x10, 0xE0, 0x8B, 0x20, 0xA0, 0x81	; 02307A38
	.byte 0x03, 0x20, 0xE0, 0x81, 0x20, 0x1C, 0x10, 0x30, 0x29, 0x1C, 0xFE, 0xF7, 0x9B, 0xF8, 0x06, 0x48	; 02307A48
	.byte 0x01, 0x68, 0x06, 0x48, 0x08, 0x18, 0x21, 0x1C, 0xFD, 0xF7, 0x5A, 0xFA, 0x01, 0x20, 0x01, 0xB0	; 02307A58
	.byte 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x5C, 0x01, 0x00, 0x00	; 02307A68
.thumb

; ===== function loc_02307A68 =====
loc_02307A68:
	push {r4,r5,r6,lr}	; 02307A68
	add r6,r0,#0x0	; 02307A6A
	add r5,r1,#0x0	; 02307A6C
	ldr r0,[pool_02307AB8]	; 02307A6E
	ldr r1,[r0,#0x0]	; 02307A70
	ldr r0,[pool_02307ABC]	; 02307A72
	add r0,r1,r0	; 02307A74
	mov r1,#0x18	; 02307A76
	bl loc_02304D60	; 02307A78
	add r4,r0,#0x0	; 02307A7C
	cmp r4,#0x0	; 02307A7E
	bne loc_02307A8C	; 02307A80
	mov r0,#0x1	; 02307A82
	bl loc_02304F18	; 02307A84
	mov r0,#0x0	; 02307A88
	b loc_02307AB0	; 02307A8A
loc_02307A8C:
	mov r0,#0x88	; 02307A8C
	strh r0,[r4,#0xc]	; 02307A8E
	mov r0,#0x4	; 02307A90
	strh r0,[r4,#0xe]	; 02307A92
	add r0,r4,#0x0	; 02307A94
	add r0,#0x10	; 02307A96
	add r1,r6,#0x0	; 02307A98
	bl loc_02305B7C	; 02307A9A
	strh r5,[r4,#0x16]	; 02307A9E
	ldr r0,[pool_02307AB8]	; 02307AA0
	ldr r1,[r0,#0x0]	; 02307AA2
	ldr r0,[pool_02307ABC]	; 02307AA4
	add r0,r1,r0	; 02307AA6
	add r1,r4,#0x0	; 02307AA8
	bl loc_02304F08	; 02307AAA
	mov r0,#0x1	; 02307AAE
loc_02307AB0:
	pop {r4,r5,r6}	; 02307AB0
	pop {r3}	; 02307AB2
	bx r3	; 02307AB4
	.byte 0xC0, 0x46	; 02307AB8
pool_02307AB8:
loc_02307AB8:
	.word FirmwareWlWorkPointerSlot	; 02307AB8
pool_02307ABC:
loc_02307ABC:
	.word 0x0000015C	; 02307ABC
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x07, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0x22, 0x48, 0x01, 0x68, 0x22, 0x48	; 02307AD0
	.byte 0x08, 0x18, 0x3A, 0x21, 0xFD, 0xF7, 0x44, 0xF9, 0x05, 0x1C, 0x00, 0x2D, 0x04, 0xD1, 0x01, 0x20	; 02307AE0
	.byte 0xFD, 0xF7, 0x1A, 0xFA, 0x00, 0x20, 0x31, 0xE0, 0x87, 0x20, 0xA8, 0x81, 0x15, 0x20, 0xE8, 0x81	; 02307AF0
	.byte 0x28, 0x1C, 0x10, 0x30, 0x39, 0x1C, 0xFE, 0xF7, 0x41, 0xF8, 0xEC, 0x82, 0x70, 0x1C, 0xFD, 0xF7	; 02307B00
	.byte 0x3F, 0xFB, 0x28, 0x83, 0x00, 0x24, 0xB6, 0x1C, 0x2F, 0x1C, 0x1A, 0x37, 0x09, 0xE0, 0x20, 0x2C	; 02307B10
	.byte 0x12, 0xD2, 0x30, 0x19, 0xFD, 0xF7, 0x34, 0xFB, 0x01, 0x1C, 0x38, 0x19, 0xFD, 0xF7, 0x42, 0xFB	; 02307B20
	.byte 0x64, 0x1C, 0x28, 0x8B, 0x84, 0x42, 0xF2, 0xD3, 0x06, 0xE0, 0x28, 0x1C, 0x1A, 0x30, 0x00, 0x19	; 02307B30
	.byte 0x00, 0x21, 0xFD, 0xF7, 0x37, 0xFB, 0x64, 0x1C, 0x20, 0x2C, 0xF6, 0xD3, 0x05, 0x48, 0x01, 0x68	; 02307B40
	.byte 0x05, 0x48, 0x08, 0x18, 0x29, 0x1C, 0xFD, 0xF7, 0xDF, 0xF9, 0x01, 0x20, 0x01, 0xB0, 0xF0, 0xBC	; 02307B50
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x5C, 0x01, 0x00, 0x00, 0xF0, 0xB5, 0x81, 0xB0	; 02307B60
	.byte 0x07, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0x23, 0x48, 0x01, 0x68, 0x23, 0x48, 0x08, 0x18, 0x3A, 0x21	; 02307B70
	.byte 0xFD, 0xF7, 0xF6, 0xF8, 0x05, 0x1C, 0x00, 0x2D, 0x04, 0xD1, 0x01, 0x20, 0xFD, 0xF7, 0xCC, 0xF9	; 02307B80
	.byte 0x00, 0x20, 0x33, 0xE0, 0x86, 0x20, 0xA8, 0x81, 0x15, 0x20, 0xE8, 0x81, 0x28, 0x1C, 0x10, 0x30	; 02307B90
	.byte 0x39, 0x1C, 0xFD, 0xF7, 0xF3, 0xFF, 0x19, 0x48, 0x04, 0x40, 0xEC, 0x82, 0x70, 0x1C, 0xFD, 0xF7	; 02307BA0
	.byte 0xEF, 0xFA, 0x28, 0x83, 0x00, 0x24, 0xB6, 0x1C, 0x2F, 0x1C, 0x1A, 0x37, 0x09, 0xE0, 0x20, 0x2C	; 02307BB0
	.byte 0x12, 0xD2, 0x30, 0x19, 0xFD, 0xF7, 0xE4, 0xFA, 0x01, 0x1C, 0x38, 0x19, 0xFD, 0xF7, 0xF2, 0xFA	; 02307BC0
	.byte 0x64, 0x1C, 0x28, 0x8B, 0x84, 0x42, 0xF2, 0xD3, 0x06, 0xE0, 0x28, 0x1C, 0x1A, 0x30, 0x00, 0x19	; 02307BD0
	.byte 0x00, 0x21, 0xFD, 0xF7, 0xE7, 0xFA, 0x64, 0x1C, 0x20, 0x2C, 0xF6, 0xD3, 0x05, 0x48, 0x01, 0x68	; 02307BE0
	.byte 0x05, 0x48, 0x08, 0x18, 0x29, 0x1C, 0xFD, 0xF7, 0x8F, 0xF9, 0x01, 0x20, 0x01, 0xB0, 0xF0, 0xBC	; 02307BF0
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x5C, 0x01, 0x00, 0x00, 0xFF, 0x0F, 0x00, 0x00	; 02307C00

; ===== function loc_02307C00 =====
loc_02307C00:
	push {r4,r5,r6,lr}	; 02307C00
	add r6,r0,#0x0	; 02307C02
	add r5,r1,#0x0	; 02307C04
	ldr r0,[pool_02307C50]	; 02307C06
	ldr r1,[r0,#0x0]	; 02307C08
	ldr r0,[pool_02307C54]	; 02307C0A
	add r0,r1,r0	; 02307C0C
	mov r1,#0x18	; 02307C0E
	bl loc_02304D60	; 02307C10
	add r4,r0,#0x0	; 02307C14
	cmp r4,#0x0	; 02307C16
	bne loc_02307C24	; 02307C18
	mov r0,#0x1	; 02307C1A
	bl loc_02304F18	; 02307C1C
	mov r0,#0x0	; 02307C20
	b loc_02307C48	; 02307C22
loc_02307C24:
	mov r0,#0x85	; 02307C24
	strh r0,[r4,#0xc]	; 02307C26
	mov r0,#0x4	; 02307C28
	strh r0,[r4,#0xe]	; 02307C2A
	add r0,r4,#0x0	; 02307C2C
	add r0,#0x10	; 02307C2E
	add r1,r6,#0x0	; 02307C30
	bl loc_02305B7C	; 02307C32
	strh r5,[r4,#0x16]	; 02307C36
	ldr r0,[pool_02307C50]	; 02307C38
	ldr r1,[r0,#0x0]	; 02307C3A
	ldr r0,[pool_02307C54]	; 02307C3C
	add r0,r1,r0	; 02307C3E
	add r1,r4,#0x0	; 02307C40
	bl loc_02304F08	; 02307C42
	mov r0,#0x1	; 02307C46
loc_02307C48:
	pop {r4,r5,r6}	; 02307C48
	pop {r3}	; 02307C4A
	bx r3	; 02307C4C
	.byte 0xC0, 0x46	; 02307C50
pool_02307C50:
loc_02307C50:
	.word FirmwareWlWorkPointerSlot	; 02307C50
pool_02307C54:
loc_02307C54:
	.word 0x0000015C	; 02307C54
	.byte 0x70, 0xB5, 0x06, 0x1C, 0x0D, 0x1C, 0x12, 0x48, 0x01, 0x68, 0x12, 0x48, 0x08, 0x18, 0x18, 0x21	; 02307C68
	.byte 0xFD, 0xF7, 0x7A, 0xF8, 0x04, 0x1C, 0x00, 0x2C, 0x04, 0xD1, 0x01, 0x20, 0xFD, 0xF7, 0x50, 0xF9	; 02307C78
	.byte 0x00, 0x20, 0x11, 0xE0, 0x84, 0x20, 0xA0, 0x81, 0x04, 0x20, 0xE0, 0x81, 0x20, 0x1C, 0x10, 0x30	; 02307C88
	.byte 0x31, 0x1C, 0xFD, 0xF7, 0x77, 0xFF, 0xE5, 0x82, 0x05, 0x48, 0x01, 0x68, 0x05, 0x48, 0x08, 0x18	; 02307C98
	.byte 0x21, 0x1C, 0xFD, 0xF7, 0x35, 0xF9, 0x01, 0x20, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02307CA8
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x5C, 0x01, 0x00, 0x00	; 02307CB0

; ===== function loc_02307CB0 =====
loc_02307CB0:
	push {r4,lr}	; 02307CB0
	ldr r0,[pool_02307CE8]	; 02307CB2
	ldr r1,[r0,#0x0]	; 02307CB4
	ldr r0,[pool_02307CEC]	; 02307CB6
	add r4,r1,r0	; 02307CB8
	ldr r0,[pool_02307CF0]	; 02307CBA
	add r2,r1,r0	; 02307CBC
	ldrh r1,[r2,#0x4]	; 02307CBE
	mov r0,#0x1	; 02307CC0
	bic r1,r0	; 02307CC2
	strh r1,[r2,#0x4]	; 02307CC4
	add r0,r4,#0x0	; 02307CC6
	add r0,#0x84	; 02307CC8
	ldr r1,[r2,#0x0]	; 02307CCA
	bl loc_02304F08	; 02307CCC
	add r4,#0x8c	; 02307CD0
	ldrh r0,[r4,#0x0]	; 02307CD2
	cmp r0,#0x0	; 02307CD4
	beq loc_02307CE0	; 02307CD6
	mov r0,#0x2	; 02307CD8
	mov r1,#0xb	; 02307CDA
	bl loc_02304BE8	; 02307CDC
loc_02307CE0:
	pop {r4}	; 02307CE0
	pop {r3}	; 02307CE2
	bx r3	; 02307CE4
	.byte 0xC0, 0x46	; 02307CE8
pool_02307CE8:
loc_02307CE8:
	.word FirmwareWlWorkPointerSlot	; 02307CE8
pool_02307CEC:
loc_02307CEC:
	.word 0x00000150	; 02307CEC
pool_02307CF0:
loc_02307CF0:
	.word 0x000003F8	; 02307CF0
	.byte 0x02, 0x48, 0x01, 0x68, 0x02, 0x48, 0x08, 0x18, 0x02, 0x4B, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 02307D04
	.byte 0x9A, 0x03, 0x00, 0x00, 0x11, 0x7A, 0x30, 0x02	; 02307D0C
	mov r2,#0x83	; 02307D0C
	ldr r0,[pool_02307D20]	; 02307D0E
	ldr r1,[r0,#0x0]	; 02307D10
	ldr r0,[pool_02307D24]	; 02307D12
	strh r2,[r1,r0]	; 02307D14
	mov r0,#0x2	; 02307D16
	mov r1,#0x5	; 02307D18
	ldr r3,[pool_02307D28]	; 02307D1A
	bx r3	; 02307D1C
	.byte 0xC0, 0x46	; 02307D20
pool_02307D20:
loc_02307D20:
	.word FirmwareWlWorkPointerSlot	; 02307D20
pool_02307D24:
loc_02307D24:
	.word 0x000003D8	; 02307D24
pool_02307D28:
loc_02307D28:
	.word loc_037FB3C4 + 1	; 02307D28

; ===== function loc_02307D2C =====
	push {r4,r5,lr}	; 02307D2C
	sub sp,#0x4	; 02307D2E
	ldr r0,[pool_02307EAC]	; 02307D30
	ldr r1,[r0,#0x0]	; 02307D32
	ldr r0,[pool_02307EB0]	; 02307D34
	add r5,r1,r0	; 02307D36
	ldr r0,[pool_02307EB4]	; 02307D38
	add r4,r1,r0	; 02307D3A
	ldrh r0,[r4,#0x0]	; 02307D3C
	sub r0,#0x80	; 02307D3E
	cmp r0,#0x4	; 02307D40
	bls loc_02307D46	; 02307D42
	b loc_02307E96	; 02307D44
loc_02307D46:
	add r0,r0,r0	; 02307D46
P4_SwitchIndexPC_02307D46:
	add r0,pc	; 02307D48
	ldrh r0,[r0,#(P4_SwitchTable_02307D46 - (P4_SwitchIndexPC_02307D46 + 4))]	; 02307D4A
	lsl r0,r0,#0x10	; 02307D4C
	asr r0,r0,#0x10	; 02307D4E
P4_SwitchTargetPC_02307D46:
	add r0,pc	; 02307D50
	bx r0	; 02307D52
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02307D46:
	.halfword (loc_02307D5E + 1) - (P4_SwitchTargetPC_02307D46 + 4)
	.halfword (loc_02307D84 + 1) - (P4_SwitchTargetPC_02307D46 + 4)
	.halfword (loc_02307DF6 + 1) - (P4_SwitchTargetPC_02307D46 + 4)
	.halfword (loc_02307E10 + 1) - (P4_SwitchTargetPC_02307D46 + 4)
	.halfword (loc_02307E52 + 1) - (P4_SwitchTargetPC_02307D46 + 4)
P4_SwitchTable_02307D46End:
loc_02307D5E:
	mov r0,#0x0	; 02307D5E
	strh r0,[r4,#0x14]	; 02307D60
	mov r0,#0x13	; 02307D62
	bl loc_023057BC	; 02307D64
	strh r0,[r4,#0xe]	; 02307D68
	mov r0,#0x35	; 02307D6A
	bl loc_023057BC	; 02307D6C
	strh r0,[r4,#0x10]	; 02307D70
	ldr r1,[r4,#0x18]	; 02307D72
	ldrh r0,[r1,#0x12]	; 02307D74
	ldrh r1,[r1,#0x14]	; 02307D76
	bl loc_02306508	; 02307D78
	mov r0,#0x4	; 02307D7C
	strh r0,[r5,#0xc]	; 02307D7E
	mov r0,#0x0	; 02307D80
	strh r0,[r4,#0x16]	; 02307D82
loc_02307D84:
	mov r0,#0x0	; 02307D84
	str r0,[r4,#0x4]	; 02307D86
	str r0,[r4,#0x8]	; 02307D88
	ldr r1,[r4,#0x18]	; 02307D8A
	add r1,#0x18	; 02307D8C
	ldrh r0,[r4,#0x14]	; 02307D8E
	add r0,r1,r0	; 02307D90
	bl loc_02305180	; 02307D92
	add r5,r0,#0x0	; 02307D96
	cmp r5,#0x0	; 02307D98
	beq loc_02307DA2	; 02307D9A
	ldrh r0,[r4,#0x14]	; 02307D9C
	cmp r0,#0x10	; 02307D9E
	bcc loc_02307DA8	; 02307DA0
loc_02307DA2:
	mov r0,#0x84	; 02307DA2
	strh r0,[r4,#0x0]	; 02307DA4
	b loc_02307E96	; 02307DA6
loc_02307DA8:
	mov r0,#0x0	; 02307DA8
	bl loc_0230D490	; 02307DAA
	cmp r0,#0x0	; 02307DAE
	beq loc_02307DBC	; 02307DB0
	mov r0,#0xe	; 02307DB2
	strh r0,[r4,#0x16]	; 02307DB4
	mov r0,#0x84	; 02307DB6
	strh r0,[r4,#0x0]	; 02307DB8
	b loc_02307E96	; 02307DBA
loc_02307DBC:
	ldrh r0,[r4,#0x0]	; 02307DBC
	cmp r0,#0x80	; 02307DBE
	bne loc_02307DDE	; 02307DC0
	lsl r0,r5,#0x10	; 02307DC2
	lsr r0,r0,#0x10	; 02307DC4
	mov r1,#0x0	; 02307DC6
	bl loc_02305F8C	; 02307DC8
	bl loc_02307ECC	; 02307DCC
	ldr r0,[pool_02307EB8]	; 02307DD0
	ldrh r0,[r0,#0x0]	; 02307DD2
	strh r0,[r4,#0xc]	; 02307DD4
	ldr r0,[pool_02307EBC]	; 02307DD6
	bl loc_02305E84	; 02307DD8
	b loc_02307DE8	; 02307DDC
loc_02307DDE:
	lsl r0,r5,#0x10	; 02307DDE
	lsr r0,r0,#0x10	; 02307DE0
	mov r1,#0x0	; 02307DE2
	bl loc_02305F8C	; 02307DE4
loc_02307DE8:
	mov r0,#0x82	; 02307DE8
	strh r0,[r4,#0x0]	; 02307DEA
	ldr r0,[r4,#0x18]	; 02307DEC
	ldrh r0,[r0,#0x16]	; 02307DEE
	ldr r1,[pool_02307EC0]	; 02307DF0
	bl loc_023053C8	; 02307DF2
loc_02307DF6:
	ldr r0,[r4,#0x4]	; 02307DF6
	add r0,r0,#0x1	; 02307DF8
	str r0,[r4,#0x4]	; 02307DFA
	ldr r0,[pool_02307EC4]	; 02307DFC
	ldrh r1,[r0,#0x0]	; 02307DFE
	mov r0,#0x1	; 02307E00
	and r1,r0	; 02307E02
	cmp r1,#0x0	; 02307E04
	beq loc_02307E96	; 02307E06
	ldr r0,[r4,#0x8]	; 02307E08
	add r0,#0x64	; 02307E0A
	str r0,[r4,#0x8]	; 02307E0C
	b loc_02307E96	; 02307E0E
loc_02307E10:
	ldr r1,[r4,#0x18]	; 02307E10
	add r1,#0x18	; 02307E12
	ldrh r0,[r4,#0x14]	; 02307E14
	add r0,r1,r0	; 02307E16
	bl loc_02305180	; 02307E18
	add r5,r0,#0x0	; 02307E1C
	mov r2,#0x0	; 02307E1E
	ldr r1,[r4,#0x4]	; 02307E20
	cmp r1,#0x0	; 02307E22
	beq loc_02307E38	; 02307E24
	ldr r0,[r4,#0x8]	; 02307E26
	cmp r0,#0x0	; 02307E28
	beq loc_02307E38	; 02307E2A
	bl loc_02307EDC	; 02307E2C
	add r2,r0,#0x1	; 02307E30
	cmp r2,#0x64	; 02307E32
	bls loc_02307E38	; 02307E34
	mov r2,#0x64	; 02307E36
loc_02307E38:
	lsl r0,r2,#0x8	; 02307E38
	orr r5,r0	; 02307E3A
	ldr r1,[r4,#0x1c]	; 02307E3C
	ldrh r0,[r4,#0x14]	; 02307E3E
	lsl r0,r0,#0x1	; 02307E40
	add r0,r1,r0	; 02307E42
	strh r5,[r0,#0x8]	; 02307E44
	ldrh r0,[r4,#0x14]	; 02307E46
	add r0,r0,#0x1	; 02307E48
	strh r0,[r4,#0x14]	; 02307E4A
	mov r0,#0x81	; 02307E4C
	strh r0,[r4,#0x0]	; 02307E4E
	b loc_02307E96	; 02307E50
loc_02307E52:
	bl loc_02304E58	; 02307E52
	ldr r0,[pool_02307EAC]	; 02307E56
	ldr r1,[r0,#0x0]	; 02307E58
	ldr r0,[pool_02307EC8]	; 02307E5A
	ldrh r0,[r1,r0]	; 02307E5C
	strh r0,[r5,#0xc]	; 02307E5E
	mov r0,#0x13	; 02307E60
	ldrh r1,[r4,#0xe]	; 02307E62
	bl loc_02305788	; 02307E64
	mov r0,#0x35	; 02307E68
	ldrh r1,[r4,#0x10]	; 02307E6A
	bl loc_02305788	; 02307E6C
	ldrh r0,[r4,#0xc]	; 02307E70
	bl loc_02305E84	; 02307E72
	ldrh r1,[r4,#0x16]	; 02307E76
	ldr r0,[r4,#0x1c]	; 02307E78
	strh r1,[r0,#0x4]	; 02307E7A
	mov r2,#0x0	; 02307E7C
	strh r2,[r4,#0x0]	; 02307E7E
	ldrh r3,[r4,#0x14]	; 02307E80
	b loc_02307E8E	; 02307E82
loc_02307E84:
	ldr r1,[r4,#0x1c]	; 02307E84
	lsl r0,r3,#0x1	; 02307E86
	add r0,r1,r0	; 02307E88
	strh r2,[r0,#0x8]	; 02307E8A
	add r3,r3,#0x1	; 02307E8C
loc_02307E8E:
	cmp r3,#0x10	; 02307E8E
	bcc loc_02307E84	; 02307E90
	bl loc_02307CB0	; 02307E92
loc_02307E96:
	ldrh r0,[r4,#0x0]	; 02307E96
	cmp r0,#0x0	; 02307E98
	beq loc_02307EA4	; 02307E9A
	mov r0,#0x2	; 02307E9C
	mov r1,#0x5	; 02307E9E
	bl loc_02304BE8	; 02307EA0
loc_02307EA4:
	add sp,#0x4	; 02307EA4
	pop {r4,r5}	; 02307EA6
	pop {r3}	; 02307EA8
	bx r3	; 02307EAA
pool_02307EAC:
loc_02307EAC:
	.word FirmwareWlWorkPointerSlot	; 02307EAC
pool_02307EB0:
loc_02307EB0:
	.word 0x00000318	; 02307EB0
pool_02307EB4:
loc_02307EB4:
	.word 0x000003D8	; 02307EB4
pool_02307EB8:
loc_02307EB8:
	.word REG_WIFI_POWERFORCE	; 02307EB8
pool_02307EBC:
loc_02307EBC:
	.word 0x00008000	; 02307EBC
pool_02307EC0:
loc_02307EC0:
	.word 0x02307D0D	; 02307EC0
pool_02307EC4:
loc_02307EC4:
	.word REG_WIFI_RF_PINS	; 02307EC4
pool_02307EC8:
loc_02307EC8:
	.word 0x00000302	; 02307EC8

; ===== function loc_02307ECC =====
loc_02307ECC:
	bx pc	; 02307ECC
	.byte 0xC0, 0x46	; 02307ED0
.arm

; ===== function loc_02307ED0 =====
loc_02307ED0:
	ldr r12,[pool_02307ED8]	; 02307ED0
	bx r12	; 02307ED4
pool_02307ED8:
loc_02307ED8:
	.word P2_Entry_037FB9C8 + 1	; 02307ED8
.thumb

; ===== function loc_02307EDC =====
loc_02307EDC:
	bx pc	; 02307EDC
	.byte 0xC0, 0x46	; 02307EE0
.arm

; ===== function loc_02307EE0 =====
loc_02307EE0:
	ldr pc,[pool_02307EE4]	; 02307EE0
pool_02307EE4:
loc_02307EE4:
	.word loc_03804DB0	; 02307EE4
.thumb
	bx lr	; 02307EE8
	.byte 0x00, 0x00	; 02307EEC
	ldr r0,[pool_02307F08]	; 02307EEC
	ldr r1,[r0,#0x0]	; 02307EEE
	ldr r0,[pool_02307F0C]	; 02307EF0
	add r2,r1,r0	; 02307EF2
	mov r1,#0x7	; 02307EF4
	ldr r0,[r2,#0x1c]	; 02307EF6
	strh r1,[r0,#0x4]	; 02307EF8
	mov r0,#0x53	; 02307EFA
	strh r0,[r2,#0x0]	; 02307EFC
	mov r0,#0x2	; 02307EFE
	mov r1,#0x3	; 02307F00
	ldr r3,[pool_02307F10]	; 02307F02
	bx r3	; 02307F04
	.byte 0xC0, 0x46	; 02307F08
pool_02307F08:
loc_02307F08:
	.word FirmwareWlWorkPointerSlot	; 02307F08
pool_02307F0C:
loc_02307F0C:
	.word 0x000003D8	; 02307F0C
pool_02307F10:
loc_02307F10:
	.word loc_037FB3C4 + 1	; 02307F10

; ===== function loc_02307F14 =====
	push {r4,lr}	; 02307F14
	ldr r0,[pool_02307F80]	; 02307F16
	ldr r1,[r0,#0x0]	; 02307F18
	ldr r0,[pool_02307F84]	; 02307F1A
	add r4,r1,r0	; 02307F1C
	ldrh r0,[r4,#0x0]	; 02307F1E
	cmp r0,#0x50	; 02307F20
	beq loc_02307F2A	; 02307F22
	cmp r0,#0x53	; 02307F24
	beq loc_02307F5E	; 02307F26
	b loc_02307F7A	; 02307F28
loc_02307F2A:
	ldr r0,[r4,#0x18]	; 02307F2A
	add r0,#0x10	; 02307F2C
	bl loc_02309EEC	; 02307F2E
	cmp r0,#0x0	; 02307F32
	bne loc_02307F4A	; 02307F34
	mov r1,#0x8	; 02307F36
	ldr r0,[r4,#0x1c]	; 02307F38
	strh r1,[r0,#0x4]	; 02307F3A
	mov r0,#0x53	; 02307F3C
	strh r0,[r4,#0x0]	; 02307F3E
	mov r0,#0x2	; 02307F40
	mov r1,#0x3	; 02307F42
	bl loc_02304BE8	; 02307F44
	b loc_02307F7A	; 02307F48
loc_02307F4A:
	mov r1,#0x51	; 02307F4A
	strh r1,[r4,#0x0]	; 02307F4C
	bl loc_0230A43C	; 02307F4E
	ldr r0,[r4,#0x18]	; 02307F52
	ldrh r0,[r0,#0x18]	; 02307F54
	ldr r1,[pool_02307F88]	; 02307F56
	bl loc_023053C8	; 02307F58
	b loc_02307F7A	; 02307F5C
loc_02307F5E:
	mov r0,#0x1	; 02307F5E
	bl loc_0230A698	; 02307F60
	mov r0,#0x1	; 02307F64
	bl loc_0230A704	; 02307F66
	mov r0,#0x1	; 02307F6A
	mov r1,#0x0	; 02307F6C
	bl loc_0230A4A8	; 02307F6E
	mov r0,#0x0	; 02307F72
	strh r0,[r4,#0x0]	; 02307F74
	bl loc_02307CB0	; 02307F76
loc_02307F7A:
	pop {r4}	; 02307F7A
	pop {r3}	; 02307F7C
	bx r3	; 02307F7E
pool_02307F80:
loc_02307F80:
	.word FirmwareWlWorkPointerSlot	; 02307F80
pool_02307F84:
loc_02307F84:
	.word 0x000003D8	; 02307F84
pool_02307F88:
loc_02307F88:
	.word 0x02307EED	; 02307F88
	ldr r0,[pool_02307FA8]	; 02307F8C
	ldr r1,[r0,#0x0]	; 02307F8E
	ldr r0,[pool_02307FAC]	; 02307F90
	add r2,r1,r0	; 02307F92
	mov r1,#0x7	; 02307F94
	ldr r0,[r2,#0x1c]	; 02307F96
	strh r1,[r0,#0x4]	; 02307F98
	mov r0,#0x35	; 02307F9A
	strh r0,[r2,#0x0]	; 02307F9C
	mov r0,#0x2	; 02307F9E
	add r1,r0,#0x0	; 02307FA0
	ldr r3,[pool_02307FB0]	; 02307FA2
	bx r3	; 02307FA4
	.byte 0xC0, 0x46	; 02307FA8
pool_02307FA8:
loc_02307FA8:
	.word FirmwareWlWorkPointerSlot	; 02307FA8
pool_02307FAC:
loc_02307FAC:
	.word 0x000003D8	; 02307FAC
pool_02307FB0:
loc_02307FB0:
	.word loc_037FB3C4 + 1	; 02307FB0

; ===== function loc_02307FB4 =====
	push {r4,lr}	; 02307FB4
	ldr r0,[pool_02308030]	; 02307FB6
	ldr r1,[r0,#0x0]	; 02307FB8
	ldr r0,[pool_02308034]	; 02307FBA
	add r4,r1,r0	; 02307FBC
	ldrh r0,[r4,#0x0]	; 02307FBE
	cmp r0,#0x30	; 02307FC0
	beq loc_02307FCA	; 02307FC2
	cmp r0,#0x35	; 02307FC4
	beq loc_0230800E	; 02307FC6
	b loc_0230802A	; 02307FC8
loc_02307FCA:
	ldr r0,[r4,#0x18]	; 02307FCA
	add r0,#0x10	; 02307FCC
	mov r1,#0x0	; 02307FCE
	bl loc_02309B74	; 02307FD0
	cmp r0,#0x0	; 02307FD4
	bne loc_02307FEC	; 02307FD6
	mov r1,#0x8	; 02307FD8
	ldr r0,[r4,#0x1c]	; 02307FDA
	strh r1,[r0,#0x4]	; 02307FDC
	mov r0,#0x35	; 02307FDE
	strh r0,[r4,#0x0]	; 02307FE0
	mov r0,#0x2	; 02307FE2
	add r1,r0,#0x0	; 02307FE4
	bl loc_02304BE8	; 02307FE6
	b loc_0230802A	; 02307FEA
loc_02307FEC:
	ldr r1,[r4,#0x18]	; 02307FEC
	ldrh r1,[r1,#0x16]	; 02307FEE
	strh r1,[r0,#0x2c]	; 02307FF0
	mov r1,#0x1	; 02307FF2
	strh r1,[r0,#0x2e]	; 02307FF4
	mov r1,#0x0	; 02307FF6
	strh r1,[r0,#0x30]	; 02307FF8
	mov r1,#0x31	; 02307FFA
	strh r1,[r4,#0x0]	; 02307FFC
	bl loc_0230A43C	; 02307FFE
	ldr r0,[r4,#0x18]	; 02308002
	ldrh r0,[r0,#0x18]	; 02308004
	ldr r1,[pool_02308038]	; 02308006
	bl loc_023053C8	; 02308008
	b loc_0230802A	; 0230800C
loc_0230800E:
	mov r0,#0x1	; 0230800E
	bl loc_0230A698	; 02308010
	mov r0,#0x1	; 02308014
	bl loc_0230A704	; 02308016
	mov r0,#0x1	; 0230801A
	mov r1,#0x0	; 0230801C
	bl loc_0230A4A8	; 0230801E
	mov r0,#0x0	; 02308022
	strh r0,[r4,#0x0]	; 02308024
	bl loc_02307CB0	; 02308026
loc_0230802A:
	pop {r4}	; 0230802A
	pop {r3}	; 0230802C
	bx r3	; 0230802E
pool_02308030:
loc_02308030:
	.word FirmwareWlWorkPointerSlot	; 02308030
pool_02308034:
loc_02308034:
	.word 0x000003D8	; 02308034
pool_02308038:
loc_02308038:
	.word 0x02307F8D	; 02308038
	ldr r0,[pool_02308054]	; 0230803C
	ldr r1,[r0,#0x0]	; 0230803E
	ldr r0,[pool_02308058]	; 02308040
	add r1,r1,r0	; 02308042
	mov r0,#0x7	; 02308044
	strh r0,[r1,#0x4]	; 02308046
	mov r0,#0x25	; 02308048
	strh r0,[r1,#0x0]	; 0230804A
	mov r0,#0x2	; 0230804C
	mov r1,#0x1	; 0230804E
	ldr r3,[pool_0230805C]	; 02308050
	bx r3	; 02308052
pool_02308054:
loc_02308054:
	.word FirmwareWlWorkPointerSlot	; 02308054
pool_02308058:
loc_02308058:
	.word 0x000003D8	; 02308058
pool_0230805C:
loc_0230805C:
	.word loc_037FB3C4 + 1	; 0230805C

; ===== function loc_02308060 =====
	push {r4,lr}	; 02308060
	ldr r0,[pool_023080B4]	; 02308062
	ldr r1,[r0,#0x0]	; 02308064
	ldr r0,[pool_023080B8]	; 02308066
	add r4,r1,r0	; 02308068
	ldrh r0,[r4,#0x0]	; 0230806A
	cmp r0,#0x20	; 0230806C
	beq loc_02308076	; 0230806E
	cmp r0,#0x25	; 02308070
	beq loc_02308090	; 02308072
	b loc_023080AE	; 02308074
loc_02308076:
	bl loc_02307ECC	; 02308076
	mov r0,#0x0	; 0230807A
	strh r0,[r4,#0x4]	; 0230807C
	strh r0,[r4,#0x6]	; 0230807E
	mov r0,#0x21	; 02308080
	strh r0,[r4,#0x0]	; 02308082
	ldr r0,[r4,#0x18]	; 02308084
	ldrh r0,[r0,#0x10]	; 02308086
	ldr r1,[pool_023080BC]	; 02308088
	bl loc_023053C8	; 0230808A
	b loc_023080AE	; 0230808E
loc_02308090:
	ldrh r1,[r4,#0x4]	; 02308090
	ldr r0,[r4,#0x1c]	; 02308092
	strh r1,[r0,#0x4]	; 02308094
	ldrh r1,[r4,#0x6]	; 02308096
	ldr r0,[r4,#0x1c]	; 02308098
	strh r1,[r0,#0x6]	; 0230809A
	ldrh r0,[r4,#0x4]	; 0230809C
	cmp r0,#0x0	; 0230809E
	beq loc_023080A6	; 023080A0
	bl loc_02304E58	; 023080A2
loc_023080A6:
	mov r0,#0x0	; 023080A6
	strh r0,[r4,#0x0]	; 023080A8
	bl loc_02307CB0	; 023080AA
loc_023080AE:
	pop {r4}	; 023080AE
	pop {r3}	; 023080B0
	bx r3	; 023080B2
pool_023080B4:
loc_023080B4:
	.word FirmwareWlWorkPointerSlot	; 023080B4
pool_023080B8:
loc_023080B8:
	.word 0x000003D8	; 023080B8
pool_023080BC:
loc_023080BC:
	.word 0x0230803D	; 023080BC
	ldr r0,[pool_023080F4]	; 023080C0
	ldr r1,[r0,#0x0]	; 023080C2
	ldr r0,[pool_023080F8]	; 023080C4
	add r0,r1,r0	; 023080C6
	ldrh r2,[r0,#0xa]	; 023080C8
	ldrh r1,[r0,#0xc]	; 023080CA
	add r1,r2,r1	; 023080CC
	strh r1,[r0,#0xa]	; 023080CE
	ldrh r2,[r0,#0xa]	; 023080D0
	ldr r1,[r0,#0x18]	; 023080D2
	add r1,#0x4a	; 023080D4
	ldrh r1,[r1,#0x0]	; 023080D6
	cmp r2,r1	; 023080D8
	bcc loc_023080EC	; 023080DA
	ldrh r1,[r0,#0x6]	; 023080DC
	cmp r1,#0x10	; 023080DE
	bcs loc_023080E8	; 023080E0
	mov r1,#0x11	; 023080E2
	strh r1,[r0,#0x0]	; 023080E4
	b loc_023080EC	; 023080E6
loc_023080E8:
	mov r1,#0x15	; 023080E8
	strh r1,[r0,#0x0]	; 023080EA
loc_023080EC:
	mov r0,#0x2	; 023080EC
	mov r1,#0x0	; 023080EE
	ldr r3,[pool_023080FC]	; 023080F0
	bx r3	; 023080F2
pool_023080F4:
loc_023080F4:
	.word FirmwareWlWorkPointerSlot	; 023080F4
pool_023080F8:
loc_023080F8:
	.word 0x000003D8	; 023080F8
pool_023080FC:
loc_023080FC:
	.word loc_037FB3C4 + 1	; 023080FC

; ===== function loc_02308100 =====
	push {r4,r5,r6,lr}	; 02308100
	ldr r0,[pool_0230822C]	; 02308102
	ldr r1,[r0,#0x0]	; 02308104
	ldr r0,[pool_02308230]	; 02308106
	add r4,r1,r0	; 02308108
	ldr r0,[pool_02308234]	; 0230810A
	add r6,r1,r0	; 0230810C
	mov r5,#0x0	; 0230810E
	ldrh r0,[r4,#0x0]	; 02308110
	sub r0,#0x10	; 02308112
	cmp r0,#0x5	; 02308114
	bhi loc_02308218	; 02308116
	add r0,r0,r0	; 02308118
P4_SwitchIndexPC_02308118:
	add r0,pc	; 0230811A
	ldrh r0,[r0,#(P4_SwitchTable_02308118 - (P4_SwitchIndexPC_02308118 + 4))]	; 0230811C
	lsl r0,r0,#0x10	; 0230811E
	asr r0,r0,#0x10	; 02308120
P4_SwitchTargetPC_02308118:
	add r0,pc	; 02308122
	bx r0	; 02308124
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_02308118:
	.halfword (loc_02308132 + 1) - (P4_SwitchTargetPC_02308118 + 4)
	.halfword (loc_02308178 + 1) - (P4_SwitchTargetPC_02308118 + 4)
	.halfword (loc_023081D2 + 1) - (P4_SwitchTargetPC_02308118 + 4)
	.halfword (loc_023081D2 + 1) - (P4_SwitchTargetPC_02308118 + 4)
	.halfword (loc_02308218 + 1) - (P4_SwitchTargetPC_02308118 + 4)
	.halfword (loc_02308204 + 1) - (P4_SwitchTargetPC_02308118 + 4)
P4_SwitchTable_02308118End:
loc_02308132:
	mov r0,#0x20	; 02308132
	bl loc_023070B8	; 02308134
	mov r0,#0x2	; 02308138
	strh r0,[r6,#0xc]	; 0230813A
	lsl r1,r5,#0	; 0230813C
	ldr r0,[r4,#0x1c]	; 0230813E
	strh r1,[r0,#0x8]	; 02308140
	ldr r0,[r4,#0x1c]	; 02308142
	strh r1,[r0,#0x6]	; 02308144
	strh r1,[r4,#0x6]	; 02308146
	strh r1,[r4,#0x8]	; 02308148
	ldr r1,[r4,#0x18]	; 0230814A
	ldrh r0,[r1,#0x38]	; 0230814C
	cmp r0,#0x0	; 0230814E
	bne loc_0230816C	; 02308150
	add r1,#0x4a	; 02308152
	ldrh r0,[r1,#0x0]	; 02308154
	add r0,r0,#0x3	; 02308156
	mov r1,#0x4	; 02308158
	bl loc_02308240	; 0230815A
	strh r0,[r4,#0xc]	; 0230815E
	ldrh r0,[r4,#0xc]	; 02308160
	cmp r0,#0xa	; 02308162
	bcs loc_02308172	; 02308164
	mov r0,#0xa	; 02308166
	strh r0,[r4,#0xc]	; 02308168
	b loc_02308172	; 0230816A
loc_0230816C:
	add r1,#0x4a	; 0230816C
	ldrh r0,[r1,#0x0]	; 0230816E
	strh r0,[r4,#0xc]	; 02308170
loc_02308172:
	mov r1,#0x0	; 02308172
	ldr r0,[r4,#0x1c]	; 02308174
	strh r1,[r0,#0x4]	; 02308176
loc_02308178:
	ldr r1,[r4,#0x18]	; 02308178
	add r1,#0x3a	; 0230817A
	ldrh r0,[r4,#0x6]	; 0230817C
	add r0,r1,r0	; 0230817E
	bl loc_02305180	; 02308180
	add r6,r0,#0x0	; 02308184
	cmp r6,#0x0	; 02308186
	bne loc_02308192	; 02308188
	mov r0,#0x15	; 0230818A
	strh r0,[r4,#0x0]	; 0230818C
	mov r5,#0x1	; 0230818E
	b loc_02308218	; 02308190
loc_02308192:
	ldrh r0,[r4,#0x6]	; 02308192
	add r0,r0,#0x1	; 02308194
	strh r0,[r4,#0x6]	; 02308196
	mov r0,#0x0	; 02308198
	strh r0,[r4,#0xa]	; 0230819A
	bl loc_0230D490	; 0230819C
	cmp r0,#0x0	; 023081A0
	beq loc_023081B2	; 023081A2
	mov r1,#0xe	; 023081A4
	ldr r0,[r4,#0x1c]	; 023081A6
	strh r1,[r0,#0x4]	; 023081A8
	mov r0,#0x15	; 023081AA
	strh r0,[r4,#0x0]	; 023081AC
	mov r5,#0x1	; 023081AE
	b loc_02308218	; 023081B0
loc_023081B2:
	ldrh r0,[r4,#0x0]	; 023081B2
	cmp r0,#0x10	; 023081B4
	bne loc_023081C6	; 023081B6
	add r0,r6,#0x0	; 023081B8
	mov r1,#0x0	; 023081BA
	bl loc_02305F8C	; 023081BC
	bl loc_02307ECC	; 023081C0
	b loc_023081CE	; 023081C4
loc_023081C6:
	add r0,r6,#0x0	; 023081C6
	mov r1,#0x0	; 023081C8
	bl loc_02305F8C	; 023081CA
loc_023081CE:
	mov r0,#0x12	; 023081CE
	strh r0,[r4,#0x0]	; 023081D0
loc_023081D2:
	mov r0,#0x13	; 023081D2
	strh r0,[r4,#0x0]	; 023081D4
	ldr r0,[r4,#0x18]	; 023081D6
	ldrh r1,[r0,#0x38]	; 023081D8
	cmp r1,#0x0	; 023081DA
	bne loc_023081FA	; 023081DC
	add r0,#0x10	; 023081DE
	bl loc_02309C8C	; 023081E0
	cmp r0,#0x0	; 023081E4
	bne loc_023081F6	; 023081E6
	mov r1,#0x8	; 023081E8
	ldr r0,[r4,#0x1c]	; 023081EA
	strh r1,[r0,#0x4]	; 023081EC
	mov r0,#0x15	; 023081EE
	strh r0,[r4,#0x0]	; 023081F0
	mov r5,#0x1	; 023081F2
	b loc_02308218	; 023081F4
loc_023081F6:
	bl loc_0230A43C	; 023081F6
loc_023081FA:
	ldrh r0,[r4,#0xc]	; 023081FA
	ldr r1,[pool_02308238]	; 023081FC
	bl loc_023053C8	; 023081FE
	b loc_02308218	; 02308202
loc_02308204:
	strh r5,[r4,#0x0]	; 02308204
	bl loc_02304E58	; 02308206
	ldr r0,[pool_0230822C]	; 0230820A
	ldr r1,[r0,#0x0]	; 0230820C
	ldr r0,[pool_0230823C]	; 0230820E
	ldrh r0,[r1,r0]	; 02308210
	strh r0,[r6,#0xc]	; 02308212
	bl loc_02307CB0	; 02308214
loc_02308218:
	cmp r5,#0x0	; 02308218
	beq loc_02308224	; 0230821A
	mov r0,#0x2	; 0230821C
	mov r1,#0x0	; 0230821E
	bl loc_02304BE8	; 02308220
loc_02308224:
	pop {r4,r5,r6}	; 02308224
	pop {r3}	; 02308226
	bx r3	; 02308228
	.byte 0xC0, 0x46	; 0230822C
pool_0230822C:
loc_0230822C:
	.word FirmwareWlWorkPointerSlot	; 0230822C
pool_02308230:
loc_02308230:
	.word 0x000003D8	; 02308230
pool_02308234:
loc_02308234:
	.word 0x00000318	; 02308234
pool_02308238:
loc_02308238:
	.word 0x023080C1	; 02308238
pool_0230823C:
loc_0230823C:
	.word 0x00000302	; 0230823C

; ===== function loc_02308240 =====
loc_02308240:
	bx pc	; 02308240
	.byte 0xC0, 0x46	; 02308244
.arm

; ===== function loc_02308244 =====
loc_02308244:
	ldr pc,[pool_02308248]	; 02308244
pool_02308248:
loc_02308248:
	.word P2_SignedDivMod	; 02308248
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0E, 0x1C, 0x21, 0x4A, 0x11, 0x68, 0x21, 0x48, 0x0F, 0x18	; 0230824C
	.byte 0x12, 0x20, 0x70, 0x80, 0x11, 0x68, 0x20, 0x48, 0x08, 0x5A, 0x20, 0x28, 0x01, 0xD0, 0x01, 0x20	; 0230825C
	.byte 0x31, 0xE0, 0x68, 0x8A, 0x03, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x2C, 0xE0, 0xA8, 0x8A, 0x3F, 0x28	; 0230826C
	.byte 0x01, 0xD9, 0x05, 0x20, 0x27, 0xE0, 0xE9, 0x8A, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x22, 0xE0	; 0230827C
	.byte 0x16, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x1D, 0xE0, 0x00, 0x24, 0x0D, 0xE0, 0x28, 0x1C	; 0230828C
	.byte 0x18, 0x30, 0x00, 0x19, 0xFC, 0xF7, 0x6E, 0xFF, 0x00, 0x28, 0x08, 0xD0, 0xFD, 0xF7, 0xF8, 0xFA	; 0230829C
	.byte 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x0E, 0xE0, 0x64, 0x1C, 0x10, 0x2C, 0xEF, 0xD3, 0x00, 0x2C	; 023082AC
	.byte 0x01, 0xD1, 0x05, 0x20, 0x07, 0xE0, 0xBD, 0x61, 0xFE, 0x61, 0x80, 0x20, 0x38, 0x80, 0xB0, 0x80	; 023082BC
	.byte 0xFF, 0xF7, 0x2E, 0xFD, 0x80, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 023082CC
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xD8, 0x03, 0x00, 0x00, 0x20, 0x03, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00	; 023082DC
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x45, 0x48, 0x02, 0x68, 0x45, 0x48, 0x16, 0x18, 0x45, 0x48, 0x14, 0x18	; 023082EC
	.byte 0x01, 0x20, 0x48, 0x80, 0x60, 0x8A, 0x01, 0x28, 0x03, 0xD0, 0x00, 0x28, 0x01, 0xD0, 0x0B, 0x20	; 023082FC
	.byte 0x78, 0xE0, 0x30, 0x89, 0x20, 0x28, 0x01, 0xD0, 0x01, 0x20, 0x73, 0xE0, 0x28, 0x8A, 0x20, 0x28	; 0230830C
	.byte 0x01, 0xD9, 0x05, 0x20, 0x6E, 0xE0, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x6A, 0xE0, 0x69, 0x8E	; 0230831C
	.byte 0x0A, 0x29, 0x01, 0xD2, 0x05, 0x20, 0x65, 0xE0, 0x37, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20	; 0230832C
	.byte 0x60, 0xE0, 0xA8, 0x8E, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x5B, 0xE0, 0xFF, 0x28, 0x01, 0xD9	; 0230833C
	.byte 0x05, 0x20, 0x57, 0xE0, 0xE8, 0x8E, 0x31, 0x49, 0x02, 0x1C, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0	; 0230834C
	.byte 0x05, 0x20, 0x4F, 0xE0, 0xFD, 0xF7, 0x9C, 0xFA, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x49, 0xE0	; 0230835C
	.byte 0x29, 0x8F, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x44, 0xE0, 0x29, 0x48, 0x01, 0x40, 0x00, 0x29	; 0230836C
	.byte 0x01, 0xD0, 0x05, 0x20, 0x3E, 0xE0, 0x69, 0x8F, 0x00, 0x29, 0x01, 0xD1, 0x05, 0x20, 0x39, 0xE0	; 0230837C
	.byte 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x34, 0xE0, 0xA8, 0x8F, 0x80, 0x28, 0x01, 0xD9	; 0230838C
	.byte 0x05, 0x20, 0x2F, 0xE0, 0x00, 0x20, 0x05, 0xF0, 0x75, 0xF8, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20	; 0230839C
	.byte 0x28, 0xE0, 0x60, 0x8A, 0x00, 0x28, 0x03, 0xD1, 0x1A, 0x48, 0xFD, 0xF7, 0xEB, 0xFF, 0x03, 0xE0	; 023083AC
	.byte 0x08, 0x34, 0x20, 0x1C, 0xFD, 0xF7, 0xE6, 0xFF, 0x28, 0x8A, 0x29, 0x1C, 0x12, 0x31, 0xFD, 0xF7	; 023083BC
	.byte 0x7F, 0xFF, 0x68, 0x8E, 0xFD, 0xF7, 0x5A, 0xFF, 0xA8, 0x8E, 0xFD, 0xF7, 0x3F, 0xFF, 0xE8, 0x8E	; 023083CC
	.byte 0x00, 0x21, 0xFD, 0xF7, 0xD5, 0xFD, 0x28, 0x1C, 0x38, 0x30, 0xFD, 0xF7, 0xBB, 0xFD, 0xA8, 0x8F	; 023083DC
	.byte 0x3E, 0x35, 0x29, 0x1C, 0xFD, 0xF7, 0x62, 0xFC, 0x00, 0x20, 0xA4, 0x36, 0x30, 0x80, 0xFF, 0xF7	; 023083EC
	.byte 0x67, 0xFD, 0x00, 0x20, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 023083FC
	.byte 0x18, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00, 0xF0, 0xFF, 0x00, 0x00	; 0230840C
	.byte 0x00, 0xF0, 0xFF, 0xFF, 0x08, 0xD6, 0x30, 0x02, 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0F, 0x1C	; 0230841C
	.byte 0x22, 0x48, 0x00, 0x68, 0x22, 0x49, 0x44, 0x18, 0x22, 0x49, 0x46, 0x18, 0x03, 0x21, 0x79, 0x80	; 0230842C
	.byte 0x21, 0x49, 0x40, 0x5A, 0x03, 0x28, 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x31, 0xE0	; 0230843C
	.byte 0x20, 0x89, 0x30, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x2C, 0xE0, 0x29, 0x8A, 0x01, 0x20, 0x01, 0x40	; 0230844C
	.byte 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x25, 0xE0, 0xE8, 0x8A, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20	; 0230845C
	.byte 0x20, 0xE0, 0xFF, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x1C, 0xE0, 0x29, 0x8B, 0x13, 0x48, 0x81, 0x42	; 0230846C
	.byte 0x01, 0xD9, 0x05, 0x20, 0x16, 0xE0, 0x0A, 0x29, 0x01, 0xD2, 0x05, 0x20, 0x12, 0xE0, 0x30, 0x20	; 0230847C
	.byte 0xFE, 0xF7, 0x14, 0xFE, 0xFD, 0xF7, 0x7C, 0xFB, 0xE9, 0x8A, 0x20, 0x1C, 0x70, 0x30, 0x01, 0x80	; 0230848C
	.byte 0xE8, 0x8A, 0x72, 0x34, 0x20, 0x80, 0xB5, 0x61, 0xF7, 0x61, 0x50, 0x20, 0x30, 0x80, 0xFF, 0xF7	; 0230849C
	.byte 0x33, 0xFD, 0x80, 0x20, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 023084AC
	.byte 0x18, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0x02, 0x03, 0x00, 0x00, 0xD0, 0x07, 0x00, 0x00	; 023084BC
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x04, 0x20, 0x60, 0x80, 0x2D, 0x48, 0x02, 0x68, 0x2D, 0x48	; 023084CC
	.byte 0x11, 0x5A, 0x03, 0x29, 0x05, 0xD0, 0x02, 0x29, 0x03, 0xD0, 0x01, 0x29, 0x01, 0xD0, 0x0B, 0x20	; 023084DC
	.byte 0x4B, 0xE0, 0x29, 0x48, 0x10, 0x5A, 0x30, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x45, 0xE0, 0x27, 0x48	; 023084EC
	.byte 0x08, 0x18, 0x00, 0x04, 0x00, 0x0C, 0x01, 0x28, 0x06, 0xD8, 0x29, 0x8A, 0x01, 0x20, 0x01, 0x40	; 023084FC
	.byte 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x38, 0xE0, 0xA0, 0x1D, 0x29, 0x1C, 0x10, 0x31, 0xFD, 0xF7	; 0230850C
	.byte 0x2F, 0xFB, 0xA0, 0x1D, 0xE9, 0x8A, 0x01, 0xF0, 0xFB, 0xFA, 0x06, 0x1C, 0x00, 0x2E, 0x01, 0xD1	; 0230851C
	.byte 0x08, 0x20, 0x2A, 0xE0, 0x16, 0x48, 0x02, 0x68, 0x19, 0x49, 0x55, 0x50, 0x02, 0x68, 0x19, 0x49	; 0230852C
	.byte 0x54, 0x50, 0x41, 0x23, 0x02, 0x68, 0x18, 0x49, 0x53, 0x52, 0x2A, 0x8A, 0x01, 0x21, 0x0A, 0x40	; 0230853C
	.byte 0x00, 0x2A, 0x12, 0xD0, 0x01, 0x68, 0x15, 0x48, 0x08, 0x18, 0x10, 0x3E, 0x31, 0x1C, 0xFF, 0xF7	; 0230854C
	.byte 0x13, 0xF8, 0x0B, 0x48, 0x02, 0x68, 0x12, 0x48, 0x11, 0x5A, 0x12, 0x48, 0x10, 0x5A, 0x81, 0x43	; 0230855C
	.byte 0x00, 0x29, 0x09, 0xD1, 0x02, 0xF0, 0x80, 0xFC, 0x06, 0xE0, 0x10, 0x35, 0x28, 0x1C, 0x02, 0xF0	; 0230856C
	.byte 0x1B, 0xF8, 0x30, 0x1C, 0x01, 0xF0, 0x5C, 0xFF, 0x80, 0x20, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230857C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x02, 0x03, 0x00, 0x00, 0x20, 0x03, 0x00, 0x00, 0xFE, 0xFF, 0x00, 0x00	; 0230858C
	.byte 0xF0, 0x03, 0x00, 0x00, 0xF4, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0x5C, 0x01, 0x00, 0x00	; 0230859C
	.byte 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00, 0x70, 0xB5, 0x05, 0x1C, 0x0E, 0x1C, 0x20, 0x48	; 023085AC
	.byte 0x00, 0x68, 0x20, 0x49, 0x41, 0x18, 0x20, 0x4A, 0x84, 0x18, 0x06, 0x22, 0x72, 0x80, 0x1F, 0x4A	; 023085BC
	.byte 0x80, 0x5A, 0x03, 0x28, 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x2D, 0xE0, 0x08, 0x89	; 023085CC
	.byte 0x20, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x28, 0xE0, 0x29, 0x8A, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29	; 023085DC
	.byte 0x01, 0xD0, 0x05, 0x20, 0x21, 0xE0, 0xE8, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x1C, 0xE0	; 023085EC
	.byte 0x29, 0x8B, 0x13, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x16, 0xE0, 0x0A, 0x29, 0x01, 0xD2	; 023085FC
	.byte 0x05, 0x20, 0x12, 0xE0, 0x20, 0x20, 0xFE, 0xF7, 0x51, 0xFD, 0xA5, 0x61, 0xE6, 0x61, 0x30, 0x20	; 0230860C
	.byte 0x20, 0x80, 0xA0, 0x69, 0xC0, 0x8A, 0xF0, 0x81, 0x08, 0x36, 0x30, 0x1C, 0xA1, 0x69, 0x10, 0x31	; 0230861C
	.byte 0xFD, 0xF7, 0xA6, 0xFA, 0xFF, 0xF7, 0xC0, 0xFC, 0x80, 0x20, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230862C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0x02, 0x03, 0x00, 0x00	; 0230863C
	.byte 0xD0, 0x07, 0x00, 0x00, 0x70, 0xB5, 0x05, 0x1C, 0x0E, 0x1C, 0x51, 0x48, 0x00, 0x68, 0x51, 0x49	; 0230864C
	.byte 0x41, 0x18, 0x51, 0x4A, 0x84, 0x18, 0x05, 0x22, 0x72, 0x80, 0x50, 0x4A, 0x80, 0x5A, 0x03, 0x28	; 0230865C
	.byte 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x8E, 0xE0, 0x08, 0x89, 0x20, 0x28, 0x01, 0xD2	; 0230866C
	.byte 0x01, 0x20, 0x89, 0xE0, 0x20, 0x20, 0xFE, 0xF7, 0x19, 0xFD, 0x29, 0x8B, 0x01, 0x20, 0x01, 0x40	; 0230867C
	.byte 0x00, 0x29, 0x01, 0xD0, 0x05, 0x20, 0x7F, 0xE0, 0xE8, 0x8B, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20	; 0230868C
	.byte 0x7A, 0xE0, 0x20, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x76, 0xE0, 0x28, 0x1C, 0x46, 0x30, 0x01, 0x88	; 0230869C
	.byte 0x0A, 0x29, 0x01, 0xD2, 0x05, 0x20, 0x6F, 0xE0, 0x3D, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20	; 023086AC
	.byte 0x6A, 0xE0, 0x28, 0x1C, 0x48, 0x30, 0x00, 0x88, 0xFF, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x63, 0xE0	; 023086BC
	.byte 0x28, 0x1C, 0x4A, 0x30, 0x00, 0x88, 0x37, 0x49, 0x02, 0x1C, 0x0A, 0x40, 0x00, 0x2A, 0x01, 0xD0	; 023086CC
	.byte 0x05, 0x20, 0x59, 0xE0, 0xFD, 0xF7, 0xDC, 0xF8, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x53, 0xE0	; 023086DC
	.byte 0x28, 0x1C, 0x42, 0x30, 0x00, 0x88, 0x30, 0x4A, 0x01, 0x1C, 0x11, 0x40, 0x00, 0x29, 0x01, 0xD0	; 023086EC
	.byte 0x05, 0x20, 0x49, 0xE0, 0x29, 0x1C, 0x44, 0x31, 0x0B, 0x88, 0x19, 0x1C, 0x11, 0x40, 0x00, 0x29	; 023086FC
	.byte 0x01, 0xD0, 0x05, 0x20, 0x40, 0xE0, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x3C, 0xE0, 0x03, 0x43	; 0230870C
	.byte 0x00, 0x2B, 0x01, 0xD1, 0x05, 0x20, 0x37, 0xE0, 0x29, 0x8A, 0x24, 0x48, 0x81, 0x42, 0x01, 0xD9	; 0230871C
	.byte 0x05, 0x20, 0x31, 0xE0, 0x00, 0x20, 0x04, 0xF0, 0xAD, 0xFE, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20	; 0230872C
	.byte 0x2A, 0xE0, 0x28, 0x1C, 0x40, 0x30, 0x01, 0x88, 0x20, 0x20, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD1	; 0230873C
	.byte 0x00, 0x20, 0xFD, 0xF7, 0x01, 0xFF, 0x28, 0x1C, 0x18, 0x30, 0xFD, 0xF7, 0x1B, 0xFE, 0xE8, 0x8B	; 0230874C
	.byte 0x29, 0x1C, 0x20, 0x31, 0xFD, 0xF7, 0xB4, 0xFD, 0x28, 0x1C, 0x46, 0x30, 0x00, 0x88, 0xFD, 0xF7	; 0230875C
	.byte 0x8D, 0xFD, 0x28, 0x1C, 0x4A, 0x30, 0x00, 0x88, 0x00, 0x21, 0xFD, 0xF7, 0x09, 0xFC, 0x28, 0x1C	; 0230876C
	.byte 0x42, 0x30, 0xFD, 0xF7, 0xEF, 0xFB, 0xA5, 0x61, 0xE6, 0x61, 0x20, 0x20, 0x20, 0x80, 0x02, 0x20	; 0230877C
	.byte 0x01, 0x21, 0xFC, 0xF7, 0x2B, 0xFA, 0x80, 0x20, 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 0230878C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0x02, 0x03, 0x00, 0x00	; 0230879C
	.byte 0xE8, 0x03, 0x00, 0x00, 0xF0, 0xFF, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0xFF, 0xD0, 0x07, 0x00, 0x00	; 023087AC
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0F, 0x1C, 0x33, 0x48, 0x00, 0x68, 0x33, 0x49, 0x44, 0x18	; 023087BC
	.byte 0x79, 0x88, 0x89, 0x1E, 0xA1, 0x80, 0x03, 0x21, 0x79, 0x80, 0x31, 0x49, 0x40, 0x5A, 0x01, 0x28	; 023087CC
	.byte 0x05, 0xD0, 0x03, 0x28, 0x03, 0xD0, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x50, 0xE0, 0x2A, 0x48	; 023087DC
	.byte 0x01, 0x68, 0x2C, 0x48, 0x08, 0x5A, 0x20, 0x28, 0x01, 0xD2, 0x01, 0x20, 0x48, 0xE0, 0xE8, 0x8A	; 023087EC
	.byte 0x20, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x43, 0xE0, 0x28, 0x8F, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20	; 023087FC
	.byte 0x3E, 0xE0, 0x28, 0x1C, 0x3A, 0x30, 0xFC, 0xF7, 0xB5, 0xFC, 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20	; 0230880C
	.byte 0x36, 0xE0, 0x28, 0x1C, 0x4A, 0x30, 0x01, 0x88, 0x1F, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20	; 0230881C
	.byte 0x2E, 0xE0, 0x0A, 0x29, 0x01, 0xD2, 0x05, 0x20, 0x2A, 0xE0, 0x28, 0x1C, 0x4C, 0x30, 0x00, 0x88	; 0230882C
	.byte 0x10, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x23, 0xE0, 0x00, 0x26, 0x0D, 0xE0, 0x28, 0x1C, 0x3A, 0x30	; 0230883C
	.byte 0x80, 0x19, 0xFC, 0xF7, 0x97, 0xFC, 0x00, 0x28, 0x08, 0xD0, 0xFD, 0xF7, 0x21, 0xF8, 0x00, 0x28	; 0230884C
	.byte 0x01, 0xD1, 0x05, 0x20, 0x14, 0xE0, 0x76, 0x1C, 0x10, 0x2E, 0xEF, 0xD3, 0x28, 0x1C, 0x10, 0x30	; 0230885C
	.byte 0xFD, 0xF7, 0x90, 0xFD, 0xE8, 0x8A, 0x29, 0x1C, 0x18, 0x31, 0xFD, 0xF7, 0x29, 0xFD, 0xA5, 0x61	; 0230886C
	.byte 0xE7, 0x61, 0x10, 0x20, 0x20, 0x80, 0x02, 0x20, 0x00, 0x21, 0xFC, 0xF7, 0xAF, 0xF9, 0x80, 0x20	; 0230887C
	.byte 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xD8, 0x03, 0x00, 0x00	; 0230888C
	.byte 0x02, 0x03, 0x00, 0x00, 0x20, 0x03, 0x00, 0x00, 0xE8, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x04, 0x1C	; 0230889C
	.byte 0x09, 0x20, 0x48, 0x80, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20, 0x25, 0xE0, 0x61, 0x8A	; 023088AC
	.byte 0x01, 0x29, 0x01, 0xD9, 0x05, 0x20, 0x20, 0xE0, 0xA1, 0x8A, 0x01, 0x29, 0x01, 0xD9, 0x05, 0x20	; 023088BC
	.byte 0x1B, 0xE0, 0xFD, 0xF7, 0xEF, 0xFA, 0x20, 0x8A, 0x01, 0x28, 0x0F, 0xD1, 0x60, 0x8A, 0x01, 0x28	; 023088CC
	.byte 0x03, 0xD1, 0x0B, 0x48, 0xFD, 0xF7, 0xD0, 0xFA, 0x02, 0xE0, 0x00, 0x20, 0xFD, 0xF7, 0xCC, 0xFA	; 023088DC
	.byte 0xA2, 0x8A, 0x08, 0x48, 0x01, 0x68, 0x08, 0x48, 0x0A, 0x52, 0x05, 0xE0, 0x07, 0x48, 0xFD, 0xF7	; 023088EC
	.byte 0xC3, 0xFA, 0x02, 0x20, 0xFD, 0xF7, 0xC6, 0xFA, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 023088FC
	.byte 0x01, 0x80, 0x00, 0x00, 0xF4, 0xFF, 0x80, 0x03, 0x2C, 0x03, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00	; 0230890C
	.byte 0x10, 0xB5, 0x04, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20	; 0230891C
	.byte 0x07, 0xE0, 0xFC, 0xF7, 0x93, 0xFA, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD1, 0xFD, 0xF7, 0xE0, 0xF8	; 0230892C
	.byte 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x02, 0x20, 0x48, 0x80, 0x03, 0x48, 0x02, 0x68	; 0230893C
	.byte 0x03, 0x48, 0x10, 0x5A, 0xC8, 0x80, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230894C
	.byte 0x08, 0x03, 0x00, 0x00, 0x02, 0x20, 0x48, 0x80, 0x03, 0x48, 0x02, 0x68, 0x03, 0x48, 0x10, 0x5A	; 0230895C
	.byte 0xC8, 0x80, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x02, 0x03, 0x00, 0x00	; 0230896C
	.byte 0x03, 0x20, 0x48, 0x80, 0x05, 0x4B, 0x1A, 0x68, 0x05, 0x48, 0x10, 0x5A, 0xC8, 0x80, 0x1A, 0x68	; 0230897C
	.byte 0x04, 0x48, 0x10, 0x5A, 0x08, 0x81, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230898C
	.byte 0x00, 0x03, 0x00, 0x00, 0x92, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x04, 0x20, 0x48, 0x80	; 0230899C
	.byte 0x88, 0x1D, 0x05, 0x49, 0x0A, 0x68, 0x05, 0x49, 0x51, 0x18, 0xFD, 0xF7, 0xE1, 0xF8, 0x00, 0x20	; 023089AC
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF8, 0x02, 0x00, 0x00	; 023089BC
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x0E, 0x48, 0x01, 0x68, 0x0E, 0x48	; 023089CC
	.byte 0x08, 0x5A, 0x01, 0x28, 0x01, 0xD0, 0x0B, 0x20, 0x0F, 0xE0, 0x2C, 0x8A, 0x60, 0x1C, 0x02, 0x21	; 023089DC
	.byte 0x00, 0xF0, 0x14, 0xF8, 0xE9, 0x89, 0x40, 0x1C, 0x81, 0x42, 0x01, 0xDA, 0x04, 0x20, 0x04, 0xE0	; 023089EC
	.byte 0x20, 0x1C, 0x12, 0x35, 0x29, 0x1C, 0xFD, 0xF7, 0x0F, 0xF9, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC	; 023089FC
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x02, 0x03, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46	; 02308A0C
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0xA4, 0x4B, 0x80, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x23, 0x4B, 0x80	; 02308A1C
	.byte 0x06, 0x49, 0x0A, 0x68, 0x06, 0x49, 0x51, 0x5A, 0x10, 0x29, 0x03, 0xD3, 0x00, 0x8A, 0xFD, 0xF7	; 02308A2C
	.byte 0xD7, 0xFC, 0x03, 0x1C, 0x18, 0x1C, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 02308A3C
	.byte 0x20, 0x03, 0x00, 0x00, 0x10, 0xB5, 0x01, 0x24, 0x4C, 0x80, 0x0C, 0x4B, 0x1A, 0x68, 0x0C, 0x49	; 02308A4C
	.byte 0x51, 0x5A, 0x20, 0x29, 0x01, 0xD9, 0x20, 0x1C, 0x0D, 0xE0, 0x01, 0x8A, 0x49, 0x1C, 0x01, 0x82	; 02308A5C
	.byte 0x1A, 0x68, 0x01, 0x8A, 0x07, 0x48, 0x10, 0x5A, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x02, 0xE0	; 02308A6C
	.byte 0x05, 0x48, 0x11, 0x52, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 02308A7C
	.byte 0x20, 0x03, 0x00, 0x00, 0xF4, 0x02, 0x00, 0x00, 0xF6, 0x02, 0x00, 0x00, 0xF0, 0xB5, 0x81, 0xB0	; 02308A8C
	.byte 0x03, 0x1C, 0x25, 0x48, 0x04, 0x68, 0x25, 0x4A, 0xA2, 0x58, 0x01, 0x24, 0x4C, 0x80, 0x19, 0x8A	; 02308A9C
	.byte 0x04, 0x68, 0x23, 0x48, 0x20, 0x5A, 0x81, 0x42, 0x04, 0xD3, 0x22, 0x48, 0x81, 0x42, 0x01, 0xD0	; 02308AAC
	.byte 0x05, 0x20, 0x35, 0xE0, 0x9C, 0x8A, 0x3F, 0x2C, 0x04, 0xD9, 0x1E, 0x48, 0x84, 0x42, 0x01, 0xD0	; 02308ABC
	.byte 0x05, 0x20, 0x2D, 0xE0, 0x1B, 0x48, 0x81, 0x42, 0x14, 0xD1, 0x01, 0x21, 0x16, 0x4D, 0x1C, 0x24	; 02308ACC
	.byte 0x17, 0x4F, 0x0A, 0xE0, 0x08, 0x1C, 0x60, 0x43, 0x10, 0x18, 0x5E, 0x8A, 0x46, 0x83, 0x06, 0x8B	; 02308ADC
	.byte 0x00, 0x2E, 0x01, 0xD0, 0x5E, 0x8A, 0x06, 0x83, 0x49, 0x1C, 0x28, 0x68, 0xC0, 0x5B, 0x81, 0x42	; 02308AEC
	.byte 0xF0, 0xD3, 0x0F, 0xE0, 0x00, 0x29, 0x0D, 0xD0, 0x5C, 0x8A, 0x1C, 0x20, 0x41, 0x43, 0x51, 0x18	; 02308AFC
	.byte 0x4C, 0x83, 0x18, 0x32, 0x19, 0x8A, 0x41, 0x43, 0x54, 0x18, 0x50, 0x5A, 0x00, 0x28, 0x01, 0xD0	; 02308B0C
	.byte 0x58, 0x8A, 0x20, 0x80, 0x98, 0x8A, 0x00, 0x28, 0x01, 0xD0, 0xFD, 0xF7, 0x1B, 0xF9, 0x00, 0x20	; 02308B1C
	.byte 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xF0, 0x02, 0x00, 0x00	; 02308B2C
	.byte 0xF6, 0x02, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x22, 0x4A, 0x80	; 02308B3C
	.byte 0x0A, 0x49, 0x0B, 0x68, 0x0A, 0x49, 0x59, 0x5A, 0x20, 0x29, 0x01, 0xD9, 0x10, 0x1C, 0x0A, 0xE0	; 02308B4C
	.byte 0x20, 0x29, 0x05, 0xD1, 0x07, 0x49, 0x59, 0x5A, 0x00, 0x29, 0x01, 0xD0, 0x10, 0x1C, 0x02, 0xE0	; 02308B5C
	.byte 0x00, 0x8A, 0xFD, 0xF7, 0x81, 0xFE, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 02308B6C
	.byte 0x20, 0x03, 0x00, 0x00, 0x2A, 0x03, 0x00, 0x00, 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x01, 0x20	; 02308B7C
	.byte 0x48, 0x80, 0x2B, 0x49, 0x0A, 0x68, 0x2B, 0x49, 0x51, 0x5A, 0x10, 0x29, 0x4B, 0xD1, 0x28, 0x1C	; 02308B8C
	.byte 0x10, 0x30, 0xFD, 0xF7, 0xC9, 0xFE, 0x04, 0x1C, 0xE8, 0x8A, 0xFD, 0xF7, 0xB3, 0xFE, 0x04, 0x43	; 02308B9C
	.byte 0x28, 0x8B, 0xFD, 0xF7, 0x93, 0xFE, 0x04, 0x43, 0xA8, 0x8B, 0xFD, 0xF7, 0x5D, 0xFE, 0x04, 0x43	; 02308BAC
	.byte 0xE8, 0x8B, 0xFD, 0xF7, 0x45, 0xFE, 0x04, 0x43, 0x28, 0x8C, 0xFD, 0xF7, 0xEB, 0xFD, 0x04, 0x43	; 02308BBC
	.byte 0x68, 0x8C, 0xFD, 0xF7, 0xD9, 0xFD, 0x04, 0x43, 0x28, 0x1C, 0x24, 0x30, 0xFD, 0xF7, 0xAE, 0xFD	; 02308BCC
	.byte 0x04, 0x43, 0x28, 0x1C, 0x74, 0x30, 0x00, 0x88, 0xFD, 0xF7, 0x94, 0xFD, 0x04, 0x43, 0x28, 0x1C	; 02308BDC
	.byte 0x76, 0x30, 0x00, 0x88, 0xFD, 0xF7, 0x78, 0xFD, 0x04, 0x43, 0x28, 0x1C, 0x78, 0x30, 0x00, 0x88	; 02308BEC
	.byte 0xFD, 0xF7, 0x5A, 0xFD, 0x04, 0x43, 0x28, 0x1C, 0x7A, 0x30, 0x00, 0x88, 0x00, 0x21, 0xFD, 0xF7	; 02308BFC
	.byte 0x0B, 0xFD, 0x04, 0x43, 0x28, 0x1C, 0x7C, 0x30, 0xFD, 0xF7, 0xF4, 0xFC, 0x04, 0x43, 0x28, 0x1C	; 02308C0C
	.byte 0x9C, 0x30, 0x00, 0x88, 0xFD, 0xF7, 0x98, 0xFC, 0x04, 0x43, 0x9E, 0x35, 0x28, 0x88, 0xFD, 0xF7	; 02308C1C
	.byte 0x85, 0xFC, 0x04, 0x43, 0x20, 0x1C, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02308C2C
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x20, 0x03, 0x00, 0x00	; 02308C3C
.thumb
P4_Entry_02308C44:
	ldr r0,[pool_02308C88]	; 02308C44
	ldr r1,[r0,#0x0]	; 02308C46
	ldr r0,[pool_02308C8C]	; 02308C48
	ldrh r0,[r1,r0]	; 02308C4A
	cmp r0,#0x0	; 02308C4C
	beq P4_Entry_02308C64	; 02308C4E
	mov r1,#0x0	; 02308C50
	ldr r0,[pool_02308C90]	; 02308C52
	strh r1,[r0,#0x0]	; 02308C54
	strh r1,[r0,#0x4]	; 02308C56
	ldr r2,[pool_02308C94]	; 02308C58
	ldrh r1,[r2,#0x0]	; 02308C5A
	ldr r0,[pool_02308C98]	; 02308C5C
	orr r1,r0	; 02308C5E
	strh r1,[r2,#0x0]	; 02308C60
	bx lr	; 02308C62
P4_Entry_02308C64:
	mov r1,#0x1	; 02308C64
	ldr r0,[pool_02308C9C]	; 02308C66
	strh r1,[r0,#0x0]	; 02308C68
	mov r2,#0x0	; 02308C6A
	ldr r0,[pool_02308CA0]	; 02308C6C
	strh r2,[r0,#0x0]	; 02308C6E
	mov r1,#0x2	; 02308C70
	ldr r0,[pool_02308CA4]	; 02308C72
	strh r1,[r0,#0x0]	; 02308C74
	ldr r1,[pool_02308CA8]	; 02308C76
	ldr r0,[pool_02308CAC]	; 02308C78
	strh r1,[r0,#0x0]	; 02308C7A
	ldr r0,[pool_02308CB0]	; 02308C7C
	strh r2,[r0,#0x0]	; 02308C7E
	ldr r0,[pool_02308CB4]	; 02308C80
	strh r2,[r0,#0x0]	; 02308C82
	bx lr	; 02308C84
	.byte 0xC0, 0x46	; 02308C86
pool_02308C88:
	.word FirmwareWlWorkPointerSlot	; 02308C88
pool_02308C8C:
	.word 0x00000330	; 02308C8C
pool_02308C90:
	.word WifiRamBase	; 02308C90
pool_02308C94:
	.word REG_WIFI_TXBUF_LOC1	; 02308C94
pool_02308C98:
	.word 0x00008000	; 02308C98
pool_02308C9C:
	.word REG_WIFI_TXREQ_RESET	; 02308C9C
pool_02308CA0:
	.word REG_WIFI_MODE_RST	; 02308CA0
pool_02308CA4:
	.word REG_WIFI_IE	; 02308CA4
pool_02308CA8:
	.word 0x0000FFFF	; 02308CA8
pool_02308CAC:
	.word REG_WIFI_IF	; 02308CAC
pool_02308CB0:
	.word REG_WIFI_TX_HDR_CNT	; 02308CB0
pool_02308CB4:
	.word REG_WIFI_POWERFORCE	; 02308CB4
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x29, 0x48, 0x01, 0x68, 0x29, 0x48, 0x0C, 0x18, 0xFF, 0xF7	; 02308CB8
	.byte 0x01, 0xF9, 0xFC, 0xF7, 0xC5, 0xF8, 0x06, 0x20, 0xFC, 0xF7, 0x74, 0xFD, 0x21, 0x1C, 0xAC, 0x31	; 02308CC8
	.byte 0x08, 0x80, 0x68, 0x8A, 0x04, 0x28, 0x03, 0xD1, 0x06, 0x20, 0x00, 0x21, 0xFC, 0xF7, 0x50, 0xFD	; 02308CD8
	.byte 0x00, 0x21, 0x00, 0xA8, 0x01, 0x80, 0x00, 0x88, 0x1E, 0x49, 0x0C, 0x22, 0x00, 0xF0, 0x54, 0xF8	; 02308CE8
	.byte 0x14, 0x20, 0x1C, 0x4A, 0x10, 0x81, 0x1C, 0x48, 0x50, 0x81, 0x0C, 0x32, 0x00, 0x23, 0x1B, 0x49	; 02308CF8
	.byte 0x1B, 0x48, 0x11, 0x80, 0x92, 0x1C, 0x9B, 0x1C, 0x83, 0x42, 0xFA, 0xD3, 0x08, 0x21, 0x15, 0x48	; 02308D08
	.byte 0x81, 0x81, 0x06, 0x21, 0x17, 0x48, 0x01, 0x80, 0x12, 0x20, 0x20, 0x81, 0x01, 0x21, 0x21, 0x83	; 02308D18
	.byte 0xE8, 0x8A, 0xFD, 0xF7, 0x2F, 0xF9, 0x14, 0x49, 0x14, 0x48, 0x01, 0x80, 0x14, 0x48, 0xFC, 0xF7	; 02308D28
	.byte 0xDB, 0xFB, 0x02, 0x21, 0x13, 0x48, 0x01, 0x80, 0x01, 0x21, 0x13, 0x48, 0x01, 0x80, 0x13, 0x48	; 02308D38
	.byte 0x01, 0x80, 0x08, 0x49, 0x12, 0x48, 0x01, 0x40, 0xC8, 0x03, 0x01, 0x0C, 0x0A, 0x48, 0x01, 0x43	; 02308D48
	.byte 0x10, 0x48, 0x01, 0x80, 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03	; 02308D58
	.byte 0x18, 0x03, 0x00, 0x00, 0x00, 0x40, 0x80, 0x04, 0xD0, 0x07, 0x00, 0x00, 0x55, 0x55, 0x00, 0x00	; 02308D68
	.byte 0xF8, 0x05, 0x00, 0x00, 0x94, 0x81, 0x80, 0x04, 0x00, 0x80, 0x00, 0x00, 0x40, 0x80, 0x80, 0x04	; 02308D78
	.byte 0xDC, 0x05, 0x00, 0x00, 0x12, 0x80, 0x80, 0x04, 0x04, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04	; 02308D88
	.byte 0xFF, 0x3F, 0x00, 0x00, 0xA0, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 02308D98
	.byte 0x1C, 0xF3, 0x7F, 0x03, 0x70, 0xB5, 0x82, 0xB0, 0x04, 0x1C, 0x5F, 0x48, 0x02, 0x68, 0x5F, 0x48	; 02308DA8
	.byte 0x15, 0x18, 0x01, 0x20, 0x48, 0x80, 0x2A, 0x89, 0xF0, 0x21, 0x0A, 0x40, 0x10, 0x2A, 0x00, 0xD0	; 02308DB8
	.byte 0xAD, 0xE0, 0x20, 0x8A, 0x01, 0x28, 0x01, 0xD9, 0x05, 0x20, 0xA8, 0xE0, 0xA0, 0x8A, 0x0A, 0x28	; 02308DC8
	.byte 0x03, 0xD0, 0x14, 0x28, 0x01, 0xD0, 0x05, 0x20, 0xA1, 0xE0, 0xE0, 0x8A, 0xFC, 0xF7, 0x5A, 0xFD	; 02308DD8
	.byte 0x00, 0x28, 0x01, 0xD1, 0x05, 0x20, 0x9A, 0xE0, 0x60, 0x8A, 0x04, 0x28, 0x01, 0xD9, 0x05, 0x20	; 02308DE8
	.byte 0x95, 0xE0, 0x00, 0x20, 0x04, 0xF0, 0x48, 0xFB, 0x00, 0x28, 0x01, 0xD0, 0x0E, 0x20, 0x8E, 0xE0	; 02308DF8
	.byte 0x20, 0x8A, 0x00, 0x28, 0x5E, 0xD0, 0x01, 0x28, 0x00, 0xD0, 0x87, 0xE0, 0x28, 0x89, 0x10, 0x28	; 02308E08
	.byte 0x01, 0xD0, 0x01, 0x20, 0x83, 0xE0, 0x00, 0x20, 0x00, 0x90, 0x65, 0x20, 0x01, 0x21, 0x00, 0xAA	; 02308E18
	.byte 0x04, 0xF0, 0xCC, 0xFA, 0x00, 0x9E, 0x01, 0x20, 0xFC, 0xF7, 0xC4, 0xFC, 0x86, 0x42, 0x06, 0xD0	; 02308E28
	.byte 0x01, 0x20, 0x31, 0x1C, 0xFC, 0xF7, 0xA4, 0xFC, 0x3D, 0x48, 0xFC, 0xF7, 0x55, 0xFB, 0x60, 0x8A	; 02308E38
	.byte 0x04, 0x28, 0x6B, 0xD8, 0x00, 0x18, 0x78, 0x44, 0x00, 0x89, 0x00, 0x04, 0x00, 0x14, 0x78, 0x44	; 02308E48
	.byte 0x00, 0x47, 0x0B, 0x00, 0x0B, 0x00, 0x0B, 0x00, 0x6B, 0x00, 0x6B, 0x00, 0x11, 0x20, 0x28, 0x81	; 02308E58
	.byte 0xE0, 0x8A, 0x01, 0x21, 0xFD, 0xF7, 0x8E, 0xF8, 0x32, 0x49, 0x33, 0x48, 0x01, 0x80, 0x33, 0x48	; 02308E68
	.byte 0xFC, 0xF7, 0x3A, 0xFB, 0xA0, 0x8A, 0xE8, 0x82, 0x02, 0x20, 0xFC, 0xF7, 0x9B, 0xFC, 0x00, 0x90	; 02308E78
	.byte 0x61, 0x8A, 0x01, 0x29, 0x02, 0xD8, 0x10, 0x21, 0x08, 0x43, 0x00, 0x90, 0xA1, 0x8A, 0x2C, 0x48	; 02308E88
	.byte 0x01, 0x80, 0x61, 0x8A, 0x01, 0x29, 0x07, 0xD1, 0x00, 0x99, 0x20, 0x20, 0x01, 0x43, 0x00, 0x91	; 02308E98
	.byte 0x03, 0x21, 0x28, 0x48, 0x01, 0x80, 0x01, 0xE0, 0x26, 0x48, 0x01, 0x80, 0x02, 0x20, 0x00, 0x99	; 02308EA8
	.byte 0xFC, 0xF7, 0x66, 0xFC, 0x24, 0x49, 0x25, 0x48, 0x01, 0x80, 0x2F, 0xE0, 0x20, 0x1C, 0xFF, 0xF7	; 02308EB8
	.byte 0xF7, 0xFE, 0x2B, 0xE0, 0x28, 0x89, 0x11, 0x28, 0x15, 0xD1, 0xFC, 0xF7, 0xC9, 0xFA, 0x00, 0x22	; 02308EC8
	.byte 0x1E, 0x48, 0x02, 0x80, 0x01, 0x21, 0x1B, 0x48, 0x01, 0x80, 0x17, 0x48, 0x02, 0x80, 0x02, 0x20	; 02308ED8
	.byte 0xFC, 0xF7, 0x68, 0xFC, 0x00, 0x90, 0x30, 0x22, 0x01, 0x1C, 0x91, 0x43, 0x00, 0x91, 0x02, 0x20	; 02308EE8
	.byte 0xFC, 0xF7, 0x46, 0xFC, 0x10, 0xE0, 0x12, 0x28, 0x0C, 0xD1, 0x00, 0x20, 0x28, 0x83, 0x14, 0x49	; 02308EF8
	.byte 0x08, 0x88, 0x00, 0x28, 0xFC, 0xD1, 0x06, 0x20, 0x29, 0x1C, 0xAC, 0x31, 0x09, 0x88, 0xFC, 0xF7	; 02308F08
	.byte 0x37, 0xFC, 0x01, 0xE0, 0x01, 0x20, 0x02, 0xE0, 0x10, 0x20, 0x28, 0x81, 0x00, 0x20, 0x02, 0xB0	; 02308F18
	.byte 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00	; 02308F28
	.byte 0x88, 0x13, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x40, 0x80, 0x80, 0x04, 0xDC, 0x05, 0x00, 0x00	; 02308F38
	.byte 0xA4, 0x81, 0x80, 0x04, 0xA2, 0x81, 0x80, 0x04, 0x23, 0x08, 0x00, 0x00, 0xA0, 0x81, 0x80, 0x04	; 02308F48
	.byte 0x04, 0x80, 0x80, 0x04, 0x02, 0x20, 0x48, 0x80, 0x03, 0x48, 0x02, 0x68, 0x03, 0x48, 0x10, 0x5A	; 02308F58
	.byte 0xC8, 0x80, 0x00, 0x20, 0x70, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x20, 0x03, 0x00, 0x00	; 02308F68
	.byte 0x10, 0xB5, 0x0C, 0x1C, 0x0C, 0x48, 0x01, 0x68, 0x0C, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x01, 0xD1	; 02308F78
	.byte 0x01, 0x20, 0x0D, 0xE0, 0x5C, 0x20, 0x60, 0x80, 0xFC, 0xF7, 0xE2, 0xFC, 0x06, 0x48, 0x01, 0x68	; 02308F88
	.byte 0x07, 0x48, 0x08, 0x18, 0x08, 0x34, 0x21, 0x1C, 0xB4, 0x22, 0x00, 0xF0, 0x0B, 0xF8, 0x00, 0x20	; 02308F98
	.byte 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x20, 0x03, 0x00, 0x00	; 02308FA8
	.byte 0x10, 0x05, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x64, 0xF3, 0x7F, 0x03	; 02308FB8
	.byte 0x10, 0xB5, 0x0C, 0x1C, 0x09, 0x20, 0x60, 0x80, 0x0B, 0x48, 0xA1, 0x1D, 0x08, 0x22, 0x00, 0xF0	; 02308FC8
	.byte 0x1B, 0xF8, 0x0A, 0x48, 0x00, 0x88, 0xE0, 0x81, 0x00, 0x20, 0xFC, 0xF7, 0xEB, 0xFB, 0x20, 0x82	; 02308FD8
	.byte 0xFC, 0xF7, 0xA0, 0xFB, 0x60, 0x82, 0x06, 0x48, 0x01, 0x68, 0x06, 0x48, 0x08, 0x5A, 0xA0, 0x82	; 02308FE8
	.byte 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0x2C, 0xDB, 0x30, 0x02, 0x00, 0x80, 0x80, 0x04	; 02308FF8
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xCC, 0x05, 0x00, 0x00, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 02309008
	.byte 0x34, 0xF3, 0x7F, 0x03, 0x00, 0xB5, 0x81, 0xB0, 0x07, 0x48, 0x02, 0x68, 0x07, 0x48, 0x10, 0x5A	; 02309018
	.byte 0x00, 0x28, 0x01, 0xD1, 0x01, 0x20, 0x04, 0xE0, 0x01, 0x20, 0x48, 0x80, 0xFC, 0xF7, 0x62, 0xFD	; 02309028
	.byte 0x00, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x20, 0x03, 0x00, 0x00	; 02309038
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x20, 0x48, 0x80, 0x06, 0x48, 0x01, 0x68, 0x06, 0x48, 0x08, 0x5A	; 02309048
	.byte 0x20, 0x28, 0x01, 0xD3, 0xFB, 0xF7, 0xFC, 0xFE, 0xFB, 0xF7, 0x6C, 0xFD, 0x00, 0x20, 0x01, 0xB0	; 02309058
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x20, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0	; 02309068
	.byte 0x01, 0x20, 0x48, 0x80, 0x0A, 0x48, 0x01, 0x68, 0x0A, 0x48, 0x08, 0x5A, 0x10, 0x28, 0x05, 0xD0	; 02309078
	.byte 0x20, 0x28, 0x08, 0xD1, 0x08, 0x48, 0x08, 0x5A, 0x00, 0x28, 0x04, 0xD1, 0x20, 0x20, 0xFE, 0xF7	; 02309088
	.byte 0x0F, 0xF8, 0x00, 0x20, 0x00, 0xE0, 0x01, 0x20, 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46	; 02309098
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x20, 0x03, 0x00, 0x00, 0x2A, 0x03, 0x00, 0x00, 0x00, 0xB5, 0x81, 0xB0	; 023090A8
	.byte 0x01, 0x20, 0x48, 0x80, 0x0B, 0x49, 0x0A, 0x68, 0x0B, 0x49, 0x51, 0x5A, 0x20, 0x29, 0x0E, 0xD8	; 023090B8
	.byte 0x0A, 0x49, 0x51, 0x5A, 0x00, 0x29, 0x0A, 0xD1, 0x00, 0x20, 0x04, 0xF0, 0xDD, 0xF9, 0x00, 0x28	; 023090C8
	.byte 0x01, 0xD0, 0x0E, 0x20, 0x03, 0xE0, 0x10, 0x20, 0xFD, 0xF7, 0xEA, 0xFF, 0x00, 0x20, 0x01, 0xB0	; 023090D8
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x20, 0x03, 0x00, 0x00, 0x2A, 0x03, 0x00, 0x00	; 023090E8
	.byte 0x00, 0xB5, 0x81, 0xB0, 0x01, 0x20, 0x48, 0x80, 0x07, 0x49, 0x0A, 0x68, 0x07, 0x49, 0x51, 0x5A	; 023090F8
	.byte 0x00, 0x29, 0x01, 0xD0, 0x10, 0x29, 0x03, 0xD1, 0x00, 0x20, 0xFD, 0xF7, 0xD1, 0xFF, 0x00, 0x20	; 02309108
	.byte 0x01, 0xB0, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x20, 0x03, 0x00, 0x00	; 02309118
.arm
.thumb

; ===== function loc_02309128 =====
loc_02309128:
	ldrh r2,[r1,#0xe]	; 02309128
	lsl r2,r2,#0x1	; 0230912A
	add r3,r1,r2	; 0230912C
	add r2,r3,#0x0	; 0230912E
	add r2,#0x10	; 02309130
	ldrh r3,[r3,#0x10]	; 02309132
	strh r3,[r1,#0xc]	; 02309134
	mov r3,#0x2	; 02309136
	strh r3,[r2,#0x2]	; 02309138
	mov r3,#0x0	; 0230913A
	strh r3,[r2,#0x4]	; 0230913C
	ldrh r3,[r1,#0x18]	; 0230913E
	strh r3,[r2,#0x6]	; 02309140
	ldr r3,[pool_02309148]	; 02309142
	bx r3	; 02309144
	.byte 0xC0, 0x46	; 02309148
pool_02309148:
loc_02309148:
	.word loc_037FB960 + 1	; 02309148

; ===== function loc_0230914C =====
	push {r4,lr}	; 0230914C
	add r4,r0,#0x0	; 0230914E
	mov r2,#0x1	; 02309150
	strh r2,[r1,#0x2]	; 02309152
	ldrh r0,[r4,#0x10]	; 02309154
	and r0,r2	; 02309156
	cmp r0,#0x0	; 02309158
	beq loc_02309160	; 0230915A
	bl loc_0230A824	; 0230915C
loc_02309160:
	ldrh r1,[r4,#0x10]	; 02309160
	mov r0,#0x2	; 02309162
	and r1,r0	; 02309164
	cmp r1,#0x0	; 02309166
	beq loc_0230916E	; 02309168
	bl loc_0230A7D0	; 0230916A
loc_0230916E:
	ldrh r1,[r4,#0x10]	; 0230916E
	mov r0,#0x4	; 02309170
	and r1,r0	; 02309172
	cmp r1,#0x0	; 02309174
	beq loc_0230917C	; 02309176
	bl loc_0230A758	; 02309178
loc_0230917C:
	mov r0,#0x0	; 0230917C
	pop {r4}	; 0230917E
	pop {r3}	; 02309180
	bx r3	; 02309182
	.byte 0x10, 0xB5, 0x04, 0x1C, 0x01, 0x20, 0x48, 0x80, 0x0C, 0x48, 0xA0, 0x81, 0x20, 0x1C, 0x10, 0x30	; 02309194
	.byte 0x00, 0x21, 0x41, 0x80, 0xC1, 0x88, 0x41, 0x82, 0xFE, 0xF7, 0xCA, 0xF9, 0x08, 0x48, 0x02, 0x68	; 023091A4
	.byte 0x08, 0x48, 0x10, 0x18, 0x08, 0x49, 0x51, 0x18, 0x22, 0x1C, 0xFE, 0xF7, 0x0D, 0xFA, 0x00, 0x20	; 023091B4
	.byte 0x01, 0xF0, 0xA4, 0xFE, 0x00, 0x20, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xFF, 0xFF, 0x00, 0x00	; 023091C4
	.byte 0xF4, 0xFF, 0x80, 0x03, 0xD4, 0x01, 0x00, 0x00, 0x68, 0x01, 0x00, 0x00, 0xF0, 0xB5, 0x89, 0xB0	; 023091D4
	.byte 0x05, 0x1C, 0xD3, 0x48, 0x00, 0x68, 0xD3, 0x4A, 0x82, 0x18, 0x00, 0x92, 0xD2, 0x4A, 0x82, 0x18	; 023091E4
	.byte 0x01, 0x92, 0xD2, 0x4A, 0x82, 0x18, 0x02, 0x92, 0xD1, 0x4A, 0x86, 0x18, 0xD1, 0x4A, 0x80, 0x5A	; 023091F4
	.byte 0x03, 0x90, 0x01, 0x20, 0x06, 0x90, 0x48, 0x80, 0x01, 0x98, 0x40, 0x8A, 0x01, 0x28, 0x01, 0xD0	; 02309204
	.byte 0x0B, 0x20, 0x89, 0xE1, 0xB0, 0x8F, 0x00, 0x28, 0x01, 0xD0, 0x08, 0x20, 0x84, 0xE1, 0x74, 0x6C	; 02309214
	.byte 0x2A, 0x8A, 0xC9, 0x48, 0x11, 0x1C, 0x01, 0x40, 0x00, 0x29, 0x24, 0xD0, 0x02, 0x20, 0x02, 0x40	; 02309224
	.byte 0x00, 0x2A, 0x03, 0xD1, 0x30, 0x1C, 0x94, 0x30, 0x00, 0x88, 0xA8, 0x82, 0x29, 0x8A, 0x04, 0x20	; 02309234
	.byte 0x01, 0x40, 0x00, 0x29, 0x03, 0xD1, 0x30, 0x1C, 0xA0, 0x30, 0x00, 0x88, 0xE8, 0x82, 0x29, 0x8A	; 02309244
	.byte 0x08, 0x20, 0x01, 0x40, 0x00, 0x29, 0x03, 0xD1, 0x30, 0x1C, 0x96, 0x30, 0x00, 0x88, 0x28, 0x83	; 02309254
	.byte 0x29, 0x8A, 0x10, 0x20, 0x01, 0x40, 0x00, 0x29, 0x05, 0xD1, 0x30, 0x1C, 0x9C, 0x30, 0x00, 0x88	; 02309264
	.byte 0xA8, 0x83, 0x00, 0x20, 0x06, 0x90, 0xA9, 0x8B, 0xB4, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20	; 02309274
	.byte 0x52, 0xE1, 0x02, 0x20, 0x00, 0x21, 0x05, 0x91, 0x08, 0xE0, 0xE9, 0x8A, 0x01, 0x40, 0x00, 0x29	; 02309284
	.byte 0x02, 0xD0, 0x05, 0x99, 0x49, 0x1C, 0x05, 0x91, 0x40, 0x04, 0x00, 0x0C, 0x00, 0x28, 0xF4, 0xD1	; 02309294
	.byte 0xA9, 0x8A, 0x30, 0x1C, 0x94, 0x30, 0x01, 0x80, 0xA8, 0x8A, 0xA7, 0x49, 0x02, 0x1C, 0x0A, 0x40	; 023092A4
	.byte 0x00, 0x2A, 0x0C, 0xD0, 0xA6, 0x49, 0x08, 0x40, 0xA8, 0x82, 0xA8, 0x8A, 0xD0, 0x38, 0x87, 0x08	; 023092B4
	.byte 0xEA, 0x20, 0xE0, 0x81, 0xA3, 0x48, 0x87, 0x42, 0x19, 0xD9, 0x05, 0x20, 0x2C, 0xE1, 0x02, 0x23	; 023092C4
	.byte 0x03, 0x99, 0x19, 0x40, 0x00, 0x29, 0x02, 0xD0, 0x01, 0x22, 0x06, 0x21, 0x02, 0xE0, 0x00, 0x22	; 023092D4
	.byte 0x13, 0x1C, 0x11, 0x1C, 0x87, 0x18, 0x9C, 0x48, 0x10, 0x18, 0x87, 0x42, 0x01, 0xD9, 0x05, 0x20	; 023092E4
	.byte 0x1A, 0xE1, 0xB8, 0x00, 0xD0, 0x30, 0x18, 0x18, 0xA8, 0x82, 0xEA, 0x31, 0xE1, 0x81, 0x09, 0x37	; 023092F4
	.byte 0x01, 0x20, 0x87, 0x43, 0x39, 0x1C, 0x07, 0x91, 0x05, 0x98, 0x41, 0x43, 0x07, 0x91, 0x02, 0x98	; 02309304
	.byte 0x0C, 0x30, 0x1A, 0x31, 0xFB, 0xF7, 0x2A, 0xFD, 0x31, 0x1C, 0x90, 0x31, 0x08, 0x60, 0x30, 0x1C	; 02309314
	.byte 0x90, 0x30, 0x00, 0x68, 0x00, 0x28, 0x01, 0xD1, 0x08, 0x20, 0xFD, 0xE0, 0x01, 0x20, 0xB0, 0x87	; 02309324
	.byte 0xF0, 0x8F, 0x40, 0x1C, 0xF0, 0x87, 0x29, 0x8B, 0x30, 0x1C, 0x96, 0x30, 0x01, 0x80, 0xE9, 0x8A	; 02309334
	.byte 0x30, 0x1C, 0x98, 0x30, 0x01, 0x80, 0x00, 0x20, 0x31, 0x1C, 0x9A, 0x31, 0x08, 0x80, 0xAA, 0x8B	; 02309344
	.byte 0x31, 0x1C, 0x9C, 0x31, 0x0A, 0x80, 0x6A, 0x8A, 0x31, 0x1C, 0x9E, 0x31, 0x0A, 0x80, 0x20, 0x80	; 02309354
	.byte 0xE9, 0x8A, 0x61, 0x80, 0xA0, 0x80, 0x14, 0x20, 0x20, 0x81, 0xA8, 0x8B, 0x22, 0x30, 0x60, 0x81	; 02309364
	.byte 0x7A, 0x48, 0xA0, 0x81, 0xE2, 0x89, 0xA9, 0x8A, 0x0A, 0x31, 0x05, 0x98, 0x41, 0x43, 0x50, 0x18	; 02309374
	.byte 0xE0, 0x81, 0x20, 0x1C, 0x10, 0x30, 0x76, 0x49, 0x00, 0x9A, 0x64, 0x32, 0x00, 0x92, 0x01, 0x9B	; 02309384
	.byte 0x08, 0x33, 0x01, 0x93, 0xFC, 0xF7, 0xD4, 0xFB, 0x29, 0x8A, 0x6B, 0x48, 0x01, 0x40, 0x00, 0x29	; 02309394
	.byte 0x06, 0xD0, 0x61, 0x8C, 0x6F, 0x48, 0x81, 0x42, 0x02, 0xD0, 0x6F, 0x48, 0x04, 0x90, 0x03, 0xE0	; 023093A4
	.byte 0x00, 0x20, 0x04, 0x90, 0x6B, 0x48, 0x60, 0x84, 0xA8, 0x8A, 0xA0, 0x84, 0xE8, 0x8A, 0xE0, 0x84	; 023093B4
	.byte 0xE8, 0x8B, 0x20, 0x85, 0x06, 0x98, 0x00, 0x28, 0x07, 0xD0, 0xAA, 0x8B, 0x00, 0x2A, 0x04, 0xD0	; 023093C4
	.byte 0x20, 0x1C, 0x2A, 0x30, 0x29, 0x6A, 0xFB, 0xF7, 0x2B, 0xFF, 0x04, 0x21, 0x03, 0x98, 0x08, 0x40	; 023093D4
	.byte 0x03, 0x90, 0x00, 0x28, 0x0B, 0xD0, 0x21, 0x1C, 0x28, 0x31, 0xA8, 0x8B, 0x80, 0x1C, 0x08, 0x18	; 023093E4
	.byte 0xC0, 0x1C, 0x03, 0x21, 0x88, 0x43, 0x5D, 0x49, 0x01, 0x80, 0x5D, 0x49, 0x41, 0x80, 0x5D, 0x49	; 023093F4
	.byte 0x30, 0x1C, 0x90, 0x30, 0x00, 0x68, 0x81, 0x81, 0x07, 0x98, 0x0B, 0x30, 0x07, 0x90, 0x41, 0x08	; 02309404
	.byte 0x30, 0x1C, 0x90, 0x30, 0x00, 0x68, 0xC1, 0x81, 0xE9, 0x8A, 0x30, 0x1C, 0x90, 0x30, 0x00, 0x68	; 02309414
	.byte 0x01, 0x82, 0x30, 0x1C, 0x90, 0x30, 0x01, 0x68, 0x05, 0x98, 0x88, 0x82, 0x30, 0x1C, 0x90, 0x30	; 02309424
	.byte 0x00, 0x68, 0xC7, 0x82, 0x30, 0x1C, 0x90, 0x30, 0x01, 0x68, 0x00, 0x20, 0x08, 0x83, 0x30, 0x1C	; 02309434
	.byte 0x90, 0x30, 0x01, 0x68, 0x1A, 0x31, 0x01, 0x23, 0x02, 0x20, 0x0D, 0xE0, 0xEA, 0x8A, 0x02, 0x40	; 02309444
	.byte 0x00, 0x2A, 0x06, 0xD0, 0x43, 0x4A, 0x0A, 0x80, 0x00, 0x22, 0x4A, 0x80, 0xCA, 0x80, 0x8B, 0x80	; 02309454
	.byte 0xC9, 0x19, 0x40, 0x04, 0x00, 0x0C, 0x5B, 0x1C, 0x00, 0x28, 0xEF, 0xD1, 0xA9, 0x8A, 0x42, 0x48	; 02309464
	.byte 0x01, 0x80, 0xE1, 0x89, 0x41, 0x48, 0x01, 0x80, 0x69, 0x8B, 0x36, 0x48, 0x47, 0x1A, 0x28, 0x8B	; 02309474
	.byte 0x00, 0x28, 0x1E, 0xD1, 0xA8, 0x8B, 0x22, 0x30, 0x82, 0x00, 0x60, 0x32, 0xA9, 0x8A, 0x05, 0x98	; 02309484
	.byte 0x41, 0x43, 0x3B, 0x48, 0x08, 0x18, 0x10, 0x18, 0x32, 0x30, 0x0A, 0x21, 0x00, 0xF0, 0x7A, 0xF8	; 02309494
	.byte 0x05, 0x1C, 0x00, 0xF0, 0x7D, 0xF8, 0x37, 0x49, 0x0D, 0x80, 0x37, 0x49, 0x0C, 0x40, 0x62, 0x08	; 023094A4
	.byte 0x25, 0x49, 0x0A, 0x43, 0x04, 0x99, 0x0A, 0x43, 0x34, 0x49, 0x0A, 0x80, 0x00, 0xF0, 0x76, 0xF8	; 023094B4
	.byte 0x31, 0xE0, 0x00, 0xF0, 0x79, 0xF8, 0x08, 0x90, 0x31, 0x48, 0x00, 0x88, 0x38, 0x18, 0x25, 0x49	; 023094C4
	.byte 0x08, 0x40, 0x0A, 0x21, 0x00, 0xF0, 0x76, 0xF8, 0x2A, 0x8B, 0xC1, 0x1C, 0x91, 0x42, 0x10, 0xD2	; 023094D4
	.byte 0x10, 0x1A, 0x41, 0x1E, 0x27, 0x48, 0x01, 0x80, 0x27, 0x48, 0x04, 0x40, 0x61, 0x08, 0x16, 0x48	; 023094E4
	.byte 0x01, 0x43, 0x04, 0x98, 0x01, 0x43, 0x25, 0x48, 0x01, 0x80, 0x08, 0x98, 0x00, 0xF0, 0x68, 0xF8	; 023094F4
	.byte 0x11, 0xE0, 0x08, 0x98, 0x00, 0xF0, 0x6A, 0xF8, 0x02, 0x98, 0x0C, 0x30, 0x02, 0x90, 0x31, 0x1C	; 02309504
	.byte 0x90, 0x31, 0x09, 0x68, 0xFB, 0xF7, 0x98, 0xFB, 0x00, 0x20, 0xB0, 0x87, 0xF0, 0x8F, 0x40, 0x1E	; 02309514
	.byte 0xF0, 0x87, 0x05, 0x20, 0x00, 0xE0, 0x00, 0x20, 0x09, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 02309524
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00, 0xF0, 0x02, 0x00, 0x00, 0x50, 0x01, 0x00, 0x00	; 02309534
	.byte 0x00, 0x04, 0x00, 0x00, 0x38, 0x06, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x04, 0x02, 0x00, 0x00	; 02309544
	.byte 0xFF, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x06, 0x02, 0x00, 0x00, 0x28, 0x02, 0x00, 0x00	; 02309554
	.byte 0x20, 0xD6, 0x30, 0x02, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0xB8, 0xB6, 0x00, 0x00	; 02309564
	.byte 0x46, 0x1D, 0x00, 0x00, 0x84, 0x01, 0x00, 0x00, 0xC4, 0x80, 0x80, 0x04, 0xC0, 0x80, 0x80, 0x04	; 02309574
	.byte 0x88, 0x03, 0x00, 0x00, 0x18, 0x81, 0x80, 0x04, 0xFF, 0x3F, 0x00, 0x00, 0x90, 0x80, 0x80, 0x04	; 02309584
	.byte 0xF8, 0x80, 0x80, 0x04, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0xB0, 0x4D, 0x80, 0x03	; 02309594
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x04, 0xF1, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46	; 023095A4
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x18, 0xF1, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5	; 023095B4
	.byte 0x04, 0xF1, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0xB0, 0x4D, 0x80, 0x03	; 023095C4
	.byte 0x78, 0x47, 0xC0, 0x46, 0x04, 0xF0, 0x1F, 0xE5, 0x18, 0xF1, 0x7F, 0x03, 0x78, 0x47, 0xC0, 0x46	; 023095D4
	.byte 0x04, 0xF0, 0x1F, 0xE5, 0x18, 0xF1, 0x7F, 0x03, 0xF0, 0xB5, 0x83, 0xB0, 0x06, 0x1C, 0x3A, 0x48	; 023095E4
	.byte 0x00, 0x68, 0x3A, 0x4A, 0x83, 0x18, 0x3A, 0x4A, 0x82, 0x18, 0x3A, 0x4C, 0x07, 0x19, 0x3A, 0x4C	; 023095F4
	.byte 0x00, 0x5B, 0x00, 0x90, 0x01, 0x25, 0x4D, 0x80, 0x50, 0x8A, 0x02, 0x28, 0x01, 0xD0, 0x0B, 0x20	; 02309604
	.byte 0x5D, 0xE0, 0x31, 0x8A, 0x35, 0x48, 0x81, 0x42, 0x01, 0xD9, 0x05, 0x20, 0x57, 0xE0, 0x38, 0x1C	; 02309614
	.byte 0x50, 0x30, 0x00, 0x88, 0x00, 0x28, 0x00, 0xD1, 0x00, 0x25, 0x14, 0x20, 0x45, 0x43, 0x39, 0x1C	; 02309624
	.byte 0x50, 0x31, 0x48, 0x19, 0x01, 0x90, 0x48, 0x5B, 0x00, 0x28, 0x01, 0xD0, 0x08, 0x20, 0x46, 0xE0	; 02309634
	.byte 0x2B, 0x48, 0x01, 0x88, 0x2B, 0x48, 0x01, 0x40, 0x00, 0x29, 0x01, 0xD0, 0x08, 0x20, 0x3E, 0xE0	; 02309644
	.byte 0x78, 0x19, 0x84, 0x6D, 0x00, 0x20, 0x20, 0x80, 0xA0, 0x80, 0x14, 0x20, 0x20, 0x81, 0x30, 0x8A	; 02309654
	.byte 0x1E, 0x30, 0x60, 0x81, 0x24, 0x48, 0xA0, 0x81, 0x20, 0x1C, 0x10, 0x30, 0x64, 0x33, 0x19, 0x1C	; 02309664
	.byte 0x08, 0x32, 0x22, 0x4B, 0xFC, 0xF7, 0x64, 0xFA, 0x70, 0x8A, 0xA0, 0x84, 0x32, 0x8A, 0x00, 0x2A	; 02309674
	.byte 0x04, 0xD0, 0x20, 0x1C, 0x26, 0x30, 0x71, 0x69, 0xFB, 0xF7, 0xD2, 0xFD, 0x04, 0x21, 0x00, 0x98	; 02309684
	.byte 0x08, 0x40, 0x00, 0x90, 0x00, 0x28, 0x0B, 0xD0, 0x21, 0x1C, 0x24, 0x31, 0x30, 0x8A, 0x80, 0x1C	; 02309694
	.byte 0x08, 0x18, 0xC1, 0x1C, 0x03, 0x20, 0x81, 0x43, 0x15, 0x48, 0x08, 0x80, 0x15, 0x48, 0x48, 0x80	; 023096A4
	.byte 0x01, 0x21, 0x01, 0x98, 0x01, 0x80, 0x52, 0x37, 0x78, 0x5B, 0x40, 0x1C, 0x78, 0x53, 0x12, 0x48	; 023096B4
	.byte 0x04, 0x40, 0x61, 0x08, 0x0B, 0x48, 0x01, 0x43, 0x09, 0x48, 0x01, 0x80, 0x00, 0x20, 0x03, 0xB0	; 023096C4
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00	; 023096D4
	.byte 0xF0, 0x02, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x38, 0x06, 0x00, 0x00, 0x04, 0x02, 0x00, 0x00	; 023096E4
	.byte 0x94, 0x80, 0x80, 0x04, 0x00, 0x80, 0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0x10, 0xD6, 0x30, 0x02	; 023096F4
	.byte 0xB8, 0xB6, 0x00, 0x00, 0x46, 0x1D, 0x00, 0x00, 0xFF, 0x3F, 0x00, 0x00, 0xF0, 0xB5, 0x83, 0xB0	; 02309704
	.byte 0x00, 0x90, 0x55, 0x48, 0x01, 0x68, 0x55, 0x48, 0x0E, 0x18, 0x55, 0x48, 0x0F, 0x18, 0x55, 0x48	; 02309714
	.byte 0x0D, 0x18, 0x00, 0x9C, 0x10, 0x34, 0x00, 0x98, 0xC1, 0x8A, 0x53, 0x48, 0x81, 0x42, 0x01, 0xD9	; 02309724
	.byte 0x05, 0x20, 0x94, 0xE0, 0x78, 0x8A, 0x01, 0x28, 0x0C, 0xD1, 0x20, 0x1C, 0x18, 0x30, 0xFD, 0xF7	; 02309734
	.byte 0xBF, 0xFF, 0x01, 0x90, 0xFF, 0x28, 0x03, 0xD0, 0xFD, 0xF7, 0xA6, 0xFD, 0x40, 0x28, 0x05, 0xD0	; 02309744
	.byte 0x0A, 0x20, 0x84, 0xE0, 0x30, 0x1C, 0x88, 0x30, 0x00, 0x88, 0x01, 0x90, 0x01, 0x98, 0x60, 0x80	; 02309754
	.byte 0x41, 0x48, 0x01, 0x68, 0x45, 0x48, 0x08, 0x58, 0xA0, 0x80, 0xE2, 0x89, 0xFF, 0x20, 0x11, 0x1C	; 02309764
	.byte 0x01, 0x40, 0x00, 0x29, 0x04, 0xD1, 0x01, 0x98, 0xFD, 0xF7, 0x4A, 0xFD, 0x20, 0x82, 0x02, 0xE0	; 02309774
	.byte 0x22, 0x82, 0x00, 0x20, 0xE0, 0x81, 0xE0, 0x88, 0x00, 0x28, 0x0A, 0xD1, 0x30, 0x1C, 0x8A, 0x30	; 02309784
	.byte 0x01, 0x88, 0x40, 0x20, 0x01, 0x43, 0x3A, 0x48, 0x01, 0x40, 0xA1, 0x82, 0x1C, 0x20, 0x60, 0x82	; 02309794
	.byte 0x0D, 0xE0, 0x30, 0x1C, 0x8A, 0x30, 0x00, 0x88, 0xA0, 0x82, 0x38, 0x8B, 0x00, 0x28, 0x03, 0xD1	; 023097A4
	.byte 0xE0, 0x88, 0x1C, 0x30, 0x60, 0x82, 0x02, 0xE0, 0xE0, 0x88, 0x24, 0x30, 0x60, 0x82, 0x78, 0x8A	; 023097B4
	.byte 0x01, 0x28, 0x04, 0xD0, 0x02, 0x28, 0x30, 0xD0, 0x03, 0x28, 0x2E, 0xD0, 0x46, 0xE0, 0x20, 0x1C	; 023097C4
	.byte 0x24, 0x30, 0x21, 0x1C, 0x1E, 0x31, 0xFC, 0xF7, 0xD7, 0xF9, 0x20, 0x1C, 0x1E, 0x30, 0x64, 0x36	; 023097D4
	.byte 0x31, 0x1C, 0xFC, 0xF7, 0xD1, 0xF9, 0x01, 0x98, 0x00, 0x28, 0x10, 0xD1, 0x84, 0x35, 0x28, 0x1C	; 023097E4
	.byte 0x00, 0x99, 0xFD, 0xF7, 0xCD, 0xFE, 0x1C, 0x48, 0x02, 0x68, 0x22, 0x48, 0x11, 0x5A, 0x22, 0x48	; 023097F4
	.byte 0x10, 0x5A, 0x81, 0x43, 0x00, 0x29, 0x29, 0xD1, 0x01, 0xF0, 0x3A, 0xFB, 0x26, 0xE0, 0x20, 0x1C	; 02309804
	.byte 0xFD, 0xF7, 0x96, 0xFE, 0x28, 0x1C, 0x84, 0x30, 0x18, 0x35, 0x29, 0x1C, 0x00, 0x9A, 0xFD, 0xF7	; 02309814
	.byte 0xDB, 0xFE, 0x00, 0x20, 0x01, 0xF0, 0x72, 0xFB, 0x18, 0xE0, 0x20, 0x1C, 0x24, 0x30, 0x21, 0x1C	; 02309824
	.byte 0x18, 0x31, 0xFC, 0xF7, 0xA9, 0xF9, 0x20, 0x1C, 0x18, 0x30, 0x64, 0x36, 0x31, 0x1C, 0xFC, 0xF7	; 02309834
	.byte 0xA3, 0xF9, 0x20, 0x1C, 0xFD, 0xF7, 0x7C, 0xFE, 0x28, 0x1C, 0x84, 0x30, 0x18, 0x35, 0x29, 0x1C	; 02309844
	.byte 0x00, 0x9A, 0xFD, 0xF7, 0xC1, 0xFE, 0x00, 0x20, 0x01, 0xF0, 0x58, 0xFB, 0x81, 0x20, 0x03, 0xB0	; 02309854
	.byte 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00	; 02309864
	.byte 0xF0, 0x02, 0x00, 0x00, 0x50, 0x01, 0x00, 0x00, 0xE4, 0x05, 0x00, 0x00, 0xC0, 0x03, 0x00, 0x00	; 02309874
	.byte 0xFF, 0xBF, 0xFF, 0xFF, 0x06, 0x05, 0x00, 0x00, 0x0A, 0x05, 0x00, 0x00	; 02309880

; ===== function loc_02309880 =====
loc_02309880:
	push {r4,r5,r6,r7,lr}	; 02309880
	sub sp,#0x4	; 02309882
	add r5,r0,#0x0	; 02309884
	ldr r1,[pool_02309958]	; 02309886
	ldr r2,[r1,#0x0]	; 02309888
	ldr r1,[pool_0230995C]	; 0230988A
	add r1,r2,r1	; 0230988C
	str r1,[sp,#0x0]	; 0230988E
	ldr r1,[pool_02309960]	; 02309890
	add r6,r2,r1	; 02309892
	mov r4,#0x0	; 02309894
	mov r1,#0xdd	; 02309896
	bl loc_023051A4	; 02309898
	add r0,r5,#0x1	; 0230989C
	ldr r1,[pool_02309958]	; 0230989E
	ldr r2,[r1,#0x0]	; 023098A0
	ldr r1,[pool_02309964]	; 023098A2
	ldrh r1,[r2,r1]	; 023098A4
	add r1,#0x8	; 023098A6
	lsl r1,r1,#0x18	; 023098A8
	lsr r1,r1,#0x18	; 023098AA
	bl loc_023051A4	; 023098AC
	add r0,r5,#0x2	; 023098B0
	lsl r1,r4,#0	; 023098B2
	bl loc_023051A4	; 023098B4
	add r0,r5,#0x3	; 023098B8
	mov r1,#0x9	; 023098BA
	bl loc_023051A4	; 023098BC
	add r0,r5,#0x4	; 023098C0
	mov r1,#0xbf	; 023098C2
	bl loc_023051A4	; 023098C4
	add r0,r5,#0x5	; 023098C8
	lsl r1,r4,#0	; 023098CA
	bl loc_023051A4	; 023098CC
	add r0,r5,#0x6	; 023098D0
	ldrh r1,[r6,#0x20]	; 023098D2
	lsl r1,r1,#0x18	; 023098D4
	lsr r1,r1,#0x18	; 023098D6
	bl loc_023051A4	; 023098D8
	add r0,r5,#0x7	; 023098DC
	ldrh r1,[r6,#0x20]	; 023098DE
	asr r1,r1,#0x8	; 023098E0
	lsl r1,r1,#0x18	; 023098E2
	lsr r1,r1,#0x18	; 023098E4
	bl loc_023051A4	; 023098E6
	ldr r0,[pool_02309968]	; 023098EA
	ldrh r6,[r0,#0x0]	; 023098EC
	add r0,r5,#0x0	; 023098EE
	add r0,#0x8	; 023098F0
	lsl r1,r6,#0x18	; 023098F2
	lsr r1,r1,#0x18	; 023098F4
	bl loc_023051A4	; 023098F6
	add r0,r5,#0x0	; 023098FA
	add r0,#0x9	; 023098FC
	lsr r1,r6,#0x8	; 023098FE
	lsl r1,r1,#0x18	; 02309900
	lsr r1,r1,#0x18	; 02309902
	bl loc_023051A4	; 02309904
	add r4,#0xa	; 02309908
	ldr r0,[sp,#0x0]	; 0230990A
	add r0,#0xa0	; 0230990C
	ldrh r0,[r0,#0x0]	; 0230990E
	cmp r0,#0x0	; 02309910
	beq loc_0230994C	; 02309912
	ldr r0,[sp,#0x0]	; 02309914
	add r0,#0x9c	; 02309916
	ldr r6,[r0,#0x0]	; 02309918
	ldr r0,[sp,#0x0]	; 0230991A
	add r0,#0xa2	; 0230991C
	ldrh r1,[r0,#0x0]	; 0230991E
	mov r0,#0x1	; 02309920
	and r1,r0	; 02309922
	cmp r1,#0x0	; 02309924
	beq loc_0230992A	; 02309926
	add r6,r6,#0x1	; 02309928
loc_0230992A:
	mov r7,#0x0	; 0230992A
	b loc_02309942	; 0230992C
loc_0230992E:
	add r0,r6,#0x0	; 0230992E
	bl loc_02305180	; 02309930
	add r1,r0,#0x0	; 02309934
	add r0,r5,r4	; 02309936
	bl loc_023051A4	; 02309938
	add r4,r4,#0x1	; 0230993C
	add r6,r6,#0x1	; 0230993E
	add r7,r7,#0x1	; 02309940
loc_02309942:
	ldr r0,[sp,#0x0]	; 02309942
	add r0,#0xa0	; 02309944
	ldrh r0,[r0,#0x0]	; 02309946
	cmp r7,r0	; 02309948
	bcc loc_0230992E	; 0230994A
loc_0230994C:
	add r0,r4,#0x0	; 0230994C
	add sp,#0x4	; 0230994E
	pop {r4,r5,r6,r7}	; 02309950
	pop {r3}	; 02309952
	bx r3	; 02309954
	.byte 0xC0, 0x46	; 02309958
pool_02309958:
loc_02309958:
	.word FirmwareWlWorkPointerSlot	; 02309958
pool_0230995C:
loc_0230995C:
	.word 0x00000318	; 0230995C
pool_02309960:
loc_02309960:
	.word 0x000002F0	; 02309960
pool_02309964:
loc_02309964:
	.word 0x000003B8	; 02309964
pool_02309968:
loc_02309968:
	.word FirmwareWlAdjustedTimeSlot	; 02309968

; ===== function loc_0230996C =====
loc_0230996C:
	push {r4,lr}	; 0230996C
	add r4,r0,#0x0	; 0230996E
	mov r1,#0x3	; 02309970
	bl loc_023051A4	; 02309972
	add r0,r4,#0x1	; 02309976
	mov r1,#0x1	; 02309978
	bl loc_023051A4	; 0230997A
	add r0,r4,#0x2	; 0230997E
	ldr r1,[pool_02309998]	; 02309980
	ldr r2,[r1,#0x0]	; 02309982
	ldr r1,[pool_0230999C]	; 02309984
	ldrh r1,[r2,r1]	; 02309986
	lsl r1,r1,#0x18	; 02309988
	lsr r1,r1,#0x18	; 0230998A
	bl loc_023051A4	; 0230998C
	mov r0,#0x3	; 02309990
	pop {r4}	; 02309992
	pop {r3}	; 02309994
	bx r3	; 02309996
pool_02309998:
loc_02309998:
	.word FirmwareWlWorkPointerSlot	; 02309998
pool_0230999C:
loc_0230999C:
	.word 0x00000392	; 0230999C

; ===== function loc_023099A0 =====
loc_023099A0:
	push {r4,r5,r6,r7,lr}	; 023099A0
	sub sp,#0x4	; 023099A2
	add r6,r0,#0x0	; 023099A4
	ldr r1,[pool_02309A1C]	; 023099A6
	ldr r2,[r1,#0x0]	; 023099A8
	ldr r1,[pool_02309A20]	; 023099AA
	add r7,r2,r1	; 023099AC
	mov r5,#0x0	; 023099AE
	mov r1,#0x1	; 023099B0
	bl loc_023051A4	; 023099B2
	add r5,r5,#0x2	; 023099B6
	mov r4,#0x0	; 023099B8
loc_023099BA:
	mov r0,#0x1	; 023099BA
	lsl r0,r4	; 023099BC
	add r1,r7,#0x0	; 023099BE
	add r1,#0x62	; 023099C0
	ldrh r1,[r1,#0x0]	; 023099C2
	and r1,r0	; 023099C4
	cmp r1,#0x0	; 023099C6
	beq loc_023099FE	; 023099C8
	add r1,r7,#0x0	; 023099CA
	add r1,#0x60	; 023099CC
	ldrh r1,[r1,#0x0]	; 023099CE
	and r1,r0	; 023099D0
	cmp r1,#0x0	; 023099D2
	beq loc_023099EC	; 023099D4
	add r0,r6,r5	; 023099D6
	lsl r2,r4,#0x1	; 023099D8
	ldr r1,[pool_02309A24]	; 023099DA
	ldrh r2,[r1,r2]	; 023099DC
	mov r1,#0x80	; 023099DE
	orr r2,r1	; 023099E0
	lsl r1,r2,#0x18	; 023099E2
	lsr r1,r1,#0x18	; 023099E4
	bl loc_023051A4	; 023099E6
	b loc_023099FC	; 023099EA
loc_023099EC:
	add r0,r6,r5	; 023099EC
	lsl r2,r4,#0x1	; 023099EE
	ldr r1,[pool_02309A24]	; 023099F0
	ldrh r1,[r1,r2]	; 023099F2
	lsl r1,r1,#0x18	; 023099F4
	lsr r1,r1,#0x18	; 023099F6
	bl loc_023051A4	; 023099F8
loc_023099FC:
	add r5,r5,#0x1	; 023099FC
loc_023099FE:
	add r4,r4,#0x1	; 023099FE
	cmp r4,#0x10	; 02309A00
	bcc loc_023099BA	; 02309A02
	add r0,r6,#0x1	; 02309A04
	sub r1,r5,#0x2	; 02309A06
	lsl r1,r1,#0x18	; 02309A08
	lsr r1,r1,#0x18	; 02309A0A
	bl loc_023051A4	; 02309A0C
	add r0,r5,#0x0	; 02309A10
	add sp,#0x4	; 02309A12
	pop {r4,r5,r6,r7}	; 02309A14
	pop {r3}	; 02309A16
	bx r3	; 02309A18
	.byte 0xC0, 0x46	; 02309A1C
pool_02309A1C:
loc_02309A1C:
	.word FirmwareWlWorkPointerSlot	; 02309A1C
pool_02309A20:
loc_02309A20:
	.word 0x00000318	; 02309A20
pool_02309A24:
loc_02309A24:
	.word P4_Data_0230D628	; 02309A24

; ===== function loc_02309A28 =====
loc_02309A28:
	push {r4,r5,r6,r7,lr}	; 02309A28
	sub sp,#0x4	; 02309A2A
	add r7,r0,#0x0	; 02309A2C
	ldr r1,[pool_02309A78]	; 02309A2E
	ldr r2,[r1,#0x0]	; 02309A30
	ldr r1,[pool_02309A7C]	; 02309A32
	add r1,r2,r1	; 02309A34
	str r1,[sp,#0x0]	; 02309A36
	mov r5,#0x0	; 02309A38
	ldrh r6,[r1,#0x1e]	; 02309A3A
	add r1,r5,#0x0	; 02309A3C
	bl loc_023051A4	; 02309A3E
	add r0,r7,#0x1	; 02309A42
	lsl r1,r6,#0x18	; 02309A44
	lsr r1,r1,#0x18	; 02309A46
	bl loc_023051A4	; 02309A48
	add r5,r5,#0x2	; 02309A4C
	mov r4,#0x0	; 02309A4E
	b loc_02309A68	; 02309A50
loc_02309A52:
	ldr r0,[sp,#0x0]	; 02309A52
	add r0,#0x20	; 02309A54
	add r0,r0,r4	; 02309A56
	bl loc_02305180	; 02309A58
	add r1,r0,#0x0	; 02309A5C
	add r0,r7,r5	; 02309A5E
	bl loc_023051A4	; 02309A60
	add r5,r5,#0x1	; 02309A64
	add r4,r4,#0x1	; 02309A66
loc_02309A68:
	cmp r4,r6	; 02309A68
	bcc loc_02309A52	; 02309A6A
	add r0,r5,#0x0	; 02309A6C
	add sp,#0x4	; 02309A6E
	pop {r4,r5,r6,r7}	; 02309A70
	pop {r3}	; 02309A72
	bx r3	; 02309A74
	.byte 0xC0, 0x46	; 02309A78
pool_02309A78:
loc_02309A78:
	.word FirmwareWlWorkPointerSlot	; 02309A78
pool_02309A7C:
loc_02309A7C:
	.word 0x00000318	; 02309A7C

; ===== function loc_02309A80 =====
loc_02309A80:
	push {r4,r5,lr}	; 02309A80
	sub sp,#0x4	; 02309A82
	add r5,r0,#0x0	; 02309A84
	add r4,r1,#0x0	; 02309A86
	mov r1,#0x0	; 02309A88
	add r0,sp,#0x0	; 02309A8A
	strh r1,[r0,#0x0]	; 02309A8C
	ldrh r0,[r0,#0x0]	; 02309A8E
	add r1,r5,#0x0	; 02309A90
	mov r2,#0x2c	; 02309A92
	bl loc_02309AC8	; 02309A94
	bl loc_023057E4	; 02309A98
	strh r0,[r5,#0x10]	; 02309A9C
	ldr r0,[pool_02309ABC]	; 02309A9E
	ldr r3,[r0,#0x0]	; 02309AA0
	add r5,#0x18	; 02309AA2
	add r0,r5,#0x0	; 02309AA4
	add r1,r4,#0x0	; 02309AA6
	ldr r2,[pool_02309AC0]	; 02309AA8
	add r2,r3,r2	; 02309AAA
	ldr r4,[pool_02309AC4]	; 02309AAC
	add r3,r3,r4	; 02309AAE
	bl loc_02305B34	; 02309AB0
	add sp,#0x4	; 02309AB4
	pop {r4,r5}	; 02309AB6
	pop {r3}	; 02309AB8
	bx r3	; 02309ABA
pool_02309ABC:
loc_02309ABC:
	.word FirmwareWlWorkPointerSlot	; 02309ABC
pool_02309AC0:
loc_02309AC0:
	.word 0x000002F8	; 02309AC0
pool_02309AC4:
loc_02309AC4:
	.word 0x0000037C	; 02309AC4

; ===== function loc_02309AC8 =====
loc_02309AC8:
	bx pc	; 02309AC8
	.byte 0xC0, 0x46	; 02309ACC
.arm

; ===== function loc_02309ACC =====
loc_02309ACC:
	ldr pc,[pool_02309AD0]	; 02309ACC
pool_02309AD0:
loc_02309AD0:
	.word loc_037FF31C	; 02309AD0
.thumb

; ===== function loc_02309AD4 =====
loc_02309AD4:
	ldr r2,[pool_02309B04]	; 02309AD4
	ldr r3,[r2,#0x0]	; 02309AD6
	ldr r1,[pool_02309B08]	; 02309AD8
	ldr r1,[r3,r1]	; 02309ADA
	mov r3,#0x0	; 02309ADC
	strh r3,[r1,#0x0]	; 02309ADE
	strh r3,[r1,#0x2]	; 02309AE0
	strh r3,[r1,#0x4]	; 02309AE2
	mov r3,#0x14	; 02309AE4
	strh r3,[r1,#0xa]	; 02309AE6
	mov r3,#0xa4	; 02309AE8
	strh r3,[r1,#0xc]	; 02309AEA
	ldr r3,[pool_02309B0C]	; 02309AEC
	orr r0,r3	; 02309AEE
	strh r0,[r1,#0xe]	; 02309AF0
	ldr r3,[r2,#0x0]	; 02309AF2
	add r1,#0x10	; 02309AF4
	add r0,r1,#0x0	; 02309AF6
	ldr r1,[pool_02309B10]	; 02309AF8
	add r1,r3,r1	; 02309AFA
	ldr r2,[pool_02309B14]	; 02309AFC
	add r2,r3,r2	; 02309AFE
	ldr r3,[pool_02309B18]	; 02309B00
	bx r3	; 02309B02
pool_02309B04:
loc_02309B04:
	.word FirmwareWlWorkPointerSlot	; 02309B04
pool_02309B08:
loc_02309B08:
	.word 0x00000430	; 02309B08
pool_02309B0C:
loc_02309B0C:
	.word 0x0000C000	; 02309B0C
pool_02309B10:
loc_02309B10:
	.word 0x0000037C	; 02309B10
pool_02309B14:
loc_02309B14:
	.word 0x000002F8	; 02309B14
pool_02309B18:
loc_02309B18:
	.word loc_02305B60 + 1	; 02309B18

; ===== function loc_02309B1C =====
loc_02309B1C:
	push {r4,r5,r6,lr}	; 02309B1C
	add r6,r0,#0x0	; 02309B1E
	add r5,r1,#0x0	; 02309B20
	ldr r0,[pool_02309B68]	; 02309B22
	ldr r1,[r0,#0x0]	; 02309B24
	ldr r0,[pool_02309B6C]	; 02309B26
	add r0,r1,r0	; 02309B28
	mov r1,#0x36	; 02309B2A
	bl loc_02304D60	; 02309B2C
	add r4,r0,#0x0	; 02309B30
	cmp r4,#0x0	; 02309B32
	bne loc_02309B40	; 02309B34
	mov r0,#0x2	; 02309B36
	bl loc_02304F18	; 02309B38
	add r0,r4,#0x0	; 02309B3C
	b loc_02309B60	; 02309B3E
loc_02309B40:
	ldr r0,[pool_02309B70]	; 02309B40
	strh r0,[r4,#0xc]	; 02309B42
	add r4,#0x10	; 02309B44
	add r0,r4,#0x0	; 02309B46
	add r1,r6,#0x0	; 02309B48
	bl loc_02309A80	; 02309B4A
	strh r5,[r4,#0x2c]	; 02309B4E
	mov r0,#0x2	; 02309B50
	strh r0,[r4,#0x6]	; 02309B52
	ldrh r0,[r4,#0x6]	; 02309B54
	add r0,#0x1c	; 02309B56
	strh r0,[r4,#0x12]	; 02309B58
	mov r0,#0xc0	; 02309B5A
	strh r0,[r4,#0x14]	; 02309B5C
	add r0,r4,#0x0	; 02309B5E
loc_02309B60:
	pop {r4,r5,r6}	; 02309B60
	pop {r3}	; 02309B62
	bx r3	; 02309B64
	.byte 0xC0, 0x46	; 02309B68
pool_02309B68:
loc_02309B68:
	.word FirmwareWlWorkPointerSlot	; 02309B68
pool_02309B6C:
loc_02309B6C:
	.word 0x0000015C	; 02309B6C
pool_02309B70:
loc_02309B70:
	.word 0x0000FFFF	; 02309B70

; ===== function loc_02309B74 =====
loc_02309B74:
	push {r4,r5,r6,lr}	; 02309B74
	add r6,r0,#0x0	; 02309B76
	add r5,r1,#0x0	; 02309B78
	ldr r0,[pool_02309BE0]	; 02309B7A
	ldr r1,[r0,#0x0]	; 02309B7C
	ldr r0,[pool_02309BE4]	; 02309B7E
	add r0,r1,r0	; 02309B80
	ldr r1,[pool_02309BE8]	; 02309B82
	add r1,r5,r1	; 02309B84
	bl loc_02304D60	; 02309B86
	add r4,r0,#0x0	; 02309B8A
	cmp r4,#0x0	; 02309B8C
	bne loc_02309B9A	; 02309B8E
	mov r0,#0x2	; 02309B90
	bl loc_02304F18	; 02309B92
	add r0,r4,#0x0	; 02309B96
	b loc_02309BD8	; 02309B98
loc_02309B9A:
	ldr r0,[pool_02309BEC]	; 02309B9A
	strh r0,[r4,#0xc]	; 02309B9C
	add r4,#0x10	; 02309B9E
	add r0,r4,#0x0	; 02309BA0
	add r1,r6,#0x0	; 02309BA2
	bl loc_02309A80	; 02309BA4
	cmp r5,#0x0	; 02309BA8
	beq loc_02309BC8	; 02309BAA
	add r0,r4,#0x0	; 02309BAC
	add r0,#0x32	; 02309BAE
	mov r1,#0x10	; 02309BB0
	bl loc_023051A4	; 02309BB2
	add r0,r4,#0x0	; 02309BB6
	add r0,#0x33	; 02309BB8
	lsl r1,r5,#0x18	; 02309BBA
	lsr r1,r1,#0x18	; 02309BBC
	bl loc_023051A4	; 02309BBE
	add r0,r5,#0x2	; 02309BC2
	lsl r0,r0,#0x10	; 02309BC4
	lsr r5,r0,#0x10	; 02309BC6
loc_02309BC8:
	add r0,r5,#0x6	; 02309BC8
	strh r0,[r4,#0x6]	; 02309BCA
	ldrh r0,[r4,#0x6]	; 02309BCC
	add r0,#0x1c	; 02309BCE
	strh r0,[r4,#0x12]	; 02309BD0
	mov r0,#0xb0	; 02309BD2
	strh r0,[r4,#0x14]	; 02309BD4
	add r0,r4,#0x0	; 02309BD6
loc_02309BD8:
	pop {r4,r5,r6}	; 02309BD8
	pop {r3}	; 02309BDA
	bx r3	; 02309BDC
	.byte 0xC0, 0x46	; 02309BE0
pool_02309BE0:
loc_02309BE0:
	.word FirmwareWlWorkPointerSlot	; 02309BE0
pool_02309BE4:
loc_02309BE4:
	.word 0x0000015C	; 02309BE4
pool_02309BE8:
loc_02309BE8:
	.word 0x0000013A	; 02309BE8
pool_02309BEC:
loc_02309BEC:
	.word 0x0000FFFF	; 02309BEC

; ===== function loc_02309BF0 =====
loc_02309BF0:
	push {r4,r5,r6,lr}	; 02309BF0
	add r6,r0,#0x0	; 02309BF2
	ldr r0,[pool_02309C7C]	; 02309BF4
	ldr r1,[r0,#0x0]	; 02309BF6
	ldr r0,[pool_02309C80]	; 02309BF8
	add r5,r1,r0	; 02309BFA
	ldr r0,[pool_02309C84]	; 02309BFC
	add r0,r1,r0	; 02309BFE
	add r1,r5,#0x0	; 02309C00
	add r1,#0xa0	; 02309C02
	ldrh r1,[r1,#0x0]	; 02309C04
	add r1,#0x78	; 02309C06
	bl loc_02304D60	; 02309C08
	add r4,r0,#0x0	; 02309C0C
	cmp r4,#0x0	; 02309C0E
	bne loc_02309C1C	; 02309C10
	mov r0,#0x2	; 02309C12
	bl loc_02304F18	; 02309C14
	add r0,r4,#0x0	; 02309C18
	b loc_02309C76	; 02309C1A
loc_02309C1C:
	ldr r0,[pool_02309C88]	; 02309C1C
	strh r0,[r4,#0xc]	; 02309C1E
	add r4,#0x10	; 02309C20
	add r0,r4,#0x0	; 02309C22
	add r1,r6,#0x0	; 02309C24
	bl loc_02309A80	; 02309C26
	add r0,r5,#0x0	; 02309C2A
	add r0,#0x6e	; 02309C2C
	ldrh r0,[r0,#0x0]	; 02309C2E
	strh r0,[r4,#0x34]	; 02309C30
	add r5,#0x7c	; 02309C32
	ldrh r0,[r5,#0x0]	; 02309C34
	strh r0,[r4,#0x36]	; 02309C36
	add r0,r4,#0x0	; 02309C38
	add r0,#0x38	; 02309C3A
	bl loc_02309A28	; 02309C3C
	add r5,r0,#0x0	; 02309C40
	add r0,r4,#0x0	; 02309C42
	add r0,#0x38	; 02309C44
	add r0,r0,r5	; 02309C46
	bl loc_023099A0	; 02309C48
	add r5,r5,r0	; 02309C4C
	add r0,r4,#0x0	; 02309C4E
	add r0,#0x38	; 02309C50
	add r0,r0,r5	; 02309C52
	bl loc_0230996C	; 02309C54
	add r5,r5,r0	; 02309C58
	add r0,r4,#0x0	; 02309C5A
	add r0,#0x38	; 02309C5C
	add r0,r0,r5	; 02309C5E
	bl loc_02309880	; 02309C60
	add r0,r5,r0	; 02309C64
	add r0,#0xc	; 02309C66
	strh r0,[r4,#0x6]	; 02309C68
	ldrh r0,[r4,#0x6]	; 02309C6A
	add r0,#0x1c	; 02309C6C
	strh r0,[r4,#0x12]	; 02309C6E
	mov r0,#0x50	; 02309C70
	strh r0,[r4,#0x14]	; 02309C72
	add r0,r4,#0x0	; 02309C74
loc_02309C76:
	pop {r4,r5,r6}	; 02309C76
	pop {r3}	; 02309C78
	bx r3	; 02309C7A
pool_02309C7C:
loc_02309C7C:
	.word FirmwareWlWorkPointerSlot	; 02309C7C
pool_02309C80:
loc_02309C80:
	.word 0x00000318	; 02309C80
pool_02309C84:
loc_02309C84:
	.word 0x0000015C	; 02309C84
pool_02309C88:
loc_02309C88:
	.word 0x0000FFFF	; 02309C88

; ===== function loc_02309C8C =====
loc_02309C8C:
	push {r4,r5,lr}	; 02309C8C
	sub sp,#0x4	; 02309C8E
	add r4,r0,#0x0	; 02309C90
	ldr r0,[pool_02309CE8]	; 02309C92
	ldr r1,[r0,#0x0]	; 02309C94
	ldr r0,[pool_02309CEC]	; 02309C96
	add r0,r1,r0	; 02309C98
	mov r1,#0x5a	; 02309C9A
	bl loc_02304D60	; 02309C9C
	add r5,r0,#0x0	; 02309CA0
	cmp r5,#0x0	; 02309CA2
	bne loc_02309CB0	; 02309CA4
	mov r0,#0x2	; 02309CA6
	bl loc_02304F18	; 02309CA8
	add r0,r5,#0x0	; 02309CAC
	b loc_02309CE0	; 02309CAE
loc_02309CB0:
	ldr r0,[pool_02309CF0]	; 02309CB0
	strh r0,[r5,#0xc]	; 02309CB2
	add r5,#0x10	; 02309CB4
	add r0,r5,#0x0	; 02309CB6
	add r1,r4,#0x0	; 02309CB8
	bl loc_02309A80	; 02309CBA
	add r0,r5,#0x0	; 02309CBE
	add r0,#0x2c	; 02309CC0
	bl loc_02309A28	; 02309CC2
	add r4,r0,#0x0	; 02309CC6
	add r0,r5,#0x0	; 02309CC8
	add r0,#0x2c	; 02309CCA
	add r0,r0,r4	; 02309CCC
	bl loc_023099A0	; 02309CCE
	add r0,r4,r0	; 02309CD2
	strh r0,[r5,#0x6]	; 02309CD4
	add r0,#0x1c	; 02309CD6
	strh r0,[r5,#0x12]	; 02309CD8
	mov r0,#0x40	; 02309CDA
	strh r0,[r5,#0x14]	; 02309CDC
	add r0,r5,#0x0	; 02309CDE
loc_02309CE0:
	add sp,#0x4	; 02309CE0
	pop {r4,r5}	; 02309CE2
	pop {r3}	; 02309CE4
	bx r3	; 02309CE6
pool_02309CE8:
loc_02309CE8:
	.word FirmwareWlWorkPointerSlot	; 02309CE8
pool_02309CEC:
loc_02309CEC:
	.word 0x0000015C	; 02309CEC
pool_02309CF0:
loc_02309CF0:
	.word 0x0000FFFF	; 02309CF0

; ===== function loc_02309CF4 =====
loc_02309CF4:
	push {r4,r5,r6,r7,lr}	; 02309CF4
	sub sp,#0xc	; 02309CF6
	str r0,[sp,#0x0]	; 02309CF8
	add r4,r1,#0x0	; 02309CFA
	add r7,r2,#0x0	; 02309CFC
	ldr r0,[pool_02309DD8]	; 02309CFE
	ldr r1,[r0,#0x0]	; 02309D00
	ldr r0,[pool_02309DDC]	; 02309D02
	add r0,r1,r0	; 02309D04
	mov r1,#0x60	; 02309D06
	bl loc_02304D60	; 02309D08
	add r5,r0,#0x0	; 02309D0C
	cmp r5,#0x0	; 02309D0E
	bne loc_02309D1C	; 02309D10
	mov r0,#0x2	; 02309D12
	bl loc_02304F18	; 02309D14
	add r0,r5,#0x0	; 02309D18
	b loc_02309DD0	; 02309D1A
loc_02309D1C:
	ldr r0,[pool_02309DE0]	; 02309D1C
	strh r0,[r5,#0xc]	; 02309D1E
	add r5,#0x10	; 02309D20
	cmp r4,#0x0	; 02309D22
	bne loc_02309D36	; 02309D24
	ldr r0,[sp,#0x0]	; 02309D26
	bl loc_023072F0	; 02309D28
	add r6,r0,#0x0	; 02309D2C
	cmp r6,#0x0	; 02309D2E
	bne loc_02309D38	; 02309D30
	mov r4,#0x13	; 02309D32
	b loc_02309D38	; 02309D34
loc_02309D36:
	mov r6,#0x0	; 02309D36
loc_02309D38:
	ldr r0,[sp,#0x0]	; 02309D38
	bl loc_02307244	; 02309D3A
	add r1,r0,#0x0	; 02309D3E
	add r0,r5,#0x0	; 02309D40
	bl loc_02309A80	; 02309D42
	ldr r0,[pool_02309DD8]	; 02309D46
	ldr r1,[r0,#0x0]	; 02309D48
	ldr r0,[pool_02309DE4]	; 02309D4A
	ldrh r0,[r1,r0]	; 02309D4C
	strh r0,[r5,#0x2c]	; 02309D4E
	strh r4,[r5,#0x2e]	; 02309D50
	ldr r0,[pool_02309DE8]	; 02309D52
	orr r6,r0	; 02309D54
	strh r6,[r5,#0x30]	; 02309D56
	add r0,r5,#0x0	; 02309D58
	add r0,#0x32	; 02309D5A
	bl loc_023099A0	; 02309D5C
	add r0,r0,#0x6	; 02309D60
	strh r0,[r5,#0x6]	; 02309D62
	ldrh r0,[r5,#0x6]	; 02309D64
	add r0,#0x1c	; 02309D66
	strh r0,[r5,#0x12]	; 02309D68
	mov r0,#0x30	; 02309D6A
	strh r0,[r5,#0x14]	; 02309D6C
	add r1,r5,#0x0	; 02309D6E
	add r1,#0x14	; 02309D70
	ldrh r0,[r5,#0x12]	; 02309D72
	add r4,r1,r0	; 02309D74
	cmp r7,#0x0	; 02309D76
	beq loc_02309DBE	; 02309D78
	add r0,r7,#0x1	; 02309D7A
	bl loc_02305180	; 02309D7C
	str r0,[sp,#0x4]	; 02309D80
	add r0,r7,#0x0	; 02309D82
	bl loc_02305180	; 02309D84
	add r1,r0,#0x0	; 02309D88
	add r0,r4,#0x0	; 02309D8A
	bl loc_023051A4	; 02309D8C
	add r0,r4,#0x1	; 02309D90
	ldr r1,[sp,#0x4]	; 02309D92
	lsl r1,r1,#0x18	; 02309D94
	lsr r1,r1,#0x18	; 02309D96
	bl loc_023051A4	; 02309D98
	add r4,r4,#0x2	; 02309D9C
	mov r6,#0x0	; 02309D9E
	b loc_02309DB6	; 02309DA0
loc_02309DA2:
	add r0,r7,#0x2	; 02309DA2
	add r0,r0,r6	; 02309DA4
	bl loc_02305180	; 02309DA6
	add r1,r0,#0x0	; 02309DAA
	add r0,r4,#0x0	; 02309DAC
	bl loc_023051A4	; 02309DAE
	add r4,r4,#0x1	; 02309DB2
	add r6,r6,#0x1	; 02309DB4
loc_02309DB6:
	ldr r0,[sp,#0x4]	; 02309DB6
	cmp r6,r0	; 02309DB8
	bcc loc_02309DA2	; 02309DBA
	b loc_02309DCE	; 02309DBC
loc_02309DBE:
	add r0,r4,#0x0	; 02309DBE
	mov r1,#0x0	; 02309DC0
	bl loc_023051A4	; 02309DC2
	add r0,r4,#0x1	; 02309DC6
	mov r1,#0x0	; 02309DC8
	bl loc_023051A4	; 02309DCA
loc_02309DCE:
	add r0,r5,#0x0	; 02309DCE
loc_02309DD0:
	add sp,#0xc	; 02309DD0
	pop {r4,r5,r6,r7}	; 02309DD2
	pop {r3}	; 02309DD4
	bx r3	; 02309DD6
pool_02309DD8:
loc_02309DD8:
	.word FirmwareWlWorkPointerSlot	; 02309DD8
pool_02309DDC:
loc_02309DDC:
	.word 0x0000015C	; 02309DDC
pool_02309DE0:
loc_02309DE0:
	.word 0x0000FFFF	; 02309DE0
pool_02309DE4:
loc_02309DE4:
	.word 0x00000394	; 02309DE4
pool_02309DE8:
loc_02309DE8:
	.word 0x0000C000	; 02309DE8

; ===== function loc_02309DEC =====
loc_02309DEC:
	push {r4,r5,r6,r7,lr}	; 02309DEC
	sub sp,#0xc	; 02309DEE
	str r0,[sp,#0x0]	; 02309DF0
	add r4,r1,#0x0	; 02309DF2
	add r7,r2,#0x0	; 02309DF4
	ldr r0,[pool_02309ED8]	; 02309DF6
	ldr r1,[r0,#0x0]	; 02309DF8
	ldr r0,[pool_02309EDC]	; 02309DFA
	add r0,r1,r0	; 02309DFC
	mov r1,#0x60	; 02309DFE
	bl loc_02304D60	; 02309E00
	add r5,r0,#0x0	; 02309E04
	cmp r5,#0x0	; 02309E06
	bne loc_02309E14	; 02309E08
	mov r0,#0x2	; 02309E0A
	bl loc_02304F18	; 02309E0C
	add r0,r5,#0x0	; 02309E10
	b loc_02309ED0	; 02309E12
loc_02309E14:
	ldr r0,[pool_02309EE0]	; 02309E14
	strh r0,[r5,#0xc]	; 02309E16
	add r5,#0x10	; 02309E18
	cmp r4,#0x0	; 02309E1A
	bne loc_02309E2E	; 02309E1C
	ldr r0,[sp,#0x0]	; 02309E1E
	bl loc_023072F0	; 02309E20
	add r6,r0,#0x0	; 02309E24
	cmp r6,#0x0	; 02309E26
	bne loc_02309E30	; 02309E28
	mov r4,#0x13	; 02309E2A
	b loc_02309E30	; 02309E2C
loc_02309E2E:
	mov r6,#0x0	; 02309E2E
loc_02309E30:
	ldr r0,[sp,#0x0]	; 02309E30
	bl loc_02307244	; 02309E32
	add r1,r0,#0x0	; 02309E36
	add r0,r5,#0x0	; 02309E38
	bl loc_02309A80	; 02309E3A
	ldr r0,[pool_02309ED8]	; 02309E3E
	ldr r1,[r0,#0x0]	; 02309E40
	ldr r0,[pool_02309EE4]	; 02309E42
	ldrh r0,[r1,r0]	; 02309E44
	strh r0,[r5,#0x2c]	; 02309E46
	strh r4,[r5,#0x2e]	; 02309E48
	strh r6,[r5,#0x30]	; 02309E4A
	cmp r6,#0x0	; 02309E4C
	beq loc_02309E58	; 02309E4E
	ldrh r1,[r5,#0x30]	; 02309E50
	ldr r0,[pool_02309EE8]	; 02309E52
	orr r1,r0	; 02309E54
	strh r1,[r5,#0x30]	; 02309E56
loc_02309E58:
	add r0,r5,#0x0	; 02309E58
	add r0,#0x32	; 02309E5A
	bl loc_023099A0	; 02309E5C
	add r0,r0,#0x6	; 02309E60
	strh r0,[r5,#0x6]	; 02309E62
	ldrh r0,[r5,#0x6]	; 02309E64
	add r0,#0x1c	; 02309E66
	strh r0,[r5,#0x12]	; 02309E68
	mov r0,#0x10	; 02309E6A
	strh r0,[r5,#0x14]	; 02309E6C
	add r1,r5,#0x0	; 02309E6E
	add r1,#0x14	; 02309E70
	ldrh r0,[r5,#0x12]	; 02309E72
	add r4,r1,r0	; 02309E74
	cmp r7,#0x0	; 02309E76
	beq loc_02309EBE	; 02309E78
	add r0,r7,#0x1	; 02309E7A
	bl loc_02305180	; 02309E7C
	str r0,[sp,#0x4]	; 02309E80
	add r0,r7,#0x0	; 02309E82
	bl loc_02305180	; 02309E84
	add r1,r0,#0x0	; 02309E88
	add r0,r4,#0x0	; 02309E8A
	bl loc_023051A4	; 02309E8C
	add r0,r4,#0x1	; 02309E90
	add r4,r4,#0x2	; 02309E92
	ldr r1,[sp,#0x4]	; 02309E94
	lsl r1,r1,#0x18	; 02309E96
	lsr r1,r1,#0x18	; 02309E98
	bl loc_023051A4	; 02309E9A
	mov r6,#0x0	; 02309E9E
	b loc_02309EB6	; 02309EA0
loc_02309EA2:
	add r0,r7,#0x2	; 02309EA2
	add r0,r0,r6	; 02309EA4
	bl loc_02305180	; 02309EA6
	add r1,r0,#0x0	; 02309EAA
	add r0,r4,#0x0	; 02309EAC
	bl loc_023051A4	; 02309EAE
	add r6,r6,#0x1	; 02309EB2
	add r4,r4,#0x1	; 02309EB4
loc_02309EB6:
	ldr r0,[sp,#0x4]	; 02309EB6
	cmp r6,r0	; 02309EB8
	bcc loc_02309EA2	; 02309EBA
	b loc_02309ECE	; 02309EBC
loc_02309EBE:
	add r0,r4,#0x0	; 02309EBE
	mov r1,#0x0	; 02309EC0
	bl loc_023051A4	; 02309EC2
	add r0,r4,#0x1	; 02309EC6
	mov r1,#0x0	; 02309EC8
	bl loc_023051A4	; 02309ECA
loc_02309ECE:
	add r0,r5,#0x0	; 02309ECE
loc_02309ED0:
	add sp,#0xc	; 02309ED0
	pop {r4,r5,r6,r7}	; 02309ED2
	pop {r3}	; 02309ED4
	bx r3	; 02309ED6
pool_02309ED8:
loc_02309ED8:
	.word FirmwareWlWorkPointerSlot	; 02309ED8
pool_02309EDC:
loc_02309EDC:
	.word 0x0000015C	; 02309EDC
pool_02309EE0:
loc_02309EE0:
	.word 0x0000FFFF	; 02309EE0
pool_02309EE4:
loc_02309EE4:
	.word 0x00000394	; 02309EE4
pool_02309EE8:
loc_02309EE8:
	.word 0x0000C000	; 02309EE8

; ===== function loc_02309EEC =====
loc_02309EEC:
	push {r4,r5,r6,lr}	; 02309EEC
	add r6,r0,#0x0	; 02309EEE
	ldr r0,[pool_02309F5C]	; 02309EF0
	ldr r1,[r0,#0x0]	; 02309EF2
	ldr r0,[pool_02309F60]	; 02309EF4
	add r5,r1,r0	; 02309EF6
	ldr r0,[pool_02309F64]	; 02309EF8
	add r0,r1,r0	; 02309EFA
	mov r1,#0x5e	; 02309EFC
	bl loc_02304D60	; 02309EFE
	add r4,r0,#0x0	; 02309F02
	cmp r4,#0x0	; 02309F04
	bne loc_02309F12	; 02309F06
	mov r0,#0x2	; 02309F08
	bl loc_02304F18	; 02309F0A
	add r0,r4,#0x0	; 02309F0E
	b loc_02309F54	; 02309F10
loc_02309F12:
	ldr r0,[pool_02309F68]	; 02309F12
	strh r0,[r4,#0xc]	; 02309F14
	add r4,#0x10	; 02309F16
	add r0,r4,#0x0	; 02309F18
	add r1,r6,#0x0	; 02309F1A
	bl loc_02309A80	; 02309F1C
	add r0,r5,#0x0	; 02309F20
	add r0,#0x7c	; 02309F22
	ldrh r0,[r0,#0x0]	; 02309F24
	strh r0,[r4,#0x2c]	; 02309F26
	add r5,#0x70	; 02309F28
	ldrh r0,[r5,#0x0]	; 02309F2A
	strh r0,[r4,#0x2e]	; 02309F2C
	add r0,r4,#0x0	; 02309F2E
	add r0,#0x30	; 02309F30
	bl loc_02309A28	; 02309F32
	add r5,r0,#0x0	; 02309F36
	add r0,r4,#0x0	; 02309F38
	add r0,#0x30	; 02309F3A
	add r0,r0,r5	; 02309F3C
	bl loc_023099A0	; 02309F3E
	add r0,r5,r0	; 02309F42
	add r0,r0,#0x4	; 02309F44
	strh r0,[r4,#0x6]	; 02309F46
	ldrh r0,[r4,#0x6]	; 02309F48
	add r0,#0x1c	; 02309F4A
	strh r0,[r4,#0x12]	; 02309F4C
	mov r0,#0x0	; 02309F4E
	strh r0,[r4,#0x14]	; 02309F50
	add r0,r4,#0x0	; 02309F52
loc_02309F54:
	pop {r4,r5,r6}	; 02309F54
	pop {r3}	; 02309F56
	bx r3	; 02309F58
	.byte 0xC0, 0x46	; 02309F5C
pool_02309F5C:
loc_02309F5C:
	.word FirmwareWlWorkPointerSlot	; 02309F5C
pool_02309F60:
loc_02309F60:
	.word 0x00000318	; 02309F60
pool_02309F64:
loc_02309F64:
	.word 0x0000015C	; 02309F64
pool_02309F68:
loc_02309F68:
	.word 0x0000FFFF	; 02309F68

; ===== function loc_02309F6C =====
loc_02309F6C:
	push {r4,r5,r6,lr}	; 02309F6C
	add r6,r0,#0x0	; 02309F6E
	add r5,r1,#0x0	; 02309F70
	ldr r0,[pool_02309FB8]	; 02309F72
	ldr r1,[r0,#0x0]	; 02309F74
	ldr r0,[pool_02309FBC]	; 02309F76
	add r0,r1,r0	; 02309F78
	mov r1,#0x36	; 02309F7A
	bl loc_02304D60	; 02309F7C
	add r4,r0,#0x0	; 02309F80
	cmp r4,#0x0	; 02309F82
	bne loc_02309F90	; 02309F84
	mov r0,#0x2	; 02309F86
	bl loc_02304F18	; 02309F88
	add r0,r4,#0x0	; 02309F8C
	b loc_02309FB0	; 02309F8E
loc_02309F90:
	ldr r0,[pool_02309FC0]	; 02309F90
	strh r0,[r4,#0xc]	; 02309F92
	add r4,#0x10	; 02309F94
	add r0,r4,#0x0	; 02309F96
	add r1,r6,#0x0	; 02309F98
	bl loc_02309A80	; 02309F9A
	strh r5,[r4,#0x2c]	; 02309F9E
	mov r0,#0x2	; 02309FA0
	strh r0,[r4,#0x6]	; 02309FA2
	ldrh r0,[r4,#0x6]	; 02309FA4
	add r0,#0x1c	; 02309FA6
	strh r0,[r4,#0x12]	; 02309FA8
	mov r0,#0xa0	; 02309FAA
	strh r0,[r4,#0x14]	; 02309FAC
	add r0,r4,#0x0	; 02309FAE
loc_02309FB0:
	pop {r4,r5,r6}	; 02309FB0
	pop {r3}	; 02309FB2
	bx r3	; 02309FB4
	.byte 0xC0, 0x46	; 02309FB8
pool_02309FB8:
loc_02309FB8:
	.word FirmwareWlWorkPointerSlot	; 02309FB8
pool_02309FBC:
loc_02309FBC:
	.word 0x0000015C	; 02309FBC
pool_02309FC0:
loc_02309FC0:
	.word 0x0000FFFF	; 02309FC0
	.byte 0x30, 0xB5, 0x81, 0xB0, 0x30, 0x48, 0x01, 0x68, 0x30, 0x48, 0x0D, 0x18, 0x30, 0x48, 0x09, 0x58	; 02309FC4
	.byte 0x24, 0x31, 0x28, 0x1C, 0x96, 0x30, 0x00, 0x88, 0x0C, 0x18, 0x28, 0x1C, 0xA0, 0x30, 0x02, 0x88	; 02309FD4
	.byte 0x00, 0x2A, 0x21, 0xD0, 0x28, 0x1C, 0xA2, 0x30, 0x01, 0x88, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29	; 02309FE4
	.byte 0x12, 0xD0, 0x20, 0x1C, 0x0A, 0x30, 0x40, 0x1E, 0x29, 0x1C, 0x9C, 0x31, 0x09, 0x68, 0x92, 0x1C	; 02309FF4
	.byte 0xFB, 0xF7, 0x0E, 0xF9, 0x20, 0x1C, 0x09, 0x30, 0x22, 0x49, 0x09, 0x88, 0x09, 0x12, 0x09, 0x06	; 0230A004
	.byte 0x09, 0x0E, 0xFB, 0xF7, 0xC5, 0xF8, 0x07, 0xE0, 0x20, 0x1C, 0x0A, 0x30, 0x29, 0x1C, 0x9C, 0x31	; 0230A014
	.byte 0x09, 0x68, 0x52, 0x1C, 0xFB, 0xF7, 0xFC, 0xF8, 0x28, 0x1C, 0x96, 0x30, 0x01, 0x88, 0x26, 0x31	; 0230A024
	.byte 0x28, 0x1C, 0xA0, 0x30, 0x00, 0x88, 0x0A, 0x18, 0x13, 0x48, 0x01, 0x68, 0x14, 0x48, 0x08, 0x58	; 0230A034
	.byte 0x42, 0x81, 0x60, 0x1C, 0x29, 0x1C, 0xA0, 0x31, 0x09, 0x88, 0x08, 0x31, 0x09, 0x06, 0x09, 0x0E	; 0230A044
	.byte 0xFB, 0xF7, 0xA6, 0xF8, 0x0C, 0x48, 0x01, 0x68, 0x0F, 0x48, 0x09, 0x5A, 0x04, 0x20, 0x01, 0x40	; 0230A054
	.byte 0x00, 0x29, 0x0A, 0xD0, 0x0D, 0x34, 0x28, 0x1C, 0xA0, 0x30, 0x00, 0x88, 0x21, 0x18, 0x03, 0x20	; 0230A064
	.byte 0x81, 0x43, 0x0A, 0x48, 0x08, 0x80, 0x0A, 0x48, 0x48, 0x80, 0x00, 0x20, 0xA4, 0x35, 0x28, 0x80	; 0230A074
	.byte 0x01, 0xB0, 0x30, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0x18, 0x03, 0x00, 0x00	; 0230A084
	.byte 0x80, 0x04, 0x00, 0x00, 0xF0, 0xFF, 0x80, 0x03, 0x38, 0x06, 0x00, 0x00, 0xB8, 0xB6, 0x00, 0x00	; 0230A094
	.byte 0x46, 0x1D, 0x00, 0x00	; 0230A0A4
P4_Entry_0230A0A8:
	push {r4,r5,r6,r7,lr}	; 0230A0A8
	sub sp,#0x1c	; 0230A0AA
	ldr r0,[pool_0230A364]	; 0230A0AC
	ldr r1,[r0,#0x0]	; 0230A0AE
	ldr r0,[pool_0230A368]	; 0230A0B0
	ldr r6,[r1,r0]	; 0230A0B2
	ldr r0,[pool_0230A36C]	; 0230A0B4
	add r0,r1,r0	; 0230A0B6
	str r0,[sp,#0x0]	; 0230A0B8
	ldr r0,[pool_0230A370]	; 0230A0BA
	add r5,r1,r0	; 0230A0BC
	mov r0,#0x0	; 0230A0BE
	strh r0,[r6,#0x0]	; 0230A0C0
	strh r0,[r6,#0x2]	; 0230A0C2
	strh r0,[r6,#0x4]	; 0230A0C4
	strh r0,[r6,#0x6]	; 0230A0C6
	bl loc_023057E4	; 0230A0C8
	strh r0,[r6,#0x8]	; 0230A0CC
	mov r0,#0x80	; 0230A0CE
	strh r0,[r6,#0xc]	; 0230A0D0
	mov r0,#0x0	; 0230A0D2
	strh r0,[r6,#0xe]	; 0230A0D4
	add r0,r6,#0x0	; 0230A0D6
	add r0,#0x10	; 0230A0D8
	ldr r1,[pool_0230A374]	; 0230A0DA
	ldr r2,[sp,#0x0]	; 0230A0DC
	add r2,#0x8	; 0230A0DE
	add r3,r2,#0x0	; 0230A0E0
	bl loc_02305B34	; 0230A0E2
	mov r1,#0x0	; 0230A0E6
	strh r1,[r6,#0x22]	; 0230A0E8
	add r7,r6,#0x0	; 0230A0EA
	add r7,#0x24	; 0230A0EC
	str r1,[r6,#0x24]	; 0230A0EE
	str r1,[r7,#0x4]	; 0230A0F0
	add r0,r5,#0x0	; 0230A0F2
	add r0,#0x6e	; 0230A0F4
	ldrh r0,[r0,#0x0]	; 0230A0F6
	strh r0,[r7,#0x8]	; 0230A0F8
	add r0,r5,#0x0	; 0230A0FA
	add r0,#0x7c	; 0230A0FC
	ldrh r0,[r0,#0x0]	; 0230A0FE
	strh r0,[r7,#0xa]	; 0230A100
	add r4,r7,#0x0	; 0230A102
	add r4,#0xc	; 0230A104
	ldr r0,[sp,#0x0]	; 0230A106
	ldrh r0,[r0,#0x1e]	; 0230A108
	lsl r0,r0,#0x1f	; 0230A10A
	lsr r0,r0,#0x1f	; 0230A10C
	cmp r0,#0x0	; 0230A10E
	bne P4_Entry_0230A16E	; 0230A110
	sub r2,r4,r7	; 0230A112
	add r0,r5,#0x0	; 0230A114
	add r0,#0x92	; 0230A116
	strh r2,[r0,#0x0]	; 0230A118
	add r0,r4,#0x0	; 0230A11A
	bl loc_023051A4	; 0230A11C
	add r0,r4,#0x1	; 0230A120
	add r4,r4,#0x2	; 0230A122
	ldrh r1,[r5,#0x1e]	; 0230A124
	lsl r1,r1,#0x18	; 0230A126
	lsr r1,r1,#0x18	; 0230A128
	bl loc_023051A4	; 0230A12A
	mov r0,#0x0	; 0230A12E
	str r0,[sp,#0x8]	; 0230A130
	b P4_Entry_0230A150	; 0230A132
P4_Entry_0230A134:
	add r1,r5,#0x0	; 0230A134
	add r1,#0x20	; 0230A136
	ldr r0,[sp,#0x8]	; 0230A138
	add r0,r1,r0	; 0230A13A
	bl loc_02305180	; 0230A13C
	add r1,r0,#0x0	; 0230A140
	add r0,r4,#0x0	; 0230A142
	bl loc_023051A4	; 0230A144
	add r4,r4,#0x1	; 0230A148
	ldr r0,[sp,#0x8]	; 0230A14A
	add r0,r0,#0x1	; 0230A14C
	str r0,[sp,#0x8]	; 0230A14E
P4_Entry_0230A150:
	ldrh r1,[r5,#0x1e]	; 0230A150
	ldr r0,[sp,#0x8]	; 0230A152
	cmp r0,r1	; 0230A154
	bcc P4_Entry_0230A134	; 0230A156
	mov r0,#0x0	; 0230A158
	mvn r1,r0	; 0230A15A
	ldr r0,[sp,#0x8]	; 0230A15C
	sub r0,r1,r0	; 0230A15E
	add r0,r4,r0	; 0230A160
	ldr r1,[sp,#0x8]	; 0230A162
	lsl r1,r1,#0x18	; 0230A164
	lsr r1,r1,#0x18	; 0230A166
	bl loc_023051A4	; 0230A168
	b P4_Entry_0230A174	; 0230A16C
P4_Entry_0230A16E:
	add r0,r5,#0x0	; 0230A16E
	add r0,#0x92	; 0230A170
	strh r1,[r0,#0x0]	; 0230A172
P4_Entry_0230A174:
	add r0,r4,#0x0	; 0230A174
	bl loc_023099A0	; 0230A176
	add r4,r4,r0	; 0230A17A
	add r0,r4,#0x0	; 0230A17C
	mov r1,#0x3	; 0230A17E
	bl loc_023051A4	; 0230A180
	add r0,r4,#0x1	; 0230A184
	mov r1,#0x1	; 0230A186
	bl loc_023051A4	; 0230A188
	add r0,r4,#0x2	; 0230A18C
	add r1,r5,#0x0	; 0230A18E
	add r1,#0x7a	; 0230A190
	ldrh r1,[r1,#0x0]	; 0230A192
	lsl r1,r1,#0x18	; 0230A194
	lsr r1,r1,#0x18	; 0230A196
	bl loc_023051A4	; 0230A198
	add r0,r4,#0x3	; 0230A19C
	sub r2,r0,r7	; 0230A19E
	add r1,r5,#0x0	; 0230A1A0
	add r1,#0x94	; 0230A1A2
	strh r2,[r1,#0x0]	; 0230A1A4
	add r1,r5,#0x0	; 0230A1A6
	add r1,#0x94	; 0230A1A8
	ldrh r1,[r1,#0x0]	; 0230A1AA
	add r2,r1,#0x2	; 0230A1AC
	ldr r1,[pool_0230A378]	; 0230A1AE
	strh r2,[r1,#0x0]	; 0230A1B0
	mov r1,#0x5	; 0230A1B2
	bl loc_023051A4	; 0230A1B4
	add r0,r4,#0x4	; 0230A1B8
	mov r1,#0x5	; 0230A1BA
	bl loc_023051A4	; 0230A1BC
	add r0,r4,#0x5	; 0230A1C0
	mov r1,#0x0	; 0230A1C2
	bl loc_023051A4	; 0230A1C4
	add r0,r4,#0x6	; 0230A1C8
	add r1,r5,#0x0	; 0230A1CA
	add r1,#0x74	; 0230A1CC
	ldrh r1,[r1,#0x0]	; 0230A1CE
	lsl r1,r1,#0x18	; 0230A1D0
	lsr r1,r1,#0x18	; 0230A1D2
	bl loc_023051A4	; 0230A1D4
	add r0,r4,#0x7	; 0230A1D8
	mov r1,#0x0	; 0230A1DA
	bl loc_023051A4	; 0230A1DC
	add r0,r4,#0x0	; 0230A1E0
	add r0,#0x8	; 0230A1E2
	mov r1,#0x0	; 0230A1E4
	bl loc_023051A4	; 0230A1E6
	add r0,r4,#0x0	; 0230A1EA
	add r0,#0x9	; 0230A1EC
	mov r1,#0x0	; 0230A1EE
	bl loc_023051A4	; 0230A1F0
	add r0,r4,#0x0	; 0230A1F4
	add r0,#0xa	; 0230A1F6
	sub r2,r0,r7	; 0230A1F8
	add r1,r5,#0x0	; 0230A1FA
	add r1,#0x96	; 0230A1FC
	strh r2,[r1,#0x0]	; 0230A1FE
	add r1,r5,#0x0	; 0230A200
	add r1,#0x96	; 0230A202
	ldrh r1,[r1,#0x0]	; 0230A204
	mov r2,#0x1	; 0230A206
	and r1,r2	; 0230A208
	add r2,r5,#0x0	; 0230A20A
	add r2,#0xa2	; 0230A20C
	strh r1,[r2,#0x0]	; 0230A20E
	mov r1,#0xdd	; 0230A210
	bl loc_023051A4	; 0230A212
	add r0,r4,#0x0	; 0230A216
	add r0,#0xb	; 0230A218
	add r1,r5,#0x0	; 0230A21A
	add r1,#0xa0	; 0230A21C
	ldrh r1,[r1,#0x0]	; 0230A21E
	add r1,#0x8	; 0230A220
	lsl r1,r1,#0x18	; 0230A222
	lsr r1,r1,#0x18	; 0230A224
	bl loc_023051A4	; 0230A226
	add r0,r4,#0x0	; 0230A22A
	add r0,#0xc	; 0230A22C
	mov r1,#0x0	; 0230A22E
	bl loc_023051A4	; 0230A230
	add r0,r4,#0x0	; 0230A234
	add r0,#0xd	; 0230A236
	mov r1,#0x9	; 0230A238
	bl loc_023051A4	; 0230A23A
	add r0,r4,#0x0	; 0230A23E
	add r0,#0xe	; 0230A240
	mov r1,#0xbf	; 0230A242
	bl loc_023051A4	; 0230A244
	add r0,r4,#0x0	; 0230A248
	add r0,#0xf	; 0230A24A
	mov r1,#0x0	; 0230A24C
	bl loc_023051A4	; 0230A24E
	ldrh r0,[r5,#0xe]	; 0230A252
	cmp r0,#0x1	; 0230A254
	bne P4_Entry_0230A27E	; 0230A256
	add r0,r4,#0x0	; 0230A258
	add r0,#0x10	; 0230A25A
	ldr r1,[sp,#0x0]	; 0230A25C
	ldrh r1,[r1,#0x20]	; 0230A25E
	lsl r1,r1,#0x18	; 0230A260
	lsr r1,r1,#0x18	; 0230A262
	bl loc_023051A4	; 0230A264
	add r0,r4,#0x0	; 0230A268
	add r0,#0x11	; 0230A26A
	add r4,#0x12	; 0230A26C
	ldr r1,[sp,#0x0]	; 0230A26E
	ldrh r1,[r1,#0x20]	; 0230A270
	asr r1,r1,#0x8	; 0230A272
	lsl r1,r1,#0x18	; 0230A274
	lsr r1,r1,#0x18	; 0230A276
	bl loc_023051A4	; 0230A278
	b P4_Entry_0230A294	; 0230A27C
P4_Entry_0230A27E:
	add r0,r4,#0x0	; 0230A27E
	add r0,#0x10	; 0230A280
	mov r1,#0xff	; 0230A282
	bl loc_023051A4	; 0230A284
	add r0,r4,#0x0	; 0230A288
	add r0,#0x11	; 0230A28A
	add r4,#0x12	; 0230A28C
	mov r1,#0xff	; 0230A28E
	bl loc_023051A4	; 0230A290
P4_Entry_0230A294:
	ldr r0,[pool_0230A37C]	; 0230A294
	ldrh r0,[r0,#0x0]	; 0230A296
	str r0,[sp,#0xc]	; 0230A298
	add r0,r4,#0x0	; 0230A29A
	ldr r1,[sp,#0xc]	; 0230A29C
	lsl r1,r1,#0x18	; 0230A29E
	lsr r1,r1,#0x18	; 0230A2A0
	bl loc_023051A4	; 0230A2A2
	add r0,r4,#0x1	; 0230A2A6
	add r4,r4,#0x2	; 0230A2A8
	ldr r1,[sp,#0xc]	; 0230A2AA
	lsr r1,r1,#0x8	; 0230A2AC
	lsl r1,r1,#0x18	; 0230A2AE
	lsr r1,r1,#0x18	; 0230A2B0
	bl loc_023051A4	; 0230A2B2
	add r0,r5,#0x0	; 0230A2B6
	add r0,#0x9c	; 0230A2B8
	ldr r0,[r0,#0x0]	; 0230A2BA
	str r0,[sp,#0x4]	; 0230A2BC
	mov r0,#0x0	; 0230A2BE
	str r0,[sp,#0x14]	; 0230A2C0
	b P4_Entry_0230A2E0	; 0230A2C2
P4_Entry_0230A2C4:
	ldr r0,[sp,#0x4]	; 0230A2C4
	bl loc_02305180	; 0230A2C6
	add r1,r0,#0x0	; 0230A2CA
	add r0,r4,#0x0	; 0230A2CC
	bl loc_023051A4	; 0230A2CE
	add r4,r4,#0x1	; 0230A2D2
	ldr r0,[sp,#0x4]	; 0230A2D4
	add r0,r0,#0x1	; 0230A2D6
	str r0,[sp,#0x4]	; 0230A2D8
	ldr r0,[sp,#0x14]	; 0230A2DA
	add r0,r0,#0x1	; 0230A2DC
	str r0,[sp,#0x14]	; 0230A2DE
P4_Entry_0230A2E0:
	add r0,r5,#0x0	; 0230A2E0
	add r0,#0xa0	; 0230A2E2
	ldrh r0,[r0,#0x0]	; 0230A2E4
	ldr r1,[sp,#0x14]	; 0230A2E6
	cmp r1,r0	; 0230A2E8
	bcc P4_Entry_0230A2C4	; 0230A2EA
	add r1,r5,#0x0	; 0230A2EC
	add r1,#0xa2	; 0230A2EE
	ldrh r1,[r1,#0x0]	; 0230A2F0
	cmp r1,#0x0	; 0230A2F2
	beq P4_Entry_0230A330	; 0230A2F4
	add r1,r5,#0x0	; 0230A2F6
	add r1,#0x9c	; 0230A2F8
	ldr r1,[r1,#0x0]	; 0230A2FA
	add r0,r1,r0	; 0230A2FC
	sub r0,r0,#0x1	; 0230A2FE
	str r0,[sp,#0x18]	; 0230A300
	mov r0,#0x0	; 0230A302
	str r0,[sp,#0x10]	; 0230A304
	b P4_Entry_0230A324	; 0230A306
P4_Entry_0230A308:
	ldr r0,[sp,#0x18]	; 0230A308
	bl loc_02305180	; 0230A30A
	add r1,r0,#0x0	; 0230A30E
	ldr r0,[sp,#0x18]	; 0230A310
	add r0,r0,#0x1	; 0230A312
	bl loc_023051A4	; 0230A314
	ldr r0,[sp,#0x10]	; 0230A318
	add r0,r0,#0x1	; 0230A31A
	str r0,[sp,#0x10]	; 0230A31C
	ldr r0,[sp,#0x18]	; 0230A31E
	sub r0,r0,#0x1	; 0230A320
	str r0,[sp,#0x18]	; 0230A322
P4_Entry_0230A324:
	add r0,r5,#0x0	; 0230A324
	add r0,#0xa0	; 0230A326
	ldrh r1,[r0,#0x0]	; 0230A328
	ldr r0,[sp,#0x10]	; 0230A32A
	cmp r0,r1	; 0230A32C
	bcc P4_Entry_0230A308	; 0230A32E
P4_Entry_0230A330:
	ldr r0,[pool_0230A364]	; 0230A330
	ldr r1,[r0,#0x0]	; 0230A332
	ldr r0,[pool_0230A380]	; 0230A334
	ldrh r1,[r1,r0]	; 0230A336
	mov r0,#0x4	; 0230A338
	and r1,r0	; 0230A33A
	cmp r1,#0x0	; 0230A33C
	beq P4_Entry_0230A34E	; 0230A33E
	add r1,r4,#0x3	; 0230A340
	mov r0,#0x3	; 0230A342
	bic r1,r0	; 0230A344
	ldr r0,[pool_0230A384]	; 0230A346
	strh r0,[r1,#0x0]	; 0230A348
	ldr r0,[pool_0230A388]	; 0230A34A
	strh r0,[r1,#0x2]	; 0230A34C
P4_Entry_0230A34E:
	mov r0,#0x0	; 0230A34E
	add r5,#0xa4	; 0230A350
	strh r0,[r5,#0x0]	; 0230A352
	add r4,#0x1c	; 0230A354
	sub r0,r4,r7	; 0230A356
	strh r0,[r6,#0xa]	; 0230A358
	add sp,#0x1c	; 0230A35A
	pop {r4,r5,r6,r7}	; 0230A35C
	pop {r3}	; 0230A35E
	bx r3	; 0230A360
	.byte 0xC0, 0x46	; 0230A362
pool_0230A364:
	.word FirmwareWlWorkPointerSlot	; 0230A364
pool_0230A368:
	.word 0x00000480	; 0230A368
pool_0230A36C:
	.word 0x000002F0	; 0230A36C
pool_0230A370:
	.word 0x00000318	; 0230A370
pool_0230A374:
	.word 0x0230D608	; 0230A374
pool_0230A378:
	.word REG_WIFI_TXBUF_TIM	; 0230A378
pool_0230A37C:
	.word FirmwareWlAdjustedTimeSlot	; 0230A37C
pool_0230A380:
	.word 0x00000638	; 0230A380
pool_0230A384:
	.word 0x0000B6B8	; 0230A384
pool_0230A388:
	.word 0x00001D46	; 0230A388
P4_Entry_0230A38C:
	ldr r0,[pool_0230A39C]	; 0230A38C
	ldr r2,[r0,#0x0]	; 0230A38E
	mov r1,#0x0	; 0230A390
	ldr r0,[pool_0230A3A0]	; 0230A392
	strh r1,[r0,#0x0]	; 0230A394
	ldr r0,[pool_0230A3A4]	; 0230A396
	strh r1,[r2,r0]	; 0230A398
	bx lr	; 0230A39A
pool_0230A39C:
	.word FirmwareWlWorkPointerSlot	; 0230A39C
pool_0230A3A0:
	.word REG_WIFI_TXBUF_BEACON	; 0230A3A0
pool_0230A3A4:
	.word 0x00000478	; 0230A3A4
P4_Entry_0230A3A8:
	ldr r0,[pool_0230A3C8]	; 0230A3A8
	ldr r1,[r0,#0x0]	; 0230A3AA
	ldr r0,[pool_0230A3CC]	; 0230A3AC
	add r1,r1,r0	; 0230A3AE
	mov r0,#0x1	; 0230A3B0
	strh r0,[r1,#0x0]	; 0230A3B2
	ldr r1,[r1,#0x8]	; 0230A3B4
	ldr r0,[pool_0230A3D0]	; 0230A3B6
	and r1,r0	; 0230A3B8
	lsr r1,r1,#0x1	; 0230A3BA
	ldr r0,[pool_0230A3D4]	; 0230A3BC
	orr r1,r0	; 0230A3BE
	ldr r0,[pool_0230A3D8]	; 0230A3C0
	strh r1,[r0,#0x0]	; 0230A3C2
	bx lr	; 0230A3C4
	.byte 0xC0, 0x46	; 0230A3C6
pool_0230A3C8:
	.word FirmwareWlWorkPointerSlot	; 0230A3C8
pool_0230A3CC:
	.word 0x00000478	; 0230A3CC
pool_0230A3D0:
	.word 0x00003FFF	; 0230A3D0
pool_0230A3D4:
	.word 0x00008000	; 0230A3D4
pool_0230A3D8:
	.word REG_WIFI_TXBUF_BEACON	; 0230A3D8

; ===== function loc_0230A3DC =====
loc_0230A3DC:
	push {r4,lr}	; 0230A3DC
	ldr r0,[pool_0230A428]	; 0230A3DE
	ldr r1,[r0,#0x0]	; 0230A3E0
	ldr r0,[pool_0230A42C]	; 0230A3E2
	add r4,r1,r0	; 0230A3E4
	ldrh r0,[r4,#0x2]	; 0230A3E6
	add r0,r0,#0x1	; 0230A3E8
	strh r0,[r4,#0x2]	; 0230A3EA
	ldrh r0,[r4,#0x0]	; 0230A3EC
	cmp r0,#0x0	; 0230A3EE
	beq loc_0230A3FA	; 0230A3F0
	mov r1,#0x0	; 0230A3F2
	ldr r0,[r4,#0x8]	; 0230A3F4
	strh r1,[r0,#0x4]	; 0230A3F6
	b loc_0230A422	; 0230A3F8
loc_0230A3FA:
	mov r0,#0x1	; 0230A3FA
	strh r0,[r4,#0x0]	; 0230A3FC
	mov r1,#0x0	; 0230A3FE
	ldr r0,[r4,#0x8]	; 0230A400
	strh r1,[r0,#0x0]	; 0230A402
	ldr r0,[r4,#0x8]	; 0230A404
	strh r1,[r0,#0x4]	; 0230A406
	bl loc_023057E4	; 0230A408
	ldr r1,[r4,#0x8]	; 0230A40C
	strh r0,[r1,#0x8]	; 0230A40E
	ldr r1,[r4,#0x8]	; 0230A410
	ldr r0,[pool_0230A430]	; 0230A412
	and r1,r0	; 0230A414
	lsl r0,r1,#0xf	; 0230A416
	lsr r1,r0,#0x10	; 0230A418
	ldr r0,[pool_0230A434]	; 0230A41A
	orr r1,r0	; 0230A41C
	ldr r0,[pool_0230A438]	; 0230A41E
	strh r1,[r0,#0x0]	; 0230A420
loc_0230A422:
	pop {r4}	; 0230A422
	pop {r3}	; 0230A424
	bx r3	; 0230A426
pool_0230A428:
loc_0230A428:
	.word FirmwareWlWorkPointerSlot	; 0230A428
pool_0230A42C:
loc_0230A42C:
	.word 0x00000428	; 0230A42C
pool_0230A430:
loc_0230A430:
	.word 0x00003FFF	; 0230A430
pool_0230A434:
loc_0230A434:
	.word 0x00008000	; 0230A434
pool_0230A438:
loc_0230A438:
	.word REG_WIFI_TXBUF_LOC3	; 0230A438

; ===== function loc_0230A43C =====
loc_0230A43C:
	push {r4,lr}	; 0230A43C
	add r4,r0,#0x0	; 0230A43E
	add r0,#0x18	; 0230A440
	bl loc_023076B4	; 0230A442
	strh r0,[r4,#0x2]	; 0230A446
	ldrh r0,[r4,#0x2]	; 0230A448
	cmp r0,#0xff	; 0230A44A
	bne loc_0230A452	; 0230A44C
	mov r0,#0x0	; 0230A44E
	strh r0,[r4,#0x2]	; 0230A450
loc_0230A452:
	ldr r0,[pool_0230A494]	; 0230A452
	ldr r1,[r0,#0x0]	; 0230A454
	ldr r0,[pool_0230A498]	; 0230A456
	ldr r0,[r1,r0]	; 0230A458
	strh r0,[r4,#0x4]	; 0230A45A
	ldrh r1,[r4,#0x14]	; 0230A45C
	ldr r0,[pool_0230A49C]	; 0230A45E
	and r1,r0	; 0230A460
	cmp r1,#0x0	; 0230A462
	beq loc_0230A46C	; 0230A464
	ldrh r0,[r4,#0x12]	; 0230A466
	add r0,#0x8	; 0230A468
	strh r0,[r4,#0x12]	; 0230A46A
loc_0230A46C:
	add r0,r4,#0x0	; 0230A46C
	bl loc_02307534	; 0230A46E
	ldr r0,[pool_0230A494]	; 0230A472
	ldr r2,[r0,#0x0]	; 0230A474
	ldr r0,[pool_0230A4A0]	; 0230A476
	add r0,r2,r0	; 0230A478
	ldr r1,[pool_0230A4A4]	; 0230A47A
	add r1,r2,r1	; 0230A47C
	sub r4,#0x10	; 0230A47E
	add r2,r4,#0x0	; 0230A480
	bl loc_023075CC	; 0230A482
	mov r0,#0x1	; 0230A486
	bl loc_0230AF00	; 0230A488
	pop {r4}	; 0230A48C
	pop {r3}	; 0230A48E
	bx r3	; 0230A490
	.byte 0xC0, 0x46	; 0230A494
pool_0230A494:
loc_0230A494:
	.word FirmwareWlWorkPointerSlot	; 0230A494
pool_0230A498:
loc_0230A498:
	.word 0x000003C0	; 0230A498
pool_0230A49C:
loc_0230A49C:
	.word 0x00004000	; 0230A49C
pool_0230A4A0:
loc_0230A4A0:
	.word 0x0000015C	; 0230A4A0
pool_0230A4A4:
loc_0230A4A4:
	.word 0x00000174	; 0230A4A4

; ===== function loc_0230A4A8 =====
loc_0230A4A8:
	push {r4,r5,r6,r7,lr}	; 0230A4A8
	sub sp,#0xc	; 0230A4AA
	add r7,r0,#0x0	; 0230A4AC
	str r1,[sp,#0x0]	; 0230A4AE
	mov r0,#0xc	; 0230A4B0
	add r4,r7,#0x0	; 0230A4B2
	mul r4,r0	; 0230A4B4
	ldr r0,[pool_0230A50C]	; 0230A4B6
	ldr r0,[r0,#0x0]	; 0230A4B8
	add r1,r0,r4	; 0230A4BA
	ldr r0,[pool_0230A510]	; 0230A4BC
	ldr r5,[r1,r0]	; 0230A4BE
	mov r0,#0x0	; 0230A4C0
	mvn r0,r0	; 0230A4C2
	cmp r5,r0	; 0230A4C4
	beq loc_0230A504	; 0230A4C6
loc_0230A4C8:
	add r0,r5,#0x0	; 0230A4C8
	bl loc_02304C2C	; 0230A4CA
	str r0,[sp,#0x4]	; 0230A4CE
	add r6,r5,#0x0	; 0230A4D0
	add r6,#0x10	; 0230A4D2
	cmp r7,#0x2	; 0230A4D4
	beq loc_0230A4DE	; 0230A4D6
	add r0,r6,#0x0	; 0230A4D8
	bl loc_023074E8	; 0230A4DA
loc_0230A4DE:
	mov r0,#0x2	; 0230A4DE
	strh r0,[r6,#0x8]	; 0230A4E0
	ldr r0,[sp,#0x0]	; 0230A4E2
	cmp r0,#0x0	; 0230A4E4
	beq loc_0230A4F8	; 0230A4E6
	ldr r0,[pool_0230A50C]	; 0230A4E8
	ldr r1,[r0,#0x0]	; 0230A4EA
	ldr r0,[pool_0230A510]	; 0230A4EC
	add r0,r1,r0	; 0230A4EE
	add r0,r0,r4	; 0230A4F0
	add r1,r5,#0x0	; 0230A4F2
	bl loc_02309128	; 0230A4F4
loc_0230A4F8:
	ldr r5,[sp,#0x4]	; 0230A4F8
	mov r0,#0x0	; 0230A4FA
	mvn r1,r0	; 0230A4FC
	lsl r0,r5,#0	; 0230A4FE
	cmp r0,r1	; 0230A500
	bne loc_0230A4C8	; 0230A502
loc_0230A504:
	add sp,#0xc	; 0230A504
	pop {r4,r5,r6,r7}	; 0230A506
	pop {r3}	; 0230A508
	bx r3	; 0230A50A
pool_0230A50C:
loc_0230A50C:
	.word FirmwareWlWorkPointerSlot	; 0230A50C
pool_0230A510:
loc_0230A510:
	.word 0x00000168	; 0230A510
P4_Entry_0230A514:
	push {r4,lr}	; 0230A514
	ldr r0,[pool_0230A5A4]	; 0230A516
	ldr r1,[r0,#0x0]	; 0230A518
	ldr r0,[pool_0230A5A8]	; 0230A51A
	add r4,r1,r0	; 0230A51C
	ldr r0,[pool_0230A5AC]	; 0230A51E
	ldrh r0,[r1,r0]	; 0230A520
	cmp r0,#0x1	; 0230A522
	beq P4_Entry_0230A530	; 0230A524
	cmp r0,#0x2	; 0230A526
	beq P4_Entry_0230A56A	; 0230A528
	cmp r0,#0x3	; 0230A52A
	beq P4_Entry_0230A56A	; 0230A52C
	b P4_Entry_0230A584	; 0230A52E
P4_Entry_0230A530:
	mov r0,#0x0	; 0230A530
	mov r1,#0x1	; 0230A532
	bl loc_0230A4A8	; 0230A534
	mov r0,#0x1	; 0230A538
	mov r1,#0x0	; 0230A53A
	bl loc_0230A4A8	; 0230A53C
	mov r0,#0x2	; 0230A540
	mov r1,#0x1	; 0230A542
	bl loc_0230A4A8	; 0230A544
	ldrh r0,[r4,#0x3c]	; 0230A548
	cmp r0,#0x0	; 0230A54A
	beq P4_Entry_0230A59C	; 0230A54C
	mov r0,#0x0	; 0230A54E
	strh r0,[r4,#0x3c]	; 0230A550
	ldrh r0,[r4,#0x3e]	; 0230A552
	sub r0,r0,#0x1	; 0230A554
	strh r0,[r4,#0x3e]	; 0230A556
	ldr r0,[pool_0230A5A4]	; 0230A558
	ldr r1,[r0,#0x0]	; 0230A55A
	ldr r0,[pool_0230A5B0]	; 0230A55C
	add r0,r1,r0	; 0230A55E
	add r4,#0x90	; 0230A560
	ldr r1,[r4,#0x0]	; 0230A562
	bl loc_02304C3C	; 0230A564
	b P4_Entry_0230A59C	; 0230A568
P4_Entry_0230A56A:
	mov r0,#0x0	; 0230A56A
	mov r1,#0x1	; 0230A56C
	bl loc_0230A4A8	; 0230A56E
	mov r0,#0x1	; 0230A572
	mov r1,#0x0	; 0230A574
	bl loc_0230A4A8	; 0230A576
	mov r0,#0x2	; 0230A57A
	mov r1,#0x0	; 0230A57C
	bl loc_0230A4A8	; 0230A57E
	b P4_Entry_0230A59C	; 0230A582
P4_Entry_0230A584:
	mov r0,#0x0	; 0230A584
	add r1,r0,#0x0	; 0230A586
	bl loc_0230A4A8	; 0230A588
	mov r0,#0x1	; 0230A58C
	mov r1,#0x0	; 0230A58E
	bl loc_0230A4A8	; 0230A590
	mov r0,#0x2	; 0230A594
	mov r1,#0x0	; 0230A596
	bl loc_0230A4A8	; 0230A598
P4_Entry_0230A59C:
	pop {r4}	; 0230A59C
	pop {r3}	; 0230A59E
	bx r3	; 0230A5A0
	.byte 0xC0, 0x46	; 0230A5A2
pool_0230A5A4:
	.word FirmwareWlWorkPointerSlot	; 0230A5A4
pool_0230A5A8:
	.word 0x00000400	; 0230A5A8
pool_0230A5AC:
	.word 0x00000324	; 0230A5AC
pool_0230A5B0:
	.word 0x0000015C	; 0230A5B0
	.byte 0x70, 0xB5, 0x01, 0x88, 0x01, 0x25, 0x29, 0x40, 0x00, 0x29, 0x0B, 0xD0, 0x0A, 0x4C, 0x0B, 0x4E	; 0230A5B4
	.byte 0x03, 0xE0, 0x28, 0x1C, 0x00, 0xF0, 0x14, 0xF8, 0x6D, 0x1C, 0x20, 0x68, 0x80, 0x5B, 0x85, 0x42	; 0230A5C4
	.byte 0xF7, 0xD3, 0x05, 0xE0, 0xFD, 0xF7, 0x6C, 0xF8, 0xFF, 0x28, 0x01, 0xD0, 0x00, 0xF0, 0x08, 0xF8	; 0230A5D4
	.byte 0x70, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0xF6, 0x02, 0x00, 0x00	; 0230A5E4

; ===== function loc_0230A5F4 =====
loc_0230A5F4:
	push {r4,r5,r6,r7,lr}	; 0230A5F4
	sub sp,#0x14	; 0230A5F6
	str r0,[sp,#0x0]	; 0230A5F8
	mov r6,#0x0	; 0230A5FA
	bl loc_023071E4	; 0230A5FC
	cmp r0,#0x0	; 0230A600
	beq loc_0230A682	; 0230A602
	lsl r4,r6,#0	; 0230A604
	str r4,[sp,#0x10]	; 0230A606
	str r4,[sp,#0xc]	; 0230A608
loc_0230A60A:
	add r1,r4,#0x0	; 0230A60A
	str r1,[sp,#0x8]	; 0230A60C
	mov r0,#0xc	; 0230A60E
	mul r1,r0	; 0230A610
	str r1,[sp,#0x8]	; 0230A612
	ldr r0,[pool_0230A68C]	; 0230A614
	ldr r1,[r0,#0x0]	; 0230A616
	ldr r0,[sp,#0x8]	; 0230A618
	add r1,r1,r0	; 0230A61A
	ldr r0,[pool_0230A690]	; 0230A61C
	ldr r5,[r1,r0]	; 0230A61E
	ldr r0,[sp,#0xc]	; 0230A620
	mvn r0,r0	; 0230A622
	cmp r5,r0	; 0230A624
	beq loc_0230A67C	; 0230A626
	add r7,r4,#0x0	; 0230A628
	mov r0,#0x14	; 0230A62A
	mul r7,r0	; 0230A62C
loc_0230A62E:
	add r0,r5,#0x0	; 0230A62E
	bl loc_02304C2C	; 0230A630
	str r0,[sp,#0x4]	; 0230A634
	add r0,r5,#0x0	; 0230A636
	add r0,#0x10	; 0230A638
	ldrh r2,[r0,#0x2]	; 0230A63A
	ldr r1,[sp,#0x0]	; 0230A63C
	cmp r2,r1	; 0230A63E
	bne loc_0230A670	; 0230A640
	ldr r1,[pool_0230A68C]	; 0230A642
	ldr r1,[r1,#0x0]	; 0230A644
	add r2,r7,r1	; 0230A646
	ldr r1,[pool_0230A694]	; 0230A648
	ldr r1,[r2,r1]	; 0230A64A
	cmp r0,r1	; 0230A64C
	beq loc_0230A670	; 0230A64E
	mov r1,#0x2	; 0230A650
	strh r1,[r0,#0x8]	; 0230A652
	bl loc_023074E8	; 0230A654
	ldr r0,[pool_0230A68C]	; 0230A658
	ldr r1,[r0,#0x0]	; 0230A65A
	ldr r0,[pool_0230A690]	; 0230A65C
	add r1,r1,r0	; 0230A65E
	ldr r0,[sp,#0x8]	; 0230A660
	add r0,r1,r0	; 0230A662
	add r1,r5,#0x0	; 0230A664
	bl loc_02309128	; 0230A666
	cmp r6,#0x0	; 0230A66A
	bne loc_0230A670	; 0230A66C
	mov r6,#0x1	; 0230A66E
loc_0230A670:
	ldr r5,[sp,#0x4]	; 0230A670
	ldr r0,[sp,#0x10]	; 0230A672
	mvn r1,r0	; 0230A674
	lsl r0,r5,#0	; 0230A676
	cmp r0,r1	; 0230A678
	bne loc_0230A62E	; 0230A67A
loc_0230A67C:
	add r4,r4,#0x2	; 0230A67C
	cmp r4,#0x3	; 0230A67E
	bcc loc_0230A60A	; 0230A680
loc_0230A682:
	add sp,#0x14	; 0230A682
	pop {r4,r5,r6,r7}	; 0230A684
	pop {r3}	; 0230A686
	bx r3	; 0230A688
	.byte 0xC0, 0x46	; 0230A68C
pool_0230A68C:
loc_0230A68C:
	.word FirmwareWlWorkPointerSlot	; 0230A68C
pool_0230A690:
loc_0230A690:
	.word 0x00000168	; 0230A690
pool_0230A694:
loc_0230A694:
	.word 0x0000040C	; 0230A694

; ===== function loc_0230A698 =====
loc_0230A698:
	push {r4,r5,r6,r7,lr}	; 0230A698
	sub sp,#0x4	; 0230A69A
	add r6,r0,#0x0	; 0230A69C
	ldr r0,[pool_0230A6EC]	; 0230A69E
	ldr r1,[r0,#0x0]	; 0230A6A0
	ldr r0,[pool_0230A6F0]	; 0230A6A2
	add r4,r1,r0	; 0230A6A4
	mov r0,#0x14	; 0230A6A6
	add r7,r6,#0x0	; 0230A6A8
	mul r7,r0	; 0230A6AA
	add r5,r4,r7	; 0230A6AC
	ldr r0,[pool_0230A6F4]	; 0230A6AE
	bl loc_02304EE8	; 0230A6B0
	lsl r2,r6,#0x1	; 0230A6B4
	ldr r1,[pool_0230A6F8]	; 0230A6B6
	ldrh r2,[r1,r2]	; 0230A6B8
	ldr r1,[pool_0230A6FC]	; 0230A6BA
	strh r2,[r1,#0x0]	; 0230A6BC
	ldrh r1,[r4,r7]	; 0230A6BE
	cmp r1,#0x0	; 0230A6C0
	beq loc_0230A6DE	; 0230A6C2
	ldr r3,[r5,#0xc]	; 0230A6C4
	ldrh r2,[r3,#0x14]	; 0230A6C6
	ldr r1,[pool_0230A700]	; 0230A6C8
	and r2,r1	; 0230A6CA
	cmp r2,#0x0	; 0230A6CC
	bne loc_0230A6D6	; 0230A6CE
	ldr r1,[r5,#0x8]	; 0230A6D0
	ldrh r1,[r1,#0x4]	; 0230A6D2
	strh r1,[r3,#0xc]	; 0230A6D4
loc_0230A6D6:
	ldr r1,[r5,#0x8]	; 0230A6D6
	ldrh r2,[r1,#0x22]	; 0230A6D8
	ldr r1,[r5,#0xc]	; 0230A6DA
	strh r2,[r1,#0x2a]	; 0230A6DC
loc_0230A6DE:
	bl loc_02304EF8	; 0230A6DE
	add sp,#0x4	; 0230A6E2
	pop {r4,r5,r6,r7}	; 0230A6E4
	pop {r3}	; 0230A6E6
	bx r3	; 0230A6E8
	.byte 0xC0, 0x46	; 0230A6EC
pool_0230A6EC:
loc_0230A6EC:
	.word FirmwareWlWorkPointerSlot	; 0230A6EC
pool_0230A6F0:
loc_0230A6F0:
	.word 0x00000400	; 0230A6F0
pool_0230A6F4:
loc_0230A6F4:
	.word 0x01000000	; 0230A6F4
pool_0230A6F8:
loc_0230A6F8:
	.word P4_Data_0230DB34	; 0230A6F8
pool_0230A6FC:
loc_0230A6FC:
	.word REG_WIFI_TXBUF_RESET	; 0230A6FC
pool_0230A700:
loc_0230A700:
	.word 0x00004000	; 0230A700

; ===== function loc_0230A704 =====
loc_0230A704:
	push {lr}	; 0230A704
	sub sp,#0x4	; 0230A706
	ldr r1,[pool_0230A740]	; 0230A708
	ldr r2,[r1,#0x0]	; 0230A70A
	ldr r1,[pool_0230A744]	; 0230A70C
	add r3,r2,r1	; 0230A70E
	mov r1,#0x14	; 0230A710
	mul r0,r1	; 0230A712
	add r2,r3,r0	; 0230A714
	ldrh r0,[r3,r0]	; 0230A716
	cmp r0,#0x0	; 0230A718
	beq loc_0230A73A	; 0230A71A
	ldr r0,[r2,#0x8]	; 0230A71C
	ldrh r1,[r0,#0x0]	; 0230A71E
	cmp r1,#0x0	; 0230A720
	bne loc_0230A72C	; 0230A722
	mov r1,#0x2	; 0230A724
	ldr r0,[r2,#0xc]	; 0230A726
	strh r1,[r0,#0x8]	; 0230A728
	b loc_0230A730	; 0230A72A
loc_0230A72C:
	ldr r0,[r2,#0xc]	; 0230A72C
	strh r1,[r0,#0x8]	; 0230A72E
loc_0230A730:
	ldr r0,[r2,#0xc]	; 0230A730
	mov r1,#0x0	; 0230A732
	ldr r2,[r2,#0x10]	; 0230A734
	bl loc_0230A748	; 0230A736
loc_0230A73A:
	add sp,#0x4	; 0230A73A
	pop {r3}	; 0230A73C
	bx r3	; 0230A73E
pool_0230A740:
loc_0230A740:
	.word FirmwareWlWorkPointerSlot	; 0230A740
pool_0230A744:
loc_0230A744:
	.word 0x00000400	; 0230A744

; ===== function loc_0230A748 =====
loc_0230A748:
	bx pc	; 0230A748
	.byte 0xC0, 0x46	; 0230A74C
.arm

; ===== function loc_0230A74C =====
loc_0230A74C:
	ldr r12,[pool_0230A754]	; 0230A74C
	bx r12	; 0230A750
pool_0230A754:
loc_0230A754:
	.word loc_0380508C + 1	; 0230A754
.thumb

; ===== function loc_0230A758 =====
loc_0230A758:
	push {r4,r5,lr}	; 0230A758
	sub sp,#0x4	; 0230A75A
	ldr r0,[pool_0230A7BC]	; 0230A75C
	ldr r1,[r0,#0x0]	; 0230A75E
	ldr r0,[pool_0230A7C0]	; 0230A760
	add r5,r1,r0	; 0230A762
	ldr r0,[pool_0230A7C4]	; 0230A764
	bl loc_02304EE8	; 0230A766
	add r4,r0,#0x0	; 0230A76A
	ldr r0,[pool_0230A7BC]	; 0230A76C
	ldr r1,[r0,#0x0]	; 0230A76E
	ldr r0,[pool_0230A7C8]	; 0230A770
	ldrh r0,[r1,r0]	; 0230A772
	cmp r0,#0x1	; 0230A774
	bne loc_0230A794	; 0230A776
	mov r1,#0x9	; 0230A778
	ldr r0,[pool_0230A7CC]	; 0230A77A
	strh r1,[r0,#0x0]	; 0230A77C
	ldrh r0,[r5,#0x28]	; 0230A77E
	cmp r0,#0x0	; 0230A780
	beq loc_0230A78A	; 0230A782
	mov r0,#0x2	; 0230A784
	bl loc_0230A704	; 0230A786
loc_0230A78A:
	mov r0,#0x2	; 0230A78A
	mov r1,#0x1	; 0230A78C
	bl loc_0230A4A8	; 0230A78E
	b loc_0230A79A	; 0230A792
loc_0230A794:
	mov r1,#0x1	; 0230A794
	ldr r0,[pool_0230A7CC]	; 0230A796
	strh r1,[r0,#0x0]	; 0230A798
loc_0230A79A:
	ldrh r0,[r5,#0x0]	; 0230A79A
	cmp r0,#0x0	; 0230A79C
	beq loc_0230A7A6	; 0230A79E
	mov r0,#0x0	; 0230A7A0
	bl loc_0230A704	; 0230A7A2
loc_0230A7A6:
	mov r0,#0x0	; 0230A7A6
	mov r1,#0x1	; 0230A7A8
	bl loc_0230A4A8	; 0230A7AA
	add r0,r4,#0x0	; 0230A7AE
	bl loc_02304EF8	; 0230A7B0
	add sp,#0x4	; 0230A7B4
	pop {r4,r5}	; 0230A7B6
	pop {r3}	; 0230A7B8
	bx r3	; 0230A7BA
pool_0230A7BC:
loc_0230A7BC:
	.word FirmwareWlWorkPointerSlot	; 0230A7BC
pool_0230A7C0:
loc_0230A7C0:
	.word 0x00000400	; 0230A7C0
pool_0230A7C4:
loc_0230A7C4:
	.word 0x01000000	; 0230A7C4
pool_0230A7C8:
loc_0230A7C8:
	.word 0x00000324	; 0230A7C8
pool_0230A7CC:
loc_0230A7CC:
	.word REG_WIFI_TXBUF_RESET	; 0230A7CC

; ===== function loc_0230A7D0 =====
loc_0230A7D0:
	push {r4,r5,lr}	; 0230A7D0
	sub sp,#0x4	; 0230A7D2
	ldr r0,[pool_0230A804]	; 0230A7D4
	ldr r1,[r0,#0x0]	; 0230A7D6
	ldr r0,[pool_0230A808]	; 0230A7D8
	add r5,r1,r0	; 0230A7DA
	ldr r0,[pool_0230A80C]	; 0230A7DC
	bl loc_02304EE8	; 0230A7DE
	add r4,r0,#0x0	; 0230A7E2
	mov r1,#0x2	; 0230A7E4
	ldr r0,[pool_0230A810]	; 0230A7E6
	strh r1,[r0,#0x0]	; 0230A7E8
	ldrh r0,[r5,#0x3c]	; 0230A7EA
	cmp r0,#0x0	; 0230A7EC
	beq loc_0230A7F4	; 0230A7EE
	bl loc_0230A814	; 0230A7F0
loc_0230A7F4:
	add r0,r4,#0x0	; 0230A7F4
	bl loc_02304EF8	; 0230A7F6
	add sp,#0x4	; 0230A7FA
	pop {r4,r5}	; 0230A7FC
	pop {r3}	; 0230A7FE
	bx r3	; 0230A800
	.byte 0xC0, 0x46	; 0230A804
pool_0230A804:
loc_0230A804:
	.word FirmwareWlWorkPointerSlot	; 0230A804
pool_0230A808:
loc_0230A808:
	.word 0x00000400	; 0230A808
pool_0230A80C:
loc_0230A80C:
	.word 0x01000000	; 0230A80C
pool_0230A810:
loc_0230A810:
	.word REG_WIFI_TXBUF_RESET	; 0230A810

; ===== function loc_0230A814 =====
loc_0230A814:
	bx pc	; 0230A814
	.byte 0xC0, 0x46	; 0230A818
.arm

; ===== function loc_0230A818 =====
loc_0230A818:
	ldr r12,[pool_0230A820]	; 0230A818
	bx r12	; 0230A81C
pool_0230A820:
loc_0230A820:
	.word P2_Entry_037FD288 + 1	; 0230A820
.thumb

; ===== function loc_0230A824 =====
loc_0230A824:
	push {r4,lr}	; 0230A824
	ldr r0,[pool_0230A850]	; 0230A826
	ldr r1,[r0,#0x0]	; 0230A828
	ldr r0,[pool_0230A854]	; 0230A82A
	add r4,r1,r0	; 0230A82C
	ldr r0,[pool_0230A858]	; 0230A82E
	bl loc_02304EE8	; 0230A830
	mov r2,#0xc0	; 0230A834
	ldr r1,[pool_0230A85C]	; 0230A836
	strh r2,[r1,#0x0]	; 0230A838
	mov r2,#0x0	; 0230A83A
	add r1,r4,#0x0	; 0230A83C
	add r1,#0x50	; 0230A83E
	strh r2,[r1,#0x0]	; 0230A840
	add r4,#0x64	; 0230A842
	strh r2,[r4,#0x0]	; 0230A844
	bl loc_02304EF8	; 0230A846
	pop {r4}	; 0230A84A
	pop {r3}	; 0230A84C
	bx r3	; 0230A84E
pool_0230A850:
loc_0230A850:
	.word FirmwareWlWorkPointerSlot	; 0230A850
pool_0230A854:
loc_0230A854:
	.word 0x00000400	; 0230A854
pool_0230A858:
loc_0230A858:
	.word 0x01000000	; 0230A858
pool_0230A85C:
loc_0230A85C:
	.word REG_WIFI_TXBUF_RESET	; 0230A85C
P4_Entry_0230A860:
	ldr r1,[r0,#0x8]	; 0230A860
	ldrh r3,[r1,#0x4]	; 0230A862
	mov r1,#0xff	; 0230A864
	and r3,r1	; 0230A866
	ldr r1,[pool_0230A890]	; 0230A868
	ldr r2,[r1,#0x0]	; 0230A86A
	ldr r1,[pool_0230A894]	; 0230A86C
	add r2,r2,r1	; 0230A86E
	cmp r3,#0x0	; 0230A870
	bne P4_Entry_0230A87C	; 0230A872
	ldr r1,[r2,#0x6c]	; 0230A874
	add r1,r1,#0x1	; 0230A876
	str r1,[r2,#0x6c]	; 0230A878
	b P4_Entry_0230A882	; 0230A87A
P4_Entry_0230A87C:
	ldr r1,[r2,#0x68]	; 0230A87C
	add r1,r1,r3	; 0230A87E
	str r1,[r2,#0x68]	; 0230A880
P4_Entry_0230A882:
	ldrh r1,[r0,#0x4]	; 0230A882
	add r1,r1,#0x1	; 0230A884
	strh r1,[r0,#0x4]	; 0230A886
	mov r1,#0x0	; 0230A888
	strh r1,[r0,#0x0]	; 0230A88A
	bx lr	; 0230A88C
	.byte 0xC0, 0x46	; 0230A88E
pool_0230A890:
	.word FirmwareWlWorkPointerSlot	; 0230A890
pool_0230A894:
	.word 0x00000510	; 0230A894
	.byte 0xF0, 0xB5, 0x81, 0xB0, 0x05, 0x1C, 0x0F, 0x1C, 0x29, 0x49, 0x09, 0x68, 0x29, 0x4A, 0x8C, 0x18	; 0230A898
	.byte 0x26, 0x1C, 0x30, 0x36, 0x28, 0x4A, 0x89, 0x18, 0x0A, 0x68, 0x52, 0x1C, 0x0A, 0x60, 0xA9, 0x8A	; 0230A8A8
	.byte 0x09, 0x07, 0x89, 0x0F, 0x00, 0x29, 0x0D, 0xD1, 0xFC, 0xF7, 0x38, 0xFE, 0x30, 0x1C, 0x21, 0x1C	; 0230A8B8
	.byte 0x24, 0x31, 0x2A, 0x1C, 0x10, 0x3A, 0xFC, 0xF7, 0x7D, 0xFE, 0x28, 0x1C, 0x00, 0x21, 0x00, 0xF0	; 0230A8C8
	.byte 0x6D, 0xF8, 0x04, 0xE0, 0x30, 0x1C, 0x10, 0x3D, 0x29, 0x1C, 0xFE, 0xF7, 0x21, 0xFC, 0x00, 0x23	; 0230A8D8
	.byte 0x17, 0x4A, 0x11, 0x68, 0x19, 0x48, 0x0B, 0x52, 0x11, 0x68, 0x19, 0x48, 0x08, 0x58, 0x80, 0x89	; 0230A8E8
	.byte 0x80, 0x04, 0xC0, 0x0F, 0x00, 0x28, 0x13, 0xD1, 0x08, 0x21, 0x16, 0x48, 0x01, 0x80, 0x05, 0x21	; 0230A8F8
	.byte 0x15, 0x48, 0x01, 0x80, 0x00, 0x2F, 0x0B, 0xD0, 0xA0, 0x8D, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20	; 0230A908
	.byte 0x00, 0xF0, 0xF2, 0xFA, 0x20, 0x8C, 0x00, 0x28, 0x02, 0xD0, 0x00, 0x20, 0x00, 0xF0, 0xEC, 0xFA	; 0230A918
	.byte 0x30, 0x89, 0x00, 0x28, 0x05, 0xD0, 0x00, 0x2F, 0x06, 0xD0, 0x02, 0x20, 0x00, 0xF0, 0xE4, 0xFA	; 0230A928
	.byte 0x02, 0xE0, 0x00, 0x20, 0xFC, 0xF7, 0xC4, 0xFB, 0x01, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230A938
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x50, 0x01, 0x00, 0x00, 0x24, 0x05, 0x00, 0x00, 0x28, 0x04, 0x00, 0x00	; 0230A948
	.byte 0x30, 0x04, 0x00, 0x00, 0xAC, 0x80, 0x80, 0x04, 0xAE, 0x80, 0x80, 0x04, 0x10, 0xB5, 0x10, 0x49	; 0230A958
	.byte 0x0A, 0x68, 0x10, 0x49, 0x51, 0x18, 0x8C, 0x68, 0x83, 0x88, 0xFF, 0x22, 0x13, 0x40, 0xE2, 0x18	; 0230A968
	.byte 0x8A, 0x60, 0x02, 0x88, 0x02, 0x20, 0x02, 0x40, 0x00, 0x2A, 0x06, 0xD1, 0x08, 0x68, 0x40, 0x1C	; 0230A978
	.byte 0x08, 0x60, 0x08, 0x69, 0x40, 0x1C, 0x08, 0x61, 0x02, 0xE0, 0x48, 0x68, 0x40, 0x1C, 0x48, 0x60	; 0230A988
	.byte 0x00, 0x22, 0x03, 0x48, 0x01, 0x68, 0x04, 0x48, 0x0A, 0x52, 0x10, 0xBC, 0x08, 0xBC, 0x18, 0x47	; 0230A998
	.byte 0xF4, 0xFF, 0x80, 0x03, 0x10, 0x05, 0x00, 0x00, 0x28, 0x04, 0x00, 0x00, 0xF0, 0xB5, 0x83, 0xB0	; 0230A9A8
	.byte 0x05, 0x1C, 0x00, 0x91, 0xA1, 0x48, 0x00, 0x68, 0xA1, 0x49, 0x41, 0x18, 0x01, 0x91, 0xA1, 0x49	; 0230A9B8
	.byte 0x47, 0x18, 0xA1, 0x49, 0x44, 0x18, 0xA1, 0x49, 0x40, 0x18, 0x02, 0x90, 0x6E, 0x88, 0x29, 0x89	; 0230A9C8
	.byte 0x02, 0x20, 0x01, 0x40, 0x00, 0x29, 0x1C, 0xD1, 0x20, 0x68, 0x40, 0x1C, 0x20, 0x60, 0x29, 0x8B	; 0230A9D8
	.byte 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x03, 0xD0, 0x60, 0x69, 0x40, 0x1C, 0x60, 0x61, 0x02, 0xE0	; 0230A9E8
	.byte 0x20, 0x69, 0x40, 0x1C, 0x20, 0x61, 0x30, 0x1C, 0xFC, 0xF7, 0x28, 0xFC, 0x00, 0x28, 0x0B, 0xD0	; 0230A9F8
	.byte 0xA9, 0x8A, 0x93, 0x48, 0x01, 0x40, 0x00, 0x29, 0x06, 0xD1, 0x30, 0x1C, 0xFC, 0xF7, 0xE0, 0xFC	; 0230AA08
	.byte 0x02, 0xE0, 0x60, 0x68, 0x40, 0x1C, 0x60, 0x60, 0xA8, 0x8A, 0x40, 0x04, 0xC0, 0x0F, 0x00, 0x28	; 0230AA18
	.byte 0x02, 0xD0, 0xA0, 0x69, 0x40, 0x1C, 0xA0, 0x61, 0xA2, 0x68, 0xA9, 0x89, 0xFF, 0x20, 0x01, 0x40	; 0230AA28
	.byte 0x50, 0x18, 0xA0, 0x60, 0xAC, 0x8A, 0xFC, 0x20, 0x04, 0x40, 0xA0, 0x2C, 0x09, 0xD8, 0xA0, 0x2C	; 0230AA38
	.byte 0x69, 0xD2, 0x10, 0x2C, 0x02, 0xD8, 0x10, 0x2C, 0x3C, 0xD0, 0xDB, 0xE0, 0x30, 0x2C, 0x39, 0xD0	; 0230AA48
	.byte 0xD8, 0xE0, 0xB0, 0x2C, 0x02, 0xD8, 0xB0, 0x2C, 0x04, 0xD0, 0xD3, 0xE0, 0xC0, 0x2C, 0x00, 0xD1	; 0230AA58
	.byte 0x95, 0xE0, 0xCF, 0xE0, 0x29, 0x89, 0x02, 0x20, 0x01, 0x40, 0x00, 0x29, 0x00, 0xD0, 0xC9, 0xE0	; 0230AA68
	.byte 0xA9, 0x8D, 0x00, 0x29, 0x10, 0xD1, 0xE8, 0x8D, 0x02, 0x28, 0x0D, 0xD1, 0x28, 0x8E, 0x00, 0x28	; 0230AA78
	.byte 0x0A, 0xD1, 0x30, 0x04, 0x00, 0x0C, 0x30, 0x21, 0xFC, 0xF7, 0xE4, 0xFC, 0x28, 0x1C, 0x18, 0x30	; 0230AA88
	.byte 0xA9, 0x8D, 0xFD, 0xF7, 0xDD, 0xF8, 0xB5, 0xE0, 0x01, 0x29, 0x00, 0xD0, 0xB2, 0xE0, 0xE8, 0x8D	; 0230AA98
	.byte 0x04, 0x28, 0x00, 0xD0, 0xAE, 0xE0, 0x28, 0x8E, 0x00, 0x28, 0x00, 0xD0, 0xAA, 0xE0, 0x30, 0x04	; 0230AAA8
	.byte 0x00, 0x0C, 0x30, 0x21, 0xFC, 0xF7, 0xCE, 0xFC, 0x28, 0x1C, 0x18, 0x30, 0xA9, 0x8D, 0xFD, 0xF7	; 0230AAB8
	.byte 0xC7, 0xF8, 0x9F, 0xE0, 0x29, 0x89, 0x02, 0x20, 0x01, 0x40, 0x00, 0x29, 0x1E, 0xD1, 0xE8, 0x8D	; 0230AAC8
	.byte 0x00, 0x28, 0x00, 0xD0, 0x96, 0xE0, 0x30, 0x04, 0x00, 0x0C, 0x40, 0x21, 0xFC, 0xF7, 0xBA, 0xFC	; 0230AAD8
	.byte 0x10, 0x2C, 0x09, 0xD1, 0x28, 0x1C, 0x18, 0x30, 0x29, 0x8E, 0x2B, 0x1C, 0x14, 0x33, 0x6A, 0x8A	; 0230AAE8
	.byte 0x9A, 0x18, 0xFD, 0xF7, 0x2F, 0xF8, 0x85, 0xE0, 0x28, 0x1C, 0x18, 0x30, 0x29, 0x8E, 0x2B, 0x1C	; 0230AAF8
	.byte 0x14, 0x33, 0x6A, 0x8A, 0x9A, 0x18, 0xFC, 0xF7, 0xD7, 0xFF, 0x7B, 0xE0, 0x30, 0x04, 0x00, 0x0C	; 0230AB08
	.byte 0xFC, 0xF7, 0xC0, 0xFB, 0x76, 0xE0, 0x01, 0x98, 0x80, 0x89, 0x01, 0x28, 0x24, 0xD1, 0x00, 0x2E	; 0230AB18
	.byte 0x0A, 0xD0, 0x30, 0x1C, 0xFC, 0xF7, 0xAE, 0xFB, 0x30, 0x28, 0x26, 0xD9, 0x30, 0x04, 0x00, 0x0C	; 0230AB28
	.byte 0x30, 0x21, 0xFC, 0xF7, 0x8F, 0xFC, 0x20, 0xE0, 0x28, 0x8B, 0x01, 0x24, 0x20, 0x40, 0x00, 0x28	; 0230AB38
	.byte 0x1B, 0xD0, 0x3E, 0x4E, 0x0A, 0xE0, 0x20, 0x1C, 0xFC, 0xF7, 0x9C, 0xFB, 0x30, 0x28, 0x04, 0xD9	; 0230AB48
	.byte 0x20, 0x04, 0x00, 0x0C, 0x30, 0x21, 0xFC, 0xF7, 0x7D, 0xFC, 0x64, 0x1C, 0x31, 0x68, 0x3D, 0x48	; 0230AB58
	.byte 0x08, 0x5A, 0x84, 0x42, 0xEF, 0xD3, 0x08, 0xE0, 0x01, 0x98, 0x00, 0x89, 0x30, 0x28, 0x04, 0xD9	; 0230AB68
	.byte 0x30, 0x20, 0xFC, 0xF7, 0x9D, 0xFA, 0xFB, 0xF7, 0x05, 0xF8, 0x38, 0x88, 0x71, 0x28, 0x41, 0xD1	; 0230AB78
	.byte 0x00, 0x21, 0xF8, 0x69, 0x81, 0x80, 0x39, 0x80, 0xFD, 0xF7, 0x8E, 0xF8, 0x3A, 0xE0, 0x01, 0x98	; 0230AB88
	.byte 0x80, 0x89, 0x01, 0x28, 0x24, 0xD1, 0x00, 0x2E, 0x0A, 0xD0, 0x30, 0x1C, 0xFC, 0xF7, 0x72, 0xFB	; 0230AB98
	.byte 0x20, 0x28, 0x26, 0xD9, 0x30, 0x04, 0x00, 0x0C, 0x20, 0x21, 0xFC, 0xF7, 0x53, 0xFC, 0x20, 0xE0	; 0230ABA8
	.byte 0x28, 0x8B, 0x01, 0x24, 0x20, 0x40, 0x00, 0x28, 0x1B, 0xD0, 0x20, 0x4E, 0x0A, 0xE0, 0x20, 0x1C	; 0230ABB8
	.byte 0xFC, 0xF7, 0x60, 0xFB, 0x20, 0x28, 0x04, 0xD9, 0x20, 0x04, 0x00, 0x0C, 0x20, 0x21, 0xFC, 0xF7	; 0230ABC8
	.byte 0x41, 0xFC, 0x64, 0x1C, 0x31, 0x68, 0x1F, 0x48, 0x08, 0x5A, 0x84, 0x42, 0xEF, 0xD3, 0x08, 0xE0	; 0230ABD8
	.byte 0x01, 0x98, 0x00, 0x89, 0x20, 0x28, 0x04, 0xD9, 0x20, 0x20, 0xFC, 0xF7, 0x61, 0xFA, 0xFA, 0xF7	; 0230ABE8
	.byte 0xC9, 0xFF, 0x38, 0x88, 0x41, 0x28, 0x05, 0xD1, 0x00, 0x21, 0xF8, 0x69, 0x81, 0x80, 0x39, 0x80	; 0230ABF8
	.byte 0xFD, 0xF7, 0x52, 0xF8, 0x28, 0x1C, 0xFC, 0xF7, 0x6B, 0xFC, 0x02, 0x98, 0x10, 0x3D, 0x29, 0x1C	; 0230AC08
	.byte 0xFA, 0xF7, 0x10, 0xF8, 0x00, 0x22, 0x09, 0x48, 0x01, 0x68, 0x0F, 0x48, 0x0A, 0x52, 0x00, 0x98	; 0230AC18
	.byte 0x00, 0x28, 0x06, 0xD0, 0x02, 0x98, 0x00, 0x89, 0x00, 0x28, 0x02, 0xD0, 0x01, 0x20, 0x00, 0xF0	; 0230AC28
	.byte 0x63, 0xF9, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC, 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03	; 0230AC38
	.byte 0x18, 0x03, 0x00, 0x00, 0xD8, 0x03, 0x00, 0x00, 0x10, 0x05, 0x00, 0x00, 0x74, 0x01, 0x00, 0x00	; 0230AC48
	.byte 0x00, 0x20, 0x00, 0x00, 0xF6, 0x02, 0x00, 0x00, 0x14, 0x04, 0x00, 0x00, 0xF0, 0xB5, 0x83, 0xB0	; 0230AC58
	.byte 0x05, 0x1C, 0x00, 0x91, 0x3F, 0x49, 0x09, 0x68, 0x3F, 0x4A, 0x8F, 0x18, 0x3F, 0x4A, 0x8E, 0x18	; 0230AC68
	.byte 0x3F, 0x4A, 0x8C, 0x18, 0x29, 0x1C, 0x01, 0x91, 0x10, 0x39, 0x01, 0x91, 0xFC, 0xF7, 0x30, 0xFC	; 0230AC78
	.byte 0x29, 0x89, 0x02, 0x20, 0x01, 0x40, 0x00, 0x29, 0x21, 0xD1, 0x20, 0x68, 0x40, 0x1C, 0x20, 0x60	; 0230AC88
	.byte 0xA8, 0x8A, 0xC0, 0x05, 0xC0, 0x0F, 0x00, 0x28, 0x0C, 0xD0, 0xA9, 0x8C, 0x01, 0x20, 0x01, 0x40	; 0230AC98
	.byte 0x00, 0x29, 0x03, 0xD0, 0x60, 0x69, 0x40, 0x1C, 0x60, 0x61, 0x13, 0xE0, 0x20, 0x69, 0x40, 0x1C	; 0230ACA8
	.byte 0x20, 0x61, 0x0F, 0xE0, 0x29, 0x8B, 0x01, 0x20, 0x01, 0x40, 0x00, 0x29, 0x03, 0xD0, 0x60, 0x69	; 0230ACB8
	.byte 0x40, 0x1C, 0x60, 0x61, 0x06, 0xE0, 0x20, 0x69, 0x40, 0x1C, 0x20, 0x61, 0x02, 0xE0, 0x60, 0x68	; 0230ACC8
	.byte 0x40, 0x1C, 0x60, 0x60, 0xA8, 0x8A, 0x40, 0x04, 0xC0, 0x0F, 0x00, 0x28, 0x02, 0xD0, 0xA0, 0x69	; 0230ACD8
	.byte 0x40, 0x1C, 0xA0, 0x61, 0x38, 0x1C, 0x01, 0x99, 0xFE, 0xF7, 0x1A, 0xFA, 0x00, 0x22, 0x1D, 0x48	; 0230ACE8
	.byte 0x01, 0x68, 0x20, 0x48, 0x0A, 0x52, 0x68, 0x88, 0xFC, 0xF7, 0xA8, 0xFA, 0x00, 0x28, 0x07, 0xD0	; 0230ACF8
	.byte 0xA9, 0x8A, 0x1D, 0x48, 0x01, 0x40, 0x00, 0x29, 0x02, 0xD1, 0x68, 0x88, 0xFC, 0xF7, 0x60, 0xFB	; 0230AD08
	.byte 0x00, 0x98, 0x00, 0x28, 0x21, 0xD0, 0x38, 0x89, 0x00, 0x28, 0x03, 0xD0, 0x00, 0x20, 0x00, 0xF0	; 0230AD18
	.byte 0xEB, 0xF8, 0x1A, 0xE0, 0xB1, 0x89, 0x15, 0x48, 0x08, 0x18, 0x00, 0x04, 0x00, 0x0C, 0x01, 0x28	; 0230AD28
	.byte 0x13, 0xD8, 0x30, 0x89, 0x40, 0x28, 0x10, 0xD1, 0xF0, 0x89, 0x00, 0x28, 0x0D, 0xD0, 0x30, 0x1C	; 0230AD38
	.byte 0x88, 0x30, 0x00, 0x88, 0xFC, 0xF7, 0x4A, 0xFA, 0x00, 0x28, 0x06, 0xD1, 0x8E, 0x36, 0x30, 0x88	; 0230AD48
	.byte 0x00, 0x28, 0x02, 0xD1, 0x01, 0x20, 0xFB, 0xF7, 0x97, 0xF8, 0x03, 0xB0, 0xF0, 0xBC, 0x08, 0xBC	; 0230AD58
	.byte 0x18, 0x47, 0xC0, 0x46, 0xF4, 0xFF, 0x80, 0x03, 0x68, 0x01, 0x00, 0x00, 0x18, 0x03, 0x00, 0x00	; 0230AD68
	.byte 0x10, 0x05, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0xFE, 0xFF, 0x00, 0x00	; 0230AD78

; ===== function loc_0230AD88 =====
loc_0230AD88:
	push {r4,r5,lr}	; 0230AD88
	sub sp,#0x4	; 0230AD8A
	add r5,r0,#0x0	; 0230AD8C
	add r4,r1,#0x0	; 0230AD8E
	add r4,#0x10	; 0230AD90
	ldrh r3,[r4,#0x14]	; 0230AD92
	ldr r2,[pool_0230AE54]	; 0230AD94
	and r3,r2	; 0230AD96
	cmp r3,#0x0	; 0230AD98
	beq loc_0230AE04	; 0230AD9A
	ldrh r2,[r1,#0xc]	; 0230AD9C
	ldr r1,[pool_0230AE58]	; 0230AD9E
	cmp r2,r1	; 0230ADA0
	bne loc_0230ADB4	; 0230ADA2
	add r1,r4,#0x0	; 0230ADA4
	add r1,#0x8	; 0230ADA6
	add r2,r4,#0x0	; 0230ADA8
	add r2,#0x2c	; 0230ADAA
	ldrh r3,[r4,#0x6]	; 0230ADAC
	bl loc_023051D4	; 0230ADAE
	b loc_0230ADC0	; 0230ADB2
loc_0230ADB4:
	add r1,r4,#0x0	; 0230ADB4
	add r1,#0x8	; 0230ADB6
	ldr r2,[r4,#0x2c]	; 0230ADB8
	ldrh r3,[r4,#0x6]	; 0230ADBA
	bl loc_023051D4	; 0230ADBC
loc_0230ADC0:
	ldr r2,[pool_0230AE5C]	; 0230ADC0
	ldrh r1,[r2,#0x0]	; 0230ADC2
	ldrh r0,[r2,#0x0]	; 0230ADC4
	lsl r0,r0,#0x8	; 0230ADC6
	add r0,r1,r0	; 0230ADC8
	strh r0,[r5,#0x24]	; 0230ADCA
	ldrh r0,[r2,#0x0]	; 0230ADCC
	mov r1,#0xff	; 0230ADCE
	and r0,r1	; 0230ADD0
	ldr r3,[pool_0230AE60]	; 0230ADD2
	ldr r2,[r3,#0x0]	; 0230ADD4
	ldr r1,[pool_0230AE64]	; 0230ADD6
	ldrh r1,[r2,r1]	; 0230ADD8
	lsl r1,r1,#0xe	; 0230ADDA
	orr r0,r1	; 0230ADDC
	strh r0,[r5,#0x26]	; 0230ADDE
	ldr r1,[r3,#0x0]	; 0230ADE0
	ldr r0,[pool_0230AE68]	; 0230ADE2
	ldrh r1,[r1,r0]	; 0230ADE4
	mov r0,#0x8	; 0230ADE6
	and r1,r0	; 0230ADE8
	cmp r1,#0x0	; 0230ADEA
	beq loc_0230AE26	; 0230ADEC
	add r1,r5,#0x0	; 0230ADEE
	add r1,#0xc	; 0230ADF0
	ldrh r0,[r4,#0x12]	; 0230ADF2
	add r0,r1,r0	; 0230ADF4
	sub r1,r0,#0x7	; 0230ADF6
	mov r0,#0x1	; 0230ADF8
	bic r1,r0	; 0230ADFA
	mov r0,#0x0	; 0230ADFC
	strh r0,[r1,#0x0]	; 0230ADFE
	strh r0,[r1,#0x2]	; 0230AE00
	b loc_0230AE26	; 0230AE02
loc_0230AE04:
	ldrh r2,[r1,#0xc]	; 0230AE04
	ldr r1,[pool_0230AE58]	; 0230AE06
	cmp r2,r1	; 0230AE08
	bne loc_0230AE1A	; 0230AE0A
	add r1,r4,#0x0	; 0230AE0C
	add r1,#0x8	; 0230AE0E
	ldrh r2,[r4,#0x6]	; 0230AE10
	add r2,#0x24	; 0230AE12
	bl loc_02305224	; 0230AE14
	b loc_0230AE26	; 0230AE18
loc_0230AE1A:
	add r1,r4,#0x0	; 0230AE1A
	add r1,#0x8	; 0230AE1C
	ldr r2,[r4,#0x2c]	; 0230AE1E
	ldrh r3,[r4,#0x6]	; 0230AE20
	bl loc_023051FC	; 0230AE22
loc_0230AE26:
	ldr r0,[pool_0230AE60]	; 0230AE26
	ldr r1,[r0,#0x0]	; 0230AE28
	ldr r0,[pool_0230AE68]	; 0230AE2A
	ldrh r1,[r1,r0]	; 0230AE2C
	mov r0,#0x4	; 0230AE2E
	and r1,r0	; 0230AE30
	cmp r1,#0x0	; 0230AE32
	beq loc_0230AE4A	; 0230AE34
	add r5,#0xc	; 0230AE36
	ldrh r0,[r4,#0x12]	; 0230AE38
	add r0,r5,r0	; 0230AE3A
	sub r1,r0,#0x1	; 0230AE3C
	mov r0,#0x3	; 0230AE3E
	bic r1,r0	; 0230AE40
	ldr r0,[pool_0230AE6C]	; 0230AE42
	strh r0,[r1,#0x0]	; 0230AE44
	ldr r0,[pool_0230AE70]	; 0230AE46
	strh r0,[r1,#0x2]	; 0230AE48
loc_0230AE4A:
	add sp,#0x4	; 0230AE4A
	pop {r4,r5}	; 0230AE4C
	pop {r3}	; 0230AE4E
	bx r3	; 0230AE50
	.byte 0xC0, 0x46	; 0230AE54
pool_0230AE54:
loc_0230AE54:
	.word 0x00004000	; 0230AE54
pool_0230AE58:
loc_0230AE58:
	.word 0x0000FFFF	; 0230AE58
pool_0230AE5C:
loc_0230AE5C:
	.word REG_WIFI_RANDOM	; 0230AE5C
pool_0230AE60:
loc_0230AE60:
	.word FirmwareWlWorkPointerSlot	; 0230AE60
pool_0230AE64:
loc_0230AE64:
	.word 0x0000030A	; 0230AE64
pool_0230AE68:
loc_0230AE68:
	.word 0x00000638	; 0230AE68
pool_0230AE6C:
loc_0230AE6C:
	.word 0x0000B6B8	; 0230AE6C
pool_0230AE70:
loc_0230AE70:
	.word 0x00001D46	; 0230AE70

; ===== function loc_0230AE74 =====
	push {r4,r5,r6,r7,lr}	; 0230AE74
	sub sp,#0x4	; 0230AE76
	ldr r0,[pool_0230AEE0]	; 0230AE78
	ldr r1,[r0,#0x0]	; 0230AE7A
	ldr r0,[pool_0230AEE4]	; 0230AE7C
	add r4,r1,r0	; 0230AE7E
	ldr r0,[pool_0230AEE8]	; 0230AE80
	add r5,r1,r0	; 0230AE82
	ldrh r6,[r5,#0x8]	; 0230AE84
	cmp r6,#0x0	; 0230AE86
	beq loc_0230AED8	; 0230AE88
	ldr r0,[pool_0230AEEC]	; 0230AE8A
	bl loc_02304EE8	; 0230AE8C
	add r7,r0,#0x0	; 0230AE90
	ldrh r1,[r4,#0x0]	; 0230AE92
	cmp r1,#0x0	; 0230AE94
	beq loc_0230AE9E	; 0230AE96
	bl loc_02304EF8	; 0230AE98
	b loc_0230AED8	; 0230AE9C
loc_0230AE9E:
	mov r0,#0x1	; 0230AE9E
	strh r0,[r4,#0x0]	; 0230AEA0
	ldrh r0,[r4,#0x2]	; 0230AEA2
	add r0,r0,#0x1	; 0230AEA4
	strh r0,[r4,#0x2]	; 0230AEA6
	ldr r1,[r5,#0x0]	; 0230AEA8
	ldr r5,[r4,#0x8]	; 0230AEAA
	add r0,r1,#0x0	; 0230AEAC
	add r0,#0x10	; 0230AEAE
	str r0,[r4,#0xc]	; 0230AEB0
	add r0,r5,#0x0	; 0230AEB2
	bl loc_0230AD88	; 0230AEB4
	cmp r6,#0x1	; 0230AEB8
	bls loc_0230AEC4	; 0230AEBA
	ldrh r1,[r5,#0xc]	; 0230AEBC
	ldr r0,[pool_0230AEF0]	; 0230AEBE
	orr r1,r0	; 0230AEC0
	strh r1,[r5,#0xc]	; 0230AEC2
loc_0230AEC4:
	ldr r0,[pool_0230AEF4]	; 0230AEC4
	and r5,r0	; 0230AEC6
	lsr r1,r5,#0x1	; 0230AEC8
	ldr r0,[pool_0230AEF8]	; 0230AECA
	orr r1,r0	; 0230AECC
	ldr r0,[pool_0230AEFC]	; 0230AECE
	strh r1,[r0,#0x0]	; 0230AED0
	add r0,r7,#0x0	; 0230AED2
	bl loc_02304EF8	; 0230AED4
loc_0230AED8:
	add sp,#0x4	; 0230AED8
	pop {r4,r5,r6,r7}	; 0230AEDA
	pop {r3}	; 0230AEDC
	bx r3	; 0230AEDE
pool_0230AEE0:
loc_0230AEE0:
	.word FirmwareWlWorkPointerSlot	; 0230AEE0
pool_0230AEE4:
loc_0230AEE4:
	.word 0x00000428	; 0230AEE4
pool_0230AEE8:
loc_0230AEE8:
	.word 0x00000180	; 0230AEE8
pool_0230AEEC:
loc_0230AEEC:
	.word 0x01000000	; 0230AEEC
pool_0230AEF0:
loc_0230AEF0:
	.word 0x00002000	; 0230AEF0
pool_0230AEF4:
loc_0230AEF4:
	.word 0x00003FFF	; 0230AEF4
pool_0230AEF8:
loc_0230AEF8:
	.word 0x00008000	; 0230AEF8
pool_0230AEFC:
loc_0230AEFC:
	.word REG_WIFI_TXBUF_LOC3	; 0230AEFC

; ===== function loc_0230AF00 =====
loc_0230AF00:
	push {r4,r5,r6,r7,lr}	; 0230AF00
	sub sp,#0x1c	; 0230AF02
	add r6,r0,#0x0	; 0230AF04
	ldr r0,[pool_0230B074]	; 0230AF06
	ldr r0,[r0,#0x0]	; 0230AF08
	ldr r1,[pool_0230B078]	; 0230AF0A
	add r7,r0,r1	; 0230AF0C
	ldr r1,[pool_0230B07C]	; 0230AF0E
	add r1,r0,r1	; 0230AF10
	str r1,[sp,#0x0]	; 0230AF12
	mov r1,#0x14	; 0230AF14
	add r2,r6,#0x0	; 0230AF16
	mul r2,r1	; 0230AF18
	ldr r1,[sp,#0x0]	; 0230AF1A
	add r4,r1,r2	; 0230AF1C
	ldr r1,[pool_0230B080]	; 0230AF1E
	add r2,r0,r1	; 0230AF20
	mov r0,#0xc	; 0230AF22
	add r1,r6,#0x0	; 0230AF24
	mul r1,r0	; 0230AF26
	add r0,r2,r1	; 0230AF28
	str r0,[sp,#0x4]	; 0230AF2A
	ldrh r0,[r0,#0x8]	; 0230AF2C
	cmp r0,#0x0	; 0230AF2E
	bne loc_0230AF34	; 0230AF30
	b loc_0230B06A	; 0230AF32
loc_0230AF34:
	ldr r0,[pool_0230B084]	; 0230AF34
	bl loc_02304EE8	; 0230AF36
	str r0,[sp,#0x10]	; 0230AF3A
	ldrh r1,[r4,#0x0]	; 0230AF3C
	cmp r1,#0x0	; 0230AF3E
	beq loc_0230AF48	; 0230AF40
	bl loc_02304EF8	; 0230AF42
	b loc_0230B06A	; 0230AF46
loc_0230AF48:
	ldr r0,[sp,#0x4]	; 0230AF48
	ldr r0,[r0,#0x0]	; 0230AF4A
	str r0,[sp,#0xc]	; 0230AF4C
loc_0230AF4E:
	mov r0,#0x0	; 0230AF4E
	mvn r1,r0	; 0230AF50
	ldr r0,[sp,#0xc]	; 0230AF52
	cmp r0,r1	; 0230AF54
	bne loc_0230AF60	; 0230AF56
	ldr r0,[sp,#0x10]	; 0230AF58
	bl loc_02304EF8	; 0230AF5A
	b loc_0230B06A	; 0230AF5E
loc_0230AF60:
	str r0,[sp,#0x8]	; 0230AF60
	bl loc_02304C2C	; 0230AF62
	str r0,[sp,#0xc]	; 0230AF66
	ldr r5,[sp,#0x8]	; 0230AF68
	add r5,#0x10	; 0230AF6A
	ldrh r0,[r5,#0x2]	; 0230AF6C
	str r0,[sp,#0x14]	; 0230AF6E
	add r0,r7,#0x0	; 0230AF70
	add r0,#0xa8	; 0230AF72
	ldr r1,[r0,#0x0]	; 0230AF74
	ldrh r0,[r5,#0x4]	; 0230AF76
	sub r0,r1,r0	; 0230AF78
	lsl r0,r0,#0x10	; 0230AF7A
	lsr r1,r0,#0x10	; 0230AF7C
	add r0,r7,#0x0	; 0230AF7E
	add r0,#0x8c	; 0230AF80
	ldrh r0,[r0,#0x0]	; 0230AF82
	cmp r1,r0	; 0230AF84
	bls loc_0230AFAC	; 0230AF86
	ldr r0,[sp,#0x0]	; 0230AF88
	add r0,#0xb0	; 0230AF8A
	ldrh r0,[r0,#0x0]	; 0230AF8C
	add r1,r0,#0x1	; 0230AF8E
	ldr r0,[sp,#0x0]	; 0230AF90
	add r0,#0xb0	; 0230AF92
	strh r1,[r0,#0x0]	; 0230AF94
	mov r0,#0x2	; 0230AF96
	strh r0,[r5,#0x8]	; 0230AF98
	ldrh r0,[r4,#0x4]	; 0230AF9A
	add r0,r0,#0x1	; 0230AF9C
	strh r0,[r4,#0x4]	; 0230AF9E
	add r0,r5,#0x0	; 0230AFA0
	mov r1,#0x0	; 0230AFA2
	ldr r2,[r4,#0x10]	; 0230AFA4
	bl loc_0230A748	; 0230AFA6
	b loc_0230AF4E	; 0230AFAA
loc_0230AFAC:
	cmp r6,#0x0	; 0230AFAC
	beq loc_0230AFBE	; 0230AFAE
	cmp r6,#0x1	; 0230AFB0
	bne loc_0230AFE8	; 0230AFB2
	ldr r0,[sp,#0x14]	; 0230AFB4
	bl loc_0230728C	; 0230AFB6
	cmp r0,#0x40	; 0230AFBA
	bne loc_0230AFE8	; 0230AFBC
loc_0230AFBE:
	ldr r0,[sp,#0x14]	; 0230AFBE
	bl loc_02307270	; 0230AFC0
	cmp r0,#0x0	; 0230AFC4
	beq loc_0230AF4E	; 0230AFC6
	ldr r0,[sp,#0x14]	; 0230AFC8
	bl loc_0230728C	; 0230AFCA
	cmp r0,#0x40	; 0230AFCE
	beq loc_0230AFE8	; 0230AFD0
	mov r0,#0x2	; 0230AFD2
	strh r0,[r5,#0x8]	; 0230AFD4
	ldr r0,[sp,#0x4]	; 0230AFD6
	add r1,r5,#0x0	; 0230AFD8
	sub r1,#0x10	; 0230AFDA
	bl loc_02309128	; 0230AFDC
	add r0,r5,#0x0	; 0230AFE0
	bl loc_023074E8	; 0230AFE2
	b loc_0230AF4E	; 0230AFE6
loc_0230AFE8:
	mov r0,#0x1	; 0230AFE8
	strh r0,[r4,#0x0]	; 0230AFEA
	ldrh r0,[r4,#0x2]	; 0230AFEC
	add r0,r0,#0x1	; 0230AFEE
	strh r0,[r4,#0x2]	; 0230AFF0
	str r5,[r4,#0xc]	; 0230AFF2
	ldr r4,[r4,#0x8]	; 0230AFF4
	ldrh r0,[r7,#0x10]	; 0230AFF6
	cmp r0,#0x0	; 0230AFF8
	bne loc_0230B002	; 0230AFFA
	mov r0,#0x2	; 0230AFFC
	bl loc_02305E90	; 0230AFFE
loc_0230B002:
	add r0,r4,#0x0	; 0230B002
	ldr r1,[sp,#0x8]	; 0230B004
	bl loc_0230AD88	; 0230B006
	ldrh r0,[r7,#0xc]	; 0230B00A
	cmp r0,#0x1	; 0230B00C
	bne loc_0230B022	; 0230B00E
	ldr r0,[sp,#0x14]	; 0230B010
	bl loc_023071E4	; 0230B012
	cmp r0,#0x1	; 0230B016
	bls loc_0230B022	; 0230B018
	ldrh r1,[r4,#0xc]	; 0230B01A
	ldr r0,[pool_0230B088]	; 0230B01C
	orr r1,r0	; 0230B01E
	strh r1,[r4,#0xc]	; 0230B020
loc_0230B022:
	ldrh r1,[r5,#0x14]	; 0230B022
	lsl r2,r6,#0x2	; 0230B024
	ldr r0,[pool_0230B08C]	; 0230B026
	add r0,r2,r0	; 0230B028
	ldr r2,[pool_0230B090]	; 0230B02A
	and r4,r2	; 0230B02C
	lsr r4,r4,#0x1	; 0230B02E
	mov r2,#0xc	; 0230B030
	add r3,r1,#0x0	; 0230B032
	and r3,r2	; 0230B034
	cmp r3,#0x4	; 0230B036
	bne loc_0230B046	; 0230B038
	lsl r1,r4,#0x10	; 0230B03A
	lsr r2,r1,#0x10	; 0230B03C
	ldr r1,[pool_0230B094]	; 0230B03E
	orr r2,r1	; 0230B040
	strh r2,[r0,#0x0]	; 0230B042
	b loc_0230B064	; 0230B044
loc_0230B046:
	mov r2,#0xfc	; 0230B046
	and r1,r2	; 0230B048
	cmp r1,#0x50	; 0230B04A
	bne loc_0230B05A	; 0230B04C
	lsl r1,r4,#0x10	; 0230B04E
	lsr r2,r1,#0x10	; 0230B050
	ldr r1,[pool_0230B098]	; 0230B052
	orr r2,r1	; 0230B054
	strh r2,[r0,#0x0]	; 0230B056
	b loc_0230B064	; 0230B058
loc_0230B05A:
	lsl r1,r4,#0x10	; 0230B05A
	lsr r2,r1,#0x10	; 0230B05C
	ldr r1,[pool_0230B09C]	; 0230B05E
	orr r2,r1	; 0230B060
	strh r2,[r0,#0x0]	; 0230B062
loc_0230B064:
	ldr r0,[sp,#0x10]	; 0230B064
	bl loc_02304EF8	; 0230B066
loc_0230B06A:
	add sp,#0x1c	; 0230B06A
	pop {r4,r5,r6,r7}	; 0230B06C
	pop {r3}	; 0230B06E
	bx r3	; 0230B070
	.byte 0xC0, 0x46	; 0230B074
pool_0230B074:
loc_0230B074:
	.word FirmwareWlWorkPointerSlot	; 0230B074
pool_0230B078:
loc_0230B078:
	.word 0x00000318	; 0230B078
pool_0230B07C:
loc_0230B07C:
	.word 0x00000400	; 0230B07C
pool_0230B080:
loc_0230B080:
	.word 0x00000168	; 0230B080
pool_0230B084:
loc_0230B084:
	.word 0x01000000	; 0230B084
pool_0230B088:
loc_0230B088:
	.word 0x00002000	; 0230B088
pool_0230B08C:
loc_0230B08C:
	.word 0x048080A0	; 0230B08C
pool_0230B090:
loc_0230B090:
	.word 0x00003FFF	; 0230B090
pool_0230B094:
loc_0230B094:
	.word 0x0000A000	; 0230B094
pool_0230B098:
loc_0230B098:
	.word 0x00009000	; 0230B098
pool_0230B09C:
loc_0230B09C:
	.word 0x00008000	; 0230B09C

; ===== function loc_0230B0A0 =====
	push {r4,r5,r6,r7,lr}	; 0230B0A0
	sub sp,#0x4	; 0230B0A2
	ldr r6,[pool_0230B0E0]	; 0230B0A4
	ldr r1,[r6,#0x0]	; 0230B0A6
	ldr r0,[pool_0230B0E4]	; 0230B0A8
	add r5,r1,r0	; 0230B0AA
	mov r4,#0x0	; 0230B0AC
	mov r7,#0x18	; 0230B0AE
loc_0230B0B0:
	add r0,r4,#0x0	; 0230B0B0
	mul r0,r7	; 0230B0B2
	add r1,r5,r0	; 0230B0B4
	ldrh r0,[r5,r0]	; 0230B0B6
	cmp r0,#0x0	; 0230B0B8
	beq loc_0230B0D2	; 0230B0BA
	sub r0,r0,#0x1	; 0230B0BC
	strh r0,[r1,#0x0]	; 0230B0BE
	ldrh r0,[r1,#0x0]	; 0230B0C0
	cmp r0,#0x0	; 0230B0C2
	bne loc_0230B0D2	; 0230B0C4
	ldr r2,[r6,#0x0]	; 0230B0C6
	ldr r0,[pool_0230B0E8]	; 0230B0C8
	add r0,r2,r0	; 0230B0CA
	ldr r1,[r1,#0x14]	; 0230B0CC
	bl loc_02304C3C	; 0230B0CE
loc_0230B0D2:
	add r4,r4,#0x1	; 0230B0D2
	cmp r4,#0x3	; 0230B0D4
	bcc loc_0230B0B0	; 0230B0D6
	add sp,#0x4	; 0230B0D8
	pop {r4,r5,r6,r7}	; 0230B0DA
	pop {r3}	; 0230B0DC
	bx r3	; 0230B0DE
pool_0230B0E0:
loc_0230B0E0:
	.word FirmwareWlWorkPointerSlot	; 0230B0E0
pool_0230B0E4:
loc_0230B0E4:
	.word 0x000004BC	; 0230B0E4
pool_0230B0E8:
loc_0230B0E8:
	.word 0x0000015C	; 0230B0E8

; ===== function loc_0230B0EC =====
loc_0230B0EC:
	push {r4,r5,r6,r7,lr}	; 0230B0EC
	sub sp,#0x1c	; 0230B0EE
	add r6,r0,#0x0	; 0230B0F0
	str r1,[sp,#0x0]	; 0230B0F2
	ldr r0,[pool_0230B28C]	; 0230B0F4
	ldr r1,[r0,#0x0]	; 0230B0F6
	ldr r0,[pool_0230B290]	; 0230B0F8
	add r7,r1,r0	; 0230B0FA
	ldr r0,[pool_0230B294]	; 0230B0FC
	add r0,r1,r0	; 0230B0FE
	str r0,[sp,#0x4]	; 0230B100
	ldrh r0,[r6,#0x8]	; 0230B102
	sub r0,#0x18	; 0230B104
	strh r0,[r6,#0x8]	; 0230B106
	mov r4,#0x0	; 0230B108
	b loc_0230B18A	; 0230B10A
loc_0230B10C:
	add r1,r4,#0x0	; 0230B10C
	str r1,[sp,#0x18]	; 0230B10E
	mov r0,#0x18	; 0230B110
	mul r1,r0	; 0230B112
	str r1,[sp,#0x18]	; 0230B114
	ldr r0,[sp,#0x4]	; 0230B116
	add r5,r0,r1	; 0230B118
	lsl r1,r0,#0	; 0230B11A
	ldr r0,[sp,#0x18]	; 0230B11C
	ldrh r0,[r1,r0]	; 0230B11E
	cmp r0,#0x0	; 0230B120
	beq loc_0230B188	; 0230B122
	add r0,r5,#0x4	; 0230B124
	ldr r1,[sp,#0x0]	; 0230B126
	bl loc_023058B8	; 0230B128
	cmp r0,#0x0	; 0230B12C
	beq loc_0230B188	; 0230B12E
	add r0,r5,#0x0	; 0230B130
	add r0,#0xa	; 0230B132
	ldr r1,[sp,#0x0]	; 0230B134
	add r1,r1,#0x6	; 0230B136
	bl loc_023058B8	; 0230B138
	cmp r0,#0x0	; 0230B13C
	beq loc_0230B188	; 0230B13E
	ldr r0,[sp,#0x0]	; 0230B140
	ldrh r0,[r0,#0xc]	; 0230B142
	lsl r1,r0,#0x10	; 0230B144
	lsr r1,r1,#0x14	; 0230B146
	ldrh r2,[r5,#0x10]	; 0230B148
	lsl r2,r2,#0x10	; 0230B14A
	lsr r2,r2,#0x14	; 0230B14C
	cmp r1,r2	; 0230B14E
	bne loc_0230B188	; 0230B150
	ldr r2,[sp,#0x4]	; 0230B152
	ldr r1,[sp,#0x18]	; 0230B154
	add r1,r2,r1	; 0230B156
	ldrh r2,[r1,#0x10]	; 0230B158
	sub r0,r2,r0	; 0230B15A
	str r0,[sp,#0xc]	; 0230B15C
	ldr r0,[pool_0230B298]	; 0230B15E
	ldr r2,[sp,#0xc]	; 0230B160
	and r2,r0	; 0230B162
	cmp r2,#0x0	; 0230B164
	beq loc_0230B16A	; 0230B166
	b loc_0230B284	; 0230B168
loc_0230B16A:
	ldrh r2,[r1,#0x2]	; 0230B16A
	ldr r1,[sp,#0xc]	; 0230B16C
	str r1,[sp,#0x10]	; 0230B16E
	mul r1,r2	; 0230B170
	str r1,[sp,#0x10]	; 0230B172
	ldrh r2,[r6,#0x8]	; 0230B174
	sub r1,r2,r1	; 0230B176
	str r1,[sp,#0x14]	; 0230B178
	cmp r1,#0x0	; 0230B17A
	bne loc_0230B180	; 0230B17C
	b loc_0230B284	; 0230B17E
loc_0230B180:
	and r1,r0	; 0230B180
	cmp r1,#0x0	; 0230B182
	beq loc_0230B18E	; 0230B184
	b loc_0230B284	; 0230B186
loc_0230B188:
	add r4,r4,#0x1	; 0230B188
loc_0230B18A:
	cmp r4,#0x3	; 0230B18A
	bcc loc_0230B10C	; 0230B18C
loc_0230B18E:
	cmp r4,#0x3	; 0230B18E
	beq loc_0230B284	; 0230B190
	mov r0,#0x18	; 0230B192
	mul r4,r0	; 0230B194
	ldr r0,[sp,#0x4]	; 0230B196
	add r0,r0,r4	; 0230B198
	ldr r5,[r0,#0x14]	; 0230B19A
	add r5,#0x10	; 0230B19C
	ldrh r1,[r5,#0x10]	; 0230B19E
	ldr r0,[sp,#0x14]	; 0230B1A0
	add r0,r1,r0	; 0230B1A2
	str r0,[sp,#0x8]	; 0230B1A4
	ldr r2,[pool_0230B29C]	; 0230B1A6
	cmp r0,r2	; 0230B1A8
	bls loc_0230B1C0	; 0230B1AA
	add r7,#0xc	; 0230B1AC
	add r0,r7,#0x0	; 0230B1AE
	sub r5,#0x10	; 0230B1B0
	add r1,r5,#0x0	; 0230B1B2
	bl loc_02304C3C	; 0230B1B4
	mov r1,#0x0	; 0230B1B8
	ldr r0,[sp,#0x4]	; 0230B1BA
	strh r1,[r0,r4]	; 0230B1BC
	b loc_0230B284	; 0230B1BE
loc_0230B1C0:
	add r2,r6,#0x0	; 0230B1C0
	add r2,#0x24	; 0230B1C2
	ldr r0,[sp,#0x10]	; 0230B1C4
	add r0,r2,r0	; 0230B1C6
	add r2,r5,#0x0	; 0230B1C8
	add r2,#0x2c	; 0230B1CA
	add r1,r2,r1	; 0230B1CC
	ldr r2,[sp,#0x14]	; 0230B1CE
	add r2,r2,#0x1	; 0230B1D0
	bl loc_0230B2A8	; 0230B1D2
	ldr r0,[sp,#0x8]	; 0230B1D6
	strh r0,[r5,#0x10]	; 0230B1D8
	ldrh r0,[r6,#0x0]	; 0230B1DA
	mov r1,#0xf0	; 0230B1DC
	and r0,r1	; 0230B1DE
	mov r1,#0x10	; 0230B1E0
	bl loc_0230B2B4	; 0230B1E2
	add r2,r0,#0x0	; 0230B1E6
	ldr r0,[sp,#0x4]	; 0230B1E8
	add r1,r0,r4	; 0230B1EA
	ldrh r4,[r1,#0x10]	; 0230B1EC
	add r0,r4,#0x0	; 0230B1EE
	mov r3,#0xf	; 0230B1F0
	bic r0,r3	; 0230B1F2
	lsl r3,r4,#0x1c	; 0230B1F4
	lsr r4,r3,#0x1c	; 0230B1F6
	ldr r3,[sp,#0xc]	; 0230B1F8
	sub r3,r2,r3	; 0230B1FA
	add r3,r4,r3	; 0230B1FC
	lsl r3,r3,#0x10	; 0230B1FE
	lsr r4,r3,#0x10	; 0230B200
	mov r3,#0xf	; 0230B202
	and r4,r3	; 0230B204
	orr r0,r4	; 0230B206
	strh r0,[r1,#0x10]	; 0230B208
	ldr r0,[pool_0230B28C]	; 0230B20A
	ldr r3,[r0,#0x0]	; 0230B20C
	ldr r0,[pool_0230B2A0]	; 0230B20E
	add r0,r3,r0	; 0230B210
	ldr r3,[r0,#0x0]	; 0230B212
	add r2,r3,r2	; 0230B214
	str r2,[r0,#0x0]	; 0230B216
	ldrh r2,[r6,#0x0]	; 0230B218
	ldr r0,[pool_0230B2A4]	; 0230B21A
	and r2,r0	; 0230B21C
	cmp r2,#0x0	; 0230B21E
	bne loc_0230B284	; 0230B220
	mov r0,#0x0	; 0230B222
	strh r0,[r1,#0x0]	; 0230B224
	ldrh r1,[r5,#0x8]	; 0230B226
	mov r0,#0xf0	; 0230B228
	bic r1,r0	; 0230B22A
	add r1,#0x10	; 0230B22C
	strh r1,[r5,#0x8]	; 0230B22E
	ldrh r0,[r5,#0x10]	; 0230B230
	add r0,#0x18	; 0230B232
	strh r0,[r5,#0x10]	; 0230B234
	ldrh r1,[r5,#0x8]	; 0230B236
	mov r0,#0xf	; 0230B238
	and r1,r0	; 0230B23A
	cmp r1,#0x0	; 0230B23C
	beq loc_0230B25E	; 0230B23E
	cmp r1,#0x8	; 0230B240
	bne loc_0230B278	; 0230B242
	add r0,r7,#0x0	; 0230B244
	add r0,#0xc	; 0230B246
	add r7,#0x48	; 0230B248
	add r1,r7,#0x0	; 0230B24A
	sub r5,#0x10	; 0230B24C
	add r2,r5,#0x0	; 0230B24E
	bl loc_023075CC	; 0230B250
	mov r0,#0x2	; 0230B254
	mov r1,#0x6	; 0230B256
	bl loc_02304BE8	; 0230B258
	b loc_0230B284	; 0230B25C
loc_0230B25E:
	add r0,r7,#0x0	; 0230B25E
	add r0,#0xc	; 0230B260
	add r7,#0x60	; 0230B262
	add r1,r7,#0x0	; 0230B264
	sub r5,#0x10	; 0230B266
	add r2,r5,#0x0	; 0230B268
	bl loc_023075CC	; 0230B26A
	mov r0,#0x1	; 0230B26E
	mov r1,#0x7	; 0230B270
	bl loc_02304BE8	; 0230B272
	b loc_0230B284	; 0230B276
loc_0230B278:
	add r7,#0xc	; 0230B278
	add r0,r7,#0x0	; 0230B27A
	sub r5,#0x10	; 0230B27C
	add r1,r5,#0x0	; 0230B27E
	bl loc_02304C3C	; 0230B280
loc_0230B284:
	add sp,#0x1c	; 0230B284
	pop {r4,r5,r6,r7}	; 0230B286
	pop {r3}	; 0230B288
	bx r3	; 0230B28A
pool_0230B28C:
loc_0230B28C:
	.word FirmwareWlWorkPointerSlot	; 0230B28C
pool_0230B290:
loc_0230B290:
	.word 0x00000150	; 0230B290
pool_0230B294:
loc_0230B294:
	.word 0x000004BC	; 0230B294
pool_0230B298:
loc_0230B298:
	.word 0x80000000	; 0230B298
pool_0230B29C:
loc_0230B29C:
	.word 0x000005E4	; 0230B29C
pool_0230B2A0:
loc_0230B2A0:
	.word 0x00000534	; 0230B2A0
pool_0230B2A4:
loc_0230B2A4:
	.word 0x00000100	; 0230B2A4

; ===== function loc_0230B2A8 =====
loc_0230B2A8:
	bx pc	; 0230B2A8
	.byte 0xC0, 0x46	; 0230B2AC
.arm

; ===== function loc_0230B2AC =====
loc_0230B2AC:
	ldr pc,[pool_0230B2B0]	; 0230B2AC
pool_0230B2B0:
loc_0230B2B0:
	.word P2_Entry_037FF334	; 0230B2B0
.thumb

; ===== function loc_0230B2B4 =====
loc_0230B2B4:
	bx pc	; 0230B2B4
	.byte 0xC0, 0x46	; 0230B2B8
.arm

; ===== function loc_0230B2B8 =====
loc_0230B2B8:
	ldr pc,[pool_0230B2BC]	; 0230B2B8
pool_0230B2BC:
loc_0230B2BC:
	.word P2_SignedDivMod	; 0230B2BC
.thumb

; ===== function loc_0230B2C0 =====
loc_0230B2C0:
	push {r4,r5,r6,r7,lr}	; 0230B2C0
	sub sp,#0x14	; 0230B2C2
	add r6,r0,#0x0	; 0230B2C4
	str r1,[sp,#0x0]	; 0230B2C6
	ldr r0,[pool_0230B448]	; 0230B2C8
	ldr r1,[r0,#0x0]	; 0230B2CA
	ldr r0,[pool_0230B44C]	; 0230B2CC
	add r5,r1,r0	; 0230B2CE
	mov r0,#0x0	; 0230B2D0
	str r0,[sp,#0x4]	; 0230B2D2
	mvn r4,r0	; 0230B2D4
	b loc_0230B39E	; 0230B2D6
loc_0230B2D8:
	ldr r1,[sp,#0x4]	; 0230B2D8
	str r1,[sp,#0x8]	; 0230B2DA
	mov r0,#0x18	; 0230B2DC
	mul r1,r0	; 0230B2DE
	str r1,[sp,#0x8]	; 0230B2E0
	add r7,r5,r1	; 0230B2E2
	lsl r0,r1,#0	; 0230B2E4
	ldrh r0,[r5,r0]	; 0230B2E6
	cmp r0,#0x0	; 0230B2E8
	beq loc_0230B396	; 0230B2EA
	add r0,r7,#0x4	; 0230B2EC
	ldr r1,[sp,#0x0]	; 0230B2EE
	bl loc_023058B8	; 0230B2F0
	cmp r0,#0x0	; 0230B2F4
	beq loc_0230B398	; 0230B2F6
	add r0,r7,#0x0	; 0230B2F8
	add r0,#0xa	; 0230B2FA
	ldr r1,[sp,#0x0]	; 0230B2FC
	add r1,r1,#0x6	; 0230B2FE
	bl loc_023058B8	; 0230B300
	cmp r0,#0x0	; 0230B304
	beq loc_0230B398	; 0230B306
	ldr r0,[sp,#0x0]	; 0230B308
	ldrh r0,[r0,#0xc]	; 0230B30A
	lsl r0,r0,#0x10	; 0230B30C
	lsr r0,r0,#0x14	; 0230B30E
	ldrh r1,[r7,#0x10]	; 0230B310
	lsl r1,r1,#0x10	; 0230B312
	lsr r1,r1,#0x14	; 0230B314
	cmp r0,r1	; 0230B316
	bne loc_0230B398	; 0230B318
	ldrh r0,[r6,#0x0]	; 0230B31A
	mov r1,#0xf0	; 0230B31C
	and r0,r1	; 0230B31E
	mov r1,#0x10	; 0230B320
	bl loc_0230B464	; 0230B322
	str r0,[sp,#0x10]	; 0230B326
	ldrh r0,[r7,#0x10]	; 0230B328
	lsl r0,r0,#0x1c	; 0230B32A
	lsr r1,r0,#0x1c	; 0230B32C
	ldr r0,[sp,#0x10]	; 0230B32E
	sub r1,r0,r1	; 0230B330
	cmp r1,#0x0	; 0230B332
	bne loc_0230B338	; 0230B334
	b loc_0230B440	; 0230B336
loc_0230B338:
	ldr r0,[pool_0230B450]	; 0230B338
	and r1,r0	; 0230B33A
	cmp r1,#0x0	; 0230B33C
	bne loc_0230B440	; 0230B33E
	ldr r1,[sp,#0x8]	; 0230B340
	add r1,r5,r1	; 0230B342
	ldr r4,[r1,#0x14]	; 0230B344
	add r4,#0x10	; 0230B346
	ldrh r1,[r4,#0x10]	; 0230B348
	ldrh r2,[r6,#0x8]	; 0230B34A
	sub r5,r2,r1	; 0230B34C
	sub r5,#0x18	; 0230B34E
	cmp r5,#0x0	; 0230B350
	beq loc_0230B440	; 0230B352
	add r2,r5,#0x0	; 0230B354
	and r2,r0	; 0230B356
	cmp r2,#0x0	; 0230B358
	bne loc_0230B440	; 0230B35A
	add r6,#0x24	; 0230B35C
	add r0,r6,r1	; 0230B35E
	add r2,r4,#0x0	; 0230B360
	add r2,#0x2c	; 0230B362
	add r1,r2,r1	; 0230B364
	add r2,r5,#0x0	; 0230B366
	bl loc_0230B470	; 0230B368
	ldrh r0,[r4,#0x10]	; 0230B36C
	add r0,r0,r5	; 0230B36E
	strh r0,[r4,#0x10]	; 0230B370
	ldrh r2,[r7,#0x10]	; 0230B372
	mov r1,#0xf	; 0230B374
	bic r2,r1	; 0230B376
	ldr r0,[sp,#0x10]	; 0230B378
	lsl r0,r0,#0x10	; 0230B37A
	lsr r0,r0,#0x10	; 0230B37C
	and r0,r1	; 0230B37E
	orr r2,r0	; 0230B380
	strh r2,[r7,#0x10]	; 0230B382
	ldr r0,[pool_0230B448]	; 0230B384
	ldr r1,[r0,#0x0]	; 0230B386
	ldr r0,[pool_0230B454]	; 0230B388
	add r1,r1,r0	; 0230B38A
	ldr r2,[r1,#0x0]	; 0230B38C
	ldr r0,[sp,#0x10]	; 0230B38E
	add r0,r2,r0	; 0230B390
	str r0,[r1,#0x0]	; 0230B392
	b loc_0230B440	; 0230B394
loc_0230B396:
	ldr r4,[sp,#0x4]	; 0230B396
loc_0230B398:
	ldr r0,[sp,#0x4]	; 0230B398
	add r0,r0,#0x1	; 0230B39A
	str r0,[sp,#0x4]	; 0230B39C
loc_0230B39E:
	ldr r0,[sp,#0x4]	; 0230B39E
	cmp r0,#0x3	; 0230B3A0
	bcc loc_0230B2D8	; 0230B3A2
	mov r0,#0x0	; 0230B3A4
	mvn r0,r0	; 0230B3A6
	cmp r4,r0	; 0230B3A8
	beq loc_0230B440	; 0230B3AA
	ldr r0,[pool_0230B448]	; 0230B3AC
	ldr r1,[r0,#0x0]	; 0230B3AE
	ldr r0,[pool_0230B458]	; 0230B3B0
	add r0,r1,r0	; 0230B3B2
	ldr r1,[pool_0230B45C]	; 0230B3B4
	bl loc_02304D60	; 0230B3B6
	add r7,r0,#0x0	; 0230B3BA
	cmp r7,#0x0	; 0230B3BC
	beq loc_0230B43A	; 0230B3BE
	mov r0,#0x18	; 0230B3C0
	mul r4,r0	; 0230B3C2
	add r0,r5,r4	; 0230B3C4
	str r0,[sp,#0xc]	; 0230B3C6
	ldr r0,[sp,#0x0]	; 0230B3C8
	ldr r1,[sp,#0xc]	; 0230B3CA
	add r1,r1,#0x4	; 0230B3CC
	mov r2,#0x10	; 0230B3CE
	bl loc_0230B47C	; 0230B3D0
	mov r0,#0x5	; 0230B3D4
	strh r0,[r5,r4]	; 0230B3D6
	add r0,r5,r4	; 0230B3D8
	str r7,[r0,#0x14]	; 0230B3DA
	add r7,#0x10	; 0230B3DC
	add r0,r6,#0x0	; 0230B3DE
	add r1,r7,#0x0	; 0230B3E0
	add r1,#0x8	; 0230B3E2
	ldrh r2,[r6,#0x8]	; 0230B3E4
	add r2,#0xc	; 0230B3E6
	bl loc_0230B488	; 0230B3E8
	ldr r0,[pool_0230B448]	; 0230B3EC
	ldr r1,[r0,#0x0]	; 0230B3EE
	ldr r0,[pool_0230B460]	; 0230B3F0
	ldr r0,[r1,r0]	; 0230B3F2
	bl loc_0230B494	; 0230B3F4
	ldrh r0,[r7,#0x8]	; 0230B3F8
	mov r1,#0xf0	; 0230B3FA
	and r0,r1	; 0230B3FC
	mov r1,#0x10	; 0230B3FE
	bl loc_0230B4A4	; 0230B400
	add r1,r0,#0x0	; 0230B404
	ldr r0,[sp,#0xc]	; 0230B406
	ldrh r0,[r0,#0x10]	; 0230B408
	mov r3,#0xf	; 0230B40A
	bic r0,r3	; 0230B40C
	lsl r2,r1,#0x10	; 0230B40E
	lsr r2,r2,#0x10	; 0230B410
	and r2,r3	; 0230B412
	orr r0,r2	; 0230B414
	ldr r2,[sp,#0xc]	; 0230B416
	strh r0,[r2,#0x10]	; 0230B418
	ldr r0,[pool_0230B448]	; 0230B41A
	ldr r2,[r0,#0x0]	; 0230B41C
	ldr r0,[pool_0230B454]	; 0230B41E
	add r0,r2,r0	; 0230B420
	ldr r2,[r0,#0x0]	; 0230B422
	add r2,r2,r1	; 0230B424
	str r2,[r0,#0x0]	; 0230B426
	ldrh r0,[r6,#0x8]	; 0230B428
	sub r0,#0x18	; 0230B42A
	strh r0,[r7,#0x10]	; 0230B42C
	ldrh r0,[r7,#0x10]	; 0230B42E
	bl loc_0230B4B0	; 0230B430
	add r1,r5,r4	; 0230B434
	strh r0,[r1,#0x2]	; 0230B436
	b loc_0230B440	; 0230B438
loc_0230B43A:
	mov r0,#0x4	; 0230B43A
	bl loc_02304F18	; 0230B43C
loc_0230B440:
	add sp,#0x14	; 0230B440
	pop {r4,r5,r6,r7}	; 0230B442
	pop {r3}	; 0230B444
	bx r3	; 0230B446
pool_0230B448:
loc_0230B448:
	.word FirmwareWlWorkPointerSlot	; 0230B448
pool_0230B44C:
loc_0230B44C:
	.word 0x000004BC	; 0230B44C
pool_0230B450:
loc_0230B450:
	.word 0x80000000	; 0230B450
pool_0230B454:
loc_0230B454:
	.word 0x00000534	; 0230B454
pool_0230B458:
loc_0230B458:
	.word 0x0000015C	; 0230B458
pool_0230B45C:
loc_0230B45C:
	.word 0x00000622	; 0230B45C
pool_0230B460:
loc_0230B460:
	.word 0x000002E0	; 0230B460

; ===== function loc_0230B464 =====
loc_0230B464:
	bx pc	; 0230B464
	.byte 0xC0, 0x46	; 0230B468
.arm

; ===== function loc_0230B468 =====
loc_0230B468:
	ldr pc,[pool_0230B46C]	; 0230B468
pool_0230B46C:
loc_0230B46C:
	.word P2_SignedDivMod	; 0230B46C
.thumb

; ===== function loc_0230B470 =====
loc_0230B470:
	bx pc	; 0230B470
	.byte 0xC0, 0x46	; 0230B474
.arm

; ===== function loc_0230B474 =====
loc_0230B474:
	ldr pc,[pool_0230B478]	; 0230B474
pool_0230B478:
loc_0230B478:
	.word P2_Entry_037FF334	; 0230B478
.thumb

; ===== function loc_0230B47C =====
loc_0230B47C:
	bx pc	; 0230B47C
	.byte 0xC0, 0x46	; 0230B480
.arm

; ===== function loc_0230B480 =====
loc_0230B480:
	ldr pc,[pool_0230B484]	; 0230B480
pool_0230B484:
loc_0230B484:
	.word P2_Entry_037FF334	; 0230B484
.thumb

; ===== function loc_0230B488 =====
loc_0230B488:
	bx pc	; 0230B488
	.byte 0xC0, 0x46	; 0230B48C
.arm

; ===== function loc_0230B48C =====
loc_0230B48C:
	ldr pc,[pool_0230B490]	; 0230B48C
pool_0230B490:
loc_0230B490:
	.word P2_Entry_037FF334	; 0230B490
.thumb

; ===== function loc_0230B494 =====
loc_0230B494:
	bx pc	; 0230B494
	.byte 0xC0, 0x46	; 0230B498
.arm

; ===== function loc_0230B498 =====
loc_0230B498:
	ldr r12,[pool_0230B4A0]	; 0230B498
	bx r12	; 0230B49C
pool_0230B4A0:
loc_0230B4A0:
	.word P2_Entry_037FF224 + 1	; 0230B4A0
.thumb

; ===== function loc_0230B4A4 =====
loc_0230B4A4:
	bx pc	; 0230B4A4
	.byte 0xC0, 0x46	; 0230B4A8
.arm

; ===== function loc_0230B4A8 =====
loc_0230B4A8:
	ldr pc,[pool_0230B4AC]	; 0230B4A8
pool_0230B4AC:
loc_0230B4AC:
	.word P2_SignedDivMod	; 0230B4AC
.thumb

; ===== function loc_0230B4B0 =====
loc_0230B4B0:
	bx pc	; 0230B4B0
	.byte 0xC0, 0x46	; 0230B4B4
.arm

; ===== function loc_0230B4B4 =====
loc_0230B4B4:
	ldr pc,[pool_0230B4B8]	; 0230B4B4
pool_0230B4B8:
loc_0230B4B8:
	.word loc_03804DB0	; 0230B4B8
.thumb

; ===== function loc_0230B4BC =====
	push {r4,r5,r6,r7,lr}	; 0230B4BC
	sub sp,#0x14	; 0230B4BE
	ldr r0,[pool_0230B594]	; 0230B4C0
	ldr r0,[r0,#0x0]	; 0230B4C2
	ldr r1,[pool_0230B598]	; 0230B4C4
	add r5,r0,r1	; 0230B4C6
	ldr r6,[r5,#0x6c]	; 0230B4C8
	mov r1,#0x0	; 0230B4CA
	mvn r1,r1	; 0230B4CC
	cmp r6,r1	; 0230B4CE
	beq loc_0230B58A	; 0230B4D0
	add r4,r6,#0x0	; 0230B4D2
	add r4,#0x10	; 0230B4D4
	ldr r1,[pool_0230B59C]	; 0230B4D6
	ldrh r0,[r0,r1]	; 0230B4D8
	cmp r0,#0x40	; 0230B4DA
	bne loc_0230B570	; 0230B4DC
	ldrh r1,[r4,#0x10]	; 0230B4DE
	ldr r0,[pool_0230B5A0]	; 0230B4E0
	cmp r1,r0	; 0230B4E2
	bhi loc_0230B570	; 0230B4E4
	ldrh r7,[r4,#0x14]	; 0230B4E6
	ldr r0,[pool_0230B5A4]	; 0230B4E8
	add r1,r7,#0x0	; 0230B4EA
	and r1,r0	; 0230B4EC
	cmp r1,#0x0	; 0230B4EE
	beq loc_0230B514	; 0230B4F0
	add r0,sp,#0x0	; 0230B4F2
	add r1,r4,#0x0	; 0230B4F4
	add r1,#0x24	; 0230B4F6
	bl loc_02305B7C	; 0230B4F8
	ldr r0,[pool_0230B5A8]	; 0230B4FC
	add r1,r7,#0x0	; 0230B4FE
	and r1,r0	; 0230B500
	cmp r1,#0x0	; 0230B502
	bne loc_0230B570	; 0230B504
	add r0,sp,#0x4	; 0230B506
	add r0,#0x2	; 0230B508
	add r1,r4,#0x0	; 0230B50A
	add r1,#0x1e	; 0230B50C
	bl loc_02305B7C	; 0230B50E
	b loc_0230B542	; 0230B512
loc_0230B514:
	add r0,sp,#0x0	; 0230B514
	add r1,r4,#0x0	; 0230B516
	add r1,#0x18	; 0230B518
	bl loc_02305B7C	; 0230B51A
	ldr r0,[pool_0230B5A8]	; 0230B51E
	add r1,r7,#0x0	; 0230B520
	and r1,r0	; 0230B522
	cmp r1,#0x0	; 0230B524
	beq loc_0230B536	; 0230B526
	add r0,sp,#0x4	; 0230B528
	add r0,#0x2	; 0230B52A
	add r1,r4,#0x0	; 0230B52C
	add r1,#0x24	; 0230B52E
	bl loc_02305B7C	; 0230B530
	b loc_0230B542	; 0230B534
loc_0230B536:
	add r0,sp,#0x4	; 0230B536
	add r0,#0x2	; 0230B538
	add r1,r4,#0x0	; 0230B53A
	add r1,#0x1e	; 0230B53C
	bl loc_02305B7C	; 0230B53E
loc_0230B542:
	ldrh r1,[r4,#0x2a]	; 0230B542
	add r0,sp,#0x0	; 0230B544
	strh r1,[r0,#0xc]	; 0230B546
	ldr r0,[pool_0230B5AC]	; 0230B548
	and r7,r0	; 0230B54A
	cmp r7,#0x0	; 0230B54C
	beq loc_0230B566	; 0230B54E
	ldrh r0,[r4,#0x2a]	; 0230B550
	lsl r0,r0,#0x1c	; 0230B552
	lsr r0,r0,#0x1c	; 0230B554
	cmp r0,#0x0	; 0230B556
	bne loc_0230B566	; 0230B558
	add r4,#0x8	; 0230B55A
	add r0,r4,#0x0	; 0230B55C
	add r1,sp,#0x0	; 0230B55E
	bl loc_0230B2C0	; 0230B560
	b loc_0230B570	; 0230B564
loc_0230B566:
	add r4,#0x8	; 0230B566
	add r0,r4,#0x0	; 0230B568
	add r1,sp,#0x0	; 0230B56A
	bl loc_0230B0EC	; 0230B56C
loc_0230B570:
	add r0,r5,#0x0	; 0230B570
	add r0,#0x6c	; 0230B572
	add r1,r6,#0x0	; 0230B574
	bl loc_02304C3C	; 0230B576
	add r5,#0x74	; 0230B57A
	ldrh r0,[r5,#0x0]	; 0230B57C
	cmp r0,#0x0	; 0230B57E
	beq loc_0230B58A	; 0230B580
	mov r0,#0x2	; 0230B582
	mov r1,#0x9	; 0230B584
	bl loc_02304BE8	; 0230B586
loc_0230B58A:
	add sp,#0x14	; 0230B58A
	pop {r4,r5,r6,r7}	; 0230B58C
	pop {r3}	; 0230B58E
	bx r3	; 0230B590
	.byte 0xC0, 0x46	; 0230B594
pool_0230B594:
loc_0230B594:
	.word FirmwareWlWorkPointerSlot	; 0230B594
pool_0230B598:
loc_0230B598:
	.word 0x00000150	; 0230B598
pool_0230B59C:
loc_0230B59C:
	.word 0x00000320	; 0230B59C
pool_0230B5A0:
loc_0230B5A0:
	.word 0x000005FC	; 0230B5A0
pool_0230B5A4:
loc_0230B5A4:
	.word 0x00000100	; 0230B5A4
pool_0230B5A8:
loc_0230B5A8:
	.word 0x00000200	; 0230B5A8
pool_0230B5AC:
loc_0230B5AC:
	.word 0x00000400	; 0230B5AC

; ===== function loc_0230B5B0 =====
loc_0230B5B0:
	push {r4,r5,r6,r7,lr}	; 0230B5B0
	sub sp,#0x4	; 0230B5B2
	add r5,r0,#0x0	; 0230B5B4
	ldrh r0,[r5,#0x2]	; 0230B5B6
	bl loc_02307234	; 0230B5B8
	bl loc_02305148	; 0230B5BC
	add r4,r5,#0x0	; 0230B5C0
	add r4,#0x34	; 0230B5C2
	add r5,#0x33	; 0230B5C4
	add r0,r5,#0x0	; 0230B5C6
	bl loc_02305180	; 0230B5C8
	add r6,r0,#0x0	; 0230B5CC
	mov r5,#0x0	; 0230B5CE
	lsr r7,r6,#0x1	; 0230B5D0
	b loc_0230B5E6	; 0230B5D2
loc_0230B5D4:
	bl loc_02305128	; 0230B5D4
	ldrh r1,[r4,#0x0]	; 0230B5D8
	add r4,r4,#0x2	; 0230B5DA
	cmp r1,r0	; 0230B5DC
	beq loc_0230B5E4	; 0230B5DE
	mov r0,#0x0	; 0230B5E0
	b loc_0230B608	; 0230B5E2
loc_0230B5E4:
	add r5,r5,#0x1	; 0230B5E4
loc_0230B5E6:
	cmp r5,r7	; 0230B5E6
	bcc loc_0230B5D4	; 0230B5E8
	mov r0,#0x1	; 0230B5EA
	and r6,r0	; 0230B5EC
	cmp r6,#0x0	; 0230B5EE
	beq loc_0230B606	; 0230B5F0
	bl loc_02305128	; 0230B5F2
	ldrh r2,[r4,#0x0]	; 0230B5F6
	mov r1,#0xff	; 0230B5F8
	and r2,r1	; 0230B5FA
	and r0,r1	; 0230B5FC
	cmp r2,r0	; 0230B5FE
	beq loc_0230B606	; 0230B600
	mov r0,#0x0	; 0230B602
	b loc_0230B608	; 0230B604
loc_0230B606:
	mov r0,#0x1	; 0230B606
loc_0230B608:
	add sp,#0x4	; 0230B608
	pop {r4,r5,r6,r7}	; 0230B60A
	pop {r3}	; 0230B60C
	bx r3	; 0230B60E

; ===== function loc_0230B610 =====
loc_0230B610:
	push {r4,r5,r6,lr}	; 0230B610
	add r6,r0,#0x0	; 0230B612
	add r5,r1,#0x0	; 0230B614
	ldr r0,[pool_0230B660]	; 0230B616
	ldrh r1,[r0,#0x0]	; 0230B618
	ldrh r0,[r0,#0x0]	; 0230B61A
	lsl r0,r0,#0x8	; 0230B61C
	add r0,r1,r0	; 0230B61E
	lsl r0,r0,#0x10	; 0230B620
	lsr r4,r0,#0x10	; 0230B622
	cmp r4,#0x0	; 0230B624
	bne loc_0230B62A	; 0230B626
	mov r4,#0x1	; 0230B628
loc_0230B62A:
	add r0,r4,#0x0	; 0230B62A
	bl loc_02305148	; 0230B62C
	add r0,r6,#0x0	; 0230B630
	add r1,r4,#0x0	; 0230B632
	bl loc_0230737C	; 0230B634
	add r4,r5,#0x0	; 0230B638
	add r4,#0x34	; 0230B63A
	add r5,#0x33	; 0230B63C
	add r0,r5,#0x0	; 0230B63E
	bl loc_02305180	; 0230B640
	add r6,r0,#0x0	; 0230B644
	mov r5,#0x0	; 0230B646
	b loc_0230B654	; 0230B648
loc_0230B64A:
	bl loc_02305128	; 0230B64A
	strh r0,[r4,#0x0]	; 0230B64E
	add r4,r4,#0x2	; 0230B650
	add r5,r5,#0x2	; 0230B652
loc_0230B654:
	cmp r5,r6	; 0230B654
	bcc loc_0230B64A	; 0230B656
	pop {r4,r5,r6}	; 0230B658
	pop {r3}	; 0230B65A
	bx r3	; 0230B65C
	.byte 0xC0, 0x46	; 0230B660
pool_0230B660:
loc_0230B660:
	.word REG_WIFI_RANDOM	; 0230B660

; ===== function loc_0230B664 =====
	push {r4,r5,r6,r7,lr}	; 0230B664
	sub sp,#0x1c	; 0230B666
	ldr r0,[pool_0230B898]	; 0230B668
	ldr r1,[r0,#0x0]	; 0230B66A
	ldr r0,[pool_0230B89C]	; 0230B66C
	add r0,r1,r0	; 0230B66E
	str r0,[sp,#0x0]	; 0230B670
	ldr r0,[pool_0230B8A0]	; 0230B672
	add r6,r1,r0	; 0230B674
	ldr r0,[pool_0230B8A4]	; 0230B676
	ldrh r0,[r1,r0]	; 0230B678
	str r0,[sp,#0x4]	; 0230B67A
	ldr r0,[sp,#0x0]	; 0230B67C
	ldr r0,[r0,#0x60]	; 0230B67E
	str r0,[sp,#0x8]	; 0230B680
	mov r0,#0x0	; 0230B682
	mvn r1,r0	; 0230B684
	ldr r0,[sp,#0x8]	; 0230B686
	cmp r0,r1	; 0230B688
	bne loc_0230B68E	; 0230B68A
	b loc_0230B88E	; 0230B68C
loc_0230B68E:
	lsl r4,r0,#0	; 0230B68E
	add r4,#0x10	; 0230B690
	add r0,r4,#0x0	; 0230B692
	str r0,[sp,#0xc]	; 0230B694
	add r0,#0x14	; 0230B696
	str r0,[sp,#0xc]	; 0230B698
	ldrh r1,[r4,#0x18]	; 0230B69A
	mov r0,#0x1	; 0230B69C
	and r1,r0	; 0230B69E
	cmp r1,#0x0	; 0230B6A0
	beq loc_0230B6AC	; 0230B6A2
	ldr r0,[r6,#0x2c]	; 0230B6A4
	add r0,r0,#0x1	; 0230B6A6
	str r0,[r6,#0x2c]	; 0230B6A8
	b loc_0230B6B2	; 0230B6AA
loc_0230B6AC:
	ldr r0,[r6,#0x28]	; 0230B6AC
	add r0,r0,#0x1	; 0230B6AE
	str r0,[r6,#0x28]	; 0230B6B0
loc_0230B6B2:
	ldrh r0,[r4,#0x8]	; 0230B6B2
	mov r1,#0xf0	; 0230B6B4
	and r0,r1	; 0230B6B6
	mov r1,#0x10	; 0230B6B8
	bl loc_0230B8A8	; 0230B6BA
	ldr r1,[r6,#0x24]	; 0230B6BE
	sub r0,r0,#0x1	; 0230B6C0
	add r0,r1,r0	; 0230B6C2
	str r0,[r6,#0x24]	; 0230B6C4
	ldr r0,[sp,#0xc]	; 0230B6C6
	ldrh r0,[r0,#0x0]	; 0230B6C8
	lsl r1,r0,#0x1c	; 0230B6CA
	lsr r7,r1,#0x1e	; 0230B6CC
	lsl r0,r0,#0x18	; 0230B6CE
	lsr r5,r0,#0x1c	; 0230B6D0
	ldr r0,[sp,#0xc]	; 0230B6D2
	add r0,#0xa	; 0230B6D4
	bl loc_023075DC	; 0230B6D6
	str r0,[sp,#0x10]	; 0230B6DA
	lsl r0,r0,#0x10	; 0230B6DC
	lsr r0,r0,#0x10	; 0230B6DE
	strh r0,[r4,#0x2]	; 0230B6E0
	ldr r1,[sp,#0x10]	; 0230B6E2
	cmp r1,#0xff	; 0230B6E4
	bne loc_0230B720	; 0230B6E6
	mov r0,#0x0	; 0230B6E8
	strh r0,[r4,#0x2]	; 0230B6EA
	ldr r0,[sp,#0x4]	; 0230B6EC
	cmp r0,#0x1	; 0230B6EE
	beq loc_0230B6F4	; 0230B6F0
	b loc_0230B870	; 0230B6F2
loc_0230B6F4:
	cmp r7,#0x0	; 0230B6F4
	beq loc_0230B6FA	; 0230B6F6
	b loc_0230B870	; 0230B6F8
loc_0230B6FA:
	cmp r5,#0x0	; 0230B6FA
	beq loc_0230B718	; 0230B6FC
	cmp r5,#0x4	; 0230B6FE
	beq loc_0230B710	; 0230B700
	cmp r5,#0xb	; 0230B702
	beq loc_0230B708	; 0230B704
	b loc_0230B870	; 0230B706
loc_0230B708:
	add r0,r4,#0x0	; 0230B708
	bl loc_0230BBC8	; 0230B70A
	b loc_0230B870	; 0230B70E
loc_0230B710:
	add r0,r4,#0x0	; 0230B710
	bl loc_0230C1B8	; 0230B712
	b loc_0230B870	; 0230B716
loc_0230B718:
	add r0,r4,#0x0	; 0230B718
	bl loc_0230C4F8	; 0230B71A
	b loc_0230B870	; 0230B71E
loc_0230B720:
	ldrh r2,[r4,#0x12]	; 0230B720
	mov r1,#0xff	; 0230B722
	and r2,r1	; 0230B724
	lsl r1,r2,#0x10	; 0230B726
	lsr r1,r1,#0x10	; 0230B728
	bl loc_0230744C	; 0230B72A
	cmp r7,#0x0	; 0230B72E
	bne loc_0230B750	; 0230B730
	ldrh r0,[r4,#0x2a]	; 0230B732
	str r0,[sp,#0x14]	; 0230B734
	ldr r0,[sp,#0x10]	; 0230B736
	bl loc_02307224	; 0230B738
	ldr r1,[sp,#0x14]	; 0230B73C
	cmp r1,r0	; 0230B73E
	bne loc_0230B74A	; 0230B740
	ldr r0,[r6,#0x3c]	; 0230B742
	add r0,r0,#0x1	; 0230B744
	str r0,[r6,#0x3c]	; 0230B746
	b loc_0230B870	; 0230B748
loc_0230B74A:
	ldr r0,[sp,#0x10]	; 0230B74A
	bl loc_0230738C	; 0230B74C
loc_0230B750:
	ldr r0,[sp,#0x4]	; 0230B750
	cmp r0,#0x1	; 0230B752
	beq loc_0230B760	; 0230B754
	cmp r0,#0x2	; 0230B756
	beq loc_0230B7F4	; 0230B758
	cmp r0,#0x3	; 0230B75A
	beq loc_0230B7F4	; 0230B75C
	b loc_0230B870	; 0230B75E
loc_0230B760:
	ldr r0,[sp,#0x10]	; 0230B760
	lsl r0,r0,#0x10	; 0230B762
	lsr r0,r0,#0x10	; 0230B764
	ldr r1,[sp,#0xc]	; 0230B766
	ldrh r1,[r1,#0x0]	; 0230B768
	lsl r1,r1,#0x13	; 0230B76A
	lsr r1,r1,#0x1f	; 0230B76C
	bl loc_02307404	; 0230B76E
	cmp r7,#0x0	; 0230B772
	bne loc_0230B7E4	; 0230B774
	cmp r5,#0xc	; 0230B776
	bhi loc_0230B870	; 0230B778
	add r0,r5,r5	; 0230B77A
P4_SwitchIndexPC_0230B77A:
	add r0,pc	; 0230B77C
	ldrh r0,[r0,#(P4_SwitchTable_0230B77A - (P4_SwitchIndexPC_0230B77A + 4))]	; 0230B77E
	lsl r0,r0,#0x10	; 0230B780
	asr r0,r0,#0x10	; 0230B782
P4_SwitchTargetPC_0230B77A:
	add r0,pc	; 0230B784
	bx r0	; 0230B786
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230B77A:
	.halfword (loc_0230B7AA + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B7B2 + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B7BA + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B7C2 + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B7A2 + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B7CC + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B7D4 + 1) - (P4_SwitchTargetPC_0230B77A + 4)
	.halfword (loc_0230B7DC + 1) - (P4_SwitchTargetPC_0230B77A + 4)
P4_SwitchTable_0230B77AEnd:
loc_0230B7A2:
	add r0,r4,#0x0	; 0230B7A2
	bl loc_0230C6C4	; 0230B7A4
	b loc_0230B870	; 0230B7A8
loc_0230B7AA:
	add r0,r4,#0x0	; 0230B7AA
	bl loc_0230C4F8	; 0230B7AC
	b loc_0230B870	; 0230B7B0
loc_0230B7B2:
	add r0,r4,#0x0	; 0230B7B2
	bl loc_0230C31C	; 0230B7B4
	b loc_0230B870	; 0230B7B8
loc_0230B7BA:
	add r0,r4,#0x0	; 0230B7BA
	bl loc_0230C1B8	; 0230B7BC
	b loc_0230B870	; 0230B7C0
loc_0230B7C2:
	add r0,r4,#0x0	; 0230B7C2
	mov r1,#0x0	; 0230B7C4
	bl loc_0230BF5C	; 0230B7C6
	b loc_0230B870	; 0230B7CA
loc_0230B7CC:
	add r0,r4,#0x0	; 0230B7CC
	bl loc_0230C620	; 0230B7CE
	b loc_0230B870	; 0230B7D2
loc_0230B7D4:
	add r0,r4,#0x0	; 0230B7D4
	bl loc_0230BBC8	; 0230B7D6
	b loc_0230B870	; 0230B7DA
loc_0230B7DC:
	add r0,r4,#0x0	; 0230B7DC
	bl loc_0230BB48	; 0230B7DE
	b loc_0230B870	; 0230B7E2
loc_0230B7E4:
	cmp r7,#0x1	; 0230B7E4
	bne loc_0230B870	; 0230B7E6
	cmp r5,#0xa	; 0230B7E8
	bne loc_0230B870	; 0230B7EA
	add r0,r4,#0x0	; 0230B7EC
	bl loc_0230BB00	; 0230B7EE
	b loc_0230B870	; 0230B7F2
loc_0230B7F4:
	cmp r7,#0x0	; 0230B7F4
	bne loc_0230B85E	; 0230B7F6
	cmp r5,#0xc	; 0230B7F8
	bhi loc_0230B870	; 0230B7FA
	add r0,r5,r5	; 0230B7FC
P4_SwitchIndexPC_0230B7FC:
	add r0,pc	; 0230B7FE
	ldrh r0,[r0,#(P4_SwitchTable_0230B7FC - (P4_SwitchIndexPC_0230B7FC + 4))]	; 0230B800
	lsl r0,r0,#0x10	; 0230B802
	asr r0,r0,#0x10	; 0230B804
P4_SwitchTargetPC_0230B7FC:
	add r0,pc	; 0230B806
	bx r0	; 0230B808
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230B7FC:
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B82C + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B834 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B83C + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B824 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B870 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B846 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B84E + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
	.halfword (loc_0230B856 + 1) - (P4_SwitchTargetPC_0230B7FC + 4)
P4_SwitchTable_0230B7FCEnd:
loc_0230B824:
	add r0,r4,#0x0	; 0230B824
	bl loc_0230C6C4	; 0230B826
	b loc_0230B870	; 0230B82A
loc_0230B82C:
	add r0,r4,#0x0	; 0230B82C
	bl loc_0230C428	; 0230B82E
	b loc_0230B870	; 0230B832
loc_0230B834:
	add r0,r4,#0x0	; 0230B834
	bl loc_0230C248	; 0230B836
	b loc_0230B870	; 0230B83A
loc_0230B83C:
	add r0,r4,#0x0	; 0230B83C
	mov r1,#0x0	; 0230B83E
	bl loc_0230BF5C	; 0230B840
	b loc_0230B870	; 0230B844
loc_0230B846:
	add r0,r4,#0x0	; 0230B846
	bl loc_0230C620	; 0230B848
	b loc_0230B870	; 0230B84C
loc_0230B84E:
	add r0,r4,#0x0	; 0230B84E
	bl loc_0230BBC8	; 0230B850
	b loc_0230B870	; 0230B854
loc_0230B856:
	add r0,r4,#0x0	; 0230B856
	bl loc_0230BB48	; 0230B858
	b loc_0230B870	; 0230B85C
loc_0230B85E:
	cmp r7,#0x1	; 0230B85E
	bne loc_0230B870	; 0230B860
	cmp r5,#0xe	; 0230B862
	beq loc_0230B86A	; 0230B864
	cmp r5,#0xf	; 0230B866
	bne loc_0230B870	; 0230B868
loc_0230B86A:
	add r0,r4,#0x0	; 0230B86A
	bl loc_0230BAFC	; 0230B86C
loc_0230B870:
	ldr r0,[sp,#0x0]	; 0230B870
	add r0,#0x60	; 0230B872
	ldr r1,[sp,#0x8]	; 0230B874
	bl loc_02304C3C	; 0230B876
	ldr r0,[sp,#0x0]	; 0230B87A
	add r0,#0x68	; 0230B87C
	str r0,[sp,#0x0]	; 0230B87E
	ldrh r0,[r0,#0x0]	; 0230B880
	cmp r0,#0x0	; 0230B882
	beq loc_0230B88E	; 0230B884
	mov r0,#0x1	; 0230B886
	mov r1,#0x7	; 0230B888
	bl loc_02304BE8	; 0230B88A
loc_0230B88E:
	add sp,#0x1c	; 0230B88E
	pop {r4,r5,r6,r7}	; 0230B890
	pop {r3}	; 0230B892
	bx r3	; 0230B894
	.byte 0xC0, 0x46	; 0230B898
pool_0230B898:
loc_0230B898:
	.word FirmwareWlWorkPointerSlot	; 0230B898
pool_0230B89C:
loc_0230B89C:
	.word 0x00000150	; 0230B89C
pool_0230B8A0:
loc_0230B8A0:
	.word 0x00000510	; 0230B8A0
pool_0230B8A4:
loc_0230B8A4:
	.word 0x00000324	; 0230B8A4

; ===== function loc_0230B8A8 =====
loc_0230B8A8:
	bx pc	; 0230B8A8
	.byte 0xC0, 0x46	; 0230B8AC
.arm

; ===== function loc_0230B8AC =====
loc_0230B8AC:
	ldr pc,[pool_0230B8B0]	; 0230B8AC
pool_0230B8B0:
loc_0230B8B0:
	.word P2_SignedDivMod	; 0230B8B0
.thumb

; ===== function loc_0230B8B4 =====
loc_0230B8B4:
	push {r4,r5,r6,r7,lr}	; 0230B8B4
	sub sp,#0xc	; 0230B8B6
	add r4,r0,#0x0	; 0230B8B8
	ldr r0,[pool_0230BADC]	; 0230B8BA
	ldr r1,[r0,#0x0]	; 0230B8BC
	ldr r0,[pool_0230BAE0]	; 0230B8BE
	add r0,r1,r0	; 0230B8C0
	str r0,[sp,#0x0]	; 0230B8C2
	ldr r5,[r4,#0x0]	; 0230B8C4
	add r0,#0x7a	; 0230B8C6
	ldrh r0,[r0,#0x0]	; 0230B8C8
	strh r0,[r4,#0x12]	; 0230B8CA
	ldrh r1,[r4,#0xc]	; 0230B8CC
	ldr r0,[pool_0230BAE4]	; 0230B8CE
	and r1,r0	; 0230B8D0
	cmp r1,#0x0	; 0230B8D2
	beq loc_0230B8DE	; 0230B8D4
	ldrh r1,[r4,#0xa]	; 0230B8D6
	mov r0,#0x1	; 0230B8D8
	orr r1,r0	; 0230B8DA
	strh r1,[r4,#0xa]	; 0230B8DC
loc_0230B8DE:
	ldrh r0,[r4,#0x8]	; 0230B8DE
	str r0,[sp,#0x4]	; 0230B8E0
	b loc_0230BA62	; 0230B8E2
loc_0230B8E4:
	add r0,r5,#0x0	; 0230B8E4
	bl loc_02305180	; 0230B8E6
	add r7,r0,#0x0	; 0230B8EA
	add r0,r5,#0x1	; 0230B8EC
	add r5,r5,#0x2	; 0230B8EE
	bl loc_02305180	; 0230B8F0
	add r6,r0,#0x0	; 0230B8F4
	cmp r7,#0x5	; 0230B8F6
	bhi loc_0230B914	; 0230B8F8
	add r0,r7,r7	; 0230B8FA
P4_SwitchIndexPC_0230B8FA:
	add r0,pc	; 0230B8FC
	ldrh r0,[r0,#(P4_SwitchTable_0230B8FA - (P4_SwitchIndexPC_0230B8FA + 4))]	; 0230B8FE
	lsl r0,r0,#0x10	; 0230B900
	asr r0,r0,#0x10	; 0230B902
P4_SwitchTargetPC_0230B8FA:
	add r0,pc	; 0230B904
	bx r0	; 0230B906
; 表项是相对 ADD 所读 PC 的有符号偏移，保留 ARM/Thumb 状态位。
; Signed offsets from the ADD's PC, including the ARM/Thumb state bit.
P4_SwitchTable_0230B8FA:
	.halfword (loc_0230B91C + 1) - (P4_SwitchTargetPC_0230B8FA + 4)
	.halfword (loc_0230B9AC + 1) - (P4_SwitchTargetPC_0230B8FA + 4)
	.halfword (loc_0230BA58 + 1) - (P4_SwitchTargetPC_0230B8FA + 4)
	.halfword (loc_0230B972 + 1) - (P4_SwitchTargetPC_0230B8FA + 4)
	.halfword (loc_0230BA0E + 1) - (P4_SwitchTargetPC_0230B8FA + 4)
	.halfword (loc_0230B9FC + 1) - (P4_SwitchTargetPC_0230B8FA + 4)
P4_SwitchTable_0230B8FAEnd:
loc_0230B914:
	cmp r7,#0xdd	; 0230B914
	bne loc_0230B91A	; 0230B916
	b loc_0230BA20	; 0230B918
loc_0230B91A:
	b loc_0230BA58	; 0230B91A
loc_0230B91C:
	cmp r6,#0x20	; 0230B91C
	bhi loc_0230B964	; 0230B91E
	ldrh r1,[r4,#0xc]	; 0230B920
	mov r0,#0x1	; 0230B922
	orr r1,r0	; 0230B924
	strh r1,[r4,#0xc]	; 0230B926
	sub r0,r5,#0x2	; 0230B928
	str r0,[r4,#0x18]	; 0230B92A
	cmp r6,#0x0	; 0230B92C
	bne loc_0230B944	; 0230B92E
	ldrh r1,[r4,#0xc]	; 0230B930
	ldr r0,[pool_0230BAE4]	; 0230B932
	and r1,r0	; 0230B934
	cmp r1,#0x0	; 0230B936
	beq loc_0230B944	; 0230B938
	ldrh r1,[r4,#0xa]	; 0230B93A
	mov r0,#0x1	; 0230B93C
	orr r1,r0	; 0230B93E
	strh r1,[r4,#0xa]	; 0230B940
	b loc_0230BA58	; 0230B942
loc_0230B944:
	ldrh r1,[r4,#0xa]	; 0230B944
	mov r0,#0x1	; 0230B946
	bic r1,r0	; 0230B948
	strh r1,[r4,#0xa]	; 0230B94A
	lsl r0,r6,#0x10	; 0230B94C
	lsr r0,r0,#0x10	; 0230B94E
	add r1,r5,#0x0	; 0230B950
	bl loc_023058D8	; 0230B952
	cmp r0,#0x0	; 0230B956
	beq loc_0230BA58	; 0230B958
	ldrh r1,[r4,#0xa]	; 0230B95A
	mov r0,#0x1	; 0230B95C
	orr r1,r0	; 0230B95E
	strh r1,[r4,#0xa]	; 0230B960
	b loc_0230BA58	; 0230B962
loc_0230B964:
	ldrh r1,[r4,#0xc]	; 0230B964
	mov r0,#0x1	; 0230B966
	bic r1,r0	; 0230B968
	strh r1,[r4,#0xc]	; 0230B96A
	mov r0,#0x0	; 0230B96C
	str r0,[r4,#0x18]	; 0230B96E
	b loc_0230BA58	; 0230B970
loc_0230B972:
	cmp r6,#0x1	; 0230B972
	bcc loc_0230BA58	; 0230B974
	ldrh r1,[r4,#0xc]	; 0230B976
	mov r0,#0x2	; 0230B978
	orr r1,r0	; 0230B97A
	strh r1,[r4,#0xc]	; 0230B97C
	add r0,r5,#0x0	; 0230B97E
	bl loc_02305180	; 0230B980
	strh r0,[r4,#0x12]	; 0230B984
	ldrh r0,[r4,#0x12]	; 0230B986
	ldr r1,[pool_0230BADC]	; 0230B988
	ldr r2,[r1,#0x0]	; 0230B98A
	ldr r1,[pool_0230BAE8]	; 0230B98C
	ldr r1,[r2,r1]	; 0230B98E
	add r1,#0x4a	; 0230B990
	ldrh r1,[r1,#0x0]	; 0230B992
	cmp r0,r1	; 0230B994
	bne loc_0230B9A2	; 0230B996
	ldrh r1,[r4,#0xa]	; 0230B998
	mov r0,#0x2	; 0230B99A
	orr r1,r0	; 0230B99C
	strh r1,[r4,#0xa]	; 0230B99E
	b loc_0230BA58	; 0230B9A0
loc_0230B9A2:
	ldrh r1,[r4,#0xa]	; 0230B9A2
	mov r0,#0x2	; 0230B9A4
	bic r1,r0	; 0230B9A6
	strh r1,[r4,#0xa]	; 0230B9A8
	b loc_0230BA58	; 0230B9AA
loc_0230B9AC:
	cmp r6,#0x1	; 0230B9AC
	bcc loc_0230BA58	; 0230B9AE
	ldrh r1,[r4,#0xc]	; 0230B9B0
	mov r0,#0x4	; 0230B9B2
	orr r1,r0	; 0230B9B4
	strh r1,[r4,#0xc]	; 0230B9B6
	sub r0,r5,#0x2	; 0230B9B8
	add r1,r4,#0x0	; 0230B9BA
	add r1,#0x14	; 0230B9BC
	bl loc_0230581C	; 0230B9BE
	ldrh r1,[r4,#0x14]	; 0230B9C2
	ldr r0,[sp,#0x0]	; 0230B9C4
	add r0,#0x60	; 0230B9C6
	ldrh r0,[r0,#0x0]	; 0230B9C8
	ldr r2,[sp,#0x0]	; 0230B9CA
	add r2,#0x62	; 0230B9CC
	ldrh r2,[r2,#0x0]	; 0230B9CE
	add r3,r0,#0x0	; 0230B9D0
	orr r3,r2	; 0230B9D2
	add r2,r1,#0x0	; 0230B9D4
	bic r2,r3	; 0230B9D6
	cmp r2,#0x0	; 0230B9D8
	bne loc_0230B9F2	; 0230B9DA
	ldrh r2,[r4,#0x16]	; 0230B9DC
	orr r1,r2	; 0230B9DE
	add r2,r0,#0x0	; 0230B9E0
	and r2,r1	; 0230B9E2
	cmp r0,r2	; 0230B9E4
	bne loc_0230B9F2	; 0230B9E6
	ldrh r1,[r4,#0xa]	; 0230B9E8
	mov r0,#0x4	; 0230B9EA
	orr r1,r0	; 0230B9EC
	strh r1,[r4,#0xa]	; 0230B9EE
	b loc_0230BA58	; 0230B9F0
loc_0230B9F2:
	ldrh r1,[r4,#0xa]	; 0230B9F2
	mov r0,#0x4	; 0230B9F4
	bic r1,r0	; 0230B9F6
	strh r1,[r4,#0xa]	; 0230B9F8
	b loc_0230BA58	; 0230B9FA
loc_0230B9FC:
	cmp r6,#0x3	; 0230B9FC
	bcc loc_0230BA58	; 0230B9FE
	ldrh r1,[r4,#0xc]	; 0230BA00
	ldr r0,[pool_0230BAEC]	; 0230BA02
	orr r1,r0	; 0230BA04
	strh r1,[r4,#0xc]	; 0230BA06
	sub r0,r5,#0x2	; 0230BA08
	str r0,[r4,#0x20]	; 0230BA0A
	b loc_0230BA58	; 0230BA0C
loc_0230BA0E:
	cmp r6,#0x6	; 0230BA0E
	bcc loc_0230BA58	; 0230BA10
	ldrh r1,[r4,#0xc]	; 0230BA12
	ldr r0,[pool_0230BAF0]	; 0230BA14
	orr r1,r0	; 0230BA16
	strh r1,[r4,#0xc]	; 0230BA18
	sub r0,r5,#0x2	; 0230BA1A
	str r0,[r4,#0x1c]	; 0230BA1C
	b loc_0230BA58	; 0230BA1E
loc_0230BA20:
	cmp r6,#0x8	; 0230BA20
	bcc loc_0230BA58	; 0230BA22
	add r0,r5,#0x0	; 0230BA24
	bl loc_02305180	; 0230BA26
	cmp r0,#0x0	; 0230BA2A
	bne loc_0230BA58	; 0230BA2C
	add r0,r5,#0x1	; 0230BA2E
	bl loc_02305180	; 0230BA30
	cmp r0,#0x9	; 0230BA34
	bne loc_0230BA58	; 0230BA36
	add r0,r5,#0x2	; 0230BA38
	bl loc_02305180	; 0230BA3A
	cmp r0,#0xbf	; 0230BA3E
	bne loc_0230BA58	; 0230BA40
	add r0,r5,#0x3	; 0230BA42
	bl loc_02305180	; 0230BA44
	cmp r0,#0x0	; 0230BA48
	bne loc_0230BA58	; 0230BA4A
	ldrh r1,[r4,#0xc]	; 0230BA4C
	ldr r0,[pool_0230BAF4]	; 0230BA4E
	orr r1,r0	; 0230BA50
	strh r1,[r4,#0xc]	; 0230BA52
	sub r0,r5,#0x2	; 0230BA54
	str r0,[r4,#0x24]	; 0230BA56
loc_0230BA58:
	add r5,r5,r6	; 0230BA58
	add r1,r6,#0x2	; 0230BA5A
	ldr r0,[sp,#0x4]	; 0230BA5C
	sub r0,r0,r1	; 0230BA5E
	str r0,[sp,#0x4]	; 0230BA60
loc_0230BA62:
	ldr r0,[sp,#0x4]	; 0230BA62
	cmp r0,#0x0	; 0230BA64
	ble loc_0230BA6A	; 0230BA66
	b loc_0230B8E4	; 0230BA68
loc_0230BA6A:
	ldrh r1,[r4,#0xc]	; 0230BA6A
	mov r0,#0x8	; 0230BA6C
	and r1,r0	; 0230BA6E
	cmp r1,#0x0	; 0230BA70
	beq loc_0230BA94	; 0230BA72
	ldr r0,[sp,#0x0]	; 0230BA74
	add r0,#0x64	; 0230BA76
	ldrh r1,[r0,#0x0]	; 0230BA78
	mov r0,#0x1	; 0230BA7A
	and r1,r0	; 0230BA7C
	cmp r1,#0x0	; 0230BA7E
	bne loc_0230BA8C	; 0230BA80
	ldrh r1,[r4,#0x4]	; 0230BA82
	ldr r0,[pool_0230BAF8]	; 0230BA84
	and r1,r0	; 0230BA86
	cmp r1,#0x0	; 0230BA88
	beq loc_0230BA94	; 0230BA8A
loc_0230BA8C:
	ldrh r1,[r4,#0xa]	; 0230BA8C
	mov r0,#0x8	; 0230BA8E
	orr r1,r0	; 0230BA90
	strh r1,[r4,#0xa]	; 0230BA92
loc_0230BA94:
	ldrh r1,[r4,#0xc]	; 0230BA94
	mov r0,#0x30	; 0230BA96
	and r1,r0	; 0230BA98
	cmp r1,#0x0	; 0230BA9A
	beq loc_0230BAD4	; 0230BA9C
	ldrh r2,[r4,#0x6]	; 0230BA9E
	mov r1,#0x3	; 0230BAA0
	and r2,r1	; 0230BAA2
	ldr r0,[sp,#0x0]	; 0230BAA4
	add r0,#0x7c	; 0230BAA6
	ldrh r0,[r0,#0x0]	; 0230BAA8
	and r0,r1	; 0230BAAA
	cmp r2,r0	; 0230BAAC
	bne loc_0230BAB8	; 0230BAAE
	ldrh r1,[r4,#0xa]	; 0230BAB0
	mov r0,#0x10	; 0230BAB2
	orr r1,r0	; 0230BAB4
	strh r1,[r4,#0xa]	; 0230BAB6
loc_0230BAB8:
	ldrh r2,[r4,#0x6]	; 0230BAB8
	mov r1,#0x10	; 0230BABA
	and r2,r1	; 0230BABC
	ldr r0,[sp,#0x0]	; 0230BABE
	add r0,#0x7c	; 0230BAC0
	str r0,[sp,#0x0]	; 0230BAC2
	ldrh r0,[r0,#0x0]	; 0230BAC4
	and r0,r1	; 0230BAC6
	cmp r2,r0	; 0230BAC8
	bne loc_0230BAD4	; 0230BACA
	ldrh r1,[r4,#0xa]	; 0230BACC
	mov r0,#0x20	; 0230BACE
	orr r1,r0	; 0230BAD0
	strh r1,[r4,#0xa]	; 0230BAD2
loc_0230BAD4:
	add sp,#0xc	; 0230BAD4
	pop {r4,r5,r6,r7}	; 0230BAD6
	pop {r3}	; 0230BAD8
	bx r3	; 0230BADA
pool_0230BADC:
loc_0230BADC:
	.word FirmwareWlWorkPointerSlot	; 0230BADC
pool_0230BAE0:
loc_0230BAE0:
	.word 0x00000318	; 0230BAE0
pool_0230BAE4:
loc_0230BAE4:
	.word 0x00000800	; 0230BAE4
pool_0230BAE8:
loc_0230BAE8:
	.word 0x000003F0	; 0230BAE8
pool_0230BAEC:
loc_0230BAEC:
	.word 0x00000100	; 0230BAEC
pool_0230BAF0:
loc_0230BAF0:
	.word 0x00000200	; 0230BAF0
pool_0230BAF4:
loc_0230BAF4:
	.word 0x00000400	; 0230BAF4
pool_0230BAF8:
loc_0230BAF8:
	.word 0x00008000	; 0230BAF8

; ===== function loc_0230BAFC =====
loc_0230BAFC:
	bx lr	; 0230BAFC
	.byte 0x00, 0x00	; 0230BB00

; ===== function loc_0230BB00 =====
loc_0230BB00:
	push {r4,r5,lr}	; 0230BB00
	sub sp,#0x4	; 0230BB02
	ldr r1,[pool_0230BB40]	; 0230BB04
	ldr r2,[r1,#0x0]	; 0230BB06
	ldr r1,[pool_0230BB44]	; 0230BB08
	add r4,r2,r1	; 0230BB0A
	ldrh r5,[r0,#0x2]	; 0230BB0C
	add r0,r5,#0x0	; 0230BB0E
	bl loc_0230728C	; 0230BB10
	cmp r0,#0x40	; 0230BB14
	bne loc_0230BB36	; 0230BB16
	add r0,r5,#0x0	; 0230BB18
	bl loc_023073BC	; 0230BB1A
	ldrh r0,[r4,#0x2c]	; 0230BB1E
	cmp r0,#0x0	; 0230BB20
	beq loc_0230BB2A	; 0230BB22
	mov r0,#0x1	; 0230BB24
	bl loc_0230AF00	; 0230BB26
loc_0230BB2A:
	ldrh r0,[r4,#0x20]	; 0230BB2A
	cmp r0,#0x0	; 0230BB2C
	beq loc_0230BB36	; 0230BB2E
	mov r0,#0x0	; 0230BB30
	bl loc_0230AF00	; 0230BB32
loc_0230BB36:
	add sp,#0x4	; 0230BB36
	pop {r4,r5}	; 0230BB38
	pop {r3}	; 0230BB3A
	bx r3	; 0230BB3C
	.byte 0xC0, 0x46	; 0230BB40
pool_0230BB40:
loc_0230BB40:
	.word FirmwareWlWorkPointerSlot	; 0230BB40
pool_0230BB44:
loc_0230BB44:
	.word 0x00000150	; 0230BB44

; ===== function loc_0230BB48 =====
loc_0230BB48:
	push {r4,r5,lr}	; 0230BB48
	sub sp,#0x4	; 0230BB4A
	add r5,r0,#0x0	; 0230BB4C
	ldr r0,[pool_0230BBC0]	; 0230BB4E
	ldr r1,[r0,#0x0]	; 0230BB50
	ldr r0,[pool_0230BBC4]	; 0230BB52
	add r1,r1,r0	; 0230BB54
	ldrh r4,[r5,#0x2]	; 0230BB56
	ldrh r0,[r1,#0xc]	; 0230BB58
	cmp r0,#0x1	; 0230BB5A
	beq loc_0230BB68	; 0230BB5C
	cmp r0,#0x2	; 0230BB5E
	beq loc_0230BB8E	; 0230BB60
	cmp r0,#0x3	; 0230BB62
	beq loc_0230BB8E	; 0230BB64
	b loc_0230BBB6	; 0230BB66
loc_0230BB68:
	add r0,r4,#0x0	; 0230BB68
	bl loc_0230728C	; 0230BB6A
	cmp r0,#0x20	; 0230BB6E
	bls loc_0230BBB6	; 0230BB70
	lsl r0,r4,#0x10	; 0230BB72
	lsr r0,r0,#0x10	; 0230BB74
	mov r1,#0x20	; 0230BB76
	bl loc_0230745C	; 0230BB78
	add r0,r5,#0x0	; 0230BB7C
	add r0,#0x1e	; 0230BB7E
	ldrh r1,[r5,#0x2c]	; 0230BB80
	bl loc_02307C00	; 0230BB82
	add r0,r4,#0x0	; 0230BB86
	bl loc_0230A5F4	; 0230BB88
	b loc_0230BBB6	; 0230BB8C
loc_0230BB8E:
	ldrh r0,[r1,#0x8]	; 0230BB8E
	cmp r0,#0x20	; 0230BB90
	bls loc_0230BBB6	; 0230BB92
	add r0,r5,#0x0	; 0230BB94
	add r0,#0x1e	; 0230BB96
	add r1,#0x82	; 0230BB98
	bl loc_023058B8	; 0230BB9A
	cmp r0,#0x0	; 0230BB9E
	beq loc_0230BBB6	; 0230BBA0
	mov r0,#0x20	; 0230BBA2
	bl loc_023070B8	; 0230BBA4
	bl loc_02305B8C	; 0230BBA8
	add r0,r5,#0x0	; 0230BBAC
	add r0,#0x1e	; 0230BBAE
	ldrh r1,[r5,#0x2c]	; 0230BBB0
	bl loc_02307C00	; 0230BBB2
loc_0230BBB6:
	add sp,#0x4	; 0230BBB6
	pop {r4,r5}	; 0230BBB8
	pop {r3}	; 0230BBBA
	bx r3	; 0230BBBC
	.byte 0xC0, 0x46	; 0230BBC0
pool_0230BBC0:
loc_0230BBC0:
	.word FirmwareWlWorkPointerSlot	; 0230BBC0
pool_0230BBC4:
loc_0230BBC4:
	.word 0x00000318	; 0230BBC4

; ===== function loc_0230BBC8 =====
loc_0230BBC8:
	push {r4,r5,r6,r7,lr}	; 0230BBC8
	sub sp,#0x14	; 0230BBCA
	add r6,r0,#0x0	; 0230BBCC
	ldr r0,[pool_0230BEE4]	; 0230BBCE
	ldr r0,[r0,#0x0]	; 0230BBD0
	ldr r1,[pool_0230BEE8]	; 0230BBD2
	add r1,r0,r1	; 0230BBD4
	str r1,[sp,#0x0]	; 0230BBD6
	ldr r1,[pool_0230BEEC]	; 0230BBD8
	add r5,r0,r1	; 0230BBDA
	add r4,r6,#0x0	; 0230BBDC
	add r4,#0x2c	; 0230BBDE
	ldr r1,[pool_0230BEF0]	; 0230BBE0
	ldrh r2,[r0,r1]	; 0230BBE2
	mov r1,#0x8	; 0230BBE4
	and r2,r1	; 0230BBE6
	cmp r2,#0x0	; 0230BBE8
	beq loc_0230BC40	; 0230BBEA
	ldr r1,[pool_0230BEF4]	; 0230BBEC
	add r1,r0,r1	; 0230BBEE
	ldr r0,[pool_0230BEF8]	; 0230BBF0
	ldrh r0,[r0,#0x0]	; 0230BBF2
	mov r2,#0x1	; 0230BBF4
	add r3,r0,#0x0	; 0230BBF6
	and r3,r2	; 0230BBF8
	cmp r3,#0x0	; 0230BBFA
	beq loc_0230BC04	; 0230BBFC
	ldrh r2,[r1,#0x0]	; 0230BBFE
	cmp r2,#0x0	; 0230BC00
	bne loc_0230BC40	; 0230BC02
loc_0230BC04:
	mov r2,#0x4	; 0230BC04
	add r3,r0,#0x0	; 0230BC06
	and r3,r2	; 0230BC08
	cmp r3,#0x0	; 0230BC0A
	beq loc_0230BC14	; 0230BC0C
	ldrh r2,[r1,#0x14]	; 0230BC0E
	cmp r2,#0x0	; 0230BC10
	bne loc_0230BC40	; 0230BC12
loc_0230BC14:
	mov r2,#0x8	; 0230BC14
	and r0,r2	; 0230BC16
	cmp r0,#0x0	; 0230BC18
	beq loc_0230BC22	; 0230BC1A
	ldrh r0,[r1,#0x28]	; 0230BC1C
	cmp r0,#0x0	; 0230BC1E
	bne loc_0230BC40	; 0230BC20
loc_0230BC22:
	ldr r0,[pool_0230BEFC]	; 0230BC22
	ldrh r1,[r0,#0x0]	; 0230BC24
	mov r0,#0x1	; 0230BC26
	and r1,r0	; 0230BC28
	cmp r1,#0x0	; 0230BC2A
	bne loc_0230BC40	; 0230BC2C
	mov r0,#0x0	; 0230BC2E
	ldr r2,[pool_0230BF00]	; 0230BC30
	strh r0,[r2,#0x0]	; 0230BC32
	ldr r1,[pool_0230BF04]	; 0230BC34
	strh r1,[r2,#0x0]	; 0230BC36
	ldr r1,[pool_0230BEE4]	; 0230BC38
	ldr r2,[r1,#0x0]	; 0230BC3A
	ldr r1,[pool_0230BF08]	; 0230BC3C
	strh r0,[r2,r1]	; 0230BC3E
loc_0230BC40:
	mov r0,#0x0	; 0230BC40
	str r0,[sp,#0x4]	; 0230BC42
	ldrh r0,[r4,#0x2]	; 0230BC44
	add r0,r0,#0x1	; 0230BC46
	lsl r0,r0,#0x10	; 0230BC48
	lsr r0,r0,#0x10	; 0230BC4A
	str r0,[sp,#0x8]	; 0230BC4C
	ldrh r7,[r6,#0x2]	; 0230BC4E
	cmp r7,#0x0	; 0230BC50
	bne loc_0230BC5E	; 0230BC52
	mov r0,#0x13	; 0230BC54
	str r0,[sp,#0xc]	; 0230BC56
	mov r0,#0x1	; 0230BC58
	str r0,[sp,#0x4]	; 0230BC5A
	b loc_0230BF24	; 0230BC5C
loc_0230BC5E:
	ldr r0,[sp,#0x0]	; 0230BC5E
	ldrh r0,[r0,#0xc]	; 0230BC60
	cmp r0,#0x1	; 0230BC62
	bne loc_0230BCB0	; 0230BC64
	add r0,r7,#0x0	; 0230BC66
	bl loc_0230728C	; 0230BC68
	cmp r0,#0x20	; 0230BC6C
	bls loc_0230BC84	; 0230BC6E
	lsl r0,r7,#0x10	; 0230BC70
	lsr r0,r0,#0x10	; 0230BC72
	mov r1,#0x20	; 0230BC74
	bl loc_0230745C	; 0230BC76
	add r0,r6,#0x0	; 0230BC7A
	add r0,#0x1e	; 0230BC7C
	mov r1,#0x1	; 0230BC7E
	bl loc_02307C00	; 0230BC80
loc_0230BC84:
	ldrh r1,[r6,#0x8]	; 0230BC84
	ldr r0,[pool_0230BEF4]	; 0230BC86
	and r1,r0	; 0230BC88
	cmp r1,#0x0	; 0230BC8A
	beq loc_0230BCB0	; 0230BC8C
	add r0,r7,#0x0	; 0230BC8E
	bl loc_02307234	; 0230BC90
	cmp r0,#0x0	; 0230BC94
	beq loc_0230BCB0	; 0230BC96
	mov r0,#0x1	; 0230BC98
	str r0,[sp,#0x4]	; 0230BC9A
	strh r0,[r4,#0x0]	; 0230BC9C
	mov r0,#0xf	; 0230BC9E
	str r0,[sp,#0xc]	; 0230BCA0
	mov r0,#0x4	; 0230BCA2
	str r0,[sp,#0x8]	; 0230BCA4
	add r0,r7,#0x0	; 0230BCA6
	mov r1,#0x0	; 0230BCA8
	bl loc_0230737C	; 0230BCAA
	b loc_0230BF24	; 0230BCAE
loc_0230BCB0:
	ldrh r0,[r4,#0x0]	; 0230BCB0
	cmp r0,#0x0	; 0230BCB2
	beq loc_0230BCBC	; 0230BCB4
	cmp r0,#0x1	; 0230BCB6
	beq loc_0230BD62	; 0230BCB8
	b loc_0230BF14	; 0230BCBA
loc_0230BCBC:
	ldr r0,[sp,#0x0]	; 0230BCBC
	ldrh r0,[r0,#0xc]	; 0230BCBE
	cmp r0,#0x1	; 0230BCC0
	bne loc_0230BCDA	; 0230BCC2
	ldr r1,[pool_0230BEE4]	; 0230BCC4
	ldr r2,[r1,#0x0]	; 0230BCC6
	ldr r1,[pool_0230BF0C]	; 0230BCC8
	ldrh r1,[r2,r1]	; 0230BCCA
	cmp r1,#0x1	; 0230BCCC
	bne loc_0230BCDA	; 0230BCCE
	mov r0,#0xd	; 0230BCD0
	str r0,[sp,#0xc]	; 0230BCD2
	mov r0,#0x1	; 0230BCD4
	str r0,[sp,#0x4]	; 0230BCD6
	b loc_0230BF24	; 0230BCD8
loc_0230BCDA:
	cmp r0,#0x1	; 0230BCDA
	bne loc_0230BCFC	; 0230BCDC
	ldrh r0,[r4,#0x2]	; 0230BCDE
	cmp r0,#0x1	; 0230BCE0
	bne loc_0230BCEE	; 0230BCE2
	mov r0,#0x0	; 0230BCE4
	str r0,[sp,#0xc]	; 0230BCE6
	mov r0,#0x1	; 0230BCE8
	str r0,[sp,#0x4]	; 0230BCEA
	b loc_0230BF24	; 0230BCEC
loc_0230BCEE:
	mov r0,#0xe	; 0230BCEE
	str r0,[sp,#0xc]	; 0230BCF0
	mov r0,#0x2	; 0230BCF2
	str r0,[sp,#0x8]	; 0230BCF4
	mov r0,#0x1	; 0230BCF6
	str r0,[sp,#0x4]	; 0230BCF8
	b loc_0230BF24	; 0230BCFA
loc_0230BCFC:
	cmp r0,#0x1	; 0230BCFC
	bne loc_0230BD02	; 0230BCFE
	b loc_0230BF24	; 0230BD00
loc_0230BD02:
	ldrh r0,[r4,#0x2]	; 0230BD02
	cmp r0,#0x2	; 0230BD04
	beq loc_0230BD0A	; 0230BD06
	b loc_0230BF24	; 0230BD08
loc_0230BD0A:
	ldr r0,[r5,#0x18]	; 0230BD0A
	ldrh r1,[r0,#0x16]	; 0230BD0C
	cmp r1,#0x0	; 0230BD0E
	beq loc_0230BD14	; 0230BD10
	b loc_0230BF24	; 0230BD12
loc_0230BD14:
	add r0,#0x10	; 0230BD14
	add r1,r6,#0x0	; 0230BD16
	add r1,#0x1e	; 0230BD18
	bl loc_023058B8	; 0230BD1A
	cmp r0,#0x0	; 0230BD1E
	bne loc_0230BD24	; 0230BD20
	b loc_0230BF24	; 0230BD22
loc_0230BD24:
	ldrh r0,[r5,#0x0]	; 0230BD24
	cmp r0,#0x31	; 0230BD26
	beq loc_0230BD2C	; 0230BD28
	b loc_0230BF24	; 0230BD2A
loc_0230BD2C:
	bl loc_02305358	; 0230BD2C
	ldrh r0,[r4,#0x4]	; 0230BD30
	cmp r0,#0x0	; 0230BD32
	bne loc_0230BD48	; 0230BD34
	mov r0,#0x30	; 0230BD36
	bl loc_023070B8	; 0230BD38
	mov r1,#0x0	; 0230BD3C
	ldr r0,[r5,#0x1c]	; 0230BD3E
	strh r1,[r0,#0x4]	; 0230BD40
	ldr r0,[r5,#0x1c]	; 0230BD42
	strh r1,[r0,#0x6]	; 0230BD44
	b loc_0230BD54	; 0230BD46
loc_0230BD48:
	mov r1,#0xc	; 0230BD48
	ldr r0,[r5,#0x1c]	; 0230BD4A
	strh r1,[r0,#0x4]	; 0230BD4C
	ldrh r1,[r4,#0x4]	; 0230BD4E
	ldr r0,[r5,#0x1c]	; 0230BD50
	strh r1,[r0,#0x6]	; 0230BD52
loc_0230BD54:
	mov r0,#0x35	; 0230BD54
	strh r0,[r5,#0x0]	; 0230BD56
	mov r0,#0x2	; 0230BD58
	add r1,r0,#0x0	; 0230BD5A
	bl loc_02304BE8	; 0230BD5C
	b loc_0230BF24	; 0230BD60
loc_0230BD62:
	ldr r0,[sp,#0x0]	; 0230BD62
	ldrh r0,[r0,#0xc]	; 0230BD64
	cmp r0,#0x1	; 0230BD66
	bne loc_0230BE0C	; 0230BD68
	lsl r0,r7,#0x10	; 0230BD6A
	lsr r0,r0,#0x10	; 0230BD6C
	mov r1,#0x20	; 0230BD6E
	bl loc_0230745C	; 0230BD70
	ldrh r0,[r4,#0x2]	; 0230BD74
	cmp r0,#0x1	; 0230BD76
	bne loc_0230BDA8	; 0230BD78
	add r0,r6,#0x0	; 0230BD7A
	add r0,#0x1e	; 0230BD7C
	mov r1,#0x80	; 0230BD7E
	bl loc_02309B74	; 0230BD80
	add r5,r0,#0x0	; 0230BD84
	cmp r5,#0x0	; 0230BD86
	bne loc_0230BD8C	; 0230BD88
	b loc_0230BF24	; 0230BD8A
loc_0230BD8C:
	ldrh r0,[r4,#0x0]	; 0230BD8C
	strh r0,[r5,#0x2c]	; 0230BD8E
	ldr r0,[sp,#0x8]	; 0230BD90
	strh r0,[r5,#0x2e]	; 0230BD92
	mov r0,#0x0	; 0230BD94
	strh r0,[r5,#0x30]	; 0230BD96
	add r0,r7,#0x0	; 0230BD98
	add r1,r5,#0x0	; 0230BD9A
	bl loc_0230B610	; 0230BD9C
	add r0,r5,#0x0	; 0230BDA0
	bl loc_0230A43C	; 0230BDA2
	b loc_0230BF24	; 0230BDA6
loc_0230BDA8:
	cmp r0,#0x3	; 0230BDA8
	bne loc_0230BDF6	; 0230BDAA
	add r0,r7,#0x0	; 0230BDAC
	bl loc_0230728C	; 0230BDAE
	cmp r0,#0x20	; 0230BDB2
	bne loc_0230BDC0	; 0230BDB4
	add r0,r7,#0x0	; 0230BDB6
	bl loc_02307234	; 0230BDB8
	cmp r0,#0x0	; 0230BDBC
	bne loc_0230BDC8	; 0230BDBE
loc_0230BDC0:
	mov r0,#0x1	; 0230BDC0
	str r0,[sp,#0xc]	; 0230BDC2
	str r0,[sp,#0x4]	; 0230BDC4
	b loc_0230BF24	; 0230BDC6
loc_0230BDC8:
	add r0,r6,#0x0	; 0230BDC8
	bl loc_0230B5B0	; 0230BDCA
	cmp r0,#0x0	; 0230BDCE
	bne loc_0230BDE4	; 0230BDD0
	mov r0,#0xf	; 0230BDD2
	str r0,[sp,#0xc]	; 0230BDD4
	mov r0,#0x1	; 0230BDD6
	str r0,[sp,#0x4]	; 0230BDD8
	add r0,r7,#0x0	; 0230BDDA
	mov r1,#0x0	; 0230BDDC
	bl loc_0230737C	; 0230BDDE
	b loc_0230BF24	; 0230BDE2
loc_0230BDE4:
	add r0,r7,#0x0	; 0230BDE4
	mov r1,#0x0	; 0230BDE6
	bl loc_0230737C	; 0230BDE8
	mov r0,#0x0	; 0230BDEC
	str r0,[sp,#0xc]	; 0230BDEE
	mov r0,#0x1	; 0230BDF0
	str r0,[sp,#0x4]	; 0230BDF2
	b loc_0230BF24	; 0230BDF4
loc_0230BDF6:
	add r0,r7,#0x0	; 0230BDF6
	mov r1,#0x0	; 0230BDF8
	bl loc_0230737C	; 0230BDFA
	mov r0,#0xe	; 0230BDFE
	str r0,[sp,#0xc]	; 0230BE00
	mov r0,#0x2	; 0230BE02
	str r0,[sp,#0x8]	; 0230BE04
	mov r0,#0x1	; 0230BE06
	str r0,[sp,#0x4]	; 0230BE08
	b loc_0230BF24	; 0230BE0A
loc_0230BE0C:
	ldr r0,[r5,#0x18]	; 0230BE0C
	ldrh r1,[r0,#0x16]	; 0230BE0E
	cmp r1,#0x1	; 0230BE10
	beq loc_0230BE16	; 0230BE12
	b loc_0230BF24	; 0230BE14
loc_0230BE16:
	add r0,#0x10	; 0230BE16
	add r1,r6,#0x0	; 0230BE18
	add r1,#0x1e	; 0230BE1A
	bl loc_023058B8	; 0230BE1C
	cmp r0,#0x0	; 0230BE20
	beq loc_0230BF24	; 0230BE22
	ldrh r0,[r4,#0x2]	; 0230BE24
	cmp r0,#0x2	; 0230BE26
	bne loc_0230BEA2	; 0230BE28
	ldrh r0,[r5,#0x0]	; 0230BE2A
	cmp r0,#0x31	; 0230BE2C
	bne loc_0230BF24	; 0230BE2E
	ldrh r0,[r4,#0x4]	; 0230BE30
	cmp r0,#0x0	; 0230BE32
	beq loc_0230BE5A	; 0230BE34
	bl loc_02305358	; 0230BE36
	mov r0,#0x35	; 0230BE3A
	strh r0,[r5,#0x0]	; 0230BE3C
	mov r1,#0xc	; 0230BE3E
	ldr r0,[r5,#0x1c]	; 0230BE40
	strh r1,[r0,#0x4]	; 0230BE42
	ldrh r1,[r4,#0x4]	; 0230BE44
	ldr r0,[r5,#0x1c]	; 0230BE46
	strh r1,[r0,#0x6]	; 0230BE48
	mov r0,#0x2	; 0230BE4A
	add r1,r0,#0x0	; 0230BE4C
	bl loc_02304BE8	; 0230BE4E
	mov r0,#0x20	; 0230BE52
	bl loc_023070B8	; 0230BE54
	b loc_0230BF24	; 0230BE58
loc_0230BE5A:
	mov r0,#0x33	; 0230BE5A
	strh r0,[r5,#0x0]	; 0230BE5C
	add r0,r6,#0x0	; 0230BE5E
	add r0,#0x33	; 0230BE60
	bl loc_02305180	; 0230BE62
	add r1,r0,#0x0	; 0230BE66
	add r0,r6,#0x0	; 0230BE68
	add r0,#0x1e	; 0230BE6A
	bl loc_02309B74	; 0230BE6C
	add r5,r0,#0x0	; 0230BE70
	cmp r5,#0x0	; 0230BE72
	beq loc_0230BF24	; 0230BE74
	ldrh r1,[r5,#0x14]	; 0230BE76
	ldr r0,[pool_0230BF10]	; 0230BE78
	orr r1,r0	; 0230BE7A
	strh r1,[r5,#0x14]	; 0230BE7C
	add r0,r6,#0x0	; 0230BE7E
	add r0,#0x2c	; 0230BE80
	add r1,r5,#0x0	; 0230BE82
	add r1,#0x2c	; 0230BE84
	ldrh r2,[r6,#0x6]	; 0230BE86
	add r2,r2,#0x1	; 0230BE88
	bl loc_0230BF50	; 0230BE8A
	ldrh r0,[r4,#0x0]	; 0230BE8E
	strh r0,[r5,#0x2c]	; 0230BE90
	mov r0,#0x3	; 0230BE92
	strh r0,[r5,#0x2e]	; 0230BE94
	mov r0,#0x0	; 0230BE96
	strh r0,[r5,#0x30]	; 0230BE98
	add r0,r5,#0x0	; 0230BE9A
	bl loc_0230A43C	; 0230BE9C
	b loc_0230BF24	; 0230BEA0
loc_0230BEA2:
	cmp r0,#0x4	; 0230BEA2
	bne loc_0230BF24	; 0230BEA4
	ldrh r0,[r5,#0x0]	; 0230BEA6
	cmp r0,#0x33	; 0230BEA8
	bne loc_0230BF24	; 0230BEAA
	bl loc_02305358	; 0230BEAC
	ldrh r0,[r4,#0x4]	; 0230BEB0
	cmp r0,#0x0	; 0230BEB2
	bne loc_0230BEC8	; 0230BEB4
	mov r0,#0x30	; 0230BEB6
	bl loc_023070B8	; 0230BEB8
	mov r1,#0x0	; 0230BEBC
	ldr r0,[r5,#0x1c]	; 0230BEBE
	strh r1,[r0,#0x4]	; 0230BEC0
	ldr r0,[r5,#0x1c]	; 0230BEC2
	strh r1,[r0,#0x6]	; 0230BEC4
	b loc_0230BED4	; 0230BEC6
loc_0230BEC8:
	mov r1,#0xc	; 0230BEC8
	ldr r0,[r5,#0x1c]	; 0230BECA
	strh r1,[r0,#0x4]	; 0230BECC
	ldrh r1,[r4,#0x4]	; 0230BECE
	ldr r0,[r5,#0x1c]	; 0230BED0
	strh r1,[r0,#0x6]	; 0230BED2
loc_0230BED4:
	mov r0,#0x35	; 0230BED4
	strh r0,[r5,#0x0]	; 0230BED6
	mov r0,#0x2	; 0230BED8
	add r1,r0,#0x0	; 0230BEDA
	bl loc_02304BE8	; 0230BEDC
	b loc_0230BF24	; 0230BEE0
	.byte 0xC0, 0x46	; 0230BEE4
pool_0230BEE4:
loc_0230BEE4:
	.word FirmwareWlWorkPointerSlot	; 0230BEE4
pool_0230BEE8:
loc_0230BEE8:
	.word 0x00000318	; 0230BEE8
pool_0230BEEC:
loc_0230BEEC:
	.word 0x000003D8	; 0230BEEC
pool_0230BEF0:
loc_0230BEF0:
	.word 0x00000638	; 0230BEF0
pool_0230BEF4:
loc_0230BEF4:
	.word 0x00000400	; 0230BEF4
pool_0230BEF8:
loc_0230BEF8:
	.word REG_WIFI_TXREQ_READ	; 0230BEF8
pool_0230BEFC:
loc_0230BEFC:
	.word REG_WIFI_RF_PINS	; 0230BEFC
pool_0230BF00:
loc_0230BF00:
	.word REG_WIFI_WEP_CNT	; 0230BF00
pool_0230BF04:
loc_0230BF04:
	.word 0x00008000	; 0230BF04
pool_0230BF08:
loc_0230BF08:
	.word 0x000004B6	; 0230BF08
pool_0230BF0C:
loc_0230BF0C:
	.word 0x00000306	; 0230BF0C
pool_0230BF10:
loc_0230BF10:
	.word 0x00004000	; 0230BF10
loc_0230BF14:
	ldr r0,[sp,#0x0]	; 0230BF14
	ldrh r0,[r0,#0xc]	; 0230BF16
	cmp r0,#0x1	; 0230BF18
	bne loc_0230BF24	; 0230BF1A
	mov r0,#0xd	; 0230BF1C
	str r0,[sp,#0xc]	; 0230BF1E
	mov r0,#0x1	; 0230BF20
	str r0,[sp,#0x4]	; 0230BF22
loc_0230BF24:
	ldr r0,[sp,#0x4]	; 0230BF24
	cmp r0,#0x0	; 0230BF26
	beq loc_0230BF48	; 0230BF28
	add r6,#0x1e	; 0230BF2A
	add r0,r6,#0x0	; 0230BF2C
	mov r1,#0x0	; 0230BF2E
	bl loc_02309B74	; 0230BF30
	cmp r0,#0x0	; 0230BF34
	beq loc_0230BF48	; 0230BF36
	ldrh r1,[r4,#0x0]	; 0230BF38
	strh r1,[r0,#0x2c]	; 0230BF3A
	ldr r1,[sp,#0x8]	; 0230BF3C
	strh r1,[r0,#0x2e]	; 0230BF3E
	ldr r1,[sp,#0xc]	; 0230BF40
	strh r1,[r0,#0x30]	; 0230BF42
	bl loc_0230A43C	; 0230BF44
loc_0230BF48:
	add sp,#0x14	; 0230BF48
	pop {r4,r5,r6,r7}	; 0230BF4A
	pop {r3}	; 0230BF4C
	bx r3	; 0230BF4E

; ===== function loc_0230BF50 =====
loc_0230BF50:
	bx pc	; 0230BF50
	.byte 0xC0, 0x46	; 0230BF54
.arm

; ===== function loc_0230BF54 =====
loc_0230BF54:
	ldr pc,[pool_0230BF58]	; 0230BF54
pool_0230BF58:
loc_0230BF58:
	.word P2_Entry_037FF334	; 0230BF58
.thumb

; ===== function loc_0230BF5C =====
loc_0230BF5C:
	push {r4,r5,r6,r7,lr}	; 0230BF5C
	sub sp,#0x54	; 0230BF5E
	str r0,[sp,#0x0]	; 0230BF60
	add r5,r1,#0x0	; 0230BF62
	ldr r0,[pool_0230C190]	; 0230BF64
	ldr r1,[r0,#0x0]	; 0230BF66
	ldr r0,[pool_0230C194]	; 0230BF68
	add r7,r1,r0	; 0230BF6A
	ldrh r0,[r7,#0x0]	; 0230BF6C
	cmp r0,#0x13	; 0230BF6E
	beq loc_0230BF74	; 0230BF70
	b loc_0230C186	; 0230BF72
loc_0230BF74:
	ldr r6,[r7,#0x1c]	; 0230BF74
	ldr r0,[sp,#0x0]	; 0230BF76
	str r0,[sp,#0x4]	; 0230BF78
	add r0,#0x2c	; 0230BF7A
	str r0,[sp,#0x4]	; 0230BF7C
	ldr r0,[r7,#0x18]	; 0230BF7E
	str r0,[sp,#0x10]	; 0230BF80
	add r0,#0x4e	; 0230BF82
	str r0,[sp,#0x10]	; 0230BF84
	mov r4,#0x0	; 0230BF86
	b loc_0230BFAC	; 0230BF88
loc_0230BF8A:
	ldr r0,[sp,#0x10]	; 0230BF8A
	ldr r1,[sp,#0x0]	; 0230BF8C
	add r1,#0x24	; 0230BF8E
	bl loc_023058B8	; 0230BF90
	cmp r0,#0x0	; 0230BF94
	beq loc_0230BFA4	; 0230BF96
	ldrh r1,[r6,#0x6]	; 0230BF98
	mov r0,#0x1	; 0230BF9A
	lsl r0,r4	; 0230BF9C
	orr r1,r0	; 0230BF9E
	strh r1,[r6,#0x6]	; 0230BFA0
	b loc_0230C186	; 0230BFA2
loc_0230BFA4:
	ldr r0,[sp,#0x10]	; 0230BFA4
	add r0,r0,#0x6	; 0230BFA6
	str r0,[sp,#0x10]	; 0230BFA8
	add r4,r4,#0x1	; 0230BFAA
loc_0230BFAC:
	ldr r0,[r7,#0x18]	; 0230BFAC
	add r0,#0x4c	; 0230BFAE
	ldrh r0,[r0,#0x0]	; 0230BFB0
	cmp r4,r0	; 0230BFB2
	bcc loc_0230BF8A	; 0230BFB4
	add r4,r6,#0x0	; 0230BFB6
	add r4,#0xa	; 0230BFB8
	mov r0,#0x0	; 0230BFBA
	str r0,[sp,#0x14]	; 0230BFBC
	b loc_0230BFDC	; 0230BFBE
loc_0230BFC0:
	ldr r0,[sp,#0x0]	; 0230BFC0
	add r0,#0x24	; 0230BFC2
	add r1,r4,#0x4	; 0230BFC4
	bl loc_023058B8	; 0230BFC6
	cmp r0,#0x0	; 0230BFCA
	beq loc_0230BFD0	; 0230BFCC
	b loc_0230C186	; 0230BFCE
loc_0230BFD0:
	ldrh r0,[r4,#0x0]	; 0230BFD0
	lsl r0,r0,#0x1	; 0230BFD2
	add r4,r4,r0	; 0230BFD4
	ldr r0,[sp,#0x14]	; 0230BFD6
	add r0,r0,#0x1	; 0230BFD8
	str r0,[sp,#0x14]	; 0230BFDA
loc_0230BFDC:
	ldrh r1,[r6,#0x8]	; 0230BFDC
	ldr r0,[sp,#0x14]	; 0230BFDE
	cmp r0,r1	; 0230BFE0
	bcc loc_0230BFC0	; 0230BFE2
	mov r1,#0x0	; 0230BFE4
	add r0,sp,#0x24	; 0230BFE6
	strh r1,[r0,#0x0]	; 0230BFE8
	ldrh r0,[r0,#0x0]	; 0230BFEA
	add r1,r4,#0x0	; 0230BFEC
	mov r2,#0x44	; 0230BFEE
	bl loc_0230C1A0	; 0230BFF0
	ldr r0,[sp,#0x0]	; 0230BFF4
	ldrh r0,[r0,#0x6]	; 0230BFF6
	str r0,[sp,#0x8]	; 0230BFF8
	cmp r0,#0xc	; 0230BFFA
	bhi loc_0230C000	; 0230BFFC
	b loc_0230C186	; 0230BFFE
loc_0230C000:
	cmp r5,#0x0	; 0230C000
	bne loc_0230C03E	; 0230C002
	mov r0,#0x0	; 0230C004
	str r0,[sp,#0x28]	; 0230C006
	ldr r0,[sp,#0x28]	; 0230C008
	add r1,sp,#0x2c	; 0230C00A
	mov r2,#0x28	; 0230C00C
	bl loc_0230C1AC	; 0230C00E
	ldr r0,[sp,#0x4]	; 0230C012
	add r0,#0xc	; 0230C014
	str r0,[sp,#0x2c]	; 0230C016
	ldr r0,[sp,#0x8]	; 0230C018
	sub r0,#0xc	; 0230C01A
	str r0,[sp,#0x8]	; 0230C01C
	add r1,sp,#0x24	; 0230C01E
	strh r0,[r1,#0x10]	; 0230C020
	mov r0,#0x3	; 0230C022
	strh r0,[r1,#0x12]	; 0230C024
	mov r0,#0x38	; 0230C026
	strh r0,[r1,#0x14]	; 0230C028
	ldr r0,[sp,#0x0]	; 0230C02A
	ldrh r0,[r0,#0x8]	; 0230C02C
	strh r0,[r1,#0xc]	; 0230C02E
	ldr r0,[sp,#0x4]	; 0230C030
	ldrh r0,[r0,#0xa]	; 0230C032
	strh r0,[r1,#0xe]	; 0230C034
	add r0,sp,#0x2c	; 0230C036
	bl loc_0230B8B4	; 0230C038
	add r5,sp,#0x2c	; 0230C03C
loc_0230C03E:
	ldr r0,[r5,#0x24]	; 0230C03E
	cmp r0,#0x0	; 0230C040
	beq loc_0230C04E	; 0230C042
	add r0,r0,#0x1	; 0230C044
	bl loc_02305180	; 0230C046
	sub r0,#0x8	; 0230C04A
	strh r0,[r4,#0x3c]	; 0230C04C
loc_0230C04E:
	ldrh r1,[r5,#0xa]	; 0230C04E
	mov r0,#0x1	; 0230C050
	and r1,r0	; 0230C052
	cmp r1,#0x1	; 0230C054
	beq loc_0230C05A	; 0230C056
	b loc_0230C17E	; 0230C058
loc_0230C05A:
	ldr r0,[pool_0230C190]	; 0230C05A
	ldr r1,[r0,#0x0]	; 0230C05C
	ldr r0,[pool_0230C198]	; 0230C05E
	ldrh r1,[r1,r0]	; 0230C060
	ldrh r0,[r4,#0x3c]	; 0230C062
	add r0,#0x41	; 0230C064
	lsr r0,r0,#0x1	; 0230C066
	cmp r1,r0	; 0230C068
	bcs loc_0230C06E	; 0230C06A
	b loc_0230C17E	; 0230C06C
loc_0230C06E:
	ldr r0,[sp,#0x4]	; 0230C06E
	ldrh r0,[r0,#0xa]	; 0230C070
	strh r0,[r4,#0x2c]	; 0230C072
	add r0,r4,#0x4	; 0230C074
	ldr r1,[sp,#0x0]	; 0230C076
	add r1,#0x24	; 0230C078
	bl loc_02305B7C	; 0230C07A
	ldr r0,[sp,#0x4]	; 0230C07E
	ldrh r0,[r0,#0x8]	; 0230C080
	strh r0,[r4,#0x32]	; 0230C082
	ldr r0,[sp,#0x0]	; 0230C084
	ldrh r1,[r0,#0x12]	; 0230C086
	mov r0,#0xff	; 0230C088
	and r1,r0	; 0230C08A
	strh r1,[r4,#0x2]	; 0230C08C
	ldr r0,[r5,#0x24]	; 0230C08E
	cmp r0,#0x0	; 0230C090
	beq loc_0230C0C2	; 0230C092
	mov r0,#0x0	; 0230C094
	str r0,[sp,#0xc]	; 0230C096
	b loc_0230C0BA	; 0230C098
loc_0230C09A:
	ldr r1,[r5,#0x24]	; 0230C09A
	add r1,#0xa	; 0230C09C
	ldr r0,[sp,#0xc]	; 0230C09E
	add r0,r1,r0	; 0230C0A0
	bl loc_02305180	; 0230C0A2
	add r1,r0,#0x0	; 0230C0A6
	add r2,r4,#0x0	; 0230C0A8
	add r2,#0x40	; 0230C0AA
	ldr r0,[sp,#0xc]	; 0230C0AC
	add r0,r2,r0	; 0230C0AE
	bl loc_023051A4	; 0230C0B0
	ldr r0,[sp,#0xc]	; 0230C0B4
	add r0,r0,#0x1	; 0230C0B6
	str r0,[sp,#0xc]	; 0230C0B8
loc_0230C0BA:
	ldrh r1,[r4,#0x3c]	; 0230C0BA
	ldr r0,[sp,#0xc]	; 0230C0BC
	cmp r0,r1	; 0230C0BE
	bcc loc_0230C09A	; 0230C0C0
loc_0230C0C2:
	ldr r0,[r5,#0x18]	; 0230C0C2
	cmp r0,#0x0	; 0230C0C4
	beq loc_0230C100	; 0230C0C6
	add r0,r0,#0x1	; 0230C0C8
	bl loc_02305180	; 0230C0CA
	strh r0,[r4,#0xa]	; 0230C0CE
	mov r0,#0x0	; 0230C0D0
	str r0,[sp,#0x1c]	; 0230C0D2
	b loc_0230C0F6	; 0230C0D4
loc_0230C0D6:
	ldr r0,[r5,#0x18]	; 0230C0D6
	add r1,r0,#0x2	; 0230C0D8
	ldr r0,[sp,#0x1c]	; 0230C0DA
	add r0,r1,r0	; 0230C0DC
	bl loc_02305180	; 0230C0DE
	add r1,r0,#0x0	; 0230C0E2
	add r2,r4,#0x0	; 0230C0E4
	add r2,#0xc	; 0230C0E6
	ldr r0,[sp,#0x1c]	; 0230C0E8
	add r0,r2,r0	; 0230C0EA
	bl loc_023051A4	; 0230C0EC
	ldr r0,[sp,#0x1c]	; 0230C0F0
	add r0,r0,#0x1	; 0230C0F2
	str r0,[sp,#0x1c]	; 0230C0F4
loc_0230C0F6:
	ldrh r1,[r4,#0xa]	; 0230C0F6
	ldr r0,[sp,#0x1c]	; 0230C0F8
	cmp r0,r1	; 0230C0FA
	bcc loc_0230C0D6	; 0230C0FC
	b loc_0230C120	; 0230C0FE
loc_0230C100:
	mov r0,#0x0	; 0230C100
	str r0,[sp,#0x18]	; 0230C102
	strh r0,[r4,#0xa]	; 0230C104
	str r0,[sp,#0x20]	; 0230C106
loc_0230C108:
	add r1,r4,#0x0	; 0230C108
	add r1,#0xc	; 0230C10A
	ldr r0,[sp,#0x18]	; 0230C10C
	add r0,r1,r0	; 0230C10E
	ldr r1,[sp,#0x20]	; 0230C110
	bl loc_023051A4	; 0230C112
	ldr r0,[sp,#0x18]	; 0230C116
	add r0,r0,#0x1	; 0230C118
	str r0,[sp,#0x18]	; 0230C11A
	cmp r0,#0x20	; 0230C11C
	bcc loc_0230C108	; 0230C11E
loc_0230C120:
	ldrh r0,[r5,#0x14]	; 0230C120
	strh r0,[r4,#0x2e]	; 0230C122
	ldrh r0,[r5,#0x16]	; 0230C124
	strh r0,[r4,#0x30]	; 0230C126
	ldrh r0,[r5,#0x12]	; 0230C128
	strh r0,[r4,#0x36]	; 0230C12A
	ldr r0,[r5,#0x1c]	; 0230C12C
	cmp r0,#0x0	; 0230C12E
	beq loc_0230C13A	; 0230C130
	add r0,r0,#0x3	; 0230C132
	bl loc_02305180	; 0230C134
	strh r0,[r4,#0x38]	; 0230C138
loc_0230C13A:
	ldr r0,[r5,#0x20]	; 0230C13A
	cmp r0,#0x0	; 0230C13C
	beq loc_0230C148	; 0230C13E
	add r0,r0,#0x3	; 0230C140
	bl loc_02305180	; 0230C142
	strh r0,[r4,#0x34]	; 0230C146
loc_0230C148:
	ldrh r0,[r4,#0x3c]	; 0230C148
	add r0,#0x41	; 0230C14A
	lsr r0,r0,#0x1	; 0230C14C
	strh r0,[r4,#0x0]	; 0230C14E
	ldrh r1,[r6,#0x2]	; 0230C150
	ldrh r0,[r4,#0x0]	; 0230C152
	add r0,r1,r0	; 0230C154
	strh r0,[r6,#0x2]	; 0230C156
	ldrh r0,[r6,#0x8]	; 0230C158
	add r0,r0,#0x1	; 0230C15A
	strh r0,[r6,#0x8]	; 0230C15C
	ldrh r1,[r7,#0x4]	; 0230C15E
	ldrh r0,[r4,#0x0]	; 0230C160
	sub r0,r1,r0	; 0230C162
	strh r0,[r7,#0x4]	; 0230C164
	ldrh r0,[r7,#0x4]	; 0230C166
	cmp r0,#0x20	; 0230C168
	bcs loc_0230C186	; 0230C16A
	bl loc_02305358	; 0230C16C
	mov r0,#0x15	; 0230C170
	strh r0,[r7,#0x0]	; 0230C172
	mov r0,#0x2	; 0230C174
	mov r1,#0x0	; 0230C176
	bl loc_02304BE8	; 0230C178
	b loc_0230C186	; 0230C17C
loc_0230C17E:
	add r0,r4,#0x4	; 0230C17E
	ldr r1,[pool_0230C19C]	; 0230C180
	bl loc_02305B7C	; 0230C182
loc_0230C186:
	add sp,#0x54	; 0230C186
	pop {r4,r5,r6,r7}	; 0230C188
	pop {r3}	; 0230C18A
	bx r3	; 0230C18C
	.byte 0xC0, 0x46	; 0230C190
pool_0230C190:
loc_0230C190:
	.word FirmwareWlWorkPointerSlot	; 0230C190
pool_0230C194:
loc_0230C194:
	.word 0x000003D8	; 0230C194
pool_0230C198:
loc_0230C198:
	.word 0x000003DC	; 0230C198
pool_0230C19C:
loc_0230C19C:
	.word 0x0230D618	; 0230C19C

; ===== function loc_0230C1A0 =====
loc_0230C1A0:
	bx pc	; 0230C1A0
	.byte 0xC0, 0x46	; 0230C1A4
.arm

; ===== function loc_0230C1A4 =====
loc_0230C1A4:
	ldr pc,[pool_0230C1A8]	; 0230C1A4
pool_0230C1A8:
loc_0230C1A8:
	.word loc_037FF31C	; 0230C1A8
.thumb

; ===== function loc_0230C1AC =====
loc_0230C1AC:
	bx pc	; 0230C1AC
	.byte 0xC0, 0x46	; 0230C1B0
.arm

; ===== function loc_0230C1B0 =====
loc_0230C1B0:
	ldr pc,[pool_0230C1B4]	; 0230C1B0
pool_0230C1B4:
loc_0230C1B4:
	.word loc_037FF350	; 0230C1B4
.thumb

; ===== function loc_0230C1B8 =====
loc_0230C1B8:
	push {r4,lr}	; 0230C1B8
	sub sp,#0x30	; 0230C1BA
	add r4,r0,#0x0	; 0230C1BC
	ldrh r1,[r4,#0x24]	; 0230C1BE
	mov r0,#0x1	; 0230C1C0
	and r1,r0	; 0230C1C2
	cmp r1,#0x0	; 0230C1C4
	bne loc_0230C1D2	; 0230C1C6
	ldrh r1,[r4,#0x8]	; 0230C1C8
	ldr r0,[pool_0230C22C]	; 0230C1CA
	and r1,r0	; 0230C1CC
	cmp r1,#0x0	; 0230C1CE
	beq loc_0230C222	; 0230C1D0
loc_0230C1D2:
	mov r0,#0x0	; 0230C1D2
	str r0,[sp,#0x0]	; 0230C1D4
	ldr r0,[sp,#0x0]	; 0230C1D6
	add r1,sp,#0x4	; 0230C1D8
	mov r2,#0x28	; 0230C1DA
	bl loc_0230C23C	; 0230C1DC
	add r0,r4,#0x0	; 0230C1E0
	add r0,#0x2c	; 0230C1E2
	str r0,[sp,#0x4]	; 0230C1E4
	ldrh r0,[r4,#0x6]	; 0230C1E6
	add r1,sp,#0x0	; 0230C1E8
	strh r0,[r1,#0xc]	; 0230C1EA
	ldr r0,[pool_0230C230]	; 0230C1EC
	ldr r2,[r0,#0x0]	; 0230C1EE
	ldr r0,[pool_0230C234]	; 0230C1F0
	ldrh r0,[r2,r0]	; 0230C1F2
	lsl r0,r0,#0x1e	; 0230C1F4
	lsr r0,r0,#0x1f	; 0230C1F6
	cmp r0,#0x0	; 0230C1F8
	bne loc_0230C200	; 0230C1FA
	ldr r0,[pool_0230C238]	; 0230C1FC
	strh r0,[r1,#0x10]	; 0230C1FE
loc_0230C200:
	add r0,sp,#0x4	; 0230C200
	bl loc_0230B8B4	; 0230C202
	add r0,sp,#0x0	; 0230C206
	ldrh r1,[r0,#0xe]	; 0230C208
	mov r0,#0x1	; 0230C20A
	and r1,r0	; 0230C20C
	cmp r1,#0x1	; 0230C20E
	bne loc_0230C222	; 0230C210
	add r4,#0x1e	; 0230C212
	add r0,r4,#0x0	; 0230C214
	bl loc_02309BF0	; 0230C216
	cmp r0,#0x0	; 0230C21A
	beq loc_0230C222	; 0230C21C
	bl loc_0230A43C	; 0230C21E
loc_0230C222:
	add sp,#0x30	; 0230C222
	pop {r4}	; 0230C224
	pop {r3}	; 0230C226
	bx r3	; 0230C228
	.byte 0xC0, 0x46	; 0230C22C
pool_0230C22C:
loc_0230C22C:
	.word 0x00008000	; 0230C22C
pool_0230C230:
loc_0230C230:
	.word FirmwareWlWorkPointerSlot	; 0230C230
pool_0230C234:
loc_0230C234:
	.word 0x0000030E	; 0230C234
pool_0230C238:
loc_0230C238:
	.word 0x00000800	; 0230C238

; ===== function loc_0230C23C =====
loc_0230C23C:
	bx pc	; 0230C23C
	.byte 0xC0, 0x46	; 0230C240
.arm

; ===== function loc_0230C240 =====
loc_0230C240:
	ldr pc,[pool_0230C244]	; 0230C240
pool_0230C244:
loc_0230C244:
	.word loc_037FF350	; 0230C244
.thumb

; ===== function loc_0230C248 =====
loc_0230C248:
	push {r4,r5,r6,r7,lr}	; 0230C248
	sub sp,#0x4	; 0230C24A
	add r7,r0,#0x0	; 0230C24C
	ldr r0,[pool_0230C30C]	; 0230C24E
	ldr r1,[r0,#0x0]	; 0230C250
	ldr r0,[pool_0230C310]	; 0230C252
	add r5,r1,r0	; 0230C254
	ldr r0,[pool_0230C314]	; 0230C256
	add r4,r1,r0	; 0230C258
	add r6,r7,#0x0	; 0230C25A
	add r6,#0x2c	; 0230C25C
	ldrh r0,[r5,#0xc]	; 0230C25E
	cmp r0,#0x2	; 0230C260
	beq loc_0230C268	; 0230C262
	cmp r0,#0x3	; 0230C264
	bne loc_0230C304	; 0230C266
loc_0230C268:
	ldrh r0,[r4,#0x0]	; 0230C268
	cmp r0,#0x61	; 0230C26A
	bne loc_0230C304	; 0230C26C
	ldr r0,[r4,#0x18]	; 0230C26E
	add r0,#0x10	; 0230C270
	add r1,r7,#0x0	; 0230C272
	add r1,#0x1e	; 0230C274
	bl loc_023058B8	; 0230C276
	cmp r0,#0x0	; 0230C27A
	beq loc_0230C304	; 0230C27C
	bl loc_02305358	; 0230C27E
	ldrh r0,[r6,#0x2]	; 0230C282
	cmp r0,#0x0	; 0230C284
	bne loc_0230C2CC	; 0230C286
	ldrh r1,[r6,#0x4]	; 0230C288
	ldr r0,[pool_0230C318]	; 0230C28A
	and r1,r0	; 0230C28C
	lsl r0,r1,#0x10	; 0230C28E
	lsr r0,r0,#0x10	; 0230C290
	bl loc_02305BEC	; 0230C292
	add r0,r5,#0x0	; 0230C296
	add r0,#0x6a	; 0230C298
	ldrh r0,[r0,#0x0]	; 0230C29A
	bl loc_02309AD4	; 0230C29C
	add r0,r5,#0x0	; 0230C2A0
	add r0,#0x82	; 0230C2A2
	add r1,r7,#0x0	; 0230C2A4
	add r1,#0x1e	; 0230C2A6
	bl loc_02305B7C	; 0230C2A8
	add r7,#0x1e	; 0230C2AC
	add r0,r7,#0x0	; 0230C2AE
	bl loc_023076B4	; 0230C2B0
	add r1,r5,#0x0	; 0230C2B4
	add r1,#0x88	; 0230C2B6
	strh r0,[r1,#0x0]	; 0230C2B8
	add r0,r5,#0x0	; 0230C2BA
	add r0,#0x88	; 0230C2BC
	ldrh r0,[r0,#0x0]	; 0230C2BE
	mov r1,#0x40	; 0230C2C0
	bl loc_0230745C	; 0230C2C2
	mov r0,#0x40	; 0230C2C6
	bl loc_023070B8	; 0230C2C8
loc_0230C2CC:
	ldrh r0,[r6,#0x2]	; 0230C2CC
	cmp r0,#0x0	; 0230C2CE
	bne loc_0230C2E4	; 0230C2D0
	mov r1,#0x0	; 0230C2D2
	ldr r0,[r4,#0x1c]	; 0230C2D4
	strh r1,[r0,#0x4]	; 0230C2D6
	ldr r0,[r4,#0x1c]	; 0230C2D8
	strh r1,[r0,#0x6]	; 0230C2DA
	mov r0,#0x40	; 0230C2DC
	bl loc_023070B8	; 0230C2DE
	b loc_0230C2F0	; 0230C2E2
loc_0230C2E4:
	mov r1,#0xc	; 0230C2E4
	ldr r0,[r4,#0x1c]	; 0230C2E6
	strh r1,[r0,#0x4]	; 0230C2E8
	ldrh r1,[r6,#0x2]	; 0230C2EA
	ldr r0,[r4,#0x1c]	; 0230C2EC
	strh r1,[r0,#0x6]	; 0230C2EE
loc_0230C2F0:
	add r5,#0x6a	; 0230C2F0
	ldrh r1,[r5,#0x0]	; 0230C2F2
	ldr r0,[r4,#0x1c]	; 0230C2F4
	strh r1,[r0,#0x8]	; 0230C2F6
	mov r0,#0x63	; 0230C2F8
	strh r0,[r4,#0x0]	; 0230C2FA
	mov r0,#0x2	; 0230C2FC
	mov r1,#0x4	; 0230C2FE
	bl loc_02304BE8	; 0230C300
loc_0230C304:
	add sp,#0x4	; 0230C304
	pop {r4,r5,r6,r7}	; 0230C306
	pop {r3}	; 0230C308
	bx r3	; 0230C30A
pool_0230C30C:
loc_0230C30C:
	.word FirmwareWlWorkPointerSlot	; 0230C30C
pool_0230C310:
loc_0230C310:
	.word 0x00000318	; 0230C310
pool_0230C314:
loc_0230C314:
	.word 0x000003D8	; 0230C314
pool_0230C318:
loc_0230C318:
	.word 0x00000FFF	; 0230C318

; ===== function loc_0230C31C =====
loc_0230C31C:
	push {r4,r5,r6,r7,lr}	; 0230C31C
	sub sp,#0x34	; 0230C31E
	add r5,r0,#0x0	; 0230C320
	ldr r0,[pool_0230C408]	; 0230C322
	ldr r7,[r0,#0x0]	; 0230C324
	ldrh r6,[r5,#0x6]	; 0230C326
	add r4,r5,#0x0	; 0230C328
	add r4,#0x2c	; 0230C32A
	cmp r6,#0xa	; 0230C32C
	bls loc_0230C400	; 0230C32E
	ldr r0,[pool_0230C40C]	; 0230C330
	ldrh r0,[r7,r0]	; 0230C332
	cmp r0,#0x1	; 0230C334
	bne loc_0230C400	; 0230C336
	ldrh r0,[r5,#0x2]	; 0230C338
	str r0,[sp,#0x0]	; 0230C33A
	bl loc_0230728C	; 0230C33C
	cmp r0,#0x30	; 0230C340
	bcs loc_0230C358	; 0230C342
	add r5,#0x1e	; 0230C344
	add r0,r5,#0x0	; 0230C346
	mov r1,#0x6	; 0230C348
	bl loc_02309B1C	; 0230C34A
	cmp r0,#0x0	; 0230C34E
	beq loc_0230C400	; 0230C350
	bl loc_0230A43C	; 0230C352
	b loc_0230C400	; 0230C356
loc_0230C358:
	ldr r0,[sp,#0x0]	; 0230C358
	bl loc_0230728C	; 0230C35A
	cmp r0,#0x40	; 0230C35E
	bne loc_0230C374	; 0230C360
	ldr r0,[sp,#0x0]	; 0230C362
	mov r1,#0x30	; 0230C364
	bl loc_0230745C	; 0230C366
	add r5,#0x1e	; 0230C36A
	add r0,r5,#0x0	; 0230C36C
	mov r1,#0x1	; 0230C36E
	bl loc_02307A68	; 0230C370
loc_0230C374:
	mov r0,#0x0	; 0230C374
	str r0,[sp,#0x4]	; 0230C376
	ldr r0,[sp,#0x4]	; 0230C378
	add r1,sp,#0x8	; 0230C37A
	mov r2,#0x28	; 0230C37C
	bl loc_0230C41C	; 0230C37E
	add r0,r4,#0x0	; 0230C382
	add r0,#0xa	; 0230C384
	str r0,[sp,#0x8]	; 0230C386
	sub r6,#0xa	; 0230C388
	add r0,sp,#0x4	; 0230C38A
	strh r6,[r0,#0xc]	; 0230C38C
	ldr r1,[pool_0230C410]	; 0230C38E
	strh r1,[r0,#0x10]	; 0230C390
	add r0,sp,#0x8	; 0230C392
	bl loc_0230B8B4	; 0230C394
	ldrh r1,[r4,#0x0]	; 0230C398
	ldr r0,[pool_0230C414]	; 0230C39A
	add r2,r1,#0x0	; 0230C39C
	and r2,r0	; 0230C39E
	cmp r2,#0x0	; 0230C3A0
	bne loc_0230C3C2	; 0230C3A2
	ldr r0,[pool_0230C418]	; 0230C3A4
	ldrh r2,[r7,r0]	; 0230C3A6
	cmp r2,#0x0	; 0230C3A8
	bne loc_0230C3B4	; 0230C3AA
	lsl r0,r1,#0x1b	; 0230C3AC
	lsr r0,r0,#0x1f	; 0230C3AE
	cmp r0,#0x1	; 0230C3B0
	beq loc_0230C3C2	; 0230C3B2
loc_0230C3B4:
	cmp r2,#0x0	; 0230C3B4
	beq loc_0230C3C6	; 0230C3B6
	ldrh r0,[r4,#0x0]	; 0230C3B8
	lsl r0,r0,#0x1b	; 0230C3BA
	lsr r0,r0,#0x1f	; 0230C3BC
	cmp r0,#0x0	; 0230C3BE
	bne loc_0230C3C6	; 0230C3C0
loc_0230C3C2:
	mov r1,#0xa	; 0230C3C2
	b loc_0230C3F0	; 0230C3C4
loc_0230C3C6:
	ldr r0,[sp,#0x0]	; 0230C3C6
	bl loc_023073AC	; 0230C3C8
	add r2,sp,#0x4	; 0230C3CC
	ldrh r3,[r2,#0xe]	; 0230C3CE
	mov r1,#0x1	; 0230C3D0
	add r0,r3,#0x0	; 0230C3D2
	and r0,r1	; 0230C3D4
	cmp r0,#0x0	; 0230C3D6
	beq loc_0230C3F0	; 0230C3D8
	mov r0,#0x4	; 0230C3DA
	and r3,r0	; 0230C3DC
	cmp r3,#0x0	; 0230C3DE
	bne loc_0230C3E6	; 0230C3E0
	mov r1,#0x12	; 0230C3E2
	b loc_0230C3F0	; 0230C3E4
loc_0230C3E6:
	ldr r0,[sp,#0x0]	; 0230C3E6
	ldrh r1,[r2,#0x1a]	; 0230C3E8
	bl loc_0230739C	; 0230C3EA
	mov r1,#0x0	; 0230C3EE
loc_0230C3F0:
	ldr r0,[sp,#0x0]	; 0230C3F0
	ldr r2,[sp,#0x20]	; 0230C3F2
	bl loc_02309CF4	; 0230C3F4
	cmp r0,#0x0	; 0230C3F8
	beq loc_0230C400	; 0230C3FA
	bl loc_0230A43C	; 0230C3FC
loc_0230C400:
	add sp,#0x34	; 0230C400
	pop {r4,r5,r6,r7}	; 0230C402
	pop {r3}	; 0230C404
	bx r3	; 0230C406
pool_0230C408:
loc_0230C408:
	.word FirmwareWlWorkPointerSlot	; 0230C408
pool_0230C40C:
loc_0230C40C:
	.word 0x00000324	; 0230C40C
pool_0230C410:
loc_0230C410:
	.word 0x00000800	; 0230C410
pool_0230C414:
loc_0230C414:
	.word 0x0000FFC2	; 0230C414
pool_0230C418:
loc_0230C418:
	.word 0x00000308	; 0230C418

; ===== function loc_0230C41C =====
loc_0230C41C:
	bx pc	; 0230C41C
	.byte 0xC0, 0x46	; 0230C420
.arm

; ===== function loc_0230C420 =====
loc_0230C420:
	ldr pc,[pool_0230C424]	; 0230C420
pool_0230C424:
loc_0230C424:
	.word loc_037FF350	; 0230C424
.thumb

; ===== function loc_0230C428 =====
loc_0230C428:
	push {r4,r5,r6,r7,lr}	; 0230C428
	sub sp,#0x4	; 0230C42A
	add r7,r0,#0x0	; 0230C42C
	ldr r0,[pool_0230C4E8]	; 0230C42E
	ldr r1,[r0,#0x0]	; 0230C430
	ldr r0,[pool_0230C4EC]	; 0230C432
	add r5,r1,r0	; 0230C434
	ldr r0,[pool_0230C4F0]	; 0230C436
	add r4,r1,r0	; 0230C438
	add r6,r7,#0x0	; 0230C43A
	add r6,#0x2c	; 0230C43C
	ldrh r0,[r5,#0xc]	; 0230C43E
	cmp r0,#0x2	; 0230C440
	beq loc_0230C448	; 0230C442
	cmp r0,#0x3	; 0230C444
	bne loc_0230C4DE	; 0230C446
loc_0230C448:
	ldrh r0,[r4,#0x0]	; 0230C448
	cmp r0,#0x51	; 0230C44A
	bne loc_0230C4DE	; 0230C44C
	ldr r0,[r4,#0x18]	; 0230C44E
	add r0,#0x10	; 0230C450
	add r1,r7,#0x0	; 0230C452
	add r1,#0x1e	; 0230C454
	bl loc_023058B8	; 0230C456
	cmp r0,#0x0	; 0230C45A
	beq loc_0230C4DE	; 0230C45C
	bl loc_02305358	; 0230C45E
	ldrh r0,[r6,#0x2]	; 0230C462
	cmp r0,#0x0	; 0230C464
	bne loc_0230C4A6	; 0230C466
	ldrh r1,[r6,#0x4]	; 0230C468
	ldr r0,[pool_0230C4F4]	; 0230C46A
	and r1,r0	; 0230C46C
	lsl r0,r1,#0x10	; 0230C46E
	lsr r0,r0,#0x10	; 0230C470
	bl loc_02305BEC	; 0230C472
	add r0,r5,#0x0	; 0230C476
	add r0,#0x6a	; 0230C478
	ldrh r0,[r0,#0x0]	; 0230C47A
	bl loc_02309AD4	; 0230C47C
	add r0,r5,#0x0	; 0230C480
	add r0,#0x82	; 0230C482
	add r1,r7,#0x0	; 0230C484
	add r1,#0x1e	; 0230C486
	bl loc_02305B7C	; 0230C488
	add r7,#0x1e	; 0230C48C
	add r0,r7,#0x0	; 0230C48E
	bl loc_023076B4	; 0230C490
	add r1,r5,#0x0	; 0230C494
	add r1,#0x88	; 0230C496
	strh r0,[r1,#0x0]	; 0230C498
	add r0,r5,#0x0	; 0230C49A
	add r0,#0x88	; 0230C49C
	ldrh r0,[r0,#0x0]	; 0230C49E
	mov r1,#0x40	; 0230C4A0
	bl loc_0230745C	; 0230C4A2
loc_0230C4A6:
	ldrh r0,[r6,#0x2]	; 0230C4A6
	cmp r0,#0x0	; 0230C4A8
	bne loc_0230C4BE	; 0230C4AA
	mov r1,#0x0	; 0230C4AC
	ldr r0,[r4,#0x1c]	; 0230C4AE
	strh r1,[r0,#0x4]	; 0230C4B0
	ldr r0,[r4,#0x1c]	; 0230C4B2
	strh r1,[r0,#0x6]	; 0230C4B4
	mov r0,#0x40	; 0230C4B6
	bl loc_023070B8	; 0230C4B8
	b loc_0230C4CA	; 0230C4BC
loc_0230C4BE:
	mov r1,#0xc	; 0230C4BE
	ldr r0,[r4,#0x1c]	; 0230C4C0
	strh r1,[r0,#0x4]	; 0230C4C2
	ldrh r1,[r6,#0x2]	; 0230C4C4
	ldr r0,[r4,#0x1c]	; 0230C4C6
	strh r1,[r0,#0x6]	; 0230C4C8
loc_0230C4CA:
	add r5,#0x6a	; 0230C4CA
	ldrh r1,[r5,#0x0]	; 0230C4CC
	ldr r0,[r4,#0x1c]	; 0230C4CE
	strh r1,[r0,#0x8]	; 0230C4D0
	mov r0,#0x53	; 0230C4D2
	strh r0,[r4,#0x0]	; 0230C4D4
	mov r0,#0x2	; 0230C4D6
	mov r1,#0x3	; 0230C4D8
	bl loc_02304BE8	; 0230C4DA
loc_0230C4DE:
	add sp,#0x4	; 0230C4DE
	pop {r4,r5,r6,r7}	; 0230C4E0
	pop {r3}	; 0230C4E2
	bx r3	; 0230C4E4
	.byte 0xC0, 0x46	; 0230C4E8
pool_0230C4E8:
loc_0230C4E8:
	.word FirmwareWlWorkPointerSlot	; 0230C4E8
pool_0230C4EC:
loc_0230C4EC:
	.word 0x00000318	; 0230C4EC
pool_0230C4F0:
loc_0230C4F0:
	.word 0x000003D8	; 0230C4F0
pool_0230C4F4:
loc_0230C4F4:
	.word 0x00000FFF	; 0230C4F4

; ===== function loc_0230C4F8 =====
loc_0230C4F8:
	push {r4,r5,r6,r7,lr}	; 0230C4F8
	sub sp,#0x34	; 0230C4FA
	add r5,r0,#0x0	; 0230C4FC
	ldr r0,[pool_0230C604]	; 0230C4FE
	ldr r0,[r0,#0x0]	; 0230C500
	ldr r1,[pool_0230C608]	; 0230C502
	add r7,r0,r1	; 0230C504
	ldrh r1,[r5,#0x6]	; 0230C506
	str r1,[sp,#0x0]	; 0230C508
	add r4,r5,#0x0	; 0230C50A
	add r4,#0x2c	; 0230C50C
	cmp r1,#0x4	; 0230C50E
	bls loc_0230C5FC	; 0230C510
	ldr r1,[pool_0230C60C]	; 0230C512
	ldrh r0,[r0,r1]	; 0230C514
	cmp r0,#0x1	; 0230C516
	bne loc_0230C5FC	; 0230C518
	ldrh r6,[r5,#0x2]	; 0230C51A
	cmp r6,#0x0	; 0230C51C
	beq loc_0230C52A	; 0230C51E
	add r0,r6,#0x0	; 0230C520
	bl loc_0230728C	; 0230C522
	cmp r0,#0x30	; 0230C526
	bcs loc_0230C53E	; 0230C528
loc_0230C52A:
	add r5,#0x1e	; 0230C52A
	add r0,r5,#0x0	; 0230C52C
	mov r1,#0x6	; 0230C52E
	bl loc_02309B1C	; 0230C530
	cmp r0,#0x0	; 0230C534
	beq loc_0230C5FC	; 0230C536
	bl loc_0230A43C	; 0230C538
	b loc_0230C5FC	; 0230C53C
loc_0230C53E:
	add r0,r6,#0x0	; 0230C53E
	bl loc_0230728C	; 0230C540
	cmp r0,#0x40	; 0230C544
	bne loc_0230C55A	; 0230C546
	add r0,r6,#0x0	; 0230C548
	mov r1,#0x30	; 0230C54A
	bl loc_0230745C	; 0230C54C
	add r5,#0x1e	; 0230C550
	add r0,r5,#0x0	; 0230C552
	mov r1,#0x1	; 0230C554
	bl loc_02307A68	; 0230C556
loc_0230C55A:
	mov r0,#0x0	; 0230C55A
	str r0,[sp,#0x4]	; 0230C55C
	ldr r0,[sp,#0x4]	; 0230C55E
	add r1,sp,#0x8	; 0230C560
	mov r2,#0x28	; 0230C562
	bl loc_0230C614	; 0230C564
	add r0,r4,#0x4	; 0230C568
	str r0,[sp,#0x8]	; 0230C56A
	ldr r0,[sp,#0x0]	; 0230C56C
	sub r1,r0,#0x4	; 0230C56E
	add r0,sp,#0x4	; 0230C570
	strh r1,[r0,#0xc]	; 0230C572
	add r0,sp,#0x8	; 0230C574
	bl loc_0230B8B4	; 0230C576
	ldrh r1,[r4,#0x0]	; 0230C57A
	ldr r0,[pool_0230C610]	; 0230C57C
	add r2,r1,#0x0	; 0230C57E
	and r2,r0	; 0230C580
	cmp r2,#0x0	; 0230C582
	bne loc_0230C5BE	; 0230C584
	lsl r0,r1,#0x1f	; 0230C586
	lsr r0,r0,#0x1f	; 0230C588
	cmp r0,#0x0	; 0230C58A
	beq loc_0230C5BE	; 0230C58C
	ldrh r2,[r7,#0x18]	; 0230C58E
	cmp r2,#0x0	; 0230C590
	bne loc_0230C59C	; 0230C592
	lsl r0,r1,#0x1b	; 0230C594
	lsr r0,r0,#0x1f	; 0230C596
	cmp r0,#0x1	; 0230C598
	beq loc_0230C5BE	; 0230C59A
loc_0230C59C:
	cmp r2,#0x0	; 0230C59C
	beq loc_0230C5AA	; 0230C59E
	ldrh r0,[r4,#0x0]	; 0230C5A0
	lsl r0,r0,#0x1b	; 0230C5A2
	lsr r0,r0,#0x1f	; 0230C5A4
	cmp r0,#0x0	; 0230C5A6
	beq loc_0230C5BE	; 0230C5A8
loc_0230C5AA:
	ldrh r0,[r7,#0x1e]	; 0230C5AA
	lsl r0,r0,#0x1d	; 0230C5AC
	lsr r0,r0,#0x1f	; 0230C5AE
	cmp r0,#0x1	; 0230C5B0
	bne loc_0230C5C2	; 0230C5B2
	ldrh r0,[r4,#0x0]	; 0230C5B4
	lsl r0,r0,#0x1a	; 0230C5B6
	lsr r0,r0,#0x1f	; 0230C5B8
	cmp r0,#0x0	; 0230C5BA
	bne loc_0230C5C2	; 0230C5BC
loc_0230C5BE:
	mov r1,#0xa	; 0230C5BE
	b loc_0230C5EC	; 0230C5C0
loc_0230C5C2:
	add r0,r6,#0x0	; 0230C5C2
	bl loc_023073AC	; 0230C5C4
	add r2,sp,#0x4	; 0230C5C8
	ldrh r3,[r2,#0xe]	; 0230C5CA
	mov r1,#0x1	; 0230C5CC
	add r0,r3,#0x0	; 0230C5CE
	and r0,r1	; 0230C5D0
	cmp r0,#0x0	; 0230C5D2
	beq loc_0230C5EC	; 0230C5D4
	mov r0,#0x4	; 0230C5D6
	and r3,r0	; 0230C5D8
	cmp r3,#0x0	; 0230C5DA
	bne loc_0230C5E2	; 0230C5DC
	mov r1,#0x12	; 0230C5DE
	b loc_0230C5EC	; 0230C5E0
loc_0230C5E2:
	add r0,r6,#0x0	; 0230C5E2
	ldrh r1,[r2,#0x1a]	; 0230C5E4
	bl loc_0230739C	; 0230C5E6
	mov r1,#0x0	; 0230C5EA
loc_0230C5EC:
	add r0,r6,#0x0	; 0230C5EC
	ldr r2,[sp,#0x20]	; 0230C5EE
	bl loc_02309DEC	; 0230C5F0
	cmp r0,#0x0	; 0230C5F4
	beq loc_0230C5FC	; 0230C5F6
	bl loc_0230A43C	; 0230C5F8
loc_0230C5FC:
	add sp,#0x34	; 0230C5FC
	pop {r4,r5,r6,r7}	; 0230C5FE
	pop {r3}	; 0230C600
	bx r3	; 0230C602
pool_0230C604:
loc_0230C604:
	.word FirmwareWlWorkPointerSlot	; 0230C604
pool_0230C608:
loc_0230C608:
	.word 0x000002F0	; 0230C608
pool_0230C60C:
loc_0230C60C:
	.word 0x00000324	; 0230C60C
pool_0230C610:
loc_0230C610:
	.word 0x0000FFC2	; 0230C610

; ===== function loc_0230C614 =====
loc_0230C614:
	bx pc	; 0230C614
	.byte 0xC0, 0x46	; 0230C618
.arm

; ===== function loc_0230C618 =====
loc_0230C618:
	ldr pc,[pool_0230C61C]	; 0230C618
pool_0230C61C:
loc_0230C61C:
	.word loc_037FF350	; 0230C61C
.thumb

; ===== function loc_0230C620 =====
loc_0230C620:
	push {r4,r5,lr}	; 0230C620
	sub sp,#0x4	; 0230C622
	add r5,r0,#0x0	; 0230C624
	ldr r0,[pool_0230C6BC]	; 0230C626
	ldr r1,[r0,#0x0]	; 0230C628
	ldr r0,[pool_0230C6C0]	; 0230C62A
	add r1,r1,r0	; 0230C62C
	ldrh r4,[r5,#0x2]	; 0230C62E
	ldrh r0,[r1,#0xc]	; 0230C630
	cmp r0,#0x1	; 0230C632
	beq loc_0230C640	; 0230C634
	cmp r0,#0x2	; 0230C636
	beq loc_0230C68A	; 0230C638
	cmp r0,#0x3	; 0230C63A
	beq loc_0230C68A	; 0230C63C
	b loc_0230C6B2	; 0230C63E
loc_0230C640:
	add r0,r4,#0x0	; 0230C640
	bl loc_0230728C	; 0230C642
	cmp r0,#0x40	; 0230C646
	bne loc_0230C666	; 0230C648
	lsl r0,r4,#0x10	; 0230C64A
	lsr r0,r0,#0x10	; 0230C64C
	mov r1,#0x30	; 0230C64E
	bl loc_0230745C	; 0230C650
	add r0,r5,#0x0	; 0230C654
	add r0,#0x1e	; 0230C656
	ldrh r1,[r5,#0x2c]	; 0230C658
	bl loc_02307A68	; 0230C65A
	add r0,r4,#0x0	; 0230C65E
	bl loc_0230A5F4	; 0230C660
	b loc_0230C6B2	; 0230C664
loc_0230C666:
	cmp r0,#0x30	; 0230C666
	bne loc_0230C676	; 0230C668
	add r5,#0x1e	; 0230C66A
	add r0,r5,#0x0	; 0230C66C
	mov r1,#0x7	; 0230C66E
	bl loc_02309F6C	; 0230C670
	b loc_0230C680	; 0230C674
loc_0230C676:
	add r5,#0x1e	; 0230C676
	add r0,r5,#0x0	; 0230C678
	mov r1,#0x7	; 0230C67A
	bl loc_02309B1C	; 0230C67C
loc_0230C680:
	cmp r0,#0x0	; 0230C680
	beq loc_0230C6B2	; 0230C682
	bl loc_0230A43C	; 0230C684
	b loc_0230C6B2	; 0230C688
loc_0230C68A:
	ldrh r0,[r1,#0x8]	; 0230C68A
	cmp r0,#0x40	; 0230C68C
	bne loc_0230C6B2	; 0230C68E
	add r0,r5,#0x0	; 0230C690
	add r0,#0x1e	; 0230C692
	add r1,#0x82	; 0230C694
	bl loc_023058B8	; 0230C696
	cmp r0,#0x0	; 0230C69A
	beq loc_0230C6B2	; 0230C69C
	mov r0,#0x30	; 0230C69E
	bl loc_023070B8	; 0230C6A0
	bl loc_02305B8C	; 0230C6A4
	add r0,r5,#0x0	; 0230C6A8
	add r0,#0x1e	; 0230C6AA
	ldrh r1,[r5,#0x2c]	; 0230C6AC
	bl loc_02307A68	; 0230C6AE
loc_0230C6B2:
	add sp,#0x4	; 0230C6B2
	pop {r4,r5}	; 0230C6B4
	pop {r3}	; 0230C6B6
	bx r3	; 0230C6B8
	.byte 0xC0, 0x46	; 0230C6BC
pool_0230C6BC:
loc_0230C6BC:
	.word FirmwareWlWorkPointerSlot	; 0230C6BC
pool_0230C6C0:
loc_0230C6C0:
	.word 0x00000318	; 0230C6C0

; ===== function loc_0230C6C4 =====
loc_0230C6C4:
	push {r4,r5,r6,r7,lr}	; 0230C6C4
	sub sp,#0x5c	; 0230C6C6
	add r6,r0,#0x0	; 0230C6C8
	ldr r0,[pool_0230CA30]	; 0230C6CA
	ldr r0,[r0,#0x0]	; 0230C6CC
	ldr r1,[pool_0230CA34]	; 0230C6CE
	add r5,r0,r1	; 0230C6D0
	ldr r1,[pool_0230CA38]	; 0230C6D2
	add r4,r0,r1	; 0230C6D4
	ldr r1,[pool_0230CA3C]	; 0230C6D6
	add r1,r0,r1	; 0230C6D8
	str r1,[sp,#0x0]	; 0230C6DA
	ldr r1,[pool_0230CA40]	; 0230C6DC
	add r1,r0,r1	; 0230C6DE
	str r1,[sp,#0x4]	; 0230C6E0
	ldr r1,[pool_0230CA44]	; 0230C6E2
	add r0,r0,r1	; 0230C6E4
	ldr r1,[r0,#0x0]	; 0230C6E6
	add r1,r1,#0x1	; 0230C6E8
	str r1,[r0,#0x0]	; 0230C6EA
	add r0,r6,#0x0	; 0230C6EC
	add r0,#0x1e	; 0230C6EE
	bl loc_023075DC	; 0230C6F0
	str r0,[sp,#0xc]	; 0230C6F4
	lsl r0,r0,#0x10	; 0230C6F6
	lsr r0,r0,#0x10	; 0230C6F8
	strh r0,[r6,#0x2]	; 0230C6FA
	ldr r1,[sp,#0xc]	; 0230C6FC
	cmp r1,#0xff	; 0230C6FE
	bne loc_0230C704	; 0230C700
	b loc_0230CBC0	; 0230C702
loc_0230C704:
	ldrh r1,[r6,#0x12]	; 0230C704
	bl loc_0230744C	; 0230C706
	add r7,r6,#0x0	; 0230C70A
	add r7,#0x2c	; 0230C70C
	ldrh r0,[r6,#0x6]	; 0230C70E
	str r0,[sp,#0x8]	; 0230C710
	cmp r0,#0xc	; 0230C712
	bhi loc_0230C718	; 0230C714
	b loc_0230CBC0	; 0230C716
loc_0230C718:
	mov r0,#0x0	; 0230C718
	str r0,[sp,#0x30]	; 0230C71A
	ldr r0,[sp,#0x30]	; 0230C71C
	add r1,sp,#0x34	; 0230C71E
	mov r2,#0x28	; 0230C720
	bl loc_0230CBCC	; 0230C722
	add r0,r7,#0x0	; 0230C726
	add r0,#0xc	; 0230C728
	str r0,[sp,#0x34]	; 0230C72A
	ldr r0,[sp,#0x8]	; 0230C72C
	sub r0,#0xc	; 0230C72E
	str r0,[sp,#0x8]	; 0230C730
	add r1,sp,#0x18	; 0230C732
	strh r0,[r1,#0x24]	; 0230C734
	mov r0,#0x2	; 0230C736
	strh r0,[r1,#0x26]	; 0230C738
	ldrh r0,[r5,#0x1e]	; 0230C73A
	cmp r0,#0x0	; 0230C73C
	bne loc_0230C748	; 0230C73E
	ldrh r2,[r1,#0x26]	; 0230C740
	mov r0,#0x1	; 0230C742
	orr r2,r0	; 0230C744
	strh r2,[r1,#0x26]	; 0230C746
loc_0230C748:
	mov r1,#0x38	; 0230C748
	add r0,sp,#0x18	; 0230C74A
	strh r1,[r0,#0x28]	; 0230C74C
	ldrh r1,[r6,#0x8]	; 0230C74E
	strh r1,[r0,#0x20]	; 0230C750
	ldrh r1,[r7,#0xa]	; 0230C752
	strh r1,[r0,#0x22]	; 0230C754
	add r0,sp,#0x34	; 0230C756
	bl loc_0230B8B4	; 0230C758
	ldr r7,[sp,#0x50]	; 0230C75C
	cmp r7,#0x0	; 0230C75E
	beq loc_0230C784	; 0230C760
	ldrh r1,[r6,#0x16]	; 0230C762
	ldr r0,[pool_0230CA48]	; 0230C764
	and r1,r0	; 0230C766
	cmp r1,#0x0	; 0230C768
	beq loc_0230C784	; 0230C76A
	add r0,r7,#0x6	; 0230C76C
	bl loc_02305180	; 0230C76E
	str r0,[sp,#0x10]	; 0230C772
	add r0,r7,#0x7	; 0230C774
	bl loc_02305180	; 0230C776
	lsl r1,r0,#0x8	; 0230C77A
	ldr r0,[sp,#0x10]	; 0230C77C
	add r1,r0,r1	; 0230C77E
	ldr r0,[pool_0230CA4C]	; 0230C780
	strh r1,[r0,#0x0]	; 0230C782
loc_0230C784:
	ldrh r3,[r4,#0x0]	; 0230C784
	cmp r3,#0x13	; 0230C786
	bne loc_0230C7AA	; 0230C788
	ldr r0,[r4,#0x18]	; 0230C78A
	ldrh r0,[r0,#0x38]	; 0230C78C
	cmp r0,#0x1	; 0230C78E
	bne loc_0230C7AA	; 0230C790
	add r0,sp,#0x18	; 0230C792
	ldrh r1,[r0,#0x26]	; 0230C794
	mov r0,#0x9	; 0230C796
	and r1,r0	; 0230C798
	cmp r1,#0x9	; 0230C79A
	beq loc_0230C7A0	; 0230C79C
	b loc_0230CBB0	; 0230C79E
loc_0230C7A0:
	add r0,r6,#0x0	; 0230C7A0
	add r1,sp,#0x34	; 0230C7A2
	bl loc_0230BF5C	; 0230C7A4
	b loc_0230CBB0	; 0230C7A8
loc_0230C7AA:
	add r7,sp,#0x18	; 0230C7AA
	ldrh r2,[r7,#0x26]	; 0230C7AC
	mov r0,#0x8	; 0230C7AE
	add r1,r2,#0x0	; 0230C7B0
	and r1,r0	; 0230C7B2
	cmp r1,#0x0	; 0230C7B4
	bne loc_0230C7BA	; 0230C7B6
	b loc_0230CBB0	; 0230C7B8
loc_0230C7BA:
	ldrh r1,[r7,#0x28]	; 0230C7BA
	mov r0,#0x1	; 0230C7BC
	and r1,r0	; 0230C7BE
	cmp r1,#0x0	; 0230C7C0
	beq loc_0230C7D2	; 0230C7C2
	cmp r1,#0x0	; 0230C7C4
	bne loc_0230C7CA	; 0230C7C6
	b loc_0230CBB0	; 0230C7C8
loc_0230C7CA:
	and r2,r0	; 0230C7CA
	cmp r2,#0x0	; 0230C7CC
	bne loc_0230C7D2	; 0230C7CE
	b loc_0230CBB0	; 0230C7D0
loc_0230C7D2:
	cmp r3,#0x21	; 0230C7D2
	beq loc_0230C7D8	; 0230C7D4
	b loc_0230C8E6	; 0230C7D6
loc_0230C7D8:
	bl loc_02305358	; 0230C7D8
	add r0,sp,#0x18	; 0230C7DC
	ldrh r1,[r0,#0x26]	; 0230C7DE
	mov r2,#0x30	; 0230C7E0
	add r3,r1,#0x0	; 0230C7E2
	and r3,r2	; 0230C7E4
	cmp r3,#0x30	; 0230C7E6
	beq loc_0230C7F4	; 0230C7E8
	mov r0,#0xc	; 0230C7EA
	strh r0,[r4,#0x4]	; 0230C7EC
	mov r0,#0xa	; 0230C7EE
	strh r0,[r4,#0x6]	; 0230C7F0
	b loc_0230C8CE	; 0230C7F2
loc_0230C7F4:
	mov r2,#0x4	; 0230C7F4
	and r1,r2	; 0230C7F6
	cmp r1,#0x0	; 0230C7F8
	bne loc_0230C806	; 0230C7FA
	mov r0,#0xc	; 0230C7FC
	strh r0,[r4,#0x4]	; 0230C7FE
	mov r0,#0x12	; 0230C800
	strh r0,[r4,#0x6]	; 0230C802
	b loc_0230C8CE	; 0230C804
loc_0230C806:
	ldrh r2,[r6,#0x34]	; 0230C806
	ldr r1,[pool_0230CA50]	; 0230C808
	cmp r2,r1	; 0230C80A
	bls loc_0230C818	; 0230C80C
	mov r0,#0xc	; 0230C80E
	strh r0,[r4,#0x4]	; 0230C810
	mov r0,#0x1	; 0230C812
	strh r0,[r4,#0x6]	; 0230C814
	b loc_0230C8CE	; 0230C816
loc_0230C818:
	mov r1,#0x0	; 0230C818
	strh r1,[r4,#0x4]	; 0230C81A
	ldrh r3,[r0,#0x28]	; 0230C81C
	mov r2,#0x2	; 0230C81E
	and r3,r2	; 0230C820
	cmp r3,#0x0	; 0230C822
	beq loc_0230C834	; 0230C824
	ldrh r3,[r0,#0x26]	; 0230C826
	and r3,r2	; 0230C828
	cmp r3,#0x0	; 0230C82A
	bne loc_0230C834	; 0230C82C
	ldrh r0,[r0,#0x2e]	; 0230C82E
	bl loc_02305F8C	; 0230C830
loc_0230C834:
	ldr r0,[sp,#0xc]	; 0230C834
	add r1,sp,#0x18	; 0230C836
	ldrh r1,[r1,#0x32]	; 0230C838
	bl loc_0230739C	; 0230C83A
	ldrh r0,[r5,#0xc]	; 0230C83E
	cmp r0,#0x2	; 0230C840
	bne loc_0230C892	; 0230C842
	ldr r7,[sp,#0x58]	; 0230C844
	cmp r7,#0x0	; 0230C846
	beq loc_0230C884	; 0230C848
	add r0,r7,#0x6	; 0230C84A
	bl loc_02305180	; 0230C84C
	str r0,[sp,#0x14]	; 0230C850
	add r0,r7,#0x7	; 0230C852
	bl loc_02305180	; 0230C854
	lsl r1,r0,#0x8	; 0230C858
	ldr r0,[sp,#0x14]	; 0230C85A
	add r0,r0,r1	; 0230C85C
	lsl r0,r0,#0x10	; 0230C85E
	lsr r0,r0,#0x10	; 0230C860
	mov r1,#0x1	; 0230C862
	bl loc_02306624	; 0230C864
	ldr r0,[sp,#0x58]	; 0230C868
	add r0,#0x8	; 0230C86A
	bl loc_02305180	; 0230C86C
	add r7,r0,#0x0	; 0230C870
	ldr r0,[sp,#0x58]	; 0230C872
	add r0,#0x9	; 0230C874
	bl loc_02305180	; 0230C876
	lsl r0,r0,#0x8	; 0230C87A
	add r1,r7,r0	; 0230C87C
	ldr r0,[pool_0230CA54]	; 0230C87E
	strh r1,[r0,#0x0]	; 0230C880
	b loc_0230C892	; 0230C882
loc_0230C884:
	ldr r0,[pool_0230CA58]	; 0230C884
	mov r1,#0x1	; 0230C886
	bl loc_02306624	; 0230C888
	mov r1,#0x0	; 0230C88C
	ldr r0,[pool_0230CA54]	; 0230C88E
	strh r1,[r0,#0x0]	; 0230C890
loc_0230C892:
	ldr r0,[sp,#0x54]	; 0230C892
	add r0,r0,#0x3	; 0230C894
	bl loc_02305180	; 0230C896
	bl loc_02306258	; 0230C89A
	ldr r0,[sp,#0x54]	; 0230C89E
	add r0,r0,#0x2	; 0230C8A0
	bl loc_02305180	; 0230C8A2
	add r1,r5,#0x0	; 0230C8A6
	add r1,#0x76	; 0230C8A8
	strh r0,[r1,#0x0]	; 0230C8AA
	ldrh r0,[r6,#0x34]	; 0230C8AC
	bl loc_02306288	; 0230C8AE
	mov r0,#0x1	; 0230C8B2
	strh r0,[r5,#0x12]	; 0230C8B4
	strh r0,[r5,#0x1a]	; 0230C8B6
	ldrh r0,[r5,#0xc]	; 0230C8B8
	cmp r0,#0x2	; 0230C8BA
	bne loc_0230C8C4	; 0230C8BC
	mov r1,#0x3	; 0230C8BE
	ldr r0,[pool_0230CA5C]	; 0230C8C0
	strh r1,[r0,#0x0]	; 0230C8C2
loc_0230C8C4:
	ldr r2,[pool_0230CA60]	; 0230C8C4
	ldrh r1,[r2,#0x0]	; 0230C8C6
	mov r0,#0x1	; 0230C8C8
	orr r1,r0	; 0230C8CA
	strh r1,[r2,#0x0]	; 0230C8CC
loc_0230C8CE:
	ldr r0,[r4,#0x1c]	; 0230C8CE
	add r0,#0x8	; 0230C8D0
	add r1,r6,#0x0	; 0230C8D2
	add r1,#0x1e	; 0230C8D4
	bl loc_02305B7C	; 0230C8D6
	mov r0,#0x25	; 0230C8DA
	strh r0,[r4,#0x0]	; 0230C8DC
	mov r0,#0x2	; 0230C8DE
	mov r1,#0x1	; 0230C8E0
	bl loc_02304BE8	; 0230C8E2
loc_0230C8E6:
	ldrh r0,[r5,#0xc]	; 0230C8E6
	cmp r0,#0x2	; 0230C8E8
	beq loc_0230C8F2	; 0230C8EA
	cmp r0,#0x3	; 0230C8EC
	beq loc_0230C982	; 0230C8EE
	b loc_0230CB9E	; 0230C8F0
loc_0230C8F2:
	ldr r4,[sp,#0x58]	; 0230C8F2
	cmp r4,#0x0	; 0230C8F4
	beq loc_0230C982	; 0230C8F6
	add r0,r4,#0x6	; 0230C8F8
	bl loc_02305180	; 0230C8FA
	add r7,r0,#0x0	; 0230C8FE
	add r0,r4,#0x7	; 0230C900
	bl loc_02305180	; 0230C902
	lsl r0,r0,#0x8	; 0230C906
	add r0,r7,r0	; 0230C908
	lsl r0,r0,#0x10	; 0230C90A
	lsr r0,r0,#0x10	; 0230C90C
	mov r1,#0x0	; 0230C90E
	bl loc_02306624	; 0230C910
	ldr r0,[sp,#0x58]	; 0230C914
	add r0,#0x8	; 0230C916
	bl loc_02305180	; 0230C918
	add r4,r0,#0x0	; 0230C91C
	ldr r0,[sp,#0x58]	; 0230C91E
	add r0,#0x9	; 0230C920
	bl loc_02305180	; 0230C922
	lsl r0,r0,#0x8	; 0230C926
	add r1,r4,r0	; 0230C928
	ldr r0,[pool_0230CA54]	; 0230C92A
	strh r1,[r0,#0x0]	; 0230C92C
	ldr r0,[sp,#0x58]	; 0230C92E
	add r0,r0,#0x1	; 0230C930
	bl loc_02305180	; 0230C932
	sub r0,#0x8	; 0230C936
	add r1,r5,#0x0	; 0230C938
	add r1,#0xa0	; 0230C93A
	strh r0,[r1,#0x0]	; 0230C93C
	add r0,r5,#0x0	; 0230C93E
	add r0,#0xa0	; 0230C940
	ldrh r2,[r0,#0x0]	; 0230C942
	cmp r2,#0x0	; 0230C944
	beq loc_0230C982	; 0230C946
	ldr r0,[sp,#0x58]	; 0230C948
	mov r1,#0x1	; 0230C94A
	add r3,r0,#0x0	; 0230C94C
	and r3,r1	; 0230C94E
	cmp r3,#0x0	; 0230C950
	beq loc_0230C96C	; 0230C952
	add r0,#0x9	; 0230C954
	add r1,r5,#0x0	; 0230C956
	add r1,#0x9c	; 0230C958
	ldr r1,[r1,#0x0]	; 0230C95A
	add r2,r2,#0x2	; 0230C95C
	bl loc_0230CBD8	; 0230C95E
	mov r1,#0x1	; 0230C962
	add r0,r5,#0x0	; 0230C964
	add r0,#0xa2	; 0230C966
	strh r1,[r0,#0x0]	; 0230C968
	b loc_0230C982	; 0230C96A
loc_0230C96C:
	add r0,#0xa	; 0230C96C
	add r1,r5,#0x0	; 0230C96E
	add r1,#0x9c	; 0230C970
	ldr r1,[r1,#0x0]	; 0230C972
	add r2,r2,#0x1	; 0230C974
	bl loc_0230CBE4	; 0230C976
	mov r1,#0x0	; 0230C97A
	add r0,r5,#0x0	; 0230C97C
	add r0,#0xa2	; 0230C97E
	strh r1,[r0,#0x0]	; 0230C980
loc_0230C982:
	mov r1,#0x0	; 0230C982
	add r0,r5,#0x0	; 0230C984
	add r0,#0x80	; 0230C986
	strh r1,[r0,#0x0]	; 0230C988
	ldr r0,[sp,#0xc]	; 0230C98A
	bl loc_02307360	; 0230C98C
	add r0,r6,#0x0	; 0230C990
	add r0,#0x2c	; 0230C992
	ldmia r0!,{r2,r3}	; 0230C994
	add r0,sp,#0x18	; 0230C996
	stmia r0!,{r2,r3}	; 0230C998
	add r0,r5,#0x0	; 0230C99A
	add r0,#0x6e	; 0230C99C
	ldrh r0,[r0,#0x0]	; 0230C99E
	lsl r4,r0,#0xa	; 0230C9A0
	mov r7,#0x0	; 0230C9A2
	ldr r0,[sp,#0x18]	; 0230C9A4
	ldr r1,[sp,#0x1c]	; 0230C9A6
	add r2,r4,#0x0	; 0230C9A8
	add r3,r7,#0x0	; 0230C9AA
	bl loc_0230CBF0	; 0230C9AC
	str r0,[sp,#0x18]	; 0230C9B0
	str r1,[sp,#0x1c]	; 0230C9B2
	lsl r3,r7,#0	; 0230C9B4
	mov r2,#0x1	; 0230C9B6
	add r0,r0,r2	; 0230C9B8
	adc r1,r3	; 0230C9BA
	str r0,[sp,#0x18]	; 0230C9BC
	str r1,[sp,#0x1c]	; 0230C9BE
	add r2,r4,#0x0	; 0230C9C0
	bl loc_0230CBFC	; 0230C9C2
	str r0,[sp,#0x18]	; 0230C9C6
	str r1,[sp,#0x1c]	; 0230C9C8
	add r0,sp,#0x18	; 0230C9CA
	ldrh r2,[r0,#0x6]	; 0230C9CC
	ldr r1,[pool_0230CA64]	; 0230C9CE
	strh r2,[r1,#0x0]	; 0230C9D0
	ldrh r2,[r0,#0x4]	; 0230C9D2
	ldr r1,[pool_0230CA68]	; 0230C9D4
	strh r2,[r1,#0x0]	; 0230C9D6
	ldrh r2,[r0,#0x2]	; 0230C9D8
	ldr r1,[pool_0230CA6C]	; 0230C9DA
	strh r2,[r1,#0x0]	; 0230C9DC
	ldrh r1,[r0,#0x0]	; 0230C9DE
	mov r0,#0x1	; 0230C9E0
	orr r1,r0	; 0230C9E2
	ldr r0,[pool_0230CA70]	; 0230C9E4
	strh r1,[r0,#0x0]	; 0230C9E6
	ldrh r0,[r5,#0xc]	; 0230C9E8
	cmp r0,#0x2	; 0230C9EA
	bne loc_0230CAD2	; 0230C9EC
	ldrh r0,[r5,#0x1a]	; 0230C9EE
	cmp r0,#0x0	; 0230C9F0
	beq loc_0230CAD2	; 0230C9F2
	ldr r0,[sp,#0x18]	; 0230C9F4
	ldr r1,[sp,#0x1c]	; 0230C9F6
	sub r0,r0,r4	; 0230C9F8
	sbc r1,r7	; 0230C9FA
	str r0,[sp,#0x18]	; 0230C9FC
	str r1,[sp,#0x1c]	; 0230C9FE
	bl loc_0230CC08	; 0230CA00
	ldr r2,[pool_0230CA74]	; 0230CA04
	ldrh r1,[r2,#0x0]	; 0230CA06
	add r4,sp,#0x18	; 0230CA08
	strh r1,[r4,#0x8]	; 0230CA0A
	ldr r1,[pool_0230CA78]	; 0230CA0C
	ldrh r3,[r1,#0x0]	; 0230CA0E
	strh r3,[r4,#0xa]	; 0230CA10
	ldr r7,[pool_0230CA7C]	; 0230CA12
	ldrh r3,[r7,#0x0]	; 0230CA14
	strh r3,[r4,#0xc]	; 0230CA16
	ldr r3,[pool_0230CA80]	; 0230CA18
	ldrh r3,[r3,#0x0]	; 0230CA1A
	strh r3,[r4,#0xe]	; 0230CA1C
	ldrh r2,[r2,#0x0]	; 0230CA1E
	strh r2,[r4,#0x10]	; 0230CA20
	ldrh r1,[r1,#0x0]	; 0230CA22
	strh r1,[r4,#0x12]	; 0230CA24
	ldrh r1,[r7,#0x0]	; 0230CA26
	strh r1,[r4,#0x14]	; 0230CA28
	ldr r1,[pool_0230CA80]	; 0230CA2A
	b loc_0230CA84	; 0230CA2C
	.byte 0xC0, 0x46	; 0230CA30
pool_0230CA30:
loc_0230CA30:
	.word FirmwareWlWorkPointerSlot	; 0230CA30
pool_0230CA34:
loc_0230CA34:
	.word 0x00000318	; 0230CA34
pool_0230CA38:
loc_0230CA38:
	.word 0x000003D8	; 0230CA38
pool_0230CA3C:
loc_0230CA3C:
	.word 0x000002F0	; 0230CA3C
pool_0230CA40:
loc_0230CA40:
	.word 0x00000150	; 0230CA40
pool_0230CA44:
loc_0230CA44:
	.word 0x00000544	; 0230CA44
pool_0230CA48:
loc_0230CA48:
	.word 0x00008000	; 0230CA48
pool_0230CA4C:
loc_0230CA4C:
	.word REG_WIFI_CONTENTFREE	; 0230CA4C
pool_0230CA50:
loc_0230CA50:
	.word 0x000003E8	; 0230CA50
pool_0230CA54:
loc_0230CA54:
	.word FirmwareWlAdjustedTimeSlot	; 0230CA54
pool_0230CA58:
loc_0230CA58:
	.word 0x0000FFFF	; 0230CA58
pool_0230CA5C:
loc_0230CA5C:
	.word REG_WIFI_UNKNOWN_048	; 0230CA5C
pool_0230CA60:
loc_0230CA60:
	.word REG_WIFI_POWER_TX	; 0230CA60
pool_0230CA64:
loc_0230CA64:
	.word REG_WIFI_US_COMPARE3	; 0230CA64
pool_0230CA68:
loc_0230CA68:
	.word REG_WIFI_US_COMPARE2	; 0230CA68
pool_0230CA6C:
loc_0230CA6C:
	.word REG_WIFI_US_COMPARE1	; 0230CA6C
pool_0230CA70:
loc_0230CA70:
	.word REG_WIFI_US_COMPARE0	; 0230CA70
pool_0230CA74:
loc_0230CA74:
	.word REG_WIFI_US_COUNT0	; 0230CA74
pool_0230CA78:
loc_0230CA78:
	.word REG_WIFI_US_COUNT1	; 0230CA78
pool_0230CA7C:
loc_0230CA7C:
	.word REG_WIFI_US_COUNT2	; 0230CA7C
pool_0230CA80:
loc_0230CA80:
	.word REG_WIFI_US_COUNT3	; 0230CA80
loc_0230CA84:
	ldrh r1,[r1,#0x0]	; 0230CA84
	strh r1,[r4,#0x16]	; 0230CA86
	bl loc_0230CC14	; 0230CA88
	lsl r0,r4,#0	; 0230CA8C
	ldrh r1,[r0,#0x8]	; 0230CA8E
	ldrh r0,[r0,#0x10]	; 0230CA90
	cmp r1,r0	; 0230CA92
	bcs loc_0230CAAA	; 0230CA94
	ldr r2,[sp,#0x20]	; 0230CA96
	ldr r3,[sp,#0x24]	; 0230CA98
	ldr r1,[sp,#0x18]	; 0230CA9A
	ldr r0,[sp,#0x1c]	; 0230CA9C
	sub r1,r2,r1	; 0230CA9E
	sbc r3,r0	; 0230CAA0
	lsl r0,r3,#0x16	; 0230CAA2
	lsr r1,r1,#0xa	; 0230CAA4
	orr r1,r0	; 0230CAA6
	b loc_0230CABC	; 0230CAA8
loc_0230CAAA:
	ldr r2,[sp,#0x28]	; 0230CAAA
	ldr r3,[sp,#0x2c]	; 0230CAAC
	ldr r1,[sp,#0x18]	; 0230CAAE
	ldr r0,[sp,#0x1c]	; 0230CAB0
	sub r1,r2,r1	; 0230CAB2
	sbc r3,r0	; 0230CAB4
	lsl r0,r3,#0x16	; 0230CAB6
	lsr r1,r1,#0xa	; 0230CAB8
	orr r1,r0	; 0230CABA
loc_0230CABC:
	ldr r0,[sp,#0x0]	; 0230CABC
	ldrh r0,[r0,#0x20]	; 0230CABE
	cmp r1,r0	; 0230CAC0
	bcs loc_0230CACC	; 0230CAC2
	sub r1,r0,r1	; 0230CAC4
	ldr r0,[pool_0230CBC8]	; 0230CAC6
	strh r1,[r0,#0x0]	; 0230CAC8
	b loc_0230CAD2	; 0230CACA
loc_0230CACC:
	mov r1,#0x0	; 0230CACC
	ldr r0,[pool_0230CBC8]	; 0230CACE
	strh r1,[r0,#0x0]	; 0230CAD0
loc_0230CAD2:
	ldrh r0,[r5,#0x8]	; 0230CAD2
	cmp r0,#0x40	; 0230CAD4
	bne loc_0230CB9E	; 0230CAD6
	ldr r1,[sp,#0x54]	; 0230CAD8
	cmp r1,#0x0	; 0230CADA
	beq loc_0230CB9E	; 0230CADC
	ldrh r0,[r5,#0xe]	; 0230CADE
	cmp r0,#0x1	; 0230CAE0
	bne loc_0230CB9E	; 0230CAE2
	add r0,r1,#0x2	; 0230CAE4
	bl loc_02305180	; 0230CAE6
	add r1,r5,#0x0	; 0230CAEA
	add r1,#0x76	; 0230CAEC
	ldrh r1,[r1,#0x0]	; 0230CAEE
	cmp r1,r0	; 0230CAF0
	beq loc_0230CAFA	; 0230CAF2
	add r1,r5,#0x0	; 0230CAF4
	add r1,#0x76	; 0230CAF6
	strh r0,[r1,#0x0]	; 0230CAF8
loc_0230CAFA:
	mov r2,#0x0	; 0230CAFA
	add r1,r5,#0x0	; 0230CAFC
	add r1,#0x8e	; 0230CAFE
	strh r2,[r1,#0x0]	; 0230CB00
	cmp r0,#0x0	; 0230CB02
	bne loc_0230CB24	; 0230CB04
	ldr r0,[sp,#0x54]	; 0230CB06
	add r0,r0,#0x4	; 0230CB08
	bl loc_02305180	; 0230CB0A
	mov r1,#0x1	; 0230CB0E
	and r0,r1	; 0230CB10
	cmp r0,#0x0	; 0230CB12
	beq loc_0230CB24	; 0230CB14
	add r0,r5,#0x0	; 0230CB16
	add r0,#0x8e	; 0230CB18
	ldrh r2,[r0,#0x0]	; 0230CB1A
	orr r2,r1	; 0230CB1C
	add r0,r5,#0x0	; 0230CB1E
	add r0,#0x8e	; 0230CB20
	strh r2,[r0,#0x0]	; 0230CB22
loc_0230CB24:
	ldr r0,[sp,#0x54]	; 0230CB24
	add r0,r0,#0x4	; 0230CB26
	bl loc_02305180	; 0230CB28
	mov r1,#0xfe	; 0230CB2C
	add r7,r0,#0x0	; 0230CB2E
	and r7,r1	; 0230CB30
	lsl r4,r7,#0x3	; 0230CB32
	ldr r0,[sp,#0x54]	; 0230CB34
	add r0,r0,#0x1	; 0230CB36
	bl loc_02305180	; 0230CB38
	add r0,r7,r0	; 0230CB3C
	sub r0,r0,#0x3	; 0230CB3E
	lsl r1,r0,#0x3	; 0230CB40
	add r0,r5,#0x0	; 0230CB42
	add r0,#0x6a	; 0230CB44
	ldrh r0,[r0,#0x0]	; 0230CB46
	cmp r4,r0	; 0230CB48
	bhi loc_0230CB80	; 0230CB4A
	cmp r0,r1	; 0230CB4C
	bhi loc_0230CB80	; 0230CB4E
	sub r4,r0,r4	; 0230CB50
	ldr r0,[sp,#0x54]	; 0230CB52
	add r1,r0,#0x5	; 0230CB54
	lsr r0,r4,#0x3	; 0230CB56
	add r0,r1,r0	; 0230CB58
	bl loc_02305180	; 0230CB5A
	mov r2,#0x1	; 0230CB5E
	mov r1,#0x7	; 0230CB60
	and r4,r1	; 0230CB62
	lsl r2,r4	; 0230CB64
	and r2,r0	; 0230CB66
	cmp r2,#0x0	; 0230CB68
	beq loc_0230CB80	; 0230CB6A
	add r0,r5,#0x0	; 0230CB6C
	add r0,#0x8e	; 0230CB6E
	ldrh r1,[r0,#0x0]	; 0230CB70
	mov r0,#0x2	; 0230CB72
	orr r1,r0	; 0230CB74
	add r0,r5,#0x0	; 0230CB76
	add r0,#0x8e	; 0230CB78
	strh r1,[r0,#0x0]	; 0230CB7A
	bl loc_0230A3DC	; 0230CB7C
loc_0230CB80:
	ldr r0,[sp,#0x4]	; 0230CB80
	ldrh r0,[r0,#0x20]	; 0230CB82
	cmp r0,#0x0	; 0230CB84
	bne loc_0230CB9E	; 0230CB86
	ldr r0,[sp,#0x4]	; 0230CB88
	ldrh r0,[r0,#0x2c]	; 0230CB8A
	cmp r0,#0x0	; 0230CB8C
	bne loc_0230CB9E	; 0230CB8E
	add r5,#0x8e	; 0230CB90
	ldrh r0,[r5,#0x0]	; 0230CB92
	cmp r0,#0x0	; 0230CB94
	bne loc_0230CB9E	; 0230CB96
	mov r0,#0x1	; 0230CB98
	bl loc_02305E90	; 0230CB9A
loc_0230CB9E:
	ldr r0,[sp,#0x0]	; 0230CB9E
	ldrh r0,[r0,#0x1e]	; 0230CBA0
	lsl r0,r0,#0x19	; 0230CBA2
	lsr r0,r0,#0x1f	; 0230CBA4
	cmp r0,#0x0	; 0230CBA6
	beq loc_0230CBB0	; 0230CBA8
	add r0,r6,#0x0	; 0230CBAA
	bl loc_023078C8	; 0230CBAC
loc_0230CBB0:
	ldr r2,[sp,#0x4c]	; 0230CBB0
	cmp r2,#0x0	; 0230CBB2
	beq loc_0230CBC0	; 0230CBB4
	add r0,sp,#0x18	; 0230CBB6
	ldrh r0,[r0,#0x2e]	; 0230CBB8
	add r1,r6,#0x0	; 0230CBBA
	bl loc_0230D1F0	; 0230CBBC
loc_0230CBC0:
	add sp,#0x5c	; 0230CBC0
	pop {r4,r5,r6,r7}	; 0230CBC2
	pop {r3}	; 0230CBC4
	bx r3	; 0230CBC6
pool_0230CBC8:
loc_0230CBC8:
	.word REG_WIFI_POST_BEACON	; 0230CBC8

; ===== function loc_0230CBCC =====
loc_0230CBCC:
	bx pc	; 0230CBCC
	.byte 0xC0, 0x46	; 0230CBD0
.arm

; ===== function loc_0230CBD0 =====
loc_0230CBD0:
	ldr pc,[pool_0230CBD4]	; 0230CBD0
pool_0230CBD4:
loc_0230CBD4:
	.word loc_037FF350	; 0230CBD4
.thumb

; ===== function loc_0230CBD8 =====
loc_0230CBD8:
	bx pc	; 0230CBD8
	.byte 0xC0, 0x46	; 0230CBDC
.arm

; ===== function loc_0230CBDC =====
loc_0230CBDC:
	ldr pc,[pool_0230CBE0]	; 0230CBDC
pool_0230CBE0:
loc_0230CBE0:
	.word P2_Entry_037FF334	; 0230CBE0
.thumb

; ===== function loc_0230CBE4 =====
loc_0230CBE4:
	bx pc	; 0230CBE4
	.byte 0xC0, 0x46	; 0230CBE8
.arm

; ===== function loc_0230CBE8 =====
loc_0230CBE8:
	ldr pc,[pool_0230CBEC]	; 0230CBE8
pool_0230CBEC:
loc_0230CBEC:
	.word P2_Entry_037FF334	; 0230CBEC
.thumb

; ===== function loc_0230CBF0 =====
loc_0230CBF0:
	bx pc	; 0230CBF0
	.byte 0xC0, 0x46	; 0230CBF4
.arm

; ===== function loc_0230CBF4 =====
loc_0230CBF4:
	ldr pc,[pool_0230CBF8]	; 0230CBF4
pool_0230CBF8:
loc_0230CBF8:
	.word loc_0380494C	; 0230CBF8
.thumb

; ===== function loc_0230CBFC =====
loc_0230CBFC:
	bx pc	; 0230CBFC
	.byte 0xC0, 0x46	; 0230CC00
.arm

; ===== function loc_0230CC00 =====
loc_0230CC00:
	ldr pc,[pool_0230CC04]	; 0230CC00
pool_0230CC04:
loc_0230CC04:
	.word loc_03804B54	; 0230CC04
.thumb

; ===== function loc_0230CC08 =====
loc_0230CC08:
	bx pc	; 0230CC08
	.byte 0xC0, 0x46	; 0230CC0C
.arm

; ===== function loc_0230CC0C =====
loc_0230CC0C:
	ldr pc,[pool_0230CC10]	; 0230CC0C
pool_0230CC10:
loc_0230CC10:
	.word loc_037FF104	; 0230CC10
.thumb

; ===== function loc_0230CC14 =====
loc_0230CC14:
	bx pc	; 0230CC14
	.byte 0xC0, 0x46	; 0230CC18
.arm

; ===== function loc_0230CC18 =====
loc_0230CC18:
	ldr pc,[pool_0230CC1C]	; 0230CC18
pool_0230CC1C:
loc_0230CC1C:
	.word loc_037FF118	; 0230CC1C
.thumb
P4_Entry_0230CC20:
	push {r4,r5,r6,lr}	; 0230CC20
	add r4,r0,#0x0	; 0230CC22
	ldr r0,[pool_0230CCA4]	; 0230CC24
	ldr r1,[r0,#0x0]	; 0230CC26
	ldr r0,[pool_0230CCA8]	; 0230CC28
	add r5,r1,r0	; 0230CC2A
	ldr r0,[pool_0230CCAC]	; 0230CC2C
	ldrh r0,[r1,r0]	; 0230CC2E
	cmp r0,#0x40	; 0230CC30
	beq P4_Entry_0230CC38	; 0230CC32
	mov r0,#0x1	; 0230CC34
	b P4_Entry_0230CC9E	; 0230CC36
P4_Entry_0230CC38:
	add r0,r4,#0x0	; 0230CC38
	add r0,#0x1e	; 0230CC3A
	add r1,r5,#0x0	; 0230CC3C
	add r1,#0x64	; 0230CC3E
	bl loc_023058B8	; 0230CC40
	cmp r0,#0x0	; 0230CC44
	beq P4_Entry_0230CC58	; 0230CC46
	add r0,r4,#0x0	; 0230CC48
	add r0,#0x24	; 0230CC4A
	add r5,#0x82	; 0230CC4C
	add r1,r5,#0x0	; 0230CC4E
	bl loc_023058B8	; 0230CC50
	cmp r0,#0x0	; 0230CC54
	bne P4_Entry_0230CC5C	; 0230CC56
P4_Entry_0230CC58:
	mov r0,#0x1	; 0230CC58
	b P4_Entry_0230CC9E	; 0230CC5A
P4_Entry_0230CC5C:
	ldrh r0,[r4,#0x10]	; 0230CC5C
	sub r0,#0x1c	; 0230CC5E
	strh r0,[r4,#0x6]	; 0230CC60
	sub r4,#0x10	; 0230CC62
	ldr r0,[pool_0230CCB0]	; 0230CC64
	strh r0,[r4,#0xc]	; 0230CC66
	mov r0,#0x18	; 0230CC68
	strh r0,[r4,#0xe]	; 0230CC6A
	ldrh r3,[r4,#0x18]	; 0230CC6C
	ldr r0,[pool_0230CCB4]	; 0230CC6E
	ldrh r0,[r0,#0x0]	; 0230CC70
	ldr r5,[pool_0230CCB8]	; 0230CC72
	and r0,r5	; 0230CC74
	asr r2,r0,#0x3	; 0230CC76
	ldr r0,[pool_0230CCA4]	; 0230CC78
	ldr r6,[r0,#0x0]	; 0230CC7A
	ldr r1,[pool_0230CCBC]	; 0230CC7C
	ldrh r1,[r6,r1]	; 0230CC7E
	ldr r6,[pool_0230CCC0]	; 0230CC80
	ldrh r6,[r6,#0x0]	; 0230CC82
	and r6,r5	; 0230CC84
	asr r5,r6,#0x4	; 0230CC86
	orr r1,r5	; 0230CC88
	orr r2,r1	; 0230CC8A
	orr r3,r2	; 0230CC8C
	strh r3,[r4,#0x18]	; 0230CC8E
	ldr r1,[r0,#0x0]	; 0230CC90
	ldr r0,[pool_0230CCC4]	; 0230CC92
	add r0,r1,r0	; 0230CC94
	add r1,r4,#0x0	; 0230CC96
	bl loc_02304F08	; 0230CC98
	mov r0,#0x0	; 0230CC9C
P4_Entry_0230CC9E:
	pop {r4,r5,r6}	; 0230CC9E
	pop {r3}	; 0230CCA0
	bx r3	; 0230CCA2
pool_0230CCA4:
	.word FirmwareWlWorkPointerSlot	; 0230CCA4
pool_0230CCA8:
	.word 0x00000318	; 0230CCA8
pool_0230CCAC:
	.word 0x00000320	; 0230CCAC
pool_0230CCB0:
	.word 0x00000185	; 0230CCB0
pool_0230CCB4:
	.word REG_WIFI_TXBUF_REPLY1	; 0230CCB4
pool_0230CCB8:
	.word 0x00008000	; 0230CCB8
pool_0230CCBC:
	.word 0x000004BA	; 0230CCBC
pool_0230CCC0:
	.word REG_WIFI_TXBUF_REPLY2	; 0230CCC0
pool_0230CCC4:
	.word 0x0000015C	; 0230CCC4
P4_Entry_0230CCC8:
	push {r4,r5,r6,r7,lr}	; 0230CCC8
	sub sp,#0x4	; 0230CCCA
	add r5,r0,#0x0	; 0230CCCC
	ldr r0,[pool_0230CDE8]	; 0230CCCE
	ldr r1,[r0,#0x0]	; 0230CCD0
	ldr r0,[pool_0230CDEC]	; 0230CCD2
	add r7,r1,r0	; 0230CCD4
	add r0,r7,#0x0	; 0230CCD6
	add r0,#0x90	; 0230CCD8
	ldr r6,[r0,#0x0]	; 0230CCDA
	add r6,#0x10	; 0230CCDC
	ldrh r0,[r7,#0x3c]	; 0230CCDE
	cmp r0,#0x0	; 0230CCE0
	beq P4_Entry_0230CDDE	; 0230CCE2
	add r0,r5,#0x0	; 0230CCE4
	add r0,#0x18	; 0230CCE6
	ldr r2,[pool_0230CDF0]	; 0230CCE8
	add r1,r1,r2	; 0230CCEA
	bl loc_023058B8	; 0230CCEC
	cmp r0,#0x0	; 0230CCF0
	beq P4_Entry_0230CDDE	; 0230CCF2
	ldrh r1,[r5,#0x10]	; 0230CCF4
	sub r1,#0x18	; 0230CCF6
	ldrh r0,[r6,#0x6]	; 0230CCF8
	sub r0,#0x8	; 0230CCFA
	cmp r1,r0	; 0230CCFC
	bgt P4_Entry_0230CDDE	; 0230CCFE
	add r0,r5,#0x0	; 0230CD00
	add r0,#0x1e	; 0230CD02
	bl loc_023076B4	; 0230CD04
	add r4,r0,#0x0	; 0230CD08
	cmp r4,#0xff	; 0230CD0A
	beq P4_Entry_0230CDDE	; 0230CD0C
	cmp r4,#0x0	; 0230CD0E
	beq P4_Entry_0230CDDE	; 0230CD10
	bl loc_0230728C	; 0230CD12
	cmp r0,#0x40	; 0230CD16
	beq P4_Entry_0230CD2E	; 0230CD18
	add r5,#0x1e	; 0230CD1A
	add r0,r5,#0x0	; 0230CD1C
	mov r1,#0x7	; 0230CD1E
	bl loc_02309B1C	; 0230CD20
	cmp r0,#0x0	; 0230CD24
	beq P4_Entry_0230CDDE	; 0230CD26
	bl loc_0230A43C	; 0230CD28
	b P4_Entry_0230CDDE	; 0230CD2C
P4_Entry_0230CD2E:
	lsl r0,r4,#0x10	; 0230CD2E
	lsr r0,r0,#0x10	; 0230CD30
	ldrh r1,[r5,#0x14]	; 0230CD32
	lsl r1,r1,#0x13	; 0230CD34
	lsr r1,r1,#0x1f	; 0230CD36
	bl loc_02307404	; 0230CD38
	add r0,r4,#0x0	; 0230CD3C
	bl loc_02307360	; 0230CD3E
	add r0,r4,#0x0	; 0230CD42
	bl loc_023071F4	; 0230CD44
	mov r1,#0x1	; 0230CD48
	lsl r1,r0	; 0230CD4A
	lsl r0,r1,#0x10	; 0230CD4C
	lsr r0,r0,#0x10	; 0230CD4E
	add r1,r7,#0x0	; 0230CD50
	add r1,#0x9a	; 0230CD52
	ldrh r1,[r1,#0x0]	; 0230CD54
	add r2,r0,#0x0	; 0230CD56
	and r2,r1	; 0230CD58
	cmp r2,#0x0	; 0230CD5A
	bne P4_Entry_0230CDDE	; 0230CD5C
	add r1,r7,#0x0	; 0230CD5E
	add r1,#0x98	; 0230CD60
	ldrh r1,[r1,#0x0]	; 0230CD62
	add r2,r0,#0x0	; 0230CD64
	and r2,r1	; 0230CD66
	cmp r2,#0x0	; 0230CD68
	beq P4_Entry_0230CDDE	; 0230CD6A
	add r1,r7,#0x0	; 0230CD6C
	add r1,#0x9a	; 0230CD6E
	ldrh r2,[r1,#0x0]	; 0230CD70
	orr r2,r0	; 0230CD72
	add r1,r7,#0x0	; 0230CD74
	add r1,#0x9a	; 0230CD76
	strh r2,[r1,#0x0]	; 0230CD78
	ldrh r1,[r6,#0x0]	; 0230CD7A
	bic r1,r0	; 0230CD7C
	strh r1,[r6,#0x0]	; 0230CD7E
	add r4,r6,#0x0	; 0230CD80
	add r4,#0xa	; 0230CD82
	lsl r0,r0,#0xf	; 0230CD84
	lsr r0,r0,#0x10	; 0230CD86
	b P4_Entry_0230CDA0	; 0230CD88
P4_Entry_0230CD8A:
	add r1,r7,#0x0	; 0230CD8A
	add r1,#0x98	; 0230CD8C
	ldrh r1,[r1,#0x0]	; 0230CD8E
	add r2,r0,#0x0	; 0230CD90
	and r2,r1	; 0230CD92
	cmp r2,#0x0	; 0230CD94
	beq P4_Entry_0230CD9C	; 0230CD96
	ldrh r1,[r6,#0x6]	; 0230CD98
	add r4,r4,r1	; 0230CD9A
P4_Entry_0230CD9C:
	lsl r0,r0,#0xf	; 0230CD9C
	lsr r0,r0,#0x10	; 0230CD9E
P4_Entry_0230CDA0:
	cmp r0,#0x1	; 0230CDA0
	bne P4_Entry_0230CD8A	; 0230CDA2
	ldrh r0,[r5,#0x10]	; 0230CDA4
	sub r0,#0x18	; 0230CDA6
	strh r0,[r4,#0x0]	; 0230CDA8
	add r0,r4,#0x3	; 0230CDAA
	ldrh r2,[r5,#0x12]	; 0230CDAC
	mov r1,#0xff	; 0230CDAE
	and r2,r1	; 0230CDB0
	lsl r1,r2,#0x18	; 0230CDB2
	lsr r1,r1,#0x18	; 0230CDB4
	bl loc_023051A4	; 0230CDB6
	add r0,r4,#0x2	; 0230CDBA
	ldrh r2,[r5,#0xe]	; 0230CDBC
	mov r1,#0xff	; 0230CDBE
	and r2,r1	; 0230CDC0
	lsl r1,r2,#0x18	; 0230CDC2
	lsr r1,r1,#0x18	; 0230CDC4
	bl loc_023051A4	; 0230CDC6
	ldrh r2,[r4,#0x0]	; 0230CDCA
	cmp r2,#0x0	; 0230CDCC
	beq P4_Entry_0230CDDE	; 0230CDCE
	add r5,#0x2c	; 0230CDD0
	add r0,r5,#0x0	; 0230CDD2
	add r4,#0x8	; 0230CDD4
	add r1,r4,#0x0	; 0230CDD6
	add r2,r2,#0x1	; 0230CDD8
	bl P4_Entry_0230CDF4	; 0230CDDA
P4_Entry_0230CDDE:
	add sp,#0x4	; 0230CDDE
	pop {r4,r5,r6,r7}	; 0230CDE0
	pop {r3}	; 0230CDE2
	bx r3	; 0230CDE4
	.byte 0xC0, 0x46	; 0230CDE6
pool_0230CDE8:
	.word FirmwareWlWorkPointerSlot	; 0230CDE8
pool_0230CDEC:
	.word 0x00000400	; 0230CDEC
pool_0230CDF0:
	.word 0x0000037C	; 0230CDF0
P4_Entry_0230CDF4:
	bx pc	; 0230CDF4
	.byte 0xC0, 0x46	; 0230CDF6
.arm
	ldr pc,[pool_0230CDFC]	; 0230CDF8
pool_0230CDFC:
	.word P2_Entry_037FF334	; 0230CDFC
.thumb
P4_Entry_0230CE00:
	push {r4,r5,r6,lr}	; 0230CE00
	add r5,r0,#0x0	; 0230CE02
	ldr r0,[pool_0230CF14]	; 0230CE04
	ldr r0,[r0,#0x0]	; 0230CE06
	ldr r1,[pool_0230CF18]	; 0230CE08
	add r6,r0,r1	; 0230CE0A
	ldr r1,[pool_0230CF1C]	; 0230CE0C
	add r4,r0,r1	; 0230CE0E
	ldrh r1,[r6,#0x8]	; 0230CE10
	cmp r1,#0x40	; 0230CE12
	beq P4_Entry_0230CE1A	; 0230CE14
	mov r0,#0x1	; 0230CE16
	b P4_Entry_0230CF0E	; 0230CE18
P4_Entry_0230CE1A:
	ldrh r2,[r5,#0x2a]	; 0230CE1A
	ldrh r1,[r4,#0x0]	; 0230CE1C
	cmp r1,r2	; 0230CE1E
	bne P4_Entry_0230CE30	; 0230CE20
	ldr r1,[pool_0230CF20]	; 0230CE22
	add r0,r0,r1	; 0230CE24
	ldr r1,[r0,#0x0]	; 0230CE26
	add r1,r1,#0x1	; 0230CE28
	str r1,[r0,#0x0]	; 0230CE2A
	mov r0,#0x1	; 0230CE2C
	b P4_Entry_0230CF0E	; 0230CE2E
P4_Entry_0230CE30:
	strh r2,[r4,#0x0]	; 0230CE30
	add r0,r5,#0x0	; 0230CE32
	add r0,#0x1e	; 0230CE34
	add r1,r6,#0x0	; 0230CE36
	add r1,#0x64	; 0230CE38
	bl loc_023058B8	; 0230CE3A
	cmp r0,#0x0	; 0230CE3E
	beq P4_Entry_0230CE52	; 0230CE40
	add r0,r5,#0x0	; 0230CE42
	add r0,#0x24	; 0230CE44
	add r1,r6,#0x0	; 0230CE46
	add r1,#0x82	; 0230CE48
	bl loc_023058B8	; 0230CE4A
	cmp r0,#0x0	; 0230CE4E
	bne P4_Entry_0230CE56	; 0230CE50
P4_Entry_0230CE52:
	mov r0,#0x1	; 0230CE52
	b P4_Entry_0230CF0E	; 0230CE54
P4_Entry_0230CE56:
	mov r1,#0x1	; 0230CE56
	add r0,r6,#0x0	; 0230CE58
	add r0,#0x6a	; 0230CE5A
	ldrh r0,[r0,#0x0]	; 0230CE5C
	lsl r1,r0	; 0230CE5E
	lsl r0,r1,#0x10	; 0230CE60
	lsr r1,r0,#0x10	; 0230CE62
	ldrh r0,[r5,#0x2e]	; 0230CE64
	and r1,r0	; 0230CE66
	cmp r1,#0x0	; 0230CE68
	bne P4_Entry_0230CE72	; 0230CE6A
	mov r0,#0x0	; 0230CE6C
	strh r0,[r4,#0x6]	; 0230CE6E
	b P4_Entry_0230CE76	; 0230CE70
P4_Entry_0230CE72:
	ldr r0,[pool_0230CF24]	; 0230CE72
	strh r0,[r4,#0x6]	; 0230CE74
P4_Entry_0230CE76:
	ldr r0,[pool_0230CF28]	; 0230CE76
	ldrh r2,[r0,#0x0]	; 0230CE78
	ldr r0,[pool_0230CF2C]	; 0230CE7A
	add r1,r2,#0x0	; 0230CE7C
	and r1,r0	; 0230CE7E
	cmp r1,#0x0	; 0230CE80
	beq P4_Entry_0230CE9A	; 0230CE82
	ldr r0,[pool_0230CF30]	; 0230CE84
	and r2,r0	; 0230CE86
	lsl r1,r2,#0x1	; 0230CE88
	ldr r0,[pool_0230CF34]	; 0230CE8A
	ldrh r0,[r1,r0]	; 0230CE8C
	cmp r0,#0x0	; 0230CE8E
	beq P4_Entry_0230CE9A	; 0230CE90
	ldrh r1,[r4,#0x6]	; 0230CE92
	ldr r0,[pool_0230CF38]	; 0230CE94
	orr r1,r0	; 0230CE96
	strh r1,[r4,#0x6]	; 0230CE98
P4_Entry_0230CE9A:
	add r6,#0x88	; 0230CE9A
	ldrh r0,[r6,#0x0]	; 0230CE9C
	bl loc_02307360	; 0230CE9E
	ldrh r0,[r5,#0x10]	; 0230CEA2
	sub r0,#0x1c	; 0230CEA4
	strh r0,[r5,#0x6]	; 0230CEA6
	add r1,r5,#0x0	; 0230CEA8
	sub r1,#0x10	; 0230CEAA
	ldr r0,[pool_0230CF3C]	; 0230CEAC
	strh r0,[r1,#0xc]	; 0230CEAE
	ldrh r0,[r5,#0x6]	; 0230CEB0
	add r0,#0x31	; 0230CEB2
	lsr r0,r0,#0x1	; 0230CEB4
	strh r0,[r1,#0xe]	; 0230CEB6
	ldrh r3,[r1,#0x3e]	; 0230CEB8
	mov r5,#0x0	; 0230CEBA
	mov r2,#0x1	; 0230CEBC
	b P4_Entry_0230CECE	; 0230CEBE
P4_Entry_0230CEC0:
	add r0,r3,#0x0	; 0230CEC0
	and r0,r2	; 0230CEC2
	cmp r0,#0x0	; 0230CEC4
	beq P4_Entry_0230CECA	; 0230CEC6
	add r5,r5,#0x1	; 0230CEC8
P4_Entry_0230CECA:
	lsl r0,r3,#0xf	; 0230CECA
	lsr r3,r0,#0x10	; 0230CECC
P4_Entry_0230CECE:
	cmp r3,#0x0	; 0230CECE
	bne P4_Entry_0230CEC0	; 0230CED0
	ldrh r3,[r1,#0x18]	; 0230CED2
	ldr r0,[pool_0230CF40]	; 0230CED4
	ldrh r0,[r0,#0x0]	; 0230CED6
	ldr r6,[pool_0230CF2C]	; 0230CED8
	and r0,r6	; 0230CEDA
	asr r2,r0,#0x3	; 0230CEDC
	ldrh r0,[r4,#0x6]	; 0230CEDE
	ldr r4,[pool_0230CF28]	; 0230CEE0
	ldrh r4,[r4,#0x0]	; 0230CEE2
	and r4,r6	; 0230CEE4
	asr r4,r4,#0x4	; 0230CEE6
	orr r0,r4	; 0230CEE8
	orr r2,r0	; 0230CEEA
	orr r3,r2	; 0230CEEC
	strh r3,[r1,#0x18]	; 0230CEEE
	ldrh r2,[r1,#0x1c]	; 0230CEF0
	ldrh r0,[r1,#0x3c]	; 0230CEF2
	add r0,#0xa	; 0230CEF4
	mul r5,r0	; 0230CEF6
	add r5,#0xfc	; 0230CEF8
	lsr r0,r5,#0x4	; 0230CEFA
	add r0,r2,r0	; 0230CEFC
	strh r0,[r1,#0x1a]	; 0230CEFE
	ldr r0,[pool_0230CF14]	; 0230CF00
	ldr r2,[r0,#0x0]	; 0230CF02
	ldr r0,[pool_0230CF44]	; 0230CF04
	add r0,r2,r0	; 0230CF06
	bl loc_02304F08	; 0230CF08
	mov r0,#0x0	; 0230CF0C
P4_Entry_0230CF0E:
	pop {r4,r5,r6}	; 0230CF0E
	pop {r3}	; 0230CF10
	bx r3	; 0230CF12
pool_0230CF14:
	.word FirmwareWlWorkPointerSlot	; 0230CF14
pool_0230CF18:
	.word 0x00000318	; 0230CF18
pool_0230CF1C:
	.word 0x000004B4	; 0230CF1C
pool_0230CF20:
	.word 0x00000550	; 0230CF20
pool_0230CF24:
	.word 0x00002000	; 0230CF24
pool_0230CF28:
	.word REG_WIFI_TXBUF_REPLY2	; 0230CF28
pool_0230CF2C:
	.word 0x00008000	; 0230CF2C
pool_0230CF30:
	.word 0x00007FFF	; 0230CF30
pool_0230CF34:
	.word 0x04804004	; 0230CF34
pool_0230CF38:
	.word 0x00004000	; 0230CF38
pool_0230CF3C:
	.word 0x00000182	; 0230CF3C
pool_0230CF40:
	.word REG_WIFI_TXBUF_REPLY1	; 0230CF40
pool_0230CF44:
	.word 0x0000015C	; 0230CF44
.arm
.thumb
	push {r4,r5,r6,r7,lr}	; 0230CF48
	sub sp,#0xc	; 0230CF4A
	ldr r0,[pool_0230D15C]	; 0230CF4C
	ldr r1,[r0,#0x0]	; 0230CF4E
	ldr r0,[pool_0230D160]	; 0230CF50
	add r6,r1,r0	; 0230CF52
	ldr r0,[pool_0230D164]	; 0230CF54
	add r7,r1,r0	; 0230CF56
	ldr r0,[pool_0230D168]	; 0230CF58
	add r4,r1,r0	; 0230CF5A
	ldr r0,[r7,#0x48]	; 0230CF5C
	str r0,[sp,#0x0]	; 0230CF5E
	mov r0,#0x0	; 0230CF60
	mvn r1,r0	; 0230CF62
	ldr r0,[sp,#0x0]	; 0230CF64
	cmp r0,r1	; 0230CF66
	bne loc_0230CF6C	; 0230CF68
	b loc_0230D154	; 0230CF6A
loc_0230CF6C:
	ldrh r0,[r6,#0x8]	; 0230CF6C
	cmp r0,#0x40	; 0230CF6E
	beq loc_0230CF7E	; 0230CF70
	add r7,#0x48	; 0230CF72
	add r0,r7,#0x0	; 0230CF74
	ldr r1,[sp,#0x0]	; 0230CF76
	bl loc_02304C3C	; 0230CF78
	b loc_0230D154	; 0230CF7C
loc_0230CF7E:
	ldr r5,[sp,#0x0]	; 0230CF7E
	add r5,#0x10	; 0230CF80
	ldrh r0,[r5,#0x14]	; 0230CF82
	lsl r0,r0,#0x17	; 0230CF84
	lsr r0,r0,#0x1f	; 0230CF86
	cmp r0,#0x0	; 0230CF88
	beq loc_0230CFA6	; 0230CF8A
	ldrh r1,[r5,#0x24]	; 0230CF8C
	mov r0,#0x1	; 0230CF8E
	and r1,r0	; 0230CF90
	cmp r1,#0x0	; 0230CF92
	beq loc_0230CF9E	; 0230CF94
	ldr r0,[r4,#0x2c]	; 0230CF96
	add r0,r0,#0x1	; 0230CF98
	str r0,[r4,#0x2c]	; 0230CF9A
	b loc_0230CFBE	; 0230CF9C
loc_0230CF9E:
	ldr r0,[r4,#0x28]	; 0230CF9E
	add r0,r0,#0x1	; 0230CFA0
	str r0,[r4,#0x28]	; 0230CFA2
	b loc_0230CFBE	; 0230CFA4
loc_0230CFA6:
	ldrh r1,[r5,#0x18]	; 0230CFA6
	mov r0,#0x1	; 0230CFA8
	and r1,r0	; 0230CFAA
	cmp r1,#0x0	; 0230CFAC
	beq loc_0230CFB8	; 0230CFAE
	ldr r0,[r4,#0x2c]	; 0230CFB0
	add r0,r0,#0x1	; 0230CFB2
	str r0,[r4,#0x2c]	; 0230CFB4
	b loc_0230CFBE	; 0230CFB6
loc_0230CFB8:
	ldr r0,[r4,#0x28]	; 0230CFB8
	add r0,r0,#0x1	; 0230CFBA
	str r0,[r4,#0x28]	; 0230CFBC
loc_0230CFBE:
	ldrh r0,[r5,#0x8]	; 0230CFBE
	mov r1,#0xf0	; 0230CFC0
	and r0,r1	; 0230CFC2
	mov r1,#0x10	; 0230CFC4
	bl loc_0230D174	; 0230CFC6
	ldr r1,[r4,#0x24]	; 0230CFCA
	sub r0,r0,#0x1	; 0230CFCC
	add r0,r1,r0	; 0230CFCE
	str r0,[r4,#0x24]	; 0230CFD0
	mov r0,#0x1	; 0230CFD2
	str r0,[sp,#0x8]	; 0230CFD4
	ldrh r1,[r6,#0xc]	; 0230CFD6
	cmp r1,#0x1	; 0230CFD8
	beq loc_0230CFE6	; 0230CFDA
	cmp r1,#0x2	; 0230CFDC
	beq loc_0230D064	; 0230CFDE
	cmp r1,#0x3	; 0230CFE0
	beq loc_0230D064	; 0230CFE2
	b loc_0230D0EE	; 0230CFE4
loc_0230CFE6:
	ldrh r1,[r5,#0x14]	; 0230CFE6
	and r1,r0	; 0230CFE8
	cmp r1,#0x0	; 0230CFEA
	bne loc_0230D0EE	; 0230CFEC
	add r0,r5,#0x0	; 0230CFEE
	add r0,#0x1e	; 0230CFF0
	bl loc_023076B4	; 0230CFF2
	str r0,[sp,#0x4]	; 0230CFF6
	cmp r0,#0xff	; 0230CFF8
	beq loc_0230D004	; 0230CFFA
	bl loc_0230728C	; 0230CFFC
	cmp r0,#0x40	; 0230D000
	beq loc_0230D02E	; 0230D002
loc_0230D004:
	ldr r0,[sp,#0x4]	; 0230D004
	bl loc_0230728C	; 0230D006
	cmp r0,#0x30	; 0230D00A
	bne loc_0230D01A	; 0230D00C
	add r0,r5,#0x0	; 0230D00E
	add r0,#0x1e	; 0230D010
	mov r1,#0x7	; 0230D012
	bl loc_02309F6C	; 0230D014
	b loc_0230D024	; 0230D018
loc_0230D01A:
	add r0,r5,#0x0	; 0230D01A
	add r0,#0x1e	; 0230D01C
	mov r1,#0x7	; 0230D01E
	bl loc_02309B1C	; 0230D020
loc_0230D024:
	cmp r0,#0x0	; 0230D024
	beq loc_0230D0EE	; 0230D026
	bl loc_0230A43C	; 0230D028
	b loc_0230D0EE	; 0230D02C
loc_0230D02E:
	ldr r0,[sp,#0x4]	; 0230D02E
	lsl r0,r0,#0x10	; 0230D030
	lsr r0,r0,#0x10	; 0230D032
	ldrh r1,[r5,#0x14]	; 0230D034
	lsl r1,r1,#0x13	; 0230D036
	lsr r1,r1,#0x1f	; 0230D038
	bl loc_02307404	; 0230D03A
	ldr r0,[sp,#0x4]	; 0230D03E
	bl loc_02307224	; 0230D040
	ldrh r1,[r5,#0x2a]	; 0230D044
	cmp r1,r0	; 0230D046
	bne loc_0230D052	; 0230D048
	ldr r0,[r4,#0x3c]	; 0230D04A
	add r0,r0,#0x1	; 0230D04C
	str r0,[r4,#0x3c]	; 0230D04E
	b loc_0230D0EE	; 0230D050
loc_0230D052:
	add r0,r5,#0x0	; 0230D052
	add r0,#0x18	; 0230D054
	add r1,r5,#0x0	; 0230D056
	add r1,#0x24	; 0230D058
	bl loc_02305B7C	; 0230D05A
	mov r0,#0x0	; 0230D05E
	str r0,[sp,#0x8]	; 0230D060
	b loc_0230D0EE	; 0230D062
loc_0230D064:
	ldrh r0,[r5,#0x14]	; 0230D064
	mov r3,#0x1	; 0230D066
	add r2,r0,#0x0	; 0230D068
	and r2,r3	; 0230D06A
	cmp r2,#0x0	; 0230D06C
	bne loc_0230D0EE	; 0230D06E
	ldrh r2,[r6,#0xe]	; 0230D070
	cmp r2,#0x0	; 0230D072
	beq loc_0230D0C6	; 0230D074
	ldr r2,[pool_0230D16C]	; 0230D076
	and r0,r2	; 0230D078
	cmp r0,#0x0	; 0230D07A
	bne loc_0230D0C6	; 0230D07C
	ldrh r0,[r5,#0x18]	; 0230D07E
	and r0,r3	; 0230D080
	cmp r0,#0x0	; 0230D082
	beq loc_0230D096	; 0230D084
	add r0,r6,#0x0	; 0230D086
	add r0,#0x8e	; 0230D088
	ldrh r1,[r0,#0x0]	; 0230D08A
	bic r1,r3	; 0230D08C
	add r0,r6,#0x0	; 0230D08E
	add r0,#0x8e	; 0230D090
	strh r1,[r0,#0x0]	; 0230D092
	b loc_0230D0AA	; 0230D094
loc_0230D096:
	cmp r1,#0x3	; 0230D096
	beq loc_0230D0AA	; 0230D098
	add r0,r6,#0x0	; 0230D09A
	add r0,#0x8e	; 0230D09C
	ldrh r1,[r0,#0x0]	; 0230D09E
	mov r0,#0x2	; 0230D0A0
	bic r1,r0	; 0230D0A2
	add r0,r6,#0x0	; 0230D0A4
	add r0,#0x8e	; 0230D0A6
	strh r1,[r0,#0x0]	; 0230D0A8
loc_0230D0AA:
	add r0,r6,#0x0	; 0230D0AA
	add r0,#0x8e	; 0230D0AC
	ldrh r0,[r0,#0x0]	; 0230D0AE
	cmp r0,#0x0	; 0230D0B0
	bne loc_0230D0C6	; 0230D0B2
	ldrh r0,[r7,#0x20]	; 0230D0B4
	cmp r0,#0x0	; 0230D0B6
	bne loc_0230D0C6	; 0230D0B8
	ldrh r0,[r7,#0x2c]	; 0230D0BA
	cmp r0,#0x0	; 0230D0BC
	bne loc_0230D0C6	; 0230D0BE
	mov r0,#0x1	; 0230D0C0
	bl loc_02305E90	; 0230D0C2
loc_0230D0C6:
	add r6,#0x88	; 0230D0C6
	ldrh r0,[r6,#0x0]	; 0230D0C8
	str r0,[sp,#0x4]	; 0230D0CA
	bl loc_02307224	; 0230D0CC
	ldrh r1,[r5,#0x2a]	; 0230D0D0
	cmp r1,r0	; 0230D0D2
	bne loc_0230D0DE	; 0230D0D4
	ldr r0,[r4,#0x3c]	; 0230D0D6
	add r0,r0,#0x1	; 0230D0D8
	str r0,[r4,#0x3c]	; 0230D0DA
	b loc_0230D0EE	; 0230D0DC
loc_0230D0DE:
	add r0,r5,#0x0	; 0230D0DE
	add r0,#0x1e	; 0230D0E0
	add r1,r5,#0x0	; 0230D0E2
	add r1,#0x24	; 0230D0E4
	bl loc_02305B7C	; 0230D0E6
	mov r0,#0x0	; 0230D0EA
	str r0,[sp,#0x8]	; 0230D0EC
loc_0230D0EE:
	ldr r0,[sp,#0x8]	; 0230D0EE
	cmp r0,#0x0	; 0230D0F0
	bne loc_0230D13A	; 0230D0F2
	ldr r0,[sp,#0x4]	; 0230D0F4
	lsl r0,r0,#0x10	; 0230D0F6
	lsr r0,r0,#0x10	; 0230D0F8
	strh r0,[r5,#0x2]	; 0230D0FA
	ldrh r2,[r5,#0x12]	; 0230D0FC
	mov r1,#0xff	; 0230D0FE
	and r2,r1	; 0230D100
	lsl r1,r2,#0x10	; 0230D102
	lsr r1,r1,#0x10	; 0230D104
	bl loc_0230744C	; 0230D106
	ldr r0,[sp,#0x4]	; 0230D10A
	ldrh r1,[r5,#0x2a]	; 0230D10C
	bl loc_0230738C	; 0230D10E
	ldr r0,[sp,#0x4]	; 0230D112
	bl loc_02307360	; 0230D114
	ldrh r0,[r5,#0x10]	; 0230D118
	sub r0,#0x18	; 0230D11A
	strh r0,[r5,#0x6]	; 0230D11C
	ldr r1,[pool_0230D170]	; 0230D11E
	ldr r0,[sp,#0x0]	; 0230D120
	strh r1,[r0,#0xc]	; 0230D122
	ldrh r0,[r5,#0x6]	; 0230D124
	add r0,#0x2d	; 0230D126
	lsr r1,r0,#0x1	; 0230D128
	ldr r0,[sp,#0x0]	; 0230D12A
	strh r1,[r0,#0xe]	; 0230D12C
	add r0,r7,#0x0	; 0230D12E
	add r0,#0x48	; 0230D130
	ldr r1,[sp,#0x0]	; 0230D132
	bl loc_02304F08	; 0230D134
	b loc_0230D144	; 0230D138
loc_0230D13A:
	add r0,r7,#0x0	; 0230D13A
	add r0,#0x48	; 0230D13C
	ldr r1,[sp,#0x0]	; 0230D13E
	bl loc_02304C3C	; 0230D140
loc_0230D144:
	add r7,#0x50	; 0230D144
	ldrh r0,[r7,#0x0]	; 0230D146
	cmp r0,#0x0	; 0230D148
	beq loc_0230D154	; 0230D14A
	mov r0,#0x2	; 0230D14C
	mov r1,#0x6	; 0230D14E
	bl loc_02304BE8	; 0230D150
loc_0230D154:
	add sp,#0xc	; 0230D154
	pop {r4,r5,r6,r7}	; 0230D156
	pop {r3}	; 0230D158
	bx r3	; 0230D15A
pool_0230D15C:
loc_0230D15C:
	.word FirmwareWlWorkPointerSlot	; 0230D15C
pool_0230D160:
loc_0230D160:
	.word 0x00000318	; 0230D160
pool_0230D164:
loc_0230D164:
	.word 0x00000150	; 0230D164
pool_0230D168:
loc_0230D168:
	.word 0x00000510	; 0230D168
pool_0230D16C:
loc_0230D16C:
	.word 0x00002000	; 0230D16C
pool_0230D170:
loc_0230D170:
	.word 0x00000180	; 0230D170

; ===== function loc_0230D174 =====
loc_0230D174:
	bx pc	; 0230D174
	.byte 0xC0, 0x46	; 0230D178
.arm

; ===== function loc_0230D178 =====
loc_0230D178:
	ldr pc,[pool_0230D17C]	; 0230D178
pool_0230D17C:
loc_0230D17C:
	.word P2_SignedDivMod	; 0230D17C
.thumb

; ===== function loc_0230D180 =====
	push {r4,lr}	; 0230D180
	ldr r0,[pool_0230D1B4]	; 0230D182
	ldr r1,[r0,#0x0]	; 0230D184
	ldr r0,[pool_0230D1B8]	; 0230D186
	add r4,r1,r0	; 0230D188
	mov r3,#0x0	; 0230D18A
	add r0,r3,#0x0	; 0230D18C
	add r2,r4,#0x0	; 0230D18E
	add r2,#0x30	; 0230D190
loc_0230D192:
	ldrh r1,[r4,#0x30]	; 0230D192
	cmp r1,#0x0	; 0230D194
	beq loc_0230D1A6	; 0230D196
	ldrh r1,[r2,#0x0]	; 0230D198
	sub r1,r1,#0x1	; 0230D19A
	strh r1,[r2,#0x0]	; 0230D19C
	ldrh r1,[r4,#0x30]	; 0230D19E
	cmp r1,#0x0	; 0230D1A0
	bne loc_0230D1A6	; 0230D1A2
	strh r0,[r4,#0x0]	; 0230D1A4
loc_0230D1A6:
	add r3,r3,#0x1	; 0230D1A6
	cmp r3,#0x4	; 0230D1A8
	bcc loc_0230D192	; 0230D1AA
	pop {r4}	; 0230D1AC
	pop {r3}	; 0230D1AE
	bx r3	; 0230D1B0
	.byte 0xC0, 0x46	; 0230D1B4
pool_0230D1B4:
loc_0230D1B4:
	.word FirmwareWlWorkPointerSlot	; 0230D1B4
pool_0230D1B8:
loc_0230D1B8:
	.word 0x00000210	; 0230D1B8
P4_Entry_0230D1BC:
	push {lr}	; 0230D1BC
	sub sp,#0x4	; 0230D1BE
	mov r1,#0x0	; 0230D1C0
	add r0,sp,#0x0	; 0230D1C2
	strh r1,[r0,#0x0]	; 0230D1C4
	ldrh r0,[r0,#0x0]	; 0230D1C6
	ldr r1,[pool_0230D1DC]	; 0230D1C8
	ldr r2,[r1,#0x0]	; 0230D1CA
	ldr r1,[pool_0230D1E0]	; 0230D1CC
	add r1,r2,r1	; 0230D1CE
	mov r2,#0xc8	; 0230D1D0
	bl P4_Entry_0230D1E4	; 0230D1D2
	add sp,#0x4	; 0230D1D6
	pop {r3}	; 0230D1D8
	bx r3	; 0230D1DA
pool_0230D1DC:
	.word FirmwareWlWorkPointerSlot	; 0230D1DC
pool_0230D1E0:
	.word 0x00000210	; 0230D1E0
P4_Entry_0230D1E4:
	bx pc	; 0230D1E4
	.byte 0xC0, 0x46	; 0230D1E6
.arm
	ldr pc,[pool_0230D1EC]	; 0230D1E8
pool_0230D1EC:
	.word loc_037FF31C	; 0230D1EC
.thumb

; ===== function loc_0230D1F0 =====
loc_0230D1F0:
	push {r4,r5,r6,r7,lr}	; 0230D1F0
	sub sp,#0x1c	; 0230D1F2
	str r0,[sp,#0x0]	; 0230D1F4
	add r6,r1,#0x0	; 0230D1F6
	add r7,r2,#0x0	; 0230D1F8
	ldr r0,[pool_0230D2CC]	; 0230D1FA
	ldr r1,[r0,#0x0]	; 0230D1FC
	ldr r0,[pool_0230D2D0]	; 0230D1FE
	add r4,r1,r0	; 0230D200
	add r0,r7,#0x1	; 0230D202
	bl loc_02305180	; 0230D204
	cmp r0,#0x20	; 0230D208
	bhi loc_0230D2C2	; 0230D20A
	mov r0,#0x4	; 0230D20C
	str r0,[sp,#0x4]	; 0230D20E
	str r0,[sp,#0x8]	; 0230D210
	ldr r0,[pool_0230D2D4]	; 0230D212
	str r0,[sp,#0xc]	; 0230D214
	mov r5,#0x0	; 0230D216
	b loc_0230D242	; 0230D218
loc_0230D21A:
	ldrh r0,[r4,#0x0]	; 0230D21A
	cmp r0,#0x0	; 0230D21C
	beq loc_0230D23C	; 0230D21E
	add r0,r4,#0x6	; 0230D220
	add r1,r6,#0x0	; 0230D222
	add r1,#0x24	; 0230D224
	bl loc_023058B8	; 0230D226
	cmp r0,#0x0	; 0230D22A
	bne loc_0230D258	; 0230D22C
	ldrh r1,[r4,#0x30]	; 0230D22E
	ldr r0,[sp,#0xc]	; 0230D230
	cmp r1,r0	; 0230D232
	bcs loc_0230D23E	; 0230D234
	str r1,[sp,#0xc]	; 0230D236
	str r5,[sp,#0x8]	; 0230D238
	b loc_0230D23E	; 0230D23A
loc_0230D23C:
	str r5,[sp,#0x4]	; 0230D23C
loc_0230D23E:
	add r5,r5,#0x1	; 0230D23E
	add r4,#0x32	; 0230D240
loc_0230D242:
	cmp r5,#0x4	; 0230D242
	bcc loc_0230D21A	; 0230D244
	ldr r0,[sp,#0x4]	; 0230D246
	cmp r0,#0x4	; 0230D248
	beq loc_0230D250	; 0230D24A
	lsl r5,r0,#0	; 0230D24C
	b loc_0230D258	; 0230D24E
loc_0230D250:
	ldr r0,[sp,#0x8]	; 0230D250
	cmp r0,#0x4	; 0230D252
	beq loc_0230D2C2	; 0230D254
	lsl r5,r0,#0	; 0230D256
loc_0230D258:
	ldr r0,[pool_0230D2CC]	; 0230D258
	ldr r1,[r0,#0x0]	; 0230D25A
	ldr r0,[pool_0230D2D0]	; 0230D25C
	add r0,r1,r0	; 0230D25E
	str r0,[sp,#0x10]	; 0230D260
	mov r2,#0x32	; 0230D262
	mul r5,r2	; 0230D264
	add r4,r0,r5	; 0230D266
	mov r1,#0x0	; 0230D268
	add r0,sp,#0x14	; 0230D26A
	strh r1,[r0,#0x0]	; 0230D26C
	ldrh r0,[r0,#0x0]	; 0230D26E
	add r1,r4,#0x0	; 0230D270
	bl loc_0230D2D8	; 0230D272
	ldr r0,[pool_0230D2D4]	; 0230D276
	strh r0,[r4,#0x30]	; 0230D278
	ldrh r1,[r6,#0x12]	; 0230D27A
	mov r0,#0xff	; 0230D27C
	and r1,r0	; 0230D27E
	ldr r0,[sp,#0x10]	; 0230D280
	strh r1,[r0,r5]	; 0230D282
	ldr r0,[sp,#0x0]	; 0230D284
	strh r0,[r4,#0x2]	; 0230D286
	add r0,r4,#0x6	; 0230D288
	add r1,r6,#0x0	; 0230D28A
	add r1,#0x24	; 0230D28C
	bl loc_02305B7C	; 0230D28E
	add r0,r7,#0x1	; 0230D292
	bl loc_02305180	; 0230D294
	strh r0,[r4,#0xc]	; 0230D298
	mov r5,#0x0	; 0230D29A
	add r7,r7,#0x2	; 0230D29C
	b loc_0230D2B4	; 0230D29E
loc_0230D2A0:
	add r0,r7,r5	; 0230D2A0
	bl loc_02305180	; 0230D2A2
	add r1,r0,#0x0	; 0230D2A6
	add r0,r4,#0x0	; 0230D2A8
	add r0,#0xe	; 0230D2AA
	add r0,r0,r5	; 0230D2AC
	bl loc_023051A4	; 0230D2AE
	add r5,r5,#0x1	; 0230D2B2
loc_0230D2B4:
	ldrh r0,[r4,#0xc]	; 0230D2B4
	cmp r5,r0	; 0230D2B6
	bcc loc_0230D2A0	; 0230D2B8
	ldrh r0,[r6,#0x34]	; 0230D2BA
	strh r0,[r4,#0x2e]	; 0230D2BC
	ldrh r0,[r6,#0x36]	; 0230D2BE
	strh r0,[r4,#0x4]	; 0230D2C0
loc_0230D2C2:
	add sp,#0x1c	; 0230D2C2
	pop {r4,r5,r6,r7}	; 0230D2C4
	pop {r3}	; 0230D2C6
	bx r3	; 0230D2C8
	.byte 0xC0, 0x46	; 0230D2CC
pool_0230D2CC:
loc_0230D2CC:
	.word FirmwareWlWorkPointerSlot	; 0230D2CC
pool_0230D2D0:
loc_0230D2D0:
	.word 0x00000210	; 0230D2D0
pool_0230D2D4:
loc_0230D2D4:
	.word 0x00000400	; 0230D2D4

; ===== function loc_0230D2D8 =====
loc_0230D2D8:
	bx pc	; 0230D2D8
	.byte 0xC0, 0x46	; 0230D2DC
.arm

; ===== function loc_0230D2DC =====
loc_0230D2DC:
	ldr pc,[pool_0230D2E0]	; 0230D2DC
pool_0230D2E0:
loc_0230D2E0:
	.word loc_037FF31C	; 0230D2E0
.thumb

; ===== function loc_0230D2E4 =====
loc_0230D2E4:
	push {lr}	; 0230D2E4
	sub sp,#0x4	; 0230D2E6
	ldr r0,[pool_0230D380]	; 0230D2E8
	ldr r1,[r0,#0x0]	; 0230D2EA
	ldr r0,[pool_0230D384]	; 0230D2EC
	ldr r0,[r1,r0]	; 0230D2EE
	bl loc_0230D394	; 0230D2F0
	bl loc_0230D440	; 0230D2F4
	mov r0,#0x0	; 0230D2F8
	str r0,[sp,#0x0]	; 0230D2FA
	mov r0,#0x2c	; 0230D2FC
	mov r1,#0x2	; 0230D2FE
	add r2,sp,#0x0	; 0230D300
	bl loc_0230D3A4	; 0230D302
	ldr r0,[pool_0230D380]	; 0230D306
	ldr r1,[r0,#0x0]	; 0230D308
	ldr r0,[pool_0230D384]	; 0230D30A
	ldr r0,[r1,r0]	; 0230D30C
	bl loc_0230D3B4	; 0230D30E
	ldr r1,[sp,#0x0]	; 0230D312
	cmp r1,#0xa4	; 0230D314
	bcc loc_0230D31E	; 0230D316
	ldr r0,[pool_0230D388]	; 0230D318
	cmp r1,r0	; 0230D31A
	bls loc_0230D322	; 0230D31C
loc_0230D31E:
	mov r0,#0x0	; 0230D31E
	b loc_0230D378	; 0230D320
loc_0230D322:
	add r1,r1,#0x2	; 0230D322
	str r1,[sp,#0x0]	; 0230D324
	ldr r0,[pool_0230D380]	; 0230D326
	ldr r2,[r0,#0x0]	; 0230D328
	ldr r0,[pool_0230D38C]	; 0230D32A
	add r0,r2,r0	; 0230D32C
	bl loc_02304D60	; 0230D32E
	ldr r3,[pool_0230D380]	; 0230D332
	ldr r2,[r3,#0x0]	; 0230D334
	ldr r1,[pool_0230D390]	; 0230D336
	str r0,[r2,r1]	; 0230D338
	ldr r0,[r3,#0x0]	; 0230D33A
	add r0,r0,r1	; 0230D33C
	ldr r1,[r0,#0x0]	; 0230D33E
	cmp r1,#0x0	; 0230D340
	bne loc_0230D348	; 0230D342
	mov r0,#0x0	; 0230D344
	b loc_0230D378	; 0230D346
loc_0230D348:
	add r1,#0xc	; 0230D348
	str r1,[r0,#0x0]	; 0230D34A
	ldr r1,[r3,#0x0]	; 0230D34C
	ldr r0,[pool_0230D384]	; 0230D34E
	ldr r0,[r1,r0]	; 0230D350
	bl loc_0230D394	; 0230D352
	bl loc_0230D440	; 0230D356
	mov r0,#0x2a	; 0230D35A
	ldr r1,[sp,#0x0]	; 0230D35C
	ldr r2,[pool_0230D380]	; 0230D35E
	ldr r3,[r2,#0x0]	; 0230D360
	ldr r2,[pool_0230D390]	; 0230D362
	ldr r2,[r3,r2]	; 0230D364
	bl loc_0230D3A4	; 0230D366
	ldr r0,[pool_0230D380]	; 0230D36A
	ldr r1,[r0,#0x0]	; 0230D36C
	ldr r0,[pool_0230D384]	; 0230D36E
	ldr r0,[r1,r0]	; 0230D370
	bl loc_0230D3B4	; 0230D372
	mov r0,#0x1	; 0230D376
loc_0230D378:
	add sp,#0x4	; 0230D378
	pop {r3}	; 0230D37A
	bx r3	; 0230D37C
	.byte 0xC0, 0x46	; 0230D380
pool_0230D380:
loc_0230D380:
	.word FirmwareWlWorkPointerSlot	; 0230D380
pool_0230D384:
loc_0230D384:
	.word 0x000002E8	; 0230D384
pool_0230D388:
loc_0230D388:
	.word 0x000001D6	; 0230D388
pool_0230D38C:
loc_0230D38C:
	.word 0x0000015C	; 0230D38C
pool_0230D390:
loc_0230D390:
	.word 0x000002EC	; 0230D390

; ===== function loc_0230D394 =====
loc_0230D394:
	bx pc	; 0230D394
	.byte 0xC0, 0x46	; 0230D398
.arm

; ===== function loc_0230D398 =====
loc_0230D398:
	ldr r12,[pool_0230D3A0]	; 0230D398
	bx r12	; 0230D39C
pool_0230D3A0:
loc_0230D3A0:
	.word loc_03802F38 + 1	; 0230D3A0
.thumb

; ===== function loc_0230D3A4 =====
loc_0230D3A4:
	bx pc	; 0230D3A4
	.byte 0xC0, 0x46	; 0230D3A8
.arm

; ===== function loc_0230D3A8 =====
loc_0230D3A8:
	ldr r12,[pool_0230D3B0]	; 0230D3A8
	bx r12	; 0230D3AC
pool_0230D3B0:
loc_0230D3B0:
	.word loc_03803F54 + 1	; 0230D3B0
.thumb

; ===== function loc_0230D3B4 =====
loc_0230D3B4:
	bx pc	; 0230D3B4
	.byte 0xC0, 0x46	; 0230D3B8
.arm

; ===== function loc_0230D3B8 =====
loc_0230D3B8:
	ldr r12,[pool_0230D3C0]	; 0230D3B8
	bx r12	; 0230D3BC
pool_0230D3C0:
loc_0230D3C0:
	.word loc_03802EF0 + 1	; 0230D3C0
	.byte 0x70, 0xB5, 0x05, 0x1C, 0x0C, 0x1C, 0x16, 0x1C, 0x0A, 0x48, 0x01, 0x68, 0x0A, 0x48, 0x08, 0x58	; 0230D3D4
	.byte 0xFF, 0xF7, 0xDE, 0xFF, 0x00, 0xF0, 0x32, 0xF8, 0x28, 0x1C, 0x21, 0x1C, 0x32, 0x1C, 0xFF, 0xF7	; 0230D3E4
	.byte 0xDF, 0xFF, 0x04, 0x48, 0x01, 0x68, 0x04, 0x48, 0x08, 0x58, 0xFF, 0xF7, 0xE1, 0xFF, 0x70, 0xBC	; 0230D3F4
	.byte 0x08, 0xBC, 0x18, 0x47, 0xF4, 0xFF, 0x80, 0x03, 0xE8, 0x02, 0x00, 0x00	; 0230D400
.thumb

; ===== function loc_0230D400 =====
loc_0230D400:
	push {r4,r5,r6,lr}	; 0230D400
	add r5,r1,#0x0	; 0230D402
	add r6,r2,#0x0	; 0230D404
	ldr r1,[pool_0230D438]	; 0230D406
	ldr r2,[r1,#0x0]	; 0230D408
	ldr r1,[pool_0230D43C]	; 0230D40A
	ldr r1,[r2,r1]	; 0230D40C
	cmp r1,#0x0	; 0230D40E
	beq loc_0230D430	; 0230D410
	add r4,r1,r0	; 0230D412
	sub r4,#0x2a	; 0230D414
	b loc_0230D42C	; 0230D416
loc_0230D418:
	add r0,r4,#0x0	; 0230D418
	bl loc_02305180	; 0230D41A
	add r4,r4,#0x1	; 0230D41E
	add r1,r0,#0x0	; 0230D420
	add r0,r6,#0x0	; 0230D422
	bl loc_023051A4	; 0230D424
	add r6,r6,#0x1	; 0230D428
	sub r5,r5,#0x1	; 0230D42A
loc_0230D42C:
	cmp r5,#0x0	; 0230D42C
	bne loc_0230D418	; 0230D42E
loc_0230D430:
	pop {r4,r5,r6}	; 0230D430
	pop {r3}	; 0230D432
	bx r3	; 0230D434
	.byte 0xC0, 0x46	; 0230D438
pool_0230D438:
loc_0230D438:
	.word FirmwareWlWorkPointerSlot	; 0230D438
pool_0230D43C:
loc_0230D43C:
	.word 0x000002EC	; 0230D43C

; ===== function loc_0230D440 =====
loc_0230D440:
	push {r4,r5,r6,lr}	; 0230D440
	sub sp,#0x8	; 0230D442
	add r6,sp,#0x0	; 0230D444
	mov r4,#0x1	; 0230D446
	mov r5,#0x20	; 0230D448
loc_0230D44A:
	add r0,r6,#0x0	; 0230D44A
	bl loc_0230D470	; 0230D44C
	ldr r0,[sp,#0x0]	; 0230D450
	and r0,r5	; 0230D452
	cmp r0,#0x0	; 0230D454
	beq loc_0230D45E	; 0230D456
	bl loc_0230D480	; 0230D458
	b loc_0230D44A	; 0230D45C
loc_0230D45E:
	ldr r0,[sp,#0x0]	; 0230D45E
	and r0,r4	; 0230D460
	cmp r0,#0x0	; 0230D462
	bne loc_0230D44A	; 0230D464
	add sp,#0x8	; 0230D466
	pop {r4,r5,r6}	; 0230D468
	pop {r3}	; 0230D46A
	bx r3	; 0230D46C
	.byte 0xC0, 0x46	; 0230D470

; ===== function loc_0230D470 =====
loc_0230D470:
	bx pc	; 0230D470
	.byte 0xC0, 0x46	; 0230D474
.arm

; ===== function loc_0230D474 =====
loc_0230D474:
	ldr r12,[pool_0230D47C]	; 0230D474
	bx r12	; 0230D478
pool_0230D47C:
loc_0230D47C:
	.word loc_03804050 + 1	; 0230D47C
.thumb

; ===== function loc_0230D480 =====
loc_0230D480:
	bx pc	; 0230D480
	.byte 0xC0, 0x46	; 0230D484
.arm

; ===== function loc_0230D484 =====
loc_0230D484:
	ldr r12,[pool_0230D48C]	; 0230D484
	bx r12	; 0230D488
pool_0230D48C:
loc_0230D48C:
	.word P2_Entry_03803C3C + 1	; 0230D48C
.thumb

; ===== function loc_0230D490 =====
loc_0230D490:
	push {r4,r5,r6,r7,lr}	; 0230D490
	sub sp,#0x4	; 0230D492
	add r7,r0,#0x0	; 0230D494
	ldr r0,[pool_0230D4F8]	; 0230D496
	ldr r1,[r0,#0x0]	; 0230D498
	ldr r0,[pool_0230D4FC]	; 0230D49A
	ldr r1,[r1,r0]	; 0230D49C
	ldrh r4,[r1,#0x2]	; 0230D49E
	cmp r4,#0xa4	; 0230D4A0
	bcc loc_0230D4AA	; 0230D4A2
	ldr r0,[pool_0230D500]	; 0230D4A4
	cmp r4,r0	; 0230D4A6
	bls loc_0230D4AE	; 0230D4A8
loc_0230D4AA:
	mov r0,#0x2	; 0230D4AA
	b loc_0230D4EE	; 0230D4AC
loc_0230D4AE:
	add r6,r1,#0x2	; 0230D4AE
	mov r5,#0x0	; 0230D4B0
	b loc_0230D4CC	; 0230D4B2
loc_0230D4B4:
	add r0,r6,#0x0	; 0230D4B4
	bl loc_02305180	; 0230D4B6
	add r6,r6,#0x1	; 0230D4BA
	lsl r0,r0,#0x18	; 0230D4BC
	lsr r0,r0,#0x18	; 0230D4BE
	lsl r1,r5,#0x10	; 0230D4C0
	lsr r1,r1,#0x10	; 0230D4C2
	bl loc_023050D0	; 0230D4C4
	add r5,r0,#0x0	; 0230D4C8
	sub r4,r4,#0x1	; 0230D4CA
loc_0230D4CC:
	cmp r4,#0x0	; 0230D4CC
	bne loc_0230D4B4	; 0230D4CE
	ldr r0,[pool_0230D4F8]	; 0230D4D0
	ldr r1,[r0,#0x0]	; 0230D4D2
	ldr r0,[pool_0230D4FC]	; 0230D4D4
	ldr r0,[r1,r0]	; 0230D4D6
	ldrh r1,[r0,#0x0]	; 0230D4D8
	cmp r7,#0x0	; 0230D4DA
	beq loc_0230D4E4	; 0230D4DC
	lsl r0,r5,#0x10	; 0230D4DE
	orr r0,r1	; 0230D4E0
	str r0,[r7,#0x0]	; 0230D4E2
loc_0230D4E4:
	cmp r5,r1	; 0230D4E4
	beq loc_0230D4EC	; 0230D4E6
	mov r0,#0x1	; 0230D4E8
	b loc_0230D4EE	; 0230D4EA
loc_0230D4EC:
	mov r0,#0x0	; 0230D4EC
loc_0230D4EE:
	add sp,#0x4	; 0230D4EE
	pop {r4,r5,r6,r7}	; 0230D4F0
	pop {r3}	; 0230D4F2
	bx r3	; 0230D4F4
	.byte 0xC0, 0x46	; 0230D4F8
pool_0230D4F8:
loc_0230D4F8:
	.word FirmwareWlWorkPointerSlot	; 0230D4F8
pool_0230D4FC:
loc_0230D4FC:
	.word 0x000002EC	; 0230D4FC
pool_0230D500:
loc_0230D500:
	.word 0x000001D6	; 0230D500
	.byte 0x11, 0x1F, 0x30, 0x02, 0xBD, 0x1F, 0x30, 0x02, 0xF9, 0x20, 0x30, 0x02, 0x39, 0x46, 0x30, 0x02	; 0230D514
	.byte 0x81, 0x46, 0x30, 0x02, 0x49, 0x48, 0x30, 0x02, 0xBD, 0x48, 0x30, 0x02, 0x8D, 0x21, 0x30, 0x02	; 0230D524
	.byte 0x45, 0x22, 0x30, 0x02, 0xC5, 0x23, 0x30, 0x02, 0xB5, 0x24, 0x30, 0x02, 0x31, 0x27, 0x30, 0x02	; 0230D534
	.byte 0xBD, 0x27, 0x30, 0x02, 0x11, 0x2D, 0x30, 0x02, 0x49, 0x2D, 0x30, 0x02, 0x91, 0x2E, 0x30, 0x02	; 0230D544
	.byte 0x21, 0x2F, 0x30, 0x02, 0xF5, 0x17, 0x30, 0x02, 0xF5, 0x17, 0x30, 0x02, 0xF5, 0x17, 0x30, 0x02	; 0230D554
	.byte 0xF5, 0x17, 0x30, 0x02, 0xF5, 0x17, 0x30, 0x02, 0xF5, 0x17, 0x30, 0x02, 0xF5, 0x17, 0x30, 0x02	; 0230D564
	.byte 0x61, 0x2F, 0x30, 0x02, 0x71, 0x30, 0x30, 0x02, 0xF5, 0x17, 0x30, 0x02, 0xF5, 0x17, 0x30, 0x02	; 0230D574
	.byte 0x15, 0x38, 0x30, 0x02, 0xD9, 0x30, 0x30, 0x02, 0x4D, 0x31, 0x30, 0x02, 0x7D, 0x32, 0x30, 0x02	; 0230D584
	.byte 0xDD, 0x32, 0x30, 0x02, 0xD1, 0x44, 0x30, 0x02, 0x41, 0x45, 0x30, 0x02, 0x35, 0x49, 0x30, 0x02	; 0230D594
	.byte 0x99, 0x49, 0x30, 0x02, 0xED, 0x37, 0x30, 0x02, 0xC9, 0x37, 0x30, 0x02, 0xA1, 0x37, 0x30, 0x02	; 0230D5A4
P4_Data_0230D5A4:
	.byte 0x01, 0x81, 0x30, 0x02, 0x61, 0x80, 0x30, 0x02, 0xB5, 0x7F, 0x30, 0x02, 0x15, 0x7F, 0x30, 0x02	; 0230D5A4
	.byte 0xE9, 0x7E, 0x30, 0x02, 0x2D, 0x7D, 0x30, 0x02, 0x49, 0xCF, 0x30, 0x02, 0x65, 0xB6, 0x30, 0x02	; 0230D5C4
	.byte 0xE9, 0xCD, 0x7F, 0x03, 0xBD, 0xB4, 0x30, 0x02, 0xED, 0x6F, 0x30, 0x02, 0x59, 0xB7, 0x7F, 0x03	; 0230D5D4
	.byte 0xA5, 0xB4, 0x7F, 0x03, 0xF5, 0x7C, 0x30, 0x02, 0x45, 0xCE, 0x7F, 0x03, 0x99, 0xCF, 0x7F, 0x03	; 0230D5E4
	.byte 0x89, 0xD2, 0x7F, 0x03, 0xA1, 0xB0, 0x30, 0x02, 0x81, 0xD1, 0x30, 0x02, 0x39, 0x78, 0x30, 0x02	; 0230D5F4
	.byte 0x41, 0xD3, 0x7F, 0x03, 0x79, 0x4E, 0x30, 0x02, 0xDD, 0x4D, 0x30, 0x02, 0x81, 0x4D, 0x30, 0x02	; 0230D604
	.byte 0x03, 0x00, 0x03, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x03, 0x09, 0xBF, 0x00	; 0230D614
	.byte 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x09, 0xBF, 0x00	; 0230D624
	.byte 0x00, 0x00, 0x00, 0x00	; 0230D624
P4_Data_0230D628:
	.byte 0x02, 0x00, 0x04, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x12, 0x00, 0x16, 0x00	; 0230D628
	.byte 0x18, 0x00, 0x24, 0x00, 0x30, 0x00, 0x48, 0x00, 0x60, 0x00, 0x6C, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230D644
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230D654
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230D664
	.byte 0x00, 0x00, 0x00, 0x00	; 0230D664
P4_Data_0230D668:
	.byte 0x00, 0x00, 0x01, 0xCC, 0x01, 0xD8, 0x00, 0x14, 0x01, 0xF0, 0x00, 0x3C	; 0230D668
	.byte 0x00, 0x28, 0x01, 0xE4, 0x01, 0xA0, 0x00, 0x6C, 0x00, 0x78, 0x01, 0xB4, 0x00, 0x50, 0x01, 0x9C	; 0230D684
	.byte 0x01, 0x88, 0x00, 0x44, 0x46, 0x01, 0x48, 0x01, 0x4A, 0x01, 0x4C, 0x01, 0x20, 0x01, 0x22, 0x01	; 0230D694
	.byte 0x54, 0x01, 0x44, 0x01, 0x32, 0x01, 0x32, 0x01, 0x40, 0x01, 0x42, 0x01, 0x38, 0x00, 0x24, 0x01	; 0230D6A4
	.byte 0x28, 0x01, 0x50, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230D6B4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230D6C4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230D6D4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230D6E4
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230D6F4
	.byte 0x00, 0x00, 0x00, 0x00	; 0230D6F4
P4_Data_0230D6F8:
	.byte 0x04, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x0A, 0x00, 0x00, 0x00	; 0230D6F8
	.byte 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0xFF, 0xFF, 0x54, 0x02, 0x00, 0x00, 0xB4, 0x00, 0xFF, 0xFF	; 0230D714
	.byte 0x80, 0x00, 0x00, 0x00, 0x8E, 0x00, 0x01, 0x00, 0x88, 0x00, 0x00, 0x00, 0x2A, 0x00, 0x00, 0x00	; 0230D724
	.byte 0x28, 0x00, 0x00, 0x00, 0xE8, 0x00, 0x00, 0x00, 0xEA, 0x00, 0x00, 0x00, 0xEE, 0x00, 0x01, 0x00	; 0230D734
	.byte 0xEC, 0x00, 0x03, 0x3F, 0xA2, 0x01, 0x01, 0x00, 0xA0, 0x01, 0x00, 0x00, 0x10, 0x01, 0x00, 0x08	; 0230D744
	.byte 0xBC, 0x00, 0x01, 0x00, 0xD4, 0x00, 0x03, 0x00, 0xD8, 0x00, 0x04, 0x00, 0xDA, 0x00, 0x02, 0x06	; 0230D754
	.byte 0x76, 0x00, 0x00, 0x00, 0x30, 0x01, 0x46, 0x01	; 0230D754
P4_Data_0230D75C:
	.byte 0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x01, 0x00	; 0230D75C
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x02, 0x00, 0x03, 0x00	; 0230D774
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x04, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D784
	.byte 0xFF, 0x00, 0x05, 0x00, 0xFF, 0x00, 0x06, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D794
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x07, 0x00	; 0230D7A4
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D7B4
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x08, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D7C4
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D7D4
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D7E4
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x09, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D7F4
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D804
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D814
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x0A, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D824
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x0B, 0x00	; 0230D834
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D844
	.byte 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00	; 0230D844
P4_Data_0230D84C:
	.byte 0x18, 0x00, 0xFF, 0xFF, 0x1A, 0x00, 0xFF, 0xFF	; 0230D84C
	.byte 0x1C, 0x00, 0xFF, 0xFF, 0x22, 0x01, 0xFF, 0xFF, 0x24, 0x01, 0xFF, 0xFF, 0x02, 0x00, 0x04, 0x00	; 0230D864
	.byte 0x05, 0x00, 0x06, 0x00, 0x07, 0x00, 0x1C, 0x00, 0x1D, 0x00, 0x1E, 0x00, 0x1F, 0x00, 0x20, 0x00	; 0230D874
	.byte 0x21, 0x00, 0x26, 0x00, 0x29, 0x00, 0x2C, 0x00, 0x2D, 0x00, 0x2E, 0x00, 0x2F, 0x00, 0x30, 0x00	; 0230D884
	.byte 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00, 0x65, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230D894
	.byte 0x00, 0x00, 0x09, 0x00, 0x0A, 0x00, 0x0B, 0x00, 0x0C, 0x00, 0x0D, 0x00, 0x0E, 0x00, 0x0F, 0x00	; 0230D8A4
	.byte 0x10, 0x00, 0x11, 0x00, 0x12, 0x00, 0x14, 0x00, 0x15, 0x00, 0x16, 0x00, 0x17, 0x00, 0x18, 0x00	; 0230D8B4
	.byte 0x19, 0x00, 0x1A, 0x00, 0x27, 0x00, 0x4D, 0x00, 0x5D, 0x00, 0x5E, 0x00, 0x5F, 0x00, 0x60, 0x00	; 0230D8C4
	.byte 0x61, 0x00, 0x64, 0x00, 0x66, 0x00, 0x00, 0x00, 0x18, 0x00, 0x02, 0x00, 0x01, 0x97, 0x30, 0x02	; 0230D8D4
	.byte 0x04, 0x00, 0x01, 0x00, 0xDD, 0x95, 0x30, 0x02, 0x0A, 0x00, 0x01, 0x00, 0xD1, 0x91, 0x30, 0x02	; 0230D8E4
	.byte 0x0C, 0x00, 0x01, 0x00, 0x85, 0x91, 0x30, 0x02, 0x01, 0x00, 0x01, 0x00, 0x4D, 0x91, 0x30, 0x02	; 0230D8F4
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230D904
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230D914
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xCD, 0x89, 0x30, 0x02	; 0230D924
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0xF9, 0x90, 0x30, 0x02	; 0230D934
	.byte 0x00, 0x00, 0x01, 0x00, 0xB5, 0x90, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x75, 0x90, 0x30, 0x02	; 0230D944
	.byte 0x00, 0x00, 0x01, 0x00, 0x49, 0x90, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x1D, 0x90, 0x30, 0x02	; 0230D954
	.byte 0x00, 0x00, 0x09, 0x00, 0xC9, 0x8F, 0x30, 0x02, 0x00, 0x00, 0x5C, 0x00, 0x79, 0x8F, 0x30, 0x02	; 0230D964
	.byte 0x00, 0x00, 0x02, 0x00, 0x5D, 0x8F, 0x30, 0x02, 0x04, 0x00, 0x01, 0x00, 0xAD, 0x8D, 0x30, 0x02	; 0230D974
	.byte 0x01, 0x00, 0x01, 0x00, 0x1D, 0x89, 0x30, 0x02, 0x03, 0x00, 0x01, 0x00, 0xA9, 0x88, 0x30, 0x02	; 0230D984
	.byte 0x1F, 0x00, 0x23, 0x00, 0xBD, 0x87, 0x30, 0x02, 0x22, 0x00, 0x05, 0x00, 0x51, 0x86, 0x30, 0x02	; 0230D994
	.byte 0x05, 0x00, 0x06, 0x00, 0xB5, 0x85, 0x30, 0x02, 0x04, 0x00, 0x04, 0x00, 0xCD, 0x84, 0x30, 0x02	; 0230D9A4
	.byte 0x05, 0x00, 0x03, 0x00, 0x25, 0x84, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230D9B4
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x17, 0x00, 0x01, 0x00, 0xED, 0x82, 0x30, 0x02	; 0230D9C4
	.byte 0x0C, 0x00, 0x12, 0x00, 0x4D, 0x82, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230D9D4
	.byte 0x00, 0x00, 0x04, 0x00, 0xA5, 0x89, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230D9E4
	.byte 0x00, 0x00, 0x03, 0x00, 0x7D, 0x89, 0x30, 0x02, 0x00, 0x00, 0x02, 0x00, 0x61, 0x89, 0x30, 0x02	; 0230D9F4
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x02, 0x00, 0x45, 0x89, 0x30, 0x02	; 0230DA04
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DA14
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DA24
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DA34
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DA44
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DA54
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DA64
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DA74
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x48, 0x00, 0x01, 0x00, 0x85, 0x8B, 0x30, 0x02	; 0230DA84
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DA94
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x01, 0x00, 0x01, 0x00, 0x45, 0x8B, 0x30, 0x02	; 0230DAA4
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DAB4
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DAC4
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DAD4
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DAE4
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DAF4
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DB04
	.byte 0x03, 0x00, 0x01, 0x00, 0x99, 0x8A, 0x30, 0x02, 0x01, 0x00, 0x01, 0x00, 0x51, 0x8A, 0x30, 0x02	; 0230DB14
	.byte 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02, 0x00, 0x00, 0x01, 0x00, 0x91, 0x78, 0x30, 0x02	; 0230DB24
	.byte 0x01, 0x00, 0x01, 0x00, 0x25, 0x8A, 0x30, 0x02, 0x32, 0x2E, 0x33, 0x37, 0x2E, 0x30, 0x30, 0x00	; 0230DB34
P4_Data_0230DB34:
	.byte 0x01, 0x00, 0x04, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00	; 0230DB34
P4_ImageEnd:
P4_BssStart:
.close

; P4 初始化器从组件末尾清零运行区；只有边界符号，不向文件填充 BSS。
; P4 initialization clears runtime storage after its image; BSS emits no file data.
.definelabel P4_BssBytes, 0x2424
.definelabel P4_BssEnd, P4_BssStart + P4_BssBytes
